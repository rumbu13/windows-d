module windows.windowsdesktopsharing;

public import windows.automation;
public import windows.com;

extern(Windows):

const GUID CLSID_RDPViewer = {0x32BE5ED2, 0x5C86, 0x480F, [0xA9, 0x14, 0x0F, 0xF8, 0x88, 0x5A, 0x1B, 0x3F]};
@GUID(0x32BE5ED2, 0x5C86, 0x480F, [0xA9, 0x14, 0x0F, 0xF8, 0x88, 0x5A, 0x1B, 0x3F]);
struct RDPViewer;

const GUID CLSID_RDPSRAPISessionProperties = {0xDD7594FF, 0xEA2A, 0x4C06, [0x8F, 0xDF, 0x13, 0x2D, 0xE4, 0x8B, 0x65, 0x10]};
@GUID(0xDD7594FF, 0xEA2A, 0x4C06, [0x8F, 0xDF, 0x13, 0x2D, 0xE4, 0x8B, 0x65, 0x10]);
struct RDPSRAPISessionProperties;

const GUID CLSID_RDPSRAPIInvitationManager = {0x53D9C9DB, 0x75AB, 0x4271, [0x94, 0x8A, 0x4C, 0x4E, 0xB3, 0x6A, 0x8F, 0x2B]};
@GUID(0x53D9C9DB, 0x75AB, 0x4271, [0x94, 0x8A, 0x4C, 0x4E, 0xB3, 0x6A, 0x8F, 0x2B]);
struct RDPSRAPIInvitationManager;

const GUID CLSID_RDPSRAPIInvitation = {0x49174DC6, 0x0731, 0x4B5E, [0x8E, 0xE1, 0x83, 0xA6, 0x3D, 0x38, 0x68, 0xFA]};
@GUID(0x49174DC6, 0x0731, 0x4B5E, [0x8E, 0xE1, 0x83, 0xA6, 0x3D, 0x38, 0x68, 0xFA]);
struct RDPSRAPIInvitation;

const GUID CLSID_RDPSRAPIAttendeeManager = {0xD7B13A01, 0xF7D4, 0x42A6, [0x85, 0x95, 0x12, 0xFC, 0x8C, 0x24, 0xE8, 0x51]};
@GUID(0xD7B13A01, 0xF7D4, 0x42A6, [0x85, 0x95, 0x12, 0xFC, 0x8C, 0x24, 0xE8, 0x51]);
struct RDPSRAPIAttendeeManager;

const GUID CLSID_RDPSRAPIAttendee = {0x74F93BB5, 0x755F, 0x488E, [0x8A, 0x29, 0x23, 0x90, 0x10, 0x8A, 0xEF, 0x55]};
@GUID(0x74F93BB5, 0x755F, 0x488E, [0x8A, 0x29, 0x23, 0x90, 0x10, 0x8A, 0xEF, 0x55]);
struct RDPSRAPIAttendee;

const GUID CLSID_RDPSRAPIAttendeeDisconnectInfo = {0xB47D7250, 0x5BDB, 0x405D, [0xB4, 0x87, 0xCA, 0xAD, 0x9C, 0x56, 0xF4, 0xF8]};
@GUID(0xB47D7250, 0x5BDB, 0x405D, [0xB4, 0x87, 0xCA, 0xAD, 0x9C, 0x56, 0xF4, 0xF8]);
struct RDPSRAPIAttendeeDisconnectInfo;

const GUID CLSID_RDPSRAPIApplicationFilter = {0xE35ACE89, 0xC7E8, 0x427E, [0xA4, 0xF9, 0xB9, 0xDA, 0x07, 0x28, 0x26, 0xBD]};
@GUID(0xE35ACE89, 0xC7E8, 0x427E, [0xA4, 0xF9, 0xB9, 0xDA, 0x07, 0x28, 0x26, 0xBD]);
struct RDPSRAPIApplicationFilter;

const GUID CLSID_RDPSRAPIApplicationList = {0x9E31C815, 0x7433, 0x4876, [0x97, 0xFB, 0xED, 0x59, 0xFE, 0x2B, 0xAA, 0x22]};
@GUID(0x9E31C815, 0x7433, 0x4876, [0x97, 0xFB, 0xED, 0x59, 0xFE, 0x2B, 0xAA, 0x22]);
struct RDPSRAPIApplicationList;

const GUID CLSID_RDPSRAPIApplication = {0xC116A484, 0x4B25, 0x4B9F, [0x8A, 0x54, 0xB9, 0x34, 0xB0, 0x6E, 0x57, 0xFA]};
@GUID(0xC116A484, 0x4B25, 0x4B9F, [0x8A, 0x54, 0xB9, 0x34, 0xB0, 0x6E, 0x57, 0xFA]);
struct RDPSRAPIApplication;

const GUID CLSID_RDPSRAPIWindowList = {0x9C21E2B8, 0x5DD4, 0x42CC, [0x81, 0xBA, 0x1C, 0x09, 0x98, 0x52, 0xE6, 0xFA]};
@GUID(0x9C21E2B8, 0x5DD4, 0x42CC, [0x81, 0xBA, 0x1C, 0x09, 0x98, 0x52, 0xE6, 0xFA]);
struct RDPSRAPIWindowList;

const GUID CLSID_RDPSRAPIWindow = {0x03CF46DB, 0xCE45, 0x4D36, [0x86, 0xED, 0xED, 0x28, 0xB7, 0x43, 0x98, 0xBF]};
@GUID(0x03CF46DB, 0xCE45, 0x4D36, [0x86, 0xED, 0xED, 0x28, 0xB7, 0x43, 0x98, 0xBF]);
struct RDPSRAPIWindow;

const GUID CLSID_RDPSRAPITcpConnectionInfo = {0xBE49DB3F, 0xEBB6, 0x4278, [0x8C, 0xE0, 0xD5, 0x45, 0x58, 0x33, 0xEA, 0xEE]};
@GUID(0xBE49DB3F, 0xEBB6, 0x4278, [0x8C, 0xE0, 0xD5, 0x45, 0x58, 0x33, 0xEA, 0xEE]);
struct RDPSRAPITcpConnectionInfo;

const GUID CLSID_RDPSession = {0x9B78F0E6, 0x3E05, 0x4A5B, [0xB2, 0xE8, 0xE7, 0x43, 0xA8, 0x95, 0x6B, 0x65]};
@GUID(0x9B78F0E6, 0x3E05, 0x4A5B, [0xB2, 0xE8, 0xE7, 0x43, 0xA8, 0x95, 0x6B, 0x65]);
struct RDPSession;

const GUID CLSID_RDPSRAPIFrameBuffer = {0xA4F66BCC, 0x538E, 0x4101, [0x95, 0x1D, 0x30, 0x84, 0x7A, 0xDB, 0x51, 0x01]};
@GUID(0xA4F66BCC, 0x538E, 0x4101, [0x95, 0x1D, 0x30, 0x84, 0x7A, 0xDB, 0x51, 0x01]);
struct RDPSRAPIFrameBuffer;

const GUID CLSID_RDPTransportStreamBuffer = {0x8D4A1C69, 0xF17F, 0x4549, [0xA6, 0x99, 0x76, 0x1C, 0x6E, 0x6B, 0x5C, 0x0A]};
@GUID(0x8D4A1C69, 0xF17F, 0x4549, [0xA6, 0x99, 0x76, 0x1C, 0x6E, 0x6B, 0x5C, 0x0A]);
struct RDPTransportStreamBuffer;

const GUID CLSID_RDPTransportStreamEvents = {0x31E3AB20, 0x5350, 0x483F, [0x9D, 0xC6, 0x67, 0x48, 0x66, 0x5E, 0xFD, 0xEB]};
@GUID(0x31E3AB20, 0x5350, 0x483F, [0x9D, 0xC6, 0x67, 0x48, 0x66, 0x5E, 0xFD, 0xEB]);
struct RDPTransportStreamEvents;

enum CTRL_LEVEL
{
    CTRL_LEVEL_MIN = 0,
    CTRL_LEVEL_INVALID = 0,
    CTRL_LEVEL_NONE = 1,
    CTRL_LEVEL_VIEW = 2,
    CTRL_LEVEL_INTERACTIVE = 3,
    CTRL_LEVEL_REQCTRL_VIEW = 4,
    CTRL_LEVEL_REQCTRL_INTERACTIVE = 5,
    CTRL_LEVEL_MAX = 5,
}

enum ATTENDEE_DISCONNECT_REASON
{
    ATTENDEE_DISCONNECT_REASON_MIN = 0,
    ATTENDEE_DISCONNECT_REASON_APP = 0,
    ATTENDEE_DISCONNECT_REASON_ERR = 1,
    ATTENDEE_DISCONNECT_REASON_CLI = 2,
    ATTENDEE_DISCONNECT_REASON_MAX = 2,
}

enum CHANNEL_PRIORITY
{
    CHANNEL_PRIORITY_LO = 0,
    CHANNEL_PRIORITY_MED = 1,
    CHANNEL_PRIORITY_HI = 2,
}

enum CHANNEL_FLAGS
{
    CHANNEL_FLAGS_LEGACY = 1,
    CHANNEL_FLAGS_UNCOMPRESSED = 2,
    CHANNEL_FLAGS_DYNAMIC = 4,
}

enum CHANNEL_ACCESS_ENUM
{
    CHANNEL_ACCESS_ENUM_NONE = 0,
    CHANNEL_ACCESS_ENUM_SENDRECEIVE = 1,
}

enum RDPENCOMAPI_ATTENDEE_FLAGS
{
    ATTENDEE_FLAGS_LOCAL = 1,
}

enum RDPSRAPI_WND_FLAGS
{
    WND_FLAG_PRIVILEGED = 1,
}

enum RDPSRAPI_APP_FLAGS
{
    APP_FLAG_PRIVILEGED = 1,
}

enum RDPSRAPI_MOUSE_BUTTON_TYPE
{
    RDPSRAPI_MOUSE_BUTTON_BUTTON1 = 0,
    RDPSRAPI_MOUSE_BUTTON_BUTTON2 = 1,
    RDPSRAPI_MOUSE_BUTTON_BUTTON3 = 2,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON1 = 3,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON2 = 4,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON3 = 5,
}

enum RDPSRAPI_KBD_CODE_TYPE
{
    RDPSRAPI_KBD_CODE_SCANCODE = 0,
    RDPSRAPI_KBD_CODE_UNICODE = 1,
}

enum RDPSRAPI_KBD_SYNC_FLAG
{
    RDPSRAPI_KBD_SYNC_FLAG_SCROLL_LOCK = 1,
    RDPSRAPI_KBD_SYNC_FLAG_NUM_LOCK = 2,
    RDPSRAPI_KBD_SYNC_FLAG_CAPS_LOCK = 4,
    RDPSRAPI_KBD_SYNC_FLAG_KANA_LOCK = 8,
}

const GUID IID_IRDPSRAPIDebug = {0xAA1E42B5, 0x496D, 0x4CA4, [0xA6, 0x90, 0x34, 0x8D, 0xCB, 0x2E, 0xC4, 0xAD]};
@GUID(0xAA1E42B5, 0x496D, 0x4CA4, [0xA6, 0x90, 0x34, 0x8D, 0xCB, 0x2E, 0xC4, 0xAD]);
interface IRDPSRAPIDebug : IUnknown
{
    HRESULT put_CLXCmdLine(BSTR CLXCmdLine);
    HRESULT get_CLXCmdLine(BSTR* pCLXCmdLine);
}

const GUID IID_IRDPSRAPIPerfCounterLogger = {0x071C2533, 0x0FA4, 0x4E8F, [0xAE, 0x83, 0x9C, 0x10, 0xB4, 0x30, 0x5A, 0xB5]};
@GUID(0x071C2533, 0x0FA4, 0x4E8F, [0xAE, 0x83, 0x9C, 0x10, 0xB4, 0x30, 0x5A, 0xB5]);
interface IRDPSRAPIPerfCounterLogger : IUnknown
{
    HRESULT LogValue(long lValue);
}

const GUID IID_IRDPSRAPIPerfCounterLoggingManager = {0x9A512C86, 0xAC6E, 0x4A8E, [0xB1, 0xA4, 0xFC, 0xEF, 0x36, 0x3F, 0x6E, 0x64]};
@GUID(0x9A512C86, 0xAC6E, 0x4A8E, [0xB1, 0xA4, 0xFC, 0xEF, 0x36, 0x3F, 0x6E, 0x64]);
interface IRDPSRAPIPerfCounterLoggingManager : IUnknown
{
    HRESULT CreateLogger(BSTR bstrCounterName, IRDPSRAPIPerfCounterLogger* ppLogger);
}

const GUID IID_IRDPSRAPIAudioStream = {0xE3E30EF9, 0x89C6, 0x4541, [0xBA, 0x3B, 0x19, 0x33, 0x6A, 0xC6, 0xD3, 0x1C]};
@GUID(0xE3E30EF9, 0x89C6, 0x4541, [0xBA, 0x3B, 0x19, 0x33, 0x6A, 0xC6, 0xD3, 0x1C]);
interface IRDPSRAPIAudioStream : IUnknown
{
    HRESULT Initialize(long* pnPeriodInHundredNsIntervals);
    HRESULT Start();
    HRESULT Stop();
    HRESULT GetBuffer(char* ppbData, uint* pcbData, ulong* pTimestamp);
    HRESULT FreeBuffer();
}

const GUID IID_IRDPSRAPIClipboardUseEvents = {0xD559F59A, 0x7A27, 0x4138, [0x87, 0x63, 0x24, 0x7C, 0xE5, 0xF6, 0x59, 0xA8]};
@GUID(0xD559F59A, 0x7A27, 0x4138, [0x87, 0x63, 0x24, 0x7C, 0xE5, 0xF6, 0x59, 0xA8]);
interface IRDPSRAPIClipboardUseEvents : IUnknown
{
    HRESULT OnPasteFromClipboard(uint clipboardFormat, IDispatch pAttendee, short* pRetVal);
}

const GUID IID_IRDPSRAPIWindow = {0xBEAFE0F9, 0xC77B, 0x4933, [0xBA, 0x9F, 0xA2, 0x4C, 0xDD, 0xCC, 0x27, 0xCF]};
@GUID(0xBEAFE0F9, 0xC77B, 0x4933, [0xBA, 0x9F, 0xA2, 0x4C, 0xDD, 0xCC, 0x27, 0xCF]);
interface IRDPSRAPIWindow : IDispatch
{
    HRESULT get_Id(int* pRetVal);
    HRESULT get_Application(IRDPSRAPIApplication* pApplication);
    HRESULT get_Shared(short* pRetVal);
    HRESULT put_Shared(short NewVal);
    HRESULT get_Name(BSTR* pRetVal);
    HRESULT Show();
    HRESULT get_Flags(uint* pdwFlags);
}

const GUID IID_IRDPSRAPIWindowList = {0x8A05CE44, 0x715A, 0x4116, [0xA1, 0x89, 0xA1, 0x18, 0xF3, 0x0A, 0x07, 0xBD]};
@GUID(0x8A05CE44, 0x715A, 0x4116, [0xA1, 0x89, 0xA1, 0x18, 0xF3, 0x0A, 0x07, 0xBD]);
interface IRDPSRAPIWindowList : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(int item, IRDPSRAPIWindow* pWindow);
}

const GUID IID_IRDPSRAPIApplication = {0x41E7A09D, 0xEB7A, 0x436E, [0x93, 0x5D, 0x78, 0x0C, 0xA2, 0x62, 0x83, 0x24]};
@GUID(0x41E7A09D, 0xEB7A, 0x436E, [0x93, 0x5D, 0x78, 0x0C, 0xA2, 0x62, 0x83, 0x24]);
interface IRDPSRAPIApplication : IDispatch
{
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindowList);
    HRESULT get_Id(int* pRetVal);
    HRESULT get_Shared(short* pRetVal);
    HRESULT put_Shared(short NewVal);
    HRESULT get_Name(BSTR* pRetVal);
    HRESULT get_Flags(uint* pdwFlags);
}

const GUID IID_IRDPSRAPIApplicationList = {0xD4B4AEB3, 0x22DC, 0x4837, [0xB3, 0xB6, 0x42, 0xEA, 0x25, 0x17, 0x84, 0x9A]};
@GUID(0xD4B4AEB3, 0x22DC, 0x4837, [0xB3, 0xB6, 0x42, 0xEA, 0x25, 0x17, 0x84, 0x9A]);
interface IRDPSRAPIApplicationList : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(int item, IRDPSRAPIApplication* pApplication);
}

const GUID IID_IRDPSRAPIApplicationFilter = {0xD20F10CA, 0x6637, 0x4F06, [0xB1, 0xD5, 0x27, 0x7E, 0xA7, 0xE5, 0x16, 0x0D]};
@GUID(0xD20F10CA, 0x6637, 0x4F06, [0xB1, 0xD5, 0x27, 0x7E, 0xA7, 0xE5, 0x16, 0x0D]);
interface IRDPSRAPIApplicationFilter : IDispatch
{
    HRESULT get_Applications(IRDPSRAPIApplicationList* pApplications);
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindows);
    HRESULT get_Enabled(short* pRetVal);
    HRESULT put_Enabled(short NewVal);
}

const GUID IID_IRDPSRAPISessionProperties = {0x339B24F2, 0x9BC0, 0x4F16, [0x9A, 0xAC, 0xF1, 0x65, 0x43, 0x3D, 0x13, 0xD4]};
@GUID(0x339B24F2, 0x9BC0, 0x4F16, [0x9A, 0xAC, 0xF1, 0x65, 0x43, 0x3D, 0x13, 0xD4]);
interface IRDPSRAPISessionProperties : IDispatch
{
    HRESULT get_Property(BSTR PropertyName, VARIANT* pVal);
    HRESULT put_Property(BSTR PropertyName, VARIANT newVal);
}

const GUID IID_IRDPSRAPIInvitation = {0x4FAC1D43, 0xFC51, 0x45BB, [0xB1, 0xB4, 0x2B, 0x53, 0xAA, 0x56, 0x2F, 0xA3]};
@GUID(0x4FAC1D43, 0xFC51, 0x45BB, [0xB1, 0xB4, 0x2B, 0x53, 0xAA, 0x56, 0x2F, 0xA3]);
interface IRDPSRAPIInvitation : IDispatch
{
    HRESULT get_ConnectionString(BSTR* pbstrVal);
    HRESULT get_GroupName(BSTR* pbstrVal);
    HRESULT get_Password(BSTR* pbstrVal);
    HRESULT get_AttendeeLimit(int* pRetVal);
    HRESULT put_AttendeeLimit(int NewVal);
    HRESULT get_Revoked(short* pRetVal);
    HRESULT put_Revoked(short NewVal);
}

const GUID IID_IRDPSRAPIInvitationManager = {0x4722B049, 0x92C3, 0x4C2D, [0x8A, 0x65, 0xF7, 0x34, 0x8F, 0x64, 0x4D, 0xCF]};
@GUID(0x4722B049, 0x92C3, 0x4C2D, [0x8A, 0x65, 0xF7, 0x34, 0x8F, 0x64, 0x4D, 0xCF]);
interface IRDPSRAPIInvitationManager : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT item, IRDPSRAPIInvitation* ppInvitation);
    HRESULT get_Count(int* pRetVal);
    HRESULT CreateInvitation(BSTR bstrAuthString, BSTR bstrGroupName, BSTR bstrPassword, int AttendeeLimit, IRDPSRAPIInvitation* ppInvitation);
}

const GUID IID_IRDPSRAPITcpConnectionInfo = {0xF74049A4, 0x3D06, 0x4028, [0x81, 0x93, 0x0A, 0x8C, 0x29, 0xBC, 0x24, 0x52]};
@GUID(0xF74049A4, 0x3D06, 0x4028, [0x81, 0x93, 0x0A, 0x8C, 0x29, 0xBC, 0x24, 0x52]);
interface IRDPSRAPITcpConnectionInfo : IDispatch
{
    HRESULT get_Protocol(int* plProtocol);
    HRESULT get_LocalPort(int* plPort);
    HRESULT get_LocalIP(BSTR* pbsrLocalIP);
    HRESULT get_PeerPort(int* plPort);
    HRESULT get_PeerIP(BSTR* pbstrIP);
}

const GUID IID_IRDPSRAPIAttendee = {0xEC0671B3, 0x1B78, 0x4B80, [0xA4, 0x64, 0x91, 0x32, 0x24, 0x75, 0x43, 0xE3]};
@GUID(0xEC0671B3, 0x1B78, 0x4B80, [0xA4, 0x64, 0x91, 0x32, 0x24, 0x75, 0x43, 0xE3]);
interface IRDPSRAPIAttendee : IDispatch
{
    HRESULT get_Id(int* pId);
    HRESULT get_RemoteName(BSTR* pVal);
    HRESULT get_ControlLevel(CTRL_LEVEL* pVal);
    HRESULT put_ControlLevel(CTRL_LEVEL pNewVal);
    HRESULT get_Invitation(IRDPSRAPIInvitation* ppVal);
    HRESULT TerminateConnection();
    HRESULT get_Flags(int* plFlags);
    HRESULT get_ConnectivityInfo(IUnknown* ppVal);
}

const GUID IID_IRDPSRAPIAttendeeManager = {0xBA3A37E8, 0x33DA, 0x4749, [0x8D, 0xA0, 0x07, 0xFA, 0x34, 0xDA, 0x79, 0x44]};
@GUID(0xBA3A37E8, 0x33DA, 0x4749, [0x8D, 0xA0, 0x07, 0xFA, 0x34, 0xDA, 0x79, 0x44]);
interface IRDPSRAPIAttendeeManager : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(int id, IRDPSRAPIAttendee* ppItem);
}

const GUID IID_IRDPSRAPIAttendeeDisconnectInfo = {0xC187689F, 0x447C, 0x44A1, [0x9C, 0x14, 0xFF, 0xFB, 0xB3, 0xB7, 0xEC, 0x17]};
@GUID(0xC187689F, 0x447C, 0x44A1, [0x9C, 0x14, 0xFF, 0xFB, 0xB3, 0xB7, 0xEC, 0x17]);
interface IRDPSRAPIAttendeeDisconnectInfo : IDispatch
{
    HRESULT get_Attendee(IRDPSRAPIAttendee* retval);
    HRESULT get_Reason(ATTENDEE_DISCONNECT_REASON* pReason);
    HRESULT get_Code(int* pVal);
}

const GUID IID_IRDPSRAPIVirtualChannel = {0x05E12F95, 0x28B3, 0x4C9A, [0x87, 0x80, 0xD0, 0x24, 0x85, 0x74, 0xA1, 0xE0]};
@GUID(0x05E12F95, 0x28B3, 0x4C9A, [0x87, 0x80, 0xD0, 0x24, 0x85, 0x74, 0xA1, 0xE0]);
interface IRDPSRAPIVirtualChannel : IDispatch
{
    HRESULT SendData(BSTR bstrData, int lAttendeeId, uint ChannelSendFlags);
    HRESULT SetAccess(int lAttendeeId, CHANNEL_ACCESS_ENUM AccessType);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Flags(int* plFlags);
    HRESULT get_Priority(CHANNEL_PRIORITY* pPriority);
}

const GUID IID_IRDPSRAPIVirtualChannelManager = {0x0D11C661, 0x5D0D, 0x4EE4, [0x89, 0xDF, 0x21, 0x66, 0xAE, 0x1F, 0xDF, 0xED]};
@GUID(0x0D11C661, 0x5D0D, 0x4EE4, [0x89, 0xDF, 0x21, 0x66, 0xAE, 0x1F, 0xDF, 0xED]);
interface IRDPSRAPIVirtualChannelManager : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT item, IRDPSRAPIVirtualChannel* pChannel);
    HRESULT CreateVirtualChannel(BSTR bstrChannelName, CHANNEL_PRIORITY Priority, uint ChannelFlags, IRDPSRAPIVirtualChannel* ppChannel);
}

const GUID IID_IRDPSRAPIViewer = {0xC6BFCD38, 0x8CE9, 0x404D, [0x8A, 0xE8, 0xF3, 0x1D, 0x00, 0xC6, 0x5C, 0xB5]};
@GUID(0xC6BFCD38, 0x8CE9, 0x404D, [0x8A, 0xE8, 0xF3, 0x1D, 0x00, 0xC6, 0x5C, 0xB5]);
interface IRDPSRAPIViewer : IDispatch
{
    HRESULT Connect(BSTR bstrConnectionString, BSTR bstrName, BSTR bstrPassword);
    HRESULT Disconnect();
    HRESULT get_Attendees(IRDPSRAPIAttendeeManager* ppVal);
    HRESULT get_Invitations(IRDPSRAPIInvitationManager* ppVal);
    HRESULT get_ApplicationFilter(IRDPSRAPIApplicationFilter* ppVal);
    HRESULT get_VirtualChannelManager(IRDPSRAPIVirtualChannelManager* ppVal);
    HRESULT put_SmartSizing(short vbSmartSizing);
    HRESULT get_SmartSizing(short* pvbSmartSizing);
    HRESULT RequestControl(CTRL_LEVEL CtrlLevel);
    HRESULT put_DisconnectedText(BSTR bstrDisconnectedText);
    HRESULT get_DisconnectedText(BSTR* pbstrDisconnectedText);
    HRESULT RequestColorDepthChange(int Bpp);
    HRESULT get_Properties(IRDPSRAPISessionProperties* ppVal);
    HRESULT StartReverseConnectListener(BSTR bstrConnectionString, BSTR bstrUserName, BSTR bstrPassword, BSTR* pbstrReverseConnectString);
}

const GUID IID_IRDPViewerRenderingSurface = {0x56BFCE32, 0x83E9, 0x414D, [0x82, 0xE8, 0xF3, 0x1D, 0x01, 0xC6, 0x2C, 0xB5]};
@GUID(0x56BFCE32, 0x83E9, 0x414D, [0x82, 0xE8, 0xF3, 0x1D, 0x01, 0xC6, 0x2C, 0xB5]);
interface IRDPViewerRenderingSurface : IUnknown
{
    HRESULT SetRenderingSurface(IUnknown pRenderingSurface, int surfaceWidth, int surfaceHeight);
}

const GUID IID_IRDPViewerInputSink = {0xBB590853, 0xA6C5, 0x4A7B, [0x8D, 0xD4, 0x76, 0xB6, 0x9E, 0xEA, 0x12, 0xD5]};
@GUID(0xBB590853, 0xA6C5, 0x4A7B, [0x8D, 0xD4, 0x76, 0xB6, 0x9E, 0xEA, 0x12, 0xD5]);
interface IRDPViewerInputSink : IUnknown
{
    HRESULT SendMouseButtonEvent(RDPSRAPI_MOUSE_BUTTON_TYPE buttonType, short vbButtonDown, uint xPos, uint yPos);
    HRESULT SendMouseMoveEvent(uint xPos, uint yPos);
    HRESULT SendMouseWheelEvent(ushort wheelRotation);
    HRESULT SendKeyboardEvent(RDPSRAPI_KBD_CODE_TYPE codeType, ushort keycode, short vbKeyUp, short vbRepeat, short vbExtended);
    HRESULT SendSyncEvent(uint syncFlags);
    HRESULT BeginTouchFrame();
    HRESULT AddTouchInput(uint contactId, uint event, int x, int y);
    HRESULT EndTouchFrame();
}

const GUID IID_IRDPSRAPIFrameBuffer = {0x3D67E7D2, 0xB27B, 0x448E, [0x81, 0xB3, 0xC6, 0x11, 0x0E, 0xD8, 0xB4, 0xBE]};
@GUID(0x3D67E7D2, 0xB27B, 0x448E, [0x81, 0xB3, 0xC6, 0x11, 0x0E, 0xD8, 0xB4, 0xBE]);
interface IRDPSRAPIFrameBuffer : IDispatch
{
    HRESULT get_Width(int* plWidth);
    HRESULT get_Height(int* plHeight);
    HRESULT get_Bpp(int* plBpp);
    HRESULT GetFrameBufferBits(int x, int y, int Width, int Heigth, SAFEARRAY** ppBits);
}

const GUID IID_IRDPSRAPITransportStreamBuffer = {0x81C80290, 0x5085, 0x44B0, [0xB4, 0x60, 0xF8, 0x65, 0xC3, 0x9C, 0xB4, 0xA9]};
@GUID(0x81C80290, 0x5085, 0x44B0, [0xB4, 0x60, 0xF8, 0x65, 0xC3, 0x9C, 0xB4, 0xA9]);
interface IRDPSRAPITransportStreamBuffer : IUnknown
{
    HRESULT get_Storage(ubyte** ppbStorage);
    HRESULT get_StorageSize(int* plMaxStore);
    HRESULT get_PayloadSize(int* plRetVal);
    HRESULT put_PayloadSize(int lVal);
    HRESULT get_PayloadOffset(int* plRetVal);
    HRESULT put_PayloadOffset(int lRetVal);
    HRESULT get_Flags(int* plFlags);
    HRESULT put_Flags(int lFlags);
    HRESULT get_Context(IUnknown* ppContext);
    HRESULT put_Context(IUnknown pContext);
}

const GUID IID_IRDPSRAPITransportStreamEvents = {0xEA81C254, 0xF5AF, 0x4E40, [0x98, 0x2E, 0x3E, 0x63, 0xBB, 0x59, 0x52, 0x76]};
@GUID(0xEA81C254, 0xF5AF, 0x4E40, [0x98, 0x2E, 0x3E, 0x63, 0xBB, 0x59, 0x52, 0x76]);
interface IRDPSRAPITransportStreamEvents : IUnknown
{
    void OnWriteCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    void OnReadCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    void OnStreamClosed(HRESULT hrReason);
}

const GUID IID_IRDPSRAPITransportStream = {0x36CFA065, 0x43BB, 0x4EF7, [0xAE, 0xD7, 0x9B, 0x88, 0xA5, 0x05, 0x30, 0x36]};
@GUID(0x36CFA065, 0x43BB, 0x4EF7, [0xAE, 0xD7, 0x9B, 0x88, 0xA5, 0x05, 0x30, 0x36]);
interface IRDPSRAPITransportStream : IUnknown
{
    HRESULT AllocBuffer(int maxPayload, IRDPSRAPITransportStreamBuffer* ppBuffer);
    HRESULT FreeBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    HRESULT WriteBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    HRESULT ReadBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    HRESULT Open(IRDPSRAPITransportStreamEvents pCallbacks);
    HRESULT Close();
}

const GUID IID_IRDPSRAPISharingSession = {0xEEB20886, 0xE470, 0x4CF6, [0x84, 0x2B, 0x27, 0x39, 0xC0, 0xEC, 0x5C, 0xFB]};
@GUID(0xEEB20886, 0xE470, 0x4CF6, [0x84, 0x2B, 0x27, 0x39, 0xC0, 0xEC, 0x5C, 0xFB]);
interface IRDPSRAPISharingSession : IDispatch
{
    HRESULT Open();
    HRESULT Close();
    HRESULT put_ColorDepth(int colorDepth);
    HRESULT get_ColorDepth(int* pColorDepth);
    HRESULT get_Properties(IRDPSRAPISessionProperties* ppVal);
    HRESULT get_Attendees(IRDPSRAPIAttendeeManager* ppVal);
    HRESULT get_Invitations(IRDPSRAPIInvitationManager* ppVal);
    HRESULT get_ApplicationFilter(IRDPSRAPIApplicationFilter* ppVal);
    HRESULT get_VirtualChannelManager(IRDPSRAPIVirtualChannelManager* ppVal);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT ConnectToClient(BSTR bstrConnectionString);
    HRESULT SetDesktopSharedRect(int left, int top, int right, int bottom);
    HRESULT GetDesktopSharedRect(int* pleft, int* ptop, int* pright, int* pbottom);
}

const GUID IID_IRDPSRAPISharingSession2 = {0xFEE4EE57, 0xE3E8, 0x4205, [0x8F, 0xB0, 0x8F, 0xD1, 0xD0, 0x67, 0x5C, 0x21]};
@GUID(0xFEE4EE57, 0xE3E8, 0x4205, [0x8F, 0xB0, 0x8F, 0xD1, 0xD0, 0x67, 0x5C, 0x21]);
interface IRDPSRAPISharingSession2 : IRDPSRAPISharingSession
{
    HRESULT ConnectUsingTransportStream(IRDPSRAPITransportStream pStream, BSTR bstrGroup, BSTR bstrAuthenticatedAttendeeName);
    HRESULT get_FrameBuffer(IRDPSRAPIFrameBuffer* ppVal);
    HRESULT SendControlLevelChangeResponse(IRDPSRAPIAttendee pAttendee, CTRL_LEVEL RequestedLevel, int ReasonCode);
}

enum RDPENCOMAPI_CONSTANTS
{
    CONST_MAX_CHANNEL_MESSAGE_SIZE = 1024,
    CONST_MAX_CHANNEL_NAME_LEN = 8,
    CONST_MAX_LEGACY_CHANNEL_MESSAGE_SIZE = 409600,
    CONST_ATTENDEE_ID_EVERYONE = -1,
    CONST_ATTENDEE_ID_HOST = 0,
    CONST_CONN_INTERVAL = 50,
    CONST_ATTENDEE_ID_DEFAULT = -1,
}

struct __ReferenceRemainingTypes__
{
    CTRL_LEVEL __ctrlLevel__;
    ATTENDEE_DISCONNECT_REASON __attendeeDisconnectReason__;
    CHANNEL_PRIORITY __channelPriority__;
    CHANNEL_FLAGS __channelFlags__;
    CHANNEL_ACCESS_ENUM __channelAccessEnum__;
    RDPENCOMAPI_ATTENDEE_FLAGS __rdpencomapiAttendeeFlags__;
    RDPSRAPI_WND_FLAGS __rdpsrapiWndFlags__;
    RDPSRAPI_APP_FLAGS __rdpsrapiAppFlags__;
}

const GUID IID__IRDPSessionEvents = {0x98A97042, 0x6698, 0x40E9, [0x8E, 0xFD, 0xB3, 0x20, 0x09, 0x90, 0x00, 0x4B]};
@GUID(0x98A97042, 0x6698, 0x40E9, [0x8E, 0xFD, 0xB3, 0x20, 0x09, 0x90, 0x00, 0x4B]);
interface _IRDPSessionEvents : IDispatch
{
}

