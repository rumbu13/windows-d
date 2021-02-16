module windows.windowsdesktopsharing;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


enum : int
{
    CTRL_LEVEL_MIN                 = 0x00000000,
    CTRL_LEVEL_INVALID             = 0x00000000,
    CTRL_LEVEL_NONE                = 0x00000001,
    CTRL_LEVEL_VIEW                = 0x00000002,
    CTRL_LEVEL_INTERACTIVE         = 0x00000003,
    CTRL_LEVEL_REQCTRL_VIEW        = 0x00000004,
    CTRL_LEVEL_REQCTRL_INTERACTIVE = 0x00000005,
    CTRL_LEVEL_MAX                 = 0x00000005,
}
alias CTRL_LEVEL = int;

enum : int
{
    ATTENDEE_DISCONNECT_REASON_MIN = 0x00000000,
    ATTENDEE_DISCONNECT_REASON_APP = 0x00000000,
    ATTENDEE_DISCONNECT_REASON_ERR = 0x00000001,
    ATTENDEE_DISCONNECT_REASON_CLI = 0x00000002,
    ATTENDEE_DISCONNECT_REASON_MAX = 0x00000002,
}
alias ATTENDEE_DISCONNECT_REASON = int;

enum : int
{
    CHANNEL_PRIORITY_LO  = 0x00000000,
    CHANNEL_PRIORITY_MED = 0x00000001,
    CHANNEL_PRIORITY_HI  = 0x00000002,
}
alias CHANNEL_PRIORITY = int;

enum : int
{
    CHANNEL_FLAGS_LEGACY       = 0x00000001,
    CHANNEL_FLAGS_UNCOMPRESSED = 0x00000002,
    CHANNEL_FLAGS_DYNAMIC      = 0x00000004,
}
alias CHANNEL_FLAGS = int;

enum : int
{
    CHANNEL_ACCESS_ENUM_NONE        = 0x00000000,
    CHANNEL_ACCESS_ENUM_SENDRECEIVE = 0x00000001,
}
alias CHANNEL_ACCESS_ENUM = int;

enum : int
{
    ATTENDEE_FLAGS_LOCAL = 0x00000001,
}
alias RDPENCOMAPI_ATTENDEE_FLAGS = int;

enum : int
{
    WND_FLAG_PRIVILEGED = 0x00000001,
}
alias RDPSRAPI_WND_FLAGS = int;

enum : int
{
    APP_FLAG_PRIVILEGED = 0x00000001,
}
alias RDPSRAPI_APP_FLAGS = int;

enum : int
{
    RDPSRAPI_MOUSE_BUTTON_BUTTON1  = 0x00000000,
    RDPSRAPI_MOUSE_BUTTON_BUTTON2  = 0x00000001,
    RDPSRAPI_MOUSE_BUTTON_BUTTON3  = 0x00000002,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON1 = 0x00000003,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON2 = 0x00000004,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON3 = 0x00000005,
}
alias RDPSRAPI_MOUSE_BUTTON_TYPE = int;

enum : int
{
    RDPSRAPI_KBD_CODE_SCANCODE = 0x00000000,
    RDPSRAPI_KBD_CODE_UNICODE  = 0x00000001,
}
alias RDPSRAPI_KBD_CODE_TYPE = int;

enum : int
{
    RDPSRAPI_KBD_SYNC_FLAG_SCROLL_LOCK = 0x00000001,
    RDPSRAPI_KBD_SYNC_FLAG_NUM_LOCK    = 0x00000002,
    RDPSRAPI_KBD_SYNC_FLAG_CAPS_LOCK   = 0x00000004,
    RDPSRAPI_KBD_SYNC_FLAG_KANA_LOCK   = 0x00000008,
}
alias RDPSRAPI_KBD_SYNC_FLAG = int;

enum : int
{
    CONST_MAX_CHANNEL_MESSAGE_SIZE        = 0x00000400,
    CONST_MAX_CHANNEL_NAME_LEN            = 0x00000008,
    CONST_MAX_LEGACY_CHANNEL_MESSAGE_SIZE = 0x00064000,
    CONST_ATTENDEE_ID_EVERYONE            = 0xffffffff,
    CONST_ATTENDEE_ID_HOST                = 0x00000000,
    CONST_CONN_INTERVAL                   = 0x00000032,
    CONST_ATTENDEE_ID_DEFAULT             = 0xffffffff,
}
alias RDPENCOMAPI_CONSTANTS = int;

// Structs


struct __ReferenceRemainingTypes__
{
    CTRL_LEVEL          __ctrlLevel__;
    ATTENDEE_DISCONNECT_REASON __attendeeDisconnectReason__;
    CHANNEL_PRIORITY    __channelPriority__;
    CHANNEL_FLAGS       __channelFlags__;
    CHANNEL_ACCESS_ENUM __channelAccessEnum__;
    RDPENCOMAPI_ATTENDEE_FLAGS __rdpencomapiAttendeeFlags__;
    RDPSRAPI_WND_FLAGS  __rdpsrapiWndFlags__;
    RDPSRAPI_APP_FLAGS  __rdpsrapiAppFlags__;
}

// Interfaces

@GUID("32BE5ED2-5C86-480F-A914-0FF8885A1B3F")
struct RDPViewer;

@GUID("DD7594FF-EA2A-4C06-8FDF-132DE48B6510")
struct RDPSRAPISessionProperties;

@GUID("53D9C9DB-75AB-4271-948A-4C4EB36A8F2B")
struct RDPSRAPIInvitationManager;

@GUID("49174DC6-0731-4B5E-8EE1-83A63D3868FA")
struct RDPSRAPIInvitation;

@GUID("D7B13A01-F7D4-42A6-8595-12FC8C24E851")
struct RDPSRAPIAttendeeManager;

@GUID("74F93BB5-755F-488E-8A29-2390108AEF55")
struct RDPSRAPIAttendee;

@GUID("B47D7250-5BDB-405D-B487-CAAD9C56F4F8")
struct RDPSRAPIAttendeeDisconnectInfo;

@GUID("E35ACE89-C7E8-427E-A4F9-B9DA072826BD")
struct RDPSRAPIApplicationFilter;

@GUID("9E31C815-7433-4876-97FB-ED59FE2BAA22")
struct RDPSRAPIApplicationList;

@GUID("C116A484-4B25-4B9F-8A54-B934B06E57FA")
struct RDPSRAPIApplication;

@GUID("9C21E2B8-5DD4-42CC-81BA-1C099852E6FA")
struct RDPSRAPIWindowList;

@GUID("03CF46DB-CE45-4D36-86ED-ED28B74398BF")
struct RDPSRAPIWindow;

@GUID("BE49DB3F-EBB6-4278-8CE0-D5455833EAEE")
struct RDPSRAPITcpConnectionInfo;

@GUID("9B78F0E6-3E05-4A5B-B2E8-E743A8956B65")
struct RDPSession;

@GUID("A4F66BCC-538E-4101-951D-30847ADB5101")
struct RDPSRAPIFrameBuffer;

@GUID("8D4A1C69-F17F-4549-A699-761C6E6B5C0A")
struct RDPTransportStreamBuffer;

@GUID("31E3AB20-5350-483F-9DC6-6748665EFDEB")
struct RDPTransportStreamEvents;

@GUID("AA1E42B5-496D-4CA4-A690-348DCB2EC4AD")
interface IRDPSRAPIDebug : IUnknown
{
    HRESULT put_CLXCmdLine(BSTR CLXCmdLine);
    HRESULT get_CLXCmdLine(BSTR* pCLXCmdLine);
}

@GUID("071C2533-0FA4-4E8F-AE83-9C10B4305AB5")
interface IRDPSRAPIPerfCounterLogger : IUnknown
{
    HRESULT LogValue(long lValue);
}

@GUID("9A512C86-AC6E-4A8E-B1A4-FCEF363F6E64")
interface IRDPSRAPIPerfCounterLoggingManager : IUnknown
{
    HRESULT CreateLogger(BSTR bstrCounterName, IRDPSRAPIPerfCounterLogger* ppLogger);
}

@GUID("E3E30EF9-89C6-4541-BA3B-19336AC6D31C")
interface IRDPSRAPIAudioStream : IUnknown
{
    HRESULT Initialize(long* pnPeriodInHundredNsIntervals);
    HRESULT Start();
    HRESULT Stop();
    HRESULT GetBuffer(char* ppbData, uint* pcbData, ulong* pTimestamp);
    HRESULT FreeBuffer();
}

@GUID("D559F59A-7A27-4138-8763-247CE5F659A8")
interface IRDPSRAPIClipboardUseEvents : IUnknown
{
    HRESULT OnPasteFromClipboard(uint clipboardFormat, IDispatch pAttendee, short* pRetVal);
}

@GUID("BEAFE0F9-C77B-4933-BA9F-A24CDDCC27CF")
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

@GUID("8A05CE44-715A-4116-A189-A118F30A07BD")
interface IRDPSRAPIWindowList : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(int item, IRDPSRAPIWindow* pWindow);
}

@GUID("41E7A09D-EB7A-436E-935D-780CA2628324")
interface IRDPSRAPIApplication : IDispatch
{
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindowList);
    HRESULT get_Id(int* pRetVal);
    HRESULT get_Shared(short* pRetVal);
    HRESULT put_Shared(short NewVal);
    HRESULT get_Name(BSTR* pRetVal);
    HRESULT get_Flags(uint* pdwFlags);
}

@GUID("D4B4AEB3-22DC-4837-B3B6-42EA2517849A")
interface IRDPSRAPIApplicationList : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(int item, IRDPSRAPIApplication* pApplication);
}

@GUID("D20F10CA-6637-4F06-B1D5-277EA7E5160D")
interface IRDPSRAPIApplicationFilter : IDispatch
{
    HRESULT get_Applications(IRDPSRAPIApplicationList* pApplications);
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindows);
    HRESULT get_Enabled(short* pRetVal);
    HRESULT put_Enabled(short NewVal);
}

@GUID("339B24F2-9BC0-4F16-9AAC-F165433D13D4")
interface IRDPSRAPISessionProperties : IDispatch
{
    HRESULT get_Property(BSTR PropertyName, VARIANT* pVal);
    HRESULT put_Property(BSTR PropertyName, VARIANT newVal);
}

@GUID("4FAC1D43-FC51-45BB-B1B4-2B53AA562FA3")
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

@GUID("4722B049-92C3-4C2D-8A65-F7348F644DCF")
interface IRDPSRAPIInvitationManager : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT item, IRDPSRAPIInvitation* ppInvitation);
    HRESULT get_Count(int* pRetVal);
    HRESULT CreateInvitation(BSTR bstrAuthString, BSTR bstrGroupName, BSTR bstrPassword, int AttendeeLimit, 
                             IRDPSRAPIInvitation* ppInvitation);
}

@GUID("F74049A4-3D06-4028-8193-0A8C29BC2452")
interface IRDPSRAPITcpConnectionInfo : IDispatch
{
    HRESULT get_Protocol(int* plProtocol);
    HRESULT get_LocalPort(int* plPort);
    HRESULT get_LocalIP(BSTR* pbsrLocalIP);
    HRESULT get_PeerPort(int* plPort);
    HRESULT get_PeerIP(BSTR* pbstrIP);
}

@GUID("EC0671B3-1B78-4B80-A464-9132247543E3")
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

@GUID("BA3A37E8-33DA-4749-8DA0-07FA34DA7944")
interface IRDPSRAPIAttendeeManager : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(int id, IRDPSRAPIAttendee* ppItem);
}

@GUID("C187689F-447C-44A1-9C14-FFFBB3B7EC17")
interface IRDPSRAPIAttendeeDisconnectInfo : IDispatch
{
    HRESULT get_Attendee(IRDPSRAPIAttendee* retval);
    HRESULT get_Reason(ATTENDEE_DISCONNECT_REASON* pReason);
    HRESULT get_Code(int* pVal);
}

@GUID("05E12F95-28B3-4C9A-8780-D0248574A1E0")
interface IRDPSRAPIVirtualChannel : IDispatch
{
    HRESULT SendData(BSTR bstrData, int lAttendeeId, uint ChannelSendFlags);
    HRESULT SetAccess(int lAttendeeId, CHANNEL_ACCESS_ENUM AccessType);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Flags(int* plFlags);
    HRESULT get_Priority(CHANNEL_PRIORITY* pPriority);
}

@GUID("0D11C661-5D0D-4EE4-89DF-2166AE1FDFED")
interface IRDPSRAPIVirtualChannelManager : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT item, IRDPSRAPIVirtualChannel* pChannel);
    HRESULT CreateVirtualChannel(BSTR bstrChannelName, CHANNEL_PRIORITY Priority, uint ChannelFlags, 
                                 IRDPSRAPIVirtualChannel* ppChannel);
}

@GUID("C6BFCD38-8CE9-404D-8AE8-F31D00C65CB5")
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
    HRESULT StartReverseConnectListener(BSTR bstrConnectionString, BSTR bstrUserName, BSTR bstrPassword, 
                                        BSTR* pbstrReverseConnectString);
}

@GUID("56BFCE32-83E9-414D-82E8-F31D01C62CB5")
interface IRDPViewerRenderingSurface : IUnknown
{
    HRESULT SetRenderingSurface(IUnknown pRenderingSurface, int surfaceWidth, int surfaceHeight);
}

@GUID("BB590853-A6C5-4A7B-8DD4-76B69EEA12D5")
interface IRDPViewerInputSink : IUnknown
{
    HRESULT SendMouseButtonEvent(RDPSRAPI_MOUSE_BUTTON_TYPE buttonType, short vbButtonDown, uint xPos, uint yPos);
    HRESULT SendMouseMoveEvent(uint xPos, uint yPos);
    HRESULT SendMouseWheelEvent(ushort wheelRotation);
    HRESULT SendKeyboardEvent(RDPSRAPI_KBD_CODE_TYPE codeType, ushort keycode, short vbKeyUp, short vbRepeat, 
                              short vbExtended);
    HRESULT SendSyncEvent(uint syncFlags);
    HRESULT BeginTouchFrame();
    HRESULT AddTouchInput(uint contactId, uint event, int x, int y);
    HRESULT EndTouchFrame();
}

@GUID("3D67E7D2-B27B-448E-81B3-C6110ED8B4BE")
interface IRDPSRAPIFrameBuffer : IDispatch
{
    HRESULT get_Width(int* plWidth);
    HRESULT get_Height(int* plHeight);
    HRESULT get_Bpp(int* plBpp);
    HRESULT GetFrameBufferBits(int x, int y, int Width, int Heigth, SAFEARRAY** ppBits);
}

@GUID("81C80290-5085-44B0-B460-F865C39CB4A9")
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

@GUID("EA81C254-F5AF-4E40-982E-3E63BB595276")
interface IRDPSRAPITransportStreamEvents : IUnknown
{
    void OnWriteCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    void OnReadCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    void OnStreamClosed(HRESULT hrReason);
}

@GUID("36CFA065-43BB-4EF7-AED7-9B88A5053036")
interface IRDPSRAPITransportStream : IUnknown
{
    HRESULT AllocBuffer(int maxPayload, IRDPSRAPITransportStreamBuffer* ppBuffer);
    HRESULT FreeBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    HRESULT WriteBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    HRESULT ReadBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    HRESULT Open(IRDPSRAPITransportStreamEvents pCallbacks);
    HRESULT Close();
}

@GUID("EEB20886-E470-4CF6-842B-2739C0EC5CFB")
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

@GUID("FEE4EE57-E3E8-4205-8FB0-8FD1D0675C21")
interface IRDPSRAPISharingSession2 : IRDPSRAPISharingSession
{
    HRESULT ConnectUsingTransportStream(IRDPSRAPITransportStream pStream, BSTR bstrGroup, 
                                        BSTR bstrAuthenticatedAttendeeName);
    HRESULT get_FrameBuffer(IRDPSRAPIFrameBuffer* ppVal);
    HRESULT SendControlLevelChangeResponse(IRDPSRAPIAttendee pAttendee, CTRL_LEVEL RequestedLevel, int ReasonCode);
}

@GUID("98A97042-6698-40E9-8EFD-B3200990004B")
interface _IRDPSessionEvents : IDispatch
{
}


// GUIDs

const GUID CLSID_RDPSRAPIApplication            = GUIDOF!RDPSRAPIApplication;
const GUID CLSID_RDPSRAPIApplicationFilter      = GUIDOF!RDPSRAPIApplicationFilter;
const GUID CLSID_RDPSRAPIApplicationList        = GUIDOF!RDPSRAPIApplicationList;
const GUID CLSID_RDPSRAPIAttendee               = GUIDOF!RDPSRAPIAttendee;
const GUID CLSID_RDPSRAPIAttendeeDisconnectInfo = GUIDOF!RDPSRAPIAttendeeDisconnectInfo;
const GUID CLSID_RDPSRAPIAttendeeManager        = GUIDOF!RDPSRAPIAttendeeManager;
const GUID CLSID_RDPSRAPIFrameBuffer            = GUIDOF!RDPSRAPIFrameBuffer;
const GUID CLSID_RDPSRAPIInvitation             = GUIDOF!RDPSRAPIInvitation;
const GUID CLSID_RDPSRAPIInvitationManager      = GUIDOF!RDPSRAPIInvitationManager;
const GUID CLSID_RDPSRAPISessionProperties      = GUIDOF!RDPSRAPISessionProperties;
const GUID CLSID_RDPSRAPITcpConnectionInfo      = GUIDOF!RDPSRAPITcpConnectionInfo;
const GUID CLSID_RDPSRAPIWindow                 = GUIDOF!RDPSRAPIWindow;
const GUID CLSID_RDPSRAPIWindowList             = GUIDOF!RDPSRAPIWindowList;
const GUID CLSID_RDPSession                     = GUIDOF!RDPSession;
const GUID CLSID_RDPTransportStreamBuffer       = GUIDOF!RDPTransportStreamBuffer;
const GUID CLSID_RDPTransportStreamEvents       = GUIDOF!RDPTransportStreamEvents;
const GUID CLSID_RDPViewer                      = GUIDOF!RDPViewer;

const GUID IID_IRDPSRAPIApplication               = GUIDOF!IRDPSRAPIApplication;
const GUID IID_IRDPSRAPIApplicationFilter         = GUIDOF!IRDPSRAPIApplicationFilter;
const GUID IID_IRDPSRAPIApplicationList           = GUIDOF!IRDPSRAPIApplicationList;
const GUID IID_IRDPSRAPIAttendee                  = GUIDOF!IRDPSRAPIAttendee;
const GUID IID_IRDPSRAPIAttendeeDisconnectInfo    = GUIDOF!IRDPSRAPIAttendeeDisconnectInfo;
const GUID IID_IRDPSRAPIAttendeeManager           = GUIDOF!IRDPSRAPIAttendeeManager;
const GUID IID_IRDPSRAPIAudioStream               = GUIDOF!IRDPSRAPIAudioStream;
const GUID IID_IRDPSRAPIClipboardUseEvents        = GUIDOF!IRDPSRAPIClipboardUseEvents;
const GUID IID_IRDPSRAPIDebug                     = GUIDOF!IRDPSRAPIDebug;
const GUID IID_IRDPSRAPIFrameBuffer               = GUIDOF!IRDPSRAPIFrameBuffer;
const GUID IID_IRDPSRAPIInvitation                = GUIDOF!IRDPSRAPIInvitation;
const GUID IID_IRDPSRAPIInvitationManager         = GUIDOF!IRDPSRAPIInvitationManager;
const GUID IID_IRDPSRAPIPerfCounterLogger         = GUIDOF!IRDPSRAPIPerfCounterLogger;
const GUID IID_IRDPSRAPIPerfCounterLoggingManager = GUIDOF!IRDPSRAPIPerfCounterLoggingManager;
const GUID IID_IRDPSRAPISessionProperties         = GUIDOF!IRDPSRAPISessionProperties;
const GUID IID_IRDPSRAPISharingSession            = GUIDOF!IRDPSRAPISharingSession;
const GUID IID_IRDPSRAPISharingSession2           = GUIDOF!IRDPSRAPISharingSession2;
const GUID IID_IRDPSRAPITcpConnectionInfo         = GUIDOF!IRDPSRAPITcpConnectionInfo;
const GUID IID_IRDPSRAPITransportStream           = GUIDOF!IRDPSRAPITransportStream;
const GUID IID_IRDPSRAPITransportStreamBuffer     = GUIDOF!IRDPSRAPITransportStreamBuffer;
const GUID IID_IRDPSRAPITransportStreamEvents     = GUIDOF!IRDPSRAPITransportStreamEvents;
const GUID IID_IRDPSRAPIViewer                    = GUIDOF!IRDPSRAPIViewer;
const GUID IID_IRDPSRAPIVirtualChannel            = GUIDOF!IRDPSRAPIVirtualChannel;
const GUID IID_IRDPSRAPIVirtualChannelManager     = GUIDOF!IRDPSRAPIVirtualChannelManager;
const GUID IID_IRDPSRAPIWindow                    = GUIDOF!IRDPSRAPIWindow;
const GUID IID_IRDPSRAPIWindowList                = GUIDOF!IRDPSRAPIWindowList;
const GUID IID_IRDPViewerInputSink                = GUIDOF!IRDPViewerInputSink;
const GUID IID_IRDPViewerRenderingSurface         = GUIDOF!IRDPViewerRenderingSurface;
const GUID IID__IRDPSessionEvents                 = GUIDOF!_IRDPSessionEvents;
