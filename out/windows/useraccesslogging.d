// Written in the D programming language.

module windows.useraccesslogging;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.networkdrivers : SOCKADDR_STORAGE_LH;
public import windows.systemservices : BOOL, HANDLE;
public import windows.textservices : ITfFunction;

extern(Windows):


// Structs


///Specifies information about a User Access Logging (UAL) session.
struct UAL_DATA_BLOB
{
    ///The size, in bytes, of this structure.
    uint                Size;
    ///A GUID structure that represents the role or minor product name associated with a UAL session.
    GUID                RoleGuid;
    ///A GUID structure that identifies a tenant of a hosted environment. This can be used to differentiate client
    ///tenants when more than one tenant uses the same host service.
    GUID                TenantId;
    ///The IP address of the client that accompanies the UAL payload from installed roles and products.
    SOCKADDR_STORAGE_LH Address;
    ///The name of the client user that accompanies the UAL payload from installed roles and products..
    ushort[260]         UserName;
}

// Functions

@DllImport("MsCtfMonitor")
BOOL DoMsCtfMonitor(uint dwFlags, HANDLE hEventForServiceStop);

///Starts a User Access Logging (UAL) session.
///Params:
///    Data = A pointer to an UAL_DATA_BLOB structure that specifies session information. Only the <b>RoleGuid</b> property of
///           the UAL_DATA_BLOB structure is required. All other members can be null.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If it fails, it returns an error code.
///    
@DllImport("ualapi")
HRESULT UalStart(UAL_DATA_BLOB* Data);

///Stops a User Access Logging (UAL) session.
///Params:
///    Data = A pointer to an UAL_DATA_BLOB structure that specifies session information. Only the <b>RoleGuid</b> property of
///           the UAL_DATA_BLOB structure is required. All other members can be null.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If it fails, it returns an error code.
///    
@DllImport("ualapi")
HRESULT UalStop(UAL_DATA_BLOB* Data);

///Records the specified data to the User Access Logging (UAL) framework by using information from a UAL_DATA_BLOB
///structure. You must call the UalStart function before calling the <b>UalInstrument</b> function. When you have
///finished calling this function, call the UalStop function to clean up resources.
///Params:
///    Data = A pointer to a UAL_DATA_BLOB structure that specifies session information.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If it fails, it returns an error code.
///    
@DllImport("ualapi")
HRESULT UalInstrument(UAL_DATA_BLOB* Data);

///Registers a product with User Access Logging (UAL).
///Params:
///    wszProductName = The name of the major product to register with UAL. For example, "Windows Server".
///    wszRoleName = The name of the role or minor product within the major product to be registered with UAL. For example, "DHCP".
///    wszGuid = The GUID associated with the role specified by the <i>wszRoleName</i> parameter.
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
