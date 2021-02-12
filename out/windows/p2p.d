module windows.p2p;

public import system;
public import windows.com;
public import windows.networkdrivers;
public import windows.security;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

enum PNRP_SCOPE
{
    PNRP_SCOPE_ANY = 0,
    PNRP_GLOBAL_SCOPE = 1,
    PNRP_SITE_LOCAL_SCOPE = 2,
    PNRP_LINK_LOCAL_SCOPE = 3,
}

enum PNRP_CLOUD_STATE
{
    PNRP_CLOUD_STATE_VIRTUAL = 0,
    PNRP_CLOUD_STATE_SYNCHRONISING = 1,
    PNRP_CLOUD_STATE_ACTIVE = 2,
    PNRP_CLOUD_STATE_DEAD = 3,
    PNRP_CLOUD_STATE_DISABLED = 4,
    PNRP_CLOUD_STATE_NO_NET = 5,
    PNRP_CLOUD_STATE_ALONE = 6,
}

enum PNRP_CLOUD_FLAGS
{
    PNRP_CLOUD_NO_FLAGS = 0,
    PNRP_CLOUD_NAME_LOCAL = 1,
    PNRP_CLOUD_RESOLVE_ONLY = 2,
    PNRP_CLOUD_FULL_PARTICIPANT = 4,
}

enum PNRP_REGISTERED_ID_STATE
{
    PNRP_REGISTERED_ID_STATE_OK = 1,
    PNRP_REGISTERED_ID_STATE_PROBLEM = 2,
}

enum PNRP_RESOLVE_CRITERIA
{
    PNRP_RESOLVE_CRITERIA_DEFAULT = 0,
    PNRP_RESOLVE_CRITERIA_REMOTE_PEER_NAME = 1,
    PNRP_RESOLVE_CRITERIA_NEAREST_REMOTE_PEER_NAME = 2,
    PNRP_RESOLVE_CRITERIA_NON_CURRENT_PROCESS_PEER_NAME = 3,
    PNRP_RESOLVE_CRITERIA_NEAREST_NON_CURRENT_PROCESS_PEER_NAME = 4,
    PNRP_RESOLVE_CRITERIA_ANY_PEER_NAME = 5,
    PNRP_RESOLVE_CRITERIA_NEAREST_PEER_NAME = 6,
}

struct PNRP_CLOUD_ID
{
    int AddressFamily;
    PNRP_SCOPE Scope;
    uint ScopeId;
}

enum PNRP_EXTENDED_PAYLOAD_TYPE
{
    PNRP_EXTENDED_PAYLOAD_TYPE_NONE = 0,
    PNRP_EXTENDED_PAYLOAD_TYPE_BINARY = 1,
    PNRP_EXTENDED_PAYLOAD_TYPE_STRING = 2,
}

struct PNRPINFO_V1
{
    uint dwSize;
    const(wchar)* lpwszIdentity;
    uint nMaxResolve;
    uint dwTimeout;
    uint dwLifetime;
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    uint dwFlags;
    SOCKET_ADDRESS saHint;
    PNRP_REGISTERED_ID_STATE enNameState;
}

struct PNRPINFO_V2
{
    uint dwSize;
    const(wchar)* lpwszIdentity;
    uint nMaxResolve;
    uint dwTimeout;
    uint dwLifetime;
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    uint dwFlags;
    SOCKET_ADDRESS saHint;
    PNRP_REGISTERED_ID_STATE enNameState;
    PNRP_EXTENDED_PAYLOAD_TYPE enExtendedPayloadType;
    _Anonymous_e__Union Anonymous;
}

struct PNRPCLOUDINFO
{
    uint dwSize;
    PNRP_CLOUD_ID Cloud;
    PNRP_CLOUD_STATE enCloudState;
    PNRP_CLOUD_FLAGS enCloudFlags;
}

enum PEER_RECORD_CHANGE_TYPE
{
    PEER_RECORD_ADDED = 1,
    PEER_RECORD_UPDATED = 2,
    PEER_RECORD_DELETED = 3,
    PEER_RECORD_EXPIRED = 4,
}

enum PEER_CONNECTION_STATUS
{
    PEER_CONNECTED = 1,
    PEER_DISCONNECTED = 2,
    PEER_CONNECTION_FAILED = 3,
}

enum PEER_CONNECTION_FLAGS
{
    PEER_CONNECTION_NEIGHBOR = 1,
    PEER_CONNECTION_DIRECT = 2,
}

enum PEER_RECORD_FLAGS
{
    PEER_RECORD_FLAG_AUTOREFRESH = 1,
    PEER_RECORD_FLAG_DELETED = 2,
}

struct PEER_VERSION_DATA
{
    ushort wVersion;
    ushort wHighestVersion;
}

struct PEER_DATA
{
    uint cbData;
    ubyte* pbData;
}

struct PEER_RECORD
{
    uint dwSize;
    Guid type;
    Guid id;
    uint dwVersion;
    uint dwFlags;
    const(wchar)* pwzCreatorId;
    const(wchar)* pwzModifiedById;
    const(wchar)* pwzAttributes;
    FILETIME ftCreation;
    FILETIME ftExpiration;
    FILETIME ftLastModified;
    PEER_DATA securityData;
    PEER_DATA data;
}

struct PEER_ADDRESS
{
    uint dwSize;
    SOCKADDR_IN6_LH sin6;
}

struct PEER_CONNECTION_INFO
{
    uint dwSize;
    uint dwFlags;
    ulong ullConnectionId;
    ulong ullNodeId;
    const(wchar)* pwzPeerId;
    PEER_ADDRESS address;
}

struct PEER_EVENT_INCOMING_DATA
{
    uint dwSize;
    ulong ullConnectionId;
    Guid type;
    PEER_DATA data;
}

struct PEER_EVENT_RECORD_CHANGE_DATA
{
    uint dwSize;
    PEER_RECORD_CHANGE_TYPE changeType;
    Guid recordId;
    Guid recordType;
}

struct PEER_EVENT_CONNECTION_CHANGE_DATA
{
    uint dwSize;
    PEER_CONNECTION_STATUS status;
    ulong ullConnectionId;
    ulong ullNodeId;
    ulong ullNextConnectionId;
    HRESULT hrConnectionFailedReason;
}

struct PEER_EVENT_SYNCHRONIZED_DATA
{
    uint dwSize;
    Guid recordType;
}

enum PEER_GRAPH_EVENT_TYPE
{
    PEER_GRAPH_EVENT_STATUS_CHANGED = 1,
    PEER_GRAPH_EVENT_PROPERTY_CHANGED = 2,
    PEER_GRAPH_EVENT_RECORD_CHANGED = 3,
    PEER_GRAPH_EVENT_DIRECT_CONNECTION = 4,
    PEER_GRAPH_EVENT_NEIGHBOR_CONNECTION = 5,
    PEER_GRAPH_EVENT_INCOMING_DATA = 6,
    PEER_GRAPH_EVENT_CONNECTION_REQUIRED = 7,
    PEER_GRAPH_EVENT_NODE_CHANGED = 8,
    PEER_GRAPH_EVENT_SYNCHRONIZED = 9,
}

enum PEER_NODE_CHANGE_TYPE
{
    PEER_NODE_CHANGE_CONNECTED = 1,
    PEER_NODE_CHANGE_DISCONNECTED = 2,
    PEER_NODE_CHANGE_UPDATED = 3,
}

enum PEER_GRAPH_STATUS_FLAGS
{
    PEER_GRAPH_STATUS_LISTENING = 1,
    PEER_GRAPH_STATUS_HAS_CONNECTIONS = 2,
    PEER_GRAPH_STATUS_SYNCHRONIZED = 4,
}

enum PEER_GRAPH_PROPERTY_FLAGS
{
    PEER_GRAPH_PROPERTY_HEARTBEATS = 1,
    PEER_GRAPH_PROPERTY_DEFER_EXPIRATION = 2,
}

enum PEER_GRAPH_SCOPE
{
    PEER_GRAPH_SCOPE_ANY = 0,
    PEER_GRAPH_SCOPE_GLOBAL = 1,
    PEER_GRAPH_SCOPE_SITELOCAL = 2,
    PEER_GRAPH_SCOPE_LINKLOCAL = 3,
    PEER_GRAPH_SCOPE_LOOPBACK = 4,
}

struct PEER_GRAPH_PROPERTIES
{
    uint dwSize;
    uint dwFlags;
    uint dwScope;
    uint dwMaxRecordSize;
    const(wchar)* pwzGraphId;
    const(wchar)* pwzCreatorId;
    const(wchar)* pwzFriendlyName;
    const(wchar)* pwzComment;
    uint ulPresenceLifetime;
    uint cPresenceMax;
}

struct PEER_NODE_INFO
{
    uint dwSize;
    ulong ullNodeId;
    const(wchar)* pwzPeerId;
    uint cAddresses;
    PEER_ADDRESS* pAddresses;
    const(wchar)* pwzAttributes;
}

struct PEER_EVENT_NODE_CHANGE_DATA
{
    uint dwSize;
    PEER_NODE_CHANGE_TYPE changeType;
    ulong ullNodeId;
    const(wchar)* pwzPeerId;
}

struct PEER_GRAPH_EVENT_REGISTRATION
{
    PEER_GRAPH_EVENT_TYPE eventType;
    Guid* pType;
}

struct PEER_GRAPH_EVENT_DATA
{
    PEER_GRAPH_EVENT_TYPE eventType;
    _Anonymous_e__Union Anonymous;
}

alias PFNPEER_VALIDATE_RECORD = extern(Windows) HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, PEER_RECORD_CHANGE_TYPE changeType);
alias PFNPEER_SECURE_RECORD = extern(Windows) HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, PEER_RECORD_CHANGE_TYPE changeType, PEER_DATA** ppSecurityData);
alias PFNPEER_FREE_SECURITY_DATA = extern(Windows) HRESULT function(void* hGraph, void* pvContext, PEER_DATA* pSecurityData);
alias PFNPEER_ON_PASSWORD_AUTH_FAILED = extern(Windows) HRESULT function(void* hGraph, void* pvContext);
struct PEER_SECURITY_INTERFACE
{
    uint dwSize;
    const(wchar)* pwzSspFilename;
    const(wchar)* pwzPackageName;
    uint cbSecurityInfo;
    ubyte* pbSecurityInfo;
    void* pvContext;
    PFNPEER_VALIDATE_RECORD pfnValidateRecord;
    PFNPEER_SECURE_RECORD pfnSecureRecord;
    PFNPEER_FREE_SECURITY_DATA pfnFreeSecurityData;
    PFNPEER_ON_PASSWORD_AUTH_FAILED pfnAuthFailed;
}

enum PEER_GROUP_EVENT_TYPE
{
    PEER_GROUP_EVENT_STATUS_CHANGED = 1,
    PEER_GROUP_EVENT_PROPERTY_CHANGED = 2,
    PEER_GROUP_EVENT_RECORD_CHANGED = 3,
    PEER_GROUP_EVENT_DIRECT_CONNECTION = 4,
    PEER_GROUP_EVENT_NEIGHBOR_CONNECTION = 5,
    PEER_GROUP_EVENT_INCOMING_DATA = 6,
    PEER_GROUP_EVENT_MEMBER_CHANGED = 8,
    PEER_GROUP_EVENT_CONNECTION_FAILED = 10,
    PEER_GROUP_EVENT_AUTHENTICATION_FAILED = 11,
}

enum PEER_GROUP_STATUS
{
    PEER_GROUP_STATUS_LISTENING = 1,
    PEER_GROUP_STATUS_HAS_CONNECTIONS = 2,
}

enum PEER_GROUP_PROPERTY_FLAGS
{
    PEER_MEMBER_DATA_OPTIONAL = 1,
    PEER_DISABLE_PRESENCE = 2,
    PEER_DEFER_EXPIRATION = 4,
}

enum PEER_GROUP_AUTHENTICATION_SCHEME
{
    PEER_GROUP_GMC_AUTHENTICATION = 1,
    PEER_GROUP_PASSWORD_AUTHENTICATION = 2,
}

enum PEER_MEMBER_FLAGS
{
    PEER_MEMBER_PRESENT = 1,
}

enum PEER_MEMBER_CHANGE_TYPE
{
    PEER_MEMBER_CONNECTED = 1,
    PEER_MEMBER_DISCONNECTED = 2,
    PEER_MEMBER_UPDATED = 3,
    PEER_MEMBER_JOINED = 4,
    PEER_MEMBER_LEFT = 5,
}

enum PEER_GROUP_ISSUE_CREDENTIAL_FLAGS
{
    PEER_GROUP_STORE_CREDENTIALS = 1,
}

struct PEER_CREDENTIAL_INFO
{
    uint dwSize;
    uint dwFlags;
    const(wchar)* pwzFriendlyName;
    CERT_PUBLIC_KEY_INFO* pPublicKey;
    const(wchar)* pwzIssuerPeerName;
    const(wchar)* pwzIssuerFriendlyName;
    FILETIME ftValidityStart;
    FILETIME ftValidityEnd;
    uint cRoles;
    Guid* pRoles;
}

struct PEER_MEMBER
{
    uint dwSize;
    uint dwFlags;
    const(wchar)* pwzIdentity;
    const(wchar)* pwzAttributes;
    ulong ullNodeId;
    uint cAddresses;
    PEER_ADDRESS* pAddresses;
    PEER_CREDENTIAL_INFO* pCredentialInfo;
}

struct PEER_INVITATION_INFO
{
    uint dwSize;
    uint dwFlags;
    const(wchar)* pwzCloudName;
    uint dwScope;
    uint dwCloudFlags;
    const(wchar)* pwzGroupPeerName;
    const(wchar)* pwzIssuerPeerName;
    const(wchar)* pwzSubjectPeerName;
    const(wchar)* pwzGroupFriendlyName;
    const(wchar)* pwzIssuerFriendlyName;
    const(wchar)* pwzSubjectFriendlyName;
    FILETIME ftValidityStart;
    FILETIME ftValidityEnd;
    uint cRoles;
    Guid* pRoles;
    uint cClassifiers;
    ushort** ppwzClassifiers;
    CERT_PUBLIC_KEY_INFO* pSubjectPublicKey;
    PEER_GROUP_AUTHENTICATION_SCHEME authScheme;
}

struct PEER_GROUP_PROPERTIES
{
    uint dwSize;
    uint dwFlags;
    const(wchar)* pwzCloud;
    const(wchar)* pwzClassifier;
    const(wchar)* pwzGroupPeerName;
    const(wchar)* pwzCreatorPeerName;
    const(wchar)* pwzFriendlyName;
    const(wchar)* pwzComment;
    uint ulMemberDataLifetime;
    uint ulPresenceLifetime;
    uint dwAuthenticationSchemes;
    const(wchar)* pwzGroupPassword;
    Guid groupPasswordRole;
}

struct PEER_EVENT_MEMBER_CHANGE_DATA
{
    uint dwSize;
    PEER_MEMBER_CHANGE_TYPE changeType;
    const(wchar)* pwzIdentity;
}

struct PEER_GROUP_EVENT_REGISTRATION
{
    PEER_GROUP_EVENT_TYPE eventType;
    Guid* pType;
}

struct PEER_GROUP_EVENT_DATA
{
    PEER_GROUP_EVENT_TYPE eventType;
    _Anonymous_e__Union Anonymous;
}

struct PEER_NAME_PAIR
{
    uint dwSize;
    const(wchar)* pwzPeerName;
    const(wchar)* pwzFriendlyName;
}

enum PEER_SIGNIN_FLAGS
{
    PEER_SIGNIN_NONE = 0,
    PEER_SIGNIN_NEAR_ME = 1,
    PEER_SIGNIN_INTERNET = 2,
    PEER_SIGNIN_ALL = 3,
}

enum PEER_WATCH_PERMISSION
{
    PEER_WATCH_BLOCKED = 0,
    PEER_WATCH_ALLOWED = 1,
}

enum PEER_PUBLICATION_SCOPE
{
    PEER_PUBLICATION_SCOPE_NONE = 0,
    PEER_PUBLICATION_SCOPE_NEAR_ME = 1,
    PEER_PUBLICATION_SCOPE_INTERNET = 2,
    PEER_PUBLICATION_SCOPE_ALL = 3,
}

struct PEER_APPLICATION
{
    Guid id;
    PEER_DATA data;
    const(wchar)* pwzDescription;
}

struct PEER_OBJECT
{
    Guid id;
    PEER_DATA data;
    uint dwPublicationScope;
}

struct PEER_CONTACT
{
    const(wchar)* pwzPeerName;
    const(wchar)* pwzNickName;
    const(wchar)* pwzDisplayName;
    const(wchar)* pwzEmailAddress;
    BOOL fWatch;
    PEER_WATCH_PERMISSION WatcherPermissions;
    PEER_DATA credentials;
}

struct PEER_ENDPOINT
{
    PEER_ADDRESS address;
    const(wchar)* pwzEndpointName;
}

struct PEER_PEOPLE_NEAR_ME
{
    const(wchar)* pwzNickName;
    PEER_ENDPOINT endpoint;
    Guid id;
}

enum PEER_INVITATION_RESPONSE_TYPE
{
    PEER_INVITATION_RESPONSE_DECLINED = 0,
    PEER_INVITATION_RESPONSE_ACCEPTED = 1,
    PEER_INVITATION_RESPONSE_EXPIRED = 2,
    PEER_INVITATION_RESPONSE_ERROR = 3,
}

enum PEER_APPLICATION_REGISTRATION_TYPE
{
    PEER_APPLICATION_CURRENT_USER = 0,
    PEER_APPLICATION_ALL_USERS = 1,
}

struct PEER_INVITATION
{
    Guid applicationId;
    PEER_DATA applicationData;
    const(wchar)* pwzMessage;
}

struct PEER_INVITATION_RESPONSE
{
    PEER_INVITATION_RESPONSE_TYPE action;
    const(wchar)* pwzMessage;
    HRESULT hrExtendedInfo;
}

struct PEER_APP_LAUNCH_INFO
{
    PEER_CONTACT* pContact;
    PEER_ENDPOINT* pEndpoint;
    PEER_INVITATION* pInvitation;
}

struct PEER_APPLICATION_REGISTRATION_INFO
{
    PEER_APPLICATION application;
    const(wchar)* pwzApplicationToLaunch;
    const(wchar)* pwzApplicationArguments;
    uint dwPublicationScope;
}

enum PEER_PRESENCE_STATUS
{
    PEER_PRESENCE_OFFLINE = 0,
    PEER_PRESENCE_OUT_TO_LUNCH = 1,
    PEER_PRESENCE_AWAY = 2,
    PEER_PRESENCE_BE_RIGHT_BACK = 3,
    PEER_PRESENCE_IDLE = 4,
    PEER_PRESENCE_BUSY = 5,
    PEER_PRESENCE_ON_THE_PHONE = 6,
    PEER_PRESENCE_ONLINE = 7,
}

struct PEER_PRESENCE_INFO
{
    PEER_PRESENCE_STATUS status;
    const(wchar)* pwzDescriptiveText;
}

enum PEER_CHANGE_TYPE
{
    PEER_CHANGE_ADDED = 0,
    PEER_CHANGE_DELETED = 1,
    PEER_CHANGE_UPDATED = 2,
}

enum PEER_COLLAB_EVENT_TYPE
{
    PEER_EVENT_WATCHLIST_CHANGED = 1,
    PEER_EVENT_ENDPOINT_CHANGED = 2,
    PEER_EVENT_ENDPOINT_PRESENCE_CHANGED = 3,
    PEER_EVENT_ENDPOINT_APPLICATION_CHANGED = 4,
    PEER_EVENT_ENDPOINT_OBJECT_CHANGED = 5,
    PEER_EVENT_MY_ENDPOINT_CHANGED = 6,
    PEER_EVENT_MY_PRESENCE_CHANGED = 7,
    PEER_EVENT_MY_APPLICATION_CHANGED = 8,
    PEER_EVENT_MY_OBJECT_CHANGED = 9,
    PEER_EVENT_PEOPLE_NEAR_ME_CHANGED = 10,
    PEER_EVENT_REQUEST_STATUS_CHANGED = 11,
}

struct PEER_COLLAB_EVENT_REGISTRATION
{
    PEER_COLLAB_EVENT_TYPE eventType;
    Guid* pInstance;
}

struct PEER_EVENT_WATCHLIST_CHANGED_DATA
{
    PEER_CONTACT* pContact;
    PEER_CHANGE_TYPE changeType;
}

struct PEER_EVENT_PRESENCE_CHANGED_DATA
{
    PEER_CONTACT* pContact;
    PEER_ENDPOINT* pEndpoint;
    PEER_CHANGE_TYPE changeType;
    PEER_PRESENCE_INFO* pPresenceInfo;
}

struct PEER_EVENT_APPLICATION_CHANGED_DATA
{
    PEER_CONTACT* pContact;
    PEER_ENDPOINT* pEndpoint;
    PEER_CHANGE_TYPE changeType;
    PEER_APPLICATION* pApplication;
}

struct PEER_EVENT_OBJECT_CHANGED_DATA
{
    PEER_CONTACT* pContact;
    PEER_ENDPOINT* pEndpoint;
    PEER_CHANGE_TYPE changeType;
    PEER_OBJECT* pObject;
}

struct PEER_EVENT_ENDPOINT_CHANGED_DATA
{
    PEER_CONTACT* pContact;
    PEER_ENDPOINT* pEndpoint;
}

struct PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA
{
    PEER_CHANGE_TYPE changeType;
    PEER_PEOPLE_NEAR_ME* pPeopleNearMe;
}

struct PEER_EVENT_REQUEST_STATUS_CHANGED_DATA
{
    PEER_ENDPOINT* pEndpoint;
    HRESULT hrChange;
}

struct PEER_COLLAB_EVENT_DATA
{
    PEER_COLLAB_EVENT_TYPE eventType;
    _Anonymous_e__Union Anonymous;
}

struct PEER_PNRP_ENDPOINT_INFO
{
    const(wchar)* pwzPeerName;
    uint cAddresses;
    SOCKADDR** ppAddresses;
    const(wchar)* pwzComment;
    PEER_DATA payload;
}

struct PEER_PNRP_CLOUD_INFO
{
    const(wchar)* pwzCloudName;
    PNRP_SCOPE dwScope;
    uint dwScopeId;
}

struct PEER_PNRP_REGISTRATION_INFO
{
    const(wchar)* pwzCloudName;
    const(wchar)* pwzPublishingIdentity;
    uint cAddresses;
    SOCKADDR** ppAddresses;
    ushort wPort;
    const(wchar)* pwzComment;
    PEER_DATA payload;
}

enum DRT_SCOPE
{
    DRT_GLOBAL_SCOPE = 1,
    DRT_SITE_LOCAL_SCOPE = 2,
    DRT_LINK_LOCAL_SCOPE = 3,
}

enum DRT_STATUS
{
    DRT_ACTIVE = 0,
    DRT_ALONE = 1,
    DRT_NO_NETWORK = 10,
    DRT_FAULTED = 20,
}

enum DRT_MATCH_TYPE
{
    DRT_MATCH_EXACT = 0,
    DRT_MATCH_NEAR = 1,
    DRT_MATCH_INTERMEDIATE = 2,
}

enum DRT_LEAFSET_KEY_CHANGE_TYPE
{
    DRT_LEAFSET_KEY_ADDED = 0,
    DRT_LEAFSET_KEY_DELETED = 1,
}

enum DRT_EVENT_TYPE
{
    DRT_EVENT_STATUS_CHANGED = 0,
    DRT_EVENT_LEAFSET_KEY_CHANGED = 1,
    DRT_EVENT_REGISTRATION_STATE_CHANGED = 2,
}

enum DRT_SECURITY_MODE
{
    DRT_SECURE_RESOLVE = 0,
    DRT_SECURE_MEMBERSHIP = 1,
    DRT_SECURE_CONFIDENTIALPAYLOAD = 2,
}

enum DRT_REGISTRATION_STATE
{
    DRT_REGISTRATION_STATE_UNRESOLVEABLE = 1,
}

enum DRT_ADDRESS_FLAGS
{
    DRT_ADDRESS_FLAG_ACCEPTED = 1,
    DRT_ADDRESS_FLAG_REJECTED = 2,
    DRT_ADDRESS_FLAG_UNREACHABLE = 4,
    DRT_ADDRESS_FLAG_LOOP = 8,
    DRT_ADDRESS_FLAG_TOO_BUSY = 16,
    DRT_ADDRESS_FLAG_BAD_VALIDATE_ID = 32,
    DRT_ADDRESS_FLAG_SUSPECT_UNREGISTERED_ID = 64,
    DRT_ADDRESS_FLAG_INQUIRE = 128,
}

struct DRT_DATA
{
    uint cb;
    ubyte* pb;
}

struct DRT_REGISTRATION
{
    DRT_DATA key;
    DRT_DATA appData;
}

struct DRT_SECURITY_PROVIDER
{
    void* pvContext;
    HRESULT********* Attach;
    int Detach;
    HRESULT********* RegisterKey;
    HRESULT********* UnregisterKey;
    HRESULT********* ValidateAndUnpackPayload;
    HRESULT********* SecureAndPackPayload;
    int FreeData;
    HRESULT********* EncryptData;
    HRESULT********* DecryptData;
    HRESULT********* GetSerializedCredential;
    HRESULT********* ValidateRemoteCredential;
    HRESULT********* SignData;
    HRESULT********* VerifyData;
}

alias DRT_BOOTSTRAP_RESOLVE_CALLBACK = extern(Windows) void function(HRESULT hr, void* pvContext, SOCKET_ADDRESS_LIST* pAddresses, BOOL fFatalError);
struct DRT_BOOTSTRAP_PROVIDER
{
    void* pvContext;
    HRESULT********* Attach;
    int Detach;
    HRESULT********* InitResolve;
    HRESULT********* IssueResolve;
    int EndResolve;
    HRESULT********* Register;
    int Unregister;
}

struct DRT_SETTINGS
{
    uint dwSize;
    uint cbKey;
    ubyte bProtocolMajorVersion;
    ubyte bProtocolMinorVersion;
    uint ulMaxRoutingAddresses;
    const(wchar)* pwzDrtInstancePrefix;
    void* hTransport;
    DRT_SECURITY_PROVIDER* pSecurityProvider;
    DRT_BOOTSTRAP_PROVIDER* pBootstrapProvider;
    DRT_SECURITY_MODE eSecurityMode;
}

struct DRT_SEARCH_INFO
{
    uint dwSize;
    BOOL fIterative;
    BOOL fAllowCurrentInstanceMatch;
    BOOL fAnyMatchInRange;
    uint cMaxEndpoints;
    DRT_DATA* pMaximumKey;
    DRT_DATA* pMinimumKey;
}

struct DRT_ADDRESS
{
    SOCKADDR_STORAGE_LH socketAddress;
    uint flags;
    int nearness;
    uint latency;
}

struct DRT_ADDRESS_LIST
{
    uint AddressCount;
    DRT_ADDRESS AddressList;
}

struct DRT_SEARCH_RESULT
{
    uint dwSize;
    DRT_MATCH_TYPE type;
    void* pvContext;
    DRT_REGISTRATION registration;
}

struct DRT_EVENT_DATA
{
    DRT_EVENT_TYPE type;
    HRESULT hr;
    void* pvContext;
    _Anonymous_e__Union Anonymous;
}

enum PEERDIST_STATUS
{
    PEERDIST_STATUS_DISABLED = 0,
    PEERDIST_STATUS_UNAVAILABLE = 1,
    PEERDIST_STATUS_AVAILABLE = 2,
}

struct PEERDIST_PUBLICATION_OPTIONS
{
    uint dwVersion;
    uint dwFlags;
}

struct PEERDIST_CONTENT_TAG
{
    ubyte Data;
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
    uint cbSize;
    PEERDIST_STATUS status;
    uint dwMinVer;
    uint dwMaxVer;
}

enum PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS
{
    PeerDistClientBasicInfo = 0,
    MaximumPeerDistClientInfoByHandlesClass = 1,
}

struct PEERDIST_CLIENT_BASIC_INFO
{
    BOOL fFlashCrowd;
}

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphShutdown();

@DllImport("P2PGRAPH.dll")
void PeerGraphFreeData(void* pvData);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetItemCount(void* hPeerEnum, uint* pCount);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEndEnumeration(void* hPeerEnum);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphCreate(PEER_GRAPH_PROPERTIES* pGraphProperties, const(wchar)* pwzDatabaseName, PEER_SECURITY_INTERFACE* pSecurityInterface, void** phGraph);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphOpen(const(wchar)* pwzGraphId, const(wchar)* pwzPeerId, const(wchar)* pwzDatabaseName, PEER_SECURITY_INTERFACE* pSecurityInterface, uint cRecordTypeSyncPrecedence, char* pRecordTypeSyncPrecedence, void** phGraph);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphListen(void* hGraph, uint dwScope, uint dwScopeId, ushort wPort);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphConnect(void* hGraph, const(wchar)* pwzPeerId, PEER_ADDRESS* pAddress, ulong* pullConnectionId);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphClose(void* hGraph);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphDelete(const(wchar)* pwzGraphId, const(wchar)* pwzPeerId, const(wchar)* pwzDatabaseName);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetStatus(void* hGraph, uint* pdwStatus);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetProperties(void* hGraph, PEER_GRAPH_PROPERTIES** ppGraphProperties);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSetProperties(void* hGraph, PEER_GRAPH_PROPERTIES* pGraphProperties);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphRegisterEvent(void* hGraph, HANDLE hEvent, uint cEventRegistrations, char* pEventRegistrations, void** phPeerEvent);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphUnregisterEvent(void* hPeerEvent);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetEventData(void* hPeerEvent, PEER_GRAPH_EVENT_DATA** ppEventData);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetRecord(void* hGraph, const(Guid)* pRecordId, PEER_RECORD** ppRecord);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphAddRecord(void* hGraph, PEER_RECORD* pRecord, Guid* pRecordId);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphUpdateRecord(void* hGraph, PEER_RECORD* pRecord);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphDeleteRecord(void* hGraph, const(Guid)* pRecordId, BOOL fLocal);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEnumRecords(void* hGraph, const(Guid)* pRecordType, const(wchar)* pwzPeerId, void** phPeerEnum);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSearchRecords(void* hGraph, const(wchar)* pwzCriteria, void** phPeerEnum);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphExportDatabase(void* hGraph, const(wchar)* pwzFilePath);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphImportDatabase(void* hGraph, const(wchar)* pwzFilePath);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphValidateDeferredRecords(void* hGraph, uint cRecordIds, char* pRecordIds);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphOpenDirectConnection(void* hGraph, const(wchar)* pwzPeerId, PEER_ADDRESS* pAddress, ulong* pullConnectionId);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSendData(void* hGraph, ulong ullConnectionId, const(Guid)* pType, uint cbData, char* pvData);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphCloseDirectConnection(void* hGraph, ulong ullConnectionId);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEnumConnections(void* hGraph, uint dwFlags, void** phPeerEnum);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEnumNodes(void* hGraph, const(wchar)* pwzPeerId, void** phPeerEnum);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSetPresence(void* hGraph, BOOL fPresent);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetNodeInfo(void* hGraph, ulong ullNodeId, PEER_NODE_INFO** ppNodeInfo);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSetNodeAttributes(void* hGraph, const(wchar)* pwzAttributes);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphPeerTimeToUniversalTime(void* hGraph, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphUniversalTimeToPeerTime(void* hGraph, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

@DllImport("P2P.dll")
void PeerFreeData(void* pvData);

@DllImport("P2P.dll")
HRESULT PeerGetItemCount(void* hPeerEnum, uint* pCount);

@DllImport("P2P.dll")
HRESULT PeerGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

@DllImport("P2P.dll")
HRESULT PeerEndEnumeration(void* hPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerGroupStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

@DllImport("P2P.dll")
HRESULT PeerGroupShutdown();

@DllImport("P2P.dll")
HRESULT PeerGroupCreate(PEER_GROUP_PROPERTIES* pProperties, void** phGroup);

@DllImport("P2P.dll")
HRESULT PeerGroupOpen(const(wchar)* pwzIdentity, const(wchar)* pwzGroupPeerName, const(wchar)* pwzCloud, void** phGroup);

@DllImport("P2P.dll")
HRESULT PeerGroupJoin(const(wchar)* pwzIdentity, const(wchar)* pwzInvitation, const(wchar)* pwzCloud, void** phGroup);

@DllImport("P2P.dll")
HRESULT PeerGroupPasswordJoin(const(wchar)* pwzIdentity, const(wchar)* pwzInvitation, const(wchar)* pwzPassword, const(wchar)* pwzCloud, void** phGroup);

@DllImport("P2P.dll")
HRESULT PeerGroupConnect(void* hGroup);

@DllImport("P2P.dll")
HRESULT PeerGroupConnectByAddress(void* hGroup, uint cAddresses, char* pAddresses);

@DllImport("P2P.dll")
HRESULT PeerGroupClose(void* hGroup);

@DllImport("P2P.dll")
HRESULT PeerGroupDelete(const(wchar)* pwzIdentity, const(wchar)* pwzGroupPeerName);

@DllImport("P2P.dll")
HRESULT PeerGroupCreateInvitation(void* hGroup, const(wchar)* pwzIdentityInfo, FILETIME* pftExpiration, uint cRoles, char* pRoles, ushort** ppwzInvitation);

@DllImport("P2P.dll")
HRESULT PeerGroupCreatePasswordInvitation(void* hGroup, ushort** ppwzInvitation);

@DllImport("P2P.dll")
HRESULT PeerGroupParseInvitation(const(wchar)* pwzInvitation, PEER_INVITATION_INFO** ppInvitationInfo);

@DllImport("P2P.dll")
HRESULT PeerGroupGetStatus(void* hGroup, uint* pdwStatus);

@DllImport("P2P.dll")
HRESULT PeerGroupGetProperties(void* hGroup, PEER_GROUP_PROPERTIES** ppProperties);

@DllImport("P2P.dll")
HRESULT PeerGroupSetProperties(void* hGroup, PEER_GROUP_PROPERTIES* pProperties);

@DllImport("P2P.dll")
HRESULT PeerGroupEnumMembers(void* hGroup, uint dwFlags, const(wchar)* pwzIdentity, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerGroupOpenDirectConnection(void* hGroup, const(wchar)* pwzIdentity, PEER_ADDRESS* pAddress, ulong* pullConnectionId);

@DllImport("P2P.dll")
HRESULT PeerGroupCloseDirectConnection(void* hGroup, ulong ullConnectionId);

@DllImport("P2P.dll")
HRESULT PeerGroupEnumConnections(void* hGroup, uint dwFlags, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerGroupSendData(void* hGroup, ulong ullConnectionId, const(Guid)* pType, uint cbData, char* pvData);

@DllImport("P2P.dll")
HRESULT PeerGroupRegisterEvent(void* hGroup, HANDLE hEvent, uint cEventRegistration, char* pEventRegistrations, void** phPeerEvent);

@DllImport("P2P.dll")
HRESULT PeerGroupUnregisterEvent(void* hPeerEvent);

@DllImport("P2P.dll")
HRESULT PeerGroupGetEventData(void* hPeerEvent, PEER_GROUP_EVENT_DATA** ppEventData);

@DllImport("P2P.dll")
HRESULT PeerGroupGetRecord(void* hGroup, const(Guid)* pRecordId, PEER_RECORD** ppRecord);

@DllImport("P2P.dll")
HRESULT PeerGroupAddRecord(void* hGroup, PEER_RECORD* pRecord, Guid* pRecordId);

@DllImport("P2P.dll")
HRESULT PeerGroupUpdateRecord(void* hGroup, PEER_RECORD* pRecord);

@DllImport("P2P.dll")
HRESULT PeerGroupDeleteRecord(void* hGroup, const(Guid)* pRecordId);

@DllImport("P2P.dll")
HRESULT PeerGroupEnumRecords(void* hGroup, const(Guid)* pRecordType, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerGroupSearchRecords(void* hGroup, const(wchar)* pwzCriteria, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerGroupExportDatabase(void* hGroup, const(wchar)* pwzFilePath);

@DllImport("P2P.dll")
HRESULT PeerGroupImportDatabase(void* hGroup, const(wchar)* pwzFilePath);

@DllImport("P2P.dll")
HRESULT PeerGroupIssueCredentials(void* hGroup, const(wchar)* pwzSubjectIdentity, PEER_CREDENTIAL_INFO* pCredentialInfo, uint dwFlags, ushort** ppwzInvitation);

@DllImport("P2P.dll")
HRESULT PeerGroupExportConfig(void* hGroup, const(wchar)* pwzPassword, ushort** ppwzXML);

@DllImport("P2P.dll")
HRESULT PeerGroupImportConfig(const(wchar)* pwzXML, const(wchar)* pwzPassword, BOOL fOverwrite, ushort** ppwzIdentity, ushort** ppwzGroup);

@DllImport("P2P.dll")
HRESULT PeerGroupPeerTimeToUniversalTime(void* hGroup, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

@DllImport("P2P.dll")
HRESULT PeerGroupUniversalTimeToPeerTime(void* hGroup, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

@DllImport("P2P.dll")
HRESULT PeerGroupResumePasswordAuthentication(void* hGroup, void* hPeerEventHandle);

@DllImport("P2P.dll")
HRESULT PeerIdentityCreate(const(wchar)* pwzClassifier, const(wchar)* pwzFriendlyName, uint hCryptProv, ushort** ppwzIdentity);

@DllImport("P2P.dll")
HRESULT PeerIdentityGetFriendlyName(const(wchar)* pwzIdentity, ushort** ppwzFriendlyName);

@DllImport("P2P.dll")
HRESULT PeerIdentitySetFriendlyName(const(wchar)* pwzIdentity, const(wchar)* pwzFriendlyName);

@DllImport("P2P.dll")
HRESULT PeerIdentityGetCryptKey(const(wchar)* pwzIdentity, uint* phCryptProv);

@DllImport("P2P.dll")
HRESULT PeerIdentityDelete(const(wchar)* pwzIdentity);

@DllImport("P2P.dll")
HRESULT PeerEnumIdentities(void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerEnumGroups(const(wchar)* pwzIdentity, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerCreatePeerName(const(wchar)* pwzIdentity, const(wchar)* pwzClassifier, ushort** ppwzPeerName);

@DllImport("P2P.dll")
HRESULT PeerIdentityGetXML(const(wchar)* pwzIdentity, ushort** ppwzIdentityXML);

@DllImport("P2P.dll")
HRESULT PeerIdentityExport(const(wchar)* pwzIdentity, const(wchar)* pwzPassword, ushort** ppwzExportXML);

@DllImport("P2P.dll")
HRESULT PeerIdentityImport(const(wchar)* pwzImportXML, const(wchar)* pwzPassword, ushort** ppwzIdentity);

@DllImport("P2P.dll")
HRESULT PeerIdentityGetDefault(ushort** ppwzPeerName);

@DllImport("P2P.dll")
HRESULT PeerCollabStartup(ushort wVersionRequested);

@DllImport("P2P.dll")
HRESULT PeerCollabShutdown();

@DllImport("P2P.dll")
HRESULT PeerCollabSignin(HWND hwndParent, uint dwSigninOptions);

@DllImport("P2P.dll")
HRESULT PeerCollabSignout(uint dwSigninOptions);

@DllImport("P2P.dll")
HRESULT PeerCollabGetSigninOptions(uint* pdwSigninOptions);

@DllImport("P2P.dll")
HRESULT PeerCollabAsyncInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, HANDLE hEvent, HANDLE* phInvitation);

@DllImport("P2P.dll")
HRESULT PeerCollabGetInvitationResponse(HANDLE hInvitation, PEER_INVITATION_RESPONSE** ppInvitationResponse);

@DllImport("P2P.dll")
HRESULT PeerCollabCancelInvitation(HANDLE hInvitation);

@DllImport("P2P.dll")
HRESULT PeerCollabCloseHandle(HANDLE hInvitation);

@DllImport("P2P.dll")
HRESULT PeerCollabInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, PEER_INVITATION_RESPONSE** ppResponse);

@DllImport("P2P.dll")
HRESULT PeerCollabAsyncInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, HANDLE hEvent, HANDLE* phInvitation);

@DllImport("P2P.dll")
HRESULT PeerCollabInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, PEER_INVITATION_RESPONSE** ppResponse);

@DllImport("P2P.dll")
HRESULT PeerCollabGetAppLaunchInfo(PEER_APP_LAUNCH_INFO** ppLaunchInfo);

@DllImport("P2P.dll")
HRESULT PeerCollabRegisterApplication(PEER_APPLICATION_REGISTRATION_INFO* pcApplication, PEER_APPLICATION_REGISTRATION_TYPE registrationType);

@DllImport("P2P.dll")
HRESULT PeerCollabUnregisterApplication(const(Guid)* pApplicationId, PEER_APPLICATION_REGISTRATION_TYPE registrationType);

@DllImport("P2P.dll")
HRESULT PeerCollabGetApplicationRegistrationInfo(const(Guid)* pApplicationId, PEER_APPLICATION_REGISTRATION_TYPE registrationType, PEER_APPLICATION_REGISTRATION_INFO** ppApplication);

@DllImport("P2P.dll")
HRESULT PeerCollabEnumApplicationRegistrationInfo(PEER_APPLICATION_REGISTRATION_TYPE registrationType, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerCollabGetPresenceInfo(PEER_ENDPOINT* pcEndpoint, PEER_PRESENCE_INFO** ppPresenceInfo);

@DllImport("P2P.dll")
HRESULT PeerCollabEnumApplications(PEER_ENDPOINT* pcEndpoint, const(Guid)* pApplicationId, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerCollabEnumObjects(PEER_ENDPOINT* pcEndpoint, const(Guid)* pObjectId, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerCollabEnumEndpoints(PEER_CONTACT* pcContact, void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerCollabRefreshEndpointData(PEER_ENDPOINT* pcEndpoint);

@DllImport("P2P.dll")
HRESULT PeerCollabDeleteEndpointData(PEER_ENDPOINT* pcEndpoint);

@DllImport("P2P.dll")
HRESULT PeerCollabQueryContactData(PEER_ENDPOINT* pcEndpoint, ushort** ppwzContactData);

@DllImport("P2P.dll")
HRESULT PeerCollabSubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

@DllImport("P2P.dll")
HRESULT PeerCollabUnsubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

@DllImport("P2P.dll")
HRESULT PeerCollabSetPresenceInfo(PEER_PRESENCE_INFO* pcPresenceInfo);

@DllImport("P2P.dll")
HRESULT PeerCollabGetEndpointName(ushort** ppwzEndpointName);

@DllImport("P2P.dll")
HRESULT PeerCollabSetEndpointName(const(wchar)* pwzEndpointName);

@DllImport("P2P.dll")
HRESULT PeerCollabSetObject(PEER_OBJECT* pcObject);

@DllImport("P2P.dll")
HRESULT PeerCollabDeleteObject(const(Guid)* pObjectId);

@DllImport("P2P.dll")
HRESULT PeerCollabRegisterEvent(HANDLE hEvent, uint cEventRegistration, char* pEventRegistrations, void** phPeerEvent);

@DllImport("P2P.dll")
HRESULT PeerCollabGetEventData(void* hPeerEvent, PEER_COLLAB_EVENT_DATA** ppEventData);

@DllImport("P2P.dll")
HRESULT PeerCollabUnregisterEvent(void* hPeerEvent);

@DllImport("P2P.dll")
HRESULT PeerCollabEnumPeopleNearMe(void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerCollabAddContact(const(wchar)* pwzContactData, PEER_CONTACT** ppContact);

@DllImport("P2P.dll")
HRESULT PeerCollabDeleteContact(const(wchar)* pwzPeerName);

@DllImport("P2P.dll")
HRESULT PeerCollabGetContact(const(wchar)* pwzPeerName, PEER_CONTACT** ppContact);

@DllImport("P2P.dll")
HRESULT PeerCollabUpdateContact(PEER_CONTACT* pContact);

@DllImport("P2P.dll")
HRESULT PeerCollabEnumContacts(void** phPeerEnum);

@DllImport("P2P.dll")
HRESULT PeerCollabExportContact(const(wchar)* pwzPeerName, ushort** ppwzContactData);

@DllImport("P2P.dll")
HRESULT PeerCollabParseContact(const(wchar)* pwzContactData, PEER_CONTACT** ppContact);

@DllImport("P2P.dll")
HRESULT PeerNameToPeerHostName(const(wchar)* pwzPeerName, ushort** ppwzHostName);

@DllImport("P2P.dll")
HRESULT PeerHostNameToPeerName(const(wchar)* pwzHostName, ushort** ppwzPeerName);

@DllImport("P2P.dll")
HRESULT PeerPnrpStartup(ushort wVersionRequested);

@DllImport("P2P.dll")
HRESULT PeerPnrpShutdown();

@DllImport("P2P.dll")
HRESULT PeerPnrpRegister(const(wchar)* pcwzPeerName, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo, void** phRegistration);

@DllImport("P2P.dll")
HRESULT PeerPnrpUpdateRegistration(void* hRegistration, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo);

@DllImport("P2P.dll")
HRESULT PeerPnrpUnregister(void* hRegistration);

@DllImport("P2P.dll")
HRESULT PeerPnrpResolve(const(wchar)* pcwzPeerName, const(wchar)* pcwzCloudName, uint* pcEndpoints, PEER_PNRP_ENDPOINT_INFO** ppEndpoints);

@DllImport("P2P.dll")
HRESULT PeerPnrpStartResolve(const(wchar)* pcwzPeerName, const(wchar)* pcwzCloudName, uint cMaxEndpoints, HANDLE hEvent, void** phResolve);

@DllImport("P2P.dll")
HRESULT PeerPnrpGetCloudInfo(uint* pcNumClouds, PEER_PNRP_CLOUD_INFO** ppCloudInfo);

@DllImport("P2P.dll")
HRESULT PeerPnrpGetEndpoint(void* hResolve, PEER_PNRP_ENDPOINT_INFO** ppEndpoint);

@DllImport("P2P.dll")
HRESULT PeerPnrpEndResolve(void* hResolve);

@DllImport("drtprov.dll")
HRESULT DrtCreatePnrpBootstrapResolver(BOOL fPublish, const(wchar)* pwzPeerName, const(wchar)* pwzCloudName, const(wchar)* pwzPublishingIdentity, DRT_BOOTSTRAP_PROVIDER** ppResolver);

@DllImport("drtprov.dll")
void DrtDeletePnrpBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

@DllImport("drtprov.dll")
HRESULT DrtCreateDnsBootstrapResolver(ushort port, const(wchar)* pwszAddress, DRT_BOOTSTRAP_PROVIDER** ppModule);

@DllImport("drtprov.dll")
void DrtDeleteDnsBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

@DllImport("drttransport.dll")
HRESULT DrtCreateIpv6UdpTransport(DRT_SCOPE scope, uint dwScopeId, uint dwLocalityThreshold, ushort* pwPort, void** phTransport);

@DllImport("drttransport.dll")
HRESULT DrtDeleteIpv6UdpTransport(void* hTransport);

@DllImport("drtprov.dll")
HRESULT DrtCreateDerivedKeySecurityProvider(CERT_CONTEXT* pRootCert, CERT_CONTEXT* pLocalCert, DRT_SECURITY_PROVIDER** ppSecurityProvider);

@DllImport("drtprov.dll")
HRESULT DrtCreateDerivedKey(CERT_CONTEXT* pLocalCert, DRT_DATA* pKey);

@DllImport("drtprov.dll")
void DrtDeleteDerivedKeySecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

@DllImport("drtprov.dll")
HRESULT DrtCreateNullSecurityProvider(DRT_SECURITY_PROVIDER** ppSecurityProvider);

@DllImport("drtprov.dll")
void DrtDeleteNullSecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

@DllImport("drt.dll")
HRESULT DrtOpen(const(DRT_SETTINGS)* pSettings, HANDLE hEvent, const(void)* pvContext, void** phDrt);

@DllImport("drt.dll")
void DrtClose(void* hDrt);

@DllImport("drt.dll")
HRESULT DrtGetEventDataSize(void* hDrt, uint* pulEventDataLen);

@DllImport("drt.dll")
HRESULT DrtGetEventData(void* hDrt, uint ulEventDataLen, char* pEventData);

@DllImport("drt.dll")
HRESULT DrtRegisterKey(void* hDrt, DRT_REGISTRATION* pRegistration, void* pvKeyContext, void** phKeyRegistration);

@DllImport("drt.dll")
HRESULT DrtUpdateKey(void* hKeyRegistration, DRT_DATA* pAppData);

@DllImport("drt.dll")
void DrtUnregisterKey(void* hKeyRegistration);

@DllImport("drt.dll")
HRESULT DrtStartSearch(void* hDrt, DRT_DATA* pKey, const(DRT_SEARCH_INFO)* pInfo, uint timeout, HANDLE hEvent, const(void)* pvContext, void** hSearchContext);

@DllImport("drt.dll")
HRESULT DrtContinueSearch(void* hSearchContext);

@DllImport("drt.dll")
HRESULT DrtGetSearchResultSize(void* hSearchContext, uint* pulSearchResultSize);

@DllImport("drt.dll")
HRESULT DrtGetSearchResult(void* hSearchContext, uint ulSearchResultSize, char* pSearchResult);

@DllImport("drt.dll")
HRESULT DrtGetSearchPathSize(void* hSearchContext, uint* pulSearchPathSize);

@DllImport("drt.dll")
HRESULT DrtGetSearchPath(void* hSearchContext, uint ulSearchPathSize, char* pSearchPath);

@DllImport("drt.dll")
HRESULT DrtEndSearch(void* hSearchContext);

@DllImport("drt.dll")
HRESULT DrtGetInstanceName(void* hDrt, uint ulcbInstanceNameSize, const(wchar)* pwzDrtInstanceName);

@DllImport("drt.dll")
HRESULT DrtGetInstanceNameSize(void* hDrt, uint* pulcbInstanceNameSize);

@DllImport("PeerDist.dll")
uint PeerDistStartup(uint dwVersionRequested, int* phPeerDist, uint* pdwSupportedVersion);

@DllImport("PeerDist.dll")
uint PeerDistShutdown(int hPeerDist);

@DllImport("PeerDist.dll")
uint PeerDistGetStatus(int hPeerDist, PEERDIST_STATUS* pPeerDistStatus);

@DllImport("PeerDist.dll")
uint PeerDistRegisterForStatusChangeNotification(int hPeerDist, HANDLE hCompletionPort, uint ulCompletionKey, OVERLAPPED* lpOverlapped, PEERDIST_STATUS* pPeerDistStatus);

@DllImport("PeerDist.dll")
uint PeerDistUnregisterForStatusChangeNotification(int hPeerDist);

@DllImport("PeerDist.dll")
uint PeerDistServerPublishStream(int hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, ulong cbContentLength, PEERDIST_PUBLICATION_OPTIONS* pPublishOptions, HANDLE hCompletionPort, uint ulCompletionKey, int* phStream);

@DllImport("PeerDist.dll")
uint PeerDistServerPublishAddToStream(int hPeerDist, int hStream, uint cbNumberOfBytes, char* pBuffer, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistServerPublishCompleteStream(int hPeerDist, int hStream, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistServerCloseStreamHandle(int hPeerDist, int hStream);

@DllImport("PeerDist.dll")
uint PeerDistServerUnpublish(int hPeerDist, uint cbContentIdentifier, char* pContentIdentifier);

@DllImport("PeerDist.dll")
uint PeerDistServerOpenContentInformation(int hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, ulong ullContentOffset, ulong cbContentLength, HANDLE hCompletionPort, uint ulCompletionKey, int* phContentInfo);

@DllImport("PeerDist.dll")
uint PeerDistServerRetrieveContentInformation(int hPeerDist, int hContentInfo, uint cbMaxNumberOfBytes, char* pBuffer, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistServerCloseContentInformation(int hPeerDist, int hContentInfo);

@DllImport("PeerDist.dll")
uint PeerDistServerCancelAsyncOperation(int hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, OVERLAPPED* pOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistClientOpenContent(int hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, uint ulCompletionKey, int* phContentHandle);

@DllImport("PeerDist.dll")
uint PeerDistClientCloseContent(int hPeerDist, int hContentHandle);

@DllImport("PeerDist.dll")
uint PeerDistClientAddContentInformation(int hPeerDist, int hContentHandle, uint cbNumberOfBytes, char* pBuffer, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistClientCompleteContentInformation(int hPeerDist, int hContentHandle, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistClientAddData(int hPeerDist, int hContentHandle, uint cbNumberOfBytes, char* pBuffer, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistClientBlockRead(int hPeerDist, int hContentHandle, uint cbMaxNumberOfBytes, char* pBuffer, uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistClientStreamRead(int hPeerDist, int hContentHandle, uint cbMaxNumberOfBytes, char* pBuffer, uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistClientFlushContent(int hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, uint ulCompletionKey, OVERLAPPED* lpOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistClientCancelAsyncOperation(int hPeerDist, int hContentHandle, OVERLAPPED* pOverlapped);

@DllImport("PeerDist.dll")
uint PeerDistGetStatusEx(int hPeerDist, PEERDIST_STATUS_INFO* pPeerDistStatus);

@DllImport("PeerDist.dll")
uint PeerDistRegisterForStatusChangeNotificationEx(int hPeerDist, HANDLE hCompletionPort, uint ulCompletionKey, OVERLAPPED* lpOverlapped, PEERDIST_STATUS_INFO* pPeerDistStatus);

@DllImport("PeerDist.dll")
BOOL PeerDistGetOverlappedResult(OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

@DllImport("PeerDist.dll")
uint PeerDistServerOpenContentInformationEx(int hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, ulong ullContentOffset, ulong cbContentLength, PEERDIST_RETRIEVAL_OPTIONS* pRetrievalOptions, HANDLE hCompletionPort, uint ulCompletionKey, int* phContentInfo);

@DllImport("PeerDist.dll")
uint PeerDistClientGetInformationByHandle(int hPeerDist, int hContentHandle, PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS PeerDistClientInfoClass, uint dwBufferSize, char* lpInformation);

