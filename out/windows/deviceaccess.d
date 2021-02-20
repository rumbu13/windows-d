// Written in the D programming language.

module windows.deviceaccess;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : PWSTR;

extern(Windows) @nogc nothrow:


// Constants


enum GUID CLSID_DeviceIoControl = GUID("12d3e372-874b-457d-9fdf-73977778686c");

// Functions

///Creates the object that's used to access a device. The instantiated object implements the IDeviceIoControl and
///ICreateDeviceAccessAsync interfaces. Conditions (FYI): ``` !defined(__deviceaccess_h__) [-AND-] ((NTDDI_VERSION >=
///NTDDI_WIN8)) [-AND-] defined(__cplusplus) ``` Declaration from header. ``` HRESULT WINAPI CreateDeviceAccessInstance(
///_In_ LPCWSTR deviceInterfacePath, _In_ DWORD desiredAccess, _Outptr_ ICreateDeviceAccessAsync **createAsync ); ```
///Params:
///    deviceInterfacePath = A valid device interface path for the device that this instance should bind to.
///    desiredAccess = The requested level of access to the device, which can be summarized as read, write, both, or neither (zero). The
///                    most commonly used values are <b>GENERIC_READ</b>, <b>GENERIC_WRITE</b>, or both (<b>GENERIC_READ</b> |
///                    <b>GENERIC_WRITE</b>). For more information, see Generic Access Rights, File Security and Access Rights, File
///                    Access Rights Constants, Creating and Opening Files, and ACCESS_MASK.
///    createAsync = Asynchronous interface to control binding for this instance. For more information, see ICreateDeviceAccessAsync.
@DllImport("deviceaccess")
HRESULT CreateDeviceAccessInstance(const(PWSTR) deviceInterfacePath, uint desiredAccess, 
                                   ICreateDeviceAccessAsync* createAsync);


// Interfaces

///Provides a method to handle the completion of calls to the DeviceIoControlAsyncmethod.
@GUID("999BAD24-9ACD-45BB-8669-2A2FC0288B04")
interface IDeviceRequestCompletionCallback : IUnknown
{
    HRESULT Invoke(HRESULT requestResult, uint bytesReturned);
}

///Sends a control code to a device driver.This action causes the device to perform the corresponding operation.
@GUID("9EEFE161-23AB-4F18-9B49-991B586AE970")
interface IDeviceIoControl : IUnknown
{
    ///The <b>DeviceIoControlSync</b> method sends a synchronous device input/output (I/O) control request to the device
    ///interface that the call to the CreateDeviceAccessInstance function specified.
    ///Params:
    ///    ioControlCode = The I/O control code for the operation.
    ///    inputBuffer = An optional input buffer for the operation.
    ///    inputBufferSize = The size of input buffer, in bytes.
    ///    outputBuffer = An optional output buffer for the operation.
    ///    outputBufferSize = The size of output buffer, in bytes.
    ///    bytesReturned = A pointer to a variable that receives the number of bytes that were written into the output buffer, if one
    ///                    was specified.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeviceIoControlSync(uint ioControlCode, ubyte* inputBuffer, uint inputBufferSize, ubyte* outputBuffer, 
                                uint outputBufferSize, uint* bytesReturned);
    ///The <b>DeviceIoControlAsync</b> method sends an asynchronous device input/output (I/O) control request to the
    ///device interface that the call to the CreateDeviceAccessInstance function specified.
    ///Params:
    ///    ioControlCode = The I/O control code for the operation.
    ///    inputBuffer = An optional input buffer for the operation.
    ///    inputBufferSize = The size of input buffer, in bytes.
    ///    outputBuffer = An operational output buffer for the operation.
    ///    outputBufferSize = The size of output buffer, in bytes.
    ///    requestCompletionCallback = The callback interface on which the RequestCompletion method is called if the operation is submitted
    ///                                successfully.
    ///    cancelContext = An optional pointer that receives a cancel context that can be passed to the CancelOperationmethod to cancel
    ///                    an outstanding request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeviceIoControlAsync(uint ioControlCode, ubyte* inputBuffer, uint inputBufferSize, ubyte* outputBuffer, 
                                 uint outputBufferSize, IDeviceRequestCompletionCallback requestCompletionCallback, 
                                 size_t* cancelContext);
    ///The <b>CancelOperation</b> method attempts to cancel a previously issued call by using the DeviceIoControlAsync
    ///method.
    ///Params:
    ///    cancelContext = The cancel context that a previous call to DeviceIoControlAsync returned.
    ///Returns:
    ///    This method supports standard return values, in addition to these: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was still outstanding, and cancellation was attempted. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The operation was no longer outstanding. </td>
    ///    </tr> </table>
    ///    
    HRESULT CancelOperation(size_t cancelContext);
}

///The <b>ICreateDeviceAccessAsync</b> interface is returned from a call to CreateDeviceAccessInstance. It enables the
///caller to control the operation of binding to an instance of a device in order to retrieve another interface that can
///be used to interact with that device.
@GUID("3474628F-683D-42D2-ABCB-DB018C6503BC")
interface ICreateDeviceAccessAsync : IUnknown
{
    ///The <b>Cancel</b> method attempts to cancel an asynchronous operation that is in progress.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Cancel();
    ///The <b>Wait</b> method waits a specified length of time for an asynchronous bind operation that is in progress to
    ///finish.
    ///Params:
    ///    timeout = Timeout value, in milliseconds, for the wait call. Use <b>INFINITE</b> if you want the caller to wait until
    ///              the operation finishes.
    ///Returns:
    ///    This method supports standard return values, in addition to these: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    wait was successful and the operation finished. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The wait timed out before the operation finished.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ILLEGAL_METHOD_CALL</b></dt> </dl> </td> <td width="60%"> The
    ///    operation has already closed when this method was called. </td> </tr> </table>
    ///    
    HRESULT Wait(uint timeout);
    ///The <b>Close</b> method performs cleanup after the asynchronous operation is completed and you retrieve the
    ///results.
    ///Returns:
    ///    This method supports standard return values, in addition to these: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    property value was retrieved successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ILLEGAL_METHOD_CALL</b></dt> </dl> </td> <td width="60%"> The operation did not finish. </td> </tr>
    ///    </table>
    ///    
    HRESULT Close();
    ///Retrieves an IDeviceIoControl object that's bound to the device interface that's specified in a call to the
    ///CreateDeviceAccessInstance function.
    ///Params:
    ///    riid = An interface identifier that indicates what type of device access interface the caller wants to retrieve. The
    ///           only valid value for this identifier is IID_IDeviceIoControl.
    ///    deviceAccess = If the binding was successful, contains an interface of the type that was supplied to the initial call to
    ///                   CreateDeviceAccessInstance.
    ///Returns:
    ///    This method supports standard return values, in addition to these: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    binding was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ILLEGAL_METHOD_CALL</b></dt> </dl>
    ///    </td> <td width="60%"> The asynchronous operation wasn't in a valid state. The bind operation was either
    ///    still in progress or not yet started. </td> </tr> </table>
    ///    
    HRESULT GetResult(const(GUID)* riid, void** deviceAccess);
}


// GUIDs


const GUID IID_ICreateDeviceAccessAsync         = GUIDOF!ICreateDeviceAccessAsync;
const GUID IID_IDeviceIoControl                 = GUIDOF!IDeviceIoControl;
const GUID IID_IDeviceRequestCompletionCallback = GUIDOF!IDeviceRequestCompletionCallback;
