// Written in the D programming language.

module windows.windowsportabledevices;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : BOOL, DEVPROPKEY, LARGE_INTEGER, PWSTR,
                                       ULARGE_INTEGER;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows) @nogc nothrow:


// Enums


alias DELETE_OBJECT_OPTIONS = int;
enum : int
{
    PORTABLE_DEVICE_DELETE_NO_RECURSION   = 0x00000000,
    PORTABLE_DEVICE_DELETE_WITH_RECURSION = 0x00000001,
}

alias WPD_DEVICE_TYPES = int;
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

alias WPD_DEVICE_TRANSPORTS = int;
enum : int
{
    WPD_DEVICE_TRANSPORT_UNSPECIFIED = 0x00000000,
    WPD_DEVICE_TRANSPORT_USB         = 0x00000001,
    WPD_DEVICE_TRANSPORT_IP          = 0x00000002,
    WPD_DEVICE_TRANSPORT_BLUETOOTH   = 0x00000003,
}

alias WPD_STORAGE_TYPE_VALUES = int;
enum : int
{
    WPD_STORAGE_TYPE_UNDEFINED     = 0x00000000,
    WPD_STORAGE_TYPE_FIXED_ROM     = 0x00000001,
    WPD_STORAGE_TYPE_REMOVABLE_ROM = 0x00000002,
    WPD_STORAGE_TYPE_FIXED_RAM     = 0x00000003,
    WPD_STORAGE_TYPE_REMOVABLE_RAM = 0x00000004,
}

alias WPD_STORAGE_ACCESS_CAPABILITY_VALUES = int;
enum : int
{
    WPD_STORAGE_ACCESS_CAPABILITY_READWRITE                         = 0x00000000,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITHOUT_OBJECT_DELETION = 0x00000001,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITH_OBJECT_DELETION    = 0x00000002,
}

alias WPD_SMS_ENCODING_TYPES = int;
enum : int
{
    SMS_ENCODING_7_BIT  = 0x00000000,
    SMS_ENCODING_8_BIT  = 0x00000001,
    SMS_ENCODING_UTF_16 = 0x00000002,
}

alias SMS_MESSAGE_TYPES = int;
enum : int
{
    SMS_TEXT_MESSAGE   = 0x00000000,
    SMS_BINARY_MESSAGE = 0x00000001,
}

alias WPD_POWER_SOURCES = int;
enum : int
{
    WPD_POWER_SOURCE_BATTERY  = 0x00000000,
    WPD_POWER_SOURCE_EXTERNAL = 0x00000001,
}

alias WPD_WHITE_BALANCE_SETTINGS = int;
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

alias WPD_FOCUS_MODES = int;
enum : int
{
    WPD_FOCUS_UNDEFINED       = 0x00000000,
    WPD_FOCUS_MANUAL          = 0x00000001,
    WPD_FOCUS_AUTOMATIC       = 0x00000002,
    WPD_FOCUS_AUTOMATIC_MACRO = 0x00000003,
}

alias WPD_EXPOSURE_METERING_MODES = int;
enum : int
{
    WPD_EXPOSURE_METERING_MODE_UNDEFINED               = 0x00000000,
    WPD_EXPOSURE_METERING_MODE_AVERAGE                 = 0x00000001,
    WPD_EXPOSURE_METERING_MODE_CENTER_WEIGHTED_AVERAGE = 0x00000002,
    WPD_EXPOSURE_METERING_MODE_MULTI_SPOT              = 0x00000003,
    WPD_EXPOSURE_METERING_MODE_CENTER_SPOT             = 0x00000004,
}

alias WPD_FLASH_MODES = int;
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

alias WPD_EXPOSURE_PROGRAM_MODES = int;
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

alias WPD_CAPTURE_MODES = int;
enum : int
{
    WPD_CAPTURE_MODE_UNDEFINED = 0x00000000,
    WPD_CAPTURE_MODE_NORMAL    = 0x00000001,
    WPD_CAPTURE_MODE_BURST     = 0x00000002,
    WPD_CAPTURE_MODE_TIMELAPSE = 0x00000003,
}

alias WPD_EFFECT_MODES = int;
enum : int
{
    WPD_EFFECT_MODE_UNDEFINED       = 0x00000000,
    WPD_EFFECT_MODE_COLOR           = 0x00000001,
    WPD_EFFECT_MODE_BLACK_AND_WHITE = 0x00000002,
    WPD_EFFECT_MODE_SEPIA           = 0x00000003,
}

alias WPD_FOCUS_METERING_MODES = int;
enum : int
{
    WPD_FOCUS_METERING_MODE_UNDEFINED   = 0x00000000,
    WPD_FOCUS_METERING_MODE_CENTER_SPOT = 0x00000001,
    WPD_FOCUS_METERING_MODE_MULTI_SPOT  = 0x00000002,
}

alias WPD_BITRATE_TYPES = int;
enum : int
{
    WPD_BITRATE_TYPE_UNUSED   = 0x00000000,
    WPD_BITRATE_TYPE_DISCRETE = 0x00000001,
    WPD_BITRATE_TYPE_VARIABLE = 0x00000002,
    WPD_BITRATE_TYPE_FREE     = 0x00000003,
}

alias WPD_META_GENRES = int;
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

alias WPD_CROPPED_STATUS_VALUES = int;
enum : int
{
    WPD_CROPPED_STATUS_NOT_CROPPED           = 0x00000000,
    WPD_CROPPED_STATUS_CROPPED               = 0x00000001,
    WPD_CROPPED_STATUS_SHOULD_NOT_BE_CROPPED = 0x00000002,
}

alias WPD_COLOR_CORRECTED_STATUS_VALUES = int;
enum : int
{
    WPD_COLOR_CORRECTED_STATUS_NOT_CORRECTED           = 0x00000000,
    WPD_COLOR_CORRECTED_STATUS_CORRECTED               = 0x00000001,
    WPD_COLOR_CORRECTED_STATUS_SHOULD_NOT_BE_CORRECTED = 0x00000002,
}

alias WPD_VIDEO_SCAN_TYPES = int;
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

alias WPD_OPERATION_STATES = int;
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

alias WPD_SECTION_DATA_UNITS_VALUES = int;
enum : int
{
    WPD_SECTION_DATA_UNITS_BYTES        = 0x00000000,
    WPD_SECTION_DATA_UNITS_MILLISECONDS = 0x00000001,
}

alias WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPES = int;
enum : int
{
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_OBJECT   = 0x00000000,
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_RESOURCE = 0x00000001,
}

alias WPD_COMMAND_ACCESS_TYPES = int;
enum : int
{
    WPD_COMMAND_ACCESS_READ                              = 0x00000001,
    WPD_COMMAND_ACCESS_READWRITE                         = 0x00000003,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_STGM_ACCESS    = 0x00000004,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_FILE_ACCESS    = 0x00000008,
    WPD_COMMAND_ACCESS_FROM_ATTRIBUTE_WITH_METHOD_ACCESS = 0x00000010,
}

alias WPD_SERVICE_INHERITANCE_TYPES = int;
enum : int
{
    WPD_SERVICE_INHERITANCE_IMPLEMENTATION = 0x00000000,
}

alias WPD_PARAMETER_USAGE_TYPES = int;
enum : int
{
    WPD_PARAMETER_USAGE_RETURN = 0x00000000,
    WPD_PARAMETER_USAGE_IN     = 0x00000001,
    WPD_PARAMETER_USAGE_OUT    = 0x00000002,
    WPD_PARAMETER_USAGE_INOUT  = 0x00000003,
}

alias WPD_STREAM_UNITS = int;
enum : int
{
    WPD_STREAM_UNITS_BYTES        = 0x00000000,
    WPD_STREAM_UNITS_FRAMES       = 0x00000001,
    WPD_STREAM_UNITS_ROWS         = 0x00000002,
    WPD_STREAM_UNITS_MILLISECONDS = 0x00000004,
    WPD_STREAM_UNITS_MICROSECONDS = 0x00000008,
}

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
    HRESULT GetIPortableDeviceValuesFromBuffer(ubyte* pBuffer, uint dwInputBufferLength, 
                                               IPortableDeviceValues* ppParams);
    HRESULT WriteIPortableDeviceValuesToBuffer(uint dwOutputBufferLength, IPortableDeviceValues pResults, 
                                               ubyte* pBuffer, uint* pdwBytesWritten);
    HRESULT GetBufferFromIPortableDeviceValues(IPortableDeviceValues pSource, ubyte** ppBuffer, 
                                               uint* pdwBufferSize);
    HRESULT GetSerializedSize(IPortableDeviceValues pSource, uint* pdwSize);
}

@GUID("6848F6F2-3155-4F86-B6F5-263EEEAB3143")
interface IPortableDeviceValues : IUnknown
{
    HRESULT GetCount(uint* pcelt);
    HRESULT GetAt(const(uint) index, PROPERTYKEY* pKey, PROPVARIANT* pValue);
    HRESULT SetValue(const(PROPERTYKEY)* key, const(PROPVARIANT)* pValue);
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* pValue);
    HRESULT SetStringValue(const(PROPERTYKEY)* key, const(PWSTR) Value);
    HRESULT GetStringValue(const(PROPERTYKEY)* key, PWSTR* pValue);
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
    HRESULT SetErrorValue(const(PROPERTYKEY)* key, const(HRESULT) Value);
    HRESULT GetErrorValue(const(PROPERTYKEY)* key, HRESULT* pValue);
    HRESULT SetKeyValue(const(PROPERTYKEY)* key, const(PROPERTYKEY)* Value);
    HRESULT GetKeyValue(const(PROPERTYKEY)* key, PROPERTYKEY* pValue);
    HRESULT SetBoolValue(const(PROPERTYKEY)* key, const(BOOL) Value);
    HRESULT GetBoolValue(const(PROPERTYKEY)* key, BOOL* pValue);
    HRESULT SetIUnknownValue(const(PROPERTYKEY)* key, IUnknown pValue);
    HRESULT GetIUnknownValue(const(PROPERTYKEY)* key, IUnknown* ppValue);
    HRESULT SetGuidValue(const(PROPERTYKEY)* key, const(GUID)* Value);
    HRESULT GetGuidValue(const(PROPERTYKEY)* key, GUID* pValue);
    HRESULT SetBufferValue(const(PROPERTYKEY)* key, ubyte* pValue, uint cbValue);
    HRESULT GetBufferValue(const(PROPERTYKEY)* key, ubyte** ppValue, uint* pcbValue);
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

///Enumerates devices that are connected to the computer and provides a simple way to request installation information,
///including manufacturer, friendly name, and description. This is typically the first Windows Portable Devices
///interface created by an application. To create an instance of this interface, call <b>CoCreateInstance</b> and
///specify <b>CLSID_PortableDeviceManager</b>. The properties that are requested using this interface can also be
///requested by using the IPortableDeviceProperties interface. However, that interface requires several steps to
///acquire; using this interface is a much simpler way to request device information.
@GUID("A1567595-4C2F-4574-A6FA-ECEF917B9A40")
interface IPortableDeviceManager : IUnknown
{
    ///Retrieves a list of portable devices connected to the computer.
    ///Params:
    ///    pPnPDeviceIDs = A caller-allocated array of string pointers that holds the Plug and Play names of all of the connected
    ///                    devices. To learn the required size for this parameter, first call this method with this parameter set to
    ///                    <b>NULL</b> and <i>pcPnPDeviceIDs</i> set to zero, and then allocate a buffer according to the value
    ///                    retrieved by <i>pcPnPDeviceIDs</i>. These names can be used by IPortableDevice::Open to create a connection
    ///                    to a device.
    ///    pcPnPDeviceIDs = On input, the number of values that <i>pPnPDeviceIDs</i> can hold. On output, a pointer to the number of
    ///                     devices actually written to <i>pPnPDeviceIDs</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>pPnPDeviceIDs</i> buffer is too small to hold all the values requested, but
    ///    <i>pcPnPDeviceIDs</i> values have been written to <i>pPnPDeviceIDs</i>. </td> </tr> </table>
    ///    
    HRESULT GetDevices(PWSTR* pPnPDeviceIDs, uint* pcPnPDeviceIDs);
    ///The <b>RefreshDeviceList</b> method refreshes the list of devices that are connected to the computer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT RefreshDeviceList();
    ///Retrieves the user-friendly name for the device.
    ///Params:
    ///    pszPnPDeviceID = Pointer to a null-terminated string that contains the device's Plug and Play ID. You can retrieve a list of
    ///                     Plug and Play names of all devices that are connected to the computer by calling GetDevices.
    ///    pDeviceFriendlyName = A caller-allocated buffer that is used to hold the user-friendly name for the device. To learn the required
    ///                          size for this parameter, first call this method with this parameter set to <b>NULL</b> and
    ///                          <i>pcchDeviceFriendlyName</i> set to <b>0</b>; the method will succeed and set <i>pcchDeviceFriendlyName</i>
    ///                          to the required buffer size to hold the device-friendly name, including the termination character.
    ///    pcchDeviceFriendlyName = On input, the maximum number of characters that <i>pDeviceFriendlyName</i> can hold, not including the
    ///                             termination character. On output, the number of characters that is returned by <i>pDeviceFriendlyName</i>,
    ///                             not including the termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The supplied
    ///    buffer is not large enough to hold the device description. (Refer to the value returned in
    ///    <i>pcchDeviceDescription</i> for the required size.) </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATA)</b></dt> </dl> </td> <td width="60%"> The device description
    ///    could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> At least one of the required arguments was a <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT GetDeviceFriendlyName(const(PWSTR) pszPnPDeviceID, PWSTR pDeviceFriendlyName, 
                                  uint* pcchDeviceFriendlyName);
    ///Retrieves the description of a device.
    ///Params:
    ///    pszPnPDeviceID = Pointer to a null-terminated string that contains the device's Plug and Play ID. You can retrieve a list of
    ///                     Plug and Play names of devices that are currently connected by calling GetDevices.
    ///    pDeviceDescription = A caller-allocated buffer to hold the user-description name of the device. The caller must allocate the
    ///                         memory for this parameter. To learn the required size for this parameter, first call this method with this
    ///                         parameter set to <b>NULL</b> and <i>pcchDeviceDescription</i> set to <b>0</b>; the method will succeed and
    ///                         set <i>pcchDeviceDescription</i> to the required buffer size to hold the device-friendly name, including the
    ///                         termination character.
    ///    pcchDeviceDescription = The number of characters (not including the termination character) in <i>pDeviceDescription</i>. On input,
    ///                            the maximum length of <i>pDeviceDescription</i>; on output, the length of the returned string in
    ///                            <i>pDeviceDescription</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The supplied
    ///    buffer is not large enough to hold the device description. (Refer to the value returned in
    ///    <i>pcchDeviceDescription</i> for the required size.) </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATA)</b></dt> </dl> </td> <td width="60%"> The device description
    ///    could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> At least one of the required arguments was a <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT GetDeviceDescription(const(PWSTR) pszPnPDeviceID, PWSTR pDeviceDescription, 
                                 uint* pcchDeviceDescription);
    ///Retrieves the name of the device manufacturer.
    ///Params:
    ///    pszPnPDeviceID = Pointer to a null-terminated string that contains the device's Plug and Play ID. You can retrieve a list of
    ///                     Plug and Play names of all devices that are connected to the computer by calling GetDevices.
    ///    pDeviceManufacturer = A caller-allocated buffer that holds the name of the device manufacturer. To learn the required size for this
    ///                          parameter, first call this method with this parameter set to <b>NULL</b> and <i>pcchDeviceManufacturer</i>
    ///                          set to <b>0</b>; the method will succeed and set <i>pcchDeviceManufacturer</i> to the required buffer size to
    ///                          hold the device-friendly name, including the termination character.
    ///    pcchDeviceManufacturer = On input, the maximum number of characters that <i>pDeviceManufacturer</i> can hold, not including the
    ///                             termination character. On output, the number of characters returned by <i>pDeviceManufacturer</i>, not
    ///                             including the termination character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The supplied
    ///    buffer is not large enough to hold the device description. (Refer to the value returned in
    ///    <i>pcchDeviceDescription</i> for the required size.) </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATA)</b></dt> </dl> </td> <td width="60%"> The device description
    ///    could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> At least one of the required arguments was a <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT GetDeviceManufacturer(const(PWSTR) pszPnPDeviceID, PWSTR pDeviceManufacturer, 
                                  uint* pcchDeviceManufacturer);
    ///Retrieves a property value stored by the device on the computer. (These are not standard properties that are
    ///defined by Windows Portable Devices.)
    ///Params:
    ///    pszPnPDeviceID = Pointer to a null-terminated string that contains the device's Plug and Play ID. You can retrieve a list of
    ///                     Plug and Play names of all devices that are connected to the computer by calling GetDevices.
    ///    pszDevicePropertyName = Pointer to a null-terminated string that contains the name of the property to request. These are custom
    ///                            property names defined by a device manufacturer.
    ///    pData = A caller-allocated buffer to hold the retrieved data. To get the size required, call this method with this
    ///            parameter set to <b>NULL</b> and <i>pcbData</i> set to zero, and the required size will be retrieved in
    ///            <i>pcbData</i>. This call will also return an error that can be ignored. See Return Values.
    ///    pcbData = The size of the buffer allocated or returned by <i>pData</i>, in bytes.
    ///    pdwType = A constant describing the type of data returned in <i>pData</i>. The values for this parameter are the same
    ///              types used to describe the <i>lpType</i> parameter of the Platform SDK function <b>RegQueryValueEx</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The supplied
    ///    buffer is not large enough to hold the requested data. (This result is always returned when <i>pData</i> is
    ///    <b>NULL</b>. You can ignore this result if you are calling the method to retrieve the required buffer size.
    ///    See the description of the <i>pData</i> parameter.) </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT GetDeviceProperty(const(PWSTR) pszPnPDeviceID, const(PWSTR) pszDevicePropertyName, ubyte* pData, 
                              uint* pcbData, uint* pdwType);
    ///The <b>GetPrivateDevices</b> method retrieves a list of private portable devices connected to the computer. These
    ///private devices are only accessible through an application that is designed for these particular devices.
    ///Params:
    ///    pPnPDeviceIDs = A caller-allocated array of string pointers that holds the Plug and Play names of all of the connected
    ///                    devices. To learn the required size for this parameter, first call this method with this parameter set to
    ///                    <b>NULL</b> and <i>pcPnPDeviceIDs</i> set to zero, and then allocate a buffer according to the value
    ///                    retrieved by <i>pcPnPDeviceIDs</i>. These names can be used by IPortableDevice::Open to create a connection
    ///                    to a device.
    ///    pcPnPDeviceIDs = On input, the number of values that <i>pPnPDeviceIDs</i> can hold. On output, a pointer to the number of
    ///                     devices actually written to <i>pPnPDeviceIDs</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>pPnPDeviceIDs</i> buffer is too small to hold all the values requested, but
    ///    <i>pcPnPDeviceIDs</i> values have been written to <i>pPnPDeviceIDs</i>. </td> </tr> </table>
    ///    
    HRESULT GetPrivateDevices(PWSTR* pPnPDeviceIDs, uint* pcPnPDeviceIDs);
}

///The <b>IPortableDevice</b> interface provides access to a portable device. To create and open this interface, first
///call CoCreateInstance with <b>CLSID_PortableDeviceFTM</b> or <b>CLSID_PortableDevice</b>to retrieve an
///<b>IPortableDevice</b> interface, and then call Open to open a connection to the device.
@GUID("625E2DF8-6392-4CF0-9AD1-3CFA5F17775C")
interface IPortableDevice : IUnknown
{
    ///The <b>Open</b> method opens a connection between the application and the device.
    ///Params:
    ///    pszPnPDeviceID = A pointer to a null-terminated string that contains the Plug and Play ID string for the device. You can get
    ///                     this string by calling IPortableDeviceManager::GetDevices.
    ///    pClientInfo = A pointer to an IPortableDeviceValues interface that holds information that identifies the application to the
    ///                  device. This interface holds <b>PROPERTYKEY</b>/value pairs that try to identify an application uniquely.
    ///                  Although the presence of a CoCreated interface is required, the application is not required to send any
    ///                  key/value pairs. However, sending data might improve performance. Typical key/value pairs include the
    ///                  application name, major and minor version, and build number. See properties beginning with "WPD_CLIENT_" in
    ///                  the Properties section.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_WPD_DEVICE_ALREADY_OPENED</b></dt> </dl> </td> <td width="60%"> The device connection has
    ///    already been opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> At least one of the arguments was a NULL pointer. </td> </tr> </table>
    ///    
    HRESULT Open(const(PWSTR) pszPnPDeviceID, IPortableDeviceValues pClientInfo);
    ///The <b>SendCommand</b> method sends a command to the device and retrieves the results synchronously.
    ///Params:
    ///    dwFlags = Currently not used; specify zero.
    ///    pParameters = Pointer to an IPortableDeviceValues interface that specifies the command and parameters to call on the
    ///                  device. This interface must include the following two values to indicate the command. Additional parameters
    ///                  vary depending on the command. For a list of the parameters that are required for each command, see Commands.
    ///                  <table> <tr> <th>Command or property</th> <th>Description</th> </tr> <tr>
    ///                  <td>WPD_PROPERTY_COMMON_COMMAND_CATEGORY</td> <td>The category <b>GUID</b> of the command to send. For
    ///                  example, to reset a device, you would send <b>WPD_COMMAND_COMMON_RESET_DEVICE.fmtid</b>.</td> </tr> <tr>
    ///                  <td>WPD_PROPERTY_COMMON_COMMAND_ID</td> <td>The PID of the command to send. For example, to reset a device,
    ///                  you would send <b>WPD_COMMAND_COMMON_RESET_DEVICE.pid</b>.</td> </tr> </table>
    ///    ppResults = Address of a variable that receives a pointer to an IPortableDeviceValues interface that indicates the
    ///                results of the command results, including success or failure, and any command values returned by the device.
    ///                The caller must release this interface when it is done with it. The retrieved values vary by command; see the
    ///                appropriate command documentation in Commands to learn what values are returned by each command call.
    ///Returns:
    ///    The returned value indicates success or failure to send a command and return a result from the driver; it
    ///    does not indicate whether the driver supports the command or if it encountered some error in processing the
    ///    command. (For more information, see Remarks.) These errors are returned in the <b>HRESULT</b> values of the
    ///    <i>ppResults</i> parameter. The possible <b>HRESULT</b> values returned by this method include, but are not
    ///    limited to, those in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The command was successfully received
    ///    by the driver. This does not indicate that the command itself succeeded—you must check <i>ppResults</i> to
    ///    determine the success or failure of the command. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the arguments was a NULL pointer.
    ///    </td> </tr> </table>
    ///    
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
    ///The <b>Content</b> method retrieves an interface that you can use to access objects on a device.
    ///Params:
    ///    ppContent = Address of a variable that receives a pointer to an IPortableDeviceContent interface that is used to access
    ///                the content on a device. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>ppContent</i> argument was a NULL pointer.
    ///    </td> </tr> </table>
    ///    
    HRESULT Content(IPortableDeviceContent* ppContent);
    ///The <b>Capabilities</b> method retrieves an interface used to query the capabilities of a portable device.
    ///Params:
    ///    ppCapabilities = Address of a variable that receives a pointer to an IPortableDeviceCapabilities interface that can describe
    ///                     the device's capabilities. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>ppCapabilities</i> argument was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT Capabilities(IPortableDeviceCapabilities* ppCapabilities);
    ///The <b>Cancel</b> method cancels a pending operation on this interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was canceled successfully. </td> </tr>
    ///    </table>
    ///    
    HRESULT Cancel();
    ///The <b>Close</b> method closes the connection with the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Close();
    ///The <b>Advise</b> method registers an application-defined callback that receives device events.
    ///Params:
    ///    dwFlags = <b>DWORD</b> that specifies option flags.
    ///    pCallback = Pointer to a callback object.
    ///    pParameters = This parameter is ignored and should be set to <b>NULL</b>.
    ///    ppszCookie = A string that represents a unique context ID. This is used to unregister for callbacks when calling Unadvise.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The application-defined callback was successfully
    ///    registered. </td> </tr> </table>
    ///    
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, 
                   PWSTR* ppszCookie);
    ///The <b>Unadvise</b> method unregisters a client from receiving callback notifications. You must call this method
    ///if you called Advise previously.
    ///Params:
    ///    pszCookie = Pointer to a null-terminated string that is a unique context ID. This was retrieved in the initial call to
    ///                IPortableDevice::Advise.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Unadvise(const(PWSTR) pszCookie);
    ///The <b>GetPnPDeviceID</b> method retrieves the Plug and Play (PnP) device identifier that the application used to
    ///open the device.
    ///Params:
    ///    ppszPnPDeviceID = Pointer to a null-terminated string that contains the Plug and Play ID string for the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_WPD_DEVICE_NOT_OPEN</b></dt> </dl> </td> <td width="60%"> The IPortableDevice::Open method has
    ///    not been called yet for this device. </td> </tr> </table>
    ///    
    HRESULT GetPnPDeviceID(PWSTR* ppszPnPDeviceID);
}

///The <b>IPortableDeviceContent</b> interface provides methods to create, enumerate, examine, and delete content on a
///device. To get this interface, call <b>IPortableDevice::Content</b>.
@GUID("6A96ED84-7C73-4480-9938-BF5AF477D426")
interface IPortableDeviceContent : IUnknown
{
    ///The <b>EnumObjects</b> method retrieves an interface that is used to enumerate the immediate child objects of an
    ///object. It has an optional filter that can enumerate objects with specific properties.
    ///Params:
    ///    dwFlags = Currently ignored; specify zero.
    ///    pszParentObjectID = Pointer to a null-terminated string that specifies the ID of the parent. This can be an empty string (but not
    ///                        a <b>NULL</b> pointer) or the defined constant <b>WPD_DEVICE_OBJECT_ID</b> to indicate the device root.
    ///    pFilter = This parameter is ignored and should be set to <b>NULL</b>.
    ///    ppEnum = Address of a variable that receives a pointer to an IEnumPortableDeviceObjectIDs interface that is used to
    ///             enumerate the objects that are found. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT EnumObjects(const(uint) dwFlags, const(PWSTR) pszParentObjectID, IPortableDeviceValues pFilter, 
                        IEnumPortableDeviceObjectIDs* ppEnum);
    ///The <b>Properties</b> method retrieves the interface that is required to get or set properties on an object on
    ///the device.
    ///Params:
    ///    ppProperties = Address of a variable that receives a pointer to an IPortableDeviceProperties interface that is used to get
    ///                   or set object properties. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT Properties(IPortableDeviceProperties* ppProperties);
    ///The Transfer method retrieves an interface that is used to read from or write to the content data of an existing
    ///object resource.
    ///Params:
    ///    ppResources = Address of a variable that receives a pointer to an IPortableDeviceResources interface that is used to modify
    ///                  an object's resources. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT Transfer(IPortableDeviceResources* ppResources);
    ///The <b>CreateObjectWithPropertiesOnly</b> method creates an object with only properties on the device.
    ///Params:
    ///    pValues = An IPortableDeviceValues collection of properties to assign to the object. For a list of required and
    ///              optional properties for an object, see Requirements for Objects.
    ///    ppszObjectID = An optional string pointer to receive the name of the new object. Can be <b>NULL</b>, if not needed. Windows
    ///                   Portable Devices defines the constant WPD_DEVICE_OBJECT_ID to represent a device. The SDK allocates this
    ///                   memory; the caller must release it using <b>CoTaskMemFree</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT CreateObjectWithPropertiesOnly(IPortableDeviceValues pValues, PWSTR* ppszObjectID);
    ///The <b>CreateObjectWithPropertiesAndData</b> method creates an object with both properties and data on the
    ///device.
    ///Params:
    ///    pValues = An <b>IPortableDeviceValues</b> collection of properties to assign to the object. For a list of required and
    ///              optional properties for an object, see Requirements for Objects.
    ///    ppData = Address of a variable that receives a pointer to an <b>IStream</b> interface that the application uses to
    ///             send the object data to the device. The object will not be created on the device until the application sends
    ///             the data by calling <i>ppData</i>-&gt;<b>Commit</b>. To abandon a data transfer in progress, you can call
    ///             <i>ppData</i> -&gt; <b>Revert</b>. The caller must release this interface when it is done with it. The
    ///             underlying object extends both <b>IStream</b> and IPortableDeviceDataStream.
    ///    pdwOptimalWriteBufferSize = An optional <b>DWORD</b> pointer that specifies the optimal buffer size for the application to use when
    ///                                writing the data to <i>ppData</i>. The application can specify <b>TRUE</b> to ignore this.
    ///    ppszCookie = An optional unique, null-terminated string ID that is used to identify this creation request in the
    ///                 application's implementation of IPortableDeviceEventCallback (if implemented). When the device finishes
    ///                 creating the object, it will send this identifier to the callback function. This identifier allows an
    ///                 application to monitor object creation in a different thread from the one that called
    ///                 CreateObjectWithPropertiesOnly. The SDK allocates this memory, and the caller must release it using
    ///                 <b>CoTaskMemFree</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT CreateObjectWithPropertiesAndData(IPortableDeviceValues pValues, IStream* ppData, 
                                              uint* pdwOptimalWriteBufferSize, PWSTR* ppszCookie);
    ///The <b>Delete</b> method deletes one or more objects from the device.
    ///Params:
    ///    dwOptions = One of the DELETE_OBJECT_OPTIONS enumerators.
    ///    pObjectIDs = Pointer to an IPortableDevicePropVariantCollection interface that holds one or more null-terminated strings
    ///                 (type VT_LPWSTR) specifying the object IDs of the objects to delete.
    ///    ppResults = Optional. On return, this parameter contains a collection of VT_ERROR values indicating the success or
    ///                failure of the operation. The first element returned in <i>ppResults</i> corresponds to the first object in
    ///                the <i>pObjectIDs</i> collection, the second element returned in <i>ppResults</i> corresponds to the second
    ///                object in the <i>pObjectIDs</i> collection, and so on. This parameter can be <b>NULL</b> if the application
    ///                is not concerned with the results.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. If any error value is returned, no objects were deleted on the device. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> At least one object could not be deleted. The <i>ppResults</i> parameter, if specified,
    ///    contains the per-object error code. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_XXXXXXXX</b></dt> </dl>
    ///    </td> <td width="60%"> The driver did not delete any objects. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid value was specified for
    ///    <i>dwOptions</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The application does not have permission to delete the object. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_DIR_NOT_EMPTY)</b></dt> </dl> </td> <td width="60%"> The specified
    ///    folder or directory could not be deleted because it was not empty. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> The application
    ///    specified PORTABLE_DEVICE_DELETE_NO_RECURSION, and the object has children. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The object could not be
    ///    deleted because it does not exist on the device. </td> </tr> </table>
    ///    
    HRESULT Delete(const(uint) dwOptions, IPortableDevicePropVariantCollection pObjectIDs, 
                   IPortableDevicePropVariantCollection* ppResults);
    ///The <b>GetObjectIDsFromPersistentUniqueIDs</b> method retrieves the current object ID of one or more objects,
    ///given their persistent unique IDs (PUIDs).
    ///Params:
    ///    pPersistentUniqueIDs = Pointer to an IPortableDevicePropVariantCollection interface that contains one or more persistent unique ID
    ///                           (PUID) string values (type VT_LPWSTR).
    ///    ppObjectIDs = Pointer to an <b>IPortableDevicePropVariantCollection</b> interface pointer that contains the retrieved
    ///                  object IDs, as type <b>VT_LPWSTR</b>. The retrieved IDs will be in the same order as the submitted PUIDs; if
    ///                  a value could not be found, it is indicated by an empty string. The caller must release this interface when
    ///                  it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT GetObjectIDsFromPersistentUniqueIDs(IPortableDevicePropVariantCollection pPersistentUniqueIDs, 
                                                IPortableDevicePropVariantCollection* ppObjectIDs);
    ///The <b>Cancel</b> method cancels a pending operation called on this interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Cancel();
    ///The <b>Move</b> method moves one or more objects from one location on the device to another.
    ///Params:
    ///    pObjectIDs = Pointer to an IPortableDevicePropVariantCollection interface that holds one or more null-terminated strings
    ///                 (type VT_LPWSTR) specifying the object IDs of the objects to be moved.
    ///    pszDestinationFolderObjectID = Pointer to a null-terminated string that specifies the ID of the destination.
    ///    ppResults = Optional. On return, this parameter contains a collection of VT_ERROR values indicating the success or
    ///                failure of the operation. The first element returned in <i>ppResults</i> corresponds to the first object in
    ///                the <i>pObjectIDs</i> collection, the second element returned in <i>ppResults</i> corresponds to the second
    ///                object in the <i>pObjectIDs</i> collection, and so on. This parameter can be <b>NULL</b> if the application
    ///                is not concerned with the results.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. If any error value is returned, no objects were deleted on the device. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> One or more objects were deleted, but at least one object could not be deleted. See
    ///    <i>ppFailedObjectIDs</i> to learn which objects were not be deleted. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The application does not have the rights to move
    ///    the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At
    ///    least one of the required arguments was a <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT Move(IPortableDevicePropVariantCollection pObjectIDs, const(PWSTR) pszDestinationFolderObjectID, 
                 IPortableDevicePropVariantCollection* ppResults);
    ///The <b>Copy</b> method copies objects from one location on a device to another.
    ///Params:
    ///    pObjectIDs = A collection of object identifiers for the objects that this method will copy.
    ///    pszDestinationFolderObjectID = An object identifier for the destination folder (or functional storage) into which this method will copy the
    ///                                   specified objects.
    ///    ppResults = A collection of VT_ERROR values indicating the success or failure of copying a particular element. The first
    ///                error value corresponds to the first object in the collection of object identifiers, the second to the second
    ///                element, and so on. This argument can be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The copy operation failed for at least one object.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The
    ///    application does not have the rights to copy one of the specified objects. </td> </tr> </table>
    ///    
    HRESULT Copy(IPortableDevicePropVariantCollection pObjectIDs, const(PWSTR) pszDestinationFolderObjectID, 
                 IPortableDevicePropVariantCollection* ppResults);
}

///The <b>IPortableDeviceContent2</b> interface defines additional methods that provide access to content found on a
///device.
@GUID("9B4ADD96-F6BF-4034-8708-ECA72BF10554")
interface IPortableDeviceContent2 : IPortableDeviceContent
{
    ///The <b>UpdateObjectWithPropertiesAndData</b> method updates an object by using properties and data found on the
    ///device.
    ///Params:
    ///    pszObjectID = The identifier of the object to update.
    ///    pProperties = The IPortableDeviceValues interface that specifies the object properties to be updated.
    ///    ppData = The <b>IStream</b> interface through which the object data is sent to the device.
    ///    pdwOptimalWriteBufferSize = The optimal buffer size for writing the object data to <i>ppData</i>, or <b>NULL</b> if the buffer size is
    ///                                ignored.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT UpdateObjectWithPropertiesAndData(const(PWSTR) pszObjectID, IPortableDeviceValues pProperties, 
                                              IStream* ppData, uint* pdwOptimalWriteBufferSize);
}

///The <b>IEnumPortableDeviceObjectIDs</b> interface enumerates the objects on a portable device. Get this interface
///initially by calling IPortableDeviceContent::EnumObjects on a device.
@GUID("10ECE955-CF41-4728-BFA0-41EEDF1BBF19")
interface IEnumPortableDeviceObjectIDs : IUnknown
{
    ///The <b>Next</b> method retrieves the next one or more object IDs in the enumeration sequence.
    ///Params:
    ///    cObjects = A count of the objects requested.
    ///    pObjIDs = An array of <b>LPWSTR</b> pointers, each specifying a retrieved object ID. The caller must allocate an array
    ///              of <i>cObjects</i> LPWSTR elements. The caller must free both the array and the returned strings. The strings
    ///              are freed by calling CoTaskMemFree.
    ///    pcFetched = On input, this parameter is ignored. On output, the number of IDs actually retrieved. If no object IDs are
    ///                released and the return value is S_FALSE, there are no more objects to enumerate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There are no more objects to enumerate. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint cObjects, PWSTR* pObjIDs, uint* pcFetched);
    ///The <b>Skip</b> method skips a specified number of objects in the enumeration sequence.
    ///Params:
    ///    cObjects = The number of objects to skip.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The specified number of objects could not be
    ///    skipped (for instance, if fewer than <i>cObjects</i> remained in the enumeration sequence). </td> </tr>
    ///    </table>
    ///    
    HRESULT Skip(uint cObjects);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method duplicates the current I<b>EnumPortableDeviceObjectIDs</b> interface. <b>Not implemented
    ///in this release.</b>
    ///Params:
    ///    ppEnum = Address of a variable that receives a pointer to an enumeration interface. The caller must release this
    ///             interface when it is finished with the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented in this release. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumPortableDeviceObjectIDs* ppEnum);
    ///The <b>Cancel</b> method cancels a pending operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b> . Possible values include, but are not limited to, those in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was canceled successfully. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_WPD_DEVICE_NOT_OPEN</b></dt> </dl> </td> <td width="60%"> The device is not
    ///    opened. </td> </tr> </table>
    ///    
    HRESULT Cancel();
}

///The <b>IPortableDeviceProperties</b> interface retrieves, adds, or deletes properties from an object on a device, or
///the device itself. To get this interface, call IPortableDeviceContent::Properties on an object. To get this interface
///for the object, specify <b>WPD_DEVICE_OBJECT_ID</b> in <b>GetValues</b>.
@GUID("7F6D695C-03DF-4439-A809-59266BEEE3A6")
interface IPortableDeviceProperties : IUnknown
{
    ///The <b>GetSupportedProperties</b> method retrieves a list of properties that a specified object supports. Note
    ///that not all of these properties may actually have values.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the object ID of the object to query. To specify the
    ///                  device, use <b>WPD_DEVICE_OBJECT_ID</b>.
    ///    ppKeys = Address of a variable that receives a pointer to an IPortableDeviceKeyCollection interface that contains the
    ///             supported properties. For a list of properties defined by Windows Portable Devices, see Properties and
    ///             Attributes. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetSupportedProperties(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection* ppKeys);
    ///The <b>GetPropertyAttributes</b> method retrieves attributes of a specified object property on a device.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the object ID of the object to query. To specify the
    ///                  device, use <b>WPD_DEVICE_OBJECT_ID</b>.
    ///    Key = A <b>REFPROPERTYKEY</b> that specifies the property to query for. You can retrieve a list of supported
    ///          properties by calling GetSupportedProperties. For a list of properties that are defined by Windows Portable
    ///          Devices, see Properties and Attributes.
    ///    ppAttributes = Address of a variable that receives a pointer to an IPortableDeviceValues interface that holds the retrieved
    ///                   property attributes. These are PROPERTYKEY/value pairs, where the <b>PROPERTYKEY</b> is the property, and the
    ///                   value data type depends on the specific property. The caller must release this interface when it is done with
    ///                   it. Attributes defined by Windows Portable Devices can be found on the Properties and Attributes page.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded, and all attributes were retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    Only some attribute values could be retrieved. Others could not, and will contain an <b>HRESULT</b> value of
    ///    type VT_ERROR. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    A required pointer argument was <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetPropertyAttributes(const(PWSTR) pszObjectID, const(PROPERTYKEY)* Key, 
                                  IPortableDeviceValues* ppAttributes);
    ///The <b>GetValues</b> method retrieves a list of specified properties from a specified object on a device.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the ID of the object to query. To specify the device, use
    ///                  WPD_DEVICE_OBJECT_ID.
    ///    pKeys = Pointer to an IPortableDeviceKeyCollection interface that contains one or more properties to query for. If
    ///            this is <b>NULL</b>, all properties will be retrieved. See Properties and Attributes for a list of properties
    ///            that are defined by Windows Portable Devices.
    ///    ppValues = Address of a variable that receives a pointer to an IPortableDeviceValues interface that contains the
    ///               requested property values. These will be returned as PROPERTYKEY/value pairs, where the data type of the
    ///               value depends on the property. If a value could not be retrieved for some reason, the returned type will be
    ///               VT_ERROR, and contain an HRESULT value describing the retrieval error. The caller must release this interface
    ///               when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All requested property values were retrieved. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> One or more property values
    ///    could not be retrieved. The problem properties will have an HRESULT value in the retrieved <i>ppValues</i>
    ///    parameter. </td> </tr> </table>
    ///    
    HRESULT GetValues(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection pKeys, 
                      IPortableDeviceValues* ppValues);
    ///The <b>SetValues</b> method adds or modifies one or more properties on a specified object on a device.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the object ID of the object to modify. To specify the
    ///                  device, use WPD_DEVICE_OBJECT_ID.
    ///    pValues = Pointer to an IPortableDeviceValues interface that contains one or more property/value pairs to set. Existing
    ///              values will be overwritten.
    ///    ppResults = Address of a variable that receives a pointer to an <b>IPortableDeviceValues</b> interface that contains a
    ///                collection of property/HRESULT values. Each value (type VT_ERROR) describes the success or failure of the
    ///                property set attempt. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All specified property values were updated. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> One or more properties could
    ///    not be modified. Those that could not will have an <b>HRESULT</b> of type VT_ERROR in the retrieved
    ///    <i>ppResults</i> parameter. </td> </tr> </table>
    ///    
    HRESULT SetValues(const(PWSTR) pszObjectID, IPortableDeviceValues pValues, IPortableDeviceValues* ppResults);
    ///The <b>Delete</b> method deletes specified properties from a specified object on a device.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that specifies the ID of the object whose properties you will delete. To
    ///                  specify the device, use <b>WPD_DEVICE_OBJECT_ID</b>.
    ///    pKeys = Pointer to an IPortableDeviceKeyCollection interface that specifies which properties to delete. For a list of
    ///            properties defined by Windows Portable Devices, see Properties and Attributes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> One or more property values could not be deleted.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The required
    ///    pointer argument was <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Delete(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection pKeys);
    ///The <b>Cancel</b> method cancels a pending call.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Cancel();
}

///The <b>IPortableDeviceResources</b> interface provides access to an object's raw data. Use this interface to read or
///write resources in an object. To get this interface, call IPortableDeviceContent::Transfer.
@GUID("FD8878AC-D841-4D17-891C-E6829CDB6934")
interface IPortableDeviceResources : IUnknown
{
    ///The <b>GetSupportedResources</b> method retrieves a list of resources that are supported by a specific object.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the ID of the object.
    ///    ppKeys = Address of a variable that receives a pointer to an IPortableDeviceKeyCollection interface that holds a
    ///             collection of <b>PROPERTYKEY</b> values specifying resource types supported by this object type. If the
    ///             object cannot hold resources, this will be an empty collection. The caller must release this interface when
    ///             it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required pointer arguments
    ///    was <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSupportedResources(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection* ppKeys);
    ///The <b>GetResourceAttributes</b> method retrieves all attributes from a specified resource in an object.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the object ID of the object hosting the resource.
    ///    Key = A <b>REFPROPERTYKEY</b> that specifies which resource to query.
    ///    ppResourceAttributes = Pointer to an IPortableDeviceValues interface pointer that holds <b>PROPERTYKEY</b>/<b>PROPVARIANT</b> pairs
    ///                           that describe each attribute and its value, respectively. The value types of the attribute values vary. If a
    ///                           property could not be returned, the value for the returned property will be <b>VT_ERROR</b>, and the
    ///                           <b>PROPVARIANT</b> <i>scode</i> member will contain the <b>HRESULT</b> of that particular failure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All attribute values were retrieved. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> One or more attribute values could not
    ///    be retrieved. These will have <b>HRESULT</b> values of type VT_ERROR in the retrieved
    ///    <i>ppResourceAttributes</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> At least one of the required pointer arguments was <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetResourceAttributes(const(PWSTR) pszObjectID, const(PROPERTYKEY)* Key, 
                                  IPortableDeviceValues* ppResourceAttributes);
    ///The <b>GetStream</b> method gets an <b>IStream</b> interface with which to read or write the content data in an
    ///object on a device. The retrieved interface enables you to read from or write to the object data.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the object ID of the object.
    ///    Key = A <b>REFPROPERTYKEY</b> that specifies which resource to read. You can retrieve the keys of all the object's
    ///          resources by calling GetSupportedResources.
    ///    dwMode = One of the following access modes: <ul> <li>STGM_READ (Read-only access.)</li> <li>STGM_WRITE (Write-only
    ///             access.)</li> <li>STGM_READWRITE (Read/write access.)</li> </ul>
    ///    pdwOptimalBufferSize = An optional pointer to a <b>DWORD</b> that specifies an estimate of the best buffer size to use when reading
    ///                           or writing data by using <i>ppStream</i>. A driver is required to support this value.
    ///    ppStream = Pointer to an <b>IStream</b> interface pointer. This interface is used to read and write data to the object.
    ///               The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required pointer arguments
    ///    was <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetStream(const(PWSTR) pszObjectID, const(PROPERTYKEY)* Key, const(uint) dwMode, 
                      uint* pdwOptimalBufferSize, IStream* ppStream);
    ///The <b>Delete</b> method deletes one or more resources from the object identified by the <i>pszObjectID</i>
    ///parameter.
    ///Params:
    ///    pszObjectID = Pointer to a null-terminated string that contains the object ID of the object.
    ///    pKeys = Pointer to an IPortableDeviceKeyCollection interface that lists which resources to delete. You can find out
    ///            what resources the object has by calling GetSupportedResources.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the arguments was a <b>NULL</b>
    ///    pointer. </td> </tr> </table>
    ///    
    HRESULT Delete(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection pKeys);
    ///The <b>Cancel</b> method cancels a pending operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded </td> </tr> </table>
    ///    
    HRESULT Cancel();
    ///The <b>CreateResource</b> method creates a resource.
    ///Params:
    ///    pResourceAttributes = Pointer to the following object parameter attributes. <table> <tr> <th>Attribute</th> <th>Description</th>
    ///                          </tr> <tr> <td>WPD_OBJECT_NAME</td> <td>The object name.</td> </tr> <tr>
    ///                          <td>WPD_RESOURCE_ATTRIBUTE_TOTAL_SIZE</td> <td>The total size of the resource data stream.</td> </tr> <tr>
    ///                          <td>WPD_RESOURCE_ATTRIBUTE_FORMAT</td> <td>The format of the resource data stream.</td> </tr> <tr>
    ///                          <td>WPD_RESOURCE_ATTRIBUTE_RESOURCE_KEY</td> <td>The resource key.</td> </tr> </table>
    ///    ppData = Pointer to a stream into which the caller can write resource data.
    ///    pdwOptimalWriteBufferSize = Pointer to a value that specifies the optimal buffer size when writing to the stream. This parameter is
    ///                                optional.
    ///    ppszCookie = Pointer to a cookie that identifies the resource creation request. This parameter is optional.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the arguments was a <b>NULL</b>
    ///    pointer. </td> </tr> </table>
    ///    
    HRESULT CreateResource(IPortableDeviceValues pResourceAttributes, IStream* ppData, 
                           uint* pdwOptimalWriteBufferSize, PWSTR* ppszCookie);
}

///The <b>IPortableDeviceCapabilities</b> interface a variety of device capabilities, including supported formats,
///commands, and functional objects. You can retrieve this interface from a device by calling
///<b>IPortableDevice::Capabilities</b>.
@GUID("2C8C6DBF-E3DC-4061-BECC-8542E810D126")
interface IPortableDeviceCapabilities : IUnknown
{
    ///The <b>GetSupportedCommands</b> method retrieves a list of all the supported commands for this device.
    ///Params:
    ///    ppCommands = Address of a variable that receives a pointer to an IPortableDeviceKeyCollection interface that holds all the
    ///                 valid commands. For a list of commands that are defined by Windows Portable Devices, see Commands. The caller
    ///                 must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
    ///The <b>GetCommandOptions</b> method retrieves all the supported options for the specified command on the device.
    ///Params:
    ///    Command = A <b>REFPROPERTYKEY</b> that specifies a command to query for supported options. For a list of the commands
    ///              that are defined by Windows Portable Devices, see Commands.
    ///    ppOptions = Address of a variable that receives a pointer to an IPortableDeviceValues interface that contains the
    ///                supported options. If no options are supported, this will not contain any values. The caller must release
    ///                this interface when it is done with it. For more information, see Remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
    ///The <b>GetFunctionalCategories</b> method retrieves all functional categories supported by the device.
    ///Params:
    ///    ppCategories = Address of a variable that receives a pointer to an IPortableDevicePropVariantCollection interface that holds
    ///                   all the functional categories for this device. The values will be <b>GUID</b>s of type VT_CLSID in the
    ///                   retrieved <b>PROPVARIANT</b> values. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetFunctionalCategories(IPortableDevicePropVariantCollection* ppCategories);
    ///The GetFunctionalObjects method retrieves all functional objects that match a specified category on the device.
    ///Params:
    ///    Category = A <b>REFGUID</b> that specifies the category to search for. This can be WPD_FUNCTIONAL_CATEGORY_ALL to return
    ///               all functional objects.
    ///    ppObjectIDs = Address of a variable that receives a pointer to an IPortableDevicePropVariantCollection interface that
    ///                  contains the object IDs of the functional objects as strings (type VT_LPWSTR in the retrieved
    ///                  <b>PROPVARIANT</b> items). If no objects of the requested type are found, this will be an empty collection
    ///                  (not <b>NULL</b>). The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetFunctionalObjects(const(GUID)* Category, IPortableDevicePropVariantCollection* ppObjectIDs);
    ///The <b>GetSupportedContentTypes</b> method retrieves all supported content types for a specified functional
    ///object type on a device.
    ///Params:
    ///    Category = A <b>REFGUID</b> that specifies a functional object category. To get a list of functional categories on the
    ///               device, call IPortableDeviceCapabilities::GetFunctionalCategories.
    ///    ppContentTypes = Address of a variable that receives a pointer to an IPortableDevicePropVariantCollection interface that lists
    ///                     all the supported object types for the specified functional object category. These object types will be
    ///                     <b>GUID</b> values of type VT_CLSID in the retrieved <b>PROPVARIANT</b> items. See Requirements for Objects
    ///                     for a list of object types defined by Windows Portable Devices. The caller must release this interface when
    ///                     it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetSupportedContentTypes(const(GUID)* Category, IPortableDevicePropVariantCollection* ppContentTypes);
    ///The <b>GetSupportedFormats</b> method retrieves the supported formats for a specified object type on the device.
    ///For example, specifying audio objects might return <b>WPD_OBJECT_FORMAT_WMA</b>,<b> WPD_OBJECT_FORMAT_WAV</b>,
    ///and <b>WPD_OBJECT_FORMAT_MP3</b>.
    ///Params:
    ///    ContentType = A <b>REFGUID</b> that specifies a content type, such as image, audio, or video. For a list of content types
    ///                  that are defined by Windows Portable Devices, see Requirements for Objects.
    ///    ppFormats = Address of a variable that receives a pointer to an IPortableDevicePropVariantCollection interface that lists
    ///                the supported formats for the specified content type. These are GUID values (type VT_CLSID) in the retrieved
    ///                collection items. For a list of formats that are supported by Windows Portable Devices, see Object Formats.
    ///                The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the arguments was a <b>NULL</b>
    ///    pointer. </td> </tr> </table>
    ///    
    HRESULT GetSupportedFormats(const(GUID)* ContentType, IPortableDevicePropVariantCollection* ppFormats);
    ///The <b>GetSupportedFormatProperties</b> method retrieves the properties supported by objects of a specified
    ///format on the device.
    ///Params:
    ///    Format = A <b>REFGUID</b> that specifies the format of the object. For a list of formats that are defined by Windows
    ///             Portable Devices, see Object Formats.
    ///    ppKeys = Address of a variable that receives a pointer to an IPortableDeviceKeyCollection interface that contains the
    ///             supported properties for the specified format. For a list of properties defined by Windows Portable Devices,
    ///             see Properties and Attributes. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetSupportedFormatProperties(const(GUID)* Format, IPortableDeviceKeyCollection* ppKeys);
    ///The <b>GetFixedPropertyAttributes</b> method retrieves the standard property attributes for a specified property
    ///and format. Standard attributes are those that have the same value for all objects of the same format. For
    ///example, one device might not allow users to modify video file names; this device would return
    ///<b>WPD_PROPERTY_ATTRIBUTE_CAN_WRITE</b> with a value of False for WMV formatted objects. Attributes that can have
    ///different values for a format, or optional attributes, are not returned.
    ///Params:
    ///    Format = A <b>REFGUID</b> that specifies the format of the objects of interest. For format <b>GUID</b> values, see
    ///             Object Formats.
    ///    Key = A <b>REFPROPERTYKEY</b> that specifies the property that you want to know the attributes of. Properties
    ///          defined by Windows Portable Devices are listed in Properties and Attributes.
    ///    ppAttributes = Address of a variable that receives a pointer to an IPortableDeviceValues interface that holds the attributes
    ///                   and their values. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetFixedPropertyAttributes(const(GUID)* Format, const(PROPERTYKEY)* Key, 
                                       IPortableDeviceValues* ppAttributes);
    ///The <b>Cancel</b> method cancels a pending request on this interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Cancel();
    ///The <b>GetSupportedEvents</b> method retrieves the supported events for this device.
    ///Params:
    ///    ppEvents = Address of a variable that receives a pointer to an IPortableDevicePropVariantCollection interface that lists
    ///               the supported events. The caller must release this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the arguments was a <b>NULL</b>
    ///    pointer. </td> </tr> </table>
    ///    
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
    ///The <b>GetEventOptions</b> method retrieves all the supported options for the specified event on the device.
    ///Params:
    ///    Event = A <b>REFGUID</b> that specifies a event to query for supported options. For a list of the events that are
    ///            defined by Windows Portable Devices, see Events.
    ///    ppOptions = Address of a variable that receives a pointer to an IPortableDeviceValues interface that contains the
    ///                supported options. If no options are supported, this will not contain any values. The caller must release
    ///                this interface when it is done with it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the arguments was a <b>NULL</b>
    ///    pointer. </td> </tr> </table>
    ///    
    HRESULT GetEventOptions(const(GUID)* Event, IPortableDeviceValues* ppOptions);
}

///The <b>IPortableDeviceEventCallback</b> interface implemented by the application to receive asynchronous callbacks if
///an application has registered to receive them by calling IPortableDevice::Advise.
@GUID("A8792A31-F385-493C-A893-40F64EB45F6E")
interface IPortableDeviceEventCallback : IUnknown
{
    ///The <b>OnEvent</b> method is called by the SDK to notify the application about asynchronous events.
    ///Params:
    ///    pEventParameters = Pointer to an IPortableDeviceValues interface that contains event details.
    ///Returns:
    ///    Any values returned by the application are ignored by Windows Portable Devices.
    ///    
    HRESULT OnEvent(IPortableDeviceValues pEventParameters);
}

///The <b>IPortableDeviceDataStream</b> interface exposes additional methods on an <b>IStream</b> that is used for data
///transfers. It is obtained by calling <b>QueryInterface</b> on the <b>IStream</b> that is retrieved by
///IPortableDeviceResources::GetStream or IPortableDeviceContent::CreateObjectWithPropertiesAndData.
@GUID("88E04DB3-1012-4D64-9996-F703A950D3F4")
interface IPortableDeviceDataStream : IStream
{
    ///The <b>GetObjectID</b> method retrieves the object ID of the resource that was written to the device. This method
    ///is only valid after calling <b>IStream::Commit</b> on the data stream.
    ///Params:
    ///    ppszObjectID = The ID of the object just transferred to the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the required arguments was a
    ///    <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory is available. </td> </tr> </table>
    ///    
    HRESULT GetObjectID(PWSTR* ppszObjectID);
    ///The <b>Cancel</b> method cancels a call in progress on this interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Cancel();
}

///The <b>IPortableDeviceUnitsStream</b> interface provides a way to operate, or seek, on a stream by using alternate
///units, such as frames or milliseconds.
@GUID("5E98025F-BFC4-47A2-9A5F-BC900A507C67")
interface IPortableDeviceUnitsStream : IUnknown
{
    ///The <b>SeekInUnits</b> method performs a seek on a stream, based on alternate units.
    ///Params:
    ///    dlibMove = The displacement to add to the location indicated by the <i>dwOrigin</i> parameter. The units for the
    ///               displacement are specified by <i>units</i>. If <i>dwOrigin</i> is STREAM_SEEK_SET, this is interpreted as an
    ///               unsigned value rather than a signed value.
    ///    units = The units of the <i>dlibMove</i> and <i>plibNewPosition</i> parameters. See WPD_STREAM_UNITS for more
    ///            details.
    ///    dwOrigin = The origin for the displacement specified in <i>dlibMove</i>. The origin can be the beginning of the file
    ///               (STREAM_SEEK_SET), the current seek pointer (STREAM_SEEK_CUR), or the end of the file (STREAM_SEEK_END). For
    ///               more information about values, see the STREAM_SEEK enumeration.
    ///    plibNewPosition = A pointer to the location where this method writes the value of the new seek pointer from the beginning of
    ///                      the stream. The units are given by units. You can set this pointer to NULL. In this case, this method does
    ///                      not provide the new seek pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The seek pointer was successfully adjusted. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>STG_E_INVALIDPOINTER</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///    the [out] parameter <i>plibNewPosition</i> points to invalid memory, because <i>plibNewPosition</i> is not
    ///    read. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_INVALIDFUNCTION</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>dwUnits</i> or <i>dwOrigin</i> parameter contains an invalid value, or the
    ///    <i>dlibMove</i> parameter contains a bad offset value. For example, the result of the seek pointer is a
    ///    negative offset value. </td> </tr> </table>
    ///    
    HRESULT SeekInUnits(LARGE_INTEGER dlibMove, WPD_STREAM_UNITS units, uint dwOrigin, 
                        ULARGE_INTEGER* plibNewPosition);
    HRESULT Cancel();
}

///The <b>IPortableDevicePropertiesBulk</b> interface queries or sets multiple properties on multiple objects on a
///device, asynchronously. Information is returned by an application-implemented IPortableDevicePropertiesBulkCallback
///interface. To get this interface, call <b>QueryInterface</b> on <b>IPortableDeviceProperties</b>. If the device does
///not support bulk operations, this call will fail with E_NOINTERFACE.
@GUID("482B05C0-4056-44ED-9E0F-5E23B009DA93")
interface IPortableDevicePropertiesBulk : IUnknown
{
    ///The <b>QueueGetValuesByObjectList</b> method queues a request for one or more specified properties from one or
    ///more specified objects on the device.
    ///Params:
    ///    pObjectIDs = Pointer to an IPortableDevicePropVariantCollection interface that lists the object IDs of all the objects to
    ///                 query. These will be of type VT_LPWSTR.
    ///    pKeys = Pointer to an IPortableDeviceKeyCollection interface that specifies the properties to request. For a list of
    ///            properties defined by Windows Portable Devices, see Properties and Attributes. Specify <b>NULL</b> to
    ///            indicate all properties from the specified objects.
    ///    pCallback = Pointer to an application-implemented IPortableDevicePropertiesBulkCallback interface that will receive the
    ///                information as it is retrieved.
    ///    pContext = Pointer to a GUID that is used to start, cancel, or identify the request
    ///               <b>IPortableDevicePropertiesBulkCallback</b> callbacks, if implemented.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT QueueGetValuesByObjectList(IPortableDevicePropVariantCollection pObjectIDs, 
                                       IPortableDeviceKeyCollection pKeys, 
                                       IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
    ///The <b>QueueGetValuesByObjectFormat</b> interface queues a request for properties of objects of a specific format
    ///on a device.
    ///Params:
    ///    pguidObjectFormat = Pointer to a <b>GUID</b> that specifies the object format. Only objects of this type are queried.
    ///    pszParentObjectID = Pointer to a null-terminated string that contains the object ID of the parent object where the search should
    ///                        begin. To search all the objects on a device, specify <b>WPD_DEVICE_OBJECT_ID</b>.
    ///    dwDepth = The maximum depth to search below the parent, where 1 means immediate children only. It is acceptable for
    ///              this number to be greater than the actual number of levels. To search to any depth, specify 0xFFFFFFFF
    ///    pKeys = Pointer to an <b>IPortableDeviceKeyCollection</b> interface that contains the properties to retrieve. For a
    ///            list of properties that are defined by Windows Portable Devices, see Properties and Attributes. Specify
    ///            <b>NULL</b> to indicate all properties from the specified format.
    ///    pCallback = Pointer to an application-implemented IPortableDevicePropertiesBulkCallback interface that will receive the
    ///                information as it is retrieved.
    ///    pContext = Pointer to a GUID that will be used to start, cancel, or identify the request in
    ///               <b>IPortableDevicePropertiesBulkCallback</b> callbacks, if implemented.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was queued successfully. </td> </tr> </table>
    ///    
    HRESULT QueueGetValuesByObjectFormat(const(GUID)* pguidObjectFormat, const(PWSTR) pszParentObjectID, 
                                         const(uint) dwDepth, IPortableDeviceKeyCollection pKeys, 
                                         IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
    ///The <b>QueueSetValuesByObjectList</b> method queues a request to set one or more specified values on one or more
    ///specified objects on the device.
    ///Params:
    ///    pObjectValues = Pointer to an IPortableDeviceValuesCollection interface that contains the properties and values to set on
    ///                    specified objects. This interface holds one or more IPortableDeviceValues interfaces, each representing a
    ///                    single object. Each <b>IPortableDeviceValues</b> interface holds a collection of key/value pairs, where the
    ///                    key is the <b>PROPERTYKEY</b> identifying the property, and the value is a data type that varies by property.
    ///                    Each <b>IPortableDeviceValues</b> interface also holds one WPD_OBJECT_ID property that identifies the object
    ///                    to which this interface refers.
    ///    pCallback = Pointer to an application-implemented IPortableDevicePropertiesBulkCallback interface that will receive the
    ///                information as it is retrieved.
    ///    pContext = Pointer to a GUID that is used to start, cancel, or identify the request to any client-implemented
    ///               <b>IPortableDevicePropertiesBulkCallback</b> callbacks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was queued successfully. </td> </tr> </table>
    ///    
    HRESULT QueueSetValuesByObjectList(IPortableDeviceValuesCollection pObjectValues, 
                                       IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
    ///The <b>Start</b> method starts a queued operation.
    ///Params:
    ///    pContext = A pointer to a GUID that identifies the operation to start. This value is generated by a <b>Queue...</b>
    ///               method of this interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The GUID passed to
    ///    <i>pContext</i> does not match a queued operation. </td> </tr> </table>
    ///    
    HRESULT Start(const(GUID)* pContext);
    ///The <b>Cancel</b> method cancels a pending properties request.
    ///Params:
    ///    pContext = Pointer to a context GUID that was retrieved when an asynchronous request was started by calling one of the
    ///               <b>Queue...</b> methods.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Cancel(const(GUID)* pContext);
}

///The <b>IPortableDevicePropertiesBulkCallback</b> interface is implemented by the application to track the progress of
///an asynchronous operation that was begun by using the IPortableDevicePropertiesBulk interface. After the application
///calls IPortableDevicePropertiesBulk::Start, Windows Portable Devices calls
///<b>IPortableDevicePropertiesBulkCallback::OnStart</b> first, and then repeatedly calls
///<b>IPortableDevicePropertiesBulkCallback::OnProgress</b> with information until the operation is completed or the
///application calls IPortableDevicePropertiesBulk::Cancel or returns an error value for <b>OnProgress</b>. Finally,
///regardless of whether the operation completed successfully, Windows Portable Devices calls
///<b>IPortableDevicePropertiesBulkCallback::OnEnd</b>.
@GUID("9DEACB80-11E8-40E3-A9F3-F557986A7845")
interface IPortableDevicePropertiesBulkCallback : IUnknown
{
    ///The <b>OnStart</b> method is called by the SDK when a bulk operation started by
    ///IPortableDevicePropertiesBulk::Start is about to begin.
    ///Params:
    ///    pContext = Pointer to a GUID that identifies which operation has started. This value is produced by a <b>Queue</b>...
    ///               method of the IPortableDevicePropertiesBulk interface.
    ///Returns:
    ///    The application should return either S_OK or an error code to abandon the operation. The application should
    ///    handle all error codes in the same manner.
    ///    
    HRESULT OnStart(const(GUID)* pContext);
    ///The <b>OnProgress</b> method is called by the SDK when a bulk operation started by
    ///IPortableDevicePropertiesBulk::Start has sent data to the device and received some information back.
    ///Params:
    ///    pContext = Pointer to a GUID that identifies which operation is in progress. This value is produced by a <b>Queue</b>...
    ///               method of the IPortableDevicePropertiesBulk interface.
    ///    pResults = Pointer to an IPortableDeviceValuesCollection interface that contains the results retrieved from the device.
    ///               This interface will hold one or more IPortableDeviceValues interfaces. Each of these interfaces will hold one
    ///               WPD_OBJECT_ID property with a string value (VT_LPSTR) specifying the object ID of the object that these
    ///               values pertain to. The rest of the values in each <b>IPortableDeviceValues</b> interface vary, depending on
    ///               the bulk operation being reported. For the <b>QueueGetValuesByObjectFormat</b> and
    ///               <b>QueueGetValuesByObjectList</b> methods, they will be retrieved values of varying types. For
    ///               QueueSetValuesByObjectList, they will be <b>VT_ERROR</b><b>HRESULT</b> values for any errors encountered when
    ///               setting values.
    ///Returns:
    ///    The application should return either S_OK, or an error code to abandon the operation. All error codes are
    ///    handled the same way.
    ///    
    HRESULT OnProgress(const(GUID)* pContext, IPortableDeviceValuesCollection pResults);
    ///The <b>OnEnd</b> method is called by the SDK when a bulk operation that is started by
    ///IPortableDevicePropertiesBulk::Start is completed.
    ///Params:
    ///    pContext = Pointer to a GUID that identifies which operation has finished. This value is produced by a <b>Queue</b>...
    ///               method of the IPortableDevicePropertiesBulk interface.
    ///    hrStatus = Contains any errors returned by the driver after the bulk operation has completed.
    ///Returns:
    ///    The method's return value is ignored.
    ///    
    HRESULT OnEnd(const(GUID)* pContext, HRESULT hrStatus);
}

///The <b>IPortableDeviceServiceManager</b> interface retrieves the device associated with a service and the list of
///services found on a device.
@GUID("A8ABC4E9-A84A-47A9-80B3-C5D9B172A961")
interface IPortableDeviceServiceManager : IUnknown
{
    ///The <b>GetDeviceServices</b> method retrieves a list of the services associated with the specified device.
    ///Params:
    ///    pszPnPDeviceID = The Plug and Play (PnP) identifier of the device.
    ///    guidServiceCategory = A reference to a globally unique identifier (GUID) that specifies the category of services to retrieve. If
    ///                          the referenced identifier is GUID_DEVINTERFACE_WPD_SERVICE, this method will retrieve all services supported
    ///                          by the device.
    ///    pServices = A user-allocated array of pointers to strings. When the method returns, the array contains the retrieved PnP
    ///                service identifiers.
    ///    pcServices = The number of elements in the array specified by the <i>pServices</i> parameter. This value represents the
    ///                 maximum number of service identifiers that will be retrieved. When the method returns, this parameter
    ///                 contains the number of identifiers actually retrieved.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The array referenced by the <i>pServices</i>
    ///    parameter was too small to contain all of the services. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pcServices</i> parameter was <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDeviceServices(const(PWSTR) pszPnPDeviceID, const(GUID)* guidServiceCategory, PWSTR* pServices, 
                              uint* pcServices);
    ///The <b>GetDeviceForService</b> method retrieves the device associated with the specified service.
    ///Params:
    ///    pszPnPServiceID = The Plug and Play (PnP) identifier of the service.
    ///    ppszPnPDeviceID = The retrieved PnP identifier of the device associated with the service.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> An invalid pointer was supplied. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDeviceForService(const(PWSTR) pszPnPServiceID, PWSTR* ppszPnPDeviceID);
}

///The <b>IPortableDeviceService</b> interface provides access to a service.
@GUID("D3BD3A44-D7B5-40A9-98B7-2FA4D01DEC08")
interface IPortableDeviceService : IUnknown
{
    ///The <b>Open</b> method opens a connection to the service.
    ///Params:
    ///    pszPnPServiceID = The Plug and Play (PnP) identifier for the service, which is the same identifier that is retrieved by the
    ///                      GetPnPServiceId method.
    ///    pClientInfo = The IPortableDeviceValues interface specifying the client information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PnP identifier specified by the
    ///    <i>pszPnPServiceID</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> A <b>NULL</b> parameter was specified. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_WPD_SERVICE_ALREADY_OPENED</b></dt> </dl> </td> <td width="60%"> This method has already been called
    ///    for the service. </td> </tr> </table>
    ///    
    HRESULT Open(const(PWSTR) pszPnPServiceID, IPortableDeviceValues pClientInfo);
    ///The <b>Capabilities</b> method retrieves the service capabilities.
    ///Params:
    ///    ppCapabilities = The IPortableDeviceServiceCapabilities interface specifying the capabilities of the service.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> parameter was specified. </td>
    ///    </tr> </table>
    ///    
    HRESULT Capabilities(IPortableDeviceServiceCapabilities* ppCapabilities);
    ///The <b>Content</b> method retrieves access to the service content.
    ///Params:
    ///    ppContent = The IPortableDeviceContent2 interface that accesses the service content.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> parameter was specified. </td>
    ///    </tr> </table>
    ///    
    HRESULT Content(IPortableDeviceContent2* ppContent);
    ///The <b>Methods</b> method retrieves the IPortableDeviceServiceMethods interface that is used to invoke custom
    ///functionality on the service.
    ///Params:
    ///    ppMethods = The IPortableDeviceServiceMethods interface used for invoking methods on the given service.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> parameter was specified. </td>
    ///    </tr> </table>
    ///    
    HRESULT Methods(IPortableDeviceServiceMethods* ppMethods);
    ///The <b>Cancel</b> method cancels a pending operation on this interface.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT Cancel();
    ///The <b>Close</b> method releases the connection to the service.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT Close();
    ///The <b>GetServiceObjectID</b> method retrieves an object identifier for the service. This object identifier can
    ///be used to access the properties of the service, for example.
    ///Params:
    ///    ppszServiceObjectID = The retrieved service object identifier.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetServiceObjectID(PWSTR* ppszServiceObjectID);
    ///The <b>GetPnPServiceID</b> method retrieves a Plug and Play (PnP) identifier for the service.
    ///Params:
    ///    ppszPnPServiceID = The retrieved PnP identifier, which is the same identifier that was passed to the Open method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> parameter was specified. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_WPD_SERVICE_NOT_OPEN</b></dt> </dl> </td> <td width="60%"> The Open
    ///    method has not yet been called for the service. </td> </tr> </table>
    ///    
    HRESULT GetPnPServiceID(PWSTR* ppszPnPServiceID);
    ///The <b>Advise</b> method registers an application-defined callback object that receives service events.
    ///Params:
    ///    dwFlags = Not used.
    ///    pCallback = The IPortableDeviceEventCallback interface specifying the callback object to register.
    ///    pParameters = The IPortableDeviceValues interface specifying the event-registration parameters, or <b>NULL</b> if the
    ///                  callback object is to receive all service events.
    ///    ppszCookie = The unique context ID for the callback object. This value matches that used by the Unadvise method to
    ///                 unregister the callback object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> value was specified for the
    ///    <i>pCallback</i> parameter or the <i>ppszCookie</i> parameter. </td> </tr> </table>
    ///    
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, 
                   PWSTR* ppszCookie);
    ///The <b>Unadvise</b> method unregisters a service event callback object.
    ///Params:
    ///    pszCookie = The unique context ID for the application-supplied callback object. This value matches that yielded by the
    ///                <i>ppszCookie</i> parameter of the Advise method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> parameter was specified. </td>
    ///    </tr> </table>
    ///    
    HRESULT Unadvise(const(PWSTR) pszCookie);
    ///The <b>SendCommand</b> method sends a standard WPD command and its parameters to the service.
    ///Params:
    ///    dwFlags = Not used.
    ///    pParameters = The IPortableDeviceValues interface specifying the command parameters.
    ///    ppResults = The IPortableDeviceValues interface specifying the command results.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
}

///The <b>IPortableDeviceServiceCapabilities</b> interface retrieves information describing the capabilities of a
///service.
@GUID("24DBD89D-413E-43E0-BD5B-197F3C56C886")
interface IPortableDeviceServiceCapabilities : IUnknown
{
    ///The <b>GetSupportedMethods</b> method retrieves the methods supported by the service.
    ///Params:
    ///    ppMethods = The IPortableDevicePropVariantCollection interface that receives the list of methods.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetSupportedMethods(IPortableDevicePropVariantCollection* ppMethods);
    ///The <b>GetSupportedMethodsByFormat</b> method retrieves the methods supported by the service for the specified
    ///format.
    ///Params:
    ///    Format = The format whose supported methods are retrieved.
    ///    ppMethods = The IPortableDevicePropVariantCollection interface that receives the list of methods.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetSupportedMethodsByFormat(const(GUID)* Format, IPortableDevicePropVariantCollection* ppMethods);
    ///The <b>GetMethodAttributes</b> method retrieves the attributes used to describe a given method.
    ///Params:
    ///    Method = The method whose attributes are retrieved.
    ///    ppAttributes = The IPortableDeviceValues interface that receives the list of attributes.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetMethodAttributes(const(GUID)* Method, IPortableDeviceValues* ppAttributes);
    ///The <b>GetMethodParameterAttributes</b> method retrieves the attributes used to describe a given method
    ///parameter.
    ///Params:
    ///    Method = The method that contains the parameter whose attributes are retrieved.
    ///    ppAttributes = The IPortableDeviceValues interface that receives the list of attributes.
    ///    Parameter = The parameter whose attributes are retrieved.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetMethodParameterAttributes(const(GUID)* Method, const(PROPERTYKEY)* Parameter, 
                                         IPortableDeviceValues* ppAttributes);
    ///The <b>GetSupportedFormats</b> method retrieves the formats supported by the service.
    ///Params:
    ///    ppFormats = The IPortableDevicePropVariantCollection interface that receives the list of formats.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetSupportedFormats(IPortableDevicePropVariantCollection* ppFormats);
    ///The <b>GetFormatAttributes</b> method retrieves the attributes of a format.
    ///Params:
    ///    Format = The format whose attributes are retrieved.
    ///    ppAttributes = The IPortableDeviceValues interface that receives the list of attributes.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetFormatAttributes(const(GUID)* Format, IPortableDeviceValues* ppAttributes);
    ///The <b>GetSupportedFormatProperties</b> method retrieves the properties supported by the service for the
    ///specified format.
    ///Params:
    ///    Format = The format whose properties are retrieved.
    ///    ppKeys = The IPortableDeviceKeyCollection interface that receives the list of properties.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetSupportedFormatProperties(const(GUID)* Format, IPortableDeviceKeyCollection* ppKeys);
    ///The <b>GetFormatPropertyAttributes</b> method retrieves the attributes of a format property.
    ///Params:
    ///    Format = The format whose property has its attributes retrieved.
    ///    Property = The property whose attributes are retrieved.
    ///    ppAttributes = The IPortableDeviceValues interface that receives the list of attributes.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetFormatPropertyAttributes(const(GUID)* Format, const(PROPERTYKEY)* Property, 
                                        IPortableDeviceValues* ppAttributes);
    ///The <b>GetSupportedEvents</b> method retrieves the events supported by the service.
    ///Params:
    ///    ppEvents = The IPortableDevicePropVariantCollection interface that receives the list of events.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
    ///The <b>GetEventAttributes</b> method retrieves the attributes of an event.
    ///Params:
    ///    Event = The event whose attributes are retrieved.
    ///    ppAttributes = The IPortableDeviceValues interface that receives the list of attributes.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetEventAttributes(const(GUID)* Event, IPortableDeviceValues* ppAttributes);
    ///The <b>GetEventParameterAttributes</b> method retrieves the attributes of an event parameter.
    ///Params:
    ///    Event = The event that contains the parameter whose attributes are retrieved.
    ///    ppAttributes = The IPortableDeviceValues interface that receives the list of attributes.
    ///    Parameter = The parameter whose attributes are retrieved.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetEventParameterAttributes(const(GUID)* Event, const(PROPERTYKEY)* Parameter, 
                                        IPortableDeviceValues* ppAttributes);
    ///The <b>GetInheritedServices</b> method retrieves the services having the specified inheritance type.
    ///Params:
    ///    dwInheritanceType = The type of inherited services to retrieve.
    ///    ppServices = The IPortableDevicePropVariantCollection interface that receives the list of services. If no inherited
    ///                 services are found, an empty collection is returned.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetInheritedServices(const(uint) dwInheritanceType, IPortableDevicePropVariantCollection* ppServices);
    ///The <b>GetFormatRenderingProfiles</b> method retrieves the rendering profiles of a format.
    ///Params:
    ///    Format = The format whose rendering profiles are retrieved.
    ///    ppRenderingProfiles = The IPortableDeviceValuesCollection object that receives the list of rendering profiles.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetFormatRenderingProfiles(const(GUID)* Format, IPortableDeviceValuesCollection* ppRenderingProfiles);
    ///The <b>GetSupportedCommands</b> method retrieves the commands supported by the service.
    ///Params:
    ///    ppCommands = The IPortableDeviceKeyCollection interface that receives the list of commands.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
    ///The <b>GetCommandOptions</b> method retrieves the options of a WPD command.
    ///Params:
    ///    Command = The command whose options are retrieved.
    ///    ppOptions = The IPortableDeviceValues interface that receives the list of options.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
    ///The <b>Cancel</b> method cancels a pending operation.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT Cancel();
}

///The <b>IPortableDeviceServiceMethods</b> interface invokes, or cancels invocation of, a method on a service.
@GUID("E20333C9-FD34-412D-A381-CC6F2D820DF7")
interface IPortableDeviceServiceMethods : IUnknown
{
    ///The <b>Invoke</b> method synchronously invokes a method.
    ///Params:
    ///    Method = The method to invoke.
    ///    pParameters = A pointer to an IPortableDeviceValues interface that contains the parameters of the invoked method, or
    ///                  <b>NULL</b> to indicate that the method has no parameters.
    ///    ppResults = The address of a pointer to an IPortableDeviceValues interface that receives the method results, or
    ///                <b>NULL</b> to ignore the method results.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT Invoke(const(GUID)* Method, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
    ///The <b>InvokeAsync</b> method asynchronously invokes a method.
    ///Params:
    ///    Method = The method to invoke.
    ///    pParameters = A pointer to an IPortableDeviceValues interface that contains the parameters of the invoked method, or
    ///                  <b>NULL</b> to indicate that the method has no parameters.
    ///    pCallback = A pointer to an application-supplied IPortableDeviceServiceMethodCallback callback object that receives the
    ///                method results, or <b>NULL</b> to ignore the method results.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT InvokeAsync(const(GUID)* Method, IPortableDeviceValues pParameters, 
                        IPortableDeviceServiceMethodCallback pCallback);
    ///The <b>Cancel</b> method cancels a pending method invocation.
    ///Params:
    ///    pCallback = A pointer to the callback object whose method invocation is to be canceled, or <b>NULL</b> to cancel all
    ///                pending method invocations.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT Cancel(IPortableDeviceServiceMethodCallback pCallback);
}

///The <b>IPortableDeviceServiceMethodCallback</b> interface contains a method that applications use to track the
///completion of a callback method. Applications that call service methods asynchronously may implement this interface,
///and supply it as a parameter to IPortableDeviceServiceMethods::InvokeAsync. Each asynchronous method invocation uses
///the application-supplied callback object as its context. Therefore, an application that intends to simultaneously
///invoke multiple methods should avoid reusing the callback object. Instead, the application should provide a unique
///instance of the callback object for each call to <b>InvokeAsync</b>
@GUID("C424233C-AFCE-4828-A756-7ED7A2350083")
interface IPortableDeviceServiceMethodCallback : IUnknown
{
    ///The <b>OnComplete</b> method indicates that a callback method has completed execution.
    ///Params:
    ///    hrStatus = The overall status of the method.
    ///    pResults = An IPortableDeviceValues interface that contains the method-execution results. This is empty if the method
    ///               returns no results.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Any other <b>HRESULT</b> value indicates that the call
    ///    failed.
    ///    
    HRESULT OnComplete(HRESULT hrStatus, IPortableDeviceValues pResults);
}

@GUID("E56B0534-D9B9-425C-9B99-75F97CB3D7C8")
interface IPortableDeviceServiceActivation : IUnknown
{
    HRESULT OpenAsync(const(PWSTR) pszPnPServiceID, IPortableDeviceValues pClientInfo, 
                      IPortableDeviceServiceOpenCallback pCallback);
    HRESULT CancelOpenAsync();
}

@GUID("BCED49C8-8EFE-41ED-960B-61313ABD47A9")
interface IPortableDeviceServiceOpenCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus);
}

///Represents a factory that can instantiate a WPD Automation Device object.
@GUID("5E1EAFC3-E3D7-4132-96FA-759C0F9D1E0F")
interface IPortableDeviceDispatchFactory : IUnknown
{
    ///Instantiates a WPD Automation Device object for a given WPD device identifier.
    ///Params:
    ///    pszPnPDeviceID = A pointer to a <b>String</b> that is used by Plug-and-play to identify a currently connected WPD device. The
    ///                     Plug and Play (PnP) identifier for a particular device can be obtained from the
    ///                     IPortableDeviceManager::GetDevices method in the WPD C++/COM API.
    ///    ppDeviceDispatch = Contains a pointer to the <b>IDispatch</b> implementation for the WPD Automation Device object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetDeviceDispatch(const(PWSTR) pszPnPDeviceID, IDispatch* ppDeviceDispatch);
}

///Represents a factory that can instantiate a WPD Automation Device object in a Windows Store app.
@GUID("94FC7953-5CA1-483A-8AEE-DF52E7747D00")
interface IPortableDeviceWebControl : IDispatch
{
    ///Instantiates a WPD Automation Device object for a given WPD device identifier.
    ///Params:
    ///    deviceId = A <b>BSTR</b> that is used by Plug-and-play to identify a currently connected WPD device. The Plug and Play
    ///               (PnP) identifier for a particular device can be obtained from the IPortableDeviceManager::GetDevices method
    ///               in the WPD C++/COM API. A Windows Store app can obtain the PnP identifier of a WPD device by using
    ///               Windows.Devices.Portable.ServiceDevice.GetDeviceSelector or
    ///               Windows.Devices.Portable.ServiceDevice.GetDeviceSelectorFromServiceId to get a selector string to pass to
    ///               Windows.Devices.Enumeration.DeviceInformation.FindAllAsync. FindAllAsync returns a collection of
    ///               DeviceInformation objects that represent the currently connected WPD devices. A <b>DeviceInformation</b>
    ///               object's Id property is the device's PnP identifier.
    ///    ppDevice = Contains a pointer to the <b>IDispatch</b> implementation for the WPD Automation Device object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> A call to this method outside of a Windows Store
    ///    app running on Windows 8 will return this error code. </td> </tr> </table>
    ///    
    HRESULT GetDeviceFromId(BSTR deviceId, IDispatch* ppDevice);
    ///Instantiates a WPD Automation Device object asynchronously for a given WPD device identifier.
    ///Params:
    ///    deviceId = A <b>BSTR</b> that is used by Plug-and-play to identify a currently connected WPD device. The Plug and Play
    ///               (PnP) identifier for a particular device can be obtained from the IPortableDeviceManager::GetDevices method
    ///               in the WPD C++/COM API. A Windows Store app can obtain the PnP identifier of a WPD device by using
    ///               Windows.Devices.Portable.ServiceDevice.GetDeviceSelector or
    ///               Windows.Devices.Portable.ServiceDevice.GetDeviceSelectorFromServiceId to get a selector string to pass to
    ///               Windows.Devices.Enumeration.DeviceInformation.FindAllAsync. FindAllAsync returns a collection of
    ///               DeviceInformation objects that represent the currently connected WPD devices. A <b>DeviceInformation</b>
    ///               object's Id property is the device's PnP identifier.
    ///    pCompletionHandler = A completion handler.
    ///    pErrorHandler = An error handler.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> A call to this method outside of a Windows Store
    ///    app running on Windows 8 will return this error code. </td> </tr> </table>
    ///    
    HRESULT GetDeviceFromIdAsync(BSTR deviceId, IDispatch pCompletionHandler, IDispatch pErrorHandler);
}

@GUID("BFDEF549-9247-454F-BD82-06FE80853FAA")
interface IEnumPortableDeviceConnectors : IUnknown
{
    HRESULT Next(uint cRequested, IPortableDeviceConnector* pConnectors, uint* pcFetched);
    HRESULT Skip(uint cConnectors);
    HRESULT Reset();
    HRESULT Clone(IEnumPortableDeviceConnectors* ppEnum);
}

///The <b>IPortableDeviceConnector</b> interface defines methods used for connection-management and property-retrieval
///for a paired MTP/Bluetooth device.
@GUID("625E2DF8-6392-4CF0-9AD1-3CFA5F17775C")
interface IPortableDeviceConnector : IUnknown
{
    ///The <b>Connect</b> method sends an asynchronous connection request to the MTP/Bluetooth device.
    ///Params:
    ///    pCallback = A pointer to a IConnectionRequestCallback interface if the application wishes to be notified when the request
    ///                is complete; otherwise, <b>NULL</b>. If multiple requests are being sent simultaneously using the same
    ///                IPortableDeviceConnector object, a different instance of the callback object must be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Connect(IConnectionRequestCallback pCallback);
    ///The <b>Disconnect</b> method sends an asynchronous disconnect request to the MTP/Bluetooth device.
    ///Params:
    ///    pCallback = A pointer to an IConnectionRequestCallback interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Disconnect(IConnectionRequestCallback pCallback);
    ///The <b>Cancel</b> method cancels a pending request to connect or disconnect an MTP/Bluetooth device. The callback
    ///object is used to identify the request. This method returns immediately, and the request will be cancelled
    ///asynchronously.
    ///Params:
    ///    pCallback = A pointer to an IConnectionRequestCallback interface. This value cannot be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Either the
    ///    <i>pCallback</i> parameter does not correspond to a pending connect or disconnect request, or this method has
    ///    been already been called. </td> </tr> </table>
    ///    
    HRESULT Cancel(IConnectionRequestCallback pCallback);
    ///The <b>GetProperty</b> method retrieves a property for the given MTP/Bluetooth Bus Enumerator device.
    ///Params:
    ///    pPropertyKey = A pointer to a property key for the requested property.
    ///    pPropertyType = A pointer to a property type.
    ///    ppData = The address of a pointer to the property data.
    ///    pcbData = A pointer to the size (in bytes) of the property data.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The specified property
    ///    key is not supported. </td> </tr> </table>
    ///    
    HRESULT GetProperty(const(DEVPROPKEY)* pPropertyKey, uint* pPropertyType, ubyte** ppData, uint* pcbData);
    ///The <b>SetProperty</b> method sets the given property on the MTP/Bluetooth Bus Enumerator device.
    ///Params:
    ///    pPropertyKey = A pointer to a property key for the given property.
    ///    PropertyType = The property type.
    ///    pData = A pointer to the property data.
    ///    cbData = The size (in bytes) of the property data.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The specified property
    ///    key is not supported. </td> </tr> </table>
    ///    
    HRESULT SetProperty(const(DEVPROPKEY)* pPropertyKey, uint PropertyType, const(ubyte)* pData, uint cbData);
    ///The <b>GetPnPID</b> method retrieves the connector's Plug and Play (PnP) device identifier.
    ///Params:
    ///    ppwszPnPID = The PnP device identifier.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetPnPID(PWSTR* ppwszPnPID);
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
