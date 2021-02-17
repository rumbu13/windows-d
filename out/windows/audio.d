// Written in the D programming language.

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


alias APO_CONNECTION_BUFFER_TYPE = int;
enum : int
{
    APO_CONNECTION_BUFFER_TYPE_ALLOCATED = 0x00000000,
    APO_CONNECTION_BUFFER_TYPE_EXTERNAL  = 0x00000001,
    APO_CONNECTION_BUFFER_TYPE_DEPENDANT = 0x00000002,
}

///The APO_FLAG enumeration defines constants that are used as flags by an audio processing object (APO). This
///enumeration is used by the APO_REG_PROPERTIES structure to help describe the registration properties of an APO.
alias APO_FLAG = int;
enum : int
{
    ///Indicates that there are no flags enabled for this APO.
    APO_FLAG_NONE                       = 0x00000000,
    ///Indicates that this APO can perform in-place processing. This allows the processor to use a common buffer for
    ///input and output.
    APO_FLAG_INPLACE                    = 0x00000001,
    ///Indicates that the samples per frame for the input and output connections must match.
    APO_FLAG_SAMPLESPERFRAME_MUST_MATCH = 0x00000002,
    ///Indicates that the frames per second for the input and output connections must match.
    APO_FLAG_FRAMESPERSECOND_MUST_MATCH = 0x00000004,
    ///Indicates that bits per sample AND bytes per sample container for the input and output connections must match.
    APO_FLAG_BITSPERSAMPLE_MUST_MATCH   = 0x00000008,
    APO_FLAG_MIXER                      = 0x00000010,
    ///The value of this member is determined by the logical OR result of the three preceding members. In other words:
    ///APO_FLAG_DEFAULT = ( APO_FLAG_SAMPLESPERFRAME_MUST_MATCH | APO_FLAG_FRAMESPERSECOND_MUST_MATCH |
    ///APO_FLAG_BITSPERSAMPLE_MUST_MATCH ).
    APO_FLAG_DEFAULT                    = 0x0000000e,
}

alias AUDIO_FLOW_TYPE = int;
enum : int
{
    AUDIO_FLOW_PULL = 0x00000000,
    AUDIO_FLOW_PUSH = 0x00000001,
}

enum EAudioConstriction : int
{
    eAudioConstrictionOff   = 0x00000000,
    eAudioConstriction48_16 = 0x00000001,
    eAudioConstriction44_16 = 0x00000002,
    eAudioConstriction14_14 = 0x00000003,
    eAudioConstrictionMute  = 0x00000004,
}

alias DMUS_CLOCKTYPE = int;
enum : int
{
    DMUS_CLOCK_SYSTEM = 0x00000000,
    DMUS_CLOCK_WAVE   = 0x00000001,
}

///The KSPROPERTY_AUDIOEFFECTSDISCOVERY enumeration defines a constant that is used by the list of audio processing
///objects (APOs).
alias KSPROPERTY_AUDIOEFFECTSDISCOVERY = int;
enum : int
{
    ///Specifies the ID of the KSPROPERTY_AUDIOEFFECTSDISCOVERY_EFFECTSLIST property.
    KSPROPERTY_AUDIOEFFECTSDISCOVERY_EFFECTSLIST = 0x00000001,
}

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


///The UNCOMPRESSEDAUDIOFORMAT structure specifies the frame rate, channel mask, and other attributes of the
///uncompressed audio data format.
struct UNCOMPRESSEDAUDIOFORMAT
{
    ///Specifies the GUID of the data format type.
    GUID  guidFormatType;
    ///Specifies the number of samples per frame.
    uint  dwSamplesPerFrame;
    ///Specifies the number of bytes that make up a unit container of the sample.
    uint  dwBytesPerSampleContainer;
    ///Specifies the number of valid bits per sample.
    uint  dwValidBitsPerSample;
    ///Specifies the number of frames per second of streaming audio data.
    float fFramesPerSecond;
    ///Specifies the channel mask that is used by the uncompressed audio data.
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

///The APO_REG_PROPERTIES structure is used by IAudioProcessingObject::GetRegistrationProperties for returning the
///registration properties of an audio processing object (APO).
struct APO_REG_PROPERTIES
{
    ///The class ID for this APO.
    GUID        clsid;
    ///The flags for this APO. This parameter is an enumerated constant of type APO_FLAG.
    APO_FLAG    Flags;
    ///The friendly name of this APO. This is a string of characters with a max length of 256.
    ushort[256] szFriendlyName;
    ///The copyright info for this APO. This is a string of characters with a max length of 256.
    ushort[256] szCopyrightInfo;
    ///The major version number for this APO.
    uint        u32MajorVersion;
    ///The minor version number for this APO.
    uint        u32MinorVersion;
    ///The minimum number of input connections for this APO.
    uint        u32MinInputConnections;
    ///The maximum number of input connections for this APO.
    uint        u32MaxInputConnections;
    ///The minimum number of output connections for this APO.
    uint        u32MinOutputConnections;
    ///The maximum number of output connections for this APO.
    uint        u32MaxOutputConnections;
    ///The maximum number of instances of this APO.
    uint        u32MaxInstances;
    ///The number of interfaces for this APO.
    uint        u32NumAPOInterfaces;
    GUID[1]     iidAPOInterfaceList;
}

///The APOInitBaseStruct structure is the base initialization header that must precede other initialization data in
///IAudioProcessingObject::Initialize.
struct APOInitBaseStruct
{
    ///The total size of the structure in bytes.
    uint cbSize;
    ///The Class ID (CLSID) of the APO.
    GUID clsid;
}

///The APOInitSystemEffects structure gets passed to the system effects APO for initialization.
struct APOInitSystemEffects
{
    ///An APOInitBaseStruct structure.
    APOInitBaseStruct   APOInit;
    ///A pointer to an IPropertyStore object.
    IPropertyStore      pAPOEndpointProperties;
    ///A pointer to an IPropertyStore object.
    IPropertyStore      pAPOSystemEffectsProperties;
    ///Reserved for future use.
    void*               pReserved;
    ///A pointer to an IMMDeviceCollection object.
    IMMDeviceCollection pDeviceCollection;
}

///The APOInitSystemEffects2 structure was introduced with Windows 8.1, to make it possible to provide additional
///initialization context to the audio processing object (APO) for initialization.
struct APOInitSystemEffects2
{
    ///An APOInitBaseStruct structure.
    APOInitBaseStruct   APOInit;
    ///A pointer to an IPropertyStore object.
    IPropertyStore      pAPOEndpointProperties;
    ///A pointer to an IPropertyStore object.
    IPropertyStore      pAPOSystemEffectsProperties;
    ///Reserved for future use.
    void*               pReserved;
    ///A pointer to an IMMDeviceCollection object. The last item in the *pDeviceCollection* is always the
    ///[IMMDevice](../mmdeviceapi/nn-mmdeviceapi-immdevice.md) representing the audio endpoint.
    IMMDeviceCollection pDeviceCollection;
    ///Specifies the MMDevice that implements the DeviceTopology that includes the software connector for which the APO
    ///is initializing. The MMDevice is contained in <i>pDeviceCollection</i>.
    uint                nSoftwareIoDeviceInCollection;
    ///Specifies the index of a Software_IO connector in the DeviceTopology.
    uint                nSoftwareIoConnectorIndex;
    ///Specifies the processing mode for the audio graph.
    GUID                AudioProcessingMode;
    ///Indicates whether the audio system is initializing the APO for effects discovery only.
    BOOL                InitializeForDiscoveryOnly;
}

///The AudioFXExtensionParams structure is passed to the system effects ControlPanel Extension PropertyPage via
///IShellPropSheetExt::AddPages.
struct AudioFXExtensionParams
{
    ///Parameters for the Property Page extension.
    LPARAM         AddPageParam;
    ///The ID for the audio endpoint.
    const(wchar)*  pwstrEndpointID;
    ///An IPropertyStore object.
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

///<b>DMUS_VOICE_STATE</b> is not supported and may be altered or unavailable in the future.
struct DMUS_VOICE_STATE
{
    BOOL  bExists;
    ulong spPosition;
}

///The KSP_PINMODE structure specifies the pin property and the supported audio processing modes for a pin factory.
///KSP_PINMODE provides property data for KSPROPERTY_AUDIOEFFECTSDISCOVERY_EFFECTSLIST.
struct KSP_PINMODE
{
    ///The pin property of the pin factory.
    KSP_PIN PinProperty;
    ///The audio processing mode (or modes) supported by the pin factory.
    GUID    AudioProcessingMode;
}

///The <code>MDEVICECAPSEX</code> structure contains device capability information for Plug and Play (PnP) device
///drivers.
struct MDEVICECAPSEX
{
align (1):
    ///Specifies the size of the structure, in bytes.
    uint  cbSize;
    void* pCaps;
}

///The <code>MIDIOPENDESC</code> structure is a client-filled structure that provides information about how to open a
///MIDI device.
struct MIDIOPENDESC
{
align (1):
    ///Specifies the handle that the client uses to reference the device. This handle is assigned by WINMM. Use this
    ///handle when you notify the client with the DriverCallback function.
    ptrdiff_t hMidi;
    ///Specifies either the address of a callback function, a window handle, or a task handle, depending on the flags
    ///that are specified in the dwParam2 parameter of the MODM_OPEN message. If this field contains a handle, it is
    ///contained in the low-order word.
    size_t    dwCallback;
    ///Specifies a pointer to a DWORD that contains instance information for the client. This instance information is
    ///returned to the client whenever the driver notifies the client by using the <b>DriverCallback</b> function.
    size_t    dwInstance;
    ///Specifies a device node for the MIDI output device, if it is a Plug and Play (PnP) MIDI device.
    size_t    dnDevNode;
    ///Specifies the number of stream identifiers, if a stream is open.
    uint      cIds;
    ///Specifies an array of device identifiers. The number of identifiers is given by the <b>cIds</b> member.
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

///The IAudioMediaType interface exposes methods that allow an sAPO to get information that is used to negotiate with
///the audio engine for the appropriate audio data format.
@GUID("4E997F73-B71F-4798-873B-ED7DFCF15B4D")
interface IAudioMediaType : IUnknown
{
    ///The <code>IsCompressedFormat</code> method determines whether the audio data format is a compressed format.
    ///Params:
    ///    pfCompressed = Receives a Boolean value. The value is <b>TRUE</b> if the format is compressed or <b>FALSE</b> if the format
    ///                   is uncompressed.
    ///Returns:
    ///    The <code>IsCompressedFormat</code> method returns S_OK if the audio data format is compressed, otherwise it
    ///    returns an error code.
    ///    
    HRESULT IsCompressedFormat(int* pfCompressed);
    ///The <code>IsEqual</code> method compares two media types and determines whether they are identical.
    ///Params:
    ///    pIAudioType = Specifies a pointer to an IAudioMediaType interface of the media type to compare.
    ///    pdwFlags = Specifies a pointer to a DWORD variable that contains the bitwise OR result of zero or more flags. These
    ///               flags indicate the degree of similarity between the two media types. The following table shows the supported
    ///               flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> AUDIOMEDIATYPE_EQUAL_FORMAT_TYPES </td>
    ///               <td> The audio format types are the same. </td> </tr> <tr> <td> AUDIOMEDIATYPE_EQUAL_FORMAT_DATA </td> <td>
    ///               The format information matches, not including extra data beyond the base WAVEFORMATEX structure. </td> </tr>
    ///               <tr> <td> AUDIOMEDIATYPE_EQUAL_FORMAT_USER_DATA </td> <td> The extra data is identical, or neither media type
    ///               contains extra data. </td> </tr> </table>
    ///Returns:
    ///    The <code>IsEqual</code> method returns S_OK if it is successful, otherwise it returns one of the HRESULT
    ///    values shown in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One media type is invalid or both
    ///    media types are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The media types are not equal. Examine the <i>pdwFlags</i> parameter to determine how the media
    ///    types differ. </td> </tr> </table>
    ///    
    HRESULT IsEqual(IAudioMediaType pIAudioType, uint* pdwFlags);
    ///The <code>GetAudioFormat</code> method returns the WAVEFORMATEX structure for the audio data format.
    ///Returns:
    ///    The <code>GetAudioFormat</code> method returns a pointer to a WAVEFORMATEX structure.
    ///    
    WAVEFORMATEX* GetAudioFormat();
    ///The <code>IAudioMediaType::GetUncompressedAudioFormat</code> returns information about the audio data format.
    ///Params:
    ///    pUncompressedAudioFormat = Specifies a pointer to an UNCOMPRESSEDAUDIOFORMAT structure.
    ///Returns:
    ///    The <code>GetUncompressedAudioFormat</code> method returns S_OK if it is successful. Otherwise, it returns an
    ///    error code.
    ///    
    HRESULT GetUncompressedAudioFormat(UNCOMPRESSEDAUDIOFORMAT* pUncompressedAudioFormat);
}

///This interface can operate in real-time mode and its methods can be called form real-time processing threads.
@GUID("9E1D6A6D-DDBC-4E95-A4C7-AD64BA37846C")
interface IAudioProcessingObjectRT : IUnknown
{
    ///The APOProcess method causes the APO to make a processing pass.
    ///Params:
    ///    u32NumInputConnections = The number of input connections that are attached to this APO.
    ///    ppInputConnections = An array of input connection property structures. There is one structure per input connection.
    ///    u32NumOutputConnections = The number of output connections that are attached to this APO.
    ///    ppOutputConnections = An array of output connection property structures. There is one structure per output connection.
    ///Returns:
    ///    None <table> <tr> <th>Return code</th> <th>Description</th> </tr> </table>
    ///    
    void APOProcess(uint u32NumInputConnections, APO_CONNECTION_PROPERTY** ppInputConnections, 
                    uint u32NumOutputConnections, APO_CONNECTION_PROPERTY** ppOutputConnections);
    ///The <code>CalcInputFrames</code> method returns the number of input frames that an APO requires to generate a
    ///given number of output frames.
    ///Params:
    ///    u32OutputFrameCount = This is a count of the number of output frames.
    ///Returns:
    ///    The <code>CalcInputFrames</code> method returns the number of input frames that are required to generate the
    ///    given number of output frames. <table> <tr> <th>Return code</th> <th>Description</th> </tr> </table>
    ///    
    uint CalcInputFrames(uint u32OutputFrameCount);
    ///The <code>CalcOutputFrames</code> method returns the number of output frames that an APO requires for a given
    ///number of input frames.
    ///Params:
    ///    u32InputFrameCount = This is a count of the number of input frames.
    ///Returns:
    ///    The <code>CalcOutputFrames</code> method returns the number of output frames that an APO will generate for a
    ///    given number of input frames. <table> <tr> <th>Return code</th> <th>Description</th> </tr> </table>
    ///    
    uint CalcOutputFrames(uint u32InputFrameCount);
}

@GUID("7BA1DB8F-78AD-49CD-9591-F79D80A17C81")
interface IAudioProcessingObjectVBR : IUnknown
{
    HRESULT CalcMaxInputFrames(uint u32MaxOutputFrameCount, uint* pu32InputFrameCount);
    HRESULT CalcMaxOutputFrames(uint u32MaxInputFrameCount, uint* pu32OutputFrameCount);
}

///The IAudioProcessingObjectConfiguration interface is used to configure the APO. This interface uses its methods to
///lock and unlock the APO for processing.
@GUID("0E5ED805-ABA6-49C3-8F9A-2B8C889C4FA8")
interface IAudioProcessingObjectConfiguration : IUnknown
{
    ///The <code>LockForProcess</code> method is used to verify that the APO is locked and ready to process data.
    ///Params:
    ///    u32NumInputConnections = Number of input connections that are attached to this APO.
    ///    ppInputConnections = Connection descriptor for each input connection that is attached to this APO.
    ///    u32NumOutputConnections = Number of output connections that are attached to this APO.
    ///    ppOutputConnections = Connection descriptor for each output connection that is attached to this APO.
    ///Returns:
    ///    The <code>LockForProcess</code> method returns a value of S_OK if the call is completed successfully. At this
    ///    stage, the APO is locked and is ready to process data. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer was
    ///    passed to function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>APOERR_INVALID_CONNECITON_FORMAT</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid connection format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>APOERR_NUM_CONNECTIONS_INVALID</b></dt> </dl> </td> <td width="60%"> Number of input or output
    ///    connections not valid on this APO. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>APOERR_APO_LOCKED</b></dt>
    ///    </dl> </td> <td width="60%"> APO is already locked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other
    ///    HRESULTS</b></dt> </dl> </td> <td width="60%"> These failures will be tracked by the audio engine. </td>
    ///    </tr> </table>
    ///    
    HRESULT LockForProcess(uint u32NumInputConnections, APO_CONNECTION_DESCRIPTOR** ppInputConnections, 
                           uint u32NumOutputConnections, APO_CONNECTION_DESCRIPTOR** ppOutputConnections);
    ///The <code>UnlockForProcess</code> method releases the lock that was imposed on the APO by the LockForProcess
    ///method.
    ///Returns:
    ///    The <code>UnlockForProcess</code> method returns a value of S_OK if the call completed successfully. If the
    ///    APO was already unlocked when the call was made, the method returns a value of APOERR_ALREADY_UNLOCKED.
    ///    
    HRESULT UnlockForProcess();
}

///System Effects Audio Processing Objects (sAPOs) are typically used in or called from real-time process threads.
@GUID("FD7F2B29-24D0-4B5C-B177-592C39F9CA10")
interface IAudioProcessingObject : IUnknown
{
    ///The Reset method resets the APO to its original state. This method does not cause any changes in the connection
    ///objects that are attached to the input or the output of the APO.
    ///Returns:
    ///    The <code>Reset</code> method returns a value of S_OK when the call is completed successfully.
    ///    
    HRESULT Reset();
    ///The GetLatency method returns the latency for this APO. Latency is the amount of time it takes a frame to
    ///traverse the processing pass of an APO.
    ///Params:
    ///    pTime = A pointer to an MFTIME structure that will receive the number of units of delay that this APO introduces.
    ///            Each unit of delay represents 100 nanoseconds.
    ///Returns:
    ///    <code>GetLatency</code> returns a value of S_OK if the call was successful. Otherwise, it returns an error
    ///    code of E_POINTER to indicate that an invalid pointer was passed to the function.
    ///    
    HRESULT GetLatency(long* pTime);
    ///GetRegistrationProperties returns the registration properties of the audio processing object (APO).
    ///Params:
    ///    ppRegProps = The registration properties of the APO. This parameter is of type APO_REG_PROPERTIES.
    ///Returns:
    ///    <code>GetRegistrationProperties</code> returns a value of S_OK if the call was successful. Otherwise, it
    ///    returns an error code of E_POINTER to indicate that an invalid pointer was passed to the function.
    ///    
    HRESULT GetRegistrationProperties(APO_REG_PROPERTIES** ppRegProps);
    ///The Initialize method initializes the APO and supports data of variable length.
    ///Params:
    ///    cbDataSize = This is the size, in bytes, of the initialization data.
    ///    pbyData = This is initialization data that is specific to this APO.
    ///Returns:
    ///    The <code>Initialize</code> method returns a value of S_OK if the call was successful. Otherwise, this method
    ///    returns one of the following error codes: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer passed to the
    ///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>APOERR_ALREADY_INITIALIZED</b></dt> </dl>
    ///    </td> <td width="60%"> APO already initialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other
    ///    HRESULTS</b></dt> </dl> </td> <td width="60%"> These additional error conditions are tracked by the audio
    ///    engine. </td> </tr> </table>
    ///    
    HRESULT Initialize(uint cbDataSize, char* pbyData);
    ///This method negotiates with the Windows Vista audio engine to establish a data format for the stream of audio
    ///data.
    ///Params:
    ///    pOppositeFormat = A pointer to an IAudioMediaType interface. This parameter is used to indicate the output format of the data.
    ///                      The value of pOppositeFormat must be set to <b>NULL</b> to indicate that the output format can be any type.
    ///    pRequestedInputFormat = A pointer to an IAudioMediaType interface. This parameter is used to indicate the input format that is to be
    ///                            verified.
    ///    ppSupportedInputFormat = This parameter indicates the supported format that is closest to the format to be verified.
    ///Returns:
    ///    If the call completed successfully, the ppSupportedInputFormat parameter returns a pRequestedInputFormat
    ///    pointer and the IsInputFormatSupported method returns a value of S_OK. Otherwise, this method returns one of
    ///    the following error codes: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The format of the input/output format pair is not
    ///    supported. ppSupportedInputFormat returns a suggested new format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>APOERR_FORMAT_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The format to be verified is not
    ///    supported. The value of ppSupportedInputFormat does not change. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer that is passed to the method. The
    ///    value of ppSupportedInputFormat does not change. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other HRESULT
    ///    values</b></dt> </dl> </td> <td width="60%"> These additional error conditions are tracked by the audio
    ///    engine. </td> </tr> </table>
    ///    
    HRESULT IsInputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedInputFormat, 
                                   IAudioMediaType* ppSupportedInputFormat);
    ///The <code>IsOutputFormatSupported</code> method is used to verify that a specific output format is supported.
    ///Params:
    ///    pOppositeFormat = A pointer to an IAudioMediaType interface. This parameter indicates the output format. This parameter must be
    ///                      set to <b>NULL</b> to indicate that the output format can be any type.
    ///    pRequestedOutputFormat = A pointer to an <b>IAudioMediaType</b> interface. This parameter indicates the output format that is to be
    ///                             verified.
    ///    ppSupportedOutputFormat = This parameter indicates the supported output format that is closest to the format to be verified.
    ///Returns:
    ///    If the call completes successfully, the ppSupportedOutputFormat parameter returns a pRequestedOutputFormat
    ///    pointer and the IsOutputFormatSupported method returns a value of S_OK. Otherwise, this method returns one of
    ///    the following error codes: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The format of Input/output format pair is not
    ///    supported. The ppSupportedOutPutFormat parameter returns a suggested new format. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>APOERR_FORMAT_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The format is not
    ///    supported. The value of ppSupportedOutputFormat does not change. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> An invalid pointer was passed to the function. The
    ///    value of ppSupportedOutputFormat does not change. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other HRESULT
    ///    values</b></dt> </dl> </td> <td width="60%"> These additional error conditions are tracked by the audio
    ///    engine. </td> </tr> </table>
    ///    
    HRESULT IsOutputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedOutputFormat, 
                                    IAudioMediaType* ppSupportedOutputFormat);
    ///GetInputChannelCount returns the input channel count (samples-per-frame) for this APO.
    ///Params:
    ///    pu32ChannelCount = The input channel count.
    ///Returns:
    ///    <code>GetInputChannelCount</code> returns a value of S_OK if the call was successful.
    ///    
    HRESULT GetInputChannelCount(uint* pu32ChannelCount);
}

@GUID("98F37DAC-D0B6-49F5-896A-AA4D169A4C48")
interface IAudioDeviceModulesClient : IUnknown
{
    HRESULT SetAudioDeviceModulesManager(IUnknown pAudioDeviceModulesManager);
}

///The IAudioSystemEffects interface uses the basic methods that are inherited from IUnknown, and must implement an
///Initialize method.
@GUID("5FA00F27-ADD6-499A-8A9D-6B98521FA75B")
interface IAudioSystemEffects : IUnknown
{
}

///The <b>IAudioSystemEffects2</b> interface was introduced with Windows 8.1 for retrieving information about the
///processing objects in a given mode.
@GUID("BAFE99D2-7436-44CE-9E0E-4D89AFBFFF56")
interface IAudioSystemEffects2 : IAudioSystemEffects
{
    ///The GetEffectsList method is used for retrieving the list of audio processing effects that are currently active,
    ///and stores an event to be signaled if the list changes.
    ///Params:
    ///    ppEffectsIds = Pointer to the list of GUIDs that represent audio processing effects. The caller is responsible for freeing
    ///                   this memory by calling CoTaskMemFree.
    ///    pcEffects = A count of the audio processing effects in the list.
    ///    Event = The HANDLE of the event that will be signaled if the list changes.
    ///Returns:
    ///    The <b>GetEffectsList</b> method returns S_OK, If the method call is successful. If there are no effects in
    ///    the list, the function still succeeds, <i>ppEffectsIds</i> returns a NULL pointer, and <i>pcEffects</i>
    ///    returns a count of 0.
    ///    
    HRESULT GetEffectsList(GUID** ppEffectsIds, uint* pcEffects, HANDLE Event);
}

///The IAudioSystemEffectsCustomFormats interface is supported in Windows Vista and later versions of Windows.
@GUID("B1176E34-BB7F-4F05-BEBD-1B18A534E097")
interface IAudioSystemEffectsCustomFormats : IUnknown
{
    ///The <code>GetFormatCount</code> method retrieves the number of custom formats supported by the system effects
    ///audio processing object (sAPO).
    ///Params:
    ///    pcFormats = Specifies a pointer to an unsigned integer. The unsigned integer represents the number of formats supported
    ///                by the sAPO.
    ///Returns:
    ///    The <code>GetFormatCount</code> method returns S_OK when the call is successful. Otherwise, it returns
    ///    E_POINTER to indicate that an invalid pointer was passed to the function.
    ///    
    HRESULT GetFormatCount(uint* pcFormats);
    ///The <code>GetFormat</code> method retrieves an IAudioMediaType representation of a custom format.
    ///Params:
    ///    nFormat = Specifies the index of a supported format. This parameter can be any value in the range from zero to one less
    ///              than the return value of GetFormatCount. In other words, any value in the range from zero to GetFormatCount(
    ///              ) - 1.
    ///    ppFormat = Specifies a pointer to a pointer to an <b>IAudioMediaType</b> interface. It is the responsibility of the
    ///               caller to release the <b>IAudioMediaType</b> interface to which the <i>ppFormat</i> parameter points.
    ///Returns:
    ///    The <code>GetFormat</code> method returns S_OK when the call is successful. Otherwise, it returns one of the
    ///    error codes shown in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer passed to
    ///    function </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Return buffer cannot be allocated </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> nFormat is out of range </td> </tr> </table>
    ///    
    HRESULT GetFormat(uint nFormat, IAudioMediaType* ppFormat);
    ///The <code>GetFormatRepresentation</code> method retrieves a string representation of the custom format so that it
    ///can be displayed on a user-interface.
    ///Params:
    ///    nFormat = Specifies the index of a supported format. This parameter can be any value in the range from zero to one less
    ///              than the return value of GetFormatCount. In other words, any value in the range from zero to GetFormatCount(
    ///              ) - 1.
    ///    ppwstrFormatRep = Specifies the address of the buffer that receives a NULL-terminated Unicode string that describes the custom
    ///                      format.
    ///Returns:
    ///    The <code>GetFormatRepresentation</code> method returns S_OK when the call is successful. Otherwise, it
    ///    returns one of the error codes shown in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Invalid pointer passed to function </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> Return buffer cannot be allocated </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> nFormat is out of range </td> </tr> </table>
    ///    
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

///The IDirectMusicSynth interface is used by DirectMusic to communicate with user-mode synthesizers.
interface IDirectMusicSynth : IUnknown
{
    ///The <code>Open</code> method opens a DirectMusic synthesizer "port".
    ///Params:
    ///    pPortParams = Pointer to a DMUS_PORTPARAMS structure (described in the Microsoft Windows SDK documentation) specifying a
    ///                  set of options for opening the DirectMusic "port". The structure contains setup parameters for the port,
    ///                  including sample rate, stereo mode, and number of voices. If this parameter is set to <b>NULL</b>, default
    ///                  settings are used.
    ///Returns:
    ///    <code>Open</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate error
    ///    code. The following table shows some of the possible return status codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Indicates a bad pointer was passed in <i>pPortParams</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_ALREADYOPEN</b></dt> </dl> </td> <td width="60%"> Indicates that the port was already opened.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_NOSYNTHSINK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates that no sink is available for output. </td> </tr> </table>
    ///    
    HRESULT Open(DMUS_PORTPARAMS8* pPortParams);
    ///The <code>Close</code> method closes a DirectMusic "port", which is a DirectMusic term for a device that sends or
    ///receives music data.
    ///Returns:
    ///    <code>Close</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_ALREADYCLOSED</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates that the port was not open. </td> </tr> </table>
    ///    
    HRESULT Close();
    ///The <code>SetNumChannelGroups</code> method instructs the synthesizer to set its number of channel groups to a
    ///new value.
    ///Params:
    ///    dwGroups = Specifies the number of channel groups requested.
    ///Returns:
    ///    <code>SetNumChannelGroups</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth is not open
    ///    or not properly configured. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the method is unable to allocate the channel groups. </td> </tr> </table>
    ///    
    HRESULT SetNumChannelGroups(uint dwGroups);
    ///The <code>Download</code> method downloads a wave or instrument definition to the synthesizer.
    ///Params:
    ///    phDownload = Output pointer for the download handle. This parameter points to a caller-allocated variable into which the
    ///                 method writes a handle identifying the download data. The caller uses this handle later to unload the data.
    ///    pvData = Pointer to a continuous memory segment containing download data. For an overview of the data format, see the
    ///             description of low-level DLS in the DirectMusic section of the Microsoft Windows SDK documentation.
    ///    pbFree = Output pointer for a status value indicating whether the memory for the download data can be freed. This
    ///             parameter points to a caller-allocated variable into which the method writes a Boolean value indicating
    ///             whether the caller can free the storage pointed to by <i>pvData</i>. If <b>TRUE</b>, the application can
    ///             safely free the memory after the return. If <b>FALSE</b>, the caller must keep the memory pointed to by
    ///             <i>pvData</i> allocated until it is unloaded.
    ///Returns:
    ///    <code>Download</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that one of the pointers is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Indicates that the method is unable to download the data.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%">
    ///    Indicates that the synth is not open or not properly configured. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_NOTMONO</b></dt> </dl> </td> <td width="60%"> Indicates that the wave chunk has more than one
    ///    interleaved channel. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_BADARTICULATION</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates a bad articulation chunk or link. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_BADINSTRUMENT</b></dt> </dl> </td> <td width="60%"> Indicates a bad instrument chunk or link.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_BADWAVELINK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates a bad link to the wave download data. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_NOARTICULATION</b></dt> </dl> </td> <td width="60%"> Indicates that the region in instrument
    ///    has neither global nor local articulation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_NOTPCM</b></dt> </dl> </td> <td width="60%"> Indicates that the wave data is not PCM. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_BADWAVE</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///    the wave header is corrupt. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_BADOFFSETTABLE</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the offset table contains errors. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>DMUS_E_UNKNOWNDOWNLOAD</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    download data is neither instrument nor wave. </td> </tr> </table>
    ///    
    HRESULT Download(ptrdiff_t* phDownload, void* pvData, int* pbFree);
    ///The <code>Unload</code> method unloads a DLS resource (waveform or articulation data for a MIDI instrument) that
    ///was previously downloaded by a call to IDirectMusicSynth::Download.
    ///Params:
    ///    hDownload = Handle to the DLS resource, which was obtained from a previous call to the <b>IDirectMusicSynth::Download</b>
    ///                method. If the <i>lpFreeHandle</i> parameter below is non-<b>NULL</b>, the synthesizer passes this handle as
    ///                the first parameter to the <i>lpFreeHandle</i> callback routine.
    ///    lpFreeHandle = Pointer to a callback routine that will be called when the memory containing the DLS resource is no longer in
    ///                   use. If the original call to <b>IDirectMusicSynth::Download</b> returned <b>FALSE</b> in <i>pbFree</i>, this
    ///                   means that the synthesizer continued accessing the caller-allocated memory in the download chunk after the
    ///                   return from <b>Download</b>. If so, the synthesizer notifies the caller as soon as the memory can be freed,
    ///                   but this might occur later than the return from <code>Unload</code> because the DLS resource might be
    ///                   currently in use. The callback function takes two handles as call parameters. The first of these two handles
    ///                   is the <i>hDownload</i> parameter (see above), and the second is the <i>hUserData</i> parameter (see below).
    ///    hUserData = Pointer to user data, which is passed as the second parameter to the <i>lpFreeHandle</i> callback function
    ///                above. The meaning of this value is known only to the caller, but it is typically a pointer to context
    ///                information describing the state of the memory that is to be freed.
    ///Returns:
    ///    <code>Unload</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the method is unable to unload data (<i>hDownload</i> probably invalid). </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%">
    ///    Indicates that the synth is not open or not properly configured. </td> </tr> </table>
    ///    
    HRESULT Unload(HANDLE hDownload, HRESULT*********** lpFreeHandle, HANDLE hUserData);
    ///The <code>PlayBuffer</code> method downloads a stream of MIDI messages to the synthesizer.
    ///Params:
    ///    rt = Specifies the start time of the buffer. This value is specified in REFERENCE_TIME units, relative to the
    ///         master clock, which was previously set with a call to IDirectMusicSynth::SetMasterClock. Also, this value
    ///         should be after the time returned by the clock in IDirectMusicSynth::GetLatencyClock.
    ///    pbBuffer = Pointer to a memory buffer containing the time-stamped MIDI messages that the <b>IDirectMusicBuffer</b>
    ///               object generates
    ///    cbBuffer = Specifies the size of the buffer in bytes.
    ///Returns:
    ///    <code>PlayBuffer</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates a bad buffer pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth is not open
    ///    or not properly configured. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_NOSYNTHSINK</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates that the <b>IDirectMusicSynthSink</b> object was not connected. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>DMUS_E_SYNTHINACTIVE</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///    the method was called when the synth is inactive, which is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Indicates that the method is unable to queue the
    ///    messages. </td> </tr> </table>
    ///    
    HRESULT PlayBuffer(long rt, ubyte* pbBuffer, uint cbBuffer);
    ///The <code>GetRunningStats</code> method retrieves current information about the state of the synthesizer so that
    ///an application can tell how the synth is performing.
    ///Params:
    ///    pStats = Pointer to a DMUS_SYNTHSTATS structure (described in Microsoft Windows SDK documentation). The method writes
    ///             the synth's statistics into this structure.
    ///Returns:
    ///    <code>GetRunningStats</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> Indicates that the method is unable to get the stats. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Indicates a bad <i>pStats</i> pointer. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    synthesizer has not implemented this method (so expect the worst!). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth is not open
    ///    or not properly configured. </td> </tr> </table>
    ///    
    HRESULT GetRunningStats(DMUS_SYNTHSTATS* pStats);
    ///The <code>GetPortCaps</code> method retrieves the capabilities of a DirectMusic "port", which is a DirectMusic
    ///term for a device that sends or receives music data.
    ///Params:
    ///    pCaps = Pointer to a DMUS_PORTCAPS structure (described in the Microsoft Windows SDK documentation). The method
    ///            writes the capabilities of the DirectMusic "port" into this structure.
    ///Returns:
    ///    <code>GetPortCaps</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates a bad <i>pCaps</i> pointer. </td> </tr> </table>
    ///    
    HRESULT GetPortCaps(DMUS_PORTCAPS* pCaps);
    ///The <code>SetMasterClock</code> method provides the synthesizer with a master time source, which the synthesizer
    ///requires to synchronize itself with the rest of DirectMusic.
    ///Params:
    ///    pClock = Pointer to the master <b>IReferenceClock</b> (defined in Microsoft Windows SDK documentation) object, which
    ///             is used by all devices in the current instance of DirectMusic.
    ///Returns:
    ///    <code>SetMasterClock</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates a bad interface pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth is not open
    ///    or not properly configured. </td> </tr> </table>
    ///    
    HRESULT SetMasterClock(IReferenceClock pClock);
    ///The <code>GetLatencyClock</code> method retrieves a reference to the <b>IReferenceClock</b> interface (described
    ///in the Microsoft Windows SDK documentation) of the reference-clock object that tracks the current mix time.
    ///Params:
    ///    ppClock = Output pointer for the latency clock. This parameter points to a caller-allocated pointer variable into which
    ///              the method writes a pointer to the latency-clock object's <b>IReferenceClock</b> interface. Through this
    ///              interface, the synthesizer is able to get the current mix time. Specify a valid, non-NULL pointer value for
    ///              this parameter.
    ///Returns:
    ///    <code>GetLatencyClock</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> Indicates that the method was unable to access the latency clock. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Indicates that the <i>ppClock</i>
    ///    pointer is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_NOSYNTHSINK</b></dt> </dl> </td>
    ///    <td width="60%"> Indicates that the <b>IDirectMusicSynthSink</b> object was not connected. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///    the synth is not open or is not properly configured. </td> </tr> </table>
    ///    
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    ///The <code>Activate</code> method enables or disables the audio device under program control.
    ///Params:
    ///    fEnable = Specifies whether to enable or disable the audio device. If <b>TRUE</b>, the method enables the device. If
    ///              <b>FALSE</b>, the method disables it.
    ///Returns:
    ///    <code>Activate</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates audio device is already inactive. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Indicates that the request failed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that not enough memory
    ///    is available to load the device. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth is not opened
    ///    or not properly configured. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_NOSYNTHSINK</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates that the <b>IDirectMusicSynthSink</b> object was not connected. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>DMUS_E_SYNTHACTIVE</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    synth is already active. </td> </tr> </table>
    ///    
    HRESULT Activate(BOOL fEnable);
    ///The <code>SetSynthSink</code> method establishes the connection of the synth to the wave sink.
    ///Params:
    ///    pSynthSink = Pointer to the synth sink. This parameter either points to the IDirectMusicSynthSink sink object to connect
    ///                 to the synth, or is <b>NULL</b> to disconnect the synth from its current synth sink.
    ///Returns:
    ///    <code>SetSynthSink</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates that a bad pointer was passed in <i>pSynthSink</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Indicates that the method failed
    ///    because it was unable to connect to the <b>IDirectMusicSynthSink</b> object. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that not enough memory
    ///    is available to establish the connection. </td> </tr> </table>
    ///    
    HRESULT SetSynthSink(IDirectMusicSynthSink pSynthSink);
    ///The <code>Render</code> method is called by the synth sink to render to a buffer in the audio stream.
    ///Params:
    ///    pBuffer = Pointer to the buffer to write to
    ///    dwLength = Specifies the length of the buffer. The buffer length is expressed in samples, not bytes. The size in bytes
    ///               of the buffer can vary, depending on the buffer's format, which the synth sets in response to an
    ///               IDirectMusicSynth::Activate command.
    ///    llPosition = Specifies the position in the audio stream. The position is expressed in samples, not bytes. The caller
    ///                 should always increment this value by <i>dwLength</i> after each call.
    ///Returns:
    ///    <code>Render</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the method failed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Indicates a bad buffer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    synth is not open or not properly configured. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHINACTIVE</b></dt> </dl> </td> <td width="60%"> Indicates that the method is not valid when
    ///    synth is inactive. </td> </tr> </table>
    ///    
    HRESULT Render(short* pBuffer, uint dwLength, long llPosition);
    ///The <code>SetChannelPriority</code> method sets the priority of a MIDI channel.
    ///Params:
    ///    dwChannelGroup = Specifies the group the channel is in. This value must be one or greater.
    ///    dwChannel = Specifies a channel in the channel group. This parameter is an index in the range 0 to 15.
    ///    dwPriority = Specifies the priority ranking of the channel. For a list of the ranking values that are defined for this
    ///                 parameter, see the <b>IDirectMusicPort::GetChannelPriority</b> reference page in the Microsoft Windows SDK
    ///                 documentation.
    ///Returns:
    ///    <code>SetChannelPriority</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code.
    ///    
    HRESULT SetChannelPriority(uint dwChannelGroup, uint dwChannel, uint dwPriority);
    ///The <code>GetChannelPriority</code> method outputs the priority of a MIDI channel.
    ///Params:
    ///    dwChannelGroup = Specifies the channel group that the channel belongs to. This parameter must be one or greater.
    ///    dwChannel = Specifies the index of the channel in the channel group. This is a value in the range 0 to 15.
    ///    pdwPriority = Output pointer for the priority ranking. This parameter points to a caller-allocated variable into which the
    ///                  method writes the priority ranking value. For a list of the priority values that are defined for this
    ///                  parameter, see the <b>IDirectMusicPort::GetChannelPriority</b> reference page in the Microsoft Windows SDK
    ///                  documentation.
    ///Returns:
    ///    <code>GetChannelPriority</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code.
    ///    
    HRESULT GetChannelPriority(uint dwChannelGroup, uint dwChannel, uint* pdwPriority);
    ///The <code>GetFormat</code> method retrieves information about the wave format.
    ///Params:
    ///    pWaveFormatEx = Pointer to a caller-allocated WAVEFORMATEX structure into which the method writes information about the
    ///                    format. This value can be <b>NULL</b>. For more information, see the following Remarks section.
    ///    pdwWaveFormatExSize = Pointer to a caller-allocated DWORD variable specifying the size in bytes of the structure that
    ///                          <i>pWaveFormatEx</i> points to. For more information, see the following Remarks section.
    ///Returns:
    ///    <code>GetFormat</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that one of the pointers is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth is not open
    ///    or is not properly configured. </td> </tr> </table>
    ///    
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatEx, uint* pdwWaveFormatExSize);
    ///The <code>GetAppend</code> method outputs the number of additional wave samples that the DirectMusic "port" needs
    ///to have appended to the end of a download buffer.
    ///Params:
    ///    pdwAppend = Output pointer for the number of samples to append. This parameter points to a caller-allocated variable into
    ///                which the method writes a count specifying the number of appended samples for which memory is required. The
    ///                required memory in bytes can be calculated from the wave format.
    ///Returns:
    ///    <code>GetAppend</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the pointer buffer is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Indicates that the method is not implemented. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAppend(uint* pdwAppend);
}

///IDirectMusicSynth8is unsupported and may be altered or unavailable in the future.
interface IDirectMusicSynth8 : IDirectMusicSynth
{
    ///<b>PlayVoice</b> is unsupported and may be altered or unavailable in the future.
    ///Params:
    ///    rt = 
    ///    dwVoiceId = 
    ///    dwChannelGroup = 
    ///    dwChannel = 
    ///    dwDLId = 
    ///    prPitch = PREL not defined here.
    ///    vrVolume = VREL not defined here.
    ///    stVoiceStart = 
    ///    stLoopStart = 
    ///    stLoopEnd = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PlayVoice(long rt, uint dwVoiceId, uint dwChannelGroup, uint dwChannel, uint dwDLId, int prPitch, 
                      int vrVolume, ulong stVoiceStart, ulong stLoopStart, ulong stLoopEnd);
    ///<b>StopVoice</b> is unsupported and may be altered or unavailable in the future
    ///Params:
    ///    rt = 
    ///    dwVoiceId = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StopVoice(long rt, uint dwVoiceId);
    ///<b>GetVoiceState</b> is unsupported and may be altered or unavailable in the future.
    ///Params:
    ///    dwVoice = 
    ///    cbVoice = 
    ///    dwVoiceState = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetVoiceState(uint* dwVoice, uint cbVoice, DMUS_VOICE_STATE* dwVoiceState);
    ///<b>Refresh</b> is unsupported and may be altered or unavailable in the future.
    ///Params:
    ///    dwDownloadID = 
    ///    dwFlags = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh(uint dwDownloadID, uint dwFlags);
    ///<b>AssignChannelToBuses</b> is unsupported and may be altered or unavailable in the future.
    ///Params:
    ///    dwChannelGroup = 
    ///    dwChannel = 
    ///    pdwBuses = 
    ///    cBuses = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AssignChannelToBuses(uint dwChannelGroup, uint dwChannel, uint* pdwBuses, uint cBuses);
}

///The IDirectMusicSynthSink interface is now largely obsolete and is supported only by versions of DirectMusic before
///DirectX 8.
interface IDirectMusicSynthSink : IUnknown
{
    ///The <code>Init</code> method initializes the synth-sink object.
    ///Params:
    ///    pSynth = Pointer to the synth object that the synth-sink object is to connect to. This parameter is a valid, non-NULL
    ///             pointer to a IDirectMusicSynth object.
    ///Returns:
    ///    <code>Init</code> returns S_OK if the call is successful. Otherwise, the method returns an appropriate error
    ///    code.
    ///    
    HRESULT Init(IDirectMusicSynth pSynth);
    ///The <code>SetMasterClock</code> method provides the synth sink with a master time source, which is required for
    ///synchronization with the rest of DirectMusic.
    ///Params:
    ///    pClock = Specifies the master clock to synchronize to. This parameter is a pointer to the master-clock object's
    ///             <b>IReferenceClock</b> interface (described in the Microsoft Windows SDK documentation).
    ///Returns:
    ///    <code>SetMasterClock</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> Indicates that the method is unable to accept clock. </td> </tr> </table>
    ///    
    HRESULT SetMasterClock(IReferenceClock pClock);
    ///The <code>GetLatencyClock</code> method retrieves the latency clock, which measures the progress of the output
    ///audio stream.
    ///Params:
    ///    ppClock = Output pointer for the latency clock. This parameter points to a caller-allocated pointer variable into which
    ///              the method writes a pointer to the latency-clock object's <b>IReferenceClock</b> interface (described in the
    ///              Microsoft Windows SDK documentation).
    ///Returns:
    ///    <code>GetLatencyClock</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> Indicates that the method is unable to access latency clock. </td> </tr> </table>
    ///    
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    ///The <code>Activate</code> method activates or deactivates the synthesizer sink.
    ///Params:
    ///    fEnable = Specifies whether to activate the synth sink. If <b>TRUE</b>, the method activates the synth sink. If
    ///              <b>FALSE</b>, it deactivates it.
    ///Returns:
    ///    <code>Activate</code> returns S_OK if the call was successful. Otherwise, the method returns an appropriate
    ///    error code. The following table shows some of the possible return status codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the method is unable to activate or deactivate the synth sink. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///    the synth is not set or not properly configured. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHACTIVE</b></dt> </dl> </td> <td width="60%"> Indicates that the sink is already active.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_DSOUND_NOT_SET</b></dt> </dl> </td> <td width="60%">
    ///    Indicates that <b>SetDirectSound</b> hasn't been called successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_NO_MASTER_CLOCK</b></dt> </dl> </td> <td width="60%"> Indicates that <b>SetMasterClock</b>
    ///    hasn't been called successfully. </td> </tr> </table>
    ///    
    HRESULT Activate(BOOL fEnable);
    ///The <code>SampleToRefTime</code> method converts a sample time to a reference time.
    ///Params:
    ///    llSampleTime = Specifies the sample time. For more information, see the following Remarks section.
    ///    prfTime = Output pointer for the reference time. This parameter points to a caller-allocated REFERENCE_TIME variable
    ///              into which the method writes the reference time.
    ///Returns:
    ///    <code>SampleToRefTime</code> returns S_OK if the call is successful. Otherwise, the method returns an
    ///    appropriate error code.
    ///    
    HRESULT SampleToRefTime(long llSampleTime, long* prfTime);
    ///The <code>RefTimeToSample</code> method converts a reference time to a sample time.
    ///Params:
    ///    rfTime = Specifies the reference time. Reference time is measured in 100-nanosecond units.
    ///    pllSampleTime = Output pointer for the sample time. This parameter points to a caller-allocated LONGLONG variable into which
    ///                    the method writes the sample time.
    ///Returns:
    ///    <code>RefTimeToSample</code> returns S_OK if the call is successful. Otherwise, the method returns an
    ///    appropriate error code.
    ///    
    HRESULT RefTimeToSample(long rfTime, long* pllSampleTime);
    ///The <code>SetDirectSound</code> method connects the synthesizer sink with an existing DirectSound object and a
    ///DirectSound buffer.
    ///Params:
    ///    pDirectSound = Pointer to an <b>IDirectSound</b> object that the sink is to be associated with. This parameter is set to a
    ///                   valid, non-<b>NULL</b> pointer value.
    ///    pDirectSoundBuffer = Pointer to the <b>IDirectSoundBuffer</b> object that the sink is to be associated with. This parameter can be
    ///                         <b>NULL</b>. For more information, see the following Remarks section.
    ///Returns:
    ///    <code>SetDirectSound</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth not set.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMUS_E_SYNTHACTIVE</b></dt> </dl> </td> <td width="60%">
    ///    Indicates that the sink is active. </td> </tr> </table>
    ///    
    HRESULT SetDirectSound(IDirectSound pDirectSound, IDirectSoundBuffer pDirectSoundBuffer);
    ///The <code>GetDesiredBufferSize</code> method retrieves the synthesizer's preferred buffer size, expressed in
    ///samples.
    ///Params:
    ///    pdwBufferSizeInSamples = Output pointer for the buffer size. This parameter points to a caller-allocated variable into which the
    ///                             method writes the desired buffer length, expressed in samples.
    ///Returns:
    ///    <code>GetDesiredBufferSize</code> returns S_OK if the call was successful. Otherwise, the method returns an
    ///    appropriate error code. The following table shows some of the possible return status codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DMUS_E_SYNTHNOTCONFIGURED</b></dt> </dl> </td> <td width="60%"> Indicates that the synth is not set.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDesiredBufferSize(uint* pdwBufferSizeInSamples);
}

///This interface exposes methods used to enumerate and manipulate property values.
@GUID("886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99")
interface IPropertyStore : IUnknown
{
    ///This method returns a count of the number of properties that are attached to the file.
    ///Params:
    ///    cProps = A pointer to a value that indicates the property count.
    ///Returns:
    ///    The <code>IpropertyStore::GetCount</code> method returns a value of S_OK when the call is successful, even if
    ///    the file has no properties attached. Any other code returned is an error code.
    ///    
    HRESULT GetCount(uint* cProps);
    ///Gets a property key from the property array of an item.
    ///Params:
    ///    iProp = The index of the property key in the array of PROPERTYKEY structures. This is a zero-based index.
    ///    pkey = TBD
    ///    pKey = A pointer to a PROPERTYKEY structure and it can be used in subsequent calls to IPropertyStore::GetValue and
    ///           IPropertyStore::SetValue.
    ///Returns:
    ///    The <code>IPropertyStore::GetAt</code> method returns a value of S_OK if successful. Otherwise, any other
    ///    code it returns must be considered to be an error code.
    ///    
    HRESULT GetAt(uint iProp, PROPERTYKEY* pkey);
    ///This method retrieves the data for a specific property.
    ///Params:
    ///    key = TBD
    ///    pv = After the <code>IPropertyStore::GetValue</code> method returns successfully, this parameter points to a
    ///         PROPVARIANT structure that contains data about the property.
    ///    Key = A reference to the PROPERTYKEY structure that is retrieved through IPropertyStore::GetAt. The PROPERTYKEY
    ///          structure also contains a globally unique identifier (GUID) for the property.
    ///Returns:
    ///    Returns S_OK or INPLACE_S_TRUNCATED if successful, or an error value otherwise. INPLACE_S_TRUNCATED is
    ///    returned to indicate that the returned PROPVARIANT was converted into a more canonical form. For example,
    ///    this would be done to trim leading or trailing spaces from a string value. You must use the SUCCEEDED macro
    ///    to check the return value, which treats INPLACE_S_TRUNCATED as a success code. The SUCCEEDED macro is defined
    ///    in the Winerror.h file.
    ///    
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* pv);
    ///This method sets a property value or replaces or removes an existing value.
    ///Params:
    ///    key = TBD
    ///    propvar = TBD
    ///    Key = A reference to the PROPERTYKEY structure that is retrieved through IPropertyStore::GetAt. This structure
    ///          contains a global unique identifier (GUID) for the property.
    ///Returns:
    ///    The <code>IPropertyStore::SetValue</code> method can return any one of the following: <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The property change was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>INPLACE_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> The value was set but truncated. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>STG_E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This is an error
    ///    code. The property store was read-only so the method was not able to set the value. </td> </tr> </table>
    ///    
    HRESULT SetValue(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar);
    ///After a change has been made, this method saves the changes.
    ///Returns:
    ///    The <code>IPropertyStore::Commit</code> method returns any one of the following: <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> All of the property changes were successfully written to the stream or path. This includes the
    ///    case where no changes were pending when the method was called and nothing was written. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>STG_E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The stream or file is
    ///    read-only; the method was not able to set the value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Some or all of the changes could not be written to the
    ///    file. Another, more explanatory error can be used in place of E_FAIL. </td> </tr> </table>
    ///    
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
