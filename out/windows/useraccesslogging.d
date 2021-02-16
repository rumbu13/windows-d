module windows.useraccesslogging;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.networkdrivers : SOCKADDR_STORAGE_LH;
public import windows.systemservices : BOOL, HANDLE;
public import windows.textservices : ITfFunction;

extern(Windows):


// Structs


struct UAL_DATA_BLOB
{
    uint                Size;
    GUID                RoleGuid;
    GUID                TenantId;
    SOCKADDR_STORAGE_LH Address;
    ushort[260]         UserName;
}

// Functions

@DllImport("MsCtfMonitor")
BOOL DoMsCtfMonitor(uint dwFlags, HANDLE hEventForServiceStop);

@DllImport("ualapi")
HRESULT UalStart(UAL_DATA_BLOB* Data);

@DllImport("ualapi")
HRESULT UalStop(UAL_DATA_BLOB* Data);

@DllImport("ualapi")
HRESULT UalInstrument(UAL_DATA_BLOB* Data);

@DllImport("ualapi")
HRESULT UalRegisterProduct(const(wchar)* wszProductName, const(wchar)* wszRoleName, const(wchar)* wszGuid);


// Interfaces

@GUID("8C5DAC4F-083C-4B85-A4C9-71746048ADCA")
interface IEnumSpeechCommands : IUnknown
{
    HRESULT Clone(IEnumSpeechCommands* ppEnum);
    HRESULT Next(uint ulCount, char* pSpCmds, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("38E09D4C-586D-435A-B592-C8A86691DEC6")
interface ISpeechCommandProvider : IUnknown
{
    HRESULT EnumSpeechCommands(ushort langid, IEnumSpeechCommands* ppEnum);
    HRESULT ProcessCommand(const(wchar)* pszCommand, uint cch, ushort langid);
}

@GUID("FCA6C349-A12F-43A3-8DD6-5A5A4282577B")
interface ITfFnCustomSpeechCommand : ITfFunction
{
    HRESULT SetSpeechCommandProvider(IUnknown pspcmdProvider);
}


// GUIDs


const GUID IID_IEnumSpeechCommands      = GUIDOF!IEnumSpeechCommands;
const GUID IID_ISpeechCommandProvider   = GUIDOF!ISpeechCommandProvider;
const GUID IID_ITfFnCustomSpeechCommand = GUIDOF!ITfFnCustomSpeechCommand;
