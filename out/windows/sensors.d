module windows.sensors;

public import system;
public import windows.automation;
public import windows.com;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsportabledevices;
public import windows.windowsprogramming;
public import windows.windowspropertiessystem;

extern(Windows):

const GUID CLSID_SensorManager = {0x77A1C827, 0xFCD2, 0x4689, [0x89, 0x15, 0x9D, 0x61, 0x3C, 0xC5, 0xFA, 0x3E]};
@GUID(0x77A1C827, 0xFCD2, 0x4689, [0x89, 0x15, 0x9D, 0x61, 0x3C, 0xC5, 0xFA, 0x3E]);
struct SensorManager;

const GUID CLSID_SensorCollection = {0x79C43ADB, 0xA429, 0x469F, [0xAA, 0x39, 0x2F, 0x2B, 0x74, 0xB7, 0x59, 0x37]};
@GUID(0x79C43ADB, 0xA429, 0x469F, [0xAA, 0x39, 0x2F, 0x2B, 0x74, 0xB7, 0x59, 0x37]);
struct SensorCollection;

const GUID CLSID_Sensor = {0xE97CED00, 0x523A, 0x4133, [0xBF, 0x6F, 0xD3, 0xA2, 0xDA, 0xE7, 0xF6, 0xBA]};
@GUID(0xE97CED00, 0x523A, 0x4133, [0xBF, 0x6F, 0xD3, 0xA2, 0xDA, 0xE7, 0xF6, 0xBA]);
struct Sensor;

const GUID CLSID_SensorDataReport = {0x4EA9D6EF, 0x694B, 0x4218, [0x88, 0x16, 0xCC, 0xDA, 0x8D, 0xA7, 0x4B, 0xBA]};
@GUID(0x4EA9D6EF, 0x694B, 0x4218, [0x88, 0x16, 0xCC, 0xDA, 0x8D, 0xA7, 0x4B, 0xBA]);
struct SensorDataReport;

enum SensorState
{
    SENSOR_STATE_MIN = 0,
    SENSOR_STATE_READY = 0,
    SENSOR_STATE_NOT_AVAILABLE = 1,
    SENSOR_STATE_NO_DATA = 2,
    SENSOR_STATE_INITIALIZING = 3,
    SENSOR_STATE_ACCESS_DENIED = 4,
    SENSOR_STATE_ERROR = 5,
    SENSOR_STATE_MAX = 5,
}

enum SensorConnectionType
{
    SENSOR_CONNECTION_TYPE_PC_INTEGRATED = 0,
    SENSOR_CONNECTION_TYPE_PC_ATTACHED = 1,
    SENSOR_CONNECTION_TYPE_PC_EXTERNAL = 2,
}

enum LOCATION_DESIRED_ACCURACY
{
    LOCATION_DESIRED_ACCURACY_DEFAULT = 0,
    LOCATION_DESIRED_ACCURACY_HIGH = 1,
}

enum LOCATION_POSITION_SOURCE
{
    LOCATION_POSITION_SOURCE_CELLULAR = 0,
    LOCATION_POSITION_SOURCE_SATELLITE = 1,
    LOCATION_POSITION_SOURCE_WIFI = 2,
    LOCATION_POSITION_SOURCE_IPADDRESS = 3,
    LOCATION_POSITION_SOURCE_UNKNOWN = 4,
}

enum SimpleDeviceOrientation
{
    SIMPLE_DEVICE_ORIENTATION_NOT_ROTATED = 0,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_90 = 1,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_180 = 2,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_270 = 3,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_UP = 4,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_DOWN = 5,
}

enum MagnetometerAccuracy
{
    MAGNETOMETER_ACCURACY_UNKNOWN = 0,
    MAGNETOMETER_ACCURACY_UNRELIABLE = 1,
    MAGNETOMETER_ACCURACY_APPROXIMATE = 2,
    MAGNETOMETER_ACCURACY_HIGH = 3,
}

const GUID IID_ISensorManager = {0xBD77DB67, 0x45A8, 0x42DC, [0x8D, 0x00, 0x6D, 0xCF, 0x15, 0xF8, 0x37, 0x7A]};
@GUID(0xBD77DB67, 0x45A8, 0x42DC, [0x8D, 0x00, 0x6D, 0xCF, 0x15, 0xF8, 0x37, 0x7A]);
interface ISensorManager : IUnknown
{
    HRESULT GetSensorsByCategory(Guid* sensorCategory, ISensorCollection* ppSensorsFound);
    HRESULT GetSensorsByType(Guid* sensorType, ISensorCollection* ppSensorsFound);
    HRESULT GetSensorByID(Guid* sensorID, ISensor* ppSensor);
    HRESULT SetEventSink(ISensorManagerEvents pEvents);
    HRESULT RequestPermissions(HWND hParent, ISensorCollection pSensors, BOOL fModal);
}

const GUID IID_ILocationPermissions = {0xD5FB0A7F, 0xE74E, 0x44F5, [0x8E, 0x02, 0x48, 0x06, 0x86, 0x3A, 0x27, 0x4F]};
@GUID(0xD5FB0A7F, 0xE74E, 0x44F5, [0x8E, 0x02, 0x48, 0x06, 0x86, 0x3A, 0x27, 0x4F]);
interface ILocationPermissions : IUnknown
{
    HRESULT GetGlobalLocationPermission(int* pfEnabled);
    HRESULT CheckLocationCapability(uint dwClientThreadId);
}

const GUID IID_ISensorCollection = {0x23571E11, 0xE545, 0x4DD8, [0xA3, 0x37, 0xB8, 0x9B, 0xF4, 0x4B, 0x10, 0xDF]};
@GUID(0x23571E11, 0xE545, 0x4DD8, [0xA3, 0x37, 0xB8, 0x9B, 0xF4, 0x4B, 0x10, 0xDF]);
interface ISensorCollection : IUnknown
{
    HRESULT GetAt(uint ulIndex, ISensor* ppSensor);
    HRESULT GetCount(uint* pCount);
    HRESULT Add(ISensor pSensor);
    HRESULT Remove(ISensor pSensor);
    HRESULT RemoveByID(Guid* sensorID);
    HRESULT Clear();
}

const GUID IID_ISensor = {0x5FA08F80, 0x2657, 0x458E, [0xAF, 0x75, 0x46, 0xF7, 0x3F, 0xA6, 0xAC, 0x5C]};
@GUID(0x5FA08F80, 0x2657, 0x458E, [0xAF, 0x75, 0x46, 0xF7, 0x3F, 0xA6, 0xAC, 0x5C]);
interface ISensor : IUnknown
{
    HRESULT GetID(Guid* pID);
    HRESULT GetCategory(Guid* pSensorCategory);
    HRESULT GetType(Guid* pSensorType);
    HRESULT GetFriendlyName(BSTR* pFriendlyName);
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* pProperty);
    HRESULT GetProperties(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppProperties);
    HRESULT GetSupportedDataFields(IPortableDeviceKeyCollection* ppDataFields);
    HRESULT SetProperties(IPortableDeviceValues pProperties, IPortableDeviceValues* ppResults);
    HRESULT SupportsDataField(const(PROPERTYKEY)* key, short* pIsSupported);
    HRESULT GetState(SensorState* pState);
    HRESULT GetData(ISensorDataReport* ppDataReport);
    HRESULT SupportsEvent(const(Guid)* eventGuid, short* pIsSupported);
    HRESULT GetEventInterest(char* ppValues, uint* pCount);
    HRESULT SetEventInterest(char* pValues, uint count);
    HRESULT SetEventSink(ISensorEvents pEvents);
}

const GUID IID_ISensorDataReport = {0x0AB9DF9B, 0xC4B5, 0x4796, [0x88, 0x98, 0x04, 0x70, 0x70, 0x6A, 0x2E, 0x1D]};
@GUID(0x0AB9DF9B, 0xC4B5, 0x4796, [0x88, 0x98, 0x04, 0x70, 0x70, 0x6A, 0x2E, 0x1D]);
interface ISensorDataReport : IUnknown
{
    HRESULT GetTimestamp(SYSTEMTIME* pTimeStamp);
    HRESULT GetSensorValue(const(PROPERTYKEY)* pKey, PROPVARIANT* pValue);
    HRESULT GetSensorValues(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppValues);
}

const GUID IID_ISensorManagerEvents = {0x9B3B0B86, 0x266A, 0x4AAD, [0xB2, 0x1F, 0xFD, 0xE5, 0x50, 0x10, 0x01, 0xB7]};
@GUID(0x9B3B0B86, 0x266A, 0x4AAD, [0xB2, 0x1F, 0xFD, 0xE5, 0x50, 0x10, 0x01, 0xB7]);
interface ISensorManagerEvents : IUnknown
{
    HRESULT OnSensorEnter(ISensor pSensor, SensorState state);
}

const GUID IID_ISensorEvents = {0x5D8DCC91, 0x4641, 0x47E7, [0xB7, 0xC3, 0xB7, 0x4F, 0x48, 0xA6, 0xC3, 0x91]};
@GUID(0x5D8DCC91, 0x4641, 0x47E7, [0xB7, 0xC3, 0xB7, 0x4F, 0x48, 0xA6, 0xC3, 0x91]);
interface ISensorEvents : IUnknown
{
    HRESULT OnStateChanged(ISensor pSensor, SensorState state);
    HRESULT OnDataUpdated(ISensor pSensor, ISensorDataReport pNewData);
    HRESULT OnEvent(ISensor pSensor, const(Guid)* eventID, IPortableDeviceValues pEventData);
    HRESULT OnLeave(Guid* ID);
}

