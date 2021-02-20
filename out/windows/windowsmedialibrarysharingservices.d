// Written in the D programming language.

module windows.windowsmedialibrarysharingservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT;

extern(Windows) @nogc nothrow:


// Enums


///The <b>WindowsMediaLibrarySharingDeviceAuthorizationStatus</b> enumeration defines constants that indicate whether a
///media device is authorized to have access to a media library.
enum WindowsMediaLibrarySharingDeviceAuthorizationStatus : int
{
    ///It is not known whether the device is authorized to have access to the media library.
    DEVICE_AUTHORIZATION_UNKNOWN = 0x00000000,
    ///The device is authorized to have access to the media library.
    DEVICE_AUTHORIZATION_ALLOWED = 0x00000001,
    ///The device is not authorized to have access to the media library.
    DEVICE_AUTHORIZATION_DENIED  = 0x00000002,
}

// Interfaces

@GUID("AD581B00-7B64-4E59-A38D-D2C5BF51DDB3")
struct WindowsMediaLibrarySharingServices;

///The <b>IWindowsMediaLibrarySharingDeviceProperty</b> interface defines methods that provide access to the name and
///value of an individual property of a media device.
@GUID("81E26927-7A7D-40A7-81D4-BDDC02960E3E")
interface IWindowsMediaLibrarySharingDeviceProperty : IDispatch
{
    ///The <b>get_Name</b> method retrieves the name of an individual property of a media device.
    ///Params:
    ///    name = A pointer to a <b>BSTR</b> that receives the property name.
    HRESULT get_Name(BSTR* name);
    ///The <b>get_Value</b> method retrieves the value of an individual property of a media device.
    ///Params:
    ///    value = A pointer to a <b>VARIANT</b> that receives the property value.
    HRESULT get_Value(VARIANT* value);
}

///The <b>IWindowsMediaLibrarySharingDeviceProperties</b> interface defines methods that provide access to the
///collection of all properties for an individual media device.
@GUID("C4623214-6B06-40C5-A623-B2FF4C076BFD")
interface IWindowsMediaLibrarySharingDeviceProperties : IDispatch
{
    ///The <b>get_Item</b> method retrieves an IWindowsMediaLibrarySharingDeviceProperty interface that represents an
    ///individual property for a media device.
    ///Params:
    ///    index = The zero-based index of the property in the collection of all properties associated with the media device.
    ///    property = A pointer to a variable that receives a pointer to the IWindowsMediaLibrarySharingDeviceProperty interface.
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDeviceProperty* property);
    ///The <b>get_Count</b> method retrieves the number of properties associated with an individual media device.
    ///Params:
    ///    count = A pointer to a <b>LONG</b> that receives the number of properties.
    HRESULT get_Count(int* count);
    ///The <b>GetProperty</b> method retrieves an IWindowsMediaLibrarySharingDeviceProperty interface that represents an
    ///indivdual property for a media device.
    ///Params:
    ///    name = A <b>BSTR</b> that specifies the name of the property.
    ///    property = A pointer to a variable that receives a pointer to the IWindowsMediaLibrarySharingDeviceProperty interface.
    HRESULT GetProperty(BSTR name, IWindowsMediaLibrarySharingDeviceProperty* property);
}

///The <b>IWindowsMediaLibrarySharingDevice</b> interface defines methods that provide access to an individual media
///device on the home network.
@GUID("3DCCC293-4FD9-4191-A25B-8E57C5D27BD4")
interface IWindowsMediaLibrarySharingDevice : IDispatch
{
    ///The <b>get_DeviceID</b> method retrieves the device ID.
    ///Params:
    ///    deviceID = A pointer to a <b>BSTR</b> that receives the device ID.
    HRESULT get_DeviceID(BSTR* deviceID);
    ///The <b>get_Authorization</b> method retrieves a value that indicates whether the device is authorized to have
    ///access to the current user's media library.
    ///Params:
    ///    authorization = A pointer to a variable that receives an element of the WindowsMediaLibrarySharingDeviceAuthorizationStatus
    ///                    enumeration.
    HRESULT get_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus* authorization);
    ///The <b>put_Authorization</b> method authorizes or unauthorizes the device to have access to the current user's
    ///media library.
    ///Params:
    ///    authorization = An element of the WindowsMediaLibrarySharingDeviceAuthorizationStatus enumeration that specifies whether the
    ///                    device is authorized (<b>DEVICE_AUTHORIZATION_ALLOWED</b>) or unauthorized
    ///                    (<b>DEVICE_AUTHORIZATION_DENIED</b>) to have access to the current user's media library.
    HRESULT put_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus authorization);
    ///The <b>get_Properties</b> method retrieves an IWindowsMediaLibrarySharingDeviceProperties interface that
    ///represents the collection of all properties for the device.
    ///Params:
    ///    deviceProperties = A pointer to a variable that receives a pointer to the IWindowsMediaLibrarySharingDeviceProperties interface.
    HRESULT get_Properties(IWindowsMediaLibrarySharingDeviceProperties* deviceProperties);
}

///The <b>IWindowsMediaLibrarySharingDevices</b> interface defines methods that provide access to the collection of
///media devices on the home network.
@GUID("1803F9D6-FE6D-4546-BF5B-992FE8EC12D1")
interface IWindowsMediaLibrarySharingDevices : IDispatch
{
    ///The <b>get_Item</b> method retrieves an IWindowsMediaLibrarySharingDevice interface that represents an individual
    ///media device.
    ///Params:
    ///    index = The zero-based index of the device in the collection of media devices on the home network.
    ///    device = A pointer to a variable that receives a pointer to the IWindowsMediaLibrarySharingDevice interface.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDevice* device);
    ///The <b>get_Count</b> method retrieves the number of media devices on the home network.
    ///Params:
    ///    count = A pointer to a <b>LONG</b> that receives the number of devices.
    HRESULT get_Count(int* count);
    ///The <b>GetDevice</b> method retrieves an IWindowsMediaLibrarySharingDevice interface that represents an
    ///individual media device.
    ///Params:
    ///    deviceID = A <b>BSTR</b> that specifies the device ID.
    ///    device = A pointer to a variable that receives a pointer to the IWindowsMediaLibrarySharingDevice interface.
    HRESULT GetDevice(BSTR deviceID, IWindowsMediaLibrarySharingDevice* device);
}

///The <b>IWindowsMediaLibrarySharingServices</b> interface defines methods that configure the sharing of media
///libraries among users on the local computer, users on the home network, and users on the Internet.
@GUID("01F5F85E-0A81-40DA-A7C8-21EF3AF8440C")
interface IWindowsMediaLibrarySharingServices : IDispatch
{
    ///The <b>showShareMediaCPL</b> method displays the media sharing page in the Control Panel and highlights a
    ///specified device.
    ///Params:
    ///    device = <b>BSTR</b>
    ///Returns:
    ///    This method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT showShareMediaCPL(BSTR device);
    ///The <b>get_userHomeMediaSharingState</b> method retrieves a value that indicates whether the current user's media
    ///library is shared on the home network.
    ///Params:
    ///    sharingEnabled = Pointer to a <b>VARIANT_BOOL</b> that receives <b>VARIANT_TRUE</b> if the media library is shared and
    ///                     <b>VARIANT_FALSE</b> if the media library is not shared.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_userHomeMediaSharingState(short* sharingEnabled);
    ///The <b>put_userHomeMediaSharingState</b> method enables or disables sharing of the current user's media library
    ///on the home network.
    ///Params:
    ///    sharingEnabled = A <b>VARIANT_BOOL</b> that specifies whether sharing is enabled (<b>VARIANT_TRUE</b>) or disabled
    ///                     (<b>VARIANT_FALSE</b>) for the current user.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_userHomeMediaSharingState(short sharingEnabled);
    ///The <b>get_userHomeMediaSharingLibraryName</b> method retrieves the name of the current user's shared media
    ///library.
    ///Params:
    ///    libraryName = Pointer to a <b>BSTR</b> that receives the library name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_userHomeMediaSharingLibraryName(BSTR* libraryName);
    ///The <b>put_userHomeMediaSharingLibraryName</b> method sets the name of the current user's shared media library.
    ///Params:
    ///    libraryName = A <b>BSTR</b> that specifies the library name.
    HRESULT put_userHomeMediaSharingLibraryName(BSTR libraryName);
    ///The <b>get_computerHomeMediaSharingAllowedState</b> method retrieves a value that indicates whether media
    ///libraries on the computer are allowed to be shared on the home network.
    ///Params:
    ///    sharingAllowed = Pointer to a <b>VARIANT_BOOL</b> that receives <b>VARIANT_TRUE</b> if media libraries are allowed to be
    ///                     shared and <b>VARIANT_FALSE</b> if media libraries are not allowed to be shared.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_computerHomeMediaSharingAllowedState(short* sharingAllowed);
    ///The <b>put_computerHomeMediaSharingAllowedState</b> method specifies whether media libraries on the computer are
    ///allowed to be shared on the home network.
    ///Params:
    ///    sharingAllowed = A <b>VARIANT_BOOL</b> that specifies VARIANT_TRUE if media libraries are allowed to be shared or
    ///                     <b>VARIANT_FALSE</b> if media libraries are not allowed to be shared.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_computerHomeMediaSharingAllowedState(short sharingAllowed);
    ///The <b>get_userInternetMediaSharingState</b> method retrieves a value that indicates whether the current user's
    ///media library is shared on the Internet.
    ///Params:
    ///    sharingEnabled = Pointer to a <b>VARIANT_BOOL</b> that receives <b>VARIANT_TRUE</b> if the media library is shared and
    ///                     <b>VARIANT_FALSE</b> if the media library is not shared.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_userInternetMediaSharingState(short* sharingEnabled);
    ///The <b>put_userInternetMediaSharingState</b> method enables or disables sharing of the current user's media
    ///library on the Internet.
    ///Params:
    ///    sharingEnabled = A <b>VARIANT_BOOL</b> that specifies whether sharing on the Internet is enabled (<b>VARIANT_TRUE</b>) or
    ///                     disabled (<b>VARIANT_FALSE</b>) for the current user.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_userInternetMediaSharingState(short sharingEnabled);
    ///The <b>get_computerInternetMediaSharingAllowedState</b> method retrieves a value that indicates whether media
    ///libraries on the computer are allowed to be shared on the Internet.
    ///Params:
    ///    sharingAllowed = Pointer to a <b>VARIANT_BOOL</b> that receives <b>VARIANT_TRUE</b> if media libraries are allowed to be
    ///                     shared and <b>VARIANT_FALSE</b> if media libraries are not allowed to be shared.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_computerInternetMediaSharingAllowedState(short* sharingAllowed);
    ///The <b>put_computerInternetMediaSharingAllowedState</b> method specifies whether media libraries on the computer
    ///are allowed to be shared on the Internet.
    ///Params:
    ///    sharingAllowed = A <b>VARIANT_BOOL</b> that specifies whether sharing is allowed (<b>VARIANT_TRUE</b>) or not allowed
    ///                     (<b>VARIANT_FALSE</b>).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_computerInternetMediaSharingAllowedState(short sharingAllowed);
    ///The <b>get_internetMediaSharingSecurityGroup</b> method retrieves the name of the security group that is used to
    ///authenticate connections coming in over the Internet.
    ///Params:
    ///    securityGroup = A pointer to a <b>BSTR</b> that receives the name of the security group.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_internetMediaSharingSecurityGroup(BSTR* securityGroup);
    ///The <b>put_internetMediaSharingSecurityGroup</b> method specifies the name of the security group that is used to
    ///authenticate connections coming in over the Internet.
    ///Params:
    ///    securityGroup = A <b>BSTR</b> that specifies the name of the security group.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_internetMediaSharingSecurityGroup(BSTR securityGroup);
    ///The <b>get_allowSharingToAllDevices</b> method retrieves a value that indicates whether the current user's media
    ///library is shared with all devices on the home network.
    ///Params:
    ///    sharingEnabled = Pointer to a <b>VARIANT_BOOL</b> that receives <b>VARIANT_TRUE</b> if the media libray is shared with all
    ///                     devices and <b>VARIANT_FALSE</b> if the media library is not shared with at least one device.
    HRESULT get_allowSharingToAllDevices(short* sharingEnabled);
    ///The <b>put_allowSharingToAllDevices</b> method allows or disallows sharing of the current user's media library
    ///with all devices on the home network.
    ///Params:
    ///    sharingEnabled = A <b>VARIANT_BOOL</b> that specifies whether sharing is allowed (<b>VARIANT_TRUE</b>) or not allowed
    ///                     (<b>VARIANT_FALSE</b>).
    HRESULT put_allowSharingToAllDevices(short sharingEnabled);
    ///The <b>setDefaultAuthorization</b> method enables or disables access to all users' media libraries by a specified
    ///set of devices.
    ///Params:
    ///    MACAddresses = A <b>BSTR</b> that specifies the MAC addresses of the devices for which access will be enabled or disabled.
    ///                   The MAC addresses are delimited by commas.
    ///    friendlyName = A <b>BSTR</b> that specifies a friendly name that applies to all devices listed in the <i>MACAddresses</i>
    ///                   parameter.
    ///    authorization = A <b>VARIANT_BOOL</b> that specifies whether access by the set of devices is enabled (<b>VARIANT_TRUE</b>) or
    ///                    disabled (<b>VARIANT_FALSE</b>).
    HRESULT setDefaultAuthorization(BSTR MACAddresses, BSTR friendlyName, short authorization);
    ///The <b>setAuthorizationState</b> method enables or disables access to the current user's media library by a
    ///specified device.
    ///Params:
    ///    MACAddress = A <b>BSTR</b> that specifies the MAC address of the device for which access will be enabled or disabled.
    ///    authorizationState = A <b>VARIANT_BOOL</b> that specifies whether access by the device is enabled (<b>VARIANT_TRUE</b>) or
    ///                         disabled (<b>VARIANT_FALSE</b>).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setAuthorizationState(BSTR MACAddress, short authorizationState);
    ///The <b>getAllDevices</b> method retrieves an IWindowsMediaLibrarySharingDevices interface that represents all of
    ///the media-sharing client devices on the home network.
    ///Params:
    ///    devices = A pointer to a variable that receives a pointer to the IWindowsMediaLibrarySharingDevices interface.
    HRESULT getAllDevices(IWindowsMediaLibrarySharingDevices* devices);
    ///The <b>get_customSettingsApplied</b> method retrieves a value that indicates whether any custom media-sharing
    ///settings are in place for the current user.
    ///Params:
    ///    customSettingsApplied = Pointer to a <b>VARIANT_BOOL</b> that receives <b>VARIANT_TRUE</b> if any custom settings are in place for
    ///                            the current user and <b>VARIANT_FALSE</b> if the default settings are in place for the current user.
    HRESULT get_customSettingsApplied(short* customSettingsApplied);
}


// GUIDs

const GUID CLSID_WindowsMediaLibrarySharingServices = GUIDOF!WindowsMediaLibrarySharingServices;

const GUID IID_IWindowsMediaLibrarySharingDevice           = GUIDOF!IWindowsMediaLibrarySharingDevice;
const GUID IID_IWindowsMediaLibrarySharingDeviceProperties = GUIDOF!IWindowsMediaLibrarySharingDeviceProperties;
const GUID IID_IWindowsMediaLibrarySharingDeviceProperty   = GUIDOF!IWindowsMediaLibrarySharingDeviceProperty;
const GUID IID_IWindowsMediaLibrarySharingDevices          = GUIDOF!IWindowsMediaLibrarySharingDevices;
const GUID IID_IWindowsMediaLibrarySharingServices         = GUIDOF!IWindowsMediaLibrarySharingServices;
