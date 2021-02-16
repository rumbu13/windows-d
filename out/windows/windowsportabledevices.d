module windows.windowsportabledevices;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : DEVPROPKEY, LARGE_INTEGER, ULARGE_INTEGER;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows):


// Enums


enum : int
{
    PORTABLE_DEVICE_DELETE_NO_RECURSION   = 0x00000000,
    PORTABLE_DEVICE_DELETE_WITH_RECURSION = 0x00000001,
}
alias DELETE_OBJECT_OPTIONS = int;

enum : int
{
    WPD_DEVICE_TYPE_GENERIC                      = 0x00000000,
    WPD_DEVICE_TYPE_CAMERA                       = 0x00000001,
    WPD_DEVICE_TYPE_MEDIA_PLAYER                 = 0x00000002,
    WPD_DEVICE_TYPE_PHONE                        = 0x00000003,
    WPD_DEVICE_TYPE_VIDEO                        = 0x00000004,
    WPD_DEVICE_TYPE_PERSONAL_INFORMATION_MANAGER = 0x00000005,
    WPD_DEVICE_TYPE_AUDIO_RECORDER               = 0x00000006,
}
alias WPD_DEVICE_TYPES = int;

enum WpdAttributeForm : int
{
    WPD_PROPERTY_ATTRIBUTE_FORM_UNSPECIFIED        = 0x00000000,
    WPD_PROPERTY_ATTRIBUTE_FORM_RANGE              = 0x00000001,
    WPD_PROPERTY_ATTRIBUTE_FORM_ENUMERATION        = 0x00000002,
    WPD_PROPERTY_ATTRIBUTE_FORM_REGULAR_EXPRESSION = 0x00000003,
    WPD_PROPERTY_ATTRIBUTE_FORM_OBJECT_IDENTIFIER  = 0x00000004,
}

enum WpdParameterAttributeForm : int
{
    WPD_PARAMETER_ATTRIBUTE_FORM_UNSPECIFIED        = 0x00000000,
    WPD_PARAMETER_ATTRIBUTE_FORM_RANGE              = 0x00000001,
    WPD_PARAMETER_ATTRIBUTE_FORM_ENUMERATION        = 0x00000002,
    WPD_PARAMETER_ATTRIBUTE_FORM_REGULAR_EXPRESSION = 0x00000003,
    WPD_PARAMETER_ATTRIBUTE_FORM_OBJECT_IDENTIFIER  = 0x00000004,
}

enum : int
{
    WPD_DEVICE_TRANSPORT_UNSPECIFIED = 0x00000000,
    WPD_DEVICE_TRANSPORT_USB         = 0x00000001,
    WPD_DEVICE_TRANSPORT_IP          = 0x00000002,
    WPD_DEVICE_TRANSPORT_BLUETOOTH   = 0x00000003,
}
alias WPD_DEVICE_TRANSPORTS = int;

enum : int
{
    WPD_STORAGE_TYPE_UNDEFINED     = 0x00000000,
    WPD_STORAGE_TYPE_FIXED_ROM     = 0x00000001,
    WPD_STORAGE_TYPE_REMOVABLE_ROM = 0x00000002,
    WPD_STORAGE_TYPE_FIXED_RAM     = 0x00000003,
    WPD_STORAGE_TYPE_REMOVABLE_RAM = 0x00000004,
}
alias WPD_STORAGE_TYPE_VALUES = int;

enum : int
{
    WPD_STORAGE_ACCESS_CAPABILITY_READWRITE                         = 0x00000000,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITHOUT_OBJECT_DELETION = 0x00000001,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITH_OBJECT_DELETION    = 0x00000002,
}
alias WPD_STORAGE_ACCESS_CAPABILITY_VALUES = int;

enum : int
{
    SMS_ENCODING_7_BIT  = 0x00000000,
    SMS_ENCODING_8_BIT  = 0x00000001,
    SMS_ENCODING_UTF_16 = 0x00000002,
}
alias WPD_SMS_ENCODING_TYPES = int;

enum : int
{
    SMS_TEXT_MESSAGE   = 0x00000000,
    SMS_BINARY_MESSAGE = 0x00000001,
}
alias SMS_MESSAGE_TYPES = int;

enum : int
{
    WPD_POWER_SOURCE_BATTERY  = 0x00000000,
    WPD_POWER_SOURCE_EXTERNAL = 0x00000001,
}
alias WPD_POWER_SOURCES = int;

enum : int
{
    WPD_WHITE_BALANCE_UNDEFINED          = 0x00000000,
    WPD_WHITE_BALANCE_MANUAL             = 0x00000001,
    WPD_WHITE_BALANCE_AUTOMATIC          = 0x00000002,
    WPD_WHITE_BALANCE_ONE_PUSH_AUTOMATIC = 0x00000003,
    WPD_WHITE_BALANCE_DAYLIGHT           = 0x00000004,
    WPD_WHITE_BALANCE_FLORESCENT         = 0x00000005,
    WPD_WHITE_BALANCE_TUNGSTEN           = 0x00000006,
    WPD_WHITE_BALANCE_FLASH              = 0x00000007,
}
alias WPD_WHITE_BALANCE_SETTINGS = int;

enum : int
{
    WPD_FOCUS_UNDEFINED       = 0x00000000,
    WPD_FOCUS_MANUAL          = 0x00000001,
    WPD_FOCUS_AUTOMATIC       = 0x00000002,
    WPD_FOCUS_AUTOMATIC_MACRO = 0x00000003,
}
alias WPD_FOCUS_MODES = int;

enum : int
{
    WPD_EXPOSURE_METERING_MODE_UNDEFINED               = 0x00000000,
    WPD_EXPOSURE_METERING_MODE_AVERAGE                 = 0x00000001,
    WPD_EXPOSURE_METERING_MODE_CENTER_WEIGHTED_AVERAGE = 0x00000002,
    WPD_EXPOSURE_METERING_MODE_MULTI_SPOT              = 0x00000003,
    WPD_EXPOSURE_METERING_MODE_CENTER_SPOT             = 0x00000004,
}
alias WPD_EXPOSURE_METERING_MODES = int;

enum : int
{
    WPD_FLASH_MODE_UNDEFINED     = 0x00000000,
    WPD_FLASH_MODE_AUTO          = 0x00000001,
    WPD_FLASH_MODE_OFF           = 0x00000002,
    WPD_FLASH_MODE_FILL          = 0x00000003,
    WPD_FLASH_MODE_RED_EYE_AUTO  = 0x00000004,
    WPD_FLASH_MODE_RED_EYE_FILL  = 0x00000005,
    WPD_FLASH_MODE_EXTERNAL_SYNC = 0x00000006,
}
alias WPD_FLASH_MODES = int;

enum : int
{
    WPD_EXPOSURE_PROGRAM_MODE_UNDEFINED         = 0x00000000,
    WPD_EXPOSURE_PROGRAM_MODE_MANUAL            = 0x00000001,
    WPD_EXPOSURE_PROGRAM_MODE_AUTO              = 0x00000002,
    WPD_EXPOSURE_PROGRAM_MODE_APERTURE_PRIORITY = 0x00000003,
    WPD_EXPOSURE_PROGRAM_MODE_SHUTTER_PRIORITY  = 0x00000004,
    WPD_EXPOSURE_PROGRAM_MODE_CREATIVE          = 0x00000005,
    WPD_EXPOSURE_PROGRAM_MODE_ACTION            = 0x00000006,
    WPD_EXPOSURE_PROGRAM_MODE_PORTRAIT          = 0x00000007,
}
alias WPD_EXPOSURE_PROGRAM_MODES = int;

enum : int
{
    WPD_CAPTURE_MODE_UNDEFINED = 0x00000000,
    WPD_CAPTURE_MODE_NORMAL    = 0x00000001,
    WPD_CAPTURE_MODE_BURST     = 0x00000002,
    WPD_CAPTURE_MODE_TIMELAPSE = 0x00000003,
}
alias WPD_CAPTURE_MODES = int;

enum : int
{
    WPD_EFFECT_MODE_UNDEFINED       = 0x00000000,
    WPD_EFFECT_MODE_COLOR           = 0x00000001,
    WPD_EFFECT_MODE_BLACK_AND_WHITE = 0x00000002,
    WPD_EFFECT_MODE_SEPIA           = 0x00000003,
}
alias WPD_EFFECT_MODES = int;

enum : int
{
    WPD_FOCUS_METERING_MODE_UNDEFINED   = 0x00000000,
    WPD_FOCUS_METERING_MODE_CENTER_SPOT = 0x00000001,
    WPD_FOCUS_METERING_MODE_MULTI_SPOT  = 0x00000002,
}
alias WPD_FOCUS_METERING_MODES = int;

enum : int
{
    WPD_BITRATE_TYPE_UNUSED   = 0x00000000,
    WPD_BITRATE_TYPE_DISCRETE = 0x00000001,
    WPD_BITRATE_TYPE_VARIABLE = 0x00000002,
    WPD_BITRATE_TYPE_FREE     = 0x00000003,
}
alias WPD_BITRATE_TYPES = int;

enum : int
{
    WPD_META_GENRE_UNUSED                           = 0x00000000,
    WPD_META_GENRE_GENERIC_MUSIC_AUDIO_FILE         = 0x00000001,
    WPD_META_GENRE_GENERIC_NON_MUSIC_AUDIO_FILE     = 0x00000011,
    WPD_META_GENRE_SPOKEN_WORD_AUDIO_BOOK_FILES     = 0x00000012,
    WPD_META_GENRE_SPOKEN_WORD_FILES_NON_AUDIO_BOOK = 0x00000013,
    WPD_META_GENRE_SPOKEN_WORD_NEWS                 = 0x00000014,
    WPD_META_GENRE_SPOKEN_WORD_TALK_SHOWS           = 0x00000015,
    WPD_META_GENRE_GENERIC_VIDEO_FILE               = 0x00000021,
    WPD_META_GENRE_NEWS_VIDEO_FILE                  = 0x00000022,
    WPD_META_GENRE_MUSIC_VIDEO_FILE                 = 0x00000023,
    WPD_META_GENRE_HOME_VIDEO_FILE                  = 0x00000024,
    WPD_META_GENRE_FEATURE_FILM_VIDEO_FILE          = 0x00000025,
    WPD_META_GENRE_TELEVISION_VIDEO_FILE            = 0x00000026,
    WPD_META_GENRE_TRAINING_EDUCATIONAL_VIDEO_FILE  = 0x00000027,
    WPD_META_GENRE_PHOTO_MONTAGE_VIDEO_FILE         = 0x00000028,
    WPD_META_GENRE_GENERIC_NON_AUDIO_NON_VIDEO      = 0x00000030,
    WPD_META_GENRE_AUDIO_PODCAST                    = 0x00000040,
    WPD_META_GENRE_VIDEO_PODCAST                    = 0x00000041,
    WPD_META_GENRE_MIXED_PODCAST                    = 0x00000042,
}
alias WPD_META_GENRES = int;

enum : int
{
    WPD_CROPPED_STATUS_NOT_CROPPED           = 0x00000000,
    WPD_CROPPED_STATUS_CROPPED               = 0x00000001,
    WPD_CROPPED_STATUS_SHOULD_NOT_BE_CROPPED = 0x00000002,
}
alias WPD_CROPPED_STATUS_VALUES = int;

enum : int
{
    WPD_COLOR_CORRECTED_STATUS_NOT_CORRECTED           = 0x00000000,
    WPD_COLOR_CORRECTED_STATUS_CORRECTED               = 0x00000001,
    WPD_COLOR_CORRECTED_STATUS_SHOULD_NOT_BE_CORRECTED = 0x00000002,
}
alias WPD_COLOR_CORRECTED_STATUS_VALUES = int;

enum : int
{
    WPD_VIDEO_SCAN_TYPE_UNUSED                          = 0x00000000,
    WPD_VIDEO_SCAN_TYPE_PROGRESSIVE                     = 0x00000001,
    WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_UPPER_FIRST   = 0x00000002,
    WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_LOWER_FIRST   = 0x00000003,
    WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_UPPER_FIRST        = 0x00000004,
    WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_LOWER_FIRST        = 0x00000005,
    WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE                 = 0x00000006,
    WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE_AND_PROGRESSIVE = 0x00000007,
}
alias WPD_VIDEO_SCAN_TYPES = int;

enum : int
{
    WPD_OPERATION_STATE_UNSPECIFIED = 0x00000000,
    WPD_OPERATION_STATE_STARTED     = 0x00000001,
    WPD_OPERATION_STATE_RUNNING     = 0x00000002,
    WPD_OPERATION_STATE_PAUSED      = 0x00000003,
    WPD_OPERATION_STATE_CANCELLED   = 0x00000004,
    WPD_OPERATION_STATE_FINISHED    = 0x00000005,
    WPD_OPERATION_STATE_ABORTED     = 0x00000006,
}
alias WPD_OPERATION_STATES = int;

enum : int
{
    WPD_SECTION_DATA_UNITS_BYTES        = 0x00000000,
    WPD_SECTION_DATA_UNITS_MILLISECONDS = 0x00000001,
}
alias WPD_SECTION_DATA_UNITS_VALUES = int;

enum : int
{
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_OBJECT   = 0x00000000,
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_RESOURCE = 0x00000001,
}
alias WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPES = int;

enum : int
{
    WPD_COMMAND_ACCESS_READ                              = 0x00000001,
    WPD_COMMAND_ACCESS_READWRITE                         = 0x00000003,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_STGM_ACCESS    = 0x00000004,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_FILE_ACCESS    = 0x00000008,
    WPD_COMMAND_ACCESS_FROM_ATTRIBUTE_WITH_METHOD_ACCESS = 0x00000010,
}
alias WPD_COMMAND_ACCESS_TYPES = int;

enum : int
{
    WPD_SERVICE_INHERITANCE_IMPLEMENTATION = 0x00000000,
}
alias WPD_SERVICE_INHERITANCE_TYPES = int;

enum : int
{
    WPD_PARAMETER_USAGE_RETURN = 0x00000000,
    WPD_PARAMETER_USAGE_IN     = 0x00000001,
    WPD_PARAMETER_USAGE_OUT    = 0x00000002,
    WPD_PARAMETER_USAGE_INOUT  = 0x00000003,
}
alias WPD_PARAMETER_USAGE_TYPES = int;

enum : int
{
    WPD_STREAM_UNITS_BYTES        = 0x00000000,
    WPD_STREAM_UNITS_FRAMES       = 0x00000001,
    WPD_STREAM_UNITS_ROWS         = 0x00000002,
    WPD_STREAM_UNITS_MILLISECONDS = 0x00000004,
    WPD_STREAM_UNITS_MICROSECONDS = 0x00000008,
}
alias WPD_STREAM_UNITS = int;

// Structs


struct WPD_COMMAND_ACCESS_LOOKUP_ENTRY
{
    PROPERTYKEY Command;
    uint        AccessType;
    PROPERTYKEY AccessProperty;
}

// Interfaces

@GUID("0B91A74B-AD7C-4A9D-B563-29EEF9167172")
struct WpdSerializer;

@GUID("0C15D503-D017-47CE-9016-7B3F978721CC")
struct PortableDeviceValues;

@GUID("DE2D022D-2480-43BE-97F0-D1FA2CF98F4F")
struct PortableDeviceKeyCollection;

@GUID("08A99E2F-6D6D-4B80-AF5A-BAF2BCBE4CB9")
struct PortableDevicePropVariantCollection;

@GUID("3882134D-14CF-4220-9CB4-435F86D83F60")
struct PortableDeviceValuesCollection;

@GUID("728A21C5-3D9E-48D7-9810-864848F0F404")
struct PortableDevice;

@GUID("0AF10CEC-2ECD-4B92-9581-34F6AE0637F3")
struct PortableDeviceManager;

@GUID("EF5DB4C2-9312-422C-9152-411CD9C4DD84")
struct PortableDeviceService;

@GUID("43232233-8338-4658-AE01-0B4AE830B6B0")
struct PortableDeviceDispatchFactory;

@GUID("F7C0039A-4762-488A-B4B3-760EF9A1BA9B")
struct PortableDeviceFTM;

@GUID("1649B154-C794-497A-9B03-F3F0121302F3")
struct PortableDeviceServiceFTM;

@GUID("186DD02C-2DEC-41B5-A7D4-B59056FADE51")
struct PortableDeviceWebControl;

@GUID("A1570149-E645-4F43-8B0D-409B061DB2FC")
struct EnumBthMtpConnectors;

@GUID("B32F4002-BB27-45FF-AF4F-06631C1E8DAD")
interface IWpdSerializer : IUnknown
{
    HRESULT GetIPortableDeviceValuesFromBuffer(char* pBuffer, uint dwInputBufferLength, 
                                               IPortableDeviceValues* ppParams);
    HRESULT WriteIPortableDeviceValuesToBuffer(uint dwOutputBufferLength, IPortableDeviceValues pResults, 
                                               char* pBuffer, uint* pdwBytesWritten);
    HRESULT GetBufferFromIPortableDeviceValues(IPortableDeviceValues pSource, char* ppBuffer, uint* pdwBufferSize);
    HRESULT GetSerializedSize(IPortableDeviceValues pSource, uint* pdwSize);
}

@GUID("6848F6F2-3155-4F86-B6F5-263EEEAB3143")
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
    HRESULT SetGuidValue(const(PROPERTYKEY)* key, const(GUID)* Value);
    HRESULT GetGuidValue(const(PROPERTYKEY)* key, GUID* pValue);
    HRESULT SetBufferValue(const(PROPERTYKEY)* key, char* pValue, uint cbValue);
    HRESULT GetBufferValue(const(PROPERTYKEY)* key, char* ppValue, uint* pcbValue);
    HRESULT SetIPortableDeviceValuesValue(const(PROPERTYKEY)* key, IPortableDeviceValues pValue);
    HRESULT GetIPortableDeviceValuesValue(const(PROPERTYKEY)* key, IPortableDeviceValues* ppValue);
    HRESULT SetIPortableDevicePropVariantCollectionValue(const(PROPERTYKEY)* key, 
                                                         IPortableDevicePropVariantCollection pValue);
    HRESULT GetIPortableDevicePropVariantCollectionValue(const(PROPERTYKEY)* key, 
                                                         IPortableDevicePropVariantCollection* ppValue);
    HRESULT SetIPortableDeviceKeyCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceKeyCollection pValue);
    HRESULT GetIPortableDeviceKeyCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceKeyCollection* ppValue);
    HRESULT SetIPortableDeviceValuesCollectionValue(const(PROPERTYKEY)* key, 
                                                    IPortableDeviceValuesCollection pValue);
    HRESULT GetIPortableDeviceValuesCollectionValue(const(PROPERTYKEY)* key, 
                                                    IPortableDeviceValuesCollection* ppValue);
    HRESULT RemoveValue(const(PROPERTYKEY)* key);
    HRESULT CopyValuesFromPropertyStore(IPropertyStore pStore);
    HRESULT CopyValuesToPropertyStore(IPropertyStore pStore);
    HRESULT Clear();
}

@GUID("DADA2357-E0AD-492E-98DB-DD61C53BA353")
interface IPortableDeviceKeyCollection : IUnknown
{
    HRESULT GetCount(uint* pcElems);
    HRESULT GetAt(const(uint) dwIndex, PROPERTYKEY* pKey);
    HRESULT Add(const(PROPERTYKEY)* Key);
    HRESULT Clear();
    HRESULT RemoveAt(const(uint) dwIndex);
}

@GUID("89B2E422-4F1B-4316-BCEF-A44AFEA83EB3")
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

@GUID("6E3F2D79-4E07-48C4-8208-D8C2E5AF4A99")
interface IPortableDeviceValuesCollection : IUnknown
{
    HRESULT GetCount(uint* pcElems);
    HRESULT GetAt(const(uint) dwIndex, IPortableDeviceValues* ppValues);
    HRESULT Add(IPortableDeviceValues pValues);
    HRESULT Clear();
    HRESULT RemoveAt(const(uint) dwIndex);
}

@GUID("A1567595-4C2F-4574-A6FA-ECEF917B9A40")
interface IPortableDeviceManager : IUnknown
{
    HRESULT GetDevices(ushort** pPnPDeviceIDs, uint* pcPnPDeviceIDs);
    HRESULT RefreshDeviceList();
    HRESULT GetDeviceFriendlyName(const(wchar)* pszPnPDeviceID, ushort* pDeviceFriendlyName, 
                                  uint* pcchDeviceFriendlyName);
    HRESULT GetDeviceDescription(const(wchar)* pszPnPDeviceID, ushort* pDeviceDescription, 
                                 uint* pcchDeviceDescription);
    HRESULT GetDeviceManufacturer(const(wchar)* pszPnPDeviceID, ushort* pDeviceManufacturer, 
                                  uint* pcchDeviceManufacturer);
    HRESULT GetDeviceProperty(const(wchar)* pszPnPDeviceID, const(wchar)* pszDevicePropertyName, ubyte* pData, 
                              uint* pcbData, uint* pdwType);
    HRESULT GetPrivateDevices(ushort** pPnPDeviceIDs, uint* pcPnPDeviceIDs);
}

@GUID("625E2DF8-6392-4CF0-9AD1-3CFA5F17775C")
interface IPortableDevice : IUnknown
{
    HRESULT Open(const(wchar)* pszPnPDeviceID, IPortableDeviceValues pClientInfo);
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
    HRESULT Content(IPortableDeviceContent* ppContent);
    HRESULT Capabilities(IPortableDeviceCapabilities* ppCapabilities);
    HRESULT Cancel();
    HRESULT Close();
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, 
                   ushort** ppszCookie);
    HRESULT Unadvise(const(wchar)* pszCookie);
    HRESULT GetPnPDeviceID(ushort** ppszPnPDeviceID);
}

@GUID("6A96ED84-7C73-4480-9938-BF5AF477D426")
interface IPortableDeviceContent : IUnknown
{
    HRESULT EnumObjects(const(uint) dwFlags, const(wchar)* pszParentObjectID, IPortableDeviceValues pFilter, 
                        IEnumPortableDeviceObjectIDs* ppEnum);
    HRESULT Properties(IPortableDeviceProperties* ppProperties);
    HRESULT Transfer(IPortableDeviceResources* ppResources);
    HRESULT CreateObjectWithPropertiesOnly(IPortableDeviceValues pValues, ushort** ppszObjectID);
    HRESULT CreateObjectWithPropertiesAndData(IPortableDeviceValues pValues, IStream* ppData, 
                                              uint* pdwOptimalWriteBufferSize, ushort** ppszCookie);
    HRESULT Delete(const(uint) dwOptions, IPortableDevicePropVariantCollection pObjectIDs, 
                   IPortableDevicePropVariantCollection* ppResults);
    HRESULT GetObjectIDsFromPersistentUniqueIDs(IPortableDevicePropVariantCollection pPersistentUniqueIDs, 
                                                IPortableDevicePropVariantCollection* ppObjectIDs);
    HRESULT Cancel();
    HRESULT Move(IPortableDevicePropVariantCollection pObjectIDs, const(wchar)* pszDestinationFolderObjectID, 
                 IPortableDevicePropVariantCollection* ppResults);
    HRESULT Copy(IPortableDevicePropVariantCollection pObjectIDs, const(wchar)* pszDestinationFolderObjectID, 
                 IPortableDevicePropVariantCollection* ppResults);
}

@GUID("9B4ADD96-F6BF-4034-8708-ECA72BF10554")
interface IPortableDeviceContent2 : IPortableDeviceContent
{
    HRESULT UpdateObjectWithPropertiesAndData(const(wchar)* pszObjectID, IPortableDeviceValues pProperties, 
                                              IStream* ppData, uint* pdwOptimalWriteBufferSize);
}

@GUID("10ECE955-CF41-4728-BFA0-41EEDF1BBF19")
interface IEnumPortableDeviceObjectIDs : IUnknown
{
    HRESULT Next(uint cObjects, char* pObjIDs, uint* pcFetched);
    HRESULT Skip(uint cObjects);
    HRESULT Reset();
    HRESULT Clone(IEnumPortableDeviceObjectIDs* ppEnum);
    HRESULT Cancel();
}

@GUID("7F6D695C-03DF-4439-A809-59266BEEE3A6")
interface IPortableDeviceProperties : IUnknown
{
    HRESULT GetSupportedProperties(const(wchar)* pszObjectID, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetPropertyAttributes(const(wchar)* pszObjectID, const(PROPERTYKEY)* Key, 
                                  IPortableDeviceValues* ppAttributes);
    HRESULT GetValues(const(wchar)* pszObjectID, IPortableDeviceKeyCollection pKeys, 
                      IPortableDeviceValues* ppValues);
    HRESULT SetValues(const(wchar)* pszObjectID, IPortableDeviceValues pValues, IPortableDeviceValues* ppResults);
    HRESULT Delete(const(wchar)* pszObjectID, IPortableDeviceKeyCollection pKeys);
    HRESULT Cancel();
}

@GUID("FD8878AC-D841-4D17-891C-E6829CDB6934")
interface IPortableDeviceResources : IUnknown
{
    HRESULT GetSupportedResources(const(wchar)* pszObjectID, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetResourceAttributes(const(wchar)* pszObjectID, const(PROPERTYKEY)* Key, 
                                  IPortableDeviceValues* ppResourceAttributes);
    HRESULT GetStream(const(wchar)* pszObjectID, const(PROPERTYKEY)* Key, const(uint) dwMode, 
                      uint* pdwOptimalBufferSize, IStream* ppStream);
    HRESULT Delete(const(wchar)* pszObjectID, IPortableDeviceKeyCollection pKeys);
    HRESULT Cancel();
    HRESULT CreateResource(IPortableDeviceValues pResourceAttributes, IStream* ppData, 
                           uint* pdwOptimalWriteBufferSize, ushort** ppszCookie);
}

@GUID("2C8C6DBF-E3DC-4061-BECC-8542E810D126")
interface IPortableDeviceCapabilities : IUnknown
{
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
    HRESULT GetFunctionalCategories(IPortableDevicePropVariantCollection* ppCategories);
    HRESULT GetFunctionalObjects(const(GUID)* Category, IPortableDevicePropVariantCollection* ppObjectIDs);
    HRESULT GetSupportedContentTypes(const(GUID)* Category, IPortableDevicePropVariantCollection* ppContentTypes);
    HRESULT GetSupportedFormats(const(GUID)* ContentType, IPortableDevicePropVariantCollection* ppFormats);
    HRESULT GetSupportedFormatProperties(const(GUID)* Format, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetFixedPropertyAttributes(const(GUID)* Format, const(PROPERTYKEY)* Key, 
                                       IPortableDeviceValues* ppAttributes);
    HRESULT Cancel();
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
    HRESULT GetEventOptions(const(GUID)* Event, IPortableDeviceValues* ppOptions);
}

@GUID("A8792A31-F385-493C-A893-40F64EB45F6E")
interface IPortableDeviceEventCallback : IUnknown
{
    HRESULT OnEvent(IPortableDeviceValues pEventParameters);
}

@GUID("88E04DB3-1012-4D64-9996-F703A950D3F4")
interface IPortableDeviceDataStream : IStream
{
    HRESULT GetObjectID(ushort** ppszObjectID);
    HRESULT Cancel();
}

@GUID("5E98025F-BFC4-47A2-9A5F-BC900A507C67")
interface IPortableDeviceUnitsStream : IUnknown
{
    HRESULT SeekInUnits(LARGE_INTEGER dlibMove, WPD_STREAM_UNITS units, uint dwOrigin, 
                        ULARGE_INTEGER* plibNewPosition);
    HRESULT Cancel();
}

@GUID("482B05C0-4056-44ED-9E0F-5E23B009DA93")
interface IPortableDevicePropertiesBulk : IUnknown
{
    HRESULT QueueGetValuesByObjectList(IPortableDevicePropVariantCollection pObjectIDs, 
                                       IPortableDeviceKeyCollection pKeys, 
                                       IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
    HRESULT QueueGetValuesByObjectFormat(const(GUID)* pguidObjectFormat, const(wchar)* pszParentObjectID, 
                                         const(uint) dwDepth, IPortableDeviceKeyCollection pKeys, 
                                         IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
    HRESULT QueueSetValuesByObjectList(IPortableDeviceValuesCollection pObjectValues, 
                                       IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
    HRESULT Start(const(GUID)* pContext);
    HRESULT Cancel(const(GUID)* pContext);
}

@GUID("9DEACB80-11E8-40E3-A9F3-F557986A7845")
interface IPortableDevicePropertiesBulkCallback : IUnknown
{
    HRESULT OnStart(const(GUID)* pContext);
    HRESULT OnProgress(const(GUID)* pContext, IPortableDeviceValuesCollection pResults);
    HRESULT OnEnd(const(GUID)* pContext, HRESULT hrStatus);
}

@GUID("A8ABC4E9-A84A-47A9-80B3-C5D9B172A961")
interface IPortableDeviceServiceManager : IUnknown
{
    HRESULT GetDeviceServices(const(wchar)* pszPnPDeviceID, const(GUID)* guidServiceCategory, ushort** pServices, 
                              uint* pcServices);
    HRESULT GetDeviceForService(const(wchar)* pszPnPServiceID, ushort** ppszPnPDeviceID);
}

@GUID("D3BD3A44-D7B5-40A9-98B7-2FA4D01DEC08")
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
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, 
                   ushort** ppszCookie);
    HRESULT Unadvise(const(wchar)* pszCookie);
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
}

@GUID("24DBD89D-413E-43E0-BD5B-197F3C56C886")
interface IPortableDeviceServiceCapabilities : IUnknown
{
    HRESULT GetSupportedMethods(IPortableDevicePropVariantCollection* ppMethods);
    HRESULT GetSupportedMethodsByFormat(const(GUID)* Format, IPortableDevicePropVariantCollection* ppMethods);
    HRESULT GetMethodAttributes(const(GUID)* Method, IPortableDeviceValues* ppAttributes);
    HRESULT GetMethodParameterAttributes(const(GUID)* Method, const(PROPERTYKEY)* Parameter, 
                                         IPortableDeviceValues* ppAttributes);
    HRESULT GetSupportedFormats(IPortableDevicePropVariantCollection* ppFormats);
    HRESULT GetFormatAttributes(const(GUID)* Format, IPortableDeviceValues* ppAttributes);
    HRESULT GetSupportedFormatProperties(const(GUID)* Format, IPortableDeviceKeyCollection* ppKeys);
    HRESULT GetFormatPropertyAttributes(const(GUID)* Format, const(PROPERTYKEY)* Property, 
                                        IPortableDeviceValues* ppAttributes);
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
    HRESULT GetEventAttributes(const(GUID)* Event, IPortableDeviceValues* ppAttributes);
    HRESULT GetEventParameterAttributes(const(GUID)* Event, const(PROPERTYKEY)* Parameter, 
                                        IPortableDeviceValues* ppAttributes);
    HRESULT GetInheritedServices(const(uint) dwInheritanceType, IPortableDevicePropVariantCollection* ppServices);
    HRESULT GetFormatRenderingProfiles(const(GUID)* Format, IPortableDeviceValuesCollection* ppRenderingProfiles);
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
    HRESULT Cancel();
}

@GUID("E20333C9-FD34-412D-A381-CC6F2D820DF7")
interface IPortableDeviceServiceMethods : IUnknown
{
    HRESULT Invoke(const(GUID)* Method, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
    HRESULT InvokeAsync(const(GUID)* Method, IPortableDeviceValues pParameters, 
                        IPortableDeviceServiceMethodCallback pCallback);
    HRESULT Cancel(IPortableDeviceServiceMethodCallback pCallback);
}

@GUID("C424233C-AFCE-4828-A756-7ED7A2350083")
interface IPortableDeviceServiceMethodCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus, IPortableDeviceValues pResults);
}

@GUID("E56B0534-D9B9-425C-9B99-75F97CB3D7C8")
interface IPortableDeviceServiceActivation : IUnknown
{
    HRESULT OpenAsync(const(wchar)* pszPnPServiceID, IPortableDeviceValues pClientInfo, 
                      IPortableDeviceServiceOpenCallback pCallback);
    HRESULT CancelOpenAsync();
}

@GUID("BCED49C8-8EFE-41ED-960B-61313ABD47A9")
interface IPortableDeviceServiceOpenCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus);
}

@GUID("5E1EAFC3-E3D7-4132-96FA-759C0F9D1E0F")
interface IPortableDeviceDispatchFactory : IUnknown
{
    HRESULT GetDeviceDispatch(const(wchar)* pszPnPDeviceID, IDispatch* ppDeviceDispatch);
}

@GUID("94FC7953-5CA1-483A-8AEE-DF52E7747D00")
interface IPortableDeviceWebControl : IDispatch
{
    HRESULT GetDeviceFromId(BSTR deviceId, IDispatch* ppDevice);
    HRESULT GetDeviceFromIdAsync(BSTR deviceId, IDispatch pCompletionHandler, IDispatch pErrorHandler);
}

@GUID("BFDEF549-9247-454F-BD82-06FE80853FAA")
interface IEnumPortableDeviceConnectors : IUnknown
{
    HRESULT Next(uint cRequested, char* pConnectors, uint* pcFetched);
    HRESULT Skip(uint cConnectors);
    HRESULT Reset();
    HRESULT Clone(IEnumPortableDeviceConnectors* ppEnum);
}

@GUID("625E2DF8-6392-4CF0-9AD1-3CFA5F17775C")
interface IPortableDeviceConnector : IUnknown
{
    HRESULT Connect(IConnectionRequestCallback pCallback);
    HRESULT Disconnect(IConnectionRequestCallback pCallback);
    HRESULT Cancel(IConnectionRequestCallback pCallback);
    HRESULT GetProperty(const(DEVPROPKEY)* pPropertyKey, uint* pPropertyType, char* ppData, uint* pcbData);
    HRESULT SetProperty(const(DEVPROPKEY)* pPropertyKey, uint PropertyType, char* pData, uint cbData);
    HRESULT GetPnPID(ushort** ppwszPnPID);
}

@GUID("272C9AE0-7161-4AE0-91BD-9F448EE9C427")
interface IConnectionRequestCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus);
}


// GUIDs

const GUID CLSID_EnumBthMtpConnectors                = GUIDOF!EnumBthMtpConnectors;
const GUID CLSID_PortableDevice                      = GUIDOF!PortableDevice;
const GUID CLSID_PortableDeviceDispatchFactory       = GUIDOF!PortableDeviceDispatchFactory;
const GUID CLSID_PortableDeviceFTM                   = GUIDOF!PortableDeviceFTM;
const GUID CLSID_PortableDeviceKeyCollection         = GUIDOF!PortableDeviceKeyCollection;
const GUID CLSID_PortableDeviceManager               = GUIDOF!PortableDeviceManager;
const GUID CLSID_PortableDevicePropVariantCollection = GUIDOF!PortableDevicePropVariantCollection;
const GUID CLSID_PortableDeviceService               = GUIDOF!PortableDeviceService;
const GUID CLSID_PortableDeviceServiceFTM            = GUIDOF!PortableDeviceServiceFTM;
const GUID CLSID_PortableDeviceValues                = GUIDOF!PortableDeviceValues;
const GUID CLSID_PortableDeviceValuesCollection      = GUIDOF!PortableDeviceValuesCollection;
const GUID CLSID_PortableDeviceWebControl            = GUIDOF!PortableDeviceWebControl;
const GUID CLSID_WpdSerializer                       = GUIDOF!WpdSerializer;

const GUID IID_IConnectionRequestCallback            = GUIDOF!IConnectionRequestCallback;
const GUID IID_IEnumPortableDeviceConnectors         = GUIDOF!IEnumPortableDeviceConnectors;
const GUID IID_IEnumPortableDeviceObjectIDs          = GUIDOF!IEnumPortableDeviceObjectIDs;
const GUID IID_IPortableDevice                       = GUIDOF!IPortableDevice;
const GUID IID_IPortableDeviceCapabilities           = GUIDOF!IPortableDeviceCapabilities;
const GUID IID_IPortableDeviceConnector              = GUIDOF!IPortableDeviceConnector;
const GUID IID_IPortableDeviceContent                = GUIDOF!IPortableDeviceContent;
const GUID IID_IPortableDeviceContent2               = GUIDOF!IPortableDeviceContent2;
const GUID IID_IPortableDeviceDataStream             = GUIDOF!IPortableDeviceDataStream;
const GUID IID_IPortableDeviceDispatchFactory        = GUIDOF!IPortableDeviceDispatchFactory;
const GUID IID_IPortableDeviceEventCallback          = GUIDOF!IPortableDeviceEventCallback;
const GUID IID_IPortableDeviceKeyCollection          = GUIDOF!IPortableDeviceKeyCollection;
const GUID IID_IPortableDeviceManager                = GUIDOF!IPortableDeviceManager;
const GUID IID_IPortableDevicePropVariantCollection  = GUIDOF!IPortableDevicePropVariantCollection;
const GUID IID_IPortableDeviceProperties             = GUIDOF!IPortableDeviceProperties;
const GUID IID_IPortableDevicePropertiesBulk         = GUIDOF!IPortableDevicePropertiesBulk;
const GUID IID_IPortableDevicePropertiesBulkCallback = GUIDOF!IPortableDevicePropertiesBulkCallback;
const GUID IID_IPortableDeviceResources              = GUIDOF!IPortableDeviceResources;
const GUID IID_IPortableDeviceService                = GUIDOF!IPortableDeviceService;
const GUID IID_IPortableDeviceServiceActivation      = GUIDOF!IPortableDeviceServiceActivation;
const GUID IID_IPortableDeviceServiceCapabilities    = GUIDOF!IPortableDeviceServiceCapabilities;
const GUID IID_IPortableDeviceServiceManager         = GUIDOF!IPortableDeviceServiceManager;
const GUID IID_IPortableDeviceServiceMethodCallback  = GUIDOF!IPortableDeviceServiceMethodCallback;
const GUID IID_IPortableDeviceServiceMethods         = GUIDOF!IPortableDeviceServiceMethods;
const GUID IID_IPortableDeviceServiceOpenCallback    = GUIDOF!IPortableDeviceServiceOpenCallback;
const GUID IID_IPortableDeviceUnitsStream            = GUIDOF!IPortableDeviceUnitsStream;
const GUID IID_IPortableDeviceValues                 = GUIDOF!IPortableDeviceValues;
const GUID IID_IPortableDeviceValuesCollection       = GUIDOF!IPortableDeviceValuesCollection;
const GUID IID_IPortableDeviceWebControl             = GUIDOF!IPortableDeviceWebControl;
const GUID IID_IWpdSerializer                        = GUIDOF!IWpdSerializer;
