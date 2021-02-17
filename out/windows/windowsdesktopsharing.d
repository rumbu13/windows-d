// Written in the D programming language.

module windows.windowsdesktopsharing;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


///Defines the level of control that an attendee has on a session.
alias CTRL_LEVEL = int;
enum : int
{
    ///Minimum enumeration value.
    CTRL_LEVEL_MIN                 = 0x00000000,
    ///The control level is not valid.
    CTRL_LEVEL_INVALID             = 0x00000000,
    ///The attendee cannot view or interact with the session. This is the default.
    CTRL_LEVEL_NONE                = 0x00000001,
    ///The attendee can view the session.
    CTRL_LEVEL_VIEW                = 0x00000002,
    ///The attendee can view and interact with the session. The local keyboard and mouse input is redirected to the
    ///session.
    CTRL_LEVEL_INTERACTIVE         = 0x00000003,
    ///The attendee can view the session. <b>Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7, Windows
    ///Server 2008 and Windows Vista: </b>This enumeration value is not supported.
    CTRL_LEVEL_REQCTRL_VIEW        = 0x00000004,
    ///The attendee can view and interact with the session. The local keyboard and mouse input is redirected to the
    ///session. Hosting applications that want to allow users to control the shared session must either define
    ///<b>uiAccess</b> as "true" in their application manifest OR run at High Integrity Level (elevated). For more
    ///information see Setting UIAccess in the Application Manifest File. <b>Windows Server 2012, Windows 8, Windows
    ///Server 2008 R2, Windows 7, Windows Server 2008 and Windows Vista: </b>This enumeration value is not supported.
    CTRL_LEVEL_REQCTRL_INTERACTIVE = 0x00000005,
    ///Maximum enumeration value.
    CTRL_LEVEL_MAX                 = 0x00000005,
}

///Defines values for the reasons why an attendee was disconnected from the session.
alias ATTENDEE_DISCONNECT_REASON = int;
enum : int
{
    ///Minimum enumeration value.
    ATTENDEE_DISCONNECT_REASON_MIN = 0x00000000,
    ///The application called the IRDPSRAPIAttendee::TerminateConnection method.
    ATTENDEE_DISCONNECT_REASON_APP = 0x00000000,
    ///There was an internal error when processing data from an attendee or trying to manage an attendee
    ATTENDEE_DISCONNECT_REASON_ERR = 0x00000001,
    ///The attendee disconnected after a request from the attendee itself.
    ATTENDEE_DISCONNECT_REASON_CLI = 0x00000002,
    ///Maximum enumeration value.
    ATTENDEE_DISCONNECT_REASON_MAX = 0x00000002,
}

///Defines values for the priority used to send packets on the channel.
alias CHANNEL_PRIORITY = int;
enum : int
{
    ///Send the packets at a low priority.
    CHANNEL_PRIORITY_LO  = 0x00000000,
    ///Send the packets at a medium priority.
    CHANNEL_PRIORITY_MED = 0x00000001,
    ///Send the packets at a high priority.
    CHANNEL_PRIORITY_HI  = 0x00000002,
}

///Defines values for how data is sent on the channel.
alias CHANNEL_FLAGS = int;
enum : int
{
    ///Reserved.
    CHANNEL_FLAGS_LEGACY       = 0x00000001,
    ///Data sent on the channel is not compressed. Use this option if the data is already compressed.
    CHANNEL_FLAGS_UNCOMPRESSED = 0x00000002,
    CHANNEL_FLAGS_DYNAMIC      = 0x00000004,
}

///Defines values for the type of access granted to the attendee for the channel.
alias CHANNEL_ACCESS_ENUM = int;
enum : int
{
    ///No access. The attendee cannot send or receive data on the channel.
    CHANNEL_ACCESS_ENUM_NONE        = 0x00000000,
    ///The attendee can send or receive data on the channel.
    CHANNEL_ACCESS_ENUM_SENDRECEIVE = 0x00000001,
}

///Defines values for the type of attendee. Attendee flags can be queried for each attendee by using the attendee list.
alias RDPENCOMAPI_ATTENDEE_FLAGS = int;
enum : int
{
    ATTENDEE_FLAGS_LOCAL = 0x00000001,
}

///Defines values for the type of window. These flags can be retrieved from the IRDPSRAPIWindow interface that
///represents each Win32 window. The list of windows on the sharing user session can be retrieved on both the sharer and
///the viewer through the IRDPSRAPIApplicationFilter interface by calling the get_Windows method.
alias RDPSRAPI_WND_FLAGS = int;
enum : int
{
    ///The window is part of an application that runs at a higher level than the current process. This flag indicates
    ///that the window cannot be shared. Applications can use this flag to prevent the user from sharing it either by
    ///disabling the entry for the window in the user interface or by not showing the entry.
    WND_FLAG_PRIVILEGED = 0x00000001,
}

///Defines values for the type of application. You can retrieve these flags from the IRDPSRAPIApplication interface that
///represents each application. You can retrieve the list of applications that are running on the sharing user session
///for both the sharer and the viewer through the IRDPSRAPIApplicationFilter interface by calling the get_Applications
///method.
alias RDPSRAPI_APP_FLAGS = int;
enum : int
{
    APP_FLAG_PRIVILEGED = 0x00000001,
}

///Defines values for the type of mouse buttons.
alias RDPSRAPI_MOUSE_BUTTON_TYPE = int;
enum : int
{
    RDPSRAPI_MOUSE_BUTTON_BUTTON1  = 0x00000000,
    RDPSRAPI_MOUSE_BUTTON_BUTTON2  = 0x00000001,
    RDPSRAPI_MOUSE_BUTTON_BUTTON3  = 0x00000002,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON1 = 0x00000003,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON2 = 0x00000004,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON3 = 0x00000005,
}

///Defines values for the type of encoding of a keyboard.
alias RDPSRAPI_KBD_CODE_TYPE = int;
enum : int
{
    RDPSRAPI_KBD_CODE_SCANCODE = 0x00000000,
    RDPSRAPI_KBD_CODE_UNICODE  = 0x00000001,
}

///Defines values for the type of keys that control the state of a keyboard, such as the Caps Lock key.
alias RDPSRAPI_KBD_SYNC_FLAG = int;
enum : int
{
    RDPSRAPI_KBD_SYNC_FLAG_SCROLL_LOCK = 0x00000001,
    RDPSRAPI_KBD_SYNC_FLAG_NUM_LOCK    = 0x00000002,
    RDPSRAPI_KBD_SYNC_FLAG_CAPS_LOCK   = 0x00000004,
    RDPSRAPI_KBD_SYNC_FLAG_KANA_LOCK   = 0x00000008,
}

///Defines values for some of the constants used in this API.
alias RDPENCOMAPI_CONSTANTS = int;
enum : int
{
    ///Maximum message size, in bytes.
    CONST_MAX_CHANNEL_MESSAGE_SIZE        = 0x00000400,
    ///Maximum length (including the null terminator) of a channel name, in characters. Note that the legacy channel
    ///names are limited to 32 characters.
    CONST_MAX_CHANNEL_NAME_LEN            = 0x00000008,
    ///Maximum message size for a legacy channel, in bytes. Use this constant if <b>CHANNEL_FLAGS_LEGACY</b> is set.
    CONST_MAX_LEGACY_CHANNEL_MESSAGE_SIZE = 0x00064000,
    ///Indicates all attendees.
    CONST_ATTENDEE_ID_EVERYONE            = 0xffffffff,
    ///Identifies the host. Used to send a virtual channel message to the host.
    CONST_ATTENDEE_ID_HOST                = 0x00000000,
    ///Not used.
    CONST_CONN_INTERVAL                   = 0x00000032,
    CONST_ATTENDEE_ID_DEFAULT             = 0xffffffff,
}

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

///Enables a client application to implement custom performance logging. Applications obtain access to this object using
///the IRDPSRAPIPerfCounterLoggingManager<b>::</b>CreateLogger method.
@GUID("071C2533-0FA4-4E8F-AE83-9C10B4305AB5")
interface IRDPSRAPIPerfCounterLogger : IUnknown
{
    ///Logs a value.
    ///Params:
    ///    lValue = The value to log.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT LogValue(long lValue);
}

///Manages IRDPSRAPIPerfCounterLogger objects.
@GUID("9A512C86-AC6E-4A8E-B1A4-FCEF363F6E64")
interface IRDPSRAPIPerfCounterLoggingManager : IUnknown
{
    ///Creates a new IRDPSRAPIPerfCounterLogger object.
    ///Params:
    ///    bstrCounterName = The name of the counter.
    ///    ppLogger = An IRDPSRAPIPerfCounterLogger interface pointer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT CreateLogger(BSTR bstrCounterName, IRDPSRAPIPerfCounterLogger* ppLogger);
}

///Enables sending an audio stream from the collaboration sharer Microsoft ActiveX control to collaboration viewer
///controls. This interface only supports a pulse code modulation (PCM) audio stream with the following specifications;
///44.1 kHz, 2 channels, 16 bits/sample.
@GUID("E3E30EF9-89C6-4541-BA3B-19336AC6D31C")
interface IRDPSRAPIAudioStream : IUnknown
{
    ///Initializes the audio stream.
    ///Params:
    ///    pnPeriodInHundredNsIntervals = On return, indicates the stream period in 100 nanosecond intervals. The collaboration sharer calculates how
    ///                                   frequently to call the GetBuffer method from this value.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Initialize(long* pnPeriodInHundredNsIntervals);
    ///Starts the audio stream. The audio stream must be initialized by calling the Initialize method before it can be
    ///started.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Start();
    ///Stops the audio stream.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Stop();
    ///Gets audio data from the buffer. This method locks an internal buffer and returns a pointer to a specific
    ///location in that buffer. It does not allocate a copy of the buffer for the caller. To release the buffer after
    ///the last call to this method, call the FreeBuffer method.
    ///Params:
    ///    ppbData = A pointer to the current location in the buffer.
    ///    pcbData = The size in bytes of the available data in the buffer.
    ///    pTimestamp = The time-based location of the location pointer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT GetBuffer(char* ppbData, uint* pcbData, ulong* pTimestamp);
    ///Releases the hold on the buffer after the GetBuffer method is called.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT FreeBuffer();
}

///Implement this interface on the sharer side to track or control use of the clipboard. If you do not enable clipboard
///sharing, this interface has no effect. You need to set a value for the <b>SetClipboardRedirectCallback</b> property
///described in Property. This interface is available starting with Windows 10, version 1511.
@GUID("D559F59A-7A27-4138-8763-247CE5F659A8")
interface IRDPSRAPIClipboardUseEvents : IUnknown
{
    ///This callback is issued when an attempt to copy data from the sharer computer is made.
    ///Params:
    ///    clipboardFormat = A clipboard format identifier. For more information about clipboard formats, see Clipboard Formats. For a
    ///                      list of clipboard format identifiers, see Standard Clipboard Formats.
    ///    pAttendee = A pointer to the IRDPSRAPIAttendee instance for the attendee who attempted the clipboard copy.
    ///    pRetVal = The return value for this attempt. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%">
    ///              <dl> <dt>VARIANT_TRUE</dt> </dl> </td> <td width="60%"> The clipboard copy attempt should be allowed. </td>
    ///              </tr> <tr> <td width="40%"> <dl> <dt>VARIANT_FALSE</dt> </dl> </td> <td width="60%"> The clipboard copy
    ///              attempt should not be allowed. </td> </tr> </table>
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnPasteFromClipboard(uint clipboardFormat, IDispatch pAttendee, short* pRetVal);
}

///Represents a one-to-one mapping to a sharable window. A sharable window is usually a top-level window that does not
///have an owner. Sharing the content of a window can be enabled or disabled by setting the Shared property on the
///window object to <b>TRUE</b> or <b>FALSE</b>. Applications can use this window object to display a list of windows
///that can be shared.
@GUID("BEAFE0F9-C77B-4933-BA9F-A24CDDCC27CF")
interface IRDPSRAPIWindow : IDispatch
{
    ///Returns the ID of a window. The ID is a <b>LONG</b> number that is automatically generated. It is not the window
    ///handle. This property is read-only.
    HRESULT get_Id(int* pRetVal);
    ///Returns a pointer to the application object that the window belongs to. All the window objects are parented to
    ///applications. This method provides easy access to the parent of the window. This property is read-only.
    HRESULT get_Application(IRDPSRAPIApplication* pApplication);
    ///Gets or sets the sharing property for a window. Whether a window is shared or not also depends on the state of
    ///the parent application object and on the enabled state of the sharing filter. For more information about the
    ///enabled state of the sharing filter, see Enabled Property of IRDPSRAPIApplicationFilter. This property is
    ///read/write.
    HRESULT get_Shared(short* pRetVal);
    ///Gets or sets the sharing property for a window. Whether a window is shared or not also depends on the state of
    ///the parent application object and on the enabled state of the sharing filter. For more information about the
    ///enabled state of the sharing filter, see Enabled Property of IRDPSRAPIApplicationFilter. This property is
    ///read/write.
    HRESULT put_Shared(short NewVal);
    ///Returns the name for the window object. This is the actual title for the window. This property is read-only.
    HRESULT get_Name(BSTR* pRetVal);
    ///Brings the current window to the foreground.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Show();
    ///Returns the flags on the current window. Flags are one of the values of the enumeration type RDPSRAPI_WND_FLAGS.
    ///This property is read-only.
    HRESULT get_Flags(uint* pdwFlags);
}

///Manages the window list. Applications obtain access to this object using IRDPSRAPIApplication::get_Windows or
///IRDPSRAPIApplicationFilter::get_Windows.
@GUID("8A05CE44-715A-4116-A189-A118F30A07BD")
interface IRDPSRAPIWindowList : IDispatch
{
    ///An enumerator interface for the window collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///An item in the window collection. This property is read-only.
    HRESULT get_Item(int item, IRDPSRAPIWindow* pWindow);
}

///Groups the sharable windows within a process. Each application object contains a list of window objects. If an
///application object is shared, all its windows are shared.
@GUID("41E7A09D-EB7A-436E-935D-780CA2628324")
interface IRDPSRAPIApplication : IDispatch
{
    ///The list of windows. This property is read-only.
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindowList);
    ///The application identifier. This property is read-only.
    HRESULT get_Id(int* pRetVal);
    ///The sharing state. This property is read/write.
    HRESULT get_Shared(short* pRetVal);
    ///The sharing state. This property is read/write.
    HRESULT put_Shared(short NewVal);
    ///The name of the application. This property is read-only.
    HRESULT get_Name(BSTR* pRetVal);
    ///The sharing flags. This property is read-only.
    HRESULT get_Flags(uint* pdwFlags);
}

///Manages the application list. Applications obtain access to this object using
///IRDPSRAPIApplicationFilter::get_Applications.
@GUID("D4B4AEB3-22DC-4837-B3B6-42EA2517849A")
interface IRDPSRAPIApplicationList : IDispatch
{
    ///An enumerator interface for the application collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///An item in the application collection. This property is read-only.
    HRESULT get_Item(int item, IRDPSRAPIApplication* pApplication);
}

///Manages the shared desktop area at the window and process level. Applications can use the enumerators to display
///lists of objects in the session that can be shared. Applications can obtain access to this object using
///IRDPSRAPISharingSession::ApplicationFilter. The list of sharable objects is exposed as a two-level tree. Each window
///has an application object as a parent. Each window object has its own sharing state that can be overridden by the
///sharing state of its parent. Each application object has its own sharing state that can be overridden by the Enabled
///property of the application filter. Therefore, if an application filter is enabled and the application is shared, its
///windows are shared regardless of their sharing state. If the application filter is enabled but the application is not
///shared, its windows are shared depending on their sharing state. If a shared application creates a new window that is
///sharable, it will be shared because the parent application is shared.
@GUID("D20F10CA-6637-4F06-B1D5-277EA7E5160D")
interface IRDPSRAPIApplicationFilter : IDispatch
{
    ///The list of sharable applications. This property is read-only.
    HRESULT get_Applications(IRDPSRAPIApplicationList* pApplications);
    ///The list of sharable windows. This property is read-only.
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindows);
    ///The enabled state of the application filter. This property is read/write.
    HRESULT get_Enabled(short* pRetVal);
    ///The enabled state of the application filter. This property is read/write.
    HRESULT put_Enabled(short NewVal);
}

///Use this interface to get or set session properties. To get this interface, access one of the following properties:
///<ul> <li> Properties Property of IRDPSRAPISharingSession </li> <li> Properties Property of IRDPSRAPIViewer </li>
///</ul>
@GUID("339B24F2-9BC0-4F16-9AAC-F165433D13D4")
interface IRDPSRAPISessionProperties : IDispatch
{
    ///Sets or gets a named session property. This property is read/write.
    HRESULT get_Property(BSTR PropertyName, VARIANT* pVal);
    ///Sets or gets a named session property. This property is read/write.
    HRESULT put_Property(BSTR PropertyName, VARIANT newVal);
}

///Invitations enable a person or group of persons to connect to a session. When an attendee connects to a session, the
///client sends a ticket and a password. These two pieces of information are used to authenticate an attendee.
///Applications obtain access to this object using IRDPSRAPIInvitationManager::CreateInvitation. An attendee can join a
///session if the invitation list contains and invitation with the following properties: <ul> <li>The ticket string in
///ConnectionString matches the one sent by the client.</li> <li>The password string in Password matches the one sent by
///the client.</li> <li>The number of attendees has not exceeded the maximum number in AttendeeLimit.</li> <li>The
///invitation has not been revoked using Revoked.</li> </ul>
@GUID("4FAC1D43-FC51-45BB-B1B4-2B53AA562FA3")
interface IRDPSRAPIInvitation : IDispatch
{
    ///The ticket string. This property is read-only.
    HRESULT get_ConnectionString(BSTR* pbstrVal);
    ///The group name. This property is read-only.
    HRESULT get_GroupName(BSTR* pbstrVal);
    ///The password string. This property is read-only.
    HRESULT get_Password(BSTR* pbstrVal);
    ///The maximum number of attendees that can connect to the session. When this limit is reached, no additional
    ///attendees can connect to a session. This property is read/write.
    HRESULT get_AttendeeLimit(int* pRetVal);
    ///The maximum number of attendees that can connect to the session. When this limit is reached, no additional
    ///attendees can connect to a session. This property is read/write.
    HRESULT put_AttendeeLimit(int NewVal);
    ///The revoked state of the invitation. This property is read/write.
    HRESULT get_Revoked(short* pRetVal);
    ///The revoked state of the invitation. This property is read/write.
    HRESULT put_Revoked(short NewVal);
}

///Manages invitation objects. Applications obtain access to this object using IRDPSRAPISharingSession::get_Invitations
///This interface provides access to the <b>RDPSRAPIInvitationManager</b> object.
@GUID("4722B049-92C3-4C2D-8A65-F7348F644DCF")
interface IRDPSRAPIInvitationManager : IDispatch
{
    ///An enumerator interface for the invitation collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///An item in the invitation collection. This property is read-only.
    HRESULT get_Item(VARIANT item, IRDPSRAPIInvitation* ppInvitation);
    ///The number of invitations in the collection. This property is read-only.
    HRESULT get_Count(int* pRetVal);
    ///Creates an invitation.
    ///Params:
    ///    bstrAuthString = Type: <b>BSTR</b> String to use for the authorization. The string is limited to 255 characters and must be
    ///                     unique for the session. If <b>NULL</b>, the method generates the string for you.
    ///    bstrGroupName = Type: <b>BSTR</b> The name of the group. The string must be unique for the session. Applications typically
    ///                    use the group name to separate attendees into groups that can be granted different authorization levels.
    ///    bstrPassword = Type: <b>BSTR</b> Password to use for authentication. The password is limited to 255 characters. You must
    ///                   provide the password to the viewer out-of-band from the ticket.
    ///    AttendeeLimit = Type: <b>long</b> The maximum number of attendees.
    ///    ppInvitation = Type: <b>IRDPSRAPIInvitation**</b> An IRDPSRAPIInvitation interface pointer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT CreateInvitation(BSTR bstrAuthString, BSTR bstrGroupName, BSTR bstrPassword, int AttendeeLimit, 
                             IRDPSRAPIInvitation* ppInvitation);
}

///Supports the methods to retrieve the TCP connection information on the viewer and on the sharer side. This interface
///is exposed through the IRDPSRAPIAttendee::get_ConnectivityInfo method.
@GUID("F74049A4-3D06-4028-8193-0A8C29BC2452")
interface IRDPSRAPITcpConnectionInfo : IDispatch
{
    ///Retrieves the protocol that is being used by the sharer or by the viewer for communication. This property is
    ///read-only.
    HRESULT get_Protocol(int* plProtocol);
    ///Retrieves the local port that is being used by the sharer or by the viewer in communication. For example, the
    ///sharer can retrieve its own port that is being used to communicate with the viewer and vice versa. This property
    ///is read-only.
    HRESULT get_LocalPort(int* plPort);
    ///Retrieves the local IP address that is being used by the sharer or by the viewer for communication. For example,
    ///the sharer can retrieve its own IP address that is being used to communicate with the viewer and vice versa. This
    ///property is read-only.
    HRESULT get_LocalIP(BSTR* pbsrLocalIP);
    ///Retrieves the remote port that is being used by the sharer or by the viewer in communication. For example, the
    ///sharer can retrieve the port that the viewer is using in communication and vice versa. This property is
    ///read-only.
    HRESULT get_PeerPort(int* plPort);
    ///Retrieves the remote IP address that is being used by the sharer or by the viewer in communication. For example,
    ///the sharer can retrieve the IP address of the viewer that is being used for communication and vice versa. This
    ///property is read-only.
    HRESULT get_PeerIP(BSTR* pbstrIP);
}

///Attendee objects are created as a result of clients connecting to the session and being authenticated. After an
///attendee object is created, it is automatically added to the attendees list.You cannot create an instance of this
///object. Applications can get access to attendee objects in the following ways: <ul> <li>When the
///IRDPSessionEvents::OnAttendeeConnected event is fired, the parameter is an <b>IDispatch</b> pointer corresponding to
///the attendee object that was created.</li> <li>By accessing the Attendee property of the AttendeeDisconnectInfo
///object. An <b>IDispatch</b> pointer to this object is fired by the IRDPSessionEvents::OnAttendeeDisconnected event.
///This is how applications are informed of what attendee was disconnected.</li> <li>By calling the get_Item method on
///the IRDPSRAPIAttendeeManager interface.</li> <li>By calling <b>get_Next</b> on the enumerator returned by the
///IRDPSRAPIAttendeeManager::get__NewEnum method.</li> </ul>
@GUID("EC0671B3-1B78-4B80-A464-9132247543E3")
interface IRDPSRAPIAttendee : IDispatch
{
    ///The unique identifier for the attendee. This property is read-only.
    HRESULT get_Id(int* pId);
    ///The name of the remote client. This is usually the attendee's friendly name. This property is read-only.
    HRESULT get_RemoteName(BSTR* pVal);
    ///The level of control the attendee has over the session. This property is read/write.
    HRESULT get_ControlLevel(CTRL_LEVEL* pVal);
    ///The level of control the attendee has over the session. This property is read/write.
    HRESULT put_ControlLevel(CTRL_LEVEL pNewVal);
    ///The invitation used to grant the attendee access to the conference. This property is read-only.
    HRESULT get_Invitation(IRDPSRAPIInvitation* ppVal);
    ///Disconnects the client represented by the attendee.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code. The following is a possible value.
    ///    
    HRESULT TerminateConnection();
    ///Retrieves the attendee specific flags that are defined in the RDPENCOMAPI_ATTENDEE_FLAGS enumeration type. This
    ///property is read-only.
    HRESULT get_Flags(int* plFlags);
    ///Retrieves the connectivity information for the attendee. This property is read-only.
    HRESULT get_ConnectivityInfo(IUnknown* ppVal);
}

///Manages attendee objects. Applications obtain access to this object using IRDPSRAPISharingSession::get_Attendees.
@GUID("BA3A37E8-33DA-4749-8DA0-07FA34DA7944")
interface IRDPSRAPIAttendeeManager : IDispatch
{
    ///An enumerator interface for the attendee collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///An item in the attendee collection. This property is read-only.
    HRESULT get_Item(int id, IRDPSRAPIAttendee* ppItem);
}

///Contains information about the reason an attendee disconnected. Applications obtain access to this object through
///_IRDPSessionEvents::OnAttendeeDisconnected.
@GUID("C187689F-447C-44A1-9C14-FFFBB3B7EC17")
interface IRDPSRAPIAttendeeDisconnectInfo : IDispatch
{
    ///The attendee that was disconnected. This property is read-only.
    HRESULT get_Attendee(IRDPSRAPIAttendee* retval);
    ///The reason the attendee was disconnected. This property is read-only.
    HRESULT get_Reason(ATTENDEE_DISCONNECT_REASON* pReason);
    ///The status of the disconnect operation. This property is read-only.
    HRESULT get_Code(int* pVal);
}

///Manages the virtual channel.
@GUID("05E12F95-28B3-4C9A-8780-D0248574A1E0")
interface IRDPSRAPIVirtualChannel : IDispatch
{
    ///Sends data on the channel.
    ///Params:
    ///    bstrData = Type: <b>BSTR</b> The buffer to be sent in a packet on the channel. The maximum size of the data is
    ///               CONST_MAX_MESSAGE_SIZE bytes.
    ///    lAttendeeId = Type: <b>long</b> The attendee that should receive the data. To send the data to all attendees, use
    ///                  CONST_ATTENDEE_ID_EVERYONE.
    ///    ChannelSendFlags = Type: <b>unsigned long</b> The channel flags. This parameter can be 0 or the following value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT SendData(BSTR bstrData, int lAttendeeId, uint ChannelSendFlags);
    ///Enables the channel for an attendee.
    ///Params:
    ///    lAttendeeId = Type: <b>long</b> The identifier of the attendee.
    ///    AccessType = Type: <b>CHANNEL_ACCESS_ENUM</b> The type of access granted. This parameter can be one of the following
    ///                 values. <a id="CHANNEL_ACCESS_ENUM_NONE"></a> <a id="channel_access_enum_none"></a>
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT SetAccess(int lAttendeeId, CHANNEL_ACCESS_ENUM AccessType);
    ///The channel name. This property is read-only.
    HRESULT get_Name(BSTR* pbstrName);
    ///The channel flags. This property is reserved for future use. This property is read-only.
    HRESULT get_Flags(int* plFlags);
    ///The channel priority. This property is read-only.
    HRESULT get_Priority(CHANNEL_PRIORITY* pPriority);
}

///Manages the list of virtual channels.
@GUID("0D11C661-5D0D-4EE4-89DF-2166AE1FDFED")
interface IRDPSRAPIVirtualChannelManager : IDispatch
{
    ///An enumerator interface for the virtual channel collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///An item in the virtual channel collection. This property is read-only.
    HRESULT get_Item(VARIANT item, IRDPSRAPIVirtualChannel* pChannel);
    ///Creates a virtual channel.
    ///Params:
    ///    bstrChannelName = Type: <b>BSTR</b> The name of the channel. The maximum length is 8 characters, including the null-terminating
    ///                      character. Legacy channel names are limited to 32 characters.
    ///    Priority = Type: <b>CHANNEL_PRIORITY</b> The priority of the channel. This parameter can be one of the following values.
    ///               <a id="CHANNEL_PRIORITY_LO"></a> <a id="channel_priority_lo"></a>
    ///    ChannelFlags = Type: <b>unsigned long</b> Flags that determine how data is sent on the channel. This parameter can be 0 or
    ///                   CHANNEL_FLAGS_UNCOMPRESSED.
    ///    ppChannel = Type: <b>IRDPSRAPIVirtualChannel**</b> An IRDPSRAPIVirtualChannel interface pointer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code. The following is a possible value.
    ///    
    HRESULT CreateVirtualChannel(BSTR bstrChannelName, CHANNEL_PRIORITY Priority, uint ChannelFlags, 
                                 IRDPSRAPIVirtualChannel* ppChannel);
}

///<p class="CCE_Message">[The <b>IRDPSRAPIViewer</b> interface is no longer available for use for UWP applications as
///of Windows 10, version 1709. It is still supported for Desktop Apps.] The ActiveX interface that is used on the
///viewer side. The <b>IRDPSRAPIViewer</b> interface is equivalent to the IRDPSRAPISharingSession interface on the
///sharer side. This interface can be used to connect or disconnect viewers and to get or set various properties on the
///viewer ActiveX control.
@GUID("C6BFCD38-8CE9-404D-8AE8-F31D00C65CB5")
interface IRDPSRAPIViewer : IDispatch
{
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Starts the actual connection to the sharer.
    ///Params:
    ///    bstrConnectionString = Type: <b>BSTR</b> The connection string used to connect to the sharer and authenticate the viewer.
    ///    bstrName = Type: <b>BSTR</b> Name for the viewer. The name is sent to the sharer and other viewers. The string is
    ///               limited to 255 characters.
    ///    bstrPassword = Type: <b>BSTR</b> Password used for authentication. The password is sent out-of-band from the sharer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT Connect(BSTR bstrConnectionString, BSTR bstrName, BSTR bstrPassword);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Initiates a disconnect of the viewer from the
    ///sharer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Disconnect();
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Returns an object implementing the
    ///IRDPSRAPIAttendeeManager interface. This property is read-only.
    HRESULT get_Attendees(IRDPSRAPIAttendeeManager* ppVal);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Returns an object implementing the
    ///IRDPSRAPIInvitationManager interface. This property is read-only.
    HRESULT get_Invitations(IRDPSRAPIInvitationManager* ppVal);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Returns an object implementing the
    ///IRDPSRAPIApplicationFilter interface. This property is read-only.
    HRESULT get_ApplicationFilter(IRDPSRAPIApplicationFilter* ppVal);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Returns an object implementing the
    ///IRDPSRAPIVirtualChannelManager interface. This property is read-only.
    HRESULT get_VirtualChannelManager(IRDPSRAPIVirtualChannelManager* ppVal);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Gets or sets the smart sizing property of the
    ///viewer ActiveX control. The <b>SmartSizing</b> property specifies whether the display should be scaled to fit the
    ///client area of the control. Scroll bars do not appear when the <b>SmartSizing</b> property is enabled. Unlike
    ///most other properties, this property can be set when the control is connected. This property is read/write.
    HRESULT put_SmartSizing(short vbSmartSizing);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Gets or sets the smart sizing property of the
    ///viewer ActiveX control. The <b>SmartSizing</b> property specifies whether the display should be scaled to fit the
    ///client area of the control. Scroll bars do not appear when the <b>SmartSizing</b> property is enabled. Unlike
    ///most other properties, this property can be set when the control is connected. This property is read/write.
    HRESULT get_SmartSizing(short* pvbSmartSizing);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Requests the sharer to change the control
    ///level of the viewer. After this method is called, a message is sent to the sharer to notify the sharer that a
    ///viewer is requesting a control level change. After the sharer receives the message, an event is raised on the
    ///sharer side to notify the application that an attendee is requesting a change in control level. The application
    ///or user can then decide whether to allow the requested level of control for an attendee.
    ///Params:
    ///    CtrlLevel = Type: <b>CTRL_LEVEL</b> One of the values of the CTRL_LEVEL enumeration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT RequestControl(CTRL_LEVEL CtrlLevel);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Retrieves or sets the text that appears
    ///centered in the control before a connection is terminated. This property is read/write.
    HRESULT put_DisconnectedText(BSTR bstrDisconnectedText);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Retrieves or sets the text that appears
    ///centered in the control before a connection is terminated. This property is read/write.
    HRESULT get_DisconnectedText(BSTR* pbstrDisconnectedText);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Requests a color depth change on the sharer
    ///Winlogon user session.
    ///Params:
    ///    Bpp = Type: <b>long</b> Specifies the color depth of the session in bits per pixel. Possible values are 16 and 24.
    ///          If you specify a value of 8, the color depth is set to 16 bits per pixel. <b>Windows Server 2008 and Windows
    ///          Vista: </b>Possible values are 8, 16, and 24.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT RequestColorDepthChange(int Bpp);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Returns an object implementing the
    ///IRDPSRAPISessionProperties interface. This property is read-only.
    HRESULT get_Properties(IRDPSRAPISessionProperties* ppVal);
    ///<p class="CCE_Message">[The IRDPSRAPIViewer interface is no longer available for use for UWP applications as of
    ///Windows 10, version 1709. It is still supported for Desktop apps.] Initiates a listener for accepting reverse
    ///connections from the sharer to the viewer, or obtains the connection string that the sharer uses to reverse
    ///connect to the viewer.
    ///Params:
    ///    bstrConnectionString = Type: <b>BSTR</b> The connection string that the sharer will use to start the listener.
    ///    bstrUserName = Type: <b>BSTR</b> The user name to use for authentication.
    ///    bstrPassword = Type: <b>BSTR</b> The password to use for authentication.
    ///    pbstrReverseConnectString = Type: <b>BSTR*</b> A pointer to a <b>BSTR</b> that receives the connection string that the sharer can use to
    ///                                reverse connect to the viewer by using the IRDPSRAPISharingSession::ConnectToClient method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT StartReverseConnectListener(BSTR bstrConnectionString, BSTR bstrUserName, BSTR bstrPassword, 
                                        BSTR* pbstrReverseConnectString);
}

///<p class="CCE_Message">[The <b>IRDPViewerRenderingSurface</b> interface is no longer available for use as of Windows
///10, version 1709.] Manages the rendering surface for the viewer. The viewer control host uses this interface to set
///the rendering surface that the viewer should use. This interface is implemented by the viewer control. An instance of
///this interface is obtained by calling the IRDPSRAPIViewer object's QueryInterface method, passing
///<b>IID_IRDPViewerRenderingSurface</b>.
@GUID("56BFCE32-83E9-414D-82E8-F31D01C62CB5")
interface IRDPViewerRenderingSurface : IUnknown
{
    ///<p class="CCE_Message">[The IRDPViewerRenderingSurface interface is no longer available for use as of Windows 10,
    ///version 1709.] Sets the rendering surface to be used by the viewer.
    ///Params:
    ///    pRenderingSurface = The address of the SurfaceImageSource object to use for the rendering surface.
    ///    surfaceWidth = The width, in pixels, of the rendering surface.
    ///    surfaceHeight = The height, in pixels, of the rendering surface.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT SetRenderingSurface(IUnknown pRenderingSurface, int surfaceWidth, int surfaceHeight);
}

///<p class="CCE_Message">[The <b>IRDPViewerInputSink</b> interface is no longer available for use for UWP applications
///as of Windows 10, version 1709. It is still supported for Desktop apps.] Sends mouse and keyboard events, and
///supports touch input.
@GUID("BB590853-A6C5-4A7B-8DD4-76B69EEA12D5")
interface IRDPViewerInputSink : IUnknown
{
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Sends a mouse button event message.
    ///Params:
    ///    buttonType = The button that is pressed or released.
    ///    vbButtonDown = The button state: <b>TRUE</b> if the button is down and <b>FALSE</b> otherwise.
    ///    xPos = The mouse position in pixels along the horizontal axis.
    ///    yPos = The mouse position in pixels along the vertical axis.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT SendMouseButtonEvent(RDPSRAPI_MOUSE_BUTTON_TYPE buttonType, short vbButtonDown, uint xPos, uint yPos);
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Sends a mouse move event message.
    ///Params:
    ///    xPos = The mouse position in pixels along the horizontal axis.
    ///    yPos = The mouse position in pixels along the vertical axis.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT SendMouseMoveEvent(uint xPos, uint yPos);
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Sends a mouse wheel event message.
    ///Params:
    ///    wheelRotation = The number of increments that the wheel is moved.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT SendMouseWheelEvent(ushort wheelRotation);
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Sends a keyboard event message.
    ///Params:
    ///    codeType = The encoding of the key code.
    ///    keycode = The key code of the pressed or released key.
    ///    vbKeyUp = The state of the key: <b>TRUE</b> if the key is released, <b>FALSE</b> if the key is pressed.
    ///    vbRepeat = The key code is a repeated code: <b>FALSE</b> if this is the initial key code from a key press, <b>TRUE</b>
    ///               if this is repeated code from a single key press.
    ///    vbExtended = The key code is extended: <b>TRUE</b> if the code is extended, <b>FALSE</b> otherwise.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT SendKeyboardEvent(RDPSRAPI_KBD_CODE_TYPE codeType, ushort keycode, short vbKeyUp, short vbRepeat, 
                              short vbExtended);
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Sends an event message to indicate a change
    ///in the state of the keyboard, such as when the Caps Lock key is pressed.
    ///Params:
    ///    syncFlags = For possible values, see the RDPSRAPI_KBD_SYNC_FLAG enumeration.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT SendSyncEvent(uint syncFlags);
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Begins to accept a series of touch inputs.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT BeginTouchFrame();
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Accepts a description of a touch input.
    ///Params:
    ///    contactId = The identifier of the contact that generated the touch input.
    ///    event = The event that results from the input.
    ///    x = The touch position in the x-axis.
    ///    y = The touch position in the y-axis.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT AddTouchInput(uint contactId, uint event, int x, int y);
    ///<p class="CCE_Message">[The IRDPViewerInputSink interface is no longer available for use for UWP applications as
    ///of Windows 10, version 1709. It is still supported for Desktop apps.] Stops to accept a series of touch inputs.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT EndTouchFrame();
}

///Provides data about the frame buffer size and format and allows the contents to be retrieved. Applications can get a
///pointer to this interface from the <b>FrameBuffer</b> property of the IRDPSRAPISharingSession2 interface.
@GUID("3D67E7D2-B27B-448E-81B3-C6110ED8B4BE")
interface IRDPSRAPIFrameBuffer : IDispatch
{
    ///Width, in pixels, of the frame buffer. This property is read-only.
    HRESULT get_Width(int* plWidth);
    ///Height, in pixels, of the frame buffer. This property is read-only.
    HRESULT get_Height(int* plHeight);
    ///The bits per pixel for the frame buffer. This property is read-only.
    HRESULT get_Bpp(int* plBpp);
    ///Gets the bits in a specified area of the frame.
    ///Params:
    ///    x = The x coordinate of the requested area of the frame.
    ///    y = The y coordinate of the requested area of the frame.
    ///    Width = The width of the requested area of the frame.
    ///    Heigth = The height of the requested area of the frame.
    ///    ppBits = The contents of the frame buffer in the specified area.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT GetFrameBufferBits(int x, int y, int Width, int Heigth, SAFEARRAY** ppBits);
}

///Created and used by the IRDPSRAPITransportStream interface for sending and receiving data.
@GUID("81C80290-5085-44B0-B460-F865C39CB4A9")
interface IRDPSRAPITransportStreamBuffer : IUnknown
{
    ///The address of the internal storage buffer for the stream. This property is read-only.
    HRESULT get_Storage(ubyte** ppbStorage);
    ///The size, in bytes, of the internal storage buffer for the stream. This property is read-only.
    HRESULT get_StorageSize(int* plMaxStore);
    ///The size, in bytes, of the content in the internal storage buffer. This property is read/write.
    HRESULT get_PayloadSize(int* plRetVal);
    ///The size, in bytes, of the content in the internal storage buffer. This property is read/write.
    HRESULT put_PayloadSize(int lVal);
    ///Specifies the location in the stream buffer where the content starts. This property is read/write.
    HRESULT get_PayloadOffset(int* plRetVal);
    ///Specifies the location in the stream buffer where the content starts. This property is read/write.
    HRESULT put_PayloadOffset(int lRetVal);
    ///Retrieves or specifies options for the stream buffer. This property is read/write.
    HRESULT get_Flags(int* plFlags);
    ///Retrieves or specifies options for the stream buffer. This property is read/write.
    HRESULT put_Flags(int lFlags);
    ///This property is reserved for use by the Remote Desktop Protocol (RDP) stack. Do not modify it. This property is
    ///read/write.
    HRESULT get_Context(IUnknown* ppContext);
    ///This property is reserved for use by the Remote Desktop Protocol (RDP) stack. Do not modify it. This property is
    ///read/write.
    HRESULT put_Context(IUnknown pContext);
}

///Exposes methods called by the stream interface (IRDPSRAPITransportStream) to notify the Remote Desktop Protocol (RDP)
///stack about the completion of events.
@GUID("EA81C254-F5AF-4E40-982E-3E63BB595276")
interface IRDPSRAPITransportStreamEvents : IUnknown
{
    ///Notifies the Remote Desktop Protocol (RDP) stack that a write operation has completed. The RDP stack resumes
    ///ownership of the stream buffer and uses it for subsequent operations.
    ///Params:
    ///    pBuffer = Type: <b>IRDPSRAPITransportStreamBuffer*</b> An IRDPSRAPITransportStreamBuffer interface pointer that
    ///              represents the stream buffer that was written.
    void OnWriteCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    ///Notifies the Remote Desktop Protocol (RDP) stack that a read operation has completed. The RDP stack resumes
    ///ownership of the stream buffer and uses it for subsequent operations.
    ///Params:
    ///    pBuffer = Type: <b>IRDPSRAPITransportStreamBuffer*</b> An IRDPSRAPITransportStreamBuffer interface pointer that
    ///              represents the stream buffer that was read.
    void OnReadCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    ///Notifies the Remote Desktop Protocol (RDP) stack that the connection was closed.
    ///Params:
    ///    hrReason = Type: <b>HRESULT</b> An <b>HRESULT</b> value that specifies if the stream was closed normally or due to an
    ///               error. Contains <b>S_OK</b> if the stream was closed normally or an error code otherwise.
    void OnStreamClosed(HRESULT hrReason);
}

///Exposes methods that perform operations with streams.
@GUID("36CFA065-43BB-4EF7-AED7-9B88A5053036")
interface IRDPSRAPITransportStream : IUnknown
{
    ///Called by the Remote Desktop Protocol (RDP) stack to allocate a stream buffer.
    ///Params:
    ///    maxPayload = Type: <b>long</b> The maximum size, in bytes, of the payload that will be placed into the buffer.
    ///    ppBuffer = Type: <b>IRDPSRAPITransportStreamBuffer**</b> The address of an IRDPSRAPITransportStreamBuffer interface
    ///               pointer that receives the buffer object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT AllocBuffer(int maxPayload, IRDPSRAPITransportStreamBuffer* ppBuffer);
    ///Called by the Remote Desktop Protocol (RDP) stack to return a stream buffer to the stream.
    ///Params:
    ///    pBuffer = Type: <b>IRDPSRAPITransportStreamBuffer*</b> An IRDPSRAPITransportStreamBuffer interface pointer that
    ///              represents the buffer to free.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT FreeBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    ///Called by the Remote Desktop Protocol (RDP) stack to write the contents of a stream buffer to the network.
    ///Params:
    ///    pBuffer = Type: <b>IRDPSRAPITransportStreamBuffer*</b> An IRDPSRAPITransportStreamBuffer interface pointer that
    ///              represents the buffer to write.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT WriteBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    ///Called by the Remote Desktop Protocol (RDP) stack to read the contents of a stream buffer.
    ///Params:
    ///    pBuffer = Type: <b>IRDPSRAPITransportStreamBuffer*</b> An IRDPSRAPITransportStreamBuffer interface pointer that
    ///              represents the buffer to read.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT ReadBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    ///Called by the Remote Desktop Protocol (RDP) stack to start the stream and indicate that the RDP stack is ready to
    ///receive notifications of events.
    ///Params:
    ///    pCallbacks = Type: <b>IRDPSRAPITransportStreamEvents*</b> An IRDPSRAPITransportStreamEvents interface pointer that will
    ///                 receive the transport stream events.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT Open(IRDPSRAPITransportStreamEvents pCallbacks);
    ///Called by the Remote Desktop Protocol (RDP) stack to close the stream.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Close();
}

///The main object that an application must create to start a collaboration session. It is also the only object that you
///can create an instance of. The rest of the objects are accessed as session object properties. The session object is
///hosted in-process by RdpEncom.dll. Even if the object is hosted in-process, there can be only one instance of this
///object created within a Winlogon session. Creating a second object will fail. This interface uses the single-threaded
///apartment (STA) threading model. The object exposes a source interface that is used for firing session-specific
///events (_IRDPSessionEvents) and a dual interface that is used for managing a session.
@GUID("EEB20886-E470-4CF6-842B-2739C0EC5CFB")
interface IRDPSRAPISharingSession : IDispatch
{
    ///Puts the session in an active state. After this method is called, the listener is started and incoming
    ///connections will be accepted.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code. The
    ///    following are possible values.
    ///    
    HRESULT Open();
    ///Disconnects all attendees from the session and stops listening to incoming connections. When the attendees are
    ///disconnected, no attendee disconnect event occurs on the sharer side because it is the sharer that calls this
    ///method. The sharer is already aware that the attendees will be disconnected. A closed session cannot be reopened
    ///by calling the IRDPSRAPISharingSession::Open method.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Close();
    ///Retrieves or sets the color depth for the shared session. This property is read/write.
    HRESULT put_ColorDepth(int colorDepth);
    ///Retrieves or sets the color depth for the shared session. This property is read/write.
    HRESULT get_ColorDepth(int* pColorDepth);
    ///Retrieves an object implementing the IRDPSRAPISessionProperties interface. This property is read-only.
    HRESULT get_Properties(IRDPSRAPISessionProperties* ppVal);
    ///Returns an object implementing the IRDPSRAPIAttendeeManager interface. This property is read-only.
    HRESULT get_Attendees(IRDPSRAPIAttendeeManager* ppVal);
    ///Returns an object implementing the IRDPSRAPIInvitationManager interface. This property is read-only.
    HRESULT get_Invitations(IRDPSRAPIInvitationManager* ppVal);
    ///Returns an object implementing the IRDPSRAPIApplicationFilter interface. This property is read-only.
    HRESULT get_ApplicationFilter(IRDPSRAPIApplicationFilter* ppVal);
    ///Retrieves an object implementing the IRDPSRAPIVirtualChannelManager interface. This property is read-only.
    HRESULT get_VirtualChannelManager(IRDPSRAPIVirtualChannelManager* ppVal);
    ///Pauses the graphics stream that is sent to all viewers from the sharer until IRDPSRAPISharingSession::Resume is
    ///called.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Pause();
    ///Causes the graphics stream that is sent to all viewers from the sharer to resume until either
    ///IRDPSRAPISharingSession::Pause or IRDPSRAPISharingSession::Close is called.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT Resume();
    ///Used for reverse connect mode, where the sharer connects to the viewer. In this mode, the sharer sends the
    ///invitation file to the viewer out-of-band by using instant messaging (IM) or email. For the sharer to connect to
    ///the viewer, the sharer receives a connection string from the viewer out-of-band through IM or email.
    ///Params:
    ///    bstrConnectionString = Type: <b>BSTR</b> Connection string that the viewer sends to the sharer out-of-band through IM or email.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT ConnectToClient(BSTR bstrConnectionString);
    ///Sets the desktop region that will be shared.
    ///Params:
    ///    left = Type: <b>long</b> X-coordinate of the upper-left corner of the shared rectangle.
    ///    top = Type: <b>long</b> Y-coordinate of the upper-left corner of the shared rectangle.
    ///    right = Type: <b>long</b> X-coordinate of the lower-right corner of the shared rectangle.
    ///    bottom = Type: <b>long</b> Y-coordinate of the lower-right corner of the shared rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT SetDesktopSharedRect(int left, int top, int right, int bottom);
    ///Retrieves the current desktop region being shared.
    ///Params:
    ///    pleft = Type: <b>long*</b> X-coordinate of the upper-left corner of the shared rectangle.
    ///    ptop = Type: <b>long*</b> Y-coordinate of the upper-left corner of the shared rectangle.
    ///    pright = Type: <b>long*</b> X-coordinate of the lower-right corner of the shared rectangle.
    ///    pbottom = Type: <b>long*</b> Y-coordinate of the lower-right corner of the shared rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is
    ///    an error code.
    ///    
    HRESULT GetDesktopSharedRect(int* pleft, int* ptop, int* pright, int* pbottom);
}

///The main object that an application must create to start a collaboration session. The session object is hosted
///in-process by RdpEncom.dll. Even though session object is hosted in-process, there can be only one instance of this
///object created within a Winlogon session. Creating a second object will fail. This interface uses the single-threaded
///apartment (STA) threading model. The object exposes a source interface that is used for firing session-specific
///events (_IRDPSessionEvents) and a dual interface that is used for managing a session. This interface extends the
///IRDPSRAPISharingSession interface and contains the following members.
@GUID("FEE4EE57-E3E8-4205-8FB0-8FD1D0675C21")
interface IRDPSRAPISharingSession2 : IRDPSRAPISharingSession
{
    ///Connects using the specified transport stream.
    ///Params:
    ///    pStream = The transport stream used for the connection.
    ///    bstrGroup = The name of the group. The string must be unique for the session. Applications typically use the group name
    ///                to separate attendees into groups that can be granted different authorization levels.
    ///    bstrAuthenticatedAttendeeName = The name of the authenticated attendee.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT ConnectUsingTransportStream(IRDPSRAPITransportStream pStream, BSTR bstrGroup, 
                                        BSTR bstrAuthenticatedAttendeeName);
    ///Gets a frame buffer for this session. This property is read-only.
    HRESULT get_FrameBuffer(IRDPSRAPIFrameBuffer* ppVal);
    ///Sends an OnControlLevelChangeResponse event.
    ///Params:
    ///    pAttendee = Attendee that requests control.
    ///    RequestedLevel = Level of control requested by the attendee. For possible values, see the CTRL_LEVEL enumeration.
    ///    ReasonCode = Specifies the reason for the change.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the return value is an error code.
    ///    
    HRESULT SendControlLevelChangeResponse(IRDPSRAPIAttendee pAttendee, CTRL_LEVEL RequestedLevel, int ReasonCode);
}

///Implement this interface to receive notifications when events occur.
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
