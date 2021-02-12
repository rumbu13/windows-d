module windows.deviceaccess;

public import system;
public import windows.com;

extern(Windows):

const GUID IID_IDeviceRequestCompletionCallback = {0x999BAD24, 0x9ACD, 0x45BB, [0x86, 0x69, 0x2A, 0x2F, 0xC0, 0x28, 0x8B, 0x04]};
@GUID(0x999BAD24, 0x9ACD, 0x45BB, [0x86, 0x69, 0x2A, 0x2F, 0xC0, 0x28, 0x8B, 0x04]);
interface IDeviceRequestCompletionCallback : IUnknown
{
    HRESULT Invoke(HRESULT requestResult, uint bytesReturned);
}

const GUID IID_IDeviceIoControl = {0x9EEFE161, 0x23AB, 0x4F18, [0x9B, 0x49, 0x99, 0x1B, 0x58, 0x6A, 0xE9, 0x70]};
@GUID(0x9EEFE161, 0x23AB, 0x4F18, [0x9B, 0x49, 0x99, 0x1B, 0x58, 0x6A, 0xE9, 0x70]);
interface IDeviceIoControl : IUnknown
{
    HRESULT DeviceIoControlSync(uint ioControlCode, char* inputBuffer, uint inputBufferSize, char* outputBuffer, uint outputBufferSize, uint* bytesReturned);
    HRESULT DeviceIoControlAsync(uint ioControlCode, char* inputBuffer, uint inputBufferSize, char* outputBuffer, uint outputBufferSize, IDeviceRequestCompletionCallback requestCompletionCallback, uint* cancelContext);
    HRESULT CancelOperation(uint cancelContext);
}

const GUID IID_ICreateDeviceAccessAsync = {0x3474628F, 0x683D, 0x42D2, [0xAB, 0xCB, 0xDB, 0x01, 0x8C, 0x65, 0x03, 0xBC]};
@GUID(0x3474628F, 0x683D, 0x42D2, [0xAB, 0xCB, 0xDB, 0x01, 0x8C, 0x65, 0x03, 0xBC]);
interface ICreateDeviceAccessAsync : IUnknown
{
    HRESULT Cancel();
    HRESULT Wait(uint timeout);
    HRESULT Close();
    HRESULT GetResult(const(Guid)* riid, void** deviceAccess);
}

@DllImport("deviceaccess.dll")
HRESULT CreateDeviceAccessInstance(const(wchar)* deviceInterfacePath, uint desiredAccess, ICreateDeviceAccessAsync* createAsync);

