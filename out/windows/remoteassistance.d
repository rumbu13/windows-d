module windows.remoteassistance;

public import windows.automation;
public import windows.com;

extern(Windows):

const GUID CLSID_RendezvousApplication = {0x0B7E019A, 0xB5DE, 0x47FA, [0x89, 0x66, 0x90, 0x82, 0xF8, 0x2F, 0xB1, 0x92]};
@GUID(0x0B7E019A, 0xB5DE, 0x47FA, [0x89, 0x66, 0x90, 0x82, 0xF8, 0x2F, 0xB1, 0x92]);
struct RendezvousApplication;

enum RENDEZVOUS_SESSION_STATE
{
    RSS_UNKNOWN = 0,
    RSS_READY = 1,
    RSS_INVITATION = 2,
    RSS_ACCEPTED = 3,
    RSS_CONNECTED = 4,
    RSS_CANCELLED = 5,
    RSS_DECLINED = 6,
    RSS_TERMINATED = 7,
}

enum RENDEZVOUS_SESSION_FLAGS
{
    RSF_NONE = 0,
    RSF_INVITER = 1,
    RSF_INVITEE = 2,
    RSF_ORIGINAL_INVITER = 4,
    RSF_REMOTE_LEGACYSESSION = 8,
    RSF_REMOTE_WIN7SESSION = 16,
}

const GUID IID_IRendezvousSession = {0x9BA4B1DD, 0x8B0C, 0x48B7, [0x9E, 0x7C, 0x2F, 0x25, 0x85, 0x7C, 0x8D, 0xF5]};
@GUID(0x9BA4B1DD, 0x8B0C, 0x48B7, [0x9E, 0x7C, 0x2F, 0x25, 0x85, 0x7C, 0x8D, 0xF5]);
interface IRendezvousSession : IUnknown
{
    HRESULT get_State(RENDEZVOUS_SESSION_STATE* pSessionState);
    HRESULT get_RemoteUser(BSTR* bstrUserName);
    HRESULT get_Flags(int* pFlags);
    HRESULT SendContextData(BSTR bstrData);
    HRESULT Terminate(HRESULT hr, BSTR bstrAppData);
}

const GUID IID_DRendezvousSessionEvents = {0x3FA19CF8, 0x64C4, 0x4F53, [0xAE, 0x60, 0x63, 0x5B, 0x38, 0x06, 0xEC, 0xA6]};
@GUID(0x3FA19CF8, 0x64C4, 0x4F53, [0xAE, 0x60, 0x63, 0x5B, 0x38, 0x06, 0xEC, 0xA6]);
interface DRendezvousSessionEvents : IDispatch
{
}

const GUID IID_IRendezvousApplication = {0x4F4D070B, 0xA275, 0x49FB, [0xB1, 0x0D, 0x8E, 0xC2, 0x63, 0x87, 0xB5, 0x0D]};
@GUID(0x4F4D070B, 0xA275, 0x49FB, [0xB1, 0x0D, 0x8E, 0xC2, 0x63, 0x87, 0xB5, 0x0D]);
interface IRendezvousApplication : IUnknown
{
    HRESULT SetRendezvousSession(IUnknown pRendezvousSession);
}

