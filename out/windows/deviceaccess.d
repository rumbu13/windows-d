module windows.deviceaccess;

public import windows.core;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Functions

@DllImport("deviceaccess")
HRESULT CreateDeviceAccessInstance(const(wchar)* deviceInterfacePath, uint desiredAccess, 
                                   ICreateDeviceAccessAsync* createAsync);


// Interfaces

@GUID("999BAD24-9ACD-45BB-8669-2A2FC0288B04")
interface IDeviceRequestCompletionCallback : IUnknown
{
    HRESULT Invoke(HRESULT requestResult, uint bytesReturned);
}

@GUID("9EEFE161-23AB-4F18-9B49-991B586AE970")
interface IDeviceIoControl : IUnknown
{
    HRESULT DeviceIoControlSync(uint ioControlCode, char* inputBuffer, uint inputBufferSize, char* outputBuffer, 
                                uint outputBufferSize, uint* bytesReturned);
    HRESULT DeviceIoControlAsync(uint ioControlCode, char* inputBuffer, uint inputBufferSize, char* outputBuffer, 
                                 uint outputBufferSize, IDeviceRequestCompletionCallback requestCompletionCallback, 
                                 size_t* cancelContext);
    HRESULT CancelOperation(size_t cancelContext);
}

@GUID("3474628F-683D-42D2-ABCB-DB018C6503BC")
interface ICreateDeviceAccessAsync : IUnknown
{
    HRESULT Cancel();
    HRESULT Wait(uint timeout);
    HRESULT Close();
    HRESULT GetResult(const(GUID)* riid, void** deviceAccess);
}


// GUIDs


const GUID IID_ICreateDeviceAccessAsync         = GUIDOF!ICreateDeviceAccessAsync;
const GUID IID_IDeviceIoControl                 = GUIDOF!IDeviceIoControl;
const GUID IID_IDeviceRequestCompletionCallback = GUIDOF!IDeviceRequestCompletionCallback;
