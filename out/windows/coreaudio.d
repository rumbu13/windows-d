module windows.coreaudio;

public import system;
public import windows.audio;
public import windows.com;
public import windows.directshow;
public import windows.displaydevices;
public import windows.gdi;
public import windows.kernel;
public import windows.multimedia;
public import windows.remotedesktopservices;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowspropertiessystem;

extern(Windows):

alias YIELDPROC = extern(Windows) uint function(uint mciId, uint dwYieldData);
struct MCI_GENERIC_PARMS
{
    uint dwCallback;
}

struct MCI_OPEN_PARMSA
{
    uint dwCallback;
    uint wDeviceID;
    const(char)* lpstrDeviceType;
    const(char)* lpstrElementName;
    const(char)* lpstrAlias;
}

struct MCI_OPEN_PARMSW
{
    uint dwCallback;
    uint wDeviceID;
    const(wchar)* lpstrDeviceType;
    const(wchar)* lpstrElementName;
    const(wchar)* lpstrAlias;
}

struct MCI_PLAY_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
}

struct MCI_SEEK_PARMS
{
    uint dwCallback;
    uint dwTo;
}

struct MCI_STATUS_PARMS
{
    uint dwCallback;
    uint dwReturn;
    uint dwItem;
    uint dwTrack;
}

struct MCI_INFO_PARMSA
{
    uint dwCallback;
    const(char)* lpstrReturn;
    uint dwRetSize;
}

struct MCI_INFO_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrReturn;
    uint dwRetSize;
}

struct MCI_GETDEVCAPS_PARMS
{
    uint dwCallback;
    uint dwReturn;
    uint dwItem;
}

struct MCI_SYSINFO_PARMSA
{
    uint dwCallback;
    const(char)* lpstrReturn;
    uint dwRetSize;
    uint dwNumber;
    uint wDeviceType;
}

struct MCI_SYSINFO_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrReturn;
    uint dwRetSize;
    uint dwNumber;
    uint wDeviceType;
}

struct MCI_SET_PARMS
{
    uint dwCallback;
    uint dwTimeFormat;
    uint dwAudio;
}

struct MCI_BREAK_PARMS
{
    uint dwCallback;
    int nVirtKey;
    HWND hwndBreak;
}

struct MCI_SAVE_PARMSA
{
    uint dwCallback;
    const(char)* lpfilename;
}

struct MCI_SAVE_PARMSW
{
    uint dwCallback;
    const(wchar)* lpfilename;
}

struct MCI_LOAD_PARMSA
{
    uint dwCallback;
    const(char)* lpfilename;
}

struct MCI_LOAD_PARMSW
{
    uint dwCallback;
    const(wchar)* lpfilename;
}

struct MCI_RECORD_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
}

struct MCI_VD_PLAY_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
    uint dwSpeed;
}

struct MCI_VD_STEP_PARMS
{
    uint dwCallback;
    uint dwFrames;
}

struct MCI_VD_ESCAPE_PARMSA
{
    uint dwCallback;
    const(char)* lpstrCommand;
}

struct MCI_VD_ESCAPE_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrCommand;
}

struct MCI_WAVE_OPEN_PARMSA
{
    uint dwCallback;
    uint wDeviceID;
    const(char)* lpstrDeviceType;
    const(char)* lpstrElementName;
    const(char)* lpstrAlias;
    uint dwBufferSeconds;
}

struct MCI_WAVE_OPEN_PARMSW
{
    uint dwCallback;
    uint wDeviceID;
    const(wchar)* lpstrDeviceType;
    const(wchar)* lpstrElementName;
    const(wchar)* lpstrAlias;
    uint dwBufferSeconds;
}

struct MCI_WAVE_DELETE_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
}

struct MCI_WAVE_SET_PARMS
{
    uint dwCallback;
    uint dwTimeFormat;
    uint dwAudio;
    uint wInput;
    uint wOutput;
    ushort wFormatTag;
    ushort wReserved2;
    ushort nChannels;
    ushort wReserved3;
    uint nSamplesPerSec;
    uint nAvgBytesPerSec;
    ushort nBlockAlign;
    ushort wReserved4;
    ushort wBitsPerSample;
    ushort wReserved5;
}

struct MCI_SEQ_SET_PARMS
{
    uint dwCallback;
    uint dwTimeFormat;
    uint dwAudio;
    uint dwTempo;
    uint dwPort;
    uint dwSlave;
    uint dwMaster;
    uint dwOffset;
}

struct MCI_ANIM_OPEN_PARMSA
{
    uint dwCallback;
    uint wDeviceID;
    const(char)* lpstrDeviceType;
    const(char)* lpstrElementName;
    const(char)* lpstrAlias;
    uint dwStyle;
    HWND hWndParent;
}

struct MCI_ANIM_OPEN_PARMSW
{
    uint dwCallback;
    uint wDeviceID;
    const(wchar)* lpstrDeviceType;
    const(wchar)* lpstrElementName;
    const(wchar)* lpstrAlias;
    uint dwStyle;
    HWND hWndParent;
}

struct MCI_ANIM_PLAY_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
    uint dwSpeed;
}

struct MCI_ANIM_STEP_PARMS
{
    uint dwCallback;
    uint dwFrames;
}

struct MCI_ANIM_WINDOW_PARMSA
{
    uint dwCallback;
    HWND hWnd;
    uint nCmdShow;
    const(char)* lpstrText;
}

struct MCI_ANIM_WINDOW_PARMSW
{
    uint dwCallback;
    HWND hWnd;
    uint nCmdShow;
    const(wchar)* lpstrText;
}

struct MCI_ANIM_RECT_PARMS
{
    uint dwCallback;
    RECT rc;
}

struct MCI_ANIM_UPDATE_PARMS
{
    uint dwCallback;
    RECT rc;
    HDC hDC;
}

struct MCI_OVLY_OPEN_PARMSA
{
    uint dwCallback;
    uint wDeviceID;
    const(char)* lpstrDeviceType;
    const(char)* lpstrElementName;
    const(char)* lpstrAlias;
    uint dwStyle;
    HWND hWndParent;
}

struct MCI_OVLY_OPEN_PARMSW
{
    uint dwCallback;
    uint wDeviceID;
    const(wchar)* lpstrDeviceType;
    const(wchar)* lpstrElementName;
    const(wchar)* lpstrAlias;
    uint dwStyle;
    HWND hWndParent;
}

struct MCI_OVLY_WINDOW_PARMSA
{
    uint dwCallback;
    HWND hWnd;
    uint nCmdShow;
    const(char)* lpstrText;
}

struct MCI_OVLY_WINDOW_PARMSW
{
    uint dwCallback;
    HWND hWnd;
    uint nCmdShow;
    const(wchar)* lpstrText;
}

struct MCI_OVLY_RECT_PARMS
{
    uint dwCallback;
    RECT rc;
}

struct MCI_OVLY_SAVE_PARMSA
{
    uint dwCallback;
    const(char)* lpfilename;
    RECT rc;
}

struct MCI_OVLY_SAVE_PARMSW
{
    uint dwCallback;
    const(wchar)* lpfilename;
    RECT rc;
}

struct MCI_OVLY_LOAD_PARMSA
{
    uint dwCallback;
    const(char)* lpfilename;
    RECT rc;
}

struct MCI_OVLY_LOAD_PARMSW
{
    uint dwCallback;
    const(wchar)* lpfilename;
    RECT rc;
}

enum AUDCLNT_SHAREMODE
{
    AUDCLNT_SHAREMODE_SHARED = 0,
    AUDCLNT_SHAREMODE_EXCLUSIVE = 1,
}

enum AUDIO_STREAM_CATEGORY
{
    AudioCategory_Other = 0,
    AudioCategory_ForegroundOnlyMedia = 1,
    AudioCategory_Communications = 3,
    AudioCategory_Alerts = 4,
    AudioCategory_SoundEffects = 5,
    AudioCategory_GameEffects = 6,
    AudioCategory_GameMedia = 7,
    AudioCategory_GameChat = 8,
    AudioCategory_Speech = 9,
    AudioCategory_Movie = 10,
    AudioCategory_Media = 11,
}

enum AudioSessionState
{
    AudioSessionStateInactive = 0,
    AudioSessionStateActive = 1,
    AudioSessionStateExpired = 2,
}

const GUID CLSID_GUID_NULL = {0x00000000, 0x0000, 0x0000, [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]};
@GUID(0x00000000, 0x0000, 0x0000, [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]);
struct GUID_NULL;

enum KSRESET
{
    KSRESET_BEGIN = 0,
    KSRESET_END = 1,
}

enum KSSTATE
{
    KSSTATE_STOP = 0,
    KSSTATE_ACQUIRE = 1,
    KSSTATE_PAUSE = 2,
    KSSTATE_RUN = 3,
}

struct KSPRIORITY
{
    uint PriorityClass;
    uint PrioritySubClass;
}

struct KSIDENTIFIER
{
    _Anonymous_e__Union Anonymous;
}

struct KSP_NODE
{
    KSIDENTIFIER Property;
    uint NodeId;
    uint Reserved;
}

struct KSM_NODE
{
    KSIDENTIFIER Method;
    uint NodeId;
    uint Reserved;
}

struct KSE_NODE
{
    KSIDENTIFIER Event;
    uint NodeId;
    uint Reserved;
}

const GUID CLSID_KSPROPTYPESETID_General = {0x97E99BA0, 0xBDEA, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x97E99BA0, 0xBDEA, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSPROPTYPESETID_General;

struct KSMULTIPLE_ITEM
{
    uint Size;
    uint Count;
}

struct KSPROPERTY_DESCRIPTION
{
    uint AccessFlags;
    uint DescriptionSize;
    KSIDENTIFIER PropTypeSet;
    uint MembersListCount;
    uint Reserved;
}

struct KSPROPERTY_MEMBERSHEADER
{
    uint MembersFlags;
    uint MembersSize;
    uint MembersCount;
    uint Flags;
}

struct KSPROPERTY_BOUNDS_LONG
{
    _Anonymous1_e__Struct Anonymous1;
    _Anonymous2_e__Struct Anonymous2;
}

struct KSPROPERTY_BOUNDS_LONGLONG
{
    _Anonymous1_e__Struct Anonymous1;
    _Anonymous2_e__Struct Anonymous2;
}

struct KSPROPERTY_STEPPING_LONG
{
    uint SteppingDelta;
    uint Reserved;
    KSPROPERTY_BOUNDS_LONG Bounds;
}

struct KSPROPERTY_STEPPING_LONGLONG
{
    ulong SteppingDelta;
    KSPROPERTY_BOUNDS_LONGLONG Bounds;
}

struct KSEVENTDATA
{
    uint NotificationType;
    _Anonymous_e__Union Anonymous;
}

struct KSQUERYBUFFER
{
    KSIDENTIFIER Event;
    KSEVENTDATA* EventData;
    void* Reserved;
}

struct KSRELATIVEEVENT
{
    uint Size;
    uint Flags;
    _Anonymous_e__Union Anonymous;
    void* Reserved;
    KSIDENTIFIER Event;
    KSEVENTDATA EventData;
}

struct KSEVENT_TIME_MARK
{
    KSEVENTDATA EventData;
    long MarkTime;
}

struct KSEVENT_TIME_INTERVAL
{
    KSEVENTDATA EventData;
    long TimeBase;
    long Interval;
}

struct KSINTERVAL
{
    long TimeBase;
    long Interval;
}

const GUID CLSID_KSPROPSETID_General = {0x1464EDA5, 0x6A8F, 0x11D1, [0x9A, 0xA7, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x1464EDA5, 0x6A8F, 0x11D1, [0x9A, 0xA7, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSPROPSETID_General;

enum KSPROPERTY_GENERAL
{
    KSPROPERTY_GENERAL_COMPONENTID = 0,
}

struct KSCOMPONENTID
{
    Guid Manufacturer;
    Guid Product;
    Guid Component;
    Guid Name;
    uint Version;
    uint Revision;
}

const GUID CLSID_KSMETHODSETID_StreamIo = {0x65D003CA, 0x1523, 0x11D2, [0xB2, 0x7A, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x65D003CA, 0x1523, 0x11D2, [0xB2, 0x7A, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSMETHODSETID_StreamIo;

enum KSMETHOD_STREAMIO
{
    KSMETHOD_STREAMIO_READ = 0,
    KSMETHOD_STREAMIO_WRITE = 1,
}

const GUID CLSID_KSPROPSETID_MediaSeeking = {0xEE904F0C, 0xD09B, 0x11D0, [0xAB, 0xE9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xEE904F0C, 0xD09B, 0x11D0, [0xAB, 0xE9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSPROPSETID_MediaSeeking;

enum KSPROPERTY_MEDIASEEKING
{
    KSPROPERTY_MEDIASEEKING_CAPABILITIES = 0,
    KSPROPERTY_MEDIASEEKING_FORMATS = 1,
    KSPROPERTY_MEDIASEEKING_TIMEFORMAT = 2,
    KSPROPERTY_MEDIASEEKING_POSITION = 3,
    KSPROPERTY_MEDIASEEKING_STOPPOSITION = 4,
    KSPROPERTY_MEDIASEEKING_POSITIONS = 5,
    KSPROPERTY_MEDIASEEKING_DURATION = 6,
    KSPROPERTY_MEDIASEEKING_AVAILABLE = 7,
    KSPROPERTY_MEDIASEEKING_PREROLL = 8,
    KSPROPERTY_MEDIASEEKING_CONVERTTIMEFORMAT = 9,
}

enum KS_SEEKING_FLAGS
{
    KS_SEEKING_NoPositioning = 0,
    KS_SEEKING_AbsolutePositioning = 1,
    KS_SEEKING_RelativePositioning = 2,
    KS_SEEKING_IncrementalPositioning = 3,
    KS_SEEKING_PositioningBitsMask = 3,
    KS_SEEKING_SeekToKeyFrame = 4,
    KS_SEEKING_ReturnTime = 8,
}

enum KS_SEEKING_CAPABILITIES
{
    KS_SEEKING_CanSeekAbsolute = 1,
    KS_SEEKING_CanSeekForwards = 2,
    KS_SEEKING_CanSeekBackwards = 4,
    KS_SEEKING_CanGetCurrentPos = 8,
    KS_SEEKING_CanGetStopPos = 16,
    KS_SEEKING_CanGetDuration = 32,
    KS_SEEKING_CanPlayBackwards = 64,
}

struct KSPROPERTY_POSITIONS
{
    long Current;
    long Stop;
    KS_SEEKING_FLAGS CurrentFlags;
    KS_SEEKING_FLAGS StopFlags;
}

struct KSPROPERTY_MEDIAAVAILABLE
{
    long Earliest;
    long Latest;
}

struct KSP_TIMEFORMAT
{
    KSIDENTIFIER Property;
    Guid SourceFormat;
    Guid TargetFormat;
    long Time;
}

const GUID CLSID_KSPROPSETID_Topology = {0x720D4AC0, 0x7533, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x720D4AC0, 0x7533, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSPROPSETID_Topology;

enum KSPROPERTY_TOPOLOGY
{
    KSPROPERTY_TOPOLOGY_CATEGORIES = 0,
    KSPROPERTY_TOPOLOGY_NODES = 1,
    KSPROPERTY_TOPOLOGY_CONNECTIONS = 2,
    KSPROPERTY_TOPOLOGY_NAME = 3,
}

const GUID CLSID_KSCATEGORY_BRIDGE = {0x085AFF00, 0x62CE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x085AFF00, 0x62CE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_BRIDGE;

const GUID CLSID_KSCATEGORY_CAPTURE = {0x65E8773D, 0x8F56, 0x11D0, [0xA3, 0xB9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x65E8773D, 0x8F56, 0x11D0, [0xA3, 0xB9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_CAPTURE;

const GUID CLSID_KSCATEGORY_VIDEO_CAMERA = {0xE5323777, 0xF976, 0x4F5B, [0x9B, 0x55, 0xB9, 0x46, 0x99, 0xC4, 0x6E, 0x44]};
@GUID(0xE5323777, 0xF976, 0x4F5B, [0x9B, 0x55, 0xB9, 0x46, 0x99, 0xC4, 0x6E, 0x44]);
struct KSCATEGORY_VIDEO_CAMERA;

const GUID CLSID_KSCATEGORY_SENSOR_CAMERA = {0x24E552D7, 0x6523, 0x47F7, [0xA6, 0x47, 0xD3, 0x46, 0x5B, 0xF1, 0xF5, 0xCA]};
@GUID(0x24E552D7, 0x6523, 0x47F7, [0xA6, 0x47, 0xD3, 0x46, 0x5B, 0xF1, 0xF5, 0xCA]);
struct KSCATEGORY_SENSOR_CAMERA;

const GUID CLSID_KSCATEGORY_NETWORK_CAMERA = {0xB8238652, 0xB500, 0x41EB, [0xB4, 0xF3, 0x42, 0x34, 0xF7, 0xF5, 0xAE, 0x99]};
@GUID(0xB8238652, 0xB500, 0x41EB, [0xB4, 0xF3, 0x42, 0x34, 0xF7, 0xF5, 0xAE, 0x99]);
struct KSCATEGORY_NETWORK_CAMERA;

const GUID CLSID_KSCATEGORY_SENSOR_GROUP = {0x669C7214, 0x0A88, 0x4311, [0xA7, 0xF3, 0x4E, 0x79, 0x82, 0x0E, 0x33, 0xBD]};
@GUID(0x669C7214, 0x0A88, 0x4311, [0xA7, 0xF3, 0x4E, 0x79, 0x82, 0x0E, 0x33, 0xBD]);
struct KSCATEGORY_SENSOR_GROUP;

const GUID CLSID_KSCATEGORY_RENDER = {0x65E8773E, 0x8F56, 0x11D0, [0xA3, 0xB9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x65E8773E, 0x8F56, 0x11D0, [0xA3, 0xB9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_RENDER;

const GUID CLSID_KSCATEGORY_MIXER = {0xAD809C00, 0x7B88, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0xAD809C00, 0x7B88, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_MIXER;

const GUID CLSID_KSCATEGORY_SPLITTER = {0x0A4252A0, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x0A4252A0, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_SPLITTER;

const GUID CLSID_KSCATEGORY_DATACOMPRESSOR = {0x1E84C900, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x1E84C900, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_DATACOMPRESSOR;

const GUID CLSID_KSCATEGORY_DATADECOMPRESSOR = {0x2721AE20, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x2721AE20, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_DATADECOMPRESSOR;

const GUID CLSID_KSCATEGORY_DATATRANSFORM = {0x2EB07EA0, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x2EB07EA0, 0x7E70, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_DATATRANSFORM;

const GUID CLSID_KSMFT_CATEGORY_VIDEO_DECODER = {0xD6C02D4B, 0x6833, 0x45B4, [0x97, 0x1A, 0x05, 0xA4, 0xB0, 0x4B, 0xAB, 0x91]};
@GUID(0xD6C02D4B, 0x6833, 0x45B4, [0x97, 0x1A, 0x05, 0xA4, 0xB0, 0x4B, 0xAB, 0x91]);
struct KSMFT_CATEGORY_VIDEO_DECODER;

const GUID CLSID_KSMFT_CATEGORY_VIDEO_ENCODER = {0xF79EAC7D, 0xE545, 0x4387, [0xBD, 0xEE, 0xD6, 0x47, 0xD7, 0xBD, 0xE4, 0x2A]};
@GUID(0xF79EAC7D, 0xE545, 0x4387, [0xBD, 0xEE, 0xD6, 0x47, 0xD7, 0xBD, 0xE4, 0x2A]);
struct KSMFT_CATEGORY_VIDEO_ENCODER;

const GUID CLSID_KSMFT_CATEGORY_VIDEO_EFFECT = {0x12E17C21, 0x532C, 0x4A6E, [0x8A, 0x1C, 0x40, 0x82, 0x5A, 0x73, 0x63, 0x97]};
@GUID(0x12E17C21, 0x532C, 0x4A6E, [0x8A, 0x1C, 0x40, 0x82, 0x5A, 0x73, 0x63, 0x97]);
struct KSMFT_CATEGORY_VIDEO_EFFECT;

const GUID CLSID_KSMFT_CATEGORY_MULTIPLEXER = {0x059C561E, 0x05AE, 0x4B61, [0xB6, 0x9D, 0x55, 0xB6, 0x1E, 0xE5, 0x4A, 0x7B]};
@GUID(0x059C561E, 0x05AE, 0x4B61, [0xB6, 0x9D, 0x55, 0xB6, 0x1E, 0xE5, 0x4A, 0x7B]);
struct KSMFT_CATEGORY_MULTIPLEXER;

const GUID CLSID_KSMFT_CATEGORY_DEMULTIPLEXER = {0xA8700A7A, 0x939B, 0x44C5, [0x99, 0xD7, 0x76, 0x22, 0x6B, 0x23, 0xB3, 0xF1]};
@GUID(0xA8700A7A, 0x939B, 0x44C5, [0x99, 0xD7, 0x76, 0x22, 0x6B, 0x23, 0xB3, 0xF1]);
struct KSMFT_CATEGORY_DEMULTIPLEXER;

const GUID CLSID_KSMFT_CATEGORY_AUDIO_DECODER = {0x9EA73FB4, 0xEF7A, 0x4559, [0x8D, 0x5D, 0x71, 0x9D, 0x8F, 0x04, 0x26, 0xC7]};
@GUID(0x9EA73FB4, 0xEF7A, 0x4559, [0x8D, 0x5D, 0x71, 0x9D, 0x8F, 0x04, 0x26, 0xC7]);
struct KSMFT_CATEGORY_AUDIO_DECODER;

const GUID CLSID_KSMFT_CATEGORY_AUDIO_ENCODER = {0x91C64BD0, 0xF91E, 0x4D8C, [0x92, 0x76, 0xDB, 0x24, 0x82, 0x79, 0xD9, 0x75]};
@GUID(0x91C64BD0, 0xF91E, 0x4D8C, [0x92, 0x76, 0xDB, 0x24, 0x82, 0x79, 0xD9, 0x75]);
struct KSMFT_CATEGORY_AUDIO_ENCODER;

const GUID CLSID_KSMFT_CATEGORY_AUDIO_EFFECT = {0x11064C48, 0x3648, 0x4ED0, [0x93, 0x2E, 0x05, 0xCE, 0x8A, 0xC8, 0x11, 0xB7]};
@GUID(0x11064C48, 0x3648, 0x4ED0, [0x93, 0x2E, 0x05, 0xCE, 0x8A, 0xC8, 0x11, 0xB7]);
struct KSMFT_CATEGORY_AUDIO_EFFECT;

const GUID CLSID_KSMFT_CATEGORY_VIDEO_PROCESSOR = {0x302EA3FC, 0xAA5F, 0x47F9, [0x9F, 0x7A, 0xC2, 0x18, 0x8B, 0xB1, 0x63, 0x02]};
@GUID(0x302EA3FC, 0xAA5F, 0x47F9, [0x9F, 0x7A, 0xC2, 0x18, 0x8B, 0xB1, 0x63, 0x02]);
struct KSMFT_CATEGORY_VIDEO_PROCESSOR;

const GUID CLSID_KSMFT_CATEGORY_OTHER = {0x90175D57, 0xB7EA, 0x4901, [0xAE, 0xB3, 0x93, 0x3A, 0x87, 0x47, 0x75, 0x6F]};
@GUID(0x90175D57, 0xB7EA, 0x4901, [0xAE, 0xB3, 0x93, 0x3A, 0x87, 0x47, 0x75, 0x6F]);
struct KSMFT_CATEGORY_OTHER;

const GUID CLSID_KSCATEGORY_COMMUNICATIONSTRANSFORM = {0xCF1DDA2C, 0x9743, 0x11D0, [0xA3, 0xEE, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xCF1DDA2C, 0x9743, 0x11D0, [0xA3, 0xEE, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_COMMUNICATIONSTRANSFORM;

const GUID CLSID_KSCATEGORY_INTERFACETRANSFORM = {0xCF1DDA2D, 0x9743, 0x11D0, [0xA3, 0xEE, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xCF1DDA2D, 0x9743, 0x11D0, [0xA3, 0xEE, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_INTERFACETRANSFORM;

const GUID CLSID_KSCATEGORY_MEDIUMTRANSFORM = {0xCF1DDA2E, 0x9743, 0x11D0, [0xA3, 0xEE, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xCF1DDA2E, 0x9743, 0x11D0, [0xA3, 0xEE, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_MEDIUMTRANSFORM;

const GUID CLSID_KSCATEGORY_FILESYSTEM = {0x760FED5E, 0x9357, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x760FED5E, 0x9357, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_FILESYSTEM;

const GUID CLSID_KSCATEGORY_CLOCK = {0x53172480, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x53172480, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_CLOCK;

const GUID CLSID_KSCATEGORY_PROXY = {0x97EBAACA, 0x95BD, 0x11D0, [0xA3, 0xEA, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x97EBAACA, 0x95BD, 0x11D0, [0xA3, 0xEA, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_PROXY;

const GUID CLSID_KSCATEGORY_QUALITY = {0x97EBAACB, 0x95BD, 0x11D0, [0xA3, 0xEA, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x97EBAACB, 0x95BD, 0x11D0, [0xA3, 0xEA, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_QUALITY;

struct KSTOPOLOGY
{
    uint CategoriesCount;
    const(Guid)* Categories;
    uint TopologyNodesCount;
    const(Guid)* TopologyNodes;
    uint TopologyConnectionsCount;
    const(KSTOPOLOGY_CONNECTION)* TopologyConnections;
    const(Guid)* TopologyNodesNames;
    uint Reserved;
}

struct KSNODE_CREATE
{
    uint CreateFlags;
    uint Node;
}

const GUID CLSID_KSTIME_FORMAT_FRAME = {0x7B785570, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]};
@GUID(0x7B785570, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]);
struct KSTIME_FORMAT_FRAME;

const GUID CLSID_KSTIME_FORMAT_BYTE = {0x7B785571, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]};
@GUID(0x7B785571, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]);
struct KSTIME_FORMAT_BYTE;

const GUID CLSID_KSTIME_FORMAT_SAMPLE = {0x7B785572, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]};
@GUID(0x7B785572, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]);
struct KSTIME_FORMAT_SAMPLE;

const GUID CLSID_KSTIME_FORMAT_FIELD = {0x7B785573, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]};
@GUID(0x7B785573, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]);
struct KSTIME_FORMAT_FIELD;

const GUID CLSID_KSTIME_FORMAT_MEDIA_TIME = {0x7B785574, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]};
@GUID(0x7B785574, 0x8C82, 0x11CF, [0xBC, 0x0C, 0x00, 0xAA, 0x00, 0xAC, 0x74, 0xF6]);
struct KSTIME_FORMAT_MEDIA_TIME;

const GUID CLSID_KSINTERFACESETID_Standard = {0x1A8766A0, 0x62CE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x1A8766A0, 0x62CE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSINTERFACESETID_Standard;

enum KSINTERFACE_STANDARD
{
    KSINTERFACE_STANDARD_STREAMING = 0,
    KSINTERFACE_STANDARD_LOOPED_STREAMING = 1,
    KSINTERFACE_STANDARD_CONTROL = 2,
}

const GUID CLSID_KSINTERFACESETID_FileIo = {0x8C6F932C, 0xE771, 0x11D0, [0xB8, 0xFF, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x8C6F932C, 0xE771, 0x11D0, [0xB8, 0xFF, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSINTERFACESETID_FileIo;

enum KSINTERFACE_FILEIO
{
    KSINTERFACE_FILEIO_STREAMING = 0,
}

const GUID CLSID_KSMEDIUMSETID_Standard = {0x4747B320, 0x62CE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x4747B320, 0x62CE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSMEDIUMSETID_Standard;

const GUID CLSID_KSPROPSETID_Pin = {0x8C134960, 0x51AD, 0x11CF, [0x87, 0x8A, 0x94, 0xF8, 0x01, 0xC1, 0x00, 0x00]};
@GUID(0x8C134960, 0x51AD, 0x11CF, [0x87, 0x8A, 0x94, 0xF8, 0x01, 0xC1, 0x00, 0x00]);
struct KSPROPSETID_Pin;

enum KSPROPERTY_PIN
{
    KSPROPERTY_PIN_CINSTANCES = 0,
    KSPROPERTY_PIN_CTYPES = 1,
    KSPROPERTY_PIN_DATAFLOW = 2,
    KSPROPERTY_PIN_DATARANGES = 3,
    KSPROPERTY_PIN_DATAINTERSECTION = 4,
    KSPROPERTY_PIN_INTERFACES = 5,
    KSPROPERTY_PIN_MEDIUMS = 6,
    KSPROPERTY_PIN_COMMUNICATION = 7,
    KSPROPERTY_PIN_GLOBALCINSTANCES = 8,
    KSPROPERTY_PIN_NECESSARYINSTANCES = 9,
    KSPROPERTY_PIN_PHYSICALCONNECTION = 10,
    KSPROPERTY_PIN_CATEGORY = 11,
    KSPROPERTY_PIN_NAME = 12,
    KSPROPERTY_PIN_CONSTRAINEDDATARANGES = 13,
    KSPROPERTY_PIN_PROPOSEDATAFORMAT = 14,
    KSPROPERTY_PIN_PROPOSEDATAFORMAT2 = 15,
    KSPROPERTY_PIN_MODEDATAFORMATS = 16,
}

struct KSP_PIN
{
    KSIDENTIFIER Property;
    uint PinId;
    _Anonymous_e__Union Anonymous;
}

struct KSE_PIN
{
    KSIDENTIFIER Event;
    uint PinId;
    uint Reserved;
}

struct KSPIN_CINSTANCES
{
    uint PossibleCount;
    uint CurrentCount;
}

enum KSPIN_DATAFLOW
{
    KSPIN_DATAFLOW_IN = 1,
    KSPIN_DATAFLOW_OUT = 2,
}

struct KSDATAFORMAT
{
    _Anonymous_e__Struct Anonymous;
    long Alignment;
}

struct KSATTRIBUTE
{
    uint Size;
    uint Flags;
    Guid Attribute;
}

enum KSPIN_COMMUNICATION
{
    KSPIN_COMMUNICATION_NONE = 0,
    KSPIN_COMMUNICATION_SINK = 1,
    KSPIN_COMMUNICATION_SOURCE = 2,
    KSPIN_COMMUNICATION_BOTH = 3,
    KSPIN_COMMUNICATION_BRIDGE = 4,
}

struct KSPIN_CONNECT
{
    KSIDENTIFIER Interface;
    KSIDENTIFIER Medium;
    uint PinId;
    HANDLE PinToHandle;
    KSPRIORITY Priority;
}

struct KSPIN_PHYSICALCONNECTION
{
    uint Size;
    uint Pin;
    ushort SymbolicLinkName;
}

const GUID CLSID_KSEVENTSETID_PinCapsChange = {0xDD4F192E, 0x3B78, 0x49AD, [0xA5, 0x34, 0x2C, 0x31, 0x5B, 0x82, 0x20, 0x00]};
@GUID(0xDD4F192E, 0x3B78, 0x49AD, [0xA5, 0x34, 0x2C, 0x31, 0x5B, 0x82, 0x20, 0x00]);
struct KSEVENTSETID_PinCapsChange;

enum KSEVENT_PINCAPS_CHANGENOTIFICATIONS
{
    KSEVENT_PINCAPS_FORMATCHANGE = 0,
    KSEVENT_PINCAPS_JACKINFOCHANGE = 1,
}

const GUID CLSID_KSEVENTSETID_VolumeLimit = {0xDA168465, 0x3A7C, 0x4858, [0x9D, 0x4A, 0x3E, 0x8E, 0x24, 0x70, 0x1A, 0xEF]};
@GUID(0xDA168465, 0x3A7C, 0x4858, [0x9D, 0x4A, 0x3E, 0x8E, 0x24, 0x70, 0x1A, 0xEF]);
struct KSEVENTSETID_VolumeLimit;

enum KSEVENT_VOLUMELIMIT
{
    KSEVENT_VOLUMELIMIT_CHANGED = 0,
}

const GUID CLSID_KSNAME_Filter = {0x9B365890, 0x165F, 0x11D0, [0xA1, 0x95, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]};
@GUID(0x9B365890, 0x165F, 0x11D0, [0xA1, 0x95, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]);
struct KSNAME_Filter;

const GUID CLSID_KSNAME_Pin = {0x146F1A80, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x146F1A80, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSNAME_Pin;

const GUID CLSID_KSNAME_Clock = {0x53172480, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x53172480, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSNAME_Clock;

const GUID CLSID_KSNAME_Allocator = {0x642F5D00, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x642F5D00, 0x4791, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSNAME_Allocator;

const GUID CLSID_KSNAME_TopologyNode = {0x0621061A, 0xEE75, 0x11D0, [0xB9, 0x15, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x0621061A, 0xEE75, 0x11D0, [0xB9, 0x15, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNAME_TopologyNode;

const GUID CLSID_KSDATAFORMAT_TYPE_STREAM = {0xE436EB83, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EB83, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct KSDATAFORMAT_TYPE_STREAM;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_NONE = {0xE436EB8E, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EB8E, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct KSDATAFORMAT_SUBTYPE_NONE;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_FILENAME = {0xAA797B40, 0xE974, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0xAA797B40, 0xE974, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSDATAFORMAT_SPECIFIER_FILENAME;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_FILEHANDLE = {0x65E8773C, 0x8F56, 0x11D0, [0xA3, 0xB9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x65E8773C, 0x8F56, 0x11D0, [0xA3, 0xB9, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSDATAFORMAT_SPECIFIER_FILEHANDLE;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_NONE = {0x0F6417D6, 0xC318, 0x11D0, [0xA4, 0x3F, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x0F6417D6, 0xC318, 0x11D0, [0xA4, 0x3F, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSDATAFORMAT_SPECIFIER_NONE;

const GUID CLSID_KSPROPSETID_Quality = {0xD16AD380, 0xAC1A, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0xD16AD380, 0xAC1A, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSPROPSETID_Quality;

enum KSPROPERTY_QUALITY
{
    KSPROPERTY_QUALITY_REPORT = 0,
    KSPROPERTY_QUALITY_ERROR = 1,
}

const GUID CLSID_KSPROPSETID_Connection = {0x1D58C920, 0xAC9B, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x1D58C920, 0xAC9B, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSPROPSETID_Connection;

enum KSPROPERTY_CONNECTION
{
    KSPROPERTY_CONNECTION_STATE = 0,
    KSPROPERTY_CONNECTION_PRIORITY = 1,
    KSPROPERTY_CONNECTION_DATAFORMAT = 2,
    KSPROPERTY_CONNECTION_ALLOCATORFRAMING = 3,
    KSPROPERTY_CONNECTION_PROPOSEDATAFORMAT = 4,
    KSPROPERTY_CONNECTION_ACQUIREORDERING = 5,
    KSPROPERTY_CONNECTION_ALLOCATORFRAMING_EX = 6,
    KSPROPERTY_CONNECTION_STARTAT = 7,
}

const GUID CLSID_KSPROPSETID_MemoryTransport = {0x0A3D1C5D, 0x5243, 0x4819, [0x9E, 0xD0, 0xAE, 0xE8, 0x04, 0x4C, 0xEE, 0x2B]};
@GUID(0x0A3D1C5D, 0x5243, 0x4819, [0x9E, 0xD0, 0xAE, 0xE8, 0x04, 0x4C, 0xEE, 0x2B]);
struct KSPROPSETID_MemoryTransport;

struct KSALLOCATOR_FRAMING
{
    _Anonymous1_e__Union Anonymous1;
    uint PoolType;
    uint Frames;
    uint FrameSize;
    _Anonymous2_e__Union Anonymous2;
    uint Reserved;
}

struct KS_FRAMING_RANGE
{
    uint MinFrameSize;
    uint MaxFrameSize;
    uint Stepping;
}

struct KS_FRAMING_RANGE_WEIGHTED
{
    KS_FRAMING_RANGE Range;
    uint InPlaceWeight;
    uint NotInPlaceWeight;
}

struct KS_COMPRESSION
{
    uint RatioNumerator;
    uint RatioDenominator;
    uint RatioConstantMargin;
}

struct KS_FRAMING_ITEM
{
    Guid MemoryType;
    Guid BusType;
    uint MemoryFlags;
    uint BusFlags;
    uint Flags;
    uint Frames;
    _Anonymous_e__Union Anonymous;
    uint MemoryTypeWeight;
    KS_FRAMING_RANGE PhysicalRange;
    KS_FRAMING_RANGE_WEIGHTED FramingRange;
}

struct KSALLOCATOR_FRAMING_EX
{
    uint CountItems;
    uint PinFlags;
    KS_COMPRESSION OutputCompression;
    uint PinWeight;
    KS_FRAMING_ITEM FramingItem;
}

const GUID CLSID_KSMEMORY_TYPE_SYSTEM = {0x091BB638, 0x603F, 0x11D1, [0xB0, 0x67, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]};
@GUID(0x091BB638, 0x603F, 0x11D1, [0xB0, 0x67, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]);
struct KSMEMORY_TYPE_SYSTEM;

const GUID CLSID_KSMEMORY_TYPE_USER = {0x8CB0FC28, 0x7893, 0x11D1, [0xB0, 0x69, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]};
@GUID(0x8CB0FC28, 0x7893, 0x11D1, [0xB0, 0x69, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]);
struct KSMEMORY_TYPE_USER;

const GUID CLSID_KSMEMORY_TYPE_KERNEL_PAGED = {0xD833F8F8, 0x7894, 0x11D1, [0xB0, 0x69, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]};
@GUID(0xD833F8F8, 0x7894, 0x11D1, [0xB0, 0x69, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]);
struct KSMEMORY_TYPE_KERNEL_PAGED;

const GUID CLSID_KSMEMORY_TYPE_KERNEL_NONPAGED = {0x4A6D5FC4, 0x7895, 0x11D1, [0xB0, 0x69, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]};
@GUID(0x4A6D5FC4, 0x7895, 0x11D1, [0xB0, 0x69, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]);
struct KSMEMORY_TYPE_KERNEL_NONPAGED;

const GUID CLSID_KSMEMORY_TYPE_DEVICE_UNKNOWN = {0x091BB639, 0x603F, 0x11D1, [0xB0, 0x67, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]};
@GUID(0x091BB639, 0x603F, 0x11D1, [0xB0, 0x67, 0x00, 0xA0, 0xC9, 0x06, 0x28, 0x02]);
struct KSMEMORY_TYPE_DEVICE_UNKNOWN;

const GUID CLSID_KSEVENTSETID_StreamAllocator = {0x75D95571, 0x073C, 0x11D0, [0xA1, 0x61, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]};
@GUID(0x75D95571, 0x073C, 0x11D0, [0xA1, 0x61, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]);
struct KSEVENTSETID_StreamAllocator;

enum KSEVENT_STREAMALLOCATOR
{
    KSEVENT_STREAMALLOCATOR_INTERNAL_FREEFRAME = 0,
    KSEVENT_STREAMALLOCATOR_FREEFRAME = 1,
}

const GUID CLSID_KSMETHODSETID_StreamAllocator = {0xCF6E4341, 0xEC87, 0x11CF, [0xA1, 0x30, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]};
@GUID(0xCF6E4341, 0xEC87, 0x11CF, [0xA1, 0x30, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]);
struct KSMETHODSETID_StreamAllocator;

enum KSMETHOD_STREAMALLOCATOR
{
    KSMETHOD_STREAMALLOCATOR_ALLOC = 0,
    KSMETHOD_STREAMALLOCATOR_FREE = 1,
}

const GUID CLSID_KSPROPSETID_StreamAllocator = {0xCF6E4342, 0xEC87, 0x11CF, [0xA1, 0x30, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]};
@GUID(0xCF6E4342, 0xEC87, 0x11CF, [0xA1, 0x30, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]);
struct KSPROPSETID_StreamAllocator;

struct KSSTREAMALLOCATOR_STATUS
{
    KSALLOCATOR_FRAMING Framing;
    uint AllocatedFrames;
    uint Reserved;
}

struct KSSTREAMALLOCATOR_STATUS_EX
{
    KSALLOCATOR_FRAMING_EX Framing;
    uint AllocatedFrames;
    uint Reserved;
}

struct KSTIME
{
    long Time;
    uint Numerator;
    uint Denominator;
}

struct KSSTREAM_HEADER
{
    uint Size;
    uint TypeSpecificFlags;
    KSTIME PresentationTime;
    long Duration;
    uint FrameExtent;
    uint DataUsed;
    void* Data;
    uint OptionsFlags;
}

struct KSSTREAM_METADATA_INFO
{
    uint BufferSize;
    uint UsedSize;
    void* Data;
    void* SystemVa;
    uint Flags;
    uint Reserved;
}

struct KSSTREAM_UVC_METADATATYPE_TIMESTAMP
{
    uint PresentationTimeStamp;
    uint SourceClockReference;
    _Anonymous_e__Union Anonymous;
    ushort Reserved0;
    uint Reserved1;
}

struct KSSTREAM_UVC_METADATA
{
    KSSTREAM_UVC_METADATATYPE_TIMESTAMP StartOfFrameTimestamp;
    KSSTREAM_UVC_METADATATYPE_TIMESTAMP EndOfFrameTimestamp;
}

enum KSPIN_MDL_CACHING_EVENT
{
    KSPIN_MDL_CACHING_NOTIFY_CLEANUP = 0,
    KSPIN_MDL_CACHING_NOTIFY_CLEANALL_WAIT = 1,
    KSPIN_MDL_CACHING_NOTIFY_CLEANALL_NOWAIT = 2,
    KSPIN_MDL_CACHING_NOTIFY_ADDSAMPLE = 3,
}

struct KSPIN_MDL_CACHING_NOTIFICATION
{
    KSPIN_MDL_CACHING_EVENT Event;
    void* Buffer;
}

struct KSPIN_MDL_CACHING_NOTIFICATION32
{
    KSPIN_MDL_CACHING_EVENT Event;
    uint Buffer;
}

const GUID CLSID_KSPROPSETID_StreamInterface = {0x1FDD8EE1, 0x9CD3, 0x11D0, [0x82, 0xAA, 0x00, 0x00, 0xF8, 0x22, 0xFE, 0x8A]};
@GUID(0x1FDD8EE1, 0x9CD3, 0x11D0, [0x82, 0xAA, 0x00, 0x00, 0xF8, 0x22, 0xFE, 0x8A]);
struct KSPROPSETID_StreamInterface;

enum KSPROPERTY_STREAMINTERFACE
{
    KSPROPERTY_STREAMINTERFACE_HEADERSIZE = 0,
}

const GUID CLSID_KSPROPSETID_Stream = {0x65AABA60, 0x98AE, 0x11CF, [0xA1, 0x0D, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]};
@GUID(0x65AABA60, 0x98AE, 0x11CF, [0xA1, 0x0D, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]);
struct KSPROPSETID_Stream;

enum KSPROPERTY_STREAM
{
    KSPROPERTY_STREAM_ALLOCATOR = 0,
    KSPROPERTY_STREAM_QUALITY = 1,
    KSPROPERTY_STREAM_DEGRADATION = 2,
    KSPROPERTY_STREAM_MASTERCLOCK = 3,
    KSPROPERTY_STREAM_TIMEFORMAT = 4,
    KSPROPERTY_STREAM_PRESENTATIONTIME = 5,
    KSPROPERTY_STREAM_PRESENTATIONEXTENT = 6,
    KSPROPERTY_STREAM_FRAMETIME = 7,
    KSPROPERTY_STREAM_RATECAPABILITY = 8,
    KSPROPERTY_STREAM_RATE = 9,
    KSPROPERTY_STREAM_PIPE_ID = 10,
}

enum KSPPROPERTY_ALLOCATOR_MDLCACHING
{
    KSPROPERTY_ALLOCATOR_CLEANUP_CACHEDMDLPAGES = 1,
}

const GUID CLSID_KSPROPSETID_PinMDLCacheClearProp = {0xBD718A7B, 0x97FC, 0x40C7, [0x88, 0xCE, 0xD3, 0xFF, 0x06, 0xF5, 0x5B, 0x16]};
@GUID(0xBD718A7B, 0x97FC, 0x40C7, [0x88, 0xCE, 0xD3, 0xFF, 0x06, 0xF5, 0x5B, 0x16]);
struct KSPROPSETID_PinMDLCacheClearProp;

struct KSQUALITY_MANAGER
{
    HANDLE QualityManager;
    void* Context;
}

struct KSFRAMETIME
{
    long Duration;
    uint FrameFlags;
    uint Reserved;
}

struct KSRATE
{
    long PresentationStart;
    long Duration;
    KSIDENTIFIER Interface;
    int Rate;
    uint Flags;
}

struct KSRATE_CAPABILITY
{
    KSIDENTIFIER Property;
    KSRATE Rate;
}

const GUID CLSID_KSPROPSETID_Clock = {0xDF12A4C0, 0xAC17, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0xDF12A4C0, 0xAC17, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSPROPSETID_Clock;

struct KSCLOCK_CREATE
{
    uint CreateFlags;
}

struct KSCORRELATED_TIME
{
    long Time;
    long SystemTime;
}

struct KSRESOLUTION
{
    long Granularity;
    long Error;
}

enum KSPROPERTY_CLOCK
{
    KSPROPERTY_CLOCK_TIME = 0,
    KSPROPERTY_CLOCK_PHYSICALTIME = 1,
    KSPROPERTY_CLOCK_CORRELATEDTIME = 2,
    KSPROPERTY_CLOCK_CORRELATEDPHYSICALTIME = 3,
    KSPROPERTY_CLOCK_RESOLUTION = 4,
    KSPROPERTY_CLOCK_STATE = 5,
}

const GUID CLSID_KSEVENTSETID_Clock = {0x364D8E20, 0x62C7, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x364D8E20, 0x62C7, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSEVENTSETID_Clock;

enum KSEVENT_CLOCK_POSITION
{
    KSEVENT_CLOCK_INTERVAL_MARK = 0,
    KSEVENT_CLOCK_POSITION_MARK = 1,
}

const GUID CLSID_KSEVENTSETID_Connection = {0x7F4BCBE0, 0x9EA5, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x7F4BCBE0, 0x9EA5, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSEVENTSETID_Connection;

enum KSEVENT_CONNECTION
{
    KSEVENT_CONNECTION_POSITIONUPDATE = 0,
    KSEVENT_CONNECTION_DATADISCONTINUITY = 1,
    KSEVENT_CONNECTION_TIMEDISCONTINUITY = 2,
    KSEVENT_CONNECTION_PRIORITY = 3,
    KSEVENT_CONNECTION_ENDOFSTREAM = 4,
}

struct KSQUALITY
{
    void* Context;
    uint Proportion;
    long DeltaTime;
}

struct KSERROR
{
    void* Context;
    uint Status;
}

enum KSDEVICE_THERMAL_STATE
{
    KSDEVICE_THERMAL_STATE_LOW = 0,
    KSDEVICE_THERMAL_STATE_HIGH = 1,
}

const GUID CLSID_KSEVENTSETID_Device = {0x288296EC, 0x9F94, 0x41B4, [0xA1, 0x53, 0xAA, 0x31, 0xAE, 0xEC, 0xB3, 0x3F]};
@GUID(0x288296EC, 0x9F94, 0x41B4, [0xA1, 0x53, 0xAA, 0x31, 0xAE, 0xEC, 0xB3, 0x3F]);
struct KSEVENTSETID_Device;

enum KSEVENT_DEVICE
{
    KSEVENT_DEVICE_LOST = 0,
    KSEVENT_DEVICE_PREEMPTED = 1,
    KSEVENT_DEVICE_THERMAL_HIGH = 2,
    KSEVENT_DEVICE_THERMAL_LOW = 3,
}

const GUID CLSID_KSDEGRADESETID_Standard = {0x9F564180, 0x704C, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x9F564180, 0x704C, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSDEGRADESETID_Standard;

enum KSDEGRADE_STANDARD
{
    KSDEGRADE_STANDARD_SAMPLE = 0,
    KSDEGRADE_STANDARD_QUALITY = 1,
    KSDEGRADE_STANDARD_COMPUTATION = 2,
    KSDEGRADE_STANDARD_SKIP = 3,
}

struct KSPROPERTY_SERIALHDR
{
    Guid PropertySet;
    uint Count;
}

struct KSPROPERTY_SERIAL
{
    KSIDENTIFIER PropTypeSet;
    uint Id;
    uint PropertyLength;
}

struct MF_MDL_SHARED_PAYLOAD_KEY
{
    _combined_e__Struct combined;
    Guid GMDLHandle;
}

struct KSMULTIPLE_DATA_PROP
{
    KSIDENTIFIER Property;
    KSMULTIPLE_ITEM MultipleItem;
}

const GUID CLSID_KSMEDIUMSETID_MidiBus = {0x05908040, 0x3246, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x05908040, 0x3246, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSMEDIUMSETID_MidiBus;

const GUID CLSID_KSMEDIUMSETID_VPBus = {0xA18C15EC, 0xCE43, 0x11D0, [0xAB, 0xE7, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xA18C15EC, 0xCE43, 0x11D0, [0xAB, 0xE7, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSMEDIUMSETID_VPBus;

const GUID CLSID_KSINTERFACESETID_Media = {0x3A13EB40, 0x30A7, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x3A13EB40, 0x30A7, 0x11D0, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSINTERFACESETID_Media;

enum KSINTERFACE_MEDIA
{
    KSINTERFACE_MEDIA_MUSIC = 0,
    KSINTERFACE_MEDIA_WAVE_BUFFERED = 1,
    KSINTERFACE_MEDIA_WAVE_QUEUED = 2,
}

const GUID CLSID_KSCOMPONENTID_USBAUDIO = {0x8F1275F0, 0x26E9, 0x4264, [0xBA, 0x4D, 0x39, 0xFF, 0xF0, 0x1D, 0x94, 0xAA]};
@GUID(0x8F1275F0, 0x26E9, 0x4264, [0xBA, 0x4D, 0x39, 0xFF, 0xF0, 0x1D, 0x94, 0xAA]);
struct KSCOMPONENTID_USBAUDIO;

const GUID CLSID_KSNODETYPE_INPUT_UNDEFINED = {0xDFF21BE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21BE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_INPUT_UNDEFINED;

const GUID CLSID_KSNODETYPE_MICROPHONE = {0xDFF21BE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21BE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_MICROPHONE;

const GUID CLSID_KSNODETYPE_DESKTOP_MICROPHONE = {0xDFF21BE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21BE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DESKTOP_MICROPHONE;

const GUID CLSID_KSNODETYPE_PERSONAL_MICROPHONE = {0xDFF21BE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21BE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_PERSONAL_MICROPHONE;

const GUID CLSID_KSNODETYPE_OMNI_DIRECTIONAL_MICROPHONE = {0xDFF21BE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21BE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_OMNI_DIRECTIONAL_MICROPHONE;

const GUID CLSID_KSNODETYPE_MICROPHONE_ARRAY = {0xDFF21BE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21BE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_MICROPHONE_ARRAY;

const GUID CLSID_KSNODETYPE_PROCESSING_MICROPHONE_ARRAY = {0xDFF21BE6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21BE6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_PROCESSING_MICROPHONE_ARRAY;

const GUID CLSID_KSCATEGORY_MICROPHONE_ARRAY_PROCESSOR = {0x830A44F2, 0xA32D, 0x476B, [0xBE, 0x97, 0x42, 0x84, 0x56, 0x73, 0xB3, 0x5A]};
@GUID(0x830A44F2, 0xA32D, 0x476B, [0xBE, 0x97, 0x42, 0x84, 0x56, 0x73, 0xB3, 0x5A]);
struct KSCATEGORY_MICROPHONE_ARRAY_PROCESSOR;

const GUID CLSID_KSNODETYPE_OUTPUT_UNDEFINED = {0xDFF21CE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_OUTPUT_UNDEFINED;

const GUID CLSID_KSNODETYPE_SPEAKER = {0xDFF21CE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_SPEAKER;

const GUID CLSID_KSNODETYPE_HEADPHONES = {0xDFF21CE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_HEADPHONES;

const GUID CLSID_KSNODETYPE_HEAD_MOUNTED_DISPLAY_AUDIO = {0xDFF21CE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_HEAD_MOUNTED_DISPLAY_AUDIO;

const GUID CLSID_KSNODETYPE_DESKTOP_SPEAKER = {0xDFF21CE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DESKTOP_SPEAKER;

const GUID CLSID_KSNODETYPE_ROOM_SPEAKER = {0xDFF21CE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_ROOM_SPEAKER;

const GUID CLSID_KSNODETYPE_COMMUNICATION_SPEAKER = {0xDFF21CE6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_COMMUNICATION_SPEAKER;

const GUID CLSID_KSNODETYPE_LOW_FREQUENCY_EFFECTS_SPEAKER = {0xDFF21CE7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21CE7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_LOW_FREQUENCY_EFFECTS_SPEAKER;

const GUID CLSID_KSNODETYPE_BIDIRECTIONAL_UNDEFINED = {0xDFF21DE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21DE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_BIDIRECTIONAL_UNDEFINED;

const GUID CLSID_KSNODETYPE_HANDSET = {0xDFF21DE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21DE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_HANDSET;

const GUID CLSID_KSNODETYPE_HEADSET = {0xDFF21DE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21DE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_HEADSET;

const GUID CLSID_KSNODETYPE_SPEAKERPHONE_NO_ECHO_REDUCTION = {0xDFF21DE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21DE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_SPEAKERPHONE_NO_ECHO_REDUCTION;

const GUID CLSID_KSNODETYPE_ECHO_SUPPRESSING_SPEAKERPHONE = {0xDFF21DE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21DE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_ECHO_SUPPRESSING_SPEAKERPHONE;

const GUID CLSID_KSNODETYPE_ECHO_CANCELING_SPEAKERPHONE = {0xDFF21DE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21DE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_ECHO_CANCELING_SPEAKERPHONE;

const GUID CLSID_KSNODETYPE_TELEPHONY_UNDEFINED = {0xDFF21EE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21EE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_TELEPHONY_UNDEFINED;

const GUID CLSID_KSNODETYPE_PHONE_LINE = {0xDFF21EE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21EE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_PHONE_LINE;

const GUID CLSID_KSNODETYPE_TELEPHONE = {0xDFF21EE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21EE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_TELEPHONE;

const GUID CLSID_KSNODETYPE_DOWN_LINE_PHONE = {0xDFF21EE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21EE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DOWN_LINE_PHONE;

const GUID CLSID_KSNODETYPE_EXTERNAL_UNDEFINED = {0xDFF21FE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_EXTERNAL_UNDEFINED;

const GUID CLSID_KSNODETYPE_ANALOG_CONNECTOR = {0xDFF21FE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_ANALOG_CONNECTOR;

const GUID CLSID_KSNODETYPE_DIGITAL_AUDIO_INTERFACE = {0xDFF21FE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DIGITAL_AUDIO_INTERFACE;

const GUID CLSID_KSNODETYPE_LINE_CONNECTOR = {0xDFF21FE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_LINE_CONNECTOR;

const GUID CLSID_KSNODETYPE_LEGACY_AUDIO_CONNECTOR = {0xDFF21FE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_LEGACY_AUDIO_CONNECTOR;

const GUID CLSID_KSNODETYPE_SPDIF_INTERFACE = {0xDFF21FE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_SPDIF_INTERFACE;

const GUID CLSID_KSNODETYPE_1394_DA_STREAM = {0xDFF21FE6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_1394_DA_STREAM;

const GUID CLSID_KSNODETYPE_1394_DV_STREAM_SOUNDTRACK = {0xDFF21FE7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF21FE7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_1394_DV_STREAM_SOUNDTRACK;

const GUID CLSID_KSNODETYPE_EMBEDDED_UNDEFINED = {0xDFF220E0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_EMBEDDED_UNDEFINED;

const GUID CLSID_KSNODETYPE_LEVEL_CALIBRATION_NOISE_SOURCE = {0xDFF220E1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_LEVEL_CALIBRATION_NOISE_SOURCE;

const GUID CLSID_KSNODETYPE_EQUALIZATION_NOISE = {0xDFF220E2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_EQUALIZATION_NOISE;

const GUID CLSID_KSNODETYPE_CD_PLAYER = {0xDFF220E3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_CD_PLAYER;

const GUID CLSID_KSNODETYPE_DAT_IO_DIGITAL_AUDIO_TAPE = {0xDFF220E4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DAT_IO_DIGITAL_AUDIO_TAPE;

const GUID CLSID_KSNODETYPE_DCC_IO_DIGITAL_COMPACT_CASSETTE = {0xDFF220E5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DCC_IO_DIGITAL_COMPACT_CASSETTE;

const GUID CLSID_KSNODETYPE_MINIDISK = {0xDFF220E6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_MINIDISK;

const GUID CLSID_KSNODETYPE_ANALOG_TAPE = {0xDFF220E7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_ANALOG_TAPE;

const GUID CLSID_KSNODETYPE_PHONOGRAPH = {0xDFF220E8, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E8, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_PHONOGRAPH;

const GUID CLSID_KSNODETYPE_VCR_AUDIO = {0xDFF220E9, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220E9, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VCR_AUDIO;

const GUID CLSID_KSNODETYPE_VIDEO_DISC_AUDIO = {0xDFF220EA, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220EA, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_DISC_AUDIO;

const GUID CLSID_KSNODETYPE_DVD_AUDIO = {0xDFF220EB, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220EB, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DVD_AUDIO;

const GUID CLSID_KSNODETYPE_TV_TUNER_AUDIO = {0xDFF220EC, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220EC, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_TV_TUNER_AUDIO;

const GUID CLSID_KSNODETYPE_SATELLITE_RECEIVER_AUDIO = {0xDFF220ED, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220ED, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_SATELLITE_RECEIVER_AUDIO;

const GUID CLSID_KSNODETYPE_CABLE_TUNER_AUDIO = {0xDFF220EE, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220EE, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_CABLE_TUNER_AUDIO;

const GUID CLSID_KSNODETYPE_DSS_AUDIO = {0xDFF220EF, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220EF, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_DSS_AUDIO;

const GUID CLSID_KSNODETYPE_RADIO_RECEIVER = {0xDFF220F0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220F0, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_RADIO_RECEIVER;

const GUID CLSID_KSNODETYPE_RADIO_TRANSMITTER = {0xDFF220F1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220F1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_RADIO_TRANSMITTER;

const GUID CLSID_KSNODETYPE_MULTITRACK_RECORDER = {0xDFF220F2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220F2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_MULTITRACK_RECORDER;

const GUID CLSID_KSNODETYPE_SYNTHESIZER = {0xDFF220F3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF220F3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_SYNTHESIZER;

const GUID CLSID_KSNODETYPE_HDMI_INTERFACE = {0xD1B9CC2A, 0xF519, 0x417F, [0x91, 0xC9, 0x55, 0xFA, 0x65, 0x48, 0x10, 0x01]};
@GUID(0xD1B9CC2A, 0xF519, 0x417F, [0x91, 0xC9, 0x55, 0xFA, 0x65, 0x48, 0x10, 0x01]);
struct KSNODETYPE_HDMI_INTERFACE;

const GUID CLSID_KSNODETYPE_DISPLAYPORT_INTERFACE = {0xE47E4031, 0x3EA6, 0x418D, [0x8F, 0x9B, 0xB7, 0x38, 0x43, 0xCC, 0xBA, 0x97]};
@GUID(0xE47E4031, 0x3EA6, 0x418D, [0x8F, 0x9B, 0xB7, 0x38, 0x43, 0xCC, 0xBA, 0x97]);
struct KSNODETYPE_DISPLAYPORT_INTERFACE;

const GUID CLSID_KSNODETYPE_AUDIO_LOOPBACK = {0x8F42C0B2, 0x91CE, 0x4BCF, [0x9C, 0xCD, 0x0E, 0x59, 0x90, 0x37, 0xAB, 0x35]};
@GUID(0x8F42C0B2, 0x91CE, 0x4BCF, [0x9C, 0xCD, 0x0E, 0x59, 0x90, 0x37, 0xAB, 0x35]);
struct KSNODETYPE_AUDIO_LOOPBACK;

const GUID CLSID_KSNODETYPE_AUDIO_KEYWORDDETECTOR = {0x3817E0B8, 0xDF58, 0x4375, [0xB6, 0x69, 0xC4, 0x96, 0x34, 0x33, 0x1F, 0x9D]};
@GUID(0x3817E0B8, 0xDF58, 0x4375, [0xB6, 0x69, 0xC4, 0x96, 0x34, 0x33, 0x1F, 0x9D]);
struct KSNODETYPE_AUDIO_KEYWORDDETECTOR;

const GUID CLSID_KSNODETYPE_MIDI_JACK = {0x265E0C3F, 0xFA39, 0x4DF3, [0xAB, 0x04, 0xBE, 0x01, 0xB9, 0x1E, 0x29, 0x9A]};
@GUID(0x265E0C3F, 0xFA39, 0x4DF3, [0xAB, 0x04, 0xBE, 0x01, 0xB9, 0x1E, 0x29, 0x9A]);
struct KSNODETYPE_MIDI_JACK;

const GUID CLSID_KSNODETYPE_MIDI_ELEMENT = {0x01C6FE66, 0x6E48, 0x4C65, [0xAC, 0x9B, 0x52, 0xDB, 0x5D, 0x65, 0x6C, 0x7E]};
@GUID(0x01C6FE66, 0x6E48, 0x4C65, [0xAC, 0x9B, 0x52, 0xDB, 0x5D, 0x65, 0x6C, 0x7E]);
struct KSNODETYPE_MIDI_ELEMENT;

const GUID CLSID_KSNODETYPE_AUDIO_ENGINE = {0x35CAF6E4, 0xF3B3, 0x4168, [0xBB, 0x4B, 0x55, 0xE7, 0x7A, 0x46, 0x1C, 0x7E]};
@GUID(0x35CAF6E4, 0xF3B3, 0x4168, [0xBB, 0x4B, 0x55, 0xE7, 0x7A, 0x46, 0x1C, 0x7E]);
struct KSNODETYPE_AUDIO_ENGINE;

const GUID CLSID_KSNODETYPE_SPEAKERS_STATIC_JACK = {0x28E04F87, 0x4DBE, 0x4F8D, [0x85, 0x89, 0x02, 0x5D, 0x20, 0x9D, 0xFB, 0x4A]};
@GUID(0x28E04F87, 0x4DBE, 0x4F8D, [0x85, 0x89, 0x02, 0x5D, 0x20, 0x9D, 0xFB, 0x4A]);
struct KSNODETYPE_SPEAKERS_STATIC_JACK;

const GUID CLSID_PINNAME_SPDIF_OUT = {0x3A264481, 0xE52C, 0x4B82, [0x8E, 0x7A, 0xC8, 0xE2, 0xF9, 0x1D, 0xC3, 0x80]};
@GUID(0x3A264481, 0xE52C, 0x4B82, [0x8E, 0x7A, 0xC8, 0xE2, 0xF9, 0x1D, 0xC3, 0x80]);
struct PINNAME_SPDIF_OUT;

const GUID CLSID_PINNAME_SPDIF_IN = {0x15DC9025, 0x22AD, 0x41B3, [0x88, 0x75, 0xF4, 0xCE, 0xB0, 0x29, 0x9E, 0x20]};
@GUID(0x15DC9025, 0x22AD, 0x41B3, [0x88, 0x75, 0xF4, 0xCE, 0xB0, 0x29, 0x9E, 0x20]);
struct PINNAME_SPDIF_IN;

const GUID CLSID_PINNAME_HDMI_OUT = {0x387BFC03, 0xE7EF, 0x4901, [0x86, 0xE0, 0x35, 0xB7, 0xC3, 0x2B, 0x00, 0xEF]};
@GUID(0x387BFC03, 0xE7EF, 0x4901, [0x86, 0xE0, 0x35, 0xB7, 0xC3, 0x2B, 0x00, 0xEF]);
struct PINNAME_HDMI_OUT;

const GUID CLSID_PINNAME_DISPLAYPORT_OUT = {0x21FBB329, 0x1A4A, 0x48DA, [0xA0, 0x76, 0x23, 0x18, 0xA3, 0xC5, 0x9B, 0x26]};
@GUID(0x21FBB329, 0x1A4A, 0x48DA, [0xA0, 0x76, 0x23, 0x18, 0xA3, 0xC5, 0x9B, 0x26]);
struct PINNAME_DISPLAYPORT_OUT;

const GUID CLSID_KSNODETYPE_DRM_DESCRAMBLE = {0xFFBB6E3F, 0xCCFE, 0x4D84, [0x90, 0xD9, 0x42, 0x14, 0x18, 0xB0, 0x3A, 0x8E]};
@GUID(0xFFBB6E3F, 0xCCFE, 0x4D84, [0x90, 0xD9, 0x42, 0x14, 0x18, 0xB0, 0x3A, 0x8E]);
struct KSNODETYPE_DRM_DESCRAMBLE;

const GUID CLSID_KSNODETYPE_TELEPHONY_BIDI = {0x686D7CC0, 0xD903, 0x4258, [0xB4, 0x43, 0x3A, 0x3D, 0x35, 0x80, 0x74, 0x1C]};
@GUID(0x686D7CC0, 0xD903, 0x4258, [0xB4, 0x43, 0x3A, 0x3D, 0x35, 0x80, 0x74, 0x1C]);
struct KSNODETYPE_TELEPHONY_BIDI;

const GUID CLSID_KSNODETYPE_FM_RX = {0x834A733C, 0xF485, 0x41C0, [0xA6, 0x2B, 0x51, 0x30, 0x25, 0x01, 0x4E, 0x40]};
@GUID(0x834A733C, 0xF485, 0x41C0, [0xA6, 0x2B, 0x51, 0x30, 0x25, 0x01, 0x4E, 0x40]);
struct KSNODETYPE_FM_RX;

const GUID CLSID_KSCATEGORY_AUDIO = {0x6994AD04, 0x93EF, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x6994AD04, 0x93EF, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_AUDIO;

const GUID CLSID_KSCATEGORY_VIDEO = {0x6994AD05, 0x93EF, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x6994AD05, 0x93EF, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_VIDEO;

const GUID CLSID_KSCATEGORY_REALTIME = {0xEB115FFC, 0x10C8, 0x4964, [0x83, 0x1D, 0x6D, 0xCB, 0x02, 0xE6, 0xF2, 0x3F]};
@GUID(0xEB115FFC, 0x10C8, 0x4964, [0x83, 0x1D, 0x6D, 0xCB, 0x02, 0xE6, 0xF2, 0x3F]);
struct KSCATEGORY_REALTIME;

const GUID CLSID_KSCATEGORY_TEXT = {0x6994AD06, 0x93EF, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x6994AD06, 0x93EF, 0x11D0, [0xA3, 0xCC, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_TEXT;

const GUID CLSID_KSCATEGORY_NETWORK = {0x67C9CC3C, 0x69C4, 0x11D2, [0x87, 0x59, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x67C9CC3C, 0x69C4, 0x11D2, [0x87, 0x59, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_NETWORK;

const GUID CLSID_KSCATEGORY_TOPOLOGY = {0xDDA54A40, 0x1E4C, 0x11D1, [0xA0, 0x50, 0x40, 0x57, 0x05, 0xC1, 0x00, 0x00]};
@GUID(0xDDA54A40, 0x1E4C, 0x11D1, [0xA0, 0x50, 0x40, 0x57, 0x05, 0xC1, 0x00, 0x00]);
struct KSCATEGORY_TOPOLOGY;

const GUID CLSID_KSCATEGORY_VIRTUAL = {0x3503EAC4, 0x1F26, 0x11D1, [0x8A, 0xB0, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x3503EAC4, 0x1F26, 0x11D1, [0x8A, 0xB0, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSCATEGORY_VIRTUAL;

const GUID CLSID_KSCATEGORY_ACOUSTIC_ECHO_CANCEL = {0xBF963D80, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0xBF963D80, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSCATEGORY_ACOUSTIC_ECHO_CANCEL;

const GUID CLSID_KSCATEGORY_WDMAUD_USE_PIN_NAME = {0x47A4FA20, 0xA251, 0x11D1, [0xA0, 0x50, 0x00, 0x00, 0xF8, 0x00, 0x47, 0x88]};
@GUID(0x47A4FA20, 0xA251, 0x11D1, [0xA0, 0x50, 0x00, 0x00, 0xF8, 0x00, 0x47, 0x88]);
struct KSCATEGORY_WDMAUD_USE_PIN_NAME;

const GUID CLSID_KSCATEGORY_ESCALANTE_PLATFORM_DRIVER = {0x74F3AEA8, 0x9768, 0x11D1, [0x8E, 0x07, 0x00, 0xA0, 0xC9, 0x5E, 0xC2, 0x2E]};
@GUID(0x74F3AEA8, 0x9768, 0x11D1, [0x8E, 0x07, 0x00, 0xA0, 0xC9, 0x5E, 0xC2, 0x2E]);
struct KSCATEGORY_ESCALANTE_PLATFORM_DRIVER;

const GUID CLSID_KSDATAFORMAT_TYPE_VIDEO = {0x73646976, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x73646976, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_TYPE_VIDEO;

const GUID CLSID_KSDATAFORMAT_TYPE_AUDIO = {0x73647561, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x73647561, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_TYPE_AUDIO;

const GUID CLSID_KSDATAFORMAT_TYPE_TEXT = {0x73747874, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x73747874, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_TYPE_TEXT;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_ANALOG = {0x6DBA3190, 0x67BD, 0x11CF, [0xA0, 0xF7, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]};
@GUID(0x6DBA3190, 0x67BD, 0x11CF, [0xA0, 0xF7, 0x00, 0x20, 0xAF, 0xD1, 0x56, 0xE4]);
struct KSDATAFORMAT_SUBTYPE_ANALOG;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_DRM = {0x00000009, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000009, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_DRM;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_ALAW = {0x00000006, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000006, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_ALAW;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MULAW = {0x00000007, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000007, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_MULAW;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_ADPCM = {0x00000002, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000002, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_ADPCM;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEG = {0x00000050, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000050, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_MPEG;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_VC_ID = {0xAD98D184, 0xAAC3, 0x11D0, [0xA4, 0x1C, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xAD98D184, 0xAAC3, 0x11D0, [0xA4, 0x1C, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSDATAFORMAT_SPECIFIER_VC_ID;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_WAVEFORMATEX = {0x05589F81, 0xC356, 0x11CE, [0xBF, 0x01, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]};
@GUID(0x05589F81, 0xC356, 0x11CE, [0xBF, 0x01, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]);
struct KSDATAFORMAT_SPECIFIER_WAVEFORMATEX;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_DSOUND = {0x518590A2, 0xA184, 0x11D0, [0x85, 0x22, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]};
@GUID(0x518590A2, 0xA184, 0x11D0, [0x85, 0x22, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]);
struct KSDATAFORMAT_SPECIFIER_DSOUND;

struct KSDATAFORMAT_WAVEFORMATEX
{
    KSDATAFORMAT DataFormat;
    WAVEFORMATEX WaveFormatEx;
}

struct WAVEFORMATEXTENSIBLE_IEC61937
{
    WAVEFORMATEXTENSIBLE FormatExt;
    uint dwEncodedSamplesPerSec;
    uint dwEncodedChannelCount;
    uint dwAverageBytesPerSec;
}

struct KSDATAFORMAT_WAVEFORMATEXTENSIBLE
{
    KSDATAFORMAT DataFormat;
    WAVEFORMATEXTENSIBLE WaveFormatExt;
}

struct KSDSOUND_BUFFERDESC
{
    uint Flags;
    uint Control;
    WAVEFORMATEX WaveFormatEx;
}

struct KSDATAFORMAT_DSOUND
{
    KSDATAFORMAT DataFormat;
    KSDSOUND_BUFFERDESC BufferDesc;
}

struct KSAUDIO_POSITION
{
    ulong PlayOffset;
    ulong WriteOffset;
}

struct KSAUDIO_PRESENTATION_POSITION
{
    ulong u64PositionInBlocks;
    ulong u64QPCPosition;
}

enum CONSTRICTOR_OPTION
{
    CONSTRICTOR_OPTION_DISABLE = 0,
    CONSTRICTOR_OPTION_MUTE = 1,
}

struct _KSAUDIO_PACKETSIZE_SIGNALPROCESSINGMODE_CONSTRAINT
{
    Guid ProcessingMode;
    uint SamplesPerProcessingPacket;
    uint ProcessingPacketDurationInHns;
}

struct KSAUDIO_PACKETSIZE_CONSTRAINTS
{
    uint MinPacketPeriodInHns;
    uint PacketSizeFileAlignment;
    uint Reserved;
    uint NumProcessingModeConstraints;
    _KSAUDIO_PACKETSIZE_SIGNALPROCESSINGMODE_CONSTRAINT ProcessingModeConstraints;
}

struct KSAUDIO_PACKETSIZE_CONSTRAINTS2
{
    uint MinPacketPeriodInHns;
    uint PacketSizeFileAlignment;
    uint MaxPacketSizeInBytes;
    uint NumProcessingModeConstraints;
    _KSAUDIO_PACKETSIZE_SIGNALPROCESSINGMODE_CONSTRAINT ProcessingModeConstraints;
}

enum KSMICARRAY_MICTYPE
{
    KSMICARRAY_MICTYPE_OMNIDIRECTIONAL = 0,
    KSMICARRAY_MICTYPE_SUBCARDIOID = 1,
    KSMICARRAY_MICTYPE_CARDIOID = 2,
    KSMICARRAY_MICTYPE_SUPERCARDIOID = 3,
    KSMICARRAY_MICTYPE_HYPERCARDIOID = 4,
    KSMICARRAY_MICTYPE_8SHAPED = 5,
    KSMICARRAY_MICTYPE_VENDORDEFINED = 15,
}

struct KSAUDIO_MICROPHONE_COORDINATES
{
    ushort usType;
    short wXCoord;
    short wYCoord;
    short wZCoord;
    short wVerticalAngle;
    short wHorizontalAngle;
}

enum KSMICARRAY_MICARRAYTYPE
{
    KSMICARRAY_MICARRAYTYPE_LINEAR = 0,
    KSMICARRAY_MICARRAYTYPE_PLANAR = 1,
    KSMICARRAY_MICARRAYTYPE_3D = 2,
}

struct KSAUDIO_MIC_ARRAY_GEOMETRY
{
    ushort usVersion;
    ushort usMicArrayType;
    short wVerticalAngleBegin;
    short wVerticalAngleEnd;
    short wHorizontalAngleBegin;
    short wHorizontalAngleEnd;
    ushort usFrequencyBandLo;
    ushort usFrequencyBandHi;
    ushort usNumberOfMicrophones;
    KSAUDIO_MICROPHONE_COORDINATES KsMicCoord;
}

struct DS3DVECTOR
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
}

const GUID CLSID_KSPROPSETID_DirectSound3DListener = {0x437B3414, 0xD060, 0x11D0, [0x85, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]};
@GUID(0x437B3414, 0xD060, 0x11D0, [0x85, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]);
struct KSPROPSETID_DirectSound3DListener;

enum KSPROPERTY_DIRECTSOUND3DLISTENER
{
    KSPROPERTY_DIRECTSOUND3DLISTENER_ALL = 0,
    KSPROPERTY_DIRECTSOUND3DLISTENER_POSITION = 1,
    KSPROPERTY_DIRECTSOUND3DLISTENER_VELOCITY = 2,
    KSPROPERTY_DIRECTSOUND3DLISTENER_ORIENTATION = 3,
    KSPROPERTY_DIRECTSOUND3DLISTENER_DISTANCEFACTOR = 4,
    KSPROPERTY_DIRECTSOUND3DLISTENER_ROLLOFFFACTOR = 5,
    KSPROPERTY_DIRECTSOUND3DLISTENER_DOPPLERFACTOR = 6,
    KSPROPERTY_DIRECTSOUND3DLISTENER_BATCH = 7,
    KSPROPERTY_DIRECTSOUND3DLISTENER_ALLOCATION = 8,
}

struct KSDS3D_LISTENER_ALL
{
    DS3DVECTOR Position;
    DS3DVECTOR Velocity;
    DS3DVECTOR OrientFront;
    DS3DVECTOR OrientTop;
    float DistanceFactor;
    float RolloffFactor;
    float DopplerFactor;
}

struct KSDS3D_LISTENER_ORIENTATION
{
    DS3DVECTOR Front;
    DS3DVECTOR Top;
}

const GUID CLSID_KSPROPSETID_DirectSound3DBuffer = {0x437B3411, 0xD060, 0x11D0, [0x85, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]};
@GUID(0x437B3411, 0xD060, 0x11D0, [0x85, 0x83, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]);
struct KSPROPSETID_DirectSound3DBuffer;

enum KSPROPERTY_DIRECTSOUND3DBUFFER
{
    KSPROPERTY_DIRECTSOUND3DBUFFER_ALL = 0,
    KSPROPERTY_DIRECTSOUND3DBUFFER_POSITION = 1,
    KSPROPERTY_DIRECTSOUND3DBUFFER_VELOCITY = 2,
    KSPROPERTY_DIRECTSOUND3DBUFFER_CONEANGLES = 3,
    KSPROPERTY_DIRECTSOUND3DBUFFER_CONEORIENTATION = 4,
    KSPROPERTY_DIRECTSOUND3DBUFFER_CONEOUTSIDEVOLUME = 5,
    KSPROPERTY_DIRECTSOUND3DBUFFER_MINDISTANCE = 6,
    KSPROPERTY_DIRECTSOUND3DBUFFER_MAXDISTANCE = 7,
    KSPROPERTY_DIRECTSOUND3DBUFFER_MODE = 8,
}

struct KSDS3D_BUFFER_ALL
{
    DS3DVECTOR Position;
    DS3DVECTOR Velocity;
    uint InsideConeAngle;
    uint OutsideConeAngle;
    DS3DVECTOR ConeOrientation;
    int ConeOutsideVolume;
    float MinDistance;
    float MaxDistance;
    uint Mode;
}

struct KSDS3D_BUFFER_CONE_ANGLES
{
    uint InsideConeAngle;
    uint OutsideConeAngle;
}

struct KSDS3D_HRTF_PARAMS_MSG
{
    uint Size;
    uint Enabled;
    BOOL SwapChannels;
    BOOL ZeroAzimuth;
    BOOL CrossFadeOutput;
    uint FilterSize;
}

enum KSDS3D_HRTF_FILTER_QUALITY
{
    FULL_FILTER = 0,
    LIGHT_FILTER = 1,
    KSDS3D_FILTER_QUALITY_COUNT = 2,
}

struct KSDS3D_HRTF_INIT_MSG
{
    uint Size;
    KSDS3D_HRTF_FILTER_QUALITY Quality;
    float SampleRate;
    uint MaxFilterSize;
    uint FilterTransientMuteLength;
    uint FilterOverlapBufferLength;
    uint OutputOverlapBufferLength;
    uint Reserved;
}

enum KSDS3D_HRTF_COEFF_FORMAT
{
    FLOAT_COEFF = 0,
    SHORT_COEFF = 1,
    KSDS3D_COEFF_COUNT = 2,
}

enum KSDS3D_HRTF_FILTER_METHOD
{
    DIRECT_FORM = 0,
    CASCADE_FORM = 1,
    KSDS3D_FILTER_METHOD_COUNT = 2,
}

enum KSDS3D_HRTF_FILTER_VERSION
{
    DS3D_HRTF_VERSION_1 = 0,
}

struct KSDS3D_HRTF_FILTER_FORMAT_MSG
{
    KSDS3D_HRTF_FILTER_METHOD FilterMethod;
    KSDS3D_HRTF_COEFF_FORMAT CoeffFormat;
    KSDS3D_HRTF_FILTER_VERSION Version;
    uint Reserved;
}

const GUID CLSID_KSPROPSETID_Hrtf3d = {0xB66DECB0, 0xA083, 0x11D0, [0x85, 0x1E, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]};
@GUID(0xB66DECB0, 0xA083, 0x11D0, [0x85, 0x1E, 0x00, 0xC0, 0x4F, 0xD9, 0xBA, 0xF3]);
struct KSPROPSETID_Hrtf3d;

enum KSPROPERTY_HRTF3D
{
    KSPROPERTY_HRTF3D_PARAMS = 0,
    KSPROPERTY_HRTF3D_INITIALIZE = 1,
    KSPROPERTY_HRTF3D_FILTER_FORMAT = 2,
}

struct KSDS3D_ITD_PARAMS
{
    int Channel;
    float VolSmoothScale;
    float TotalDryAttenuation;
    float TotalWetAttenuation;
    int SmoothFrequency;
    int Delay;
}

struct KSDS3D_ITD_PARAMS_MSG
{
    uint Enabled;
    KSDS3D_ITD_PARAMS LeftParams;
    KSDS3D_ITD_PARAMS RightParams;
    uint Reserved;
}

const GUID CLSID_KSPROPSETID_Itd3d = {0x6429F090, 0x9FD9, 0x11D0, [0xA7, 0x5B, 0x00, 0xA0, 0xC9, 0x03, 0x65, 0xE3]};
@GUID(0x6429F090, 0x9FD9, 0x11D0, [0xA7, 0x5B, 0x00, 0xA0, 0xC9, 0x03, 0x65, 0xE3]);
struct KSPROPSETID_Itd3d;

enum KSPROPERTY_ITD3D
{
    KSPROPERTY_ITD3D_PARAMS = 0,
}

struct KSDATARANGE_AUDIO
{
    KSDATAFORMAT DataRange;
    uint MaximumChannels;
    uint MinimumBitsPerSample;
    uint MaximumBitsPerSample;
    uint MinimumSampleFrequency;
    uint MaximumSampleFrequency;
}

const GUID CLSID_KSDATAFORMAT_SUBTYPE_RIFF = {0x4995DAEE, 0x9EE6, 0x11D0, [0xA4, 0x0E, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x4995DAEE, 0x9EE6, 0x11D0, [0xA4, 0x0E, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSDATAFORMAT_SUBTYPE_RIFF;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_RIFFWAVE = {0xE436EB8B, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EB8B, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct KSDATAFORMAT_SUBTYPE_RIFFWAVE;

const GUID CLSID_KSPROPSETID_Bibliographic = {0x07BA150E, 0xE2B1, 0x11D0, [0xAC, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x07BA150E, 0xE2B1, 0x11D0, [0xAC, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSPROPSETID_Bibliographic;

enum KSPROPERTY_BIBLIOGRAPHIC
{
    KSPROPERTY_BIBLIOGRAPHIC_LEADER = 1380207648,
    KSPROPERTY_BIBLIOGRAPHIC_LCCN = 808529952,
    KSPROPERTY_BIBLIOGRAPHIC_ISBN = 808595488,
    KSPROPERTY_BIBLIOGRAPHIC_ISSN = 842149920,
    KSPROPERTY_BIBLIOGRAPHIC_CATALOGINGSOURCE = 808726560,
    KSPROPERTY_BIBLIOGRAPHIC_MAINPERSONALNAME = 808464672,
    KSPROPERTY_BIBLIOGRAPHIC_MAINCORPORATEBODY = 808530208,
    KSPROPERTY_BIBLIOGRAPHIC_MAINMEETINGNAME = 825307424,
    KSPROPERTY_BIBLIOGRAPHIC_MAINUNIFORMTITLE = 808661280,
    KSPROPERTY_BIBLIOGRAPHIC_UNIFORMTITLE = 808727072,
    KSPROPERTY_BIBLIOGRAPHIC_TITLESTATEMENT = 892613152,
    KSPROPERTY_BIBLIOGRAPHIC_VARYINGFORMTITLE = 909390368,
    KSPROPERTY_BIBLIOGRAPHIC_PUBLICATION = 808858144,
    KSPROPERTY_BIBLIOGRAPHIC_PHYSICALDESCRIPTION = 808465184,
    KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYTITLE = 808727584,
    KSPROPERTY_BIBLIOGRAPHIC_SERIESSTATEMENT = 809055264,
    KSPROPERTY_BIBLIOGRAPHIC_GENERALNOTE = 808465696,
    KSPROPERTY_BIBLIOGRAPHIC_BIBLIOGRAPHYNOTE = 875574560,
    KSPROPERTY_BIBLIOGRAPHIC_CONTENTSNOTE = 892351776,
    KSPROPERTY_BIBLIOGRAPHIC_CREATIONCREDIT = 942683424,
    KSPROPERTY_BIBLIOGRAPHIC_CITATION = 808531232,
    KSPROPERTY_BIBLIOGRAPHIC_PARTICIPANT = 825308448,
    KSPROPERTY_BIBLIOGRAPHIC_SUMMARY = 808596768,
    KSPROPERTY_BIBLIOGRAPHIC_TARGETAUDIENCE = 825373984,
    KSPROPERTY_BIBLIOGRAPHIC_ADDEDFORMAVAILABLE = 808662304,
    KSPROPERTY_BIBLIOGRAPHIC_SYSTEMDETAILS = 942880032,
    KSPROPERTY_BIBLIOGRAPHIC_AWARDS = 909653280,
    KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYPERSONALNAME = 808465952,
    KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYTOPICALTERM = 808793632,
    KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYGEOGRAPHIC = 825570848,
    KSPROPERTY_BIBLIOGRAPHIC_INDEXTERMGENRE = 892679712,
    KSPROPERTY_BIBLIOGRAPHIC_INDEXTERMCURRICULUM = 943011360,
    KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYUNIFORMTITLE = 808662816,
    KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYRELATED = 808728352,
    KSPROPERTY_BIBLIOGRAPHIC_SERIESSTATEMENTPERSONALNAME = 808466464,
    KSPROPERTY_BIBLIOGRAPHIC_SERIESSTATEMENTUNIFORMTITLE = 808663072,
}

const GUID CLSID_KSPROPSETID_TopologyNode = {0x45FFAAA1, 0x6E1B, 0x11D0, [0xBC, 0xF2, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x45FFAAA1, 0x6E1B, 0x11D0, [0xBC, 0xF2, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct KSPROPSETID_TopologyNode;

enum KSPROPERTY_TOPOLOGYNODE
{
    KSPROPERTY_TOPOLOGYNODE_ENABLE = 1,
    KSPROPERTY_TOPOLOGYNODE_RESET = 2,
}

const GUID CLSID_KSPROPSETID_RtAudio = {0xA855A48C, 0x2F78, 0x4729, [0x90, 0x51, 0x19, 0x68, 0x74, 0x6B, 0x9E, 0xEF]};
@GUID(0xA855A48C, 0x2F78, 0x4729, [0x90, 0x51, 0x19, 0x68, 0x74, 0x6B, 0x9E, 0xEF]);
struct KSPROPSETID_RtAudio;

enum KSPROPERTY_RTAUDIO
{
    KSPROPERTY_RTAUDIO_GETPOSITIONFUNCTION = 0,
    KSPROPERTY_RTAUDIO_BUFFER = 1,
    KSPROPERTY_RTAUDIO_HWLATENCY = 2,
    KSPROPERTY_RTAUDIO_POSITIONREGISTER = 3,
    KSPROPERTY_RTAUDIO_CLOCKREGISTER = 4,
    KSPROPERTY_RTAUDIO_BUFFER_WITH_NOTIFICATION = 5,
    KSPROPERTY_RTAUDIO_REGISTER_NOTIFICATION_EVENT = 6,
    KSPROPERTY_RTAUDIO_UNREGISTER_NOTIFICATION_EVENT = 7,
    KSPROPERTY_RTAUDIO_QUERY_NOTIFICATION_SUPPORT = 8,
    KSPROPERTY_RTAUDIO_PACKETCOUNT = 9,
    KSPROPERTY_RTAUDIO_PRESENTATION_POSITION = 10,
    KSPROPERTY_RTAUDIO_GETREADPACKET = 11,
    KSPROPERTY_RTAUDIO_SETWRITEPACKET = 12,
    KSPROPERTY_RTAUDIO_PACKETVREGISTER = 13,
}

struct KSRTAUDIO_BUFFER_PROPERTY
{
    KSIDENTIFIER Property;
    void* BaseAddress;
    uint RequestedBufferSize;
}

struct KSRTAUDIO_BUFFER_PROPERTY32
{
    KSIDENTIFIER Property;
    uint BaseAddress;
    uint RequestedBufferSize;
}

struct KSRTAUDIO_BUFFER_PROPERTY_WITH_NOTIFICATION
{
    KSIDENTIFIER Property;
    void* BaseAddress;
    uint RequestedBufferSize;
    uint NotificationCount;
}

struct KSRTAUDIO_BUFFER_PROPERTY_WITH_NOTIFICATION32
{
    KSIDENTIFIER Property;
    uint BaseAddress;
    uint RequestedBufferSize;
    uint NotificationCount;
}

struct KSRTAUDIO_BUFFER
{
    void* BufferAddress;
    uint ActualBufferSize;
    BOOL CallMemoryBarrier;
}

struct KSRTAUDIO_BUFFER32
{
    uint BufferAddress;
    uint ActualBufferSize;
    BOOL CallMemoryBarrier;
}

struct KSRTAUDIO_HWLATENCY
{
    uint FifoSize;
    uint ChipsetDelay;
    uint CodecDelay;
}

struct KSRTAUDIO_HWREGISTER_PROPERTY
{
    KSIDENTIFIER Property;
    void* BaseAddress;
}

struct KSRTAUDIO_HWREGISTER_PROPERTY32
{
    KSIDENTIFIER Property;
    uint BaseAddress;
}

struct KSRTAUDIO_HWREGISTER
{
    void* Register;
    uint Width;
    ulong Numerator;
    ulong Denominator;
    uint Accuracy;
}

struct KSRTAUDIO_HWREGISTER32
{
    uint Register;
    uint Width;
    ulong Numerator;
    ulong Denominator;
    uint Accuracy;
}

struct KSRTAUDIO_NOTIFICATION_EVENT_PROPERTY
{
    KSIDENTIFIER Property;
    HANDLE NotificationEvent;
}

struct KSRTAUDIO_NOTIFICATION_EVENT_PROPERTY32
{
    KSIDENTIFIER Property;
    uint NotificationEvent;
}

struct KSRTAUDIO_GETREADPACKET_INFO
{
    uint PacketNumber;
    uint Flags;
    ulong PerformanceCounterValue;
    BOOL MoreData;
}

struct KSRTAUDIO_SETWRITEPACKET_INFO
{
    uint PacketNumber;
    uint Flags;
    uint EosPacketLength;
}

struct KSRTAUDIO_PACKETVREGISTER_PROPERTY
{
    KSIDENTIFIER Property;
    void* BaseAddress;
}

struct KSRTAUDIO_PACKETVREGISTER
{
    ulong* CompletedPacketCount;
    ulong* CompletedPacketQPC;
    ulong* CompletedPacketHash;
}

const GUID CLSID_KSPROPSETID_BtAudio = {0x7FA06C40, 0xB8F6, 0x4C7E, [0x85, 0x56, 0xE8, 0xC3, 0x3A, 0x12, 0xE5, 0x4D]};
@GUID(0x7FA06C40, 0xB8F6, 0x4C7E, [0x85, 0x56, 0xE8, 0xC3, 0x3A, 0x12, 0xE5, 0x4D]);
struct KSPROPSETID_BtAudio;

enum KSPROPERTY_BTAUDIO
{
    KSPROPERTY_ONESHOT_RECONNECT = 0,
    KSPROPERTY_ONESHOT_DISCONNECT = 1,
}

const GUID CLSID_KSPROPSETID_DrmAudioStream = {0x2F2C8DDD, 0x4198, 0x4FAC, [0xBA, 0x29, 0x61, 0xBB, 0x05, 0xB7, 0xDE, 0x06]};
@GUID(0x2F2C8DDD, 0x4198, 0x4FAC, [0xBA, 0x29, 0x61, 0xBB, 0x05, 0xB7, 0xDE, 0x06]);
struct KSPROPSETID_DrmAudioStream;

enum KSPROPERTY_DRMAUDIOSTREAM
{
    KSPROPERTY_DRMAUDIOSTREAM_CONTENTID = 0,
}

const GUID CLSID_KSPROPSETID_SoundDetector = {0x113C425E, 0xFD17, 0x4057, [0xB4, 0x22, 0xED, 0x40, 0x74, 0xF1, 0xAF, 0xDF]};
@GUID(0x113C425E, 0xFD17, 0x4057, [0xB4, 0x22, 0xED, 0x40, 0x74, 0xF1, 0xAF, 0xDF]);
struct KSPROPSETID_SoundDetector;

const GUID CLSID_KSPROPSETID_SoundDetector2 = {0xFE07E322, 0x450C, 0x4BD5, [0x84, 0xCA, 0xA9, 0x48, 0x50, 0x0E, 0xA6, 0xAA]};
@GUID(0xFE07E322, 0x450C, 0x4BD5, [0x84, 0xCA, 0xA9, 0x48, 0x50, 0x0E, 0xA6, 0xAA]);
struct KSPROPSETID_SoundDetector2;

const GUID CLSID_KSPROPSETID_InterleavedAudio = {0xE9EBE550, 0xD619, 0x4C0A, [0x97, 0x6B, 0x70, 0x62, 0x32, 0x2B, 0x30, 0x06]};
@GUID(0xE9EBE550, 0xD619, 0x4C0A, [0x97, 0x6B, 0x70, 0x62, 0x32, 0x2B, 0x30, 0x06]);
struct KSPROPSETID_InterleavedAudio;

enum KSPROPERTY_INTERLEAVEDAUDIO
{
    KSPROPERTY_INTERLEAVEDAUDIO_FORMATINFORMATION = 1,
}

struct INTERLEAVED_AUDIO_FORMAT_INFORMATION
{
    uint Size;
    uint PrimaryChannelCount;
    uint PrimaryChannelStartPosition;
    uint PrimaryChannelMask;
    uint InterleavedChannelCount;
    uint InterleavedChannelStartPosition;
    uint InterleavedChannelMask;
}

struct KSSOUNDDETECTORPROPERTY
{
    KSIDENTIFIER Property;
    Guid EventId;
}

enum KSPROPERTY_SOUNDDETECTOR
{
    KSPROPERTY_SOUNDDETECTOR_SUPPORTEDPATTERNS = 1,
    KSPROPERTY_SOUNDDETECTOR_PATTERNS = 2,
    KSPROPERTY_SOUNDDETECTOR_ARMED = 3,
    KSPROPERTY_SOUNDDETECTOR_MATCHRESULT = 4,
    KSPROPERTY_SOUNDDETECTOR_RESET = 5,
    KSPROPERTY_SOUNDDETECTOR_STREAMINGSUPPORT = 6,
}

struct SOUNDDETECTOR_PATTERNHEADER
{
    uint Size;
    Guid PatternType;
}

const GUID CLSID_KSEVENTSETID_SoundDetector = {0x69785C9B, 0xFC2D, 0x49D6, [0xAC, 0x32, 0x47, 0x99, 0xF8, 0x7D, 0xE9, 0xF6]};
@GUID(0x69785C9B, 0xFC2D, 0x49D6, [0xAC, 0x32, 0x47, 0x99, 0xF8, 0x7D, 0xE9, 0xF6]);
struct KSEVENTSETID_SoundDetector;

enum KSEVENT_SOUNDDETECTOR
{
    KSEVENT_SOUNDDETECTOR_MATCHDETECTED = 1,
}

const GUID CLSID_KSNOTIFICATIONID_SoundDetector = {0x6389D844, 0xBB32, 0x4C4C, [0xA8, 0x02, 0xF4, 0xB4, 0xB7, 0x7A, 0xFE, 0xAD]};
@GUID(0x6389D844, 0xBB32, 0x4C4C, [0xA8, 0x02, 0xF4, 0xB4, 0xB7, 0x7A, 0xFE, 0xAD]);
struct KSNOTIFICATIONID_SoundDetector;

const GUID CLSID_KSPROPSETID_Audio = {0x45FFAAA0, 0x6E1B, 0x11D0, [0xBC, 0xF2, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x45FFAAA0, 0x6E1B, 0x11D0, [0xBC, 0xF2, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct KSPROPSETID_Audio;

enum KSPROPERTY_AUDIO
{
    KSPROPERTY_AUDIO_LATENCY = 1,
    KSPROPERTY_AUDIO_COPY_PROTECTION = 2,
    KSPROPERTY_AUDIO_CHANNEL_CONFIG = 3,
    KSPROPERTY_AUDIO_VOLUMELEVEL = 4,
    KSPROPERTY_AUDIO_POSITION = 5,
    KSPROPERTY_AUDIO_DYNAMIC_RANGE = 6,
    KSPROPERTY_AUDIO_QUALITY = 7,
    KSPROPERTY_AUDIO_SAMPLING_RATE = 8,
    KSPROPERTY_AUDIO_DYNAMIC_SAMPLING_RATE = 9,
    KSPROPERTY_AUDIO_MIX_LEVEL_TABLE = 10,
    KSPROPERTY_AUDIO_MIX_LEVEL_CAPS = 11,
    KSPROPERTY_AUDIO_MUX_SOURCE = 12,
    KSPROPERTY_AUDIO_MUTE = 13,
    KSPROPERTY_AUDIO_BASS = 14,
    KSPROPERTY_AUDIO_MID = 15,
    KSPROPERTY_AUDIO_TREBLE = 16,
    KSPROPERTY_AUDIO_BASS_BOOST = 17,
    KSPROPERTY_AUDIO_EQ_LEVEL = 18,
    KSPROPERTY_AUDIO_NUM_EQ_BANDS = 19,
    KSPROPERTY_AUDIO_EQ_BANDS = 20,
    KSPROPERTY_AUDIO_AGC = 21,
    KSPROPERTY_AUDIO_DELAY = 22,
    KSPROPERTY_AUDIO_LOUDNESS = 23,
    KSPROPERTY_AUDIO_WIDE_MODE = 24,
    KSPROPERTY_AUDIO_WIDENESS = 25,
    KSPROPERTY_AUDIO_REVERB_LEVEL = 26,
    KSPROPERTY_AUDIO_CHORUS_LEVEL = 27,
    KSPROPERTY_AUDIO_DEV_SPECIFIC = 28,
    KSPROPERTY_AUDIO_DEMUX_DEST = 29,
    KSPROPERTY_AUDIO_STEREO_ENHANCE = 30,
    KSPROPERTY_AUDIO_MANUFACTURE_GUID = 31,
    KSPROPERTY_AUDIO_PRODUCT_GUID = 32,
    KSPROPERTY_AUDIO_CPU_RESOURCES = 33,
    KSPROPERTY_AUDIO_STEREO_SPEAKER_GEOMETRY = 34,
    KSPROPERTY_AUDIO_SURROUND_ENCODE = 35,
    KSPROPERTY_AUDIO_3D_INTERFACE = 36,
    KSPROPERTY_AUDIO_PEAKMETER = 37,
    KSPROPERTY_AUDIO_ALGORITHM_INSTANCE = 38,
    KSPROPERTY_AUDIO_FILTER_STATE = 39,
    KSPROPERTY_AUDIO_PREFERRED_STATUS = 40,
    KSPROPERTY_AUDIO_PEQ_MAX_BANDS = 41,
    KSPROPERTY_AUDIO_PEQ_NUM_BANDS = 42,
    KSPROPERTY_AUDIO_PEQ_BAND_CENTER_FREQ = 43,
    KSPROPERTY_AUDIO_PEQ_BAND_Q_FACTOR = 44,
    KSPROPERTY_AUDIO_PEQ_BAND_LEVEL = 45,
    KSPROPERTY_AUDIO_CHORUS_MODULATION_RATE = 46,
    KSPROPERTY_AUDIO_CHORUS_MODULATION_DEPTH = 47,
    KSPROPERTY_AUDIO_REVERB_TIME = 48,
    KSPROPERTY_AUDIO_REVERB_DELAY_FEEDBACK = 49,
    KSPROPERTY_AUDIO_POSITIONEX = 50,
    KSPROPERTY_AUDIO_MIC_ARRAY_GEOMETRY = 51,
    KSPROPERTY_AUDIO_PRESENTATION_POSITION = 52,
    KSPROPERTY_AUDIO_WAVERT_CURRENT_WRITE_POSITION = 53,
    KSPROPERTY_AUDIO_LINEAR_BUFFER_POSITION = 54,
    KSPROPERTY_AUDIO_PEAKMETER2 = 55,
    KSPROPERTY_AUDIO_WAVERT_CURRENT_WRITE_LASTBUFFER_POSITION = 56,
    KSPROPERTY_AUDIO_VOLUMELIMIT_ENGAGED = 57,
    KSPROPERTY_AUDIO_MIC_SENSITIVITY = 58,
    KSPROPERTY_AUDIO_MIC_SNR = 59,
    KSPROPERTY_AUDIO_MIC_SENSITIVITY2 = 60,
}

struct KSAUDIO_COPY_PROTECTION
{
    BOOL fCopyrighted;
    BOOL fOriginal;
}

struct KSAUDIO_CHANNEL_CONFIG
{
    int ActiveSpeakerPositions;
}

struct KSAUDIO_DYNAMIC_RANGE
{
    uint QuietCompression;
    uint LoudCompression;
}

struct KSAUDIO_MIXLEVEL
{
    BOOL Mute;
    int Level;
}

struct KSAUDIO_MIX_CAPS
{
    BOOL Mute;
    int Minimum;
    int Maximum;
    _Anonymous_e__Union Anonymous;
}

struct KSAUDIO_MIXCAP_TABLE
{
    uint InputChannels;
    uint OutputChannels;
    KSAUDIO_MIX_CAPS Capabilities;
}

struct KSAUDIO_POSITIONEX
{
    LARGE_INTEGER TimerFrequency;
    LARGE_INTEGER TimeStamp1;
    KSAUDIO_POSITION Position;
    LARGE_INTEGER TimeStamp2;
}

const GUID CLSID_KSPROPSETID_TelephonyControl = {0xB6DF7EB1, 0xD099, 0x489F, [0xA6, 0xA0, 0xC0, 0x10, 0x6F, 0x08, 0x87, 0xA7]};
@GUID(0xB6DF7EB1, 0xD099, 0x489F, [0xA6, 0xA0, 0xC0, 0x10, 0x6F, 0x08, 0x87, 0xA7]);
struct KSPROPSETID_TelephonyControl;

enum KSPROPERTY_TELEPHONY_CONTROL
{
    KSPROPERTY_TELEPHONY_PROVIDERID = 0,
    KSPROPERTY_TELEPHONY_CALLINFO = 1,
    KSPROPERTY_TELEPHONY_CALLCONTROL = 2,
    KSPROPERTY_TELEPHONY_PROVIDERCHANGE = 3,
    KSPROPERTY_TELEPHONY_CALLHOLD = 4,
    KSPROPERTY_TELEPHONY_MUTE_TX = 5,
}

enum TELEPHONY_CALLTYPE
{
    TELEPHONY_CALLTYPE_CIRCUITSWITCHED = 0,
    TELEPHONY_CALLTYPE_PACKETSWITCHED_LTE = 1,
    TELEPHONY_CALLTYPE_PACKETSWITCHED_WLAN = 2,
}

enum TELEPHONY_CALLCONTROLOP
{
    TELEPHONY_CALLCONTROLOP_DISABLE = 0,
    TELEPHONY_CALLCONTROLOP_ENABLE = 1,
}

struct KSTELEPHONY_CALLCONTROL
{
    TELEPHONY_CALLTYPE CallType;
    TELEPHONY_CALLCONTROLOP CallControlOp;
}

enum TELEPHONY_PROVIDERCHANGEOP
{
    TELEPHONY_PROVIDERCHANGEOP_END = 0,
    TELEPHONY_PROVIDERCHANGEOP_BEGIN = 1,
    TELEPHONY_PROVIDERCHANGEOP_CANCEL = 2,
}

struct KSTELEPHONY_PROVIDERCHANGE
{
    TELEPHONY_CALLTYPE CallType;
    TELEPHONY_PROVIDERCHANGEOP ProviderChangeOp;
}

enum TELEPHONY_CALLSTATE
{
    TELEPHONY_CALLSTATE_DISABLED = 0,
    TELEPHONY_CALLSTATE_ENABLED = 1,
    TELEPHONY_CALLSTATE_HOLD = 2,
    TELEPHONY_CALLSTATE_PROVIDERTRANSITION = 3,
}

struct KSTELEPHONY_CALLINFO
{
    TELEPHONY_CALLTYPE CallType;
    TELEPHONY_CALLSTATE CallState;
}

const GUID CLSID_KSPROPSETID_TelephonyTopology = {0xABF25C7E, 0x0E64, 0x4E32, [0xB1, 0x90, 0xD0, 0xF6, 0xD7, 0xC5, 0x3E, 0x97]};
@GUID(0xABF25C7E, 0x0E64, 0x4E32, [0xB1, 0x90, 0xD0, 0xF6, 0xD7, 0xC5, 0x3E, 0x97]);
struct KSPROPSETID_TelephonyTopology;

enum KSPROPERTY_TELEPHONY_TOPOLOGY
{
    KSPROPERTY_TELEPHONY_ENDPOINTIDPAIR = 0,
    KSPROPERTY_TELEPHONY_VOLUME = 1,
}

struct KSTOPOLOGY_ENDPOINTID
{
    ushort TopologyName;
    uint PinId;
}

struct KSTOPOLOGY_ENDPOINTIDPAIR
{
    KSTOPOLOGY_ENDPOINTID RenderEndpoint;
    KSTOPOLOGY_ENDPOINTID CaptureEndpoint;
}

const GUID CLSID_KSPROPSETID_FMRXTopology = {0x0C46CE8F, 0xDC2D, 0x4204, [0x9D, 0xC9, 0xF5, 0x89, 0x63, 0x36, 0x65, 0x63]};
@GUID(0x0C46CE8F, 0xDC2D, 0x4204, [0x9D, 0xC9, 0xF5, 0x89, 0x63, 0x36, 0x65, 0x63]);
struct KSPROPSETID_FMRXTopology;

enum KSPROPERTY_FMRX_TOPOLOGY
{
    KSPROPERTY_FMRX_ENDPOINTID = 0,
    KSPROPERTY_FMRX_VOLUME = 1,
    KSPROPERTY_FMRX_ANTENNAENDPOINTID = 2,
}

const GUID CLSID_KSPROPSETID_FMRXControl = {0x947BBA3A, 0xE8EE, 0x4786, [0x90, 0xC4, 0x84, 0x28, 0x18, 0x5F, 0x05, 0xBE]};
@GUID(0x947BBA3A, 0xE8EE, 0x4786, [0x90, 0xC4, 0x84, 0x28, 0x18, 0x5F, 0x05, 0xBE]);
struct KSPROPSETID_FMRXControl;

enum KSPROPERTY_FMRX_CONTROL
{
    KSPROPERTY_FMRX_STATE = 0,
}

const GUID CLSID_KSEVENTSETID_Telephony = {0xB77F12B4, 0xCEB4, 0x4484, [0x8D, 0x5E, 0x52, 0xC1, 0xE7, 0xD8, 0x76, 0x2D]};
@GUID(0xB77F12B4, 0xCEB4, 0x4484, [0x8D, 0x5E, 0x52, 0xC1, 0xE7, 0xD8, 0x76, 0x2D]);
struct KSEVENTSETID_Telephony;

enum KSEVENT_TELEPHONY
{
    KSEVENT_TELEPHONY_ENDPOINTPAIRS_CHANGED = 0,
}

const GUID CLSID_KSNODETYPE_DAC = {0x507AE360, 0xC554, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x507AE360, 0xC554, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_DAC;

const GUID CLSID_KSNODETYPE_ADC = {0x4D837FE0, 0xC555, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x4D837FE0, 0xC555, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_ADC;

const GUID CLSID_KSNODETYPE_SRC = {0x9DB7B9E0, 0xC555, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x9DB7B9E0, 0xC555, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_SRC;

const GUID CLSID_KSNODETYPE_SUPERMIX = {0xE573ADC0, 0xC555, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0xE573ADC0, 0xC555, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_SUPERMIX;

const GUID CLSID_KSNODETYPE_MUX = {0x2CEAF780, 0xC556, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x2CEAF780, 0xC556, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_MUX;

const GUID CLSID_KSNODETYPE_DEMUX = {0xC0EB67D4, 0xE807, 0x11D0, [0x95, 0x8A, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0xC0EB67D4, 0xE807, 0x11D0, [0x95, 0x8A, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSNODETYPE_DEMUX;

const GUID CLSID_KSNODETYPE_SUM = {0xDA441A60, 0xC556, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0xDA441A60, 0xC556, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_SUM;

const GUID CLSID_KSNODETYPE_MUTE = {0x02B223C0, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x02B223C0, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_MUTE;

const GUID CLSID_KSNODETYPE_VOLUME = {0x3A5ACC00, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x3A5ACC00, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_VOLUME;

const GUID CLSID_KSNODETYPE_TONE = {0x7607E580, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x7607E580, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_TONE;

const GUID CLSID_KSNODETYPE_EQUALIZER = {0x9D41B4A0, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x9D41B4A0, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_EQUALIZER;

const GUID CLSID_KSNODETYPE_AGC = {0xE88C9BA0, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0xE88C9BA0, 0xC557, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_AGC;

const GUID CLSID_KSNODETYPE_NOISE_SUPPRESS = {0xE07F903F, 0x62FD, 0x4E60, [0x8C, 0xDD, 0xDE, 0xA7, 0x23, 0x66, 0x65, 0xB5]};
@GUID(0xE07F903F, 0x62FD, 0x4E60, [0x8C, 0xDD, 0xDE, 0xA7, 0x23, 0x66, 0x65, 0xB5]);
struct KSNODETYPE_NOISE_SUPPRESS;

const GUID CLSID_KSNODETYPE_DELAY = {0x144981E0, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x144981E0, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_DELAY;

const GUID CLSID_KSNODETYPE_LOUDNESS = {0x41887440, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x41887440, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_LOUDNESS;

const GUID CLSID_KSNODETYPE_PROLOGIC_DECODER = {0x831C2C80, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x831C2C80, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_PROLOGIC_DECODER;

const GUID CLSID_KSNODETYPE_STEREO_WIDE = {0xA9E69800, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0xA9E69800, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_STEREO_WIDE;

const GUID CLSID_KSNODETYPE_REVERB = {0xEF0328E0, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0xEF0328E0, 0xC558, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_REVERB;

const GUID CLSID_KSNODETYPE_CHORUS = {0x20173F20, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x20173F20, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_CHORUS;

const GUID CLSID_KSNODETYPE_3D_EFFECTS = {0x55515860, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x55515860, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_3D_EFFECTS;

const GUID CLSID_KSNODETYPE_PARAMETRIC_EQUALIZER = {0x19BB3A6A, 0xCE2B, 0x4442, [0x87, 0xEC, 0x67, 0x27, 0xC3, 0xCA, 0xB4, 0x77]};
@GUID(0x19BB3A6A, 0xCE2B, 0x4442, [0x87, 0xEC, 0x67, 0x27, 0xC3, 0xCA, 0xB4, 0x77]);
struct KSNODETYPE_PARAMETRIC_EQUALIZER;

const GUID CLSID_KSNODETYPE_UPDOWN_MIX = {0xB7EDC5CF, 0x7B63, 0x4EE2, [0xA1, 0x00, 0x29, 0xEE, 0x2C, 0xB6, 0xB2, 0xDE]};
@GUID(0xB7EDC5CF, 0x7B63, 0x4EE2, [0xA1, 0x00, 0x29, 0xEE, 0x2C, 0xB6, 0xB2, 0xDE]);
struct KSNODETYPE_UPDOWN_MIX;

const GUID CLSID_KSNODETYPE_DYN_RANGE_COMPRESSOR = {0x08C8A6A8, 0x601F, 0x4AF8, [0x87, 0x93, 0xD9, 0x05, 0xFF, 0x4C, 0xA9, 0x7D]};
@GUID(0x08C8A6A8, 0x601F, 0x4AF8, [0x87, 0x93, 0xD9, 0x05, 0xFF, 0x4C, 0xA9, 0x7D]);
struct KSNODETYPE_DYN_RANGE_COMPRESSOR;

const GUID CLSID_KSALGORITHMINSTANCE_SYSTEM_ACOUSTIC_ECHO_CANCEL = {0x1C22C56D, 0x9879, 0x4F5B, [0xA3, 0x89, 0x27, 0x99, 0x6D, 0xDC, 0x28, 0x10]};
@GUID(0x1C22C56D, 0x9879, 0x4F5B, [0xA3, 0x89, 0x27, 0x99, 0x6D, 0xDC, 0x28, 0x10]);
struct KSALGORITHMINSTANCE_SYSTEM_ACOUSTIC_ECHO_CANCEL;

const GUID CLSID_KSALGORITHMINSTANCE_SYSTEM_NOISE_SUPPRESS = {0x5AB0882E, 0x7274, 0x4516, [0x87, 0x7D, 0x4E, 0xEE, 0x99, 0xBA, 0x4F, 0xD0]};
@GUID(0x5AB0882E, 0x7274, 0x4516, [0x87, 0x7D, 0x4E, 0xEE, 0x99, 0xBA, 0x4F, 0xD0]);
struct KSALGORITHMINSTANCE_SYSTEM_NOISE_SUPPRESS;

const GUID CLSID_KSALGORITHMINSTANCE_SYSTEM_AGC = {0x950E55B9, 0x877C, 0x4C67, [0xBE, 0x08, 0xE4, 0x7B, 0x56, 0x11, 0x13, 0x0A]};
@GUID(0x950E55B9, 0x877C, 0x4C67, [0xBE, 0x08, 0xE4, 0x7B, 0x56, 0x11, 0x13, 0x0A]);
struct KSALGORITHMINSTANCE_SYSTEM_AGC;

const GUID CLSID_KSALGORITHMINSTANCE_SYSTEM_MICROPHONE_ARRAY_PROCESSOR = {0xB6F5A0A0, 0x9E61, 0x4F8C, [0x91, 0xE3, 0x76, 0xCF, 0x0F, 0x3C, 0x47, 0x1F]};
@GUID(0xB6F5A0A0, 0x9E61, 0x4F8C, [0x91, 0xE3, 0x76, 0xCF, 0x0F, 0x3C, 0x47, 0x1F]);
struct KSALGORITHMINSTANCE_SYSTEM_MICROPHONE_ARRAY_PROCESSOR;

const GUID CLSID_KSNODETYPE_DEV_SPECIFIC = {0x941C7AC0, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]};
@GUID(0x941C7AC0, 0xC559, 0x11D0, [0x8A, 0x2B, 0x00, 0xA0, 0xC9, 0x25, 0x5A, 0xC1]);
struct KSNODETYPE_DEV_SPECIFIC;

const GUID CLSID_KSNODETYPE_PROLOGIC_ENCODER = {0x8074C5B2, 0x3C66, 0x11D2, [0xB4, 0x5A, 0x30, 0x78, 0x30, 0x2C, 0x20, 0x30]};
@GUID(0x8074C5B2, 0x3C66, 0x11D2, [0xB4, 0x5A, 0x30, 0x78, 0x30, 0x2C, 0x20, 0x30]);
struct KSNODETYPE_PROLOGIC_ENCODER;

const GUID CLSID_KSNODETYPE_PEAKMETER = {0xA085651E, 0x5F0D, 0x4B36, [0xA8, 0x69, 0xD1, 0x95, 0xD6, 0xAB, 0x4B, 0x9E]};
@GUID(0xA085651E, 0x5F0D, 0x4B36, [0xA8, 0x69, 0xD1, 0x95, 0xD6, 0xAB, 0x4B, 0x9E]);
struct KSNODETYPE_PEAKMETER;

const GUID CLSID_KSAUDFNAME_BASS = {0x185FEDE0, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE0, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_BASS;

const GUID CLSID_KSAUDFNAME_TREBLE = {0x185FEDE1, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE1, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_TREBLE;

const GUID CLSID_KSAUDFNAME_MIDRANGE = {0xA2CBE478, 0xAE84, 0x49A1, [0x8B, 0x72, 0x4A, 0xD0, 0x9B, 0x78, 0xED, 0x34]};
@GUID(0xA2CBE478, 0xAE84, 0x49A1, [0x8B, 0x72, 0x4A, 0xD0, 0x9B, 0x78, 0xED, 0x34]);
struct KSAUDFNAME_MIDRANGE;

const GUID CLSID_KSAUDFNAME_3D_STEREO = {0x185FEDE2, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE2, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_3D_STEREO;

const GUID CLSID_KSAUDFNAME_MASTER_VOLUME = {0x185FEDE3, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE3, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MASTER_VOLUME;

const GUID CLSID_KSAUDFNAME_MASTER_MUTE = {0x185FEDE4, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE4, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MASTER_MUTE;

const GUID CLSID_KSAUDFNAME_WAVE_VOLUME = {0x185FEDE5, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE5, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_WAVE_VOLUME;

const GUID CLSID_KSAUDFNAME_WAVE_MUTE = {0x185FEDE6, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE6, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_WAVE_MUTE;

const GUID CLSID_KSAUDFNAME_MIDI_VOLUME = {0x185FEDE7, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE7, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MIDI_VOLUME;

const GUID CLSID_KSAUDFNAME_MIDI_MUTE = {0x185FEDE8, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE8, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MIDI_MUTE;

const GUID CLSID_KSAUDFNAME_CD_VOLUME = {0x185FEDE9, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDE9, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_CD_VOLUME;

const GUID CLSID_KSAUDFNAME_CD_MUTE = {0x185FEDEA, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDEA, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_CD_MUTE;

const GUID CLSID_KSAUDFNAME_LINE_VOLUME = {0x185FEDEB, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDEB, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_LINE_VOLUME;

const GUID CLSID_KSAUDFNAME_LINE_MUTE = {0x185FEDEC, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDEC, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_LINE_MUTE;

const GUID CLSID_KSAUDFNAME_MIC_VOLUME = {0x185FEDED, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDED, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MIC_VOLUME;

const GUID CLSID_KSAUDFNAME_MIC_MUTE = {0x185FEDEE, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDEE, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MIC_MUTE;

const GUID CLSID_KSAUDFNAME_RECORDING_SOURCE = {0x185FEDEF, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDEF, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_RECORDING_SOURCE;

const GUID CLSID_KSAUDFNAME_PC_SPEAKER_VOLUME = {0x185FEDF0, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF0, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_PC_SPEAKER_VOLUME;

const GUID CLSID_KSAUDFNAME_PC_SPEAKER_MUTE = {0x185FEDF1, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF1, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_PC_SPEAKER_MUTE;

const GUID CLSID_KSAUDFNAME_MIDI_IN_VOLUME = {0x185FEDF2, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF2, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MIDI_IN_VOLUME;

const GUID CLSID_KSAUDFNAME_CD_IN_VOLUME = {0x185FEDF3, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF3, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_CD_IN_VOLUME;

const GUID CLSID_KSAUDFNAME_LINE_IN_VOLUME = {0x185FEDF4, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF4, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_LINE_IN_VOLUME;

const GUID CLSID_KSAUDFNAME_MIC_IN_VOLUME = {0x185FEDF5, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF5, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MIC_IN_VOLUME;

const GUID CLSID_KSAUDFNAME_WAVE_IN_VOLUME = {0x185FEDF6, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF6, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_WAVE_IN_VOLUME;

const GUID CLSID_KSAUDFNAME_VOLUME_CONTROL = {0x185FEDF7, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF7, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_VOLUME_CONTROL;

const GUID CLSID_KSAUDFNAME_MIDI = {0x185FEDF8, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF8, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_MIDI;

const GUID CLSID_KSAUDFNAME_LINE_IN = {0x185FEDF9, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDF9, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_LINE_IN;

const GUID CLSID_KSAUDFNAME_RECORDING_CONTROL = {0x185FEDFA, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDFA, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_RECORDING_CONTROL;

const GUID CLSID_KSAUDFNAME_CD_AUDIO = {0x185FEDFB, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDFB, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_CD_AUDIO;

const GUID CLSID_KSAUDFNAME_AUX_VOLUME = {0x185FEDFC, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDFC, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_AUX_VOLUME;

const GUID CLSID_KSAUDFNAME_AUX_MUTE = {0x185FEDFD, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDFD, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_AUX_MUTE;

const GUID CLSID_KSAUDFNAME_AUX = {0x185FEDFE, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDFE, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_AUX;

const GUID CLSID_KSAUDFNAME_PC_SPEAKER = {0x185FEDFF, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEDFF, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_PC_SPEAKER;

const GUID CLSID_KSAUDFNAME_WAVE_OUT_MIX = {0x185FEE00, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0x185FEE00, 0x9905, 0x11D1, [0x95, 0xA9, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSAUDFNAME_WAVE_OUT_MIX;

const GUID CLSID_KSAUDFNAME_MONO_OUT = {0xF9B41DC3, 0x96E2, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0xF9B41DC3, 0x96E2, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_MONO_OUT;

const GUID CLSID_KSAUDFNAME_STEREO_MIX = {0x00DFF077, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x00DFF077, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_STEREO_MIX;

const GUID CLSID_KSAUDFNAME_MONO_MIX = {0x00DFF078, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x00DFF078, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_MONO_MIX;

const GUID CLSID_KSAUDFNAME_MONO_OUT_VOLUME = {0x1AD247EB, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x1AD247EB, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_MONO_OUT_VOLUME;

const GUID CLSID_KSAUDFNAME_MONO_OUT_MUTE = {0x1AD247EC, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x1AD247EC, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_MONO_OUT_MUTE;

const GUID CLSID_KSAUDFNAME_STEREO_MIX_VOLUME = {0x1AD247ED, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x1AD247ED, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_STEREO_MIX_VOLUME;

const GUID CLSID_KSAUDFNAME_STEREO_MIX_MUTE = {0x22B0EAFD, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x22B0EAFD, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_STEREO_MIX_MUTE;

const GUID CLSID_KSAUDFNAME_MONO_MIX_VOLUME = {0x22B0EAFE, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x22B0EAFE, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_MONO_MIX_VOLUME;

const GUID CLSID_KSAUDFNAME_MONO_MIX_MUTE = {0x2BC31D69, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x2BC31D69, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_MONO_MIX_MUTE;

const GUID CLSID_KSAUDFNAME_MICROPHONE_BOOST = {0x2BC31D6A, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x2BC31D6A, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_MICROPHONE_BOOST;

const GUID CLSID_KSAUDFNAME_ALTERNATE_MICROPHONE = {0x2BC31D6B, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x2BC31D6B, 0x96E3, 0x11D2, [0xAC, 0x4C, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_ALTERNATE_MICROPHONE;

const GUID CLSID_KSAUDFNAME_3D_DEPTH = {0x63FF5747, 0x991F, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x63FF5747, 0x991F, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_3D_DEPTH;

const GUID CLSID_KSAUDFNAME_3D_CENTER = {0x9F0670B4, 0x991F, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x9F0670B4, 0x991F, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_3D_CENTER;

const GUID CLSID_KSAUDFNAME_VIDEO_VOLUME = {0x9B46E708, 0x992A, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x9B46E708, 0x992A, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_VIDEO_VOLUME;

const GUID CLSID_KSAUDFNAME_VIDEO_MUTE = {0x9B46E709, 0x992A, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x9B46E709, 0x992A, 0x11D2, [0xAC, 0x4D, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_VIDEO_MUTE;

const GUID CLSID_KSAUDFNAME_VIDEO = {0x915DAEC4, 0xA434, 0x11D2, [0xAC, 0x52, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]};
@GUID(0x915DAEC4, 0xA434, 0x11D2, [0xAC, 0x52, 0x00, 0xC0, 0x4F, 0x8E, 0xFB, 0x68]);
struct KSAUDFNAME_VIDEO;

const GUID CLSID_KSAUDFNAME_PEAKMETER = {0x57E24340, 0xFC5B, 0x4612, [0xA5, 0x62, 0x72, 0xB1, 0x1A, 0x29, 0xDF, 0xAE]};
@GUID(0x57E24340, 0xFC5B, 0x4612, [0xA5, 0x62, 0x72, 0xB1, 0x1A, 0x29, 0xDF, 0xAE]);
struct KSAUDFNAME_PEAKMETER;

const GUID CLSID_KSMETHODSETID_Wavetable = {0xDCEF31EB, 0xD907, 0x11D0, [0x95, 0x83, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0xDCEF31EB, 0xD907, 0x11D0, [0x95, 0x83, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSMETHODSETID_Wavetable;

enum KSMETHOD_WAVETABLE
{
    KSMETHOD_WAVETABLE_WAVE_ALLOC = 0,
    KSMETHOD_WAVETABLE_WAVE_FREE = 1,
    KSMETHOD_WAVETABLE_WAVE_FIND = 2,
    KSMETHOD_WAVETABLE_WAVE_WRITE = 3,
}

struct KSWAVETABLE_WAVE_DESC
{
    KSIDENTIFIER Identifier;
    uint Size;
    BOOL Looped;
    uint LoopPoint;
    BOOL InROM;
    KSDATAFORMAT Format;
}

const GUID CLSID_KSPROPSETID_Wave = {0x924E54B0, 0x630F, 0x11CF, [0xAD, 0xA7, 0x08, 0x00, 0x3E, 0x30, 0x49, 0x4A]};
@GUID(0x924E54B0, 0x630F, 0x11CF, [0xAD, 0xA7, 0x08, 0x00, 0x3E, 0x30, 0x49, 0x4A]);
struct KSPROPSETID_Wave;

enum KSPROPERTY_WAVE
{
    KSPROPERTY_WAVE_COMPATIBLE_CAPABILITIES = 0,
    KSPROPERTY_WAVE_INPUT_CAPABILITIES = 1,
    KSPROPERTY_WAVE_OUTPUT_CAPABILITIES = 2,
    KSPROPERTY_WAVE_BUFFER = 3,
    KSPROPERTY_WAVE_FREQUENCY = 4,
    KSPROPERTY_WAVE_VOLUME = 5,
    KSPROPERTY_WAVE_PAN = 6,
}

struct KSWAVE_COMPATCAPS
{
    uint ulDeviceType;
}

struct KSWAVE_INPUT_CAPABILITIES
{
    uint MaximumChannelsPerConnection;
    uint MinimumBitsPerSample;
    uint MaximumBitsPerSample;
    uint MinimumSampleFrequency;
    uint MaximumSampleFrequency;
    uint TotalConnections;
    uint ActiveConnections;
}

struct KSWAVE_OUTPUT_CAPABILITIES
{
    uint MaximumChannelsPerConnection;
    uint MinimumBitsPerSample;
    uint MaximumBitsPerSample;
    uint MinimumSampleFrequency;
    uint MaximumSampleFrequency;
    uint TotalConnections;
    uint StaticConnections;
    uint StreamingConnections;
    uint ActiveConnections;
    uint ActiveStaticConnections;
    uint ActiveStreamingConnections;
    uint Total3DConnections;
    uint Static3DConnections;
    uint Streaming3DConnections;
    uint Active3DConnections;
    uint ActiveStatic3DConnections;
    uint ActiveStreaming3DConnections;
    uint TotalSampleMemory;
    uint FreeSampleMemory;
    uint LargestFreeContiguousSampleMemory;
}

struct KSWAVE_VOLUME
{
    int LeftAttenuation;
    int RightAttenuation;
}

struct KSWAVE_BUFFER
{
    uint Attributes;
    uint BufferSize;
    void* BufferAddress;
}

const GUID CLSID_KSMUSIC_TECHNOLOGY_PORT = {0x86C92E60, 0x62E8, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x86C92E60, 0x62E8, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSMUSIC_TECHNOLOGY_PORT;

const GUID CLSID_KSMUSIC_TECHNOLOGY_SQSYNTH = {0x0ECF4380, 0x62E9, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x0ECF4380, 0x62E9, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSMUSIC_TECHNOLOGY_SQSYNTH;

const GUID CLSID_KSMUSIC_TECHNOLOGY_FMSYNTH = {0x252C5C80, 0x62E9, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x252C5C80, 0x62E9, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSMUSIC_TECHNOLOGY_FMSYNTH;

const GUID CLSID_KSMUSIC_TECHNOLOGY_WAVETABLE = {0x394EC7C0, 0x62E9, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x394EC7C0, 0x62E9, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSMUSIC_TECHNOLOGY_WAVETABLE;

const GUID CLSID_KSMUSIC_TECHNOLOGY_SWSYNTH = {0x37407736, 0x3620, 0x11D1, [0x85, 0xD3, 0x00, 0x00, 0xF8, 0x75, 0x43, 0x80]};
@GUID(0x37407736, 0x3620, 0x11D1, [0x85, 0xD3, 0x00, 0x00, 0xF8, 0x75, 0x43, 0x80]);
struct KSMUSIC_TECHNOLOGY_SWSYNTH;

struct KSDATARANGE_MUSIC
{
    KSDATAFORMAT DataRange;
    Guid Technology;
    uint Channels;
    uint Notes;
    uint ChannelMask;
}

const GUID CLSID_KSPROPSETID_Cyclic = {0x3FFEAEA0, 0x2BEE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x3FFEAEA0, 0x2BEE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSPROPSETID_Cyclic;

enum KSPROPERTY_CYCLIC
{
    KSPROPERTY_CYCLIC_POSITION = 0,
}

const GUID CLSID_KSEVENTSETID_AudioControlChange = {0xE85E9698, 0xFA2F, 0x11D1, [0x95, 0xBD, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]};
@GUID(0xE85E9698, 0xFA2F, 0x11D1, [0x95, 0xBD, 0x00, 0xC0, 0x4F, 0xB9, 0x25, 0xD3]);
struct KSEVENTSETID_AudioControlChange;

enum KSEVENT_AUDIO_CONTROL_CHANGE
{
    KSEVENT_CONTROL_CHANGE = 0,
}

const GUID CLSID_KSEVENTSETID_LoopedStreaming = {0x4682B940, 0xC6EF, 0x11D0, [0x96, 0xD8, 0x00, 0xAA, 0x00, 0x51, 0xE5, 0x1D]};
@GUID(0x4682B940, 0xC6EF, 0x11D0, [0x96, 0xD8, 0x00, 0xAA, 0x00, 0x51, 0xE5, 0x1D]);
struct KSEVENTSETID_LoopedStreaming;

enum KSEVENT_LOOPEDSTREAMING
{
    KSEVENT_LOOPEDSTREAMING_POSITION = 0,
}

struct LOOPEDSTREAMING_POSITION_EVENT_DATA
{
    KSEVENTDATA KsEventData;
    ulong Position;
}

struct KSNODEPROPERTY
{
    KSIDENTIFIER Property;
    uint NodeId;
    uint Reserved;
}

struct KSNODEPROPERTY_AUDIO_CHANNEL
{
    KSNODEPROPERTY NodeProperty;
    int Channel;
    uint Reserved;
}

struct KSNODEPROPERTY_AUDIO_DEV_SPECIFIC
{
    KSNODEPROPERTY NodeProperty;
    uint DevSpecificId;
    uint DeviceInfo;
    uint Length;
}

struct KSNODEPROPERTY_AUDIO_3D_LISTENER
{
    KSNODEPROPERTY NodeProperty;
    void* ListenerId;
    uint Reserved;
}

struct KSNODEPROPERTY_AUDIO_PROPERTY
{
    KSNODEPROPERTY NodeProperty;
    void* AppContext;
    uint Length;
    uint Reserved;
}

const GUID CLSID_KSDATAFORMAT_TYPE_MUSIC = {0xE725D360, 0x62CC, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0xE725D360, 0x62CC, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSDATAFORMAT_TYPE_MUSIC;

const GUID CLSID_KSDATAFORMAT_TYPE_MIDI = {0x7364696D, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x7364696D, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_TYPE_MIDI;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MIDI = {0x1D262760, 0xE957, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x1D262760, 0xE957, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSDATAFORMAT_SUBTYPE_MIDI;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MIDI_BUS = {0x2CA15FA0, 0x6CFE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]};
@GUID(0x2CA15FA0, 0x6CFE, 0x11CF, [0xA5, 0xD6, 0x28, 0xDB, 0x04, 0xC1, 0x00, 0x00]);
struct KSDATAFORMAT_SUBTYPE_MIDI_BUS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_RIFFMIDI = {0x4995DAF0, 0x9EE6, 0x11D0, [0xA4, 0x0E, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x4995DAF0, 0x9EE6, 0x11D0, [0xA4, 0x0E, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSDATAFORMAT_SUBTYPE_RIFFMIDI;

struct KSMUSICFORMAT
{
    uint TimeDeltaMs;
    uint ByteCount;
}

const GUID CLSID_KSDATAFORMAT_TYPE_STANDARD_ELEMENTARY_STREAM = {0x36523B11, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B11, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_TYPE_STANDARD_ELEMENTARY_STREAM;

const GUID CLSID_KSDATAFORMAT_TYPE_STANDARD_PES_PACKET = {0x36523B12, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B12, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_TYPE_STANDARD_PES_PACKET;

const GUID CLSID_KSDATAFORMAT_TYPE_STANDARD_PACK_HEADER = {0x36523B13, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B13, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_TYPE_STANDARD_PACK_HEADER;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_STANDARD_MPEG1_VIDEO = {0x36523B21, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B21, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SUBTYPE_STANDARD_MPEG1_VIDEO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_STANDARD_MPEG1_AUDIO = {0x36523B22, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B22, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SUBTYPE_STANDARD_MPEG1_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_STANDARD_MPEG2_VIDEO = {0x36523B23, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B23, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SUBTYPE_STANDARD_MPEG2_VIDEO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_STANDARD_MPEG2_AUDIO = {0x36523B24, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B24, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SUBTYPE_STANDARD_MPEG2_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_STANDARD_AC3_AUDIO = {0x36523B25, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B25, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SUBTYPE_STANDARD_AC3_AUDIO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_DIALECT_MPEG1_VIDEO = {0x36523B31, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B31, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SPECIFIER_DIALECT_MPEG1_VIDEO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_DIALECT_MPEG1_AUDIO = {0x36523B32, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B32, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SPECIFIER_DIALECT_MPEG1_AUDIO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_DIALECT_MPEG2_VIDEO = {0x36523B33, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B33, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SPECIFIER_DIALECT_MPEG2_VIDEO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_DIALECT_MPEG2_AUDIO = {0x36523B34, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B34, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SPECIFIER_DIALECT_MPEG2_AUDIO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_DIALECT_AC3_AUDIO = {0x36523B35, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]};
@GUID(0x36523B35, 0x8EE5, 0x11D1, [0x8C, 0xA3, 0x00, 0x60, 0xB0, 0x57, 0x66, 0x4A]);
struct KSDATAFORMAT_SPECIFIER_DIALECT_AC3_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_DSS_VIDEO = {0xA0AF4F81, 0xE163, 0x11D0, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]};
@GUID(0xA0AF4F81, 0xE163, 0x11D0, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]);
struct KSDATAFORMAT_SUBTYPE_DSS_VIDEO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_DSS_AUDIO = {0xA0AF4F82, 0xE163, 0x11D0, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]};
@GUID(0xA0AF4F82, 0xE163, 0x11D0, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]);
struct KSDATAFORMAT_SUBTYPE_DSS_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEG1Packet = {0xE436EB80, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EB80, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct KSDATAFORMAT_SUBTYPE_MPEG1Packet;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEG1Payload = {0xE436EB81, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EB81, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct KSDATAFORMAT_SUBTYPE_MPEG1Payload;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEG1Video = {0xE436EB86, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EB86, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct KSDATAFORMAT_SUBTYPE_MPEG1Video;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_MPEG1_VIDEO = {0x05589F82, 0xC356, 0x11CE, [0xBF, 0x01, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]};
@GUID(0x05589F82, 0xC356, 0x11CE, [0xBF, 0x01, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]);
struct KSDATAFORMAT_SPECIFIER_MPEG1_VIDEO;

const GUID CLSID_KSDATAFORMAT_TYPE_MPEG2_PES = {0xE06D8020, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D8020, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_TYPE_MPEG2_PES;

const GUID CLSID_KSDATAFORMAT_TYPE_MPEG2_PROGRAM = {0xE06D8022, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D8022, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_TYPE_MPEG2_PROGRAM;

const GUID CLSID_KSDATAFORMAT_TYPE_MPEG2_TRANSPORT = {0xE06D8023, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D8023, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_TYPE_MPEG2_TRANSPORT;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEG2_VIDEO = {0xE06D8026, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D8026, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SUBTYPE_MPEG2_VIDEO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_MPEG2_VIDEO = {0xE06D80E3, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D80E3, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SPECIFIER_MPEG2_VIDEO;

const GUID CLSID_KSPROPSETID_Mpeg2Vid = {0xC8E11B60, 0x0CC9, 0x11D0, [0xBD, 0x69, 0x00, 0x35, 0x05, 0xC1, 0x03, 0xA9]};
@GUID(0xC8E11B60, 0x0CC9, 0x11D0, [0xBD, 0x69, 0x00, 0x35, 0x05, 0xC1, 0x03, 0xA9]);
struct KSPROPSETID_Mpeg2Vid;

enum KSPROPERTY_MPEG2VID
{
    KSPROPERTY_MPEG2VID_MODES = 0,
    KSPROPERTY_MPEG2VID_CUR_MODE = 1,
    KSPROPERTY_MPEG2VID_4_3_RECT = 2,
    KSPROPERTY_MPEG2VID_16_9_RECT = 3,
    KSPROPERTY_MPEG2VID_16_9_PANSCAN = 4,
}

struct KSMPEGVID_RECT
{
    uint StartX;
    uint StartY;
    uint EndX;
    uint EndY;
}

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEG2_AUDIO = {0xE06D802B, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D802B, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SUBTYPE_MPEG2_AUDIO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_MPEG2_AUDIO = {0xE06D80E5, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D80E5, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SPECIFIER_MPEG2_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_LPCM_AUDIO = {0xE06D8032, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D8032, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SUBTYPE_LPCM_AUDIO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_LPCM_AUDIO = {0xE06D80E6, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D80E6, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SPECIFIER_LPCM_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_AC3_AUDIO = {0xE06D802C, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D802C, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SUBTYPE_AC3_AUDIO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_AC3_AUDIO = {0xE06D80E4, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D80E4, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SPECIFIER_AC3_AUDIO;

const GUID CLSID_KSPROPSETID_AC3 = {0xBFABE720, 0x6E1F, 0x11D0, [0xBC, 0xF2, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0xBFABE720, 0x6E1F, 0x11D0, [0xBC, 0xF2, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct KSPROPSETID_AC3;

enum KSPROPERTY_AC3
{
    KSPROPERTY_AC3_ERROR_CONCEALMENT = 1,
    KSPROPERTY_AC3_ALTERNATE_AUDIO = 2,
    KSPROPERTY_AC3_DOWNMIX = 3,
    KSPROPERTY_AC3_BIT_STREAM_MODE = 4,
    KSPROPERTY_AC3_DIALOGUE_LEVEL = 5,
    KSPROPERTY_AC3_LANGUAGE_CODE = 6,
    KSPROPERTY_AC3_ROOM_TYPE = 7,
}

struct KSAC3_ERROR_CONCEALMENT
{
    BOOL fRepeatPreviousBlock;
    BOOL fErrorInCurrentBlock;
}

struct KSAC3_ALTERNATE_AUDIO
{
    BOOL fStereo;
    uint DualMode;
}

struct KSAC3_DOWNMIX
{
    BOOL fDownMix;
    BOOL fDolbySurround;
}

struct KSAC3_BIT_STREAM_MODE
{
    int BitStreamMode;
}

struct KSAC3_DIALOGUE_LEVEL
{
    uint DialogueLevel;
}

struct KSAC3_ROOM_TYPE
{
    BOOL fLargeRoom;
}

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_DIGITAL = {0x00000092, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000092, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_DIGITAL;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_WMA_PRO = {0x00000164, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000164, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_WMA_PRO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DTS = {0x00000008, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000008, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DTS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_MPEG1 = {0x00000003, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000003, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_MPEG1;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_MPEG2 = {0x00000004, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000004, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_MPEG2;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_MPEG3 = {0x00000005, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000005, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_MPEG3;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_AAC = {0x00000006, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000006, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_AAC;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_ATRAC = {0x00000008, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000008, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_ATRAC;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_ONE_BIT_AUDIO = {0x00000009, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000009, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_ONE_BIT_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_DIGITAL_PLUS = {0x0000000A, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x0000000A, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_DIGITAL_PLUS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_DIGITAL_PLUS_ATMOS = {0x0000010A, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x0000010A, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_DIGITAL_PLUS_ATMOS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DTS_HD = {0x0000000B, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x0000000B, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DTS_HD;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_MLP = {0x0000000C, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x0000000C, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_MLP;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_MAT20 = {0x0000010C, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x0000010C, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_MAT20;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_MAT21 = {0x0000030C, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x0000030C, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DOLBY_MAT21;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEC61937_DST = {0x0000000D, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x0000000D, 0x0CEA, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEC61937_DST;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEGLAYER3 = {0x00000055, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000055, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_MPEGLAYER3;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MPEG_HEAAC = {0x00001610, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00001610, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_MPEG_HEAAC;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_WMAUDIO2 = {0x00000161, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000161, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_WMAUDIO2;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_WMAUDIO3 = {0x00000162, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000162, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_WMAUDIO3;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_WMAUDIO_LOSSLESS = {0x00000163, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000163, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_WMAUDIO_LOSSLESS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_DTS_AUDIO = {0xE06D8033, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D8033, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SUBTYPE_DTS_AUDIO;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_SDDS_AUDIO = {0xE06D8034, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D8034, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SUBTYPE_SDDS_AUDIO;

const GUID CLSID_KSPROPSETID_AudioDecoderOut = {0x6CA6E020, 0x43BD, 0x11D0, [0xBD, 0x6A, 0x00, 0x35, 0x05, 0xC1, 0x03, 0xA9]};
@GUID(0x6CA6E020, 0x43BD, 0x11D0, [0xBD, 0x6A, 0x00, 0x35, 0x05, 0xC1, 0x03, 0xA9]);
struct KSPROPSETID_AudioDecoderOut;

enum KSPROPERTY_AUDDECOUT
{
    KSPROPERTY_AUDDECOUT_MODES = 0,
    KSPROPERTY_AUDDECOUT_CUR_MODE = 1,
}

const GUID CLSID_KSDATAFORMAT_SUBTYPE_SUBPICTURE = {0xE06D802D, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]};
@GUID(0xE06D802D, 0xDB46, 0x11CF, [0xB4, 0xD1, 0x00, 0x80, 0x5F, 0x6C, 0xBB, 0xEA]);
struct KSDATAFORMAT_SUBTYPE_SUBPICTURE;

const GUID CLSID_KSPROPSETID_DvdSubPic = {0xAC390460, 0x43AF, 0x11D0, [0xBD, 0x6A, 0x00, 0x35, 0x05, 0xC1, 0x03, 0xA9]};
@GUID(0xAC390460, 0x43AF, 0x11D0, [0xBD, 0x6A, 0x00, 0x35, 0x05, 0xC1, 0x03, 0xA9]);
struct KSPROPSETID_DvdSubPic;

enum KSPROPERTY_DVDSUBPIC
{
    KSPROPERTY_DVDSUBPIC_PALETTE = 0,
    KSPROPERTY_DVDSUBPIC_HLI = 1,
    KSPROPERTY_DVDSUBPIC_COMPOSIT_ON = 2,
}

struct KS_DVD_YCrCb
{
    ubyte Reserved;
    ubyte Y;
    ubyte Cr;
    ubyte Cb;
}

struct KS_DVD_YUV
{
    ubyte Reserved;
    ubyte Y;
    ubyte V;
    ubyte U;
}

struct KSPROPERTY_SPPAL
{
    KS_DVD_YUV sppal;
}

struct KS_COLCON
{
    ubyte _bitfield1;
    ubyte _bitfield2;
    ubyte _bitfield3;
    ubyte _bitfield4;
}

struct KSPROPERTY_SPHLI
{
    ushort HLISS;
    ushort Reserved;
    uint StartPTM;
    uint EndPTM;
    ushort StartX;
    ushort StartY;
    ushort StopX;
    ushort StopY;
    KS_COLCON ColCon;
}

const GUID CLSID_KSPROPSETID_CopyProt = {0x0E8A0A40, 0x6AEF, 0x11D0, [0x9E, 0xD0, 0x00, 0xA0, 0x24, 0xCA, 0x19, 0xB3]};
@GUID(0x0E8A0A40, 0x6AEF, 0x11D0, [0x9E, 0xD0, 0x00, 0xA0, 0x24, 0xCA, 0x19, 0xB3]);
struct KSPROPSETID_CopyProt;

enum KSPROPERTY_COPYPROT
{
    KSPROPERTY_DVDCOPY_CHLG_KEY = 1,
    KSPROPERTY_DVDCOPY_DVD_KEY1 = 2,
    KSPROPERTY_DVDCOPY_DEC_KEY2 = 3,
    KSPROPERTY_DVDCOPY_TITLE_KEY = 4,
    KSPROPERTY_COPY_MACROVISION = 5,
    KSPROPERTY_DVDCOPY_REGION = 6,
    KSPROPERTY_DVDCOPY_SET_COPY_STATE = 7,
    KSPROPERTY_DVDCOPY_DISC_KEY = 128,
}

struct KS_DVDCOPY_CHLGKEY
{
    ubyte ChlgKey;
    ubyte Reserved;
}

struct KS_DVDCOPY_BUSKEY
{
    ubyte BusKey;
    ubyte Reserved;
}

struct KS_DVDCOPY_DISCKEY
{
    ubyte DiscKey;
}

struct KS_DVDCOPY_REGION
{
    ubyte Reserved;
    ubyte RegionData;
    ubyte Reserved2;
}

struct KS_DVDCOPY_TITLEKEY
{
    uint KeyFlags;
    uint ReservedNT;
    ubyte TitleKey;
    ubyte Reserved;
}

struct KS_COPY_MACROVISION
{
    uint MACROVISIONLevel;
}

struct KS_DVDCOPY_SET_COPY_STATE
{
    uint DVDCopyState;
}

enum KS_DVDCOPYSTATE
{
    KS_DVDCOPYSTATE_INITIALIZE = 0,
    KS_DVDCOPYSTATE_INITIALIZE_TITLE = 1,
    KS_DVDCOPYSTATE_AUTHENTICATION_NOT_REQUIRED = 2,
    KS_DVDCOPYSTATE_AUTHENTICATION_REQUIRED = 3,
    KS_DVDCOPYSTATE_DONE = 4,
}

enum KS_COPY_MACROVISION_LEVEL
{
    KS_MACROVISION_DISABLED = 0,
    KS_MACROVISION_LEVEL1 = 1,
    KS_MACROVISION_LEVEL2 = 2,
    KS_MACROVISION_LEVEL3 = 3,
}

const GUID CLSID_KSCATEGORY_TVTUNER = {0xA799A800, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]};
@GUID(0xA799A800, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]);
struct KSCATEGORY_TVTUNER;

const GUID CLSID_KSCATEGORY_CROSSBAR = {0xA799A801, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]};
@GUID(0xA799A801, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]);
struct KSCATEGORY_CROSSBAR;

const GUID CLSID_KSCATEGORY_TVAUDIO = {0xA799A802, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]};
@GUID(0xA799A802, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]);
struct KSCATEGORY_TVAUDIO;

const GUID CLSID_KSCATEGORY_VPMUX = {0xA799A803, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]};
@GUID(0xA799A803, 0xA46D, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0x24, 0x01, 0xDC, 0xD4]);
struct KSCATEGORY_VPMUX;

const GUID CLSID_KSCATEGORY_VBICODEC = {0x07DAD660, 0x22F1, 0x11D1, [0xA9, 0xF4, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0x8F]};
@GUID(0x07DAD660, 0x22F1, 0x11D1, [0xA9, 0xF4, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0x8F]);
struct KSCATEGORY_VBICODEC;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_VPVideo = {0x5A9B6A40, 0x1A22, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]};
@GUID(0x5A9B6A40, 0x1A22, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]);
struct KSDATAFORMAT_SUBTYPE_VPVideo;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_VPVBI = {0x5A9B6A41, 0x1A22, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]};
@GUID(0x5A9B6A41, 0x1A22, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]);
struct KSDATAFORMAT_SUBTYPE_VPVBI;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_VIDEOINFO = {0x05589F80, 0xC356, 0x11CE, [0xBF, 0x01, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]};
@GUID(0x05589F80, 0xC356, 0x11CE, [0xBF, 0x01, 0x00, 0xAA, 0x00, 0x55, 0x59, 0x5A]);
struct KSDATAFORMAT_SPECIFIER_VIDEOINFO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_VIDEOINFO2 = {0xF72A76A0, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xF72A76A0, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct KSDATAFORMAT_SPECIFIER_VIDEOINFO2;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_H264_VIDEO = {0x2017BE05, 0x6629, 0x4248, [0xAA, 0xED, 0x7E, 0x1A, 0x47, 0xBC, 0x9B, 0x9C]};
@GUID(0x2017BE05, 0x6629, 0x4248, [0xAA, 0xED, 0x7E, 0x1A, 0x47, 0xBC, 0x9B, 0x9C]);
struct KSDATAFORMAT_SPECIFIER_H264_VIDEO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_JPEG_IMAGE = {0x692FA379, 0xD3E8, 0x4651, [0xB5, 0xB4, 0x0B, 0x94, 0xB0, 0x13, 0xEE, 0xAF]};
@GUID(0x692FA379, 0xD3E8, 0x4651, [0xB5, 0xB4, 0x0B, 0x94, 0xB0, 0x13, 0xEE, 0xAF]);
struct KSDATAFORMAT_SPECIFIER_JPEG_IMAGE;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_IMAGE = {0x692FA379, 0xD3E8, 0x4651, [0xB5, 0xB4, 0x0B, 0x94, 0xB0, 0x13, 0xEE, 0xAF]};
@GUID(0x692FA379, 0xD3E8, 0x4651, [0xB5, 0xB4, 0x0B, 0x94, 0xB0, 0x13, 0xEE, 0xAF]);
struct KSDATAFORMAT_SPECIFIER_IMAGE;

const GUID CLSID_KSDATAFORMAT_TYPE_IMAGE = {0x72178C23, 0xE45B, 0x11D5, [0xBC, 0x2A, 0x00, 0xB0, 0xD0, 0xF3, 0xF4, 0xAB]};
@GUID(0x72178C23, 0xE45B, 0x11D5, [0xBC, 0x2A, 0x00, 0xB0, 0xD0, 0xF3, 0xF4, 0xAB]);
struct KSDATAFORMAT_TYPE_IMAGE;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_JPEG = {0x19E4A5AA, 0x5662, 0x4FC5, [0xA0, 0xC0, 0x17, 0x58, 0x02, 0x8E, 0x10, 0x57]};
@GUID(0x19E4A5AA, 0x5662, 0x4FC5, [0xA0, 0xC0, 0x17, 0x58, 0x02, 0x8E, 0x10, 0x57]);
struct KSDATAFORMAT_SUBTYPE_JPEG;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IMAGE_RGB32 = {0x00000016, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000016, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IMAGE_RGB32;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_L8 = {0x00000032, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000032, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_L8;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_L8_IR = {0x00000032, 0x0002, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000032, 0x0002, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_L8_IR;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_L8_CUSTOM = {0x00000032, 0x8000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000032, 0x8000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_L8_CUSTOM;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_L16 = {0x00000051, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000051, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_L16;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_L16_IR = {0x00000051, 0x0002, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000051, 0x0002, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_L16_IR;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_D16 = {0x00000050, 0x0004, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000050, 0x0004, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_D16;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_L16_CUSTOM = {0x00000051, 0x8000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000051, 0x8000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_L16_CUSTOM;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MJPG_IR = {0x47504A4D, 0x0002, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x47504A4D, 0x0002, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_MJPG_IR;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MJPG_DEPTH = {0x47504A4D, 0x0004, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x47504A4D, 0x0004, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_MJPG_DEPTH;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_MJPG_CUSTOM = {0x47504A4D, 0x8000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x47504A4D, 0x8000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_MJPG_CUSTOM;

const GUID CLSID_KSDATAFORMAT_TYPE_ANALOGVIDEO = {0x0482DDE1, 0x7817, 0x11CF, [0x8A, 0x03, 0x00, 0xAA, 0x00, 0x6E, 0xCB, 0x65]};
@GUID(0x0482DDE1, 0x7817, 0x11CF, [0x8A, 0x03, 0x00, 0xAA, 0x00, 0x6E, 0xCB, 0x65]);
struct KSDATAFORMAT_TYPE_ANALOGVIDEO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_ANALOGVIDEO = {0x0482DDE0, 0x7817, 0x11CF, [0x8A, 0x03, 0x00, 0xAA, 0x00, 0x6E, 0xCB, 0x65]};
@GUID(0x0482DDE0, 0x7817, 0x11CF, [0x8A, 0x03, 0x00, 0xAA, 0x00, 0x6E, 0xCB, 0x65]);
struct KSDATAFORMAT_SPECIFIER_ANALOGVIDEO;

const GUID CLSID_KSDATAFORMAT_TYPE_ANALOGAUDIO = {0x0482DEE1, 0x7817, 0x11CF, [0x8A, 0x03, 0x00, 0xAA, 0x00, 0x6E, 0xCB, 0x65]};
@GUID(0x0482DEE1, 0x7817, 0x11CF, [0x8A, 0x03, 0x00, 0xAA, 0x00, 0x6E, 0xCB, 0x65]);
struct KSDATAFORMAT_TYPE_ANALOGAUDIO;

const GUID CLSID_KSDATAFORMAT_SPECIFIER_VBI = {0xF72A76E0, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xF72A76E0, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct KSDATAFORMAT_SPECIFIER_VBI;

const GUID CLSID_KSDATAFORMAT_TYPE_VBI = {0xF72A76E1, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xF72A76E1, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct KSDATAFORMAT_TYPE_VBI;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_RAW8 = {0xCA20D9A0, 0x3E3E, 0x11D1, [0x9B, 0xF9, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0xBF]};
@GUID(0xCA20D9A0, 0x3E3E, 0x11D1, [0x9B, 0xF9, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0xBF]);
struct KSDATAFORMAT_SUBTYPE_RAW8;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_CC = {0x33214CC1, 0x011F, 0x11D2, [0xB4, 0xB1, 0x00, 0xA0, 0xD1, 0x02, 0xCF, 0xBE]};
@GUID(0x33214CC1, 0x011F, 0x11D2, [0xB4, 0xB1, 0x00, 0xA0, 0xD1, 0x02, 0xCF, 0xBE]);
struct KSDATAFORMAT_SUBTYPE_CC;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_NABTS = {0xF72A76E2, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xF72A76E2, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct KSDATAFORMAT_SUBTYPE_NABTS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_TELETEXT = {0xF72A76E3, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xF72A76E3, 0xEB0A, 0x11D0, [0xAC, 0xE4, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct KSDATAFORMAT_SUBTYPE_TELETEXT;

struct KS_RGBQUAD
{
    ubyte rgbBlue;
    ubyte rgbGreen;
    ubyte rgbRed;
    ubyte rgbReserved;
}

struct KS_BITMAPINFOHEADER
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

struct tag_KS_TRUECOLORINFO
{
    uint dwBitMasks;
    KS_RGBQUAD bmiColors;
}

struct KS_VIDEOINFOHEADER
{
    RECT rcSource;
    RECT rcTarget;
    uint dwBitRate;
    uint dwBitErrorRate;
    long AvgTimePerFrame;
    KS_BITMAPINFOHEADER bmiHeader;
}

struct KS_VIDEOINFO
{
    RECT rcSource;
    RECT rcTarget;
    uint dwBitRate;
    uint dwBitErrorRate;
    long AvgTimePerFrame;
    KS_BITMAPINFOHEADER bmiHeader;
    _Anonymous_e__Union Anonymous;
}

struct KS_VBIINFOHEADER
{
    uint StartLine;
    uint EndLine;
    uint SamplingFrequency;
    uint MinLineStartTime;
    uint MaxLineStartTime;
    uint ActualLineStartTime;
    uint ActualLineEndTime;
    uint VideoStandard;
    uint SamplesPerLine;
    uint StrideInBytes;
    uint BufferSize;
}

struct tagKS_AnalogVideoInfo
{
    RECT rcSource;
    RECT rcTarget;
    uint dwActiveWidth;
    uint dwActiveHeight;
    long AvgTimePerFrame;
}

struct KS_TVTUNER_CHANGE_INFO
{
    uint dwFlags;
    uint dwCountryCode;
    uint dwAnalogVideoStandard;
    uint dwChannel;
}

enum KS_MPEG2Level
{
    KS_MPEG2Level_Low = 0,
    KS_MPEG2Level_Main = 1,
    KS_MPEG2Level_High1440 = 2,
    KS_MPEG2Level_High = 3,
}

enum KS_MPEG2Profile
{
    KS_MPEG2Profile_Simple = 0,
    KS_MPEG2Profile_Main = 1,
    KS_MPEG2Profile_SNRScalable = 2,
    KS_MPEG2Profile_SpatiallyScalable = 3,
    KS_MPEG2Profile_High = 4,
}

struct KS_VIDEOINFOHEADER2
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
    KS_BITMAPINFOHEADER bmiHeader;
}

struct KS_MPEG1VIDEOINFO
{
    KS_VIDEOINFOHEADER hdr;
    uint dwStartTimeCode;
    uint cbSequenceHeader;
    ubyte bSequenceHeader;
}

struct KS_MPEGVIDEOINFO2
{
    KS_VIDEOINFOHEADER2 hdr;
    uint dwStartTimeCode;
    uint cbSequenceHeader;
    uint dwProfile;
    uint dwLevel;
    uint dwFlags;
    uint bSequenceHeader;
}

struct KS_H264VIDEOINFO
{
    ushort wWidth;
    ushort wHeight;
    ushort wSARwidth;
    ushort wSARheight;
    ushort wProfile;
    ubyte bLevelIDC;
    ushort wConstrainedToolset;
    uint bmSupportedUsages;
    ushort bmCapabilities;
    uint bmSVCCapabilities;
    uint bmMVCCapabilities;
    uint dwFrameInterval;
    ubyte bMaxCodecConfigDelay;
    ubyte bmSupportedSliceModes;
    ubyte bmSupportedSyncFrameTypes;
    ubyte bResolutionScaling;
    ubyte bSimulcastSupport;
    ubyte bmSupportedRateControlModes;
    ushort wMaxMBperSecOneResolutionNoScalability;
    ushort wMaxMBperSecTwoResolutionsNoScalability;
    ushort wMaxMBperSecThreeResolutionsNoScalability;
    ushort wMaxMBperSecFourResolutionsNoScalability;
    ushort wMaxMBperSecOneResolutionTemporalScalability;
    ushort wMaxMBperSecTwoResolutionsTemporalScalablility;
    ushort wMaxMBperSecThreeResolutionsTemporalScalability;
    ushort wMaxMBperSecFourResolutionsTemporalScalability;
    ushort wMaxMBperSecOneResolutionTemporalQualityScalability;
    ushort wMaxMBperSecTwoResolutionsTemporalQualityScalability;
    ushort wMaxMBperSecThreeResolutionsTemporalQualityScalablity;
    ushort wMaxMBperSecFourResolutionsTemporalQualityScalability;
    ushort wMaxMBperSecOneResolutionTemporalSpatialScalability;
    ushort wMaxMBperSecTwoResolutionsTemporalSpatialScalability;
    ushort wMaxMBperSecThreeResolutionsTemporalSpatialScalablity;
    ushort wMaxMBperSecFourResolutionsTemporalSpatialScalability;
    ushort wMaxMBperSecOneResolutionFullScalability;
    ushort wMaxMBperSecTwoResolutionsFullScalability;
    ushort wMaxMBperSecThreeResolutionsFullScalability;
    ushort wMaxMBperSecFourResolutionsFullScalability;
}

struct tagKS_MPEAUDIOINFO
{
    uint dwFlags;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
}

struct KS_DATAFORMAT_VIDEOINFOHEADER
{
    KSDATAFORMAT DataFormat;
    KS_VIDEOINFOHEADER VideoInfoHeader;
}

struct KS_DATAFORMAT_VIDEOINFOHEADER2
{
    KSDATAFORMAT DataFormat;
    KS_VIDEOINFOHEADER2 VideoInfoHeader2;
}

struct KS_DATAFORMAT_MPEGVIDEOINFO2
{
    KSDATAFORMAT DataFormat;
    KS_MPEGVIDEOINFO2 MpegVideoInfoHeader2;
}

struct KS_DATAFORMAT_H264VIDEOINFO
{
    KSDATAFORMAT DataFormat;
    KS_H264VIDEOINFO H264VideoInfoHeader;
}

struct KS_DATAFORMAT_IMAGEINFO
{
    KSDATAFORMAT DataFormat;
    KS_BITMAPINFOHEADER ImageInfoHeader;
}

struct KS_DATAFORMAT_VIDEOINFO_PALETTE
{
    KSDATAFORMAT DataFormat;
    KS_VIDEOINFO VideoInfo;
}

struct KS_DATAFORMAT_VBIINFOHEADER
{
    KSDATAFORMAT DataFormat;
    KS_VBIINFOHEADER VBIInfoHeader;
}

struct KS_VIDEO_STREAM_CONFIG_CAPS
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

struct KS_DATARANGE_VIDEO
{
    KSDATAFORMAT DataRange;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint StreamDescriptionFlags;
    uint MemoryAllocationFlags;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_VIDEOINFOHEADER VideoInfoHeader;
}

struct KS_DATARANGE_VIDEO2
{
    KSDATAFORMAT DataRange;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint StreamDescriptionFlags;
    uint MemoryAllocationFlags;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_VIDEOINFOHEADER2 VideoInfoHeader;
}

struct KS_DATARANGE_MPEG1_VIDEO
{
    KSDATAFORMAT DataRange;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint StreamDescriptionFlags;
    uint MemoryAllocationFlags;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_MPEG1VIDEOINFO VideoInfoHeader;
}

struct KS_DATARANGE_MPEG2_VIDEO
{
    KSDATAFORMAT DataRange;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint StreamDescriptionFlags;
    uint MemoryAllocationFlags;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_MPEGVIDEOINFO2 VideoInfoHeader;
}

struct KS_DATARANGE_H264_VIDEO
{
    KSDATAFORMAT DataRange;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint StreamDescriptionFlags;
    uint MemoryAllocationFlags;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_H264VIDEOINFO VideoInfoHeader;
}

struct KS_DATARANGE_IMAGE
{
    KSDATAFORMAT DataRange;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_BITMAPINFOHEADER ImageInfoHeader;
}

struct KS_DATARANGE_VIDEO_PALETTE
{
    KSDATAFORMAT DataRange;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint StreamDescriptionFlags;
    uint MemoryAllocationFlags;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_VIDEOINFO VideoInfo;
}

struct KS_DATARANGE_VIDEO_VBI
{
    KSDATAFORMAT DataRange;
    BOOL bFixedSizeSamples;
    BOOL bTemporalCompression;
    uint StreamDescriptionFlags;
    uint MemoryAllocationFlags;
    KS_VIDEO_STREAM_CONFIG_CAPS ConfigCaps;
    KS_VBIINFOHEADER VBIInfoHeader;
}

struct KS_DATARANGE_ANALOGVIDEO
{
    KSDATAFORMAT DataRange;
    tagKS_AnalogVideoInfo AnalogVideoInfo;
}

const GUID CLSID_KSPROPSETID_VBICAP_PROPERTIES = {0xF162C607, 0x7B35, 0x496F, [0xAD, 0x7F, 0x2D, 0xCA, 0x3B, 0x46, 0xB7, 0x18]};
@GUID(0xF162C607, 0x7B35, 0x496F, [0xAD, 0x7F, 0x2D, 0xCA, 0x3B, 0x46, 0xB7, 0x18]);
struct KSPROPSETID_VBICAP_PROPERTIES;

enum KSPROPERTY_VBICAP
{
    KSPROPERTY_VBICAP_PROPERTIES_PROTECTION = 1,
}

struct VBICAP_PROPERTIES_PROTECTION_S
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    uint Status;
}

const GUID CLSID_KSDATAFORMAT_TYPE_NABTS = {0xE757BCA0, 0x39AC, 0x11D1, [0xA9, 0xF5, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0x8F]};
@GUID(0xE757BCA0, 0x39AC, 0x11D1, [0xA9, 0xF5, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0x8F]);
struct KSDATAFORMAT_TYPE_NABTS;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_NABTS_FEC = {0xE757BCA1, 0x39AC, 0x11D1, [0xA9, 0xF5, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0x8F]};
@GUID(0xE757BCA1, 0x39AC, 0x11D1, [0xA9, 0xF5, 0x00, 0xC0, 0x4F, 0xBB, 0xDE, 0x8F]);
struct KSDATAFORMAT_SUBTYPE_NABTS_FEC;

struct NABTSFEC_BUFFER
{
    uint dataSize;
    ushort groupID;
    ushort Reserved;
    ubyte data;
}

const GUID CLSID_KSPROPSETID_VBICodecFiltering = {0xCAFEB0CA, 0x8715, 0x11D0, [0xBD, 0x6A, 0x00, 0x35, 0xC0, 0xED, 0xBA, 0xBE]};
@GUID(0xCAFEB0CA, 0x8715, 0x11D0, [0xBD, 0x6A, 0x00, 0x35, 0xC0, 0xED, 0xBA, 0xBE]);
struct KSPROPSETID_VBICodecFiltering;

enum KSPROPERTY_VBICODECFILTERING
{
    KSPROPERTY_VBICODECFILTERING_SCANLINES_REQUESTED_BIT_ARRAY = 1,
    KSPROPERTY_VBICODECFILTERING_SCANLINES_DISCOVERED_BIT_ARRAY = 2,
    KSPROPERTY_VBICODECFILTERING_SUBSTREAMS_REQUESTED_BIT_ARRAY = 3,
    KSPROPERTY_VBICODECFILTERING_SUBSTREAMS_DISCOVERED_BIT_ARRAY = 4,
    KSPROPERTY_VBICODECFILTERING_STATISTICS = 5,
}

struct VBICODECFILTERING_SCANLINES
{
    uint DwordBitArray;
}

struct VBICODECFILTERING_NABTS_SUBSTREAMS
{
    uint SubstreamMask;
}

struct VBICODECFILTERING_CC_SUBSTREAMS
{
    uint SubstreamMask;
}

struct CC_BYTE_PAIR
{
    ubyte Decoded;
    ushort Reserved;
}

struct CC_HW_FIELD
{
    VBICODECFILTERING_SCANLINES ScanlinesRequested;
    uint fieldFlags;
    long PictureNumber;
    CC_BYTE_PAIR Lines;
}

struct NABTS_BUFFER_LINE
{
    ubyte Confidence;
    ubyte Bytes;
}

struct NABTS_BUFFER
{
    VBICODECFILTERING_SCANLINES ScanlinesRequested;
    long PictureNumber;
    NABTS_BUFFER_LINE NabtsLines;
}

struct WST_BUFFER_LINE
{
    ubyte Confidence;
    ubyte Bytes;
}

struct WST_BUFFER
{
    VBICODECFILTERING_SCANLINES ScanlinesRequested;
    WST_BUFFER_LINE WstLines;
}

struct VBICODECFILTERING_STATISTICS_COMMON
{
    uint InputSRBsProcessed;
    uint OutputSRBsProcessed;
    uint SRBsIgnored;
    uint InputSRBsMissing;
    uint OutputSRBsMissing;
    uint OutputFailures;
    uint InternalErrors;
    uint ExternalErrors;
    uint InputDiscontinuities;
    uint DSPFailures;
    uint TvTunerChanges;
    uint VBIHeaderChanges;
    uint LineConfidenceAvg;
    uint BytesOutput;
}

struct VBICODECFILTERING_STATISTICS_COMMON_PIN
{
    uint SRBsProcessed;
    uint SRBsIgnored;
    uint SRBsMissing;
    uint InternalErrors;
    uint ExternalErrors;
    uint Discontinuities;
    uint LineConfidenceAvg;
    uint BytesOutput;
}

struct VBICODECFILTERING_STATISTICS_NABTS
{
    VBICODECFILTERING_STATISTICS_COMMON Common;
    uint FECBundleBadLines;
    uint FECQueueOverflows;
    uint FECCorrectedLines;
    uint FECUncorrectableLines;
    uint BundlesProcessed;
    uint BundlesSent2IP;
    uint FilteredLines;
}

struct VBICODECFILTERING_STATISTICS_NABTS_PIN
{
    VBICODECFILTERING_STATISTICS_COMMON_PIN Common;
}

struct VBICODECFILTERING_STATISTICS_CC
{
    VBICODECFILTERING_STATISTICS_COMMON Common;
}

struct VBICODECFILTERING_STATISTICS_CC_PIN
{
    VBICODECFILTERING_STATISTICS_COMMON_PIN Common;
}

struct VBICODECFILTERING_STATISTICS_TELETEXT
{
    VBICODECFILTERING_STATISTICS_COMMON Common;
}

struct VBICODECFILTERING_STATISTICS_TELETEXT_PIN
{
    VBICODECFILTERING_STATISTICS_COMMON_PIN Common;
}

struct KSPROPERTY_VBICODECFILTERING_SCANLINES_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_SCANLINES Scanlines;
}

struct KSPROPERTY_VBICODECFILTERING_NABTS_SUBSTREAMS_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_NABTS_SUBSTREAMS Substreams;
}

struct KSPROPERTY_VBICODECFILTERING_CC_SUBSTREAMS_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_CC_SUBSTREAMS Substreams;
}

struct KSPROPERTY_VBICODECFILTERING_STATISTICS_COMMON_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_STATISTICS_COMMON Statistics;
}

struct KSPROPERTY_VBICODECFILTERING_STATISTICS_COMMON_PIN_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_STATISTICS_COMMON_PIN Statistics;
}

struct KSPROPERTY_VBICODECFILTERING_STATISTICS_NABTS_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_STATISTICS_NABTS Statistics;
}

struct KSPROPERTY_VBICODECFILTERING_STATISTICS_NABTS_PIN_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_STATISTICS_NABTS_PIN Statistics;
}

struct KSPROPERTY_VBICODECFILTERING_STATISTICS_CC_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_STATISTICS_CC Statistics;
}

struct KSPROPERTY_VBICODECFILTERING_STATISTICS_CC_PIN_S
{
    KSIDENTIFIER Property;
    VBICODECFILTERING_STATISTICS_CC_PIN Statistics;
}

const GUID CLSID_PINNAME_VIDEO_CAPTURE = {0xFB6C4281, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4281, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_CAPTURE;

const GUID CLSID_PINNAME_VIDEO_CC_CAPTURE = {0x1AAD8061, 0x012D, 0x11D2, [0xB4, 0xB1, 0x00, 0xA0, 0xD1, 0x02, 0xCF, 0xBE]};
@GUID(0x1AAD8061, 0x012D, 0x11D2, [0xB4, 0xB1, 0x00, 0xA0, 0xD1, 0x02, 0xCF, 0xBE]);
struct PINNAME_VIDEO_CC_CAPTURE;

const GUID CLSID_PINNAME_VIDEO_NABTS_CAPTURE = {0x29703660, 0x498A, 0x11D2, [0xB4, 0xB1, 0x00, 0xA0, 0xD1, 0x02, 0xCF, 0xBE]};
@GUID(0x29703660, 0x498A, 0x11D2, [0xB4, 0xB1, 0x00, 0xA0, 0xD1, 0x02, 0xCF, 0xBE]);
struct PINNAME_VIDEO_NABTS_CAPTURE;

const GUID CLSID_PINNAME_VIDEO_PREVIEW = {0xFB6C4282, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4282, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_PREVIEW;

const GUID CLSID_PINNAME_VIDEO_ANALOGVIDEOIN = {0xFB6C4283, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4283, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_ANALOGVIDEOIN;

const GUID CLSID_PINNAME_VIDEO_VBI = {0xFB6C4284, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4284, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_VBI;

const GUID CLSID_PINNAME_VIDEO_VIDEOPORT = {0xFB6C4285, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4285, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_VIDEOPORT;

const GUID CLSID_PINNAME_VIDEO_NABTS = {0xFB6C4286, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4286, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_NABTS;

const GUID CLSID_PINNAME_VIDEO_EDS = {0xFB6C4287, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4287, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_EDS;

const GUID CLSID_PINNAME_VIDEO_TELETEXT = {0xFB6C4288, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4288, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_TELETEXT;

const GUID CLSID_PINNAME_VIDEO_CC = {0xFB6C4289, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C4289, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_CC;

const GUID CLSID_PINNAME_VIDEO_STILL = {0xFB6C428A, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C428A, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_STILL;

const GUID CLSID_PINNAME_IMAGE = {0x38A0CD98, 0xD49B, 0x4CE8, [0xB4, 0x8A, 0x34, 0x46, 0x67, 0xA1, 0x78, 0x30]};
@GUID(0x38A0CD98, 0xD49B, 0x4CE8, [0xB4, 0x8A, 0x34, 0x46, 0x67, 0xA1, 0x78, 0x30]);
struct PINNAME_IMAGE;

const GUID CLSID_PINNAME_VIDEO_TIMECODE = {0xFB6C428B, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C428B, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_TIMECODE;

const GUID CLSID_PINNAME_VIDEO_VIDEOPORT_VBI = {0xFB6C428C, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0xFB6C428C, 0x0353, 0x11D1, [0x90, 0x5F, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PINNAME_VIDEO_VIDEOPORT_VBI;

enum CAPTURE_MEMORY_ALLOCATION_FLAGS
{
    KS_CAPTURE_ALLOC_INVALID = 0,
    KS_CAPTURE_ALLOC_SYSTEM = 1,
    KS_CAPTURE_ALLOC_VRAM = 2,
    KS_CAPTURE_ALLOC_SYSTEM_AGP = 4,
    KS_CAPTURE_ALLOC_VRAM_MAPPED = 8,
    KS_CAPTURE_ALLOC_SECURE_BUFFER = 16,
}

const GUID CLSID_KSPROPSETID_VramCapture = {0xE73FACE3, 0x2880, 0x4902, [0xB7, 0x99, 0x88, 0xD0, 0xCD, 0x63, 0x4E, 0x0F]};
@GUID(0xE73FACE3, 0x2880, 0x4902, [0xB7, 0x99, 0x88, 0xD0, 0xCD, 0x63, 0x4E, 0x0F]);
struct KSPROPSETID_VramCapture;

enum KSPROPERTY_VIDMEM_TRANSPORT
{
    KSPROPERTY_DISPLAY_ADAPTER_GUID = 1,
    KSPROPERTY_PREFERRED_CAPTURE_SURFACE = 2,
    KSPROPERTY_CURRENT_CAPTURE_SURFACE = 3,
    KSPROPERTY_MAP_CAPTURE_HANDLE_TO_VRAM_ADDRESS = 4,
}

struct VRAM_SURFACE_INFO
{
    uint hSurface;
    long VramPhysicalAddress;
    uint cbCaptured;
    uint dwWidth;
    uint dwHeight;
    uint dwLinearSize;
    int lPitch;
    ulong ullReserved;
}

struct VRAM_SURFACE_INFO_PROPERTY_S
{
    KSIDENTIFIER Property;
    VRAM_SURFACE_INFO* pVramSurfaceInfo;
}

struct SECURE_BUFFER_INFO
{
    Guid guidBufferIdentifier;
    uint cbBufferSize;
    uint cbCaptured;
    ulong ullReserved;
}

const GUID CLSID_KS_SECURE_CAMERA_SCENARIO_ID = {0xAE53FC6E, 0x8D89, 0x4488, [0x9D, 0x2E, 0x4D, 0x00, 0x87, 0x31, 0xC5, 0xFD]};
@GUID(0xAE53FC6E, 0x8D89, 0x4488, [0x9D, 0x2E, 0x4D, 0x00, 0x87, 0x31, 0xC5, 0xFD]);
struct KS_SECURE_CAMERA_SCENARIO_ID;

const GUID CLSID_KSPROPSETID_MPEG4_MediaType_Attributes = {0xFF6C4BFA, 0x07A9, 0x4C7B, [0xA2, 0x37, 0x67, 0x2F, 0x9D, 0x68, 0x06, 0x5F]};
@GUID(0xFF6C4BFA, 0x07A9, 0x4C7B, [0xA2, 0x37, 0x67, 0x2F, 0x9D, 0x68, 0x06, 0x5F]);
struct KSPROPSETID_MPEG4_MediaType_Attributes;

enum KSPROPERTY_MPEG4_MEDIATYPE_ATTRIBUTES
{
    KSPROPERTY_MPEG4_MEDIATYPE_SD_BOX = 1,
}

const GUID CLSID_KSEVENTSETID_DynamicFormatChange = {0x162AC456, 0x83D7, 0x4239, [0x96, 0xDF, 0xC7, 0x5F, 0xFA, 0x13, 0x8B, 0xC6]};
@GUID(0x162AC456, 0x83D7, 0x4239, [0x96, 0xDF, 0xC7, 0x5F, 0xFA, 0x13, 0x8B, 0xC6]);
struct KSEVENTSETID_DynamicFormatChange;

enum KSEVENT_DYNAMICFORMATCHANGE
{
    KSEVENT_DYNAMIC_FORMAT_CHANGE = 0,
}

struct KS_FRAME_INFO
{
    uint ExtendedHeaderSize;
    uint dwFrameFlags;
    long PictureNumber;
    long DropCount;
    HANDLE hDirectDraw;
    HANDLE hSurfaceHandle;
    RECT DirectDrawRect;
    _Anonymous1_e__Union Anonymous1;
    uint Reserved2;
    _Anonymous2_e__Union Anonymous2;
}

struct KS_VBI_FRAME_INFO
{
    uint ExtendedHeaderSize;
    uint dwFrameFlags;
    long PictureNumber;
    long DropCount;
    uint dwSamplingFrequency;
    KS_TVTUNER_CHANGE_INFO TvTunerChangeInfo;
    KS_VBIINFOHEADER VBIInfoHeader;
}

enum KS_AnalogVideoStandard
{
    KS_AnalogVideo_None = 0,
    KS_AnalogVideo_NTSC_M = 1,
    KS_AnalogVideo_NTSC_M_J = 2,
    KS_AnalogVideo_NTSC_433 = 4,
    KS_AnalogVideo_PAL_B = 16,
    KS_AnalogVideo_PAL_D = 32,
    KS_AnalogVideo_PAL_G = 64,
    KS_AnalogVideo_PAL_H = 128,
    KS_AnalogVideo_PAL_I = 256,
    KS_AnalogVideo_PAL_M = 512,
    KS_AnalogVideo_PAL_N = 1024,
    KS_AnalogVideo_PAL_60 = 2048,
    KS_AnalogVideo_SECAM_B = 4096,
    KS_AnalogVideo_SECAM_D = 8192,
    KS_AnalogVideo_SECAM_G = 16384,
    KS_AnalogVideo_SECAM_H = 32768,
    KS_AnalogVideo_SECAM_K = 65536,
    KS_AnalogVideo_SECAM_K1 = 131072,
    KS_AnalogVideo_SECAM_L = 262144,
    KS_AnalogVideo_SECAM_L1 = 524288,
    KS_AnalogVideo_PAL_N_COMBO = 1048576,
}

const GUID CLSID_PROPSETID_ALLOCATOR_CONTROL = {0x53171960, 0x148E, 0x11D2, [0x99, 0x79, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]};
@GUID(0x53171960, 0x148E, 0x11D2, [0x99, 0x79, 0x00, 0x00, 0xC0, 0xCC, 0x16, 0xBA]);
struct PROPSETID_ALLOCATOR_CONTROL;

enum KSPROPERTY_ALLOCATOR_CONTROL
{
    KSPROPERTY_ALLOCATOR_CONTROL_HONOR_COUNT = 0,
    KSPROPERTY_ALLOCATOR_CONTROL_SURFACE_SIZE = 1,
    KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_CAPS = 2,
    KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_INTERLEAVE = 3,
}

struct KSPROPERTY_ALLOCATOR_CONTROL_SURFACE_SIZE_S
{
    uint CX;
    uint CY;
}

struct KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_CAPS_S
{
    uint InterleavedCapSupported;
}

struct KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_INTERLEAVE_S
{
    uint InterleavedCapPossible;
}

const GUID CLSID_PROPSETID_VIDCAP_VIDEOPROCAMP = {0xC6E13360, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13360, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_VIDEOPROCAMP;

enum KSPROPERTY_VIDCAP_VIDEOPROCAMP
{
    KSPROPERTY_VIDEOPROCAMP_BRIGHTNESS = 0,
    KSPROPERTY_VIDEOPROCAMP_CONTRAST = 1,
    KSPROPERTY_VIDEOPROCAMP_HUE = 2,
    KSPROPERTY_VIDEOPROCAMP_SATURATION = 3,
    KSPROPERTY_VIDEOPROCAMP_SHARPNESS = 4,
    KSPROPERTY_VIDEOPROCAMP_GAMMA = 5,
    KSPROPERTY_VIDEOPROCAMP_COLORENABLE = 6,
    KSPROPERTY_VIDEOPROCAMP_WHITEBALANCE = 7,
    KSPROPERTY_VIDEOPROCAMP_BACKLIGHT_COMPENSATION = 8,
    KSPROPERTY_VIDEOPROCAMP_GAIN = 9,
    KSPROPERTY_VIDEOPROCAMP_DIGITAL_MULTIPLIER = 10,
    KSPROPERTY_VIDEOPROCAMP_DIGITAL_MULTIPLIER_LIMIT = 11,
    KSPROPERTY_VIDEOPROCAMP_WHITEBALANCE_COMPONENT = 12,
    KSPROPERTY_VIDEOPROCAMP_POWERLINE_FREQUENCY = 13,
}

struct KSPROPERTY_VIDEOPROCAMP_S
{
    KSIDENTIFIER Property;
    int Value;
    uint Flags;
    uint Capabilities;
}

struct KSPROPERTY_VIDEOPROCAMP_NODE_S
{
    KSP_NODE NodeProperty;
    int Value;
    uint Flags;
    uint Capabilities;
}

struct KSPROPERTY_VIDEOPROCAMP_S2
{
    KSIDENTIFIER Property;
    int Value1;
    uint Flags;
    uint Capabilities;
    int Value2;
}

struct KSPROPERTY_VIDEOPROCAMP_NODE_S2
{
    KSP_NODE NodeProperty;
    int Value1;
    uint Flags;
    uint Capabilities;
    int Value2;
}

const GUID CLSID_PROPSETID_VIDCAP_SELECTOR = {0x1ABDAECA, 0x68B6, 0x4F83, [0x93, 0x71, 0xB4, 0x13, 0x90, 0x7C, 0x7B, 0x9F]};
@GUID(0x1ABDAECA, 0x68B6, 0x4F83, [0x93, 0x71, 0xB4, 0x13, 0x90, 0x7C, 0x7B, 0x9F]);
struct PROPSETID_VIDCAP_SELECTOR;

enum KSPROPERTY_VIDCAP_SELECTOR
{
    KSPROPERTY_SELECTOR_SOURCE_NODE_ID = 0,
    KSPROPERTY_SELECTOR_NUM_SOURCES = 1,
}

struct KSPROPERTY_SELECTOR_S
{
    KSIDENTIFIER Property;
    int Value;
    uint Flags;
    uint Capabilities;
}

struct KSPROPERTY_SELECTOR_NODE_S
{
    KSP_NODE NodeProperty;
    int Value;
    uint Flags;
    uint Capabilities;
}

const GUID CLSID_PROPSETID_TUNER = {0x6A2E0605, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0605, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_TUNER;

enum KSPROPERTY_TUNER
{
    KSPROPERTY_TUNER_CAPS = 0,
    KSPROPERTY_TUNER_MODE_CAPS = 1,
    KSPROPERTY_TUNER_MODE = 2,
    KSPROPERTY_TUNER_STANDARD = 3,
    KSPROPERTY_TUNER_FREQUENCY = 4,
    KSPROPERTY_TUNER_INPUT = 5,
    KSPROPERTY_TUNER_STATUS = 6,
    KSPROPERTY_TUNER_IF_MEDIUM = 7,
    KSPROPERTY_TUNER_SCAN_CAPS = 8,
    KSPROPERTY_TUNER_SCAN_STATUS = 9,
    KSPROPERTY_TUNER_STANDARD_MODE = 10,
    KSPROPERTY_TUNER_NETWORKTYPE_SCAN_CAPS = 11,
}

enum KSPROPERTY_TUNER_MODES
{
    KSPROPERTY_TUNER_MODE_TV = 1,
    KSPROPERTY_TUNER_MODE_FM_RADIO = 2,
    KSPROPERTY_TUNER_MODE_AM_RADIO = 4,
    KSPROPERTY_TUNER_MODE_DSS = 8,
    KSPROPERTY_TUNER_MODE_ATSC = 16,
}

enum KS_TUNER_TUNING_FLAGS
{
    KS_TUNER_TUNING_EXACT = 1,
    KS_TUNER_TUNING_FINE = 2,
    KS_TUNER_TUNING_COARSE = 3,
}

enum KS_TUNER_STRATEGY
{
    KS_TUNER_STRATEGY_PLL = 1,
    KS_TUNER_STRATEGY_SIGNAL_STRENGTH = 2,
    KS_TUNER_STRATEGY_DRIVER_TUNES = 4,
}

struct KSPROPERTY_TUNER_CAPS_S
{
    KSIDENTIFIER Property;
    uint ModesSupported;
    KSIDENTIFIER VideoMedium;
    KSIDENTIFIER TVAudioMedium;
    KSIDENTIFIER RadioAudioMedium;
}

struct KSPROPERTY_TUNER_IF_MEDIUM_S
{
    KSIDENTIFIER Property;
    KSIDENTIFIER IFMedium;
}

struct KSPROPERTY_TUNER_MODE_CAPS_S
{
    KSIDENTIFIER Property;
    uint Mode;
    uint StandardsSupported;
    uint MinFrequency;
    uint MaxFrequency;
    uint TuningGranularity;
    uint NumberOfInputs;
    uint SettlingTime;
    uint Strategy;
}

struct KSPROPERTY_TUNER_MODE_S
{
    KSIDENTIFIER Property;
    uint Mode;
}

struct KSPROPERTY_TUNER_FREQUENCY_S
{
    KSIDENTIFIER Property;
    uint Frequency;
    uint LastFrequency;
    uint TuningFlags;
    uint VideoSubChannel;
    uint AudioSubChannel;
    uint Channel;
    uint Country;
}

struct KSPROPERTY_TUNER_STANDARD_S
{
    KSIDENTIFIER Property;
    uint Standard;
}

struct KSPROPERTY_TUNER_STANDARD_MODE_S
{
    KSIDENTIFIER Property;
    BOOL AutoDetect;
}

struct KSPROPERTY_TUNER_INPUT_S
{
    KSIDENTIFIER Property;
    uint InputIndex;
}

struct KSPROPERTY_TUNER_STATUS_S
{
    KSIDENTIFIER Property;
    uint CurrentFrequency;
    uint PLLOffset;
    uint SignalStrength;
    uint Busy;
}

enum _TunerDecoderLockType
{
    Tuner_LockType_None = 0,
    Tuner_LockType_Within_Scan_Sensing_Range = 1,
    Tuner_LockType_Locked = 2,
}

struct TUNER_ANALOG_CAPS_S
{
    uint Mode;
    uint StandardsSupported;
    uint MinFrequency;
    uint MaxFrequency;
    uint TuningGranularity;
    uint SettlingTime;
    uint ScanSensingRange;
    uint FineTuneSensingRange;
}

const GUID CLSID_EVENTSETID_TUNER = {0x6A2E0606, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0606, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct EVENTSETID_TUNER;

enum KSEVENT_TUNER
{
    KSEVENT_TUNER_CHANGED = 0,
    KSEVENT_TUNER_INITIATE_SCAN = 1,
}

struct KSPROPERTY_TUNER_SCAN_CAPS_S
{
    KSIDENTIFIER Property;
    BOOL fSupportsHardwareAssistedScanning;
    uint SupportedBroadcastStandards;
    void* GUIDBucket;
    uint lengthofBucket;
}

struct KSPROPERTY_TUNER_NETWORKTYPE_SCAN_CAPS_S
{
    KSIDENTIFIER Property;
    Guid NetworkType;
    uint BufferSize;
    void* NetworkTunerCapabilities;
}

struct KSPROPERTY_TUNER_SCAN_STATUS_S
{
    KSIDENTIFIER Property;
    _TunerDecoderLockType LockStatus;
    uint CurrentFrequency;
}

struct KSEVENT_TUNER_INITIATE_SCAN_S
{
    KSEVENTDATA EventData;
    uint StartFrequency;
    uint EndFrequency;
}

const GUID CLSID_KSNODETYPE_VIDEO_STREAMING = {0xDFF229E1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E1, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_STREAMING;

const GUID CLSID_KSNODETYPE_VIDEO_INPUT_TERMINAL = {0xDFF229E2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E2, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_INPUT_TERMINAL;

const GUID CLSID_KSNODETYPE_VIDEO_OUTPUT_TERMINAL = {0xDFF229E3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E3, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_OUTPUT_TERMINAL;

const GUID CLSID_KSNODETYPE_VIDEO_SELECTOR = {0xDFF229E4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E4, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_SELECTOR;

const GUID CLSID_KSNODETYPE_VIDEO_PROCESSING = {0xDFF229E5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E5, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_PROCESSING;

const GUID CLSID_KSNODETYPE_VIDEO_CAMERA_TERMINAL = {0xDFF229E6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E6, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_CAMERA_TERMINAL;

const GUID CLSID_KSNODETYPE_VIDEO_INPUT_MTT = {0xDFF229E7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E7, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_INPUT_MTT;

const GUID CLSID_KSNODETYPE_VIDEO_OUTPUT_MTT = {0xDFF229E8, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0xDFF229E8, 0xF70F, 0x11D0, [0xB9, 0x17, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSNODETYPE_VIDEO_OUTPUT_MTT;

const GUID CLSID_PROPSETID_VIDCAP_VIDEOENCODER = {0x6A2E0610, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0610, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_VIDEOENCODER;

enum KSPROPERTY_VIDCAP_VIDEOENCODER
{
    KSPROPERTY_VIDEOENCODER_CAPS = 0,
    KSPROPERTY_VIDEOENCODER_STANDARD = 1,
    KSPROPERTY_VIDEOENCODER_COPYPROTECTION = 2,
    KSPROPERTY_VIDEOENCODER_CC_ENABLE = 3,
}

struct KSPROPERTY_VIDEOENCODER_S
{
    KSIDENTIFIER Property;
    int Value;
    uint Flags;
    uint Capabilities;
}

const GUID CLSID_PROPSETID_VIDCAP_VIDEODECODER = {0xC6E13350, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13350, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_VIDEODECODER;

enum KSPROPERTY_VIDCAP_VIDEODECODER
{
    KSPROPERTY_VIDEODECODER_CAPS = 0,
    KSPROPERTY_VIDEODECODER_STANDARD = 1,
    KSPROPERTY_VIDEODECODER_STATUS = 2,
    KSPROPERTY_VIDEODECODER_OUTPUT_ENABLE = 3,
    KSPROPERTY_VIDEODECODER_VCR_TIMING = 4,
    KSPROPERTY_VIDEODECODER_STATUS2 = 5,
}

enum KS_VIDEODECODER_FLAGS
{
    KS_VIDEODECODER_FLAGS_CAN_DISABLE_OUTPUT = 1,
    KS_VIDEODECODER_FLAGS_CAN_USE_VCR_LOCKING = 2,
    KS_VIDEODECODER_FLAGS_CAN_INDICATE_LOCKED = 4,
}

struct KSPROPERTY_VIDEODECODER_CAPS_S
{
    KSIDENTIFIER Property;
    uint StandardsSupported;
    uint Capabilities;
    uint SettlingTime;
    uint HSyncPerVSync;
}

struct KSPROPERTY_VIDEODECODER_STATUS_S
{
    KSIDENTIFIER Property;
    uint NumberOfLines;
    uint SignalLocked;
}

struct KSPROPERTY_VIDEODECODER_STATUS2_S
{
    KSIDENTIFIER Property;
    uint NumberOfLines;
    uint SignalLocked;
    uint ChromaLock;
}

struct KSPROPERTY_VIDEODECODER_S
{
    KSIDENTIFIER Property;
    uint Value;
}

const GUID CLSID_EVENTSETID_VIDEODECODER = {0x6A2E0621, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0621, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct EVENTSETID_VIDEODECODER;

enum KSEVENT_VIDEODECODER
{
    KSEVENT_VIDEODECODER_CHANGED = 0,
}

const GUID CLSID_KSEVENTSETID_CameraAsyncControl = {0x22A11754, 0x9701, 0x4088, [0xB3, 0x3F, 0x6B, 0x9C, 0xBC, 0x52, 0xDF, 0x5E]};
@GUID(0x22A11754, 0x9701, 0x4088, [0xB3, 0x3F, 0x6B, 0x9C, 0xBC, 0x52, 0xDF, 0x5E]);
struct KSEVENTSETID_CameraAsyncControl;

enum KSEVENT_CAMERACONTROL
{
    KSEVENT_CAMERACONTROL_FOCUS = 0,
    KSEVENT_CAMERACONTROL_ZOOM = 1,
}

const GUID CLSID_PROPSETID_VIDCAP_CAMERACONTROL = {0xC6E13370, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13370, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_CAMERACONTROL;

enum KSPROPERTY_VIDCAP_CAMERACONTROL
{
    KSPROPERTY_CAMERACONTROL_PAN = 0,
    KSPROPERTY_CAMERACONTROL_TILT = 1,
    KSPROPERTY_CAMERACONTROL_ROLL = 2,
    KSPROPERTY_CAMERACONTROL_ZOOM = 3,
    KSPROPERTY_CAMERACONTROL_EXPOSURE = 4,
    KSPROPERTY_CAMERACONTROL_IRIS = 5,
    KSPROPERTY_CAMERACONTROL_FOCUS = 6,
    KSPROPERTY_CAMERACONTROL_SCANMODE = 7,
    KSPROPERTY_CAMERACONTROL_PRIVACY = 8,
    KSPROPERTY_CAMERACONTROL_PANTILT = 9,
    KSPROPERTY_CAMERACONTROL_PAN_RELATIVE = 10,
    KSPROPERTY_CAMERACONTROL_TILT_RELATIVE = 11,
    KSPROPERTY_CAMERACONTROL_ROLL_RELATIVE = 12,
    KSPROPERTY_CAMERACONTROL_ZOOM_RELATIVE = 13,
    KSPROPERTY_CAMERACONTROL_EXPOSURE_RELATIVE = 14,
    KSPROPERTY_CAMERACONTROL_IRIS_RELATIVE = 15,
    KSPROPERTY_CAMERACONTROL_FOCUS_RELATIVE = 16,
    KSPROPERTY_CAMERACONTROL_PANTILT_RELATIVE = 17,
    KSPROPERTY_CAMERACONTROL_FOCAL_LENGTH = 18,
    KSPROPERTY_CAMERACONTROL_AUTO_EXPOSURE_PRIORITY = 19,
}

enum KS_CameraControlAsyncOperation
{
    KS_CAMERACONTROL_ASYNC_START = 1,
    KS_CAMERACONTROL_ASYNC_STOP = 2,
    KS_CAMERACONTROL_ASYNC_RESET = 3,
}

struct KSPROPERTY_CAMERACONTROL_S_EX
{
    KSIDENTIFIER Property;
    int Value;
    uint Flags;
    uint Capabilities;
    RECT FocusRect;
}

struct KSPROPERTY_CAMERACONTROL_S
{
    KSIDENTIFIER Property;
    int Value;
    uint Flags;
    uint Capabilities;
}

struct KSPROPERTY_CAMERACONTROL_NODE_S
{
    KSP_NODE NodeProperty;
    int Value;
    uint Flags;
    uint Capabilities;
}

struct KSPROPERTY_CAMERACONTROL_S2
{
    KSIDENTIFIER Property;
    int Value1;
    uint Flags;
    uint Capabilities;
    int Value2;
}

struct KSPROPERTY_CAMERACONTROL_NODE_S2
{
    KSP_NODE NodeProperty;
    int Value1;
    uint Flags;
    uint Capabilities;
    int Value2;
}

struct KSPROPERTY_CAMERACONTROL_FOCAL_LENGTH_S
{
    KSIDENTIFIER Property;
    int lOcularFocalLength;
    int lObjectiveFocalLengthMin;
    int lObjectiveFocalLengthMax;
}

struct KSPROPERTY_CAMERACONTROL_NODE_FOCAL_LENGTH_S
{
    KSNODEPROPERTY NodeProperty;
    int lOcularFocalLength;
    int lObjectiveFocalLengthMin;
    int lObjectiveFocalLengthMax;
}

const GUID CLSID_PROPSETID_VIDCAP_CAMERACONTROL_FLASH = {0x785E8F49, 0x63A2, 0x4144, [0xAB, 0x70, 0xFF, 0xB2, 0x78, 0xFA, 0x26, 0xCE]};
@GUID(0x785E8F49, 0x63A2, 0x4144, [0xAB, 0x70, 0xFF, 0xB2, 0x78, 0xFA, 0x26, 0xCE]);
struct PROPSETID_VIDCAP_CAMERACONTROL_FLASH;

enum KSPROPERTY_CAMERACONTROL_FLASH
{
    KSPROPERTY_CAMERACONTROL_FLASH_PROPERTY_ID = 0,
}

struct KSPROPERTY_CAMERACONTROL_FLASH_S
{
    uint Flash;
    uint Capabilities;
}

const GUID CLSID_PROPSETID_VIDCAP_CAMERACONTROL_VIDEO_STABILIZATION = {0x43964BD3, 0x7716, 0x404E, [0x8B, 0xE1, 0xD2, 0x99, 0xB2, 0x0E, 0x50, 0xFD]};
@GUID(0x43964BD3, 0x7716, 0x404E, [0x8B, 0xE1, 0xD2, 0x99, 0xB2, 0x0E, 0x50, 0xFD]);
struct PROPSETID_VIDCAP_CAMERACONTROL_VIDEO_STABILIZATION;

enum KSPROPERTY_CAMERACONTROL_VIDEO_STABILIZATION_MODE
{
    KSPROPERTY_CAMERACONTROL_VIDEO_STABILIZATION_MODE_PROPERTY_ID = 0,
}

struct KSPROPERTY_CAMERACONTROL_VIDEOSTABILIZATION_MODE_S
{
    uint VideoStabilizationMode;
    uint Capabilities;
}

const GUID CLSID_PROPSETID_VIDCAP_CAMERACONTROL_REGION_OF_INTEREST = {0x9D12D198, 0xF86C, 0x4FED, [0xB0, 0x23, 0x5D, 0x87, 0x65, 0x3D, 0xA7, 0x93]};
@GUID(0x9D12D198, 0xF86C, 0x4FED, [0xB0, 0x23, 0x5D, 0x87, 0x65, 0x3D, 0xA7, 0x93]);
struct PROPSETID_VIDCAP_CAMERACONTROL_REGION_OF_INTEREST;

enum KSPROPERTY_CAMERACONTROL_REGION_OF_INTEREST
{
    KSPROPERTY_CAMERACONTROL_REGION_OF_INTEREST_PROPERTY_ID = 0,
}

const GUID CLSID_EVENTSETID_VIDCAP_CAMERACONTROL_REGION_OF_INTEREST = {0x2FDFFC5D, 0xC732, 0x4BA6, [0xB5, 0xDF, 0x6B, 0x4D, 0x7F, 0xC8, 0x8B, 0x8B]};
@GUID(0x2FDFFC5D, 0xC732, 0x4BA6, [0xB5, 0xDF, 0x6B, 0x4D, 0x7F, 0xC8, 0x8B, 0x8B]);
struct EVENTSETID_VIDCAP_CAMERACONTROL_REGION_OF_INTEREST;

struct KSPROPERTY_CAMERACONTROL_REGION_OF_INTEREST_S
{
    RECT FocusRect;
    BOOL AutoFocusLock;
    BOOL AutoExposureLock;
    BOOL AutoWhitebalanceLock;
    _Anonymous_e__Union Anonymous;
}

const GUID CLSID_PROPSETID_VIDCAP_CAMERACONTROL_IMAGE_PIN_CAPABILITY = {0x9D3D7BBF, 0x5C6D, 0x4138, [0xBB, 0x00, 0x58, 0x4E, 0xDD, 0x20, 0xF7, 0xC5]};
@GUID(0x9D3D7BBF, 0x5C6D, 0x4138, [0xBB, 0x00, 0x58, 0x4E, 0xDD, 0x20, 0xF7, 0xC5]);
struct PROPSETID_VIDCAP_CAMERACONTROL_IMAGE_PIN_CAPABILITY;

enum KSPROPERTY_CAMERACONTROL_IMAGE_PIN_CAPABILITY
{
    KSPROPERTY_CAMERACONTROL_IMAGE_PIN_CAPABILITY_PROPERTY_ID = 0,
}

struct KSPROPERTY_CAMERACONTROL_IMAGE_PIN_CAPABILITY_S
{
    uint Capabilities;
    uint Reserved0;
}

enum KSPROPERTY_CAMERACONTROL_EXTENDED_PROPERTY
{
    KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOMODE = 0,
    KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOFRAMERATE = 1,
    KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOMAXFRAMERATE = 2,
    KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOTRIGGERTIME = 3,
    KSPROPERTY_CAMERACONTROL_EXTENDED_WARMSTART = 4,
    KSPROPERTY_CAMERACONTROL_EXTENDED_MAXVIDFPS_PHOTORES = 5,
    KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOTHUMBNAIL = 6,
    KSPROPERTY_CAMERACONTROL_EXTENDED_SCENEMODE = 7,
    KSPROPERTY_CAMERACONTROL_EXTENDED_TORCHMODE = 8,
    KSPROPERTY_CAMERACONTROL_EXTENDED_FLASHMODE = 9,
    KSPROPERTY_CAMERACONTROL_EXTENDED_OPTIMIZATIONHINT = 10,
    KSPROPERTY_CAMERACONTROL_EXTENDED_WHITEBALANCEMODE = 11,
    KSPROPERTY_CAMERACONTROL_EXTENDED_EXPOSUREMODE = 12,
    KSPROPERTY_CAMERACONTROL_EXTENDED_FOCUSMODE = 13,
    KSPROPERTY_CAMERACONTROL_EXTENDED_ISO = 14,
    KSPROPERTY_CAMERACONTROL_EXTENDED_FIELDOFVIEW = 15,
    KSPROPERTY_CAMERACONTROL_EXTENDED_EVCOMPENSATION = 16,
    KSPROPERTY_CAMERACONTROL_EXTENDED_CAMERAANGLEOFFSET = 17,
    KSPROPERTY_CAMERACONTROL_EXTENDED_METADATA = 18,
    KSPROPERTY_CAMERACONTROL_EXTENDED_FOCUSPRIORITY = 19,
    KSPROPERTY_CAMERACONTROL_EXTENDED_FOCUSSTATE = 20,
    KSPROPERTY_CAMERACONTROL_EXTENDED_ROI_CONFIGCAPS = 21,
    KSPROPERTY_CAMERACONTROL_EXTENDED_ROI_ISPCONTROL = 22,
    KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOCONFIRMATION = 23,
    KSPROPERTY_CAMERACONTROL_EXTENDED_ZOOM = 24,
    KSPROPERTY_CAMERACONTROL_EXTENDED_MCC = 25,
    KSPROPERTY_CAMERACONTROL_EXTENDED_ISO_ADVANCED = 26,
    KSPROPERTY_CAMERACONTROL_EXTENDED_VIDEOSTABILIZATION = 27,
    KSPROPERTY_CAMERACONTROL_EXTENDED_VFR = 28,
    KSPROPERTY_CAMERACONTROL_EXTENDED_FACEDETECTION = 29,
    KSPROPERTY_CAMERACONTROL_EXTENDED_VIDEOHDR = 30,
    KSPROPERTY_CAMERACONTROL_EXTENDED_HISTOGRAM = 31,
    KSPROPERTY_CAMERACONTROL_EXTENDED_OIS = 32,
    KSPROPERTY_CAMERACONTROL_EXTENDED_ADVANCEDPHOTO = 33,
    KSPROPERTY_CAMERACONTROL_EXTENDED_PROFILE = 34,
    KSPROPERTY_CAMERACONTROL_EXTENDED_FACEAUTH_MODE = 35,
    KSPROPERTY_CAMERACONTROL_EXTENDED_SECURE_MODE = 36,
    KSPROPERTY_CAMERACONTROL_EXTENDED_VIDEOTEMPORALDENOISING = 37,
    KSPROPERTY_CAMERACONTROL_EXTENDED_IRTORCHMODE = 38,
    KSPROPERTY_CAMERACONTROL_EXTENDED_RELATIVEPANELOPTIMIZATION = 39,
    KSPROPERTY_CAMERACONTROL_EXTENDED_END = 40,
    KSPROPERTY_CAMERACONTROL_EXTENDED_END2 = 40,
}

const GUID CLSID_KSPROPERTYSETID_ExtendedCameraControl = {0x1CB79112, 0xC0D2, 0x4213, [0x9C, 0xA6, 0xCD, 0x4F, 0xDB, 0x92, 0x79, 0x72]};
@GUID(0x1CB79112, 0xC0D2, 0x4213, [0x9C, 0xA6, 0xCD, 0x4F, 0xDB, 0x92, 0x79, 0x72]);
struct KSPROPERTYSETID_ExtendedCameraControl;

const GUID CLSID_KSEVENTSETID_ExtendedCameraControl = {0x571C92C9, 0x13A2, 0x47E3, [0xA6, 0x49, 0xD2, 0xA7, 0x78, 0x16, 0x63, 0x84]};
@GUID(0x571C92C9, 0x13A2, 0x47E3, [0xA6, 0x49, 0xD2, 0xA7, 0x78, 0x16, 0x63, 0x84]);
struct KSEVENTSETID_ExtendedCameraControl;

const GUID CLSID_KSEVENTSETID_CameraEvent = {0x7899B2E0, 0x6B43, 0x4964, [0x9D, 0x2A, 0xA2, 0x1F, 0x40, 0x61, 0xF5, 0x76]};
@GUID(0x7899B2E0, 0x6B43, 0x4964, [0x9D, 0x2A, 0xA2, 0x1F, 0x40, 0x61, 0xF5, 0x76]);
struct KSEVENTSETID_CameraEvent;

enum KSEVENT_CAMERAEVENT
{
    KSEVENT_PHOTO_SAMPLE_SCANNED = 0,
}

enum KSCAMERA_EXTENDEDPROP_WHITEBALANCE_MODE
{
    KSCAMERA_EXTENDEDPROP_WHITEBALANCE_TEMPERATURE = 1,
    KSCAMERA_EXTENDEDPROP_WHITEBALANCE_PRESET = 2,
}

enum KSCAMERA_EXTENDEDPROP_WBPRESET
{
    KSCAMERA_EXTENDEDPROP_WBPRESET_CLOUDY = 1,
    KSCAMERA_EXTENDEDPROP_WBPRESET_DAYLIGHT = 2,
    KSCAMERA_EXTENDEDPROP_WBPRESET_FLASH = 3,
    KSCAMERA_EXTENDEDPROP_WBPRESET_FLUORESCENT = 4,
    KSCAMERA_EXTENDEDPROP_WBPRESET_TUNGSTEN = 5,
    KSCAMERA_EXTENDEDPROP_WBPRESET_CANDLELIGHT = 6,
}

enum KSPROPERTY_CAMERA_PHOTOTRIGGERTIME_FLAGS
{
    KSPROPERTY_CAMERA_PHOTOTRIGGERTIME_CLEAR = 0,
    KSPROPERTY_CAMERA_PHOTOTRIGGERTIME_SET = 1,
}

struct KSCAMERA_EXTENDEDPROP_HEADER
{
    uint Version;
    uint PinId;
    uint Size;
    uint Result;
    ulong Flags;
    ulong Capability;
}

struct KSCAMERA_EXTENDEDPROP_VALUE
{
    _Value_e__Union Value;
}

struct KSCAMERA_MAXVIDEOFPS_FORPHOTORES
{
    uint PhotoResWidth;
    uint PhotoResHeight;
    uint PreviewFPSNum;
    uint PreviewFPSDenom;
    uint CaptureFPSNum;
    uint CaptureFPSDenom;
}

struct KSCAMERA_EXTENDEDPROP_PHOTOMODE
{
    uint RequestedHistoryFrames;
    uint MaxHistoryFrames;
    uint SubMode;
    uint Reserved;
}

struct KSCAMERA_EXTENDEDPROP_VIDEOPROCSETTING
{
    uint Mode;
    int Min;
    int Max;
    int Step;
    KSCAMERA_EXTENDEDPROP_VALUE VideoProc;
    ulong Reserved;
}

struct KSCAMERA_EXTENDEDPROP_EVCOMPENSATION
{
    uint Mode;
    int Min;
    int Max;
    int Value;
    ulong Reserved;
}

struct KSCAMERA_EXTENDEDPROP_FIELDOFVIEW
{
    uint NormalizedFocalLengthX;
    uint NormalizedFocalLengthY;
    uint Flag;
    uint Reserved;
}

struct KSCAMERA_EXTENDEDPROP_CAMERAOFFSET
{
    int PitchAngle;
    int YawAngle;
    uint Flag;
    uint Reserved;
}

struct KSCAMERA_EXTENDEDPROP_METADATAINFO
{
    int BufferAlignment;
    uint MaxMetadataBufferSize;
}

enum KSCAMERA_EXTENDEDPROP_MetadataAlignment
{
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_16 = 4,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_32 = 5,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_64 = 6,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_128 = 7,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_256 = 8,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_512 = 9,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_1024 = 10,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_2048 = 11,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_4096 = 12,
    KSCAMERA_EXTENDEDPROP_MetadataAlignment_8192 = 13,
}

enum KSCAMERA_MetadataId
{
    MetadataId_Standard_Start = 1,
    MetadataId_PhotoConfirmation = 1,
    MetadataId_UsbVideoHeader = 2,
    MetadataId_CaptureStats = 3,
    MetadataId_CameraExtrinsics = 4,
    MetadataId_CameraIntrinsics = 5,
    MetadataId_FrameIllumination = 6,
    MetadataId_Standard_End = 6,
    MetadataId_Custom_Start = -2147483648,
}

struct KSCAMERA_METADATA_ITEMHEADER
{
    uint MetadataId;
    uint Size;
}

struct KSCAMERA_METADATA_PHOTOCONFIRMATION
{
    KSCAMERA_METADATA_ITEMHEADER Header;
    uint PhotoConfirmationIndex;
    uint Reserved;
}

struct KSCAMERA_METADATA_FRAMEILLUMINATION
{
    KSCAMERA_METADATA_ITEMHEADER Header;
    uint Flags;
    uint Reserved;
}

struct KSCAMERA_METADATA_CAPTURESTATS
{
    KSCAMERA_METADATA_ITEMHEADER Header;
    uint Flags;
    uint Reserved;
    ulong ExposureTime;
    ulong ExposureCompensationFlags;
    int ExposureCompensationValue;
    uint IsoSpeed;
    uint FocusState;
    uint LensPosition;
    uint WhiteBalance;
    uint Flash;
    uint FlashPower;
    uint ZoomFactor;
    ulong SceneMode;
    ulong SensorFramerate;
}

enum KSCAMERA_EXTENDEDPROP_FOCUSSTATE
{
    KSCAMERA_EXTENDEDPROP_FOCUSSTATE_UNINITIALIZED = 0,
    KSCAMERA_EXTENDEDPROP_FOCUSSTATE_LOST = 1,
    KSCAMERA_EXTENDEDPROP_FOCUSSTATE_SEARCHING = 2,
    KSCAMERA_EXTENDEDPROP_FOCUSSTATE_FOCUSED = 3,
    KSCAMERA_EXTENDEDPROP_FOCUSSTATE_FAILED = 4,
}

struct KSCAMERA_EXTENDEDPROP_ROI_CONFIGCAPSHEADER
{
    uint Size;
    uint ConfigCapCount;
    ulong Reserved;
}

struct KSCAMERA_EXTENDEDPROP_ROI_CONFIGCAPS
{
    uint ControlId;
    uint MaxNumberOfROIs;
    ulong Capability;
}

struct KSCAMERA_EXTENDEDPROP_ROI_ISPCONTROLHEADER
{
    uint Size;
    uint ControlCount;
    ulong Reserved;
}

struct KSCAMERA_EXTENDEDPROP_ROI_ISPCONTROL
{
    uint ControlId;
    uint ROICount;
    uint Result;
    uint Reserved;
}

struct KSCAMERA_EXTENDEDPROP_ROI_INFO
{
    RECT Region;
    ulong Flags;
    int Weight;
    int RegionOfInterestType;
}

enum KSCAMERA_EXTENDEDPROP_ROITYPE
{
    KSCAMERA_EXTENDEDPROP_ROITYPE_UNKNOWN = 0,
    KSCAMERA_EXTENDEDPROP_ROITYPE_FACE = 1,
}

struct KSCAMERA_EXTENDEDPROP_ROI_WHITEBALANCE
{
    KSCAMERA_EXTENDEDPROP_ROI_INFO ROIInfo;
    ulong Reserved;
}

struct KSCAMERA_EXTENDEDPROP_ROI_EXPOSURE
{
    KSCAMERA_EXTENDEDPROP_ROI_INFO ROIInfo;
    ulong Reserved;
}

struct KSCAMERA_EXTENDEDPROP_ROI_FOCUS
{
    KSCAMERA_EXTENDEDPROP_ROI_INFO ROIInfo;
    ulong Reserved;
}

const GUID CLSID_KSPROPERTYSETID_PerFrameSettingControl = {0xF1F3E261, 0xDEE6, 0x4537, [0xBF, 0xF5, 0xEE, 0x20, 0x6D, 0xB5, 0x4A, 0xAC]};
@GUID(0xF1F3E261, 0xDEE6, 0x4537, [0xBF, 0xF5, 0xEE, 0x20, 0x6D, 0xB5, 0x4A, 0xAC]);
struct KSPROPERTYSETID_PerFrameSettingControl;

enum KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_PROPERTY
{
    KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_CAPABILITY = 0,
    KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_SET = 1,
    KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_CLEAR = 2,
}

enum KSCAMERA_PERFRAMESETTING_ITEM_TYPE
{
    KSCAMERA_PERFRAMESETTING_ITEM_EXPOSURE_TIME = 1,
    KSCAMERA_PERFRAMESETTING_ITEM_FLASH = 2,
    KSCAMERA_PERFRAMESETTING_ITEM_EXPOSURE_COMPENSATION = 3,
    KSCAMERA_PERFRAMESETTING_ITEM_ISO = 4,
    KSCAMERA_PERFRAMESETTING_ITEM_FOCUS = 5,
    KSCAMERA_PERFRAMESETTING_ITEM_PHOTOCONFIRMATION = 6,
    KSCAMERA_PERFRAMESETTING_ITEM_CUSTOM = 7,
}

struct KSCAMERA_PERFRAMESETTING_CAP_ITEM_HEADER
{
    uint Size;
    uint Type;
    ulong Flags;
}

struct KSCAMERA_PERFRAMESETTING_CAP_HEADER
{
    uint Size;
    uint ItemCount;
    ulong Flags;
}

struct KSCAMERA_PERFRAMESETTING_CUSTOM_ITEM
{
    uint Size;
    uint Reserved;
    Guid Id;
}

struct KSCAMERA_PERFRAMESETTING_ITEM_HEADER
{
    uint Size;
    uint Type;
    ulong Flags;
}

struct KSCAMERA_PERFRAMESETTING_FRAME_HEADER
{
    uint Size;
    uint Id;
    uint ItemCount;
    uint Reserved;
}

struct KSCAMERA_PERFRAMESETTING_HEADER
{
    uint Size;
    uint FrameCount;
    Guid Id;
    ulong Flags;
    uint LoopCount;
    uint Reserved;
}

struct KSCAMERA_EXTENDEDPROP_PROFILE
{
    Guid ProfileId;
    uint Index;
    uint Reserved;
}

const GUID CLSID_KSCAMERAPROFILE_Legacy = {0xB4894D81, 0x62B7, 0x4EEC, [0x87, 0x40, 0x80, 0x65, 0x8C, 0x4A, 0x9D, 0x3E]};
@GUID(0xB4894D81, 0x62B7, 0x4EEC, [0x87, 0x40, 0x80, 0x65, 0x8C, 0x4A, 0x9D, 0x3E]);
struct KSCAMERAPROFILE_Legacy;

const GUID CLSID_KSCAMERAPROFILE_VideoRecording = {0xA0E517E8, 0x8F8C, 0x4F6F, [0x9A, 0x57, 0x46, 0xFC, 0x2F, 0x64, 0x7E, 0xC0]};
@GUID(0xA0E517E8, 0x8F8C, 0x4F6F, [0x9A, 0x57, 0x46, 0xFC, 0x2F, 0x64, 0x7E, 0xC0]);
struct KSCAMERAPROFILE_VideoRecording;

const GUID CLSID_KSCAMERAPROFILE_HighQualityPhoto = {0x32440725, 0x961B, 0x4CA3, [0xB5, 0xB2, 0x85, 0x4E, 0x71, 0x9D, 0x9E, 0x1B]};
@GUID(0x32440725, 0x961B, 0x4CA3, [0xB5, 0xB2, 0x85, 0x4E, 0x71, 0x9D, 0x9E, 0x1B]);
struct KSCAMERAPROFILE_HighQualityPhoto;

const GUID CLSID_KSCAMERAPROFILE_BalancedVideoAndPhoto = {0x6B52B017, 0x42C7, 0x4A21, [0xBF, 0xE3, 0x23, 0xF0, 0x09, 0x14, 0x98, 0x87]};
@GUID(0x6B52B017, 0x42C7, 0x4A21, [0xBF, 0xE3, 0x23, 0xF0, 0x09, 0x14, 0x98, 0x87]);
struct KSCAMERAPROFILE_BalancedVideoAndPhoto;

const GUID CLSID_KSCAMERAPROFILE_VideoConferencing = {0xC5444A88, 0xE1BF, 0x4597, [0xB2, 0xDD, 0x9E, 0x1E, 0xAD, 0x86, 0x4B, 0xB8]};
@GUID(0xC5444A88, 0xE1BF, 0x4597, [0xB2, 0xDD, 0x9E, 0x1E, 0xAD, 0x86, 0x4B, 0xB8]);
struct KSCAMERAPROFILE_VideoConferencing;

const GUID CLSID_KSCAMERAPROFILE_PhotoSequence = {0x02399D9D, 0x4EE8, 0x49BA, [0xBC, 0x07, 0x5F, 0xF1, 0x56, 0x53, 0x14, 0x13]};
@GUID(0x02399D9D, 0x4EE8, 0x49BA, [0xBC, 0x07, 0x5F, 0xF1, 0x56, 0x53, 0x14, 0x13]);
struct KSCAMERAPROFILE_PhotoSequence;

const GUID CLSID_KSCAMERAPROFILE_FaceAuth_Mode = {0x81361B22, 0x700B, 0x4546, [0xA2, 0xD4, 0xC5, 0x2E, 0x90, 0x7B, 0xFC, 0x27]};
@GUID(0x81361B22, 0x700B, 0x4546, [0xA2, 0xD4, 0xC5, 0x2E, 0x90, 0x7B, 0xFC, 0x27]);
struct KSCAMERAPROFILE_FaceAuth_Mode;

const GUID CLSID_KSCAMERAPROFILE_HighFrameRate = {0x566E6113, 0x8C35, 0x48E7, [0xB8, 0x9F, 0xD2, 0x3F, 0xDC, 0x12, 0x19, 0xDC]};
@GUID(0x566E6113, 0x8C35, 0x48E7, [0xB8, 0x9F, 0xD2, 0x3F, 0xDC, 0x12, 0x19, 0xDC]);
struct KSCAMERAPROFILE_HighFrameRate;

const GUID CLSID_KSCAMERAPROFILE_HDRWithWCGVideo = {0x4B27C336, 0x4924, 0x4989, [0xB9, 0x94, 0xFD, 0xAF, 0x1D, 0xC7, 0xCD, 0x85]};
@GUID(0x4B27C336, 0x4924, 0x4989, [0xB9, 0x94, 0xFD, 0xAF, 0x1D, 0xC7, 0xCD, 0x85]);
struct KSCAMERAPROFILE_HDRWithWCGVideo;

const GUID CLSID_KSCAMERAPROFILE_HDRWithWCGPhoto = {0x9BF6F1FF, 0xB555, 0x4625, [0xB3, 0x26, 0xA4, 0x6D, 0xEF, 0x31, 0x8F, 0xB7]};
@GUID(0x9BF6F1FF, 0xB555, 0x4625, [0xB3, 0x26, 0xA4, 0x6D, 0xEF, 0x31, 0x8F, 0xB7]);
struct KSCAMERAPROFILE_HDRWithWCGPhoto;

const GUID CLSID_KSCAMERAPROFILE_VariablePhotoSequence = {0x9FF2CB56, 0xE75A, 0x49B1, [0xA9, 0x28, 0x99, 0x85, 0xD5, 0x94, 0x6F, 0x87]};
@GUID(0x9FF2CB56, 0xE75A, 0x49B1, [0xA9, 0x28, 0x99, 0x85, 0xD5, 0x94, 0x6F, 0x87]);
struct KSCAMERAPROFILE_VariablePhotoSequence;

const GUID CLSID_KSCAMERAPROFILE_VideoHDR8 = {0xD4F3F4EC, 0xBDFF, 0x4314, [0xB1, 0xD4, 0x00, 0x8E, 0x28, 0x1F, 0x74, 0xE7]};
@GUID(0xD4F3F4EC, 0xBDFF, 0x4314, [0xB1, 0xD4, 0x00, 0x8E, 0x28, 0x1F, 0x74, 0xE7]);
struct KSCAMERAPROFILE_VideoHDR8;

struct KSCAMERA_PROFILE_MEDIAINFO
{
    _Resolution_e__Struct Resolution;
    _MaxFrameRate_e__Struct MaxFrameRate;
    ulong Flags;
    uint Data0;
    uint Data1;
    uint Data2;
    uint Data3;
}

struct KSCAMERA_PROFILE_PININFO
{
    Guid PinCategory;
    _Anonymous_e__Union Anonymous;
    uint MediaInfoCount;
    KSCAMERA_PROFILE_MEDIAINFO* MediaInfos;
}

struct KSCAMERA_PROFILE_INFO
{
    Guid ProfileId;
    uint Index;
    uint PinCount;
    KSCAMERA_PROFILE_PININFO* Pins;
}

struct KSCAMERA_PROFILE_CONCURRENCYINFO
{
    Guid ReferenceGuid;
    uint Reserved;
    uint ProfileCount;
    KSCAMERA_PROFILE_INFO* Profiles;
}

struct KSDEVICE_PROFILE_INFO
{
    uint Type;
    uint Size;
    _Anonymous_e__Union Anonymous;
}

struct WNF_KSCAMERA_STREAMSTATE_INFO
{
    uint ProcessId;
    uint SessionId;
    uint StreamState;
    uint Reserved;
}

enum KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE
{
    KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE_DISABLE = 0,
    KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE_HOSTNTP = 1,
    KSPROPERYT_NETWORKCAMERACONTROL_NTPINFO_TYPE_CUSTOM = 2,
}

struct KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_HEADER
{
    uint Size;
    KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE Type;
}

const GUID CLSID_KSPROPERTYSETID_NetworkCameraControl = {0x0E780F09, 0x5745, 0x4E3A, [0xBC, 0x9F, 0xF2, 0x26, 0xEA, 0x43, 0xA6, 0xEC]};
@GUID(0x0E780F09, 0x5745, 0x4E3A, [0xBC, 0x9F, 0xF2, 0x26, 0xEA, 0x43, 0xA6, 0xEC]);
struct KSPROPERTYSETID_NetworkCameraControl;

enum KSPROPERTY_NETWORKCAMERACONTROL_PROPERTY
{
    KSPROPERTY_NETWORKCAMERACONTROL_NTP = 0,
    KSPROPERTY_NETWORKCAMERACONTROL_URI = 1,
}

const GUID CLSID_PROPSETID_EXT_DEVICE = {0xB5730A90, 0x1A2C, 0x11CF, [0x8C, 0x23, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0xB5730A90, 0x1A2C, 0x11CF, [0x8C, 0x23, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
struct PROPSETID_EXT_DEVICE;

enum KSPROPERTY_EXTDEVICE
{
    KSPROPERTY_EXTDEVICE_ID = 0,
    KSPROPERTY_EXTDEVICE_VERSION = 1,
    KSPROPERTY_EXTDEVICE_POWER_STATE = 2,
    KSPROPERTY_EXTDEVICE_PORT = 3,
    KSPROPERTY_EXTDEVICE_CAPABILITIES = 4,
}

struct DEVCAPS
{
    int CanRecord;
    int CanRecordStrobe;
    int HasAudio;
    int HasVideo;
    int UsesFiles;
    int CanSave;
    int DeviceType;
    int TCRead;
    int TCWrite;
    int CTLRead;
    int IndexRead;
    int Preroll;
    int Postroll;
    int SyncAcc;
    int NormRate;
    int CanPreview;
    int CanMonitorSrc;
    int CanTest;
    int VideoIn;
    int AudioIn;
    int Calibrate;
    int SeekType;
    int SimulatedHardware;
}

struct KSPROPERTY_EXTDEVICE_S
{
    KSIDENTIFIER Property;
    _u_e__Union u;
}

const GUID CLSID_PROPSETID_EXT_TRANSPORT = {0xA03CD5F0, 0x3045, 0x11CF, [0x8C, 0x44, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0xA03CD5F0, 0x3045, 0x11CF, [0x8C, 0x44, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
struct PROPSETID_EXT_TRANSPORT;

enum KSPROPERTY_EXTXPORT
{
    KSPROPERTY_EXTXPORT_CAPABILITIES = 0,
    KSPROPERTY_EXTXPORT_INPUT_SIGNAL_MODE = 1,
    KSPROPERTY_EXTXPORT_OUTPUT_SIGNAL_MODE = 2,
    KSPROPERTY_EXTXPORT_LOAD_MEDIUM = 3,
    KSPROPERTY_EXTXPORT_MEDIUM_INFO = 4,
    KSPROPERTY_EXTXPORT_STATE = 5,
    KSPROPERTY_EXTXPORT_STATE_NOTIFY = 6,
    KSPROPERTY_EXTXPORT_TIMECODE_SEARCH = 7,
    KSPROPERTY_EXTXPORT_ATN_SEARCH = 8,
    KSPROPERTY_EXTXPORT_RTC_SEARCH = 9,
    KSPROPERTY_RAW_AVC_CMD = 10,
}

struct TRANSPORTSTATUS
{
    int Mode;
    int LastError;
    int RecordInhibit;
    int ServoLock;
    int MediaPresent;
    int MediaLength;
    int MediaSize;
    int MediaTrackCount;
    int MediaTrackLength;
    int MediaTrackSide;
    int MediaType;
    int LinkMode;
    int NotifyOn;
}

struct TRANSPORTBASICPARMS
{
    int TimeFormat;
    int TimeReference;
    int Superimpose;
    int EndStopAction;
    int RecordFormat;
    int StepFrames;
    int SetpField;
    int Preroll;
    int RecPreroll;
    int Postroll;
    int EditDelay;
    int PlayTCDelay;
    int RecTCDelay;
    int EditField;
    int FrameServo;
    int ColorFrameServo;
    int ServoRef;
    int WarnGenlock;
    int SetTracking;
    byte VolumeName;
    int Ballistic;
    int Speed;
    int CounterFormat;
    int TunerChannel;
    int TunerNumber;
    int TimerEvent;
    int TimerStartDay;
    int TimerStartTime;
    int TimerStopDay;
    int TimerStopTime;
}

struct TRANSPORTVIDEOPARMS
{
    int OutputMode;
    int Input;
}

struct TRANSPORTAUDIOPARMS
{
    int EnableOutput;
    int EnableRecord;
    int EnableSelsync;
    int Input;
    int MonitorSource;
}

struct MEDIUM_INFO
{
    BOOL MediaPresent;
    uint MediaType;
    BOOL RecordInhibit;
}

struct TRANSPORT_STATE
{
    uint Mode;
    uint State;
}

struct KSPROPERTY_EXTXPORT_S
{
    KSIDENTIFIER Property;
    _u_e__Union u;
}

struct KSPROPERTY_EXTXPORT_NODE_S
{
    KSP_NODE NodeProperty;
    _u_e__Union u;
}

const GUID CLSID_PROPSETID_TIMECODE_READER = {0x9B496CE1, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]};
@GUID(0x9B496CE1, 0x811B, 0x11CF, [0x8C, 0x77, 0x00, 0xAA, 0x00, 0x6B, 0x68, 0x14]);
struct PROPSETID_TIMECODE_READER;

enum KSPROPERTY_TIMECODE
{
    KSPROPERTY_TIMECODE_READER = 0,
    KSPROPERTY_ATN_READER = 1,
    KSPROPERTY_RTC_READER = 2,
}

struct KSPROPERTY_TIMECODE_S
{
    KSIDENTIFIER Property;
    TIMECODE_SAMPLE TimecodeSamp;
}

struct KSPROPERTY_TIMECODE_NODE_S
{
    KSP_NODE NodeProperty;
    TIMECODE_SAMPLE TimecodeSamp;
}

const GUID CLSID_KSEVENTSETID_EXTDEV_Command = {0x109C7988, 0xB3CB, 0x11D2, [0xB4, 0x8E, 0x00, 0x60, 0x97, 0xB3, 0x39, 0x1B]};
@GUID(0x109C7988, 0xB3CB, 0x11D2, [0xB4, 0x8E, 0x00, 0x60, 0x97, 0xB3, 0x39, 0x1B]);
struct KSEVENTSETID_EXTDEV_Command;

enum KSEVENT_DEVCMD
{
    KSEVENT_EXTDEV_COMMAND_NOTIFY_INTERIM_READY = 0,
    KSEVENT_EXTDEV_COMMAND_CONTROL_INTERIM_READY = 1,
    KSEVENT_EXTDEV_COMMAND_BUSRESET = 2,
    KSEVENT_EXTDEV_TIMECODE_UPDATE = 3,
    KSEVENT_EXTDEV_OPERATION_MODE_UPDATE = 4,
    KSEVENT_EXTDEV_TRANSPORT_STATE_UPDATE = 5,
    KSEVENT_EXTDEV_NOTIFY_REMOVAL = 6,
    KSEVENT_EXTDEV_NOTIFY_MEDIUM_CHANGE = 7,
}

const GUID CLSID_PROPSETID_VIDCAP_CROSSBAR = {0x6A2E0640, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0640, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_CROSSBAR;

enum KSPROPERTY_VIDCAP_CROSSBAR
{
    KSPROPERTY_CROSSBAR_CAPS = 0,
    KSPROPERTY_CROSSBAR_PININFO = 1,
    KSPROPERTY_CROSSBAR_CAN_ROUTE = 2,
    KSPROPERTY_CROSSBAR_ROUTE = 3,
    KSPROPERTY_CROSSBAR_INPUT_ACTIVE = 4,
}

struct KSPROPERTY_CROSSBAR_CAPS_S
{
    KSIDENTIFIER Property;
    uint NumberOfInputs;
    uint NumberOfOutputs;
}

struct KSPROPERTY_CROSSBAR_PININFO_S
{
    KSIDENTIFIER Property;
    KSPIN_DATAFLOW Direction;
    uint Index;
    uint PinType;
    uint RelatedPinIndex;
    KSIDENTIFIER Medium;
}

struct KSPROPERTY_CROSSBAR_ROUTE_S
{
    KSIDENTIFIER Property;
    uint IndexInputPin;
    uint IndexOutputPin;
    uint CanRoute;
}

struct KSPROPERTY_CROSSBAR_ACTIVE_S
{
    KSIDENTIFIER Property;
    uint IndexInputPin;
    uint Active;
}

const GUID CLSID_EVENTSETID_CROSSBAR = {0x6A2E0641, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0641, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct EVENTSETID_CROSSBAR;

enum KSEVENT_CROSSBAR
{
    KSEVENT_CROSSBAR_CHANGED = 0,
}

enum KS_PhysicalConnectorType
{
    KS_PhysConn_Video_Tuner = 1,
    KS_PhysConn_Video_Composite = 2,
    KS_PhysConn_Video_SVideo = 3,
    KS_PhysConn_Video_RGB = 4,
    KS_PhysConn_Video_YRYBY = 5,
    KS_PhysConn_Video_SerialDigital = 6,
    KS_PhysConn_Video_ParallelDigital = 7,
    KS_PhysConn_Video_SCSI = 8,
    KS_PhysConn_Video_AUX = 9,
    KS_PhysConn_Video_1394 = 10,
    KS_PhysConn_Video_USB = 11,
    KS_PhysConn_Video_VideoDecoder = 12,
    KS_PhysConn_Video_VideoEncoder = 13,
    KS_PhysConn_Video_SCART = 14,
    KS_PhysConn_Audio_Tuner = 4096,
    KS_PhysConn_Audio_Line = 4097,
    KS_PhysConn_Audio_Mic = 4098,
    KS_PhysConn_Audio_AESDigital = 4099,
    KS_PhysConn_Audio_SPDIFDigital = 4100,
    KS_PhysConn_Audio_SCSI = 4101,
    KS_PhysConn_Audio_AUX = 4102,
    KS_PhysConn_Audio_1394 = 4103,
    KS_PhysConn_Audio_USB = 4104,
    KS_PhysConn_Audio_AudioDecoder = 4105,
}

const GUID CLSID_PROPSETID_VIDCAP_TVAUDIO = {0x6A2E0650, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0650, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_TVAUDIO;

enum KSPROPERTY_VIDCAP_TVAUDIO
{
    KSPROPERTY_TVAUDIO_CAPS = 0,
    KSPROPERTY_TVAUDIO_MODE = 1,
    KSPROPERTY_TVAUDIO_CURRENTLY_AVAILABLE_MODES = 2,
}

struct KSPROPERTY_TVAUDIO_CAPS_S
{
    KSIDENTIFIER Property;
    uint Capabilities;
    KSIDENTIFIER InputMedium;
    KSIDENTIFIER OutputMedium;
}

struct KSPROPERTY_TVAUDIO_S
{
    KSIDENTIFIER Property;
    uint Mode;
}

const GUID CLSID_KSEVENTSETID_VIDCAP_TVAUDIO = {0x6A2E0651, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0651, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct KSEVENTSETID_VIDCAP_TVAUDIO;

enum KSEVENT_TVAUDIO
{
    KSEVENT_TVAUDIO_CHANGED = 0,
}

const GUID CLSID_PROPSETID_VIDCAP_VIDEOCOMPRESSION = {0xC6E13343, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13343, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_VIDEOCOMPRESSION;

enum KSPROPERTY_VIDCAP_VIDEOCOMPRESSION
{
    KSPROPERTY_VIDEOCOMPRESSION_GETINFO = 0,
    KSPROPERTY_VIDEOCOMPRESSION_KEYFRAME_RATE = 1,
    KSPROPERTY_VIDEOCOMPRESSION_PFRAMES_PER_KEYFRAME = 2,
    KSPROPERTY_VIDEOCOMPRESSION_QUALITY = 3,
    KSPROPERTY_VIDEOCOMPRESSION_OVERRIDE_KEYFRAME = 4,
    KSPROPERTY_VIDEOCOMPRESSION_OVERRIDE_FRAME_SIZE = 5,
    KSPROPERTY_VIDEOCOMPRESSION_WINDOWSIZE = 6,
}

enum KS_CompressionCaps
{
    KS_CompressionCaps_CanQuality = 1,
    KS_CompressionCaps_CanCrunch = 2,
    KS_CompressionCaps_CanKeyFrame = 4,
    KS_CompressionCaps_CanBFrame = 8,
    KS_CompressionCaps_CanWindow = 16,
}

enum KS_VideoStreamingHints
{
    KS_StreamingHint_FrameInterval = 256,
    KS_StreamingHint_KeyFrameRate = 512,
    KS_StreamingHint_PFrameRate = 1024,
    KS_StreamingHint_CompQuality = 2048,
    KS_StreamingHint_CompWindowSize = 4096,
}

struct KSPROPERTY_VIDEOCOMPRESSION_GETINFO_S
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    int DefaultKeyFrameRate;
    int DefaultPFrameRate;
    int DefaultQuality;
    int NumberOfQualitySettings;
    int Capabilities;
}

struct KSPROPERTY_VIDEOCOMPRESSION_S
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    int Value;
}

struct KSPROPERTY_VIDEOCOMPRESSION_S1
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    int Value;
    uint Flags;
}

const GUID CLSID_KSDATAFORMAT_SUBTYPE_OVERLAY = {0xE436EB7F, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]};
@GUID(0xE436EB7F, 0x524F, 0x11CE, [0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0B, 0xA7, 0x70]);
struct KSDATAFORMAT_SUBTYPE_OVERLAY;

const GUID CLSID_KSPROPSETID_OverlayUpdate = {0x490EA5CF, 0x7681, 0x11D1, [0xA2, 0x1C, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]};
@GUID(0x490EA5CF, 0x7681, 0x11D1, [0xA2, 0x1C, 0x00, 0xA0, 0xC9, 0x22, 0x31, 0x96]);
struct KSPROPSETID_OverlayUpdate;

enum KSPROPERTY_OVERLAYUPDATE
{
    KSPROPERTY_OVERLAYUPDATE_INTERESTS = 0,
    KSPROPERTY_OVERLAYUPDATE_CLIPLIST = 1,
    KSPROPERTY_OVERLAYUPDATE_PALETTE = 2,
    KSPROPERTY_OVERLAYUPDATE_COLORKEY = 4,
    KSPROPERTY_OVERLAYUPDATE_VIDEOPOSITION = 8,
    KSPROPERTY_OVERLAYUPDATE_DISPLAYCHANGE = 16,
    KSPROPERTY_OVERLAYUPDATE_COLORREF = 268435456,
}

struct KSDISPLAYCHANGE
{
    uint PelsWidth;
    uint PelsHeight;
    uint BitsPerPel;
    ushort DeviceID;
}

const GUID CLSID_PROPSETID_VIDCAP_VIDEOCONTROL = {0x6A2E0670, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0x6A2E0670, 0x28E4, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_VIDEOCONTROL;

enum KSPROPERTY_VIDCAP_VIDEOCONTROL
{
    KSPROPERTY_VIDEOCONTROL_CAPS = 0,
    KSPROPERTY_VIDEOCONTROL_ACTUAL_FRAME_RATE = 1,
    KSPROPERTY_VIDEOCONTROL_FRAME_RATES = 2,
    KSPROPERTY_VIDEOCONTROL_MODE = 3,
}

enum KS_VideoControlFlags
{
    KS_VideoControlFlag_FlipHorizontal = 1,
    KS_VideoControlFlag_FlipVertical = 2,
    KS_Obsolete_VideoControlFlag_ExternalTriggerEnable = 16,
    KS_Obsolete_VideoControlFlag_Trigger = 32,
    KS_VideoControlFlag_ExternalTriggerEnable = 4,
    KS_VideoControlFlag_Trigger = 8,
    KS_VideoControlFlag_IndependentImagePin = 64,
    KS_VideoControlFlag_StillCapturePreviewFrame = 128,
    KS_VideoControlFlag_StartPhotoSequenceCapture = 256,
    KS_VideoControlFlag_StopPhotoSequenceCapture = 512,
}

struct KSPROPERTY_VIDEOCONTROL_CAPS_S
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    uint VideoControlCaps;
}

struct KSPROPERTY_VIDEOCONTROL_MODE_S
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    int Mode;
}

struct KSPROPERTY_VIDEOCONTROL_ACTUAL_FRAME_RATE_S
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    uint RangeIndex;
    SIZE Dimensions;
    long CurrentActualFrameRate;
    long CurrentMaxAvailableFrameRate;
}

struct KSPROPERTY_VIDEOCONTROL_FRAME_RATES_S
{
    KSIDENTIFIER Property;
    uint StreamIndex;
    uint RangeIndex;
    SIZE Dimensions;
}

const GUID CLSID_PROPSETID_VIDCAP_DROPPEDFRAMES = {0xC6E13344, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]};
@GUID(0xC6E13344, 0x30AC, 0x11D0, [0xA1, 0x8C, 0x00, 0xA0, 0xC9, 0x11, 0x89, 0x56]);
struct PROPSETID_VIDCAP_DROPPEDFRAMES;

enum KSPROPERTY_VIDCAP_DROPPEDFRAMES
{
    KSPROPERTY_DROPPEDFRAMES_CURRENT = 0,
}

struct KSPROPERTY_DROPPEDFRAMES_CURRENT_S
{
    KSIDENTIFIER Property;
    long PictureNumber;
    long DropCount;
    uint AverageFrameSize;
}

const GUID CLSID_KSPROPSETID_VPConfig = {0xBC29A660, 0x30E3, 0x11D0, [0x9E, 0x69, 0x00, 0xC0, 0x4F, 0xD7, 0xC1, 0x5B]};
@GUID(0xBC29A660, 0x30E3, 0x11D0, [0x9E, 0x69, 0x00, 0xC0, 0x4F, 0xD7, 0xC1, 0x5B]);
struct KSPROPSETID_VPConfig;

const GUID CLSID_KSPROPSETID_VPVBIConfig = {0xEC529B00, 0x1A1F, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]};
@GUID(0xEC529B00, 0x1A1F, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]);
struct KSPROPSETID_VPVBIConfig;

enum KSPROPERTY_VPCONFIG
{
    KSPROPERTY_VPCONFIG_NUMCONNECTINFO = 0,
    KSPROPERTY_VPCONFIG_GETCONNECTINFO = 1,
    KSPROPERTY_VPCONFIG_SETCONNECTINFO = 2,
    KSPROPERTY_VPCONFIG_VPDATAINFO = 3,
    KSPROPERTY_VPCONFIG_MAXPIXELRATE = 4,
    KSPROPERTY_VPCONFIG_INFORMVPINPUT = 5,
    KSPROPERTY_VPCONFIG_NUMVIDEOFORMAT = 6,
    KSPROPERTY_VPCONFIG_GETVIDEOFORMAT = 7,
    KSPROPERTY_VPCONFIG_SETVIDEOFORMAT = 8,
    KSPROPERTY_VPCONFIG_INVERTPOLARITY = 9,
    KSPROPERTY_VPCONFIG_DECIMATIONCAPABILITY = 10,
    KSPROPERTY_VPCONFIG_SCALEFACTOR = 11,
    KSPROPERTY_VPCONFIG_DDRAWHANDLE = 12,
    KSPROPERTY_VPCONFIG_VIDEOPORTID = 13,
    KSPROPERTY_VPCONFIG_DDRAWSURFACEHANDLE = 14,
    KSPROPERTY_VPCONFIG_SURFACEPARAMS = 15,
}

const GUID CLSID_CLSID_KsIBasicAudioInterfaceHandler = {0xB9F8AC3E, 0x0F71, 0x11D2, [0xB7, 0x2C, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]};
@GUID(0xB9F8AC3E, 0x0F71, 0x11D2, [0xB7, 0x2C, 0x00, 0xC0, 0x4F, 0xB6, 0xBD, 0x3D]);
struct CLSID_KsIBasicAudioInterfaceHandler;

struct DDVIDEOPORTCONNECT
{
    uint dwSize;
    uint dwPortWidth;
    Guid guidTypeID;
    uint dwFlags;
    uint dwReserved1;
}

enum KS_AMPixAspectRatio
{
    KS_PixAspectRatio_NTSC4x3 = 0,
    KS_PixAspectRatio_NTSC16x9 = 1,
    KS_PixAspectRatio_PAL4x3 = 2,
    KS_PixAspectRatio_PAL16x9 = 3,
}

enum KS_AMVP_SELECTFORMATBY
{
    KS_AMVP_DO_NOT_CARE = 0,
    KS_AMVP_BEST_BANDWIDTH = 1,
    KS_AMVP_INPUT_SAME_AS_OUTPUT = 2,
}

enum KS_AMVP_MODE
{
    KS_AMVP_MODE_WEAVE = 0,
    KS_AMVP_MODE_BOBINTERLEAVED = 1,
    KS_AMVP_MODE_BOBNONINTERLEAVED = 2,
    KS_AMVP_MODE_SKIPEVEN = 3,
    KS_AMVP_MODE_SKIPODD = 4,
}

struct KS_AMVPDIMINFO
{
    uint dwFieldWidth;
    uint dwFieldHeight;
    uint dwVBIWidth;
    uint dwVBIHeight;
    RECT rcValidRegion;
}

struct KS_AMVPDATAINFO
{
    uint dwSize;
    uint dwMicrosecondsPerField;
    KS_AMVPDIMINFO amvpDimInfo;
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

struct KS_AMVPSIZE
{
    uint dwWidth;
    uint dwHeight;
}

struct KSVPMAXPIXELRATE
{
    KS_AMVPSIZE Size;
    uint MaxPixelsPerSecond;
    uint Reserved;
}

struct KSVPSIZE_PROP
{
    KSIDENTIFIER Property;
    KS_AMVPSIZE Size;
}

struct KSVPSURFACEPARAMS
{
    uint dwPitch;
    uint dwXOrigin;
    uint dwYOrigin;
}

const GUID CLSID_KSEVENTSETID_VPNotify = {0x20C5598E, 0xD3C8, 0x11D0, [0x8D, 0xFC, 0x00, 0xC0, 0x4F, 0xD7, 0xC0, 0x8B]};
@GUID(0x20C5598E, 0xD3C8, 0x11D0, [0x8D, 0xFC, 0x00, 0xC0, 0x4F, 0xD7, 0xC0, 0x8B]);
struct KSEVENTSETID_VPNotify;

enum KSEVENT_VPNOTIFY
{
    KSEVENT_VPNOTIFY_FORMATCHANGE = 0,
}

const GUID CLSID_KSEVENTSETID_VIDCAPTOSTI = {0xDB47DE20, 0xF628, 0x11D1, [0xBA, 0x41, 0x00, 0xA0, 0xC9, 0x0D, 0x2B, 0x05]};
@GUID(0xDB47DE20, 0xF628, 0x11D1, [0xBA, 0x41, 0x00, 0xA0, 0xC9, 0x0D, 0x2B, 0x05]);
struct KSEVENTSETID_VIDCAPTOSTI;

enum KSEVENT_VIDCAPTOSTI
{
    KSEVENT_VIDCAPTOSTI_EXT_TRIGGER = 0,
    KSEVENT_VIDCAP_AUTO_UPDATE = 1,
    KSEVENT_VIDCAP_SEARCH = 2,
}

enum KSPROPERTY_EXTENSION_UNIT
{
    KSPROPERTY_EXTENSION_UNIT_INFO = 0,
    KSPROPERTY_EXTENSION_UNIT_CONTROL = 1,
    KSPROPERTY_EXTENSION_UNIT_PASS_THROUGH = 65535,
}

const GUID CLSID_KSEVENTSETID_VPVBINotify = {0xEC529B01, 0x1A1F, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]};
@GUID(0xEC529B01, 0x1A1F, 0x11D1, [0xBA, 0xD9, 0x00, 0x60, 0x97, 0x44, 0x11, 0x1A]);
struct KSEVENTSETID_VPVBINotify;

enum KSEVENT_VPVBINOTIFY
{
    KSEVENT_VPVBINOTIFY_FORMATCHANGE = 0,
}

const GUID CLSID_KSDATAFORMAT_TYPE_AUXLine21Data = {0x670AEA80, 0x3A82, 0x11D0, [0xB7, 0x9B, 0x00, 0xAA, 0x00, 0x37, 0x67, 0xA7]};
@GUID(0x670AEA80, 0x3A82, 0x11D0, [0xB7, 0x9B, 0x00, 0xAA, 0x00, 0x37, 0x67, 0xA7]);
struct KSDATAFORMAT_TYPE_AUXLine21Data;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_Line21_BytePair = {0x6E8D4A22, 0x310C, 0x11D0, [0xB7, 0x9A, 0x00, 0xAA, 0x00, 0x37, 0x67, 0xA7]};
@GUID(0x6E8D4A22, 0x310C, 0x11D0, [0xB7, 0x9A, 0x00, 0xAA, 0x00, 0x37, 0x67, 0xA7]);
struct KSDATAFORMAT_SUBTYPE_Line21_BytePair;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_Line21_GOPPacket = {0x6E8D4A23, 0x310C, 0x11D0, [0xB7, 0x9A, 0x00, 0xAA, 0x00, 0x37, 0x67, 0xA7]};
@GUID(0x6E8D4A23, 0x310C, 0x11D0, [0xB7, 0x9A, 0x00, 0xAA, 0x00, 0x37, 0x67, 0xA7]);
struct KSDATAFORMAT_SUBTYPE_Line21_GOPPacket;

struct KSGOP_USERDATA
{
    uint sc;
    uint reserved1;
    ubyte cFields;
    byte l21Data;
}

const GUID CLSID_KSDATAFORMAT_TYPE_DVD_ENCRYPTED_PACK = {0xED0B916A, 0x044D, 0x11D1, [0xAA, 0x78, 0x00, 0xC0, 0x4F, 0xC3, 0x1D, 0x60]};
@GUID(0xED0B916A, 0x044D, 0x11D1, [0xAA, 0x78, 0x00, 0xC0, 0x4F, 0xC3, 0x1D, 0x60]);
struct KSDATAFORMAT_TYPE_DVD_ENCRYPTED_PACK;

const GUID CLSID_KSPROPSETID_TSRateChange = {0xA503C5C0, 0x1D1D, 0x11D1, [0xAD, 0x80, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0xA503C5C0, 0x1D1D, 0x11D1, [0xAD, 0x80, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct KSPROPSETID_TSRateChange;

enum KS_AM_PROPERTY_TS_RATE_CHANGE
{
    KS_AM_RATE_SimpleRateChange = 1,
    KS_AM_RATE_ExactRateChange = 2,
    KS_AM_RATE_MaxFullDataRate = 3,
    KS_AM_RATE_Step = 4,
}

struct KS_AM_SimpleRateChange
{
    long StartTime;
    int Rate;
}

struct KS_AM_ExactRateChange
{
    long OutputZeroTime;
    int Rate;
}

const GUID CLSID_KSCATEGORY_ENCODER = {0x19689BF6, 0xC384, 0x48FD, [0xAD, 0x51, 0x90, 0xE5, 0x8C, 0x79, 0xF7, 0x0B]};
@GUID(0x19689BF6, 0xC384, 0x48FD, [0xAD, 0x51, 0x90, 0xE5, 0x8C, 0x79, 0xF7, 0x0B]);
struct KSCATEGORY_ENCODER;

const GUID CLSID_KSCATEGORY_MULTIPLEXER = {0x7A5DE1D3, 0x01A1, 0x452C, [0xB4, 0x81, 0x4F, 0xA2, 0xB9, 0x62, 0x71, 0xE8]};
@GUID(0x7A5DE1D3, 0x01A1, 0x452C, [0xB4, 0x81, 0x4F, 0xA2, 0xB9, 0x62, 0x71, 0xE8]);
struct KSCATEGORY_MULTIPLEXER;

const GUID CLSID_ENCAPIPARAM_BITRATE = {0x49CC4C43, 0xCA83, 0x4AD4, [0xA9, 0xAF, 0xF3, 0x69, 0x6A, 0xF6, 0x66, 0xDF]};
@GUID(0x49CC4C43, 0xCA83, 0x4AD4, [0xA9, 0xAF, 0xF3, 0x69, 0x6A, 0xF6, 0x66, 0xDF]);
struct ENCAPIPARAM_BITRATE;

const GUID CLSID_ENCAPIPARAM_PEAK_BITRATE = {0x703F16A9, 0x3D48, 0x44A1, [0xB0, 0x77, 0x01, 0x8D, 0xFF, 0x91, 0x5D, 0x19]};
@GUID(0x703F16A9, 0x3D48, 0x44A1, [0xB0, 0x77, 0x01, 0x8D, 0xFF, 0x91, 0x5D, 0x19]);
struct ENCAPIPARAM_PEAK_BITRATE;

const GUID CLSID_ENCAPIPARAM_BITRATE_MODE = {0xEE5FB25C, 0xC713, 0x40D1, [0x9D, 0x58, 0xC0, 0xD7, 0x24, 0x1E, 0x25, 0x0F]};
@GUID(0xEE5FB25C, 0xC713, 0x40D1, [0x9D, 0x58, 0xC0, 0xD7, 0x24, 0x1E, 0x25, 0x0F]);
struct ENCAPIPARAM_BITRATE_MODE;

const GUID CLSID_CODECAPI_CHANGELISTS = {0x62B12ACF, 0xF6B0, 0x47D9, [0x94, 0x56, 0x96, 0xF2, 0x2C, 0x4E, 0x0B, 0x9D]};
@GUID(0x62B12ACF, 0xF6B0, 0x47D9, [0x94, 0x56, 0x96, 0xF2, 0x2C, 0x4E, 0x0B, 0x9D]);
struct CODECAPI_CHANGELISTS;

const GUID CLSID_CODECAPI_VIDEO_ENCODER = {0x7112E8E1, 0x3D03, 0x47EF, [0x8E, 0x60, 0x03, 0xF1, 0xCF, 0x53, 0x73, 0x01]};
@GUID(0x7112E8E1, 0x3D03, 0x47EF, [0x8E, 0x60, 0x03, 0xF1, 0xCF, 0x53, 0x73, 0x01]);
struct CODECAPI_VIDEO_ENCODER;

const GUID CLSID_CODECAPI_AUDIO_ENCODER = {0xB9D19A3E, 0xF897, 0x429C, [0xBC, 0x46, 0x81, 0x38, 0xB7, 0x27, 0x2B, 0x2D]};
@GUID(0xB9D19A3E, 0xF897, 0x429C, [0xBC, 0x46, 0x81, 0x38, 0xB7, 0x27, 0x2B, 0x2D]);
struct CODECAPI_AUDIO_ENCODER;

const GUID CLSID_CODECAPI_SETALLDEFAULTS = {0x6C5E6A7C, 0xACF8, 0x4F55, [0xA9, 0x99, 0x1A, 0x62, 0x81, 0x09, 0x05, 0x1B]};
@GUID(0x6C5E6A7C, 0xACF8, 0x4F55, [0xA9, 0x99, 0x1A, 0x62, 0x81, 0x09, 0x05, 0x1B]);
struct CODECAPI_SETALLDEFAULTS;

const GUID CLSID_CODECAPI_ALLSETTINGS = {0x6A577E92, 0x83E1, 0x4113, [0xAD, 0xC2, 0x4F, 0xCE, 0xC3, 0x2F, 0x83, 0xA1]};
@GUID(0x6A577E92, 0x83E1, 0x4113, [0xAD, 0xC2, 0x4F, 0xCE, 0xC3, 0x2F, 0x83, 0xA1]);
struct CODECAPI_ALLSETTINGS;

const GUID CLSID_CODECAPI_SUPPORTSEVENTS = {0x0581AF97, 0x7693, 0x4DBD, [0x9D, 0xCA, 0x3F, 0x9E, 0xBD, 0x65, 0x85, 0xA1]};
@GUID(0x0581AF97, 0x7693, 0x4DBD, [0x9D, 0xCA, 0x3F, 0x9E, 0xBD, 0x65, 0x85, 0xA1]);
struct CODECAPI_SUPPORTSEVENTS;

const GUID CLSID_CODECAPI_CURRENTCHANGELIST = {0x1CB14E83, 0x7D72, 0x4657, [0x83, 0xFD, 0x47, 0xA2, 0xC5, 0xB9, 0xD1, 0x3D]};
@GUID(0x1CB14E83, 0x7D72, 0x4657, [0x83, 0xFD, 0x47, 0xA2, 0xC5, 0xB9, 0xD1, 0x3D]);
struct CODECAPI_CURRENTCHANGELIST;

const GUID CLSID_KSPROPSETID_Jack = {0x4509F757, 0x2D46, 0x4637, [0x8E, 0x62, 0xCE, 0x7D, 0xB9, 0x44, 0xF5, 0x7B]};
@GUID(0x4509F757, 0x2D46, 0x4637, [0x8E, 0x62, 0xCE, 0x7D, 0xB9, 0x44, 0xF5, 0x7B]);
struct KSPROPSETID_Jack;

enum KSPROPERTY_JACK
{
    KSPROPERTY_JACK_DESCRIPTION = 1,
    KSPROPERTY_JACK_DESCRIPTION2 = 2,
    KSPROPERTY_JACK_SINK_INFO = 3,
    KSPROPERTY_JACK_CONTAINERID = 4,
}

enum EPcxConnectionType
{
    eConnTypeUnknown = 0,
    eConnType3Point5mm = 1,
    eConnTypeQuarter = 2,
    eConnTypeAtapiInternal = 3,
    eConnTypeRCA = 4,
    eConnTypeOptical = 5,
    eConnTypeOtherDigital = 6,
    eConnTypeOtherAnalog = 7,
    eConnTypeMultichannelAnalogDIN = 8,
    eConnTypeXlrProfessional = 9,
    eConnTypeRJ11Modem = 10,
    eConnTypeCombination = 11,
}

enum EPcxGeoLocation
{
    eGeoLocRear = 1,
    eGeoLocFront = 2,
    eGeoLocLeft = 3,
    eGeoLocRight = 4,
    eGeoLocTop = 5,
    eGeoLocBottom = 6,
    eGeoLocRearPanel = 7,
    eGeoLocRiser = 8,
    eGeoLocInsideMobileLid = 9,
    eGeoLocDrivebay = 10,
    eGeoLocHDMI = 11,
    eGeoLocOutsideMobileLid = 12,
    eGeoLocATAPI = 13,
    eGeoLocNotApplicable = 14,
    eGeoLocReserved6 = 15,
    EPcxGeoLocation_enum_count = 16,
}

enum EPcxGenLocation
{
    eGenLocPrimaryBox = 0,
    eGenLocInternal = 1,
    eGenLocSeparate = 2,
    eGenLocOther = 3,
    EPcxGenLocation_enum_count = 4,
}

enum EPxcPortConnection
{
    ePortConnJack = 0,
    ePortConnIntegratedDevice = 1,
    ePortConnBothIntegratedAndJack = 2,
    ePortConnUnknown = 3,
}

struct KSJACK_DESCRIPTION
{
    uint ChannelMapping;
    uint Color;
    EPcxConnectionType ConnectionType;
    EPcxGeoLocation GeoLocation;
    EPcxGenLocation GenLocation;
    EPxcPortConnection PortConnection;
    BOOL IsConnected;
}

enum KSJACK_SINK_CONNECTIONTYPE
{
    KSJACK_SINK_CONNECTIONTYPE_HDMI = 0,
    KSJACK_SINK_CONNECTIONTYPE_DISPLAYPORT = 1,
}

struct KSJACK_SINK_INFORMATION
{
    KSJACK_SINK_CONNECTIONTYPE ConnType;
    ushort ManufacturerId;
    ushort ProductId;
    ushort AudioLatency;
    BOOL HDCPCapable;
    BOOL AICapable;
    ubyte SinkDescriptionLength;
    ushort SinkDescription;
    LUID PortId;
}

struct KSJACK_DESCRIPTION2
{
    uint DeviceStateInfo;
    uint JackCapabilities;
}

const GUID CLSID_KSPROPSETID_AudioPosture = {0xDB14E8DA, 0x0267, 0x4AAB, [0x87, 0x59, 0xBA, 0xC8, 0x8E, 0x46, 0xB6, 0x53]};
@GUID(0xDB14E8DA, 0x0267, 0x4AAB, [0x87, 0x59, 0xBA, 0xC8, 0x8E, 0x46, 0xB6, 0x53]);
struct KSPROPSETID_AudioPosture;

enum KSPROPERTY_AUDIOPOSTURE
{
    KSPROPERTY_AUDIOPOSTURE_DESCRIPTION = 1,
}

enum AUDIOPOSTURE_PANEL_ORIENTATION
{
    AUDIOPOSTURE_PANEL_ORIENTATION_NOTROTATED = 0,
    AUDIOPOSTURE_PANEL_ORIENTATION_ROTATED90DEGREESCOUNTERCLOCKWISE = 1,
    AUDIOPOSTURE_PANEL_ORIENTATION_ROTATED180DEGREESCOUNTERCLOCKWISE = 2,
    AUDIOPOSTURE_PANEL_ORIENTATION_ROTATED270DEGREESCOUNTERCLOCKWISE = 3,
    AUDIOPOSTURE_PANEL_ORIENTATION_FACEUP = 4,
    AUDIOPOSTURE_PANEL_ORIENTATION_FACEDOWN = 5,
    AUDIOPOSTURE_PANEL_ORIENTATION_COUNT = 6,
}

enum AUDIOPOSTURE_PANEL_POWER
{
    AUDIOPOSTURE_PANEL_POWER_OFF = 0,
    AUDIOPOSTURE_PANEL_POWER_ON = 1,
}

struct KSAUDIOPOSTURE_PANEL_STATE
{
    AUDIOPOSTURE_PANEL_POWER Power;
    AUDIOPOSTURE_PANEL_ORIENTATION Orientation;
}

enum AUDIOPOSTURE_MEMBER_FLAGS
{
    AUDIOPOSTURE_MEMBER_FLAGS_HINGEANGLE = 1,
    AUDIOPOSTURE_MEMBER_FLAGS_PANELSTATE = 2,
}

struct KSAUDIOPOSTURE_DESCRIPTION
{
    uint CbSize;
    uint MembersListCount;
}

const GUID CLSID_KSPROPSETID_AudioBufferDuration = {0x4E73C07F, 0x23CC, 0x4955, [0xA7, 0xEA, 0x3D, 0xA5, 0x02, 0x49, 0x62, 0x90]};
@GUID(0x4E73C07F, 0x23CC, 0x4955, [0xA7, 0xEA, 0x3D, 0xA5, 0x02, 0x49, 0x62, 0x90]);
struct KSPROPSETID_AudioBufferDuration;

const GUID CLSID_KSPROPSETID_AudioEngine = {0x3A2F82DC, 0x886F, 0x4BAA, [0x9E, 0xB4, 0x08, 0x2B, 0x90, 0x25, 0xC5, 0x36]};
@GUID(0x3A2F82DC, 0x886F, 0x4BAA, [0x9E, 0xB4, 0x08, 0x2B, 0x90, 0x25, 0xC5, 0x36]);
struct KSPROPSETID_AudioEngine;

enum KSPROPERTY_AUDIOENGINE
{
    KSPROPERTY_AUDIOENGINE_LFXENABLE = 0,
    KSPROPERTY_AUDIOENGINE_GFXENABLE = 1,
    KSPROPERTY_AUDIOENGINE_MIXFORMAT = 2,
    KSPROPERTY_AUDIOENGINE_DEVICEFORMAT = 4,
    KSPROPERTY_AUDIOENGINE_SUPPORTEDDEVICEFORMATS = 5,
    KSPROPERTY_AUDIOENGINE_DESCRIPTOR = 6,
    KSPROPERTY_AUDIOENGINE_BUFFER_SIZE_RANGE = 7,
    KSPROPERTY_AUDIOENGINE_LOOPBACK_PROTECTION = 8,
    KSPROPERTY_AUDIOENGINE_VOLUMELEVEL = 9,
}

struct KSAUDIOENGINE_DESCRIPTOR
{
    uint nHostPinId;
    uint nOffloadPinId;
    uint nLoopbackPinId;
}

struct KSAUDIOENGINE_BUFFER_SIZE_RANGE
{
    uint MinBufferBytes;
    uint MaxBufferBytes;
}

enum AUDIO_CURVE_TYPE
{
    AUDIO_CURVE_TYPE_NONE = 0,
    AUDIO_CURVE_TYPE_WINDOWS_FADE = 1,
}

struct KSAUDIOENGINE_VOLUMELEVEL
{
    int TargetVolume;
    AUDIO_CURVE_TYPE CurveType;
    ulong CurveDuration;
}

const GUID CLSID_KSPROPSETID_AudioSignalProcessing = {0x4F67B528, 0x30C9, 0x40DE, [0xB2, 0xFB, 0x85, 0x9D, 0xDD, 0x1F, 0x34, 0x70]};
@GUID(0x4F67B528, 0x30C9, 0x40DE, [0xB2, 0xFB, 0x85, 0x9D, 0xDD, 0x1F, 0x34, 0x70]);
struct KSPROPSETID_AudioSignalProcessing;

enum KSPROPERTY_AUDIOSIGNALPROCESSING
{
    KSPROPERTY_AUDIOSIGNALPROCESSING_MODES = 0,
}

const GUID CLSID_KSATTRIBUTEID_AUDIOSIGNALPROCESSING_MODE = {0xE1F89EB5, 0x5F46, 0x419B, [0x96, 0x7B, 0xFF, 0x67, 0x70, 0xB9, 0x84, 0x01]};
@GUID(0xE1F89EB5, 0x5F46, 0x419B, [0x96, 0x7B, 0xFF, 0x67, 0x70, 0xB9, 0x84, 0x01]);
struct KSATTRIBUTEID_AUDIOSIGNALPROCESSING_MODE;

struct KSATTRIBUTE_AUDIOSIGNALPROCESSING_MODE
{
    KSATTRIBUTE AttributeHeader;
    Guid SignalProcessingMode;
}

const GUID CLSID_AUDIO_SIGNALPROCESSINGMODE_DEFAULT = {0xC18E2F7E, 0x933D, 0x4965, [0xB7, 0xD1, 0x1E, 0xEF, 0x22, 0x8D, 0x2A, 0xF3]};
@GUID(0xC18E2F7E, 0x933D, 0x4965, [0xB7, 0xD1, 0x1E, 0xEF, 0x22, 0x8D, 0x2A, 0xF3]);
struct AUDIO_SIGNALPROCESSINGMODE_DEFAULT;

const GUID CLSID_AUDIO_SIGNALPROCESSINGMODE_RAW = {0x9E90EA20, 0xB493, 0x4FD1, [0xA1, 0xA8, 0x7E, 0x13, 0x61, 0xA9, 0x56, 0xCF]};
@GUID(0x9E90EA20, 0xB493, 0x4FD1, [0xA1, 0xA8, 0x7E, 0x13, 0x61, 0xA9, 0x56, 0xCF]);
struct AUDIO_SIGNALPROCESSINGMODE_RAW;

const GUID CLSID_BLUETOOTHLE_MIDI_SERVICE_UUID = {0x03B80E5A, 0xEDE8, 0x4B33, [0xA7, 0x51, 0x6C, 0xE3, 0x4E, 0xC4, 0xC7, 0x00]};
@GUID(0x03B80E5A, 0xEDE8, 0x4B33, [0xA7, 0x51, 0x6C, 0xE3, 0x4E, 0xC4, 0xC7, 0x00]);
struct BLUETOOTHLE_MIDI_SERVICE_UUID;

const GUID CLSID_BLUETOOTH_MIDI_DATAIO_CHARACTERISTIC = {0x7772E5DB, 0x3868, 0x4112, [0xA1, 0xA9, 0xF2, 0x66, 0x9D, 0x10, 0x6B, 0xF3]};
@GUID(0x7772E5DB, 0x3868, 0x4112, [0xA1, 0xA9, 0xF2, 0x66, 0x9D, 0x10, 0x6B, 0xF3]);
struct BLUETOOTH_MIDI_DATAIO_CHARACTERISTIC;

const GUID CLSID_APO_CLASS_UUID = {0x5989FCE8, 0x9CD0, 0x467D, [0x8A, 0x6A, 0x54, 0x19, 0xE3, 0x15, 0x29, 0xD4]};
@GUID(0x5989FCE8, 0x9CD0, 0x467D, [0x8A, 0x6A, 0x54, 0x19, 0xE3, 0x15, 0x29, 0xD4]);
struct APO_CLASS_UUID;

const GUID CLSID_AUDIOENDPOINT_CLASS_UUID = {0xC166523C, 0xFE0C, 0x4A94, [0xA5, 0x86, 0xF1, 0xA8, 0x0C, 0xFB, 0xBF, 0x3E]};
@GUID(0xC166523C, 0xFE0C, 0x4A94, [0xA5, 0x86, 0xF1, 0xA8, 0x0C, 0xFB, 0xBF, 0x3E]);
struct AUDIOENDPOINT_CLASS_UUID;

const GUID CLSID_AUDIO_SIGNALPROCESSINGMODE_COMMUNICATIONS = {0x98951333, 0xB9CD, 0x48B1, [0xA0, 0xA3, 0xFF, 0x40, 0x68, 0x2D, 0x73, 0xF7]};
@GUID(0x98951333, 0xB9CD, 0x48B1, [0xA0, 0xA3, 0xFF, 0x40, 0x68, 0x2D, 0x73, 0xF7]);
struct AUDIO_SIGNALPROCESSINGMODE_COMMUNICATIONS;

const GUID CLSID_AUDIO_SIGNALPROCESSINGMODE_SPEECH = {0xFC1CFC9B, 0xB9D6, 0x4CFA, [0xB5, 0xE0, 0x4B, 0xB2, 0x16, 0x68, 0x78, 0xB2]};
@GUID(0xFC1CFC9B, 0xB9D6, 0x4CFA, [0xB5, 0xE0, 0x4B, 0xB2, 0x16, 0x68, 0x78, 0xB2]);
struct AUDIO_SIGNALPROCESSINGMODE_SPEECH;

const GUID CLSID_AUDIO_SIGNALPROCESSINGMODE_NOTIFICATION = {0x9CF2A70B, 0xF377, 0x403B, [0xBD, 0x6B, 0x36, 0x08, 0x63, 0xE0, 0x35, 0x5C]};
@GUID(0x9CF2A70B, 0xF377, 0x403B, [0xBD, 0x6B, 0x36, 0x08, 0x63, 0xE0, 0x35, 0x5C]);
struct AUDIO_SIGNALPROCESSINGMODE_NOTIFICATION;

const GUID CLSID_AUDIO_SIGNALPROCESSINGMODE_MEDIA = {0x4780004E, 0x7133, 0x41D8, [0x8C, 0x74, 0x66, 0x0D, 0xAD, 0xD2, 0xC0, 0xEE]};
@GUID(0x4780004E, 0x7133, 0x41D8, [0x8C, 0x74, 0x66, 0x0D, 0xAD, 0xD2, 0xC0, 0xEE]);
struct AUDIO_SIGNALPROCESSINGMODE_MEDIA;

const GUID CLSID_AUDIO_SIGNALPROCESSINGMODE_MOVIE = {0xB26FEB0D, 0xEC94, 0x477C, [0x94, 0x94, 0xD1, 0xAB, 0x8E, 0x75, 0x3F, 0x6E]};
@GUID(0xB26FEB0D, 0xEC94, 0x477C, [0x94, 0x94, 0xD1, 0xAB, 0x8E, 0x75, 0x3F, 0x6E]);
struct AUDIO_SIGNALPROCESSINGMODE_MOVIE;

const GUID CLSID_AUDIO_EFFECT_TYPE_ACOUSTIC_ECHO_CANCELLATION = {0x6F64ADBE, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADBE, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_ACOUSTIC_ECHO_CANCELLATION;

const GUID CLSID_AUDIO_EFFECT_TYPE_NOISE_SUPPRESSION = {0x6F64ADBF, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADBF, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_NOISE_SUPPRESSION;

const GUID CLSID_AUDIO_EFFECT_TYPE_AUTOMATIC_GAIN_CONTROL = {0x6F64ADC0, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC0, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_AUTOMATIC_GAIN_CONTROL;

const GUID CLSID_AUDIO_EFFECT_TYPE_BEAMFORMING = {0x6F64ADC1, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC1, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_BEAMFORMING;

const GUID CLSID_AUDIO_EFFECT_TYPE_CONSTANT_TONE_REMOVAL = {0x6F64ADC2, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC2, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_CONSTANT_TONE_REMOVAL;

const GUID CLSID_AUDIO_EFFECT_TYPE_EQUALIZER = {0x6F64ADC3, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC3, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_EQUALIZER;

const GUID CLSID_AUDIO_EFFECT_TYPE_LOUDNESS_EQUALIZER = {0x6F64ADC4, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC4, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_LOUDNESS_EQUALIZER;

const GUID CLSID_AUDIO_EFFECT_TYPE_BASS_BOOST = {0x6F64ADC5, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC5, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_BASS_BOOST;

const GUID CLSID_AUDIO_EFFECT_TYPE_VIRTUAL_SURROUND = {0x6F64ADC6, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC6, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_VIRTUAL_SURROUND;

const GUID CLSID_AUDIO_EFFECT_TYPE_VIRTUAL_HEADPHONES = {0x6F64ADC7, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC7, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_VIRTUAL_HEADPHONES;

const GUID CLSID_AUDIO_EFFECT_TYPE_SPEAKER_FILL = {0x6F64ADC8, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC8, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_SPEAKER_FILL;

const GUID CLSID_AUDIO_EFFECT_TYPE_ROOM_CORRECTION = {0x6F64ADC9, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADC9, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_ROOM_CORRECTION;

const GUID CLSID_AUDIO_EFFECT_TYPE_BASS_MANAGEMENT = {0x6F64ADCA, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADCA, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_BASS_MANAGEMENT;

const GUID CLSID_AUDIO_EFFECT_TYPE_ENVIRONMENTAL_EFFECTS = {0x6F64ADCB, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADCB, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_ENVIRONMENTAL_EFFECTS;

const GUID CLSID_AUDIO_EFFECT_TYPE_SPEAKER_PROTECTION = {0x6F64ADCC, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADCC, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_SPEAKER_PROTECTION;

const GUID CLSID_AUDIO_EFFECT_TYPE_SPEAKER_COMPENSATION = {0x6F64ADCD, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADCD, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_SPEAKER_COMPENSATION;

const GUID CLSID_AUDIO_EFFECT_TYPE_DYNAMIC_RANGE_COMPRESSION = {0x6F64ADCE, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]};
@GUID(0x6F64ADCE, 0x8211, 0x11E2, [0x8C, 0x70, 0x2C, 0x27, 0xD7, 0xF0, 0x01, 0xFA]);
struct AUDIO_EFFECT_TYPE_DYNAMIC_RANGE_COMPRESSION;

const GUID CLSID_KSPROPSETID_AudioModule = {0xC034FDB0, 0xFF75, 0x47C8, [0xAA, 0x3C, 0xEE, 0x46, 0x71, 0x6B, 0x50, 0xC6]};
@GUID(0xC034FDB0, 0xFF75, 0x47C8, [0xAA, 0x3C, 0xEE, 0x46, 0x71, 0x6B, 0x50, 0xC6]);
struct KSPROPSETID_AudioModule;

enum KSPROPERTY_AUDIOMODULE
{
    KSPROPERTY_AUDIOMODULE_DESCRIPTORS = 1,
    KSPROPERTY_AUDIOMODULE_COMMAND = 2,
    KSPROPERTY_AUDIOMODULE_NOTIFICATION_DEVICE_ID = 3,
}

struct KSAUDIOMODULE_DESCRIPTOR
{
    Guid ClassId;
    uint InstanceId;
    uint VersionMajor;
    uint VersionMinor;
    ushort Name;
}

struct KSAUDIOMODULE_PROPERTY
{
    KSIDENTIFIER Property;
    Guid ClassId;
    uint InstanceId;
}

const GUID CLSID_KSNOTIFICATIONID_AudioModule = {0x9C2220F0, 0xD9A6, 0x4D5C, [0xA0, 0x36, 0x57, 0x38, 0x57, 0xFD, 0x50, 0xD2]};
@GUID(0x9C2220F0, 0xD9A6, 0x4D5C, [0xA0, 0x36, 0x57, 0x38, 0x57, 0xFD, 0x50, 0xD2]);
struct KSNOTIFICATIONID_AudioModule;

struct KSAUDIOMODULE_NOTIFICATION
{
    _Anonymous_e__Union Anonymous;
}

enum _AUDCLNT_BUFFERFLAGS
{
    AUDCLNT_BUFFERFLAGS_DATA_DISCONTINUITY = 1,
    AUDCLNT_BUFFERFLAGS_SILENT = 2,
    AUDCLNT_BUFFERFLAGS_TIMESTAMP_ERROR = 4,
}

enum AUDCLNT_STREAMOPTIONS
{
    AUDCLNT_STREAMOPTIONS_NONE = 0,
    AUDCLNT_STREAMOPTIONS_RAW = 1,
    AUDCLNT_STREAMOPTIONS_MATCH_FORMAT = 2,
    AUDCLNT_STREAMOPTIONS_AMBISONICS = 4,
}

struct AudioClientProperties
{
    uint cbSize;
    BOOL bIsOffload;
    AUDIO_STREAM_CATEGORY eCategory;
    AUDCLNT_STREAMOPTIONS Options;
}

const GUID IID_IAudioClient = {0x1CB9AD4C, 0xDBFA, 0x4C32, [0xB1, 0x78, 0xC2, 0xF5, 0x68, 0xA7, 0x03, 0xB2]};
@GUID(0x1CB9AD4C, 0xDBFA, 0x4C32, [0xB1, 0x78, 0xC2, 0xF5, 0x68, 0xA7, 0x03, 0xB2]);
interface IAudioClient : IUnknown
{
    HRESULT Initialize(AUDCLNT_SHAREMODE ShareMode, uint StreamFlags, long hnsBufferDuration, long hnsPeriodicity, const(WAVEFORMATEX)* pFormat, Guid* AudioSessionGuid);
    HRESULT GetBufferSize(uint* pNumBufferFrames);
    HRESULT GetStreamLatency(long* phnsLatency);
    HRESULT GetCurrentPadding(uint* pNumPaddingFrames);
    HRESULT IsFormatSupported(AUDCLNT_SHAREMODE ShareMode, const(WAVEFORMATEX)* pFormat, WAVEFORMATEX** ppClosestMatch);
    HRESULT GetMixFormat(WAVEFORMATEX** ppDeviceFormat);
    HRESULT GetDevicePeriod(long* phnsDefaultDevicePeriod, long* phnsMinimumDevicePeriod);
    HRESULT Start();
    HRESULT Stop();
    HRESULT Reset();
    HRESULT SetEventHandle(HANDLE eventHandle);
    HRESULT GetService(const(Guid)* riid, void** ppv);
}

const GUID IID_IAudioClient2 = {0x726778CD, 0xF60A, 0x4EDA, [0x82, 0xDE, 0xE4, 0x76, 0x10, 0xCD, 0x78, 0xAA]};
@GUID(0x726778CD, 0xF60A, 0x4EDA, [0x82, 0xDE, 0xE4, 0x76, 0x10, 0xCD, 0x78, 0xAA]);
interface IAudioClient2 : IAudioClient
{
    HRESULT IsOffloadCapable(AUDIO_STREAM_CATEGORY Category, int* pbOffloadCapable);
    HRESULT SetClientProperties(const(AudioClientProperties)* pProperties);
    HRESULT GetBufferSizeLimits(const(WAVEFORMATEX)* pFormat, BOOL bEventDriven, long* phnsMinBufferDuration, long* phnsMaxBufferDuration);
}

struct AudioClient3ActivationParams
{
    Guid tracingContextId;
}

const GUID IID_IAudioClient3 = {0x7ED4EE07, 0x8E67, 0x4CD4, [0x8C, 0x1A, 0x2B, 0x7A, 0x59, 0x87, 0xAD, 0x42]};
@GUID(0x7ED4EE07, 0x8E67, 0x4CD4, [0x8C, 0x1A, 0x2B, 0x7A, 0x59, 0x87, 0xAD, 0x42]);
interface IAudioClient3 : IAudioClient2
{
    HRESULT GetSharedModeEnginePeriod(const(WAVEFORMATEX)* pFormat, uint* pDefaultPeriodInFrames, uint* pFundamentalPeriodInFrames, uint* pMinPeriodInFrames, uint* pMaxPeriodInFrames);
    HRESULT GetCurrentSharedModeEnginePeriod(WAVEFORMATEX** ppFormat, uint* pCurrentPeriodInFrames);
    HRESULT InitializeSharedAudioStream(uint StreamFlags, uint PeriodInFrames, const(WAVEFORMATEX)* pFormat, Guid* AudioSessionGuid);
}

const GUID IID_IAudioRenderClient = {0xF294ACFC, 0x3146, 0x4483, [0xA7, 0xBF, 0xAD, 0xDC, 0xA7, 0xC2, 0x60, 0xE2]};
@GUID(0xF294ACFC, 0x3146, 0x4483, [0xA7, 0xBF, 0xAD, 0xDC, 0xA7, 0xC2, 0x60, 0xE2]);
interface IAudioRenderClient : IUnknown
{
    HRESULT GetBuffer(uint NumFramesRequested, ubyte** ppData);
    HRESULT ReleaseBuffer(uint NumFramesWritten, uint dwFlags);
}

const GUID IID_IAudioCaptureClient = {0xC8ADBD64, 0xE71E, 0x48A0, [0xA4, 0xDE, 0x18, 0x5C, 0x39, 0x5C, 0xD3, 0x17]};
@GUID(0xC8ADBD64, 0xE71E, 0x48A0, [0xA4, 0xDE, 0x18, 0x5C, 0x39, 0x5C, 0xD3, 0x17]);
interface IAudioCaptureClient : IUnknown
{
    HRESULT GetBuffer(ubyte** ppData, uint* pNumFramesToRead, uint* pdwFlags, ulong* pu64DevicePosition, ulong* pu64QPCPosition);
    HRESULT ReleaseBuffer(uint NumFramesRead);
    HRESULT GetNextPacketSize(uint* pNumFramesInNextPacket);
}

const GUID IID_IAudioClock = {0xCD63314F, 0x3FBA, 0x4A1B, [0x81, 0x2C, 0xEF, 0x96, 0x35, 0x87, 0x28, 0xE7]};
@GUID(0xCD63314F, 0x3FBA, 0x4A1B, [0x81, 0x2C, 0xEF, 0x96, 0x35, 0x87, 0x28, 0xE7]);
interface IAudioClock : IUnknown
{
    HRESULT GetFrequency(ulong* pu64Frequency);
    HRESULT GetPosition(ulong* pu64Position, ulong* pu64QPCPosition);
    HRESULT GetCharacteristics(uint* pdwCharacteristics);
}

const GUID IID_IAudioClock2 = {0x6F49FF73, 0x6727, 0x49AC, [0xA0, 0x08, 0xD9, 0x8C, 0xF5, 0xE7, 0x00, 0x48]};
@GUID(0x6F49FF73, 0x6727, 0x49AC, [0xA0, 0x08, 0xD9, 0x8C, 0xF5, 0xE7, 0x00, 0x48]);
interface IAudioClock2 : IUnknown
{
    HRESULT GetDevicePosition(ulong* DevicePosition, ulong* QPCPosition);
}

const GUID IID_IAudioClockAdjustment = {0xF6E4C0A0, 0x46D9, 0x4FB8, [0xBE, 0x21, 0x57, 0xA3, 0xEF, 0x2B, 0x62, 0x6C]};
@GUID(0xF6E4C0A0, 0x46D9, 0x4FB8, [0xBE, 0x21, 0x57, 0xA3, 0xEF, 0x2B, 0x62, 0x6C]);
interface IAudioClockAdjustment : IUnknown
{
    HRESULT SetSampleRate(float flSampleRate);
}

const GUID IID_ISimpleAudioVolume = {0x87CE5498, 0x68D6, 0x44E5, [0x92, 0x15, 0x6D, 0xA4, 0x7E, 0xF8, 0x83, 0xD8]};
@GUID(0x87CE5498, 0x68D6, 0x44E5, [0x92, 0x15, 0x6D, 0xA4, 0x7E, 0xF8, 0x83, 0xD8]);
interface ISimpleAudioVolume : IUnknown
{
    HRESULT SetMasterVolume(float fLevel, Guid* EventContext);
    HRESULT GetMasterVolume(float* pfLevel);
    HRESULT SetMute(const(int) bMute, Guid* EventContext);
    HRESULT GetMute(int* pbMute);
}

const GUID IID_IAudioStreamVolume = {0x93014887, 0x242D, 0x4068, [0x8A, 0x15, 0xCF, 0x5E, 0x93, 0xB9, 0x0F, 0xE3]};
@GUID(0x93014887, 0x242D, 0x4068, [0x8A, 0x15, 0xCF, 0x5E, 0x93, 0xB9, 0x0F, 0xE3]);
interface IAudioStreamVolume : IUnknown
{
    HRESULT GetChannelCount(uint* pdwCount);
    HRESULT SetChannelVolume(uint dwIndex, const(float) fLevel);
    HRESULT GetChannelVolume(uint dwIndex, float* pfLevel);
    HRESULT SetAllVolumes(uint dwCount, char* pfVolumes);
    HRESULT GetAllVolumes(uint dwCount, char* pfVolumes);
}

enum AMBISONICS_TYPE
{
    AMBISONICS_TYPE_FULL3D = 0,
}

enum AMBISONICS_CHANNEL_ORDERING
{
    AMBISONICS_CHANNEL_ORDERING_ACN = 0,
}

enum AMBISONICS_NORMALIZATION
{
    AMBISONICS_NORMALIZATION_SN3D = 0,
    AMBISONICS_NORMALIZATION_N3D = 1,
}

struct AMBISONICS_PARAMS
{
    uint u32Size;
    uint u32Version;
    AMBISONICS_TYPE u32Type;
    AMBISONICS_CHANNEL_ORDERING u32ChannelOrdering;
    AMBISONICS_NORMALIZATION u32Normalization;
    uint u32Order;
    uint u32NumChannels;
    uint* pu32ChannelMap;
}

const GUID IID_IAudioAmbisonicsControl = {0x28724C91, 0xDF35, 0x4856, [0x9F, 0x76, 0xD6, 0xA2, 0x64, 0x13, 0xF3, 0xDF]};
@GUID(0x28724C91, 0xDF35, 0x4856, [0x9F, 0x76, 0xD6, 0xA2, 0x64, 0x13, 0xF3, 0xDF]);
interface IAudioAmbisonicsControl : IUnknown
{
    HRESULT SetData(char* pAmbisonicsParams, uint cbAmbisonicsParams);
    HRESULT SetHeadTracking(BOOL bEnableHeadTracking);
    HRESULT GetHeadTracking(int* pbEnableHeadTracking);
    HRESULT SetRotation(float X, float Y, float Z, float W);
}

const GUID IID_IChannelAudioVolume = {0x1C158861, 0xB533, 0x4B30, [0xB1, 0xCF, 0xE8, 0x53, 0xE5, 0x1C, 0x59, 0xB8]};
@GUID(0x1C158861, 0xB533, 0x4B30, [0xB1, 0xCF, 0xE8, 0x53, 0xE5, 0x1C, 0x59, 0xB8]);
interface IChannelAudioVolume : IUnknown
{
    HRESULT GetChannelCount(uint* pdwCount);
    HRESULT SetChannelVolume(uint dwIndex, const(float) fLevel, Guid* EventContext);
    HRESULT GetChannelVolume(uint dwIndex, float* pfLevel);
    HRESULT SetAllVolumes(uint dwCount, char* pfVolumes, Guid* EventContext);
    HRESULT GetAllVolumes(uint dwCount, char* pfVolumes);
}

enum AudioObjectType
{
    AudioObjectType_None = 0,
    AudioObjectType_Dynamic = 1,
    AudioObjectType_FrontLeft = 2,
    AudioObjectType_FrontRight = 4,
    AudioObjectType_FrontCenter = 8,
    AudioObjectType_LowFrequency = 16,
    AudioObjectType_SideLeft = 32,
    AudioObjectType_SideRight = 64,
    AudioObjectType_BackLeft = 128,
    AudioObjectType_BackRight = 256,
    AudioObjectType_TopFrontLeft = 512,
    AudioObjectType_TopFrontRight = 1024,
    AudioObjectType_TopBackLeft = 2048,
    AudioObjectType_TopBackRight = 4096,
    AudioObjectType_BottomFrontLeft = 8192,
    AudioObjectType_BottomFrontRight = 16384,
    AudioObjectType_BottomBackLeft = 32768,
    AudioObjectType_BottomBackRight = 65536,
    AudioObjectType_BackCenter = 131072,
}

struct SpatialAudioObjectRenderStreamActivationParams
{
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType StaticObjectTypeMask;
    uint MinDynamicObjectCount;
    uint MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE EventHandle;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
}

const GUID IID_IAudioFormatEnumerator = {0xDCDAA858, 0x895A, 0x4A22, [0xA5, 0xEB, 0x67, 0xBD, 0xA5, 0x06, 0x09, 0x6D]};
@GUID(0xDCDAA858, 0x895A, 0x4A22, [0xA5, 0xEB, 0x67, 0xBD, 0xA5, 0x06, 0x09, 0x6D]);
interface IAudioFormatEnumerator : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetFormat(uint index, WAVEFORMATEX** format);
}

const GUID IID_ISpatialAudioObjectBase = {0xCCE0B8F2, 0x8D4D, 0x4EFB, [0xA8, 0xCF, 0x3D, 0x6E, 0xCF, 0x1C, 0x30, 0xE0]};
@GUID(0xCCE0B8F2, 0x8D4D, 0x4EFB, [0xA8, 0xCF, 0x3D, 0x6E, 0xCF, 0x1C, 0x30, 0xE0]);
interface ISpatialAudioObjectBase : IUnknown
{
    HRESULT GetBuffer(ubyte** buffer, uint* bufferLength);
    HRESULT SetEndOfStream(uint frameCount);
    HRESULT IsActive(int* isActive);
    HRESULT GetAudioObjectType(AudioObjectType* audioObjectType);
}

const GUID IID_ISpatialAudioObject = {0xDDE28967, 0x521B, 0x46E5, [0x8F, 0x00, 0xBD, 0x6F, 0x2B, 0xC8, 0xAB, 0x1D]};
@GUID(0xDDE28967, 0x521B, 0x46E5, [0x8F, 0x00, 0xBD, 0x6F, 0x2B, 0xC8, 0xAB, 0x1D]);
interface ISpatialAudioObject : ISpatialAudioObjectBase
{
    HRESULT SetPosition(float x, float y, float z);
    HRESULT SetVolume(float volume);
}

const GUID IID_ISpatialAudioObjectRenderStreamBase = {0xFEAAF403, 0xC1D8, 0x450D, [0xAA, 0x05, 0xE0, 0xCC, 0xEE, 0x75, 0x02, 0xA8]};
@GUID(0xFEAAF403, 0xC1D8, 0x450D, [0xAA, 0x05, 0xE0, 0xCC, 0xEE, 0x75, 0x02, 0xA8]);
interface ISpatialAudioObjectRenderStreamBase : IUnknown
{
    HRESULT GetAvailableDynamicObjectCount(uint* value);
    HRESULT GetService(const(Guid)* riid, void** service);
    HRESULT Start();
    HRESULT Stop();
    HRESULT Reset();
    HRESULT BeginUpdatingAudioObjects(uint* availableDynamicObjectCount, uint* frameCountPerBuffer);
    HRESULT EndUpdatingAudioObjects();
}

const GUID IID_ISpatialAudioObjectRenderStream = {0xBAB5F473, 0xB423, 0x477B, [0x85, 0xF5, 0xB5, 0xA3, 0x32, 0xA0, 0x41, 0x53]};
@GUID(0xBAB5F473, 0xB423, 0x477B, [0x85, 0xF5, 0xB5, 0xA3, 0x32, 0xA0, 0x41, 0x53]);
interface ISpatialAudioObjectRenderStream : ISpatialAudioObjectRenderStreamBase
{
    HRESULT ActivateSpatialAudioObject(AudioObjectType type, ISpatialAudioObject* audioObject);
}

const GUID IID_ISpatialAudioObjectRenderStreamNotify = {0xDDDF83E6, 0x68D7, 0x4C70, [0x88, 0x3F, 0xA1, 0x83, 0x6A, 0xFB, 0x4A, 0x50]};
@GUID(0xDDDF83E6, 0x68D7, 0x4C70, [0x88, 0x3F, 0xA1, 0x83, 0x6A, 0xFB, 0x4A, 0x50]);
interface ISpatialAudioObjectRenderStreamNotify : IUnknown
{
    HRESULT OnAvailableDynamicObjectCountChange(ISpatialAudioObjectRenderStreamBase sender, long hnsComplianceDeadlineTime, uint availableDynamicObjectCountChange);
}

const GUID IID_ISpatialAudioClient = {0xBBF8E066, 0xAAAA, 0x49BE, [0x9A, 0x4D, 0xFD, 0x2A, 0x85, 0x8E, 0xA2, 0x7F]};
@GUID(0xBBF8E066, 0xAAAA, 0x49BE, [0x9A, 0x4D, 0xFD, 0x2A, 0x85, 0x8E, 0xA2, 0x7F]);
interface ISpatialAudioClient : IUnknown
{
    HRESULT GetStaticObjectPosition(AudioObjectType type, float* x, float* y, float* z);
    HRESULT GetNativeStaticObjectTypeMask(AudioObjectType* mask);
    HRESULT GetMaxDynamicObjectCount(uint* value);
    HRESULT GetSupportedAudioObjectFormatEnumerator(IAudioFormatEnumerator* enumerator);
    HRESULT GetMaxFrameCount(const(WAVEFORMATEX)* objectFormat, uint* frameCountPerBuffer);
    HRESULT IsAudioObjectFormatSupported(const(WAVEFORMATEX)* objectFormat);
    HRESULT IsSpatialAudioStreamAvailable(const(Guid)* streamUuid, const(PROPVARIANT)* auxiliaryInfo);
    HRESULT ActivateSpatialAudioStream(const(PROPVARIANT)* activationParams, const(Guid)* riid, void** stream);
}

struct SpatialAudioClientActivationParams
{
    Guid tracingContextId;
    Guid appId;
    int majorVersion;
    int minorVersion1;
    int minorVersion2;
    int minorVersion3;
}

enum SpatialAudioHrtfDirectivityType
{
    SpatialAudioHrtfDirectivity_OmniDirectional = 0,
    SpatialAudioHrtfDirectivity_Cardioid = 1,
    SpatialAudioHrtfDirectivity_Cone = 2,
}

enum SpatialAudioHrtfEnvironmentType
{
    SpatialAudioHrtfEnvironment_Small = 0,
    SpatialAudioHrtfEnvironment_Medium = 1,
    SpatialAudioHrtfEnvironment_Large = 2,
    SpatialAudioHrtfEnvironment_Outdoors = 3,
    SpatialAudioHrtfEnvironment_Average = 4,
}

enum SpatialAudioHrtfDistanceDecayType
{
    SpatialAudioHrtfDistanceDecay_NaturalDecay = 0,
    SpatialAudioHrtfDistanceDecay_CustomDecay = 1,
}

struct SpatialAudioHrtfDirectivity
{
    SpatialAudioHrtfDirectivityType Type;
    float Scaling;
}

struct SpatialAudioHrtfDirectivityCardioid
{
    SpatialAudioHrtfDirectivity directivity;
    float Order;
}

struct SpatialAudioHrtfDirectivityCone
{
    SpatialAudioHrtfDirectivity directivity;
    float InnerAngle;
    float OuterAngle;
}

struct SpatialAudioHrtfDirectivityUnion
{
    SpatialAudioHrtfDirectivityCone Cone;
    SpatialAudioHrtfDirectivityCardioid Cardiod;
    SpatialAudioHrtfDirectivity Omni;
}

struct SpatialAudioHrtfDistanceDecay
{
    SpatialAudioHrtfDistanceDecayType Type;
    float MaxGain;
    float MinGain;
    float UnityGainDistance;
    float CutoffDistance;
}

struct SpatialAudioHrtfActivationParams
{
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType StaticObjectTypeMask;
    uint MinDynamicObjectCount;
    uint MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE EventHandle;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
    SpatialAudioHrtfDistanceDecay* DistanceDecay;
    SpatialAudioHrtfDirectivityUnion* Directivity;
    SpatialAudioHrtfEnvironmentType* Environment;
    float* Orientation;
}

const GUID IID_ISpatialAudioObjectForHrtf = {0xD7436ADE, 0x1978, 0x4E14, [0xAB, 0xA0, 0x55, 0x5B, 0xD8, 0xEB, 0x83, 0xB4]};
@GUID(0xD7436ADE, 0x1978, 0x4E14, [0xAB, 0xA0, 0x55, 0x5B, 0xD8, 0xEB, 0x83, 0xB4]);
interface ISpatialAudioObjectForHrtf : ISpatialAudioObjectBase
{
    HRESULT SetPosition(float x, float y, float z);
    HRESULT SetGain(float gain);
    HRESULT SetOrientation(const(float)** orientation);
    HRESULT SetEnvironment(SpatialAudioHrtfEnvironmentType environment);
    HRESULT SetDistanceDecay(SpatialAudioHrtfDistanceDecay* distanceDecay);
    HRESULT SetDirectivity(SpatialAudioHrtfDirectivityUnion* directivity);
}

const GUID IID_ISpatialAudioObjectRenderStreamForHrtf = {0xE08DEEF9, 0x5363, 0x406E, [0x9F, 0xDC, 0x08, 0x0E, 0xE2, 0x47, 0xBB, 0xE0]};
@GUID(0xE08DEEF9, 0x5363, 0x406E, [0x9F, 0xDC, 0x08, 0x0E, 0xE2, 0x47, 0xBB, 0xE0]);
interface ISpatialAudioObjectRenderStreamForHrtf : ISpatialAudioObjectRenderStreamBase
{
    HRESULT ActivateSpatialAudioObjectForHrtf(AudioObjectType type, ISpatialAudioObjectForHrtf* audioObject);
}

const GUID IID_IAudioEndpointFormatControl = {0x784CFD40, 0x9F89, 0x456E, [0xA1, 0xA6, 0x87, 0x3B, 0x00, 0x6A, 0x66, 0x4E]};
@GUID(0x784CFD40, 0x9F89, 0x456E, [0xA1, 0xA6, 0x87, 0x3B, 0x00, 0x6A, 0x66, 0x4E]);
interface IAudioEndpointFormatControl : IUnknown
{
    HRESULT ResetToDefault(uint ResetFlags);
}

const GUID CLSID_MMDeviceEnumerator = {0xBCDE0395, 0xE52F, 0x467C, [0x8E, 0x3D, 0xC4, 0x57, 0x92, 0x91, 0x69, 0x2E]};
@GUID(0xBCDE0395, 0xE52F, 0x467C, [0x8E, 0x3D, 0xC4, 0x57, 0x92, 0x91, 0x69, 0x2E]);
struct MMDeviceEnumerator;

struct DIRECTX_AUDIO_ACTIVATION_PARAMS
{
    uint cbDirectXAudioActivationParams;
    Guid guidAudioSession;
    uint dwAudioStreamFlags;
}

enum EDataFlow
{
    eRender = 0,
    eCapture = 1,
    eAll = 2,
    EDataFlow_enum_count = 3,
}

enum ERole
{
    eConsole = 0,
    eMultimedia = 1,
    eCommunications = 2,
    ERole_enum_count = 3,
}

enum EndpointFormFactor
{
    RemoteNetworkDevice = 0,
    Speakers = 1,
    LineLevel = 2,
    Headphones = 3,
    Microphone = 4,
    Headset = 5,
    Handset = 6,
    UnknownDigitalPassthrough = 7,
    SPDIF = 8,
    DigitalAudioDisplayDevice = 9,
    UnknownFormFactor = 10,
    EndpointFormFactor_enum_count = 11,
}

const GUID IID_IMMNotificationClient = {0x7991EEC9, 0x7E89, 0x4D85, [0x83, 0x90, 0x6C, 0x70, 0x3C, 0xEC, 0x60, 0xC0]};
@GUID(0x7991EEC9, 0x7E89, 0x4D85, [0x83, 0x90, 0x6C, 0x70, 0x3C, 0xEC, 0x60, 0xC0]);
interface IMMNotificationClient : IUnknown
{
    HRESULT OnDeviceStateChanged(const(wchar)* pwstrDeviceId, uint dwNewState);
    HRESULT OnDeviceAdded(const(wchar)* pwstrDeviceId);
    HRESULT OnDeviceRemoved(const(wchar)* pwstrDeviceId);
    HRESULT OnDefaultDeviceChanged(EDataFlow flow, ERole role, const(wchar)* pwstrDefaultDeviceId);
    HRESULT OnPropertyValueChanged(const(wchar)* pwstrDeviceId, const(PROPERTYKEY) key);
}

const GUID IID_IMMDevice = {0xD666063F, 0x1587, 0x4E43, [0x81, 0xF1, 0xB9, 0x48, 0xE8, 0x07, 0x36, 0x3F]};
@GUID(0xD666063F, 0x1587, 0x4E43, [0x81, 0xF1, 0xB9, 0x48, 0xE8, 0x07, 0x36, 0x3F]);
interface IMMDevice : IUnknown
{
    HRESULT Activate(const(Guid)* iid, uint dwClsCtx, PROPVARIANT* pActivationParams, void** ppInterface);
    HRESULT OpenPropertyStore(uint stgmAccess, IPropertyStore* ppProperties);
    HRESULT GetId(ushort** ppstrId);
    HRESULT GetState(uint* pdwState);
}

const GUID IID_IMMDeviceCollection = {0x0BD7A1BE, 0x7A1A, 0x44DB, [0x83, 0x97, 0xCC, 0x53, 0x92, 0x38, 0x7B, 0x5E]};
@GUID(0x0BD7A1BE, 0x7A1A, 0x44DB, [0x83, 0x97, 0xCC, 0x53, 0x92, 0x38, 0x7B, 0x5E]);
interface IMMDeviceCollection : IUnknown
{
    HRESULT GetCount(uint* pcDevices);
    HRESULT Item(uint nDevice, IMMDevice* ppDevice);
}

const GUID IID_IMMEndpoint = {0x1BE09788, 0x6894, 0x4089, [0x85, 0x86, 0x9A, 0x2A, 0x6C, 0x26, 0x5A, 0xC5]};
@GUID(0x1BE09788, 0x6894, 0x4089, [0x85, 0x86, 0x9A, 0x2A, 0x6C, 0x26, 0x5A, 0xC5]);
interface IMMEndpoint : IUnknown
{
    HRESULT GetDataFlow(EDataFlow* pDataFlow);
}

const GUID IID_IMMDeviceEnumerator = {0xA95664D2, 0x9614, 0x4F35, [0xA7, 0x46, 0xDE, 0x8D, 0xB6, 0x36, 0x17, 0xE6]};
@GUID(0xA95664D2, 0x9614, 0x4F35, [0xA7, 0x46, 0xDE, 0x8D, 0xB6, 0x36, 0x17, 0xE6]);
interface IMMDeviceEnumerator : IUnknown
{
    HRESULT EnumAudioEndpoints(EDataFlow dataFlow, uint dwStateMask, IMMDeviceCollection* ppDevices);
    HRESULT GetDefaultAudioEndpoint(EDataFlow dataFlow, ERole role, IMMDevice* ppEndpoint);
    HRESULT GetDevice(const(wchar)* pwstrId, IMMDevice* ppDevice);
    HRESULT RegisterEndpointNotificationCallback(IMMNotificationClient pClient);
    HRESULT UnregisterEndpointNotificationCallback(IMMNotificationClient pClient);
}

const GUID IID_IMMDeviceActivator = {0x3B0D0EA4, 0xD0A9, 0x4B0E, [0x93, 0x5B, 0x09, 0x51, 0x67, 0x46, 0xFA, 0xC0]};
@GUID(0x3B0D0EA4, 0xD0A9, 0x4B0E, [0x93, 0x5B, 0x09, 0x51, 0x67, 0x46, 0xFA, 0xC0]);
interface IMMDeviceActivator : IUnknown
{
    HRESULT Activate(const(Guid)* iid, IMMDevice pDevice, PROPVARIANT* pActivationParams, void** ppInterface);
}

const GUID IID_IActivateAudioInterfaceCompletionHandler = {0x41D949AB, 0x9862, 0x444A, [0x80, 0xF6, 0xC2, 0x61, 0x33, 0x4D, 0xA5, 0xEB]};
@GUID(0x41D949AB, 0x9862, 0x444A, [0x80, 0xF6, 0xC2, 0x61, 0x33, 0x4D, 0xA5, 0xEB]);
interface IActivateAudioInterfaceCompletionHandler : IUnknown
{
    HRESULT ActivateCompleted(IActivateAudioInterfaceAsyncOperation activateOperation);
}

const GUID IID_IActivateAudioInterfaceAsyncOperation = {0x72A22D78, 0xCDE4, 0x431D, [0xB8, 0xCC, 0x84, 0x3A, 0x71, 0x19, 0x9B, 0x6D]};
@GUID(0x72A22D78, 0xCDE4, 0x431D, [0xB8, 0xCC, 0x84, 0x3A, 0x71, 0x19, 0x9B, 0x6D]);
interface IActivateAudioInterfaceAsyncOperation : IUnknown
{
    HRESULT GetActivateResult(int* activateResult, IUnknown* activatedInterface);
}

struct AudioExtensionParams
{
    LPARAM AddPageParam;
    IMMDevice pEndpoint;
    IMMDevice pPnpInterface;
    IMMDevice pPnpDevnode;
}

enum __MIDL___MIDL_itf_audioengineendpoint_0000_0000_0001
{
    eHostProcessConnector = 0,
    eOffloadConnector = 1,
    eLoopbackConnector = 2,
    eKeywordDetectorConnector = 3,
    eConnectorCount = 4,
}

struct AUDIO_ENDPOINT_SHARED_CREATE_PARAMS
{
    uint u32Size;
    uint u32TSSessionId;
    __MIDL___MIDL_itf_audioengineendpoint_0000_0000_0001 targetEndpointConnectorType;
    WAVEFORMATEX wfxDeviceFormat;
}

const GUID IID_IAudioEndpointOffloadStreamVolume = {0x64F1DD49, 0x71CA, 0x4281, [0x86, 0x72, 0x3A, 0x9E, 0xDD, 0xD1, 0xD0, 0xB6]};
@GUID(0x64F1DD49, 0x71CA, 0x4281, [0x86, 0x72, 0x3A, 0x9E, 0xDD, 0xD1, 0xD0, 0xB6]);
interface IAudioEndpointOffloadStreamVolume : IUnknown
{
    HRESULT GetVolumeChannelCount(uint* pu32ChannelCount);
    HRESULT SetChannelVolumes(uint u32ChannelCount, float* pf32Volumes, AUDIO_CURVE_TYPE u32CurveType, long* pCurveDuration);
    HRESULT GetChannelVolumes(uint u32ChannelCount, float* pf32Volumes);
}

const GUID IID_IAudioEndpointOffloadStreamMute = {0xDFE21355, 0x5EC2, 0x40E0, [0x8D, 0x6B, 0x71, 0x0A, 0xC3, 0xC0, 0x02, 0x49]};
@GUID(0xDFE21355, 0x5EC2, 0x40E0, [0x8D, 0x6B, 0x71, 0x0A, 0xC3, 0xC0, 0x02, 0x49]);
interface IAudioEndpointOffloadStreamMute : IUnknown
{
    HRESULT SetMute(ubyte bMuted);
    HRESULT GetMute(ubyte* pbMuted);
}

const GUID IID_IAudioEndpointOffloadStreamMeter = {0xE1546DCE, 0x9DD1, 0x418B, [0x9A, 0xB2, 0x34, 0x8C, 0xED, 0x16, 0x1C, 0x86]};
@GUID(0xE1546DCE, 0x9DD1, 0x418B, [0x9A, 0xB2, 0x34, 0x8C, 0xED, 0x16, 0x1C, 0x86]);
interface IAudioEndpointOffloadStreamMeter : IUnknown
{
    HRESULT GetMeterChannelCount(uint* pu32ChannelCount);
    HRESULT GetMeteringData(uint u32ChannelCount, float* pf32PeakValues);
}

const GUID IID_IAudioEndpointLastBufferControl = {0xF8520DD3, 0x8F9D, 0x4437, [0x98, 0x61, 0x62, 0xF5, 0x84, 0xC3, 0x3D, 0xD6]};
@GUID(0xF8520DD3, 0x8F9D, 0x4437, [0x98, 0x61, 0x62, 0xF5, 0x84, 0xC3, 0x3D, 0xD6]);
interface IAudioEndpointLastBufferControl : IUnknown
{
    BOOL IsLastBufferControlSupported();
    void ReleaseOutputDataPointerForLastBuffer(const(APO_CONNECTION_PROPERTY)* pConnectionProperty);
}

const GUID IID_IAudioLfxControl = {0x076A6922, 0xD802, 0x4F83, [0xBA, 0xF6, 0x40, 0x9D, 0x9C, 0xA1, 0x1B, 0xFE]};
@GUID(0x076A6922, 0xD802, 0x4F83, [0xBA, 0xF6, 0x40, 0x9D, 0x9C, 0xA1, 0x1B, 0xFE]);
interface IAudioLfxControl : IUnknown
{
    HRESULT SetLocalEffectsState(BOOL bEnabled);
    HRESULT GetLocalEffectsState(int* pbEnabled);
}

const GUID IID_IHardwareAudioEngineBase = {0xEDDCE3E4, 0xF3C1, 0x453A, [0xB4, 0x61, 0x22, 0x35, 0x63, 0xCB, 0xD8, 0x86]};
@GUID(0xEDDCE3E4, 0xF3C1, 0x453A, [0xB4, 0x61, 0x22, 0x35, 0x63, 0xCB, 0xD8, 0x86]);
interface IHardwareAudioEngineBase : IUnknown
{
    HRESULT GetAvailableOffloadConnectorCount(const(wchar)* _pwstrDeviceId, uint _uConnectorId, uint* _pAvailableConnectorInstanceCount);
    HRESULT GetEngineFormat(IMMDevice pDevice, BOOL _bRequestDeviceFormat, WAVEFORMATEX** _ppwfxFormat);
    HRESULT SetEngineDeviceFormat(IMMDevice pDevice, WAVEFORMATEX* _pwfxFormat);
    HRESULT SetGfxState(IMMDevice pDevice, BOOL _bEnable);
    HRESULT GetGfxState(IMMDevice pDevice, int* _pbEnable);
}

const GUID CLSID_DEVINTERFACE_AUDIOENDPOINTPLUGIN = {0x9F2F7B66, 0x65AC, 0x4FA6, [0x8A, 0xE4, 0x12, 0x3C, 0x78, 0xB8, 0x93, 0x13]};
@GUID(0x9F2F7B66, 0x65AC, 0x4FA6, [0x8A, 0xE4, 0x12, 0x3C, 0x78, 0xB8, 0x93, 0x13]);
struct DEVINTERFACE_AUDIOENDPOINTPLUGIN;

const GUID CLSID_DeviceTopology = {0x1DF639D0, 0x5EC1, 0x47AA, [0x93, 0x79, 0x82, 0x8D, 0xC1, 0xAA, 0x8C, 0x59]};
@GUID(0x1DF639D0, 0x5EC1, 0x47AA, [0x93, 0x79, 0x82, 0x8D, 0xC1, 0xAA, 0x8C, 0x59]);
struct DeviceTopology;

enum DataFlow
{
    In = 0,
    Out = 1,
}

enum PartType
{
    Connector = 0,
    Subunit = 1,
}

enum ConnectorType
{
    Unknown_Connector = 0,
    Physical_Internal = 1,
    Physical_External = 2,
    Software_IO = 3,
    Software_Fixed = 4,
    Network = 5,
}

const GUID IID_IPerChannelDbLevel = {0xC2F8E001, 0xF205, 0x4BC9, [0x99, 0xBC, 0xC1, 0x3B, 0x1E, 0x04, 0x8C, 0xCB]};
@GUID(0xC2F8E001, 0xF205, 0x4BC9, [0x99, 0xBC, 0xC1, 0x3B, 0x1E, 0x04, 0x8C, 0xCB]);
interface IPerChannelDbLevel : IUnknown
{
    HRESULT GetChannelCount(uint* pcChannels);
    HRESULT GetLevelRange(uint nChannel, float* pfMinLevelDB, float* pfMaxLevelDB, float* pfStepping);
    HRESULT GetLevel(uint nChannel, float* pfLevelDB);
    HRESULT SetLevel(uint nChannel, float fLevelDB, Guid* pguidEventContext);
    HRESULT SetLevelUniform(float fLevelDB, Guid* pguidEventContext);
    HRESULT SetLevelAllChannels(char* aLevelsDB, uint cChannels, Guid* pguidEventContext);
}

const GUID IID_IAudioVolumeLevel = {0x7FB7B48F, 0x531D, 0x44A2, [0xBC, 0xB3, 0x5A, 0xD5, 0xA1, 0x34, 0xB3, 0xDC]};
@GUID(0x7FB7B48F, 0x531D, 0x44A2, [0xBC, 0xB3, 0x5A, 0xD5, 0xA1, 0x34, 0xB3, 0xDC]);
interface IAudioVolumeLevel : IPerChannelDbLevel
{
}

const GUID IID_IAudioChannelConfig = {0xBB11C46F, 0xEC28, 0x493C, [0xB8, 0x8A, 0x5D, 0xB8, 0x80, 0x62, 0xCE, 0x98]};
@GUID(0xBB11C46F, 0xEC28, 0x493C, [0xB8, 0x8A, 0x5D, 0xB8, 0x80, 0x62, 0xCE, 0x98]);
interface IAudioChannelConfig : IUnknown
{
    HRESULT SetChannelConfig(uint dwConfig, Guid* pguidEventContext);
    HRESULT GetChannelConfig(uint* pdwConfig);
}

const GUID IID_IAudioLoudness = {0x7D8B1437, 0xDD53, 0x4350, [0x9C, 0x1B, 0x1E, 0xE2, 0x89, 0x0B, 0xD9, 0x38]};
@GUID(0x7D8B1437, 0xDD53, 0x4350, [0x9C, 0x1B, 0x1E, 0xE2, 0x89, 0x0B, 0xD9, 0x38]);
interface IAudioLoudness : IUnknown
{
    HRESULT GetEnabled(int* pbEnabled);
    HRESULT SetEnabled(BOOL bEnable, Guid* pguidEventContext);
}

const GUID IID_IAudioInputSelector = {0x4F03DC02, 0x5E6E, 0x4653, [0x8F, 0x72, 0xA0, 0x30, 0xC1, 0x23, 0xD5, 0x98]};
@GUID(0x4F03DC02, 0x5E6E, 0x4653, [0x8F, 0x72, 0xA0, 0x30, 0xC1, 0x23, 0xD5, 0x98]);
interface IAudioInputSelector : IUnknown
{
    HRESULT GetSelection(uint* pnIdSelected);
    HRESULT SetSelection(uint nIdSelect, Guid* pguidEventContext);
}

const GUID IID_IAudioOutputSelector = {0xBB515F69, 0x94A7, 0x429E, [0x8B, 0x9C, 0x27, 0x1B, 0x3F, 0x11, 0xA3, 0xAB]};
@GUID(0xBB515F69, 0x94A7, 0x429E, [0x8B, 0x9C, 0x27, 0x1B, 0x3F, 0x11, 0xA3, 0xAB]);
interface IAudioOutputSelector : IUnknown
{
    HRESULT GetSelection(uint* pnIdSelected);
    HRESULT SetSelection(uint nIdSelect, Guid* pguidEventContext);
}

const GUID IID_IAudioMute = {0xDF45AEEA, 0xB74A, 0x4B6B, [0xAF, 0xAD, 0x23, 0x66, 0xB6, 0xAA, 0x01, 0x2E]};
@GUID(0xDF45AEEA, 0xB74A, 0x4B6B, [0xAF, 0xAD, 0x23, 0x66, 0xB6, 0xAA, 0x01, 0x2E]);
interface IAudioMute : IUnknown
{
    HRESULT SetMute(BOOL bMuted, Guid* pguidEventContext);
    HRESULT GetMute(int* pbMuted);
}

const GUID IID_IAudioBass = {0xA2B1A1D9, 0x4DB3, 0x425D, [0xA2, 0xB2, 0xBD, 0x33, 0x5C, 0xB3, 0xE2, 0xE5]};
@GUID(0xA2B1A1D9, 0x4DB3, 0x425D, [0xA2, 0xB2, 0xBD, 0x33, 0x5C, 0xB3, 0xE2, 0xE5]);
interface IAudioBass : IPerChannelDbLevel
{
}

const GUID IID_IAudioMidrange = {0x5E54B6D7, 0xB44B, 0x40D9, [0x9A, 0x9E, 0xE6, 0x91, 0xD9, 0xCE, 0x6E, 0xDF]};
@GUID(0x5E54B6D7, 0xB44B, 0x40D9, [0x9A, 0x9E, 0xE6, 0x91, 0xD9, 0xCE, 0x6E, 0xDF]);
interface IAudioMidrange : IPerChannelDbLevel
{
}

const GUID IID_IAudioTreble = {0x0A717812, 0x694E, 0x4907, [0xB7, 0x4B, 0xBA, 0xFA, 0x5C, 0xFD, 0xCA, 0x7B]};
@GUID(0x0A717812, 0x694E, 0x4907, [0xB7, 0x4B, 0xBA, 0xFA, 0x5C, 0xFD, 0xCA, 0x7B]);
interface IAudioTreble : IPerChannelDbLevel
{
}

const GUID IID_IAudioAutoGainControl = {0x85401FD4, 0x6DE4, 0x4B9D, [0x98, 0x69, 0x2D, 0x67, 0x53, 0xA8, 0x2F, 0x3C]};
@GUID(0x85401FD4, 0x6DE4, 0x4B9D, [0x98, 0x69, 0x2D, 0x67, 0x53, 0xA8, 0x2F, 0x3C]);
interface IAudioAutoGainControl : IUnknown
{
    HRESULT GetEnabled(int* pbEnabled);
    HRESULT SetEnabled(BOOL bEnable, Guid* pguidEventContext);
}

const GUID IID_IAudioPeakMeter = {0xDD79923C, 0x0599, 0x45E0, [0xB8, 0xB6, 0xC8, 0xDF, 0x7D, 0xB6, 0xE7, 0x96]};
@GUID(0xDD79923C, 0x0599, 0x45E0, [0xB8, 0xB6, 0xC8, 0xDF, 0x7D, 0xB6, 0xE7, 0x96]);
interface IAudioPeakMeter : IUnknown
{
    HRESULT GetChannelCount(uint* pcChannels);
    HRESULT GetLevel(uint nChannel, float* pfLevel);
}

const GUID IID_IDeviceSpecificProperty = {0x3B22BCBF, 0x2586, 0x4AF0, [0x85, 0x83, 0x20, 0x5D, 0x39, 0x1B, 0x80, 0x7C]};
@GUID(0x3B22BCBF, 0x2586, 0x4AF0, [0x85, 0x83, 0x20, 0x5D, 0x39, 0x1B, 0x80, 0x7C]);
interface IDeviceSpecificProperty : IUnknown
{
    HRESULT GetType(ushort* pVType);
    HRESULT GetValue(void* pvValue, uint* pcbValue);
    HRESULT SetValue(void* pvValue, uint cbValue, Guid* pguidEventContext);
    HRESULT Get4BRange(int* plMin, int* plMax, int* plStepping);
}

const GUID IID_IKsFormatSupport = {0x3CB4A69D, 0xBB6F, 0x4D2B, [0x95, 0xB7, 0x45, 0x2D, 0x2C, 0x15, 0x5D, 0xB5]};
@GUID(0x3CB4A69D, 0xBB6F, 0x4D2B, [0x95, 0xB7, 0x45, 0x2D, 0x2C, 0x15, 0x5D, 0xB5]);
interface IKsFormatSupport : IUnknown
{
    HRESULT IsFormatSupported(KSDATAFORMAT* pKsFormat, uint cbFormat, int* pbSupported);
    HRESULT GetDevicePreferredFormat(KSDATAFORMAT** ppKsFormat);
}

const GUID IID_IKsJackDescription = {0x4509F757, 0x2D46, 0x4637, [0x8E, 0x62, 0xCE, 0x7D, 0xB9, 0x44, 0xF5, 0x7B]};
@GUID(0x4509F757, 0x2D46, 0x4637, [0x8E, 0x62, 0xCE, 0x7D, 0xB9, 0x44, 0xF5, 0x7B]);
interface IKsJackDescription : IUnknown
{
    HRESULT GetJackCount(uint* pcJacks);
    HRESULT GetJackDescription(uint nJack, KSJACK_DESCRIPTION* pDescription);
}

const GUID IID_IKsJackDescription2 = {0x478F3A9B, 0xE0C9, 0x4827, [0x92, 0x28, 0x6F, 0x55, 0x05, 0xFF, 0xE7, 0x6A]};
@GUID(0x478F3A9B, 0xE0C9, 0x4827, [0x92, 0x28, 0x6F, 0x55, 0x05, 0xFF, 0xE7, 0x6A]);
interface IKsJackDescription2 : IUnknown
{
    HRESULT GetJackCount(uint* pcJacks);
    HRESULT GetJackDescription2(uint nJack, KSJACK_DESCRIPTION2* pDescription2);
}

const GUID IID_IKsJackSinkInformation = {0xD9BD72ED, 0x290F, 0x4581, [0x9F, 0xF3, 0x61, 0x02, 0x7A, 0x8F, 0xE5, 0x32]};
@GUID(0xD9BD72ED, 0x290F, 0x4581, [0x9F, 0xF3, 0x61, 0x02, 0x7A, 0x8F, 0xE5, 0x32]);
interface IKsJackSinkInformation : IUnknown
{
    HRESULT GetJackSinkInformation(KSJACK_SINK_INFORMATION* pJackSinkInformation);
}

const GUID IID_IKsJackContainerId = {0xC99AF463, 0xD629, 0x4EC4, [0x8C, 0x00, 0xE5, 0x4D, 0x68, 0x15, 0x42, 0x48]};
@GUID(0xC99AF463, 0xD629, 0x4EC4, [0x8C, 0x00, 0xE5, 0x4D, 0x68, 0x15, 0x42, 0x48]);
interface IKsJackContainerId : IUnknown
{
    HRESULT GetJackContainerId(Guid* pJackContainerId);
}

const GUID IID_IPartsList = {0x6DAA848C, 0x5EB0, 0x45CC, [0xAE, 0xA5, 0x99, 0x8A, 0x2C, 0xDA, 0x1F, 0xFB]};
@GUID(0x6DAA848C, 0x5EB0, 0x45CC, [0xAE, 0xA5, 0x99, 0x8A, 0x2C, 0xDA, 0x1F, 0xFB]);
interface IPartsList : IUnknown
{
    HRESULT GetCount(uint* pCount);
    HRESULT GetPart(uint nIndex, IPart* ppPart);
}

const GUID IID_IPart = {0xAE2DE0E4, 0x5BCA, 0x4F2D, [0xAA, 0x46, 0x5D, 0x13, 0xF8, 0xFD, 0xB3, 0xA9]};
@GUID(0xAE2DE0E4, 0x5BCA, 0x4F2D, [0xAA, 0x46, 0x5D, 0x13, 0xF8, 0xFD, 0xB3, 0xA9]);
interface IPart : IUnknown
{
    HRESULT GetName(ushort** ppwstrName);
    HRESULT GetLocalId(uint* pnId);
    HRESULT GetGlobalId(ushort** ppwstrGlobalId);
    HRESULT GetPartType(PartType* pPartType);
    HRESULT GetSubType(Guid* pSubType);
    HRESULT GetControlInterfaceCount(uint* pCount);
    HRESULT GetControlInterface(uint nIndex, IControlInterface* ppInterfaceDesc);
    HRESULT EnumPartsIncoming(IPartsList* ppParts);
    HRESULT EnumPartsOutgoing(IPartsList* ppParts);
    HRESULT GetTopologyObject(IDeviceTopology* ppTopology);
    HRESULT Activate(uint dwClsContext, const(Guid)* refiid, void** ppvObject);
    HRESULT RegisterControlChangeCallback(const(Guid)* riid, IControlChangeNotify pNotify);
    HRESULT UnregisterControlChangeCallback(IControlChangeNotify pNotify);
}

const GUID IID_IConnector = {0x9C2C4058, 0x23F5, 0x41DE, [0x87, 0x7A, 0xDF, 0x3A, 0xF2, 0x36, 0xA0, 0x9E]};
@GUID(0x9C2C4058, 0x23F5, 0x41DE, [0x87, 0x7A, 0xDF, 0x3A, 0xF2, 0x36, 0xA0, 0x9E]);
interface IConnector : IUnknown
{
    HRESULT GetType(ConnectorType* pType);
    HRESULT GetDataFlow(DataFlow* pFlow);
    HRESULT ConnectTo(IConnector pConnectTo);
    HRESULT Disconnect();
    HRESULT IsConnected(int* pbConnected);
    HRESULT GetConnectedTo(IConnector* ppConTo);
    HRESULT GetConnectorIdConnectedTo(ushort** ppwstrConnectorId);
    HRESULT GetDeviceIdConnectedTo(ushort** ppwstrDeviceId);
}

const GUID IID_ISubunit = {0x82149A85, 0xDBA6, 0x4487, [0x86, 0xBB, 0xEA, 0x8F, 0x7F, 0xEF, 0xCC, 0x71]};
@GUID(0x82149A85, 0xDBA6, 0x4487, [0x86, 0xBB, 0xEA, 0x8F, 0x7F, 0xEF, 0xCC, 0x71]);
interface ISubunit : IUnknown
{
}

const GUID IID_IControlInterface = {0x45D37C3F, 0x5140, 0x444A, [0xAE, 0x24, 0x40, 0x07, 0x89, 0xF3, 0xCB, 0xF3]};
@GUID(0x45D37C3F, 0x5140, 0x444A, [0xAE, 0x24, 0x40, 0x07, 0x89, 0xF3, 0xCB, 0xF3]);
interface IControlInterface : IUnknown
{
    HRESULT GetName(ushort** ppwstrName);
    HRESULT GetIID(Guid* pIID);
}

const GUID IID_IControlChangeNotify = {0xA09513ED, 0xC709, 0x4D21, [0xBD, 0x7B, 0x5F, 0x34, 0xC4, 0x7F, 0x39, 0x47]};
@GUID(0xA09513ED, 0xC709, 0x4D21, [0xBD, 0x7B, 0x5F, 0x34, 0xC4, 0x7F, 0x39, 0x47]);
interface IControlChangeNotify : IUnknown
{
    HRESULT OnNotify(uint dwSenderProcessId, Guid* pguidEventContext);
}

const GUID IID_IDeviceTopology = {0x2A07407E, 0x6497, 0x4A18, [0x97, 0x87, 0x32, 0xF7, 0x9B, 0xD0, 0xD9, 0x8F]};
@GUID(0x2A07407E, 0x6497, 0x4A18, [0x97, 0x87, 0x32, 0xF7, 0x9B, 0xD0, 0xD9, 0x8F]);
interface IDeviceTopology : IUnknown
{
    HRESULT GetConnectorCount(uint* pCount);
    HRESULT GetConnector(uint nIndex, IConnector* ppConnector);
    HRESULT GetSubunitCount(uint* pCount);
    HRESULT GetSubunit(uint nIndex, ISubunit* ppSubunit);
    HRESULT GetPartById(uint nId, IPart* ppPart);
    HRESULT GetDeviceId(ushort** ppwstrDeviceId);
    HRESULT GetSignalPath(IPart pIPartFrom, IPart pIPartTo, BOOL bRejectMixedPaths, IPartsList* ppParts);
}

struct AUDIO_VOLUME_NOTIFICATION_DATA
{
    Guid guidEventContext;
    BOOL bMuted;
    float fMasterVolume;
    uint nChannels;
    float afChannelVolumes;
}

const GUID IID_IAudioEndpointVolumeCallback = {0x657804FA, 0xD6AD, 0x4496, [0x8A, 0x60, 0x35, 0x27, 0x52, 0xAF, 0x4F, 0x89]};
@GUID(0x657804FA, 0xD6AD, 0x4496, [0x8A, 0x60, 0x35, 0x27, 0x52, 0xAF, 0x4F, 0x89]);
interface IAudioEndpointVolumeCallback : IUnknown
{
    HRESULT OnNotify(AUDIO_VOLUME_NOTIFICATION_DATA* pNotify);
}

const GUID IID_IAudioEndpointVolume = {0x5CDF2C82, 0x841E, 0x4546, [0x97, 0x22, 0x0C, 0xF7, 0x40, 0x78, 0x22, 0x9A]};
@GUID(0x5CDF2C82, 0x841E, 0x4546, [0x97, 0x22, 0x0C, 0xF7, 0x40, 0x78, 0x22, 0x9A]);
interface IAudioEndpointVolume : IUnknown
{
    HRESULT RegisterControlChangeNotify(IAudioEndpointVolumeCallback pNotify);
    HRESULT UnregisterControlChangeNotify(IAudioEndpointVolumeCallback pNotify);
    HRESULT GetChannelCount(uint* pnChannelCount);
    HRESULT SetMasterVolumeLevel(float fLevelDB, Guid* pguidEventContext);
    HRESULT SetMasterVolumeLevelScalar(float fLevel, Guid* pguidEventContext);
    HRESULT GetMasterVolumeLevel(float* pfLevelDB);
    HRESULT GetMasterVolumeLevelScalar(float* pfLevel);
    HRESULT SetChannelVolumeLevel(uint nChannel, float fLevelDB, Guid* pguidEventContext);
    HRESULT SetChannelVolumeLevelScalar(uint nChannel, float fLevel, Guid* pguidEventContext);
    HRESULT GetChannelVolumeLevel(uint nChannel, float* pfLevelDB);
    HRESULT GetChannelVolumeLevelScalar(uint nChannel, float* pfLevel);
    HRESULT SetMute(BOOL bMute, Guid* pguidEventContext);
    HRESULT GetMute(int* pbMute);
    HRESULT GetVolumeStepInfo(uint* pnStep, uint* pnStepCount);
    HRESULT VolumeStepUp(Guid* pguidEventContext);
    HRESULT VolumeStepDown(Guid* pguidEventContext);
    HRESULT QueryHardwareSupport(uint* pdwHardwareSupportMask);
    HRESULT GetVolumeRange(float* pflVolumeMindB, float* pflVolumeMaxdB, float* pflVolumeIncrementdB);
}

const GUID IID_IAudioEndpointVolumeEx = {0x66E11784, 0xF695, 0x4F28, [0xA5, 0x05, 0xA7, 0x08, 0x00, 0x81, 0xA7, 0x8F]};
@GUID(0x66E11784, 0xF695, 0x4F28, [0xA5, 0x05, 0xA7, 0x08, 0x00, 0x81, 0xA7, 0x8F]);
interface IAudioEndpointVolumeEx : IAudioEndpointVolume
{
    HRESULT GetVolumeRangeChannel(uint iChannel, float* pflVolumeMindB, float* pflVolumeMaxdB, float* pflVolumeIncrementdB);
}

const GUID IID_IAudioMeterInformation = {0xC02216F6, 0x8C67, 0x4B5B, [0x9D, 0x00, 0xD0, 0x08, 0xE7, 0x3E, 0x00, 0x64]};
@GUID(0xC02216F6, 0x8C67, 0x4B5B, [0x9D, 0x00, 0xD0, 0x08, 0xE7, 0x3E, 0x00, 0x64]);
interface IAudioMeterInformation : IUnknown
{
    HRESULT GetPeakValue(float* pfPeak);
    HRESULT GetMeteringChannelCount(uint* pnChannelCount);
    HRESULT GetChannelsPeakValues(uint u32ChannelCount, float* afPeakValues);
    HRESULT QueryHardwareSupport(uint* pdwHardwareSupportMask);
}

enum AudioSessionDisconnectReason
{
    DisconnectReasonDeviceRemoval = 0,
    DisconnectReasonServerShutdown = 1,
    DisconnectReasonFormatChanged = 2,
    DisconnectReasonSessionLogoff = 3,
    DisconnectReasonSessionDisconnected = 4,
    DisconnectReasonExclusiveModeOverride = 5,
}

const GUID IID_IAudioSessionEvents = {0x24918ACC, 0x64B3, 0x37C1, [0x8C, 0xA9, 0x74, 0xA6, 0x6E, 0x99, 0x57, 0xA8]};
@GUID(0x24918ACC, 0x64B3, 0x37C1, [0x8C, 0xA9, 0x74, 0xA6, 0x6E, 0x99, 0x57, 0xA8]);
interface IAudioSessionEvents : IUnknown
{
    HRESULT OnDisplayNameChanged(const(wchar)* NewDisplayName, Guid* EventContext);
    HRESULT OnIconPathChanged(const(wchar)* NewIconPath, Guid* EventContext);
    HRESULT OnSimpleVolumeChanged(float NewVolume, BOOL NewMute, Guid* EventContext);
    HRESULT OnChannelVolumeChanged(uint ChannelCount, char* NewChannelVolumeArray, uint ChangedChannel, Guid* EventContext);
    HRESULT OnGroupingParamChanged(Guid* NewGroupingParam, Guid* EventContext);
    HRESULT OnStateChanged(AudioSessionState NewState);
    HRESULT OnSessionDisconnected(AudioSessionDisconnectReason DisconnectReason);
}

const GUID IID_IAudioSessionControl = {0xF4B1A599, 0x7266, 0x4319, [0xA8, 0xCA, 0xE7, 0x0A, 0xCB, 0x11, 0xE8, 0xCD]};
@GUID(0xF4B1A599, 0x7266, 0x4319, [0xA8, 0xCA, 0xE7, 0x0A, 0xCB, 0x11, 0xE8, 0xCD]);
interface IAudioSessionControl : IUnknown
{
    HRESULT GetState(AudioSessionState* pRetVal);
    HRESULT GetDisplayName(ushort** pRetVal);
    HRESULT SetDisplayName(const(wchar)* Value, Guid* EventContext);
    HRESULT GetIconPath(ushort** pRetVal);
    HRESULT SetIconPath(const(wchar)* Value, Guid* EventContext);
    HRESULT GetGroupingParam(Guid* pRetVal);
    HRESULT SetGroupingParam(Guid* Override, Guid* EventContext);
    HRESULT RegisterAudioSessionNotification(IAudioSessionEvents NewNotifications);
    HRESULT UnregisterAudioSessionNotification(IAudioSessionEvents NewNotifications);
}

const GUID IID_IAudioSessionControl2 = {0xBFB7FF88, 0x7239, 0x4FC9, [0x8F, 0xA2, 0x07, 0xC9, 0x50, 0xBE, 0x9C, 0x6D]};
@GUID(0xBFB7FF88, 0x7239, 0x4FC9, [0x8F, 0xA2, 0x07, 0xC9, 0x50, 0xBE, 0x9C, 0x6D]);
interface IAudioSessionControl2 : IAudioSessionControl
{
    HRESULT GetSessionIdentifier(ushort** pRetVal);
    HRESULT GetSessionInstanceIdentifier(ushort** pRetVal);
    HRESULT GetProcessId(uint* pRetVal);
    HRESULT IsSystemSoundsSession();
    HRESULT SetDuckingPreference(BOOL optOut);
}

const GUID IID_IAudioSessionManager = {0xBFA971F1, 0x4D5E, 0x40BB, [0x93, 0x5E, 0x96, 0x70, 0x39, 0xBF, 0xBE, 0xE4]};
@GUID(0xBFA971F1, 0x4D5E, 0x40BB, [0x93, 0x5E, 0x96, 0x70, 0x39, 0xBF, 0xBE, 0xE4]);
interface IAudioSessionManager : IUnknown
{
    HRESULT GetAudioSessionControl(Guid* AudioSessionGuid, uint StreamFlags, IAudioSessionControl* SessionControl);
    HRESULT GetSimpleAudioVolume(Guid* AudioSessionGuid, uint StreamFlags, ISimpleAudioVolume* AudioVolume);
}

const GUID IID_IAudioVolumeDuckNotification = {0xC3B284D4, 0x6D39, 0x4359, [0xB3, 0xCF, 0xB5, 0x6D, 0xDB, 0x3B, 0xB3, 0x9C]};
@GUID(0xC3B284D4, 0x6D39, 0x4359, [0xB3, 0xCF, 0xB5, 0x6D, 0xDB, 0x3B, 0xB3, 0x9C]);
interface IAudioVolumeDuckNotification : IUnknown
{
    HRESULT OnVolumeDuckNotification(const(wchar)* sessionID, uint countCommunicationSessions);
    HRESULT OnVolumeUnduckNotification(const(wchar)* sessionID);
}

const GUID IID_IAudioSessionNotification = {0x641DD20B, 0x4D41, 0x49CC, [0xAB, 0xA3, 0x17, 0x4B, 0x94, 0x77, 0xBB, 0x08]};
@GUID(0x641DD20B, 0x4D41, 0x49CC, [0xAB, 0xA3, 0x17, 0x4B, 0x94, 0x77, 0xBB, 0x08]);
interface IAudioSessionNotification : IUnknown
{
    HRESULT OnSessionCreated(IAudioSessionControl NewSession);
}

const GUID IID_IAudioSessionEnumerator = {0xE2F5BB11, 0x0570, 0x40CA, [0xAC, 0xDD, 0x3A, 0xA0, 0x12, 0x77, 0xDE, 0xE8]};
@GUID(0xE2F5BB11, 0x0570, 0x40CA, [0xAC, 0xDD, 0x3A, 0xA0, 0x12, 0x77, 0xDE, 0xE8]);
interface IAudioSessionEnumerator : IUnknown
{
    HRESULT GetCount(int* SessionCount);
    HRESULT GetSession(int SessionCount, IAudioSessionControl* Session);
}

const GUID IID_IAudioSessionManager2 = {0x77AA99A0, 0x1BD6, 0x484F, [0x8B, 0xC7, 0x2C, 0x65, 0x4C, 0x9A, 0x9B, 0x6F]};
@GUID(0x77AA99A0, 0x1BD6, 0x484F, [0x8B, 0xC7, 0x2C, 0x65, 0x4C, 0x9A, 0x9B, 0x6F]);
interface IAudioSessionManager2 : IAudioSessionManager
{
    HRESULT GetSessionEnumerator(IAudioSessionEnumerator* SessionEnum);
    HRESULT RegisterSessionNotification(IAudioSessionNotification SessionNotification);
    HRESULT UnregisterSessionNotification(IAudioSessionNotification SessionNotification);
    HRESULT RegisterDuckNotification(const(wchar)* sessionID, IAudioVolumeDuckNotification duckNotification);
    HRESULT UnregisterDuckNotification(IAudioVolumeDuckNotification duckNotification);
}

enum SpatialAudioMetadataWriterOverflowMode
{
    SpatialAudioMetadataWriterOverflow_Fail = 0,
    SpatialAudioMetadataWriterOverflow_MergeWithNew = 1,
    SpatialAudioMetadataWriterOverflow_MergeWithLast = 2,
}

enum SpatialAudioMetadataCopyMode
{
    SpatialAudioMetadataCopy_Overwrite = 0,
    SpatialAudioMetadataCopy_Append = 1,
    SpatialAudioMetadataCopy_AppendMergeWithLast = 2,
    SpatialAudioMetadataCopy_AppendMergeWithFirst = 3,
}

struct SpatialAudioMetadataItemsInfo
{
    ushort FrameCount;
    ushort ItemCount;
    ushort MaxItemCount;
    uint MaxValueBufferLength;
}

struct SpatialAudioObjectRenderStreamForMetadataActivationParams
{
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType StaticObjectTypeMask;
    uint MinDynamicObjectCount;
    uint MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE EventHandle;
    Guid MetadataFormatId;
    ushort MaxMetadataItemCount;
    const(PROPVARIANT)* MetadataActivationParams;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
}

const GUID IID_ISpatialAudioMetadataItems = {0xBCD7C78F, 0x3098, 0x4F22, [0xB5, 0x47, 0xA2, 0xF2, 0x5A, 0x38, 0x12, 0x69]};
@GUID(0xBCD7C78F, 0x3098, 0x4F22, [0xB5, 0x47, 0xA2, 0xF2, 0x5A, 0x38, 0x12, 0x69]);
interface ISpatialAudioMetadataItems : IUnknown
{
    HRESULT GetFrameCount(ushort* frameCount);
    HRESULT GetItemCount(ushort* itemCount);
    HRESULT GetMaxItemCount(ushort* maxItemCount);
    HRESULT GetMaxValueBufferLength(uint* maxValueBufferLength);
    HRESULT GetInfo(SpatialAudioMetadataItemsInfo* info);
}

const GUID IID_ISpatialAudioMetadataWriter = {0x1B17CA01, 0x2955, 0x444D, [0xA4, 0x30, 0x53, 0x7D, 0xC5, 0x89, 0xA8, 0x44]};
@GUID(0x1B17CA01, 0x2955, 0x444D, [0xA4, 0x30, 0x53, 0x7D, 0xC5, 0x89, 0xA8, 0x44]);
interface ISpatialAudioMetadataWriter : IUnknown
{
    HRESULT Open(ISpatialAudioMetadataItems metadataItems);
    HRESULT WriteNextItem(ushort frameOffset);
    HRESULT WriteNextItemCommand(ubyte commandID, char* valueBuffer, uint valueBufferLength);
    HRESULT Close();
}

const GUID IID_ISpatialAudioMetadataReader = {0xB78E86A2, 0x31D9, 0x4C32, [0x94, 0xD2, 0x7D, 0xF4, 0x0F, 0xC7, 0xEB, 0xEC]};
@GUID(0xB78E86A2, 0x31D9, 0x4C32, [0x94, 0xD2, 0x7D, 0xF4, 0x0F, 0xC7, 0xEB, 0xEC]);
interface ISpatialAudioMetadataReader : IUnknown
{
    HRESULT Open(ISpatialAudioMetadataItems metadataItems);
    HRESULT ReadNextItem(ubyte* commandCount, ushort* frameOffset);
    HRESULT ReadNextItemCommand(ubyte* commandID, char* valueBuffer, uint maxValueBufferLength, uint* valueBufferLength);
    HRESULT Close();
}

const GUID IID_ISpatialAudioMetadataCopier = {0xD224B233, 0xE251, 0x4FD0, [0x9C, 0xA2, 0xD5, 0xEC, 0xF9, 0xA6, 0x84, 0x04]};
@GUID(0xD224B233, 0xE251, 0x4FD0, [0x9C, 0xA2, 0xD5, 0xEC, 0xF9, 0xA6, 0x84, 0x04]);
interface ISpatialAudioMetadataCopier : IUnknown
{
    HRESULT Open(ISpatialAudioMetadataItems metadataItems);
    HRESULT CopyMetadataForFrames(ushort copyFrameCount, SpatialAudioMetadataCopyMode copyMode, ISpatialAudioMetadataItems dstMetadataItems, ushort* itemsCopied);
    HRESULT Close();
}

const GUID IID_ISpatialAudioMetadataItemsBuffer = {0x42640A16, 0xE1BD, 0x42D9, [0x9F, 0xF6, 0x03, 0x1A, 0xB7, 0x1A, 0x2D, 0xBA]};
@GUID(0x42640A16, 0xE1BD, 0x42D9, [0x9F, 0xF6, 0x03, 0x1A, 0xB7, 0x1A, 0x2D, 0xBA]);
interface ISpatialAudioMetadataItemsBuffer : IUnknown
{
    HRESULT AttachToBuffer(char* buffer, uint bufferLength);
    HRESULT AttachToPopulatedBuffer(char* buffer, uint bufferLength);
    HRESULT DetachBuffer();
}

const GUID IID_ISpatialAudioMetadataClient = {0x777D4A3B, 0xF6FF, 0x4A26, [0x85, 0xDC, 0x68, 0xD7, 0xCD, 0xED, 0xA1, 0xD4]};
@GUID(0x777D4A3B, 0xF6FF, 0x4A26, [0x85, 0xDC, 0x68, 0xD7, 0xCD, 0xED, 0xA1, 0xD4]);
interface ISpatialAudioMetadataClient : IUnknown
{
    HRESULT ActivateSpatialAudioMetadataItems(ushort maxItemCount, ushort frameCount, ISpatialAudioMetadataItemsBuffer* metadataItemsBuffer, ISpatialAudioMetadataItems* metadataItems);
    HRESULT GetSpatialAudioMetadataItemsBufferLength(ushort maxItemCount, uint* bufferLength);
    HRESULT ActivateSpatialAudioMetadataWriter(SpatialAudioMetadataWriterOverflowMode overflowMode, ISpatialAudioMetadataWriter* metadataWriter);
    HRESULT ActivateSpatialAudioMetadataCopier(ISpatialAudioMetadataCopier* metadataCopier);
    HRESULT ActivateSpatialAudioMetadataReader(ISpatialAudioMetadataReader* metadataReader);
}

const GUID IID_ISpatialAudioObjectForMetadataCommands = {0x0DF2C94B, 0xF5F9, 0x472D, [0xAF, 0x6B, 0xC4, 0x6E, 0x0A, 0xC9, 0xCD, 0x05]};
@GUID(0x0DF2C94B, 0xF5F9, 0x472D, [0xAF, 0x6B, 0xC4, 0x6E, 0x0A, 0xC9, 0xCD, 0x05]);
interface ISpatialAudioObjectForMetadataCommands : ISpatialAudioObjectBase
{
    HRESULT WriteNextMetadataCommand(ubyte commandID, char* valueBuffer, uint valueBufferLength);
}

const GUID IID_ISpatialAudioObjectForMetadataItems = {0xDDEA49FF, 0x3BC0, 0x4377, [0x8A, 0xAD, 0x9F, 0xBC, 0xFD, 0x80, 0x85, 0x66]};
@GUID(0xDDEA49FF, 0x3BC0, 0x4377, [0x8A, 0xAD, 0x9F, 0xBC, 0xFD, 0x80, 0x85, 0x66]);
interface ISpatialAudioObjectForMetadataItems : ISpatialAudioObjectBase
{
    HRESULT GetSpatialAudioMetadataItems(ISpatialAudioMetadataItems* metadataItems);
}

const GUID IID_ISpatialAudioObjectRenderStreamForMetadata = {0xBBC9C907, 0x48D5, 0x4A2E, [0xA0, 0xC7, 0xF7, 0xF0, 0xD6, 0x7C, 0x1F, 0xB1]};
@GUID(0xBBC9C907, 0x48D5, 0x4A2E, [0xA0, 0xC7, 0xF7, 0xF0, 0xD6, 0x7C, 0x1F, 0xB1]);
interface ISpatialAudioObjectRenderStreamForMetadata : ISpatialAudioObjectRenderStreamBase
{
    HRESULT ActivateSpatialAudioObjectForMetadataCommands(AudioObjectType type, ISpatialAudioObjectForMetadataCommands* audioObject);
    HRESULT ActivateSpatialAudioObjectForMetadataItems(AudioObjectType type, ISpatialAudioObjectForMetadataItems* audioObject);
}

@DllImport("WINMM.dll")
uint mciSendCommandA(uint mciId, uint uMsg, uint dwParam1, uint dwParam2);

@DllImport("WINMM.dll")
uint mciSendCommandW(uint mciId, uint uMsg, uint dwParam1, uint dwParam2);

@DllImport("WINMM.dll")
uint mciSendStringA(const(char)* lpstrCommand, const(char)* lpstrReturnString, uint uReturnLength, HWND hwndCallback);

@DllImport("WINMM.dll")
uint mciSendStringW(const(wchar)* lpstrCommand, const(wchar)* lpstrReturnString, uint uReturnLength, HWND hwndCallback);

@DllImport("WINMM.dll")
uint mciGetDeviceIDA(const(char)* pszDevice);

@DllImport("WINMM.dll")
uint mciGetDeviceIDW(const(wchar)* pszDevice);

@DllImport("WINMM.dll")
uint mciGetDeviceIDFromElementIDA(uint dwElementID, const(char)* lpstrType);

@DllImport("WINMM.dll")
uint mciGetDeviceIDFromElementIDW(uint dwElementID, const(wchar)* lpstrType);

@DllImport("WINMM.dll")
BOOL mciGetErrorStringA(uint mcierr, const(char)* pszText, uint cchText);

@DllImport("WINMM.dll")
BOOL mciGetErrorStringW(uint mcierr, const(wchar)* pszText, uint cchText);

@DllImport("WINMM.dll")
BOOL mciSetYieldProc(uint mciId, YIELDPROC fpYieldProc, uint dwYieldData);

@DllImport("WINMM.dll")
int mciGetCreatorTask(uint mciId);

@DllImport("WINMM.dll")
YIELDPROC mciGetYieldProc(uint mciId, uint* pdwYieldData);

@DllImport("WINMM.dll")
uint mciGetDriverData(uint wDeviceID);

@DllImport("WINMM.dll")
uint mciLoadCommandResource(HANDLE hInstance, const(wchar)* lpResName, uint wType);

@DllImport("WINMM.dll")
BOOL mciSetDriverData(uint wDeviceID, uint dwData);

@DllImport("WINMM.dll")
uint mciDriverYield(uint wDeviceID);

@DllImport("WINMM.dll")
BOOL mciDriverNotify(HANDLE hwndCallback, uint wDeviceID, uint uStatus);

@DllImport("WINMM.dll")
BOOL mciFreeCommandResource(uint wTable);

@DllImport("ksuser.dll")
uint KsCreateAllocator(HANDLE ConnectionHandle, KSALLOCATOR_FRAMING* AllocatorFraming, int* AllocatorHandle);

@DllImport("ksuser.dll")
uint KsCreateClock(HANDLE ConnectionHandle, KSCLOCK_CREATE* ClockCreate, int* ClockHandle);

@DllImport("ksuser.dll")
uint KsCreatePin(HANDLE FilterHandle, KSPIN_CONNECT* Connect, uint DesiredAccess, int* ConnectionHandle);

@DllImport("ksuser.dll")
uint KsCreateTopologyNode(HANDLE ParentHandle, KSNODE_CREATE* NodeCreate, uint DesiredAccess, int* NodeHandle);

@DllImport("ksuser.dll")
HRESULT KsCreateAllocator2(HANDLE ConnectionHandle, KSALLOCATOR_FRAMING* AllocatorFraming, int* AllocatorHandle);

@DllImport("ksuser.dll")
HRESULT KsCreateClock2(HANDLE ConnectionHandle, KSCLOCK_CREATE* ClockCreate, int* ClockHandle);

@DllImport("ksuser.dll")
HRESULT KsCreatePin2(HANDLE FilterHandle, KSPIN_CONNECT* Connect, uint DesiredAccess, int* ConnectionHandle);

@DllImport("ksuser.dll")
HRESULT KsCreateTopologyNode2(HANDLE ParentHandle, KSNODE_CREATE* NodeCreate, uint DesiredAccess, int* NodeHandle);

@DllImport("MMDevAPI.dll")
HRESULT ActivateAudioInterfaceAsync(const(wchar)* deviceInterfacePath, const(Guid)* riid, PROPVARIANT* activationParams, IActivateAudioInterfaceCompletionHandler completionHandler, IActivateAudioInterfaceAsyncOperation* activationOperation);

