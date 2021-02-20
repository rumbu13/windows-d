// Written in the D programming language.

module windows.location;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;
public import windows.sensors : LOCATION_DESIRED_ACCURACY;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows) @nogc nothrow:


// Enums


///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] Defines possible status for new reports of a particular report type.
alias LOCATION_REPORT_STATUS = int;
enum : int
{
    ///The requested report type is not supported by the API. No location providers of the requested type are installed.
    REPORT_NOT_SUPPORTED = 0x00000000,
    ///There was an error when creating the report, or location providers for the requested type are unable to provide
    ///any data. Location providers might be currently unavailable, or location providers cannot obtain any data. For
    ///example, this state may occur when a GPS sensor is indoors and no satellites are in view.
    REPORT_ERROR         = 0x00000001,
    ///No permissions have been granted to access this report type. Call ILocation::RequestPermissions.
    REPORT_ACCESS_DENIED = 0x00000002,
    ///The report is being initialized.
    REPORT_INITIALIZING  = 0x00000003,
    ///The report is running. New location data for the requested report type is available.
    REPORT_RUNNING       = 0x00000004,
}

// Interfaces

@GUID("E5B8E079-EE6D-4E33-A438-C87F2E959254")
struct Location;

@GUID("8B7FBFE0-5CD7-494A-AF8C-283A65707506")
struct DefaultLocation;

@GUID("ED81C073-1F84-4CA8-A161-183C776BC651")
struct LatLongReport;

@GUID("D39E7BDD-7D05-46B8-8721-80CF035F57D7")
struct CivicAddressReport;

@GUID("9DCC3CC8-8609-4863-BAD4-03601F4C65E8")
struct LatLongReportFactory;

@GUID("2A11F42C-3E81-4AD4-9CBE-45579D89671A")
struct CivicAddressReportFactory;

@GUID("7A7C3277-8F84-4636-95B2-EBB5507FF77E")
struct DispLatLongReport;

@GUID("4C596AEC-8544-4082-BA9F-EB0A7D8E65C6")
struct DispCivicAddressReport;

///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] The parent interface for location reports.
@GUID("C8B7F7EE-75D0-4DB9-B62D-7A0F369CA456")
interface ILocationReport : IUnknown
{
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the ID of the sensor that generated the location report.
    ///Params:
    ///    pSensorID = Address of a <b>SENSOR_ID</b> that receives the ID of the sensor that generated the location report.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSensorID(GUID* pSensorID);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the date and time when the report was generated.
    ///Params:
    ///    pCreationTime = Address of a <b>SYSTEMTIME</b> that receives the date and time when the report was generated. Time stamps are
    ///                    provided as Coordinated Universal Time (UTC).
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTimestamp(SYSTEMTIME* pCreationTime);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves a property value from the location report.
    ///Params:
    ///    pKey = <b>REFPROPERTYKEY</b> that specifies the name of the property to retrieve.
    ///    pValue = Address of a <b>PROPVARIANT</b> that receives the property value.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetValue(const(PROPERTYKEY)* pKey, PROPVARIANT* pValue);
}

///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] <b>ILatLongReport</b> represents a location report that contains information in the
///form of latitude and longitude.
@GUID("7FED806D-0EF8-4F07-80AC-36A0BEAE3134")
interface ILatLongReport : ILocationReport
{
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the latitude, in degrees. The latitude is between -90 and 90, where
    ///north is positive.
    ///Params:
    ///    pLatitude = Address of a <b>DOUBLE</b> that receives the latitude.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLatitude(double* pLatitude);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the longitude, in degrees. The longitude is between -180 and 180,
    ///where East is positive.
    ///Params:
    ///    pLongitude = Address of a <b>DOUBLE</b> that receives the longitude.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLongitude(double* pLongitude);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves a distance from the reported location, in meters. Combined with the
    ///location reported as the origin, this radius describes the circle in which the actual location is probably
    ///located.
    ///Params:
    ///    pErrorRadius = Address of a <b>DOUBLE</b> that receives the error radius.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetErrorRadius(double* pErrorRadius);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the altitude, in meters. Altitude is relative to the reference
    ///ellipsoid.
    ///Params:
    ///    pAltitude = Address of a <b>DOUBLE</b> that receives the altitude, in meters. May be <b>NULL</b>.
    ///Returns:
    ///    Possible values include, but are not limited to, those in the following table. <table> <tr> <th>Return
    ///    value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%">
    ///    The method returned successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>HRESULT_FROM_WIN32(ERROR_NO_DATA)</dt> </dl> </td> <td width="60%"> The location report does not include
    ///    data for the requested field. This result is returned when the location sensor does not support altitude.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetAltitude(double* pAltitude);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.Geolocation API. ] Retrieves the altitude error, in meters.
    ///Params:
    ///    pAltitudeError = Address of a <b>DOUBLE</b> that receives the altitude error, in meters. May be <b>NULL</b>.
    ///Returns:
    ///    Possible values include, but are not limited to, those in the following table. <table> <tr> <th>Return
    ///    value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%">
    ///    The method returned successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt>HRESULT_FROM_WIN32(ERROR_NO_DATA)</dt> </dl> </td> <td width="60%"> The location report does not include
    ///    data for the requested field. This result is returned when the location sensor does not support altitude.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetAltitudeError(double* pAltitudeError);
}

///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] <b>ICivicAddressReport</b> represents a location report that contains information
///in the form of a street address.
@GUID("C0B19F70-4ADF-445D-87F2-CAD8FD711792")
interface ICivicAddressReport : ILocationReport
{
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the first line of a street address.
    ///Params:
    ///    pbstrAddress1 = Address of a <b>BSTR</b> that receives the first line of a street address.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAddressLine1(BSTR* pbstrAddress1);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the second line of a street address.
    ///Params:
    ///    pbstrAddress2 = Address of a <b>BSTR</b> that receives the second line of a street address.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAddressLine2(BSTR* pbstrAddress2);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the city name.
    ///Params:
    ///    pbstrCity = Address of a <b>BSTR</b> that receives the city name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCity(BSTR* pbstrCity);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the state or province name.
    ///Params:
    ///    pbstrStateProvince = Address of a <b>BSTR</b> that receives the state or province name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStateProvince(BSTR* pbstrStateProvince);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the postal code.
    ///Params:
    ///    pbstrPostalCode = Address of a <b>BSTR</b> that receives the postal code.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPostalCode(BSTR* pbstrPostalCode);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the two-letter country or region code.
    ///Params:
    ///    pbstrCountryRegion = Address of a <b>BSTR</b> that receives the country or region code.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCountryRegion(BSTR* pbstrCountryRegion);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Reserved.
    ///Params:
    ///    pDetailLevel = Reserved.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDetailLevel(uint* pDetailLevel);
}

///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] Provides methods used to manage location reports, event registration, and sensor
///permissions.
@GUID("AB2ECE69-56D9-4F28-B525-DE1B0EE44237")
interface ILocation : IUnknown
{
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Requests location report events.
    ///Params:
    ///    pEvents = Pointer to the ILocationEvents callback interface through which the requested event notifications will be
    ///              received.
    ///    reportType = <b>GUID</b> that specifies the interface ID of the report type for which to receive event notifications.
    ///    dwRequestedReportInterval = <b>DWORD</b> that specifies the requested elapsed time, in milliseconds, between event notifications for the
    ///                                specified report type. If <i>dwRequestedReportInterval</i> is zero, no minimum interval is specified and your
    ///                                application requests to receive events at the location sensor's default interval. See Remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType </i>
    ///    is other than IID_ILatLongReport or IID_ICivicAddressReport. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_ALREADY_REGISTERED)</b></dt> </dl> </td> <td width="60%"> <i>reportType </i>
    ///    is already registered. </td> </tr> </table>
    ///    
    HRESULT RegisterForReport(ILocationEvents pEvents, const(GUID)* reportType, uint dwRequestedReportInterval);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Stops event notifications for the specified report type.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the interface ID of the report type for which to stop events.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_STATE)</b></dt> </dl> </td> <td width="60%"> The caller is not
    ///    registered to receive events for the specified report type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType </i> is
    ///    other than IID_ILatLongReport or IID_ICivicAddressReport. </td> </tr> </table>
    ///    
    HRESULT UnregisterForReport(const(GUID)* reportType);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves a location report.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the type of report to retrieve.
    ///    ppLocationReport = Address of a pointer to ILocationReport that receives the specified location report.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The location provider has permissions
    ///    disabled and report data cannot be retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType </i> is
    ///    other than <b>IID_ILatLongReport</b> or <b>IID_ICivicAddressReport</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_DATA)</b></dt> </dl> </td> <td width="60%"> No data is available.
    ///    This may be due to an error or due to the provider being unavailable. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppLocationReport</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>reportType </i> is
    ///    <b>IID_ILatLongReport</b>, and the latitude or longitude value is out of bounds. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The underlying sensor is <b>NULL</b> or
    ///    disconnected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Out of memory. </td> </tr> </table>
    ///    
    HRESULT GetReport(const(GUID)* reportType, ILocationReport* ppLocationReport);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the status for the specified report type.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the report type for which to get the interval.
    ///    arg2 = Address of a LOCATION_REPORT_STATUS that receives the current status for the specified report.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType </i>
    ///    is other than <b>IID_ILatLongReport</b> or <b>IID_ICivicAddressReport</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pStatus</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetReportStatus(const(GUID)* reportType, LOCATION_REPORT_STATUS* pStatus);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the requested amount of time, in milliseconds, between report events.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the report type for which to get the interval.
    ///    pMilliseconds = The address of a <b>DWORD</b> that receives the report interval value, in milliseconds. If the report is not
    ///                    registered, this will be set to <b>NULL</b>. If this value is set to zero, no minimum interval is specified
    ///                    and your application receives events at the location sensor's default interval.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType</i>
    ///    was other than <b>IID_ILatLongReport</b> or <b>IID_ICivicAddressReport</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_STATE)</b></dt> </dl> </td> <td width="60%"> The caller is not
    ///    registered to receive events for the specified report type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pMilliseconds</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetReportInterval(const(GUID)* reportType, uint* pMilliseconds);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Specifies the requested minimum amount of time, in milliseconds, between report
    ///events.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the report type for which to set the interval.
    ///    millisecondsRequested = <b>DWORD</b> that contains the report interval value, in milliseconds. If this value is zero, no minimum
    ///                            interval is specified and your application receives events at the location sensor's default interval.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_STATE)</b></dt> </dl> </td> <td width="60%"> The caller is not
    ///    registered to receive events for the specified report type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType</i> was
    ///    other than <b>IID_ILatLongReport</b> or <b>IID_ICivicAddressReport</b>. </td> </tr> </table>
    ///    
    HRESULT SetReportInterval(const(GUID)* reportType, uint millisecondsRequested);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the current requested accuracy setting.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the report type for which to get the requested accuracy.
    ///    arg2 = The address of a LOCATION_DESIRED_ACCURACY that receives the accuracy value. If the report is not registered,
    ///           this will be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType</i>
    ///    was other than <b>IID_ILatLongReport</b> or <b>IID_ICivicAddressReport</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pDesiredAccuracy</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDesiredAccuracy(const(GUID)* reportType, LOCATION_DESIRED_ACCURACY* pDesiredAccuracy);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Specifies the accuracy to be used.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the report type for which to set the accuracy to be used.
    ///    arg2 = LOCATION_DESIRED_ACCURACY value that specifies the accuracy to be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td width="60%"> <i>reportType</i>
    ///    was other than <b>IID_ILatLongReport</b> or <b>IID_ICivicAddressReport</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>desiredAccuracy</i> is not
    ///    supported in the LOCATION_DESIRED_ACCURACY enumerated type. </td> </tr> </table>
    ///    
    HRESULT SetDesiredAccuracy(const(GUID)* reportType, LOCATION_DESIRED_ACCURACY desiredAccuracy);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.Geolocation API. ] Opens a system dialog box to request user permission to enable location
    ///devices.
    ///Params:
    ///    hParent = <b>HWND</b> for the parent window. This parameter is optional. In Windows 8 the dialog is always modal if
    ///              <i>hParent</i> is provided, and not modal if <i>hParent</i> is NULL.
    ///    pReportTypes = Pointer to an <b>IID</b> array. This array must contain interface IDs for all report types for which you are
    ///                   requesting permission. The interface IDs of the valid report types are IID_ILatLongReport and
    ///                   IID_ICivicAddressReport. The count of IDs must match the value specified through the <i>count</i> parameter.
    ///    count = The count of interface IDs contained in <i>pReportTypes</i>.
    ///    fModal = This parameter is not used.
    ///Returns:
    ///    This method can return one of these values. The following table describes return codes when the call is
    ///    synchronous. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The user enabled location services. The method succeeded.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_ACCESS_DENIED)</b></dt> </dl> </td>
    ///    <td width="60%"> The location platform is disabled. An administrator turned the location platform off. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_CANCELLED)</b></dt> </dl> </td> <td
    ///    width="60%"> The user did not enable access to location services or canceled the dialog box. </td> </tr>
    ///    </table> The following table describes return codes when the call is asynchronous. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The user enabled access to location services. The method succeeded. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_ACCESS_DENIED) </b></dt> </dl> </td> <td
    ///    width="60%"> The location platform is disabled. An administrator turned the location platform off. The dialog
    ///    box was not shown. </td> </tr> </table>
    ///    
    HRESULT RequestPermissions(HWND hParent, GUID* pReportTypes, uint count, BOOL fModal);
}

///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] Used by Windows Store app browsers in Windows 8 to notify the location platform
///that an app has been suspended (disconnect) and restored (connect). Most apps will not need to use this interface.
@GUID("193E7729-AB6B-4B12-8617-7596E1BB191C")
interface ILocationPower : IUnknown
{
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Used by Windows Store app browsers in Windows 8 to notify the location platform
    ///that an app has been suspended (disconnect) and restored (connect). Most apps will not need to use this method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Connect();
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Used by Windows Store app browsers in Windows 8 to notify the location platform
    ///that an app has been suspended (disconnect) and restored (connect). Most apps will not need to use this method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Disconnect();
}

///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] <b>IDefaultLocation</b> provides methods used to specify or retrieve the default
///location.
@GUID("A65AF77E-969A-4A2E-8ACA-33BB7CBB1235")
interface IDefaultLocation : IUnknown
{
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Sets the default location.
    ///Params:
    ///    reportType = <b>REFIID</b> that represents the interface ID of the type of report that is passed using
    ///                 <i>pLocationReport</i>.
    ///    pLocationReport = Pointer to the ILocationReport instance that contains the location report from the default location provider.
    ///Returns:
    ///    Possible values include, but are not limited to, those in the following table. <table> <tr> <th>Return
    ///    value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%">
    ///    The location report was successfully set. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_INVALIDARG</dt> </dl>
    ///    </td> <td width="60%"> The location report contains invalid data. This may occur when a civic address report
    ///    does not contain a valid IS0 3166 two-letter country or region code, or when a latitude/longitude report does
    ///    not contain a latitude between -90 and 90 or does not contain a longitude between -180 and 180. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>E_ACCESSDENIED</dt> </dl> </td> <td width="60%"> The user does not have
    ///    permission to set the default location. </td> </tr> </table>
    ///    
    HRESULT SetReport(const(GUID)* reportType, ILocationReport pLocationReport);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Retrieves the specified report type from the default location provider.
    ///Params:
    ///    reportType = <b>REFIID</b> representing the interface ID for the type of report being retrieved.
    ///    ppLocationReport = The address of a pointer to ILocationReport that receives the specified location report from the default
    ///                       location provider.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The location report was successfully retrieved. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>reportType </i> is
    ///    other than <b>IID_ILatLongReport</b> or <b>IID_ICivicAddressReport</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_DATA)</b></dt> </dl> </td> <td width="60%"> No data is available.
    ///    This may be due to a lack of default location data in the registry, corrupt data in the registry, or a
    ///    missing Country/Region field in the default location report. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppLocationReport</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetReport(const(GUID)* reportType, ILocationReport* ppLocationReport);
}

///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
///Windows.Devices.GeolocationAPI. ] <b>ILocationEvents</b> provides callback methods that you must implement if you
///want to receive event notifications.
@GUID("CAE02BBF-798B-4508-A207-35A7906DC73D")
interface ILocationEvents : IUnknown
{
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Called when a new location report is available.
    ///Params:
    ///    reportType = <b>REFIID</b> that contains the interface ID of the report type contained in <i>pLocationReport</i>.
    ///    pLocationReport = Pointer to the ILocationReport instance that contains the new location report.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnLocationChanged(const(GUID)* reportType, ILocationReport pLocationReport);
    ///<p class="CCE_Message">[The Win32 Location API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the
    ///Windows.Devices.GeolocationAPI. ] Called when a report status changes.
    ///Params:
    ///    reportType = <b>REFIID</b> that specifies the interface ID of the report type for which the status has changed.
    ///    newStatus = A constant from the LOCATION_REPORT_STATUS enumeration that contains the new status.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnStatusChanged(const(GUID)* reportType, LOCATION_REPORT_STATUS newStatus);
}

@GUID("8AE32723-389B-4A11-9957-5BDD48FC9617")
interface IDispLatLongReport : IDispatch
{
    HRESULT get_Latitude(double* pVal);
    HRESULT get_Longitude(double* pVal);
    HRESULT get_ErrorRadius(double* pVal);
    HRESULT get_Altitude(double* pVal);
    HRESULT get_AltitudeError(double* pVal);
    HRESULT get_Timestamp(double* pVal);
}

@GUID("16FF1A34-9E30-42C3-B44D-E22513B5767A")
interface IDispCivicAddressReport : IDispatch
{
    HRESULT get_AddressLine1(BSTR* pAddress1);
    HRESULT get_AddressLine2(BSTR* pAddress2);
    HRESULT get_City(BSTR* pCity);
    HRESULT get_StateProvince(BSTR* pStateProvince);
    HRESULT get_PostalCode(BSTR* pPostalCode);
    HRESULT get_CountryRegion(BSTR* pCountryRegion);
    HRESULT get_DetailLevel(uint* pDetailLevel);
    HRESULT get_Timestamp(double* pVal);
}

@GUID("2DAEC322-90B2-47E4-BB08-0DA841935A6B")
interface ILocationReportFactory : IDispatch
{
    HRESULT ListenForReports(uint requestedReportInterval);
    HRESULT StopListeningForReports();
    HRESULT get_Status(uint* pVal);
    HRESULT get_ReportInterval(uint* pMilliseconds);
    HRESULT put_ReportInterval(uint millisecondsRequested);
    HRESULT get_DesiredAccuracy(uint* pDesiredAccuracy);
    HRESULT put_DesiredAccuracy(uint desiredAccuracy);
    HRESULT RequestPermissions(uint* hWnd);
}

@GUID("3F0804CB-B114-447D-83DD-390174EBB082")
interface ILatLongReportFactory : ILocationReportFactory
{
    HRESULT get_LatLongReport(IDispLatLongReport* pVal);
}

@GUID("BF773B93-C64F-4BEE-BEB2-67C0B8DF66E0")
interface ICivicAddressReportFactory : ILocationReportFactory
{
    HRESULT get_CivicAddressReport(IDispCivicAddressReport* pVal);
}

@GUID("16EE6CB7-AB3C-424B-849F-269BE551FCBC")
interface _ILatLongReportFactoryEvents : IDispatch
{
}

@GUID("C96039FF-72EC-4617-89BD-84D88BEDC722")
interface _ICivicAddressReportFactoryEvents : IDispatch
{
}


// GUIDs

const GUID CLSID_CivicAddressReport        = GUIDOF!CivicAddressReport;
const GUID CLSID_CivicAddressReportFactory = GUIDOF!CivicAddressReportFactory;
const GUID CLSID_DefaultLocation           = GUIDOF!DefaultLocation;
const GUID CLSID_DispCivicAddressReport    = GUIDOF!DispCivicAddressReport;
const GUID CLSID_DispLatLongReport         = GUIDOF!DispLatLongReport;
const GUID CLSID_LatLongReport             = GUIDOF!LatLongReport;
const GUID CLSID_LatLongReportFactory      = GUIDOF!LatLongReportFactory;
const GUID CLSID_Location                  = GUIDOF!Location;

const GUID IID_ICivicAddressReport               = GUIDOF!ICivicAddressReport;
const GUID IID_ICivicAddressReportFactory        = GUIDOF!ICivicAddressReportFactory;
const GUID IID_IDefaultLocation                  = GUIDOF!IDefaultLocation;
const GUID IID_IDispCivicAddressReport           = GUIDOF!IDispCivicAddressReport;
const GUID IID_IDispLatLongReport                = GUIDOF!IDispLatLongReport;
const GUID IID_ILatLongReport                    = GUIDOF!ILatLongReport;
const GUID IID_ILatLongReportFactory             = GUIDOF!ILatLongReportFactory;
const GUID IID_ILocation                         = GUIDOF!ILocation;
const GUID IID_ILocationEvents                   = GUIDOF!ILocationEvents;
const GUID IID_ILocationPower                    = GUIDOF!ILocationPower;
const GUID IID_ILocationReport                   = GUIDOF!ILocationReport;
const GUID IID_ILocationReportFactory            = GUIDOF!ILocationReportFactory;
const GUID IID__ICivicAddressReportFactoryEvents = GUIDOF!_ICivicAddressReportFactoryEvents;
const GUID IID__ILatLongReportFactoryEvents      = GUIDOF!_ILatLongReportFactoryEvents;
