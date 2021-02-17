// Written in the D programming language.

module windows.remoteassistance;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


///Provides the list of possible state codes of the session invitation.
alias RENDEZVOUS_SESSION_STATE = int;
enum : int
{
    ///Unknown response.
    RSS_UNKNOWN    = 0x00000000,
    ///The session is ready.
    RSS_READY      = 0x00000001,
    ///The session is an invitation.
    RSS_INVITATION = 0x00000002,
    ///The session is accepted.
    RSS_ACCEPTED   = 0x00000003,
    ///The session is not ready.
    RSS_CONNECTED  = 0x00000004,
    ///The local session canceled.
    RSS_CANCELLED  = 0x00000005,
    ///The session is remotely cancelled.
    RSS_DECLINED   = 0x00000006,
    RSS_TERMINATED = 0x00000007,
}

///Provides the list of possible flags for the session invitation.
alias RENDEZVOUS_SESSION_FLAGS = int;
enum : int
{
    ///No such value.
    RSF_NONE                 = 0x00000000,
    ///The party that sets the session object is the inviter.
    RSF_INVITER              = 0x00000001,
    ///The party that sets the session object is the recipient.
    RSF_INVITEE              = 0x00000002,
    RSF_ORIGINAL_INVITER     = 0x00000004,
    RSF_REMOTE_LEGACYSESSION = 0x00000008,
    RSF_REMOTE_WIN7SESSION   = 0x00000010,
}

// Interfaces

@GUID("0B7E019A-B5DE-47FA-8966-9082F82FB192")
struct RendezvousApplication;

///Exposes methods that send data about the session and that can terminate it.
@GUID("9BA4B1DD-8B0C-48B7-9E7C-2F25857C8DF5")
interface IRendezvousSession : IUnknown
{
    ///Retrieves a value that indicates the session state. This property is read-only.
    HRESULT get_State(RENDEZVOUS_SESSION_STATE* pSessionState);
    ///Retrieves a pointer to a <b>BSTR</b> that contains the Windows Messenger contact name. This property is
    ///read-only.
    HRESULT get_RemoteUser(BSTR* bstrUserName);
    ///Retrieves a value that indicates session information. For example, the session flag can indicate whether the user
    ///is the inviter or the invitee. This property is read-only.
    HRESULT get_Flags(int* pFlags);
    ///Sends the context data to the remote RendezvousApplication.
    ///Params:
    ///    bstrData = A <b>BSTR</b> specifying context data for the application.
    HRESULT SendContextData(BSTR bstrData);
    ///Terminates the remote RendezvousApplication.
    ///Params:
    ///    hr = The <b>HRESULT</b> from the application termination.
    ///    bstrAppData = Application data.
    HRESULT Terminate(HRESULT hr, BSTR bstrAppData);
}

///Handles events that are generated or received by a IRendezvousSession object.
@GUID("3FA19CF8-64C4-4F53-AE60-635B3806ECA6")
interface DRendezvousSessionEvents : IDispatch
{
}

///Exposes a method used by an instant messaging (IM) application to create a remote assistance session.
@GUID("4F4D070B-A275-49FB-B10D-8EC26387B50D")
interface IRendezvousApplication : IUnknown
{
    ///Passes IRendezvousSession to the Windows Remote Assistance application. This method is used by the instant
    ///messaging application.
    ///Params:
    ///    pRendezvousSession = IRendezvousSession
    HRESULT SetRendezvousSession(IUnknown pRendezvousSession);
}


// GUIDs

const GUID CLSID_RendezvousApplication = GUIDOF!RendezvousApplication;

const GUID IID_DRendezvousSessionEvents = GUIDOF!DRendezvousSessionEvents;
const GUID IID_IRendezvousApplication   = GUIDOF!IRendezvousApplication;
const GUID IID_IRendezvousSession       = GUIDOF!IRendezvousSession;
