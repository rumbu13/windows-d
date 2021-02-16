module windows.sensors;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsportabledevices : IPortableDeviceKeyCollection, IPortableDeviceValues;
public import windows.windowsprogramming : SYSTEMTIME;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows):


// Enums


enum SensorState : int
{
    SENSOR_STATE_MIN           = 0x00000000,
    SENSOR_STATE_READY         = 0x00000000,
    SENSOR_STATE_NOT_AVAILABLE = 0x00000001,
    SENSOR_STATE_NO_DATA       = 0x00000002,
    SENSOR_STATE_INITIALIZING  = 0x00000003,
    SENSOR_STATE_ACCESS_DENIED = 0x00000004,
    SENSOR_STATE_ERROR         = 0x00000005,
    SENSOR_STATE_MAX           = 0x00000005,
}

enum SensorConnectionType : int
{
    SENSOR_CONNECTION_TYPE_PC_INTEGRATED = 0x00000000,
    SENSOR_CONNECTION_TYPE_PC_ATTACHED   = 0x00000001,
    SENSOR_CONNECTION_TYPE_PC_EXTERNAL   = 0x00000002,
}

enum : int
{
    LOCATION_DESIRED_ACCURACY_DEFAULT = 0x00000000,
    LOCATION_DESIRED_ACCURACY_HIGH    = 0x00000001,
}
alias LOCATION_DESIRED_ACCURACY = int;

enum : int
{
    LOCATION_POSITION_SOURCE_CELLULAR  = 0x00000000,
    LOCATION_POSITION_SOURCE_SATELLITE = 0x00000001,
    LOCATION_POSITION_SOURCE_WIFI      = 0x00000002,
    LOCATION_POSITION_SOURCE_IPADDRESS = 0x00000003,
    LOCATION_POSITION_SOURCE_UNKNOWN   = 0x00000004,
}
alias LOCATION_POSITION_SOURCE = int;

enum SimpleDeviceOrientation : int
{
    SIMPLE_DEVICE_ORIENTATION_NOT_ROTATED       = 0x00000000,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_90        = 0x00000001,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_180       = 0x00000002,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_270       = 0x00000003,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_UP   = 0x00000004,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_DOWN = 0x00000005,
}

enum MagnetometerAccuracy : int
{
    MAGNETOMETER_ACCURACY_UNKNOWN     = 0x00000000,
    MAGNETOMETER_ACCURACY_UNRELIABLE  = 0x00000001,
    MAGNETOMETER_ACCURACY_APPROXIMATE = 0x00000002,
    MAGNETOMETER_ACCURACY_HIGH        = 0x00000003,
}

// Interfaces

@GUID("77A1C827-FCD2-4689-8915-9D613CC5FA3E")
struct SensorManager;

@GUID("79C43ADB-A429-469F-AA39-2F2B74B75937")
struct SensorCollection;

@GUID("E97CED00-523A-4133-BF6F-D3A2DAE7F6BA")
struct Sensor;

@GUID("4EA9D6EF-694B-4218-8816-CCDA8DA74BBA")
struct SensorDataReport;

@GUID("BD77DB67-45A8-42DC-8D00-6DCF15F8377A")
interface ISensorManager : IUnknown
{
    HRESULT GetSensorsByCategory(GUID* sensorCategory, ISensorCollection* ppSensorsFound);
    HRESULT GetSensorsByType(GUID* sensorType, ISensorCollection* ppSensorsFound);
    HRESULT GetSensorByID(GUID* sensorID, ISensor* ppSensor);
    HRESULT SetEventSink(ISensorManagerEvents pEvents);
    HRESULT RequestPermissions(HWND hParent, ISensorCollection pSensors, BOOL fModal);
}

@GUID("D5FB0A7F-E74E-44F5-8E02-4806863A274F")
interface ILocationPermissions : IUnknown
{
    HRESULT GetGlobalLocationPermission(int* pfEnabled);
    HRESULT CheckLocationCapability(uint dwClientThreadId);
}

@GUID("23571E11-E545-4DD8-A337-B89BF44B10DF")
interface ISensorCollection : IUnknown
{
    HRESULT GetAt(uint ulIndex, ISensor* ppSensor);
    HRESULT GetCount(uint* pCount);
    HRESULT Add(ISensor pSensor);
    HRESULT Remove(ISensor pSensor);
    HRESULT RemoveByID(GUID* sensorID);
    HRESULT Clear();
}

@GUID("5FA08F80-2657-458E-AF75-46F73FA6AC5C")
interface ISensor : IUnknown
{
    HRESULT GetID(GUID* pID);
    HRESULT GetCategory(GUID* pSensorCategory);
    HRESULT GetType(GUID* pSensorType);
    HRESULT GetFriendlyName(BSTR* pFriendlyName);
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* pProperty);
    HRESULT GetProperties(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppProperties);
    HRESULT GetSupportedDataFields(IPortableDeviceKeyCollection* ppDataFields);
    HRESULT SetProperties(IPortableDeviceValues pProperties, IPortableDeviceValues* ppResults);
    HRESULT SupportsDataField(const(PROPERTYKEY)* key, short* pIsSupported);
    HRESULT GetState(SensorState* pState);
    HRESULT GetData(ISensorDataReport* ppDataReport);
    HRESULT SupportsEvent(const(GUID)* eventGuid, short* pIsSupported);
    HRESULT GetEventInterest(char* ppValues, uint* pCount);
    HRESULT SetEventInterest(char* pValues, uint count);
    HRESULT SetEventSink(ISensorEvents pEvents);
}

@GUID("0AB9DF9B-C4B5-4796-8898-0470706A2E1D")
interface ISensorDataReport : IUnknown
{
    HRESULT GetTimestamp(SYSTEMTIME* pTimeStamp);
    HRESULT GetSensorValue(const(PROPERTYKEY)* pKey, PROPVARIANT* pValue);
    HRESULT GetSensorValues(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppValues);
}

@GUID("9B3B0B86-266A-4AAD-B21F-FDE5501001B7")
interface ISensorManagerEvents : IUnknown
{
    HRESULT OnSensorEnter(ISensor pSensor, SensorState state);
}

@GUID("5D8DCC91-4641-47E7-B7C3-B74F48A6C391")
interface ISensorEvents : IUnknown
{
    HRESULT OnStateChanged(ISensor pSensor, SensorState state);
    HRESULT OnDataUpdated(ISensor pSensor, ISensorDataReport pNewData);
    HRESULT OnEvent(ISensor pSensor, const(GUID)* eventID, IPortableDeviceValues pEventData);
    HRESULT OnLeave(GUID* ID);
}


// GUIDs

const GUID CLSID_Sensor           = GUIDOF!Sensor;
const GUID CLSID_SensorCollection = GUIDOF!SensorCollection;
const GUID CLSID_SensorDataReport = GUIDOF!SensorDataReport;
const GUID CLSID_SensorManager    = GUIDOF!SensorManager;

const GUID IID_ILocationPermissions = GUIDOF!ILocationPermissions;
const GUID IID_ISensor              = GUIDOF!ISensor;
const GUID IID_ISensorCollection    = GUIDOF!ISensorCollection;
const GUID IID_ISensorDataReport    = GUIDOF!ISensorDataReport;
const GUID IID_ISensorEvents        = GUIDOF!ISensorEvents;
const GUID IID_ISensorManager       = GUIDOF!ISensorManager;
const GUID IID_ISensorManagerEvents = GUIDOF!ISensorManagerEvents;
