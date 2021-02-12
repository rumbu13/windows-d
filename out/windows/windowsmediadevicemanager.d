module windows.windowsmediadevicemanager;

public import system;
public import windows.com;
public import windows.displaydevices;
public import windows.structuredstorage;
public import windows.systemservices;

extern(Windows):

struct __MACINFO
{
    BOOL fUsed;
    ubyte abMacState;
}

const GUID CLSID_MediaDevMgrClassFactory = {0x50040C1D, 0xBDBF, 0x4924, [0xB8, 0x73, 0xF1, 0x4D, 0x6C, 0x5B, 0xFD, 0x66]};
@GUID(0x50040C1D, 0xBDBF, 0x4924, [0xB8, 0x73, 0xF1, 0x4D, 0x6C, 0x5B, 0xFD, 0x66]);
struct MediaDevMgrClassFactory;

const GUID CLSID_MediaDevMgr = {0x25BAAD81, 0x3560, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x25BAAD81, 0x3560, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
struct MediaDevMgr;

const GUID CLSID_WMDMDevice = {0x807B3CDF, 0x357A, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x807B3CDF, 0x357A, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
struct WMDMDevice;

const GUID CLSID_WMDMStorage = {0x807B3CE0, 0x357A, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x807B3CE0, 0x357A, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
struct WMDMStorage;

const GUID CLSID_WMDMStorageGlobal = {0x807B3CE1, 0x357A, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x807B3CE1, 0x357A, 0x11D3, [0x84, 0x71, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
struct WMDMStorageGlobal;

const GUID CLSID_WMDMDeviceEnum = {0x430E35AF, 0x3971, 0x11D3, [0x84, 0x74, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x430E35AF, 0x3971, 0x11D3, [0x84, 0x74, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
struct WMDMDeviceEnum;

const GUID CLSID_WMDMStorageEnum = {0xEB401A3B, 0x3AF7, 0x11D3, [0x84, 0x74, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0xEB401A3B, 0x3AF7, 0x11D3, [0x84, 0x74, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
struct WMDMStorageEnum;

enum WMDM_TAG_DATATYPE
{
    WMDM_TYPE_DWORD = 0,
    WMDM_TYPE_STRING = 1,
    WMDM_TYPE_BINARY = 2,
    WMDM_TYPE_BOOL = 3,
    WMDM_TYPE_QWORD = 4,
    WMDM_TYPE_WORD = 5,
    WMDM_TYPE_GUID = 6,
    WMDM_TYPE_DATE = 7,
}

enum WMDM_SESSION_TYPE
{
    WMDM_SESSION_NONE = 0,
    WMDM_SESSION_TRANSFER_TO_DEVICE = 1,
    WMDM_SESSION_TRANSFER_FROM_DEVICE = 16,
    WMDM_SESSION_DELETE = 256,
    WMDM_SESSION_CUSTOM = 4096,
}

struct _tWAVEFORMATEX
{
    ushort wFormatTag;
    ushort nChannels;
    uint nSamplesPerSec;
    uint nAvgBytesPerSec;
    ushort nBlockAlign;
    ushort wBitsPerSample;
    ushort cbSize;
}

struct _tagBITMAPINFOHEADER
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

struct _tagVIDEOINFOHEADER
{
    RECT rcSource;
    RECT rcTarget;
    uint dwBitRate;
    uint dwBitErrorRate;
    long AvgTimePerFrame;
    _tagBITMAPINFOHEADER bmiHeader;
}

struct WMFILECAPABILITIES
{
    const(wchar)* pwszMimeType;
    uint dwReserved;
}

struct __OPAQUECOMMAND
{
    Guid guidCommand;
    uint dwDataLen;
    ubyte* pData;
    ubyte abMAC;
}

struct __WMDMID
{
    uint cbSize;
    uint dwVendorID;
    ubyte pID;
    uint SerialNumberLength;
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
    uint cbSize;
    uint dwContentType;
    uint fuFlags;
    uint fuRights;
    uint dwAppSec;
    uint dwPlaybackCount;
    WMDMDATETIME ExpirationDate;
}

struct __WMDMMetadataView
{
    ushort* pwszViewName;
    uint nDepth;
    ushort** ppwszTags;
}

enum WMDM_STORAGE_ENUM_MODE
{
    ENUM_MODE_RAW = 0,
    ENUM_MODE_USE_DEVICE_PREF = 1,
    ENUM_MODE_METADATA_VIEWS = 2,
}

enum WMDM_FORMATCODE
{
    WMDM_FORMATCODE_NOTUSED = 0,
    WMDM_FORMATCODE_ALLIMAGES = -1,
    WMDM_FORMATCODE_UNDEFINED = 12288,
    WMDM_FORMATCODE_ASSOCIATION = 12289,
    WMDM_FORMATCODE_SCRIPT = 12290,
    WMDM_FORMATCODE_EXECUTABLE = 12291,
    WMDM_FORMATCODE_TEXT = 12292,
    WMDM_FORMATCODE_HTML = 12293,
    WMDM_FORMATCODE_DPOF = 12294,
    WMDM_FORMATCODE_AIFF = 12295,
    WMDM_FORMATCODE_WAVE = 12296,
    WMDM_FORMATCODE_MP3 = 12297,
    WMDM_FORMATCODE_AVI = 12298,
    WMDM_FORMATCODE_MPEG = 12299,
    WMDM_FORMATCODE_ASF = 12300,
    WMDM_FORMATCODE_RESERVED_FIRST = 12301,
    WMDM_FORMATCODE_RESERVED_LAST = 14335,
    WMDM_FORMATCODE_IMAGE_UNDEFINED = 14336,
    WMDM_FORMATCODE_IMAGE_EXIF = 14337,
    WMDM_FORMATCODE_IMAGE_TIFFEP = 14338,
    WMDM_FORMATCODE_IMAGE_FLASHPIX = 14339,
    WMDM_FORMATCODE_IMAGE_BMP = 14340,
    WMDM_FORMATCODE_IMAGE_CIFF = 14341,
    WMDM_FORMATCODE_IMAGE_GIF = 14343,
    WMDM_FORMATCODE_IMAGE_JFIF = 14344,
    WMDM_FORMATCODE_IMAGE_PCD = 14345,
    WMDM_FORMATCODE_IMAGE_PICT = 14346,
    WMDM_FORMATCODE_IMAGE_PNG = 14347,
    WMDM_FORMATCODE_IMAGE_TIFF = 14349,
    WMDM_FORMATCODE_IMAGE_TIFFIT = 14350,
    WMDM_FORMATCODE_IMAGE_JP2 = 14351,
    WMDM_FORMATCODE_IMAGE_JPX = 14352,
    WMDM_FORMATCODE_IMAGE_RESERVED_FIRST = 14353,
    WMDM_FORMATCODE_IMAGE_RESERVED_LAST = 16383,
    WMDM_FORMATCODE_UNDEFINEDFIRMWARE = 47106,
    WMDM_FORMATCODE_WBMP = 47107,
    WMDM_FORMATCODE_JPEGXR = 47108,
    WMDM_FORMATCODE_WINDOWSIMAGEFORMAT = 47233,
    WMDM_FORMATCODE_UNDEFINEDAUDIO = 47360,
    WMDM_FORMATCODE_WMA = 47361,
    WMDM_FORMATCODE_OGG = 47362,
    WMDM_FORMATCODE_AAC = 47363,
    WMDM_FORMATCODE_AUDIBLE = 47364,
    WMDM_FORMATCODE_FLAC = 47366,
    WMDM_FORMATCODE_QCELP = 47367,
    WMDM_FORMATCODE_AMR = 47368,
    WMDM_FORMATCODE_UNDEFINEDVIDEO = 47488,
    WMDM_FORMATCODE_WMV = 47489,
    WMDM_FORMATCODE_MP4 = 47490,
    WMDM_FORMATCODE_MP2 = 47491,
    WMDM_FORMATCODE_3GP = 47492,
    WMDM_FORMATCODE_3G2 = 47493,
    WMDM_FORMATCODE_AVCHD = 47494,
    WMDM_FORMATCODE_ATSCTS = 47495,
    WMDM_FORMATCODE_DVBTS = 47496,
    WMDM_FORMATCODE_MKV = 47497,
    WMDM_FORMATCODE_MKA = 47498,
    WMDM_FORMATCODE_MK3D = 47499,
    WMDM_FORMATCODE_UNDEFINEDCOLLECTION = 47616,
    WMDM_FORMATCODE_ABSTRACTMULTIMEDIAALBUM = 47617,
    WMDM_FORMATCODE_ABSTRACTIMAGEALBUM = 47618,
    WMDM_FORMATCODE_ABSTRACTAUDIOALBUM = 47619,
    WMDM_FORMATCODE_ABSTRACTVIDEOALBUM = 47620,
    WMDM_FORMATCODE_ABSTRACTAUDIOVIDEOPLAYLIST = 47621,
    WMDM_FORMATCODE_ABSTRACTCONTACTGROUP = 47622,
    WMDM_FORMATCODE_ABSTRACTMESSAGEFOLDER = 47623,
    WMDM_FORMATCODE_ABSTRACTCHAPTEREDPRODUCTION = 47624,
    WMDM_FORMATCODE_MEDIA_CAST = 47627,
    WMDM_FORMATCODE_WPLPLAYLIST = 47632,
    WMDM_FORMATCODE_M3UPLAYLIST = 47633,
    WMDM_FORMATCODE_MPLPLAYLIST = 47634,
    WMDM_FORMATCODE_ASXPLAYLIST = 47635,
    WMDM_FORMATCODE_PLSPLAYLIST = 47636,
    WMDM_FORMATCODE_UNDEFINEDDOCUMENT = 47744,
    WMDM_FORMATCODE_ABSTRACTDOCUMENT = 47745,
    WMDM_FORMATCODE_XMLDOCUMENT = 47746,
    WMDM_FORMATCODE_MICROSOFTWORDDOCUMENT = 47747,
    WMDM_FORMATCODE_MHTCOMPILEDHTMLDOCUMENT = 47748,
    WMDM_FORMATCODE_MICROSOFTEXCELSPREADSHEET = 47749,
    WMDM_FORMATCODE_MICROSOFTPOWERPOINTDOCUMENT = 47750,
    WMDM_FORMATCODE_UNDEFINEDMESSAGE = 47872,
    WMDM_FORMATCODE_ABSTRACTMESSAGE = 47873,
    WMDM_FORMATCODE_UNDEFINEDCONTACT = 48000,
    WMDM_FORMATCODE_ABSTRACTCONTACT = 48001,
    WMDM_FORMATCODE_VCARD2 = 48002,
    WMDM_FORMATCODE_VCARD3 = 48003,
    WMDM_FORMATCODE_UNDEFINEDCALENDARITEM = 48640,
    WMDM_FORMATCODE_ABSTRACTCALENDARITEM = 48641,
    WMDM_FORMATCODE_VCALENDAR1 = 48642,
    WMDM_FORMATCODE_VCALENDAR2 = 48643,
    WMDM_FORMATCODE_UNDEFINEDWINDOWSEXECUTABLE = 48768,
    WMDM_FORMATCODE_M4A = 1297101889,
    WMDM_FORMATCODE_3GPA = 860311617,
    WMDM_FORMATCODE_3G2A = 860303937,
    WMDM_FORMATCODE_SECTION = 48770,
}

enum WMDM_ENUM_PROP_VALID_VALUES_FORM
{
    WMDM_ENUM_PROP_VALID_VALUES_ANY = 0,
    WMDM_ENUM_PROP_VALID_VALUES_RANGE = 1,
    WMDM_ENUM_PROP_VALID_VALUES_ENUM = 2,
}

struct WMDM_PROP_VALUES_RANGE
{
    PROPVARIANT rangeMin;
    PROPVARIANT rangeMax;
    PROPVARIANT rangeStep;
}

struct WMDM_PROP_VALUES_ENUM
{
    uint cEnumValues;
    PROPVARIANT* pValues;
}

struct WMDM_PROP_DESC
{
    const(wchar)* pwszPropName;
    WMDM_ENUM_PROP_VALID_VALUES_FORM ValidValuesForm;
    _ValidValues_e__Union ValidValues;
}

struct WMDM_PROP_CONFIG
{
    uint nPreference;
    uint nPropDesc;
    WMDM_PROP_DESC* pPropDesc;
}

struct WMDM_FORMAT_CAPABILITY
{
    uint nPropConfig;
    WMDM_PROP_CONFIG* pConfigs;
}

enum WMDM_FIND_SCOPE
{
    WMDM_FIND_SCOPE_GLOBAL = 0,
    WMDM_FIND_SCOPE_IMMEDIATE_CHILDREN = 1,
}

enum WMDMMessage
{
    WMDM_MSG_DEVICE_ARRIVAL = 0,
    WMDM_MSG_DEVICE_REMOVAL = 1,
    WMDM_MSG_MEDIA_ARRIVAL = 2,
    WMDM_MSG_MEDIA_REMOVAL = 3,
}

const GUID IID_IWMDMMetaData = {0xEC3B0663, 0x0951, 0x460A, [0x9A, 0x80, 0x0D, 0xCE, 0xED, 0x3C, 0x04, 0x3C]};
@GUID(0xEC3B0663, 0x0951, 0x460A, [0x9A, 0x80, 0x0D, 0xCE, 0xED, 0x3C, 0x04, 0x3C]);
interface IWMDMMetaData : IUnknown
{
    HRESULT AddItem(WMDM_TAG_DATATYPE Type, const(wchar)* pwszTagName, char* pValue, uint iLength);
    HRESULT QueryByName(const(wchar)* pwszTagName, WMDM_TAG_DATATYPE* pType, char* pValue, uint* pcbLength);
    HRESULT QueryByIndex(uint iIndex, ushort** ppwszName, WMDM_TAG_DATATYPE* pType, char* ppValue, uint* pcbLength);
    HRESULT GetItemCount(uint* iCount);
}

const GUID IID_IWMDeviceManager = {0x1DCB3A00, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A00, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IWMDeviceManager : IUnknown
{
    HRESULT GetRevision(uint* pdwRevision);
    HRESULT GetDeviceCount(uint* pdwCount);
    HRESULT EnumDevices(IWMDMEnumDevice* ppEnumDevice);
}

const GUID IID_IWMDeviceManager2 = {0x923E5249, 0x8731, 0x4C5B, [0x9B, 0x1C, 0xB8, 0xB6, 0x0B, 0x6E, 0x46, 0xAF]};
@GUID(0x923E5249, 0x8731, 0x4C5B, [0x9B, 0x1C, 0xB8, 0xB6, 0x0B, 0x6E, 0x46, 0xAF]);
interface IWMDeviceManager2 : IWMDeviceManager
{
    HRESULT GetDeviceFromCanonicalName(const(wchar)* pwszCanonicalName, IWMDMDevice* ppDevice);
    HRESULT EnumDevices2(IWMDMEnumDevice* ppEnumDevice);
    HRESULT Reinitialize();
}

const GUID IID_IWMDeviceManager3 = {0xAF185C41, 0x100D, 0x46ED, [0xBE, 0x2E, 0x9C, 0xE8, 0xC4, 0x45, 0x94, 0xEF]};
@GUID(0xAF185C41, 0x100D, 0x46ED, [0xBE, 0x2E, 0x9C, 0xE8, 0xC4, 0x45, 0x94, 0xEF]);
interface IWMDeviceManager3 : IWMDeviceManager2
{
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

const GUID IID_IWMDMStorageGlobals = {0x1DCB3A07, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A07, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IWMDMStorage = {0x1DCB3A06, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A06, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IWMDMStorage2 = {0x1ED5A144, 0x5CD5, 0x4683, [0x9E, 0xFF, 0x72, 0xCB, 0xDB, 0x2D, 0x95, 0x33]};
@GUID(0x1ED5A144, 0x5CD5, 0x4683, [0x9E, 0xFF, 0x72, 0xCB, 0xDB, 0x2D, 0x95, 0x33]);
interface IWMDMStorage2 : IWMDMStorage
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IWMDMStorage* ppStorage);
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pFormat, _tagVIDEOINFOHEADER* pVideoFormat);
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, _tagVIDEOINFOHEADER* pVideoFormat);
}

const GUID IID_IWMDMStorage3 = {0x97717EEA, 0x926A, 0x464E, [0x96, 0xA4, 0x24, 0x7B, 0x02, 0x16, 0x02, 0x6E]};
@GUID(0x97717EEA, 0x926A, 0x464E, [0x96, 0xA4, 0x24, 0x7B, 0x02, 0x16, 0x02, 0x6E]);
interface IWMDMStorage3 : IWMDMStorage2
{
    HRESULT GetMetadata(IWMDMMetaData* ppMetadata);
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
    HRESULT CreateEmptyMetadataObject(IWMDMMetaData* ppMetadata);
    HRESULT SetEnumPreference(WMDM_STORAGE_ENUM_MODE* pMode, uint nViews, char* pViews);
}

const GUID IID_IWMDMStorage4 = {0xC225BAC5, 0xA03A, 0x40B8, [0x9A, 0x23, 0x91, 0xCF, 0x47, 0x8C, 0x64, 0xA6]};
@GUID(0xC225BAC5, 0xA03A, 0x40B8, [0x9A, 0x23, 0x91, 0xCF, 0x47, 0x8C, 0x64, 0xA6]);
interface IWMDMStorage4 : IWMDMStorage3
{
    HRESULT SetReferences(uint dwRefs, char* ppIWMDMStorage);
    HRESULT GetReferences(uint* pdwRefs, char* pppIWMDMStorage);
    HRESULT GetRightsWithProgress(IWMDMProgress3 pIProgressCallback, char* ppRights, uint* pnRightsCount);
    HRESULT GetSpecifiedMetadata(uint cProperties, char* ppwszPropNames, IWMDMMetaData* ppMetadata);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IWMDMStorage* ppStorage);
    HRESULT GetParent(IWMDMStorage* ppStorage);
}

const GUID IID_IWMDMOperation = {0x1DCB3A0B, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A0B, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IWMDMOperation2 = {0x33445B48, 0x7DF7, 0x425C, [0xAD, 0x8F, 0x0F, 0xC6, 0xD8, 0x2F, 0x9F, 0x75]};
@GUID(0x33445B48, 0x7DF7, 0x425C, [0xAD, 0x8F, 0x0F, 0xC6, 0xD8, 0x2F, 0x9F, 0x75]);
interface IWMDMOperation2 : IWMDMOperation
{
    HRESULT SetObjectAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pFormat, _tagVIDEOINFOHEADER* pVideoFormat);
    HRESULT GetObjectAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, _tagVIDEOINFOHEADER* pVideoFormat);
}

const GUID IID_IWMDMOperation3 = {0xD1F9B46A, 0x9CA8, 0x46D8, [0x9D, 0x0F, 0x1E, 0xC9, 0xBA, 0xE5, 0x49, 0x19]};
@GUID(0xD1F9B46A, 0x9CA8, 0x46D8, [0x9D, 0x0F, 0x1E, 0xC9, 0xBA, 0xE5, 0x49, 0x19]);
interface IWMDMOperation3 : IWMDMOperation
{
    HRESULT TransferObjectDataOnClearChannel(char* pData, uint* pdwSize);
}

const GUID IID_IWMDMProgress = {0x1DCB3A0C, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A0C, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IWMDMProgress : IUnknown
{
    HRESULT Begin(uint dwEstimatedTicks);
    HRESULT Progress(uint dwTranspiredTicks);
    HRESULT End();
}

const GUID IID_IWMDMProgress2 = {0x3A43F550, 0xB383, 0x4E92, [0xB0, 0x4A, 0xE6, 0xBB, 0xC6, 0x60, 0xFE, 0xFC]};
@GUID(0x3A43F550, 0xB383, 0x4E92, [0xB0, 0x4A, 0xE6, 0xBB, 0xC6, 0x60, 0xFE, 0xFC]);
interface IWMDMProgress2 : IWMDMProgress
{
    HRESULT End2(HRESULT hrCompletionCode);
}

const GUID IID_IWMDMProgress3 = {0x21DE01CB, 0x3BB4, 0x4929, [0xB2, 0x1A, 0x17, 0xAF, 0x3F, 0x80, 0xF6, 0x58]};
@GUID(0x21DE01CB, 0x3BB4, 0x4929, [0xB2, 0x1A, 0x17, 0xAF, 0x3F, 0x80, 0xF6, 0x58]);
interface IWMDMProgress3 : IWMDMProgress2
{
    HRESULT Begin3(Guid EventId, uint dwEstimatedTicks, __OPAQUECOMMAND* pContext);
    HRESULT Progress3(Guid EventId, uint dwTranspiredTicks, __OPAQUECOMMAND* pContext);
    HRESULT End3(Guid EventId, HRESULT hrCompletionCode, __OPAQUECOMMAND* pContext);
}

const GUID IID_IWMDMDevice = {0x1DCB3A02, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A02, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IWMDMDevice2 = {0xE34F3D37, 0x9D67, 0x4FC1, [0x92, 0x52, 0x62, 0xD2, 0x8B, 0x2F, 0x8B, 0x55]};
@GUID(0xE34F3D37, 0x9D67, 0x4FC1, [0x92, 0x52, 0x62, 0xD2, 0x8B, 0x2F, 0x8B, 0x55]);
interface IWMDMDevice2 : IWMDMDevice
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IWMDMStorage* ppStorage);
    HRESULT GetFormatSupport2(uint dwFlags, char* ppAudioFormatEx, uint* pnAudioFormatCount, char* ppVideoFormatEx, uint* pnVideoFormatCount, char* ppFileType, uint* pnFileTypeCount);
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, char* pppUnknowns, uint* pcUnks);
    HRESULT GetCanonicalName(const(wchar)* pwszPnPName, uint nMaxChars);
}

const GUID IID_IWMDMDevice3 = {0x6C03E4FE, 0x05DB, 0x4DDA, [0x9E, 0x3C, 0x06, 0x23, 0x3A, 0x6D, 0x5D, 0x65]};
@GUID(0x6C03E4FE, 0x05DB, 0x4DDA, [0x9E, 0x3C, 0x06, 0x23, 0x3A, 0x6D, 0x5D, 0x65]);
interface IWMDMDevice3 : IWMDMDevice2
{
    HRESULT GetProperty(const(wchar)* pwszPropName, PROPVARIANT* pValue);
    HRESULT SetProperty(const(wchar)* pwszPropName, const(PROPVARIANT)* pValue);
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    HRESULT DeviceIoControl(uint dwIoControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint* pnOutBufferSize);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IWMDMStorage* ppStorage);
}

const GUID IID_IWMDMDeviceSession = {0x82AF0A65, 0x9D96, 0x412C, [0x83, 0xE5, 0x3C, 0x43, 0xE4, 0xB0, 0x6C, 0xC7]};
@GUID(0x82AF0A65, 0x9D96, 0x412C, [0x83, 0xE5, 0x3C, 0x43, 0xE4, 0xB0, 0x6C, 0xC7]);
interface IWMDMDeviceSession : IUnknown
{
    HRESULT BeginSession(WMDM_SESSION_TYPE type, char* pCtx, uint dwSizeCtx);
    HRESULT EndSession(WMDM_SESSION_TYPE type, char* pCtx, uint dwSizeCtx);
}

const GUID IID_IWMDMEnumDevice = {0x1DCB3A01, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A01, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IWMDMEnumDevice : IUnknown
{
    HRESULT Next(uint celt, char* ppDevice, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IWMDMEnumDevice* ppEnumDevice);
}

const GUID IID_IWMDMDeviceControl = {0x1DCB3A04, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A04, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IWMDMEnumStorage = {0x1DCB3A05, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A05, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IWMDMEnumStorage : IUnknown
{
    HRESULT Next(uint celt, char* ppStorage, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IWMDMEnumStorage* ppEnumStorage);
}

const GUID IID_IWMDMStorageControl = {0x1DCB3A08, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A08, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IWMDMStorageControl : IUnknown
{
    HRESULT Insert(uint fuMode, const(wchar)* pwszFile, IWMDMOperation pOperation, IWMDMProgress pProgress, IWMDMStorage* ppNewObject);
    HRESULT Delete(uint fuMode, IWMDMProgress pProgress);
    HRESULT Rename(uint fuMode, const(wchar)* pwszNewName, IWMDMProgress pProgress);
    HRESULT Read(uint fuMode, const(wchar)* pwszFile, IWMDMProgress pProgress, IWMDMOperation pOperation);
    HRESULT Move(uint fuMode, IWMDMStorage pTargetObject, IWMDMProgress pProgress);
}

const GUID IID_IWMDMStorageControl2 = {0x972C2E88, 0xBD6C, 0x4125, [0x8E, 0x09, 0x84, 0xF8, 0x37, 0xE6, 0x37, 0xB6]};
@GUID(0x972C2E88, 0xBD6C, 0x4125, [0x8E, 0x09, 0x84, 0xF8, 0x37, 0xE6, 0x37, 0xB6]);
interface IWMDMStorageControl2 : IWMDMStorageControl
{
    HRESULT Insert2(uint fuMode, const(wchar)* pwszFileSource, const(wchar)* pwszFileDest, IWMDMOperation pOperation, IWMDMProgress pProgress, IUnknown pUnknown, IWMDMStorage* ppNewObject);
}

const GUID IID_IWMDMStorageControl3 = {0xB3266365, 0xD4F3, 0x4696, [0x8D, 0x53, 0xBD, 0x27, 0xEC, 0x60, 0x99, 0x3A]};
@GUID(0xB3266365, 0xD4F3, 0x4696, [0x8D, 0x53, 0xBD, 0x27, 0xEC, 0x60, 0x99, 0x3A]);
interface IWMDMStorageControl3 : IWMDMStorageControl2
{
    HRESULT Insert3(uint fuMode, uint fuType, const(wchar)* pwszFileSource, const(wchar)* pwszFileDest, IWMDMOperation pOperation, IWMDMProgress pProgress, IWMDMMetaData pMetaData, IUnknown pUnknown, IWMDMStorage* ppNewObject);
}

const GUID IID_IWMDMObjectInfo = {0x1DCB3A09, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A09, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IWMDMRevoked = {0xEBECCEDB, 0x88EE, 0x4E55, [0xB6, 0xA4, 0x8D, 0x9F, 0x07, 0xD6, 0x96, 0xAA]};
@GUID(0xEBECCEDB, 0x88EE, 0x4E55, [0xB6, 0xA4, 0x8D, 0x9F, 0x07, 0xD6, 0x96, 0xAA]);
interface IWMDMRevoked : IUnknown
{
    HRESULT GetRevocationURL(char* ppwszRevocationURL, uint* pdwBufferLen, uint* pdwRevokedBitFlag);
}

const GUID IID_IWMDMNotification = {0x3F5E95C0, 0x0F43, 0x4ED4, [0x93, 0xD2, 0xC8, 0x9A, 0x45, 0xD5, 0x9B, 0x81]};
@GUID(0x3F5E95C0, 0x0F43, 0x4ED4, [0x93, 0xD2, 0xC8, 0x9A, 0x45, 0xD5, 0x9B, 0x81]);
interface IWMDMNotification : IUnknown
{
    HRESULT WMDMMessage(uint dwMessageType, const(wchar)* pwszCanonicalName);
}

struct WMDMDetermineMaxPropStringLen
{
    ushort sz001;
    ushort sz002;
    ushort sz003;
    ushort sz004;
    ushort sz005;
    ushort sz006;
    ushort sz007;
    ushort sz008;
    ushort sz009;
    ushort sz010;
    ushort sz011;
    ushort sz012;
    ushort sz013;
    ushort sz014;
    ushort sz015;
    ushort sz016;
    ushort sz017;
    ushort sz018;
    ushort sz019;
    ushort sz020;
    ushort sz021;
    ushort sz022;
    ushort sz023;
    ushort sz024;
    ushort sz025;
    ushort sz026;
    ushort sz027;
    ushort sz028;
    ushort sz029;
    ushort sz030;
    ushort sz031;
    ushort sz032;
    ushort sz033;
    ushort sz034;
    ushort sz035;
    ushort sz036;
    ushort sz037;
    ushort sz041;
    ushort sz043;
    ushort sz044;
    ushort sz045;
    ushort sz046;
    ushort sz047;
    ushort sz048;
    ushort sz049;
    ushort sz050;
    ushort sz051;
    ushort sz052;
    ushort sz053;
    ushort sz054;
    ushort sz055;
    ushort sz056;
    ushort sz057;
    ushort sz058;
    ushort sz059;
    ushort sz060;
    ushort sz061;
    ushort sz062;
    ushort sz063;
    ushort sz064;
    ushort sz065;
    ushort sz066;
    ushort sz067;
    ushort sz068;
    ushort sz069;
    ushort sz070;
    ushort sz071;
    ushort sz072;
    ushort sz073;
    ushort sz074;
    ushort sz075;
    ushort sz076;
    ushort sz077;
    ushort sz078;
    ushort sz079;
    ushort sz080;
    ushort sz081;
    ushort sz082;
    ushort sz083;
    ushort sz084;
    ushort sz085;
    ushort sz086;
}

const GUID IID_IMDServiceProvider = {0x1DCB3A10, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A10, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IMDServiceProvider : IUnknown
{
    HRESULT GetDeviceCount(uint* pdwCount);
    HRESULT EnumDevices(IMDSPEnumDevice* ppEnumDevice);
}

const GUID IID_IMDServiceProvider2 = {0xB2FA24B7, 0xCDA3, 0x4694, [0x98, 0x62, 0x41, 0x3A, 0xE1, 0xA3, 0x48, 0x19]};
@GUID(0xB2FA24B7, 0xCDA3, 0x4694, [0x98, 0x62, 0x41, 0x3A, 0xE1, 0xA3, 0x48, 0x19]);
interface IMDServiceProvider2 : IMDServiceProvider
{
    HRESULT CreateDevice(const(wchar)* pwszDevicePath, uint* pdwCount, char* pppDeviceArray);
}

const GUID IID_IMDServiceProvider3 = {0x4ED13EF3, 0xA971, 0x4D19, [0x9F, 0x51, 0x0E, 0x18, 0x26, 0xB2, 0xDA, 0x57]};
@GUID(0x4ED13EF3, 0xA971, 0x4D19, [0x9F, 0x51, 0x0E, 0x18, 0x26, 0xB2, 0xDA, 0x57]);
interface IMDServiceProvider3 : IMDServiceProvider2
{
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

const GUID IID_IMDSPEnumDevice = {0x1DCB3A11, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A11, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IMDSPEnumDevice : IUnknown
{
    HRESULT Next(uint celt, char* ppDevice, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IMDSPEnumDevice* ppEnumDevice);
}

const GUID IID_IMDSPDevice = {0x1DCB3A12, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A12, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IMDSPDevice2 = {0x420D16AD, 0xC97D, 0x4E00, [0x82, 0xAA, 0x00, 0xE9, 0xF4, 0x33, 0x5D, 0xDD]};
@GUID(0x420D16AD, 0xC97D, 0x4E00, [0x82, 0xAA, 0x00, 0xE9, 0xF4, 0x33, 0x5D, 0xDD]);
interface IMDSPDevice2 : IMDSPDevice
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IMDSPStorage* ppStorage);
    HRESULT GetFormatSupport2(uint dwFlags, char* ppAudioFormatEx, uint* pnAudioFormatCount, char* ppVideoFormatEx, uint* pnVideoFormatCount, char* ppFileType, uint* pnFileTypeCount);
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, char* pppUnknowns, uint* pcUnks);
    HRESULT GetCanonicalName(const(wchar)* pwszPnPName, uint nMaxChars);
}

const GUID IID_IMDSPDevice3 = {0x1A839845, 0xFC55, 0x487C, [0x97, 0x6F, 0xEE, 0x38, 0xAC, 0x0E, 0x8C, 0x4E]};
@GUID(0x1A839845, 0xFC55, 0x487C, [0x97, 0x6F, 0xEE, 0x38, 0xAC, 0x0E, 0x8C, 0x4E]);
interface IMDSPDevice3 : IMDSPDevice2
{
    HRESULT GetProperty(const(wchar)* pwszPropName, PROPVARIANT* pValue);
    HRESULT SetProperty(const(wchar)* pwszPropName, const(PROPVARIANT)* pValue);
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    HRESULT DeviceIoControl(uint dwIoControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint* pnOutBufferSize);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IMDSPStorage* ppStorage);
}

const GUID IID_IMDSPDeviceControl = {0x1DCB3A14, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A14, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IMDSPEnumStorage = {0x1DCB3A15, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A15, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IMDSPEnumStorage : IUnknown
{
    HRESULT Next(uint celt, char* ppStorage, uint* pceltFetched);
    HRESULT Skip(uint celt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Clone(IMDSPEnumStorage* ppEnumStorage);
}

const GUID IID_IMDSPStorage = {0x1DCB3A16, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A16, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IMDSPStorage : IUnknown
{
    HRESULT SetAttributes(uint dwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT GetStorageGlobals(IMDSPStorageGlobals* ppStorageGlobals);
    HRESULT GetAttributes(uint* pdwAttributes, _tWAVEFORMATEX* pFormat);
    HRESULT GetName(const(wchar)* pwszName, uint nMaxChars);
    HRESULT GetDate(WMDMDATETIME* pDateTimeUTC);
    HRESULT GetSize(uint* pdwSizeLow, uint* pdwSizeHigh);
    HRESULT GetRights(char* ppRights, uint* pnRightsCount, char* abMac);
    HRESULT CreateStorage(uint dwAttributes, _tWAVEFORMATEX* pFormat, const(wchar)* pwszName, IMDSPStorage* ppNewStorage);
    HRESULT EnumStorage(IMDSPEnumStorage* ppEnumStorage);
    HRESULT SendOpaqueCommand(__OPAQUECOMMAND* pCommand);
}

const GUID IID_IMDSPStorage2 = {0x0A5E07A5, 0x6454, 0x4451, [0x9C, 0x36, 0x1C, 0x6A, 0xE7, 0xE2, 0xB1, 0xD6]};
@GUID(0x0A5E07A5, 0x6454, 0x4451, [0x9C, 0x36, 0x1C, 0x6A, 0xE7, 0xE2, 0xB1, 0xD6]);
interface IMDSPStorage2 : IMDSPStorage
{
    HRESULT GetStorage(const(wchar)* pszStorageName, IMDSPStorage* ppStorage);
    HRESULT CreateStorage2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pAudioFormat, _tagVIDEOINFOHEADER* pVideoFormat, const(wchar)* pwszName, ulong qwFileSize, IMDSPStorage* ppNewStorage);
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, _tWAVEFORMATEX* pAudioFormat, _tagVIDEOINFOHEADER* pVideoFormat);
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, _tWAVEFORMATEX* pAudioFormat, _tagVIDEOINFOHEADER* pVideoFormat);
}

const GUID IID_IMDSPStorage3 = {0x6C669867, 0x97ED, 0x4A67, [0x97, 0x06, 0x1C, 0x55, 0x29, 0xD2, 0xA4, 0x14]};
@GUID(0x6C669867, 0x97ED, 0x4A67, [0x97, 0x06, 0x1C, 0x55, 0x29, 0xD2, 0xA4, 0x14]);
interface IMDSPStorage3 : IMDSPStorage2
{
    HRESULT GetMetadata(IWMDMMetaData pMetadata);
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
}

const GUID IID_IMDSPStorage4 = {0x3133B2C4, 0x515C, 0x481B, [0xB1, 0xCE, 0x39, 0x32, 0x7E, 0xCB, 0x4F, 0x74]};
@GUID(0x3133B2C4, 0x515C, 0x481B, [0xB1, 0xCE, 0x39, 0x32, 0x7E, 0xCB, 0x4F, 0x74]);
interface IMDSPStorage4 : IMDSPStorage3
{
    HRESULT SetReferences(uint dwRefs, char* ppISPStorage);
    HRESULT GetReferences(uint* pdwRefs, char* pppISPStorage);
    HRESULT CreateStorageWithMetadata(uint dwAttributes, const(wchar)* pwszName, IWMDMMetaData pMetadata, ulong qwFileSize, IMDSPStorage* ppNewStorage);
    HRESULT GetSpecifiedMetadata(uint cProperties, char* ppwszPropNames, IWMDMMetaData pMetadata);
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(wchar)* pwszUniqueID, IMDSPStorage* ppStorage);
    HRESULT GetParent(IMDSPStorage* ppStorage);
}

const GUID IID_IMDSPStorageGlobals = {0x1DCB3A17, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A17, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IMDSPObjectInfo = {0x1DCB3A19, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A19, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IMDSPObject = {0x1DCB3A18, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A18, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
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

const GUID IID_IMDSPObject2 = {0x3F34CD3E, 0x5907, 0x4341, [0x9A, 0xF9, 0x97, 0xF4, 0x18, 0x7C, 0x3A, 0xA5]};
@GUID(0x3F34CD3E, 0x5907, 0x4341, [0x9A, 0xF9, 0x97, 0xF4, 0x18, 0x7C, 0x3A, 0xA5]);
interface IMDSPObject2 : IMDSPObject
{
    HRESULT ReadOnClearChannel(char* pData, uint* pdwSize);
    HRESULT WriteOnClearChannel(char* pData, uint* pdwSize);
}

const GUID IID_IMDSPDirectTransfer = {0xC2FE57A8, 0x9304, 0x478C, [0x9E, 0xE4, 0x47, 0xE3, 0x97, 0xB9, 0x12, 0xD7]};
@GUID(0xC2FE57A8, 0x9304, 0x478C, [0x9E, 0xE4, 0x47, 0xE3, 0x97, 0xB9, 0x12, 0xD7]);
interface IMDSPDirectTransfer : IUnknown
{
    HRESULT TransferToDevice(const(wchar)* pwszSourceFilePath, IWMDMOperation pSourceOperation, uint fuFlags, const(wchar)* pwszDestinationName, IWMDMMetaData pSourceMetaData, IWMDMProgress pTransferProgress, IMDSPStorage* ppNewObject);
}

const GUID IID_IMDSPRevoked = {0xA4E8F2D4, 0x3F31, 0x464D, [0xB5, 0x3D, 0x4F, 0xC3, 0x35, 0x99, 0x81, 0x84]};
@GUID(0xA4E8F2D4, 0x3F31, 0x464D, [0xB5, 0x3D, 0x4F, 0xC3, 0x35, 0x99, 0x81, 0x84]);
interface IMDSPRevoked : IUnknown
{
    HRESULT GetRevocationURL(char* ppwszRevocationURL, uint* pdwBufferLen);
}

const GUID IID_ISCPSecureAuthenticate = {0x1DCB3A0F, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A0F, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface ISCPSecureAuthenticate : IUnknown
{
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

const GUID IID_ISCPSecureAuthenticate2 = {0xB580CFAE, 0x1672, 0x47E2, [0xAC, 0xAA, 0x44, 0xBB, 0xEC, 0xBC, 0xAE, 0x5B]};
@GUID(0xB580CFAE, 0x1672, 0x47E2, [0xAC, 0xAA, 0x44, 0xBB, 0xEC, 0xBC, 0xAE, 0x5B]);
interface ISCPSecureAuthenticate2 : ISCPSecureAuthenticate
{
    HRESULT GetSCPSession(ISCPSession* ppSCPSession);
}

const GUID IID_ISCPSecureQuery = {0x1DCB3A0D, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A0D, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface ISCPSecureQuery : IUnknown
{
    HRESULT GetDataDemands(uint* pfuFlags, uint* pdwMinRightsData, uint* pdwMinExamineData, uint* pdwMinDecideData, char* abMac);
    HRESULT ExamineData(uint fuFlags, const(wchar)* pwszExtension, char* pData, uint dwSize, char* abMac);
    HRESULT MakeDecision(uint fuFlags, char* pData, uint dwSize, uint dwAppSec, char* pbSPSessionKey, uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, ISCPSecureExchange* ppExchange, char* abMac);
    HRESULT GetRights(char* pData, uint dwSize, char* pbSPSessionKey, uint dwSessionKeyLen, IMDSPStorageGlobals pStgGlobals, char* ppRights, uint* pnRightsCount, char* abMac);
}

const GUID IID_ISCPSecureQuery2 = {0xEBE17E25, 0x4FD7, 0x4632, [0xAF, 0x46, 0x6D, 0x93, 0xD4, 0xFC, 0xC7, 0x2E]};
@GUID(0xEBE17E25, 0x4FD7, 0x4632, [0xAF, 0x46, 0x6D, 0x93, 0xD4, 0xFC, 0xC7, 0x2E]);
interface ISCPSecureQuery2 : ISCPSecureQuery
{
    HRESULT MakeDecision2(uint fuFlags, char* pData, uint dwSize, uint dwAppSec, char* pbSPSessionKey, uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, char* pAppCertApp, uint dwAppCertAppLen, char* pAppCertSP, uint dwAppCertSPLen, char* pszRevocationURL, uint* pdwRevocationURLLen, uint* pdwRevocationBitFlag, ulong* pqwFileSize, IUnknown pUnknown, ISCPSecureExchange* ppExchange, char* abMac);
}

const GUID IID_ISCPSecureExchange = {0x1DCB3A0E, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0x1DCB3A0E, 0x33ED, 0x11D3, [0x84, 0x70, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface ISCPSecureExchange : IUnknown
{
    HRESULT TransferContainerData(char* pData, uint dwSize, uint* pfuReadyFlags, char* abMac);
    HRESULT ObjectData(char* pData, uint* pdwSize, char* abMac);
    HRESULT TransferComplete();
}

const GUID IID_ISCPSecureExchange2 = {0x6C62FC7B, 0x2690, 0x483F, [0x9D, 0x44, 0x0A, 0x20, 0xCB, 0x35, 0x57, 0x7C]};
@GUID(0x6C62FC7B, 0x2690, 0x483F, [0x9D, 0x44, 0x0A, 0x20, 0xCB, 0x35, 0x57, 0x7C]);
interface ISCPSecureExchange2 : ISCPSecureExchange
{
    HRESULT TransferContainerData2(char* pData, uint dwSize, IWMDMProgress3 pProgressCallback, uint* pfuReadyFlags, char* abMac);
}

const GUID IID_ISCPSecureExchange3 = {0xAB4E77E4, 0x8908, 0x4B17, [0xBD, 0x2A, 0xB1, 0xDB, 0xE6, 0xDD, 0x69, 0xE1]};
@GUID(0xAB4E77E4, 0x8908, 0x4B17, [0xBD, 0x2A, 0xB1, 0xDB, 0xE6, 0xDD, 0x69, 0xE1]);
interface ISCPSecureExchange3 : ISCPSecureExchange2
{
    HRESULT TransferContainerDataOnClearChannel(IMDSPDevice pDevice, char* pData, uint dwSize, IWMDMProgress3 pProgressCallback, uint* pfuReadyFlags);
    HRESULT GetObjectDataOnClearChannel(IMDSPDevice pDevice, char* pData, uint* pdwSize);
    HRESULT TransferCompleteForDevice(IMDSPDevice pDevice);
}

const GUID IID_ISCPSession = {0x88A3E6ED, 0xEEE4, 0x4619, [0xBB, 0xB3, 0xFD, 0x4F, 0xB6, 0x27, 0x15, 0xD1]};
@GUID(0x88A3E6ED, 0xEEE4, 0x4619, [0xBB, 0xB3, 0xFD, 0x4F, 0xB6, 0x27, 0x15, 0xD1]);
interface ISCPSession : IUnknown
{
    HRESULT BeginSession(IMDSPDevice pIDevice, char* pCtx, uint dwSizeCtx);
    HRESULT EndSession(char* pCtx, uint dwSizeCtx);
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

const GUID IID_ISCPSecureQuery3 = {0xB7EDD1A2, 0x4DAB, 0x484B, [0xB3, 0xC5, 0xAD, 0x39, 0xB8, 0xB4, 0xC0, 0xB1]};
@GUID(0xB7EDD1A2, 0x4DAB, 0x484B, [0xB3, 0xC5, 0xAD, 0x39, 0xB8, 0xB4, 0xC0, 0xB1]);
interface ISCPSecureQuery3 : ISCPSecureQuery2
{
    HRESULT GetRightsOnClearChannel(char* pData, uint dwSize, char* pbSPSessionKey, uint dwSessionKeyLen, IMDSPStorageGlobals pStgGlobals, IWMDMProgress3 pProgressCallback, char* ppRights, uint* pnRightsCount);
    HRESULT MakeDecisionOnClearChannel(uint fuFlags, char* pData, uint dwSize, uint dwAppSec, char* pbSPSessionKey, uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, IWMDMProgress3 pProgressCallback, char* pAppCertApp, uint dwAppCertAppLen, char* pAppCertSP, uint dwAppCertSPLen, char* pszRevocationURL, uint* pdwRevocationURLLen, uint* pdwRevocationBitFlag, ulong* pqwFileSize, IUnknown pUnknown, ISCPSecureExchange* ppExchange);
}

const GUID IID_IComponentAuthenticate = {0xA9889C00, 0x6D2B, 0x11D3, [0x84, 0x96, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]};
@GUID(0xA9889C00, 0x6D2B, 0x11D3, [0x84, 0x96, 0x00, 0xC0, 0x4F, 0x79, 0xDB, 0xC0]);
interface IComponentAuthenticate : IUnknown
{
    HRESULT SACAuth(uint dwProtocolID, uint dwPass, char* pbDataIn, uint dwDataInLen, char* ppbDataOut, uint* pdwDataOutLen);
    HRESULT SACGetProtocols(char* ppdwProtocols, uint* pdwProtocolCount);
}

const GUID CLSID_WMDMLogger = {0x110A3202, 0x5A79, 0x11D3, [0x8D, 0x78, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x110A3202, 0x5A79, 0x11D3, [0x8D, 0x78, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct WMDMLogger;

const GUID IID_IWMDMLogger = {0x110A3200, 0x5A79, 0x11D3, [0x8D, 0x78, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x110A3200, 0x5A79, 0x11D3, [0x8D, 0x78, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
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

struct MTP_COMMAND_DATA_IN
{
    ushort OpCode;
    uint NumParams;
    uint Params;
    uint NextPhase;
    uint CommandWriteDataSize;
    ubyte CommandWriteData;
}

struct MTP_COMMAND_DATA_OUT
{
    ushort ResponseCode;
    uint NumParams;
    uint Params;
    uint CommandReadDataSize;
    ubyte CommandReadData;
}

