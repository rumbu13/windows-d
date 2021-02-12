module windows.windowsportabledevices;

public import system;
public import windows.audio;
public import windows.automation;
public import windows.com;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowspropertiessystem;

extern(Windows):

enum DELETE_OBJECT_OPTIONS
{
    PORTABLE_DEVICE_DELETE_NO_RECURSION = 0,
    PORTABLE_DEVICE_DELETE_WITH_RECURSION = 1,
}

enum WPD_DEVICE_TYPES
{
    WPD_DEVICE_TYPE_GENERIC = 0,
    WPD_DEVICE_TYPE_CAMERA = 1,
    WPD_DEVICE_TYPE_MEDIA_PLAYER = 2,
    WPD_DEVICE_TYPE_PHONE = 3,
    WPD_DEVICE_TYPE_VIDEO = 4,
    WPD_DEVICE_TYPE_PERSONAL_INFORMATION_MANAGER = 5,
    WPD_DEVICE_TYPE_AUDIO_RECORDER = 6,
}

enum WpdAttributeForm
{
    WPD_PROPERTY_ATTRIBUTE_FORM_UNSPECIFIED = 0,
    WPD_PROPERTY_ATTRIBUTE_FORM_RANGE = 1,
    WPD_PROPERTY_ATTRIBUTE_FORM_ENUMERATION = 2,
    WPD_PROPERTY_ATTRIBUTE_FORM_REGULAR_EXPRESSION = 3,
    WPD_PROPERTY_ATTRIBUTE_FORM_OBJECT_IDENTIFIER = 4,
}

enum WpdParameterAttributeForm
{
    WPD_PARAMETER_ATTRIBUTE_FORM_UNSPECIFIED = 0,
    WPD_PARAMETER_ATTRIBUTE_FORM_RANGE = 1,
    WPD_PARAMETER_ATTRIBUTE_FORM_ENUMERATION = 2,
    WPD_PARAMETER_ATTRIBUTE_FORM_REGULAR_EXPRESSION = 3,
    WPD_PARAMETER_ATTRIBUTE_FORM_OBJECT_IDENTIFIER = 4,
}

enum WPD_DEVICE_TRANSPORTS
{
    WPD_DEVICE_TRANSPORT_UNSPECIFIED = 0,
    WPD_DEVICE_TRANSPORT_USB = 1,
    WPD_DEVICE_TRANSPORT_IP = 2,
    WPD_DEVICE_TRANSPORT_BLUETOOTH = 3,
}

enum WPD_STORAGE_TYPE_VALUES
{
    WPD_STORAGE_TYPE_UNDEFINED = 0,
    WPD_STORAGE_TYPE_FIXED_ROM = 1,
    WPD_STORAGE_TYPE_REMOVABLE_ROM = 2,
    WPD_STORAGE_TYPE_FIXED_RAM = 3,
    WPD_STORAGE_TYPE_REMOVABLE_RAM = 4,
}

enum WPD_STORAGE_ACCESS_CAPABILITY_VALUES
{
    WPD_STORAGE_ACCESS_CAPABILITY_READWRITE = 0,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITHOUT_OBJECT_DELETION = 1,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITH_OBJECT_DELETION = 2,
}

enum WPD_SMS_ENCODING_TYPES
{
    SMS_ENCODING_7_BIT = 0,
    SMS_ENCODING_8_BIT = 1,
    SMS_ENCODING_UTF_16 = 2,
}

enum SMS_MESSAGE_TYPES
{
    SMS_TEXT_MESSAGE = 0,
    SMS_BINARY_MESSAGE = 1,
}

enum WPD_POWER_SOURCES
{
    WPD_POWER_SOURCE_BATTERY = 0,
    WPD_POWER_SOURCE_EXTERNAL = 1,
}

enum WPD_WHITE_BALANCE_SETTINGS
{
    WPD_WHITE_BALANCE_UNDEFINED = 0,
    WPD_WHITE_BALANCE_MANUAL = 1,
    WPD_WHITE_BALANCE_AUTOMATIC = 2,
    WPD_WHITE_BALANCE_ONE_PUSH_AUTOMATIC = 3,
    WPD_WHITE_BALANCE_DAYLIGHT = 4,
    WPD_WHITE_BALANCE_FLORESCENT = 5,
    WPD_WHITE_BALANCE_TUNGSTEN = 6,
    WPD_WHITE_BALANCE_FLASH = 7,
}

enum WPD_FOCUS_MODES
{
    WPD_FOCUS_UNDEFINED = 0,
    WPD_FOCUS_MANUAL = 1,
    WPD_FOCUS_AUTOMATIC = 2,
    WPD_FOCUS_AUTOMATIC_MACRO = 3,
}

enum WPD_EXPOSURE_METERING_MODES
{
    WPD_EXPOSURE_METERING_MODE_UNDEFINED = 0,
    WPD_EXPOSURE_METERING_MODE_AVERAGE = 1,
    WPD_EXPOSURE_METERING_MODE_CENTER_WEIGHTED_AVERAGE = 2,
    WPD_EXPOSURE_METERING_MODE_MULTI_SPOT = 3,
    WPD_EXPOSURE_METERING_MODE_CENTER_SPOT = 4,
}

enum WPD_FLASH_MODES
{
    WPD_FLASH_MODE_UNDEFINED = 0,
    WPD_FLASH_MODE_AUTO = 1,
    WPD_FLASH_MODE_OFF = 2,
    WPD_FLASH_MODE_FILL = 3,
    WPD_FLASH_MODE_RED_EYE_AUTO = 4,
    WPD_FLASH_MODE_RED_EYE_FILL = 5,
    WPD_FLASH_MODE_EXTERNAL_SYNC = 6,
}

enum WPD_EXPOSURE_PROGRAM_MODES
{
    WPD_EXPOSURE_PROGRAM_MODE_UNDEFINED = 0,
    WPD_EXPOSURE_PROGRAM_MODE_MANUAL = 1,
    WPD_EXPOSURE_PROGRAM_MODE_AUTO = 2,
    WPD_EXPOSURE_PROGRAM_MODE_APERTURE_PRIORITY = 3,
    WPD_EXPOSURE_PROGRAM_MODE_SHUTTER_PRIORITY = 4,
    WPD_EXPOSURE_PROGRAM_MODE_CREATIVE = 5,
    WPD_EXPOSURE_PROGRAM_MODE_ACTION = 6,
    WPD_EXPOSURE_PROGRAM_MODE_PORTRAIT = 7,
}

enum WPD_CAPTURE_MODES
{
    WPD_CAPTURE_MODE_UNDEFINED = 0,
    WPD_CAPTURE_MODE_NORMAL = 1,
    WPD_CAPTURE_MODE_BURST = 2,
    WPD_CAPTURE_MODE_TIMELAPSE = 3,
}

enum WPD_EFFECT_MODES
{
    WPD_EFFECT_MODE_UNDEFINED = 0,
    WPD_EFFECT_MODE_COLOR = 1,
    WPD_EFFECT_MODE_BLACK_AND_WHITE = 2,
    WPD_EFFECT_MODE_SEPIA = 3,
}

enum WPD_FOCUS_METERING_MODES
{
    WPD_FOCUS_METERING_MODE_UNDEFINED = 0,
    WPD_FOCUS_METERING_MODE_CENTER_SPOT = 1,
    WPD_FOCUS_METERING_MODE_MULTI_SPOT = 2,
}

enum WPD_BITRATE_TYPES
{
    WPD_BITRATE_TYPE_UNUSED = 0,
    WPD_BITRATE_TYPE_DISCRETE = 1,
    WPD_BITRATE_TYPE_VARIABLE = 2,
    WPD_BITRATE_TYPE_FREE = 3,
}

enum WPD_META_GENRES
{
    WPD_META_GENRE_UNUSED = 0,
    WPD_META_GENRE_GENERIC_MUSIC_AUDIO_FILE = 1,
    WPD_META_GENRE_GENERIC_NON_MUSIC_AUDIO_FILE = 17,
    WPD_META_GENRE_SPOKEN_WORD_AUDIO_BOOK_FILES = 18,
    WPD_META_GENRE_SPOKEN_WORD_FILES_NON_AUDIO_BOOK = 19,
    WPD_META_GENRE_SPOKEN_WORD_NEWS = 20,
    WPD_META_GENRE_SPOKEN_WORD_TALK_SHOWS = 21,
    WPD_META_GENRE_GENERIC_VIDEO_FILE = 33,
    WPD_META_GENRE_NEWS_VIDEO_FILE = 34,
    WPD_META_GENRE_MUSIC_VIDEO_FILE = 35,
    WPD_META_GENRE_HOME_VIDEO_FILE = 36,
    WPD_META_GENRE_FEATURE_FILM_VIDEO_FILE = 37,
    WPD_META_GENRE_TELEVISION_VIDEO_FILE = 38,
    WPD_META_GENRE_TRAINING_EDUCATIONAL_VIDEO_FILE = 39,
    WPD_META_GENRE_PHOTO_MONTAGE_VIDEO_FILE = 40,
    WPD_META_GENRE_GENERIC_NON_AUDIO_NON_VIDEO = 48,
    WPD_META_GENRE_AUDIO_PODCAST = 64,
    WPD_META_GENRE_VIDEO_PODCAST = 65,
    WPD_META_GENRE_MIXED_PODCAST = 66,
}

enum WPD_CROPPED_STATUS_VALUES
{
    WPD_CROPPED_STATUS_NOT_CROPPED = 0,
    WPD_CROPPED_STATUS_CROPPED = 1,
    WPD_CROPPED_STATUS_SHOULD_NOT_BE_CROPPED = 2,
}

enum WPD_COLOR_CORRECTED_STATUS_VALUES
{
    WPD_COLOR_CORRECTED_STATUS_NOT_CORRECTED = 0,
    WPD_COLOR_CORRECTED_STATUS_CORRECTED = 1,
    WPD_COLOR_CORRECTED_STATUS_SHOULD_NOT_BE_CORRECTED = 2,
}

enum WPD_VIDEO_SCAN_TYPES
{
    WPD_VIDEO_SCAN_TYPE_UNUSED = 0,
    WPD_VIDEO_SCAN_TYPE_PROGRESSIVE = 1,
    WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_UPPER_FIRST = 2,
    WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_LOWER_FIRST = 3,
    WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_UPPER_FIRST = 4,
    WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_LOWER_FIRST = 5,
    WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE = 6,
    WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE_AND_PROGRESSIVE = 7,
}

enum WPD_OPERATION_STATES
{
    WPD_OPERATION_STATE_UNSPECIFIED = 0,
    WPD_OPERATION_STATE_STARTED = 1,
    WPD_OPERATION_STATE_RUNNING = 2,
    WPD_OPERATION_STATE_PAUSED = 3,
    WPD_OPERATION_STATE_CANCELLED = 4,
    WPD_OPERATION_STATE_FINISHED = 5,
    WPD_OPERATION_STATE_ABORTED = 6,
}

enum WPD_SECTION_DATA_UNITS_VALUES
{
    WPD_SECTION_DATA_UNITS_BYTES = 0,
    WPD_SECTION_DATA_UNITS_MILLISECONDS = 1,
}

enum WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPES
{
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_OBJECT = 0,
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_RESOURCE = 1,
}

enum WPD_COMMAND_ACCESS_TYPES
{
    WPD_COMMAND_ACCESS_READ = 1,
    WPD_COMMAND_ACCESS_READWRITE = 3,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_STGM_ACCESS = 4,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_FILE_ACCESS = 8,
    WPD_COMMAND_ACCESS_FROM_ATTRIBUTE_WITH_METHOD_ACCESS = 16,
}

enum WPD_SERVICE_INHERITANCE_TYPES
{
    WPD_SERVICE_INHERITANCE_IMPLEMENTATION = 0,
}

enum WPD_PARAMETER_USAGE_TYPES
{
    WPD_PARAMETER_USAGE_RETURN = 0,
    WPD_PARAMETER_USAGE_IN = 1,
    WPD_PARAMETER_USAGE_OUT = 2,
    WPD_PARAMETER_USAGE_INOUT = 3,
}

struct WPD_COMMAND_ACCESS_LOOKUP_ENTRY
{
    PROPERTYKEY Command;
    uint AccessType;
    PROPERTYKEY AccessProperty;
}

const GUID CLSID_WpdSerializer = {0x0B91A74B, 0xAD7C, 0x4A9D, [0xB5, 0x63, 0x29, 0xEE, 0xF9, 0x16, 0x71, 0x72]};
@GUID(0x0B91A74B, 0xAD7C, 0x4A9D, [0xB5, 0x63, 0x29, 0xEE, 0xF9, 0x16, 0x71, 0x72]);
struct WpdSerializer;

const GUID CLSID_PortableDeviceValues = {0x0C15D503, 0xD017, 0x47CE, [0x90, 0x16, 0x7B, 0x3F, 0x97, 0x87, 0x21, 0xCC]};
@GUID(0x0C15D503, 0xD017, 0x47CE, [0x90, 0x16, 0x7B, 0x3F, 0x97, 0x87, 0x21, 0xCC]);
struct PortableDeviceValues;

const GUID CLSID_PortableDeviceKeyCollection = {0xDE2D022D, 0x2480, 0x43BE, [0x97, 0xF0, 0xD1, 0xFA, 0x2C, 0xF9, 0x8F, 0x4F]};
@GUID(0xDE2D022D, 0x2480, 0x43BE, [0x97, 0xF0, 0xD1, 0xFA, 0x2C, 0xF9, 0x8F, 0x4F]);
struct PortableDeviceKeyCollection;

const GUID CLSID_PortableDevicePropVariantCollection = {0x08A99E2F, 0x6D6D, 0x4B80, [0xAF, 0x5A, 0xBA, 0xF2, 0xBC, 0xBE, 0x4C, 0xB9]};
@GUID(0x08A99E2F, 0x6D6D, 0x4B80, [0xAF, 0x5A, 0xBA, 0xF2, 0xBC, 0xBE, 0x4C, 0xB9]);
struct PortableDevicePropVariantCollection;

const GUID CLSID_PortableDeviceValuesCollection = {0x3882134D, 0x14CF, 0x4220, [0x9C, 0xB4, 0x43, 0x5F, 0x86, 0xD8, 0x3F, 0x60]};
@GUID(0x3882134D, 0x14CF, 0x4220, [0x9C, 0xB4, 0x43, 0x5F, 0x86, 0xD8, 0x3F, 0x60]);
struct PortableDeviceValuesCollection;

enum WPD_STREAM_UNITS
{
    WPD_STREAM_UNITS_BYTES = 0,
    WPD_STREAM_UNITS_FRAMES = 1,
    WPD_STREAM_UNITS_ROWS = 2,
    WPD_STREAM_UNITS_MILLISECONDS = 4,
    WPD_STREAM_UNITS_MICROSECONDS = 8,
}

const GUID IID_IWpdSerializer = {0xB32F4002, 0xBB27, 0x45FF, [0xAF, 0x4F, 0x06, 0x63, 0x1C, 0x1E, 0x8D, 0xAD]};
@GUID(0xB32F4002, 0xBB27, 0x45FF, [0xAF, 0x4F, 0x06, 0x63, 0x1C, 0x1E, 0x8D, 0xAD]);
interface IWpdSerializer : IUnknown
{
    HRESULT GetIPortableDeviceValuesFromBuffer(char* pBuffer, uint dwInputBufferLength, IPortableDeviceValues* ppParams);
    HRESULT WriteIPortableDeviceValuesToBuffer(uint dwOutputBufferLength, IPortableDeviceValues pResults, char* pBuffer, uint* pdwBytesWritten);
    HRESULT GetBufferFromIPortableDeviceValues(IPortableDeviceValues pSource, char* ppBuffer, uint* pdwBufferSize);
    HRESULT GetSerializedSize(IPortableDeviceValues pSource, uint* pdwSize);
}

const GUID IID_IPortableDeviceValues = {0x6848F6F2, 0x3155, 0x4F86, [0xB6, 0xF5, 0x26, 0x3E, 0xEE, 0xAB, 0x31, 0x43]};
@GUID(0x6848F6F2, 0x3155, 0x4F86, [0xB6, 0xF5, 0x26, 0x3E, 0xEE, 0xAB, 0x31, 0x43]);
interface IPortableDeviceValues : IUnknown
{
    HRESULT GetCount(uint* pcelt);
    HRESULT GetAt(const(uint) index, PROPERTYKEY* pKey, PROPVARIANT* pValue);
    HRESULT SetValue(const(PROPERTYKEY)* key, const(PROPVARIANT)* pValue);
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* pValue);
    HRESULT SetStringValue(const(PROPERTYKEY)* key, const(wchar)* Value);
    HRESULT GetStringValue(const(PROPERTYKEY)* key, ushort** pValue);
    HRESULT SetUnsignedIntegerValue(const(PROPERTYKEY)* key, const(uint) Value);
    HRESULT GetUnsignedIntegerValue(const(PROPERTYKEY)* key, uint* pValue);
    HRESULT SetSignedIntegerValue(const(PROPERTYKEY)* key, const(int) Value);
    HRESULT GetSignedIntegerValue(const(PROPERTYKEY)* key, int* pValue);
    HRESULT SetUnsignedLargeIntegerValue(const(PROPERTYKEY)* key, const(ulong) Value);
    HRESULT GetUnsignedLargeIntegerValue(const(PROPERTYKEY)* key, ulong* pValue);
    HRESULT SetSignedLargeIntegerValue(const(PROPERTYKEY)* key, const(long) Value);
    HRESULT GetSignedLargeIntegerValue(const(PROPERTYKEY)* key, long* pValue);
    HRESULT SetFloatValue(const(PROPERTYKEY)* key, const(float) Value);
    HRESULT GetFloatValue(const(PROPERTYKEY)* key, float* pValue);
    HRESULT SetErrorValue(const(PROPERTYKEY)* key, const(int) Value);
    HRESULT GetErrorValue(const(PROPERTYKEY)* key, int* pValue);
    HRESULT SetKeyValue(const(PROPERTYKEY)* key, const(PROPERTYKEY)* Value);
    HRESULT GetKeyValue(const(PROPERTYKEY)* key, PROPERTYKEY* pValue);
    HRESULT SetBoolValue(const(PROPERTYKEY)* key, const(int) Value);
    HRESULT GetBoolValue(const(PROPERTYKEY)* key, int* pValue);
    HRESULT SetIUnknownValue(const(PROPERTYKEY)* key, IUnknown pValue);
    HRESULT GetIUnknownValue(const(PROPERTYKEY)* key, IUnknown* ppValue);
    HRESULT SetGuidValue(const(PROPERTYKEY)* key, const(Guid)* Value);
    HRESULT GetGuidValue(const(PROPERTYKEY)* key, Guid* pValue);
    HRESULT SetBufferValue(const(PROPERTYKEY)* key, char* pValue, uint cbValue);
    HRESULT GetBufferValue(const(PROPERTYKEY)* key, char* ppValue, uint* pcbValue);
    HRESULT SetIPortableDeviceValuesValue(const(PROPERTYKEY)* key, IPortableDeviceValues pValue);
    HRESULT GetIPortableDeviceValuesValue(const(PROPERTYKEY)* key, IPortableDeviceValues* ppValue);
    HRESULT SetIPortableDevicePropVariantCollectionValue(const(PROPERTYKEY)* key, IPortableDevicePropVariantCollection pValue);
    HRESULT GetIPortableDevicePropVariantCollectionValue(const(PROPERTYKEY)* key, IPortableDevicePropVariantCollection* ppValue);
    HRESULT SetIPortableDeviceKeyCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceKeyCollection pValue);
    HRESULT GetIPortableDeviceKeyCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceKeyCollection* ppValue);
    HRESULT SetIPortableDeviceValuesCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceValuesCollection pValue);
    HRESULT GetIPortableDeviceValuesCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceValuesCollection* ppValue);
    HRESULT RemoveValue(const(PROPERTYKEY)* key);
    HRESULT CopyValuesFromPropertyStore(IPropertyStore pStore);
    HRESULT CopyValuesToPropertyStore(IPropertyStore pStore);
    HRESULT Clear();
}

const GUID IID_IPortableDeviceKeyCollection = {0xDADA2357, 0xE0AD, 0x492E, [0x98, 0xDB, 0xDD, 0x61, 0xC5, 0x3B, 0xA3, 0x53]};
@GUID(0xDADA2357, 0xE0AD, 0x492E, [0x98, 0xDB, 0xDD, 0x61, 0xC5, 0x3B, 0xA3, 0x53]);
interface IPortableDeviceKeyCollection : IUnknown
{
    HRESULT GetCount(uint* pcElems);
    HRESULT GetAt(const(uint) dwIndex, PROPERTYKEY* pKey);
    HRESULT Add(const(PROPERTYKEY)* Key);
    HRESULT Clear();
    HRESULT RemoveAt(const(uint) dwIndex);
}

const GUID IID_IPortableDevicePropVariantCollection = {0x89B2E422, 0x4F1B, 0x4316, [0xBC, 0xEF, 0xA4, 0x4A, 0xFE, 0xA8, 0x3E, 0xB3]};
@GUID(0x89B2E422, 0x4F1B, 0x4316, [0xBC, 0xEF, 0xA4, 0x4A, 0xFE, 0xA8, 0x3E, 0xB3]);
interface IPortableDevicePropVariantCollection : IUnknown
{
    HRESULT GetCount(uint* pcElems);
    HRESULT GetAt(const(uint) dwIndex, PROPVARIANT* pValue);
    HRESULT Add(const(PROPVARIANT)* pValue);
    HRESULT GetType(ushort* pvt);
    HRESULT ChangeType(const(ushort) vt);
    HRESULT Clear();
    HRESULT RemoveAt(const(uint) dwIndex);
}

const GUID IID_IPortableDeviceValuesCollection = {0x6E3F2D79, 0x4E07, 0x48C4, [0x82, 0x08, 0xD8, 0xC2, 0xE5, 0xAF, 0x4A, 0x99]};
@GUID(0x6E3F2D79, 0x4E07, 0x48C4, [0x82, 0x08, 0xD8, 0xC2, 0xE5, 0xAF, 0x4A, 0x99]);
interface IPortableDeviceValuesCollection : IUnknown
{
    HRESULT GetCount(uint* pcElems);
    HRESULT GetAt(const(uint) dwIndex, IPortableDeviceValues* ppValues);
    HRESULT Add(IPortableDeviceValues pValues);
    HRESULT Clear();
    HRESULT RemoveAt(const(uint) dwIndex);
}

const GUID CLSID_PortableDevice = {0x728A21C5, 0x3D9E, 0x48D7, [0x98, 0x10, 0x86, 0x48, 0x48, 0xF0, 0xF4, 0x04]};
@GUID(0x728A21C5, 0x3D9E, 0x48D7, [0x98, 0x10, 0x86, 0x48, 0x48, 0xF0, 0xF4, 0x04]);
struct PortableDevice;

const GUID CLSID_PortableDeviceManager = {0x0AF10CEC, 0x2ECD, 0x4B92, [0x95, 0x81, 0x34, 0xF6, 0xAE, 0x06, 0x37, 0xF3]};
@GUID(0x0AF10CEC, 0x2ECD, 0x4B92, [0x95, 0x81, 0x34, 0xF6, 0xAE, 0x06, 0x37, 0xF3]);
struct PortableDeviceManager;

const GUID CLSID_PortableDeviceService = {0xEF5DB4C2, 0x9312, 0x422C, [0x91, 0x52, 0x41, 0x1C, 0xD9, 0xC4, 0xDD, 0x84]};
@GUID(0xEF5DB4C2, 0x9312, 0x422C, [0x91, 0x52, 0x41, 0x1C, 0xD9, 0xC4, 0xDD, 0x84]);
struct PortableDeviceService;

const GUID CLSID_PortableDeviceDispatchFactory = {0x43232233, 0x8338, 0x4658, [0xAE, 0x01, 0x0B, 0x4A, 0xE8, 0x30, 0xB6, 0xB0]};
@GUID(0x43232233, 0x8338, 0x4658, [0xAE, 0x01, 0x0B, 0x4A, 0xE8, 0x30, 0xB6, 0xB0]);
struct PortableDeviceDispatchFactory;

const GUID CLSID_PortableDeviceFTM = {0xF7C0039A, 0x4762, 0x488A, [0xB4, 0xB3, 0x76, 0x0E, 0xF9, 0xA1, 0xBA, 0x9B]};
@GUID(0xF7C0039A, 0x4762, 0x488A, [0xB4, 0xB3, 0x76, 0x0E, 0xF9, 0xA1, 0xBA, 0x9B]);
struct PortableDeviceFTM;

const GUID CLSID_PortableDeviceServiceFTM = {0x1649B154, 0xC794, 0x497A, [0x9B, 0x03, 0xF3, 0xF0, 0x12, 0x13, 0x02, 0xF3]};
@GUID(0x1649B154, 0xC794, 0x497A, [0x9B, 0x03, 0xF3, 0xF0, 0x12, 0x13, 0x02, 0xF3]);
struct PortableDeviceServiceFTM;

const GUID CLSID_PortableDeviceWebControl = {0x186DD02C, 0x2DEC, 0x41B5, [0xA7, 0xD4, 0xB5, 0x90, 0x56, 0xFA, 0xDE, 0x51]};
@GUID(0x186DD02C, 0x2DEC, 0x41B5, [0xA7, 0xD4, 0xB5, 0x90, 0x56, 0xFA, 0xDE, 0x51]);
struct PortableDeviceWebControl;

const GUID IID_IPortableDeviceManager = {0xA1567595, 0x4C2F, 0x4574, [0xA6, 0xFA, 0xEC, 0xEF, 0x91, 0x7B, 0x9A, 0x40]};
@GUID(0xA1567595, 0x4C2F, 0x4574, [0xA6, 0xFA, 0xEC, 0xEF, 0x91, 0x7B, 0x9A, 0x40]);
interface IPortableDeviceManager : IUnknown
{
    HRESULT GetDevices(ushort** pPnPDeviceIDs, uint* pcPnPDeviceIDs);
    HRESULT RefreshDeviceList();
    HRESULT GetDeviceFriendlyName(const(wchar)* pszPnPDeviceID, ushort* pDeviceFriendlyName, uint* pcchDeviceFriendlyName);
    HRESULT GetDeviceDescription(const(wchar)* pszPnPDeviceID, ushort* pDeviceDescription, uint* pcchDeviceDescription);
    HRESULT GetDeviceManufacturer(const(wchar)* pszPnPDeviceID, ushort* pDeviceManufacturer, uint* pcchDeviceManufacturer);
    HRESULT GetDeviceProperty(const(wchar)* pszPnPDeviceID, const(wchar)* pszDevicePropertyName, ubyte* pData, uint* pcbData, uint* pdwType);
    HRESULT GetPrivateDevices(ushort** pPnPDeviceIDs, uint* pcPnPDeviceIDs);
}

const GUID IID_IPortableDevice = {0x625E2DF8, 0x6392, 0x4CF0, [0x9A, 0xD1, 0x3C, 0xFA, 0x5F, 0x17, 0x77, 0x5C]};
@GUID(0x625E2DF8, 0x6392, 0x4CF0, [0x9A, 0xD1, 0x3C, 0xFA, 0x5F, 0x17, 0x77, 0x5C]);
interface IPortableDevice : IUnknown
{
    HRESULT Open(const(wchar)* pszPnPDeviceID, IPortableDeviceValues pClientInfo);
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
    HRESULT Content(IPortableDeviceContent* ppContent);
    HRESULT Capabilities(IPortableDeviceCapabilities* ppCapabilities);
    HRESULT Cancel();
    HRESULT Close();
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, ushort** ppszCookie);
    HRESULT Unadvise(const(wchar)* pszCookie);
    HRESULT GetPnPDeviceID(ushort** ppszPnPDeviceID);
}

const GUID IID_IPortableDeviceContent = {0x6A96ED84, 0x7C73, 0x4480, [0x99, 0x38, 0xBF, 0x5A, 0xF4, 0x77, 0xD4, 0x26]};
@GUID(0x6A96ED84, 0x7C73, 0x4480, [0x99, 0x38, 0xBF, 0x5A, 0xF4, 0x77, 0xD4, 0x26]);
interface IPortableDeviceContent : IUnknown
{
    HRESULT EnumObjects(const(uint) dwFlags, const(wchar)* pszParentObjectID, IPortableDeviceValues pFilter, IEnumPortableDeviceObjectIDs* ppEnum);
    HRESULT Properties(IPortableDeviceProperties* ppProperties);
    HRESULT Transfer(IPortableDeviceResources* ppResources);
    HRESULT CreateObjectWithPropertiesOnly(IPortableDeviceValues pValues, ushort** ppszObjectID);
    HRESULT CreateObjectWithPropertiesAndData(IPortableDeviceValues pValues, IStream* ppData, uint* pdwOptimalWriteBufferSize, ushort** ppszCookie);
    HRESULT Delete(const(uint) dwOptions, IPortableDevicePropVariantCollection pObjectIDs, IPortableDevicePropVariantCollection* ppResults);
    HRESULT GetObjectIDsFromPersistentUniqueIDs(IPortableDevicePropVariantCollection pPersistentUniqueIDs, IPortableDevicePropVariantCollection* ppObjectIDs);
    HRESULT Cancel();
    HRESULT Move(IPortableDevicePropVariantCollection pObjectIDs, const(wchar)* pszDestinationFolderObjectID, IPortableDevicePropVariantCollection* ppResults);
    HRESULT Copy(IPortableDevicePropVariantCollection pObjectIDs, const(wchar)* pszDestinationFolderObjectID, IPortableDevicePropVariantCollection* ppResults);
}

const GUID IID_IPortableDeviceContent2 = {0x9B4ADD96, 0xF6BF, 0x4034, [0x87, 0x08, 0xEC, 0xA7, 0x2B, 0xF1, 0x05, 0x54]};
@GUID(0x9B4ADD96, 0xF6BF, 0x4034, [0x87, 0x08, 0xEC, 0xA7, 0x2B, 0xF1, 0x05, 0x54]);
interface IPortableDeviceContent2 : IPortableDeviceContent
{
    HRESULT UpdateObjectWithPropertiesAndData(const(wchar)* pszObjectID, IPortableDeviceValues pProperties, IStream* ppData, uint* pdwOptimalWriteBufferSize);
}

const GUID IID_IEnumPortableDeviceObjectIDs = {0x10ECE955, 0xCF41, 0x4728, [0xBF, 0xA0, 0x41, 0xEE, 0xDF, 0x1B, 0xBF, 0x19]};
@GUID(0x10ECE955, 0xCF41, 0x4728, [0xBF, 0xA0, 0x41, 0xEE, 0xDF, 0x1B, 0xBF, 0x19]);
interface IEnumPortableDeviceObjectIDs : IUnknown
{
    HRESULT Next(uint cObjects, char* pObjIDs, uint* pcFetched);
    HRESULT Skip(uint cObjects);
    HRESULT Reset();
    HRESULT Clone(IEnumPortableDeviceObjectIDs* ppEnum);
    HRESULT Cancel();
}

const GUID IID_IPortableDeviceProperties = {0x7F6D695C, 0x03DF, 0x4439, [0xA8, 0x09, 0x59, 0x26, 0x6B, 0xEE, 0xE3, 0xA6]};
@GUID(0x7F6D695C, 0x03DF, 0x4439, [0xA8, 0x09, 0x59, 0x26, 0x6B, 0xEE, 0xE3, 0xA6]);
interface IPortableDeviceProperties : IUnknown
{
    HRESULT GetSupportedProperties(const(wchar)* pszObjectID, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetPropertyAttributes(const(wchar)* pszObjectID, const(PROPERTYKEY)* Key, IPortableDeviceValues* ppAttributes);
    HRESULT GetValues(const(wchar)* pszObjectID, IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppValues);
    HRESULT SetValues(const(wchar)* pszObjectID, IPortableDeviceValues pValues, IPortableDeviceValues* ppResults);
    HRESULT Delete(const(wchar)* pszObjectID, IPortableDeviceKeyCollection pKeys);
    HRESULT Cancel();
}

const GUID IID_IPortableDeviceResources = {0xFD8878AC, 0xD841, 0x4D17, [0x89, 0x1C, 0xE6, 0x82, 0x9C, 0xDB, 0x69, 0x34]};
@GUID(0xFD8878AC, 0xD841, 0x4D17, [0x89, 0x1C, 0xE6, 0x82, 0x9C, 0xDB, 0x69, 0x34]);
interface IPortableDeviceResources : IUnknown
{
    HRESULT GetSupportedResources(const(wchar)* pszObjectID, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetResourceAttributes(const(wchar)* pszObjectID, const(PROPERTYKEY)* Key, IPortableDeviceValues* ppResourceAttributes);
    HRESULT GetStream(const(wchar)* pszObjectID, const(PROPERTYKEY)* Key, const(uint) dwMode, uint* pdwOptimalBufferSize, IStream* ppStream);
    HRESULT Delete(const(wchar)* pszObjectID, IPortableDeviceKeyCollection pKeys);
    HRESULT Cancel();
    HRESULT CreateResource(IPortableDeviceValues pResourceAttributes, IStream* ppData, uint* pdwOptimalWriteBufferSize, ushort** ppszCookie);
}

const GUID IID_IPortableDeviceCapabilities = {0x2C8C6DBF, 0xE3DC, 0x4061, [0xBE, 0xCC, 0x85, 0x42, 0xE8, 0x10, 0xD1, 0x26]};
@GUID(0x2C8C6DBF, 0xE3DC, 0x4061, [0xBE, 0xCC, 0x85, 0x42, 0xE8, 0x10, 0xD1, 0x26]);
interface IPortableDeviceCapabilities : IUnknown
{
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
    HRESULT GetFunctionalCategories(IPortableDevicePropVariantCollection* ppCategories);
    HRESULT GetFunctionalObjects(const(Guid)* Category, IPortableDevicePropVariantCollection* ppObjectIDs);
    HRESULT GetSupportedContentTypes(const(Guid)* Category, IPortableDevicePropVariantCollection* ppContentTypes);
    HRESULT GetSupportedFormats(const(Guid)* ContentType, IPortableDevicePropVariantCollection* ppFormats);
    HRESULT GetSupportedFormatProperties(const(Guid)* Format, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetFixedPropertyAttributes(const(Guid)* Format, const(PROPERTYKEY)* Key, IPortableDeviceValues* ppAttributes);
    HRESULT Cancel();
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
    HRESULT GetEventOptions(const(Guid)* Event, IPortableDeviceValues* ppOptions);
}

const GUID IID_IPortableDeviceEventCallback = {0xA8792A31, 0xF385, 0x493C, [0xA8, 0x93, 0x40, 0xF6, 0x4E, 0xB4, 0x5F, 0x6E]};
@GUID(0xA8792A31, 0xF385, 0x493C, [0xA8, 0x93, 0x40, 0xF6, 0x4E, 0xB4, 0x5F, 0x6E]);
interface IPortableDeviceEventCallback : IUnknown
{
    HRESULT OnEvent(IPortableDeviceValues pEventParameters);
}

const GUID IID_IPortableDeviceDataStream = {0x88E04DB3, 0x1012, 0x4D64, [0x99, 0x96, 0xF7, 0x03, 0xA9, 0x50, 0xD3, 0xF4]};
@GUID(0x88E04DB3, 0x1012, 0x4D64, [0x99, 0x96, 0xF7, 0x03, 0xA9, 0x50, 0xD3, 0xF4]);
interface IPortableDeviceDataStream : IStream
{
    HRESULT GetObjectID(ushort** ppszObjectID);
    HRESULT Cancel();
}

const GUID IID_IPortableDeviceUnitsStream = {0x5E98025F, 0xBFC4, 0x47A2, [0x9A, 0x5F, 0xBC, 0x90, 0x0A, 0x50, 0x7C, 0x67]};
@GUID(0x5E98025F, 0xBFC4, 0x47A2, [0x9A, 0x5F, 0xBC, 0x90, 0x0A, 0x50, 0x7C, 0x67]);
interface IPortableDeviceUnitsStream : IUnknown
{
    HRESULT SeekInUnits(LARGE_INTEGER dlibMove, WPD_STREAM_UNITS units, uint dwOrigin, ULARGE_INTEGER* plibNewPosition);
    HRESULT Cancel();
}

const GUID IID_IPortableDevicePropertiesBulk = {0x482B05C0, 0x4056, 0x44ED, [0x9E, 0x0F, 0x5E, 0x23, 0xB0, 0x09, 0xDA, 0x93]};
@GUID(0x482B05C0, 0x4056, 0x44ED, [0x9E, 0x0F, 0x5E, 0x23, 0xB0, 0x09, 0xDA, 0x93]);
interface IPortableDevicePropertiesBulk : IUnknown
{
    HRESULT QueueGetValuesByObjectList(IPortableDevicePropVariantCollection pObjectIDs, IPortableDeviceKeyCollection pKeys, IPortableDevicePropertiesBulkCallback pCallback, Guid* pContext);
    HRESULT QueueGetValuesByObjectFormat(const(Guid)* pguidObjectFormat, const(wchar)* pszParentObjectID, const(uint) dwDepth, IPortableDeviceKeyCollection pKeys, IPortableDevicePropertiesBulkCallback pCallback, Guid* pContext);
    HRESULT QueueSetValuesByObjectList(IPortableDeviceValuesCollection pObjectValues, IPortableDevicePropertiesBulkCallback pCallback, Guid* pContext);
    HRESULT Start(const(Guid)* pContext);
    HRESULT Cancel(const(Guid)* pContext);
}

const GUID IID_IPortableDevicePropertiesBulkCallback = {0x9DEACB80, 0x11E8, 0x40E3, [0xA9, 0xF3, 0xF5, 0x57, 0x98, 0x6A, 0x78, 0x45]};
@GUID(0x9DEACB80, 0x11E8, 0x40E3, [0xA9, 0xF3, 0xF5, 0x57, 0x98, 0x6A, 0x78, 0x45]);
interface IPortableDevicePropertiesBulkCallback : IUnknown
{
    HRESULT OnStart(const(Guid)* pContext);
    HRESULT OnProgress(const(Guid)* pContext, IPortableDeviceValuesCollection pResults);
    HRESULT OnEnd(const(Guid)* pContext, HRESULT hrStatus);
}

const GUID IID_IPortableDeviceServiceManager = {0xA8ABC4E9, 0xA84A, 0x47A9, [0x80, 0xB3, 0xC5, 0xD9, 0xB1, 0x72, 0xA9, 0x61]};
@GUID(0xA8ABC4E9, 0xA84A, 0x47A9, [0x80, 0xB3, 0xC5, 0xD9, 0xB1, 0x72, 0xA9, 0x61]);
interface IPortableDeviceServiceManager : IUnknown
{
    HRESULT GetDeviceServices(const(wchar)* pszPnPDeviceID, const(Guid)* guidServiceCategory, ushort** pServices, uint* pcServices);
    HRESULT GetDeviceForService(const(wchar)* pszPnPServiceID, ushort** ppszPnPDeviceID);
}

const GUID IID_IPortableDeviceService = {0xD3BD3A44, 0xD7B5, 0x40A9, [0x98, 0xB7, 0x2F, 0xA4, 0xD0, 0x1D, 0xEC, 0x08]};
@GUID(0xD3BD3A44, 0xD7B5, 0x40A9, [0x98, 0xB7, 0x2F, 0xA4, 0xD0, 0x1D, 0xEC, 0x08]);
interface IPortableDeviceService : IUnknown
{
    HRESULT Open(const(wchar)* pszPnPServiceID, IPortableDeviceValues pClientInfo);
    HRESULT Capabilities(IPortableDeviceServiceCapabilities* ppCapabilities);
    HRESULT Content(IPortableDeviceContent2* ppContent);
    HRESULT Methods(IPortableDeviceServiceMethods* ppMethods);
    HRESULT Cancel();
    HRESULT Close();
    HRESULT GetServiceObjectID(ushort** ppszServiceObjectID);
    HRESULT GetPnPServiceID(ushort** ppszPnPServiceID);
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, ushort** ppszCookie);
    HRESULT Unadvise(const(wchar)* pszCookie);
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
}

const GUID IID_IPortableDeviceServiceCapabilities = {0x24DBD89D, 0x413E, 0x43E0, [0xBD, 0x5B, 0x19, 0x7F, 0x3C, 0x56, 0xC8, 0x86]};
@GUID(0x24DBD89D, 0x413E, 0x43E0, [0xBD, 0x5B, 0x19, 0x7F, 0x3C, 0x56, 0xC8, 0x86]);
interface IPortableDeviceServiceCapabilities : IUnknown
{
    HRESULT GetSupportedMethods(IPortableDevicePropVariantCollection* ppMethods);
    HRESULT GetSupportedMethodsByFormat(const(Guid)* Format, IPortableDevicePropVariantCollection* ppMethods);
    HRESULT GetMethodAttributes(const(Guid)* Method, IPortableDeviceValues* ppAttributes);
    HRESULT GetMethodParameterAttributes(const(Guid)* Method, const(PROPERTYKEY)* Parameter, IPortableDeviceValues* ppAttributes);
    HRESULT GetSupportedFormats(IPortableDevicePropVariantCollection* ppFormats);
    HRESULT GetFormatAttributes(const(Guid)* Format, IPortableDeviceValues* ppAttributes);
    HRESULT GetSupportedFormatProperties(const(Guid)* Format, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetFormatPropertyAttributes(const(Guid)* Format, const(PROPERTYKEY)* Property, IPortableDeviceValues* ppAttributes);
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
    HRESULT GetEventAttributes(const(Guid)* Event, IPortableDeviceValues* ppAttributes);
    HRESULT GetEventParameterAttributes(const(Guid)* Event, const(PROPERTYKEY)* Parameter, IPortableDeviceValues* ppAttributes);
    HRESULT GetInheritedServices(const(uint) dwInheritanceType, IPortableDevicePropVariantCollection* ppServices);
    HRESULT GetFormatRenderingProfiles(const(Guid)* Format, IPortableDeviceValuesCollection* ppRenderingProfiles);
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
    HRESULT Cancel();
}

const GUID IID_IPortableDeviceServiceMethods = {0xE20333C9, 0xFD34, 0x412D, [0xA3, 0x81, 0xCC, 0x6F, 0x2D, 0x82, 0x0D, 0xF7]};
@GUID(0xE20333C9, 0xFD34, 0x412D, [0xA3, 0x81, 0xCC, 0x6F, 0x2D, 0x82, 0x0D, 0xF7]);
interface IPortableDeviceServiceMethods : IUnknown
{
    HRESULT Invoke(const(Guid)* Method, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
    HRESULT InvokeAsync(const(Guid)* Method, IPortableDeviceValues pParameters, IPortableDeviceServiceMethodCallback pCallback);
    HRESULT Cancel(IPortableDeviceServiceMethodCallback pCallback);
}

const GUID IID_IPortableDeviceServiceMethodCallback = {0xC424233C, 0xAFCE, 0x4828, [0xA7, 0x56, 0x7E, 0xD7, 0xA2, 0x35, 0x00, 0x83]};
@GUID(0xC424233C, 0xAFCE, 0x4828, [0xA7, 0x56, 0x7E, 0xD7, 0xA2, 0x35, 0x00, 0x83]);
interface IPortableDeviceServiceMethodCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus, IPortableDeviceValues pResults);
}

const GUID IID_IPortableDeviceServiceActivation = {0xE56B0534, 0xD9B9, 0x425C, [0x9B, 0x99, 0x75, 0xF9, 0x7C, 0xB3, 0xD7, 0xC8]};
@GUID(0xE56B0534, 0xD9B9, 0x425C, [0x9B, 0x99, 0x75, 0xF9, 0x7C, 0xB3, 0xD7, 0xC8]);
interface IPortableDeviceServiceActivation : IUnknown
{
    HRESULT OpenAsync(const(wchar)* pszPnPServiceID, IPortableDeviceValues pClientInfo, IPortableDeviceServiceOpenCallback pCallback);
    HRESULT CancelOpenAsync();
}

const GUID IID_IPortableDeviceServiceOpenCallback = {0xBCED49C8, 0x8EFE, 0x41ED, [0x96, 0x0B, 0x61, 0x31, 0x3A, 0xBD, 0x47, 0xA9]};
@GUID(0xBCED49C8, 0x8EFE, 0x41ED, [0x96, 0x0B, 0x61, 0x31, 0x3A, 0xBD, 0x47, 0xA9]);
interface IPortableDeviceServiceOpenCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus);
}

const GUID IID_IPortableDeviceDispatchFactory = {0x5E1EAFC3, 0xE3D7, 0x4132, [0x96, 0xFA, 0x75, 0x9C, 0x0F, 0x9D, 0x1E, 0x0F]};
@GUID(0x5E1EAFC3, 0xE3D7, 0x4132, [0x96, 0xFA, 0x75, 0x9C, 0x0F, 0x9D, 0x1E, 0x0F]);
interface IPortableDeviceDispatchFactory : IUnknown
{
    HRESULT GetDeviceDispatch(const(wchar)* pszPnPDeviceID, IDispatch* ppDeviceDispatch);
}

const GUID IID_IPortableDeviceWebControl = {0x94FC7953, 0x5CA1, 0x483A, [0x8A, 0xEE, 0xDF, 0x52, 0xE7, 0x74, 0x7D, 0x00]};
@GUID(0x94FC7953, 0x5CA1, 0x483A, [0x8A, 0xEE, 0xDF, 0x52, 0xE7, 0x74, 0x7D, 0x00]);
interface IPortableDeviceWebControl : IDispatch
{
    HRESULT GetDeviceFromId(BSTR deviceId, IDispatch* ppDevice);
    HRESULT GetDeviceFromIdAsync(BSTR deviceId, IDispatch pCompletionHandler, IDispatch pErrorHandler);
}

const GUID CLSID_EnumBthMtpConnectors = {0xA1570149, 0xE645, 0x4F43, [0x8B, 0x0D, 0x40, 0x9B, 0x06, 0x1D, 0xB2, 0xFC]};
@GUID(0xA1570149, 0xE645, 0x4F43, [0x8B, 0x0D, 0x40, 0x9B, 0x06, 0x1D, 0xB2, 0xFC]);
struct EnumBthMtpConnectors;

const GUID IID_IEnumPortableDeviceConnectors = {0xBFDEF549, 0x9247, 0x454F, [0xBD, 0x82, 0x06, 0xFE, 0x80, 0x85, 0x3F, 0xAA]};
@GUID(0xBFDEF549, 0x9247, 0x454F, [0xBD, 0x82, 0x06, 0xFE, 0x80, 0x85, 0x3F, 0xAA]);
interface IEnumPortableDeviceConnectors : IUnknown
{
    HRESULT Next(uint cRequested, char* pConnectors, uint* pcFetched);
    HRESULT Skip(uint cConnectors);
    HRESULT Reset();
    HRESULT Clone(IEnumPortableDeviceConnectors* ppEnum);
}

const GUID IID_IPortableDeviceConnector = {0x625E2DF8, 0x6392, 0x4CF0, [0x9A, 0xD1, 0x3C, 0xFA, 0x5F, 0x17, 0x77, 0x5C]};
@GUID(0x625E2DF8, 0x6392, 0x4CF0, [0x9A, 0xD1, 0x3C, 0xFA, 0x5F, 0x17, 0x77, 0x5C]);
interface IPortableDeviceConnector : IUnknown
{
    HRESULT Connect(IConnectionRequestCallback pCallback);
    HRESULT Disconnect(IConnectionRequestCallback pCallback);
    HRESULT Cancel(IConnectionRequestCallback pCallback);
    HRESULT GetProperty(const(DEVPROPKEY)* pPropertyKey, uint* pPropertyType, char* ppData, uint* pcbData);
    HRESULT SetProperty(const(DEVPROPKEY)* pPropertyKey, uint PropertyType, char* pData, uint cbData);
    HRESULT GetPnPID(ushort** ppwszPnPID);
}

const GUID IID_IConnectionRequestCallback = {0x272C9AE0, 0x7161, 0x4AE0, [0x91, 0xBD, 0x9F, 0x44, 0x8E, 0xE9, 0xC4, 0x27]};
@GUID(0x272C9AE0, 0x7161, 0x4AE0, [0x91, 0xBD, 0x9F, 0x44, 0x8E, 0xE9, 0xC4, 0x27]);
interface IConnectionRequestCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus);
}

