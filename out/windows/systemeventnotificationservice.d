module windows.systemeventnotificationservice;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL;

extern(Windows):


// Structs


struct QOCINFO
{
    uint dwSize;
    uint dwFlags;
    uint dwInSpeed;
    uint dwOutSpeed;
}

struct SENS_QOCINFO
{
    uint dwSize;
    uint dwFlags;
    uint dwOutSpeed;
    uint dwInSpeed;
}

// Functions

@DllImport("SensApi")
BOOL IsDestinationReachableA(const(char)* lpszDestination, QOCINFO* lpQOCInfo);

@DllImport("SensApi")
BOOL IsDestinationReachableW(const(wchar)* lpszDestination, QOCINFO* lpQOCInfo);

@DllImport("SensApi")
BOOL IsNetworkAlive(uint* lpdwFlags);


// Interfaces

@GUID("D597CAFE-5B9F-11D1-8DD2-00AA004ABD5E")
struct SENS;

@GUID("D597BAB1-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensNetwork : IDispatch
{
    HRESULT ConnectionMade(BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    HRESULT ConnectionMadeNoQOCInfo(BSTR bstrConnection, uint ulType);
    HRESULT ConnectionLost(BSTR bstrConnection, uint ulType);
    HRESULT DestinationReachable(BSTR bstrDestination, BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    HRESULT DestinationReachableNoQOCInfo(BSTR bstrDestination, BSTR bstrConnection, uint ulType);
}

@GUID("D597BAB2-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensOnNow : IDispatch
{
    HRESULT OnACPower();
    HRESULT OnBatteryPower(uint dwBatteryLifePercent);
    HRESULT BatteryLow(uint dwBatteryLifePercent);
}

@GUID("D597BAB3-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensLogon : IDispatch
{
    HRESULT Logon(BSTR bstrUserName);
    HRESULT Logoff(BSTR bstrUserName);
    HRESULT StartShell(BSTR bstrUserName);
    HRESULT DisplayLock(BSTR bstrUserName);
    HRESULT DisplayUnlock(BSTR bstrUserName);
    HRESULT StartScreenSaver(BSTR bstrUserName);
    HRESULT StopScreenSaver(BSTR bstrUserName);
}

@GUID("D597BAB4-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensLogon2 : IDispatch
{
    HRESULT Logon(BSTR bstrUserName, uint dwSessionId);
    HRESULT Logoff(BSTR bstrUserName, uint dwSessionId);
    HRESULT SessionDisconnect(BSTR bstrUserName, uint dwSessionId);
    HRESULT SessionReconnect(BSTR bstrUserName, uint dwSessionId);
    HRESULT PostShell(BSTR bstrUserName, uint dwSessionId);
}


// GUIDs

const GUID CLSID_SENS = GUIDOF!SENS;

const GUID IID_ISensLogon   = GUIDOF!ISensLogon;
const GUID IID_ISensLogon2  = GUIDOF!ISensLogon2;
const GUID IID_ISensNetwork = GUIDOF!ISensNetwork;
const GUID IID_ISensOnNow   = GUIDOF!ISensOnNow;
