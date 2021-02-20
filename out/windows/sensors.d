// Written in the D programming language.

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

extern(Windows) @nogc nothrow:


// Enums


///Defines possible operational states for sensors.
enum SensorState : int
{
    ///Minimum enumerated sensor state. Use <b>SENSOR_STATE_READY</b> instead.
    SENSOR_STATE_MIN           = 0x00000000,
    ///Ready to send sensor data.
    SENSOR_STATE_READY         = 0x00000000,
    ///The sensor is not available for use.
    SENSOR_STATE_NOT_AVAILABLE = 0x00000001,
    ///The sensor is available but does not have data.
    SENSOR_STATE_NO_DATA       = 0x00000002,
    ///The sensor is available, but performing initialization. Try again later.
    SENSOR_STATE_INITIALIZING  = 0x00000003,
    ///The sensor is available, but the user account does not have permission to access the sensor data. For more
    ///information about permissions, see Managing User Permissions.
    SENSOR_STATE_ACCESS_DENIED = 0x00000004,
    ///The sensor has raised an error.
    SENSOR_STATE_ERROR         = 0x00000005,
    SENSOR_STATE_MAX           = 0x00000005,
}

///Defines types of sensor device connections.
enum SensorConnectionType : int
{
    ///The sensor device is built into the computer.
    SENSOR_CONNECTION_TYPE_PC_INTEGRATED = 0x00000000,
    ///The sensor device is attached to the computer, such as through a peripheral device.
    SENSOR_CONNECTION_TYPE_PC_ATTACHED   = 0x00000001,
    SENSOR_CONNECTION_TYPE_PC_EXTERNAL   = 0x00000002,
}

///The <b>LOCATION_DESIRED_ACCURACY </b>enumeration type defines values for the
///SENSOR_PROPERTY_LOCATION_DESIRED_ACCURACY property.
alias LOCATION_DESIRED_ACCURACY = int;
enum : int
{
    ///Indicates that the sensor should use the accuracy for which it can optimize power and other such cost
    ///considerations.
    LOCATION_DESIRED_ACCURACY_DEFAULT = 0x00000000,
    ///Indicates that the sensor should deliver the highest-accuracy report possible. This includes using services that
    ///might charge money, or consuming higher levels of battery power or connection bandwidth.
    LOCATION_DESIRED_ACCURACY_HIGH    = 0x00000001,
}

alias LOCATION_POSITION_SOURCE = int;
enum : int
{
    LOCATION_POSITION_SOURCE_CELLULAR  = 0x00000000,
    LOCATION_POSITION_SOURCE_SATELLITE = 0x00000001,
    LOCATION_POSITION_SOURCE_WIFI      = 0x00000002,
    LOCATION_POSITION_SOURCE_IPADDRESS = 0x00000003,
    LOCATION_POSITION_SOURCE_UNKNOWN   = 0x00000004,
}

enum SimpleDeviceOrientation : int
{
    SIMPLE_DEVICE_ORIENTATION_NOT_ROTATED       = 0x00000000,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_90        = 0x00000001,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_180       = 0x00000002,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_270       = 0x00000003,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_UP   = 0x00000004,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_DOWN = 0x00000005,
}

///Specifies the accuracy of the magnetometer.
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

///Provides methods for discovering and retrieving available sensors and a method to request sensor manager events.
@GUID("BD77DB67-45A8-42DC-8D00-6DCF15F8377A")
interface ISensorManager : IUnknown
{
    ///Retrieves a collection containing all sensors associated with the specified category.
    ///Params:
    ///    sensorCategory = ID of the sensor category to retrieve.
    ///    ppSensorsFound = Address of an ISensorCollection interface pointer that receives a pointer to the sensor collection requested.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> No sensors are available
    ///    for the specified category. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> NULL was passed in for ppSensorsFound. </td> </tr> </table>
    ///    
    HRESULT GetSensorsByCategory(GUID* sensorCategory, ISensorCollection* ppSensorsFound);
    ///Retrieves a collection containing all sensors associated with the specified type.
    ///Params:
    ///    sensorType = ID of the type of sensors to retrieve.
    ///    ppSensorsFound = Address of an ISensorCollection interface pointer that receives the pointer to the sensor collection
    ///                     requested.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> No sensors are
    ///    available for the specified type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> NULL was passed in for ppSensorsFound. </td> </tr> </table>
    ///    
    HRESULT GetSensorsByType(GUID* sensorType, ISensorCollection* ppSensorsFound);
    ///Retrieves a pointer to the specified sensor.
    ///Params:
    ///    sensorID = The ID of the sensor to retrieve.
    ///    ppSensor = Address of an ISensor interface pointer that receives a pointer to the requested sensor. Will be <b>NULL</b>
    ///               if the requested sensor cannot be found.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The sensor manager found more than one sensor
    ///    with the same ID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND) </b></dt>
    ///    </dl> </td> <td width="60%"> No sensor is available for the specified ID. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for ppSensor. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSensorByID(GUID* sensorID, ISensor* ppSensor);
    ///Specifies the interface through which to receive sensor manager event notifications.
    ///Params:
    ///    pEvents = Pointer to the ISensorManagerEvents callback interface that receives the event notifications. Set to
    ///              <b>NULL</b> to stop receiving event notifications.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEventSink(ISensorManagerEvents pEvents);
    ///Opens a system dialog box to request user permission to access sensor data.
    ///Params:
    ///    hParent = For Windows 8, if <i>hParent</i> is provided a value, then the dialog will be modal to the parent window. If
    ///              <i>hParent</i> is <b>NULL</b>, then the dialog will not be modal. The dialog is always synchronous. For
    ///              Windows 7, <b>HWND</b> is handle to a window that can act as a parent to the permissions dialog box. Must be
    ///              <b>NULL</b> if <i>fModal</i> is <b>TRUE</b>.
    ///    pSensors = For Windows 8, this value is not used. For Windows 7, <i>pSensors</i> is a pointer to the ISensorCollection
    ///               interface that contains the list of sensors for which permission is being requested.
    ///    fModal = For Windows 8, this value is not used. Refer to <i>hParent</i> for control of modality. For Windows 7,
    ///             <i>fModal</i> is a <b>BOOL</b> that specifies the dialog box mode. Must be <b>FALSE</b> if <i>hParent</i> is
    ///             non-null. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a
    ///             id="true"></a><dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> If <i>hParent</i> is <b>NULL</b>, the
    ///             dialog box is modal and therefore has exclusive focus in Windows until the user responds. The call is
    ///             synchronous. The return code indicates the user choice. See Return Value. If <i>hParent</i> is non-null, the
    ///             call is asynchronous and the calling thread will not wait for the dialog box to be closed. The return code
    ///             indicates whether the call succeeded. See Return Value. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a
    ///             id="false"></a><dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The dialog box is modeless. The call
    ///             is asynchronous and the calling thread will not wait for the dialog box to be closed. The return code
    ///             indicates whether the call succeeded. See Return Value. The <i>hParent</i> parameter is ignored. </td> </tr>
    ///             </table>
    ///Returns:
    ///    The following table describes return codes for synchronous results. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    user enabled the sensors. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_ACCESS_DENIED)</b></dt> </dl> </td> <td width="60%"> The user chose to
    ///    disable the sensors. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_CANCELLED)
    ///    </b></dt> </dl> </td> <td width="60%"> The user canceled the dialog box or refused elevation of permission to
    ///    show the dialog box. </td> </tr> </table> The following table describes return codes for asynchronous
    ///    results. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All of the sensors in the sensor collection were displayed
    ///    for the user to enable. The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> Some of the sensors in the sensor collection were displayed for the user to
    ///    enable. Some sensors may have been removed from the collection; for example, because the user had previously
    ///    chosen to keep them disabled. The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer is null. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_ACCESS_DENIED)</b></dt> </dl> </td> <td width="60%">
    ///    All sensors in the sensor collection were previously disabled by the user. The dialog box was not shown.
    ///    </td> </tr> </table>
    ///    
    HRESULT RequestPermissions(HWND hParent, ISensorCollection pSensors, BOOL fModal);
}

///Provides the status of the system setting that allows users to change location settings.
@GUID("D5FB0A7F-E74E-44F5-8E02-4806863A274F")
interface ILocationPermissions : IUnknown
{
    ///Gets the status of the system setting that allows users to change location settings.
    ///Params:
    ///    pfEnabled = <b>TRUE</b> if system settings allow users to enable or disable the location platform; otherwise,
    ///                <b>FALSE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for pfEnabled. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGlobalLocationPermission(BOOL* pfEnabled);
    ///Gets the location capability of the Windows Store app of the given thread
    ///Params:
    ///    dwClientThreadId = Thread Id of the app to check the location capability of
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded and the app is location enabled. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The app has not
    ///    declared location capability or the user has declined or revoked location access. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ILLEGAL_METHOD_CALL</b></dt> </dl> </td> <td width="60%"> An invalid client thread
    ///    was provided. </td> </tr> </table>
    ///    
    HRESULT CheckLocationCapability(uint dwClientThreadId);
}

///Represents a collection of sensors, such as all the sensors connected to a computer. Retrieve a pointer to
///<b>ISensorCollection</b> by calling methods of the ISensorManager interface. In addition to the methods inherited
///from <b>IUnknown</b>, the <b>ISensorCollection</b> interface exposes the following methods.
@GUID("23571E11-E545-4DD8-A337-B89BF44B10DF")
interface ISensorCollection : IUnknown
{
    ///Retrieves the sensor at the specified index in the collection.
    ///Params:
    ///    ulIndex = <b>ULONG</b> containing the index of the sensor to retrieve.
    ///    ppSensor = Address of an ISensor pointer that receives the pointer to the specified sensor.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for ppSensor. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetAt(uint ulIndex, ISensor* ppSensor);
    ///Retrieves the count of sensors in the collection.
    ///Params:
    ///    pCount = Address of a <b>ULONG</b> that receives the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for pCount. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCount(uint* pCount);
    ///Adds a sensor to the collection.
    ///Params:
    ///    pSensor = Pointer to the ISensor interface for the sensor to add to the collection.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_ALREADY_EXISTS) </b></dt> </dl> </td> <td width="60%"> The sensor
    ///    collection already contains a sensor with the specified ID. </td> </tr> </table>
    ///    
    HRESULT Add(ISensor pSensor);
    ///Removes a sensor from the collection. The sensor is specified by a pointer to the ISensor interface to be
    ///removed.
    ///Params:
    ///    pSensor = Pointer to the ISensor interface to remove from the collection.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified sensor is not part of the
    ///    collection. </td> </tr> </table>
    ///    
    HRESULT Remove(ISensor pSensor);
    ///Removes a sensor from the collection. The sensor to be removed is specified by its ID.
    ///Params:
    ///    sensorID = The <b>GUID</b> of the sensor to remove from the collection.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified sensor is not part of the
    ///    collection. </td> </tr> </table>
    ///    
    HRESULT RemoveByID(GUID* sensorID);
    ///Empties the sensor collection.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Clear();
}

///Represents a sensor. You will generally retrieve a pointer to <b>ISensor</b> by calling ISensorCollection::GetAt or
///ISensorManager::GetSensorByID, but other methods can retrieve this pointer, too. Various other Sensor API methods use
///a pointer to <b>ISensor</b> to provide information about a particular sensor or to enable you to specify which sensor
///to use for a particular action. In addition to the methods inherited from <b>IUnknown</b>, the <b>ISensor</b>
///interface exposes the following methods.
@GUID("5FA08F80-2657-458E-AF75-46F73FA6AC5C")
interface ISensor : IUnknown
{
    ///Retrieves the unique identifier of the sensor.
    ///Params:
    ///    pID = Address of a <b>SENSOR_ID</b> that receives the ID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The sensor driver did not provide a sensor ID.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed
    ///    in for pID. </td> </tr> </table>
    ///    
    HRESULT GetID(GUID* pID);
    ///Retrieves the identifier of the sensor category.
    ///Params:
    ///    pSensorCategory = Address of a <b>SENSOR_CATEGORY_ID</b> that receives the sensor category ID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The sensor driver did not provide a category
    ///    value. The <b>PROPVARIANT</b> returned will have its error value set to <b>HRESULT_FROM_WIN32 (
    ///    ERROR_NOT_FOUND)</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> NULL was passed in for pSensorCategory. </td> </tr> </table>
    ///    
    HRESULT GetCategory(GUID* pSensorCategory);
    ///Retrieves the sensor type ID.
    ///Params:
    ///    pSensorType = Address of a <b>SENSOR_TYPE_ID</b> that receives the sensor type ID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The sensor driver did not provide a sensor
    ///    type value. The <b>PROPVARIANT</b> returned will have its error value set to <b>HRESULT_FROM_WIN32 (
    ///    ERROR_NOT_FOUND)</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> NULL was passed in for pSensorType. </td> </tr> </table>
    ///    
    HRESULT GetType(GUID* pSensorType);
    ///Retrieves the sensor name that is intended to be seen by the user.
    ///Params:
    ///    pFriendlyName = Address of a <b>BSTR</b> that receives the friendly name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The sensor driver did not provide a friendly
    ///    name value. The value provided through <i>pFriendlyName</i> is not valid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for pFriendlyName. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFriendlyName(BSTR* pFriendlyName);
    ///Retrieves a property value.
    ///Params:
    ///    key = <b>REFPROPERTYKEY</b> specifying the property value to be retrieved.
    ///    pProperty = <b>PROPVARIANT</b> pointer that receives the property value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> The sensor does not
    ///    support the specified property. The value provided through <i>pProperty</i> is <b>VT_NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for
    ///    pProperty. </td> </tr> </table>
    ///    
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* pProperty);
    ///Retrieves multiple sensor properties.
    ///Params:
    ///    pKeys = Pointer to an IPortableDeviceKeyCollection interface containing the <b>PROPERTYKEY</b> collection for the
    ///            property values being requested. Set to <b>NULL</b> to retrieve all supported properties.
    ///    ppProperties = Address of an IPortableDeviceValues pointer that receives the pointer to the requested property values.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The sensor driver does not support at least one of
    ///    the specified properties. Each unsupported property <b>PROPVARIANT</b> returned through the
    ///    IPortableDeviceValues interface will have its error value set to <b>HRESULT_FROM_WIN32 (ERROR_NOT_FOUND)</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed
    ///    in for ppProperties. </td> </tr> </table>
    ///    
    HRESULT GetProperties(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppProperties);
    ///Retrieves a set of <b>PROPERTYKEY</b>s that represent the data fields the sensor can provide.
    ///Params:
    ///    ppDataFields = Address of the IPortableDeviceKeyCollection pointer that receives the list of supported data fields.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for ppDataFields. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSupportedDataFields(IPortableDeviceKeyCollection* ppDataFields);
    ///Specifies sensor properties.
    ///Params:
    ///    pProperties = Pointer to an IPortableDeviceValues interface containing the list of properties and values to set.
    ///    ppResults = Address of an <b>IPortableDeviceValues</b> interface that receives the list of properties that were
    ///                successfully set. Each property has an associated <b>HRESULT</b> value, which indicates whether setting the
    ///                property succeeded.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The request to set one or more of the specified
    ///    properties failed. Inspect <i>ppResults</i> to determine which properties, if any, succeeded. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for
    ///    ppResults. </td> </tr> </table>
    ///    
    HRESULT SetProperties(IPortableDeviceValues pProperties, IPortableDeviceValues* ppResults);
    ///Indicates whether the sensor supports the specified data field.
    ///Params:
    ///    key = <b>REFPROPERTYKEY</b> value specifying the data field to search for.
    ///    pIsSupported = Address of a <b>VARIANT_BOOL</b> that receives a value indicating whether the sensor supports the data field.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for pIsSupported. </td> </tr>
    ///    </table>
    ///    
    HRESULT SupportsDataField(const(PROPERTYKEY)* key, short* pIsSupported);
    ///Retrieves the current operational state of the sensor.
    ///Params:
    ///    pState = Address of a SensorState variable that receives the current state.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The sensor driver did not provide a state
    ///    value. The value provided through <i>pState</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for pState. </td> </tr> </table>
    ///    
    HRESULT GetState(SensorState* pState);
    ///Retrieves the most recent sensor data report.
    ///Params:
    ///    ppDataReport = Address of an ISensorDataReport pointer that receives the pointer to the most recent sensor data report.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The sensor driver provided badly formed data.
    ///    For example, the data was of a type that is not supported. For information about data types of
    ///    platform-defined data fields, see Sensor Categories, Types, and Data Fields. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_DATA)</b></dt> </dl> </td> <td width="60%"> The sensor
    ///    has no data to report. For example, a GPS sensor could be in the process of acquiring a satellite fix. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in
    ///    for ppDataReport. </td> </tr> </table>
    ///    
    HRESULT GetData(ISensorDataReport* ppDataReport);
    ///Indicates whether the sensor supports the specified event.
    ///Params:
    ///    eventGuid = <b>REFGUID</b> value specifying the event to search for.
    ///    pIsSupported = Address of a <b>VARIANT_BOOL</b> that receives a value indicating whether the sensor supports the event.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for pIsSupported. </td> </tr>
    ///    </table>
    ///    
    HRESULT SupportsEvent(const(GUID)* eventGuid, short* pIsSupported);
    ///Retrieves the current event interest settings.
    ///Params:
    ///    ppValues = Address of a <b>GUID</b> pointer that points to an array of sensor event identifiers.
    ///    pCount = The count of <b>GUID</b>s in the array pointed to by <i>ppValues</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for ppValues or pCount. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetEventInterest(GUID** ppValues, uint* pCount);
    ///Specifies the list of sensor events to receive.
    ///Params:
    ///    pValues = Pointer to an array of <b>GUID</b>s. Each <b>GUID</b> represents an event to receive. Set to <b>NULL</b> to
    ///              receive all data-updated events and all custom events.
    ///    count = The count of <b>GUID</b>s in the array pointed to by <i>pValues</i>. Set to zero when <i>pValues</i> is
    ///            <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEventInterest(GUID* pValues, uint count);
    ///Specifies the interface through which to receive sensor event notifications.
    ///Params:
    ///    pEvents = Pointer to the ISensorEvents callback interface that receives the event notifications. Set to <b>NULL</b> to
    ///              cancel event notifications.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEventSink(ISensorEvents pEvents);
}

///Represents a sensor data report. Sensor data reports contain data field values generated by a sensor and a time stamp
///that indicates when the data report was created. Retrieve a sensor data report asynchronously by subscribing to the
///ISensorEvents::OnDataUpdated event, or synchronously by calling ISensor::GetData. In addition to the methods
///inherited from <b>IUnknown</b>, the ISensorDataReport interface exposes the following methods.
@GUID("0AB9DF9B-C4B5-4796-8898-0470706A2E1D")
interface ISensorDataReport : IUnknown
{
    ///Retrieves the time at which the data report was created.
    ///Params:
    ///    pTimeStamp = Address of a SYSTEMTIME variable that receives the time stamp.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The sensor driver did not return a valid time
    ///    stamp for the data report. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> NULL was passed in for pTimeStamp. </td> </tr> </table>
    ///    
    HRESULT GetTimestamp(SYSTEMTIME* pTimeStamp);
    ///Retrieves a single data field value from the data report.
    ///Params:
    ///    pKey = <b>REFPROPERTYKEY</b> indicating the data field to retrieve.
    ///    pValue = Address of a <b>PROPVARIANT</b> that receives the data field value.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> The data field was not
    ///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was
    ///    passed in for pValue. </td> </tr> </table>
    ///    
    HRESULT GetSensorValue(const(PROPERTYKEY)* pKey, PROPVARIANT* pValue);
    ///Retrieves a collection of data field values.
    ///Params:
    ///    pKeys = Pointer to the IPortableDeviceKeyCollection interface that contains the data fields for which to retrieve
    ///            values. Set to <b>NULL</b> to retrieve values for all supported data fields.
    ///    ppValues = Address of an IPortableDeviceValues interface pointer that receives the pointer to the retrieved values.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> A data field was not
    ///    found. Inspect <i>ppValues</i> to determine which values were set to <b>ERROR_NOT_FOUND</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed in for ppValues.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSensorValues(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppValues);
}

///The callback interface for receiving sensor manager events. To receive event notifications, first call
///ISensorManager::SetEventSink.
@GUID("9B3B0B86-266A-4AAD-B21F-FDE5501001B7")
interface ISensorManagerEvents : IUnknown
{
    ///Provides notification when a sensor device is connected.
    ///Params:
    ///    pSensor = A pointer to the ISensor interface of the sensor that was connected.
    ///    state = SensorState indicating the current state of the sensor.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT OnSensorEnter(ISensor pSensor, SensorState state);
}

///The callback interface you must implement if you want to receive sensor events. To subscribe to events for a
///particular sensor, call ISensor::SetEventSink. In addition to the methods inherited from <b>IUnknown</b>, the
///<b>ISensorEvents</b> interface exposes the following methods.
@GUID("5D8DCC91-4641-47E7-B7C3-B74F48A6C391")
interface ISensorEvents : IUnknown
{
    ///Provides a notification that a sensor state has changed.
    ///Params:
    ///    pSensor = Pointer to the ISensor interface of the sensor that raised the event.
    ///    state = SensorState containing the new state.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT OnStateChanged(ISensor pSensor, SensorState state);
    ///Provides sensor event data.
    ///Params:
    ///    pSensor = Pointer to the ISensor interface of the sensor that raised the event.
    ///    pNewData = Pointer to the ISensorDataReport interface that contains the event data.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT OnDataUpdated(ISensor pSensor, ISensorDataReport pNewData);
    ///Provides custom event notifications.
    ///Params:
    ///    pSensor = Pointer to the ISensor interface that represents the sensor that raised the event.
    ///    eventID = <b>REFGUID</b> that identifies the event.
    ///    pEventData = Pointer to the IPortableDeviceValues interface that contains the event data.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnEvent(ISensor pSensor, const(GUID)* eventID, IPortableDeviceValues pEventData);
    ///Provides notification that a sensor device is no longer connected.
    ///Params:
    ///    ID = The ID of the sensor.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
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
