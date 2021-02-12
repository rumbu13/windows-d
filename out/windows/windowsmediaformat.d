module windows.windowsmediaformat;

public import system;
public import windows.automation;
public import windows.com;
public import windows.directshow;
public import windows.displaydevices;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

const GUID IID_IAMWMBufferPass = {0x6DD816D7, 0xE740, 0x4123, [0x9E, 0x24, 0x24, 0x44, 0x41, 0x26, 0x44, 0xD8]};
@GUID(0x6DD816D7, 0xE740, 0x4123, [0x9E, 0x24, 0x24, 0x44, 0x41, 0x26, 0x44, 0xD8]);
interface IAMWMBufferPass : IUnknown
{
    HRESULT SetNotify(IAMWMBufferPassCallback pCallback);
}

const GUID IID_IAMWMBufferPassCallback = {0xB25B8372, 0xD2D2, 0x44B2, [0x86, 0x53, 0x1B, 0x8D, 0xAE, 0x33, 0x24, 0x89]};
@GUID(0xB25B8372, 0xD2D2, 0x44B2, [0x86, 0x53, 0x1B, 0x8D, 0xAE, 0x33, 0x24, 0x89]);
interface IAMWMBufferPassCallback : IUnknown
{
    HRESULT Notify(INSSBuffer3 pNSSBuffer3, IPin pPin, long* prtStart, long* prtEnd);
}

enum _AM_ASFWRITERCONFIG_PARAM
{
    AM_CONFIGASFWRITER_PARAM_AUTOINDEX = 1,
    AM_CONFIGASFWRITER_PARAM_MULTIPASS = 2,
    AM_CONFIGASFWRITER_PARAM_DONTCOMPRESS = 3,
}

struct AM_WMT_EVENT_DATA
{
    HRESULT hrStatus;
    void* pData;
}

const GUID IID_INSSBuffer = {0xE1CD3524, 0x03D7, 0x11D2, [0x9E, 0xED, 0x00, 0x60, 0x97, 0xD2, 0xD7, 0xCF]};
@GUID(0xE1CD3524, 0x03D7, 0x11D2, [0x9E, 0xED, 0x00, 0x60, 0x97, 0xD2, 0xD7, 0xCF]);
interface INSSBuffer : IUnknown
{
    HRESULT GetLength(uint* pdwLength);
    HRESULT SetLength(uint dwLength);
    HRESULT GetMaxLength(uint* pdwLength);
    HRESULT GetBuffer(ubyte** ppdwBuffer);
    HRESULT GetBufferAndLength(ubyte** ppdwBuffer, uint* pdwLength);
}

const GUID IID_INSSBuffer2 = {0x4F528693, 0x1035, 0x43FE, [0xB4, 0x28, 0x75, 0x75, 0x61, 0xAD, 0x3A, 0x68]};
@GUID(0x4F528693, 0x1035, 0x43FE, [0xB4, 0x28, 0x75, 0x75, 0x61, 0xAD, 0x3A, 0x68]);
interface INSSBuffer2 : INSSBuffer
{
    HRESULT GetSampleProperties(uint cbProperties, ubyte* pbProperties);
    HRESULT SetSampleProperties(uint cbProperties, ubyte* pbProperties);
}

const GUID IID_INSSBuffer3 = {0xC87CEAAF, 0x75BE, 0x4BC4, [0x84, 0xEB, 0xAC, 0x27, 0x98, 0x50, 0x76, 0x72]};
@GUID(0xC87CEAAF, 0x75BE, 0x4BC4, [0x84, 0xEB, 0xAC, 0x27, 0x98, 0x50, 0x76, 0x72]);
interface INSSBuffer3 : INSSBuffer2
{
    HRESULT SetProperty(Guid guidBufferProperty, void* pvBufferProperty, uint dwBufferPropertySize);
    HRESULT GetProperty(Guid guidBufferProperty, void* pvBufferProperty, uint* pdwBufferPropertySize);
}

const GUID IID_INSSBuffer4 = {0xB6B8FD5A, 0x32E2, 0x49D4, [0xA9, 0x10, 0xC2, 0x6C, 0xC8, 0x54, 0x65, 0xED]};
@GUID(0xB6B8FD5A, 0x32E2, 0x49D4, [0xA9, 0x10, 0xC2, 0x6C, 0xC8, 0x54, 0x65, 0xED]);
interface INSSBuffer4 : INSSBuffer3
{
    HRESULT GetPropertyCount(uint* pcBufferProperties);
    HRESULT GetPropertyByIndex(uint dwBufferPropertyIndex, Guid* pguidBufferProperty, void* pvBufferProperty, uint* pdwBufferPropertySize);
}

const GUID IID_IWMSBufferAllocator = {0x61103CA4, 0x2033, 0x11D2, [0x9E, 0xF1, 0x00, 0x60, 0x97, 0xD2, 0xD7, 0xCF]};
@GUID(0x61103CA4, 0x2033, 0x11D2, [0x9E, 0xF1, 0x00, 0x60, 0x97, 0xD2, 0xD7, 0xCF]);
interface IWMSBufferAllocator : IUnknown
{
    HRESULT AllocateBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
    HRESULT AllocatePageSizeBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
}

enum __MIDL___MIDL_itf_wmsdkidl_0000_0000_0001
{
    WEBSTREAM_SAMPLE_TYPE_FILE = 1,
    WEBSTREAM_SAMPLE_TYPE_RENDER = 2,
}

enum __MIDL___MIDL_itf_wmsdkidl_0000_0000_0002
{
    WM_SF_CLEANPOINT = 1,
    WM_SF_DISCONTINUITY = 2,
    WM_SF_DATALOSS = 4,
}

enum __MIDL___MIDL_itf_wmsdkidl_0000_0000_0003
{
    WM_SFEX_NOTASYNCPOINT = 2,
    WM_SFEX_DATALOSS = 4,
}

enum WMT_STATUS
{
    WMT_ERROR = 0,
    WMT_OPENED = 1,
    WMT_BUFFERING_START = 2,
    WMT_BUFFERING_STOP = 3,
    WMT_EOF = 4,
    WMT_END_OF_FILE = 4,
    WMT_END_OF_SEGMENT = 5,
    WMT_END_OF_STREAMING = 6,
    WMT_LOCATING = 7,
    WMT_CONNECTING = 8,
    WMT_NO_RIGHTS = 9,
    WMT_MISSING_CODEC = 10,
    WMT_STARTED = 11,
    WMT_STOPPED = 12,
    WMT_CLOSED = 13,
    WMT_STRIDING = 14,
    WMT_TIMER = 15,
    WMT_INDEX_PROGRESS = 16,
    WMT_SAVEAS_START = 17,
    WMT_SAVEAS_STOP = 18,
    WMT_NEW_SOURCEFLAGS = 19,
    WMT_NEW_METADATA = 20,
    WMT_BACKUPRESTORE_BEGIN = 21,
    WMT_SOURCE_SWITCH = 22,
    WMT_ACQUIRE_LICENSE = 23,
    WMT_INDIVIDUALIZE = 24,
    WMT_NEEDS_INDIVIDUALIZATION = 25,
    WMT_NO_RIGHTS_EX = 26,
    WMT_BACKUPRESTORE_END = 27,
    WMT_BACKUPRESTORE_CONNECTING = 28,
    WMT_BACKUPRESTORE_DISCONNECTING = 29,
    WMT_ERROR_WITHURL = 30,
    WMT_RESTRICTED_LICENSE = 31,
    WMT_CLIENT_CONNECT = 32,
    WMT_CLIENT_DISCONNECT = 33,
    WMT_NATIVE_OUTPUT_PROPS_CHANGED = 34,
    WMT_RECONNECT_START = 35,
    WMT_RECONNECT_END = 36,
    WMT_CLIENT_CONNECT_EX = 37,
    WMT_CLIENT_DISCONNECT_EX = 38,
    WMT_SET_FEC_SPAN = 39,
    WMT_PREROLL_READY = 40,
    WMT_PREROLL_COMPLETE = 41,
    WMT_CLIENT_PROPERTIES = 42,
    WMT_LICENSEURL_SIGNATURE_STATE = 43,
    WMT_INIT_PLAYLIST_BURN = 44,
    WMT_TRANSCRYPTOR_INIT = 45,
    WMT_TRANSCRYPTOR_SEEKED = 46,
    WMT_TRANSCRYPTOR_READ = 47,
    WMT_TRANSCRYPTOR_CLOSED = 48,
    WMT_PROXIMITY_RESULT = 49,
    WMT_PROXIMITY_COMPLETED = 50,
    WMT_CONTENT_ENABLER = 51,
}

enum WMT_STREAM_SELECTION
{
    WMT_OFF = 0,
    WMT_CLEANPOINT_ONLY = 1,
    WMT_ON = 2,
}

enum WMT_IMAGE_TYPE
{
    WMT_IT_NONE = 0,
    WMT_IT_BITMAP = 1,
    WMT_IT_JPEG = 2,
    WMT_IT_GIF = 3,
}

enum WMT_ATTR_DATATYPE
{
    WMT_TYPE_DWORD = 0,
    WMT_TYPE_STRING = 1,
    WMT_TYPE_BINARY = 2,
    WMT_TYPE_BOOL = 3,
    WMT_TYPE_QWORD = 4,
    WMT_TYPE_WORD = 5,
    WMT_TYPE_GUID = 6,
}

enum WMT_ATTR_IMAGETYPE
{
    WMT_IMAGETYPE_BITMAP = 1,
    WMT_IMAGETYPE_JPEG = 2,
    WMT_IMAGETYPE_GIF = 3,
}

enum WMT_VERSION
{
    WMT_VER_4_0 = 262144,
    WMT_VER_7_0 = 458752,
    WMT_VER_8_0 = 524288,
    WMT_VER_9_0 = 589824,
}

enum WMT_STORAGE_FORMAT
{
    WMT_Storage_Format_MP3 = 0,
    WMT_Storage_Format_V1 = 1,
}

enum WMT_DRMLA_TRUST
{
    WMT_DRMLA_UNTRUSTED = 0,
    WMT_DRMLA_TRUSTED = 1,
    WMT_DRMLA_TAMPERED = 2,
}

enum WMT_TRANSPORT_TYPE
{
    WMT_Transport_Type_Unreliable = 0,
    WMT_Transport_Type_Reliable = 1,
}

enum WMT_NET_PROTOCOL
{
    WMT_PROTOCOL_HTTP = 0,
}

enum WMT_PLAY_MODE
{
    WMT_PLAY_MODE_AUTOSELECT = 0,
    WMT_PLAY_MODE_LOCAL = 1,
    WMT_PLAY_MODE_DOWNLOAD = 2,
    WMT_PLAY_MODE_STREAMING = 3,
}

enum WMT_PROXY_SETTINGS
{
    WMT_PROXY_SETTING_NONE = 0,
    WMT_PROXY_SETTING_MANUAL = 1,
    WMT_PROXY_SETTING_AUTO = 2,
    WMT_PROXY_SETTING_BROWSER = 3,
    WMT_PROXY_SETTING_MAX = 4,
}

enum WMT_CODEC_INFO_TYPE
{
    WMT_CODECINFO_AUDIO = 0,
    WMT_CODECINFO_VIDEO = 1,
    WMT_CODECINFO_UNKNOWN = -1,
}

enum __MIDL___MIDL_itf_wmsdkidl_0000_0000_0004
{
    WM_DM_NOTINTERLACED = 0,
    WM_DM_DEINTERLACE_NORMAL = 1,
    WM_DM_DEINTERLACE_HALFSIZE = 2,
    WM_DM_DEINTERLACE_HALFSIZEDOUBLERATE = 3,
    WM_DM_DEINTERLACE_INVERSETELECINE = 4,
    WM_DM_DEINTERLACE_VERTICALHALFSIZEDOUBLERATE = 5,
}

enum __MIDL___MIDL_itf_wmsdkidl_0000_0000_0005
{
    WM_DM_IT_DISABLE_COHERENT_MODE = 0,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_TOP = 1,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_TOP = 2,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_TOP = 3,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_TOP = 4,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_TOP = 5,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_BOTTOM = 6,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_BOTTOM = 7,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_BOTTOM = 8,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_BOTTOM = 9,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_BOTTOM = 10,
}

enum WMT_OFFSET_FORMAT
{
    WMT_OFFSET_FORMAT_100NS = 0,
    WMT_OFFSET_FORMAT_FRAME_NUMBERS = 1,
    WMT_OFFSET_FORMAT_PLAYLIST_OFFSET = 2,
    WMT_OFFSET_FORMAT_TIMECODE = 3,
    WMT_OFFSET_FORMAT_100NS_APPROXIMATE = 4,
}

enum WMT_INDEXER_TYPE
{
    WMT_IT_PRESENTATION_TIME = 0,
    WMT_IT_FRAME_NUMBERS = 1,
    WMT_IT_TIMECODE = 2,
}

enum WMT_INDEX_TYPE
{
    WMT_IT_NEAREST_DATA_UNIT = 1,
    WMT_IT_NEAREST_OBJECT = 2,
    WMT_IT_NEAREST_CLEAN_POINT = 3,
}

enum WMT_FILESINK_MODE
{
    WMT_FM_SINGLE_BUFFERS = 1,
    WMT_FM_FILESINK_DATA_UNITS = 2,
    WMT_FM_FILESINK_UNBUFFERED = 4,
}

enum WMT_MUSICSPEECH_CLASS_MODE
{
    WMT_MS_CLASS_MUSIC = 0,
    WMT_MS_CLASS_SPEECH = 1,
    WMT_MS_CLASS_MIXED = 2,
}

enum WMT_WATERMARK_ENTRY_TYPE
{
    WMT_WMETYPE_AUDIO = 1,
    WMT_WMETYPE_VIDEO = 2,
}

enum __MIDL___MIDL_itf_wmsdkidl_0000_0000_0006
{
    WM_PLAYBACK_DRC_HIGH = 0,
    WM_PLAYBACK_DRC_MEDIUM = 1,
    WM_PLAYBACK_DRC_LOW = 2,
}

enum __MIDL___MIDL_itf_wmsdkidl_0000_0000_0007
{
    WMT_TIMECODE_FRAMERATE_30 = 0,
    WMT_TIMECODE_FRAMERATE_30DROP = 1,
    WMT_TIMECODE_FRAMERATE_25 = 2,
    WMT_TIMECODE_FRAMERATE_24 = 3,
}

enum WMT_CREDENTIAL_FLAGS
{
    WMT_CREDENTIAL_SAVE = 1,
    WMT_CREDENTIAL_DONT_CACHE = 2,
    WMT_CREDENTIAL_CLEAR_TEXT = 4,
    WMT_CREDENTIAL_PROXY = 8,
    WMT_CREDENTIAL_ENCRYPT = 16,
}

enum WM_AETYPE
{
    WM_AETYPE_INCLUDE = 105,
    WM_AETYPE_EXCLUDE = 101,
}

enum WMT_RIGHTS
{
    WMT_RIGHT_PLAYBACK = 1,
    WMT_RIGHT_COPY_TO_NON_SDMI_DEVICE = 2,
    WMT_RIGHT_COPY_TO_CD = 8,
    WMT_RIGHT_COPY_TO_SDMI_DEVICE = 16,
    WMT_RIGHT_ONE_TIME = 32,
    WMT_RIGHT_SAVE_STREAM_PROTECTED = 64,
    WMT_RIGHT_COPY = 128,
    WMT_RIGHT_COLLABORATIVE_PLAY = 256,
    WMT_RIGHT_SDMI_TRIGGER = 65536,
    WMT_RIGHT_SDMI_NOMORECOPIES = 131072,
}

struct WM_STREAM_PRIORITY_RECORD
{
    ushort wStreamNumber;
    BOOL fMandatory;
}

struct WM_WRITER_STATISTICS
{
    ulong qwSampleCount;
    ulong qwByteCount;
    ulong qwDroppedSampleCount;
    ulong qwDroppedByteCount;
    uint dwCurrentBitrate;
    uint dwAverageBitrate;
    uint dwExpectedBitrate;
    uint dwCurrentSampleRate;
    uint dwAverageSampleRate;
    uint dwExpectedSampleRate;
}

struct WM_WRITER_STATISTICS_EX
{
    uint dwBitratePlusOverhead;
    uint dwCurrentSampleDropRateInQueue;
    uint dwCurrentSampleDropRateInCodec;
    uint dwCurrentSampleDropRateInMultiplexer;
    uint dwTotalSampleDropsInQueue;
    uint dwTotalSampleDropsInCodec;
    uint dwTotalSampleDropsInMultiplexer;
}

struct WM_READER_STATISTICS
{
    uint cbSize;
    uint dwBandwidth;
    uint cPacketsReceived;
    uint cPacketsRecovered;
    uint cPacketsLost;
    ushort wQuality;
}

struct WM_READER_CLIENTINFO
{
    uint cbSize;
    ushort* wszLang;
    ushort* wszBrowserUserAgent;
    ushort* wszBrowserWebPage;
    ulong qwReserved;
    LPARAM* pReserved;
    ushort* wszHostExe;
    ulong qwHostVersion;
    ushort* wszPlayerUserAgent;
}

struct WM_CLIENT_PROPERTIES
{
    uint dwIPAddress;
    uint dwPort;
}

struct WM_CLIENT_PROPERTIES_EX
{
    uint cbSize;
    const(wchar)* pwszIPAddress;
    const(wchar)* pwszPort;
    const(wchar)* pwszDNSName;
}

struct WM_PORT_NUMBER_RANGE
{
    ushort wPortBegin;
    ushort wPortEnd;
}

struct WMT_BUFFER_SEGMENT
{
    INSSBuffer pBuffer;
    uint cbOffset;
    uint cbLength;
}

struct WMT_PAYLOAD_FRAGMENT
{
    uint dwPayloadIndex;
    WMT_BUFFER_SEGMENT segmentData;
}

struct WMT_FILESINK_DATA_UNIT
{
    WMT_BUFFER_SEGMENT packetHeaderBuffer;
    uint cPayloads;
    WMT_BUFFER_SEGMENT* pPayloadHeaderBuffers;
    uint cPayloadDataFragments;
    WMT_PAYLOAD_FRAGMENT* pPayloadDataFragments;
}

struct WMT_WEBSTREAM_FORMAT
{
    ushort cbSize;
    ushort cbSampleHeaderFixedData;
    ushort wVersion;
    ushort wReserved;
}

struct WMT_WEBSTREAM_SAMPLE_HEADER
{
    ushort cbLength;
    ushort wPart;
    ushort cTotalParts;
    ushort wSampleType;
    ushort wszURL;
}

struct WM_ADDRESS_ACCESSENTRY
{
    uint dwIPAddress;
    uint dwMask;
}

struct WM_PICTURE
{
    const(wchar)* pwszMIMEType;
    ubyte bPictureType;
    const(wchar)* pwszDescription;
    uint dwDataLen;
    ubyte* pbData;
}

struct WM_SYNCHRONISED_LYRICS
{
    ubyte bTimeStampFormat;
    ubyte bContentType;
    const(wchar)* pwszContentDescriptor;
    uint dwLyricsLen;
    ubyte* pbLyrics;
}

struct WM_USER_WEB_URL
{
    const(wchar)* pwszDescription;
    const(wchar)* pwszURL;
}

struct WM_USER_TEXT
{
    const(wchar)* pwszDescription;
    const(wchar)* pwszText;
}

struct WM_LEAKY_BUCKET_PAIR
{
    uint dwBitrate;
    uint msBufferWindow;
}

struct WM_STREAM_TYPE_INFO
{
    Guid guidMajorType;
    uint cbFormat;
}

struct WMT_WATERMARK_ENTRY
{
    WMT_WATERMARK_ENTRY_TYPE wmetType;
    Guid clsid;
    uint cbDisplayName;
    const(wchar)* pwszDisplayName;
}

struct WMT_VIDEOIMAGE_SAMPLE
{
    uint dwMagic;
    uint cbStruct;
    uint dwControlFlags;
    uint dwInputFlagsCur;
    int lCurMotionXtoX;
    int lCurMotionYtoX;
    int lCurMotionXoffset;
    int lCurMotionXtoY;
    int lCurMotionYtoY;
    int lCurMotionYoffset;
    int lCurBlendCoef1;
    int lCurBlendCoef2;
    uint dwInputFlagsPrev;
    int lPrevMotionXtoX;
    int lPrevMotionYtoX;
    int lPrevMotionXoffset;
    int lPrevMotionXtoY;
    int lPrevMotionYtoY;
    int lPrevMotionYoffset;
    int lPrevBlendCoef1;
    int lPrevBlendCoef2;
}

struct WMT_VIDEOIMAGE_SAMPLE2
{
    uint dwMagic;
    uint dwStructSize;
    uint dwControlFlags;
    uint dwViewportWidth;
    uint dwViewportHeight;
    uint dwCurrImageWidth;
    uint dwCurrImageHeight;
    float fCurrRegionX0;
    float fCurrRegionY0;
    float fCurrRegionWidth;
    float fCurrRegionHeight;
    float fCurrBlendCoef;
    uint dwPrevImageWidth;
    uint dwPrevImageHeight;
    float fPrevRegionX0;
    float fPrevRegionY0;
    float fPrevRegionWidth;
    float fPrevRegionHeight;
    float fPrevBlendCoef;
    uint dwEffectType;
    uint dwNumEffectParas;
    float fEffectPara0;
    float fEffectPara1;
    float fEffectPara2;
    float fEffectPara3;
    float fEffectPara4;
    BOOL bKeepPrevImage;
}

struct WM_MEDIA_TYPE
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

struct WMVIDEOINFOHEADER
{
    RECT rcSource;
    RECT rcTarget;
    uint dwBitRate;
    uint dwBitErrorRate;
    long AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
}

struct WMVIDEOINFOHEADER2
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
    uint dwReserved1;
    uint dwReserved2;
    BITMAPINFOHEADER bmiHeader;
}

struct WMMPEG2VIDEOINFO
{
    WMVIDEOINFOHEADER2 hdr;
    uint dwStartTimeCode;
    uint cbSequenceHeader;
    uint dwProfile;
    uint dwLevel;
    uint dwFlags;
    uint dwSequenceHeader;
}

struct WMSCRIPTFORMAT
{
    Guid scriptType;
}

struct WMT_COLORSPACEINFO_EXTENSION_DATA
{
    ubyte ucColorPrimaries;
    ubyte ucColorTransferChar;
    ubyte ucColorMatrixCoef;
}

struct WMT_TIMECODE_EXTENSION_DATA
{
    ushort wRange;
    uint dwTimecode;
    uint dwUserbits;
    uint dwAmFlags;
}

struct DRM_VAL16
{
    ubyte val;
}

const GUID IID_IWMMediaProps = {0x96406BCE, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BCE, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMMediaProps : IUnknown
{
    HRESULT GetType(Guid* pguidType);
    HRESULT GetMediaType(WM_MEDIA_TYPE* pType, uint* pcbType);
    HRESULT SetMediaType(WM_MEDIA_TYPE* pType);
}

const GUID IID_IWMVideoMediaProps = {0x96406BCF, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BCF, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMVideoMediaProps : IWMMediaProps
{
    HRESULT GetMaxKeyFrameSpacing(long* pllTime);
    HRESULT SetMaxKeyFrameSpacing(long llTime);
    HRESULT GetQuality(uint* pdwQuality);
    HRESULT SetQuality(uint dwQuality);
}

const GUID IID_IWMWriter = {0x96406BD4, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BD4, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMWriter : IUnknown
{
    HRESULT SetProfileByID(const(Guid)* guidProfile);
    HRESULT SetProfile(IWMProfile pProfile);
    HRESULT SetOutputFilename(const(wchar)* pwszFilename);
    HRESULT GetInputCount(uint* pcInputs);
    HRESULT GetInputProps(uint dwInputNum, IWMInputMediaProps* ppInput);
    HRESULT SetInputProps(uint dwInputNum, IWMInputMediaProps pInput);
    HRESULT GetInputFormatCount(uint dwInputNumber, uint* pcFormats);
    HRESULT GetInputFormat(uint dwInputNumber, uint dwFormatNumber, IWMInputMediaProps* pProps);
    HRESULT BeginWriting();
    HRESULT EndWriting();
    HRESULT AllocateSample(uint dwSampleSize, INSSBuffer* ppSample);
    HRESULT WriteSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    HRESULT Flush();
}

const GUID IID_IWMDRMWriter = {0xD6EA5DD0, 0x12A0, 0x43F4, [0x90, 0xAB, 0xA3, 0xFD, 0x45, 0x1E, 0x6A, 0x07]};
@GUID(0xD6EA5DD0, 0x12A0, 0x43F4, [0x90, 0xAB, 0xA3, 0xFD, 0x45, 0x1E, 0x6A, 0x07]);
interface IWMDRMWriter : IUnknown
{
    HRESULT GenerateKeySeed(ushort* pwszKeySeed, uint* pcwchLength);
    HRESULT GenerateKeyID(ushort* pwszKeyID, uint* pcwchLength);
    HRESULT GenerateSigningKeyPair(ushort* pwszPrivKey, uint* pcwchPrivKeyLength, ushort* pwszPubKey, uint* pcwchPubKeyLength);
    HRESULT SetDRMAttribute(ushort wStreamNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
}

struct WMDRM_IMPORT_INIT_STRUCT
{
    uint dwVersion;
    uint cbEncryptedSessionKeyMessage;
    ubyte* pbEncryptedSessionKeyMessage;
    uint cbEncryptedKeyMessage;
    ubyte* pbEncryptedKeyMessage;
}

const GUID IID_IWMDRMWriter2 = {0x38EE7A94, 0x40E2, 0x4E10, [0xAA, 0x3F, 0x33, 0xFD, 0x32, 0x10, 0xED, 0x5B]};
@GUID(0x38EE7A94, 0x40E2, 0x4E10, [0xAA, 0x3F, 0x33, 0xFD, 0x32, 0x10, 0xED, 0x5B]);
interface IWMDRMWriter2 : IWMDRMWriter
{
    HRESULT SetWMDRMNetEncryption(BOOL fSamplesEncrypted, ubyte* pbKeyID, uint cbKeyID);
}

const GUID IID_IWMDRMWriter3 = {0xA7184082, 0xA4AA, 0x4DDE, [0xAC, 0x9C, 0xE7, 0x5D, 0xBD, 0x11, 0x17, 0xCE]};
@GUID(0xA7184082, 0xA4AA, 0x4DDE, [0xAC, 0x9C, 0xE7, 0x5D, 0xBD, 0x11, 0x17, 0xCE]);
interface IWMDRMWriter3 : IWMDRMWriter2
{
    HRESULT SetProtectStreamSamples(WMDRM_IMPORT_INIT_STRUCT* pImportInitStruct);
}

const GUID IID_IWMInputMediaProps = {0x96406BD5, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BD5, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMInputMediaProps : IWMMediaProps
{
    HRESULT GetConnectionName(ushort* pwszName, ushort* pcchName);
    HRESULT GetGroupName(ushort* pwszName, ushort* pcchName);
}

const GUID IID_IWMPropertyVault = {0x72995A79, 0x5090, 0x42A4, [0x9C, 0x8C, 0xD9, 0xD0, 0xB6, 0xD3, 0x4B, 0xE5]};
@GUID(0x72995A79, 0x5090, 0x42A4, [0x9C, 0x8C, 0xD9, 0xD0, 0xB6, 0xD3, 0x4B, 0xE5]);
interface IWMPropertyVault : IUnknown
{
    HRESULT GetPropertyCount(uint* pdwCount);
    HRESULT GetPropertyByName(const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    HRESULT SetProperty(const(wchar)* pszName, WMT_ATTR_DATATYPE pType, ubyte* pValue, uint dwSize);
    HRESULT GetPropertyByIndex(uint dwIndex, const(wchar)* pszName, uint* pdwNameLen, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    HRESULT CopyPropertiesFrom(IWMPropertyVault pIWMPropertyVault);
    HRESULT Clear();
}

const GUID IID_IWMIStreamProps = {0x6816DAD3, 0x2B4B, 0x4C8E, [0x81, 0x49, 0x87, 0x4C, 0x34, 0x83, 0xA7, 0x53]};
@GUID(0x6816DAD3, 0x2B4B, 0x4C8E, [0x81, 0x49, 0x87, 0x4C, 0x34, 0x83, 0xA7, 0x53]);
interface IWMIStreamProps : IUnknown
{
    HRESULT GetProperty(const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

const GUID IID_IWMReader = {0x96406BD6, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BD6, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMReader : IUnknown
{
    HRESULT Open(const(wchar)* pwszURL, IWMReaderCallback pCallback, void* pvContext);
    HRESULT Close();
    HRESULT GetOutputCount(uint* pcOutputs);
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    HRESULT GetOutputFormatCount(uint dwOutputNumber, uint* pcFormats);
    HRESULT GetOutputFormat(uint dwOutputNumber, uint dwFormatNumber, IWMOutputMediaProps* ppProps);
    HRESULT Start(ulong cnsStart, ulong cnsDuration, float fRate, void* pvContext);
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Resume();
}

const GUID IID_IWMSyncReader = {0x9397F121, 0x7705, 0x4DC9, [0xB0, 0x49, 0x98, 0xB6, 0x98, 0x18, 0x84, 0x14]};
@GUID(0x9397F121, 0x7705, 0x4DC9, [0xB0, 0x49, 0x98, 0xB6, 0x98, 0x18, 0x84, 0x14]);
interface IWMSyncReader : IUnknown
{
    HRESULT Open(const(wchar)* pwszFilename);
    HRESULT Close();
    HRESULT SetRange(ulong cnsStartTime, long cnsDuration);
    HRESULT SetRangeByFrame(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead);
    HRESULT GetNextSample(ushort wStreamNum, INSSBuffer* ppSample, ulong* pcnsSampleTime, ulong* pcnsDuration, uint* pdwFlags, uint* pdwOutputNum, ushort* pwStreamNum);
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    HRESULT SetReadStreamSamples(ushort wStreamNum, BOOL fCompressed);
    HRESULT GetReadStreamSamples(ushort wStreamNum, int* pfCompressed);
    HRESULT GetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT SetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
    HRESULT GetOutputCount(uint* pcOutputs);
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    HRESULT GetOutputFormatCount(uint dwOutputNum, uint* pcFormats);
    HRESULT GetOutputFormat(uint dwOutputNum, uint dwFormatNum, IWMOutputMediaProps* ppProps);
    HRESULT GetOutputNumberForStream(ushort wStreamNum, uint* pdwOutputNum);
    HRESULT GetStreamNumberForOutput(uint dwOutputNum, ushort* pwStreamNum);
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    HRESULT OpenStream(IStream pStream);
}

const GUID IID_IWMSyncReader2 = {0xFAED3D21, 0x1B6B, 0x4AF7, [0x8C, 0xB6, 0x3E, 0x18, 0x9B, 0xBC, 0x18, 0x7B]};
@GUID(0xFAED3D21, 0x1B6B, 0x4AF7, [0x8C, 0xB6, 0x3E, 0x18, 0x9B, 0xBC, 0x18, 0x7B]);
interface IWMSyncReader2 : IWMSyncReader
{
    HRESULT SetRangeByTimecode(ushort wStreamNum, WMT_TIMECODE_EXTENSION_DATA* pStart, WMT_TIMECODE_EXTENSION_DATA* pEnd);
    HRESULT SetRangeByFrameEx(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead, ulong* pcnsStartTime);
    HRESULT SetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx pAllocator);
    HRESULT GetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx* ppAllocator);
    HRESULT SetAllocateForStream(ushort wStreamNum, IWMReaderAllocatorEx pAllocator);
    HRESULT GetAllocateForStream(ushort dwSreamNum, IWMReaderAllocatorEx* ppAllocator);
}

const GUID IID_IWMOutputMediaProps = {0x96406BD7, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BD7, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMOutputMediaProps : IWMMediaProps
{
    HRESULT GetStreamGroupName(ushort* pwszName, ushort* pcchName);
    HRESULT GetConnectionName(ushort* pwszName, ushort* pcchName);
}

const GUID IID_IWMStatusCallback = {0x6D7CDC70, 0x9888, 0x11D3, [0x8E, 0xDC, 0x00, 0xC0, 0x4F, 0x61, 0x09, 0xCF]};
@GUID(0x6D7CDC70, 0x9888, 0x11D3, [0x8E, 0xDC, 0x00, 0xC0, 0x4F, 0x61, 0x09, 0xCF]);
interface IWMStatusCallback : IUnknown
{
    HRESULT OnStatus(WMT_STATUS Status, HRESULT hr, WMT_ATTR_DATATYPE dwType, ubyte* pValue, void* pvContext);
}

const GUID IID_IWMReaderCallback = {0x96406BD8, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BD8, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMReaderCallback : IWMStatusCallback
{
    HRESULT OnSample(uint dwOutputNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, INSSBuffer pSample, void* pvContext);
}

const GUID IID_IWMCredentialCallback = {0x342E0EB7, 0xE651, 0x450C, [0x97, 0x5B, 0x2A, 0xCE, 0x2C, 0x90, 0xC4, 0x8E]};
@GUID(0x342E0EB7, 0xE651, 0x450C, [0x97, 0x5B, 0x2A, 0xCE, 0x2C, 0x90, 0xC4, 0x8E]);
interface IWMCredentialCallback : IUnknown
{
    HRESULT AcquireCredentials(ushort* pwszRealm, ushort* pwszSite, ushort* pwszUser, uint cchUser, ushort* pwszPassword, uint cchPassword, HRESULT hrStatus, uint* pdwFlags);
}

const GUID IID_IWMMetadataEditor = {0x96406BD9, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BD9, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMMetadataEditor : IUnknown
{
    HRESULT Open(const(wchar)* pwszFilename);
    HRESULT Close();
    HRESULT Flush();
}

const GUID IID_IWMMetadataEditor2 = {0x203CFFE3, 0x2E18, 0x4FDF, [0xB5, 0x9D, 0x6E, 0x71, 0x53, 0x05, 0x34, 0xCF]};
@GUID(0x203CFFE3, 0x2E18, 0x4FDF, [0xB5, 0x9D, 0x6E, 0x71, 0x53, 0x05, 0x34, 0xCF]);
interface IWMMetadataEditor2 : IWMMetadataEditor
{
    HRESULT OpenEx(const(wchar)* pwszFilename, uint dwDesiredAccess, uint dwShareMode);
}

const GUID IID_IWMDRMEditor = {0xFF130EBC, 0xA6C3, 0x42A6, [0xB4, 0x01, 0xC3, 0x38, 0x2C, 0x3E, 0x08, 0xB3]};
@GUID(0xFF130EBC, 0xA6C3, 0x42A6, [0xB4, 0x01, 0xC3, 0x38, 0x2C, 0x3E, 0x08, 0xB3]);
interface IWMDRMEditor : IUnknown
{
    HRESULT GetDRMProperty(const(wchar)* pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

const GUID IID_IWMHeaderInfo = {0x96406BDA, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BDA, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMHeaderInfo : IUnknown
{
    HRESULT GetAttributeCount(ushort wStreamNum, ushort* pcAttributes);
    HRESULT GetAttributeByIndex(ushort wIndex, ushort* pwStreamNum, ushort* pwszName, ushort* pcchNameLen, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT GetAttributeByName(ushort* pwStreamNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT SetAttribute(ushort wStreamNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
    HRESULT GetMarkerCount(ushort* pcMarkers);
    HRESULT GetMarker(ushort wIndex, ushort* pwszMarkerName, ushort* pcchMarkerNameLen, ulong* pcnsMarkerTime);
    HRESULT AddMarker(const(wchar)* pwszMarkerName, ulong cnsMarkerTime);
    HRESULT RemoveMarker(ushort wIndex);
    HRESULT GetScriptCount(ushort* pcScripts);
    HRESULT GetScript(ushort wIndex, ushort* pwszType, ushort* pcchTypeLen, ushort* pwszCommand, ushort* pcchCommandLen, ulong* pcnsScriptTime);
    HRESULT AddScript(const(wchar)* pwszType, const(wchar)* pwszCommand, ulong cnsScriptTime);
    HRESULT RemoveScript(ushort wIndex);
}

const GUID IID_IWMHeaderInfo2 = {0x15CF9781, 0x454E, 0x482E, [0xB3, 0x93, 0x85, 0xFA, 0xE4, 0x87, 0xA8, 0x10]};
@GUID(0x15CF9781, 0x454E, 0x482E, [0xB3, 0x93, 0x85, 0xFA, 0xE4, 0x87, 0xA8, 0x10]);
interface IWMHeaderInfo2 : IWMHeaderInfo
{
    HRESULT GetCodecInfoCount(uint* pcCodecInfos);
    HRESULT GetCodecInfo(uint wIndex, ushort* pcchName, ushort* pwszName, ushort* pcchDescription, ushort* pwszDescription, WMT_CODEC_INFO_TYPE* pCodecType, ushort* pcbCodecInfo, ubyte* pbCodecInfo);
}

const GUID IID_IWMHeaderInfo3 = {0x15CC68E3, 0x27CC, 0x4ECD, [0xB2, 0x22, 0x3F, 0x5D, 0x02, 0xD8, 0x0B, 0xD5]};
@GUID(0x15CC68E3, 0x27CC, 0x4ECD, [0xB2, 0x22, 0x3F, 0x5D, 0x02, 0xD8, 0x0B, 0xD5]);
interface IWMHeaderInfo3 : IWMHeaderInfo2
{
    HRESULT GetAttributeCountEx(ushort wStreamNum, ushort* pcAttributes);
    HRESULT GetAttributeIndices(ushort wStreamNum, const(wchar)* pwszName, ushort* pwLangIndex, ushort* pwIndices, ushort* pwCount);
    HRESULT GetAttributeByIndexEx(ushort wStreamNum, ushort wIndex, const(wchar)* pwszName, ushort* pwNameLen, WMT_ATTR_DATATYPE* pType, ushort* pwLangIndex, ubyte* pValue, uint* pdwDataLength);
    HRESULT ModifyAttribute(ushort wStreamNum, ushort wIndex, WMT_ATTR_DATATYPE Type, ushort wLangIndex, const(ubyte)* pValue, uint dwLength);
    HRESULT AddAttribute(ushort wStreamNum, const(wchar)* pszName, ushort* pwIndex, WMT_ATTR_DATATYPE Type, ushort wLangIndex, const(ubyte)* pValue, uint dwLength);
    HRESULT DeleteAttribute(ushort wStreamNum, ushort wIndex);
    HRESULT AddCodecInfo(const(wchar)* pwszName, const(wchar)* pwszDescription, WMT_CODEC_INFO_TYPE codecType, ushort cbCodecInfo, ubyte* pbCodecInfo);
}

const GUID IID_IWMProfileManager = {0xD16679F2, 0x6CA0, 0x472D, [0x8D, 0x31, 0x2F, 0x5D, 0x55, 0xAE, 0xE1, 0x55]};
@GUID(0xD16679F2, 0x6CA0, 0x472D, [0x8D, 0x31, 0x2F, 0x5D, 0x55, 0xAE, 0xE1, 0x55]);
interface IWMProfileManager : IUnknown
{
    HRESULT CreateEmptyProfile(WMT_VERSION dwVersion, IWMProfile* ppProfile);
    HRESULT LoadProfileByID(const(Guid)* guidProfile, IWMProfile* ppProfile);
    HRESULT LoadProfileByData(const(wchar)* pwszProfile, IWMProfile* ppProfile);
    HRESULT SaveProfile(IWMProfile pIWMProfile, ushort* pwszProfile, uint* pdwLength);
    HRESULT GetSystemProfileCount(uint* pcProfiles);
    HRESULT LoadSystemProfile(uint dwProfileIndex, IWMProfile* ppProfile);
}

const GUID IID_IWMProfileManager2 = {0x7A924E51, 0x73C1, 0x494D, [0x80, 0x19, 0x23, 0xD3, 0x7E, 0xD9, 0xB8, 0x9A]};
@GUID(0x7A924E51, 0x73C1, 0x494D, [0x80, 0x19, 0x23, 0xD3, 0x7E, 0xD9, 0xB8, 0x9A]);
interface IWMProfileManager2 : IWMProfileManager
{
    HRESULT GetSystemProfileVersion(WMT_VERSION* pdwVersion);
    HRESULT SetSystemProfileVersion(WMT_VERSION dwVersion);
}

const GUID IID_IWMProfileManagerLanguage = {0xBA4DCC78, 0x7EE0, 0x4AB8, [0xB2, 0x7A, 0xDB, 0xCE, 0x8B, 0xC5, 0x14, 0x54]};
@GUID(0xBA4DCC78, 0x7EE0, 0x4AB8, [0xB2, 0x7A, 0xDB, 0xCE, 0x8B, 0xC5, 0x14, 0x54]);
interface IWMProfileManagerLanguage : IUnknown
{
    HRESULT GetUserLanguageID(ushort* wLangID);
    HRESULT SetUserLanguageID(ushort wLangID);
}

const GUID IID_IWMProfile = {0x96406BDB, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BDB, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMProfile : IUnknown
{
    HRESULT GetVersion(WMT_VERSION* pdwVersion);
    HRESULT GetName(ushort* pwszName, uint* pcchName);
    HRESULT SetName(const(wchar)* pwszName);
    HRESULT GetDescription(ushort* pwszDescription, uint* pcchDescription);
    HRESULT SetDescription(const(wchar)* pwszDescription);
    HRESULT GetStreamCount(uint* pcStreams);
    HRESULT GetStream(uint dwStreamIndex, IWMStreamConfig* ppConfig);
    HRESULT GetStreamByNumber(ushort wStreamNum, IWMStreamConfig* ppConfig);
    HRESULT RemoveStream(IWMStreamConfig pConfig);
    HRESULT RemoveStreamByNumber(ushort wStreamNum);
    HRESULT AddStream(IWMStreamConfig pConfig);
    HRESULT ReconfigStream(IWMStreamConfig pConfig);
    HRESULT CreateNewStream(const(Guid)* guidStreamType, IWMStreamConfig* ppConfig);
    HRESULT GetMutualExclusionCount(uint* pcME);
    HRESULT GetMutualExclusion(uint dwMEIndex, IWMMutualExclusion* ppME);
    HRESULT RemoveMutualExclusion(IWMMutualExclusion pME);
    HRESULT AddMutualExclusion(IWMMutualExclusion pME);
    HRESULT CreateNewMutualExclusion(IWMMutualExclusion* ppME);
}

const GUID IID_IWMProfile2 = {0x07E72D33, 0xD94E, 0x4BE7, [0x88, 0x43, 0x60, 0xAE, 0x5F, 0xF7, 0xE5, 0xF5]};
@GUID(0x07E72D33, 0xD94E, 0x4BE7, [0x88, 0x43, 0x60, 0xAE, 0x5F, 0xF7, 0xE5, 0xF5]);
interface IWMProfile2 : IWMProfile
{
    HRESULT GetProfileID(Guid* pguidID);
}

const GUID IID_IWMProfile3 = {0x00EF96CC, 0xA461, 0x4546, [0x8B, 0xCD, 0xC9, 0xA2, 0x8F, 0x0E, 0x06, 0xF5]};
@GUID(0x00EF96CC, 0xA461, 0x4546, [0x8B, 0xCD, 0xC9, 0xA2, 0x8F, 0x0E, 0x06, 0xF5]);
interface IWMProfile3 : IWMProfile2
{
    HRESULT GetStorageFormat(WMT_STORAGE_FORMAT* pnStorageFormat);
    HRESULT SetStorageFormat(WMT_STORAGE_FORMAT nStorageFormat);
    HRESULT GetBandwidthSharingCount(uint* pcBS);
    HRESULT GetBandwidthSharing(uint dwBSIndex, IWMBandwidthSharing* ppBS);
    HRESULT RemoveBandwidthSharing(IWMBandwidthSharing pBS);
    HRESULT AddBandwidthSharing(IWMBandwidthSharing pBS);
    HRESULT CreateNewBandwidthSharing(IWMBandwidthSharing* ppBS);
    HRESULT GetStreamPrioritization(IWMStreamPrioritization* ppSP);
    HRESULT SetStreamPrioritization(IWMStreamPrioritization pSP);
    HRESULT RemoveStreamPrioritization();
    HRESULT CreateNewStreamPrioritization(IWMStreamPrioritization* ppSP);
    HRESULT GetExpectedPacketCount(ulong msDuration, ulong* pcPackets);
}

const GUID IID_IWMStreamConfig = {0x96406BDC, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BDC, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMStreamConfig : IUnknown
{
    HRESULT GetStreamType(Guid* pguidStreamType);
    HRESULT GetStreamNumber(ushort* pwStreamNum);
    HRESULT SetStreamNumber(ushort wStreamNum);
    HRESULT GetStreamName(ushort* pwszStreamName, ushort* pcchStreamName);
    HRESULT SetStreamName(const(wchar)* pwszStreamName);
    HRESULT GetConnectionName(ushort* pwszInputName, ushort* pcchInputName);
    HRESULT SetConnectionName(const(wchar)* pwszInputName);
    HRESULT GetBitrate(uint* pdwBitrate);
    HRESULT SetBitrate(uint pdwBitrate);
    HRESULT GetBufferWindow(uint* pmsBufferWindow);
    HRESULT SetBufferWindow(uint msBufferWindow);
}

const GUID IID_IWMStreamConfig2 = {0x7688D8CB, 0xFC0D, 0x43BD, [0x94, 0x59, 0x5A, 0x8D, 0xEC, 0x20, 0x0C, 0xFA]};
@GUID(0x7688D8CB, 0xFC0D, 0x43BD, [0x94, 0x59, 0x5A, 0x8D, 0xEC, 0x20, 0x0C, 0xFA]);
interface IWMStreamConfig2 : IWMStreamConfig
{
    HRESULT GetTransportType(WMT_TRANSPORT_TYPE* pnTransportType);
    HRESULT SetTransportType(WMT_TRANSPORT_TYPE nTransportType);
    HRESULT AddDataUnitExtension(Guid guidExtensionSystemID, ushort cbExtensionDataSize, ubyte* pbExtensionSystemInfo, uint cbExtensionSystemInfo);
    HRESULT GetDataUnitExtensionCount(ushort* pcDataUnitExtensions);
    HRESULT GetDataUnitExtension(ushort wDataUnitExtensionNumber, Guid* pguidExtensionSystemID, ushort* pcbExtensionDataSize, ubyte* pbExtensionSystemInfo, uint* pcbExtensionSystemInfo);
    HRESULT RemoveAllDataUnitExtensions();
}

const GUID IID_IWMStreamConfig3 = {0xCB164104, 0x3AA9, 0x45A7, [0x9A, 0xC9, 0x4D, 0xAE, 0xE1, 0x31, 0xD6, 0xE1]};
@GUID(0xCB164104, 0x3AA9, 0x45A7, [0x9A, 0xC9, 0x4D, 0xAE, 0xE1, 0x31, 0xD6, 0xE1]);
interface IWMStreamConfig3 : IWMStreamConfig2
{
    HRESULT GetLanguage(ushort* pwszLanguageString, ushort* pcchLanguageStringLength);
    HRESULT SetLanguage(const(wchar)* pwszLanguageString);
}

const GUID IID_IWMPacketSize = {0xCDFB97AB, 0x188F, 0x40B3, [0xB6, 0x43, 0x5B, 0x79, 0x03, 0x97, 0x5C, 0x59]};
@GUID(0xCDFB97AB, 0x188F, 0x40B3, [0xB6, 0x43, 0x5B, 0x79, 0x03, 0x97, 0x5C, 0x59]);
interface IWMPacketSize : IUnknown
{
    HRESULT GetMaxPacketSize(uint* pdwMaxPacketSize);
    HRESULT SetMaxPacketSize(uint dwMaxPacketSize);
}

const GUID IID_IWMPacketSize2 = {0x8BFC2B9E, 0xB646, 0x4233, [0xA8, 0x77, 0x1C, 0x6A, 0x07, 0x96, 0x69, 0xDC]};
@GUID(0x8BFC2B9E, 0xB646, 0x4233, [0xA8, 0x77, 0x1C, 0x6A, 0x07, 0x96, 0x69, 0xDC]);
interface IWMPacketSize2 : IWMPacketSize
{
    HRESULT GetMinPacketSize(uint* pdwMinPacketSize);
    HRESULT SetMinPacketSize(uint dwMinPacketSize);
}

const GUID IID_IWMStreamList = {0x96406BDD, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BDD, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMStreamList : IUnknown
{
    HRESULT GetStreams(ushort* pwStreamNumArray, ushort* pcStreams);
    HRESULT AddStream(ushort wStreamNum);
    HRESULT RemoveStream(ushort wStreamNum);
}

const GUID IID_IWMMutualExclusion = {0x96406BDE, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BDE, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMMutualExclusion : IWMStreamList
{
    HRESULT GetType(Guid* pguidType);
    HRESULT SetType(const(Guid)* guidType);
}

const GUID IID_IWMMutualExclusion2 = {0x0302B57D, 0x89D1, 0x4BA2, [0x85, 0xC9, 0x16, 0x6F, 0x2C, 0x53, 0xEB, 0x91]};
@GUID(0x0302B57D, 0x89D1, 0x4BA2, [0x85, 0xC9, 0x16, 0x6F, 0x2C, 0x53, 0xEB, 0x91]);
interface IWMMutualExclusion2 : IWMMutualExclusion
{
    HRESULT GetName(ushort* pwszName, ushort* pcchName);
    HRESULT SetName(const(wchar)* pwszName);
    HRESULT GetRecordCount(ushort* pwRecordCount);
    HRESULT AddRecord();
    HRESULT RemoveRecord(ushort wRecordNumber);
    HRESULT GetRecordName(ushort wRecordNumber, ushort* pwszRecordName, ushort* pcchRecordName);
    HRESULT SetRecordName(ushort wRecordNumber, const(wchar)* pwszRecordName);
    HRESULT GetStreamsForRecord(ushort wRecordNumber, ushort* pwStreamNumArray, ushort* pcStreams);
    HRESULT AddStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
    HRESULT RemoveStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
}

const GUID IID_IWMBandwidthSharing = {0xAD694AF1, 0xF8D9, 0x42F8, [0xBC, 0x47, 0x70, 0x31, 0x1B, 0x0C, 0x4F, 0x9E]};
@GUID(0xAD694AF1, 0xF8D9, 0x42F8, [0xBC, 0x47, 0x70, 0x31, 0x1B, 0x0C, 0x4F, 0x9E]);
interface IWMBandwidthSharing : IWMStreamList
{
    HRESULT GetType(Guid* pguidType);
    HRESULT SetType(const(Guid)* guidType);
    HRESULT GetBandwidth(uint* pdwBitrate, uint* pmsBufferWindow);
    HRESULT SetBandwidth(uint dwBitrate, uint msBufferWindow);
}

const GUID IID_IWMStreamPrioritization = {0x8C1C6090, 0xF9A8, 0x4748, [0x8E, 0xC3, 0xDD, 0x11, 0x08, 0xBA, 0x1E, 0x77]};
@GUID(0x8C1C6090, 0xF9A8, 0x4748, [0x8E, 0xC3, 0xDD, 0x11, 0x08, 0xBA, 0x1E, 0x77]);
interface IWMStreamPrioritization : IUnknown
{
    HRESULT GetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort* pcRecords);
    HRESULT SetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort cRecords);
}

const GUID IID_IWMWriterAdvanced = {0x96406BE3, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BE3, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMWriterAdvanced : IUnknown
{
    HRESULT GetSinkCount(uint* pcSinks);
    HRESULT GetSink(uint dwSinkNum, IWMWriterSink* ppSink);
    HRESULT AddSink(IWMWriterSink pSink);
    HRESULT RemoveSink(IWMWriterSink pSink);
    HRESULT WriteStreamSample(ushort wStreamNum, ulong cnsSampleTime, uint msSampleSendTime, ulong cnsSampleDuration, uint dwFlags, INSSBuffer pSample);
    HRESULT SetLiveSource(BOOL fIsLiveSource);
    HRESULT IsRealTime(int* pfRealTime);
    HRESULT GetWriterTime(ulong* pcnsCurrentTime);
    HRESULT GetStatistics(ushort wStreamNum, WM_WRITER_STATISTICS* pStats);
    HRESULT SetSyncTolerance(uint msWindow);
    HRESULT GetSyncTolerance(uint* pmsWindow);
}

const GUID IID_IWMWriterAdvanced2 = {0x962DC1EC, 0xC046, 0x4DB8, [0x9C, 0xC7, 0x26, 0xCE, 0xAE, 0x50, 0x08, 0x17]};
@GUID(0x962DC1EC, 0xC046, 0x4DB8, [0x9C, 0xC7, 0x26, 0xCE, 0xAE, 0x50, 0x08, 0x17]);
interface IWMWriterAdvanced2 : IWMWriterAdvanced
{
    HRESULT GetInputSetting(uint dwInputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT SetInputSetting(uint dwInputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
}

const GUID IID_IWMWriterAdvanced3 = {0x2CD6492D, 0x7C37, 0x4E76, [0x9D, 0x3B, 0x59, 0x26, 0x11, 0x83, 0xA2, 0x2E]};
@GUID(0x2CD6492D, 0x7C37, 0x4E76, [0x9D, 0x3B, 0x59, 0x26, 0x11, 0x83, 0xA2, 0x2E]);
interface IWMWriterAdvanced3 : IWMWriterAdvanced2
{
    HRESULT GetStatisticsEx(ushort wStreamNum, WM_WRITER_STATISTICS_EX* pStats);
    HRESULT SetNonBlocking();
}

const GUID IID_IWMWriterPreprocess = {0xFC54A285, 0x38C4, 0x45B5, [0xAA, 0x23, 0x85, 0xB9, 0xF7, 0xCB, 0x42, 0x4B]};
@GUID(0xFC54A285, 0x38C4, 0x45B5, [0xAA, 0x23, 0x85, 0xB9, 0xF7, 0xCB, 0x42, 0x4B]);
interface IWMWriterPreprocess : IUnknown
{
    HRESULT GetMaxPreprocessingPasses(uint dwInputNum, uint dwFlags, uint* pdwMaxNumPasses);
    HRESULT SetNumPreprocessingPasses(uint dwInputNum, uint dwFlags, uint dwNumPasses);
    HRESULT BeginPreprocessingPass(uint dwInputNum, uint dwFlags);
    HRESULT PreprocessSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    HRESULT EndPreprocessingPass(uint dwInputNum, uint dwFlags);
}

const GUID IID_IWMWriterPostViewCallback = {0xD9D6549D, 0xA193, 0x4F24, [0xB3, 0x08, 0x03, 0x12, 0x3D, 0x9B, 0x7F, 0x8D]};
@GUID(0xD9D6549D, 0xA193, 0x4F24, [0xB3, 0x08, 0x03, 0x12, 0x3D, 0x9B, 0x7F, 0x8D]);
interface IWMWriterPostViewCallback : IWMStatusCallback
{
    HRESULT OnPostViewSample(ushort wStreamNumber, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, INSSBuffer pSample, void* pvContext);
    HRESULT AllocateForPostView(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

const GUID IID_IWMWriterPostView = {0x81E20CE4, 0x75EF, 0x491A, [0x80, 0x04, 0xFC, 0x53, 0xC4, 0x5B, 0xDC, 0x3E]};
@GUID(0x81E20CE4, 0x75EF, 0x491A, [0x80, 0x04, 0xFC, 0x53, 0xC4, 0x5B, 0xDC, 0x3E]);
interface IWMWriterPostView : IUnknown
{
    HRESULT SetPostViewCallback(IWMWriterPostViewCallback pCallback, void* pvContext);
    HRESULT SetReceivePostViewSamples(ushort wStreamNum, BOOL fReceivePostViewSamples);
    HRESULT GetReceivePostViewSamples(ushort wStreamNum, int* pfReceivePostViewSamples);
    HRESULT GetPostViewProps(ushort wStreamNumber, IWMMediaProps* ppOutput);
    HRESULT SetPostViewProps(ushort wStreamNumber, IWMMediaProps pOutput);
    HRESULT GetPostViewFormatCount(ushort wStreamNumber, uint* pcFormats);
    HRESULT GetPostViewFormat(ushort wStreamNumber, uint dwFormatNumber, IWMMediaProps* ppProps);
    HRESULT SetAllocateForPostView(ushort wStreamNumber, BOOL fAllocate);
    HRESULT GetAllocateForPostView(ushort wStreamNumber, int* pfAllocate);
}

const GUID IID_IWMWriterSink = {0x96406BE4, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BE4, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMWriterSink : IUnknown
{
    HRESULT OnHeader(INSSBuffer pHeader);
    HRESULT IsRealTime(int* pfRealTime);
    HRESULT AllocateDataUnit(uint cbDataUnit, INSSBuffer* ppDataUnit);
    HRESULT OnDataUnit(INSSBuffer pDataUnit);
    HRESULT OnEndWriting();
}

const GUID IID_IWMRegisterCallback = {0xCF4B1F99, 0x4DE2, 0x4E49, [0xA3, 0x63, 0x25, 0x27, 0x40, 0xD9, 0x9B, 0xC1]};
@GUID(0xCF4B1F99, 0x4DE2, 0x4E49, [0xA3, 0x63, 0x25, 0x27, 0x40, 0xD9, 0x9B, 0xC1]);
interface IWMRegisterCallback : IUnknown
{
    HRESULT Advise(IWMStatusCallback pCallback, void* pvContext);
    HRESULT Unadvise(IWMStatusCallback pCallback, void* pvContext);
}

const GUID IID_IWMWriterFileSink = {0x96406BE5, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BE5, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMWriterFileSink : IWMWriterSink
{
    HRESULT Open(const(wchar)* pwszFilename);
}

const GUID IID_IWMWriterFileSink2 = {0x14282BA7, 0x4AEF, 0x4205, [0x8C, 0xE5, 0xC2, 0x29, 0x03, 0x5A, 0x05, 0xBC]};
@GUID(0x14282BA7, 0x4AEF, 0x4205, [0x8C, 0xE5, 0xC2, 0x29, 0x03, 0x5A, 0x05, 0xBC]);
interface IWMWriterFileSink2 : IWMWriterFileSink
{
    HRESULT Start(ulong cnsStartTime);
    HRESULT Stop(ulong cnsStopTime);
    HRESULT IsStopped(int* pfStopped);
    HRESULT GetFileDuration(ulong* pcnsDuration);
    HRESULT GetFileSize(ulong* pcbFile);
    HRESULT Close();
    HRESULT IsClosed(int* pfClosed);
}

const GUID IID_IWMWriterFileSink3 = {0x3FEA4FEB, 0x2945, 0x47A7, [0xA1, 0xDD, 0xC5, 0x3A, 0x8F, 0xC4, 0xC4, 0x5C]};
@GUID(0x3FEA4FEB, 0x2945, 0x47A7, [0xA1, 0xDD, 0xC5, 0x3A, 0x8F, 0xC4, 0xC4, 0x5C]);
interface IWMWriterFileSink3 : IWMWriterFileSink2
{
    HRESULT SetAutoIndexing(BOOL fDoAutoIndexing);
    HRESULT GetAutoIndexing(int* pfAutoIndexing);
    HRESULT SetControlStream(ushort wStreamNumber, BOOL fShouldControlStartAndStop);
    HRESULT GetMode(uint* pdwFileSinkMode);
    HRESULT OnDataUnitEx(WMT_FILESINK_DATA_UNIT* pFileSinkDataUnit);
    HRESULT SetUnbufferedIO(BOOL fUnbufferedIO, BOOL fRestrictMemUsage);
    HRESULT GetUnbufferedIO(int* pfUnbufferedIO);
    HRESULT CompleteOperations();
}

const GUID IID_IWMWriterNetworkSink = {0x96406BE7, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BE7, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMWriterNetworkSink : IWMWriterSink
{
    HRESULT SetMaximumClients(uint dwMaxClients);
    HRESULT GetMaximumClients(uint* pdwMaxClients);
    HRESULT SetNetworkProtocol(WMT_NET_PROTOCOL protocol);
    HRESULT GetNetworkProtocol(WMT_NET_PROTOCOL* pProtocol);
    HRESULT GetHostURL(ushort* pwszURL, uint* pcchURL);
    HRESULT Open(uint* pdwPortNum);
    HRESULT Disconnect();
    HRESULT Close();
}

const GUID IID_IWMClientConnections = {0x73C66010, 0xA299, 0x41DF, [0xB1, 0xF0, 0xCC, 0xF0, 0x3B, 0x09, 0xC1, 0xC6]};
@GUID(0x73C66010, 0xA299, 0x41DF, [0xB1, 0xF0, 0xCC, 0xF0, 0x3B, 0x09, 0xC1, 0xC6]);
interface IWMClientConnections : IUnknown
{
    HRESULT GetClientCount(uint* pcClients);
    HRESULT GetClientProperties(uint dwClientNum, WM_CLIENT_PROPERTIES* pClientProperties);
}

const GUID IID_IWMClientConnections2 = {0x4091571E, 0x4701, 0x4593, [0xBB, 0x3D, 0xD5, 0xF5, 0xF0, 0xC7, 0x42, 0x46]};
@GUID(0x4091571E, 0x4701, 0x4593, [0xBB, 0x3D, 0xD5, 0xF5, 0xF0, 0xC7, 0x42, 0x46]);
interface IWMClientConnections2 : IWMClientConnections
{
    HRESULT GetClientInfo(uint dwClientNum, ushort* pwszNetworkAddress, uint* pcchNetworkAddress, ushort* pwszPort, uint* pcchPort, ushort* pwszDNSName, uint* pcchDNSName);
}

const GUID IID_IWMReaderAdvanced = {0x96406BEA, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BEA, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMReaderAdvanced : IUnknown
{
    HRESULT SetUserProvidedClock(BOOL fUserClock);
    HRESULT GetUserProvidedClock(int* pfUserClock);
    HRESULT DeliverTime(ulong cnsTime);
    HRESULT SetManualStreamSelection(BOOL fSelection);
    HRESULT GetManualStreamSelection(int* pfSelection);
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    HRESULT SetReceiveSelectionCallbacks(BOOL fGetCallbacks);
    HRESULT GetReceiveSelectionCallbacks(int* pfGetCallbacks);
    HRESULT SetReceiveStreamSamples(ushort wStreamNum, BOOL fReceiveStreamSamples);
    HRESULT GetReceiveStreamSamples(ushort wStreamNum, int* pfReceiveStreamSamples);
    HRESULT SetAllocateForOutput(uint dwOutputNum, BOOL fAllocate);
    HRESULT GetAllocateForOutput(uint dwOutputNum, int* pfAllocate);
    HRESULT SetAllocateForStream(ushort wStreamNum, BOOL fAllocate);
    HRESULT GetAllocateForStream(ushort dwSreamNum, int* pfAllocate);
    HRESULT GetStatistics(WM_READER_STATISTICS* pStatistics);
    HRESULT SetClientInfo(WM_READER_CLIENTINFO* pClientInfo);
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    HRESULT NotifyLateDelivery(ulong cnsLateness);
}

const GUID IID_IWMReaderAdvanced2 = {0xAE14A945, 0xB90C, 0x4D0D, [0x91, 0x27, 0x80, 0xD6, 0x65, 0xF7, 0xD7, 0x3E]};
@GUID(0xAE14A945, 0xB90C, 0x4D0D, [0x91, 0x27, 0x80, 0xD6, 0x65, 0xF7, 0xD7, 0x3E]);
interface IWMReaderAdvanced2 : IWMReaderAdvanced
{
    HRESULT SetPlayMode(WMT_PLAY_MODE Mode);
    HRESULT GetPlayMode(WMT_PLAY_MODE* pMode);
    HRESULT GetBufferProgress(uint* pdwPercent, ulong* pcnsBuffering);
    HRESULT GetDownloadProgress(uint* pdwPercent, ulong* pqwBytesDownloaded, ulong* pcnsDownload);
    HRESULT GetSaveAsProgress(uint* pdwPercent);
    HRESULT SaveFileAs(const(wchar)* pwszFilename);
    HRESULT GetProtocolName(ushort* pwszProtocol, uint* pcchProtocol);
    HRESULT StartAtMarker(ushort wMarkerIndex, ulong cnsDuration, float fRate, void* pvContext);
    HRESULT GetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT SetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
    HRESULT Preroll(ulong cnsStart, ulong cnsDuration, float fRate);
    HRESULT SetLogClientID(BOOL fLogClientID);
    HRESULT GetLogClientID(int* pfLogClientID);
    HRESULT StopBuffering();
    HRESULT OpenStream(IStream pStream, IWMReaderCallback pCallback, void* pvContext);
}

const GUID IID_IWMReaderAdvanced3 = {0x5DC0674B, 0xF04B, 0x4A4E, [0x9F, 0x2A, 0xB1, 0xAF, 0xDE, 0x2C, 0x81, 0x00]};
@GUID(0x5DC0674B, 0xF04B, 0x4A4E, [0x9F, 0x2A, 0xB1, 0xAF, 0xDE, 0x2C, 0x81, 0x00]);
interface IWMReaderAdvanced3 : IWMReaderAdvanced2
{
    HRESULT StopNetStreaming();
    HRESULT StartAtPosition(ushort wStreamNum, void* pvOffsetStart, void* pvDuration, WMT_OFFSET_FORMAT dwOffsetFormat, float fRate, void* pvContext);
}

const GUID IID_IWMReaderAdvanced4 = {0x945A76A2, 0x12AE, 0x4D48, [0xBD, 0x3C, 0xCD, 0x1D, 0x90, 0x39, 0x9B, 0x85]};
@GUID(0x945A76A2, 0x12AE, 0x4D48, [0xBD, 0x3C, 0xCD, 0x1D, 0x90, 0x39, 0x9B, 0x85]);
interface IWMReaderAdvanced4 : IWMReaderAdvanced3
{
    HRESULT GetLanguageCount(uint dwOutputNum, ushort* pwLanguageCount);
    HRESULT GetLanguage(uint dwOutputNum, ushort wLanguage, ushort* pwszLanguageString, ushort* pcchLanguageStringLength);
    HRESULT GetMaxSpeedFactor(double* pdblFactor);
    HRESULT IsUsingFastCache(int* pfUsingFastCache);
    HRESULT AddLogParam(const(wchar)* wszNameSpace, const(wchar)* wszName, const(wchar)* wszValue);
    HRESULT SendLogParams();
    HRESULT CanSaveFileAs(int* pfCanSave);
    HRESULT CancelSaveFileAs();
    HRESULT GetURL(ushort* pwszURL, uint* pcchURL);
}

const GUID IID_IWMReaderAdvanced5 = {0x24C44DB0, 0x55D1, 0x49AE, [0xA5, 0xCC, 0xF1, 0x38, 0x15, 0xE3, 0x63, 0x63]};
@GUID(0x24C44DB0, 0x55D1, 0x49AE, [0xA5, 0xCC, 0xF1, 0x38, 0x15, 0xE3, 0x63, 0x63]);
interface IWMReaderAdvanced5 : IWMReaderAdvanced4
{
    HRESULT SetPlayerHook(uint dwOutputNum, IWMPlayerHook pHook);
}

const GUID IID_IWMReaderAdvanced6 = {0x18A2E7F8, 0x428F, 0x4ACD, [0x8A, 0x00, 0xE6, 0x46, 0x39, 0xBC, 0x93, 0xDE]};
@GUID(0x18A2E7F8, 0x428F, 0x4ACD, [0x8A, 0x00, 0xE6, 0x46, 0x39, 0xBC, 0x93, 0xDE]);
interface IWMReaderAdvanced6 : IWMReaderAdvanced5
{
    HRESULT SetProtectStreamSamples(ubyte* pbCertificate, uint cbCertificate, uint dwCertificateType, uint dwFlags, ubyte* pbInitializationVector, uint* pcbInitializationVector);
}

const GUID IID_IWMPlayerHook = {0xE5B7CA9A, 0x0F1C, 0x4F66, [0x90, 0x02, 0x74, 0xEC, 0x50, 0xD8, 0xB3, 0x04]};
@GUID(0xE5B7CA9A, 0x0F1C, 0x4F66, [0x90, 0x02, 0x74, 0xEC, 0x50, 0xD8, 0xB3, 0x04]);
interface IWMPlayerHook : IUnknown
{
    HRESULT PreDecode();
}

const GUID IID_IWMReaderAllocatorEx = {0x9F762FA7, 0xA22E, 0x428D, [0x93, 0xC9, 0xAC, 0x82, 0xF3, 0xAA, 0xFE, 0x5A]};
@GUID(0x9F762FA7, 0xA22E, 0x428D, [0x93, 0xC9, 0xAC, 0x82, 0xF3, 0xAA, 0xFE, 0x5A]);
interface IWMReaderAllocatorEx : IUnknown
{
    HRESULT AllocateForStreamEx(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
    HRESULT AllocateForOutputEx(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
}

const GUID IID_IWMReaderTypeNegotiation = {0xFDBE5592, 0x81A1, 0x41EA, [0x93, 0xBD, 0x73, 0x5C, 0xAD, 0x1A, 0xDC, 0x05]};
@GUID(0xFDBE5592, 0x81A1, 0x41EA, [0x93, 0xBD, 0x73, 0x5C, 0xAD, 0x1A, 0xDC, 0x05]);
interface IWMReaderTypeNegotiation : IUnknown
{
    HRESULT TryOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
}

const GUID IID_IWMReaderCallbackAdvanced = {0x96406BEB, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BEB, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMReaderCallbackAdvanced : IUnknown
{
    HRESULT OnStreamSample(ushort wStreamNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, INSSBuffer pSample, void* pvContext);
    HRESULT OnTime(ulong cnsCurrentTime, void* pvContext);
    HRESULT OnStreamSelection(ushort wStreamCount, ushort* pStreamNumbers, WMT_STREAM_SELECTION* pSelections, void* pvContext);
    HRESULT OnOutputPropsChanged(uint dwOutputNum, WM_MEDIA_TYPE* pMediaType, void* pvContext);
    HRESULT AllocateForStream(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
    HRESULT AllocateForOutput(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

const GUID IID_IWMDRMReader = {0xD2827540, 0x3EE7, 0x432C, [0xB1, 0x4C, 0xDC, 0x17, 0xF0, 0x85, 0xD3, 0xB3]};
@GUID(0xD2827540, 0x3EE7, 0x432C, [0xB1, 0x4C, 0xDC, 0x17, 0xF0, 0x85, 0xD3, 0xB3]);
interface IWMDRMReader : IUnknown
{
    HRESULT AcquireLicense(uint dwFlags);
    HRESULT CancelLicenseAcquisition();
    HRESULT Individualize(uint dwFlags);
    HRESULT CancelIndividualization();
    HRESULT MonitorLicenseAcquisition();
    HRESULT CancelMonitorLicenseAcquisition();
    HRESULT SetDRMProperty(const(wchar)* pwstrName, WMT_ATTR_DATATYPE dwType, const(ubyte)* pValue, ushort cbLength);
    HRESULT GetDRMProperty(const(wchar)* pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

struct DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS
{
    ushort wCompressedDigitalVideo;
    ushort wUncompressedDigitalVideo;
    ushort wAnalogVideo;
    ushort wCompressedDigitalAudio;
    ushort wUncompressedDigitalAudio;
}

struct DRM_OPL_OUTPUT_IDS
{
    ushort cIds;
    Guid* rgIds;
}

struct DRM_OUTPUT_PROTECTION
{
    Guid guidId;
    ubyte bConfigData;
}

struct DRM_VIDEO_OUTPUT_PROTECTION_IDS
{
    ushort cEntries;
    DRM_OUTPUT_PROTECTION* rgVop;
}

struct DRM_PLAY_OPL
{
    DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS minOPL;
    DRM_OPL_OUTPUT_IDS oplIdReserved;
    DRM_VIDEO_OUTPUT_PROTECTION_IDS vopi;
}

struct DRM_COPY_OPL
{
    ushort wMinimumCopyLevel;
    DRM_OPL_OUTPUT_IDS oplIdIncludes;
    DRM_OPL_OUTPUT_IDS oplIdExcludes;
}

const GUID IID_IWMDRMReader2 = {0xBEFE7A75, 0x9F1D, 0x4075, [0xB9, 0xD9, 0xA3, 0xC3, 0x7B, 0xDA, 0x49, 0xA0]};
@GUID(0xBEFE7A75, 0x9F1D, 0x4075, [0xB9, 0xD9, 0xA3, 0xC3, 0x7B, 0xDA, 0x49, 0xA0]);
interface IWMDRMReader2 : IWMDRMReader
{
    HRESULT SetEvaluateOutputLevelLicenses(BOOL fEvaluate);
    HRESULT GetPlayOutputLevels(DRM_PLAY_OPL* pPlayOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    HRESULT GetCopyOutputLevels(DRM_COPY_OPL* pCopyOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    HRESULT TryNextLicense();
}

const GUID IID_IWMDRMReader3 = {0xE08672DE, 0xF1E7, 0x4FF4, [0xA0, 0xA3, 0xFC, 0x4B, 0x08, 0xE4, 0xCA, 0xF8]};
@GUID(0xE08672DE, 0xF1E7, 0x4FF4, [0xA0, 0xA3, 0xFC, 0x4B, 0x08, 0xE4, 0xCA, 0xF8]);
interface IWMDRMReader3 : IWMDRMReader2
{
    HRESULT GetInclusionList(Guid** ppGuids, uint* pcGuids);
}

const GUID IID_IWMReaderPlaylistBurn = {0xF28C0300, 0x9BAA, 0x4477, [0xA8, 0x46, 0x17, 0x44, 0xD9, 0xCB, 0xF5, 0x33]};
@GUID(0xF28C0300, 0x9BAA, 0x4477, [0xA8, 0x46, 0x17, 0x44, 0xD9, 0xCB, 0xF5, 0x33]);
interface IWMReaderPlaylistBurn : IUnknown
{
    HRESULT InitPlaylistBurn(uint cFiles, ushort** ppwszFilenames, IWMStatusCallback pCallback, void* pvContext);
    HRESULT GetInitResults(uint cFiles, int* phrStati);
    HRESULT Cancel();
    HRESULT EndPlaylistBurn(HRESULT hrBurnResult);
}

const GUID IID_IWMReaderNetworkConfig = {0x96406BEC, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BEC, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMReaderNetworkConfig : IUnknown
{
    HRESULT GetBufferingTime(ulong* pcnsBufferingTime);
    HRESULT SetBufferingTime(ulong cnsBufferingTime);
    HRESULT GetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint* pcRanges);
    HRESULT SetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint cRanges);
    HRESULT GetProxySettings(const(wchar)* pwszProtocol, WMT_PROXY_SETTINGS* pProxySetting);
    HRESULT SetProxySettings(const(wchar)* pwszProtocol, WMT_PROXY_SETTINGS ProxySetting);
    HRESULT GetProxyHostName(const(wchar)* pwszProtocol, ushort* pwszHostName, uint* pcchHostName);
    HRESULT SetProxyHostName(const(wchar)* pwszProtocol, const(wchar)* pwszHostName);
    HRESULT GetProxyPort(const(wchar)* pwszProtocol, uint* pdwPort);
    HRESULT SetProxyPort(const(wchar)* pwszProtocol, uint dwPort);
    HRESULT GetProxyExceptionList(const(wchar)* pwszProtocol, ushort* pwszExceptionList, uint* pcchExceptionList);
    HRESULT SetProxyExceptionList(const(wchar)* pwszProtocol, const(wchar)* pwszExceptionList);
    HRESULT GetProxyBypassForLocal(const(wchar)* pwszProtocol, int* pfBypassForLocal);
    HRESULT SetProxyBypassForLocal(const(wchar)* pwszProtocol, BOOL fBypassForLocal);
    HRESULT GetForceRerunAutoProxyDetection(int* pfForceRerunDetection);
    HRESULT SetForceRerunAutoProxyDetection(BOOL fForceRerunDetection);
    HRESULT GetEnableMulticast(int* pfEnableMulticast);
    HRESULT SetEnableMulticast(BOOL fEnableMulticast);
    HRESULT GetEnableHTTP(int* pfEnableHTTP);
    HRESULT SetEnableHTTP(BOOL fEnableHTTP);
    HRESULT GetEnableUDP(int* pfEnableUDP);
    HRESULT SetEnableUDP(BOOL fEnableUDP);
    HRESULT GetEnableTCP(int* pfEnableTCP);
    HRESULT SetEnableTCP(BOOL fEnableTCP);
    HRESULT ResetProtocolRollover();
    HRESULT GetConnectionBandwidth(uint* pdwConnectionBandwidth);
    HRESULT SetConnectionBandwidth(uint dwConnectionBandwidth);
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    HRESULT GetSupportedProtocolName(uint dwProtocolNum, ushort* pwszProtocolName, uint* pcchProtocolName);
    HRESULT AddLoggingUrl(const(wchar)* pwszUrl);
    HRESULT GetLoggingUrl(uint dwIndex, const(wchar)* pwszUrl, uint* pcchUrl);
    HRESULT GetLoggingUrlCount(uint* pdwUrlCount);
    HRESULT ResetLoggingUrlList();
}

const GUID IID_IWMReaderNetworkConfig2 = {0xD979A853, 0x042B, 0x4050, [0x83, 0x87, 0xC9, 0x39, 0xDB, 0x22, 0x01, 0x3F]};
@GUID(0xD979A853, 0x042B, 0x4050, [0x83, 0x87, 0xC9, 0x39, 0xDB, 0x22, 0x01, 0x3F]);
interface IWMReaderNetworkConfig2 : IWMReaderNetworkConfig
{
    HRESULT GetEnableContentCaching(int* pfEnableContentCaching);
    HRESULT SetEnableContentCaching(BOOL fEnableContentCaching);
    HRESULT GetEnableFastCache(int* pfEnableFastCache);
    HRESULT SetEnableFastCache(BOOL fEnableFastCache);
    HRESULT GetAcceleratedStreamingDuration(ulong* pcnsAccelDuration);
    HRESULT SetAcceleratedStreamingDuration(ulong cnsAccelDuration);
    HRESULT GetAutoReconnectLimit(uint* pdwAutoReconnectLimit);
    HRESULT SetAutoReconnectLimit(uint dwAutoReconnectLimit);
    HRESULT GetEnableResends(int* pfEnableResends);
    HRESULT SetEnableResends(BOOL fEnableResends);
    HRESULT GetEnableThinning(int* pfEnableThinning);
    HRESULT SetEnableThinning(BOOL fEnableThinning);
    HRESULT GetMaxNetPacketSize(uint* pdwMaxNetPacketSize);
}

const GUID IID_IWMReaderStreamClock = {0x96406BED, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]};
@GUID(0x96406BED, 0x2B2B, 0x11D3, [0xB3, 0x6B, 0x00, 0xC0, 0x4F, 0x61, 0x08, 0xFF]);
interface IWMReaderStreamClock : IUnknown
{
    HRESULT GetTime(ulong* pcnsNow);
    HRESULT SetTimer(ulong cnsWhen, void* pvParam, uint* pdwTimerId);
    HRESULT KillTimer(uint dwTimerId);
}

const GUID IID_IWMIndexer = {0x6D7CDC71, 0x9888, 0x11D3, [0x8E, 0xDC, 0x00, 0xC0, 0x4F, 0x61, 0x09, 0xCF]};
@GUID(0x6D7CDC71, 0x9888, 0x11D3, [0x8E, 0xDC, 0x00, 0xC0, 0x4F, 0x61, 0x09, 0xCF]);
interface IWMIndexer : IUnknown
{
    HRESULT StartIndexing(const(wchar)* pwszURL, IWMStatusCallback pCallback, void* pvContext);
    HRESULT Cancel();
}

const GUID IID_IWMIndexer2 = {0xB70F1E42, 0x6255, 0x4DF0, [0xA6, 0xB9, 0x02, 0xB2, 0x12, 0xD9, 0xE2, 0xBB]};
@GUID(0xB70F1E42, 0x6255, 0x4DF0, [0xA6, 0xB9, 0x02, 0xB2, 0x12, 0xD9, 0xE2, 0xBB]);
interface IWMIndexer2 : IWMIndexer
{
    HRESULT Configure(ushort wStreamNum, WMT_INDEXER_TYPE nIndexerType, void* pvInterval, void* pvIndexType);
}

const GUID IID_IWMLicenseBackup = {0x05E5AC9F, 0x3FB6, 0x4508, [0xBB, 0x43, 0xA4, 0x06, 0x7B, 0xA1, 0xEB, 0xE8]};
@GUID(0x05E5AC9F, 0x3FB6, 0x4508, [0xBB, 0x43, 0xA4, 0x06, 0x7B, 0xA1, 0xEB, 0xE8]);
interface IWMLicenseBackup : IUnknown
{
    HRESULT BackupLicenses(uint dwFlags, IWMStatusCallback pCallback);
    HRESULT CancelLicenseBackup();
}

const GUID IID_IWMLicenseRestore = {0xC70B6334, 0xA22E, 0x4EFB, [0xA2, 0x45, 0x15, 0xE6, 0x5A, 0x00, 0x4A, 0x13]};
@GUID(0xC70B6334, 0xA22E, 0x4EFB, [0xA2, 0x45, 0x15, 0xE6, 0x5A, 0x00, 0x4A, 0x13]);
interface IWMLicenseRestore : IUnknown
{
    HRESULT RestoreLicenses(uint dwFlags, IWMStatusCallback pCallback);
    HRESULT CancelLicenseRestore();
}

const GUID IID_IWMBackupRestoreProps = {0x3C8E0DA6, 0x996F, 0x4FF3, [0xA1, 0xAF, 0x48, 0x38, 0xF9, 0x37, 0x7E, 0x2E]};
@GUID(0x3C8E0DA6, 0x996F, 0x4FF3, [0xA1, 0xAF, 0x48, 0x38, 0xF9, 0x37, 0x7E, 0x2E]);
interface IWMBackupRestoreProps : IUnknown
{
    HRESULT GetPropCount(ushort* pcProps);
    HRESULT GetPropByIndex(ushort wIndex, ushort* pwszName, ushort* pcchNameLen, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT GetPropByName(const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT SetPropA(const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
    HRESULT RemovePropA(const(wchar)* pcwszName);
    HRESULT RemoveAllProps();
}

const GUID IID_IWMCodecInfo = {0xA970F41E, 0x34DE, 0x4A98, [0xB3, 0xBA, 0xE4, 0xB3, 0xCA, 0x75, 0x28, 0xF0]};
@GUID(0xA970F41E, 0x34DE, 0x4A98, [0xB3, 0xBA, 0xE4, 0xB3, 0xCA, 0x75, 0x28, 0xF0]);
interface IWMCodecInfo : IUnknown
{
    HRESULT GetCodecInfoCount(const(Guid)* guidType, uint* pcCodecs);
    HRESULT GetCodecFormatCount(const(Guid)* guidType, uint dwCodecIndex, uint* pcFormat);
    HRESULT GetCodecFormat(const(Guid)* guidType, uint dwCodecIndex, uint dwFormatIndex, IWMStreamConfig* ppIStreamConfig);
}

const GUID IID_IWMCodecInfo2 = {0xAA65E273, 0xB686, 0x4056, [0x91, 0xEC, 0xDD, 0x76, 0x8D, 0x4D, 0xF7, 0x10]};
@GUID(0xAA65E273, 0xB686, 0x4056, [0x91, 0xEC, 0xDD, 0x76, 0x8D, 0x4D, 0xF7, 0x10]);
interface IWMCodecInfo2 : IWMCodecInfo
{
    HRESULT GetCodecName(const(Guid)* guidType, uint dwCodecIndex, ushort* wszName, uint* pcchName);
    HRESULT GetCodecFormatDesc(const(Guid)* guidType, uint dwCodecIndex, uint dwFormatIndex, IWMStreamConfig* ppIStreamConfig, ushort* wszDesc, uint* pcchDesc);
}

const GUID IID_IWMCodecInfo3 = {0x7E51F487, 0x4D93, 0x4F98, [0x8A, 0xB4, 0x27, 0xD0, 0x56, 0x5A, 0xDC, 0x51]};
@GUID(0x7E51F487, 0x4D93, 0x4F98, [0x8A, 0xB4, 0x27, 0xD0, 0x56, 0x5A, 0xDC, 0x51]);
interface IWMCodecInfo3 : IWMCodecInfo2
{
    HRESULT GetCodecFormatProp(const(Guid)* guidType, uint dwCodecIndex, uint dwFormatIndex, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    HRESULT GetCodecProp(const(Guid)* guidType, uint dwCodecIndex, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    HRESULT SetCodecEnumerationSetting(const(Guid)* guidType, uint dwCodecIndex, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, uint dwSize);
    HRESULT GetCodecEnumerationSetting(const(Guid)* guidType, uint dwCodecIndex, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

const GUID IID_IWMLanguageList = {0xDF683F00, 0x2D49, 0x4D8E, [0x92, 0xB7, 0xFB, 0x19, 0xF6, 0xA0, 0xDC, 0x57]};
@GUID(0xDF683F00, 0x2D49, 0x4D8E, [0x92, 0xB7, 0xFB, 0x19, 0xF6, 0xA0, 0xDC, 0x57]);
interface IWMLanguageList : IUnknown
{
    HRESULT GetLanguageCount(ushort* pwCount);
    HRESULT GetLanguageDetails(ushort wIndex, ushort* pwszLanguageString, ushort* pcchLanguageStringLength);
    HRESULT AddLanguageByRFC1766String(const(wchar)* pwszLanguageString, ushort* pwIndex);
}

const GUID IID_IWMWriterPushSink = {0xDC10E6A5, 0x072C, 0x467D, [0xBF, 0x57, 0x63, 0x30, 0xA9, 0xDD, 0xE1, 0x2A]};
@GUID(0xDC10E6A5, 0x072C, 0x467D, [0xBF, 0x57, 0x63, 0x30, 0xA9, 0xDD, 0xE1, 0x2A]);
interface IWMWriterPushSink : IWMWriterSink
{
    HRESULT Connect(const(wchar)* pwszURL, const(wchar)* pwszTemplateURL, BOOL fAutoDestroy);
    HRESULT Disconnect();
    HRESULT EndSession();
}

const GUID IID_IWMDeviceRegistration = {0xF6211F03, 0x8D21, 0x4E94, [0x93, 0xE6, 0x85, 0x10, 0x80, 0x5F, 0x2D, 0x99]};
@GUID(0xF6211F03, 0x8D21, 0x4E94, [0x93, 0xE6, 0x85, 0x10, 0x80, 0x5F, 0x2D, 0x99]);
interface IWMDeviceRegistration : IUnknown
{
    HRESULT RegisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber, IWMRegisteredDevice* ppDevice);
    HRESULT UnregisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber);
    HRESULT GetRegistrationStats(uint dwRegisterType, uint* pcRegisteredDevices);
    HRESULT GetFirstRegisteredDevice(uint dwRegisterType, IWMRegisteredDevice* ppDevice);
    HRESULT GetNextRegisteredDevice(IWMRegisteredDevice* ppDevice);
    HRESULT GetRegisteredDeviceByID(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber, IWMRegisteredDevice* ppDevice);
}

const GUID IID_IWMRegisteredDevice = {0xA4503BEC, 0x5508, 0x4148, [0x97, 0xAC, 0xBF, 0xA7, 0x57, 0x60, 0xA7, 0x0D]};
@GUID(0xA4503BEC, 0x5508, 0x4148, [0x97, 0xAC, 0xBF, 0xA7, 0x57, 0x60, 0xA7, 0x0D]);
interface IWMRegisteredDevice : IUnknown
{
    HRESULT GetDeviceSerialNumber(DRM_VAL16* pSerialNumber);
    HRESULT GetDeviceCertificate(INSSBuffer* ppCertificate);
    HRESULT GetDeviceType(uint* pdwType);
    HRESULT GetAttributeCount(uint* pcAttributes);
    HRESULT GetAttributeByIndex(uint dwIndex, BSTR* pbstrName, BSTR* pbstrValue);
    HRESULT GetAttributeByName(BSTR bstrName, BSTR* pbstrValue);
    HRESULT SetAttributeByName(BSTR bstrName, BSTR bstrValue);
    HRESULT Approve(BOOL fApprove);
    HRESULT IsValid(int* pfValid);
    HRESULT IsApproved(int* pfApproved);
    HRESULT IsWmdrmCompliant(int* pfCompliant);
    HRESULT IsOpened(int* pfOpened);
    HRESULT Open();
    HRESULT Close();
}

const GUID IID_IWMProximityDetection = {0x6A9FD8EE, 0xB651, 0x4BF0, [0xB8, 0x49, 0x7D, 0x4E, 0xCE, 0x79, 0xA2, 0xB1]};
@GUID(0x6A9FD8EE, 0xB651, 0x4BF0, [0xB8, 0x49, 0x7D, 0x4E, 0xCE, 0x79, 0xA2, 0xB1]);
interface IWMProximityDetection : IUnknown
{
    HRESULT StartDetection(ubyte* pbRegistrationMsg, uint cbRegistrationMsg, ubyte* pbLocalAddress, uint cbLocalAddress, uint dwExtraPortsAllowed, INSSBuffer* ppRegistrationResponseMsg, IWMStatusCallback pCallback, void* pvContext);
}

const GUID IID_IWMDRMMessageParser = {0xA73A0072, 0x25A0, 0x4C99, [0xB4, 0xA5, 0xED, 0xE8, 0x10, 0x1A, 0x6C, 0x39]};
@GUID(0xA73A0072, 0x25A0, 0x4C99, [0xB4, 0xA5, 0xED, 0xE8, 0x10, 0x1A, 0x6C, 0x39]);
interface IWMDRMMessageParser : IUnknown
{
    HRESULT ParseRegistrationReqMsg(ubyte* pbRegistrationReqMsg, uint cbRegistrationReqMsg, INSSBuffer* ppDeviceCert, DRM_VAL16* pDeviceSerialNumber);
    HRESULT ParseLicenseRequestMsg(ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, INSSBuffer* ppDeviceCert, DRM_VAL16* pDeviceSerialNumber, BSTR* pbstrAction);
}

const GUID IID_IWMDRMTranscryptor = {0x69059850, 0x6E6F, 0x4BB2, [0x80, 0x6F, 0x71, 0x86, 0x3D, 0xDF, 0xC4, 0x71]};
@GUID(0x69059850, 0x6E6F, 0x4BB2, [0x80, 0x6F, 0x71, 0x86, 0x3D, 0xDF, 0xC4, 0x71]);
interface IWMDRMTranscryptor : IUnknown
{
    HRESULT Initialize(BSTR bstrFileName, ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, INSSBuffer* ppLicenseResponseMsg, IWMStatusCallback pCallback, void* pvContext);
    HRESULT Seek(ulong hnsTime);
    HRESULT Read(ubyte* pbData, uint* pcbData);
    HRESULT Close();
}

const GUID IID_IWMDRMTranscryptor2 = {0xE0DA439F, 0xD331, 0x496A, [0xBE, 0xCE, 0x18, 0xE5, 0xBA, 0xC5, 0xDD, 0x23]};
@GUID(0xE0DA439F, 0xD331, 0x496A, [0xBE, 0xCE, 0x18, 0xE5, 0xBA, 0xC5, 0xDD, 0x23]);
interface IWMDRMTranscryptor2 : IWMDRMTranscryptor
{
    HRESULT SeekEx(ulong cnsStartTime, ulong cnsDuration, float flRate, BOOL fIncludeFileHeader);
    HRESULT ZeroAdjustTimestamps(BOOL fEnable);
    HRESULT GetSeekStartTime(ulong* pcnsTime);
    HRESULT GetDuration(ulong* pcnsDuration);
}

const GUID IID_IWMDRMTranscryptionManager = {0xB1A887B2, 0xA4F0, 0x407A, [0xB0, 0x2E, 0xEF, 0xBD, 0x23, 0xBB, 0xEC, 0xDF]};
@GUID(0xB1A887B2, 0xA4F0, 0x407A, [0xB0, 0x2E, 0xEF, 0xBD, 0x23, 0xBB, 0xEC, 0xDF]);
interface IWMDRMTranscryptionManager : IUnknown
{
    HRESULT CreateTranscryptor(IWMDRMTranscryptor* ppTranscryptor);
}

const GUID IID_IWMWatermarkInfo = {0x6F497062, 0xF2E2, 0x4624, [0x8E, 0xA7, 0x9D, 0xD4, 0x0D, 0x81, 0xFC, 0x8D]};
@GUID(0x6F497062, 0xF2E2, 0x4624, [0x8E, 0xA7, 0x9D, 0xD4, 0x0D, 0x81, 0xFC, 0x8D]);
interface IWMWatermarkInfo : IUnknown
{
    HRESULT GetWatermarkEntryCount(WMT_WATERMARK_ENTRY_TYPE wmetType, uint* pdwCount);
    HRESULT GetWatermarkEntry(WMT_WATERMARK_ENTRY_TYPE wmetType, uint dwEntryNum, WMT_WATERMARK_ENTRY* pEntry);
}

const GUID IID_IWMReaderAccelerator = {0xBDDC4D08, 0x944D, 0x4D52, [0xA6, 0x12, 0x46, 0xC3, 0xFD, 0xA0, 0x7D, 0xD4]};
@GUID(0xBDDC4D08, 0x944D, 0x4D52, [0xA6, 0x12, 0x46, 0xC3, 0xFD, 0xA0, 0x7D, 0xD4]);
interface IWMReaderAccelerator : IUnknown
{
    HRESULT GetCodecInterface(uint dwOutputNum, const(Guid)* riid, void** ppvCodecInterface);
    HRESULT Notify(uint dwOutputNum, WM_MEDIA_TYPE* pSubtype);
}

const GUID IID_IWMReaderTimecode = {0xF369E2F0, 0xE081, 0x4FE6, [0x84, 0x50, 0xB8, 0x10, 0xB2, 0xF4, 0x10, 0xD1]};
@GUID(0xF369E2F0, 0xE081, 0x4FE6, [0x84, 0x50, 0xB8, 0x10, 0xB2, 0xF4, 0x10, 0xD1]);
interface IWMReaderTimecode : IUnknown
{
    HRESULT GetTimecodeRangeCount(ushort wStreamNum, ushort* pwRangeCount);
    HRESULT GetTimecodeRangeBounds(ushort wStreamNum, ushort wRangeNum, uint* pStartTimecode, uint* pEndTimecode);
}

const GUID IID_IWMAddressAccess = {0xBB3C6389, 0x1633, 0x4E92, [0xAF, 0x14, 0x9F, 0x31, 0x73, 0xBA, 0x39, 0xD0]};
@GUID(0xBB3C6389, 0x1633, 0x4E92, [0xAF, 0x14, 0x9F, 0x31, 0x73, 0xBA, 0x39, 0xD0]);
interface IWMAddressAccess : IUnknown
{
    HRESULT GetAccessEntryCount(WM_AETYPE aeType, uint* pcEntries);
    HRESULT GetAccessEntry(WM_AETYPE aeType, uint dwEntryNum, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    HRESULT AddAccessEntry(WM_AETYPE aeType, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    HRESULT RemoveAccessEntry(WM_AETYPE aeType, uint dwEntryNum);
}

const GUID IID_IWMAddressAccess2 = {0x65A83FC2, 0x3E98, 0x4D4D, [0x81, 0xB5, 0x2A, 0x74, 0x28, 0x86, 0xB3, 0x3D]};
@GUID(0x65A83FC2, 0x3E98, 0x4D4D, [0x81, 0xB5, 0x2A, 0x74, 0x28, 0x86, 0xB3, 0x3D]);
interface IWMAddressAccess2 : IWMAddressAccess
{
    HRESULT GetAccessEntryEx(WM_AETYPE aeType, uint dwEntryNum, BSTR* pbstrAddress, BSTR* pbstrMask);
    HRESULT AddAccessEntryEx(WM_AETYPE aeType, BSTR bstrAddress, BSTR bstrMask);
}

const GUID IID_IWMImageInfo = {0x9F0AA3B6, 0x7267, 0x4D89, [0x88, 0xF2, 0xBA, 0x91, 0x5A, 0xA5, 0xC4, 0xC6]};
@GUID(0x9F0AA3B6, 0x7267, 0x4D89, [0x88, 0xF2, 0xBA, 0x91, 0x5A, 0xA5, 0xC4, 0xC6]);
interface IWMImageInfo : IUnknown
{
    HRESULT GetImageCount(uint* pcImages);
    HRESULT GetImage(uint wIndex, ushort* pcchMIMEType, ushort* pwszMIMEType, ushort* pcchDescription, ushort* pwszDescription, ushort* pImageType, uint* pcbImageData, ubyte* pbImageData);
}

const GUID IID_IWMLicenseRevocationAgent = {0x6967F2C9, 0x4E26, 0x4B57, [0x88, 0x94, 0x79, 0x98, 0x80, 0xF7, 0xAC, 0x7B]};
@GUID(0x6967F2C9, 0x4E26, 0x4B57, [0x88, 0x94, 0x79, 0x98, 0x80, 0xF7, 0xAC, 0x7B]);
interface IWMLicenseRevocationAgent : IUnknown
{
    HRESULT GetLRBChallenge(ubyte* pMachineID, uint dwMachineIDLength, ubyte* pChallenge, uint dwChallengeLength, ubyte* pChallengeOutput, uint* pdwChallengeOutputLength);
    HRESULT ProcessLRB(ubyte* pSignedLRB, uint dwSignedLRBLength, ubyte* pSignedACK, uint* pdwSignedACKLength);
}

const GUID IID_IWMAuthorizer = {0xD9B67D36, 0xA9AD, 0x4EB4, [0xBA, 0xEF, 0xDB, 0x28, 0x4E, 0xF5, 0x50, 0x4C]};
@GUID(0xD9B67D36, 0xA9AD, 0x4EB4, [0xBA, 0xEF, 0xDB, 0x28, 0x4E, 0xF5, 0x50, 0x4C]);
interface IWMAuthorizer : IUnknown
{
    HRESULT GetCertCount(uint* pcCerts);
    HRESULT GetCert(uint dwIndex, ubyte** ppbCertData);
    HRESULT GetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData, ubyte* pbCert, ubyte** ppbSharedData);
}

const GUID IID_IWMSecureChannel = {0x2720598A, 0xD0F2, 0x4189, [0xBD, 0x10, 0x91, 0xC4, 0x6E, 0xF0, 0x93, 0x6F]};
@GUID(0x2720598A, 0xD0F2, 0x4189, [0xBD, 0x10, 0x91, 0xC4, 0x6E, 0xF0, 0x93, 0x6F]);
interface IWMSecureChannel : IWMAuthorizer
{
    HRESULT WMSC_AddCertificate(IWMAuthorizer pCert);
    HRESULT WMSC_AddSignature(ubyte* pbCertSig, uint cbCertSig);
    HRESULT WMSC_Connect(IWMSecureChannel pOtherSide);
    HRESULT WMSC_IsConnected(int* pfIsConnected);
    HRESULT WMSC_Disconnect();
    HRESULT WMSC_GetValidCertificate(ubyte** ppbCertificate, uint* pdwSignature);
    HRESULT WMSC_Encrypt(ubyte* pbData, uint cbData);
    HRESULT WMSC_Decrypt(ubyte* pbData, uint cbData);
    HRESULT WMSC_Lock();
    HRESULT WMSC_Unlock();
    HRESULT WMSC_SetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData);
}

const GUID IID_IWMGetSecureChannel = {0x94BC0598, 0xC3D2, 0x11D3, [0xBE, 0xDF, 0x00, 0xC0, 0x4F, 0x61, 0x29, 0x86]};
@GUID(0x94BC0598, 0xC3D2, 0x11D3, [0xBE, 0xDF, 0x00, 0xC0, 0x4F, 0x61, 0x29, 0x86]);
interface IWMGetSecureChannel : IUnknown
{
    HRESULT GetPeerSecureChannelInterface(IWMSecureChannel* ppPeer);
}

const GUID IID_INSNetSourceCreator = {0x0C0E4080, 0x9081, 0x11D2, [0xBE, 0xEC, 0x00, 0x60, 0x08, 0x2F, 0x20, 0x54]};
@GUID(0x0C0E4080, 0x9081, 0x11D2, [0xBE, 0xEC, 0x00, 0x60, 0x08, 0x2F, 0x20, 0x54]);
interface INSNetSourceCreator : IUnknown
{
    HRESULT Initialize();
    HRESULT CreateNetSource(const(wchar)* pszStreamName, IUnknown pMonitor, ubyte* pData, IUnknown pUserContext, IUnknown pCallback, ulong qwContext);
    HRESULT GetNetSourceProperties(const(wchar)* pszStreamName, IUnknown* ppPropertiesNode);
    HRESULT GetNetSourceSharedNamespace(IUnknown* ppSharedNamespace);
    HRESULT GetNetSourceAdminInterface(const(wchar)* pszStreamName, VARIANT* pVal);
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    HRESULT GetProtocolName(uint dwProtocolNum, ushort* pwszProtocolName, ushort* pcchProtocolName);
    HRESULT Shutdown();
}

const GUID IID_IWMPlayerTimestampHook = {0x28580DDA, 0xD98E, 0x48D0, [0xB7, 0xAE, 0x69, 0xE4, 0x73, 0xA0, 0x28, 0x25]};
@GUID(0x28580DDA, 0xD98E, 0x48D0, [0xB7, 0xAE, 0x69, 0xE4, 0x73, 0xA0, 0x28, 0x25]);
interface IWMPlayerTimestampHook : IUnknown
{
    HRESULT MapTimestamp(long rtIn, long* prtOut);
}

const GUID IID_IWMCodecAMVideoAccelerator = {0xD98EE251, 0x34E0, 0x4A2D, [0x93, 0x12, 0x9B, 0x4C, 0x78, 0x8D, 0x9F, 0xA1]};
@GUID(0xD98EE251, 0x34E0, 0x4A2D, [0x93, 0x12, 0x9B, 0x4C, 0x78, 0x8D, 0x9F, 0xA1]);
interface IWMCodecAMVideoAccelerator : IUnknown
{
    HRESULT SetAcceleratorInterface(IAMVideoAccelerator pIAMVA);
    HRESULT NegotiateConnection(AM_MEDIA_TYPE* pMediaType);
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}

const GUID IID_IWMCodecVideoAccelerator = {0x990641B0, 0x739F, 0x4E94, [0xA8, 0x08, 0x98, 0x88, 0xDA, 0x8F, 0x75, 0xAF]};
@GUID(0x990641B0, 0x739F, 0x4E94, [0xA8, 0x08, 0x98, 0x88, 0xDA, 0x8F, 0x75, 0xAF]);
interface IWMCodecVideoAccelerator : IUnknown
{
    HRESULT NegotiateConnection(IAMVideoAccelerator pIAMVA, AM_MEDIA_TYPE* pMediaType);
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}

enum NETSOURCE_URLCREDPOLICY_SETTINGS
{
    NETSOURCE_URLCREDPOLICY_SETTING_SILENTLOGONOK = 0,
    NETSOURCE_URLCREDPOLICY_SETTING_MUSTPROMPTUSER = 1,
    NETSOURCE_URLCREDPOLICY_SETTING_ANONYMOUSONLY = 2,
}

const GUID IID_IWMSInternalAdminNetSource = {0x8BB23E5F, 0xD127, 0x4AFB, [0x8D, 0x02, 0xAE, 0x5B, 0x66, 0xD5, 0x4C, 0x78]};
@GUID(0x8BB23E5F, 0xD127, 0x4AFB, [0x8D, 0x02, 0xAE, 0x5B, 0x66, 0xD5, 0x4C, 0x78]);
interface IWMSInternalAdminNetSource : IUnknown
{
    HRESULT Initialize(IUnknown pSharedNamespace, IUnknown pNamespaceNode, INSNetSourceCreator pNetSourceCreator, BOOL fEmbeddedInServer);
    HRESULT GetNetSourceCreator(INSNetSourceCreator* ppNetSourceCreator);
    HRESULT SetCredentials(BSTR bstrRealm, BSTR bstrName, BSTR bstrPassword, BOOL fPersist, BOOL fConfirmedGood);
    HRESULT GetCredentials(BSTR bstrRealm, BSTR* pbstrName, BSTR* pbstrPassword, int* pfConfirmedGood);
    HRESULT DeleteCredentials(BSTR bstrRealm);
    HRESULT GetCredentialFlags(uint* lpdwFlags);
    HRESULT SetCredentialFlags(uint dwFlags);
    HRESULT FindProxyForURL(BSTR bstrProtocol, BSTR bstrHost, int* pfProxyEnabled, BSTR* pbstrProxyServer, uint* pdwProxyPort, uint* pdwProxyContext);
    HRESULT RegisterProxyFailure(HRESULT hrParam, uint dwProxyContext);
    HRESULT ShutdownProxyContext(uint dwProxyContext);
    HRESULT IsUsingIE(uint dwProxyContext, int* pfIsUsingIE);
}

const GUID IID_IWMSInternalAdminNetSource2 = {0xE74D58C3, 0xCF77, 0x4B51, [0xAF, 0x17, 0x74, 0x46, 0x87, 0xC4, 0x3E, 0xAE]};
@GUID(0xE74D58C3, 0xCF77, 0x4B51, [0xAF, 0x17, 0x74, 0x46, 0x87, 0xC4, 0x3E, 0xAE]);
interface IWMSInternalAdminNetSource2 : IUnknown
{
    HRESULT SetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, BOOL fPersist, BOOL fConfirmedGood);
    HRESULT GetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, int* pfConfirmedGood);
    HRESULT DeleteCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy);
    HRESULT FindProxyForURLEx(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, int* pfProxyEnabled, BSTR* pbstrProxyServer, uint* pdwProxyPort, uint* pdwProxyContext);
}

const GUID IID_IWMSInternalAdminNetSource3 = {0x6B63D08E, 0x4590, 0x44AF, [0x9E, 0xB3, 0x57, 0xFF, 0x1E, 0x73, 0xBF, 0x80]};
@GUID(0x6B63D08E, 0x4590, 0x44AF, [0x9E, 0xB3, 0x57, 0xFF, 0x1E, 0x73, 0xBF, 0x80]);
interface IWMSInternalAdminNetSource3 : IWMSInternalAdminNetSource2
{
    HRESULT GetNetSourceCreator2(IUnknown* ppNetSourceCreator);
    HRESULT FindProxyForURLEx2(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, int* pfProxyEnabled, BSTR* pbstrProxyServer, uint* pdwProxyPort, ulong* pqwProxyContext);
    HRESULT RegisterProxyFailure2(HRESULT hrParam, ulong qwProxyContext);
    HRESULT ShutdownProxyContext2(ulong qwProxyContext);
    HRESULT IsUsingIE2(ulong qwProxyContext, int* pfIsUsingIE);
    HRESULT SetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, BOOL fPersist, BOOL fConfirmedGood, BOOL fClearTextAuthentication);
    HRESULT GetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BOOL fClearTextAuthentication, NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, int* pfConfirmedGood);
}

@DllImport("WMVCore.dll")
HRESULT WMIsContentProtected(const(wchar)* pwszFileName, int* pfIsProtected);

@DllImport("WMVCore.dll")
HRESULT WMCreateWriter(IUnknown pUnkCert, IWMWriter* ppWriter);

@DllImport("WMVCore.dll")
HRESULT WMCreateReader(IUnknown pUnkCert, uint dwRights, IWMReader* ppReader);

@DllImport("WMVCore.dll")
HRESULT WMCreateSyncReader(IUnknown pUnkCert, uint dwRights, IWMSyncReader* ppSyncReader);

@DllImport("WMVCore.dll")
HRESULT WMCreateEditor(IWMMetadataEditor* ppEditor);

@DllImport("WMVCore.dll")
HRESULT WMCreateIndexer(IWMIndexer* ppIndexer);

@DllImport("WMVCore.dll")
HRESULT WMCreateBackupRestorer(IUnknown pCallback, IWMLicenseBackup* ppBackup);

@DllImport("WMVCore.dll")
HRESULT WMCreateProfileManager(IWMProfileManager* ppProfileManager);

@DllImport("WMVCore.dll")
HRESULT WMCreateWriterFileSink(IWMWriterFileSink* ppSink);

@DllImport("WMVCore.dll")
HRESULT WMCreateWriterNetworkSink(IWMWriterNetworkSink* ppSink);

@DllImport("WMVCore.dll")
HRESULT WMCreateWriterPushSink(IWMWriterPushSink* ppSink);

