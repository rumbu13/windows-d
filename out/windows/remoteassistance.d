module windows.remoteassistance;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


enum : int
{
    RSS_UNKNOWN    = 0x00000000,
    RSS_READY      = 0x00000001,
    RSS_INVITATION = 0x00000002,
    RSS_ACCEPTED   = 0x00000003,
    RSS_CONNECTED  = 0x00000004,
    RSS_CANCELLED  = 0x00000005,
    RSS_DECLINED   = 0x00000006,
    RSS_TERMINATED = 0x00000007,
}
alias RENDEZVOUS_SESSION_STATE = int;

enum : int
{
    RSF_NONE                 = 0x00000000,
    RSF_INVITER              = 0x00000001,
    RSF_INVITEE              = 0x00000002,
    RSF_ORIGINAL_INVITER     = 0x00000004,
    RSF_REMOTE_LEGACYSESSION = 0x00000008,
    RSF_REMOTE_WIN7SESSION   = 0x00000010,
}
alias RENDEZVOUS_SESSION_FLAGS = int;

// Interfaces

@GUID("0B7E019A-B5DE-47FA-8966-9082F82FB192")
struct RendezvousApplication;

@GUID("9BA4B1DD-8B0C-48B7-9E7C-2F25857C8DF5")
interface IRendezvousSession : IUnknown
{
    HRESULT get_State(RENDEZVOUS_SESSION_STATE* pSessionState);
    HRESULT get_RemoteUser(BSTR* bstrUserName);
    HRESULT get_Flags(int* pFlags);
    HRESULT SendContextData(BSTR bstrData);
    HRESULT Terminate(HRESULT hr, BSTR bstrAppData);
}

@GUID("3FA19CF8-64C4-4F53-AE60-635B3806ECA6")
interface DRendezvousSessionEvents : IDispatch
{
}

@GUID("4F4D070B-A275-49FB-B10D-8EC26387B50D")
interface IRendezvousApplication : IUnknown
{
    HRESULT SetRendezvousSession(IUnknown pRendezvousSession);
}


// GUIDs

const GUID CLSID_RendezvousApplication = GUIDOF!RendezvousApplication;

const GUID IID_DRendezvousSessionEvents = GUIDOF!DRendezvousSessionEvents;
const GUID IID_IRendezvousApplication   = GUIDOF!IRendezvousApplication;
const GUID IID_IRendezvousSession       = GUIDOF!IRendezvousSession;
