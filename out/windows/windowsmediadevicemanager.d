// Written in the D programming language.

module windows.windowsmediadevicemanager;

public import windows.core;
public import windows.com : HRESULT, ISpecifyPropertyPages, IUnknown;
public import windows.displaydevices : RECT;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias WMDM_TAG_DATATYPE = int;
enum : int
{
    WMDM_TYPE_DWORD  = 0x00000000,
    WMDM_TYPE_STRING = 0x00000001,
    WMDM_TYPE_BINARY = 0x00000002,
    WMDM_TYPE_BOOL   = 0x00000003,
    WMDM_TYPE_QWORD  = 0x00000004,
    WMDM_TYPE_WORD   = 0x00000005,
    WMDM_TYPE_GUID   = 0x00000006,
    WMDM_TYPE_DATE   = 0x00000007,
}

alias WMDM_SESSION_TYPE = int;
enum : int
{
    WMDM_SESSION_NONE                 = 0x00000000,
    WMDM_SESSION_TRANSFER_TO_DEVICE   = 0x00000001,
    WMDM_SESSION_TRANSFER_FROM_DEVICE = 0x00000010,
    WMDM_SESSION_DELETE               = 0x00000100,
    WMDM_SESSION_CUSTOM               = 0x00001000,
}

alias WMDM_STORAGE_ENUM_MODE = int;
enum : int
{
    ENUM_MODE_RAW             = 0x00000000,
    ENUM_MODE_USE_DEVICE_PREF = 0x00000001,
    ENUM_MODE_METADATA_VIEWS  = 0x00000002,
}

alias WMDM_FORMATCODE = int;
enum : int
{
    WMDM_FORMATCODE_NOTUSED                     = 0x00000000,
    WMDM_FORMATCODE_ALLIMAGES                   = 0xffffffff,
    WMDM_FORMATCODE_UNDEFINED                   = 0x00003000,
    WMDM_FORMATCODE_ASSOCIATION                 = 0x00003001,
    WMDM_FORMATCODE_SCRIPT                      = 0x00003002,
    WMDM_FORMATCODE_EXECUTABLE                  = 0x00003003,
    WMDM_FORMATCODE_TEXT                        = 0x00003004,
    WMDM_FORMATCODE_HTML                        = 0x00003005,
    WMDM_FORMATCODE_DPOF                        = 0x00003006,
    WMDM_FORMATCODE_AIFF                        = 0x00003007,
    WMDM_FORMATCODE_WAVE                        = 0x00003008,
    WMDM_FORMATCODE_MP3                         = 0x00003009,
    WMDM_FORMATCODE_AVI                         = 0x0000300a,
    WMDM_FORMATCODE_MPEG                        = 0x0000300b,
    WMDM_FORMATCODE_ASF                         = 0x0000300c,
    WMDM_FORMATCODE_RESERVED_FIRST              = 0x0000300d,
    WMDM_FORMATCODE_RESERVED_LAST               = 0x000037ff,
    WMDM_FORMATCODE_IMAGE_UNDEFINED             = 0x00003800,
    WMDM_FORMATCODE_IMAGE_EXIF                  = 0x00003801,
    WMDM_FORMATCODE_IMAGE_TIFFEP                = 0x00003802,
    WMDM_FORMATCODE_IMAGE_FLASHPIX              = 0x00003803,
    WMDM_FORMATCODE_IMAGE_BMP                   = 0x00003804,
    WMDM_FORMATCODE_IMAGE_CIFF                  = 0x00003805,
    WMDM_FORMATCODE_IMAGE_GIF                   = 0x00003807,
    WMDM_FORMATCODE_IMAGE_JFIF                  = 0x00003808,
    WMDM_FORMATCODE_IMAGE_PCD                   = 0x00003809,
    WMDM_FORMATCODE_IMAGE_PICT                  = 0x0000380a,
    WMDM_FORMATCODE_IMAGE_PNG                   = 0x0000380b,
    WMDM_FORMATCODE_IMAGE_TIFF                  = 0x0000380d,
    WMDM_FORMATCODE_IMAGE_TIFFIT                = 0x0000380e,
    WMDM_FORMATCODE_IMAGE_JP2                   = 0x0000380f,
    WMDM_FORMATCODE_IMAGE_JPX                   = 0x00003810,
    WMDM_FORMATCODE_IMAGE_RESERVED_FIRST        = 0x00003811,
    WMDM_FORMATCODE_IMAGE_RESERVED_LAST         = 0x00003fff,
    WMDM_FORMATCODE_UNDEFINEDFIRMWARE           = 0x0000b802,
    WMDM_FORMATCODE_WBMP                        = 0x0000b803,
    WMDM_FORMATCODE_JPEGXR                      = 0x0000b804,
    WMDM_FORMATCODE_WINDOWSIMAGEFORMAT          = 0x0000b881,
    WMDM_FORMATCODE_UNDEFINEDAUDIO              = 0x0000b900,
    WMDM_FORMATCODE_WMA                         = 0x0000b901,
    WMDM_FORMATCODE_OGG                         = 0x0000b902,
    WMDM_FORMATCODE_AAC                         = 0x0000b903,
    WMDM_FORMATCODE_AUDIBLE                     = 0x0000b904,
    WMDM_FORMATCODE_FLAC                        = 0x0000b906,
    WMDM_FORMATCODE_QCELP                       = 0x0000b907,
    WMDM_FORMATCODE_AMR                         = 0x0000b908,
    WMDM_FORMATCODE_UNDEFINEDVIDEO              = 0x0000b980,
    WMDM_FORMATCODE_WMV                         = 0x0000b981,
    WMDM_FORMATCODE_MP4                         = 0x0000b982,
    WMDM_FORMATCODE_MP2                         = 0x0000b983,
    WMDM_FORMATCODE_3GP                         = 0x0000b984,
    WMDM_FORMATCODE_3G2                         = 0x0000b985,
    WMDM_FORMATCODE_AVCHD                       = 0x0000b986,
    WMDM_FORMATCODE_ATSCTS                      = 0x0000b987,
    WMDM_FORMATCODE_DVBTS                       = 0x0000b988,
    WMDM_FORMATCODE_MKV                         = 0x0000b989,
    WMDM_FORMATCODE_MKA                         = 0x0000b98a,
    WMDM_FORMATCODE_MK3D                        = 0x0000b98b,
    WMDM_FORMATCODE_UNDEFINEDCOLLECTION         = 0x0000ba00,
    WMDM_FORMATCODE_ABSTRACTMULTIMEDIAALBUM     = 0x0000ba01,
    WMDM_FORMATCODE_ABSTRACTIMAGEALBUM          = 0x0000ba02,
    WMDM_FORMATCODE_ABSTRACTAUDIOALBUM          = 0x0000ba03,
    WMDM_FORMATCODE_ABSTRACTVIDEOALBUM          = 0x0000ba04,
    WMDM_FORMATCODE_ABSTRACTAUDIOVIDEOPLAYLIST  = 0x0000ba05,
    WMDM_FORMATCODE_ABSTRACTCONTACTGROUP        = 0x0000ba06,
    WMDM_FORMATCODE_ABSTRACTMESSAGEFOLDER       = 0x0000ba07,
    WMDM_FORMATCODE_ABSTRACTCHAPTEREDPRODUCTION = 0x0000ba08,
    WMDM_FORMATCODE_MEDIA_CAST                  = 0x0000ba0b,
    WMDM_FORMATCODE_WPLPLAYLIST                 = 0x0000ba10,
    WMDM_FORMATCODE_M3UPLAYLIST                 = 0x0000ba11,
    WMDM_FORMATCODE_MPLPLAYLIST                 = 0x0000ba12,
    WMDM_FORMATCODE_ASXPLAYLIST                 = 0x0000ba13,
    WMDM_FORMATCODE_PLSPLAYLIST                 = 0x0000ba14,
    WMDM_FORMATCODE_UNDEFINEDDOCUMENT           = 0x0000ba80,
    WMDM_FORMATCODE_ABSTRACTDOCUMENT            = 0x0000ba81,
    WMDM_FORMATCODE_XMLDOCUMENT                 = 0x0000ba82,
    WMDM_FORMATCODE_MICROSOFTWORDDOCUMENT       = 0x0000ba83,
    WMDM_FORMATCODE_MHTCOMPILEDHTMLDOCUMENT     = 0x0000ba84,
    WMDM_FORMATCODE_MICROSOFTEXCELSPREADSHEET   = 0x0000ba85,
    WMDM_FORMATCODE_MICROSOFTPOWERPOINTDOCUMENT = 0x0000ba86,
    WMDM_FORMATCODE_UNDEFINEDMESSAGE            = 0x0000bb00,
    WMDM_FORMATCODE_ABSTRACTMESSAGE             = 0x0000bb01,
    WMDM_FORMATCODE_UNDEFINEDCONTACT            = 0x0000bb80,
    WMDM_FORMATCODE_ABSTRACTCONTACT             = 0x0000bb81,
    WMDM_FORMATCODE_VCARD2                      = 0x0000bb82,
    WMDM_FORMATCODE_VCARD3                      = 0x0000bb83,
    WMDM_FORMATCODE_UNDEFINEDCALENDARITEM       = 0x0000be00,
    WMDM_FORMATCODE_ABSTRACTCALENDARITEM        = 0x0000be01,
    WMDM_FORMATCODE_VCALENDAR1                  = 0x0000be02,
    WMDM_FORMATCODE_VCALENDAR2                  = 0x0000be03,
    WMDM_FORMATCODE_UNDEFINEDWINDOWSEXECUTABLE  = 0x0000be80,
    WMDM_FORMATCODE_M4A                         = 0x4d503441,
    WMDM_FORMATCODE_3GPA                        = 0x33475041,
    WMDM_FORMATCODE_3G2A                        = 0x33473241,
    WMDM_FORMATCODE_SECTION                     = 0x0000be82,
}

alias WMDM_ENUM_PROP_VALID_VALUES_FORM = int;
enum : int
{
    WMDM_ENUM_PROP_VALID_VALUES_ANY   = 0x00000000,
    WMDM_ENUM_PROP_VALID_VALUES_RANGE = 0x00000001,
    WMDM_ENUM_PROP_VALID_VALUES_ENUM  = 0x00000002,
}

alias WMDM_FIND_SCOPE = int;
enum : int
{
    WMDM_FIND_SCOPE_GLOBAL             = 0x00000000,
    WMDM_FIND_SCOPE_IMMEDIATE_CHILDREN = 0x00000001,
}

enum WMDMMessage : int
{
    WMDM_MSG_DEVICE_ARRIVAL = 0x00000000,
    WMDM_MSG_DEVICE_REMOVAL = 0x00000001,
    WMDM_MSG_MEDIA_ARRIVAL  = 0x00000002,
    WMDM_MSG_MEDIA_REMOVAL  = 0x00000003,
}

// Constants


enum : const(wchar)*
{
    g_wszWMDMFileName         = "WMDM/FileName",
    g_wszWMDMFormatCode       = "WMDM/FormatCode",
    g_wszWMDMLastModifiedDate = "WMDM/LastModifiedDate",
}

enum : const(wchar)*
{
    g_wszWMDMFileSize       = "WMDM/FileSize",
    g_wszWMDMFileAttributes = "WMDM/FileAttributes",
}

enum const(wchar)* g_wszVideoFourCCCodec = "WMDM/VideoFourCCCodec";

enum : const(wchar)*
{
    g_wszWMDMAuthor             = "WMDM/Author",
    g_wszWMDMDescription        = "WMDM/Description",
    g_wszWMDMIsProtected        = "WMDM/IsProtected",
    g_wszWMDMAlbumTitle         = "WMDM/AlbumTitle",
    g_wszWMDMAlbumArtist        = "WMDM/AlbumArtist",
    g_wszWMDMTrack              = "WMDM/Track",
    g_wszWMDMGenre              = "WMDM/Genre",
    g_wszWMDMTrackMood          = "WMDM/TrackMood",
    g_wszWMDMAlbumCoverFormat   = "WMDM/AlbumCoverFormat",
    g_wszWMDMAlbumCoverSize     = "WMDM/AlbumCoverSize",
    g_wszWMDMAlbumCoverHeight   = "WMDM/AlbumCoverHeight",
    g_wszWMDMAlbumCoverWidth    = "WMDM/AlbumCoverWidth",
    g_wszWMDMAlbumCoverDuration = "WMDM/AlbumCoverDuration",
    g_wszWMDMAlbumCoverData     = "WMDM/AlbumCoverData",
}

enum : const(wchar)*
{
    g_wszWMDMComposer       = "WMDM/Composer",
    g_wszWMDMCodec          = "WMDM/Codec",
    g_wszWMDMDRMId          = "WMDM/DRMId",
    g_wszWMDMBitrate        = "WMDM/Bitrate",
    g_wszWMDMBitRateType    = "WMDM/BitRateType",
    g_wszWMDMSampleRate     = "WMDM/SampleRate",
    g_wszWMDMNumChannels    = "WMDM/NumChannels",
    g_wszWMDMBlockAlignment = "WMDM/BlockAlignment",
}

enum : const(wchar)*
{
    g_wszWMDMTotalBitrate     = "WMDM/TotalBitrate",
    g_wszWMDMVideoBitrate     = "WMDM/VideoBitrate",
    g_wszWMDMFrameRate        = "WMDM/FrameRate",
    g_wszWMDMScanType         = "WMDM/ScanType",
    g_wszWMDMKeyFrameDistance = "WMDM/KeyFrameDistance",
}

enum const(wchar)* g_wszWMDMQualitySetting = "WMDM/QualitySetting";

enum : const(wchar)*
{
    g_wszWMDMDuration           = "WMDM/Duration",
    g_wszWMDMAlbumArt           = "WMDM/AlbumArt",
    g_wszWMDMBuyNow             = "WMDM/BuyNow",
    g_wszWMDMNonConsumable      = "WMDM/NonConsumable",
    g_wszWMDMediaClassPrimaryID = "WMDM/MediaClassPrimaryID",
}

enum : const(wchar)*
{
    g_wszWMDMUserEffectiveRating = "WMDM/UserEffectiveRating",
    g_wszWMDMUserRating          = "WMDM/UserRating",
    g_wszWMDMUserRatingOnDevice  = "WMDM/UserRatingOnDevice",
}

enum const(wchar)* g_wszWMDMDevicePlayCount = "WMDM/DevicePlayCount";
enum const(wchar)* g_wszWMDMUserLastPlayTime = "WMDM/UserLastPlayTime";
enum const(wchar)* g_wszWMDMSubTitleDescription = "WMDM/SubTitleDescription";

enum : const(wchar)*
{
    g_wszWMDMMediaStationName               = "WMDM/MediaStationName",
    g_wszWMDMMediaOriginalChannel           = "WMDM/MediaOriginalChannel",
    g_wszWMDMMediaOriginalBroadcastDateTime = "WMDM/MediaOriginalBroadcastDateTime",
}

enum : const(wchar)*
{
    g_wszWMDMSyncID             = "WMDM/SyncID",
    g_wszWMDMPersistentUniqueID = "WMDM/PersistentUniqueID",
}

enum : const(wchar)*
{
    g_wszWMDMHeight         = "WMDM/Height",
    g_wszWMDMSyncTime       = "WMDM/SyncTime",
    g_wszWMDMParentalRating = "WMDM/ParentalRating",
}

enum : const(wchar)*
{
    g_wszWMDMIsRepeat                  = "WMDM/IsRepeat",
    g_wszWMDMSupportedDeviceProperties = "WMDM/SupportedDeviceProperties",
}

enum : const(wchar)*
{
    g_wszWMDMFormatsSupported           = "WMDM/FormatsSupported",
    g_wszWMDMFormatsSupportedAreOrdered = "WMDM/FormatsSupportedAreOrdered",
}

enum : const(wchar)*
{
    g_wszWMDMDeviceModelName             = "WMDM/DeviceModelName",
    g_wszWMDMDeviceFirmwareVersion       = "WMDM/DeviceFirmwareVersion",
    g_wszWMDMDeviceVendorExtension       = "WMDM/DeviceVendorExtension",
    g_wszWMDMDeviceProtocol              = "WMDM/DeviceProtocol",
    g_wszWMDMDeviceServiceProviderVendor = "WMDM/DeviceServiceProviderVendor",
    g_wszWMDMDeviceRevocationInfo        = "WMDM/DeviceRevocationInfo",
}

enum : const(wchar)*
{
    g_wszWMDMOwner          = "WMDM/Owner",
    g_wszWMDMEditor         = "WMDM/Editor",
    g_wszWMDMWebmaster      = "WMDM/Webmaster",
    g_wszWMDMSourceURL      = "WMDM/SourceURL",
    g_wszWMDMDestinationURL = "WMDM/DestinationURL",
}

enum : const(wchar)*
{
    g_wszWMDMTimeBookmark   = "WMDM/TimeBookmark",
    g_wszWMDMObjectBookmark = "WMDM/ObjectBookmark",
}

enum : const(wchar)*
{
    g_wszWMDMDataOffset = "WMDM/DataOffset",
    g_wszWMDMDataLength = "WMDM/DataLength",
    g_wszWMDMDataUnits  = "WMDM/DataUnits",
    g_wszWMDMTimeToLive = "WMDM/TimeToLive",
    g_wszWMDMMediaGuid  = "WMDM/MediaGuid",
}

enum GUID EVENT_WMDM_CONTENT_TRANSFER = GUID("339c9bf4-bcfe-4ed8-94df-eaf8c26ab61b");
enum uint MTP_RESPONSE_MAX_PARAMS = 0x00000005;

// Structs


struct __MACINFO
{
    BOOL      fUsed;
    ubyte[36] abMacState;
}

struct _tWAVEFORMATEX
{
    ushort wFormatTag;
    ushort nChannels;
    uint   nSamplesPerSec;
    uint   nAvgBytesPerSec;
    ushort nBlockAlign;
    ushort wBitsPerSample;
    ushort cbSize;
}

struct _tagBITMAPINFOHEADER
{
    uint   biSize;
    int    biWidth;
    int    biHeight;
    ushort biPlanes;
    ushort biBitCount;
    uint   biCompression;
    uint   biSizeImage;
    int    biXPelsPerMeter;
    int    biYPelsPerMeter;
    uint   biClrUsed;
    uint   biClrImportant;
}

struct _tagVIDEOINFOHEADER
{
    RECT                 rcSource;
    RECT                 rcTarget;
    uint                 dwBitRate;
    uint                 dwBitErrorRate;
    long                 AvgTimePerFrame;
    _tagBITMAPINFOHEADER bmiHeader;
}

struct WMFILECAPABILITIES
{
    PWSTR pwszMimeType;
    uint  dwReserved;
}

struct __OPAQUECOMMAND
{
    GUID      guidCommand;
    uint      dwDataLen;
    ubyte*    pData;
    ubyte[20] abMAC;
}

struct __WMDMID
{
    uint       cbSize;
    uint       dwVendorID;
    ubyte[128] pID;
    uint       SerialNumberLength;
}

struct WMDMDATETIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
}

struct __WMDMRIGHTS
{
    uint         cbSize;
    uint         dwContentType;
    uint         fuFlags;
    uint         fuRights;
    uint         dwAppSec;
    uint         dwPlaybackCount;
    WMDMDATETIME ExpirationDate;
}

struct __WMDMMetadataView
{
    PWSTR    pwszViewName;
    uint     nDepth;
    ushort** ppwszTags;
}

struct WMDM_PROP_VALUES_RANGE
{
    PROPVARIANT rangeMin;
    PROPVARIANT rangeMax;
    PROPVARIANT rangeStep;
}

struct WMDM_PROP_VALUES_ENUM
{
    uint         cEnumValues;
    PROPVARIANT* pValues;
}

struct WMDM_PROP_DESC
{
    PWSTR pwszPropName;
    WMDM_ENUM_PROP_VALID_VALUES_FORM ValidValuesForm;
union ValidValues
    {
        WMDM_PROP_VALUES_RANGE ValidValuesRange;
        WMDM_PROP_VALUES_ENUM EnumeratedValidValues;
    }
}

struct WMDM_PROP_CONFIG
{
    uint            nPreference;
    uint            nPropDesc;
    WMDM_PROP_DESC* pPropDesc;
}

struct WMDM_FORMAT_CAPABILITY
{
    uint              nPropConfig;
    WMDM_PROP_CONFIG* pConfigs;
}

union WMDMDetermineMaxPropStringLen
{
    ushort[27] sz001;
    ushort[31] sz002;
    ushort[14] sz003;
    ushort[16] sz004;
    ushort[22] sz005;
    ushort[14] sz006;
    ushort[20] sz007;
    ushort[20] sz008;
    ushort[22] sz009;
    ushort[11] sz010;
    ushort[12] sz011;
    ushort[17] sz012;
    ushort[17] sz013;
    ushort[16] sz014;
    ushort[17] sz015;
    ushort[11] sz016;
    ushort[11] sz017;
    ushort[15] sz018;
    ushort[22] sz019;
    ushort[20] sz020;
    ushort[22] sz021;
    ushort[21] sz022;
    ushort[24] sz023;
    ushort[20] sz024;
    ushort[10] sz025;
    ushort[14] sz026;
    ushort[11] sz027;
    ushort[11] sz028;
    ushort[13] sz029;
    ushort[17] sz030;
    ushort[16] sz031;
    ushort[17] sz032;
    ushort[20] sz033;
    ushort[19] sz034;
    ushort[18] sz035;
    ushort[18] sz036;
    ushort[15] sz037;
    ushort[14] sz041;
    ushort[22] sz043;
    ushort[16] sz044;
    ushort[20] sz045;
    ushort[14] sz046;
    ushort[14] sz047;
    ushort[12] sz048;
    ushort[25] sz049;
    ushort[26] sz050;
    ushort[25] sz051;
    ushort[16] sz052;
    ushort[24] sz053;
    ushort[15] sz054;
    ushort[21] sz055;
    ushort[16] sz056;
    ushort[22] sz057;
    ushort[14] sz058;
    ushort[25] sz059;
    ushort[18] sz060;
    ushort[22] sz061;
    ushort[26] sz062;
    ushort[36] sz063;
    ushort[23] sz064;
    ushort[12] sz065;
    ushort[24] sz066;
    ushort[11] sz067;
    ushort[12] sz068;
    ushort[14] sz069;
    ushort[20] sz070;
    ushort[15] sz071;
    ushort[14] sz072;
    ushort[31] sz073;
    ushort[24] sz074;
    ushort[22] sz075;
    ushort[24] sz076;
    ushort[21] sz077;
    ushort[27] sz078;
    ushort[27] sz079;
    ushort[20] sz080;
    ushort[33] sz081;
    ushort[21] sz082;
    ushort[32] sz083;
    ushort[26] sz084;
    ushort[18] sz085;
    ushort[30] sz086;
}

///The <b>MTP_COMMAND_DATA_IN</b> structure contains Media Transport Protocol (MTP) custom commands that are sent to the
///device by using the IWMDMDevice3::DeviceIoControl method.
struct MTP_COMMAND_DATA_IN
{
align (1):
    ///Operation code.
    ushort   OpCode;
    ///Number of parameters passed in.
    uint     NumParams;
    ///Parameters to the command. <b>MTP_COMMAND_MAX_PARAMS</b> is a defined constant with a value of 5.
    uint[5]  Params;
    ///Indicates whether the command has a read data phase, a write data phase, or no data phase. The valid values are
    ///defined in the following table.
    uint     NextPhase;
    ///Data size of <b>CommandWriteData</b>[1], in bytes.
    uint     CommandWriteDataSize;
    ///Optional, first byte of data to write to the device if <b>NextPhase</b> is MTP_NEXTPHASE_WRITE_DATA.
    ubyte[1] CommandWriteData;
}

///The <b>MTP_COMMAND_DATA_OUT</b> structure contains Media Transport Protocol (MTP) responses that are filled by the
///device driver on exiting a call to IWMDMDevice3::DeviceIoControl.
struct MTP_COMMAND_DATA_OUT
{
align (1):
    ///Response code.
    ushort   ResponseCode;
    ///Number of parameters for this response.
    uint     NumParams;
    ///Parameters of the response. <b>MTP_RESPONSE_MAX_PARAMS</b> is a defined constant with a value of 5.
    uint[5]  Params;
    ///Data size of <b>CommandReadData</b>[1], in bytes.
    uint     CommandReadDataSize;
    ///Optional, first byte of data to read from the device if <b>MTP_COMMAND_DATA_IN.NextPhase</b> is
    ///MTP_NEXTPHASE_READ_DATA.
    ubyte[1] CommandReadData;
}

// Interfaces

@GUID("50040C1D-BDBF-4924-B873-F14D6C5BFD66")
struct MediaDevMgrClassFactory;

@GUID("25BAAD81-3560-11D3-8471-00C04F79DBC0")
struct MediaDevMgr;

@GUID("807B3CDF-357A-11D3-8471-00C04F79DBC0")
struct WMDMDevice;

@GUID("807B3CE0-357A-11D3-8471-00C04F79DBC0")
struct WMDMStorage;

@GUID("807B3CE1-357A-11D3-8471-00C04F79DBC0")
struct WMDMStorageGlobal;

@GUID("430E35AF-3971-11D3-8474-00C04F79DBC0")
struct WMDMDeviceEnum;

@GUID("EB401A3B-3AF7-11D3-8474-00C04F79DBC0")
struct WMDMStorageEnum;

@GUID("110A3202-5A79-11D3-8D78-444553540000")
struct WMDMLogger;

///The <b>IWMDMMetaData</b> interface sets and retrieves metadata properties (such as artist, album, genre, and so on)
///of a storage. Metadata properties are stored as name-value pairs. To create a new, empty instance of this interface,
///call IWMDMStorage3::CreateEmptyMetadataObject. To retrieve this interface (with values), call
///IWMDMStorage3::GetMetadata or IWMDMStorage4::GetSpecifiedMetadata.
@GUID("EC3B0663-0951-460A-9A80-0DCEED3C043C")
interface IWMDMMetaData : IUnknown
{
    ///The <b>AddItem</b> method adds a metadata property to the interface.
    ///Params:
    ///    Type = An WMDM_TAG_DATATYPE enumerated value specifying the type of metadata being saved.
    ///    pwszTagName = Pointer to a wide-character, null-terminated string specifying the name of the property to set. A list of
    ///                  standard property name constants is given in Metadata Constants.
    ///    pValue = Pointer to a byte array specifying the value to assign to the property. The submitted value is copied, so the
    ///             memory can be freed after calling <b>AddItem</b>.
    ///    iLength = Integer specifying the size of <i>pValue</i>, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT AddItem(WMDM_TAG_DATATYPE Type, const(PWSTR) pwszTagName, ubyte* pValue, uint iLength);
    ///The <b>QueryByName</b> method retrieves the value of a property specified by name.
    ///Params:
    ///    pwszTagName = Pointer to a wide-character <b>null</b>-terminated string specifying the property name. A list of standard
    ///                  property name constants is given in Metadata Constants.
    ///    pType = An WMDM_TAG_DATATYPE enumerated value describing the type of data retrieved by <i>pValue</i>.
    ///    pValue = Pointer to a pointer to a byte array that receives the content of the value if the method succeeds. Windows
    ///             Media Device Manager allocates this memory and the caller must free it using <b>CoTaskMemFree</b>.
    ///    pcbLength = Pointer to the size, in bytes, of the byte array <i>ppValue</i>. If the value is a string, this includes the
    ///                termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT QueryByName(const(PWSTR) pwszTagName, WMDM_TAG_DATATYPE* pType, ubyte** pValue, uint* pcbLength);
    ///The <b>QueryByIndex</b> method retrieves the value of a property specified by index.
    ///Params:
    ///    iIndex = Integer specifying the zero-based index of the property. The number of items is obtained through the
    ///             GetItemCount call.
    ///    ppwszName = Name of the property. Windows Media Device Manager allocates this memory, and the caller must free it using
    ///                <b>CoTaskMemFree</b>.
    ///    pType = An WMDM_TAG_DATATYPE enumerated value describing the type of data returned in <i>ppValue</i>.
    ///    ppValue = Pointer to a pointer to a byte array that receives the content of the value if the method succeeds. This
    ///              memory is allocated by Windows Media Device Manager, and the caller must free it using <b>CoTaskMemFree</b>.
    ///    pcbLength = Pointer to the size, in bytes, of the byte array <i>ppValue</i>. If the value is a string, this includes the
    ///                termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT QueryByIndex(uint iIndex, ushort** ppwszName, WMDM_TAG_DATATYPE* pType, ubyte** ppValue, 
                         uint* pcbLength);
    ///The <b>GetItemCount</b> method retrieves the total number of properties held by the interface.
    ///Params:
    ///    iCount = Pointer to an integer that receives the total number of metadata properties stored by the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetItemCount(uint* iCount);
}

///The <b>IWMDeviceManager</b> interface is the top level Windows Media Device Manager interface for applications. This
///is the first interface accessed by an application, and is used to acquire the IWMDMEnumDevice interface used to
///enumerate the connected devices. This interface is obtained by calling <b>QueryInterface</b> on the authenticated
///IComponentAuthenticate interface. If the device supports it, use IWMDeviceManager2 interface, which offers superior
///device enumeration capabilities.
@GUID("1DCB3A00-33ED-11D3-8470-00C04F79DBC0")
interface IWMDeviceManager : IUnknown
{
    ///The <b>GetRevision</b> method retrieves the version number of Windows Media Device Manager currently in use.
    ///Params:
    ///    pdwRevision = Pointer to a <b>DWORD</b> specifying the Windows Media Device Manager version number. Windows Media Device
    ///                  Manager 10 returns 0x00080000.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetRevision(uint* pdwRevision);
    ///The <b>GetDeviceCount</b> method retrieves the number of portable devices that are currently connected to the
    ///computer.
    ///Params:
    ///    pdwCount = Pointer to a <b>DWORD</b> specifying the count of known devices.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetDeviceCount(uint* pdwCount);
    ///The <b>EnumDevices</b> method retrieves a pointer to the IWMDMEnumDevice interface that can be used to enumerate
    ///portable devices connected to the computer.
    ///Params:
    ///    ppEnumDevice = Pointer to a pointer to an IWMDMEnumDevice interface used to enumerate devices. The caller must release this
    ///                   interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EnumDevices(IWMDMEnumDevice* ppEnumDevice);
}

///The <b>IWMDeviceManager2</b> interface extends IWMDeviceManager interface. It provides a way of enumerating devices
///that takes advantage of the Plug and Play (PnP) system that results in better performance and lower memory use. It
///also enables the application to query for a specific device based on the canonical name of the device.
@GUID("923E5249-8731-4C5B-9B1C-B8B60B6E46AF")
interface IWMDeviceManager2 : IWMDeviceManager
{
    ///The <b>GetDeviceFromCanonicalName</b> method retrieves an <b>IWMDMDevice</b> interface for a device with a
    ///specified canonical name. You can retrieve a device's canonical name by calling IWMDMDevice2::GetCanonicalName.
    ///Params:
    ///    pwszCanonicalName = A wide-character, <b>null</b>-terminated string specifying the canonical name of the device.
    ///    ppDevice = Pointer to a pointer to the IWMDMDevice interface of the device object with the specified canonical name. The
    ///               caller must release this interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszCanonicalName</i> or
    ///    <i>ppDeviceArray</i> parameter is an invalid or <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There is no connected device found with canonical name
    ///    <i>pwszCanonicalName</i>. </td> </tr> </table>
    ///    
    HRESULT GetDeviceFromCanonicalName(const(PWSTR) pwszCanonicalName, IWMDMDevice* ppDevice);
    ///The <b>EnumDevices2</b> method retrieves an enumeration interface that is used to enumerate portable devices
    ///connected to the computer. Microsoft strongly recommends that applications use the <b>EnumDevices2</b> method
    ///instead of IWMDeviceManager::EnumDevices.
    ///Params:
    ///    ppEnumDevice = Pointer to a pointer to an IWMDMEnumDevice interface. The caller is responsible for calling <b>Release</b> on
    ///                   the retrieved interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EnumDevices2(IWMDMEnumDevice* ppEnumDevice);
    ///The <b>Reinitialize</b> method forces Windows Media Device Manager to rediscover all the Windows Media Device
    ///Manager devices.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Reinitialize();
}

///The <b>IWMDeviceManager3</b> interface extends the IWMDeviceManager2 interface by providing a method that sets the
///device enumeration preferences.
@GUID("AF185C41-100D-46ED-BE2E-9CE8C44594EF")
interface IWMDeviceManager3 : IWMDeviceManager2
{
    ///The <b>SetDeviceEnumPreference</b> method sets the device enumeration preferences.
    ///Params:
    ///    dwEnumPref = Specifies a bitwise <b>OR</b> combination of one or more of the following bit values that specify enumeration
    ///                 preference. Each set bit enables the corresponding extended behavior, whereas the absence of that bit
    ///                 disables the extended behavior and specifies the default, backward-compatible enumeration behavior. The
    ///                 possible values for <i>fuPrefs</i> are provided in the following table. <table> <tr> <th>Value </th>
    ///                 <th>Description </th> </tr> <tr> <td>DO_NOT_VIRTUALIZE_STORAGES_AS_DEVICES</td> <td>By default, for devices
    ///                 containing multiple storage media (for example, multiple flash memory cards), each of these storages
    ///                 enumerates as a separate pseudo-device. However, when this flag is set, storages are not visible as devices,
    ///                 and only devices are visible as devices. See Remarks for more information.</td> </tr> <tr>
    ///                 <td>ALLOW_OUTOFBAND_NOTIFICATION</td> <td>When this flag is set, the service provider can send device arrival
    ///                 and removal by an additional mechanism, such as by using a window message, as well as the default mechanism
    ///                 of calling any application-implemented IWMDMNotification interfaces.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>fuPrefs</i> parameter specifies an
    ///    unsupported bit value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_CALL_OUT_OF_SEQUENCE</b></dt>
    ///    </dl> </td> <td width="60%"> The method was called after an enumeration operation; it must be called before
    ///    the enumeration operation. </td> </tr> </table>
    ///    
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

///The <b>IWMDMStorageGlobals</b> interface provides methods for retrieving global information about a storage
///<i>medium</i> (such as a flash ROM card) on a device. This can include the amount of free space, the total number of
///files, and so on. The values returned by this interface apply to the root storage of the current storage. Note that
///this is not necessarily equivalent to a device, since a device may have more than one storage (each flash card is
///considered a separate storage, for instance). This interface is acquired by calling
///<b>IWMDMStorage::GetStorageGlobals</b>.
@GUID("1DCB3A07-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMStorageGlobals : IUnknown
{
    ///The <b>GetCapabilities</b> method retrieves the capabilities of the root storage medium.
    ///Params:
    ///    pdwCapabilities = Pointer to a <b>DWORD</b> containing a bitwise <b>OR</b> of zero or more of the following values. <table>
    ///                      <tr> <th>Capability code </th> <th>Description </th> </tr> <tr> <td>WMDM_STORAGECAP_FOLDERSINROOT</td>
    ///                      <td>The medium supports folders in the root of storage.</td> </tr> <tr> <td>WMDM_STORAGECAP_FILESINROOT</td>
    ///                      <td>The medium supports files in the root of storage.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_FOLDERSINFOLDERS</td> <td>The medium supports nested folders.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_FILESINFOLDERS</td> <td>The medium supports files in folders.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_FOLDERLIMITEXISTS</td> <td>There is an arbitrary count limit for the number of folders
    ///                      allowed per the form of folder support by the medium.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_FILELIMITEXISTS</td> <td>There is an arbitrary count limit for the number of files
    ///                      allowed per the form of file support by the medium.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_NOT_INITIALIZABLE</td> <td>The medium can not be initialized. The top-level storage can
    ///                      be formatted by default.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetCapabilities(uint* pdwCapabilities);
    ///The <b>GetSerialNumber</b> method retrieves a serial number that uniquely identifies the storage medium.
    ///Params:
    ///    pSerialNum = Pointer to a WMDMID structure specifying the serial number information.
    ///    abMac = Array of bytes specifying the message authentication code for the parameter data of this method. This memory
    ///            is allocated and freed by the caller.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSerialNumber(__WMDMID* pSerialNum, ubyte* abMac);
    ///The <b>GetTotalSize</b> method retrieves the total size in bytes of the storage medium associated with the
    ///<b>IWMDMStorageGlobals</b> interface.
    ///Params:
    ///    pdwTotalSizeLow = Pointer to a <b>DWORD</b> that receives the low-order value of the total size of the medium.
    ///    pdwTotalSizeHigh = Pointer to a <b>DWORD</b> that receives the high-order value of the total size of the medium.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalSize(uint* pdwTotalSizeLow, uint* pdwTotalSizeHigh);
    ///The <b>GetTotalFree</b> method retrieves the total amount of free space on the storage medium, in bytes.
    ///Params:
    ///    pdwFreeLow = Pointer to a <b>DWORD</b> that receives the low-order part of the free space value.
    ///    pdwFreeHigh = Pointer to a <b>DWORD</b> that receives the high-order part of the free space value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalFree(uint* pdwFreeLow, uint* pdwFreeHigh);
    ///The <b>GetTotalBad</b> method retrieves the total amount of unusable space on the storage medium, in bytes.
    ///Params:
    ///    pdwBadLow = Pointer to a <b>DWORD</b> that receives the low-order bytes of unusable space.
    ///    pdwBadHigh = Pointer to a <b>DWORD</b> that receives the high-order bytes of unusable space.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalBad(uint* pdwBadLow, uint* pdwBadHigh);
    ///The <b>GetStatus</b> method retrieves the current status of a storage medium.
    ///Params:
    ///    pdwStatus = Pointer to a <b>DWORD</b> to receive the status information when the method returns. The following values can
    ///                be returned in the <i>pdwStatus</i> parameter. <table> <tr> <th>Status </th> <th>Description </th> </tr> <tr>
    ///                <td>WMDM_STATUS_READY</td> <td>The medium is in an idle or ready state.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_BUSY</td> <td>An operation is ongoing. Evaluate status values to determine the ongoing
    ///                operation.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_NOTPRESENT</td> <td>The storage medium is not present. For
    ///                devices with more than one medium supported, this value is only reported from the <b>IWMDMStorageGlobals</b>
    ///                interface.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_INITIALIZING</td> <td>The device is currently busy
    ///                formatting a storage medium on a device.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_BROKEN</td> <td>The storage
    ///                medium is broken. For devices with more than one medium supported, this value is only reported from the
    ///                <b>IWMDMStorageGlobals</b> interface.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_NOTSUPPORTED</td> <td>The
    ///                storage medium is not supported by the device. For devices with more than one medium supported, this value is
    ///                only returned from the <b>IWMDMStorageGlobals</b> interface.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_STORAGE_UNFORMATTED</td> <td>The storage medium is not formatted. For devices with more than
    ///                one medium supported, this value is only reported from the <b>IWMDMStorageGlobals</b> interface.</td> </tr>
    ///                </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStatus(uint* pdwStatus);
    ///The <b>Initialize</b> method formats the storage medium.
    ///Params:
    ///    fuMode = Mode used to initialize the medium. Specify exactly one of the following two modes. If both modes are
    ///             specified, block mode is used. <table> <tr> <th>Mode </th> <th>Description </th> </tr> <tr>
    ///             <td>WMDM_MODE_BLOCK</td> <td>The operation is performed using block mode processing. The call will not return
    ///             until the operation is finished.</td> </tr> <tr> <td>WMDM_MODE_THREAD</td> <td>The operation is performed
    ///             using thread mode processing. The call returns immediately, and the operation is performed in a background
    ///             thread.</td> </tr> </table>
    ///    pProgress = Pointer to an <b>IWMDMProgress</b> interface implemented by an application to track the progress of the
    ///                formatting operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Initialize(uint fuMode, IWMDMProgress pProgress);
}

///An instance of the <b>IWMDMStorage</b> interface provides methods to examine and explore a storage (a generic name
///for a data or collection object, such as a file, folder, or playlist) on a <i>device</i>. Note that storages cannot
///be used to refer to objects on the computer, only on the device. <b>IWMDMStorage</b> can contain nested objects, and
///can represent the root object (the entire storage medium) or any child object, such as a folder or file, on that
///medium. The <b>IWMDMStorage2</b> interface extends this interface by making it possible to get a storage pointer from
///a storage name and to get and set extended attributes. <b>IWMDMStorage3</b> extends this interface by supporting
///metadata. To obtain a root storage object which can be queried for all other objects on a device, you must call
///IWMDMDevice::EnumStorage, as described in Exploring a Device.
@GUID("1DCB3A06-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMStorage : IUnknown
{
    ///The <b>SetAttributes</b> method sets the attributes of the storage.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> specifying the attributes to be set. The following table lists the attributes that can be set by
    ///                   this parameter. <table> <tr> <th>Attribute </th> <th>Description </th> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_AUDIO</td> <td>This file contains audio data.</td> </tr> <tr> <td>WMDM_FILE_ATTR_DATA</td>
    ///                   <td>This file contains non-audio data.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANPLAY</td> <td>This audio file
    ///                   can be played by the device.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANDELETE</td> <td>This file can be
    ///                   deleted.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANMOVE</td> <td>This file or folder can be moved around on the
    ///                   storage medium.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANRENAME</td> <td>This file or folder can be
    ///                   renamed.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANREAD</td> <td>This file can be read by the host computer.</td>
    ///                   </tr> <tr> <td>WMDM_FILE_ATTR_MUSIC</td> <td>This audio file contains music.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_AUDIOBOOK</td> <td>This is an audio book file.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_HIDDEN</td> <td>This file is hidden on the file system</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_SYSTEM</td> <td>This is a system file</td> </tr> <tr> <td>WMDM_FILE_ATTR_READONLY</td>
    ///                   <td>This is a read-only file.</td> </tr> </table>
    ///    pFormat = Optional pointer to a _WAVEFORMATEX structure that specifies audio information about the object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetAttributes(uint dwAttributes, _tWAVEFORMATEX* pFormat);
    ///The <b>GetStorageGlobals</b> method retrieves the <b>IWMDMStorageGlobals</b> interface of the root storage of
    ///this storage.
    ///Params:
    ///    ppStorageGlobals = Pointer to an IWMDMStorageGlobals interface, which provides information about the device such as serial
    ///                       number, capabilities, and so on. The caller must release this interface when finished with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStorageGlobals(IWMDMStorageGlobals* ppStorageGlobals);
    ///The <b>GetAttributes</b> method retrieves the attributes of the storage.
    ///Params:
    ///    pdwAttributes = Pointer to a <b>DWORD</b> specifying one or more of the following attributes, combined with a bitwise
    ///                    <b>OR</b>. <table> <tr> <th>Attribute </th> <th>Description </th> </tr> <tr>
    ///                    <td>WMDM_STORAGE_ATTR_FILESYSTEM</td> <td>This object is the top-level storage medium, for example, a storage
    ///                    card or some other type of on-board storage.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_REMOVABLE</td> <td>The
    ///                    global storage medium is removable.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_NONREMOVABLE</td> <td>The global
    ///                    storage medium is not removable.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_FOLDERS</td> <td>The global storage
    ///                    medium supports folders and file hierarchy.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_HAS_FILES</td> <td>This
    ///                    storage object contains at least one file as an immediate child.</td> </tr> <tr>
    ///                    <td>WMDM_STORAGE_ATTR_HAS_FOLDERS</td> <td>This storage object contains at least one folder as an immediate
    ///                    child.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_CANEDITMETADATA</td> <td>This storage can edit metadata.</td>
    ///                    </tr> <tr> <td>WMDM_FILE_ATTR_FILE</td> <td>This is a file on the storage medium.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_FOLDER</td> <td>This is a folder on the storage medium.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_LINK</td> <td>This is a link that creates an association between multiple files.</td>
    ///                    </tr> <tr> <td>WMDM_FILE_ATTR_AUDIO</td> <td>This file contains audio data.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_DATA</td> <td>This file contains non-audio data.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_CANPLAY</td> <td>This audio file can be played by the device.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_CANDELETE</td> <td>This file can be deleted.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_CANMOVE</td> <td>This file or folder can be moved around on the storage medium.</td> </tr>
    ///                    <tr> <td>WMDM_FILE_ATTR_CANRENAME</td> <td>This file or folder can be renamed.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_CANREAD</td> <td>This file can be read by the host computer.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_MUSIC</td> <td>This audio file contains music.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_AUDIOBOOK</td> <td>This is an audio book file.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_VIDEO</td> <td>This file contains video data.</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_HIDDEN</td> <td>This file is hidden on the file system</td> </tr> <tr>
    ///                    <td>WMDM_FILE_ATTR_SYSTEM</td> <td>This is a system file</td> </tr> <tr> <td>WMDM_FILE_ATTR_READONLY</td>
    ///                    <td>This is a read-only file.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_VIRTUAL</td> <td>This storage is virtual
    ///                    and does not correspond to an actual storage on the file system of the device. (Folders created based on
    ///                    metadata are one example of virtual storage.)</td> </tr> <tr> <td>WMDM_STORAGE_IS_DEFAULT</td> <td>This
    ///                    storage is the default location for putting new digital media on the device.</td> </tr> <tr>
    ///                    <td>WMDM_STORAGE_CONTAINS_DEFAULT</td> <td>This storage contains the default storage where new digital media
    ///                    should be placed.</td> </tr> </table>
    ///    pFormat = Optional pointer to a _WAVEFORMATEX structure that specifies the object's audio attributes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetAttributes(uint* pdwAttributes, _tWAVEFORMATEX* pFormat);
    ///The <b>GetName</b> method retrieves the display name of the storage.
    ///Params:
    ///    pwszName = Pointer to a wide-character null-terminated string specifying the storage name. This is the display name of
    ///               the object is the file name without path information. The caller allocates and releases this buffer.
    ///    nMaxChars = Integer specifying the maximum number of characters that can be copied to the name string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    ///The <b>GetDate</b> method retrieves the date when the storage was last modified.
    ///Params:
    ///    pDateTimeUTC = Pointer to a <b>WMDMDATETIME</b> structure specifying the date on which the storage object (file or folder)
    ///                   was last modified.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetDate(WMDMDATETIME* pDateTimeUTC);
    ///The <b>GetSize</b> method retrieves the size of the storage, in bytes.
    ///Params:
    ///    pdwSizeLow = Pointer to a <b>DWORD</b> specifying the low-order part of the storage object size, in bytes.
    ///    pdwSizeHigh = Pointer to a <b>DWORD</b> specifying the high-order part of the storage object size, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSize(uint* pdwSizeLow, uint* pdwSizeHigh);
    ///The <b>GetRights</b> method retrieves rights information for a licensed storage.
    ///Params:
    ///    ppRights = Pointer to an array of WMDMRIGHTS structures that contain the storage rights. This parameter is included in
    ///               the message authentication code. Windows Media Device Manager allocates this memory, and the application must
    ///               release it with <b>CoTaskMemFree</b>.
    ///    pnRightsCount = Pointer to the number of <b>WMDMRIGHTS</b> structures in the <i>ppRights</i> array. This parameter is
    ///                    included in the message authentication code.
    ///    abMac = Array of bytes containing the message authentication code (MAC) for the parameter data of this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetRights(__WMDMRIGHTS** ppRights, uint* pnRightsCount, ubyte* abMac);
    ///The <b>EnumStorage</b> method retrieves an <b>IWMDMEnumStorage</b> interface to enumerate the immediate child
    ///storages of the current storage.
    ///Params:
    ///    pEnumStorage = Pointer to an IWMDMEnumStorage interface. The caller must release this interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EnumStorage(IWMDMEnumStorage* pEnumStorage);
    ///The <b>SendOpaqueCommand</b> method sends a command to the storage through Windows Media Device Manager, without
    ///processing it.
    ///Params:
    ///    pCommand = Pointer to an OPAQUECOMMAND structure containing the command to execute. Data can be passed two ways—from
    ///               the application to the device, and from the device back to the application when the call finishes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

///The <b>IWMDMStorage2</b> interface extends <b>IWMDMStorage</b> by making it possible to get a child storage by name,
///and to get and set extended attributes. <b>IWMDMStorage3</b> interface extends this interface by supporting metadata.
@GUID("1ED5A144-5CD5-4683-9EFF-72CBDB2D9533")
interface IWMDMStorage2 : IWMDMStorage
{
    ///The <b>GetStorage</b> method retrieves a child storage by name directly from the current storage without having
    ///to enumerate through all the children.
    ///Params:
    ///    pszStorageName = Pointer to a <b>null</b>-terminated string specifying the storage name. This is the name retrieved by
    ///                     IWMDMStorage::GetName.
    ///    ppStorage = Pointer to the retrieved storage object, or <b>NULL</b> if no storage was found. The caller must release this
    ///                interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStorage(const(PWSTR) pszStorageName, IWMDMStorage* ppStorage);
    ///The <b>SetAttributes2</b> method sets extended attributes of the storage.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> specifying the base attributes defined in the IWMDMStorage::SetAttributes method.
    ///    dwAttributesEx = <b>DWORD</b> specifying extended attributes. Currently, no extended attributes are defined.
    ///    pFormat = Optional pointer to a _ WAVEFORMATEX structure that specifies audio information about the object. This
    ///              parameter is ignored if the file is not audio.
    ///    pVideoFormat = Optional pointer to a _VIDEOINFOHEADER structure that specifies video information about the object. This
    ///                   parameter is ignored if the file is not video.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
    ///The <b>GetAttributes2</b> method retrieves extended attributes of the storage.
    ///Params:
    ///    pdwAttributes = Pointer to a <b>DWORD</b> specifying one or more attributes defined in the IWMDMStorage::GetAttributes
    ///                    method, combined with a bitwise <b>OR</b>.
    ///    pdwAttributesEx = Pointer to a <b>DWORD</b> specifying the extended attributes. Currently, no extended attributes are defined.
    ///    pAudioFormat = Optional pointer to a _ WAVEFORMATEX structure that specifies audio information about the object. This
    ///                   parameter is ignored if the file is not audio.
    ///    pVideoFormat = Optional pointer to a _ VIDEOINFOHEADER structure that specifies video information about the object. This
    ///                   parameter is ignored if the file is not video.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
}

///The <b>IWMDMStorage3</b> interface extends IWMDMStorage2 by exposing metadata.
@GUID("97717EEA-926A-464E-96A4-247B0216026E")
interface IWMDMStorage3 : IWMDMStorage2
{
    ///The <b>GetMetadata</b> method retrieves the metadata associated with the storage.
    ///Params:
    ///    ppMetadata = Pointer to an IWMDMMetaData pointer associated with a storage. The caller is responsible for calling
    ///                 <b>Release</b> on this interface and all the allocated values when finished with it, as described under
    ///                 "Clearing allocated memory" in Discovering Device Format Capabilities.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetMetadata(IWMDMMetaData* ppMetadata);
    ///The <b>SetMetadata</b> method sets metadata on the storage.
    ///Params:
    ///    pMetadata = An IWMDMMetaData pointer containing metadata to set on the object. To create this interface, call
    ///                CreateEmptyMetadataObject.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
    ///The <b>CreateEmptyMetadataObject</b> method creates a new <b>IWMDMMetaData</b> interface. This interface is used
    ///to set or retrieve metadata properties of a storage.
    ///Params:
    ///    ppMetadata = Receives the new IWMDMMetaData interface. The caller must release this interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT CreateEmptyMetadataObject(IWMDMMetaData* ppMetadata);
    ///The <b>SetEnumPreference</b> method sets the preferred view mode for the storage.
    ///Params:
    ///    pMode = Desired mode of the storage enumerator. For more details on the mode, see WMDM_STORAGE_ENUM_MODE. If the
    ///            value of <i>pMode</i> is set to ENUM_MODE_USE_DEVICE_PREF, then upon return it is set to ENUM_MODE_RAW or
    ///            ENUM_MODE_METADATA_VIEWS, based on the device preference.
    ///    nViews = Number of view definitions provided. This parameter is ignored if the value of <i>pMode</i> is ENUM_MODE_RAW
    ///             or if the value of <i>pMode</i> is ENUM_MODE_USE_DEVICE_PREF and the device does not prefer metadata views.
    ///             If the value of <i>pMode</i> is ENUM_MODE_METADATA_VIEWS or if the value of <i>pMode</i> is
    ///             ENUM_MODE_USE_DEVICE_PREF and the device prefers metadata views, this parameter can still be 0. In this case,
    ///             Windows Media Device Manager uses its default metadata views. If the value of <i>nViews</i> is 0,
    ///             <i>ppViews</i> must be <b>NULL</b>. If the value of <i>nViews</i> is not 0, <i>ppViews</i> must point to an
    ///             array of WMDMMetadataView structures with <i>nViews</i> elements.
    ///    pViews = Array of view definitions. The length of the array must be equal to <i>nViews</i>. This parameter is ignored
    ///             if the value of <i>pMode</i> is ENUM_MODE_RAW or if the value of <i>pMode</i> is ENUM_MODE_USE_DEVICE_PREF
    ///             and the device does not prefer metadata views. If the value of <i>pMode</i> is ENUM_MODE_METADATA_VIEWS or if
    ///             the value of <i>pMode</i> is ENUM_MODE_USE_DEVICE_PREF and the device prefers metadata views, this parameter
    ///             can still be <b>NULL</b>. In this case Windows Media Device Manager uses its default metadata views. The
    ///             value of this parameter must be <b>NULL</b> if the value of <i>nViews</i> is 0. If the value of <i>nViews</i>
    ///             is not 0, <i>ppViews</i> must point to an array of WMDMMetadataView structures with <i>nViews</i> elements.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. The following table lists all possible values. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> There is not enough memory to allocate the item. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NOT_CERTIFIED</b></dt> </dl> </td> <td width="60%"> The caller
    ///    does not have the rights to execute this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The object does not support this method.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> </table>
    ///    
    HRESULT SetEnumPreference(WMDM_STORAGE_ENUM_MODE* pMode, uint nViews, __WMDMMetadataView* pViews);
}

///The <b>IWMDMStorage4</b> interface extends <b>IWMDMStorage3</b> by providing methods for retrieving a subset of
///available metadata for a storage, and for setting and retrieving a list of references to other storages.
@GUID("C225BAC5-A03A-40B8-9A23-91CF478C64A6")
interface IWMDMStorage4 : IWMDMStorage3
{
    ///The <b>SetReferences</b> method sets the references contained in a storage that has references (such as a
    ///playlist or album), overwriting any previously existing references held by the storage.
    ///Params:
    ///    dwRefs = Count of IWMDMStorage interface pointers in <i>ppIWMDMStorage</i>. Zero is an acceptable value and clears all
    ///             references from the storage. The storage itself is not deleted in this case.
    ///    ppIWMDMStorage = Pointer to an array of <b>IWMDMStorage</b> interface pointers to be referenced by the storage. This order is
    ///                     preserved by the storage. <b>NULL</b> is an acceptable value if <i>dwRefs</i> is also zero. The caller is
    ///                     responsible for allocating and releasing this array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetReferences(uint dwRefs, IWMDMStorage* ppIWMDMStorage);
    ///The <b>GetReferences</b> method retrieves an array of pointers to <b>IWMDMStorage</b> objects pointed to by this
    ///storage. An abstract album or playlist is typically stored as a collection of references on an MTP device.
    ///Params:
    ///    pdwRefs = Pointer to the count of values retrieved by <i>pppIWMDMStorage</i>. If the object has no references, this
    ///              will return zero, and the function will return S_OK.
    ///    pppIWMDMStorage = Pointer to a pointer to the array of IWMDMStorage interface pointers that represent references in a storage.
    ///                      Such references can, for example, represent items in a playlist or album. The retrieved array is in the same
    ///                      order as they appear in the object itself. Memory for this array is allocated by Windows Media Device
    ///                      Manager. When the calling application has finished accessing this array, it must first call <b>Release</b> on
    ///                      all of the interface pointers, and then free the array memory using <b>CoTaskMemFree</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetReferences(uint* pdwRefs, IWMDMStorage** pppIWMDMStorage);
    ///The <b>GetRightsWithProgress</b> method retrieves the rights information for the storage object, providing a
    ///callback mechanism for monitoring progress.
    ///Params:
    ///    pIProgressCallback = Optional pointer to an IWMDMProgress3 interface to be used by Windows Media Device Manager to report progress
    ///                         back to the application.
    ///    ppRights = Pointer to an array of WMDMRIGHTS structures that contain the storage object rights information. Memory for
    ///               this array is allocated by Windows Media Device Manager. When the calling application has finished accessing
    ///               this array, the memory must be freed by using <b>CoTaskMemFree</b>.
    ///    pnRightsCount = Pointer to the number of <b>WMDMRIGHTS</b> structures in the <i>ppRights</i> array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetRightsWithProgress(IWMDMProgress3 pIProgressCallback, __WMDMRIGHTS** ppRights, uint* pnRightsCount);
    ///The <b>GetSpecifiedMetadata</b> method retrieves one or more specific metadata properties from the storage.
    ///Params:
    ///    cProperties = Count of properties to retrieve.
    ///    ppwszPropNames = Array of property names to retrieve. The length of this array should be equal to <i>cProperties</i>. The
    ///                     application should free this memory using <b>CoTaskMemFree</b>.
    ///    ppMetadata = Pointer to the returned IWMDMMetaData interface pointer, containing the retrieved values. The caller must
    ///                 release this interface when finished with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSpecifiedMetadata(uint cProperties, PWSTR* ppwszPropNames, IWMDMMetaData* ppMetadata);
    ///The <b>FindStorage</b> method retrieves a storage in the current root storage, based on its persistent unique
    ///identifier.
    ///Params:
    ///    findScope = A WMDM_FIND_SCOPE enumeration specifying the scope to search.
    ///    pwszUniqueID = Persistent unique identifier of the storage to be found. The persistent unique identifier of the storage is
    ///                   described by the <b>g_wszWMDMPersistentUniqueID</b> metadata property of the storage.
    ///    ppStorage = Pointer to the retrieved storage, if found. The caller must release this interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IWMDMStorage* ppStorage);
    ///The <b>GetParent</b> method retrieves the parent of the storage.
    ///Params:
    ///    ppStorage = Pointer to the IWMDMStorage interface of the parent storage. The caller must release this interface when
    ///                finished with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetParent(IWMDMStorage* ppStorage);
}

///This optional, application-implemented <b>IWMDMOperation</b> interface allows the application to control how data is
///read from or written to the computer during a file transfer.
@GUID("1DCB3A0B-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMOperation : IUnknown
{
    ///The <b>BeginRead</b> method indicates that a "read from device" action is beginning. Windows Media Device Manager
    ///only calls this method if the application calls IWMDMStorageControl::Read and passes in this
    ///<b>IWMDMOperation</b> interface.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT BeginRead();
    ///The <b>BeginWrite</b> method indicates that a "write to device" action is beginning. Windows Media Device Manager
    ///only calls this method if the application calls <b>IWMDMStorageControl/2/3::Insert/2/3</b> and passes in this
    ///interface.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT BeginWrite();
    ///Windows Media Device Manager calls <b>GetObjectName</b> before an object is written to the device in order to
    ///know what it should be named on the device.
    ///Params:
    ///    pwszName = Pointer to a wide-character null-terminated string that specifies the object name. The name should include a
    ///               file extension, if required. Windows Media Device Manager allocates and releases this buffer.
    ///               <i>nMaxChars</i> specifies the maximum number of characters, including the terminating null character.
    ///    nMaxChars = Integer specifying the number of characters in <i>pwszName</i>, including the terminating null character.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT GetObjectName(PWSTR pwszName, uint nMaxChars);
    ///The <b>SetObjectName</b> method assigns a name to the content being read or written. This method is currently not
    ///called by Windows Media Device Manager.
    ///Params:
    ///    pwszName = Pointer to a wide-character null-terminated string specifying the object name.
    ///    nMaxChars = Integer specifying the maximum number of characters that this string can hold.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT SetObjectName(PWSTR pwszName, uint nMaxChars);
    ///The <b>GetObjectAttributes</b> method allows the application to specify attributes for an object being written to
    ///a device. Windows Media Device Manager calls this method before a file is written to the device in order to learn
    ///the file's attributes.
    ///Params:
    ///    pdwAttributes = Pointer to a <b>DWORD</b> that specifies the attributes defined in the IWMDMStorage::GetAttributes method.
    ///    pFormat = Pointer to a _WAVEFORMATEX structure that specifies the audio format for files with audio data attributes.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT GetObjectAttributes(uint* pdwAttributes, _tWAVEFORMATEX* pFormat);
    ///The <b>SetObjectAttributes</b> method specifies the file attributes. This method is currently not called by
    ///Windows Media Device Manager.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> specifying the object attributes as defined in the IWMDMStorage::SetAttributes method.
    ///    pFormat = Pointer to a _WAVEFORMATEX structure specifying the format for files with audio data attributes. If the file
    ///              contains audio data, this parameter should be filled.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT SetObjectAttributes(uint dwAttributes, _tWAVEFORMATEX* pFormat);
    ///Windows Media Device Manager calls <b>GetObjectTotalSize</b> before a file is written to the device in order to
    ///retrieve the total size of the object, in bytes.
    ///Params:
    ///    pdwSize = Pointer to a <b>DWORD</b> that, on return, specifies the low-order bits of the object size in bytes.
    ///    pdwSizeHigh = Pointer to a <b>DWORD</b> that, on return, specifies the high-order bits of the object size in bytes.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT GetObjectTotalSize(uint* pdwSize, uint* pdwSizeHigh);
    ///The <b>SetObjectTotalSize</b> method assigns the total size in bytes of an object. This method is currently not
    ///called by Windows Media Device Manager.
    ///Params:
    ///    dwSize = <b>DWORD</b> specifying the low-order bits of the object size, in bytes.
    ///    dwSizeHigh = <b>DWORD</b> specifying the high-order bits of the object size, in bytes.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT SetObjectTotalSize(uint dwSize, uint dwSizeHigh);
    ///The <b>TransferObjectData</b> method is called to allow the application to transfer a block of data to or from
    ///the computer.
    ///Params:
    ///    pData = Pointer to a buffer containing the data. This buffer is always allocated and freed by Windows Media Device
    ///            Manager. Your application should never allocate or free this buffer. <b>BeginRead</b>[in] During a read from
    ///            device, incoming data that must be decrypted using the CSecureChannelClient::DecryptParam method. The
    ///            application does not need to deallocate the buffer. <b>BeginWrite</b>[in, out] During a write to device, on
    ///            input is a memory buffer <i>pdwSize</i> bytes long, allocated by Windows Media Device Manager. The
    ///            application should fill this buffer with data that has been encrypted using the
    ///            CSecureChannelClient::EncryptParam method.
    ///    pdwSize = Pointer to a <b>DWORD</b> that specifies the transfer buffer size. <b>BeginRead</b>[in, out] On input, the
    ///              size of the incoming data in <i>pData</i>. On output, the amount of data the application has actually
    ///              actually read. <b>BeginWriteOn</b> input, the size of the <i>pData</i> buffer. On output, the actual size of
    ///              the data sent out.
    ///    abMac = Array of bytes specifying the message authentication code for the parameter data of this method.
    ///            <b>BeginRead</b>[in] A MAC generated from <i>pData</i> and <i>pdwSize</i> that the application should check
    ///            after <i>pData</i> is decrypted, to verify that the data has not been modified. <b>BeginWrite</b>[out] A MAC
    ///            generated from <i>pData</i> and <i>pdwSize</i> before <i>pData</i> is encrypted.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT TransferObjectData(ubyte* pData, uint* pdwSize, ubyte* abMac);
    ///The <b>End</b> method indicates that a read or write operation is finished, whether successful or not, and it
    ///returns a completion code.
    ///Params:
    ///    phCompletionCode = Completion code for the operation.
    ///    pNewObject = When sending to a device, a pointer to a new <b>IWMDMStorage</b> object representing the new object that has
    ///                 been sent to the device. When reading from a device, a pointer to the <b>IWMDMStorage</b> object that was
    ///                 read from the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT End(HRESULT* phCompletionCode, IUnknown pNewObject);
}

///The optional, application-implemented <b>IWMDMOperation2</b> interface extends IWMDMOperation by providing methods to
///get and set extended attributes.
@GUID("33445B48-7DF7-425C-AD8F-0FC6D82F9F75")
interface IWMDMOperation2 : IWMDMOperation
{
    ///The <b>SetObjectAttributes2</b> method sets attributes of files or storages. This method is currently not called
    ///by Windows Media Device Manager.
    ///Params:
    ///    dwAttributes = Pointer to a <b>DWORD</b> specifying the attributes as defined by the IWMDMStorage::SetAttributes method.
    ///    dwAttributesEx = <b>DWORD</b> specifying the extended attributes. No extended attributes are currently defined.
    ///    pFormat = Optional pointer to a _WAVEFORMATEX structure that specifies audio information about the object.
    ///    pVideoFormat = Optional pointer to a _VIDEOINFOHEADER structure that specifies video information about the object.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT SetObjectAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pFormat, 
                                 _tagVIDEOINFOHEADER* pVideoFormat);
    ///Windows Media Device Manager calls <b>GetObjectAttributes</b> when a file is written to the device in order to
    ///learn the attributes of the file.
    ///Params:
    ///    pdwAttributes = Pointer to a <b>DWORD</b> specifying the storage attributes defined in the IWMDMStorage::GetAttributes
    ///                    method.
    ///    pdwAttributesEx = Pointer to a <b>DWORD</b> specifying extended attributes. There are currently no extended attributes defined.
    ///    pAudioFormat = Optional pointer to a _WAVEFORMATEX structure that specifies audio file attributes.
    ///    pVideoFormat = Optional pointer to a _VIDEOINFOHEADER structure that specifies video object attributes.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT GetObjectAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                                 _tagVIDEOINFOHEADER* pVideoFormat);
}

///The optional, application-implemented <b>IWMDMOperation3</b> interface extends <b>IWMDMOperation</b> by providing a
///new method for transferring data unencrypted for added efficiency.
@GUID("D1F9B46A-9CA8-46D8-9D0F-1EC9BAE54919")
interface IWMDMOperation3 : IWMDMOperation
{
    ///The <b>TransferObjectDataOnClearChannel</b> method is a more efficient implementation of
    ///IWMDMOperation::TransferObjectData.
    ///Params:
    ///    pData = Pointer to an unencrypted byte buffer.
    ///    pdwSize = Pointer to a variable specifying the buffer size.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    read operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt>
    ///    </dl> </td> <td width="60%"> The read operation should be cancelled without finishing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred, and the
    ///    read operation should be cancelled without finishing. </td> </tr> </table>
    ///    
    HRESULT TransferObjectDataOnClearChannel(ubyte* pData, uint* pdwSize);
}

///The optional, application-implemented <b>IWMDMProgress</b> allows an application to track the progress of operations,
///such as formatting media or file transfers. This interface is submitted to, and called by, the IWMDMStorageGlobals
///and IWMDMStorageControl interfaces. These methods do not provide a way for the application to know which operation is
///being tracked. However, the <b>IWMDMProgress3</b> methods do provide a means to identify the operation; if possible,
///you should implement that interface instead.
@GUID("1DCB3A0C-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMProgress : IUnknown
{
    ///The <b>Begin</b> method indicates that an operation is beginning. An estimate of the duration of the operation is
    ///provided when possible.
    ///Params:
    ///    dwEstimatedTicks = <b>DWORD</b> specifying the estimated number of ticks that are needed for the operation to complete.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt> </dl>
    ///    </td> <td width="60%"> Windows Media Device Manager should cancel the current operation without waiting for
    ///    it to finish. If the application is using block mode, then Windows Media Device Manager will return this
    ///    error to the application. </td> </tr> </table>
    ///    
    HRESULT Begin(uint dwEstimatedTicks);
    ///The <b>Progress</b> method indicates that an operation is still in progress.
    ///Params:
    ///    dwTranspiredTicks = <b>DWORD</b> specifying the number of ticks that have transpired so far.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt> </dl>
    ///    </td> <td width="60%"> Windows Media Device Manager should cancel the current operation without waiting for
    ///    it to finish. If the application is using block mode, then Windows Media Device Manager will return this
    ///    error to the application. </td> </tr> </table>
    ///    
    HRESULT Progress(uint dwTranspiredTicks);
    ///The <b>End</b> method indicates that an operation is finished.
    ///Returns:
    ///    The return value from the method is ignored by Windows Media Device Manager.
    ///    
    HRESULT End();
}

///The optional, application-implemented <b>IWMDMProgress2</b> interface extends the IWMDMProgress::End method by
///providing a status indicator.
@GUID("3A43F550-B383-4E92-B04A-E6BBC660FEFC")
interface IWMDMProgress2 : IWMDMProgress
{
    ///The <b>End2</b> method extends IWMDMProgress::End by providing a completion status indicator.
    ///Params:
    ///    hrCompletionCode = The return value of the operation that ended.
    ///Returns:
    ///    The return value from the method is ignored by Windows Media Device Manager.
    ///    
    HRESULT End2(HRESULT hrCompletionCode);
}

///The optional, application-implemented <b>IWMDMProgress3</b> interface extends <b>IWMDMProgress2</b> by providing
///additional input parameters to specify which event is being monitored, and to allow for context-specific information.
///Applications that implement this callback interface should provide an implementation for methods corresponding to
///<b>IWMDMProgress</b> and <b>IWMDMProgress2</b> for backward compatibility, in addition to the new methods.
@GUID("21DE01CB-3BB4-4929-B21A-17AF3F80F658")
interface IWMDMProgress3 : IWMDMProgress2
{
    ///The <b>Begin3</b> method is called by Windows Media Device Manager to indicate that an operation is about to
    ///begin. An estimate of the duration of the operation is provided when possible. This method extends
    ///IWMDMProgress::Begin by providing additional input parameters for the identification (ID) of the event and for a
    ///pointer to the optional context of the commands. The operation is identified by an event ID. The method allows
    ///the caller to pass an opaque data structure to the application.
    ///Params:
    ///    EventId = A <b>GUID</b> identifying the operation that will begin. Possible values are shown in the following table.
    ///              <table> <tr> <th>Event </th> <th>Description </th> </tr> <tr> <td>SCP_EVENTID_ACQSECURECLOCK</td> <td>Windows
    ///              Media Device Manager is acquiring a secure clock from server.</td> </tr> <tr>
    ///              <td>SCP_EVENTID_NEEDTOINDIV</td> <td>The device is being individualized. This is not currently used.</td>
    ///              </tr> <tr> <td>SCP_EVENTID_DRMINFO</td> <td> This event ID is used to notify the application with the version
    ///              DRM header found in the content for each file. The OPAQUECOMMAND structure returned has the
    ///              <b>guidCommand</b> member set to SCP_PARAMID_DRMVERSION. In addition, the OPAQUECOMMAND specifies one of the
    ///              following flags: WMDM_SCP_DRMINFO_NOT_DRMPROTECTED WMDM_SCP_DRMINFO_V1HEADER WMDM_SCP_DRMINFO_V2HEADER </td>
    ///              </tr> <tr> <td>EVENT_WMDM_CONTENT_TRANSFER</td> <td>Content is being transferred to or from the device.</td>
    ///              </tr> </table>
    ///    dwEstimatedTicks = <b>DWORD</b> specifying the estimated number of ticks that are needed for the operation to complete. The
    ///                       number of ticks passed in <i>dwEstimatedTicks</i> is an estimate of how many ticks are needed for the
    ///                       operation to complete. During the course of the operation, the <b>Progress3</b> method is called to indicate
    ///                       how many ticks have transpired. Applications can use the estimate to configure display mechanisms that show
    ///                       progress.
    ///    pContext = Pointer to an OPAQUECOMMAND structure containing a command sent to the device without being handled by
    ///               Windows Media Device Manager. This parameter is optional and can be <b>NULL</b>.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt> </dl>
    ///    </td> <td width="60%"> Windows Media Device Manager should cancel the current operation without waiting for
    ///    it to finish. If the application is using block mode, then Windows Media Device Manager will return this
    ///    error to the application. </td> </tr> </table>
    ///    
    HRESULT Begin3(GUID EventId, uint dwEstimatedTicks, __OPAQUECOMMAND* pContext);
    ///The <b>Progress3</b> method is called by Windows Media Device Manager to indicate the status of an action in
    ///progress. This method extends IWMDMProgress::Progress by providing additional input parameters for the
    ///identification (ID) of the event and for a pointer to the context of the commands.
    ///Params:
    ///    EventId = <b>GUID</b> specifying the event ID for which progress notifications are being sent. Possible values are
    ///              shown in the following table. <table> <tr> <th>Event </th> <th>Description </th> </tr> <tr>
    ///              <td>SCP_EVENTID_ACQSECURECLOCK</td> <td>Windows Media Device Manager is acquiring a secure clock from
    ///              server.</td> </tr> <tr> <td>SCP_EVENTID_NEEDTOINDIV</td> <td>The device is being individualized. This is not
    ///              currently used.</td> </tr> <tr> <td>SCP_EVENTID_DRMINFO</td> <td> This event ID is used to notify the
    ///              application with the version DRM header found in the content for each file. The OPAQUECOMMAND structure
    ///              returned has the <i>guidCommand</i> parameter set to SCP_PARAMID_DRMVERSION. In addition, the data specifies
    ///              one of the following flags: WMDM_SCP_DRMINFO_NOT_DRMPROTECTED WMDM_SCP_DRMINFO_V1HEADER
    ///              WMDM_SCP_DRMINFO_V2HEADER </td> </tr> <tr> <td>EVENT_WMDM_CONTENT_TRANSFER</td> <td>Content is being
    ///              transferred to or from the device.</td> </tr> </table>
    ///    dwTranspiredTicks = <b>DWORD</b> specifying the number of ticks that have transpired so far.
    ///    pContext = Pointer to an OPAQUECOMMAND structure containing a command sent directly to the device without being handled
    ///               by Windows Media Device Manager. This parameter is optional and can be <b>NULL</b>. If the event is
    ///               SCP_EVENTID_DRMINFO, the data in this parameter will have the SCP_PARAMID_DRMVERSION GUID.
    ///Returns:
    ///    The application should return one of the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation should continue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_USER_CANCELLED</b></dt> </dl>
    ///    </td> <td width="60%"> Windows Media Device Manager should cancel the current operation without waiting for
    ///    it to finish. If the application is using block mode, then Windows Media Device Manager will return this
    ///    error to the application. </td> </tr> </table>
    ///    
    HRESULT Progress3(GUID EventId, uint dwTranspiredTicks, __OPAQUECOMMAND* pContext);
    ///The <b>End3</b> method is called by Windows Media Device Manager to indicate that an operation has finished. This
    ///method extends IWMDMProgress2::End2 by providing additional input parameters for the identification (ID) of the
    ///event and for a pointer to the context of the commands.
    ///Params:
    ///    EventId = A <b>GUID</b> specifying the event that is ending. Possible values are shown in the following table. <table>
    ///              <tr> <th>Event </th> <th>Description </th> </tr> <tr> <td>SCP_EVENTID_ACQSECURECLOCK</td> <td>Windows Media
    ///              Device Manager is acquiring a secure clock from server.</td> </tr> <tr> <td>SCP_EVENTID_NEEDTOINDIV</td>
    ///              <td>The device is being individualized. This is not currently used.</td> </tr> <tr>
    ///              <td>SCP_EVENTID_DRMINFO</td> <td> This event ID is used to notify the application with the version DRM header
    ///              found in the content for each file. The OPAQUECOMMAND structure returned has the <b>guidCommand</b> member
    ///              set to SCP_PARAMID_DRMVERSION. In addition, the data specifies one of the following flags:
    ///              WMDM_SCP_DRMINFO_NOT_DRMPROTECTED WMDM_SCP_DRMINFO_V1HEADER WMDM_SCP_DRMINFO_V2HEADER </td> </tr> <tr>
    ///              <td>EVENT_WMDM_CONTENT_TRANSFER</td> <td>Content is being transferred to or from the device.</td> </tr>
    ///              </table>
    ///    hrCompletionCode = <b>HRESULT</b> specifying the completion code of the operation that was in progress. The
    ///                       <i>hrCompletionCode</i> parameter is the return code of the operation that ended. This parameter can be any
    ///                       <b>HRESULT</b>, including standard COM error codes, Win32 error codes converted to <b>HRESULT</b>, or Windows
    ///                       Media Device Manager error codes.
    ///    pContext = Pointer to an OPAQUECOMMAND structure containing a command sent directly to the device without being handled
    ///               by Windows Media Device Manager. This parameter is optional and can be <b>NULL</b>. The context structure is
    ///               a way for the component to send any relevant data with the event to the application. The component sending
    ///               this structure should define how the application can interpret this data structure.
    ///Returns:
    ///    Windows Media Device Manager ignores any return code returned by the <b>End3</b> method because the current
    ///    operation is finished or cancelled before this method is called.
    ///    
    HRESULT End3(GUID EventId, HRESULT hrCompletionCode, __OPAQUECOMMAND* pContext);
}

///The <b>IWMDMDevice</b> interface provides methods to examine and explore a single portable device. The interface can
///be used to get information about a device and enumerate its storages. IWMDMDevice2 extends the capabilities of this
///interface.
@GUID("1DCB3A02-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMDevice : IUnknown
{
    ///The <b>GetName</b> method retrieves the human-readable name of the media device.
    ///Params:
    ///    pwszName = Pointer to a (Unicode) wide-character, null-terminated string specifying the device name. The buffer is
    ///               allocated and released by the caller.
    ///    nMaxChars = Integer specifying the maximum number of characters that can be placed in <i>pwszName</i>, including the
    ///                termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    ///The <b>GetManufacturer</b> method retrieves the name of the manufacturer of the device.
    ///Params:
    ///    pwszName = Pointer to a wide-character, null-terminated string specifying the manufacturer's name. The buffer must be
    ///               allocated and released by the caller.
    ///    nMaxChars = Integer specifying the maximum number of characters that can be copied to <i>pwszName</i>, including the
    ///                termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetManufacturer(PWSTR pwszName, uint nMaxChars);
    ///The <b>GetVersion</b> method retrieves the manufacturer-defined version number of the device.
    ///Params:
    ///    pdwVersion = Pointer to a <b>DWORD</b> specifying the version number.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetVersion(uint* pdwVersion);
    ///The <b>GetType</b> method retrieves the operations supported by the device.
    ///Params:
    ///    pdwType = Pointer to a <b>DWORD</b> specifying the device type attributes. The possible values returned in
    ///              <i>pdwType</i> are defined in the following table. Microsoft recommends setting both WMDM_DEVICE_TYPE_SDMI
    ///              and WMDM_DEVICE_TYPE_NONSDMI flags. <table> <tr> <th>Device type </th> <th>Description </th> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_PLAYBACK</td> <td>The media device supports audio playback.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_RECORD</td> <td>The media device supports audio recording.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_DECODE</td> <td>The media device supports audio format decoding.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_ENCODE</td> <td>The media device supports audio format encoding.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_STORAGE</td> <td>The media device has on-board storage for media files.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_VIRTUAL</td> <td>The media device is not a physical device.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_SDMI</td> <td>The media device can accept SDMI-protected content.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_NONSDMI</td> <td>The media device can accept non-SDMI content.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_NONREENTRANT</td> <td>The media device must synchronize access to Windows Media Device
    ///              Manager services.</td> </tr> <tr> <td>WMDM_DEVICE_TYPE_FILELISTRESYNC</td> <td>The media device allows the
    ///              file list to be resynchronized.</td> </tr> <tr> <td>WMDM_DEVICE_TYPE_VIEW_PREF_METADATAVIEW</td> <td>The
    ///              media device prefers metadata views while its storages are enumerated.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetType(uint* pdwType);
    ///The <b>GetSerialNumber</b> method retrieves a serial number that uniquely identifies the device.
    ///Params:
    ///    pSerialNumber = Pointer to a WMDMID structure specifying the serial number information. The <b>WMDID</b> structure is
    ///                    allocated and released by the application.
    ///    abMac = Array of bytes specifying the message authentication code for the parameter data of this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSerialNumber(__WMDMID* pSerialNumber, ubyte* abMac);
    ///The <b>GetPowerSource</b> method retrieves information about the power source and the percentage of power
    ///remaining for the device.
    ///Params:
    ///    pdwPowerSource = Pointer to a <b>DWORD</b> specifying information about the power source of the device. The possible returned
    ///                     values are a bitwise <b>OR</b> of one or more of the following values. <table> <tr> <th>Flag </th>
    ///                     <th>Description </th> </tr> <tr> <td>WMDM_POWER_CAP_BATTERY</td> <td>The media device can run on
    ///                     batteries.</td> </tr> <tr> <td>WMDM_POWER_CAP_EXTERNAL</td> <td>The media device can run on external
    ///                     power.</td> </tr> <tr> <td>WMDM_POWER_IS_BATTERY</td> <td>The media device is currently running on
    ///                     batteries.</td> </tr> <tr> <td>WMDM_POWER_IS_EXTERNAL</td> <td>The media device is currently running on
    ///                     external power.</td> </tr> <tr> <td>WMDM_POWER_PERCENT_AVAILABLE</td> <td>The percentage of power remaining
    ///                     was returned in <i>pdwPercentRemaining</i>.</td> </tr> </table>
    ///    pdwPercentRemaining = If <i>pdwPowerSource</i> contains WMDM_POWER_PERCENT_AVAILABLE, a pointer to a <b>DWORD</b> specifying the
    ///                          percentage of power remaining in the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetPowerSource(uint* pdwPowerSource, uint* pdwPercentRemaining);
    ///The <b>GetStatus</b> method retrieves device status information.
    ///Params:
    ///    pdwStatus = Pointer to a <b>DWORD</b> specifying the device status. The possible values returned in <i>pdwStatus</i> are
    ///                provided in the following table. <table> <tr> <th>Status </th> <th>Description </th> </tr> <tr>
    ///                <td>WMDM_STATUS_READY</td> <td>Windows Media Device Manager and its subcomponents are in a ready state.</td>
    ///                </tr> <tr> <td>WMDM_STATUS_BUSY</td> <td>An operation is ongoing. Evaluate status values to determine the
    ///                operation.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStatus(uint* pdwStatus);
    ///The <b>GetDeviceIcon</b> method retrieves a handle to the icon that the device manufacturer wants to display when
    ///the device is connected.
    ///Params:
    ///    hIcon = Handle to an icon object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetDeviceIcon(uint* hIcon);
    ///The <b>EnumStorage</b> method retrieves an IWMDMEnumStorage interface to enumerate the storages on a device.
    ///Syntax
    ///Params:
    ///    ppEnumStorage = Pointer to a pointer to an IWMDMEnumStorage interface to enumerate the storages on a device. This points to
    ///                    the root storage on the device. The caller is responsible for calling <b>Release</b> on the retrieved
    ///                    interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EnumStorage(IWMDMEnumStorage* ppEnumStorage);
    ///The <b>GetFormatSupport</b> method retrieves all the formats supported by the device, including codecs and file
    ///formats.
    ///Params:
    ///    ppFormatEx = Pointer to an array of _WAVEFORMATEX structures specifying information about codecs and bit rates supported
    ///                 by the device. Windows Media Device Manager allocates the memory for this parameter; the caller must free it
    ///                 using <b>CoTaskMemFree</b>.
    ///    pnFormatCount = Pointer to the number of elements in the <i>ppFormatEx</i> array.
    ///    pppwszMimeType = Pointer to an array describing file formats and digital rights management schemes supported by the device.
    ///                     Windows Media Device Manager allocates the memory for this parameter; the caller must free it using
    ///                     <b>CoTaskMemFree</b>.
    ///    pnMimeTypeCount = Pointer to the number of elements in the <i>pppwszMimeType</i> array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetFormatSupport(_tWAVEFORMATEX** ppFormatEx, uint* pnFormatCount, PWSTR** pppwszMimeType, 
                             uint* pnMimeTypeCount);
    ///The <b>SendOpaqueCommand</b> method sends a device-specific command to the device through Windows Media Device
    ///Manager. Windows Media Device Manager does not attempt to read the command.
    ///Params:
    ///    pCommand = Pointer to an OPAQUECOMMAND structure specifying the information required to execute the command. If the
    ///               device returns data, it is returned through the <i>pData</i> member of <i>pCommand</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

///The <b>IWMDMDevice2</b> interface extends IWMDMDevice by making it possible to get the video formats supported by a
///device, find storage from its name, and use property pages.
@GUID("E34F3D37-9D67-4FC1-9252-62D28B2F8B55")
interface IWMDMDevice2 : IWMDMDevice
{
    ///The <b>GetStorage</b> method searches the immediate children of the root storage for a storage with the given
    ///name.
    ///Params:
    ///    pszStorageName = Pointer to a <b>null</b>-terminated string specifying the name of the storage to find. This parameter does
    ///                     not support wildcard characters.
    ///    ppStorage = Pointer to the IWMDMStorage interface of the storage specified by the <i>pszStorageName</i> parameter. The
    ///                caller must release this interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStorage(const(PWSTR) pszStorageName, IWMDMStorage* ppStorage);
    ///The <b>GetFormatSupport2</b> method retrieves the formats supported by the device, including audio and video
    ///codecs, and MIME file formats.
    ///Params:
    ///    dwFlags = <b>DWORD</b> specifying audio formats, video formats, and MIME types. This flag specifies what the
    ///              application is requesting the service provider to fill in. The caller can set one or more of the following
    ///              three values. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr>
    ///              <td>WMDM_GET_FORMAT_SUPPORT_AUDIO</td> <td>Service provider should fill in audio parameters.</td> </tr> <tr>
    ///              <td>WMDM_GET_FORMAT_SUPPORT_VIDEO</td> <td>Service provider should fill in video parameters.</td> </tr> <tr>
    ///              <td>WMDM_GET_FORMAT_SUPPORT_FILE</td> <td>Service provider should fill in file parameters.</td> </tr>
    ///              </table>
    ///    ppAudioFormatEx = Pointer to an array of <b>_WAVEFORMATEX</b> structures specifying information about audio codecs and bit
    ///                      rates supported by the device. The memory for this parameter is allocated by Windows Media Device Manager,
    ///                      and must be released by the caller with the Win32 function <b>CoTaskMemFree</b>.
    ///    pnAudioFormatCount = Pointer to an integer specifying the audio format count.
    ///    ppVideoFormatEx = Pointer to an array of <b>_VIDEOFORMATEX</b> structures specifying information about video codes and formats
    ///                      supported by the device. The memory for this parameter is allocated by Windows Media Device Manager, and must
    ///                      be released by the caller with the Win32 function <b>CoTaskMemFree</b>.
    ///    pnVideoFormatCount = Pointer to an integer specifying the video format count.
    ///    ppFileType = Pointer to an array of <b>WMFILECAPABILITIES</b> file-type objects. The memory for this parameter is
    ///                 allocated by Windows Media Device Manager, and must be released by the caller with the Win32 function
    ///                 <b>CoTaskMemFree</b>.
    ///    pnFileTypeCount = Pointer to an integer specifying the file-type count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetFormatSupport2(uint dwFlags, _tWAVEFORMATEX** ppAudioFormatEx, uint* pnAudioFormatCount, 
                              _tagVIDEOINFOHEADER** ppVideoFormatEx, uint* pnVideoFormatCount, 
                              WMFILECAPABILITIES** ppFileType, uint* pnFileTypeCount);
    ///The <b>GetSpecifyPropertyPages</b> method retrieves the property page for the device. Property pages can be used
    ///to report device-specific properties and branding information.
    ///Params:
    ///    ppSpecifyPropPages = Pointer to a pointer to an <b>ISpecifyPropertyPages</b> interface. <b>ISpecifyPropertyPages</b> is documented
    ///                         in the COM area of the Platform SDK. The caller must release this interface when done with it.
    ///    pppUnknowns = Specifies an array of <b>IUnknown</b> interface pointers. These interfaces are passed to the property page
    ///                  and can be used to pass information between the property page and the service provider. The array is
    ///                  allocated by Windows Media Device Manager, but the caller must call <b>Release</b> on each interface
    ///                  retrieved, and <b>CoTaskMemFree</b> on the retrieved array.
    ///    pcUnks = Retrieves the size of the <i>pppUnknowns</i> array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, IUnknown** pppUnknowns, 
                                    uint* pcUnks);
    ///The <b>GetCanonicalName</b> method retrieves the canonical name of the device.
    ///Params:
    ///    pwszPnPName = Wide-character buffer for the canonical names. This buffer must be allocated and released by the caller.
    ///    nMaxChars = Integer specifying the maximum number of characters that can be placed in <i>pwszPnPName</i>, including the
    ///                termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszPnPName</i> parameter is an invalid or
    ///    <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td>
    ///    <td width="60%"> The device does not support a canonical name. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The buffer specified is too small for the
    ///    canonical name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetCanonicalName(PWSTR pwszPnPName, uint nMaxChars);
}

///The <b>IWMDMDevice3</b> interface extends <b>IWMDMDevice2</b> by providing methods to query a device for properties,
///send device I/O controle codes, and also providing upgraded methods to search for storages and retrieve device format
///capabilities.
@GUID("6C03E4FE-05DB-4DDA-9E3C-06233A6D5D65")
interface IWMDMDevice3 : IWMDMDevice2
{
    ///The <b>GetProperty</b> method retrieves a specific device metadata property.
    ///Params:
    ///    pwszPropName = A wide character, null-terminated string name of the property to retrieve. A list of standard property name
    ///                   constants is given in Metadata Constants.
    ///    pValue = Returned value for the property. The application must free this memory using <b>PropVariantClear</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetProperty(const(PWSTR) pwszPropName, PROPVARIANT* pValue);
    ///The <b>SetProperty</b> method sets a specific device property, if it is writable.
    ///Params:
    ///    pwszPropName = A wide character, null-terminated string name of the property to set. This overwrites any existing property
    ///                   with the same name. Once the application has made this call, it should free any dynamic memory using
    ///                   <b>PropVariantClear</b>. A list of standard property name constants is given in Metadata Constants.
    ///    pValue = Value of the property being set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetProperty(const(PWSTR) pwszPropName, const(PROPVARIANT)* pValue);
    ///The <b>GetFormatCapability</b> method retrieves device support for files of a specified format. The capabilities
    ///are expressed as supported properties and their allowed values.
    ///Params:
    ///    format = Value from the WMDM_FORMATCODE enumeration representing the queried format.
    ///    pFormatSupport = Pointer to the returned WMDM_FORMAT_CAPABILITY structure containing supported properties and their allowed
    ///                     values. These values must be released by the application as described in Getting Format Capabilities on
    ///                     Devices That Support IWMDMDevice3.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    ///The <b>DeviceIoControl</b> method sends a Device I/O Control (IOCTL) code to the device. This is a pass-through
    ///method; Windows Media Device Manager just forwards the call to the service provider after validating the
    ///parameters.
    ///Params:
    ///    dwIoControlCode = Control code to send to the device. When calling this method on an MTP device, use the value
    ///                      IOCTL_MTP_CUSTOM_COMMAND defined in MtpExt.h included with the SDK.
    ///    lpInBuffer = Optional pointer to an input buffer supplied by the caller. It can be <b>NULL</b> if <i>nInBufferSize</i> is
    ///                 zero. When calling this method on an MTP device, you can pass in the MTP_COMMAND_DATA_IN structure.
    ///    nInBufferSize = Size of the input buffer, in bytes. When calling this method on an MTP device, you can use the macro
    ///                    <b>SIZEOF_REQUIRED_COMMAND_DATA_IN</b> to specify the size.
    ///    lpOutBuffer = Optional pointer to the output buffer supplied by the caller. It can be <b>NULL</b> if <i>pnOutBufferSize</i>
    ///                  points to a value of zero. When calling this method on an MTP device, you can pass in the
    ///                  MTP_COMMAND_DATA_OUT structure.
    ///    pnOutBufferSize = Size of the output buffer, in bytes. When the call returns, it specifies the number of bytes actually
    ///                      returned. When calling this method on an MTP device, you can use the macro
    ///                      <b>SIZEOF_REQUIRED_COMMAND_DATA_OUT</b> defined in MtpExt.h to specify the size.This parameter cannot be
    ///                      <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT DeviceIoControl(uint dwIoControlCode, ubyte* lpInBuffer, uint nInBufferSize, ubyte* lpOutBuffer, 
                            uint* pnOutBufferSize);
    ///The <b>FindStorage</b> method finds a storage by its persistent unique identifier. Unlike other methods, this
    ///method can search recursively from the root storage.
    ///Params:
    ///    findScope = A WMDM_FIND_SCOPE enumeration specifying the scope of the find operation.
    ///    pwszUniqueID = A wide character, null-terminated string representing a persistent unique identifier of the storage, which
    ///                   can be retrieved by querying for the <b>g_wszWMDMPersistentUniqueID</b> property of the storage.
    ///    ppStorage = Pointer to the returned storage. The caller must release this interface when done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IWMDMStorage* ppStorage);
}

///The <b>IWMDMDeviceSession</b> interface improves the efficiency of device operations by bundling multiple operations
///into one session. Using a single session allows Windows Media Device Manager to handle various operations, such as
///acquiring a device certificate, once over several operations.
@GUID("82AF0A65-9D96-412C-83E5-3C43E4B06CC7")
interface IWMDMDeviceSession : IUnknown
{
    ///The <b>BeginSession</b> method begins a device session.
    ///Params:
    ///    type = A WMDM_SESSION_TYPE describing the type of session to begin. This is a bitwise <b>OR</b> of any values except
    ///           WMDM_SESSION_NONE. The same type (or combination of types) must be specified during EndSession.
    ///    pCtx = Optional pointer to a caller-allocated session context buffer for private communication between the
    ///           application and the service provider. Applications having knowledge of the underlying service provider can
    ///           use this buffer to pass context-specific data to it. Windows Media Device Manager does not do anything with
    ///           this context. The caller is responsible for freeing this buffer.
    ///    dwSizeCtx = Size of the context buffer, in bytes. If the size is 0, <i>pCtx</i> is ignored. If the size is non-zero,
    ///                <i>pCtx</i> must be a valid pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT BeginSession(WMDM_SESSION_TYPE type, ubyte* pCtx, uint dwSizeCtx);
    ///The <b>EndSession</b> method ends a device session.
    ///Params:
    ///    type = A WMDM_SESSION_TYPE describing the type of session to end. This must be the same bitwise <b>OR</b> of the
    ///           values specified in BeginSession.
    ///    pCtx = Optional pointer to a caller-allocated session context buffer for private communication between the
    ///           application and the service provider. Applications having knowledge of the underlying service provider can
    ///           use this buffer to pass context-specific data to it. Windows Media Device Manager does not do anything with
    ///           this context. The caller is responsible for freeing this buffer.
    ///    dwSizeCtx = Size of the context buffer, in bytes. If the size is 0, <i>pCtx</i> is ignored. If the size is non-zero,
    ///                <i>pCtx</i> must be a valid pointer
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EndSession(WMDM_SESSION_TYPE type, ubyte* pCtx, uint dwSizeCtx);
}

///The <b>IWMDMEnumDevice</b> interface enumerates portable devices attached to a computer. To obtain this interface,
///call IWMDeviceManager::EnumDevices.
@GUID("1DCB3A01-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMEnumDevice : IUnknown
{
    ///The <b>Next</b> method returns a pointer to the next device, represented by an IWMDMDevice interface.
    ///Params:
    ///    celt = Number of devices requested.
    ///    ppDevice = Pointer to caller-allocated array of IWMDMDevice interface pointers. The size of this array must be
    ///               <b>IWMDMDevice</b> *[celt]. The caller must release these interfaces when done with them. To avoid allocating
    ///               a whole array, simply pass in the address of a pointer to an <b>IWMDMDevice</b> interface, as shown in
    ///               Remarks.
    ///    pceltFetched = Pointer to a variable that receives the number of devices (interfaces) returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Next(uint celt, IWMDMDevice* ppDevice, uint* pceltFetched);
    ///The <b>Skip</b> method skips over a specified number of devices in the enumeration sequence.
    ///Params:
    ///    celt = Number of devices to skip.
    ///    pceltFetched = Number of devices actually skipped.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Skip(uint celt, uint* pceltFetched);
    ///The <b>Reset</b> method resets the enumeration so that Next returns a pointer to the first device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method returns a copy of the <b>IWMDMEnumDevice</b> interface. The new enumerator specifies the
    ///same enumeration state as the current enumerator.
    ///Params:
    ///    ppEnumDevice = Address of a pointer to an IWMDMEnumDevice interface. The caller must release this interface when done with
    ///                   it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Clone(IWMDMEnumDevice* ppEnumDevice);
}

///The <b>IWMDMDeviceControl</b> interface provides methods for controlling playback on a device. Query an
///<b>IWMDMDevice</b> interface to get this interface. Playback parameters are controlled by the IWMDMObjectInfo
///interface. The <b>IWMDMDeviceControl</b> interface methods support several modes of audio control, depending on the
///context in which they are used. That context is defined by the IWMDMDeviceControl::Seek method. The
///IWMDMDeviceControl::GetCapabilities method is used to determine what kinds of operations can be performed by the
///device.
@GUID("1DCB3A04-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMDeviceControl : IUnknown
{
    ///The <b>GetStatus</b> method retrieves the control status of the device.
    ///Params:
    ///    pdwStatus = Pointer to a <b>DWORD</b> that specifies the control status of the device. The control status value specifies
    ///                one or more of the following flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///                <td>WMDM_STATUS_READY</td> <td>Windows Media Device Manager and its subcomponents are in a ready state.</td>
    ///                </tr> <tr> <td>WMDM_STATUS_BUSY</td> <td>An operation is currently being performed. Evaluate the other status
    ///                values to determine which operation it is.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_PLAYING</td> <td>The
    ///                device is currently playing.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_RECORDING</td> <td>The device is
    ///                currently recording.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_PAUSED</td> <td>The device is currently
    ///                paused.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_REMOTE</td> <td>The play or record operation of the
    ///                device is being remotely controlled by the application.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_DEVICECONTROL_STREAM</td> <td>The play or record method is streaming data to or from the
    ///                media device.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pdwStatus</i> parameter is an invalid
    ///    or <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetStatus(uint* pdwStatus);
    ///The <b>GetCapabilities</b> method retrieves the device capabilities to determine what operations the device can
    ///perform. The capabilities describe the methods of the device control that are supported by the media device.
    ///Params:
    ///    pdwCapabilitiesMask = Pointer to a <b>DWORD</b> specifying the capabilities of the device. The following flags can be returned in
    ///                          this variable. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr> <td>WMDM_DEVICECAP_CANPLAY</td>
    ///                          <td>The media device can play MP3 audio.</td> </tr> <tr> <td>WMDM_DEVICECAP_CANSTREAMPLAY</td> <td>The media
    ///                          device can play streaming audio directly from the host computer.</td> </tr> <tr>
    ///                          <td>WMDM_DEVICECAP_CANRECORD</td> <td>The media device can record audio.</td> </tr> <tr>
    ///                          <td>WMDM_DEVICECAP_CANSTREAMRECORD</td> <td>The media device can record streaming audio directly to the host
    ///                          computer.</td> </tr> <tr> <td>WMDM_DEVICECAP_CANPAUSE</td> <td>The media device can pause during play or
    ///                          record operations.</td> </tr> <tr> <td>WMDM_DEVICECAP_CANRESUME</td> <td>The media device can resume an
    ///                          operation that was paused.</td> </tr> <tr> <td>WMDM_DEVICECAP_CANSTOP</td> <td>The media device can stop
    ///                          playing before the end of a file.</td> </tr> <tr> <td>WMDM_DEVICECAP_CANSEEK</td> <td>The media device can
    ///                          seek to a position other than the beginning of a file.</td> </tr> <tr> <td>WMDM_DEVICECAP_HASSECURECLOCK</td>
    ///                          <td>The media device has a secure clock.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pdwCapabilitiesMask</i> parameter is an
    ///    invalid or <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetCapabilities(uint* pdwCapabilitiesMask);
    ///The <b>Play</b> method begins playing at the current seek position. If the <b>IWMDMDeviceControl::Seek</b> method
    ///has not been called, then playing begins at the beginning of the first file, and the play length is not defined.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_BUSY</b></dt> </dl> </td> <td width="60%"> The device is busy. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The play function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Play();
    ///The <b>Record</b> method begins recording from the device's external record input at the current seek position.
    ///The <b>IWMDMDeviceControl::Seek</b> method must be called first.
    ///Params:
    ///    pFormat = Pointer to a _WAVEFORMATEX structure specifying the format in which the data must be recorded.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_BUSY</b></dt> </dl> </td> <td width="60%"> The device is already performing an operation. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The record
    ///    function is not implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Record(_tWAVEFORMATEX* pFormat);
    ///The <b>Pause</b> method pauses the current play or record session at the current position within the content.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The device is already paused. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The pause function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Pause();
    ///The <b>Resume</b> method resumes the current play or record operation from the file position saved during the
    ///call to Pause.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The device is not paused. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The resume function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Resume();
    ///The <b>Stop</b> method stops the current record or play operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_BUSY</b></dt> </dl> </td> <td width="60%"> The device is busy. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The stop function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Stop();
    ///The <b>Seek</b> method seeks to a position that is used as the starting point by the Play or Record methods.
    ///Params:
    ///    fuMode = Mode for the seek operation being performed. The <i>fuMode</i> parameter must be one of the following modes.
    ///             <table> <tr> <th>Mode </th> <th>Description </th> </tr> <tr> <td>WMDM_SEEK_BEGIN</td> <td>Seek to a position
    ///             that is <i>nOffset</i> units after the beginning of the file.</td> </tr> <tr> <td>WMDM_SEEK_CURRENT</td>
    ///             <td>Seek to a position that is <i>nOffset</i> units from the current position.</td> </tr> <tr>
    ///             <td>WMDM_SEEK_END</td> <td>Seek to a position that is <i>nOffset</i> units before the end of the file.</td>
    ///             </tr> <tr> <td>WMDM_SEEK_REMOTECONTROL</td> <td>Seek the removable control.</td> </tr> <tr>
    ///             <td>WMDM_SEEK_STREAMINGAUDIO</td> <td>Seek the streaming audio.</td> </tr> </table>
    ///    nOffset = Number of units by which the seek operation moves the starting position away from the origin specified by
    ///              <i>fuMode</i>. The units of <i>nOffset</i> are defined by the content. They can be milliseconds for music,
    ///              pages for electronic books, and so on. A positive value for <i>nOffset</i> indicates seeking forward through
    ///              the file. A negative value indicates seeking backward through the file. Any combination of <i>nOffset</i> and
    ///              <i>fuMode</i> that indicates seeking to a position before the beginning of the file or after the end of the
    ///              file is not valid, and causes the method to return E_INVALIDARG.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> Seek is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Seek(uint fuMode, int nOffset);
}

///The <b>IWMDMEnumStorage</b> interface enumerates storages on a device. Obtain this interface the first time by
///calling IWMDMDevice::EnumStorage on a device, and afterward by calling IWMDMStorage::EnumStorage. This interface only
///enumerates the immediate children of the parent storage that was used to obtain this interface. (If
///IWMDMDevice::EnumStorage was used, the parent storage is the device's root storage.)
@GUID("1DCB3A05-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMEnumStorage : IUnknown
{
    ///The <b>Next</b> method retrieves a pointer to the next sibling storage.
    ///Params:
    ///    celt = Number of storages requested.
    ///    ppStorage = Pointer to caller-allocated array of IWMDMStorage interface pointers. The size of this array must be
    ///                <b>IWMDMStorage</b> *[celt]. The caller must release these interfaces when done with them. To avoid
    ///                allocating a whole array, simply pass in the address of a pointer to an <b>IWMDMStorage</b> interface, as
    ///                shown in Remarks.
    ///    pceltFetched = Number of storages enumerated.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Next(uint celt, IWMDMStorage* ppStorage, uint* pceltFetched);
    ///The <b>Skip</b> method skips over the specified number of storages in the enumeration sequence.
    ///Params:
    ///    celt = The number of storages to skip.
    ///    pceltFetched = The number of storages skipped.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Skip(uint celt, uint* pceltFetched);
    ///The <b>Reset</b> method sets the enumeration sequence back to the beginning.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method creates another enumerator with the same enumeration state as the current enumerator.
    ///Params:
    ///    ppEnumStorage = An IWMDMEnumStorage interface of the cloned enumerator. The caller must release this interface when done with
    ///                    it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Clone(IWMDMEnumStorage* ppEnumStorage);
}

///The <b>IWMDMStorageControl</b> interface is used to insert, delete, or move files within a storage, a device, or
///between a device and the computer.
@GUID("1DCB3A08-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMStorageControl : IUnknown
{
    ///The <b>Insert</b> method puts content into the storage on the device.
    ///Params:
    ///    fuMode = A bitwise <b>OR</b> of the following values. The following table lists the processing modes that can be
    ///             specified in the <i>fuMode</i> parameter. You must specify exactly one of the first two modes, exactly one of
    ///             the STORAGECONTROL modes, and exactly one of the CONTENT modes. If both WMDM_MODE_BLOCK and WMDM_MODE_THREAD
    ///             are specified, block mode is used. <table> <tr> <th>Combinations </th> <th>Mode </th> <th>Description </th>
    ///             </tr> <tr> <td>Exactly one of:</td> <td>WMDM_MODE_BLOCK</td> <td>The operation is performed using block mode
    ///             processing. The call will not return until the operation is finished.</td> </tr> <tr> <td></td>
    ///             <td>WMDM_MODE_THREAD</td> <td>The operation is performed using thread mode processing. The call will return
    ///             immediately, and the operation is performed in a background thread.</td> </tr> <tr> <td>Exactly one of:</td>
    ///             <td>WMDM_STORAGECONTROL_INSERTBEFORE</td> <td>The object is inserted before the current object.</td> </tr>
    ///             <tr> <td></td> <td>WMDM_STORAGECONTROL_INSERTAFTER</td> <td>The object is inserted after the current
    ///             object.</td> </tr> <tr> <td></td> <td>WMDM_STORAGECONTROL_INSERTINTO</td> <td>The object is inserted into the
    ///             current object. This will only work if the current object is a folder.</td> </tr> <tr> <td>Exactly one
    ///             of:</td> <td>WMDM_CONTENT_FILE</td> <td>The content being inserted is a file.</td> </tr> <tr> <td></td>
    ///             <td>WMDM_CONTENT_FOLDER</td> <td>The content being inserted is a folder. This will not transfer the contents
    ///             of the folder.</td> </tr> <tr> <td></td> <td>WMDM_CONTENT_OPERATIONINTERFACE</td> <td>The content being
    ///             inserted is an operation interface. The data for the content should be written to the application-implemented
    ///             <b>IWMDMOperation</b> interface.</td> </tr> <tr> <td>Zero or more of:</td>
    ///             <td>WMDM_FILE_CREATE_OVERWRITE</td> <td>The object will replace the current object.</td> </tr> <tr> <td></td>
    ///             <td>WMDM_MODE_QUERY</td> <td>A test is performed to determine whether the insert operation could succeed, but
    ///             the insert will not be performed.</td> </tr> <tr> <td></td> <td>WMDM_MODE_PROGRESS</td> <td>The method should
    ///             return progress notifications through <i>pProgress</i>.</td> </tr> <tr> <td>Zero or one of:</td>
    ///             <td>WMDM_MODE_TRANSFER_PROTECTED</td> <td>The insertion is in protected transfer mode.</td> </tr> <tr>
    ///             <td></td> <td>WMDM_MODE_TRANSFER_UNPROTECTED</td> <td>The insertion is in unprotected transfer mode.</td>
    ///             </tr> </table>
    ///    pwszFile = Pointer to a wide-character <b>null</b>-terminated string indicating where to find the content for the insert
    ///               operation. This parameter must be <b>NULL</b> if WMDM_CONTENT_OPERATIONINTERFACE is specified in
    ///               <i>fuMode</i>.
    ///    pOperation = Optional pointer to an IWMDMOperation interface, to control the transfer of content to a media device. If
    ///                 specified, <i>fuMode</i> must include the WMDM_CONTENT_OPERATIONINTERFACE flag. This parameter must be
    ///                 <b>NULL</b> if WMDM_CONTENT_FILE or WMDM_CONTENT_FOLDER is specified in <i>fuMode</i>.
    ///    pProgress = Optional pointer to an IWMDMProgress interface to be used by Windows Media Device Manager to report progress
    ///                back to the application. If this is used, <i>fuMode</i> should include WMDM_MODE_PROGRESS.
    ///    ppNewObject = Pointer to an IWMDMStorage interface that will contain the new content. The caller must release this
    ///                  interface when finished with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Insert(uint fuMode, PWSTR pwszFile, IWMDMOperation pOperation, IWMDMProgress pProgress, 
                   IWMDMStorage* ppNewObject);
    ///The <b>Delete</b> method permanently deletes this storage.
    ///Params:
    ///    fuMode = One or two of the following flags, combined with a bitwise <b>OR</b>. Specify exactly one of the first two
    ///             modes; the third mode is optional. <table> <tr> <th>Mode </th> <th>Description </th> </tr> <tr>
    ///             <td>WMDM_MODE_BLOCK</td> <td>The operation is performed using block mode (synchronous) processing. The call
    ///             will not return until the operation is finished.</td> </tr> <tr> <td>WMDM_MODE_THREAD</td> <td>The operation
    ///             is performed using thread mode (asynchronous) processing. The call will return immediately, and the operation
    ///             is performed in a background thread.</td> </tr> <tr> <td>WMDM_MODE_RECURSIVE</td> <td>If the storage object
    ///             is a folder, it and its contents, and all subfolders and their contents are deleted.</td> </tr> </table> 4
    ///    pProgress = Optional pointer to an IWMDMProgress interface to be used by Windows Media Device Manager to report progress
    ///                back to the application.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Delete(uint fuMode, IWMDMProgress pProgress);
    ///The <b>Rename</b> method renames the current storage.
    ///Params:
    ///    fuMode = Processing mode used for the <b>Rename</b> operation. Specify exactly one of the following two modes. If both
    ///             modes are specified, block mode is used. <table> <tr> <th>Mode </th> <th>Description </th> </tr> <tr>
    ///             <td>WMDM_MODE_BLOCK</td> <td>The operation is performed using block mode processing. The call will not return
    ///             until the operation is finished.</td> </tr> <tr> <td>WMDM_MODE_THREAD</td> <td>The operation is performed
    ///             using thread mode processing. The call will return immediately, and the operation is performed in a
    ///             background thread.</td> </tr> </table>
    ///    pwszNewName = Pointer to a wide-character null-terminated string specifying the new name.
    ///    pProgress = Optional pointer to an <b>IWMDMProgress</b> interface that has been implemented by the application to track
    ///                the progress of the action.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Rename(uint fuMode, PWSTR pwszNewName, IWMDMProgress pProgress);
    ///The <b>Read</b> method copies the current storage to the computer.
    ///Params:
    ///    fuMode = Processing mode used for the <b>Read</b> operation. The following table lists the processing modes that can
    ///             be specified in the <i>fuMode</i> parameter. You must specify exactly one of the first two modes, and exactly
    ///             one of the last three (WMDM_CONTENT) modes. If both WMDM_MODE_BLOCK and WMDM_MODE_THREAD are specified, block
    ///             mode is used. <table> <tr> <th>Mode </th> <th>Description </th> </tr> <tr> <td>WMDM_MODE_BLOCK</td> <td>The
    ///             operation is performed using block mode processing. The call will not return until the operation is
    ///             finished.</td> </tr> <tr> <td>WMDM_MODE_THREAD</td> <td>The operation is performed using thread mode
    ///             processing. The call will return immediately, and the operation is performed in a background thread.</td>
    ///             </tr> <tr> <td>WMDM_CONTENT_FILE</td> <td>The caller requests that Windows Media Device Manager read the file
    ///             from the portable device into a file on the hard disk. The caller should indicate, in the <i>pwszFileName</i>
    ///             parameter, the full path and name of the file.</td> </tr> <tr> <td>WMDM_CONTENT_FOLDER</td> <td>The caller
    ///             requests that Windows Media Device Manager read the specified folder, the contents, of the folder and the
    ///             contents of any subfolders from the portable device onto the hard disk. The caller should indicate the full
    ///             path of the target directory on the hard disk in the <i>pwszFileName</i> parameter.This is not currently
    ///             supported by any Microsoft-provided service providers. </td> </tr> <tr>
    ///             <td>WMDM_CONTENT_OPERATIONINTERFACE</td> <td>The application-implemented <b>IWMDMOperation</b> interface is
    ///             being used to read data, instead of passing in a file name.</td> </tr> </table>
    ///    pwszFile = Pointer to a fully qualified file name on the computer to which the content from the portable device is
    ///               copied. The file name should include an extension; the extension from the current storage on the device will
    ///               not be used. If WMDM_CONTENT_OPERATIONINTERFACE is specified in <i>fuMode</i>, this parameter is ignored.
    ///    pProgress = Optional pointer to a IWMDMProgress interface that has been implemented by the application to track the
    ///                progress of ongoing operations.
    ///    pOperation = Optional pointer to an IWMDMOperation interface, an optional set of methods used to enhance the transfer of
    ///                 content from a media device. This parameter must be <b>NULL</b> if WMDM_CONTENT_FILE or WMDM_CONTENT_FOLDER
    ///                 is specified in <i>fuMode</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Read(uint fuMode, PWSTR pwszFile, IWMDMProgress pProgress, IWMDMOperation pOperation);
    ///The <b>Move</b> method moves the current storage to a new location on the device.
    ///Params:
    ///    fuMode = Processing mode by which to invoke the <b>Move</b> operation and the type of move to make. Specify exactly
    ///             one of the following two modes. If both modes are specified, block mode is used. <table> <tr> <th>Mode </th>
    ///             <th>Description </th> </tr> <tr> <td>WMDM_MODE_BLOCK</td> <td>The operation is performed using block mode
    ///             processing. The call will not return until the operation is finished.</td> </tr> <tr>
    ///             <td>WMDM_MODE_THREAD</td> <td>The operation is performed using thread mode processing. The call will return
    ///             immediately, and the operation is performed in a background thread.</td> </tr> </table> The following table
    ///             lists flags that indicate where the object is moved to. One value from this table is combined with one value
    ///             from the preceding Mode table using a bitwise <b>OR</b>. <table> <tr> <th>Flag </th> <th>Description </th>
    ///             </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTBEFORE</td> <td>The object is inserted before the target
    ///             object.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTINTO</td> <td>The object is inserted into the target
    ///             object.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTAFTER</td> <td>The object is inserted after the target
    ///             object.</td> </tr> </table>
    ///    pTargetObject = Pointer to the object before or after which you want to put the current object.
    ///    pProgress = Optional pointer to an IWMDMProgress interface that has been implemented by the application to track the
    ///                progress of an ongoing operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Move(uint fuMode, IWMDMStorage pTargetObject, IWMDMProgress pProgress);
}

///The <b>IWMDMStorageControl2</b> interface extends <b>IWMDMStorageControl</b> by making it possible to set the name of
///the destination file when inserting content into a storage.
@GUID("972C2E88-BD6C-4125-8E09-84F837E637B6")
interface IWMDMStorageControl2 : IWMDMStorageControl
{
    ///The <b>Insert2</b> method puts content into/next to the storage. This method extends
    ///<b>IWMDMStorageControl::Insert</b> by allowing the application to specify a new destination name, and provide a
    ///pointer to a custom COM object.
    ///Params:
    ///    fuMode = Processing mode used for the <b>Insert2</b> operation. The following table lists the processing modes that
    ///             can be specified in the <b>fuMode</b> parameter. You must specify exactly one of the first two modes, exactly
    ///             one of the STORAGECONTROL modes, and exactly one of the CONTENT modes. If both WMDM_MODE_BLOCK and
    ///             WMDM_MODE_THREAD are specified, block mode is used. <table> <tr> <th>Combinations </th> <th>Mode </th>
    ///             <th>Description </th> </tr> <tr> <td>Exactly one of:</td> <td>WMDM_MODE_BLOCK</td> <td>The operation is
    ///             performed using block mode processing. The call will not return until the operation is finished.</td> </tr>
    ///             <tr> <td>-</td> <td>WMDM_MODE_THREAD</td> <td>The operation is performed using thread mode processing. The
    ///             call will return immediately, and the operation is performed in a background thread.</td> </tr> <tr>
    ///             <td>Optional</td> <td>WMDM_MODE_QUERY</td> <td>A test is performed to determine whether the insert operation
    ///             could succeed, but the insert will not be performed.</td> </tr> <tr> <td>Exactly one of:</td>
    ///             <td>WMDM_STORAGECONTROL_INSERTBEFORE</td> <td>The object is inserted before the target object.</td> </tr>
    ///             <tr> <td>-</td> <td>WMDM_STORAGECONTROL_INSERTAFTER</td> <td>The object is inserted after the target
    ///             object.</td> </tr> <tr> <td>-</td> <td>WMDM_STORAGECONTROL_INSERTINTO</td> <td>The object is inserted into
    ///             the current object. This will only work if the current object is a folder.</td> </tr> <tr> <td>Optional</td>
    ///             <td>WMDM_FILE_CREATE_OVERWRITE</td> <td>The object will replace the target object.</td> </tr> <tr>
    ///             <td>Exactly one of:</td> <td>WMDM_CONTENT_FILE</td> <td>The content being inserted is a file.</td> </tr> <tr>
    ///             <td>-</td> <td>WMDM_CONTENT_FOLDER</td> <td>The content being inserted is a folder. This will not transfer
    ///             the contents of the folder.</td> </tr> <tr> <td>Optional</td> <td>WMDM_CONTENT_OPERATIONINTERFACE</td>
    ///             <td>The content being inserted is an operation interface. The data for the content should be written to the
    ///             application-implemented <b>IWMDMOperation</b> interface.</td> </tr> <tr> <td>Optional</td>
    ///             <td>WMDM_MODE_PROGRESS</td> <td>Progress notifications should be sent through the <i>pProgress</i>
    ///             parameter.</td> </tr> <tr> <td>Optional one of:</td> <td>WMDM_MODE_TRANSFER_PROTECTED</td> <td>The insertion
    ///             is in protected transfer mode.</td> </tr> <tr> <td>-</td> <td>WMDM_MODE_TRANSFER_UNPROTECTED</td> <td>The
    ///             insertion is in unprotected transfer mode.</td> </tr> </table>
    ///    pwszFileSource = Pointer to a wide-character, <b>null</b>-terminated string indicating the full name and path of the object to
    ///                     send to the device. This parameter must be <b>NULL</b> if WMDM_CONTENT_OPERATIONINTERFACE is specified in
    ///                     <i>fuMode</i>.
    ///    pwszFileDest = Optional name of file on the device. If not specified and the application passes an <b>IWMDMOperation</b>
    ///                   pointer to <i>pOperation</i>, Windows Media Device Manager will request a destination name by calling
    ///                   IWMDMOperation::GetObjectName. If not specified and the application does not use <i>pOperation</i>, the
    ///                   original file name and extension are used (without the path).
    ///    pOperation = Optional pointer to an IWMDMOperation interface, to control the transfer of content to a media device. If
    ///                 specified, <i>fuMode</i> must include the WMDM_CONTENT_OPERATIONINTERFACE flag. This parameter must be
    ///                 <b>NULL</b> if WMDM_CONTENT_FILE or WMDM_CONTENT_FOLDER is specified in <i>fuMode</i>.
    ///    pProgress = Optional pointer to an IWMDMProgress interface to report action progress back to the application. If
    ///                specified, <i>fuMode</i> should include WMDM_MODE_PROGRESS.
    ///    pUnknown = Optional <b>IUnknown</b> pointer of any custom COM object to be passed to the secure content provider. This
    ///               makes it possible to pass custom information to a secure content provider if the application has sufficient
    ///               information about the secure content provider.
    ///    ppNewObject = Pointer to an <b>IWMDMStorage</b> interface that will contain the new content. The caller must release this
    ///                  interface when finished with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Insert2(uint fuMode, PWSTR pwszFileSource, PWSTR pwszFileDest, IWMDMOperation pOperation, 
                    IWMDMProgress pProgress, IUnknown pUnknown, IWMDMStorage* ppNewObject);
}

///The <b>IWMDMStorageControl3</b> interface extends <b>IWMDMStorageControl2</b> by providing an <b>Insert</b> method
///that accepts an IWMDMMetaData interface pointer.
@GUID("B3266365-D4F3-4696-8D53-BD27EC60993A")
interface IWMDMStorageControl3 : IWMDMStorageControl2
{
    ///The <b>Insert3</b> method puts content into/next to the storage. This method extends
    ///<b>IWMDMStorageControl2::Insert2</b> by allowing the application to explicitly specify the metadata and type of
    ///the object being sent.
    ///Params:
    ///    fuMode = Processing mode used for the <b>Insert3</b> operation. The following table lists the processing modes that
    ///             can be specified in the <i>fuMode</i> parameter. You must specify exactly one of the first two modes, exactly
    ///             one of the STORAGECONTROL modes, and exactly one of the CONTENT modes. If both WMDM_MODE_BLOCK and
    ///             WMDM_MODE_THREAD are specified, block mode is used. Specifying the WMDM_FILE_ATTR* flags in this function is
    ///             more efficient than calling this function first, then setting these attributes on the file after it has been
    ///             created or sent. <table> <tr> <th>Combinations </th> <th>Mode </th> <th>Description </th> </tr> <tr>
    ///             <td>Exactly one of:</td> <td>WMDM_MODE_BLOCK</td> <td>The operation is performed using block mode processing.
    ///             The call will not return until the operation is finished.</td> </tr> <tr> <td>-</td>
    ///             <td>WMDM_MODE_THREAD</td> <td>The operation is performed using thread mode processing. The call will return
    ///             immediately, and the operation is performed in a background thread.</td> </tr> <tr> <td>Optional</td>
    ///             <td>WMDM_MODE_QUERY</td> <td>A test is performed to determine whether the insert operation could succeed, but
    ///             the insert will not be performed.</td> </tr> <tr> <td>Exactly one of:</td>
    ///             <td>WMDM_STORAGECONTROL_INSERTBEFORE</td> <td>The object is inserted before the target object.</td> </tr>
    ///             <tr> <td>-</td> <td>WMDM_STORAGECONTROL_INSERTAFTER</td> <td>The object is inserted after the target
    ///             object.</td> </tr> <tr> <td>-</td> <td>WMDM_STORAGECONTROL_INSERTINTO</td> <td>The object is inserted into
    ///             the current object. This will only work if the current object is a folder.</td> </tr> <tr> <td>Optional</td>
    ///             <td>WMDM_FILE_CREATE_OVERWRITE</td> <td>The object will replace the target object.</td> </tr> <tr>
    ///             <td>Exactly one of:</td> <td>WMDM_CONTENT_FILE</td> <td>The content being inserted is a file.</td> </tr> <tr>
    ///             <td>-</td> <td>WMDM_CONTENT_FOLDER</td> <td>The content being inserted is a folder. This will not transfer
    ///             the contents of the folder.</td> </tr> <tr> <td>Optional</td> <td>WMDM_CONTENT_OPERATIONINTERFACE</td>
    ///             <td>The application is passing in an <b>IWMDMOperation</b> interface to control data transfer.</td> </tr>
    ///             <tr> <td>Zero or more of:</td> <td>WMDM_FILE_ATTR_READONLY</td> <td>The storage should be set to read-only on
    ///             the device.</td> </tr> <tr> <td>-</td> <td>WMDM_FILE_ATTR_HIDDEN</td> <td>The storage should be set to hidden
    ///             on the device.</td> </tr> <tr> <td>-</td> <td>WMDM_FILE_ATTR_SYSTEM</td> <td>The storage should be set to
    ///             system on the device.</td> </tr> <tr> <td>Optional</td> <td>WMDM_MODE_PROGRESS</td> <td>The insertion is in
    ///             progress.</td> </tr> <tr> <td>Optional one of:</td> <td>WMDM_MODE_TRANSFER_PROTECTED</td> <td>The insertion
    ///             is in protected transfer mode.</td> </tr> <tr> <td>-</td> <td>WMDM_MODE_TRANSFER_UNPROTECTED</td> <td>The
    ///             insertion is in unprotected transfer mode.</td> </tr> </table>
    ///    fuType = One of the following types, specifying the current storage. <table> <tr> <th>Value </th> <th>Description
    ///             </th> </tr> <tr> <td>WMDM_FILE_ATTR_FILE</td> <td>The current storage is a file.</td> </tr> <tr>
    ///             <td>WMDM_FILE_ATTR_FOLDER</td> <td>The current storage is a folder.</td> </tr> </table>
    ///    pwszFileSource = Pointer to a wide-character, <b>null</b>-terminated string indicating where to find the content for the
    ///                     insert operation. This parameter must be <b>NULL</b> if WMDM_CONTENT_OPERATIONINTERFACE is specified in
    ///                     <i>fuMode</i>. This parameter can be <b>NULL</b> if a playlist or album is being created.
    ///    pwszFileDest = Optional name of file on the device. If not specified and the application passes an <b>IWMDMOperation</b>
    ///                   pointer to <i>pOperation</i>, Windows Media Device Manager will request a destination name by calling
    ///                   IWMDMOperation::GetObjectName. If not specified and the application does not use <i>pOperation</i>, the
    ///                   original file name and extension are used (without the path).
    ///    pOperation = Optional pointer to an IWMDMOperation interface, to control the transfer of content to a media device. If
    ///                 specified, <i>fuMode</i> must include the WMDM_CONTENT_OPERATIONINTERFACE flag. This parameter must be
    ///                 <b>NULL</b> if WMDM_CONTENT_FILE or WMDM_CONTENT_FOLDER is specified in <i>fuMode</i>.
    ///    pProgress = Optional pointer to an IWMDMProgress interface to report action progress back to the application. This
    ///                parameter can be <b>NULL</b>.
    ///    pMetaData = Optional pointer to a metadata object. Create a new metadata object by calling
    ///                IWMDMStorage3::CreateEmptyMetadataObject. This parameter allows an application to specify metadata (including
    ///                format) to set on the device during object creation on the device, which is more efficient than setting
    ///                metadata afterward. You must set the file format (specified by g_wszWMDMFormatCode). If you do not specify
    ///                the format code of a file when using this method, an MTP device will not show the file as present in its user
    ///                interface, and non-MTP devices will behave unpredictably.
    ///    pUnknown = Optional <b>IUnknown</b> pointer of any custom COM object to be passed to the secure content provider. This
    ///               makes it possible to pass custom information to a secure content provider if the application has sufficient
    ///               information about the secure content provider.
    ///    ppNewObject = Pointer to an <b>IWMDMStorage</b> interface that will contain the new content. The caller must release this
    ///                  interface when finished with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Insert3(uint fuMode, uint fuType, PWSTR pwszFileSource, PWSTR pwszFileDest, IWMDMOperation pOperation, 
                    IWMDMProgress pProgress, IWMDMMetaData pMetaData, IUnknown pUnknown, IWMDMStorage* ppNewObject);
}

///The <b>IWMDMObjectInfo</b> interface gets and sets information that controls how playable files on device are handled
///by the IWMDMDeviceControl interface. This interface is not intended for non-playable files. If the
///<b>IWMDMObjectInfo</b> interface is acquired from an IWMDMStorage interface that represents a non-playable file, or a
///folder or a root file system containing no playable files, E_INVALIDTYPE is returned from all of the methods.
@GUID("1DCB3A09-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMObjectInfo : IUnknown
{
    ///The <b>GetPlayLength</b> method retrieves the play length of the object in units appropriate to the format. This
    ///is the remaining length that the file can play, not its total length.
    ///Params:
    ///    pdwLength = Pointer to a <b>DWORD</b> specifying the remaining play length of the file, in milliseconds.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetPlayLength(uint* pdwLength);
    ///The <b>SetPlayLength</b> method sets the play length of the object, in units appropriate to the format. This is
    ///the maximum length that the object plays regardless of its actual length.
    ///Params:
    ///    dwLength = <b>DWORD</b> specifying the play length, in units appropriate to the format.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetPlayLength(uint dwLength);
    ///The <b>GetPlayOffset</b> method retrieves the play offset of the object, in units appropriate to the format. This
    ///is the starting point for the next invocation of <b>Play</b>.
    ///Params:
    ///    pdwOffset = Pointer to a <b>DWORD</b> specifying the play offset of the object, in units appropriate to the format.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetPlayOffset(uint* pdwOffset);
    ///The <b>SetPlayOffset</b> method sets the play offset of the object, in the units appropriate to the format. This
    ///specifies the starting point for the next invocation of <b>Play</b>.
    ///Params:
    ///    dwOffset = <b>DWORD</b> specifying the play offset, in units appropriate to the format.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetPlayOffset(uint dwOffset);
    ///The <b>GetTotalLength</b> method retrieves the total play length of the object, in units appropriate to the
    ///format. The value returned is the total length regardless of the current settings of the play length and offset.
    ///Params:
    ///    pdwLength = Pointer to a <b>DWORD</b> specifying the total length of the file, in units appropriate to the format.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalLength(uint* pdwLength);
    ///The <b>GetLastPlayPosition</b> method retrieves the last play position of the object. The object must be an audio
    ///file on the media device.
    ///Params:
    ///    pdwLastPos = Pointer to a <b>DWORD</b> specifying the last play position of the object, in milliseconds.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetLastPlayPosition(uint* pdwLastPos);
    ///The <b>GetLongestPlayPosition</b> method retrieves the longest play position of the file. The file must be an
    ///audio file on the media device.
    ///Params:
    ///    pdwLongestPos = Pointer to a <b>DWORD</b> specifying the longest play position of the object, in milliseconds.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetLongestPlayPosition(uint* pdwLongestPos);
}

///The <b>IWMDMRevoked</b> interface retrieves the URL from which updated components can be downloaded, if a transfer
///fails with a revocation error. The secured content provider determines whether or not to allow a transfer, based on
///the application certificates of the components involved. You can access the <b>IWMDMRevoked</b> interface by calling
///<b>QueryInterface</b> on the IWMDMStorageControl interface.
@GUID("EBECCEDB-88EE-4E55-B6A4-8D9F07D696AA")
interface IWMDMRevoked : IUnknown
{
    ///The <b>GetRevocationURL</b> method retrieves the URL from which updated components can be downloaded.
    ///Params:
    ///    ppwszRevocationURL = Pointer to a string containing a revocation URL. This buffer is created and freed by the caller.
    ///    pdwBufferLen = Size of the buffer holding the revocation URL.
    ///    pdwRevokedBitFlag = Pointer to a <b>DWORD</b> specifying information on what component(s) have been revoked. This should be one
    ///                        or more of the following values, combined using a bitwise <b>OR</b>. <table> <tr> <th>Flag </th>
    ///                        <th>Description </th> </tr> <tr> <td>WMDM_WMDM_REVOKED</td> <td>Windows Media Device Manager itself has been
    ///                        revoked.</td> </tr> <tr> <td>WMDM_APP_REVOKED</td> <td>The application has been revoked and needs to be
    ///                        updated before any DRM-protected content can be transferred.</td> </tr> <tr> <td>WMDM_SP_REVOKED</td> <td>The
    ///                        service provider has been revoked and needs to be updated before any DRM-protected content can be transferred
    ///                        to it.</td> </tr> <tr> <td>WMDM_SCP_REVOKED</td> <td>The secured content provider has been revoked and needs
    ///                        to be updated before any DRM-protected content can be transferred.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetRevocationURL(PWSTR* ppwszRevocationURL, uint* pdwBufferLen, uint* pdwRevokedBitFlag);
}

///The optional, application-implemented <b>IWMDMNotification</b> interface allows applications and service providers to
///receive notifications when either devices or memory storages (such as RAM cards) are connected or disconnected from
///the computer. <div class="alert"><b>Note</b> This method will be called only for registered Plug and Play devices.
///Other device arrivals or departures will not cause this interface to be called.</div> <div> </div> This interface
///GUID is not properly defined in mssachlp.lib; therefore, you must #include both mswmdm.h and mswmdm_i.c (from
///wmdm.idl) if implementing this interface, to get the proper definitions.
@GUID("3F5E95C0-0F43-4ED4-93D2-C89A45D59B81")
interface IWMDMNotification : IUnknown
{
    ///The <b>WMDMMessage</b> method is a callback method implemented by a client, and called by Windows Media Device
    ///Manager when a Plug and Play compliant device or storage medium is connected or removed.
    ///Params:
    ///    dwMessageType = A <b>DWORD</b> specifying the message type. The possible values for the event types are the following:
    ///                    <table> <tr> <th>Message type </th> <th>Description </th> </tr> <tr> <td>WMDM_MSG_DEVICE_ARRIVAL</td> <td>A
    ///                    device has been connected.</td> </tr> <tr> <td>WMDM_MSG_DEVICE_REMOVAL</td> <td>A device has been
    ///                    removed.</td> </tr> <tr> <td>WMDM_MSG_MEDIA_ARRIVAL</td> <td>A storage medium has been inserted in a
    ///                    connected device.</td> </tr> <tr> <td>WMDM_MSG_MEDIA_REMOVAL</td> <td>A storage medium has been removed from
    ///                    a connected device.</td> </tr> </table>
    ///    pwszCanonicalName = Pointer to a wide-character, null-terminated string specifying the canonical name of the device for which
    ///                        this event is generated. The application does not release this value.
    ///Returns:
    ///    The return value is an <b>HRESULT</b> in which application can return results of its processing of the
    ///    message. The return value is ignored by WMDM.
    ///    
    HRESULT WMDMMessage(uint dwMessageType, const(PWSTR) pwszCanonicalName);
}

///The <b>IMDServiceProvider</b> interface is the initial interface that Windows Media Device Manager uses to connect to
///your service provider. Using this interface, Windows Media Device Manager can enumerate and communicate with the all
///media devices supported by a particular service provider. The IMDServiceProvider2 interface can be implemented to
///create devices by using the device path.
@GUID("1DCB3A10-33ED-11D3-8470-00C04F79DBC0")
interface IMDServiceProvider : IUnknown
{
    ///The <b>GetDeviceCount</b> method returns the number of installed physical or software devices that are currently
    ///attached and are known by the service provider.
    ///Params:
    ///    pdwCount = Pointer to a <b>DWORD</b> containing the count of known devices.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetDeviceCount(uint* pdwCount);
    ///The <b>EnumDevices</b> method enumerates the installed physical or software devices that are currently attached
    ///and are known by the service provider.
    ///Params:
    ///    ppEnumDevice = Pointer to an IMDSPEnumDevice interface. If the service provider implements
    ///                   IMDServiceProvider2::CreateDevice, this enumerator should only enumerate non-Plug and Play devices.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EnumDevices(IMDSPEnumDevice* ppEnumDevice);
}

///The <b>IMDServiceProvider2</b> interface extends the IMDServiceProvider interface by providing a way of obtaining
///IMDSPDevice object(s) for a given device path name. The device path name comes from the Plug and Play (PnP)
///subsystem.
@GUID("B2FA24B7-CDA3-4694-9862-413AE1A34819")
interface IMDServiceProvider2 : IMDServiceProvider
{
    ///The <b>CreateDevice</b> method is called by the Windows Media Device Manager to get the <b>IMDSPDevice</b>
    ///object(s) corresponding to the canonical device obtained from the PnP subsystem. This method must be implemented
    ///for PnP and Windows Explorer support, but otherwise it is optional. For more information, see Mandatory and
    ///Optional Interfaces.
    ///Params:
    ///    pwszDevicePath = Pointer to a wide-character null-terminated string containing the device path of the device detected by
    ///                     Windows Media Device Manager. This name is obtained from the PnP subsystem, and is the canonical name plus "$
    ///                     <i>
    ///    pdwCount = Pointer to a <b>DWORD</b> containing the number of <b>IMDSPDevice</b> objects that are created.
    ///    pppDeviceArray = An array of IMDSPDevice interfaces representing the devices. Typically, there is only one array element, but
    ///                     a service provider can create more than one <b>IMDSPDevice</b> object corresponding to a device path name if
    ///                     it creates an <b>IMDSPDevice</b> object for each top-level storage. This is subject to change in the future,
    ///                     and the count may be restricted to 1.
    ///Returns:
    ///    If the method succeeds it returns S_OK. If the method fails, it returns the Windows Media Device Manager
    ///    error codes.
    ///    
    HRESULT CreateDevice(const(PWSTR) pwszDevicePath, uint* pdwCount, IMDSPDevice** pppDeviceArray);
}

///The <b>IMDServiceProvider3</b> interface extends the IMDServiceProvider2 interface by providing a method for setting
///the device enumeration preferences.
@GUID("4ED13EF3-A971-4D19-9F51-0E1826B2DA57")
interface IMDServiceProvider3 : IMDServiceProvider2
{
    ///The <b>SetDeviceEnumPreference</b> method sets the device enumeration preferences.
    ///Params:
    ///    dwEnumPref = Contains a bitwise <b>OR</b> combination of one or more of the following bit values that specify enumeration
    ///                 preference. Each set bit enables the corresponding extended behavior, whereas the absence of that bit
    ///                 disables the extended behavior and specifies the default, backward-compatible enumeration behavior. The
    ///                 possible values for <i>dwEnumPref</i> are provided in the following table. <table> <tr> <th>Value </th>
    ///                 <th>Description </th> </tr> <tr> <td>DO_NOT_VIRTUALIZE_STORAGES_AS_DEVICES</td> <td>By default, for devices
    ///                 containing multiple storage media, each of these storages enumerates as a separate pseudo-device. However,
    ///                 when this bit is set, storages are not visible as devices, and only devices are visible as devices.</td>
    ///                 </tr> <tr> <td>ALLOW_OUTOFBAND_NOTIFICATION</td> <td>By default, the IWMDMNotification callback mechanism
    ///                 provides applications with device arrival and removal events. When this bit is set, the service provider is
    ///                 free to notify the application by a separate mechanism, such as by using a window message. This behavior is
    ///                 in addition to the Windows Media Device Manager notifications. This flag does not suppress Windows Media
    ///                 Device Manager notifications.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwEnumPref</i> parameter contains an
    ///    unsupported bit value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_CALL_OUT_OF_SEQUENCE</b></dt>
    ///    </dl> </td> <td width="60%"> The method was called after an enumeration operation. It must be called before
    ///    the enumeration operation. </td> </tr> </table>
    ///    
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

///The <b>IMDSPEnumDevice</b> interface is used to enumerate the media devices. For more information on enumeration, see
///the Microsoft COM documentation on the COM page at the Microsoft Web site. The <b>IMDSPEnumDevice</b> interface is
///implemented on the device enumerator object. The only valid way to create a device enumerator object is to call
///IMDServiceProvider::EnumDevices. If the device implements IMDServiceProvider2::CreateDevice, this enumerator should
///enumerate only non-Plug and Play devices. The device enumerator should enumerate only the devices that are attached
///to the computer and are supported by the service provider.
@GUID("1DCB3A11-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPEnumDevice : IUnknown
{
    ///The <b>Next</b> method retrieves a pointer to the next <i>celt</i>IMDSPDevice interfaces.
    ///Params:
    ///    celt = Number of devices requested.
    ///    ppDevice = Array of <i>celt</i> pointers IMDSPDevice allocated by the caller. Return <b>NULL</b> to indicate that no
    ///               more devices exist or an error has occurred. If <i>celt</i> is more than 1, the caller must allocate enough
    ///               memory to store <i>celt</i> number of interface pointers.
    ///    pceltFetched = Pointer to a <b>ULONG</b> variable that receives the number of interfaces retrieved.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Next(uint celt, IMDSPDevice* ppDevice, uint* pceltFetched);
    ///The <b>Skip</b> method skips over the next specified number of media device interface(s) in the enumeration
    ///sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///    pceltFetched = Pointer to the number of elements that actually were skipped.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Skip(uint celt, uint* pceltFetched);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning. A subsequent call to <b>Next</b>
    ///fetches the first Windows Media Device Manager interface in the enumeration sequence.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method creates another enumerator that contains the same enumeration state as the current one.
    ///Params:
    ///    ppEnumDevice = Pointer to an IMDSPEnumDevice interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Clone(IMDSPEnumDevice* ppEnumDevice);
}

///The <b>IMDSPDevice</b> interface provides an instance-based association with a media device. Using this interface,
///the client can get a storage media enumerator for the device, get information about the device, and send opaque
///(pass-through) commands to the device. IMDServiceProvider2 extends <b>IMDSPDevice</b> by providing methods for
///getting video formats, getting Plug and Play (PnP) device names, enabling the use of property pages, and making it
///possible to get a pointer to a storage medium from its name. This interface is optional for the service provider but
///is recommended.
@GUID("1DCB3A12-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPDevice : IUnknown
{
    ///The <b>GetName</b> method retrieves the name of the device.
    ///Params:
    ///    pwszName = Pointer to an array of 16-bit Unicode characters that receives the device name string.
    ///    nMaxChars = Maximum number of characters to copy to the string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    ///The <b>GetManufacturer</b> method retrieves the name of the manufacturer of the device.
    ///Params:
    ///    pwszName = Pointer to a caller-allocated wide character array that receives the manufacturer name string.
    ///    nMaxChars = Maximum number of characters to copy to the string, including the termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetManufacturer(PWSTR pwszName, uint nMaxChars);
    ///The <b>GetVersion</b> method retrieves the version number of the device.
    ///Params:
    ///    pdwVersion = Pointer to a <b>DWORD</b> to receive the version number of the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetVersion(uint* pdwVersion);
    ///The <b>GetType</b> method retrieves device type information.
    ///Params:
    ///    pdwType = Pointer to a <b>DWORD</b> that receives the type attributes of the device. The following table shows the
    ///              types received. <table> <tr> <th>Device type </th> <th>Description </th> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_PLAYBACK</td> <td>The media device supports audio playback.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_RECORD</td> <td>The media device supports audio recording.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_DECODE</td> <td>The media device supports audio format decoding.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_ENCODE</td> <td>The media device supports audio format encoding.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_STORAGE</td> <td>The media device has on-board storage for media files.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_SDMI</td> <td>The media device is SDMI compliant.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_NONSDMI</td> <td>The media device is not SDMI compliant.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_VIRTUAL</td> <td>The media device is not a physical device.</td> </tr> <tr>
    ///              <td>WMDM_DEVICE_TYPE_NONREENTRANT</td> <td>The media device must synchronize access to the service provider
    ///              services.</td> </tr> <tr> <td>WMDM_DEVICE_TYPE_FILELISTRESYNC</td> <td>The media device allows the file list
    ///              to be resynchronized.</td> </tr> <tr> <td>WMDM_DEVICE_TYPE_VIEW_PREF_METADATAVIEW</td> <td>The media device
    ///              prefers metadata views while its storages are enumerated.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetType(uint* pdwType);
    ///The <b>GetSerialNumber</b> method retrieves the serial number that uniquely identifies the device.
    ///Params:
    ///    pSerialNumber = Pointer to a <b>WMDMID</b> structure that receives the serial number for the device. This parameter is
    ///                    included in the output message authentication code.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSerialNumber(__WMDMID* pSerialNumber, ubyte* abMac);
    ///The <b>GetPowerSource</b> method reports whether the device is capable of running on batteries, external power,
    ///or both, and on which type of power source it is currently running. If the device is running on batteries, this
    ///method also reports the percentage of total power remaining in the batteries.
    ///Params:
    ///    pdwPowerSource = Pointer to a <b>DWORD</b> that receives a value indicating the current power source for the device. The value
    ///                     is one of the following flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///                     <td>WMDM_POWER_CAP_BATTERY</td> <td>The media device can run on batteries.</td> </tr> <tr>
    ///                     <td>WMDM_POWER_CAP_EXTERNAL</td> <td>The media device can run on external power.</td> </tr> <tr>
    ///                     <td>WMDM_POWER_IS_BATTERY</td> <td>The media device is currently running on batteries.</td> </tr> <tr>
    ///                     <td>WMDM_POWER_IS_EXTERNAL</td> <td>The media device is currently running on external power.</td> </tr> <tr>
    ///                     <td>WMDM_POWER_PERCENT_AVAILABLE</td> <td>The percentage of power remaining was returned in
    ///                     <i>pdwPercentRemaining</i>.</td> </tr> </table>
    ///    pdwPercentRemaining = If the device is running on batteries, <i>pdwPercentRemaining</i> specifies a pointer to a <b>DWORD</b>
    ///                          containing the percentage of total battery power remaining.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetPowerSource(uint* pdwPowerSource, uint* pdwPercentRemaining);
    ///The <b>GetStatus</b> method retrieves all the device status information that the device can provide.
    ///Params:
    ///    pdwStatus = Pointer to a <b>DWORD</b> that receives the current device status. These status values are defined in the
    ///                following table. <table> <tr> <th>Status </th> <th>Description </th> </tr> <tr> <td>WMDM_STATUS_READY</td>
    ///                <td>Windows Media Device Manager and its subcomponents are in a ready state.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_BUSY</td> <td>An operation is ongoing. Check other status values to determine which operation
    ///                it is.</td> </tr> <tr> <td>WMDM_STATUS_DEVICE_NOTPRESENT</td> <td>The device is not connected to the
    ///                computer.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_NOTPRESENT</td> <td>The medium is not present. For devices
    ///                that support more than one medium, this value is reported only from the IWMDMStorageGlobals interface.</td>
    ///                </tr> <tr> <td>WMDM_STATUS_STORAGE_INITIALIZING</td> <td>The device is currently busy formatting media on the
    ///                device.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_BROKEN</td> <td>The medium is not working. For devices that
    ///                support more than one medium, this value is reported only from the <b>IWMDMStorageGlobals</b> interface.</td>
    ///                </tr> <tr> <td>WMDM_STATUS_STORAGE_NOTSUPPORTED</td> <td>The medium is not supported by the device. For
    ///                devices that support more than one medium, this value is returned only from the <b>IWMDMStorageGlobals</b>
    ///                interface.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_UNFORMATTED</td> <td>The medium is not formatted. For
    ///                devices that support more than one medium, this value is returned only from the <b>IWMDMStorageGlobals</b>
    ///                interface.</td> </tr> <tr> <td>WMDM_STATUS_STORAGECONTROL_INSERTING</td> <td>The IWMDMStorageControl::Insert
    ///                method is currently running.</td> </tr> <tr> <td>WMDM_STATUS_STORAGECONTROL_DELETING</td> <td>The
    ///                IWMDMStorageControl::Delete method is currently running.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_STORAGECONTROL_MOVING</td> <td>The IWMDMStorageControl::Move method is currently
    ///                running.</td> </tr> <tr> <td>WMDM_STATUS_STORAGECONTROL_READING</td> <td>The IWMDMStorageControl::Read method
    ///                is currently running.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStatus(uint* pdwStatus);
    ///The <b>GetDeviceIcon</b> method returns a <b>HICON</b> that represents the icon that the device service provider
    ///indicates must be used to represent this device.
    ///Params:
    ///    hIcon = Handle to an <b>Icon</b> object that receives the icon for the device. Before using it, the caller must cast
    ///            the value to a <b>HICON</b>*. When an application is finished with the icon, it should call
    ///            <b>DestroyIcon</b> to free the resource. <b>DestroyIcon</b> is a standard Win32 function.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetDeviceIcon(uint* hIcon);
    ///The <b>EnumStorage</b> method retrieves a pointer to an <b>IMDSPEnumStorage</b> interface of an enumerator object
    ///that represents the top-level storage(s) on the device. Top-level storage for a device is the root directory of
    ///the storage medium.
    ///Params:
    ///    ppEnumStorage = Pointer to an IMDSPEnumStorage object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EnumStorage(IMDSPEnumStorage* ppEnumStorage);
    ///The <b>GetFormatSupport</b> method retrieves all the formats supported by the device. The format information
    ///includes codecs, file formats, and digital rights management schemes.
    ///Params:
    ///    pFormatEx = Pointer to an array of _WAVEFORMATEX structures containing information about codecs and bit rates supported
    ///                by the device.
    ///    pnFormatCount = Pointer to the number of elements in the <i>pFormatEx</i> array.
    ///    pppwszMimeType = Pointer to an array that describes file formats and digital rights management schemes supported by the
    ///                     device.
    ///    pnMimeTypeCount = Pointer to the number of elements in the <i>pppwszMimeType</i> array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetFormatSupport(_tWAVEFORMATEX** pFormatEx, uint* pnFormatCount, PWSTR** pppwszMimeType, 
                             uint* pnMimeTypeCount);
    ///The <b>SendOpaqueCommand</b> method sends a command through Windows Media Device Manager. Without acting on it,
    ///Windows Media Device Manager passes the command through to a device.
    ///Params:
    ///    pCommand = Pointer to an OPAQUECOMMAND structure containing the information required to execute the command.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

///The <b>IMDSPDevice2</b> interface extends IMDSPDevice by getting extended formats, getting Plug and Play (PnP) device
///names, enabling the use of property pages, and making it possible to get a pointer to a storage medium from its name.
@GUID("420D16AD-C97D-4E00-82AA-00E9F4335DDD")
interface IMDSPDevice2 : IMDSPDevice
{
    ///The <b>GetStorage</b> method makes it possible to go directly to a storage based on its name instead of
    ///enumerating through all storages to find it.
    ///Params:
    ///    pszStorageName = Pointer to a null-terminated string containing the name of the storage to find.
    ///    ppStorage = Pointer to the storage object specified by the <i>pszStorageName</i> parameter.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStorage(const(PWSTR) pszStorageName, IMDSPStorage* ppStorage);
    ///The <b>GetFormatSupport2</b> method gets the formats supported by a device, including audio and video codecs, and
    ///MIME file formats.
    ///Params:
    ///    dwFlags = <b>DWORD</b> containing audio formats, video formats, and MIME types. This flag specifies what the
    ///              application is requesting the service provider to fill in. The caller can set one or more of the following
    ///              three values. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr>
    ///              <td>WMDM_GET_FORMAT_SUPPORT_AUDIO</td> <td>Service provider should fill in audio parameters.</td> </tr> <tr>
    ///              <td>WMDM_GET_FORMAT_SUPPORT_VIDEO</td> <td>Service provider should fill in video parameters.</td> </tr> <tr>
    ///              <td>WMDM_GET_FORMAT_SUPPORT_FILE</td> <td>Service provider should fill in file parameters.</td> </tr>
    ///              </table>
    ///    ppAudioFormatEx = Pointer to an array of _WAVEFORMATEX structures containing information about audio codecs and bit rates
    ///                      supported by the device.
    ///    pnAudioFormatCount = Pointer to an integer containing the audio format count.
    ///    ppVideoFormatEx = Pointer to an array of _VIDEOINFOHEADER structures containing information about video codecs and formats
    ///                      supported by the device.
    ///    pnVideoFormatCount = Pointer to an integer containing the video format count.
    ///    ppFileType = Pointer to an array of WMFILECAPABILITIES structures containing information about file types supported by the
    ///                 device.
    ///    pnFileTypeCount = Pointer to an integer containing the file format count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetFormatSupport2(uint dwFlags, _tWAVEFORMATEX** ppAudioFormatEx, uint* pnAudioFormatCount, 
                              _tagVIDEOINFOHEADER** ppVideoFormatEx, uint* pnVideoFormatCount, 
                              WMFILECAPABILITIES** ppFileType, uint* pnFileTypeCount);
    ///The <b>GetSpecifyPropertyPages</b> method gets property pages describing non-standard capabilities of portable
    ///devices.
    ///Params:
    ///    ppSpecifyPropPages = Pointer to a Win32 <b>ISpecifyPropertyPages</b> interface pointer.
    ///    pppUnknowns = Array of <b>IUnknown</b> interface pointers. These interfaces will be passed to the property page and can be
    ///                  used to pass information between the property page and the service provider.
    ///    pcUnks = Size of the <i>pppUnknowns</i> array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, IUnknown** pppUnknowns, 
                                    uint* pcUnks);
    ///The <b>GetCanonicalPName</b> method gets the canonical name of a device.
    ///Params:
    ///    pwszPnPName = A wide character, null-terminated buffer holding the canonical name. The caller allocates and releases this
    ///                  buffer.
    ///    nMaxChars = Integer containing the maximum number of characters that can be placed in <i>pwszCanonicalName</i>, including
    ///                the termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table.
    ///    
    HRESULT GetCanonicalName(PWSTR pwszPnPName, uint nMaxChars);
}

///The <b>IMDSPDevice3</b> interface must be supported for devices that expect to synchronize with Windows Media Player.
///For more information, see Enabling Synchronization with Windows Media Player. The <b>IMDSPDevice3</b> interface
///extends IMDSPDevice2 by providing ability to query properties and capabilities of the device with regard to an object
///format. <div class="alert"><b>Note</b> Unless the service provider has added the device parameter
///<i>UseExtendedWmdm</i> with a value of 1, Windows Media Device Manager will not call this interface. See Device
///Parameters for more information about this.</div> <div> </div>
@GUID("1A839845-FC55-487C-976F-EE38AC0E8C4E")
interface IMDSPDevice3 : IMDSPDevice2
{
    ///The <b>GetProperty</b> method retrieves a specific device property.
    ///Params:
    ///    pwszPropName = Name of property being retrieved from the device.
    ///    pValue = Returned value for the property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetProperty(const(PWSTR) pwszPropName, PROPVARIANT* pValue);
    ///The <b>SetProperty</b> method sets a specific device property that is writable.
    ///Params:
    ///    pwszPropName = Name of device property being set.
    ///    pValue = Value of device property being set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetProperty(const(PWSTR) pwszPropName, const(PROPVARIANT)* pValue);
    ///The <b>GetFormatCapability</b> method retrieves information from a device about the values or ranges of values
    ///supported by the device for each aspect of a particular object format.
    ///Params:
    ///    format = WMDM_FORMATCODE Enumerated value representing inquired format.
    ///    pFormatSupport = Returned WMDM_FORMAT_CAPABILITY structure containing the values or ranges of values supported for each aspect
    ///                     of a particular object format.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    ///The <b>DeviceIoControl</b> method calls the device I/O control.
    ///Params:
    ///    dwIoControlCode = I/O control code being sent to the device.
    ///    lpInBuffer = Input buffer supplied by the calling application. This can be <b>NULL</b> if <i>nInBufferSize</i> is zero.
    ///    nInBufferSize = Size of <i>lpInBuffer</i>, in bytes.
    ///    lpOutBuffer = Output buffer, supplied by the calling application.
    ///    pnOutBufferSize = Size of <i>lpOutBuffer</i>, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT DeviceIoControl(uint dwIoControlCode, ubyte* lpInBuffer, uint nInBufferSize, ubyte* lpOutBuffer, 
                            uint* pnOutBufferSize);
    ///The <b>FindStorage</b> method finds a storage with the given persistent unique identifier. The persistent unique
    ///identifier of a storage is described by the <b>g_wszWMDMPersistentUniqueID</b> property of that storage.
    ///Params:
    ///    findScope = Scope of the find operation. It must be one of the following values. <table> <tr> <th>Value </th>
    ///                <th>Description </th> </tr> <tr> <td>WMDM_FIND_SCOPE_GLOBAL</td> <td>Search the whole device.</td> </tr> <tr>
    ///                <td>WMDM_FIND_SCOPE_IMMEDIATE_CHILDREN</td> <td>Search only in the immediate children of the current
    ///                storage.</td> </tr> </table>
    ///    pwszUniqueID = Persistent unique identifier of the storage.
    ///    ppStorage = Pointer to the returned storage specified by the <i>pwszUniqueID</i> parameter.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IMDSPStorage* ppStorage);
}

///The <b>IMDSPDeviceControl</b> interface provides methods for controlling devices. After this interface is acquired
///from a specific instance of the <b>IMDSPDevice</b> interface, the control methods are used for remote control of
///streaming audio play, record, pause, stop, and seek operations on that device. Implementing this interface is
///optional. For more information, see Mandatory and Optional Interfaces. The <b>IMDSPDeviceControl</b> interface
///methods support several modes of audio control, depending on the context in which they are used. That context is
///defined by the <b>Seek</b> method. The <b>GetCapabilities</b> method is used to determine what kinds of operations
///can be performed by the device.
@GUID("1DCB3A14-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPDeviceControl : IUnknown
{
    ///The <b>GetDCStatus</b> method retrieves the control status of the device.
    ///Params:
    ///    pdwStatus = Pointer to a <b>DWORD</b> that contains the control status of the device. The control status value contains
    ///                one or more of the following flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///                <td>WMDM_STATUS_READY</td> <td>Windows Media Device Manager and its subcomponents are in a ready state.</td>
    ///                </tr> <tr> <td>WMDM_STATUS_BUSY</td> <td>An operation is currently being performed. Evaluate the other status
    ///                values to determine which operation it is.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_PLAYING</td> <td>The
    ///                device is currently playing.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_RECORDING</td> <td>The device is
    ///                currently recording.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_PAUSED</td> <td>The device is currently
    ///                paused.</td> </tr> <tr> <td>WMDM_STATUS_DEVICECONTROL_REMOTE</td> <td>The play or record operation of the
    ///                device is being remotely controlled by the application.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_DEVICECONTROL_STREAM</td> <td>The play or record method is streaming data to or from the
    ///                media device.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pdwStatus</i> parameter is an invalid
    ///    or <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetDCStatus(uint* pdwStatus);
    ///The <b>GetCapabilities</b> method retrieves the capabilities mask for the device with which this control
    ///interface is associated. The capabilities describe the methods of the device control that are supported by the
    ///media device.
    ///Params:
    ///    pdwCapabilitiesMask = Pointer to a <b>DWORD</b> containing the capabilities of the device. The following flags can be returned in
    ///                          this variable. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr> <td>MDM_DEVICECAP_CANPLAY</td>
    ///                          <td>The media device can play MP3 audio.</td> </tr> <tr> <td>MDM_DEVICECAP_CANSTREAMPLAY</td> <td>The media
    ///                          device can play streaming audio directly from the host computer.</td> </tr> <tr>
    ///                          <td>MDM_DEVICECAP_CANRECORD</td> <td>The media device can record audio.</td> </tr> <tr>
    ///                          <td>MDM_DEVICECAP_CANSTREAMRECORD</td> <td>The media device can record streaming audio directly to the host
    ///                          computer.</td> </tr> <tr> <td>MDM_DEVICECAP_CANPAUSE</td> <td>The media device can pause during play or
    ///                          record operations.</td> </tr> <tr> <td>MDM_DEVICECAP_CANRESUME</td> <td>The media device can resume an
    ///                          operation from a pause command.</td> </tr> <tr> <td>MDM_DEVICECAP_CANSTOP</td> <td>The media device can stop
    ///                          playing before the end of a file.</td> </tr> <tr> <td>MDM_DEVICECAP_CANSEEK</td> <td>The media device can
    ///                          seek to a position other than the beginning of a file.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pdwCapabilitiesMask</i> parameter is an
    ///    invalid or <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetCapabilities(uint* pdwCapabilitiesMask);
    ///The <b>Play</b> method begins playing at the current seek position. If the Seek method has not been called, then
    ///playing begins at the beginning of the first file, and the play length is not defined.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_BUSY</b></dt> </dl> </td> <td width="60%"> The device is busy. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The play function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Play();
    ///The <b>Record</b> method begins recording from the device's external record input at the current seek position.
    ///The Seek method must be called first.
    ///Params:
    ///    pFormat = Pointer to a _WAVEFORMATEX structure containing the format in which the data must be recorded.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_BUSY</b></dt> </dl> </td> <td width="60%"> The device is already performing an operation. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The record
    ///    function is not implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Record(_tWAVEFORMATEX* pFormat);
    ///The <b>Pause</b> method pauses the current play or record session at the current position within the content.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The device is already paused. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The pause function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Pause();
    ///The <b>Resume</b> method resumes the current playback or record operation from the file position saved during the
    ///call to Pause.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The device is not paused. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The resume function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Resume();
    ///The <b>Stop</b> method stops the current stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_BUSY</b></dt> </dl> </td> <td width="60%"> The device is busy. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The stop function is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Stop();
    ///The <b>Seek</b> method seeks to a position that is used as the starting point by the Play or Record methods.
    ///Params:
    ///    fuMode = Mode for the seek operation being performed. The <i>fuMode</i> parameter must be one of the following modes.
    ///             <table> <tr> <th>Mode </th> <th>Description </th> </tr> <tr> <td>MDSP_SEEK_BOF</td> <td>Seek to a position
    ///             that is <i>nOffset</i> units after the beginning of the file.</td> </tr> <tr> <td>MDSP_SEEK_CUR</td> <td>Seek
    ///             to a position that is <i>nOffset</i> units from the current position.</td> </tr> <tr> <td>MDSP_SEEK_EOF</td>
    ///             <td>Seek to a position that is <i>nOffset</i> units before the end of the file.</td> </tr> </table>
    ///    nOffset = Number of units by which the seek operation moves the starting position away from the origin specified by
    ///              <i>fuMode</i>. The units of <i>nOffset</i> are defined by the content. They can be milliseconds for music,
    ///              pages for electronic books, and so on. A positive value for <i>nOffset</i> indicates seeking forward through
    ///              the file. A negative value indicates seeking backward through the file. Any combination of <i>nOffset</i> and
    ///              <i>fuMode</i> that indicates seeking to a position before the beginning of the file or after the end of the
    ///              file is not valid, and causes the method to return E_INVALIDARG.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> Seek is not
    ///    implemented on this device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Seek(uint fuMode, int nOffset);
}

///The <b>IMDSPEnumStorage</b> interface is used to enumerate the storage media on a device. For more information on the
///standard implementation of enumeration interfaces, see the Microsoft COM documentation, available at the Microsoft
///Web site. The storage media on a device are organized in a hierarchical manner similar to disk drives on a computer.
///When accessed from the IMDSPDevice::EnumStorage method, this interface enumerates the individual storage media on the
///device in the same way that you would see the individual disk drives on a computer. When accessed from the
///IWMDMStorage::EnumStorage method, this interface enumerates the contents of the storage medium. <b>EnumStorage</b>
///can be called on the enumerated storage objects recursively, and thus the contents of a storage medium are returned
///in the hierarchical fashion in which they are stored on the storage medium. If the file system of the storage medium
///supports a notion of order among the content, the enumerator will return the contents in the same order. The storage
///enumerator returns a snapshot of the state of storages. It may not reflect the effect of storage media insertion and
///removal and may not reflect the effects of subsequent <b>Insert</b>, <b>Move</b> and <b>Delete</b> methods. The
///client should obtain a new enumerator to get the new state of the storage media. The <b>Insert</b>, <b>Move</b>, and
///<b>Delete</b> methods of the IWMDMStorageControl interface change the order of files. If these operations are
///invoked, then the order of objects as originally returned by the <b>IMDSPEnumStorage</b> interface can be changed. If
///an application is going to display the order of content on a media device, the application programmer must take into
///account order changes that can occur as a result of <b>IWMDMStorageControl</b> operations. There are two ways to deal
///with this situation. One way is to simply re-enumerate whenever a change to content occurs. Another way is to
///maintain the order of <b>IWMDMStorage</b> objects programmatically. No matter how this issue is handled, it must be
///handled by the application if the order of files is important to the application.
@GUID("1DCB3A15-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPEnumStorage : IUnknown
{
    ///The <b>Next</b> method returns a pointer to the next <i>celt</i>IMDSPStorage interfaces.
    ///Params:
    ///    celt = Number of storage interfaces requested.
    ///    ppStorage = Array of <i>celt</i>IMDSPStorage interface pointers allocated by the caller. Return <b>NULL</b> if no more
    ///                storage media exist, or an error has occurred. If <i>celt</i> is more than 1, the caller must allocate enough
    ///                memory to store <i>celt</i> number of interface pointers.
    ///    pceltFetched = Pointer to a <b>ULONG</b> variable that receives the count of interfaces returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Next(uint celt, IMDSPStorage* ppStorage, uint* pceltFetched);
    ///The <b>Skip</b> method skips over the next specified number of storage interface(s) in the enumeration sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///    pceltFetched = Pointer to the number of elements actually skipped.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Skip(uint celt, uint* pceltFetched);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning. A subsequent call to the <b>Next</b>
    ///method fetches the first storage interface in the enumeration sequence.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method creates another enumerator that contains the same enumeration state as the current one.
    ///Params:
    ///    ppEnumStorage = Pointer to an IMDSPEnumStorage interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Clone(IMDSPEnumStorage* ppEnumStorage);
}

///The <b>IMDSPStorage</b> interface provides an instanced-based association with a storage medium on a device. An
///<b>IMDSPStorage</b> interface can represent the entire storage medium, or can be further enumerated to represent any
///object, such as a folder or file, on that medium. This reiterative enumeration provides the mechanism for describing
///the organization of a hierarchically structured storage medium. The methods of <b>IMDSPStorage</b> can be used to
///gather information about the object that the interface represents. The IMDSPStorage2 interface extends
///<b>IMDSPStorage</b> by getting and setting extended attributes and making it possible to get a pointer to a storage
///medium from its name.
@GUID("1DCB3A16-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPStorage : IUnknown
{
    ///The <b>SetAttributes</b> method sets the attributes of a storage object.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> containing the attributes to be set as defined in the <b>IWMDMStorage::SetAttributes</b> method.
    ///    pFormat = Pointer to a <b>_WAVEFORMATEX</b> structure that contains attribute information about the object. This
    ///              parameter is optional and is ignored if the file is not audio.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetAttributes(uint dwAttributes, _tWAVEFORMATEX* pFormat);
    ///The <b>GetStorageGlobals</b> method retrieves the <b>IMDSPStorageGlobals</b> interface to provide access to
    ///global information about a storage medium.
    ///Params:
    ///    ppStorageGlobals = Pointer to an <b>IMDSPStorageGlobals</b> interface that can provide access to global information about a
    ///                       storage medium.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStorageGlobals(IMDSPStorageGlobals* ppStorageGlobals);
    ///The <b>GetAttributes</b> method retrieves the attributes of this storage object.
    ///Params:
    ///    pdwAttributes = Pointer to a <b>DWORD</b> containing the attributes as defined by in the <b>IWMDMStorage::GetAttributes</b>
    ///                    method.
    ///    pFormat = Pointer to a <b>_WAVEFORMATEX</b> structure that is filled with attribute information about the object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetAttributes(uint* pdwAttributes, _tWAVEFORMATEX* pFormat);
    ///The <b>GetName</b> method retrieves the display name of the storage object.
    ///Params:
    ///    pwszName = Pointer to a (Unicode) wide-character null-terminated string containing the object name.
    ///    nMaxChars = Integer containing the maximum number of characters that can be copied to the name string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    ///The <b>GetDate</b> method retrieves the date on which the storage object (file or folder) was most recently
    ///modified.
    ///Params:
    ///    pDateTimeUTC = Pointer to a <b>WMDMDATETIME</b> structure containing the date on which the file or folder was most recently
    ///                   modified.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetDate(WMDMDATETIME* pDateTimeUTC);
    ///The <b>GetSize</b> method retrieves the size of the storage object, in bytes.
    ///Params:
    ///    pdwSizeLow = Pointer to a <b>DWORD</b> containing the low-order part of the storage object size.
    ///    pdwSizeHigh = Pointer to a <b>DWORD</b> containing the high-order part of the storage object size.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSize(uint* pdwSizeLow, uint* pdwSizeHigh);
    ///The <b>GetRights</b> method retrieves the rights information for an object.
    ///Params:
    ///    ppRights = Pointer to an array of <b>WMDMRIGHTS</b> structures that contain the storage object rights information. This
    ///               parameter is included in the output message authentication code.
    ///    pnRightsCount = Pointer to the number of <b>WMDMRIGHTS</b> structures in the <i>ppRights</i> array. This parameter is
    ///                    included in the output message authentication code.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetRights(__WMDMRIGHTS** ppRights, uint* pnRightsCount, ubyte* abMac);
    ///The <b>CreateStorage</b> method creates a new storage and returns a pointer to the <b>IMDSPStorage</b> interface
    ///on the newly created storage. This method is optional unless <i>dwAttributes</i> is WMDM_FILE_ATTR_FILE. In that
    ///case, this method must be implemented and must not return WMDM_E_NOTSUPPORTED or E_NOTIMPL. For more information,
    ///see Mandatory and Optional Interfaces.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> containing the attributes for the new storage. The following table lists the available storage
    ///                   attributes. <table> <tr> <th>Attribute </th> <th>Description </th> </tr> <tr>
    ///                   <td>WMDM_STORAGECONTROL_INSERTBEFORE</td> <td>The new storage object will be created in front of the target
    ///                   object.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTAFTER</td> <td>The new storage object will be created
    ///                   after the target object.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTINTO</td> <td>The new storage object
    ///                   will be created in the target object folder.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_OVERWRITE</td> <td>If
    ///                   storage with the same name already exists, it will be destroyed and a new storage created.</td> </tr> <tr>
    ///                   <td>WMDM_STORAGE_ATTR_FILESYSTEM</td> <td>This object is the top-level storage medium (for example, a storage
    ///                   card or some other on-board storage.)</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_REMOVABLE</td> <td>This storage
    ///                   medium is removable.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_CANEDITMETADATA</td> <td>This storage can edit
    ///                   metadata.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_FOLDERS</td> <td>This storage medium supports folders and
    ///                   file hierarchy.</td> </tr> <tr> <td>WMDM_FILE_ATTR_FOLDER</td> <td>This is a folder on the storage
    ///                   medium.</td> </tr> <tr> <td>WMDM_FILE_ATTR_LINK</td> <td>This is a link that creates an association among
    ///                   multiple files.</td> </tr> <tr> <td>WMDM_FILE_ATTR_FILE</td> <td>This is a file on the storage medium.</td>
    ///                   </tr> <tr> <td>WMDM_FILE_ATTR_AUDIO</td> <td>This file is audio data.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_DATA</td> <td>This file is non-audio data.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANPLAY</td>
    ///                   <td>This audio file can be played by the device.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANDELETE</td> <td>This
    ///                   file can be deleted.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANMOVE</td> <td>This file or folder can be moved
    ///                   around on the storage medium.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANRENAME</td> <td>This file or folder can
    ///                   be renamed.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANREAD</td> <td>This file can be read by the host
    ///                   computer.</td> </tr> <tr> <td>WMDM_FILE_ATTR_MUSIC</td> <td>This audio file is music.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_VIDEO</td> <td>This file contains video data.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_HIDDEN</td> <td>This file is hidden on the file system</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_SYSTEM</td> <td>This is a system file</td> </tr> <tr> <td>WMDM_FILE_ATTR_READONLY</td>
    ///                   <td>This is a read-only file.</td> </tr> <tr> <td>WMDM_STORAGE_IS_DEFAULT</td> <td>This storage is the
    ///                   default storage where new media should be placed.</td> </tr> <tr> <td>WMDM_STORAGE_CONTAINS_DEFAULT</td>
    ///                   <td>This storage contains the default storage where new media should be placed.</td> </tr> </table>
    ///    pFormat = Pointer to a <b>_WAVEFORMATEX</b> structure that contains information about the object, if the object is an
    ///              audio file.
    ///    pwszName = Pointer to a wide-character null-terminated string containing the name for the new storage.
    ///    ppNewStorage = Pointer to an <b>IMDSPStorage</b> pointer to receive the <b>IMDSPStorage</b> interface for the newly created
    ///                   storage.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT CreateStorage(uint dwAttributes, _tWAVEFORMATEX* pFormat, PWSTR pwszName, IMDSPStorage* ppNewStorage);
    ///The <b>EnumStorage</b> method accesses the <b>IMDSPEnumStorage</b> interface to enumerate the individual storage
    ///media on a device.
    ///Params:
    ///    ppEnumStorage = Pointer to an <b>IMDSPEnumStorage</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT EnumStorage(IMDSPEnumStorage* ppEnumStorage);
    ///The <b>SendOpaqueCommands</b> method sends a command through Windows Media Device Manager. Without acting on it,
    ///Windows Media Device Manager passes the command through to a device.
    ///Params:
    ///    pCommand = Pointer to an <b>OPAQUECOMMAND</b> structure containing the information required to execute the command.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

///The <b>IMDSPStorage2</b> interface extends IMDSPStorage by providing methods for getting and setting extended
///attributes and making it possible to get a pointer to a storage medium from its name. This interface also extends the
///<b>CreateStorage</b> method of the <b>IMDSPStorage</b> interface.
@GUID("0A5E07A5-6454-4451-9C36-1C6AE7E2B1D6")
interface IMDSPStorage2 : IMDSPStorage
{
    ///The <b>GetStorage</b> method makes it possible to go directly to a storage object from a storage name instead of
    ///enumerating through all storages to find it.
    ///Params:
    ///    pszStorageName = Pointer to a <b>null</b>-terminated string containing the storage name.
    ///    ppStorage = Pointer to the storage object specified by <i>pszStorageName</i>, or <b>NULL</b> if no such storage was
    ///                found.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStorage(const(PWSTR) pszStorageName, IMDSPStorage* ppStorage);
    ///The <b>CreateStorage2</b> method creates a new storage with the specified name and returns a pointer to the
    ///<b>IMDSPStorage</b> interface on the newly created storage.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> containing the attributes as described in the <b>IMDSPStorage::CreateStorage</b> method.
    ///    dwAttributesEx = <b>DWORD</b> containing the extended attributes. There are currently no extended attributes defined.
    ///    pAudioFormat = Pointer to a <b>_WAVEFORMATEX</b> structure that contains audio format information about the object. This
    ///                   parameter is optional and is ignored if the file is not audio.
    ///    pVideoFormat = Pointer to a <b>_VIDEOINFOHEADER</b> structure that contains video format information about the object. This
    ///                   parameter is optional and is ignored if the file is not video.
    ///    pwszName = Pointer to a wide-character null-terminated string containing the name for the new storage.
    ///    qwFileSize = <b>QWORD</b> containing the size of the file to create. If the total size of the output file is not known at
    ///                 the time of creation, this value will be set to zero.
    ///    ppNewStorage = Pointer to an <b>IMDSPStorage</b> pointer to receive the <b>IMDSPStorage</b> interface for the newly created
    ///                   storage.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT CreateStorage2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat, PWSTR pwszName, ulong qwFileSize, 
                           IMDSPStorage* ppNewStorage);
    ///The <b>SetAttributes2</b> method extends <b>IMDSPStorage::SetAttributes</b> by enabling you to set audio and
    ///video formats and extended attributes of a storage object.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> containing the attributes to be set as defined in the <b>IWMDMStorage::SetAttributes</b> method
    ///    dwAttributesEx = <b>DWORD</b> containing the extended attributes. No extended attributes are currently defined.
    ///    pAudioFormat = Pointer to a <b>_WAVEFORMATEX</b> structure that contains audio format information about the object. This
    ///                   parameter is optional and is ignored if the file is not audio.
    ///    pVideoFormat = Pointer to a <b>_VIDEOINFOHEADER</b> structure that contains video format information about the object. This
    ///                   parameter is optional and is ignored if the file is not video.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
    ///The <b>GetAttributes2</b> method gets attributes of files or storages.
    ///Params:
    ///    pdwAttributes = Pointer to a <b>DWORD</b> containing the base attributes as defined in the <b>IWMDMStorage::GetAttributes</b>
    ///                    method.
    ///    pdwAttributesEx = Pointer to a <b>DWORD</b> containing the extended attributes. Currently no extended attributes are defined.
    ///    pAudioFormat = Pointer to a <b>_WAVEFORMATEX</b> structure that contains audio format information about the object. This
    ///                   parameter is optional and is ignored if the file is not audio.
    ///    pVideoFormat = Pointer to a <b>_VIDEOINFOHEADER</b> structure that contains video format information about the object. This
    ///                   parameter is optional and is ignored if the file is not video.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
}

///The <b>IMDSPStorage3</b> interface extends IMDSPStorage2 by supporting metadata. This interface is optional. Service
///providers must implement this interface only if they are going to support metadata. If the device parameter
///<i>UseMetadataViews</i> is set to 1, this interface must be implemented and the <b>GetMetadata</b> method becomes
///mandatory, although <b>SetMetadata</b> is still optional. For more information, see Device Parameters.
@GUID("6C669867-97ED-4A67-9706-1C5529D2A414")
interface IMDSPStorage3 : IMDSPStorage2
{
    ///The <b>GetMetadata</b> method retrieves metadata from the service provider.
    ///Params:
    ///    pMetadata = Pointer to an <b>IWMDMMetaData</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetMetadata(IWMDMMetaData pMetadata);
    ///The <b>SetMetadata</b> method provides the metadata associated with a specified content.
    ///Params:
    ///    pMetadata = Pointer to an <b>IWMDMMetadata</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded, which indicates that SP has
    ///    successfully processed the metadata. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The device does not support setting
    ///    metadata. </td> </tr> </table>
    ///    
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
}

///The <b>IMDSPStorage4</b> interface extends IMDSPStorage3 for supporting virtual storages (such as playlists and
///albums) and metadata. <div class="alert"><b>Note</b> Unless the service provider has added the device parameter
///<b>UseExtendedWmdm</b> with a value of 1, Windows Media Device Manager will not call this interface. See Device
///Parameters for more information about this.</div> <div> </div>
@GUID("3133B2C4-515C-481B-B1CE-39327ECB4F74")
interface IMDSPStorage4 : IMDSPStorage3
{
    ///The <b>SetReferences</b> method sets the references contained in a storage that has references (such as
    ///playlist/album), overwriting any previously existing references contained in this storage.
    ///Params:
    ///    dwRefs = Count of <b>IMDSPStorage</b> interface pointers contained in the passed-in array. Zero is an acceptable value
    ///             and resets the storage to contain zero references. The storage itself is not deleted in this case.
    ///    ppISPStorage = Pointer to an array of <b>IMDSPStorage</b> interface pointers used to set references in a storage. The
    ///                   ordering of references matches the ordering of the corresponding <b>IWMDMStorage</b> interface pointers in
    ///                   this array. <b>NULL</b> is an acceptable value if <i>dwRefs</i> is also zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetReferences(uint dwRefs, IMDSPStorage* ppISPStorage);
    ///The <b>GetReferences</b> method returns an array of pointers to <b>IMDSPStorage</b> objects comprising the
    ///references contained in an association storage, such as one representing playlist or album objects.
    ///Params:
    ///    pdwRefs = Pointer to the count of <b>IWMDMStorage</b> interface pointers being returned in <i>pppIWMDMStorage</i>.
    ///    pppISPStorage = Pointer to a pointer to the array of <b>IWMDMStorage</b> interface pointers that represent references on a
    ///                    storage. Such references can, for example, represent items in a playlist or album. The ordering of references
    ///                    matches the ordering in this array. Memory for this array should be allocated by the service provider.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetReferences(uint* pdwRefs, IMDSPStorage** pppISPStorage);
    ///The <b>CreateStorageWithMetadata</b> method creates a new storage, applying the given metadata to the new
    ///storage, and returns a pointer to the <b>IMDSPStorage</b> interface on the newly created storage. The new storage
    ///can be created at the same level or can be inserted into the current storage. This method is useful if the device
    ///needs metadata at creation time. Depending upon the device it may also be more efficient to applying metadata at
    ///creation time as opposed to creating the storage and then setting metadata.
    ///Params:
    ///    dwAttributes = <b>DWORD</b> containing attributes for the new storage. The following table lists the available storage
    ///                   attributes. <table> <tr> <th>Attribute </th> <th>Description </th> </tr> <tr>
    ///                   <td>WMDM_STORAGECONTROL_INSERTBEFORE</td> <td>The new storage object will be created in front of the target
    ///                   object.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTAFTER</td> <td>The new storage object will be created
    ///                   after the target object.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTINTO</td> <td>The new storage object
    ///                   will be created in the target object folder.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_OVERWRITE</td> <td>If
    ///                   storage with the same name already exists, it will be destroyed and a new storage created.</td> </tr> <tr>
    ///                   <td>WMDM_STORAGE_ATTR_FILESYSTEM</td> <td>This object is the top-level storage medium (for example, a storage
    ///                   card or some other onboard storage.)</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_REMOVABLE</td> <td>This storage
    ///                   medium is removable.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_CANEDITMETADATA</td> <td>This storage can edit
    ///                   metadata.</td> </tr> <tr> <td>WMDM_STORAGE_ATTR_FOLDERS</td> <td>This storage medium supports folders and
    ///                   file hierarchy.</td> </tr> <tr> <td>WMDM_FILE_ATTR_FOLDER</td> <td>This is a folder on the storage
    ///                   medium.</td> </tr> <tr> <td>WMDM_FILE_ATTR_LINK</td> <td>This is a link that creates an association among
    ///                   multiple files.</td> </tr> <tr> <td>WMDM_FILE_ATTR_FILE</td> <td>This is a file on the storage medium.</td>
    ///                   </tr> <tr> <td>WMDM_FILE_ATTR_AUDIO</td> <td>This file is audio data.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_DATA</td> <td>This file is non-audio data.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANPLAY</td>
    ///                   <td>This audio file can be played by the device.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANDELETE</td> <td>This
    ///                   file can be deleted.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANMOVE</td> <td>This file or folder can be moved on
    ///                   the storage medium.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANRENAME</td> <td>This file or folder can be
    ///                   renamed.</td> </tr> <tr> <td>WMDM_FILE_ATTR_CANREAD</td> <td>This file can be read by the host computer.</td>
    ///                   </tr> <tr> <td>WMDM_FILE_ATTR_MUSIC</td> <td>This audio file is music.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_PLAYLIST</td> <td>This is a playlist object.</td> </tr> <tr> <td>WMDM_FILE_ATTR_VIDEO</td>
    ///                   <td>This file contains video data.</td> </tr> <tr> <td>WMDM_FILE_ATTR_HIDDEN</td> <td>This file is hidden on
    ///                   the file system.</td> </tr> <tr> <td>WMDM_FILE_ATTR_SYSTEM</td> <td>This is a system file.</td> </tr> <tr>
    ///                   <td>WMDM_FILE_ATTR_READONLY</td> <td>This is a read-only file.</td> </tr> <tr>
    ///                   <td>WMDM_STORAGE_IS_DEFAULT</td> <td>This storage is the default storage where new media should be
    ///                   placed.</td> </tr> <tr> <td>WMDM_STORAGE_CONTAINS_DEFAULT</td> <td>This storage contains the default storage
    ///                   where new media should be placed.</td> </tr> </table>
    ///    pwszName = Pointer to a wide-character, null-terminated string containing a name for the new storage.
    ///    pMetadata = Pointer to an <b>IWMDMMetaData</b> interface.
    ///    qwFileSize = <b>Qword</b> containing the file size.
    ///    ppNewStorage = Pointer to an <b>IMDSPStorage</b> pointer to receive the <b>IMDSPStorage</b> interface for the newly created
    ///                   storage.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT CreateStorageWithMetadata(uint dwAttributes, const(PWSTR) pwszName, IWMDMMetaData pMetadata, 
                                      ulong qwFileSize, IMDSPStorage* ppNewStorage);
    ///The <b>GetSpecifiedMetadata</b> method retrieves only the specified metadata object for a storage.
    ///Params:
    ///    cProperties = Count of properties to be retrieved.
    ///    ppwszPropNames = Array that contains the property names to be retrieved. The size of this array should be equal to
    ///                     <i>cProperties</i>.
    ///    pMetadata = Pointer to the returned <b>IWMDMMetaData</b> interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSpecifiedMetadata(uint cProperties, PWSTR* ppwszPropNames, IWMDMMetaData pMetadata);
    ///The <b>FindStorage</b> method finds a storage with the given persistent unique identifier. The persistent unique
    ///identifier of a storage is described by the <b>g_wszWMDMPersistentUniqueID</b> property of that storage.
    ///Params:
    ///    findScope = Scope of the find operation. It must be one of the following values. <table> <tr> <th>Value </th>
    ///                <th>Description </th> </tr> <tr> <td>WMDM_FIND_SCOPE_GLOBAL</td> <td>Search the entire device.</td> </tr>
    ///                <tr> <td>WMDM_FIND_SCOPE_IMMEDIATE_CHILDREN</td> <td>Search only in the immediate children of the current
    ///                storage.</td> </tr> </table>
    ///    pwszUniqueID = Persistent unique identifier of the storage.
    ///    ppStorage = Pointer to the returned storage specified by the <i>pwszUniqueID</i> parameter.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IMDSPStorage* ppStorage);
    ///The <b>GetParent</b> method retrieves the parent of the current storage.
    ///Params:
    ///    ppStorage = Pointer to the returned parent storage object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetParent(IMDSPStorage* ppStorage);
}

///The <b>IMDSPStorageGlobals</b> interface, acquired from the IMDSPStorage interface, provides methods for retrieving
///global information about a storage medium. This might include the amount of free space, serial number of the medium,
///and so on.
@GUID("1DCB3A17-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPStorageGlobals : IUnknown
{
    ///The <b>GetCapabilities</b> method retrieves the capabilities of the storage medium that an instance of this
    ///interface is associated with.
    ///Params:
    ///    pdwCapabilities = Pointer to a <b>DWORD</b> containing the capabilities of the storage medium. The following flags can be
    ///                      returned in the <i>pdwCapabilities</i> parameter. <table> <tr> <th>Flag </th> <th>Description </th> </tr>
    ///                      <tr> <td>WMDM_STORAGECAP_FOLDERSINROOT</td> <td>The medium supports folders in the root of storage.</td>
    ///                      </tr> <tr> <td>WMDM_STORAGECAP_FILESINROOT</td> <td>The medium supports files in the root of storage.</td>
    ///                      </tr> <tr> <td>WMDM_STORAGECAP_FOLDERSINFOLDERS</td> <td>The medium supports folders in folders.</td> </tr>
    ///                      <tr> <td>WMDM_STORAGECAP_FILESINFOLDERS</td> <td>The medium supports files in folders.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_FOLDERLIMITEXISTS</td> <td>There is an arbitrary count limit for the number of folders
    ///                      allowed per the form of folder support by the medium.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_FILELIMITEXISTS</td> <td>There is an arbitrary count limit for the number of files
    ///                      allowed per the form of file support by the medium.</td> </tr> <tr>
    ///                      <td>WMDM_STORAGECAP_NOT_INITIALIZABLE</td> <td>The medium cannot be initialized. By default, the top-level
    ///                      storage can be initialized.</td> </tr> </table> For secured device implementations, the following flags
    ///                      describing the rights capabilities of the medium can also be returned. <table> <tr> <th>Flag </th>
    ///                      <th>Description </th> </tr> <tr> <td>WMDM_RIGHTS_PLAYBACKCOUNT</td> <td>The medium supports playback count
    ///                      limiting for content.</td> </tr> <tr> <td>WMDM_RIGHTS_EXPIRATIONDATE</td> <td>The medium supports expiration
    ///                      date tracking for content.</td> </tr> <tr> <td>WMDM_RIGHTS_FREESERIALIDS</td> <td>The medium supports a free
    ///                      serial identifier for the file.</td> </tr> <tr> <td>WMDM_RIGHTS_GROUPID</td> <td>The medium supports a group
    ///                      identifier for the file.</td> </tr> <tr> <td>WMDM_RIGHTS_NAMEDSERIALIDS</td> <td>The medium supports a named
    ///                      serial identifier for the file.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetCapabilities(uint* pdwCapabilities);
    ///The <b>GetSerialNumber</b> method retrieves a serial number uniquely identifying the storage medium. This method
    ///must be implemented for protected content transfer, but otherwise it is optional. For more information, see
    ///Mandatory and Optional Interfaces. .
    ///Params:
    ///    pSerialNum = Pointer to a <b>WMDMID</b> structure containing the serial number information. This parameter is included in
    ///                 the output message authentication code.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSerialNumber(__WMDMID* pSerialNum, ubyte* abMac);
    ///The <b>GetTotalSize</b> method retrieves the total size, in bytes, of the medium associated with this
    ///<b>IMDSPStorageGlobals</b> interface.
    ///Params:
    ///    pdwTotalSizeLow = Pointer to a <b>DWORD</b> containing the low-order bytes of the total size of the medium.
    ///    pdwTotalSizeHigh = Pointer to a <b>DWORD</b> containing the high-order bytes of the total size of the medium.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalSize(uint* pdwTotalSizeLow, uint* pdwTotalSizeHigh);
    ///The <b>GetTotalFree</b> method retrieves the total free space on the storage medium, in bytes.
    ///Params:
    ///    pdwFreeLow = Pointer to a <b>DWORD</b> containing the low-order bytes of the free space.
    ///    pdwFreeHigh = Pointer to a <b>DWORD</b> containing the high-order bytes of the free space.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalFree(uint* pdwFreeLow, uint* pdwFreeHigh);
    ///The <b>GetTotalBad</b> method retrieves the total amount of unusable space on the storage medium, in bytes.
    ///Params:
    ///    pdwBadLow = Pointer to a <b>DWORD</b> containing the low-order bytes of the unusable space.
    ///    pdwBadHigh = Pointer to a <b>DWORD</b> containing the high-order bytes of the unusable space.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalBad(uint* pdwBadLow, uint* pdwBadHigh);
    ///The <b>GetStatus</b> method retrieves the current status of the storage medium.
    ///Params:
    ///    pdwStatus = Pointer to a <b>DWORD</b> containing the status information. The following status values can be returned by
    ///                the <i>pdwStatus</i> parameter. <table> <tr> <th>Status </th> <th>Description </th> </tr> <tr>
    ///                <td>WMDM_STATUS_READY</td> <td>The medium is in an idle ready state.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_BUSY</td> <td>An operation is ongoing. Evaluate status values to determine the ongoing
    ///                operation.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_NOTPRESENT</td> <td>The medium is not present. For devices
    ///                that support more than one medium, this value is only reported from the <b>IMDSPStorageGlobals</b>
    ///                interface.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_INITIALIZING</td> <td>The device is currently busy
    ///                formatting media on a device.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_BROKEN</td> <td>The medium is broken.
    ///                For devices that support more than one medium, this value is only reported from the
    ///                <b>IMDSPStorageGlobals</b> interface.</td> </tr> <tr> <td>WMDM_STATUS_STORAGE_NOTSUPPORTED</td> <td>The
    ///                medium is not supported by the device. For devices that support more than one medium, this value is only
    ///                returned from the <b>IMDSPStorageGlobals</b> interface.</td> </tr> <tr>
    ///                <td>WMDM_STATUS_STORAGE_UNFORMATTED</td> <td>The medium is not formatted. For devices that support more than
    ///                one medium, this value is only reported from the <b>IMDSPStorageGlobals</b> interface.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetStatus(uint* pdwStatus);
    ///The <b>Initialize</b> method formats the storage medium. This method is optional. However, this method should be
    ///implemented if the device supports this functionality. If this method is not implemented,
    ///IMDSPStorageGlobals::GetCapabilities must return WMDM_STORAGECAP_NOT_INITIALIZABLE in addition to any other
    ///flags. For more information, see Mandatory and Optional Interfaces.
    ///Params:
    ///    fuMode = Mode used to initialize the medium. Specify exactly one of the following two modes. If both modes are
    ///             specified, block mode is used. <table> <tr> <th>Mode </th> <th>Description </th> </tr> <tr>
    ///             <td>WMDM_MODE_BLOCK</td> <td>The operation is performed using block mode processing. The call is not returned
    ///             until the operation is finished.</td> </tr> <tr> <td>WMDM_MODE_THREAD</td> <td>The operation is performed
    ///             using thread mode processing. The call returns immediately and the operation is performed in a background
    ///             thread.</td> </tr> </table>
    ///    pProgress = Pointer to an <b>IWMDMProgress</b> interface implemented by an application to track the progress of the
    ///                formatting operation. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Initialize(uint fuMode, IWMDMProgress pProgress);
    ///The <b>GetDevice</b> method retrieves a pointer to the device on which the storage medium with which this
    ///interface is associated is mounted.
    ///Params:
    ///    ppDevice = Pointer to a device identified by the <b>IMDSPDevice</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetDevice(IMDSPDevice* ppDevice);
    ///The <b>GetRootStorage</b> method retrieves a pointer to the <b>IMDSPStorage</b> interface for the root storage of
    ///the storage medium.
    ///Params:
    ///    ppRoot = Pointer to an <b>IMDSPStorage</b> pointer that receives the root storage.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetRootStorage(IMDSPStorage* ppRoot);
}

///The <b>IMDSPObjectInfo</b> interface provides methods for getting and setting parameters that describe how playable
///objects on a storage medium are referenced or accessed by the IMDSPDeviceControl interface. Implementing this
///interface is optional. For more information, see Mandatory and Optional Interfaces. The resolution of the method
///parameters depends on the associated storage object as follows: <ul> <li>If the storage object represents a playable
///audio file, then the relative storage units are milliseconds.</li> <li>If the storage object represents a folder or
///the root of a storage medium containing playable files, then the relative storage units are tracks.</li> </ul> This
///interface is not intended for non-playable files. If the <b>IMDSPObjectInfo</b> interface is acquired from an
///IMDSPStorage interface that represents a non-playable file or a folder or a root file system containing no playable
///files, E_INVALIDTYPE is returned from all of the methods.
@GUID("1DCB3A19-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPObjectInfo : IUnknown
{
    ///The <b>GetPlayLength</b> method retrieves the play length of the object in units pertinent to the object. This is
    ///the remaining length that the object can play, not its total length.
    ///Params:
    ///    pdwLength = Pointer to a <b>DWORD</b> containing the remaining play length of the object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetPlayLength(uint* pdwLength);
    ///The <b>SetPlayLength</b> method sets the play length of the object, in units pertinent to the object. This is the
    ///maximum length that the object plays regardless of its actual length.
    ///Params:
    ///    dwLength = <b>DWORD</b> containing the play length to set for the object, in units pertinent to the object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetPlayLength(uint dwLength);
    ///The <b>GetPlayOffset</b> method retrieves the play offset of the object, in units pertinent to the object. This
    ///is the starting point for the next invocation of IMDSPDeviceControl::Play.
    ///Params:
    ///    pdwOffset = Pointer to a <b>DWORD</b> containing the play offset of the object, in units pertinent to the object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetPlayOffset(uint* pdwOffset);
    ///The <b>SetPlayOffset</b> method sets the play offset of the object, in the units pertinent to the object. This
    ///specifies the starting point for the next invocation of IMDSPDeviceControl::Play.
    ///Params:
    ///    dwOffset = <b>DWORD</b> containing the play offset to set for the object, in units pertinent to the object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetPlayOffset(uint dwOffset);
    ///The <b>GetTotalLength</b> method retrieves the total play length of the object in units pertinent to the object.
    ///The value returned is the total length regardless of the current settings of the play length and offset.
    ///Params:
    ///    pdwLength = Pointer to a <b>DWORD</b> containing the total length of the object, in units pertinent to the object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetTotalLength(uint* pdwLength);
    ///The <b>GetLastPlayPosition</b> method retrieves the last play position of the object. The object must be a music
    ///file on the media device.
    ///Params:
    ///    pdwLastPos = Pointer to a <b>DWORD</b> containing the last play position of the object, in milliseconds.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetLastPlayPosition(uint* pdwLastPos);
    ///The <b>GetLongestPlayPosition</b> method retrieves the longest play position of the object. The object must be a
    ///music file on the media device.
    ///Params:
    ///    pdwLongestPos = Pointer to a <b>DWORD</b> containing the longest play position of the object, in milliseconds.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetLongestPlayPosition(uint* pdwLongestPos);
}

///The <b>IMDSPObject</b> interface manages the transfer of data to and from storage media. The <b>Open</b>,
///<b>Read</b>, <b>Write</b>, and <b>Close</b> methods are valid only if the storage object is a file. The client would
///typically call <b>Open</b>, perform a number of <b>Read</b> or <b>Write</b> operations and then call <b>Close</b>.
///This allows for a buffered mode read/write of the storage medium. The service provider should be able to handle any
///other calls on the device or storage interfaces (for example, enumerating content or getting global information about
///the storage medium) while the read or write operation is in progress. The service provider should also be able to
///handle simultaneous read or write operations on multiple files. If the underlying file-system does not support
///opening of multiple files at the same time, service provider should gracefully return an error. The <b>Delete</b>,
///<b>Rename</b>, and <b>Move</b> methods are valid for both files and folders.
@GUID("1DCB3A18-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPObject : IUnknown
{
    ///The <b>Open</b> method opens the associated object and prepares it for Read or Write operations. This operation
    ///is valid only if the storage object represents a file.
    ///Params:
    ///    fuMode = Mode in which the file must be opened. It must be one of the following two values. <table> <tr> <th>Value
    ///             </th> <th>Description </th> </tr> <tr> <td>MDSP_READ</td> <td>Query whether a subsequent call to <b>Read</b>
    ///             would be allowed.</td> </tr> <tr> <td>MDSP_WRITE</td> <td>Query whether a subsequent call to <b>Insert</b>
    ///             would be allowed.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Open(uint fuMode);
    ///The <b>Read</b> method reads data from the object at the current position. This operation is valid only if the
    ///storage object represents a file.
    ///Params:
    ///    pData = Pointer to a buffer to receive the data read from the object. This parameter is included in the output
    ///            message authentication code and must be encrypted using CSecureChannelServer::EncryptParam. See Remarks.
    ///    pdwSize = Pointer to a <b>DWORD</b> specifying the number of bytes of data to read. Upon return, this parameter
    ///              contains the actual amount of data read. This parameter must be included in the input message authentication
    ///              code.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Read(ubyte* pData, uint* pdwSize, ubyte* abMac);
    ///The <b>Write</b> method writes data to the object at the current position within the object. This operation is
    ///valid only if the storage object represents a file.
    ///Params:
    ///    pData = Pointer to the buffer containing the data to write to the object. This parameter is encrypted and must be
    ///            decrypted using CSecureChannelServer::DecryptParam with the MAC in <i>abMac</i>. See Remarks.
    ///    pdwSize = <b>DWORD</b> containing the number of bytes of data to write. Upon return, this parameter contains the actual
    ///              number of bytes written. This parameter must be included in both the input and output message authentication
    ///              codes.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Write(ubyte* pData, uint* pdwSize, ubyte* abMac);
    ///The <b>Delete</b> method removes an object or objects from a storage medium on a media device.
    ///Params:
    ///    fuMode = Flag that must always be set to WMDM_MODE_RECURSIVE by the client. If the object is a folder, it and its
    ///             contents, and all subfolders and their contents are deleted. If the object is a file, this parameter is
    ///             ignored.
    ///    pProgress = Pointer to an application-implemented IWMDMProgress interface that enables the application to receive
    ///                progress notifications for lengthy <b>Delete</b> operations.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Delete(uint fuMode, IWMDMProgress pProgress);
    ///The <b>Seek</b> method sets the current position within the object. This operation is valid only if the storage
    ///object represents a file.
    ///Params:
    ///    fuFlags = Mode in which the file must be opened. It must be one of the values in the following table. <table> <tr>
    ///              <th>Value </th> <th>Description </th> </tr> <tr> <td>MDSP_SEEK_BOF</td> <td>Seek <i>dwOffset</i> bytes
    ///              forward from the beginning of the file.</td> </tr> <tr> <td>MDSP_SEEK_CUR</td> <td>Seek <i>dwOffset</i> bytes
    ///              forward from the current position.</td> </tr> <tr> <td>MDSP_SEEK_EOF</td> <td>Seek <i>dwOffset</i> bytes
    ///              backward from the end of the file.</td> </tr> </table>
    ///    dwOffset = <b>DWORD</b> containing the number of bytes to seek.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Seek(uint fuFlags, uint dwOffset);
    ///The <b>Rename</b> method renames the associated object which can be a file or a folder.
    ///Params:
    ///    pwszNewName = Pointer to a wide-character null-terminated string to receive a new name for the object. For information on
    ///                  how to use the <b>LPWSTR</b> variable type, see the Windows documentation.
    ///    pProgress = Pointer to an application-implemented IWMDMProgress interface that enables the application to receive
    ///                progress notification for lengthy renaming operations.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Rename(PWSTR pwszNewName, IWMDMProgress pProgress);
    ///The <b>Move</b> method moves a file or folder on a media device.
    ///Params:
    ///    fuMode = Processing mode by which to invoke the <b>Move</b> operation and the method by which to move. Specify exactly
    ///             one of the following two modes. If both modes are specified, block mode is used. <table> <tr> <th>Mode </th>
    ///             <th>Description </th> </tr> <tr> <td>WMDM_MODE_BLOCK</td> <td>The operation will be performed using block
    ///             mode processing. The call will not return until the operation is finished.</td> </tr> <tr>
    ///             <td>WMDM_MODE_THREAD</td> <td>The operation will be performed using thread mode processing. The call will
    ///             return immediately, and the operation will be performed in a background thread.</td> </tr> </table> The
    ///             following table lists flags that indicate where the object will be moved to. One value from this table is
    ///             combined with one value from the preceding Mode table by using a bitwise <b>OR</b>. <table> <tr> <th>Method
    ///             of move </th> <th>Description </th> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTBEFORE</td> <td>The object will
    ///             be inserted before the target object.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTINTO</td> <td>The object
    ///             will be inserted into the target object. The target object must be a folder. If the target object is a file,
    ///             this method fails.</td> </tr> <tr> <td>WMDM_STORAGECONTROL_INSERTAFTER</td> <td>The object will be inserted
    ///             after the target object.</td> </tr> </table>
    ///    pProgress = Pointer to an IWMDMProgress interface that has been implemented by the application to track the progress of
    ///                ongoing operations. This parameter is optional and should be set to <b>NULL</b> when not being used.
    ///    pTarget = Pointer to the target object before or after which you want to put the current object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Move(uint fuMode, IWMDMProgress pProgress, IMDSPStorage pTarget);
    ///The <b>Close</b> method closes a file on a storage medium of a media device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Close();
}

///Windows Media Device Manager uses <b>IMDSPObject2</b> to enable more efficient file reading and writing. <div
///class="alert"><b>Note</b> Unless the service provider has added the device parameter <b>UseExtendedWmdm</b> with a
///value of 1, Windows Media Device Manager will not call this interface. See Device Parameters for more information
///about this.</div> <div> </div>
@GUID("3F34CD3E-5907-4341-9AF9-97F4187C3AA5")
interface IMDSPObject2 : IMDSPObject
{
    ///The <b>ReadOnClearChannel</b> method reads data from the object at the current position without using secure
    ///authenticated channels. This is still secure for use with DRM-protected content. This operation is valid only if
    ///the storage object represents a file. If <b>IMDSPObject2</b> is supported, this method must be implemented.
    ///Windows Media Device Manager does not fall back to IMDSPObject::Read if this method fails.
    ///Params:
    ///    pData = Pointer to a buffer to receive the data read from the object.
    ///    pdwSize = Pointer to a <b>DWORD</b> specifying the number of bytes of data to read. Upon return, this parameter
    ///              contains the actual amount of data read.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT ReadOnClearChannel(ubyte* pData, uint* pdwSize);
    ///The <b>WriteOnClearChannel</b> method writes data to the object to the current position within the object,
    ///without using secure authenticated channels. This operation is valid only if the storage object represents a
    ///file. If <b>IMDSPObject2</b> is supported, this method must be implemented. Windows Media Device Manager does not
    ///fall back to IMDSPObject::Write if this method fails.
    ///Params:
    ///    pData = Pointer to the buffer containing the data to write to the object.
    ///    pdwSize = Pointer to a <b>DWORD</b> containing the number of bytes of data to write. Upon return, this parameter
    ///              contains the actual number of bytes written.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT WriteOnClearChannel(ubyte* pData, uint* pdwSize);
}

///The <b>IMDSPDirectTransfer</b> interface enables Windows Media Device Manager to delegate content transfer to the
///service provider. In this case Windows Media Device Manager does not do any processing of the content before sending
///it to the service provider. The service provider gets full control of the source.
@GUID("C2FE57A8-9304-478C-9EE4-47E397B912D7")
interface IMDSPDirectTransfer : IUnknown
{
    ///The <b>TransferToDevice</b> method is called by Windows Media Device Manager to delegate content transfer content
    ///to the service provider. The source can be specified either as a file or as an operation interface.
    ///Params:
    ///    pwszSourceFilePath = Source file name. The value contained in this parameter should be ignored if WMDM_CONTENT_OPERATIONINTERFACE
    ///                         is specified.
    ///    pSourceOperation = Operation interface pointer that serves as the source. The value contained in this parameter should be
    ///                       ignored unless WMDM_CONTENT_OPERATIONINTERFACE is specified.
    ///    fuFlags = Flags that affect behavior of this method. The <i>fuFlags</i> parameter must be one of the following values.
    ///              <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>WMDM_CONTENT_FILE</td> <td>The source is a
    ///              file.</td> </tr> <tr> <td>WMDM_CONTENT_FOLDER</td> <td>The source is a folder.</td> </tr> <tr>
    ///              <td>WMDM_FILE_CREATE_OVERWRITE</td> <td>Overwrite the destination file if it already exists.</td> </tr>
    ///              </table>
    ///    pwszDestinationName = Content should be transferred to the device with this name. This parameter is required.
    ///    pSourceMetaData = Metadata interface pointer. The metadata object contains the source properties. This parameter is optional.
    ///    pTransferProgress = Progress callback interface. The service provider should update the information during the progress of the
    ///                        transfer. This parameter is optional.
    ///    ppNewObject = Newly created storage object. This parameter is optional. This can be <b>NULL</b> if the caller does not need
    ///                  to have the new object returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the following is true: 1) Both
    ///    <i>pwszSourceFileName</i> and <i>pSourceOperation</i> are specified; 2) <i>pwszDestinationName</i> is not
    ///    specified; 3) <i>fuFlags</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DISK_FULL)</b></dt> </dl> </td> <td width="60%"> There is not enough space on
    ///    the disk. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_EXISTS)</b></dt> </dl>
    ///    </td> <td width="60%"> The file already exists and WMDM_FILE_CREATE_OVERWRITE was not specified. If the
    ///    device allows duplicate file names, this could be acceptable and this error does not need to be returned.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td>
    ///    <td width="60%"> Transfer of the specified content is not supported on the device. </td> </tr> </table>
    ///    
    HRESULT TransferToDevice(const(PWSTR) pwszSourceFilePath, IWMDMOperation pSourceOperation, uint fuFlags, 
                             PWSTR pwszDestinationName, IWMDMMetaData pSourceMetaData, 
                             IWMDMProgress pTransferProgress, IMDSPStorage* ppNewObject);
}

///The <b>IMDSPRevoked</b> interface retrieves the URL from which updated components can be downloaded. Implementing
///this interface is optional. For more information, see Mandatory and Optional Interfaces.
@GUID("A4E8F2D4-3F31-464D-B53D-4FC335998184")
interface IMDSPRevoked : IUnknown
{
    ///The <b>GetRevocationURL</b> method retrieves the URL from which updated components can be downloaded.
    ///Params:
    ///    ppwszRevocationURL = Pointer to a Unicode string where the revocation URL should be written.
    ///    pdwBufferLen = Number of <b>WCHAR</b> characters that the buffer supplied by the client can hold; on return it contains the
    ///                   required number of characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetRevocationURL(PWSTR* ppwszRevocationURL, uint* pdwBufferLen);
}

///The <b>ISCPSecureAuthenticate</b> interface is the primary interface of the secure content provider, which Windows
///Media Device Manager queries to authenticate the secure content provider and to be authenticated by the secure
///content provider. This interface is used to pass information about the content to the secure content provider module,
///which the provider uses to report back whether it is responsible for the content. Windows Media Device Manager
///consults this interface whenever an application downloads content to a media device. The secure content provider
///implements this interface, and Windows Media Device Manager calls its methods.
@GUID("1DCB3A0F-33ED-11D3-8470-00C04F79DBC0")
interface ISCPSecureAuthenticate : IUnknown
{
    ///The <b>GetSecureQuery</b> method is used to obtain a pointer to the ISCPSecureQuery interface.
    ///Params:
    ///    ppSecureQuery = Pointer to an ISCPSecureQuery object.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

///The <b>ISCPSecureAuthenticate2</b> interface extends <b>ISCPSecureAuthenticate</b> by providing a way to get a
///session object.
@GUID("B580CFAE-1672-47E2-ACAA-44BBECBCAE5B")
interface ISCPSecureAuthenticate2 : ISCPSecureAuthenticate
{
    ///The <b>GetSCPSession</b> method is used to obtain a pointer to the ISCPSecureQuery interface that represents a
    ///session object.
    ///Params:
    ///    ppSCPSession = Pointer to an ISCPSession object.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSCPSession(ISCPSession* ppSCPSession);
}

///The <b>ISCPSecureQuery</b> interface is queried by Windows Media Device Manager to determine ownership of secured
///content. Windows Media Device Manager passes information about the content to the secure content provider, which uses
///that information to determine whether it is responsible for the content. Windows Media Device Manager consults this
///interface whenever an application downloads content to a media device. The ISCPSecureQuery2 interface extends
///<b>ISCPSecureQuery</b> through functionality that determines whether the secure content provider is responsible for
///the content, and if so, providing a URL for updating revoked components and determining which components have been
///revoked. The secure content provider implements this interface and secure Windows Media Device Manager
///implementations call its methods.
@GUID("1DCB3A0D-33ED-11D3-8470-00C04F79DBC0")
interface ISCPSecureQuery : IUnknown
{
    ///The <b>GetDataDemands</b> method reports which data the secure content provider needs to determine the rights and
    ///responsibility for a specified piece of content.
    ///Params:
    ///    pfuFlags = Flags describing the data required by the secure content provider to make decisions. This parameter is
    ///               included in the output message authentication code. At least one of the following flags must be used. <table>
    ///               <tr> <th>Flag </th> <th>Description </th> </tr> <tr> <td>WMDM_SCP_RIGHTS_DATA</td> <td>The secure content
    ///               provider needs data to determine rights for the content.</td> </tr> <tr> <td>WMDM_SCP_EXAMINE_DATA</td>
    ///               <td>The secure content provider needs data to determine whether it is responsible for the content.</td> </tr>
    ///               <tr> <td>WMDM_SCP_DECIDE_DATA</td> <td>The secure content provider needs data to determine whether to allow
    ///               the content to be downloaded.</td> </tr> <tr> <td>WMDM_SCP_EXAMINE_EXTENSION</td> <td>The secure content
    ///               provider needs to examine the file name extension to determine whether to allow the content to be
    ///               downloaded.</td> </tr> <tr> <td>WMDM_SCP_PROTECTED_OUTPUT</td> <td>The secure content provider needs
    ///               protected output.</td> </tr> <tr> <td>WMDM_SCP_UNPROTECTED_OUTPUT</td> <td>The secure content provider needs
    ///               unprotected output.</td> </tr> </table>
    ///    pdwMinRightsData = Pointer to a <b>DWORD</b> specifying the minimum amount of data needed to determine rights for this content.
    ///                       This parameter is included in the output message authentication code.
    ///    pdwMinExamineData = Pointer to a <b>DWORD</b> containing the minimum number of bytes of data that the secure content provider
    ///                        needs to determine whether it is responsible for the content. This parameter is included in the output
    ///                        message authentication code.
    ///    pdwMinDecideData = Pointer to a <b>DWORD</b> containing the minimum number of bytes of data that the secure content provider
    ///                       needs to determine whether to allow the content to be downloaded. This parameter is included in the output
    ///                       message authentication code.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message authentication code is not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A
    ///    parameter is an invalid or <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetDataDemands(uint* pfuFlags, uint* pdwMinRightsData, uint* pdwMinExamineData, uint* pdwMinDecideData, 
                           ubyte* abMac);
    ///The <b>ExamineData</b> method determines rights and responsibility for the content by examining data that Windows
    ///Media Device Manager passes to this method.
    ///Params:
    ///    fuFlags = Flags describing the data offered to the secure content provider to make decisions. The following flags can
    ///              be present. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr> <td>WMDM_SCP_EXAMINE_DATA</td>
    ///              <td>The <i>pData</i> parameter points to data to be examined.</td> </tr> </table>
    ///    pwszExtension = Pointer to the file name extension to be examined if the secure content provider asks for an extension in the
    ///                    GetDataDemands call.
    ///    pData = Pointer to the data at the beginning of the file to be examined. This parameter must be included in the input
    ///            message authentication code and must be encrypted.
    ///    dwSize = <b>DWORD</b> that contains the length, in bytes, of the data to be examined. This parameter must be included
    ///             in the input message authentication code.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. The secure content provider is
    ///    responsible for this content. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_CALL_OUT_OF_SEQUENCE</b></dt> </dl> </td> <td width="60%"> This method was called out of
    ///    sequence. <b>GetDataDemands</b> must be called first. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message authentication code is not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MOREDATA</b></dt> </dl> </td> <td width="60%">
    ///    Windows Media Device Manager must call this method again with another packet of data. The size of the packet
    ///    is determined by the <i>pdwMinExamineData</i> parameter in the <b>GetDataDemands</b> method. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The secure content provider is not
    ///    responsible for this content. Terminate interaction with the secure content provider. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is invalid or is a
    ///    <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT ExamineData(uint fuFlags, PWSTR pwszExtension, ubyte* pData, uint dwSize, ubyte* abMac);
    ///The <b>MakeDecision</b> method determines whether access to the content is allowed. If access is allowed, this
    ///method returns the interface that will be used to access the content.
    ///Params:
    ///    fuFlags = Flags describing the data offered to the secure content provider for making decisions. This parameter must be
    ///              included in the input message authentication code. The following flags can be present. <table> <tr> <th>Flag
    ///              </th> <th>Description </th> </tr> <tr> <td>WMDM_SCP_DECIDE_DATA</td> <td>The <i>pData</i> parameter points to
    ///              data to be examined.</td> </tr> <tr> <td>WMDM_MODE_TRANSFER_PROTECTED</td> <td>The output object data from
    ///              the ISCPSecureExchange interface must be protected. If Windows Media Device Manager sets neither or both mode
    ///              flags, DRM decides whether the output object data from the <b>ISCPSecureExchange</b> interface must be
    ///              protected or unprotected.</td> </tr> <tr> <td>WMDM_MODE_TRANSFER_UNPROTECTED</td> <td>The output object data
    ///              from the <b>ISCPSecureExchange</b> interface must be unprotected. If Windows Media Device Manager sets
    ///              neither or both mode flags, DRM decides whether the output object data from the <b>ISCPSecureExchange</b>
    ///              interface must be protected or unprotected.</td> </tr> </table>
    ///    pData = Pointer to a data object containing the data to be examined. This parameter must be included in the input
    ///            message authentication code and must be encrypted.
    ///    dwSize = <b>DWORD</b> that contains the length, in bytes, of the data to be examined. This parameter must be included
    ///             in the input message authentication code.
    ///    dwAppSec = <b>DWORD</b> that indicates the current level of security of Windows Media Device Manager. This is the
    ///               smaller of the current security levels of the application and the target service provider. This parameter
    ///               must be included in the input message authentication code.
    ///    pbSPSessionKey = Pointer to an array of bytes containing the session key for securing communication with the service provider
    ///                     to which <i>pStgGlobals</i> points. This parameter must be included in the input message authentication code
    ///                     and must be encrypted.
    ///    dwSessionKeyLen = Length of the byte array to which <i>pbSPSessionKey</i> points. This parameter must be included in the input
    ///                      message authentication code.
    ///    pStorageGlobals = Pointer to the IWMDMStorageGlobals interface on the root storage of the media or device to or from which the
    ///                      file is being transferred. This parameter must be included in the input message authentication code.
    ///    ppExchange = Pointer to an exchange object that receives the exchange interface.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_CALL_OUT_OF_SEQUENCE</b></dt> </dl> </td> <td width="60%"> This method was called out of
    ///    sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td
    ///    width="60%"> The message authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_MOREDATA</b></dt> </dl> </td> <td width="60%"> Windows Media Device Manager must call this
    ///    method again with another packet of data. The size of the packet is determined by the
    ///    <i>pdwMinDecisionData</i> parameter in the ISCPSecureQuery::GetDataDemands method. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The caller does not have the rights
    ///    required to perform the requested transfer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is invalid or is a <b>NULL</b> pointer.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> </table>
    ///    
    HRESULT MakeDecision(uint fuFlags, ubyte* pData, uint dwSize, uint dwAppSec, ubyte* pbSPSessionKey, 
                         uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, ISCPSecureExchange* ppExchange, 
                         ubyte* abMac);
    ///The <b>GetRights</b> method retrieves rights information for the current piece of content. Rights are
    ///file-specific.
    ///Params:
    ///    pData = Pointer to data requested by GetDataDemands. This parameter must be included in the input message
    ///            authentication code and must be encrypted.
    ///    dwSize = Number of bytes of data in the <i>pData</i> buffer. This parameter must be included in the input message
    ///             authentication code.
    ///    pbSPSessionKey = Pointer to an array of bytes containing the session key for securing communication with the service provider
    ///                     to which <i>pStgGlobals</i> points. This parameter must be included in the input message authentication code
    ///                     and must be encrypted.
    ///    dwSessionKeyLen = Length of the byte array to which <i>pbSPSessionKey</i> points. This parameter must be included in the input
    ///                      message authentication code.
    ///    pStgGlobals = Pointer to an IWMDMStorageGlobals interface on the root storage of the media or device to or from which the
    ///                  file is being transferred.
    ///    ppRights = Pointer to an array of WMDMRIGHTS structures containing the rights information for this object. The array is
    ///               allocated by this method and must be freed using <b>CoTaskMemFree</b>. This parameter is included in the
    ///               output message authentication code.
    ///    pnRightsCount = Number of <b>WMDMRIGHTS</b> structures in the <i>ppRights</i> array. This parameter is included in the output
    ///                    message authentication code.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_CALL_OUT_OF_SEQUENCE</b></dt> </dl> </td> <td width="60%"> This method was called out of
    ///    sequence. <b>GetDataDemands</b> and then ExamineData must be called first, in that order. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message
    ///    authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NORIGHTS</b></dt>
    ///    </dl> </td> <td width="60%"> The caller does not have the rights required to perform the requested operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter
    ///    is invalid or is a <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetRights(ubyte* pData, uint dwSize, ubyte* pbSPSessionKey, uint dwSessionKeyLen, 
                      IMDSPStorageGlobals pStgGlobals, __WMDMRIGHTS** ppRights, uint* pnRightsCount, ubyte* abMac);
}

///The <b>ISCPSecureQuery2</b> interface extends ISCPSecureQuery through functionality that determines whether the
///secure content provider is responsible for the content, and if so, providing a URL for updating revoked components
///and determining which components have been revoked.
@GUID("EBE17E25-4FD7-4632-AF46-6D93D4FCC72E")
interface ISCPSecureQuery2 : ISCPSecureQuery
{
    ///The <b>MakeDecision2</b> method determines whether the secure content provider is responsible for the content by
    ///examining data that Windows Media Device Manager passes to this method. This method provides two output
    ///parameters for error handling, a default location for updating revoked components, and a bit flag indicating
    ///which components have been revoked.
    ///Params:
    ///    fuFlags = Flags describing the data offered to the secure content provider for making decisions. This parameter must be
    ///              included in the input message authentication code. One or more of the following flags can be combined using a
    ///              bitwise <b>OR</b>. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr> <td>WMDM_SCP_DECIDE_DATA</td>
    ///              <td>The <i>pData</i> parameter points to the data to be examined.</td> </tr> <tr>
    ///              <td>WMDM_MODE_TRANSFER_PROTECTED</td> <td>The output object data from the ISCPSecureExchange interface must
    ///              be protected. If Windows Media Device Manager sets neither or both mode flags, Windows Media Digital Rights
    ///              Manager decides whether the output object data from the <b>ISCPSecureExchange</b> interface must be protected
    ///              or unprotected.</td> </tr> <tr> <td>WMDM_MODE_TRANSFER_UNPROTECTED</td> <td>The output object data from the
    ///              <b>ISCPSecureExchange</b> interface must be unprotected. If Windows Media Device Manager sets neither or both
    ///              mode flags, Windows Media Digital Rights Manager decides whether the output object data from the
    ///              <b>ISCPSecureExchange</b> interface must be protected or unprotected.</td> </tr> </table>
    ///    pData = Pointer to a data object containing the data to be examined. This parameter must be included in the input
    ///            message authentication code and must be encrypted.
    ///    dwSize = <b>DWORD</b> containing the size of the file data.
    ///    dwAppSec = <b>DWORD</b> that contains the length, in bytes, of the <b>dwAppSec</b> member of the WMDMRIGHTS structure of
    ///               the service provider and secure content provider to be examined. This parameter must be included in the input
    ///               message authentication code.
    ///    pbSPSessionKey = Pointer to an array of bytes containing the session key for securing communication with the service provider
    ///                     to which <i>pStgGlobals</i> points. This parameter must be included in the input message authentication code
    ///                     and must be encrypted.
    ///    dwSessionKeyLen = <b>DWORD</b> containing the session key length.
    ///    pStorageGlobals = Pointer to the IWMDMStorageGlobals interface on the root storage of the media or device to or from which the
    ///                      file is being transferred. This parameter must be included in the input message authentication code.
    ///    pAppCertApp = Pointer to an application certificate of the application object.
    ///    dwAppCertAppLen = <b>DWORD</b> containing the length, in bytes, of the application certificate.
    ///    pAppCertSP = Pointer to the application certificate of the service provider object.
    ///    dwAppCertSPLen = <b>DWORD</b> containing the length, in bytes, of the application certificate.
    ///    pszRevocationURL = Pointer to a buffer to hold the revocation URL.
    ///    pdwRevocationURLLen = Pointer to a <b>DWORD</b> containing the size of the <i>rpszRevocationURL</i> buffer in bytes.
    ///    pdwRevocationBitFlag = Pointer to a <b>DWORD</b> containing the revocation bit flag. The flag value will be either zero, or one or
    ///                           more of the following flag names combined by using a bitwise <b>OR</b>. <table> <tr> <th>Value </th>
    ///                           <th>Description </th> </tr> <tr> <td>WMDM_WMDM_REVOKED</td> <td>Windows Media Device Manager itself has been
    ///                           revoked.</td> </tr> <tr> <td>WMDM_APP_REVOKED</td> <td>The application has been revoked and needs to be
    ///                           updated before any DRM-protected content can be transferred.</td> </tr> <tr> <td>WMDM_SP_REVOKED</td> <td>The
    ///                           service provider has been revoked and needs to be updated before any DRM-protected content can be transferred
    ///                           to it.</td> </tr> <tr> <td>WMDM_SCP_REVOKED</td> <td>The secure content provider has been revoked and needs
    ///                           to be updated before any DRM-protected content can be transferred.</td> </tr> </table>
    ///    pqwFileSize = Pointer to a <b>QWORD</b> containing the file size. The secure content provider is responsible for updating
    ///                  this value or setting it to zero if the size of the destination file cannot be determined at this point.
    ///    pUnknown = Pointer to an unknown interface from the application.
    ///    ppExchange = Pointer to an exchange object that receives the exchange interface.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_REVOKED</b></dt>
    ///    </dl> </td> <td width="60%"> The application certificate that the secure content provider uses to talk to the
    ///    DRM client has been revoked. </td> </tr> </table>
    ///    
    HRESULT MakeDecision2(uint fuFlags, ubyte* pData, uint dwSize, uint dwAppSec, ubyte* pbSPSessionKey, 
                          uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, ubyte* pAppCertApp, 
                          uint dwAppCertAppLen, ubyte* pAppCertSP, uint dwAppCertSPLen, PWSTR* pszRevocationURL, 
                          uint* pdwRevocationURLLen, uint* pdwRevocationBitFlag, ulong* pqwFileSize, 
                          IUnknown pUnknown, ISCPSecureExchange* ppExchange, ubyte* abMac);
}

///The <b>ISCPSecureExchange</b> interface is used to exchange secured content and rights associated with content. The
///secure content provider implements this interface and secure Windows Media Device Manager implementations call its
///methods.
@GUID("1DCB3A0E-33ED-11D3-8470-00C04F79DBC0")
interface ISCPSecureExchange : IUnknown
{
    ///The <b>TransferContainerData</b> method transfers container file data to the secure content provider. The secure
    ///content provider breaks down the container internally and reports which parts of the content are available as
    ///they are extracted from the container.
    ///Params:
    ///    pData = Pointer to a buffer holding the current data being transferred from the container file. This parameter must
    ///            be included in the input message authentication code and must be encrypted.
    ///    dwSize = <b>DWORD</b> that contains the number of bytes in the buffer. This parameter must be included in the input
    ///             message authentication code.
    ///    pfuReadyFlags = Flag indicating which parts of the container file are ready to be read. This parameter is included in the
    ///                    output message authentication code. The following flags indicate what is ready. <table> <tr> <th>Flag </th>
    ///                    <th>Description </th> </tr> <tr> <td>WMDM_SCP_TRANSFER_OBJECTDATA</td> <td>Data of the object is available by
    ///                    calling the ObjectData method.</td> </tr> <tr> <td>WMDM_SCP_NO_MORE_CHANGES</td> <td>Set when the secure
    ///                    content provider has determined that it requires no further processing and/or modification of the file being
    ///                    transferred. Windows Media Device Manager can directly transfer the remainder of the file to the device.</td>
    ///                    </tr> </table>
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NOT_CERTIFIED</b></dt> </dl> </td> <td width="60%"> The caller is not authorized to use this
    ///    interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NORIGHTS</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have the rights required to perform the requested operation. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message
    ///    authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> The method failed. Terminate interaction with the secure content provider. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is invalid or is
    ///    a <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT TransferContainerData(ubyte* pData, uint dwSize, uint* pfuReadyFlags, ubyte* abMac);
    ///The <b>ObjectData</b> method transfers a block of object data back to Windows Media Device Manager.
    ///Params:
    ///    pData = Pointer to a buffer to receive data. This parameter is included in the output message authentication code and
    ///            is encrypted.
    ///    pdwSize = Pointer to a <b>DWORD</b> containing the transfer size. This parameter must be included in both the input and
    ///              output message authentication codes.
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message authentication code is not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NORIGHTS</b></dt> </dl> </td> <td width="60%">
    ///    The caller does not have the rights required to perform the requested operation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method failed. Terminate
    ///    interaction with the secure content provider. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is an invalid or <b>NULL</b> pointer.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> </table>
    ///    
    HRESULT ObjectData(ubyte* pData, uint* pdwSize, ubyte* abMac);
    ///The <b>TransferComplete</b> method is called by Windows Media Device Manager to signal the end of a secure
    ///transfer of data. In this method, the secure content provider can perform any additional processing required to
    ///enable the content on the target device.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NOT_CERTIFIED</b></dt> </dl> </td> <td width="60%"> The caller is not authorized to use this
    ///    interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NORIGHTS</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have the rights required to perform the requested operation. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message
    ///    authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT TransferComplete();
}

///The <b>ISCPSecureExchange2</b> interface extends ISCPSecureExchange by providing a new version of the
///<b>TransferContainerData</b> method. <b>TransferContainerData2</b> accepts a progress callback on which the secure
///content provider can send progress notifications for any of the steps it needs to carry out.
@GUID("6C62FC7B-2690-483F-9D44-0A20CB35577C")
interface ISCPSecureExchange2 : ISCPSecureExchange
{
    ///The <b>TransferContainerData2</b> method transfers container file data to the secure content provider. The secure
    ///content provider breaks down the container internally and reports which parts of the content are available as
    ///they are extracted from the container. This method extends ISCPSecureExchange::TransferContainerData by accepting
    ///a progress callback on which the secure content provider can send progress notifications for any of the steps it
    ///needs to carry out.
    ///Params:
    ///    pData = Pointer to a buffer holding the current data being transferred from the container file. This parameter must
    ///            be included in the input message authentication code and must be encrypted.
    ///    dwSize = <b>DWORD</b> that contains the number of bytes in the buffer. This parameter must be included in the input
    ///             message authentication code.
    ///    pProgressCallback = Progress callback on which the secure content provider can report progress of any steps that it might need to
    ///                        carry out. The step will be identified by the <i>EventId</i> parameter of IWMDMProgress3 methods.
    ///    pfuReadyFlags = Flag indicating which parts of the container file are ready to be read. This parameter is included in the
    ///                    output message authentication code. The following flags indicate what is ready. <table> <tr> <th>Flag </th>
    ///                    <th>Description </th> </tr> <tr> <td>WMDM_SCP_TRANSFER_OBJECTDATA</td> <td>Data of the object is available by
    ///                    calling the ObjectData method.</td> </tr> <tr> <td>WMDM_SCP_NO_MORE_CHANGES</td> <td>The secure content
    ///                    provider has determined that it requires no further processing and/or modification of the file being
    ///                    transferred. Windows Media Device Manager can directly transfer the remainder of the file to the device.</td>
    ///                    </tr> </table>
    ///    abMac = Array of eight bytes containing the message authentication code for the parameter data of this method.
    ///            (WMDM_MAC_LENGTH is defined as 8.)
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NOT_CERTIFIED</b></dt> </dl> </td> <td width="60%"> The caller is not authorized to use this
    ///    interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NORIGHTS</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have the rights required to perform the requested operation. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message
    ///    authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> The method failed. Terminate interaction with the secure content provider. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is invalid or is
    ///    a <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT TransferContainerData2(ubyte* pData, uint dwSize, IWMDMProgress3 pProgressCallback, 
                                   uint* pfuReadyFlags, ubyte* abMac);
}

///The <b>ISCPSecureExchange3</b> interface extends <b>ISCPSecureExchange2</b> by providing improved data exchange
///performance, and a transfer-complete callback method.
@GUID("AB4E77E4-8908-4B17-BD2A-B1DBE6DD69E1")
interface ISCPSecureExchange3 : ISCPSecureExchange2
{
    ///The <b>TransferContainerDataOnClearChannel</b> method transfers container file data to the content provider
    ///through the clear channel. The content provider breaks down the container internally and reports which parts of
    ///the content are available as they are extracted from the container. This method is identical to
    ///ISCPSecureExchange::TransferContainerData except that the parameters passed to this method are not encrypted.
    ///Consequently this method is more efficient.
    ///Params:
    ///    pDevice = Pointer to a device object.
    ///    pData = Pointer to a buffer holding the current data being transferred from the container file.
    ///    dwSize = Contains the number of bytes in the buffer.
    ///    pProgressCallback = Progress callback on which the content provider can report progress of any steps that it might need to carry
    ///                        out. The step will be identified by the <i>EventId</i> parameter of IWMDMProgress3 methods.
    ///    pfuReadyFlags = Flag indicating which parts of the container file are ready to be read. This parameter is included in the
    ///                    output message authentication code. The following flags indicate what is ready. <table> <tr> <th>Value</th>
    ///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WMDM_SCP_TRANSFER_OBJECTDATA"></a><a
    ///                    id="wmdm_scp_transfer_objectdata"></a><dl> <dt><b>WMDM_SCP_TRANSFER_OBJECTDATA</b></dt> </dl> </td> <td
    ///                    width="60%"> Data of the object is available by calling the GetObjectDataOnClearChannel method. </td> </tr>
    ///                    <tr> <td width="40%"><a id="WMDM_SCP_NO_MORE_CHANGES"></a><a id="wmdm_scp_no_more_changes"></a><dl>
    ///                    <dt><b>WMDM_SCP_NO_MORE_CHANGES</b></dt> </dl> </td> <td width="60%"> The content provider has determined
    ///                    that it requires no further processing and/or modification of the file being transferred. Windows Media
    ///                    Device Manager can directly transfer the remainder of the file to the device. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method fails, it returns an <b>HRESULT</b> error code.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NOT_CERTIFIED</b></dt> </dl> </td> <td width="60%"> The caller is not authorized to use this
    ///    interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NORIGHTS</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have the rights required to perform the requested operation. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message
    ///    authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> The method failed. Terminate interaction with the content provider. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is invalid or is a
    ///    <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT TransferContainerDataOnClearChannel(IMDSPDevice pDevice, ubyte* pData, uint dwSize, 
                                                IWMDMProgress3 pProgressCallback, uint* pfuReadyFlags);
    HRESULT GetObjectDataOnClearChannel(IMDSPDevice pDevice, ubyte* pData, uint* pdwSize);
    ///The <b>TransferCompleteForDevice</b> method is called by Windows Media Device Manager to signal the end of a data
    ///transfer for a specific device.
    ///Params:
    ///    pDevice = Pointer to a device object.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method fails, it returns an <b>HRESULT</b> error code.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NOT_CERTIFIED</b></dt> </dl> </td> <td width="60%"> The caller is not authorized to use this
    ///    interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_NORIGHTS</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have the rights required to perform the requested operation. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%"> The message
    ///    authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT TransferCompleteForDevice(IMDSPDevice pDevice);
}

///The <b>ISCPSession</b> interface provides efficient common state management for multiple operations. A secure content
///provider (SCP) session is useful when transferring multiple files. In that case, the session can help SCP do some of
///the operations only once instead of once for every file transfer. This results in better transfer performance.
@GUID("88A3E6ED-EEE4-4619-BBB3-FD4FB62715D1")
interface ISCPSession : IUnknown
{
    ///The <b>BeginSession</b> method indicates beginning of a transfer session. It can be used to optimize operations
    ///that need to occur only once per transfer session.
    ///Params:
    ///    pIDevice = Pointer to an IMDSPDevice object.
    ///    pCtx = Pointer to the context.
    ///    dwSizeCtx = <b>DWORD</b> containing the size of context.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT BeginSession(IMDSPDevice pIDevice, ubyte* pCtx, uint dwSizeCtx);
    ///The <b>EndSession</b> method indicates the ending of a transfer session.
    ///Params:
    ///    pCtx = Pointer to the context.
    ///    dwSizeCtx = <b>DWORD</b> containing the size of context.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT EndSession(ubyte* pCtx, uint dwSizeCtx);
    ///The <b>GetSecureQuery</b> method is used to obtain a secure query object for the session.
    ///Params:
    ///    ppSecureQuery = Pointer to a secure query object.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

///The <b>ISCPSecureQuery3</b> interface extends ISCPSecureQuery2 by providing a set of new methods for retrieving the
///rights and making decision on a clear channel. These methods are more efficient because they do not involve
///encrypting and decrypting of parameters, which happens on a secure channel.
@GUID("B7EDD1A2-4DAB-484B-B3C5-AD39B8B4C0B1")
interface ISCPSecureQuery3 : ISCPSecureQuery2
{
    ///The <b>GetRightsOnClearChannel</b> method retrieves rights information for the current piece of content on a
    ///clear channel.
    ///Params:
    ///    pData = Pointer to data object.
    ///    dwSize = Number of bytes of data in the <i>pData</i> buffer.
    ///    pbSPSessionKey = Pointer to an array of bytes containing the session key for securing communication with the service provider
    ///                     to which <i>pStgGlobals</i> points.
    ///    dwSessionKeyLen = Length of the byte array to which <i>pbSPSessionKey</i> points.
    ///    pStgGlobals = Pointer to an IWMDMStorageGlobals interface on the root storage of the media or device to or from which the
    ///                  file is being transferred.
    ///    pProgressCallback = Pointer to an IWMDMProgress3 interface.
    ///    ppRights = Pointer to an array of WMDMRIGHTS structures containing the rights information for this object. The array is
    ///               allocated by this method and must be freed using <b>CoTaskMemFree</b>.
    ///    pnRightsCount = Number of <b>WMDMRIGHTS</b> structures in the <i>ppRights</i> array.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method fails, it returns an <b>HRESULT</b> error code.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_CALL_OUT_OF_SEQUENCE</b></dt> </dl> </td> <td width="60%"> This method was called out of
    ///    sequence. ISCPSecureQuery::GetDataDemands and then ISCPSecureQuery::ExamineDatamust be called, in that order.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td width="60%">
    ///    The message authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_NORIGHTS</b></dt> </dl> </td> <td width="60%"> The caller does not have the rights required to
    ///    perform the requested operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> A parameter is invalid or is a <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetRightsOnClearChannel(ubyte* pData, uint dwSize, ubyte* pbSPSessionKey, uint dwSessionKeyLen, 
                                    IMDSPStorageGlobals pStgGlobals, IWMDMProgress3 pProgressCallback, 
                                    __WMDMRIGHTS** ppRights, uint* pnRightsCount);
    ///The <b>MakeDecisionOnClearChannel</b> method determines whether access to the content is allowed on a clear
    ///channel. If access is allowed, this method returns the interface used to access the content.
    ///Params:
    ///    fuFlags = Flags describing the data offered to the content provider for making decisions. The following flags can be
    ///              present. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr> <td>WMDM_SCP_DECIDE_DATA</td> <td>The
    ///              <i>pData</i> parameter points to data to be examined.</td> </tr> <tr> <td>WMDM_MODE_TRANSFER_PROTECTED</td>
    ///              <td>The output object data from the ISCPSecureExchange interface must be protected. If Windows Media Device
    ///              Manager sets neither or both mode flags, digital rights management (DRM) decides whether the output object
    ///              data from the <b>ISCPSecureExchange</b> interface must be protected or unprotected.</td> </tr> <tr>
    ///              <td>WMDM_MODE_TRANSFER_UNPROTECTED</td> <td>The output object data from the <b>ISCPSecureExchange</b>
    ///              interface must be unprotected. If Windows Media Device Manager sets neither or both mode flags, digital
    ///              rights management (DRM) decides whether the output object data from the <b>ISCPSecureExchange</b> interface
    ///              must be protected or unprotected.</td> </tr> </table>
    ///    pData = Pointer to a data object containing the data to be examined.
    ///    dwSize = <b>DWORD</b> that contains the length, in bytes, of the data to be examined.
    ///    dwAppSec = <b>DWORD</b> that indicates the current level of security of Windows Media Device Manager. This is the
    ///               smaller of the current security levels of the application and the target service provider.
    ///    pbSPSessionKey = Pointer to an array of bytes containing the session key for securing communication with the service provider
    ///                     to which <i>pStgGlobals</i> points.
    ///    dwSessionKeyLen = Length of the byte array to which <i>pbSPSessionKey</i> points.
    ///    pStorageGlobals = Pointer to the IWMDMStorageGlobals interface on the root storage of the media or device to or from which the
    ///                      file is being transferred.
    ///    pProgressCallback = Pointer to a progress callback object.
    ///    pAppCertApp = Pointer to an application certificate of the application object.
    ///    dwAppCertAppLen = <b>DWORD</b> containing the length, in bytes, of the application certificate.
    ///    pAppCertSP = Pointer to the application certificate of the service provider object.
    ///    dwAppCertSPLen = <b>DWORD</b> containing the length, in bytes, of the application certificate.
    ///    pszRevocationURL = Pointer to a buffer to hold the revocation URL.
    ///    pdwRevocationURLLen = Pointer to a <b>DWORD</b> containing the size of the <i>rpszRevocationURL</i> buffer in bytes.
    ///    pdwRevocationBitFlag = Pointer to a <b>DWORD</b> containing the revocation bit flag. The flag value will be either zero or one or
    ///                           more of the following flag names combined by using a bitwise <b>OR</b>. <table> <tr> <th>Value </th>
    ///                           <th>Description </th> </tr> <tr> <td>WMDM_WMDM_REVOKED</td> <td>Windows Media Device Manager itself has been
    ///                           revoked.</td> </tr> <tr> <td>WMDM_APP_REVOKED</td> <td>The application has been revoked and needs to be
    ///                           updated before any DRM-protected content can be transferred.</td> </tr> <tr> <td>WMDM_SP_REVOKED</td> <td>The
    ///                           service provider has been revoked and needs to be updated before any DRM-protected content can be transferred
    ///                           to it.</td> </tr> <tr> <td>WMDM_SCP_REVOKED</td> <td>The content provider has been revoked and needs to be
    ///                           updated before any DRM-protected content can be transferred.</td> </tr> </table>
    ///    pqwFileSize = Pointer to a <b>QWORD</b> containing the file size. The content provider is responsible for updating this
    ///                  value or setting it to zero if the size of the destination file cannot be determined at this point.
    ///    pUnknown = Pointer to an unknown interface from the application.
    ///    ppExchange = Pointer to an exchange object that receives the exchange interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method fails, it returns an <b>HRESULT</b> error code.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_CALL_OUT_OF_SEQUENCE</b></dt> </dl> </td> <td width="60%"> This method was called out of
    ///    sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WMDM_E_MAC_CHECK_FAILED</b></dt> </dl> </td> <td
    ///    width="60%"> The message authentication code is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WMDM_E_MOREDATA</b></dt> </dl> </td> <td width="60%"> Windows Media Device Manager must call this
    ///    method again with another packet of data. The size of the packet is determined by the
    ///    <i>pdwMinDecisionData</i> parameter in the ISCPSecureQuery::GetDataDemands method. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The caller does not have the rights
    ///    required to perform the requested transfer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is invalid or is a <b>NULL</b> pointer.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> </table>
    ///    
    HRESULT MakeDecisionOnClearChannel(uint fuFlags, ubyte* pData, uint dwSize, uint dwAppSec, 
                                       ubyte* pbSPSessionKey, uint dwSessionKeyLen, 
                                       IMDSPStorageGlobals pStorageGlobals, IWMDMProgress3 pProgressCallback, 
                                       ubyte* pAppCertApp, uint dwAppCertAppLen, ubyte* pAppCertSP, 
                                       uint dwAppCertSPLen, PWSTR* pszRevocationURL, uint* pdwRevocationURLLen, 
                                       uint* pdwRevocationBitFlag, ulong* pqwFileSize, IUnknown pUnknown, 
                                       ISCPSecureExchange* ppExchange);
}

///The <b>IComponentAuthenticate</b> interface provides secure, encrypted communication between modules of Windows Media
///Device Manager. It is implemented by a service provider and created and used by an application or plug-in. To get
///this interface, the application calls <b>CoCreateInstance</b> (__uuidof(MediaDevMgr)). The application creates and
///passes this interface to CSecureChannelClient::SetInterface, but never calls any methods on this interface. The
///service provider implements the methods in this interface, and calls them on a private CSecureChannelServer member.
@GUID("A9889C00-6D2B-11D3-8496-00C04F79DBC0")
interface IComponentAuthenticate : IUnknown
{
    ///The <b>SACAuth</b> method establishes a secure authenticated channel between components.
    ///Params:
    ///    dwProtocolID = <b>DWORD</b> containing the protocol identifier. For this version of Windows Media Device Manager, always set
    ///                   this parameter to SAC_PROTOCOL_V1.
    ///    dwPass = <b>DWORD</b> containing the number of the current communication pass. A pass consists of two messages, one in
    ///             each direction. SAC_PROTOCOL_V1 is a two-pass protocol, and the passes are numbered 0 and 1.
    ///    pbDataIn = Pointer to the input data.
    ///    dwDataInLen = <b>DWORD</b> containing the length of the data to which <i>pbDataIn</i> points.
    ///    ppbDataOut = Pointer to a pointer to the output data.
    ///    pdwDataOutLen = Pointer to a <b>DWORD</b> containing the length of the data to which <i>ppbDataOut</i> points.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SACAuth(uint dwProtocolID, uint dwPass, ubyte* pbDataIn, uint dwDataInLen, ubyte** ppbDataOut, 
                    uint* pdwDataOutLen);
    ///The <b>SACGetProtocols</b> method is used by a component to discover the authentication protocols supported by
    ///another component.
    ///Params:
    ///    ppdwProtocols = Pointer to an array of supported protocols. For this version of Windows Media Device Manager, it is a
    ///                    single-element <b>DWORD</b> array containing the value SAC_PROTOCOL_V1.
    ///    pdwProtocolCount = Pointer to a <b>DWORD</b> containing the number of protocols returned in <i>ppdwProtocols</i>. The number is
    ///                       always 1 for this version.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SACGetProtocols(uint** ppdwProtocols, uint* pdwProtocolCount);
}

///The <b>IWMDMLogger</b> interface is used by Windows Media Device Manager applications and service providers to log
///entries in a common log file. Components do not need to be certified to use this object. This interface is exposed by
///a COM object that must be created using the class ID CLSID_WMDMLogger, as shown here: ```cpp IWMDMLogger* m_pLogger =
///NULL; CoCreateInstance(CLSID_WMDMLogger, NULL, CLSCTX_ALL, __uuidof(IWMDMLogger), (void**)&m_pLogger); ``` This
///interface GUID is not properly defined in mssachlp.lib; therefore, to get the proper definitions when implementing
///this interface, you must #include both mswmdm.h and wmdmlog_i.c from wmdmlog.idl.
@GUID("110A3200-5A79-11D3-8D78-444553540000")
interface IWMDMLogger : IUnknown
{
    ///The <b>IsEnabled</b> method determines whether logging is enabled.
    ///Params:
    ///    pfEnabled = Pointer to a flag that is true on output if logging is enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT IsEnabled(BOOL* pfEnabled);
    ///The <b>Enable</b> method enables or disables logging. Logging is enabled by default.
    ///Params:
    ///    fEnable = Flag that enables logging if it is true and disables logging if it is <b>false</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Enable(BOOL fEnable);
    ///The <b>GetLogFileName</b> method returns the full path to the current log file.
    ///Params:
    ///    pszFilename = Pointer to a buffer to receive the log file name.
    ///    nMaxChars = Specifies the size of the <i>pszFilename</i> buffer. This is the maximum number of characters that can be
    ///                placed in the buffer, including the terminating <b>NULL</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetLogFileName(PSTR pszFilename, uint nMaxChars);
    ///The <b>SetLogFileName</b> method sets the full path to the current log file. All subsequent log entries will be
    ///placed in this file.
    ///Params:
    ///    pszFilename = Pointer to a string that is the full path to the new log file. Note that this is not a wide-character string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT SetLogFileName(PSTR pszFilename);
    ///The <b>LogString</b> method logs a string to the current log file. A carriage return and line feed are added to
    ///each log entry.
    ///Params:
    ///    dwFlags = Flags that control the way a string is logged. This parameter is a combination of one or more of the
    ///              following values. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>WMDM_LOG_SEV_INFO</td>
    ///              <td>Tag the log entry as informational.</td> </tr> <tr> <td>WMDM_LOG_SEV_WARN</td> <td>Tag the log entry as a
    ///              warning.</td> </tr> <tr> <td>WMDM_LOG_SEV_ERROR</td> <td>Tag the log entry as an error.</td> </tr> <tr>
    ///              <td>WMDM_LOG_NOTIMESTAMP</td> <td>Do not include a time stamp on the log entry. Time stamps are in ISO format
    ///              minus the time-zone information.</td> </tr> </table>
    ///    pszSrcName = Pointer to a string containing the name of the module that is making the log entry. This parameter can be
    ///                 <b>NULL</b>.
    ///    pszLog = Pointer to a string to be copied to the log. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT LogString(uint dwFlags, PSTR pszSrcName, PSTR pszLog);
    ///The <b>LogDword</b> method logs a <b>DWORD</b> value to the current log file. A carriage return and line feed are
    ///added to each log entry.
    ///Params:
    ///    dwFlags = Flags that control the way a string is logged. This parameter is a combination of one or more of the
    ///              following values. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>WMDM_LOG_SEV_INFO</td>
    ///              <td>Tag the log entry as informational.</td> </tr> <tr> <td>WMDM_LOG_SEV_WARN</td> <td>Tag the log entry as a
    ///              warning.</td> </tr> <tr> <td>WMDM_LOG_SEV_ERROR</td> <td>Tag the log entry as an error.</td> </tr> <tr>
    ///              <td>WMDM_LOG_NOTIMESTAMP</td> <td>Do not include a time stamp on the log entry. Time stamps are in ISO format
    ///              minus the time-zone information.</td> </tr> </table>
    ///    pszSrcName = Optional pointer to a string containing the name of the module that is making the log entry.
    ///    pszLogFormat = Pointer to a string that specifies the format of the log string. This string is of the same form as the
    ///                   format string for the <b>printf</b> function.
    ///    dwLog = <b>DWORD</b> value to log.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT LogDword(uint dwFlags, PSTR pszSrcName, PSTR pszLogFormat, uint dwLog);
    ///The <b>Reset</b> method deletes the contents of the current log file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT Reset();
    ///The <b>GetSizeParams</b> method retrieves the current size parameters of the current log file.
    ///Params:
    ///    pdwMaxSize = Pointer to a buffer that receives the approximate maximum size of the log file. This parameter can be
    ///                 <b>NULL</b>.
    ///    pdwShrinkToSize = Pointer to a buffer that receives the approximate size to which the log file will be reduced after it reaches
    ///                      the maximum size. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes.
    ///    
    HRESULT GetSizeParams(uint* pdwMaxSize, uint* pdwShrinkToSize);
    ///The <b>SetSizeParams</b> method sets the current size parameters for the current log file.
    ///Params:
    ///    dwMaxSize = The approximate maximum size of the log file. The size of the log file is checked before each log entry is
    ///                made. Therefore, the log file can grow bigger than the maximum size until the next log entry is made.
    ///    dwShrinkToSize = The approximate file size to which the log file should be reduced when the maximum log file size is reached.
    ///                     The log file is generally shrunk to a little smaller than this value so that the file is not split in the
    ///                     middle of a log entry.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. All the interface methods in Windows Media Device Manager can return
    ///    any of the following classes of error codes: <ul> <li>Standard COM error codes </li> <li>Windows error codes
    ///    converted to HRESULT values </li> <li>Windows Media Device Manager error codes </li> </ul> For an extensive
    ///    list of possible error codes, see Error Codes. The method returns an <b>HRESULT</b>. All the interface
    ///    methods in Windows Media Device Manager can return any of the following classes of error codes:
    ///    
    HRESULT SetSizeParams(uint dwMaxSize, uint dwShrinkToSize);
}


// GUIDs

const GUID CLSID_MediaDevMgr             = GUIDOF!MediaDevMgr;
const GUID CLSID_MediaDevMgrClassFactory = GUIDOF!MediaDevMgrClassFactory;
const GUID CLSID_WMDMDevice              = GUIDOF!WMDMDevice;
const GUID CLSID_WMDMDeviceEnum          = GUIDOF!WMDMDeviceEnum;
const GUID CLSID_WMDMLogger              = GUIDOF!WMDMLogger;
const GUID CLSID_WMDMStorage             = GUIDOF!WMDMStorage;
const GUID CLSID_WMDMStorageEnum         = GUIDOF!WMDMStorageEnum;
const GUID CLSID_WMDMStorageGlobal       = GUIDOF!WMDMStorageGlobal;

const GUID IID_IComponentAuthenticate  = GUIDOF!IComponentAuthenticate;
const GUID IID_IMDSPDevice             = GUIDOF!IMDSPDevice;
const GUID IID_IMDSPDevice2            = GUIDOF!IMDSPDevice2;
const GUID IID_IMDSPDevice3            = GUIDOF!IMDSPDevice3;
const GUID IID_IMDSPDeviceControl      = GUIDOF!IMDSPDeviceControl;
const GUID IID_IMDSPDirectTransfer     = GUIDOF!IMDSPDirectTransfer;
const GUID IID_IMDSPEnumDevice         = GUIDOF!IMDSPEnumDevice;
const GUID IID_IMDSPEnumStorage        = GUIDOF!IMDSPEnumStorage;
const GUID IID_IMDSPObject             = GUIDOF!IMDSPObject;
const GUID IID_IMDSPObject2            = GUIDOF!IMDSPObject2;
const GUID IID_IMDSPObjectInfo         = GUIDOF!IMDSPObjectInfo;
const GUID IID_IMDSPRevoked            = GUIDOF!IMDSPRevoked;
const GUID IID_IMDSPStorage            = GUIDOF!IMDSPStorage;
const GUID IID_IMDSPStorage2           = GUIDOF!IMDSPStorage2;
const GUID IID_IMDSPStorage3           = GUIDOF!IMDSPStorage3;
const GUID IID_IMDSPStorage4           = GUIDOF!IMDSPStorage4;
const GUID IID_IMDSPStorageGlobals     = GUIDOF!IMDSPStorageGlobals;
const GUID IID_IMDServiceProvider      = GUIDOF!IMDServiceProvider;
const GUID IID_IMDServiceProvider2     = GUIDOF!IMDServiceProvider2;
const GUID IID_IMDServiceProvider3     = GUIDOF!IMDServiceProvider3;
const GUID IID_ISCPSecureAuthenticate  = GUIDOF!ISCPSecureAuthenticate;
const GUID IID_ISCPSecureAuthenticate2 = GUIDOF!ISCPSecureAuthenticate2;
const GUID IID_ISCPSecureExchange      = GUIDOF!ISCPSecureExchange;
const GUID IID_ISCPSecureExchange2     = GUIDOF!ISCPSecureExchange2;
const GUID IID_ISCPSecureExchange3     = GUIDOF!ISCPSecureExchange3;
const GUID IID_ISCPSecureQuery         = GUIDOF!ISCPSecureQuery;
const GUID IID_ISCPSecureQuery2        = GUIDOF!ISCPSecureQuery2;
const GUID IID_ISCPSecureQuery3        = GUIDOF!ISCPSecureQuery3;
const GUID IID_ISCPSession             = GUIDOF!ISCPSession;
const GUID IID_IWMDMDevice             = GUIDOF!IWMDMDevice;
const GUID IID_IWMDMDevice2            = GUIDOF!IWMDMDevice2;
const GUID IID_IWMDMDevice3            = GUIDOF!IWMDMDevice3;
const GUID IID_IWMDMDeviceControl      = GUIDOF!IWMDMDeviceControl;
const GUID IID_IWMDMDeviceSession      = GUIDOF!IWMDMDeviceSession;
const GUID IID_IWMDMEnumDevice         = GUIDOF!IWMDMEnumDevice;
const GUID IID_IWMDMEnumStorage        = GUIDOF!IWMDMEnumStorage;
const GUID IID_IWMDMLogger             = GUIDOF!IWMDMLogger;
const GUID IID_IWMDMMetaData           = GUIDOF!IWMDMMetaData;
const GUID IID_IWMDMNotification       = GUIDOF!IWMDMNotification;
const GUID IID_IWMDMObjectInfo         = GUIDOF!IWMDMObjectInfo;
const GUID IID_IWMDMOperation          = GUIDOF!IWMDMOperation;
const GUID IID_IWMDMOperation2         = GUIDOF!IWMDMOperation2;
const GUID IID_IWMDMOperation3         = GUIDOF!IWMDMOperation3;
const GUID IID_IWMDMProgress           = GUIDOF!IWMDMProgress;
const GUID IID_IWMDMProgress2          = GUIDOF!IWMDMProgress2;
const GUID IID_IWMDMProgress3          = GUIDOF!IWMDMProgress3;
const GUID IID_IWMDMRevoked            = GUIDOF!IWMDMRevoked;
const GUID IID_IWMDMStorage            = GUIDOF!IWMDMStorage;
const GUID IID_IWMDMStorage2           = GUIDOF!IWMDMStorage2;
const GUID IID_IWMDMStorage3           = GUIDOF!IWMDMStorage3;
const GUID IID_IWMDMStorage4           = GUIDOF!IWMDMStorage4;
const GUID IID_IWMDMStorageControl     = GUIDOF!IWMDMStorageControl;
const GUID IID_IWMDMStorageControl2    = GUIDOF!IWMDMStorageControl2;
const GUID IID_IWMDMStorageControl3    = GUIDOF!IWMDMStorageControl3;
const GUID IID_IWMDMStorageGlobals     = GUIDOF!IWMDMStorageGlobals;
const GUID IID_IWMDeviceManager        = GUIDOF!IWMDeviceManager;
const GUID IID_IWMDeviceManager2       = GUIDOF!IWMDeviceManager2;
const GUID IID_IWMDeviceManager3       = GUIDOF!IWMDeviceManager3;
