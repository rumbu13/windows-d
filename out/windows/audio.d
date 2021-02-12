module windows.audio;

public import system;
public import windows.com;
public import windows.coreaudio;
public import windows.directshow;
public import windows.multimedia;
public import windows.remotedesktopservices;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowspropertiessystem;

extern(Windows):

struct UNCOMPRESSEDAUDIOFORMAT
{
    Guid guidFormatType;
    uint dwSamplesPerFrame;
    uint dwBytesPerSampleContainer;
    uint dwValidBitsPerSample;
    float fFramesPerSecond;
    uint dwChannelMask;
}

const GUID IID_IAudioMediaType = {0x4E997F73, 0xB71F, 0x4798, [0x87, 0x3B, 0xED, 0x7D, 0xFC, 0xF1, 0x5B, 0x4D]};
@GUID(0x4E997F73, 0xB71F, 0x4798, [0x87, 0x3B, 0xED, 0x7D, 0xFC, 0xF1, 0x5B, 0x4D]);
interface IAudioMediaType : IUnknown
{
    HRESULT IsCompressedFormat(int* pfCompressed);
    HRESULT IsEqual(IAudioMediaType pIAudioType, uint* pdwFlags);
    WAVEFORMATEX* GetAudioFormat();
    HRESULT GetUncompressedAudioFormat(UNCOMPRESSEDAUDIOFORMAT* pUncompressedAudioFormat);
}

enum APO_CONNECTION_BUFFER_TYPE
{
    APO_CONNECTION_BUFFER_TYPE_ALLOCATED = 0,
    APO_CONNECTION_BUFFER_TYPE_EXTERNAL = 1,
    APO_CONNECTION_BUFFER_TYPE_DEPENDANT = 2,
}

struct APO_CONNECTION_DESCRIPTOR
{
    APO_CONNECTION_BUFFER_TYPE Type;
    uint pBuffer;
    uint u32MaxFrameCount;
    IAudioMediaType pFormat;
    uint u32Signature;
}

enum APO_FLAG
{
    APO_FLAG_NONE = 0,
    APO_FLAG_INPLACE = 1,
    APO_FLAG_SAMPLESPERFRAME_MUST_MATCH = 2,
    APO_FLAG_FRAMESPERSECOND_MUST_MATCH = 4,
    APO_FLAG_BITSPERSAMPLE_MUST_MATCH = 8,
    APO_FLAG_MIXER = 16,
    APO_FLAG_DEFAULT = 14,
}

struct APO_REG_PROPERTIES
{
    Guid clsid;
    APO_FLAG Flags;
    ushort szFriendlyName;
    ushort szCopyrightInfo;
    uint u32MajorVersion;
    uint u32MinorVersion;
    uint u32MinInputConnections;
    uint u32MaxInputConnections;
    uint u32MinOutputConnections;
    uint u32MaxOutputConnections;
    uint u32MaxInstances;
    uint u32NumAPOInterfaces;
    Guid iidAPOInterfaceList;
}

struct APOInitBaseStruct
{
    uint cbSize;
    Guid clsid;
}

enum AUDIO_FLOW_TYPE
{
    AUDIO_FLOW_PULL = 0,
    AUDIO_FLOW_PUSH = 1,
}

enum EAudioConstriction
{
    eAudioConstrictionOff = 0,
    eAudioConstriction48_16 = 1,
    eAudioConstriction44_16 = 2,
    eAudioConstriction14_14 = 3,
    eAudioConstrictionMute = 4,
}

const GUID IID_IAudioProcessingObjectRT = {0x9E1D6A6D, 0xDDBC, 0x4E95, [0xA4, 0xC7, 0xAD, 0x64, 0xBA, 0x37, 0x84, 0x6C]};
@GUID(0x9E1D6A6D, 0xDDBC, 0x4E95, [0xA4, 0xC7, 0xAD, 0x64, 0xBA, 0x37, 0x84, 0x6C]);
interface IAudioProcessingObjectRT : IUnknown
{
    void APOProcess(uint u32NumInputConnections, APO_CONNECTION_PROPERTY** ppInputConnections, uint u32NumOutputConnections, APO_CONNECTION_PROPERTY** ppOutputConnections);
    uint CalcInputFrames(uint u32OutputFrameCount);
    uint CalcOutputFrames(uint u32InputFrameCount);
}

const GUID IID_IAudioProcessingObjectVBR = {0x7BA1DB8F, 0x78AD, 0x49CD, [0x95, 0x91, 0xF7, 0x9D, 0x80, 0xA1, 0x7C, 0x81]};
@GUID(0x7BA1DB8F, 0x78AD, 0x49CD, [0x95, 0x91, 0xF7, 0x9D, 0x80, 0xA1, 0x7C, 0x81]);
interface IAudioProcessingObjectVBR : IUnknown
{
    HRESULT CalcMaxInputFrames(uint u32MaxOutputFrameCount, uint* pu32InputFrameCount);
    HRESULT CalcMaxOutputFrames(uint u32MaxInputFrameCount, uint* pu32OutputFrameCount);
}

const GUID IID_IAudioProcessingObjectConfiguration = {0x0E5ED805, 0xABA6, 0x49C3, [0x8F, 0x9A, 0x2B, 0x8C, 0x88, 0x9C, 0x4F, 0xA8]};
@GUID(0x0E5ED805, 0xABA6, 0x49C3, [0x8F, 0x9A, 0x2B, 0x8C, 0x88, 0x9C, 0x4F, 0xA8]);
interface IAudioProcessingObjectConfiguration : IUnknown
{
    HRESULT LockForProcess(uint u32NumInputConnections, APO_CONNECTION_DESCRIPTOR** ppInputConnections, uint u32NumOutputConnections, APO_CONNECTION_DESCRIPTOR** ppOutputConnections);
    HRESULT UnlockForProcess();
}

const GUID IID_IAudioProcessingObject = {0xFD7F2B29, 0x24D0, 0x4B5C, [0xB1, 0x77, 0x59, 0x2C, 0x39, 0xF9, 0xCA, 0x10]};
@GUID(0xFD7F2B29, 0x24D0, 0x4B5C, [0xB1, 0x77, 0x59, 0x2C, 0x39, 0xF9, 0xCA, 0x10]);
interface IAudioProcessingObject : IUnknown
{
    HRESULT Reset();
    HRESULT GetLatency(long* pTime);
    HRESULT GetRegistrationProperties(APO_REG_PROPERTIES** ppRegProps);
    HRESULT Initialize(uint cbDataSize, char* pbyData);
    HRESULT IsInputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedInputFormat, IAudioMediaType* ppSupportedInputFormat);
    HRESULT IsOutputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedOutputFormat, IAudioMediaType* ppSupportedOutputFormat);
    HRESULT GetInputChannelCount(uint* pu32ChannelCount);
}

const GUID IID_IAudioDeviceModulesClient = {0x98F37DAC, 0xD0B6, 0x49F5, [0x89, 0x6A, 0xAA, 0x4D, 0x16, 0x9A, 0x4C, 0x48]};
@GUID(0x98F37DAC, 0xD0B6, 0x49F5, [0x89, 0x6A, 0xAA, 0x4D, 0x16, 0x9A, 0x4C, 0x48]);
interface IAudioDeviceModulesClient : IUnknown
{
    HRESULT SetAudioDeviceModulesManager(IUnknown pAudioDeviceModulesManager);
}

alias FNAPONOTIFICATIONCALLBACK = extern(Windows) HRESULT function(APO_REG_PROPERTIES* pProperties, void* pvRefData);
const GUID IID_IAudioSystemEffects = {0x5FA00F27, 0xADD6, 0x499A, [0x8A, 0x9D, 0x6B, 0x98, 0x52, 0x1F, 0xA7, 0x5B]};
@GUID(0x5FA00F27, 0xADD6, 0x499A, [0x8A, 0x9D, 0x6B, 0x98, 0x52, 0x1F, 0xA7, 0x5B]);
interface IAudioSystemEffects : IUnknown
{
}

const GUID IID_IAudioSystemEffects2 = {0xBAFE99D2, 0x7436, 0x44CE, [0x9E, 0x0E, 0x4D, 0x89, 0xAF, 0xBF, 0xFF, 0x56]};
@GUID(0xBAFE99D2, 0x7436, 0x44CE, [0x9E, 0x0E, 0x4D, 0x89, 0xAF, 0xBF, 0xFF, 0x56]);
interface IAudioSystemEffects2 : IAudioSystemEffects
{
    HRESULT GetEffectsList(Guid** ppEffectsIds, uint* pcEffects, HANDLE Event);
}

const GUID IID_IAudioSystemEffectsCustomFormats = {0xB1176E34, 0xBB7F, 0x4F05, [0xBE, 0xBD, 0x1B, 0x18, 0xA5, 0x34, 0xE0, 0x97]};
@GUID(0xB1176E34, 0xBB7F, 0x4F05, [0xBE, 0xBD, 0x1B, 0x18, 0xA5, 0x34, 0xE0, 0x97]);
interface IAudioSystemEffectsCustomFormats : IUnknown
{
    HRESULT GetFormatCount(uint* pcFormats);
    HRESULT GetFormat(uint nFormat, IAudioMediaType* ppFormat);
    HRESULT GetFormatRepresentation(uint nFormat, ushort** ppwstrFormatRep);
}

struct APOInitSystemEffects
{
    APOInitBaseStruct APOInit;
    IPropertyStore pAPOEndpointProperties;
    IPropertyStore pAPOSystemEffectsProperties;
    void* pReserved;
    IMMDeviceCollection pDeviceCollection;
}

struct APOInitSystemEffects2
{
    APOInitBaseStruct APOInit;
    IPropertyStore pAPOEndpointProperties;
    IPropertyStore pAPOSystemEffectsProperties;
    void* pReserved;
    IMMDeviceCollection pDeviceCollection;
    uint nSoftwareIoDeviceInCollection;
    uint nSoftwareIoConnectorIndex;
    Guid AudioProcessingMode;
    BOOL InitializeForDiscoveryOnly;
}

struct AudioFXExtensionParams
{
    LPARAM AddPageParam;
    const(wchar)* pwstrEndpointID;
    IPropertyStore pFxProperties;
}

struct DLSID
{
    uint ulData1;
    ushort usData2;
    ushort usData3;
    ubyte abData4;
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
    int lScale;
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
    ushort fusOptions;
    ushort usKeyGroup;
}

struct INSTHEADER
{
    uint cRegions;
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
    uint ulChannel;
    uint ulTableIndex;
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
    uint cbSize;
    ushort usUnityNote;
    short sFineTune;
    int lAttenuation;
    uint fulOptions;
    uint cSampleLoops;
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
    uint ulOffsetTable;
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
    ushort fusOptions;
    ushort usKeyGroup;
    uint ulRegionArtIdx;
    uint ulNextRegionIdx;
    uint ulFirstExtCkIdx;
    WAVELINK WaveLink;
    _rwsmp WSMP;
    _rloop WLOOP;
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
    uint cbSize;
    uint ulNextExtCkIdx;
    uint ExtCkID;
    ubyte byExtCk;
}

struct DMUS_COPYRIGHT
{
    uint cbSize;
    ubyte byCopyright;
}

struct DMUS_WAVEDATA
{
    uint cbSize;
    ubyte byData;
}

struct DMUS_WAVE
{
    uint ulFirstExtCkIdx;
    uint ulCopyrightIdx;
    uint ulWaveDataIdx;
    WAVEFORMATEX WaveformatEx;
}

struct DMUS_NOTERANGE
{
    uint dwLowNote;
    uint dwHighNote;
}

struct DMUS_WAVEARTDL
{
    uint ulDownloadIdIdx;
    uint ulBus;
    uint ulBuffers;
    uint ulMasterDLId;
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
    uint dwSize;
    uint dwFlags;
    Guid guidDSFXClass;
    uint dwReserved1;
    uint dwReserved2;
}

struct DSCEFFECTDESC
{
    uint dwSize;
    uint dwFlags;
    Guid guidDSCFXClass;
    Guid guidDSCFXInstance;
    uint dwReserved1;
    uint dwReserved2;
}

struct DSBUFFERDESC
{
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwReserved;
    WAVEFORMATEX* lpwfxFormat;
    Guid guid3DAlgorithm;
}

struct DSBUFFERDESC1
{
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwReserved;
    WAVEFORMATEX* lpwfxFormat;
}

struct DS3DBUFFER
{
    uint dwSize;
    D3DVECTOR vPosition;
    D3DVECTOR vVelocity;
    uint dwInsideConeAngle;
    uint dwOutsideConeAngle;
    D3DVECTOR vConeOrientation;
    int lConeOutsideVolume;
    float flMinDistance;
    float flMaxDistance;
    uint dwMode;
}

struct DS3DLISTENER
{
    uint dwSize;
    D3DVECTOR vPosition;
    D3DVECTOR vVelocity;
    D3DVECTOR vOrientFront;
    D3DVECTOR vOrientTop;
    float flDistanceFactor;
    float flRolloffFactor;
    float flDopplerFactor;
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
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwReserved;
    WAVEFORMATEX* lpwfxFormat;
}

struct DSCBUFFERDESC
{
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwReserved;
    WAVEFORMATEX* lpwfxFormat;
    uint dwFXCount;
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
    uint dwOffset;
    HANDLE hEventNotify;
}

alias LPDSENUMCALLBACKA = extern(Windows) BOOL function(Guid* param0, const(char)* param1, const(char)* param2, void* param3);
alias LPDSENUMCALLBACKW = extern(Windows) BOOL function(Guid* param0, const(wchar)* param1, const(wchar)* param2, void* param3);
interface IDirectSound : IUnknown
{
    HRESULT CreateSoundBuffer(DSBUFFERDESC* pcDSBufferDesc, IDirectSoundBuffer* ppDSBuffer, IUnknown pUnkOuter);
    HRESULT GetCaps(DSCAPS* pDSCaps);
    HRESULT DuplicateSoundBuffer(IDirectSoundBuffer pDSBufferOriginal, IDirectSoundBuffer* ppDSBufferDuplicate);
    HRESULT SetCooperativeLevel(HWND hwnd, uint dwLevel);
    HRESULT Compact();
    HRESULT GetSpeakerConfig(uint* pdwSpeakerConfig);
    HRESULT SetSpeakerConfig(uint dwSpeakerConfig);
    HRESULT Initialize(Guid* pcGuidDevice);
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
    HRESULT Lock(uint dwOffset, uint dwBytes, void** ppvAudioPtr1, uint* pdwAudioBytes1, void** ppvAudioPtr2, uint* pdwAudioBytes2, uint dwFlags);
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
    HRESULT GetObjectInPath(const(Guid)* rguidObject, uint dwIndex, const(Guid)* rguidInterface, void** ppObject);
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
    HRESULT SetOrientation(float xFront, float yFront, float zFront, float xTop, float yTop, float zTop, uint dwApply);
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
    HRESULT CreateCaptureBuffer(DSCBUFFERDESC* pcDSCBufferDesc, IDirectSoundCaptureBuffer* ppDSCBuffer, IUnknown pUnkOuter);
    HRESULT GetCaps(DSCCAPS* pDSCCaps);
    HRESULT Initialize(Guid* pcGuidDevice);
}

interface IDirectSoundCaptureBuffer : IUnknown
{
    HRESULT GetCaps(DSCBCAPS* pDSCBCaps);
    HRESULT GetCurrentPosition(uint* pdwCapturePosition, uint* pdwReadPosition);
    HRESULT GetFormat(char* pwfxFormat, uint dwSizeAllocated, uint* pdwSizeWritten);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Initialize(IDirectSoundCapture pDirectSoundCapture, DSCBUFFERDESC* pcDSCBufferDesc);
    HRESULT Lock(uint dwOffset, uint dwBytes, void** ppvAudioPtr1, uint* pdwAudioBytes1, void** ppvAudioPtr2, uint* pdwAudioBytes2, uint dwFlags);
    HRESULT Start(uint dwFlags);
    HRESULT Stop();
    HRESULT Unlock(char* pvAudioPtr1, uint dwAudioBytes1, char* pvAudioPtr2, uint dwAudioBytes2);
}

interface IDirectSoundCaptureBuffer8 : IDirectSoundCaptureBuffer
{
    HRESULT GetObjectInPath(const(Guid)* rguidObject, uint dwIndex, const(Guid)* rguidInterface, void** ppObject);
    HRESULT GetFXStatus(uint dwEffectsCount, char* pdwFXStatus);
}

interface IDirectSoundNotify : IUnknown
{
    HRESULT SetNotificationPositions(uint dwPositionNotifies, char* pcPositionNotifies);
}

struct DSFXGargle
{
    uint dwRateHz;
    uint dwWaveShape;
}

interface IDirectSoundFXGargle : IUnknown
{
    HRESULT SetAllParameters(DSFXGargle* pcDsFxGargle);
    HRESULT GetAllParameters(DSFXGargle* pDsFxGargle);
}

struct DSFXChorus
{
    float fWetDryMix;
    float fDepth;
    float fFeedback;
    float fFrequency;
    int lWaveform;
    float fDelay;
    int lPhase;
}

interface IDirectSoundFXChorus : IUnknown
{
    HRESULT SetAllParameters(DSFXChorus* pcDsFxChorus);
    HRESULT GetAllParameters(DSFXChorus* pDsFxChorus);
}

struct DSFXFlanger
{
    float fWetDryMix;
    float fDepth;
    float fFeedback;
    float fFrequency;
    int lWaveform;
    float fDelay;
    int lPhase;
}

interface IDirectSoundFXFlanger : IUnknown
{
    HRESULT SetAllParameters(DSFXFlanger* pcDsFxFlanger);
    HRESULT GetAllParameters(DSFXFlanger* pDsFxFlanger);
}

struct DSFXEcho
{
    float fWetDryMix;
    float fFeedback;
    float fLeftDelay;
    float fRightDelay;
    int lPanDelay;
}

interface IDirectSoundFXEcho : IUnknown
{
    HRESULT SetAllParameters(DSFXEcho* pcDsFxEcho);
    HRESULT GetAllParameters(DSFXEcho* pDsFxEcho);
}

struct DSFXDistortion
{
    float fGain;
    float fEdge;
    float fPostEQCenterFrequency;
    float fPostEQBandwidth;
    float fPreLowpassCutoff;
}

interface IDirectSoundFXDistortion : IUnknown
{
    HRESULT SetAllParameters(DSFXDistortion* pcDsFxDistortion);
    HRESULT GetAllParameters(DSFXDistortion* pDsFxDistortion);
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

interface IDirectSoundFXCompressor : IUnknown
{
    HRESULT SetAllParameters(DSFXCompressor* pcDsFxCompressor);
    HRESULT GetAllParameters(DSFXCompressor* pDsFxCompressor);
}

struct DSFXParamEq
{
    float fCenter;
    float fBandwidth;
    float fGain;
}

interface IDirectSoundFXParamEq : IUnknown
{
    HRESULT SetAllParameters(DSFXParamEq* pcDsFxParamEq);
    HRESULT GetAllParameters(DSFXParamEq* pDsFxParamEq);
}

struct DSFXI3DL2Reverb
{
    int lRoom;
    int lRoomHF;
    float flRoomRolloffFactor;
    float flDecayTime;
    float flDecayHFRatio;
    int lReflections;
    float flReflectionsDelay;
    int lReverb;
    float flReverbDelay;
    float flDiffusion;
    float flDensity;
    float flHFReference;
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

struct DSFXWavesReverb
{
    float fInGain;
    float fReverbMix;
    float fReverbTime;
    float fHighFreqRTRatio;
}

interface IDirectSoundFXWavesReverb : IUnknown
{
    HRESULT SetAllParameters(DSFXWavesReverb* pcDsFxWavesReverb);
    HRESULT GetAllParameters(DSFXWavesReverb* pDsFxWavesReverb);
}

struct DSCFXAec
{
    BOOL fEnable;
    BOOL fNoiseFill;
    uint dwMode;
}

interface IDirectSoundCaptureFXAec : IUnknown
{
    HRESULT SetAllParameters(DSCFXAec* pDscFxAec);
    HRESULT GetAllParameters(DSCFXAec* pDscFxAec);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Reset();
}

struct DSCFXNoiseSuppress
{
    BOOL fEnable;
}

interface IDirectSoundCaptureFXNoiseSuppress : IUnknown
{
    HRESULT SetAllParameters(DSCFXNoiseSuppress* pcDscFxNoiseSuppress);
    HRESULT GetAllParameters(DSCFXNoiseSuppress* pDscFxNoiseSuppress);
    HRESULT Reset();
}

interface IDirectSoundFullDuplex : IUnknown
{
    HRESULT Initialize(Guid* pCaptureGuid, Guid* pRenderGuid, DSCBUFFERDESC* lpDscBufferDesc, DSBUFFERDESC* lpDsBufferDesc, HWND hWnd, uint dwLevel, IDirectSoundCaptureBuffer8* lplpDirectSoundCaptureBuffer8, IDirectSoundBuffer8* lplpDirectSoundBuffer8);
}

struct DMUS_EVENTHEADER
{
    uint cbEvent;
    uint dwChannelGroup;
    long rtDelta;
    uint dwFlags;
}

struct DMUS_BUFFERDESC
{
    uint dwSize;
    uint dwFlags;
    Guid guidBufferFormat;
    uint cbBuffer;
}

struct DMUS_PORTCAPS
{
    uint dwSize;
    uint dwFlags;
    Guid guidPort;
    uint dwClass;
    uint dwType;
    uint dwMemorySize;
    uint dwMaxChannelGroups;
    uint dwMaxVoices;
    uint dwMaxAudioChannels;
    uint dwEffectFlags;
    ushort wszDescription;
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
    int lPeakVolume;
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
    int lPeakVolume;
    uint dwSynthMemUse;
}

struct DMUS_WAVES_REVERB_PARAMS
{
    float fInGain;
    float fReverbMix;
    float fReverbTime;
    float fHighFreqRTRatio;
}

enum DMUS_CLOCKTYPE
{
    DMUS_CLOCK_SYSTEM = 0,
    DMUS_CLOCK_WAVE = 1,
}

struct DMUS_CLOCKINFO7
{
    uint dwSize;
    DMUS_CLOCKTYPE ctType;
    Guid guidClock;
    ushort wszDescription;
}

struct DMUS_CLOCKINFO8
{
    uint dwSize;
    DMUS_CLOCKTYPE ctType;
    Guid guidClock;
    ushort wszDescription;
    uint dwFlags;
}

interface IDirectMusic : IUnknown
{
    HRESULT EnumPort(uint dwIndex, DMUS_PORTCAPS* pPortCaps);
    HRESULT CreateMusicBuffer(DMUS_BUFFERDESC* pBufferDesc, IDirectMusicBuffer* ppBuffer, IUnknown pUnkOuter);
    HRESULT CreatePort(const(Guid)* rclsidPort, DMUS_PORTPARAMS8* pPortParams, IDirectMusicPort* ppPort, IUnknown pUnkOuter);
    HRESULT EnumMasterClock(uint dwIndex, DMUS_CLOCKINFO8* lpClockInfo);
    HRESULT GetMasterClock(Guid* pguidClock, IReferenceClock* ppReferenceClock);
    HRESULT SetMasterClock(const(Guid)* rguidClock);
    HRESULT Activate(BOOL fEnable);
    HRESULT GetDefaultPort(Guid* pguidPort);
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
    HRESULT GetBufferFormat(Guid* pGuidFormat);
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
    HRESULT DownloadInstrument(IDirectMusicInstrument pInstrument, IDirectMusicDownloadedInstrument* ppDownloadedInstrument, DMUS_NOTERANGE* pNoteRanges, uint dwNumNoteRanges);
    HRESULT UnloadInstrument(IDirectMusicDownloadedInstrument pDownloadedInstrument);
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    HRESULT GetRunningStats(DMUS_SYNTHSTATS* pStats);
    HRESULT Compact();
    HRESULT GetCaps(DMUS_PORTCAPS* pPortCaps);
    HRESULT DeviceIoControl(uint dwIoControlCode, void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned, OVERLAPPED* lpOverlapped);
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
    HRESULT ThruChannel(uint dwSourceChannelGroup, uint dwSourceChannel, uint dwDestinationChannelGroup, uint dwDestinationChannel, IDirectMusicPort pDestinationPort);
}

struct DMUS_VOICE_STATE
{
    BOOL bExists;
    ulong spPosition;
}

interface IDirectMusicSynth : IUnknown
{
    HRESULT Open(DMUS_PORTPARAMS8* pPortParams);
    HRESULT Close();
    HRESULT SetNumChannelGroups(uint dwGroups);
    HRESULT Download(int* phDownload, void* pvData, int* pbFree);
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
    HRESULT PlayVoice(long rt, uint dwVoiceId, uint dwChannelGroup, uint dwChannel, uint dwDLId, int prPitch, int vrVolume, ulong stVoiceStart, ulong stLoopStart, ulong stLoopEnd);
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

const GUID CLSID_KSPROPSETID_AudioEffectsDiscovery = {0x0B217A72, 0x16B8, 0x4A4D, [0xBD, 0xED, 0xF9, 0xD6, 0xBB, 0xED, 0xCD, 0x8F]};
@GUID(0x0B217A72, 0x16B8, 0x4A4D, [0xBD, 0xED, 0xF9, 0xD6, 0xBB, 0xED, 0xCD, 0x8F]);
struct KSPROPSETID_AudioEffectsDiscovery;

enum KSPROPERTY_AUDIOEFFECTSDISCOVERY
{
    KSPROPERTY_AUDIOEFFECTSDISCOVERY_EFFECTSLIST = 1,
}

struct KSP_PINMODE
{
    KSP_PIN PinProperty;
    Guid AudioProcessingMode;
}

@DllImport("DSOUND.dll")
HRESULT DirectSoundCreate(Guid* pcGuidDevice, IDirectSound* ppDS, IUnknown pUnkOuter);

@DllImport("DSOUND.dll")
HRESULT DirectSoundEnumerateA(LPDSENUMCALLBACKA pDSEnumCallback, void* pContext);

@DllImport("DSOUND.dll")
HRESULT DirectSoundEnumerateW(LPDSENUMCALLBACKW pDSEnumCallback, void* pContext);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureCreate(Guid* pcGuidDevice, IDirectSoundCapture* ppDSC, IUnknown pUnkOuter);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureEnumerateA(LPDSENUMCALLBACKA pDSEnumCallback, void* pContext);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureEnumerateW(LPDSENUMCALLBACKW pDSEnumCallback, void* pContext);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCreate8(Guid* pcGuidDevice, IDirectSound8* ppDS8, IUnknown pUnkOuter);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureCreate8(Guid* pcGuidDevice, IDirectSoundCapture* ppDSC8, IUnknown pUnkOuter);

@DllImport("DSOUND.dll")
HRESULT DirectSoundFullDuplexCreate(Guid* pcGuidCaptureDevice, Guid* pcGuidRenderDevice, DSCBUFFERDESC* pcDSCBufferDesc, DSBUFFERDESC* pcDSBufferDesc, HWND hWnd, uint dwLevel, IDirectSoundFullDuplex* ppDSFD, IDirectSoundCaptureBuffer8* ppDSCBuffer8, IDirectSoundBuffer8* ppDSBuffer8, IUnknown pUnkOuter);

const GUID IID_IPropertyStore = {0x886D8EEB, 0x8CF2, 0x4446, [0x8D, 0x02, 0xCD, 0xBA, 0x1D, 0xBD, 0xCF, 0x99]};
@GUID(0x886D8EEB, 0x8CF2, 0x4446, [0x8D, 0x02, 0xCD, 0xBA, 0x1D, 0xBD, 0xCF, 0x99]);
interface IPropertyStore : IUnknown
{
    HRESULT GetCount(uint* cProps);
    HRESULT GetAt(uint iProp, PROPERTYKEY* pkey);
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* pv);
    HRESULT SetValue(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar);
    HRESULT Commit();
}

struct MDEVICECAPSEX
{
    uint cbSize;
    void* pCaps;
}

struct MIDIOPENDESC
{
    int hMidi;
    uint dwCallback;
    uint dwInstance;
    uint dnDevNode;
    uint cIds;
    midiopenstrmid_tag rgIds;
}

