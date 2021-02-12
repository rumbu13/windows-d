module windows.directshow;

public import system;
public import windows.audio;
public import windows.automation;
public import windows.com;
public import windows.coreaudio;
public import windows.direct2d;
public import windows.direct3d9;
public import windows.directdraw;
public import windows.displaydevices;
public import windows.gdi;
public import windows.mediafoundation;
public import windows.menusandresources;
public import windows.mmc;
public import windows.multimedia;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsmediaformat;
public import windows.windowsprogramming;

extern(Windows):

struct BITMAPINFOHEADER
{
    uint biSize;
    int biWidth;
    int biHeight;
    ushort biPlanes;
    ushort biBitCount;
    uint biCompression;
    uint biSizeImage;
    int biXPelsPerMeter;
    int biYPelsPerMeter;
    uint biClrUsed;
    uint biClrImportant;
}

enum READYSTATE
{
    READYSTATE_UNINITIALIZED = 0,
    READYSTATE_LOADING = 1,
    READYSTATE_LOADED = 2,
    READYSTATE_INTERACTIVE = 3,
    READYSTATE_COMPLETE = 4,
}

enum AMVP_SELECT_FORMAT_BY
{
    AMVP_DO_NOT_CARE = 0,
    AMVP_BEST_BANDWIDTH = 1,
    AMVP_INPUT_SAME_AS_OUTPUT = 2,
}

enum AMVP_MODE
{
    AMVP_MODE_WEAVE = 0,
    AMVP_MODE_BOBINTERLEAVED = 1,
    AMVP_MODE_BOBNONINTERLEAVED = 2,
    AMVP_MODE_SKIPEVEN = 3,
    AMVP_MODE_SKIPODD = 4,
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
    uint dwSize;
    uint dwMicrosecondsPerField;
    AMVPDIMINFO amvpDimInfo;
    uint dwPictAspectRatioX;
    uint dwPictAspectRatioY;
    BOOL bEnableDoubleClock;
    BOOL bEnableVACT;
    BOOL bDataIsInterlaced;
    int lHalfLinesOdd;
    BOOL bFieldPolarityInverted;
    uint dwNumLinesInVREF;
    int lHalfLinesEven;
    uint dwReserved1;
}

const GUID IID_ICreateDevEnum = {0x29840822, 0x5B84, 0x11D0, [0xBD, 0x3B, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]};
@GUID(0x29840822, 0x5B84, 0x11D0, [0xBD, 0x3B, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]);
interface ICreateDevEnum : IUnknown
{
    HRESULT CreateClassEnumerator(const(Guid)* clsidDeviceClass, IEnumMoniker* ppEnumMoniker, uint dwFlags);
}

struct AM_MEDIA_TYPE
{
    Guid majortype;
    Guid subtype;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint lSampleSize;
    Guid formattype;
    IUnknown pUnk;
    uint cbFormat;
    ubyte* pbFormat;
}

enum PIN_DIRECTION
{
    PINDIR_INPUT = 0,
    PINDIR_OUTPUT = 1,
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
    IBaseFilter pFilter;
    PIN_DIRECTION dir;
    ushort achName;
}

const GUID IID_IPin = {0x56A86891, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A86891, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IEnumPins = {0x56A86892, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A86892, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IEnumPins : IUnknown
{
    HRESULT Next(uint cPins, char* ppPins, uint* pcFetched);
    HRESULT Skip(uint cPins);
    HRESULT Reset();
    HRESULT Clone(IEnumPins* ppEnum);
}

const GUID IID_IEnumMediaTypes = {0x89C31040, 0x846B, 0x11CE, [0x97, 0xD3, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]};
@GUID(0x89C31040, 0x846B, 0x11CE, [0x97, 0xD3, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]);
interface IEnumMediaTypes : IUnknown
{
    HRESULT Next(uint cMediaTypes, char* ppMediaTypes, uint* pcFetched);
    HRESULT Skip(uint cMediaTypes);
    HRESULT Reset();
    HRESULT Clone(IEnumMediaTypes* ppEnum);
}

const GUID IID_IFilterGraph = {0x56A8689F, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A8689F, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IEnumFilters = {0x56A86893, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A86893, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IEnumFilters : IUnknown
{
    HRESULT Next(uint cFilters, char* ppFilter, uint* pcFetched);
    HRESULT Skip(uint cFilters);
    HRESULT Reset();
    HRESULT Clone(IEnumFilters* ppEnum);
}

enum FILTER_STATE
{
    State_Stopped = 0,
    State_Paused = 1,
    State_Running = 2,
}

const GUID IID_IMediaFilter = {0x56A86899, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A86899, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMediaFilter : IPersist
{
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Run(long tStart);
    HRESULT GetState(uint dwMilliSecsTimeout, FILTER_STATE* State);
    HRESULT SetSyncSource(IReferenceClock pClock);
    HRESULT GetSyncSource(IReferenceClock* pClock);
}

struct FILTER_INFO
{
    ushort achName;
    IFilterGraph pGraph;
}

const GUID IID_IBaseFilter = {0x56A86895, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A86895, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IBaseFilter : IMediaFilter
{
    HRESULT EnumPins(IEnumPins* ppEnum);
    HRESULT FindPin(const(wchar)* Id, IPin* ppPin);
    HRESULT QueryFilterInfo(FILTER_INFO* pInfo);
    HRESULT JoinFilterGraph(IFilterGraph pGraph, const(wchar)* pName);
    HRESULT QueryVendorInfo(ushort** pVendorInfo);
}

const GUID IID_IReferenceClock = {0x56A86897, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A86897, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IReferenceClock : IUnknown
{
    HRESULT GetTime(long* pTime);
    HRESULT AdviseTime(long baseTime, long streamTime, uint hEvent, uint* pdwAdviseCookie);
    HRESULT AdvisePeriodic(long startTime, long periodTime, uint hSemaphore, uint* pdwAdviseCookie);
    HRESULT Unadvise(uint dwAdviseCookie);
}

const GUID IID_IReferenceClockTimerControl = {0xEBEC459C, 0x2ECA, 0x4D42, [0xA8, 0xAF, 0x30, 0xDF, 0x55, 0x76, 0x14, 0xB8]};
@GUID(0xEBEC459C, 0x2ECA, 0x4D42, [0xA8, 0xAF, 0x30, 0xDF, 0x55, 0x76, 0x14, 0xB8]);
interface IReferenceClockTimerControl : IUnknown
{
    HRESULT SetDefaultTimerResolution(long timerResolution);
    HRESULT GetDefaultTimerResolution(long* pTimerResolution);
}

const GUID IID_IReferenceClock2 = {0x36B73885, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]};
@GUID(0x36B73885, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]);
interface IReferenceClock2 : IReferenceClock
{
}

const GUID IID_IMediaSample = {0x56A8689A, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A8689A, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMediaSample : IUnknown
{
    HRESULT GetPointer(char* ppBuffer);
    int GetSize();
    HRESULT GetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT SetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT IsSyncPoint();
    HRESULT SetSyncPoint(BOOL bIsSyncPoint);
    HRESULT IsPreroll();
    HRESULT SetPreroll(BOOL bIsPreroll);
    int GetActualDataLength();
    HRESULT SetActualDataLength(int __MIDL__IMediaSample0000);
    HRESULT GetMediaType(AM_MEDIA_TYPE** ppMediaType);
    HRESULT SetMediaType(AM_MEDIA_TYPE* pMediaType);
    HRESULT IsDiscontinuity();
    HRESULT SetDiscontinuity(BOOL bDiscontinuity);
    HRESULT GetMediaTime(long* pTimeStart, long* pTimeEnd);
    HRESULT SetMediaTime(long* pTimeStart, long* pTimeEnd);
}

enum tagAM_SAMPLE_PROPERTY_FLAGS
{
    AM_SAMPLE_SPLICEPOINT = 1,
    AM_SAMPLE_PREROLL = 2,
    AM_SAMPLE_DATADISCONTINUITY = 4,
    AM_SAMPLE_TYPECHANGED = 8,
    AM_SAMPLE_TIMEVALID = 16,
    AM_SAMPLE_TIMEDISCONTINUITY = 64,
    AM_SAMPLE_FLUSH_ON_PAUSE = 128,
    AM_SAMPLE_STOPVALID = 256,
    AM_SAMPLE_ENDOFSTREAM = 512,
    AM_STREAM_MEDIA = 0,
    AM_STREAM_CONTROL = 1,
}

struct AM_SAMPLE2_PROPERTIES
{
    uint cbData;
    uint dwTypeSpecificFlags;
    uint dwSampleFlags;
    int lActual;
    long tStart;
    long tStop;
    uint dwStreamId;
    AM_MEDIA_TYPE* pMediaType;
    ubyte* pbBuffer;
    int cbBuffer;
}

const GUID IID_IMediaSample2 = {0x36B73884, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]};
@GUID(0x36B73884, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]);
interface IMediaSample2 : IMediaSample
{
    HRESULT GetProperties(uint cbProperties, char* pbProperties);
    HRESULT SetProperties(uint cbProperties, char* pbProperties);
}

const GUID IID_IMediaSample2Config = {0x68961E68, 0x832B, 0x41EA, [0xBC, 0x91, 0x63, 0x59, 0x3F, 0x3E, 0x70, 0xE3]};
@GUID(0x68961E68, 0x832B, 0x41EA, [0xBC, 0x91, 0x63, 0x59, 0x3F, 0x3E, 0x70, 0xE3]);
interface IMediaSample2Config : IUnknown
{
    HRESULT GetSurface(IUnknown* ppDirect3DSurface9);
}

const GUID IID_IMemAllocator = {0x56A8689C, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A8689C, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMemAllocator : IUnknown
{
    HRESULT SetProperties(ALLOCATOR_PROPERTIES* pRequest, ALLOCATOR_PROPERTIES* pActual);
    HRESULT GetProperties(ALLOCATOR_PROPERTIES* pProps);
    HRESULT Commit();
    HRESULT Decommit();
    HRESULT GetBuffer(IMediaSample* ppBuffer, long* pStartTime, long* pEndTime, uint dwFlags);
    HRESULT ReleaseBuffer(IMediaSample pBuffer);
}

const GUID IID_IMemAllocatorCallbackTemp = {0x379A0CF0, 0xC1DE, 0x11D2, [0xAB, 0xF5, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0x379A0CF0, 0xC1DE, 0x11D2, [0xAB, 0xF5, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IMemAllocatorCallbackTemp : IMemAllocator
{
    HRESULT SetNotify(IMemAllocatorNotifyCallbackTemp pNotify);
    HRESULT GetFreeCount(int* plBuffersFree);
}

const GUID IID_IMemAllocatorNotifyCallbackTemp = {0x92980B30, 0xC1DE, 0x11D2, [0xAB, 0xF5, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0x92980B30, 0xC1DE, 0x11D2, [0xAB, 0xF5, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IMemAllocatorNotifyCallbackTemp : IUnknown
{
    HRESULT NotifyRelease();
}

const GUID IID_IMemInputPin = {0x56A8689D, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A8689D, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMemInputPin : IUnknown
{
    HRESULT GetAllocator(IMemAllocator* ppAllocator);
    HRESULT NotifyAllocator(IMemAllocator pAllocator, BOOL bReadOnly);
    HRESULT GetAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
    HRESULT Receive(IMediaSample pSample);
    HRESULT ReceiveMultiple(char* pSamples, int nSamples, int* nSamplesProcessed);
    HRESULT ReceiveCanBlock();
}

const GUID IID_IAMovieSetup = {0xA3D8CEC0, 0x7E5A, 0x11CF, [0xBB, 0xC5, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x20]};
@GUID(0xA3D8CEC0, 0x7E5A, 0x11CF, [0xBB, 0xC5, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x20]);
interface IAMovieSetup : IUnknown
{
    HRESULT Register();
    HRESULT Unregister();
}

enum AM_SEEKING_SeekingFlags
{
    AM_SEEKING_NoPositioning = 0,
    AM_SEEKING_AbsolutePositioning = 1,
    AM_SEEKING_RelativePositioning = 2,
    AM_SEEKING_IncrementalPositioning = 3,
    AM_SEEKING_PositioningBitsMask = 3,
    AM_SEEKING_SeekToKeyFrame = 4,
    AM_SEEKING_ReturnTime = 8,
    AM_SEEKING_Segment = 16,
    AM_SEEKING_NoFlush = 32,
}

enum AM_SEEKING_SEEKING_CAPABILITIES
{
    AM_SEEKING_CanSeekAbsolute = 1,
    AM_SEEKING_CanSeekForwards = 2,
    AM_SEEKING_CanSeekBackwards = 4,
    AM_SEEKING_CanGetCurrentPos = 8,
    AM_SEEKING_CanGetStopPos = 16,
    AM_SEEKING_CanGetDuration = 32,
    AM_SEEKING_CanPlayBackwards = 64,
    AM_SEEKING_CanDoSegments = 128,
    AM_SEEKING_Source = 256,
}

const GUID IID_IMediaSeeking = {0x36B73880, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]};
@GUID(0x36B73880, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]);
interface IMediaSeeking : IUnknown
{
    HRESULT GetCapabilities(uint* pCapabilities);
    HRESULT CheckCapabilities(uint* pCapabilities);
    HRESULT IsFormatSupported(const(Guid)* pFormat);
    HRESULT QueryPreferredFormat(Guid* pFormat);
    HRESULT GetTimeFormatA(Guid* pFormat);
    HRESULT IsUsingTimeFormat(const(Guid)* pFormat);
    HRESULT SetTimeFormat(const(Guid)* pFormat);
    HRESULT GetDuration(long* pDuration);
    HRESULT GetStopPosition(long* pStop);
    HRESULT GetCurrentPosition(long* pCurrent);
    HRESULT ConvertTimeFormat(long* pTarget, const(Guid)* pTargetFormat, long Source, const(Guid)* pSourceFormat);
    HRESULT SetPositions(long* pCurrent, uint dwCurrentFlags, long* pStop, uint dwStopFlags);
    HRESULT GetPositions(long* pCurrent, long* pStop);
    HRESULT GetAvailable(long* pEarliest, long* pLatest);
    HRESULT SetRate(double dRate);
    HRESULT GetRate(double* pdRate);
    HRESULT GetPreroll(long* pllPreroll);
}

enum tagAM_MEDIAEVENT_FLAGS
{
    AM_MEDIAEVENT_NONOTIFY = 1,
}

struct REGFILTER
{
    Guid Clsid;
    const(wchar)* Name;
}

const GUID IID_IEnumRegFilters = {0x56A868A4, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A4, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IEnumRegFilters : IUnknown
{
    HRESULT Next(uint cFilters, char* apRegFilter, uint* pcFetched);
    HRESULT Skip(uint cFilters);
    HRESULT Reset();
    HRESULT Clone(IEnumRegFilters* ppEnum);
}

enum __MIDL_IFilterMapper_0001
{
    MERIT_PREFERRED = 8388608,
    MERIT_NORMAL = 6291456,
    MERIT_UNLIKELY = 4194304,
    MERIT_DO_NOT_USE = 2097152,
    MERIT_SW_COMPRESSOR = 1048576,
    MERIT_HW_COMPRESSOR = 1048656,
}

const GUID IID_IFilterMapper = {0x56A868A3, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A3, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IFilterMapper : IUnknown
{
    HRESULT RegisterFilter(Guid clsid, const(wchar)* Name, uint dwMerit);
    HRESULT RegisterFilterInstance(Guid clsid, const(wchar)* Name, Guid* MRId);
    HRESULT RegisterPin(Guid Filter, const(wchar)* Name, BOOL bRendered, BOOL bOutput, BOOL bZero, BOOL bMany, Guid ConnectsToFilter, const(wchar)* ConnectsToPin);
    HRESULT RegisterPinType(Guid clsFilter, const(wchar)* strName, Guid clsMajorType, Guid clsSubType);
    HRESULT UnregisterFilter(Guid Filter);
    HRESULT UnregisterFilterInstance(Guid MRId);
    HRESULT UnregisterPin(Guid Filter, const(wchar)* Name);
    HRESULT EnumMatchingFilters(IEnumRegFilters* ppEnum, uint dwMerit, BOOL bInputNeeded, Guid clsInMaj, Guid clsInSub, BOOL bRender, BOOL bOututNeeded, Guid clsOutMaj, Guid clsOutSub);
}

struct REGPINTYPES
{
    const(Guid)* clsMajorType;
    const(Guid)* clsMinorType;
}

struct REGFILTERPINS
{
    const(wchar)* strName;
    BOOL bRendered;
    BOOL bOutput;
    BOOL bZero;
    BOOL bMany;
    const(Guid)* clsConnectsToFilter;
    const(wchar)* strConnectsToPin;
    uint nMediaTypes;
    const(REGPINTYPES)* lpMediaType;
}

struct REGPINMEDIUM
{
    Guid clsMedium;
    uint dw1;
    uint dw2;
}

enum __MIDL___MIDL_itf_strmif_0000_0023_0001
{
    REG_PINFLAG_B_ZERO = 1,
    REG_PINFLAG_B_RENDERER = 2,
    REG_PINFLAG_B_MANY = 4,
    REG_PINFLAG_B_OUTPUT = 8,
}

struct REGFILTERPINS2
{
    uint dwFlags;
    uint cInstances;
    uint nMediaTypes;
    const(REGPINTYPES)* lpMediaType;
    uint nMediums;
    const(REGPINMEDIUM)* lpMedium;
    const(Guid)* clsPinCategory;
}

struct REGFILTER2
{
    uint dwVersion;
    uint dwMerit;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_IFilterMapper2 = {0xB79BB0B0, 0x33C1, 0x11D1, [0xAB, 0xE1, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0xB79BB0B0, 0x33C1, 0x11D1, [0xAB, 0xE1, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IFilterMapper2 : IUnknown
{
    HRESULT CreateCategory(const(Guid)* clsidCategory, uint dwCategoryMerit, const(wchar)* Description);
    HRESULT UnregisterFilter(const(Guid)* pclsidCategory, ushort* szInstance, const(Guid)* Filter);
    HRESULT RegisterFilter(const(Guid)* clsidFilter, const(wchar)* Name, IMoniker* ppMoniker, const(Guid)* pclsidCategory, ushort* szInstance, const(REGFILTER2)* prf2);
    HRESULT EnumMatchingFilters(IEnumMoniker* ppEnum, uint dwFlags, BOOL bExactMatch, uint dwMerit, BOOL bInputNeeded, uint cInputTypes, char* pInputTypes, const(REGPINMEDIUM)* pMedIn, const(Guid)* pPinCategoryIn, BOOL bRender, BOOL bOutputNeeded, uint cOutputTypes, char* pOutputTypes, const(REGPINMEDIUM)* pMedOut, const(Guid)* pPinCategoryOut);
}

const GUID IID_IFilterMapper3 = {0xB79BB0B1, 0x33C1, 0x11D1, [0xAB, 0xE1, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0xB79BB0B1, 0x33C1, 0x11D1, [0xAB, 0xE1, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IFilterMapper3 : IFilterMapper2
{
    HRESULT GetICreateDevEnum(ICreateDevEnum* ppEnum);
}

enum QualityMessageType
{
    Famine = 0,
    Flood = 1,
}

struct Quality
{
    QualityMessageType Type;
    int Proportion;
    long Late;
    long TimeStamp;
}

const GUID IID_IQualityControl = {0x56A868A5, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A5, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IQualityControl : IUnknown
{
    HRESULT Notify(IBaseFilter pSelf, Quality q);
    HRESULT SetSink(IQualityControl piqc);
}

enum __MIDL___MIDL_itf_strmif_0000_0026_0001
{
    CK_NOCOLORKEY = 0,
    CK_INDEX = 1,
    CK_RGB = 2,
}

struct COLORKEY
{
    uint KeyType;
    uint PaletteIndex;
    uint LowColorValue;
    uint HighColorValue;
}

enum __MIDL___MIDL_itf_strmif_0000_0026_0002
{
    ADVISE_NONE = 0,
    ADVISE_CLIPPING = 1,
    ADVISE_PALETTE = 2,
    ADVISE_COLORKEY = 4,
    ADVISE_POSITION = 8,
    ADVISE_DISPLAY_CHANGE = 16,
}

const GUID IID_IOverlayNotify = {0x56A868A0, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A0, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IOverlayNotify : IUnknown
{
    HRESULT OnPaletteChange(uint dwColors, const(PALETTEENTRY)* pPalette);
    HRESULT OnClipChange(const(RECT)* pSourceRect, const(RECT)* pDestinationRect, const(RGNDATA)* pRgnData);
    HRESULT OnColorKeyChange(const(COLORKEY)* pColorKey);
    HRESULT OnPositionChange(const(RECT)* pSourceRect, const(RECT)* pDestinationRect);
}

const GUID IID_IOverlayNotify2 = {0x680EFA10, 0xD535, 0x11D1, [0x87, 0xC8, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x680EFA10, 0xD535, 0x11D1, [0x87, 0xC8, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
interface IOverlayNotify2 : IOverlayNotify
{
    HRESULT OnDisplayChange(int hMonitor);
}

const GUID IID_IOverlay = {0x56A868A1, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A1, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IMediaEventSink = {0x56A868A2, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A2, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMediaEventSink : IUnknown
{
    HRESULT Notify(int EventCode, int EventParam1, int EventParam2);
}

const GUID IID_IFileSourceFilter = {0x56A868A6, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A6, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IFileSourceFilter : IUnknown
{
    HRESULT Load(ushort* pszFileName, const(AM_MEDIA_TYPE)* pmt);
    HRESULT GetCurFile(ushort** ppszFileName, AM_MEDIA_TYPE* pmt);
}

const GUID IID_IFileSinkFilter = {0xA2104830, 0x7C70, 0x11CF, [0x8B, 0xCE, 0x00, 0xAA, 0x00, 0xA3, 0xF1, 0xA6]};
@GUID(0xA2104830, 0x7C70, 0x11CF, [0x8B, 0xCE, 0x00, 0xAA, 0x00, 0xA3, 0xF1, 0xA6]);
interface IFileSinkFilter : IUnknown
{
    HRESULT SetFileName(ushort* pszFileName, const(AM_MEDIA_TYPE)* pmt);
    HRESULT GetCurFile(ushort** ppszFileName, AM_MEDIA_TYPE* pmt);
}

const GUID IID_IFileSinkFilter2 = {0x00855B90, 0xCE1B, 0x11D0, [0xBD, 0x4F, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]};
@GUID(0x00855B90, 0xCE1B, 0x11D0, [0xBD, 0x4F, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]);
interface IFileSinkFilter2 : IFileSinkFilter
{
    HRESULT SetMode(uint dwFlags);
    HRESULT GetMode(uint* pdwFlags);
}

enum AM_FILESINK_FLAGS
{
    AM_FILE_OVERWRITE = 1,
}

const GUID IID_IGraphBuilder = {0x56A868A9, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868A9, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IGraphBuilder : IFilterGraph
{
    HRESULT Connect(IPin ppinOut, IPin ppinIn);
    HRESULT Render(IPin ppinOut);
    HRESULT RenderFile(const(wchar)* lpcwstrFile, const(wchar)* lpcwstrPlayList);
    HRESULT AddSourceFilter(const(wchar)* lpcwstrFileName, const(wchar)* lpcwstrFilterName, IBaseFilter* ppFilter);
    HRESULT SetLogFile(uint hFile);
    HRESULT Abort();
    HRESULT ShouldOperationContinue();
}

const GUID IID_ICaptureGraphBuilder = {0xBF87B6E0, 0x8C27, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]};
@GUID(0xBF87B6E0, 0x8C27, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]);
interface ICaptureGraphBuilder : IUnknown
{
    HRESULT SetFiltergraph(IGraphBuilder pfg);
    HRESULT GetFiltergraph(IGraphBuilder* ppfg);
    HRESULT SetOutputFileName(const(Guid)* pType, ushort* lpstrFile, IBaseFilter* ppf, IFileSinkFilter* ppSink);
    HRESULT FindInterface(const(Guid)* pCategory, IBaseFilter pf, const(Guid)* riid, void** ppint);
    HRESULT RenderStream(const(Guid)* pCategory, IUnknown pSource, IBaseFilter pfCompressor, IBaseFilter pfRenderer);
    HRESULT ControlStream(const(Guid)* pCategory, IBaseFilter pFilter, long* pstart, long* pstop, ushort wStartCookie, ushort wStopCookie);
    HRESULT AllocCapFile(ushort* lpstr, ulong dwlSize);
    HRESULT CopyCaptureFile(ushort* lpwstrOld, ushort* lpwstrNew, int fAllowEscAbort, IAMCopyCaptureFileProgress pCallback);
}

const GUID IID_IAMCopyCaptureFileProgress = {0x670D1D20, 0xA068, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]};
@GUID(0x670D1D20, 0xA068, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]);
interface IAMCopyCaptureFileProgress : IUnknown
{
    HRESULT Progress(int iProgress);
}

const GUID IID_ICaptureGraphBuilder2 = {0x93E5A4E0, 0x2D50, 0x11D2, [0xAB, 0xFA, 0x00, 0xA0, 0xC9, 0xC6, 0xE3, 0x8D]};
@GUID(0x93E5A4E0, 0x2D50, 0x11D2, [0xAB, 0xFA, 0x00, 0xA0, 0xC9, 0xC6, 0xE3, 0x8D]);
interface ICaptureGraphBuilder2 : IUnknown
{
    HRESULT SetFiltergraph(IGraphBuilder pfg);
    HRESULT GetFiltergraph(IGraphBuilder* ppfg);
    HRESULT SetOutputFileName(const(Guid)* pType, ushort* lpstrFile, IBaseFilter* ppf, IFileSinkFilter* ppSink);
    HRESULT FindInterface(const(Guid)* pCategory, const(Guid)* pType, IBaseFilter pf, const(Guid)* riid, void** ppint);
    HRESULT RenderStream(const(Guid)* pCategory, const(Guid)* pType, IUnknown pSource, IBaseFilter pfCompressor, IBaseFilter pfRenderer);
    HRESULT ControlStream(const(Guid)* pCategory, const(Guid)* pType, IBaseFilter pFilter, long* pstart, long* pstop, ushort wStartCookie, ushort wStopCookie);
    HRESULT AllocCapFile(ushort* lpstr, ulong dwlSize);
    HRESULT CopyCaptureFile(ushort* lpwstrOld, ushort* lpwstrNew, int fAllowEscAbort, IAMCopyCaptureFileProgress pCallback);
    HRESULT FindPin(IUnknown pSource, PIN_DIRECTION pindir, const(Guid)* pCategory, const(Guid)* pType, BOOL fUnconnected, int num, IPin* ppPin);
}

enum _AM_RENSDEREXFLAGS
{
    AM_RENDEREX_RENDERTOEXISTINGRENDERERS = 1,
}

const GUID IID_IFilterGraph2 = {0x36B73882, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]};
@GUID(0x36B73882, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]);
interface IFilterGraph2 : IGraphBuilder
{
    HRESULT AddSourceFilterForMoniker(IMoniker pMoniker, IBindCtx pCtx, const(wchar)* lpcwstrFilterName, IBaseFilter* ppFilter);
    HRESULT ReconnectEx(IPin ppin, const(AM_MEDIA_TYPE)* pmt);
    HRESULT RenderEx(IPin pPinOut, uint dwFlags, uint* pvContext);
}

const GUID IID_IFilterGraph3 = {0xAAF38154, 0xB80B, 0x422F, [0x91, 0xE6, 0xB6, 0x64, 0x67, 0x50, 0x9A, 0x07]};
@GUID(0xAAF38154, 0xB80B, 0x422F, [0x91, 0xE6, 0xB6, 0x64, 0x67, 0x50, 0x9A, 0x07]);
interface IFilterGraph3 : IFilterGraph2
{
    HRESULT SetSyncSourceEx(IReferenceClock pClockForMostOfFilterGraph, IReferenceClock pClockForFilter, IBaseFilter pFilter);
}

const GUID IID_IStreamBuilder = {0x56A868BF, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868BF, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IStreamBuilder : IUnknown
{
    HRESULT Render(IPin ppinOut, IGraphBuilder pGraph);
    HRESULT Backout(IPin ppinOut, IGraphBuilder pGraph);
}

const GUID IID_IAsyncReader = {0x56A868AA, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868AA, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IAsyncReader : IUnknown
{
    HRESULT RequestAllocator(IMemAllocator pPreferred, ALLOCATOR_PROPERTIES* pProps, IMemAllocator* ppActual);
    HRESULT Request(IMediaSample pSample, uint dwUser);
    HRESULT WaitForNext(uint dwTimeout, IMediaSample* ppSample, uint* pdwUser);
    HRESULT SyncReadAligned(IMediaSample pSample);
    HRESULT SyncRead(long llPosition, int lLength, char* pBuffer);
    HRESULT Length(long* pTotal, long* pAvailable);
    HRESULT BeginFlush();
    HRESULT EndFlush();
}

const GUID IID_IGraphVersion = {0x56A868AB, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868AB, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IGraphVersion : IUnknown
{
    HRESULT QueryVersion(int* pVersion);
}

const GUID IID_IResourceConsumer = {0x56A868AD, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868AD, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IResourceConsumer : IUnknown
{
    HRESULT AcquireResource(int idResource);
    HRESULT ReleaseResource(int idResource);
}

const GUID IID_IResourceManager = {0x56A868AC, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868AC, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IDistributorNotify = {0x56A868AF, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868AF, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IDistributorNotify : IUnknown
{
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Run(long tStart);
    HRESULT SetSyncSource(IReferenceClock pClock);
    HRESULT NotifyGraphChange();
}

enum AM_STREAM_INFO_FLAGS
{
    AM_STREAM_INFO_START_DEFINED = 1,
    AM_STREAM_INFO_STOP_DEFINED = 2,
    AM_STREAM_INFO_DISCARDING = 4,
    AM_STREAM_INFO_STOP_SEND_EXTRA = 16,
}

struct AM_STREAM_INFO
{
    long tStart;
    long tStop;
    uint dwStartCookie;
    uint dwStopCookie;
    uint dwFlags;
}

const GUID IID_IAMStreamControl = {0x36B73881, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]};
@GUID(0x36B73881, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]);
interface IAMStreamControl : IUnknown
{
    HRESULT StartAt(const(long)* ptStart, uint dwCookie);
    HRESULT StopAt(const(long)* ptStop, BOOL bSendExtra, uint dwCookie);
    HRESULT GetInfo(AM_STREAM_INFO* pInfo);
}

const GUID IID_ISeekingPassThru = {0x36B73883, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]};
@GUID(0x36B73883, 0xC2C8, 0x11CF, [0x8B, 0x46, 0x00, 0x80, 0x5F, 0x6C, 0xEF, 0x60]);
interface ISeekingPassThru : IUnknown
{
    HRESULT Init(BOOL bSupportRendering, IPin pPin);
}

struct VIDEO_STREAM_CONFIG_CAPS
{
    Guid guid;
    uint VideoStandard;
    SIZE InputSize;
    SIZE MinCroppingSize;
    SIZE MaxCroppingSize;
    int CropGranularityX;
    int CropGranularityY;
    int CropAlignX;
    int CropAlignY;
    SIZE MinOutputSize;
    SIZE MaxOutputSize;
    int OutputGranularityX;
    int OutputGranularityY;
    int StretchTapsX;
    int StretchTapsY;
    int ShrinkTapsX;
    int ShrinkTapsY;
    long MinFrameInterval;
    long MaxFrameInterval;
    int MinBitsPerSecond;
    int MaxBitsPerSecond;
}

struct AUDIO_STREAM_CONFIG_CAPS
{
    Guid guid;
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

const GUID IID_IAMStreamConfig = {0xC6E13340, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13340, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
interface IAMStreamConfig : IUnknown
{
    HRESULT SetFormat(AM_MEDIA_TYPE* pmt);
    HRESULT GetFormat(AM_MEDIA_TYPE** ppmt);
    HRESULT GetNumberOfCapabilities(int* piCount, int* piSize);
    HRESULT GetStreamCaps(int iIndex, AM_MEDIA_TYPE** ppmt, ubyte* pSCC);
}

enum InterleavingMode
{
    INTERLEAVE_NONE = 0,
    INTERLEAVE_CAPTURE = 1,
    INTERLEAVE_FULL = 2,
    INTERLEAVE_NONE_BUFFERED = 3,
}

const GUID IID_IConfigInterleaving = {0xBEE3D220, 0x157B, 0x11D0, [0xBD, 0x23, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]};
@GUID(0xBEE3D220, 0x157B, 0x11D0, [0xBD, 0x23, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]);
interface IConfigInterleaving : IUnknown
{
    HRESULT put_Mode(InterleavingMode mode);
    HRESULT get_Mode(InterleavingMode* pMode);
    HRESULT put_Interleaving(const(long)* prtInterleave, const(long)* prtPreroll);
    HRESULT get_Interleaving(long* prtInterleave, long* prtPreroll);
}

const GUID IID_IConfigAviMux = {0x5ACD6AA0, 0xF482, 0x11CE, [0x8B, 0x67, 0x00, 0xAA, 0x00, 0xA3, 0xF1, 0xA6]};
@GUID(0x5ACD6AA0, 0xF482, 0x11CE, [0x8B, 0x67, 0x00, 0xAA, 0x00, 0xA3, 0xF1, 0xA6]);
interface IConfigAviMux : IUnknown
{
    HRESULT SetMasterStream(int iStream);
    HRESULT GetMasterStream(int* pStream);
    HRESULT SetOutputCompatibilityIndex(BOOL fOldIndex);
    HRESULT GetOutputCompatibilityIndex(int* pfOldIndex);
}

enum CompressionCaps
{
    CompressionCaps_CanQuality = 1,
    CompressionCaps_CanCrunch = 2,
    CompressionCaps_CanKeyFrame = 4,
    CompressionCaps_CanBFrame = 8,
    CompressionCaps_CanWindow = 16,
}

const GUID IID_IAMVideoCompression = {0xC6E13343, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13343, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
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
    HRESULT GetInfo(const(wchar)* pszVersion, int* pcbVersion, const(wchar)* pszDescription, int* pcbDescription, int* pDefaultKeyFrameRate, int* pDefaultPFramesPerKey, double* pDefaultQuality, int* pCapabilities);
    HRESULT OverrideKeyFrame(int FrameNumber);
    HRESULT OverrideFrameSize(int FrameNumber, int Size);
}

enum VfwCaptureDialogs
{
    VfwCaptureDialog_Source = 1,
    VfwCaptureDialog_Format = 2,
    VfwCaptureDialog_Display = 4,
}

enum VfwCompressDialogs
{
    VfwCompressDialog_Config = 1,
    VfwCompressDialog_About = 2,
    VfwCompressDialog_QueryConfig = 4,
    VfwCompressDialog_QueryAbout = 8,
}

const GUID IID_IAMVfwCaptureDialogs = {0xD8D715A0, 0x6E5E, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]};
@GUID(0xD8D715A0, 0x6E5E, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]);
interface IAMVfwCaptureDialogs : IUnknown
{
    HRESULT HasDialog(int iDialog);
    HRESULT ShowDialog(int iDialog, HWND hwnd);
    HRESULT SendDriverMessage(int iDialog, int uMsg, int dw1, int dw2);
}

const GUID IID_IAMVfwCompressDialogs = {0xD8D715A3, 0x6E5E, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]};
@GUID(0xD8D715A3, 0x6E5E, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]);
interface IAMVfwCompressDialogs : IUnknown
{
    HRESULT ShowDialog(int iDialog, HWND hwnd);
    HRESULT GetState(char* pState, int* pcbState);
    HRESULT SetState(char* pState, int cbState);
    HRESULT SendDriverMessage(int uMsg, int dw1, int dw2);
}

const GUID IID_IAMDroppedFrames = {0xC6E13344, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13344, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
interface IAMDroppedFrames : IUnknown
{
    HRESULT GetNumDropped(int* plDropped);
    HRESULT GetNumNotDropped(int* plNotDropped);
    HRESULT GetDroppedInfo(int lSize, int* plArray, int* plNumCopied);
    HRESULT GetAverageFrameSize(int* plAverageSize);
}

const GUID IID_IAMAudioInputMixer = {0x54C39221, 0x8380, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]};
@GUID(0x54C39221, 0x8380, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]);
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

const GUID IID_IAMBufferNegotiation = {0x56ED71A0, 0xAF5F, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]};
@GUID(0x56ED71A0, 0xAF5F, 0x11D0, [0xB3, 0xF0, 0x00, 0xAA, 0x00, 0x37, 0x61, 0xC5]);
interface IAMBufferNegotiation : IUnknown
{
    HRESULT SuggestAllocatorProperties(const(ALLOCATOR_PROPERTIES)* pprop);
    HRESULT GetAllocatorProperties(ALLOCATOR_PROPERTIES* pprop);
}

enum AnalogVideoStandard
{
    AnalogVideo_None = 0,
    AnalogVideo_NTSC_M = 1,
    AnalogVideo_NTSC_M_J = 2,
    AnalogVideo_NTSC_433 = 4,
    AnalogVideo_PAL_B = 16,
    AnalogVideo_PAL_D = 32,
    AnalogVideo_PAL_G = 64,
    AnalogVideo_PAL_H = 128,
    AnalogVideo_PAL_I = 256,
    AnalogVideo_PAL_M = 512,
    AnalogVideo_PAL_N = 1024,
    AnalogVideo_PAL_60 = 2048,
    AnalogVideo_SECAM_B = 4096,
    AnalogVideo_SECAM_D = 8192,
    AnalogVideo_SECAM_G = 16384,
    AnalogVideo_SECAM_H = 32768,
    AnalogVideo_SECAM_K = 65536,
    AnalogVideo_SECAM_K1 = 131072,
    AnalogVideo_SECAM_L = 262144,
    AnalogVideo_SECAM_L1 = 524288,
    AnalogVideo_PAL_N_COMBO = 1048576,
    AnalogVideoMask_MCE_NTSC = 1052167,
    AnalogVideoMask_MCE_PAL = 496,
    AnalogVideoMask_MCE_SECAM = 1044480,
}

enum TunerInputType
{
    TunerInputCable = 0,
    TunerInputAntenna = 1,
}

enum VideoCopyProtectionType
{
    VideoCopyProtectionMacrovisionBasic = 0,
    VideoCopyProtectionMacrovisionCBI = 1,
}

enum PhysicalConnectorType
{
    PhysConn_Video_Tuner = 1,
    PhysConn_Video_Composite = 2,
    PhysConn_Video_SVideo = 3,
    PhysConn_Video_RGB = 4,
    PhysConn_Video_YRYBY = 5,
    PhysConn_Video_SerialDigital = 6,
    PhysConn_Video_ParallelDigital = 7,
    PhysConn_Video_SCSI = 8,
    PhysConn_Video_AUX = 9,
    PhysConn_Video_1394 = 10,
    PhysConn_Video_USB = 11,
    PhysConn_Video_VideoDecoder = 12,
    PhysConn_Video_VideoEncoder = 13,
    PhysConn_Video_SCART = 14,
    PhysConn_Video_Black = 15,
    PhysConn_Audio_Tuner = 4096,
    PhysConn_Audio_Line = 4097,
    PhysConn_Audio_Mic = 4098,
    PhysConn_Audio_AESDigital = 4099,
    PhysConn_Audio_SPDIFDigital = 4100,
    PhysConn_Audio_SCSI = 4101,
    PhysConn_Audio_AUX = 4102,
    PhysConn_Audio_1394 = 4103,
    PhysConn_Audio_USB = 4104,
    PhysConn_Audio_AudioDecoder = 4105,
}

const GUID IID_IAMAnalogVideoDecoder = {0xC6E13350, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13350, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
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

enum VideoProcAmpProperty
{
    VideoProcAmp_Brightness = 0,
    VideoProcAmp_Contrast = 1,
    VideoProcAmp_Hue = 2,
    VideoProcAmp_Saturation = 3,
    VideoProcAmp_Sharpness = 4,
    VideoProcAmp_Gamma = 5,
    VideoProcAmp_ColorEnable = 6,
    VideoProcAmp_WhiteBalance = 7,
    VideoProcAmp_BacklightCompensation = 8,
    VideoProcAmp_Gain = 9,
}

enum VideoProcAmpFlags
{
    VideoProcAmp_Flags_Auto = 1,
    VideoProcAmp_Flags_Manual = 2,
}

const GUID IID_IAMVideoProcAmp = {0xC6E13360, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13360, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
interface IAMVideoProcAmp : IUnknown
{
    HRESULT GetRange(int Property, int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlags);
    HRESULT Set(int Property, int lValue, int Flags);
    HRESULT Get(int Property, int* lValue, int* Flags);
}

enum CameraControlProperty
{
    CameraControl_Pan = 0,
    CameraControl_Tilt = 1,
    CameraControl_Roll = 2,
    CameraControl_Zoom = 3,
    CameraControl_Exposure = 4,
    CameraControl_Iris = 5,
    CameraControl_Focus = 6,
}

enum CameraControlFlags
{
    CameraControl_Flags_Auto = 1,
    CameraControl_Flags_Manual = 2,
}

const GUID IID_IAMCameraControl = {0xC6E13370, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13370, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
interface IAMCameraControl : IUnknown
{
    HRESULT GetRange(int Property, int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlags);
    HRESULT Set(int Property, int lValue, int Flags);
    HRESULT Get(int Property, int* lValue, int* Flags);
}

enum VideoControlFlags
{
    VideoControlFlag_FlipHorizontal = 1,
    VideoControlFlag_FlipVertical = 2,
    VideoControlFlag_ExternalTriggerEnable = 4,
    VideoControlFlag_Trigger = 8,
}

const GUID IID_IAMVideoControl = {0x6A2E0670, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0670, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
interface IAMVideoControl : IUnknown
{
    HRESULT GetCaps(IPin pPin, int* pCapsFlags);
    HRESULT SetMode(IPin pPin, int Mode);
    HRESULT GetMode(IPin pPin, int* Mode);
    HRESULT GetCurrentActualFrameRate(IPin pPin, long* ActualFrameRate);
    HRESULT GetMaxAvailableFrameRate(IPin pPin, int iIndex, SIZE Dimensions, long* MaxAvailableFrameRate);
    HRESULT GetFrameRateList(IPin pPin, int iIndex, SIZE Dimensions, int* ListSize, long** FrameRates);
}

const GUID IID_IAMCrossbar = {0xC6E13380, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13380, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
interface IAMCrossbar : IUnknown
{
    HRESULT get_PinCounts(int* OutputPinCount, int* InputPinCount);
    HRESULT CanRoute(int OutputPinIndex, int InputPinIndex);
    HRESULT Route(int OutputPinIndex, int InputPinIndex);
    HRESULT get_IsRoutedTo(int OutputPinIndex, int* InputPinIndex);
    HRESULT get_CrossbarPinInfo(BOOL IsInputPin, int PinIndex, int* PinIndexRelated, int* PhysicalType);
}

enum AMTunerSubChannel
{
    AMTUNER_SUBCHAN_NO_TUNE = -2,
    AMTUNER_SUBCHAN_DEFAULT = -1,
}

enum AMTunerSignalStrength
{
    AMTUNER_HASNOSIGNALSTRENGTH = -1,
    AMTUNER_NOSIGNAL = 0,
    AMTUNER_SIGNALPRESENT = 1,
}

enum AMTunerModeType
{
    AMTUNER_MODE_DEFAULT = 0,
    AMTUNER_MODE_TV = 1,
    AMTUNER_MODE_FM_RADIO = 2,
    AMTUNER_MODE_AM_RADIO = 4,
    AMTUNER_MODE_DSS = 8,
}

enum AMTunerEventType
{
    AMTUNER_EVENT_CHANGED = 1,
}

const GUID IID_IAMTuner = {0x211A8761, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]};
@GUID(0x211A8761, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]);
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

const GUID IID_IAMTunerNotification = {0x211A8760, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]};
@GUID(0x211A8760, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]);
interface IAMTunerNotification : IUnknown
{
    HRESULT OnEvent(AMTunerEventType Event);
}

const GUID IID_IAMTVTuner = {0x211A8766, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]};
@GUID(0x211A8766, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]);
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

const GUID IID_IBPCSatelliteTuner = {0x211A8765, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]};
@GUID(0x211A8765, 0x03AC, 0x11D1, [0x8D, 0x13, 0x00, 0xAA, 0x00, 0xBD, 0x83, 0x39]);
interface IBPCSatelliteTuner : IAMTuner
{
    HRESULT get_DefaultSubChannelTypes(int* plDefaultVideoType, int* plDefaultAudioType);
    HRESULT put_DefaultSubChannelTypes(int lDefaultVideoType, int lDefaultAudioType);
    HRESULT IsTapingPermitted();
}

enum TVAudioMode
{
    AMTVAUDIO_MODE_MONO = 1,
    AMTVAUDIO_MODE_STEREO = 2,
    AMTVAUDIO_MODE_LANG_A = 16,
    AMTVAUDIO_MODE_LANG_B = 32,
    AMTVAUDIO_MODE_LANG_C = 64,
    AMTVAUDIO_PRESET_STEREO = 512,
    AMTVAUDIO_PRESET_LANG_A = 4096,
    AMTVAUDIO_PRESET_LANG_B = 8192,
    AMTVAUDIO_PRESET_LANG_C = 16384,
}

enum AMTVAudioEventType
{
    AMTVAUDIO_EVENT_CHANGED = 1,
}

const GUID IID_IAMTVAudio = {0x83EC1C30, 0x23D1, 0x11D1, [0x99, 0xE6, 0x00, 0xA0, 0xC9, 0x56, 0x02, 0x66]};
@GUID(0x83EC1C30, 0x23D1, 0x11D1, [0x99, 0xE6, 0x00, 0xA0, 0xC9, 0x56, 0x02, 0x66]);
interface IAMTVAudio : IUnknown
{
    HRESULT GetHardwareSupportedTVAudioModes(int* plModes);
    HRESULT GetAvailableTVAudioModes(int* plModes);
    HRESULT get_TVAudioMode(int* plMode);
    HRESULT put_TVAudioMode(int lMode);
    HRESULT RegisterNotificationCallBack(IAMTunerNotification pNotify, int lEvents);
    HRESULT UnRegisterNotificationCallBack(IAMTunerNotification pNotify);
}

const GUID IID_IAMTVAudioNotification = {0x83EC1C33, 0x23D1, 0x11D1, [0x99, 0xE6, 0x00, 0xA0, 0xC9, 0x56, 0x02, 0x66]};
@GUID(0x83EC1C33, 0x23D1, 0x11D1, [0x99, 0xE6, 0x00, 0xA0, 0xC9, 0x56, 0x02, 0x66]);
interface IAMTVAudioNotification : IUnknown
{
    HRESULT OnEvent(AMTVAudioEventType Event);
}

const GUID IID_IAMAnalogVideoEncoder = {0xC6E133B0, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E133B0, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
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

enum AMPROPERTY_PIN
{
    AMPROPERTY_PIN_CATEGORY = 0,
    AMPROPERTY_PIN_MEDIUM = 1,
}

const GUID IID_IKsPropertySet = {0x31EFAC30, 0x515C, 0x11D0, [0xA9, 0xAA, 0x00, 0xAA, 0x00, 0x61, 0xBE, 0x93]};
@GUID(0x31EFAC30, 0x515C, 0x11D0, [0xA9, 0xAA, 0x00, 0xAA, 0x00, 0x61, 0xBE, 0x93]);
interface IKsPropertySet : IUnknown
{
    HRESULT Set(const(Guid)* guidPropSet, uint dwPropID, char* pInstanceData, uint cbInstanceData, char* pPropData, uint cbPropData);
    HRESULT Get(const(Guid)* guidPropSet, uint dwPropID, char* pInstanceData, uint cbInstanceData, char* pPropData, uint cbPropData, uint* pcbReturned);
    HRESULT QuerySupported(const(Guid)* guidPropSet, uint dwPropID, uint* pTypeSupport);
}

const GUID IID_IMediaPropertyBag = {0x6025A880, 0xC0D5, 0x11D0, [0xBD, 0x4E, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]};
@GUID(0x6025A880, 0xC0D5, 0x11D0, [0xBD, 0x4E, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]);
interface IMediaPropertyBag : IPropertyBag
{
    HRESULT EnumProperty(uint iProperty, VARIANT* pvarPropertyName, VARIANT* pvarPropertyValue);
}

const GUID IID_IPersistMediaPropertyBag = {0x5738E040, 0xB67F, 0x11D0, [0xBD, 0x4D, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]};
@GUID(0x5738E040, 0xB67F, 0x11D0, [0xBD, 0x4D, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]);
interface IPersistMediaPropertyBag : IPersist
{
    HRESULT InitNew();
    HRESULT Load(IMediaPropertyBag pPropBag, IErrorLog pErrorLog);
    HRESULT Save(IMediaPropertyBag pPropBag, BOOL fClearDirty, BOOL fSaveAllProperties);
}

const GUID IID_IAMPhysicalPinInfo = {0xF938C991, 0x3029, 0x11CF, [0x8C, 0x44, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0xF938C991, 0x3029, 0x11CF, [0x8C, 0x44, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
interface IAMPhysicalPinInfo : IUnknown
{
    HRESULT GetPhysicalType(int* pType, ushort** ppszType);
}

const GUID IID_IAMExtDevice = {0xB5730A90, 0x1A2C, 0x11CF, [0x8C, 0x23, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0xB5730A90, 0x1A2C, 0x11CF, [0x8C, 0x23, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
interface IAMExtDevice : IUnknown
{
    HRESULT GetCapability(int Capability, int* pValue, double* pdblValue);
    HRESULT get_ExternalDeviceID(ushort** ppszData);
    HRESULT get_ExternalDeviceVersion(ushort** ppszData);
    HRESULT put_DevicePower(int PowerMode);
    HRESULT get_DevicePower(int* pPowerMode);
    HRESULT Calibrate(uint hEvent, int Mode, int* pStatus);
    HRESULT put_DevicePort(int DevicePort);
    HRESULT get_DevicePort(int* pDevicePort);
}

const GUID IID_IAMExtTransport = {0xA03CD5F0, 0x3045, 0x11CF, [0x8C, 0x44, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0xA03CD5F0, 0x3045, 0x11CF, [0x8C, 0x44, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
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
    HRESULT GetChase(int* pEnabled, int* pOffset, uint* phEvent);
    HRESULT SetChase(int Enable, int Offset, uint hEvent);
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

const GUID IID_IAMTimecodeReader = {0x9B496CE1, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0x9B496CE1, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
interface IAMTimecodeReader : IUnknown
{
    HRESULT GetTCRMode(int Param, int* pValue);
    HRESULT SetTCRMode(int Param, int Value);
    HRESULT put_VITCLine(int Line);
    HRESULT get_VITCLine(int* pLine);
    HRESULT GetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
}

const GUID IID_IAMTimecodeGenerator = {0x9B496CE0, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0x9B496CE0, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
interface IAMTimecodeGenerator : IUnknown
{
    HRESULT GetTCGMode(int Param, int* pValue);
    HRESULT SetTCGMode(int Param, int Value);
    HRESULT put_VITCLine(int Line);
    HRESULT get_VITCLine(int* pLine);
    HRESULT SetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
    HRESULT GetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
}

const GUID IID_IAMTimecodeDisplay = {0x9B496CE2, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0x9B496CE2, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
interface IAMTimecodeDisplay : IUnknown
{
    HRESULT GetTCDisplayEnable(int* pState);
    HRESULT SetTCDisplayEnable(int State);
    HRESULT GetTCDisplay(int Param, int* pValue);
    HRESULT SetTCDisplay(int Param, int Value);
}

const GUID IID_IAMDevMemoryAllocator = {0xC6545BF0, 0xE76B, 0x11D0, [0xBD, 0x52, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]};
@GUID(0xC6545BF0, 0xE76B, 0x11D0, [0xBD, 0x52, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]);
interface IAMDevMemoryAllocator : IUnknown
{
    HRESULT GetInfo(uint* pdwcbTotalFree, uint* pdwcbLargestFree, uint* pdwcbTotalMemory, uint* pdwcbMinimumChunk);
    HRESULT CheckMemory(const(ubyte)* pBuffer);
    HRESULT Alloc(ubyte** ppBuffer, uint* pdwcbBuffer);
    HRESULT Free(ubyte* pBuffer);
    HRESULT GetDevMemoryObject(IUnknown* ppUnkInnner, IUnknown pUnkOuter);
}

const GUID IID_IAMDevMemoryControl = {0xC6545BF1, 0xE76B, 0x11D0, [0xBD, 0x52, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]};
@GUID(0xC6545BF1, 0xE76B, 0x11D0, [0xBD, 0x52, 0x00, 0xA0, 0xC9, 0x11, 0xCE, 0x86]);
interface IAMDevMemoryControl : IUnknown
{
    HRESULT QueryWriteSync();
    HRESULT WriteSync();
    HRESULT GetDevId(uint* pdwDevId);
}

enum _AMSTREAMSELECTINFOFLAGS
{
    AMSTREAMSELECTINFO_ENABLED = 1,
    AMSTREAMSELECTINFO_EXCLUSIVE = 2,
}

enum _AMSTREAMSELECTENABLEFLAGS
{
    AMSTREAMSELECTENABLE_ENABLE = 1,
    AMSTREAMSELECTENABLE_ENABLEALL = 2,
}

const GUID IID_IAMStreamSelect = {0xC1960960, 0x17F5, 0x11D1, [0xAB, 0xE1, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0xC1960960, 0x17F5, 0x11D1, [0xAB, 0xE1, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IAMStreamSelect : IUnknown
{
    HRESULT Count(uint* pcStreams);
    HRESULT Info(int lIndex, AM_MEDIA_TYPE** ppmt, uint* pdwFlags, uint* plcid, uint* pdwGroup, ushort** ppszName, IUnknown* ppObject, IUnknown* ppUnk);
    HRESULT Enable(int lIndex, uint dwFlags);
}

enum _AMRESCTL_RESERVEFLAGS
{
    AMRESCTL_RESERVEFLAGS_RESERVE = 0,
    AMRESCTL_RESERVEFLAGS_UNRESERVE = 1,
}

const GUID IID_IAMResourceControl = {0x8389D2D0, 0x77D7, 0x11D1, [0xAB, 0xE6, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0x8389D2D0, 0x77D7, 0x11D1, [0xAB, 0xE6, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IAMResourceControl : IUnknown
{
    HRESULT Reserve(uint dwFlags, void* pvReserved);
}

const GUID IID_IAMClockAdjust = {0x4D5466B0, 0xA49C, 0x11D1, [0xAB, 0xE8, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0x4D5466B0, 0xA49C, 0x11D1, [0xAB, 0xE8, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IAMClockAdjust : IUnknown
{
    HRESULT SetClockDelta(long rtDelta);
}

enum _AM_FILTER_MISC_FLAGS
{
    AM_FILTER_MISC_FLAGS_IS_RENDERER = 1,
    AM_FILTER_MISC_FLAGS_IS_SOURCE = 2,
}

const GUID IID_IAMFilterMiscFlags = {0x2DD74950, 0xA890, 0x11D1, [0xAB, 0xE8, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0x2DD74950, 0xA890, 0x11D1, [0xAB, 0xE8, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IAMFilterMiscFlags : IUnknown
{
    uint GetMiscFlags();
}

const GUID IID_IDrawVideoImage = {0x48EFB120, 0xAB49, 0x11D2, [0xAE, 0xD2, 0x00, 0xA0, 0xC9, 0x95, 0xE8, 0xD5]};
@GUID(0x48EFB120, 0xAB49, 0x11D2, [0xAE, 0xD2, 0x00, 0xA0, 0xC9, 0x95, 0xE8, 0xD5]);
interface IDrawVideoImage : IUnknown
{
    HRESULT DrawVideoImageBegin();
    HRESULT DrawVideoImageEnd();
    HRESULT DrawVideoImageDraw(HDC hdc, RECT* lprcSrc, RECT* lprcDst);
}

const GUID IID_IDecimateVideoImage = {0x2E5EA3E0, 0xE924, 0x11D2, [0xB6, 0xDA, 0x00, 0xA0, 0xC9, 0x95, 0xE8, 0xDF]};
@GUID(0x2E5EA3E0, 0xE924, 0x11D2, [0xB6, 0xDA, 0x00, 0xA0, 0xC9, 0x95, 0xE8, 0xDF]);
interface IDecimateVideoImage : IUnknown
{
    HRESULT SetDecimationImageSize(int lWidth, int lHeight);
    HRESULT ResetDecimationImageSize();
}

enum DECIMATION_USAGE
{
    DECIMATION_LEGACY = 0,
    DECIMATION_USE_DECODER_ONLY = 1,
    DECIMATION_USE_VIDEOPORT_ONLY = 2,
    DECIMATION_USE_OVERLAY_ONLY = 3,
    DECIMATION_DEFAULT = 4,
}

const GUID IID_IAMVideoDecimationProperties = {0x60D32930, 0x13DA, 0x11D3, [0x9E, 0xC6, 0xC4, 0xFC, 0xAE, 0xF5, 0xC7, 0xBE]};
@GUID(0x60D32930, 0x13DA, 0x11D3, [0x9E, 0xC6, 0xC4, 0xFC, 0xAE, 0xF5, 0xC7, 0xBE]);
interface IAMVideoDecimationProperties : IUnknown
{
    HRESULT QueryDecimationUsage(DECIMATION_USAGE* lpUsage);
    HRESULT SetDecimationUsage(DECIMATION_USAGE Usage);
}

const GUID IID_IVideoFrameStep = {0xE46A9787, 0x2B71, 0x444D, [0xA4, 0xB5, 0x1F, 0xAB, 0x7B, 0x70, 0x8D, 0x6A]};
@GUID(0xE46A9787, 0x2B71, 0x444D, [0xA4, 0xB5, 0x1F, 0xAB, 0x7B, 0x70, 0x8D, 0x6A]);
interface IVideoFrameStep : IUnknown
{
    HRESULT Step(uint dwFrames, IUnknown pStepObject);
    HRESULT CanStep(int bMultiple, IUnknown pStepObject);
    HRESULT CancelStep();
}

enum _AM_PUSHSOURCE_FLAGS
{
    AM_PUSHSOURCECAPS_INTERNAL_RM = 1,
    AM_PUSHSOURCECAPS_NOT_LIVE = 2,
    AM_PUSHSOURCECAPS_PRIVATE_CLOCK = 4,
    AM_PUSHSOURCEREQS_USE_STREAM_CLOCK = 65536,
    AM_PUSHSOURCEREQS_USE_CLOCK_CHAIN = 131072,
}

const GUID IID_IAMLatency = {0x62EA93BA, 0xEC62, 0x11D2, [0xB7, 0x70, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]};
@GUID(0x62EA93BA, 0xEC62, 0x11D2, [0xB7, 0x70, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]);
interface IAMLatency : IUnknown
{
    HRESULT GetLatency(long* prtLatency);
}

const GUID IID_IAMPushSource = {0xF185FE76, 0xE64E, 0x11D2, [0xB7, 0x6E, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]};
@GUID(0xF185FE76, 0xE64E, 0x11D2, [0xB7, 0x6E, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]);
interface IAMPushSource : IAMLatency
{
    HRESULT GetPushSourceFlags(uint* pFlags);
    HRESULT SetPushSourceFlags(uint Flags);
    HRESULT SetStreamOffset(long rtOffset);
    HRESULT GetStreamOffset(long* prtOffset);
    HRESULT GetMaxStreamOffset(long* prtMaxOffset);
    HRESULT SetMaxStreamOffset(long rtMaxOffset);
}

const GUID IID_IAMDeviceRemoval = {0xF90A6130, 0xB658, 0x11D2, [0xAE, 0x49, 0x00, 0x00, 0xF8, 0x75, 0x4B, 0x99]};
@GUID(0xF90A6130, 0xB658, 0x11D2, [0xAE, 0x49, 0x00, 0x00, 0xF8, 0x75, 0x4B, 0x99]);
interface IAMDeviceRemoval : IUnknown
{
    HRESULT DeviceInfo(Guid* pclsidInterfaceClass, ushort** pwszSymbolicLink);
    HRESULT Reassociate();
    HRESULT Disassociate();
}

struct DVINFO
{
    uint dwDVAAuxSrc;
    uint dwDVAAuxCtl;
    uint dwDVAAuxSrc1;
    uint dwDVAAuxCtl1;
    uint dwDVVAuxSrc;
    uint dwDVVAuxCtl;
    uint dwDVReserved;
}

enum _DVENCODERRESOLUTION
{
    DVENCODERRESOLUTION_720x480 = 2012,
    DVENCODERRESOLUTION_360x240 = 2013,
    DVENCODERRESOLUTION_180x120 = 2014,
    DVENCODERRESOLUTION_88x60 = 2015,
}

enum _DVENCODERVIDEOFORMAT
{
    DVENCODERVIDEOFORMAT_NTSC = 2000,
    DVENCODERVIDEOFORMAT_PAL = 2001,
}

enum _DVENCODERFORMAT
{
    DVENCODERFORMAT_DVSD = 2007,
    DVENCODERFORMAT_DVHD = 2008,
    DVENCODERFORMAT_DVSL = 2009,
}

const GUID IID_IDVEnc = {0xD18E17A0, 0xAACB, 0x11D0, [0xAF, 0xB0, 0x00, 0xAA, 0x00, 0xB6, 0x7A, 0x42]};
@GUID(0xD18E17A0, 0xAACB, 0x11D0, [0xAF, 0xB0, 0x00, 0xAA, 0x00, 0xB6, 0x7A, 0x42]);
interface IDVEnc : IUnknown
{
    HRESULT get_IFormatResolution(int* VideoFormat, int* DVFormat, int* Resolution, ubyte fDVInfo, DVINFO* sDVInfo);
    HRESULT put_IFormatResolution(int VideoFormat, int DVFormat, int Resolution, ubyte fDVInfo, DVINFO* sDVInfo);
}

enum _DVDECODERRESOLUTION
{
    DVDECODERRESOLUTION_720x480 = 1000,
    DVDECODERRESOLUTION_360x240 = 1001,
    DVDECODERRESOLUTION_180x120 = 1002,
    DVDECODERRESOLUTION_88x60 = 1003,
}

enum _DVRESOLUTION
{
    DVRESOLUTION_FULL = 1000,
    DVRESOLUTION_HALF = 1001,
    DVRESOLUTION_QUARTER = 1002,
    DVRESOLUTION_DC = 1003,
}

const GUID IID_IIPDVDec = {0xB8E8BD60, 0x0BFE, 0x11D0, [0xAF, 0x91, 0x00, 0xAA, 0x00, 0xB6, 0x7A, 0x42]};
@GUID(0xB8E8BD60, 0x0BFE, 0x11D0, [0xAF, 0x91, 0x00, 0xAA, 0x00, 0xB6, 0x7A, 0x42]);
interface IIPDVDec : IUnknown
{
    HRESULT get_IPDisplay(int* displayPix);
    HRESULT put_IPDisplay(int displayPix);
}

const GUID IID_IDVRGB219 = {0x58473A19, 0x2BC8, 0x4663, [0x80, 0x12, 0x25, 0xF8, 0x1B, 0xAB, 0xDD, 0xD1]};
@GUID(0x58473A19, 0x2BC8, 0x4663, [0x80, 0x12, 0x25, 0xF8, 0x1B, 0xAB, 0xDD, 0xD1]);
interface IDVRGB219 : IUnknown
{
    HRESULT SetRGB219(BOOL bState);
}

const GUID IID_IDVSplitter = {0x92A3A302, 0xDA7C, 0x4A1F, [0xBA, 0x7E, 0x18, 0x02, 0xBB, 0x5D, 0x2D, 0x02]};
@GUID(0x92A3A302, 0xDA7C, 0x4A1F, [0xBA, 0x7E, 0x18, 0x02, 0xBB, 0x5D, 0x2D, 0x02]);
interface IDVSplitter : IUnknown
{
    HRESULT DiscardAlternateVideoFrames(int nDiscard);
}

enum _AM_AUDIO_RENDERER_STAT_PARAM
{
    AM_AUDREND_STAT_PARAM_BREAK_COUNT = 1,
    AM_AUDREND_STAT_PARAM_SLAVE_MODE = 2,
    AM_AUDREND_STAT_PARAM_SILENCE_DUR = 3,
    AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR = 4,
    AM_AUDREND_STAT_PARAM_DISCONTINUITIES = 5,
    AM_AUDREND_STAT_PARAM_SLAVE_RATE = 6,
    AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR = 7,
    AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR = 8,
    AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR = 9,
    AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR = 10,
    AM_AUDREND_STAT_PARAM_BUFFERFULLNESS = 11,
    AM_AUDREND_STAT_PARAM_JITTER = 12,
}

const GUID IID_IAMAudioRendererStats = {0x22320CB2, 0xD41A, 0x11D2, [0xBF, 0x7C, 0xD7, 0xCB, 0x9D, 0xF0, 0xBF, 0x93]};
@GUID(0x22320CB2, 0xD41A, 0x11D2, [0xBF, 0x7C, 0xD7, 0xCB, 0x9D, 0xF0, 0xBF, 0x93]);
interface IAMAudioRendererStats : IUnknown
{
    HRESULT GetStatParam(uint dwParam, uint* pdwParam1, uint* pdwParam2);
}

enum _AM_INTF_SEARCH_FLAGS
{
    AM_INTF_SEARCH_INPUT_PIN = 1,
    AM_INTF_SEARCH_OUTPUT_PIN = 2,
    AM_INTF_SEARCH_FILTER = 4,
}

const GUID IID_IAMGraphStreams = {0x632105FA, 0x072E, 0x11D3, [0x8A, 0xF9, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]};
@GUID(0x632105FA, 0x072E, 0x11D3, [0x8A, 0xF9, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]);
interface IAMGraphStreams : IUnknown
{
    HRESULT FindUpstreamInterface(IPin pPin, const(Guid)* riid, void** ppvInterface, uint dwFlags);
    HRESULT SyncUsingStreamOffset(BOOL bUseStreamOffset);
    HRESULT SetMaxGraphLatency(long rtMaxGraphLatency);
}

enum AMOVERLAYFX
{
    AMOVERFX_NOFX = 0,
    AMOVERFX_MIRRORLEFTRIGHT = 2,
    AMOVERFX_MIRRORUPDOWN = 4,
    AMOVERFX_DEINTERLACE = 8,
}

const GUID IID_IAMOverlayFX = {0x62FAE250, 0x7E65, 0x4460, [0xBF, 0xC9, 0x63, 0x98, 0xB3, 0x22, 0x07, 0x3C]};
@GUID(0x62FAE250, 0x7E65, 0x4460, [0xBF, 0xC9, 0x63, 0x98, 0xB3, 0x22, 0x07, 0x3C]);
interface IAMOverlayFX : IUnknown
{
    HRESULT QueryOverlayFXCaps(uint* lpdwOverlayFXCaps);
    HRESULT SetOverlayFX(uint dwOverlayFX);
    HRESULT GetOverlayFX(uint* lpdwOverlayFX);
}

const GUID IID_IAMOpenProgress = {0x8E1C39A1, 0xDE53, 0x11CF, [0xAA, 0x63, 0x00, 0x80, 0xC7, 0x44, 0x52, 0x8D]};
@GUID(0x8E1C39A1, 0xDE53, 0x11CF, [0xAA, 0x63, 0x00, 0x80, 0xC7, 0x44, 0x52, 0x8D]);
interface IAMOpenProgress : IUnknown
{
    HRESULT QueryProgress(long* pllTotal, long* pllCurrent);
    HRESULT AbortOperation();
}

const GUID IID_IMpeg2Demultiplexer = {0x436EEE9C, 0x264F, 0x4242, [0x90, 0xE1, 0x4E, 0x33, 0x0C, 0x10, 0x75, 0x12]};
@GUID(0x436EEE9C, 0x264F, 0x4242, [0x90, 0xE1, 0x4E, 0x33, 0x0C, 0x10, 0x75, 0x12]);
interface IMpeg2Demultiplexer : IUnknown
{
    HRESULT CreateOutputPin(AM_MEDIA_TYPE* pMediaType, const(wchar)* pszPinName, IPin* ppIPin);
    HRESULT SetOutputPinMediaType(const(wchar)* pszPinName, AM_MEDIA_TYPE* pMediaType);
    HRESULT DeleteOutputPin(const(wchar)* pszPinName);
}

struct STREAM_ID_MAP
{
    uint stream_id;
    uint dwMediaSampleContent;
    uint ulSubstreamFilterValue;
    int iDataOffset;
}

const GUID IID_IEnumStreamIdMap = {0x945C1566, 0x6202, 0x46FC, [0x96, 0xC7, 0xD8, 0x7F, 0x28, 0x9C, 0x65, 0x34]};
@GUID(0x945C1566, 0x6202, 0x46FC, [0x96, 0xC7, 0xD8, 0x7F, 0x28, 0x9C, 0x65, 0x34]);
interface IEnumStreamIdMap : IUnknown
{
    HRESULT Next(uint cRequest, char* pStreamIdMap, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(IEnumStreamIdMap* ppIEnumStreamIdMap);
}

const GUID IID_IMPEG2StreamIdMap = {0xD0E04C47, 0x25B8, 0x4369, [0x92, 0x5A, 0x36, 0x2A, 0x01, 0xD9, 0x54, 0x44]};
@GUID(0xD0E04C47, 0x25B8, 0x4369, [0x92, 0x5A, 0x36, 0x2A, 0x01, 0xD9, 0x54, 0x44]);
interface IMPEG2StreamIdMap : IUnknown
{
    HRESULT MapStreamId(uint ulStreamId, uint MediaSampleContent, uint ulSubstreamFilterValue, int iDataOffset);
    HRESULT UnmapStreamId(uint culStreamId, char* pulStreamId);
    HRESULT EnumStreamIdMap(IEnumStreamIdMap* ppIEnumStreamIdMap);
}

const GUID IID_IRegisterServiceProvider = {0x7B3A2F01, 0x0751, 0x48DD, [0xB5, 0x56, 0x00, 0x47, 0x85, 0x17, 0x1C, 0x54]};
@GUID(0x7B3A2F01, 0x0751, 0x48DD, [0xB5, 0x56, 0x00, 0x47, 0x85, 0x17, 0x1C, 0x54]);
interface IRegisterServiceProvider : IUnknown
{
    HRESULT RegisterService(const(Guid)* guidService, IUnknown pUnkObject);
}

const GUID IID_IAMClockSlave = {0x9FD52741, 0x176D, 0x4B36, [0x8F, 0x51, 0xCA, 0x8F, 0x93, 0x32, 0x23, 0xBE]};
@GUID(0x9FD52741, 0x176D, 0x4B36, [0x8F, 0x51, 0xCA, 0x8F, 0x93, 0x32, 0x23, 0xBE]);
interface IAMClockSlave : IUnknown
{
    HRESULT SetErrorTolerance(uint dwTolerance);
    HRESULT GetErrorTolerance(uint* pdwTolerance);
}

const GUID IID_IAMGraphBuilderCallback = {0x4995F511, 0x9DDB, 0x4F12, [0xBD, 0x3B, 0xF0, 0x46, 0x11, 0x80, 0x7B, 0x79]};
@GUID(0x4995F511, 0x9DDB, 0x4F12, [0xBD, 0x3B, 0xF0, 0x46, 0x11, 0x80, 0x7B, 0x79]);
interface IAMGraphBuilderCallback : IUnknown
{
    HRESULT SelectedFilter(IMoniker pMon);
    HRESULT CreatedFilter(IBaseFilter pFil);
}

interface IAMFilterGraphCallback : IUnknown
{
    HRESULT UnableToRender(IPin pPin);
}

const GUID IID_IGetCapabilitiesKey = {0xA8809222, 0x07BB, 0x48EA, [0x95, 0x1C, 0x33, 0x15, 0x81, 0x00, 0x62, 0x5B]};
@GUID(0xA8809222, 0x07BB, 0x48EA, [0x95, 0x1C, 0x33, 0x15, 0x81, 0x00, 0x62, 0x5B]);
interface IGetCapabilitiesKey : IUnknown
{
    HRESULT GetCapabilitiesKey(HKEY* pHKey);
}

const GUID IID_IEncoderAPI = {0x70423839, 0x6ACC, 0x4B23, [0xB0, 0x79, 0x21, 0xDB, 0xF0, 0x81, 0x56, 0xA5]};
@GUID(0x70423839, 0x6ACC, 0x4B23, [0xB0, 0x79, 0x21, 0xDB, 0xF0, 0x81, 0x56, 0xA5]);
interface IEncoderAPI : IUnknown
{
    HRESULT IsSupported(const(Guid)* Api);
    HRESULT IsAvailable(const(Guid)* Api);
    HRESULT GetParameterRange(const(Guid)* Api, VARIANT* ValueMin, VARIANT* ValueMax, VARIANT* SteppingDelta);
    HRESULT GetParameterValues(const(Guid)* Api, char* Values, uint* ValuesCount);
    HRESULT GetDefaultValue(const(Guid)* Api, VARIANT* Value);
    HRESULT GetValue(const(Guid)* Api, VARIANT* Value);
    HRESULT SetValue(const(Guid)* Api, VARIANT* Value);
}

const GUID IID_IVideoEncoder = {0x02997C3B, 0x8E1B, 0x460E, [0x92, 0x70, 0x54, 0x5E, 0x0D, 0xE9, 0x56, 0x3E]};
@GUID(0x02997C3B, 0x8E1B, 0x460E, [0x92, 0x70, 0x54, 0x5E, 0x0D, 0xE9, 0x56, 0x3E]);
interface IVideoEncoder : IEncoderAPI
{
}

const GUID IID_IAMDecoderCaps = {0xC0DFF467, 0xD499, 0x4986, [0x97, 0x2B, 0xE1, 0xD9, 0x09, 0x0F, 0xA9, 0x41]};
@GUID(0xC0DFF467, 0xD499, 0x4986, [0x97, 0x2B, 0xE1, 0xD9, 0x09, 0x0F, 0xA9, 0x41]);
interface IAMDecoderCaps : IUnknown
{
    HRESULT GetDecoderCaps(uint dwCapIndex, uint* lpdwCap);
}

struct AMCOPPSignature
{
    ubyte Signature;
}

struct AMCOPPCommand
{
    Guid macKDI;
    Guid guidCommandID;
    uint dwSequence;
    uint cbSizeData;
    ubyte CommandData;
}

struct AMCOPPStatusInput
{
    Guid rApp;
    Guid guidStatusRequestID;
    uint dwSequence;
    uint cbSizeData;
    ubyte StatusData;
}

struct AMCOPPStatusOutput
{
    Guid macKDI;
    uint cbSizeData;
    ubyte COPPStatus;
}

const GUID IID_IAMCertifiedOutputProtection = {0x6FEDED3E, 0x0FF1, 0x4901, [0xA2, 0xF1, 0x43, 0xF7, 0x01, 0x2C, 0x85, 0x15]};
@GUID(0x6FEDED3E, 0x0FF1, 0x4901, [0xA2, 0xF1, 0x43, 0xF7, 0x01, 0x2C, 0x85, 0x15]);
interface IAMCertifiedOutputProtection : IUnknown
{
    HRESULT KeyExchange(Guid* pRandom, ubyte** VarLenCertGH, uint* pdwLengthCertGH);
    HRESULT SessionSequenceStart(AMCOPPSignature* pSig);
    HRESULT ProtectionCommand(const(AMCOPPCommand)* cmd);
    HRESULT ProtectionStatus(const(AMCOPPStatusInput)* pStatusInput, AMCOPPStatusOutput* pStatusOutput);
}

const GUID IID_IAMAsyncReaderTimestampScaling = {0xCF7B26FC, 0x9A00, 0x485B, [0x81, 0x47, 0x3E, 0x78, 0x9D, 0x5E, 0x8F, 0x67]};
@GUID(0xCF7B26FC, 0x9A00, 0x485B, [0x81, 0x47, 0x3E, 0x78, 0x9D, 0x5E, 0x8F, 0x67]);
interface IAMAsyncReaderTimestampScaling : IUnknown
{
    HRESULT GetTimestampMode(int* pfRaw);
    HRESULT SetTimestampMode(BOOL fRaw);
}

const GUID IID_IAMPluginControl = {0x0E26A181, 0xF40C, 0x4635, [0x87, 0x86, 0x97, 0x62, 0x84, 0xB5, 0x29, 0x81]};
@GUID(0x0E26A181, 0xF40C, 0x4635, [0x87, 0x86, 0x97, 0x62, 0x84, 0xB5, 0x29, 0x81]);
interface IAMPluginControl : IUnknown
{
    HRESULT GetPreferredClsid(const(Guid)* subType, Guid* clsid);
    HRESULT GetPreferredClsidByIndex(uint index, Guid* subType, Guid* clsid);
    HRESULT SetPreferredClsid(const(Guid)* subType, const(Guid)* clsid);
    HRESULT IsDisabled(const(Guid)* clsid);
    HRESULT GetDisabledByIndex(uint index, Guid* clsid);
    HRESULT SetDisabled(const(Guid)* clsid, BOOL disabled);
    HRESULT IsLegacyDisabled(const(wchar)* dllName);
}

const GUID IID_IPinConnection = {0x4A9A62D3, 0x27D4, 0x403D, [0x91, 0xE9, 0x89, 0xF5, 0x40, 0xE5, 0x55, 0x34]};
@GUID(0x4A9A62D3, 0x27D4, 0x403D, [0x91, 0xE9, 0x89, 0xF5, 0x40, 0xE5, 0x55, 0x34]);
interface IPinConnection : IUnknown
{
    HRESULT DynamicQueryAccept(const(AM_MEDIA_TYPE)* pmt);
    HRESULT NotifyEndOfStream(HANDLE hNotifyEvent);
    HRESULT IsEndPin();
    HRESULT DynamicDisconnect();
}

const GUID IID_IPinFlowControl = {0xC56E9858, 0xDBF3, 0x4F6B, [0x81, 0x19, 0x38, 0x4A, 0xF2, 0x06, 0x0D, 0xEB]};
@GUID(0xC56E9858, 0xDBF3, 0x4F6B, [0x81, 0x19, 0x38, 0x4A, 0xF2, 0x06, 0x0D, 0xEB]);
interface IPinFlowControl : IUnknown
{
    HRESULT Block(uint dwBlockFlags, HANDLE hEvent);
}

enum _AM_PIN_FLOW_CONTROL_BLOCK_FLAGS
{
    AM_PIN_FLOW_CONTROL_BLOCK = 1,
}

enum AM_GRAPH_CONFIG_RECONNECT_FLAGS
{
    AM_GRAPH_CONFIG_RECONNECT_DIRECTCONNECT = 1,
    AM_GRAPH_CONFIG_RECONNECT_CACHE_REMOVED_FILTERS = 2,
    AM_GRAPH_CONFIG_RECONNECT_USE_ONLY_CACHED_FILTERS = 4,
}

enum _REM_FILTER_FLAGS
{
    REMFILTERF_LEAVECONNECTED = 1,
}

enum AM_FILTER_FLAGS
{
    AM_FILTER_FLAGS_REMOVABLE = 1,
}

const GUID IID_IGraphConfig = {0x03A1EB8E, 0x32BF, 0x4245, [0x85, 0x02, 0x11, 0x4D, 0x08, 0xA9, 0xCB, 0x88]};
@GUID(0x03A1EB8E, 0x32BF, 0x4245, [0x85, 0x02, 0x11, 0x4D, 0x08, 0xA9, 0xCB, 0x88]);
interface IGraphConfig : IUnknown
{
    HRESULT Reconnect(IPin pOutputPin, IPin pInputPin, const(AM_MEDIA_TYPE)* pmtFirstConnection, IBaseFilter pUsingFilter, HANDLE hAbortEvent, uint dwFlags);
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

const GUID IID_IGraphConfigCallback = {0xADE0FD60, 0xD19D, 0x11D2, [0xAB, 0xF6, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0xADE0FD60, 0xD19D, 0x11D2, [0xAB, 0xF6, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IGraphConfigCallback : IUnknown
{
    HRESULT Reconfigure(void* pvContext, uint dwFlags);
}

const GUID IID_IFilterChain = {0xDCFBDCF6, 0x0DC2, 0x45F5, [0x9A, 0xB2, 0x7C, 0x33, 0x0E, 0xA0, 0x9C, 0x29]};
@GUID(0xDCFBDCF6, 0x0DC2, 0x45F5, [0x9A, 0xB2, 0x7C, 0x33, 0x0E, 0xA0, 0x9C, 0x29]);
interface IFilterChain : IUnknown
{
    HRESULT StartChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    HRESULT PauseChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    HRESULT StopChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    HRESULT RemoveChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
}

enum VMRPresentationFlags
{
    VMRSample_SyncPoint = 1,
    VMRSample_Preroll = 2,
    VMRSample_Discontinuity = 4,
    VMRSample_TimeValid = 8,
    VMRSample_SrcDstRectsValid = 16,
}

struct VMRPRESENTATIONINFO
{
    uint dwFlags;
    IDirectDrawSurface7 lpSurf;
    long rtStart;
    long rtEnd;
    SIZE szAspectRatio;
    RECT rcSrc;
    RECT rcDst;
    uint dwTypeSpecificFlags;
    uint dwInterlaceFlags;
}

const GUID IID_IVMRImagePresenter = {0xCE704FE7, 0xE71E, 0x41FB, [0xBA, 0xA2, 0xC4, 0x40, 0x3E, 0x11, 0x82, 0xF5]};
@GUID(0xCE704FE7, 0xE71E, 0x41FB, [0xBA, 0xA2, 0xC4, 0x40, 0x3E, 0x11, 0x82, 0xF5]);
interface IVMRImagePresenter : IUnknown
{
    HRESULT StartPresenting(uint dwUserID);
    HRESULT StopPresenting(uint dwUserID);
    HRESULT PresentImage(uint dwUserID, VMRPRESENTATIONINFO* lpPresInfo);
}

enum VMRSurfaceAllocationFlags
{
    AMAP_PIXELFORMAT_VALID = 1,
    AMAP_3D_TARGET = 2,
    AMAP_ALLOW_SYSMEM = 4,
    AMAP_FORCE_SYSMEM = 8,
    AMAP_DIRECTED_FLIP = 16,
    AMAP_DXVA_TARGET = 32,
}

struct VMRALLOCATIONINFO
{
    uint dwFlags;
    BITMAPINFOHEADER* lpHdr;
    DDPIXELFORMAT* lpPixFmt;
    SIZE szAspectRatio;
    uint dwMinBuffers;
    uint dwMaxBuffers;
    uint dwInterlaceFlags;
    SIZE szNativeSize;
}

const GUID IID_IVMRSurfaceAllocator = {0x31CE832E, 0x4484, 0x458B, [0x8C, 0xCA, 0xF4, 0xD7, 0xE3, 0xDB, 0x0B, 0x52]};
@GUID(0x31CE832E, 0x4484, 0x458B, [0x8C, 0xCA, 0xF4, 0xD7, 0xE3, 0xDB, 0x0B, 0x52]);
interface IVMRSurfaceAllocator : IUnknown
{
    HRESULT AllocateSurface(uint dwUserID, VMRALLOCATIONINFO* lpAllocInfo, uint* lpdwActualBuffers, IDirectDrawSurface7* lplpSurface);
    HRESULT FreeSurface(uint dwID);
    HRESULT PrepareSurface(uint dwUserID, IDirectDrawSurface7 lpSurface, uint dwSurfaceFlags);
    HRESULT AdviseNotify(IVMRSurfaceAllocatorNotify lpIVMRSurfAllocNotify);
}

const GUID IID_IVMRSurfaceAllocatorNotify = {0xAADA05A8, 0x5A4E, 0x4729, [0xAF, 0x0B, 0xCE, 0xA2, 0x7A, 0xED, 0x51, 0xE2]};
@GUID(0xAADA05A8, 0x5A4E, 0x4729, [0xAF, 0x0B, 0xCE, 0xA2, 0x7A, 0xED, 0x51, 0xE2]);
interface IVMRSurfaceAllocatorNotify : IUnknown
{
    HRESULT AdviseSurfaceAllocator(uint dwUserID, IVMRSurfaceAllocator lpIVRMSurfaceAllocator);
    HRESULT SetDDrawDevice(IDirectDraw7 lpDDrawDevice, int hMonitor);
    HRESULT ChangeDDrawDevice(IDirectDraw7 lpDDrawDevice, int hMonitor);
    HRESULT RestoreDDrawSurfaces();
    HRESULT NotifyEvent(int EventCode, int Param1, int Param2);
    HRESULT SetBorderColor(uint clrBorder);
}

enum VMR_ASPECT_RATIO_MODE
{
    VMR_ARMODE_NONE = 0,
    VMR_ARMODE_LETTER_BOX = 1,
}

const GUID IID_IVMRWindowlessControl = {0x0EB1088C, 0x4DCD, 0x46F0, [0x87, 0x8F, 0x39, 0xDA, 0xE8, 0x6A, 0x51, 0xB7]};
@GUID(0x0EB1088C, 0x4DCD, 0x46F0, [0x87, 0x8F, 0x39, 0xDA, 0xE8, 0x6A, 0x51, 0xB7]);
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

enum VMRMixerPrefs
{
    MixerPref_NoDecimation = 1,
    MixerPref_DecimateOutput = 2,
    MixerPref_ARAdjustXorY = 4,
    MixerPref_DecimationReserved = 8,
    MixerPref_DecimateMask = 15,
    MixerPref_BiLinearFiltering = 16,
    MixerPref_PointFiltering = 32,
    MixerPref_FilteringMask = 240,
    MixerPref_RenderTargetRGB = 256,
    MixerPref_RenderTargetYUV = 4096,
    MixerPref_RenderTargetYUV420 = 512,
    MixerPref_RenderTargetYUV422 = 1024,
    MixerPref_RenderTargetYUV444 = 2048,
    MixerPref_RenderTargetReserved = 57344,
    MixerPref_RenderTargetMask = 65280,
    MixerPref_DynamicSwitchToBOB = 65536,
    MixerPref_DynamicDecimateBy2 = 131072,
    MixerPref_DynamicReserved = 786432,
    MixerPref_DynamicMask = 983040,
}

struct NORMALIZEDRECT
{
    float left;
    float top;
    float right;
    float bottom;
}

const GUID IID_IVMRMixerControl = {0x1C1A17B0, 0xBED0, 0x415D, [0x97, 0x4B, 0xDC, 0x66, 0x96, 0x13, 0x15, 0x99]};
@GUID(0x1C1A17B0, 0xBED0, 0x415D, [0x97, 0x4B, 0xDC, 0x66, 0x96, 0x13, 0x15, 0x99]);
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

struct VMRGUID
{
    Guid* pGUID;
    Guid GUID;
}

struct VMRMONITORINFO
{
    VMRGUID guid;
    RECT rcMonitor;
    int hMon;
    uint dwFlags;
    ushort szDevice;
    ushort szDescription;
    LARGE_INTEGER liDriverVersion;
    uint dwVendorId;
    uint dwDeviceId;
    uint dwSubSysId;
    uint dwRevision;
}

const GUID IID_IVMRMonitorConfig = {0x9CF0B1B6, 0xFBAA, 0x4B7F, [0x88, 0xCF, 0xCF, 0x1F, 0x13, 0x0A, 0x0D, 0xCE]};
@GUID(0x9CF0B1B6, 0xFBAA, 0x4B7F, [0x88, 0xCF, 0xCF, 0x1F, 0x13, 0x0A, 0x0D, 0xCE]);
interface IVMRMonitorConfig : IUnknown
{
    HRESULT SetMonitor(const(VMRGUID)* pGUID);
    HRESULT GetMonitor(VMRGUID* pGUID);
    HRESULT SetDefaultMonitor(const(VMRGUID)* pGUID);
    HRESULT GetDefaultMonitor(VMRGUID* pGUID);
    HRESULT GetAvailableMonitors(VMRMONITORINFO* pInfo, uint dwMaxInfoArraySize, uint* pdwNumDevices);
}

enum VMRRenderPrefs
{
    RenderPrefs_RestrictToInitialMonitor = 0,
    RenderPrefs_ForceOffscreen = 1,
    RenderPrefs_ForceOverlays = 2,
    RenderPrefs_AllowOverlays = 0,
    RenderPrefs_AllowOffscreen = 0,
    RenderPrefs_DoNotRenderColorKeyAndBorder = 8,
    RenderPrefs_Reserved = 16,
    RenderPrefs_PreferAGPMemWhenMixing = 32,
    RenderPrefs_Mask = 63,
}

enum VMRMode
{
    VMRMode_Windowed = 1,
    VMRMode_Windowless = 2,
    VMRMode_Renderless = 4,
    VMRMode_Mask = 7,
}

enum __MIDL___MIDL_itf_strmif_0000_0122_0001
{
    MAX_NUMBER_OF_STREAMS = 16,
}

const GUID IID_IVMRFilterConfig = {0x9E5530C5, 0x7034, 0x48B4, [0xBB, 0x46, 0x0B, 0x8A, 0x6E, 0xFC, 0x8E, 0x36]};
@GUID(0x9E5530C5, 0x7034, 0x48B4, [0xBB, 0x46, 0x0B, 0x8A, 0x6E, 0xFC, 0x8E, 0x36]);
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

const GUID IID_IVMRAspectRatioControl = {0xEDE80B5C, 0xBAD6, 0x4623, [0xB5, 0x37, 0x65, 0x58, 0x6C, 0x9F, 0x8D, 0xFD]};
@GUID(0xEDE80B5C, 0xBAD6, 0x4623, [0xB5, 0x37, 0x65, 0x58, 0x6C, 0x9F, 0x8D, 0xFD]);
interface IVMRAspectRatioControl : IUnknown
{
    HRESULT GetAspectRatioMode(uint* lpdwARMode);
    HRESULT SetAspectRatioMode(uint dwARMode);
}

enum VMRDeinterlacePrefs
{
    DeinterlacePref_NextBest = 1,
    DeinterlacePref_BOB = 2,
    DeinterlacePref_Weave = 4,
    DeinterlacePref_Mask = 7,
}

enum VMRDeinterlaceTech
{
    DeinterlaceTech_Unknown = 0,
    DeinterlaceTech_BOBLineReplicate = 1,
    DeinterlaceTech_BOBVerticalStretch = 2,
    DeinterlaceTech_MedianFiltering = 4,
    DeinterlaceTech_EdgeFiltering = 16,
    DeinterlaceTech_FieldAdaptive = 32,
    DeinterlaceTech_PixelAdaptive = 64,
    DeinterlaceTech_MotionVectorSteered = 128,
}

struct VMRFrequency
{
    uint dwNumerator;
    uint dwDenominator;
}

struct VMRVideoDesc
{
    uint dwSize;
    uint dwSampleWidth;
    uint dwSampleHeight;
    BOOL SingleFieldPerSample;
    uint dwFourCC;
    VMRFrequency InputSampleFreq;
    VMRFrequency OutputFrameFreq;
}

struct VMRDeinterlaceCaps
{
    uint dwSize;
    uint dwNumPreviousOutputFrames;
    uint dwNumForwardRefSamples;
    uint dwNumBackwardRefSamples;
    VMRDeinterlaceTech DeinterlaceTechnology;
}

const GUID IID_IVMRDeinterlaceControl = {0xBB057577, 0x0DB8, 0x4E6A, [0x87, 0xA7, 0x1A, 0x8C, 0x9A, 0x50, 0x5A, 0x0F]};
@GUID(0xBB057577, 0x0DB8, 0x4E6A, [0x87, 0xA7, 0x1A, 0x8C, 0x9A, 0x50, 0x5A, 0x0F]);
interface IVMRDeinterlaceControl : IUnknown
{
    HRESULT GetNumberOfDeinterlaceModes(VMRVideoDesc* lpVideoDescription, uint* lpdwNumDeinterlaceModes, Guid* lpDeinterlaceModes);
    HRESULT GetDeinterlaceModeCaps(Guid* lpDeinterlaceMode, VMRVideoDesc* lpVideoDescription, VMRDeinterlaceCaps* lpDeinterlaceCaps);
    HRESULT GetDeinterlaceMode(uint dwStreamID, Guid* lpDeinterlaceMode);
    HRESULT SetDeinterlaceMode(uint dwStreamID, Guid* lpDeinterlaceMode);
    HRESULT GetDeinterlacePrefs(uint* lpdwDeinterlacePrefs);
    HRESULT SetDeinterlacePrefs(uint dwDeinterlacePrefs);
    HRESULT GetActualDeinterlaceMode(uint dwStreamID, Guid* lpDeinterlaceMode);
}

struct VMRALPHABITMAP
{
    uint dwFlags;
    HDC hdc;
    IDirectDrawSurface7 pDDS;
    RECT rSrc;
    NORMALIZEDRECT rDest;
    float fAlpha;
    uint clrSrcKey;
}

const GUID IID_IVMRMixerBitmap = {0x1E673275, 0x0257, 0x40AA, [0xAF, 0x20, 0x7C, 0x60, 0x8D, 0x4A, 0x04, 0x28]};
@GUID(0x1E673275, 0x0257, 0x40AA, [0xAF, 0x20, 0x7C, 0x60, 0x8D, 0x4A, 0x04, 0x28]);
interface IVMRMixerBitmap : IUnknown
{
    HRESULT SetAlphaBitmap(const(VMRALPHABITMAP)* pBmpParms);
    HRESULT UpdateAlphaBitmapParameters(VMRALPHABITMAP* pBmpParms);
    HRESULT GetAlphaBitmapParameters(VMRALPHABITMAP* pBmpParms);
}

struct VMRVIDEOSTREAMINFO
{
    IDirectDrawSurface7 pddsVideoSurface;
    uint dwWidth;
    uint dwHeight;
    uint dwStrmID;
    float fAlpha;
    DDCOLORKEY ddClrKey;
    NORMALIZEDRECT rNormal;
}

const GUID IID_IVMRImageCompositor = {0x7A4FB5AF, 0x479F, 0x4074, [0xBB, 0x40, 0xCE, 0x67, 0x22, 0xE4, 0x3C, 0x82]};
@GUID(0x7A4FB5AF, 0x479F, 0x4074, [0xBB, 0x40, 0xCE, 0x67, 0x22, 0xE4, 0x3C, 0x82]);
interface IVMRImageCompositor : IUnknown
{
    HRESULT InitCompositionTarget(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget);
    HRESULT TermCompositionTarget(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget);
    HRESULT SetStreamMediaType(uint dwStrmID, AM_MEDIA_TYPE* pmt, BOOL fTexture);
    HRESULT CompositeImage(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget, AM_MEDIA_TYPE* pmtRenderTarget, long rtStart, long rtEnd, uint dwClrBkGnd, VMRVIDEOSTREAMINFO* pVideoStreamInfo, uint cStreams);
}

const GUID IID_IVMRVideoStreamControl = {0x058D1F11, 0x2A54, 0x4BEF, [0xBD, 0x54, 0xDF, 0x70, 0x66, 0x26, 0xB7, 0x27]};
@GUID(0x058D1F11, 0x2A54, 0x4BEF, [0xBD, 0x54, 0xDF, 0x70, 0x66, 0x26, 0xB7, 0x27]);
interface IVMRVideoStreamControl : IUnknown
{
    HRESULT SetColorKey(DDCOLORKEY* lpClrKey);
    HRESULT GetColorKey(DDCOLORKEY* lpClrKey);
    HRESULT SetStreamActiveState(BOOL fActive);
    HRESULT GetStreamActiveState(int* lpfActive);
}

const GUID IID_IVMRSurface = {0xA9849BBE, 0x9EC8, 0x4263, [0xB7, 0x64, 0x62, 0x73, 0x0F, 0x0D, 0x15, 0xD0]};
@GUID(0xA9849BBE, 0x9EC8, 0x4263, [0xB7, 0x64, 0x62, 0x73, 0x0F, 0x0D, 0x15, 0xD0]);
interface IVMRSurface : IUnknown
{
    HRESULT IsSurfaceLocked();
    HRESULT LockSurface(ubyte** lpSurface);
    HRESULT UnlockSurface();
    HRESULT GetSurface(IDirectDrawSurface7* lplpSurface);
}

const GUID IID_IVMRImagePresenterConfig = {0x9F3A1C85, 0x8555, 0x49BA, [0x93, 0x5F, 0xBE, 0x5B, 0x5B, 0x29, 0xD1, 0x78]};
@GUID(0x9F3A1C85, 0x8555, 0x49BA, [0x93, 0x5F, 0xBE, 0x5B, 0x5B, 0x29, 0xD1, 0x78]);
interface IVMRImagePresenterConfig : IUnknown
{
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    HRESULT GetRenderingPrefs(uint* dwRenderFlags);
}

const GUID IID_IVMRImagePresenterExclModeConfig = {0xE6F7CE40, 0x4673, 0x44F1, [0x8F, 0x77, 0x54, 0x99, 0xD6, 0x8C, 0xB4, 0xEA]};
@GUID(0xE6F7CE40, 0x4673, 0x44F1, [0x8F, 0x77, 0x54, 0x99, 0xD6, 0x8C, 0xB4, 0xEA]);
interface IVMRImagePresenterExclModeConfig : IVMRImagePresenterConfig
{
    HRESULT SetXlcModeDDObjAndPrimarySurface(IDirectDraw7 lpDDObj, IDirectDrawSurface7 lpPrimarySurf);
    HRESULT GetXlcModeDDObjAndPrimarySurface(IDirectDraw7* lpDDObj, IDirectDrawSurface7* lpPrimarySurf);
}

const GUID IID_IVPManager = {0xAAC18C18, 0xE186, 0x46D2, [0x82, 0x5D, 0xA1, 0xF8, 0xDC, 0x8E, 0x39, 0x5A]};
@GUID(0xAAC18C18, 0xE186, 0x46D2, [0x82, 0x5D, 0xA1, 0xF8, 0xDC, 0x8E, 0x39, 0x5A]);
interface IVPManager : IUnknown
{
    HRESULT SetVideoPortIndex(uint dwVideoPortIndex);
    HRESULT GetVideoPortIndex(uint* pdwVideoPortIndex);
}

enum DVD_DOMAIN
{
    DVD_DOMAIN_FirstPlay = 1,
    DVD_DOMAIN_VideoManagerMenu = 2,
    DVD_DOMAIN_VideoTitleSetMenu = 3,
    DVD_DOMAIN_Title = 4,
    DVD_DOMAIN_Stop = 5,
}

enum DVD_MENU_ID
{
    DVD_MENU_Title = 2,
    DVD_MENU_Root = 3,
    DVD_MENU_Subpicture = 4,
    DVD_MENU_Audio = 5,
    DVD_MENU_Angle = 6,
    DVD_MENU_Chapter = 7,
}

enum DVD_DISC_SIDE
{
    DVD_SIDE_A = 1,
    DVD_SIDE_B = 2,
}

enum DVD_PREFERRED_DISPLAY_MODE
{
    DISPLAY_CONTENT_DEFAULT = 0,
    DISPLAY_16x9 = 1,
    DISPLAY_4x3_PANSCAN_PREFERRED = 2,
    DISPLAY_4x3_LETTERBOX_PREFERRED = 3,
}

struct DVD_ATR
{
    uint ulCAT;
    ubyte pbATRI;
}

enum DVD_FRAMERATE
{
    DVD_FPS_25 = 1,
    DVD_FPS_30NonDrop = 3,
}

struct DVD_TIMECODE
{
    uint _bitfield;
}

enum DVD_NavCmdType
{
    DVD_NavCmdType_Pre = 1,
    DVD_NavCmdType_Post = 2,
    DVD_NavCmdType_Cell = 3,
    DVD_NavCmdType_Button = 4,
}

enum DVD_TIMECODE_FLAGS
{
    DVD_TC_FLAG_25fps = 1,
    DVD_TC_FLAG_30fps = 2,
    DVD_TC_FLAG_DropFrame = 4,
    DVD_TC_FLAG_Interpolated = 8,
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
    uint TitleNum;
    uint ChapterNum;
    DVD_HMSF_TIMECODE TimeCode;
    uint TimeCodeFlags;
}

struct DVD_PLAYBACK_LOCATION
{
    uint TitleNum;
    uint ChapterNum;
    uint TimeCode;
}

enum VALID_UOP_FLAG
{
    UOP_FLAG_Play_Title_Or_AtTime = 1,
    UOP_FLAG_Play_Chapter = 2,
    UOP_FLAG_Play_Title = 4,
    UOP_FLAG_Stop = 8,
    UOP_FLAG_ReturnFromSubMenu = 16,
    UOP_FLAG_Play_Chapter_Or_AtTime = 32,
    UOP_FLAG_PlayPrev_Or_Replay_Chapter = 64,
    UOP_FLAG_PlayNext_Chapter = 128,
    UOP_FLAG_Play_Forwards = 256,
    UOP_FLAG_Play_Backwards = 512,
    UOP_FLAG_ShowMenu_Title = 1024,
    UOP_FLAG_ShowMenu_Root = 2048,
    UOP_FLAG_ShowMenu_SubPic = 4096,
    UOP_FLAG_ShowMenu_Audio = 8192,
    UOP_FLAG_ShowMenu_Angle = 16384,
    UOP_FLAG_ShowMenu_Chapter = 32768,
    UOP_FLAG_Resume = 65536,
    UOP_FLAG_Select_Or_Activate_Button = 131072,
    UOP_FLAG_Still_Off = 262144,
    UOP_FLAG_Pause_On = 524288,
    UOP_FLAG_Select_Audio_Stream = 1048576,
    UOP_FLAG_Select_SubPic_Stream = 2097152,
    UOP_FLAG_Select_Angle = 4194304,
    UOP_FLAG_Select_Karaoke_Audio_Presentation_Mode = 8388608,
    UOP_FLAG_Select_Video_Mode_Preference = 16777216,
}

enum DVD_CMD_FLAGS
{
    DVD_CMD_FLAG_None = 0,
    DVD_CMD_FLAG_Flush = 1,
    DVD_CMD_FLAG_SendEvents = 2,
    DVD_CMD_FLAG_Block = 4,
    DVD_CMD_FLAG_StartWhenRendered = 8,
    DVD_CMD_FLAG_EndAfterRendered = 16,
}

enum DVD_OPTION_FLAG
{
    DVD_ResetOnStop = 1,
    DVD_NotifyParentalLevelChange = 2,
    DVD_HMSF_TimeCodeEvents = 3,
    DVD_AudioDuringFFwdRew = 4,
    DVD_EnableNonblockingAPIs = 5,
    DVD_CacheSizeInMB = 6,
    DVD_EnablePortableBookmarks = 7,
    DVD_EnableExtendedCopyProtectErrors = 8,
    DVD_NotifyPositionChange = 9,
    DVD_IncreaseOutputControl = 10,
    DVD_EnableStreaming = 11,
    DVD_EnableESOutput = 12,
    DVD_EnableTitleLength = 13,
    DVD_DisableStillThrottle = 14,
    DVD_EnableLoggingEvents = 15,
    DVD_MaxReadBurstInKB = 16,
    DVD_ReadBurstPeriodInMS = 17,
    DVD_RestartDisc = 18,
    DVD_EnableCC = 19,
}

enum DVD_RELATIVE_BUTTON
{
    DVD_Relative_Upper = 1,
    DVD_Relative_Lower = 2,
    DVD_Relative_Left = 3,
    DVD_Relative_Right = 4,
}

enum DVD_PARENTAL_LEVEL
{
    DVD_PARENTAL_LEVEL_8 = 32768,
    DVD_PARENTAL_LEVEL_7 = 16384,
    DVD_PARENTAL_LEVEL_6 = 8192,
    DVD_PARENTAL_LEVEL_5 = 4096,
    DVD_PARENTAL_LEVEL_4 = 2048,
    DVD_PARENTAL_LEVEL_3 = 1024,
    DVD_PARENTAL_LEVEL_2 = 512,
    DVD_PARENTAL_LEVEL_1 = 256,
}

enum DVD_AUDIO_LANG_EXT
{
    DVD_AUD_EXT_NotSpecified = 0,
    DVD_AUD_EXT_Captions = 1,
    DVD_AUD_EXT_VisuallyImpaired = 2,
    DVD_AUD_EXT_DirectorComments1 = 3,
    DVD_AUD_EXT_DirectorComments2 = 4,
}

enum DVD_SUBPICTURE_LANG_EXT
{
    DVD_SP_EXT_NotSpecified = 0,
    DVD_SP_EXT_Caption_Normal = 1,
    DVD_SP_EXT_Caption_Big = 2,
    DVD_SP_EXT_Caption_Children = 3,
    DVD_SP_EXT_CC_Normal = 5,
    DVD_SP_EXT_CC_Big = 6,
    DVD_SP_EXT_CC_Children = 7,
    DVD_SP_EXT_Forced = 9,
    DVD_SP_EXT_DirectorComments_Normal = 13,
    DVD_SP_EXT_DirectorComments_Big = 14,
    DVD_SP_EXT_DirectorComments_Children = 15,
}

enum DVD_AUDIO_APPMODE
{
    DVD_AudioMode_None = 0,
    DVD_AudioMode_Karaoke = 1,
    DVD_AudioMode_Surround = 2,
    DVD_AudioMode_Other = 3,
}

enum DVD_AUDIO_FORMAT
{
    DVD_AudioFormat_AC3 = 0,
    DVD_AudioFormat_MPEG1 = 1,
    DVD_AudioFormat_MPEG1_DRC = 2,
    DVD_AudioFormat_MPEG2 = 3,
    DVD_AudioFormat_MPEG2_DRC = 4,
    DVD_AudioFormat_LPCM = 5,
    DVD_AudioFormat_DTS = 6,
    DVD_AudioFormat_SDDS = 7,
    DVD_AudioFormat_Other = 8,
}

enum DVD_KARAOKE_DOWNMIX
{
    DVD_Mix_0to0 = 1,
    DVD_Mix_1to0 = 2,
    DVD_Mix_2to0 = 4,
    DVD_Mix_3to0 = 8,
    DVD_Mix_4to0 = 16,
    DVD_Mix_Lto0 = 32,
    DVD_Mix_Rto0 = 64,
    DVD_Mix_0to1 = 256,
    DVD_Mix_1to1 = 512,
    DVD_Mix_2to1 = 1024,
    DVD_Mix_3to1 = 2048,
    DVD_Mix_4to1 = 4096,
    DVD_Mix_Lto1 = 8192,
    DVD_Mix_Rto1 = 16384,
}

struct DVD_AudioAttributes
{
    DVD_AUDIO_APPMODE AppMode;
    ubyte AppModeData;
    DVD_AUDIO_FORMAT AudioFormat;
    uint Language;
    DVD_AUDIO_LANG_EXT LanguageExtension;
    BOOL fHasMultichannelInfo;
    uint dwFrequency;
    ubyte bQuantization;
    ubyte bNumberOfChannels;
    uint dwReserved;
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
    DVD_MUA_MixingInfo Info;
    DVD_MUA_Coeff Coeff;
}

enum DVD_KARAOKE_CONTENTS
{
    DVD_Karaoke_GuideVocal1 = 1,
    DVD_Karaoke_GuideVocal2 = 2,
    DVD_Karaoke_GuideMelody1 = 4,
    DVD_Karaoke_GuideMelody2 = 8,
    DVD_Karaoke_GuideMelodyA = 16,
    DVD_Karaoke_GuideMelodyB = 32,
    DVD_Karaoke_SoundEffectA = 64,
    DVD_Karaoke_SoundEffectB = 128,
}

enum DVD_KARAOKE_ASSIGNMENT
{
    DVD_Assignment_reserved0 = 0,
    DVD_Assignment_reserved1 = 1,
    DVD_Assignment_LR = 2,
    DVD_Assignment_LRM = 3,
    DVD_Assignment_LR1 = 4,
    DVD_Assignment_LRM1 = 5,
    DVD_Assignment_LR12 = 6,
    DVD_Assignment_LRM12 = 7,
}

struct DVD_KaraokeAttributes
{
    ubyte bVersion;
    BOOL fMasterOfCeremoniesInGuideVocal1;
    BOOL fDuet;
    DVD_KARAOKE_ASSIGNMENT ChannelAssignment;
    ushort wChannelContents;
}

enum DVD_VIDEO_COMPRESSION
{
    DVD_VideoCompression_Other = 0,
    DVD_VideoCompression_MPEG1 = 1,
    DVD_VideoCompression_MPEG2 = 2,
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

enum DVD_SUBPICTURE_TYPE
{
    DVD_SPType_NotSpecified = 0,
    DVD_SPType_Language = 1,
    DVD_SPType_Other = 2,
}

enum DVD_SUBPICTURE_CODING
{
    DVD_SPCoding_RunLength = 0,
    DVD_SPCoding_Extended = 1,
    DVD_SPCoding_Other = 2,
}

struct DVD_SubpictureAttributes
{
    DVD_SUBPICTURE_TYPE Type;
    DVD_SUBPICTURE_CODING CodingMode;
    uint Language;
    DVD_SUBPICTURE_LANG_EXT LanguageExtension;
}

enum DVD_TITLE_APPMODE
{
    DVD_AppMode_Not_Specified = 0,
    DVD_AppMode_Karaoke = 1,
    DVD_AppMode_Other = 3,
}

struct DVD_TitleAttributes
{
    _Anonymous_e__Union Anonymous;
    DVD_VideoAttributes VideoAttributes;
    uint ulNumberOfAudioStreams;
    DVD_AudioAttributes AudioAttributes;
    DVD_MultichannelAudioAttributes MultichannelAudioAttributes;
    uint ulNumberOfSubpictureStreams;
    DVD_SubpictureAttributes SubpictureAttributes;
}

struct DVD_MenuAttributes
{
    BOOL*** fCompatibleRegion;
    DVD_VideoAttributes VideoAttributes;
    BOOL fAudioPresent;
    DVD_AudioAttributes AudioAttributes;
    BOOL fSubpicturePresent;
    DVD_SubpictureAttributes SubpictureAttributes;
}

const GUID IID_IDvdControl = {0xA70EFE61, 0xE2A3, 0x11D0, [0xA9, 0xBE, 0x00, 0xAA, 0x00, 0x61, 0xBE, 0x93]};
@GUID(0xA70EFE61, 0xE2A3, 0x11D0, [0xA9, 0xBE, 0x00, 0xAA, 0x00, 0x61, 0xBE, 0x93]);
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

const GUID IID_IDvdInfo = {0xA70EFE60, 0xE2A3, 0x11D0, [0xA9, 0xBE, 0x00, 0xAA, 0x00, 0x61, 0xBE, 0x93]};
@GUID(0xA70EFE60, 0xE2A3, 0x11D0, [0xA9, 0xBE, 0x00, 0xAA, 0x00, 0x61, 0xBE, 0x93]);
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
    HRESULT GetCurrentVolumeInfo(uint* pulNumOfVol, uint* pulThisVolNum, DVD_DISC_SIDE* pSide, uint* pulNumOfTitles);
    HRESULT GetDVDTextInfo(char* pTextManager, uint ulBufSize, uint* pulActualSize);
    HRESULT GetPlayerParentalLevel(uint* pulParentalLevel, uint* pulCountryCode);
    HRESULT GetNumberOfChapters(uint ulTitle, uint* pulNumberOfChapters);
    HRESULT GetTitleParentalLevels(uint ulTitle, uint* pulParentalLevels);
    HRESULT GetRoot(const(char)* pRoot, uint ulBufSize, uint* pulActualSize);
}

const GUID IID_IDvdCmd = {0x5A4A97E4, 0x94EE, 0x4A55, [0x97, 0x51, 0x74, 0xB5, 0x64, 0x3A, 0xA2, 0x7D]};
@GUID(0x5A4A97E4, 0x94EE, 0x4A55, [0x97, 0x51, 0x74, 0xB5, 0x64, 0x3A, 0xA2, 0x7D]);
interface IDvdCmd : IUnknown
{
    HRESULT WaitForStart();
    HRESULT WaitForEnd();
}

const GUID IID_IDvdState = {0x86303D6D, 0x1C4A, 0x4087, [0xAB, 0x42, 0xF7, 0x11, 0x16, 0x70, 0x48, 0xEF]};
@GUID(0x86303D6D, 0x1C4A, 0x4087, [0xAB, 0x42, 0xF7, 0x11, 0x16, 0x70, 0x48, 0xEF]);
interface IDvdState : IUnknown
{
    HRESULT GetDiscID(ulong* pullUniqueID);
    HRESULT GetParentalLevel(uint* pulParentalLevel);
}

const GUID IID_IDvdControl2 = {0x33BC7430, 0xEEC0, 0x11D2, [0x82, 0x01, 0x00, 0xA0, 0xC9, 0xD7, 0x48, 0x42]};
@GUID(0x33BC7430, 0xEEC0, 0x11D2, [0x82, 0x01, 0x00, 0xA0, 0xC9, 0xD7, 0x48, 0x42]);
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
    HRESULT PlayPeriodInTitleAutoStop(uint ulTitle, DVD_HMSF_TIMECODE* pStartTime, DVD_HMSF_TIMECODE* pEndTime, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SetGPRM(uint ulIndex, ushort wValue, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SelectDefaultMenuLanguage(uint Language);
    HRESULT SelectDefaultAudioLanguage(uint Language, DVD_AUDIO_LANG_EXT audioExtension);
    HRESULT SelectDefaultSubpictureLanguage(uint Language, DVD_SUBPICTURE_LANG_EXT subpictureExtension);
}

enum DVD_TextStringType
{
    DVD_Struct_Volume = 1,
    DVD_Struct_Title = 2,
    DVD_Struct_ParentalID = 3,
    DVD_Struct_PartOfTitle = 4,
    DVD_Struct_Cell = 5,
    DVD_Stream_Audio = 16,
    DVD_Stream_Subpicture = 17,
    DVD_Stream_Angle = 18,
    DVD_Channel_Audio = 32,
    DVD_General_Name = 48,
    DVD_General_Comments = 49,
    DVD_Title_Series = 56,
    DVD_Title_Movie = 57,
    DVD_Title_Video = 58,
    DVD_Title_Album = 59,
    DVD_Title_Song = 60,
    DVD_Title_Other = 63,
    DVD_Title_Sub_Series = 64,
    DVD_Title_Sub_Movie = 65,
    DVD_Title_Sub_Video = 66,
    DVD_Title_Sub_Album = 67,
    DVD_Title_Sub_Song = 68,
    DVD_Title_Sub_Other = 71,
    DVD_Title_Orig_Series = 72,
    DVD_Title_Orig_Movie = 73,
    DVD_Title_Orig_Video = 74,
    DVD_Title_Orig_Album = 75,
    DVD_Title_Orig_Song = 76,
    DVD_Title_Orig_Other = 79,
    DVD_Other_Scene = 80,
    DVD_Other_Cut = 81,
    DVD_Other_Take = 82,
}

enum DVD_TextCharSet
{
    DVD_CharSet_Unicode = 0,
    DVD_CharSet_ISO646 = 1,
    DVD_CharSet_JIS_Roman_Kanji = 2,
    DVD_CharSet_ISO8859_1 = 3,
    DVD_CharSet_ShiftJIS_Kanji_Roman_Katakana = 4,
}

struct DVD_DECODER_CAPS
{
    uint dwSize;
    uint dwAudioCaps;
    double dFwdMaxRateVideo;
    double dFwdMaxRateAudio;
    double dFwdMaxRateSP;
    double dBwdMaxRateVideo;
    double dBwdMaxRateAudio;
    double dBwdMaxRateSP;
    uint dwRes1;
    uint dwRes2;
    uint dwRes3;
    uint dwRes4;
}

const GUID IID_IDvdInfo2 = {0x34151510, 0xEEC0, 0x11D2, [0x82, 0x01, 0x00, 0xA0, 0xC9, 0xD7, 0x48, 0x42]};
@GUID(0x34151510, 0xEEC0, 0x11D2, [0x82, 0x01, 0x00, 0xA0, 0xC9, 0xD7, 0x48, 0x42]);
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
    HRESULT GetDVDTextLanguageInfo(uint ulLangIndex, uint* pulNumOfStrings, uint* pLangCode, DVD_TextCharSet* pbCharacterSet);
    HRESULT GetDVDTextStringAsNative(uint ulLangIndex, uint ulStringIndex, ubyte* pbBuffer, uint ulMaxBufferSize, uint* pulActualSize, DVD_TextStringType* pType);
    HRESULT GetDVDTextStringAsUnicode(uint ulLangIndex, uint ulStringIndex, ushort* pchwBuffer, uint ulMaxBufferSize, uint* pulActualSize, DVD_TextStringType* pType);
    HRESULT GetPlayerParentalLevel(uint* pulParentalLevel, ubyte* pbCountryCode);
    HRESULT GetNumberOfChapters(uint ulTitle, uint* pulNumOfChapters);
    HRESULT GetTitleParentalLevels(uint ulTitle, uint* pulParentalLevels);
    HRESULT GetDVDDirectory(const(wchar)* pszwPath, uint ulMaxSize, uint* pulActualSize);
    HRESULT IsAudioStreamEnabled(uint ulStreamNum, int* pbEnabled);
    HRESULT GetDiscID(const(wchar)* pszwPath, ulong* pullDiscID);
    HRESULT GetState(IDvdState* pStateData);
    HRESULT GetMenuLanguages(uint* pLanguages, uint ulMaxLanguages, uint* pulActualLanguages);
    HRESULT GetButtonAtPosition(POINT point, uint* pulButtonIndex);
    HRESULT GetCmdFromEvent(int lParam1, IDvdCmd* pCmdObj);
    HRESULT GetDefaultMenuLanguage(uint* pLanguage);
    HRESULT GetDefaultAudioLanguage(uint* pLanguage, DVD_AUDIO_LANG_EXT* pAudioExtension);
    HRESULT GetDefaultSubpictureLanguage(uint* pLanguage, DVD_SUBPICTURE_LANG_EXT* pSubpictureExtension);
    HRESULT GetDecoderCaps(DVD_DECODER_CAPS* pCaps);
    HRESULT GetButtonRect(uint ulButton, RECT* pRect);
    HRESULT IsSubpictureStreamEnabled(uint ulStreamNum, int* pbEnabled);
}

enum AM_DVD_GRAPH_FLAGS
{
    AM_DVD_HWDEC_PREFER = 1,
    AM_DVD_HWDEC_ONLY = 2,
    AM_DVD_SWDEC_PREFER = 4,
    AM_DVD_SWDEC_ONLY = 8,
    AM_DVD_NOVPE = 256,
    AM_DVD_DO_NOT_CLEAR = 512,
    AM_DVD_VMR9_ONLY = 2048,
    AM_DVD_EVR_ONLY = 4096,
    AM_DVD_EVR_QOS = 8192,
    AM_DVD_ADAPT_GRAPH = 16384,
    AM_DVD_MASK = 65535,
}

enum AM_DVD_STREAM_FLAGS
{
    AM_DVD_STREAM_VIDEO = 1,
    AM_DVD_STREAM_AUDIO = 2,
    AM_DVD_STREAM_SUBPIC = 4,
}

struct AM_DVD_RENDERSTATUS
{
    HRESULT hrVPEStatus;
    BOOL bDvdVolInvalid;
    BOOL bDvdVolUnknown;
    BOOL bNoLine21In;
    BOOL bNoLine21Out;
    int iNumStreams;
    int iNumStreamsFailed;
    uint dwFailedStreamsFlag;
}

const GUID IID_IDvdGraphBuilder = {0xFCC152B6, 0xF372, 0x11D0, [0x8E, 0x00, 0x00, 0xC0, 0x4F, 0xD7, 0xC0, 0x8B]};
@GUID(0xFCC152B6, 0xF372, 0x11D0, [0x8E, 0x00, 0x00, 0xC0, 0x4F, 0xD7, 0xC0, 0x8B]);
interface IDvdGraphBuilder : IUnknown
{
    HRESULT GetFiltergraph(IGraphBuilder* ppGB);
    HRESULT GetDvdInterface(const(Guid)* riid, void** ppvIF);
    HRESULT RenderDvdVideoVolume(const(wchar)* lpcwszPathName, uint dwFlags, AM_DVD_RENDERSTATUS* pStatus);
}

const GUID IID_IDDrawExclModeVideo = {0x153ACC21, 0xD83B, 0x11D1, [0x82, 0xBF, 0x00, 0xA0, 0xC9, 0x69, 0x6C, 0x8F]};
@GUID(0x153ACC21, 0xD83B, 0x11D1, [0x82, 0xBF, 0x00, 0xA0, 0xC9, 0x69, 0x6C, 0x8F]);
interface IDDrawExclModeVideo : IUnknown
{
    HRESULT SetDDrawObject(IDirectDraw pDDrawObject);
    HRESULT GetDDrawObject(IDirectDraw* ppDDrawObject, int* pbUsingExternal);
    HRESULT SetDDrawSurface(IDirectDrawSurface pDDrawSurface);
    HRESULT GetDDrawSurface(IDirectDrawSurface* ppDDrawSurface, int* pbUsingExternal);
    HRESULT SetDrawParameters(const(RECT)* prcSource, const(RECT)* prcTarget);
    HRESULT GetNativeVideoProps(uint* pdwVideoWidth, uint* pdwVideoHeight, uint* pdwPictAspectRatioX, uint* pdwPictAspectRatioY);
    HRESULT SetCallbackInterface(IDDrawExclModeVideoCallback pCallback, uint dwFlags);
}

enum _AM_OVERLAY_NOTIFY_FLAGS
{
    AM_OVERLAY_NOTIFY_VISIBLE_CHANGE = 1,
    AM_OVERLAY_NOTIFY_SOURCE_CHANGE = 2,
    AM_OVERLAY_NOTIFY_DEST_CHANGE = 4,
}

const GUID IID_IDDrawExclModeVideoCallback = {0x913C24A0, 0x20AB, 0x11D2, [0x90, 0x38, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x98]};
@GUID(0x913C24A0, 0x20AB, 0x11D2, [0x90, 0x38, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x98]);
interface IDDrawExclModeVideoCallback : IUnknown
{
    HRESULT OnUpdateOverlay(BOOL bBefore, uint dwFlags, BOOL bOldVisible, const(RECT)* prcOldSrc, const(RECT)* prcOldDest, BOOL bNewVisible, const(RECT)* prcNewSrc, const(RECT)* prcNewDest);
    HRESULT OnUpdateColorKey(const(COLORKEY)* pKey, uint dwColor);
    HRESULT OnUpdateSize(uint dwWidth, uint dwHeight, uint dwARWidth, uint dwARHeight);
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

enum BDA_EVENT_ID
{
    BDA_EVENT_SIGNAL_LOSS = 0,
    BDA_EVENT_SIGNAL_LOCK = 1,
    BDA_EVENT_DATA_START = 2,
    BDA_EVENT_DATA_STOP = 3,
    BDA_EVENT_CHANNEL_ACQUIRED = 4,
    BDA_EVENT_CHANNEL_LOST = 5,
    BDA_EVENT_CHANNEL_SOURCE_CHANGED = 6,
    BDA_EVENT_CHANNEL_ACTIVATED = 7,
    BDA_EVENT_CHANNEL_DEACTIVATED = 8,
    BDA_EVENT_SUBCHANNEL_ACQUIRED = 9,
    BDA_EVENT_SUBCHANNEL_LOST = 10,
    BDA_EVENT_SUBCHANNEL_SOURCE_CHANGED = 11,
    BDA_EVENT_SUBCHANNEL_ACTIVATED = 12,
    BDA_EVENT_SUBCHANNEL_DEACTIVATED = 13,
    BDA_EVENT_ACCESS_GRANTED = 14,
    BDA_EVENT_ACCESS_DENIED = 15,
    BDA_EVENT_OFFER_EXTENDED = 16,
    BDA_EVENT_PURCHASE_COMPLETED = 17,
    BDA_EVENT_SMART_CARD_INSERTED = 18,
    BDA_EVENT_SMART_CARD_REMOVED = 19,
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
    ubyte rgbAddress;
}

struct BDA_ETHERNET_ADDRESS_LIST
{
    uint ulcAddresses;
    BDA_ETHERNET_ADDRESS rgAddressl;
}

enum BDA_MULTICAST_MODE
{
    BDA_PROMISCUOUS_MULTICAST = 0,
    BDA_FILTERED_MULTICAST = 1,
    BDA_NO_MULTICAST = 2,
}

struct BDA_IPv4_ADDRESS
{
    ubyte rgbAddress;
}

struct BDA_IPv4_ADDRESS_LIST
{
    uint ulcAddresses;
    BDA_IPv4_ADDRESS rgAddressl;
}

struct BDA_IPv6_ADDRESS
{
    ubyte rgbAddress;
}

struct BDA_IPv6_ADDRESS_LIST
{
    uint ulcAddresses;
    BDA_IPv6_ADDRESS rgAddressl;
}

enum BDA_SIGNAL_STATE
{
    BDA_SIGNAL_UNAVAILABLE = 0,
    BDA_SIGNAL_INACTIVE = 1,
    BDA_SIGNAL_ACTIVE = 2,
}

enum BDA_CHANGE_STATE
{
    BDA_CHANGES_COMPLETE = 0,
    BDA_CHANGES_PENDING = 1,
}

struct BDANODE_DESCRIPTOR
{
    uint ulBdaNodeType;
    Guid guidFunction;
    Guid guidName;
}

struct BDA_TABLE_SECTION
{
    uint ulPrimarySectionId;
    uint ulSecondarySectionId;
    uint ulcbSectionLength;
    uint argbSectionData;
}

struct BDA_DISEQC_SEND
{
    uint ulRequestId;
    uint ulPacketLength;
    ubyte argbPacketData;
}

struct BDA_DISEQC_RESPONSE
{
    uint ulRequestId;
    uint ulPacketLength;
    ubyte argbPacketData;
}

enum MEDIA_SAMPLE_CONTENT
{
    MEDIA_TRANSPORT_PACKET = 0,
    MEDIA_ELEMENTARY_STREAM = 1,
    MEDIA_MPEG2_PSI = 2,
    MEDIA_TRANSPORT_PAYLOAD = 3,
}

struct PID_MAP
{
    uint ulPID;
    MEDIA_SAMPLE_CONTENT MediaSampleContent;
}

struct BDA_PID_MAP
{
    MEDIA_SAMPLE_CONTENT MediaSampleContent;
    uint ulcPIDs;
    uint aulPIDs;
}

struct BDA_PID_UNMAP
{
    uint ulcPIDs;
    uint aulPIDs;
}

struct BDA_CA_MODULE_UI
{
    uint ulFormat;
    uint ulbcDesc;
    uint ulDesc;
}

struct BDA_PROGRAM_PID_LIST
{
    uint ulProgramNumber;
    uint ulcPIDs;
    uint ulPID;
}

struct BDA_DRM_DRMSTATUS
{
    int lResult;
    Guid DRMuuid;
    uint ulDrmUuidListStringSize;
    Guid argbDrmUuidListString;
}

struct BDA_WMDRM_STATUS
{
    int lResult;
    uint ulMaxCaptureTokenSize;
    uint uMaxStreamingPid;
    uint ulMaxLicense;
    uint ulMinSecurityLevel;
    uint ulRevInfoSequenceNumber;
    ulong ulRevInfoIssuedTime;
    uint ulRevListVersion;
    uint ulRevInfoTTL;
    uint ulState;
}

struct BDA_WMDRM_KEYINFOLIST
{
    int lResult;
    uint ulKeyuuidBufferLen;
    Guid argKeyuuidBuffer;
}

struct BDA_BUFFER
{
    int lResult;
    uint ulBufferSize;
    ubyte argbBuffer;
}

struct BDA_WMDRM_RENEWLICENSE
{
    int lResult;
    uint ulDescrambleStatus;
    uint ulXmrLicenseOutputLength;
    ubyte argbXmrLicenceOutputBuffer;
}

struct BDA_WMDRMTUNER_PIDPROTECTION
{
    int lResult;
    Guid uuidKeyID;
}

struct BDA_WMDRMTUNER_PURCHASEENTITLEMENT
{
    int lResult;
    uint ulDescrambleStatus;
    uint ulCaptureTokenLength;
    ubyte argbCaptureTokenBuffer;
}

struct BDA_TUNER_TUNERSTATE
{
    int lResult;
    uint ulTuneLength;
    ubyte argbTuneData;
}

struct BDA_TUNER_DIAGNOSTICS
{
    int lResult;
    uint ulSignalLevel;
    uint ulSignalLevelQuality;
    uint ulSignalNoiseRatio;
}

struct BDA_STRING
{
    int lResult;
    uint ulStringSize;
    ubyte argbString;
}

struct BDA_SCAN_CAPABILTIES
{
    int lResult;
    ulong ul64AnalogStandardsSupported;
}

struct BDA_SCAN_STATE
{
    int lResult;
    uint ulSignalLock;
    uint ulSecondsLeft;
    uint ulCurrentFrequency;
}

struct BDA_SCAN_START
{
    int lResult;
    uint LowerFrequency;
    uint HigerFrequency;
}

struct BDA_GDDS_DATATYPE
{
    int lResult;
    Guid uuidDataType;
}

struct BDA_GDDS_DATA
{
    int lResult;
    uint ulDataLength;
    uint ulPercentageProgress;
    ubyte argbData;
}

struct BDA_USERACTIVITY_INTERVAL
{
    int lResult;
    uint ulActivityInterval;
}

struct BDA_CAS_CHECK_ENTITLEMENTTOKEN
{
    int lResult;
    uint ulDescrambleStatus;
}

struct BDA_CAS_CLOSE_MMIDIALOG
{
    int lResult;
    uint SessionResult;
}

struct BDA_CAS_REQUESTTUNERDATA
{
    ubyte ucRequestPriority;
    ubyte ucRequestReason;
    ubyte ucRequestConsequences;
    uint ulEstimatedTime;
}

struct BDA_CAS_OPENMMIDATA
{
    uint ulDialogNumber;
    uint ulDialogRequest;
    Guid uuidDialogType;
    ushort usDialogDataLength;
    ubyte argbDialogData;
}

struct BDA_CAS_CLOSEMMIDATA
{
    uint ulDialogNumber;
}

enum ISDBCAS_REQUEST_ID
{
    ISDBCAS_REQUEST_ID_EMG = 56,
    ISDBCAS_REQUEST_ID_EMD = 58,
}

struct BDA_ISDBCAS_REQUESTHEADER
{
    ubyte bInstruction;
    ubyte bReserved;
    uint ulDataLength;
    ubyte argbIsdbCommand;
}

struct BDA_ISDBCAS_RESPONSEDATA
{
    int lResult;
    uint ulRequestID;
    uint ulIsdbStatus;
    uint ulIsdbDataSize;
    ubyte argbIsdbCommandData;
}

struct BDA_ISDBCAS_EMG_REQ
{
    ubyte bCLA;
    ubyte bINS;
    ubyte bP1;
    ubyte bP2;
    ubyte bLC;
    ubyte bCardId;
    ubyte bProtocol;
    ubyte bCABroadcasterGroupId;
    ubyte bMessageControl;
    ubyte bMessageCode;
}

enum MUX_PID_TYPE
{
    PID_OTHER = -1,
    PID_ELEMENTARY_STREAM = 0,
    PID_MPEG2_SECTION_PSI_SI = 1,
}

struct BDA_MUX_PIDLISTITEM
{
    ushort usPIDNumber;
    ushort usProgramNumber;
    MUX_PID_TYPE ePIDType;
}

struct BDA_TS_SELECTORINFO
{
    ubyte bTSInfolength;
    ubyte bReserved;
    Guid guidNetworkType;
    ubyte bTSIDCount;
    ushort usTSID;
}

struct BDA_TS_SELECTORINFO_ISDBS_EXT
{
    ubyte bTMCC;
}

struct BDA_DVBT2_L1_SIGNALLING_DATA
{
    ubyte L1Pre_TYPE;
    ubyte L1Pre_BWT_S1_S2;
    ubyte L1Pre_REPETITION_GUARD_PAPR;
    ubyte L1Pre_MOD_COD_FEC;
    ubyte L1Pre_POSTSIZE_INFO_PILOT;
    ubyte L1Pre_TX_ID_AVAIL;
    ubyte L1Pre_CELL_ID;
    ubyte L1Pre_NETWORK_ID;
    ubyte L1Pre_T2SYSTEM_ID;
    ubyte L1Pre_NUM_T2_FRAMES;
    ubyte L1Pre_NUM_DATA_REGENFLAG_L1POSTEXT;
    ubyte L1Pre_NUMRF_CURRENTRF_RESERVED;
    ubyte L1Pre_CRC32;
    ubyte L1PostData;
}

struct BDA_RATING_PINRESET
{
    ubyte bPinLength;
    ubyte argbNewPin;
}

enum DVBSystemType
{
    DVB_Cable = 0,
    DVB_Terrestrial = 1,
    DVB_Satellite = 2,
    ISDB_Terrestrial = 3,
    ISDB_Satellite = 4,
}

enum BDA_Channel
{
    BDA_UNDEFINED_CHANNEL = -1,
}

enum ComponentCategory
{
    CategoryNotSet = -1,
    CategoryOther = 0,
    CategoryVideo = 1,
    CategoryAudio = 2,
    CategoryText = 3,
    CategorySubtitles = 4,
    CategoryCaptions = 5,
    CategorySuperimpose = 6,
    CategoryData = 7,
    CATEGORY_COUNT = 8,
}

enum ComponentStatus
{
    StatusActive = 0,
    StatusInactive = 1,
    StatusUnavailable = 2,
}

enum MPEG2StreamType
{
    BDA_UNITIALIZED_MPEG2STREAMTYPE = -1,
    Reserved1 = 0,
    ISO_IEC_11172_2_VIDEO = 1,
    ISO_IEC_13818_2_VIDEO = 2,
    ISO_IEC_11172_3_AUDIO = 3,
    ISO_IEC_13818_3_AUDIO = 4,
    ISO_IEC_13818_1_PRIVATE_SECTION = 5,
    ISO_IEC_13818_1_PES = 6,
    ISO_IEC_13522_MHEG = 7,
    ANNEX_A_DSM_CC = 8,
    ITU_T_REC_H_222_1 = 9,
    ISO_IEC_13818_6_TYPE_A = 10,
    ISO_IEC_13818_6_TYPE_B = 11,
    ISO_IEC_13818_6_TYPE_C = 12,
    ISO_IEC_13818_6_TYPE_D = 13,
    ISO_IEC_13818_1_AUXILIARY = 14,
    ISO_IEC_13818_7_AUDIO = 15,
    ISO_IEC_14496_2_VISUAL = 16,
    ISO_IEC_14496_3_AUDIO = 17,
    ISO_IEC_14496_1_IN_PES = 18,
    ISO_IEC_14496_1_IN_SECTION = 19,
    ISO_IEC_13818_6_DOWNLOAD = 20,
    METADATA_IN_PES = 21,
    METADATA_IN_SECTION = 22,
    METADATA_IN_DATA_CAROUSEL = 23,
    METADATA_IN_OBJECT_CAROUSEL = 24,
    METADATA_IN_DOWNLOAD_PROTOCOL = 25,
    IRPM_STREAMM = 26,
    ITU_T_H264 = 27,
    ISO_IEC_13818_1_RESERVED = 28,
    USER_PRIVATE = 16,
    HEVC_VIDEO_OR_TEMPORAL_VIDEO = 36,
    HEVC_TEMPORAL_VIDEO_SUBSET = 37,
    ISO_IEC_USER_PRIVATE = 128,
    DOLBY_AC3_AUDIO = 129,
    DOLBY_DIGITAL_PLUS_AUDIO_ATSC = 135,
}

struct MPEG2_TRANSPORT_STRIDE
{
    uint dwOffset;
    uint dwPacketLength;
    uint dwStride;
}

enum ATSCComponentTypeFlags
{
    ATSCCT_AC3 = 1,
}

enum BinaryConvolutionCodeRate
{
    BDA_BCC_RATE_NOT_SET = -1,
    BDA_BCC_RATE_NOT_DEFINED = 0,
    BDA_BCC_RATE_1_2 = 1,
    BDA_BCC_RATE_2_3 = 2,
    BDA_BCC_RATE_3_4 = 3,
    BDA_BCC_RATE_3_5 = 4,
    BDA_BCC_RATE_4_5 = 5,
    BDA_BCC_RATE_5_6 = 6,
    BDA_BCC_RATE_5_11 = 7,
    BDA_BCC_RATE_7_8 = 8,
    BDA_BCC_RATE_1_4 = 9,
    BDA_BCC_RATE_1_3 = 10,
    BDA_BCC_RATE_2_5 = 11,
    BDA_BCC_RATE_6_7 = 12,
    BDA_BCC_RATE_8_9 = 13,
    BDA_BCC_RATE_9_10 = 14,
    BDA_BCC_RATE_MAX = 15,
}

enum FECMethod
{
    BDA_FEC_METHOD_NOT_SET = -1,
    BDA_FEC_METHOD_NOT_DEFINED = 0,
    BDA_FEC_VITERBI = 1,
    BDA_FEC_RS_204_188 = 2,
    BDA_FEC_LDPC = 3,
    BDA_FEC_BCH = 4,
    BDA_FEC_RS_147_130 = 5,
    BDA_FEC_MAX = 6,
}

enum ModulationType
{
    BDA_MOD_NOT_SET = -1,
    BDA_MOD_NOT_DEFINED = 0,
    BDA_MOD_16QAM = 1,
    BDA_MOD_32QAM = 2,
    BDA_MOD_64QAM = 3,
    BDA_MOD_80QAM = 4,
    BDA_MOD_96QAM = 5,
    BDA_MOD_112QAM = 6,
    BDA_MOD_128QAM = 7,
    BDA_MOD_160QAM = 8,
    BDA_MOD_192QAM = 9,
    BDA_MOD_224QAM = 10,
    BDA_MOD_256QAM = 11,
    BDA_MOD_320QAM = 12,
    BDA_MOD_384QAM = 13,
    BDA_MOD_448QAM = 14,
    BDA_MOD_512QAM = 15,
    BDA_MOD_640QAM = 16,
    BDA_MOD_768QAM = 17,
    BDA_MOD_896QAM = 18,
    BDA_MOD_1024QAM = 19,
    BDA_MOD_QPSK = 20,
    BDA_MOD_BPSK = 21,
    BDA_MOD_OQPSK = 22,
    BDA_MOD_8VSB = 23,
    BDA_MOD_16VSB = 24,
    BDA_MOD_ANALOG_AMPLITUDE = 25,
    BDA_MOD_ANALOG_FREQUENCY = 26,
    BDA_MOD_8PSK = 27,
    BDA_MOD_RF = 28,
    BDA_MOD_16APSK = 29,
    BDA_MOD_32APSK = 30,
    BDA_MOD_NBC_QPSK = 31,
    BDA_MOD_NBC_8PSK = 32,
    BDA_MOD_DIRECTV = 33,
    BDA_MOD_ISDB_T_TMCC = 34,
    BDA_MOD_ISDB_S_TMCC = 35,
    BDA_MOD_MAX = 36,
}

enum ScanModulationTypes
{
    BDA_SCAN_MOD_16QAM = 1,
    BDA_SCAN_MOD_32QAM = 2,
    BDA_SCAN_MOD_64QAM = 4,
    BDA_SCAN_MOD_80QAM = 8,
    BDA_SCAN_MOD_96QAM = 16,
    BDA_SCAN_MOD_112QAM = 32,
    BDA_SCAN_MOD_128QAM = 64,
    BDA_SCAN_MOD_160QAM = 128,
    BDA_SCAN_MOD_192QAM = 256,
    BDA_SCAN_MOD_224QAM = 512,
    BDA_SCAN_MOD_256QAM = 1024,
    BDA_SCAN_MOD_320QAM = 2048,
    BDA_SCAN_MOD_384QAM = 4096,
    BDA_SCAN_MOD_448QAM = 8192,
    BDA_SCAN_MOD_512QAM = 16384,
    BDA_SCAN_MOD_640QAM = 32768,
    BDA_SCAN_MOD_768QAM = 65536,
    BDA_SCAN_MOD_896QAM = 131072,
    BDA_SCAN_MOD_1024QAM = 262144,
    BDA_SCAN_MOD_QPSK = 524288,
    BDA_SCAN_MOD_BPSK = 1048576,
    BDA_SCAN_MOD_OQPSK = 2097152,
    BDA_SCAN_MOD_8VSB = 4194304,
    BDA_SCAN_MOD_16VSB = 8388608,
    BDA_SCAN_MOD_AM_RADIO = 16777216,
    BDA_SCAN_MOD_FM_RADIO = 33554432,
    BDA_SCAN_MOD_8PSK = 67108864,
    BDA_SCAN_MOD_RF = 134217728,
    ScanModulationTypesMask_MCE_DigitalCable = 11,
    ScanModulationTypesMask_MCE_TerrestrialATSC = 23,
    ScanModulationTypesMask_MCE_AnalogTv = 28,
    ScanModulationTypesMask_MCE_All_TV = -1,
    ScanModulationTypesMask_DVBC = 75,
    BDA_SCAN_MOD_16APSK = 268435456,
    BDA_SCAN_MOD_32APSK = 536870912,
}

enum SpectralInversion
{
    BDA_SPECTRAL_INVERSION_NOT_SET = -1,
    BDA_SPECTRAL_INVERSION_NOT_DEFINED = 0,
    BDA_SPECTRAL_INVERSION_AUTOMATIC = 1,
    BDA_SPECTRAL_INVERSION_NORMAL = 2,
    BDA_SPECTRAL_INVERSION_INVERTED = 3,
    BDA_SPECTRAL_INVERSION_MAX = 4,
}

enum Polarisation
{
    BDA_POLARISATION_NOT_SET = -1,
    BDA_POLARISATION_NOT_DEFINED = 0,
    BDA_POLARISATION_LINEAR_H = 1,
    BDA_POLARISATION_LINEAR_V = 2,
    BDA_POLARISATION_CIRCULAR_L = 3,
    BDA_POLARISATION_CIRCULAR_R = 4,
    BDA_POLARISATION_MAX = 5,
}

enum LNB_Source
{
    BDA_LNB_SOURCE_NOT_SET = -1,
    BDA_LNB_SOURCE_NOT_DEFINED = 0,
    BDA_LNB_SOURCE_A = 1,
    BDA_LNB_SOURCE_B = 2,
    BDA_LNB_SOURCE_C = 3,
    BDA_LNB_SOURCE_D = 4,
    BDA_LNB_SOURCE_MAX = 5,
}

enum GuardInterval
{
    BDA_GUARD_NOT_SET = -1,
    BDA_GUARD_NOT_DEFINED = 0,
    BDA_GUARD_1_32 = 1,
    BDA_GUARD_1_16 = 2,
    BDA_GUARD_1_8 = 3,
    BDA_GUARD_1_4 = 4,
    BDA_GUARD_1_128 = 5,
    BDA_GUARD_19_128 = 6,
    BDA_GUARD_19_256 = 7,
    BDA_GUARD_MAX = 8,
}

enum HierarchyAlpha
{
    BDA_HALPHA_NOT_SET = -1,
    BDA_HALPHA_NOT_DEFINED = 0,
    BDA_HALPHA_1 = 1,
    BDA_HALPHA_2 = 2,
    BDA_HALPHA_4 = 3,
    BDA_HALPHA_MAX = 4,
}

enum TransmissionMode
{
    BDA_XMIT_MODE_NOT_SET = -1,
    BDA_XMIT_MODE_NOT_DEFINED = 0,
    BDA_XMIT_MODE_2K = 1,
    BDA_XMIT_MODE_8K = 2,
    BDA_XMIT_MODE_4K = 3,
    BDA_XMIT_MODE_2K_INTERLEAVED = 4,
    BDA_XMIT_MODE_4K_INTERLEAVED = 5,
    BDA_XMIT_MODE_1K = 6,
    BDA_XMIT_MODE_16K = 7,
    BDA_XMIT_MODE_32K = 8,
    BDA_XMIT_MODE_MAX = 9,
}

enum RollOff
{
    BDA_ROLL_OFF_NOT_SET = -1,
    BDA_ROLL_OFF_NOT_DEFINED = 0,
    BDA_ROLL_OFF_20 = 1,
    BDA_ROLL_OFF_25 = 2,
    BDA_ROLL_OFF_35 = 3,
    BDA_ROLL_OFF_MAX = 4,
}

enum Pilot
{
    BDA_PILOT_NOT_SET = -1,
    BDA_PILOT_NOT_DEFINED = 0,
    BDA_PILOT_OFF = 1,
    BDA_PILOT_ON = 2,
    BDA_PILOT_MAX = 3,
}

struct BDA_SIGNAL_TIMEOUTS
{
    uint ulCarrierTimeoutMs;
    uint ulScanningTimeoutMs;
    uint ulTuningTimeoutMs;
}

enum BDA_Frequency
{
    BDA_FREQUENCY_NOT_SET = -1,
    BDA_FREQUENCY_NOT_DEFINED = 0,
}

enum BDA_Range
{
    BDA_RANGE_NOT_SET = -1,
    BDA_RANGE_NOT_DEFINED = 0,
}

enum BDA_Channel_Bandwidth
{
    BDA_CHAN_BANDWITH_NOT_SET = -1,
    BDA_CHAN_BANDWITH_NOT_DEFINED = 0,
}

enum BDA_Frequency_Multiplier
{
    BDA_FREQUENCY_MULTIPLIER_NOT_SET = -1,
    BDA_FREQUENCY_MULTIPLIER_NOT_DEFINED = 0,
}

enum BDA_Comp_Flags
{
    BDACOMP_NOT_DEFINED = 0,
    BDACOMP_EXCLUDE_TS_FROM_TR = 1,
    BDACOMP_INCLUDE_LOCATOR_IN_TR = 2,
    BDACOMP_INCLUDE_COMPONENTS_IN_TR = 4,
}

enum ApplicationTypeType
{
    SCTE28_ConditionalAccess = 0,
    SCTE28_POD_Host_Binding_Information = 1,
    SCTE28_IPService = 2,
    SCTE28_NetworkInterface_SCTE55_2 = 3,
    SCTE28_NetworkInterface_SCTE55_1 = 4,
    SCTE28_CopyProtection = 5,
    SCTE28_Diagnostic = 6,
    SCTE28_Undesignated = 7,
    SCTE28_Reserved = 8,
}

enum BDA_CONDITIONALACCESS_REQUESTTYPE
{
    CONDITIONALACCESS_ACCESS_UNSPECIFIED = 0,
    CONDITIONALACCESS_ACCESS_NOT_POSSIBLE = 1,
    CONDITIONALACCESS_ACCESS_POSSIBLE = 2,
    CONDITIONALACCESS_ACCESS_POSSIBLE_NO_STREAMING_DISRUPTION = 3,
}

enum BDA_CONDITIONALACCESS_MMICLOSEREASON
{
    CONDITIONALACCESS_UNSPECIFIED = 0,
    CONDITIONALACCESS_CLOSED_ITSELF = 1,
    CONDITIONALACCESS_TUNER_REQUESTED_CLOSE = 2,
    CONDITIONALACCESS_DIALOG_TIMEOUT = 3,
    CONDITIONALACCESS_DIALOG_FOCUS_CHANGE = 4,
    CONDITIONALACCESS_DIALOG_USER_DISMISSED = 5,
    CONDITIONALACCESS_DIALOG_USER_NOT_AVAILABLE = 6,
}

enum BDA_CONDITIONALACCESS_SESSION_RESULT
{
    CONDITIONALACCESS_SUCCESSFULL = 0,
    CONDITIONALACCESS_ENDED_NOCHANGE = 1,
    CONDITIONALACCESS_ABORTED = 2,
}

enum BDA_DISCOVERY_STATE
{
    BDA_DISCOVERY_UNSPECIFIED = 0,
    BDA_DISCOVERY_REQUIRED = 1,
    BDA_DISCOVERY_COMPLETE = 2,
}

enum SmartCardStatusType
{
    CardInserted = 0,
    CardRemoved = 1,
    CardError = 2,
    CardDataChanged = 3,
    CardFirmwareUpgrade = 4,
}

enum SmartCardAssociationType
{
    NotAssociated = 0,
    Associated = 1,
    AssociationUnknown = 2,
}

enum LocationCodeSchemeType
{
    SCTE_18 = 0,
}

struct EALocationCodeType
{
    LocationCodeSchemeType LocationCodeScheme;
    ubyte state_code;
    ubyte county_subdivision;
    ushort county_code;
}

enum EntitlementType
{
    Entitled = 0,
    NotEntitled = 1,
    TechnicalFailure = 2,
}

enum UICloseReasonType
{
    NotReady = 0,
    UserClosed = 1,
    SystemClosed = 2,
    DeviceClosed = 3,
    ErrorClosed = 4,
}

struct SmartCardApplication
{
    ApplicationTypeType ApplicationType;
    ushort ApplicationVersion;
    BSTR pbstrApplicationName;
    BSTR pbstrApplicationURL;
}

enum BDA_DrmPairingError
{
    BDA_DrmPairing_Succeeded = 0,
    BDA_DrmPairing_HardwareFailure = 1,
    BDA_DrmPairing_NeedRevocationData = 2,
    BDA_DrmPairing_NeedIndiv = 3,
    BDA_DrmPairing_Other = 4,
    BDA_DrmPairing_DrmInitFailed = 5,
    BDA_DrmPairing_DrmNotPaired = 6,
    BDA_DrmPairing_DrmRePairSoon = 7,
    BDA_DrmPairing_Aborted = 8,
    BDA_DrmPairing_NeedSDKUpdate = 9,
}

const GUID IID_IBDA_NetworkProvider = {0xFD501041, 0x8EBE, 0x11CE, [0x81, 0x83, 0x00, 0xAA, 0x00, 0x57, 0x7D, 0xA2]};
@GUID(0xFD501041, 0x8EBE, 0x11CE, [0x81, 0x83, 0x00, 0xAA, 0x00, 0x57, 0x7D, 0xA2]);
interface IBDA_NetworkProvider : IUnknown
{
    HRESULT PutSignalSource(uint ulSignalSource);
    HRESULT GetSignalSource(uint* pulSignalSource);
    HRESULT GetNetworkType(Guid* pguidNetworkType);
    HRESULT PutTuningSpace(const(Guid)* guidTuningSpace);
    HRESULT GetTuningSpace(Guid* pguidTuingSpace);
    HRESULT RegisterDeviceFilter(IUnknown pUnkFilterControl, uint* ppvRegisitrationContext);
    HRESULT UnRegisterDeviceFilter(uint pvRegistrationContext);
}

const GUID IID_IBDA_EthernetFilter = {0x71985F43, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F43, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
interface IBDA_EthernetFilter : IUnknown
{
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    HRESULT PutMulticastList(uint ulcbAddresses, char* pAddressList);
    HRESULT GetMulticastList(uint* pulcbAddresses, char* pAddressList);
    HRESULT PutMulticastMode(uint ulModeMask);
    HRESULT GetMulticastMode(uint* pulModeMask);
}

const GUID IID_IBDA_IPV4Filter = {0x71985F44, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F44, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
interface IBDA_IPV4Filter : IUnknown
{
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    HRESULT PutMulticastList(uint ulcbAddresses, char* pAddressList);
    HRESULT GetMulticastList(uint* pulcbAddresses, char* pAddressList);
    HRESULT PutMulticastMode(uint ulModeMask);
    HRESULT GetMulticastMode(uint* pulModeMask);
}

const GUID IID_IBDA_IPV6Filter = {0xE1785A74, 0x2A23, 0x4FB3, [0x92, 0x45, 0xA8, 0xF8, 0x80, 0x17, 0xEF, 0x33]};
@GUID(0xE1785A74, 0x2A23, 0x4FB3, [0x92, 0x45, 0xA8, 0xF8, 0x80, 0x17, 0xEF, 0x33]);
interface IBDA_IPV6Filter : IUnknown
{
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    HRESULT PutMulticastList(uint ulcbAddresses, char* pAddressList);
    HRESULT GetMulticastList(uint* pulcbAddresses, char* pAddressList);
    HRESULT PutMulticastMode(uint ulModeMask);
    HRESULT GetMulticastMode(uint* pulModeMask);
}

const GUID IID_IBDA_DeviceControl = {0xFD0A5AF3, 0xB41D, 0x11D2, [0x9C, 0x95, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xFD0A5AF3, 0xB41D, 0x11D2, [0x9C, 0x95, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
interface IBDA_DeviceControl : IUnknown
{
    HRESULT StartChanges();
    HRESULT CheckChanges();
    HRESULT CommitChanges();
    HRESULT GetChangeState(uint* pState);
}

const GUID IID_IBDA_PinControl = {0x0DED49D5, 0xA8B7, 0x4D5D, [0x97, 0xA1, 0x12, 0xB0, 0xC1, 0x95, 0x87, 0x4D]};
@GUID(0x0DED49D5, 0xA8B7, 0x4D5D, [0x97, 0xA1, 0x12, 0xB0, 0xC1, 0x95, 0x87, 0x4D]);
interface IBDA_PinControl : IUnknown
{
    HRESULT GetPinID(uint* pulPinID);
    HRESULT GetPinType(uint* pulPinType);
    HRESULT RegistrationContext(uint* pulRegistrationCtx);
}

const GUID IID_IBDA_SignalProperties = {0xD2F1644B, 0xB409, 0x11D2, [0xBC, 0x69, 0x00, 0xA0, 0xC9, 0xEE, 0x9E, 0x16]};
@GUID(0xD2F1644B, 0xB409, 0x11D2, [0xBC, 0x69, 0x00, 0xA0, 0xC9, 0xEE, 0x9E, 0x16]);
interface IBDA_SignalProperties : IUnknown
{
    HRESULT PutNetworkType(const(Guid)* guidNetworkType);
    HRESULT GetNetworkType(Guid* pguidNetworkType);
    HRESULT PutSignalSource(uint ulSignalSource);
    HRESULT GetSignalSource(uint* pulSignalSource);
    HRESULT PutTuningSpace(const(Guid)* guidTuningSpace);
    HRESULT GetTuningSpace(Guid* pguidTuingSpace);
}

const GUID IID_IBDA_SignalStatistics = {0x1347D106, 0xCF3A, 0x428A, [0xA5, 0xCB, 0xAC, 0x0D, 0x9A, 0x2A, 0x43, 0x38]};
@GUID(0x1347D106, 0xCF3A, 0x428A, [0xA5, 0xCB, 0xAC, 0x0D, 0x9A, 0x2A, 0x43, 0x38]);
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

const GUID IID_IBDA_Topology = {0x79B56888, 0x7FEA, 0x4690, [0xB4, 0x5D, 0x38, 0xFD, 0x3C, 0x78, 0x49, 0xBE]};
@GUID(0x79B56888, 0x7FEA, 0x4690, [0xB4, 0x5D, 0x38, 0xFD, 0x3C, 0x78, 0x49, 0xBE]);
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

const GUID IID_IBDA_VoidTransform = {0x71985F46, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F46, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
interface IBDA_VoidTransform : IUnknown
{
    HRESULT Start();
    HRESULT Stop();
}

const GUID IID_IBDA_NullTransform = {0xDDF15B0D, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xDDF15B0D, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
interface IBDA_NullTransform : IUnknown
{
    HRESULT Start();
    HRESULT Stop();
}

const GUID IID_IBDA_FrequencyFilter = {0x71985F47, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F47, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
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

const GUID IID_IBDA_LNBInfo = {0x992CF102, 0x49F9, 0x4719, [0xA6, 0x64, 0xC4, 0xF2, 0x3E, 0x24, 0x08, 0xF4]};
@GUID(0x992CF102, 0x49F9, 0x4719, [0xA6, 0x64, 0xC4, 0xF2, 0x3E, 0x24, 0x08, 0xF4]);
interface IBDA_LNBInfo : IUnknown
{
    HRESULT put_LocalOscilatorFrequencyLowBand(uint ulLOFLow);
    HRESULT get_LocalOscilatorFrequencyLowBand(uint* pulLOFLow);
    HRESULT put_LocalOscilatorFrequencyHighBand(uint ulLOFHigh);
    HRESULT get_LocalOscilatorFrequencyHighBand(uint* pulLOFHigh);
    HRESULT put_HighLowSwitchFrequency(uint ulSwitchFrequency);
    HRESULT get_HighLowSwitchFrequency(uint* pulSwitchFrequency);
}

const GUID IID_IBDA_DiseqCommand = {0xF84E2AB0, 0x3C6B, 0x45E3, [0xA0, 0xFC, 0x86, 0x69, 0xD4, 0xB8, 0x1F, 0x11]};
@GUID(0xF84E2AB0, 0x3C6B, 0x45E3, [0xA0, 0xFC, 0x86, 0x69, 0xD4, 0xB8, 0x1F, 0x11]);
interface IBDA_DiseqCommand : IUnknown
{
    HRESULT put_EnableDiseqCommands(ubyte bEnable);
    HRESULT put_DiseqLNBSource(uint ulLNBSource);
    HRESULT put_DiseqUseToneBurst(ubyte bUseToneBurst);
    HRESULT put_DiseqRepeats(uint ulRepeats);
    HRESULT put_DiseqSendCommand(uint ulRequestId, uint ulcbCommandLen, char* pbCommand);
    HRESULT get_DiseqResponse(uint ulRequestId, uint* pulcbResponseLen, char* pbResponse);
}

const GUID IID_IBDA_AutoDemodulate = {0xDDF15B12, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xDDF15B12, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
interface IBDA_AutoDemodulate : IUnknown
{
    HRESULT put_AutoDemodulate();
}

const GUID IID_IBDA_AutoDemodulateEx = {0x34518D13, 0x1182, 0x48E6, [0xB2, 0x8F, 0xB2, 0x49, 0x87, 0x78, 0x73, 0x26]};
@GUID(0x34518D13, 0x1182, 0x48E6, [0xB2, 0x8F, 0xB2, 0x49, 0x87, 0x78, 0x73, 0x26]);
interface IBDA_AutoDemodulateEx : IBDA_AutoDemodulate
{
    HRESULT get_SupportedDeviceNodeTypes(uint ulcDeviceNodeTypesMax, uint* pulcDeviceNodeTypes, Guid* pguidDeviceNodeTypes);
    HRESULT get_SupportedVideoFormats(uint* pulAMTunerModeType, uint* pulAnalogVideoStandard);
    HRESULT get_AuxInputCount(uint* pulCompositeCount, uint* pulSvideoCount);
}

const GUID IID_IBDA_DigitalDemodulator = {0xEF30F379, 0x985B, 0x4D10, [0xB6, 0x40, 0xA7, 0x9D, 0x5E, 0x04, 0xE1, 0xE0]};
@GUID(0xEF30F379, 0x985B, 0x4D10, [0xB6, 0x40, 0xA7, 0x9D, 0x5E, 0x04, 0xE1, 0xE0]);
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

const GUID IID_IBDA_DigitalDemodulator2 = {0x525ED3EE, 0x5CF3, 0x4E1E, [0x9A, 0x06, 0x53, 0x68, 0xA8, 0x4F, 0x9A, 0x6E]};
@GUID(0x525ED3EE, 0x5CF3, 0x4E1E, [0x9A, 0x06, 0x53, 0x68, 0xA8, 0x4F, 0x9A, 0x6E]);
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

const GUID IID_IBDA_DigitalDemodulator3 = {0x13F19604, 0x7D32, 0x4359, [0x93, 0xA2, 0xA0, 0x52, 0x05, 0xD9, 0x0A, 0xC9]};
@GUID(0x13F19604, 0x7D32, 0x4359, [0x93, 0xA2, 0xA0, 0x52, 0x05, 0xD9, 0x0A, 0xC9]);
interface IBDA_DigitalDemodulator3 : IBDA_DigitalDemodulator2
{
    HRESULT put_SignalTimeouts(BDA_SIGNAL_TIMEOUTS* pSignalTimeouts);
    HRESULT get_SignalTimeouts(BDA_SIGNAL_TIMEOUTS* pSignalTimeouts);
    HRESULT put_PLPNumber(uint* pPLPNumber);
    HRESULT get_PLPNumber(uint* pPLPNumber);
}

enum __MIDL___MIDL_itf_bdaiface_0000_0019_0001
{
    KSPROPERTY_IPSINK_MULTICASTLIST = 0,
    KSPROPERTY_IPSINK_ADAPTER_DESCRIPTION = 1,
    KSPROPERTY_IPSINK_ADAPTER_ADDRESS = 2,
}

const GUID IID_ICCSubStreamFiltering = {0x4B2BD7EA, 0x8347, 0x467B, [0x8D, 0xBF, 0x62, 0xF7, 0x84, 0x92, 0x9C, 0xC3]};
@GUID(0x4B2BD7EA, 0x8347, 0x467B, [0x8D, 0xBF, 0x62, 0xF7, 0x84, 0x92, 0x9C, 0xC3]);
interface ICCSubStreamFiltering : IUnknown
{
    HRESULT get_SubstreamTypes(int* pTypes);
    HRESULT put_SubstreamTypes(int Types);
}

const GUID IID_IBDA_IPSinkControl = {0x3F4DC8E2, 0x4050, 0x11D3, [0x8F, 0x4B, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]};
@GUID(0x3F4DC8E2, 0x4050, 0x11D3, [0x8F, 0x4B, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]);
interface IBDA_IPSinkControl : IUnknown
{
    HRESULT GetMulticastList(uint* pulcbSize, ubyte** pbBuffer);
    HRESULT GetAdapterIPAddress(uint* pulcbSize, ubyte** pbBuffer);
}

const GUID IID_IBDA_IPSinkInfo = {0xA750108F, 0x492E, 0x4D51, [0x95, 0xF7, 0x64, 0x9B, 0x23, 0xFF, 0x7A, 0xD7]};
@GUID(0xA750108F, 0x492E, 0x4D51, [0x95, 0xF7, 0x64, 0x9B, 0x23, 0xFF, 0x7A, 0xD7]);
interface IBDA_IPSinkInfo : IUnknown
{
    HRESULT get_MulticastList(uint* pulcbAddresses, char* ppbAddressList);
    HRESULT get_AdapterIPAddress(BSTR* pbstrBuffer);
    HRESULT get_AdapterDescription(BSTR* pbstrBuffer);
}

const GUID IID_IEnumPIDMap = {0xAFB6C2A2, 0x2C41, 0x11D3, [0x8A, 0x60, 0x00, 0x00, 0xF8, 0x1E, 0x0E, 0x4A]};
@GUID(0xAFB6C2A2, 0x2C41, 0x11D3, [0x8A, 0x60, 0x00, 0x00, 0xF8, 0x1E, 0x0E, 0x4A]);
interface IEnumPIDMap : IUnknown
{
    HRESULT Next(uint cRequest, char* pPIDMap, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(IEnumPIDMap* ppIEnumPIDMap);
}

const GUID IID_IMPEG2PIDMap = {0xAFB6C2A1, 0x2C41, 0x11D3, [0x8A, 0x60, 0x00, 0x00, 0xF8, 0x1E, 0x0E, 0x4A]};
@GUID(0xAFB6C2A1, 0x2C41, 0x11D3, [0x8A, 0x60, 0x00, 0x00, 0xF8, 0x1E, 0x0E, 0x4A]);
interface IMPEG2PIDMap : IUnknown
{
    HRESULT MapPID(uint culPID, uint* pulPID, MEDIA_SAMPLE_CONTENT MediaSampleContent);
    HRESULT UnmapPID(uint culPID, uint* pulPID);
    HRESULT EnumPIDMap(IEnumPIDMap* pIEnumPIDMap);
}

const GUID IID_IFrequencyMap = {0x06FB45C1, 0x693C, 0x4EA7, [0xB7, 0x9F, 0x7A, 0x6A, 0x54, 0xD8, 0xDE, 0xF2]};
@GUID(0x06FB45C1, 0x693C, 0x4EA7, [0xB7, 0x9F, 0x7A, 0x6A, 0x54, 0xD8, 0xDE, 0xF2]);
interface IFrequencyMap : IUnknown
{
    HRESULT get_FrequencyMapping(uint* ulCount, uint** ppulList);
    HRESULT put_FrequencyMapping(uint ulCount, char* pList);
    HRESULT get_CountryCode(uint* pulCountryCode);
    HRESULT put_CountryCode(uint ulCountryCode);
    HRESULT get_DefaultFrequencyMapping(uint ulCountryCode, uint* pulCount, uint** ppulList);
    HRESULT get_CountryCodeList(uint* pulCount, uint** ppulList);
}

const GUID IID_IBDA_EasMessage = {0xD806973D, 0x3EBE, 0x46DE, [0x8F, 0xBB, 0x63, 0x58, 0xFE, 0x78, 0x42, 0x08]};
@GUID(0xD806973D, 0x3EBE, 0x46DE, [0x8F, 0xBB, 0x63, 0x58, 0xFE, 0x78, 0x42, 0x08]);
interface IBDA_EasMessage : IUnknown
{
    HRESULT get_EasMessage(uint ulEventID, IUnknown* ppEASObject);
}

const GUID IID_IBDA_TransportStreamInfo = {0x8E882535, 0x5F86, 0x47AB, [0x86, 0xCF, 0xC2, 0x81, 0xA7, 0x2A, 0x05, 0x49]};
@GUID(0x8E882535, 0x5F86, 0x47AB, [0x86, 0xCF, 0xC2, 0x81, 0xA7, 0x2A, 0x05, 0x49]);
interface IBDA_TransportStreamInfo : IUnknown
{
    HRESULT get_PatTableTickCount(uint* pPatTickCount);
}

const GUID IID_IBDA_ConditionalAccess = {0xCD51F1E0, 0x7BE9, 0x4123, [0x84, 0x82, 0xA2, 0xA7, 0x96, 0xC0, 0xA6, 0xB0]};
@GUID(0xCD51F1E0, 0x7BE9, 0x4123, [0x84, 0x82, 0xA2, 0xA7, 0x96, 0xC0, 0xA6, 0xB0]);
interface IBDA_ConditionalAccess : IUnknown
{
    HRESULT get_SmartCardStatus(SmartCardStatusType* pCardStatus, SmartCardAssociationType* pCardAssociation, BSTR* pbstrCardError, short* pfOOBLocked);
    HRESULT get_SmartCardInfo(BSTR* pbstrCardName, BSTR* pbstrCardManufacturer, short* pfDaylightSavings, ubyte* pbyRatingRegion, int* plTimeZoneOffsetMinutes, BSTR* pbstrLanguage, EALocationCodeType* pEALocationCode);
    HRESULT get_SmartCardApplications(uint* pulcApplications, uint ulcApplicationsMax, char* rgApplications);
    HRESULT get_Entitlement(ushort usVirtualChannel, EntitlementType* pEntitlement);
    HRESULT TuneByChannel(ushort usVirtualChannel);
    HRESULT SetProgram(ushort usProgramNumber);
    HRESULT AddProgram(ushort usProgramNumber);
    HRESULT RemoveProgram(ushort usProgramNumber);
    HRESULT GetModuleUI(ubyte byDialogNumber, BSTR* pbstrURL);
    HRESULT InformUIClosed(ubyte byDialogNumber, UICloseReasonType CloseReason);
}

const GUID IID_IBDA_DiagnosticProperties = {0x20E80CB5, 0xC543, 0x4C1B, [0x8E, 0xB3, 0x49, 0xE7, 0x19, 0xEE, 0xE7, 0xD4]};
@GUID(0x20E80CB5, 0xC543, 0x4C1B, [0x8E, 0xB3, 0x49, 0xE7, 0x19, 0xEE, 0xE7, 0xD4]);
interface IBDA_DiagnosticProperties : IPropertyBag
{
}

const GUID IID_IBDA_DRM = {0xF98D88B0, 0x1992, 0x4CD6, [0xA6, 0xD9, 0xB9, 0xAF, 0xAB, 0x99, 0x33, 0x0D]};
@GUID(0xF98D88B0, 0x1992, 0x4CD6, [0xA6, 0xD9, 0xB9, 0xAF, 0xAB, 0x99, 0x33, 0x0D]);
interface IBDA_DRM : IUnknown
{
    HRESULT GetDRMPairingStatus(uint* pdwStatus, int* phError);
    HRESULT PerformDRMPairing(BOOL fSync);
}

const GUID IID_IBDA_NameValueService = {0x7F0B3150, 0x7B81, 0x4AD4, [0x98, 0xE3, 0x7E, 0x90, 0x97, 0x09, 0x43, 0x01]};
@GUID(0x7F0B3150, 0x7B81, 0x4AD4, [0x98, 0xE3, 0x7E, 0x90, 0x97, 0x09, 0x43, 0x01]);
interface IBDA_NameValueService : IUnknown
{
    HRESULT GetValueNameByIndex(uint ulIndex, BSTR* pbstrName);
    HRESULT GetValue(BSTR bstrName, BSTR bstrLanguage, BSTR* pbstrValue);
    HRESULT SetValue(uint ulDialogRequest, BSTR bstrLanguage, BSTR bstrName, BSTR bstrValue, uint ulReserved);
}

const GUID IID_IBDA_ConditionalAccessEx = {0x497C3418, 0x23CB, 0x44BA, [0xBB, 0x62, 0x76, 0x9F, 0x50, 0x6F, 0xCE, 0xA7]};
@GUID(0x497C3418, 0x23CB, 0x44BA, [0xBB, 0x62, 0x76, 0x9F, 0x50, 0x6F, 0xCE, 0xA7]);
interface IBDA_ConditionalAccessEx : IUnknown
{
    HRESULT CheckEntitlementToken(uint ulDialogRequest, BSTR bstrLanguage, BDA_CONDITIONALACCESS_REQUESTTYPE RequestType, uint ulcbEntitlementTokenLen, char* pbEntitlementToken, uint* pulDescrambleStatus);
    HRESULT SetCaptureToken(uint ulcbCaptureTokenLen, char* pbCaptureToken);
    HRESULT OpenBroadcastMmi(uint ulDialogRequest, BSTR bstrLanguage, uint EventId);
    HRESULT CloseMmiDialog(uint ulDialogRequest, BSTR bstrLanguage, uint ulDialogNumber, BDA_CONDITIONALACCESS_MMICLOSEREASON ReasonCode, uint* pulSessionResult);
    HRESULT CreateDialogRequestNumber(uint* pulDialogRequestNumber);
}

const GUID IID_IBDA_ISDBConditionalAccess = {0x5E68C627, 0x16C2, 0x4E6C, [0xB1, 0xE2, 0xD0, 0x01, 0x70, 0xCD, 0xAA, 0x0F]};
@GUID(0x5E68C627, 0x16C2, 0x4E6C, [0xB1, 0xE2, 0xD0, 0x01, 0x70, 0xCD, 0xAA, 0x0F]);
interface IBDA_ISDBConditionalAccess : IUnknown
{
    HRESULT SetIsdbCasRequest(uint ulRequestId, uint ulcbRequestBufferLen, char* pbRequestBuffer);
}

const GUID IID_IBDA_EventingService = {0x207C413F, 0x00DC, 0x4C61, [0xBA, 0xD6, 0x6F, 0xEE, 0x1F, 0xF0, 0x70, 0x64]};
@GUID(0x207C413F, 0x00DC, 0x4C61, [0xBA, 0xD6, 0x6F, 0xEE, 0x1F, 0xF0, 0x70, 0x64]);
interface IBDA_EventingService : IUnknown
{
    HRESULT CompleteEvent(uint ulEventID, uint ulEventResult);
}

const GUID IID_IBDA_AUX = {0x7DEF4C09, 0x6E66, 0x4567, [0xA8, 0x19, 0xF0, 0xE1, 0x7F, 0x4A, 0x81, 0xAB]};
@GUID(0x7DEF4C09, 0x6E66, 0x4567, [0xA8, 0x19, 0xF0, 0xE1, 0x7F, 0x4A, 0x81, 0xAB]);
interface IBDA_AUX : IUnknown
{
    HRESULT QueryCapabilities(uint* pdwNumAuxInputsBSTR);
    HRESULT EnumCapability(uint dwIndex, uint* dwInputID, Guid* pConnectorType, uint* ConnTypeNum, uint* NumVideoStds, ulong* AnalogStds);
}

const GUID IID_IBDA_Encoder = {0x3A8BAD59, 0x59FE, 0x4559, [0xA0, 0xBA, 0x39, 0x6C, 0xFA, 0xA9, 0x8A, 0xE3]};
@GUID(0x3A8BAD59, 0x59FE, 0x4559, [0xA0, 0xBA, 0x39, 0x6C, 0xFA, 0xA9, 0x8A, 0xE3]);
interface IBDA_Encoder : IUnknown
{
    HRESULT QueryCapabilities(uint* NumAudioFmts, uint* NumVideoFmts);
    HRESULT EnumAudioCapability(uint FmtIndex, uint* MethodID, uint* AlgorithmType, uint* SamplingRate, uint* BitDepth, uint* NumChannels);
    HRESULT EnumVideoCapability(uint FmtIndex, uint* MethodID, uint* AlgorithmType, uint* VerticalSize, uint* HorizontalSize, uint* AspectRatio, uint* FrameRateCode, uint* ProgressiveSequence);
    HRESULT SetParameters(uint AudioBitrateMode, uint AudioBitrate, uint AudioMethodID, uint AudioProgram, uint VideoBitrateMode, uint VideoBitrate, uint VideoMethodID);
    HRESULT GetState(uint* AudioBitrateMax, uint* AudioBitrateMin, uint* AudioBitrateMode, uint* AudioBitrateStepping, uint* AudioBitrate, uint* AudioMethodID, uint* AvailableAudioPrograms, uint* AudioProgram, uint* VideoBitrateMax, uint* VideoBitrateMin, uint* VideoBitrateMode, uint* VideoBitrate, uint* VideoBitrateStepping, uint* VideoMethodID, uint* SignalSourceID, ulong* SignalFormat, int* SignalLock, int* SignalLevel, uint* SignalToNoiseRatio);
}

const GUID IID_IBDA_FDC = {0x138ADC7E, 0x58AE, 0x437F, [0xB0, 0xB4, 0xC9, 0xFE, 0x19, 0xD5, 0xB4, 0xAC]};
@GUID(0x138ADC7E, 0x58AE, 0x437F, [0xB0, 0xB4, 0xC9, 0xFE, 0x19, 0xD5, 0xB4, 0xAC]);
interface IBDA_FDC : IUnknown
{
    HRESULT GetStatus(uint* CurrentBitrate, int* CarrierLock, uint* CurrentFrequency, int* CurrentSpectrumInversion, BSTR* CurrentPIDList, BSTR* CurrentTIDList, int* Overflow);
    HRESULT RequestTables(BSTR TableIDs);
    HRESULT AddPid(BSTR PidsToAdd, uint* RemainingFilterEntries);
    HRESULT RemovePid(BSTR PidsToRemove);
    HRESULT AddTid(BSTR TidsToAdd, BSTR* CurrentTidList);
    HRESULT RemoveTid(BSTR TidsToRemove);
    HRESULT GetTableSection(uint* Pid, uint MaxBufferSize, uint* ActualSize, ubyte* SecBuffer);
}

const GUID IID_IBDA_GuideDataDeliveryService = {0xC0AFCB73, 0x23E7, 0x4BC6, [0xBA, 0xFA, 0xFD, 0xC1, 0x67, 0xB4, 0x71, 0x9F]};
@GUID(0xC0AFCB73, 0x23E7, 0x4BC6, [0xBA, 0xFA, 0xFD, 0xC1, 0x67, 0xB4, 0x71, 0x9F]);
interface IBDA_GuideDataDeliveryService : IUnknown
{
    HRESULT GetGuideDataType(Guid* pguidDataType);
    HRESULT GetGuideData(uint* pulcbBufferLen, ubyte* pbBuffer, uint* pulGuideDataPercentageProgress);
    HRESULT RequestGuideDataUpdate();
    HRESULT GetTuneXmlFromServiceIdx(ulong ul64ServiceIdx, BSTR* pbstrTuneXml);
    HRESULT GetServices(uint* pulcbBufferLen, ubyte* pbBuffer);
    HRESULT GetServiceInfoFromTuneXml(BSTR bstrTuneXml, BSTR* pbstrServiceDescription);
}

const GUID IID_IBDA_DRMService = {0xBFF6B5BB, 0xB0AE, 0x484C, [0x9D, 0xCA, 0x73, 0x52, 0x8F, 0xB0, 0xB4, 0x6E]};
@GUID(0xBFF6B5BB, 0xB0AE, 0x484C, [0x9D, 0xCA, 0x73, 0x52, 0x8F, 0xB0, 0xB4, 0x6E]);
interface IBDA_DRMService : IUnknown
{
    HRESULT SetDRM(Guid* puuidNewDrm);
    HRESULT GetDRMStatus(BSTR* pbstrDrmUuidList, Guid* DrmUuid);
}

const GUID IID_IBDA_WMDRMSession = {0x4BE6FA3D, 0x07CD, 0x4139, [0x8B, 0x80, 0x8C, 0x18, 0xBA, 0x3A, 0xEC, 0x88]};
@GUID(0x4BE6FA3D, 0x07CD, 0x4139, [0x8B, 0x80, 0x8C, 0x18, 0xBA, 0x3A, 0xEC, 0x88]);
interface IBDA_WMDRMSession : IUnknown
{
    HRESULT GetStatus(uint* MaxCaptureToken, uint* MaxStreamingPid, uint* MaxLicense, uint* MinSecurityLevel, uint* RevInfoSequenceNumber, ulong* RevInfoIssuedTime, uint* RevInfoTTL, uint* RevListVersion, uint* ulState);
    HRESULT SetRevInfo(uint ulRevInfoLen, char* pbRevInfo);
    HRESULT SetCrl(uint ulCrlLen, char* pbCrlLen);
    HRESULT TransactMessage(uint ulcbRequest, char* pbRequest, uint* pulcbResponse, ubyte* pbResponse);
    HRESULT GetLicense(Guid* uuidKey, uint* pulPackageLen, ubyte* pbPackage);
    HRESULT ReissueLicense(Guid* uuidKey);
    HRESULT RenewLicense(uint ulInXmrLicenseLen, char* pbInXmrLicense, uint ulEntitlementTokenLen, char* pbEntitlementToken, uint* pulDescrambleStatus, uint* pulOutXmrLicenseLen, ubyte* pbOutXmrLicense);
    HRESULT GetKeyInfo(uint* pulKeyInfoLen, ubyte* pbKeyInfo);
}

const GUID IID_IBDA_WMDRMTuner = {0x86D979CF, 0xA8A7, 0x4F94, [0xB5, 0xFB, 0x14, 0xC0, 0xAC, 0xA6, 0x8F, 0xE6]};
@GUID(0x86D979CF, 0xA8A7, 0x4F94, [0xB5, 0xFB, 0x14, 0xC0, 0xAC, 0xA6, 0x8F, 0xE6]);
interface IBDA_WMDRMTuner : IUnknown
{
    HRESULT PurchaseEntitlement(uint ulDialogRequest, BSTR bstrLanguage, uint ulPurchaseTokenLen, char* pbPurchaseToken, uint* pulDescrambleStatus, uint* pulCaptureTokenLen, ubyte* pbCaptureToken);
    HRESULT CancelCaptureToken(uint ulCaptureTokenLen, char* pbCaptureToken);
    HRESULT SetPidProtection(uint ulPid, Guid* uuidKey);
    HRESULT GetPidProtection(uint pulPid, Guid* uuidKey);
    HRESULT SetSyncValue(uint ulSyncValue);
    HRESULT GetStartCodeProfile(uint* pulStartCodeProfileLen, ubyte* pbStartCodeProfile);
}

const GUID IID_IBDA_DRIDRMService = {0x1F9BC2A5, 0x44A3, 0x4C52, [0xAA, 0xB1, 0x0B, 0xBC, 0xE5, 0xA1, 0x38, 0x1D]};
@GUID(0x1F9BC2A5, 0x44A3, 0x4C52, [0xAA, 0xB1, 0x0B, 0xBC, 0xE5, 0xA1, 0x38, 0x1D]);
interface IBDA_DRIDRMService : IUnknown
{
    HRESULT SetDRM(BSTR bstrNewDrm);
    HRESULT GetDRMStatus(BSTR* pbstrDrmUuidList, Guid* DrmUuid);
    HRESULT GetPairingStatus(BDA_DrmPairingError* penumPairingStatus);
}

const GUID IID_IBDA_DRIWMDRMSession = {0x05C690F8, 0x56DB, 0x4BB2, [0xB0, 0x53, 0x79, 0xC1, 0x20, 0x98, 0xBB, 0x26]};
@GUID(0x05C690F8, 0x56DB, 0x4BB2, [0xB0, 0x53, 0x79, 0xC1, 0x20, 0x98, 0xBB, 0x26]);
interface IBDA_DRIWMDRMSession : IUnknown
{
    HRESULT AcknowledgeLicense(HRESULT hrLicenseAck);
    HRESULT ProcessLicenseChallenge(uint dwcbLicenseMessage, char* pbLicenseMessage, uint* pdwcbLicenseResponse, char* ppbLicenseResponse);
    HRESULT ProcessRegistrationChallenge(uint dwcbRegistrationMessage, char* pbRegistrationMessage, uint* pdwcbRegistrationResponse, ubyte** ppbRegistrationResponse);
    HRESULT SetRevInfo(uint dwRevInfoLen, char* pbRevInfo, uint* pdwResponse);
    HRESULT SetCrl(uint dwCrlLen, char* pbCrlLen, uint* pdwResponse);
    HRESULT GetHMSAssociationData();
    HRESULT GetLastCardeaError(uint* pdwError);
}

const GUID IID_IBDA_MUX = {0x942AAFEC, 0x4C05, 0x4C74, [0xB8, 0xEB, 0x87, 0x06, 0xC2, 0xA4, 0x94, 0x3F]};
@GUID(0x942AAFEC, 0x4C05, 0x4C74, [0xB8, 0xEB, 0x87, 0x06, 0xC2, 0xA4, 0x94, 0x3F]);
interface IBDA_MUX : IUnknown
{
    HRESULT SetPidList(uint ulPidListCount, char* pbPidListBuffer);
    HRESULT GetPidList(uint* pulPidListCount, BDA_MUX_PIDLISTITEM* pbPidListBuffer);
}

const GUID IID_IBDA_TransportStreamSelector = {0x1DCFAFE9, 0xB45E, 0x41B3, [0xBB, 0x2A, 0x56, 0x1E, 0xB1, 0x29, 0xAE, 0x98]};
@GUID(0x1DCFAFE9, 0xB45E, 0x41B3, [0xBB, 0x2A, 0x56, 0x1E, 0xB1, 0x29, 0xAE, 0x98]);
interface IBDA_TransportStreamSelector : IUnknown
{
    HRESULT SetTSID(ushort usTSID);
    HRESULT GetTSInformation(uint* pulTSInformationBufferLen, char* pbTSInformationBuffer);
}

const GUID IID_IBDA_UserActivityService = {0x53B14189, 0xE478, 0x4B7A, [0xA1, 0xFF, 0x50, 0x6D, 0xB4, 0xB9, 0x9D, 0xFE]};
@GUID(0x53B14189, 0xE478, 0x4B7A, [0xA1, 0xFF, 0x50, 0x6D, 0xB4, 0xB9, 0x9D, 0xFE]);
interface IBDA_UserActivityService : IUnknown
{
    HRESULT SetCurrentTunerUseReason(uint dwUseReason);
    HRESULT GetUserActivityInterval(uint* pdwActivityInterval);
    HRESULT UserActivityDetected();
}

const GUID IID_IESEvent = {0x1F0E5357, 0xAF43, 0x44E6, [0x85, 0x47, 0x65, 0x4C, 0x64, 0x51, 0x45, 0xD2]};
@GUID(0x1F0E5357, 0xAF43, 0x44E6, [0x85, 0x47, 0x65, 0x4C, 0x64, 0x51, 0x45, 0xD2]);
interface IESEvent : IUnknown
{
    HRESULT GetEventId(uint* pdwEventId);
    HRESULT GetEventType(Guid* pguidEventType);
    HRESULT SetCompletionStatus(uint dwResult);
    HRESULT GetData(SAFEARRAY** pbData);
    HRESULT GetStringData(BSTR* pbstrData);
}

const GUID IID_IESEvents = {0xABD414BF, 0xCFE5, 0x4E5E, [0xAF, 0x5B, 0x4B, 0x4E, 0x49, 0xC5, 0xBF, 0xEB]};
@GUID(0xABD414BF, 0xCFE5, 0x4E5E, [0xAF, 0x5B, 0x4B, 0x4E, 0x49, 0xC5, 0xBF, 0xEB]);
interface IESEvents : IUnknown
{
    HRESULT OnESEventReceived(Guid guidEventType, IESEvent pESEvent);
}

const GUID IID_IBroadcastEvent = {0x3B21263F, 0x26E8, 0x489D, [0xAA, 0xC4, 0x92, 0x4F, 0x7E, 0xFD, 0x95, 0x11]};
@GUID(0x3B21263F, 0x26E8, 0x489D, [0xAA, 0xC4, 0x92, 0x4F, 0x7E, 0xFD, 0x95, 0x11]);
interface IBroadcastEvent : IUnknown
{
    HRESULT Fire(Guid EventID);
}

const GUID IID_IBroadcastEventEx = {0x3D9E3887, 0x1929, 0x423F, [0x80, 0x21, 0x43, 0x68, 0x2D, 0xE9, 0x54, 0x48]};
@GUID(0x3D9E3887, 0x1929, 0x423F, [0x80, 0x21, 0x43, 0x68, 0x2D, 0xE9, 0x54, 0x48]);
interface IBroadcastEventEx : IBroadcastEvent
{
    HRESULT FireEx(Guid EventID, uint Param1, uint Param2, uint Param3, uint Param4);
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

enum AMExtendedSeekingCapabilities
{
    AM_EXSEEK_CANSEEK = 1,
    AM_EXSEEK_CANSCAN = 2,
    AM_EXSEEK_MARKERSEEK = 4,
    AM_EXSEEK_SCANWITHOUTCLOCK = 8,
    AM_EXSEEK_NOSTANDARDREPAINT = 16,
    AM_EXSEEK_BUFFERING = 32,
    AM_EXSEEK_SENDS_VIDEOFRAMEREADY = 64,
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

enum AM_LINE21_CCLEVEL
{
    AM_L21_CCLEVEL_TC2 = 0,
}

enum AM_LINE21_CCSERVICE
{
    AM_L21_CCSERVICE_None = 0,
    AM_L21_CCSERVICE_Caption1 = 1,
    AM_L21_CCSERVICE_Caption2 = 2,
    AM_L21_CCSERVICE_Text1 = 3,
    AM_L21_CCSERVICE_Text2 = 4,
    AM_L21_CCSERVICE_XDS = 5,
    AM_L21_CCSERVICE_DefChannel = 10,
    AM_L21_CCSERVICE_Invalid = 11,
}

enum AM_LINE21_CCSTATE
{
    AM_L21_CCSTATE_Off = 0,
    AM_L21_CCSTATE_On = 1,
}

enum AM_LINE21_CCSTYLE
{
    AM_L21_CCSTYLE_None = 0,
    AM_L21_CCSTYLE_PopOn = 1,
    AM_L21_CCSTYLE_PaintOn = 2,
    AM_L21_CCSTYLE_RollUp = 3,
}

enum AM_LINE21_DRAWBGMODE
{
    AM_L21_DRAWBGMODE_Opaque = 0,
    AM_L21_DRAWBGMODE_Transparent = 1,
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

const GUID CLSID_FilgraphManager = {0xE436EBB3, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EBB3, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct FilgraphManager;

const GUID IID_IAMCollection = {0x56A868B9, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B9, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IAMCollection : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT Item(int lItem, IUnknown* ppUnk);
    HRESULT get__NewEnum(IUnknown* ppUnk);
}

const GUID IID_IMediaControl = {0x56A868B1, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B1, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IMediaEvent = {0x56A868B6, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B6, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMediaEvent : IDispatch
{
    HRESULT GetEventHandle(int* hEvent);
    HRESULT GetEvent(int* lEventCode, int* lParam1, int* lParam2, int msTimeout);
    HRESULT WaitForCompletion(int msTimeout, int* pEvCode);
    HRESULT CancelDefaultHandling(int lEvCode);
    HRESULT RestoreDefaultHandling(int lEvCode);
    HRESULT FreeEventParams(int lEvCode, int lParam1, int lParam2);
}

const GUID IID_IMediaEventEx = {0x56A868C0, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868C0, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMediaEventEx : IMediaEvent
{
    HRESULT SetNotifyWindow(int hwnd, int lMsg, int lInstanceData);
    HRESULT SetNotifyFlags(int lNoNotifyFlags);
    HRESULT GetNotifyFlags(int* lplNoNotifyFlags);
}

const GUID IID_IMediaPosition = {0x56A868B2, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B2, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IBasicAudio = {0x56A868B3, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B3, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IBasicAudio : IDispatch
{
    HRESULT put_Volume(int lVolume);
    HRESULT get_Volume(int* plVolume);
    HRESULT put_Balance(int lBalance);
    HRESULT get_Balance(int* plBalance);
}

const GUID IID_IVideoWindow = {0x56A868B4, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B4, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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
    HRESULT put_Owner(int Owner);
    HRESULT get_Owner(int* Owner);
    HRESULT put_MessageDrain(int Drain);
    HRESULT get_MessageDrain(int* Drain);
    HRESULT get_BorderColor(int* Color);
    HRESULT put_BorderColor(int Color);
    HRESULT get_FullScreenMode(int* FullScreenMode);
    HRESULT put_FullScreenMode(int FullScreenMode);
    HRESULT SetWindowForeground(int Focus);
    HRESULT NotifyOwnerMessage(int hwnd, int uMsg, int wParam, int lParam);
    HRESULT SetWindowPosition(int Left, int Top, int Width, int Height);
    HRESULT GetWindowPosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    HRESULT GetMinIdealImageSize(int* pWidth, int* pHeight);
    HRESULT GetMaxIdealImageSize(int* pWidth, int* pHeight);
    HRESULT GetRestorePosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    HRESULT HideCursor(int HideCursor);
    HRESULT IsCursorHidden(int* CursorHidden);
}

const GUID IID_IBasicVideo = {0x56A868B5, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B5, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IBasicVideo2 = {0x329BB360, 0xF6EA, 0x11D1, [0x90, 0x38, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x98]};
@GUID(0x329BB360, 0xF6EA, 0x11D1, [0x90, 0x38, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x98]);
interface IBasicVideo2 : IBasicVideo
{
    HRESULT GetPreferredAspectRatio(int* plAspectX, int* plAspectY);
}

const GUID IID_IDeferredCommand = {0x56A868B8, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B8, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IDeferredCommand : IUnknown
{
    HRESULT Cancel();
    HRESULT Confidence(int* pConfidence);
    HRESULT Postpone(double newtime);
    HRESULT GetHResult(int* phrResult);
}

const GUID IID_IQueueCommand = {0x56A868B7, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868B7, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IQueueCommand : IUnknown
{
    HRESULT InvokeAtStreamTime(IDeferredCommand* pCmd, double time, Guid* iid, int dispidMethod, short wFlags, int cArgs, VARIANT* pDispParams, VARIANT* pvarResult, short* puArgErr);
    HRESULT InvokeAtPresentationTime(IDeferredCommand* pCmd, double time, Guid* iid, int dispidMethod, short wFlags, int cArgs, VARIANT* pDispParams, VARIANT* pvarResult, short* puArgErr);
}

const GUID IID_IFilterInfo = {0x56A868BA, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868BA, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IRegFilterInfo = {0x56A868BB, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868BB, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IRegFilterInfo : IDispatch
{
    HRESULT get_Name(BSTR* strName);
    HRESULT Filter(IDispatch* ppUnk);
}

const GUID IID_IMediaTypeInfo = {0x56A868BC, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868BC, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
interface IMediaTypeInfo : IDispatch
{
    HRESULT get_Type(BSTR* strType);
    HRESULT get_Subtype(BSTR* strType);
}

const GUID IID_IPinInfo = {0x56A868BD, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0x56A868BD, 0x0AD4, 0x11CE, [0xB0, 0x3A, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
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

const GUID IID_IAMStats = {0xBC9BCF80, 0xDCD2, 0x11D2, [0xAB, 0xF6, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]};
@GUID(0xBC9BCF80, 0xDCD2, 0x11D2, [0xAB, 0xF6, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x75]);
interface IAMStats : IDispatch
{
    HRESULT Reset();
    HRESULT get_Count(int* plCount);
    HRESULT GetValueByIndex(int lIndex, BSTR* szName, int* lCount, double* dLast, double* dAverage, double* dStdDev, double* dMin, double* dMax);
    HRESULT GetValueByName(BSTR szName, int* lIndex, int* lCount, double* dLast, double* dAverage, double* dStdDev, double* dMin, double* dMax);
    HRESULT GetIndex(BSTR szName, int lCreate, int* plIndex);
    HRESULT AddValue(int lIndex, double dValue);
}

struct AMVAUncompBufferInfo
{
    uint dwMinNumSurfaces;
    uint dwMaxNumSurfaces;
    DDPIXELFORMAT ddUncompPixelFormat;
}

struct AMVAUncompDataInfo
{
    uint dwUncompWidth;
    uint dwUncompHeight;
    DDPIXELFORMAT ddUncompPixelFormat;
}

struct AMVAInternalMemInfo
{
    uint dwScratchMemAlloc;
}

struct AMVACompBufferInfo
{
    uint dwNumCompBuffers;
    uint dwWidthToCreate;
    uint dwHeightToCreate;
    uint dwBytesToAllocate;
    DDSCAPS2 ddCompCaps;
    DDPIXELFORMAT ddPixelFormat;
}

struct AMVABeginFrameInfo
{
    uint dwDestSurfaceIndex;
    void* pInputData;
    uint dwSizeInputData;
    void* pOutputData;
    uint dwSizeOutputData;
}

struct AMVAEndFrameInfo
{
    uint dwSizeMiscData;
    void* pMiscData;
}

struct AMVABUFFERINFO
{
    uint dwTypeIndex;
    uint dwBufferIndex;
    uint dwDataOffset;
    uint dwDataSize;
}

const GUID IID_IAMVideoAcceleratorNotify = {0x256A6A21, 0xFBAD, 0x11D1, [0x82, 0xBF, 0x00, 0xA0, 0xC9, 0x69, 0x6C, 0x8F]};
@GUID(0x256A6A21, 0xFBAD, 0x11D1, [0x82, 0xBF, 0x00, 0xA0, 0xC9, 0x69, 0x6C, 0x8F]);
interface IAMVideoAcceleratorNotify : IUnknown
{
    HRESULT GetUncompSurfacesInfo(const(Guid)* pGuid, AMVAUncompBufferInfo* pUncompBufferInfo);
    HRESULT SetUncompSurfacesInfo(uint dwActualUncompSurfacesAllocated);
    HRESULT GetCreateVideoAcceleratorData(const(Guid)* pGuid, uint* pdwSizeMiscData, void** ppMiscData);
}

const GUID IID_IAMVideoAccelerator = {0x256A6A22, 0xFBAD, 0x11D1, [0x82, 0xBF, 0x00, 0xA0, 0xC9, 0x69, 0x6C, 0x8F]};
@GUID(0x256A6A22, 0xFBAD, 0x11D1, [0x82, 0xBF, 0x00, 0xA0, 0xC9, 0x69, 0x6C, 0x8F]);
interface IAMVideoAccelerator : IUnknown
{
    HRESULT GetVideoAcceleratorGUIDs(uint* pdwNumGuidsSupported, char* pGuidsSupported);
    HRESULT GetUncompFormatsSupported(const(Guid)* pGuid, uint* pdwNumFormatsSupported, char* pFormatsSupported);
    HRESULT GetInternalMemInfo(const(Guid)* pGuid, const(AMVAUncompDataInfo)* pamvaUncompDataInfo, AMVAInternalMemInfo* pamvaInternalMemInfo);
    HRESULT GetCompBufferInfo(const(Guid)* pGuid, const(AMVAUncompDataInfo)* pamvaUncompDataInfo, uint* pdwNumTypesCompBuffers, char* pamvaCompBufferInfo);
    HRESULT GetInternalCompBufferInfo(uint* pdwNumTypesCompBuffers, char* pamvaCompBufferInfo);
    HRESULT BeginFrame(const(AMVABeginFrameInfo)* amvaBeginFrameInfo);
    HRESULT EndFrame(const(AMVAEndFrameInfo)* pEndFrameInfo);
    HRESULT GetBuffer(uint dwTypeIndex, uint dwBufferIndex, BOOL bReadOnly, void** ppBuffer, int* lpStride);
    HRESULT ReleaseBuffer(uint dwTypeIndex, uint dwBufferIndex);
    HRESULT Execute(uint dwFunction, void* lpPrivateInputData, uint cbPrivateInputData, void* lpPrivateOutputDat, uint cbPrivateOutputData, uint dwNumBuffers, char* pamvaBufferInfo);
    HRESULT QueryRenderStatus(uint dwTypeIndex, uint dwBufferIndex, uint dwFlags);
    HRESULT DisplayFrame(uint dwFlipToIndex, IMediaSample pMediaSample);
}

struct AM_WST_PAGE
{
    uint dwPageNr;
    uint dwSubPageNr;
    ubyte* pucPageData;
}

enum AM_WST_LEVEL
{
    AM_WST_LEVEL_1_5 = 0,
}

enum AM_WST_SERVICE
{
    AM_WST_SERVICE_None = 0,
    AM_WST_SERVICE_Text = 1,
    AM_WST_SERVICE_IDS = 2,
    AM_WST_SERVICE_Invalid = 3,
}

enum AM_WST_STATE
{
    AM_WST_STATE_Off = 0,
    AM_WST_STATE_On = 1,
}

enum AM_WST_STYLE
{
    AM_WST_STYLE_None = 0,
    AM_WST_STYLE_Invers = 1,
}

enum AM_WST_DRAWBGMODE
{
    AM_WST_DRAWBGMODE_Opaque = 0,
    AM_WST_DRAWBGMODE_Transparent = 1,
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

const GUID IID_IKsTopologyInfo = {0x720D4AC0, 0x7533, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x720D4AC0, 0x7533, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
interface IKsTopologyInfo : IUnknown
{
    HRESULT get_NumCategories(uint* pdwNumCategories);
    HRESULT get_Category(uint dwIndex, Guid* pCategory);
    HRESULT get_NumConnections(uint* pdwNumConnections);
    HRESULT get_ConnectionInfo(uint dwIndex, KSTOPOLOGY_CONNECTION* pConnectionInfo);
    HRESULT get_NodeName(uint dwNodeId, char* pwchNodeName, uint dwBufSize, uint* pdwNameLen);
    HRESULT get_NumNodes(uint* pdwNumNodes);
    HRESULT get_NodeType(uint dwNodeId, Guid* pNodeType);
    HRESULT CreateNodeInstance(uint dwNodeId, const(Guid)* iid, void** ppvObject);
}

const GUID IID_ISelector = {0x1ABDAECA, 0x68B6, 0x4F83, [0x93, 0x71, 0xB4, 0x13, 0x90, 0x7C, 0x7B, 0x9F]};
@GUID(0x1ABDAECA, 0x68B6, 0x4F83, [0x93, 0x71, 0xB4, 0x13, 0x90, 0x7C, 0x7B, 0x9F]);
interface ISelector : IUnknown
{
    HRESULT get_NumSources(uint* pdwNumSources);
    HRESULT get_SourceNodeId(uint* pdwPinId);
    HRESULT put_SourceNodeId(uint dwPinId);
}

const GUID IID_ICameraControl = {0x2BA1785D, 0x4D1B, 0x44EF, [0x85, 0xE8, 0xC7, 0xF1, 0xD3, 0xF2, 0x01, 0x84]};
@GUID(0x2BA1785D, 0x4D1B, 0x44EF, [0x85, 0xE8, 0xC7, 0xF1, 0xD3, 0xF2, 0x01, 0x84]);
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
    HRESULT get_FocalLengths(int* plOcularFocalLength, int* plObjectiveFocalLengthMin, int* plObjectiveFocalLengthMax);
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

const GUID IID_IVideoProcAmp = {0x4050560E, 0x42A7, 0x413A, [0x85, 0xC2, 0x09, 0x26, 0x9A, 0x2D, 0x0F, 0x44]};
@GUID(0x4050560E, 0x42A7, 0x413A, [0x85, 0xC2, 0x09, 0x26, 0x9A, 0x2D, 0x0F, 0x44]);
interface IVideoProcAmp : IUnknown
{
    HRESULT get_BacklightCompensation(int* pValue, int* pFlags);
    HRESULT put_BacklightCompensation(int Value, int Flags);
    HRESULT getRange_BacklightCompensation(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
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
    HRESULT getRange_WhiteBalanceComponent(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
}

const GUID IID_IKsNodeControl = {0x11737C14, 0x24A7, 0x4BB5, [0x81, 0xA0, 0x0D, 0x00, 0x38, 0x13, 0xB0, 0xC4]};
@GUID(0x11737C14, 0x24A7, 0x4BB5, [0x81, 0xA0, 0x0D, 0x00, 0x38, 0x13, 0xB0, 0xC4]);
interface IKsNodeControl : IUnknown
{
    HRESULT put_NodeId(uint dwNodeId);
    HRESULT put_KsControl(void* pKsControl);
}

const GUID IID_IConfigAsfWriter = {0x45086030, 0xF7E4, 0x486A, [0xB5, 0x04, 0x82, 0x6B, 0xB5, 0x79, 0x2A, 0x3B]};
@GUID(0x45086030, 0xF7E4, 0x486A, [0xB5, 0x04, 0x82, 0x6B, 0xB5, 0x79, 0x2A, 0x3B]);
interface IConfigAsfWriter : IUnknown
{
    HRESULT ConfigureFilterUsingProfileId(uint dwProfileId);
    HRESULT GetCurrentProfileId(uint* pdwProfileId);
    HRESULT ConfigureFilterUsingProfileGuid(const(Guid)* guidProfile);
    HRESULT GetCurrentProfileGuid(Guid* pProfileGuid);
    HRESULT ConfigureFilterUsingProfile(IWMProfile pProfile);
    HRESULT GetCurrentProfile(IWMProfile* ppProfile);
    HRESULT SetIndexMode(BOOL bIndexFile);
    HRESULT GetIndexMode(int* pbIndexFile);
}

const GUID IID_IConfigAsfWriter2 = {0x7989CCAA, 0x53F0, 0x44F0, [0x88, 0x4A, 0xF3, 0xB0, 0x3F, 0x6A, 0xE0, 0x66]};
@GUID(0x7989CCAA, 0x53F0, 0x44F0, [0x88, 0x4A, 0xF3, 0xB0, 0x3F, 0x6A, 0xE0, 0x66]);
interface IConfigAsfWriter2 : IConfigAsfWriter
{
    HRESULT StreamNumFromPin(IPin pPin, ushort* pwStreamNum);
    HRESULT SetParam(uint dwParam, uint dwParam1, uint dwParam2);
    HRESULT GetParam(uint dwParam, uint* pdwParam1, uint* pdwParam2);
    HRESULT ResetMultiPassState();
}

enum STREAM_TYPE
{
    STREAMTYPE_READ = 0,
    STREAMTYPE_WRITE = 1,
    STREAMTYPE_TRANSFORM = 2,
}

enum STREAM_STATE
{
    STREAMSTATE_STOP = 0,
    STREAMSTATE_RUN = 1,
}

enum __MIDL___MIDL_itf_mmstream_0000_0000_0003
{
    COMPSTAT_NOUPDATEOK = 1,
    COMPSTAT_WAIT = 2,
    COMPSTAT_ABORT = 4,
}

enum __MIDL___MIDL_itf_mmstream_0000_0000_0004
{
    MMSSF_HASCLOCK = 1,
    MMSSF_SUPPORTSEEK = 2,
    MMSSF_ASYNCHRONOUS = 4,
}

enum __MIDL___MIDL_itf_mmstream_0000_0000_0005
{
    SSUPDATE_ASYNC = 1,
    SSUPDATE_CONTINUOUS = 2,
}

const GUID IID_IMultiMediaStream = {0xB502D1BC, 0x9A57, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xB502D1BC, 0x9A57, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IMultiMediaStream : IUnknown
{
    HRESULT GetInformation(uint* pdwFlags, STREAM_TYPE* pStreamType);
    HRESULT GetMediaStream(Guid* idPurpose, IMediaStream* ppMediaStream);
    HRESULT EnumMediaStreams(int Index, IMediaStream* ppMediaStream);
    HRESULT GetState(STREAM_STATE* pCurrentState);
    HRESULT SetState(STREAM_STATE NewState);
    HRESULT GetTime(long* pCurrentTime);
    HRESULT GetDuration(long* pDuration);
    HRESULT Seek(long SeekTime);
    HRESULT GetEndOfStreamEventHandle(HANDLE* phEOS);
}

const GUID IID_IMediaStream = {0xB502D1BD, 0x9A57, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xB502D1BD, 0x9A57, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IMediaStream : IUnknown
{
    HRESULT GetMultiMediaStream(IMultiMediaStream* ppMultiMediaStream);
    HRESULT GetInformation(Guid* pPurposeId, STREAM_TYPE* pType);
    HRESULT SetSameFormat(IMediaStream pStreamThatHasDesiredFormat, uint dwFlags);
    HRESULT AllocateSample(uint dwFlags, IStreamSample* ppSample);
    HRESULT CreateSharedSample(IStreamSample pExistingSample, uint dwFlags, IStreamSample* ppNewSample);
    HRESULT SendEndOfStream(uint dwFlags);
}

const GUID IID_IStreamSample = {0xB502D1BE, 0x9A57, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xB502D1BE, 0x9A57, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IStreamSample : IUnknown
{
    HRESULT GetMediaStream(IMediaStream* ppMediaStream);
    HRESULT GetSampleTimes(long* pStartTime, long* pEndTime, long* pCurrentTime);
    HRESULT SetSampleTimes(const(long)* pStartTime, const(long)* pEndTime);
    HRESULT Update(uint dwFlags, HANDLE hEvent, PAPCFUNC pfnAPC, uint dwAPCData);
    HRESULT CompletionStatus(uint dwFlags, uint dwMilliseconds);
}

enum __MIDL___MIDL_itf_ddstream_0000_0000_0001
{
    DDSFF_PROGRESSIVERENDER = 1,
}

const GUID IID_IDirectDrawMediaStream = {0xF4104FCE, 0x9A70, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xF4104FCE, 0x9A70, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IDirectDrawMediaStream : IMediaStream
{
    HRESULT GetFormat(DDSURFACEDESC* pDDSDCurrent, IDirectDrawPalette* ppDirectDrawPalette, DDSURFACEDESC* pDDSDDesired, uint* pdwFlags);
    HRESULT SetFormat(const(DDSURFACEDESC)* pDDSurfaceDesc, IDirectDrawPalette pDirectDrawPalette);
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
    HRESULT SetDirectDraw(IDirectDraw pDirectDraw);
    HRESULT CreateSample(IDirectDrawSurface pSurface, const(RECT)* pRect, uint dwFlags, IDirectDrawStreamSample* ppSample);
    HRESULT GetTimePerFrame(long* pFrameTime);
}

const GUID IID_IDirectDrawStreamSample = {0xF4104FCF, 0x9A70, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xF4104FCF, 0x9A70, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IDirectDrawStreamSample : IStreamSample
{
    HRESULT GetSurface(IDirectDrawSurface* ppDirectDrawSurface, RECT* pRect);
    HRESULT SetRect(const(RECT)* pRect);
}

const GUID IID_IAudioMediaStream = {0xF7537560, 0xA3BE, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]};
@GUID(0xF7537560, 0xA3BE, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]);
interface IAudioMediaStream : IMediaStream
{
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatCurrent);
    HRESULT SetFormat(const(WAVEFORMATEX)* lpWaveFormat);
    HRESULT CreateSample(IAudioData pAudioData, uint dwFlags, IAudioStreamSample* ppSample);
}

const GUID IID_IAudioStreamSample = {0x345FEE00, 0xABA5, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]};
@GUID(0x345FEE00, 0xABA5, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]);
interface IAudioStreamSample : IStreamSample
{
    HRESULT GetAudioData(IAudioData* ppAudio);
}

const GUID IID_IMemoryData = {0x327FC560, 0xAF60, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]};
@GUID(0x327FC560, 0xAF60, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]);
interface IMemoryData : IUnknown
{
    HRESULT SetBuffer(uint cbSize, ubyte* pbData, uint dwFlags);
    HRESULT GetInfo(uint* pdwLength, ubyte** ppbData, uint* pcbActualData);
    HRESULT SetActual(uint cbDataValid);
}

const GUID IID_IAudioData = {0x54C719C0, 0xAF60, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]};
@GUID(0x54C719C0, 0xAF60, 0x11D0, [0x82, 0x12, 0x00, 0xC0, 0x4F, 0xC3, 0x2C, 0x45]);
interface IAudioData : IMemoryData
{
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatCurrent);
    HRESULT SetFormat(const(WAVEFORMATEX)* lpWaveFormat);
}

enum __MIDL___MIDL_itf_amstream_0000_0000_0001
{
    AMMSF_NOGRAPHTHREAD = 1,
}

enum __MIDL___MIDL_itf_amstream_0000_0000_0002
{
    AMMSF_ADDDEFAULTRENDERER = 1,
    AMMSF_CREATEPEER = 2,
    AMMSF_STOPIFNOSAMPLES = 4,
    AMMSF_NOSTALL = 8,
}

enum __MIDL___MIDL_itf_amstream_0000_0000_0003
{
    AMMSF_RENDERTYPEMASK = 3,
    AMMSF_RENDERTOEXISTING = 0,
    AMMSF_RENDERALLSTREAMS = 1,
    AMMSF_NORENDER = 2,
    AMMSF_NOCLOCK = 4,
    AMMSF_RUN = 8,
}

enum __MIDL___MIDL_itf_amstream_0000_0000_0004
{
    Disabled = 0,
    ReadData = 1,
    RenderData = 2,
}

const GUID IID_IAMMultiMediaStream = {0xBEBE595C, 0x9A6F, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xBEBE595C, 0x9A6F, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IAMMultiMediaStream : IMultiMediaStream
{
    HRESULT Initialize(STREAM_TYPE StreamType, uint dwFlags, IGraphBuilder pFilterGraph);
    HRESULT GetFilterGraph(IGraphBuilder* ppGraphBuilder);
    HRESULT GetFilter(IMediaStreamFilter* ppFilter);
    HRESULT AddMediaStream(IUnknown pStreamObject, const(Guid)* PurposeId, uint dwFlags, IMediaStream* ppNewStream);
    HRESULT OpenFile(const(wchar)* pszFileName, uint dwFlags);
    HRESULT OpenMoniker(IBindCtx pCtx, IMoniker pMoniker, uint dwFlags);
    HRESULT Render(uint dwFlags);
}

const GUID IID_IAMMediaStream = {0xBEBE595D, 0x9A6F, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xBEBE595D, 0x9A6F, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IAMMediaStream : IMediaStream
{
    HRESULT Initialize(IUnknown pSourceObject, uint dwFlags, Guid* PurposeId, const(STREAM_TYPE) StreamType);
    HRESULT SetState(FILTER_STATE State);
    HRESULT JoinAMMultiMediaStream(IAMMultiMediaStream pAMMultiMediaStream);
    HRESULT JoinFilter(IMediaStreamFilter pMediaStreamFilter);
    HRESULT JoinFilterGraph(IFilterGraph pFilterGraph);
}

const GUID IID_IMediaStreamFilter = {0xBEBE595E, 0x9A6F, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xBEBE595E, 0x9A6F, 0x11D0, [0x8F, 0xDE, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IMediaStreamFilter : IBaseFilter
{
    HRESULT AddMediaStream(IAMMediaStream pAMMediaStream);
    HRESULT GetMediaStream(Guid* idPurpose, IMediaStream* ppMediaStream);
    HRESULT EnumMediaStreams(int Index, IMediaStream* ppMediaStream);
    HRESULT SupportSeeking(BOOL bRenderer);
    HRESULT ReferenceTimeToStreamTime(long* pTime);
    HRESULT GetCurrentStreamTime(long* pCurrentStreamTime);
    HRESULT WaitUntil(long WaitStreamTime);
    HRESULT Flush(BOOL bCancelEOS);
    HRESULT EndOfStream();
}

const GUID IID_IDirectDrawMediaSampleAllocator = {0xAB6B4AFC, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xAB6B4AFC, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IDirectDrawMediaSampleAllocator : IUnknown
{
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
}

const GUID IID_IDirectDrawMediaSample = {0xAB6B4AFE, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xAB6B4AFE, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IDirectDrawMediaSample : IUnknown
{
    HRESULT GetSurfaceAndReleaseLock(IDirectDrawSurface* ppDirectDrawSurface, RECT* pRect);
    HRESULT LockMediaSamplePointer();
}

const GUID IID_IAMMediaTypeStream = {0xAB6B4AFA, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xAB6B4AFA, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IAMMediaTypeStream : IMediaStream
{
    HRESULT GetFormat(AM_MEDIA_TYPE* pMediaType, uint dwFlags);
    HRESULT SetFormat(AM_MEDIA_TYPE* pMediaType, uint dwFlags);
    HRESULT CreateSample(int lSampleSize, ubyte* pbBuffer, uint dwFlags, IUnknown pUnkOuter, IAMMediaTypeSample* ppAMMediaTypeSample);
    HRESULT GetStreamAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
    HRESULT SetStreamAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
}

const GUID IID_IAMMediaTypeSample = {0xAB6B4AFB, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]};
@GUID(0xAB6B4AFB, 0xF6E4, 0x11D0, [0x90, 0x0D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0x9D]);
interface IAMMediaTypeSample : IStreamSample
{
    HRESULT SetPointer(ubyte* pBuffer, int lSize);
    HRESULT GetPointer(ubyte** ppBuffer);
    int GetSize();
    HRESULT GetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT SetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT IsSyncPoint();
    HRESULT SetSyncPoint(BOOL bIsSyncPoint);
    HRESULT IsPreroll();
    HRESULT SetPreroll(BOOL bIsPreroll);
    int GetActualDataLength();
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

struct TRUECOLORINFO
{
    uint dwBitMasks;
    RGBQUAD bmiColors;
}

struct VIDEOINFOHEADER
{
    RECT rcSource;
    RECT rcTarget;
    uint dwBitRate;
    uint dwBitErrorRate;
    long AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
}

struct VIDEOINFO
{
    RECT rcSource;
    RECT rcTarget;
    uint dwBitRate;
    uint dwBitErrorRate;
    long AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
    _Anonymous_e__Union Anonymous;
}

struct MPEG1VIDEOINFO
{
    VIDEOINFOHEADER hdr;
    uint dwStartTimeCode;
    uint cbSequenceHeader;
    ubyte bSequenceHeader;
}

struct ANALOGVIDEOINFO
{
    RECT rcSource;
    RECT rcTarget;
    uint dwActiveWidth;
    uint dwActiveHeight;
    long AvgTimePerFrame;
}

enum AM_PROPERTY_FRAMESTEP
{
    AM_PROPERTY_FRAMESTEP_STEP = 1,
    AM_PROPERTY_FRAMESTEP_CANCEL = 2,
    AM_PROPERTY_FRAMESTEP_CANSTEP = 3,
    AM_PROPERTY_FRAMESTEP_CANSTEPMULTIPLE = 4,
}

struct AM_FRAMESTEP_STEP
{
    uint dwFramesToStep;
}

const GUID IID_IDMOWrapperFilter = {0x52D6F586, 0x9F0F, 0x4824, [0x8F, 0xC8, 0xE3, 0x2C, 0xA0, 0x49, 0x30, 0xC2]};
@GUID(0x52D6F586, 0x9F0F, 0x4824, [0x8F, 0xC8, 0xE3, 0x2C, 0xA0, 0x49, 0x30, 0xC2]);
interface IDMOWrapperFilter : IUnknown
{
    HRESULT Init(const(Guid)* clsidDMO, const(Guid)* catDMO);
}

enum KSALLOCATORMODE
{
    KsAllocatorMode_User = 0,
    KsAllocatorMode_Kernel = 1,
}

enum FRAMING_PROP
{
    FramingProp_Uninitialized = 0,
    FramingProp_None = 1,
    FramingProp_Old = 2,
    FramingProp_Ex = 3,
}

enum FRAMING_CACHE_OPS
{
    Framing_Cache_Update = 0,
    Framing_Cache_ReadLast = 1,
    Framing_Cache_ReadOrig = 2,
    Framing_Cache_Write = 3,
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

enum PIPE_STATE
{
    PipeState_DontCare = 0,
    PipeState_RangeNotFixed = 1,
    PipeState_RangeFixed = 2,
    PipeState_CompressionUnknown = 3,
    PipeState_Finalized = 4,
}

struct PIPE_DIMENSIONS
{
    KS_COMPRESSION AllocatorPin;
    KS_COMPRESSION MaxExpansionPin;
    KS_COMPRESSION EndPin;
}

enum PIPE_ALLOCATOR_PLACE
{
    Pipe_Allocator_None = 0,
    Pipe_Allocator_FirstPin = 1,
    Pipe_Allocator_LastPin = 2,
    Pipe_Allocator_MiddlePin = 3,
}

enum KS_LogicalMemoryType
{
    KS_MemoryTypeDontCare = 0,
    KS_MemoryTypeKernelPaged = 1,
    KS_MemoryTypeKernelNonPaged = 2,
    KS_MemoryTypeDeviceHostMapped = 3,
    KS_MemoryTypeDeviceSpecific = 4,
    KS_MemoryTypeUser = 5,
    KS_MemoryTypeAnyHost = 6,
}

struct PIPE_TERMINATION
{
    uint Flags;
    uint OutsideFactors;
    uint Weigth;
    KS_FRAMING_RANGE PhysicalRange;
    KS_FRAMING_RANGE_WEIGHTED OptimalRange;
    KS_COMPRESSION Compression;
}

struct ALLOCATOR_PROPERTIES_EX
{
    int cBuffers;
    int cbBuffer;
    int cbAlign;
    int cbPrefix;
    Guid MemoryType;
    Guid BusType;
    PIPE_STATE State;
    PIPE_TERMINATION Input;
    PIPE_TERMINATION Output;
    uint Strategy;
    uint Flags;
    uint Weight;
    KS_LogicalMemoryType LogicalMemoryType;
    PIPE_ALLOCATOR_PLACE AllocatorPlace;
    PIPE_DIMENSIONS Dimensions;
    KS_FRAMING_RANGE PhysicalRange;
    IKsAllocatorEx* PrevSegment;
    uint CountNextSegments;
    IKsAllocatorEx** NextSegments;
    uint InsideFactors;
    uint NumberPins;
}

const GUID CLSID_CLSID_Proxy = {0x17CCA71B, 0xECD7, 0x11D0, [0xB9, 0x08, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x17CCA71B, 0xECD7, 0x11D0, [0xB9, 0x08, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct CLSID_Proxy;

const GUID IID_IKsControl = {0x28F54685, 0x06FD, 0x11D2, [0xB2, 0x7A, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x28F54685, 0x06FD, 0x11D2, [0xB2, 0x7A, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
interface IKsControl : IUnknown
{
    HRESULT KsProperty(char* Property, uint PropertyLength, char* PropertyData, uint DataLength, uint* BytesReturned);
    HRESULT KsMethod(char* Method, uint MethodLength, char* MethodData, uint DataLength, uint* BytesReturned);
    HRESULT KsEvent(char* Event, uint EventLength, char* EventData, uint DataLength, uint* BytesReturned);
}

const GUID IID_IKsAggregateControl = {0x7F40EAC0, 0x3947, 0x11D2, [0x87, 0x4E, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x7F40EAC0, 0x3947, 0x11D2, [0x87, 0x4E, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
interface IKsAggregateControl : IUnknown
{
    HRESULT KsAddAggregate(const(Guid)* AggregateClass);
    HRESULT KsRemoveAggregate(const(Guid)* AggregateClass);
}

const GUID IID_IKsTopology = {0x28F54683, 0x06FD, 0x11D2, [0xB2, 0x7A, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x28F54683, 0x06FD, 0x11D2, [0xB2, 0x7A, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
interface IKsTopology : IUnknown
{
    HRESULT CreateNodeInstance(uint NodeId, uint Flags, uint DesiredAccess, IUnknown UnkOuter, const(Guid)* InterfaceId, void** Interface);
}

const GUID IID_IMixerOCXNotify = {0x81A3BD31, 0xDEE1, 0x11D1, [0x85, 0x08, 0x00, 0xA0, 0xC9, 0x1F, 0x9C, 0xA0]};
@GUID(0x81A3BD31, 0xDEE1, 0x11D1, [0x85, 0x08, 0x00, 0xA0, 0xC9, 0x1F, 0x9C, 0xA0]);
interface IMixerOCXNotify : IUnknown
{
    HRESULT OnInvalidateRect(RECT* lpcRect);
    HRESULT OnStatusChange(uint ulStatusFlags);
    HRESULT OnDataChange(uint ulDataFlags);
}

const GUID IID_IMixerOCX = {0x81A3BD32, 0xDEE1, 0x11D1, [0x85, 0x08, 0x00, 0xA0, 0xC9, 0x1F, 0x9C, 0xA0]};
@GUID(0x81A3BD32, 0xDEE1, 0x11D1, [0x85, 0x08, 0x00, 0xA0, 0xC9, 0x1F, 0x9C, 0xA0]);
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

enum AM_ASPECT_RATIO_MODE
{
    AM_ARMODE_STRETCHED = 0,
    AM_ARMODE_LETTER_BOX = 1,
    AM_ARMODE_CROP = 2,
    AM_ARMODE_STRETCHED_AS_PRIMARY = 3,
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

struct AM_MPEGSTREAMTYPE
{
    uint dwStreamId;
    uint dwReserved;
    AM_MEDIA_TYPE mt;
    ubyte bFormat;
}

struct AM_MPEGSYSTEMTYPE
{
    uint dwBitRate;
    uint cStreams;
    AM_MPEGSTREAMTYPE Streams;
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

enum VMR9PresentationFlags
{
    VMR9Sample_SyncPoint = 1,
    VMR9Sample_Preroll = 2,
    VMR9Sample_Discontinuity = 4,
    VMR9Sample_TimeValid = 8,
    VMR9Sample_SrcDstRectsValid = 16,
}

struct VMR9PresentationInfo
{
    uint dwFlags;
    IDirect3DSurface9 lpSurf;
    long rtStart;
    long rtEnd;
    SIZE szAspectRatio;
    RECT rcSrc;
    RECT rcDst;
    uint dwReserved1;
    uint dwReserved2;
}

const GUID IID_IVMRImagePresenter9 = {0x69188C61, 0x12A3, 0x40F0, [0x8F, 0xFC, 0x34, 0x2E, 0x7B, 0x43, 0x3F, 0xD7]};
@GUID(0x69188C61, 0x12A3, 0x40F0, [0x8F, 0xFC, 0x34, 0x2E, 0x7B, 0x43, 0x3F, 0xD7]);
interface IVMRImagePresenter9 : IUnknown
{
    HRESULT StartPresenting(uint dwUserID);
    HRESULT StopPresenting(uint dwUserID);
    HRESULT PresentImage(uint dwUserID, VMR9PresentationInfo* lpPresInfo);
}

enum VMR9SurfaceAllocationFlags
{
    VMR9AllocFlag_3DRenderTarget = 1,
    VMR9AllocFlag_DXVATarget = 2,
    VMR9AllocFlag_TextureSurface = 4,
    VMR9AllocFlag_OffscreenSurface = 8,
    VMR9AllocFlag_RGBDynamicSwitch = 16,
    VMR9AllocFlag_UsageReserved = 224,
    VMR9AllocFlag_UsageMask = 255,
}

struct VMR9AllocationInfo
{
    uint dwFlags;
    uint dwWidth;
    uint dwHeight;
    D3DFORMAT Format;
    D3DPOOL Pool;
    uint MinBuffers;
    SIZE szAspectRatio;
    SIZE szNativeSize;
}

const GUID IID_IVMRSurfaceAllocator9 = {0x8D5148EA, 0x3F5D, 0x46CF, [0x9D, 0xF1, 0xD1, 0xB8, 0x96, 0xEE, 0xDB, 0x1F]};
@GUID(0x8D5148EA, 0x3F5D, 0x46CF, [0x9D, 0xF1, 0xD1, 0xB8, 0x96, 0xEE, 0xDB, 0x1F]);
interface IVMRSurfaceAllocator9 : IUnknown
{
    HRESULT InitializeDevice(uint dwUserID, VMR9AllocationInfo* lpAllocInfo, uint* lpNumBuffers);
    HRESULT TerminateDevice(uint dwID);
    HRESULT GetSurface(uint dwUserID, uint SurfaceIndex, uint SurfaceFlags, IDirect3DSurface9* lplpSurface);
    HRESULT AdviseNotify(IVMRSurfaceAllocatorNotify9 lpIVMRSurfAllocNotify);
}

const GUID IID_IVMRSurfaceAllocatorEx9 = {0x6DE9A68A, 0xA928, 0x4522, [0xBF, 0x57, 0x65, 0x5A, 0xE3, 0x86, 0x64, 0x56]};
@GUID(0x6DE9A68A, 0xA928, 0x4522, [0xBF, 0x57, 0x65, 0x5A, 0xE3, 0x86, 0x64, 0x56]);
interface IVMRSurfaceAllocatorEx9 : IVMRSurfaceAllocator9
{
    HRESULT GetSurfaceEx(uint dwUserID, uint SurfaceIndex, uint SurfaceFlags, IDirect3DSurface9* lplpSurface, RECT* lprcDst);
}

const GUID IID_IVMRSurfaceAllocatorNotify9 = {0xDCA3F5DF, 0xBB3A, 0x4D03, [0xBD, 0x81, 0x84, 0x61, 0x4B, 0xFB, 0xFA, 0x0C]};
@GUID(0xDCA3F5DF, 0xBB3A, 0x4D03, [0xBD, 0x81, 0x84, 0x61, 0x4B, 0xFB, 0xFA, 0x0C]);
interface IVMRSurfaceAllocatorNotify9 : IUnknown
{
    HRESULT AdviseSurfaceAllocator(uint dwUserID, IVMRSurfaceAllocator9 lpIVRMSurfaceAllocator);
    HRESULT SetD3DDevice(IDirect3DDevice9 lpD3DDevice, int hMonitor);
    HRESULT ChangeD3DDevice(IDirect3DDevice9 lpD3DDevice, int hMonitor);
    HRESULT AllocateSurfaceHelper(VMR9AllocationInfo* lpAllocInfo, uint* lpNumBuffers, IDirect3DSurface9* lplpSurface);
    HRESULT NotifyEvent(int EventCode, int Param1, int Param2);
}

enum VMR9AspectRatioMode
{
    VMR9ARMode_None = 0,
    VMR9ARMode_LetterBox = 1,
}

const GUID IID_IVMRWindowlessControl9 = {0x8F537D09, 0xF85E, 0x4414, [0xB2, 0x3B, 0x50, 0x2E, 0x54, 0xC7, 0x99, 0x27]};
@GUID(0x8F537D09, 0xF85E, 0x4414, [0xB2, 0x3B, 0x50, 0x2E, 0x54, 0xC7, 0x99, 0x27]);
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

enum VMR9MixerPrefs
{
    MixerPref9_NoDecimation = 1,
    MixerPref9_DecimateOutput = 2,
    MixerPref9_ARAdjustXorY = 4,
    MixerPref9_NonSquareMixing = 8,
    MixerPref9_DecimateMask = 15,
    MixerPref9_BiLinearFiltering = 16,
    MixerPref9_PointFiltering = 32,
    MixerPref9_AnisotropicFiltering = 64,
    MixerPref9_PyramidalQuadFiltering = 128,
    MixerPref9_GaussianQuadFiltering = 256,
    MixerPref9_FilteringReserved = 3584,
    MixerPref9_FilteringMask = 4080,
    MixerPref9_RenderTargetRGB = 4096,
    MixerPref9_RenderTargetYUV = 8192,
    MixerPref9_RenderTargetReserved = 1032192,
    MixerPref9_RenderTargetMask = 1044480,
    MixerPref9_DynamicSwitchToBOB = 1048576,
    MixerPref9_DynamicDecimateBy2 = 2097152,
    MixerPref9_DynamicReserved = 12582912,
    MixerPref9_DynamicMask = 15728640,
}

struct VMR9NormalizedRect
{
    float left;
    float top;
    float right;
    float bottom;
}

enum VMR9ProcAmpControlFlags
{
    ProcAmpControl9_Brightness = 1,
    ProcAmpControl9_Contrast = 2,
    ProcAmpControl9_Hue = 4,
    ProcAmpControl9_Saturation = 8,
    ProcAmpControl9_Mask = 15,
}

struct VMR9ProcAmpControl
{
    uint dwSize;
    uint dwFlags;
    float Brightness;
    float Contrast;
    float Hue;
    float Saturation;
}

struct VMR9ProcAmpControlRange
{
    uint dwSize;
    VMR9ProcAmpControlFlags dwProperty;
    float MinValue;
    float MaxValue;
    float DefaultValue;
    float StepSize;
}

const GUID IID_IVMRMixerControl9 = {0x1A777EAA, 0x47C8, 0x4930, [0xB2, 0xC9, 0x8F, 0xEE, 0x1C, 0x1B, 0x0F, 0x3B]};
@GUID(0x1A777EAA, 0x47C8, 0x4930, [0xB2, 0xC9, 0x8F, 0xEE, 0x1C, 0x1B, 0x0F, 0x3B]);
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

struct VMR9AlphaBitmap
{
    uint dwFlags;
    HDC hdc;
    IDirect3DSurface9 pDDS;
    RECT rSrc;
    VMR9NormalizedRect rDest;
    float fAlpha;
    uint clrSrcKey;
    uint dwFilterMode;
}

enum VMR9AlphaBitmapFlags
{
    VMR9AlphaBitmap_Disable = 1,
    VMR9AlphaBitmap_hDC = 2,
    VMR9AlphaBitmap_EntireDDS = 4,
    VMR9AlphaBitmap_SrcColorKey = 8,
    VMR9AlphaBitmap_SrcRect = 16,
    VMR9AlphaBitmap_FilterMode = 32,
}

const GUID IID_IVMRMixerBitmap9 = {0xCED175E5, 0x1935, 0x4820, [0x81, 0xBD, 0xFF, 0x6A, 0xD0, 0x0C, 0x91, 0x08]};
@GUID(0xCED175E5, 0x1935, 0x4820, [0x81, 0xBD, 0xFF, 0x6A, 0xD0, 0x0C, 0x91, 0x08]);
interface IVMRMixerBitmap9 : IUnknown
{
    HRESULT SetAlphaBitmap(const(VMR9AlphaBitmap)* pBmpParms);
    HRESULT UpdateAlphaBitmapParameters(const(VMR9AlphaBitmap)* pBmpParms);
    HRESULT GetAlphaBitmapParameters(VMR9AlphaBitmap* pBmpParms);
}

const GUID IID_IVMRSurface9 = {0xDFC581A1, 0x6E1F, 0x4C3A, [0x8D, 0x0A, 0x5E, 0x97, 0x92, 0xEA, 0x2A, 0xFC]};
@GUID(0xDFC581A1, 0x6E1F, 0x4C3A, [0x8D, 0x0A, 0x5E, 0x97, 0x92, 0xEA, 0x2A, 0xFC]);
interface IVMRSurface9 : IUnknown
{
    HRESULT IsSurfaceLocked();
    HRESULT LockSurface(ubyte** lpSurface);
    HRESULT UnlockSurface();
    HRESULT GetSurface(IDirect3DSurface9* lplpSurface);
}

enum VMR9RenderPrefs
{
    RenderPrefs9_DoNotRenderBorder = 1,
    RenderPrefs9_Mask = 1,
}

const GUID IID_IVMRImagePresenterConfig9 = {0x45C15CAB, 0x6E22, 0x420A, [0x80, 0x43, 0xAE, 0x1F, 0x0A, 0xC0, 0x2C, 0x7D]};
@GUID(0x45C15CAB, 0x6E22, 0x420A, [0x80, 0x43, 0xAE, 0x1F, 0x0A, 0xC0, 0x2C, 0x7D]);
interface IVMRImagePresenterConfig9 : IUnknown
{
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    HRESULT GetRenderingPrefs(uint* dwRenderFlags);
}

const GUID IID_IVMRVideoStreamControl9 = {0xD0CFE38B, 0x93E7, 0x4772, [0x89, 0x57, 0x04, 0x00, 0xC4, 0x9A, 0x44, 0x85]};
@GUID(0xD0CFE38B, 0x93E7, 0x4772, [0x89, 0x57, 0x04, 0x00, 0xC4, 0x9A, 0x44, 0x85]);
interface IVMRVideoStreamControl9 : IUnknown
{
    HRESULT SetStreamActiveState(BOOL fActive);
    HRESULT GetStreamActiveState(int* lpfActive);
}

enum VMR9Mode
{
    VMR9Mode_Windowed = 1,
    VMR9Mode_Windowless = 2,
    VMR9Mode_Renderless = 4,
    VMR9Mode_Mask = 7,
}

const GUID IID_IVMRFilterConfig9 = {0x5A804648, 0x4F66, 0x4867, [0x9C, 0x43, 0x4F, 0x5C, 0x82, 0x2C, 0xF1, 0xB8]};
@GUID(0x5A804648, 0x4F66, 0x4867, [0x9C, 0x43, 0x4F, 0x5C, 0x82, 0x2C, 0xF1, 0xB8]);
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

const GUID IID_IVMRAspectRatioControl9 = {0x00D96C29, 0xBBDE, 0x4EFC, [0x99, 0x01, 0xBB, 0x50, 0x36, 0x39, 0x21, 0x46]};
@GUID(0x00D96C29, 0xBBDE, 0x4EFC, [0x99, 0x01, 0xBB, 0x50, 0x36, 0x39, 0x21, 0x46]);
interface IVMRAspectRatioControl9 : IUnknown
{
    HRESULT GetAspectRatioMode(uint* lpdwARMode);
    HRESULT SetAspectRatioMode(uint dwARMode);
}

struct VMR9MonitorInfo
{
    uint uDevID;
    RECT rcMonitor;
    int hMon;
    uint dwFlags;
    ushort szDevice;
    ushort szDescription;
    LARGE_INTEGER liDriverVersion;
    uint dwVendorId;
    uint dwDeviceId;
    uint dwSubSysId;
    uint dwRevision;
}

const GUID IID_IVMRMonitorConfig9 = {0x46C2E457, 0x8BA0, 0x4EEF, [0xB8, 0x0B, 0x06, 0x80, 0xF0, 0x97, 0x87, 0x49]};
@GUID(0x46C2E457, 0x8BA0, 0x4EEF, [0xB8, 0x0B, 0x06, 0x80, 0xF0, 0x97, 0x87, 0x49]);
interface IVMRMonitorConfig9 : IUnknown
{
    HRESULT SetMonitor(uint uDev);
    HRESULT GetMonitor(uint* puDev);
    HRESULT SetDefaultMonitor(uint uDev);
    HRESULT GetDefaultMonitor(uint* puDev);
    HRESULT GetAvailableMonitors(VMR9MonitorInfo* pInfo, uint dwMaxInfoArraySize, uint* pdwNumDevices);
}

enum VMR9DeinterlacePrefs
{
    DeinterlacePref9_NextBest = 1,
    DeinterlacePref9_BOB = 2,
    DeinterlacePref9_Weave = 4,
    DeinterlacePref9_Mask = 7,
}

enum VMR9DeinterlaceTech
{
    DeinterlaceTech9_Unknown = 0,
    DeinterlaceTech9_BOBLineReplicate = 1,
    DeinterlaceTech9_BOBVerticalStretch = 2,
    DeinterlaceTech9_MedianFiltering = 4,
    DeinterlaceTech9_EdgeFiltering = 16,
    DeinterlaceTech9_FieldAdaptive = 32,
    DeinterlaceTech9_PixelAdaptive = 64,
    DeinterlaceTech9_MotionVectorSteered = 128,
}

struct VMR9Frequency
{
    uint dwNumerator;
    uint dwDenominator;
}

enum VMR9_SampleFormat
{
    VMR9_SampleReserved = 1,
    VMR9_SampleProgressiveFrame = 2,
    VMR9_SampleFieldInterleavedEvenFirst = 3,
    VMR9_SampleFieldInterleavedOddFirst = 4,
    VMR9_SampleFieldSingleEven = 5,
    VMR9_SampleFieldSingleOdd = 6,
}

struct VMR9VideoDesc
{
    uint dwSize;
    uint dwSampleWidth;
    uint dwSampleHeight;
    VMR9_SampleFormat SampleFormat;
    uint dwFourCC;
    VMR9Frequency InputSampleFreq;
    VMR9Frequency OutputFrameFreq;
}

struct VMR9DeinterlaceCaps
{
    uint dwSize;
    uint dwNumPreviousOutputFrames;
    uint dwNumForwardRefSamples;
    uint dwNumBackwardRefSamples;
    VMR9DeinterlaceTech DeinterlaceTechnology;
}

const GUID IID_IVMRDeinterlaceControl9 = {0xA215FB8D, 0x13C2, 0x4F7F, [0x99, 0x3C, 0x00, 0x3D, 0x62, 0x71, 0xA4, 0x59]};
@GUID(0xA215FB8D, 0x13C2, 0x4F7F, [0x99, 0x3C, 0x00, 0x3D, 0x62, 0x71, 0xA4, 0x59]);
interface IVMRDeinterlaceControl9 : IUnknown
{
    HRESULT GetNumberOfDeinterlaceModes(VMR9VideoDesc* lpVideoDescription, uint* lpdwNumDeinterlaceModes, Guid* lpDeinterlaceModes);
    HRESULT GetDeinterlaceModeCaps(Guid* lpDeinterlaceMode, VMR9VideoDesc* lpVideoDescription, VMR9DeinterlaceCaps* lpDeinterlaceCaps);
    HRESULT GetDeinterlaceMode(uint dwStreamID, Guid* lpDeinterlaceMode);
    HRESULT SetDeinterlaceMode(uint dwStreamID, Guid* lpDeinterlaceMode);
    HRESULT GetDeinterlacePrefs(uint* lpdwDeinterlacePrefs);
    HRESULT SetDeinterlacePrefs(uint dwDeinterlacePrefs);
    HRESULT GetActualDeinterlaceMode(uint dwStreamID, Guid* lpDeinterlaceMode);
}

struct VMR9VideoStreamInfo
{
    IDirect3DSurface9 pddsVideoSurface;
    uint dwWidth;
    uint dwHeight;
    uint dwStrmID;
    float fAlpha;
    VMR9NormalizedRect rNormal;
    long rtStart;
    long rtEnd;
    VMR9_SampleFormat SampleFormat;
}

const GUID IID_IVMRImageCompositor9 = {0x4A5C89EB, 0xDF51, 0x4654, [0xAC, 0x2A, 0xE4, 0x8E, 0x02, 0xBB, 0xAB, 0xF6]};
@GUID(0x4A5C89EB, 0xDF51, 0x4654, [0xAC, 0x2A, 0xE4, 0x8E, 0x02, 0xBB, 0xAB, 0xF6]);
interface IVMRImageCompositor9 : IUnknown
{
    HRESULT InitCompositionDevice(IUnknown pD3DDevice);
    HRESULT TermCompositionDevice(IUnknown pD3DDevice);
    HRESULT SetStreamMediaType(uint dwStrmID, AM_MEDIA_TYPE* pmt, BOOL fTexture);
    HRESULT CompositeImage(IUnknown pD3DDevice, IDirect3DSurface9 pddsRenderTarget, AM_MEDIA_TYPE* pmtRenderTarget, long rtStart, long rtEnd, uint dwClrBkGnd, VMR9VideoStreamInfo* pVideoStreamInfo, uint cStreams);
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
    HRESULT SetDirectDrawKernelHandle(uint dwDDKernelHandle);
    HRESULT SetVideoPortID(uint dwVideoPortID);
    HRESULT SetDDSurfaceKernelHandles(uint cHandles, uint* rgDDKernelHandles);
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

struct _riffchunk
{
    uint fcc;
    uint cb;
}

struct _rifflist
{
    uint fcc;
    uint cb;
    uint fccListType;
}

struct AVIMAINHEADER
{
    uint fcc;
    uint cb;
    uint dwMicroSecPerFrame;
    uint dwMaxBytesPerSec;
    uint dwPaddingGranularity;
    uint dwFlags;
    uint dwTotalFrames;
    uint dwInitialFrames;
    uint dwStreams;
    uint dwSuggestedBufferSize;
    uint dwWidth;
    uint dwHeight;
    uint dwReserved;
}

struct _aviextheader
{
    uint fcc;
    uint cb;
    uint dwGrandFrames;
    uint dwFuture;
}

struct AVISTREAMHEADER
{
    uint fcc;
    uint cb;
    uint fccType;
    uint fccHandler;
    uint dwFlags;
    ushort wPriority;
    ushort wLanguage;
    uint dwInitialFrames;
    uint dwScale;
    uint dwRate;
    uint dwStart;
    uint dwLength;
    uint dwSuggestedBufferSize;
    uint dwQuality;
    uint dwSampleSize;
    _rcFrame_e__Struct rcFrame;
}

struct AVIOLDINDEX
{
    uint fcc;
    uint cb;
    _avioldindex_entry aIndex;
}

struct _timecodedata
{
    TIMECODE time;
    uint dwSMPTEflags;
    uint dwUser;
}

struct AVIMETAINDEX
{
    uint fcc;
    uint cb;
    ushort wLongsPerEntry;
    ubyte bIndexSubType;
    ubyte bIndexType;
    uint nEntriesInUse;
    uint dwChunkId;
    uint dwReserved;
    uint adwIndex;
}

struct AVISUPERINDEX
{
    uint fcc;
    uint cb;
    ushort wLongsPerEntry;
    ubyte bIndexSubType;
    ubyte bIndexType;
    uint nEntriesInUse;
    uint dwChunkId;
    uint dwReserved;
    _avisuperindex_entry aIndex;
}

struct AVISTDINDEX_ENTRY
{
    uint dwOffset;
    uint dwSize;
}

struct AVISTDINDEX
{
    uint fcc;
    uint cb;
    ushort wLongsPerEntry;
    ubyte bIndexSubType;
    ubyte bIndexType;
    uint nEntriesInUse;
    uint dwChunkId;
    ulong qwBaseOffset;
    uint dwReserved_3;
    AVISTDINDEX_ENTRY aIndex;
}

struct _avitimedindex_entry
{
    uint dwOffset;
    uint dwSize;
    uint dwDuration;
}

struct _avitimedindex
{
    uint fcc;
    uint cb;
    ushort wLongsPerEntry;
    ubyte bIndexSubType;
    ubyte bIndexType;
    uint nEntriesInUse;
    uint dwChunkId;
    ulong qwBaseOffset;
    uint dwReserved_3;
    _avitimedindex_entry aIndex;
    uint adwTrailingFill;
}

struct _avitimecodeindex
{
    uint fcc;
    uint cb;
    ushort wLongsPerEntry;
    ubyte bIndexSubType;
    ubyte bIndexType;
    uint nEntriesInUse;
    uint dwChunkId;
    uint dwReserved;
    _timecodedata aIndex;
}

struct _avitcdlindex_entry
{
    uint dwTick;
    TIMECODE time;
    uint dwSMPTEflags;
    uint dwUser;
    byte szReelId;
}

struct _avitcdlindex
{
    uint fcc;
    uint cb;
    ushort wLongsPerEntry;
    ubyte bIndexSubType;
    ubyte bIndexType;
    uint nEntriesInUse;
    uint dwChunkId;
    uint dwReserved;
    _avitcdlindex_entry aIndex;
    uint adwTrailingFill;
}

struct _avifieldindex_chunk
{
    uint fcc;
    uint cb;
    ushort wLongsPerEntry;
    ubyte bIndexSubType;
    ubyte bIndexType;
    uint nEntriesInUse;
    uint dwChunkId;
    ulong qwBaseOffset;
    uint dwReserved3;
    _avifieldindex_entry aIndex;
}

struct MainAVIHeader
{
    uint dwMicroSecPerFrame;
    uint dwMaxBytesPerSec;
    uint dwPaddingGranularity;
    uint dwFlags;
    uint dwTotalFrames;
    uint dwInitialFrames;
    uint dwStreams;
    uint dwSuggestedBufferSize;
    uint dwWidth;
    uint dwHeight;
    uint dwReserved;
}

struct AVIStreamHeader
{
    uint fccType;
    uint fccHandler;
    uint dwFlags;
    ushort wPriority;
    ushort wLanguage;
    uint dwInitialFrames;
    uint dwScale;
    uint dwRate;
    uint dwStart;
    uint dwLength;
    uint dwSuggestedBufferSize;
    uint dwQuality;
    uint dwSampleSize;
    RECT rcFrame;
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
    ubyte bFirstEntry;
    ubyte bNumEntries;
    ushort wFlags;
    PALETTEENTRY peNew;
}

enum AM_PROPERTY_AC3
{
    AM_PROPERTY_AC3_ERROR_CONCEALMENT = 1,
    AM_PROPERTY_AC3_ALTERNATE_AUDIO = 2,
    AM_PROPERTY_AC3_DOWNMIX = 3,
    AM_PROPERTY_AC3_BIT_STREAM_MODE = 4,
    AM_PROPERTY_AC3_DIALOGUE_LEVEL = 5,
    AM_PROPERTY_AC3_LANGUAGE_CODE = 6,
    AM_PROPERTY_AC3_ROOM_TYPE = 7,
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

enum AM_PROPERTY_DVDSUBPIC
{
    AM_PROPERTY_DVDSUBPIC_PALETTE = 0,
    AM_PROPERTY_DVDSUBPIC_HLI = 1,
    AM_PROPERTY_DVDSUBPIC_COMPOSIT_ON = 2,
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
    AM_DVD_YUV sppal;
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
    ushort HLISS;
    ushort Reserved;
    uint StartPTM;
    uint EndPTM;
    ushort StartX;
    ushort StartY;
    ushort StopX;
    ushort StopY;
    AM_COLCON ColCon;
}

enum AM_PROPERTY_DVDCOPYPROT
{
    AM_PROPERTY_DVDCOPY_CHLG_KEY = 1,
    AM_PROPERTY_DVDCOPY_DVD_KEY1 = 2,
    AM_PROPERTY_DVDCOPY_DEC_KEY2 = 3,
    AM_PROPERTY_DVDCOPY_TITLE_KEY = 4,
    AM_PROPERTY_COPY_MACROVISION = 5,
    AM_PROPERTY_DVDCOPY_REGION = 6,
    AM_PROPERTY_DVDCOPY_SET_COPY_STATE = 7,
    AM_PROPERTY_COPY_ANALOG_COMPONENT = 8,
    AM_PROPERTY_COPY_DIGITAL_CP = 9,
    AM_PROPERTY_COPY_DVD_SRM = 10,
    AM_PROPERTY_DVDCOPY_SUPPORTS_NEW_KEYCOUNT = 11,
    AM_PROPERTY_DVDCOPY_DISC_KEY = 128,
}

enum AM_DIGITAL_CP
{
    AM_DIGITAL_CP_OFF = 0,
    AM_DIGITAL_CP_ON = 1,
    AM_DIGITAL_CP_DVD_COMPLIANT = 2,
}

struct AM_DVDCOPY_CHLGKEY
{
    ubyte ChlgKey;
    ubyte Reserved;
}

struct AM_DVDCOPY_BUSKEY
{
    ubyte BusKey;
    ubyte Reserved;
}

struct AM_DVDCOPY_DISCKEY
{
    ubyte DiscKey;
}

struct AM_DVDCOPY_TITLEKEY
{
    uint KeyFlags;
    uint Reserved1;
    ubyte TitleKey;
    ubyte Reserved2;
}

struct AM_COPY_MACROVISION
{
    uint MACROVISIONLevel;
}

struct AM_DVDCOPY_SET_COPY_STATE
{
    uint DVDCopyState;
}

enum AM_DVDCOPYSTATE
{
    AM_DVDCOPYSTATE_INITIALIZE = 0,
    AM_DVDCOPYSTATE_INITIALIZE_TITLE = 1,
    AM_DVDCOPYSTATE_AUTHENTICATION_NOT_REQUIRED = 2,
    AM_DVDCOPYSTATE_AUTHENTICATION_REQUIRED = 3,
    AM_DVDCOPYSTATE_DONE = 4,
}

enum AM_COPY_MACROVISION_LEVEL
{
    AM_MACROVISION_DISABLED = 0,
    AM_MACROVISION_LEVEL1 = 1,
    AM_MACROVISION_LEVEL2 = 2,
    AM_MACROVISION_LEVEL3 = 3,
}

struct DVD_REGION
{
    ubyte CopySystem;
    ubyte RegionData;
    ubyte SystemRegion;
    ubyte ResetCount;
}

enum AM_MPEG2Level
{
    AM_MPEG2Level_Low = 1,
    AM_MPEG2Level_Main = 2,
    AM_MPEG2Level_High1440 = 3,
    AM_MPEG2Level_High = 4,
}

enum AM_MPEG2Profile
{
    AM_MPEG2Profile_Simple = 1,
    AM_MPEG2Profile_Main = 2,
    AM_MPEG2Profile_SNRScalable = 3,
    AM_MPEG2Profile_SpatiallyScalable = 4,
    AM_MPEG2Profile_High = 5,
}

struct VIDEOINFOHEADER2
{
    RECT rcSource;
    RECT rcTarget;
    uint dwBitRate;
    uint dwBitErrorRate;
    long AvgTimePerFrame;
    uint dwInterlaceFlags;
    uint dwCopyProtectFlags;
    uint dwPictAspectRatioX;
    uint dwPictAspectRatioY;
    _Anonymous_e__Union Anonymous;
    uint dwReserved2;
    BITMAPINFOHEADER bmiHeader;
}

struct MPEG2VIDEOINFO
{
    VIDEOINFOHEADER2 hdr;
    uint dwStartTimeCode;
    uint cbSequenceHeader;
    uint dwProfile;
    uint dwLevel;
    uint dwFlags;
    uint dwSequenceHeader;
}

struct AM_DvdKaraokeData
{
    uint dwDownmix;
    uint dwSpeakerAssignment;
}

enum AM_PROPERTY_DVDKARAOKE
{
    AM_PROPERTY_DVDKARAOKE_ENABLE = 0,
    AM_PROPERTY_DVDKARAOKE_DATA = 1,
}

enum AM_PROPERTY_TS_RATE_CHANGE
{
    AM_RATE_SimpleRateChange = 1,
    AM_RATE_ExactRateChange = 2,
    AM_RATE_MaxFullDataRate = 3,
    AM_RATE_Step = 4,
    AM_RATE_UseRateVersion = 5,
    AM_RATE_QueryFullFrameRate = 6,
    AM_RATE_QueryLastRateSegPTS = 7,
    AM_RATE_CorrectTS = 8,
    AM_RATE_ReverseMaxFullDataRate = 9,
    AM_RATE_ResetOnTimeDisc = 10,
    AM_RATE_QueryMapping = 11,
}

enum AM_PROPERTY_DVD_RATE_CHANGE
{
    AM_RATE_ChangeRate = 1,
    AM_RATE_FullDataRateMax = 2,
    AM_RATE_ReverseDecode = 3,
    AM_RATE_DecoderPosition = 4,
    AM_RATE_DecoderVersion = 5,
}

struct AM_SimpleRateChange
{
    long StartTime;
    int Rate;
}

struct AM_QueryRate
{
    int lMaxForwardFullFrame;
    int lMaxReverseFullFrame;
}

struct AM_ExactRateChange
{
    long OutputZeroTime;
    int Rate;
}

struct AM_DVD_ChangeRate
{
    long StartInTime;
    long StartOutTime;
    int Rate;
}

enum DVD_PLAY_DIRECTION
{
    DVD_DIR_FORWARD = 0,
    DVD_DIR_BACKWARD = 1,
}

enum DVD_ERROR
{
    DVD_ERROR_Unexpected = 1,
    DVD_ERROR_CopyProtectFail = 2,
    DVD_ERROR_InvalidDVD1_0Disc = 3,
    DVD_ERROR_InvalidDiscRegion = 4,
    DVD_ERROR_LowParentalLevel = 5,
    DVD_ERROR_MacrovisionFail = 6,
    DVD_ERROR_IncompatibleSystemAndDecoderRegions = 7,
    DVD_ERROR_IncompatibleDiscAndDecoderRegions = 8,
    DVD_ERROR_CopyProtectOutputFail = 9,
    DVD_ERROR_CopyProtectOutputNotSupported = 10,
}

enum DVD_WARNING
{
    DVD_WARNING_InvalidDVD1_0Disc = 1,
    DVD_WARNING_FormatNotSupported = 2,
    DVD_WARNING_IllegalNavCommand = 3,
    DVD_WARNING_Open = 4,
    DVD_WARNING_Seek = 5,
    DVD_WARNING_Read = 6,
}

enum DVD_PB_STOPPED
{
    DVD_PB_STOPPED_Other = 0,
    DVD_PB_STOPPED_NoBranch = 1,
    DVD_PB_STOPPED_NoFirstPlayDomain = 2,
    DVD_PB_STOPPED_StopCommand = 3,
    DVD_PB_STOPPED_Reset = 4,
    DVD_PB_STOPPED_DiscEjected = 5,
    DVD_PB_STOPPED_IllegalNavCommand = 6,
    DVD_PB_STOPPED_PlayPeriodAutoStop = 7,
    DVD_PB_STOPPED_PlayChapterAutoStop = 8,
    DVD_PB_STOPPED_ParentalFailure = 9,
    DVD_PB_STOPPED_RegionFailure = 10,
    DVD_PB_STOPPED_MacrovisionFailure = 11,
    DVD_PB_STOPPED_DiscReadError = 12,
    DVD_PB_STOPPED_CopyProtectFailure = 13,
    DVD_PB_STOPPED_CopyProtectOutputFailure = 14,
    DVD_PB_STOPPED_CopyProtectOutputNotSupported = 15,
}

alias AMGETERRORTEXTPROCA = extern(Windows) BOOL function(HRESULT param0, byte* param1, uint param2);
alias AMGETERRORTEXTPROCW = extern(Windows) BOOL function(HRESULT param0, ushort* param1, uint param2);
alias AMGETERRORTEXTPROC = extern(Windows) BOOL function();
enum SNDDEV_ERR
{
    SNDDEV_ERROR_Open = 1,
    SNDDEV_ERROR_Close = 2,
    SNDDEV_ERROR_GetCaps = 3,
    SNDDEV_ERROR_PrepareHeader = 4,
    SNDDEV_ERROR_UnprepareHeader = 5,
    SNDDEV_ERROR_Reset = 6,
    SNDDEV_ERROR_Restart = 7,
    SNDDEV_ERROR_GetPosition = 8,
    SNDDEV_ERROR_Write = 9,
    SNDDEV_ERROR_Pause = 10,
    SNDDEV_ERROR_Stop = 11,
    SNDDEV_ERROR_Start = 12,
    SNDDEV_ERROR_AddBuffer = 13,
    SNDDEV_ERROR_Query = 14,
}

enum MP_TYPE
{
    MPT_INT = 0,
    MPT_FLOAT = 1,
    MPT_BOOL = 2,
    MPT_ENUM = 3,
    MPT_MAX = 4,
}

enum MP_CURVE_TYPE
{
    MP_CURVE_JUMP = 1,
    MP_CURVE_LINEAR = 2,
    MP_CURVE_SQUARE = 4,
    MP_CURVE_INVSQUARE = 8,
    MP_CURVE_SINE = 16,
}

struct MP_PARAMINFO
{
    MP_TYPE mpType;
    uint mopCaps;
    float mpdMinValue;
    float mpdMaxValue;
    float mpdNeutralValue;
    ushort szUnitText;
    ushort szLabel;
}

struct MP_ENVELOPE_SEGMENT
{
    long rtStart;
    long rtEnd;
    float valStart;
    float valEnd;
    MP_CURVE_TYPE iCurve;
    uint flags;
}

const GUID IID_IMediaParamInfo = {0x6D6CBB60, 0xA223, 0x44AA, [0x84, 0x2F, 0xA2, 0xF0, 0x67, 0x50, 0xBE, 0x6D]};
@GUID(0x6D6CBB60, 0xA223, 0x44AA, [0x84, 0x2F, 0xA2, 0xF0, 0x67, 0x50, 0xBE, 0x6D]);
interface IMediaParamInfo : IUnknown
{
    HRESULT GetParamCount(uint* pdwParams);
    HRESULT GetParamInfo(uint dwParamIndex, MP_PARAMINFO* pInfo);
    HRESULT GetParamText(uint dwParamIndex, ushort** ppwchText);
    HRESULT GetNumTimeFormats(uint* pdwNumTimeFormats);
    HRESULT GetSupportedTimeFormat(uint dwFormatIndex, Guid* pguidTimeFormat);
    HRESULT GetCurrentTimeFormat(Guid* pguidTimeFormat, uint* pTimeData);
}

const GUID IID_IMediaParams = {0x6D6CBB61, 0xA223, 0x44AA, [0x84, 0x2F, 0xA2, 0xF0, 0x67, 0x50, 0xBE, 0x6E]};
@GUID(0x6D6CBB61, 0xA223, 0x44AA, [0x84, 0x2F, 0xA2, 0xF0, 0x67, 0x50, 0xBE, 0x6E]);
interface IMediaParams : IUnknown
{
    HRESULT GetParam(uint dwParamIndex, float* pValue);
    HRESULT SetParam(uint dwParamIndex, float value);
    HRESULT AddEnvelope(uint dwParamIndex, uint cSegments, MP_ENVELOPE_SEGMENT* pEnvelopeSegments);
    HRESULT FlushEnvelope(uint dwParamIndex, long refTimeStart, long refTimeEnd);
    HRESULT SetTimeFormat(Guid guidTimeFormat, uint mpTimeData);
}

struct DMO_PARTIAL_MEDIATYPE
{
    Guid type;
    Guid subtype;
}

enum DMO_REGISTER_FLAGS
{
    DMO_REGISTERF_IS_KEYED = 1,
}

enum DMO_ENUM_FLAGS
{
    DMO_ENUMF_INCLUDE_KEYED = 1,
}

@DllImport("QUARTZ.dll")
uint AMGetErrorTextA(HRESULT hr, const(char)* pbuffer, uint MaxLen);

@DllImport("QUARTZ.dll")
uint AMGetErrorTextW(HRESULT hr, const(wchar)* pbuffer, uint MaxLen);

@DllImport("msdmo.dll")
HRESULT DMORegister(const(wchar)* szName, const(Guid)* clsidDMO, const(Guid)* guidCategory, uint dwFlags, uint cInTypes, const(DMO_PARTIAL_MEDIATYPE)* pInTypes, uint cOutTypes, const(DMO_PARTIAL_MEDIATYPE)* pOutTypes);

@DllImport("msdmo.dll")
HRESULT DMOUnregister(const(Guid)* clsidDMO, const(Guid)* guidCategory);

@DllImport("msdmo.dll")
HRESULT DMOEnum(const(Guid)* guidCategory, uint dwFlags, uint cInTypes, const(DMO_PARTIAL_MEDIATYPE)* pInTypes, uint cOutTypes, const(DMO_PARTIAL_MEDIATYPE)* pOutTypes, IEnumDMO* ppEnum);

@DllImport("msdmo.dll")
HRESULT DMOGetTypes(const(Guid)* clsidDMO, uint ulInputTypesRequested, uint* pulInputTypesSupplied, DMO_PARTIAL_MEDIATYPE* pInputTypes, uint ulOutputTypesRequested, uint* pulOutputTypesSupplied, DMO_PARTIAL_MEDIATYPE* pOutputTypes);

@DllImport("msdmo.dll")
HRESULT DMOGetName(const(Guid)* clsidDMO, char* szName);

@DllImport("msdmo.dll")
HRESULT MoInitMediaType(AM_MEDIA_TYPE* pmt, uint cbFormat);

@DllImport("msdmo.dll")
HRESULT MoFreeMediaType(AM_MEDIA_TYPE* pmt);

@DllImport("msdmo.dll")
HRESULT MoCopyMediaType(AM_MEDIA_TYPE* pmtDest, const(AM_MEDIA_TYPE)* pmtSrc);

@DllImport("msdmo.dll")
HRESULT MoCreateMediaType(AM_MEDIA_TYPE** ppmt, uint cbFormat);

@DllImport("msdmo.dll")
HRESULT MoDeleteMediaType(AM_MEDIA_TYPE* pmt);

@DllImport("msdmo.dll")
HRESULT MoDuplicateMediaType(AM_MEDIA_TYPE** ppmtDest, const(AM_MEDIA_TYPE)* pmtSrc);

struct KSTOPOLOGY_CONNECTION
{
    uint FromNode;
    uint FromNodePin;
    uint ToNode;
    uint ToNodePin;
}

struct TIMECODE
{
    _Anonymous_e__Struct Anonymous;
    ulong qw;
}

struct TIMECODE_SAMPLE
{
    long qwTick;
    TIMECODE timecode;
    uint dwUser;
    uint dwFlags;
}

enum VIDEOENCODER_BITRATE_MODE
{
    ConstantBitRate = 0,
    VariableBitRateAverage = 1,
    VariableBitRatePeak = 2,
}

const GUID CLSID_SystemTuningSpaces = {0xD02AAC50, 0x027E, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0xD02AAC50, 0x027E, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
struct SystemTuningSpaces;

const GUID CLSID_TuningSpace = {0x5FFDC5E6, 0xB83A, 0x4B55, [0xB6, 0xE8, 0xC6, 0x9E, 0x76, 0x5F, 0xE9, 0xDB]};
@GUID(0x5FFDC5E6, 0xB83A, 0x4B55, [0xB6, 0xE8, 0xC6, 0x9E, 0x76, 0x5F, 0xE9, 0xDB]);
struct TuningSpace;

const GUID CLSID_ChannelIDTuningSpace = {0xCC829A2F, 0x3365, 0x463F, [0xAF, 0x13, 0x81, 0xDB, 0xB6, 0xF3, 0xA5, 0x55]};
@GUID(0xCC829A2F, 0x3365, 0x463F, [0xAF, 0x13, 0x81, 0xDB, 0xB6, 0xF3, 0xA5, 0x55]);
struct ChannelIDTuningSpace;

const GUID CLSID_ATSCTuningSpace = {0xA2E30750, 0x6C3D, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xA2E30750, 0x6C3D, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct ATSCTuningSpace;

const GUID CLSID_DigitalCableTuningSpace = {0xD9BB4CEE, 0xB87A, 0x47F1, [0xAC, 0x92, 0xB0, 0x8D, 0x9C, 0x78, 0x13, 0xFC]};
@GUID(0xD9BB4CEE, 0xB87A, 0x47F1, [0xAC, 0x92, 0xB0, 0x8D, 0x9C, 0x78, 0x13, 0xFC]);
struct DigitalCableTuningSpace;

const GUID CLSID_AnalogRadioTuningSpace = {0x8A674B4C, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x8A674B4C, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct AnalogRadioTuningSpace;

const GUID CLSID_AuxInTuningSpace = {0xF9769A06, 0x7ACA, 0x4E39, [0x9C, 0xFB, 0x97, 0xBB, 0x35, 0xF0, 0xE7, 0x7E]};
@GUID(0xF9769A06, 0x7ACA, 0x4E39, [0x9C, 0xFB, 0x97, 0xBB, 0x35, 0xF0, 0xE7, 0x7E]);
struct AuxInTuningSpace;

const GUID CLSID_AnalogTVTuningSpace = {0x8A674B4D, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x8A674B4D, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct AnalogTVTuningSpace;

const GUID CLSID_DVBTuningSpace = {0xC6B14B32, 0x76AA, 0x4A86, [0xA7, 0xAC, 0x5C, 0x79, 0xAA, 0xF5, 0x8D, 0xA7]};
@GUID(0xC6B14B32, 0x76AA, 0x4A86, [0xA7, 0xAC, 0x5C, 0x79, 0xAA, 0xF5, 0x8D, 0xA7]);
struct DVBTuningSpace;

const GUID CLSID_DVBSTuningSpace = {0xB64016F3, 0xC9A2, 0x4066, [0x96, 0xF0, 0xBD, 0x95, 0x63, 0x31, 0x47, 0x26]};
@GUID(0xB64016F3, 0xC9A2, 0x4066, [0x96, 0xF0, 0xBD, 0x95, 0x63, 0x31, 0x47, 0x26]);
struct DVBSTuningSpace;

const GUID CLSID_ComponentTypes = {0xA1A2B1C4, 0x0E3A, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0xA1A2B1C4, 0x0E3A, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
struct ComponentTypes;

const GUID CLSID_ComponentType = {0x823535A0, 0x0318, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x823535A0, 0x0318, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
struct ComponentType;

const GUID CLSID_LanguageComponentType = {0x1BE49F30, 0x0E1B, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x1BE49F30, 0x0E1B, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
struct LanguageComponentType;

const GUID CLSID_MPEG2ComponentType = {0x418008F3, 0xCF67, 0x4668, [0x96, 0x28, 0x10, 0xDC, 0x52, 0xBE, 0x1D, 0x08]};
@GUID(0x418008F3, 0xCF67, 0x4668, [0x96, 0x28, 0x10, 0xDC, 0x52, 0xBE, 0x1D, 0x08]);
struct MPEG2ComponentType;

const GUID CLSID_ATSCComponentType = {0xA8DCF3D5, 0x0780, 0x4EF4, [0x8A, 0x83, 0x2C, 0xFF, 0xAA, 0xCB, 0x8A, 0xCE]};
@GUID(0xA8DCF3D5, 0x0780, 0x4EF4, [0x8A, 0x83, 0x2C, 0xFF, 0xAA, 0xCB, 0x8A, 0xCE]);
struct ATSCComponentType;

const GUID CLSID_Components = {0x809B6661, 0x94C4, 0x49E6, [0xB6, 0xEC, 0x3F, 0x0F, 0x86, 0x22, 0x15, 0xAA]};
@GUID(0x809B6661, 0x94C4, 0x49E6, [0xB6, 0xEC, 0x3F, 0x0F, 0x86, 0x22, 0x15, 0xAA]);
struct Components;

const GUID CLSID_Component = {0x59DC47A8, 0x116C, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x59DC47A8, 0x116C, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
struct Component;

const GUID CLSID_MPEG2Component = {0x055CB2D7, 0x2969, 0x45CD, [0x91, 0x4B, 0x76, 0x89, 0x07, 0x22, 0xF1, 0x12]};
@GUID(0x055CB2D7, 0x2969, 0x45CD, [0x91, 0x4B, 0x76, 0x89, 0x07, 0x22, 0xF1, 0x12]);
struct MPEG2Component;

const GUID CLSID_AnalogAudioComponentType = {0x28AB0005, 0xE845, 0x4FFA, [0xAA, 0x9B, 0xF4, 0x66, 0x52, 0x36, 0x14, 0x1C]};
@GUID(0x28AB0005, 0xE845, 0x4FFA, [0xAA, 0x9B, 0xF4, 0x66, 0x52, 0x36, 0x14, 0x1C]);
struct AnalogAudioComponentType;

const GUID CLSID_TuneRequest = {0xB46E0D38, 0xAB35, 0x4A06, [0xA1, 0x37, 0x70, 0x57, 0x6B, 0x01, 0xB3, 0x9F]};
@GUID(0xB46E0D38, 0xAB35, 0x4A06, [0xA1, 0x37, 0x70, 0x57, 0x6B, 0x01, 0xB3, 0x9F]);
struct TuneRequest;

const GUID CLSID_ChannelIDTuneRequest = {0x3A9428A7, 0x31A4, 0x45E9, [0x9E, 0xFB, 0xE0, 0x55, 0xBF, 0x7B, 0xB3, 0xDB]};
@GUID(0x3A9428A7, 0x31A4, 0x45E9, [0x9E, 0xFB, 0xE0, 0x55, 0xBF, 0x7B, 0xB3, 0xDB]);
struct ChannelIDTuneRequest;

const GUID CLSID_ChannelTuneRequest = {0x0369B4E5, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x0369B4E5, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct ChannelTuneRequest;

const GUID CLSID_ATSCChannelTuneRequest = {0x0369B4E6, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x0369B4E6, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct ATSCChannelTuneRequest;

const GUID CLSID_DigitalCableTuneRequest = {0x26EC0B63, 0xAA90, 0x458A, [0x8D, 0xF4, 0x56, 0x59, 0xF2, 0xC8, 0xA1, 0x8A]};
@GUID(0x26EC0B63, 0xAA90, 0x458A, [0x8D, 0xF4, 0x56, 0x59, 0xF2, 0xC8, 0xA1, 0x8A]);
struct DigitalCableTuneRequest;

const GUID CLSID_MPEG2TuneRequest = {0x0955AC62, 0xBF2E, 0x4CBA, [0xA2, 0xB9, 0xA6, 0x3F, 0x77, 0x2D, 0x46, 0xCF]};
@GUID(0x0955AC62, 0xBF2E, 0x4CBA, [0xA2, 0xB9, 0xA6, 0x3F, 0x77, 0x2D, 0x46, 0xCF]);
struct MPEG2TuneRequest;

const GUID CLSID_MPEG2TuneRequestFactory = {0x2C63E4EB, 0x4CEA, 0x41B8, [0x91, 0x9C, 0xE9, 0x47, 0xEA, 0x19, 0xA7, 0x7C]};
@GUID(0x2C63E4EB, 0x4CEA, 0x41B8, [0x91, 0x9C, 0xE9, 0x47, 0xEA, 0x19, 0xA7, 0x7C]);
struct MPEG2TuneRequestFactory;

const GUID CLSID_Locator = {0x0888C883, 0xAC4F, 0x4943, [0xB5, 0x16, 0x2C, 0x38, 0xD9, 0xB3, 0x45, 0x62]};
@GUID(0x0888C883, 0xAC4F, 0x4943, [0xB5, 0x16, 0x2C, 0x38, 0xD9, 0xB3, 0x45, 0x62]);
struct Locator;

const GUID CLSID_DigitalLocator = {0x6E50CC0D, 0xC19B, 0x4BF6, [0x81, 0x0B, 0x5B, 0xD6, 0x07, 0x61, 0xF5, 0xCC]};
@GUID(0x6E50CC0D, 0xC19B, 0x4BF6, [0x81, 0x0B, 0x5B, 0xD6, 0x07, 0x61, 0xF5, 0xCC]);
struct DigitalLocator;

const GUID CLSID_AnalogLocator = {0x49638B91, 0x48AB, 0x48B7, [0xA4, 0x7A, 0x7D, 0x0E, 0x75, 0xA0, 0x8E, 0xDE]};
@GUID(0x49638B91, 0x48AB, 0x48B7, [0xA4, 0x7A, 0x7D, 0x0E, 0x75, 0xA0, 0x8E, 0xDE]);
struct AnalogLocator;

const GUID CLSID_ATSCLocator = {0x8872FF1B, 0x98FA, 0x4D7A, [0x8D, 0x93, 0xC9, 0xF1, 0x05, 0x5F, 0x85, 0xBB]};
@GUID(0x8872FF1B, 0x98FA, 0x4D7A, [0x8D, 0x93, 0xC9, 0xF1, 0x05, 0x5F, 0x85, 0xBB]);
struct ATSCLocator;

const GUID CLSID_DigitalCableLocator = {0x03C06416, 0xD127, 0x407A, [0xAB, 0x4C, 0xFD, 0xD2, 0x79, 0xAB, 0xBE, 0x5D]};
@GUID(0x03C06416, 0xD127, 0x407A, [0xAB, 0x4C, 0xFD, 0xD2, 0x79, 0xAB, 0xBE, 0x5D]);
struct DigitalCableLocator;

const GUID CLSID_DVBTLocator = {0x9CD64701, 0xBDF3, 0x4D14, [0x8E, 0x03, 0xF1, 0x29, 0x83, 0xD8, 0x66, 0x64]};
@GUID(0x9CD64701, 0xBDF3, 0x4D14, [0x8E, 0x03, 0xF1, 0x29, 0x83, 0xD8, 0x66, 0x64]);
struct DVBTLocator;

const GUID CLSID_DVBTLocator2 = {0xEFE3FA02, 0x45D7, 0x4920, [0xBE, 0x96, 0x53, 0xFA, 0x7F, 0x35, 0xB0, 0xE6]};
@GUID(0xEFE3FA02, 0x45D7, 0x4920, [0xBE, 0x96, 0x53, 0xFA, 0x7F, 0x35, 0xB0, 0xE6]);
struct DVBTLocator2;

const GUID CLSID_DVBSLocator = {0x1DF7D126, 0x4050, 0x47F0, [0xA7, 0xCF, 0x4C, 0x4C, 0xA9, 0x24, 0x13, 0x33]};
@GUID(0x1DF7D126, 0x4050, 0x47F0, [0xA7, 0xCF, 0x4C, 0x4C, 0xA9, 0x24, 0x13, 0x33]);
struct DVBSLocator;

const GUID CLSID_DVBCLocator = {0xC531D9FD, 0x9685, 0x4028, [0x8B, 0x68, 0x6E, 0x12, 0x32, 0x07, 0x9F, 0x1E]};
@GUID(0xC531D9FD, 0x9685, 0x4028, [0x8B, 0x68, 0x6E, 0x12, 0x32, 0x07, 0x9F, 0x1E]);
struct DVBCLocator;

const GUID CLSID_ISDBSLocator = {0x6504AFED, 0xA629, 0x455C, [0xA7, 0xF1, 0x04, 0x96, 0x4D, 0xEA, 0x5C, 0xC4]};
@GUID(0x6504AFED, 0xA629, 0x455C, [0xA7, 0xF1, 0x04, 0x96, 0x4D, 0xEA, 0x5C, 0xC4]);
struct ISDBSLocator;

const GUID CLSID_DVBTuneRequest = {0x15D6504A, 0x5494, 0x499C, [0x88, 0x6C, 0x97, 0x3C, 0x9E, 0x53, 0xB9, 0xF1]};
@GUID(0x15D6504A, 0x5494, 0x499C, [0x88, 0x6C, 0x97, 0x3C, 0x9E, 0x53, 0xB9, 0xF1]);
struct DVBTuneRequest;

const GUID CLSID_CreatePropBagOnRegKey = {0x8A674B49, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x8A674B49, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct CreatePropBagOnRegKey;

const GUID CLSID_BroadcastEventService = {0x0B3FFB92, 0x0919, 0x4934, [0x9D, 0x5B, 0x61, 0x9C, 0x71, 0x9D, 0x02, 0x02]};
@GUID(0x0B3FFB92, 0x0919, 0x4934, [0x9D, 0x5B, 0x61, 0x9C, 0x71, 0x9D, 0x02, 0x02]);
struct BroadcastEventService;

const GUID CLSID_TunerMarshaler = {0x6438570B, 0x0C08, 0x4A25, [0x95, 0x04, 0x80, 0x12, 0xBB, 0x4D, 0x50, 0xCF]};
@GUID(0x6438570B, 0x0C08, 0x4A25, [0x95, 0x04, 0x80, 0x12, 0xBB, 0x4D, 0x50, 0xCF]);
struct TunerMarshaler;

const GUID CLSID_PersistTuneXmlUtility = {0xE77026B0, 0xB97F, 0x4CBB, [0xB7, 0xFB, 0xF4, 0xF0, 0x3A, 0xD6, 0x9F, 0x11]};
@GUID(0xE77026B0, 0xB97F, 0x4CBB, [0xB7, 0xFB, 0xF4, 0xF0, 0x3A, 0xD6, 0x9F, 0x11]);
struct PersistTuneXmlUtility;

const GUID CLSID_ESEventService = {0xC20447FC, 0xEC60, 0x475E, [0x81, 0x3F, 0xD2, 0xB0, 0xA6, 0xDE, 0xCE, 0xFE]};
@GUID(0xC20447FC, 0xEC60, 0x475E, [0x81, 0x3F, 0xD2, 0xB0, 0xA6, 0xDE, 0xCE, 0xFE]);
struct ESEventService;

const GUID CLSID_ESEventFactory = {0x8E8A07DA, 0x71F8, 0x40C1, [0xA9, 0x29, 0x5E, 0x3A, 0x86, 0x8A, 0xC2, 0xC6]};
@GUID(0x8E8A07DA, 0x71F8, 0x40C1, [0xA9, 0x29, 0x5E, 0x3A, 0x86, 0x8A, 0xC2, 0xC6]);
struct ESEventFactory;

const GUID IID_ICreatePropBagOnRegKey = {0x8A674B48, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x8A674B48, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface ICreatePropBagOnRegKey : IUnknown
{
    HRESULT Create(HKEY hkey, ushort* subkey, uint ulOptions, uint samDesired, const(Guid)* iid, void** ppBag);
}

enum __MIDL___MIDL_itf_tuner_0000_0000_0001
{
    DISPID_TUNER_TS_UNIQUENAME = 1,
    DISPID_TUNER_TS_FRIENDLYNAME = 2,
    DISPID_TUNER_TS_CLSID = 3,
    DISPID_TUNER_TS_NETWORKTYPE = 4,
    DISPID_TUNER_TS__NETWORKTYPE = 5,
    DISPID_TUNER_TS_CREATETUNEREQUEST = 6,
    DISPID_TUNER_TS_ENUMCATEGORYGUIDS = 7,
    DISPID_TUNER_TS_ENUMDEVICEMONIKERS = 8,
    DISPID_TUNER_TS_DEFAULTPREFERREDCOMPONENTTYPES = 9,
    DISPID_TUNER_TS_FREQMAP = 10,
    DISPID_TUNER_TS_DEFLOCATOR = 11,
    DISPID_TUNER_TS_CLONE = 12,
    DISPID_TUNER_TR_TUNINGSPACE = 1,
    DISPID_TUNER_TR_COMPONENTS = 2,
    DISPID_TUNER_TR_CLONE = 3,
    DISPID_TUNER_TR_LOCATOR = 4,
    DISPID_TUNER_CT_CATEGORY = 1,
    DISPID_TUNER_CT_MEDIAMAJORTYPE = 2,
    DISPID_TUNER_CT__MEDIAMAJORTYPE = 3,
    DISPID_TUNER_CT_MEDIASUBTYPE = 4,
    DISPID_TUNER_CT__MEDIASUBTYPE = 5,
    DISPID_TUNER_CT_MEDIAFORMATTYPE = 6,
    DISPID_TUNER_CT__MEDIAFORMATTYPE = 7,
    DISPID_TUNER_CT_MEDIATYPE = 8,
    DISPID_TUNER_CT_CLONE = 9,
    DISPID_TUNER_LCT_LANGID = 100,
    DISPID_TUNER_MP2CT_TYPE = 200,
    DISPID_TUNER_ATSCCT_FLAGS = 300,
    DISPID_TUNER_L_CARRFREQ = 1,
    DISPID_TUNER_L_INNERFECMETHOD = 2,
    DISPID_TUNER_L_INNERFECRATE = 3,
    DISPID_TUNER_L_OUTERFECMETHOD = 4,
    DISPID_TUNER_L_OUTERFECRATE = 5,
    DISPID_TUNER_L_MOD = 6,
    DISPID_TUNER_L_SYMRATE = 7,
    DISPID_TUNER_L_CLONE = 8,
    DISPID_TUNER_L_ATSC_PHYS_CHANNEL = 201,
    DISPID_TUNER_L_ATSC_TSID = 202,
    DISPID_TUNER_L_ATSC_MP2_PROGNO = 203,
    DISPID_TUNER_L_DVBT_BANDWIDTH = 301,
    DISPID_TUNER_L_DVBT_LPINNERFECMETHOD = 302,
    DISPID_TUNER_L_DVBT_LPINNERFECRATE = 303,
    DISPID_TUNER_L_DVBT_GUARDINTERVAL = 304,
    DISPID_TUNER_L_DVBT_HALPHA = 305,
    DISPID_TUNER_L_DVBT_TRANSMISSIONMODE = 306,
    DISPID_TUNER_L_DVBT_INUSE = 307,
    DISPID_TUNER_L_DVBT2_PHYSICALLAYERPIPEID = 351,
    DISPID_TUNER_L_DVBS_POLARISATION = 401,
    DISPID_TUNER_L_DVBS_WEST = 402,
    DISPID_TUNER_L_DVBS_ORBITAL = 403,
    DISPID_TUNER_L_DVBS_AZIMUTH = 404,
    DISPID_TUNER_L_DVBS_ELEVATION = 405,
    DISPID_TUNER_L_DVBS2_DISEQ_LNB_SOURCE = 406,
    DISPID_TUNER_TS_DVBS2_LOW_OSC_FREQ_OVERRIDE = 407,
    DISPID_TUNER_TS_DVBS2_HI_OSC_FREQ_OVERRIDE = 408,
    DISPID_TUNER_TS_DVBS2_LNB_SWITCH_FREQ_OVERRIDE = 409,
    DISPID_TUNER_TS_DVBS2_SPECTRAL_INVERSION_OVERRIDE = 410,
    DISPID_TUNER_L_DVBS2_ROLLOFF = 411,
    DISPID_TUNER_L_DVBS2_PILOT = 412,
    DISPID_TUNER_L_ANALOG_STANDARD = 601,
    DISPID_TUNER_L_DTV_O_MAJOR_CHANNEL = 701,
    DISPID_TUNER_C_TYPE = 1,
    DISPID_TUNER_C_STATUS = 2,
    DISPID_TUNER_C_LANGID = 3,
    DISPID_TUNER_C_DESCRIPTION = 4,
    DISPID_TUNER_C_CLONE = 5,
    DISPID_TUNER_C_MP2_PID = 101,
    DISPID_TUNER_C_MP2_PCRPID = 102,
    DISPID_TUNER_C_MP2_PROGNO = 103,
    DISPID_TUNER_C_ANALOG_AUDIO = 201,
    DISPID_TUNER_TS_DVB_SYSTEMTYPE = 101,
    DISPID_TUNER_TS_DVB2_NETWORK_ID = 102,
    DISPID_TUNER_TS_DVBS_LOW_OSC_FREQ = 1001,
    DISPID_TUNER_TS_DVBS_HI_OSC_FREQ = 1002,
    DISPID_TUNER_TS_DVBS_LNB_SWITCH_FREQ = 1003,
    DISPID_TUNER_TS_DVBS_INPUT_RANGE = 1004,
    DISPID_TUNER_TS_DVBS_SPECTRAL_INVERSION = 1005,
    DISPID_TUNER_TS_AR_MINFREQUENCY = 101,
    DISPID_TUNER_TS_AR_MAXFREQUENCY = 102,
    DISPID_TUNER_TS_AR_STEP = 103,
    DISPID_TUNER_TS_AR_COUNTRYCODE = 104,
    DISPID_TUNER_TS_AUX_COUNTRYCODE = 101,
    DISPID_TUNER_TS_ATV_MINCHANNEL = 101,
    DISPID_TUNER_TS_ATV_MAXCHANNEL = 102,
    DISPID_TUNER_TS_ATV_INPUTTYPE = 103,
    DISPID_TUNER_TS_ATV_COUNTRYCODE = 104,
    DISPID_TUNER_TS_ATSC_MINMINORCHANNEL = 201,
    DISPID_TUNER_TS_ATSC_MAXMINORCHANNEL = 202,
    DISPID_TUNER_TS_ATSC_MINPHYSCHANNEL = 203,
    DISPID_TUNER_TS_ATSC_MAXPHYSCHANNEL = 204,
    DISPID_TUNER_TS_DC_MINMAJORCHANNEL = 301,
    DISPID_TUNER_TS_DC_MAXMAJORCHANNEL = 302,
    DISPID_TUNER_TS_DC_MINSOURCEID = 303,
    DISPID_TUNER_TS_DC_MAXSOURCEID = 304,
    DISPID_CHTUNER_ATVAC_CHANNEL = 101,
    DISPID_CHTUNER_ATVDC_SYSTEM = 101,
    DISPID_CHTUNER_ATVDC_CONTENT = 102,
    DISPID_CHTUNER_CIDTR_CHANNELID = 101,
    DISPID_CHTUNER_CTR_CHANNEL = 101,
    DISPID_CHTUNER_ACTR_MINOR_CHANNEL = 201,
    DISPID_CHTUNER_DCTR_MAJOR_CHANNEL = 301,
    DISPID_CHTUNER_DCTR_SRCID = 302,
    DISPID_DVBTUNER_DVBC_ATTRIBUTESVALID = 101,
    DISPID_DVBTUNER_DVBC_PID = 102,
    DISPID_DVBTUNER_DVBC_TAG = 103,
    DISPID_DVBTUNER_DVBC_COMPONENTTYPE = 104,
    DISPID_DVBTUNER_ONID = 101,
    DISPID_DVBTUNER_TSID = 102,
    DISPID_DVBTUNER_SID = 103,
    DISPID_MP2TUNER_TSID = 101,
    DISPID_MP2TUNER_PROGNO = 102,
    DISPID_MP2TUNERFACTORY_CREATETUNEREQUEST = 1,
}

const GUID IID_ITuningSpaces = {0x901284E4, 0x33FE, 0x4B69, [0x8D, 0x63, 0x63, 0x4A, 0x59, 0x6F, 0x37, 0x56]};
@GUID(0x901284E4, 0x33FE, 0x4B69, [0x8D, 0x63, 0x63, 0x4A, 0x59, 0x6F, 0x37, 0x56]);
interface ITuningSpaces : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(VARIANT varIndex, ITuningSpace* TuningSpace);
    HRESULT get_EnumTuningSpaces(IEnumTuningSpaces* NewEnum);
}

const GUID IID_ITuningSpaceContainer = {0x5B692E84, 0xE2F1, 0x11D2, [0x94, 0x93, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x5B692E84, 0xE2F1, 0x11D2, [0x94, 0x93, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
interface ITuningSpaceContainer : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(VARIANT varIndex, ITuningSpace* TuningSpace);
    HRESULT put_Item(VARIANT varIndex, ITuningSpace TuningSpace);
    HRESULT TuningSpacesForCLSID(BSTR SpaceCLSID, ITuningSpaces* NewColl);
    HRESULT _TuningSpacesForCLSID2(const(Guid)* SpaceCLSID, ITuningSpaces* NewColl);
    HRESULT TuningSpacesForName(BSTR Name, ITuningSpaces* NewColl);
    HRESULT FindID(ITuningSpace TuningSpace, int* ID);
    HRESULT Add(ITuningSpace TuningSpace, VARIANT* NewIndex);
    HRESULT get_EnumTuningSpaces(IEnumTuningSpaces* ppEnum);
    HRESULT Remove(VARIANT Index);
    HRESULT get_MaxCount(int* MaxCount);
    HRESULT put_MaxCount(int MaxCount);
}

const GUID IID_ITuningSpace = {0x061C6E30, 0xE622, 0x11D2, [0x94, 0x93, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x061C6E30, 0xE622, 0x11D2, [0x94, 0x93, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
interface ITuningSpace : IDispatch
{
    HRESULT get_UniqueName(BSTR* Name);
    HRESULT put_UniqueName(BSTR Name);
    HRESULT get_FriendlyName(BSTR* Name);
    HRESULT put_FriendlyName(BSTR Name);
    HRESULT get_CLSID(BSTR* SpaceCLSID);
    HRESULT get_NetworkType(BSTR* NetworkTypeGuid);
    HRESULT put_NetworkType(BSTR NetworkTypeGuid);
    HRESULT get__NetworkType(Guid* NetworkTypeGuid);
    HRESULT put__NetworkType(const(Guid)* NetworkTypeGuid);
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

const GUID IID_IEnumTuningSpaces = {0x8B8EB248, 0xFC2B, 0x11D2, [0x9D, 0x8C, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x8B8EB248, 0xFC2B, 0x11D2, [0x9D, 0x8C, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
interface IEnumTuningSpaces : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumTuningSpaces* ppEnum);
}

const GUID IID_IDVBTuningSpace = {0xADA0B268, 0x3B19, 0x4E5B, [0xAC, 0xC4, 0x49, 0xF8, 0x52, 0xBE, 0x13, 0xBA]};
@GUID(0xADA0B268, 0x3B19, 0x4E5B, [0xAC, 0xC4, 0x49, 0xF8, 0x52, 0xBE, 0x13, 0xBA]);
interface IDVBTuningSpace : ITuningSpace
{
    HRESULT get_SystemType(DVBSystemType* SysType);
    HRESULT put_SystemType(DVBSystemType SysType);
}

const GUID IID_IDVBTuningSpace2 = {0x843188B4, 0xCE62, 0x43DB, [0x96, 0x6B, 0x81, 0x45, 0xA0, 0x94, 0xE0, 0x40]};
@GUID(0x843188B4, 0xCE62, 0x43DB, [0x96, 0x6B, 0x81, 0x45, 0xA0, 0x94, 0xE0, 0x40]);
interface IDVBTuningSpace2 : IDVBTuningSpace
{
    HRESULT get_NetworkID(int* NetworkID);
    HRESULT put_NetworkID(int NetworkID);
}

const GUID IID_IDVBSTuningSpace = {0xCDF7BE60, 0xD954, 0x42FD, [0xA9, 0x72, 0x78, 0x97, 0x19, 0x58, 0xE4, 0x70]};
@GUID(0xCDF7BE60, 0xD954, 0x42FD, [0xA9, 0x72, 0x78, 0x97, 0x19, 0x58, 0xE4, 0x70]);
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

const GUID IID_IAuxInTuningSpace = {0xE48244B8, 0x7E17, 0x4F76, [0xA7, 0x63, 0x50, 0x90, 0xFF, 0x1E, 0x2F, 0x30]};
@GUID(0xE48244B8, 0x7E17, 0x4F76, [0xA7, 0x63, 0x50, 0x90, 0xFF, 0x1E, 0x2F, 0x30]);
interface IAuxInTuningSpace : ITuningSpace
{
}

const GUID IID_IAuxInTuningSpace2 = {0xB10931ED, 0x8BFE, 0x4AB0, [0x9D, 0xCE, 0xE4, 0x69, 0xC2, 0x9A, 0x97, 0x29]};
@GUID(0xB10931ED, 0x8BFE, 0x4AB0, [0x9D, 0xCE, 0xE4, 0x69, 0xC2, 0x9A, 0x97, 0x29]);
interface IAuxInTuningSpace2 : IAuxInTuningSpace
{
    HRESULT get_CountryCode(int* CountryCodeVal);
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

const GUID IID_IAnalogTVTuningSpace = {0x2A6E293C, 0x2595, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x2A6E293C, 0x2595, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
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

const GUID IID_IATSCTuningSpace = {0x0369B4E2, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x0369B4E2, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
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

const GUID IID_IDigitalCableTuningSpace = {0x013F9F9C, 0xB449, 0x4EC7, [0xA6, 0xD2, 0x9D, 0x4F, 0x2F, 0xC7, 0x0A, 0xE5]};
@GUID(0x013F9F9C, 0xB449, 0x4EC7, [0xA6, 0xD2, 0x9D, 0x4F, 0x2F, 0xC7, 0x0A, 0xE5]);
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

const GUID IID_IAnalogRadioTuningSpace = {0x2A6E293B, 0x2595, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x2A6E293B, 0x2595, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IAnalogRadioTuningSpace : ITuningSpace
{
    HRESULT get_MinFrequency(int* MinFrequencyVal);
    HRESULT put_MinFrequency(int NewMinFrequencyVal);
    HRESULT get_MaxFrequency(int* MaxFrequencyVal);
    HRESULT put_MaxFrequency(int NewMaxFrequencyVal);
    HRESULT get_Step(int* StepVal);
    HRESULT put_Step(int NewStepVal);
}

const GUID IID_IAnalogRadioTuningSpace2 = {0x39DD45DA, 0x2DA8, 0x46BA, [0x8A, 0x8A, 0x87, 0xE2, 0xB7, 0x3D, 0x98, 0x3A]};
@GUID(0x39DD45DA, 0x2DA8, 0x46BA, [0x8A, 0x8A, 0x87, 0xE2, 0xB7, 0x3D, 0x98, 0x3A]);
interface IAnalogRadioTuningSpace2 : IAnalogRadioTuningSpace
{
    HRESULT get_CountryCode(int* CountryCodeVal);
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

const GUID IID_ITuneRequest = {0x07DDC146, 0xFC3D, 0x11D2, [0x9D, 0x8C, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x07DDC146, 0xFC3D, 0x11D2, [0x9D, 0x8C, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
interface ITuneRequest : IDispatch
{
    HRESULT get_TuningSpace(ITuningSpace* TuningSpace);
    HRESULT get_Components(IComponents* Components);
    HRESULT Clone(ITuneRequest* NewTuneRequest);
    HRESULT get_Locator(ILocator* Locator);
    HRESULT put_Locator(ILocator Locator);
}

const GUID IID_IChannelIDTuneRequest = {0x156EFF60, 0x86F4, 0x4E28, [0x89, 0xFC, 0x10, 0x97, 0x99, 0xFD, 0x57, 0xEE]};
@GUID(0x156EFF60, 0x86F4, 0x4E28, [0x89, 0xFC, 0x10, 0x97, 0x99, 0xFD, 0x57, 0xEE]);
interface IChannelIDTuneRequest : ITuneRequest
{
    HRESULT get_ChannelID(BSTR* ChannelID);
    HRESULT put_ChannelID(BSTR ChannelID);
}

const GUID IID_IChannelTuneRequest = {0x0369B4E0, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x0369B4E0, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IChannelTuneRequest : ITuneRequest
{
    HRESULT get_Channel(int* Channel);
    HRESULT put_Channel(int Channel);
}

const GUID IID_IATSCChannelTuneRequest = {0x0369B4E1, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x0369B4E1, 0x45B6, 0x11D3, [0xB6, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IATSCChannelTuneRequest : IChannelTuneRequest
{
    HRESULT get_MinorChannel(int* MinorChannel);
    HRESULT put_MinorChannel(int MinorChannel);
}

const GUID IID_IDigitalCableTuneRequest = {0xBAD7753B, 0x6B37, 0x4810, [0xAE, 0x57, 0x3C, 0xE0, 0xC4, 0xA9, 0xE6, 0xCB]};
@GUID(0xBAD7753B, 0x6B37, 0x4810, [0xAE, 0x57, 0x3C, 0xE0, 0xC4, 0xA9, 0xE6, 0xCB]);
interface IDigitalCableTuneRequest : IATSCChannelTuneRequest
{
    HRESULT get_MajorChannel(int* pMajorChannel);
    HRESULT put_MajorChannel(int MajorChannel);
    HRESULT get_SourceID(int* pSourceID);
    HRESULT put_SourceID(int SourceID);
}

const GUID IID_IDVBTuneRequest = {0x0D6F567E, 0xA636, 0x42BB, [0x83, 0xBA, 0xCE, 0x4C, 0x17, 0x04, 0xAF, 0xA2]};
@GUID(0x0D6F567E, 0xA636, 0x42BB, [0x83, 0xBA, 0xCE, 0x4C, 0x17, 0x04, 0xAF, 0xA2]);
interface IDVBTuneRequest : ITuneRequest
{
    HRESULT get_ONID(int* ONID);
    HRESULT put_ONID(int ONID);
    HRESULT get_TSID(int* TSID);
    HRESULT put_TSID(int TSID);
    HRESULT get_SID(int* SID);
    HRESULT put_SID(int SID);
}

const GUID IID_IMPEG2TuneRequest = {0xEB7D987F, 0x8A01, 0x42AD, [0xB8, 0xAE, 0x57, 0x4D, 0xEE, 0xE4, 0x4D, 0x1A]};
@GUID(0xEB7D987F, 0x8A01, 0x42AD, [0xB8, 0xAE, 0x57, 0x4D, 0xEE, 0xE4, 0x4D, 0x1A]);
interface IMPEG2TuneRequest : ITuneRequest
{
    HRESULT get_TSID(int* TSID);
    HRESULT put_TSID(int TSID);
    HRESULT get_ProgNo(int* ProgNo);
    HRESULT put_ProgNo(int ProgNo);
}

const GUID IID_IMPEG2TuneRequestFactory = {0x14E11ABD, 0xEE37, 0x4893, [0x9E, 0xA1, 0x69, 0x64, 0xDE, 0x93, 0x3E, 0x39]};
@GUID(0x14E11ABD, 0xEE37, 0x4893, [0x9E, 0xA1, 0x69, 0x64, 0xDE, 0x93, 0x3E, 0x39]);
interface IMPEG2TuneRequestFactory : IDispatch
{
    HRESULT CreateTuneRequest(ITuningSpace TuningSpace, IMPEG2TuneRequest* TuneRequest);
}

const GUID IID_IMPEG2TuneRequestSupport = {0x1B9D5FC3, 0x5BBC, 0x4B6C, [0xBB, 0x18, 0xB9, 0xD1, 0x0E, 0x3E, 0xEE, 0xBF]};
@GUID(0x1B9D5FC3, 0x5BBC, 0x4B6C, [0xBB, 0x18, 0xB9, 0xD1, 0x0E, 0x3E, 0xEE, 0xBF]);
interface IMPEG2TuneRequestSupport : IUnknown
{
}

const GUID IID_ITunerCap = {0xE60DFA45, 0x8D56, 0x4E65, [0xA8, 0xAB, 0xD6, 0xBE, 0x94, 0x12, 0xC2, 0x49]};
@GUID(0xE60DFA45, 0x8D56, 0x4E65, [0xA8, 0xAB, 0xD6, 0xBE, 0x94, 0x12, 0xC2, 0x49]);
interface ITunerCap : IUnknown
{
    HRESULT get_SupportedNetworkTypes(uint ulcNetworkTypesMax, uint* pulcNetworkTypes, Guid* pguidNetworkTypes);
    HRESULT get_SupportedVideoFormats(uint* pulAMTunerModeType, uint* pulAnalogVideoStandard);
    HRESULT get_AuxInputCount(uint* pulCompositeCount, uint* pulSvideoCount);
}

const GUID IID_ITunerCapEx = {0xED3E0C66, 0x18C8, 0x4EA6, [0x93, 0x00, 0xF6, 0x84, 0x1F, 0xDD, 0x35, 0xDC]};
@GUID(0xED3E0C66, 0x18C8, 0x4EA6, [0x93, 0x00, 0xF6, 0x84, 0x1F, 0xDD, 0x35, 0xDC]);
interface ITunerCapEx : IUnknown
{
    HRESULT get_Has608_708Caption(short* pbHasCaption);
}

const GUID IID_ITuner = {0x28C52640, 0x018A, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x28C52640, 0x018A, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
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

const GUID IID_IScanningTuner = {0x1DFD0A5C, 0x0284, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x1DFD0A5C, 0x0284, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
interface IScanningTuner : ITuner
{
    HRESULT SeekUp();
    HRESULT SeekDown();
    HRESULT ScanUp(int MillisecondsPause);
    HRESULT ScanDown(int MillisecondsPause);
    HRESULT AutoProgram();
}

const GUID IID_IScanningTunerEx = {0x04BBD195, 0x0E2D, 0x4593, [0x9B, 0xD5, 0x4F, 0x90, 0x8B, 0xC3, 0x3C, 0xF5]};
@GUID(0x04BBD195, 0x0E2D, 0x4593, [0x9B, 0xD5, 0x4F, 0x90, 0x8B, 0xC3, 0x3C, 0xF5]);
interface IScanningTunerEx : IScanningTuner
{
    HRESULT GetCurrentLocator(ILocator* pILocator);
    HRESULT PerformExhaustiveScan(int dwLowerFreq, int dwHigherFreq, short bFineTune, uint hEvent);
    HRESULT TerminateCurrentScan(int* pcurrentFreq);
    HRESULT ResumeCurrentScan(uint hEvent);
    HRESULT GetTunerScanningCapability(int* HardwareAssistedScanning, int* NumStandardsSupported, Guid* BroadcastStandards);
    HRESULT GetTunerStatus(int* SecondsLeft, int* CurrentLockType, int* AutoDetect, int* CurrentFreq);
    HRESULT GetCurrentTunerStandardCapability(Guid CurrentBroadcastStandard, int* SettlingTime, int* TvStandardsSupported);
    HRESULT SetScanSignalTypeFilter(int ScanModulationTypes, int AnalogVideoStandard);
}

const GUID IID_IComponentType = {0x6A340DC0, 0x0311, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x6A340DC0, 0x0311, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
interface IComponentType : IDispatch
{
    HRESULT get_Category(ComponentCategory* Category);
    HRESULT put_Category(ComponentCategory Category);
    HRESULT get_MediaMajorType(BSTR* MediaMajorType);
    HRESULT put_MediaMajorType(BSTR MediaMajorType);
    HRESULT get__MediaMajorType(Guid* MediaMajorTypeGuid);
    HRESULT put__MediaMajorType(const(Guid)* MediaMajorTypeGuid);
    HRESULT get_MediaSubType(BSTR* MediaSubType);
    HRESULT put_MediaSubType(BSTR MediaSubType);
    HRESULT get__MediaSubType(Guid* MediaSubTypeGuid);
    HRESULT put__MediaSubType(const(Guid)* MediaSubTypeGuid);
    HRESULT get_MediaFormatType(BSTR* MediaFormatType);
    HRESULT put_MediaFormatType(BSTR MediaFormatType);
    HRESULT get__MediaFormatType(Guid* MediaFormatTypeGuid);
    HRESULT put__MediaFormatType(const(Guid)* MediaFormatTypeGuid);
    HRESULT get_MediaType(AM_MEDIA_TYPE* MediaType);
    HRESULT put_MediaType(AM_MEDIA_TYPE* MediaType);
    HRESULT Clone(IComponentType* NewCT);
}

const GUID IID_ILanguageComponentType = {0xB874C8BA, 0x0FA2, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0xB874C8BA, 0x0FA2, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
interface ILanguageComponentType : IComponentType
{
    HRESULT get_LangID(int* LangID);
    HRESULT put_LangID(int LangID);
}

const GUID IID_IMPEG2ComponentType = {0x2C073D84, 0xB51C, 0x48C9, [0xAA, 0x9F, 0x68, 0x97, 0x1E, 0x1F, 0x6E, 0x38]};
@GUID(0x2C073D84, 0xB51C, 0x48C9, [0xAA, 0x9F, 0x68, 0x97, 0x1E, 0x1F, 0x6E, 0x38]);
interface IMPEG2ComponentType : ILanguageComponentType
{
    HRESULT get_StreamType(MPEG2StreamType* MP2StreamType);
    HRESULT put_StreamType(MPEG2StreamType MP2StreamType);
}

const GUID IID_IATSCComponentType = {0xFC189E4D, 0x7BD4, 0x4125, [0xB3, 0xB3, 0x3A, 0x76, 0xA3, 0x32, 0xCC, 0x96]};
@GUID(0xFC189E4D, 0x7BD4, 0x4125, [0xB3, 0xB3, 0x3A, 0x76, 0xA3, 0x32, 0xCC, 0x96]);
interface IATSCComponentType : IMPEG2ComponentType
{
    HRESULT get_Flags(int* Flags);
    HRESULT put_Flags(int flags);
}

const GUID IID_IEnumComponentTypes = {0x8A674B4A, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x8A674B4A, 0x1F63, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IEnumComponentTypes : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumComponentTypes* ppEnum);
}

const GUID IID_IComponentTypes = {0x0DC13D4A, 0x0313, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x0DC13D4A, 0x0313, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
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

const GUID IID_IComponent = {0x1A5576FC, 0x0E19, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0x1A5576FC, 0x0E19, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
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

const GUID IID_IAnalogAudioComponentType = {0x2CFEB2A8, 0x1787, 0x4A24, [0xA9, 0x41, 0xC6, 0xEA, 0xEC, 0x39, 0xC8, 0x42]};
@GUID(0x2CFEB2A8, 0x1787, 0x4A24, [0xA9, 0x41, 0xC6, 0xEA, 0xEC, 0x39, 0xC8, 0x42]);
interface IAnalogAudioComponentType : IComponentType
{
    HRESULT get_AnalogAudioMode(TVAudioMode* Mode);
    HRESULT put_AnalogAudioMode(TVAudioMode Mode);
}

const GUID IID_IMPEG2Component = {0x1493E353, 0x1EB6, 0x473C, [0x80, 0x2D, 0x8E, 0x6B, 0x8E, 0xC9, 0xD2, 0xA9]};
@GUID(0x1493E353, 0x1EB6, 0x473C, [0x80, 0x2D, 0x8E, 0x6B, 0x8E, 0xC9, 0xD2, 0xA9]);
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

const GUID IID_IEnumComponents = {0x2A6E2939, 0x2595, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x2A6E2939, 0x2595, 0x11D3, [0xB6, 0x4C, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IEnumComponents : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumComponents* ppEnum);
}

const GUID IID_IComponents = {0x39A48091, 0xFFFE, 0x4182, [0xA1, 0x61, 0x3F, 0xF8, 0x02, 0x64, 0x0E, 0x26]};
@GUID(0x39A48091, 0xFFFE, 0x4182, [0xA1, 0x61, 0x3F, 0xF8, 0x02, 0x64, 0x0E, 0x26]);
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

const GUID IID_IComponentsOld = {0xFCD01846, 0x0E19, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]};
@GUID(0xFCD01846, 0x0E19, 0x11D3, [0x9D, 0x8E, 0x00, 0xC0, 0x4F, 0x72, 0xD9, 0x80]);
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

const GUID IID_ILocator = {0x286D7F89, 0x760C, 0x4F89, [0x80, 0xC4, 0x66, 0x84, 0x1D, 0x25, 0x07, 0xAA]};
@GUID(0x286D7F89, 0x760C, 0x4F89, [0x80, 0xC4, 0x66, 0x84, 0x1D, 0x25, 0x07, 0xAA]);
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

const GUID IID_IAnalogLocator = {0x34D1F26B, 0xE339, 0x430D, [0xAB, 0xCE, 0x73, 0x8C, 0xB4, 0x89, 0x84, 0xDC]};
@GUID(0x34D1F26B, 0xE339, 0x430D, [0xAB, 0xCE, 0x73, 0x8C, 0xB4, 0x89, 0x84, 0xDC]);
interface IAnalogLocator : ILocator
{
    HRESULT get_VideoStandard(AnalogVideoStandard* AVS);
    HRESULT put_VideoStandard(AnalogVideoStandard AVS);
}

const GUID IID_IDigitalLocator = {0x19B595D8, 0x839A, 0x47F0, [0x96, 0xDF, 0x4F, 0x19, 0x4F, 0x3C, 0x76, 0x8C]};
@GUID(0x19B595D8, 0x839A, 0x47F0, [0x96, 0xDF, 0x4F, 0x19, 0x4F, 0x3C, 0x76, 0x8C]);
interface IDigitalLocator : ILocator
{
}

const GUID IID_IATSCLocator = {0xBF8D986F, 0x8C2B, 0x4131, [0x94, 0xD7, 0x4D, 0x3D, 0x9F, 0xCC, 0x21, 0xEF]};
@GUID(0xBF8D986F, 0x8C2B, 0x4131, [0x94, 0xD7, 0x4D, 0x3D, 0x9F, 0xCC, 0x21, 0xEF]);
interface IATSCLocator : IDigitalLocator
{
    HRESULT get_PhysicalChannel(int* PhysicalChannel);
    HRESULT put_PhysicalChannel(int PhysicalChannel);
    HRESULT get_TSID(int* TSID);
    HRESULT put_TSID(int TSID);
}

const GUID IID_IATSCLocator2 = {0x612AA885, 0x66CF, 0x4090, [0xBA, 0x0A, 0x56, 0x6F, 0x53, 0x12, 0xE4, 0xCA]};
@GUID(0x612AA885, 0x66CF, 0x4090, [0xBA, 0x0A, 0x56, 0x6F, 0x53, 0x12, 0xE4, 0xCA]);
interface IATSCLocator2 : IATSCLocator
{
    HRESULT get_ProgramNumber(int* ProgramNumber);
    HRESULT put_ProgramNumber(int ProgramNumber);
}

const GUID IID_IDigitalCableLocator = {0x48F66A11, 0x171A, 0x419A, [0x95, 0x25, 0xBE, 0xEE, 0xCD, 0x51, 0x58, 0x4C]};
@GUID(0x48F66A11, 0x171A, 0x419A, [0x95, 0x25, 0xBE, 0xEE, 0xCD, 0x51, 0x58, 0x4C]);
interface IDigitalCableLocator : IATSCLocator2
{
}

const GUID IID_IDVBTLocator = {0x8664DA16, 0xDDA2, 0x42AC, [0x92, 0x6A, 0xC1, 0x8F, 0x91, 0x27, 0xC3, 0x02]};
@GUID(0x8664DA16, 0xDDA2, 0x42AC, [0x92, 0x6A, 0xC1, 0x8F, 0x91, 0x27, 0xC3, 0x02]);
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

const GUID IID_IDVBTLocator2 = {0x448A2EDF, 0xAE95, 0x4B43, [0xA3, 0xCC, 0x74, 0x78, 0x43, 0xC4, 0x53, 0xD4]};
@GUID(0x448A2EDF, 0xAE95, 0x4B43, [0xA3, 0xCC, 0x74, 0x78, 0x43, 0xC4, 0x53, 0xD4]);
interface IDVBTLocator2 : IDVBTLocator
{
    HRESULT get_PhysicalLayerPipeId(int* PhysicalLayerPipeIdVal);
    HRESULT put_PhysicalLayerPipeId(int PhysicalLayerPipeIdVal);
}

const GUID IID_IDVBSLocator = {0x3D7C353C, 0x0D04, 0x45F1, [0xA7, 0x42, 0xF9, 0x7C, 0xC1, 0x18, 0x8D, 0xC8]};
@GUID(0x3D7C353C, 0x0D04, 0x45F1, [0xA7, 0x42, 0xF9, 0x7C, 0xC1, 0x18, 0x8D, 0xC8]);
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

const GUID IID_IDVBSLocator2 = {0x6044634A, 0x1733, 0x4F99, [0xB9, 0x82, 0x5F, 0xB1, 0x2A, 0xFC, 0xE4, 0xF0]};
@GUID(0x6044634A, 0x1733, 0x4F99, [0xB9, 0x82, 0x5F, 0xB1, 0x2A, 0xFC, 0xE4, 0xF0]);
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

const GUID IID_IDVBCLocator = {0x6E42F36E, 0x1DD2, 0x43C4, [0x9F, 0x78, 0x69, 0xD2, 0x5A, 0xE3, 0x90, 0x34]};
@GUID(0x6E42F36E, 0x1DD2, 0x43C4, [0x9F, 0x78, 0x69, 0xD2, 0x5A, 0xE3, 0x90, 0x34]);
interface IDVBCLocator : IDigitalLocator
{
}

const GUID IID_IISDBSLocator = {0xC9897087, 0xE29C, 0x473F, [0x9E, 0x4B, 0x70, 0x72, 0x12, 0x3D, 0xEA, 0x14]};
@GUID(0xC9897087, 0xE29C, 0x473F, [0x9E, 0x4B, 0x70, 0x72, 0x12, 0x3D, 0xEA, 0x14]);
interface IISDBSLocator : IDVBSLocator
{
}

const GUID IID_IESOpenMmiEvent = {0xBA4B6526, 0x1A35, 0x4635, [0x8B, 0x56, 0x3E, 0xC6, 0x12, 0x74, 0x6A, 0x8C]};
@GUID(0xBA4B6526, 0x1A35, 0x4635, [0x8B, 0x56, 0x3E, 0xC6, 0x12, 0x74, 0x6A, 0x8C]);
interface IESOpenMmiEvent : IESEvent
{
    HRESULT GetDialogNumber(uint* pDialogRequest, uint* pDialogNumber);
    HRESULT GetDialogType(Guid* guidDialogType);
    HRESULT GetDialogData(SAFEARRAY** pbData);
    HRESULT GetDialogStringData(BSTR* pbstrBaseUrl, BSTR* pbstrData);
}

const GUID IID_IESCloseMmiEvent = {0x6B80E96F, 0x55E2, 0x45AA, [0xB7, 0x54, 0x0C, 0x23, 0xC8, 0xE7, 0xD5, 0xC1]};
@GUID(0x6B80E96F, 0x55E2, 0x45AA, [0xB7, 0x54, 0x0C, 0x23, 0xC8, 0xE7, 0xD5, 0xC1]);
interface IESCloseMmiEvent : IESEvent
{
    HRESULT GetDialogNumber(uint* pDialogNumber);
}

const GUID IID_IESValueUpdatedEvent = {0x8A24C46E, 0xBB63, 0x4664, [0x86, 0x02, 0x5D, 0x9C, 0x71, 0x8C, 0x14, 0x6D]};
@GUID(0x8A24C46E, 0xBB63, 0x4664, [0x86, 0x02, 0x5D, 0x9C, 0x71, 0x8C, 0x14, 0x6D]);
interface IESValueUpdatedEvent : IESEvent
{
    HRESULT GetValueNames(SAFEARRAY** pbstrNames);
}

const GUID IID_IESRequestTunerEvent = {0x54C7A5E8, 0xC3BB, 0x4F51, [0xAF, 0x14, 0xE0, 0xE2, 0xC0, 0xE3, 0x4C, 0x6D]};
@GUID(0x54C7A5E8, 0xC3BB, 0x4F51, [0xAF, 0x14, 0xE0, 0xE2, 0xC0, 0xE3, 0x4C, 0x6D]);
interface IESRequestTunerEvent : IESEvent
{
    HRESULT GetPriority(ubyte* pbyPriority);
    HRESULT GetReason(ubyte* pbyReason);
    HRESULT GetConsequences(ubyte* pbyConsequences);
    HRESULT GetEstimatedTime(uint* pdwEstimatedTime);
}

const GUID IID_IESIsdbCasResponseEvent = {0x2017CB03, 0xDC0F, 0x4C24, [0x83, 0xCA, 0x36, 0x30, 0x7B, 0x2C, 0xD1, 0x9F]};
@GUID(0x2017CB03, 0xDC0F, 0x4C24, [0x83, 0xCA, 0x36, 0x30, 0x7B, 0x2C, 0xD1, 0x9F]);
interface IESIsdbCasResponseEvent : IESEvent
{
    HRESULT GetRequestId(uint* pRequestId);
    HRESULT GetStatus(uint* pStatus);
    HRESULT GetDataLength(uint* pRequestLength);
    HRESULT GetResponseData(SAFEARRAY** pbData);
}

const GUID IID_IGpnvsCommonBase = {0x907E0B5C, 0xE42D, 0x4F04, [0x91, 0xF0, 0x26, 0xF4, 0x01, 0xF3, 0x69, 0x07]};
@GUID(0x907E0B5C, 0xE42D, 0x4F04, [0x91, 0xF0, 0x26, 0xF4, 0x01, 0xF3, 0x69, 0x07]);
interface IGpnvsCommonBase : IUnknown
{
    HRESULT GetValueUpdateName(BSTR* pbstrName);
}

const GUID IID_IESEventFactory = {0x506A09B8, 0x7F86, 0x4E04, [0xAC, 0x05, 0x33, 0x03, 0xBF, 0xE8, 0xFC, 0x49]};
@GUID(0x506A09B8, 0x7F86, 0x4E04, [0xAC, 0x05, 0x33, 0x03, 0xBF, 0xE8, 0xFC, 0x49]);
interface IESEventFactory : IUnknown
{
    HRESULT CreateESEvent(IUnknown pServiceProvider, uint dwEventId, Guid guidEventType, uint dwEventDataLength, char* pEventData, BSTR bstrBaseUrl, IUnknown pInitContext, IESEvent* ppESEvent);
}

const GUID IID_IESLicenseRenewalResultEvent = {0xD5A48EF5, 0xA81B, 0x4DF0, [0xAC, 0xAA, 0x5E, 0x35, 0xE7, 0xEA, 0x45, 0xD4]};
@GUID(0xD5A48EF5, 0xA81B, 0x4DF0, [0xAC, 0xAA, 0x5E, 0x35, 0xE7, 0xEA, 0x45, 0xD4]);
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

const GUID IID_IESFileExpiryDateEvent = {0xBA9EDCB6, 0x4D36, 0x4CFE, [0x8C, 0x56, 0x87, 0xA6, 0xB0, 0xCA, 0x48, 0xE1]};
@GUID(0xBA9EDCB6, 0x4D36, 0x4CFE, [0x8C, 0x56, 0x87, 0xA6, 0xB0, 0xCA, 0x48, 0xE1]);
interface IESFileExpiryDateEvent : IESEvent
{
    HRESULT GetTunerId(Guid* pguidTunerId);
    HRESULT GetExpiryDate(ulong* pqwExpiryDate);
    HRESULT GetFinalExpiryDate(ulong* pqwExpiryDate);
    HRESULT GetMaxRenewalCount(uint* dwMaxRenewalCount);
    HRESULT IsEntitlementTokenPresent(int* pfEntTokenPresent);
    HRESULT DoesExpireAfterFirstUse(int* pfExpireAfterFirstUse);
}

const GUID IID_IESEventService = {0xED89A619, 0x4C06, 0x4B2F, [0x99, 0xEB, 0xC7, 0x66, 0x9B, 0x13, 0x04, 0x7C]};
@GUID(0xED89A619, 0x4C06, 0x4B2F, [0x99, 0xEB, 0xC7, 0x66, 0x9B, 0x13, 0x04, 0x7C]);
interface IESEventService : IUnknown
{
    HRESULT FireESEvent(IESEvent pESEvent);
}

const GUID IID_IESEventServiceConfiguration = {0x33B9DAAE, 0x9309, 0x491D, [0xA0, 0x51, 0xBC, 0xAD, 0x2A, 0x70, 0xCD, 0x66]};
@GUID(0x33B9DAAE, 0x9309, 0x491D, [0xA0, 0x51, 0xBC, 0xAD, 0x2A, 0x70, 0xCD, 0x66]);
interface IESEventServiceConfiguration : IUnknown
{
    HRESULT SetParent(IESEventService pEventService);
    HRESULT RemoveParent();
    HRESULT SetOwner(IESEvents pESEvents);
    HRESULT RemoveOwner();
    HRESULT SetGraph(IFilterGraph pGraph);
    HRESULT RemoveGraph(IFilterGraph pGraph);
}

const GUID IID_IRegisterTuner = {0x359B3901, 0x572C, 0x4854, [0xBB, 0x49, 0xCD, 0xEF, 0x66, 0x60, 0x6A, 0x25]};
@GUID(0x359B3901, 0x572C, 0x4854, [0xBB, 0x49, 0xCD, 0xEF, 0x66, 0x60, 0x6A, 0x25]);
interface IRegisterTuner : IUnknown
{
    HRESULT Register(ITuner pTuner, IGraphBuilder pGraph);
    HRESULT Unregister();
}

const GUID IID_IBDAComparable = {0xB34505E0, 0x2F0E, 0x497B, [0x80, 0xBC, 0xD4, 0x3F, 0x3B, 0x24, 0xED, 0x7F]};
@GUID(0xB34505E0, 0x2F0E, 0x497B, [0x80, 0xBC, 0xD4, 0x3F, 0x3B, 0x24, 0xED, 0x7F]);
interface IBDAComparable : IUnknown
{
    HRESULT CompareExact(IDispatch CompareTo, int* Result);
    HRESULT CompareEquivalent(IDispatch CompareTo, uint dwFlags, int* Result);
    HRESULT HashExact(long* Result);
    HRESULT HashExactIncremental(long PartialResult, long* Result);
    HRESULT HashEquivalent(uint dwFlags, long* Result);
    HRESULT HashEquivalentIncremental(long PartialResult, uint dwFlags, long* Result);
}

const GUID IID_IPersistTuneXml = {0x0754CD31, 0x8D15, 0x47A9, [0x82, 0x15, 0xD2, 0x00, 0x64, 0x15, 0x72, 0x44]};
@GUID(0x0754CD31, 0x8D15, 0x47A9, [0x82, 0x15, 0xD2, 0x00, 0x64, 0x15, 0x72, 0x44]);
interface IPersistTuneXml : IPersist
{
    HRESULT InitNew();
    HRESULT Load(VARIANT varValue);
    HRESULT Save(VARIANT* pvarFragment);
}

const GUID IID_IPersistTuneXmlUtility = {0x990237AE, 0xAC11, 0x4614, [0xBE, 0x8F, 0xDD, 0x21, 0x7A, 0x4C, 0xB4, 0xCB]};
@GUID(0x990237AE, 0xAC11, 0x4614, [0xBE, 0x8F, 0xDD, 0x21, 0x7A, 0x4C, 0xB4, 0xCB]);
interface IPersistTuneXmlUtility : IUnknown
{
    HRESULT Deserialize(VARIANT varValue, IUnknown* ppObject);
}

const GUID IID_IPersistTuneXmlUtility2 = {0x992E165F, 0xEA24, 0x4B2F, [0x9A, 0x1D, 0x00, 0x9D, 0x92, 0x12, 0x04, 0x51]};
@GUID(0x992E165F, 0xEA24, 0x4B2F, [0x9A, 0x1D, 0x00, 0x9D, 0x92, 0x12, 0x04, 0x51]);
interface IPersistTuneXmlUtility2 : IPersistTuneXmlUtility
{
    HRESULT Serialize(ITuneRequest piTuneRequest, BSTR* pString);
}

const GUID IID_IBDACreateTuneRequestEx = {0xC0A4A1D4, 0x2B3C, 0x491A, [0xBA, 0x22, 0x49, 0x9F, 0xBA, 0xDD, 0x4D, 0x12]};
@GUID(0xC0A4A1D4, 0x2B3C, 0x491A, [0xBA, 0x22, 0x49, 0x9F, 0xBA, 0xDD, 0x4D, 0x12]);
interface IBDACreateTuneRequestEx : IUnknown
{
    HRESULT CreateTuneRequestEx(const(Guid)* TuneRequestIID, ITuneRequest* TuneRequest);
}

const GUID CLSID_XDSToRat = {0xC5C5C5F0, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]};
@GUID(0xC5C5C5F0, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]);
struct XDSToRat;

const GUID CLSID_EvalRat = {0xC5C5C5F1, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]};
@GUID(0xC5C5C5F1, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]);
struct EvalRat;

const GUID CLSID_ETFilter = {0xC4C4C4F1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4F1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
struct ETFilter;

const GUID CLSID_DTFilter = {0xC4C4C4F2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4F2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
struct DTFilter;

const GUID CLSID_XDSCodec = {0xC4C4C4F3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4F3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
struct XDSCodec;

const GUID CLSID_CXDSData = {0xC4C4C4F4, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4F4, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
struct CXDSData;

enum EnTvRat_System
{
    MPAA = 0,
    US_TV = 1,
    Canadian_English = 2,
    Canadian_French = 3,
    Reserved4 = 4,
    System5 = 5,
    System6 = 6,
    Reserved7 = 7,
    PBDA = 8,
    AgeBased = 9,
    TvRat_kSystems = 10,
    TvRat_SystemDontKnow = 255,
}

enum EnTvRat_GenericLevel
{
    TvRat_0 = 0,
    TvRat_1 = 1,
    TvRat_2 = 2,
    TvRat_3 = 3,
    TvRat_4 = 4,
    TvRat_5 = 5,
    TvRat_6 = 6,
    TvRat_7 = 7,
    TvRat_8 = 8,
    TvRat_9 = 9,
    TvRat_10 = 10,
    TvRat_11 = 11,
    TvRat_12 = 12,
    TvRat_13 = 13,
    TvRat_14 = 14,
    TvRat_15 = 15,
    TvRat_16 = 16,
    TvRat_17 = 17,
    TvRat_18 = 18,
    TvRat_19 = 19,
    TvRat_20 = 20,
    TvRat_21 = 21,
    TvRat_kLevels = 22,
    TvRat_Unblock = -1,
    TvRat_LevelDontKnow = 255,
}

enum EnTvRat_MPAA
{
    MPAA_NotApplicable = 0,
    MPAA_G = 1,
    MPAA_PG = 2,
    MPAA_PG13 = 3,
    MPAA_R = 4,
    MPAA_NC17 = 5,
    MPAA_X = 6,
    MPAA_NotRated = 7,
}

enum EnTvRat_US_TV
{
    US_TV_None = 0,
    US_TV_Y = 1,
    US_TV_Y7 = 2,
    US_TV_G = 3,
    US_TV_PG = 4,
    US_TV_14 = 5,
    US_TV_MA = 6,
    US_TV_None7 = 7,
}

enum EnTvRat_CAE_TV
{
    CAE_TV_Exempt = 0,
    CAE_TV_C = 1,
    CAE_TV_C8 = 2,
    CAE_TV_G = 3,
    CAE_TV_PG = 4,
    CAE_TV_14 = 5,
    CAE_TV_18 = 6,
    CAE_TV_Reserved = 7,
}

enum EnTvRat_CAF_TV
{
    CAF_TV_Exempt = 0,
    CAF_TV_G = 1,
    CAF_TV_8 = 2,
    CAF_TV_13 = 3,
    CAF_TV_16 = 4,
    CAF_TV_18 = 5,
    CAF_TV_Reserved6 = 6,
    CAF_TV_Reserved = 7,
}

enum BfEnTvRat_GenericAttributes
{
    BfAttrNone = 0,
    BfIsBlocked = 1,
    BfIsAttr_1 = 2,
    BfIsAttr_2 = 4,
    BfIsAttr_3 = 8,
    BfIsAttr_4 = 16,
    BfIsAttr_5 = 32,
    BfIsAttr_6 = 64,
    BfIsAttr_7 = 128,
    BfValidAttrSubmask = 255,
}

enum BfEnTvRat_Attributes_US_TV
{
    US_TV_IsBlocked = 1,
    US_TV_IsViolent = 2,
    US_TV_IsSexualSituation = 4,
    US_TV_IsAdultLanguage = 8,
    US_TV_IsSexuallySuggestiveDialog = 16,
    US_TV_ValidAttrSubmask = 31,
}

enum BfEnTvRat_Attributes_MPAA
{
    MPAA_IsBlocked = 1,
    MPAA_ValidAttrSubmask = 1,
}

enum BfEnTvRat_Attributes_CAE_TV
{
    CAE_IsBlocked = 1,
    CAE_ValidAttrSubmask = 1,
}

enum BfEnTvRat_Attributes_CAF_TV
{
    CAF_IsBlocked = 1,
    CAF_ValidAttrSubmask = 1,
}

enum FormatNotSupportedEvents
{
    FORMATNOTSUPPORTED_CLEAR = 0,
    FORMATNOTSUPPORTED_NOTSUPPORTED = 1,
}

struct __MIDL___MIDL_itf_encdec_0000_0000_0001
{
    ushort wszKID;
    ulong qwCounter;
    ulong qwIndex;
    ubyte bOffset;
}

struct __MIDL___MIDL_itf_encdec_0000_0000_0002
{
    HRESULT hrReason;
}

enum ProtType
{
    PROT_COPY_FREE = 1,
    PROT_COPY_ONCE = 2,
    PROT_COPY_NEVER = 3,
    PROT_COPY_NEVER_REALLY = 4,
    PROT_COPY_NO_MORE = 5,
    PROT_COPY_FREE_CIT = 6,
    PROT_COPY_BF = 7,
    PROT_COPY_CN_RECORDING_STOP = 8,
    PROT_COPY_FREE_SECURE = 9,
    PROT_COPY_INVALID = 50,
}

enum EncDecEvents
{
    ENCDEC_CPEVENT = 0,
    ENCDEC_RECORDING_STATUS = 1,
}

enum CPRecordingStatus
{
    RECORDING_STOPPED = 0,
    RECORDING_STARTED = 1,
}

enum CPEventBitShift
{
    CPEVENT_BITSHIFT_RATINGS = 0,
    CPEVENT_BITSHIFT_COPP = 1,
    CPEVENT_BITSHIFT_LICENSE = 2,
    CPEVENT_BITSHIFT_ROLLBACK = 3,
    CPEVENT_BITSHIFT_SAC = 4,
    CPEVENT_BITSHIFT_DOWNRES = 5,
    CPEVENT_BITSHIFT_STUBLIB = 6,
    CPEVENT_BITSHIFT_UNTRUSTEDGRAPH = 7,
    CPEVENT_BITSHIFT_PENDING_CERTIFICATE = 8,
    CPEVENT_BITSHIFT_NO_PLAYREADY = 9,
}

enum CPEvents
{
    CPEVENT_NONE = 0,
    CPEVENT_RATINGS = 1,
    CPEVENT_COPP = 2,
    CPEVENT_LICENSE = 3,
    CPEVENT_ROLLBACK = 4,
    CPEVENT_SAC = 5,
    CPEVENT_DOWNRES = 6,
    CPEVENT_STUBLIB = 7,
    CPEVENT_UNTRUSTEDGRAPH = 8,
    CPEVENT_PROTECTWINDOWED = 9,
}

enum RevokedComponent
{
    REVOKED_COPP = 0,
    REVOKED_SAC = 1,
    REVOKED_APP_STUB = 2,
    REVOKED_SECURE_PIPELINE = 3,
    REVOKED_MAX_TYPES = 4,
}

enum EnTag_Mode
{
    EnTag_Remove = 0,
    EnTag_Once = 1,
    EnTag_Repeat = 2,
}

enum COPPEventBlockReason
{
    COPP_Unknown = -1,
    COPP_BadDriver = 0,
    COPP_NoCardHDCPSupport = 1,
    COPP_NoMonitorHDCPSupport = 2,
    COPP_BadCertificate = 3,
    COPP_InvalidBusProtection = 4,
    COPP_AeroGlassOff = 5,
    COPP_RogueApp = 6,
    COPP_ForbiddenVideo = 7,
    COPP_Activate = 8,
    COPP_DigitalAudioUnprotected = 9,
}

enum LicenseEventBlockReason
{
    LIC_BadLicense = 0,
    LIC_NeedIndiv = 1,
    LIC_Expired = 2,
    LIC_NeedActivation = 3,
    LIC_ExtenderBlocked = 4,
}

enum DownResEventParam
{
    DOWNRES_Always = 0,
    DOWNRES_InWindowOnly = 1,
    DOWNRES_Undefined = 2,
}

const GUID IID_IETFilterConfig = {0xC4C4C4D1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4D1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IETFilterConfig : IUnknown
{
    HRESULT InitLicense(int LicenseId);
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
}

const GUID IID_IDTFilterConfig = {0xC4C4C4D2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4D2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IDTFilterConfig : IUnknown
{
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
}

const GUID IID_IXDSCodecConfig = {0xC4C4C4D3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4D3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IXDSCodecConfig : IUnknown
{
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
    HRESULT SetPauseBufferTime(uint dwPauseBufferTime);
}

const GUID IID_IDTFilterLicenseRenewal = {0x8A78B317, 0xE405, 0x4A43, [0x99, 0x4A, 0x62, 0x0D, 0x8F, 0x5C, 0xE2, 0x5E]};
@GUID(0x8A78B317, 0xE405, 0x4A43, [0x99, 0x4A, 0x62, 0x0D, 0x8F, 0x5C, 0xE2, 0x5E]);
interface IDTFilterLicenseRenewal : IUnknown
{
    HRESULT GetLicenseRenewalData(ushort** ppwszFileName, ushort** ppwszExpiredKid, ushort** ppwszTunerId);
}

const GUID IID_IPTFilterLicenseRenewal = {0x26D836A5, 0x0C15, 0x44C7, [0xAC, 0x59, 0xB0, 0xDA, 0x87, 0x28, 0xF2, 0x40]};
@GUID(0x26D836A5, 0x0C15, 0x44C7, [0xAC, 0x59, 0xB0, 0xDA, 0x87, 0x28, 0xF2, 0x40]);
interface IPTFilterLicenseRenewal : IUnknown
{
    HRESULT RenewLicenses(ushort* wszFileName, ushort* wszExpiredKid, uint dwCallersId, BOOL bHighPriority);
    HRESULT CancelLicenseRenewal();
}

const GUID IID_IMceBurnerControl = {0x5A86B91A, 0xE71E, 0x46C1, [0x88, 0xA9, 0x9B, 0xB3, 0x38, 0x71, 0x05, 0x52]};
@GUID(0x5A86B91A, 0xE71E, 0x46C1, [0x88, 0xA9, 0x9B, 0xB3, 0x38, 0x71, 0x05, 0x52]);
interface IMceBurnerControl : IUnknown
{
    HRESULT GetBurnerNoDecryption();
}

const GUID IID_IETFilter = {0xC4C4C4B1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4B1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IETFilter : IUnknown
{
    HRESULT get_EvalRatObjOK(int* pHrCoCreateRetVal);
    HRESULT GetCurrRating(EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnRating, int* plbfEnAttr);
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    HRESULT GetLastErrorCode();
    HRESULT SetRecordingOn(BOOL fRecState);
}

const GUID IID_IETFilterEvents = {0xC4C4C4C1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4C1, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IETFilterEvents : IDispatch
{
}

const GUID IID_IDTFilter = {0xC4C4C4B2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4B2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
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

const GUID IID_IDTFilter2 = {0xC4C4C4B4, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4B4, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IDTFilter2 : IDTFilter
{
    HRESULT get_ChallengeUrl(BSTR* pbstrChallengeUrl);
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    HRESULT GetLastErrorCode();
}

const GUID IID_IDTFilter3 = {0x513998CC, 0xE929, 0x4CDF, [0x9F, 0xBD, 0xBA, 0xD1, 0xE0, 0x31, 0x48, 0x66]};
@GUID(0x513998CC, 0xE929, 0x4CDF, [0x9F, 0xBD, 0xBA, 0xD1, 0xE0, 0x31, 0x48, 0x66]);
interface IDTFilter3 : IDTFilter2
{
    HRESULT GetProtectionType(ProtType* pProtectionType);
    HRESULT LicenseHasExpirationDate(int* pfLicenseHasExpirationDate);
    HRESULT SetRights(BSTR bstrRights);
}

const GUID IID_IDTFilterEvents = {0xC4C4C4C2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4C2, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IDTFilterEvents : IDispatch
{
}

const GUID IID_IXDSCodec = {0xC4C4C4B3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4B3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IXDSCodec : IUnknown
{
    HRESULT get_XDSToRatObjOK(int* pHrCoCreateRetVal);
    HRESULT put_CCSubstreamService(int SubstreamMask);
    HRESULT get_CCSubstreamService(int* pSubstreamMask);
    HRESULT GetContentAdvisoryRating(int* pRat, int* pPktSeqID, int* pCallSeqID, long* pTimeStart, long* pTimeEnd);
    HRESULT GetXDSPacket(int* pXDSClassPkt, int* pXDSTypePkt, BSTR* pBstrXDSPkt, int* pPktSeqID, int* pCallSeqID, long* pTimeStart, long* pTimeEnd);
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    HRESULT GetLastErrorCode();
}

const GUID IID_IXDSCodecEvents = {0xC4C4C4C3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]};
@GUID(0xC4C4C4C3, 0x0049, 0x4E2B, [0x98, 0xFB, 0x95, 0x37, 0xF6, 0xCE, 0x51, 0x6D]);
interface IXDSCodecEvents : IDispatch
{
}

const GUID IID_IXDSToRat = {0xC5C5C5B0, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]};
@GUID(0xC5C5C5B0, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]);
interface IXDSToRat : IDispatch
{
    HRESULT Init();
    HRESULT ParseXDSBytePair(ubyte byte1, ubyte byte2, EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnLevel, int* plBfEnAttributes);
}

const GUID IID_IEvalRat = {0xC5C5C5B1, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]};
@GUID(0xC5C5C5B1, 0x3ABC, 0x11D6, [0xB2, 0x5B, 0x00, 0xC0, 0x4F, 0xA0, 0xC0, 0x26]);
interface IEvalRat : IDispatch
{
    HRESULT get_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int* plbfAttrs);
    HRESULT put_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int lbfAttrs);
    HRESULT get_BlockUnRated(int* pfBlockUnRatedShows);
    HRESULT put_BlockUnRated(BOOL fBlockUnRatedShows);
    HRESULT MostRestrictiveRating(EnTvRat_System enSystem1, EnTvRat_GenericLevel enEnLevel1, int lbfEnAttr1, EnTvRat_System enSystem2, EnTvRat_GenericLevel enEnLevel2, int lbfEnAttr2, EnTvRat_System* penSystem, EnTvRat_GenericLevel* penEnLevel, int* plbfEnAttr);
    HRESULT TestRating(EnTvRat_System enShowSystem, EnTvRat_GenericLevel enShowLevel, int lbfEnShowAttributes);
}

enum SegDispidList
{
    dispidName = 0,
    dispidStatus = 1,
    dispidDevImageSourceWidth = 2,
    dispidDevImageSourceHeight = 3,
    dispidDevCountryCode = 4,
    dispidDevOverScan = 5,
    dispidSegment = 6,
    dispidDevVolume = 7,
    dispidDevBalance = 8,
    dispidDevPower = 9,
    dispidTuneChan = 10,
    dispidDevVideoSubchannel = 11,
    dispidDevAudioSubchannel = 12,
    dispidChannelAvailable = 13,
    dispidDevVideoFrequency = 14,
    dispidDevAudioFrequency = 15,
    dispidCount = 16,
    dispidDevFileName = 17,
    dispidVisible = 18,
    dispidOwner = 19,
    dispidMessageDrain = 20,
    dispidViewable = 21,
    dispidDevView = 22,
    dispidKSCat = 23,
    dispidCLSID = 24,
    dispid_KSCat = 25,
    dispid_CLSID = 26,
    dispidTune = 27,
    dispidTS = 28,
    dispidDevSAP = 29,
    dispidClip = 30,
    dispidRequestedClipRect = 31,
    dispidClippedSourceRect = 32,
    dispidAvailableSourceRect = 33,
    dispidMediaPosition = 34,
    dispidDevRun = 35,
    dispidDevPause = 36,
    dispidDevStop = 37,
    dispidCCEnable = 38,
    dispidDevStep = 39,
    dispidDevCanStep = 40,
    dispidSourceSize = 41,
    dispid_playtitle = 42,
    dispid_playchapterintitle = 43,
    dispid_playchapter = 44,
    dispid_playchaptersautostop = 45,
    dispid_playattime = 46,
    dispid_playattimeintitle = 47,
    dispid_playperiodintitleautostop = 48,
    dispid_replaychapter = 49,
    dispid_playprevchapter = 50,
    dispid_playnextchapter = 51,
    dispid_playforwards = 52,
    dispid_playbackwards = 53,
    dispid_stilloff = 54,
    dispid_audiolanguage = 55,
    dispid_showmenu = 56,
    dispid_resume = 57,
    dispid_returnfromsubmenu = 58,
    dispid_buttonsavailable = 59,
    dispid_currentbutton = 60,
    dispid_SelectAndActivateButton = 61,
    dispid_ActivateButton = 62,
    dispid_SelectRightButton = 63,
    dispid_SelectLeftButton = 64,
    dispid_SelectLowerButton = 65,
    dispid_SelectUpperButton = 66,
    dispid_ActivateAtPosition = 67,
    dispid_SelectAtPosition = 68,
    dispid_ButtonAtPosition = 69,
    dispid_NumberOfChapters = 70,
    dispid_TotalTitleTime = 71,
    dispid_TitlesAvailable = 72,
    dispid_VolumesAvailable = 73,
    dispid_CurrentVolume = 74,
    dispid_CurrentDiscSide = 75,
    dispid_CurrentDomain = 76,
    dispid_CurrentChapter = 77,
    dispid_CurrentTitle = 78,
    dispid_CurrentTime = 79,
    dispid_FramesPerSecond = 80,
    dispid_DVDTimeCode2bstr = 81,
    dispid_DVDDirectory = 82,
    dispid_IsSubpictureStreamEnabled = 83,
    dispid_IsAudioStreamEnabled = 84,
    dispid_CurrentSubpictureStream = 85,
    dispid_SubpictureLanguage = 86,
    dispid_CurrentAudioStream = 87,
    dispid_AudioStreamsAvailable = 88,
    dispid_AnglesAvailable = 89,
    dispid_CurrentAngle = 90,
    dispid_CCActive = 91,
    dispid_CurrentCCService = 92,
    dispid_SubpictureStreamsAvailable = 93,
    dispid_SubpictureOn = 94,
    dispid_DVDUniqueID = 95,
    dispid_EnableResetOnStop = 96,
    dispid_AcceptParentalLevelChange = 97,
    dispid_NotifyParentalLevelChange = 98,
    dispid_SelectParentalCountry = 99,
    dispid_SelectParentalLevel = 100,
    dispid_TitleParentalLevels = 101,
    dispid_PlayerParentalCountry = 102,
    dispid_PlayerParentalLevel = 103,
    dispid_Eject = 104,
    dispid_UOPValid = 105,
    dispid_SPRM = 106,
    dispid_GPRM = 107,
    dispid_DVDTextStringType = 108,
    dispid_DVDTextString = 109,
    dispid_DVDTextNumberOfStrings = 110,
    dispid_DVDTextNumberOfLanguages = 111,
    dispid_DVDTextLanguageLCID = 112,
    dispid_RegionChange = 113,
    dispid_DVDAdm = 114,
    dispid_DeleteBookmark = 115,
    dispid_RestoreBookmark = 116,
    dispid_SaveBookmark = 117,
    dispid_SelectDefaultAudioLanguage = 118,
    dispid_SelectDefaultSubpictureLanguage = 119,
    dispid_PreferredSubpictureStream = 120,
    dispid_DefaultMenuLanguage = 121,
    dispid_DefaultSubpictureLanguage = 122,
    dispid_DefaultAudioLanguage = 123,
    dispid_DefaultSubpictureLanguageExt = 124,
    dispid_DefaultAudioLanguageExt = 125,
    dispid_LanguageFromLCID = 126,
    dispid_KaraokeAudioPresentationMode = 127,
    dispid_KaraokeChannelContent = 128,
    dispid_KaraokeChannelAssignment = 129,
    dispid_RestorePreferredSettings = 130,
    dispid_ButtonRect = 131,
    dispid_DVDScreenInMouseCoordinates = 132,
    dispid_CustomCompositorClass = 133,
    dispidCustomCompositorClass = 134,
    dispid_CustomCompositor = 135,
    dispidMixerBitmap = 136,
    dispid_MixerBitmap = 137,
    dispidMixerBitmapOpacity = 138,
    dispidMixerBitmapRect = 139,
    dispidSetupMixerBitmap = 140,
    dispidUsingOverlay = 141,
    dispidDisplayChange = 142,
    dispidRePaint = 143,
    dispid_IsEqualDevice = 144,
    dispidrate = 145,
    dispidposition = 146,
    dispidpositionmode = 147,
    dispidlength = 148,
    dispidChangePassword = 149,
    dispidSaveParentalLevel = 150,
    dispidSaveParentalCountry = 151,
    dispidConfirmPassword = 152,
    dispidGetParentalLevel = 153,
    dispidGetParentalCountry = 154,
    dispidDefaultAudioLCID = 155,
    dispidDefaultSubpictureLCID = 156,
    dispidDefaultMenuLCID = 157,
    dispidBookmarkOnStop = 158,
    dispidMaxVidRect = 159,
    dispidMinVidRect = 160,
    dispidCapture = 161,
    dispid_DecimateInput = 162,
    dispidAlloctor = 163,
    dispid_Allocator = 164,
    dispidAllocPresentID = 165,
    dispidSetAllocator = 166,
    dispid_SetAllocator = 167,
    dispidStreamBufferSinkName = 168,
    dispidStreamBufferSourceName = 169,
    dispidStreamBufferContentRecording = 170,
    dispidStreamBufferReferenceRecording = 171,
    dispidstarttime = 172,
    dispidstoptime = 173,
    dispidrecordingstopped = 174,
    dispidrecordingstarted = 175,
    dispidNameSetLock = 176,
    dispidrecordingtype = 177,
    dispidstart = 178,
    dispidRecordingAttribute = 179,
    dispid_RecordingAttribute = 180,
    dispidSBEConfigure = 181,
    dispid_CurrentRatings = 182,
    dispid_MaxRatingsLevel = 183,
    dispid_audioencoderint = 184,
    dispid_videoencoderint = 185,
    dispidService = 186,
    dispid_BlockUnrated = 187,
    dispid_UnratedDelay = 188,
    dispid_SuppressEffects = 189,
    dispidsbesource = 190,
    dispidSetSinkFilter = 191,
    dispid_SinkStreams = 192,
    dispidTVFormats = 193,
    dispidModes = 194,
    dispidAuxInputs = 195,
    dispidTeleTextFilter = 196,
    dispid_channelchangeint = 197,
    dispidUnlockProfile = 198,
    dispid_AddFilter = 199,
    dispidSetMinSeek = 200,
    dispidRateEx = 201,
    dispidaudiocounter = 202,
    dispidvideocounter = 203,
    dispidcccounter = 204,
    dispidwstcounter = 205,
    dispid_audiocounter = 206,
    dispid_videocounter = 207,
    dispid_cccounter = 208,
    dispid_wstcounter = 209,
    dispidaudioanalysis = 210,
    dispidvideoanalysis = 211,
    dispiddataanalysis = 212,
    dispidaudio_analysis = 213,
    dispidvideo_analysis = 214,
    dispiddata_analysis = 215,
    dispid_resetFilterList = 216,
    dispidDevicePath = 217,
    dispid_SourceFilter = 218,
    dispid__SourceFilter = 219,
    dispidUserEvent = 220,
    dispid_Bookmark = 221,
    LastReservedDeviceDispid = 16383,
}

enum SegEventidList
{
    eventidStateChange = 0,
    eventidOnTuneChanged = 1,
    eventidEndOfMedia = 2,
    eventidDVDNotify = 3,
    eventidPlayForwards = 4,
    eventidPlayBackwards = 5,
    eventidShowMenu = 6,
    eventidResume = 7,
    eventidSelectOrActivateButton = 8,
    eventidStillOff = 9,
    eventidPauseOn = 10,
    eventidChangeCurrentAudioStream = 11,
    eventidChangeCurrentSubpictureStream = 12,
    eventidChangeCurrentAngle = 13,
    eventidPlayAtTimeInTitle = 14,
    eventidPlayAtTime = 15,
    eventidPlayChapterInTitle = 16,
    eventidPlayChapter = 17,
    eventidReplayChapter = 18,
    eventidPlayNextChapter = 19,
    eventidStop = 20,
    eventidReturnFromSubmenu = 21,
    eventidPlayTitle = 22,
    eventidPlayPrevChapter = 23,
    eventidChangeKaraokePresMode = 24,
    eventidChangeVideoPresMode = 25,
    eventidOverlayUnavailable = 26,
    eventidSinkCertificateFailure = 27,
    eventidSinkCertificateSuccess = 28,
    eventidSourceCertificateFailure = 29,
    eventidSourceCertificateSuccess = 30,
    eventidRatingsBlocked = 31,
    eventidRatingsUnlocked = 32,
    eventidRatingsChanged = 33,
    eventidWriteFailure = 34,
    eventidTimeHole = 35,
    eventidStaleDataRead = 36,
    eventidContentBecomingStale = 37,
    eventidStaleFileDeleted = 38,
    eventidEncryptionOn = 39,
    eventidEncryptionOff = 40,
    eventidRateChange = 41,
    eventidLicenseChange = 42,
    eventidCOPPBlocked = 43,
    eventidCOPPUnblocked = 44,
    dispidlicenseerrorcode = 45,
    eventidBroadcastEvent = 46,
    eventidBroadcastEventEx = 47,
    eventidContentPrimarilyAudio = 48,
    dispidAVDecAudioDualMonoEvent = 49,
    dispidAVAudioSampleRateEvent = 50,
    dispidAVAudioChannelConfigEvent = 51,
    dispidAVAudioChannelCountEvent = 52,
    dispidAVDecCommonMeanBitRateEvent = 53,
    dispidAVDDSurroundModeEvent = 54,
    dispidAVDecCommonInputFormatEvent = 55,
    dispidAVDecCommonOutputFormatEvent = 56,
    eventidWriteFailureClear = 57,
    LastReservedDeviceEvent = 16383,
}

enum PositionModeList
{
    FrameMode = 0,
    TenthsSecondsMode = 1,
}

enum RecordingType
{
    CONTENT = 0,
    REFERENCE = 1,
}

enum MSVidCCService
{
    None = 0,
    Caption1 = 1,
    Caption2 = 2,
    Text1 = 3,
    Text2 = 4,
    XDS = 5,
}

enum MSVidSinkStreams
{
    MSVidSink_Video = 1,
    MSVidSink_Audio = 2,
    MSVidSink_Other = 4,
}

const GUID IID_IMSVidRect = {0x7F5000A6, 0xA440, 0x47CA, [0x8A, 0xCC, 0xC0, 0xE7, 0x55, 0x31, 0xA2, 0xC2]};
@GUID(0x7F5000A6, 0xA440, 0x47CA, [0x8A, 0xCC, 0xC0, 0xE7, 0x55, 0x31, 0xA2, 0xC2]);
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

const GUID IID_IMSVidGraphSegmentContainer = {0x3DD2903D, 0xE0AA, 0x11D2, [0xB6, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x3DD2903D, 0xE0AA, 0x11D2, [0xB6, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
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

enum MSVidSegmentType
{
    MSVidSEG_SOURCE = 0,
    MSVidSEG_XFORM = 1,
    MSVidSEG_DEST = 2,
}

const GUID IID_IMSVidGraphSegment = {0x238DEC54, 0xADEB, 0x4005, [0xA3, 0x49, 0xF7, 0x72, 0xB9, 0xAF, 0xEB, 0xC4]};
@GUID(0x238DEC54, 0xADEB, 0x4005, [0xA3, 0x49, 0xF7, 0x72, 0xB9, 0xAF, 0xEB, 0xC4]);
interface IMSVidGraphSegment : IPersist
{
    HRESULT get_Init(IUnknown* pInit);
    HRESULT put_Init(IUnknown pInit);
    HRESULT EnumFilters(IEnumFilters* pNewEnum);
    HRESULT get_Container(IMSVidGraphSegmentContainer* ppCtl);
    HRESULT put_Container(IMSVidGraphSegmentContainer pCtl);
    HRESULT get_Type(MSVidSegmentType* pType);
    HRESULT get_Category(Guid* pGuid);
    HRESULT Build();
    HRESULT PostBuild();
    HRESULT PreRun();
    HRESULT PostRun();
    HRESULT PreStop();
    HRESULT PostStop();
    HRESULT OnEventNotify(int lEventCode, int lEventParm1, int lEventParm2);
    HRESULT Decompose();
}

enum MSVidCtlButtonstate
{
    MSVIDCTL_LEFT_BUTTON = 1,
    MSVIDCTL_RIGHT_BUTTON = 2,
    MSVIDCTL_MIDDLE_BUTTON = 4,
    MSVIDCTL_X_BUTTON1 = 8,
    MSVIDCTL_X_BUTTON2 = 16,
    MSVIDCTL_SHIFT = 1,
    MSVIDCTL_CTRL = 2,
    MSVIDCTL_ALT = 4,
}

const GUID IID_IMSVidGraphSegmentUserInput = {0x301C060E, 0x20D9, 0x4587, [0x9B, 0x03, 0xF8, 0x2E, 0xD9, 0xA9, 0x94, 0x3C]};
@GUID(0x301C060E, 0x20D9, 0x4587, [0x9B, 0x03, 0xF8, 0x2E, 0xD9, 0xA9, 0x94, 0x3C]);
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

const GUID IID_IMSVidCompositionSegment = {0x1C15D483, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D483, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidCompositionSegment : IMSVidGraphSegment
{
    HRESULT Compose(IMSVidGraphSegment upstream, IMSVidGraphSegment downstream);
    HRESULT get_Up(IMSVidGraphSegment* upstream);
    HRESULT get_Down(IMSVidGraphSegment* downstream);
}

const GUID IID_IEnumMSVidGraphSegment = {0x3DD2903E, 0xE0AA, 0x11D2, [0xB6, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x3DD2903E, 0xE0AA, 0x11D2, [0xB6, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IEnumMSVidGraphSegment : IUnknown
{
    HRESULT Next(uint celt, IMSVidGraphSegment* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumMSVidGraphSegment* ppenum);
}

const GUID IID_IMSVidVRGraphSegment = {0xDD47DE3F, 0x9874, 0x4F7B, [0x8B, 0x22, 0x7C, 0xB2, 0x68, 0x84, 0x61, 0xE7]};
@GUID(0xDD47DE3F, 0x9874, 0x4F7B, [0x8B, 0x22, 0x7C, 0xB2, 0x68, 0x84, 0x61, 0xE7]);
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

const GUID IID_IMSVidDevice = {0x1C15D47C, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D47C, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidDevice : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Status(int* Status);
    HRESULT put_Power(short Power);
    HRESULT get_Power(short* Power);
    HRESULT get_Category(BSTR* Guid);
    HRESULT get_ClassID(BSTR* Clsid);
    HRESULT get__Category(Guid* Guid);
    HRESULT get__ClassID(Guid* Clsid);
    HRESULT IsEqualDevice(IMSVidDevice Device, short* IsEqual);
}

const GUID IID_IMSVidDevice2 = {0x87BD2783, 0xEBC0, 0x478C, [0xB4, 0xA0, 0xE8, 0xE7, 0xF4, 0x3A, 0xB7, 0x8E]};
@GUID(0x87BD2783, 0xEBC0, 0x478C, [0xB4, 0xA0, 0xE8, 0xE7, 0xF4, 0x3A, 0xB7, 0x8E]);
interface IMSVidDevice2 : IUnknown
{
    HRESULT get_DevicePath(BSTR* DevPath);
}

const GUID IID_IMSVidInputDevice = {0x37B0353D, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B0353D, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidInputDevice : IMSVidDevice
{
    HRESULT IsViewable(VARIANT* v, short* pfViewable);
    HRESULT View(VARIANT* v);
}

const GUID IID_IMSVidDeviceEvent = {0x1C15D480, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D480, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidDeviceEvent : IDispatch
{
    HRESULT StateChange(IMSVidDevice lpd, int oldState, int newState);
}

const GUID IID_IMSVidInputDeviceEvent = {0x37B0353E, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B0353E, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidInputDeviceEvent : IDispatch
{
}

const GUID IID_IMSVidVideoInputDevice = {0x1C15D47F, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D47F, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidVideoInputDevice : IMSVidInputDevice
{
}

const GUID IID_IMSVidPlayback = {0x37B03538, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03538, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
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

const GUID IID_IMSVidPlaybackEvent = {0x37B0353B, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B0353B, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidPlaybackEvent : IMSVidInputDeviceEvent
{
    HRESULT EndOfMedia(IMSVidPlayback lpd);
}

const GUID IID_IMSVidTuner = {0x1C15D47D, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D47D, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidTuner : IMSVidVideoInputDevice
{
    HRESULT get_Tune(ITuneRequest* ppTR);
    HRESULT put_Tune(ITuneRequest pTR);
    HRESULT get_TuningSpace(ITuningSpace* plTS);
    HRESULT put_TuningSpace(ITuningSpace plTS);
}

const GUID IID_IMSVidTunerEvent = {0x1C15D485, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D485, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidTunerEvent : IMSVidInputDeviceEvent
{
    HRESULT TuneChanged(IMSVidTuner lpd);
}

const GUID IID_IMSVidAnalogTuner = {0x1C15D47E, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D47E, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
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

const GUID IID_IMSVidAnalogTuner2 = {0x37647BF7, 0x3DDE, 0x4CC8, [0xA4, 0xDC, 0x0D, 0x53, 0x4D, 0x3D, 0x00, 0x37]};
@GUID(0x37647BF7, 0x3DDE, 0x4CC8, [0xA4, 0xDC, 0x0D, 0x53, 0x4D, 0x3D, 0x00, 0x37]);
interface IMSVidAnalogTuner2 : IMSVidAnalogTuner
{
    HRESULT get_TVFormats(int* Formats);
    HRESULT get_TunerModes(int* Modes);
    HRESULT get_NumAuxInputs(int* Inputs);
}

const GUID IID_IMSVidAnalogTunerEvent = {0x1C15D486, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D486, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidAnalogTunerEvent : IMSVidTunerEvent
{
}

const GUID IID_IMSVidFilePlayback = {0x37B03539, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03539, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidFilePlayback : IMSVidPlayback
{
    HRESULT get_FileName(BSTR* FileName);
    HRESULT put_FileName(BSTR FileName);
}

const GUID IID_IMSVidFilePlayback2 = {0x2F7E44AF, 0x6E52, 0x4660, [0xBC, 0x08, 0xD8, 0xD5, 0x42, 0x58, 0x7D, 0x72]};
@GUID(0x2F7E44AF, 0x6E52, 0x4660, [0xBC, 0x08, 0xD8, 0xD5, 0x42, 0x58, 0x7D, 0x72]);
interface IMSVidFilePlayback2 : IMSVidFilePlayback
{
    HRESULT put__SourceFilter(BSTR FileName);
    HRESULT put___SourceFilter(Guid FileName);
}

const GUID IID_IMSVidFilePlaybackEvent = {0x37B0353A, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B0353A, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidFilePlaybackEvent : IMSVidPlaybackEvent
{
}

enum DVDMenuIDConstants
{
    dvdMenu_Title = 2,
    dvdMenu_Root = 3,
    dvdMenu_Subpicture = 4,
    dvdMenu_Audio = 5,
    dvdMenu_Angle = 6,
    dvdMenu_Chapter = 7,
}

enum DVDFilterState
{
    dvdState_Undefined = -2,
    dvdState_Unitialized = -1,
    dvdState_Stopped = 0,
    dvdState_Paused = 1,
    dvdState_Running = 2,
}

enum DVDTextStringType
{
    dvdStruct_Volume = 1,
    dvdStruct_Title = 2,
    dvdStruct_ParentalID = 3,
    dvdStruct_PartOfTitle = 4,
    dvdStruct_Cell = 5,
    dvdStream_Audio = 16,
    dvdStream_Subpicture = 17,
    dvdStream_Angle = 18,
    dvdChannel_Audio = 32,
    dvdGeneral_Name = 48,
    dvdGeneral_Comments = 49,
    dvdTitle_Series = 56,
    dvdTitle_Movie = 57,
    dvdTitle_Video = 58,
    dvdTitle_Album = 59,
    dvdTitle_Song = 60,
    dvdTitle_Other = 63,
    dvdTitle_Sub_Series = 64,
    dvdTitle_Sub_Movie = 65,
    dvdTitle_Sub_Video = 66,
    dvdTitle_Sub_Album = 67,
    dvdTitle_Sub_Song = 68,
    dvdTitle_Sub_Other = 71,
    dvdTitle_Orig_Series = 72,
    dvdTitle_Orig_Movie = 73,
    dvdTitle_Orig_Video = 74,
    dvdTitle_Orig_Album = 75,
    dvdTitle_Orig_Song = 76,
    dvdTitle_Orig_Other = 79,
    dvdOther_Scene = 80,
    dvdOther_Cut = 81,
    dvdOther_Take = 82,
}

enum DVDSPExt
{
    dvdSPExt_NotSpecified = 0,
    dvdSPExt_Caption_Normal = 1,
    dvdSPExt_Caption_Big = 2,
    dvdSPExt_Caption_Children = 3,
    dvdSPExt_CC_Normal = 5,
    dvdSPExt_CC_Big = 6,
    dvdSPExt_CC_Children = 7,
    dvdSPExt_Forced = 9,
    dvdSPExt_DirectorComments_Normal = 13,
    dvdSPExt_DirectorComments_Big = 14,
    dvdSPExt_DirectorComments_Children = 15,
}

const GUID IID_IMSVidWebDVD = {0xCF45F88B, 0xAC56, 0x4EE2, [0xA7, 0x3A, 0xED, 0x04, 0xE2, 0x88, 0x5D, 0x3C]};
@GUID(0xCF45F88B, 0xAC56, 0x4EE2, [0xA7, 0x3A, 0xED, 0x04, 0xE2, 0x88, 0x5D, 0x3C]);
interface IMSVidWebDVD : IMSVidPlayback
{
    HRESULT OnDVDEvent(int lEvent, int lParam1, int lParam2);
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

const GUID IID_IMSVidWebDVD2 = {0x7027212F, 0xEE9A, 0x4A7C, [0x8B, 0x67, 0xF0, 0x23, 0x71, 0x4C, 0xDA, 0xFF]};
@GUID(0x7027212F, 0xEE9A, 0x4A7C, [0x8B, 0x67, 0xF0, 0x23, 0x71, 0x4C, 0xDA, 0xFF]);
interface IMSVidWebDVD2 : IMSVidWebDVD
{
    HRESULT get_Bookmark(char* ppData, uint* pDataLength);
    HRESULT put_Bookmark(ubyte* pData, uint dwDataLength);
}

const GUID IID_IMSVidWebDVDEvent = {0xB4F7A674, 0x9B83, 0x49CB, [0xA3, 0x57, 0xC6, 0x3B, 0x87, 0x1B, 0xE9, 0x58]};
@GUID(0xB4F7A674, 0x9B83, 0x49CB, [0xA3, 0x57, 0xC6, 0x3B, 0x87, 0x1B, 0xE9, 0x58]);
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

const GUID IID_IMSVidWebDVDAdm = {0xB8BE681A, 0xEB2C, 0x47F0, [0xB4, 0x15, 0x94, 0xD5, 0x45, 0x2F, 0x0E, 0x05]};
@GUID(0xB8BE681A, 0xEB2C, 0x47F0, [0xB4, 0x15, 0x94, 0xD5, 0x45, 0x2F, 0x0E, 0x05]);
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

const GUID IID_IMSVidOutputDevice = {0x37B03546, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03546, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidOutputDevice : IMSVidDevice
{
}

const GUID IID_IMSVidOutputDeviceEvent = {0x2E6A14E2, 0x571C, 0x11D3, [0xB6, 0x52, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x2E6A14E2, 0x571C, 0x11D3, [0xB6, 0x52, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidOutputDeviceEvent : IMSVidDeviceEvent
{
}

const GUID IID_IMSVidFeature = {0x37B03547, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03547, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidFeature : IMSVidDevice
{
}

const GUID IID_IMSVidFeatureEvent = {0x3DD2903C, 0xE0AA, 0x11D2, [0xB6, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x3DD2903C, 0xE0AA, 0x11D2, [0xB6, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidFeatureEvent : IMSVidDeviceEvent
{
}

const GUID IID_IMSVidEncoder = {0xC0020FD4, 0xBEE7, 0x43D9, [0xA4, 0x95, 0x9F, 0x21, 0x31, 0x17, 0x10, 0x3D]};
@GUID(0xC0020FD4, 0xBEE7, 0x43D9, [0xA4, 0x95, 0x9F, 0x21, 0x31, 0x17, 0x10, 0x3D]);
interface IMSVidEncoder : IMSVidFeature
{
    HRESULT get_VideoEncoderInterface(IUnknown* ppEncInt);
    HRESULT get_AudioEncoderInterface(IUnknown* ppEncInt);
}

const GUID IID_IMSVidClosedCaptioning = {0x99652EA1, 0xC1F7, 0x414F, [0xBB, 0x7B, 0x1C, 0x96, 0x7D, 0xE7, 0x59, 0x83]};
@GUID(0x99652EA1, 0xC1F7, 0x414F, [0xBB, 0x7B, 0x1C, 0x96, 0x7D, 0xE7, 0x59, 0x83]);
interface IMSVidClosedCaptioning : IMSVidFeature
{
    HRESULT get_Enable(short* On);
    HRESULT put_Enable(short On);
}

const GUID IID_IMSVidClosedCaptioning2 = {0xE00CB864, 0xA029, 0x4310, [0x99, 0x87, 0xA8, 0x73, 0xF5, 0x88, 0x7D, 0x97]};
@GUID(0xE00CB864, 0xA029, 0x4310, [0x99, 0x87, 0xA8, 0x73, 0xF5, 0x88, 0x7D, 0x97]);
interface IMSVidClosedCaptioning2 : IMSVidClosedCaptioning
{
    HRESULT get_Service(MSVidCCService* On);
    HRESULT put_Service(MSVidCCService On);
}

const GUID IID_IMSVidClosedCaptioning3 = {0xC8638E8A, 0x7625, 0x4C51, [0x93, 0x66, 0x2F, 0x40, 0xA9, 0x83, 0x1F, 0xC0]};
@GUID(0xC8638E8A, 0x7625, 0x4C51, [0x93, 0x66, 0x2F, 0x40, 0xA9, 0x83, 0x1F, 0xC0]);
interface IMSVidClosedCaptioning3 : IMSVidClosedCaptioning2
{
    HRESULT get_TeleTextFilter(IUnknown* punkTTFilter);
}

const GUID IID_IMSVidXDS = {0x11EBC158, 0xE712, 0x4D1F, [0x8B, 0xB3, 0x01, 0xED, 0x52, 0x74, 0xC4, 0xCE]};
@GUID(0x11EBC158, 0xE712, 0x4D1F, [0x8B, 0xB3, 0x01, 0xED, 0x52, 0x74, 0xC4, 0xCE]);
interface IMSVidXDS : IMSVidFeature
{
    HRESULT get_ChannelChangeInterface(IUnknown* punkCC);
}

const GUID IID_IMSVidXDSEvent = {0x6DB2317D, 0x3B23, 0x41EC, [0xBA, 0x4B, 0x70, 0x1F, 0x40, 0x7E, 0xAF, 0x3A]};
@GUID(0x6DB2317D, 0x3B23, 0x41EC, [0xBA, 0x4B, 0x70, 0x1F, 0x40, 0x7E, 0xAF, 0x3A]);
interface IMSVidXDSEvent : IMSVidFeatureEvent
{
    HRESULT RatingChange(EnTvRat_System PrevRatingSystem, EnTvRat_GenericLevel PrevLevel, BfEnTvRat_GenericAttributes PrevAttributes, EnTvRat_System NewRatingSystem, EnTvRat_GenericLevel NewLevel, BfEnTvRat_GenericAttributes NewAttributes);
}

const GUID IID_IMSVidDataServices = {0x334125C1, 0x77E5, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x334125C1, 0x77E5, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidDataServices : IMSVidFeature
{
}

const GUID IID_IMSVidDataServicesEvent = {0x334125C2, 0x77E5, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x334125C2, 0x77E5, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidDataServicesEvent : IMSVidDeviceEvent
{
}

enum SourceSizeList
{
    sslFullSize = 0,
    sslClipByOverScan = 1,
    sslClipByClipRect = 2,
}

const GUID IID_IMSVidVideoRenderer = {0x37B03540, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03540, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidVideoRenderer : IMSVidOutputDevice
{
    HRESULT get_CustomCompositorClass(BSTR* CompositorCLSID);
    HRESULT put_CustomCompositorClass(BSTR CompositorCLSID);
    HRESULT get__CustomCompositorClass(Guid* CompositorCLSID);
    HRESULT put__CustomCompositorClass(const(Guid)* CompositorCLSID);
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

const GUID IID_IMSVidVideoRendererEvent = {0x37B03545, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03545, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidVideoRendererEvent : IMSVidOutputDeviceEvent
{
    HRESULT OverlayUnavailable();
}

const GUID IID_IMSVidGenericSink = {0x6C29B41D, 0x455B, 0x4C33, [0x96, 0x3A, 0x0D, 0x28, 0xE5, 0xE5, 0x55, 0xEA]};
@GUID(0x6C29B41D, 0x455B, 0x4C33, [0x96, 0x3A, 0x0D, 0x28, 0xE5, 0xE5, 0x55, 0xEA]);
interface IMSVidGenericSink : IMSVidOutputDevice
{
    HRESULT SetSinkFilter(BSTR bstrName);
    HRESULT get_SinkStreams(MSVidSinkStreams* pStreams);
    HRESULT put_SinkStreams(MSVidSinkStreams Streams);
}

const GUID IID_IMSVidGenericSink2 = {0x6B5A28F3, 0x47F1, 0x4092, [0xB1, 0x68, 0x60, 0xCA, 0xBE, 0xC0, 0x8F, 0x1C]};
@GUID(0x6B5A28F3, 0x47F1, 0x4092, [0xB1, 0x68, 0x60, 0xCA, 0xBE, 0xC0, 0x8F, 0x1C]);
interface IMSVidGenericSink2 : IMSVidGenericSink
{
    HRESULT AddFilter(BSTR bstrName);
    HRESULT ResetFilterList();
}

const GUID IID_IMSVidStreamBufferRecordingControl = {0x160621AA, 0xBBBC, 0x4326, [0xA8, 0x24, 0xC3, 0x95, 0xAE, 0xBC, 0x6E, 0x74]};
@GUID(0x160621AA, 0xBBBC, 0x4326, [0xA8, 0x24, 0xC3, 0x95, 0xAE, 0xBC, 0x6E, 0x74]);
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

const GUID IID_IMSVidStreamBufferSink = {0x159DBB45, 0xCD1B, 0x4DAB, [0x83, 0xEA, 0x5C, 0xB1, 0xF4, 0xF2, 0x1D, 0x07]};
@GUID(0x159DBB45, 0xCD1B, 0x4DAB, [0x83, 0xEA, 0x5C, 0xB1, 0xF4, 0xF2, 0x1D, 0x07]);
interface IMSVidStreamBufferSink : IMSVidOutputDevice
{
    HRESULT get_ContentRecorder(BSTR pszFilename, IMSVidStreamBufferRecordingControl* pRecordingIUnknown);
    HRESULT get_ReferenceRecorder(BSTR pszFilename, IMSVidStreamBufferRecordingControl* pRecordingIUnknown);
    HRESULT get_SinkName(BSTR* pName);
    HRESULT put_SinkName(BSTR Name);
    HRESULT NameSetLock();
    HRESULT get_SBESink(IUnknown* sbeConfig);
}

const GUID IID_IMSVidStreamBufferSink2 = {0x2CA9FC63, 0xC131, 0x4E5A, [0x95, 0x5A, 0x54, 0x4A, 0x47, 0xC6, 0x71, 0x46]};
@GUID(0x2CA9FC63, 0xC131, 0x4E5A, [0x95, 0x5A, 0x54, 0x4A, 0x47, 0xC6, 0x71, 0x46]);
interface IMSVidStreamBufferSink2 : IMSVidStreamBufferSink
{
    HRESULT UnlockProfile();
}

const GUID IID_IMSVidStreamBufferSink3 = {0x4F8721D7, 0x7D59, 0x4D8B, [0x99, 0xF5, 0xA7, 0x77, 0x75, 0x58, 0x6B, 0xD5]};
@GUID(0x4F8721D7, 0x7D59, 0x4D8B, [0x99, 0xF5, 0xA7, 0x77, 0x75, 0x58, 0x6B, 0xD5]);
interface IMSVidStreamBufferSink3 : IMSVidStreamBufferSink2
{
    HRESULT SetMinSeek(int* pdwMin);
    HRESULT get_AudioCounter(IUnknown* ppUnk);
    HRESULT get_VideoCounter(IUnknown* ppUnk);
    HRESULT get_CCCounter(IUnknown* ppUnk);
    HRESULT get_WSTCounter(IUnknown* ppUnk);
    HRESULT put_AudioAnalysisFilter(BSTR szCLSID);
    HRESULT get_AudioAnalysisFilter(BSTR* pszCLSID);
    HRESULT put__AudioAnalysisFilter(Guid guid);
    HRESULT get__AudioAnalysisFilter(Guid* pGuid);
    HRESULT put_VideoAnalysisFilter(BSTR szCLSID);
    HRESULT get_VideoAnalysisFilter(BSTR* pszCLSID);
    HRESULT put__VideoAnalysisFilter(Guid guid);
    HRESULT get__VideoAnalysisFilter(Guid* pGuid);
    HRESULT put_DataAnalysisFilter(BSTR szCLSID);
    HRESULT get_DataAnalysisFilter(BSTR* pszCLSID);
    HRESULT put__DataAnalysisFilter(Guid guid);
    HRESULT get__DataAnalysisFilter(Guid* pGuid);
    HRESULT get_LicenseErrorCode(int* hres);
}

const GUID IID_IMSVidStreamBufferSinkEvent = {0xF798A36B, 0xB05B, 0x4BBE, [0x97, 0x03, 0xEA, 0xEA, 0x7D, 0x61, 0xCD, 0x51]};
@GUID(0xF798A36B, 0xB05B, 0x4BBE, [0x97, 0x03, 0xEA, 0xEA, 0x7D, 0x61, 0xCD, 0x51]);
interface IMSVidStreamBufferSinkEvent : IMSVidOutputDeviceEvent
{
    HRESULT CertificateFailure();
    HRESULT CertificateSuccess();
    HRESULT WriteFailure();
}

const GUID IID_IMSVidStreamBufferSinkEvent2 = {0x3D7A5166, 0x72D7, 0x484B, [0xA0, 0x6F, 0x28, 0x61, 0x87, 0xB8, 0x0C, 0xA1]};
@GUID(0x3D7A5166, 0x72D7, 0x484B, [0xA0, 0x6F, 0x28, 0x61, 0x87, 0xB8, 0x0C, 0xA1]);
interface IMSVidStreamBufferSinkEvent2 : IMSVidStreamBufferSinkEvent
{
    HRESULT EncryptionOn();
    HRESULT EncryptionOff();
}

const GUID IID_IMSVidStreamBufferSinkEvent3 = {0x735AD8D5, 0xC259, 0x48E9, [0x81, 0xE7, 0xD2, 0x79, 0x53, 0x66, 0x5B, 0x23]};
@GUID(0x735AD8D5, 0xC259, 0x48E9, [0x81, 0xE7, 0xD2, 0x79, 0x53, 0x66, 0x5B, 0x23]);
interface IMSVidStreamBufferSinkEvent3 : IMSVidStreamBufferSinkEvent2
{
    HRESULT LicenseChange(int dwProt);
}

const GUID IID_IMSVidStreamBufferSinkEvent4 = {0x1B01DCB0, 0xDAF0, 0x412C, [0xA5, 0xD1, 0x59, 0x0C, 0x7F, 0x62, 0xE2, 0xB8]};
@GUID(0x1B01DCB0, 0xDAF0, 0x412C, [0xA5, 0xD1, 0x59, 0x0C, 0x7F, 0x62, 0xE2, 0xB8]);
interface IMSVidStreamBufferSinkEvent4 : IMSVidStreamBufferSinkEvent3
{
    HRESULT WriteFailureClear();
}

const GUID IID_IMSVidStreamBufferSource = {0xEB0C8CF9, 0x6950, 0x4772, [0x87, 0xB1, 0x47, 0xD1, 0x1C, 0xF3, 0xA0, 0x2F]};
@GUID(0xEB0C8CF9, 0x6950, 0x4772, [0x87, 0xB1, 0x47, 0xD1, 0x1C, 0xF3, 0xA0, 0x2F]);
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

const GUID IID_IMSVidStreamBufferSource2 = {0xE4BA9059, 0xB1CE, 0x40D8, [0xB9, 0xA0, 0xD4, 0xEA, 0x4A, 0x99, 0x89, 0xD3]};
@GUID(0xE4BA9059, 0xB1CE, 0x40D8, [0xB9, 0xA0, 0xD4, 0xEA, 0x4A, 0x99, 0x89, 0xD3]);
interface IMSVidStreamBufferSource2 : IMSVidStreamBufferSource
{
    HRESULT put_RateEx(double dwRate, uint dwFramesPerSecond);
    HRESULT get_AudioCounter(IUnknown* ppUnk);
    HRESULT get_VideoCounter(IUnknown* ppUnk);
    HRESULT get_CCCounter(IUnknown* ppUnk);
    HRESULT get_WSTCounter(IUnknown* ppUnk);
}

const GUID IID_IMSVidStreamBufferSourceEvent = {0x50CE8A7D, 0x9C28, 0x4DA8, [0x90, 0x42, 0xCD, 0xFA, 0x71, 0x16, 0xF9, 0x79]};
@GUID(0x50CE8A7D, 0x9C28, 0x4DA8, [0x90, 0x42, 0xCD, 0xFA, 0x71, 0x16, 0xF9, 0x79]);
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

const GUID IID_IMSVidStreamBufferSourceEvent2 = {0x7AEF50CE, 0x8E22, 0x4BA8, [0xBC, 0x06, 0xA9, 0x2A, 0x45, 0x8B, 0x4E, 0xF2]};
@GUID(0x7AEF50CE, 0x8E22, 0x4BA8, [0xBC, 0x06, 0xA9, 0x2A, 0x45, 0x8B, 0x4E, 0xF2]);
interface IMSVidStreamBufferSourceEvent2 : IMSVidStreamBufferSourceEvent
{
    HRESULT RateChange(double qwNewRate, double qwOldRate);
}

const GUID IID_IMSVidStreamBufferSourceEvent3 = {0xCEABD6AB, 0x9B90, 0x4570, [0xAD, 0xF1, 0x3C, 0xE7, 0x6E, 0x00, 0xA7, 0x63]};
@GUID(0xCEABD6AB, 0x9B90, 0x4570, [0xAD, 0xF1, 0x3C, 0xE7, 0x6E, 0x00, 0xA7, 0x63]);
interface IMSVidStreamBufferSourceEvent3 : IMSVidStreamBufferSourceEvent2
{
    HRESULT BroadcastEvent(BSTR Guid);
    HRESULT BroadcastEventEx(BSTR Guid, uint Param1, uint Param2, uint Param3, uint Param4);
    HRESULT COPPBlocked();
    HRESULT COPPUnblocked();
    HRESULT ContentPrimarilyAudio();
}

const GUID IID_IMSVidStreamBufferV2SourceEvent = {0x49C771F9, 0x41B2, 0x4CF7, [0x9F, 0x9A, 0xA3, 0x13, 0xA8, 0xF6, 0x02, 0x7E]};
@GUID(0x49C771F9, 0x41B2, 0x4CF7, [0x9F, 0x9A, 0xA3, 0x13, 0xA8, 0xF6, 0x02, 0x7E]);
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

const GUID IID_IMSVidVideoRenderer2 = {0x6BDD5C1E, 0x2810, 0x4159, [0x94, 0xBC, 0x05, 0x51, 0x1A, 0xE8, 0x54, 0x9B]};
@GUID(0x6BDD5C1E, 0x2810, 0x4159, [0x94, 0xBC, 0x05, 0x51, 0x1A, 0xE8, 0x54, 0x9B]);
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

const GUID IID_IMSVidVideoRendererEvent2 = {0x7145ED66, 0x4730, 0x4FDB, [0x8A, 0x53, 0xFD, 0xE7, 0x50, 0x8D, 0x3E, 0x5E]};
@GUID(0x7145ED66, 0x4730, 0x4FDB, [0x8A, 0x53, 0xFD, 0xE7, 0x50, 0x8D, 0x3E, 0x5E]);
interface IMSVidVideoRendererEvent2 : IMSVidOutputDeviceEvent
{
    HRESULT OverlayUnavailable();
}

const GUID IID_IMSVidVMR9 = {0xD58B0015, 0xEBEF, 0x44BB, [0xBB, 0xDD, 0x3F, 0x36, 0x99, 0xD7, 0x6E, 0xA1]};
@GUID(0xD58B0015, 0xEBEF, 0x44BB, [0xBB, 0xDD, 0x3F, 0x36, 0x99, 0xD7, 0x6E, 0xA1]);
interface IMSVidVMR9 : IMSVidVideoRenderer
{
    HRESULT get_Allocator_ID(int* ID);
    HRESULT SetAllocator(IUnknown AllocPresent, int ID);
    HRESULT put_SuppressEffects(short bSuppress);
    HRESULT get_SuppressEffects(short* bSuppress);
    HRESULT get_Allocator(IUnknown* AllocPresent);
}

const GUID IID_IMSVidEVR = {0x15E496AE, 0x82A8, 0x4CF9, [0xA6, 0xB6, 0xC5, 0x61, 0xDC, 0x60, 0x39, 0x8F]};
@GUID(0x15E496AE, 0x82A8, 0x4CF9, [0xA6, 0xB6, 0xC5, 0x61, 0xDC, 0x60, 0x39, 0x8F]);
interface IMSVidEVR : IMSVidVideoRenderer
{
    HRESULT get_Presenter(IMFVideoPresenter* ppAllocPresent);
    HRESULT put_Presenter(IMFVideoPresenter pAllocPresent);
    HRESULT put_SuppressEffects(short bSuppress);
    HRESULT get_SuppressEffects(short* bSuppress);
}

const GUID IID_IMSVidEVREvent = {0x349ABB10, 0x883C, 0x4F22, [0x87, 0x14, 0xCE, 0xCA, 0xEE, 0xE4, 0x5D, 0x62]};
@GUID(0x349ABB10, 0x883C, 0x4F22, [0x87, 0x14, 0xCE, 0xCA, 0xEE, 0xE4, 0x5D, 0x62]);
interface IMSVidEVREvent : IMSVidOutputDeviceEvent
{
    HRESULT OnUserEvent(int lEventCode);
}

const GUID IID_IMSVidAudioRenderer = {0x37B0353F, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B0353F, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidAudioRenderer : IMSVidOutputDevice
{
    HRESULT put_Volume(int lVol);
    HRESULT get_Volume(int* lVol);
    HRESULT put_Balance(int lBal);
    HRESULT get_Balance(int* lBal);
}

const GUID IID_IMSVidAudioRendererEvent = {0x37B03541, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03541, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidAudioRendererEvent : IMSVidOutputDeviceEvent
{
}

const GUID IID_IMSVidAudioRendererEvent2 = {0xE3F55729, 0x353B, 0x4C43, [0xA0, 0x28, 0x50, 0xF7, 0x9A, 0xA9, 0xA9, 0x07]};
@GUID(0xE3F55729, 0x353B, 0x4C43, [0xA0, 0x28, 0x50, 0xF7, 0x9A, 0xA9, 0xA9, 0x07]);
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

const GUID IID_IMSVidInputDevices = {0xC5702CD1, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CD1, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidInputDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidInputDevice* pDB);
    HRESULT Add(IMSVidInputDevice pDB);
    HRESULT Remove(VARIANT v);
}

const GUID IID_IMSVidOutputDevices = {0xC5702CD2, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CD2, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidOutputDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidOutputDevice* pDB);
    HRESULT Add(IMSVidOutputDevice pDB);
    HRESULT Remove(VARIANT v);
}

const GUID IID_IMSVidVideoRendererDevices = {0xC5702CD3, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CD3, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidVideoRendererDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidVideoRenderer* pDB);
    HRESULT Add(IMSVidVideoRenderer pDB);
    HRESULT Remove(VARIANT v);
}

const GUID IID_IMSVidAudioRendererDevices = {0xC5702CD4, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CD4, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidAudioRendererDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidAudioRenderer* pDB);
    HRESULT Add(IMSVidAudioRenderer pDB);
    HRESULT Remove(VARIANT v);
}

const GUID IID_IMSVidFeatures = {0xC5702CD5, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CD5, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface IMSVidFeatures : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidFeature* pDB);
    HRESULT Add(IMSVidFeature pDB);
    HRESULT Remove(VARIANT v);
}

const GUID CLSID_MSVidAnalogTunerDevice = {0x1C15D484, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x1C15D484, 0x911D, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidAnalogTunerDevice;

const GUID CLSID_MSVidBDATunerDevice = {0xA2E3074E, 0x6C3D, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xA2E3074E, 0x6C3D, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidBDATunerDevice;

const GUID CLSID_MSVidFilePlaybackDevice = {0x37B0353C, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B0353C, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidFilePlaybackDevice;

const GUID CLSID_MSVidWebDVD = {0x011B3619, 0xFE63, 0x4814, [0x8A, 0x84, 0x15, 0xA1, 0x94, 0xCE, 0x9C, 0xE3]};
@GUID(0x011B3619, 0xFE63, 0x4814, [0x8A, 0x84, 0x15, 0xA1, 0x94, 0xCE, 0x9C, 0xE3]);
struct MSVidWebDVD;

const GUID CLSID_MSVidWebDVDAdm = {0xFA7C375B, 0x66A7, 0x4280, [0x87, 0x9D, 0xFD, 0x45, 0x9C, 0x84, 0xBB, 0x02]};
@GUID(0xFA7C375B, 0x66A7, 0x4280, [0x87, 0x9D, 0xFD, 0x45, 0x9C, 0x84, 0xBB, 0x02]);
struct MSVidWebDVDAdm;

const GUID CLSID_MSVidVideoRenderer = {0x37B03543, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03543, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidVideoRenderer;

const GUID CLSID_MSVidVMR9 = {0x24DC3975, 0x09BF, 0x4231, [0x86, 0x55, 0x3E, 0xE7, 0x1F, 0x43, 0x83, 0x7D]};
@GUID(0x24DC3975, 0x09BF, 0x4231, [0x86, 0x55, 0x3E, 0xE7, 0x1F, 0x43, 0x83, 0x7D]);
struct MSVidVMR9;

const GUID CLSID_MSVidEVR = {0xC45268A2, 0xFA81, 0x4E19, [0xB1, 0xE3, 0x72, 0xED, 0xBD, 0x60, 0xAE, 0xDA]};
@GUID(0xC45268A2, 0xFA81, 0x4E19, [0xB1, 0xE3, 0x72, 0xED, 0xBD, 0x60, 0xAE, 0xDA]);
struct MSVidEVR;

const GUID CLSID_MSVidAudioRenderer = {0x37B03544, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x37B03544, 0xA4C8, 0x11D2, [0xB6, 0x34, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidAudioRenderer;

const GUID CLSID_MSVidGenericSink = {0x4A5869CF, 0x929D, 0x4040, [0xAE, 0x03, 0xFC, 0xAF, 0xC5, 0xB9, 0xCD, 0x42]};
@GUID(0x4A5869CF, 0x929D, 0x4040, [0xAE, 0x03, 0xFC, 0xAF, 0xC5, 0xB9, 0xCD, 0x42]);
struct MSVidGenericSink;

const GUID CLSID_MSVidStreamBufferSink = {0x9E77AAC4, 0x35E5, 0x42A1, [0xBD, 0xC2, 0x8F, 0x3F, 0xF3, 0x99, 0x84, 0x7C]};
@GUID(0x9E77AAC4, 0x35E5, 0x42A1, [0xBD, 0xC2, 0x8F, 0x3F, 0xF3, 0x99, 0x84, 0x7C]);
struct MSVidStreamBufferSink;

const GUID CLSID_MSVidStreamBufferSource = {0xAD8E510D, 0x217F, 0x409B, [0x80, 0x76, 0x29, 0xC5, 0xE7, 0x3B, 0x98, 0xE8]};
@GUID(0xAD8E510D, 0x217F, 0x409B, [0x80, 0x76, 0x29, 0xC5, 0xE7, 0x3B, 0x98, 0xE8]);
struct MSVidStreamBufferSource;

const GUID CLSID_MSVidStreamBufferV2Source = {0xFD351EA1, 0x4173, 0x4AF4, [0x82, 0x1D, 0x80, 0xD4, 0xAE, 0x97, 0x90, 0x48]};
@GUID(0xFD351EA1, 0x4173, 0x4AF4, [0x82, 0x1D, 0x80, 0xD4, 0xAE, 0x97, 0x90, 0x48]);
struct MSVidStreamBufferV2Source;

const GUID CLSID_MSVidEncoder = {0xBB530C63, 0xD9DF, 0x4B49, [0x94, 0x39, 0x63, 0x45, 0x39, 0x62, 0xE5, 0x98]};
@GUID(0xBB530C63, 0xD9DF, 0x4B49, [0x94, 0x39, 0x63, 0x45, 0x39, 0x62, 0xE5, 0x98]);
struct MSVidEncoder;

const GUID CLSID_MSVidITVCapture = {0x5740A302, 0xEF0B, 0x45CE, [0xBF, 0x3B, 0x44, 0x70, 0xA1, 0x4A, 0x89, 0x80]};
@GUID(0x5740A302, 0xEF0B, 0x45CE, [0xBF, 0x3B, 0x44, 0x70, 0xA1, 0x4A, 0x89, 0x80]);
struct MSVidITVCapture;

const GUID CLSID_MSVidITVPlayback = {0x9E797ED0, 0x5253, 0x4243, [0xA9, 0xB7, 0xBD, 0x06, 0xC5, 0x8F, 0x8E, 0xF3]};
@GUID(0x9E797ED0, 0x5253, 0x4243, [0xA9, 0xB7, 0xBD, 0x06, 0xC5, 0x8F, 0x8E, 0xF3]);
struct MSVidITVPlayback;

const GUID CLSID_MSVidCCA = {0x86151827, 0xE47B, 0x45EE, [0x84, 0x21, 0xD1, 0x0E, 0x6E, 0x69, 0x09, 0x79]};
@GUID(0x86151827, 0xE47B, 0x45EE, [0x84, 0x21, 0xD1, 0x0E, 0x6E, 0x69, 0x09, 0x79]);
struct MSVidCCA;

const GUID CLSID_MSVidClosedCaptioning = {0x7F9CB14D, 0x48E4, 0x43B6, [0x93, 0x46, 0x1A, 0xEB, 0xC3, 0x9C, 0x64, 0xD3]};
@GUID(0x7F9CB14D, 0x48E4, 0x43B6, [0x93, 0x46, 0x1A, 0xEB, 0xC3, 0x9C, 0x64, 0xD3]);
struct MSVidClosedCaptioning;

const GUID CLSID_MSVidClosedCaptioningSI = {0x92ED88BF, 0x879E, 0x448F, [0xB6, 0xB6, 0xA3, 0x85, 0xBC, 0xEB, 0x84, 0x6D]};
@GUID(0x92ED88BF, 0x879E, 0x448F, [0xB6, 0xB6, 0xA3, 0x85, 0xBC, 0xEB, 0x84, 0x6D]);
struct MSVidClosedCaptioningSI;

const GUID CLSID_MSVidDataServices = {0x334125C0, 0x77E5, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x334125C0, 0x77E5, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidDataServices;

const GUID CLSID_MSVidXDS = {0x0149EEDF, 0xD08F, 0x4142, [0x8D, 0x73, 0xD2, 0x39, 0x03, 0xD2, 0x1E, 0x90]};
@GUID(0x0149EEDF, 0xD08F, 0x4142, [0x8D, 0x73, 0xD2, 0x39, 0x03, 0xD2, 0x1E, 0x90]);
struct MSVidXDS;

const GUID CLSID_MSVidAnalogCaptureToDataServices = {0xC5702CD6, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CD6, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidAnalogCaptureToDataServices;

const GUID CLSID_MSVidDataServicesToStreamBufferSink = {0x38F03426, 0xE83B, 0x4E68, [0xB6, 0x5B, 0xDC, 0xAE, 0x73, 0x30, 0x48, 0x38]};
@GUID(0x38F03426, 0xE83B, 0x4E68, [0xB6, 0x5B, 0xDC, 0xAE, 0x73, 0x30, 0x48, 0x38]);
struct MSVidDataServicesToStreamBufferSink;

const GUID CLSID_MSVidDataServicesToXDS = {0x0429EC6E, 0x1144, 0x4BED, [0xB8, 0x8B, 0x2F, 0xB9, 0x89, 0x9A, 0x4A, 0x3D]};
@GUID(0x0429EC6E, 0x1144, 0x4BED, [0xB8, 0x8B, 0x2F, 0xB9, 0x89, 0x9A, 0x4A, 0x3D]);
struct MSVidDataServicesToXDS;

const GUID CLSID_MSVidAnalogCaptureToXDS = {0x3540D440, 0x5B1D, 0x49CB, [0x82, 0x1A, 0xE8, 0x4B, 0x8C, 0xF0, 0x65, 0xA7]};
@GUID(0x3540D440, 0x5B1D, 0x49CB, [0x82, 0x1A, 0xE8, 0x4B, 0x8C, 0xF0, 0x65, 0xA7]);
struct MSVidAnalogCaptureToXDS;

const GUID CLSID_MSVidCtl = {0xB0EDF163, 0x910A, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xB0EDF163, 0x910A, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidCtl;

const GUID CLSID_MSVidInputDevices = {0xC5702CCC, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CCC, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidInputDevices;

const GUID CLSID_MSVidOutputDevices = {0xC5702CCD, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CCD, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidOutputDevices;

const GUID CLSID_MSVidVideoRendererDevices = {0xC5702CCE, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CCE, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidVideoRendererDevices;

const GUID CLSID_MSVidAudioRendererDevices = {0xC5702CCF, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CCF, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidAudioRendererDevices;

const GUID CLSID_MSVidFeatures = {0xC5702CD0, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xC5702CD0, 0x9B79, 0x11D3, [0xB6, 0x54, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidFeatures;

const GUID CLSID_MSVidGenericComposite = {0x2764BCE5, 0xCC39, 0x11D2, [0xB6, 0x39, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0x2764BCE5, 0xCC39, 0x11D2, [0xB6, 0x39, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidGenericComposite;

const GUID CLSID_MSVidAnalogCaptureToOverlayMixer = {0xE18AF75A, 0x08AF, 0x11D3, [0xB6, 0x4A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xE18AF75A, 0x08AF, 0x11D3, [0xB6, 0x4A, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct MSVidAnalogCaptureToOverlayMixer;

const GUID CLSID_MSVidWebDVDToVideoRenderer = {0x267DB0B3, 0x55E3, 0x4902, [0x94, 0x9B, 0xDF, 0x8F, 0x5C, 0xEC, 0x01, 0x91]};
@GUID(0x267DB0B3, 0x55E3, 0x4902, [0x94, 0x9B, 0xDF, 0x8F, 0x5C, 0xEC, 0x01, 0x91]);
struct MSVidWebDVDToVideoRenderer;

const GUID CLSID_MSVidWebDVDToAudioRenderer = {0x8D04238E, 0x9FD1, 0x41C6, [0x8D, 0xE3, 0x9E, 0x1E, 0xE3, 0x09, 0xE9, 0x35]};
@GUID(0x8D04238E, 0x9FD1, 0x41C6, [0x8D, 0xE3, 0x9E, 0x1E, 0xE3, 0x09, 0xE9, 0x35]);
struct MSVidWebDVDToAudioRenderer;

const GUID CLSID_MSVidMPEG2DecoderToClosedCaptioning = {0x6AD28EE1, 0x5002, 0x4E71, [0xAA, 0xF7, 0xBD, 0x07, 0x79, 0x07, 0xB1, 0xA4]};
@GUID(0x6AD28EE1, 0x5002, 0x4E71, [0xAA, 0xF7, 0xBD, 0x07, 0x79, 0x07, 0xB1, 0xA4]);
struct MSVidMPEG2DecoderToClosedCaptioning;

const GUID CLSID_MSVidAnalogCaptureToStreamBufferSink = {0x9F50E8B1, 0x9530, 0x4DDC, [0x82, 0x5E, 0x1A, 0xF8, 0x1D, 0x47, 0xAE, 0xD6]};
@GUID(0x9F50E8B1, 0x9530, 0x4DDC, [0x82, 0x5E, 0x1A, 0xF8, 0x1D, 0x47, 0xAE, 0xD6]);
struct MSVidAnalogCaptureToStreamBufferSink;

const GUID CLSID_MSVidDigitalCaptureToStreamBufferSink = {0xABE40035, 0x27C3, 0x4A2F, [0x81, 0x53, 0x66, 0x24, 0x47, 0x16, 0x08, 0xAF]};
@GUID(0xABE40035, 0x27C3, 0x4A2F, [0x81, 0x53, 0x66, 0x24, 0x47, 0x16, 0x08, 0xAF]);
struct MSVidDigitalCaptureToStreamBufferSink;

const GUID CLSID_MSVidITVToStreamBufferSink = {0x92B94828, 0x1AF7, 0x4E6E, [0x9E, 0xBF, 0x77, 0x06, 0x57, 0xF7, 0x7A, 0xF5]};
@GUID(0x92B94828, 0x1AF7, 0x4E6E, [0x9E, 0xBF, 0x77, 0x06, 0x57, 0xF7, 0x7A, 0xF5]);
struct MSVidITVToStreamBufferSink;

const GUID CLSID_MSVidCCAToStreamBufferSink = {0x3EF76D68, 0x8661, 0x4843, [0x8B, 0x8F, 0xC3, 0x71, 0x63, 0xD8, 0xC9, 0xCE]};
@GUID(0x3EF76D68, 0x8661, 0x4843, [0x8B, 0x8F, 0xC3, 0x71, 0x63, 0xD8, 0xC9, 0xCE]);
struct MSVidCCAToStreamBufferSink;

const GUID CLSID_MSVidEncoderToStreamBufferSink = {0xA0B9B497, 0xAFBC, 0x45AD, [0xA8, 0xA6, 0x9B, 0x07, 0x7C, 0x40, 0xD4, 0xF2]};
@GUID(0xA0B9B497, 0xAFBC, 0x45AD, [0xA8, 0xA6, 0x9B, 0x07, 0x7C, 0x40, 0xD4, 0xF2]);
struct MSVidEncoderToStreamBufferSink;

const GUID CLSID_MSVidFilePlaybackToVideoRenderer = {0xB401C5EB, 0x8457, 0x427F, [0x84, 0xEA, 0xA4, 0xD2, 0x36, 0x33, 0x64, 0xB0]};
@GUID(0xB401C5EB, 0x8457, 0x427F, [0x84, 0xEA, 0xA4, 0xD2, 0x36, 0x33, 0x64, 0xB0]);
struct MSVidFilePlaybackToVideoRenderer;

const GUID CLSID_MSVidFilePlaybackToAudioRenderer = {0xCC23F537, 0x18D4, 0x4ECE, [0x93, 0xBD, 0x20, 0x7A, 0x84, 0x72, 0x69, 0x79]};
@GUID(0xCC23F537, 0x18D4, 0x4ECE, [0x93, 0xBD, 0x20, 0x7A, 0x84, 0x72, 0x69, 0x79]);
struct MSVidFilePlaybackToAudioRenderer;

const GUID CLSID_MSVidAnalogTVToEncoder = {0x28953661, 0x0231, 0x41DB, [0x89, 0x86, 0x21, 0xFF, 0x43, 0x88, 0xEE, 0x9B]};
@GUID(0x28953661, 0x0231, 0x41DB, [0x89, 0x86, 0x21, 0xFF, 0x43, 0x88, 0xEE, 0x9B]);
struct MSVidAnalogTVToEncoder;

const GUID CLSID_MSVidStreamBufferSourceToVideoRenderer = {0x3C4708DC, 0xB181, 0x46A8, [0x8D, 0xA8, 0x4A, 0xB0, 0x37, 0x17, 0x58, 0xCD]};
@GUID(0x3C4708DC, 0xB181, 0x46A8, [0x8D, 0xA8, 0x4A, 0xB0, 0x37, 0x17, 0x58, 0xCD]);
struct MSVidStreamBufferSourceToVideoRenderer;

const GUID CLSID_MSVidAnalogCaptureToCCA = {0x942B7909, 0xA28E, 0x49A1, [0xA2, 0x07, 0x34, 0xEB, 0xCB, 0xCB, 0x4B, 0x3B]};
@GUID(0x942B7909, 0xA28E, 0x49A1, [0xA2, 0x07, 0x34, 0xEB, 0xCB, 0xCB, 0x4B, 0x3B]);
struct MSVidAnalogCaptureToCCA;

const GUID CLSID_MSVidDigitalCaptureToCCA = {0x73D14237, 0xB9DB, 0x4EFA, [0xA6, 0xDD, 0x84, 0x35, 0x04, 0x21, 0xFB, 0x2F]};
@GUID(0x73D14237, 0xB9DB, 0x4EFA, [0xA6, 0xDD, 0x84, 0x35, 0x04, 0x21, 0xFB, 0x2F]);
struct MSVidDigitalCaptureToCCA;

const GUID CLSID_MSVidDigitalCaptureToITV = {0x5D8E73F7, 0x4989, 0x4AC8, [0x8A, 0x98, 0x39, 0xBA, 0x0D, 0x32, 0x53, 0x02]};
@GUID(0x5D8E73F7, 0x4989, 0x4AC8, [0x8A, 0x98, 0x39, 0xBA, 0x0D, 0x32, 0x53, 0x02]);
struct MSVidDigitalCaptureToITV;

const GUID CLSID_MSVidSBESourceToITV = {0x2291478C, 0x5EE3, 0x4BEF, [0xAB, 0x5D, 0xB5, 0xFF, 0x2C, 0xF5, 0x83, 0x52]};
@GUID(0x2291478C, 0x5EE3, 0x4BEF, [0xAB, 0x5D, 0xB5, 0xFF, 0x2C, 0xF5, 0x83, 0x52]);
struct MSVidSBESourceToITV;

const GUID CLSID_MSVidSBESourceToCC = {0x9193A8F9, 0x0CBA, 0x400E, [0xAA, 0x97, 0xEB, 0x47, 0x09, 0x16, 0x45, 0x76]};
@GUID(0x9193A8F9, 0x0CBA, 0x400E, [0xAA, 0x97, 0xEB, 0x47, 0x09, 0x16, 0x45, 0x76]);
struct MSVidSBESourceToCC;

const GUID CLSID_MSVidSBESourceToGenericSink = {0x991DA7E5, 0x953F, 0x435B, [0xBE, 0x5E, 0xB9, 0x2A, 0x05, 0xED, 0xFC, 0x42]};
@GUID(0x991DA7E5, 0x953F, 0x435B, [0xBE, 0x5E, 0xB9, 0x2A, 0x05, 0xED, 0xFC, 0x42]);
struct MSVidSBESourceToGenericSink;

const GUID CLSID_MSVidCCToVMR = {0xC4BF2784, 0xAE00, 0x41BA, [0x98, 0x28, 0x9C, 0x95, 0x3B, 0xD3, 0xC5, 0x4A]};
@GUID(0xC4BF2784, 0xAE00, 0x41BA, [0x98, 0x28, 0x9C, 0x95, 0x3B, 0xD3, 0xC5, 0x4A]);
struct MSVidCCToVMR;

const GUID CLSID_MSVidCCToAR = {0xD76334CA, 0xD89E, 0x4BAF, [0x86, 0xAB, 0xDD, 0xB5, 0x93, 0x72, 0xAF, 0xC2]};
@GUID(0xD76334CA, 0xD89E, 0x4BAF, [0x86, 0xAB, 0xDD, 0xB5, 0x93, 0x72, 0xAF, 0xC2]);
struct MSVidCCToAR;

const GUID CLSID_MSEventBinder = {0x577FAA18, 0x4518, 0x445E, [0x8F, 0x70, 0x14, 0x73, 0xF8, 0xCF, 0x4B, 0xA4]};
@GUID(0x577FAA18, 0x4518, 0x445E, [0x8F, 0x70, 0x14, 0x73, 0xF8, 0xCF, 0x4B, 0xA4]);
struct MSEventBinder;

const GUID CLSID_MSVidStreamBufferRecordingControl = {0xCAAFDD83, 0xCEFC, 0x4E3D, [0xBA, 0x03, 0x17, 0x5F, 0x17, 0xA2, 0x4F, 0x91]};
@GUID(0xCAAFDD83, 0xCEFC, 0x4E3D, [0xBA, 0x03, 0x17, 0x5F, 0x17, 0xA2, 0x4F, 0x91]);
struct MSVidStreamBufferRecordingControl;

const GUID CLSID_MSVidRect = {0xCB4276E6, 0x7D5F, 0x4CF1, [0x97, 0x27, 0x62, 0x9C, 0x5E, 0x6D, 0xB6, 0xAE]};
@GUID(0xCB4276E6, 0x7D5F, 0x4CF1, [0x97, 0x27, 0x62, 0x9C, 0x5E, 0x6D, 0xB6, 0xAE]);
struct MSVidRect;

const GUID CLSID_MSVidDevice = {0x6E40476F, 0x9C49, 0x4C3E, [0x8B, 0xB9, 0x85, 0x87, 0x95, 0x8E, 0xFF, 0x74]};
@GUID(0x6E40476F, 0x9C49, 0x4C3E, [0x8B, 0xB9, 0x85, 0x87, 0x95, 0x8E, 0xFF, 0x74]);
struct MSVidDevice;

const GUID CLSID_MSVidDevice2 = {0x30997F7D, 0xB3B5, 0x4A1C, [0x98, 0x3A, 0x1F, 0xE8, 0x09, 0x8C, 0xB7, 0x7D]};
@GUID(0x30997F7D, 0xB3B5, 0x4A1C, [0x98, 0x3A, 0x1F, 0xE8, 0x09, 0x8C, 0xB7, 0x7D]);
struct MSVidDevice2;

const GUID CLSID_MSVidInputDevice = {0xAC1972F2, 0x138A, 0x4CA3, [0x90, 0xDA, 0xAE, 0x51, 0x11, 0x2E, 0xDA, 0x28]};
@GUID(0xAC1972F2, 0x138A, 0x4CA3, [0x90, 0xDA, 0xAE, 0x51, 0x11, 0x2E, 0xDA, 0x28]);
struct MSVidInputDevice;

const GUID CLSID_MSVidVideoInputDevice = {0x95F4820B, 0xBB3A, 0x4E2D, [0xBC, 0x64, 0x5B, 0x81, 0x7B, 0xC2, 0xC3, 0x0E]};
@GUID(0x95F4820B, 0xBB3A, 0x4E2D, [0xBC, 0x64, 0x5B, 0x81, 0x7B, 0xC2, 0xC3, 0x0E]);
struct MSVidVideoInputDevice;

const GUID CLSID_MSVidVideoPlaybackDevice = {0x1990D634, 0x1A5E, 0x4071, [0xA3, 0x4A, 0x53, 0xAA, 0xFF, 0xCE, 0x9F, 0x36]};
@GUID(0x1990D634, 0x1A5E, 0x4071, [0xA3, 0x4A, 0x53, 0xAA, 0xFF, 0xCE, 0x9F, 0x36]);
struct MSVidVideoPlaybackDevice;

const GUID CLSID_MSVidFeature = {0x7748530B, 0xC08A, 0x47EA, [0xB2, 0x4C, 0xBE, 0x86, 0x95, 0xFF, 0x40, 0x5F]};
@GUID(0x7748530B, 0xC08A, 0x47EA, [0xB2, 0x4C, 0xBE, 0x86, 0x95, 0xFF, 0x40, 0x5F]);
struct MSVidFeature;

const GUID CLSID_MSVidOutput = {0x87EB890D, 0x03AD, 0x4E9D, [0x98, 0x66, 0x37, 0x6E, 0x5E, 0xC5, 0x72, 0xED]};
@GUID(0x87EB890D, 0x03AD, 0x4E9D, [0x98, 0x66, 0x37, 0x6E, 0x5E, 0xC5, 0x72, 0xED]);
struct MSVidOutput;

enum MSViddispidList
{
    dispidInputs = 0,
    dispidOutputs = 1,
    dispid_Inputs = 2,
    dispid_Outputs = 3,
    dispidVideoRenderers = 4,
    dispidAudioRenderers = 5,
    dispidFeatures = 6,
    dispidInput = 7,
    dispidOutput = 8,
    dispidVideoRenderer = 9,
    dispidAudioRenderer = 10,
    dispidSelectedFeatures = 11,
    dispidView = 12,
    dispidBuild = 13,
    dispidPause = 14,
    dispidRun = 15,
    dispidStop = 16,
    dispidDecompose = 17,
    dispidDisplaySize = 18,
    dispidMaintainAspectRatio = 19,
    dispidColorKey = 20,
    dispidStateChange = 21,
    dispidgetState = 22,
    dispidunbind = 23,
    dispidbind = 24,
    dispidDisableVideo = 25,
    dispidDisableAudio = 26,
    dispidViewNext = 27,
    dispidServiceP = 28,
}

enum DisplaySizeList
{
    dslDefaultSize = 0,
    dslSourceSize = 0,
    dslHalfSourceSize = 1,
    dslDoubleSourceSize = 2,
    dslFullScreen = 3,
    dslHalfScreen = 4,
    dslQuarterScreen = 5,
    dslSixteenthScreen = 6,
}

enum MSVidCtlStateList
{
    STATE_UNBUILT = -1,
    STATE_STOP = 0,
    STATE_PAUSE = 1,
    STATE_PLAY = 2,
}

const GUID IID_IMSVidCtl = {0xB0EDF162, 0x910A, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xB0EDF162, 0x910A, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
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
    HRESULT get__InputsAvailable(Guid* CategoryGuid, IMSVidInputDevices* pVal);
    HRESULT get__OutputsAvailable(Guid* CategoryGuid, IMSVidOutputDevices* pVal);
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

const GUID IID_IMSEventBinder = {0xC3A9F406, 0x2222, 0x436D, [0x86, 0xD5, 0xBA, 0x32, 0x29, 0x27, 0x9E, 0xFB]};
@GUID(0xC3A9F406, 0x2222, 0x436D, [0x86, 0xD5, 0xBA, 0x32, 0x29, 0x27, 0x9E, 0xFB]);
interface IMSEventBinder : IDispatch
{
    HRESULT Bind(IDispatch pEventObject, BSTR EventName, BSTR EventHandler, int* CancelID);
    HRESULT Unbind(uint CancelCookie);
}

const GUID IID__IMSVidCtlEvents = {0xB0EDF164, 0x910A, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xB0EDF164, 0x910A, 0x11D2, [0xB6, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
interface _IMSVidCtlEvents : IDispatch
{
}

const GUID IID_IStreamBufferInitialize = {0x9CE50F2D, 0x6BA7, 0x40FB, [0xA0, 0x34, 0x50, 0xB1, 0xA6, 0x74, 0xEC, 0x78]};
@GUID(0x9CE50F2D, 0x6BA7, 0x40FB, [0xA0, 0x34, 0x50, 0xB1, 0xA6, 0x74, 0xEC, 0x78]);
interface IStreamBufferInitialize : IUnknown
{
    HRESULT SetHKEY(HKEY hkeyRoot);
    HRESULT SetSIDs(uint cSIDs, void** ppSID);
}

enum __MIDL___MIDL_itf_sbe_0000_0001_0001
{
    RECORDING_TYPE_CONTENT = 0,
    RECORDING_TYPE_REFERENCE = 1,
}

const GUID IID_IStreamBufferSink = {0xAFD1F242, 0x7EFD, 0x45EE, [0xBA, 0x4E, 0x40, 0x7A, 0x25, 0xC9, 0xA7, 0x7A]};
@GUID(0xAFD1F242, 0x7EFD, 0x45EE, [0xBA, 0x4E, 0x40, 0x7A, 0x25, 0xC9, 0xA7, 0x7A]);
interface IStreamBufferSink : IUnknown
{
    HRESULT LockProfile(const(wchar)* pszStreamBufferFilename);
    HRESULT CreateRecorder(const(wchar)* pszFilename, uint dwRecordType, IUnknown* pRecordingIUnknown);
    HRESULT IsProfileLocked();
}

const GUID IID_IStreamBufferSink2 = {0xDB94A660, 0xF4FB, 0x4BFA, [0xBC, 0xC6, 0xFE, 0x15, 0x9A, 0x4E, 0xEA, 0x93]};
@GUID(0xDB94A660, 0xF4FB, 0x4BFA, [0xBC, 0xC6, 0xFE, 0x15, 0x9A, 0x4E, 0xEA, 0x93]);
interface IStreamBufferSink2 : IStreamBufferSink
{
    HRESULT UnlockProfile();
}

const GUID IID_IStreamBufferSink3 = {0x974723F2, 0x887A, 0x4452, [0x93, 0x66, 0x2C, 0xFF, 0x30, 0x57, 0xBC, 0x8F]};
@GUID(0x974723F2, 0x887A, 0x4452, [0x93, 0x66, 0x2C, 0xFF, 0x30, 0x57, 0xBC, 0x8F]);
interface IStreamBufferSink3 : IStreamBufferSink2
{
    HRESULT SetAvailableFilter(long* prtMin);
}

const GUID IID_IStreamBufferSource = {0x1C5BD776, 0x6CED, 0x4F44, [0x81, 0x64, 0x5E, 0xAB, 0x0E, 0x98, 0xDB, 0x12]};
@GUID(0x1C5BD776, 0x6CED, 0x4F44, [0x81, 0x64, 0x5E, 0xAB, 0x0E, 0x98, 0xDB, 0x12]);
interface IStreamBufferSource : IUnknown
{
    HRESULT SetStreamSink(IStreamBufferSink pIStreamBufferSink);
}

const GUID IID_IStreamBufferRecordControl = {0xBA9B6C99, 0xF3C7, 0x4FF2, [0x92, 0xDB, 0xCF, 0xDD, 0x48, 0x51, 0xBF, 0x31]};
@GUID(0xBA9B6C99, 0xF3C7, 0x4FF2, [0x92, 0xDB, 0xCF, 0xDD, 0x48, 0x51, 0xBF, 0x31]);
interface IStreamBufferRecordControl : IUnknown
{
    HRESULT Start(long* prtStart);
    HRESULT Stop(long rtStop);
    HRESULT GetRecordingStatus(int* phResult, int* pbStarted, int* pbStopped);
}

const GUID IID_IStreamBufferRecComp = {0x9E259A9B, 0x8815, 0x42AE, [0xB0, 0x9F, 0x22, 0x19, 0x70, 0xB1, 0x54, 0xFD]};
@GUID(0x9E259A9B, 0x8815, 0x42AE, [0xB0, 0x9F, 0x22, 0x19, 0x70, 0xB1, 0x54, 0xFD]);
interface IStreamBufferRecComp : IUnknown
{
    HRESULT Initialize(const(wchar)* pszTargetFilename, const(wchar)* pszSBRecProfileRef);
    HRESULT Append(const(wchar)* pszSBRecording);
    HRESULT AppendEx(const(wchar)* pszSBRecording, long rtStart, long rtStop);
    HRESULT GetCurrentLength(uint* pcSeconds);
    HRESULT Close();
    HRESULT Cancel();
}

enum STREAMBUFFER_ATTR_DATATYPE
{
    STREAMBUFFER_TYPE_DWORD = 0,
    STREAMBUFFER_TYPE_STRING = 1,
    STREAMBUFFER_TYPE_BINARY = 2,
    STREAMBUFFER_TYPE_BOOL = 3,
    STREAMBUFFER_TYPE_QWORD = 4,
    STREAMBUFFER_TYPE_WORD = 5,
    STREAMBUFFER_TYPE_GUID = 6,
}

const GUID IID_IStreamBufferRecordingAttribute = {0x16CA4E03, 0xFE69, 0x4705, [0xBD, 0x41, 0x5B, 0x7D, 0xFC, 0x0C, 0x95, 0xF3]};
@GUID(0x16CA4E03, 0xFE69, 0x4705, [0xBD, 0x41, 0x5B, 0x7D, 0xFC, 0x0C, 0x95, 0xF3]);
interface IStreamBufferRecordingAttribute : IUnknown
{
    HRESULT SetAttribute(uint ulReserved, const(wchar)* pszAttributeName, STREAMBUFFER_ATTR_DATATYPE StreamBufferAttributeType, char* pbAttribute, ushort cbAttributeLength);
    HRESULT GetAttributeCount(uint ulReserved, ushort* pcAttributes);
    HRESULT GetAttributeByName(const(wchar)* pszAttributeName, uint* pulReserved, STREAMBUFFER_ATTR_DATATYPE* pStreamBufferAttributeType, char* pbAttribute, ushort* pcbLength);
    HRESULT GetAttributeByIndex(ushort wIndex, uint* pulReserved, ushort* pszAttributeName, ushort* pcchNameLength, STREAMBUFFER_ATTR_DATATYPE* pStreamBufferAttributeType, char* pbAttribute, ushort* pcbLength);
    HRESULT EnumAttributes(IEnumStreamBufferRecordingAttrib* ppIEnumStreamBufferAttrib);
}

struct STREAMBUFFER_ATTRIBUTE
{
    const(wchar)* pszName;
    STREAMBUFFER_ATTR_DATATYPE StreamBufferAttributeType;
    ubyte* pbAttribute;
    ushort cbLength;
}

const GUID IID_IEnumStreamBufferRecordingAttrib = {0xC18A9162, 0x1E82, 0x4142, [0x8C, 0x73, 0x56, 0x90, 0xFA, 0x62, 0xFE, 0x33]};
@GUID(0xC18A9162, 0x1E82, 0x4142, [0x8C, 0x73, 0x56, 0x90, 0xFA, 0x62, 0xFE, 0x33]);
interface IEnumStreamBufferRecordingAttrib : IUnknown
{
    HRESULT Next(uint cRequest, char* pStreamBufferAttribute, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(IEnumStreamBufferRecordingAttrib* ppIEnumStreamBufferAttrib);
}

const GUID IID_IStreamBufferConfigure = {0xCE14DFAE, 0x4098, 0x4AF7, [0xBB, 0xF7, 0xD6, 0x51, 0x1F, 0x83, 0x54, 0x14]};
@GUID(0xCE14DFAE, 0x4098, 0x4AF7, [0xBB, 0xF7, 0xD6, 0x51, 0x1F, 0x83, 0x54, 0x14]);
interface IStreamBufferConfigure : IUnknown
{
    HRESULT SetDirectory(const(wchar)* pszDirectoryName);
    HRESULT GetDirectory(ushort** ppszDirectoryName);
    HRESULT SetBackingFileCount(uint dwMin, uint dwMax);
    HRESULT GetBackingFileCount(uint* pdwMin, uint* pdwMax);
    HRESULT SetBackingFileDuration(uint dwSeconds);
    HRESULT GetBackingFileDuration(uint* pdwSeconds);
}

const GUID IID_IStreamBufferConfigure2 = {0x53E037BF, 0x3992, 0x4282, [0xAE, 0x34, 0x24, 0x87, 0xB4, 0xDA, 0xE0, 0x6B]};
@GUID(0x53E037BF, 0x3992, 0x4282, [0xAE, 0x34, 0x24, 0x87, 0xB4, 0xDA, 0xE0, 0x6B]);
interface IStreamBufferConfigure2 : IStreamBufferConfigure
{
    HRESULT SetMultiplexedPacketSize(uint cbBytesPerPacket);
    HRESULT GetMultiplexedPacketSize(uint* pcbBytesPerPacket);
    HRESULT SetFFTransitionRates(uint dwMaxFullFrameRate, uint dwMaxNonSkippingRate);
    HRESULT GetFFTransitionRates(uint* pdwMaxFullFrameRate, uint* pdwMaxNonSkippingRate);
}

const GUID IID_IStreamBufferConfigure3 = {0x7E2D2A1E, 0x7192, 0x4BD7, [0x80, 0xC1, 0x06, 0x1F, 0xD1, 0xD1, 0x04, 0x02]};
@GUID(0x7E2D2A1E, 0x7192, 0x4BD7, [0x80, 0xC1, 0x06, 0x1F, 0xD1, 0xD1, 0x04, 0x02]);
interface IStreamBufferConfigure3 : IStreamBufferConfigure2
{
    HRESULT SetStartRecConfig(BOOL fStartStopsCur);
    HRESULT GetStartRecConfig(int* pfStartStopsCur);
    HRESULT SetNamespace(const(wchar)* pszNamespace);
    HRESULT GetNamespace(ushort** ppszNamespace);
}

const GUID IID_IStreamBufferMediaSeeking = {0xF61F5C26, 0x863D, 0x4AFA, [0xB0, 0xBA, 0x2F, 0x81, 0xDC, 0x97, 0x85, 0x96]};
@GUID(0xF61F5C26, 0x863D, 0x4AFA, [0xB0, 0xBA, 0x2F, 0x81, 0xDC, 0x97, 0x85, 0x96]);
interface IStreamBufferMediaSeeking : IMediaSeeking
{
}

const GUID IID_IStreamBufferMediaSeeking2 = {0x3A439AB0, 0x155F, 0x470A, [0x86, 0xA6, 0x9E, 0xA5, 0x4A, 0xFD, 0x6E, 0xAF]};
@GUID(0x3A439AB0, 0x155F, 0x470A, [0x86, 0xA6, 0x9E, 0xA5, 0x4A, 0xFD, 0x6E, 0xAF]);
interface IStreamBufferMediaSeeking2 : IStreamBufferMediaSeeking
{
    HRESULT SetRateEx(double dRate, uint dwFramesPerSec);
}

struct SBE_PIN_DATA
{
    ulong cDataBytes;
    ulong cSamplesProcessed;
    ulong cDiscontinuities;
    ulong cSyncPoints;
    ulong cTimestamps;
}

const GUID IID_IStreamBufferDataCounters = {0x9D2A2563, 0x31AB, 0x402E, [0x9A, 0x6B, 0xAD, 0xB9, 0x03, 0x48, 0x94, 0x40]};
@GUID(0x9D2A2563, 0x31AB, 0x402E, [0x9A, 0x6B, 0xAD, 0xB9, 0x03, 0x48, 0x94, 0x40]);
interface IStreamBufferDataCounters : IUnknown
{
    HRESULT GetData(SBE_PIN_DATA* pPinData);
    HRESULT ResetData();
}

enum CROSSBAR_DEFAULT_FLAGS
{
    DEF_MODE_PROFILE = 1,
    DEF_MODE_STREAMS = 2,
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
    uint Version;
    uint StreamId;
    BOOL Default;
    BOOL Creation;
    uint Reserved;
    Guid guidSubMediaType;
    Guid guidFormatType;
    AM_MEDIA_TYPE MediaType;
}

const GUID IID_ISBE2GlobalEvent = {0xCAEDE759, 0xB6B1, 0x11DB, [0xA5, 0x78, 0x00, 0x18, 0xF3, 0xFA, 0x24, 0xC6]};
@GUID(0xCAEDE759, 0xB6B1, 0x11DB, [0xA5, 0x78, 0x00, 0x18, 0xF3, 0xFA, 0x24, 0xC6]);
interface ISBE2GlobalEvent : IUnknown
{
    HRESULT GetEvent(const(Guid)* idEvt, uint param1, uint param2, uint param3, uint param4, int* pSpanning, uint* pcb, char* pb);
}

const GUID IID_ISBE2GlobalEvent2 = {0x6D8309BF, 0x00FE, 0x4506, [0x8B, 0x03, 0xF8, 0xC6, 0x5B, 0x5C, 0x9B, 0x39]};
@GUID(0x6D8309BF, 0x00FE, 0x4506, [0x8B, 0x03, 0xF8, 0xC6, 0x5B, 0x5C, 0x9B, 0x39]);
interface ISBE2GlobalEvent2 : ISBE2GlobalEvent
{
    HRESULT GetEventEx(const(Guid)* idEvt, uint param1, uint param2, uint param3, uint param4, int* pSpanning, uint* pcb, char* pb, long* pStreamTime);
}

const GUID IID_ISBE2SpanningEvent = {0xCAEDE760, 0xB6B1, 0x11DB, [0xA5, 0x78, 0x00, 0x18, 0xF3, 0xFA, 0x24, 0xC6]};
@GUID(0xCAEDE760, 0xB6B1, 0x11DB, [0xA5, 0x78, 0x00, 0x18, 0xF3, 0xFA, 0x24, 0xC6]);
interface ISBE2SpanningEvent : IUnknown
{
    HRESULT GetEvent(const(Guid)* idEvt, uint streamId, uint* pcb, char* pb);
}

const GUID IID_ISBE2Crossbar = {0x547B6D26, 0x3226, 0x487E, [0x82, 0x53, 0x8A, 0xA1, 0x68, 0x74, 0x94, 0x34]};
@GUID(0x547B6D26, 0x3226, 0x487E, [0x82, 0x53, 0x8A, 0xA1, 0x68, 0x74, 0x94, 0x34]);
interface ISBE2Crossbar : IUnknown
{
    HRESULT EnableDefaultMode(uint DefaultFlags);
    HRESULT GetInitialProfile(ISBE2MediaTypeProfile* ppProfile);
    HRESULT SetOutputProfile(ISBE2MediaTypeProfile pProfile, uint* pcOutputPins, IPin* ppOutputPins);
    HRESULT EnumStreams(ISBE2EnumStream* ppStreams);
}

const GUID IID_ISBE2StreamMap = {0x667C7745, 0x85B1, 0x4C55, [0xAE, 0x55, 0x4E, 0x25, 0x05, 0x61, 0x59, 0xFC]};
@GUID(0x667C7745, 0x85B1, 0x4C55, [0xAE, 0x55, 0x4E, 0x25, 0x05, 0x61, 0x59, 0xFC]);
interface ISBE2StreamMap : IUnknown
{
    HRESULT MapStream(uint Stream);
    HRESULT UnmapStream(uint Stream);
    HRESULT EnumMappedStreams(ISBE2EnumStream* ppStreams);
}

const GUID IID_ISBE2EnumStream = {0xF7611092, 0x9FBC, 0x46EC, [0xA7, 0xC7, 0x54, 0x8E, 0xA7, 0x8B, 0x71, 0xA4]};
@GUID(0xF7611092, 0x9FBC, 0x46EC, [0xA7, 0xC7, 0x54, 0x8E, 0xA7, 0x8B, 0x71, 0xA4]);
interface ISBE2EnumStream : IUnknown
{
    HRESULT Next(uint cRequest, char* pStreamDesc, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(ISBE2EnumStream* ppIEnumStream);
}

const GUID IID_ISBE2MediaTypeProfile = {0xF238267D, 0x4671, 0x40D7, [0x99, 0x7E, 0x25, 0xDC, 0x32, 0xCF, 0xED, 0x2A]};
@GUID(0xF238267D, 0x4671, 0x40D7, [0x99, 0x7E, 0x25, 0xDC, 0x32, 0xCF, 0xED, 0x2A]);
interface ISBE2MediaTypeProfile : IUnknown
{
    HRESULT GetStreamCount(uint* pCount);
    HRESULT GetStream(uint Index, AM_MEDIA_TYPE** ppMediaType);
    HRESULT AddStream(AM_MEDIA_TYPE* pMediaType);
    HRESULT DeleteStream(uint Index);
}

const GUID IID_ISBE2FileScan = {0x3E2BF5A5, 0x4F96, 0x4899, [0xA1, 0xA3, 0x75, 0xE8, 0xBE, 0x9A, 0x5A, 0xC0]};
@GUID(0x3E2BF5A5, 0x4F96, 0x4899, [0xA1, 0xA3, 0x75, 0xE8, 0xBE, 0x9A, 0x5A, 0xC0]);
interface ISBE2FileScan : IUnknown
{
    HRESULT RepairFile(const(wchar)* filename);
}

const GUID CLSID_SectionList = {0x73DA5D04, 0x4347, 0x45D3, [0xA9, 0xDC, 0xFA, 0xE9, 0xDD, 0xBE, 0x55, 0x8D]};
@GUID(0x73DA5D04, 0x4347, 0x45D3, [0xA9, 0xDC, 0xFA, 0xE9, 0xDD, 0xBE, 0x55, 0x8D]);
struct SectionList;

const GUID CLSID_Mpeg2Stream = {0xF91D96C7, 0x8509, 0x4D0B, [0xAB, 0x26, 0xA0, 0xDD, 0x10, 0x90, 0x4B, 0xB7]};
@GUID(0xF91D96C7, 0x8509, 0x4D0B, [0xAB, 0x26, 0xA0, 0xDD, 0x10, 0x90, 0x4B, 0xB7]);
struct Mpeg2Stream;

const GUID CLSID_Mpeg2Data = {0xC666E115, 0xBB62, 0x4027, [0xA1, 0x13, 0x82, 0xD6, 0x43, 0xFE, 0x2D, 0x99]};
@GUID(0xC666E115, 0xBB62, 0x4027, [0xA1, 0x13, 0x82, 0xD6, 0x43, 0xFE, 0x2D, 0x99]);
struct Mpeg2Data;

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0001
{
    ushort Bits;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0002
{
    ushort Bits;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0003
{
    ubyte Bits;
}

enum MPEG_CURRENT_NEXT_BIT
{
    MPEG_SECTION_IS_NEXT = 0,
    MPEG_SECTION_IS_CURRENT = 1,
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0005
{
    ushort wTidExt;
    ushort wCount;
}

struct SECTION
{
    ubyte TableId;
    _Header_e__Union Header;
    ubyte SectionData;
}

struct LONG_SECTION
{
    ubyte TableId;
    _Header_e__Union Header;
    ushort TableIdExtension;
    _Version_e__Union Version;
    ubyte SectionNumber;
    ubyte LastSectionNumber;
    ubyte RemainingData;
}

struct DSMCC_SECTION
{
    ubyte TableId;
    _Header_e__Union Header;
    ushort TableIdExtension;
    _Version_e__Union Version;
    ubyte SectionNumber;
    ubyte LastSectionNumber;
    ubyte ProtocolDiscriminator;
    ubyte DsmccType;
    ushort MessageId;
    uint TransactionId;
    ubyte Reserved;
    ubyte AdaptationLength;
    ushort MessageLength;
    ubyte RemainingData;
}

struct MPEG_RQST_PACKET
{
    uint dwLength;
    SECTION* pSection;
}

struct MPEG_PACKET_LIST
{
    ushort wPacketCount;
    MPEG_RQST_PACKET* PacketList;
}

struct DSMCC_FILTER_OPTIONS
{
    BOOL fSpecifyProtocol;
    ubyte Protocol;
    BOOL fSpecifyType;
    ubyte Type;
    BOOL fSpecifyMessageId;
    ushort MessageId;
    BOOL fSpecifyTransactionId;
    BOOL fUseTrxIdMessageIdMask;
    uint TransactionId;
    BOOL fSpecifyModuleVersion;
    ubyte ModuleVersion;
    BOOL fSpecifyBlockNumber;
    ushort BlockNumber;
    BOOL fGetModuleCall;
    ushort NumberOfBlocksInModule;
}

struct ATSC_FILTER_OPTIONS
{
    BOOL fSpecifyEtmId;
    uint EtmId;
}

struct DVB_EIT_FILTER_OPTIONS
{
    BOOL fSpecifySegment;
    ubyte bSegment;
}

struct MPEG2_FILTER
{
    ubyte bVersionNumber;
    ushort wFilterSize;
    BOOL fUseRawFilteringBits;
    ubyte Filter;
    ubyte Mask;
    BOOL fSpecifyTableIdExtension;
    ushort TableIdExtension;
    BOOL fSpecifyVersion;
    ubyte Version;
    BOOL fSpecifySectionNumber;
    ubyte SectionNumber;
    BOOL fSpecifyCurrentNext;
    BOOL fNext;
    BOOL fSpecifyDsmccOptions;
    DSMCC_FILTER_OPTIONS Dsmcc;
    BOOL fSpecifyAtscOptions;
    ATSC_FILTER_OPTIONS Atsc;
}

struct MPEG2_FILTER2
{
    _Anonymous_e__Union Anonymous;
    BOOL fSpecifyDvbEitOptions;
    DVB_EIT_FILTER_OPTIONS DvbEit;
}

struct MPEG_STREAM_BUFFER
{
    HRESULT hr;
    uint dwDataBufferSize;
    uint dwSizeOfDataRead;
    ubyte* pDataBuffer;
}

struct MPEG_TIME
{
    ubyte Hours;
    ubyte Minutes;
    ubyte Seconds;
}

struct MPEG_DATE
{
    ubyte Date;
    ubyte Month;
    ushort Year;
}

struct MPEG_DATE_AND_TIME
{
    MPEG_DATE D;
    MPEG_TIME T;
}

enum MPEG_CONTEXT_TYPE
{
    MPEG_CONTEXT_BCS_DEMUX = 0,
    MPEG_CONTEXT_WINSOCK = 1,
}

struct MPEG_BCS_DEMUX
{
    uint AVMGraphId;
}

struct MPEG_WINSOCK
{
    uint AVMGraphId;
}

struct MPEG_CONTEXT
{
    MPEG_CONTEXT_TYPE Type;
    _U_e__Union U;
}

enum MPEG_REQUEST_TYPE
{
    MPEG_RQST_UNKNOWN = 0,
    MPEG_RQST_GET_SECTION = 1,
    MPEG_RQST_GET_SECTION_ASYNC = 2,
    MPEG_RQST_GET_TABLE = 3,
    MPEG_RQST_GET_TABLE_ASYNC = 4,
    MPEG_RQST_GET_SECTIONS_STREAM = 5,
    MPEG_RQST_GET_PES_STREAM = 6,
    MPEG_RQST_GET_TS_STREAM = 7,
    MPEG_RQST_START_MPE_STREAM = 8,
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0033
{
    MPEG_REQUEST_TYPE Type;
    MPEG_CONTEXT Context;
    ushort Pid;
    ubyte TableId;
    MPEG2_FILTER Filter;
    uint Flags;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0034
{
    uint IPAddress;
    ushort Port;
}

struct DSMCC_ELEMENT
{
    ushort pid;
    ubyte bComponentTag;
    uint dwCarouselId;
    uint dwTransactionId;
    DSMCC_ELEMENT* pNext;
}

struct MPE_ELEMENT
{
    ushort pid;
    ubyte bComponentTag;
    MPE_ELEMENT* pNext;
}

struct MPEG_STREAM_FILTER
{
    ushort wPidValue;
    uint dwFilterSize;
    BOOL fCrcEnabled;
    ubyte rgchFilter;
    ubyte rgchMask;
}

const GUID IID_IMpeg2TableFilter = {0xBDCDD913, 0x9ECD, 0x4FB2, [0x81, 0xAE, 0xAD, 0xF7, 0x47, 0xEA, 0x75, 0xA5]};
@GUID(0xBDCDD913, 0x9ECD, 0x4FB2, [0x81, 0xAE, 0xAD, 0xF7, 0x47, 0xEA, 0x75, 0xA5]);
interface IMpeg2TableFilter : IUnknown
{
    HRESULT AddPID(ushort p);
    HRESULT AddTable(ushort p, ubyte t);
    HRESULT AddExtension(ushort p, ubyte t, ushort e);
    HRESULT RemovePID(ushort p);
    HRESULT RemoveTable(ushort p, ubyte t);
    HRESULT RemoveExtension(ushort p, ubyte t, ushort e);
}

struct Mpeg2TableSampleHdr
{
    ubyte SectionCount;
    ubyte Reserved;
    int SectionOffsets;
}

const GUID CLSID_Mpeg2DataLib = {0xDBAF6C1B, 0xB6A4, 0x4898, [0xAE, 0x65, 0x20, 0x4F, 0x0D, 0x95, 0x09, 0xA1]};
@GUID(0xDBAF6C1B, 0xB6A4, 0x4898, [0xAE, 0x65, 0x20, 0x4F, 0x0D, 0x95, 0x09, 0xA1]);
struct Mpeg2DataLib;

const GUID IID_IMpeg2Data = {0x9B396D40, 0xF380, 0x4E3C, [0xA5, 0x14, 0x1A, 0x82, 0xBF, 0x6E, 0xBF, 0xE6]};
@GUID(0x9B396D40, 0xF380, 0x4E3C, [0xA5, 0x14, 0x1A, 0x82, 0xBF, 0x6E, 0xBF, 0xE6]);
interface IMpeg2Data : IUnknown
{
    HRESULT GetSection(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, uint dwTimeout, ISectionList* ppSectionList);
    HRESULT GetTable(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, uint dwTimeout, ISectionList* ppSectionList);
    HRESULT GetStreamOfSections(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, HANDLE hDataReadyEvent, IMpeg2Stream* ppMpegStream);
}

const GUID IID_ISectionList = {0xAFEC1EB5, 0x2A64, 0x46C6, [0xBF, 0x4B, 0xAE, 0x3C, 0xCB, 0x6A, 0xFD, 0xB0]};
@GUID(0xAFEC1EB5, 0x2A64, 0x46C6, [0xBF, 0x4B, 0xAE, 0x3C, 0xCB, 0x6A, 0xFD, 0xB0]);
interface ISectionList : IUnknown
{
    HRESULT Initialize(MPEG_REQUEST_TYPE requestType, IMpeg2Data pMpeg2Data, MPEG_CONTEXT* pContext, ushort pid, ubyte tid, MPEG2_FILTER* pFilter, uint timeout, HANDLE hDoneEvent);
    HRESULT InitializeWithRawSections(MPEG_PACKET_LIST* pmplSections);
    HRESULT CancelPendingRequest();
    HRESULT GetNumberOfSections(ushort* pCount);
    HRESULT GetSectionData(ushort sectionNumber, uint* pdwRawPacketLength, SECTION** ppSection);
    HRESULT GetProgramIdentifier(ushort* pPid);
    HRESULT GetTableIdentifier(ubyte* pTableId);
}

const GUID IID_IMpeg2Stream = {0x400CC286, 0x32A0, 0x4CE4, [0x90, 0x41, 0x39, 0x57, 0x11, 0x25, 0xA6, 0x35]};
@GUID(0x400CC286, 0x32A0, 0x4CE4, [0x90, 0x41, 0x39, 0x57, 0x11, 0x25, 0xA6, 0x35]);
interface IMpeg2Stream : IUnknown
{
    HRESULT Initialize(MPEG_REQUEST_TYPE requestType, IMpeg2Data pMpeg2Data, MPEG_CONTEXT* pContext, ushort pid, ubyte tid, MPEG2_FILTER* pFilter, HANDLE hDataReadyEvent);
    HRESULT SupplyDataBuffer(MPEG_STREAM_BUFFER* pStreamBuffer);
}

const GUID IID_IGenericDescriptor = {0x6A5918F8, 0xA77A, 0x4F61, [0xAE, 0xD0, 0x57, 0x02, 0xBD, 0xCD, 0xA3, 0xE6]};
@GUID(0x6A5918F8, 0xA77A, 0x4F61, [0xAE, 0xD0, 0x57, 0x02, 0xBD, 0xCD, 0xA3, 0xE6]);
interface IGenericDescriptor : IUnknown
{
    HRESULT Initialize(ubyte* pbDesc, int bCount);
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetBody(ubyte** ppbVal);
}

const GUID IID_IGenericDescriptor2 = {0xBF02FB7E, 0x9792, 0x4E10, [0xA6, 0x8D, 0x03, 0x3A, 0x2C, 0xC2, 0x46, 0xA5]};
@GUID(0xBF02FB7E, 0x9792, 0x4E10, [0xA6, 0x8D, 0x03, 0x3A, 0x2C, 0xC2, 0x46, 0xA5]);
interface IGenericDescriptor2 : IGenericDescriptor
{
    HRESULT Initialize(ubyte* pbDesc, ushort wCount);
    HRESULT GetLength(ushort* pwVal);
}

struct __MIDL_IPAT_0001
{
    ushort wProgramNumber;
    ushort wProgramMapPID;
}

const GUID IID_IPAT = {0x6623B511, 0x4B5F, 0x43C3, [0x9A, 0x01, 0xE8, 0xFF, 0x84, 0x18, 0x80, 0x60]};
@GUID(0x6623B511, 0x4B5F, 0x43C3, [0x9A, 0x01, 0xE8, 0xFF, 0x84, 0x18, 0x80, 0x60]);
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

const GUID IID_ICAT = {0x7C6995FB, 0x2A31, 0x4BD7, [0x95, 0x3E, 0xB1, 0xAD, 0x7F, 0xB7, 0xD3, 0x1C]};
@GUID(0x7C6995FB, 0x2A31, 0x4BD7, [0x95, 0x3E, 0xB1, 0xAD, 0x7F, 0xB7, 0xD3, 0x1C]);
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

const GUID IID_IPMT = {0x01F3B398, 0x9527, 0x4736, [0x94, 0xDB, 0x51, 0x95, 0x87, 0x8E, 0x97, 0xA8]};
@GUID(0x01F3B398, 0x9527, 0x4736, [0x94, 0xDB, 0x51, 0x95, 0x87, 0x8E, 0x97, 0xA8]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT QueryServiceGatewayInfo(DSMCC_ELEMENT** ppDSMCCList, uint* puiCount);
    HRESULT QueryMPEInfo(MPE_ELEMENT** ppMPEList, uint* puiCount);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IPMT* ppPMT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

const GUID IID_ITSDT = {0xD19BDB43, 0x405B, 0x4A7C, [0xA7, 0x91, 0xC8, 0x91, 0x10, 0xC3, 0x31, 0x65]};
@GUID(0xD19BDB43, 0x405B, 0x4A7C, [0xA7, 0x91, 0xC8, 0x91, 0x10, 0xC3, 0x31, 0x65]);
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

const GUID IID_IPSITables = {0x919F24C5, 0x7B14, 0x42AC, [0xA4, 0xB0, 0x2A, 0xE0, 0x8D, 0xAF, 0x00, 0xAC]};
@GUID(0x919F24C5, 0x7B14, 0x42AC, [0xA4, 0xB0, 0x2A, 0xE0, 0x8D, 0xAF, 0x00, 0xAC]);
interface IPSITables : IUnknown
{
    HRESULT GetTable(uint dwTSID, uint dwTID_PID, uint dwHashedVer, uint dwPara4, IUnknown* ppIUnknown);
}

const GUID IID_IAtscPsipParser = {0xB2C98995, 0x5EB2, 0x4FB1, [0xB4, 0x06, 0xF3, 0xE8, 0xE2, 0x02, 0x6A, 0x9A]};
@GUID(0xB2C98995, 0x5EB2, 0x4FB1, [0xB4, 0x06, 0xF3, 0xE8, 0xE2, 0x02, 0x6A, 0x9A]);
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

const GUID IID_IATSC_MGT = {0x8877DABD, 0xC137, 0x4073, [0x97, 0xE3, 0x77, 0x94, 0x07, 0xA5, 0xD8, 0x7A]};
@GUID(0x8877DABD, 0xC137, 0x4073, [0x97, 0xE3, 0x77, 0x94, 0x07, 0xA5, 0xD8, 0x7A]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

const GUID IID_IATSC_VCT = {0x26879A18, 0x32F9, 0x46C6, [0x91, 0xF0, 0xFB, 0x64, 0x79, 0x27, 0x0E, 0x8C]};
@GUID(0x26879A18, 0x32F9, 0x46C6, [0x91, 0xF0, 0xFB, 0x64, 0x79, 0x27, 0x0E, 0x8C]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

const GUID IID_IATSC_EIT = {0xD7C212D7, 0x76A2, 0x4B4B, [0xAA, 0x56, 0x84, 0x68, 0x79, 0xA8, 0x00, 0x96]};
@GUID(0xD7C212D7, 0x76A2, 0x4B4B, [0xAA, 0x56, 0x84, 0x68, 0x79, 0xA8, 0x00, 0x96]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

const GUID IID_IATSC_ETT = {0x5A142CC9, 0xB8CF, 0x4A86, [0xA0, 0x40, 0xE9, 0xCA, 0xDF, 0x3E, 0xF3, 0xE7]};
@GUID(0x5A142CC9, 0xB8CF, 0x4A86, [0xA0, 0x40, 0xE9, 0xCA, 0xDF, 0x3E, 0xF3, 0xE7]);
interface IATSC_ETT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetProtocolVersion(ubyte* pbVal);
    HRESULT GetEtmId(uint* pdwVal);
    HRESULT GetExtendedMessageText(uint* pdwLength, ubyte** ppText);
}

const GUID IID_IATSC_STT = {0x6BF42423, 0x217D, 0x4D6F, [0x81, 0xE1, 0x3A, 0x7B, 0x36, 0x0E, 0xC8, 0x96]};
@GUID(0x6BF42423, 0x217D, 0x4D6F, [0x81, 0xE1, 0x3A, 0x7B, 0x36, 0x0E, 0xC8, 0x96]);
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

const GUID IID_ISCTE_EAS = {0x1FF544D6, 0x161D, 0x4FAE, [0x9F, 0xAA, 0x4F, 0x9F, 0x49, 0x2A, 0xE9, 0x99]};
@GUID(0x1FF544D6, 0x161D, 0x4FAE, [0x9F, 0xAA, 0x4F, 0x9F, 0x49, 0x2A, 0xE9, 0x99]);
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

const GUID IID_IAtscContentAdvisoryDescriptor = {0xFF76E60C, 0x0283, 0x43EA, [0xBA, 0x32, 0xB4, 0x22, 0x23, 0x85, 0x47, 0xEE]};
@GUID(0xFF76E60C, 0x0283, 0x43EA, [0xBA, 0x32, 0xB4, 0x22, 0x23, 0x85, 0x47, 0xEE]);
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

const GUID IID_ICaptionServiceDescriptor = {0x40834007, 0x6834, 0x46F0, [0xBD, 0x45, 0xD5, 0xF6, 0xA6, 0xBE, 0x25, 0x8C]};
@GUID(0x40834007, 0x6834, 0x46F0, [0xBD, 0x45, 0xD5, 0xF6, 0xA6, 0xBE, 0x25, 0x8C]);
interface ICaptionServiceDescriptor : IUnknown
{
    HRESULT GetNumberOfServices(ubyte* pbVal);
    HRESULT GetLanguageCode(ubyte bIndex, char* LangCode);
    HRESULT GetCaptionServiceNumber(ubyte bIndex, ubyte* pbVal);
    HRESULT GetCCType(ubyte bIndex, ubyte* pbVal);
    HRESULT GetEasyReader(ubyte bIndex, ubyte* pbVal);
    HRESULT GetWideAspectRatio(ubyte bIndex, ubyte* pbVal);
}

const GUID IID_IServiceLocationDescriptor = {0x58C3C827, 0x9D91, 0x4215, [0xBF, 0xF3, 0x82, 0x0A, 0x49, 0xF0, 0x90, 0x4C]};
@GUID(0x58C3C827, 0x9D91, 0x4215, [0xBF, 0xF3, 0x82, 0x0A, 0x49, 0xF0, 0x90, 0x4C]);
interface IServiceLocationDescriptor : IUnknown
{
    HRESULT GetPCR_PID(ushort* pwVal);
    HRESULT GetNumberOfElements(ubyte* pbVal);
    HRESULT GetElementStreamType(ubyte bIndex, ubyte* pbVal);
    HRESULT GetElementPID(ubyte bIndex, ushort* pwVal);
    HRESULT GetElementLanguageCode(ubyte bIndex, char* LangCode);
}

const GUID IID_IAttributeSet = {0x583EC3CC, 0x4960, 0x4857, [0x98, 0x2B, 0x41, 0xA3, 0x3E, 0xA0, 0xA0, 0x06]};
@GUID(0x583EC3CC, 0x4960, 0x4857, [0x98, 0x2B, 0x41, 0xA3, 0x3E, 0xA0, 0xA0, 0x06]);
interface IAttributeSet : IUnknown
{
    HRESULT SetAttrib(Guid guidAttribute, ubyte* pbAttribute, uint dwAttributeLength);
}

const GUID IID_IAttributeGet = {0x52DBD1EC, 0xE48F, 0x4528, [0x92, 0x32, 0xF4, 0x42, 0xA6, 0x8F, 0x0A, 0xE1]};
@GUID(0x52DBD1EC, 0xE48F, 0x4528, [0x92, 0x32, 0xF4, 0x42, 0xA6, 0x8F, 0x0A, 0xE1]);
interface IAttributeGet : IUnknown
{
    HRESULT GetCount(int* plCount);
    HRESULT GetAttribIndexed(int lIndex, Guid* pguidAttribute, ubyte* pbAttribute, uint* pdwAttributeLength);
    HRESULT GetAttrib(Guid guidAttribute, ubyte* pbAttribute, uint* pdwAttributeLength);
}

struct UDCR_TAG
{
    ubyte bVersion;
    ubyte KID;
    ulong ullBaseCounter;
    ulong ullBaseCounterRange;
    BOOL fScrambled;
    ubyte bStreamMark;
    uint dwReserved1;
    uint dwReserved2;
}

struct PIC_SEQ_SAMPLE
{
    uint _bitfield;
}

struct SAMPLE_SEQ_OFFSET
{
    uint _bitfield;
}

enum VA_VIDEO_FORMAT
{
    VA_VIDEO_COMPONENT = 0,
    VA_VIDEO_PAL = 1,
    VA_VIDEO_NTSC = 2,
    VA_VIDEO_SECAM = 3,
    VA_VIDEO_MAC = 4,
    VA_VIDEO_UNSPECIFIED = 5,
}

enum VA_COLOR_PRIMARIES
{
    VA_PRIMARIES_ITU_R_BT_709 = 1,
    VA_PRIMARIES_UNSPECIFIED = 2,
    VA_PRIMARIES_ITU_R_BT_470_SYSTEM_M = 4,
    VA_PRIMARIES_ITU_R_BT_470_SYSTEM_B_G = 5,
    VA_PRIMARIES_SMPTE_170M = 6,
    VA_PRIMARIES_SMPTE_240M = 7,
    VA_PRIMARIES_H264_GENERIC_FILM = 8,
}

enum VA_TRANSFER_CHARACTERISTICS
{
    VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_709 = 1,
    VA_TRANSFER_CHARACTERISTICS_UNSPECIFIED = 2,
    VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_470_SYSTEM_M = 4,
    VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_470_SYSTEM_B_G = 5,
    VA_TRANSFER_CHARACTERISTICS_SMPTE_170M = 6,
    VA_TRANSFER_CHARACTERISTICS_SMPTE_240M = 7,
    VA_TRANSFER_CHARACTERISTICS_LINEAR = 8,
    VA_TRANSFER_CHARACTERISTICS_H264_LOG_100_TO_1 = 9,
    VA_TRANSFER_CHARACTERISTICS_H264_LOG_316_TO_1 = 10,
}

enum VA_MATRIX_COEFFICIENTS
{
    VA_MATRIX_COEFF_H264_RGB = 0,
    VA_MATRIX_COEFF_ITU_R_BT_709 = 1,
    VA_MATRIX_COEFF_UNSPECIFIED = 2,
    VA_MATRIX_COEFF_FCC = 4,
    VA_MATRIX_COEFF_ITU_R_BT_470_SYSTEM_B_G = 5,
    VA_MATRIX_COEFF_SMPTE_170M = 6,
    VA_MATRIX_COEFF_SMPTE_240M = 7,
    VA_MATRIX_COEFF_H264_YCgCo = 8,
}

struct VA_OPTIONAL_VIDEO_PROPERTIES
{
    ushort dwPictureHeight;
    ushort dwPictureWidth;
    ushort dwAspectRatioX;
    ushort dwAspectRatioY;
    VA_VIDEO_FORMAT VAVideoFormat;
    VA_COLOR_PRIMARIES VAColorPrimaries;
    VA_TRANSFER_CHARACTERISTICS VATransferCharacteristics;
    VA_MATRIX_COEFFICIENTS VAMatrixCoefficients;
}

struct TRANSPORT_PROPERTIES
{
    uint PID;
    long PCR;
    _Fields_e__Union Fields;
}

struct PBDA_TAG_ATTRIBUTE
{
    Guid TableUUId;
    ubyte TableId;
    ushort VersionNo;
    uint TableDataSize;
    ubyte TableData;
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

const GUID CLSID_TIFLoad = {0x14EB8748, 0x1753, 0x4393, [0x95, 0xAE, 0x4F, 0x7E, 0x7A, 0x87, 0xAA, 0xD6]};
@GUID(0x14EB8748, 0x1753, 0x4393, [0x95, 0xAE, 0x4F, 0x7E, 0x7A, 0x87, 0xAA, 0xD6]);
struct TIFLoad;

enum __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001
{
    STRCONV_MODE_DVB = 0,
    STRCONV_MODE_DVB_EMPHASIS = 1,
    STRCONV_MODE_DVB_WITHOUT_EMPHASIS = 2,
    STRCONV_MODE_ISDB = 3,
}

const GUID IID_IDvbSiParser = {0xB758A7BD, 0x14DC, 0x449D, [0xB8, 0x28, 0x35, 0x90, 0x9A, 0xCB, 0x3B, 0x1E]};
@GUID(0xB758A7BD, 0x14DC, 0x449D, [0xB8, 0x28, 0x35, 0x90, 0x9A, 0xCB, 0x3B, 0x1E]);
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

const GUID IID_IDvbSiParser2 = {0x0AC5525F, 0xF816, 0x42F4, [0x93, 0xBA, 0x4C, 0x0F, 0x32, 0xF4, 0x6E, 0x54]};
@GUID(0x0AC5525F, 0xF816, 0x42F4, [0x93, 0xBA, 0x4C, 0x0F, 0x32, 0xF4, 0x6E, 0x54]);
interface IDvbSiParser2 : IDvbSiParser
{
    HRESULT GetEIT2(ubyte tableId, ushort* pwServiceId, ubyte* pbSegment, IDVB_EIT2* ppEIT);
}

const GUID IID_IIsdbSiParser2 = {0x900E4BB7, 0x18CD, 0x453F, [0x98, 0xBE, 0x3B, 0xE6, 0xAA, 0x21, 0x17, 0x72]};
@GUID(0x900E4BB7, 0x18CD, 0x453F, [0x98, 0xBE, 0x3B, 0xE6, 0xAA, 0x21, 0x17, 0x72]);
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

const GUID IID_IDVB_NIT = {0xC64935F4, 0x29E4, 0x4E22, [0x91, 0x1A, 0x63, 0xF7, 0xF5, 0x5C, 0xB0, 0x97]};
@GUID(0xC64935F4, 0x29E4, 0x4E22, [0x91, 0x1A, 0x63, 0xF7, 0xF5, 0x5C, 0xB0, 0x97]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_NIT* ppNIT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

const GUID IID_IDVB_SDT = {0x02CAD8D3, 0xFE43, 0x48E2, [0x90, 0xBD, 0x45, 0x0E, 0xD9, 0xA8, 0xA5, 0xFD]};
@GUID(0x02CAD8D3, 0xFE43, 0x48E2, [0x90, 0xBD, 0x45, 0x0E, 0xD9, 0xA8, 0xA5, 0xFD]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_SDT* ppSDT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

const GUID IID_IISDB_SDT = {0x3F3DC9A2, 0xBB32, 0x4FB9, [0xAE, 0x9E, 0xD8, 0x56, 0x84, 0x89, 0x27, 0xA3]};
@GUID(0x3F3DC9A2, 0xBB32, 0x4FB9, [0xAE, 0x9E, 0xD8, 0x56, 0x84, 0x89, 0x27, 0xA3]);
interface IISDB_SDT : IDVB_SDT
{
    HRESULT GetRecordEITUserDefinedFlags(uint dwRecordIndex, ubyte* pbVal);
}

const GUID IID_IDVB_EIT = {0x442DB029, 0x02CB, 0x4495, [0x8B, 0x92, 0x1C, 0x13, 0x37, 0x5B, 0xCE, 0x99]};
@GUID(0x442DB029, 0x02CB, 0x4495, [0x8B, 0x92, 0x1C, 0x13, 0x37, 0x5B, 0xCE, 0x99]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_EIT* ppEIT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

const GUID IID_IDVB_EIT2 = {0x61A389E0, 0x9B9E, 0x4BA0, [0xAE, 0xEA, 0x5D, 0xDD, 0x15, 0x98, 0x20, 0xEA]};
@GUID(0x61A389E0, 0x9B9E, 0x4BA0, [0xAE, 0xEA, 0x5D, 0xDD, 0x15, 0x98, 0x20, 0xEA]);
interface IDVB_EIT2 : IDVB_EIT
{
    HRESULT GetSegmentInfo(ubyte* pbTid, ubyte* pbSegment);
    HRESULT GetRecordSection(uint dwRecordIndex, ubyte* pbVal);
}

const GUID IID_IDVB_BAT = {0xECE9BB0C, 0x43B6, 0x4558, [0xA0, 0xEC, 0x18, 0x12, 0xC3, 0x4C, 0xD6, 0xCA]};
@GUID(0xECE9BB0C, 0x43B6, 0x4558, [0xA0, 0xEC, 0x18, 0x12, 0xC3, 0x4C, 0xD6, 0xCA]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_BAT* ppBAT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

const GUID IID_IDVB_RST = {0xF47DCD04, 0x1E23, 0x4FB7, [0x9F, 0x96, 0xB4, 0x0E, 0xEA, 0xD1, 0x0B, 0x2B]};
@GUID(0xF47DCD04, 0x1E23, 0x4FB7, [0x9F, 0x96, 0xB4, 0x0E, 0xEA, 0xD1, 0x0B, 0x2B]);
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

const GUID IID_IDVB_ST = {0x4D5B9F23, 0x2A02, 0x45DE, [0xBC, 0xDA, 0x5D, 0x5D, 0xBF, 0xBF, 0xBE, 0x62]};
@GUID(0x4D5B9F23, 0x2A02, 0x45DE, [0xBC, 0xDA, 0x5D, 0x5D, 0xBF, 0xBF, 0xBE, 0x62]);
interface IDVB_ST : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetDataLength(ushort* pwVal);
    HRESULT GetData(ubyte** ppData);
}

const GUID IID_IDVB_TDT = {0x0780DC7D, 0xD55C, 0x4AEF, [0x97, 0xE6, 0x6B, 0x75, 0x90, 0x6E, 0x27, 0x96]};
@GUID(0x0780DC7D, 0xD55C, 0x4AEF, [0x97, 0xE6, 0x6B, 0x75, 0x90, 0x6E, 0x27, 0x96]);
interface IDVB_TDT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetUTCTime(MPEG_DATE_AND_TIME* pmdtVal);
}

const GUID IID_IDVB_TOT = {0x83295D6A, 0xFABA, 0x4EE1, [0x9B, 0x15, 0x80, 0x67, 0x69, 0x69, 0x10, 0xAE]};
@GUID(0x83295D6A, 0xFABA, 0x4EE1, [0x9B, 0x15, 0x80, 0x67, 0x69, 0x69, 0x10, 0xAE]);
interface IDVB_TOT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetUTCTime(MPEG_DATE_AND_TIME* pmdtVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

const GUID IID_IDVB_DIT = {0x91BFFDF9, 0x9432, 0x410F, [0x86, 0xEF, 0x1C, 0x22, 0x8E, 0xD0, 0xAD, 0x70]};
@GUID(0x91BFFDF9, 0x9432, 0x410F, [0x86, 0xEF, 0x1C, 0x22, 0x8E, 0xD0, 0xAD, 0x70]);
interface IDVB_DIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetTransitionFlag(int* pfVal);
}

const GUID IID_IDVB_SIT = {0x68CDCE53, 0x8BEA, 0x45C2, [0x9D, 0x9D, 0xAC, 0xF5, 0x75, 0xA0, 0x89, 0xB5]};
@GUID(0x68CDCE53, 0x8BEA, 0x45C2, [0x9D, 0x9D, 0xAC, 0xF5, 0x75, 0xA0, 0x89, 0xB5]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(uint dwTimeout, IDVB_SIT* ppSIT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

const GUID IID_IISDB_BIT = {0x537CD71E, 0x0E46, 0x4173, [0x90, 0x01, 0xBA, 0x04, 0x3F, 0x3E, 0x49, 0xE2]};
@GUID(0x537CD71E, 0x0E46, 0x4173, [0x90, 0x01, 0xBA, 0x04, 0x3F, 0x3E, 0x49, 0xE2]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

const GUID IID_IISDB_NBIT = {0x1B1863EF, 0x08F1, 0x40B7, [0xA5, 0x59, 0x3B, 0x1E, 0xFF, 0x8C, 0xAF, 0xA6]};
@GUID(0x1B1863EF, 0x08F1, 0x40B7, [0xA5, 0x59, 0x3B, 0x1E, 0xFF, 0x8C, 0xAF, 0xA6]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

const GUID IID_IISDB_LDT = {0x141A546B, 0x02FF, 0x4FB9, [0xA3, 0xA3, 0x2F, 0x07, 0x4B, 0x74, 0xA9, 0xA9]};
@GUID(0x141A546B, 0x02FF, 0x4FB9, [0xA3, 0xA3, 0x2F, 0x07, 0x4B, 0x74, 0xA9, 0xA9]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

const GUID IID_IISDB_SDTT = {0xEE60EF2D, 0x813A, 0x4DC7, [0xBF, 0x92, 0xEA, 0x13, 0xDA, 0xC8, 0x53, 0x13]};
@GUID(0xEE60EF2D, 0x813A, 0x4DC7, [0xBF, 0x92, 0xEA, 0x13, 0xDA, 0xC8, 0x53, 0x13]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

const GUID IID_IISDB_CDT = {0x25FA92C2, 0x8B80, 0x4787, [0xA8, 0x41, 0x3A, 0x0E, 0x8F, 0x17, 0x98, 0x4B]};
@GUID(0x25FA92C2, 0x8B80, 0x4787, [0xA8, 0x41, 0x3A, 0x0E, 0x8F, 0x17, 0x98, 0x4B]);
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

const GUID IID_IISDB_EMM = {0x0EDB556D, 0x43AD, 0x4938, [0x96, 0x68, 0x32, 0x1B, 0x2F, 0xFE, 0xCF, 0xD3]};
@GUID(0x0EDB556D, 0x43AD, 0x4938, [0x96, 0x68, 0x32, 0x1B, 0x2F, 0xFE, 0xCF, 0xD3]);
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

const GUID IID_IDvbServiceAttributeDescriptor = {0x0F37BD92, 0xD6A1, 0x4854, [0xB9, 0x50, 0x3A, 0x96, 0x9D, 0x27, 0xF3, 0x0E]};
@GUID(0x0F37BD92, 0xD6A1, 0x4854, [0xB9, 0x50, 0x3A, 0x96, 0x9D, 0x27, 0xF3, 0x0E]);
interface IDvbServiceAttributeDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordNumericSelectionFlag(ubyte bRecordIndex, int* pfVal);
    HRESULT GetRecordVisibleServiceFlag(ubyte bRecordIndex, int* pfVal);
}

enum __MIDL___MIDL_itf_dvbsiparser_0000_0022_0001
{
    CRID_LOCATION_IN_DESCRIPTOR = 0,
    CRID_LOCATION_IN_CIT = 1,
    CRID_LOCATION_DVB_RESERVED1 = 2,
    CRID_LOCATION_DVB_RESERVED2 = 3,
}

const GUID IID_IDvbContentIdentifierDescriptor = {0x05E0C1EA, 0xF661, 0x4053, [0x9F, 0xBF, 0xD9, 0x3B, 0x28, 0x35, 0x98, 0x38]};
@GUID(0x05E0C1EA, 0xF661, 0x4053, [0x9F, 0xBF, 0xD9, 0x3B, 0x28, 0x35, 0x98, 0x38]);
interface IDvbContentIdentifierDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordCrid(ubyte bRecordIndex, ubyte* pbType, ubyte* pbLocation, ubyte* pbLength, ubyte** ppbBytes);
}

const GUID IID_IDvbDefaultAuthorityDescriptor = {0x05EC24D1, 0x3A31, 0x44E7, [0xB4, 0x08, 0x67, 0xC6, 0x0A, 0x35, 0x22, 0x76]};
@GUID(0x05EC24D1, 0x3A31, 0x44E7, [0xB4, 0x08, 0x67, 0xC6, 0x0A, 0x35, 0x22, 0x76]);
interface IDvbDefaultAuthorityDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDefaultAuthority(ubyte* pbLength, ubyte** ppbBytes);
}

const GUID IID_IDvbSatelliteDeliverySystemDescriptor = {0x02F2225A, 0x805B, 0x4EC5, [0xA9, 0xA6, 0xF9, 0xB5, 0x91, 0x3C, 0xD4, 0x70]};
@GUID(0x02F2225A, 0x805B, 0x4EC5, [0xA9, 0xA6, 0xF9, 0xB5, 0x91, 0x3C, 0xD4, 0x70]);
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

const GUID IID_IDvbCableDeliverySystemDescriptor = {0xDFB98E36, 0x9E1A, 0x4862, [0x99, 0x46, 0x99, 0x3A, 0x4E, 0x59, 0x01, 0x7B]};
@GUID(0xDFB98E36, 0x9E1A, 0x4862, [0x99, 0x46, 0x99, 0x3A, 0x4E, 0x59, 0x01, 0x7B]);
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

const GUID IID_IDvbTerrestrialDeliverySystemDescriptor = {0xED7E1B91, 0xD12E, 0x420C, [0xB4, 0x1D, 0xA4, 0x9D, 0x84, 0xFE, 0x18, 0x23]};
@GUID(0xED7E1B91, 0xD12E, 0x420C, [0xB4, 0x1D, 0xA4, 0x9D, 0x84, 0xFE, 0x18, 0x23]);
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

const GUID IID_IDvbTerrestrial2DeliverySystemDescriptor = {0x20EE9BE9, 0xCD57, 0x49AB, [0x8F, 0x6E, 0x1D, 0x07, 0xAE, 0xB8, 0xE4, 0x82]};
@GUID(0x20EE9BE9, 0xCD57, 0x49AB, [0x8F, 0x6E, 0x1D, 0x07, 0xAE, 0xB8, 0xE4, 0x82]);
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

const GUID IID_IDvbFrequencyListDescriptor = {0x1CADB613, 0xE1DD, 0x4512, [0xAF, 0xA8, 0xBB, 0x7A, 0x00, 0x7E, 0xF8, 0xB1]};
@GUID(0x1CADB613, 0xE1DD, 0x4512, [0xAF, 0xA8, 0xBB, 0x7A, 0x00, 0x7E, 0xF8, 0xB1]);
interface IDvbFrequencyListDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCodingType(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordCentreFrequency(ubyte bRecordIndex, uint* pdwVal);
}

const GUID IID_IDvbPrivateDataSpecifierDescriptor = {0x5660A019, 0xE75A, 0x4B82, [0x9B, 0x4C, 0xED, 0x22, 0x56, 0xD1, 0x65, 0xA2]};
@GUID(0x5660A019, 0xE75A, 0x4B82, [0x9B, 0x4C, 0xED, 0x22, 0x56, 0xD1, 0x65, 0xA2]);
interface IDvbPrivateDataSpecifierDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetPrivateDataSpecifier(uint* pdwVal);
}

const GUID IID_IDvbLogicalChannelDescriptor = {0xCF1EDAFF, 0x3FFD, 0x4CF7, [0x82, 0x01, 0x35, 0x75, 0x6A, 0xCB, 0xF8, 0x5F]};
@GUID(0xCF1EDAFF, 0x3FFD, 0x4CF7, [0x82, 0x01, 0x35, 0x75, 0x6A, 0xCB, 0xF8, 0x5F]);
interface IDvbLogicalChannelDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordLogicalChannelNumber(ubyte bRecordIndex, ushort* pwVal);
}

const GUID IID_IDvbLogicalChannelDescriptor2 = {0x43ACA974, 0x4BE8, 0x4B98, [0xBC, 0x17, 0x9E, 0xAF, 0xD7, 0x88, 0xB1, 0xD7]};
@GUID(0x43ACA974, 0x4BE8, 0x4B98, [0xBC, 0x17, 0x9E, 0xAF, 0xD7, 0x88, 0xB1, 0xD7]);
interface IDvbLogicalChannelDescriptor2 : IDvbLogicalChannelDescriptor
{
    HRESULT GetRecordLogicalChannelAndVisibility(ubyte bRecordIndex, ushort* pwVal);
}

const GUID IID_IDvbLogicalChannel2Descriptor = {0xF69C3747, 0x8A30, 0x4980, [0x99, 0x8C, 0x01, 0xFE, 0x7F, 0x0B, 0xA3, 0x5A]};
@GUID(0xF69C3747, 0x8A30, 0x4980, [0x99, 0x8C, 0x01, 0xFE, 0x7F, 0x0B, 0xA3, 0x5A]);
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

const GUID IID_IDvbHDSimulcastLogicalChannelDescriptor = {0x1EA8B738, 0xA307, 0x4680, [0x9E, 0x26, 0xD0, 0xA9, 0x08, 0xC8, 0x24, 0xF4]};
@GUID(0x1EA8B738, 0xA307, 0x4680, [0x9E, 0x26, 0xD0, 0xA9, 0x08, 0xC8, 0x24, 0xF4]);
interface IDvbHDSimulcastLogicalChannelDescriptor : IDvbLogicalChannelDescriptor2
{
}

const GUID IID_IDvbDataBroadcastIDDescriptor = {0x5F26F518, 0x65C8, 0x4048, [0x91, 0xF2, 0x92, 0x90, 0xF5, 0x9F, 0x7B, 0x90]};
@GUID(0x5F26F518, 0x65C8, 0x4048, [0x91, 0xF2, 0x92, 0x90, 0xF5, 0x9F, 0x7B, 0x90]);
interface IDvbDataBroadcastIDDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDataBroadcastID(ushort* pwVal);
    HRESULT GetIDSelectorBytes(ubyte* pbLen, ubyte* pbVal);
}

const GUID IID_IDvbDataBroadcastDescriptor = {0xD1EBC1D6, 0x8B60, 0x4C20, [0x9C, 0xAF, 0xE5, 0x93, 0x82, 0xE7, 0xC4, 0x00]};
@GUID(0xD1EBC1D6, 0x8B60, 0x4C20, [0x9C, 0xAF, 0xE5, 0x93, 0x82, 0xE7, 0xC4, 0x00]);
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

enum __MIDL___MIDL_itf_dvbsiparser_0000_0036_0001
{
    DESC_LINKAGE_RESERVED0 = 0,
    DESC_LINKAGE_INFORMATION = 1,
    DESC_LINKAGE_EPG = 2,
    DESC_LINKAGE_CA_REPLACEMENT = 3,
    DESC_LINKAGE_COMPLETE_NET_BOUQUET_SI = 4,
    DESC_LINKAGE_REPLACEMENT = 5,
    DESC_LINKAGE_DATA = 6,
    DESC_LINKAGE_RESERVED1 = 7,
    DESC_LINKAGE_USER = 8,
    DESC_LINKAGE_RESERVED2 = 255,
}

const GUID IID_IDvbLinkageDescriptor = {0x1CDF8B31, 0x994A, 0x46FC, [0xAC, 0xFD, 0x6A, 0x6B, 0xE8, 0x93, 0x4D, 0xD5]};
@GUID(0x1CDF8B31, 0x994A, 0x46FC, [0xAC, 0xFD, 0x6A, 0x6B, 0xE8, 0x93, 0x4D, 0xD5]);
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

const GUID IID_IDvbTeletextDescriptor = {0x9CD29D47, 0x69C6, 0x4F92, [0x98, 0xA9, 0x21, 0x0A, 0xF1, 0xB7, 0x30, 0x3A]};
@GUID(0x9CD29D47, 0x69C6, 0x4F92, [0x98, 0xA9, 0x21, 0x0A, 0xF1, 0xB7, 0x30, 0x3A]);
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

const GUID IID_IDvbSubtitlingDescriptor = {0x9B25FE1D, 0xFA23, 0x4E50, [0x97, 0x84, 0x6D, 0xF8, 0xB2, 0x6F, 0x8A, 0x49]};
@GUID(0x9B25FE1D, 0xFA23, 0x4E50, [0x97, 0x84, 0x6D, 0xF8, 0xB2, 0x6F, 0x8A, 0x49]);
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

const GUID IID_IDvbServiceDescriptor = {0xF9C7FBCF, 0xE2D6, 0x464D, [0xB3, 0x2D, 0x2E, 0xF5, 0x26, 0xE4, 0x92, 0x90]};
@GUID(0xF9C7FBCF, 0xE2D6, 0x464D, [0xB3, 0x2D, 0x2E, 0xF5, 0x26, 0xE4, 0x92, 0x90]);
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

const GUID IID_IDvbServiceDescriptor2 = {0xD6C76506, 0x85AB, 0x487C, [0x9B, 0x2B, 0x36, 0x41, 0x65, 0x11, 0xE4, 0xA2]};
@GUID(0xD6C76506, 0x85AB, 0x487C, [0x9B, 0x2B, 0x36, 0x41, 0x65, 0x11, 0xE4, 0xA2]);
interface IDvbServiceDescriptor2 : IDvbServiceDescriptor
{
    HRESULT GetServiceProviderNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetServiceNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

const GUID IID_IDvbServiceListDescriptor = {0x05DB0D8F, 0x6008, 0x491A, [0xAC, 0xD3, 0x70, 0x90, 0x95, 0x27, 0x07, 0xD0]};
@GUID(0x05DB0D8F, 0x6008, 0x491A, [0xAC, 0xD3, 0x70, 0x90, 0x95, 0x27, 0x07, 0xD0]);
interface IDvbServiceListDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordServiceType(ubyte bRecordIndex, ubyte* pbVal);
}

const GUID IID_IDvbMultilingualServiceNameDescriptor = {0x2D80433B, 0xB32C, 0x47EF, [0x98, 0x7F, 0xE7, 0x8E, 0xBB, 0x77, 0x3E, 0x34]};
@GUID(0x2D80433B, 0xB32C, 0x47EF, [0x98, 0x7F, 0xE7, 0x8E, 0xBB, 0x77, 0x3E, 0x34]);
interface IDvbMultilingualServiceNameDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordLangId(ubyte bRecordIndex, uint* ulVal);
    HRESULT GetRecordServiceProviderNameW(ubyte bRecordIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetRecordServiceNameW(ubyte bRecordIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

const GUID IID_IDvbNetworkNameDescriptor = {0x5B2A80CF, 0x35B9, 0x446C, [0xB3, 0xE4, 0x04, 0x8B, 0x76, 0x1D, 0xBC, 0x51]};
@GUID(0x5B2A80CF, 0x35B9, 0x446C, [0xB3, 0xE4, 0x04, 0x8B, 0x76, 0x1D, 0xBC, 0x51]);
interface IDvbNetworkNameDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetNetworkName(byte** pszName);
    HRESULT GetNetworkNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

const GUID IID_IDvbShortEventDescriptor = {0xB170BE92, 0x5B75, 0x458E, [0x9C, 0x6E, 0xB0, 0x00, 0x82, 0x31, 0x49, 0x1A]};
@GUID(0xB170BE92, 0x5B75, 0x458E, [0x9C, 0x6E, 0xB0, 0x00, 0x82, 0x31, 0x49, 0x1A]);
interface IDvbShortEventDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetLanguageCode(char* pszCode);
    HRESULT GetEventNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
}

const GUID IID_IDvbExtendedEventDescriptor = {0xC9B22ECA, 0x85F4, 0x499F, [0xB1, 0xDB, 0xEF, 0xA9, 0x3A, 0x91, 0xEE, 0x57]};
@GUID(0xC9B22ECA, 0x85F4, 0x499F, [0xB1, 0xDB, 0xEF, 0xA9, 0x3A, 0x91, 0xEE, 0x57]);
interface IDvbExtendedEventDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDescriptorNumber(ubyte* pbVal);
    HRESULT GetLastDescriptorNumber(ubyte* pbVal);
    HRESULT GetLanguageCode(char* pszCode);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordItemW(ubyte bRecordIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrDesc, BSTR* pbstrItem);
    HRESULT GetConcatenatedItemW(IDvbExtendedEventDescriptor pFollowingDescriptor, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrDesc, BSTR* pbstrItem);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
    HRESULT GetConcatenatedTextW(IDvbExtendedEventDescriptor FollowingDescriptor, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
    HRESULT GetRecordItemRawBytes(ubyte bRecordIndex, ubyte** ppbRawItem, ubyte* pbItemLength);
}

const GUID IID_IDvbComponentDescriptor = {0x91E405CF, 0x80E7, 0x457F, [0x90, 0x96, 0x1B, 0x9D, 0x1C, 0xE3, 0x21, 0x41]};
@GUID(0x91E405CF, 0x80E7, 0x457F, [0x90, 0x96, 0x1B, 0x9D, 0x1C, 0xE3, 0x21, 0x41]);
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

const GUID IID_IDvbContentDescriptor = {0x2E883881, 0xA467, 0x412A, [0x9D, 0x63, 0x6F, 0x2B, 0x6D, 0xA0, 0x5B, 0xF0]};
@GUID(0x2E883881, 0xA467, 0x412A, [0x9D, 0x63, 0x6F, 0x2B, 0x6D, 0xA0, 0x5B, 0xF0]);
interface IDvbContentDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordContentNibbles(ubyte bRecordIndex, ubyte* pbValLevel1, ubyte* pbValLevel2);
    HRESULT GetRecordUserNibbles(ubyte bRecordIndex, ubyte* pbVal1, ubyte* pbVal2);
}

const GUID IID_IDvbParentalRatingDescriptor = {0x3AD9DDE1, 0xFB1B, 0x4186, [0x93, 0x7F, 0x22, 0xE6, 0xB5, 0xA7, 0x2A, 0x10]};
@GUID(0x3AD9DDE1, 0xFB1B, 0x4186, [0x93, 0x7F, 0x22, 0xE6, 0xB5, 0xA7, 0x2A, 0x10]);
interface IDvbParentalRatingDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordRating(ubyte bRecordIndex, char* pszCountryCode, ubyte* pbVal);
}

const GUID IID_IIsdbTerrestrialDeliverySystemDescriptor = {0x39FAE0A6, 0xD151, 0x44DD, [0xA2, 0x8A, 0x76, 0x5D, 0xE5, 0x99, 0x16, 0x70]};
@GUID(0x39FAE0A6, 0xD151, 0x44DD, [0xA2, 0x8A, 0x76, 0x5D, 0xE5, 0x99, 0x16, 0x70]);
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

const GUID IID_IIsdbTSInformationDescriptor = {0xD7AD183E, 0x38F5, 0x4210, [0xB5, 0x5F, 0xEC, 0x8D, 0x60, 0x1B, 0xBD, 0x47]};
@GUID(0xD7AD183E, 0x38F5, 0x4210, [0xB5, 0x5F, 0xEC, 0x8D, 0x60, 0x1B, 0xBD, 0x47]);
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

const GUID IID_IIsdbDigitalCopyControlDescriptor = {0x1A28417E, 0x266A, 0x4BB8, [0xA4, 0xBD, 0xD7, 0x82, 0xBC, 0xFB, 0x81, 0x61]};
@GUID(0x1A28417E, 0x266A, 0x4BB8, [0xA4, 0xBD, 0xD7, 0x82, 0xBC, 0xFB, 0x81, 0x61]);
interface IIsdbDigitalCopyControlDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCopyControl(ubyte* pbDigitalRecordingControlData, ubyte* pbCopyControlType, ubyte* pbAPSControlData, ubyte* pbMaximumBitrate);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordCopyControl(ubyte bRecordIndex, ubyte* pbComponentTag, ubyte* pbDigitalRecordingControlData, ubyte* pbCopyControlType, ubyte* pbAPSControlData, ubyte* pbMaximumBitrate);
}

const GUID IID_IIsdbAudioComponentDescriptor = {0x679D2002, 0x2425, 0x4BE4, [0xA4, 0xC7, 0xD6, 0x63, 0x2A, 0x57, 0x4F, 0x4D]};
@GUID(0x679D2002, 0x2425, 0x4BE4, [0xA4, 0xC7, 0xD6, 0x63, 0x2A, 0x57, 0x4F, 0x4D]);
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

const GUID IID_IIsdbDataContentDescriptor = {0xA428100A, 0xE646, 0x4BD6, [0xAA, 0x14, 0x60, 0x87, 0xBD, 0xC0, 0x8C, 0xD5]};
@GUID(0xA428100A, 0xE646, 0x4BD6, [0xAA, 0x14, 0x60, 0x87, 0xBD, 0xC0, 0x8C, 0xD5]);
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

const GUID IID_IIsdbCAContractInformationDescriptor = {0x08E18B25, 0xA28F, 0x4E92, [0x82, 0x1E, 0x4F, 0xCE, 0xD5, 0xCC, 0x22, 0x91]};
@GUID(0x08E18B25, 0xA28F, 0x4E92, [0x82, 0x1E, 0x4F, 0xCE, 0xD5, 0xCC, 0x22, 0x91]);
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

const GUID IID_IIsdbEventGroupDescriptor = {0x94B06780, 0x2E2A, 0x44DC, [0xA9, 0x66, 0xCC, 0x56, 0xFD, 0xAB, 0xC6, 0xC2]};
@GUID(0x94B06780, 0x2E2A, 0x44DC, [0xA9, 0x66, 0xCC, 0x56, 0xFD, 0xAB, 0xC6, 0xC2]);
interface IIsdbEventGroupDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetGroupType(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordEvent(ubyte bRecordIndex, ushort* pwServiceId, ushort* pwEventId);
    HRESULT GetCountOfRefRecords(ubyte* pbVal);
    HRESULT GetRefRecordEvent(ubyte bRecordIndex, ushort* pwOriginalNetworkId, ushort* pwTransportStreamId, ushort* pwServiceId, ushort* pwEventId);
}

const GUID IID_IIsdbComponentGroupDescriptor = {0xA494F17F, 0xC592, 0x47D8, [0x89, 0x43, 0x64, 0xC9, 0xA3, 0x4B, 0xE7, 0xB9]};
@GUID(0xA494F17F, 0xC592, 0x47D8, [0x89, 0x43, 0x64, 0xC9, 0xA3, 0x4B, 0xE7, 0xB9]);
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
    HRESULT GetRecordCAUnitComponentTag(ubyte bRecordIndex, ubyte bCAUnitIndex, ubyte bComponentIndex, ubyte* pbVal);
    HRESULT GetRecordTotalBitRate(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordTextW(ubyte bRecordIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
}

const GUID IID_IIsdbSeriesDescriptor = {0x07EF6370, 0x1660, 0x4F26, [0x87, 0xFC, 0x61, 0x4A, 0xDA, 0xB2, 0x4B, 0x11]};
@GUID(0x07EF6370, 0x1660, 0x4F26, [0x87, 0xFC, 0x61, 0x4A, 0xDA, 0xB2, 0x4B, 0x11]);
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

const GUID IID_IIsdbDownloadContentDescriptor = {0x5298661E, 0xCB88, 0x4F5F, [0xA1, 0xDE, 0x5F, 0x44, 0x0C, 0x18, 0x5B, 0x92]};
@GUID(0x5298661E, 0xCB88, 0x4F5F, [0xA1, 0xDE, 0x5F, 0x44, 0x0C, 0x18, 0x5B, 0x92]);
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

const GUID IID_IIsdbLogoTransmissionDescriptor = {0xE0103F49, 0x4AE1, 0x4F07, [0x90, 0x98, 0x75, 0x6D, 0xB1, 0xFA, 0x88, 0xCD]};
@GUID(0xE0103F49, 0x4AE1, 0x4F07, [0x90, 0x98, 0x75, 0x6D, 0xB1, 0xFA, 0x88, 0xCD]);
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

const GUID IID_IIsdbSIParameterDescriptor = {0xF837DC36, 0x867C, 0x426A, [0x91, 0x11, 0xF6, 0x20, 0x93, 0x95, 0x1A, 0x45]};
@GUID(0xF837DC36, 0x867C, 0x426A, [0x91, 0x11, 0xF6, 0x20, 0x93, 0x95, 0x1A, 0x45]);
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

const GUID IID_IIsdbEmergencyInformationDescriptor = {0xBA6FA681, 0xB973, 0x4DA1, [0x92, 0x07, 0xAC, 0x3E, 0x7F, 0x03, 0x41, 0xEB]};
@GUID(0xBA6FA681, 0xB973, 0x4DA1, [0x92, 0x07, 0xAC, 0x3E, 0x7F, 0x03, 0x41, 0xEB]);
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

const GUID IID_IIsdbCADescriptor = {0x0570AA47, 0x52BC, 0x42AE, [0x8C, 0xA5, 0x96, 0x9F, 0x41, 0xE8, 0x1A, 0xEA]};
@GUID(0x0570AA47, 0x52BC, 0x42AE, [0x8C, 0xA5, 0x96, 0x9F, 0x41, 0xE8, 0x1A, 0xEA]);
interface IIsdbCADescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCASystemId(ushort* pwVal);
    HRESULT GetReservedBits(ubyte* pbVal);
    HRESULT GetCAPID(ushort* pwVal);
    HRESULT GetPrivateDataBytes(ubyte* pbBufferLength, ubyte* pbBuffer);
}

const GUID IID_IIsdbCAServiceDescriptor = {0x39CBEB97, 0xFF0B, 0x42A7, [0x9A, 0xB9, 0x7B, 0x9C, 0xFE, 0x70, 0xA7, 0x7A]};
@GUID(0x39CBEB97, 0xFF0B, 0x42A7, [0x9A, 0xB9, 0x7B, 0x9C, 0xFE, 0x70, 0xA7, 0x7A]);
interface IIsdbCAServiceDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCASystemId(ushort* pwVal);
    HRESULT GetCABroadcasterGroupId(ubyte* pbVal);
    HRESULT GetMessageControl(ubyte* pbVal);
    HRESULT GetServiceIds(ubyte* pbNumServiceIds, ushort* pwServiceIds);
}

const GUID IID_IIsdbHierarchicalTransmissionDescriptor = {0xB7B3AE90, 0xEE0B, 0x446D, [0x87, 0x69, 0xF7, 0xE2, 0xAA, 0x26, 0x6A, 0xA6]};
@GUID(0xB7B3AE90, 0xEE0B, 0x446D, [0x87, 0x69, 0xF7, 0xE2, 0xAA, 0x26, 0x6A, 0xA6]);
interface IIsdbHierarchicalTransmissionDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetFutureUse1(ubyte* pbVal);
    HRESULT GetQualityLevel(ubyte* pbVal);
    HRESULT GetFutureUse2(ubyte* pbVal);
    HRESULT GetReferencePid(ushort* pwVal);
}

const GUID IID_IPBDASiParser = {0x9DE49A74, 0xABA2, 0x4A18, [0x93, 0xE1, 0x21, 0xF1, 0x7F, 0x95, 0xC3, 0xC3]};
@GUID(0x9DE49A74, 0xABA2, 0x4A18, [0x93, 0xE1, 0x21, 0xF1, 0x7F, 0x95, 0xC3, 0xC3]);
interface IPBDASiParser : IUnknown
{
    HRESULT Initialize(IUnknown punk);
    HRESULT GetEIT(uint dwSize, ubyte* pBuffer, IPBDA_EIT* ppEIT);
    HRESULT GetServices(uint dwSize, const(ubyte)* pBuffer, IPBDA_Services* ppServices);
}

const GUID IID_IPBDA_EIT = {0xA35F2DEA, 0x098F, 0x4EBD, [0x98, 0x4C, 0x2B, 0xD4, 0xC3, 0xC8, 0xCE, 0x0A]};
@GUID(0xA35F2DEA, 0x098F, 0x4EBD, [0x98, 0x4C, 0x2B, 0xD4, 0xC3, 0xC8, 0xCE, 0x0A]);
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
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

const GUID IID_IPBDA_Services = {0x944EAB37, 0xEED4, 0x4850, [0xAF, 0xD2, 0x77, 0xE7, 0xEF, 0xEB, 0x44, 0x27]};
@GUID(0x944EAB37, 0xEED4, 0x4850, [0xAF, 0xD2, 0x77, 0xE7, 0xEF, 0xEB, 0x44, 0x27]);
interface IPBDA_Services : IUnknown
{
    HRESULT Initialize(uint size, ubyte* pBuffer);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordByIndex(uint dwRecordIndex, ulong* pul64ServiceIdx);
}

const GUID IID_IPBDAEntitlementDescriptor = {0x22632497, 0x0DE3, 0x4587, [0xAA, 0xDC, 0xD8, 0xD9, 0x90, 0x17, 0xE7, 0x60]};
@GUID(0x22632497, 0x0DE3, 0x4587, [0xAA, 0xDC, 0xD8, 0xD9, 0x90, 0x17, 0xE7, 0x60]);
interface IPBDAEntitlementDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ushort* pwVal);
    HRESULT GetToken(ubyte** ppbTokenBuffer, uint* pdwTokenLength);
}

const GUID IID_IPBDAAttributesDescriptor = {0x313B3620, 0x3263, 0x45A6, [0x95, 0x33, 0x96, 0x8B, 0xEF, 0xBE, 0xAC, 0x03]};
@GUID(0x313B3620, 0x3263, 0x45A6, [0x95, 0x33, 0x96, 0x8B, 0xEF, 0xBE, 0xAC, 0x03]);
interface IPBDAAttributesDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ushort* pwVal);
    HRESULT GetAttributePayload(ubyte** ppbAttributeBuffer, uint* pdwAttributeLength);
}

const GUID IID_IBDA_TIF_REGISTRATION = {0xDFEF4A68, 0xEE61, 0x415F, [0x9C, 0xCB, 0xCD, 0x95, 0xF2, 0xF9, 0x8A, 0x3A]};
@GUID(0xDFEF4A68, 0xEE61, 0x415F, [0x9C, 0xCB, 0xCD, 0x95, 0xF2, 0xF9, 0x8A, 0x3A]);
interface IBDA_TIF_REGISTRATION : IUnknown
{
    HRESULT RegisterTIFEx(IPin pTIFInputPin, uint* ppvRegistrationContext, IUnknown* ppMpeg2DataControl);
    HRESULT UnregisterTIF(uint pvRegistrationContext);
}

const GUID IID_IMPEG2_TIF_CONTROL = {0xF9BAC2F9, 0x4149, 0x4916, [0xB2, 0xEF, 0xFA, 0xA2, 0x02, 0x32, 0x68, 0x62]};
@GUID(0xF9BAC2F9, 0x4149, 0x4916, [0xB2, 0xEF, 0xFA, 0xA2, 0x02, 0x32, 0x68, 0x62]);
interface IMPEG2_TIF_CONTROL : IUnknown
{
    HRESULT RegisterTIF(IUnknown pUnkTIF, uint* ppvRegistrationContext);
    HRESULT UnregisterTIF(uint pvRegistrationContext);
    HRESULT AddPIDs(uint ulcPIDs, uint* pulPIDs);
    HRESULT DeletePIDs(uint ulcPIDs, uint* pulPIDs);
    HRESULT GetPIDCount(uint* pulcPIDs);
    HRESULT GetPIDs(uint* pulcPIDs, uint* pulPIDs);
}

const GUID IID_ITuneRequestInfo = {0xA3B152DF, 0x7A90, 0x4218, [0xAC, 0x54, 0x98, 0x30, 0xBE, 0xE8, 0xC0, 0xB6]};
@GUID(0xA3B152DF, 0x7A90, 0x4218, [0xAC, 0x54, 0x98, 0x30, 0xBE, 0xE8, 0xC0, 0xB6]);
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

const GUID IID_ITuneRequestInfoEx = {0xEE957C52, 0xB0D0, 0x4E78, [0x8D, 0xD1, 0xB8, 0x7A, 0x08, 0xBF, 0xD8, 0x93]};
@GUID(0xEE957C52, 0xB0D0, 0x4E78, [0x8D, 0xD1, 0xB8, 0x7A, 0x08, 0xBF, 0xD8, 0x93]);
interface ITuneRequestInfoEx : ITuneRequestInfo
{
    HRESULT CreateComponentListEx(ITuneRequest CurrentRequest, IUnknown* ppCurPMT);
}

const GUID IID_ISIInbandEPGEvent = {0x7E47913A, 0x5A89, 0x423D, [0x9A, 0x2B, 0xE1, 0x51, 0x68, 0x85, 0x89, 0x34]};
@GUID(0x7E47913A, 0x5A89, 0x423D, [0x9A, 0x2B, 0xE1, 0x51, 0x68, 0x85, 0x89, 0x34]);
interface ISIInbandEPGEvent : IUnknown
{
    HRESULT SIObjectEvent(IDVB_EIT2 pIDVB_EIT, uint dwTable_ID, uint dwService_ID);
}

const GUID IID_ISIInbandEPG = {0xF90AD9D0, 0xB854, 0x4B68, [0x9C, 0xC1, 0xB2, 0xCC, 0x96, 0x11, 0x9D, 0x85]};
@GUID(0xF90AD9D0, 0xB854, 0x4B68, [0x9C, 0xC1, 0xB2, 0xCC, 0x96, 0x11, 0x9D, 0x85]);
interface ISIInbandEPG : IUnknown
{
    HRESULT StartSIEPGScan();
    HRESULT StopSIEPGScan();
    HRESULT IsSIEPGScanRunning(int* bRunning);
}

const GUID IID_IGuideDataEvent = {0xEFDA0C80, 0xF395, 0x42C3, [0x9B, 0x3C, 0x56, 0xB3, 0x7D, 0xEC, 0x7B, 0xB7]};
@GUID(0xEFDA0C80, 0xF395, 0x42C3, [0x9B, 0x3C, 0x56, 0xB3, 0x7D, 0xEC, 0x7B, 0xB7]);
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

const GUID IID_IGuideDataProperty = {0x88EC5E58, 0xBB73, 0x41D6, [0x99, 0xCE, 0x66, 0xC5, 0x24, 0xB8, 0xB5, 0x91]};
@GUID(0x88EC5E58, 0xBB73, 0x41D6, [0x99, 0xCE, 0x66, 0xC5, 0x24, 0xB8, 0xB5, 0x91]);
interface IGuideDataProperty : IUnknown
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Language(int* idLang);
    HRESULT get_Value(VARIANT* pvar);
}

const GUID IID_IEnumGuideDataProperties = {0xAE44423B, 0x4571, 0x475C, [0xAD, 0x2C, 0xF4, 0x0A, 0x77, 0x1D, 0x80, 0xEF]};
@GUID(0xAE44423B, 0x4571, 0x475C, [0xAD, 0x2C, 0xF4, 0x0A, 0x77, 0x1D, 0x80, 0xEF]);
interface IEnumGuideDataProperties : IUnknown
{
    HRESULT Next(uint celt, IGuideDataProperty* ppprop, uint* pcelt);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumGuideDataProperties* ppenum);
}

const GUID IID_IEnumTuneRequests = {0x1993299C, 0xCED6, 0x4788, [0x87, 0xA3, 0x42, 0x00, 0x67, 0xDC, 0xE0, 0xC7]};
@GUID(0x1993299C, 0xCED6, 0x4788, [0x87, 0xA3, 0x42, 0x00, 0x67, 0xDC, 0xE0, 0xC7]);
interface IEnumTuneRequests : IUnknown
{
    HRESULT Next(uint celt, ITuneRequest* ppprop, uint* pcelt);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumTuneRequests* ppenum);
}

const GUID IID_IGuideData = {0x61571138, 0x5B01, 0x43CD, [0xAE, 0xAF, 0x60, 0xB7, 0x84, 0xA0, 0xBF, 0x93]};
@GUID(0x61571138, 0x5B01, 0x43CD, [0xAE, 0xAF, 0x60, 0xB7, 0x84, 0xA0, 0xBF, 0x93]);
interface IGuideData : IUnknown
{
    HRESULT GetServices(IEnumTuneRequests* ppEnumTuneRequests);
    HRESULT GetServiceProperties(ITuneRequest pTuneRequest, IEnumGuideDataProperties* ppEnumProperties);
    HRESULT GetGuideProgramIDs(IEnumVARIANT* pEnumPrograms);
    HRESULT GetProgramProperties(VARIANT varProgramDescriptionID, IEnumGuideDataProperties* ppEnumProperties);
    HRESULT GetScheduleEntryIDs(IEnumVARIANT* pEnumScheduleEntries);
    HRESULT GetScheduleEntryProperties(VARIANT varScheduleEntryDescriptionID, IEnumGuideDataProperties* ppEnumProperties);
}

const GUID IID_IGuideDataLoader = {0x4764FF7C, 0xFA95, 0x4525, [0xAF, 0x4D, 0xD3, 0x22, 0x36, 0xDB, 0x9E, 0x38]};
@GUID(0x4764FF7C, 0xFA95, 0x4525, [0xAF, 0x4D, 0xD3, 0x22, 0x36, 0xDB, 0x9E, 0x38]);
interface IGuideDataLoader : IUnknown
{
    HRESULT Init(IGuideData pGuideStore);
    HRESULT Terminate();
}

struct KSP_BDA_NODE_PIN
{
    KSIDENTIFIER Property;
    uint ulNodeType;
    uint ulInputPinId;
    uint ulOutputPinId;
}

struct KSM_BDA_PIN
{
    KSIDENTIFIER Method;
    _Anonymous_e__Union Anonymous;
    uint Reserved;
}

struct KSM_BDA_PIN_PAIR
{
    KSIDENTIFIER Method;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct KSP_NODE_ESPID
{
    KSP_NODE Property;
    uint EsPid;
}

struct KSM_BDA_DEBUG_LEVEL
{
    KSIDENTIFIER Method;
    ubyte ucDebugLevel;
    uint ulDebugStringSize;
    ubyte argbDebugString;
}

struct BDA_DEBUG_DATA
{
    int lResult;
    Guid uuidDebugDataType;
    uint ulDataSize;
    ubyte argbDebugData;
}

struct BDA_EVENT_DATA
{
    int lResult;
    uint ulEventID;
    Guid uuidEventType;
    uint ulEventDataLength;
    ubyte argbEventData;
}

struct KSM_BDA_EVENT_COMPLETE
{
    KSIDENTIFIER Method;
    uint ulEventID;
    uint ulEventResult;
}

struct KSM_BDA_DRM_SETDRM
{
    KSM_NODE NodeMethod;
    Guid NewDRMuuid;
}

struct KSM_BDA_BUFFER
{
    KSM_NODE NodeMethod;
    uint ulBufferSize;
    ubyte argbBuffer;
}

struct KSM_BDA_WMDRM_LICENSE
{
    KSM_NODE NodeMethod;
    Guid uuidKeyID;
}

struct KSM_BDA_WMDRM_RENEWLICENSE
{
    KSM_NODE NodeMethod;
    uint ulXMRLicenseLength;
    uint ulEntitlementTokenLength;
    ubyte argbDataBuffer;
}

struct KSM_BDA_WMDRMTUNER_PURCHASEENTITLEMENT
{
    KSM_NODE NodeMethod;
    uint ulDialogRequest;
    byte cLanguage;
    uint ulPurchaseTokenLength;
    ubyte argbDataBuffer;
}

struct KSM_BDA_WMDRMTUNER_SETPIDPROTECTION
{
    KSM_NODE NodeMethod;
    uint ulPID;
    Guid uuidKeyID;
}

struct KSM_BDA_WMDRMTUNER_GETPIDPROTECTION
{
    KSM_NODE NodeMethod;
    uint ulPID;
}

struct KSM_BDA_WMDRMTUNER_SYNCVALUE
{
    KSM_NODE NodeMethod;
    uint ulSyncValue;
}

struct KSM_BDA_TUNER_TUNEREQUEST
{
    KSIDENTIFIER Method;
    uint ulTuneLength;
    ubyte argbTuneData;
}

struct KSM_BDA_GPNV_GETVALUE
{
    KSIDENTIFIER Method;
    uint ulNameLength;
    byte cLanguage;
    ubyte argbData;
}

struct KSM_BDA_GPNV_SETVALUE
{
    KSIDENTIFIER Method;
    uint ulDialogRequest;
    byte cLanguage;
    uint ulNameLength;
    uint ulValueLength;
    ubyte argbName;
}

struct KSM_BDA_GPNV_NAMEINDEX
{
    KSIDENTIFIER Method;
    uint ulValueNameIndex;
}

struct KSM_BDA_SCAN_CAPABILTIES
{
    KSIDENTIFIER Method;
    Guid uuidBroadcastStandard;
}

struct KSM_BDA_SCAN_FILTER
{
    KSIDENTIFIER Method;
    uint ulScanModulationTypeSize;
    ulong AnalogVideoStandards;
    ubyte argbScanModulationTypes;
}

struct KSM_BDA_SCAN_START
{
    KSIDENTIFIER Method;
    uint LowerFrequency;
    uint HigherFrequency;
}

struct KSM_BDA_GDDS_TUNEXMLFROMIDX
{
    KSIDENTIFIER Method;
    ulong ulIdx;
}

struct KSM_BDA_GDDS_SERVICEFROMTUNEXML
{
    KSIDENTIFIER Method;
    uint ulTuneXmlLength;
    ubyte argbTuneXml;
}

struct KSM_BDA_USERACTIVITY_USEREASON
{
    KSIDENTIFIER Method;
    uint ulUseReason;
}

struct KSM_BDA_CAS_ENTITLEMENTTOKEN
{
    KSM_NODE NodeMethod;
    uint ulDialogRequest;
    byte cLanguage;
    uint ulRequestType;
    uint ulEntitlementTokenLen;
    ubyte argbEntitlementToken;
}

struct KSM_BDA_CAS_CAPTURETOKEN
{
    KSM_NODE NodeMethod;
    uint ulTokenLength;
    ubyte argbToken;
}

struct KSM_BDA_CAS_OPENBROADCASTMMI
{
    KSM_NODE NodeMethod;
    uint ulDialogRequest;
    byte cLanguage;
    uint ulEventId;
}

struct KSM_BDA_CAS_CLOSEMMIDIALOG
{
    KSM_NODE NodeMethod;
    uint ulDialogRequest;
    byte cLanguage;
    uint ulDialogNumber;
    uint ulReason;
}

struct KSM_BDA_ISDBCAS_REQUEST
{
    KSM_NODE NodeMethod;
    uint ulRequestID;
    uint ulIsdbCommandSize;
    ubyte argbIsdbCommandData;
}

struct KSM_BDA_TS_SELECTOR_SETTSID
{
    KSM_NODE NodeMethod;
    ushort usTSID;
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
    KSDATAFORMAT DataRange;
    BDA_TRANSPORT_INFO BdaTransportInfo;
}

const GUID CLSID_EVENTID_TuningChanging = {0x83183C03, 0xC09E, 0x45C4, [0xA7, 0x19, 0x80, 0x7A, 0x94, 0x95, 0x2B, 0xF9]};
@GUID(0x83183C03, 0xC09E, 0x45C4, [0xA7, 0x19, 0x80, 0x7A, 0x94, 0x95, 0x2B, 0xF9]);
struct EVENTID_TuningChanging;

const GUID CLSID_EVENTID_TuningChanged = {0x9D7E6235, 0x4B7D, 0x425D, [0xA6, 0xD1, 0xD7, 0x17, 0xC3, 0x3B, 0x9C, 0x4C]};
@GUID(0x9D7E6235, 0x4B7D, 0x425D, [0xA6, 0xD1, 0xD7, 0x17, 0xC3, 0x3B, 0x9C, 0x4C]);
struct EVENTID_TuningChanged;

const GUID CLSID_EVENTID_CandidatePostTuneData = {0x9F02D3D0, 0x9F06, 0x4369, [0x9F, 0x1E, 0x3A, 0xD6, 0xCA, 0x19, 0x80, 0x7E]};
@GUID(0x9F02D3D0, 0x9F06, 0x4369, [0x9F, 0x1E, 0x3A, 0xD6, 0xCA, 0x19, 0x80, 0x7E]);
struct EVENTID_CandidatePostTuneData;

const GUID CLSID_EVENTID_CADenialCountChanged = {0x2A65C528, 0x2249, 0x4070, [0xAC, 0x16, 0x00, 0x39, 0x0C, 0xDF, 0xB2, 0xDD]};
@GUID(0x2A65C528, 0x2249, 0x4070, [0xAC, 0x16, 0x00, 0x39, 0x0C, 0xDF, 0xB2, 0xDD]);
struct EVENTID_CADenialCountChanged;

const GUID CLSID_EVENTID_SignalStatusChanged = {0x6D9CFAF2, 0x702D, 0x4B01, [0x8D, 0xFF, 0x68, 0x92, 0xAD, 0x20, 0xD1, 0x91]};
@GUID(0x6D9CFAF2, 0x702D, 0x4B01, [0x8D, 0xFF, 0x68, 0x92, 0xAD, 0x20, 0xD1, 0x91]);
struct EVENTID_SignalStatusChanged;

const GUID CLSID_EVENTID_NewSignalAcquired = {0xC87EC52D, 0xCD18, 0x404A, [0xA0, 0x76, 0xC0, 0x2A, 0x27, 0x3D, 0x3D, 0xE7]};
@GUID(0xC87EC52D, 0xCD18, 0x404A, [0xA0, 0x76, 0xC0, 0x2A, 0x27, 0x3D, 0x3D, 0xE7]);
struct EVENTID_NewSignalAcquired;

const GUID CLSID_EVENTID_EASMessageReceived = {0xD10DF9D5, 0xC261, 0x4B85, [0x9E, 0x8A, 0x51, 0x7B, 0x32, 0x99, 0xCA, 0xB2]};
@GUID(0xD10DF9D5, 0xC261, 0x4B85, [0x9E, 0x8A, 0x51, 0x7B, 0x32, 0x99, 0xCA, 0xB2]);
struct EVENTID_EASMessageReceived;

const GUID CLSID_EVENTID_PSITable = {0x1B9C3703, 0xD447, 0x4E16, [0x97, 0xBB, 0x01, 0x79, 0x9F, 0xC0, 0x31, 0xED]};
@GUID(0x1B9C3703, 0xD447, 0x4E16, [0x97, 0xBB, 0x01, 0x79, 0x9F, 0xC0, 0x31, 0xED]);
struct EVENTID_PSITable;

const GUID CLSID_EVENTID_ServiceTerminated = {0x0A1D591C, 0xE0D2, 0x4F8E, [0x89, 0x60, 0x23, 0x35, 0xBE, 0xF4, 0x5C, 0xCB]};
@GUID(0x0A1D591C, 0xE0D2, 0x4F8E, [0x89, 0x60, 0x23, 0x35, 0xBE, 0xF4, 0x5C, 0xCB]);
struct EVENTID_ServiceTerminated;

const GUID CLSID_EVENTID_CardStatusChanged = {0xA265FAEA, 0xF874, 0x4B38, [0x9F, 0xF7, 0xC5, 0x3D, 0x02, 0x96, 0x99, 0x96]};
@GUID(0xA265FAEA, 0xF874, 0x4B38, [0x9F, 0xF7, 0xC5, 0x3D, 0x02, 0x96, 0x99, 0x96]);
struct EVENTID_CardStatusChanged;

const GUID CLSID_EVENTID_DRMParingStatusChanged = {0x000906F5, 0xF0D1, 0x41D6, [0xA7, 0xDF, 0x40, 0x28, 0x69, 0x76, 0x69, 0xF6]};
@GUID(0x000906F5, 0xF0D1, 0x41D6, [0xA7, 0xDF, 0x40, 0x28, 0x69, 0x76, 0x69, 0xF6]);
struct EVENTID_DRMParingStatusChanged;

const GUID CLSID_EVENTID_DRMParingStepComplete = {0x5B2EBF78, 0xB752, 0x4420, [0xB4, 0x1E, 0xA4, 0x72, 0xDC, 0x95, 0x82, 0x8E]};
@GUID(0x5B2EBF78, 0xB752, 0x4420, [0xB4, 0x1E, 0xA4, 0x72, 0xDC, 0x95, 0x82, 0x8E]);
struct EVENTID_DRMParingStepComplete;

const GUID CLSID_EVENTID_MMIMessage = {0x052C29AF, 0x09A4, 0x4B93, [0x89, 0x0F, 0xBD, 0x6A, 0x34, 0x89, 0x68, 0xA4]};
@GUID(0x052C29AF, 0x09A4, 0x4B93, [0x89, 0x0F, 0xBD, 0x6A, 0x34, 0x89, 0x68, 0xA4]);
struct EVENTID_MMIMessage;

const GUID CLSID_EVENTID_EntitlementChanged = {0x9071AD5D, 0x2359, 0x4C95, [0x86, 0x94, 0xAF, 0xA8, 0x1D, 0x70, 0xBF, 0xD5]};
@GUID(0x9071AD5D, 0x2359, 0x4C95, [0x86, 0x94, 0xAF, 0xA8, 0x1D, 0x70, 0xBF, 0xD5]);
struct EVENTID_EntitlementChanged;

const GUID CLSID_EVENTID_STBChannelNumber = {0x17C4D730, 0xD0F0, 0x413A, [0x8C, 0x99, 0x50, 0x04, 0x69, 0xDE, 0x35, 0xAD]};
@GUID(0x17C4D730, 0xD0F0, 0x413A, [0x8C, 0x99, 0x50, 0x04, 0x69, 0xDE, 0x35, 0xAD]);
struct EVENTID_STBChannelNumber;

const GUID CLSID_EVENTID_BDAEventingServicePendingEvent = {0x5CA51711, 0x5DDC, 0x41A6, [0x94, 0x30, 0xE4, 0x1B, 0x8B, 0x3B, 0xBC, 0x5B]};
@GUID(0x5CA51711, 0x5DDC, 0x41A6, [0x94, 0x30, 0xE4, 0x1B, 0x8B, 0x3B, 0xBC, 0x5B]);
struct EVENTID_BDAEventingServicePendingEvent;

const GUID CLSID_EVENTID_BDAConditionalAccessTAG = {0xEFC3A459, 0xAE8B, 0x4B4A, [0x8F, 0xE9, 0x79, 0xA0, 0xD0, 0x97, 0xF3, 0xEA]};
@GUID(0xEFC3A459, 0xAE8B, 0x4B4A, [0x8F, 0xE9, 0x79, 0xA0, 0xD0, 0x97, 0xF3, 0xEA]);
struct EVENTID_BDAConditionalAccessTAG;

const GUID CLSID_EVENTTYPE_CASDescrambleFailureEvent = {0xB2127D42, 0x7BE5, 0x4F4B, [0x91, 0x30, 0x66, 0x79, 0x89, 0x9F, 0x4F, 0x4B]};
@GUID(0xB2127D42, 0x7BE5, 0x4F4B, [0x91, 0x30, 0x66, 0x79, 0x89, 0x9F, 0x4F, 0x4B]);
struct EVENTTYPE_CASDescrambleFailureEvent;

const GUID CLSID_EVENTID_CASFailureSpanningEvent = {0xEAD831AE, 0x5529, 0x4D1F, [0xAF, 0xCE, 0x0D, 0x8C, 0xD1, 0x25, 0x7D, 0x30]};
@GUID(0xEAD831AE, 0x5529, 0x4D1F, [0xAF, 0xCE, 0x0D, 0x8C, 0xD1, 0x25, 0x7D, 0x30]);
struct EVENTID_CASFailureSpanningEvent;

enum ChannelChangeSpanningEvent_State
{
    ChannelChangeSpanningEvent_Start = 0,
    ChannelChangeSpanningEvent_End = 2,
}

const GUID CLSID_EVENTID_ChannelChangeSpanningEvent = {0x9067C5E5, 0x4C5C, 0x4205, [0x86, 0xC8, 0x7A, 0xFE, 0x20, 0xFE, 0x1E, 0xFA]};
@GUID(0x9067C5E5, 0x4C5C, 0x4205, [0x86, 0xC8, 0x7A, 0xFE, 0x20, 0xFE, 0x1E, 0xFA]);
struct EVENTID_ChannelChangeSpanningEvent;

struct ChannelChangeInfo
{
    ChannelChangeSpanningEvent_State state;
    ulong TimeStamp;
}

const GUID CLSID_EVENTID_ChannelTypeSpanningEvent = {0x72AB1D51, 0x87D2, 0x489B, [0xBA, 0x11, 0x0E, 0x08, 0xDC, 0x21, 0x02, 0x43]};
@GUID(0x72AB1D51, 0x87D2, 0x489B, [0xBA, 0x11, 0x0E, 0x08, 0xDC, 0x21, 0x02, 0x43]);
struct EVENTID_ChannelTypeSpanningEvent;

enum ChannelType
{
    ChannelTypeNone = 0,
    ChannelTypeOther = 1,
    ChannelTypeVideo = 2,
    ChannelTypeAudio = 4,
    ChannelTypeText = 8,
    ChannelTypeSubtitles = 16,
    ChannelTypeCaptions = 32,
    ChannelTypeSuperimpose = 64,
    ChannelTypeData = 128,
}

struct ChannelTypeInfo
{
    ChannelType channelType;
    ulong timeStamp;
}

struct ChannelInfo
{
    int lFrequency;
    _Anonymous_e__Union Anonymous;
}

const GUID CLSID_EVENTID_ChannelInfoSpanningEvent = {0x41F36D80, 0x4132, 0x4CC2, [0xB1, 0x21, 0x01, 0xA4, 0x32, 0x19, 0xD8, 0x1B]};
@GUID(0x41F36D80, 0x4132, 0x4CC2, [0xB1, 0x21, 0x01, 0xA4, 0x32, 0x19, 0xD8, 0x1B]);
struct EVENTID_ChannelInfoSpanningEvent;

const GUID CLSID_EVENTID_RRTSpanningEvent = {0xF6CFC8F4, 0xDA93, 0x4F2F, [0xBF, 0xF8, 0xBA, 0x1E, 0xE6, 0xFC, 0xA3, 0xA2]};
@GUID(0xF6CFC8F4, 0xDA93, 0x4F2F, [0xBF, 0xF8, 0xBA, 0x1E, 0xE6, 0xFC, 0xA3, 0xA2]);
struct EVENTID_RRTSpanningEvent;

struct SpanningEventDescriptor
{
    ushort wDataLen;
    ushort wProgNumber;
    ushort wSID;
    ubyte bDescriptor;
}

const GUID CLSID_EVENTID_CSDescriptorSpanningEvent = {0xEFE779D9, 0x97F0, 0x4786, [0x80, 0x0D, 0x95, 0xCF, 0x50, 0x5D, 0xDC, 0x66]};
@GUID(0xEFE779D9, 0x97F0, 0x4786, [0x80, 0x0D, 0x95, 0xCF, 0x50, 0x5D, 0xDC, 0x66]);
struct EVENTID_CSDescriptorSpanningEvent;

const GUID CLSID_EVENTID_CtxADescriptorSpanningEvent = {0x3AB4A2E6, 0x4247, 0x4B34, [0x89, 0x6C, 0x30, 0xAF, 0xA5, 0xD2, 0x1C, 0x24]};
@GUID(0x3AB4A2E6, 0x4247, 0x4B34, [0x89, 0x6C, 0x30, 0xAF, 0xA5, 0xD2, 0x1C, 0x24]);
struct EVENTID_CtxADescriptorSpanningEvent;

struct DVBScramblingControlSpanningEvent
{
    uint ulPID;
    BOOL fScrambled;
}

const GUID CLSID_EVENTID_DVBScramblingControlSpanningEvent = {0x4BD4E1C4, 0x90A1, 0x4109, [0x82, 0x36, 0x27, 0xF0, 0x0E, 0x7D, 0xCC, 0x5B]};
@GUID(0x4BD4E1C4, 0x90A1, 0x4109, [0x82, 0x36, 0x27, 0xF0, 0x0E, 0x7D, 0xCC, 0x5B]);
struct EVENTID_DVBScramblingControlSpanningEvent;

enum SignalAndServiceStatusSpanningEvent_State
{
    SignalAndServiceStatusSpanningEvent_None = -1,
    SignalAndServiceStatusSpanningEvent_Clear = 0,
    SignalAndServiceStatusSpanningEvent_NoTVSignal = 1,
    SignalAndServiceStatusSpanningEvent_ServiceOffAir = 2,
    SignalAndServiceStatusSpanningEvent_WeakTVSignal = 3,
    SignalAndServiceStatusSpanningEvent_NoSubscription = 4,
    SignalAndServiceStatusSpanningEvent_AllAVScrambled = 5,
}

const GUID CLSID_EVENTID_SignalAndServiceStatusSpanningEvent = {0x8068C5CB, 0x3C04, 0x492B, [0xB4, 0x7D, 0x03, 0x08, 0x82, 0x0D, 0xCE, 0x51]};
@GUID(0x8068C5CB, 0x3C04, 0x492B, [0xB4, 0x7D, 0x03, 0x08, 0x82, 0x0D, 0xCE, 0x51]);
struct EVENTID_SignalAndServiceStatusSpanningEvent;

struct SpanningEventEmmMessage
{
    ubyte bCAbroadcasterGroupId;
    ubyte bMessageControl;
    ushort wServiceId;
    ushort wTableIdExtension;
    ubyte bDeletionStatus;
    ubyte bDisplayingDuration1;
    ubyte bDisplayingDuration2;
    ubyte bDisplayingDuration3;
    ubyte bDisplayingCycle;
    ubyte bFormatVersion;
    ubyte bDisplayPosition;
    ushort wMessageLength;
    ushort szMessageArea;
}

const GUID CLSID_EVENTID_EmmMessageSpanningEvent = {0x6BF00268, 0x4F7E, 0x4294, [0xAA, 0x87, 0xE9, 0xE9, 0x53, 0xE4, 0x3F, 0x14]};
@GUID(0x6BF00268, 0x4F7E, 0x4294, [0xAA, 0x87, 0xE9, 0xE9, 0x53, 0xE4, 0x3F, 0x14]);
struct EVENTID_EmmMessageSpanningEvent;

const GUID CLSID_EVENTID_AudioTypeSpanningEvent = {0x501CBFBE, 0xB849, 0x42CE, [0x9B, 0xE9, 0x3D, 0xB8, 0x69, 0xFB, 0x82, 0xB3]};
@GUID(0x501CBFBE, 0xB849, 0x42CE, [0x9B, 0xE9, 0x3D, 0xB8, 0x69, 0xFB, 0x82, 0xB3]);
struct EVENTID_AudioTypeSpanningEvent;

const GUID CLSID_EVENTID_StreamTypeSpanningEvent = {0x82AF2EBC, 0x30A6, 0x4264, [0xA8, 0x0B, 0xAD, 0x2E, 0x13, 0x72, 0xAC, 0x60]};
@GUID(0x82AF2EBC, 0x30A6, 0x4264, [0xA8, 0x0B, 0xAD, 0x2E, 0x13, 0x72, 0xAC, 0x60]);
struct EVENTID_StreamTypeSpanningEvent;

const GUID CLSID_EVENTID_ARIBcontentSpanningEvent = {0x3A954083, 0x93D0, 0x463E, [0x90, 0xB2, 0x07, 0x42, 0xC4, 0x96, 0xED, 0xF0]};
@GUID(0x3A954083, 0x93D0, 0x463E, [0x90, 0xB2, 0x07, 0x42, 0xC4, 0x96, 0xED, 0xF0]);
struct EVENTID_ARIBcontentSpanningEvent;

const GUID CLSID_EVENTID_LanguageSpanningEvent = {0xE292666D, 0x9C02, 0x448D, [0xAA, 0x8D, 0x78, 0x1A, 0x93, 0xFD, 0xC3, 0x95]};
@GUID(0xE292666D, 0x9C02, 0x448D, [0xAA, 0x8D, 0x78, 0x1A, 0x93, 0xFD, 0xC3, 0x95]);
struct EVENTID_LanguageSpanningEvent;

struct LanguageInfo
{
    ushort LangID;
    int lISOLangCode;
}

const GUID CLSID_EVENTID_DualMonoSpanningEvent = {0xA9A29B56, 0xA84B, 0x488C, [0x89, 0xD5, 0x0D, 0x4E, 0x76, 0x57, 0xC8, 0xCE]};
@GUID(0xA9A29B56, 0xA84B, 0x488C, [0x89, 0xD5, 0x0D, 0x4E, 0x76, 0x57, 0xC8, 0xCE]);
struct EVENTID_DualMonoSpanningEvent;

struct DualMonoInfo
{
    ushort LangID1;
    ushort LangID2;
    int lISOLangCode1;
    int lISOLangCode2;
}

const GUID CLSID_EVENTID_PIDListSpanningEvent = {0x47FC8F65, 0xE2BB, 0x4634, [0x9C, 0xEF, 0xFD, 0xBF, 0xE6, 0x26, 0x1D, 0x5C]};
@GUID(0x47FC8F65, 0xE2BB, 0x4634, [0x9C, 0xEF, 0xFD, 0xBF, 0xE6, 0x26, 0x1D, 0x5C]);
struct EVENTID_PIDListSpanningEvent;

struct PIDListSpanningEvent
{
    ushort wPIDCount;
    uint pulPIDs;
}

const GUID CLSID_EVENTID_AudioDescriptorSpanningEvent = {0x107BD41C, 0xA6DA, 0x4691, [0x83, 0x69, 0x11, 0xB2, 0xCD, 0xAA, 0x28, 0x8E]};
@GUID(0x107BD41C, 0xA6DA, 0x4691, [0x83, 0x69, 0x11, 0xB2, 0xCD, 0xAA, 0x28, 0x8E]);
struct EVENTID_AudioDescriptorSpanningEvent;

const GUID CLSID_EVENTID_SubtitleSpanningEvent = {0x5DCEC048, 0xD0B9, 0x4163, [0x87, 0x2C, 0x4F, 0x32, 0x22, 0x3B, 0xE8, 0x8A]};
@GUID(0x5DCEC048, 0xD0B9, 0x4163, [0x87, 0x2C, 0x4F, 0x32, 0x22, 0x3B, 0xE8, 0x8A]);
struct EVENTID_SubtitleSpanningEvent;

const GUID CLSID_EVENTID_TeletextSpanningEvent = {0x9599D950, 0x5F33, 0x4617, [0xAF, 0x7C, 0x1E, 0x54, 0xB5, 0x10, 0xDA, 0xA3]};
@GUID(0x9599D950, 0x5F33, 0x4617, [0xAF, 0x7C, 0x1E, 0x54, 0xB5, 0x10, 0xDA, 0xA3]);
struct EVENTID_TeletextSpanningEvent;

const GUID CLSID_EVENTID_StreamIDSpanningEvent = {0xCAF1AB68, 0xE153, 0x4D41, [0xA6, 0xB3, 0xA7, 0xC9, 0x98, 0xDB, 0x75, 0xEE]};
@GUID(0xCAF1AB68, 0xE153, 0x4D41, [0xA6, 0xB3, 0xA7, 0xC9, 0x98, 0xDB, 0x75, 0xEE]);
struct EVENTID_StreamIDSpanningEvent;

const GUID CLSID_EVENTID_PBDAParentalControlEvent = {0xF947AA85, 0xFB52, 0x48E8, [0xB9, 0xC5, 0xE1, 0xE1, 0xF4, 0x11, 0xA5, 0x1A]};
@GUID(0xF947AA85, 0xFB52, 0x48E8, [0xB9, 0xC5, 0xE1, 0xE1, 0xF4, 0x11, 0xA5, 0x1A]);
struct EVENTID_PBDAParentalControlEvent;

struct RATING_ATTRIBUTE
{
    uint rating_attribute_id;
    uint rating_attribute_value;
}

struct RATING_SYSTEM
{
    Guid rating_system_id;
    ubyte _bitfield;
    ubyte country_code;
    uint rating_attribute_count;
    RATING_ATTRIBUTE* lpratingattrib;
}

struct RATING_INFO
{
    uint rating_system_count;
    RATING_SYSTEM* lpratingsystem;
}

struct PBDAParentalControl
{
    uint rating_system_count;
    RATING_SYSTEM* rating_systems;
}

const GUID CLSID_EVENTID_TuneFailureEvent = {0xD97287B2, 0x2DFD, 0x436A, [0x94, 0x85, 0x99, 0xD7, 0xD4, 0xAB, 0x5A, 0x69]};
@GUID(0xD97287B2, 0x2DFD, 0x436A, [0x94, 0x85, 0x99, 0xD7, 0xD4, 0xAB, 0x5A, 0x69]);
struct EVENTID_TuneFailureEvent;

const GUID CLSID_EVENTID_TuneFailureSpanningEvent = {0x6F8AA455, 0x5EE1, 0x48AB, [0xA2, 0x7C, 0x4C, 0x8D, 0x70, 0xB9, 0xAE, 0xBA]};
@GUID(0x6F8AA455, 0x5EE1, 0x48AB, [0xA2, 0x7C, 0x4C, 0x8D, 0x70, 0xB9, 0xAE, 0xBA]);
struct EVENTID_TuneFailureSpanningEvent;

const GUID CLSID_EVENTID_DvbParentalRatingDescriptor = {0x2A67A58D, 0xECA5, 0x4EAC, [0xAB, 0xCB, 0xE7, 0x34, 0xD3, 0x77, 0x6D, 0x0A]};
@GUID(0x2A67A58D, 0xECA5, 0x4EAC, [0xAB, 0xCB, 0xE7, 0x34, 0xD3, 0x77, 0x6D, 0x0A]);
struct EVENTID_DvbParentalRatingDescriptor;

struct DvbParentalRatingParam
{
    byte szCountryCode;
    ubyte bRating;
}

struct DvbParentalRatingDescriptor
{
    uint ulNumParams;
    DvbParentalRatingParam pParams;
}

const GUID CLSID_EVENTID_DFNWithNoActualAVData = {0xF5689FFE, 0x55F9, 0x4BB3, [0x96, 0xBE, 0xAE, 0x97, 0x1C, 0x63, 0xBA, 0xE0]};
@GUID(0xF5689FFE, 0x55F9, 0x4BB3, [0x96, 0xBE, 0xAE, 0x97, 0x1C, 0x63, 0xBA, 0xE0]);
struct EVENTID_DFNWithNoActualAVData;

const GUID CLSID_KSDATAFORMAT_TYPE_BDA_ANTENNA = {0x71985F41, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F41, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSDATAFORMAT_TYPE_BDA_ANTENNA;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_MPEG2_TRANSPORT = {0xF4AEB342, 0x0329, 0x4FDD, [0xA8, 0xFD, 0x4A, 0xFF, 0x49, 0x26, 0xC9, 0x78]};
@GUID(0xF4AEB342, 0x0329, 0x4FDD, [0xA8, 0xFD, 0x4A, 0xFF, 0x49, 0x26, 0xC9, 0x78]);
struct KSDATAFORMAT_SUBTYPE_BDA_MPEG2_TRANSPORT;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_BDA_TRANSPORT = {0x8DEDA6FD, 0xAC5F, 0x4334, [0x8E, 0xCF, 0xA4, 0xBA, 0x8F, 0xA7, 0xD0, 0xF0]};
@GUID(0x8DEDA6FD, 0xAC5F, 0x4334, [0x8E, 0xCF, 0xA4, 0xBA, 0x8F, 0xA7, 0xD0, 0xF0]);
struct KSDATAFORMAT_SPECIFIER_BDA_TRANSPORT;

const GUID CLSID_KSDATAFORMAT_TYPE_BDA_IF_SIGNAL = {0x61BE0B47, 0xA5EB, 0x499B, [0x9A, 0x85, 0x5B, 0x16, 0xC0, 0x7F, 0x12, 0x58]};
@GUID(0x61BE0B47, 0xA5EB, 0x499B, [0x9A, 0x85, 0x5B, 0x16, 0xC0, 0x7F, 0x12, 0x58]);
struct KSDATAFORMAT_TYPE_BDA_IF_SIGNAL;

const GUID CLSID_KSDATAFORMAT_TYPE_MPEG2_SECTIONS = {0x455F176C, 0x4B06, 0x47CE, [0x9A, 0xEF, 0x8C, 0xAE, 0xF7, 0x3D, 0xF7, 0xB5]};
@GUID(0x455F176C, 0x4B06, 0x47CE, [0x9A, 0xEF, 0x8C, 0xAE, 0xF7, 0x3D, 0xF7, 0xB5]);
struct KSDATAFORMAT_TYPE_MPEG2_SECTIONS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_ATSC_SI = {0xB3C7397C, 0xD303, 0x414D, [0xB3, 0x3C, 0x4E, 0xD2, 0xC9, 0xD2, 0x97, 0x33]};
@GUID(0xB3C7397C, 0xD303, 0x414D, [0xB3, 0x3C, 0x4E, 0xD2, 0xC9, 0xD2, 0x97, 0x33]);
struct KSDATAFORMAT_SUBTYPE_ATSC_SI;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_DVB_SI = {0xE9DD31A3, 0x221D, 0x4ADB, [0x85, 0x32, 0x9A, 0xF3, 0x09, 0xC1, 0xA4, 0x08]};
@GUID(0xE9DD31A3, 0x221D, 0x4ADB, [0x85, 0x32, 0x9A, 0xF3, 0x09, 0xC1, 0xA4, 0x08]);
struct KSDATAFORMAT_SUBTYPE_DVB_SI;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_PSIP = {0x762E3F66, 0x336F, 0x48D1, [0xBF, 0x83, 0x2B, 0x00, 0x35, 0x2C, 0x11, 0xF0]};
@GUID(0x762E3F66, 0x336F, 0x48D1, [0xBF, 0x83, 0x2B, 0x00, 0x35, 0x2C, 0x11, 0xF0]);
struct KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_PSIP;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_OOB_PSIP = {0x951727DB, 0xD2CE, 0x4528, [0x96, 0xF6, 0x33, 0x01, 0xFA, 0xBB, 0x2D, 0xE0]};
@GUID(0x951727DB, 0xD2CE, 0x4528, [0x96, 0xF6, 0x33, 0x01, 0xFA, 0xBB, 0x2D, 0xE0]);
struct KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_OOB_PSIP;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_ISDB_SI = {0x4A2EEB99, 0x6458, 0x4538, [0xB1, 0x87, 0x04, 0x01, 0x7C, 0x41, 0x41, 0x3F]};
@GUID(0x4A2EEB99, 0x6458, 0x4538, [0xB1, 0x87, 0x04, 0x01, 0x7C, 0x41, 0x41, 0x3F]);
struct KSDATAFORMAT_SUBTYPE_ISDB_SI;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_PBDA_TRANSPORT_RAW = {0x0D7AED42, 0xCB9A, 0x11DB, [0x97, 0x05, 0x00, 0x50, 0x56, 0xC0, 0x00, 0x08]};
@GUID(0x0D7AED42, 0xCB9A, 0x11DB, [0x97, 0x05, 0x00, 0x50, 0x56, 0xC0, 0x00, 0x08]);
struct KSDATAFORMAT_SUBTYPE_PBDA_TRANSPORT_RAW;

const GUID CLSID_PINNAME_BDA_TRANSPORT = {0x78216A81, 0xCFA8, 0x493E, [0x97, 0x11, 0x36, 0xA6, 0x1C, 0x08, 0xBD, 0x9D]};
@GUID(0x78216A81, 0xCFA8, 0x493E, [0x97, 0x11, 0x36, 0xA6, 0x1C, 0x08, 0xBD, 0x9D]);
struct PINNAME_BDA_TRANSPORT;

const GUID CLSID_PINNAME_BDA_ANALOG_VIDEO = {0x5C0C8281, 0x5667, 0x486C, [0x84, 0x82, 0x63, 0xE3, 0x1F, 0x01, 0xA6, 0xE9]};
@GUID(0x5C0C8281, 0x5667, 0x486C, [0x84, 0x82, 0x63, 0xE3, 0x1F, 0x01, 0xA6, 0xE9]);
struct PINNAME_BDA_ANALOG_VIDEO;

const GUID CLSID_PINNAME_BDA_ANALOG_AUDIO = {0xD28A580A, 0x9B1F, 0x4B0C, [0x9C, 0x33, 0x9B, 0xF0, 0xA8, 0xEA, 0x63, 0x6B]};
@GUID(0xD28A580A, 0x9B1F, 0x4B0C, [0x9C, 0x33, 0x9B, 0xF0, 0xA8, 0xEA, 0x63, 0x6B]);
struct PINNAME_BDA_ANALOG_AUDIO;

const GUID CLSID_PINNAME_BDA_FM_RADIO = {0xD2855FED, 0xB2D3, 0x4EEB, [0x9B, 0xD0, 0x19, 0x34, 0x36, 0xA2, 0xF8, 0x90]};
@GUID(0xD2855FED, 0xB2D3, 0x4EEB, [0x9B, 0xD0, 0x19, 0x34, 0x36, 0xA2, 0xF8, 0x90]);
struct PINNAME_BDA_FM_RADIO;

const GUID CLSID_PINNAME_BDA_IF_PIN = {0x1A9D4A42, 0xF3CD, 0x48A1, [0x9A, 0xEA, 0x71, 0xDE, 0x13, 0x3C, 0xBE, 0x14]};
@GUID(0x1A9D4A42, 0xF3CD, 0x48A1, [0x9A, 0xEA, 0x71, 0xDE, 0x13, 0x3C, 0xBE, 0x14]);
struct PINNAME_BDA_IF_PIN;

const GUID CLSID_PINNAME_BDA_OPENCABLE_PSIP_PIN = {0x297BB104, 0xE5C9, 0x4ACE, [0xB1, 0x23, 0x95, 0xC3, 0xCB, 0xB2, 0x4D, 0x4F]};
@GUID(0x297BB104, 0xE5C9, 0x4ACE, [0xB1, 0x23, 0x95, 0xC3, 0xCB, 0xB2, 0x4D, 0x4F]);
struct PINNAME_BDA_OPENCABLE_PSIP_PIN;

const GUID CLSID_KSPROPSETID_BdaEthernetFilter = {0x71985F43, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F43, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSPROPSETID_BdaEthernetFilter;

enum KSPROPERTY_BDA_ETHERNET_FILTER
{
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST_SIZE = 0,
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST = 1,
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_MODE = 2,
}

const GUID CLSID_KSPROPSETID_BdaIPv4Filter = {0x71985F44, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F44, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSPROPSETID_BdaIPv4Filter;

enum KSPROPERTY_BDA_IPv4_FILTER
{
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST_SIZE = 0,
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST = 1,
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_MODE = 2,
}

const GUID CLSID_KSPROPSETID_BdaIPv6Filter = {0xE1785A74, 0x2A23, 0x4FB3, [0x92, 0x45, 0xA8, 0xF8, 0x80, 0x17, 0xEF, 0x33]};
@GUID(0xE1785A74, 0x2A23, 0x4FB3, [0x92, 0x45, 0xA8, 0xF8, 0x80, 0x17, 0xEF, 0x33]);
struct KSPROPSETID_BdaIPv6Filter;

enum KSPROPERTY_BDA_IPv6_FILTER
{
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST_SIZE = 0,
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST = 1,
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_MODE = 2,
}

const GUID CLSID_KSPROPSETID_BdaSignalStats = {0x1347D106, 0xCF3A, 0x428A, [0xA5, 0xCB, 0xAC, 0x0D, 0x9A, 0x2A, 0x43, 0x38]};
@GUID(0x1347D106, 0xCF3A, 0x428A, [0xA5, 0xCB, 0xAC, 0x0D, 0x9A, 0x2A, 0x43, 0x38]);
struct KSPROPSETID_BdaSignalStats;

enum KSPROPERTY_BDA_SIGNAL_STATS
{
    KSPROPERTY_BDA_SIGNAL_STRENGTH = 0,
    KSPROPERTY_BDA_SIGNAL_QUALITY = 1,
    KSPROPERTY_BDA_SIGNAL_PRESENT = 2,
    KSPROPERTY_BDA_SIGNAL_LOCKED = 3,
    KSPROPERTY_BDA_SAMPLE_TIME = 4,
    KSPROPERTY_BDA_SIGNAL_LOCK_CAPS = 5,
    KSPROPERTY_BDA_SIGNAL_LOCK_TYPE = 6,
}

enum _BdaLockType
{
    Bda_LockType_None = 0,
    Bda_LockType_PLL = 1,
    Bda_LockType_DecoderDemod = 2,
    Bda_LockType_Complete = 128,
}

const GUID CLSID_KSMETHODSETID_BdaChangeSync = {0xFD0A5AF3, 0xB41D, 0x11D2, [0x9C, 0x95, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xFD0A5AF3, 0xB41D, 0x11D2, [0x9C, 0x95, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSMETHODSETID_BdaChangeSync;

enum KSMETHOD_BDA_CHANGE_SYNC
{
    KSMETHOD_BDA_START_CHANGES = 0,
    KSMETHOD_BDA_CHECK_CHANGES = 1,
    KSMETHOD_BDA_COMMIT_CHANGES = 2,
    KSMETHOD_BDA_GET_CHANGE_STATE = 3,
}

const GUID CLSID_KSMETHODSETID_BdaDeviceConfiguration = {0x71985F45, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F45, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSMETHODSETID_BdaDeviceConfiguration;

enum KSMETHOD_BDA_DEVICE_CONFIGURATION
{
    KSMETHOD_BDA_CREATE_PIN_FACTORY = 0,
    KSMETHOD_BDA_DELETE_PIN_FACTORY = 1,
    KSMETHOD_BDA_CREATE_TOPOLOGY = 2,
}

const GUID CLSID_KSPROPSETID_BdaTopology = {0xA14EE835, 0x0A23, 0x11D3, [0x9C, 0xC7, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xA14EE835, 0x0A23, 0x11D3, [0x9C, 0xC7, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSPROPSETID_BdaTopology;

enum KSPROPERTY_BDA_TOPOLOGY
{
    KSPROPERTY_BDA_NODE_TYPES = 0,
    KSPROPERTY_BDA_PIN_TYPES = 1,
    KSPROPERTY_BDA_TEMPLATE_CONNECTIONS = 2,
    KSPROPERTY_BDA_NODE_METHODS = 3,
    KSPROPERTY_BDA_NODE_PROPERTIES = 4,
    KSPROPERTY_BDA_NODE_EVENTS = 5,
    KSPROPERTY_BDA_CONTROLLING_PIN_ID = 6,
    KSPROPERTY_BDA_NODE_DESCRIPTORS = 7,
}

const GUID CLSID_KSPROPSETID_BdaPinControl = {0x0DED49D5, 0xA8B7, 0x4D5D, [0x97, 0xA1, 0x12, 0xB0, 0xC1, 0x95, 0x87, 0x4D]};
@GUID(0x0DED49D5, 0xA8B7, 0x4D5D, [0x97, 0xA1, 0x12, 0xB0, 0xC1, 0x95, 0x87, 0x4D]);
struct KSPROPSETID_BdaPinControl;

enum KSPROPERTY_BDA_PIN_CONTROL
{
    KSPROPERTY_BDA_PIN_ID = 0,
    KSPROPERTY_BDA_PIN_TYPE = 1,
}

const GUID CLSID_KSEVENTSETID_BdaPinEvent = {0x104781CD, 0x50BD, 0x40D5, [0x95, 0xFB, 0x08, 0x7E, 0x0E, 0x86, 0xA5, 0x91]};
@GUID(0x104781CD, 0x50BD, 0x40D5, [0x95, 0xFB, 0x08, 0x7E, 0x0E, 0x86, 0xA5, 0x91]);
struct KSEVENTSETID_BdaPinEvent;

enum KSPROPERTY_BDA_PIN_EVENT
{
    KSEVENT_BDA_PIN_CONNECTED = 0,
    KSEVENT_BDA_PIN_DISCONNECTED = 1,
}

const GUID CLSID_KSPROPSETID_BdaVoidTransform = {0x71985F46, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F46, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSPROPSETID_BdaVoidTransform;

enum KSPROPERTY_BDA_VOID_TRANSFORM
{
    KSPROPERTY_BDA_VOID_TRANSFORM_START = 0,
    KSPROPERTY_BDA_VOID_TRANSFORM_STOP = 1,
}

const GUID CLSID_KSPROPSETID_BdaNullTransform = {0xDDF15B0D, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xDDF15B0D, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSPROPSETID_BdaNullTransform;

enum KSPROPERTY_BDA_NULL_TRANSFORM
{
    KSPROPERTY_BDA_NULL_TRANSFORM_START = 0,
    KSPROPERTY_BDA_NULL_TRANSFORM_STOP = 1,
}

const GUID CLSID_KSPROPSETID_BdaFrequencyFilter = {0x71985F47, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F47, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSPROPSETID_BdaFrequencyFilter;

enum KSPROPERTY_BDA_FREQUENCY_FILTER
{
    KSPROPERTY_BDA_RF_TUNER_FREQUENCY = 0,
    KSPROPERTY_BDA_RF_TUNER_POLARITY = 1,
    KSPROPERTY_BDA_RF_TUNER_RANGE = 2,
    KSPROPERTY_BDA_RF_TUNER_TRANSPONDER = 3,
    KSPROPERTY_BDA_RF_TUNER_BANDWIDTH = 4,
    KSPROPERTY_BDA_RF_TUNER_FREQUENCY_MULTIPLIER = 5,
    KSPROPERTY_BDA_RF_TUNER_CAPS = 6,
    KSPROPERTY_BDA_RF_TUNER_SCAN_STATUS = 7,
    KSPROPERTY_BDA_RF_TUNER_STANDARD = 8,
    KSPROPERTY_BDA_RF_TUNER_STANDARD_MODE = 9,
}

enum _BdaSignalType
{
    Bda_SignalType_Unknown = 0,
    Bda_SignalType_Analog = 1,
    Bda_SignalType_Digital = 2,
}

enum BDA_DigitalSignalStandard
{
    Bda_DigitalStandard_None = 0,
    Bda_DigitalStandard_DVB_T = 1,
    Bda_DigitalStandard_DVB_S = 2,
    Bda_DigitalStandard_DVB_C = 4,
    Bda_DigitalStandard_ATSC = 8,
    Bda_DigitalStandard_ISDB_T = 16,
    Bda_DigitalStandard_ISDB_S = 32,
    Bda_DigitalStandard_ISDB_C = 64,
}

struct KSPROPERTY_BDA_RF_TUNER_CAPS_S
{
    KSP_NODE Property;
    uint Mode;
    uint AnalogStandardsSupported;
    uint DigitalStandardsSupported;
    uint MinFrequency;
    uint MaxFrequency;
    uint SettlingTime;
    uint AnalogSensingRange;
    uint DigitalSensingRange;
    uint MilliSecondsPerMHz;
}

struct KSPROPERTY_BDA_RF_TUNER_SCAN_STATUS_S
{
    KSP_NODE Property;
    uint CurrentFrequency;
    uint FrequencyRangeMin;
    uint FrequencyRangeMax;
    uint MilliSecondsLeft;
}

struct KSPROPERTY_BDA_RF_TUNER_STANDARD_S
{
    KSP_NODE Property;
    _BdaSignalType SignalType;
    uint SignalStandard;
}

struct KSPROPERTY_BDA_RF_TUNER_STANDARD_MODE_S
{
    KSP_NODE Property;
    BOOL AutoDetect;
}

const GUID CLSID_KSEVENTSETID_BdaTunerEvent = {0xAAB59E17, 0x01C9, 0x4EBF, [0x93, 0xF2, 0xFC, 0x3B, 0x79, 0xB4, 0x6F, 0x91]};
@GUID(0xAAB59E17, 0x01C9, 0x4EBF, [0x93, 0xF2, 0xFC, 0x3B, 0x79, 0xB4, 0x6F, 0x91]);
struct KSEVENTSETID_BdaTunerEvent;

enum KSEVENT_BDA_TUNER
{
    KSEVENT_BDA_TUNER_SCAN = 0,
}

struct KSEVENTDATA_BDA_RF_TUNER_SCAN_S
{
    KSEVENTDATA EventData;
    uint StartFrequency;
    uint EndFrequency;
    _BdaLockType LockRequested;
}

const GUID CLSID_KSPROPSETID_BdaLNBInfo = {0x992CF102, 0x49F9, 0x4719, [0xA6, 0x64, 0xC4, 0xF2, 0x3E, 0x24, 0x08, 0xF4]};
@GUID(0x992CF102, 0x49F9, 0x4719, [0xA6, 0x64, 0xC4, 0xF2, 0x3E, 0x24, 0x08, 0xF4]);
struct KSPROPSETID_BdaLNBInfo;

enum KSPROPERTY_BDA_LNB_INFO
{
    KSPROPERTY_BDA_LNB_LOF_LOW_BAND = 0,
    KSPROPERTY_BDA_LNB_LOF_HIGH_BAND = 1,
    KSPROPERTY_BDA_LNB_SWITCH_FREQUENCY = 2,
}

const GUID CLSID_KSPROPSETID_BdaDiseqCommand = {0xF84E2AB0, 0x3C6B, 0x45E3, [0xA0, 0xFC, 0x86, 0x69, 0xD4, 0xB8, 0x1F, 0x11]};
@GUID(0xF84E2AB0, 0x3C6B, 0x45E3, [0xA0, 0xFC, 0x86, 0x69, 0xD4, 0xB8, 0x1F, 0x11]);
struct KSPROPSETID_BdaDiseqCommand;

enum KSPROPERTY_BDA_DISEQC_COMMAND
{
    KSPROPERTY_BDA_DISEQC_ENABLE = 0,
    KSPROPERTY_BDA_DISEQC_LNB_SOURCE = 1,
    KSPROPERTY_BDA_DISEQC_USETONEBURST = 2,
    KSPROPERTY_BDA_DISEQC_REPEATS = 3,
    KSPROPERTY_BDA_DISEQC_SEND = 4,
    KSPROPERTY_BDA_DISEQC_RESPONSE = 5,
}

const GUID CLSID_KSEVENTSETID_BdaDiseqCEvent = {0x8B19BBF0, 0x4184, 0x43AC, [0xAD, 0x3C, 0x0C, 0x88, 0x9B, 0xE4, 0xC2, 0x12]};
@GUID(0x8B19BBF0, 0x4184, 0x43AC, [0xAD, 0x3C, 0x0C, 0x88, 0x9B, 0xE4, 0xC2, 0x12]);
struct KSEVENTSETID_BdaDiseqCEvent;

enum KSPROPERTY_BDA_DISEQC_EVENT
{
    KSEVENT_BDA_DISEQC_DATA_RECEIVED = 0,
}

const GUID CLSID_KSPROPSETID_BdaDigitalDemodulator = {0xEF30F379, 0x985B, 0x4D10, [0xB6, 0x40, 0xA7, 0x9D, 0x5E, 0x04, 0xE1, 0xE0]};
@GUID(0xEF30F379, 0x985B, 0x4D10, [0xB6, 0x40, 0xA7, 0x9D, 0x5E, 0x04, 0xE1, 0xE0]);
struct KSPROPSETID_BdaDigitalDemodulator;

enum KSPROPERTY_BDA_DIGITAL_DEMODULATOR
{
    KSPROPERTY_BDA_MODULATION_TYPE = 0,
    KSPROPERTY_BDA_INNER_FEC_TYPE = 1,
    KSPROPERTY_BDA_INNER_FEC_RATE = 2,
    KSPROPERTY_BDA_OUTER_FEC_TYPE = 3,
    KSPROPERTY_BDA_OUTER_FEC_RATE = 4,
    KSPROPERTY_BDA_SYMBOL_RATE = 5,
    KSPROPERTY_BDA_SPECTRAL_INVERSION = 6,
    KSPROPERTY_BDA_GUARD_INTERVAL = 7,
    KSPROPERTY_BDA_TRANSMISSION_MODE = 8,
    KSPROPERTY_BDA_ROLL_OFF = 9,
    KSPROPERTY_BDA_PILOT = 10,
    KSPROPERTY_BDA_SIGNALTIMEOUTS = 11,
    KSPROPERTY_BDA_PLP_NUMBER = 12,
}

const GUID CLSID_KSPROPSETID_BdaAutodemodulate = {0xDDF15B12, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xDDF15B12, 0xBD25, 0x11D2, [0x9C, 0xA0, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSPROPSETID_BdaAutodemodulate;

enum KSPROPERTY_BDA_AUTODEMODULATE
{
    KSPROPERTY_BDA_AUTODEMODULATE_START = 0,
    KSPROPERTY_BDA_AUTODEMODULATE_STOP = 1,
}

const GUID CLSID_KSPROPSETID_BdaTableSection = {0x516B99C5, 0x971C, 0x4AAF, [0xB3, 0xF3, 0xD9, 0xFD, 0xA8, 0xA1, 0x5E, 0x16]};
@GUID(0x516B99C5, 0x971C, 0x4AAF, [0xB3, 0xF3, 0xD9, 0xFD, 0xA8, 0xA1, 0x5E, 0x16]);
struct KSPROPSETID_BdaTableSection;

enum KSPROPERTY_IDS_BDA_TABLE
{
    KSPROPERTY_BDA_TABLE_SECTION = 0,
}

const GUID CLSID_KSPROPSETID_BdaPIDFilter = {0xD0A67D65, 0x08DF, 0x4FEC, [0x85, 0x33, 0xE5, 0xB5, 0x50, 0x41, 0x0B, 0x85]};
@GUID(0xD0A67D65, 0x08DF, 0x4FEC, [0x85, 0x33, 0xE5, 0xB5, 0x50, 0x41, 0x0B, 0x85]);
struct KSPROPSETID_BdaPIDFilter;

enum KSPROPERTY_BDA_PIDFILTER
{
    KSPROPERTY_BDA_PIDFILTER_MAP_PIDS = 0,
    KSPROPERTY_BDA_PIDFILTER_UNMAP_PIDS = 1,
    KSPROPERTY_BDA_PIDFILTER_LIST_PIDS = 2,
}

const GUID CLSID_KSPROPSETID_BdaCA = {0xB0693766, 0x5278, 0x4EC6, [0xB9, 0xE1, 0x3C, 0xE4, 0x05, 0x60, 0xEF, 0x5A]};
@GUID(0xB0693766, 0x5278, 0x4EC6, [0xB9, 0xE1, 0x3C, 0xE4, 0x05, 0x60, 0xEF, 0x5A]);
struct KSPROPSETID_BdaCA;

enum KSPROPERTY_BDA_CA
{
    KSPROPERTY_BDA_ECM_MAP_STATUS = 0,
    KSPROPERTY_BDA_CA_MODULE_STATUS = 1,
    KSPROPERTY_BDA_CA_SMART_CARD_STATUS = 2,
    KSPROPERTY_BDA_CA_MODULE_UI = 3,
    KSPROPERTY_BDA_CA_SET_PROGRAM_PIDS = 4,
    KSPROPERTY_BDA_CA_REMOVE_PROGRAM = 5,
}

const GUID CLSID_KSEVENTSETID_BdaCAEvent = {0x488C4CCC, 0xB768, 0x4129, [0x8E, 0xB1, 0xB0, 0x0A, 0x07, 0x1F, 0x90, 0x68]};
@GUID(0x488C4CCC, 0xB768, 0x4129, [0x8E, 0xB1, 0xB0, 0x0A, 0x07, 0x1F, 0x90, 0x68]);
struct KSEVENTSETID_BdaCAEvent;

enum KSPROPERTY_BDA_CA_EVENT
{
    KSEVENT_BDA_PROGRAM_FLOW_STATUS_CHANGED = 0,
    KSEVENT_BDA_CA_MODULE_STATUS_CHANGED = 1,
    KSEVENT_BDA_CA_SMART_CARD_STATUS_CHANGED = 2,
    KSEVENT_BDA_CA_MODULE_UI_REQUESTED = 3,
}

const GUID CLSID_KSMETHODSETID_BdaDrmService = {0xBFF6B5BB, 0xB0AE, 0x484C, [0x9D, 0xCA, 0x73, 0x52, 0x8F, 0xB0, 0xB4, 0x6E]};
@GUID(0xBFF6B5BB, 0xB0AE, 0x484C, [0x9D, 0xCA, 0x73, 0x52, 0x8F, 0xB0, 0xB4, 0x6E]);
struct KSMETHODSETID_BdaDrmService;

enum KSMETHOD_BDA_DRM
{
    KSMETHOD_BDA_DRM_CURRENT = 0,
    KSMETHOD_BDA_DRM_DRMSTATUS = 1,
}

const GUID CLSID_KSMETHODSETID_BdaWmdrmSession = {0x4BE6FA3D, 0x07CD, 0x4139, [0x8B, 0x80, 0x8C, 0x18, 0xBA, 0x3A, 0xEC, 0x88]};
@GUID(0x4BE6FA3D, 0x07CD, 0x4139, [0x8B, 0x80, 0x8C, 0x18, 0xBA, 0x3A, 0xEC, 0x88]);
struct KSMETHODSETID_BdaWmdrmSession;

enum KSMETHOD_BDA_WMDRM
{
    KSMETHOD_BDA_WMDRM_STATUS = 0,
    KSMETHOD_BDA_WMDRM_REVINFO = 1,
    KSMETHOD_BDA_WMDRM_CRL = 2,
    KSMETHOD_BDA_WMDRM_MESSAGE = 3,
    KSMETHOD_BDA_WMDRM_REISSUELICENSE = 4,
    KSMETHOD_BDA_WMDRM_RENEWLICENSE = 5,
    KSMETHOD_BDA_WMDRM_LICENSE = 6,
    KSMETHOD_BDA_WMDRM_KEYINFO = 7,
}

const GUID CLSID_KSMETHODSETID_BdaWmdrmTuner = {0x86D979CF, 0xA8A7, 0x4F94, [0xB5, 0xFB, 0x14, 0xC0, 0xAC, 0xA6, 0x8F, 0xE6]};
@GUID(0x86D979CF, 0xA8A7, 0x4F94, [0xB5, 0xFB, 0x14, 0xC0, 0xAC, 0xA6, 0x8F, 0xE6]);
struct KSMETHODSETID_BdaWmdrmTuner;

enum KSMETHOD_BDA_WMDRM_TUNER
{
    KSMETHOD_BDA_WMDRMTUNER_CANCELCAPTURETOKEN = 0,
    KSMETHOD_BDA_WMDRMTUNER_SETPIDPROTECTION = 1,
    KSMETHOD_BDA_WMDRMTUNER_GETPIDPROTECTION = 2,
    KSMETHOD_BDA_WMDRMTUNER_SETSYNCVALUE = 3,
    KSMETHOD_BDA_WMDRMTUNER_STARTCODEPROFILE = 4,
    KSMETHOD_BDA_WMDRMTUNER_PURCHASE_ENTITLEMENT = 5,
}

const GUID CLSID_KSMETHODSETID_BdaEventing = {0xF99492DA, 0x6193, 0x4EB0, [0x86, 0x90, 0x66, 0x86, 0xCB, 0xFF, 0x71, 0x3E]};
@GUID(0xF99492DA, 0x6193, 0x4EB0, [0x86, 0x90, 0x66, 0x86, 0xCB, 0xFF, 0x71, 0x3E]);
struct KSMETHODSETID_BdaEventing;

enum KSMETHOD_BDA_EVENTING_SERVICE
{
    KSMETHOD_BDA_EVENT_DATA = 0,
    KSMETHOD_BDA_EVENT_COMPLETE = 1,
}

const GUID CLSID_KSEVENTSETID_BdaEvent = {0xAE7E55B2, 0x96D7, 0x4E29, [0x90, 0x8F, 0x62, 0xF9, 0x5B, 0x2A, 0x16, 0x79]};
@GUID(0xAE7E55B2, 0x96D7, 0x4E29, [0x90, 0x8F, 0x62, 0xF9, 0x5B, 0x2A, 0x16, 0x79]);
struct KSEVENTSETID_BdaEvent;

enum KSEVENT_BDA_EVENT_TYPE
{
    KSEVENT_BDA_EVENT_PENDINGEVENT = 0,
}

const GUID CLSID_KSMETHODSETID_BdaDebug = {0x0D4A90EC, 0xC69D, 0x4EE2, [0x8C, 0x5A, 0xFB, 0x1F, 0x63, 0xA5, 0x0D, 0xA1]};
@GUID(0x0D4A90EC, 0xC69D, 0x4EE2, [0x8C, 0x5A, 0xFB, 0x1F, 0x63, 0xA5, 0x0D, 0xA1]);
struct KSMETHODSETID_BdaDebug;

enum KSMETHOD_BDA_DEBUG_SERVICE
{
    KSMETHOD_BDA_DEBUG_LEVEL = 0,
    KSMETHOD_BDA_DEBUG_DATA = 1,
}

const GUID CLSID_KSMETHODSETID_BdaTuner = {0xB774102F, 0xAC07, 0x478A, [0x82, 0x28, 0x27, 0x42, 0xD9, 0x61, 0xFA, 0x7E]};
@GUID(0xB774102F, 0xAC07, 0x478A, [0x82, 0x28, 0x27, 0x42, 0xD9, 0x61, 0xFA, 0x7E]);
struct KSMETHODSETID_BdaTuner;

enum KSMETHOD_BDA_TUNER_SERVICE
{
    KSMETHOD_BDA_TUNER_SETTUNER = 0,
    KSMETHOD_BDA_TUNER_GETTUNERSTATE = 1,
    KSMETHOD_BDA_TUNER_SIGNALNOISERATIO = 2,
}

const GUID CLSID_KSMETHODSETID_BdaNameValueA = {0x0C24096D, 0x5FF5, 0x47DE, [0xA8, 0x56, 0x06, 0x2E, 0x58, 0x7E, 0x37, 0x27]};
@GUID(0x0C24096D, 0x5FF5, 0x47DE, [0xA8, 0x56, 0x06, 0x2E, 0x58, 0x7E, 0x37, 0x27]);
struct KSMETHODSETID_BdaNameValueA;

const GUID CLSID_KSMETHODSETID_BdaNameValue = {0x36E07304, 0x9F0D, 0x4E88, [0x91, 0x18, 0xAC, 0x0B, 0xA3, 0x17, 0xB7, 0xF2]};
@GUID(0x36E07304, 0x9F0D, 0x4E88, [0x91, 0x18, 0xAC, 0x0B, 0xA3, 0x17, 0xB7, 0xF2]);
struct KSMETHODSETID_BdaNameValue;

enum KSMETHOD_BDA_GPNV_SERVICE
{
    KSMETHOD_BDA_GPNV_GETVALUE = 0,
    KSMETHOD_BDA_GPNV_SETVALUE = 1,
    KSMETHOD_BDA_GPNV_NAMEFROMINDEX = 2,
    KSMETHOD_BDA_GPNV_GETVALUEUPDATENAME = 3,
}

const GUID CLSID_KSMETHODSETID_BdaMux = {0x942AAFEC, 0x4C05, 0x4C74, [0xB8, 0xEB, 0x87, 0x06, 0xC2, 0xA4, 0x94, 0x3F]};
@GUID(0x942AAFEC, 0x4C05, 0x4C74, [0xB8, 0xEB, 0x87, 0x06, 0xC2, 0xA4, 0x94, 0x3F]);
struct KSMETHODSETID_BdaMux;

enum KSMETHOD_BDA_MUX_SERVICE
{
    KSMETHOD_BDA_MUX_GETPIDLIST = 0,
    KSMETHOD_BDA_MUX_SETPIDLIST = 1,
}

const GUID CLSID_KSMETHODSETID_BdaScanning = {0x12EB49DF, 0x6249, 0x47F3, [0xB1, 0x90, 0xE2, 0x1E, 0x6E, 0x2F, 0x8A, 0x9C]};
@GUID(0x12EB49DF, 0x6249, 0x47F3, [0xB1, 0x90, 0xE2, 0x1E, 0x6E, 0x2F, 0x8A, 0x9C]);
struct KSMETHODSETID_BdaScanning;

enum KSMETHOD_BDA_SCAN_SERVICE
{
    KSMETHOD_BDA_SCAN_CAPABILTIES = 0,
    KSMETHOD_BDA_SCANNING_STATE = 1,
    KSMETHOD_BDA_SCAN_FILTER = 2,
    KSMETHOD_BDA_SCAN_START = 3,
    KSMETHOD_BDA_SCAN_RESUME = 4,
    KSMETHOD_BDA_SCAN_STOP = 5,
}

const GUID CLSID_KSMETHODSETID_BdaGuideDataDeliveryService = {0x8D9D5562, 0x1589, 0x417D, [0x99, 0xCE, 0xAC, 0x53, 0x1D, 0xDA, 0x19, 0xF9]};
@GUID(0x8D9D5562, 0x1589, 0x417D, [0x99, 0xCE, 0xAC, 0x53, 0x1D, 0xDA, 0x19, 0xF9]);
struct KSMETHODSETID_BdaGuideDataDeliveryService;

enum KSMETHOD_BDA_GDDS_SERVICE
{
    KSMETHOD_BDA_GDDS_DATATYPE = 0,
    KSMETHOD_BDA_GDDS_DATA = 1,
    KSMETHOD_BDA_GDDS_TUNEXMLFROMIDX = 2,
    KSMETHOD_BDA_GDDS_GETSERVICES = 3,
    KSMETHOD_BDA_GDDS_SERVICEFROMTUNEXML = 4,
    KSMETHOD_BDA_GDDS_DATAUPDATE = 5,
}

const GUID CLSID_KSMETHODSETID_BdaConditionalAccessService = {0x10CED3B4, 0x320B, 0x41BF, [0x98, 0x24, 0x1B, 0x2E, 0x68, 0xE7, 0x1E, 0xB9]};
@GUID(0x10CED3B4, 0x320B, 0x41BF, [0x98, 0x24, 0x1B, 0x2E, 0x68, 0xE7, 0x1E, 0xB9]);
struct KSMETHODSETID_BdaConditionalAccessService;

enum KSMETHOD_BDA_CAS_SERVICE
{
    KSMETHOD_BDA_CAS_CHECKENTITLEMENTTOKEN = 0,
    KSMETHOD_BDA_CAS_SETCAPTURETOKEN = 1,
    KSMETHOD_BDA_CAS_OPENBROADCASTMMI = 2,
    KSMETHOD_BDA_CAS_CLOSEMMIDIALOG = 3,
}

const GUID CLSID_KSMETHODSETID_BdaIsdbConditionalAccess = {0x5E68C627, 0x16C2, 0x4E6C, [0xB1, 0xE2, 0xD0, 0x01, 0x70, 0xCD, 0xAA, 0x0F]};
@GUID(0x5E68C627, 0x16C2, 0x4E6C, [0xB1, 0xE2, 0xD0, 0x01, 0x70, 0xCD, 0xAA, 0x0F]);
struct KSMETHODSETID_BdaIsdbConditionalAccess;

enum KSMETHOD_BDA_ISDB_CAS
{
    KSMETHOD_BDA_ISDBCAS_SETREQUEST = 0,
    KSMETHOD_BDA_ISDBCAS_RESPONSEDATA = 1,
}

const GUID CLSID_KSMETHODSETID_BdaTSSelector = {0x1DCFAFE9, 0xB45E, 0x41B3, [0xBB, 0x2A, 0x56, 0x1E, 0xB1, 0x29, 0xAE, 0x98]};
@GUID(0x1DCFAFE9, 0xB45E, 0x41B3, [0xBB, 0x2A, 0x56, 0x1E, 0xB1, 0x29, 0xAE, 0x98]);
struct KSMETHODSETID_BdaTSSelector;

enum KSMETHOD_BDA_TS_SELECTOR
{
    KSMETHOD_BDA_TS_SELECTOR_SETTSID = 0,
    KSMETHOD_BDA_TS_SELECTOR_GETTSINFORMATION = 1,
}

const GUID CLSID_KSMETHODSETID_BdaUserActivity = {0xEDA5C834, 0x4531, 0x483C, [0xBE, 0x0A, 0x94, 0xE6, 0xC9, 0x6F, 0xF3, 0x96]};
@GUID(0xEDA5C834, 0x4531, 0x483C, [0xBE, 0x0A, 0x94, 0xE6, 0xC9, 0x6F, 0xF3, 0x96]);
struct KSMETHODSETID_BdaUserActivity;

enum KSMETHOD_BDA_USERACTIVITY_SERVICE
{
    KSMETHOD_BDA_USERACTIVITY_USEREASON = 0,
    KSMETHOD_BDA_USERACTIVITY_INTERVAL = 1,
    KSMETHOD_BDA_USERACTIVITY_DETECTED = 2,
}

const GUID CLSID_KSCATEGORY_BDA_RECEIVER_COMPONENT = {0xFD0A5AF4, 0xB41D, 0x11D2, [0x9C, 0x95, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0xFD0A5AF4, 0xB41D, 0x11D2, [0x9C, 0x95, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSCATEGORY_BDA_RECEIVER_COMPONENT;

const GUID CLSID_KSCATEGORY_BDA_NETWORK_TUNER = {0x71985F48, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F48, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSCATEGORY_BDA_NETWORK_TUNER;

const GUID CLSID_KSCATEGORY_BDA_NETWORK_EPG = {0x71985F49, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F49, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSCATEGORY_BDA_NETWORK_EPG;

const GUID CLSID_KSCATEGORY_BDA_IP_SINK = {0x71985F4A, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F4A, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSCATEGORY_BDA_IP_SINK;

const GUID CLSID_KSCATEGORY_BDA_NETWORK_PROVIDER = {0x71985F4B, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F4B, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSCATEGORY_BDA_NETWORK_PROVIDER;

const GUID CLSID_KSCATEGORY_BDA_TRANSPORT_INFORMATION = {0xA2E3074F, 0x6C3D, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]};
@GUID(0xA2E3074F, 0x6C3D, 0x11D3, [0xB6, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0x49, 0x8E]);
struct KSCATEGORY_BDA_TRANSPORT_INFORMATION;

const GUID CLSID_KSNODE_BDA_RF_TUNER = {0x71985F4C, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F4C, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSNODE_BDA_RF_TUNER;

const GUID CLSID_KSNODE_BDA_ANALOG_DEMODULATOR = {0x634DB199, 0x27DD, 0x46B8, [0xAC, 0xFB, 0xEC, 0xC9, 0x8E, 0x61, 0xA2, 0xAD]};
@GUID(0x634DB199, 0x27DD, 0x46B8, [0xAC, 0xFB, 0xEC, 0xC9, 0x8E, 0x61, 0xA2, 0xAD]);
struct KSNODE_BDA_ANALOG_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_QAM_DEMODULATOR = {0x71985F4D, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F4D, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSNODE_BDA_QAM_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_QPSK_DEMODULATOR = {0x6390C905, 0x27C1, 0x4D67, [0xBD, 0xB7, 0x77, 0xC5, 0x0D, 0x07, 0x93, 0x00]};
@GUID(0x6390C905, 0x27C1, 0x4D67, [0xBD, 0xB7, 0x77, 0xC5, 0x0D, 0x07, 0x93, 0x00]);
struct KSNODE_BDA_QPSK_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_8VSB_DEMODULATOR = {0x71985F4F, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F4F, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSNODE_BDA_8VSB_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_COFDM_DEMODULATOR = {0x2DAC6E05, 0xEDBE, 0x4B9C, [0xB3, 0x87, 0x1B, 0x6F, 0xAD, 0x7D, 0x64, 0x95]};
@GUID(0x2DAC6E05, 0xEDBE, 0x4B9C, [0xB3, 0x87, 0x1B, 0x6F, 0xAD, 0x7D, 0x64, 0x95]);
struct KSNODE_BDA_COFDM_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_8PSK_DEMODULATOR = {0xE957A0E7, 0xDD98, 0x4A3C, [0x81, 0x0B, 0x35, 0x25, 0x15, 0x7A, 0xB6, 0x2E]};
@GUID(0xE957A0E7, 0xDD98, 0x4A3C, [0x81, 0x0B, 0x35, 0x25, 0x15, 0x7A, 0xB6, 0x2E]);
struct KSNODE_BDA_8PSK_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_ISDB_T_DEMODULATOR = {0xFCEA3AE3, 0x2CB2, 0x464D, [0x8F, 0x5D, 0x30, 0x5C, 0x0B, 0xB7, 0x78, 0xA2]};
@GUID(0xFCEA3AE3, 0x2CB2, 0x464D, [0x8F, 0x5D, 0x30, 0x5C, 0x0B, 0xB7, 0x78, 0xA2]);
struct KSNODE_BDA_ISDB_T_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_ISDB_S_DEMODULATOR = {0xEDDE230A, 0x9086, 0x432D, [0xB8, 0xA5, 0x66, 0x70, 0x26, 0x38, 0x07, 0xE9]};
@GUID(0xEDDE230A, 0x9086, 0x432D, [0xB8, 0xA5, 0x66, 0x70, 0x26, 0x38, 0x07, 0xE9]);
struct KSNODE_BDA_ISDB_S_DEMODULATOR;

const GUID CLSID_KSNODE_BDA_OPENCABLE_POD = {0x345812A0, 0xFB7C, 0x4790, [0xAA, 0x7E, 0xB1, 0xDB, 0x88, 0xAC, 0x19, 0xC9]};
@GUID(0x345812A0, 0xFB7C, 0x4790, [0xAA, 0x7E, 0xB1, 0xDB, 0x88, 0xAC, 0x19, 0xC9]);
struct KSNODE_BDA_OPENCABLE_POD;

const GUID CLSID_KSNODE_BDA_COMMON_CA_POD = {0xD83EF8FC, 0xF3B8, 0x45AB, [0x8B, 0x71, 0xEC, 0xF7, 0xC3, 0x39, 0xDE, 0xB4]};
@GUID(0xD83EF8FC, 0xF3B8, 0x45AB, [0x8B, 0x71, 0xEC, 0xF7, 0xC3, 0x39, 0xDE, 0xB4]);
struct KSNODE_BDA_COMMON_CA_POD;

const GUID CLSID_KSNODE_BDA_PID_FILTER = {0xF5412789, 0xB0A0, 0x44E1, [0xAE, 0x4F, 0xEE, 0x99, 0x9B, 0x1B, 0x7F, 0xBE]};
@GUID(0xF5412789, 0xB0A0, 0x44E1, [0xAE, 0x4F, 0xEE, 0x99, 0x9B, 0x1B, 0x7F, 0xBE]);
struct KSNODE_BDA_PID_FILTER;

const GUID CLSID_KSNODE_BDA_IP_SINK = {0x71985F4E, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]};
@GUID(0x71985F4E, 0x1CA1, 0x11D3, [0x9C, 0xC8, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE0]);
struct KSNODE_BDA_IP_SINK;

const GUID CLSID_KSNODE_BDA_VIDEO_ENCODER = {0xD98429E3, 0x65C9, 0x4AC4, [0x93, 0xAA, 0x76, 0x67, 0x82, 0x83, 0x3B, 0x7A]};
@GUID(0xD98429E3, 0x65C9, 0x4AC4, [0x93, 0xAA, 0x76, 0x67, 0x82, 0x83, 0x3B, 0x7A]);
struct KSNODE_BDA_VIDEO_ENCODER;

const GUID CLSID_KSNODE_BDA_PBDA_CAS = {0xC026869F, 0x7129, 0x4E71, [0x86, 0x96, 0xEC, 0x8F, 0x75, 0x29, 0x9B, 0x77]};
@GUID(0xC026869F, 0x7129, 0x4E71, [0x86, 0x96, 0xEC, 0x8F, 0x75, 0x29, 0x9B, 0x77]);
struct KSNODE_BDA_PBDA_CAS;

const GUID CLSID_KSNODE_BDA_PBDA_ISDBCAS = {0xF2CF2AB3, 0x5B9D, 0x40AE, [0xAB, 0x7C, 0x4E, 0x7A, 0xD0, 0xBD, 0x1C, 0x52]};
@GUID(0xF2CF2AB3, 0x5B9D, 0x40AE, [0xAB, 0x7C, 0x4E, 0x7A, 0xD0, 0xBD, 0x1C, 0x52]);
struct KSNODE_BDA_PBDA_ISDBCAS;

const GUID CLSID_KSNODE_BDA_PBDA_TUNER = {0xAA5E8286, 0x593C, 0x4979, [0x94, 0x94, 0x46, 0xA2, 0xA9, 0xDF, 0xE0, 0x76]};
@GUID(0xAA5E8286, 0x593C, 0x4979, [0x94, 0x94, 0x46, 0xA2, 0xA9, 0xDF, 0xE0, 0x76]);
struct KSNODE_BDA_PBDA_TUNER;

const GUID CLSID_KSNODE_BDA_PBDA_MUX = {0xF88C7787, 0x6678, 0x4F4B, [0xA1, 0x3E, 0xDA, 0x09, 0x86, 0x1D, 0x68, 0x2B]};
@GUID(0xF88C7787, 0x6678, 0x4F4B, [0xA1, 0x3E, 0xDA, 0x09, 0x86, 0x1D, 0x68, 0x2B]);
struct KSNODE_BDA_PBDA_MUX;

const GUID CLSID_KSNODE_BDA_PBDA_DRM = {0x9EEEBD03, 0xEEA1, 0x450F, [0x96, 0xAE, 0x63, 0x3E, 0x6D, 0xE6, 0x3C, 0xCE]};
@GUID(0x9EEEBD03, 0xEEA1, 0x450F, [0x96, 0xAE, 0x63, 0x3E, 0x6D, 0xE6, 0x3C, 0xCE]);
struct KSNODE_BDA_PBDA_DRM;

const GUID CLSID_KSNODE_BDA_DRI_DRM = {0x4F95AD74, 0xCEFB, 0x42D2, [0x94, 0xA9, 0x68, 0xC5, 0xB2, 0xC1, 0xAA, 0xBE]};
@GUID(0x4F95AD74, 0xCEFB, 0x42D2, [0x94, 0xA9, 0x68, 0xC5, 0xB2, 0xC1, 0xAA, 0xBE]);
struct KSNODE_BDA_DRI_DRM;

const GUID CLSID_KSNODE_BDA_TS_SELECTOR = {0x5EDDF185, 0xFED1, 0x4F45, [0x96, 0x85, 0xBB, 0xB7, 0x3C, 0x32, 0x3C, 0xFC]};
@GUID(0x5EDDF185, 0xFED1, 0x4F45, [0x96, 0x85, 0xBB, 0xB7, 0x3C, 0x32, 0x3C, 0xFC]);
struct KSNODE_BDA_TS_SELECTOR;

const GUID CLSID_PINNAME_IPSINK_INPUT = {0x3FDFFA70, 0xAC9A, 0x11D2, [0x8F, 0x17, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]};
@GUID(0x3FDFFA70, 0xAC9A, 0x11D2, [0x8F, 0x17, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]);
struct PINNAME_IPSINK_INPUT;

const GUID CLSID_KSDATAFORMAT_TYPE_BDA_IP = {0xE25F7B8E, 0xCCCC, 0x11D2, [0x8F, 0x25, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]};
@GUID(0xE25F7B8E, 0xCCCC, 0x11D2, [0x8F, 0x25, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]);
struct KSDATAFORMAT_TYPE_BDA_IP;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_IP = {0x5A9A213C, 0xDB08, 0x11D2, [0x8F, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]};
@GUID(0x5A9A213C, 0xDB08, 0x11D2, [0x8F, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]);
struct KSDATAFORMAT_SUBTYPE_BDA_IP;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_BDA_IP = {0x6B891420, 0xDB09, 0x11D2, [0x8F, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]};
@GUID(0x6B891420, 0xDB09, 0x11D2, [0x8F, 0x32, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]);
struct KSDATAFORMAT_SPECIFIER_BDA_IP;

const GUID CLSID_KSDATAFORMAT_TYPE_BDA_IP_CONTROL = {0xDADD5799, 0x7D5B, 0x4B63, [0x80, 0xFB, 0xD1, 0x44, 0x2F, 0x26, 0xB6, 0x21]};
@GUID(0xDADD5799, 0x7D5B, 0x4B63, [0x80, 0xFB, 0xD1, 0x44, 0x2F, 0x26, 0xB6, 0x21]);
struct KSDATAFORMAT_TYPE_BDA_IP_CONTROL;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_IP_CONTROL = {0x499856E8, 0xE85B, 0x48ED, [0x9B, 0xEA, 0x41, 0x0D, 0x0D, 0xD4, 0xEF, 0x81]};
@GUID(0x499856E8, 0xE85B, 0x48ED, [0x9B, 0xEA, 0x41, 0x0D, 0x0D, 0xD4, 0xEF, 0x81]);
struct KSDATAFORMAT_SUBTYPE_BDA_IP_CONTROL;

const GUID CLSID_PINNAME_MPE = {0xC1B06D73, 0x1DBB, 0x11D3, [0x8F, 0x46, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]};
@GUID(0xC1B06D73, 0x1DBB, 0x11D3, [0x8F, 0x46, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]);
struct PINNAME_MPE;

const GUID CLSID_KSDATAFORMAT_TYPE_MPE = {0x455F176C, 0x4B06, 0x47CE, [0x9A, 0xEF, 0x8C, 0xAE, 0xF7, 0x3D, 0xF7, 0xB5]};
@GUID(0x455F176C, 0x4B06, 0x47CE, [0x9A, 0xEF, 0x8C, 0xAE, 0xF7, 0x3D, 0xF7, 0xB5]);
struct KSDATAFORMAT_TYPE_MPE;

const GUID CLSID_DIGITAL_CABLE_NETWORK_TYPE = {0x143827AB, 0xF77B, 0x498D, [0x81, 0xCA, 0x5A, 0x00, 0x7A, 0xEC, 0x28, 0xBF]};
@GUID(0x143827AB, 0xF77B, 0x498D, [0x81, 0xCA, 0x5A, 0x00, 0x7A, 0xEC, 0x28, 0xBF]);
struct DIGITAL_CABLE_NETWORK_TYPE;

const GUID CLSID_ANALOG_TV_NETWORK_TYPE = {0xB820D87E, 0xE0E3, 0x478F, [0x8A, 0x38, 0x4E, 0x13, 0xF7, 0xB3, 0xDF, 0x42]};
@GUID(0xB820D87E, 0xE0E3, 0x478F, [0x8A, 0x38, 0x4E, 0x13, 0xF7, 0xB3, 0xDF, 0x42]);
struct ANALOG_TV_NETWORK_TYPE;

const GUID CLSID_ANALOG_AUXIN_NETWORK_TYPE = {0x742EF867, 0x09E1, 0x40A3, [0x82, 0xD3, 0x96, 0x69, 0xBA, 0x35, 0x32, 0x5F]};
@GUID(0x742EF867, 0x09E1, 0x40A3, [0x82, 0xD3, 0x96, 0x69, 0xBA, 0x35, 0x32, 0x5F]);
struct ANALOG_AUXIN_NETWORK_TYPE;

const GUID CLSID_ANALOG_FM_NETWORK_TYPE = {0x7728087B, 0x2BB9, 0x4E30, [0x80, 0x78, 0x44, 0x94, 0x76, 0xE5, 0x9D, 0xBB]};
@GUID(0x7728087B, 0x2BB9, 0x4E30, [0x80, 0x78, 0x44, 0x94, 0x76, 0xE5, 0x9D, 0xBB]);
struct ANALOG_FM_NETWORK_TYPE;

const GUID CLSID_ISDB_TERRESTRIAL_TV_NETWORK_TYPE = {0x95037F6F, 0x3AC7, 0x4452, [0xB6, 0xC4, 0x45, 0xA9, 0xCE, 0x92, 0x92, 0xA2]};
@GUID(0x95037F6F, 0x3AC7, 0x4452, [0xB6, 0xC4, 0x45, 0xA9, 0xCE, 0x92, 0x92, 0xA2]);
struct ISDB_TERRESTRIAL_TV_NETWORK_TYPE;

const GUID CLSID_ISDB_T_NETWORK_TYPE = {0xFC3855A6, 0xC901, 0x4F2E, [0xAB, 0xA8, 0x90, 0x81, 0x5A, 0xFC, 0x6C, 0x83]};
@GUID(0xFC3855A6, 0xC901, 0x4F2E, [0xAB, 0xA8, 0x90, 0x81, 0x5A, 0xFC, 0x6C, 0x83]);
struct ISDB_T_NETWORK_TYPE;

const GUID CLSID_ISDB_SATELLITE_TV_NETWORK_TYPE = {0xB0A4E6A0, 0x6A1A, 0x4B83, [0xBB, 0x5B, 0x90, 0x3E, 0x1D, 0x90, 0xE6, 0xB6]};
@GUID(0xB0A4E6A0, 0x6A1A, 0x4B83, [0xBB, 0x5B, 0x90, 0x3E, 0x1D, 0x90, 0xE6, 0xB6]);
struct ISDB_SATELLITE_TV_NETWORK_TYPE;

const GUID CLSID_ISDB_S_NETWORK_TYPE = {0xA1E78202, 0x1459, 0x41B1, [0x9C, 0xA9, 0x2A, 0x92, 0x58, 0x7A, 0x42, 0xCC]};
@GUID(0xA1E78202, 0x1459, 0x41B1, [0x9C, 0xA9, 0x2A, 0x92, 0x58, 0x7A, 0x42, 0xCC]);
struct ISDB_S_NETWORK_TYPE;

const GUID CLSID_ISDB_CABLE_TV_NETWORK_TYPE = {0xC974DDB5, 0x41FE, 0x4B25, [0x97, 0x41, 0x92, 0xF0, 0x49, 0xF1, 0xD5, 0xD1]};
@GUID(0xC974DDB5, 0x41FE, 0x4B25, [0x97, 0x41, 0x92, 0xF0, 0x49, 0xF1, 0xD5, 0xD1]);
struct ISDB_CABLE_TV_NETWORK_TYPE;

const GUID CLSID_DIRECT_TV_SATELLITE_TV_NETWORK_TYPE = {0x93B66FB5, 0x93D4, 0x4323, [0x92, 0x1C, 0xC1, 0xF5, 0x2D, 0xF6, 0x1D, 0x3F]};
@GUID(0x93B66FB5, 0x93D4, 0x4323, [0x92, 0x1C, 0xC1, 0xF5, 0x2D, 0xF6, 0x1D, 0x3F]);
struct DIRECT_TV_SATELLITE_TV_NETWORK_TYPE;

const GUID CLSID_ECHOSTAR_SATELLITE_TV_NETWORK_TYPE = {0xC4F6B31B, 0xC6BF, 0x4759, [0x88, 0x6F, 0xA7, 0x38, 0x6D, 0xCA, 0x27, 0xA0]};
@GUID(0xC4F6B31B, 0xC6BF, 0x4759, [0x88, 0x6F, 0xA7, 0x38, 0x6D, 0xCA, 0x27, 0xA0]);
struct ECHOSTAR_SATELLITE_TV_NETWORK_TYPE;

const GUID CLSID_ATSC_TERRESTRIAL_TV_NETWORK_TYPE = {0x0DAD2FDD, 0x5FD7, 0x11D3, [0x8F, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]};
@GUID(0x0DAD2FDD, 0x5FD7, 0x11D3, [0x8F, 0x50, 0x00, 0xC0, 0x4F, 0x79, 0x71, 0xE2]);
struct ATSC_TERRESTRIAL_TV_NETWORK_TYPE;

const GUID CLSID_DVB_TERRESTRIAL_TV_NETWORK_TYPE = {0x216C62DF, 0x6D7F, 0x4E9A, [0x85, 0x71, 0x05, 0xF1, 0x4E, 0xDB, 0x76, 0x6A]};
@GUID(0x216C62DF, 0x6D7F, 0x4E9A, [0x85, 0x71, 0x05, 0xF1, 0x4E, 0xDB, 0x76, 0x6A]);
struct DVB_TERRESTRIAL_TV_NETWORK_TYPE;

const GUID CLSID_BSKYB_TERRESTRIAL_TV_NETWORK_TYPE = {0x9E9E46C6, 0x3ABA, 0x4F08, [0xAD, 0x0E, 0xCC, 0x5A, 0xC8, 0x14, 0x8C, 0x2B]};
@GUID(0x9E9E46C6, 0x3ABA, 0x4F08, [0xAD, 0x0E, 0xCC, 0x5A, 0xC8, 0x14, 0x8C, 0x2B]);
struct BSKYB_TERRESTRIAL_TV_NETWORK_TYPE;

const GUID CLSID_DVB_SATELLITE_TV_NETWORK_TYPE = {0xFA4B375A, 0x45B4, 0x4D45, [0x84, 0x40, 0x26, 0x39, 0x57, 0xB1, 0x16, 0x23]};
@GUID(0xFA4B375A, 0x45B4, 0x4D45, [0x84, 0x40, 0x26, 0x39, 0x57, 0xB1, 0x16, 0x23]);
struct DVB_SATELLITE_TV_NETWORK_TYPE;

const GUID CLSID_DVB_CABLE_TV_NETWORK_TYPE = {0xDC0C0FE7, 0x0485, 0x4266, [0xB9, 0x3F, 0x68, 0xFB, 0xF8, 0x0E, 0xD8, 0x34]};
@GUID(0xDC0C0FE7, 0x0485, 0x4266, [0xB9, 0x3F, 0x68, 0xFB, 0xF8, 0x0E, 0xD8, 0x34]);
struct DVB_CABLE_TV_NETWORK_TYPE;

const GUID CLSID_BDA_DEBUG_DATA_AVAILABLE = {0x69C24F54, 0x9983, 0x497E, [0xB4, 0x15, 0x28, 0x2B, 0xE4, 0xC5, 0x55, 0xFB]};
@GUID(0x69C24F54, 0x9983, 0x497E, [0xB4, 0x15, 0x28, 0x2B, 0xE4, 0xC5, 0x55, 0xFB]);
struct BDA_DEBUG_DATA_AVAILABLE;

const GUID CLSID_BDA_DEBUG_DATA_TYPE_STRING = {0xA806E767, 0xDE5C, 0x430C, [0x80, 0xBF, 0xA2, 0x1E, 0xBE, 0x06, 0xC7, 0x48]};
@GUID(0xA806E767, 0xDE5C, 0x430C, [0x80, 0xBF, 0xA2, 0x1E, 0xBE, 0x06, 0xC7, 0x48]);
struct BDA_DEBUG_DATA_TYPE_STRING;

const GUID CLSID_EVENTID_BDA_IsdbCASResponse = {0xD4CB1966, 0x41BC, 0x4CED, [0x9A, 0x20, 0xFD, 0xCE, 0xAC, 0x78, 0xF7, 0x0D]};
@GUID(0xD4CB1966, 0x41BC, 0x4CED, [0x9A, 0x20, 0xFD, 0xCE, 0xAC, 0x78, 0xF7, 0x0D]);
struct EVENTID_BDA_IsdbCASResponse;

const GUID CLSID_EVENTID_BDA_CASRequestTuner = {0xCF39A9D8, 0xF5D3, 0x4685, [0xBE, 0x57, 0xED, 0x81, 0xDB, 0xA4, 0x6B, 0x27]};
@GUID(0xCF39A9D8, 0xF5D3, 0x4685, [0xBE, 0x57, 0xED, 0x81, 0xDB, 0xA4, 0x6B, 0x27]);
struct EVENTID_BDA_CASRequestTuner;

const GUID CLSID_EVENTID_BDA_CASReleaseTuner = {0x20C1A16B, 0x441F, 0x49A5, [0xBB, 0x5C, 0xE9, 0xA0, 0x44, 0x95, 0xC6, 0xC1]};
@GUID(0x20C1A16B, 0x441F, 0x49A5, [0xBB, 0x5C, 0xE9, 0xA0, 0x44, 0x95, 0xC6, 0xC1]);
struct EVENTID_BDA_CASReleaseTuner;

const GUID CLSID_EVENTID_BDA_CASOpenMMI = {0x85DAC915, 0xE593, 0x410D, [0x84, 0x71, 0xD6, 0x81, 0x21, 0x05, 0xF2, 0x8E]};
@GUID(0x85DAC915, 0xE593, 0x410D, [0x84, 0x71, 0xD6, 0x81, 0x21, 0x05, 0xF2, 0x8E]);
struct EVENTID_BDA_CASOpenMMI;

const GUID CLSID_EVENTID_BDA_CASCloseMMI = {0x5D0F550F, 0xDE2E, 0x479D, [0x83, 0x45, 0xEC, 0x0E, 0x95, 0x57, 0xE8, 0xA2]};
@GUID(0x5D0F550F, 0xDE2E, 0x479D, [0x83, 0x45, 0xEC, 0x0E, 0x95, 0x57, 0xE8, 0xA2]);
struct EVENTID_BDA_CASCloseMMI;

const GUID CLSID_EVENTID_BDA_CASBroadcastMMI = {0x676876F0, 0x1132, 0x404C, [0xA7, 0xCA, 0xE7, 0x20, 0x69, 0xA9, 0xD5, 0x4F]};
@GUID(0x676876F0, 0x1132, 0x404C, [0xA7, 0xCA, 0xE7, 0x20, 0x69, 0xA9, 0xD5, 0x4F]);
struct EVENTID_BDA_CASBroadcastMMI;

const GUID CLSID_EVENTID_BDA_TunerSignalLock = {0x1872E740, 0xF573, 0x429B, [0xA0, 0x0E, 0xD9, 0xC1, 0xE4, 0x08, 0xAF, 0x09]};
@GUID(0x1872E740, 0xF573, 0x429B, [0xA0, 0x0E, 0xD9, 0xC1, 0xE4, 0x08, 0xAF, 0x09]);
struct EVENTID_BDA_TunerSignalLock;

const GUID CLSID_EVENTID_BDA_TunerNoSignal = {0xE29B382B, 0x1EDD, 0x4930, [0xBC, 0x46, 0x68, 0x2F, 0xD7, 0x2D, 0x2D, 0xFB]};
@GUID(0xE29B382B, 0x1EDD, 0x4930, [0xBC, 0x46, 0x68, 0x2F, 0xD7, 0x2D, 0x2D, 0xFB]);
struct EVENTID_BDA_TunerNoSignal;

const GUID CLSID_EVENTID_BDA_GPNVValueUpdate = {0xFF75C68C, 0xF416, 0x4E7E, [0xBF, 0x17, 0x6D, 0x55, 0xC5, 0xDF, 0x15, 0x75]};
@GUID(0xFF75C68C, 0xF416, 0x4E7E, [0xBF, 0x17, 0x6D, 0x55, 0xC5, 0xDF, 0x15, 0x75]);
struct EVENTID_BDA_GPNVValueUpdate;

const GUID CLSID_EVENTID_BDA_UpdateDrmStatus = {0x65A6F681, 0x1462, 0x473B, [0x88, 0xCE, 0xCB, 0x73, 0x14, 0x27, 0xBD, 0xB5]};
@GUID(0x65A6F681, 0x1462, 0x473B, [0x88, 0xCE, 0xCB, 0x73, 0x14, 0x27, 0xBD, 0xB5]);
struct EVENTID_BDA_UpdateDrmStatus;

const GUID CLSID_EVENTID_BDA_UpdateScanState = {0x55702B50, 0x7B49, 0x42B8, [0xA8, 0x2F, 0x4A, 0xFB, 0x69, 0x1B, 0x06, 0x28]};
@GUID(0x55702B50, 0x7B49, 0x42B8, [0xA8, 0x2F, 0x4A, 0xFB, 0x69, 0x1B, 0x06, 0x28]);
struct EVENTID_BDA_UpdateScanState;

const GUID CLSID_EVENTID_BDA_GuideDataAvailable = {0x98DB717A, 0x478A, 0x4CD4, [0x92, 0xD0, 0x95, 0xF6, 0x6B, 0x89, 0xE5, 0xB1]};
@GUID(0x98DB717A, 0x478A, 0x4CD4, [0x92, 0xD0, 0x95, 0xF6, 0x6B, 0x89, 0xE5, 0xB1]);
struct EVENTID_BDA_GuideDataAvailable;

const GUID CLSID_EVENTID_BDA_GuideServiceInformationUpdated = {0xA1C3EA2B, 0x175F, 0x4458, [0xB7, 0x35, 0x50, 0x7D, 0x22, 0xDB, 0x23, 0xA6]};
@GUID(0xA1C3EA2B, 0x175F, 0x4458, [0xB7, 0x35, 0x50, 0x7D, 0x22, 0xDB, 0x23, 0xA6]);
struct EVENTID_BDA_GuideServiceInformationUpdated;

const GUID CLSID_EVENTID_BDA_GuideDataError = {0xAC33C448, 0x6F73, 0x4FD7, [0xB3, 0x41, 0x59, 0x4C, 0x36, 0x0D, 0x8D, 0x74]};
@GUID(0xAC33C448, 0x6F73, 0x4FD7, [0xB3, 0x41, 0x59, 0x4C, 0x36, 0x0D, 0x8D, 0x74]);
struct EVENTID_BDA_GuideDataError;

const GUID CLSID_EVENTID_BDA_DiseqCResponseAvailable = {0xEFA628F8, 0x1F2C, 0x4B67, [0x9E, 0xA5, 0xAC, 0xF6, 0xFA, 0x9A, 0x1F, 0x36]};
@GUID(0xEFA628F8, 0x1F2C, 0x4B67, [0x9E, 0xA5, 0xAC, 0xF6, 0xFA, 0x9A, 0x1F, 0x36]);
struct EVENTID_BDA_DiseqCResponseAvailable;

const GUID CLSID_EVENTID_BDA_LbigsOpenConnection = {0x356207B2, 0x6F31, 0x4EB0, [0xA2, 0x71, 0xB3, 0xFA, 0x6B, 0xB7, 0x68, 0x0F]};
@GUID(0x356207B2, 0x6F31, 0x4EB0, [0xA2, 0x71, 0xB3, 0xFA, 0x6B, 0xB7, 0x68, 0x0F]);
struct EVENTID_BDA_LbigsOpenConnection;

const GUID CLSID_EVENTID_BDA_LbigsSendData = {0x1123277B, 0xF1C6, 0x4154, [0x8B, 0x0D, 0x48, 0xE6, 0x15, 0x70, 0x59, 0xAA]};
@GUID(0x1123277B, 0xF1C6, 0x4154, [0x8B, 0x0D, 0x48, 0xE6, 0x15, 0x70, 0x59, 0xAA]);
struct EVENTID_BDA_LbigsSendData;

const GUID CLSID_EVENTID_BDA_LbigsCloseConnectionHandle = {0xC2F08B99, 0x65EF, 0x4314, [0x96, 0x71, 0xE9, 0x9D, 0x4C, 0xCE, 0x0B, 0xAE]};
@GUID(0xC2F08B99, 0x65EF, 0x4314, [0x96, 0x71, 0xE9, 0x9D, 0x4C, 0xCE, 0x0B, 0xAE]);
struct EVENTID_BDA_LbigsCloseConnectionHandle;

const GUID CLSID_EVENTID_BDA_EncoderSignalLock = {0x5EC90EB9, 0x39FA, 0x4CFC, [0xB9, 0x3F, 0x00, 0xBB, 0x11, 0x07, 0x7F, 0x5E]};
@GUID(0x5EC90EB9, 0x39FA, 0x4CFC, [0xB9, 0x3F, 0x00, 0xBB, 0x11, 0x07, 0x7F, 0x5E]);
struct EVENTID_BDA_EncoderSignalLock;

const GUID CLSID_EVENTID_BDA_FdcStatus = {0x05F25366, 0xD0EB, 0x43D2, [0xBC, 0x3C, 0x68, 0x2B, 0x86, 0x3D, 0xF1, 0x42]};
@GUID(0x05F25366, 0xD0EB, 0x43D2, [0xBC, 0x3C, 0x68, 0x2B, 0x86, 0x3D, 0xF1, 0x42]);
struct EVENTID_BDA_FdcStatus;

const GUID CLSID_EVENTID_BDA_FdcTableSection = {0x6A0CD757, 0x4CE3, 0x4E5B, [0x94, 0x44, 0x71, 0x87, 0xB8, 0x71, 0x52, 0xC5]};
@GUID(0x6A0CD757, 0x4CE3, 0x4E5B, [0x94, 0x44, 0x71, 0x87, 0xB8, 0x71, 0x52, 0xC5]);
struct EVENTID_BDA_FdcTableSection;

const GUID CLSID_EVENTID_BDA_TransprtStreamSelectorInfo = {0xC40F9F85, 0x09D0, 0x489C, [0x9E, 0x9C, 0x0A, 0xBB, 0xB5, 0x69, 0x51, 0xB0]};
@GUID(0xC40F9F85, 0x09D0, 0x489C, [0x9E, 0x9C, 0x0A, 0xBB, 0xB5, 0x69, 0x51, 0xB0]);
struct EVENTID_BDA_TransprtStreamSelectorInfo;

const GUID CLSID_EVENTID_BDA_RatingPinReset = {0xC6E048C0, 0xC574, 0x4C26, [0xBC, 0xDA, 0x2F, 0x4D, 0x35, 0xEB, 0x5E, 0x85]};
@GUID(0xC6E048C0, 0xC574, 0x4C26, [0xBC, 0xDA, 0x2F, 0x4D, 0x35, 0xEB, 0x5E, 0x85]);
struct EVENTID_BDA_RatingPinReset;

const GUID CLSID_PBDA_ALWAYS_TUNE_IN_MUX = {0x1E1D7141, 0x583F, 0x4AC2, [0xB0, 0x19, 0x1F, 0x43, 0x0E, 0xDA, 0x0F, 0x4C]};
@GUID(0x1E1D7141, 0x583F, 0x4AC2, [0xB0, 0x19, 0x1F, 0x43, 0x0E, 0xDA, 0x0F, 0x4C]);
struct PBDA_ALWAYS_TUNE_IN_MUX;

struct PID_BITS
{
    ushort _bitfield;
}

struct MPEG_HEADER_BITS
{
    ushort _bitfield;
}

struct MPEG_HEADER_VERSION_BITS
{
    ubyte _bitfield;
}

struct MPEG1WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort fwHeadLayer;
    uint dwHeadBitrate;
    ushort fwHeadMode;
    ushort fwHeadModeExt;
    ushort wHeadEmphasis;
    ushort fwHeadFlags;
    uint dwPTSLow;
    uint dwPTSHigh;
}

struct MPEGLAYER3WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wID;
    uint fdwFlags;
    ushort nBlockSize;
    ushort nFramesPerBlock;
    ushort nCodecDelay;
}

struct HEAACWAVEINFO
{
    WAVEFORMATEX wfx;
    ushort wPayloadType;
    ushort wAudioProfileLevelIndication;
    ushort wStructType;
    ushort wReserved1;
    uint dwReserved2;
}

struct HEAACWAVEFORMAT
{
    HEAACWAVEINFO wfInfo;
    ubyte pbAudioSpecificConfig;
}

struct DMO_MEDIA_TYPE
{
    Guid majortype;
    Guid subtype;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint lSampleSize;
    Guid formattype;
    IUnknown pUnk;
    uint cbFormat;
    ubyte* pbFormat;
}

const GUID IID_IMediaBuffer = {0x59EFF8B9, 0x938C, 0x4A26, [0x82, 0xF2, 0x95, 0xCB, 0x84, 0xCD, 0xC8, 0x37]};
@GUID(0x59EFF8B9, 0x938C, 0x4A26, [0x82, 0xF2, 0x95, 0xCB, 0x84, 0xCD, 0xC8, 0x37]);
interface IMediaBuffer : IUnknown
{
    HRESULT SetLength(uint cbLength);
    HRESULT GetMaxLength(uint* pcbMaxLength);
    HRESULT GetBufferAndLength(ubyte** ppBuffer, uint* pcbLength);
}

struct DMO_OUTPUT_DATA_BUFFER
{
    IMediaBuffer pBuffer;
    uint dwStatus;
    long rtTimestamp;
    long rtTimelength;
}

const GUID IID_IMediaObject = {0xD8AD0F58, 0x5494, 0x4102, [0x97, 0xC5, 0xEC, 0x79, 0x8E, 0x59, 0xBC, 0xF4]};
@GUID(0xD8AD0F58, 0x5494, 0x4102, [0x97, 0xC5, 0xEC, 0x79, 0x8E, 0x59, 0xBC, 0xF4]);
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
    HRESULT ProcessInput(uint dwInputStreamIndex, IMediaBuffer pBuffer, uint dwFlags, long rtTimestamp, long rtTimelength);
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, char* pOutputBuffers, uint* pdwStatus);
    HRESULT Lock(int bLock);
}

const GUID IID_IEnumDMO = {0x2C3CD98A, 0x2BFA, 0x4A53, [0x9C, 0x27, 0x52, 0x49, 0xBA, 0x64, 0xBA, 0x0F]};
@GUID(0x2C3CD98A, 0x2BFA, 0x4A53, [0x9C, 0x27, 0x52, 0x49, 0xBA, 0x64, 0xBA, 0x0F]);
interface IEnumDMO : IUnknown
{
    HRESULT Next(uint cItemsToFetch, char* pCLSID, char* Names, uint* pcItemsFetched);
    HRESULT Skip(uint cItemsToSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumDMO* ppEnum);
}

const GUID IID_IMediaObjectInPlace = {0x651B9AD0, 0x0FC7, 0x4AA9, [0x95, 0x38, 0xD8, 0x99, 0x31, 0x01, 0x07, 0x41]};
@GUID(0x651B9AD0, 0x0FC7, 0x4AA9, [0x95, 0x38, 0xD8, 0x99, 0x31, 0x01, 0x07, 0x41]);
interface IMediaObjectInPlace : IUnknown
{
    HRESULT Process(uint ulSize, char* pData, long refTimeStart, uint dwFlags);
    HRESULT Clone(IMediaObjectInPlace* ppMediaObject);
    HRESULT GetLatency(long* pLatencyTime);
}

const GUID IID_IDMOQualityControl = {0x65ABEA96, 0xCF36, 0x453F, [0xAF, 0x8A, 0x70, 0x5E, 0x98, 0xF1, 0x62, 0x60]};
@GUID(0x65ABEA96, 0xCF36, 0x453F, [0xAF, 0x8A, 0x70, 0x5E, 0x98, 0xF1, 0x62, 0x60]);
interface IDMOQualityControl : IUnknown
{
    HRESULT SetNow(long rtNow);
    HRESULT SetStatus(uint dwFlags);
    HRESULT GetStatus(uint* pdwFlags);
}

const GUID IID_IDMOVideoOutputOptimizations = {0xBE8F4F4E, 0x5B16, 0x4D29, [0xB3, 0x50, 0x7F, 0x6B, 0x5D, 0x92, 0x98, 0xAC]};
@GUID(0xBE8F4F4E, 0x5B16, 0x4D29, [0xB3, 0x50, 0x7F, 0x6B, 0x5D, 0x92, 0x98, 0xAC]);
interface IDMOVideoOutputOptimizations : IUnknown
{
    HRESULT QueryOperationModePreferences(uint ulOutputStreamIndex, uint* pdwRequestedCapabilities);
    HRESULT SetOperationMode(uint ulOutputStreamIndex, uint dwEnabledFeatures);
    HRESULT GetCurrentOperationMode(uint ulOutputStreamIndex, uint* pdwEnabledFeatures);
    HRESULT GetCurrentSampleRequirements(uint ulOutputStreamIndex, uint* pdwRequestedFeatures);
}

struct DXVA_COPPSetProtectionLevelCmdData
{
    uint ProtType;
    uint ProtLevel;
    uint ExtendedInfoChangeMask;
    uint ExtendedInfoData;
}

enum COPP_HDCP_Protection_Level
{
    COPP_HDCP_Level0 = 0,
    COPP_HDCP_LevelMin = 0,
    COPP_HDCP_Level1 = 1,
    COPP_HDCP_LevelMax = 1,
    COPP_HDCP_ForceDWORD = 2147483647,
}

enum COPP_CGMSA_Protection_Level
{
    COPP_CGMSA_Disabled = 0,
    COPP_CGMSA_LevelMin = 0,
    COPP_CGMSA_CopyFreely = 1,
    COPP_CGMSA_CopyNoMore = 2,
    COPP_CGMSA_CopyOneGeneration = 3,
    COPP_CGMSA_CopyNever = 4,
    COPP_CGMSA_RedistributionControlRequired = 8,
    COPP_CGMSA_LevelMax = 12,
    COPP_CGMSA_ForceDWORD = 2147483647,
}

enum COPP_ACP_Protection_Level
{
    COPP_ACP_Level0 = 0,
    COPP_ACP_LevelMin = 0,
    COPP_ACP_Level1 = 1,
    COPP_ACP_Level2 = 2,
    COPP_ACP_Level3 = 3,
    COPP_ACP_LevelMax = 3,
    COPP_ACP_ForceDWORD = 2147483647,
}

struct DXVA_COPPSetSignalingCmdData
{
    uint ActiveTVProtectionStandard;
    uint AspectRatioChangeMask1;
    uint AspectRatioData1;
    uint AspectRatioChangeMask2;
    uint AspectRatioData2;
    uint AspectRatioChangeMask3;
    uint AspectRatioData3;
    uint ExtendedInfoChangeMask;
    uint ExtendedInfoData;
    uint Reserved;
}

enum COPP_TVProtectionStandard
{
    COPP_ProtectionStandard_Unknown = -2147483648,
    COPP_ProtectionStandard_None = 0,
    COPP_ProtectionStandard_IEC61880_525i = 1,
    COPP_ProtectionStandard_IEC61880_2_525i = 2,
    COPP_ProtectionStandard_IEC62375_625p = 4,
    COPP_ProtectionStandard_EIA608B_525 = 8,
    COPP_ProtectionStandard_EN300294_625i = 16,
    COPP_ProtectionStandard_CEA805A_TypeA_525p = 32,
    COPP_ProtectionStandard_CEA805A_TypeA_750p = 64,
    COPP_ProtectionStandard_CEA805A_TypeA_1125i = 128,
    COPP_ProtectionStandard_CEA805A_TypeB_525p = 256,
    COPP_ProtectionStandard_CEA805A_TypeB_750p = 512,
    COPP_ProtectionStandard_CEA805A_TypeB_1125i = 1024,
    COPP_ProtectionStandard_ARIBTRB15_525i = 2048,
    COPP_ProtectionStandard_ARIBTRB15_525p = 4096,
    COPP_ProtectionStandard_ARIBTRB15_750p = 8192,
    COPP_ProtectionStandard_ARIBTRB15_1125i = 16384,
    COPP_ProtectionStandard_Mask = -2147450881,
    COPP_ProtectionStandard_Reserved = 2147450880,
}

enum COPP_ImageAspectRatio_EN300294
{
    COPP_AspectRatio_EN300294_FullFormat4by3 = 0,
    COPP_AspectRatio_EN300294_Box14by9Center = 1,
    COPP_AspectRatio_EN300294_Box14by9Top = 2,
    COPP_AspectRatio_EN300294_Box16by9Center = 3,
    COPP_AspectRatio_EN300294_Box16by9Top = 4,
    COPP_AspectRatio_EN300294_BoxGT16by9Center = 5,
    COPP_AspectRatio_EN300294_FullFormat4by3ProtectedCenter = 6,
    COPP_AspectRatio_EN300294_FullFormat16by9Anamorphic = 7,
    COPP_AspectRatio_ForceDWORD = 2147483647,
}

enum COPP_StatusFlags
{
    COPP_StatusNormal = 0,
    COPP_LinkLost = 1,
    COPP_RenegotiationRequired = 2,
    COPP_StatusFlagsReserved = -4,
}

struct DXVA_COPPStatusData
{
    Guid rApp;
    uint dwFlags;
    uint dwData;
    uint ExtendedInfoValidMask;
    uint ExtendedInfoData;
}

struct DXVA_COPPStatusDisplayData
{
    Guid rApp;
    uint dwFlags;
    uint DisplayWidth;
    uint DisplayHeight;
    uint Format;
    uint d3dFormat;
    uint FreqNumerator;
    uint FreqDenominator;
}

enum COPP_StatusHDCPFlags
{
    COPP_HDCPRepeater = 1,
    COPP_HDCPFlagsReserved = -2,
}

struct DXVA_COPPStatusHDCPKeyData
{
    Guid rApp;
    uint dwFlags;
    uint dwHDCPFlags;
    Guid BKey;
    Guid Reserved1;
    Guid Reserved2;
}

enum COPP_ConnectorType
{
    COPP_ConnectorType_Unknown = -1,
    COPP_ConnectorType_VGA = 0,
    COPP_ConnectorType_SVideo = 1,
    COPP_ConnectorType_CompositeVideo = 2,
    COPP_ConnectorType_ComponentVideo = 3,
    COPP_ConnectorType_DVI = 4,
    COPP_ConnectorType_HDMI = 5,
    COPP_ConnectorType_LVDS = 6,
    COPP_ConnectorType_TMDS = 7,
    COPP_ConnectorType_D_JPN = 8,
    COPP_ConnectorType_Internal = -2147483648,
    COPP_ConnectorType_ForceDWORD = 2147483647,
}

enum COPP_BusType
{
    COPP_BusType_Unknown = 0,
    COPP_BusType_PCI = 1,
    COPP_BusType_PCIX = 2,
    COPP_BusType_PCIExpress = 3,
    COPP_BusType_AGP = 4,
    COPP_BusType_Integrated = -2147483648,
    COPP_BusType_ForceDWORD = 2147483647,
}

struct DXVA_COPPStatusSignalingCmdData
{
    Guid rApp;
    uint dwFlags;
    uint AvailableTVProtectionStandards;
    uint ActiveTVProtectionStandard;
    uint TVType;
    uint AspectRatioValidMask1;
    uint AspectRatioData1;
    uint AspectRatioValidMask2;
    uint AspectRatioData2;
    uint AspectRatioValidMask3;
    uint AspectRatioData3;
    uint ExtendedInfoValidMask;
    uint ExtendedInfoData;
}

struct DDCOLORKEY
{
    uint dwColorSpaceLowValue;
    uint dwColorSpaceHighValue;
}

