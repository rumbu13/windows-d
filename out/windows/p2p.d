// Written in the D programming language.

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


alias PNRP_SCOPE = int;
enum : int
{
    PNRP_SCOPE_ANY        = 0x00000000,
    PNRP_GLOBAL_SCOPE     = 0x00000001,
    PNRP_SITE_LOCAL_SCOPE = 0x00000002,
    PNRP_LINK_LOCAL_SCOPE = 0x00000003,
}

///The <b>PNRP_CLOUD_STATE</b> enumeration specifies the different states a PNRP cloud can be in.
alias PNRP_CLOUD_STATE = int;
enum : int
{
    ///The cloud is not yet initialized.
    PNRP_CLOUD_STATE_VIRTUAL       = 0x00000000,
    ///The cloud is in the process of being initialized.
    PNRP_CLOUD_STATE_SYNCHRONISING = 0x00000001,
    ///The cloud is active.
    PNRP_CLOUD_STATE_ACTIVE        = 0x00000002,
    ///The cloud is initialized, but has lost its connection to the network.
    PNRP_CLOUD_STATE_DEAD          = 0x00000003,
    ///The cloud is disabled in the registry.
    PNRP_CLOUD_STATE_DISABLED      = 0x00000004,
    ///The cloud was active, but has lost access to the network. In this state the cloud can still be used for
    ///registration but it is not capable of resolving addresses.
    PNRP_CLOUD_STATE_NO_NET        = 0x00000005,
    ///The local node bootstrapped, but found no other nodes in the cloud. This can also be the result of a network
    ///issue, like a firewall, preventing the local node from locating other nodes within the cloud. It is also
    ///important to note that a cloud in the <b>PNRP_CLOUD_STATE_ALONE</b> state may not have registered IP addresses.
    ///<div class="alert"><b>Note</b> It is possible for a local node to lose network connectivity while in this cloud
    ///state and not make the transition to the <b>PNRP_CLOUD_STATE_NO_NET</b> state.</div> <div> </div>
    PNRP_CLOUD_STATE_ALONE         = 0x00000006,
}

///The <b>PNRP_CLOUD_FLAGS</b> enumeration specifies the validity of a cloud name.
alias PNRP_CLOUD_FLAGS = int;
enum : int
{
    ///The cloud name is valid on the network.
    PNRP_CLOUD_NO_FLAGS         = 0x00000000,
    ///The cloud name is not valid on other computers.
    PNRP_CLOUD_NAME_LOCAL       = 0x00000001,
    ///The cloud is configured to be resolve only. Names cannot be published to the cloud from this computer.
    PNRP_CLOUD_RESOLVE_ONLY     = 0x00000002,
    ///This machine is a full participant in the cloud, and can publish and resolve names.
    PNRP_CLOUD_FULL_PARTICIPANT = 0x00000004,
}

alias PNRP_REGISTERED_ID_STATE = int;
enum : int
{
    PNRP_REGISTERED_ID_STATE_OK      = 0x00000001,
    PNRP_REGISTERED_ID_STATE_PROBLEM = 0x00000002,
}

///The <b>PNRP_RESOLVE_CRITERIA</b> enumeration specifies the criteria that PNRP uses to resolve searches.
alias PNRP_RESOLVE_CRITERIA = int;
enum : int
{
    ///Use the PNRP_RESOLVE_CRITERIA_NON_CURRENT_PROCESS_PEER_NAME criteria. This is also the default behavior if
    ///PNRPINFO is not specified.
    PNRP_RESOLVE_CRITERIA_DEFAULT                               = 0x00000000,
    ///Match a peer name. The resolve request excludes any peer name registered locally on this computer.
    PNRP_RESOLVE_CRITERIA_REMOTE_PEER_NAME                      = 0x00000001,
    ///Match a peer name by finding the name with a service location closest to the supplied hint, or if no hint is
    ///supplied, closest to the local IP address. The resolve request excludes any peer name registered locally on this
    ///computer.
    PNRP_RESOLVE_CRITERIA_NEAREST_REMOTE_PEER_NAME              = 0x00000002,
    ///Match a peer name. The matching peer name can be registered locally or remotely, but the resolve request excludes
    ///any peer name registered by the process making the resolve request.
    PNRP_RESOLVE_CRITERIA_NON_CURRENT_PROCESS_PEER_NAME         = 0x00000003,
    ///Match a peer name by finding the name with a service location closest to the supplied hint, or if no hint is
    ///supplied, closest to the local IP address. The matching peer name can be registered locally or remotely, but the
    ///resolve request excludes any peer name registered by the process making the resolve request.
    PNRP_RESOLVE_CRITERIA_NEAREST_NON_CURRENT_PROCESS_PEER_NAME = 0x00000004,
    ///Match a peer name. The matching peer name can be registered locally or remotely.
    PNRP_RESOLVE_CRITERIA_ANY_PEER_NAME                         = 0x00000005,
    ///Match a peer name by finding the name with a service location closest to the supplied hint, or if no hint is
    ///supplied, closest to the local IP address. The matching peer name can be registered locally or remotely.
    PNRP_RESOLVE_CRITERIA_NEAREST_PEER_NAME                     = 0x00000006,
}

alias PNRP_EXTENDED_PAYLOAD_TYPE = int;
enum : int
{
    PNRP_EXTENDED_PAYLOAD_TYPE_NONE   = 0x00000000,
    PNRP_EXTENDED_PAYLOAD_TYPE_BINARY = 0x00000001,
    PNRP_EXTENDED_PAYLOAD_TYPE_STRING = 0x00000002,
}

///The <b>PEER_RECORD_CHANGE_TYPE</b> enumeration specifies the changes that can occur to a record.
alias PEER_RECORD_CHANGE_TYPE = int;
enum : int
{
    ///Indicates that the specified record is added to the peer graph or group.
    PEER_RECORD_ADDED   = 0x00000001,
    ///Indicates that the specified record is updated in the peer graph or group.
    PEER_RECORD_UPDATED = 0x00000002,
    ///Indicates that the specified record is deleted from the peer graph or group.
    PEER_RECORD_DELETED = 0x00000003,
    ///Indicates that the specified record is expired and removed from the peer graph or group.
    PEER_RECORD_EXPIRED = 0x00000004,
}

///The <b>PEER_CONNECTION_STATUS</b> enumeration specifies the status of a peer direct or neighbor connection.
alias PEER_CONNECTION_STATUS = int;
enum : int
{
    ///The peer is connected to another peer.
    PEER_CONNECTED         = 0x00000001,
    ///The peer has disconnected from another peer.
    PEER_DISCONNECTED      = 0x00000002,
    PEER_CONNECTION_FAILED = 0x00000003,
}

///The <b>PEER_CONNECTION_FLAGS</b> enumeration specifies the types of connections that a peer can have.
alias PEER_CONNECTION_FLAGS = int;
enum : int
{
    ///Specifies that a connection is a neighbor connection.
    PEER_CONNECTION_NEIGHBOR = 0x00000001,
    ///Specifies that a connection is a direct connection to another node.
    PEER_CONNECTION_DIRECT   = 0x00000002,
}

///The <b>PEER_RECORD_FLAGS</b> enumeration specifies a set of flags for peer record behaviors.
alias PEER_RECORD_FLAGS = int;
enum : int
{
    ///The peer record must be automatically refreshed any time an event for the record is raised.
    PEER_RECORD_FLAG_AUTOREFRESH = 0x00000001,
    PEER_RECORD_FLAG_DELETED     = 0x00000002,
}

///The <b>PEER_GRAPH_EVENT_TYPE</b> enumeration specifies peer event types the application is to be notified for.
alias PEER_GRAPH_EVENT_TYPE = int;
enum : int
{
    ///The peer graph status has changed in some manner. For example, the node has synchronized with the peer graph.
    PEER_GRAPH_EVENT_STATUS_CHANGED      = 0x00000001,
    ///A field in the peer graph property structure has changed. This peer event does not generate a specific piece of
    ///data for an application to retrieve. The application must use PeerGraphGetProperties to obtain the updated
    ///structure.
    PEER_GRAPH_EVENT_PROPERTY_CHANGED    = 0x00000002,
    ///A record type or specific record has changed in some manner.
    PEER_GRAPH_EVENT_RECORD_CHANGED      = 0x00000003,
    ///A peer's direct connection has changed.
    PEER_GRAPH_EVENT_DIRECT_CONNECTION   = 0x00000004,
    ///A connection to a peer neighbor has changed.
    PEER_GRAPH_EVENT_NEIGHBOR_CONNECTION = 0x00000005,
    ///Data has been received from a direct or neighbor connection.
    PEER_GRAPH_EVENT_INCOMING_DATA       = 0x00000006,
    ///The peer graph has become unstable. The client should call PeerGraphConnect on a new node. This peer event does
    ///not generate a specific piece of data for an application to retrieve.
    PEER_GRAPH_EVENT_CONNECTION_REQUIRED = 0x00000007,
    ///A node's presence status has changed in the peer graph.
    PEER_GRAPH_EVENT_NODE_CHANGED        = 0x00000008,
    ///A specific record type has been synchronized.
    PEER_GRAPH_EVENT_SYNCHRONIZED        = 0x00000009,
}

///The <b>PEER_NODE_CHANGE_TYPE</b> enumeration specifies the types of peer node graph status changes.
alias PEER_NODE_CHANGE_TYPE = int;
enum : int
{
    ///The peer node has connected to the graph.
    PEER_NODE_CHANGE_CONNECTED    = 0x00000001,
    ///The peer node has disconnected from the graph.
    PEER_NODE_CHANGE_DISCONNECTED = 0x00000002,
    PEER_NODE_CHANGE_UPDATED      = 0x00000003,
}

///The <b>PEER_GRAPH_STATUS_FLAGS</b> enumeration is a set of flags that show the current status of a node within the
///peer graph.
alias PEER_GRAPH_STATUS_FLAGS = int;
enum : int
{
    ///Specifies whether or not the node is listening for connections.
    PEER_GRAPH_STATUS_LISTENING       = 0x00000001,
    ///Specifies whether or not the node has connections to other nodes.
    PEER_GRAPH_STATUS_HAS_CONNECTIONS = 0x00000002,
    ///Specifies whether or not the node's database is synchronized.
    PEER_GRAPH_STATUS_SYNCHRONIZED    = 0x00000004,
}

///The <b>PEER_GRAPH_PROPERTY_FLAGS</b> enumeration specifies properties of a peer graph.
alias PEER_GRAPH_PROPERTY_FLAGS = int;
enum : int
{
    ///Reserved.
    PEER_GRAPH_PROPERTY_HEARTBEATS       = 0x00000001,
    PEER_GRAPH_PROPERTY_DEFER_EXPIRATION = 0x00000002,
}

///The <b>PEER_GRAPH_SCOPE</b> enumeration specifies the network scope of a peer graph.
alias PEER_GRAPH_SCOPE = int;
enum : int
{
    ///The peer graph's network scope can contain any IP address, valid or otherwise.
    PEER_GRAPH_SCOPE_ANY       = 0x00000000,
    ///The IP addresses for the peer graph's network scope can be from any unblocked address range.
    PEER_GRAPH_SCOPE_GLOBAL    = 0x00000001,
    ///The IP addresses for the peer graph's network scope must be within the IP range defined for the site.
    PEER_GRAPH_SCOPE_SITELOCAL = 0x00000002,
    ///The IP addresses for the peer graph's network scope must be within the IP range defined for the local area
    ///network.
    PEER_GRAPH_SCOPE_LINKLOCAL = 0x00000003,
    PEER_GRAPH_SCOPE_LOOPBACK  = 0x00000004,
}

///The <b>PEER_GROUP_EVENT_TYPE</b> enumeration contains the specific peer event types that can occur within a peer
///group.
alias PEER_GROUP_EVENT_TYPE = int;
enum : int
{
    ///The status of the group has changed. This peer event is fired when one of the flags listed in the
    ///PEER_GROUP_STATUS enumeration are set or changed for the group.
    PEER_GROUP_EVENT_STATUS_CHANGED        = 0x00000001,
    ///A member in the [PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1) to retrieve.
    PEER_GROUP_EVENT_PROPERTY_CHANGED      = 0x00000002,
    ///A group record has changed. Information on this change is provided in the
    ///[PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1).
    PEER_GROUP_EVENT_RECORD_CHANGED        = 0x00000003,
    ///The status of a direct connection has changed. Information on this change is provided in the
    ///[PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1).
    PEER_GROUP_EVENT_DIRECT_CONNECTION     = 0x00000004,
    ///The status of a neighbor connection has changed. Information on this change is provided in the
    ///[PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1).
    PEER_GROUP_EVENT_NEIGHBOR_CONNECTION   = 0x00000005,
    ///Incoming direct connection data from a member is detected. Information on this peer event is provided in the
    ///[PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1).
    PEER_GROUP_EVENT_INCOMING_DATA         = 0x00000006,
    ///The status of a member has changed. Information on this change is provided in the
    ///[PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1).
    PEER_GROUP_EVENT_MEMBER_CHANGED        = 0x00000008,
    ///The connection to the peer group has failed. No data is provided when this peer event is raised. This event is
    ///also raised if no members are online in a group you are attempting to connect to for the first time.
    PEER_GROUP_EVENT_CONNECTION_FAILED     = 0x0000000a,
    PEER_GROUP_EVENT_AUTHENTICATION_FAILED = 0x0000000b,
}

///The <b>PEER_GROUP_STATUS</b> flags indicate whether or not the peer group has connections present.
alias PEER_GROUP_STATUS = int;
enum : int
{
    ///The peer group is awaiting new connections.
    PEER_GROUP_STATUS_LISTENING       = 0x00000001,
    ///The peer group has at least one connection.
    PEER_GROUP_STATUS_HAS_CONNECTIONS = 0x00000002,
}

///The <b>PEER_GROUP_PROPERTY_FLAGS</b> flags are used to specify various peer group membership settings.
alias PEER_GROUP_PROPERTY_FLAGS = int;
enum : int
{
    ///A peer's member data (PEER_MEMBER) is only published when an action if performed, such as publishing a record or
    ///issuing a GMC. If the peer has not performed one of these actions, the membership data will not be available.
    PEER_MEMBER_DATA_OPTIONAL = 0x00000001,
    ///The peer presence system is prevented from automatically publishing presence information.
    PEER_DISABLE_PRESENCE     = 0x00000002,
    ///Group records are not expired until the peer connects with a group.
    PEER_DEFER_EXPIRATION     = 0x00000004,
}

///The <b>PEER_GROUP_AUTHENTICATION_SCHEME</b> enumeration defines the set of possible authentication schemes that can
///be used to authenticate peers joining a peer group.
alias PEER_GROUP_AUTHENTICATION_SCHEME = int;
enum : int
{
    ///Authentication is performed using Group Membership Certificates (GMC).
    PEER_GROUP_GMC_AUTHENTICATION      = 0x00000001,
    PEER_GROUP_PASSWORD_AUTHENTICATION = 0x00000002,
}

///The <b>PEER_MEMBER_FLAGS</b> flag allows an application to specify whether all members or only present ones should be
///enumerated when the PeerGroupEnumMembers function is called, or to indicate whether or not a member is present within
///the peer group.
alias PEER_MEMBER_FLAGS = int;
enum : int
{
    ///The member is present in the peer group.
    PEER_MEMBER_PRESENT = 0x00000001,
}

///The <b>PEER_MEMBER_CHANGE_TYPE</b> enumeration defines the set of possible peer group membership and presence states
///for a peer.
alias PEER_MEMBER_CHANGE_TYPE = int;
enum : int
{
    ///A member is connected to a peer group.
    PEER_MEMBER_CONNECTED    = 0x00000001,
    ///A member is disconnected from a peer group.
    PEER_MEMBER_DISCONNECTED = 0x00000002,
    ///A member has updated information (for example, a new address) within a peer group.
    PEER_MEMBER_UPDATED      = 0x00000003,
    ///New membership information is published for a group member. The peer name of a peer group member is obtained from
    ///the <b>pwzIdentity</b> field of the PEER_EVENT_MEMBER_CHANGE_DATA structure. New membership information is
    ///published in one of the following three scenarios: <ul> <li>An administrator calls PeerGroupIssueCredentials with
    ///the PEER_GROUP_STORE_CREDENTIALS flag set.</li> <li>A user connects to a peer group for the first time, and the
    ///PEER_MEMBER_DATA_OPTIONAL flag is not set.</li> <li>A peer group member performs an operation (for example,
    ///issuing an invitation or credentials, or publishing a record), but membership information for the peer group
    ///member does not exist in the group.</li> </ul>
    PEER_MEMBER_JOINED       = 0x00000004,
    ///This peer event does not exist in the Peer Grouping Infrastructure v1.0, and must not be used.
    PEER_MEMBER_LEFT         = 0x00000005,
}

///The <b>PEER_GROUP_ISSUE_CREDENTIAL_FLAGS</b> are used to specify if user credentials are stored within a group.
alias PEER_GROUP_ISSUE_CREDENTIAL_FLAGS = int;
enum : int
{
    PEER_GROUP_STORE_CREDENTIALS = 0x00000001,
}

///The <b>PEER_SIGNIN_FLAGS</b> enumeration defines the set of peer presence publication behaviors available when the
///peer signs in to a peer collaboration network.
alias PEER_SIGNIN_FLAGS = int;
enum : int
{
    ///A peer's presence is not being published in any scope.
    PEER_SIGNIN_NONE     = 0x00000000,
    ///The peer can publish availability information to endpoints in the same subnet or local area network, or query for
    ///other endpoints available on the subnet.
    PEER_SIGNIN_NEAR_ME  = 0x00000001,
    ///The peer can publish presence, applications, and objects to all contacts in a peer's contact list.
    PEER_SIGNIN_INTERNET = 0x00000002,
    ///The peer can publish presence, applications, and objects to all contacts in a peer's contact list, or query for
    ///other endpoints available on the subnet.
    PEER_SIGNIN_ALL      = 0x00000003,
}

///The <b>PEER_WATCH_PERMISSION</b> enumeration defines whether a peer contact can receive presence updates from a
///contact.
alias PEER_WATCH_PERMISSION = int;
enum : int
{
    ///The peer contact cannot receive presence updates.
    PEER_WATCH_BLOCKED = 0x00000000,
    ///The peer contact can receive presence updates.
    PEER_WATCH_ALLOWED = 0x00000001,
}

///The <b>PEER_PUBLICATION_SCOPE</b> enumeration defines the set of scopes for the publication of peer objects or data.
alias PEER_PUBLICATION_SCOPE = int;
enum : int
{
    ///No scope is set for the publication of this data.
    PEER_PUBLICATION_SCOPE_NONE     = 0x00000000,
    ///The data is published to peers in the same logical or virtual subnet.
    PEER_PUBLICATION_SCOPE_NEAR_ME  = 0x00000001,
    ///The data is published to peers on the Internet.
    PEER_PUBLICATION_SCOPE_INTERNET = 0x00000002,
    ///The data is published to all peers.
    PEER_PUBLICATION_SCOPE_ALL      = 0x00000003,
}

///The <b>PEER_INVITATION_RESPONSE_TYPE</b> enumeration defines the type of response received to an invitation to start
///a Peer Collaboration activity.
alias PEER_INVITATION_RESPONSE_TYPE = int;
enum : int
{
    ///The invitation was declined by the peer.
    PEER_INVITATION_RESPONSE_DECLINED = 0x00000000,
    ///The invitation was accepted by the peer.
    PEER_INVITATION_RESPONSE_ACCEPTED = 0x00000001,
    ///The invitation has expired.
    PEER_INVITATION_RESPONSE_EXPIRED  = 0x00000002,
    ///An error occurred during the invitation process.
    PEER_INVITATION_RESPONSE_ERROR    = 0x00000003,
}

///The <b>PEER_APPLICATION_REGISTRATION_TYPE</b> enumeration defines the set of peer application registration flags.
alias PEER_APPLICATION_REGISTRATION_TYPE = int;
enum : int
{
    ///The application is available only to the current user account logged into the machine.
    PEER_APPLICATION_CURRENT_USER = 0x00000000,
    ///The application is available to all user accounts set on the machine.
    PEER_APPLICATION_ALL_USERS    = 0x00000001,
}

///The <b>PEER_PRESENCE_STATUS</b> enumeration defines the set of possible presence status settings available to a peer
///that participates in a peer collaboration network. These settings can be set by a peer collaboration network endpoint
///to indicate the peer's current level of participation to its watchers.
alias PEER_PRESENCE_STATUS = int;
enum : int
{
    ///The user is offline.
    PEER_PRESENCE_OFFLINE       = 0x00000000,
    ///The user is currently "out to lunch" and unable to respond.
    PEER_PRESENCE_OUT_TO_LUNCH  = 0x00000001,
    ///The user is away and unable to respond.
    PEER_PRESENCE_AWAY          = 0x00000002,
    ///The user has stepped away from the application and will participate soon.
    PEER_PRESENCE_BE_RIGHT_BACK = 0x00000003,
    ///The user is idling.
    PEER_PRESENCE_IDLE          = 0x00000004,
    ///The user is busy and does not wish to be disturbed.
    PEER_PRESENCE_BUSY          = 0x00000005,
    ///The user is currently on the phone and does not wish to be disturbed.
    PEER_PRESENCE_ON_THE_PHONE  = 0x00000006,
    ///The user is actively participating in the peer collaboration network.
    PEER_PRESENCE_ONLINE        = 0x00000007,
}

///The <b>PEER_CHANGE_TYPE</b> enumeration defines the set of changes that were performed on a peer object, endpoint, or
///application in a peer event. It is used to qualify the peer event associated with the change type.
alias PEER_CHANGE_TYPE = int;
enum : int
{
    ///The peer object, endpoint, or application has been added.
    PEER_CHANGE_ADDED   = 0x00000000,
    ///The peer object, endpoint, or application has been deleted.
    PEER_CHANGE_DELETED = 0x00000001,
    ///The peer object, endpoint, or application has been updated with new information.
    PEER_CHANGE_UPDATED = 0x00000002,
}

///The <b>PEER_COLLAB_EVENT_TYPE</b> enumeration defines the set of events that can be raised on a peer by the peer
///collaboration network event infrastructure.
alias PEER_COLLAB_EVENT_TYPE = int;
enum : int
{
    ///The peer's list of watched contacts has changed.
    PEER_EVENT_WATCHLIST_CHANGED            = 0x00000001,
    ///The endpoint has changed.
    PEER_EVENT_ENDPOINT_CHANGED             = 0x00000002,
    ///The presence status of an endpoint has changed.
    PEER_EVENT_ENDPOINT_PRESENCE_CHANGED    = 0x00000003,
    ///The registered application of the endpoint has changed.
    PEER_EVENT_ENDPOINT_APPLICATION_CHANGED = 0x00000004,
    ///A peer object registered to the endpoint has changed.
    PEER_EVENT_ENDPOINT_OBJECT_CHANGED      = 0x00000005,
    ///The local peer's endpoint has changed.
    PEER_EVENT_MY_ENDPOINT_CHANGED          = 0x00000006,
    ///The local peer's presence status has changed.
    PEER_EVENT_MY_PRESENCE_CHANGED          = 0x00000007,
    ///The local peer's registered application has changed.
    PEER_EVENT_MY_APPLICATION_CHANGED       = 0x00000008,
    ///A peer object registered with the local peer has changed.
    PEER_EVENT_MY_OBJECT_CHANGED            = 0x00000009,
    ///An endpoint in the same subnet as the local peer's endpoint has changed.
    PEER_EVENT_PEOPLE_NEAR_ME_CHANGED       = 0x0000000a,
    ///The status of a request to refresh endpoint data or subscribe to endpoint data has changed.
    PEER_EVENT_REQUEST_STATUS_CHANGED       = 0x0000000b,
}

///The <b>DRT_SCOPE</b> enumeration defines the set of IPv6 scopes in which DRT operates while using the IPv6 UDP
///transport created by DrtCreateIpv6UdpTransport.
alias DRT_SCOPE = int;
enum : int
{
    ///Uses the global scope.
    DRT_GLOBAL_SCOPE     = 0x00000001,
    ///The <b>DRT_SITE_LOCAL_SCOPE</b> has been deprecated and should not be used.
    DRT_SITE_LOCAL_SCOPE = 0x00000002,
    ///Uses the link local scope.
    DRT_LINK_LOCAL_SCOPE = 0x00000003,
}

///The <b>DRT_STATUS</b> enumeration defines the status of a local DRT instance.
alias DRT_STATUS = int;
enum : int
{
    ///The local node is connected to the DRT mesh and participating in the DRT system. This is also an indication that
    ///remote nodes exist and are present in the cache of the local node.
    DRT_ACTIVE     = 0x00000000,
    ///The local node is participating in the DRT system, but is waiting for remote nodes to join the DRT mesh. This is
    ///an indication that remote nodes do not exist, or are not yet present in the cache of the local node.
    DRT_ALONE      = 0x00000001,
    ///The local node does not have network connectivity.
    DRT_NO_NETWORK = 0x0000000a,
    ///A critical error has occurred in the local DRT instance. The DrtClose function must be called, after which an
    ///attempt to re-open the DRT can be made.
    DRT_FAULTED    = 0x00000014,
}

///The <b>DRT_MATCH_TYPE</b> enumeration defines the exactness of a search result returned by DrtGetSearchResult after
///initiating a search with the DrtStartSearch API.
alias DRT_MATCH_TYPE = int;
enum : int
{
    ///The node found is publishing the target key or is publishing a key within the specified range.
    DRT_MATCH_EXACT        = 0x00000000,
    ///The node found is publishing the numerically closest key to the specified target key.
    DRT_MATCH_NEAR         = 0x00000001,
    ///The node returned is an intermediate node. An application will receive this node match type if <b>fIterative</b>
    ///is set to <b>TRUE</b>.
    DRT_MATCH_INTERMEDIATE = 0x00000002,
}

///The <b>DRT_LEAFSET_KEY_CHANGE_TYPE</b> enumeration defines the set of changes that can occur on nodes in the leaf set
///of a locally registered key.
alias DRT_LEAFSET_KEY_CHANGE_TYPE = int;
enum : int
{
    ///A node was added to the DRT leaf set of the local node.
    DRT_LEAFSET_KEY_ADDED   = 0x00000000,
    ///A node was deleted from the DRT leaf set of the local node.
    DRT_LEAFSET_KEY_DELETED = 0x00000001,
}

///The <b>DRT_EVENT_TYPE</b> enumeration defines the set of events that can be raised by the Distributed Routing Table.
alias DRT_EVENT_TYPE = int;
enum : int
{
    ///The status of the local DRT instance has changed.
    DRT_EVENT_STATUS_CHANGED             = 0x00000000,
    ///A key or node was changed from the DRT leaf set of the local node.
    DRT_EVENT_LEAFSET_KEY_CHANGED        = 0x00000001,
    ///A locally published key is no longer resolvable by other nodes.
    DRT_EVENT_REGISTRATION_STATE_CHANGED = 0x00000002,
}

///The <b>DRT_SECURITY_MODE</b> enumeration defines possible security modes for the DRT. The security mode is specified
///by a field of the DRT_SETTINGS structure.
alias DRT_SECURITY_MODE = int;
enum : int
{
    ///Nodes must authenticate the keys they publish. Nodes are not required to authenticate themselves when performing
    ///searches.
    DRT_SECURE_RESOLVE             = 0x00000000,
    ///Nodes must authenticate the keys they publish. Nodes must also authenticate themselves when performing searches.
    ///Unauthorized nodes cannot search for keys and cannot retrieve the data associated with published keys.
    DRT_SECURE_MEMBERSHIP          = 0x00000001,
    ///Nodes must authenticate the keys they publish. Nodes must also authenticate themselves when performing searches.
    ///Encryption is required for all data associated with published keys prior to transmission between DRT nodes.
    ///Unauthorized nodes cannot search for keys, cannot retrieve the data associated with published keys, and cannot
    ///retrieve data by observing network traffic between other DRT nodes.
    DRT_SECURE_CONFIDENTIALPAYLOAD = 0x00000002,
}

///The <b>DRT_REGISTRATION_STATE</b> enumeration defines the set of legal states for a registered key.
alias DRT_REGISTRATION_STATE = int;
enum : int
{
    DRT_REGISTRATION_STATE_UNRESOLVEABLE = 0x00000001,
}

///The <b>DRT_ADDRESS_FLAGS</b> enumeration defines the set of responses that may be returned by an intermediate node
///when performing a search for a key.
alias DRT_ADDRESS_FLAGS = int;
enum : int
{
    ///The response provided by this machine was successfully used to make progress towards the search target.
    DRT_ADDRESS_FLAG_ACCEPTED                = 0x00000001,
    ///The response provided by this machine was not used in the search. This machine may have provided the address of a
    ///node publishing a key numerically farther from the target than other nodes already contacted.
    DRT_ADDRESS_FLAG_REJECTED                = 0x00000002,
    ///This machine did not respond.
    DRT_ADDRESS_FLAG_UNREACHABLE             = 0x00000004,
    ///The response provided by this machine was not used in the search. This machine provided the address of a node
    ///that has already been contacted.
    DRT_ADDRESS_FLAG_LOOP                    = 0x00000008,
    ///This machine indicated that it does not have sufficient resources to process the query.
    DRT_ADDRESS_FLAG_TOO_BUSY                = 0x00000010,
    ///This machine is not publishing the key expected by the local DRT instance. As a result, it may not be able to
    ///provide useful information.
    DRT_ADDRESS_FLAG_BAD_VALIDATE_ID         = 0x00000020,
    ///This machine has reason to believe that the target key has been unregistered.
    DRT_ADDRESS_FLAG_SUSPECT_UNREGISTERED_ID = 0x00000040,
    DRT_ADDRESS_FLAG_INQUIRE                 = 0x00000080,
}

///The <b>PEERDIST_STATUS</b> enumeration defines the possible status values of the Peer Distribution service.
alias PEERDIST_STATUS = int;
enum : int
{
    ///The service is disabled by Group Policy or according to configuration parameters.
    PEERDIST_STATUS_DISABLED    = 0x00000000,
    ///The service is not ready to process the request.
    PEERDIST_STATUS_UNAVAILABLE = 0x00000001,
    ///The Peer Distribution service is available and ready to process requests.
    PEERDIST_STATUS_AVAILABLE   = 0x00000002,
}

///The <b>PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS</b> enumeration defines the possible client information values.
alias PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS = int;
enum : int
{
    ///Indicates the information to retrieve is a PEERDIST_CLIENT_BASIC_INFO structure.
    PeerDistClientBasicInfo                 = 0x00000000,
    ///The maximum value for the enumeration that is used for error checking. This value should not be sent to the
    ///PeerDistClientGetInformationByHandle function.
    MaximumPeerDistClientInfoByHandlesClass = 0x00000001,
}

// Callbacks

///The <b>PFNPEER_VALIDATE_RECORD</b> callback specifies the function that the Peer Graphing Infrastructure calls to
///validate records.
///Params:
///    hGraph = Specifies the peer graph associated with the specified record.
///    pvContext = Pointer to the security context. This parameter should point to the <b>pvContext</b> member of the
///                PEER_SECURITY_INTERFACE structure.
///    pRecord = Specifies the record to validate.
///    changeType = Specifies the reason the validation must occur. Must be one of the PEER_RECORD_CHANGE_TYPE values.
///Returns:
///    If this callback succeeds, the return value is S_OK; otherwise, the function returns one of the following errors:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_DEFERRED_VALIDATION</b></dt> </dl> </td> <td width="60%"> The specified
///    record cannot be validated at this time because there is insufficient information to complete the operation.
///    Validation is deferred. Call PeerGraphValidateDeferredRecords when sufficient information is obtained. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_RECORD</b></dt> </dl> </td> <td width="60%"> The specified
///    record is invalid. </td> </tr> </table>
///    
alias PFNPEER_VALIDATE_RECORD = HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, 
                                                 PEER_RECORD_CHANGE_TYPE changeType);
///The <b>PFNPEER_SECURE_RECORD</b> callback specifies the function that the Peer Graphing Infrastructure calls to
///secure records.
///Params:
///    hGraph = Specifies the peer graph associated with the specified record.
///    pvContext = Pointer to the security context. This parameter points to the <b>pvContext</b> member of the
///                PEER_SECURITY_INTERFACE structure.
///    pRecord = Pointer to the record to secure.
///    changeType = Specifies the reason the validation must occur. PEER_RECORD_CHANGE_TYPE enumerates the valid values.
///    ppSecurityData = Specifies the security data for this record. This data is released by calling the method specified in the
///                     <b>pfnFreeSecurityData</b> member of the PEER_SECURITY_INTERFACE after the data is copied and added to the
///                     record.
///Returns:
///    If this callback succeeds, the return value is S_OK.
///    
alias PFNPEER_SECURE_RECORD = HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, 
                                               PEER_RECORD_CHANGE_TYPE changeType, PEER_DATA** ppSecurityData);
///The <b>PFNPEER_FREE_SECURITY_DATA</b> callback specifies the function that the Peer Graphing Infrastructure calls to
///free data returned by PFNPEER_SECURE_RECORD and PFNPEER_VALIDATE_RECORD callbacks.
///Params:
///    hGraph = Specifies the peer graph associated with the specified record.
///    pvContext = Pointer to the security context to free. This parameter is set to the value of the <b>pvContext</b> member of the
///                PEER_SECURITY_INTERFACE structure passed in PeerGraphCreate or PeerGraphOpen.
///    pSecurityData = Pointer to the security data to free.
///Returns:
///    If the callback is successful, the return value is S_OK. Otherwise, the callback returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
alias PFNPEER_FREE_SECURITY_DATA = HRESULT function(void* hGraph, void* pvContext, PEER_DATA* pSecurityData);
alias PFNPEER_ON_PASSWORD_AUTH_FAILED = HRESULT function(void* hGraph, void* pvContext);
alias DRT_BOOTSTRAP_RESOLVE_CALLBACK = void function(HRESULT hr, void* pvContext, SOCKET_ADDRESS_LIST* pAddresses, 
                                                     BOOL fFatalError);

// Structs


///The <b>PNRP_CLOUD_ID</b> structure contains the values that define a network cloud.
struct PNRP_CLOUD_ID
{
    ///Must be AF_INET6.
    int        AddressFamily;
    ///Specifies the scope of the cloud. Use one of the following values: <table> <tr> <th>Value</th>
    ///<th>Description</th> </tr> <tr> <td>PNRP_SCOPE_ANY</td> <td>The cloud can be in any scope.</td> </tr> <tr>
    ///<td>PNRP_GLOBAL_SCOPE</td> <td>The cloud must be a global scope.</td> </tr> <tr> <td>PNRP_SITE_LOCAL_SCOPE</td>
    ///<td>The cloud must be a site-local scope.</td> </tr> <tr> <td>PNRP_LINK_LOCAL_SCOPE</td> <td>The cloud must be a
    ///link-local scope.</td> </tr> </table>
    PNRP_SCOPE Scope;
    ///Specifies the ID for this scope.
    uint       ScopeId;
}

///The <b>PNRPINFO_V1</b> structure is pointed to by the <b>lpBlob</b> member of the WSAQUERYSET structure.
struct PNRPINFO_V1
{
    ///Specifies the size of this structure.
    uint           dwSize;
    ///Points to the Unicode string that contains the identity.
    const(wchar)*  lpwszIdentity;
    ///Specifies the requested number of resolutions.
    uint           nMaxResolve;
    ///Specifies the time, in seconds, to wait for a response.
    uint           dwTimeout;
    ///Specifies the number of seconds between refresh operations. Must be 86400 (24 * 60 * 60 seconds).
    uint           dwLifetime;
    ///Specifies the criteria used to resolve matches. PNRP can look for the first matching name, or attempt to find a
    ///name that is numerically close to the service location. Valid values are specified by PNRP_RESOLVE_CRITERIA.
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    ///Specifies the flags to use for the resolve operation. The valid value is: <table> <tr> <th>Value</th>
    ///<th>Description</th> </tr> <tr> <td>PNRPINFO_HINT</td> <td>Indicates that the <b>saHint</b> member is used. The
    ///hint influences how the service location portion of the PNRP ID is generated; it also influences how names are
    ///resolved, and specifies how to select between multiple peer names.</td> </tr> </table>
    uint           dwFlags;
    ///Specifies the IPv6 address to use for the location. The <b>dwFlags</b> member must be PNRPINFO_HINT.
    SOCKET_ADDRESS saHint;
    ///Specifies the state of the registered ID. This value is reserved and must be set to zero (0).
    PNRP_REGISTERED_ID_STATE enNameState;
}

///The <b>PNRPINFO_V1</b> structure is pointed to by the <b>lpBlob</b> member of the WSAQUERYSET structure.
struct PNRPINFO_V2
{
    ///Specifies the size of this structure.
    uint           dwSize;
    ///Points to the Unicode string that contains the identity.
    const(wchar)*  lpwszIdentity;
    ///Specifies the requested number of resolutions.
    uint           nMaxResolve;
    ///Specifies the time, in seconds, to wait for a response.
    uint           dwTimeout;
    ///Specifies the number of seconds between refresh operations. Must be 86400 (24 * 60 * 60 seconds).
    uint           dwLifetime;
    ///Specifies the criteria used to resolve matches. PNRP can look for the first matching name, or attempt to find a
    ///name that is numerically close to the service location. Valid values are specified by PNRP_RESOLVE_CRITERIA.
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    ///Specifies the flags to use for the resolve operation. The valid value is: <table> <tr> <th>Value</th>
    ///<th>Description</th> </tr> <tr> <td>PNRPINFO_HINT</td> <td>Indicates that the <b>saHint</b> member is used. The
    ///hint influences how the service location portion of the PNRP ID is generated; it also influences how names are
    ///resolved, and specifies how to select between multiple peer names.</td> </tr> </table>
    uint           dwFlags;
    ///Specifies the IPv6 address to use for the location. The <b>dwFlags</b> member must be PNRPINFO_HINT.
    SOCKET_ADDRESS saHint;
    ///Specifies the state of the registered ID. This value is reserved and must be set to zero (0).
    PNRP_REGISTERED_ID_STATE enNameState;
    PNRP_EXTENDED_PAYLOAD_TYPE enExtendedPayloadType;
    union
    {
        BLOB          blobPayload;
        const(wchar)* pwszPayload;
    }
}

///The <b>PNRPCLOUDINFO</b> structure is pointed to by the <b>lpBlob</b> member of the WSAQUERYSET structure.
struct PNRPCLOUDINFO
{
    ///Specifies the size of this structure.
    uint             dwSize;
    ///Specifies the network cloud information stored in a PNRP_CLOUD_ID structure.
    PNRP_CLOUD_ID    Cloud;
    ///Specifies the state of the network cloud. Valid values are specified by PNRP_CLOUD_STATE.
    PNRP_CLOUD_STATE enCloudState;
    ///Indicates if the cloud name is valid on the network or only valid on the current computer. Valid values are
    ///specified by PNRP_CLOUD_FLAGS.
    PNRP_CLOUD_FLAGS enCloudFlags;
}

///The <b>PEER_VERSION_DATA</b> structure contains the version information about the Peer Graphing and Grouping APIs.
struct PEER_VERSION_DATA
{
    ///Specifies the version of the Peer Infrastructure for a caller to use. The version to use is based on the Peer
    ///Infrastructure DLL installed on a local computer. A high order-byte specifies the minor version (revision)
    ///number. A low-order byte specifies the major version number.
    ushort wVersion;
    ///Specifies the highest version of the Peer Infrastructure that the Peer DLL installed on the local computer can
    ///support. Typically, this value is the same as <b>wVersion</b>.
    ushort wHighestVersion;
}

///The <b>PEER_DATA</b> structure contains binary data.
struct PEER_DATA
{
    ///Size of <b>pbData</b>, in bytes. It is possible for this value to be set to zero if <b>pbData</b> contains no
    ///data.
    uint   cbData;
    ///Pointer to a buffer.
    ubyte* pbData;
}

///The <b>PEER_RECORD</b> structure contains the record object that an application uses.
struct PEER_RECORD
{
    ///Specifies the size of a structure. Set the value to sizeof(<b>PEER_RECORD</b>).
    uint          dwSize;
    ///Specifies the type of record. The type is a <b>GUID</b> that an application must specify. The <b>GUID</b>
    ///represents a unique record type, for example, a chat record.
    GUID          type;
    ///Specifies the unique ID of a record. The Peer Infrastructure supplies this ID. This parameter is ignored in calls
    ///to PeerGroupAddRecord. An application cannot modify this member.
    GUID          id;
    ///Specifies the version of a record that the Peer Infrastructure supplies when an application calls
    ///PeerGraphAddRecord or PeerGraphUpdateRecord. An application cannot modify this member.
    uint          dwVersion;
    ///Specifies the flags that indicate special processing, which must be applied to a record. The following table
    ///identifies the valid values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///<td><b>PEER_RECORD_FLAG_AUTOREFRESH</b></td> <td>Indicates that a record is automatically refreshed when it is
    ///ready to expire. </td> </tr> <tr> <td><b>PEER_RECORD_FLAG_DELETED</b></td> <td>Indicates that a record is marked
    ///as deleted. </td> </tr> </table> <div class="alert"><b>Note</b> An application cannot set these flags.</div>
    ///<div> </div>
    uint          dwFlags;
    ///Pointer to the unique ID of a record creator. This member is set to <b>NULL</b> for calls to PeerGraphAddRecord
    ///and PeerGraphUpdateRecord. An application cannot set this member.
    const(wchar)* pwzCreatorId;
    ///Specifies the unique ID of the last person who changes a record. An application cannot set this member.
    const(wchar)* pwzModifiedById;
    ///Pointer to the set of attribute name and value pairs that are associated with a record. This member points to an
    ///XML string. Record attributes are specified as an XML string, and they must be consistent with the Peer
    ///Infrastructure record attribute schema. For a complete explanation of the XML schema, see Record Attribute
    ///Schema. The Peer Infrastructure reserves several attribute names that a user cannot set. The following list
    ///identifies the reserved attribute names:<ul> <li><b>peerlastmodifiedby</b></li> <li><b>peercreatorid</b></li>
    ///<li><b>peerlastmodificationtime</b></li> <li><b>peerrecordid</b></li> <li><b>peerrecordtype</b></li>
    ///<li><b>peercreationtime</b></li> <li><b>peerlastmodificationtime</b></li> </ul>
    const(wchar)* pwzAttributes;
    ///Specifies the Coordinated Universal Time (UTC) that a record is created. The Peer Infrastructure supplies this
    ///value, and the value is set to zero (0) in calls to PeerGroupAddRecord. An application cannot set this member.
    FILETIME      ftCreation;
    ///The UTC time that a record expires. This member is required. It can be updated to a time value greater than the
    ///originally specified time value, but it cannot be less than the originally specified value. <div
    ///class="alert"><b>Note</b> If <b>dwFlags</b> is set to <b>PEER_RECORD_FLAG_AUTOREFRESH</b>, do not set the value
    ///of <b>ftExpiration</b> to less than four (4) minutes. If this member is set to less than four (4) minutes,
    ///undefined behavior can occur.</div> <div> </div>
    FILETIME      ftExpiration;
    ///The UTC time that a record is modified. The Peer Infrastructure supplies this value. Set this member to
    ///<b>NULL</b> when calling PeerGraphAddRecord, PeerGraphUpdateRecord, PeerGroupAddRecord, and
    ///PeerGroupUpdateRecord. An application cannot set this member.
    FILETIME      ftLastModified;
    ///Specifies the security data contained in a PEER_DATA structure. The Graphing API uses this member, and provides
    ///the security provider with a place to store security data, for example, a signature. The Grouping API cannot
    ///modify this member.
    PEER_DATA     securityData;
    ///Specifies the actual data that this record contains.
    PEER_DATA     data;
}

///The <b>PEER_ADDRESS</b> structure specifies the information about the IP address.
struct PEER_ADDRESS
{
    ///Specifies the size of this structure.
    uint            dwSize;
    ///Specifies the IP address of the node in the Peer Infrastructure.
    SOCKADDR_IN6_LH sin6;
}

///The <b>PEER_CONNECTION_INFO</b> structure contains information about a connection. This structure is returned when
///you are enumerating peer graphing or grouping connections.
struct PEER_CONNECTION_INFO
{
    ///Specifies the size a structure.
    uint          dwSize;
    ///Specifies the type of connection to a remote node. Valid values are specified by PEER_CONNECTION_FLAGS.
    uint          dwFlags;
    ///Specifies the unique ID of a connection.
    ulong         ullConnectionId;
    ///Specifies the unique ID of a node.
    ulong         ullNodeId;
    ///Points to a string that identifies the node on the other end of a connection.
    const(wchar)* pwzPeerId;
    ///Specifies the address of a remote node. The address is contained in a PEER_ADDRESS structure.
    PEER_ADDRESS  address;
}

///The [PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1) structure points to the
///<b>PEER_EVENT_INCOMING_DATA</b> structure if one of the following peer events is triggered: <ul>
///<li><b>PEER_GRAPH_INCOMING_DATA</b></li> <li><b>PEER_GROUP_INCOMING_DATA</b></li> </ul> The
///<b>PEER_EVENT_INCOMING_DATA</b> structure contains updated information that includes data changes a node receives
///from a neighbor or direct connection.
struct PEER_EVENT_INCOMING_DATA
{
    ///Specifies the size of a structure.
    uint      dwSize;
    ///Specifies the unique ID of a data connection.
    ulong     ullConnectionId;
    ///Specifies the application-defined data type of incoming data.
    GUID      type;
    ///Specifies the actual data received.
    PEER_DATA data;
}

///The [PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1) structure points to the
///<b>PEER_EVENT_RECORD_CHANGE_DATA</b> structure if one of the following peer events is triggered: <ul>
///<li><b>PEER_GRAPH_EVENT_RECORD_CHANGE</b></li> <li><b>PEER_GROUP_EVENT_RECORD_CHANGE</b></li> </ul> The
///<b>PEER_EVENT_RECORD_CHANGE_DATA</b> structure contains updated information that an application requests for data
///changes to a record or record type.
struct PEER_EVENT_RECORD_CHANGE_DATA
{
    ///Specifies the size of a structure.
    uint dwSize;
    ///Specifies the type of change to a record or record type.
    PEER_RECORD_CHANGE_TYPE changeType;
    ///Specifies the unique ID of a changed record.
    GUID recordId;
    ///Specifies the unique record type of a changed record.
    GUID recordType;
}

///A PEER_GRAPH_EVENT_DATA structure points to the <b>PEER_EVENT_CONNECTION_CHANGE_DATA</b> structure if one of the
///following peer events is triggered: <ul> <li><b>PEER_GRAPH_EVENT_NEIGHBOR_CONNECTION</b></li>
///<li><b>PEER_GRAPH_EVENT_DIRECT_CONNECTION</b></li> <li><b>PEER_GROUP_EVENT_NEIGHBOR_CONNECTION</b></li>
///<li><b>PEER_GROUP_EVENT_DIRECT_CONNECTION</b></li> </ul> The <b>PEER_EVENT_CONNECTION_CHANGE_DATA</b> structure
///contains updated information that includes changes to a neighbor or direct connection.
struct PEER_EVENT_CONNECTION_CHANGE_DATA
{
    ///Specifies the size of a structure.
    uint    dwSize;
    ///Specifies the type of change in a neighbor or direct connection. Valid values are the following. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PEER_CONNECTED"></a><a
    ///id="peer_connected"></a><dl> <dt><b><b>PEER_CONNECTED</b></b></dt> </dl> </td> <td width="60%"> A new incoming or
    ///outgoing connection to the local node has been established. </td> </tr> <tr> <td width="40%"><a
    ///id="PEER_CONNECTION_FAILED"></a><a id="peer_connection_failed"></a><dl>
    ///<dt><b><b>PEER_CONNECTION_FAILED</b></b></dt> </dl> </td> <td width="60%"> An attempt to connect to a local node
    ///has failed. It is possible for a single attempt to connect to result in multiple connection failures. This will
    ///occur after the initial connection failure, when the peer infrastructure sets the <b>ullNextConnectionId</b>
    ///member to the Node ID and attempts a new connection. If the <b>ullNextConnectionId</b> member is 0, no further
    ///connections will be attempted. </td> </tr> <tr> <td width="40%"><a id="PEER_DISCONNECTED"></a><a
    ///id="peer_disconnected"></a><dl> <dt><b><b>PEER_DISCONNECTED</b></b></dt> </dl> </td> <td width="60%"> An existing
    ///connection has been disconnected. </td> </tr> </table>
    PEER_CONNECTION_STATUS status;
    ///Specifies the unique ID for a connection that has changed.
    ulong   ullConnectionId;
    ///Specifies the unique ID for the node that has changed.
    ulong   ullNodeId;
    ///<b>Windows Vista or later.</b> Contains the next available node ID that the grouping or graphing APIs will
    ///attempt to connect to when a connection fails. If this member has a value of 0, no further connections will be
    ///attempted.
    ulong   ullNextConnectionId;
    ///<b>Windows Vista or later.</b> Specifies the type of error when a connection fails.
    ///<b>hrConnectionFailedReason</b> can return the following error codes. <table> <tr> <th>Value</th>
    ///<th>Description</th> </tr> <tr> <td><b>PEER_E_CONNECTION_REFUSED</b></td> <td>A connection has been established
    ///and refused. The remote node is already at maximum number of connections or a connection already exists.</td>
    ///</tr> <tr> <td><b>PEER_E_CONNECTION_FAILED</b></td> <td>An attempt to connect to a remote node has failed.</td>
    ///</tr> <tr> <td><b>PEER_E_CONNECTION_NOT_AUTHENTICATED </b></td> <td>A connection is lost during the
    ///authentication phase. This is the result of a network failure or the remote node breaking the connection.</td>
    ///</tr> </table>
    HRESULT hrConnectionFailedReason;
}

///The <b>PEER_EVENT_SYNCHRONIZED_DATA</b> is pointed to by a PEER_GRAPH_EVENT_DATA structure's union if a
///PEER_GRAPH_EVENT_RECORD_CHANGE or PEER_GROUP_EVENT_RECORD_CHANGE event is triggered. The
///<b>PEER_EVENT_SYNCHRONIZED_DATA</b> structure indicates the type of record that has been synchronized.
struct PEER_EVENT_SYNCHRONIZED_DATA
{
    ///Specifies the size of the structure.
    uint dwSize;
    ///Specifies the type of record that is being synchronized.
    GUID recordType;
}

///The <b>PEER_GRAPH_PROPERTIES</b> structure contains data about the policy of a peer graph, ID, scope, and other
///information.
struct PEER_GRAPH_PROPERTIES
{
    ///Specifies the size, in bytes, of this data structure. The <b>dwSize</b> member must be set to the size of
    ///<b>PEER_GRAPH_PROPERTIES</b> before calling PeerGraphCreate. This member is required. There is not a default
    ///value.
    uint          dwSize;
    ///Flags that control the behavior of a peer in a graph. The default is does not have flags set. The valid value is
    ///identified in the following table. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///<td><b>PEER_GRAPH_PROPERTY_DEFER_EXPIRATION</b></td> <td>Specifies when to expire a graph record. When a graph is
    ///not connected and this flag is set, expiration does not occur until the graph connects to at least one other
    ///member. </td> </tr> </table>
    uint          dwFlags;
    ///Specifies the scope in which the peer graph ID is published. The default value is global. Valid values are
    ///identified in the following table. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///<td><b>PEER_GRAPH_SCOPE_GLOBAL</b></td> <td>Scope includes the Internet.</td> </tr> <tr>
    ///<td><b>PEER_GRAPH_SCOPE_LINK_LOCAL</b></td> <td>Scope is restricted to a local subnet.</td> </tr> <tr>
    ///<td><b>PEER_GRAPH_SCOPE_SITE_LOCAL</b></td> <td>Scope is restricted to a site, for example, a corporation
    ///intranet.</td> </tr> </table>
    uint          dwScope;
    ///Specifies the value that indicates the largest record that can be added to a peer graph. A valid value is zero
    ///(0), which indicates that the default maximum record size is used (60 megabytes), and any value between 1024
    ///bytes and 60 megabytes.
    uint          dwMaxRecordSize;
    ///Specifies the unique identifier for a peer graph. This ID must be unique for the computer/user pair. This member
    ///is required and has no default value. If the string value is greater than 256 characters (including the null
    ///terminator), an error is returned.
    const(wchar)* pwzGraphId;
    ///Specifies the unique identifier for the creator of a peer graph. This member is required and has no default
    ///value. If the string value is greater than 256 characters (including the null terminator), an error is returned.
    const(wchar)* pwzCreatorId;
    ///Specifies the friendly name of a peer graph. This member is optional and can be <b>NULL</b>. The default value is
    ///<b>NULL</b>. The maximum length of this string is 256 characters, including the null terminator.
    const(wchar)* pwzFriendlyName;
    ///Specifies the comment used to describe a peer graph. This member is optional and can be <b>NULL</b>. The default
    ///value is <b>NULL</b>. The maximum length of this string is 512 characters, including the null terminator.
    const(wchar)* pwzComment;
    ///Specifies the number of seconds before a presence record expires. The default value is 300 seconds (5 minutes).
    ///Do not set the value of <b>ulPresenceLifetime</b> to less than 300 seconds. If this member is set less than the
    ///300 (5 minutes) default value, then undefined behavior can occur.
    uint          ulPresenceLifetime;
    ///Specifies how many presence records the Peer Infrastructure keeps in a peer graph at one time. A node that has
    ///its presence published can be enumerated by all other nodes with PeerGraphEnumNodes. Specify how presence records
    ///for users are published by specifying one of the values identified in the following table. <table> <tr>
    ///<th>Value</th> <th>Description</th> </tr> <tr> <td>-1</td> <td>Presence records are automatically published for
    ///all users.</td> </tr> <tr> <td>0</td> <td>Presence records are not automatically published.</td> </tr> <tr>
    ///<td>1-N</td> <td>Up to N number of presence records are published at one time. The presence records that are
    ///published are randomly chosen by the Peer Graphing Infrastructure. </td> </tr> </table>
    uint          cPresenceMax;
}

///The <b>PEER_NODE_INFO</b> structure contains information that is specific to a particular node in a peer graph.
struct PEER_NODE_INFO
{
    ///Specifies the size of the data structure. Set the value to sizeof(<b>PEER_NODE_INFO</b>). This member is required
    ///and has no default value.
    uint          dwSize;
    ///Specifies a unique ID that identifies an application's connection to its neighbor. An application cannot set the
    ///value of this member, it is created by the Peer Graphing Infrastructure.
    ulong         ullNodeId;
    ///Specifies the ID of this peer. This value is set for the application by the Peer Graphing Infrastructure. when
    ///the application creates or opens a peer graph.
    const(wchar)* pwzPeerId;
    ///Specifies the number of addresses in <b>pAddresses</b>. This member is required and has no default value.
    uint          cAddresses;
    ///Points to an array of PEER_ADDRESS structures that indicate which addresses and ports this instance is listening
    ///to for group traffic. This member is required and has no default value.
    PEER_ADDRESS* pAddresses;
    ///Points to a string that contains the attributes that describe this particular node. This string is a free-form
    ///text string that is specific to the application. This parameter is optional; the default value is <b>NULL</b>.
    const(wchar)* pwzAttributes;
}

///The <b>PEER_EVENT_NODE_CHANGE_DATA</b> structure contains a pointer to the data if a
///<b>PEER_GRAPH_EVENT_NODE_CHANGE</b> event is triggered.
struct PEER_EVENT_NODE_CHANGE_DATA
{
    ///Specifies the size of the structure. Should set to the size of PEER_EVENT_NODE_CHANGE_DATA.
    uint          dwSize;
    ///Specifies the new state of the node. Valid values are the following. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="PEER_NODE_CHANGE_CONNECTED"></a><a id="peer_node_change_connected"></a><dl>
    ///<dt><b>PEER_NODE_CHANGE_CONNECTED</b></dt> </dl> </td> <td width="60%"> The node is present in the graph. </td>
    ///</tr> <tr> <td width="40%"><a id="PEER_NODE_CHANGE_DISCONNECTED"></a><a
    ///id="peer_node_change_disconnected"></a><dl> <dt><b>PEER_NODE_CHANGE_DISCONNECTED</b></dt> </dl> </td> <td
    ///width="60%"> The node is no longer present in the graph. </td> </tr> <tr> <td width="40%"><a
    ///id="PEER_NODE_CHANGE_UPDATED"></a><a id="peer_node_change_updated"></a><dl>
    ///<dt><b>PEER_NODE_CHANGE_UPDATED</b></dt> </dl> </td> <td width="60%"> The node has new information, for example,
    ///the attributes have changed. </td> </tr> </table>
    PEER_NODE_CHANGE_TYPE changeType;
    ///Specifies the unique ID of the node that has changed.
    ulong         ullNodeId;
    ///Specifies the peer ID of the node that has changed.
    const(wchar)* pwzPeerId;
}

///The <b>PEER_GRAPH_EVENT_REGISTRATION</b> structure is used during registration for peer event notification. During
///registration it specifies which peer events an application requires notifications for.
struct PEER_GRAPH_EVENT_REGISTRATION
{
    ///Specifies the type of peer event the application requires notifications for. The per events that can be
    ///registered for are specified by the PEER_GRAPH_EVENT_TYPE enumeration.
    PEER_GRAPH_EVENT_TYPE eventType;
    ///If the peer event specified by <b>eventType</b> relates to records, use this member to specify which types of
    ///records the application requires notifications for. Specify <b>NULL</b> to receive notifications for all record
    ///types. This member is ignored if the event specified by <b>eventType</b> does not relate to records.
    GUID* pType;
}

///The <b>PEER_GRAPH_EVENT_DATA</b> structure contains data associated with a peer event.
struct PEER_GRAPH_EVENT_DATA
{
    ///The type of peer event this data corresponds to. Must be one of the PEER_GRAPH_EVENT_TYPE values. The members
    ///that remain are given values based on the peer event type that has occurred. Not all members contain data.
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

///The <b>PEER_SECURITY_INTERFACE</b> structure specifies the security interfaces that calls to Peer Graphing APIs use
///to validate, secure, and free records. Additionally, it allows an application to specify the path to the .DLL that
///contains an implementation of a security service provider (SSP).
struct PEER_SECURITY_INTERFACE
{
    ///Specifies the size of the structure. Set the value to sizeof(<b>PEER_SECURITY_INTERFACE</b>). This member is
    ///required and has no default value.
    uint          dwSize;
    ///Specifies the full path and file name of a .DLL that implements the SSP interface. See the SSPI documentation for
    ///further information on the SSP interface.
    const(wchar)* pwzSspFilename;
    ///Specifies the ID of the security module in the SSP to use.
    const(wchar)* pwzPackageName;
    ///Specifies the byte count of the <b>pbSecurityInfo</b> member. This member is not required if
    ///<b>pbSecurityInfo</b> is <b>NULL</b>. However, if <b>pbSecurityInfo</b> is not <b>NULL</b>, this member must have
    ///a value.
    uint          cbSecurityInfo;
    ///Pointer to a buffer that contains the information used to create or open a peer graph. This member is optional
    ///and can be <b>NULL</b>. The security data blob pointed to by <b>pbSecurityInfo</b> is copied and then passed to
    ///the SSPI function call of AcquireCredentialsHandle.
    ubyte*        pbSecurityInfo;
    ///Pointer to the security context. This security context is then passed as the first parameter to
    ///PFNPEER_VALIDATE_RECORD, PFNPEER_FREE_SECURITY_DATA, and PFNPEER_SECURE_RECORD. This member is optional and can
    ///be <b>NULL</b>.
    void*         pvContext;
    ///Pointer to a callback function that is called when a record requires validation. This member is optional and can
    ///be <b>NULL</b>. If <b>pfnSecureRecord</b> is <b>NULL</b>, this member must also be <b>NULL</b>.
    PFNPEER_VALIDATE_RECORD pfnValidateRecord;
    ///Pointer to a callback function that is called when a record must be secured. This member is optional and can be
    ///<b>NULL</b>. If <b>pfnValidateRecord</b> is <b>NULL</b>, this member must also be <b>NULL</b>.
    PFNPEER_SECURE_RECORD pfnSecureRecord;
    ///Pointer to a callback function used to free any data allocated by the callback pointed to by
    ///<b>pfnSecureRecord</b>. This member is optional and can be <b>NULL</b>.
    PFNPEER_FREE_SECURITY_DATA pfnFreeSecurityData;
    PFNPEER_ON_PASSWORD_AUTH_FAILED pfnAuthFailed;
}

///The <b>PEER_CREDENTIAL_INFO</b> structure defines information used to obtain and issue a peer's security credentials.
struct PEER_CREDENTIAL_INFO
{
    ///Specifies the size of this structure, in bytes.
    uint          dwSize;
    ///Reserved. This field must be set to 0.
    uint          dwFlags;
    ///Pointer to a Unicode string that specifies the friendly (display) name of the issuer.
    const(wchar)* pwzFriendlyName;
    ///Pointer to a <b>CERT_PUBLIC_KEY_INFO</b> structure that contains the peer group member's public key and the
    ///encryption type it uses.
    CERT_PUBLIC_KEY_INFO* pPublicKey;
    ///Pointer to a Unicode string that specifies the membership issuer's PNRP name.
    const(wchar)* pwzIssuerPeerName;
    ///Pointer to a Unicode string that specifies the friendly (display) name of the issuer.
    const(wchar)* pwzIssuerFriendlyName;
    ///Specifies the FILETIME structure that contains the time when the recipient's membership in the peer group becomes
    ///valid. When issuing new credentials this value must be greater than the ValidityStart value for the member's
    ///current credentials.
    FILETIME      ftValidityStart;
    ///Specifies the FILETIME structure that contains the time when the recipient's membership in the peer group becomes
    ///invalid.
    FILETIME      ftValidityEnd;
    ///Specifies the number of role GUIDs present in <b>pRoles</b>.
    uint          cRoles;
    ///Pointer to a list of GUIDs that specifies the combined set of available roles. The available roles are as
    ///follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PEER_GROUP_ROLE_ADMIN"></a><a id="peer_group_role_admin"></a><dl> <dt><b>PEER_GROUP_ROLE_ADMIN</b></dt> </dl>
    ///</td> <td width="60%"> This role can issue invitations, issue credentials, and renew the GMC of other
    ///administrators, as well as behave as a member of the peer group. </td> </tr> <tr> <td width="40%"><a
    ///id="PEER_GROUP_ROLE_MEMBER"></a><a id="peer_group_role_member"></a><dl> <dt><b>PEER_GROUP_ROLE_MEMBER</b></dt>
    ///</dl> </td> <td width="60%"> The role can add records to the peer group database. </td> </tr> </table>
    GUID*         pRoles;
}

///The <b>PEER_MEMBER</b> structure contains information that describes a member of a peer group.
struct PEER_MEMBER
{
    ///Specifies the size of this structure, in bytes.
    uint          dwSize;
    ///PEER_MEMBER_FLAGS enumeration value that specifies the state of the member. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PEER_MEMBER_PRESENT"></a><a id="peer_member_present"></a><dl>
    ///<dt><b>PEER_MEMBER_PRESENT</b></dt> </dl> </td> <td width="60%"> The member is present in the peer group. </td>
    ///</tr> </table>
    uint          dwFlags;
    ///Pointer to a Unicode string that specifies the peer name of the member.
    const(wchar)* pwzIdentity;
    ///Pointer to a unicode string that specifies the attributes of the member. The format of this string is defined by
    ///the application.
    const(wchar)* pwzAttributes;
    ///Unsigned 64-bit integer that contains the node ID. The same peer can have several node IDs, each identifying a
    ///different node that participates in a different peer group.
    ulong         ullNodeId;
    ///Specifies the number of IP addresses listed in <b>pAddress</b>.
    uint          cAddresses;
    ///Pointer to a list of PEER_ADDRESS structures used by the member.
    PEER_ADDRESS* pAddresses;
    ///Pointer to a PEER_CREDENTIAL_INFO structure that contains information about the security credentials of a member.
    PEER_CREDENTIAL_INFO* pCredentialInfo;
}

///The <b>PEER_INVITATION_INFO</b> structure defines information about an invitation to join a peer group. Invitations
///are represented as Unicode strings. To obtain this structure, pass the XML invitation string created by
///PeerGroupCreateInvitation to PeerGroupParseInvitation.
struct PEER_INVITATION_INFO
{
    ///Specifies the size of this structure, in bytes.
    uint          dwSize;
    ///Must be set to 0x00000000.
    uint          dwFlags;
    ///Pointer to a Unicode string that specifies the PNRP cloud name.
    const(wchar)* pwzCloudName;
    ///Specifies the scope under which the peer group was registered. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PNRP_GLOBAL_SCOPE"></a><a id="pnrp_global_scope"></a><dl>
    ///<dt><b>PNRP_GLOBAL_SCOPE</b></dt> </dl> </td> <td width="60%"> Global scope, including the Internet. </td> </tr>
    ///<tr> <td width="40%"><a id="PNRP_LOCAL_SCOPE"></a><a id="pnrp_local_scope"></a><dl>
    ///<dt><b>PNRP_LOCAL_SCOPE</b></dt> </dl> </td> <td width="60%"> Local scope. </td> </tr> <tr> <td width="40%"><a
    ///id="PNRP_LINK_LOCAL_SCOPE"></a><a id="pnrp_link_local_scope"></a><dl> <dt><b>PNRP_LINK_LOCAL_SCOPE</b></dt> </dl>
    ///</td> <td width="60%"> Link-local scope. </td> </tr> </table>
    uint          dwScope;
    ///Specifies a set of flags that describe PNRP cloud features. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PNRP_CLOUD_NO_FLAGS"></a><a id="pnrp_cloud_no_flags"></a><dl>
    ///<dt><b>PNRP_CLOUD_NO_FLAGS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> No flags are set. </td> </tr> <tr>
    ///<td width="40%"><a id="PNRP_CLOUD_NAME_LOCAL"></a><a id="pnrp_cloud_name_local"></a><dl>
    ///<dt><b>PNRP_CLOUD_NAME_LOCAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The cloud name is not available on
    ///other computers; it is locally defined. </td> </tr> </table>
    uint          dwCloudFlags;
    ///Pointer to a Unicode string that specifies the peer name of the peer group.
    const(wchar)* pwzGroupPeerName;
    ///Pointer to a Unicode string that specifies the PNRP name of the peer issuing the invitation.
    const(wchar)* pwzIssuerPeerName;
    ///Pointer to a Unicode string that specifies the PNRP name of the peer that receives the invitation.
    const(wchar)* pwzSubjectPeerName;
    ///Pointer to a Unicode string that specifies the friendly (display) name of the peer group.
    const(wchar)* pwzGroupFriendlyName;
    ///Pointer to a Unicode string that specifies the friendly (display) name of the peer issuing the invitation.
    const(wchar)* pwzIssuerFriendlyName;
    ///Pointer to a Unicode string that specifies the friendly (display) name of the peer that receives the invitation.
    const(wchar)* pwzSubjectFriendlyName;
    ///Specifies a UTC <b>FILETIME</b> value that indicates when the invitation becomes valid.
    FILETIME      ftValidityStart;
    ///Specifies a UTC <b>FILETIME</b> value that indicates when the invitation becomes invalid.
    FILETIME      ftValidityEnd;
    ///Specifies the number of role GUIDs present in <b>pRoles</b>.
    uint          cRoles;
    ///Pointer to a list of GUIDs that specifies the combined set of available roles. The available roles are as
    ///follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PEER_GROUP_ROLE_ADMIN"></a><a id="peer_group_role_admin"></a><dl> <dt><b>PEER_GROUP_ROLE_ADMIN</b></dt> </dl>
    ///</td> <td width="60%"> This role can issue invitations, renew memberships, modify peer group properties, publish
    ///and update records, and renew the GMC of other administrators. </td> </tr> <tr> <td width="40%"><a
    ///id="PEER_GROUP_ROLE_MEMBER"></a><a id="peer_group_role_member"></a><dl> <dt><b>PEER_GROUP_ROLE_MEMBER</b></dt>
    ///</dl> </td> <td width="60%"> The role can publish records to the peer group database. </td> </tr> </table>
    GUID*         pRoles;
    ///Unsigned integer value that contains the number of string values listed in <b>ppwzClassifiers</b>. This field is
    ///reserved for future use.
    uint          cClassifiers;
    ///List of pointers to Unicode strings. This field is reserved for future use.
    ushort**      ppwzClassifiers;
    ///Pointer to a <b>CERT_PUBLIC_KEY_INFO</b> structure that contains the recipient's returned public key and the
    ///encryption algorithm type it uses.
    CERT_PUBLIC_KEY_INFO* pSubjectPublicKey;
    ///<b>Windows Vista or later.</b> The PEER_GROUP_AUTHENTICATION_SCHEME enumeration value that indicates the type of
    ///authentication used to validate the peer group invitee.
    PEER_GROUP_AUTHENTICATION_SCHEME authScheme;
}

///The <b>PEER_GROUP_PROPERTIES</b> structure contains data about the membership policy of a peer group.
struct PEER_GROUP_PROPERTIES
{
    ///Size of the structure, in bytes.
    uint          dwSize;
    ///PEER_GROUP_PROPERTY_FLAGS flags that describe the behavior of a peer group. The default value is zero (0), which
    ///indicates that flags are not set.
    uint          dwFlags;
    ///Specifies the name of the Peer Name Resolution Protocol (PNRP) cloud that a peer group participates in. The
    ///default value is "global", if this member is <b>NULL</b>.
    const(wchar)* pwzCloud;
    ///Specifies the classifier used to identify the authority of a peer group peer name for registration or resolution
    ///within a PNRP cloud. The maximum size of this field is 149 Unicode characters. This member can be <b>NULL</b>.
    const(wchar)* pwzClassifier;
    ///Specifies the name of a peer group that is registered with the PNRP service. The maximum size of this field is
    ///137 Unicode characters.
    const(wchar)* pwzGroupPeerName;
    ///Specifies the peer name associated with the Peer group creator. The maximum size of this field is 137 Unicode
    ///characters. If this structure member is <b>NULL</b>, the implementation uses the identity obtained from
    ///PeerIdentityGetDefault.
    const(wchar)* pwzCreatorPeerName;
    ///Specifies the friendly (display) name of a peer group. The maximum size of this field is 255 characters.
    const(wchar)* pwzFriendlyName;
    ///Contains a comment used to describe a peer group. The maximum size of this field is 255 characters.
    const(wchar)* pwzComment;
    ///Specifies the lifetime, in seconds, of peer group member data (PEER_MEMBER). The minimum value for this field is
    ///8 hours, and the maximum is 10 years. The default value is 2,419,200 seconds, or 28 days. If this value is set to
    ///zero (0), member data has the maximum allowable lifetime, which is the time remaining in the lifetime of the
    ///administrator who issues the credentials for a member.
    uint          ulMemberDataLifetime;
    ///Specifies the lifetime, in seconds, of presence information published to a peer group. The default value is 300
    ///seconds. Do not set the value of <b>ulPresenceLifetime</b> to less than 300 seconds. If this member is set to
    ///less than the 300–second default value, then undefined behavior can occur.
    uint          ulPresenceLifetime;
    ///<b>Windows Vista or later.</b> Logical OR of PEER_GROUP_AUTHENTICATION_SCHEME enumeration values that indicate
    ///the types of authentication supported by the peer group.
    uint          dwAuthenticationSchemes;
    ///<b>Windows Vista or later.</b> Pointer to a Unicode string that contains the password used to authenticate peers
    ///attempting to join the peer group.
    const(wchar)* pwzGroupPassword;
    ///<b>Windows Vista or later.</b> GUID value that indicates the peer group role for which the password is required
    ///for authentication.
    GUID          groupPasswordRole;
}

///The <b>PEER_EVENT_MEMBER_CHANGE_DATA</b> structure contains data that describes a change in the status of a peer
///group member.
struct PEER_EVENT_MEMBER_CHANGE_DATA
{
    ///Contains the size of this structure, in bytes.
    uint          dwSize;
    ///<b>PEER_MEMBER_CHANGE_TYPE</b> enumeration value that specifies the change event that occurred, such as a member
    ///joining or leaving.
    PEER_MEMBER_CHANGE_TYPE changeType;
    ///Pointer to a Unicode string that contains the peer name of the peer group member.
    const(wchar)* pwzIdentity;
}

///The <b>PEER_GROUP_EVENT_REGISTRATION</b> structure defines the particular peer group event a member can register for.
struct PEER_GROUP_EVENT_REGISTRATION
{
    ///PEER_GROUP_EVENT_TYPE that specifies the peer group event type to register for.
    PEER_GROUP_EVENT_TYPE eventType;
    ///GUID value that identifies the type of record or data message that raises an event of the type specified by
    ///<b>eventType</b>. For example, if the peer wishes to be notified about all changes to a specific record type, the
    ///GUID that corresponds to this record type must be supplied in this field and PEER_GROUP_RECORD_CHANGED must be in
    ///<b>eventType</b>. This member is only populated (not NULL) when <b>eventType</b> is either
    ///PEER_GROUP_EVENT_RECORD_CHANGED or PEER_GROUP_EVENT_INCOMING_DATA.
    GUID* pType;
}

///The <b>PEER_GROUP_EVENT_DATA</b> structure contains information about a specific peer group event that has occurred.
struct PEER_GROUP_EVENT_DATA
{
    ///PEER_GROUP_EVENT_TYPE enumeration value that specifies the type of peer group event that occurred. The type of
    ///event dictates the subsequent structure chosen from the union; for example, if this value is set to
    ///PEER_GROUP_EVENT_INCOMING_DATA, the populated union member is <b>incomingData</b>.
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

///The <b>PEER_NAME_PAIR</b> structure contains the results of a call to PeerGetNextItem.
struct PEER_NAME_PAIR
{
    ///Specifies the size, in bytes, of this structure.
    uint          dwSize;
    ///Specifies the peer name of the peer identity or peer group.
    const(wchar)* pwzPeerName;
    ///Specifies the friendly name of the peer identity or peer group.
    const(wchar)* pwzFriendlyName;
}

///The <b>PEER_APPLICATION</b> structure contains data describing a locally installed software application or component
///that can be registered and shared with trusted contacts within a peer collaboration network.
struct PEER_APPLICATION
{
    ///The GUID value under which the application is registered with the local computer.
    GUID          id;
    ///PEER_DATA structure that contains the application information in a member byte buffer. This information is
    ///available to anyone who can query for the local peer's member information. This data is limited to 16K.
    PEER_DATA     data;
    ///Pointer to a zero-terminated Unicode string that contains an optional description of the local application. This
    ///description is limited to 255 unicode characters.
    const(wchar)* pwzDescription;
}

///The <b>PEER_OBJECT</b> structure contains application-specific run-time information that can be shared with trusted
///contacts within a peer collaboration network.
struct PEER_OBJECT
{
    ///GUID value under which the peer object is uniquely registered.
    GUID      id;
    ///PEER_DATA structure that contains information which describes the peer object.
    PEER_DATA data;
    ///PEER_PUBLICATION_SCOPE enumeration value that specifies the publication scope for this peer object.
    uint      dwPublicationScope;
}

///The <b>PEER_CONTACT</b> structure contains information about a specific contact.
struct PEER_CONTACT
{
    ///Zero-terminated Unicode string that contains the peer name of the contact. This is the unique identifier for a
    ///contact. There can only be a single contact associated with any given peername.
    const(wchar)* pwzPeerName;
    ///Zero-terminated Unicode string that contains the nickname of the contact and can be modified at any time. This is
    ///used when the peer collaboration scope is set to People Near Me. It is advertised in People Near Me and seen by
    ///recipients of sent invitations. This member is limited to 255 unicode characters.
    const(wchar)* pwzNickName;
    ///Zero-terminated Unicode string that contains the display name of the contact. This corresponds to the display
    ///name seen for the contact in a peer's contacts folder. This member is limited to 255 unicode characters.
    const(wchar)* pwzDisplayName;
    ///Zero-terminated Unicode string that contains the email address of the contact.
    const(wchar)* pwzEmailAddress;
    ///If true, the contact is watched by the peer; if false, it is not.
    BOOL          fWatch;
    ///PEER_WATCH_PERMISSION enumeration value that specifies the watch permissions for this contact.
    PEER_WATCH_PERMISSION WatcherPermissions;
    ///PEER_DATA structure that contains the security credentials for the contact in an opaque byte buffer.
    PEER_DATA     credentials;
}

///The <b>PEER_ENDPOINT</b> structure contains the address and friendly name of a peer endpoint.
struct PEER_ENDPOINT
{
    ///PEER_ADDRESS structure that contains the IPv6 network address of the endpoint.
    PEER_ADDRESS  address;
    ///Zero-terminated Unicode string that contains the specific displayable name of the endpoint.
    const(wchar)* pwzEndpointName;
}

///The <b>PEER_PEOPLE_NEAR_ME</b> structure contains information about a peer in the same logical or virtual subnet.
struct PEER_PEOPLE_NEAR_ME
{
    ///Zero-terminated Unicode string that contains the nickname of the contact.
    const(wchar)* pwzNickName;
    ///PEER_ENDPOINT structure that contains the IPv6 network address of the peer whose endpoint shares the same subnet.
    PEER_ENDPOINT endpoint;
    ///GUID value that contains the unique ID value for this peer. Since this value uniquely identifies a peer endpoint,
    ///the display name and even the associated IPv6 address can be changed with deleting the rest of the peer
    ///information.
    GUID          id;
}

///The <b>PEER_INVITATION</b> structure contains a request to initiate or join a peer collaboration activity.
struct PEER_INVITATION
{
    ///GUID value that uniquely identifies the registered software or software component for the peer collaboration
    ///activity.
    GUID          applicationId;
    ///PEER_DATA structure that contains opaque data describing possible additional application-specific settings (for
    ///example, an address and port on which the activity will occur, or a specific video codec to use). This data is
    ///limited to 16K.
    PEER_DATA     applicationData;
    ///Zero-terminated Unicode string that contains a specific request message to the invitation recipient. The message
    ///is limited to 255 unicode characters.
    const(wchar)* pwzMessage;
}

///The <b>PEER_INVITATION_RESPONSE</b> structure contains a response to an invitation to join a peer collaboration
///activity.
struct PEER_INVITATION_RESPONSE
{
    ///[PEER_INVITATION_RESPONSE_TYPE](./ne-p2p-peer_invitation_response_type.md) enumeration value that specifies the
    ///action the peer takes in response to the invitation.
    PEER_INVITATION_RESPONSE_TYPE action;
    ///Reserved. This member must be set to <b>NULL</b>, and is set exclusively by the Peer Collaboration
    ///infrastructure.
    const(wchar)* pwzMessage;
    ///Any extended information that is part of the response. This can include an error code corresponding to the
    ///failure on the recipient of the invitation.
    HRESULT       hrExtendedInfo;
}

///The <b>PEER_APP_LAUNCH_INFO</b> structure contains the peer application application launch information provided by a
///contact in a previous peer invite request.
struct PEER_APP_LAUNCH_INFO
{
    ///Pointer to a PEER_CONTACT structure that contains information about the contact that sent the request to the
    ///local peer to launch the application referenced by the application.
    PEER_CONTACT*    pContact;
    ///Pointer to a PEER_ENDPOINT structure that contains information about the specific endpoint of the contact that
    ///sent the request to the local peer to launch the application referenced by the application
    PEER_ENDPOINT*   pEndpoint;
    ///Pointer to the PEER_INVITATION structure that contains the invitation to launch a specific peer application
    ///application on the local peer.
    PEER_INVITATION* pInvitation;
}

///The <b>PEER_APPLICATION_REGISTRATION_INFO</b> structure contains peer application information for registration with
///the local computer.
struct PEER_APPLICATION_REGISTRATION_INFO
{
    ///PEER_APPLICATION structure that contains the specific peer application data.
    PEER_APPLICATION application;
    ///Zero-terminated Unicode string that contains the local path to the executable peer application. Note that this
    ///data is for local use only and that this structure is never transmitted remotely.
    const(wchar)*    pwzApplicationToLaunch;
    ///Zero-terminated Unicode string that contains command-line arguments that must be supplied to the application when
    ///the application is launched. This data is for local use only. The PEER_APPLICATION_REGISTRATION_INFO structure is
    ///never transmitted remotely.
    const(wchar)*    pwzApplicationArguments;
    ///PEER_PUBLICATION_SCOPE enumeration value that specifies the publication scope for this application registration
    ///information. The only valid value for this member is PEER_PUBLICATION_SCOPE_INTERNET.
    uint             dwPublicationScope;
}

///The <b>PEER_PRESENCE_INFO</b> structure contains specific peer presence information.
struct PEER_PRESENCE_INFO
{
    ///PEER_PRESENCE_STATUS enumeration value that indicates the current availability or level of participation by the
    ///peer in a peer collaboration network.
    PEER_PRESENCE_STATUS status;
    ///Zero-terminated Unicode string that contains a user- or application-defined message that expands upon the current
    ///status value. This string is limited to 255 characters.
    const(wchar)*        pwzDescriptiveText;
}

///The <b>PEER_COLLAB_EVENT_REGISTRATION</b> structure contains the data used by a peer to register for specific peer
///collaboration network events.
struct PEER_COLLAB_EVENT_REGISTRATION
{
    ///PEER_COLLAB_EVENT_TYPE enumeration value that specifies the type of peer collaboration network event for which to
    ///register.
    PEER_COLLAB_EVENT_TYPE eventType;
    ///GUID value that uniquely identifies the application or object that registers for the specific event. This
    ///parameter is valid only for PEER_EVENT_ENDPOINT_APPLICATION_CHANGED, PEER_EVENT_ENDPOINT_OBJECT_CHANGED,
    ///PEER_EVENT_MY_APPLICATION_CHANGED, and PEER_EVENT_MY_OBJECT_CHANGED. This GUID represents the application ID for
    ///application-specific events, and the object ID for object-specific events. When <b></b>this member is set,
    ///notification will be sent only for the specific application or object.
    GUID* pInstance;
}

///The <b>PEER_EVENT_WATCHLIST_CHANGED_DATA</b> structure contains information returned when a
///PEER_EVENT_WATCHLIST_CHANGED event is raised on a peer participating in a peer collaboration network.
struct PEER_EVENT_WATCHLIST_CHANGED_DATA
{
    ///Pointer to a PEER_CONTACT structure that contains information about the peer contact in the watchlist whose
    ///change raised the event.
    PEER_CONTACT*    pContact;
    ///PEER_CHANGE_TYPE enumeration value that specifies the type of change that occurred in the peer's watchlist.
    PEER_CHANGE_TYPE changeType;
}

///The <b>PEER_EVENT_PRESENCE_CHANGED_DATA</b> structure contains information returned when a
///PEER_EVENT_ENDPOINT_PRESENCE_CHANGED or PEER_EVENT_MY_PRESENCE_CHANGED event is raised on a peer participating in a
///peer collaboration network.
struct PEER_EVENT_PRESENCE_CHANGED_DATA
{
    ///Pointer to a PEER_CONTACT structure that contains the peer contact information for the contact whose change in
    ///presence raised the event.
    PEER_CONTACT*       pContact;
    ///Pointer to a PEER_ENDPOINT structure that contains the peer endpoint information for the contact whose change in
    ///presence raised the event.
    PEER_ENDPOINT*      pEndpoint;
    ///PEER_CHANGE_TYPE enumeration value that specifies the type of presence change that occurred.
    PEER_CHANGE_TYPE    changeType;
    ///Pointer to a PEER_PRESENCE_INFO structure that contains the updated presence information for the endpoint of the
    ///contact whose change in presence raised the event.
    PEER_PRESENCE_INFO* pPresenceInfo;
}

///The <b>PEER_EVENT_APPLICATION_CHANGED_DATA</b> structure contains information returned when a
///PEER_EVENT_ENDPOINT_APPLICATION_CHANGED or PEER_EVENT_MY_APPLICATION_CHANGED event is raised on a peer participating
///in a peer collaboration network.
struct PEER_EVENT_APPLICATION_CHANGED_DATA
{
    ///Pointer to a PEER_CONTACT structure that contains the peer contact information for a contact whose change in
    ///application raised the event.
    PEER_CONTACT*     pContact;
    ///Pointer to a PEER_ENDPOINT structure that contains the peer endpoint information for a contact whose change in
    ///application information raised the event.
    PEER_ENDPOINT*    pEndpoint;
    ///PEER_CHANGE_TYPE enumeration value that specifies the type of application change that occurred.
    PEER_CHANGE_TYPE  changeType;
    ///Pointer to a PEER_APPLICATION structure that contains the changed application information.
    PEER_APPLICATION* pApplication;
}

///The <b>PEER_EVENT_OBJECT_CHANGED_DATA</b> structure contains information returned when a
///PEER_EVENT_ENDPOINT_OBJECT_CHANGED or PEER_EVENT_MY_OBJECT_CHANGED event is raised on a peer participating in a peer
///collaboration network.
struct PEER_EVENT_OBJECT_CHANGED_DATA
{
    ///Pointer to a PEER_CONTACT structure that contains the peer contact information for the contact whose peer object
    ///data changed.
    PEER_CONTACT*    pContact;
    ///Pointer to a PEER_ENDPOINT structure that contains the peer endpoint information for the contact whose peer
    ///object data changed.
    PEER_ENDPOINT*   pEndpoint;
    ///PEER_CHANGE_TYPE enumeration value that specifies the type of change that occurred.
    PEER_CHANGE_TYPE changeType;
    ///Pointer to a PEER_OBJECT structure that contains the peer object data whose change raised the event. This most
    ///commonly occurs when a new peer object is received by the peer.
    PEER_OBJECT*     pObject;
}

///The <b>PEER_EVENT_ENDPOINT_CHANGED_DATA</b> structure contains information returned when a
///PEER_EVENT_ENDPOINT_CHANGED or PEER_EVENT_MY_ENDPOINT_CHANGED event is raised on a peer participating in a peer
///collaboration network.
struct PEER_EVENT_ENDPOINT_CHANGED_DATA
{
    ///Pointer to a PEER_CONTACT structure that contains the contact information for the contact who changed endpoints.
    PEER_CONTACT*  pContact;
    ///Pointer to a PEER_ENDPOINT structure that contains the new active endpoint for the peer specified in
    ///<i>pContact</i>.
    PEER_ENDPOINT* pEndpoint;
}

///The <b>PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA</b> structure contains information returned when a
///PEER_EVENT_PEOPLE_NEAR_ME_CHANGED event is raised on a peer participating in a subnet-specific peer collaboration
///network.
struct PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA
{
    ///PEER_CHANGE_TYPE enumeration value that describes the type of change that occurred for a contact available on the
    ///local subnet.
    PEER_CHANGE_TYPE     changeType;
    ///Pointer to a PEER_PEOPLE_NEAR_ME structure that contains the peer endpoint information for the contact on the
    ///subnet that raised the change event.
    PEER_PEOPLE_NEAR_ME* pPeopleNearMe;
}

///The <b>PEER_EVENT_REQUEST_STATUS_CHANGED_DATA</b> structure contains information returned when a
///PEER_EVENT_REQUEST_STATUS_CHANGED event is raised on a peer participating in a peer collaboration network.
struct PEER_EVENT_REQUEST_STATUS_CHANGED_DATA
{
    ///Pointer to a PEER_ENDPOINT structure that contains the peer endpoint information for the contact whose change in
    ///request status raised the event.
    PEER_ENDPOINT* pEndpoint;
    ///HRESULT value that indicates the change in request status that occurred.
    HRESULT        hrChange;
}

///The <b>PEER_COLLAB_EVENT_DATA</b> union contains variant data for each possible peer collaboration network event
///raised on a peer.
struct PEER_COLLAB_EVENT_DATA
{
    ///PEER_COLLAB_EVENT_TYPE enumeration value that contains the type of the event whose corresponding data structure
    ///appears in the subsequent union arm.
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

///The <b>PEER_PNRP_ENDPOINT_INFO</b> structure contains the IP addresses and data associated with a peer endpoint.
struct PEER_PNRP_ENDPOINT_INFO
{
    ///The peer name associated with this peer endpoint.
    const(wchar)* pwzPeerName;
    ///The number of SOCKADDR structures in <b>pAddresses</b>.
    uint          cAddresses;
    ///Pointer to an array of pointers to SOCKADDR structures that contain the IP addresses for the peer endpoint's
    ///network interface.
    SOCKADDR**    ppAddresses;
    ///Pointer to a zero-terminated Unicode string that contains a comment for this peer endpoint.
    const(wchar)* pwzComment;
    PEER_DATA     payload;
}

///The <b>PEER_PNRP_CLOUD_INFO</b> structure contains information about a Peer Name Resolution Protocol (PNRP) cloud.
struct PEER_PNRP_CLOUD_INFO
{
    ///Pointer to a zero-terminated Unicode string that contains the name of the PNRP cloud. The maximum size of this
    ///name is 256 characters.
    const(wchar)* pwzCloudName;
    ///Constant value that specifies the network scope of the PNRP cloud. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="PNRP_SCOPE_ANY"></a><a id="pnrp_scope_any"></a><dl>
    ///<dt><b>PNRP_SCOPE_ANY</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> All IP addresses are allowed to register
    ///with the PNRP cloud. </td> </tr> <tr> <td width="40%"><a id="PNRP_GLOBAL_SCOPE"></a><a
    ///id="pnrp_global_scope"></a><dl> <dt><b>PNRP_GLOBAL_SCOPE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The
    ///scope is global; all valid IP addresses are allowed to register with the PNRP cloud. </td> </tr> <tr> <td
    ///width="40%"><a id="PNRP_SITE_LOCAL_SCOPE"></a><a id="pnrp_site_local_scope"></a><dl>
    ///<dt><b>PNRP_SITE_LOCAL_SCOPE</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The scope is site-local; only IP
    ///addresses defined for the site are allowed to register with the PNRP cloud. </td> </tr> <tr> <td width="40%"><a
    ///id="PNRP_LINK_LOCAL_SCOPE"></a><a id="pnrp_link_local_scope"></a><dl> <dt><b>PNRP_LINK_LOCAL_SCOPE</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The scope is link-local; only IP addresses defined for the local area
    ///network are allowed to register with the PNRP cloud. </td> </tr> </table>
    PNRP_SCOPE    dwScope;
    uint          dwScopeId;
}

///The <b>PEER_PNRP_REGISTRATION_INFO</b> structure contains the information provided by a peer identity when it
///registers with a PNRP cloud.
struct PEER_PNRP_REGISTRATION_INFO
{
    ///Pointer to a Unicode string that contains the name of the PNRP cloud for which this peer identity is requesting
    ///registration. If <b>NULL</b>, the registration will be made in all clouds. It is possible to use the special
    ///value PEER_PNRP_ALL_LINK_CLOUDS to register in all link local clouds.
    const(wchar)* pwzCloudName;
    ///Pointer to a Unicode string that contains the name of the peer identity requesting registration.
    const(wchar)* pwzPublishingIdentity;
    ///The number of SOCKADDR structures in <b>ppAddresses</b>. It is possible to use the special value
    ///PEER_PNRP_AUTO_ADDRESSES to have the infrastructure automatically choose addresses.
    uint          cAddresses;
    ///Pointer to an array of pointers to SOCKADDR structures that contain the IP addresses bound to the network
    ///interface of the peer identity requesting registration.
    SOCKADDR**    ppAddresses;
    ///The network interface port assigned to the address that the peer is publishing.
    ushort        wPort;
    ///Pointer to a zero-terminated Unicode string that contains a comment for this peer endpoint.
    const(wchar)* pwzComment;
    PEER_DATA     payload;
}

///The <b>DRT_DATA</b> structure contains a data blob. This structure is used by several DRT functions.
struct DRT_DATA
{
    ///The number of bytes.
    uint   cb;
    ubyte* pb;
}

///The <b>DRT_REGISTRATION</b> structure contains key and application data that make up a registration.
struct DRT_REGISTRATION
{
    ///Contains the key portion of the registration.
    DRT_DATA key;
    ///The application data associated with the key. The DRT_DATA structure containing this application data must point
    ///to a buffer less than 4KB in size.
    DRT_DATA appData;
}

///The <b>DRT_SECURITY_PROVIDER</b> structure defines the DRT interface that must be implemented by a security provider.
struct DRT_SECURITY_PROVIDER
{
    ///This member is specified by the application when passing the <b>DRT_SECURITY_PROVIDER</b> structure to the
    ///DrtOpen function. The DRT treats it as an opaque pointer, and passes it as the first parameter to the functions
    ///referenced by this structure. An application will use this as a pointer to the security provider state or to the
    ///object that implements the security provider functionality.
    void*            pvContext;
    ///Increments the count of references for the Security Provider with a set of DRTs.
    HRESULT********* Attach;
    ///Decrements the count of references for the Security Provider with a set of DRTs.
    ptrdiff_t        Detach;
    ///Called to register a key with the Security Provider.
    HRESULT********* RegisterKey;
    ///Called to deregister a key with the Security Provider.
    HRESULT********* UnregisterKey;
    ///Called when an Authority message is received on the wire. It is responsible for validating the data received, and
    ///for unpacking the service addresses, revoked flag, and nonce from the Secured Address Payload.
    HRESULT********* ValidateAndUnpackPayload;
    ///Called when an Authority message is about to be sent on the wire. It is responsible for securing the data before
    ///it is sent, and for packing the service addresses, revoked flag, nonce, and other application data into the
    ///Secured Address Payload.
    HRESULT********* SecureAndPackPayload;
    ///Called to release resources previously allocated for a security provider function.
    ptrdiff_t        FreeData;
    ///Called when the DRT sends a message containing data that must be encrypted. This function is only called when the
    ///DRT is operating in the <b>DRT_SECURE_CONFIDENTIALPAYLOAD</b> security mode defined by DRT_SECURITY_MODE.
    HRESULT********* EncryptData;
    ///Called when the DRT receives a message containing encrypted data. This function is only called when the DRT is
    ///operating in the <b>DRT_SECURE_CONFIDENTIALPAYLOAD</b> security mode defined by DRT_SECURITY_MODE.
    HRESULT********* DecryptData;
    ///Called when the DRT must provide a credential used to authorize the local node. This function is only called when
    ///the DRT is operating in the <b>DRT_SECURE_MEMBERSHIP</b> and <b>DRT_SECURE_CONFIDENTIALPAYLOAD</b> security modes
    ///defined by DRT_SECURITY_MODE.
    HRESULT********* GetSerializedCredential;
    ///Called when the DRT must validate a credential provided by a peer node.
    HRESULT********* ValidateRemoteCredential;
    ///Called when the DRT must sign a data blob for inclusion in a DRT protocol message. This function is only called
    ///when the DRT is operating in the <b>DRT_SECURE_MEMBERSHIP</b> and <b>DRT_SECURE_CONFIDENTIALPAYLOAD</b> security
    ///modes defined by DRT_SECURITY_MODE.
    HRESULT********* SignData;
    ///Called when the DRT must verify a signature calculated over a block of data included in a DRT message. This
    ///function is only called when the DRT is operating in the <b>DRT_SECURE_MEMBERSHIP</b> and
    ///<b>DRT_SECURE_CONFIDENTIALPAYLOAD</b> security modes defined by DRT_SECURITY_MODE.
    HRESULT********* VerifyData;
}

///The <b>DRT_BOOTSTRAP_PROVIDER</b> structure defines the DRT interface that must be implemented by a bootstrap
///provider. <div class="alert"><b>Note</b> The DRT infrastructure does not call the methods of the bootstrap provider
///concurrently.</div><div> </div>
struct DRT_BOOTSTRAP_PROVIDER
{
    ///Pointer to context data that is defined by the bootstrap resolver. When creating a bootstrap resolver, the
    ///developer is required to populate the resolver with the required information; often times, this occurs as a
    ///"this" pointer. This context gets passed to all the context parameters in the functions defined by the
    ///<b>DRT_BOOTSTRAP_PROVIDER</b>.
    void*            pvContext;
    ///Increments the count of references for the Bootstrap Provider with a set of DRTs.
    HRESULT********* Attach;
    ///Decrements the count of references for the Bootstrap Provider with a set of DRTs.
    ptrdiff_t        Detach;
    ///Called by the DRT infrastructure to supply configuration information about upcoming name resolutions.
    HRESULT********* InitResolve;
    ///Called by the DRT infrastructure to issue a resolution to determine the endpoints of nodes already active in the
    ///DRT cloud.
    HRESULT********* IssueResolve;
    ///Ends the resolution of an endpoint.
    ptrdiff_t        EndResolve;
    ///Registers an endpoint with the bootstrapping mechanism. This process makes it possible for other nodes find the
    ///endpoint via the bootstrap resolver.
    HRESULT********* Register;
    ///This function deregisters an endpoint with the bootstrapping mechanism. As a result, other nodes will be unable
    ///to find the local node via the bootstrap resolver.
    ptrdiff_t        Unregister;
}

///The <b>DRT_SETTINGS</b> structure contains the settings utilized by the local Distributed Routing Table.
struct DRT_SETTINGS
{
    ///The size of the structure specified by the <i>sizeof</i> parameter found in <b>DRT_SETTINGS</b> with the purpose
    ///of allowing new fields in the structure in future versions of the DRT API.
    uint              dwSize;
    ///Specifies the exact number of bytes for keys in this DRT instance. Currently only 8 bytes are supported. Any
    ///other values will return <b>E_INVALIDARG</b> via the DrtOpen function.
    uint              cbKey;
    ///Pointer to the byte array that represents the protocol major version specified by the application. This is packed
    ///in every DRT packet to identify the version of the Security or Bootstrap Providers in use when a single DRT
    ///instance is supporting multiple Security or Bootstrap Providers.
    ubyte             bProtocolMajorVersion;
    ///Pointer to the byte array that represents the protocol minor version specified by the application. This is packed
    ///in every DRT packet to identify the version of the Security or Bootstrap Providers in use when a single DRT
    ///instance is supporting multiple Security or Bootstrap Providers.
    ubyte             bProtocolMinorVersion;
    ///Specifies the maximum number of address the DRT registers when an application registers a key. The maximum value
    ///for this field is 4.
    uint              ulMaxRoutingAddresses;
    ///This string forms the basis of the name of the DRT instance. The name of the instance can be used to locate the
    ///Windows performance counters associated with it.
    const(wchar)*     pwzDrtInstancePrefix;
    ///Handle to a transport created by the transport creation API. This is used to open a DRT with a transport
    ///specified by the <b>DRT_SETTINGS</b> structure. Currently only IPv6 UDP is supported via
    ///DrtCreateIpv6UdpTransport.
    void*             hTransport;
    ///Pointer to the security provider specified for use. An instance of the Derived Key Security Provider can be
    ///obtained by calling DrtCreateDerivedKeySecurityProvider.
    DRT_SECURITY_PROVIDER* pSecurityProvider;
    ///Pointer to the Bootstrap Provider specified for use. An instance of the PNRP Bootstrap Provider can be obtained
    ///by calling DrtCreatePnrpBootstrapResolver.
    DRT_BOOTSTRAP_PROVIDER* pBootstrapProvider;
    ///Specifies the security mode that the DRT should operate under. All nodes participating in a DRT mesh must use the
    ///same security mode.
    DRT_SECURITY_MODE eSecurityMode;
}

///The <b>DRT_SEARCH_INFO</b> structure represents a search query issued with DrtStartSearch.
struct DRT_SEARCH_INFO
{
    ///Specifies the byte count of <b>DRT_SEARCH_INFO</b>.
    uint      dwSize;
    ///Indicates whether the search is iterative. If set to <b>TRUE</b>, the search is iterative.
    BOOL      fIterative;
    ///Indicates whether search results can contain matches found in the local DRT instance. If set to <b>TRUE</b>, the
    ///search results are capable of containing matches found in the local DRT instance.
    BOOL      fAllowCurrentInstanceMatch;
    ///If set to <b>true</b>, the search will stop locating the first key falling within the specified range. Otherwise,
    ///the search for the closest match to the target key specified by DrtStartSearch will continue.
    BOOL      fAnyMatchInRange;
    ///Specifies the number of results to return. This includes closest and exact matches. If this value is greater than
    ///1 when <b>fIterative</b> is <b>TRUE</b>, the search will only return 1 result.
    uint      cMaxEndpoints;
    ///Specifies the numerically largest key value the infrastructure should attempt to match.
    DRT_DATA* pMaximumKey;
    ///Specifies the numerically smallest key value the infrastructure should attempt to match.
    DRT_DATA* pMinimumKey;
}

///The <b>DRT_ADDRESS</b> structure contains endpoint information about a DRT node that participated in a search. This
///information is intended for use in debugging connectivity problems.
struct DRT_ADDRESS
{
    ///Contains the endpoint on which the DRT protocol is listening on the remote node.
    SOCKADDR_STORAGE_LH socketAddress;
    ///Holds information explaining how this node behaved in the key lookup.
    uint                flags;
    ///Contains the number of bits that the key published by this node shares in common with the target key in the
    ///search.
    int                 nearness;
    ///Round trip time to this node.
    uint                latency;
}

///The <b>DRT_ADDRESS_LIST</b> structure contains a set of DRT_ADDRESS structures that represent the nodes contacted
///during a search for a key.
struct DRT_ADDRESS_LIST
{
    ///The count of entries in <b>AddressList</b>.
    uint           AddressCount;
    ///An array of DRT_ADDRESS structures that contain information about addresses that participated in the search
    ///operation.
    DRT_ADDRESS[1] AddressList;
}

///The <b>DRT_SEARCH_RESULT</b> contains the registration entry and the type of match of the search result returned by
///DrtGetSearchResult when the <i>hEvent</i> passed into DrtStartSearch is signaled.
struct DRT_SEARCH_RESULT
{
    ///The size of the <b>DRT_SEARCH_RESULT</b> structure.
    uint             dwSize;
    ///Specifies the exactness of the search. This member corresponds to the DRT_MATCH_TYPE enumeration.
    DRT_MATCH_TYPE   type;
    ///Pointer to the context data passed to the DrtStartSearch API.
    void*            pvContext;
    ///Contains the registration result.
    DRT_REGISTRATION registration;
}

///The <b>DRT_EVENT_DATA</b> structure contains the event data returned by calling DrtGetEventData after an application
///receives an event signal on the <i>hEvent</i> passed into DrtOpen. Contains an unnamed union that contains a
///structure that defines a change in the leaf set, the state of a locally registered key, or the state of the local DRT
///instance.
struct DRT_EVENT_DATA
{
    ///A DRT_EVENT_TYPE enumeration that specifies the event type.
    DRT_EVENT_TYPE type;
    ///The HRESULT of the operation for which the event was signaled that indicates if a result is the last result
    ///within a search.
    HRESULT        hr;
    ///Pointer to the context data passed to the API that generated the event. For example, if data is passed into the
    ///<i>pvContext</i> parameter of DrtOpen, that data is returned through this field.
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

///The <b>PEERDIST_PUBLICATION_OPTIONS</b> structure contains publication options, including the API version information
///and possible option flags.
struct PEERDIST_PUBLICATION_OPTIONS
{
    ///The following possible values reflect the version number of the client: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Version 1.0 </td> </tr>
    ///<tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Version 2.0 </td> </tr> </table>
    uint dwVersion;
    uint dwFlags;
}

///The <b>PEERDIST_CONTENT_TAG</b> structure contains a client supplied content tag as an input to the
///PeerDistClientOpenContent API.
struct PEERDIST_CONTENT_TAG
{
    ///A 16 byte tag associated with the open content.
    ubyte[16] Data;
}

///The <b>PEER_RETRIEVAL_OPTIONS</b> structure contains version of the content information to retrieve.
struct PEERDIST_RETRIEVAL_OPTIONS
{
    ///Specifies the size of the input structure.
    uint cbSize;
    ///Specifies the minimum version of the content information to retrieve. Must be set to one of the following values:
    ///<a id="PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION"></a> <a
    ///id="peerdist_retrieval_options_contentinfo_version"></a>
    uint dwContentInfoMinVersion;
    ///Specifies the maximum version of the content information to retrieve. Must be set to one of the following values:
    ///<a id="PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION"></a> <a
    ///id="peerdist_retrieval_options_contentinfo_version"></a>
    uint dwContentInfoMaxVersion;
    ///Reserved. The <b>dwReserved</b> member should be set to 0.
    uint dwReserved;
}

///The <b>PEERDIST_STATUS_INFO</b> structure contains information about the current status and capabilities of the
///BranchCache service on the local computer.
struct PEERDIST_STATUS_INFO
{
    ///Size, in bytes, of the <b>PEERDIST_STATUS_INFO</b> structure.
    uint            cbSize;
    ///Specifies the current status of the BranchCache service. This member should be one of following values defined in
    ///the PEERDIST_STATUS enumeration.
    PEERDIST_STATUS status;
    ///Specifies the minimum version of the content information format supported by the BranchCache service on the local
    ///machine. This member must be set to one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_1"></a><a
    ///id="peerdist_retrieval_options_contentinfo_version_1"></a><dl>
    ///<dt><b>PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_1</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Windows
    ///7 compatible content information format. </td> </tr> <tr> <td width="40%"><a
    ///id="PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_2"></a><a
    ///id="peerdist_retrieval_options_contentinfo_version_2"></a><dl>
    ///<dt><b>PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_2</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Windows
    ///8 content information format. </td> </tr> </table>
    uint            dwMinVer;
    ///Specifies the maximum version of the content information format supported by the BranchCache service on the local
    ///machine. This member must be set to one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_1"></a><a
    ///id="peerdist_retrieval_options_contentinfo_version_1"></a><dl>
    ///<dt><b>PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_1</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Windows
    ///7 compatible content information format. </td> </tr> <tr> <td width="40%"><a
    ///id="PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_2"></a><a
    ///id="peerdist_retrieval_options_contentinfo_version_2"></a><dl>
    ///<dt><b>PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_2</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Windows
    ///8 content information format. </td> </tr> </table>
    uint            dwMaxVer;
}

///The <b>PEERDIST_CLIENT_BASIC_INFO</b> structure indicates whether or not there are many clients simultaneously
///downloading the same content.
struct PEERDIST_CLIENT_BASIC_INFO
{
    ///Indicates that a "flash crowd" situation has been detected, where many clients in the branch office are
    ///simultaneously downloading the same content.
    BOOL fFlashCrowd;
}

// Functions

///The <b>PeerGraphStartup</b> function indicates to the Peer Graphing Infrastructure what version of the Peer protocols
///the calling application requires. <b>PeerGraphStartup</b> must be called before any other peer graphing functions. It
///must be matched by a call to PeerGraphShutdown.
///Params:
///    wVersionRequested = Specify PEER_GRAPH_VERSION.
///    pVersionData = Pointer to a PEER_VERSION_DATA structure that receives the version of the Peer Infrastructure installed on the
///                   local computer.
///Returns:
///    Returns S_OK if the operation succeeds; otherwise, the function returns one of the following values: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to perform the specified operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_UNSUPPORTED_VERSION</b></dt> </dl> </td> <td width="60%"> The version requested
///    is not supported by the Peer Infrastructure .dll installed on the local computer. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

///The <b>PeerGraphShutdown</b> function cleans up any resources allocated by the call to PeerGraphStartup. There must
///be a call to <b>PeerGraphShutdown</b> for each call to <b>PeerGraphStartup</b>.
///Returns:
///    Returns S_OK if the operation succeeds; otherwise, the function returns the one of the standard error codes
///    defined in WinError.h, or the function returns the following value: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The peer graph must be initialized with a call to PeerGraphStartup before using this function. </td>
///    </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphShutdown();

///The <b>PeerGraphFreeData</b> function frees resources that several of the Peer Graphing API functions return.
///Params:
///    pvData = Pointer to an item to free.
///Returns:
///    This function does not have return values.
///    
@DllImport("P2PGRAPH")
void PeerGraphFreeData(void* pvData);

///The <b>PeerGraphGetItemCount</b> function retrieves the number of items in an enumeration.
///Params:
///    hPeerEnum = Handle to a peer graph.
///    pCount = Receives a pointer to the number of records in an enumeration.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns the following value.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt>
///    </dl> </td> <td width="60%"> A peer graph must be initialized with a call to PeerGraphStartup before using this
///    function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphGetItemCount(void* hPeerEnum, uint* pCount);

///The <b>PeerGraphGetNextItem</b> function obtains the next item or items in an enumeration created by a call to the
///following functions, which return a peer enumeration handle: <ul> <li> PeerGraphEnumConnections </li> <li>
///PeerGraphEnumNodes </li> <li> PeerGraphEnumRecords </li> <li> PeerGraphSearchRecords </li> </ul>
///Params:
///    hPeerEnum = Handle to an enumeration.
///    pCount = Input specifies the number of items to obtain. Output receives the actual number of items obtained. <div
///             class="alert"><b>Note</b> If <i>pCount</i> is a zero (0) output, the end of the enumeration is reached.</div>
///             <div> </div>
///    pppvItems = Receives an array of pointers to the requested items. The number of pointers contained in an array is specified
///                by the output value of <i>pCount</i>. The actual data returned depends on the type of enumeration. The types of
///                structures that are returned are the following: PEER_CONNECTION_INFO, PEER_NODE_INFO, and PEER_RECORD
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt>
///    </dl> </td> <td width="60%"> The graph must be initialized with a call to PeerGraphStartup before using this
///    function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

///The <b>PeerGraphEndEnumeration</b> function releases an enumeration handle, and frees the resources associated with
///an enumeration.
///Params:
///    hPeerEnum = Handle to an enumeration to release. This handle is returned by one of the following functions:
///                PeerGraphEnumConnections, PeerGraphEnumNodes, PeerGraphEnumRecords, or PeerGraphSearchRecords.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A graph must be initialized
///    with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphEndEnumeration(void* hPeerEnum);

///The <b>PeerGraphCreate</b> function creates a new peer graph. An application can specify information about a peer
///graph, and the type of security that a peer graph uses. A handle to a peer graph is returned, but a network
///connection is not established.
///Params:
///    pGraphProperties = All of the properties of a peer graph in the PEER_GRAPH_PROPERTIES structure.
///    pwzDatabaseName = The name of a record database to associate with a peer graph when it is created. The record database name must be
///                      a valid file name. Do not include a path with the file name. For a complete list of rules regarding file names,
///                      see the Naming a File item in the list of Graphing Reference_Links.
///    pSecurityInterface = The information about a security provider for a peer graph in the PEER_SECURITY_INTERFACE structure.
///    phGraph = Receives a handle to the peer graph that is created. When this handle is not required anymore, free it by calling
///              PeerGraphClose.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_DUPLICATE_GRAPH</b></dt>
///    </dl> </td> <td width="60%"> A database with a specified peer graph ID that already exists. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be
///    initialized with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphCreate(PEER_GRAPH_PROPERTIES* pGraphProperties, const(wchar)* pwzDatabaseName, 
                        PEER_SECURITY_INTERFACE* pSecurityInterface, void** phGraph);

///The <b>PeerGraphOpen</b> function opens a peer graph that is created previously by either the local node or a remote
///node. A handle to the peer graph is returned, but a network connection is not established.
///Params:
///    pwzGraphId = Specifies the ID of the peer graph to open. This identifier must be the same as the ID used in the call to
///                 PeerGraphCreate. <div class="alert"><b>Note</b> A peer who specifies an invalid (long) graph ID can open and
///                 connect successfully to a graph, but the peer cannot publish records to the graph, because the records cannot be
///                 validated. </div> <div> </div>
///    pwzPeerId = Specifies the unique ID of the peer opening the graph. <div class="alert"><b>Note</b> A peer who specifies an
///                invalid (long) graph ID can open and connect successfully to a graph, but the peer cannot publish records to the
///                graph, because the records cannot be validated.</div> <div> </div>
///    pwzDatabaseName = Specifies the name of the database that is associated with this peer graph at the time the graph was created or
///                      opened for the first time.
///    pSecurityInterface = Specifies the security provider for a peer graph. This parameter must specify the same value as the
///                         <i>pSecurityInterface</i> specified in the original call to PeerGraphCreate.
///    cRecordTypeSyncPrecedence = Specifies the number of record types in the <i>pRecordTypeSyncPrecedence</i> parameter.
///    pRecordTypeSyncPrecedence = Points to an array of record types. This array specifies the order in which records of the specified record types
///                                are synchronized. The order can be zero (0) to N, where 0 is the first record type to be synchronized. If a
///                                record type is not specified in the array, it is synchronized in the default order after the types specified in
///                                the array are synchronized. Specify <b>NULL</b> to use the default order. This parameter must be <b>NULL</b> if
///                                <i>cRecordTypeSyncPrecedence</i> is zero (0).
///    phGraph = Receives a handle to the peer graph that is opened. When this handle is not required or needed, free it by
///              calling PeerGraphClose.
///Returns:
///    Returns S_OK if an existing database was successfully opened. Otherwise, the function returns one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_S_GRAPH_DATA_CREATED</b></dt>
///    </dl> </td> <td width="60%"> An existing database is not found, and a new one is created successfully. If an
///    existing database is found and opened successfully, <b>S_OK</b> is returned. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the peer graph is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The
///    peer graph must be initialized by using a call to PeerGraphStartup before using this function. </td> </tr>
///    </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphOpen(const(wchar)* pwzGraphId, const(wchar)* pwzPeerId, const(wchar)* pwzDatabaseName, 
                      PEER_SECURITY_INTERFACE* pSecurityInterface, uint cRecordTypeSyncPrecedence, 
                      char* pRecordTypeSyncPrecedence, void** phGraph);

///The <b>PeerGraphListen</b> function indicates that a peer graph should start listening for incoming connections.
///Params:
///    hGraph = Specifies the peer graph to listen on.
///    dwScope = Specifies the IPv6 scope to listen on. Valid values are identified in the following table. For more information
///              about scope, see Link-Local and Site-Local Addresses. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="PEER_GRAPH_SCOPE_GLOBAL"></a><a id="peer_graph_scope_global"></a><dl>
///              <dt><b>PEER_GRAPH_SCOPE_GLOBAL</b></dt> </dl> </td> <td width="60%"> Scope includes the Internet. </td> </tr>
///              <tr> <td width="40%"><a id="PEER_GRAPH_SCOPE_SITELOCAL"></a><a id="peer_graph_scope_sitelocal"></a><dl>
///              <dt><b>PEER_GRAPH_SCOPE_SITELOCAL</b></dt> </dl> </td> <td width="60%"> Scope is restricted to a site, for
///              example, a corporation intranet. </td> </tr> <tr> <td width="40%"><a id="PEER_GRAPH_SCOPE_LINKLOCAL"></a><a
///              id="peer_graph_scope_linklocal"></a><dl> <dt><b>PEER_GRAPH_SCOPE_LINKLOCAL</b></dt> </dl> </td> <td width="60%">
///              Scope is restricted to a local subnet. </td> </tr> </table>
///    dwScopeId = Specifies the IPv6 scope ID to listen on. Specify zero (0) to listen on all interfaces of the specified scope.
///                <div class="alert"><b>Note</b> The scope ID zero (0) is not allowed if <i>dwScope</i> is
///                <b>PEER_GRAPH_SCOPE_SITELOCAL</b> or <b>PEER_GRAPH_SCOPE_LINKLOCAL</b>.</div> <div> </div>
///    wPort = Specifies the port to listen on. Specify zero (0) to use a dynamic port. If zero (0) is specified, use
///            PeerGraphGetNodeInfo to retrieve data.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the values identified in
///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GRAPH_NOT_READY</b></dt>
///    </dl> </td> <td width="60%"> The graph has never been synchronized. An application cannot listen until the peer
///    graph has been synchronized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl>
///    </td> <td width="60%"> The handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The graph must be initialized with a call to
///    PeerGraphStartup—before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphListen(void* hGraph, uint dwScope, uint dwScopeId, ushort wPort);

///The <b>PeerGraphConnect</b> function attempts to make a connection to a specified node in a peer graph. This function
///starts an asynchronous operation. The calling application must wait for a <b>PEER_GRAPH_EVENT_NEIGHBOR_CONNECTION</b>
///event to determine if the connection attempt is successful.
///Params:
///    hGraph = Handle to a peer graph.
///    pwzPeerId = The unique ID of a peer to connect to at <i>pAddress</i>. Specify <b>NULL</b> to connect to any peer listening at
///                a specified address in the same peer graph.
///    pAddress = Pointer to a PEER_ADDRESS structure that identifies a node to connect to.
///    pullConnectionId = Receives the pointer to an <b>ULONGLONG</b> that contains the connection ID. This ID can be used with the direct
///                       communication functions.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> A neighbor connection to a specified node already exists. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to a peer graph is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> A graph must be initialized with a call to PeerGraphStartup before using this function. </td> </tr>
///    </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphConnect(void* hGraph, const(wchar)* pwzPeerId, PEER_ADDRESS* pAddress, ulong* pullConnectionId);

///The <b>PeerGraphClose</b> function invalidates the peer graph handle returned by a call to either PeerGraphCreate or
///PeerGraphOpen, and closes all network connections for the specified peer graph.
///Params:
///    hGraph = Handle to the peer graph to close.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be initialized with a
///    call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphClose(void* hGraph);

///The <b>PeerGraphDelete</b> function deletes the data associated with a specified peer graph.
///Params:
///    pwzGraphId = The name of a peer graph to delete data for. Specify the same ID used in calls to PeerGraphCreate or
///                 PeerGraphOpen.
///    pwzPeerId = The peer ID to delete data for. Specify the same ID used in calls to PeerGraphCreate or PeerGraphOpen.
///    pwzDatabaseName = The name of a database associated with a peer graph. Specify the same ID used in calls to PeerGraphCreate or
///                      PeerGraphOpen.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Access to a graph is denied. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A
///    graph must be initialized with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphDelete(const(wchar)* pwzGraphId, const(wchar)* pwzPeerId, const(wchar)* pwzDatabaseName);

///The <b>PeerGraphGetStatus</b> function returns the current status of the peer graph.
///Params:
///    hGraph = Handle to the peer graph.
///    pdwStatus = Receives the current status of the peer graph. Returns one or more of the PEER_GRAPH_STATUS_FLAGS values.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is
///    not enough memory to perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the peer graph is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer
///    graph must be initialized with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphGetStatus(void* hGraph, uint* pdwStatus);

///The <b>PeerGraphGetProperties</b> function retrieves the current peer graph properties.
///Params:
///    hGraph = Handle to a peer graph.
///    ppGraphProperties = Receives a pointer to a PEER_GRAPH_PROPERTIES structure. When the structure is not needed, free it by calling
///                        PeerGraphFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GRAPH_NOT_READY</b></dt>
///    </dl> </td> <td width="60%"> The graph is not synchronized. Data cannot be retrieved until a peer graph is
///    synchronized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td
///    width="60%"> The handle to a peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A peer graph must be initialized with a call
///    to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphGetProperties(void* hGraph, PEER_GRAPH_PROPERTIES** ppGraphProperties);

///The <b>PeerGraphSetProperties</b> function sets the peer graph properties.
///Params:
///    hGraph = Handle to a graph.
///    pGraphProperties = Pointer to a PEER_GRAPH_PROPERTIES structure that specifies new values for the graph properties that an
///                       application can set. An application can set only the following fields of PEER_GRAPH_PROPERTIES:<ul>
///                       <li><b>pwzFriendlyName</b></li> <li><b>cPresenceMax</b></li> <li><b>pwzComment</b></li>
///                       <li><b>ulPresenceLifetime</b></li> </ul> <div class="alert"><b>Note</b> If remaining fields are set, then they
///                       are ignored.</div> <div> </div>
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot access a peer graph. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The
///    handle to a peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt>
///    </dl> </td> <td width="60%"> The graph must be initialized with a call to PeerGraphStartup before using this
///    function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphSetProperties(void* hGraph, PEER_GRAPH_PROPERTIES* pGraphProperties);

///The <b>PeerGraphRegisterEvent</b> function registers a peer's request to be notified of changes associated with a
///peer graph and event type.
///Params:
///    hGraph = Handle to the peer graph.
///    hEvent = Handle created by CreateEvent that the application is signaled on when an event is triggered. When an application
///             is signaled, it must call PeerGraphGetEventData to retrieve events until PEER_S_NO_EVENT_DATA returned.
///    cEventRegistrations = Specifies the number of PEER_GRAPH_EVENT_REGISTRATION structures in <i>pEventRegistrations</i>.
///    pEventRegistrations = Points to an array of PEER_GRAPH_EVENT_REGISTRATION structures that specify what events the application requests
///                          notifications for.
///    phPeerEvent = Receives a <b>HPEEREVENT</b> handle. This handle must be used when calling PeerGraphUnregisterEvent to stop
///                  receiving notifications.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be initialized with a
///    call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphRegisterEvent(void* hGraph, HANDLE hEvent, uint cEventRegistrations, char* pEventRegistrations, 
                               void** phPeerEvent);

///The <b>PeerGraphUnregisterEvent</b> function requests that the application no longer be notified of changes
///associated with a peer graph and record type.
///Params:
///    hPeerEvent = Peer event handle obtained from call to PeerGraphRegisterEvent.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be
///    initialized with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphUnregisterEvent(void* hPeerEvent);

///The <b>PeerGraphGetEventData</b> function retrieves peer events. An application calls this function until the return
///value <b>PEER_S_NO_EVENT_DATA</b> is returned, which indicates that a call is successful, but that there are no more
///peer events to retrieve.
///Params:
///    hPeerEvent = Peer event handle obtained by a call to PeerGraphRegisterEvent.
///    ppEventData = Receives a pointer to a PEER_GRAPH_EVENT_DATA structure that contains the data about an event notification. When
///                  this structure is not needed, free it by calling PeerGraphFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_S_NO_EVENT_DATA</b></dt> </dl>
///    </td> <td width="60%"> The function call succeeds, but there is no data associated with a peer event. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A peer graph must
///    be initialized with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphGetEventData(void* hPeerEvent, PEER_GRAPH_EVENT_DATA** ppEventData);

///The <b>PeerGraphGetRecord</b> function retrieves a specific record based on the specified record ID. The returned
///record should be freed by calling PeerGraphFreeData.
///Params:
///    hGraph = Handle to the peer graph.
///    pRecordId = Pointer to record ID to retrieve.
///    ppRecord = Receives the requested record. When this structure is no longer required, free it by calling PeerGraphFreeData.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_GRAPH_NOT_READY</b></dt> </dl> </td> <td width="60%"> The peer graph has
///    never been synchronized. Records cannot be retrieved until the peer graph has been synchronized. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the peer
///    graph is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The peer graph must be initialized with a call to PeerGraphStartup before using this function. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_RECORD_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The
///    specified record was not found. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphGetRecord(void* hGraph, const(GUID)* pRecordId, PEER_RECORD** ppRecord);

///The <b>PeerGraphAddRecord</b> function adds a new record to a peer graph. A record added with this function is sent
///to each node in a peer graph.
///Params:
///    hGraph = Handle to a peer graph.
///    pRecord = Pointer to a record to add.
///    pRecordId = Specifies the record ID that uniquely identifies a record in a peer graph.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot access a peer graph. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not
///    enough memory to perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_GRAPH_NOT_READY</b></dt> </dl> </td> <td width="60%"> A graph is not synchronized. Records cannot
///    be added until the peer graph is synchronized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_GRAPH_SHUTTING_DOWN</b></dt> </dl> </td> <td width="60%"> PeerGraphClose has been called. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_ATTRIBUTES</b></dt> </dl> </td> <td width="60%"> The
///    specified attributes do not match the schema. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to a peer graph is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_MAX_RECORD_SIZE_EXCEEDED</b></dt> </dl> </td> <td width="60%"> The
///    record exceeds the maximum size allowed by a peer graph. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The graph must be initialized with a call to
///    PeerGraphStartup—before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphAddRecord(void* hGraph, PEER_RECORD* pRecord, GUID* pRecordId);

///The <b>PeerGraphUpdateRecord</b> function updates a record in the peer graph and then floods the record to each node
///in the peer graph.
///Params:
///    hGraph = Handle to the peer graph.
///    pRecord = Pointer to a PEER_RECORD structure that contains the new data for the record.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_GRAPH_NOT_READY</b></dt> </dl> </td> <td width="60%"> The peer graph has
///    never been synchronized. Records cannot be updated until the graph has been synchronized. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the peer graph
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The peer graph must be initialized with a call to PeerGraphStartup before using this function. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_RECORD_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The
///    specified record was not found. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphUpdateRecord(void* hGraph, PEER_RECORD* pRecord);

///The <b>PeerGraphDeleteRecord</b> function marks a record as deleted within a peer graph. The record is not available
///on a local node to function calls, for example, calls to PeerGraphGetRecord and PeerGraphEnumRecords.
///Params:
///    hGraph = Handle to a peer graph.
///    pRecordId = Pointer to a record ID to delete.
///    fLocal = Specify <b>TRUE</b> to remove a record from only a local database without notifying the rest of a peer graph
///             about the change. Specify FALSE to delete the record from an entire peer graph. <div class="alert"><b>Note</b>
///             Specifying <b>TRUE</b> does not prevent a record from being added again during the next graph synchronization
///             with a neighbor. Specifying <b>TRUE</b> is only effective if PEER_SECURITY_INTERFACE is specified in a call to
///             PeerGraphOpen or PeerGraphCreate, and only if PEER_SECURITY_INTERFACE contains a PFNPEER_VALIDATE_RECORD function
///             that returns PEER_E_INVALID_RECORD when validating the record.</div> <div> </div>
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot access a peer graph. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_GRAPH_NOT_READY</b></dt> </dl> </td> <td width="60%"> The peer graph is not
///    synchronized. Records cannot be deleted until the graph is synchronized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to a peer graph is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer
///    graph must be initialized with a call to PeerGraphStartup before using this function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_RECORD_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified record
///    cannot be found. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphDeleteRecord(void* hGraph, const(GUID)* pRecordId, BOOL fLocal);

///The <b>PeerGraphEnumRecords</b> function creates and returns an enumeration handle used to enumerate records of a
///specific type of record, user, or both. An enumeration provides a snapshot of records at the time an enumeration is
///performed.
///Params:
///    hGraph = Handle to a peer graph.
///    pRecordType = Pointer to the type of record to enumerate. Specify <b>NULL</b> to enumerate all record types.
///    pwzPeerId = Pointer to a string that identifies the creator that an application is requesting an enumeration for. Specify
///                <b>NULL</b> to enumerate all records.
///    phPeerEnum = Receives a handle to an enumeration. Supply the handle to all calls to PeerGraphGetNextItem. When a handle is not
///                 needed, free it by calling PeerGraphEndEnumeration.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl>
///    </td> <td width="60%"> The handle to a peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A graph must be initialized with a call to
///    PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphEnumRecords(void* hGraph, const(GUID)* pRecordType, const(wchar)* pwzPeerId, void** phPeerEnum);

///The <b>PeerGraphSearchRecords</b> function searches the peer graph for specific records.
///Params:
///    hGraph = Handle to the peer graph.
///    pwzCriteria = Pointer to an XML string that specifies the records to search for. For information on formulating an XML query
///                  string to search the peer graphing records, see Record Search Query Format.
///    phPeerEnum = Handle to the enumeration.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_SEARCH</b></dt> </dl> </td> <td width="60%"> The specified query does not adhere to the
///    search schema. See Record Search Query Format for further information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be initialized with a
///    call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphSearchRecords(void* hGraph, const(wchar)* pwzCriteria, void** phPeerEnum);

///The <b>PeerGraphExportDatabase</b> function exports a peer graph database into a file that you can move to a
///different computer. By using PeerGraphImportDatabase, a peer graph database can be imported to a different computer.
///Params:
///    hGraph = Handle to a peer graph.
///    pwzFilePath = Pointer to a string that contains the file path to store exported data. If a data storage file exists and
///                  contains data when new data is exported to it, then the new data overwrites the old data.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns either an error located in
///    WinErr.h, or one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One parameter is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough
///    memory to perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to a graph is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A graph must be
///    initialized with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphExportDatabase(void* hGraph, const(wchar)* pwzFilePath);

///The <b>PeerGraphImportDatabase</b> function imports a file that contains the information from a peer graph database.
///This function can only be called if the application has not yet called the PeerGraphListen or PeerGraphConnect
///function.
///Params:
///    hGraph = Handle to the peer graph.
///    pwzFilePath = Pointer to a string that contains the path to the file in which the imported data is stored.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns either one of the WinErr.h values
///    or one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GRAPH_IN_USE</b></dt> </dl> </td> <td width="60%"> The graph
///    is currently being used, and cannot be imported. Either PeerGraphListen or PeerGraphConnect has been called.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_DATABASE</b></dt> </dl> </td> <td width="60%"> The
///    specified database is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The graph must be initialized with a call to
///    PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphImportDatabase(void* hGraph, const(wchar)* pwzFilePath);

///The <b>PeerGraphValidateDeferredRecords</b> function indicates to the Peer Graphing Infrastructure that it is time to
///resubmit any deferred records for the security module to validate.
///Params:
///    hGraph = Handle to the peer graph.
///    cRecordIds = Specifies the number of records specified in <i>pRecordIds</i>. Specify zero (0) to instruct the Graphing
///                 infrastructure to validate all deferred records. If zero (0) is specified, <i>pRecordIds</i> is ignored.
///    pRecordIds = Pointer to an array of record IDs to validate.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be initialized with a
///    call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphValidateDeferredRecords(void* hGraph, uint cRecordIds, char* pRecordIds);

///The <b>PeerGraphOpenDirectConnection</b> function allows an application to establish a direct connection with a node
///in a peer graph. The connection can only be made if the node to which the application is connecting has subscribed to
///the <b>PEER_GRAPH_EVENT_DIRECT_CONNECTION</b> event. The application can then send data directly to another node. A
///call to this function is asynchronous.
///Params:
///    hGraph = Handle to a peer graph.
///    pwzPeerId = Pointer to the unique ID of a user or node to connect to. This parameter is used to identify a specific user
///                because multiple identities can be attached to the specified address.
///    pAddress = Pointer to a PEER_ADDRESS structure that contains the address of the node to connect to.
///    pullConnectionId = Receives the connection ID for the requested connection.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the graph is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The graph must be
///    initialized with a call to PeerGraphStartup—before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphOpenDirectConnection(void* hGraph, const(wchar)* pwzPeerId, PEER_ADDRESS* pAddress, 
                                      ulong* pullConnectionId);

///The <b>PeerGraphSendData</b> function sends data to a neighbor node or a directly connected node.
///Params:
///    hGraph = Handle to the peer graph.
///    ullConnectionId = Specifies the unique ID of the connection to send data on.
///    pType = Specifies an application-defined data type to send. This parameter cannot be <b>NULL</b>.
///    cbData = Specifies the number of bytes pointed to by <i>pvData</i>.
///    pvData = Pointer to the data to send.
///Returns:
///    Returns S_OK if the operation succeeds; otherwise, the function returns one of the following values: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_CONNECTION_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No connection with the given ID exists.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The
///    handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The graph must be initialized with a call to
///    PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphSendData(void* hGraph, ulong ullConnectionId, const(GUID)* pType, uint cbData, char* pvData);

///The <b>PeerGraphCloseDirectConnection</b> function closes a specified direct connection.
///Params:
///    hGraph = Handle to a peer graph.
///    ullConnectionId = Specifies the connection ID to disconnect from.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_CONNECTION_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No connection with
///    the specified ID exists. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td>
///    <td width="60%"> The handle to a peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The graph must be initialized with a call to
///    PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphCloseDirectConnection(void* hGraph, ulong ullConnectionId);

///The <b>PeerGraphEnumConnections</b> function creates and returns an enumeration handle used to enumerate the
///connections of a local node.
///Params:
///    hGraph = Handle to a peer graph.
///    dwFlags = The type of connection to enumerate. This parameter is required. Valid values are specified by
///              PEER_CONNECTION_FLAGS.
///    phPeerEnum = Receives a handle to an enumeration. Use PeerGraphGetNextItem to retrieve the actual connection information. When
///                 this handle is not required, free it by calling PeerGraphEndEnumeration.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl>
///    </td> <td width="60%"> The handle to a peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be initialized with a
///    call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphEnumConnections(void* hGraph, uint dwFlags, void** phPeerEnum);

///The <b>PeerGraphEnumNodes</b> function creates and returns an enumeration handle used to enumerate the nodes in a
///peer graph. The enumeration provides a snapshot of a peer graph at the time an enumeration is performed. Depending on
///the policy of a peer graph, and if nodes do not publish presence information, an enumeration does not return some
///nodes that are connected to a peer graph.
///Params:
///    hGraph = Handle to a peer graph.
///    pwzPeerId = The peer ID to obtain a node enumeration. Specify <b>NULL</b> to return all nodes in a peer graph.
///    phPeerEnum = Receives a handle to an enumeration. Use PeerGraphGetNextItem to retrieve the actual node information. When this
///                 handle is not needed, free it by calling PeerGraphEndEnumeration.
///Returns:
///    If a function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl>
///    </td> <td width="60%"> The handle to a peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A peer graph must be initialized with a call
///    to PeerGraphStartup before using this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_READY</b></dt> </dl> </td> <td width="60%"> A peer graph is not synchronized completely, and
///    the nodes cannot be enumerated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_PRESENCE_DISABLED</b></dt>
///    </dl> </td> <td width="60%"> A peer graph does not require presence information. Therefore, the nodes cannot be
///    enumerated. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphEnumNodes(void* hGraph, const(wchar)* pwzPeerId, void** phPeerEnum);

///The <b>PeerGraphSetPresence</b> function explicitly turns on or off the publication of presence records for a
///specific node. This function can override the presence settings in the peer graph properties. Calling this function
///enables nodes to be enumerated with PeerGraphEnumNodes.
///Params:
///    hGraph = Handle to a peer graph.
///    fPresent = Specify <b>TRUE</b> to force the Peer Graphing Infrastructure to publish a presence record for this node, which
///               overrides the setting specified by the <b>cPresenceMax</b> in PEER_GRAPH_PROPERTIES. Specify <b>FALSE</b> to
///               return the node to the default behavior specified in the peer graph properties. <div class="alert"><b>Note</b>
///               Depending on the peer graphing presence policy, setting <i>fPresent</i> to <b>FALSE</b> does not guarantee that a
///               peer's presence information is removed. It means that a peer's presence is not published anymore.</div> <div>
///               </div>
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the peer
///    graph is invalid. The presence information cannot be published. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be initialized with a
///    call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphSetPresence(void* hGraph, BOOL fPresent);

///The <b>PeerGraphGetNodeInfo</b> function retrieves information about a specific node.
///Params:
///    hGraph = Handle to a peer graph.
///    ullNodeId = Specifies the ID of a node that an application receives information about. Specify zero (0) to retrieve
///                information about the local node.
///    ppNodeInfo = Receives a pointer to a PEER_NODE_INFO structure that contains the requested information. When the handle is not
///                 needed, free it by calling PeerGraphFreeData.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the following
///    error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One parameter is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl>
///    </td> <td width="60%"> The handle to a peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> A peer graph must be initialized by using a
///    call to PeerGraphStartup before using this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NODE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> A specified node is not found. </td> </tr>
///    </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphGetNodeInfo(void* hGraph, ulong ullNodeId, PEER_NODE_INFO** ppNodeInfo);

///The <b>PeerGraphSetNodeAttributes</b> function sets the attributes of the PEER_NODE_INFO structure for the local
///node.
///Params:
///    hGraph = Handle to the peer graph.
///    pwzAttributes = Pointer to a string that represents the attributes the application associates with the local node. This string is
///                    a free-form text string that is specific to the application. Specify <b>NULL</b> to delete all attributes for the
///                    specified node.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following value.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer graph is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer graph must be initialized with a
///    call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphSetNodeAttributes(void* hGraph, const(wchar)* pwzAttributes);

///The <b>PeerGraphPeerTimeToUniversalTime</b> function converts the peer graph-maintained reference time value to a
///localized time value appropriate for display on the peer's computer.
///Params:
///    hGraph = Handle to the peer graph this peer participates in. This handle is returned by the PeerGraphCreate, or
///             PeerGraphOpen function.
///    pftPeerTime = Pointer to the peer time (UTC) value, represented as a FILETIME structure.
///    pftUniversalTime = Pointer to the returned universal time value, represented as a FILETIME structure.
///Returns:
///    Returns S_OK if the function succeeds; otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the graph is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The graph must be
///    initialized with a call to PeerGraphStartup before using this function. </td> </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphPeerTimeToUniversalTime(void* hGraph, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

///The <b>PeerGraphUniversalTimeToPeerTime</b> function converts a universal time value from the peer's computer to a
///common peer graph time value.
///Params:
///    hGraph = Handle to the peer graph this peer participates in. This handle is returned by the PeerGraphCreate or
///             PeerGraphOpen function.
///    pftUniversalTime = Pointer to the universal time value, represented as a FILETIME structure.
///    pftPeerTime = Pointer to the returned peer time (UTC) value, represented as a FILETIME structure.
///Returns:
///    Returns S_OK if the function succeeds; otherwise, the function returns either one of the RPC errors or one of the
///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GRAPH</b></dt> </dl> </td> <td width="60%"> The handle to the peer
///    graph is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The graph must be initialized with a call to PeerGraphStartup before using this function. </td>
///    </tr> </table>
///    
@DllImport("P2PGRAPH")
HRESULT PeerGraphUniversalTimeToPeerTime(void* hGraph, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

///The <b>PeerFreeData</b> function deallocates a block of data and returns it to the memory pool. Use the
///<b>PeerFreeData</b> function to free data that the Peer Identity Manager, Peer Grouping, and Peer Collaboration APIs
///return.
///Params:
///    pvData = Pointer to a block of data to be deallocated. This parameter must reference a valid block of memory.
///Returns:
///    There are no return values.
///    
@DllImport("P2P")
void PeerFreeData(void* pvData);

///The <b>PeerGetItemCount</b> function returns a count of the items in a peer enumeration.
///Params:
///    hPeerEnum = Handle to the peer enumeration on which a count is performed. A peer enumeration function generates this handle.
///    pCount = Returns the total number of items in a peer enumeration.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerGetItemCount(void* hPeerEnum, uint* pCount);

///The <b>PeerGetNextItem</b> function returns a specific number of items from a peer enumeration.
///Params:
///    hPeerEnum = Handle to the peer enumeration from which items are retrieved. This handle is generated by a peer enumeration
///                function.
///    pCount = Pointer to an integer that specifies the number of items to be retrieved from the peer enumeration. When
///             returned, it contains the number of items in <i>ppvItems</i>. This parameter cannot be <b>NULL</b>.
///    pppvItems = Receives a pointer to an array of pointers to the next <i>pCount</i> items in the peer enumeration. The data, for
///                example, a record or member information block, depends on the actual peer enumeration type.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

///The <b>PeerEndEnumeration</b> function releases an enumeration, for example, a record or member enumeration, and
///deallocates all resources associated with the enumeration.
///Params:
///    hPeerEnum = Handle to the enumeration to be released. This handle is generated by a peer enumeration function.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns the following value. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> The parameter is not valid. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerEndEnumeration(void* hPeerEnum);

///The <b>PeerGroupStartup</b> function initiates a peer group by using a requested version of the Peer infrastructure.
///Params:
///    wVersionRequested = Specifies the highest version of the Peer Infrastructure that a caller can support. The high order byte specifies
///                        the minor version (revision) number. The low order byte specifies the major version number This parameter is
///                        required.
///    pVersionData = Pointer to a PEER_VERSION_DATA structure that contains the specific level of support provided by the Peer
///                   Infrastructure. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_DEPENDENCY_FAIL</b></dt> </dl> </td> <td width="60%"> The Peer Name Resolution Protocol
///    (PNRP) service must be started before calling PeerGroupStartup. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_IPV6_NOT_INSTALLED</b></dt> </dl> </td> <td
///    width="60%"> The grouping service failed to start because IPv6 is not installed on the computer. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_UNSUPPORTED_VERSION</b></dt> </dl> </td> <td width="60%"> The requested
///    version is not supported by the installed Peer subsystem. </td> </tr> </table> Cryptography-specific errors can
///    be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in
///    Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

///The <b>PeerGroupShutdown</b> function closes a peer group created with PeerGroupStartup and disposes of any allocated
///resources.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns the following value. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl>
///    </td> <td width="60%"> The function terminated unexpectedly. </td> </tr> </table> Cryptography-specific errors
///    can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in
///    Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupShutdown();

///The <b>PeerGroupCreate</b> function creates a new peer group.
///Params:
///    pProperties = Pointer to a PEER_GROUP_PROPERTIES structure that specifies the specific details of the group, such as the peer
///                  group names, invitation lifetimes, and presence lifetimes. This parameter is required. The following members must
///                  be set:<ul> <li><b>pwzCreatorPeerName</b></li> </ul> The following members cannot be set:<ul>
///                  <li><b>pwzGroupPeerName</b></li> </ul>The remaining members are optional.
///    phGroup = Returns the handle pointer to the peer group. Any function called with this handle as a parameter has the
///              corresponding action performed on that peer group. This parameter is required.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to perform the specified
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_CLOUD_NAME_AMBIGUOUS</b></dt> </dl> </td> <td
///    width="60%"> The cloud specified in <i>pProperties</i> cannot be uniquely discovered (more than one cloud matches
///    the provided name). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_CLASSIFIER</b></dt> </dl> </td>
///    <td width="60%"> The peer group classifier specified in <i>pProperties</i> is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_INVALID_PEER_NAME</b></dt> </dl> </td> <td width="60%"> The peer name specified
///    for the group in <i>pProperties</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_PROPERTIES</b></dt> </dl> </td> <td width="60%"> One or more of the peer group properties
///    supplied in <i>pProperties</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_CLOUD</b></dt>
///    </dl> </td> <td width="60%"> The cloud specified in <i>pProperties</i> cannot be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl> </td> <td width="60%"> Access to the identity or
///    group keys is denied. Typically, this is caused by an incorrect access control list (ACL) for the folder that
///    contains the user or computer keys. This can happen when the ACL is reset manually. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> PEER_E_PASSWORD_DOES_NOT_MEET_POLICY</b></dt> </dl> </td> <td width="60%"> Password
///    specified does not meet system password requirements. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DELETE_PENDING</b></dt> </dl> </td> <td width="60%"> The peer identity specified as the Group
///    Creator has been deleted or is in the process of being deleted. </td> </tr> </table> Cryptography-specific errors
///    can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in
///    Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupCreate(PEER_GROUP_PROPERTIES* pProperties, void** phGroup);

///The <b>PeerGroupOpen</b> function opens a peer group that a peer has created or joined. After a peer group is opened,
///the peer can register for event notifications.
///Params:
///    pwzIdentity = Pointer to a Unicode string that contains the identity a peer uses to open a group. This parameter is required.
///    pwzGroupPeerName = Pointer to a Unicode string that contains the peer name of the peer group. This parameter is required.
///    pwzCloud = Pointer to a Unicode string that contains the name of the PNRP cloud in which the peer group is located. If the
///               value is <b>NULL</b>, the cloud specified in the peer group properties is used.
///    phGroup = Pointer to a handle for a peer group. If this value is <b>NULL</b>, the open operation is unsuccessful. This
///              parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_CLOUD_NAME_AMBIGUOUS</b></dt> </dl> </td> <td width="60%"> The cloud specified in <i>pwzCloud</i>
///    cannot be uniquely discovered, for example, more than one cloud matches the provided name. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NO_CLOUD</b></dt> </dl> </td> <td width="60%"> The cloud specified in
///    <i>pwzCloud</i> cannot be located. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt>
///    </dl> </td> <td width="60%"> Access to the peer identity or peer group keys is denied. Typically, this is caused
///    by an incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen
///    when the ACL has been reset manually. </td> </tr> </table> Cryptography-specific errors can be returned from the
///    Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupOpen(const(wchar)* pwzIdentity, const(wchar)* pwzGroupPeerName, const(wchar)* pwzCloud, 
                      void** phGroup);

///The <b>PeerGroupJoin</b> function prepares a peer with an invitation to join an existing peer group prior to calling
///PeerGroupConnect or PeerGroupConnectByAddress.
///Params:
///    pwzIdentity = Pointer to a Unicode string that contains the identity opening the specified peer group. If this parameter is
///                  <b>NULL</b>, the implementation uses the identity obtained from PeerIdentityGetDefault.
///    pwzInvitation = Pointer to a Unicode string that contains the XML invitation granted by another peer. An invitation is created
///                    when the inviting peer calls PeerGroupCreateInvitation or PeerGroupIssueCredentials. Specific details regarding
///                    this invitation can be obtained as a PEER_INVITATION_INFO structure by calling PeerGroupParseInvitation. This
///                    parameter is required.
///    pwzCloud = Pointer to a Unicode string that contains the name of the PNRP cloud where a group is located. The default value
///               is <b>NULL</b>, which indicates that the cloud specified in the invitation must be used.
///    phGroup = Pointer to the handle of the peer group. To start communication with a group, call PeerGroupConnect. This
///              parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_CLOUD_NAME_AMBIGUOUS</b></dt> </dl> </td> <td width="60%"> The cloud cannot be uniquely discovered,
///    for example, more than one cloud matches the provided name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_PEER_NAME</b></dt> </dl> </td> <td width="60%"> The peer identity specified in
///    <i>pwzIdentity</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_TIME_PERIOD</b></dt>
///    </dl> </td> <td width="60%"> The validity period specified in the invitation is invalid. Either the specified
///    period has expired or the invitation is not yet valid (i.e. the specified ValidityStart date\time has not yet
///    been reached). One possible reason for the return of this error is that the system clock is incorrectly set on
///    the machine joining the group, or on the machine that issued the invitation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PEER_E_INVITATION_NOT_TRUSTED</b></dt> </dl> </td> <td width="60%"> The invitation is not trusted.
///    This may be due to invitation alteration, errors, or expiration. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NO_CLOUD</b></dt> </dl> </td> <td width="60%"> The cloud cannot be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_UNSUPPORTED_VERSION</b></dt> </dl> </td> <td width="60%"> The invitation is not
///    supported by the current version of the Peer Infrastructure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl> </td> <td width="60%"> Access to the peer identity or peer group keys
///    is denied. Typically, this is caused by an incorrect access control list (ACL) for the folder that contains the
///    user or computer keys. This can happen when the ACL has been reset manually. </td> </tr> </table>
///    Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with
///    CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupJoin(const(wchar)* pwzIdentity, const(wchar)* pwzInvitation, const(wchar)* pwzCloud, 
                      void** phGroup);

///The <b>PeerGroupPasswordJoin</b> function prepares a peer with an invitation and the correct password to join a
///password-protected peer group prior to calling PeerGroupConnect or PeerGroupConnectByAddress.
///Params:
///    pwzIdentity = Pointer to a Unicode string that contains the identity opening the specified peer group. If this parameter is
///                  <b>NULL</b>, the implementation uses the identity obtained from PeerIdentityGetDefault.
///    pwzInvitation = Pointer to a Unicode string that contains the XML invitation granted by another peer. An invitation with a
///                    password is created when the inviting peer calls PeerGroupCreatePasswordInvitation. Specific details regarding
///                    this invitation, including the password set by the group creator, can be obtained as a PEER_INVITATION_INFO
///                    structure by calling PeerGroupParseInvitation. This parameter is required.
///    pwzPassword = Pointer to a zero-terminated Unicode string that contains the password required to validate and join the peer
///                  group. This password must match the password specified in the invitation. This parameter is required.
///    pwzCloud = Pointer to a Unicode string that contains the name of the PNRP cloud where a group is located. The default value
///               is <b>NULL</b>, which indicates that the cloud specified in the invitation must be used.
///    phGroup = Pointer to the handle of the peer group. To start communication with a group, call PeerGroupConnect. This
///              parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_CLOUD_NAME_AMBIGUOUS</b></dt> </dl> </td> <td width="60%"> The cloud cannot be uniquely discovered,
///    for example, more than one cloud matches the provided name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_PEER_NAME</b></dt> </dl> </td> <td width="60%"> The peer identity specified in
///    <i>pwzIdentity</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVITATION_NOT_TRUSTED</b></dt> </dl> </td> <td width="60%"> The invitation is not trusted by the
///    peer. It has been altered or contains errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NO_CLOUD</b></dt> </dl> </td> <td width="60%"> The cloud cannot be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_UNSUPPORTED_VERSION</b></dt> </dl> </td> <td width="60%"> The invitation is not
///    supported by the current version of the Peer Infrastructure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl> </td> <td width="60%"> Access to the peer identity or peer group keys
///    is denied. Typically, this is caused by an incorrect access control list (ACL) for the folder that contains the
///    user or computer keys. This can happen when the ACL has been reset manually. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PEER_S_ALREADY_A_MEMBER</b></dt> </dl> </td> <td width="60%"> The local peer attempted to join a
///    group based on a password more than once. </td> </tr> </table> Cryptography-specific errors may be returned from
///    the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupPasswordJoin(const(wchar)* pwzIdentity, const(wchar)* pwzInvitation, const(wchar)* pwzPassword, 
                              const(wchar)* pwzCloud, void** phGroup);

///The <b>PeerGroupConnect</b> function initiates a PNRP search for a peer group and attempts to connect to it. After
///this function is called successfully, a peer can communicate with other members of the peer group.
///Params:
///    hGroup = Handle to the peer group to which a peer intends to connect. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen,PeerGroupJoin, or PeerGroupPasswordJoin function. This parameter is required.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns the following value. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer group is invalid. </td> </tr> </table> Cryptography-specific
///    errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined
///    in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupConnect(void* hGroup);

///The <b>PeerGroupConnectByAddress</b> function attempts to connect to the peer group that other peers with known IPv6
///addresses are participating in. After this function is called successfully, a peer can communicate with other members
///of the peer group.
///Params:
///    hGroup = Handle to the peer group to which a peer intends to connect. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen,PeerGroupJoin, or PeerGroupPasswordJoin function. This parameter is required.
///    cAddresses = The total number of PEER_ADDRESS structures pointed to by <i>pAddresses</i>.
///    pAddresses = Pointer to a list of PEER_ADDRESS structures that specify the endpoints of peers participating in the group.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns the following value. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer group is invalid. </td> </tr> </table> Cryptography-specific
///    errors may be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined
///    in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupConnectByAddress(void* hGroup, uint cAddresses, char* pAddresses);

///The <b>PeerGroupClose</b> function invalidates the peer group handle obtained by a previous call to the
///PeerGroupCreate, PeerGroupJoin, or PeerGroupOpen function.
///Params:
///    hGroup = Handle to the peer group to close. This handle is returned by the PeerGroupCreate, PeerGroupOpen, or
///             PeerGroupJoin function. This parameter is required.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns the following value. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer group is invalid. </td> </tr> </table> Cryptography-specific
///    errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined
///    in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupClose(void* hGroup);

///The <b>PeerGroupDelete</b> function deletes the local data and certificate associated with a peer group.
///Params:
///    pwzIdentity = Pointer to a Unicode string that contains the identity opening the specified peer group. If this parameter is
///                  <b>NULL</b>, the implementation uses the identity obtained from PeerIdentityGetDefault.
///    pwzGroupPeerName = Pointer to a Unicode string that contains the peer name of the peer group for which data is deleted. This
///                       parameter is required. The group name can be obtained by calling PeerGroupGetProperties prior to PeerGroupClose,
///                       or by parsing the invitation with PeerGroupParseInvitation.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns one of the following values. <div
///    class="alert"><b>Note</b> If a delete operation fails due to a file system error, the appropriate file system
///    error is returned.</div> <div> </div> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Access to the peer group database
///    is denied. Ensure that the peer has permission to perform this operation. In this case, the peer must be the
///    original creator of the peer group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The peer group cannot be found. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl> </td> <td width="60%"> Access to the identity or
///    peer group keys is denied. Typically, this is caused by an incorrect access control list (ACL) for the folder
///    that contains the user or computer keys. This can happen when the ACL is reset manually. </td> </tr> </table>
///    Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with
///    CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupDelete(const(wchar)* pwzIdentity, const(wchar)* pwzGroupPeerName);

///The <b>PeerGroupCreateInvitation</b> function returns an XML string that can be used by the specified peer to join a
///group.
///Params:
///    hGroup = Handle to the peer group for which this invitation is issued. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pwzIdentityInfo = Pointer to a Unicode string that contains the XML blob (including the GMC) returned by a previous call to
///                      PeerIdentityGetXML with the identity of the peer. Alternatively, this parameter can contain a pointer to an XML
///                      blob generated by <b>PeerIdentityGetXML</b> using the peer information contained in PEER_CONTACT to generate an
///                      invitation for a peer contact.
///    pftExpiration = Specifies a UTC FILETIME structure that contains the specific date and time the invitation expires. This value
///                    cannot be greater than the remaining lifetime of the issuing peer. If this parameter is <b>NULL</b>, the
///                    invitation lifetime is set to the maximum value possible - the remaining lifetime of the peer.
///    cRoles = Specifies the count of roles in <i>pRoleInfo</i>.
///    pRoles = Pointer to a list of GUIDs that specifies the combined set of available roles. The available roles are as
///             follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="PEER_GROUP_ROLE_ADMIN"></a><a id="peer_group_role_admin"></a><dl> <dt><b>PEER_GROUP_ROLE_ADMIN</b></dt> </dl>
///             </td> <td width="60%"> This role can issue invitations, issue credentials, and renew the GMC of other
///             administrators, as well as behave as a member of the peer group. </td> </tr> <tr> <td width="40%"><a
///             id="PEER_GROUP_ROLE_MEMBER"></a><a id="peer_group_role_member"></a><dl> <dt><b>PEER_GROUP_ROLE_MEMBER</b></dt>
///             </dl> </td> <td width="60%"> This role can publish records to the group database. </td> </tr> </table>
///    ppwzInvitation = Pointer to a Unicode string that contains the invitation from the issuer. This invitation can be passed to
///                     PeerGroupJoin by the recipient in order to join the specified peer group. To return the details of the invitation
///                     as a PEER_INVITATION_INFO structure, pass this string to PeerGroupParseInvitation. To release this data, pass
///                     this pointer to PeerFreeData.
///Returns:
///    Returns S_OK if the operation succeeds; otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to perform the specified
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt> </dl> </td> <td
///    width="60%"> The peer group is not in a state where records can be added. For example, PeerGroupJoin is called,
///    but synchronization with the group database has not completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_CHAIN_TOO_LONG</b></dt> </dl> </td> <td width="60%"> The GMC chain is longer than 24 administrators
///    or members. For more information about GMC chains, please refer to the How Group Security Works documentation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_IDENTITY_DELETED</b></dt> </dl> </td> <td width="60%"> The
///    data passed as <i>pwzIdentityInfo</i> is for a deleted identity and no longer valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_AUTHORIZED</b></dt> </dl> </td> <td width="60%"> The peer that called this
///    method is not an administrator. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl>
///    </td> <td width="60%"> Access to the identity or peer group keys is denied. Typically, this is caused by an
///    incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen when
///    the ACL is reset manually. </td> </tr> </table> Cryptography-specific errors can be returned from the Microsoft
///    RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupCreateInvitation(void* hGroup, const(wchar)* pwzIdentityInfo, FILETIME* pftExpiration, 
                                  uint cRoles, char* pRoles, ushort** ppwzInvitation);

///The <b>PeerGroupCreatePasswordInvitation</b> function returns an XML string that can be used by the specified peer to
///join a group with a matching password.
///Params:
///    hGroup = Handle to the peer group for which this invitation is issued. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    ppwzInvitation = Pointer to a Unicode string that contains the invitation from the issuer. This invitation can be passed to
///                     PeerGroupPasswordJoin by the recipient in order to join the specified peer group. To return the details of the
///                     invitation as a PEER_INVITATION_INFO structure, pass this string to PeerGroupParseInvitation. To release this
///                     data, pass this pointer to PeerFreeData. This function requires that the following fields are set on the
///                     PEER_GROUP_PROPERTIES structure passed to PeerGroupCreate.<ul> <li><b>pwzGroupPassword</b>. This field must
///                     contain the password used to validate peers joining the peer group.</li> <li><b>groupPasswordRole</b>. This field
///                     must containing the GUID of the role (administrator or peer) for which the password is required.</li>
///                     <li><b>dwAuthenticationSchemes</b>. This field must have the <b>PEER_GROUP_PASSWORD_AUTHENTICATION</b> flag
///                     (0x00000001) set on it.</li> </ul>
@DllImport("P2P")
HRESULT PeerGroupCreatePasswordInvitation(void* hGroup, ushort** ppwzInvitation);

///The <b>PeerGroupParseInvitation</b> function returns a PEER_INVITATION_INFO structure with the details of a specific
///invitation.
///Params:
///    pwzInvitation = Pointer to a Unicode string that contains the specific peer group invitation. This parameter is required.
///    ppInvitationInfo = Pointer to a PEER_INVITATION_INFO structure with the details of a specific invitation. To release the resources
///                       used by this structure, pass this pointer to PeerFreeData. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete an operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVITATION_NOT_TRUSTED</b></dt> </dl> </td> <td width="60%"> The invitation is not trusted by the
///    peer. It has been altered or contains errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_UNSUPPORTED_VERSION</b></dt> </dl> </td> <td width="60%"> The invitation is not supported by the
///    current version of the Peer Infrastructure. </td> </tr> </table> Cryptography-specific errors can be returned
///    from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupParseInvitation(const(wchar)* pwzInvitation, PEER_INVITATION_INFO** ppInvitationInfo);

///The <b>PeerGroupGetStatus</b> function retrieves the current status of a group.
///Params:
///    hGroup = Handle to a peer group whose status is returned. This handle is returned by the PeerGroupCreate, PeerGroupOpen,
///             or PeerGroupJoin function. This parameter is required.
///    pdwStatus = Pointer to a set of PEER_GROUP_STATUS flags that describe the status of a peer group.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete an operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt>
///    </dl> </td> <td width="60%"> The handle to a group is invalid. </td> </tr> </table> Cryptography-specific errors
///    can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in
///    Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupGetStatus(void* hGroup, uint* pdwStatus);

///The <b>PeerGroupGetProperties</b> function retrieves information on the properties of a specified group.
///Params:
///    hGroup = Handle to a peer group whose properties are retrieved. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    ppProperties = Pointer to a PEER_GROUP_PROPERTIES structure that contains information about peer group properties. This data
///                   must be freed with PeerFreeData. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt>
///    </dl> </td> <td width="60%"> The group is not in a state where peer group properties can be retrieved. For
///    example, PeerGroupJoin is called, but synchronization with the group database has not completed. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td width="60%"> The handle to the peer
///    group is invalid. </td> </tr> </table> Cryptography-specific errors can be returned from the Microsoft RSA Base
///    Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupGetProperties(void* hGroup, PEER_GROUP_PROPERTIES** ppProperties);

///The <b>PeerGroupSetProperties</b> function sets the current peer group properties. In version 1.0 of this API, only
///the creator of the peer group can perform this operation.
///Params:
///    hGroup = Handle to the peer group whose properties are set by a peer. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pProperties = Pointer to a peer-populated PEER_GROUP_PROPERTIES structure that contains the new properties. To obtain this
///                  structure, a peer must first call PeerGroupGetProperties, change the appropriate fields, and then pass it as this
///                  parameter. This parameter is required. The following members of PEER_GROUP_PROPERTIES cannot be changed:<ul>
///                  <li><b>dwSize</b></li> <li><b>pwzCloud</b></li> <li><b>pwzClassifier</b></li> <li><b>pwzGroupPeerName</b></li>
///                  <li><b>pwzCreatorPeerName</b></li> </ul>
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt> </dl> </td> <td
///    width="60%"> The group is not in a state where peer group properties can be set. For example, PeerGroupJoin has
///    been called, but synchronization with the peer group database is not complete. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td width="60%"> The handle to the peer group is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP_PROPERTIES</b></dt> </dl> </td> <td
///    width="60%"> One or more of the specified properties is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_AUTHORIZED</b></dt> </dl> </td> <td width="60%"> The current identity does not have the
///    authorization to change these properties. In this case, the identity is not the creator of the peer group. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_PASSWORD_DOES_NOT_MEET_POLICY</b></dt> </dl> </td> <td
///    width="60%"> Password specified does not meet system password requirements. </td> </tr> </table>
///    Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with
///    CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupSetProperties(void* hGroup, PEER_GROUP_PROPERTIES* pProperties);

///The <b>PeerGroupEnumMembers</b> function creates an enumeration of available peer group members and the associated
///membership information.
///Params:
///    hGroup = Handle to the peer group whose members are enumerated. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    dwFlags = Specifies the PEER_MEMBER_FLAGS flags that indicate which types of members to include in the enumeration. If this
///              value is set to zero, all members of the peer group are included. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"><a id="PEER_MEMBER_PRESENT"></a><a id="peer_member_present"></a><dl>
///              <dt><b>PEER_MEMBER_PRESENT</b></dt> </dl> </td> <td width="60%"> Enumerate all members of the current peer group
///              that are online. </td> </tr> </table>
///    pwzIdentity = Unicode string that contains the identity of a specific peer whose information is retrieved and returned in a
///                  one-item enumeration. If this parameter is <b>NULL</b>, all members of the current peer group are retrieved. This
///                  parameter is required.
///    phPeerEnum = Pointer to the enumeration that contains the returned list of peer group members. This handle is passed to
///                 PeerGetNextItem to retrieve the items, with each item represented as a pointer to a PEER_MEMBER structure. When
///                 finished, PeerEndEnumeration is called to return the memory used by the enumeration. This parameter is required.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to perform the specified
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td
///    width="60%"> The handle to the peer group is invalid. </td> </tr> </table> Cryptography-specific errors can be
///    returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupEnumMembers(void* hGroup, uint dwFlags, const(wchar)* pwzIdentity, void** phPeerEnum);

///The <b>PeerGroupOpenDirectConnection</b> function establishes a direct connection with another peer in a peer group.
///Params:
///    hGroup = Handle to the peer group that hosts the direct connection. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pwzIdentity = Pointer to a Unicode string that contains the identity a peer connects to. This parameter is required.
///    pAddress = Pointer to a PEER_ADDRESS structure that contains the IPv6 address the peer connects to. This parameter is
///               required.
///    pullConnectionId = Unsigned 64-bit integer that identifies the direct connection. This ID value cannot be assumed as valid until the
///                       PEER_GROUP_EVENT_DIRECT_CONNECTION event is raised and indicates that the connection has been accepted by the
///                       other peer. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_CONNECT_SELF</b></dt>
///    </dl> </td> <td width="60%"> The connection failed because it was a loopback, that is, the connection is between
///    a peer and itself. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl> </td> <td
///    width="60%"> Access to the peer identity or peer group keys is denied. This is typically caused by an incorrect
///    access control list (ACL) for the folder that contains the user or computer keys. This can happen when the ACL
///    has been reset manually. </td> </tr> </table> Cryptography-specific errors can be returned from the Microsoft RSA
///    Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupOpenDirectConnection(void* hGroup, const(wchar)* pwzIdentity, PEER_ADDRESS* pAddress, 
                                      ulong* pullConnectionId);

///The <b>PeerGroupCloseDirectConnection</b> function closes a specific direct connection between two peers.
///Params:
///    hGroup = Handle to the peer group that contains the peers involved in the direct connection. This handle is returned by
///             the PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    ullConnectionId = Specifies the connection ID to disconnect from. This parameter is required and has no default value.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_CONNECTION_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> A direct connection that matches the
///    supplied connection ID cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td width="60%"> The handle to the peer group is invalid. </td>
///    </tr> </table> Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors
///    are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupCloseDirectConnection(void* hGroup, ulong ullConnectionId);

///The <b>PeerGroupEnumConnections</b> function creates an enumeration of connections currently active on the peer.
///Params:
///    hGroup = Handle to the group that contains the connections to be enumerated. This handle is returned by the
///             PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    dwFlags = Specifies the flags that indicate the type of connection to enumerate. Valid values are specified by
///              PEER_CONNECTION_FLAGS.
///    phPeerEnum = Pointer to the enumeration that contains the returned list of active connections. This handle is passed to
///                 PeerGetNextItem to retrieve the items, with each item represented as a pointer to a PEER_CONNECTION_INFO
///                 structure. When finished, PeerEndEnumeration is called to return the memory used by the enumeration. This
///                 parameter is required.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to perform the specified
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td
///    width="60%"> The handle to the peer group is invalid. </td> </tr> </table> Cryptography-specific errors can be
///    returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupEnumConnections(void* hGroup, uint dwFlags, void** phPeerEnum);

///The <b>PeerGroupSendData</b> function sends data to a member over a neighbor or direct connection.
///Params:
///    hGroup = Handle to the group that contains both members of a connection. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    ullConnectionId = Unsigned 64-bit integer that contains the ID of the connection that hosts the data transmission. A connection ID
///                      is obtained by calling PeerGroupOpenDirectConnection. This parameter is required.
///    pType = Pointer to a <b>GUID</b> value that uniquely identifies the data being transmitted. This parameter is required.
///    cbData = Specifies the size of the data in <i>pvData</i>, in bytes. This parameter is required.
///    pvData = Pointer to the block of data to send. The receiving application is responsible for parsing this data. This
///             parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_CONNECTION_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> A connection with
///    the ID specified in <i>ullConnectionId</i> cannot be found. </td> </tr> </table> Cryptography-specific errors can
///    be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in
///    Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupSendData(void* hGroup, ulong ullConnectionId, const(GUID)* pType, uint cbData, char* pvData);

///The <b>PeerGroupRegisterEvent</b> function registers a peer for specific peer group events.
///Params:
///    hGroup = Handle of the peer group on which to monitor the specific peer events. This handle is returned by the
///             PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    hEvent = Pointer to a Windows event handle, which is signaled when a peer event is fired. When this handle is signaled,
///             the peer should call PeerGroupGetEventData until the function returns <b>PEER_S_NO_EVENT_DATA</b>. This parameter
///             is required.
///    cEventRegistration = Contains the number of PEER_GROUP_EVENT_REGISTRATION structures listed in <i>pEventRegistrations</i>. This
///                         parameter is required.
///    pEventRegistrations = Pointer to a list of PEER_GROUP_EVENT_REGISTRATION structures that contains the peer event types for which
///                          registration occurs. This parameter is required.
///    phPeerEvent = Pointer to the returned HPEEREVENT handle. A peer can unregister for this peer event by passing this handle to
///                  PeerGroupUnregisterEvent. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt>
///    </dl> </td> <td width="60%"> The handle to the group is invalid. </td> </tr> </table> Cryptography-specific
///    errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined
///    in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupRegisterEvent(void* hGroup, HANDLE hEvent, uint cEventRegistration, char* pEventRegistrations, 
                               void** phPeerEvent);

///The <b>PeerGroupUnregisterEvent</b> function unregisters a peer from notification of peer events associated with the
///supplied event handle.
///Params:
///    hPeerEvent = Handle returned by a previous call to PeerGroupRegisterEvent. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns the following value. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> The parameter is not valid. </td> </tr> </table> Cryptography-specific errors can be
///    returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupUnregisterEvent(void* hPeerEvent);

///The <b>PeerGroupGetEventData</b> function allows an application to retrieve the data returned by a grouping event.
///Params:
///    hPeerEvent = Handle obtained from a previous call to PeerGroupRegisterEvent. This parameter is required.
///    ppEventData = Pointer to a [PEER_GROUP_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_group_event_data-r1) structure that
///                  contains data about the peer event. This data structure must be freed after use with PeerFreeData. This parameter
///                  is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_S_NO_EVENT_DATA</b></dt> </dl> </td> <td width="60%"> The call is successful,
///    but there is no event data available. </td> </tr> </table> Cryptography-specific errors can be returned from the
///    Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupGetEventData(void* hPeerEvent, PEER_GROUP_EVENT_DATA** ppEventData);

///The <b>PeerGroupGetRecord</b> function retrieves a specific group record.
///Params:
///    hGroup = Handle to a group that contains a specific record. This handle is returned by the PeerGroupCreate, PeerGroupOpen,
///             or PeerGroupJoin function. This parameter is required.
///    pRecordId = Specifies the GUID value that uniquely identifies a required record within a peer group. This parameter is
///                required.
///    ppRecord = Pointer to the address of a PEER_RECORD structure that contains a returned record. This structure is freed by
///               passing its pointer to PeerFreeData. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt>
///    </dl> </td> <td width="60%"> The peer group is not in a state where group records can be retrieved. For example,
///    PeerGroupJoin is called, but synchronization with the peer group database has not completed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td width="60%"> The handle to a peer group is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_RECORD_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> A record that matches the supplied ID cannot be found in a peer group database. </td> </tr> </table>
///    Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with
///    CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupGetRecord(void* hGroup, const(GUID)* pRecordId, PEER_RECORD** ppRecord);

///The <b>PeerGroupAddRecord</b> function adds a new record to the peer group, which is propagated to all participating
///peers.
///Params:
///    hGroup = Handle to the peer group. This handle is returned by the PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin
///             function. This parameter is required.
///    pRecord = Pointer to a PEER_RECORD structure that is added to the peer group specified in <i>hGroup</i>. This parameter is
///              required. The following members in PEER_RECORD must be populated. <ul> <li><b>dwSize</b></li>
///              <li><b>type</b></li> <li><b>ftExpiration</b></li> </ul> <b>ftExpiration</b> must be expressed as peer time (see
///              PeerGroupUniversalTimeToPeerTime). The following members are ignored and overwritten if populated. <ul>
///              <li><b>id</b></li> <li><b>pwzCreatorId</b></li> <li><b>pwzLastModifiedById</b></li> <li><b>ftCreation</b></li>
///              <li><b>ftLastModified</b></li> <li><b>securityData</b></li> </ul> The remaining fields are optional.
///    pRecordId = Pointer to a GUID that identifies the record. This parameter is required.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to perform the specified
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt> </dl> </td> <td
///    width="60%"> The peer group is not in a state where records can be added. For example, PeerGroupJoin is called,
///    but synchronization with the peer group database has not completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_ATTRIBUTES</b></dt> </dl> </td> <td width="60%"> The XML string that contains the record
///    attributes in the <b>pwzAttributes</b> member of the PEER_RECORD structure does not comply with the schema
///    specification. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td
///    width="60%"> The handle to the peer group is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_PEER_NAME</b></dt> </dl> </td> <td width="60%"> The supplied peer name is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_RECORD</b></dt> </dl> </td> <td width="60%"> One or more
///    fields in PEER_RECORD are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_MAX_RECORD_SIZE_EXCEEDED</b></dt> </dl> </td> <td width="60%"> The record has exceeded the maximum
///    size allowed by the peer group properties. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_AUTHORIZED</b></dt> </dl> </td> <td width="60%"> The identity is not authorized to publish a
///    record of that type. </td> </tr> </table> Cryptography-specific errors can be returned from the Microsoft RSA
///    Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupAddRecord(void* hGroup, PEER_RECORD* pRecord, GUID* pRecordId);

///The <b>PeerGroupUpdateRecord</b> function updates a record within a specific peer group.
///Params:
///    hGroup = Handle to the peer group whose record is updated. This handle is returned by the PeerGroupCreate, PeerGroupOpen,
///             or PeerGroupJoin function. This parameter is required.
///    pRecord = Pointer to a PEER_RECORD structure that contains the updated record for <i>hGroup</i>. This parameter is
///              required. The following members in PEER_RECORD can be updated. <ul> <li><b>pwzAttributes</b></li>
///              <li><b>ftExpiration</b></li> <li><b>data</b></li> </ul> The following members in PEER_RECORD must be present, but
///              cannot be changed. <ul> <li><b>dwSize</b></li> <li><b>id</b></li> <li><b>type</b></li> <li><b>dwFlags</b></li>
///              </ul> The following members are ignored if populated. <ul> <li><b>dwVersion</b></li> <li><b>pwzCreatorId</b></li>
///              <li><b>pwzModifiedById</b></li> <li><b>ftCreation</b></li> <li><b>ftLastModified</b></li>
///              <li><b>securityData</b></li> </ul> The members that remain are optional.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the specified parameters is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt> </dl> </td> <td width="60%"> The peer group is
///    not in a state where a record can be updated, for example, PeerGroupJoin has been called, but synchronization
///    with the peer group database is not complete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td width="60%"> The handle to the peer group is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_AUTHORIZED</b></dt> </dl> </td> <td width="60%"> The current
///    peer identity does not have the authorization to delete the record. In this case, the peer identity is not the
///    creator of the record. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_RECORD_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The record cannot be located in the data store. </td> </tr> </table> Cryptography-specific
///    errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined
///    in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupUpdateRecord(void* hGroup, PEER_RECORD* pRecord);

///The <b>PeerGroupDeleteRecord</b> function deletes a record from a peer group. The creator, as well as any other
///member in an administrative role may delete a specific record.
///Params:
///    hGroup = Handle to the peer group that contains the record. This handle is returned by the PeerGroupCreate, PeerGroupOpen,
///             or PeerGroupJoin function. This parameter is required.
///    pRecordId = Specifies the GUID value that uniquely identifies the record to be deleted. This parameter is required.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt>
///    </dl> </td> <td width="60%"> The peer group is not in a state where records can be deleted. For example,
///    PeerGroupJoin is called, but synchronization with the peer group database has not completed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td width="60%"> The handle to the peer group
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_AUTHORIZED</b></dt> </dl> </td> <td
///    width="60%"> The current identity does not have the authorization to delete the record. In this case, the
///    identity is not the creator or a member in an administrative role may delete a specific record. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_RECORD_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The record cannot be
///    located in the data store. </td> </tr> </table> Cryptography-specific errors can be returned from the Microsoft
///    RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupDeleteRecord(void* hGroup, const(GUID)* pRecordId);

///The <b>PeerGroupEnumRecords</b> function creates an enumeration of peer group records.
///Params:
///    hGroup = Handle to the peer group whose records are enumerated. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pRecordType = Pointer to a <b>GUID</b> value that uniquely identifies a specific record type. If this parameter is <b>NULL</b>,
///                  all records are returned.
///    phPeerEnum = Pointer to the enumeration that contains the returned list of records. This handle is passed to PeerGetNextItem
///                 to retrieve the items, with each item represented as a pointer to a PEER_RECORD structure. When finished,
///                 PeerEndEnumeration is called to return the memory used by the enumeration. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_GROUP</b></dt>
///    </dl> </td> <td width="60%"> The handle to the peer group is invalid. </td> </tr> </table> Cryptography-specific
///    errors can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined
///    in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupEnumRecords(void* hGroup, const(GUID)* pRecordType, void** phPeerEnum);

///The <b>PeerGroupSearchRecords</b> function searches the local peer group database for records that match the supplied
///criteria.
///Params:
///    hGroup = Handle to the peer group whose local database is searched. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pwzCriteria = Pointer to a Unicode XML string that contains the record search query. For information about formulating an XML
///                  query string to search the peer group records database, see the Record Search Query Format documentation. This
///                  parameter is required.
///    phPeerEnum = Pointer to the enumeration that contains the returned list of records. This handle is passed to PeerGetNextItem
///                 to retrieve the items with each item represented as a pointer to a PEER_RECORD structure. When finished,
///                 PeerEndEnumeration is called to return the memory used by the enumeration. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVALID_SEARCH</b></dt>
///    </dl> </td> <td width="60%"> The XML search query does not adhere to the search query schema specification. </td>
///    </tr> </table> Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors
///    are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupSearchRecords(void* hGroup, const(wchar)* pwzCriteria, void** phPeerEnum);

///The <b>PeerGroupExportDatabase</b> function exports a peer group database to a specific file, which can be
///transported to another computer and imported with the PeerGroupImportDatabase function.
///Params:
///    hGroup = Handle to the peer group whose database is exported to a local file on the peer. This handle is returned by the
///             PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pwzFilePath = Pointer to a Unicode string that contains the absolute file system path and file name where the exported database
///                  is stored. For example, "C:\backup\p2pdb.db". If this file already exists at the specified location, the older
///                  file is overwritten. This parameter is required.
///Returns:
///    Returns S_OK if the operation succeeds. Otherwise, the function returns one of the following values. <div
///    class="alert"><b>Note</b> If an export fails due to a file system error, the appropriate file system error,
///    defined in winerror.h, is returned.</div> <div> </div> <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters
///    is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    There is not enough memory to perform the specified operation. </td> </tr> </table> Cryptography-specific errors
///    can be returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in
///    Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupExportDatabase(void* hGroup, const(wchar)* pwzFilePath);

///The <b>PeerGroupImportDatabase</b> function imports a peer group database from a local file.
///Params:
///    hGroup = Handle to a peer group whose database is imported from a local file. This handle is returned by the
///             PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pwzFilePath = Pointer to a Unicode string that contains the absolute file system path and file name where the data is stored,
///                  for example, "C:\backup\p2pdb.db". If the file does not exist at this location, an appropriate error from the
///                  file system is returned. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values. <div
///    class="alert"><b>Note</b> If an import fails due to a file system error, the appropriate file system error is
///    returned.</div> <div> </div> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_IN_USE</b></dt> </dl> </td> <td width="60%"> The operation cannot
///    be completed because the peer group database is currently in use. For example, PeerGroupConnect has been called
///    by a peer, but has not yet completed any database transactions. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVALID_GROUP</b></dt> </dl> </td> <td width="60%"> The handle to the peer group is invalid. </td>
///    </tr> </table> Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors
///    are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupImportDatabase(void* hGroup, const(wchar)* pwzFilePath);

///The <b>PeerGroupIssueCredentials</b> function issues credentials, including a GMC, to a specific identity, and
///optionally returns an invitation XML string the invited peer can use to join a peer group.
///Params:
///    hGroup = Handle to a peer group for which a peer will issue credentials to potential invited peers. This handle is
///             returned by the PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pwzSubjectIdentity = Specifies the identity of a peer to whom credentials will be issued. This parameter is required.
///    pCredentialInfo = PEER_CREDENTIAL_INFO structure that contains information about the credentials of a peer whose identity is
///                      specified in <i>pwzSubjectIdentity</i>. If this parameter is <b>NULL</b>, the information stored in the peer
///                      database is used, instead. This parameter is optional. If this parameter is provided, the following fields in
///                      PEER_CREDENTIAL_INFO are ignored:<ul> <li><b>pwzIssuerPeerName</b></li> <li><b>pwzIssuerFriendlyName</b></li>
///                      </ul>
///    dwFlags = Specifies a set of flags used to describe actions taken when credentials are issued. If this parameter is set to
///              0 (zero), the credentials are returned in <i>ppwzInvitation</i>. This parameter is optional. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PEER_GROUP_STORE_CREDENTIALS"></a><a
///              id="peer_group_store_credentials"></a><dl> <dt><b>PEER_GROUP_STORE_CREDENTIALS</b></dt> </dl> </td> <td
///              width="60%"> Publish the subject identity's newly-created GMC in the group database. The GMC is picked up
///              automatically by the subject. If this flag is not set, the credentials must be obtained by a different
///              application such as email. </td> </tr> </table>
///    ppwzInvitation = Pointer to an invitation XML string returned by the function call. This invitation is passed out-of-band to the
///                     invited peer who uses it in a call to PeerGroupJoin. This parameter is optional.
///Returns:
///    Returns <b>S_OK</b> if the operation succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_IDENTITY_DELETED</b></dt> </dl> </td> <td width="60%"> The identity creating the credentials has
///    been deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_IDENTITY_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The identity cannot be found in the group database, and <i>pCredentialInfo</i> is <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl> </td> <td width="60%"> Access to the
///    identity or group keys is denied. Typically, this is caused by an incorrect access control list (ACL) for the
///    folder that contains the user or computer keys. This can happen when the ACL has been reset manually. </td> </tr>
///    </table> Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors are
///    prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupIssueCredentials(void* hGroup, const(wchar)* pwzSubjectIdentity, 
                                  PEER_CREDENTIAL_INFO* pCredentialInfo, uint dwFlags, ushort** ppwzInvitation);

///The <b>PeerGroupExportConfig</b> function exports the group configuration for a peer as an XML string that contains
///the identity, group name, and the GMC for the identity.
///Params:
///    hGroup = Handle to the group. This handle is returned by the PeerGroupCreate, PeerGroupOpen, or PeerGroupJoin function.
///             This parameter is required.
///    pwzPassword = Specifies the password used to protect the exported configuration. There are no rules or limits for the formation
///                  of this password. This parameter is required.
///    ppwzXML = Pointer to the returned XML configuration string that contains the identity, group peer name, cloud peer name,
///              group scope, and the GMC for the identity. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt>
///    </dl> </td> <td width="60%"> Access to the identity or group keys is denied. Typically, this is caused by an
///    incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen when
///    the ACL is reset manually . </td> </tr> </table> Cryptography-specific errors can be returned from the Microsoft
///    Base Cryptographic Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupExportConfig(void* hGroup, const(wchar)* pwzPassword, ushort** ppwzXML);

///The <b>PeerGroupImportConfig</b> function imports a peer group configuration for an identity based on the specific
///settings in a supplied XML configuration string.
///Params:
///    pwzXML = Specifies a Unicode string that contains a previously exported (using PeerGroupExportConfig) peer group
///             configuration. For the specific XML format of the string, see to the Remarks section of this topic. This
///             parameter is required.
///    pwzPassword = Specifies the password used to access the encrypted peer group configuration data, as a Unicode string. This
///                  parameter is required.
///    fOverwrite = If true, the existing group configuration is overwritten. If false, the group configuration is written only if a
///                 previous group configuration does not exist. The default value is false. This parameter is required.
///    ppwzIdentity = Contains the peer identity returned after an import completes. This parameter is required.
///    ppwzGroup = Contains a peer group peer name returned after an import completes. This parameter is required.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds. Otherwise, the function returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform a specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> A peer group configuration already exists, and <i>fOverwrite</i> is set to false. </td>
///    </tr> </table> Cryptography-specific errors can be returned from the Microsoft RSA Base Provider. These errors
///    are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupImportConfig(const(wchar)* pwzXML, const(wchar)* pwzPassword, BOOL fOverwrite, 
                              ushort** ppwzIdentity, ushort** ppwzGroup);

///The <b>PeerGroupPeerTimeToUniversalTime</b> function converts the peer group-maintained reference time value to a
///localized time value appropriate for display on a peer computer.
///Params:
///    hGroup = Handle to the peer group that a peer participates in. This handle is returned by the PeerGroupCreate,
///             PeerGroupOpen, or PeerGroupJoin function. This parameter is required.
///    pftPeerTime = Pointer to the peer time value—Coordinated Universal Time (UTC)—that is represented as a FILETIME structure.
///                  This parameter is required.
///    pftUniversalTime = Pointer to the returned universal time value that is represented as a FILETIME structure. This parameter is
///                       <b>NULL</b> if an error occurs.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds. Otherwise, the function returns either one of the remote procedure
///    call (RPC) errors or one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt> </dl> </td> <td width="60%">
///    The peer group is not in a state that peer time can be retrieved accurately, for example, PeerGroupJoin has been
///    called, but synchronization with the group database has not completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The peer group must be initialized with a
///    call to PeerGroupStartup before using this function. </td> </tr> </table> Cryptography-specific errors can be
///    returned from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupPeerTimeToUniversalTime(void* hGroup, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

///The <b>PeerGroupUniversalTimeToPeerTime</b> function converts a local time value from a peer's computer to a common
///peer group time value.
///Params:
///    hGroup = Handle to the peer group a peer participates in. This handle is returned by the PeerGroupCreate, PeerGroupOpen,
///             or PeerGroupJoin function. This parameter is required.
///    pftUniversalTime = Pointer to the universal time value, represented as a FILETIME structure. This parameter is required.
///    pftPeerTime = Pointer to the returned peer time—Greenwich Mean Time (GMT) value that is represented as a FILETIME structure.
///                  This parameter is <b>NULL</b> if an error occurs.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds. Otherwise, the function returns either one of the RPC errors or one
///    of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_GROUP_NOT_READY</b></dt> </dl> </td> <td width="60%"> The peer group is not
///    in a state where peer time can be accurately calculated. For example, PeerGroupJoin has been called, but
///    synchronization with the peer group database has not completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The group must be initialized with a call to
///    PeerGroupStartup before using this function. </td> </tr> </table> Cryptography-specific errors can be returned
///    from the Microsoft RSA Base Provider. These errors are prefixed with CRYPT_* and defined in Winerror.h.
///    
@DllImport("P2P")
HRESULT PeerGroupUniversalTimeToPeerTime(void* hGroup, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

@DllImport("P2P")
HRESULT PeerGroupResumePasswordAuthentication(void* hGroup, void* hPeerEventHandle);

///The <b>PeerIdentityCreate</b> function creates a new peer identity and returns its name. The name of the peer
///identity must be passed in all subsequent calls to the Peer Identity Manager, Peer Grouping, or PNRP functions that
///operate on behalf of the peer identity. The peer identity name specifies which peer identity is being used.
///Params:
///    pwzClassifier = Specifies the classifier to append to the published peer identity name. This string is a Unicode string, and can
///                    be <b>NULL</b>. This string can only be 150 characters long, including the <b>NULL</b> terminator.
///    pwzFriendlyName = Specifies the friendly name of the peer identity. This is a Unicode string, and can be <b>NULL</b>. This string
///                      can only be 256 characters long, including the <b>NULL</b> terminator. If <i>pwzFriendlyName</i> is <b>NULL</b>,
///                      the name of the identity is the friendly name. The friendly name is optional, and it does not have to be unique.
///    hCryptProv = Handle to the cryptographic service provider (CSP) that contains an AT_KEYEXCHANGE key pair of at least 1024 bits
///                 in length. This key pair is used as the basis for a new peer identity. If <i>hCryptProv</i> is zero (0), a new
///                 key pair is generated for the peer identity. <div class="alert"><b>Note</b> The Identity Manager API does not
///                 support a CSP that has user protected keys. If a CSP that has user protected keys is used,
///                 <b>PeerIdentityCreate</b> returns <b>E_INVALIDARG</b>. </div> <div> </div>
///    ppwzIdentity = Receives a pointer to the name of an peer identity that is created. This name must be used in all subsequent
///                   calls to the Peer Identity Manager, Peer Grouping, or PNRP functions that operate on behalf of the peer identity.
///                   Returns <b>NULL</b> if the peer identity cannot be created.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle to the key specified by
///    <i>hCryptProv</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to perform the specified
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_ALREADY_EXISTS </b></dt> </dl> </td> <td
///    width="60%"> The peer identity already exists. Only occurs if an peer identity based on the specified key and
///    classifier already exists. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt> </dl>
///    </td> <td width="60%"> Access to the peer identity or peer group keys is denied. Typically, this is caused by an
///    incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen when
///    the ACL has been reset manually. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_TOO_MANY_IDENTITIES</b></dt> </dl> </td> <td width="60%"> The peer identity cannot be created
///    because there are too many peer identities. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerIdentityCreate(const(wchar)* pwzClassifier, const(wchar)* pwzFriendlyName, size_t hCryptProv, 
                           ushort** ppwzIdentity);

///The <b>PeerIdentityGetFriendlyName</b> function returns the friendly name of the peer identity.
///Params:
///    pwzIdentity = Specifies the peer identity to obtain a friendly name.
///    ppwzFriendlyName = Receives a pointer to the friendly name. When <i>ppwzFriendlyName</i> is not required anymore, the application is
///                       responsible for freeing this string by calling PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt>
///    </dl> </td> <td width="60%"> Access to the peer identity or peer group keys is denied. Typically, this is caused
///    by an incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen
///    when the ACL has been reset manually. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> A peer identity that matches the specified name cannot be found. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerIdentityGetFriendlyName(const(wchar)* pwzIdentity, ushort** ppwzFriendlyName);

///The <b>PeerIdentitySetFriendlyName</b> function modifies the friendly name for a specified peer identity. The
///friendly name is the human-readable name.
///Params:
///    pwzIdentity = Specifies a peer identity to modify.
///    pwzFriendlyName = Specifies a new friendly name. Specify <b>NULL</b> or an empty string to reset a friendly name to the default
///                      value, which is the Unicode version of the peer name.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt>
///    </dl> </td> <td width="60%"> Access to the peer identity or peer group keys is denied. Typically, this is caused
///    by an incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen
///    when the ACL has been reset manually. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> A peer identity that matches a specified name cannot be found. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerIdentitySetFriendlyName(const(wchar)* pwzIdentity, const(wchar)* pwzFriendlyName);

///The <b>PeerIdentityGetCryptKey</b> function retrieves a handle to a cryptographic service provider (CSP).
///Params:
///    pwzIdentity = Specifies the peer identity to retrieve the key pair for.
///    phCryptProv = Receives a pointer to the handle of the cryptographic service provider (CSP) that contains an AT_KEYEXCHANGE RSA
///                  key pair.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_KEY_ACCESS</b></dt>
///    </dl> </td> <td width="60%"> Access to the peer identity or peer group keys is denied. Typically, this is caused
///    by an incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen
///    when the ACL has been manually reset. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> An identity that matches the specified name cannot be found. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerIdentityGetCryptKey(const(wchar)* pwzIdentity, size_t* phCryptProv);

///The <b>PeerIdentityDelete</b> function permanently deletes a peer identity. This includes removing all certificates,
///private keys, and all group information associated with a specified peer identity.
///Params:
///    pwzIdentity = Specifies a peer identity to delete.
@DllImport("P2P")
HRESULT PeerIdentityDelete(const(wchar)* pwzIdentity);

///The <b>PeerEnumIdentities</b> function creates and returns a peer enumeration handle used to enumerate all the peer
///identities that belong to a specific user.
///Params:
///    phPeerEnum = Receives a handle to the peer enumeration that contains the list of peer identities, with each item represented
///                 as a pointer to a PEER_NAME_PAIR structure. Pass this handle to PeerGetNextItem to retrieve the items; when
///                 finished, call PeerEndEnumeration to release the memory.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerEnumIdentities(void** phPeerEnum);

///The <b>PeerEnumGroups</b> function creates and returns a peer enumeration handle used to enumerate all the peer
///groups associated with a specific peer identity.
///Params:
///    pwzIdentity = Specifies the peer identity to enumerate groups for.
///    phPeerEnum = Receives a handle to the peer enumeration that contains the list of peer groups that the specified identity is a
///                 member of, with each item represented as a pointer to a PEER_NAME_PAIR structure. Pass this handle to
///                 PeerGetNextItem to retrieve the items; when finished, call PeerEndEnumeration release the memory.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The specified peer identity cannot be found. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerEnumGroups(const(wchar)* pwzIdentity, void** phPeerEnum);

///The <b>PeerCreatePeerName</b> function creates a new name based on the existing name of the specified peer identity
///and classifier. However, a new identity is not created by a call to <b>PeerCreatePeerName</b>.
///Params:
///    pwzIdentity = Specifies the identity to use as the basis for the new peer name. If <i>pwzIdentity</i> is <b>NULL</b>, the name
///                  created is not based on any peer identity, and is therefore an unsecured name. This parameter can only be
///                  <b>NULL</b> if <i>pwzClassifier</i> is not <b>NULL</b>.
///    pwzClassifier = Pointer to the Unicode string that contains the new classifier. This classifier is appended to the existing
///                    authority portion of the peer name of the specified identity. This string is 150 characters long, including the
///                    <b>NULL</b> terminator. Specify <b>NULL</b> to return the peer name of the identity. This parameter can only be
///                    <b>NULL</b> if <i>pwzIdentity</i> is not <b>NULL</b>.
///    ppwzPeerName = Pointer that receives a pointer to the new peer name. When this string is not required anymore, free it by
///                   calling PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCreatePeerName(const(wchar)* pwzIdentity, const(wchar)* pwzClassifier, ushort** ppwzPeerName);

///The <b>PeerIdentityGetXML</b> function returns a description of the peer identity, which can then be passed to third
///parties and used to invite a peer identity into a peer group. This information is returned as an XML fragment.
///Params:
///    pwzIdentity = Specifies the peer identity to retrieve peer identity information for. When this parameter is passed as
///                  <b>NULL</b>, a "default" identity will be generated for the user by the peer infrastructure.
///    ppwzIdentityXML = Pointer to a pointer to a Unicode string that contains the XML fragment. When <i>ppwzIdentityXML</i> is no longer
///                      required, the application is responsible for freeing this string by calling PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is S_OK. Otherwise, it returns one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt>
///    </dl> </td> <td width="60%"> The handle to the identity is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerIdentityGetXML(const(wchar)* pwzIdentity, ushort** ppwzIdentityXML);

///The <b>PeerIdentityExport</b> function allows a user to export one peer identity. The user can then transfer the peer
///identity to a different computer.
///Params:
///    pwzIdentity = Specifies the peer identity to export. This parameter is required and does not have a default value.
///    pwzPassword = Specifies the password to use to encrypt the peer identity. This parameter cannot be <b>NULL</b>. This password
///                  must also be used to import the peer identity, or the import operation fails.
///    ppwzExportXML = Receives a pointer to the exported peer identity in XML format. If the export operation is successful, the
///                    application must free <i>ppwzExportXML</i> by calling PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> PEER_E_NO_KEY_ACCESS</b></dt>
///    </dl> </td> <td width="60%"> Access to the peer identity or peer group keys was denied. This is typically caused
///    by an incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen
///    when the ACL has been manually reset. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND </b></dt>
///    </dl> </td> <td width="60%"> The specified peer identity does not exist. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerIdentityExport(const(wchar)* pwzIdentity, const(wchar)* pwzPassword, ushort** ppwzExportXML);

///The <b>PeerIdentityImport</b> function imports one peer identity. If the peer identity exists on a computer,
///<b>PEER_E_ALREADY_EXISTS</b> is returned.
///Params:
///    pwzImportXML = Pointer to the XML format peer identity to import, which is returned by PeerIdentityExport. This binary data must
///                   match the exported data byte-for-byte. The XML must remain valid XML with no extra characters.
///    pwzPassword = Specifies the password to use to de-crypt a peer identity. The password must be identical to the password
///                  supplied to PeerIdentityExport. This parameter cannot be <b>NULL</b>.
///    ppwzIdentity = Pointer to a string that represents a peer identity that is imported. If the import operation is successful, the
///                   application must free <i>ppwzIdentity</i> by calling PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid, or the XML data in
///    <i>ppwzImportXML</i> has been tampered with. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
///    </dl> </td> <td width="60%"> There is not enough memory to perform the specified operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> The peer identity already
///    exists on this computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> PEER_E_NO_KEY_ACCESS</b></dt> </dl> </td>
///    <td width="60%"> Access to the peer identity or peer group keys is denied. Typically, this is caused by an
///    incorrect access control list (ACL) for the folder that contains the user or computer keys. This can happen when
///    the ACL has been reset manually. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerIdentityImport(const(wchar)* pwzImportXML, const(wchar)* pwzPassword, ushort** ppwzIdentity);

///The <b>PeerIdentityGetDefault</b> function retrieves the default peer name set for the current user.
///Params:
///    ppwzPeerName = Pointer to the address of a zero-terminated Unicode string that contains the default name of the current user.
@DllImport("P2P")
HRESULT PeerIdentityGetDefault(ushort** ppwzPeerName);

///The <b>PeerCollabStartup</b> function initializes the Peer Collaboration infrastructure.
///Params:
///    wVersionRequested = Contains the minimum version of the Peer Collaboration infrastructure requested by the peer.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PEER_E_UNSUPPORTED_VERSION</b></dt> </dl> </td> <td width="60%"> The requested version of the Peer
///    Collaboration Infrastructure is not supported. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabStartup(ushort wVersionRequested);

///The <b>PeerCollabShutdown</b> function shuts down the Peer Collaboration infrastructure and releases any resources
///associated with it.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The application did not make a previous
///    call to PeerCollabStartup. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabShutdown();

///The <b>PeerCollabSignin</b> function signs the peer into a hosted Internet (serverless presence) or subnet ("People
///Near Me") peer collaboration network presence provider.
///Params:
///    hwndParent = Windows handle to the parent application signing in.
///    dwSigninOptions = PEER_SIGNIN_FLAGS enumeration value that contains the presence provider sign-in options for the calling peer.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The application did not
///    make a previous call to PeerCollabStartup. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_SERVICE_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> An attempt was made to call
///    PeerCollabSignIn from an elevated process. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_S_NO_CONNECTIVITY</b></dt> </dl> </td> <td width="60%"> The sign-in succeeded, but IPv6 addresses are
///    not available at this time. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabSignin(HWND hwndParent, uint dwSigninOptions);

///The <b>PeerCollabSignout</b> function signs a peer out of a specific type of peer collaboration network presence
///provider.
///Params:
///    dwSigninOptions = PEER_SIGNIN_FLAGS enumeration value that contains the presence provider sign-in options for the calling peer.
///                      This value is obtained by calling PeerCollabGetSigninOptions from the peer application.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The application did not
///    make a previous call to PeerCollabStartup. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabSignout(uint dwSigninOptions);

///The <b>PeerCollabGetSigninOptions</b> function obtains the peer's current signed-in peer collaboration network
///presence options.
///Params:
///    pdwSigninOptions = The PEER_SIGNIN_FLAGS enumeration value is returned by this function.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The application did not
///    make a previous call to PeerCollabStartup. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The application has not signed into the peer
///    collaboration network with a previous call to PeerCollabSignIn. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetSigninOptions(uint* pdwSigninOptions);

///The <b>PeerCollabAsyncInviteContact</b> function sends an invitation to a trusted peer contact to join the sender's
///peer collaboration activity over a secured connection. The availability of the invitation response is updated through
///an asynchronous event.
///Params:
///    pcContact = Pointer to a PEER_CONTACT structure that contains the contact information associated with the recipient of the
///                invite. This parameter is optional. To invite the endpoint of the calling peer specified in <i>pcEndpoint</i>,
///                set the pointer value to <b>NULL</b>.
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains information about the invited peer's endpoint. The endpoint
///                 must be associated with the peer contact specified in <i>pcContact</i>.
///    pcInvitation = Pointer to a PEER_INVITATION structure that contains the invitation request to send to the endpoint specified in
///                   <i>pcEndpoint</i>. E_INVALIDARG is returned if this parameter is set to <b>NULL</b>.
///    hEvent = Handle to the event for this invitation, created by a previous call to CreateEvent. The event is signaled when
///             the status of the asynchronous invitation is updated. To obtain the response data, call
///             PeerCollabGetInvitationResponse. If the event is not provided the caller must poll for the result by calling
///             PeerCollabGetInvitationResponse.
///    phInvitation = A pointer to a handle to the sent invitation. The framework will cleanup the response information after the
///                   invitation response is received if <b>NULL</b> is specified. When <b>NULL</b> is not the specified handle to the
///                   invitation provided, it must be closed by calling PeerCollabCloseHandle.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> <i>pcEndpoint</i> is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The
///    Windows Peer infrastructure is not initialized. Calling the relevant initialization function is required. </td>
///    </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabAsyncInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, 
                                     PEER_INVITATION* pcInvitation, HANDLE hEvent, HANDLE* phInvitation);

///The <b>PeerCollabGetInvitationResponse</b> function obtains the response from a peer previously invited to join a
///peer collaboration activity.
///Params:
///    hInvitation = Handle to an invitation to join a peer collaboration activity.
///    ppInvitationResponse = Pointer to the address of a PEER_INVITATION_RESPONSE structure that contains an invited peer's response to a
///                           previously transmitted invitation request. Free the memory associated with this structure by calling
///                           PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> The provided handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to support this operation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The
///    invitation recipient could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_INVITE_CANCELED</b></dt> </dl> </td> <td width="60%"> The invitation was previously canceled. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_INVITE_RESPONSE_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The response to the peer invitation is not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_CONNECTION_FAILED</b></dt> </dl> </td> <td width="60%"> A connection to the graph or group has
///    failed, or a direct connection in a graph or group has failed. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetInvitationResponse(HANDLE hInvitation, PEER_INVITATION_RESPONSE** ppInvitationResponse);

///The <b>PeerCollabCancelInvitation</b> function cancels an invitation previously sent by the caller to a contact.
///Params:
///    hInvitation = Handle to a previously sent invitation.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The provided handle is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The application did not
///    make a previous call to PeerCollabStartup. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The handle specified is invalid. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabCancelInvitation(HANDLE hInvitation);

///The <b>PeerCollabCloseHandle</b> function closes the handle to a Peer Collaboration activity invitation.
///Params:
///    hInvitation = Handle obtained by a previous call to PeerCollabAsyncInviteContact or PeerCollabAsyncInviteEndpoint.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified is invalid. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabCloseHandle(HANDLE hInvitation);

///The <b>PeerCollabInviteContact</b> function sends an invitation to join a peer collaboration activity to a trusted
///contact. This call is synchronous and, if successful, obtains a response from the contact.
///Params:
///    pcContact = Pointer to a PEER_CONTACT structure that contains the contact information associated with the invitee.
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains information about the invited peer. This peer is sent an
///                 invitation when this API is called.
///    pcInvitation = Pointer to a PEER_INVITATION structure that contains the invitation request to send to the endpoint(s) specified
///                   in <i>pcEndpoint</i>. This parameter must not be set to <b>NULL</b>.
///    ppResponse = Pointer to a PEER_INVITATION_RESPONSE structure that receives an invited peer endpoint's responses to the
///                 invitation request. If this call fails with an error, this parameter will be <b>NULL</b>. Free the memory
///                 returned by calling PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The recipient of the invitation
///    has not responded within 5 minutes. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, 
                                PEER_INVITATION_RESPONSE** ppResponse);

///The <b>PeerCollabAsyncInviteEndpoint</b> function sends an invitation to a specified peer endpoint to join the
///sender's peer collaboration activity. The availability of the response to the invitation is updated through an
///asynchronous event.
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains information about the invited peer. This peer is sent an
///                 invitation when this API is called. This parameter must not be set to <b>NULL</b>.
///    pcInvitation = Pointer to a PEER_INVITATION structure that contains the invitation request to send to the endpoint specified in
///                   <i>pcEndpoint</i>. E_INVALIDARG is returned if this parameter is set to <b>NULL</b>.
///    hEvent = Handle to the event for this invitation, created by a previous call to CreateEvent. The event is signaled when
///             the status of the asynchronous invitation is updated. To obtain the response data, call
///             PeerCollabGetInvitationResponse. If the event is not provided, the caller must poll for the result by calling
///             PeerCollabGetInvitationResponse.
///    phInvitation = A pointer to a handle to the sent invitation. If this parameter is <b>NULL</b>, the framework will cleanup the
///                   response information after the invitation response is received. If this parameter is not <b>NULL</b>, the handle
///                   must be closed by calling PeerCollabCloseHandle.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabAsyncInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, HANDLE hEvent, 
                                      HANDLE* phInvitation);

///The <b>PeerCollabInviteEndpoint</b> function sends an invitation to a specified peer endpoint to join the sender's
///peer collaboration activity. This call is synchronous and, if successful, obtains a response from the peer endpoint.
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains information about the invited peer. This peer is sent an
///                 invitation when this API is called. This parameter must not be set to <b>NULL</b>.
///    pcInvitation = Pointer to a PEER_INVITATION structure that contains the invitation request to send to the endpoint specified in
///                   <i>pcEndpoint</i>. This parameter must not be set to <b>NULL</b>.
///    ppResponse = Pointer to a PEER_INVITATION_RESPONSE structure that receives an invited peer endpoint's responses to the
///                 invitation request. If this call fails with an error, on output this parameter will be <b>NULL</b>. Free the
///                 memory associated with this structure by pass it to PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The recipient of the invitation
///    has not responded within 5 minutes. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, 
                                 PEER_INVITATION_RESPONSE** ppResponse);

///The <b>PeerCollabGetAppLaunchInfo</b> function obtains the peer application launch information, including the contact
///name, the peer endpoint, and the invitation request.
///Params:
///    ppLaunchInfo = Pointer to a PEER_APP_LAUNCH_INFO structure that receives the peer application launch data. Free the memory
///                   associated with this structure by passing it to PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested data does not
///    exist. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetAppLaunchInfo(PEER_APP_LAUNCH_INFO** ppLaunchInfo);

///The <b>PeerCollabRegisterApplication</b> function registers an application with the local computer so that it can be
///launched in a peer collaboration activity.
///Params:
///    pcApplication = Pointer to a PEER_APPLICATION_REGISTRATION_INFO structure that contains the UUID of the peer's application
///                    feature set as well as any additional peer-specific data.
///    registrationType = A PEER_APPLICATION_REGISTRATION_TYPE value that describes whether the peer's application is registered to the
///                       <b>current user</b> or <b>all users</b> of the peer's machine.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabRegisterApplication(PEER_APPLICATION_REGISTRATION_INFO* pcApplication, 
                                      PEER_APPLICATION_REGISTRATION_TYPE registrationType);

///The <b>PeerCollabUnregisterApplication</b> function unregisters the specific applications of a peer from the local
///computer.
///Params:
///    pApplicationId = Pointer to the GUID value that represents a particular peer's application.
///    registrationType = A PEER_APPLICATION_REGISTRATION_TYPE value that describes whether the peer's application is deregistered for the
///                       current user or all users of the peer's machine.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The application requested to
///    unregister was not registered for the given <i>registrationType.</i> </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabUnregisterApplication(const(GUID)* pApplicationId, 
                                        PEER_APPLICATION_REGISTRATION_TYPE registrationType);

///The <b>PeerCollabGetApplicationRegistrationInfo</b> function obtains application-specific registration information.
///Params:
///    pApplicationId = Pointer to the GUID value that represents a particular peer's application registration flags.
///    registrationType = A PEER_APPLICATION_REGISTRATION_TYPE enumeration value that describes whether the peer's application is
///                       registered to the current user or all users of the local machine.
///    ppApplication = Pointer to the address of a PEER_APPLICATION_REGISTRATION_INFO structure that contains the information about a
///                    peer's specific registered application. The data returned in this parameter can be freed by calling PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested application is
///    not registered for the given <i>registrationType</i>. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetApplicationRegistrationInfo(const(GUID)* pApplicationId, 
                                                 PEER_APPLICATION_REGISTRATION_TYPE registrationType, 
                                                 PEER_APPLICATION_REGISTRATION_INFO** ppApplication);

///The <b>PeerCollabEnumApplicationRegistrationInfo</b> function obtains the enumeration handle used to retrieve peer
///application information.
///Params:
///    registrationType = A PEER_APPLICATION_REGISTRATION_TYPE value that specifies whether the peer's application is registered to the
///                       <b>current user</b> or <b>all users</b> of the peer's machine.
///    phPeerEnum = Pointer to a peer enumeration handle for the peer application registration information. This data is obtained by
///                 passing this handle to PeerGetNextItem.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabEnumApplicationRegistrationInfo(PEER_APPLICATION_REGISTRATION_TYPE registrationType, 
                                                  void** phPeerEnum);

///The <b>PeerCollabGetPresenceInfo</b> function retrieves the presence information for the endpoint associated with a
///specific contact.
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains the specific endpoint associated with the contact specified in
///                 <i>pcContact</i> for which presence information must be returned.
///    ppPresenceInfo = Pointer to the address of the PEER_PRESENCE_INFO structure that contains the requested presence data for the
///                     supplied endpoint.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The application did not
///    make a previous call to PeerCollabStartup. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The presence information for the specified endpoint
///    was not found in the peer collaboration network. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetPresenceInfo(PEER_ENDPOINT* pcEndpoint, PEER_PRESENCE_INFO** ppPresenceInfo);

///The <b>PeerCollabEnumApplications</b> function returns the handle to an enumeration that contains the applications
///registered to a specific peer's endpoint(s).
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains the endpoint information for a peer whose applications will be
///                 enumerated. If this parameter is set to <b>NULL</b>, the published application information for the local peer's
///                 endpoint is enumerated.
///    pApplicationId = Pointer to the GUID value that uniquely identifies a particular application of the supplied peer. If this
///                     parameter is supplied, the only peer application returned is the one that matches this GUID.
///    phPeerEnum = Pointer to the handle for the enumerated set of registered applications that correspond to the GUID returned in
///                 <i>pObjectId</i>. Pass this handle to PeerGetNextItem to obtain each item in the enumerated set.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabEnumApplications(PEER_ENDPOINT* pcEndpoint, const(GUID)* pApplicationId, void** phPeerEnum);

///The <b>PeerCollabEnumObjects</b> function returns the handle to an enumeration that contains the peer objects
///associated with a specific peer's endpoint.
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains the endpoint information for a peer whose objects will be
///                 enumerated. If this parameter is <b>NULL</b> the published objects of the local peer's contacts are returned.
///    pObjectId = Pointer to a GUID value that uniquely identifies a peer object with the supplied peer. If this parameter is
///                supplied, the only peer object returned is the one that matches this GUID.
///    phPeerEnum = Pointer to the handle for the enumerated set of peer objects that correspond to the GUID returned in
///                 <i>pObjectId</i>. Pass this handle to PeerGetNextItem to obtain each item in the enumerated set.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires the
///    user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabEnumObjects(PEER_ENDPOINT* pcEndpoint, const(GUID)* pObjectId, void** phPeerEnum);

///The <b>PeerCollabEnumEndpoints</b> function returns the handle to an enumeration that contains the endpoints
///associated with a specific peer contact.
///Params:
///    pcContact = Pointer to a PEER_CONTACT structure that contains the contact information for a specific peer. This parameter
///                must not be <b>NULL</b>.
///    phPeerEnum = Pointer to a handle for the enumerated set of endpoints that are associated with the supplied peer contact. Pass
///                 this handle to PeerGetNextItem to obtain each item in the enumerated set.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires the
///    user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabEnumEndpoints(PEER_CONTACT* pcContact, void** phPeerEnum);

///The <b>PeerCollabRefreshEndpointData</b> function updates the calling peer node with new endpoint data.
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains the updated peer endpoint information for the current peer
///                 node.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabRefreshEndpointData(PEER_ENDPOINT* pcEndpoint);

///The <b>PeerCollabDeleteEndpointData</b> function deletes the peer endpoint data on the calling peer node that matches
///the supplied endpoint data.
///Params:
///    pcEndpoint = Pointer to a [PEER_ENDPOINT](./ns-p2p-peer_endpoint.md) structure that contains the peer endpoint information to
///                 delete from the current peer node.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabDeleteEndpointData(PEER_ENDPOINT* pcEndpoint);

///The <b>PeerCollabQueryContactData</b> function retrieves the contact information for the supplied peer endpoint.
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains the peer endpoint about which to obtain contact information.
///                 If this parameter is set to <b>NULL</b>, the contact information for the current peer endpoint is obtained.
///    ppwzContactData = Pointer to a zero-terminated Unicode string buffer that contains the contact data for the endpoint supplied in
///                      <i>pcEndpoint</i>. Call PeerFreeData to free the data.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested contact data
///    does not exist. Try calling PeerCollabRefreshEndpointData before making another attempt. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabQueryContactData(PEER_ENDPOINT* pcEndpoint, ushort** ppwzContactData);

///The <b>PeerCollabSubscribeEndpointData</b> function creates a subscription to an available endpoint.
///Params:
///    pcEndpoint = Pointer to a PEER_ENDPOINT structure that contains the peer endpoint used to obtain presence information.
///Returns:
///    Returns S_OK or PEER_S_SUBSCRIPTION_EXISTS if the function succeeds. Otherwise, the function returns one of the
///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to support this operation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
///    arguments is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td>
///    <td width="60%"> The Windows Peer infrastructure is not initialized. Calling the relevant initialization function
///    is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabSubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

///The <b>PeerCollabUnsubscribeEndpointData</b> function removes a subscription to an endpoint created with
///PeerCollabSubscribeEndpointData.
///Params:
///    pcEndpoint = Pointer to a [PEER_ENDPOINT](./ns-p2p-peer_endpoint.md) structure that contains the peer endpoint that is used to
///                 remove the subscription.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabUnsubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

///The <b>PeerCollabSetPresenceInfo</b> function updates the caller's presence information to any contacts watching it.
///Params:
///    pcPresenceInfo = Pointer to a PEER_PRESENCE_INFO structure that contains the new presence information to publish for the calling
///                     peer application.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires the
///    user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabSetPresenceInfo(PEER_PRESENCE_INFO* pcPresenceInfo);

///The <b>PeerCollabGetEndpointName</b> function retrieves the name of the current endpoint of the calling peer, as
///previously set by a call to PeerCollabSetEndpointName.
///Params:
///    ppwzEndpointName = Pointer to a zero-terminated Unicode string name of the peer endpoint currently used by the calling application.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires the
///    user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetEndpointName(ushort** ppwzEndpointName);

///The <b>PeerCollabSetEndpointName</b> function sets the name of the current endpoint used by the peer application.
///Params:
///    pwzEndpointName = Pointer to the new name of the current endpoint, represented as a zero-terminated Unicode string. An error is
///                      raised if the new name is the same as the current one. An endpoint name is limited to 255 Unicode characters.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires
///    the user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabSetEndpointName(const(wchar)* pwzEndpointName);

///The <b>PeerCollabSetObject</b> function creates or updates a peer data object used in a peer collaboration network.
///Params:
///    pcObject = Pointer to a PEER_OBJECT structure that contains the peer object on the peer collaboration network.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires the
///    user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabSetObject(PEER_OBJECT* pcObject);

///The <b>PeerCollabDeleteObject</b> function deletes a peer object from the calling endpoint.
///Params:
///    pObjectId = Pointer to a GUID value that uniquely identifies the peer object to delete from the calling endpoint.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires the
///    user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabDeleteObject(const(GUID)* pObjectId);

///The <b>PeerCollabRegisterEvent</b> function registers an application with the peer collaboration infrastructure to
///receive callbacks for specific peer collaboration events.
///Params:
///    hEvent = Handle created by CreateEvent that the application is signaled on when an event is triggered. When an application
///             is signaled, it must call PeerCollabGetEventData to retrieve events until PEER_S_NO_EVENT_DATA is returned.
///    cEventRegistration = The number of PEER_COLLAB_EVENT_REGISTRATION structures in <i>pEventRegistrations</i>.
///    pEventRegistrations = An array of PEER_COLLAB_EVENT_REGISTRATION structures that specify the peer collaboration events for which the
///                          application requests notification.
///    phPeerEvent = The peer event handle returned by this function. This handle is passed to PeerCollabGetEventData when a peer
///                  collaboration network event is raised on the peer.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_SERVICE_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> An attempt was
///    made to call PeerCollabRegisterEvent from an elevated process. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer infrastructure is not
///    initialized. Calling the relevant initialization function is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabRegisterEvent(HANDLE hEvent, uint cEventRegistration, char* pEventRegistrations, 
                                void** phPeerEvent);

///The <b>PeerCollabGetEventData</b> function obtains the data associated with a peer collaboration event raised on the
///peer.
///Params:
///    hPeerEvent = The peer collaboration network event handle obtained by a call to PeerCollabRegisterEvent.
///    ppEventData = Pointer to a list of [PEER_COLLAB_EVENT_DATA](/windows/win32/api/p2p/ns-p2p-peer_collab_event_data-r1) structures
///                  that contain data about the peer collaboration network event. These data structures must be freed after use by
///                  calling PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_S_NO_EVENT_DATA</b></dt> </dl> </td> <td width="60%"> The event data is not
///    present. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetEventData(void* hPeerEvent, PEER_COLLAB_EVENT_DATA** ppEventData);

///The <b>PeerCollabUnregisterEvent</b> function deregisters an application from notification about specific peer
///collaboration events.
///Params:
///    hPeerEvent = Handle to the peer collaboration event the peer application will deregister. This handle is obtained with a
///                 previous call to PeerCollabRegisterEvent.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabUnregisterEvent(void* hPeerEvent);

///The <b>PeerCollabEnumPeopleNearMe</b> function returns a handle to an enumerated set that contains all of the peer
///collaboration network "people near me" endpoints currently available on the subnet of the calling peer.
///Params:
///    phPeerEnum = Pointer to a handle of an enumerated set that contains all of the peer collaboration network "people near me"
///                 endpoints currently available on the subnet of the calling peer.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> The operation requires the
///    user to be signed in. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabEnumPeopleNearMe(void** phPeerEnum);

///The <b>PeerCollabAddContact</b> function adds a contact to the contact list of a peer.
///Params:
///    pwzContactData = Pointer to a zero-terminated Unicode string buffer that contains the contact data for the peer that is added to
///                     the contact list. This string buffer can either be obtained by passing the peer name of the endpoint to add as a
///                     contact to PeerCollabQueryContactData, or through an out-of-band mechanism. To send its own contact data
///                     out-of-band, the peer can call PeerCollabExportContact with a <b>NULL</b> peer name. This function returns the
///                     contact data in XML format.
///    ppContact = Pointer to a pointer to a PEER_CONTACT structure. This parameter receives the address of a <b>PEER_CONTACT</b>
///                structure containing peer contact information for the contact supplied in <i>pwzContactData</i>. This parameter
///                may be <b>NULL</b>. Call PeerFreeData on the address of the PEER_CONTACT structure to free this data.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabAddContact(const(wchar)* pwzContactData, PEER_CONTACT** ppContact);

///The <b>PeerCollabDeleteContact</b> function deletes a contact from the local contact store associated with the
///caller.
///Params:
///    pwzPeerName = Pointer to a zero-terminated Unicode string that contains the peer name of the contact to delete. This parameter
///                  must not be <b>NULL</b>. You cannot delete the 'Me' contact.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabDeleteContact(const(wchar)* pwzPeerName);

///The <b>PeerCollabGetContact</b> function obtains the information for a peer contact given the peer name of the
///contact.
///Params:
///    pwzPeerName = Pointer to zero-terminated Unicode string that contains the name of the peer contact for which to obtain
///                  information. If this parameter is <b>NULL</b>, the 'Me' contact information for the calling peer is returned.
///    ppContact = Pointer to a pointer to a PEER_CONTACT structure. It receives the address of a PEER_CONTACT structure containing
///                peer contact information for the peer name supplied in <i>pwzPeerName</i>. When this parameter is <b>NULL</b>,
///                this function returns E_INVALIDARG. Call PeerFreeData on the address of the PEER_CONTACT structure to free this
///                data.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabGetContact(const(wchar)* pwzPeerName, PEER_CONTACT** ppContact);

///The <b>PeerCollabUpdateContact</b> function updates the information associated with a peer contact specified in the
///local contact store of the caller.
///Params:
///    pContact = Pointer to a PEER_CONTACT structure that contains the updated information for a specific peer contact.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr>
///    </table>
///    
@DllImport("P2P")
HRESULT PeerCollabUpdateContact(PEER_CONTACT* pContact);

///The <b>PeerCollabEnumContacts</b> function returns a handle to an enumerated set that contains all of the peer
///collaboration network contacts currently available on the calling peer.
///Params:
///    phPeerEnum = Handle to an enumerated set that contains all of the peer collaboration network contacts currently available on
///                 the calling peer, excluding the "Me" contact.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabEnumContacts(void** phPeerEnum);

///The <b>PeerCollabExportContact</b> function exports the contact data associated with a peer name to a string buffer.
///The buffer contains contact data in XML format. The PeerCollabAddContact function allows this XML string to be
///utilized by other peers.
///Params:
///    pwzPeerName = Pointer to zero-terminated Unicode string that contains the name of the peer contact for which to export. If this
///                  parameter is <b>NULL</b>, the "Me" contact information for the calling peer is exported.
///    ppwzContactData = Pointer to a zero-terminated string buffer that contains peer contact XML data where the peer names match the
///                      string supplied in <i>pwzPeerName</i>. The memory returned here can be freed by calling PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PEER_E_NOT_SIGNED_IN</b></dt> </dl> </td> <td width="60%"> One of the arguments is
///    invalid. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabExportContact(const(wchar)* pwzPeerName, ushort** ppwzContactData);

///The <b>PeerCollabParseContact</b> function parses a Unicode string buffer containing contact XML data into a
///PEER_CONTACT data structure.
///Params:
///    pwzContactData = Pointer to zero-terminated Unicode string buffer that contains XML contact data as returned by functions like
///                     PeerCollabQueryContactData or PeerCollabExportContact.
///    ppContact = Pointer to the address of a PEER_CONTACT structure that contain the peer contact information parsed from
///                <i>pwzContactData</i>. Free the memory allocated by calling PeerFreeData.
///Returns:
///    Returns S_OK if the function succeeds. Otherwise, the function returns one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory to support this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer
///    infrastructure is not initialized. Calling the relevant initialization function is required. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerCollabParseContact(const(wchar)* pwzContactData, PEER_CONTACT** ppContact);

///The <b>PeerNameToPeerHostName</b> function encodes the supplied peer name as a format that can be used with a
///subsequent call to the getaddrinfo Windows Sockets function.
///Params:
///    pwzPeerName = Pointer to a zero-terminated Unicode string that contains the peer name to encode as a host name.
///    ppwzHostName = Pointer to the address of the zero-terminated Unicode string that contains the encoded host name. This string can
///                   be passed to getaddrinfo_v2 to obtain network information about the peer.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerNameToPeerHostName(const(wchar)* pwzPeerName, ushort** ppwzHostName);

///The <b>PeerHostNameToPeerName</b> function decodes a host name returned by PeerNameToPeerHostName into the peer name
///string it represents.
///Params:
///    pwzHostName = Pointer to a zero-terminated Unicode string that contains the host name to decode.
///    ppwzPeerName = Pointer to the address of the zero-terminated Unicode string that contains the decoded peer name. The returned
///                   string must be released with PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerHostNameToPeerName(const(wchar)* pwzHostName, ushort** ppwzPeerName);

///The <b>PeerPnrpStartup</b> function starts the Peer Name Resolution Protocol (PNRP) service for the calling peer.
///Params:
///    wVersionRequested = The version of PNRP to use for this service instance. The default value is PNRP_VERSION (2).
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_UNSUPPORTED_VERSION</b></dt> </dl> </td> <td width="60%"> The provided version is unsupported.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_SERVICE_NOT_AVAILABLE </b></dt> </dl> </td> <td width="60%">
///    The Peer Collaboration infrastructure, which includes People Near Me, is not available. This code will also be
///    returned whenever an attempt is made to utilize the Collaboration infrastructure from an elevated process. </td>
///    </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpStartup(ushort wVersionRequested);

///The <b>PeerPnrpShutdown</b> function shuts down a running instance of the Peer Name Resolution Protocol (PNRP)
///service and releases all resources associated with it.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEER_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Peer infrastructure is not
///    initialized. Calling the relevant initialization function is required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to perform the specified
///    operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpShutdown();

///The <b>PeerPnrpRegister</b> function registers a peer with a PNRP cloud and returns a handle that can be used for
///registration updates. <div class="alert"><b>Note</b> When called, this function will block until the PNRP service has
///been initiated.</div><div> </div>
///Params:
///    pcwzPeerName = Pointer to a zero-terminated Unicode string that contains the peer name to register with the PNRP service.
///    pRegistrationInfo = Pointer to a PEER_PNRP_REGISTRATION_INFO structure that contains the endpoint information for the registering
///                        peer node. If <b>NULL</b>, the API will register the peer with all known PNRP clouds, and any registered
///                        addresses are automatically selected by the infrastructure.
///    phRegistration = Handle to the PNRP registration for the calling peer node. Use this handle to update the registration or to
///                     deregister with the PNRP service.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_IDENTITY_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The local peer is using an identity that does not exist. </td> </tr> </table>
///    Additionally, this function can return WSA values. For a complete list of possible values, see PNRP NSP Error
///    Codes.
///    
@DllImport("P2P")
HRESULT PeerPnrpRegister(const(wchar)* pcwzPeerName, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo, 
                         void** phRegistration);

///The <b>PeerPnrpUpdateRegistration</b> function updates the PNRP registration information for a name.
///Params:
///    hRegistration = Handle to a PNRP registration for the peer node obtained by a previous call to PeerPnrpRegister.
///    pRegistrationInfo = Pointer to a PEER_PNRP_REGISTRATION_INFO structure that contains the endpoint information for the registering
///                        peer node.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpUpdateRegistration(void* hRegistration, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo);

///The <b>PeerPnrpUnregister</b> function deregisters a peer from a PNRP cloud.
///Params:
///    hRegistration = Handle to a PNRP registration for the peer node obtained by a previous call to PeerPnrpRegister.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpUnregister(void* hRegistration);

///The <b>PeerPnrpResolve</b> function obtains the endpoint address(es) registered for a specific peer name.
///Params:
///    pcwzPeerName = Pointer to a zero-terminated string that contains the peer name for which endpoint addresses will be obtained.
///    pcwzCloudName = Pointer to a zero-terminated string that contains the name of the PNRP cloud under which to resolve the peer
///                    name. If <b>NULL</b>, the resolve is performed in all clouds. If PEER_PNRP_ALL_LINK_CLOUDS, the resolve is
///                    performed in all link local clouds. When "GLOBAL_", resolve will only take place in the global cloud.
///    pcEndpoints = The maximum number of endpoints to return in <i>ppEndpoints</i>. Upon return, this parameter contains the actual
///                  number of endpoints in <i>ppEndpoints</i>.
///    ppEndpoints = Pointer to a list of PEER_PNRP_ENDPOINT_INFO structures that contain the endpoints for which the peer name
///                  successfully resolved. Each endpoint contains one or more IP addresses at which the peer node can be reached.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpResolve(const(wchar)* pcwzPeerName, const(wchar)* pcwzCloudName, uint* pcEndpoints, 
                        PEER_PNRP_ENDPOINT_INFO** ppEndpoints);

///The <b>PeerPnrpStartResolve</b> function starts an asynchronous peer name resolution operation.
///Params:
///    pcwzPeerName = Pointer to a zero-terminated string that contains the peer name for which endpoint addresses will be obtained.
///    pcwzCloudName = Pointer to a zero-terminated string that contains the name of the PNRP cloud under which to resolve the peer
///                    name. If <b>NULL</b>, resolution is performed for all clouds. If PEER_PNRP_ALL_LINK_CLOUDS, resolution is
///                    performed for all link local clouds. When "GLOBAL_" is specified, resolution takes place in the global cloud.
///    cMaxEndpoints = The maximum number of endpoints to return for the peer name.
///    hEvent = Handle to the event signaled when a peer endpoint is resolved for the supplied peer name and are ready for
///             consumption by calling PeerPnrpGetEndpoint. This event is signaled for every endpoint discovered by the PNRP
///             service. If PEER_NO_MORE is returned by a call to PeerPnrpGetEndpoint, then all endpoints have been found for
///             that peer.
///    phResolve = Handle to this peer name resolution request. This handle must be provided to PeerPnrpEndResolve after the
///                resolution events are raised and the endpoints are obtained with corresponding calls to PeerPnrpGetEndpoint, or
///                if the operation fails.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpStartResolve(const(wchar)* pcwzPeerName, const(wchar)* pcwzCloudName, uint cMaxEndpoints, 
                             HANDLE hEvent, void** phResolve);

///The <b>PeerPnrpCloudInfo</b> function retrieves information on the Peer Name Resolution Protocol (PNRP) clouds in
///which the calling peer is participating.
///Params:
///    pcNumClouds = The number of PNRP clouds returned in <i>ppCloudInfo</i>.
///    ppCloudInfo = Pointer to a list of PEER_PNRP_CLOUD_INFO structures that contain information about the PNRP clouds in which the
///                  calling peer is participating. This data returned by this parameter must be freed by calling PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpGetCloudInfo(uint* pcNumClouds, PEER_PNRP_CLOUD_INFO** ppCloudInfo);

///The <b>PeerPnrpGetEndpoint</b> function retrieves a peer endpoint address resolved during an asynchronous peer name
///resolution operation.
///Params:
///    hResolve = The handle to the asynchronous peer name resolution operation returned by a previous call to
///               PeerPnrpStartResolve.
///    ppEndpoint = Pointer to the address of a PEER_PNRP_ENDPOINT_INFO structure that contains an endpoint address for the peer name
///                 supplied in the previous call to PeerPnrpStartResolve. This data returned by this parameter must be freed by
///                 calling PeerFreeData.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEER_E_NO_MORE</b></dt> </dl>
///    </td> <td width="60%"> All endpoint addresses have been retrieved for the peer. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpGetEndpoint(void* hResolve, PEER_PNRP_ENDPOINT_INFO** ppEndpoint);

///The <b>PeerPnrpEndResolve</b> function closes the handle for an asynchronous PNRP resolution operation initiated with
///a previous call to PeerPnrpStartResolve.
///Params:
///    hResolve = The handle to the asynchronous peer name resolution operation returned by a previous call to
///               PeerPnrpStartResolve.
///Returns:
///    If the function call succeeds, the return value is <b>S_OK</b>. Otherwise, it returns one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to
///    perform the specified operation. </td> </tr> </table>
///    
@DllImport("P2P")
HRESULT PeerPnrpEndResolve(void* hResolve);

///The <b>DrtCreatePnrpBootstrapResolver</b> function creates a bootstrap resolver based on the Peer Name Resolution
///Protocol (PNRP).
///Params:
///    fPublish = If <b>TRUE</b>, the PeerName contained in <i>pwzPeerName</i> and passed with the PNRP Bootstrap Resolver is
///               published by the local DRT using PNRP. This node will be resolvable by other nodes using the PNRP bootstrap
///               provider, and will assist other nodes attempting to bootstrap
///    pwzPeerName = The name of the peer to search for in the PNRP cloud. This string has a maximum limit of 137 unicode characters
///    pwzCloudName = The name of the cloud to search for in for the DRT corresponding to the MeshName. This string has a maximum limit
///                   of 256 unicode characters. If left blank the PNRP Bootstrap Provider will use all PNRP clouds available.
///    pwzPublishingIdentity = The PeerIdentity that is publishing into the PNRP cloud utilized for bootstrapping. This string has a maximum
///                            limit of 137 unicode characters. It is important to note that if <i>fPublish</i> is set to <b>TRUE</b>, the
///                            <i>PublishingIdentity</i> must be allowed to publish the PeerName specified.
///    ppResolver = A pointer to the created PNRP bootstrap resolver which is used in the DRT_SETTINGS structure.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    The system cannot allocate memory for the provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pwzPeerName</i> is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DRT_S_RETRY</b></dt> </dl> </td> <td width="60%"> Underlying calls to PeerPnrpStartup or
///    PeerIdentityGetCryptKey return a transient error. Try calling this function again. </td> </tr> </table> <div
///    class="alert"><b>Note</b> This function may also surface errors returned by underlying calls to PeerPnrpStartup
///    or PeerIdentityGetCryptKey.</div> <div> </div>
///    
@DllImport("drtprov")
HRESULT DrtCreatePnrpBootstrapResolver(BOOL fPublish, const(wchar)* pwzPeerName, const(wchar)* pwzCloudName, 
                                       const(wchar)* pwzPublishingIdentity, DRT_BOOTSTRAP_PROVIDER** ppResolver);

///The <b>DrtDeletePnrpBootstrapResolver</b> function deletes a bootstrap resolver based on the Peer Name Resolution
///Protocol (PNRP).
///Params:
///    pResolver = Pointer to the created PNRP bootstrap resolver to be deleted.
@DllImport("drtprov")
void DrtDeletePnrpBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

///The <b>DrtCreateDnsBootstrapResolver</b> function creates a bootstrap resolver that will use the GetAddrInfo system
///function to resolve the hostname of a will known node already present in the DRT mesh.
///Params:
///    port = Specifies the port to which the DRT protocol is bound on the well known node.
///    pwszAddress = Specifies the hostname of the well known node.
///    ppModule = Pointer to the DRT_BOOTSTRAP_PROVIDER module to be included in the DRT_SETTINGS structure.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <i>pwszAddress</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> The system could not allocate memory for the provider. </td> </tr> </table> <div
///    class="alert"><b>Note</b> This function may also return errors from underlying calls to WSAStartup and
///    StringCbPrintfW.</div> <div> </div>
///    
@DllImport("drtprov")
HRESULT DrtCreateDnsBootstrapResolver(ushort port, const(wchar)* pwszAddress, DRT_BOOTSTRAP_PROVIDER** ppModule);

///The <b>DrtDeleteDnsBootstrapResolver</b> function deletes a DNS Bootstrap Provider instance.
///Params:
///    pResolver = Pointer to a DRT_BOOTSTRAP_PROVIDER instance specifying the security provider to delte.
@DllImport("drtprov")
void DrtDeleteDnsBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

///The <b>DrtCreateIpv6UdpTransport</b> function creates a transport based on the IPv6 UDP protocol.
///Params:
///    scope = The <b>DRT_SCOPE</b> enumeration that specifies the IPv6 scope in which the DRT is to operate.
///    dwScopeId = The identifier that uniquely specifies the interface the scope is associated with. For the Global scope this
///                parameter is always the "GLOBAL_" ID and is optional when using only the global scope. For the link local scope,
///                this parameter represents the interface associated with the Network Interface Card on which the link local scope
///                exists.
///    dwLocalityThreshold = The identifier that specifies how Locality information based on IpV6 addresses is used when caching neighbors. By
///                          default, the DRT gives preference to neighbors that have an IPv6 address with a prefix in common with the local
///                          machine.
///    pwPort = Pointer to the port utilized by the local DRT instance.
///    phTransport = Pointer to a DRT transport handle specified in the DRT_SETTINGS structure.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    The system cannot allocate memory for the provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INVALID_PORT</b></dt> </dl> </td> <td width="60%"> <i>pwPort</i> is <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>DRT_E_INVALID_TRANSPORT_PROVIDER</b></dt> </dl> </td> <td width="60%">
///    <i>hTransport</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_SCOPE</b></dt>
///    </dl> </td> <td width="60%"> The specified scope is not DRT_GLOBAL_SCOPE, DRT_SITE_LOCAL_SCOPE or
///    DRT_LINK_LOCAL_SCOPE. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TRANSPORT_UNEXPECTED</b></dt> </dl>
///    </td> <td width="60%"> An unexpected error has occurred. See TraceError for reason. </td> </tr> </table> <div
///    class="alert"><b>Note</b> This function may also return errors from underlying calls to
///    NotifyUnicastIpAddressChange,WSAStartup, GetAdaptersAddresses, setsockopt, WSASocket, Bind, WSAIoctl,
///    CreateThreadpoolIo, CreateThreadpoolCleanupGroup and CreateTimerQueue.</div> <div> </div>
///    
@DllImport("drttransport")
HRESULT DrtCreateIpv6UdpTransport(DRT_SCOPE scope_, uint dwScopeId, uint dwLocalityThreshold, ushort* pwPort, 
                                  void** phTransport);

///The <b>DrtDeleteIpv6UdpTransport</b> function deletes a transport based on the IPv6 UDP protocol.
///Params:
///    hTransport = The DRT transport handle specifying the transport to delete.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_TRANSPORT_PROVIDER</b></dt> </dl>
///    </td> <td width="60%"> <i>hTransport</i> is <b>NULL</b> or invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_TRANSPORT_EXECUTING_CALLBACK</b></dt> </dl> </td> <td width="60%"> The transport provider is
///    currently executing a method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TRANSPORT_STILL_BOUND</b></dt>
///    </dl> </td> <td width="60%"> The transport is still bound. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_TRANSPORTPROVIDER_IN_USE</b></dt> </dl> </td> <td width="60%"> All clients have not called Release
///    on the transport. </td> </tr> </table> <div class="alert"><b>Note</b> This function may also surface errors
///    returned by underlying calls to PeerPnrpStartup or PeerIdentityGetCryptKey.</div> <div> </div>
///    
@DllImport("drttransport")
HRESULT DrtDeleteIpv6UdpTransport(void* hTransport);

///The <b>DrtCreateDerivedKeySecurityProvider</b> function creates the derived key security provider for a Distributed
///Routing Table.
///Params:
///    pRootCert = Pointer to the certificate that is the "root" portion of the chain. This is used to ensure that keys derived from
///                the same chain can be verified.
///    pLocalCert = Pointer to the DRT_SECURITY_PROVIDER module to be included in the DRT_SETTINGS structure.
///    ppSecurityProvider = Receives a pointer to the created security provider.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <i>pRootCert</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> The system could not allocate memory for the security provider. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DRT_E_CAPABILITY_MISMATCH</b></dt> </dl> </td> <td width="60%"> <ul> <li>The requested
///    security algorithms are not available ( ie. BCRYPT_SHA256_ALGORITHM or BCRYPT_AES_ALGORITHM).</li> <li>The
///    BCryptOpenAlgorithmProvider operation failed.</li> <li>The <i>dwProvType</i> parameter indicates that the
///    certificate provider is not AES capable.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INVALID_CERT_CHAIN</b></dt> </dl> </td> <td width="60%"> No certificate store attached or there is
///    an error in the certificate chain. </td> </tr> </table>
///    
@DllImport("drtprov")
HRESULT DrtCreateDerivedKeySecurityProvider(CERT_CONTEXT* pRootCert, CERT_CONTEXT* pLocalCert, 
                                            DRT_SECURITY_PROVIDER** ppSecurityProvider);

///The <b>DrtCreateDerivedKey</b> function creates a key that can be utilized by DrtRegisterKey when the DRT is using a
///derived key security provider.
///Params:
///    pLocalCert = Pointer to the certificate that is the "local" portion of the chain. The root of this chain must match the root
///                 specified by <i>pRootCert</i> in DrtCreateDerivedKeySecurityProvider. This certificate is used to generate a key
///                 that is used to register and prove "key ownership" with the DRT.
///    pKey = Pointer to the created key.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <ul> <li><i>pLocalCert</i> is <b>NULL</b>.</li> <li><i>pKey</i> is <b>NULL</b>.</li> <li>The <b>pb</b> member in
///    the DRT_DATA structure is <b>NULL</b>.</li> <li>The <b>cb</b> member in the DRT_DATA structure is not equal to 32
///    bytes.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_CAPABILITY_MISMATCH</b></dt> </dl> </td>
///    <td width="60%"> <ul> <li>The requested security algorithms are not available ( ie. BCRYPT_SHA256_ALGORITHM or
///    BCRYPT_AES_ALGORITHM).</li> <li>The BCryptOpenAlgorithmProvider operation failed.</li> <li>The <i>dwProvType</i>
///    parameter indicates that the certificate provider is not AES capable.</li> </ul> </td> </tr> </table>
///    
@DllImport("drtprov")
HRESULT DrtCreateDerivedKey(CERT_CONTEXT* pLocalCert, DRT_DATA* pKey);

///The <b>DrtDeleteDerivedKeySecurityProvider</b> function deletes a derived key security provider for a Distributed
///Routing Table.
///Params:
///    pSecurityProvider = Pointer to a DRT_SECURITY_PROVIDER specifying the security provider to delete.
@DllImport("drtprov")
void DrtDeleteDerivedKeySecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

///The <b>DrtCreateNullSecurityProvider</b> function creates a null security provider. This security provider does not
///require nodes to authenticate keys.
///Params:
///    ppSecurityProvider = Pointer to the [DRT_SETTINGS](./ns-drt-drt_settings.md) structure.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    The system cannot allocate memory for the provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> <i>ppDrtSecurityProvider</i> is <b>NULL</b>. </td>
///    </tr> </table>
///    
@DllImport("drtprov")
HRESULT DrtCreateNullSecurityProvider(DRT_SECURITY_PROVIDER** ppSecurityProvider);

///The <b>DrtDeleteNullSecurityProvider</b> function deletes a null security provider for a Distributed Routing Table.
///Params:
///    pSecurityProvider = Pointer to a DRT_SECURITY_PROVIDER structure specifying the security provider to delete.
@DllImport("drtprov")
void DrtDeleteNullSecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

///The <b>DrtOpen</b> function creates a local Distributed Routing Table instance against criteria specified by the
///DRT_SETTINGS structure.
///Params:
///    pSettings = Pointer to the DRT_SETTINGS structure which specifies the settings used for the creation of the DRT instance.
///    hEvent = Handle to the event signaled when an event occurs.
///    pvContext = User defined context data which is passed to the application via events.
///    phDrt = The new handle associated with the DRT. This is used in all future operations on the DRT instance.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <i>phDrt</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_SETTINGS</b></dt> </dl>
///    </td> <td width="60%"> <i>pSettings</i> is <b>NULL</b> or the <b>dwSize</b> member value of DRT_SETTINGS is not
///    equal to the size of the <b>DRT_SETTINGS</b> object. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INVALID_KEY_SIZE</b></dt> </dl> </td> <td width="60%"> <i>cbKey</i> is not equal to 256 bits. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_MAX_ADDRESSES</b></dt> </dl> </td> <td width="60%"> The
///    <b>ulMaxRoutingAddresses</b> member of DRT_SETTINGS specifies less than 1 or more than 20 as the maximum number
///    of addresses. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_TRANSPORT_PROVIDER</b></dt> </dl> </td>
///    <td width="60%"> The <b>hTransport</b> member in DRT_SETTINGS is <b>NULL</b> or some fields of the Transport are
///    <b>NULL</b> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_SECURITY_MODE</b></dt> </dl> </td> <td
///    width="60%"> The <b>eSecurityMode</b> member of DRT_SETTINGS specifies an invalid security mode. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>DRT_E_INVALID_SECURITY_PROVIDER</b></dt> </dl> </td> <td width="60%"> The
///    <b>pSecurityProvider</b> member of DRT_SETTINGS is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INVALID_BOOTSTRAP_PROVIDER</b></dt> </dl> </td> <td width="60%"> The <b>pBootstrapProvider</b>
///    member of DRT_SETTINGS is <b>NULL</b> or some fields of the bootstrap provider are <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>DRT_E_INVALID_INSTANCE_PREFIX</b></dt> </dl> </td> <td width="60%"> The size of the
///    <b>pwzDrtInstancePrefix</b> specified in DRT_SETTINGS is larger than the maximum prefix length (128). </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The system cannot allocate
///    memory for this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_BOOTSTRAPPROVIDER_IN_USE</b></dt>
///    </dl> </td> <td width="60%"> The bootstrap provider is already attached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_SECURITYPROVIDER_IN_USE</b></dt> </dl> </td> <td width="60%"> The security provider is already
///    attached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_TRANSPORTPROVIDER_IN_USE</b></dt> </dl> </td> <td
///    width="60%"> The transport provider is already attached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INVALID_CERT_CHAIN</b></dt> </dl> </td> <td width="60%"> The certification chain is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_CAPABILITY_MISMATCH</b></dt> </dl> </td> <td width="60%"> Local
///    certificate cannot be <b>NULL</b> in DRT_SECURE_MEMBERSHIP and DRT_SECURE_CONFIDENTIALPAYLOAD security. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TRANSPORT_SHUTTING_DOWN</b></dt> </dl> </td> <td width="60%">
///    Transport is shutting down. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TRANSPORT_ALREADY_BOUND</b></dt>
///    </dl> </td> <td width="60%"> Trasport is already bound. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_S_RETRY</b></dt> </dl> </td> <td width="60%"> Bootstrap provider failed to locate other nodes, but may
///    be successful in a second attempt. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_TRANSPORT_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> Transport provider parameter is
///    <b>NULL</b> or invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_TRANSPORTPROVIDER_NOT_ATTACHED</b></dt> </dl> </td> <td width="60%"> Transport is not attached.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unexpected fatal
///    error occurred. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtOpen(const(DRT_SETTINGS)* pSettings, HANDLE hEvent, const(void)* pvContext, void** phDrt);

///The <b>DrtClose</b> function closes the local instance of the DRT.
///Params:
///    hDrt = Handle to the DRT instance.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hDrt</i> handle is invalid. </td> </tr> </table>
///    
@DllImport("drt")
void DrtClose(void* hDrt);

///The <b>DrtGetEventDataSize</b> function returns the size of the DRT_EVENT_DATA structure associated with a signaled
///event.
///Params:
///    hDrt = Handle to the Distributed Routing Table instance for which the event occurred.
///    pulEventDataLen = The size, in bytes, of the event data.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
///    The DRT infrastructure is unaware of the requested search. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pulEventDataLen</i> is <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> <i>hDrt</i> is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DRT_E_NO_MORE</b></dt> </dl> </td> <td width="60%"> There is no more event data
///    available. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtGetEventDataSize(void* hDrt, uint* pulEventDataLen);

///The <b>DrtGetEventData</b> function retrieves event data associated with a signaled event.
///Params:
///    hDrt = Handle to the Distributed Routing Table instance for which the event occurred.
///    ulEventDataLen = The size, in bytes, of the <i>pEventData</i> buffer.
///    pEventData = Pointer to a DRT_EVENT_DATA structure that contains the event data.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
///    The DRT infrastructure is unaware of the requested search. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hDrt</i> handle is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DRT_E_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The provided buffer is
///    insufficient in size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_NO_MORE</b></dt> </dl> </td> <td
///    width="60%"> No more event data available. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtGetEventData(void* hDrt, uint ulEventDataLen, char* pEventData);

///The <b>DrtRegisterKey</b> function registers a key in the DRT.
///Params:
///    hDrt = A pointer to a handle returned by the DrtOpen function.
///    pRegistration = A pointer to a handle to the DRT_REGISTRATION structure.
///    pvKeyContext = Pointer to the context data associated with the key in the DRT. This data is passed to the key-specific functions
///                   of the security provider.
///    phKeyRegistration = Pointer to a handle for a key that has been registered.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <ul> <li><i>pRegistration</i> is <b>NULL</b></li> <li>The <b>cb</b> value of the <b>appData</b> member of the
///    DRT_REGISTRATION structure is too large (ie. less than 1).</li> <li>The <b>cb</b> value of the <b>appData</b>
///    member of the DRT_REGISTRATION structure is too large (ie. more than 5120).</li> <li>The <b>pb</b> value of the
///    <b>key</b> member of the DRT_REGISTRATION structure is <b>NULL</b>.</li> <li><i>phKeyRegistration</i> is
///    <b>NULL</b></li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> <i>hDrt</i> is an invalid handle or <i>phKeyRegistration</i> is an invalid handle </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>DRT_E_INVALID_KEY_SIZE</b></dt> </dl> </td> <td width="60%"> The size of cb value of
///    the key member of the DRT_REGISTRATION structure is not equal to 256 bits or the <b>pb</b> value of the
///    <b>key</b> member of the DRT_REGISTRATION structure is <b>NULL</b>.. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_FAULTED</b></dt> </dl> </td> <td width="60%"> The DRT cloud is in the faulted state. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DRT_E_DUPLICATE_KEY</b></dt> </dl> </td> <td width="60%"> The key is already
///    registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_CERT_CHAIN</b></dt> </dl> </td> <td
///    width="60%"> The provided certification chain is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_CAPABILITY_MISMATCH</b></dt> </dl> </td> <td width="60%"> Supplied certificate provider is not AES
///    capable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INVALID_KEY</b></dt> </dl> </td> <td width="60%">
///    Supplied key does not match generated key. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_TRANSPORT_NO_DEST_ADDRESSES</b></dt> </dl> </td> <td width="60%"> Valid address not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TRANSPORT_SHUTTING_DOWN</b></dt> </dl> </td> <td width="60%">
///    Transport is shutting down. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INVALID_TRANSPORT_PROVIDER</b></dt> </dl> </td> <td width="60%"> Transport provider is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TRANSPORTPROVIDER_NOT_ATTACHED</b></dt> </dl> </td> <td
///    width="60%"> Transport is not attached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_SECURITYPROVIDER_NOT_ATTACHED</b></dt> </dl> </td> <td width="60%"> Security provider is not
///    attached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TRANSPORT_NOT_BOUND</b></dt> </dl> </td> <td
///    width="60%"> Transport is not currently bound. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> <ul> <li>The
///    GlobalControl.HandleTable is <b>NULL</b>.</li> <li>The cloud is shutting down.</li> <li>The DRT is shutting
///    down.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
///    unexpected fatal error has occurred. </td> </tr> </table> <div class="alert"><b>Note</b> <b>DrtRegisterKey</b>
///    may also surface errors from underlying calls to CryptGetProvParam, CertGetCertificateChain, CertOpenStore,
///    CertAddCertificateContextToStore, CryptContextAddRef, CryptAcquireCertificatePrivateKey, CertSaveStore, WSAIoctl,
///    CryptImportPublicKeyInfoEx2, NCryptSignHash, CertEnumCertificatesInStore, BCryptGetProperty, BCryptGenRandom,
///    BCryptGenerateSymmetricKey and BCryptEncrypt.</div> <div> </div>
///    
@DllImport("drt")
HRESULT DrtRegisterKey(void* hDrt, DRT_REGISTRATION* pRegistration, void* pvKeyContext, void** phKeyRegistration);

///The <b>DrtUpdateKey</b> function updates the application data associated with a registered key.
///Params:
///    hKeyRegistration = The DRT handle returned by the DrtRegisterKey function specifying a registered key within the DRT instance.
///    pAppData = The new application data to associate with the key.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <ul> <li><i>pAppData</i> is <b>NULL</b></li> <li>The value of <b>cb</b> in <i>pAppData</i> is less than 0.</li>
///    <li>The value of <b>cb</b> in <i>pAppData</i> is more than 5120.</li> <li>The value of <b>pb</b> in
///    <i>pAppData</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> <i>hKeyRegistration</i> is an invalid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtUpdateKey(void* hKeyRegistration, DRT_DATA* pAppData);

///The <b>DrtUnregisterKey</b> function deregisters a key from the DRT.
///Params:
///    hKeyRegistration = The DRT handle returned by the DrtRegisterKey function specifying a registered key within the DRT.
@DllImport("drt")
void DrtUnregisterKey(void* hKeyRegistration);

///The <b>DrtStartSearch</b> function searches the DRT for a key using criteria specified in the DRT_SEARCH_INFO
///structure.
///Params:
///    hDrt = The DRT handle returned by the DrtOpen function.
///    pKey = Pointer to the DRT_DATA structure containing the key.
///    pInfo = Pointer to the DRT_SEARCH_INFO structure that specifies the properties of the search.
///    timeout = Specifies the milliseconds until the search is stopped.
///    hEvent = Handle to the event that is signaled when the <b>DrtStartSearch</b> API finishes or an intermediate node is
///             found.
///    pvContext = Pointer to the context data passed to the application through the event.
///    hSearchContext = Handle used in the call to DrtEndSearch.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> hDrt
///    is an invalid handle or phKeyRegistration is an invalid handle </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <ul> <li><i>hSearchContext</i> is <b>NULL</b>.</li>
///    <li><i>pKey</i> is <b>NULL</b></li> <li>The <b>pb</b> member of the DRT_DATA structure of <i>pKey</i> is
///    <b>NULL</b>.</li> <li><i>pInfo</i> was passed in, the minimum key is set inside <i>pInfo</i> for range search,
///    but the maximum key is <b>NULL</b>.</li> <li><i>pInfo</i> was passed in, the maximum key is set inside
///    <i>pInfo</i> for range search, but the minimum key is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>DRT_E_INVALID_KEY_SIZE</b></dt> </dl> </td> <td width="60%"> <ul> <li>The <b>cb</b> member of the
///    DRT_DATA structure of <i>pKey</i> is not equal to 256 bits.</li> <li><i>pInfo</i> was passed in, but the key size
///    of the minimum key set inside <i>pInfo</i> is not equal to 256 bits.</li> <li><i>pInfo</i> was passed in, but the
///    key size of the maximum key set inside <i>pInfo</i> is not equal to 256 bits.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DRT_E_INVALID_SEARCH_INFO</b></dt> </dl> </td> <td width="60%"> <i>pInfo</i> was passed
///    in but the <b>dwSize</b> of <i>pInfo</i> is not equal to size of the DRT_SEARCH_INFO structure. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>DRT_E_INVALID_MAX_ENDPOINTS</b></dt> </dl> </td> <td width="60%"> <i>pInfo</i> was
///    passed in but max endpoints (<b>cMaxEndpoints</b>) is set to 0 inside <i>pInfo</i> or <i>pInfo</i> was passed in
///    but <b>cMaxEndpoints</b> is greater than 1 with <b>fAnyMatchInRange</b> set to <b>TRUE</b> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DRT_E_INVALID_SEARCH_RANGE</b></dt> </dl> </td> <td width="60%"> Min and max key values
///    are equal, but target is different. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_FAULTED</b></dt> </dl>
///    </td> <td width="60%"> The DRT cloud is in the faulted state. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The DRT is shutting down. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unexpected fatal error has
///    occurred. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtStartSearch(void* hDrt, DRT_DATA* pKey, const(DRT_SEARCH_INFO)* pInfo, uint timeout, HANDLE hEvent, 
                       const(void)* pvContext, void** hSearchContext);

///The <b>DrtContinueSearch</b> function continues an iterative search for a key.This function is used only when the
///<b>fIterative</b> flag is set to 'true' in the associated DRT_SEARCH_INFO structure. Call this after getting a
///<b>DRT_MATCH_INTERMEDIATE</b> search result.
///Params:
///    hSearchContext = Handle to the search context to close. This parameter is returned by the DrtStartSearch API.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hSearchContext</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
///    </dl> </td> <td width="60%"> This search is not an iterative search. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtContinueSearch(void* hSearchContext);

///The <b>DrtGetSearchResultSize</b> function returns the size of the next available search result.
///Params:
///    hSearchContext = Handle to the search context to close. This parameter is returned by the DrtStartSearch function.
///    pulSearchResultSize = Holds the size of the next available search result.
///Returns:
///    Returns S_OK if the function succeeds. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <i>pulSearchResultSize</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> <i>hSearchContext</i> is an invalid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_FAULTED</b></dt> </dl> </td> <td width="60%"> The DRT cloud is in the faulted state. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DRT_E_NO_MORE</b></dt> </dl> </td> <td width="60%"> There are no more results
///    to return. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The
///    search failed because it timed out. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_SEARCH_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The search is still in progress. </td>
///    </tr> </table>
///    
@DllImport("drt")
HRESULT DrtGetSearchResultSize(void* hSearchContext, uint* pulSearchResultSize);

///The <b>DrtGetSearchResult</b> function allows the caller to retrieve the search result(s).
///Params:
///    hSearchContext = Handle to the search context to close. This parameter is returned by the DrtStartSearch function.
///    ulSearchResultSize = Pointer to the DRT_SEARCH_RESULT structure containing the search result.
///    pSearchResult = Receives a pointer to a DRT_SEARCH_RESULT structure containing the search results.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <i>ulSearchPathSize</i> is less than the size of DRT_SEARCH_RESULT. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> <i>hSearchContext</i> is an invalid handle. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DRT_E_FAULTED</b></dt> </dl> </td> <td width="60%"> the DRT cloud is in the
///    faulted state. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The provided buffer is insufficient in size to contain the search result. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DRT_E_NO_MORE</b></dt> </dl> </td> <td width="60%"> There are no more results to return.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The search
///    failed because it timed out. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DRT_E_SEARCH_IN_PROGRESS</b></dt>
///    </dl> </td> <td width="60%"> The search is currently in progress. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtGetSearchResult(void* hSearchContext, uint ulSearchResultSize, char* pSearchResult);

///The <b>DrtGetSearchPathSize</b> function returns the size of the search path, which represents the number of nodes
///utilized in the search operation.
///Params:
///    hSearchContext = Handle to the search context. This parameter is returned by the DrtStartSearch function.
///    pulSearchPathSize = Pointer to a <b>ULONG</b> value that indicates the size of the search path.
///Returns:
///    This function returns S_OK on success.
///    
@DllImport("drt")
HRESULT DrtGetSearchPathSize(void* hSearchContext, uint* pulSearchPathSize);

///The <b>DrtGetSearchPath</b> function returns a list of nodes contacted during the search operation.
///Params:
///    hSearchContext = Handle to the search context. This parameter is returned by the DrtStartSearch function.
///    ulSearchPathSize = The size of the search path which represents the number of nodes utilized in the search operation.
///    pSearchPath = Pointer to a DRT_ADDRESS_LIST structure containing the list of addresses.
///Returns:
///    This function returns S_OK on success.
///    
@DllImport("drt")
HRESULT DrtGetSearchPath(void* hSearchContext, uint ulSearchPathSize, char* pSearchPath);

///The <b>DrtEndSearch</b> function cancels a search for a key in a DRT. This API can be called at any point after a
///search is issued.
///Params:
///    hSearchContext = Handle to the search context to end. This parameter is returned from DrtStartSearch.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hSearchContext</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
///    </dl> </td> <td width="60%"> The DRT infrastructure is unaware of the requested search. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtEndSearch(void* hSearchContext);

///The <b>DrtGetInstanceName</b> function retrieves the full name of the Distributed Routing Table instance that
///corresponds to the specified DRT handle.
///Params:
///    hDrt = Handle to the DRT instance.
///    ulcbInstanceNameSize = The length of the <i>pwzDrtInstanceName</i> buffer.
///    pwzDrtInstanceName = Contains the complete name of the DRT instance associated with <i>hDRT</i>.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <i>pwzDrtInstanceName</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> <i>hDrt</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DRT_E_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The <i>pwzDrtInstanceName</i> buffer is
///    insufficient in size. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtGetInstanceName(void* hDrt, uint ulcbInstanceNameSize, const(wchar)* pwzDrtInstanceName);

///The <b>DrtGetInstanceNameSize</b> function returns the size of the Distributed Routing Table instance name.
///Params:
///    hDrt = Handle to the target DRT instance.
///    pulcbInstanceNameSize = The length of the DRT instance name.
///Returns:
///    This function returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    <i>pulcbInstanceNameSize</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt>
///    </dl> </td> <td width="60%"> <i>hDrt</i> handle is invalid. </td> </tr> </table>
///    
@DllImport("drt")
HRESULT DrtGetInstanceNameSize(void* hDrt, uint* pulcbInstanceNameSize);

///The <b>PeerDistStartup</b> function creates a new Peer Distribution instance handle which must be passed to all other
///Peer Distribution APIs.
///Params:
///    dwVersionRequested = Contains the minimum version of the Peer Distribution requested by the application. The high order byte specifies
///                         the minor version number; the low order byte specifies the major version number.
///    phPeerDist = A pointer to a <b>PEERDIST_INSTANCE_HANDLE</b> variable which upon success receives a newly created handle.
///    pdwSupportedVersion = A pointer to a variable which, if not <b>NULL</b>, contains the maximum version number that is supported by the
///                          Peer Distribution system. The high order byte specifies the minor version number; the low order byte specifies
///                          the major version number.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_VERSION_UNSUPPORTED</b></dt> </dl> </td> <td width="60%">
///    The requested version is not supported by client side DLL. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistStartup(uint dwVersionRequested, ptrdiff_t* phPeerDist, uint* pdwSupportedVersion);

///The <b>PeerDistShutdown</b> function releases resources allocated by a call to PeerDistStartup. Each handle returned
///by a <b>PeerDistStartup</b> call must be closed by a matching call to <b>PeerDistShutdown</b>
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hPeerDist</i> handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistShutdown(ptrdiff_t hPeerDist);

///The <b>PeerDistGetStatus</b> function returns the current status of the Peer Distribution service.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    pPeerDistStatus = A pointer to a PEERDIST_STATUS enumeration which upon operation success receives the current status of the Peer
///                      Distribution service.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("PeerDist")
uint PeerDistGetStatus(ptrdiff_t hPeerDist, PEERDIST_STATUS* pPeerDistStatus);

///The <b>PeerDistRegisterForStatusChangeNotification</b> function requests the Peer Distribution service status change
///notification.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hCompletionPort = A handle to the completion port that can be used for retrieving the completion notification of the asynchronous
///                      function. To create a completion port, use the CreateIoCompletionPort function. This parameter can be
///                      <b>NULL</b>.
///    ulCompletionKey = Value to be returned through the <i>lpCompletionKey</i> parameter of the GetQueuedCompletionStatus function. This
///                      parameter is ignored when <i>hCompletionPort</i> is <b>NULL</b>.
///    lpOverlapped = Pointer to an OVERLAPPED structure. If the <b>hEvent</b> member of the structure is not <b>NULL</b>, it will be
///                   signaled via SetEvent() used in order to signal the notification. This can occur even if the completion port is
///                   specified via the <i>hCompletionPort</i> argument.
///    pPeerDistStatus = A pointer to a PEERDIST_STATUS enumeration that indicates the current status of the Peer Distribution service.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistRegisterForStatusChangeNotification(ptrdiff_t hPeerDist, HANDLE hCompletionPort, 
                                                 size_t ulCompletionKey, OVERLAPPED* lpOverlapped, 
                                                 PEERDIST_STATUS* pPeerDistStatus);

///The <b>PeerDistUnregisterForStatusChangeNotification</b> function unregisters the status change notification for the
///session associated with the specified handle.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistUnregisterForStatusChangeNotification(ptrdiff_t hPeerDist);

///The <b>PeerDistServerPublishStream</b> function initializes a new stream to be published to the Peer Distribution
///service.
///Params:
///    hPeerDist = A PEERDIST_INSTANCE_HANDLE returned by PeerDistStartup.
///    cbContentIdentifier = The length, in bytes, of the buffer that contains content identifier data.
///    pContentIdentifier = A pointer to an array that contains a content identifier data.
///    cbContentLength = The length, in bytes, of the content to be published. This value can be 0 if the content length is not yet known.
///                      If a non-zero argument is provided then it must match to the total data length added by
///                      PeerDistServerPublishAddToStream function calls.
///    pPublishOptions = Pointer to a [PEERDIST_PUBLICATION_OPTIONS](./ns-peerdist-peerdist_publication_options.md) structure that
///                      specifies content publishing rules.
///    hCompletionPort = A handle to the completion port that can be used for retrieving the completion notification of the asynchronous
///                      function. To create a completion port, use the CreateIoCompletionPort function. This parameter can be
///                      <b>NULL</b>.
///    ulCompletionKey = Value returned through the <i>lpCompletionKey</i> parameter of the GetQueuedCompletionStatus function. This
///                      parameter is ignored when <i>hCompletionPort</i> is <b>NULL</b>.
///    phStream = A pointer that receives a handle to the stream that is used to publish data into the Peer Distribution service.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The specified
///    <i>hPeerDist</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_ALREADY_EXISTS</b></dt>
///    </dl> </td> <td width="60%"> The content identifier used for publication is already published. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is
///    disabled by Group Policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The service is unavailable. </td>
///    </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerPublishStream(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, 
                                 ulong cbContentLength, PEERDIST_PUBLICATION_OPTIONS* pPublishOptions, 
                                 HANDLE hCompletionPort, size_t ulCompletionKey, ptrdiff_t* phStream);

///The <b>PeerDistServerPublishAddToStream</b> function adds data to the publishing stream.
///Params:
///    hPeerDist = A PEERDIST_INSTANCE_HANDLE returned by PeerDistStartup.
///    hStream = A PEERDIST_STREAM_HANDLE created by PeerDistServerPublishStream.
///    cbNumberOfBytes = Number of bytes to be published.
///    pBuffer = Pointer to the buffer that contains the data to be published. This buffer must remain valid for the duration of
///              the add operation. The caller must not use this buffer until the add operation is completed.
///    lpOverlapped = Pointer to an OVERLAPPED structure. The <b>Offset</b> and <b>OffsetHigh</b> members are reserved and must be
///                   zero.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hStream</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is
///    disabled by Group Policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The service is unavailable. </td>
///    </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerPublishAddToStream(ptrdiff_t hPeerDist, ptrdiff_t hStream, uint cbNumberOfBytes, char* pBuffer, 
                                      OVERLAPPED* lpOverlapped);

///The <b>PeerDistServerPublishCompleteStream</b> function completes the process of adding data to the stream.
///Params:
///    hPeerDist = A PEERDIST_INSTANCE_HANDLE returned by PeerDistStartup.
///    hStream = A PEERDIST_STREAM_HANDLE returned by PeerDistServerPublishStream.
///    lpOverlapped = Pointer to an OVERLAPPED structure. The <b>Offset</b> and <b>OffsetHigh</b> are reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hStream</i> handle is invalid </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was canceled. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is
///    disabled by Group Policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The service is unavailable. </td>
///    </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerPublishCompleteStream(ptrdiff_t hPeerDist, ptrdiff_t hStream, OVERLAPPED* lpOverlapped);

///The <b>PeerDistServerCloseStreamHandle</b> function closes a handle returned by PeerDistServerPublishStream.
///Params:
///    hPeerDist = A PEERDIST_INSTANCE_HANDLE returned by PeerDistStartup.
///    hStream = A PEERDIST_STREAM_HANDLE returned by PeerDistServerPublishStream.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hStream</i> handle is invalid </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerCloseStreamHandle(ptrdiff_t hPeerDist, ptrdiff_t hStream);

///The <b>PeerDistServerUnpublish</b> function removes a publication created via PeerDistServerPublishStream.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    cbContentIdentifier = The length, in bytes, of the content identifier.
///    pContentIdentifier = Pointer to a buffer that contains the content identifier.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerUnpublish(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier);

///The <b>PeerDistServerOpenContentInformation</b> function opens a <b>PEERDIST_CONTENTINFO_HANDLE</b>. The client uses
///the handle to retrieve content information.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    cbContentIdentifier = The length, in bytes, of the content identifier.
///    pContentIdentifier = Pointer to a buffer that contains the content identifier.
///    ullContentOffset = An offset from the beginning of the published content for which the content information handle is requested.
///    cbContentLength = The length, in bytes, of the content (starting from the ullContentOffset) for which the content information is
///                      requested.
///    hCompletionPort = A handle to the completion port used for retrieving the completion notification of the asynchronous function. To
///                      create a completion port, use the CreateIoCompletionPort function. This parameter can be <b>NULL</b>.
///    ulCompletionKey = Value to be returned through the <i>lpCompletionKey</i> parameter of the GetQueuedCompletionStatus function. This
///                      parameter is ignored when <i>hCompletionPort</i> is <b>NULL</b>.
///    phContentInfo = A handle used to retrieve the content information.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified content identifier data is
///    not published. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td>
///    <td width="60%"> The feature is disabled by Group Policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The service is unavailable. </td>
///    </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerOpenContentInformation(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, 
                                          ulong ullContentOffset, ulong cbContentLength, HANDLE hCompletionPort, 
                                          size_t ulCompletionKey, ptrdiff_t* phContentInfo);

///The <b>PeerDistServerRetrieveContentInformation</b> function retrieves the encoded content information associated
///with a handle returned by PeerDistServerOpenContentInformation.
///Params:
///    hPeerDist = A PEERDIST_INSTANCE_HANDLE returned by PeerDistStartup.
///    hContentInfo = The handle returned by PeerDistServerOpenContentInformation.
///    cbMaxNumberOfBytes = The maximum number of bytes to read.
///    pBuffer = Pointer to the buffer that receives the content information data.
///    lpOverlapped = Pointer to an OVERLAPPED structure. This function does not allow the caller to specify the start Offset in the
///                   content. The offset is implicitly maintained per hContentInfo. The Offset and OffsetHigh are reserved and must be
///                   zero.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hContentInfo</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_NO_MORE</b></dt> </dl> </td> <td width="60%"> EOF on the content information has been
///    reached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td
///    width="60%"> The feature is disabled by Group Policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The service is unavailable. </td>
///    </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerRetrieveContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentInfo, uint cbMaxNumberOfBytes, 
                                              char* pBuffer, OVERLAPPED* lpOverlapped);

///The <b>PeerDistServerCloseContentInformation</b> function closes the handle opened by
///PeerDistServerOpenContentInformation.
///Params:
///    hPeerDist = The <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentInfo = The handle returned by PeerDistServerOpenContentInformation.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The provided <i>hPeerDist</i> or
///    <i>hContentInfo</i> handles are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerCloseContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentInfo);

///The <b>PeerDistServerCancelAsyncOperation</b> function cancels the asynchronous operation associated with the content
///identifier and OVERLAPPED structure.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    cbContentIdentifier = The length, in bytes, of the content identifier.
///    pContentIdentifier = Pointer to an array that contains the content identifier.
///    pOverlapped = Pointer to an OVERLAPPED structure that contains the canceling asynchronous operation data.
///Returns:
///    The function will return <b>ERROR_SUCCESS</b> value if the operation associated with OVERLAPPED structure is
///    successfully canceled. Otherwise, the function may return one of the following values: <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hPeerDist</i> handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_OPERATION_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The operation for OVERLAPPED structure cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistServerCancelAsyncOperation(ptrdiff_t hPeerDist, uint cbContentIdentifier, char* pContentIdentifier, 
                                        OVERLAPPED* pOverlapped);

///The <b>PeerDistClientOpenContent</b> function opens and returns a PEERDIST_CONTENT_HANDLE. The client uses the
///content handle to retrieve data from the Peer Distribution service.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    pContentTag = Pointer to a [PEERDIST_CONTENT_TAG](./ns-peerdist-peerdist_content_tag.md) structure that contains a 16 byte
///                  client specified identifier. This parameter is used in conjunction with the PeerDistClientFlushContent function.
///    hCompletionPort = A handle to the completion port that can be used for retrieving the completion notification of the asynchronous
///                      function. To create a completion port, use the CreateIoCompletionPort function This parameter can be <b>NULL</b>.
///    ulCompletionKey = Value to be returned through the <i>lpCompletionKey</i> parameter of the GetQueuedCompletionStatus function. This
///                      parameter is ignored when <i>hCompletionPort</i> is <b>NULL</b>.
///    phContentHandle = A pointer to a variable that receives the <b>PEERDIST_CONTENT_HANDLE</b> used to retrieve or add data.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientOpenContent(ptrdiff_t hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, 
                               size_t ulCompletionKey, ptrdiff_t* phContentHandle);

///The <b>PeerDistClientCloseContent</b> function closes the content handle opened by PeerDistClientOpenContent.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentHandle = A <b>PEERDIST_CONTENT_HANDLE</b> opened by PeerDistClientOpenContent.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function may return one of the
///    following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hContent</i> handle is invalid. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientCloseContent(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle);

///The <b>PeerDistClientAddContentInformation</b> function adds the content information associated with a content handle
///opened by PeerDistClientOpenContent.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentHandle = A <b>PEERDIST_CONTENT_HANDLE</b> opened by PeerDistClientOpenContent.
///    cbNumberOfBytes = Number of bytes in the <i>pBuffer</i> array.
///    pBuffer = Pointer to the buffer that contains the content information. This buffer must remain valid for the duration of
///              the add operation. The caller must not use this buffer until the add operation is completed.
///    lpOverlapped = Pointer to an OVERLAPPED structure. The Internal member of OVERLAPPED structure contains the completion status of
///                   the asynchronous operation. The Offset and OffsetHigh are reserved and must be 0.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientAddContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbNumberOfBytes, 
                                         char* pBuffer, OVERLAPPED* lpOverlapped);

///The <b>PeerDistClientCompleteContentInformation</b> function completes the process of adding the content information.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentHandle = A <b>PEERDIST_CONTENT_HANDLE</b> returned by PeerDistClientOpenContent.
///    lpOverlapped = Pointer to an OVERLAPPED structure.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientCompleteContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, 
                                              OVERLAPPED* lpOverlapped);

///The <b>PeerDistClientAddData</b> function is used to supply content to the local cache. Typically this is done when
///data could not be found on the local network as indicated when either PeerDistClientBlockRead or
///PeerDistClientStreamRead complete with <b>ERROR_TIMEOUT</b> or <b>PEERDIST_ERROR_MISSING_DATA</b>.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentHandle = A <b>PEERDIST_CONTENT_HANDLE</b> returned by PeerDistClientOpenContent.
///    cbNumberOfBytes = The number of bytes to be added to the local cache.
///    pBuffer = Pointer to the buffer that contains the data to be added to the local cache. This buffer must remain valid for
///              the duration of the add operation. The caller must not use this buffer until the add operation is completed.
///    lpOverlapped = Pointer to an OVERLAPPED structure. The byte offset from the beginning of content, at which this data is being
///                   added, is specified by setting the <b>Offset</b> and <b>OffsetHigh</b> members of the OVERLAPPED structure. The
///                   <b>OffsetHigh</b> member MUST be set to the higher 32 bits of the byte offset and the <b>Offset</b> member MUST
///                   be set to the lower 32 bits of the byte offset.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hContent</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientAddData(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbNumberOfBytes, char* pBuffer, 
                           OVERLAPPED* lpOverlapped);

///The <b>PeerDistClientBlockRead</b> function reads content data blocks.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentHandle = A content handle opened by PeerDistClientOpenContent function call.
///    cbMaxNumberOfBytes = The maximum number of bytes to read. If the <i>cbMaxNumberOfBytesToRead</i> is equal to 0, it indicates that the
///                         <b>PeerDistClientBlockRead</b> function is querying the length of available consecutive content byes in the local
///                         cache at the current block read offset. The query will neither download content from the peers, nor return the
///                         count of bytes present in the peer cache.
///    pBuffer = Pointer to the buffer that receives the data from the local cache. This buffer must remain valid for the duration
///              of the read operation. The caller must not use this buffer until the read operation is completed. If the
///              <i>cbMaxNumberOfBytesToRead</i> argument is equal to 0, the <i>pBuffer</i> parameter can be <b>NULL</b>
///    dwTimeoutInMilliseconds = Timeout value for the read, in milliseconds. There are two special values that may be specified: <table> <tr>
///                              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PEERDIST_READ_TIMEOUT_LOCAL_CACHE_ONLY"></a><a
///                              id="peerdist_read_timeout_local_cache_only"></a><dl> <dt><b>PEERDIST_READ_TIMEOUT_LOCAL_CACHE_ONLY</b></dt> </dl>
///                              </td> <td width="60%"> Specifies that a read should not cause any additional network traffic by contacting peers
///                              or a Hosted Cache. </td> </tr> <tr> <td width="40%"><a id="PEERDIST_READ_TIMEOUT_DEFAULT"></a><a
///                              id="peerdist_read_timeout_default"></a><dl> <dt><b>PEERDIST_READ_TIMEOUT_DEFAULT</b></dt> </dl> </td> <td
///                              width="60%"> Specifies the default timeout of 5 seconds. </td> </tr> </table>
///    lpOverlapped = Pointer to an OVERLAPPED structure. The start offset for read is specified by setting the <b>Offset</b> and
///                   <b>OffsetHigh</b> members of the OVERLAPPED structure. The <b>OffsetHigh</b> member should be set to the higher
///                   32 bits of the start offset and the <b>Offset</b> member should be set to the lower 32 bits of the start offset.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hContent</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientBlockRead(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbMaxNumberOfBytes, char* pBuffer, 
                             uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

///The <b>PeerDistClientStreamRead</b> reads a sequence of bytes from content stream.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentHandle = A content handle opened by the PeerDistClientOpenContent function call.
///    cbMaxNumberOfBytes = The maximum number of bytes to read. If the <i>cbMaxNumberOfBytesToRead</i> is equal to 0, it indicates that the
///                         <b>PeerDistClientStreamRead</b> function is querying the length of available consecutive content byes in the
///                         local cache at the current stream read offset. The query will neither download content from the peers, nor return
///                         the count of bytes present in the peer cache.
///    pBuffer = Pointer to the buffer that receives the data from the local cache. This buffer must remain valid for the duration
///              of the read operation. The caller must not use this buffer until the read operation is completed. If the
///              <i>cbMaxNumberOfBytesToRead</i> argument is equal to 0, the <i>pBuffer</i> parameter can be <b>NULL</b>.
///    dwTimeoutInMilliseconds = Timeout value for the read, in milliseconds. There are two special values that may be specified: <table> <tr>
///                              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PEERDIST_READ_TIMEOUT_LOCAL_CACHE_ONLY"></a><a
///                              id="peerdist_read_timeout_local_cache_only"></a><dl> <dt><b>PEERDIST_READ_TIMEOUT_LOCAL_CACHE_ONLY</b></dt> </dl>
///                              </td> <td width="60%"> Specifies that a read should not cause any additional network traffic by contacting peers
///                              or a Hosted Cache. </td> </tr> <tr> <td width="40%"><a id="PEERDIST_READ_TIMEOUT_DEFAULT"></a><a
///                              id="peerdist_read_timeout_default"></a><dl> <dt><b>PEERDIST_READ_TIMEOUT_DEFAULT</b></dt> </dl> </td> <td
///                              width="60%"> Specifies the default timeout of 5 seconds. </td> </tr> </table>
///    lpOverlapped = Pointer to an OVERLAPPED structure. Stream read does not allow the caller to specify the start <b>Offset</b> for
///                   the reading. The next stream read offset is implicitly maintained per <i>hContentHandle</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> or <i>hContent</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientStreamRead(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbMaxNumberOfBytes, 
                              char* pBuffer, uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

///The [PEERDIST_CONTENT_TAG](./ns-peerdist-peerdist_content_tag.md).
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    pContentTag = Pointer to a [PEERDIST_CONTENT_TAG](./ns-peerdist-peerdist_content_tag.md) structure that contains the tag
///                  supplied when PeerDistClientOpenContent is called.
///    hCompletionPort = A handle to the completion port that can be used for retrieving the completion notification of the asynchronous
///                      function. To create a completion port, use the CreateIoCompletionPort function. This parameter can be
///                      <b>NULL</b>.
///    ulCompletionKey = Value to be returned through the <i>lpCompletionKey</i> parameter of the GetQueuedCompletionStatus function. This
///                      parameter is ignored when <i>hCompletionPort</i> is <b>NULL</b>.
///    lpOverlapped = Pointer to an OVERLAPPED structure. <b>Offset</b> and <b>OffsetHigh</b> are reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_IO_PENDING</b>. Otherwise, the function may return one of
///    the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientFlushContent(ptrdiff_t hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, 
                                size_t ulCompletionKey, OVERLAPPED* lpOverlapped);

///The <b>PeerDistClientCancelAsyncOperation</b> function cancels asynchronous operation associated with an OVERLAPPED
///structure and the content handle returned by PeerDistClientOpenContent.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hContentHandle = A content handle opened by PeerDistClientOpenContent function call.
///    pOverlapped = Pointer to an OVERLAPPED structure that contains the canceling asynchronous operation data. If the pointer is
///                  <b>NULL</b> all asynchronous operations for specified content handle will be canceled.
///Returns:
///    The function will return <b>ERROR_SUCCESS</b> value if the operation associated with the specified OVERLAPPED
///    structure is successfully canceled. Otherwise, the function may return one of the following values: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hPeerDist</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PEERDIST_ERROR_OPERATION_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The operation associated with the
///    specified OVERLAPPED structure cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The feature is disabled by Group
///    Policy. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PEERDIST_ERROR_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The service is unavailable. </td> </tr> </table>
///    
@DllImport("PeerDist")
uint PeerDistClientCancelAsyncOperation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, OVERLAPPED* pOverlapped);

///The <b>PeerDistGetStatusEx</b> function returns the current status and capabilities of the Peer Distribution service.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    pPeerDistStatus = A pointer to a PEERDIST_STATUS_INFO structure that contains the current status and capabilities of the Peer
///                      Distribution service.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("PeerDist")
uint PeerDistGetStatusEx(ptrdiff_t hPeerDist, PEERDIST_STATUS_INFO* pPeerDistStatus);

///The <b>PeerDistRegisterForStatusChangeNotificationEx</b> function requests the Peer Distribution service status
///change notification.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    hCompletionPort = A handle to the completion port that can be used for retrieving the completion notification of the asynchronous
///                      function. To create a completion port, use the CreateIoCompletionPort function. This parameter can be
///                      <b>NULL</b>.
///    ulCompletionKey = Value to be returned through the <i>lpCompletionKey</i> parameter of the GetQueuedCompletionStatus function. This
///                      parameter is ignored when <i>hCompletionPort</i> is <b>NULL</b>.
///    lpOverlapped = Pointer to an OVERLAPPED structure. If the <b>hEvent</b> member of the structure is not <b>NULL</b>, it will be
///                   signaled via SetEvent() used in order to signal the notification. This can occur even if the completion port is
///                   specified via the <i>hCompletionPort</i> argument.
///    pPeerDistStatus = A pointer to a PEERDIST_STATUS_INFO structure that contains the current status and capabilities of the Peer
///                      Distribution service.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS.
///    
@DllImport("PeerDist")
uint PeerDistRegisterForStatusChangeNotificationEx(ptrdiff_t hPeerDist, HANDLE hCompletionPort, 
                                                   size_t ulCompletionKey, OVERLAPPED* lpOverlapped, 
                                                   PEERDIST_STATUS_INFO* pPeerDistStatus);

///The <b>PeerDistGetOverlappedResult</b> function retrieves the results of asynchronous operations. This function
///replaces the GetOverlappedResult function for Peer Distribution asynchronous operations.
///Params:
///    lpOverlapped = A pointer to an OVERLAPPED structure that was specified when the overlapped operation was started.
///    lpNumberOfBytesTransferred = A pointer to a variable that receives the number of bytes that were actually transferred by a read or write
///                                 operation.
///    bWait = If this parameter is `true`, the function does not return until the operation has been completed. If this
///            parameter is `false` and the operation is still pending, the function returns `false`.
@DllImport("PeerDist")
BOOL PeerDistGetOverlappedResult(OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

///The <b>PeerDistServerOpenContentInformationEx</b> function opens a <b>PEERDIST_CONTENTINFO_HANDLE</b>. The client
///uses the handle to retrieve content information.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by PeerDistStartup.
///    cbContentIdentifier = The length, in bytes, of the content identifier.
///    pContentIdentifier = Pointer to a buffer that contains the content identifier.
///    ullContentOffset = An offset from the beginning of the published content for which the content information handle is requested.
///    cbContentLength = The length, in bytes, of the content (starting from the ullContentOffset) for which the content information is
///                      requested.
///    pRetrievalOptions = A PEER_RETRIEVAL_OPTIONS structure specifying additional options for retrieving content information.
///    hCompletionPort = A handle to the completion port used for retrieving the completion notification of the asynchronous function. To
///                      create a completion port, use the CreateIoCompletionPort function. This parameter can be <b>NULL</b>.
///    ulCompletionKey = Value to be returned through the <i>lpCompletionKey</i> parameter of the GetQueuedCompletionStatus function. This
///                      parameter is ignored when <i>hCompletionPort</i> is <b>NULL</b>.
///    phContentInfo = A handle used to retrieve the content information.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("PeerDist")
uint PeerDistServerOpenContentInformationEx(ptrdiff_t hPeerDist, uint cbContentIdentifier, 
                                            char* pContentIdentifier, ulong ullContentOffset, ulong cbContentLength, 
                                            PEERDIST_RETRIEVAL_OPTIONS* pRetrievalOptions, HANDLE hCompletionPort, 
                                            size_t ulCompletionKey, ptrdiff_t* phContentInfo);

///The <b>PeerDistClientGetInformationByHandle</b> function retrieves additional information from the Peer Distribution
///service for a specific content handle.
///Params:
///    hPeerDist = A <b>PEERDIST_INSTANCE_HANDLE</b> returned by the PeerDistStartup function.
///    hContentHandle = A <b>PEERDIST_CONTENT_HANDLE</b> returned by the PeerDistClientOpenContent function.
///    PeerDistClientInfoClass = A value from the PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS enumeration that indicates the information to retrieve.
///    dwBufferSize = The size, in bytes, of the buffer for the <i>lpInformation</i> parameter.
///    lpInformation = A buffer for the returned information. The format of this information depends on the value of the
///                    <i>PeerDistClientInfoClass</i> parameter.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS.
///    
@DllImport("PeerDist")
uint PeerDistClientGetInformationByHandle(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, 
                                          PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS PeerDistClientInfoClass, 
                                          uint dwBufferSize, char* lpInformation);


