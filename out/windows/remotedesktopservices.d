module windows.remotedesktopservices;

public import system;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.multimedia;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

alias HwtsVirtualChannelHandle = int;
enum APO_BUFFER_FLAGS
{
    BUFFER_INVALID = 0,
    BUFFER_VALID = 1,
    BUFFER_SILENT = 2,
}

struct APO_CONNECTION_PROPERTY
{
    uint pBuffer;
    uint u32ValidFrameCount;
    APO_BUFFER_FLAGS u32BufferFlags;
    uint u32Signature;
}

enum AE_POSITION_FLAGS
{
    POSITION_INVALID = 0,
    POSITION_DISCONTINUOUS = 1,
    POSITION_CONTINUOUS = 2,
    POSITION_QPC_ERROR = 4,
}

struct AE_CURRENT_POSITION
{
    ulong u64DevicePosition;
    ulong u64StreamPosition;
    ulong u64PaddingFrames;
    long hnsQPCPosition;
    float f32FramesPerSecond;
    AE_POSITION_FLAGS Flag;
}

const GUID IID_IAudioEndpoint = {0x30A99515, 0x1527, 0x4451, [0xAF, 0x9F, 0x00, 0xC5, 0xF0, 0x23, 0x4D, 0xAF]};
@GUID(0x30A99515, 0x1527, 0x4451, [0xAF, 0x9F, 0x00, 0xC5, 0xF0, 0x23, 0x4D, 0xAF]);
interface IAudioEndpoint : IUnknown
{
    HRESULT GetFrameFormat(WAVEFORMATEX** ppFormat);
    HRESULT GetFramesPerPacket(uint* pFramesPerPacket);
    HRESULT GetLatency(long* pLatency);
    HRESULT SetStreamFlags(uint streamFlags);
    HRESULT SetEventHandle(HANDLE eventHandle);
}

const GUID IID_IAudioEndpointRT = {0xDFD2005F, 0xA6E5, 0x4D39, [0xA2, 0x65, 0x93, 0x9A, 0xDA, 0x9F, 0xBB, 0x4D]};
@GUID(0xDFD2005F, 0xA6E5, 0x4D39, [0xA2, 0x65, 0x93, 0x9A, 0xDA, 0x9F, 0xBB, 0x4D]);
interface IAudioEndpointRT : IUnknown
{
    void GetCurrentPadding(long* pPadding, AE_CURRENT_POSITION* pAeCurrentPosition);
    void ProcessingComplete();
    HRESULT SetPinInactive();
    HRESULT SetPinActive();
}

const GUID IID_IAudioInputEndpointRT = {0x8026AB61, 0x92B2, 0x43C1, [0xA1, 0xDF, 0x5C, 0x37, 0xEB, 0xD0, 0x8D, 0x82]};
@GUID(0x8026AB61, 0x92B2, 0x43C1, [0xA1, 0xDF, 0x5C, 0x37, 0xEB, 0xD0, 0x8D, 0x82]);
interface IAudioInputEndpointRT : IUnknown
{
    void GetInputDataPointer(APO_CONNECTION_PROPERTY* pConnectionProperty, AE_CURRENT_POSITION* pAeTimeStamp);
    void ReleaseInputDataPointer(uint u32FrameCount, uint pDataPointer);
    void PulseEndpoint();
}

const GUID IID_IAudioOutputEndpointRT = {0x8FA906E4, 0xC31C, 0x4E31, [0x93, 0x2E, 0x19, 0xA6, 0x63, 0x85, 0xE9, 0xAA]};
@GUID(0x8FA906E4, 0xC31C, 0x4E31, [0x93, 0x2E, 0x19, 0xA6, 0x63, 0x85, 0xE9, 0xAA]);
interface IAudioOutputEndpointRT : IUnknown
{
    uint GetOutputDataPointer(uint u32FrameCount, AE_CURRENT_POSITION* pAeTimeStamp);
    void ReleaseOutputDataPointer(const(APO_CONNECTION_PROPERTY)* pConnectionProperty);
    void PulseEndpoint();
}

const GUID IID_IAudioDeviceEndpoint = {0xD4952F5A, 0xA0B2, 0x4CC4, [0x8B, 0x82, 0x93, 0x58, 0x48, 0x8D, 0xD8, 0xAC]};
@GUID(0xD4952F5A, 0xA0B2, 0x4CC4, [0x8B, 0x82, 0x93, 0x58, 0x48, 0x8D, 0xD8, 0xAC]);
interface IAudioDeviceEndpoint : IUnknown
{
    HRESULT SetBuffer(long MaxPeriod, uint u32LatencyCoefficient);
    HRESULT GetRTCaps(int* pbIsRTCapable);
    HRESULT GetEventDrivenCapable(int* pbisEventCapable);
    HRESULT WriteExclusiveModeParametersToSharedMemory(uint hTargetProcess, long hnsPeriod, long hnsBufferDuration, uint u32LatencyCoefficient, uint* pu32SharedMemorySize, uint* phSharedMemory);
}

const GUID IID_IAudioEndpointControl = {0xC684B72A, 0x6DF4, 0x4774, [0xBD, 0xF9, 0x76, 0xB7, 0x75, 0x09, 0xB6, 0x53]};
@GUID(0xC684B72A, 0x6DF4, 0x4774, [0xBD, 0xF9, 0x76, 0xB7, 0x75, 0x09, 0xB6, 0x53]);
interface IAudioEndpointControl : IUnknown
{
    HRESULT Start();
    HRESULT Reset();
    HRESULT Stop();
}

struct WTSSESSION_NOTIFICATION
{
    uint cbSize;
    uint dwSessionId;
}

@DllImport("KERNEL32.dll")
BOOL ProcessIdToSessionId(uint dwProcessId, uint* pSessionId);

@DllImport("KERNEL32.dll")
uint WTSGetActiveConsoleSessionId();

@DllImport("WTSAPI32.dll")
BOOL WTSStopRemoteControlSession(uint LogonId);

@DllImport("WTSAPI32.dll")
BOOL WTSStartRemoteControlSessionW(const(wchar)* pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, ushort HotkeyModifiers);

@DllImport("WTSAPI32.dll")
BOOL WTSStartRemoteControlSessionA(const(char)* pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, ushort HotkeyModifiers);

@DllImport("WTSAPI32.dll")
BOOL WTSConnectSessionA(uint LogonId, uint TargetLogonId, const(char)* pPassword, BOOL bWait);

@DllImport("WTSAPI32.dll")
BOOL WTSConnectSessionW(uint LogonId, uint TargetLogonId, const(wchar)* pPassword, BOOL bWait);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateServersW(const(wchar)* pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOW** ppServerInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateServersA(const(char)* pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOA** ppServerInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerW(const(wchar)* pServerName);

@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerA(const(char)* pServerName);

@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerExW(const(wchar)* pServerName);

@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerExA(const(char)* pServerName);

@DllImport("WTSAPI32.dll")
void WTSCloseServer(HANDLE hServer);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsW(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOW** ppSessionInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsA(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOA** ppSessionInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsExW(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1W** ppSessionInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsExA(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1A** ppSessionInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesW(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOW** ppProcessInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesA(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOA** ppProcessInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSTerminateProcess(HANDLE hServer, uint ProcessId, uint ExitCode);

@DllImport("WTSAPI32.dll")
BOOL WTSQuerySessionInformationW(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, ushort** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32.dll")
BOOL WTSQuerySessionInformationA(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, byte** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32.dll")
BOOL WTSQueryUserConfigW(const(wchar)* pServerName, const(wchar)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, ushort** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32.dll")
BOOL WTSQueryUserConfigA(const(char)* pServerName, const(char)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, byte** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32.dll")
BOOL WTSSetUserConfigW(const(wchar)* pServerName, const(wchar)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, const(wchar)* pBuffer, uint DataLength);

@DllImport("WTSAPI32.dll")
BOOL WTSSetUserConfigA(const(char)* pServerName, const(char)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, const(char)* pBuffer, uint DataLength);

@DllImport("WTSAPI32.dll")
BOOL WTSSendMessageW(HANDLE hServer, uint SessionId, const(wchar)* pTitle, uint TitleLength, const(wchar)* pMessage, uint MessageLength, uint Style, uint Timeout, uint* pResponse, BOOL bWait);

@DllImport("WTSAPI32.dll")
BOOL WTSSendMessageA(HANDLE hServer, uint SessionId, const(char)* pTitle, uint TitleLength, const(char)* pMessage, uint MessageLength, uint Style, uint Timeout, uint* pResponse, BOOL bWait);

@DllImport("WTSAPI32.dll")
BOOL WTSDisconnectSession(HANDLE hServer, uint SessionId, BOOL bWait);

@DllImport("WTSAPI32.dll")
BOOL WTSLogoffSession(HANDLE hServer, uint SessionId, BOOL bWait);

@DllImport("WTSAPI32.dll")
BOOL WTSShutdownSystem(HANDLE hServer, uint ShutdownFlag);

@DllImport("WTSAPI32.dll")
BOOL WTSWaitSystemEvent(HANDLE hServer, uint EventMask, uint* pEventFlags);

@DllImport("WTSAPI32.dll")
HwtsVirtualChannelHandle WTSVirtualChannelOpen(HANDLE hServer, uint SessionId, const(char)* pVirtualName);

@DllImport("WTSAPI32.dll")
HwtsVirtualChannelHandle WTSVirtualChannelOpenEx(uint SessionId, const(char)* pVirtualName, uint flags);

@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelClose(HANDLE hChannelHandle);

@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelRead(HANDLE hChannelHandle, uint TimeOut, const(char)* Buffer, uint BufferSize, uint* pBytesRead);

@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelWrite(HANDLE hChannelHandle, const(char)* Buffer, uint Length, uint* pBytesWritten);

@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelPurgeInput(HANDLE hChannelHandle);

@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelPurgeOutput(HANDLE hChannelHandle);

@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelQuery(HANDLE hChannelHandle, WTS_VIRTUAL_CLASS param1, void** ppBuffer, uint* pBytesReturned);

@DllImport("WTSAPI32.dll")
void WTSFreeMemory(void* pMemory);

@DllImport("WTSAPI32.dll")
BOOL WTSRegisterSessionNotification(HWND hWnd, uint dwFlags);

@DllImport("WTSAPI32.dll")
BOOL WTSUnRegisterSessionNotification(HWND hWnd);

@DllImport("WINSTA.dll")
BOOL WTSRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd, uint dwFlags);

@DllImport("WINSTA.dll")
BOOL WTSUnRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd);

@DllImport("WTSAPI32.dll")
BOOL WTSQueryUserToken(uint SessionId, int* phToken);

@DllImport("WTSAPI32.dll")
BOOL WTSFreeMemoryExW(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

@DllImport("WTSAPI32.dll")
BOOL WTSFreeMemoryExA(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesExW(HANDLE hServer, uint* pLevel, uint SessionId, ushort** ppProcessInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesExA(HANDLE hServer, uint* pLevel, uint SessionId, byte** ppProcessInfo, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateListenersW(HANDLE hServer, void* pReserved, uint Reserved, char* pListeners, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateListenersA(HANDLE hServer, void* pReserved, uint Reserved, char* pListeners, uint* pCount);

@DllImport("WTSAPI32.dll")
BOOL WTSQueryListenerConfigW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, WTSLISTENERCONFIGW* pBuffer);

@DllImport("WTSAPI32.dll")
BOOL WTSQueryListenerConfigA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, WTSLISTENERCONFIGA* pBuffer);

@DllImport("WTSAPI32.dll")
BOOL WTSCreateListenerW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, WTSLISTENERCONFIGW* pBuffer, uint flag);

@DllImport("WTSAPI32.dll")
BOOL WTSCreateListenerA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, WTSLISTENERCONFIGA* pBuffer, uint flag);

@DllImport("WTSAPI32.dll")
BOOL WTSSetListenerSecurityW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("WTSAPI32.dll")
BOOL WTSSetListenerSecurityA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("WTSAPI32.dll")
BOOL WTSGetListenerSecurityW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, uint SecurityInformation, void* pSecurityDescriptor, uint nLength, uint* lpnLengthNeeded);

@DllImport("WTSAPI32.dll")
BOOL WTSGetListenerSecurityA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, uint SecurityInformation, void* pSecurityDescriptor, uint nLength, uint* lpnLengthNeeded);

@DllImport("WTSAPI32.dll")
BOOL WTSEnableChildSessions(BOOL bEnable);

@DllImport("WTSAPI32.dll")
BOOL WTSIsChildSessionsEnabled(int* pbEnabled);

@DllImport("WTSAPI32.dll")
BOOL WTSGetChildSessionId(uint* pSessionId);

@DllImport("WTSAPI32.dll")
HRESULT WTSSetRenderHint(ulong* pRenderHintID, HWND hwndOwner, uint renderHintType, uint cbHintDataLength, char* pHintData);

const GUID CLSID_TSUserExInterfaces = {0x0910DD01, 0xDF8C, 0x11D1, [0xAE, 0x27, 0x00, 0xC0, 0x4F, 0xA3, 0x58, 0x13]};
@GUID(0x0910DD01, 0xDF8C, 0x11D1, [0xAE, 0x27, 0x00, 0xC0, 0x4F, 0xA3, 0x58, 0x13]);
struct TSUserExInterfaces;

const GUID CLSID_ADsTSUserEx = {0xE2E9CAE6, 0x1E7B, 0x4B8E, [0xBA, 0xBD, 0xE9, 0xBF, 0x62, 0x92, 0xAC, 0x29]};
@GUID(0xE2E9CAE6, 0x1E7B, 0x4B8E, [0xBA, 0xBD, 0xE9, 0xBF, 0x62, 0x92, 0xAC, 0x29]);
struct ADsTSUserEx;

const GUID IID_IADsTSUserEx = {0xC4930E79, 0x2989, 0x4462, [0x8A, 0x60, 0x2F, 0xCF, 0x2F, 0x29, 0x55, 0xEF]};
@GUID(0xC4930E79, 0x2989, 0x4462, [0x8A, 0x60, 0x2F, 0xCF, 0x2F, 0x29, 0x55, 0xEF]);
interface IADsTSUserEx : IDispatch
{
    HRESULT get_TerminalServicesProfilePath(BSTR* pVal);
    HRESULT put_TerminalServicesProfilePath(BSTR pNewVal);
    HRESULT get_TerminalServicesHomeDirectory(BSTR* pVal);
    HRESULT put_TerminalServicesHomeDirectory(BSTR pNewVal);
    HRESULT get_TerminalServicesHomeDrive(BSTR* pVal);
    HRESULT put_TerminalServicesHomeDrive(BSTR pNewVal);
    HRESULT get_AllowLogon(int* pVal);
    HRESULT put_AllowLogon(int NewVal);
    HRESULT get_EnableRemoteControl(int* pVal);
    HRESULT put_EnableRemoteControl(int NewVal);
    HRESULT get_MaxDisconnectionTime(int* pVal);
    HRESULT put_MaxDisconnectionTime(int NewVal);
    HRESULT get_MaxConnectionTime(int* pVal);
    HRESULT put_MaxConnectionTime(int NewVal);
    HRESULT get_MaxIdleTime(int* pVal);
    HRESULT put_MaxIdleTime(int NewVal);
    HRESULT get_ReconnectionAction(int* pNewVal);
    HRESULT put_ReconnectionAction(int NewVal);
    HRESULT get_BrokenConnectionAction(int* pNewVal);
    HRESULT put_BrokenConnectionAction(int NewVal);
    HRESULT get_ConnectClientDrivesAtLogon(int* pNewVal);
    HRESULT put_ConnectClientDrivesAtLogon(int NewVal);
    HRESULT get_ConnectClientPrintersAtLogon(int* pVal);
    HRESULT put_ConnectClientPrintersAtLogon(int NewVal);
    HRESULT get_DefaultToMainPrinter(int* pVal);
    HRESULT put_DefaultToMainPrinter(int NewVal);
    HRESULT get_TerminalServicesWorkDirectory(BSTR* pVal);
    HRESULT put_TerminalServicesWorkDirectory(BSTR pNewVal);
    HRESULT get_TerminalServicesInitialProgram(BSTR* pVal);
    HRESULT put_TerminalServicesInitialProgram(BSTR pNewVal);
}

enum AAAuthSchemes
{
    AA_AUTH_MIN = 0,
    AA_AUTH_BASIC = 1,
    AA_AUTH_NTLM = 2,
    AA_AUTH_SC = 3,
    AA_AUTH_LOGGEDONCREDENTIALS = 4,
    AA_AUTH_NEGOTIATE = 5,
    AA_AUTH_ANY = 6,
    AA_AUTH_COOKIE = 7,
    AA_AUTH_DIGEST = 8,
    AA_AUTH_ORGID = 9,
    AA_AUTH_CONID = 10,
    AA_AUTH_SSPI_NTLM = 11,
    AA_AUTH_MAX = 12,
}

enum AAAccountingDataType
{
    AA_MAIN_SESSION_CREATION = 0,
    AA_SUB_SESSION_CREATION = 1,
    AA_SUB_SESSION_CLOSED = 2,
    AA_MAIN_SESSION_CLOSED = 3,
}

struct AAAccountingData
{
    BSTR userName;
    BSTR clientName;
    AAAuthSchemes authType;
    BSTR resourceName;
    int portNumber;
    BSTR protocolName;
    int numberOfBytesReceived;
    int numberOfBytesTransfered;
    BSTR reasonForDisconnect;
    Guid mainSessionId;
    int subSessionId;
}

enum __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0004
{
    SESSION_TIMEOUT_ACTION_DISCONNECT = 0,
    SESSION_TIMEOUT_ACTION_SILENT_REAUTH = 1,
}

enum PolicyAttributeType
{
    EnableAllRedirections = 0,
    DisableAllRedirections = 1,
    DriveRedirectionDisabled = 2,
    PrinterRedirectionDisabled = 3,
    PortRedirectionDisabled = 4,
    ClipboardRedirectionDisabled = 5,
    PnpRedirectionDisabled = 6,
    AllowOnlySDRServers = 7,
}

enum __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0006
{
    AA_UNTRUSTED = 0,
    AA_TRUSTEDUSER_UNTRUSTEDCLIENT = 1,
    AA_TRUSTEDUSER_TRUSTEDCLIENT = 2,
}

const GUID IID_ITSGAuthorizeConnectionSink = {0xC27ECE33, 0x7781, 0x4318, [0x98, 0xEF, 0x1C, 0xF2, 0xDA, 0x7B, 0x70, 0x05]};
@GUID(0xC27ECE33, 0x7781, 0x4318, [0x98, 0xEF, 0x1C, 0xF2, 0xDA, 0x7B, 0x70, 0x05]);
interface ITSGAuthorizeConnectionSink : IUnknown
{
    HRESULT OnConnectionAuthorized(HRESULT hrIn, Guid mainSessionId, uint cbSoHResponse, char* pbSoHResponse, uint idleTimeout, uint sessionTimeout, __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0004 sessionTimeoutAction, __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0006 trustClass, char* policyAttributes);
}

const GUID IID_ITSGAuthorizeResourceSink = {0xFEDDFCD4, 0xFA12, 0x4435, [0xAE, 0x55, 0x7A, 0xD1, 0xA9, 0x77, 0x9A, 0xF7]};
@GUID(0xFEDDFCD4, 0xFA12, 0x4435, [0xAE, 0x55, 0x7A, 0xD1, 0xA9, 0x77, 0x9A, 0xF7]);
interface ITSGAuthorizeResourceSink : IUnknown
{
    HRESULT OnChannelAuthorized(HRESULT hrIn, Guid mainSessionId, int subSessionId, char* allowedResourceNames, uint numAllowedResourceNames, char* failedResourceNames, uint numFailedResourceNames);
}

const GUID IID_ITSGPolicyEngine = {0x8BC24F08, 0x6223, 0x42F4, [0xA5, 0xB4, 0x8E, 0x37, 0xCD, 0x13, 0x5B, 0xBD]};
@GUID(0x8BC24F08, 0x6223, 0x42F4, [0xA5, 0xB4, 0x8E, 0x37, 0xCD, 0x13, 0x5B, 0xBD]);
interface ITSGPolicyEngine : IUnknown
{
    HRESULT AuthorizeConnection(Guid mainSessionId, BSTR username, AAAuthSchemes authType, BSTR clientMachineIP, BSTR clientMachineName, char* sohData, uint numSOHBytes, char* cookieData, uint numCookieBytes, uint userToken, ITSGAuthorizeConnectionSink pSink);
    HRESULT AuthorizeResource(Guid mainSessionId, int subSessionId, BSTR username, char* resourceNames, uint numResources, char* alternateResourceNames, uint numAlternateResourceName, uint portNumber, BSTR operation, char* cookie, uint numBytesInCookie, ITSGAuthorizeResourceSink pSink);
    HRESULT Refresh();
    HRESULT IsQuarantineEnabled(int* quarantineEnabled);
}

const GUID IID_ITSGAccountingEngine = {0x4CE2A0C9, 0xE874, 0x4F1A, [0x86, 0xF4, 0x06, 0xBB, 0xB9, 0x11, 0x53, 0x38]};
@GUID(0x4CE2A0C9, 0xE874, 0x4F1A, [0x86, 0xF4, 0x06, 0xBB, 0xB9, 0x11, 0x53, 0x38]);
interface ITSGAccountingEngine : IUnknown
{
    HRESULT DoAccounting(AAAccountingDataType accountingDataType, AAAccountingData accountingData);
}

const GUID IID_ITSGAuthenticateUserSink = {0x2C3E2E73, 0xA782, 0x47F9, [0x8D, 0xFB, 0x77, 0xEE, 0x1E, 0xD2, 0x7A, 0x03]};
@GUID(0x2C3E2E73, 0xA782, 0x47F9, [0x8D, 0xFB, 0x77, 0xEE, 0x1E, 0xD2, 0x7A, 0x03]);
interface ITSGAuthenticateUserSink : IUnknown
{
    HRESULT OnUserAuthenticated(BSTR userName, BSTR userDomain, uint context, uint userToken);
    HRESULT OnUserAuthenticationFailed(uint context, HRESULT genericErrorCode, HRESULT specificErrorCode);
    HRESULT ReauthenticateUser(uint context);
    HRESULT DisconnectUser(uint context);
}

const GUID IID_ITSGAuthenticationEngine = {0x9EE3E5BF, 0x04AB, 0x4691, [0x99, 0x8C, 0xD7, 0xF6, 0x22, 0x32, 0x1A, 0x56]};
@GUID(0x9EE3E5BF, 0x04AB, 0x4691, [0x99, 0x8C, 0xD7, 0xF6, 0x22, 0x32, 0x1A, 0x56]);
interface ITSGAuthenticationEngine : IUnknown
{
    HRESULT AuthenticateUser(Guid mainSessionId, ubyte* cookieData, uint numCookieBytes, uint context, ITSGAuthenticateUserSink pSink);
    HRESULT CancelAuthentication(Guid mainSessionId, uint context);
}

enum WTS_CONNECTSTATE_CLASS
{
    WTSActive = 0,
    WTSConnected = 1,
    WTSConnectQuery = 2,
    WTSShadow = 3,
    WTSDisconnected = 4,
    WTSIdle = 5,
    WTSListen = 6,
    WTSReset = 7,
    WTSDown = 8,
    WTSInit = 9,
}

struct WTS_SERVER_INFOW
{
    const(wchar)* pServerName;
}

struct WTS_SERVER_INFOA
{
    const(char)* pServerName;
}

struct WTS_SESSION_INFOW
{
    uint SessionId;
    const(wchar)* pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
}

struct WTS_SESSION_INFOA
{
    uint SessionId;
    const(char)* pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
}

struct WTS_SESSION_INFO_1W
{
    uint ExecEnvId;
    WTS_CONNECTSTATE_CLASS State;
    uint SessionId;
    const(wchar)* pSessionName;
    const(wchar)* pHostName;
    const(wchar)* pUserName;
    const(wchar)* pDomainName;
    const(wchar)* pFarmName;
}

struct WTS_SESSION_INFO_1A
{
    uint ExecEnvId;
    WTS_CONNECTSTATE_CLASS State;
    uint SessionId;
    const(char)* pSessionName;
    const(char)* pHostName;
    const(char)* pUserName;
    const(char)* pDomainName;
    const(char)* pFarmName;
}

struct WTS_PROCESS_INFOW
{
    uint SessionId;
    uint ProcessId;
    const(wchar)* pProcessName;
    void* pUserSid;
}

struct WTS_PROCESS_INFOA
{
    uint SessionId;
    uint ProcessId;
    const(char)* pProcessName;
    void* pUserSid;
}

enum WTS_INFO_CLASS
{
    WTSInitialProgram = 0,
    WTSApplicationName = 1,
    WTSWorkingDirectory = 2,
    WTSOEMId = 3,
    WTSSessionId = 4,
    WTSUserName = 5,
    WTSWinStationName = 6,
    WTSDomainName = 7,
    WTSConnectState = 8,
    WTSClientBuildNumber = 9,
    WTSClientName = 10,
    WTSClientDirectory = 11,
    WTSClientProductId = 12,
    WTSClientHardwareId = 13,
    WTSClientAddress = 14,
    WTSClientDisplay = 15,
    WTSClientProtocolType = 16,
    WTSIdleTime = 17,
    WTSLogonTime = 18,
    WTSIncomingBytes = 19,
    WTSOutgoingBytes = 20,
    WTSIncomingFrames = 21,
    WTSOutgoingFrames = 22,
    WTSClientInfo = 23,
    WTSSessionInfo = 24,
    WTSSessionInfoEx = 25,
    WTSConfigInfo = 26,
    WTSValidationInfo = 27,
    WTSSessionAddressV4 = 28,
    WTSIsRemoteSession = 29,
}

struct WTSCONFIGINFOW
{
    uint version;
    uint fConnectClientDrivesAtLogon;
    uint fConnectPrinterAtLogon;
    uint fDisablePrinterRedirection;
    uint fDisableDefaultMainClientPrinter;
    uint ShadowSettings;
    ushort LogonUserName;
    ushort LogonDomain;
    ushort WorkDirectory;
    ushort InitialProgram;
    ushort ApplicationName;
}

struct WTSCONFIGINFOA
{
    uint version;
    uint fConnectClientDrivesAtLogon;
    uint fConnectPrinterAtLogon;
    uint fDisablePrinterRedirection;
    uint fDisableDefaultMainClientPrinter;
    uint ShadowSettings;
    byte LogonUserName;
    byte LogonDomain;
    byte WorkDirectory;
    byte InitialProgram;
    byte ApplicationName;
}

struct WTSINFOW
{
    WTS_CONNECTSTATE_CLASS State;
    uint SessionId;
    uint IncomingBytes;
    uint OutgoingBytes;
    uint IncomingFrames;
    uint OutgoingFrames;
    uint IncomingCompressedBytes;
    uint OutgoingCompressedBytes;
    ushort WinStationName;
    ushort Domain;
    ushort UserName;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER CurrentTime;
}

struct WTSINFOA
{
    WTS_CONNECTSTATE_CLASS State;
    uint SessionId;
    uint IncomingBytes;
    uint OutgoingBytes;
    uint IncomingFrames;
    uint OutgoingFrames;
    uint IncomingCompressedBytes;
    uint OutgoingCompressedBy;
    byte WinStationName;
    byte Domain;
    byte UserName;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER CurrentTime;
}

struct WTSINFOEX_LEVEL1_W
{
    uint SessionId;
    WTS_CONNECTSTATE_CLASS SessionState;
    int SessionFlags;
    ushort WinStationName;
    ushort UserName;
    ushort DomainName;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER CurrentTime;
    uint IncomingBytes;
    uint OutgoingBytes;
    uint IncomingFrames;
    uint OutgoingFrames;
    uint IncomingCompressedBytes;
    uint OutgoingCompressedBytes;
}

struct WTSINFOEX_LEVEL1_A
{
    uint SessionId;
    WTS_CONNECTSTATE_CLASS SessionState;
    int SessionFlags;
    byte WinStationName;
    byte UserName;
    byte DomainName;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER ConnectTime;
    LARGE_INTEGER DisconnectTime;
    LARGE_INTEGER LastInputTime;
    LARGE_INTEGER CurrentTime;
    uint IncomingBytes;
    uint OutgoingBytes;
    uint IncomingFrames;
    uint OutgoingFrames;
    uint IncomingCompressedBytes;
    uint OutgoingCompressedBytes;
}

struct WTSINFOEX_LEVEL_W
{
    WTSINFOEX_LEVEL1_W WTSInfoExLevel1;
}

struct WTSINFOEX_LEVEL_A
{
    WTSINFOEX_LEVEL1_A WTSInfoExLevel1;
}

struct WTSINFOEXW
{
    uint Level;
    WTSINFOEX_LEVEL_W Data;
}

struct WTSINFOEXA
{
    uint Level;
    WTSINFOEX_LEVEL_A Data;
}

struct WTSCLIENTW
{
    ushort ClientName;
    ushort Domain;
    ushort UserName;
    ushort WorkDirectory;
    ushort InitialProgram;
    ubyte EncryptionLevel;
    uint ClientAddressFamily;
    ushort ClientAddress;
    ushort HRes;
    ushort VRes;
    ushort ColorDepth;
    ushort ClientDirectory;
    uint ClientBuildNumber;
    uint ClientHardwareId;
    ushort ClientProductId;
    ushort OutBufCountHost;
    ushort OutBufCountClient;
    ushort OutBufLength;
    ushort DeviceId;
}

struct WTSCLIENTA
{
    byte ClientName;
    byte Domain;
    byte UserName;
    byte WorkDirectory;
    byte InitialProgram;
    ubyte EncryptionLevel;
    uint ClientAddressFamily;
    ushort ClientAddress;
    ushort HRes;
    ushort VRes;
    ushort ColorDepth;
    byte ClientDirectory;
    uint ClientBuildNumber;
    uint ClientHardwareId;
    ushort ClientProductId;
    ushort OutBufCountHost;
    ushort OutBufCountClient;
    ushort OutBufLength;
    byte DeviceId;
}

struct _WTS_PRODUCT_INFOA
{
    byte CompanyName;
    byte ProductID;
}

struct _WTS_PRODUCT_INFOW
{
    ushort CompanyName;
    ushort ProductID;
}

struct WTS_VALIDATION_INFORMATIONA
{
    _WTS_PRODUCT_INFOA ProductInfo;
    ubyte License;
    uint LicenseLength;
    ubyte HardwareID;
    uint HardwareIDLength;
}

struct WTS_VALIDATION_INFORMATIONW
{
    _WTS_PRODUCT_INFOW ProductInfo;
    ubyte License;
    uint LicenseLength;
    ubyte HardwareID;
    uint HardwareIDLength;
}

struct WTS_CLIENT_ADDRESS
{
    uint AddressFamily;
    ubyte Address;
}

struct WTS_CLIENT_DISPLAY
{
    uint HorizontalResolution;
    uint VerticalResolution;
    uint ColorDepth;
}

enum WTS_CONFIG_CLASS
{
    WTSUserConfigInitialProgram = 0,
    WTSUserConfigWorkingDirectory = 1,
    WTSUserConfigfInheritInitialProgram = 2,
    WTSUserConfigfAllowLogonTerminalServer = 3,
    WTSUserConfigTimeoutSettingsConnections = 4,
    WTSUserConfigTimeoutSettingsDisconnections = 5,
    WTSUserConfigTimeoutSettingsIdle = 6,
    WTSUserConfigfDeviceClientDrives = 7,
    WTSUserConfigfDeviceClientPrinters = 8,
    WTSUserConfigfDeviceClientDefaultPrinter = 9,
    WTSUserConfigBrokenTimeoutSettings = 10,
    WTSUserConfigReconnectSettings = 11,
    WTSUserConfigModemCallbackSettings = 12,
    WTSUserConfigModemCallbackPhoneNumber = 13,
    WTSUserConfigShadowingSettings = 14,
    WTSUserConfigTerminalServerProfilePath = 15,
    WTSUserConfigTerminalServerHomeDir = 16,
    WTSUserConfigTerminalServerHomeDirDrive = 17,
    WTSUserConfigfTerminalServerRemoteHomeDir = 18,
    WTSUserConfigUser = 19,
}

enum WTS_CONFIG_SOURCE
{
    WTSUserConfigSourceSAM = 0,
}

struct WTSUSERCONFIGA
{
    uint Source;
    uint InheritInitialProgram;
    uint AllowLogonTerminalServer;
    uint TimeoutSettingsConnections;
    uint TimeoutSettingsDisconnections;
    uint TimeoutSettingsIdle;
    uint DeviceClientDrives;
    uint DeviceClientPrinters;
    uint ClientDefaultPrinter;
    uint BrokenTimeoutSettings;
    uint ReconnectSettings;
    uint ShadowingSettings;
    uint TerminalServerRemoteHomeDir;
    byte InitialProgram;
    byte WorkDirectory;
    byte TerminalServerProfilePath;
    byte TerminalServerHomeDir;
    byte TerminalServerHomeDirDrive;
}

struct WTSUSERCONFIGW
{
    uint Source;
    uint InheritInitialProgram;
    uint AllowLogonTerminalServer;
    uint TimeoutSettingsConnections;
    uint TimeoutSettingsDisconnections;
    uint TimeoutSettingsIdle;
    uint DeviceClientDrives;
    uint DeviceClientPrinters;
    uint ClientDefaultPrinter;
    uint BrokenTimeoutSettings;
    uint ReconnectSettings;
    uint ShadowingSettings;
    uint TerminalServerRemoteHomeDir;
    ushort InitialProgram;
    ushort WorkDirectory;
    ushort TerminalServerProfilePath;
    ushort TerminalServerHomeDir;
    ushort TerminalServerHomeDirDrive;
}

enum WTS_VIRTUAL_CLASS
{
    WTSVirtualClientData = 0,
    WTSVirtualFileHandle = 1,
}

struct WTS_SESSION_ADDRESS
{
    uint AddressFamily;
    ubyte Address;
}

struct WTS_PROCESS_INFO_EXW
{
    uint SessionId;
    uint ProcessId;
    const(wchar)* pProcessName;
    void* pUserSid;
    uint NumberOfThreads;
    uint HandleCount;
    uint PagefileUsage;
    uint PeakPagefileUsage;
    uint WorkingSetSize;
    uint PeakWorkingSetSize;
    LARGE_INTEGER UserTime;
    LARGE_INTEGER KernelTime;
}

struct WTS_PROCESS_INFO_EXA
{
    uint SessionId;
    uint ProcessId;
    const(char)* pProcessName;
    void* pUserSid;
    uint NumberOfThreads;
    uint HandleCount;
    uint PagefileUsage;
    uint PeakPagefileUsage;
    uint WorkingSetSize;
    uint PeakWorkingSetSize;
    LARGE_INTEGER UserTime;
    LARGE_INTEGER KernelTime;
}

enum WTS_TYPE_CLASS
{
    WTSTypeProcessInfoLevel0 = 0,
    WTSTypeProcessInfoLevel1 = 1,
    WTSTypeSessionInfoLevel1 = 2,
}

struct WTSLISTENERCONFIGW
{
    uint version;
    uint fEnableListener;
    uint MaxConnectionCount;
    uint fPromptForPassword;
    uint fInheritColorDepth;
    uint ColorDepth;
    uint fInheritBrokenTimeoutSettings;
    uint BrokenTimeoutSettings;
    uint fDisablePrinterRedirection;
    uint fDisableDriveRedirection;
    uint fDisableComPortRedirection;
    uint fDisableLPTPortRedirection;
    uint fDisableClipboardRedirection;
    uint fDisableAudioRedirection;
    uint fDisablePNPRedirection;
    uint fDisableDefaultMainClientPrinter;
    uint LanAdapter;
    uint PortNumber;
    uint fInheritShadowSettings;
    uint ShadowSettings;
    uint TimeoutSettingsConnection;
    uint TimeoutSettingsDisconnection;
    uint TimeoutSettingsIdle;
    uint SecurityLayer;
    uint MinEncryptionLevel;
    uint UserAuthentication;
    ushort Comment;
    ushort LogonUserName;
    ushort LogonDomain;
    ushort WorkDirectory;
    ushort InitialProgram;
}

struct WTSLISTENERCONFIGA
{
    uint version;
    uint fEnableListener;
    uint MaxConnectionCount;
    uint fPromptForPassword;
    uint fInheritColorDepth;
    uint ColorDepth;
    uint fInheritBrokenTimeoutSettings;
    uint BrokenTimeoutSettings;
    uint fDisablePrinterRedirection;
    uint fDisableDriveRedirection;
    uint fDisableComPortRedirection;
    uint fDisableLPTPortRedirection;
    uint fDisableClipboardRedirection;
    uint fDisableAudioRedirection;
    uint fDisablePNPRedirection;
    uint fDisableDefaultMainClientPrinter;
    uint LanAdapter;
    uint PortNumber;
    uint fInheritShadowSettings;
    uint ShadowSettings;
    uint TimeoutSettingsConnection;
    uint TimeoutSettingsDisconnection;
    uint TimeoutSettingsIdle;
    uint SecurityLayer;
    uint MinEncryptionLevel;
    uint UserAuthentication;
    byte Comment;
    byte LogonUserName;
    byte LogonDomain;
    byte WorkDirectory;
    byte InitialProgram;
}

enum WTSSBX_MACHINE_DRAIN
{
    WTSSBX_MACHINE_DRAIN_UNSPEC = 0,
    WTSSBX_MACHINE_DRAIN_OFF = 1,
    WTSSBX_MACHINE_DRAIN_ON = 2,
}

enum WTSSBX_MACHINE_SESSION_MODE
{
    WTSSBX_MACHINE_SESSION_MODE_UNSPEC = 0,
    WTSSBX_MACHINE_SESSION_MODE_SINGLE = 1,
    WTSSBX_MACHINE_SESSION_MODE_MULTIPLE = 2,
}

enum WTSSBX_ADDRESS_FAMILY
{
    WTSSBX_ADDRESS_FAMILY_AF_UNSPEC = 0,
    WTSSBX_ADDRESS_FAMILY_AF_INET = 1,
    WTSSBX_ADDRESS_FAMILY_AF_INET6 = 2,
    WTSSBX_ADDRESS_FAMILY_AF_IPX = 3,
    WTSSBX_ADDRESS_FAMILY_AF_NETBIOS = 4,
}

struct WTSSBX_IP_ADDRESS
{
    WTSSBX_ADDRESS_FAMILY AddressFamily;
    ubyte Address;
    ushort PortNumber;
    uint dwScope;
}

enum WTSSBX_MACHINE_STATE
{
    WTSSBX_MACHINE_STATE_UNSPEC = 0,
    WTSSBX_MACHINE_STATE_READY = 1,
    WTSSBX_MACHINE_STATE_SYNCHRONIZING = 2,
}

struct WTSSBX_MACHINE_CONNECT_INFO
{
    ushort wczMachineFQDN;
    ushort wczMachineNetBiosName;
    uint dwNumOfIPAddr;
    WTSSBX_IP_ADDRESS IPaddr;
}

struct WTSSBX_MACHINE_INFO
{
    WTSSBX_MACHINE_CONNECT_INFO ClientConnectInfo;
    ushort wczFarmName;
    WTSSBX_IP_ADDRESS InternalIPAddress;
    uint dwMaxSessionsLimit;
    uint ServerWeight;
    WTSSBX_MACHINE_SESSION_MODE SingleSessionMode;
    WTSSBX_MACHINE_DRAIN InDrain;
    WTSSBX_MACHINE_STATE MachineState;
}

enum WTSSBX_SESSION_STATE
{
    WTSSBX_SESSION_STATE_UNSPEC = 0,
    WTSSBX_SESSION_STATE_ACTIVE = 1,
    WTSSBX_SESSION_STATE_DISCONNECTED = 2,
}

struct WTSSBX_SESSION_INFO
{
    ushort wszUserName;
    ushort wszDomainName;
    ushort ApplicationType;
    uint dwSessionId;
    FILETIME CreateTime;
    FILETIME DisconnectTime;
    WTSSBX_SESSION_STATE SessionState;
}

enum WTSSBX_NOTIFICATION_TYPE
{
    WTSSBX_NOTIFICATION_REMOVED = 1,
    WTSSBX_NOTIFICATION_CHANGED = 2,
    WTSSBX_NOTIFICATION_ADDED = 4,
    WTSSBX_NOTIFICATION_RESYNC = 8,
}

const GUID IID_IWTSSBPlugin = {0xDC44BE78, 0xB18D, 0x4399, [0xB2, 0x10, 0x64, 0x1B, 0xF6, 0x7A, 0x00, 0x2C]};
@GUID(0xDC44BE78, 0xB18D, 0x4399, [0xB2, 0x10, 0x64, 0x1B, 0xF6, 0x7A, 0x00, 0x2C]);
interface IWTSSBPlugin : IUnknown
{
    HRESULT Initialize(uint* PluginCapabilities);
    HRESULT WTSSBX_MachineChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, WTSSBX_MACHINE_INFO* pMachineInfo);
    HRESULT WTSSBX_SessionChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, uint NumOfSessions, char* SessionInfo);
    HRESULT WTSSBX_GetMostSuitableServer(ushort* UserName, ushort* DomainName, ushort* ApplicationType, ushort* FarmName, int* pMachineId);
    HRESULT Terminated();
    HRESULT WTSSBX_GetUserExternalSession(ushort* UserName, ushort* DomainName, ushort* ApplicationType, WTSSBX_IP_ADDRESS* RedirectorInternalIP, uint* pSessionId, WTSSBX_MACHINE_CONNECT_INFO* pMachineConnectInfo);
}

struct CHANNEL_DEF
{
    byte name;
    uint options;
}

struct CHANNEL_PDU_HEADER
{
    uint length;
    uint flags;
}

alias CHANNEL_INIT_EVENT_FN = extern(Windows) void function(void* pInitHandle, uint event, void* pData, uint dataLength);
alias PCHANNEL_INIT_EVENT_FN = extern(Windows) void function();
alias CHANNEL_OPEN_EVENT_FN = extern(Windows) void function(uint openHandle, uint event, void* pData, uint dataLength, uint totalLength, uint dataFlags);
alias PCHANNEL_OPEN_EVENT_FN = extern(Windows) void function();
alias VIRTUALCHANNELINIT = extern(Windows) uint function(void** ppInitHandle, CHANNEL_DEF* pChannel, int channelCount, uint versionRequested, PCHANNEL_INIT_EVENT_FN pChannelInitEventProc);
alias PVIRTUALCHANNELINIT = extern(Windows) uint function();
alias VIRTUALCHANNELOPEN = extern(Windows) uint function(void* pInitHandle, uint* pOpenHandle, const(char)* pChannelName, PCHANNEL_OPEN_EVENT_FN pChannelOpenEventProc);
alias PVIRTUALCHANNELOPEN = extern(Windows) uint function();
alias VIRTUALCHANNELCLOSE = extern(Windows) uint function(uint openHandle);
alias PVIRTUALCHANNELCLOSE = extern(Windows) uint function();
alias VIRTUALCHANNELWRITE = extern(Windows) uint function(uint openHandle, void* pData, uint dataLength, void* pUserData);
alias PVIRTUALCHANNELWRITE = extern(Windows) uint function();
struct CHANNEL_ENTRY_POINTS
{
    uint cbSize;
    uint protocolVersion;
    PVIRTUALCHANNELINIT pVirtualChannelInit;
    PVIRTUALCHANNELOPEN pVirtualChannelOpen;
    PVIRTUALCHANNELCLOSE pVirtualChannelClose;
    PVIRTUALCHANNELWRITE pVirtualChannelWrite;
}

alias VIRTUALCHANNELENTRY = extern(Windows) BOOL function(CHANNEL_ENTRY_POINTS* pEntryPoints);
alias PVIRTUALCHANNELENTRY = extern(Windows) BOOL function();
const GUID CLSID_Workspace = {0x4F1DFCA6, 0x3AAD, 0x48E1, [0x84, 0x06, 0x4B, 0xC2, 0x1A, 0x50, 0x1D, 0x7C]};
@GUID(0x4F1DFCA6, 0x3AAD, 0x48E1, [0x84, 0x06, 0x4B, 0xC2, 0x1A, 0x50, 0x1D, 0x7C]);
struct Workspace;

const GUID IID_IWorkspaceClientExt = {0x12B952F4, 0x41CA, 0x4F21, [0xA8, 0x29, 0xA6, 0xD0, 0x7D, 0x9A, 0x16, 0xE5]};
@GUID(0x12B952F4, 0x41CA, 0x4F21, [0xA8, 0x29, 0xA6, 0xD0, 0x7D, 0x9A, 0x16, 0xE5]);
interface IWorkspaceClientExt : IUnknown
{
    HRESULT GetResourceId(BSTR* bstrWorkspaceId);
    HRESULT GetResourceDisplayName(BSTR* bstrWorkspaceDisplayName);
    HRESULT IssueDisconnect();
}

const GUID IID_IWorkspace = {0xB922BBB8, 0x4C55, 0x4FEA, [0x84, 0x96, 0xBE, 0xB0, 0xB4, 0x42, 0x85, 0xE5]};
@GUID(0xB922BBB8, 0x4C55, 0x4FEA, [0x84, 0x96, 0xBE, 0xB0, 0xB4, 0x42, 0x85, 0xE5]);
interface IWorkspace : IUnknown
{
    HRESULT GetWorkspaceNames(SAFEARRAY** psaWkspNames);
    HRESULT StartRemoteApplication(BSTR bstrWorkspaceId, SAFEARRAY* psaParams);
    HRESULT GetProcessId(uint* pulProcessId);
}

const GUID IID_IWorkspace2 = {0x96D8D7CF, 0x783E, 0x4286, [0x83, 0x4C, 0xEB, 0xC0, 0xE9, 0x5F, 0x78, 0x3C]};
@GUID(0x96D8D7CF, 0x783E, 0x4286, [0x83, 0x4C, 0xEB, 0xC0, 0xE9, 0x5F, 0x78, 0x3C]);
interface IWorkspace2 : IWorkspace
{
    HRESULT StartRemoteApplicationEx(BSTR bstrWorkspaceId, BSTR bstrRequestingAppId, BSTR bstrRequestingAppFamilyName, short bLaunchIntoImmersiveClient, BSTR bstrImmersiveClientActivationContext, SAFEARRAY* psaParams);
}

const GUID IID_IWorkspace3 = {0x1BECBE4A, 0xD654, 0x423B, [0xAF, 0xEB, 0xBE, 0x8D, 0x53, 0x2C, 0x13, 0xC6]};
@GUID(0x1BECBE4A, 0xD654, 0x423B, [0xAF, 0xEB, 0xBE, 0x8D, 0x53, 0x2C, 0x13, 0xC6]);
interface IWorkspace3 : IWorkspace2
{
    HRESULT GetClaimsToken2(BSTR bstrClaimsHint, BSTR bstrUserHint, uint claimCookie, uint hwndCredUiParent, RECT rectCredUiParent, BSTR* pbstrAccessToken);
    HRESULT SetClaimsToken(BSTR bstrAccessToken, ulong ullAccessTokenExpiration, BSTR bstrRefreshToken);
}

const GUID IID_IWorkspaceRegistration = {0xB922BBB8, 0x4C55, 0x4FEA, [0x84, 0x96, 0xBE, 0xB0, 0xB4, 0x42, 0x85, 0xE6]};
@GUID(0xB922BBB8, 0x4C55, 0x4FEA, [0x84, 0x96, 0xBE, 0xB0, 0xB4, 0x42, 0x85, 0xE6]);
interface IWorkspaceRegistration : IUnknown
{
    HRESULT AddResource(IWorkspaceClientExt pUnk, uint* pdwCookie);
    HRESULT RemoveResource(uint dwCookieConnection);
}

const GUID IID_IWorkspaceRegistration2 = {0xCF59F654, 0x39BB, 0x44D8, [0x94, 0xD0, 0x46, 0x35, 0x72, 0x89, 0x57, 0xE9]};
@GUID(0xCF59F654, 0x39BB, 0x44D8, [0x94, 0xD0, 0x46, 0x35, 0x72, 0x89, 0x57, 0xE9]);
interface IWorkspaceRegistration2 : IWorkspaceRegistration
{
    HRESULT AddResourceEx(IWorkspaceClientExt pUnk, BSTR bstrEventLogUploadAddress, uint* pdwCookie, Guid correlationId);
    HRESULT RemoveResourceEx(uint dwCookieConnection, Guid correlationId);
}

const GUID IID_IWorkspaceScriptable = {0xEFEA49A2, 0xDDA5, 0x429D, [0x8F, 0x42, 0xB2, 0x3B, 0x92, 0xC4, 0xC3, 0x47]};
@GUID(0xEFEA49A2, 0xDDA5, 0x429D, [0x8F, 0x42, 0xB2, 0x3B, 0x92, 0xC4, 0xC3, 0x47]);
interface IWorkspaceScriptable : IDispatch
{
    HRESULT DisconnectWorkspace(BSTR bstrWorkspaceId);
    HRESULT StartWorkspace(BSTR bstrWorkspaceId, BSTR bstrUserName, BSTR bstrPassword, BSTR bstrWorkspaceParams, int lTimeout, int lFlags);
    HRESULT IsWorkspaceCredentialSpecified(BSTR bstrWorkspaceId, short bCountUnauthenticatedCredentials, short* pbCredExist);
    HRESULT IsWorkspaceSSOEnabled(short* pbSSOEnabled);
    HRESULT ClearWorkspaceCredential(BSTR bstrWorkspaceId);
    HRESULT OnAuthenticated(BSTR bstrWorkspaceId, BSTR bstrUserName);
    HRESULT DisconnectWorkspaceByFriendlyName(BSTR bstrWorkspaceFriendlyName);
}

const GUID IID_IWorkspaceScriptable2 = {0xEFEA49A2, 0xDDA5, 0x429D, [0x8F, 0x42, 0xB3, 0x3B, 0xA2, 0xC4, 0xC3, 0x48]};
@GUID(0xEFEA49A2, 0xDDA5, 0x429D, [0x8F, 0x42, 0xB3, 0x3B, 0xA2, 0xC4, 0xC3, 0x48]);
interface IWorkspaceScriptable2 : IWorkspaceScriptable
{
    HRESULT StartWorkspaceEx(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, int lTimeout, int lFlags);
    HRESULT ResourceDismissed(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName);
}

const GUID IID_IWorkspaceScriptable3 = {0x531E6512, 0x2CBF, 0x4BD2, [0x80, 0xA5, 0xD9, 0x0A, 0x71, 0x63, 0x6A, 0x9A]};
@GUID(0x531E6512, 0x2CBF, 0x4BD2, [0x80, 0xA5, 0xD9, 0x0A, 0x71, 0x63, 0x6A, 0x9A]);
interface IWorkspaceScriptable3 : IWorkspaceScriptable2
{
    HRESULT StartWorkspaceEx2(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, int lTimeout, int lFlags, BSTR bstrEventLogUploadAddress, Guid correlationId);
}

const GUID IID_IWorkspaceReportMessage = {0xA7C06739, 0x500F, 0x4E8C, [0x99, 0xA8, 0x2B, 0xD6, 0x95, 0x58, 0x99, 0xEB]};
@GUID(0xA7C06739, 0x500F, 0x4E8C, [0x99, 0xA8, 0x2B, 0xD6, 0x95, 0x58, 0x99, 0xEB]);
interface IWorkspaceReportMessage : IUnknown
{
    HRESULT RegisterErrorLogMessage(BSTR bstrMessage);
    HRESULT IsErrorMessageRegistered(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, uint dwErrorCode, short* pfErrorExist);
    HRESULT RegisterErrorEvent(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, uint dwErrorCode);
}

const GUID IID__ITSWkspEvents = {0xB922BBB8, 0x4C55, 0x4FEA, [0x84, 0x96, 0xBE, 0xB0, 0xB4, 0x42, 0x85, 0xE9]};
@GUID(0xB922BBB8, 0x4C55, 0x4FEA, [0x84, 0x96, 0xBE, 0xB0, 0xB4, 0x42, 0x85, 0xE9]);
interface _ITSWkspEvents : IDispatch
{
}

enum TSSD_AddrV46Type
{
    TSSD_ADDR_UNDEFINED = 0,
    TSSD_ADDR_IPv4 = 4,
    TSSD_ADDR_IPv6 = 6,
}

enum TSSB_NOTIFICATION_TYPE
{
    TSSB_NOTIFY_INVALID = 0,
    TSSB_NOTIFY_TARGET_CHANGE = 1,
    TSSB_NOTIFY_SESSION_CHANGE = 2,
    TSSB_NOTIFY_CONNECTION_REQUEST_CHANGE = 4,
}

enum TARGET_STATE
{
    TARGET_UNKNOWN = 1,
    TARGET_INITIALIZING = 2,
    TARGET_RUNNING = 3,
    TARGET_DOWN = 4,
    TARGET_HIBERNATED = 5,
    TARGET_CHECKED_OUT = 6,
    TARGET_STOPPED = 7,
    TARGET_INVALID = 8,
    TARGET_STARTING = 9,
    TARGET_STOPPING = 10,
    TARGET_MAXSTATE = 11,
}

enum TARGET_CHANGE_TYPE
{
    TARGET_CHANGE_UNSPEC = 1,
    TARGET_EXTERNALIP_CHANGED = 2,
    TARGET_INTERNALIP_CHANGED = 4,
    TARGET_JOINED = 8,
    TARGET_REMOVED = 16,
    TARGET_STATE_CHANGED = 32,
    TARGET_IDLE = 64,
    TARGET_PENDING = 128,
    TARGET_INUSE = 256,
    TARGET_PATCH_STATE_CHANGED = 512,
    TARGET_FARM_MEMBERSHIP_CHANGED = 1024,
}

enum TARGET_TYPE
{
    UNKNOWN = 0,
    FARM = 1,
    NONFARM = 2,
}

enum TARGET_PATCH_STATE
{
    TARGET_PATCH_UNKNOWN = 0,
    TARGET_PATCH_NOT_STARTED = 1,
    TARGET_PATCH_IN_PROGRESS = 2,
    TARGET_PATCH_COMPLETED = 3,
    TARGET_PATCH_FAILED = 4,
}

enum CLIENT_MESSAGE_TYPE
{
    CLIENT_MESSAGE_CONNECTION_INVALID = 0,
    CLIENT_MESSAGE_CONNECTION_STATUS = 1,
    CLIENT_MESSAGE_CONNECTION_ERROR = 2,
}

enum CONNECTION_CHANGE_NOTIFICATION
{
    CONNECTION_REQUEST_INVALID = 0,
    CONNECTION_REQUEST_PENDING = 1,
    CONNECTION_REQUEST_FAILED = 2,
    CONNECTION_REQUEST_TIMEDOUT = 3,
    CONNECTION_REQUEST_SUCCEEDED = 4,
    CONNECTION_REQUEST_CANCELLED = 5,
    CONNECTION_REQUEST_LB_COMPLETED = 6,
    CONNECTION_REQUEST_QUERY_PL_COMPLETED = 7,
    CONNECTION_REQUEST_ORCH_COMPLETED = 8,
}

enum RD_FARM_TYPE
{
    RD_FARM_RDSH = 0,
    RD_FARM_TEMP_VM = 1,
    RD_FARM_MANUAL_PERSONAL_VM = 2,
    RD_FARM_AUTO_PERSONAL_VM = 3,
    RD_FARM_MANUAL_PERSONAL_RDSH = 4,
    RD_FARM_AUTO_PERSONAL_RDSH = 5,
    RD_FARM_TYPE_UNKNOWN = -1,
}

enum PLUGIN_TYPE
{
    UNKNOWN_PLUGIN = 0,
    POLICY_PLUGIN = 1,
    RESOURCE_PLUGIN = 2,
    LOAD_BALANCING_PLUGIN = 4,
    PLACEMENT_PLUGIN = 8,
    ORCHESTRATION_PLUGIN = 16,
    PROVISIONING_PLUGIN = 32,
    TASK_PLUGIN = 64,
}

enum TSSESSION_STATE
{
    STATE_INVALID = -1,
    STATE_ACTIVE = 0,
    STATE_CONNECTED = 1,
    STATE_CONNECTQUERY = 2,
    STATE_SHADOW = 3,
    STATE_DISCONNECTED = 4,
    STATE_IDLE = 5,
    STATE_LISTEN = 6,
    STATE_RESET = 7,
    STATE_DOWN = 8,
    STATE_INIT = 9,
    STATE_MAX = 10,
}

enum TARGET_OWNER
{
    OWNER_UNKNOWN = 0,
    OWNER_MS_TS_PLUGIN = 1,
    OWNER_MS_VM_PLUGIN = 2,
}

struct CLIENT_DISPLAY
{
    uint HorizontalResolution;
    uint VerticalResolution;
    uint ColorDepth;
}

struct TSSD_ConnectionPoint
{
    ubyte ServerAddressB;
    TSSD_AddrV46Type AddressType;
    ushort PortNumber;
    uint AddressScope;
}

enum VM_NOTIFY_STATUS
{
    VM_NOTIFY_STATUS_PENDING = 0,
    VM_NOTIFY_STATUS_IN_PROGRESS = 1,
    VM_NOTIFY_STATUS_COMPLETE = 2,
    VM_NOTIFY_STATUS_FAILED = 3,
    VM_NOTIFY_STATUS_CANCELED = 4,
}

struct VM_NOTIFY_ENTRY
{
    ushort VmName;
    ushort VmHost;
}

struct VM_PATCH_INFO
{
    uint dwNumEntries;
    ushort** pVmNames;
}

struct VM_NOTIFY_INFO
{
    uint dwNumEntries;
    VM_NOTIFY_ENTRY** ppVmEntries;
}

enum VM_HOST_NOTIFY_STATUS
{
    VM_HOST_STATUS_INIT_PENDING = 0,
    VM_HOST_STATUS_INIT_IN_PROGRESS = 1,
    VM_HOST_STATUS_INIT_COMPLETE = 2,
    VM_HOST_STATUS_INIT_FAILED = 3,
}

enum RDV_TASK_STATUS
{
    RDV_TASK_STATUS_UNKNOWN = 0,
    RDV_TASK_STATUS_SEARCHING = 1,
    RDV_TASK_STATUS_DOWNLOADING = 2,
    RDV_TASK_STATUS_APPLYING = 3,
    RDV_TASK_STATUS_REBOOTING = 4,
    RDV_TASK_STATUS_REBOOTED = 5,
    RDV_TASK_STATUS_SUCCESS = 6,
    RDV_TASK_STATUS_FAILED = 7,
    RDV_TASK_STATUS_TIMEOUT = 8,
}

enum TS_SB_SORT_BY
{
    TS_SB_SORT_BY_NONE = 0,
    TS_SB_SORT_BY_NAME = 1,
    TS_SB_SORT_BY_PROP = 2,
}

const GUID IID_ITsSbPlugin = {0x48CD7406, 0xCAAB, 0x465F, [0xA5, 0xD6, 0xBA, 0xA8, 0x63, 0xB9, 0xEA, 0x4F]};
@GUID(0x48CD7406, 0xCAAB, 0x465F, [0xA5, 0xD6, 0xBA, 0xA8, 0x63, 0xB9, 0xEA, 0x4F]);
interface ITsSbPlugin : IUnknown
{
    HRESULT Initialize(ITsSbProvider pProvider, ITsSbPluginNotifySink pNotifySink, ITsSbPluginPropertySet pPropertySet);
    HRESULT Terminate(HRESULT hr);
}

const GUID IID_ITsSbResourcePlugin = {0xEA8DB42C, 0x98ED, 0x4535, [0xA8, 0x8B, 0x2A, 0x16, 0x4F, 0x35, 0x49, 0x0F]};
@GUID(0xEA8DB42C, 0x98ED, 0x4535, [0xA8, 0x8B, 0x2A, 0x16, 0x4F, 0x35, 0x49, 0x0F]);
interface ITsSbResourcePlugin : ITsSbPlugin
{
}

const GUID IID_ITsSbServiceNotification = {0x86CB68AE, 0x86E0, 0x4F57, [0x8A, 0x64, 0xBB, 0x74, 0x06, 0xBC, 0x55, 0x50]};
@GUID(0x86CB68AE, 0x86E0, 0x4F57, [0x8A, 0x64, 0xBB, 0x74, 0x06, 0xBC, 0x55, 0x50]);
interface ITsSbServiceNotification : IUnknown
{
    HRESULT NotifyServiceFailure();
    HRESULT NotifyServiceSuccess();
}

const GUID IID_ITsSbLoadBalancing = {0x24329274, 0x9EB7, 0x11DC, [0xAE, 0x98, 0xF2, 0xB4, 0x56, 0xD8, 0x95, 0x93]};
@GUID(0x24329274, 0x9EB7, 0x11DC, [0xAE, 0x98, 0xF2, 0xB4, 0x56, 0xD8, 0x95, 0x93]);
interface ITsSbLoadBalancing : ITsSbPlugin
{
    HRESULT GetMostSuitableTarget(ITsSbClientConnection pConnection, ITsSbLoadBalancingNotifySink pLBSink);
}

const GUID IID_ITsSbPlacement = {0xDAADEE5F, 0x6D32, 0x480E, [0x9E, 0x36, 0xDD, 0xAB, 0x23, 0x29, 0xF0, 0x6D]};
@GUID(0xDAADEE5F, 0x6D32, 0x480E, [0x9E, 0x36, 0xDD, 0xAB, 0x23, 0x29, 0xF0, 0x6D]);
interface ITsSbPlacement : ITsSbPlugin
{
    HRESULT QueryEnvironmentForTarget(ITsSbClientConnection pConnection, ITsSbPlacementNotifySink pPlacementSink);
}

const GUID IID_ITsSbOrchestration = {0x64FC1172, 0x9EB7, 0x11DC, [0x8B, 0x00, 0x3A, 0xBA, 0x56, 0xD8, 0x95, 0x93]};
@GUID(0x64FC1172, 0x9EB7, 0x11DC, [0x8B, 0x00, 0x3A, 0xBA, 0x56, 0xD8, 0x95, 0x93]);
interface ITsSbOrchestration : ITsSbPlugin
{
    HRESULT PrepareTargetForConnect(ITsSbClientConnection pConnection, ITsSbOrchestrationNotifySink pOrchestrationNotifySink);
}

const GUID IID_ITsSbEnvironment = {0x8C87F7F7, 0xBF51, 0x4A5C, [0x87, 0xBF, 0x8E, 0x94, 0xFB, 0x6E, 0x22, 0x56]};
@GUID(0x8C87F7F7, 0xBF51, 0x4A5C, [0x87, 0xBF, 0x8E, 0x94, 0xFB, 0x6E, 0x22, 0x56]);
interface ITsSbEnvironment : IUnknown
{
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_ServerWeight(uint* pVal);
    HRESULT get_EnvironmentPropertySet(ITsSbEnvironmentPropertySet* ppPropertySet);
    HRESULT put_EnvironmentPropertySet(ITsSbEnvironmentPropertySet pVal);
}

const GUID IID_ITsSbLoadBalanceResult = {0x24FDB7AC, 0xFEA6, 0x11DC, [0x96, 0x72, 0x9A, 0x89, 0x56, 0xD8, 0x95, 0x93]};
@GUID(0x24FDB7AC, 0xFEA6, 0x11DC, [0x96, 0x72, 0x9A, 0x89, 0x56, 0xD8, 0x95, 0x93]);
interface ITsSbLoadBalanceResult : IUnknown
{
    HRESULT get_TargetName(BSTR* pVal);
}

const GUID IID_ITsSbTarget = {0x16616ECC, 0x272D, 0x411D, [0xB3, 0x24, 0x12, 0x68, 0x93, 0x03, 0x38, 0x56]};
@GUID(0x16616ECC, 0x272D, 0x411D, [0xB3, 0x24, 0x12, 0x68, 0x93, 0x03, 0x38, 0x56]);
interface ITsSbTarget : IUnknown
{
    HRESULT get_TargetName(BSTR* pVal);
    HRESULT put_TargetName(BSTR Val);
    HRESULT get_FarmName(BSTR* pVal);
    HRESULT put_FarmName(BSTR Val);
    HRESULT get_TargetFQDN(BSTR* TargetFqdnName);
    HRESULT put_TargetFQDN(BSTR Val);
    HRESULT get_TargetNetbios(BSTR* TargetNetbiosName);
    HRESULT put_TargetNetbios(BSTR Val);
    HRESULT get_IpAddresses(char* SOCKADDR, uint* numAddresses);
    HRESULT put_IpAddresses(char* SOCKADDR, uint numAddresses);
    HRESULT get_TargetState(TARGET_STATE* pState);
    HRESULT put_TargetState(TARGET_STATE State);
    HRESULT get_TargetPropertySet(ITsSbTargetPropertySet* ppPropertySet);
    HRESULT put_TargetPropertySet(ITsSbTargetPropertySet pVal);
    HRESULT get_EnvironmentName(BSTR* pVal);
    HRESULT put_EnvironmentName(BSTR Val);
    HRESULT get_NumSessions(uint* pNumSessions);
    HRESULT get_NumPendingConnections(uint* pNumPendingConnections);
    HRESULT get_TargetLoad(uint* pTargetLoad);
}

const GUID IID_ITsSbSession = {0xD453AAC7, 0xB1D8, 0x4C5E, [0xBA, 0x34, 0x9A, 0xFB, 0x4C, 0x8C, 0x55, 0x10]};
@GUID(0xD453AAC7, 0xB1D8, 0x4C5E, [0xBA, 0x34, 0x9A, 0xFB, 0x4C, 0x8C, 0x55, 0x10]);
interface ITsSbSession : IUnknown
{
    HRESULT get_SessionId(uint* pVal);
    HRESULT get_TargetName(BSTR* targetName);
    HRESULT put_TargetName(BSTR targetName);
    HRESULT get_Username(BSTR* userName);
    HRESULT get_Domain(BSTR* domain);
    HRESULT get_State(TSSESSION_STATE* pState);
    HRESULT put_State(TSSESSION_STATE State);
    HRESULT get_CreateTime(FILETIME* pTime);
    HRESULT put_CreateTime(FILETIME Time);
    HRESULT get_DisconnectTime(FILETIME* pTime);
    HRESULT put_DisconnectTime(FILETIME Time);
    HRESULT get_InitialProgram(BSTR* app);
    HRESULT put_InitialProgram(BSTR Application);
    HRESULT get_ClientDisplay(CLIENT_DISPLAY* pClientDisplay);
    HRESULT put_ClientDisplay(CLIENT_DISPLAY pClientDisplay);
    HRESULT get_ProtocolType(uint* pVal);
    HRESULT put_ProtocolType(uint Val);
}

const GUID IID_ITsSbResourceNotification = {0x65D3E85A, 0xC39B, 0x11DC, [0xB9, 0x2D, 0x3C, 0xD2, 0x55, 0xD8, 0x95, 0x93]};
@GUID(0x65D3E85A, 0xC39B, 0x11DC, [0xB9, 0x2D, 0x3C, 0xD2, 0x55, 0xD8, 0x95, 0x93]);
interface ITsSbResourceNotification : IUnknown
{
    HRESULT NotifySessionChange(TSSESSION_STATE changeType, ITsSbSession pSession);
    HRESULT NotifyTargetChange(uint TargetChangeType, ITsSbTarget pTarget);
    HRESULT NotifyClientConnectionStateChange(CONNECTION_CHANGE_NOTIFICATION ChangeType, ITsSbClientConnection pConnection);
}

const GUID IID_ITsSbResourceNotificationEx = {0xA8A47FDE, 0xCA91, 0x44D2, [0xB8, 0x97, 0x3A, 0xA2, 0x8A, 0x43, 0xB2, 0xB7]};
@GUID(0xA8A47FDE, 0xCA91, 0x44D2, [0xB8, 0x97, 0x3A, 0xA2, 0x8A, 0x43, 0xB2, 0xB7]);
interface ITsSbResourceNotificationEx : IUnknown
{
    HRESULT NotifySessionChangeEx(BSTR targetName, BSTR userName, BSTR domain, uint sessionId, TSSESSION_STATE sessionState);
    HRESULT NotifyTargetChangeEx(BSTR targetName, uint targetChangeType);
    HRESULT NotifyClientConnectionStateChangeEx(BSTR userName, BSTR domain, BSTR initialProgram, BSTR poolName, BSTR targetName, CONNECTION_CHANGE_NOTIFICATION connectionChangeType);
}

const GUID IID_ITsSbTaskInfo = {0x523D1083, 0x89BE, 0x48DD, [0x99, 0xEA, 0x04, 0xE8, 0x2F, 0xFA, 0x72, 0x65]};
@GUID(0x523D1083, 0x89BE, 0x48DD, [0x99, 0xEA, 0x04, 0xE8, 0x2F, 0xFA, 0x72, 0x65]);
interface ITsSbTaskInfo : IUnknown
{
    HRESULT get_TargetId(BSTR* pName);
    HRESULT get_StartTime(FILETIME* pStartTime);
    HRESULT get_EndTime(FILETIME* pEndTime);
    HRESULT get_Deadline(FILETIME* pDeadline);
    HRESULT get_Identifier(BSTR* pIdentifier);
    HRESULT get_Label(BSTR* pLabel);
    HRESULT get_Context(SAFEARRAY** pContext);
    HRESULT get_Plugin(BSTR* pPlugin);
    HRESULT get_Status(RDV_TASK_STATUS* pStatus);
}

const GUID IID_ITsSbTaskPlugin = {0xFA22EF0F, 0x8705, 0x41BE, [0x93, 0xBC, 0x44, 0xBD, 0xBC, 0xF1, 0xC9, 0xC4]};
@GUID(0xFA22EF0F, 0x8705, 0x41BE, [0x93, 0xBC, 0x44, 0xBD, 0xBC, 0xF1, 0xC9, 0xC4]);
interface ITsSbTaskPlugin : ITsSbPlugin
{
    HRESULT InitializeTaskPlugin(ITsSbTaskPluginNotifySink pITsSbTaskPluginNotifySink);
    HRESULT SetTaskQueue(BSTR pszHostName, uint SbTaskInfoSize, char* pITsSbTaskInfo);
}

const GUID IID_ITsSbPropertySet = {0x5C025171, 0xBB1E, 0x4BAF, [0xA2, 0x12, 0x6D, 0x5E, 0x97, 0x74, 0xB3, 0x3B]};
@GUID(0x5C025171, 0xBB1E, 0x4BAF, [0xA2, 0x12, 0x6D, 0x5E, 0x97, 0x74, 0xB3, 0x3B]);
interface ITsSbPropertySet : IPropertyBag
{
}

const GUID IID_ITsSbPluginPropertySet = {0x95006E34, 0x7EFF, 0x4B6C, [0xBB, 0x40, 0x49, 0xA4, 0xFD, 0xA7, 0xCE, 0xA6]};
@GUID(0x95006E34, 0x7EFF, 0x4B6C, [0xBB, 0x40, 0x49, 0xA4, 0xFD, 0xA7, 0xCE, 0xA6]);
interface ITsSbPluginPropertySet : ITsSbPropertySet
{
}

const GUID IID_ITsSbClientConnectionPropertySet = {0xE51995B0, 0x46D6, 0x11DD, [0xAA, 0x21, 0xCE, 0xDC, 0x55, 0xD8, 0x95, 0x93]};
@GUID(0xE51995B0, 0x46D6, 0x11DD, [0xAA, 0x21, 0xCE, 0xDC, 0x55, 0xD8, 0x95, 0x93]);
interface ITsSbClientConnectionPropertySet : ITsSbPropertySet
{
}

const GUID IID_ITsSbTargetPropertySet = {0xF7BDA5D6, 0x994C, 0x4E11, [0xA0, 0x79, 0x27, 0x63, 0xB6, 0x18, 0x30, 0xAC]};
@GUID(0xF7BDA5D6, 0x994C, 0x4E11, [0xA0, 0x79, 0x27, 0x63, 0xB6, 0x18, 0x30, 0xAC]);
interface ITsSbTargetPropertySet : ITsSbPropertySet
{
}

const GUID IID_ITsSbEnvironmentPropertySet = {0xD0D1BF7E, 0x7ACF, 0x11DD, [0xA2, 0x43, 0xE5, 0x11, 0x56, 0xD8, 0x95, 0x93]};
@GUID(0xD0D1BF7E, 0x7ACF, 0x11DD, [0xA2, 0x43, 0xE5, 0x11, 0x56, 0xD8, 0x95, 0x93]);
interface ITsSbEnvironmentPropertySet : ITsSbPropertySet
{
}

const GUID IID_ITsSbBaseNotifySink = {0x808A6537, 0x1282, 0x4989, [0x9E, 0x09, 0xF4, 0x39, 0x38, 0xB7, 0x17, 0x22]};
@GUID(0x808A6537, 0x1282, 0x4989, [0x9E, 0x09, 0xF4, 0x39, 0x38, 0xB7, 0x17, 0x22]);
interface ITsSbBaseNotifySink : IUnknown
{
    HRESULT OnError(HRESULT hrError);
    HRESULT OnReportStatus(CLIENT_MESSAGE_TYPE messageType, uint messageID);
}

const GUID IID_ITsSbPluginNotifySink = {0x44DFE30B, 0xC3BE, 0x40F5, [0xBF, 0x82, 0x7A, 0x95, 0xBB, 0x79, 0x5A, 0xDF]};
@GUID(0x44DFE30B, 0xC3BE, 0x40F5, [0xBF, 0x82, 0x7A, 0x95, 0xBB, 0x79, 0x5A, 0xDF]);
interface ITsSbPluginNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnInitialized(HRESULT hr);
    HRESULT OnTerminated();
}

const GUID IID_ITsSbLoadBalancingNotifySink = {0x5F8A8297, 0x3244, 0x4E6A, [0x95, 0x8A, 0x27, 0xC8, 0x22, 0xC1, 0xE1, 0x41]};
@GUID(0x5F8A8297, 0x3244, 0x4E6A, [0x95, 0x8A, 0x27, 0xC8, 0x22, 0xC1, 0xE1, 0x41]);
interface ITsSbLoadBalancingNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnGetMostSuitableTarget(ITsSbLoadBalanceResult pLBResult, BOOL fIsNewConnection);
}

const GUID IID_ITsSbPlacementNotifySink = {0x68A0C487, 0x2B4F, 0x46C2, [0x94, 0xA1, 0x6C, 0xE6, 0x85, 0x18, 0x36, 0x34]};
@GUID(0x68A0C487, 0x2B4F, 0x46C2, [0x94, 0xA1, 0x6C, 0xE6, 0x85, 0x18, 0x36, 0x34]);
interface ITsSbPlacementNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnQueryEnvironmentCompleted(ITsSbEnvironment pEnvironment);
}

const GUID IID_ITsSbOrchestrationNotifySink = {0x36C37D61, 0x926B, 0x442F, [0xBC, 0xA5, 0x11, 0x8C, 0x6D, 0x50, 0xDC, 0xF2]};
@GUID(0x36C37D61, 0x926B, 0x442F, [0xBC, 0xA5, 0x11, 0x8C, 0x6D, 0x50, 0xDC, 0xF2]);
interface ITsSbOrchestrationNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnReadyToConnect(ITsSbTarget pTarget);
}

const GUID IID_ITsSbTaskPluginNotifySink = {0x6AAF899E, 0xC2EC, 0x45EE, [0xAA, 0x37, 0x45, 0xE6, 0x08, 0x95, 0x26, 0x1A]};
@GUID(0x6AAF899E, 0xC2EC, 0x45EE, [0xAA, 0x37, 0x45, 0xE6, 0x08, 0x95, 0x26, 0x1A]);
interface ITsSbTaskPluginNotifySink : ITsSbBaseNotifySink
{
    HRESULT OnSetTaskTime(BSTR szTargetName, FILETIME TaskStartTime, FILETIME TaskEndTime, FILETIME TaskDeadline, BSTR szTaskLabel, BSTR szTaskIdentifier, BSTR szTaskPlugin, uint dwTaskStatus, SAFEARRAY* saContext);
    HRESULT OnDeleteTaskTime(BSTR szTargetName, BSTR szTaskIdentifier);
    HRESULT OnUpdateTaskStatus(BSTR szTargetName, BSTR TaskIdentifier, RDV_TASK_STATUS TaskStatus);
    HRESULT OnReportTasks(BSTR szHostName);
}

const GUID IID_ITsSbClientConnection = {0x18857499, 0xAD61, 0x4B1B, [0xB7, 0xDF, 0xCB, 0xCD, 0x41, 0xFB, 0x83, 0x38]};
@GUID(0x18857499, 0xAD61, 0x4B1B, [0xB7, 0xDF, 0xCB, 0xCD, 0x41, 0xFB, 0x83, 0x38]);
interface ITsSbClientConnection : IUnknown
{
    HRESULT get_UserName(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT get_InitialProgram(BSTR* pVal);
    HRESULT get_LoadBalanceResult(ITsSbLoadBalanceResult* ppVal);
    HRESULT get_FarmName(BSTR* pVal);
    HRESULT PutContext(BSTR contextId, VARIANT context, VARIANT* existingContext);
    HRESULT GetContext(BSTR contextId, VARIANT* context);
    HRESULT get_Environment(ITsSbEnvironment* ppEnvironment);
    HRESULT get_ConnectionError();
    HRESULT get_SamUserAccount(BSTR* pVal);
    HRESULT get_ClientConnectionPropertySet(ITsSbClientConnectionPropertySet* ppPropertySet);
    HRESULT get_IsFirstAssignment(int* ppVal);
    HRESULT get_RdFarmType(RD_FARM_TYPE* pRdFarmType);
    HRESULT get_UserSidString(byte** pszUserSidString);
    HRESULT GetDisconnectedSession(ITsSbSession* ppSession);
}

const GUID IID_ITsSbProvider = {0x87A4098F, 0x6D7B, 0x44DD, [0xBC, 0x17, 0x8C, 0xE4, 0x4E, 0x37, 0x0D, 0x52]};
@GUID(0x87A4098F, 0x6D7B, 0x44DD, [0xBC, 0x17, 0x8C, 0xE4, 0x4E, 0x37, 0x0D, 0x52]);
interface ITsSbProvider : IUnknown
{
    HRESULT CreateTargetObject(BSTR TargetName, BSTR EnvironmentName, ITsSbTarget* ppTarget);
    HRESULT CreateLoadBalanceResultObject(BSTR TargetName, ITsSbLoadBalanceResult* ppLBResult);
    HRESULT CreateSessionObject(BSTR TargetName, BSTR UserName, BSTR Domain, uint SessionId, ITsSbSession* ppSession);
    HRESULT CreatePluginPropertySet(ITsSbPluginPropertySet* ppPropertySet);
    HRESULT CreateTargetPropertySetObject(ITsSbTargetPropertySet* ppPropertySet);
    HRESULT CreateEnvironmentObject(BSTR Name, uint ServerWeight, ITsSbEnvironment* ppEnvironment);
    HRESULT GetResourcePluginStore(ITsSbResourcePluginStore* ppStore);
    HRESULT GetFilterPluginStore(ITsSbFilterPluginStore* ppStore);
    HRESULT RegisterForNotification(uint notificationType, BSTR ResourceToMonitor, ITsSbResourceNotification pPluginNotification);
    HRESULT UnRegisterForNotification(uint notificationType, BSTR ResourceToMonitor);
    HRESULT GetInstanceOfGlobalStore(ITsSbGlobalStore* ppGlobalStore);
    HRESULT CreateEnvironmentPropertySetObject(ITsSbEnvironmentPropertySet* ppPropertySet);
}

const GUID IID_ITsSbResourcePluginStore = {0x5C38F65F, 0xBCF1, 0x4036, [0xA6, 0xBF, 0x9E, 0x3C, 0xCC, 0xAE, 0x0B, 0x63]};
@GUID(0x5C38F65F, 0xBCF1, 0x4036, [0xA6, 0xBF, 0x9E, 0x3C, 0xCC, 0xAE, 0x0B, 0x63]);
interface ITsSbResourcePluginStore : IUnknown
{
    HRESULT QueryTarget(BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    HRESULT QuerySessionBySessionId(uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    HRESULT AddTargetToStore(ITsSbTarget pTarget);
    HRESULT AddSessionToStore(ITsSbSession pSession);
    HRESULT AddEnvironmentToStore(ITsSbEnvironment pEnvironment);
    HRESULT RemoveEnvironmentFromStore(BSTR EnvironmentName, BOOL bIgnoreOwner);
    HRESULT EnumerateFarms(uint* pdwCount, SAFEARRAY** pVal);
    HRESULT QueryEnvironment(BSTR EnvironmentName, ITsSbEnvironment* ppEnvironment);
    HRESULT EnumerateEnvironments(uint* pdwCount, char* pVal);
    HRESULT SaveTarget(ITsSbTarget pTarget, BOOL bForceWrite);
    HRESULT SaveEnvironment(ITsSbEnvironment pEnvironment, BOOL bForceWrite);
    HRESULT SaveSession(ITsSbSession pSession);
    HRESULT SetTargetProperty(BSTR TargetName, BSTR PropertyName, VARIANT* pProperty);
    HRESULT SetEnvironmentProperty(BSTR EnvironmentName, BSTR PropertyName, VARIANT* pProperty);
    HRESULT SetTargetState(BSTR targetName, TARGET_STATE newState, TARGET_STATE* pOldState);
    HRESULT SetSessionState(ITsSbSession sbSession);
    HRESULT EnumerateTargets(BSTR FarmName, BSTR EnvName, TS_SB_SORT_BY sortByFieldId, BSTR sortyByPropName, uint* pdwCount, char* pVal);
    HRESULT EnumerateSessions(BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, BSTR initialProgram, TSSESSION_STATE* pSessionState, uint* pdwCount, char* ppVal);
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
    HRESULT DeleteTarget(BSTR targetName, BSTR hostName);
    HRESULT SetTargetPropertyWithVersionCheck(ITsSbTarget pTarget, BSTR PropertyName, VARIANT* pProperty);
    HRESULT SetEnvironmentPropertyWithVersionCheck(ITsSbEnvironment pEnvironment, BSTR PropertyName, VARIANT* pProperty);
    HRESULT AcquireTargetLock(BSTR targetName, uint dwTimeout, IUnknown* ppContext);
    HRESULT ReleaseTargetLock(IUnknown pContext);
    HRESULT TestAndSetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE NewState, TARGET_STATE TestState, TARGET_STATE* pInitState);
    HRESULT SetServerWaitingToStart(BSTR PoolName, BSTR serverName);
    HRESULT GetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE* pState);
    HRESULT SetServerDrainMode(BSTR ServerFQDN, uint DrainMode);
}

const GUID IID_ITsSbFilterPluginStore = {0x85B44B0F, 0xED78, 0x413F, [0x97, 0x02, 0xFA, 0x6D, 0x3B, 0x5E, 0xE7, 0x55]};
@GUID(0x85B44B0F, 0xED78, 0x413F, [0x97, 0x02, 0xFA, 0x6D, 0x3B, 0x5E, 0xE7, 0x55]);
interface ITsSbFilterPluginStore : IUnknown
{
    HRESULT SaveProperties(ITsSbPropertySet pPropertySet);
    HRESULT EnumerateProperties(ITsSbPropertySet* ppPropertySet);
    HRESULT DeleteProperties(BSTR propertyName);
}

const GUID IID_ITsSbGlobalStore = {0x9AB60F7B, 0xBD72, 0x4D9F, [0x8A, 0x3A, 0xA0, 0xEA, 0x55, 0x74, 0xE6, 0x35]};
@GUID(0x9AB60F7B, 0xBD72, 0x4D9F, [0x8A, 0x3A, 0xA0, 0xEA, 0x55, 0x74, 0xE6, 0x35]);
interface ITsSbGlobalStore : IUnknown
{
    HRESULT QueryTarget(BSTR ProviderName, BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    HRESULT QuerySessionBySessionId(BSTR ProviderName, uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    HRESULT EnumerateFarms(BSTR ProviderName, uint* pdwCount, SAFEARRAY** pVal);
    HRESULT EnumerateTargets(BSTR ProviderName, BSTR FarmName, BSTR EnvName, uint* pdwCount, char* pVal);
    HRESULT EnumerateEnvironmentsByProvider(BSTR ProviderName, uint* pdwCount, char* ppVal);
    HRESULT EnumerateSessions(BSTR ProviderName, BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, BSTR initialProgram, TSSESSION_STATE* pSessionState, uint* pdwCount, char* ppVal);
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
}

const GUID IID_ITsSbProvisioningPluginNotifySink = {0xACA87A8E, 0x818B, 0x4581, [0xA0, 0x32, 0x49, 0xC3, 0xDF, 0xB9, 0xC7, 0x01]};
@GUID(0xACA87A8E, 0x818B, 0x4581, [0xA0, 0x32, 0x49, 0xC3, 0xDF, 0xB9, 0xC7, 0x01]);
interface ITsSbProvisioningPluginNotifySink : IUnknown
{
    HRESULT OnJobCreated(VM_NOTIFY_INFO* pVmNotifyInfo);
    HRESULT OnVirtualMachineStatusChanged(VM_NOTIFY_ENTRY* pVmNotifyEntry, VM_NOTIFY_STATUS VmNotifyStatus, HRESULT ErrorCode, BSTR ErrorDescr);
    HRESULT OnJobCompleted(HRESULT ResultCode, BSTR ResultDescription);
    HRESULT OnJobCancelled();
    HRESULT LockVirtualMachine(VM_NOTIFY_ENTRY* pVmNotifyEntry);
    HRESULT OnVirtualMachineHostStatusChanged(BSTR VmHost, VM_HOST_NOTIFY_STATUS VmHostNotifyStatus, HRESULT ErrorCode, BSTR ErrorDescr);
}

const GUID IID_ITsSbProvisioning = {0x2F6F0DBB, 0x9E4F, 0x462B, [0x9C, 0x3F, 0xFC, 0xCC, 0x3D, 0xCB, 0x62, 0x32]};
@GUID(0x2F6F0DBB, 0x9E4F, 0x462B, [0x9C, 0x3F, 0xFC, 0xCC, 0x3D, 0xCB, 0x62, 0x32]);
interface ITsSbProvisioning : ITsSbPlugin
{
    HRESULT CreateVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    HRESULT PatchVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink, VM_PATCH_INFO* pVMPatchInfo);
    HRESULT DeleteVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    HRESULT CancelJob(BSTR JobGuid);
}

const GUID IID_ITsSbGenericNotifySink = {0x4C4C8C4F, 0x300B, 0x46AD, [0x91, 0x64, 0x84, 0x68, 0xA7, 0xE7, 0x56, 0x8C]};
@GUID(0x4C4C8C4F, 0x300B, 0x46AD, [0x91, 0x64, 0x84, 0x68, 0xA7, 0xE7, 0x56, 0x8C]);
interface ITsSbGenericNotifySink : IUnknown
{
    HRESULT OnCompleted(HRESULT Status);
    HRESULT GetWaitTimeout(FILETIME* pftTimeout);
}

struct pluginResource
{
    ushort alias;
    ushort name;
    ushort* resourceFileContents;
    ushort fileExtension;
    ushort resourcePluginType;
    ubyte isDiscoverable;
    int resourceType;
    uint pceIconSize;
    ubyte* iconContents;
    uint pcePluginBlobSize;
    ubyte* blobContents;
}

const GUID IID_ItsPubPlugin = {0x70C04B05, 0xF347, 0x412B, [0x82, 0x2F, 0x36, 0xC9, 0x9C, 0x54, 0xCA, 0x45]};
@GUID(0x70C04B05, 0xF347, 0x412B, [0x82, 0x2F, 0x36, 0xC9, 0x9C, 0x54, 0xCA, 0x45]);
interface ItsPubPlugin : IUnknown
{
    HRESULT GetResourceList(const(wchar)* userID, int* pceAppListSize, pluginResource** resourceList);
    HRESULT GetResource(const(wchar)* alias, int flags, pluginResource* resource);
    HRESULT GetCacheLastUpdateTime(ulong* lastUpdateTime);
    HRESULT get_pluginName(BSTR* pVal);
    HRESULT get_pluginVersion(BSTR* pVal);
    HRESULT ResolveResource(uint* resourceType, char* resourceLocation, char* endPointName, ushort* userID, ushort* alias);
}

struct pluginResource2FileAssociation
{
    ushort extName;
    ubyte primaryHandler;
    uint pceIconSize;
    ubyte* iconContents;
}

struct pluginResource2
{
    pluginResource resourceV1;
    uint pceFileAssocListSize;
    pluginResource2FileAssociation* fileAssocList;
    ushort* securityDescriptor;
    uint pceFolderListSize;
    ushort** folderList;
}

enum TSPUB_PLUGIN_PD_RESOLUTION_TYPE
{
    TSPUB_PLUGIN_PD_QUERY_OR_CREATE = 0,
    TSPUB_PLUGIN_PD_QUERY_EXISTING = 1,
}

enum TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE
{
    TSPUB_PLUGIN_PD_ASSIGNMENT_NEW = 0,
    TSPUB_PLUGIN_PD_ASSIGNMENT_EXISTING = 1,
}

const GUID IID_ItsPubPlugin2 = {0xFA4CE418, 0xAAD7, 0x4EC6, [0xBA, 0xD1, 0x0A, 0x32, 0x1B, 0xA4, 0x65, 0xD5]};
@GUID(0xFA4CE418, 0xAAD7, 0x4EC6, [0xBA, 0xD1, 0x0A, 0x32, 0x1B, 0xA4, 0x65, 0xD5]);
interface ItsPubPlugin2 : ItsPubPlugin
{
    HRESULT GetResource2List(const(wchar)* userID, int* pceAppListSize, pluginResource2** resourceList);
    HRESULT GetResource2(const(wchar)* alias, int flags, pluginResource2* resource);
    HRESULT ResolvePersonalDesktop(const(ushort)* userId, const(ushort)* poolId, TSPUB_PLUGIN_PD_RESOLUTION_TYPE ePdResolutionType, TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE* pPdAssignmentType, char* endPointName);
    HRESULT DeletePersonalDesktopAssignment(const(ushort)* userId, const(ushort)* poolId, const(ushort)* endpointName);
}

const GUID IID_IWorkspaceResTypeRegistry = {0x1D428C79, 0x6E2E, 0x4351, [0xA3, 0x61, 0xC0, 0x40, 0x1A, 0x03, 0xA0, 0xBA]};
@GUID(0x1D428C79, 0x6E2E, 0x4351, [0xA3, 0x61, 0xC0, 0x40, 0x1A, 0x03, 0xA0, 0xBA]);
interface IWorkspaceResTypeRegistry : IDispatch
{
    HRESULT AddResourceType(short fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
    HRESULT DeleteResourceType(short fMachineWide, BSTR bstrFileExtension);
    HRESULT GetRegisteredFileExtensions(short fMachineWide, SAFEARRAY** psaFileExtensions);
    HRESULT GetResourceTypeInfo(short fMachineWide, BSTR bstrFileExtension, BSTR* pbstrLauncher);
    HRESULT ModifyResourceType(short fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
}

const GUID IID_IWTSPlugin = {0xA1230201, 0x1439, 0x4E62, [0xA4, 0x14, 0x19, 0x0D, 0x0A, 0xC3, 0xD4, 0x0E]};
@GUID(0xA1230201, 0x1439, 0x4E62, [0xA4, 0x14, 0x19, 0x0D, 0x0A, 0xC3, 0xD4, 0x0E]);
interface IWTSPlugin : IUnknown
{
    HRESULT Initialize(IWTSVirtualChannelManager pChannelMgr);
    HRESULT Connected();
    HRESULT Disconnected(uint dwDisconnectCode);
    HRESULT Terminated();
}

const GUID IID_IWTSListener = {0xA1230206, 0x9A39, 0x4D58, [0x86, 0x74, 0xCD, 0xB4, 0xDF, 0xF4, 0xE7, 0x3B]};
@GUID(0xA1230206, 0x9A39, 0x4D58, [0x86, 0x74, 0xCD, 0xB4, 0xDF, 0xF4, 0xE7, 0x3B]);
interface IWTSListener : IUnknown
{
    HRESULT GetConfiguration(IPropertyBag* ppPropertyBag);
}

const GUID IID_IWTSListenerCallback = {0xA1230203, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]};
@GUID(0xA1230203, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]);
interface IWTSListenerCallback : IUnknown
{
    HRESULT OnNewChannelConnection(IWTSVirtualChannel pChannel, BSTR data, int* pbAccept, IWTSVirtualChannelCallback* ppCallback);
}

const GUID IID_IWTSVirtualChannelCallback = {0xA1230204, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]};
@GUID(0xA1230204, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]);
interface IWTSVirtualChannelCallback : IUnknown
{
    HRESULT OnDataReceived(uint cbSize, char* pBuffer);
    HRESULT OnClose();
}

const GUID IID_IWTSVirtualChannelManager = {0xA1230205, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]};
@GUID(0xA1230205, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]);
interface IWTSVirtualChannelManager : IUnknown
{
    HRESULT CreateListener(const(byte)* pszChannelName, uint uFlags, IWTSListenerCallback pListenerCallback, IWTSListener* ppListener);
}

const GUID IID_IWTSVirtualChannel = {0xA1230207, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]};
@GUID(0xA1230207, 0xD6A7, 0x11D8, [0xB9, 0xFD, 0x00, 0x0B, 0xDB, 0xD1, 0xF1, 0x98]);
interface IWTSVirtualChannel : IUnknown
{
    HRESULT Write(uint cbSize, char* pBuffer, IUnknown pReserved);
    HRESULT Close();
}

const GUID IID_IWTSPluginServiceProvider = {0xD3E07363, 0x087C, 0x476C, [0x86, 0xA7, 0xDB, 0xB1, 0x5F, 0x46, 0xDD, 0xB4]};
@GUID(0xD3E07363, 0x087C, 0x476C, [0x86, 0xA7, 0xDB, 0xB1, 0x5F, 0x46, 0xDD, 0xB4]);
interface IWTSPluginServiceProvider : IUnknown
{
    HRESULT GetService(Guid ServiceId, IUnknown* ppunkObject);
}

struct BITMAP_RENDERER_STATISTICS
{
    uint dwFramesDelivered;
    uint dwFramesDropped;
}

const GUID IID_IWTSBitmapRenderer = {0x5B7ACC97, 0xF3C9, 0x46F7, [0x8C, 0x5B, 0xFA, 0x68, 0x5D, 0x34, 0x41, 0xB1]};
@GUID(0x5B7ACC97, 0xF3C9, 0x46F7, [0x8C, 0x5B, 0xFA, 0x68, 0x5D, 0x34, 0x41, 0xB1]);
interface IWTSBitmapRenderer : IUnknown
{
    HRESULT Render(Guid imageFormat, uint dwWidth, uint dwHeight, int cbStride, uint cbImageBuffer, char* pImageBuffer);
    HRESULT GetRendererStatistics(BITMAP_RENDERER_STATISTICS* pStatistics);
    HRESULT RemoveMapping();
}

const GUID IID_IWTSBitmapRendererCallback = {0xD782928E, 0xFE4E, 0x4E77, [0xAE, 0x90, 0x9C, 0xD0, 0xB3, 0xE3, 0xB3, 0x53]};
@GUID(0xD782928E, 0xFE4E, 0x4E77, [0xAE, 0x90, 0x9C, 0xD0, 0xB3, 0xE3, 0xB3, 0x53]);
interface IWTSBitmapRendererCallback : IUnknown
{
    HRESULT OnTargetSizeChanged(RECT rcNewSize);
}

const GUID IID_IWTSBitmapRenderService = {0xEA326091, 0x05FE, 0x40C1, [0xB4, 0x9C, 0x3D, 0x2E, 0xF4, 0x62, 0x6A, 0x0E]};
@GUID(0xEA326091, 0x05FE, 0x40C1, [0xB4, 0x9C, 0x3D, 0x2E, 0xF4, 0x62, 0x6A, 0x0E]);
interface IWTSBitmapRenderService : IUnknown
{
    HRESULT GetMappedRenderer(ulong mappingId, IWTSBitmapRendererCallback pMappedRendererCallback, IWTSBitmapRenderer* ppMappedRenderer);
}

const GUID IID_IWRdsGraphicsChannelEvents = {0x67F2368C, 0xD674, 0x4FAE, [0x66, 0xA5, 0xD2, 0x06, 0x28, 0xA6, 0x40, 0xD2]};
@GUID(0x67F2368C, 0xD674, 0x4FAE, [0x66, 0xA5, 0xD2, 0x06, 0x28, 0xA6, 0x40, 0xD2]);
interface IWRdsGraphicsChannelEvents : IUnknown
{
    HRESULT OnDataReceived(uint cbSize, ubyte* pBuffer);
    HRESULT OnClose();
    HRESULT OnChannelOpened(HRESULT OpenResult, IUnknown pOpenContext);
    HRESULT OnDataSent(IUnknown pWriteContext, BOOL bCancelled, ubyte* pBuffer, uint cbBuffer);
    HRESULT OnMetricsUpdate(uint bandwidth, uint RTT, ulong lastSentByteIndex);
}

const GUID IID_IWRdsGraphicsChannel = {0x684B7A0B, 0xEDFF, 0x43AD, [0xD5, 0xA2, 0x4A, 0x8D, 0x53, 0x88, 0xF4, 0x01]};
@GUID(0x684B7A0B, 0xEDFF, 0x43AD, [0xD5, 0xA2, 0x4A, 0x8D, 0x53, 0x88, 0xF4, 0x01]);
interface IWRdsGraphicsChannel : IUnknown
{
    HRESULT Write(uint cbSize, ubyte* pBuffer, IUnknown pContext);
    HRESULT Close();
    HRESULT Open(IWRdsGraphicsChannelEvents pChannelEvents, IUnknown pOpenContext);
}

enum WRdsGraphicsChannelType
{
    WRdsGraphicsChannelType_GuaranteedDelivery = 0,
    WRdsGraphicsChannelType_BestEffortDelivery = 1,
}

const GUID IID_IWRdsGraphicsChannelManager = {0x0FD57159, 0xE83E, 0x476A, [0xA8, 0xB9, 0x4A, 0x79, 0x76, 0xE7, 0x1E, 0x18]};
@GUID(0x0FD57159, 0xE83E, 0x476A, [0xA8, 0xB9, 0x4A, 0x79, 0x76, 0xE7, 0x1E, 0x18]);
interface IWRdsGraphicsChannelManager : IUnknown
{
    HRESULT CreateChannel(const(byte)* pszChannelName, WRdsGraphicsChannelType channelType, IWRdsGraphicsChannel* ppVirtualChannel);
}

struct RFX_GFX_RECT
{
    int left;
    int top;
    int right;
    int bottom;
}

struct RFX_GFX_MSG_HEADER
{
    ushort uMSGType;
    ushort cbSize;
}

struct RFX_GFX_MONITOR_INFO
{
    int left;
    int top;
    int right;
    int bottom;
    uint physicalWidth;
    uint physicalHeight;
    uint orientation;
    BOOL primary;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_RESPONSE
{
    RFX_GFX_MSG_HEADER channelHdr;
    uint reserved;
    uint monitorCount;
    RFX_GFX_MONITOR_INFO MonitorData;
    ushort clientUniqueId;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_NOTIFY
{
    RFX_GFX_MSG_HEADER channelHdr;
    uint ulWidth;
    uint ulHeight;
    uint ulBpp;
    uint Reserved;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_CONFIRM
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_DESKTOP_INPUT_RESET
{
    RFX_GFX_MSG_HEADER channelHdr;
    uint ulWidth;
    uint ulHeight;
}

struct RFX_GFX_MSG_DISCONNECT_NOTIFY
{
    RFX_GFX_MSG_HEADER channelHdr;
    uint DisconnectReason;
}

struct RFX_GFX_MSG_DESKTOP_RESEND_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
    RFX_GFX_RECT RedrawRect;
}

struct RFX_GFX_MSG_RDP_DATA
{
    RFX_GFX_MSG_HEADER channelHdr;
    ubyte rdpData;
}

struct WTS_SOCKADDR
{
    ushort sin_family;
    _u_e__Union u;
}

struct WTS_SMALL_RECT
{
    short Left;
    short Top;
    short Right;
    short Bottom;
}

enum WTS_RCM_SERVICE_STATE
{
    WTS_SERVICE_NONE = 0,
    WTS_SERVICE_START = 1,
    WTS_SERVICE_STOP = 2,
}

enum WTS_RCM_DRAIN_STATE
{
    WTS_DRAIN_STATE_NONE = 0,
    WTS_DRAIN_IN_DRAIN = 1,
    WTS_DRAIN_NOT_IN_DRAIN = 2,
}

struct WTS_SERVICE_STATE
{
    WTS_RCM_SERVICE_STATE RcmServiceState;
    WTS_RCM_DRAIN_STATE RcmDrainState;
}

struct WTS_SESSION_ID
{
    Guid SessionUniqueGuid;
    uint SessionId;
}

struct WTS_USER_CREDENTIAL
{
    ushort UserName;
    ushort Password;
    ushort Domain;
}

struct WTS_SYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

struct WTS_TIME_ZONE_INFORMATION
{
    int Bias;
    ushort StandardName;
    WTS_SYSTEMTIME StandardDate;
    int StandardBias;
    ushort DaylightName;
    WTS_SYSTEMTIME DaylightDate;
    int DaylightBias;
}

struct WRDS_DYNAMIC_TIME_ZONE_INFORMATION
{
    int Bias;
    ushort StandardName;
    WTS_SYSTEMTIME StandardDate;
    int StandardBias;
    ushort DaylightName;
    WTS_SYSTEMTIME DaylightDate;
    int DaylightBias;
    ushort TimeZoneKeyName;
    ushort DynamicDaylightTimeDisabled;
}

struct WTS_CLIENT_DATA
{
    ubyte fDisableCtrlAltDel;
    ubyte fDoubleClickDetect;
    ubyte fEnableWindowsKey;
    ubyte fHideTitleBar;
    BOOL fInheritAutoLogon;
    ubyte fPromptForPassword;
    ubyte fUsingSavedCreds;
    ushort Domain;
    ushort UserName;
    ushort Password;
    ubyte fPasswordIsScPin;
    BOOL fInheritInitialProgram;
    ushort WorkDirectory;
    ushort InitialProgram;
    ubyte fMaximizeShell;
    ubyte EncryptionLevel;
    uint PerformanceFlags;
    ushort ProtocolName;
    ushort ProtocolType;
    BOOL fInheritColorDepth;
    ushort HRes;
    ushort VRes;
    ushort ColorDepth;
    ushort DisplayDriverName;
    ushort DisplayDeviceName;
    ubyte fMouse;
    uint KeyboardLayout;
    uint KeyboardType;
    uint KeyboardSubType;
    uint KeyboardFunctionKey;
    ushort imeFileName;
    uint ActiveInputLocale;
    ubyte fNoAudioPlayback;
    ubyte fRemoteConsoleAudio;
    ushort AudioDriverName;
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    ushort ClientName;
    uint SerialNumber;
    uint ClientAddressFamily;
    ushort ClientAddress;
    WTS_SOCKADDR ClientSockAddress;
    ushort ClientDirectory;
    uint ClientBuildNumber;
    ushort ClientProductId;
    ushort OutBufCountHost;
    ushort OutBufCountClient;
    ushort OutBufLength;
    uint ClientSessionId;
    ushort ClientDigProductId;
    ubyte fDisableCpm;
    ubyte fDisableCdm;
    ubyte fDisableCcm;
    ubyte fDisableLPT;
    ubyte fDisableClip;
    ubyte fDisablePNP;
}

struct WTS_USER_DATA
{
    ushort WorkDirectory;
    ushort InitialProgram;
    WTS_TIME_ZONE_INFORMATION UserTimeZone;
}

struct WTS_POLICY_DATA
{
    ubyte fDisableEncryption;
    ubyte fDisableAutoReconnect;
    uint ColorDepth;
    ubyte MinEncryptionLevel;
    ubyte fDisableCpm;
    ubyte fDisableCdm;
    ubyte fDisableCcm;
    ubyte fDisableLPT;
    ubyte fDisableClip;
    ubyte fDisablePNPRedir;
}

struct WTS_PROTOCOL_CACHE
{
    uint CacheReads;
    uint CacheHits;
}

struct WTS_CACHE_STATS_UN
{
    WTS_PROTOCOL_CACHE ProtocolCache;
    uint TShareCacheStats;
    uint Reserved;
}

struct WTS_CACHE_STATS
{
    uint Specific;
    WTS_CACHE_STATS_UN Data;
    ushort ProtocolType;
    ushort Length;
}

struct WTS_PROTOCOL_COUNTERS
{
    uint WdBytes;
    uint WdFrames;
    uint WaitForOutBuf;
    uint Frames;
    uint Bytes;
    uint CompressedBytes;
    uint CompressFlushes;
    uint Errors;
    uint Timeouts;
    uint AsyncFramingError;
    uint AsyncOverrunError;
    uint AsyncOverflowError;
    uint AsyncParityError;
    uint TdErrors;
    ushort ProtocolType;
    ushort Length;
    ushort Specific;
    uint Reserved;
}

struct WTS_PROTOCOL_STATUS
{
    WTS_PROTOCOL_COUNTERS Output;
    WTS_PROTOCOL_COUNTERS Input;
    WTS_CACHE_STATS Cache;
    uint AsyncSignal;
    uint AsyncSignalMask;
    LARGE_INTEGER Counters;
}

struct WTS_DISPLAY_IOCTL
{
    ubyte pDisplayIOCtlData;
    uint cbDisplayIOCtlData;
}

enum WTS_LOGON_ERROR_REDIRECTOR_RESPONSE
{
    WTS_LOGON_ERR_INVALID = 0,
    WTS_LOGON_ERR_NOT_HANDLED = 1,
    WTS_LOGON_ERR_HANDLED_SHOW = 2,
    WTS_LOGON_ERR_HANDLED_DONT_SHOW = 3,
    WTS_LOGON_ERR_HANDLED_DONT_SHOW_START_OVER = 4,
}

struct WTS_PROPERTY_VALUE
{
    ushort Type;
    _u_e__Union u;
}

enum WTS_CERT_TYPE
{
    WTS_CERT_TYPE_INVALID = 0,
    WTS_CERT_TYPE_PROPRIETORY = 1,
    WTS_CERT_TYPE_X509 = 2,
}

struct WTS_LICENSE_CAPABILITIES
{
    uint KeyExchangeAlg;
    uint ProtocolVer;
    BOOL fAuthenticateServer;
    WTS_CERT_TYPE CertType;
    uint cbClientName;
    ubyte rgbClientName;
}

enum WRDS_CONNECTION_SETTING_LEVEL
{
    WRDS_CONNECTION_SETTING_LEVEL_INVALID = 0,
    WRDS_CONNECTION_SETTING_LEVEL_1 = 1,
}

enum WRDS_LISTENER_SETTING_LEVEL
{
    WRDS_LISTENER_SETTING_LEVEL_INVALID = 0,
    WRDS_LISTENER_SETTING_LEVEL_1 = 1,
}

enum WRDS_SETTING_TYPE
{
    WRDS_SETTING_TYPE_INVALID = 0,
    WRDS_SETTING_TYPE_MACHINE = 1,
    WRDS_SETTING_TYPE_USER = 2,
    WRDS_SETTING_TYPE_SAM = 3,
}

enum WRDS_SETTING_STATUS
{
    WRDS_SETTING_STATUS_NOTAPPLICABLE = -1,
    WRDS_SETTING_STATUS_DISABLED = 0,
    WRDS_SETTING_STATUS_ENABLED = 1,
    WRDS_SETTING_STATUS_NOTCONFIGURED = 2,
}

enum WRDS_SETTING_LEVEL
{
    WRDS_SETTING_LEVEL_INVALID = 0,
    WRDS_SETTING_LEVEL_1 = 1,
}

struct WRDS_LISTENER_SETTINGS_1
{
    uint MaxProtocolListenerConnectionCount;
    uint SecurityDescriptorSize;
    ubyte* pSecurityDescriptor;
}

struct WRDS_LISTENER_SETTING
{
    WRDS_LISTENER_SETTINGS_1 WRdsListenerSettings1;
}

struct WRDS_LISTENER_SETTINGS
{
    WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel;
    WRDS_LISTENER_SETTING WRdsListenerSetting;
}

struct WRDS_CONNECTION_SETTINGS_1
{
    ubyte fInheritInitialProgram;
    ubyte fInheritColorDepth;
    ubyte fHideTitleBar;
    ubyte fInheritAutoLogon;
    ubyte fMaximizeShell;
    ubyte fDisablePNP;
    ubyte fPasswordIsScPin;
    ubyte fPromptForPassword;
    ubyte fDisableCpm;
    ubyte fDisableCdm;
    ubyte fDisableCcm;
    ubyte fDisableLPT;
    ubyte fDisableClip;
    ubyte fResetBroken;
    ubyte fDisableEncryption;
    ubyte fDisableAutoReconnect;
    ubyte fDisableCtrlAltDel;
    ubyte fDoubleClickDetect;
    ubyte fEnableWindowsKey;
    ubyte fUsingSavedCreds;
    ubyte fMouse;
    ubyte fNoAudioPlayback;
    ubyte fRemoteConsoleAudio;
    ubyte EncryptionLevel;
    ushort ColorDepth;
    ushort ProtocolType;
    ushort HRes;
    ushort VRes;
    ushort ClientProductId;
    ushort OutBufCountHost;
    ushort OutBufCountClient;
    ushort OutBufLength;
    uint KeyboardLayout;
    uint MaxConnectionTime;
    uint MaxDisconnectionTime;
    uint MaxIdleTime;
    uint PerformanceFlags;
    uint KeyboardType;
    uint KeyboardSubType;
    uint KeyboardFunctionKey;
    uint ActiveInputLocale;
    uint SerialNumber;
    uint ClientAddressFamily;
    uint ClientBuildNumber;
    uint ClientSessionId;
    ushort WorkDirectory;
    ushort InitialProgram;
    ushort UserName;
    ushort Domain;
    ushort Password;
    ushort ProtocolName;
    ushort DisplayDriverName;
    ushort DisplayDeviceName;
    ushort imeFileName;
    ushort AudioDriverName;
    ushort ClientName;
    ushort ClientAddress;
    ushort ClientDirectory;
    ushort ClientDigProductId;
    WTS_SOCKADDR ClientSockAddress;
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    WRDS_LISTENER_SETTINGS WRdsListenerSettings;
    Guid EventLogActivityId;
    uint ContextSize;
    ubyte* ContextData;
}

struct WRDS_SETTINGS_1
{
    WRDS_SETTING_STATUS WRdsDisableClipStatus;
    uint WRdsDisableClipValue;
    WRDS_SETTING_STATUS WRdsDisableLPTStatus;
    uint WRdsDisableLPTValue;
    WRDS_SETTING_STATUS WRdsDisableCcmStatus;
    uint WRdsDisableCcmValue;
    WRDS_SETTING_STATUS WRdsDisableCdmStatus;
    uint WRdsDisableCdmValue;
    WRDS_SETTING_STATUS WRdsDisableCpmStatus;
    uint WRdsDisableCpmValue;
    WRDS_SETTING_STATUS WRdsDisablePnpStatus;
    uint WRdsDisablePnpValue;
    WRDS_SETTING_STATUS WRdsEncryptionLevelStatus;
    uint WRdsEncryptionValue;
    WRDS_SETTING_STATUS WRdsColorDepthStatus;
    uint WRdsColorDepthValue;
    WRDS_SETTING_STATUS WRdsDisableAutoReconnecetStatus;
    uint WRdsDisableAutoReconnecetValue;
    WRDS_SETTING_STATUS WRdsDisableEncryptionStatus;
    uint WRdsDisableEncryptionValue;
    WRDS_SETTING_STATUS WRdsResetBrokenStatus;
    uint WRdsResetBrokenValue;
    WRDS_SETTING_STATUS WRdsMaxIdleTimeStatus;
    uint WRdsMaxIdleTimeValue;
    WRDS_SETTING_STATUS WRdsMaxDisconnectTimeStatus;
    uint WRdsMaxDisconnectTimeValue;
    WRDS_SETTING_STATUS WRdsMaxConnectTimeStatus;
    uint WRdsMaxConnectTimeValue;
    WRDS_SETTING_STATUS WRdsKeepAliveStatus;
    ubyte WRdsKeepAliveStartValue;
    uint WRdsKeepAliveIntervalValue;
}

struct WRDS_CONNECTION_SETTING
{
    WRDS_CONNECTION_SETTINGS_1 WRdsConnectionSettings1;
}

struct WRDS_CONNECTION_SETTINGS
{
    WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel;
    WRDS_CONNECTION_SETTING WRdsConnectionSetting;
}

struct WRDS_SETTING
{
    WRDS_SETTINGS_1 WRdsSettings1;
}

struct WRDS_SETTINGS
{
    WRDS_SETTING_TYPE WRdsSettingType;
    WRDS_SETTING_LEVEL WRdsSettingLevel;
    WRDS_SETTING WRdsSetting;
}

const GUID IID_IWTSProtocolManager = {0xF9EAF6CC, 0xED79, 0x4F01, [0x82, 0x1D, 0x1F, 0x88, 0x1B, 0x9F, 0x66, 0xCC]};
@GUID(0xF9EAF6CC, 0xED79, 0x4F01, [0x82, 0x1D, 0x1F, 0x88, 0x1B, 0x9F, 0x66, 0xCC]);
interface IWTSProtocolManager : IUnknown
{
    HRESULT CreateListener(ushort* wszListenerName, IWTSProtocolListener* pProtocolListener);
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
}

const GUID IID_IWTSProtocolListener = {0x23083765, 0x45F0, 0x4394, [0x8F, 0x69, 0x32, 0xB2, 0xBC, 0x0E, 0xF4, 0xCA]};
@GUID(0x23083765, 0x45F0, 0x4394, [0x8F, 0x69, 0x32, 0xB2, 0xBC, 0x0E, 0xF4, 0xCA]);
interface IWTSProtocolListener : IUnknown
{
    HRESULT StartListen(IWTSProtocolListenerCallback pCallback);
    HRESULT StopListen();
}

const GUID IID_IWTSProtocolListenerCallback = {0x23083765, 0x1A2D, 0x4DE2, [0x97, 0xDE, 0x4A, 0x35, 0xF2, 0x60, 0xF0, 0xB3]};
@GUID(0x23083765, 0x1A2D, 0x4DE2, [0x97, 0xDE, 0x4A, 0x35, 0xF2, 0x60, 0xF0, 0xB3]);
interface IWTSProtocolListenerCallback : IUnknown
{
    HRESULT OnConnected(IWTSProtocolConnection pConnection, IWTSProtocolConnectionCallback* pCallback);
}

const GUID IID_IWTSProtocolConnection = {0x23083765, 0x9095, 0x4648, [0x98, 0xBF, 0xEF, 0x81, 0xC9, 0x14, 0x03, 0x2D]};
@GUID(0x23083765, 0x9095, 0x4648, [0x98, 0xBF, 0xEF, 0x81, 0xC9, 0x14, 0x03, 0x2D]);
interface IWTSProtocolConnection : IUnknown
{
    HRESULT GetLogonErrorRedirector(IWTSProtocolLogonErrorRedirector* ppLogonErrorRedir);
    HRESULT SendPolicyData(WTS_POLICY_DATA* pPolicyData);
    HRESULT AcceptConnection();
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    HRESULT GetLicenseConnection(IWTSProtocolLicenseConnection* ppLicenseConnection);
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId);
    HRESULT GetProtocolHandles(uint* pKeyboardHandle, uint* pMouseHandle, uint* pBeepHandle, uint* pVideoHandle);
    HRESULT ConnectNotify(uint SessionId);
    HRESULT IsUserAllowedToLogon(uint SessionId, uint UserToken, ushort* pDomainName, ushort* pUserName);
    HRESULT SessionArbitrationEnumeration(uint hUserToken, BOOL bSingleSessionPerUserEnabled, char* pSessionIdArray, uint* pdwSessionIdentifierCount);
    HRESULT LogonNotify(uint hClientToken, ushort* wszUserName, ushort* wszDomainName, WTS_SESSION_ID* SessionId);
    HRESULT GetUserData(WTS_POLICY_DATA* pPolicyData, WTS_USER_DATA* pClientData);
    HRESULT DisconnectNotify();
    HRESULT Close();
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    HRESULT SetErrorInfo(uint ulError);
    HRESULT SendBeep(uint Frequency, uint Duration);
    HRESULT CreateVirtualChannel(byte* szEndpointName, BOOL bStatic, uint RequestedPriority, uint* phChannel);
    HRESULT QueryProperty(Guid QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, char* pPropertyEntriesIn, char* pPropertyEntriesOut);
    HRESULT GetShadowConnection(IWTSProtocolShadowConnection* ppShadowConnection);
}

const GUID IID_IWTSProtocolConnectionCallback = {0x23083765, 0x75EB, 0x41FE, [0xB4, 0xFB, 0xE0, 0x86, 0x24, 0x2A, 0xFA, 0x0F]};
@GUID(0x23083765, 0x75EB, 0x41FE, [0xB4, 0xFB, 0xE0, 0x86, 0x24, 0x2A, 0xFA, 0x0F]);
interface IWTSProtocolConnectionCallback : IUnknown
{
    HRESULT OnReady();
    HRESULT BrokenConnection(uint Reason, uint Source);
    HRESULT StopScreenUpdates();
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    HRESULT DisplayIOCtl(WTS_DISPLAY_IOCTL* DisplayIOCtl);
}

const GUID IID_IWTSProtocolShadowConnection = {0xEE3B0C14, 0x37FB, 0x456B, [0xBA, 0xB3, 0x6D, 0x6C, 0xD5, 0x1E, 0x13, 0xBF]};
@GUID(0xEE3B0C14, 0x37FB, 0x456B, [0xBA, 0xB3, 0x6D, 0x6C, 0xD5, 0x1E, 0x13, 0xBF]);
interface IWTSProtocolShadowConnection : IUnknown
{
    HRESULT Start(ushort* pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, IWTSProtocolShadowCallback pShadowCallback);
    HRESULT Stop();
    HRESULT DoTarget(char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

const GUID IID_IWTSProtocolShadowCallback = {0x503A2504, 0xAAE5, 0x4AB1, [0x93, 0xE0, 0x6D, 0x1C, 0x4B, 0xC6, 0xF7, 0x1A]};
@GUID(0x503A2504, 0xAAE5, 0x4AB1, [0x93, 0xE0, 0x6D, 0x1C, 0x4B, 0xC6, 0xF7, 0x1A]);
interface IWTSProtocolShadowCallback : IUnknown
{
    HRESULT StopShadow();
    HRESULT InvokeTargetShadow(ushort* pTargetServerName, uint TargetSessionId, char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

const GUID IID_IWTSProtocolLicenseConnection = {0x23083765, 0x178C, 0x4079, [0x8E, 0x4A, 0xFE, 0xA6, 0x49, 0x6A, 0x4D, 0x70]};
@GUID(0x23083765, 0x178C, 0x4079, [0x8E, 0x4A, 0xFE, 0xA6, 0x49, 0x6A, 0x4D, 0x70]);
interface IWTSProtocolLicenseConnection : IUnknown
{
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, uint* pcbLicenseCapabilities);
    HRESULT SendClientLicense(char* pClientLicense, uint cbClientLicense);
    HRESULT RequestClientLicense(char* Reserve1, uint Reserve2, char* ppClientLicense, uint* pcbClientLicense);
    HRESULT ProtocolComplete(uint ulComplete);
}

const GUID IID_IWTSProtocolLogonErrorRedirector = {0xFD9B61A7, 0x2916, 0x4627, [0x8D, 0xEE, 0x43, 0x28, 0x71, 0x1A, 0xD6, 0xCB]};
@GUID(0xFD9B61A7, 0x2916, 0x4627, [0x8D, 0xEE, 0x43, 0x28, 0x71, 0x1A, 0xD6, 0xCB]);
interface IWTSProtocolLogonErrorRedirector : IUnknown
{
    HRESULT OnBeginPainting();
    HRESULT RedirectStatus(const(wchar)* pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectMessage(const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

const GUID IID_IWRdsRemoteFXGraphicsConnection = {0x0FAD5DCF, 0xC6D3, 0x423C, [0xB0, 0x97, 0x16, 0x3D, 0x6A, 0x67, 0x61, 0x51]};
@GUID(0x0FAD5DCF, 0xC6D3, 0x423C, [0xB0, 0x97, 0x16, 0x3D, 0x6A, 0x67, 0x61, 0x51]);
interface IWRdsRemoteFXGraphicsConnection : IUnknown
{
    HRESULT EnableRemoteFXGraphics(int* pEnableRemoteFXGraphics);
    HRESULT GetVirtualChannelTransport(IUnknown* ppTransport);
}

const GUID IID_IWRdsProtocolSettings = {0x654A5A6A, 0x2550, 0x47EB, [0xB6, 0xF7, 0xEB, 0xD6, 0x37, 0x47, 0x52, 0x65]};
@GUID(0x654A5A6A, 0x2550, 0x47EB, [0xB6, 0xF7, 0xEB, 0xD6, 0x37, 0x47, 0x52, 0x65]);
interface IWRdsProtocolSettings : IUnknown
{
    HRESULT GetSettings(WRDS_SETTING_TYPE WRdsSettingType, WRDS_SETTING_LEVEL WRdsSettingLevel, WRDS_SETTINGS* pWRdsSettings);
    HRESULT MergeSettings(WRDS_SETTINGS* pWRdsSettings, WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel, WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
}

const GUID IID_IWRdsProtocolManager = {0xDC796967, 0x3ABB, 0x40CD, [0xA4, 0x46, 0x10, 0x52, 0x76, 0xB5, 0x89, 0x50]};
@GUID(0xDC796967, 0x3ABB, 0x40CD, [0xA4, 0x46, 0x10, 0x52, 0x76, 0xB5, 0x89, 0x50]);
interface IWRdsProtocolManager : IUnknown
{
    HRESULT Initialize(IWRdsProtocolSettings pIWRdsSettings, WRDS_SETTINGS* pWRdsSettings);
    HRESULT CreateListener(ushort* wszListenerName, IWRdsProtocolListener* pProtocolListener);
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
    HRESULT NotifySettingsChange(WRDS_SETTINGS* pWRdsSettings);
    HRESULT Uninitialize();
}

const GUID IID_IWRdsProtocolListener = {0xFCBC131B, 0xC686, 0x451D, [0xA7, 0x73, 0xE2, 0x79, 0xE2, 0x30, 0xF5, 0x40]};
@GUID(0xFCBC131B, 0xC686, 0x451D, [0xA7, 0x73, 0xE2, 0x79, 0xE2, 0x30, 0xF5, 0x40]);
interface IWRdsProtocolListener : IUnknown
{
    HRESULT GetSettings(WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel, WRDS_LISTENER_SETTINGS* pWRdsListenerSettings);
    HRESULT StartListen(IWRdsProtocolListenerCallback pCallback);
    HRESULT StopListen();
}

const GUID IID_IWRdsProtocolListenerCallback = {0x3AB27E5B, 0x4449, 0x4DC1, [0xB7, 0x4A, 0x91, 0x62, 0x1D, 0x4F, 0xE9, 0x84]};
@GUID(0x3AB27E5B, 0x4449, 0x4DC1, [0xB7, 0x4A, 0x91, 0x62, 0x1D, 0x4F, 0xE9, 0x84]);
interface IWRdsProtocolListenerCallback : IUnknown
{
    HRESULT OnConnected(IWRdsProtocolConnection pConnection, WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings, IWRdsProtocolConnectionCallback* pCallback);
}

const GUID IID_IWRdsProtocolConnection = {0x324ED94F, 0xFDAF, 0x4FF6, [0x81, 0xA8, 0x42, 0xAB, 0xE7, 0x55, 0x83, 0x0B]};
@GUID(0x324ED94F, 0xFDAF, 0x4FF6, [0x81, 0xA8, 0x42, 0xAB, 0xE7, 0x55, 0x83, 0x0B]);
interface IWRdsProtocolConnection : IUnknown
{
    HRESULT GetLogonErrorRedirector(IWRdsProtocolLogonErrorRedirector* ppLogonErrorRedir);
    HRESULT AcceptConnection();
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    HRESULT GetClientMonitorData(uint* pNumMonitors, uint* pPrimaryMonitor);
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    HRESULT GetLicenseConnection(IWRdsProtocolLicenseConnection* ppLicenseConnection);
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId, uint SessionHandle);
    HRESULT GetInputHandles(uint* pKeyboardHandle, uint* pMouseHandle, uint* pBeepHandle);
    HRESULT GetVideoHandle(uint* pVideoHandle);
    HRESULT ConnectNotify(uint SessionId);
    HRESULT IsUserAllowedToLogon(uint SessionId, uint UserToken, ushort* pDomainName, ushort* pUserName);
    HRESULT SessionArbitrationEnumeration(uint hUserToken, BOOL bSingleSessionPerUserEnabled, char* pSessionIdArray, uint* pdwSessionIdentifierCount);
    HRESULT LogonNotify(uint hClientToken, ushort* wszUserName, ushort* wszDomainName, WTS_SESSION_ID* SessionId, WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
    HRESULT PreDisconnect(uint DisconnectReason);
    HRESULT DisconnectNotify();
    HRESULT Close();
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    HRESULT SetErrorInfo(uint ulError);
    HRESULT CreateVirtualChannel(byte* szEndpointName, BOOL bStatic, uint RequestedPriority, uint* phChannel);
    HRESULT QueryProperty(Guid QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, char* pPropertyEntriesIn, char* pPropertyEntriesOut);
    HRESULT GetShadowConnection(IWRdsProtocolShadowConnection* ppShadowConnection);
    HRESULT NotifyCommandProcessCreated(uint SessionId);
}

const GUID IID_IWRdsProtocolConnectionCallback = {0xF1D70332, 0xD070, 0x4EF1, [0xA0, 0x88, 0x78, 0x31, 0x35, 0x36, 0xC2, 0xD6]};
@GUID(0xF1D70332, 0xD070, 0x4EF1, [0xA0, 0x88, 0x78, 0x31, 0x35, 0x36, 0xC2, 0xD6]);
interface IWRdsProtocolConnectionCallback : IUnknown
{
    HRESULT OnReady();
    HRESULT BrokenConnection(uint Reason, uint Source);
    HRESULT StopScreenUpdates();
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    HRESULT GetConnectionId(uint* pConnectionId);
}

const GUID IID_IWRdsProtocolShadowConnection = {0x9AE85CE6, 0xCADE, 0x4548, [0x8F, 0xEB, 0x99, 0x01, 0x65, 0x97, 0xF6, 0x0A]};
@GUID(0x9AE85CE6, 0xCADE, 0x4548, [0x8F, 0xEB, 0x99, 0x01, 0x65, 0x97, 0xF6, 0x0A]);
interface IWRdsProtocolShadowConnection : IUnknown
{
    HRESULT Start(ushort* pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, IWRdsProtocolShadowCallback pShadowCallback);
    HRESULT Stop();
    HRESULT DoTarget(char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

const GUID IID_IWRdsProtocolShadowCallback = {0xE0667CE0, 0x0372, 0x40D6, [0xAD, 0xB2, 0xA0, 0xF3, 0x32, 0x26, 0x74, 0xD6]};
@GUID(0xE0667CE0, 0x0372, 0x40D6, [0xAD, 0xB2, 0xA0, 0xF3, 0x32, 0x26, 0x74, 0xD6]);
interface IWRdsProtocolShadowCallback : IUnknown
{
    HRESULT StopShadow();
    HRESULT InvokeTargetShadow(ushort* pTargetServerName, uint TargetSessionId, char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

const GUID IID_IWRdsProtocolLicenseConnection = {0x1D6A145F, 0xD095, 0x4424, [0x95, 0x7A, 0x40, 0x7F, 0xAE, 0x82, 0x2D, 0x84]};
@GUID(0x1D6A145F, 0xD095, 0x4424, [0x95, 0x7A, 0x40, 0x7F, 0xAE, 0x82, 0x2D, 0x84]);
interface IWRdsProtocolLicenseConnection : IUnknown
{
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, uint* pcbLicenseCapabilities);
    HRESULT SendClientLicense(char* pClientLicense, uint cbClientLicense);
    HRESULT RequestClientLicense(char* Reserve1, uint Reserve2, char* ppClientLicense, uint* pcbClientLicense);
    HRESULT ProtocolComplete(uint ulComplete);
}

const GUID IID_IWRdsProtocolLogonErrorRedirector = {0x519FE83B, 0x142A, 0x4120, [0xA3, 0xD5, 0xA4, 0x05, 0xD3, 0x15, 0x28, 0x1A]};
@GUID(0x519FE83B, 0x142A, 0x4120, [0xA3, 0xD5, 0xA4, 0x05, 0xD3, 0x15, 0x28, 0x1A]);
interface IWRdsProtocolLogonErrorRedirector : IUnknown
{
    HRESULT OnBeginPainting();
    HRESULT RedirectStatus(const(wchar)* pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectMessage(const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

const GUID IID_IWRdsWddmIddProps = {0x1382DF4D, 0xA289, 0x43D1, [0xA1, 0x84, 0x14, 0x47, 0x26, 0xF9, 0xAF, 0x90]};
@GUID(0x1382DF4D, 0xA289, 0x43D1, [0xA1, 0x84, 0x14, 0x47, 0x26, 0xF9, 0xAF, 0x90]);
interface IWRdsWddmIddProps : IUnknown
{
    HRESULT GetHardwareId(char* pDisplayDriverHardwareId, uint Count);
    HRESULT OnDriverLoad(uint SessionId, uint DriverHandle);
    HRESULT OnDriverUnload(uint SessionId);
    HRESULT EnableWddmIdd(BOOL Enabled);
}

const GUID IID_IWRdsProtocolConnectionSettings = {0x83FCF5D3, 0xF6F4, 0xEA94, [0x9C, 0xD2, 0x32, 0xF2, 0x80, 0xE1, 0xE5, 0x10]};
@GUID(0x83FCF5D3, 0xF6F4, 0xEA94, [0x9C, 0xD2, 0x32, 0xF2, 0x80, 0xE1, 0xE5, 0x10]);
interface IWRdsProtocolConnectionSettings : IUnknown
{
    HRESULT SetConnectionSetting(Guid PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesIn);
    HRESULT GetConnectionSetting(Guid PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesOut);
}

enum __MIDL_IRemoteDesktopClientSettings_0001
{
    PasswordEncodingUTF8 = 0,
    PasswordEncodingUTF16LE = 1,
    PasswordEncodingUTF16BE = 2,
}

const GUID IID_IRemoteDesktopClientSettings = {0x48A0F2A7, 0x2713, 0x431F, [0xBB, 0xAC, 0x6F, 0x45, 0x58, 0xE7, 0xD6, 0x4D]};
@GUID(0x48A0F2A7, 0x2713, 0x431F, [0xBB, 0xAC, 0x6F, 0x45, 0x58, 0xE7, 0xD6, 0x4D]);
interface IRemoteDesktopClientSettings : IDispatch
{
    HRESULT ApplySettings(BSTR rdpFileContents);
    HRESULT RetrieveSettings(BSTR* rdpFileContents);
    HRESULT GetRdpProperty(BSTR propertyName, VARIANT* value);
    HRESULT SetRdpProperty(BSTR propertyName, VARIANT value);
}

enum RemoteActionType
{
    RemoteActionCharms = 0,
    RemoteActionAppbar = 1,
    RemoteActionSnap = 2,
    RemoteActionStartScreen = 3,
    RemoteActionAppSwitch = 4,
}

enum SnapshotEncodingType
{
    SnapshotEncodingDataUri = 0,
}

enum SnapshotFormatType
{
    SnapshotFormatPng = 0,
    SnapshotFormatJpeg = 1,
    SnapshotFormatBmp = 2,
}

const GUID IID_IRemoteDesktopClientActions = {0x7D54BC4E, 0x1028, 0x45D4, [0x8B, 0x0A, 0xB9, 0xB6, 0xBF, 0xFB, 0xA1, 0x76]};
@GUID(0x7D54BC4E, 0x1028, 0x45D4, [0x8B, 0x0A, 0xB9, 0xB6, 0xBF, 0xFB, 0xA1, 0x76]);
interface IRemoteDesktopClientActions : IDispatch
{
    HRESULT SuspendScreenUpdates();
    HRESULT ResumeScreenUpdates();
    HRESULT ExecuteRemoteAction(RemoteActionType remoteAction);
    HRESULT GetSnapshot(SnapshotEncodingType snapshotEncoding, SnapshotFormatType snapshotFormat, uint snapshotWidth, uint snapshotHeight, BSTR* snapshotData);
}

const GUID IID_IRemoteDesktopClientTouchPointer = {0x260EC22D, 0x8CBC, 0x44B5, [0x9E, 0x88, 0x2A, 0x37, 0xF6, 0xC9, 0x3A, 0xE9]};
@GUID(0x260EC22D, 0x8CBC, 0x44B5, [0x9E, 0x88, 0x2A, 0x37, 0xF6, 0xC9, 0x3A, 0xE9]);
interface IRemoteDesktopClientTouchPointer : IDispatch
{
    HRESULT put_Enabled(short enabled);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_EventsEnabled(short eventsEnabled);
    HRESULT get_EventsEnabled(short* eventsEnabled);
    HRESULT put_PointerSpeed(uint pointerSpeed);
    HRESULT get_PointerSpeed(uint* pointerSpeed);
}

enum __MIDL_IRemoteDesktopClient_0001
{
    KeyCombinationHome = 0,
    KeyCombinationLeft = 1,
    KeyCombinationUp = 2,
    KeyCombinationRight = 3,
    KeyCombinationDown = 4,
    KeyCombinationScroll = 5,
}

const GUID IID_IRemoteDesktopClient = {0x57D25668, 0x625A, 0x4905, [0xBE, 0x4E, 0x30, 0x4C, 0xAA, 0x13, 0xF8, 0x9C]};
@GUID(0x57D25668, 0x625A, 0x4905, [0xBE, 0x4E, 0x30, 0x4C, 0xAA, 0x13, 0xF8, 0x9C]);
interface IRemoteDesktopClient : IDispatch
{
    HRESULT Connect();
    HRESULT Disconnect();
    HRESULT Reconnect(uint width, uint height);
    HRESULT get_Settings(IRemoteDesktopClientSettings* settings);
    HRESULT get_Actions(IRemoteDesktopClientActions* actions);
    HRESULT get_TouchPointer(IRemoteDesktopClientTouchPointer* touchPointer);
    HRESULT DeleteSavedCredentials(BSTR serverName);
    HRESULT UpdateSessionDisplaySettings(uint width, uint height);
    HRESULT attachEvent(BSTR eventName, IDispatch callback);
    HRESULT detachEvent(BSTR eventName, IDispatch callback);
}

