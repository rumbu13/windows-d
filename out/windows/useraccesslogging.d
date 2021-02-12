module windows.useraccesslogging;

public import system;
public import windows.com;
public import windows.networkdrivers;
public import windows.systemservices;
public import windows.textservices;

extern(Windows):

const GUID IID_IEnumSpeechCommands = {0x8C5DAC4F, 0x083C, 0x4B85, [0xA4, 0xC9, 0x71, 0x74, 0x60, 0x48, 0xAD, 0xCA]};
@GUID(0x8C5DAC4F, 0x083C, 0x4B85, [0xA4, 0xC9, 0x71, 0x74, 0x60, 0x48, 0xAD, 0xCA]);
interface IEnumSpeechCommands : IUnknown
{
    HRESULT Clone(IEnumSpeechCommands* ppEnum);
    HRESULT Next(uint ulCount, char* pSpCmds, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ISpeechCommandProvider = {0x38E09D4C, 0x586D, 0x435A, [0xB5, 0x92, 0xC8, 0xA8, 0x66, 0x91, 0xDE, 0xC6]};
@GUID(0x38E09D4C, 0x586D, 0x435A, [0xB5, 0x92, 0xC8, 0xA8, 0x66, 0x91, 0xDE, 0xC6]);
interface ISpeechCommandProvider : IUnknown
{
    HRESULT EnumSpeechCommands(ushort langid, IEnumSpeechCommands* ppEnum);
    HRESULT ProcessCommand(const(wchar)* pszCommand, uint cch, ushort langid);
}

const GUID IID_ITfFnCustomSpeechCommand = {0xFCA6C349, 0xA12F, 0x43A3, [0x8D, 0xD6, 0x5A, 0x5A, 0x42, 0x82, 0x57, 0x7B]};
@GUID(0xFCA6C349, 0xA12F, 0x43A3, [0x8D, 0xD6, 0x5A, 0x5A, 0x42, 0x82, 0x57, 0x7B]);
interface ITfFnCustomSpeechCommand : ITfFunction
{
    HRESULT SetSpeechCommandProvider(IUnknown pspcmdProvider);
}

@DllImport("MsCtfMonitor.dll")
BOOL DoMsCtfMonitor(uint dwFlags, HANDLE hEventForServiceStop);

@DllImport("ualapi.dll")
HRESULT UalStart(UAL_DATA_BLOB* Data);

@DllImport("ualapi.dll")
HRESULT UalStop(UAL_DATA_BLOB* Data);

@DllImport("ualapi.dll")
HRESULT UalInstrument(UAL_DATA_BLOB* Data);

@DllImport("ualapi.dll")
HRESULT UalRegisterProduct(const(wchar)* wszProductName, const(wchar)* wszRoleName, const(wchar)* wszGuid);

struct UAL_DATA_BLOB
{
    uint Size;
    Guid RoleGuid;
    Guid TenantId;
    SOCKADDR_STORAGE_LH Address;
    ushort UserName;
}

