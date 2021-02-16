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

extern(Windows):


// Enums


enum : int
{
    REPORT_NOT_SUPPORTED = 0x00000000,
    REPORT_ERROR         = 0x00000001,
    REPORT_ACCESS_DENIED = 0x00000002,
    REPORT_INITIALIZING  = 0x00000003,
    REPORT_RUNNING       = 0x00000004,
}
alias LOCATION_REPORT_STATUS = int;

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

@GUID("C8B7F7EE-75D0-4DB9-B62D-7A0F369CA456")
interface ILocationReport : IUnknown
{
    HRESULT GetSensorID(GUID* pSensorID);
    HRESULT GetTimestamp(SYSTEMTIME* pCreationTime);
    HRESULT GetValue(const(PROPERTYKEY)* pKey, PROPVARIANT* pValue);
}

@GUID("7FED806D-0EF8-4F07-80AC-36A0BEAE3134")
interface ILatLongReport : ILocationReport
{
    HRESULT GetLatitude(double* pLatitude);
    HRESULT GetLongitude(double* pLongitude);
    HRESULT GetErrorRadius(double* pErrorRadius);
    HRESULT GetAltitude(double* pAltitude);
    HRESULT GetAltitudeError(double* pAltitudeError);
}

@GUID("C0B19F70-4ADF-445D-87F2-CAD8FD711792")
interface ICivicAddressReport : ILocationReport
{
    HRESULT GetAddressLine1(BSTR* pbstrAddress1);
    HRESULT GetAddressLine2(BSTR* pbstrAddress2);
    HRESULT GetCity(BSTR* pbstrCity);
    HRESULT GetStateProvince(BSTR* pbstrStateProvince);
    HRESULT GetPostalCode(BSTR* pbstrPostalCode);
    HRESULT GetCountryRegion(BSTR* pbstrCountryRegion);
    HRESULT GetDetailLevel(uint* pDetailLevel);
}

@GUID("AB2ECE69-56D9-4F28-B525-DE1B0EE44237")
interface ILocation : IUnknown
{
    HRESULT RegisterForReport(ILocationEvents pEvents, const(GUID)* reportType, uint dwRequestedReportInterval);
    HRESULT UnregisterForReport(const(GUID)* reportType);
    HRESULT GetReport(const(GUID)* reportType, ILocationReport* ppLocationReport);
    HRESULT GetReportStatus(const(GUID)* reportType, LOCATION_REPORT_STATUS* pStatus);
    HRESULT GetReportInterval(const(GUID)* reportType, uint* pMilliseconds);
    HRESULT SetReportInterval(const(GUID)* reportType, uint millisecondsRequested);
    HRESULT GetDesiredAccuracy(const(GUID)* reportType, LOCATION_DESIRED_ACCURACY* pDesiredAccuracy);
    HRESULT SetDesiredAccuracy(const(GUID)* reportType, LOCATION_DESIRED_ACCURACY desiredAccuracy);
    HRESULT RequestPermissions(HWND hParent, char* pReportTypes, uint count, BOOL fModal);
}

@GUID("193E7729-AB6B-4B12-8617-7596E1BB191C")
interface ILocationPower : IUnknown
{
    HRESULT Connect();
    HRESULT Disconnect();
}

@GUID("A65AF77E-969A-4A2E-8ACA-33BB7CBB1235")
interface IDefaultLocation : IUnknown
{
    HRESULT SetReport(const(GUID)* reportType, ILocationReport pLocationReport);
    HRESULT GetReport(const(GUID)* reportType, ILocationReport* ppLocationReport);
}

@GUID("CAE02BBF-798B-4508-A207-35A7906DC73D")
interface ILocationEvents : IUnknown
{
    HRESULT OnLocationChanged(const(GUID)* reportType, ILocationReport pLocationReport);
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
