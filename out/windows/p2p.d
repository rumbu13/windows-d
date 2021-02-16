module windows.p2p;

public import windows.core;
public import windows.com : HRESULT;
public import windows.networkdrivers : SOCKADDR_IN6_LH, SOCKADDR_STORAGE_LH, SOCKET_ADDRESS_LIST;
public import windows.security : CERT_CONTEXT, CERT_PUBLIC_KEY_INFO;
public import windows.systemservices : BOOL, HANDLE, OVERLAPPED;
public import windows.winsock : BLOB, SOCKADDR, SOCKET_ADDRESS;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    PNRP_SCOPE_ANY        = 0x00000000,
    PNRP_GLOBAL_SCOPE     = 0x00000001,
    PNRP_SITE_LOCAL_SCOPE = 0x00000002,
    PNRP_LINK_LOCAL_SCOPE = 0x00000003,
}
alias PNRP_SCOPE = int;

enum : int
{
    PNRP_CLOUD_STATE_VIRTUAL       = 0x00000000,
    PNRP_CLOUD_STATE_SYNCHRONISING = 0x00000001,
    PNRP_CLOUD_STATE_ACTIVE        = 0x00000002,
    PNRP_CLOUD_STATE_DEAD          = 0x00000003,
    PNRP_CLOUD_STATE_DISABLED      = 0x00000004,
    PNRP_CLOUD_STATE_NO_NET        = 0x00000005,
    PNRP_CLOUD_STATE_ALONE         = 0x00000006,
}
alias PNRP_CLOUD_STATE = int;

enum : int
{
    PNRP_CLOUD_NO_FLAGS         = 0x00000000,
    PNRP_CLOUD_NAME_LOCAL       = 0x00000001,
    PNRP_CLOUD_RESOLVE_ONLY     = 0x00000002,
    PNRP_CLOUD_FULL_PARTICIPANT = 0x00000004,
}
alias PNRP_CLOUD_FLAGS = int;

enum : int
{
    PNRP_REGISTERED_ID_STATE_OK      = 0x00000001,
    PNRP_REGISTERED_ID_STATE_PROBLEM = 0x00000002,
}
alias PNRP_REGISTERED_ID_STATE = int;

enum : int
{
    PNRP_RESOLVE_CRITERIA_DEFAULT                               = 0x00000000,
    PNRP_RESOLVE_CRITERIA_REMOTE_PEER_NAME                      = 0x00000001,
    PNRP_RESOLVE_CRITERIA_NEAREST_REMOTE_PEER_NAME              = 0x00000002,
    PNRP_RESOLVE_CRITERIA_NON_CURRENT_PROCESS_PEER_NAME         = 0x00000003,
    PNRP_RESOLVE_CRITERIA_NEAREST_NON_CURRENT_PROCESS_PEER_NAME = 0x00000004,
    PNRP_RESOLVE_CRITERIA_ANY_PEER_NAME                         = 0x00000005,
    PNRP_RESOLVE_CRITERIA_NEAREST_PEER_NAME                     = 0x00000006,
}
alias PNRP_RESOLVE_CRITERIA = int;

enum : int
{
    PNRP_EXTENDED_PAYLOAD_TYPE_NONE   = 0x00000000,
    PNRP_EXTENDED_PAYLOAD_TYPE_BINARY = 0x00000001,
    PNRP_EXTENDED_PAYLOAD_TYPE_STRING = 0x00000002,
}
alias PNRP_EXTENDED_PAYLOAD_TYPE = int;

enum : int
{
    PEER_RECORD_ADDED   = 0x00000001,
    PEER_RECORD_UPDATED = 0x00000002,
    PEER_RECORD_DELETED = 0x00000003,
    PEER_RECORD_EXPIRED = 0x00000004,
}
alias PEER_RECORD_CHANGE_TYPE = int;

enum : int
{
    PEER_CONNECTED         = 0x00000001,
    PEER_DISCONNECTED      = 0x00000002,
    PEER_CONNECTION_FAILED = 0x00000003,
}
alias PEER_CONNECTION_STATUS = int;

enum : int
{
    PEER_CONNECTION_NEIGHBOR = 0x00000001,
    PEER_CONNECTION_DIRECT   = 0x00000002,
}
alias PEER_CONNECTION_FLAGS = int;

enum : int
{
    PEER_RECORD_FLAG_AUTOREFRESH = 0x00000001,
    PEER_RECORD_FLAG_DELETED     = 0x00000002,
}
alias PEER_RECORD_FLAGS = int;

enum : int
{
    PEER_GRAPH_EVENT_STATUS_CHANGED      = 0x00000001,
    PEER_GRAPH_EVENT_PROPERTY_CHANGED    = 0x00000002,
    PEER_GRAPH_EVENT_RECORD_CHANGED      = 0x00000003,
    PEER_GRAPH_EVENT_DIRECT_CONNECTION   = 0x00000004,
    PEER_GRAPH_EVENT_NEIGHBOR_CONNECTION = 0x00000005,
    PEER_GRAPH_EVENT_INCOMING_DATA       = 0x00000006,
    PEER_GRAPH_EVENT_CONNECTION_REQUIRED = 0x00000007,
    PEER_GRAPH_EVENT_NODE_CHANGED        = 0x00000008,
    PEER_GRAPH_EVENT_SYNCHRONIZED        = 0x00000009,
}
alias PEER_GRAPH_EVENT_TYPE = int;

enum : int
{
    PEER_NODE_CHANGE_CONNECTED    = 0x00000001,
    PEER_NODE_CHANGE_DISCONNECTED = 0x00000002,
    PEER_NODE_CHANGE_UPDATED      = 0x00000003,
}
alias PEER_NODE_CHANGE_TYPE = int;

enum : int
{
    PEER_GRAPH_STATUS_LISTENING       = 0x00000001,
    PEER_GRAPH_STATUS_HAS_CONNECTIONS = 0x00000002,
    PEER_GRAPH_STATUS_SYNCHRONIZED    = 0x00000004,
}
alias PEER_GRAPH_STATUS_FLAGS = int;

enum : int
{
    PEER_GRAPH_PROPERTY_HEARTBEATS       = 0x00000001,
    PEER_GRAPH_PROPERTY_DEFER_EXPIRATION = 0x00000002,
}
alias PEER_GRAPH_PROPERTY_FLAGS = int;

enum : int
{
    PEER_GRAPH_SCOPE_ANY       = 0x00000000,
    PEER_GRAPH_SCOPE_GLOBAL    = 0x00000001,
    PEER_GRAPH_SCOPE_SITELOCAL = 0x00000002,
    PEER_GRAPH_SCOPE_LINKLOCAL = 0x00000003,
    PEER_GRAPH_SCOPE_LOOPBACK  = 0x00000004,
}
alias PEER_GRAPH_SCOPE = int;

enum : int
{
    PEER_GROUP_EVENT_STATUS_CHANGED        = 0x00000001,
    PEER_GROUP_EVENT_PROPERTY_CHANGED      = 0x00000002,
    PEER_GROUP_EVENT_RECORD_CHANGED        = 0x00000003,
    PEER_GROUP_EVENT_DIRECT_CONNECTION     = 0x00000004,
    PEER_GROUP_EVENT_NEIGHBOR_CONNECTION   = 0x00000005,
    PEER_GROUP_EVENT_INCOMING_DATA         = 0x00000006,
    PEER_GROUP_EVENT_MEMBER_CHANGED        = 0x00000008,
    PEER_GROUP_EVENT_CONNECTION_FAILED     = 0x0000000a,
    PEER_GROUP_EVENT_AUTHENTICATION_FAILED = 0x0000000b,
}
alias PEER_GROUP_EVENT_TYPE = int;

enum : int
{
    PEER_GROUP_STATUS_LISTENING       = 0x00000001,
    PEER_GROUP_STATUS_HAS_CONNECTIONS = 0x00000002,
}
alias PEER_GROUP_STATUS = int;

enum : int
{
    PEER_MEMBER_DATA_OPTIONAL = 0x00000001,
    PEER_DISABLE_PRESENCE     = 0x00000002,
    PEER_DEFER_EXPIRATION     = 0x00000004,
}
alias PEER_GROUP_PROPERTY_FLAGS = int;

enum : int
{
    PEER_GROUP_GMC_AUTHENTICATION      = 0x00000001,
    PEER_GROUP_PASSWORD_AUTHENTICATION = 0x00000002,
}
alias PEER_GROUP_AUTHENTICATION_SCHEME = int;

enum : int
{
    PEER_MEMBER_PRESENT = 0x00000001,
}
alias PEER_MEMBER_FLAGS = int;

enum : int
{
    PEER_MEMBER_CONNECTED    = 0x00000001,
    PEER_MEMBER_DISCONNECTED = 0x00000002,
    PEER_MEMBER_UPDATED      = 0x00000003,
    PEER_MEMBER_JOINED       = 0x00000004,
    PEER_MEMBER_LEFT         = 0x00000005,
}
alias PEER_MEMBER_CHANGE_TYPE = int;

enum : int
{
    PEER_GROUP_STORE_CREDENTIALS = 0x00000001,
}
alias PEER_GROUP_ISSUE_CREDENTIAL_FLAGS = int;

enum : int
{
    PEER_SIGNIN_NONE     = 0x00000000,
    PEER_SIGNIN_NEAR_ME  = 0x00000001,
    PEER_SIGNIN_INTERNET = 0x00000002,
    PEER_SIGNIN_ALL      = 0x00000003,
}
alias PEER_SIGNIN_FLAGS = int;

enum : int
{
    PEER_WATCH_BLOCKED = 0x00000000,
    PEER_WATCH_ALLOWED = 0x00000001,
}
alias PEER_WATCH_PERMISSION = int;

enum : int
{
    PEER_PUBLICATION_SCOPE_NONE     = 0x00000000,
    PEER_PUBLICATION_SCOPE_NEAR_ME  = 0x00000001,
    PEER_PUBLICATION_SCOPE_INTERNET = 0x00000002,
    PEER_PUBLICATION_SCOPE_ALL      = 0x00000003,
}
alias PEER_PUBLICATION_SCOPE = int;

enum : int
{
    PEER_INVITATION_RESPONSE_DECLINED = 0x00000000,
    PEER_INVITATION_RESPONSE_ACCEPTED = 0x00000001,
    PEER_INVITATION_RESPONSE_EXPIRED  = 0x00000002,
    PEER_INVITATION_RESPONSE_ERROR    = 0x00000003,
}
alias PEER_INVITATION_RESPONSE_TYPE = int;

enum : int
{
    PEER_APPLICATION_CURRENT_USER = 0x00000000,
    PEER_APPLICATION_ALL_USERS    = 0x00000001,
}
alias PEER_APPLICATION_REGISTRATION_TYPE = int;

enum : int
{
    PEER_PRESENCE_OFFLINE       = 0x00000000,
    PEER_PRESENCE_OUT_TO_LUNCH  = 0x00000001,
    PEER_PRESENCE_AWAY          = 0x00000002,
    PEER_PRESENCE_BE_RIGHT_BACK = 0x00000003,
    PEER_PRESENCE_IDLE          = 0x00000004,
    PEER_PRESENCE_BUSY          = 0x00000005,
    PEER_PRESENCE_ON_THE_PHONE  = 0x00000006,
    PEER_PRESENCE_ONLINE        = 0x00000007,
}
alias PEER_PRESENCE_STATUS = int;

enum : int
{
    PEER_CHANGE_ADDED   = 0x00000000,
    PEER_CHANGE_DELETED = 0x00000001,
    PEER_CHANGE_UPDATED = 0x00000002,
}
alias PEER_CHANGE_TYPE = int;

enum : int
{
    PEER_EVENT_WATCHLIST_CHANGED            = 0x00000001,
    PEER_EVENT_ENDPOINT_CHANGED             = 0x00000002,
    PEER_EVENT_ENDPOINT_PRESENCE_CHANGED    = 0x00000003,
    PEER_EVENT_ENDPOINT_APPLICATION_CHANGED = 0x00000004,
    PEER_EVENT_ENDPOINT_OBJECT_CHANGED      = 0x00000005,
    PEER_EVENT_MY_ENDPOINT_CHANGED          = 0x00000006,
    PEER_EVENT_MY_PRESENCE_CHANGED          = 0x00000007,
    PEER_EVENT_MY_APPLICATION_CHANGED       = 0x00000008,
    PEER_EVENT_MY_OBJECT_CHANGED            = 0x00000009,
    PEER_EVENT_PEOPLE_NEAR_ME_CHANGED       = 0x0000000a,
    PEER_EVENT_REQUEST_STATUS_CHANGED       = 0x0000000b,
}
alias PEER_COLLAB_EVENT_TYPE = int;

enum : int
{
    DRT_GLOBAL_SCOPE     = 0x00000001,
    DRT_SITE_LOCAL_SCOPE = 0x00000002,
    DRT_LINK_LOCAL_SCOPE = 0x00000003,
}
alias DRT_SCOPE = int;

enum : int
{
    DRT_ACTIVE     = 0x00000000,
    DRT_ALONE      = 0x00000001,
    DRT_NO_NETWORK = 0x0000000a,
    DRT_FAULTED    = 0x00000014,
}
alias DRT_STATUS = int;

enum : int
{
    DRT_MATCH_EXACT        = 0x00000000,
    DRT_MATCH_NEAR         = 0x00000001,
    DRT_MATCH_INTERMEDIATE = 0x00000002,
}
alias DRT_MATCH_TYPE = int;

enum : int
{
    DRT_LEAFSET_KEY_ADDED   = 0x00000000,
    DRT_LEAFSET_KEY_DELETED = 0x00000001,
}
alias DRT_LEAFSET_KEY_CHANGE_TYPE = int;

enum : int
{
    DRT_EVENT_STATUS_CHANGED             = 0x00000000,
    DRT_EVENT_LEAFSET_KEY_CHANGED        = 0x00000001,
    DRT_EVENT_REGISTRATION_STATE_CHANGED = 0x00000002,
}
alias DRT_EVENT_TYPE = int;

enum : int
{
    DRT_SECURE_RESOLVE             = 0x00000000,
    DRT_SECURE_MEMBERSHIP          = 0x00000001,
    DRT_SECURE_CONFIDENTIALPAYLOAD = 0x00000002,
}
alias DRT_SECURITY_MODE = int;

enum : int
{
    DRT_REGISTRATION_STATE_UNRESOLVEABLE = 0x00000001,
}
alias DRT_REGISTRATION_STATE = int;

enum : int
{
    DRT_ADDRESS_FLAG_ACCEPTED                = 0x00000001,
    DRT_ADDRESS_FLAG_REJECTED                = 0x00000002,
    DRT_ADDRESS_FLAG_UNREACHABLE             = 0x00000004,
    DRT_ADDRESS_FLAG_LOOP                    = 0x00000008,
    DRT_ADDRESS_FLAG_TOO_BUSY                = 0x00000010,
    DRT_ADDRESS_FLAG_BAD_VALIDATE_ID         = 0x00000020,
    DRT_ADDRESS_FLAG_SUSPECT_UNREGISTERED_ID = 0x00000040,
    DRT_ADDRESS_FLAG_INQUIRE                 = 0x00000080,
}
alias DRT_ADDRESS_FLAGS = int;

enum : int
{
    PEERDIST_STATUS_DISABLED    = 0x00000000,
    PEERDIST_STATUS_UNAVAILABLE = 0x00000001,
    PEERDIST_STATUS_AVAILABLE   = 0x00000002,
}
alias PEERDIST_STATUS = int;

enum : int
{
    PeerDistClientBasicInfo                 = 0x00000000,
    MaximumPeerDistClientInfoByHandlesClass = 0x00000001,
}
alias PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS = int;

// Callbacks

alias PFNPEER_VALIDATE_RECORD = HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, 
                                                 PEER_RECORD_CHANGE_TYPE changeType);
alias PFNPEER_SECURE_RECORD = HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, 
                                               PEER_RECORD_CHANGE_TYPE changeType, PEER_DATA** ppSecurityData);
alias PFNPEER_FREE_SECURITY_DATA = HRESULT function(void* hGraph, void* pvContext, PEER_DATA* pSecurityData);
alias PFNPEER_ON_PASSWORD_AUTH_FAILED = HRESULT function(void* hGraph, void* pvContext);
alias DRT_BOOTSTRAP_RESOLVE_CALLBACK = void function(HRESULT hr, void* pvContext, SOCKET_ADDRESS_LIST* pAddresses, 
                                                     BOOL fFatalError);

// Structs


struct PNRP_CLOUD_ID
{
    int        AddressFamily;
    PNRP_SCOPE Scope;
    uint       ScopeId;
}

struct PNRPINFO_V1
{
    uint           dwSize;
    const(wchar)*  lpwszIdentity;
    uint           nMaxResolve;
    uint           dwTimeout;
    uint           dwLifetime;
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    uint           dwFlags;
    SOCKET_ADDRESS saHint;
    PNRP_REGISTERED_ID_STATE enNameState;
}

struct PNRPINFO_V2
{
    uint           dwSize;
    const(wchar)*  lpwszIdentity;
    uint           nMaxResolve;
    uint           dwTimeout;
    uint           dwLifetime;
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    uint           dwFlags;
    SOCKET_ADDRESS saHint;
    PNRP_REGISTERED_ID_STATE enNameState;
    PNRP_EXTENDED_PAYLOAD_TYPE enExtendedPayloadType;
    union
    {
        BLOB          blobPayload;
        const(wchar)* pwszPayload;
    }
}

struct PNRPCLOUDINFO
{
    uint             dwSize;
    PNRP_CLOUD_ID    Cloud;
    PNRP_CLOUD_STATE enCloudState;
    PNRP_CLOUD_FLAGS enCloudFlags;
}

struct PEER_VERSION_DATA
{
    ushort wVersion;
    ushort wHighestVersion;
}

struct PEER_DATA
{
    uint   cbData;
    ubyte* pbData;
}

struct PEER_RECORD
{
    uint          dwSize;
    GUID          type;
    GUID          id;
    uint          dwVersion;
    uint          dwFlags;
    const(wchar)* pwzCreatorId;
    const(wchar)* pwzModifiedById;
    const(wchar)* pwzAttributes;
    FILETIME      ftCreation;
    FILETIME      ftExpiration;
    FILETIME      ftLastModified;
    PEER_DATA     securityData;
    PEER_DATA     data;
}

struct PEER_ADDRESS
{
    uint            dwSize;
    SOCKADDR_IN6_LH sin6;
}

struct PEER_CONNECTION_INFO
{
    uint          dwSize;
    uint          dwFlags;
    ulong         ullConnectionId;
    ulong         ullNodeId;
    const(wchar)* pwzPeerId;
    PEER_ADDRESS  address;
}

struct PEER_EVENT_INCOMING_DATA
{
    uint      dwSize;
    ulong     ullConnectionId;
    GUID      type;
    PEER_DATA data;
}

struct PEER_EVENT_RECORD_CHANGE_DATA
{
    uint dwSize;
    PEER_RECORD_CHANGE_TYPE changeType;
    GUID recordId;
    GUID recordType;
}

struct PEER_EVENT_CONNECTION_CHANGE_DATA
{
    uint    dwSize;
    PEER_CONNECTION_STATUS status;
    ulong   ullConnectionId;
    ulong   ullNodeId;
    ulong   ullNextConnectionId;
    HRESULT hrConnectionFailedReason;
}

struct PEER_EVENT_SYNCHRONIZED_DATA
{
    uint dwSize;
    GUID recordType;
}

struct PEER_GRAPH_PROPERTIES
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwScope;
    uint          dwMaxRecordSize;
    const(wchar)* pwzGraphId;
    const(wchar)* pwzCreatorId;
    const(wchar)* pwzFriendlyName;
    const(wchar)* pwzComment;
    uint          ulPresenceLifetime;
    uint          cPresenceMax;
}

struct PEER_NODE_INFO
{
    uint          dwSize;
    ulong         ullNodeId;
    const(wchar)* pwzPeerId;
    uint          cAddresses;
    PEER_ADDRESS* pAddresses;
    const(wchar)* pwzAttributes;
}

struct PEER_EVENT_NODE_CHANGE_DATA
{
    uint          dwSize;
    PEER_NODE_CHANGE_TYPE changeType;
    ulong         ullNodeId;
    const(wchar)* pwzPeerId;
}

struct PEER_GRAPH_EVENT_REGISTRATION
{
    PEER_GRAPH_EVENT_TYPE eventType;
    GUID* pType;
}

struct PEER_GRAPH_EVENT_DATA
{
    PEER_GRAPH_EVENT_TYPE eventType;
    union
    {
        PEER_GRAPH_STATUS_FLAGS dwStatus;
        PEER_EVENT_INCOMING_DATA incomingData;
        PEER_EVENT_RECORD_CHANGE_DATA recordChangeData;
        PEER_EVENT_CONNECTION_CHANGE_DATA connectionChangeData;
        PEER_EVENT_NODE_CHANGE_DATA nodeChangeData;
        PEER_EVENT_SYNCHRONIZED_DATA synchronizedData;
    }
}

struct PEER_SECURITY_INTERFACE
{
    uint          dwSize;
    const(wchar)* pwzSspFilename;
    const(wchar)* pwzPackageName;
    uint          cbSecurityInfo;
    ubyte*        pbSecurityInfo;
    void*         pvContext;
    PFNPEER_VALIDATE_RECORD pfnValidateRecord;
    PFNPEER_SECURE_RECORD pfnSecureRecord;
    PFNPEER_FREE_SECURITY_DATA pfnFreeSecurityData;
    PFNPEER_ON_PASSWORD_AUTH_FAILED pfnAuthFailed;
}

struct PEER_CREDENTIAL_INFO
{
    uint          dwSize;
    uint          dwFlags;
    const(wchar)* pwzFriendlyName;
    CERT_PUBLIC_KEY_INFO* pPublicKey;
    const(wchar)* pwzIssuerPeerName;
    const(wchar)* pwzIssuerFriendlyName;
    FILETIME      ftValidityStart;
    FILETIME      ftValidityEnd;
    uint          cRoles;
    GUID*         pRoles;
}

struct PEER_MEMBER
{
    uint          dwSize;
    uint          dwFlags;
    const(wchar)* pwzIdentity;
    const(wchar)* pwzAttributes;
    ulong         ullNodeId;
    uint          cAddresses;
    PEER_ADDRESS* pAddresses;
    PEER_CREDENTIAL_INFO* pCredentialInfo;
}

struct PEER_INVITATION_INFO
{
    uint          dwSize;
    uint          dwFlags;
    const(wchar)* pwzCloudName;
    uint          dwScope;
    uint          dwCloudFlags;
    const(wchar)* pwzGroupPeerName;
    const(wchar)* pwzIssuerPeerName;
    const(wchar)* pwzSubjectPeerName;
    const(wchar)* pwzGroupFriendlyName;
    const(wchar)* pwzIssuerFriendlyName;
    const(wchar)* pwzSubjectFriendlyName;
    FILETIME      ftValidityStart;
    FILETIME      ftValidityEnd;
    uint          cRoles;
    GUID*         pRoles;
    uint          cClassifiers;
    ushort**      ppwzClassifiers;
    CERT_PUBLIC_KEY_INFO* pSubjectPublicKey;
    PEER_GROUP_AUTHENTICATION_SCHEME authScheme;
}

struct PEER_GROUP_PROPERTIES
{
    uint          dwSize;
    uint          dwFlags;
    const(wchar)* pwzCloud;
    const(wchar)* pwzClassifier;
    const(wchar)* pwzGroupPeerName;
    const(wchar)* pwzCreatorPeerName;
    const(wchar)* pwzFriendlyName;
    const(wchar)* pwzComment;
    uint          ulMemberDataLifetime;
    uint          ulPresenceLifetime;
    uint          dwAuthenticationSchemes;
    const(wchar)* pwzGroupPassword;
    GUID          groupPasswordRole;
}

struct PEER_EVENT_MEMBER_CHANGE_DATA
{
    uint          dwSize;
    PEER_MEMBER_CHANGE_TYPE changeType;
    const(wchar)* pwzIdentity;
}

struct PEER_GROUP_EVENT_REGISTRATION
{
    PEER_GROUP_EVENT_TYPE eventType;
    GUID* pType;
}

struct PEER_GROUP_EVENT_DATA
{
    PEER_GROUP_EVENT_TYPE eventType;
    union
    {
        PEER_GROUP_STATUS dwStatus;
        PEER_EVENT_INCOMING_DATA incomingData;
        PEER_EVENT_RECORD_CHANGE_DATA recordChangeData;
        PEER_EVENT_CONNECTION_CHANGE_DATA connectionChangeData;
        PEER_EVENT_MEMBER_CHANGE_DATA memberChangeData;
        HRESULT           hrConnectionFailedReason;
    }
}

struct PEER_NAME_PAIR
{
    uint          dwSize;
    const(wchar)* pwzPeerName;
    const(wchar)* pwzFriendlyName;
}

struct PEER_APPLICATION
{
    GUID          id;
    PEER_DATA     data;
    const(wchar)* pwzDescription;
}

struct PEER_OBJECT
{
    GUID      id;
    PEER_DATA data;
    uint      dwPublicationScope;
}

struct PEER_CONTACT
{
    const(wchar)* pwzPeerName;
    const(wchar)* pwzNickName;
    const(wchar)* pwzDisplayName;
    const(wchar)* pwzEmailAddress;
    BOOL          fWatch;
    PEER_WATCH_PERMISSION WatcherPermissions;
    PEER_DATA     credentials;
}

struct PEER_ENDPOINT
{
    PEER_ADDRESS  address;
    const(wchar)* pwzEndpointName;
}

struct PEER_PEOPLE_NEAR_ME
{
    const(wchar)* pwzNickName;
    PEER_ENDPOINT endpoint;
    GUID          id;
}

struct PEER_INVITATION
{
    GUID          applicationId;
    PEER_DATA     applicationData;
    const(wchar)* pwzMessage;
}

struct PEER_INVITATION_RESPONSE
{
    PEER_INVITATION_RESPONSE_TYPE action;
    const(wchar)* pwzMessage;
    HRESULT       hrExtendedInfo;
}

struct PEER_APP_LAUNCH_INFO
{
    PEER_CONTACT*    pContact;
    PEER_ENDPOINT*   pEndpoint;
    PEER_INVITATION* pInvitation;
}

struct PEER_APPLICATION_REGISTRATION_INFO
{
    PEER_APPLICATION application;
    const(wchar)*    pwzApplicationToLaunch;
    const(wchar)*    pwzApplicationArguments;
    uint             dwPublicationScope;
}

struct PEER_PRESENCE_INFO
{
    PEER_PRESENCE_STATUS status;
    const(wchar)*        pwzDescriptiveText;
}

struct PEER_COLLAB_EVENT_REGISTRATION
{
    PEER_COLLAB_EVENT_TYPE eventType;
    GUID* pInstance;
}

struct PEER_EVENT_WATCHLIST_CHANGED_DATA
{
    PEER_CONTACT*    pContact;
    PEER_CHANGE_TYPE changeType;
}

struct PEER_EVENT_PRESENCE_CHANGED_DATA
{
    PEER_CONTACT*       pContact;
    PEER_ENDPOINT*      pEndpoint;
    PEER_CHANGE_TYPE    changeType;
    PEER_PRESENCE_INFO* pPresenceInfo;
}

struct PEER_EVENT_APPLICATION_CHANGED_DATA
{
    PEER_CONTACT*     pContact;
    PEER_ENDPOINT*    pEndpoint;
    PEER_CHANGE_TYPE  changeType;
    PEER_APPLICATION* pApplication;
}

struct PEER_EVENT_OBJECT_CHANGED_DATA
{
    PEER_CONTACT*    pContact;
    PEER_ENDPOINT*   pEndpoint;
    PEER_CHANGE_TYPE changeType;
    PEER_OBJECT*     pObject;
}

struct PEER_EVENT_ENDPOINT_CHANGED_DATA
{
    PEER_CONTACT*  pContact;
    PEER_ENDPOINT* pEndpoint;
}

struct PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA
{
    PEER_CHANGE_TYPE     changeType;
    PEER_PEOPLE_NEAR_ME* pPeopleNearMe;
}

struct PEER_EVENT_REQUEST_STATUS_CHANGED_DATA
{
    PEER_ENDPOINT* pEndpoint;
    HRESULT        hrChange;
}

struct PEER_COLLAB_EVENT_DATA
{
    PEER_COLLAB_EVENT_TYPE eventType;
    union
    {
        PEER_EVENT_WATCHLIST_CHANGED_DATA watchListChangedData;
        PEER_EVENT_PRESENCE_CHANGED_DATA presenceChangedData;
        PEER_EVENT_APPLICATION_CHANGED_DATA applicationChangedData;
        PEER_EVENT_OBJECT_CHANGED_DATA objectChangedData;
        PEER_EVENT_ENDPOINT_CHANGED_DATA endpointChangedData;
        PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA peopleNearMeChangedData;
        PEER_EVENT_REQUEST_STATUS_CHANGED_DATA requestStatusChangedData;
    }
}

struct PEER_PNRP_ENDPOINT_INFO
{
    const(wchar)* pwzPeerName;
    uint          cAddresses;
    SOCKADDR**    ppAddresses;
    const(wchar)* pwzComment;
    PEER_DATA     payload;
}

struct PEER_PNRP_CLOUD_INFO
{
    const(wchar)* pwzCloudName;
    PNRP_SCOPE    dwScope;
    uint          dwScopeId;
}

struct PEER_PNRP_REGISTRATION_INFO
{
    const(wchar)* pwzCloudName;
    const(wchar)* pwzPublishingIdentity;
    uint          cAddresses;
    SOCKADDR**    ppAddresses;
    ushort        wPort;
    const(wchar)* pwzComment;
    PEER_DATA     payload;
}

struct DRT_DATA
{
    uint   cb;
    ubyte* pb;
}

struct DRT_REGISTRATION
{
    DRT_DATA key;
    DRT_DATA appData;
}

struct DRT_SECURITY_PROVIDER
{
    void*            pvContext;
    HRESULT********* Attach;
    ptrdiff_t        Detach;
    HRESULT********* RegisterKey;
    HRESULT********* UnregisterKey;
    HRESULT********* ValidateAndUnpackPayload;
    HRESULT********* SecureAndPackPayload;
    ptrdiff_t        FreeData;
    HRESULT********* EncryptData;
    HRESULT********* DecryptData;
    HRESULT********* GetSerializedCredential;
    HRESULT********* ValidateRemoteCredential;
    HRESULT********* SignData;
    HRESULT********* VerifyData;
}

struct DRT_BOOTSTRAP_PROVIDER
{
    void*            pvContext;
    HRESULT********* Attach;
    ptrdiff_t        Detach;
    HRESULT********* InitResolve;
    HRESULT********* IssueResolve;
    ptrdiff_t        EndResolve;
    HRESULT********* Register;
    ptrdiff_t        Unregister;
}

struct DRT_SETTINGS
{
    uint              dwSize;
    uint              cbKey;
    ubyte             bProtocolMajorVersion;
    ubyte             bProtocolMinorVersion;
    uint              ulMaxRoutingAddresses;
    const(wchar)*     pwzDrtInstancePrefix;
    void*             hTransport;
    DRT_SECURITY_PROVIDER* pSecurityProvider;
    DRT_BOOTSTRAP_PROVIDER* pBootstrapProvider;
    DRT_SECURITY_MODE eSecurityMode;
}

struct DRT_SEARCH_INFO
{
    uint      dwSize;
    BOOL      fIterative;
    BOOL      fAllowCurrentInstanceMatch;
    BOOL      fAnyMatchInRange;
    uint      cMaxEndpoints;
    DRT_DATA* pMaximumKey;
    DRT_DATA* pMinimumKey;
}

struct DRT_ADDRESS
{
    SOCKADDR_STORAGE_LH socketAddress;
    uint                flags;
    int                 nearness;
    uint                latency;
}

struct DRT_ADDRESS_LIST
{
    uint           AddressCount;
    DRT_ADDRESS[1] AddressList;
}

struct DRT_SEARCH_RESULT
{
    uint             dwSize;
    DRT_MATCH_TYPE   type;
    void*            pvContext;
    DRT_REGISTRATION registration;
}

struct DRT_EVENT_DATA
{
    DRT_EVENT_TYPE type;
    HRESULT        hr;
    void*          pvContext;
    union
    {
        struct leafsetKeyChange
        {
            DRT_LEAFSET_KEY_CHANGE_TYPE change;
            DRT_DATA localKey;
            DRT_DATA remoteKey;
        }
        struct registrationStateChange
        {
            DRT_REGISTRATION_STATE state;
            DRT_DATA localKey;
        }
        struct statusChange
        {
            DRT_STATUS status;
            struct bootstrapAddresses
            {
                uint                 cntAddress;
                SOCKADDR_STORAGE_LH* pAddresses;
            }
        }
    }
}

struct PEERDIST_PUBLICATION_OPTIONS
{
    uint dwVersion;
    uint dwFlags;
}

struct PEERDIST_CONTENT_TAG
{
    ubyte[16] Data;
}

struct PEERDIST_RETRIEVAL_OPTIONS
{
    uint cbSize;
    uint dwContentInfoMinVersion;
    uint dwContentInfoMaxVersion;
    uint dwReserved;
}

struct PEERDIST_STATUS_INFO
{
    uint            cbSize;
    PEERDIST_STATUS status;
    uint            dwMinVer;
    uint            dwMaxVer;
}

struct PEERDIST_CLIENT_BASIC_INFO
{
    BOOL fFlashCrowd;
}

// Functions

@DllImport("P2PGRAPH")
HRESULT PeerGraphStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

@DllImport("P2PGRAPH")
HRESULT PeerGraphShutdown();

@DllImport("P2PGRAPH")
void PeerGraphFreeData(void* pvData);

@DllImport("P2PGRAPH")
HRESULT PeerGraphGetItemCount(void* hPeerEnum, uint* pCount);

@DllImport("P2PGRAPH")
HRESULT PeerGraphGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

@DllImport("P2PGRAPH")
HRESULT PeerGraphEndEnumeration(void* hPeerEnum);

@DllImport("P2PGRAPH")
HRESULT PeerGraphCreate(PEER_GRAPH_PROPERTIES* pGraphProperties, const(wchar)* pwzDatabaseName, 
                        PEER_SECURITY_INTERFACE* pSecurityInterface, void** phGraph);

@DllImport("P2PGRAPH")
HRESULT PeerGraphOpen(const(wchar)* pwzGraphId, const(wchar)* pwzPeerId, const(wchar)* pwzDatabaseName, 
                      PEER_SECURITY_INTERFACE* pSecurityInterface, uint cRecordTypeSyncPrecedence, 
                      char* pRecordTypeSyncPrecedence, void** phGraph);

@DllImport("P2PGRAPH")
HRESULT PeerGraphListen(void* hGraph, uint dwScope, uint dwScopeId, ushort wPort);

@DllImport("P2PGRAPH")
HRESULT PeerGraphConnect(void* hGraph, const(wchar)* pwzPeerId, PEER_ADDRESS* pAddress, ulong* pullConnectionId);

@DllImport("P2PGRAPH")
HRESULT PeerGraphClose(void* hGraph);

@DllImport("P2PGRAPH")
HRESULT PeerGraphDelete(const(wchar)* pwzGraphId, const(wchar)* pwzPeerId, const(wchar)* pwzDatabaseName);

@DllImport("P2PGRAPH")
HRESULT PeerGraphGetStatus(void* hGraph, uint* pdwStatus);

@DllImport("P2PGRAPH")
HRESULT PeerGraphGetProperties(void* hGraph, PEER_GRAPH_PROPERTIES** ppGraphProperties);

@DllImport("P2PGRAPH")
HRESULT PeerGraphSetProperties(void* hGraph, PEER_GRAPH_PROPERTIES* pGraphProperties);

@DllImport("P2PGRAPH")
HRESULT PeerGraphRegisterEvent(void* hGraph, HANDLE hEvent, uint cEventRegistrations, char* pEventRegistrations, 
                               void** phPeerEvent);

@DllImport("P2PGRAPH")
HRESULT PeerGraphUnregisterEvent(void* hPeerEvent);

@DllImport("P2PGRAPH")
HRESULT PeerGraphGetEventData(void* hPeerEvent, PEER_GRAPH_EVENT_DATA** ppEventData);

@DllImport("P2PGRAPH")
HRESULT PeerGraphGetRecord(void* hGraph, const(GUID)* pRecordId, PEER_RECORD** ppRecord);

@DllImport("P2PGRAPH")
HRESULT PeerGraphAddRecord(void* hGraph, PEER_RECORD* pRecord, GUID* pRecordId);

@DllImport("P2PGRAPH")
HRESULT PeerGraphUpdateRecord(void* hGraph, PEER_RECORD* pRecord);

@DllImport("P2PGRAPH")
HRESULT PeerGraphDeleteRecord(void* hGraph, const(GUID)* pRecordId, BOOL fLocal);

@DllImport("P2PGRAPH")
HRESULT PeerGraphEnumRecords(void* hGraph, const(GUID)* pRecordType, const(wchar)* pwzPeerId, void** phPeerEnum);

@DllImport("P2PGRAPH")
HRESULT PeerGraphSearchRecords(void* hGraph, const(wchar)* pwzCriteria, void** phPeerEnum);

@DllImport("P2PGRAPH")
HRESULT PeerGraphExportDatabase(void* hGraph, const(wchar)* pwzFilePath);

@DllImport("P2PGRAPH")
HRESULT PeerGraphImportDatabase(void* hGraph, const(wchar)* pwzFilePath);

@DllImport("P2PGRAPH")
HRESULT PeerGraphValidateDeferredRecords(void* hGraph, uint cRecordIds, char* pRecordIds);

@DllImport("P2PGRAPH")
HRESULT PeerGraphOpenDirectConnection(void* hGraph, const(wchar)* pwzPeerId, PEER_ADDRESS* pAddress, 
                                      ulong* pullConnectionId);

@DllImport("P2PGRAPH")
HRESULT PeerGraphSendData(void* hGraph, ulong ullConnectionId, const(GUID)* pType, uint cbData, char* pvData);

@DllImport("P2PGRAPH")
HRESULT PeerGraphCloseDirectConnection(void* hGraph, ulong ullConnectionId);

@DllImport("P2PGRAPH")
HRESULT PeerGraphEnumConnections(void* hGraph, uint dwFlags, void** phPeerEnum);

@DllImport("P2PGRAPH")
HRESULT PeerGraphEnumNodes(void* hGraph, const(wchar)* pwzPeerId, void** phPeerEnum);

@DllImport("P2PGRAPH")
HRESULT PeerGraphSetPresence(void* hGraph, BOOL fPresent);

@DllImport("P2PGRAPH")
HRESULT PeerGraphGetNodeInfo(void* hGraph, ulong ullNodeId, PEER_NODE_INFO** ppNodeInfo);

@DllImport("P2PGRAPH")
HRESULT PeerGraphSetNodeAttributes(void* hGraph, const(wchar)* pwzAttributes);

@DllImport("P2PGRAPH")
HRESULT PeerGraphPeerTimeToUniversalTime(void* hGraph, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

@DllImport("P2PGRAPH")
HRESULT PeerGraphUniversalTimeToPeerTime(void* hGraph, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

@DllImport("P2P")
void PeerFreeData(void* pvData);

@DllImport("P2P")
HRESULT PeerGetItemCount(void* hPeerEnum, uint* pCount);

@DllImport("P2P")
HRESULT PeerGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

@DllImport("P2P")
HRESULT PeerEndEnumeration(void* hPeerEnum);

@DllImport("P2P")
HRESULT PeerGroupStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

@DllImport("P2P")
HRESULT PeerGroupShutdown();

@DllImport("P2P")
HRESULT PeerGroupCreate(PEER_GROUP_PROPERTIES* pProperties, void** phGroup);

@DllImport("P2P")
HRESULT PeerGroupOpen(const(wchar)* pwzIdentity, const(wchar)* pwzGroupPeerName, const(wchar)* pwzCloud, 
                      void** phGroup);

@DllImport("P2P")
HRESULT PeerGroupJoin(const(wchar)* pwzIdentity, const(wchar)* pwzInvitation, const(wchar)* pwzCloud, 
                      void** phGroup);

@DllImport("P2P")
HRESULT PeerGroupPasswordJoin(const(wchar)* pwzIdentity, const(wchar)* pwzInvitation, const(wchar)* pwzPassword, 
                              const(wchar)* pwzCloud, void** phGroup);

@DllImport("P2P")
HRESULT PeerGroupConnect(void* hGroup);

@DllImport("P2P")
HRESULT PeerGroupConnectByAddress(void* hGroup, uint cAddresses, char* pAddresses);

@DllImport("P2P")
HRESULT PeerGroupClose(void* hGroup);

@DllImport("P2P")
HRESULT PeerGroupDelete(const(wchar)* pwzIdentity, const(wchar)* pwzGroupPeerName);

@DllImport("P2P")
HRESULT PeerGroupCreateInvitation(void* hGroup, const(wchar)* pwzIdentityInfo, FILETIME* pftExpiration, 
                                  uint cRoles, char* pRoles, ushort** ppwzInvitation);

@DllImport("P2P")
HRESULT PeerGroupCreatePasswordInvitation(void* hGroup, ushort** ppwzInvitation);

@DllImport("P2P")
HRESULT PeerGroupParseInvitation(const(wchar)* pwzInvitation, PEER_INVITATION_INFO** ppInvitationInfo);

@DllImport("P2P")
HRESULT PeerGroupGetStatus(void* hGroup, uint* pdwStatus);

@DllImport("P2P")
HRESULT PeerGroupGetProperties(void* hGroup, PEER_GROUP_PROPERTIES** ppProperties);

@DllImport("P2P")
HRESULT PeerGroupSetProperties(void* hGroup, PEER_GROUP_PROPERTIES* pProperties);

@DllImport("P2P")
HRESULT PeerGroupEnumMembers(void* hGroup, uint dwFlags, const(wchar)* pwzIdentity, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerGroupOpenDirectConnection(void* hGroup, const(wchar)* pwzIdentity, PEER_ADDRESS* pAddress, 
                                      ulong* pullConnectionId);

@DllImport("P2P")
HRESULT PeerGroupCloseDirectConnection(void* hGroup, ulong ullConnectionId);

@DllImport("P2P")
HRESULT PeerGroupEnumConnections(void* hGroup, uint dwFlags, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerGroupSendData(void* hGroup, ulong ullConnectionId, const(GUID)* pType, uint cbData, char* pvData);

@DllImport("P2P")
HRESULT PeerGroupRegisterEvent(void* hGroup, HANDLE hEvent, uint cEventRegistration, char* pEventRegistrations, 
                               void** phPeerEvent);

@DllImport("P2P")
HRESULT PeerGroupUnregisterEvent(void* hPeerEvent);

@DllImport("P2P")
HRESULT PeerGroupGetEventData(void* hPeerEvent, PEER_GROUP_EVENT_DATA** ppEventData);

@DllImport("P2P")
HRESULT PeerGroupGetRecord(void* hGroup, const(GUID)* pRecordId, PEER_RECORD** ppRecord);

@DllImport("P2P")
HRESULT PeerGroupAddRecord(void* hGroup, PEER_RECORD* pRecord, GUID* pRecordId);

@DllImport("P2P")
HRESULT PeerGroupUpdateRecord(void* hGroup, PEER_RECORD* pRecord);

@DllImport("P2P")
HRESULT PeerGroupDeleteRecord(void* hGroup, const(GUID)* pRecordId);

@DllImport("P2P")
HRESULT PeerGroupEnumRecords(void* hGroup, const(GUID)* pRecordType, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerGroupSearchRecords(void* hGroup, const(wchar)* pwzCriteria, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerGroupExportDatabase(void* hGroup, const(wchar)* pwzFilePath);

@DllImport("P2P")
HRESULT PeerGroupImportDatabase(void* hGroup, const(wchar)* pwzFilePath);

@DllImport("P2P")
HRESULT PeerGroupIssueCredentials(void* hGroup, const(wchar)* pwzSubjectIdentity, 
                                  PEER_CREDENTIAL_INFO* pCredentialInfo, uint dwFlags, ushort** ppwzInvitation);

@DllImport("P2P")
HRESULT PeerGroupExportConfig(void* hGroup, const(wchar)* pwzPassword, ushort** ppwzXML);

@DllImport("P2P")
HRESULT PeerGroupImportConfig(const(wchar)* pwzXML, const(wchar)* pwzPassword, BOOL fOverwrite, 
                              ushort** ppwzIdentity, ushort** ppwzGroup);

@DllImport("P2P")
HRESULT PeerGroupPeerTimeToUniversalTime(void* hGroup, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

@DllImport("P2P")
HRESULT PeerGroupUniversalTimeToPeerTime(void* hGroup, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

@DllImport("P2P")
HRESULT PeerGroupResumePasswordAuthentication(void* hGroup, void* hPeerEventHandle);

@DllImport("P2P")
HRESULT PeerIdentityCreate(const(wchar)* pwzClassifier, const(wchar)* pwzFriendlyName, size_t hCryptProv, 
                           ushort** ppwzIdentity);

@DllImport("P2P")
HRESULT PeerIdentityGetFriendlyName(const(wchar)* pwzIdentity, ushort** ppwzFriendlyName);

@DllImport("P2P")
HRESULT PeerIdentitySetFriendlyName(const(wchar)* pwzIdentity, const(wchar)* pwzFriendlyName);

@DllImport("P2P")
HRESULT PeerIdentityGetCryptKey(const(wchar)* pwzIdentity, size_t* phCryptProv);

@DllImport("P2P")
HRESULT PeerIdentityDelete(const(wchar)* pwzIdentity);

@DllImport("P2P")
HRESULT PeerEnumIdentities(void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerEnumGroups(const(wchar)* pwzIdentity, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerCreatePeerName(const(wchar)* pwzIdentity, const(wchar)* pwzClassifier, ushort** ppwzPeerName);

@DllImport("P2P")
HRESULT PeerIdentityGetXML(const(wchar)* pwzIdentity, ushort** ppwzIdentityXML);

@DllImport("P2P")
HRESULT PeerIdentityExport(const(wchar)* pwzIdentity, const(wchar)* pwzPassword, ushort** ppwzExportXML);

@DllImport("P2P")
HRESULT PeerIdentityImport(const(wchar)* pwzImportXML, const(wchar)* pwzPassword, ushort** ppwzIdentity);

@DllImport("P2P")
HRESULT PeerIdentityGetDefault(ushort** ppwzPeerName);

@DllImport("P2P")
HRESULT PeerCollabStartup(ushort wVersionRequested);

@DllImport("P2P")
HRESULT PeerCollabShutdown();

@DllImport("P2P")
HRESULT PeerCollabSignin(HWND hwndParent, uint dwSigninOptions);

@DllImport("P2P")
HRESULT PeerCollabSignout(uint dwSigninOptions);

@DllImport("P2P")
HRESULT PeerCollabGetSigninOptions(uint* pdwSigninOptions);

@DllImport("P2P")
HRESULT PeerCollabAsyncInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, 
                                     PEER_INVITATION* pcInvitation, HANDLE hEvent, HANDLE* phInvitation);

@DllImport("P2P")
HRESULT PeerCollabGetInvitationResponse(HANDLE hInvitation, PEER_INVITATION_RESPONSE** ppInvitationResponse);

@DllImport("P2P")
HRESULT PeerCollabCancelInvitation(HANDLE hInvitation);

@DllImport("P2P")
HRESULT PeerCollabCloseHandle(HANDLE hInvitation);

@DllImport("P2P")
HRESULT PeerCollabInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, 
                                PEER_INVITATION_RESPONSE** ppResponse);

@DllImport("P2P")
HRESULT PeerCollabAsyncInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, HANDLE hEvent, 
                                      HANDLE* phInvitation);

@DllImport("P2P")
HRESULT PeerCollabInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, 
                                 PEER_INVITATION_RESPONSE** ppResponse);

@DllImport("P2P")
HRESULT PeerCollabGetAppLaunchInfo(PEER_APP_LAUNCH_INFO** ppLaunchInfo);

@DllImport("P2P")
HRESULT PeerCollabRegisterApplication(PEER_APPLICATION_REGISTRATION_INFO* pcApplication, 
                                      PEER_APPLICATION_REGISTRATION_TYPE registrationType);

@DllImport("P2P")
HRESULT PeerCollabUnregisterApplication(const(GUID)* pApplicationId, 
                                        PEER_APPLICATION_REGISTRATION_TYPE registrationType);

@DllImport("P2P")
HRESULT PeerCollabGetApplicationRegistrationInfo(const(GUID)* pApplicationId, 
                                                 PEER_APPLICATION_REGISTRATION_TYPE registrationType, 
                                                 PEER_APPLICATION_REGISTRATION_INFO** ppApplication);

@DllImport("P2P")
HRESULT PeerCollabEnumApplicationRegistrationInfo(PEER_APPLICATION_REGISTRATION_TYPE registrationType, 
                                                  void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerCollabGetPresenceInfo(PEER_ENDPOINT* pcEndpoint, PEER_PRESENCE_INFO** ppPresenceInfo);

@DllImport("P2P")
HRESULT PeerCollabEnumApplications(PEER_ENDPOINT* pcEndpoint, const(GUID)* pApplicationId, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerCollabEnumObjects(PEER_ENDPOINT* pcEndpoint, const(GUID)* pObjectId, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerCollabEnumEndpoints(PEER_CONTACT* pcContact, void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerCollabRefreshEndpointData(PEER_ENDPOINT* pcEndpoint);

@DllImport("P2P")
HRESULT PeerCollabDeleteEndpointData(PEER_ENDPOINT* pcEndpoint);

@DllImport("P2P")
HRESULT PeerCollabQueryContactData(PEER_ENDPOINT* pcEndpoint, ushort** ppwzContactData);

@DllImport("P2P")
HRESULT PeerCollabSubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

@DllImport("P2P")
HRESULT PeerCollabUnsubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

@DllImport("P2P")
HRESULT PeerCollabSetPresenceInfo(PEER_PRESENCE_INFO* pcPresenceInfo);

@DllImport("P2P")
HRESULT PeerCollabGetEndpointName(ushort** ppwzEndpointName);

@DllImport("P2P")
HRESULT PeerCollabSetEndpointName(const(wchar)* pwzEndpointName);

@DllImport("P2P")
HRESULT PeerCollabSetObject(PEER_OBJECT* pcObject);

@DllImport("P2P")
HRESULT PeerCollabDeleteObject(const(GUID)* pObjectId);

@DllImport("P2P")
HRESULT PeerCollabRegisterEvent(HANDLE hEvent, uint cEventRegistration, char* pEventRegistrations, 
                                void** phPeerEvent);

@DllImport("P2P")
HRESULT PeerCollabGetEventData(void* hPeerEvent, PEER_COLLAB_EVENT_DATA** ppEventData);

@DllImport("P2P")
HRESULT PeerCollabUnregisterEvent(void* hPeerEvent);

@DllImport("P2P")
HRESULT PeerCollabEnumPeopleNearMe(void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerCollabAddContact(const(wchar)* pwzContactData, PEER_CONTACT** ppContact);

@DllImport("P2P")
HRESULT PeerCollabDeleteContact(const(wchar)* pwzPeerName);

@DllImport("P2P")
HRESULT PeerCollabGetContact(const(wchar)* pwzPeerName, PEER_CONTACT** ppContact);

@DllImport("P2P")
HRESULT PeerCollabUpdateContact(PEER_CONTACT* pContact);

@DllImport("P2P")
HRESULT PeerCollabEnumContacts(void** phPeerEnum);

@DllImport("P2P")
HRESULT PeerCollabExportContact(const(wchar)* pwzPeerName, ushort** ppwzContactData);

@DllImport("P2P")
HRESULT PeerCollabParseContact(const(wchar)* pwzContactData, PEER_CONTACT** ppContact);

@DllImport("P2P")
HRESULT PeerNameToPeerHostName(const(wchar)* pwzPeerName, ushort** ppwzHostName);

@DllImport("P2P")
HRESULT PeerHostNameToPeerName(const(wchar)* pwzHostName, ushort** ppwzPeerName);

@DllImport("P2P")
HRESULT PeerPnrpStartup(ushort wVersionRequested);

@DllImport("P2P")
HRESULT PeerPnrpShutdown();

@DllImport("P2P")
HRESULT PeerPnrpRegister(const(wchar)* pcwzPeerName, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo, 
                         void** phRegistration);

@DllImport("P2P")
HRESULT PeerPnrpUpdateRegistration(void* hRegistration, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo);

@DllImport("P2P")
HRESULT PeerPnrpUnregister(void* hRegistration);

@DllImport("P2P")
HRESULT PeerPnrpResolve(const(wchar)* pcwzPeerName, const(wchar)* pcwzCloudName, uint* pcEndpoints, 
                        PEER_PNRP_ENDPOINT_INFO** ppEndpoints);

@DllImport("P2P")
HRESULT PeerPnrpStartResolve(const(wchar)* pcwzPeerName, const(wchar)* pcwzCloudName, uint cMaxEndpoints, 
                             HANDLE hEvent, void** phResolve);

@DllImport("P2P")
HRESULT PeerPnrpGetCloudInfo(uint* pcNumClouds, PEER_PNRP_CLOUD_INFO** ppCloudInfo);

@DllImport("P2P")
HRESULT PeerPnrpGetEndpoint(void* hResolve, PEER_PNRP_ENDPOINT_INFO** ppEndpoint);

@DllImport("P2P")
HRESULT PeerPnrpEndResolve(void* hResolve);

@DllImport("drtprov")
HRESULT DrtCreatePnrpBootstrapResolver(BOOL fPublish, const(wchar)* pwzPeerName, const(wchar)* pwzCloudName, 
                                       const(wchar)* pwzPublishingIdentity, DRT_BOOTSTRAP_PROVIDER** ppResolver);

@DllImport("drtprov")
void DrtDeletePnrpBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

@DllImport("drtprov")
HRESULT DrtCreateDnsBootstrapResolver(ushort port, const(wchar)* pwszAddress, DRT_BOOTSTRAP_PROVIDER** ppModule);

@DllImport("drtprov")
void DrtDeleteDnsBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

@DllImport("drttransport")
HRESULT DrtCreateIpv6UdpTransport(DRT_SCOPE scope_, uint dwScopeId, uint dwLocalityThreshold, ushort* pwPort, 
                                  void** phTransport);

@DllImport("drttransport")
HRESULT DrtDeleteIpv6UdpTransport(void* hTransport);

@DllImport("drtprov")
HRESULT DrtCreateDerivedKeySecurityProvider(CERT_CONTEXT* pRootCert, CERT_CONTEXT* pLocalCert, 
                                            DRT_SECURITY_PROVIDER** ppSecurityProvider);

@DllImport("drtprov")
HRESULT DrtCreateDerivedKey(CERT_CONTEXT* pLocalCert, DRT_DATA* pKey);

@DllImport("drtprov")
void DrtDeleteDerivedKeySecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

@DllImport("drtprov")
HRESULT DrtCreateNullSecurityProvider(DRT_SECURITY_PROVIDER** ppSecurityProvider);

@DllImport("drtprov")
void DrtDeleteNullSecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

@DllImport("drt")
HRESULT DrtOpen(const(DRT_SETTINGS)* pSettings, HANDLE hEvent, const(void)* pvContext, void** phDrt);

@DllImport("drt")
void DrtClose(void* hDrt);

@DllImport("drt")
HRESULT DrtGetEventDataSize(void* hDrt, uint* pulEventDataLen);

@DllImport("drt")
HRESULT DrtGetEventData(void* hDrt, uint ulEventDataLen, char* pEventData);

@DllImport("drt")
HRESULT DrtRegisterKey(void* hDrt, DRT_REGISTRATION* pRegistration, void* pvKeyContext, void** phKeyRegistration);

@DllImport("drt")
HRESULT DrtUpdateKey(void* hKeyRegistration, DRT_DATA* pAppData);

@DllImport("drt")
void DrtUnregisterKey(void* hKeyRegistration);

@DllImport("drt")
HRESULT DrtStartSearch(void* hDrt, DRT_DATA* pKey, const(DRT_SEARCH_INFO)* pInfo, uint timeout, HANDLE hEvent, 
                       const(void)* pvContext, void** hSearchContext);

@DllImport("drt")
HRESULT DrtContinueSearch(void* hSearchContext);

@DllImport("drt")
HRESULT DrtGetSearchResultSize(void* hSearchContext, uint* pulSearchResultSize);

@DllImport("drt")
HRESULT DrtGetSearchResult(void* hSearchContext, uint ulSearchResultSize, char* pSearchResult);

@DllImport("drt")
HRESULT DrtGetSearchPathSize(void* hSearchContext, uint* pulSearchPathSize);

@DllImport("drt")
HRESULT DrtGetSearchPath(void* hSearchContext, uint ulSearchPathSize, char* pSearchPath);

@DllImport("drt")
HRESULT DrtEndSearch(void* hSearchContext);

@DllImport("drt")
HRESULT DrtGetInstanceName(void* hDrt, uint ulcbInstanceNameSize, const(wchar)* pwzDrtInstanceName);

@DllImport("drt")
HRESULT DrtGetInstanceNameSize(void* hDrt, uint* pulcbInstanceNameSize);

@DllImport("PeerDist")
uint PeerDistStartup(uint dwVersionRequested, ptrdiff_t* phPeerDist, uint* pdwSupportedVersion);

@DllImport("PeerDist")
uint PeerDistShutdown(ptrdiff_t hPeerDist);

@DllImport("PeerDist")
uint PeerDistGetStatus(ptrdiff_t hPeerDist, PEERDIST_STATUS* pPeerDistStatus);

@DllImport("PeerDist")
uint PeerDistRegisterForStatusChangeNotification(ptrdiff_t hPeerDist, HANDLE hCompletionPort, 
                                                 size_t ulCompletionKey, OVERLAPPED* lpOverlapped, 
                                                 PEERDIST_STATUS* pPeerDistStatus);

@DllImport("PeerDist")
uint PeerDistUnregisterForStatusChangeNotification(ptrdiff_t hPeerDist);

@DllImport("PeerDist")
uint PeerDistServerPublishStream(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, 
                                 ulong cbContentLength, PEERDIST_PUBLICATION_OPTIONS* pPublishOptions, 
                                 HANDLE hCompletionPort, size_t ulCompletionKey, ptrdiff_t* phStream);

@DllImport("PeerDist")
uint PeerDistServerPublishAddToStream(ptrdiff_t hPeerDist, ptrdiff_t hStream, uint cbNumberOfBytes, char* pBuffer, 
                                      OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistServerPublishCompleteStream(ptrdiff_t hPeerDist, ptrdiff_t hStream, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistServerCloseStreamHandle(ptrdiff_t hPeerDist, ptrdiff_t hStream);

@DllImport("PeerDist")
uint PeerDistServerUnpublish(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier);

@DllImport("PeerDist")
uint PeerDistServerOpenContentInformation(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, 
                                          ulong ullContentOffset, ulong cbContentLength, HANDLE hCompletionPort, 
                                          size_t ulCompletionKey, ptrdiff_t* phContentInfo);

@DllImport("PeerDist")
uint PeerDistServerRetrieveContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentInfo, uint cbMaxNumberOfBytes, 
                                              char* pBuffer, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistServerCloseContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentInfo);

@DllImport("PeerDist")
uint PeerDistServerCancelAsyncOperation(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, 
                                        OVERLAPPED* pOverlapped);

@DllImport("PeerDist")
uint PeerDistClientOpenContent(ptrdiff_t hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, 
                               size_t ulCompletionKey, ptrdiff_t* phContentHandle);

@DllImport("PeerDist")
uint PeerDistClientCloseContent(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle);

@DllImport("PeerDist")
uint PeerDistClientAddContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbNumberOfBytes, 
                                         char* pBuffer, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistClientCompleteContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, 
                                              OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistClientAddData(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbNumberOfBytes, char* pBuffer, 
                           OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistClientBlockRead(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbMaxNumberOfBytes, char* pBuffer, 
                             uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistClientStreamRead(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbMaxNumberOfBytes, 
                              char* pBuffer, uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistClientFlushContent(ptrdiff_t hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, 
                                size_t ulCompletionKey, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist")
uint PeerDistClientCancelAsyncOperation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, OVERLAPPED* pOverlapped);

@DllImport("PeerDist")
uint PeerDistGetStatusEx(ptrdiff_t hPeerDist, PEERDIST_STATUS_INFO* pPeerDistStatus);

@DllImport("PeerDist")
uint PeerDistRegisterForStatusChangeNotificationEx(ptrdiff_t hPeerDist, HANDLE hCompletionPort, 
                                                   size_t ulCompletionKey, OVERLAPPED* lpOverlapped, 
                                                   PEERDIST_STATUS_INFO* pPeerDistStatus);

@DllImport("PeerDist")
BOOL PeerDistGetOverlappedResult(OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

@DllImport("PeerDist")
uint PeerDistServerOpenContentInformationEx(ptrdiff_t hPeerDist, uint cbContentIdentifier, 
                                            char* pContentIdentifier, ulong ullContentOffset, ulong cbContentLength, 
                                            PEERDIST_RETRIEVAL_OPTIONS* pRetrievalOptions, HANDLE hCompletionPort, 
                                            size_t ulCompletionKey, ptrdiff_t* phContentInfo);

@DllImport("PeerDist")
uint PeerDistClientGetInformationByHandle(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, 
                                          PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS PeerDistClientInfoClass, 
                                          uint dwBufferSize, char* lpInformation);


