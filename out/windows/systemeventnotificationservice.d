module windows.systemeventnotificationservice;

public import windows.automation;
public import windows.com;
public import windows.systemservices;

extern(Windows):

struct QOCINFO
{
    uint dwSize;
    uint dwFlags;
    uint dwInSpeed;
    uint dwOutSpeed;
}

const GUID CLSID_SENS = {0xD597CAFE, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]};
@GUID(0xD597CAFE, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]);
struct SENS;

struct SENS_QOCINFO
{
    uint dwSize;
    uint dwFlags;
    uint dwOutSpeed;
    uint dwInSpeed;
}

const GUID IID_ISensNetwork = {0xD597BAB1, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]};
@GUID(0xD597BAB1, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]);
interface ISensNetwork : IDispatch
{
    HRESULT ConnectionMade(BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    HRESULT ConnectionMadeNoQOCInfo(BSTR bstrConnection, uint ulType);
    HRESULT ConnectionLost(BSTR bstrConnection, uint ulType);
    HRESULT DestinationReachable(BSTR bstrDestination, BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    HRESULT DestinationReachableNoQOCInfo(BSTR bstrDestination, BSTR bstrConnection, uint ulType);
}

const GUID IID_ISensOnNow = {0xD597BAB2, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]};
@GUID(0xD597BAB2, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]);
interface ISensOnNow : IDispatch
{
    HRESULT OnACPower();
    HRESULT OnBatteryPower(uint dwBatteryLifePercent);
    HRESULT BatteryLow(uint dwBatteryLifePercent);
}

const GUID IID_ISensLogon = {0xD597BAB3, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]};
@GUID(0xD597BAB3, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]);
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

const GUID IID_ISensLogon2 = {0xD597BAB4, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]};
@GUID(0xD597BAB4, 0x5B9F, 0x11D1, [0x8D, 0xD2, 0x00, 0xAA, 0x00, 0x4A, 0xBD, 0x5E]);
interface ISensLogon2 : IDispatch
{
    HRESULT Logon(BSTR bstrUserName, uint dwSessionId);
    HRESULT Logoff(BSTR bstrUserName, uint dwSessionId);
    HRESULT SessionDisconnect(BSTR bstrUserName, uint dwSessionId);
    HRESULT SessionReconnect(BSTR bstrUserName, uint dwSessionId);
    HRESULT PostShell(BSTR bstrUserName, uint dwSessionId);
}

@DllImport("SensApi.dll")
BOOL IsDestinationReachableA(const(char)* lpszDestination, QOCINFO* lpQOCInfo);

@DllImport("SensApi.dll")
BOOL IsDestinationReachableW(const(wchar)* lpszDestination, QOCINFO* lpQOCInfo);

@DllImport("SensApi.dll")
BOOL IsNetworkAlive(uint* lpdwFlags);

