module windows.windowsmediadevicemanager;

public import windows.core;
public import windows.com : HRESULT, ISpecifyPropertyPages, IUnknown;
public import windows.displaydevices : RECT;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


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
alias WMDM_TAG_DATATYPE = int;

enum : int
{
    WMDM_SESSION_NONE                 = 0x00000000,
    WMDM_SESSION_TRANSFER_TO_DEVICE   = 0x00000001,
    WMDM_SESSION_TRANSFER_FROM_DEVICE = 0x00000010,
    WMDM_SESSION_DELETE               = 0x00000100,
    WMDM_SESSION_CUSTOM               = 0x00001000,
}
alias WMDM_SESSION_TYPE = int;

enum : int
{
    ENUM_MODE_RAW             = 0x00000000,
    ENUM_MODE_USE_DEVICE_PREF = 0x00000001,
    ENUM_MODE_METADATA_VIEWS  = 0x00000002,
}
alias WMDM_STORAGE_ENUM_MODE = int;

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
alias WMDM_FORMATCODE = int;

enum : int
{
    WMDM_ENUM_PROP_VALID_VALUES_ANY   = 0x00000000,
    WMDM_ENUM_PROP_VALID_VALUES_RANGE = 0x00000001,
    WMDM_ENUM_PROP_VALID_VALUES_ENUM  = 0x00000002,
}
alias WMDM_ENUM_PROP_VALID_VALUES_FORM = int;

enum : int
{
    WMDM_FIND_SCOPE_GLOBAL             = 0x00000000,
    WMDM_FIND_SCOPE_IMMEDIATE_CHILDREN = 0x00000001,
}
alias WMDM_FIND_SCOPE = int;

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

enum uint MTP_COMMAND_MAX_PARAMS = 0x00000005;
enum ushort MTP_RESPONSE_OK = 0x2001;

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
    const(wchar)* pwszMimeType;
    uint          dwReserved;
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
    ushort*  pwszViewName;
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
    const(wchar)* pwszPropName;
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

struct MTP_COMMAND_DATA_IN
{
align (1):
    ushort   OpCode;
    uint     NumParams;
    uint[5]  Params;
    uint     NextPhase;
    uint     CommandWriteDataSize;
    ubyte[1] CommandWriteData;
}

struct MTP_COMMAND_DATA_OUT
{
align (1):
    ushort   ResponseCode;
    uint     NumParams;
    uint[5]  Params;
    uint     CommandReadDataSize;
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

@GUID("EC3B0663-0951-460A-9A80-0DCEED3C043C")
interface IWMDMMetaData : IUnknown
{
    HRESULT AddItem(WMDM_TAG_DATATYPE Type, const(wchar)* pwszTagName, char* pValue, uint iLength);
    HRESULT QueryByName(const(wchar)* pwszTagName, WMDM_TAG_DATATYPE* pType, char* pValue, uint* pcbLength);
    HRESULT QueryByIndex(uint iIndex, ushort** ppwszName, WMDM_TAG_DATATYPE* pType, char* ppValue, uint* pcbLength);
    HRESULT GetItemCount(uint* iCount);
}

@GUID("1DCB3A00-33ED-11D3-8470-00C04F79DBC0")
interface IWMDeviceManager : IUnknown
{
    HRESULT GetRevision(uint* pdwRevision);
    HRESULT GetDeviceCount(uint* pdwCount);
    HRESULT EnumDevices(IWMDMEnumDevice* ppEnumDevice);
}

@GUID("923E5249-8731-4C5B-9B1C-B8B60B6E46AF")
interface IWMDeviceManager2 : IWMDeviceManager
{
    HRESULT GetDeviceFromCanonicalName(const(wchar)* pwszCanonicalName, IWMDMDevice* ppDevice);
    HRESULT EnumDevices2(IWMDMEnumDevice* ppEnumDevice);
    HRESULT Reinitialize();
}

@GUID("AF185C41-100D-46ED-BE2E-9CE8C44594EF")
interface IWMDeviceManager3 : IWMDeviceManager2
{
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

@GUID("1DCB3A07-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMStorageGlobals : IUnknown
{
    HRESULT GetCapabilities(uint* pdwCapabilities);
    HRESULT GetSerialNumber(__WMDMID* pSerialNum, char* abMac);
    HRESULT GetTotalSize(uint* pdwTotalSizeLow, uint* pdwTotalSizeHigh);
    HRESULT GetTotalFree(uint* pdwFreeLow, uint* pdwFreeHigh);
    HRESULT GetTotalBad(uint* pdwBadLow, uint* pdwBadHigh);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Initialize(uint fuMode, IWMDMProgress pProgress);
}

@GUID("1DCB3A06-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMStorage : IUnknown
{
    HRESULT SetAttributes(uint dwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT GetStorageGlobals(IWMDMStorageGlobals* ppStorageGlobals);
    HRESULT GetAttributes(uint* pdwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT GetName(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetDate(WMDMDATETIME* pDateTimeUTC);
    HRESULT GetSize(uint* pdwSizeLow, uint* pdwSizeHigh);
    HRESULT GetRights(char* ppRights, uint* pnRightsCount, char* abMac);
    HRESULT EnumStorage(IWMDMEnumStorage* pEnumStorage);
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

@GUID("1ED5A144-5CD5-4683-9EFF-72CBDB2D9533")
interface IWMDMStorage2 : IWMDMStorage
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IWMDMStorage* ppStorage);
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
}

@GUID("97717EEA-926A-464E-96A4-247B0216026E")
interface IWMDMStorage3 : IWMDMStorage2
{
    HRESULT GetMetadata(IWMDMMetaData* ppMetadata);
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
    HRESULT CreateEmptyMetadataObject(IWMDMMetaData* ppMetadata);
    HRESULT SetEnumPreference(WMDM_STORAGE_ENUM_MODE* pMode, uint nViews, char* pViews);
}

@GUID("C225BAC5-A03A-40B8-9A23-91CF478C64A6")
interface IWMDMStorage4 : IWMDMStorage3
{
    HRESULT SetReferences(uint dwRefs, char* ppIWMDMStorage);
    HRESULT GetReferences(uint* pdwRefs, char* pppIWMDMStorage);
    HRESULT GetRightsWithProgress(IWMDMProgress3 pIProgressCallback, char* ppRights, uint* pnRightsCount);
    HRESULT GetSpecifiedMetadata(uint cProperties, char* ppwszPropNames, IWMDMMetaData* ppMetadata);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IWMDMStorage* ppStorage);
    HRESULT GetParent(IWMDMStorage* ppStorage);
}

@GUID("1DCB3A0B-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMOperation : IUnknown
{
    HRESULT BeginRead();
    HRESULT BeginWrite();
    HRESULT GetObjectName(const(wchar)* pwszName, uint nMaxChars);
    HRESULT SetObjectName(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetObjectAttributes(uint* pdwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT SetObjectAttributes(uint dwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT GetObjectTotalSize(uint* pdwSize, uint* pdwSizeHigh);
    HRESULT SetObjectTotalSize(uint dwSize, uint dwSizeHigh);
    HRESULT TransferObjectData(char* pData, uint* pdwSize, char* abMac);
    HRESULT End(int* phCompletionCode, IUnknown pNewObject);
}

@GUID("33445B48-7DF7-425C-AD8F-0FC6D82F9F75")
interface IWMDMOperation2 : IWMDMOperation
{
    HRESULT SetObjectAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pFormat, 
                                 _tagVIDEOINFOHEADER* pVideoFormat);
    HRESULT GetObjectAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                                 _tagVIDEOINFOHEADER* pVideoFormat);
}

@GUID("D1F9B46A-9CA8-46D8-9D0F-1EC9BAE54919")
interface IWMDMOperation3 : IWMDMOperation
{
    HRESULT TransferObjectDataOnClearChannel(char* pData, uint* pdwSize);
}

@GUID("1DCB3A0C-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMProgress : IUnknown
{
    HRESULT Begin(uint dwEstimatedTicks);
    HRESULT Progress(uint dwTranspiredTicks);
    HRESULT End();
}

@GUID("3A43F550-B383-4E92-B04A-E6BBC660FEFC")
interface IWMDMProgress2 : IWMDMProgress
{
    HRESULT End2(HRESULT hrCompletionCode);
}

@GUID("21DE01CB-3BB4-4929-B21A-17AF3F80F658")
interface IWMDMProgress3 : IWMDMProgress2
{
    HRESULT Begin3(GUID EventId, uint dwEstimatedTicks, __OPAQUECOMMAND* pContext);
    HRESULT Progress3(GUID EventId, uint dwTranspiredTicks, __OPAQUECOMMAND* pContext);
    HRESULT End3(GUID EventId, HRESULT hrCompletionCode, __OPAQUECOMMAND* pContext);
}

@GUID("1DCB3A02-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMDevice : IUnknown
{
    HRESULT GetName(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetManufacturer(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetVersion(uint* pdwVersion);
    HRESULT GetType(uint* pdwType);
    HRESULT GetSerialNumber(__WMDMID* pSerialNumber, char* abMac);
    HRESULT GetPowerSource(uint* pdwPowerSource, uint* pdwPercentRemaining);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT GetDeviceIcon(uint* hIcon);
    HRESULT EnumStorage(IWMDMEnumStorage* ppEnumStorage);
    HRESULT GetFormatSupport(char* ppFormatEx, uint* pnFormatCount, char* pppwszMimeType, uint* pnMimeTypeCount);
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

@GUID("E34F3D37-9D67-4FC1-9252-62D28B2F8B55")
interface IWMDMDevice2 : IWMDMDevice
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IWMDMStorage* ppStorage);
    HRESULT GetFormatSupport2(uint dwFlags, char* ppAudioFormatEx, uint* pnAudioFormatCount, char* ppVideoFormatEx, 
                              uint* pnVideoFormatCount, char* ppFileType, uint* pnFileTypeCount);
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, char* pppUnknowns, uint* pcUnks);
    HRESULT GetCanonicalName(const(wchar)* pwszPnPName, uint nMaxChars);
}

@GUID("6C03E4FE-05DB-4DDA-9E3C-06233A6D5D65")
interface IWMDMDevice3 : IWMDMDevice2
{
    HRESULT GetProperty(const(wchar)* pwszPropName, PROPVARIANT* pValue);
    HRESULT SetProperty(const(wchar)* pwszPropName, const(PROPVARIANT)* pValue);
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    HRESULT DeviceIoControl(uint dwIoControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                            uint* pnOutBufferSize);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IWMDMStorage* ppStorage);
}

@GUID("82AF0A65-9D96-412C-83E5-3C43E4B06CC7")
interface IWMDMDeviceSession : IUnknown
{
    HRESULT BeginSession(WMDM_SESSION_TYPE type, char* pCtx, uint dwSizeCtx);
    HRESULT EndSession(WMDM_SESSION_TYPE type, char* pCtx, uint dwSizeCtx);
}

@GUID("1DCB3A01-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMEnumDevice : IUnknown
{
    HRESULT Next(uint celt, char* ppDevice, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IWMDMEnumDevice* ppEnumDevice);
}

@GUID("1DCB3A04-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMDeviceControl : IUnknown
{
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT GetCapabilities(uint* pdwCapabilitiesMask);
    HRESULT Play();
    HRESULT Record(_tWAVEFORMATEX* pFormat);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Stop();
    HRESULT Seek(uint fuMode, int nOffset);
}

@GUID("1DCB3A05-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMEnumStorage : IUnknown
{
    HRESULT Next(uint celt, char* ppStorage, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IWMDMEnumStorage* ppEnumStorage);
}

@GUID("1DCB3A08-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMStorageControl : IUnknown
{
    HRESULT Insert(uint fuMode, const(wchar)* pwszFile, IWMDMOperation pOperation, IWMDMProgress pProgress, 
                   IWMDMStorage* ppNewObject);
    HRESULT Delete(uint fuMode, IWMDMProgress pProgress);
    HRESULT Rename(uint fuMode, const(wchar)* pwszNewName, IWMDMProgress pProgress);
    HRESULT Read(uint fuMode, const(wchar)* pwszFile, IWMDMProgress pProgress, IWMDMOperation pOperation);
    HRESULT Move(uint fuMode, IWMDMStorage pTargetObject, IWMDMProgress pProgress);
}

@GUID("972C2E88-BD6C-4125-8E09-84F837E637B6")
interface IWMDMStorageControl2 : IWMDMStorageControl
{
    HRESULT Insert2(uint fuMode, const(wchar)* pwszFileSource, const(wchar)* pwszFileDest, 
                    IWMDMOperation pOperation, IWMDMProgress pProgress, IUnknown pUnknown, IWMDMStorage* ppNewObject);
}

@GUID("B3266365-D4F3-4696-8D53-BD27EC60993A")
interface IWMDMStorageControl3 : IWMDMStorageControl2
{
    HRESULT Insert3(uint fuMode, uint fuType, const(wchar)* pwszFileSource, const(wchar)* pwszFileDest, 
                    IWMDMOperation pOperation, IWMDMProgress pProgress, IWMDMMetaData pMetaData, IUnknown pUnknown, 
                    IWMDMStorage* ppNewObject);
}

@GUID("1DCB3A09-33ED-11D3-8470-00C04F79DBC0")
interface IWMDMObjectInfo : IUnknown
{
    HRESULT GetPlayLength(uint* pdwLength);
    HRESULT SetPlayLength(uint dwLength);
    HRESULT GetPlayOffset(uint* pdwOffset);
    HRESULT SetPlayOffset(uint dwOffset);
    HRESULT GetTotalLength(uint* pdwLength);
    HRESULT GetLastPlayPosition(uint* pdwLastPos);
    HRESULT GetLongestPlayPosition(uint* pdwLongestPos);
}

@GUID("EBECCEDB-88EE-4E55-B6A4-8D9F07D696AA")
interface IWMDMRevoked : IUnknown
{
    HRESULT GetRevocationURL(char* ppwszRevocationURL, uint* pdwBufferLen, uint* pdwRevokedBitFlag);
}

@GUID("3F5E95C0-0F43-4ED4-93D2-C89A45D59B81")
interface IWMDMNotification : IUnknown
{
    HRESULT WMDMMessage(uint dwMessageType, const(wchar)* pwszCanonicalName);
}

@GUID("1DCB3A10-33ED-11D3-8470-00C04F79DBC0")
interface IMDServiceProvider : IUnknown
{
    HRESULT GetDeviceCount(uint* pdwCount);
    HRESULT EnumDevices(IMDSPEnumDevice* ppEnumDevice);
}

@GUID("B2FA24B7-CDA3-4694-9862-413AE1A34819")
interface IMDServiceProvider2 : IMDServiceProvider
{
    HRESULT CreateDevice(const(wchar)* pwszDevicePath, uint* pdwCount, char* pppDeviceArray);
}

@GUID("4ED13EF3-A971-4D19-9F51-0E1826B2DA57")
interface IMDServiceProvider3 : IMDServiceProvider2
{
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

@GUID("1DCB3A11-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPEnumDevice : IUnknown
{
    HRESULT Next(uint celt, char* ppDevice, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IMDSPEnumDevice* ppEnumDevice);
}

@GUID("1DCB3A12-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPDevice : IUnknown
{
    HRESULT GetName(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetManufacturer(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetVersion(uint* pdwVersion);
    HRESULT GetType(uint* pdwType);
    HRESULT GetSerialNumber(__WMDMID* pSerialNumber, char* abMac);
    HRESULT GetPowerSource(uint* pdwPowerSource, uint* pdwPercentRemaining);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT GetDeviceIcon(uint* hIcon);
    HRESULT EnumStorage(IMDSPEnumStorage* ppEnumStorage);
    HRESULT GetFormatSupport(char* pFormatEx, uint* pnFormatCount, char* pppwszMimeType, uint* pnMimeTypeCount);
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

@GUID("420D16AD-C97D-4E00-82AA-00E9F4335DDD")
interface IMDSPDevice2 : IMDSPDevice
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IMDSPStorage* ppStorage);
    HRESULT GetFormatSupport2(uint dwFlags, char* ppAudioFormatEx, uint* pnAudioFormatCount, char* ppVideoFormatEx, 
                              uint* pnVideoFormatCount, char* ppFileType, uint* pnFileTypeCount);
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, char* pppUnknowns, uint* pcUnks);
    HRESULT GetCanonicalName(const(wchar)* pwszPnPName, uint nMaxChars);
}

@GUID("1A839845-FC55-487C-976F-EE38AC0E8C4E")
interface IMDSPDevice3 : IMDSPDevice2
{
    HRESULT GetProperty(const(wchar)* pwszPropName, PROPVARIANT* pValue);
    HRESULT SetProperty(const(wchar)* pwszPropName, const(PROPVARIANT)* pValue);
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    HRESULT DeviceIoControl(uint dwIoControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                            uint* pnOutBufferSize);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IMDSPStorage* ppStorage);
}

@GUID("1DCB3A14-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPDeviceControl : IUnknown
{
    HRESULT GetDCStatus(uint* pdwStatus);
    HRESULT GetCapabilities(uint* pdwCapabilitiesMask);
    HRESULT Play();
    HRESULT Record(_tWAVEFORMATEX* pFormat);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Stop();
    HRESULT Seek(uint fuMode, int nOffset);
}

@GUID("1DCB3A15-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPEnumStorage : IUnknown
{
    HRESULT Next(uint celt, char* ppStorage, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IMDSPEnumStorage* ppEnumStorage);
}

@GUID("1DCB3A16-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPStorage : IUnknown
{
    HRESULT SetAttributes(uint dwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT GetStorageGlobals(IMDSPStorageGlobals* ppStorageGlobals);
    HRESULT GetAttributes(uint* pdwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT GetName(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetDate(WMDMDATETIME* pDateTimeUTC);
    HRESULT GetSize(uint* pdwSizeLow, uint* pdwSizeHigh);
    HRESULT GetRights(char* ppRights, uint* pnRightsCount, char* abMac);
    HRESULT CreateStorage(uint dwAttributes, _tWAVEFORMATEX* pFormat, const(wchar)* pwszName, 
                          IMDSPStorage* ppNewStorage);
    HRESULT EnumStorage(IMDSPEnumStorage* ppEnumStorage);
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

@GUID("0A5E07A5-6454-4451-9C36-1C6AE7E2B1D6")
interface IMDSPStorage2 : IMDSPStorage
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IMDSPStorage* ppStorage);
    HRESULT CreateStorage2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat, const(wchar)* pwszName, ulong qwFileSize, 
                           IMDSPStorage* ppNewStorage);
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, 
                           _tagVIDEOINFOHEADER* pVideoFormat);
}

@GUID("6C669867-97ED-4A67-9706-1C5529D2A414")
interface IMDSPStorage3 : IMDSPStorage2
{
    HRESULT GetMetadata(IWMDMMetaData pMetadata);
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
}

@GUID("3133B2C4-515C-481B-B1CE-39327ECB4F74")
interface IMDSPStorage4 : IMDSPStorage3
{
    HRESULT SetReferences(uint dwRefs, char* ppISPStorage);
    HRESULT GetReferences(uint* pdwRefs, char* pppISPStorage);
    HRESULT CreateStorageWithMetadata(uint dwAttributes, const(wchar)* pwszName, IWMDMMetaData pMetadata, 
                                      ulong qwFileSize, IMDSPStorage* ppNewStorage);
    HRESULT GetSpecifiedMetadata(uint cProperties, char* ppwszPropNames, IWMDMMetaData pMetadata);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IMDSPStorage* ppStorage);
    HRESULT GetParent(IMDSPStorage* ppStorage);
}

@GUID("1DCB3A17-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPStorageGlobals : IUnknown
{
    HRESULT GetCapabilities(uint* pdwCapabilities);
    HRESULT GetSerialNumber(__WMDMID* pSerialNum, char* abMac);
    HRESULT GetTotalSize(uint* pdwTotalSizeLow, uint* pdwTotalSizeHigh);
    HRESULT GetTotalFree(uint* pdwFreeLow, uint* pdwFreeHigh);
    HRESULT GetTotalBad(uint* pdwBadLow, uint* pdwBadHigh);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Initialize(uint fuMode, IWMDMProgress pProgress);
    HRESULT GetDevice(IMDSPDevice* ppDevice);
    HRESULT GetRootStorage(IMDSPStorage* ppRoot);
}

@GUID("1DCB3A19-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPObjectInfo : IUnknown
{
    HRESULT GetPlayLength(uint* pdwLength);
    HRESULT SetPlayLength(uint dwLength);
    HRESULT GetPlayOffset(uint* pdwOffset);
    HRESULT SetPlayOffset(uint dwOffset);
    HRESULT GetTotalLength(uint* pdwLength);
    HRESULT GetLastPlayPosition(uint* pdwLastPos);
    HRESULT GetLongestPlayPosition(uint* pdwLongestPos);
}

@GUID("1DCB3A18-33ED-11D3-8470-00C04F79DBC0")
interface IMDSPObject : IUnknown
{
    HRESULT Open(uint fuMode);
    HRESULT Read(char* pData, uint* pdwSize, char* abMac);
    HRESULT Write(char* pData, uint* pdwSize, char* abMac);
    HRESULT Delete(uint fuMode, IWMDMProgress pProgress);
    HRESULT Seek(uint fuFlags, uint dwOffset);
    HRESULT Rename(const(wchar)* pwszNewName, IWMDMProgress pProgress);
    HRESULT Move(uint fuMode, IWMDMProgress pProgress, IMDSPStorage pTarget);
    HRESULT Close();
}

@GUID("3F34CD3E-5907-4341-9AF9-97F4187C3AA5")
interface IMDSPObject2 : IMDSPObject
{
    HRESULT ReadOnClearChannel(char* pData, uint* pdwSize);
    HRESULT WriteOnClearChannel(char* pData, uint* pdwSize);
}

@GUID("C2FE57A8-9304-478C-9EE4-47E397B912D7")
interface IMDSPDirectTransfer : IUnknown
{
    HRESULT TransferToDevice(const(wchar)* pwszSourceFilePath, IWMDMOperation pSourceOperation, uint fuFlags, 
                             const(wchar)* pwszDestinationName, IWMDMMetaData pSourceMetaData, 
                             IWMDMProgress pTransferProgress, IMDSPStorage* ppNewObject);
}

@GUID("A4E8F2D4-3F31-464D-B53D-4FC335998184")
interface IMDSPRevoked : IUnknown
{
    HRESULT GetRevocationURL(char* ppwszRevocationURL, uint* pdwBufferLen);
}

@GUID("1DCB3A0F-33ED-11D3-8470-00C04F79DBC0")
interface ISCPSecureAuthenticate : IUnknown
{
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

@GUID("B580CFAE-1672-47E2-ACAA-44BBECBCAE5B")
interface ISCPSecureAuthenticate2 : ISCPSecureAuthenticate
{
    HRESULT GetSCPSession(ISCPSession* ppSCPSession);
}

@GUID("1DCB3A0D-33ED-11D3-8470-00C04F79DBC0")
interface ISCPSecureQuery : IUnknown
{
    HRESULT GetDataDemands(uint* pfuFlags, uint* pdwMinRightsData, uint* pdwMinExamineData, uint* pdwMinDecideData, 
                           char* abMac);
    HRESULT ExamineData(uint fuFlags, const(wchar)* pwszExtension, char* pData, uint dwSize, char* abMac);
    HRESULT MakeDecision(uint fuFlags, char* pData, uint dwSize, uint dwAppSec, char* pbSPSessionKey, 
                         uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, ISCPSecureExchange* ppExchange, 
                         char* abMac);
    HRESULT GetRights(char* pData, uint dwSize, char* pbSPSessionKey, uint dwSessionKeyLen, 
                      IMDSPStorageGlobals pStgGlobals, char* ppRights, uint* pnRightsCount, char* abMac);
}

@GUID("EBE17E25-4FD7-4632-AF46-6D93D4FCC72E")
interface ISCPSecureQuery2 : ISCPSecureQuery
{
    HRESULT MakeDecision2(uint fuFlags, char* pData, uint dwSize, uint dwAppSec, char* pbSPSessionKey, 
                          uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, char* pAppCertApp, 
                          uint dwAppCertAppLen, char* pAppCertSP, uint dwAppCertSPLen, char* pszRevocationURL, 
                          uint* pdwRevocationURLLen, uint* pdwRevocationBitFlag, ulong* pqwFileSize, 
                          IUnknown pUnknown, ISCPSecureExchange* ppExchange, char* abMac);
}

@GUID("1DCB3A0E-33ED-11D3-8470-00C04F79DBC0")
interface ISCPSecureExchange : IUnknown
{
    HRESULT TransferContainerData(char* pData, uint dwSize, uint* pfuReadyFlags, char* abMac);
    HRESULT ObjectData(char* pData, uint* pdwSize, char* abMac);
    HRESULT TransferComplete();
}

@GUID("6C62FC7B-2690-483F-9D44-0A20CB35577C")
interface ISCPSecureExchange2 : ISCPSecureExchange
{
    HRESULT TransferContainerData2(char* pData, uint dwSize, IWMDMProgress3 pProgressCallback, uint* pfuReadyFlags, 
                                   char* abMac);
}

@GUID("AB4E77E4-8908-4B17-BD2A-B1DBE6DD69E1")
interface ISCPSecureExchange3 : ISCPSecureExchange2
{
    HRESULT TransferContainerDataOnClearChannel(IMDSPDevice pDevice, char* pData, uint dwSize, 
                                                IWMDMProgress3 pProgressCallback, uint* pfuReadyFlags);
    HRESULT GetObjectDataOnClearChannel(IMDSPDevice pDevice, char* pData, uint* pdwSize);
    HRESULT TransferCompleteForDevice(IMDSPDevice pDevice);
}

@GUID("88A3E6ED-EEE4-4619-BBB3-FD4FB62715D1")
interface ISCPSession : IUnknown
{
    HRESULT BeginSession(IMDSPDevice pIDevice, char* pCtx, uint dwSizeCtx);
    HRESULT EndSession(char* pCtx, uint dwSizeCtx);
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

@GUID("B7EDD1A2-4DAB-484B-B3C5-AD39B8B4C0B1")
interface ISCPSecureQuery3 : ISCPSecureQuery2
{
    HRESULT GetRightsOnClearChannel(char* pData, uint dwSize, char* pbSPSessionKey, uint dwSessionKeyLen, 
                                    IMDSPStorageGlobals pStgGlobals, IWMDMProgress3 pProgressCallback, 
                                    char* ppRights, uint* pnRightsCount);
    HRESULT MakeDecisionOnClearChannel(uint fuFlags, char* pData, uint dwSize, uint dwAppSec, char* pbSPSessionKey, 
                                       uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, 
                                       IWMDMProgress3 pProgressCallback, char* pAppCertApp, uint dwAppCertAppLen, 
                                       char* pAppCertSP, uint dwAppCertSPLen, char* pszRevocationURL, 
                                       uint* pdwRevocationURLLen, uint* pdwRevocationBitFlag, ulong* pqwFileSize, 
                                       IUnknown pUnknown, ISCPSecureExchange* ppExchange);
}

@GUID("A9889C00-6D2B-11D3-8496-00C04F79DBC0")
interface IComponentAuthenticate : IUnknown
{
    HRESULT SACAuth(uint dwProtocolID, uint dwPass, char* pbDataIn, uint dwDataInLen, char* ppbDataOut, 
                    uint* pdwDataOutLen);
    HRESULT SACGetProtocols(char* ppdwProtocols, uint* pdwProtocolCount);
}

@GUID("110A3200-5A79-11D3-8D78-444553540000")
interface IWMDMLogger : IUnknown
{
    HRESULT IsEnabled(int* pfEnabled);
    HRESULT Enable(BOOL fEnable);
    HRESULT GetLogFileName(const(char)* pszFilename, uint nMaxChars);
    HRESULT SetLogFileName(const(char)* pszFilename);
    HRESULT LogString(uint dwFlags, const(char)* pszSrcName, const(char)* pszLog);
    HRESULT LogDword(uint dwFlags, const(char)* pszSrcName, const(char)* pszLogFormat, uint dwLog);
    HRESULT Reset();
    HRESULT GetSizeParams(uint* pdwMaxSize, uint* pdwShrinkToSize);
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
