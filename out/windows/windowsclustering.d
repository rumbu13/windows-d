// Written in the D programming language.

module windows.windowsclustering;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HFONT, HICON;
public import windows.security : SC_HANDLE__;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, NTSTATUS, PWSTR,
                                       SECURITY_ATTRIBUTES, SECURITY_DESCRIPTOR_RELATIVE,
                                       ULARGE_INTEGER;
public import windows.windowsprogramming : FILETIME, HKEY, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///The type of quorum resource to be created.
alias CLUSTER_QUORUM_TYPE = int;
enum : int
{
    ///TBD
    OperationalQuorum = 0x00000000,
    ///TBD
    ModifyQuorum      = 0x00000001,
}

///Indicates the state of the cluster. The GetNodeClusterState function uses this enumeration.
alias NODE_CLUSTER_STATE = int;
enum : int
{
    ///The Cluster service is not installed on the node.
    ClusterStateNotInstalled  = 0x00000000,
    ///The Cluster service is installed on the node but has not yet been configured.
    ClusterStateNotConfigured = 0x00000001,
    ///The Cluster service is installed and configured on the node but is not currently running.
    ClusterStateNotRunning    = 0x00000003,
    ///The Cluster service is installed, configured, and running on the node.
    ClusterStateRunning       = 0x00000013,
}

///Used by the CLUSCTL_RESOURCE_STATE_CHANGE_REASON_STRUCT and CLUSCTL_RESOURCE_STATE_CHANGE_REASON control codes to
///describe the reason for a resource state change.
alias CLUSTER_RESOURCE_STATE_CHANGE_REASON = int;
enum : int
{
    ///This reason code is never sent by the cluster. Resource DLLs should use this value to initialize a local
    ///CLUSCTL_RESOURCE_STATE_CHANGE_REASON_STRUCT structure and to reset the <b>eReason</b> member of the
    ///<b>CLUSCTL_RESOURCE_STATE_CHANGE_REASON_STRUCT</b> structure before returning from the Offline and Terminate
    ///entry point functions. For more information, see CLUSCTL_RESOURCE_STATE_CHANGE_REASON.
    eResourceStateChangeReasonUnknown    = 0x00000000,
    ///Offline is about to be called because the resource's group is being moved.
    eResourceStateChangeReasonMove       = 0x00000001,
    ///Terminate is about to be called because the resource's group is being failed over.
    eResourceStateChangeReasonFailover   = 0x00000002,
    ///Online is about to be called because the resource's group did not successfully complete a move operation.
    eResourceStateChangeReasonFailedMove = 0x00000003,
    ///Offline is about to be called because the Cluster service is being shut down.
    eResourceStateChangeReasonShutdown   = 0x00000004,
    ///Terminate is about to be called because the Cluster service has stopped unexpectedly.
    eResourceStateChangeReasonRundown    = 0x00000005,
}

///Enumerates the possible cluster registry commands that a local node will perform when attempting to join a cluster.
///It is used by the CLUSTER_BATCH_COMMAND and CLUSTER_READ_BATCH_COMMAND structures.
alias CLUSTER_REG_COMMAND = int;
enum : int
{
    ///This constant is not a valid command. It and the <b>CLUSREG_LAST_COMMAND</b> constant act as brackets that
    ///contain the valid commands.
    CLUSREG_COMMAND_NONE              = 0x00000000,
    ///This command sets a value relative to the last executed <b>CLUSREG_CREATE_KEY</b> command or (if not provided)
    ///relative to a key passed into the ClusterRegCreateBatch function.
    CLUSREG_SET_VALUE                 = 0x00000001,
    ///This command will create a specified cluster registry key if it does not exist, or opens an existing one.
    CLUSREG_CREATE_KEY                = 0x00000002,
    ///This command will delete a key with all values and nested subkeys. No commands that operate on values can follow
    ///<b>CLUSREG_DELETE_KEY</b> until <b>CLUSREG_CREATE_KEY</b> is added.
    CLUSREG_DELETE_KEY                = 0x00000003,
    ///This command deletes a value relative to the last executed <b>CLUSREG_CREATE_KEY</b> command or (if not provided)
    ///relative to a key passed into the ClusterRegCreateBatch function.
    CLUSREG_DELETE_VALUE              = 0x00000004,
    ///This command is reserved for future use.
    CLUSREG_SET_KEY_SECURITY          = 0x00000005,
    ///This command is returned only through a batch update notification port. It indicates whether a specific cluster
    ///registry value has been deleted or whether the data of that cluster registry value has been changed.
    CLUSREG_VALUE_DELETED             = 0x00000006,
    CLUSREG_READ_KEY                  = 0x00000007,
    ///This command indicates that content was read successfully for the requested value.
    CLUSREG_READ_VALUE                = 0x00000008,
    ///This command indicates that a value was missing or another error occurred during read.
    CLUSREG_READ_ERROR                = 0x00000009,
    ///A control command. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008: </b>This value is not
    ///available before Windows Server 2012 R2.
    CLUSREG_CONTROL_COMMAND           = 0x0000000a,
    ///A condition that indicates that a value exists. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This value is not available before Windows Server 2016.
    CLUSREG_CONDITION_EXISTS          = 0x0000000b,
    ///A condition that indicates that a value does not exist. <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This value is not available before Windows Server 2016.
    CLUSREG_CONDITION_NOT_EXISTS      = 0x0000000c,
    ///A condition that indicates that a value is equal to another. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This value is not available before Windows Server 2016.
    CLUSREG_CONDITION_IS_EQUAL        = 0x0000000d,
    ///A condition that indicates that a value is not equal to another. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This value is not available before Windows Server 2016.
    CLUSREG_CONDITION_IS_NOT_EQUAL    = 0x0000000e,
    ///A condition that indicates that a value is greater than another. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This value is not available before Windows Server 2016.
    CLUSREG_CONDITION_IS_GREATER_THAN = 0x0000000f,
    ///A condition that indicates that a value is less than another. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This value is not available before Windows Server 2016.
    CLUSREG_CONDITION_IS_LESS_THAN    = 0x00000010,
    ///A condition that indicates that a key exists. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This value is not available before Windows Server 2016.
    CLUSREG_CONDITION_KEY_EXISTS      = 0x00000011,
    CLUSREG_CONDITION_KEY_NOT_EXISTS  = 0x00000012,
    ///This constant is not a valid command. It and the <b>CLUSREG_COMMAND_NONE</b> constant act as brackets that
    ///contain the valid commands. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and Windows
    ///Server 2008: </b>The value of this constant is lower before Windows Server 2016.
    CLUSREG_LAST_COMMAND              = 0x00000013,
}

///Specifies the type of cluster group to create.
alias CLUSGROUP_TYPE = int;
enum : int
{
    ///A core cluster group.
    ClusGroupTypeCoreCluster              = 0x00000001,
    ///An available storage cluster group.
    ClusGroupTypeAvailableStorage         = 0x00000002,
    ///A temporary cluster group.
    ClusGroupTypeTemporary                = 0x00000003,
    ///A shared volume.
    ClusGroupTypeSharedVolume             = 0x00000004,
    ///A storage pool.
    ClusGroupTypeStoragePool              = 0x00000005,
    ///A file server.
    ClusGroupTypeFileServer               = 0x00000064,
    ///A print server.
    ClusGroupTypePrintServer              = 0x00000065,
    ///A Dynamic Host Configuration Protocol (DHCP) server.
    ClusGroupTypeDhcpServer               = 0x00000066,
    ///A Distributed Transaction Coordinator (DTC) service.
    ClusGroupTypeDtc                      = 0x00000067,
    ///An Microsoft Message Queuing (MSMQ) service.
    ClusGroupTypeMsmq                     = 0x00000068,
    ///A Windows Internet Name Service (WINS).
    ClusGroupTypeWins                     = 0x00000069,
    ///A standalone Distributed File System (DFS).
    ClusGroupTypeStandAloneDfs            = 0x0000006a,
    ///A generic application.
    ClusGroupTypeGenericApplication       = 0x0000006b,
    ///A generic service.
    ClusGroupTypeGenericService           = 0x0000006c,
    ///A generic script.
    ClusGroupTypeGenericScript            = 0x0000006d,
    ///An Internet Small Computer System Interface (iSCSI) name service.
    ClusGroupTypeIScsiNameService         = 0x0000006e,
    ///A virtual machine.
    ClusGroupTypeVirtualMachine           = 0x0000006f,
    ///A Terminal Services Session Broker.
    ClusGroupTypeTsSessionBroker          = 0x00000070,
    ///An iSCSI target.
    ClusGroupTypeIScsiTarget              = 0x00000071,
    ///A Scale-Out File Server.
    ClusGroupTypeScaleoutFileServer       = 0x00000072,
    ///A virtual machine replica broker.
    ClusGroupTypeVMReplicaBroker          = 0x00000073,
    ///A task scheduler.
    ClusGroupTypeTaskScheduler            = 0x00000074,
    ///A cluster update agent.
    ClusGroupTypeClusterUpdateAgent       = 0x00000075,
    ///A cluster on a scale-out file server. <b>Windows Server 2012 R2 and Windows Server 2012: </b>This member is not
    ///supported until Windows Server 2016.
    ClusGroupTypeScaleoutCluster          = 0x00000076,
    ///A storage replica. <b>Windows Server 2012 R2 and Windows Server 2012: </b>This member is not supported until
    ///Windows Server 2016.
    ClusGroupTypeStorageReplica           = 0x00000077,
    ///A virtual machine replica coordinator. <b>Windows Server 2012 R2 and Windows Server 2012: </b>This member is not
    ///supported until Windows Server 2016.
    ClusGroupTypeVMReplicaCoordinator     = 0x00000078,
    ///A cross-cluster orchestrator. <b>Windows Server 2012 R2 and Windows Server 2012: </b>This member is not supported
    ///until Windows Server 2016.
    ClusGroupTypeCrossClusterOrchestrator = 0x00000079,
    ClusGroupTypeInfrastructureFileServer = 0x0000007a,
    ///An unknown cluster group type.
    ClusGroupTypeUnknown                  = 0x0000270f,
}

///Specifies the type of the management point for the cluster. <b>CLUSTER_MGMT_POINT_TYPE</b> is used as a possible
///value in the CreateCluster configuration structure.
alias CLUSTER_MGMT_POINT_TYPE = int;
enum : int
{
    ///The cluster has no management point.
    CLUSTER_MGMT_POINT_TYPE_NONE     = 0x00000000,
    ///The management point is a cluster name object.
    CLUSTER_MGMT_POINT_TYPE_CNO      = 0x00000001,
    ///The management point is DNS only.
    CLUSTER_MGMT_POINT_TYPE_DNS_ONLY = 0x00000002,
    ///The management point type is cluster name object (CNO) only. <b>Windows Server 2012 R2: </b>This value is not
    ///supported before Windows Server 2016.
    CLUSTER_MGMT_POINT_TYPE_CNO_ONLY = 0x00000003,
}

alias CLUSTER_MGMT_POINT_RESTYPE = int;
enum : int
{
    CLUSTER_MGMT_POINT_RESTYPE_AUTO = 0x00000000,
    CLUSTER_MGMT_POINT_RESTYPE_SNN  = 0x00000001,
    CLUSTER_MGMT_POINT_RESTYPE_DNN  = 0x00000002,
}

alias CLUSTER_CLOUD_TYPE = int;
enum : int
{
    CLUSTER_CLOUD_TYPE_NONE    = 0x00000000,
    CLUSTER_CLOUD_TYPE_AZURE   = 0x00000001,
    CLUSTER_CLOUD_TYPE_MIXED   = 0x00000080,
    CLUSTER_CLOUD_TYPE_UNKNOWN = 0xffffffff,
}

///Enumerates the start settings for a cluster group.
alias CLUS_GROUP_START_SETTING = int;
enum : int
{
    ///Always start the cluster.
    CLUS_GROUP_START_ALWAYS  = 0x00000000,
    ///Do not start the cluster.
    CLUS_GROUP_DO_NOT_START  = 0x00000001,
    CLUS_GROUP_START_ALLOWED = 0x00000002,
}

alias CLUS_AFFINITY_RULE_TYPE = int;
enum : int
{
    CLUS_AFFINITY_RULE_NONE                   = 0x00000000,
    CLUS_AFFINITY_RULE_SAME_FAULT_DOMAIN      = 0x00000001,
    CLUS_AFFINITY_RULE_SAME_NODE              = 0x00000002,
    CLUS_AFFINITY_RULE_DIFFERENT_FAULT_DOMAIN = 0x00000003,
    CLUS_AFFINITY_RULE_DIFFERENT_NODE         = 0x00000004,
    CLUS_AFFINITY_RULE_MIN                    = 0x00000000,
    CLUS_AFFINITY_RULE_MAX                    = 0x00000004,
}

///Enumerates values returned by the ClusterControl function with the CLUSCTL_CLUSTER_CHECK_VOTER_DOWN or the
///CLUSCTL_CLUSTER_CHECK_VOTER_EVICT control codes.
alias CLUSTER_QUORUM_VALUE = int;
enum : int
{
    ///The quorum will be maintained.
    CLUSTER_QUORUM_MAINTAINED = 0x00000000,
    ///The quorum will be lost.
    CLUSTER_QUORUM_LOST       = 0x00000001,
}

///Describes the state of a rolling upgrade of the operating system on a cluster. This enumeration is used by the
///ClusterUpgradeProgressCallback callback function.
alias CLUSTER_UPGRADE_PHASE = int;
enum : int
{
    ///The nodes are being notified that an upgrade has started.
    ClusterUpgradePhaseInitialize              = 0x00000001,
    ///The updated is being validated to determine whether the all of nodes in the cluster can be upgraded.
    ClusterUpgradePhaseValidatingUpgrade       = 0x00000002,
    ///The nodes are being upgraded.
    ClusterUpgradePhaseUpgradingComponents     = 0x00000003,
    ///The new resources are being installed.
    ClusterUpgradePhaseInstallingNewComponents = 0x00000004,
    ///The upgrade is complete.
    ClusterUpgradePhaseUpgradeComplete         = 0x00000005,
}

///Describes the type of notification returned. The GetClusterNotify, RegisterClusterNotify, and CreateCluster functions
///use this enumeration.
alias CLUSTER_CHANGE = int;
enum : int
{
    ///The queue receives a notification when a node changes state. For a list of possible node state values, see
    ///GetClusterNodeState.
    CLUSTER_CHANGE_NODE_STATE             = 0x00000001,
    ///The queue receives a notification when a node is permanently removed from a cluster. A node can be permanently
    ///deleted from an existing cluster with a call to the EvictClusterNode function.
    CLUSTER_CHANGE_NODE_DELETED           = 0x00000002,
    ///The queue receives a notification when a new node is added to the cluster. A node can be added only when the
    ///Cluster service is initially installed on the node.
    CLUSTER_CHANGE_NODE_ADDED             = 0x00000004,
    ///This notification is reserved for future use.
    CLUSTER_CHANGE_NODE_PROPERTY          = 0x00000008,
    ///The queue receives a notification when the name of a cluster database key has changed.
    CLUSTER_CHANGE_REGISTRY_NAME          = 0x00000010,
    ///The queue receives a notification when a cluster database key's attributes are changed. The only currently
    ///defined cluster database key attribute is its security descriptor, which can be changed with
    ///ClusterRegSetKeySecurity.
    CLUSTER_CHANGE_REGISTRY_ATTRIBUTES    = 0x00000020,
    ///The queue receives a notification when a value of the specified cluster database key is changed or deleted.
    ///Cluster database values can be changed with the ClusterRegSetValue function and deleted with the
    ///ClusterRegDeleteValue function.
    CLUSTER_CHANGE_REGISTRY_VALUE         = 0x00000040,
    ///Indicates that the other <b>CLUSTER_CHANGE_REGISTRY_*</b> events apply to the entire cluster database. If this
    ///flag is not included, the events apply only to the specified key.
    CLUSTER_CHANGE_REGISTRY_SUBTREE       = 0x00000080,
    ///The queue receives a notification when a resource changes state. For a list of the possible resource state
    ///values, see GetClusterResourceState.
    CLUSTER_CHANGE_RESOURCE_STATE         = 0x00000100,
    ///The queue receives a notification when a resource is deleted.
    CLUSTER_CHANGE_RESOURCE_DELETED       = 0x00000200,
    ///The queue receives a notification when a new resource is created in the cluster.
    CLUSTER_CHANGE_RESOURCE_ADDED         = 0x00000400,
    ///The queue receives a notification when the properties, dependencies, or possible owner nodes of a resource
    ///change.
    CLUSTER_CHANGE_RESOURCE_PROPERTY      = 0x00000800,
    ///The queue receives a notification when a group changes state. For a list of the possible group state values, see
    ///GetClusterGroupState.
    CLUSTER_CHANGE_GROUP_STATE            = 0x00001000,
    ///The queue receives a notification when an existing group is deleted.
    CLUSTER_CHANGE_GROUP_DELETED          = 0x00002000,
    ///The queue receives a notification when a new group is created in the cluster.
    CLUSTER_CHANGE_GROUP_ADDED            = 0x00004000,
    ///The queue receives a notification when the properties of a group change or when a resource is added or removed
    ///from a group.
    CLUSTER_CHANGE_GROUP_PROPERTY         = 0x00008000,
    ///The queue receives a notification when an existing resource type is deleted.
    CLUSTER_CHANGE_RESOURCE_TYPE_DELETED  = 0x00010000,
    ///The queue receives a notification when a new resource type is created in the cluster.
    CLUSTER_CHANGE_RESOURCE_TYPE_ADDED    = 0x00020000,
    ///The queue receives a notification when the properties of a resource type change.
    CLUSTER_CHANGE_RESOURCE_TYPE_PROPERTY = 0x00040000,
    ///When generated by a client, this value indicates that the RPC connection to a server has been reconnected to
    ///another server for the specified cluster. When generated by the server, this value indicates that notification
    ///events were dropped by the server for the port.
    CLUSTER_CHANGE_CLUSTER_RECONNECT      = 0x00080000,
    ///The queue receives a notification when a network changes state. For a list of the possible network state values,
    ///see GetClusterNetworkState.
    CLUSTER_CHANGE_NETWORK_STATE          = 0x00100000,
    ///The queue receives a notification when a network is permanently removed from the cluster environment.
    CLUSTER_CHANGE_NETWORK_DELETED        = 0x00200000,
    ///The queue receives a notification when a new network is added to the cluster environment.
    CLUSTER_CHANGE_NETWORK_ADDED          = 0x00400000,
    ///The queue receives a notification when the properties of an existing network change.
    CLUSTER_CHANGE_NETWORK_PROPERTY       = 0x00800000,
    ///The queue receives a notification when a network interface changes state. For a list of the possible network
    ///interface state values, see GetClusterNetInterfaceState.
    CLUSTER_CHANGE_NETINTERFACE_STATE     = 0x01000000,
    ///The queue receives a notification when a network interface is permanently removed from a cluster node.
    CLUSTER_CHANGE_NETINTERFACE_DELETED   = 0x02000000,
    ///The queue receives a notification when a new network interface is added to a cluster node.
    CLUSTER_CHANGE_NETINTERFACE_ADDED     = 0x04000000,
    ///The queue receives a notification when the properties of an existing network interface change.
    CLUSTER_CHANGE_NETINTERFACE_PROPERTY  = 0x08000000,
    ///This notification is reserved for future use.
    CLUSTER_CHANGE_QUORUM_STATE           = 0x10000000,
    ///The queue receives a notification when the cluster becomes unavailable, meaning that all attempts to communicate
    ///with the cluster fail.
    CLUSTER_CHANGE_CLUSTER_STATE          = 0x20000000,
    ///The queue receives a notification when the cluster's prioritized list of internal networks changes.
    CLUSTER_CHANGE_CLUSTER_PROPERTY       = 0x40000000,
    ///The queue receives a notification when a handle associated with a cluster object is closed.
    CLUSTER_CHANGE_HANDLE_CLOSE           = 0x80000000,
    CLUSTER_CHANGE_ALL                    = 0xffffffff,
}

///Defines the various versions of cluster notification enumerations.
alias CLUSTER_NOTIFICATIONS_VERSION = int;
enum : int
{
    ///Version 1 of the cluster notification enumeration.
    CLUSTER_NOTIFICATIONS_V1 = 0x00000001,
    ///Version 2 of the cluster notification enumeration.
    CLUSTER_NOTIFICATIONS_V2 = 0x00000002,
}

///Defines the list of notifications that are generated for a cluster.
alias CLUSTER_CHANGE_CLUSTER_V2 = int;
enum : int
{
    ///Indicates that a reconnect procedure occurred. This notification applies to clients only.
    CLUSTER_CHANGE_CLUSTER_RECONNECT_V2           = 0x00000001,
    ///Indicates that a cluster state changed. This notification applies to clients only.
    CLUSTER_CHANGE_CLUSTER_STATE_V2               = 0x00000002,
    ///Indicates that a new group was created.
    CLUSTER_CHANGE_CLUSTER_GROUP_ADDED_V2         = 0x00000004,
    ///Indicates that a context handle was closed. This notification applies to clients only.
    CLUSTER_CHANGE_CLUSTER_HANDLE_CLOSE_V2        = 0x00000008,
    ///Indicates that a cluster network was added to the cluster.
    CLUSTER_CHANGE_CLUSTER_NETWORK_ADDED_V2       = 0x00000010,
    ///Indicates that a node was added to the cluster. Nodes are added to a cluster in an implementation-specific way.
    CLUSTER_CHANGE_CLUSTER_NODE_ADDED_V2          = 0x00000020,
    ///Indicates that a new resource type was added to the cluster.
    CLUSTER_CHANGE_CLUSTER_RESOURCE_TYPE_ADDED_V2 = 0x00000040,
    ///Indicates that a cluster common property changed.
    CLUSTER_CHANGE_CLUSTER_COMMON_PROPERTY_V2     = 0x00000080,
    ///Indicates that a cluster private property changed.
    CLUSTER_CHANGE_CLUSTER_PRIVATE_PROPERTY_V2    = 0x00000100,
    ///Indicates that notifications might have been lost due to a transient condition on the server.
    CLUSTER_CHANGE_CLUSTER_LOST_NOTIFICATIONS_V2  = 0x00000200,
    ///Indicates that the cluster's name changed.
    CLUSTER_CHANGE_CLUSTER_RENAME_V2              = 0x00000400,
    ///Indicates that the cluster's membership changed.
    CLUSTER_CHANGE_CLUSTER_MEMBERSHIP_V2          = 0x00000800,
    ///Indicates that the cluster upgraded the Cluster service. <b>Windows Server 2012 R2 and Windows Server 2012:
    ///</b>This value is not supported until Windows Server 2016.
    CLUSTER_CHANGE_CLUSTER_UPGRADED_V2            = 0x00001000,
    CLUSTER_CHANGE_CLUSTER_ALL_V2                 = 0x00001fff,
}

///Defines the list of notifications that are generated for a group.
alias CLUSTER_CHANGE_GROUP_V2 = int;
enum : int
{
    ///Indicates that a group was deleted.
    CLUSTER_CHANGE_GROUP_DELETED_V2          = 0x00000001,
    ///Indicates that a group's common property changed.
    CLUSTER_CHANGE_GROUP_COMMON_PROPERTY_V2  = 0x00000002,
    ///Indicates that a group's private property changed.
    CLUSTER_CHANGE_GROUP_PRIVATE_PROPERTY_V2 = 0x00000004,
    ///Indicates that the group's state changed.
    CLUSTER_CHANGE_GROUP_STATE_V2            = 0x00000008,
    ///Indicates that the group's owner node has changed.
    CLUSTER_CHANGE_GROUP_OWNER_NODE_V2       = 0x00000010,
    ///Indicates that the group's preferred owners have changed.
    CLUSTER_CHANGE_GROUP_PREFERRED_OWNERS_V2 = 0x00000020,
    ///Indicates that a resource was added to the group.
    CLUSTER_CHANGE_GROUP_RESOURCE_ADDED_V2   = 0x00000040,
    ///Indicates that the group gained a resource.
    CLUSTER_CHANGE_GROUP_RESOURCE_GAINED_V2  = 0x00000080,
    ///Indicates that a resource is no longer part of the group.
    CLUSTER_CHANGE_GROUP_RESOURCE_LOST_V2    = 0x00000100,
    ///Indicates that the group's context handle was closed.
    CLUSTER_CHANGE_GROUP_HANDLE_CLOSE_V2     = 0x00000200,
    ///Indicates all V2 group notifications.
    CLUSTER_CHANGE_GROUP_ALL_V2              = 0x000003ff,
}

///Defines the list of notifications that are generated for a groupset.
alias CLUSTER_CHANGE_GROUPSET_V2 = int;
enum : int
{
    ///Indicates that a groupset was deleted.
    CLUSTER_CHANGE_GROUPSET_DELETED_v2          = 0x00000001,
    ///Indicates that a common property of the groupset has changed.
    CLUSTER_CHANGE_GROUPSET_COMMON_PROPERTY_V2  = 0x00000002,
    ///Indicates that a private property of the groupset has changed.
    CLUSTER_CHANGE_GROUPSET_PRIVATE_PROPERTY_V2 = 0x00000004,
    ///Indicates that the group's state changed.
    CLUSTER_CHANGE_GROUPSET_STATE_V2            = 0x00000008,
    ///Indicates that a group has been added to the groupset.
    CLUSTER_CHANGE_GROUPSET_GROUP_ADDED         = 0x00000010,
    ///Indicates that a group has been removed from the groupset.
    CLUSTER_CHANGE_GROUPSET_GROUP_REMOVED       = 0x00000020,
    ///Indicates that the groupset's dependencies have changed.
    CLUSTER_CHANGE_GROUPSET_DEPENDENCIES_V2     = 0x00000040,
    ///Indicates that the groupset's dependents have changed.
    CLUSTER_CHANGE_GROUPSET_DEPENDENTS_V2       = 0x00000080,
    ///Indicates that the group's context handle was closed.
    CLUSTER_CHANGE_GROUPSET_HANDLE_CLOSE_v2     = 0x00000100,
    CLUSTER_CHANGE_GROUPSET_ALL_V2              = 0x000001ff,
}

///Defines the list of notifications that are generated for a resource.
alias CLUSTER_CHANGE_RESOURCE_V2 = int;
enum : int
{
    ///Indicates that the resource's common properties have changed.
    CLUSTER_CHANGE_RESOURCE_COMMON_PROPERTY_V2  = 0x00000001,
    ///Indicates that the resource's private properties have changed.
    CLUSTER_CHANGE_RESOURCE_PRIVATE_PROPERTY_V2 = 0x00000002,
    ///Indicates that the state of the resource has changed.
    CLUSTER_CHANGE_RESOURCE_STATE_V2            = 0x00000004,
    ///Indicates that the owner group of the resource has changed.
    CLUSTER_CHANGE_RESOURCE_OWNER_GROUP_V2      = 0x00000008,
    ///Indicates that the resource's dependencies have changed.
    CLUSTER_CHANGE_RESOURCE_DEPENDENCIES_V2     = 0x00000010,
    ///Indicates that the resource's dependents have changed.
    CLUSTER_CHANGE_RESOURCE_DEPENDENTS_V2       = 0x00000020,
    ///Indicates that the resource's possible owner nodes have changed.
    CLUSTER_CHANGE_RESOURCE_POSSIBLE_OWNERS_V2  = 0x00000040,
    ///Indicates that the resource has been deleted.
    CLUSTER_CHANGE_RESOURCE_DELETED_V2          = 0x00000080,
    ///Indicates that the resource's DLL has been upgraded.
    CLUSTER_CHANGE_RESOURCE_DLL_UPGRADED_V2     = 0x00000100,
    ///Indicates that the resource's context handle was closed.
    CLUSTER_CHANGE_RESOURCE_HANDLE_CLOSE_V2     = 0x00000200,
    ///TBD
    CLUSTER_CHANGE_RESOURCE_TERMINAL_STATE_V2   = 0x00000400,
    ///Indicates all V2 resource notifications.
    CLUSTER_CHANGE_RESOURCE_ALL_V2              = 0x000007ff,
}

///Defines the set of notifications that are generated for a resource type.
alias CLUSTER_CHANGE_RESOURCE_TYPE_V2 = int;
enum : int
{
    ///Indicates that the resource type has been deleted.
    CLUSTER_CHANGE_RESOURCE_TYPE_DELETED_V2          = 0x00000001,
    ///Indicates that the resource type common properties have changed.
    CLUSTER_CHANGE_RESOURCE_TYPE_COMMON_PROPERTY_V2  = 0x00000002,
    ///Indicates that the resource type private properties have changed.
    CLUSTER_CHANGE_RESOURCE_TYPE_PRIVATE_PROPERTY_V2 = 0x00000004,
    ///Indicates that the possible owners for the resource type have changed.
    CLUSTER_CHANGE_RESOURCE_TYPE_POSSIBLE_OWNERS_V2  = 0x00000008,
    ///Indicates that the resource type DLL has been upgraded.
    CLUSTER_CHANGE_RESOURCE_TYPE_DLL_UPGRADED_V2     = 0x00000010,
    ///An indication that is specific to the resource type. <b>Windows Server 2012 R2 and Windows Server 2012: </b>This
    ///member is not supported until Windows Server 2016.
    CLUSTER_RESOURCE_TYPE_SPECIFIC_V2                = 0x00000020,
    CLUSTER_CHANGE_RESOURCE_TYPE_ALL_V2              = 0x0000003f,
}

///Defines the set of notifications that are generated for a cluster network interface.
alias CLUSTER_CHANGE_NETINTERFACE_V2 = int;
enum : int
{
    ///Indicates that the cluster network interface has been deleted.
    CLUSTER_CHANGE_NETINTERFACE_DELETED_V2          = 0x00000001,
    ///Indicates that the common properties for the cluster interface have changed.
    CLUSTER_CHANGE_NETINTERFACE_COMMON_PROPERTY_V2  = 0x00000002,
    ///Indicates that the private properties for the cluster interface have changed.
    CLUSTER_CHANGE_NETINTERFACE_PRIVATE_PROPERTY_V2 = 0x00000004,
    ///Indicates that the state of the cluster interface has changed.
    CLUSTER_CHANGE_NETINTERFACE_STATE_V2            = 0x00000008,
    ///Indicates that the cluster interface's context handle was closed.
    CLUSTER_CHANGE_NETINTERFACE_HANDLE_CLOSE_V2     = 0x00000010,
    ///Indicates all V2 network interface notifications.
    CLUSTER_CHANGE_NETINTERFACE_ALL_V2              = 0x0000001f,
}

///Defines the notifications that are generated for a cluster network.
alias CLUSTER_CHANGE_NETWORK_V2 = int;
enum : int
{
    ///Indicates that the cluster network has been deleted.
    CLUSTER_CHANGE_NETWORK_DELETED_V2          = 0x00000001,
    ///Indicates that the common properties for the cluster network have changed.
    CLUSTER_CHANGE_NETWORK_COMMON_PROPERTY_V2  = 0x00000002,
    ///Indicates that the private properties for the cluster network have changed.
    CLUSTER_CHANGE_NETWORK_PRIVATE_PROPERTY_V2 = 0x00000004,
    ///Indicates that the cluster network state has changed.
    CLUSTER_CHANGE_NETWORK_STATE_V2            = 0x00000008,
    ///Indicates that the cluster network's context handle was closed.
    CLUSTER_CHANGE_NETWORK_HANDLE_CLOSE_V2     = 0x00000010,
    ///Indicates all V2 cluster network notifications.
    CLUSTER_CHANGE_NETWORK_ALL_V2              = 0x0000001f,
}

///Defines the notifications that are generated for a cluster node.
alias CLUSTER_CHANGE_NODE_V2 = int;
enum : int
{
    ///Indicates that the network interface for the cluster node has been added.
    CLUSTER_CHANGE_NODE_NETINTERFACE_ADDED_V2 = 0x00000001,
    ///Indicates that the cluster node has been deleted.
    CLUSTER_CHANGE_NODE_DELETED_V2            = 0x00000002,
    ///Indicates that the common properties for the cluster node have been changed.
    CLUSTER_CHANGE_NODE_COMMON_PROPERTY_V2    = 0x00000004,
    ///Indicates that the private properties for the cluster node have been changed.
    CLUSTER_CHANGE_NODE_PRIVATE_PROPERTY_V2   = 0x00000008,
    ///Indicates that the state of the cluster node has changed.
    CLUSTER_CHANGE_NODE_STATE_V2              = 0x00000010,
    ///Indicates that the cluster node has gained a group.
    CLUSTER_CHANGE_NODE_GROUP_GAINED_V2       = 0x00000020,
    ///Indicates that the cluster node has lost a group.
    CLUSTER_CHANGE_NODE_GROUP_LOST_V2         = 0x00000040,
    ///Indicates that the cluster node's context handle was closed.
    CLUSTER_CHANGE_NODE_HANDLE_CLOSE_V2       = 0x00000080,
    ///Indicates all V2 cluster node notifications.
    CLUSTER_CHANGE_NODE_ALL_V2                = 0x000000ff,
}

///Defines the notifications that are generated for a registry key.
alias CLUSTER_CHANGE_REGISTRY_V2 = int;
enum : int
{
    ///Indicates that the registry attributes changed.
    CLUSTER_CHANGE_REGISTRY_ATTRIBUTES_V2   = 0x00000001,
    ///Indicates that the registry key name has changed.
    CLUSTER_CHANGE_REGISTRY_NAME_V2         = 0x00000002,
    ///Indicates that the registry subtree has changed.
    CLUSTER_CHANGE_REGISTRY_SUBTREE_V2      = 0x00000004,
    ///Indicates that the registry value has changed.
    CLUSTER_CHANGE_REGISTRY_VALUE_V2        = 0x00000008,
    ///Indicates that the registry's context handle was closed.
    CLUSTER_CHANGE_REGISTRY_HANDLE_CLOSE_V2 = 0x00000010,
    ///Indicates all V2 registry notifications.
    CLUSTER_CHANGE_REGISTRY_ALL_V2          = 0x0000001f,
}

///Defines the notifications that are generated for quorum-specific information.
alias CLUSTER_CHANGE_QUORUM_V2 = int;
enum : int
{
    ///Indicates that the quorum configuration of the cluster has changed.
    CLUSTER_CHANGE_QUORUM_STATE_V2 = 0x00000001,
    ///Indicates all V2 quorum notifications.
    CLUSTER_CHANGE_QUORUM_ALL_V2   = 0x00000001,
}

///Defines the notifications that are generated for a cluster shared volume.
alias CLUSTER_CHANGE_SHARED_VOLUME_V2 = int;
enum : int
{
    ///Indicates that the state of the cluster shared volume has changed.
    CLUSTER_CHANGE_SHARED_VOLUME_STATE_V2   = 0x00000001,
    ///Indicates that the cluster shared volume was added.
    CLUSTER_CHANGE_SHARED_VOLUME_ADDED_V2   = 0x00000002,
    ///Indicates that the cluster shared volume was removed.
    CLUSTER_CHANGE_SHARED_VOLUME_REMOVED_V2 = 0x00000004,
    ///Indicates all V2 cluster shared volume notifications.
    CLUSTER_CHANGE_SHARED_VOLUME_ALL_V2     = 0x00000007,
}

///TBD
alias CLUSTER_CHANGE_SPACEPORT_V2 = int;
enum : int
{
    ///TBD
    CLUSTER_CHANGE_SPACEPORT_CUSTOM_PNP_V2 = 0x00000001,
}

///Defines the notifications that are generated for the upgrade of a cluster node.
alias CLUSTER_CHANGE_NODE_UPGRADE_PHASE_V2 = int;
enum : int
{
    ///Indicates that the upgrade is being prepared.
    CLUSTER_CHANGE_UPGRADE_NODE_PREPARE    = 0x00000001,
    ///Indicates that the upgrade is in progress.
    CLUSTER_CHANGE_UPGRADE_NODE_COMMIT     = 0x00000002,
    ///Indicates that the upgrade is finished.
    CLUSTER_CHANGE_UPGRADE_NODE_POSTCOMMIT = 0x00000004,
    ///Indicates all <b>CLUSTER_CHANGE_NODE_UPGRADE_PHASE_V2</b> notifications.
    CLUSTER_CHANGE_UPGRADE_ALL             = 0x00000007,
}

///Defines the type of object for which a notification is requested or generated.
alias CLUSTER_OBJECT_TYPE = int;
enum : int
{
    ///The notification is for an unspecified type.
    CLUSTER_OBJECT_TYPE_NONE              = 0x00000000,
    ///The notification is for the cluster.
    CLUSTER_OBJECT_TYPE_CLUSTER           = 0x00000001,
    ///The notification is for a group.
    CLUSTER_OBJECT_TYPE_GROUP             = 0x00000002,
    ///The notification is for a resource.
    CLUSTER_OBJECT_TYPE_RESOURCE          = 0x00000003,
    ///The notification is for a resource type.
    CLUSTER_OBJECT_TYPE_RESOURCE_TYPE     = 0x00000004,
    ///The notification is for a cluster network interface.
    CLUSTER_OBJECT_TYPE_NETWORK_INTERFACE = 0x00000005,
    ///The notification is for a cluster network.
    CLUSTER_OBJECT_TYPE_NETWORK           = 0x00000006,
    ///The notification is for a cluster node.
    CLUSTER_OBJECT_TYPE_NODE              = 0x00000007,
    ///The notification is for a cluster registry key.
    CLUSTER_OBJECT_TYPE_REGISTRY          = 0x00000008,
    ///The notification is for a quorum resource.
    CLUSTER_OBJECT_TYPE_QUORUM            = 0x00000009,
    ///The notification is for a cluster shared volume.
    CLUSTER_OBJECT_TYPE_SHARED_VOLUME     = 0x0000000a,
    CLUSTER_OBJECT_TYPE_GROUPSET          = 0x0000000d,
    CLUSTER_OBJECT_TYPE_AFFINITYRULE      = 0x00000010,
}

alias CLUSTERSET_OBJECT_TYPE = int;
enum : int
{
    CLUSTERSET_OBJECT_TYPE_NONE     = 0x00000000,
    CLUSTERSET_OBJECT_TYPE_MEMBER   = 0x00000001,
    CLUSTERSET_OBJECT_TYPE_WORKLOAD = 0x00000002,
    CLUSTERSET_OBJECT_TYPE_DATABASE = 0x00000003,
}

///Describes the type of cluster objects being enumerated. This enumeration is used by the ClusterOpenEnum and
///ClusterEnum functions.
alias CLUSTER_ENUM = int;
enum : int
{
    ///The nodes in the cluster.
    CLUSTER_ENUM_NODE                   = 0x00000001,
    ///The resource types in the cluster.
    CLUSTER_ENUM_RESTYPE                = 0x00000002,
    ///The resources in the cluster.
    CLUSTER_ENUM_RESOURCE               = 0x00000004,
    ///The groups in the cluster.
    CLUSTER_ENUM_GROUP                  = 0x00000008,
    ///The networks in the cluster.
    CLUSTER_ENUM_NETWORK                = 0x00000010,
    ///The network interfaces in the cluster.
    CLUSTER_ENUM_NETINTERFACE           = 0x00000020,
    ///The cluster shared volumes (CSV) in the cluster. <b>Windows Server 2012, Windows Server 2008 R2 and Windows
    ///Server 2008: </b>This value is not supported before Windows Server 2012 R2.
    CLUSTER_ENUM_SHARED_VOLUME_GROUP    = 0x20000000,
    ///The cluster shared volumes in the cluster. <b>Windows Server 2008: </b>This value is not supported before Windows
    ///Server 2008 R2.
    CLUSTER_ENUM_SHARED_VOLUME_RESOURCE = 0x40000000,
    ///The networks used by the cluster for internal communication.
    CLUSTER_ENUM_INTERNAL_NETWORK       = 0x80000000,
    ///All the cluster objects.
    CLUSTER_ENUM_ALL                    = 0x0000003f,
}

///Describes the types of cluster objects that are enumerated by the ClusterNodeEnum and ClusterNodeOpenEnum functions.
alias CLUSTER_NODE_ENUM = int;
enum : int
{
    ///Network interfaces on the node.
    CLUSTER_NODE_ENUM_NETINTERFACES    = 0x00000001,
    ///Cluster groups on the node. <b>Windows Server 2008: </b>This value is not supported before Windows Server 2008
    ///R2.
    CLUSTER_NODE_ENUM_GROUPS           = 0x00000002,
    ///Cluster groups that list this node as their preferred owner. <b>Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This value is supported before Windows Server 2012 R2.
    CLUSTER_NODE_ENUM_PREFERRED_GROUPS = 0x00000004,
    ///Network interfaces on the node, groups on the node, and groups that list the node as their preferred owner..
    CLUSTER_NODE_ENUM_ALL              = 0x00000003,
}

///Describes the state of a cluster node. The GetClusterNodeState and State properties use this enumeration.
alias CLUSTER_NODE_STATE = int;
enum : int
{
    ///The operation was not successful. For more information about the error, call the function GetLastError.
    ClusterNodeStateUnknown = 0xffffffff,
    ///The node is physically plugged in, turned on, booted, and capable of executing programs. This value is also used
    ///by the SetClusterServiceAccountPassword function and Resume method.
    ClusterNodeUp           = 0x00000000,
    ///The node is turned off or not operational.
    ClusterNodeDown         = 0x00000001,
    ///The node is running but not participating in cluster operations. This value is also used by the PauseClusterNode
    ///and SetClusterServiceAccountPassword functions. This value is also used Pause method.
    ClusterNodePaused       = 0x00000002,
    ///The node is in the process of joining a cluster.
    ClusterNodeJoining      = 0x00000003,
}

alias CLUSTER_STORAGENODE_STATE = int;
enum : int
{
    ClusterStorageNodeStateUnknown = 0x00000000,
    ClusterStorageNodeUp           = 0x00000001,
    ClusterStorageNodeDown         = 0x00000002,
    ClusterStorageNodePaused       = 0x00000003,
    ClusterStorageNodeStarting     = 0x00000004,
    ClusterStorageNodeStopping     = 0x00000005,
}

///Enumerates the possible values of the status of a node drain. This enumeration is used in the NodeDrainStatus
///property.
alias CLUSTER_NODE_DRAIN_STATUS = int;
enum : int
{
    ///Indicates that node draining has not started.
    NodeDrainStatusNotInitiated = 0x00000000,
    ///Indicates that node draining is in progress.
    NodeDrainStatusInProgress   = 0x00000001,
    ///Indicates that node draining has been completed.
    NodeDrainStatusCompleted    = 0x00000002,
    ///Indicates that node draining has failed.
    NodeDrainStatusFailed       = 0x00000003,
    ///Defines the maximum number of drain statuses.
    ClusterNodeDrainStatusCount = 0x00000004,
}

///Describes the status of a cluster node. This enumeration is used by the <b>CLUSREG_NAME_NODE_STATUS_INFO</b>
///property.
alias CLUSTER_NODE_STATUS = int;
enum : int
{
    ///The node status is normal.
    NodeStatusNormal          = 0x00000000,
    ///The node has been isolated.
    NodeStatusIsolated        = 0x00000001,
    ///The node has been quarantined.
    NodeStatusQuarantined     = 0x00000002,
    ///The node is in the process of being drained.
    NodeStatusDrainInProgress = 0x00000004,
    ///The node has completed a node drain operation.
    NodeStatusDrainCompleted  = 0x00000008,
    ///A node drain operation failed on the node.
    NodeStatusDrainFailed     = 0x00000010,
    NodeStatusAvoidPlacement  = 0x00000020,
    ///The node has experienced a node drain failure, and is therefore isolated and quarantined.
    NodeStatusMax             = 0x00000033,
}

///Describes the type of cluster object being enumerated by the ClusterGroupEnum and
///[ClusterGroupOpenEnum](../clusapi/nf-clusapi-clustergroupopenenum.md) functions.
alias CLUSTER_GROUP_ENUM = int;
enum : int
{
    ///The resources in the group.
    CLUSTER_GROUP_ENUM_CONTAINS = 0x00000001,
    ///The nodes in the preferred owners list of the group.
    CLUSTER_GROUP_ENUM_NODES    = 0x00000002,
    ///All the resources in the group and all the nodes in the preferred owners list of the group.
    CLUSTER_GROUP_ENUM_ALL      = 0x00000003,
}

///Enumerates the possible states of a group.
alias CLUSTER_GROUP_STATE = int;
enum : int
{
    ///The state of the group is unknown.
    ClusterGroupStateUnknown  = 0xffffffff,
    ///All of the resources in the group are online.
    ClusterGroupOnline        = 0x00000000,
    ///All of the resources in the group are offline or there are no resources in the group.
    ClusterGroupOffline       = 0x00000001,
    ///At least one resource in the group has failed.
    ClusterGroupFailed        = 0x00000002,
    ///At least one resource in the group is online. No resources are pending or failed.
    ClusterGroupPartialOnline = 0x00000003,
    ///At least one resource in the group is in a pending state. There are no failed resources.
    ClusterGroupPending       = 0x00000004,
}

///Specifies the priority level of a group.
alias CLUSTER_GROUP_PRIORITY = int;
enum : int
{
    ///Disabled priority. A group that has a disabled priority does not start automatically.
    PriorityDisabled = 0x00000000,
    ///Low priority.
    PriorityLow      = 0x000003e8,
    ///Medium priority.
    PriorityMedium   = 0x000007d0,
    PriorityHigh     = 0x00000bb8,
}

///Used by the AutoFailbackType group common property to specify whether the group should be failed back to the node
///identified as its preferred owner when that node comes back online following a failover.
alias CLUSTER_GROUP_AUTOFAILBACK_TYPE = int;
enum : int
{
    ///Prevents failback.
    ClusterGroupPreventFailback   = 0x00000000,
    ///Allows failback (requires a preferred owners list for the group).
    ClusterGroupAllowFailback     = 0x00000001,
    ///Defines a maximum group property value. It is not supported by the AutoFailbackType group property.
    ClusterGroupFailbackTypeCount = 0x00000002,
}

///Specifies the failback type to use when a cluster node in a paused state is resumed by the ResumeClusterNodeEx
///function.
alias CLUSTER_NODE_RESUME_FAILBACK_TYPE = int;
enum : int
{
    ///Indicates that the failback process is not to be performed on the specified groups.
    DoNotFailbackGroups                = 0x00000000,
    ///Indicates that the groups is to be failed back to the node.
    FailbackGroupsImmediately          = 0x00000001,
    ///Indicates that the failover policy for each group is to be used.
    FailbackGroupsPerPolicy            = 0x00000002,
    ///Defines the maximum number of failback types.
    ClusterNodeResumeFailbackTypeCount = 0x00000003,
}

///Describes the operational condition of a resource. These values are used by the GetClusterResourceState function, the
///<b>State</b> property of the MSCluster_Resource class, and the State property of the ClusResource object.
alias CLUSTER_RESOURCE_STATE = int;
enum : int
{
    ///The operation was not successful. For more information about the error, call the function GetLastError.
    ClusterResourceStateUnknown   = 0xffffffff,
    ///The resource has been inherited.
    ClusterResourceInherited      = 0x00000000,
    ///The resource is performing initialization.
    ClusterResourceInitializing   = 0x00000001,
    ///The resource is operational and functioning normally.
    ClusterResourceOnline         = 0x00000002,
    ///The resource is not operational.
    ClusterResourceOffline        = 0x00000003,
    ///The resource has failed.
    ClusterResourceFailed         = 0x00000004,
    ///The resource is in the process of coming online or going offline.
    ClusterResourcePending        = 0x00000080,
    ///The resource is in the process of coming online.
    ClusterResourceOnlinePending  = 0x00000081,
    ///The resource is in the process of going offline.
    ClusterResourceOfflinePending = 0x00000082,
}

///Used by the RestartAction resource common property to specify the action to be taken by the cluster service if the
///resource fails.
alias CLUSTER_RESOURCE_RESTART_ACTION = int;
enum : int
{
    ///Do not restart the resource after a failure.
    ClusterResourceDontRestart        = 0x00000000,
    ///Restart the resource after a failure. If the resource exceeds its restart threshold within its restart period, do
    ///not attempt to failover the group to another node in the cluster.
    ClusterResourceRestartNoNotify    = 0x00000001,
    ///Restart the resource after a failure. If the resource exceeds its restart threshold within its restart period,
    ///attempt to fail over the group to another node in the cluster. This is the default setting.
    ClusterResourceRestartNotify      = 0x00000002,
    ///Defines the maximum value of the CLUSTER_RESOURCE_RESTART_ACTION enumeration. It is not a valid value for the
    ///RestartAction property.
    ClusterResourceRestartActionCount = 0x00000003,
}

///Specifies the various actions that can be performed when a resource has an embedded failure.
alias CLUSTER_RESOURCE_EMBEDDED_FAILURE_ACTION = int;
enum : int
{
    ///Indicates that no action is to be taken.
    ClusterResourceEmbeddedFailureActionNone    = 0x00000000,
    ///Indicates that the failure is to be logged.
    ClusterResourceEmbeddedFailureActionLogOnly = 0x00000001,
    ///Indicates that the resource is to be recovered.
    ClusterResourceEmbeddedFailureActionRecover = 0x00000002,
}

///Determines which resource monitor a given resource will be assigned to.
alias CLUSTER_RESOURCE_CREATE_FLAGS = int;
enum : int
{
    ///The Cluster service determines the Resource Monitor to which the new resource will be assigned.
    CLUSTER_RESOURCE_DEFAULT_MONITOR  = 0x00000000,
    ///Causes the Cluster service to create a separate Resource Monitor dedicated exclusively to the new resource.
    CLUSTER_RESOURCE_SEPARATE_MONITOR = 0x00000001,
    ///Contains all valid flags for the CLUSTER_RESOURCE_CREATE_FLAGS enumeration.
    CLUSTER_RESOURCE_VALID_FLAGS      = 0x00000001,
}

///Specifies the various snapshot states for a shared volume.
alias CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE = int;
enum : int
{
    ///Indicates that the snapshot state is unknow.
    ClusterSharedVolumeSnapshotStateUnknown = 0x00000000,
    ///Indicates that the snapshot is being created.
    ClusterSharedVolumePrepareForHWSnapshot = 0x00000001,
    ///Indicates that the snapshot is completed.
    ClusterSharedVolumeHWSnapshotCompleted  = 0x00000002,
    ///TBD
    ClusterSharedVolumePrepareForFreeze     = 0x00000003,
}

///This enumeration defines the property types that are supported by a cluster property list.
alias CLUSTER_PROPERTY_TYPE = int;
enum : int
{
    ///The property type is unknown.
    CLUSPROP_TYPE_UNKNOWN                      = 0xffffffff,
    ///Designates the data value as the last entry in a property or value list.
    CLUSPROP_TYPE_ENDMARK                      = 0x00000000,
    ///Describes a data value in a property list. For example, in the property list passed to a control code function
    ///for a property validation operation, <b>CLUSPROP_TYPE_LIST_VALUE</b> is the required type to be included with
    ///each property value.
    CLUSPROP_TYPE_LIST_VALUE                   = 0x00000001,
    ///Describes resource class information. A resource class value is described with a CLUSPROP_RESOURCE_CLASS
    ///structure. Resource classes are returned when an application calls ClusterResourceControl or
    ///ClusterResourceTypeControl with one of the following control codes: CLUSCTL_RESOURCE_GET_CLASS_INFO
    ///CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES
    CLUSPROP_TYPE_RESCLASS                     = 0x00000002,
    ///Reserved for future use.
    CLUSPROP_TYPE_RESERVED1                    = 0x00000003,
    ///Describes a data value used as a name, such as a property name. A name value is represented by a
    ///CLUSPROP_PROPERTY_NAME structure.
    CLUSPROP_TYPE_NAME                         = 0x00000004,
    ///Describes a Signature property for a disk resource. A signature value is represented by a CLUSPROP_DISK_SIGNATURE
    ///structure.
    CLUSPROP_TYPE_SIGNATURE                    = 0x00000005,
    ///Describes an Address property for an IP Address resource. A SCSI address value is represented by a
    ///CLUSPROP_SCSI_ADDRESS structure.
    CLUSPROP_TYPE_SCSI_ADDRESS                 = 0x00000006,
    ///Describes the number value of a disk resource. A disk number value is represented by a CLUSPROP_DISK_NUMBER
    ///structure.
    CLUSPROP_TYPE_DISK_NUMBER                  = 0x00000007,
    ///Describes a collection of information about a disk resource, such as its device name and volume label. Partition
    ///data is represented by a CLUSPROP_PARTITION_INFO structure.
    CLUSPROP_TYPE_PARTITION_INFO               = 0x00000008,
    ///Describes FILETIME set information. <b>Windows Server 2008 R2 and Windows Server 2008: </b>This enumeration value
    ///is not supported.
    CLUSPROP_TYPE_FTSET_INFO                   = 0x00000009,
    ///Describes the serial number of a disk resource.
    CLUSPROP_TYPE_DISK_SERIALNUMBER            = 0x0000000a,
    ///Describes the <b>GUID</b> of a disk resource.
    CLUSPROP_TYPE_DISK_GUID                    = 0x0000000b,
    ///Describes the total size of a disk in bytes.
    CLUSPROP_TYPE_DISK_SIZE                    = 0x0000000c,
    ///Describes a collection of information about a disk resource, such as its device name and volume label. Partition
    ///data is represented by a CLUSPROP_PARTITION_INFO_EX structure.
    CLUSPROP_TYPE_PARTITION_INFO_EX            = 0x0000000d,
    ///Describes a collection of information about a disk resource, such as its device name and volume label. Partition
    ///data is represented by a CLUSPROP_PARTITION_INFO_EX2 structure. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This value is not available until Windows Server 2016 .
    CLUSPROP_TYPE_PARTITION_INFO_EX2           = 0x0000000e,
    ///Describes descriptor data for a storage class resource. <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This value is not available until Windows Server 2016 .
    CLUSPROP_TYPE_STORAGE_DEVICE_ID_DESCRIPTOR = 0x0000000f,
    ///Describes the beginning of the range for users to define their own types. Associate this type with user-defined
    ///private properties.
    CLUSPROP_TYPE_USER                         = 0x00008000,
}

///Specifies the data type of a property value in a property list.
alias CLUSTER_PROPERTY_FORMAT = int;
enum : int
{
    ///Data is in an unknown format.
    CLUSPROP_FORMAT_UNKNOWN             = 0x00000000,
    ///Data is a binary value.
    CLUSPROP_FORMAT_BINARY              = 0x00000001,
    ///Data is a <b>DWORD</b> value.
    CLUSPROP_FORMAT_DWORD               = 0x00000002,
    ///Data is a null-terminated Unicode string.
    CLUSPROP_FORMAT_SZ                  = 0x00000003,
    ///Data is a null-terminated Unicode string with unexpanded references to environment variables.
    CLUSPROP_FORMAT_EXPAND_SZ           = 0x00000004,
    ///Data is an array of null-terminated Unicode strings.
    CLUSPROP_FORMAT_MULTI_SZ            = 0x00000005,
    ///Data is an <b>ULARGE_INTEGER</b>.
    CLUSPROP_FORMAT_ULARGE_INTEGER      = 0x00000006,
    ///Data is an signed <b>LONG</b> value.
    CLUSPROP_FORMAT_LONG                = 0x00000007,
    ///Data is a null-terminated Unicode string with expanded references to environment variables.
    CLUSPROP_FORMAT_EXPANDED_SZ         = 0x00000008,
    ///Data is a SECURITY_DESCRIPTOR in self-relative format. For more information about self-relative security
    ///descriptors, see Absolute and Self-Relative Security Descriptors.
    CLUSPROP_FORMAT_SECURITY_DESCRIPTOR = 0x00000009,
    ///Data is a signed <b>LARGE_INTEGER</b>.
    CLUSPROP_FORMAT_LARGE_INTEGER       = 0x0000000a,
    ///Data is a <b>WORD</b> value.
    CLUSPROP_FORMAT_WORD                = 0x0000000b,
    ///Data is a FILETIME.
    CLUSPROP_FORMAT_FILETIME            = 0x0000000c,
    CLUSPROP_FORMAT_VALUE_LIST          = 0x0000000d,
    CLUSPROP_FORMAT_PROPERTY_LIST       = 0x0000000e,
    ///Reserved for future use.
    CLUSPROP_FORMAT_USER                = 0x00008000,
}

///Provides the possible values for the syntax structures in a property list.
alias CLUSTER_PROPERTY_SYNTAX = uint;
enum : uint
{
    ///Marks the end of a value list.
    CLUSPROP_SYNTAX_ENDMARK                        = 0x00000000,
    ///Describes a property name, such as the Name property for resources and the NodeName property for nodes. A
    ///property name is represented by a CLUSPROP_PROPERTY_NAME structure.
    CLUSPROP_SYNTAX_NAME                           = 0x00040003,
    ///Describes a resource class value. A resource class value is represented by a CLUSPROP_RESOURCE_CLASS structure.
    CLUSPROP_SYNTAX_RESCLASS                       = 0x00020002,
    ///Describes a null-terminated Unicode string value in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_SZ                  = 0x00010003,
    ///Describes a null-terminated Unicode string value with unexpanded references to environment variables in a
    ///property list.
    CLUSPROP_SYNTAX_LIST_VALUE_EXPAND_SZ           = 0x00010004,
    ///Describes a <b>DWORD</b> value in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_DWORD               = 0x00010002,
    ///Describes a binary value in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_BINARY              = 0x00010001,
    ///Describes an array of null-terminated Unicode string values in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_MULTI_SZ            = 0x00010005,
    ///Describes a signed <b>long</b> value in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_LONG                = 0x00010007,
    ///Describes a null-terminated Unicode string value with expanded references to environment variables in a property
    ///list.
    CLUSPROP_SYNTAX_LIST_VALUE_EXPANDED_SZ         = 0x00010008,
    ///Describes a SECURITY_DESCRIPTOR in self-relative format in a property list. For more information about
    ///self-relative security descriptors, see Absolute and Self-Relative Security Descriptors.
    CLUSPROP_SYNTAX_LIST_VALUE_SECURITY_DESCRIPTOR = 0x00010009,
    ///Describes a signed large integer value in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_LARGE_INTEGER       = 0x0001000a,
    ///Describes an unsigned large integer value in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_ULARGE_INTEGER      = 0x00010006,
    ///Describes a <b>WORD</b> value in a property list.
    CLUSPROP_SYNTAX_LIST_VALUE_WORD                = 0x0001000b,
    ///Describes a property list. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and Windows
    ///Server 2008: </b>This enumeration value is not supported until Windows Server 2016.
    CLUSPROP_SYNTAX_LIST_VALUE_PROPERTY_LIST       = 0x0001000e,
    ///Describes a FILETIME value in a property list. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This enumeration value is not supported until Windows Server 2016.
    CLUSPROP_SYNTAX_LIST_VALUE_FILETIME            = 0x0001000c,
    ///Describes a master boot record (MBR) disk signature value represented by a CLUSPROP_DISK_SIGNATURE structure.
    CLUSPROP_SYNTAX_DISK_SIGNATURE                 = 0x00050002,
    ///Describes the address for an IP Address resource. IP Address resources store this address in their Address
    ///private property. A SCSI address value is represented by a CLUSPROP_SCSI_ADDRESS structure.
    CLUSPROP_SYNTAX_SCSI_ADDRESS                   = 0x00060002,
    ///Describes a disk number value represented by a CLUSPROP_DISK_NUMBER structure.
    CLUSPROP_SYNTAX_DISK_NUMBER                    = 0x00070002,
    ///Describes a collection of information about a Physical Disk resource, such as its device name and volume label.
    ///Partition information is represented by a CLUSPROP_PARTITION_INFO structure.
    CLUSPROP_SYNTAX_PARTITION_INFO                 = 0x00080001,
    ///Describes FILETIME set information.
    CLUSPROP_SYNTAX_FTSET_INFO                     = 0x00090001,
    ///Describes a null-terminated Unicode string value containing a serial number of a disk resource.
    CLUSPROP_SYNTAX_DISK_SERIALNUMBER              = 0x000a0003,
    ///Describes a null-terminated Unicode string value containing the <b>GUID</b> of a <b>GUID</b> partitioning table
    ///(GPT) disk resource.
    CLUSPROP_SYNTAX_DISK_GUID                      = 0x000b0003,
    ///Describes a unsigned large integer value containing the total size of a disk in bytes.
    CLUSPROP_SYNTAX_DISK_SIZE                      = 0x000c0006,
    ///Describes a collection of information about a Physical Disk resource, such as its device name and volume label.
    ///Partition information is represented by a CLUSPROP_PARTITION_INFO_EX structure.
    CLUSPROP_SYNTAX_PARTITION_INFO_EX              = 0x000d0001,
    ///Describes a collection of information about a Physical Disk resource, such as its device name and volume label.
    ///The partition information is represented by a CLUSPROP_PARTITION_INFO_EX2 structure. <b>Windows Server 2012 R2,
    ///Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008: </b>This value is not available until
    ///Windows Server 2016 .
    CLUSPROP_SYNTAX_PARTITION_INFO_EX2             = 0x000e0001,
    ///Describes descriptor data for a storage class resource. <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This value is not available until Windows Server 2016 .
    CLUSPROP_SYNTAX_STORAGE_DEVICE_ID_DESCRIPTOR   = 0x000f0001,
}

///The 8-bit object component of a control code that indicates the type of cluster object to which the control code
///applies. For more information, see Control Code Architecture.
alias CLUSTER_CONTROL_OBJECT = int;
enum : int
{
    ///Zero is not a valid object code value.
    CLUS_OBJECT_INVALID       = 0x00000000,
    ///Object code part of resource control codes that identifies cluster resources as the target.
    CLUS_OBJECT_RESOURCE      = 0x00000001,
    ///Object code part of resource type control codes that identifies cluster resource types as the target.
    CLUS_OBJECT_RESOURCE_TYPE = 0x00000002,
    ///Object code part of group control codes that identifies cluster groups as the target.
    CLUS_OBJECT_GROUP         = 0x00000003,
    ///Object code part of node control codes that identifies cluster nodes as the target.
    CLUS_OBJECT_NODE          = 0x00000004,
    ///Object code part of network control codes that identifies cluster networks as the target.
    CLUS_OBJECT_NETWORK       = 0x00000005,
    ///Object code part of network interface control codes that identifies cluster network interfaces as the target.
    CLUS_OBJECT_NETINTERFACE  = 0x00000006,
    ///Object code part of cluster control codes that identifies a cluster as the target.
    CLUS_OBJECT_CLUSTER       = 0x00000007,
    ///Object code part of cluster control codes that identifies a groupset as the target. <b>Windows Server 2012 R2 and
    ///Windows Server 2012: </b>This constant is not supported prior to Windows Server 2016.
    CLUS_OBJECT_GROUPSET      = 0x00000008,
    CLUS_OBJECT_AFFINITYRULE  = 0x00000009,
    ///Object code part of control codes that identifies cluster object types not defined by Windows Clustering.
    CLUS_OBJECT_USER          = 0x00000080,
}

///This enumeration enumerates the possible operations that a control code will perform. For more information, see
///Control Code Architecture.
alias CLCTL_CODES = int;
enum : int
{
    ///See CLUSCTL_CLUSTER_UNKNOWN, CLUSCTL_GROUP_UNKNOWN, CLUSCTL_NETINTERFACE_UNKNOWN, CLUSCTL_NETWORK_UNKNOWN,
    ///CLUSCTL_NODE_UNKNOWN, CLUSCTL_RESOURCE_TYPE_UNKNOWN, and CLUSCTL_RESOURCE_UNKNOWN.
    CLCTL_UNKNOWN                                                   = 0x00000000,
    ///See CLUSCTL_GROUP_GET_CHARACTERISTICS, CLUSCTL_NETINTERFACE_GET_CHARACTERISTICS,
    ///CLUSCTL_NETWORK_GET_CHARACTERISTICS, CLUSCTL_NODE_GET_CHARACTERISTICS, CLUSCTL_RESOURCE_GET_CHARACTERISTICS, and
    ///CLUSCTL_RESOURCE_TYPE_GET_CHARACTERISTICS.
    CLCTL_GET_CHARACTERISTICS                                       = 0x00000005,
    ///See CLUSCTL_GROUP_GET_FLAGS, CLUSCTL_NETINTERFACE_GET_FLAGS, CLUSCTL_NETWORK_GET_FLAGS, CLUSCTL_NODE_GET_FLAGS,
    ///CLUSCTL_RESOURCE_GET_FLAGS, and CLUSCTL_RESOURCE_TYPE_GET_FLAGS.
    CLCTL_GET_FLAGS                                                 = 0x00000009,
    ///See CLUSCTL_RESOURCE_GET_CLASS_INFO and CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO.
    CLCTL_GET_CLASS_INFO                                            = 0x0000000d,
    ///See CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES and CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES.
    CLCTL_GET_REQUIRED_DEPENDENCIES                                 = 0x00000011,
    ///See CLUSCTL_RESOURCE_TYPE_GET_ARB_TIMEOUT.
    CLCTL_GET_ARB_TIMEOUT                                           = 0x00000015,
    ///See CLUSCTL_RESOURCE_GET_FAILURE_INFO.
    CLCTL_GET_FAILURE_INFO                                          = 0x00000019,
    ///See CLUSCTL_GROUP_GET_NAME, CLUSCTL_NETINTERFACE_GET_NAME, CLUSCTL_NETWORK_GET_NAME, CLUSCTL_NODE_GET_NAME, and
    ///CLUSCTL_RESOURCE_GET_NAME.
    CLCTL_GET_NAME                                                  = 0x00000029,
    ///See CLUSCTL_RESOURCE_GET_RESOURCE_TYPE.
    CLCTL_GET_RESOURCE_TYPE                                         = 0x0000002d,
    ///See CLUSCTL_NETINTERFACE_GET_NODE.
    CLCTL_GET_NODE                                                  = 0x00000031,
    ///See CLUSCTL_NETINTERFACE_GET_NETWORK.
    CLCTL_GET_NETWORK                                               = 0x00000035,
    ///See CLUSCTL_GROUP_GET_ID, CLUSCTL_NETINTERFACE_GET_ID, CLUSCTL_NETWORK_GET_ID, CLUSCTL_NODE_GET_ID, and
    ///CLUSCTL_RESOURCE_GET_ID.
    CLCTL_GET_ID                                                    = 0x00000039,
    ///See CLUSCTL_CLUSTER_GET_FQDN.
    CLCTL_GET_FQDN                                                  = 0x0000003d,
    ///See CLUSCTL_NODE_GET_CLUSTER_SERVICE_ACCOUNT_NAME.
    CLCTL_GET_CLUSTER_SERVICE_ACCOUNT_NAME                          = 0x00000041,
    ///See CLUSCTL_CLUSTER_CHECK_VOTER_EVICT.
    CLCTL_CHECK_VOTER_EVICT                                         = 0x00000045,
    ///See CLUSCTL_CLUSTER_CHECK_VOTER_DOWN.
    CLCTL_CHECK_VOTER_DOWN                                          = 0x00000049,
    ///See CLUSCTL_CLUSTER_SHUTDOWN.
    CLCTL_SHUTDOWN                                                  = 0x0000004d,
    ///See CLUSCTL_CLUSTER_ENUM_COMMON_PROPERTIES, CLUSCTL_GROUP_ENUM_COMMON_PROPERTIES,
    ///CLUSCTL_NETINTERFACE_ENUM_COMMON_PROPERTIES, CLUSCTL_NETWORK_ENUM_COMMON_PROPERTIES,
    ///CLUSCTL_NODE_ENUM_COMMON_PROPERTIES, CLUSCTL_RESOURCE_ENUM_COMMON_PROPERTIES, and
    ///CLUSCTL_RESOURCE_TYPE_ENUM_COMMON_PROPERTIES.
    CLCTL_ENUM_COMMON_PROPERTIES                                    = 0x00000051,
    ///See CLUSCTL_CLUSTER_GET_RO_COMMON_PROPERTIES, CLUSCTL_COLLECTION_GET_RO_COMMON_PROPERTIES,
    ///CLUSCTL_GROUP_GET_RO_COMMON_PROPERTIES, CLUSCTL_NETINTERFACE_GET_RO_COMMON_PROPERTIES,
    ///CLUSCTL_NETWORK_GET_RO_COMMON_PROPERTIES, CLUSCTL_NODE_GET_RO_COMMON_PROPERTIES,
    ///CLUSCTL_RESOURCE_GET_RO_COMMON_PROPERTIES, and CLUSCTL_RESOURCE_TYPE_GET_RO_COMMON_PROPERTIES.
    CLCTL_GET_RO_COMMON_PROPERTIES                                  = 0x00000055,
    ///See CLUSCTL_CLUSTER_GET_COMMON_PROPERTIES, CLUSCTL_COLLECTION_GET_COMMON_PROPERTIES,
    ///CLUSCTL_GROUP_GET_COMMON_PROPERTIES, CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTIES,
    ///CLUSCTL_NETWORK_GET_COMMON_PROPERTIES, CLUSCTL_NODE_GET_COMMON_PROPERTIES,
    ///CLUSCTL_RESOURCE_GET_COMMON_PROPERTIES, and CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTIES.
    CLCTL_GET_COMMON_PROPERTIES                                     = 0x00000059,
    ///See CLUSCTL_CLUSTER_SET_COMMON_PROPERTIES, CLUSCTL_COLLECTION_SET_COMMON_PROPERTIES,
    ///CLUSCTL_GROUP_SET_COMMON_PROPERTIES, CLUSCTL_NETINTERFACE_SET_COMMON_PROPERTIES,
    ///CLUSCTL_NETWORK_SET_COMMON_PROPERTIES, CLUSCTL_NODE_SET_COMMON_PROPERTIES,
    ///CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES, and CLUSCTL_RESOURCE_TYPE_SET_COMMON_PROPERTIES.
    CLCTL_SET_COMMON_PROPERTIES                                     = 0x0040005e,
    ///See CLUSCTL_CLUSTER_VALIDATE_COMMON_PROPERTIES, CLUSCTL_GROUP_VALIDATE_COMMON_PROPERTIES,
    ///CLUSCTL_NETINTERFACE_VALIDATE_COMMON_PROPERTIES, CLUSCTL_NETWORK_VALIDATE_COMMON_PROPERTIES,
    ///CLUSCTL_NODE_VALIDATE_COMMON_PROPERTIES, CLUSCTL_RESOURCE_TYPE_VALIDATE_COMMON_PROPERTIES, and
    ///CLUSCTL_RESOURCE_VALIDATE_COMMON_PROPERTIES.
    CLCTL_VALIDATE_COMMON_PROPERTIES                                = 0x00000061,
    ///See CLUSCTL_CLUSTER_GET_COMMON_PROPERTY_FMTS, CLUSCTL_GROUP_GET_COMMON_PROPERTY_FMTS,
    ///CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTY_FMTS, CLUSCTL_NETWORK_GET_COMMON_PROPERTY_FMTS,
    ///CLUSCTL_NODE_GET_COMMON_PROPERTY_FMTS, CLUSCTL_RESOURCE_GET_COMMON_PROPERTY_FMTS, and
    ///CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTY_FMTS.
    CLCTL_GET_COMMON_PROPERTY_FMTS                                  = 0x00000065,
    ///See CLUSCTL_RESOURCE_TYPE_GET_COMMON_RESOURCE_PROPERTY_FMTS.
    CLCTL_GET_COMMON_RESOURCE_PROPERTY_FMTS                         = 0x00000069,
    ///See CLUSCTL_CLUSTER_ENUM_PRIVATE_PROPERTIES, CLUSCTL_GROUP_ENUM_PRIVATE_PROPERTIES,
    ///CLUSCTL_NETINTERFACE_ENUM_PRIVATE_PROPERTIES, CLUSCTL_NETWORK_ENUM_PRIVATE_PROPERTIES,
    ///CLUSCTL_NODE_ENUM_PRIVATE_PROPERTIES, CLUSCTL_RESOURCE_ENUM_PRIVATE_PROPERTIES, and
    ///CLUSCTL_RESOURCE_TYPE_ENUM_PRIVATE_PROPERTIES.
    CLCTL_ENUM_PRIVATE_PROPERTIES                                   = 0x00000079,
    ///see CLUSCTL_CLUSTER_GET_RO_PRIVATE_PROPERTIES, CLUSCTL_GROUP_GET_RO_PRIVATE_PROPERTIES,
    ///CLUSCTL_NETINTERFACE_GET_RO_PRIVATE_PROPERTIES, CLUSCTL_NETWORK_GET_RO_PRIVATE_PROPERTIES,
    ///CLUSCTL_NODE_GET_RO_PRIVATE_PROPERTIES, CLUSCTL_RESOURCE_GET_RO_PRIVATE_PROPERTIES, and
    ///CLUSCTL_RESOURCE_TYPE_GET_RO_PRIVATE_PROPERTIES.
    CLCTL_GET_RO_PRIVATE_PROPERTIES                                 = 0x0000007d,
    ///See CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTIES, CLUSCTL_GROUP_GET_PRIVATE_PROPERTIES,
    ///CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTIES, CLUSCTL_NETWORK_GET_PRIVATE_PROPERTIES,
    ///CLUSCTL_NODE_GET_PRIVATE_PROPERTIES, CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTIES, and
    ///CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTIES.
    CLCTL_GET_PRIVATE_PROPERTIES                                    = 0x00000081,
    ///See CLUSCTL_CLUSTER_SET_PRIVATE_PROPERTIES, CLUSCTL_GROUP_SET_PRIVATE_PROPERTIES,
    ///CLUSCTL_NETINTERFACE_SET_PRIVATE_PROPERTIES, CLUSCTL_NETWORK_SET_PRIVATE_PROPERTIES,
    ///CLUSCTL_NODE_SET_PRIVATE_PROPERTIES, CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES, and
    ///CLUSCTL_RESOURCE_TYPE_SET_PRIVATE_PROPERTIES.
    CLCTL_SET_PRIVATE_PROPERTIES                                    = 0x00400086,
    ///See CLUSCTL_CLUSTER_VALIDATE_PRIVATE_PROPERTIES, CLUSCTL_GROUP_VALIDATE_PRIVATE_PROPERTIES,
    ///CLUSCTL_NETINTERFACE_VALIDATE_PRIVATE_PROPERTIES, CLUSCTL_NETWORK_VALIDATE_PRIVATE_PROPERTIES,
    ///CLUSCTL_NODE_VALIDATE_PRIVATE_PROPERTIES, CLUSCTL_RESOURCE_TYPE_VALIDATE_PRIVATE_PROPERTIES, and
    ///CLUSCTL_RESOURCE_VALIDATE_PRIVATE_PROPERTIES.
    CLCTL_VALIDATE_PRIVATE_PROPERTIES                               = 0x00000089,
    ///See CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTY_FMTS, CLUSCTL_GROUP_GET_PRIVATE_PROPERTY_FMTS,
    ///CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTY_FMTS, CLUSCTL_NETWORK_GET_PRIVATE_PROPERTY_FMTS,
    ///CLUSCTL_NODE_GET_PRIVATE_PROPERTY_FMTS, CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTY_FMTS, and
    ///CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTY_FMTS.
    CLCTL_GET_PRIVATE_PROPERTY_FMTS                                 = 0x0000008d,
    ///See CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_RESOURCE_PROPERTY_FMTS.
    CLCTL_GET_PRIVATE_RESOURCE_PROPERTY_FMTS                        = 0x00000091,
    ///See CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT.
    CLCTL_ADD_REGISTRY_CHECKPOINT                                   = 0x004000a2,
    ///See CLUSCTL_RESOURCE_DELETE_REGISTRY_CHECKPOINT.
    CLCTL_DELETE_REGISTRY_CHECKPOINT                                = 0x004000a6,
    ///See CLUSCTL_RESOURCE_GET_REGISTRY_CHECKPOINTS.
    CLCTL_GET_REGISTRY_CHECKPOINTS                                  = 0x000000a9,
    ///See CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT.
    CLCTL_ADD_CRYPTO_CHECKPOINT                                     = 0x004000ae,
    ///See CLUSCTL_RESOURCE_DELETE_CRYPTO_CHECKPOINT.
    CLCTL_DELETE_CRYPTO_CHECKPOINT                                  = 0x004000b2,
    ///See CLUSCTL_RESOURCE_GET_CRYPTO_CHECKPOINTS.
    CLCTL_GET_CRYPTO_CHECKPOINTS                                    = 0x000000b5,
    ///See CLUSCTL_RESOURCE_UPGRADE_DLL.
    CLCTL_RESOURCE_UPGRADE_DLL                                      = 0x004000ba,
    ///See CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_64BIT.
    CLCTL_ADD_REGISTRY_CHECKPOINT_64BIT                             = 0x004000be,
    ///See CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_32BIT.
    CLCTL_ADD_REGISTRY_CHECKPOINT_32BIT                             = 0x004000c2,
    ///See CLUSCTL_RESOURCE_GET_LOADBAL_PROCESS_LIST.
    CLCTL_GET_LOADBAL_PROCESS_LIST                                  = 0x000000c9,
    ///See CLUSCTL_CLUSTER_SET_ACCOUNT_ACCESS <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_SET_ACCOUNT_ACCESS                                        = 0x004000f2,
    ///See CLUSCTL_RESOURCE_GET_NETWORK_NAME.
    CLCTL_GET_NETWORK_NAME                                          = 0x00000169,
    ///See the following topics: <ul> <li> CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN </li> <li>
    ///CLUSCTL_RESOURCE_RLUA_GET_VIRTUAL_SERVER_TOKEN </li> </ul> <b>Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available until Windows Server 2012 R2. See
    ///CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN.
    CLCTL_NETNAME_GET_VIRTUAL_SERVER_TOKEN                          = 0x0000016d,
    ///See CLUSCTL_RESOURCE_NETNAME_REGISTER_DNS_RECORDS.
    CLCTL_NETNAME_REGISTER_DNS_RECORDS                              = 0x00000172,
    ///See CLUSCTL_RESOURCE_GET_DNS_NAME.
    CLCTL_GET_DNS_NAME                                              = 0x00000175,
    ///See the following topics: <ul> <li> CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFO </li> <li>
    ///CLUSCTL_RESOURCE_RLUA_SET_PWD_INFO </li> </ul> <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server
    ///2008: </b>This control code is not available until Windows Server 2012 R2.
    CLCTL_NETNAME_SET_PWD_INFO                                      = 0x0000017a,
    ///See CLUSCTL_RESOURCE_NETNAME_DELETE_CO.
    CLCTL_NETNAME_DELETE_CO                                         = 0x0000017e,
    ///See CLUSCTL_RESOURCE_NETNAME_VALIDATE_VCO.
    CLCTL_NETNAME_VALIDATE_VCO                                      = 0x00000181,
    ///See CLUSCTL_RESOURCE_NETNAME_RESET_VCO.
    CLCTL_NETNAME_RESET_VCO                                         = 0x00000185,
    ///See CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO
    CLCTL_NETNAME_REPAIR_VCO                                        = 0x0000018d,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO.
    CLCTL_STORAGE_GET_DISK_INFO                                     = 0x00000191,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS.
    CLCTL_STORAGE_GET_AVAILABLE_DISKS                               = 0x00000195,
    ///See CLUSCTL_RESOURCE_STORAGE_IS_PATH_VALID.
    CLCTL_STORAGE_IS_PATH_VALID                                     = 0x00000199,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_SYNC_CLUSDISK_DB.
    CLCTL_STORAGE_SYNC_CLUSDISK_DB                                  = 0x0040019e,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_NUMBER_INFO. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_STORAGE_GET_DISK_NUMBER_INFO                              = 0x000001a1,
    ///See CLUSCTL_GROUP_QUERY_DELETE, CLUSCTL_RESOURCE_QUERY_DELETE, and CLUSCTL_RESOURCE_TYPE_QUERY_DELETE.
    CLCTL_QUERY_DELETE                                              = 0x000001b9,
    ///See CLUSCTL_RESOURCE_IPADDRESS_RENEW_LEASE.
    CLCTL_IPADDRESS_RENEW_LEASE                                     = 0x004001be,
    ///See CLUSCTL_RESOURCE_IPADDRESS_RELEASE_LEASE.
    CLCTL_IPADDRESS_RELEASE_LEASE                                   = 0x004001c2,
    ///See CLUSCTL_RESOURCE_QUERY_MAINTENANCE_MODE.
    CLCTL_QUERY_MAINTENANCE_MODE                                    = 0x000001e1,
    ///See CLUSCTL_RESOURCE_SET_MAINTENANCE_MODE.
    CLCTL_SET_MAINTENANCE_MODE                                      = 0x004001e6,
    ///See CLUSCTL_RESOURCE_STORAGE_SET_DRIVELETTER.
    CLCTL_STORAGE_SET_DRIVELETTER                                   = 0x004001ea,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DRIVELETTERS.
    CLCTL_STORAGE_GET_DRIVELETTERS                                  = 0x000001ed,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX.
    CLCTL_STORAGE_GET_DISK_INFO_EX                                  = 0x000001f1,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX.
    CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX                            = 0x000001f5,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX2. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_STORAGE_GET_DISK_INFO_EX2                                 = 0x000001f9,
    ///TBD
    CLCTL_STORAGE_GET_CLUSPORT_DISK_COUNT                           = 0x000001fd,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_REMAP_DRIVELETTER.
    CLCTL_STORAGE_REMAP_DRIVELETTER                                 = 0x00000201,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DISKID.
    CLCTL_STORAGE_GET_DISKID                                        = 0x00000205,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CLUSTERABLE.
    CLCTL_STORAGE_IS_CLUSTERABLE                                    = 0x00000209,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_REMOVE_VM_OWNERSHIP.
    CLCTL_STORAGE_REMOVE_VM_OWNERSHIP                               = 0x0040020e,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_MOUNTPOINTS.
    CLCTL_STORAGE_GET_MOUNTPOINTS                                   = 0x00000211,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DIRTY.
    CLCTL_STORAGE_GET_DIRTY                                         = 0x00000219,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_INFO.
    CLCTL_STORAGE_GET_SHARED_VOLUME_INFO                            = 0x00000225,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CSV_FILE.
    CLCTL_STORAGE_IS_CSV_FILE                                       = 0x00000229,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_RESOURCEID.
    CLCTL_STORAGE_GET_RESOURCEID                                    = 0x0000022d,
    ///See CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_PATH and CLUSCTL_RESOURCE_TYPE_GEN_SCRIPT_VALIDATE_PATH.
    CLCTL_VALIDATE_PATH                                             = 0x00000231,
    ///See CLUSCTL_RESOURCE_TYPE_NETNAME_VALIDATE_NETNAME.
    CLCTL_VALIDATE_NETNAME                                          = 0x00000235,
    ///See CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_DIRECTORY.
    CLCTL_VALIDATE_DIRECTORY                                        = 0x00000239,
    ///Not supported.
    CLCTL_BATCH_BLOCK_KEY                                           = 0x0000023e,
    ///Not supported.
    CLCTL_BATCH_UNBLOCK_KEY                                         = 0x00000241,
    ///See CLUSCTL_RESOURCE_FILESERVER_SHARE_ADD.
    CLCTL_FILESERVER_SHARE_ADD                                      = 0x00400246,
    ///See CLUSCTL_RESOURCE_FILESERVER_SHARE_DEL.
    CLCTL_FILESERVER_SHARE_DEL                                      = 0x0040024a,
    ///See CLUSCTL_RESOURCE_FILESERVER_SHARE_MODIFY.
    CLCTL_FILESERVER_SHARE_MODIFY                                   = 0x0040024e,
    ///See CLUSCTL_RESOURCE_FILESERVER_SHARE_REPORT.
    CLCTL_FILESERVER_SHARE_REPORT                                   = 0x00000251,
    ///See CLUSCTL_RESOURCE_TYPE_NETNAME_GET_OU_FOR_VCO.
    CLCTL_NETNAME_GET_OU_FOR_VCO                                    = 0x0040026e,
    ///See CLUSCTL_RESOURCE_ENABLE_SHARED_VOLUME_DIRECTIO.
    CLCTL_ENABLE_SHARED_VOLUME_DIRECTIO                             = 0x0040028a,
    ///See CLUSCTL_RESOURCE_DISABLE_SHARED_VOLUME_DIRECTIO.
    CLCTL_DISABLE_SHARED_VOLUME_DIRECTIO                            = 0x0040028e,
    ///See CLUSCTL_CLUSTER_GET_SHARED_VOLUME_ID.
    CLCTL_GET_SHARED_VOLUME_ID                                      = 0x00000291,
    ///See CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE.
    CLCTL_SET_CSV_MAINTENANCE_MODE                                  = 0x00400296,
    ///See CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE.
    CLCTL_SET_SHARED_VOLUME_BACKUP_MODE                             = 0x0040029a,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES.
    CLCTL_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES                 = 0x0000029d,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_STATES.
    CLCTL_STORAGE_GET_SHARED_VOLUME_STATES                          = 0x004002a2,
    ///See CLUSCTL_RESOURCE_STORAGE_IS_SHARED_VOLUME.
    CLCTL_STORAGE_IS_SHARED_VOLUME                                  = 0x000002a5,
    ///See CLUSCTL_CLUSTER_GET_CLUSDB_TIMESTAMP.
    CLCTL_GET_CLUSDB_TIMESTAMP                                      = 0x000002a9,
    ///See CLUSCTL_RESOURCE_RW_MODIFY_NOOP
    CLCTL_RW_MODIFY_NOOP                                            = 0x004002ae,
    ///See CLUSCTL_RESOURCE_IS_QUORUM_BLOCKED.
    CLCTL_IS_QUORUM_BLOCKED                                         = 0x000002b1,
    ///See CLUSCTL_RESOURCE_POOL_GET_DRIVE_INFO.
    CLCTL_POOL_GET_DRIVE_INFO                                       = 0x000002b5,
    ///See CLUSCTL_CLUSTER_GET_GUM_LOCK_OWNER. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This operation code is not available until Windows Server 2012 R2.
    CLCTL_GET_GUM_LOCK_OWNER                                        = 0x000002b9,
    ///See CLUSCTL_NODE_GET_STUCK_NODES. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This operation code is not available until Windows Server 2012 R2.
    CLCTL_GET_STUCK_NODES                                           = 0x000002bd,
    ///See CLUSCTL_NODE_INJECT_GEM_FAULT. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This operation code is not available until Windows Server 2012 R2.
    CLCTL_INJECT_GEM_FAULT                                          = 0x000002c1,
    ///See CLUSCTL_NODE_INTRODUCE_GEM_REPAIR_DELAY. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server
    ///2008: </b>This operation code is not available until Windows Server 2012 R2.
    CLCTL_INTRODUCE_GEM_REPAIR_DELAY                                = 0x000002c5,
    ///See CLUSCTL_NODE_SEND_DUMMY_GEM_MESSAGES. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This operation code is not available until Windows Server 2012 R2.
    CLCTL_SEND_DUMMY_GEM_MESSAGES                                   = 0x000002c9,
    ///See CLUSCTL_NODE_BLOCK_GEM_SEND_RECV. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This operation code is not available before Windows Server 2012 R2.
    CLCTL_BLOCK_GEM_SEND_RECV                                       = 0x000002cd,
    ///See CLUSCTL_NODE_GET_GEMID_VECTOR. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This operation code is not available before Windows Server 2012 R2.
    CLCTL_GET_GEMID_VECTOR                                          = 0x000002d1,
    ///See CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT_EX. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server
    ///2008: </b>This operation code is not available before Windows Server 2012 R2.
    CLCTL_ADD_CRYPTO_CHECKPOINT_EX                                  = 0x004002d6,
    ///See CLUSCTL_GROUP_GET_LAST_MOVE_TIME. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_GROUP_GET_LAST_MOVE_TIME                                  = 0x000002d9,
    ///See CLUSCTL_CLUSTER_SET_STORAGE_CONFIGURATION. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_SET_STORAGE_CONFIGURATION                                 = 0x004002e2,
    ///See CLUSCTL_CLUSTER_GET_STORAGE_CONFIGURATION. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_GET_STORAGE_CONFIGURATION                                 = 0x000002e5,
    ///See CLUSCTL_CLUSTER_GET_STORAGE_CONFIG_ATTRIBUTES. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_GET_STORAGE_CONFIG_ATTRIBUTES                             = 0x000002e9,
    ///See CLUSCTL_CLUSTER_REMOVE_NODE. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_REMOVE_NODE                                               = 0x004002ee,
    CLCTL_IS_FEATURE_INSTALLED                                      = 0x000002f1,
    CLCTL_IS_S2D_FEATURE_SUPPORTED                                  = 0x000002f5,
    CLCTL_STORAGE_GET_PHYSICAL_DISK_INFO                            = 0x000002f9,
    CLCTL_STORAGE_GET_CLUSBFLT_PATHS                                = 0x000002fd,
    CLCTL_STORAGE_GET_CLUSBFLT_PATHINFO                             = 0x00000301,
    ///See CLUSCTL_CLUSTER_CLEAR_NODE_CONNECTION_INFO. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_CLEAR_NODE_CONNECTION_INFO                                = 0x00400306,
    ///See CLUSCTL_CLUSTER_SET_DNS_DOMAIN. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_SET_DNS_DOMAIN                                            = 0x0040030a,
    CTCTL_GET_ROUTESTATUS_BASIC                                     = 0x0000030d,
    CTCTL_GET_ROUTESTATUS_EXTENDED                                  = 0x00000311,
    CTCTL_GET_FAULT_DOMAIN_STATE                                    = 0x00000315,
    CLCTL_NETNAME_SET_PWD_INFOEX                                    = 0x0000031a,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INT. <b>Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available before Windows Server 2012 R2.
    CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX2_INT                       = 0x00001fe1,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server
    ///2016.
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS          = 0x000020e1,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN                       = 0x004020e6,
    ///See CLUSCTL_RESOURCE_PREPARE_UPGRADE and CLUSCTL_RESOURCE_TYPE_PREPARE_UPGRADE. <b>Windows Server 2012 R2,
    ///Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available
    ///until Windows Server 2016.
    CLCTL_RESOURCE_PREPARE_UPGRADE                                  = 0x004020ea,
    ///See CLUSCTL_RESOURCE_UPGRADE_COMPLETED and CLUSCTL_RESOURCE_TYPE_UPGRADE_COMPLETED. <b>Windows Server 2012 R2,
    ///Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available
    ///until Windows Server 2016.
    CLCTL_RESOURCE_UPGRADE_COMPLETED                                = 0x004020ee,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY. <b>Windows Server 2012 R2, Windows Server
    ///2012, Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows
    ///Server 2016.
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 0x000020f1,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY                         = 0x004020f6,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_INFO. <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_REPLICATION_GET_LOG_INFO                                  = 0x00002145,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_LOGDISKS <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_REPLICATION_GET_ELIGIBLE_LOGDISKS                         = 0x00002149,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server
    ///2016.
    CLCTL_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS                 = 0x0000214d,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server
    ///2016.
    CLCTL_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS                 = 0x00002151,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_DISKS <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_REPLICATION_GET_REPLICATED_DISKS                          = 0x00002155,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICA_VOLUMES <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_REPLICATION_GET_REPLICA_VOLUMES                           = 0x00002159,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_VOLUME <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_REPLICATION_GET_LOG_VOLUME                                = 0x0000215d,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_RESOURCE_GROUP <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_REPLICATION_GET_RESOURCE_GROUP                            = 0x00002161,
    ///CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_PARTITION_INFO <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server
    ///2016.
    CLCTL_REPLICATION_GET_REPLICATED_PARTITION_INFO                 = 0x00002165,
    ///See CLUSCTL_RESOURCE_GET_STATE_CHANGE_TIME. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_GET_STATE_CHANGE_TIME                                     = 0x00002d5d,
    ///See CLUSCTL_CLUSTER_SET_CLUSTER_S2D_ENABLED. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_SET_CLUSTER_S2D_ENABLED                                   = 0x00402d62,
    ///See CLUSCTL_CLUSTER_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available until Windows Server
    ///2016.
    CLCTL_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES              = 0x00402d6e,
    ///See CLUSCTL_GROUPSET_GET_GROUPS. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_GROUPSET_GET_GROUPS                                       = 0x00002d71,
    ///See CLUSCTL_GROUPSET_GET_PROVIDER_GROUPS. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_GROUPSET_GET_PROVIDER_GROUPS                              = 0x00002d75,
    ///See CLUSCTL_GROUPSET_GET_PROVIDER_GROUPSETS. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_GROUPSET_GET_PROVIDER_GROUPSETS                           = 0x00002d79,
    ///See CLUSCTL_GROUP_GET_PROVIDER_GROUPS. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_GROUP_GET_PROVIDER_GROUPS                                 = 0x00002d7d,
    ///See CLUSCTL_GROUP_GET_PROVIDER_GROUPSETS. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This operation code is not available until Windows Server 2016.
    CLCTL_GROUP_GET_PROVIDER_GROUPSETS                              = 0x00002d81,
    CLCTL_GROUP_SET_CCF_FROM_MASTER                                 = 0x00402d86,
    CLCTL_GET_INFRASTRUCTURE_SOFS_BUFFER                            = 0x00002d89,
    CLCTL_SET_INFRASTRUCTURE_SOFS_BUFFER                            = 0x00402d8e,
    CLCTL_NOTIFY_INFRASTRUCTURE_SOFS_CHANGED                        = 0x00402d92,
    CLCTL_SCALEOUT_COMMAND                                          = 0x00402d96,
    CLCTL_SCALEOUT_CONTROL                                          = 0x00402d9a,
    CLCTL_SCALEOUT_GET_CLUSTERS                                     = 0x00402d9d,
    CLCTL_RELOAD_AUTOLOGGER_CONFIG                                  = 0x00002dd2,
    CLCTL_STORAGE_RENAME_SHARED_VOLUME                              = 0x00002dd6,
    CLCTL_STORAGE_RENAME_SHARED_VOLUME_GUID                         = 0x00002dda,
    CLCTL_ENUM_AFFINITY_RULE_NAMES                                  = 0x00002ddd,
    ///See CLUSCTL_RESOURCE_DELETE.
    CLCTL_DELETE                                                    = 0x00500006,
    ///See CLUSCTL_RESOURCE_INSTALL_NODE and CLUSCTL_RESOURCE_TYPE_INSTALL_NODE.
    CLCTL_INSTALL_NODE                                              = 0x0050000a,
    ///See CLUSCTL_RESOURCE_EVICT_NODE and CLUSCTL_RESOURCE_TYPE_EVICT_NODE.
    CLCTL_EVICT_NODE                                                = 0x0050000e,
    ///See CLUSCTL_RESOURCE_ADD_DEPENDENCY.
    CLCTL_ADD_DEPENDENCY                                            = 0x00500012,
    ///See CLUSCTL_RESOURCE_REMOVE_DEPENDENCY.
    CLCTL_REMOVE_DEPENDENCY                                         = 0x00500016,
    ///See CLUSCTL_RESOURCE_ADD_OWNER.
    CLCTL_ADD_OWNER                                                 = 0x0050001a,
    ///See CLUSCTL_RESOURCE_REMOVE_OWNER.
    CLCTL_REMOVE_OWNER                                              = 0x0050001e,
    ///See CLUSCTL_RESOURCE_SET_NAME.
    CLCTL_SET_NAME                                                  = 0x00500026,
    ///See CLUSCTL_RESOURCE_CLUSTER_NAME_CHANGED.
    CLCTL_CLUSTER_NAME_CHANGED                                      = 0x0050002a,
    ///See CLUSCTL_RESOURCE_CLUSTER_VERSION_CHANGED and CLUSCTL_RESOURCE_TYPE_CLUSTER_VERSION_CHANGED.
    CLCTL_CLUSTER_VERSION_CHANGED                                   = 0x0050002e,
    ///See CLUSCTL_RESOURCE_TYPE_FIXUP_ON_UPGRADE.
    CLCTL_FIXUP_ON_UPGRADE                                          = 0x00500032,
    ///See CLUSCTL_RESOURCE_TYPE_STARTING_PHASE1.
    CLCTL_STARTING_PHASE1                                           = 0x00500036,
    ///See CLUSCTL_RESOURCE_TYPE_STARTING_PHASE2.
    CLCTL_STARTING_PHASE2                                           = 0x0050003a,
    ///See CLUSCTL_RESOURCE_TYPE_HOLD_IO.
    CLCTL_HOLD_IO                                                   = 0x0050003e,
    ///See CLUSCTL_RESOURCE_TYPE_RESUME_IO.
    CLCTL_RESUME_IO                                                 = 0x00500042,
    ///See CLUSCTL_RESOURCE_FORCE_QUORUM.
    CLCTL_FORCE_QUORUM                                              = 0x00500046,
    ///See CLUSCTL_RESOURCE_INITIALIZE.
    CLCTL_INITIALIZE                                                = 0x0050004a,
    ///See CLUSCTL_RESOURCE_STATE_CHANGE_REASON.
    CLCTL_STATE_CHANGE_REASON                                       = 0x0050004e,
    ///See CLUSCTL_RESOURCE_PROVIDER_STATE_CHANGE.
    CLCTL_PROVIDER_STATE_CHANGE                                     = 0x00500052,
    ///See CLUSCTL_RESOURCE_LEAVING_GROUP.
    CLCTL_LEAVING_GROUP                                             = 0x00500056,
    ///See CLUSCTL_RESOURCE_JOINING_GROUP.
    CLCTL_JOINING_GROUP                                             = 0x0050005a,
    ///See CLUSCTL_RESOURCE_FSWITNESS_GET_EPOCH_INFO.
    CLCTL_FSWITNESS_GET_EPOCH_INFO                                  = 0x0010005d,
    ///See CLUSCTL_RESOURCE_FSWITNESS_SET_EPOCH_INFO.
    CLCTL_FSWITNESS_SET_EPOCH_INFO                                  = 0x00500062,
    ///See CLUSCTL_RESOURCE_FSWITNESS_RELEASE_LOCK.
    CLCTL_FSWITNESS_RELEASE_LOCK                                    = 0x00500066,
    ///See CLUSCTL_RESOURCE_NETNAME_CREDS_NOTIFYCAM.
    CLCTL_NETNAME_CREDS_NOTIFYCAM                                   = 0x0050006a,
    ///See CLUSCTL_RESOURCE_NOTIFY_QUORUM_STATUS.
    CLCTL_NOTIFY_QUORUM_STATUS                                      = 0x0050007e,
    CLCTL_NOTIFY_MONITOR_SHUTTING_DOWN                              = 0x00100081,
    CLCTL_UNDELETE                                                  = 0x00500086,
    ///See CLUSCTL_RESOURCE_GET_OPERATION_CONTEXT.
    CLCTL_GET_OPERATION_CONTEXT                                     = 0x001020e9,
    ///See CLUSCTL_RESOURCE_NOTIFY_OWNER_CHANGE. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This operation code is not available before Windows Server 2012 R2.
    CLCTL_NOTIFY_OWNER_CHANGE                                       = 0x00502122,
    ///See CLUSCTL_RESOURCE_VALIDATE_CHANGE_GROUP. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLCTL_VALIDATE_CHANGE_GROUP                                     = 0x00102125,
    CLCTL_CHECK_DRAIN_VETO                                          = 0x0010212d,
    CLCTL_NOTIFY_DRAIN_COMPLETE                                     = 0x00102131,
}

///Enumerates resource control codes.
alias CLUSCTL_RESOURCE_CODES = int;
enum : int
{
    ///See CLUSCTL_RESOURCE_UNKNOWN.
    CLUSCTL_RESOURCE_UNKNOWN                                   = 0x01000000,
    ///See CLUSCTL_RESOURCE_GET_CHARACTERISTICS.
    CLUSCTL_RESOURCE_GET_CHARACTERISTICS                       = 0x01000005,
    ///See CLUSCTL_RESOURCE_GET_FLAGS.
    CLUSCTL_RESOURCE_GET_FLAGS                                 = 0x01000009,
    ///See CLUSCTL_RESOURCE_GET_CLASS_INFO.
    CLUSCTL_RESOURCE_GET_CLASS_INFO                            = 0x0100000d,
    ///See CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES.
    CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES                 = 0x01000011,
    ///See CLUSCTL_RESOURCE_GET_NAME.
    CLUSCTL_RESOURCE_GET_NAME                                  = 0x01000029,
    ///See CLUSCTL_RESOURCE_GET_ID.
    CLUSCTL_RESOURCE_GET_ID                                    = 0x01000039,
    ///See CLUSCTL_RESOURCE_GET_RESOURCE_TYPE.
    CLUSCTL_RESOURCE_GET_RESOURCE_TYPE                         = 0x0100002d,
    ///See CLUSCTL_RESOURCE_ENUM_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_ENUM_COMMON_PROPERTIES                    = 0x01000051,
    ///See CLUSCTL_RESOURCE_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_GET_RO_COMMON_PROPERTIES                  = 0x01000055,
    ///See CLUSCTL_RESOURCE_GET_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_GET_COMMON_PROPERTIES                     = 0x01000059,
    ///See CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES                     = 0x0140005e,
    ///See CLUSCTL_RESOURCE_VALIDATE_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_VALIDATE_COMMON_PROPERTIES                = 0x01000061,
    ///See CLUSCTL_RESOURCE_GET_COMMON_PROPERTY_FMTS.
    CLUSCTL_RESOURCE_GET_COMMON_PROPERTY_FMTS                  = 0x01000065,
    ///See CLUSCTL_RESOURCE_ENUM_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_ENUM_PRIVATE_PROPERTIES                   = 0x01000079,
    ///See CLUSCTL_RESOURCE_GET_RO_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_GET_RO_PRIVATE_PROPERTIES                 = 0x0100007d,
    ///See CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTIES                    = 0x01000081,
    ///See CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES                    = 0x01400086,
    ///See CLUSCTL_RESOURCE_VALIDATE_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_VALIDATE_PRIVATE_PROPERTIES               = 0x01000089,
    ///See CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTY_FMTS.
    CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTY_FMTS                 = 0x0100008d,
    ///See CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT.
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT                   = 0x014000a2,
    ///See CLUSCTL_RESOURCE_DELETE_REGISTRY_CHECKPOINT.
    CLUSCTL_RESOURCE_DELETE_REGISTRY_CHECKPOINT                = 0x014000a6,
    ///See CLUSCTL_RESOURCE_GET_REGISTRY_CHECKPOINTS.
    CLUSCTL_RESOURCE_GET_REGISTRY_CHECKPOINTS                  = 0x010000a9,
    ///See CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT.
    CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT                     = 0x014000ae,
    ///See CLUSCTL_RESOURCE_DELETE_CRYPTO_CHECKPOINT.
    CLUSCTL_RESOURCE_DELETE_CRYPTO_CHECKPOINT                  = 0x014000b2,
    ///See CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT_EX. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server
    ///2008: </b>This control code is not available before Windows Server 2012 R2.
    CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT_EX                  = 0x014002d6,
    ///See CLUSCTL_RESOURCE_GET_CRYPTO_CHECKPOINTS.
    CLUSCTL_RESOURCE_GET_CRYPTO_CHECKPOINTS                    = 0x010000b5,
    ///See CLUSCTL_RESOURCE_GET_LOADBAL_PROCESS_LIST.
    CLUSCTL_RESOURCE_GET_LOADBAL_PROCESS_LIST                  = 0x010000c9,
    ///See CLUSCTL_RESOURCE_GET_NETWORK_NAME.
    CLUSCTL_RESOURCE_GET_NETWORK_NAME                          = 0x01000169,
    ///See CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN.
    CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN          = 0x0100016d,
    ///See CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFO.
    CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFO                      = 0x0100017a,
    CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFOEX                    = 0x0100031a,
    ///See CLUSCTL_RESOURCE_NETNAME_DELETE_CO.
    CLUSCTL_RESOURCE_NETNAME_DELETE_CO                         = 0x0100017e,
    ///See CLUSCTL_RESOURCE_NETNAME_VALIDATE_VCO.
    CLUSCTL_RESOURCE_NETNAME_VALIDATE_VCO                      = 0x01000181,
    ///See CLUSCTL_RESOURCE_NETNAME_RESET_VCO.
    CLUSCTL_RESOURCE_NETNAME_RESET_VCO                         = 0x01000185,
    ///CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO
    CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO                        = 0x0100018d,
    ///See CLUSCTL_RESOURCE_NETNAME_REGISTER_DNS_RECORDS.
    CLUSCTL_RESOURCE_NETNAME_REGISTER_DNS_RECORDS              = 0x01000172,
    ///See CLUSCTL_RESOURCE_GET_DNS_NAME.
    CLUSCTL_RESOURCE_GET_DNS_NAME                              = 0x01000175,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO.
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO                     = 0x01000191,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_NUMBER_INFO. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_NUMBER_INFO              = 0x010001a1,
    ///See CLUSCTL_RESOURCE_STORAGE_IS_PATH_VALID.
    CLUSCTL_RESOURCE_STORAGE_IS_PATH_VALID                     = 0x01000199,
    ///See CLUSCTL_RESOURCE_QUERY_DELETE.
    CLUSCTL_RESOURCE_QUERY_DELETE                              = 0x010001b9,
    ///See CLUSCTL_RESOURCE_UPGRADE_DLL.
    CLUSCTL_RESOURCE_UPGRADE_DLL                               = 0x014000ba,
    ///See CLUSCTL_RESOURCE_IPADDRESS_RENEW_LEASE.
    CLUSCTL_RESOURCE_IPADDRESS_RENEW_LEASE                     = 0x014001be,
    ///See CLUSCTL_RESOURCE_IPADDRESS_RELEASE_LEASE.
    CLUSCTL_RESOURCE_IPADDRESS_RELEASE_LEASE                   = 0x014001c2,
    ///See CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_64BIT.
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_64BIT             = 0x014000be,
    ///See CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_32BIT.
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_32BIT             = 0x014000c2,
    ///See CLUSCTL_RESOURCE_QUERY_MAINTENANCE_MODE.
    CLUSCTL_RESOURCE_QUERY_MAINTENANCE_MODE                    = 0x010001e1,
    ///See CLUSCTL_RESOURCE_SET_MAINTENANCE_MODE.
    CLUSCTL_RESOURCE_SET_MAINTENANCE_MODE                      = 0x014001e6,
    ///See CLUSCTL_RESOURCE_STORAGE_SET_DRIVELETTER.
    CLUSCTL_RESOURCE_STORAGE_SET_DRIVELETTER                   = 0x014001ea,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX.
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX                  = 0x010001f1,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX2. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX2                 = 0x010001f9,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_MOUNTPOINTS.
    CLUSCTL_RESOURCE_STORAGE_GET_MOUNTPOINTS                   = 0x01000211,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DIRTY.
    CLUSCTL_RESOURCE_STORAGE_GET_DIRTY                         = 0x01000219,
    ///Not supported.
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_INFO            = 0x01000225,
    ///See CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE.
    CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE                  = 0x01400296,
    ///See CLUSCTL_RESOURCE_ENABLE_SHARED_VOLUME_DIRECTIO.
    CLUSCTL_RESOURCE_ENABLE_SHARED_VOLUME_DIRECTIO             = 0x0140028a,
    ///See CLUSCTL_RESOURCE_DISABLE_SHARED_VOLUME_DIRECTIO.
    CLUSCTL_RESOURCE_DISABLE_SHARED_VOLUME_DIRECTIO            = 0x0140028e,
    ///See CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE.
    CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE             = 0x0140029a,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES.
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES = 0x0100029d,
    ///See CLUSCTL_RESOURCE_GET_FAILURE_INFO.
    CLUSCTL_RESOURCE_GET_FAILURE_INFO                          = 0x01000019,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_DISKID.
    CLUSCTL_RESOURCE_STORAGE_GET_DISKID                        = 0x01000205,
    ///See CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_STATES.
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_STATES          = 0x014002a2,
    ///See CLUSCTL_RESOURCE_STORAGE_IS_SHARED_VOLUME.
    CLUSCTL_RESOURCE_STORAGE_IS_SHARED_VOLUME                  = 0x010002a5,
    ///See CLUSCTL_RESOURCE_IS_QUORUM_BLOCKED.
    CLUSCTL_RESOURCE_IS_QUORUM_BLOCKED                         = 0x010002b1,
    ///See CLUSCTL_RESOURCE_POOL_GET_DRIVE_INFO.
    CLUSCTL_RESOURCE_POOL_GET_DRIVE_INFO                       = 0x010002b5,
    ///See CLUSCTL_RESOURCE_RLUA_GET_VIRTUAL_SERVER_TOKEN. <b>Windows Server 2012, Windows Server 2008 R2 and Windows
    ///Server 2008: </b>This control code is not supported before Windows Server 2012 R2.
    CLUSCTL_RESOURCE_RLUA_GET_VIRTUAL_SERVER_TOKEN             = 0x0100016d,
    ///See CLUSCTL_RESOURCE_RLUA_SET_PWD_INFO. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This control code is not supported before Windows Server 2012 R2.
    CLUSCTL_RESOURCE_RLUA_SET_PWD_INFO                         = 0x0100017a,
    CLUSCTL_RESOURCE_RLUA_SET_PWD_INFOEX                       = 0x0100031a,
    ///See CLUSCTL_RESOURCE_DELETE.
    CLUSCTL_RESOURCE_DELETE                                    = 0x01500006,
    CLUSCTL_RESOURCE_UNDELETE                                  = 0x01500086,
    ///See CLUSCTL_RESOURCE_INSTALL_NODE.
    CLUSCTL_RESOURCE_INSTALL_NODE                              = 0x0150000a,
    ///See CLUSCTL_RESOURCE_EVICT_NODE.
    CLUSCTL_RESOURCE_EVICT_NODE                                = 0x0150000e,
    ///See CLUSCTL_RESOURCE_ADD_DEPENDENCY.
    CLUSCTL_RESOURCE_ADD_DEPENDENCY                            = 0x01500012,
    ///See CLUSCTL_RESOURCE_REMOVE_DEPENDENCY.
    CLUSCTL_RESOURCE_REMOVE_DEPENDENCY                         = 0x01500016,
    ///See CLUSCTL_RESOURCE_ADD_OWNER.
    CLUSCTL_RESOURCE_ADD_OWNER                                 = 0x0150001a,
    ///See CLUSCTL_RESOURCE_REMOVE_OWNER.
    CLUSCTL_RESOURCE_REMOVE_OWNER                              = 0x0150001e,
    ///See CLUSCTL_RESOURCE_SET_NAME.
    CLUSCTL_RESOURCE_SET_NAME                                  = 0x01500026,
    ///See CLUSCTL_RESOURCE_CLUSTER_NAME_CHANGED.
    CLUSCTL_RESOURCE_CLUSTER_NAME_CHANGED                      = 0x0150002a,
    ///See CLUSCTL_RESOURCE_CLUSTER_VERSION_CHANGED.
    CLUSCTL_RESOURCE_CLUSTER_VERSION_CHANGED                   = 0x0150002e,
    ///See CLUSCTL_RESOURCE_FORCE_QUORUM.
    CLUSCTL_RESOURCE_FORCE_QUORUM                              = 0x01500046,
    ///See CLUSCTL_RESOURCE_INITIALIZE.
    CLUSCTL_RESOURCE_INITIALIZE                                = 0x0150004a,
    ///See CLUSCTL_RESOURCE_STATE_CHANGE_REASON.
    CLUSCTL_RESOURCE_STATE_CHANGE_REASON                       = 0x0150004e,
    ///See CLUSCTL_RESOURCE_PROVIDER_STATE_CHANGE.
    CLUSCTL_RESOURCE_PROVIDER_STATE_CHANGE                     = 0x01500052,
    ///See CLUSCTL_RESOURCE_LEAVING_GROUP.
    CLUSCTL_RESOURCE_LEAVING_GROUP                             = 0x01500056,
    ///See CLUSCTL_RESOURCE_JOINING_GROUP.
    CLUSCTL_RESOURCE_JOINING_GROUP                             = 0x0150005a,
    ///See CLUSCTL_RESOURCE_FSWITNESS_GET_EPOCH_INFO.
    CLUSCTL_RESOURCE_FSWITNESS_GET_EPOCH_INFO                  = 0x0110005d,
    ///See CLUSCTL_RESOURCE_FSWITNESS_SET_EPOCH_INFO.
    CLUSCTL_RESOURCE_FSWITNESS_SET_EPOCH_INFO                  = 0x01500062,
    ///See CLUSCTL_RESOURCE_FSWITNESS_RELEASE_LOCK.
    CLUSCTL_RESOURCE_FSWITNESS_RELEASE_LOCK                    = 0x01500066,
    ///See CLUSCTL_RESOURCE_NETNAME_CREDS_NOTIFYCAM.
    CLUSCTL_RESOURCE_NETNAME_CREDS_NOTIFYCAM                   = 0x0150006a,
    ///See CLUSCTL_RESOURCE_GET_OPERATION_CONTEXT.
    CLUSCTL_RESOURCE_GET_OPERATION_CONTEXT                     = 0x011020e9,
    ///See CLUSCTL_RESOURCE_RW_MODIFY_NOOP.
    CLUSCTL_RESOURCE_RW_MODIFY_NOOP                            = 0x014002ae,
    ///See CLUSCTL_RESOURCE_NOTIFY_QUORUM_STATUS.
    CLUSCTL_RESOURCE_NOTIFY_QUORUM_STATUS                      = 0x0150007e,
    ///See CLUSCTL_RESOURCE_NOTIFY_OWNER_CHANGE. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This control code is not supported before Windows Server 2012 R2.
    CLUSCTL_RESOURCE_NOTIFY_OWNER_CHANGE                       = 0x01502122,
    ///See CLUSCTL_RESOURCE_VALIDATE_CHANGE_GROUP. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_RESOURCE_VALIDATE_CHANGE_GROUP                     = 0x01102125,
    CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME              = 0x01002dd6,
    CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME_GUID         = 0x01002dda,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN                = 0x014020e6,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY                  = 0x014020f6,
    ///See CLUSCTL_RESOURCE_PREPARE_UPGRADE. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_RESOURCE_PREPARE_UPGRADE                           = 0x014020ea,
    ///See CLUSCTL_RESOURCE_UPGRADE_COMPLETED. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_RESOURCE_UPGRADE_COMPLETED                         = 0x014020ee,
    ///See CLUSCTL_RESOURCE_GET_STATE_CHANGE_TIME. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This control code is not supported before Windows Server 2016.
    CLUSCTL_RESOURCE_GET_STATE_CHANGE_TIME                     = 0x01002d5d,
    CLUSCTL_RESOURCE_GET_INFRASTRUCTURE_SOFS_BUFFER            = 0x01002d89,
    CLUSCTL_RESOURCE_SET_INFRASTRUCTURE_SOFS_BUFFER            = 0x01402d8e,
    CLUSCTL_RESOURCE_SCALEOUT_COMMAND                          = 0x01402d96,
    CLUSCTL_RESOURCE_SCALEOUT_CONTROL                          = 0x01402d9a,
    CLUSCTL_RESOURCE_SCALEOUT_GET_CLUSTERS                     = 0x01402d9d,
    CLUSCTL_RESOURCE_CHECK_DRAIN_VETO                          = 0x0110212d,
    CLUSCTL_RESOURCE_NOTIFY_DRAIN_COMPLETE                     = 0x01102131,
}

///Enumerates resource type control codes.
alias CLUSCTL_RESOURCE_TYPE_CODES = int;
enum : int
{
    ///See CLUSCTL_RESOURCE_TYPE_UNKNOWN.
    CLUSCTL_RESOURCE_TYPE_UNKNOWN                                     = 0x02000000,
    ///See CLUSCTL_RESOURCE_TYPE_GET_CHARACTERISTICS.
    CLUSCTL_RESOURCE_TYPE_GET_CHARACTERISTICS                         = 0x02000005,
    ///See CLUSCTL_RESOURCE_TYPE_GET_FLAGS.
    CLUSCTL_RESOURCE_TYPE_GET_FLAGS                                   = 0x02000009,
    ///See CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO.
    CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO                              = 0x0200000d,
    ///See CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES.
    CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES                   = 0x02000011,
    ///See CLUSCTL_RESOURCE_TYPE_GET_ARB_TIMEOUT.
    CLUSCTL_RESOURCE_TYPE_GET_ARB_TIMEOUT                             = 0x02000015,
    ///See CLUSCTL_RESOURCE_TYPE_ENUM_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_ENUM_COMMON_PROPERTIES                      = 0x02000051,
    ///See CLUSCTL_RESOURCE_TYPE_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_GET_RO_COMMON_PROPERTIES                    = 0x02000055,
    ///See CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTIES                       = 0x02000059,
    ///See CLUSCTL_RESOURCE_TYPE_VALIDATE_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_VALIDATE_COMMON_PROPERTIES                  = 0x02000061,
    ///See CLUSCTL_RESOURCE_TYPE_SET_COMMON_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_SET_COMMON_PROPERTIES                       = 0x0240005e,
    ///See CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTY_FMTS.
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTY_FMTS                    = 0x02000065,
    ///See CLUSCTL_RESOURCE_TYPE_GET_COMMON_RESOURCE_PROPERTY_FMTS.
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_RESOURCE_PROPERTY_FMTS           = 0x02000069,
    ///See CLUSCTL_RESOURCE_TYPE_ENUM_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_ENUM_PRIVATE_PROPERTIES                     = 0x02000079,
    ///See CLUSCTL_RESOURCE_TYPE_GET_RO_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_GET_RO_PRIVATE_PROPERTIES                   = 0x0200007d,
    ///See CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTIES                      = 0x02000081,
    ///See CLUSCTL_RESOURCE_TYPE_SET_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_SET_PRIVATE_PROPERTIES                      = 0x02400086,
    ///See CLUSCTL_RESOURCE_TYPE_VALIDATE_PRIVATE_PROPERTIES.
    CLUSCTL_RESOURCE_TYPE_VALIDATE_PRIVATE_PROPERTIES                 = 0x02000089,
    ///See CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTY_FMTS.
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTY_FMTS                   = 0x0200008d,
    ///See CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_RESOURCE_PROPERTY_FMTS.
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_RESOURCE_PROPERTY_FMTS          = 0x02000091,
    ///See CLUSCTL_RESOURCE_TYPE_GET_REGISTRY_CHECKPOINTS.
    CLUSCTL_RESOURCE_TYPE_GET_REGISTRY_CHECKPOINTS                    = 0x020000a9,
    ///See CLUSCTL_RESOURCE_TYPE_GET_CRYPTO_CHECKPOINTS.
    CLUSCTL_RESOURCE_TYPE_GET_CRYPTO_CHECKPOINTS                      = 0x020000b5,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS.
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS                 = 0x02000195,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_SYNC_CLUSDISK_DB.
    CLUSCTL_RESOURCE_TYPE_STORAGE_SYNC_CLUSDISK_DB                    = 0x0240019e,
    ///See CLUSCTL_RESOURCE_TYPE_NETNAME_VALIDATE_NETNAME.
    CLUSCTL_RESOURCE_TYPE_NETNAME_VALIDATE_NETNAME                    = 0x02000235,
    ///See CLUSCTL_RESOURCE_TYPE_NETNAME_GET_OU_FOR_VCO.
    CLUSCTL_RESOURCE_TYPE_NETNAME_GET_OU_FOR_VCO                      = 0x0240026e,
    ///See CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_PATH.
    CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_PATH                       = 0x02000231,
    ///See CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_DIRECTORY.
    CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_DIRECTORY                  = 0x02000239,
    ///See CLUSCTL_RESOURCE_TYPE_GEN_SCRIPT_VALIDATE_PATH.
    CLUSCTL_RESOURCE_TYPE_GEN_SCRIPT_VALIDATE_PATH                    = 0x02000231,
    ///See CLUSCTL_RESOURCE_TYPE_QUERY_DELETE.
    CLUSCTL_RESOURCE_TYPE_QUERY_DELETE                                = 0x020001b9,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DRIVELETTERS.
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DRIVELETTERS                    = 0x020001ed,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX.
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX              = 0x020001f5,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_REMAP_DRIVELETTER.
    CLUSCTL_RESOURCE_TYPE_STORAGE_REMAP_DRIVELETTER                   = 0x02000201,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DISKID.
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DISKID                          = 0x02000205,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_RESOURCEID.
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_RESOURCEID                      = 0x0200022d,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CLUSTERABLE.
    CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CLUSTERABLE                      = 0x02000209,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_REMOVE_VM_OWNERSHIP.
    CLUSCTL_RESOURCE_TYPE_STORAGE_REMOVE_VM_OWNERSHIP                 = 0x0240020e,
    CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CSV_FILE                         = 0x01000229,
    ///See CLUSCTL_RESOURCE_TYPE_WITNESS_VALIDATE_PATH.
    CLUSCTL_RESOURCE_TYPE_WITNESS_VALIDATE_PATH                       = 0x02000231,
    ///See CLUSCTL_RESOURCE_TYPE_INSTALL_NODE.
    CLUSCTL_RESOURCE_TYPE_INSTALL_NODE                                = 0x0250000a,
    ///See CLUSCTL_RESOURCE_TYPE_EVICT_NODE.
    CLUSCTL_RESOURCE_TYPE_EVICT_NODE                                  = 0x0250000e,
    ///See CLUSCTL_RESOURCE_TYPE_CLUSTER_VERSION_CHANGED.
    CLUSCTL_RESOURCE_TYPE_CLUSTER_VERSION_CHANGED                     = 0x0250002e,
    ///See CLUSCTL_RESOURCE_TYPE_FIXUP_ON_UPGRADE.
    CLUSCTL_RESOURCE_TYPE_FIXUP_ON_UPGRADE                            = 0x02500032,
    ///See CLUSCTL_RESOURCE_TYPE_STARTING_PHASE1.
    CLUSCTL_RESOURCE_TYPE_STARTING_PHASE1                             = 0x02500036,
    ///See CLUSCTL_RESOURCE_TYPE_STARTING_PHASE2.
    CLUSCTL_RESOURCE_TYPE_STARTING_PHASE2                             = 0x0250003a,
    ///See CLUSCTL_RESOURCE_TYPE_HOLD_IO.
    CLUSCTL_RESOURCE_TYPE_HOLD_IO                                     = 0x0250003e,
    ///See CLUSCTL_RESOURCE_TYPE_RESUME_IO.
    CLUSCTL_RESOURCE_TYPE_RESUME_IO                                   = 0x02500042,
    ///See CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INT. <b>Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This control code is not available before Windows Server 2012 R2.
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INT         = 0x02001fe1,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_LOGDISKS. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows Server
    ///2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_LOGDISKS           = 0x02002149,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS <b>Windows Server 2012 R2, Windows Server
    ///2012, Windows Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows
    ///Server 2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS   = 0x0200214d,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS. <b>Windows Server 2012 R2, Windows Server
    ///2012, Windows Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows
    ///Server 2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS   = 0x02002151,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_DISKS. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows Server
    ///2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_DISKS            = 0x02002155,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICA_VOLUMES <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows Server 2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICA_VOLUMES             = 0x02002159,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_VOLUME. <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows Server 2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_VOLUME                  = 0x0200215d,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_RESOURCE_GROUP. <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows Server 2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_RESOURCE_GROUP              = 0x02002161,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_PARTITION_INFO. <b>Windows Server 2012 R2, Windows Server
    ///2012, Windows Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows
    ///Server 2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_PARTITION_INFO   = 0x02002165,
    ///See CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_INFO. <b>Windows Server 2012 R2, Windows Server 2012, Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows Server 2016.
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_INFO                    = 0x02002145,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows Server
    ///2016.
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS          = 0x020020e1,
    ///See CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY. <b>Windows Server 2012 R2, Windows Server
    ///2012, Windows Server 2008 R2 and Windows Server 2008: </b>This control code is not available before Windows
    ///Server 2016.
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 0x020020f1,
    ///See CLUSCTL_RESOURCE_TYPE_PREPARE_UPGRADE. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This control code is not available before Windows Server 2016.
    CLUSCTL_RESOURCE_TYPE_PREPARE_UPGRADE                             = 0x024020ea,
    ///See CLUSCTL_RESOURCE_TYPE_UPGRADE_COMPLETED. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This control code is not available before Windows Server 2016.
    CLUSCTL_RESOURCE_TYPE_UPGRADE_COMPLETED                           = 0x024020ee,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_MONITOR_SHUTTING_DOWN                = 0x02100081,
    CLUSCTL_RESOURCE_TYPE_CHECK_DRAIN_VETO                            = 0x0210212d,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_DRAIN_COMPLETE                       = 0x02102131,
}

///Enumerates group control codes.
alias CLUSCTL_GROUP_CODES = int;
enum : int
{
    ///See CLUSCTL_GROUP_UNKNOWN.
    CLUSCTL_GROUP_UNKNOWN                     = 0x03000000,
    ///See CLUSCTL_GROUP_GET_CHARACTERISTICS.
    CLUSCTL_GROUP_GET_CHARACTERISTICS         = 0x03000005,
    ///See CLUSCTL_GROUP_GET_FLAGS.
    CLUSCTL_GROUP_GET_FLAGS                   = 0x03000009,
    ///See CLUSCTL_GROUP_GET_NAME.
    CLUSCTL_GROUP_GET_NAME                    = 0x03000029,
    ///See CLUSCTL_GROUP_GET_ID.
    CLUSCTL_GROUP_GET_ID                      = 0x03000039,
    ///See CLUSCTL_GROUP_ENUM_COMMON_PROPERTIES.
    CLUSCTL_GROUP_ENUM_COMMON_PROPERTIES      = 0x03000051,
    ///See CLUSCTL_GROUP_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_GROUP_GET_RO_COMMON_PROPERTIES    = 0x03000055,
    ///See CLUSCTL_GROUP_GET_COMMON_PROPERTIES.
    CLUSCTL_GROUP_GET_COMMON_PROPERTIES       = 0x03000059,
    ///See CLUSCTL_GROUP_SET_COMMON_PROPERTIES.
    CLUSCTL_GROUP_SET_COMMON_PROPERTIES       = 0x0340005e,
    ///See CLUSCTL_GROUP_VALIDATE_COMMON_PROPERTIES.
    CLUSCTL_GROUP_VALIDATE_COMMON_PROPERTIES  = 0x03000061,
    ///See CLUSCTL_GROUP_ENUM_PRIVATE_PROPERTIES.
    CLUSCTL_GROUP_ENUM_PRIVATE_PROPERTIES     = 0x03000079,
    ///See CLUSCTL_GROUP_GET_RO_PRIVATE_PROPERTIES.
    CLUSCTL_GROUP_GET_RO_PRIVATE_PROPERTIES   = 0x0300007d,
    ///See CLUSCTL_GROUP_GET_PRIVATE_PROPERTIES.
    CLUSCTL_GROUP_GET_PRIVATE_PROPERTIES      = 0x03000081,
    ///See CLUSCTL_GROUP_SET_PRIVATE_PROPERTIES.
    CLUSCTL_GROUP_SET_PRIVATE_PROPERTIES      = 0x03400086,
    ///See CLUSCTL_GROUP_VALIDATE_PRIVATE_PROPERTIES.
    CLUSCTL_GROUP_VALIDATE_PRIVATE_PROPERTIES = 0x03000089,
    ///See CLUSCTL_GROUP_QUERY_DELETE.
    CLUSCTL_GROUP_QUERY_DELETE                = 0x030001b9,
    ///See CLUSCTL_GROUP_GET_COMMON_PROPERTY_FMTS.
    CLUSCTL_GROUP_GET_COMMON_PROPERTY_FMTS    = 0x03000065,
    ///See CLUSCTL_GROUP_GET_PRIVATE_PROPERTY_FMTS.
    CLUSCTL_GROUP_GET_PRIVATE_PROPERTY_FMTS   = 0x0300008d,
    ///See CLUSCTL_GROUP_GET_FAILURE_INFO.
    CLUSCTL_GROUP_GET_FAILURE_INFO            = 0x03000019,
    ///See CLUSCTL_GROUP_GET_LAST_MOVE_TIME. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This control code is not available until Windows Server 2016.
    CLUSCTL_GROUP_GET_LAST_MOVE_TIME          = 0x030002d9,
    CLUSCTL_GROUP_SET_CCF_FROM_MASTER         = 0x03402d86,
}

///Enumerates node control codes.
alias CLUSCTL_NODE_CODES = int;
enum : int
{
    ///See CLUSCTL_NODE_UNKNOWN.
    CLUSCTL_NODE_UNKNOWN                          = 0x04000000,
    ///See CLUSCTL_NODE_GET_CHARACTERISTICS.
    CLUSCTL_NODE_GET_CHARACTERISTICS              = 0x04000005,
    ///See CLUSCTL_NODE_GET_FLAGS.
    CLUSCTL_NODE_GET_FLAGS                        = 0x04000009,
    ///See CLUSCTL_NODE_GET_NAME.
    CLUSCTL_NODE_GET_NAME                         = 0x04000029,
    ///See CLUSCTL_NODE_GET_ID.
    CLUSCTL_NODE_GET_ID                           = 0x04000039,
    ///See CLUSCTL_NODE_ENUM_COMMON_PROPERTIES.
    CLUSCTL_NODE_ENUM_COMMON_PROPERTIES           = 0x04000051,
    ///See CLUSCTL_NODE_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_NODE_GET_RO_COMMON_PROPERTIES         = 0x04000055,
    ///See CLUSCTL_NODE_GET_COMMON_PROPERTIES.
    CLUSCTL_NODE_GET_COMMON_PROPERTIES            = 0x04000059,
    ///See CLUSCTL_NODE_SET_COMMON_PROPERTIES.
    CLUSCTL_NODE_SET_COMMON_PROPERTIES            = 0x0440005e,
    ///See CLUSCTL_NODE_VALIDATE_COMMON_PROPERTIES.
    CLUSCTL_NODE_VALIDATE_COMMON_PROPERTIES       = 0x04000061,
    ///See CLUSCTL_NODE_ENUM_PRIVATE_PROPERTIES.
    CLUSCTL_NODE_ENUM_PRIVATE_PROPERTIES          = 0x04000079,
    ///See CLUSCTL_NODE_GET_RO_PRIVATE_PROPERTIES.
    CLUSCTL_NODE_GET_RO_PRIVATE_PROPERTIES        = 0x0400007d,
    ///See CLUSCTL_NODE_GET_PRIVATE_PROPERTIES.
    CLUSCTL_NODE_GET_PRIVATE_PROPERTIES           = 0x04000081,
    ///See CLUSCTL_NODE_SET_PRIVATE_PROPERTIES.
    CLUSCTL_NODE_SET_PRIVATE_PROPERTIES           = 0x04400086,
    ///See CLUSCTL_NODE_VALIDATE_PRIVATE_PROPERTIES.
    CLUSCTL_NODE_VALIDATE_PRIVATE_PROPERTIES      = 0x04000089,
    ///See CLUSCTL_NODE_GET_COMMON_PROPERTY_FMTS.
    CLUSCTL_NODE_GET_COMMON_PROPERTY_FMTS         = 0x04000065,
    ///See CLUSCTL_NODE_GET_PRIVATE_PROPERTY_FMTS.
    CLUSCTL_NODE_GET_PRIVATE_PROPERTY_FMTS        = 0x0400008d,
    ///See CLUSCTL_NODE_GET_CLUSTER_SERVICE_ACCOUNT_NAME.
    CLUSCTL_NODE_GET_CLUSTER_SERVICE_ACCOUNT_NAME = 0x04000041,
    CLUSCTL_NODE_GET_STUCK_NODES                  = 0x040002bd,
    ///See CLUSCTL_NODE_INJECT_GEM_FAULT. <b>Windows Server 2008 R2 and Windows Server 2012: </b>This control code is
    ///not supported before Windows Server 2012 R2.
    CLUSCTL_NODE_INJECT_GEM_FAULT                 = 0x040002c1,
    ///See CLUSCTL_NODE_INTRODUCE_GEM_REPAIR_DELAY. <b>Windows Server 2008 R2 and Windows Server 2012: </b>This control
    ///code is not supported before Windows Server 2012 R2.
    CLUSCTL_NODE_INTRODUCE_GEM_REPAIR_DELAY       = 0x040002c5,
    ///See CLUSCTL_NODE_SEND_DUMMY_GEM_MESSAGES. <b>Windows Server 2008 R2 and Windows Server 2012: </b>This control
    ///code is not supported before Windows Server 2012 R2.
    CLUSCTL_NODE_SEND_DUMMY_GEM_MESSAGES          = 0x040002c9,
    ///See CLUSCTL_NODE_BLOCK_GEM_SEND_RECV. <b>Windows Server 2008 R2 and Windows Server 2012: </b>This control code is
    ///not supported before Windows Server 2012 R2.
    CLUSCTL_NODE_BLOCK_GEM_SEND_RECV              = 0x040002cd,
    ///See CLUSCTL_NODE_GET_GEMID_VECTOR. <b>Windows Server 2008 R2 and Windows Server 2012: </b>This control code is
    ///not supported before Windows Server 2012 R2.
    CLUSCTL_NODE_GET_GEMID_VECTOR                 = 0x040002d1,
}

///Enumerates network control codes.
alias CLUSCTL_NETWORK_CODES = int;
enum : int
{
    ///See CLUSCTL_NETWORK_UNKNOWN.
    CLUSCTL_NETWORK_UNKNOWN                     = 0x05000000,
    ///See CLUSCTL_NETWORK_GET_CHARACTERISTICS.
    CLUSCTL_NETWORK_GET_CHARACTERISTICS         = 0x05000005,
    ///See CLUSCTL_NETWORK_GET_FLAGS.
    CLUSCTL_NETWORK_GET_FLAGS                   = 0x05000009,
    ///See CLUSCTL_NETWORK_GET_NAME.
    CLUSCTL_NETWORK_GET_NAME                    = 0x05000029,
    ///See CLUSCTL_NETWORK_GET_ID.
    CLUSCTL_NETWORK_GET_ID                      = 0x05000039,
    ///See CLUSCTL_NETWORK_ENUM_COMMON_PROPERTIES.
    CLUSCTL_NETWORK_ENUM_COMMON_PROPERTIES      = 0x05000051,
    ///See CLUSCTL_NETWORK_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_NETWORK_GET_RO_COMMON_PROPERTIES    = 0x05000055,
    ///See CLUSCTL_NETWORK_GET_COMMON_PROPERTIES.
    CLUSCTL_NETWORK_GET_COMMON_PROPERTIES       = 0x05000059,
    ///See CLUSCTL_NETWORK_SET_COMMON_PROPERTIES.
    CLUSCTL_NETWORK_SET_COMMON_PROPERTIES       = 0x0540005e,
    ///See CLUSCTL_NETWORK_VALIDATE_COMMON_PROPERTIES.
    CLUSCTL_NETWORK_VALIDATE_COMMON_PROPERTIES  = 0x05000061,
    ///See CLUSCTL_NETWORK_ENUM_PRIVATE_PROPERTIES.
    CLUSCTL_NETWORK_ENUM_PRIVATE_PROPERTIES     = 0x05000079,
    ///See CLUSCTL_NETWORK_GET_RO_PRIVATE_PROPERTIES.
    CLUSCTL_NETWORK_GET_RO_PRIVATE_PROPERTIES   = 0x0500007d,
    ///See CLUSCTL_NETWORK_GET_PRIVATE_PROPERTIES.
    CLUSCTL_NETWORK_GET_PRIVATE_PROPERTIES      = 0x05000081,
    ///See CLUSCTL_NETWORK_SET_PRIVATE_PROPERTIES.
    CLUSCTL_NETWORK_SET_PRIVATE_PROPERTIES      = 0x05400086,
    ///See CLUSCTL_NETWORK_VALIDATE_PRIVATE_PROPERTIES.
    CLUSCTL_NETWORK_VALIDATE_PRIVATE_PROPERTIES = 0x05000089,
    ///See CLUSCTL_NETWORK_GET_COMMON_PROPERTY_FMTS.
    CLUSCTL_NETWORK_GET_COMMON_PROPERTY_FMTS    = 0x05000065,
    ///See CLUSCTL_NETWORK_GET_PRIVATE_PROPERTY_FMTS.
    CLUSCTL_NETWORK_GET_PRIVATE_PROPERTY_FMTS   = 0x0500008d,
}

///Enumerates Network Interface control codes.
alias CLUSCTL_NETINTERFACE_CODES = int;
enum : int
{
    ///See CLUSCTL_NETINTERFACE_UNKNOWN.
    CLUSCTL_NETINTERFACE_UNKNOWN                     = 0x06000000,
    ///See CLUSCTL_NETINTERFACE_GET_CHARACTERISTICS.
    CLUSCTL_NETINTERFACE_GET_CHARACTERISTICS         = 0x06000005,
    ///See CLUSCTL_NETINTERFACE_GET_FLAGS.
    CLUSCTL_NETINTERFACE_GET_FLAGS                   = 0x06000009,
    ///See CLUSCTL_NETINTERFACE_GET_NAME.
    CLUSCTL_NETINTERFACE_GET_NAME                    = 0x06000029,
    ///See CLUSCTL_NETINTERFACE_GET_ID.
    CLUSCTL_NETINTERFACE_GET_ID                      = 0x06000039,
    ///See CLUSCTL_NETINTERFACE_GET_NODE.
    CLUSCTL_NETINTERFACE_GET_NODE                    = 0x06000031,
    ///See CLUSCTL_NETINTERFACE_GET_NETWORK.
    CLUSCTL_NETINTERFACE_GET_NETWORK                 = 0x06000035,
    ///See CLUSCTL_NETINTERFACE_ENUM_COMMON_PROPERTIES.
    CLUSCTL_NETINTERFACE_ENUM_COMMON_PROPERTIES      = 0x06000051,
    ///See CLUSCTL_NETINTERFACE_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_NETINTERFACE_GET_RO_COMMON_PROPERTIES    = 0x06000055,
    ///See CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTIES.
    CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTIES       = 0x06000059,
    ///See CLUSCTL_NETINTERFACE_SET_COMMON_PROPERTIES.
    CLUSCTL_NETINTERFACE_SET_COMMON_PROPERTIES       = 0x0640005e,
    ///See CLUSCTL_NETINTERFACE_VALIDATE_COMMON_PROPERTIES.
    CLUSCTL_NETINTERFACE_VALIDATE_COMMON_PROPERTIES  = 0x06000061,
    ///See CLUSCTL_NETINTERFACE_ENUM_PRIVATE_PROPERTIES.
    CLUSCTL_NETINTERFACE_ENUM_PRIVATE_PROPERTIES     = 0x06000079,
    ///See CLUSCTL_NETINTERFACE_GET_RO_PRIVATE_PROPERTIES.
    CLUSCTL_NETINTERFACE_GET_RO_PRIVATE_PROPERTIES   = 0x0600007d,
    ///See CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTIES.
    CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTIES      = 0x06000081,
    ///See CLUSCTL_NETINTERFACE_SET_PRIVATE_PROPERTIES.
    CLUSCTL_NETINTERFACE_SET_PRIVATE_PROPERTIES      = 0x06400086,
    ///See CLUSCTL_NETINTERFACE_VALIDATE_PRIVATE_PROPERTIES.
    CLUSCTL_NETINTERFACE_VALIDATE_PRIVATE_PROPERTIES = 0x06000089,
    ///See CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTY_FMTS.
    CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTY_FMTS    = 0x06000065,
    ///See CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTY_FMTS.
    CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTY_FMTS   = 0x0600008d,
}

///Enumerates cluster control codes used by the ClusterControl function.
alias CLUSCTL_CLUSTER_CODES = int;
enum : int
{
    ///See CLUSCTL_CLUSTER_UNKNOWN.
    CLUSCTL_CLUSTER_UNKNOWN                                      = 0x07000000,
    ///See CLUSCTL_CLUSTER_GET_FQDN.
    CLUSCTL_CLUSTER_GET_FQDN                                     = 0x0700003d,
    ///See CLUSCTL_CLUSTER_SET_STORAGE_CONFIGURATION. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_SET_STORAGE_CONFIGURATION                    = 0x074002e2,
    ///See CLUSCTL_CLUSTER_GET_STORAGE_CONFIGURATION. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_GET_STORAGE_CONFIGURATION                    = 0x070002e5,
    ///See CLUSCTL_CLUSTER_GET_STORAGE_CONFIG_ATTRIBUTES. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_GET_STORAGE_CONFIG_ATTRIBUTES                = 0x070002e9,
    ///See CLUSCTL_CLUSTER_ENUM_COMMON_PROPERTIES.
    CLUSCTL_CLUSTER_ENUM_COMMON_PROPERTIES                       = 0x07000051,
    ///See CLUSCTL_CLUSTER_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_CLUSTER_GET_RO_COMMON_PROPERTIES                     = 0x07000055,
    ///See CLUSCTL_CLUSTER_GET_COMMON_PROPERTIES.
    CLUSCTL_CLUSTER_GET_COMMON_PROPERTIES                        = 0x07000059,
    ///See CLUSCTL_CLUSTER_SET_COMMON_PROPERTIES.
    CLUSCTL_CLUSTER_SET_COMMON_PROPERTIES                        = 0x0740005e,
    ///See CLUSCTL_CLUSTER_VALIDATE_COMMON_PROPERTIES.
    CLUSCTL_CLUSTER_VALIDATE_COMMON_PROPERTIES                   = 0x07000061,
    ///See CLUSCTL_CLUSTER_ENUM_PRIVATE_PROPERTIES.
    CLUSCTL_CLUSTER_ENUM_PRIVATE_PROPERTIES                      = 0x07000079,
    ///See CLUSCTL_CLUSTER_GET_RO_PRIVATE_PROPERTIES.
    CLUSCTL_CLUSTER_GET_RO_PRIVATE_PROPERTIES                    = 0x0700007d,
    ///See CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTIES.
    CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTIES                       = 0x07000081,
    ///See CLUSCTL_CLUSTER_SET_PRIVATE_PROPERTIES.
    CLUSCTL_CLUSTER_SET_PRIVATE_PROPERTIES                       = 0x07400086,
    ///See CLUSCTL_CLUSTER_VALIDATE_PRIVATE_PROPERTIES.
    CLUSCTL_CLUSTER_VALIDATE_PRIVATE_PROPERTIES                  = 0x07000089,
    ///See CLUSCTL_CLUSTER_GET_COMMON_PROPERTY_FMTS.
    CLUSCTL_CLUSTER_GET_COMMON_PROPERTY_FMTS                     = 0x07000065,
    ///See CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTY_FMTS.
    CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTY_FMTS                    = 0x0700008d,
    ///See CLUSCTL_CLUSTER_CHECK_VOTER_EVICT.
    CLUSCTL_CLUSTER_CHECK_VOTER_EVICT                            = 0x07000045,
    ///See CLUSCTL_CLUSTER_CHECK_VOTER_DOWN.
    CLUSCTL_CLUSTER_CHECK_VOTER_DOWN                             = 0x07000049,
    ///See CLUSCTL_CLUSTER_SHUTDOWN.
    CLUSCTL_CLUSTER_SHUTDOWN                                     = 0x0700004d,
    ///Not supported.
    CLUSCTL_CLUSTER_BATCH_BLOCK_KEY                              = 0x0700023e,
    ///Not supported.
    CLUSCTL_CLUSTER_BATCH_UNBLOCK_KEY                            = 0x07000241,
    ///See CLUSCTL_CLUSTER_GET_SHARED_VOLUME_ID. <b>Windows Server 2008: </b>This control code is not supported before
    ///Windows Server 2008 R2.
    CLUSCTL_CLUSTER_GET_SHARED_VOLUME_ID                         = 0x07000291,
    ///See CLUSCTL_CLUSTER_GET_CLUSDB_TIMESTAMP.
    CLUSCTL_CLUSTER_GET_CLUSDB_TIMESTAMP                         = 0x070002a9,
    ///See CLUSCTL_CLUSTER_GET_GUM_LOCK_OWNER. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_GET_GUM_LOCK_OWNER                           = 0x070002b9,
    ///See CLUSCTL_CLUSTER_REMOVE_NODE. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_REMOVE_NODE                                  = 0x074002ee,
    ///See CLUSCTL_CLUSTER_SET_ACCOUNT_ACCESS. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_SET_ACCOUNT_ACCESS                           = 0x074000f2,
    ///See CLUSCTL_CLUSTER_CLEAR_NODE_CONNECTION_INFO. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_CLEAR_NODE_CONNECTION_INFO                   = 0x07400306,
    ///See CLUSCTL_CLUSTER_SET_DNS_DOMAIN. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_SET_DNS_DOMAIN                               = 0x0740030a,
    ///See CLUSCTL_CLUSTER_SET_CLUSTER_S2D_ENABLED. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008
    ///R2 and Windows Server 2008: </b>This operation code is not available before Windows Server 2016.
    CLUSCTL_CLUSTER_SET_CLUSTER_S2D_ENABLED                      = 0x07402d62,
    ///See CLUSCTL_CLUSTER_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This operation code is not available before Windows Server
    ///2016.
    CLUSCTL_CLUSTER_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES = 0x07402d6e,
    CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME                 = 0x07002dd6,
    CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME_GUID            = 0x07002dda,
    CLUSCTL_CLUSTER_RELOAD_AUTOLOGGER_CONFIG                     = 0x07002dd2,
    CLUSCTL_CLUSTER_ENUM_AFFINITY_RULE_NAMES                     = 0x07002ddd,
}

///Enumerates groupset control codes used by the ClusterGroupSetControl function.
alias CLUSCTL_GROUPSET_CODES = int;
enum : int
{
    ///See CLUSCTL_GROUPSET_GET_COMMON_PROPERTIES.
    CLUSCTL_GROUPSET_GET_COMMON_PROPERTIES    = 0x08000059,
    ///See CLUSCTL_GROUPSET_GET_RO_COMMON_PROPERTIES.
    CLUSCTL_GROUPSET_GET_RO_COMMON_PROPERTIES = 0x08000055,
    ///See CLUSCTL_GROUPSET_SET_COMMON_PROPERTIES.
    CLUSCTL_GROUPSET_SET_COMMON_PROPERTIES    = 0x0840005e,
    ///See CLUSCTL_GROUPSET_GET_GROUPS.
    CLUSCTL_GROUPSET_GET_GROUPS               = 0x08002d71,
    ///See CLUSCTL_GROUPSET_GET_PROVIDER_GROUPS.
    CLUSCTL_GROUPSET_GET_PROVIDER_GROUPS      = 0x08002d75,
    ///See CLUSCTL_GROUPSET_GET_PROVIDER_GROUPSETS.
    CLUSCTL_GROUPSET_GET_PROVIDER_GROUPSETS   = 0x08002d79,
    ///See CLUSCTL_GROUP_GET_PROVIDER_GROUPS.
    CLUSCTL_GROUP_GET_PROVIDER_GROUPS         = 0x08002d7d,
    ///See CLUSCTL_GROUP_GET_PROVIDER_GROUPSETS.
    CLUSCTL_GROUP_GET_PROVIDER_GROUPSETS      = 0x08002d81,
    CLUSCTL_GROUPSET_GET_ID                   = 0x08000039,
}

alias CLUSCTL_AFFINITYRULE_CODES = int;
enum : int
{
    CLUSCTL_AFFINITYRULE_GET_COMMON_PROPERTIES    = 0x09000059,
    CLUSCTL_AFFINITYRULE_GET_RO_COMMON_PROPERTIES = 0x09000055,
    CLUSCTL_AFFINITYRULE_SET_COMMON_PROPERTIES    = 0x0940005e,
    CLUSCTL_AFFINITYRULE_GET_ID                   = 0x09000039,
    CLUSCTL_AFFINITYRULE_GET_GROUPNAMES           = 0x09002d71,
}

///Defines the class of a resource.
alias CLUSTER_RESOURCE_CLASS = int;
enum : int
{
    ///Resource class is unknown.
    CLUS_RESCLASS_UNKNOWN = 0x00000000,
    ///Resource is a storage device, such as a Physical Disk resource.
    CLUS_RESCLASS_STORAGE = 0x00000001,
    ///Resource is a network device.
    CLUS_RESCLASS_NETWORK = 0x00000002,
    ///Resource classes beginning at this value are user-defined.
    CLUS_RESCLASS_USER    = 0x00008000,
}

///Identifies a resource subclass that manages a shared resource.
alias CLUS_RESSUBCLASS = int;
enum : int
{
    ///Identifies a resource subclass that manages a shared resource, such as a disk on a shared SCSI bus. The
    ///ClusterResourceControl function with the CLUSCTL_RESOURCE_GET_CLASS_INFO control code can retrieve a
    ///CLUS_RESOURCE_CLASS_INFO structure that contains this information.
    CLUS_RESSUBCLASS_SHARED = 0x80000000,
}

///Identifies a resource subclass that manages a shared bus.
alias CLUS_RESSUBCLASS_STORAGE = int;
enum : int
{
    ///Identifies a resource subclass that manages a shared bus. The ClusterResourceControl function with the
    ///CLUSCTL_RESOURCE_GET_CLASS_INFO control code can retrieve a CLUS_RESOURCE_CLASS_INFO structure that contains
    ///information for a resource subclass.
    CLUS_RESSUBCLASS_STORAGE_SHARED_BUS  = 0x80000000,
    ///Identifies a resource subclass that manages a disk. <b>Windows Server 2012, Windows Server 2008 R2 and Windows
    ///Server 2008: </b>This value is not supported before Windows Server 2012 R2.
    CLUS_RESSUBCLASS_STORAGE_DISK        = 0x40000000,
    ///Identifies a resource subclass that manages storage replication. <b>Windows Server 2012 R2, Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This value is not supported before Windows Server 2016.
    CLUS_RESSUBCLASS_STORAGE_REPLICATION = 0x10000000,
}

///Identifies a resource subclass that manages an IP address provider.
alias CLUS_RESSUBCLASS_NETWORK = int;
enum : int
{
    ///Identifies a resource subclass that manages an IP address provider. The ClusterResourceControl function with the
    ///CLUSCTL_RESOURCE_GET_CLASS_INFO control code can retrieve a CLUS_RESOURCE_CLASS_INFO structure that contains this
    ///information.
    CLUS_RESSUBCLASS_NETWORK_INTERNET_PROTOCOL = 0x80000000,
}

///Enumerates characteristics of resource types and resources.
alias CLUS_CHARACTERISTICS = int;
enum : int
{
    ///Resources of this type have no known characteristics.
    CLUS_CHAR_UNKNOWN                        = 0x00000000,
    ///Resources of this type are capable of being the quorum resource type for a cluster.
    CLUS_CHAR_QUORUM                         = 0x00000001,
    ///Resources of this type cannot be deleted unless all nodes are active.
    CLUS_CHAR_DELETE_REQUIRES_ALL_NODES      = 0x00000002,
    ///Not supported.
    CLUS_CHAR_LOCAL_QUORUM                   = 0x00000004,
    ///Not supported.
    CLUS_CHAR_LOCAL_QUORUM_DEBUG             = 0x00000008,
    ///The resource DLL will receive the CLUSCTL_RESOURCE_STATE_CHANGE_REASON control code.
    CLUS_CHAR_REQUIRES_STATE_CHANGE_REASON   = 0x00000010,
    ///Not supported.
    CLUS_CHAR_BROADCAST_DELETE               = 0x00000020,
    ///Only one instance of this resource type is allowed in a cluster.
    CLUS_CHAR_SINGLE_CLUSTER_INSTANCE        = 0x00000040,
    ///Only one instance of this resource type is allowed in a group.
    CLUS_CHAR_SINGLE_GROUP_INSTANCE          = 0x00000080,
    ///The resource can be made part of a special group. Protocol version 2.0 servers do not support this value.
    CLUS_CHAR_COEXIST_IN_SHARED_VOLUME_GROUP = 0x00000100,
    ///The resource type can be queried to get more information about how many resources it uses. For example, in the
    ///virtual machine resource type, information is returned about how much memory is required for the virtual machine
    ///to be started. <b>Windows Server 2008 R2 and Windows Server 2008: </b>This enumeration value is not supported
    ///before Windows Server 2012.
    CLUS_CHAR_PLACEMENT_DATA                 = 0x00000200,
    ///The resource can be deleted without being taken offline. Protocol version 2.0 servers do not support this value.
    CLUS_CHAR_MONITOR_DETACH                 = 0x00000400,
    ///This value is reserved for local use and must be ignored by the client. Protocol version 2.0 servers do not
    ///support this value.
    CLUS_CHAR_MONITOR_REATTACH               = 0x00000800,
    ///This value is reserved for local use and must be ignored by the client. Protocol version 2.0 servers do not
    ///support this value.
    CLUS_CHAR_OPERATION_CONTEXT              = 0x00001000,
    ///This value is reserved for local use and must be ignored by the client. Protocol version 2.0 servers do not
    ///support this value.
    CLUS_CHAR_CLONES                         = 0x00002000,
    ///The resource should not be preempted, even if the whole group is being preempted. <b>Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This enumeration value is not supported before Windows Server 2012.
    CLUS_CHAR_NOT_PREEMPTABLE                = 0x00004000,
    ///The resource can receive a new owner. <b>Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This enumeration value is not supported before Windows Server 2012 R2.
    CLUS_CHAR_NOTIFY_NEW_OWNER               = 0x00008000,
    ///The resource can continue run in an unmonitored state when it losses cluster membership. <b>Windows Server 2012
    ///R2, Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008: </b>This enumeration value is not
    ///supported before Windows Server 2016.
    CLUS_CHAR_SUPPORTS_UNMONITORED_STATE     = 0x00010000,
    ///This value is reserved for infrastructure. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This enumeration value is not supported before Windows Server 2016.
    CLUS_CHAR_INFRASTRUCTURE                 = 0x00020000,
    CLUS_CHAR_VETO_DRAIN                     = 0x00040000,
}

///Identifies the resource or group as a core resource.
alias CLUS_FLAGS = int;
enum : int
{
    ///Identifies core resources or the cluster group that contains core resources. The ClusterResourceControl function
    ///with the CLUSCTL_RESOURCE_GET_FLAGS control code can retrieve the flags that are set for a resource.
    CLUS_FLAG_CORE = 0x00000001,
}

///Represents disk partition information. The enumeration flags identify certain properties of a disk partition, which
///is a storage class resource.
alias CLUSPROP_PIFLAGS = int;
enum : int
{
    ///The drive letter is sticky.
    CLUSPROP_PIFLAG_STICKY             = 0x00000001,
    ///The storage class resource is removable.
    CLUSPROP_PIFLAG_REMOVABLE          = 0x00000002,
    ///The storage class resource is formatted with a file system that is usable by the Cluster service.
    CLUSPROP_PIFLAG_USABLE             = 0x00000004,
    ///The partition should be used to store quorum files if no partition is specified in the SetClusterQuorumResource
    ///function.
    CLUSPROP_PIFLAG_DEFAULT_QUORUM     = 0x00000008,
    ///The partition can be used in a cluster shared volume (CSV). <b>Windows Server 2008 R2 and Windows Server 2008:
    ///</b>This value is supported starting with Windows Server 2012.
    CLUSPROP_PIFLAG_USABLE_FOR_CSV     = 0x00000010,
    ///The partition uses BitLocker encryption. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2
    ///and Windows Server 2008: </b>This value is supported starting with Windows Server 2016.
    CLUSPROP_PIFLAG_ENCRYPTION_ENABLED = 0x00000020,
    CLUSPROP_PIFLAG_RAW                = 0x00000040,
    ///The partition uses an unknown file system type. <b>Windows Server 2012 R2, Windows Server 2012, Windows Server
    ///2008 R2 and Windows Server 2008: </b>This value is supported starting with Windows Server 2012 R2 with KB
    ///3093899.
    CLUSPROP_PIFLAG_UNKNOWN            = 0x80000000,
}

///Defines the various fault states for a cluster shared volume (CSV).
alias CLUSTER_CSV_VOLUME_FAULT_STATE = int;
enum : int
{
    ///The CSV has no faults.
    VolumeStateNoFaults      = 0x00000000,
    ///Direct I/O is disabled for the CSV.
    VolumeStateNoDirectIO    = 0x00000001,
    ///The CSV can not be accessed.
    VolumeStateNoAccess      = 0x00000002,
    ///The CSV is in maintenance mode.
    VolumeStateInMaintenance = 0x00000004,
    ///The CSV is dismounted.
    VolumeStateDismounted    = 0x00000008,
}

///Describes the cluster shared volume (CSV) backup state.
alias CLUSTER_SHARED_VOLUME_BACKUP_STATE = int;
enum : int
{
    ///There is no backup in progress for this CSV.
    VolumeBackupNone       = 0x00000000,
    ///There is a backup in progress for this CSV.
    VolumeBackupInProgress = 0x00000001,
}

///Defines the states of a cluster shared volume.
alias CLUSTER_SHARED_VOLUME_STATE = int;
enum : int
{
    ///The shared volume is unavailable.
    SharedVolumeStateUnavailable            = 0x00000000,
    ///The shared volume is paused.
    SharedVolumeStatePaused                 = 0x00000001,
    ///The shared volume is active.
    SharedVolumeStateActive                 = 0x00000002,
    SharedVolumeStateActiveRedirected       = 0x00000003,
    SharedVolumeStateActiveVolumeRedirected = 0x00000004,
}

alias CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE = int;
enum : int
{
    ClusterSharedVolumeRenameInputTypeNone         = 0x00000000,
    ClusterSharedVolumeRenameInputTypeVolumeOffset = 0x00000001,
    ClusterSharedVolumeRenameInputTypeVolumeId     = 0x00000002,
    ClusterSharedVolumeRenameInputTypeVolumeName   = 0x00000003,
    ClusterSharedVolumeRenameInputTypeVolumeGuid   = 0x00000004,
}

///Defines the possible states that a storage class resource can be placed in when marked for maintenance.
alias MAINTENANCE_MODE_TYPE_ENUM = int;
enum : int
{
    ///Indicates that the server is ignoring the result of the resource's health check.
    MaintenanceModeTypeDisableIsAliveCheck = 0x00000001,
    ///Indicates that the server has internally performed the operations to bring the storage resource to the
    ///ClusterResourceOffline state without changing the client visible state of the resource.
    MaintenanceModeTypeOfflineResource     = 0x00000002,
    ///Indicates the server has released ownership of the storage resource.
    MaintenanceModeTypeUnclusterResource   = 0x00000003,
}

///When used with the CLUSPROP_DWORD structure, enables or disables the functionality of the EnableNetBIOS property of
///IP Address resources.
alias CLUSPROP_IPADDR_ENABLENETBIOS = int;
enum : int
{
    ///Disable the functionality of the EnableNetBIOS property.
    CLUSPROP_IPADDR_ENABLENETBIOS_DISABLED  = 0x00000000,
    ///Enable the functionality of the EnableNetBIOS property.
    CLUSPROP_IPADDR_ENABLENETBIOS_ENABLED   = 0x00000001,
    ///Enable the functionality of the EnableNetBIOS property if the NIC to which the IP Address resource is bound has
    ///enabled NetBIOS.
    CLUSPROP_IPADDR_ENABLENETBIOS_TRACK_NIC = 0x00000002,
}

///Contains the possible change events that are used by the FILESHARE_CHANGE structure to describe an entry in a file
///share event notification list.
alias FILESHARE_CHANGE_ENUM = int;
enum : int
{
    ///This is a place holder value and is not a valid event.
    FILESHARE_CHANGE_NONE   = 0x00000000,
    ///A new file share resource has been created and will be included with the other file shares managed by the File
    ///Server resource.
    FILESHARE_CHANGE_ADD    = 0x00000001,
    ///A file share resource has been deleted and will be removed from the file shares managed by the File Server
    ///resource.
    FILESHARE_CHANGE_DEL    = 0x00000002,
    ///One or more properties of an existing file share resource have been changed.
    FILESHARE_CHANGE_MODIFY = 0x00000003,
}

///Describes the type of cluster object being enumerated by the ClusterResourceEnum or ClusterResourceOpenEnum
///functions.
alias CLUSTER_RESOURCE_ENUM = int;
enum : int
{
    ///A resource that the resource identified by the ClusterResourceEnum or ClusterResourceOpenEnum functions directly
    ///depends on.
    CLUSTER_RESOURCE_ENUM_DEPENDS  = 0x00000001,
    ///A resource that directly depends on the resource identified by the ClusterResourceEnum or ClusterResourceOpenEnum
    ///functions.
    CLUSTER_RESOURCE_ENUM_PROVIDES = 0x00000002,
    ///A node that can host the resource identified by the ClusterResourceEnum or ClusterResourceOpenEnum functions.
    CLUSTER_RESOURCE_ENUM_NODES    = 0x00000004,
    ///All nodes and resources identified by the ClusterResourceEnum or ClusterResourceOpenEnum functions.
    CLUSTER_RESOURCE_ENUM_ALL      = 0x00000007,
}

///Describes the type of cluster object being enumerated by the ClusterResourceTypeEnum and ClusterResourceTypeOpenEnum
///functions.
alias CLUSTER_RESOURCE_TYPE_ENUM = int;
enum : int
{
    ///The object is a node that can be a possible owner of the resource type.
    CLUSTER_RESOURCE_TYPE_ENUM_NODES     = 0x00000001,
    ///The object is a resource that is an instance of the resource type. <b>Windows Server 2008: </b>This value is not
    ///supported before Windows Server 2008 R2. To emulate this on earlier platforms, enumerate all resources in the
    ///cluster (see the ClusterOpenEnum function) and filter the results using the ResUtilResourceTypesEqual function.
    ///If the call is made on a system without ResUtils.dll, then use the steps mentioned in the Remarks section of the
    ///<b>ResUtilResourceTypesEqual</b> function.
    CLUSTER_RESOURCE_TYPE_ENUM_RESOURCES = 0x00000002,
    ///All cluster objects identified by the ClusterResourceTypeEnum and ClusterResourceTypeOpenEnum functions.
    CLUSTER_RESOURCE_TYPE_ENUM_ALL       = 0x00000003,
}

///Describes the type of cluster object being enumerated by the ClusterNetworkEnum and ClusterNetworkOpenEnum functions.
alias CLUSTER_NETWORK_ENUM = int;
enum : int
{
    ///The object is a network interface.
    CLUSTER_NETWORK_ENUM_NETINTERFACES = 0x00000001,
    ///All cluster objects on the network.
    CLUSTER_NETWORK_ENUM_ALL           = 0x00000001,
}

///Enumerates the possible values of the state of a network.
alias CLUSTER_NETWORK_STATE = int;
enum : int
{
    ///The operation was not successful. For more information about the error, call the function GetLastError.
    ClusterNetworkStateUnknown = 0xffffffff,
    ///All of the network interfaces on the network are unavailable, which means that the nodes that own the network
    ///interfaces are down.
    ClusterNetworkUnavailable  = 0x00000000,
    ///The network is not operational; none of the nodes on the network can communicate.
    ClusterNetworkDown         = 0x00000001,
    ///The network is operational, but two or more nodes on the network cannot communicate. Typically a path-specific
    ///problem has occurred.
    ClusterNetworkPartitioned  = 0x00000002,
    ///The network is operational; all of the nodes in the cluster can communicate.
    ClusterNetworkUp           = 0x00000003,
}

///Describes the role a network plays in the cluster. The network role and DefaultNetworkRole common properties use this
///enumeration. This is a bitmask.
alias CLUSTER_NETWORK_ROLE = int;
enum : int
{
    ///The network is not used by the cluster.
    ClusterNetworkRoleNone              = 0x00000000,
    ///The network is used to carry internal cluster communication.
    ClusterNetworkRoleInternalUse       = 0x00000001,
    ///Not supported.
    ClusterNetworkRoleClientAccess      = 0x00000002,
    ///The network is used to connect client systems and to carry internal cluster communication.
    ClusterNetworkRoleInternalAndClient = 0x00000003,
}

///Enumerates the possible values of the state of a network interface.
alias CLUSTER_NETINTERFACE_STATE = int;
enum : int
{
    ///The operation was not successful. For more information about the error, call the function GetLastError.
    ClusterNetInterfaceStateUnknown = 0xffffffff,
    ///The node that owns the network interface is down.
    ClusterNetInterfaceUnavailable  = 0x00000000,
    ///The network interface cannot communicate with any other network interface.
    ClusterNetInterfaceFailed       = 0x00000001,
    ///The network interface cannot communicate with at least one other network interface whose state is not
    ///<b>ClusterNetInterfaceFailed</b> or <b>ClusterNetInterfaceUnavailable</b>.
    ClusterNetInterfaceUnreachable  = 0x00000002,
    ///The network interface can communicate with all other network interfaces whose state is not
    ///<b>ClusterNetInterfaceFailed</b> or <b>ClusterNetInterfaceUnavailable</b>.
    ClusterNetInterfaceUp           = 0x00000003,
}

///Used by the ClusterSetupProgressCallback function to identify the current phase of the cluster setup process.
alias CLUSTER_SETUP_PHASE = int;
enum : int
{
    ///Initialize cluster setup.
    ClusterSetupPhaseInitialize                 = 0x00000001,
    ///Validate cluster nodes.
    ClusterSetupPhaseValidateNodeState          = 0x00000064,
    ///Validate cluster networks.
    ClusterSetupPhaseValidateNetft              = 0x00000066,
    ///Validate cluster disks.
    ClusterSetupPhaseValidateClusDisk           = 0x00000067,
    ///Configure cluster service.
    ClusterSetupPhaseConfigureClusSvc           = 0x00000068,
    ///Start cluster service.
    ClusterSetupPhaseStartingClusSvc            = 0x00000069,
    ///Query cluster name.
    ClusterSetupPhaseQueryClusterNameAccount    = 0x0000006a,
    ///Validate cluster name.
    ClusterSetupPhaseValidateClusterNameAccount = 0x0000006b,
    ///Create cluster account.
    ClusterSetupPhaseCreateClusterAccount       = 0x0000006c,
    ///Configure cluster account.
    ClusterSetupPhaseConfigureClusterAccount    = 0x0000006d,
    ///Form the cluster.
    ClusterSetupPhaseFormingCluster             = 0x000000c8,
    ///Add properties to cluster.
    ClusterSetupPhaseAddClusterProperties       = 0x000000c9,
    ///Create resource types.
    ClusterSetupPhaseCreateResourceTypes        = 0x000000ca,
    ///Create resource groups.
    ClusterSetupPhaseCreateGroups               = 0x000000cb,
    ///Create IP address resources.
    ClusterSetupPhaseCreateIPAddressResources   = 0x000000cc,
    ///Create network name.
    ClusterSetupPhaseCreateNetworkName          = 0x000000cd,
    ///Bring cluster groups online.
    ClusterSetupPhaseClusterGroupOnline         = 0x000000ce,
    ///Get current cluster membership.
    ClusterSetupPhaseGettingCurrentMembership   = 0x0000012c,
    ///Add node to cluster membership.
    ClusterSetupPhaseAddNodeToCluster           = 0x0000012d,
    ///Start node.
    ClusterSetupPhaseNodeUp                     = 0x0000012e,
    ///Move group to another node.
    ClusterSetupPhaseMoveGroup                  = 0x00000190,
    ///Delete group from cluster.
    ClusterSetupPhaseDeleteGroup                = 0x00000191,
    ///Clean up offline group.
    ClusterSetupPhaseCleanupCOs                 = 0x00000192,
    ///Move group offline.
    ClusterSetupPhaseOfflineGroup               = 0x00000193,
    ///Remove a node from the cluster.
    ClusterSetupPhaseEvictNode                  = 0x00000194,
    ///Return node to pre-clustered state.
    ClusterSetupPhaseCleanupNode                = 0x00000195,
    ///Return core resource group to pre-clustered state.
    ClusterSetupPhaseCoreGroupCleanup           = 0x00000196,
    ///Return failed resource to pre-clustered state.
    ClusterSetupPhaseFailureCleanup             = 0x000003e7,
}

///Describes the progress of the cluster setup process. The ClusterSetupProgressCallback function uses this enumeration.
///The values of the CLUSTER_SETUP_PHASE enumeration identify the current phase of the cluster setup process. The values
///of the CLUSTER_SETUP_PHASE_SEVERITY enumeration describe the severity of the cluster setup process.
alias CLUSTER_SETUP_PHASE_TYPE = int;
enum : int
{
    ///Indicates the start of a new setup phase.
    ClusterSetupPhaseStart    = 0x00000001,
    ///Indicates the continuation of a setup phase.
    ClusterSetupPhaseContinue = 0x00000002,
    ///Indicates the end of a setup phase. Called once at the end of every setup phase.
    ClusterSetupPhaseEnd      = 0x00000003,
    ClusterSetupPhaseReport   = 0x00000004,
}

///Describes the severity of the current phase of the cluster setup process. The ClusterSetupProgressCallback function
///uses this enumeration.
alias CLUSTER_SETUP_PHASE_SEVERITY = int;
enum : int
{
    ///This phase of the cluster setup can complete successfully.
    ClusterSetupPhaseInformational = 0x00000001,
    ///This phase of the cluster setup can complete, with a warning.
    ClusterSetupPhaseWarning       = 0x00000002,
    ///This phase of the cluster setup process cannot complete successfully.
    ClusterSetupPhaseFatal         = 0x00000003,
}

///Defines options for placing the cluster. This enumeration contains the values for the PlacementOptions property.
alias PLACEMENT_OPTIONS = int;
enum : int
{
    ///Minimum value
    PLACEMENT_OPTIONS_MIN_VALUE                                                   = 0x00000000,
    ///Default value
    PLACEMENT_OPTIONS_DEFAULT_PLACEMENT_OPTIONS                                   = 0x00000000,
    ///Disable VM cependency
    PLACEMENT_OPTIONS_DISABLE_CSV_VM_DEPENDENCY                                   = 0x00000001,
    ///Consider offline VMS
    PLACEMENT_OPTIONS_CONSIDER_OFFLINE_VMS                                        = 0x00000002,
    ///Don't use memory
    PLACEMENT_OPTIONS_DONT_USE_MEMORY                                             = 0x00000004,
    ///Don't use CPU
    PLACEMENT_OPTIONS_DONT_USE_CPU                                                = 0x00000008,
    PLACEMENT_OPTIONS_DONT_USE_LOCAL_TEMP_DISK                                    = 0x00000010,
    PLACEMENT_OPTIONS_DONT_RESUME_VMS_WITH_EXISTING_TEMP_DISK                     = 0x00000020,
    PLACEMENT_OPTIONS_SAVE_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE                 = 0x00000040,
    PLACEMENT_OPTIONS_DONT_RESUME_AVAILABILTY_SET_VMS_WITH_EXISTING_TEMP_DISK     = 0x00000080,
    PLACEMENT_OPTIONS_SAVE_AVAILABILTY_SET_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE = 0x00000100,
    PLACEMENT_OPTIONS_AVAILABILITY_SET_DOMAIN_AFFINITY                            = 0x00000200,
    ///Maximum value
    PLACEMENT_OPTIONS_ALL                                                         = 0x000003ff,
}

alias GRP_PLACEMENT_OPTIONS = int;
enum : int
{
    GRP_PLACEMENT_OPTIONS_MIN_VALUE             = 0x00000000,
    GRP_PLACEMENT_OPTIONS_DEFAULT               = 0x00000000,
    GRP_PLACEMENT_OPTIONS_DISABLE_AUTOBALANCING = 0x00000001,
    GRP_PLACEMENT_OPTIONS_ALL                   = 0x00000001,
}

///Specifies the replicated disk types for the SR_RESOURCE_TYPE_REPLICATED_DISK structure.
alias SR_REPLICATED_DISK_TYPE = int;
enum : int
{
    ///None.
    SrReplicatedDiskTypeNone                = 0x00000000,
    ///The source of replication.
    SrReplicatedDiskTypeSource              = 0x00000001,
    ///A log disk that is the source of replication.
    SrReplicatedDiskTypeLogSource           = 0x00000002,
    ///The destination of replication.
    SrReplicatedDiskTypeDestination         = 0x00000003,
    ///A log disk that is the destination of replication.
    SrReplicatedDiskTypeLogDestination      = 0x00000004,
    ///The disk is not in a replication partnership.
    SrReplicatedDiskTypeNotInParthership    = 0x00000005,
    ///A log disk that is not in a replication partnership.
    SrReplicatedDiskTypeLogNotInParthership = 0x00000006,
    ///Other.
    SrReplicatedDiskTypeOther               = 0x00000007,
}

///Specifies the various reasons a disk on a cluster node can be eligible or ineligible for replication.
alias SR_DISK_REPLICATION_ELIGIBLE = int;
enum : int
{
    ///None of the disks on the node are eligible for replication.
    SrDiskReplicationEligibleNone                    = 0x00000000,
    ///The disk is eligible for replication.
    SrDiskReplicationEligibleYes                     = 0x00000001,
    ///The disk is offline.
    SrDiskReplicationEligibleOffline                 = 0x00000002,
    ///The disk is not formatted with a GUID partition table (GPT).
    SrDiskReplicationEligibleNotGpt                  = 0x00000003,
    ///There are a different number of target and source partitions.
    SrDiskReplicationEligiblePartitionLayoutMismatch = 0x00000004,
    ///There is not enough free space on the disk.
    SrDiskReplicationEligibleInsufficientFreeSpace   = 0x00000005,
    ///The disk is not on the same site at the target disk.
    SrDiskReplicationEligibleNotInSameSite           = 0x00000006,
    ///The disk is on the same site as the target disk.
    SrDiskReplicationEligibleInSameSite              = 0x00000007,
    ///The file system on the disk is not supported.
    SrDiskReplicationEligibleFileSystemNotSupported  = 0x00000008,
    ///The disk is already being replicated.
    SrDiskReplicationEligibleAlreadyInReplication    = 0x00000009,
    ///The disk is the target disk.
    SrDiskReplicationEligibleSameAsSpecifiedDisk     = 0x0000000a,
    ///Other.
    SrDiskReplicationEligibleOther                   = 0x0000270f,
}

///Contains actions for a virtual machine to perform.
alias VM_RESDLL_CONTEXT = int;
enum : int
{
    ///Turns off the virtual machine.
    VmResdllContextTurnOff       = 0x00000000,
    ///Saves the virtual machine.
    VmResdllContextSave          = 0x00000001,
    ///Shuts down the virtual machine.
    VmResdllContextShutdown      = 0x00000002,
    ///Forces a shutdown of the virtual machine.
    VmResdllContextShutdownForce = 0x00000003,
    ///Performs a live migration of the virtual machine.
    VmResdllContextLiveMigration = 0x00000004,
}

///Specifies the various types of context operations for the GET_OPERATION_CONTEXT_PARAMS structure.
alias RESDLL_CONTEXT_OPERATION_TYPE = int;
enum : int
{
    ///A group fail back.
    ResdllContextOperationTypeFailback                   = 0x00000000,
    ///A node drain.
    ResdllContextOperationTypeDrain                      = 0x00000001,
    ///A node drain failure.
    ResdllContextOperationTypeDrainFailure               = 0x00000002,
    ///An embedded failure.
    ResdllContextOperationTypeEmbeddedFailure            = 0x00000003,
    ///A preemption failure.
    ResdllContextOperationTypePreemption                 = 0x00000004,
    ///A network connection failure. <b>Windows Server 2012: </b>This value is not supported before Windows Server 2012
    ///R2.
    ResdllContextOperationTypeNetworkDisconnect          = 0x00000005,
    ///A network connection was disconnected and it is being re-established. <b>Windows Server 2012: </b>This value is
    ///not supported before Windows Server 2012 R2.
    ResdllContextOperationTypeNetworkDisconnectMoveRetry = 0x00000006,
}

///Represents the severity of the log event passed to the LogEvent callback function.
alias LOG_LEVEL = int;
enum : int
{
    ///The event is informational.
    LOG_INFORMATION = 0x00000000,
    ///The event is reporting a failure that might have happened, but it is uncertain whether a failure really did
    ///occur.
    LOG_WARNING     = 0x00000001,
    ///The event affects a single component, but other components are not affected and the integrity of the rest of the
    ///node is not compromised.
    LOG_ERROR       = 0x00000002,
    ///The event is reporting a severe failure that affects multiple components, or the integrity of the entire system
    ///is compromised or believed to be compromised.
    LOG_SEVERE      = 0x00000003,
}

///Enumerates the possible exit states of a resource. These values are returned by the SetResourceStatus callback
///function.
alias RESOURCE_EXIT_STATE = int;
enum : int
{
    ///The resource has not been terminated. Worker threads may continue Online and Offline operations for the resource.
    ResourceExitStateContinue  = 0x00000000,
    ///The resource has been terminated. Callers should end Online or Offline operations and immediately terminate all
    ///worker threads assigned to the resource.
    ResourceExitStateTerminate = 0x00000001,
    ///This value is only used for comparisons. All supported values are less than <b>ResourceExitStateMax</b>.
    ResourceExitStateMax       = 0x00000002,
}

///Defines the failure types for cluster resources.
alias FAILURE_TYPE = int;
enum : int
{
    ///A general failure.
    FAILURE_TYPE_GENERAL      = 0x00000000,
    ///An embedded failure.
    FAILURE_TYPE_EMBEDDED     = 0x00000001,
    ///A network failure.
    FAILURE_TYPE_NETWORK_LOSS = 0x00000002,
}

///Enumerates resource application states.
alias CLUSTER_RESOURCE_APPLICATION_STATE = int;
enum : int
{
    ///Application state is unknown.
    ClusterResourceApplicationStateUnknown = 0x00000001,
    ///Application OSHeartBeat is detected.
    ClusterResourceApplicationOSHeartBeat  = 0x00000002,
    ///Application is ready.
    ClusterResourceApplicationReady        = 0x00000003,
}

///TBD
alias RESOURCE_MONITOR_STATE = int;
enum : int
{
    RmonInitializing         = 0x00000000,
    RmonIdle                 = 0x00000001,
    RmonStartingResource     = 0x00000002,
    RmonInitializingResource = 0x00000003,
    RmonOnlineResource       = 0x00000004,
    RmonOfflineResource      = 0x00000005,
    RmonShutdownResource     = 0x00000006,
    RmonDeletingResource     = 0x00000007,
    RmonIsAlivePoll          = 0x00000008,
    RmonLooksAlivePoll       = 0x00000009,
    RmonArbitrateResource    = 0x0000000a,
    RmonReleaseResource      = 0x0000000b,
    RmonResourceControl      = 0x0000000c,
    RmonResourceTypeControl  = 0x0000000d,
    RmonTerminateResource    = 0x0000000e,
    RmonDeadlocked           = 0x0000000f,
}

///Contains the names of the standard cluster roles.
alias CLUSTER_ROLE = int;
enum : int
{
    ///The DHCP cluster role.
    ClusterRoleDHCP                        = 0x00000000,
    ///The Distributed Transaction Coordinator (MSDTC) role.
    ClusterRoleDTC                         = 0x00000001,
    ///The file share role.
    ClusterRoleFileServer                  = 0x00000002,
    ///The Generic Application role.
    ClusterRoleGenericApplication          = 0x00000003,
    ///The Generic Script role.
    ClusterRoleGenericScript               = 0x00000004,
    ///The Generic Service role.
    ClusterRoleGenericService              = 0x00000005,
    ///The Microsoft Internet Storage Name Service (iSNS) role.
    ClusterRoleISCSINameServer             = 0x00000006,
    ///The Microsoft Message Queue role.
    ClusterRoleMSMQ                        = 0x00000007,
    ///The Network File System (NFS) Share role.
    ClusterRoleNFS                         = 0x00000008,
    ///The Print Spooler cluster role.
    ClusterRolePrintServer                 = 0x00000009,
    ///The specialized File Share role.
    ClusterRoleStandAloneNamespaceServer   = 0x0000000a,
    ///The Volume Shadow Copy Service Task role.
    ClusterRoleVolumeShadowCopyServiceTask = 0x0000000b,
    ///The WINS Service role.
    ClusterRoleWINS                        = 0x0000000c,
    ///The Task Scheduler role.
    ClusterRoleTaskScheduler               = 0x0000000d,
    ///The network file system role.
    ClusterRoleNetworkFileSystem           = 0x0000000e,
    ///The Distributed File System (DFS) replicated folder role.
    ClusterRoleDFSReplicatedFolder         = 0x0000000f,
    ///The Distributed File System (DFS) role.
    ClusterRoleDistributedFileSystem       = 0x00000010,
    ///The Distributed Network Name role.
    ClusterRoleDistributedNetworkName      = 0x00000011,
    ///The file share role.
    ClusterRoleFileShare                   = 0x00000012,
    ///The file share witness role
    ClusterRoleFileShareWitness            = 0x00000013,
    ///The hard disk role.
    ClusterRoleHardDisk                    = 0x00000014,
    ///The IP address role.
    ClusterRoleIPAddress                   = 0x00000015,
    ///The IPV6 address role.
    ClusterRoleIPV6Address                 = 0x00000016,
    ///The IPV6 tunnel address role.
    ClusterRoleIPV6TunnelAddress           = 0x00000017,
    ///The ISCSI Target Server role.
    ClusterRoleISCSITargetServer           = 0x00000018,
    ///The Network Name role.
    ClusterRoleNetworkName                 = 0x00000019,
    ///The physical disk role.
    ClusterRolePhysicalDisk                = 0x0000001a,
    ///The Scale-Out (SODA) File Server role
    ClusterRoleSODAFileServer              = 0x0000001b,
    ///The storage pool role.
    ClusterRoleStoragePool                 = 0x0000001c,
    ///The virtual machine role.
    ClusterRoleVirtualMachine              = 0x0000001d,
    ///The virtual machine configuration role.
    ClusterRoleVirtualMachineConfiguration = 0x0000001e,
    ///The virtual machine replica broker role.
    ClusterRoleVirtualMachineReplicaBroker = 0x0000001f,
}

///Defines the potential return values for the ResUtilGetClusterRoleState function.
alias CLUSTER_ROLE_STATE = int;
enum : int
{
    ///It is unknown whether or not the role is clustered.
    ClusterRoleUnknown     = 0xffffffff,
    ///The role is clustered.
    ClusterRoleClustered   = 0x00000000,
    ///The role is not clustered.
    ClusterRoleUnclustered = 0x00000001,
}

alias CLUADMEX_OBJECT_TYPE = int;
enum : int
{
    CLUADMEX_OT_NONE         = 0x00000000,
    CLUADMEX_OT_CLUSTER      = 0x00000001,
    CLUADMEX_OT_NODE         = 0x00000002,
    CLUADMEX_OT_GROUP        = 0x00000003,
    CLUADMEX_OT_RESOURCE     = 0x00000004,
    CLUADMEX_OT_RESOURCETYPE = 0x00000005,
    CLUADMEX_OT_NETWORK      = 0x00000006,
    CLUADMEX_OT_NETINTERFACE = 0x00000007,
}

// Callbacks

alias PCLUSAPI_GET_NODE_CLUSTER_STATE = uint function(const(PWSTR) lpszNodeName, uint* pdwClusterState);
alias PCLUSAPI_OPEN_CLUSTER = _HCLUSTER* function(const(PWSTR) lpszClusterName);
alias PCLUSAPI_OPEN_CLUSTER_EX = _HCLUSTER* function(const(PWSTR) lpszClusterName, uint dwDesiredAccess, 
                                                     uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER = BOOL function(_HCLUSTER* hCluster);
alias PCLUSAPI_SetClusterName = uint function(_HCLUSTER* hCluster, const(PWSTR) lpszNewClusterName);
alias PCLUSAPI_GET_CLUSTER_INFORMATION = uint function(_HCLUSTER* hCluster, PWSTR lpszClusterName, 
                                                       uint* lpcchClusterName, CLUSTERVERSIONINFO* lpClusterInfo);
alias PCLUSAPI_GET_CLUSTER_QUORUM_RESOURCE = uint function(_HCLUSTER* hCluster, PWSTR lpszResourceName, 
                                                           uint* lpcchResourceName, PWSTR lpszDeviceName, 
                                                           uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);
alias PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE = uint function(_HRESOURCE* hResource, const(PWSTR) lpszDeviceName, 
                                                           uint dwMaxQuoLogSize);
alias PCLUSAPI_BACKUP_CLUSTER_DATABASE = uint function(_HCLUSTER* hCluster, const(PWSTR) lpszPathName);
alias PCLUSAPI_RESTORE_CLUSTER_DATABASE = uint function(const(PWSTR) lpszPathName, BOOL bForce, 
                                                        const(PWSTR) lpszQuorumDriveLetter);
alias PCLUSAPI_SET_CLUSTER_NETWORK_PRIORITY_ORDER = uint function(_HCLUSTER* hCluster, uint NetworkCount, 
                                                                  _HNETWORK** NetworkList);
alias PCLUSAPI_SET_CLUSTER_SERVICE_ACCOUNT_PASSWORD = uint function(const(PWSTR) lpszClusterName, 
                                                                    const(PWSTR) lpszNewPassword, uint dwFlags, 
                                                                    CLUSTER_SET_PASSWORD_STATUS* lpReturnStatusBuffer, 
                                                                    uint* lpcbReturnStatusBufferSize);
alias PCLUSAPI_CLUSTER_CONTROL = uint function(_HCLUSTER* hCluster, _HNODE* hHostNode, uint dwControlCode, 
                                               void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, 
                                               uint nOutBufferSize, uint* lpBytesReturned);
///Retrieves status information for a rolling upgrade of the operating system on a cluster.
///<b>PCLUSTER_UPGRADE_PROGRESS_CALLBACK</b> type defines a pointer to this function.
///Params:
///    pvCallbackArg = A pointer to the arguments.
///    eUpgradePhase = A CLUSTER_UPGRADE_PHASE enumeration values that indicates the state of the rolling upgrade.
///Returns:
///    This function returns one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The operation was not
///    successful. </td> </tr> </table>
///    
alias PCLUSTER_UPGRADE_PROGRESS_CALLBACK = BOOL function(void* pvCallbackArg, CLUSTER_UPGRADE_PHASE eUpgradePhase);
alias PCLUSAPI_CLUSTER_UPGRADE = uint function(_HCLUSTER* hCluster, BOOL perform, 
                                               PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, 
                                               void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT_V2 = _HCHANGE* function(_HCHANGE* hChange, _HCLUSTER* hCluster, 
                                                                  NOTIFY_FILTER_AND_TYPE* Filters, 
                                                                  uint dwFilterCount, size_t dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY_V2 = uint function(_HCHANGE* hChange, NOTIFY_FILTER_AND_TYPE Filter, 
                                                          HANDLE hObject, size_t dwNotifyKey);
alias PCLUSAPI_GET_NOTIFY_EVENT_HANDLE_V2 = uint function(_HCHANGE* hChange, HANDLE* lphTargetEvent);
alias PCLUSAPI_GET_CLUSTER_NOTIFY_V2 = uint function(_HCHANGE* hChange, size_t* lpdwNotifyKey, 
                                                     NOTIFY_FILTER_AND_TYPE* pFilterAndType, ubyte* buffer, 
                                                     uint* lpcchBufferSize, PWSTR lpszObjectId, uint* lpcchObjectId, 
                                                     PWSTR lpszParentId, uint* lpcchParentId, PWSTR lpszName, 
                                                     uint* lpcchName, PWSTR lpszType, uint* lpcchType, 
                                                     uint dwMilliseconds);
alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT = _HCHANGE* function(_HCHANGE* hChange, _HCLUSTER* hCluster, 
                                                               uint dwFilter, size_t dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY = uint function(_HCHANGE* hChange, uint dwFilterType, HANDLE hObject, 
                                                       size_t dwNotifyKey);
alias PCLUSAPI_GET_CLUSTER_NOTIFY = uint function(_HCHANGE* hChange, size_t* lpdwNotifyKey, uint* lpdwFilterType, 
                                                  PWSTR lpszName, uint* lpcchName, uint dwMilliseconds);
alias PCLUSAPI_CLOSE_CLUSTER_NOTIFY_PORT = BOOL function(_HCHANGE* hChange);
alias PCLUSAPI_CLUSTER_OPEN_ENUM = _HCLUSENUM* function(_HCLUSTER* hCluster, uint dwType);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT = uint function(_HCLUSENUM* hEnum);
alias PCLUSAPI_CLUSTER_ENUM = uint function(_HCLUSENUM* hEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, 
                                            uint* lpcchName);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM = uint function(_HCLUSENUM* hEnum);
alias PCLUSAPI_CLUSTER_OPEN_ENUM_EX = _HCLUSENUMEX* function(_HCLUSTER* hCluster, uint dwType, void* pOptions);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT_EX = uint function(_HCLUSENUMEX* hClusterEnum);
alias PCLUSAPI_CLUSTER_ENUM_EX = uint function(_HCLUSENUMEX* hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, 
                                               uint* cbItem);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM_EX = uint function(_HCLUSENUMEX* hClusterEnum);
alias PCLUSAPI_CREATE_CLUSTER_GROUP_GROUPSET = _HGROUPSET* function(_HCLUSTER* hCluster, 
                                                                    const(PWSTR) lpszGroupSetName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_GROUPSET = _HGROUPSET* function(_HCLUSTER* hCluster, 
                                                                  const(PWSTR) lpszGroupSetName);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP_GROUPSET = BOOL function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_DELETE_CLUSTER_GROUP_GROUPSET = uint function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_GROUP_GROUPSET = uint function(_HGROUPSET* hGroupSet, _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_GROUP_GROUPSET = uint function(_HGROUPSET* hGroupSet, _HGROUP* hGroupName);
alias PCLUSAPI_CLUSTER_GROUP_GROUPSET_CONTROL = uint function(_HGROUPSET* hGroupSet, _HNODE* hHostNode, 
                                                              uint dwControlCode, void* lpInBuffer, 
                                                              uint cbInBufferSize, void* lpOutBuffer, 
                                                              uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_ADD_CLUSTER_GROUP_DEPENDENCY = uint function(_HGROUP* hDependentGroup, _HGROUP* hProviderGroup);
alias PCLUSAPI_SET_GROUP_DEPENDENCY_EXPRESSION = uint function(_HGROUP* hGroupSet, 
                                                               const(PWSTR) lpszDependencyExpression);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_DEPENDENCY = uint function(_HGROUP* hGroup, _HGROUP* hDependsOn);
alias PCLUSAPI_ADD_CLUSTER_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hDependentGroupSet, 
                                                                     _HGROUPSET* hProviderGroupSet);
alias PCLUSAPI_SET_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EXPRESSION = uint function(_HGROUPSET* hGroupSet, 
                                                                                const(PWSTR) lpszDependencyExpression);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hGroupSet, 
                                                                        _HGROUPSET* hDependsOn);
alias PCLUSAPI_ADD_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUP* hDependentGroup, 
                                                                              _HGROUPSET* hProviderGroupSet);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUP* hGroup, 
                                                                                 _HGROUPSET* hDependsOn);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP_GROUPSET = _HCLUSTER* function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_ADD_CROSS_CLUSTER_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hDependentGroupSet, 
                                                                     const(PWSTR) lpRemoteClusterName, 
                                                                     const(PWSTR) lpRemoteGroupSetName);
alias PCLUSAPI_REMOVE_CROSS_CLUSTER_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hDependentGroupSet, 
                                                                        const(PWSTR) lpRemoteClusterName, 
                                                                        const(PWSTR) lpRemoteGroupSetName);
alias PCLUSAPI_CREATE_CLUSTER_AVAILABILITY_SET = _HGROUPSET* function(_HCLUSTER* hCluster, 
                                                                      const(PWSTR) lpAvailabilitySetName, 
                                                                      CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);
alias PCLUSAPI_CLUSTER_CREATE_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(PWSTR) ruleName, 
                                                            CLUS_AFFINITY_RULE_TYPE ruleType);
alias PCLUSAPI_CLUSTER_REMOVE_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(PWSTR) ruleName);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(PWSTR) ruleName, 
                                                                  _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(PWSTR) ruleName, 
                                                                       _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_AFFINITY_RULE_CONTROL = uint function(_HCLUSTER* hCluster, const(PWSTR) affinityRuleName, 
                                                             _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, 
                                                             uint cbInBufferSize, void* lpOutBuffer, 
                                                             uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_OPEN_CLUSTER_NODE = _HNODE* function(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName);
alias PCLUSAPI_OPEN_CLUSTER_NODE_EX = _HNODE* function(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, 
                                                       uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_OPEN_NODE_BY_ID = _HNODE* function(_HCLUSTER* hCluster, uint nodeId);
alias PCLUSAPI_CLOSE_CLUSTER_NODE = BOOL function(_HNODE* hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_STATE = CLUSTER_NODE_STATE function(_HNODE* hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_ID = uint function(_HNODE* hNode, PWSTR lpszNodeId, uint* lpcchName);
alias PCLUSAPI_GET_CLUSTER_FROM_NODE = _HCLUSTER* function(_HNODE* hNode);
alias PCLUSAPI_PAUSE_CLUSTER_NODE = uint function(_HNODE* hNode);
alias PCLUSAPI_RESUME_CLUSTER_NODE = uint function(_HNODE* hNode);
alias PCLUSAPI_EVICT_CLUSTER_NODE = uint function(_HNODE* hNode);
alias PCLUSAPI_CLUSTER_NODE_OPEN_ENUM = _HNODEENUM* function(_HNODE* hNode, uint dwType);
alias PCLUSAPI_CLUSTER_NODE_OPEN_ENUM_EX = _HNODEENUMEX* function(_HNODE* hNode, uint dwType, void* pOptions);
alias PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT_EX = uint function(_HNODEENUMEX* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_ENUM_EX = uint function(_HNODEENUMEX* hNodeEnum, uint dwIndex, 
                                                    CLUSTER_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM_EX = uint function(_HNODEENUMEX* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT = uint function(_HNODEENUM* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM = uint function(_HNODEENUM* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_ENUM = uint function(_HNODEENUM* hNodeEnum, uint dwIndex, uint* lpdwType, 
                                                 PWSTR lpszName, uint* lpcchName);
alias PCLUSAPI_EVICT_CLUSTER_NODE_EX = uint function(_HNODE* hNode, uint dwTimeOut, HRESULT* phrCleanupStatus);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_TYPE_KEY = HKEY function(_HCLUSTER* hCluster, const(PWSTR) lpszTypeName, 
                                                             uint samDesired);
alias PCLUSAPI_CREATE_CLUSTER_GROUP = _HGROUP* function(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP = _HGROUP* function(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_EX = _HGROUP* function(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName, 
                                                         uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_PAUSE_CLUSTER_NODE_EX = uint function(_HNODE* hNode, BOOL bDrainNode, uint dwPauseFlags, 
                                                     _HNODE* hNodeDrainTarget);
alias PCLUSAPI_RESUME_CLUSTER_NODE_EX = uint function(_HNODE* hNode, 
                                                      CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                                                      uint dwResumeFlagsReserved);
alias PCLUSAPI_CREATE_CLUSTER_GROUPEX = _HGROUP* function(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName, 
                                                          CLUSTER_CREATE_GROUP_INFO* pGroupInfo);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM_EX = _HGROUPENUMEX* function(_HCLUSTER* hCluster, 
                                                                    const(PWSTR) lpszProperties, uint cbProperties, 
                                                                    const(PWSTR) lpszRoProperties, 
                                                                    uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT_EX = uint function(_HGROUPENUMEX* hGroupEnumEx);
alias PCLUSAPI_CLUSTER_GROUP_ENUM_EX = uint function(_HGROUPENUMEX* hGroupEnumEx, uint dwIndex, 
                                                     CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM_EX = uint function(_HGROUPENUMEX* hGroupEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM_EX = _HRESENUMEX* function(_HCLUSTER* hCluster, 
                                                                     const(PWSTR) lpszProperties, uint cbProperties, 
                                                                     const(PWSTR) lpszRoProperties, 
                                                                     uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT_EX = uint function(_HRESENUMEX* hResourceEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM_EX = uint function(_HRESENUMEX* hResourceEnumEx, uint dwIndex, 
                                                        CLUSTER_RESOURCE_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM_EX = uint function(_HRESENUMEX* hResourceEnumEx);
alias PCLUSAPI_RESTART_CLUSTER_RESOURCE = uint function(_HRESOURCE* hResource, uint dwFlags);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP = BOOL function(_HGROUP* hGroup);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP = _HCLUSTER* function(_HGROUP* hGroup);
alias PCLUSAPI_GET_CLUSTER_GROUP_STATE = CLUSTER_GROUP_STATE function(_HGROUP* hGroup, PWSTR lpszNodeName, 
                                                                      uint* lpcchNodeName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NAME = uint function(_HGROUP* hGroup, const(PWSTR) lpszGroupName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST = uint function(_HGROUP* hGroup, uint NodeCount, _HNODE** NodeList);
alias PCLUSAPI_ONLINE_CLUSTER_GROUP = uint function(_HGROUP* hGroup, _HNODE* hDestinationNode);
alias PCLUSAPI_MOVE_CLUSTER_GROUP = uint function(_HGROUP* hGroup, _HNODE* hDestinationNode);
alias PCLUSAPI_OFFLINE_CLUSTER_GROUP = uint function(_HGROUP* hGroup);
alias PCLUSAPI_DELETE_CLUSTER_GROUP = uint function(_HGROUP* hGroup);
alias PCLUSAPI_DESTROY_CLUSTER_GROUP = uint function(_HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM = _HGROUPENUM* function(_HGROUP* hGroup, uint dwType);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT = uint function(_HGROUPENUM* hGroupEnum);
alias PCLUSAPI_CLUSTER_GROUP_ENUM = uint function(_HGROUPENUM* hGroupEnum, uint dwIndex, uint* lpdwType, 
                                                  PWSTR lpszResourceName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM = uint function(_HGROUPENUM* hGroupEnum);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE = _HRESOURCE* function(_HGROUP* hGroup, const(PWSTR) lpszResourceName, 
                                                              const(PWSTR) lpszResourceType, uint dwFlags);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE = _HRESOURCE* function(_HCLUSTER* hCluster, const(PWSTR) lpszResourceName);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE_EX = _HRESOURCE* function(_HCLUSTER* hCluster, const(PWSTR) lpszResourceName, 
                                                               uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_RESOURCE = BOOL function(_HRESOURCE* hResource);
alias PCLUSAPI_GET_CLUSTER_FROM_RESOURCE = _HCLUSTER* function(_HRESOURCE* hResource);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_STATE = CLUSTER_RESOURCE_STATE function(_HRESOURCE* hResource, 
                                                                            PWSTR lpszNodeName, uint* lpcchNodeName, 
                                                                            PWSTR lpszGroupName, 
                                                                            uint* lpcchGroupName);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_NAME = uint function(_HRESOURCE* hResource, const(PWSTR) lpszResourceName);
alias PCLUSAPI_FAIL_CLUSTER_RESOURCE = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_ONLINE_CLUSTER_RESOURCE = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_OFFLINE_CLUSTER_RESOURCE = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP = uint function(_HRESOURCE* hResource, _HGROUP* hGroup);
alias PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP_EX = uint function(_HRESOURCE* hResource, _HGROUP* hGroup, 
                                                                ulong Flags);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_NODE = uint function(_HRESOURCE* hResource, _HNODE* hNode);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_NODE = uint function(_HRESOURCE* hResource, _HNODE* hNode);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_DEPENDENCY = uint function(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_DEPENDENCY = uint function(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION = uint function(_HRESOURCE* hResource, 
                                                                          const(PWSTR) lpszDependencyExpression);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION = uint function(_HRESOURCE* hResource, 
                                                                          PWSTR lpszDependencyExpression, 
                                                                          uint* lpcchDependencyExpression);
alias PCLUSAPI_ADD_RESOURCE_TO_CLUSTER_SHARED_VOLUMES = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_REMOVE_RESOURCE_FROM_CLUSTER_SHARED_VOLUMES = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_IS_FILE_ON_CLUSTER_SHARED_VOLUME = uint function(const(PWSTR) lpszPathName, 
                                                                BOOL* pbFileIsOnSharedVolume);
alias PCLUSAPI_SHARED_VOLUME_SET_SNAPSHOT_STATE = uint function(GUID guidSnapshotSet, const(PWSTR) lpszVolumeName, 
                                                                CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);
alias PCLUSAPI_CAN_RESOURCE_BE_DEPENDENT = BOOL function(_HRESOURCE* hResource, _HRESOURCE* hResourceDependent);
alias PCLUSAPI_CLUSTER_RESOURCE_CONTROL = uint function(_HRESOURCE* hResource, _HNODE* hHostNode, 
                                                        uint dwControlCode, void* lpInBuffer, uint cbInBufferSize, 
                                                        void* lpOutBuffer, uint cbOutBufferSize, 
                                                        uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL = uint function(_HCLUSTER* hCluster, 
                                                             const(PWSTR) lpszResourceTypeName, _HNODE* hHostNode, 
                                                             uint dwControlCode, void* lpInBuffer, 
                                                             uint nInBufferSize, void* lpOutBuffer, 
                                                             uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_GROUP_CONTROL = uint function(_HGROUP* hGroup, _HNODE* hHostNode, uint dwControlCode, 
                                                     void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, 
                                                     uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_NODE_CONTROL = uint function(_HNODE* hNode, _HNODE* hHostNode, uint dwControlCode, 
                                                    void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, 
                                                    uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_NETWORK_NAME = BOOL function(_HRESOURCE* hResource, PWSTR lpBuffer, 
                                                                 uint* nSize);
alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM = _HRESENUM* function(_HRESOURCE* hResource, uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT = uint function(_HRESENUM* hResEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM = uint function(_HRESENUM* hResEnum, uint dwIndex, uint* lpdwType, 
                                                     PWSTR lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM = uint function(_HRESENUM* hResEnum);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE = uint function(_HCLUSTER* hCluster, const(PWSTR) lpszResourceTypeName, 
                                                            const(PWSTR) lpszDisplayName, 
                                                            const(PWSTR) lpszResourceTypeDll, 
                                                            uint dwLooksAlivePollInterval, 
                                                            uint dwIsAlivePollInterval);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE = uint function(_HCLUSTER* hCluster, const(PWSTR) lpszResourceTypeName);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_OPEN_ENUM = _HRESTYPEENUM* function(_HCLUSTER* hCluster, 
                                                                         const(PWSTR) lpszResourceTypeName, 
                                                                         uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_GET_ENUM_COUNT = uint function(_HRESTYPEENUM* hResTypeEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_ENUM = uint function(_HRESTYPEENUM* hResTypeEnum, uint dwIndex, 
                                                          uint* lpdwType, PWSTR lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CLOSE_ENUM = uint function(_HRESTYPEENUM* hResTypeEnum);
alias PCLUSAPI_OPEN_CLUSTER_NETWORK = _HNETWORK* function(_HCLUSTER* hCluster, const(PWSTR) lpszNetworkName);
alias PCLUSAPI_OPEN_CLUSTER_NETWORK_EX = _HNETWORK* function(_HCLUSTER* hCluster, const(PWSTR) lpszNetworkName, 
                                                             uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_NETWORK = BOOL function(_HNETWORK* hNetwork);
alias PCLUSAPI_GET_CLUSTER_FROM_NETWORK = _HCLUSTER* function(_HNETWORK* hNetwork);
alias PCLUSAPI_CLUSTER_NETWORK_OPEN_ENUM = _HNETWORKENUM* function(_HNETWORK* hNetwork, uint dwType);
alias PCLUSAPI_CLUSTER_NETWORK_GET_ENUM_COUNT = uint function(_HNETWORKENUM* hNetworkEnum);
alias PCLUSAPI_CLUSTER_NETWORK_ENUM = uint function(_HNETWORKENUM* hNetworkEnum, uint dwIndex, uint* lpdwType, 
                                                    PWSTR lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CLOSE_ENUM = uint function(_HNETWORKENUM* hNetworkEnum);
alias PCLUSAPI_GET_CLUSTER_NETWORK_STATE = CLUSTER_NETWORK_STATE function(_HNETWORK* hNetwork);
alias PCLUSAPI_SET_CLUSTER_NETWORK_NAME = uint function(_HNETWORK* hNetwork, const(PWSTR) lpszName);
alias PCLUSAPI_GET_CLUSTER_NETWORK_ID = uint function(_HNETWORK* hNetwork, PWSTR lpszNetworkId, uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CONTROL = uint function(_HNETWORK* hNetwork, _HNODE* hHostNode, uint dwControlCode, 
                                                       void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, 
                                                       uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_OPEN_CLUSTER_NET_INTERFACE = _HNETINTERFACE* function(_HCLUSTER* hCluster, 
                                                                     const(PWSTR) lpszInterfaceName);
alias PCLUSAPI_OPEN_CLUSTER_NETINTERFACE_EX = _HNETINTERFACE* function(_HCLUSTER* hCluster, 
                                                                       const(PWSTR) lpszNetInterfaceName, 
                                                                       uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE = uint function(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, 
                                                         const(PWSTR) lpszNetworkName, PWSTR lpszInterfaceName, 
                                                         uint* lpcchInterfaceName);
alias PCLUSAPI_CLOSE_CLUSTER_NET_INTERFACE = BOOL function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_GET_CLUSTER_FROM_NET_INTERFACE = _HCLUSTER* function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_STATE = CLUSTER_NETINTERFACE_STATE function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_CLUSTER_NET_INTERFACE_CONTROL = uint function(_HNETINTERFACE* hNetInterface, _HNODE* hHostNode, 
                                                             uint dwControlCode, void* lpInBuffer, 
                                                             uint nInBufferSize, void* lpOutBuffer, 
                                                             uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_GET_CLUSTER_KEY = HKEY function(_HCLUSTER* hCluster, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_GROUP_KEY = HKEY function(_HGROUP* hGroup, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_KEY = HKEY function(_HRESOURCE* hResource, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NODE_KEY = HKEY function(_HNODE* hNode, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NETWORK_KEY = HKEY function(_HNETWORK* hNetwork, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_KEY = HKEY function(_HNETINTERFACE* hNetInterface, uint samDesired);
alias PCLUSAPI_CLUSTER_REG_CREATE_KEY = int function(HKEY hKey, const(PWSTR) lpszSubKey, uint dwOptions, 
                                                     uint samDesired, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                                                     HKEY* phkResult, uint* lpdwDisposition);
alias PCLUSAPI_CLUSTER_REG_OPEN_KEY = int function(HKEY hKey, const(PWSTR) lpszSubKey, uint samDesired, 
                                                   HKEY* phkResult);
alias PCLUSAPI_CLUSTER_REG_DELETE_KEY = int function(HKEY hKey, const(PWSTR) lpszSubKey);
alias PCLUSAPI_CLUSTER_REG_CLOSE_KEY = int function(HKEY hKey);
alias PCLUSAPI_CLUSTER_REG_ENUM_KEY = int function(HKEY hKey, uint dwIndex, PWSTR lpszName, uint* lpcchName, 
                                                   FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_SET_VALUE = uint function(HKEY hKey, const(PWSTR) lpszValueName, uint dwType, 
                                                     const(ubyte)* lpData, uint cbData);
alias PCLUSAPI_CLUSTER_REG_DELETE_VALUE = uint function(HKEY hKey, const(PWSTR) lpszValueName);
alias PCLUSAPI_CLUSTER_REG_QUERY_VALUE = int function(HKEY hKey, const(PWSTR) lpszValueName, uint* lpdwValueType, 
                                                      ubyte* lpData, uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_ENUM_VALUE = uint function(HKEY hKey, uint dwIndex, PWSTR lpszValueName, 
                                                      uint* lpcchValueName, uint* lpdwType, ubyte* lpData, 
                                                      uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_QUERY_INFO_KEY = int function(HKEY hKey, uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, 
                                                         uint* lpcValues, uint* lpcbMaxValueNameLen, 
                                                         uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                                                         FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_GET_KEY_SECURITY = int function(HKEY hKey, uint RequestedInformation, 
                                                           void* pSecurityDescriptor, uint* lpcbSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SET_KEY_SECURITY = int function(HKEY hKey, uint SecurityInformation, 
                                                           void* pSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SYNC_DATABASE = int function(_HCLUSTER* hCluster, uint flags);
alias PCLUSAPI_CLUSTER_REG_CREATE_BATCH = int function(HKEY hKey, _HREGBATCH** pHREGBATCH);
alias PCLUSTER_REG_BATCH_ADD_COMMAND = int function(_HREGBATCH* hRegBatch, CLUSTER_REG_COMMAND dwCommand, 
                                                    PWSTR wzName, uint dwOptions, const(void)* lpData, uint cbData);
alias PCLUSTER_REG_CLOSE_BATCH = int function(_HREGBATCH* hRegBatch, BOOL bCommit, int* failedCommandNumber);
alias PCLUSTER_REG_BATCH_READ_COMMAND = int function(_HREGBATCHNOTIFICATION* hBatchNotification, 
                                                     CLUSTER_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_BATCH_CLOSE_NOTIFICATION = int function(_HREGBATCHNOTIFICATION* hBatchNotification);
alias PCLUSTER_REG_CREATE_BATCH_NOTIFY_PORT = int function(HKEY hKey, _HREGBATCHPORT** phBatchNotifyPort);
alias PCLUSTER_REG_CLOSE_BATCH_NOTIFY_PORT = int function(_HREGBATCHPORT* hBatchNotifyPort);
alias PCLUSTER_REG_GET_BATCH_NOTIFICATION = int function(_HREGBATCHPORT* hBatchNotify, 
                                                         _HREGBATCHNOTIFICATION** phBatchNotification);
alias PCLUSTER_REG_CREATE_READ_BATCH = int function(HKEY hKey, _HREGREADBATCH** phRegReadBatch);
alias PCLUSTER_REG_READ_BATCH_ADD_COMMAND = int function(_HREGREADBATCH* hRegReadBatch, const(PWSTR) wzSubkeyName, 
                                                         const(PWSTR) wzValueName);
alias PCLUSTER_REG_CLOSE_READ_BATCH = int function(_HREGREADBATCH* hRegReadBatch, 
                                                   _HREGREADBATCHREPLY** phRegReadBatchReply);
alias PCLUSTER_REG_CLOSE_READ_BATCH_EX = int function(_HREGREADBATCH* hRegReadBatch, uint flags, 
                                                      _HREGREADBATCHREPLY** phRegReadBatchReply);
alias PCLUSTER_REG_READ_BATCH_REPLY_NEXT_COMMAND = int function(_HREGREADBATCHREPLY* hRegReadBatchReply, 
                                                                CLUSTER_READ_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_CLOSE_READ_BATCH_REPLY = int function(_HREGREADBATCHREPLY* hRegReadBatchReply);
alias PCLUSTER_SET_ACCOUNT_ACCESS = uint function(_HCLUSTER* hCluster, const(PWSTR) szAccountSID, uint dwAccess, 
                                                  uint dwControlType);
///Callback function that receives regular updates on the progression of the setup of the cluster. This callback is used
///during processing of the CreateCluster, AddClusterNode, and DestroyCluster functions.
///Params:
///    pvCallbackArg = <i>pvCallbackArg</i> parameter passed to the CreateCluster, AddClusterNode, or DestroyCluster function.
///    eSetupPhase = Value from the CLUSTER_SETUP_PHASE enumeration that gives the current setup phase. The parameter can be one of
///                  the following values.
///    ePhaseType = Value from the CLUSTER_SETUP_PHASE_TYPE enumeration that gives the current setup phase type. The parameter can be
///                 one of the following values.
///    ePhaseSeverity = Value from the CLUSTER_SETUP_PHASE_SEVERITY enumeration that gives the current setup phase severity. The
///                     parameter can be one of the following values.
///    dwPercentComplete = Indicates approximate percentage of setup that has been completed. Range: 0–100
///    lpszObjectName = Name of the object.
///    dwStatus = Status
///Returns:
///    TBD
///    
alias PCLUSTER_SETUP_PROGRESS_CALLBACK = BOOL function(void* pvCallbackArg, CLUSTER_SETUP_PHASE eSetupPhase, 
                                                       CLUSTER_SETUP_PHASE_TYPE ePhaseType, 
                                                       CLUSTER_SETUP_PHASE_SEVERITY ePhaseSeverity, 
                                                       uint dwPercentComplete, const(PWSTR) lpszObjectName, 
                                                       uint dwStatus);
alias PCLUSAPI_CREATE_CLUSTER = _HCLUSTER* function(CREATE_CLUSTER_CONFIG* pConfig, 
                                                    PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                    void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_CNOLESS = _HCLUSTER* function(CREATE_CLUSTER_CONFIG* pConfig, 
                                                            PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                            void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_NAME_ACCOUNT = uint function(_HCLUSTER* hCluster, 
                                                           CREATE_CLUSTER_NAME_ACCOUNT* pConfig, 
                                                           PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                           void* pvCallbackArg);
alias PCLUSAPI_REMOVE_CLUSTER_NAME_ACCOUNT = uint function(_HCLUSTER* hCluster);
alias PCLUSAPI_ADD_CLUSTER_NODE = _HNODE* function(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, 
                                                   PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                   void* pvCallbackArg);
alias PCLUSAPI_DESTROY_CLUSTER = uint function(_HCLUSTER* hCluster, 
                                               PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                               void* pvCallbackArg, BOOL fdeleteVirtualComputerObjects);
///Called to update the status of a resource. The <b>PSET_RESOURCE_STATUS_ROUTINE_EX</b> type defines a pointer to this
///function.
///Params:
///    ResourceHandle = A handle to the resource to be updated. The <i>ResourceHandle</i> parameter should contain the same handle that
///                     is used for the <i>ResourceHandle</i> parameter in the OpenV2 entry point for this resource.
///    ResourceStatus = A pointer to a RESOURCE_STATUS_EX structure that contains information about the resource's state.
///Returns:
///    One of the following values of the RESOURCE_EXIT_STATE enumeration. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ResourceExitStateContinue</b></dt> <dt>0</dt> </dl>
///    </td> <td width="60%"> The resource has not been terminated. Worker threads can continue OnlineV2 and OfflineV2
///    operations for the resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ResourceExitStateTerminate</b></dt>
///    <dt>1</dt> </dl> </td> <td width="60%"> The resource has been terminated. Callers should end OnlineV2 or
///    OfflineV2 operations and immediately terminate all worker threads that are assigned to the resource. </td> </tr>
///    </table>
///    
alias PSET_RESOURCE_STATUS_ROUTINE_EX = uint function(ptrdiff_t ResourceHandle, RESOURCE_STATUS_EX* ResourceStatus);
///Called to update the status of a resource. The <b>PSET_RESOURCE_STATUS_ROUTINE</b> type defines a pointer to this
///function.
///Params:
///    ResourceHandle = Handle identifying the resource to be updated. The <i>ResourceHandle</i> parameter should contain the same handle
///                     used for the <i>ResourceHandle</i> parameter in the Open entry point for this resource.
///    ResourceStatus = Pointer to a RESOURCE_STATUS structure that contains information about the resource's state.
///Returns:
///    <i>SetResourceStatus</i> returns one of the following values enumerated from the RESOURCE_EXIT_STATE enumeration.
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ResourceExitStateContinue</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The resource has not been
///    terminated. Worker threads may continue Online and Offline operations for the resource. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ResourceExitStateTerminate</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The resource
///    has been terminated. Callers should end Online or Offline operations and immediately terminate all worker threads
///    assigned to the resource. </td> </tr> </table>
///    
alias PSET_RESOURCE_STATUS_ROUTINE = uint function(ptrdiff_t ResourceHandle, RESOURCE_STATUS* ResourceStatus);
///Called when control of the quorum resource has been lost. The <b>PQUORUM_RESOURCE_LOST</b> type defines a pointer to
///this function.
///Params:
///    Resource = 
alias PQUORUM_RESOURCE_LOST = void function(ptrdiff_t Resource);
///Records an event in the cluster log. The <b>PLOG_EVENT_ROUTINE</b> type defines a pointer to this function.
///Params:
///    ResourceHandle = Handle identifying the resource recording the event. The value for <i>ResourceHandle</i> should be the handle
///                     passed in during the Open call for this resource.
///    LogLevel = Value enumerated by the LOG_LEVEL enumeration that represents the log level of the event and that is for
///               information only. The following valid values are shown in order from least to most severe.
///    FormatString = Null-terminated Unicode string that includes the information to be recorded. This string must be in the same
///                   format as that passed to the FormatMessage function.
///    Arg1 = 
alias PLOG_EVENT_ROUTINE = void function(ptrdiff_t ResourceHandle, LOG_LEVEL LogLevel, const(PWSTR) FormatString);
///Opens a resource. The <b>POPEN_ROUTINE</b> type defines a pointer to this function.
///Params:
///    ResourceName = Name of the resource to open.
///    ResourceKey = Cluster database key for the cluster that includes the resource represented by <i>ResourceName</i>.
///    ResourceHandle = Handle to be passed to the SetResourceStatus callback function in the Startup entry-point function.
///Returns:
///    If the operation was successful, <i>Open</i> returns a resource identifier (<b>RESID</b>). If the operation was
///    not successful, <i>Open</i> returns <b>NULL</b>. Call SetLastError to specify that an error has occurred.
///    
alias POPEN_ROUTINE = void* function(const(PWSTR) ResourceName, HKEY ResourceKey, ptrdiff_t ResourceHandle);
///Closes a resource. The <b>PCLOSE_ROUTINE</b> type defines a pointer to this function.
///Params:
///    Resource = 
///Returns:
///    None. Call SetLastError to specify that an error has occurred.
///    
alias PCLOSE_ROUTINE = void function(void* Resource);
///Marks a resource as available for use. The <b>PONLINE_ROUTINE</b> type defines a pointer to this function.
///Params:
///    Resource = Resource identifier for the resource to be made available.
///    EventHandle = On input, <i>EventHandle</i> is <b>NULL</b>. On output, <i>EventHandle</i> contains a handle to a nonsignaled
///                  synchronization object. The resource DLL can signal this handle at any time to report a resource failure to the
///                  Resource Monitor. <i>EventHandle</i> can also be set to <b>NULL</b> on output, indicating that the resource does
///                  not support asynchronous event notification.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful, and the
///    resource is now online. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_NOT_AVAILABLE</b></dt>
///    <dt>5006 (0x138E)</dt> </dl> </td> <td width="60%"> The resource was arbitrated with some other systems, and one
///    of the other systems won the arbitration. Only quorum-capable resources return this value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> <dt>997 (0x3E5)</dt> </dl> </td> <td width="60%"> The request
///    is pending, and a thread has been activated to process the online request. </td> </tr> </table> If the operation
///    was not successful for other reasons, <i>Online</i> should return one of the system error codes.
///    
alias PONLINE_ROUTINE = uint function(void* Resource, HANDLE* EventHandle);
///Marks a resource as unavailable for use after cleanup processing is complete. The <b>POFFLINE_ROUTINE</b> type
///defines a pointer to this function.
///Params:
///    Resource = Resource identifier for the resource to be taken offline.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The request completed successfully, and the
///    resource is offline. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> <dt>997 (0x3E5)</dt>
///    </dl> </td> <td width="60%"> The request is still pending, and a thread has been activated to process the offline
///    request. </td> </tr> </table> If the operation was not successful for other reasons, <i>Offline</i> should return
///    one of the system error codes.
///    
alias POFFLINE_ROUTINE = uint function(void* Resource);
///Immediately marks a resource as unavailable for use without waiting for cleanup processing to be completed. The
///<b>PTERMINATE_ROUTINE</b> type defines a pointer to this function.
///Params:
///    Resource = Resource identifier for the resource to be made unavailable.
alias PTERMINATE_ROUTINE = void function(void* Resource);
///Determines whether a resource is available for use. The <b>PIS_ALIVE_ROUTINE</b> type defines a pointer to this
///function.
///Params:
///    Resource = Resource identifier for the resource to poll.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The resource is online and functioning properly.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The resource
///    is not functioning properly. </td> </tr> </table>
///    
alias PIS_ALIVE_ROUTINE = BOOL function(void* Resource);
///Determines whether a resource appears to be available for use. The <b>PLOOKS_ALIVE_ROUTINE</b> type defines a pointer
///to this function.
///Params:
///    Resource = Resource identifier for the resource to poll.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The resource is probably online and available for
///    use. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    resource may not be functioning properly. </td> </tr> </table>
///    
alias PLOOKS_ALIVE_ROUTINE = BOOL function(void* Resource);
///Allows a node to attempt to regain ownership of a quorum resource. The <b>PARBITRATE_ROUTINE</b> type defines a
///pointer to this function.
///Params:
///    Resource = Resource identifier for the quorum resource to be owned.
///    LostQuorumResource = Address of a QuorumResourceLost callback function that should be called if control of the quorum resource is lost
///                         after being successfully gained.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The arbitration was successful and the
///    quorum resource remains defended. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Error code</b></dt> </dl> </td>
///    <td width="60%"> The arbitration was not successful. </td> </tr> </table>
///    
alias PARBITRATE_ROUTINE = uint function(void* Resource, PQUORUM_RESOURCE_LOST LostQuorumResource);
///Releases the quorum resource from arbitration. The <b>PCLOSE_ROUTINE</b> type defines a pointer to this function.
///Params:
///    Resource = Resource identifier for the quorum resource to be released.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The quorum resource was successfully
///    released and is no longer being defended. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Error code</b></dt> </dl>
///    </td> <td width="60%"> The quorum resource was not successfully released. </td> </tr> </table>
///    
alias PRELEASE_ROUTINE = uint function(void* Resource);
///Performs an operation that applies to a resource. The <b>PRESOURCE_CONTROL_ROUTINE</b> type defines a pointer to this
///function.
///Params:
///    Resource = Resource identifier of the affected resource.
///    ControlCode = Control code that represents the operation to be performed. For a list of valid values for the <i>ControlCode</i>
///                  parameter, see Resource Type Control Codes.
///    InBuffer = Pointer to a buffer containing data to be used in the operation. <i>InBuffer</i> can be <b>NULL</b> if no data is
///               required.
///    InBufferSize = Size, in bytes, of the buffer pointed to by <i>InBuffer</i>.
///    OutBuffer = Pointer to a buffer containing data resulting from the operation. <i>OutBuffer</i> can be <b>NULL</b> if the
///                operation does not need to return data.
///    OutBufferSize = Size, in bytes, of the available space pointed to by <i>OutBuffer</i>.
///    BytesReturned = Actual size, in bytes, of the data resulting from the operation.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The operation associated with
///    <i>ControlCode</i> was completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FUNCTION</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The resource DLL requested that
///    the Resource Monitor perform default processing (if any) for <i>ControlCode</i> in addition to processing
///    supplied by the DLL (if any). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234
///    (0xEA)</dt> </dl> </td> <td width="60%"> The allocated size of <i>OutBuffer</i> was too small to hold the
///    requested data. <i>BytesReturned</i> indicates the required size. Always include the terminating <b>NULL</b> when
///    calculating the byte sizes of strings. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_RESOURCE_PROPERTIES_STORED</b></dt> <dt>5024 (0x13A0)</dt> </dl> </td> <td width="60%"> Indicates
///    that new property values for a resource have been set in the cluster database, but the properties have not yet
///    taken effect. The new property values will be applied after the resource is taken offline and brought online.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Error code</b></dt> </dl> </td> <td width="60%"> The operation was
///    unsuccessful. </td> </tr> </table>
///    
alias PRESOURCE_CONTROL_ROUTINE = uint function(void* Resource, uint ControlCode, void* InBuffer, 
                                                uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                                uint* BytesReturned);
///Performs an operation that applies to a resource type. The <b>PRESOURCE_TYPE_CONTROL_ROUTINE</b> type defines a
///pointer to this function.
///Params:
///    ResourceTypeName = Type of resource to be affected by the operation.
///    ControlCode = Control code that represents the operation to be performed. For a list of valid values for the <i>ControlCode</i>
///                  parameter, see Resource Type Control Codes.
///    InBuffer = Pointer to a buffer containing data to be used in the operation. <i>InBuffer</i> can be <b>NULL</b> if the
///               operation does not require data.
///    InBufferSize = Size, in bytes, of the buffer pointed to by <i>InBuffer</i>.
///    OutBuffer = Pointer to a buffer containing data resulting from the operation. <i>OutBuffer</i> can be <b>NULL</b> if the
///                operation returns no data.
///    OutBufferSize = Size, in bytes, of the available space pointed to by <i>OutBuffer</i>.
///    BytesReturned = Number of bytes in the buffer pointed to by <i>OutBuffer</i> that actually contain data.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td
///    width="60%"> The resource DLL requested that the Resource Monitor perform default processing (if any) for
///    <i>ControlCode</i> in addition to processing supplied by the DLL (if any). </td> </tr> </table>
///    
alias PRESOURCE_TYPE_CONTROL_ROUTINE = uint function(const(PWSTR) ResourceTypeName, uint ControlCode, 
                                                     void* InBuffer, uint InBufferSize, void* OutBuffer, 
                                                     uint OutBufferSize, uint* BytesReturned);
///Opens a resource. The <b>POPEN_V2_ROUTINE</b> type defines a pointer to this function.
///Params:
///    ResourceName = The name of the resource to open.
///    ResourceKey = The cluster database key for the cluster that includes the resource represented by <i>ResourceName</i>.
///    ResourceHandle = The resource handle to pass to the SetResourceStatusEx callback function.
///    OpenFlags = One of the following flags:
///Returns:
///    If the operation was successful, returns a resource identifier (<b>RESID</b>). If the operation was not
///    successful, returns <b>NULL</b>. Call SetLastError to specify that an error has occurred.
///    
alias POPEN_V2_ROUTINE = void* function(const(PWSTR) ResourceName, HKEY ResourceKey, ptrdiff_t ResourceHandle, 
                                        uint OpenFlags);
///Marks a resource as available for use. The <b>PONLINE_V2_ROUTINE</b> type defines a pointer to this function.
///Params:
///    Resource = A resource identifier for the resource to be made available.
///    EventHandle = On input, <i>EventHandle</i> is <b>NULL</b>. On output, <i>EventHandle</i> contains a handle to a non signaled
///                  synchronization object. The resource DLL can signal this handle at any time to report a resource failure to the
///                  Resource Monitor. <i>EventHandle</i> can also be set to <b>NULL</b> on output, which indicates that the resource
///                  does not support asynchronous event notifications.
///    OnlineFlags = A bitmask of flags that specify settings for this operation. This parameter can be set to one or more of the
///                  following values:
///    InBuffer = A pointer to a buffer that contains data for the operation; otherwise <b>NULL</b> if the operation does not
///               require data.
///    InBufferSize = The size of the <i>InBuffer</i> parameter, in bytes.
///    Reserved = Reserved.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful, and the
///    resource is online. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_NOT_AVAILABLE</b></dt> <dt>5006
///    (0x138E)</dt> </dl> </td> <td width="60%"> The resource was arbitrated with some other systems, and one of the
///    other systems won the arbitration. Only quorum-capable resources return this value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> <dt>997 (0x3E5)</dt> </dl> </td> <td width="60%"> The request
///    is pending, and a thread has been activated to process the online request. </td> </tr> </table> If the operation
///    was not successful for other reasons, a system error code is returned.
///    
alias PONLINE_V2_ROUTINE = uint function(void* Resource, HANDLE* EventHandle, uint OnlineFlags, ubyte* InBuffer, 
                                         uint InBufferSize, uint Reserved);
///Marks a resource as unavailable for use after cleanup processing is complete. The <b>POFFLINE_V2_ROUTINE</b> type
///defines a pointer to this function.
///Params:
///    Resource = A resource identifier for the resource to be taken offline.
///    DestinationNodeName = The name of the node that is to contain the resource when the operation completes.
///    OfflineFlags = A bitmask of flags that specify settings for this operation. This parameter can be set to one or more of the
///                   following values:
///    InBuffer = A pointer to a buffer that contains data for the operation; otherwise <b>NULL</b> if the operation does not
///               require data.
///    InBufferSize = The size of the <i>InBuffer</i> parameter, in bytes.
///    Reserved = Reserved.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The request completed successfully, and the
///    resource is offline. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> <dt>997 (0x3E5)</dt>
///    </dl> </td> <td width="60%"> The request is still pending, and a thread has been activated to process the offline
///    request. </td> </tr> </table> If the operation was not successful for other reasons, this function returns one of
///    the system error codes.
///    
alias POFFLINE_V2_ROUTINE = uint function(void* Resource, const(PWSTR) DestinationNodeName, uint OfflineFlags, 
                                          ubyte* InBuffer, uint InBufferSize, uint Reserved);
///Cancels an operation on a resource.
///Params:
///    Resource = The resource ID of the resource.
///    CancelFlags_RESERVED = Reserved.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The quorum resource was successfully
///    released and is no longer being defended. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Error code</b></dt> </dl>
///    </td> <td width="60%"> The operation was not successfully canceled. </td> </tr> </table>
///    
alias PCANCEL_ROUTINE = uint function(void* Resource, uint CancelFlags_RESERVED);
///Starts a call to a resource control code. The <b>PBEGIN_RESCALL_ROUTINE</b> type defines a pointer to this callback
///function.
///Params:
///    Resource = The resource ID for the resource.
///    ControlCode = The control code to call.
///    InBuffer = A pointer to the buffer that contains the input data for the call to the control code.
///    InBufferSize = The size of the buffer specified by <i>InBuffer</i>, in bytes.
///    OutBuffer = A pointer to the buffer that contains the output data for the call to the control code.
///    OutBufferSize = The size of the buffer specified by <i>OutBuffer</i>, in bytes.
///    BytesReturned = The size of the data returned by <i>OutBuffer</i>, in bytes.
///    context = The context to the resource control code that was called. <b>Windows Server 2012 R2: </b>This parameter was added
///              in Windows Server 2016.
///    ReturnedAsynchronously = <b>TRUE</b> if the operation returns asynchronously; otherwise, <b>FALSE</b>. <b>Windows Server 2012 R2: </b>This
///                             parameter was added in Windows Server 2016.
///Returns:
///    The function returns one of the following values, or a system error code: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The operation completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_RESOURCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The resource ID was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td width="60%"> The requested
///    control code is not supported. </td> </tr> </table>
///    
alias PBEGIN_RESCALL_ROUTINE = uint function(void* Resource, uint ControlCode, void* InBuffer, uint InBufferSize, 
                                             void* OutBuffer, uint OutBufferSize, uint* BytesReturned, long context, 
                                             BOOL* ReturnedAsynchronously);
///Starts a call to a resource control code. The <b>PBEGIN_RESTYPECALL_ROUTINE</b> type defines a pointer to this
///callback function.
///Params:
///    ResourceTypeName = The name of the resource type.
///    ControlCode = The control code to call.
///    InBuffer = A pointer to the buffer that contains the input data for the call to the control code.
///    InBufferSize = The size of the buffer specified by <i>InBuffer</i>, in bytes.
///    OutBuffer = A pointer to the buffer that contains the output data for the call to the control code.
///    OutBufferSize = The size of the buffer specified by <i>OutBuffer</i>, in bytes.
///    BytesReturned = The size of the data returned by <i>OutBuffer</i>, in bytes.
///    context = The context to the resource type control code that was called. <b>Windows Server 2012 R2: </b>This parameter was
///              added in Windows Server 2016.
///    ReturnedAsynchronously = <b>TRUE</b> if the operation returns asynchronously; otherwise, <b>FALSE</b>. <b>Windows Server 2012 R2: </b>This
///                             parameter was added in Windows Server 2016.
///Returns:
///    The function returns one of the following values, or a system error code: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The operation completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_RESOURCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The resource ID was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td width="60%"> The requested
///    control code is not supported. </td> </tr> </table>
///    
alias PBEGIN_RESTYPECALL_ROUTINE = uint function(const(PWSTR) ResourceTypeName, uint ControlCode, void* InBuffer, 
                                                 uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                                 uint* BytesReturned, long context, BOOL* ReturnedAsynchronously);
///The <b>PBEGIN_RESCALL_AS_USER_ROUTINE</b> type defines a pointer to this callback function.
///Params:
///    Resource = TBD
///    TokenHandle = TBD
///    ControlCode = TBD
///    InBuffer = TBD
///    InBufferSize = TBD
///    OutBuffer = TBD
///    OutBufferSize = TBD
///    BytesReturned = TBD
///    context = TBD
///    ReturnedAsynchronously = TBD
///Returns:
///    TBD
///    
alias PBEGIN_RESCALL_AS_USER_ROUTINE = uint function(void* Resource, HANDLE TokenHandle, uint ControlCode, 
                                                     void* InBuffer, uint InBufferSize, void* OutBuffer, 
                                                     uint OutBufferSize, uint* BytesReturned, long context, 
                                                     BOOL* ReturnedAsynchronously);
///The <b>PBEGIN_RESTYPECALL_AS_USER_ROUTINE</b> type defines a pointer to this callback function.
///Params:
///    ResourceTypeName = TBD
///    TokenHandle = TBD
///    ControlCode = TBD
///    InBuffer = TBD
///    InBufferSize = TBD
///    OutBuffer = TBD
///    OutBufferSize = TBD
///    BytesReturned = TBD
///    context = TBD
///    ReturnedAsynchronously = TBD
///Returns:
///    TBD
///    
alias PBEGIN_RESTYPECALL_AS_USER_ROUTINE = uint function(const(PWSTR) ResourceTypeName, HANDLE TokenHandle, 
                                                         uint ControlCode, void* InBuffer, uint InBufferSize, 
                                                         void* OutBuffer, uint OutBufferSize, uint* BytesReturned, 
                                                         long context, BOOL* ReturnedAsynchronously);
///Loads a resource DLL, returning a structure containing a function table and a version number. The
///<b>PSTARTUP_ROUTINE</b> type defines a pointer to this function.
///Params:
///    ResourceType = Type of resource being started.
///    MinVersionSupported = Minimum version of the Resource API supported by the Cluster service.
///    MaxVersionSupported = Maximum version of the Resource API supported by the Cluster service.
///    SetResourceStatus = Pointer to a callback function that the resource DLL should call to update its status after returning
///                        <b>ERROR_IO_PENDING</b> from Online or Offline. For more information see SetResourceStatus.
///    LogEvent = Pointer to a callback function that the resource DLL should call to report events for the resource. For more
///               information see LogEvent.
///    FunctionTable = Pointer to a CLRES_FUNCTION_TABLE structure that describes the Resource API version and the specific names for
///                    the entry points.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The request was successful. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_REVISION_MISMATCH</b></dt> <dt>1306 (0x51A)</dt> </dl> </td> <td
///    width="60%"> The resource DLL does not support a version that falls in the range identified by the
///    <i>MinVersionSupported</i> and <i>MaxVersionSupported</i> parameters. </td> </tr> </table> If the operation was
///    not successful, <i>Startup</i> should return one of the system error codes.
///    
alias PSTARTUP_ROUTINE = uint function(const(PWSTR) ResourceType, uint MinVersionSupported, 
                                       uint MaxVersionSupported, PSET_RESOURCE_STATUS_ROUTINE SetResourceStatus, 
                                       PLOG_EVENT_ROUTINE LogEvent, CLRES_FUNCTION_TABLE** FunctionTable);
///Reports that locked mode was configured for a resource.
///Params:
///    ResourceHandle = A handle to the resource to configure.
///    LockedModeEnabled = <b>TRUE</b> to enable locked mode; otherwise <b>FALSE</b>.
///    LockedModeReason = A flag that specifies the reason that locked mode was configured.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> (0), if the operation succeeds; otherwise returns a system error code.
///    
alias PSET_RESOURCE_LOCKED_MODE_ROUTINE = uint function(ptrdiff_t ResourceHandle, BOOL LockedModeEnabled, 
                                                        uint LockedModeReason);
///Reports that there was a failure in a resource instance. The <b>PSIGNAL_FAILURE_ROUTINE</b> type defines a pointer to
///this function.
///Params:
///    ResourceHandle = A handle to the resource instance.
///    FailureType = A FAILURE_TYPE enumeration value that describes the failure type. <b>Windows Server 2012: </b>Not supported.
///    ApplicationSpecificErrorCode = An application error code.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> (0), if the operation succeeds; otherwise returns a system error code.
///    
alias PSIGNAL_FAILURE_ROUTINE = uint function(ptrdiff_t ResourceHandle, FAILURE_TYPE FailureType, 
                                              uint ApplicationSpecificErrorCode);
///TBD
///Params:
///    ResourceHandle = TBD
///    propertyListBuffer = TBD
///    propertyListBufferSize = The size of the <i>propertyListBuffer</i> parameter.
alias PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE = uint function(ptrdiff_t ResourceHandle, 
                                                                          ubyte* propertyListBuffer, 
                                                                          uint propertyListBufferSize);
///Called when a resource control code operation completes. The <b>PEND_CONTROL_CALL</b> type defines a pointer to this
///function.
///Params:
///    context = 
///    status = The context of the call to the resource control code. <b>Windows Server 2012 R2: </b>Not supported. The status of
///             the operation.
///Returns:
///    <b>ERROR_SUCCESS</b> if the operation is successful; otherwise, a system error code.
///    
alias PEND_CONTROL_CALL = uint function(const(long) context, uint status);
///Called when a resource type control code operation completes. The <b>PEND_TYPE_CONTROL_CALL</b> type defines a
///pointer to this function.
///Params:
///    context = 
///    status = The context of the call to the resource type control code. The status of the operation.
///Returns:
///    <b>ERROR_SUCCESS</b> if the operation is successful; otherwise, a system error code.
///    
alias PEND_TYPE_CONTROL_CALL = uint function(const(long) context, uint status);
///Extends the timeout for a call to a resource control code. The <b>PEXTEND_RES_CONTROL_CALL</b> type defines a pointer
///to this function.
///Params:
///    context = The context to the resource control code that was called.
///    newTimeoutInMs = The new timeout, in milliseconds.
///Returns:
///    <b>ERROR_SUCCESS</b> if the operation is successful; otherwise, a system error code.
///    
alias PEXTEND_RES_CONTROL_CALL = uint function(const(long) context, uint newTimeoutInMs);
///Extends the timeout for a call to a resource type control code. The <b>PEXTEND_RES_TYPE_CONTROL_CALL</b> type defines
///a pointer to this function.
///Params:
///    context = The context to the resource type control code that was called.
///    newTimeoutInMs = The new timeout, in milliseconds.
///Returns:
///    <b>ERROR_SUCCESS</b> if the operation is successful; otherwise, a system error code.
///    
alias PEXTEND_RES_TYPE_CONTROL_CALL = uint function(const(long) context, uint newTimeoutInMs);
///TBD. The <b>PRAISE_RES_TYPE_NOTIFICATION</b> type is a pointer to this function.
///Params:
///    ResourceType = TBD
///    pPayload = TBD
///    payloadSize = TBD
///Returns:
///    TBD
///    
alias PRAISE_RES_TYPE_NOTIFICATION = uint function(const(PWSTR) ResourceType, const(ubyte)* pPayload, 
                                                   uint payloadSize);
///The <b>PCHANGE_RESOURCE_PROCESS_FOR_DUMPS</b> type defines a pointer to this function.
///Params:
///    resource = TBD
///    processName = TBD
///    processId = TBD
///    isAdd = TBD
///Returns:
///    TBD
///    
alias PCHANGE_RESOURCE_PROCESS_FOR_DUMPS = uint function(ptrdiff_t resource, const(PWSTR) processName, 
                                                         uint processId, BOOL isAdd);
///The <b>PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS</b> type defines a pointer to this function.
///Params:
///    resourceTypeName = TBD
///    processName = TBD
///    processId = TBD
///    isAdd = TBD
///Returns:
///    TBD
///    
alias PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS = uint function(const(PWSTR) resourceTypeName, const(PWSTR) processName, 
                                                         uint processId, BOOL isAdd);
///Sets the internal state of a resource
///Params:
///    Arg1 = 
///    stateType = A CLUSTER_RESOURCE_APPLICATION_STATE value
///    active = Whether the resource is active
alias PSET_INTERNAL_STATE = uint function(ptrdiff_t param0, CLUSTER_RESOURCE_APPLICATION_STATE stateType, 
                                          BOOL active);
alias PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE = uint function(ptrdiff_t ResourceHandle, BOOL LockedModeEnabled, 
                                                           uint LockedModeReason, uint LockedModeFlags);
///Loads a resource DLL, returning a structure that contains a function table and a version number. The
///<b>PSTARTUP_EX_ROUTINE</b> type defines a pointer to this function.
///Params:
///    ResourceType = The type of resource to start.
///    MinVersionSupported = The minimum version of the Resource API supported by the Cluster service.
///    MaxVersionSupported = The maximum version of the Resource API supported by the Cluster service.
///    MonitorCallbackFunctions = TBD
///    ResourceDllInterfaceFunctions = TBD
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The request was successful. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_REVISION_MISMATCH</b></dt> <dt>1306 (0x51A)</dt> </dl> </td> <td
///    width="60%"> The resource DLL does not support a version that falls in the range identified by the
///    <i>MinVersionSupported</i> and <i>MaxVersionSupported</i> parameters. </td> </tr> </table>
///    
alias PSTARTUP_EX_ROUTINE = uint function(const(PWSTR) ResourceType, uint MinVersionSupported, 
                                          uint MaxVersionSupported, 
                                          CLRES_CALLBACK_FUNCTION_TABLE* MonitorCallbackFunctions, 
                                          CLRES_FUNCTION_TABLE** ResourceDllInterfaceFunctions);
alias PRESUTIL_START_RESOURCE_SERVICE = uint function(const(PWSTR) pszServiceName, SC_HANDLE__** phServiceHandle);
alias PRESUTIL_VERIFY_RESOURCE_SERVICE = uint function(const(PWSTR) pszServiceName);
alias PRESUTIL_STOP_RESOURCE_SERVICE = uint function(const(PWSTR) pszServiceName);
alias PRESUTIL_VERIFY_SERVICE = uint function(SC_HANDLE__* hServiceHandle);
alias PRESUTIL_STOP_SERVICE = uint function(SC_HANDLE__* hServiceHandle);
alias PRESUTIL_CREATE_DIRECTORY_TREE = uint function(const(PWSTR) pszPath);
alias PRESUTIL_IS_PATH_VALID = BOOL function(const(PWSTR) pszPath);
alias PRESUTIL_ENUM_PROPERTIES = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                               PWSTR pszOutProperties, uint cbOutPropertiesSize, 
                                               uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_ENUM_PRIVATE_PROPERTIES = uint function(HKEY hkeyClusterKey, PWSTR pszOutProperties, 
                                                       uint cbOutPropertiesSize, uint* pcbBytesReturned, 
                                                       uint* pcbRequired);
alias PRESUTIL_GET_PROPERTIES = uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                              void* pOutPropertyList, uint cbOutPropertyListSize, 
                                              uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_ALL_PROPERTIES = uint function(HKEY hkeyClusterKey, 
                                                  const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                  void* pOutPropertyList, uint cbOutPropertyListSize, 
                                                  uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_PRIVATE_PROPERTIES = uint function(HKEY hkeyClusterKey, void* pOutPropertyList, 
                                                      uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                                                      uint* pcbRequired);
alias PRESUTIL_GET_PROPERTY_SIZE = uint function(HKEY hkeyClusterKey, 
                                                 const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                                                 uint* pcbOutPropertyListSize, uint* pnPropertyCount);
alias PRESUTIL_GET_PROPERTY = uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                                            void** pOutPropertyItem, uint* pcbOutPropertyItemSize);
alias PRESUTIL_VERIFY_PROPERTY_TABLE = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                                                     BOOL bAllowUnknownProperties, const(void)* pInPropertyList, 
                                                     uint cbInPropertyListSize, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_TABLE = uint function(HKEY hkeyClusterKey, 
                                                  const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                                                  BOOL bAllowUnknownProperties, const(void)* pInPropertyList, 
                                                  uint cbInPropertyListSize, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_TABLE_EX = uint function(HKEY hkeyClusterKey, 
                                                     const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                                                     BOOL bAllowUnknownProperties, const(void)* pInPropertyList, 
                                                     uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_PARAMETER_BLOCK = uint function(HKEY hkeyClusterKey, 
                                                            const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                            void* Reserved, const(ubyte)* pInParams, 
                                                            const(void)* pInPropertyList, uint cbInPropertyListSize, 
                                                            ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_PARAMETER_BLOCK_EX = uint function(HKEY hkeyClusterKey, 
                                                               const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                               void* Reserved, const(ubyte)* pInParams, 
                                                               const(void)* pInPropertyList, 
                                                               uint cbInPropertyListSize, BOOL bForceWrite, 
                                                               ubyte* pOutParams);
alias PRESUTIL_SET_UNKNOWN_PROPERTIES = uint function(HKEY hkeyClusterKey, 
                                                      const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                      const(void)* pInPropertyList, uint cbInPropertyListSize);
alias PRESUTIL_GET_PROPERTIES_TO_PARAMETER_BLOCK = uint function(HKEY hkeyClusterKey, 
                                                                 const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                                 ubyte* pOutParams, BOOL bCheckForRequiredProperties, 
                                                                 PWSTR* pszNameOfPropInError);
alias PRESUTIL_PROPERTY_LIST_FROM_PARAMETER_BLOCK = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                                  void* pOutPropertyList, 
                                                                  uint* pcbOutPropertyListSize, 
                                                                  const(ubyte)* pInParams, uint* pcbBytesReturned, 
                                                                  uint* pcbRequired);
alias PRESUTIL_DUP_PARAMETER_BLOCK = uint function(ubyte* pOutParams, const(ubyte)* pInParams, 
                                                   const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);
alias PRESUTIL_FREE_PARAMETER_BLOCK = void function(ubyte* pOutParams, const(ubyte)* pInParams, 
                                                    const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);
alias PRESUTIL_ADD_UNKNOWN_PROPERTIES = uint function(HKEY hkeyClusterKey, 
                                                      const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                      void* pOutPropertyList, uint pcbOutPropertyListSize, 
                                                      uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_SET_PRIVATE_PROPERTY_LIST = uint function(HKEY hkeyClusterKey, const(void)* pInPropertyList, 
                                                         uint cbInPropertyListSize);
alias PRESUTIL_VERIFY_PRIVATE_PROPERTY_LIST = uint function(const(void)* pInPropertyList, 
                                                            uint cbInPropertyListSize);
alias PRESUTIL_DUP_STRING = PWSTR function(const(PWSTR) pszInString);
alias PRESUTIL_GET_BINARY_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                                ubyte** ppbOutValue, uint* pcbOutValueSize);
alias PRESUTIL_GET_SZ_VALUE = PWSTR function(HKEY hkeyClusterKey, const(PWSTR) pszValueName);
alias PRESUTIL_GET_EXPAND_SZ_VALUE = PWSTR function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, BOOL bExpand);
alias PRESUTIL_GET_DWORD_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, uint* pdwOutValue, 
                                               uint dwDefaultValue);
alias PRESUTIL_GET_QWORD_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ulong* pqwOutValue, 
                                               ulong qwDefaultValue);
alias PRESUTIL_SET_BINARY_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                                const(ubyte)* pbNewValue, uint cbNewValueSize, ubyte** ppbOutValue, 
                                                uint* pcbOutValueSize);
alias PRESUTIL_SET_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                            const(PWSTR) pszNewValue, PWSTR* ppszOutString);
alias PRESUTIL_SET_EXPAND_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                                   const(PWSTR) pszNewValue, PWSTR* ppszOutString);
alias PRESUTIL_SET_MULTI_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                                  const(PWSTR) pszNewValue, uint cbNewValueSize, PWSTR* ppszOutValue, 
                                                  uint* pcbOutValueSize);
alias PRESUTIL_SET_DWORD_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, uint dwNewValue, 
                                               uint* pdwOutValue);
alias PRESUTIL_SET_QWORD_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ulong qwNewValue, 
                                               ulong* pqwOutValue);
alias PRESUTIL_GET_BINARY_PROPERTY = uint function(ubyte** ppbOutValue, uint* pcbOutValueSize, 
                                                   const(CLUSPROP_BINARY)* pValueStruct, const(ubyte)* pbOldValue, 
                                                   uint cbOldValueSize, ubyte** ppPropertyList, 
                                                   uint* pcbPropertyListSize);
alias PRESUTIL_GET_SZ_PROPERTY = uint function(PWSTR* ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, 
                                               const(PWSTR) pszOldValue, ubyte** ppPropertyList, 
                                               uint* pcbPropertyListSize);
alias PRESUTIL_GET_MULTI_SZ_PROPERTY = uint function(PWSTR* ppszOutValue, uint* pcbOutValueSize, 
                                                     const(CLUSPROP_SZ)* pValueStruct, const(PWSTR) pszOldValue, 
                                                     uint cbOldValueSize, ubyte** ppPropertyList, 
                                                     uint* pcbPropertyListSize);
alias PRESUTIL_GET_DWORD_PROPERTY = uint function(uint* pdwOutValue, const(CLUSPROP_DWORD)* pValueStruct, 
                                                  uint dwOldValue, uint dwMinimum, uint dwMaximum, 
                                                  ubyte** ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_LONG_PROPERTY = uint function(int* plOutValue, const(CLUSPROP_LONG)* pValueStruct, 
                                                 int lOldValue, int lMinimum, int lMaximum, ubyte** ppPropertyList, 
                                                 uint* pcbPropertyListSize);
alias PRESUTIL_GET_FILETIME_PROPERTY = uint function(FILETIME* pftOutValue, const(CLUSPROP_FILETIME)* pValueStruct, 
                                                     FILETIME ftOldValue, FILETIME ftMinimum, FILETIME ftMaximum, 
                                                     ubyte** ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_ENVIRONMENT_WITH_NET_NAME = void* function(_HRESOURCE* hResource);
alias PRESUTIL_FREE_ENVIRONMENT = uint function(void* lpEnvironment);
alias PRESUTIL_EXPAND_ENVIRONMENT_STRINGS = PWSTR function(const(PWSTR) pszSrc);
alias PRESUTIL_SET_RESOURCE_SERVICE_ENVIRONMENT = uint function(const(PWSTR) pszServiceName, _HRESOURCE* hResource, 
                                                                PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                ptrdiff_t hResourceHandle);
alias PRESUTIL_REMOVE_RESOURCE_SERVICE_ENVIRONMENT = uint function(const(PWSTR) pszServiceName, 
                                                                   PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                   ptrdiff_t hResourceHandle);
alias PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS = uint function(const(PWSTR) pszServiceName, 
                                                                     SC_HANDLE__* schSCMHandle, 
                                                                     SC_HANDLE__** phService, 
                                                                     PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                     ptrdiff_t hResourceHandle);
alias PRESUTIL_FIND_SZ_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue);
alias PRESUTIL_FIND_EXPAND_SZ_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                       const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue);
alias PRESUTIL_FIND_EXPANDED_SZ_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                         const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue);
alias PRESUTIL_FIND_DWORD_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                   const(PWSTR) pszPropertyName, uint* pdwPropertyValue);
alias PRESUTIL_FIND_BINARY_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                    const(PWSTR) pszPropertyName, ubyte** pbPropertyValue, 
                                                    uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_MULTI_SZ_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                      const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue, 
                                                      uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_LONG_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                  const(PWSTR) pszPropertyName, int* plPropertyValue);
alias PRESUTIL_FIND_ULARGEINTEGER_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                           const(PWSTR) pszPropertyName, ulong* plPropertyValue);
alias PRESUTIL_FIND_FILETIME_PROPERTY = uint function(const(void)* pPropertyList, uint cbPropertyListSize, 
                                                      const(PWSTR) pszPropertyName, FILETIME* pftPropertyValue);
///Initializes a worker thread with the specified callback routine. The <b>PWORKER_START_ROUTINE</b> type defines a
///pointer to this function.
///Params:
///    pWorker = A pointer to the CLUS_WORKER structure that represents the worker thread.
///    lpThreadParameter = A pointer to the callback routine to use to initialize the worker thread.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> (0), if the operation succeeds; otherwise returns a system error code.
///    
alias PWORKER_START_ROUTINE = uint function(CLUS_WORKER* pWorker, void* lpThreadParameter);
alias PCLUSAPI_CLUS_WORKER_CREATE = uint function(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, 
                                                  void* lpParameter);
alias PCLUSAPIClusWorkerCheckTerminate = BOOL function(CLUS_WORKER* lpWorker);
///Terminates a worker thread. The <b>PCLUSAPI_CLUS_WORKER_TERMINATE</b> type defines a pointer to this function.
///Params:
///    lpWorker = Pointer to a CLUS_WORKER structure describing the thread to terminate.
alias PCLUSAPI_CLUS_WORKER_TERMINATE = void function(CLUS_WORKER* lpWorker);
///TBD
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
alias LPRESOURCE_CALLBACK = uint function(_HRESOURCE* param0, _HRESOURCE* param1, void* param2);
///TBD
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
alias LPRESOURCE_CALLBACK_EX = uint function(_HCLUSTER* param0, _HRESOURCE* param1, _HRESOURCE* param2, 
                                             void* param3);
alias LPGROUP_CALLBACK_EX = uint function(_HCLUSTER* param0, _HGROUP* param1, _HGROUP* param2, void* param3);
alias LPNODE_CALLBACK = uint function(_HCLUSTER* param0, _HNODE* param1, CLUSTER_NODE_STATE param2, void* param3);
alias PRESUTIL_RESOURCES_EQUAL = BOOL function(_HRESOURCE* hSelf, _HRESOURCE* hResource);
alias PRESUTIL_RESOURCE_TYPES_EQUAL = BOOL function(const(PWSTR) lpszResourceTypeName, _HRESOURCE* hResource);
alias PRESUTIL_IS_RESOURCE_CLASS_EQUAL = BOOL function(CLUS_RESOURCE_CLASS_INFO* prci, _HRESOURCE* hResource);
alias PRESUTIL_ENUM_RESOURCES = uint function(_HRESOURCE* hSelf, const(PWSTR) lpszResTypeName, 
                                              LPRESOURCE_CALLBACK pResCallBack, void* pParameter);
alias PRESUTIL_ENUM_RESOURCES_EX = uint function(_HCLUSTER* hCluster, _HRESOURCE* hSelf, 
                                                 const(PWSTR) lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, 
                                                 void* pParameter);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY = _HRESOURCE* function(HANDLE hSelf, const(PWSTR) lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                      const(PWSTR) lpszResourceType, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                       CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY = _HRESOURCE* function(const(PWSTR) lpszResourceName, 
                                                                   const(PWSTR) lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENTIP_ADDRESS_PROPS = uint function(_HRESOURCE* hResource, PWSTR pszAddress, 
                                                                      uint* pcchAddress, PWSTR pszSubnetMask, 
                                                                      uint* pcchSubnetMask, PWSTR pszNetwork, 
                                                                      uint* pcchNetwork);
alias PRESUTIL_FIND_DEPENDENT_DISK_RESOURCE_DRIVE_LETTER = uint function(_HCLUSTER* hCluster, 
                                                                         _HRESOURCE* hResource, PWSTR pszDriveLetter, 
                                                                         uint* pcchDriveLetter);
alias PRESUTIL_TERMINATE_SERVICE_PROCESS_FROM_RES_DLL = uint function(uint dwServicePid, BOOL bOffline, 
                                                                      uint* pdwResourceState, 
                                                                      PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                      ptrdiff_t hResourceHandle);
alias PRESUTIL_GET_PROPERTY_FORMATS = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                    void* pOutPropertyFormatList, uint cbPropertyFormatListSize, 
                                                    uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES = uint function(_HCLUSTER* hCluster, _HRESOURCE** phClusterNameResource, 
                                                          _HRESOURCE** phClusterIPAddressResource, 
                                                          _HRESOURCE** phClusterQuorumResource);
alias PRESUTIL_GET_RESOURCE_NAME = uint function(_HRESOURCE* hResource, PWSTR pszResourceName, 
                                                 uint* pcchResourceNameInOut);
alias PCLUSTER_IS_PATH_ON_SHARED_VOLUME = BOOL function(const(PWSTR) lpszPathName);
alias PCLUSTER_GET_VOLUME_PATH_NAME = BOOL function(const(PWSTR) lpszFileName, PWSTR lpszVolumePathName, 
                                                    uint cchBufferLength);
alias PCLUSTER_GET_VOLUME_NAME_FOR_VOLUME_MOUNT_POINT = BOOL function(const(PWSTR) lpszVolumeMountPoint, 
                                                                      PWSTR lpszVolumeName, uint cchBufferLength);
alias PCLUSTER_PREPARE_SHARED_VOLUME_FOR_BACKUP = uint function(const(PWSTR) lpszFileName, 
                                                                PWSTR lpszVolumePathName, uint* lpcchVolumePathName, 
                                                                PWSTR lpszVolumeName, uint* lpcchVolumeName);
alias PCLUSTER_CLEAR_BACKUP_STATE_FOR_SHARED_VOLUME = uint function(const(PWSTR) lpszVolumePathName);
alias PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS_EX = uint function(const(PWSTR) pszServiceName, 
                                                                        SC_HANDLE__* schSCMHandle, 
                                                                        SC_HANDLE__** phService, 
                                                                        uint dwDesiredAccess, 
                                                                        PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                        ptrdiff_t hResourceHandle);
alias PRESUTIL_ENUM_RESOURCES_EX2 = uint function(_HCLUSTER* hCluster, _HRESOURCE* hSelf, 
                                                  const(PWSTR) lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, 
                                                  void* pParameter, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_EX = _HRESOURCE* function(HANDLE hSelf, const(PWSTR) lpszResourceType, 
                                                                 uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME_EX = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                         const(PWSTR) lpszResourceType, 
                                                                         BOOL bRecurse, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS_EX = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                          CLUS_RESOURCE_CLASS_INFO* prci, 
                                                                          BOOL bRecurse, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY_EX = _HRESOURCE* function(const(PWSTR) lpszResourceName, 
                                                                      const(PWSTR) lpszResourceType, 
                                                                      uint dwDesiredAccess);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES_EX = uint function(_HCLUSTER* hClusterIn, 
                                                             _HRESOURCE** phClusterNameResourceOut, 
                                                             _HRESOURCE** phClusterIPAddressResourceOut, 
                                                             _HRESOURCE** phClusterQuorumResourceOut, 
                                                             uint dwDesiredAccess);
alias POPEN_CLUSTER_CRYPT_PROVIDER = _HCLUSCRYPTPROVIDER* function(const(PWSTR) lpszResource, byte* lpszProvider, 
                                                                   uint dwType, uint dwFlags);
alias POPEN_CLUSTER_CRYPT_PROVIDEREX = _HCLUSCRYPTPROVIDER* function(const(PWSTR) lpszResource, 
                                                                     const(PWSTR) lpszKeyname, byte* lpszProvider, 
                                                                     uint dwType, uint dwFlags);
alias PCLOSE_CLUSTER_CRYPT_PROVIDER = uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider);
alias PCLUSTER_ENCRYPT = uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider, ubyte* pData, uint cbData, 
                                       ubyte** ppData, uint* pcbData);
alias PCLUSTER_DECRYPT = uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider, ubyte* pCryptInput, 
                                       uint cbCryptInput, ubyte** ppCryptOutput, uint* pcbCryptOutput);
alias PFREE_CLUSTER_CRYPT = uint function(void* pCryptInfo);
alias PREGISTER_APPINSTANCE = uint function(HANDLE ProcessHandle, GUID* AppInstanceId, 
                                            BOOL ChildrenInheritAppInstance);
alias PREGISTER_APPINSTANCE_VERSION = uint function(GUID* AppInstanceId, ulong InstanceVersionHigh, 
                                                    ulong InstanceVersionLow);
alias PQUERY_APPINSTANCE_VERSION = uint function(GUID* AppInstanceId, ulong* InstanceVersionHigh, 
                                                 ulong* InstanceVersionLow, NTSTATUS* VersionStatus);
alias PRESET_ALL_APPINSTANCE_VERSIONS = uint function();
alias SET_APP_INSTANCE_CSV_FLAGS = uint function(HANDLE ProcessHandle, uint Mask, uint Flags);

// Structs


struct _HCLUSTER
{
}

struct _HNODE
{
}

struct _HRESOURCE
{
}

struct _HGROUP
{
}

struct _HNETWORK
{
}

struct _HNETINTERFACE
{
}

struct _HCHANGE
{
}

struct _HCLUSENUM
{
}

struct _HGROUPENUM
{
}

struct _HRESENUM
{
}

struct _HNETWORKENUM
{
}

struct _HNODEENUM
{
}

struct _HNETINTERFACEENUM
{
}

struct _HRESTYPEENUM
{
}

struct _HREGBATCH
{
}

struct _HREGBATCHPORT
{
}

struct _HREGBATCHNOTIFICATION
{
}

struct _HREGREADBATCH
{
}

struct _HREGREADBATCHREPLY
{
}

struct _HNODEENUMEX
{
}

struct _HCLUSENUMEX
{
}

struct _HGROUPENUMEX
{
}

struct _HRESENUMEX
{
}

struct _HGROUPSET
{
}

struct _HGROUPSETENUM
{
}

///TBD
struct CLUSTERVERSIONINFO_NT4
{
    ///Contains the size, in bytes, of the data structure. Users must set this size prior to calling the
    ///GetClusterInformation function.
    uint       dwVersionInfoSize;
    ///Identifies the major version number of the operating system that is installed on the local node. For example, for
    ///version X.Y, the major version number is X.
    ushort     MajorVersion;
    ///Identifies the minor version number of the operating system that is installed on the local node. For example, for
    ///version X.Y, the minor version number is Y.
    ushort     MinorVersion;
    ///Identifies the build number of the operating system that is installed on the local node, such as 224.
    ushort     BuildNumber;
    ///Contains the vendor identifier information for the cluster service that is installed on the local node.
    ushort[64] szVendorId;
    ///Contains the latest service pack that is installed on the node. If a Service Pack is not installed, the
    ///<b>szCSDVersion</b> member is empty.
    ushort[64] szCSDVersion;
}

///Describes information about the version of the Cluster service installed locally on a node.
struct CLUSTERVERSIONINFO
{
    ///Size, in bytes, of the data structure. Users must set this size prior to calling GetClusterInformation.
    uint       dwVersionInfoSize;
    ///Identifies the major version number of the operating system installed on the local node. For example, for version
    ///X.Y, the major version number is X.
    ushort     MajorVersion;
    ///Identifies the minor version number of the operating system installed on the local node. For example, for version
    ///X.Y, the minor version number is Y.
    ushort     MinorVersion;
    ///Identifies the build number of the operating system installed on the local node, such as 224.
    ushort     BuildNumber;
    ///Contains the vendor identifier information for the Cluster service installed on the local node.
    ushort[64] szVendorId;
    ///Contains the latest service pack installed on the node. If a Service Pack has not been installed, the
    ///<b>szCSDVersion</b> member is empty.
    ushort[64] szCSDVersion;
    ///Identifies the highest version of the Cluster service with which the Cluster service installed on the local node
    ///can join to form a cluster.
    uint       dwClusterHighestVersion;
    ///Identifies the lowest version of the Cluster service with which the Cluster service installed on the local node
    ///can join to form a cluster.
    uint       dwClusterLowestVersion;
    ///If the cluster nodes are running different versions of the Cluster service, this value is set to
    ///<b>CLUSTER_VERSION_FLAG_MIXED_MODE</b>. If all cluster nodes are running the same version of the Cluster service,
    ///this value is 0.
    uint       dwFlags;
    ///This value is reserved for internal use.
    uint       dwReserved;
}

///Indicates whether a node's attempt to start the Cluster service represents an attempt to form or join a cluster, and
///whether the node has attempted to start this version of the Cluster service before. Resource DLLs receive the
///CLUS_STARTING_PARAMS structure with the CLUSCTL_RESOURCE_TYPE_STARTING_PHASE1 and
///CLUSCTL_RESOURCE_TYPE_STARTING_PHASE2 control codes.
struct CLUS_STARTING_PARAMS
{
    ///Byte size of the structure.
    uint dwSize;
    ///Indicates whether this particular start of the Cluster service represents a form or a join operation.
    BOOL bForm;
    ///Indicates whether this version of the Cluster service has ever started on the node.
    BOOL bFirst;
}

///Sent with the CLUSCTL_RESOURCE_STATE_CHANGE_REASON control code to provide the reason for a resource state change.
struct CLUSCTL_RESOURCE_STATE_CHANGE_REASON_STRUCT
{
    ///The size of the structure in bytes.
    uint dwSize;
    ///The version of the structure. Set to <b>CLUSCTL_RESOURCE_STATE_CHANGE_REASON_VERSION_1</b> (1).
    uint dwVersion;
    ///A value of the CLUSTER_RESOURCE_STATE_CHANGE_REASON enumeration that describes the reason for the state change.
    ///The following list lists the possible values.
    CLUSTER_RESOURCE_STATE_CHANGE_REASON eReason;
}

///Represents the order in which current batch command data is sent to the ClusterRegBatchReadCommand function. Values
///in the <b>CLUSTER_BATCH_COMMAND</b> structure are identical to parameters passed to the ClusterRegBatchAddCommand
///function. The only difference is that for <b>CLUSREG_DELETE_VALUE</b>, the <b>dwOptions</b>, <b>lpData</b>, and
///<b>cbData</b> members are set to the value being deleted, similar to the <b>CLUSREG_SET_VALUE</b> command.
struct CLUSTER_BATCH_COMMAND
{
    ///A command that is supported by this API and taken from the CLUSTER_REG_COMMAND enumeration. The possible commands
    ///are as follows.
    CLUSTER_REG_COMMAND Command;
    ///If the <b>Command</b> member takes either the <b>CLUSREG_SET_VALUE</b> command or the <b>CLUSREG_DELETE_VALUE</b>
    ///command, then this member takes one of the standard registry value types. If not, then <b>Command</b> is set to
    ///0.
    uint                dwOptions;
    ///The name of the value or key relative to the command issued by <b>Command</b>.
    const(PWSTR)        wzName;
    ///A pointer to the data relative to the command issued by <b>Command</b>. The value of this member is <b>NULL</b>
    ///for all the commands except the <b>CLUSREG_SET_VALUE</b> and <b>CLUSREG_DELETE_VALUE</b> commands.
    const(ubyte)*       lpData;
    ///The count, in bytes, of the data relative to the command issued by <b>Command</b>. The value of this member is 0
    ///for all the commands except the <b>CLUSREG_SET_VALUE</b> and <b>CLUSREG_DELETE_VALUE</b> commands.
    uint                cbData;
}

///Represents a result for a single command in a read batch.
struct CLUSTER_READ_BATCH_COMMAND
{
    ///The command result status, which can be one of these values.
    CLUSTER_REG_COMMAND Command;
    ///The registry value type or the read error type, depending on the <i>Command</i> result.
    uint                dwOptions;
    ///The name of the key requested in the read command.
    const(PWSTR)        wzSubkeyName;
    ///The name of the value requested in the read command.
    const(PWSTR)        wzValueName;
    ///A pointer to value data.
    const(ubyte)*       lpData;
    ///The count, in bytes, of the <i>lpData</i> value data.
    uint                cbData;
}

///Contains the properties of a cluster object. This structure is used to enumerate clusters in the ClusterEnumEx and
///ClusterNodeEnumEx functions.
struct CLUSTER_ENUM_ITEM
{
    ///The version of the <b>CLUSTER_ENUM_ITEM</b> structure.
    uint  dwVersion;
    ///A bitmask that specifies the type of the cluster object.
    uint  dwType;
    ///The size, in bytes, of the <b>lpszId</b> field.
    uint  cbId;
    ///The ID of the cluster.
    PWSTR lpszId;
    ///The size, in bytes, of the <b>lpszName</b> field.
    uint  cbName;
    ///The name of the cluster.
    PWSTR lpszName;
}

///Allows the caller to provide additional properties when creating a new group.
struct CLUSTER_CREATE_GROUP_INFO
{
    ///The version of the <b>CLUSTER_CREATE_GROUP_INFO</b>. Currently this is set to
    ///(<b>CLUSTER_CREATE_GROUP_INFO_VERSION_1</b> (0x00000001).
    uint           dwVersion;
    CLUSGROUP_TYPE groupType;
}

///Passes in the path to validate...TBD
struct CLUSTER_VALIDATE_PATH
{
    ushort szPath;
}

///Passes in the directory to validate...TBD
struct CLUSTER_VALIDATE_DIRECTORY
{
    ushort szPath;
}

///Passes in the network name to validate...TBD
struct CLUSTER_VALIDATE_NETNAME
{
    ushort szNetworkName;
}

///Represents a cluster shared volume (CSV) during a validation operation.
struct CLUSTER_VALIDATE_CSV_FILENAME
{
    ///A Unicode string that contains the volume name of the CSV. The string ends with a terminating null character. The
    ///name provided can be either the cluster-assigned friendly name or the volume <b>GUID</b> path of the form
    ///"\\?\Volume{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}\".
    ushort szFileName;
}

///Used by the SetClusterServiceAccountPassword function to return the results of a Cluster service user account
///password change for each cluster node.
struct CLUSTER_SET_PASSWORD_STATUS
{
    ///Identifies the node on which the password change attempt was made.
    uint  NodeId;
    ///If <b>TRUE</b>, indicates that the password change was attempted on this node.
    ubyte SetAttempted;
    uint  ReturnStatus;
}

///Describes an IP address for a cluster.
struct CLUSTER_IP_ENTRY
{
    ///A <b>NULL</b>-terminated Unicode string containing a valid IPv4 or IPv6 numeric network address.
    const(PWSTR) lpszIpAddress;
    ///Specifies the number of bits in the subnet mask, for example 24 for an IPv4 netmask of 255.255.255.0.
    uint         dwPrefixLength;
}

///Defines the initial cluster configuration. This structure is passed in the <i>pConfig</i> parameter to the
///CreateCluster function.
struct CREATE_CLUSTER_CONFIG
{
    ///Version. Set this to <b>CLUSAPI_VERSION</b>.
    uint              dwVersion;
    ///Name of the cluster.
    const(PWSTR)      lpszClusterName;
    ///Count of nodes in the array pointed to by the <b>ppszNodeNames</b> member.
    uint              cNodes;
    ///Address of array of pointers to strings, each naming a node to be added to the new cluster.
    PWSTR*            ppszNodeNames;
    ///Count of nodes in the array pointed to by the <b>pIpEntries</b> member. If zero (0), no IP Address or Network
    ///Name resources will be created.
    uint              cIpEntries;
    ///Address of array of pointers to CLUSTER_IP_ENTRY structures, each naming a node to be added to the new cluster.
    ///Each entry will be used to configure a separate IP Address resource, and a Network Name resource will be created
    ///which depends on all of these IP Address resources in a logical <b>OR</b> manner.
    CLUSTER_IP_ENTRY* pIpEntries;
    ///If <b>TRUE</b>, then the cluster is to be created without any nodes and the <b>cIpEntries</b> member must be zero
    ///(0) and the <b>pIpEntries</b> member must be <b>NULL</b>. If <b>FALSE</b>, then the cluster is to be created with
    ///at least one node and the <b>cIpEntries</b> member must be one (1) or more, the <b>pIpEntries</b> member must not
    ///be <b>NULL</b>, the <b>cNodes</b> member must be one (1) or more, the <b>ppszNodeNames</b> member must not be
    ///<b>NULL</b>, and the <b>lpszClusterName</b> member must not be <b>NULL</b>.
    ubyte             fEmptyCluster;
    ///A CLUSTER_MGMT_POINT_TYPE value that specifies the management point type. If the value of the
    ///<b>fEmptyCluster</b> member of this structure is TRUE, this member is ignored and the structure is treated as if
    ///this member were set to <b>CLUSTER_MGMT_POINT_TYPE_NONE</b>. If the <b>dwVersion</b> member of this structure is
    ///set to a value less than <b>CLUSAPI_VERSION_WINDOWSBLUE</b>, the value of this member is ignored and the
    ///structure is treated as if this member were set to <b>CLUSTER_MGMT_POINT_TYPE_CNO</b>. <b>Windows Server 2012,
    ///Windows Server 2008 R2 and Windows Server 2008: </b>This member is not supported before Windows Server 2012 R2.
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
}

///Describes a cluster name resource and domain credentials used by the CreateClusterNameAccount function to add a
///cluster to a domain. <b>PCREATE_CLUSTER_NAME_ACCOUNT</b> defines a pointer to this structure.
struct CREATE_CLUSTER_NAME_ACCOUNT
{
    ///The major version of the OS that runs on the cluster. This member must be set to a value greater than
    ///<b>CLUSAPI_VERSION_WINDOWSBLUE</b>.
    uint         dwVersion;
    ///The cluster name that represents the cluster on the domain.
    const(PWSTR) lpszClusterName;
    ///Reserved for future use. This value must be "0".
    uint         dwFlags;
    ///The user name for the domain credentials.
    const(PWSTR) pszUserName;
    ///The password for the domain credentials.
    const(PWSTR) pszPassword;
    ///The domain name to join.
    const(PWSTR) pszDomain;
    ///The management point type.
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
    ubyte        bUpgradeVCOs;
}

///Represents a filter for a notification port that was created by the CreateClusterNotifyPortV2 function. A filter
///specifies that a notification port accept notifications for the specified type of cluster object during the specified
///event.
struct NOTIFY_FILTER_AND_TYPE
{
    ///A CLUSTER_OBJECT_TYPE enumeration value that specifies the cluster object type for the filter.
    uint dwObjectType;
    ///A CLUSTER_CHANGE_CLUSTER_V2 enumeration value that specifies the type for the filter.
    long FilterFlags;
}

///Represents membership information for a cluster.
struct CLUSTER_MEMBERSHIP_INFO
{
    ///<b>TRUE</b> if the cluster has a majority quorum; otherwise <b>FALSE</b>.
    BOOL     HasQuorum;
    ///The size of the <i>Upnodes</i> parameter.
    uint     UpnodesSize;
    ///A byte array that specifies the nodes in the cluster that are online.
    ubyte[1] Upnodes;
}

struct CLUSTER_AVAILABILITY_SET_CONFIG
{
    uint dwVersion;
    uint dwUpdateDomains;
    uint dwFaultDomains;
    BOOL bReserveSpareNode;
}

///Contains the properties of a cluster group. This structure is used to enumerate cluster groups in the
///ClusterGroupEnumEx function.
struct CLUSTER_GROUP_ENUM_ITEM
{
    ///The version of the <b>CLUSTER_GROUP_ENUM_ITEM</b> structure.
    uint                dwVersion;
    ///The size, in bytes, of the <b>lpszId</b> field.
    uint                cbId;
    ///The Id of the cluster group.
    PWSTR               lpszId;
    ///The size, in bytes, of the <b>IpszName</b> field.
    uint                cbName;
    ///The name of the cluster group.
    PWSTR               lpszName;
    ///The current state of the cluster group.
    CLUSTER_GROUP_STATE state;
    ///The size, in bytes, of the <b>IpszOwnerNode</b> field.
    uint                cbOwnerNode;
    ///The name of the cluster node hosting the group.
    PWSTR               lpszOwnerNode;
    ///The group flags.
    uint                dwFlags;
    ///The size, in bytes, of the <b>pProperties</b> field.
    uint                cbProperties;
    ///A pointer to a list of names of common properties.
    void*               pProperties;
    ///The size, in bytes, of the <b>pRoProperties</b> field.
    uint                cbRoProperties;
    void*               pRoProperties;
}

///Represents the properties of a cluster resource. This structure is used to enumerate cluster resources in the
///ClusterResourceEnumEx function.
struct CLUSTER_RESOURCE_ENUM_ITEM
{
    ///The version of this structure.
    uint  dwVersion;
    ///The size, in bytes, of the <b>lpszId</b> field.
    uint  cbId;
    ///The ID of the cluster resource.
    PWSTR lpszId;
    ///The size, in bytes, of the <b>IpszName</b> field.
    uint  cbName;
    ///The name of the cluster resource.
    PWSTR lpszName;
    ///The size, in bytes, of the <b>IpszOwnerNode</b> field.
    uint  cbOwnerGroupName;
    ///The name of the cluster resource that hosts the group.
    PWSTR lpszOwnerGroupName;
    ///The size, in bytes, of the <b>lpszOwnerGroupId</b> field.
    uint  cbOwnerGroupId;
    ///The group ID of the cluster group for the resource.
    PWSTR lpszOwnerGroupId;
    ///The size, in bytes, of the <b>pProperties</b> field.
    uint  cbProperties;
    ///A pointer to a list of names of common properties.
    void* pProperties;
    ///The size, in bytes, of the <b>pRoProperties</b> field.
    uint  cbRoProperties;
    ///A pointer to a list of names of read-only common properties.
    void* pRoProperties;
}

///Represents information about the Failover attempts for a group failure.
struct GROUP_FAILURE_INFO
{
    ///The number of remaining failover attempts that can be made on the group during the current FailoverPeriod time
    ///interval.
    uint dwFailoverAttemptsRemaining;
    ///The amount of time remaining for the FailoverPeriod, in hours.
    uint dwFailoverPeriodRemaining;
}

///Represents a buffer for a GROUP_FAILURE_INFO structure.
struct GROUP_FAILURE_INFO_BUFFER
{
    ///The version of this structure. Set this parameter to <b>GROUP_FAILURE_INFO_VERSION_1</b> (0x1).
    uint               dwVersion;
    ///The GROUP_FAILURE_INFO structure that contains information about the failover attempts for the group failure.
    GROUP_FAILURE_INFO Info;
}

///Represents information about the Failover attempts for a resource. This structure is used by the
///RESOURCE_FAILURE_INFO_BUFFER structure.
struct RESOURCE_FAILURE_INFO
{
    ///The number of remaining failover attempts that can be made on the resource during the current FailoverPeriod time
    ///interval.
    uint dwRestartAttemptsRemaining;
    ///The amount of time remaining for the FailoverPeriod, in seconds.
    uint dwRestartPeriodRemaining;
}

///Represents a buffer for a resource failure.
struct RESOURCE_FAILURE_INFO_BUFFER
{
    ///The version of this structure. Set this parameter to <b>RESOURCE_FAILURE_INFO_VERSION_1</b> (0x1).
    uint dwVersion;
    ///The RESOURCE_FAILURE_INFO structure that contains information about the failover attempts for the resource
    ///failure.
    RESOURCE_FAILURE_INFO Info;
}

///Represents a buffer for a terminal failure for a resource.
struct RESOURCE_TERMINAL_FAILURE_INFO_BUFFER
{
    ///<b>TRUE</b> if the resource failure is a terminal failure; otherwise, <b>FALSE</b>.
    BOOL isTerminalFailure;
    ///The amount of time remaining for the TBD, in seconds.
    uint restartPeriodRemaining;
}

///Describes the format and type of a data value. It is used as the <b>Syntax</b> member of the CLUSPROP_VALUE
///structure.
union CLUSPROP_SYNTAX
{
    ///A DWORD that describes the format and type of the data value. The CLUSTER_PROPERTY_SYNTAX enumeration defines the
    ///possible values.
    uint dw;
struct
    {
        ushort wFormat;
        ushort wType;
    }
}

///Describes the syntax and length of a data value used in a value list. The <b>CLUSPROP_VALUE</b> structure is used as
///a generic header in all of the structures that describe data of a particular type, such as CLUSPROP_BINARY and
///CLUSPROP_SZ.
struct CLUSPROP_VALUE
{
    ///CLUSPROP_SYNTAX union that describes a value.
    CLUSPROP_SYNTAX Syntax;
    ///Count of bytes in the data that follows this <b>CLUSPROP_VALUE</b> structure.
    uint            cbLength;
}

///Describes a binary data value. It is used as an entry in a value list and consists of: <ul> <li>A CLUSPROP_VALUE
///structure with a value of <b>CLUSPROP_SYNTAX_LIST_VALUE_BINARY</b> (0x00010001).</li> <li>A byte array containing the
///data.</li> </ul>
struct CLUSPROP_BINARY
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5092_C41;
    ///Array of bytes containing the data.
    ubyte          rgb;
}

///Describes numeric data. It is used as an entry in a value list and consists of: <ul> <li>A CLUSPROP_VALUE structure
///describing the format, type, and length of the numeric data.</li> <li>A <b>WORD</b> value.</li> </ul>
struct CLUSPROP_WORD
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5102_C39;
    ///Numeric value.
    ushort         w;
}

///Describes a numeric value identifying the physical drive of a disk. It is used as an entry in a value list and
///consists of: <ul> <li>A CLUSPROP_VALUE structure describing the format, type, and length of the numeric data.</li>
///<li>A <b>DWORD</b> value identifying the physical drive of a disk.</li> </ul>For convenience, the CLUSPROP_VALUE
///members are listed explicitly.
struct CLUSPROP_DWORD
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5112_C40;
    ///Numeric value identifying the physical drive of the disk. Valid values begin at zero.
    uint           dw;
}

///Describes signed <b>LONG</b> data. It is used as an entry in a value list and consists of: <ul> <li>A CLUSPROP_VALUE
///structure describing the format, type, and length of the numeric data.</li> <li>A <b>LONG</b> value.</li> </ul>
struct CLUSPROP_LONG
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5122_C39;
    ///Signed <b>LONG</b> value.
    int            l;
}

///Describes multiple <b>NULL</b>-terminated Unicode strings. It is used as an entry in a value list and consists of:
///<ul> <li>A CLUSPROP_VALUE structure describing the format, type, and length of the partition information.</li> <li>A
///string array.</li> </ul>For convenience, the CLUSPROP_VALUE members are listed explicitly.
struct CLUSPROP_SZ
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5132_C37;
    ///Multiple null-terminated Unicode strings with the last string followed by an additional <b>NULL</b>-terminating
    ///character.
    ushort         sz;
}

///Describes an unsigned large integer. It is used as an entry in a value list and consists of: <ul> <li>A
///CLUSPROP_VALUE structure indicating the format and type of the integer value.</li> <li>An unsigned large integer
///value.</li> </ul>
struct CLUSPROP_ULARGE_INTEGER
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5149_C14;
    ///Unsigned large integer value.
    ULARGE_INTEGER li;
}

///Describes a signed large integer. It is used as an entry in a value list and consists of: <ul> <li>A CLUSPROP_VALUE
///structure indicating the format and type of the integer value.</li> <li>Assigned large integer value.</li> </ul>
struct CLUSPROP_LARGE_INTEGER
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5162_C14;
    ///Signed large integer value.
    LARGE_INTEGER  li;
}

///Describes a security descriptor. It is used as an entry in a value list and consists of: <ul> <li>A CLUSPROP_VALUE
///structure indicating the format and type of the resource class information.</li> <li>A security descriptor in
///self-relative format.</li> </ul>
struct CLUSPROP_SECURITY_DESCRIPTOR
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5174_C54;
union
    {
        SECURITY_DESCRIPTOR_RELATIVE sd;
        ubyte rgbSecurityDescriptor;
    }
}

///Describes a date and time stamp for a file. It is used as an entry in a value list and consists of: <ul> <li>A
///CLUSPROP_VALUE structure indicating the format and type of the FILETIME value.</li> <li>A FILETIME value.</li>
///</ul>For convenience, the CLUSPROP_VALUE members are listed explicitly.
struct CLUSPROP_FILETIME
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5188_C14;
    ///A date and time value.
    FILETIME       ft;
}

///Contains resource class data. It is used as the data member of a CLUSPROP_RESOURCE_CLASS_INFO structure and as the
///return value of some control code operations.
struct CLUS_RESOURCE_CLASS_INFO
{
union
    {
struct
        {
union
            {
                uint dw;
                CLUSTER_RESOURCE_CLASS rc;
            }
            uint SubClass;
        }
        ULARGE_INTEGER li;
    }
}

///Describes a resource class. It is used as an entry in a value list and consists of: <ul> <li>A CLUSPROP_VALUE
///structure describing the format, type, and length of the resource class value.</li> <li>A CLUSTER_RESOURCE_CLASS
///value describing the resource class. <b>CLUSTER_RESOURCE_CLASS</b> is an enumeration defined in ClusAPI.h.</li> </ul>
struct CLUSPROP_RESOURCE_CLASS
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5213_C14;
    ///Resource class described with one of these values enumerated by the CLUSTER_RESOURCE_CLASS enumeration.
    CLUSTER_RESOURCE_CLASS rc;
}

///Describes information relating to a resource class. It is used as an entry in a value list and consists of: <ul>
///<li>A CLUSPROP_VALUE structure indicating the format and type of the resource class information.</li> <li>A
///CLUS_RESOURCE_CLASS_INFO structure describing the resource class and subclass of the resource.</li> </ul>
struct CLUSPROP_RESOURCE_CLASS_INFO
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5224_C14;
    CLUS_RESOURCE_CLASS_INFO __AnonymousBase_clusapi_L5225_C14;
}

///Describes a resource that is a required dependency of another resource. This union is used as a value in the value
///list returned from a CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES or CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES
///control code operation.
union CLUSPROP_REQUIRED_DEPENDENCY
{
    ///CLUSPROP_VALUE structure describing whether the data in the structure is a resource class or resource type name.
    CLUSPROP_VALUE Value;
    ///Resource class upon which a resource must depend. One of the following values are valid.
    CLUSPROP_RESOURCE_CLASS ResClass;
    ///Resource type upon which a resource must depend, such as IP Address.
    CLUSPROP_SZ    ResTypeName;
}

///Specifies information about the list of nodes sufficient to establish quorum in a majority-of-nodes cluster.
struct CLUS_FORCE_QUORUM_INFO
{
    ///The total size of the structure, including the nodes list.
    uint      dwSize;
    ///A bit mask representing the maximum assumed node set.
    uint      dwNodeBitMask;
    ///The number of bits set in the mask
    uint      dwMaxNumberofNodes;
    ///The names of the nodes that are sufficient to establish quorum in a majority-of-nodes cluster. This list should
    ///be comma delimited with no spaces.
    ushort[1] multiszNodeList;
}

///Contains data describing a storage class resource volume and file system. It is used as the data member of a
///CLUSPROP_PARTITION_INFO structure and as the return value of some control code operations.
struct CLUS_PARTITION_INFO
{
    ///Flags that describes the storage class resource, enumerated by the CLUSPROP_PIFLAGS enumeration.
    uint        dwFlags;
    ///Device name for the storage class resource, such as "C:". No backslash is included.
    ushort[260] szDeviceName;
    ///Volume label for the storage class resource.
    ushort[260] szVolumeLabel;
    ///Serial number of the storage class resource volume.
    uint        dwSerialNumber;
    ///Value of the maximum length, in characters, of a file name component supported by the specified file system. A
    ///file name component is the portion of a file name between backslashes.
    uint        rgdwMaximumComponentLength;
    ///Value that describes the file system. One or more of the following flags are valid.
    uint        dwFileSystemFlags;
    ///Name of the file system, such as "FAT" or "NTFS".
    ushort[32]  szFileSystem;
}

///Describes a storage class resource volume and file system. It is used as the data member of a CLUSPROP_PARTITION_INFO
///structure and as the return value of some control code operations.
struct CLUS_PARTITION_INFO_EX
{
    ///Flags that describes the storage class resource, enumerated by the CLUSPROP_PIFLAGS enumeration.
    uint           dwFlags;
    ///Device name for the storage class resource, such as "C:". No backslashes are included.
    ushort[260]    szDeviceName;
    ///Volume label for the storage class resource.
    ushort[260]    szVolumeLabel;
    ///Serial number of the storage class resource volume.
    uint           dwSerialNumber;
    ///Maximum length, in characters, of a file name component supported by the specified file system. A file name
    ///component is that portion of a file name between backslashes.
    uint           rgdwMaximumComponentLength;
    ///Flags that describes the file system. One or more of the following flags are valid.
    uint           dwFileSystemFlags;
    ///Name of the file system, such as "FAT" or "NTFS".
    ushort[32]     szFileSystem;
    ///Specifies the total size, in bytes, of the volume. This value may not be properly aligned and should be accessed
    ///using <b>UNALIGNED</b> pointers.
    ULARGE_INTEGER TotalSizeInBytes;
    ///Specifies the size, in bytes, of the unallocated space on the volume. This value may not be properly aligned and
    ///should be accessed using <b>UNALIGNED</b> pointers.
    ULARGE_INTEGER FreeSizeInBytes;
    ///The device number
    uint           DeviceNumber;
    ///The partition number.
    uint           PartitionNumber;
    ///The globally unique identifier associated with the volume.
    GUID           VolumeGuid;
}

///Describes the disk partition information of a storage class resource. This structure is used as the data member of a
///CLUSPROP_PARTITION_INFO_EX2 structure.
struct CLUS_PARTITION_INFO_EX2
{
    ///The globally unique identifier (GUID) of the partition.
    GUID        GptPartitionId;
    ///The name of the partition.
    ushort[260] szPartitionName;
    ///A flag that indicates whether BitLocker encryption is enabled on the partion.
    uint        EncryptionFlags;
}

///Represents information about a cluster shared volume (CSV).
struct CLUS_CSV_VOLUME_INFO
{
    ///The physical offset, in bytes, of the data on the CSV.
    ULARGE_INTEGER VolumeOffset;
    ///The partition number of the CSV.
    uint           PartitionNumber;
    ///A CLUSTER_CSV_VOLUME_FAULT_STATE enumeration value that specifies the fault state of the CSV.
    CLUSTER_CSV_VOLUME_FAULT_STATE FaultState;
    ///A CLUSTER_SHARED_VOLUME_BACKUP_STATE enumeration value that specifies the state of the CSV backup.
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    ///The friendly name of the CSV.
    ushort[260]    szVolumeFriendlyName;
    ///The volume <b>GUID</b> path of the CSV.
    ushort[50]     szVolumeName;
}

///Represents the name of a cluster shared volume (CSV).
struct CLUS_CSV_VOLUME_NAME
{
    ///The physical offset, in bytes, of the data on the CSV.
    LARGE_INTEGER VolumeOffset;
    ///A Unicode string that contains the volume name of the CSV. The string has a terminating null character. The name
    ///provided can be either the cluster-assigned friendly name or the volume <b>GUID</b> path of the form
    ///"\\?\Volume{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}\".
    ushort[260]   szVolumeName;
    ///The root path of the CSV.
    ushort[263]   szRootPath;
}

///Represents information about the state of a Cluster Shared Volume (CSV).
struct CLUSTER_SHARED_VOLUME_STATE_INFO
{
    ///A Unicode string that contains the volume name of the CSV. The string ends in a terminating null character. The
    ///name that is provided can be either the cluster-assigned friendly name or the volume GUID path of the form
    ///"\\?\Volume{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}\".
    ushort[260] szVolumeName;
    ///The node name of the node that hosts the CSV.
    ushort[260] szNodeName;
    ///A CLUSTER_SHARED_VOLUME_STATE enumeration value that specifies the state of the CSV.
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
}

///Represents information about the state of a Cluster Shared Volume (CSV).
struct CLUSTER_SHARED_VOLUME_STATE_INFO_EX
{
    ///A Unicode string that contains the volume name of the CSV. The string ends in a terminating null character. The
    ///name that is provided can be either the cluster-assigned friendly name or the volume GUID path of the form
    ///"\\?\Volume{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}\".
    ushort[260] szVolumeName;
    ///The node name of the node that hosts the CSV.
    ushort[260] szNodeName;
    ///A CLUSTER_SHARED_VOLUME_STATE enumeration value that specifies the state of the CSV.
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
    ///The friendly name of the CSV.
    ushort[260] szVolumeFriendlyName;
    ///A bitmask that specifies more specific reasons for the values stated in the <i>VolumeRedirectedIOReason</i>
    ///parameter. This member can contain one or more of the following values:
    ulong       RedirectedIOReason;
    ///A bitmask that specifies the reasons that direct access mode is enabled on the CSV. This member can contain one
    ///or more of the following values:
    ulong       VolumeRedirectedIOReason;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME
{
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE InputType;
union
    {
        ulong       VolumeOffset;
        ushort[260] VolumeId;
        ushort[260] VolumeName;
        ushort[50]  VolumeGuid;
    }
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_NAME
{
    ushort[260] NewVolumeName;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_GUID_NAME
{
    ushort[260] NewVolumeName;
    ushort[50]  NewVolumeGuid;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT
{
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME __AnonymousBase_clusapi_L5427_C14;
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_NAME __AnonymousBase_clusapi_L5428_C14;
}

struct CLUSTER_SHARED_VOLUME_RENAME_GUID_INPUT
{
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME __AnonymousBase_clusapi_L5438_C14;
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_GUID_NAME __AnonymousBase_clusapi_L5439_C14;
}

///Represents information about a Chkdsk operation.
struct CLUS_CHKDSK_INFO
{
    ///The ID of the partition on which the Chkdsk operation is being performed.
    uint     PartitionNumber;
    ///The state of the Chkdsk operation.
    uint     ChkdskState;
    ///The number of files that were identified by the Chkdsk operation.
    uint     FileIdCount;
    ///A list of file IDs that were identified by the Chkdsk operation.
    ulong[1] FileIdList;
}

///Represents information about the disk number of a physical disk.
struct CLUS_DISK_NUMBER_INFO
{
    ///The disk number of the disk.
    uint DiskNumber;
    ///The size of the disk sectors, in bytes.
    uint BytesPerSector;
}

///Describes the backup mode for cluster shared volume (CSV). Used by the CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE
///control code.
struct CLUS_SHARED_VOLUME_BACKUP_MODE
{
    ///Value from CLUSTER_SHARED_VOLUME_BACKUP_STATE enumeration.
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    ///If the <b>BackupState</b> member is set to <b>VolumeBackupNone</b> then this member must be set to 0. Otherwise
    ///this member must be set to a nonzero value.
    uint        DelayTimerInSecs;
    ///Null-terminated Unicode string containing the name of the shared volume. The name provided can be either the
    ///cluster-assigned friendly name or the volume GUID path of the form
    ///"\\?\Volume{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}\".
    ushort[260] VolumeName;
}

///Contains information relevant to storage class resources. It is used as an entry in a value list and consists of:
///<ul> <li>A CLUSPROP_VALUE structure describing the format, type, and length of the partition information.</li> <li>A
///CLUS_PARTITION_INFO structure.</li> </ul>For convenience, the CLUSPROP_VALUE and CLUS_PARTITION_INFO members are
///listed explicitly.
struct CLUSPROP_PARTITION_INFO
{
    CLUSPROP_VALUE      __AnonymousBase_clusapi_L5470_C14;
    CLUS_PARTITION_INFO __AnonymousBase_clusapi_L5471_C14;
}

///Specifies a collection of information about a physical disk resource, such as its device name and volume label. The
///<b>CLUSPROP_PARTITION_INFO_EX</b> structure contains information relevant to storage class resources. It is used as
///an entry in a value list and consists of: <ul> <li>A CLUSPROP_VALUE structure describing the format, type, and length
///of the partition information.</li> <li>A CLUS_PARTITION_INFO_EX structure.</li> </ul>
struct CLUSPROP_PARTITION_INFO_EX
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5482_C14;
    CLUS_PARTITION_INFO_EX __AnonymousBase_clusapi_L5483_C14;
}

///A value list entry that contains partition information for a storage class resource. This structure is as a input,
///and a as a return value for the CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX2 control code.
struct CLUSPROP_PARTITION_INFO_EX2
{
    CLUSPROP_PARTITION_INFO_EX __AnonymousBase_clusapi_L5496_C14;
    CLUS_PARTITION_INFO_EX2 __AnonymousBase_clusapi_L5497_C14;
}

///Contains information about an FT (fault tolerant) set. This structure is used by the CLUSPROP_FTSET_INFO structure to
///create an entry in a value list.
struct CLUS_FTSET_INFO
{
    ///The root signature of the FT set.
    uint dwRootSignature;
    ///The type of fault tolerance that is supported by the FT set.
    uint dwFtType;
}

///Contains information about an FT (fault tolerant) set. It is used as an entry in a value list and consists of a
///CLUSPROP_VALUE and a CLUS_FTSET_INFO structure.
struct CLUSPROP_FTSET_INFO
{
    CLUSPROP_VALUE  __AnonymousBase_clusapi_L5518_C14;
    CLUS_FTSET_INFO __AnonymousBase_clusapi_L5519_C14;
}

///Contains SCSI address data. It is used as the data member of a CLUSPROP_SCSI_ADDRESS structure and as the return
///value of some control code operations.
struct CLUS_SCSI_ADDRESS
{
union
    {
struct
        {
            ubyte PortNumber;
            ubyte PathId;
            ubyte TargetId;
            ubyte Lun;
        }
        uint dw;
    }
}

///Describes an address for a SCSI device. It is used as an entry in a value list and consists of: <ul> <li>A
///CLUSPROP_VALUE structure indicating the format and type of the resource class information.</li> <li>A
///CLUS_SCSI_ADDRESS structure.</li> </ul>For convenience, the CLUSPROP_VALUE and CLUS_SCSI_ADDRESS members are listed
///explicitly.
struct CLUSPROP_SCSI_ADDRESS
{
    CLUSPROP_VALUE    __AnonymousBase_clusapi_L5546_C14;
    CLUS_SCSI_ADDRESS __AnonymousBase_clusapi_L5547_C14;
}

///Contains the data needed to request a token. It is used as the input parameter of the
///CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN control code.
struct CLUS_NETNAME_VS_TOKEN_INFO
{
    ///Process ID of the process requesting the token.
    uint ProcessID;
    ///Specifies an access mask that specifies the requested types of access. For a list of access rights for access
    ///tokens, see Access Rights for Access-Token Objects.
    uint DesiredAccess;
    ///Indicates whether the new handle is inheritable. If <b>TRUE</b>, the duplicate handle can be inherited by new
    ///processes created by the target process. If <b>FALSE</b>, the new handle cannot be inherited.
    BOOL InheritHandle;
}

///Provides information for resetting the security principal associated with a computer name.
struct CLUS_NETNAME_PWD_INFO
{
    ///Indicates if other fields in the structure have valid data.
    uint        Flags;
    ///Contains the new password for the alternate computer name's associated security principal.
    ushort[16]  Password;
    ///Contains the name of a directory server where the associated security principal object is stored. The total
    ///length includes the '\\' prefix.
    ushort[258] CreatingDC;
    ///Contains the ID of a security principal objecton a directory server.
    ushort[64]  ObjectGuid;
}

struct CLUS_NETNAME_PWD_INFOEX
{
    uint        Flags;
    ushort[128] Password;
    ushort[258] CreatingDC;
    ushort[64]  ObjectGuid;
}

///Represents the status of a Distributed Network Name (DNN) resource for a Scale-Out File Server.
struct CLUS_DNN_LEADER_STATUS
{
    ///<b>TRUE</b> if the Distributed Network Name (DNN) resource for the Scale-Out File Server is online; otherwise
    ///<b>FALSE</b>.
    BOOL IsOnline;
    ///<b>TRUE</b> if the file server is running; otherwise <b>FALSE</b>.
    BOOL IsFileServerPresent;
}

///Represents the status of a Scale-Out File Server clone.
struct CLUS_DNN_SODAFS_CLONE_STATUS
{
    ///The node ID of the clone.
    uint NodeId;
    ///A CLUSTER_RESOURCE_STATE enumeration value that specifies the status of the clone.
    CLUSTER_RESOURCE_STATE Status;
}

///Represents IP information for a NetName resource.
struct CLUS_NETNAME_IP_INFO_ENTRY
{
    ///The ID of the node that hosts the NetName resource.
    uint     NodeId;
    ///The size of the <i>BYTE</i> parameter, in bytes.
    uint     AddressSize;
    ///A byte array that contains the address of the NetName.
    ubyte[1] Address;
}

///Represents IP information for a NetName resource that has Multichannel enabled.
struct CLUS_NETNAME_IP_INFO_FOR_MULTICHANNEL
{
    ///An array of wide characters that specifies the name of the resource.
    ushort[64] szName;
    ///The number of channels that are specified by the <i>IpInfo</i> parameter.
    uint       NumEntries;
    ///An array of CLUS_NETNAME_IP_INFO_ENTRY structures that specify the IP info for each channel.
    CLUS_NETNAME_IP_INFO_ENTRY[1] IpInfo;
}

///Enables or disables maintenance mode on a cluster node.
struct CLUS_MAINTENANCE_MODE_INFO
{
    ///Set to <b>TRUE</b> to enable or <b>FALSE</b> to disable maintenance mode for the identified resource. When
    ///queried, a resource will return <b>True</b> or <b>False</b> to indicate the current maintenance mode state of the
    ///resource.
    BOOL InMaintenance;
}

///Used with the CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE control code to enables or disables the maintenance mode on a
///cluster shared volume (CSV).
struct CLUS_CSV_MAINTENANCE_MODE_INFO
{
    ///Specifies the maintenance mode for the CSV. <b>TRUE</b> enables maintenance mode, <b>FALSE</b> disables it.
    BOOL        InMaintenance;
    ///The volume <b>GUID</b> path of the CSV.
    ushort[260] VolumeName;
}

///Represents the extended maintenance mode settings for a storage class resource.
struct CLUS_MAINTENANCE_MODE_INFOEX
{
    ///Set to <b>TRUE</b> to enable or <b>FALSE</b> to disable maintenance mode for the identified resource. When
    ///queried, a resource will return <b>True</b> or <b>False</b> to indicate the current maintenance mode state of the
    ///resource.
    BOOL InMaintenance;
    ///Unless the resource in question is in a type of maintenance mode, this member is set to 0. Otherwise this member
    ///takes an <b>enumerator</b> from the MAINTENANCE_MODE_TYPE_ENUM enumeration as its value. The possible values of
    ///this member are as follows.
    MAINTENANCE_MODE_TYPE_ENUM MaintainenceModeType;
    ///This member represents the internal resource state. This field is valid only when written by the server. This
    ///member takes an enumerator from the CLUSTER_RESOURCE_STATE enumeration. The possible values of this member are as
    ///follows.
    CLUSTER_RESOURCE_STATE InternalState;
    ///A 32-bit integer that must contain the value 0xABBAF00F.
    uint Signature;
}

struct CLUS_SET_MAINTENANCE_MODE_INPUT
{
    BOOL     InMaintenance;
    uint     ExtraParameterSize;
    ubyte[1] ExtraParameter;
}

///Supplies drive letter information for a disk partition associated with a storage class resource.
struct CLUS_STORAGE_SET_DRIVELETTER
{
    ///A 32-bit integer that indicates a partition on the storage device.
    uint PartitionNumber;
    uint DriveLetterMask;
}

///Contains a bitmask of the driver letters that are available on a node. It is used as the return value of the
///CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DRIVELETTERS control code.
struct CLUS_STORAGE_GET_AVAILABLE_DRIVELETTERS
{
    ///The least significant bit represents the letter 'A' and is set to zero if any partition on the node has that
    ///drive letter in use. This convention continues until bit 26, which represents the letter 'Z'. The value of bits
    ///27 through 32 is not defined.
    uint AvailDrivelettersMask;
}

///Identifies the existing and target drive letter for a disk drive on a node.
struct CLUS_STORAGE_REMAP_DRIVELETTER
{
    ///A 32-bit bitmask indicating the drive letter to be changed. The least significant bit represents the drive letter
    ///'A' through bit 25, which represents the drive letter 'Z'.
    uint CurrentDriveLetterMask;
    uint TargetDriveLetterMask;
}

///Contains data about the state of a provider resource.
struct CLUS_PROVIDER_STATE_CHANGE_INFO
{
    ///The size of this structure including the provider name and the terminating null character.
    uint      dwSize;
    ///An enumerator from the CLUSTER_RESOURCE_STATE enumeration as its value. The following are the possible values for
    ///this member.
    CLUSTER_RESOURCE_STATE resourceState;
    ///The globally unique ID of the provider resource. This value can also be passed to the <i>lpszResourceName</i>
    ///parameter of the OpenClusterResource function instead of a resource's name.
    ushort[1] szProviderId;
}

struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_INPUT
{
    ushort[16] FileServerName;
}

struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_OUTPUT
{
    ushort[260] FileServerName;
}

///Accesses the beginning of a property list.
struct CLUSPROP_LIST
{
    ///Number of properties in the property list.
    uint        nPropertyCount;
    ///Structure describing the name of the first property in the list.
    CLUSPROP_SZ PropertyName;
}

///Describes the format for an entry in an event notification list.
struct FILESHARE_CHANGE
{
    ///Describes a change event. This value is taken from the FILESHARE_CHANGE_ENUMenumeration. The following are the
    ///possible values for this member.
    FILESHARE_CHANGE_ENUM Change;
    ///The name of the file share resource specific to this entry in the event notification list.
    ushort[84] ShareName;
}

///Describes an event notification list for file shares managed by the File Server resource.
struct FILESHARE_CHANGE_LIST
{
    ///The number of entries the event notification list contains.
    uint                NumEntries;
    ///An entry in the event notification list. The format of this member comes from the FILESHARE_CHANGE structure.
    FILESHARE_CHANGE[1] ChangeEntry;
}

///Specifies information about the last time a group was moved to another node.
struct CLUSCTL_GROUP_GET_LAST_MOVE_TIME_OUTPUT
{
    ///The number of milliseconds that have elapsed in the owning node, when the group was moved.
    ulong      GetTickCount64;
    ///The system date and time in the owning node, when the group was moved.
    SYSTEMTIME GetSystemTime;
    ///The unique ID of the node that owns the group.
    uint       NodeId;
}

///Used to build or parse a property list or, a value list.
union CLUSPROP_BUFFER_HELPER
{
    ///Pointer to a buffer containing an array of bytes.
    ubyte*             pb;
    ///Pointer to a buffer containing an array of <b>WORD</b> values.
    ushort*            pw;
    ///Pointer to a buffer containing an array of <b>DWORD</b> values.
    uint*              pdw;
    ///Pointer to a buffer containing an array of signed <b>long</b> values.
    int*               pl;
    ///Pointer to a buffer containing a <b>NULL</b>-terminated Unicode string value.
    PWSTR              psz;
    ///Pointer to a CLUSPROP_LIST structure describing the beginning of a property list.
    CLUSPROP_LIST*     pList;
    ///Pointer to a CLUSPROP_SYNTAX structure describing the format and type of a value.
    CLUSPROP_SYNTAX*   pSyntax;
    ///Pointer to a CLUSPROP_PROPERTY_NAME structure containing a property name value.
    CLUSPROP_SZ*       pName;
    ///Pointer to a CLUSPROP_VALUE structure describing the format, type, and length of a data value.
    CLUSPROP_VALUE*    pValue;
    ///Pointer to a CLUSPROP_BINARY structure containing a binary data value.
    CLUSPROP_BINARY*   pBinaryValue;
    ///Pointer to a CLUSPROP_WORD structure containing a numeric value.
    CLUSPROP_WORD*     pWordValue;
    ///Pointer to a CLUSPROP_DWORD structure containing a numeric value.
    CLUSPROP_DWORD*    pDwordValue;
    ///Pointer to a CLUSPROP_LONG structure containing a signed long value.
    CLUSPROP_LONG*     pLongValue;
    ///Pointer to a CLUSPROP_ULARGE_INTEGER structure containing an unsigned large integer value.
    CLUSPROP_ULARGE_INTEGER* pULargeIntegerValue;
    ///Pointer to a CLUSPROP_LARGE_INTEGER structure containing a large integer value.
    CLUSPROP_LARGE_INTEGER* pLargeIntegerValue;
    ///Pointer to a CLUSPROP_SZ structure containing a <b>NULL</b>-terminated Unicode string value.
    CLUSPROP_SZ*       pStringValue;
    ///Pointer to a CLUSPROP_MULTI_SZ structure containing multiple null-terminated Unicode string values.
    CLUSPROP_SZ*       pMultiSzValue;
    ///Pointer to a CLUSPROP_SECURITY_DESCRIPTOR structure containing a security descriptor.
    CLUSPROP_SECURITY_DESCRIPTOR* pSecurityDescriptor;
    ///Pointer to a CLUSPROP_RESOURCE_CLASS structure containing a resource class value.
    CLUSPROP_RESOURCE_CLASS* pResourceClassValue;
    ///Pointer to a CLUSPROP_RESOURCE_CLASS_INFO structure containing a resource class information value.
    CLUSPROP_RESOURCE_CLASS_INFO* pResourceClassInfoValue;
    ///Pointer to a CLUSPROP_DISK_SIGNATURE structure containing a disk signature value.
    CLUSPROP_DWORD*    pDiskSignatureValue;
    ///Pointer to a CLUSPROP_SCSI_ADDRESS structure containing an SCSI address value.
    CLUSPROP_SCSI_ADDRESS* pScsiAddressValue;
    ///Pointer to a CLUSPROP_DISK_NUMBER structure containing a disk number value.
    CLUSPROP_DWORD*    pDiskNumberValue;
    ///Pointer to a CLUSPROP_PARTITION_INFO structure containing a partition information value.
    CLUSPROP_PARTITION_INFO* pPartitionInfoValue;
    ///Pointer to a CLUSPROP_REQUIRED_DEPENDENCY structure containing a resource dependency value.
    CLUSPROP_REQUIRED_DEPENDENCY* pRequiredDependencyValue;
    ///Pointer to a CLUSPROP_PARTITION_INFO_EX structure containing a partition information value.
    CLUSPROP_PARTITION_INFO_EX* pPartitionInfoValueEx;
    ///A pointer to a CLUSPROP_PARTITION_INFO_EX2 structure that contains a partition information value. <b>Windows
    ///Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 and Windows Server 2008: </b>This member is not
    ///available before Windows Server 2016.
    CLUSPROP_PARTITION_INFO_EX2* pPartitionInfoValueEx2;
    ///Pointer to a CLUSPROP_FILETIME structure containing a date/time value.
    CLUSPROP_FILETIME* pFileTimeValue;
}

///Describes a replicated partition.
struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO
{
    ///Offset of the partition in the disk.
    ulong PartitionOffset;
    ///The capabilities of replicated partition
    uint  Capabilities;
}

///Lists the all replicated partitions on a disk.
struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_ARRAY
{
    ///The count of all replicated partitions on the disk.
    uint Count;
    ///A variable size array of all replicated partitions on the disk.
    SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO[1] PartitionArray;
}

///Describes a set of retrieved disks that can be used as log disks for the specified data disk.This is a data structure
///for a value list that is returned by the CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_LOGDISKS control code.
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_LOGDISKS
{
    ///The cluster resource identifier of the data disk.
    GUID  DataDiskGuid;
    ///When <b>TRUE</b>, the result set includes all the offline disks in the available storage group.
    ubyte IncludeOfflineDisks;
}

///Describes a set of retrieved data disks that can be used as target sites for replication.
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_TARGET_DATADISKS
{
    ///The cluster resource identifier of the data disk.
    GUID  SourceDataDiskGuid;
    ///The identifier of the replication group that contains the retrieved data disks.
    GUID  TargetReplicationGroupGuid;
    ///<b>true</b> if the disks that are connected to the same nodes as the source disk are included in result set.
    ubyte SkipConnectivityCheck;
    ///<b>true</b> if the result set includes all offline disks in the available storage group.
    ubyte IncludeOfflineDisks;
}

///Describes a set of retrieved data disks that can be used as source sites for replication.
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_SOURCE_DATADISKS
{
    ///The cluster resource identifier of the data disk.
    GUID  DataDiskGuid;
    ///<b>true</b> if the result set includes disks in the available storage group.
    ubyte IncludeAvailableStoargeDisks;
}

///Describes a set of information that indicates whether a disk is eligible for replication.
struct SR_RESOURCE_TYPE_DISK_INFO
{
    ///Indicates the reason that the disk is eligible or ineligible for replication.
    SR_DISK_REPLICATION_ELIGIBLE Reason;
    ///The cluster resource identifier of the disk.
    GUID DiskGuid;
}

///Describes a set of data disks retrieved by a resource type control code operation for storage replication.
struct SR_RESOURCE_TYPE_ELIGIBLE_DISKS_RESULT
{
    ///The number of retrieved disks.
    ushort Count;
    ///An array that contains the retrieved disk information.
    SR_RESOURCE_TYPE_DISK_INFO[1] DiskInfo;
}

///Represents a replicated disk.
struct SR_RESOURCE_TYPE_REPLICATED_DISK
{
    ///The type of the replicated disk.
    SR_REPLICATED_DISK_TYPE Type;
    ///The cluster resource identifier of the disk.
    GUID        ClusterDiskResourceGuid;
    ///The replication group identifier of the disk.
    GUID        ReplicationGroupId;
    ///The name of the replication group..
    ushort[260] ReplicationGroupName;
}

///Describes a retrieved set of replicated disks.
struct SR_RESOURCE_TYPE_REPLICATED_DISKS_RESULT
{
    ///The number of replicated disks in the result set.
    ushort Count;
    ///The retrieved array of replicated disks.
    SR_RESOURCE_TYPE_REPLICATED_DISK[1] ReplicatedDisks;
}

///Represents an input buffer for the CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INT control code.
struct CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INPUT
{
    ///A bifmask of flags that specifies settings for the operation. This member can contain the following values:
    uint dwFlags;
    ///A storage pool <b>GUID</b> that filters the results.
    GUID guidPoolFilter;
}

///Contains information about a resource that is being brought online or taken offline. This structure is used as a
///parameter to the callback function SetResourceStatus.
struct RESOURCE_STATUS
{
    ///A value describing the state of a resource enumerated by the CLUSTER_RESOURCE_STATE enumeration. The possible
    ///values for this member are as follows:
    CLUSTER_RESOURCE_STATE ResourceState;
    ///A value set by the resource DLL to flag a status report as new.
    uint   CheckPoint;
    ///This member is not being used at this time.
    uint   WaitHint;
    ///Handle to an event that indicates when the resource has failed.
    HANDLE EventHandle;
}

struct NodeUtilizationInfoElement
{
    ulong Id;
    ulong AvailableMemory;
    ulong AvailableMemoryAfterReclamation;
}

struct ResourceUtilizationInfoElement
{
    ulong PhysicalNumaId;
    ulong CurrentMemory;
}

///Represents context parameters that are used as input for the CLUSCTL_RESOURCE_GET_OPERATION_CONTEXT control code.
struct GET_OPERATION_CONTEXT_PARAMS
{
    ///The size of this structure, in bytes.
    uint Size;
    ///The version of this structure.
    uint Version;
    ///A RESDLL_CONTEXT_OPERATION_TYPE enumeration value that specifies the context operation type.
    RESDLL_CONTEXT_OPERATION_TYPE Type;
    ///TBD
    uint Priority;
}

///Contains information about a resource that is being brought online or taken offline. This structure is used as a
///parameter to the callback function SetResourceStatusEx.
struct RESOURCE_STATUS_EX
{
    ///A CLUSTER_RESOURCE_STATE enumeration value that describes the state of the resource.
    CLUSTER_RESOURCE_STATE ResourceState;
    ///A value set by the resource DLL to flag a status report as new.
    uint   CheckPoint;
    ///A handle to an event that indicates when the resource has failed.
    HANDLE EventHandle;
    ///TBD
    uint   ApplicationSpecificErrorCode;
    ///A bitmask of flags that specify settings for the operation. This member can contain one or more of the following
    ///values:
    uint   Flags;
    ///This member is not being used at this time. <b>Windows Server 2012: </b>This member was added in Windows Server
    ///2012 R2.
    uint   WaitHint;
}

///Contains pointers to all Resource API version 1.0 entry points except Startup.
struct CLRES_V1_FUNCTIONS
{
    ///Pointer to the Open entry point.
    POPEN_ROUTINE        Open;
    ///Pointer to the Close entry point.
    PCLOSE_ROUTINE       Close;
    ///Pointer to the Online entry point.
    PONLINE_ROUTINE      Online;
    ///Pointer to the Offline entry point.
    POFFLINE_ROUTINE     Offline;
    ///Pointer to the Terminate entry point.
    PTERMINATE_ROUTINE   Terminate;
    ///Pointer to the LooksAlive entry point.
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    ///Pointer to the IsAlive entry point.
    PIS_ALIVE_ROUTINE    IsAlive;
    ///Pointer to the Arbitrate entry point.
    PARBITRATE_ROUTINE   Arbitrate;
    ///Pointer to the Release entry point.
    PRELEASE_ROUTINE     Release;
    ///Pointer to the ResourceControl entry point.
    PRESOURCE_CONTROL_ROUTINE ResourceControl;
    ///Pointer to the ResourceTypeControl entry point.
    PRESOURCE_TYPE_CONTROL_ROUTINE ResourceTypeControl;
}

///Contains pointers to all Resource API version 2.0 entry points except StartupEx.
struct CLRES_V2_FUNCTIONS
{
    ///Pointer to the OpenV2 entry point.
    POPEN_V2_ROUTINE     Open;
    ///Pointer to the Close entry point.
    PCLOSE_ROUTINE       Close;
    ///Pointer to the OnlineV2 entry point.
    PONLINE_V2_ROUTINE   Online;
    ///Pointer to the OfflineV2 entry point.
    POFFLINE_V2_ROUTINE  Offline;
    ///Pointer to the Terminate entry point.
    PTERMINATE_ROUTINE   Terminate;
    ///Pointer to the LooksAlive entry point.
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    ///Pointer to the IsAlive entry point.
    PIS_ALIVE_ROUTINE    IsAlive;
    ///Pointer to the Arbitrate entry point.
    PARBITRATE_ROUTINE   Arbitrate;
    ///Pointer to the Release entry point.
    PRELEASE_ROUTINE     Release;
    ///Pointer to the ResourceControl entry point.
    PRESOURCE_CONTROL_ROUTINE ResourceControl;
    ///Pointer to the ResourceTypeControl entry point.
    PRESOURCE_TYPE_CONTROL_ROUTINE ResourceTypeControl;
    ///Pointer to the Cancel entry point.
    PCANCEL_ROUTINE      Cancel;
}

///Contains pointers to all Resource API version 3.0 entry points, except StartupEx.
struct CLRES_V3_FUNCTIONS
{
    ///Pointer to the OpenV2 entry point.
    POPEN_V2_ROUTINE     Open;
    ///Pointer to the Close entry point.
    PCLOSE_ROUTINE       Close;
    ///Pointer to the OnlineV2 entry point.
    PONLINE_V2_ROUTINE   Online;
    ///Pointer to the OfflineV2 entry point.
    POFFLINE_V2_ROUTINE  Offline;
    ///Pointer to the Terminate entry point.
    PTERMINATE_ROUTINE   Terminate;
    ///Pointer to the LooksAlive entry point.
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    ///Pointer to the IsAlive entry point.
    PIS_ALIVE_ROUTINE    IsAlive;
    ///Pointer to the Arbitrate entry point.
    PARBITRATE_ROUTINE   Arbitrate;
    ///Pointer to the Release entry point.
    PRELEASE_ROUTINE     Release;
    ///Pointer to the BeginResourceControl entry point.
    PBEGIN_RESCALL_ROUTINE BeginResourceControl;
    ///Pointer to the BeginResourceTypeControl entry point.
    PBEGIN_RESTYPECALL_ROUTINE BeginResourceTypeControl;
    ///Pointer to the Cancel entry point.
    PCANCEL_ROUTINE      Cancel;
}

///Contains pointers to all Resource API version 4.0 entry points, except StartupEx.
struct CLRES_V4_FUNCTIONS
{
    ///Pointer to the OpenV2 entry point.
    POPEN_V2_ROUTINE     Open;
    ///Pointer to the Close entry point.
    PCLOSE_ROUTINE       Close;
    ///Pointer to the OnlineV2 entry point.
    PONLINE_V2_ROUTINE   Online;
    ///Pointer to the OfflineV2 entry point.
    POFFLINE_V2_ROUTINE  Offline;
    ///Pointer to the Terminate entry point.
    PTERMINATE_ROUTINE   Terminate;
    ///Pointer to the LooksAlive entry point.
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    ///Pointer to the IsAlive entry point.
    PIS_ALIVE_ROUTINE    IsAlive;
    ///Pointer to the Arbitrate entry point.
    PARBITRATE_ROUTINE   Arbitrate;
    ///Pointer to the Release entry point.
    PRELEASE_ROUTINE     Release;
    ///Pointer to the BeginResourceControl entry point.
    PBEGIN_RESCALL_ROUTINE BeginResourceControl;
    ///Pointer to the BeginResourceTypeControl entry point.
    PBEGIN_RESTYPECALL_ROUTINE BeginResourceTypeControl;
    ///Pointer to the Cancel entry point.
    PCANCEL_ROUTINE      Cancel;
    ///Pointer to the BeginResourceControlAsUser entry point.
    PBEGIN_RESCALL_AS_USER_ROUTINE BeginResourceControlAsUser;
    ///Pointer to the BeginResourceTypeControlAsUser entry point.
    PBEGIN_RESTYPECALL_AS_USER_ROUTINE BeginResourceTypeControlAsUser;
}

///Describes a function table for any version of the Resource API.
struct CLRES_FUNCTION_TABLE
{
    ///Count of bytes in the structure. This can contain one of these values:
    uint TableSize;
    ///The supported version of the Resource API. This can contain one of these values:
    uint Version;
union
    {
        CLRES_V1_FUNCTIONS V1Functions;
        CLRES_V2_FUNCTIONS V2Functions;
        CLRES_V3_FUNCTIONS V3Functions;
        CLRES_V4_FUNCTIONS V4Functions;
    }
}

///Describes the default, maximum, and minimum values allowed for a signed large integer.
struct RESUTIL_LARGEINT_DATA
{
    ///The default value.
    LARGE_INTEGER Default;
    ///The minimum value.
    LARGE_INTEGER Minimum;
    ///The maximum value.
    LARGE_INTEGER Maximum;
}

///Describes the default, maximum, and minimum values allowed for an unsigned large integer.
struct RESUTIL_ULARGEINT_DATA
{
    ///The default value.
    ULARGE_INTEGER Default;
    ///The minimum value.
    ULARGE_INTEGER Minimum;
    ///The maximum value.
    ULARGE_INTEGER Maximum;
}

///Describes the default, maximum, and minimum values allowed for a FILETIME.
struct RESUTIL_FILETIME_DATA
{
    FILETIME Default;
    FILETIME Minimum;
    FILETIME Maximum;
}

///Contains information about a cluster object property. An array of <b>RESUTIL_PROPERTY_ITEM</b> structures forms a
///property table which can be used in property operations.
struct RESUTIL_PROPERTY_ITEM
{
    ///The name of the property.
    PWSTR Name;
    ///Optional name of the cluster database subkey for the property. This parameter can be <b>NULL</b>.
    PWSTR KeyName;
    ///Describes the format of the property such as <b>CLUSPROP_FORMAT_BINARY</b> or <b>CLUSPROP_FORMAT_DWORD</b>. For a
    ///list of valid format values, see the <b>wFormat</b> member of CLUSPROP_SYNTAX.
    uint  Format;
union
    {
        size_t DefaultPtr;
        uint   Default;
        void*  lpDefault;
        RESUTIL_LARGEINT_DATA* LargeIntData;
        RESUTIL_ULARGEINT_DATA* ULargeIntData;
        RESUTIL_FILETIME_DATA* FileTimeData;
    }
    ///Minimum data value for the property. For data values with the <b>CLUSPROP_FORMAT_BINARY</b> and
    ///<b>CLUSPROP_FORMAT_MULTI_SZ</b> formats, the <b>Minimum</b> member contains the byte size of the default data
    ///value specified by <b>Default</b>.
    uint  Minimum;
    ///Maximum data value for the property.
    uint  Maximum;
    ///Bitmask that describes the property.
    uint  Flags;
    ///Byte offset to the actual property data. The data is stored in a buffer known as a parameter block.
    uint  Offset;
}

///Represents a function table for the StartupEx callback function.
struct CLRES_CALLBACK_FUNCTION_TABLE
{
    ///A pointer to the LogEvent entry point.
    PLOG_EVENT_ROUTINE  LogEvent;
    ///A pointer to the SetResourceStatusEx entry point.
    PSET_RESOURCE_STATUS_ROUTINE_EX SetResourceStatusEx;
    ///A pointer to the SetResourceLockedMode entry point.
    PSET_RESOURCE_LOCKED_MODE_ROUTINE SetResourceLockedMode;
    ///A pointer to the SignalFailure entry point.
    PSIGNAL_FAILURE_ROUTINE SignalFailure;
    ///A pointer to the SetResourceInMemoryNodeLocalProperties entry point.
    PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE SetResourceInMemoryNodeLocalProperties;
    ///A pointer to the EndControlCall entry point. <b>Windows Server 2012: </b>This member was added in Windows Server
    ///2012 R2.
    PEND_CONTROL_CALL   EndControlCall;
    ///A pointer to the EndTypeControlCall entry point. <b>Windows Server 2012: </b>This member was added in Windows
    ///Server 2012 R2.
    PEND_TYPE_CONTROL_CALL EndTypeControlCall;
    ///A pointer to the ExtendControlCall entry point. <b>Windows Server 2012 R2 and Windows Server 2012: </b>This
    ///member was added in Windows Server 2016.
    PEXTEND_RES_CONTROL_CALL ExtendControlCall;
    ///A pointer to the ExtendResTypeControlCall entry point. <b>Windows Server 2012 R2 and Windows Server 2012:
    ///</b>This member was added in Windows Server 2016.
    PEXTEND_RES_TYPE_CONTROL_CALL ExtendTypeControlCall;
    ///A pointer to the RaiseResTypeNotification entry point. <b>Windows Server 2012 R2 and Windows Server 2012:
    ///</b>This member was added in Windows Server 2016.
    PRAISE_RES_TYPE_NOTIFICATION RaiseResTypeNotification;
    ///A pointer to the ChangeResourceProcessForDumps entry point. <b>Windows Server 2012 R2 and Windows Server 2012:
    ///</b>This member was added in Windows Server 2016.
    PCHANGE_RESOURCE_PROCESS_FOR_DUMPS ChangeResourceProcessForDumps;
    ///A pointer to the ChangeResTypeProcessForDumps entry point. <b>Windows Server 2012 R2 and Windows Server 2012:
    ///</b>This member was added in Windows Server 2016.
    PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS ChangeResTypeProcessForDumps;
    ///A pointer to the SetInternalState entry point. <b>Windows Server 2012 R2 and Windows Server 2012: </b>This member
    ///was added in Windows Server 2016.
    PSET_INTERNAL_STATE SetInternalState;
    PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE SetResourceLockedModeEx;
}

///TBD
struct MONITOR_STATE
{
    LARGE_INTEGER LastUpdate;
    RESOURCE_MONITOR_STATE State;
    HANDLE        ActiveResource;
    BOOL          ResmonStop;
}

///Represents post-upgrade state information for the cluster service.
struct POST_UPGRADE_VERSION_INFO
{
    ///The major version of the cluster service after the upgrade.
    uint newMajorVersion;
    ///The minor version of the cluster service after the update.
    uint newUpgradeVersion;
    ///The major version of the cluster service before the upgrade. <div class="alert"><b>Tip</b> In some error
    ///conditions this field can be zero.</div> <div> </div>
    uint oldMajorVersion;
    ///The minor version of the cluster service before the upgrade. <div class="alert"><b>Tip</b> In some error
    ///conditions this field can be zero.</div> <div> </div>
    uint oldUpgradeVersion;
    ///Reserved.
    uint reserved;
}

///TBD
struct CLUSTER_HEALTH_FAULT
{
    ///TBD
    PWSTR Id;
    uint  ErrorType;
    ///TBD
    uint  ErrorCode;
    ///TBD
    PWSTR Description;
    ///TBD
    PWSTR Provider;
    ///TBD
    uint  Flags;
    uint  Reserved;
}

///TBD
struct CLUSTER_HEALTH_FAULT_ARRAY
{
    ///The number of faults in the array.
    uint numFaults;
    CLUSTER_HEALTH_FAULT* faults;
}

///Contains information about a worker thread.
struct CLUS_WORKER
{
    ///Handle to the worker thread.
    HANDLE hThread;
    ///Flag that indicates whether the thread is to be terminated.
    BOOL   Terminate;
}

struct _HCLUSCRYPTPROVIDER
{
}

///Contains the Paxos tag values of a cluster node, which stores information about the cluster configuration version of
///the node when the cluster uses a File Share witness.
struct PaxosTagCStruct
{
    ///TBD
    ulong __padding__PaxosTagVtable;
    ///TBD
    ulong __padding__NextEpochVtable;
    ///TBD
    ulong __padding__NextEpoch_DateTimeVtable;
    ///TBD
    ulong NextEpoch_DateTime_ticks;
    ///The next epoch of the cluster configuration.
    int   NextEpoch_Value;
    ///TBD
    uint  __padding__BoundryNextEpoch;
    ///TBD
    ulong __padding__EpochVtable;
    ///TBD
    ulong __padding__Epoch_DateTimeVtable;
    ///TBD
    ulong Epoch_DateTime_ticks;
    ///The epoch of the cluster configuration.
    int   Epoch_Value;
    ///TBD
    uint  __padding__BoundryEpoch;
    ///The sequence of the cluster configuration.
    int   Sequence;
    ///TBD
    uint  __padding__BoundrySequence;
}

///Contains information used to update and validate a PaxosTagCStruct structure.
struct WitnessTagUpdateHelper
{
    ///The cluster configuration version to validate.
    int             Version;
    ///The Paxos tag to update.
    PaxosTagCStruct paxosToSet;
    ///The Paxos tag to validate.
    PaxosTagCStruct paxosToValidate;
}

///Contains information used to validate a PaxosTagCStruct structure.
struct WitnessTagHelper
{
    ///The cluster configuration version to validate.
    int             Version;
    ///The Paxos tag to validate.
    PaxosTagCStruct paxosToValidate;
}

// Functions

///Determines whether the Cluster service is installed and running on a node. The <b>PCLUSAPI_GET_NODE_CLUSTER_STATE</b>
///type defines a pointer to this function.
///Params:
///    lpszNodeName = Pointer to a null-terminated Unicode string containing the name of the node to query. If <i>lpszNodeName</i> is
///                   <b>NULL</b>, the local node is queried.
///    pdwClusterState = Pointer to a value describing the state of the Cluster service on the node. A node will be described by one of
///                      the following NODE_CLUSTER_STATE enumeration values.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint GetNodeClusterState(const(PWSTR) lpszNodeName, uint* pdwClusterState);

///Opens a connection to a cluster and returns a handle to it.
///Params:
///    lpszClusterName = Specifies one of the following values: <ul> <li>Pointer to a null-terminated Unicode string containing the name
///                      of the cluster or one of the cluster nodes expressed as a NetBIOS name, a fully qualified DNS name, or an IP
///                      address. This produces an RPC cluster handle.</li> <li><b>NULL</b>, which produces an LPC handle to the cluster
///                      to which the local computer belongs.</li> </ul>
///Returns:
///    If the operation was successful, <b>OpenCluster</b> returns a cluster handle. <table> <tr> <th>Return
///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> <dt>0</dt> </dl> </td>
///    <td width="60%"> The operation was not successful. For more information about the error, call the function
///    GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HCLUSTER* OpenCluster(const(PWSTR) lpszClusterName);

///Opens a connection to a cluster and returns a handle to it.
///Params:
///    lpszClusterName = Specifies one of the following values: <ul> <li>Pointer to a null-terminated Unicode string containing the name
///                      of the cluster or one of the cluster nodes expressed as a NetBIOS name, a fully qualified DNS name, or an IP
///                      address. This produces an RPC cluster handle.</li> <li><b>NULL</b>, which produces an LPC handle to the cluster
///                      to which the local computer belongs.</li> </ul>
///    DesiredAccess = The requested access privileges. This may be any combination of <b>GENERIC_READ</b> (0x80000000),
///                    <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0) and undefined
///                    error may be returned. Using <b>GENERIC_ALL</b> is the same as calling OpenCluster.
///    GrantedAccess = Optional parameter that contains the address of a <b>DWORD</b> that will receive the access rights granted. If
///                    the <i>DesiredAccess</i> parameter is <b>MAXIMUM_ALLOWED</b> (0x02000000) then the <b>DWORD</b> pointed to by
///                    this parameter will contain the maximum privileges granted to this user.
///Returns:
///    If the operation was successful, <b>OpenClusterEx</b> returns a cluster handle. <table> <tr> <th>Return
///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> <dt>0</dt> </dl> </td>
///    <td width="60%"> The operation was not successful. For more information about the error, call the GetLastError
///    function. If the target server does not support the OpenClusterEx function (for example if the target server is
///    running Windows Server 2008 or earlier) then the <b>GetLastError</b> function will return
///    <b>RPC_S_PROCNUM_OUT_OF_RANGE</b> (1745). </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HCLUSTER* OpenClusterEx(const(PWSTR) lpszClusterName, uint DesiredAccess, uint* GrantedAccess);

///Closes a cluster handle. The <b>PCLUSAPI_CLOSE_CLUSTER</b> type defines a pointer to this function.
///Params:
///    hCluster = Handle to the cluster to close.
///Returns:
///    This function always returns <b>TRUE</b>.
///    
@DllImport("CLUSAPI")
BOOL CloseCluster(_HCLUSTER* hCluster);

///Sets the name for a cluster. The <b>PCLUSAPI_SetClusterName</b> type defines a pointer to this function.
///Params:
///    hCluster = Handle to a cluster to rename.
///    lpszNewClusterName = Pointer to a null-terminated Unicode string containing the new cluster name.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_RESOURCE_PROPERTIES_STORED</b>. If the operation fails,
///    the function returns a system error code.
///    
@DllImport("CLUSAPI")
uint SetClusterName(_HCLUSTER* hCluster, const(PWSTR) lpszNewClusterName);

///Retrieves a cluster's name and version. The <b>PCLUSAPI_GET_CLUSTER_INFORMATION</b> type defines a pointer to this
///function.
///Params:
///    hCluster = Handle to a cluster.
///    lpszClusterName = Pointer to a null-terminated Unicode string containing the name of the cluster identified by <i>hCluster</i>.
///    lpcchClusterName = Pointer to the size of the <i>lpszClusterName</i> buffer as a count of characters. On input, specify the maximum
///                       number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                       of characters in the resulting name, excluding the terminating <b>NULL</b>.
///    lpClusterInfo = Either <b>NULL</b> or a pointer to a CLUSTERVERSIONINFO structure describing the version of the Cluster service.
///                    When <i>lpClusterInfo</i> is not <b>NULL</b>, the <b>dwVersionInfoSize</b> member of this structure should be set
///                    as follows: <code>lpClusterInfo-&gt;dwVersionInfoSize = sizeof(CLUSTERVERSIONINFO);</code>
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code. The following is one of the possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The buffer pointed to by <i>lpszClusterName</i> is not big enough to hold the result. The
///    <i>lpcchClusterName</i> parameter returns the number of characters in the result, excluding the terminating
///    <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint GetClusterInformation(_HCLUSTER* hCluster, PWSTR lpszClusterName, uint* lpcchClusterName, 
                           CLUSTERVERSIONINFO* lpClusterInfo);

///Returns the name of a cluster's quorum resource. The <b>PCLUSAPI_GET_CLUSTER_QUORUM_RESOURCE</b> type defines a
///pointer to this function.
///Params:
///    hCluster = Handle to an existing cluster.
///    lpszResourceName = Pointer to a null-terminated Unicode string containing the name of the cluster's quorum resource. The name is
///                       read from the quorum resource's Name common property. Do not pass <b>NULL</b> for this parameter.
///    lpcchResourceName = Pointer to the size of the <i>lpszResourceName</i> buffer as a count of characters. On input, specify the maximum
///                        number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                        of characters in the resulting name, excluding the terminating <b>NULL</b>.
///    lpszDeviceName = Pointer to a null-terminated Unicode string containing the path to the location of the quorum log files
///                     maintained by the Cluster service. Do not pass <b>NULL</b> for this parameter.
///    lpcchDeviceName = Pointer to the size of the <i>lpszDeviceName</i> buffer as a count of characters. On input, specify the maximum
///                      number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                      of characters in the resulting name, excluding the terminating <b>NULL</b>.
///    lpdwMaxQuorumLogSize = Pointer to the maximum size (in bytes) of the log being maintained by the quorum resource. Do not pass
///                           <b>NULL</b> for this parameter.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is one of the possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The <i>lpszResourceName</i> or the <i>lpszDeviceName</i> buffer is not big enough to hold the
///    result. The <i>lpcchResourceName</i> and <i>lpcchDeviceName</i> parameters return the number of characters in the
///    result, excluding the terminating <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint GetClusterQuorumResource(_HCLUSTER* hCluster, PWSTR lpszResourceName, uint* lpcchResourceName, 
                              PWSTR lpszDeviceName, uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);

///Establishes a resource as the quorum resource for a cluster. The <b>PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to the new quorum resource; or the existing quorum resource when <i>dwMaxQuoLogSize</i> is
///                <b>CLUS_NODE_MAJORITY_QUORUM</b>.
///    lpszDeviceName = Determines the drive letter and path that the Cluster service will use to maintain the quorum files on the new
///                     quorum resource. Pass a null-terminated Unicode string or <b>NULL</b>, as follows. <ul> <li>If you specify a
///                     drive letter in the path, the Cluster service will verify that the drive letter refers to a valid partition on
///                     the new quorum resource.</li> <li>If you do not specify a drive letter in the path, the Cluster service will use
///                     a default partition on the new quorum resource (see below).</li> <li>If <b>NULL</b>, the Cluster service will use
///                     a default partition and a default path name (see below).</li> </ul> The Cluster service uses the partition
///                     flagged as <b>CLUSPROP_PIFLAG_DEFAULT_QUORUM</b> as the default partition (see CLUSPROP_PARTITION_INFO), or, if
///                     the flag cannot be found, the first available NTFS partition on the new quorum resource. For the default path
///                     name, the Cluster service uses the previous path name if one exists; otherwise it uses "MSCS".
///    dwMaxQuoLogSize = The quorum type value. Specify one of the three constants listed. When you specify
///                      <b>CLUS_NODE_MAJORITY_QUORUM</b>, <i> hResource</i> must refer to the existing quorum resource.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_NOT_ONLINE</b></dt> <dt>5004
///    (0x138C)</dt> </dl> </td> <td width="60%"> The quorum resource is not online. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint SetClusterQuorumResource(_HRESOURCE* hResource, const(PWSTR) lpszDeviceName, uint dwMaxQuoLogSize);

///<p class="CCE_Message">[This function is available for use in the operating systems specified in the Requirements
///section. Support for this function was removed in Windows Server 2008 and this function does nothing and returns
///<b>ERROR_CALL_NOT_IMPLEMENTED</b>.] Creates a backup of the cluster database and all registry checkpoints.
///Params:
///    hCluster = Handle to the cluster to be backed up.
///    lpszPathName = Null-terminated Unicode string specifying the path to where the backup should be created. Cluster configuration
///                   information will be saved to this location; this is sensitive data that should be protected. For example, this
///                   data can be protected by using an access control list to restrict access to the location where the data is
///                   stored.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the system
///    error codes.
///    
@DllImport("CLUSAPI")
uint BackupClusterDatabase(_HCLUSTER* hCluster, const(PWSTR) lpszPathName);

///<p class="CCE_Message">[This function is available for use in the operating systems specified in the Requirements
///section. Support for this function was removed in Windows Server 2008 and this function does nothing and returns
///<b>ERROR_CALL_NOT_IMPLEMENTED</b>.] Restores the cluster database and restarts the Cluster service on the node from
///which the function is called. This node is called the restoring node.
///Params:
///    lpszPathName = Null-terminated Unicode string specifying the path to the backup file. Cluster configuration information is
///                   contained in this location; this is sensitive data that should be protected. For example, this data can be
///                   protected by using an access control list to restrict access to the location where the data is stored.
///    bForce = If <b>FALSE</b>, the restore operation will not be completed if either of the following circumstances applies:
///             <ul> <li>Other nodes are currently active.</li> <li>The partition layout of the current quorum resource is not
///             identical to the partition layout of the quorum resource that was in place when the backup was made. (The term
///             "partition layout" refers to the number of partitions on the disk and the offsets to each partition. The disk
///             signature and drive letter assignments do not have to be identical.)</li> </ul> Setting <i>bForce</i> to
///             <b>TRUE</b> causes the operation to proceed regardless of these preceding circumstances; however, the operation
///             may still fail for other reasons.
///    lpszQuorumDriveLetter = Optional. Identifies the drive letter of the quorum resource on which the cluster database will be restored. Use
///                            this parameter only if the quorum resource has been replaced since the backup was made. The string must be
///                            formatted as follows: <ul> <li>The first character must be alphabetic, that is, in the range 'a'-'z' or
///                            'A'-'Z'.</li> <li>The second character must be a colon (':').</li> <li>The third character must be a terminating
///                            null ('\0').</li> </ul>
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CLUSTER_NODE_UP</b></dt> </dl> </td> <td
///    width="60%"> The operation failed because other cluster nodes are currently active. If you call
///    RestoreClusterDatabase again with <i>bForce</i> set to <b>TRUE</b>, the cluster will attempt to shut down the
///    Cluster service on the other active nodes. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_QUORUM_DISK_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The operation failed because the quorum
///    disk described in the backup does not match the current quorum disk. If you call RestoreClusterDatabase again
///    with <i>bForce</i> set to <b>TRUE</b>, the cluster will attempt to change the signature and drive letter of the
///    current quorum disk to the values stored in the backup. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint RestoreClusterDatabase(const(PWSTR) lpszPathName, BOOL bForce, const(PWSTR) lpszQuorumDriveLetter);

///<p class="CCE_Message">[This function is available for use in the operating systems specified in the Requirements
///section. Support for this method was removed in Windows Server 2008 and this function does nothing and returns
///<b>ERROR_CALL_NOT_IMPLEMENTED</b>.] Sets the priority order for the set of networks used for internal communication
///between cluster nodes. The <b>PCLUSAPI_SET_CLUSTER_NETWORK_PRIORITY_ORDER</b> type defines a pointer to this
///function.
///Params:
///    hCluster = Handle to the cluster to be affected.
///    NetworkCount = Number of items in the list specified by the <i>NetworkList</i> parameter.
///    NetworkList = Prioritized array of handles to network objects. The first handle in the array has the highest priority. The list
///                  must contain only those networks that are used for internal communication between nodes in the cluster, and there
///                  can be no duplicates.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> <dt>87 (0x57)</dt>
///    </dl> </td> <td width="60%"> There was a duplicate network in <i>NetworkList</i>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint SetClusterNetworkPriorityOrder(_HCLUSTER* hCluster, uint NetworkCount, _HNETWORK** NetworkList);

///<p class="CCE_Message">[This function is available for use in the operating systems specified in the Requirements
///section. Support for this function was removed in Windows Server 2008 and this function does nothing and returns
///<b>ERROR_CALL_NOT_IMPLEMENTED</b>.] Changes the password for the Cluster service user account on all available
///cluster nodes. The <b>PCLUSAPI_SET_CLUSTER_SERVICE_ACCOUNT_PASSWORD</b> type defines a pointer to this function.
///Params:
///    lpszClusterName = <b>NULL</b>-terminated Unicode string specifying the name of the cluster.
///    lpszNewPassword = <b>NULL</b>-terminated Unicode string specifying the new password for the Cluster service user account.
///    dwFlags = Optional bitfield of values enumerated from the CLUSTER_SET_PASSWORD_FLAGS enumeration containing flags that
///              describe how the password update is to be applied to the cluster. By default (<i>dwFlags</i> = 0), the function
///              will not proceed unless all cluster nodes are available.
///    lpReturnStatusBuffer = Pointer to an output buffer that receives an array of CLUSTER_SET_PASSWORD_STATUS structures describing the
///                           result of the password update for each cluster node. If this parameter is not <b>NULL</b> and the buffer is not
///                           large enough to hold the resulting data, the function returns <b>ERROR_MORE_DATA</b> and sets
///                           <i>lpcbReturnStatusBufferSize</i> to the required size for the output buffer. If this parameter is <b>NULL</b>,
///                           no password update will be performed; the function will set <i>lpcbReturnStatusBufferSize</i> to the required
///                           buffer size and return <b>ERROR_SUCCESS</b>.
///    lpcbReturnStatusBufferSize = On input, pointer to a value specifying the size (in bytes) of the output buffer. On output, pointer to a value
///                                 specifying the actual size (in bytes) of the resulting data. The output size is always specified, even if
///                                 <i>lpReturnStatusBuffer</i> is <b>NULL</b>. This parameter cannot be <b>NULL</b>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALL_NODES_NOT_AVAILABLE</b></dt> <dt>5037
///    (0x13AD)</dt> </dl> </td> <td width="60%"> Some nodes in the cluster are unavailable (that is, not in the
///    <b>ClusterNodeStateUp</b> or <b>ClusterNodeStatePaused</b> states) and the
///    <b>CLUSTER_SET_PASSWORD_IGNORE_DOWN_NODES</b> flag is not set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The output buffer pointed to by
///    <i>lpReturnStatusBuffer</i> was not large enough to hold the resulting data. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint SetClusterServiceAccountPassword(const(PWSTR) lpszClusterName, const(PWSTR) lpszNewPassword, uint dwFlags, 
                                      CLUSTER_SET_PASSWORD_STATUS* lpReturnStatusBuffer, 
                                      uint* lpcbReturnStatusBufferSize);

///Initiates an operation that affects a cluster. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hCluster = Handle to the cluster to be affected.
///    hHostNode = If non-<b>NULL</b>, handle to the node to perform the operation represented by the control code. If <b>NULL</b>,
///                the local node performs the operation. Specifying <i>hHostNode</i> is optional.
///    dwControlCode = A cluster control code from the CLUSCTL_CLUSTER_CODES enumeration that specifies the operation to be performed.
///                    For the syntax associated with a control code, refer to Control Code Architecture and the following topics: <ul>
///                    <li> CLUSCTL_CLUSTER_CHECK_VOTER_DOWN </li> <li> CLUSCTL_CLUSTER_CHECK_VOTER_EVICT </li> <li>
///                    CLUSCTL_CLUSTER_CLEAR_NODE_CONNECTION_INFO </li> <li> CLUSCTL_CLUSTER_ENUM_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_CLUSTER_ENUM_PRIVATE_PROPERTIES </li> <li> CLUSCTL_CLUSTER_GET_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_CLUSTER_GET_FQDN </li> <li> CLUSCTL_CLUSTER_GET_COMMON_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_CLUSTER_GET_RO_COMMON_PROPERTIES </li> <li> CLUSCTL_CLUSTER_GET_RO_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_CLUSTER_GET_SHARED_VOLUME_ID </li> <li> CLUSCTL_CLUSTER_SET_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_CLUSTER_SET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_CLUSTER_SHUTDOWN </li> <li> CLUSCTL_CLUSTER_UNKNOWN
///                    </li> <li> CLUSCTL_CLUSTER_VALIDATE_COMMON_PROPERTIES </li> <li> CLUSCTL_CLUSTER_VALIDATE_PRIVATE_PROPERTIES
///                    </li> </ul>
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    nInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    nOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpcbBytesReturned</i>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation was
///    successful. If the operation required an output buffer, <i>lpcbBytesReturned</i> (if not <b>NULL</b> on input)
///    points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer pointed to by <i>lpOutBuffer</i>
///    was not large enough to hold the data resulting from the operation. The <i>lpcbBytesReturned</i> parameter (if
///    not <b>NULL</b> on input) points to the size required for the output buffer. Only operations requiring an output
///    buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and the
///    <i>nOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not <b>ERROR_MORE_DATA</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. If the operation required an output buffer, the value specified by
///    <i>lpcbBytesReturned</i> (if not <b>NULL</b> on input) is unreliable. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterControl(_HCLUSTER* hCluster, _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, 
                    uint nInBufferSize, void* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

///Initiates a rolling upgrade of the operating system on a cluster. <b>PCLUSAPI_CLUSTER_UPGRADE</b> defines a pointer
///to this function.
///Params:
///    hCluster = A handle to the cluster to upgrade.
///    perform = <b>True</b> to initiate the rolling upgrade; otherwise <b>false</b>.
///    pfnProgressCallback = A pointer to the ClusterUpgradeProgressCallback callback function that retrieves the status of the rolling
///                          upgrade.
///    pvCallbackArg = A pointer to the arguments for <b>pfnProgressCallback</b>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterUpgradeFunctionalLevel(_HCLUSTER* hCluster, BOOL perform, 
                                   PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

///Creates or modifies a notification port. For information about notification ports, see Receiving Cluster Events.
///Params:
///    hChange = A handle to a notification port or <b>INVALID_HANDLE_VALUE</b>, indicating that a new handle should be created.
///              If the <i>hChange</i> parameter is an existing handle, the events that are specified in the <i>dwFilter</i>
///              parameter are added to the notification port.
///    hCluster = A handle to the cluster to be associated with the notification port that is identified by the <i>hChange</i>
///               parameter or <b>INVALID_HANDLE_VALUE</b>, indicating that the notification port should not be associated with a
///               cluster. If the <i>hChange</i> parameter is not set to <b>INVALID_HANDLE_VALUE</b>, the <i>hCluster</i> parameter
///               cannot be set to <b>INVALID_HANDLE_VALUE</b>.
///    Filters = A pointer to the NOTIFY_FILTER_AND_TYPE structure that specifies the type of notifications that the port can
///              accept.
///    dwFilterCount = The number of filters that are specified by the <i>Filters</i> parameter.
///    dwNotifyKey = A user-specified value to associate with the retrieval of notifications from the notification port. The
///                  <i>dwNotifyKey</i> parameter is returned from GetClusterNotifyV2 when an event of one of the types that are
///                  specified in <i>Filters</i> occurs.
///Returns:
///    If the operation succeeds, the function returns a notification port handle. If the operation fails, the function
///    returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HCHANGE* CreateClusterNotifyPortV2(_HCHANGE* hChange, _HCLUSTER* hCluster, NOTIFY_FILTER_AND_TYPE* Filters, 
                                    uint dwFilterCount, size_t dwNotifyKey);

///Registers an event type with a notification port by adding the notification key to the event type.
///Params:
///    hChange = A handle to a notification port that is created with the CreateClusterNotifyPortV2 function.
///    Filter = A NOTIFY_FILTER_AND_TYPE structure that specifies the event type to create.
///    hObject = A handle to the failover cluster object that is affected by the event as specified in the <i>dwFilterType</i>
///              parameter. The type of handle depends on the value of <i>dwFilterType</i>.
///    dwNotifyKey = The notification key that is returned from the GetClusterNotify function when the requested event occurs.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint RegisterClusterNotifyV2(_HCHANGE* hChange, NOTIFY_FILTER_AND_TYPE Filter, HANDLE hObject, size_t dwNotifyKey);

///Retrieves a handle to a notification event.
///Params:
///    hChange = A handle to the notification port that received the notification event.
///    lphTargetEvent = The handle to the notification event.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint GetNotifyEventHandle(_HCHANGE* hChange, HANDLE* lphTargetEvent);

///Retrieves information about the next notification event for a notification port.
///Params:
///    hChange = A handle to the notification port. This handle is created by the CreateClusterNotifyPortV2 function.
///    lpdwNotifyKey = A pointer to the notification key for the notification port.
///    pFilterAndType = A pointer to a NOTIFY_FILTER_AND_TYPE structure that describes the next notification event for the notification
///                     port.
///    buffer = A pointer to a buffer for the notification event.
///    lpbBufferSize = A pointer to the size of the <i>buffer</i> parameter, in bytes.
///    lpszObjectId = A pointer to a Unicode string with the ID of the cluster object that triggered the event. The string ends with a
///                   terminating null character.
///    lpcchObjectId = On input, a pointer to a <b>DWORD</b> that specifies the maximum number of characters that the
///                    <i>lpszObjectId</i> parameter can hold, including the terminating null character. On output, a pointer to a
///                    <b>DWORD</b> that specifies the number of characters that <i>lpszObjectId</i> received, excluding the terminating
///                    null character.
///    lpszParentId = A pointer to a Unicode string with the ID of the parent to the cluster object that triggered the event. The
///                   string ends with a terminating null character.
///    lpcchParentId = On input, a pointer to a <b>DWORD</b> that specifies the maximum number of characters the <i>lpszParentId</i>
///                    parameter can hold, including the terminating null character. On output, a pointer to a <b>DWORD</b> that
///                    specifies the number of characters that <i>lpszParentId</i> received, excluding the terminating null character.
///    lpszName = A pointer to a Unicode string that contains the name of the cluster object that triggered the event. The string
///               ends with a terminating null character.
///    lpcchName = On input, a pointer to a <b>DWORD</b> that specifies the maximum number of characters that the <i>lpszName</i>
///                parameter can hold, including the terminating null character. On output, a pointer to a <b>DWORD</b> that
///                specifies the number of characters that <i>lpszName</i> received, excluding the terminating null character.
///    lpszType = A pointer to a Unicode string that contains the type of cluster object that triggered the event. The string ends
///               with a terminating null character.
///    lpcchType = On input, a pointer to a <b>DWORD</b> that specifies the maximum number of characters the <i>lpszType</i>
///                parameter can hold, including the terminating null character. On output, a pointer to a <b>DWORD</b> that
///                specifies the number of characters that <i>lpszType</i> received, excluding the terminating null character.
///    dwMilliseconds = A time-out value that specifies how long the caller is willing to wait for the notification.
///Returns:
///    if the operation succeeds, this function returns <b>ERROR_SUCCESS</b>. If the operation fails, this function
///    returns one of the following system error codes. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The
///    handle that is represented in the <i>hChange</i> parameter is invalid or has been closed by another thread. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WAIT_TIMEOUT</b></dt> <dt>258 (0x102)</dt> </dl> </td> <td width="60%">
///    The call timed out before the notification could be successfully returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>lpszName</i> parameter is not big enough to hold the result. The <i>lpcchName</i> parameter returns the number
///    of characters in the result, excluding the terminating null character. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint GetClusterNotifyV2(_HCHANGE* hChange, size_t* lpdwNotifyKey, NOTIFY_FILTER_AND_TYPE* pFilterAndType, 
                        ubyte* buffer, uint* lpbBufferSize, PWSTR lpszObjectId, uint* lpcchObjectId, 
                        PWSTR lpszParentId, uint* lpcchParentId, PWSTR lpszName, uint* lpcchName, PWSTR lpszType, 
                        uint* lpcchType, uint dwMilliseconds);

///Creates or modifies a notification port. For information on notification ports, see Receiving Cluster Events. The
///<b>PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT</b> type defines a pointer to this function.
///Params:
///    hChange = Handle to a notification port or <b>INVALID_HANDLE_VALUE</b>, indicating that a new handle should be created. If
///              <i>hChange</i> is an existing handle, the events specified in <i>dwFilter</i> are added to the notification port.
///    hCluster = Handle to the cluster to be associated with the notification port identified by <i>hChange</i>, or
///               <b>INVALID_HANDLE_VALUE</b>, indicating that the notification port should not be associated with a cluster. If
///               <i>hChange</i> is not set to <b>INVALID_HANDLE_VALUE</b>, <i>hCluster</i> cannot be set to
///               <b>INVALID_HANDLE_VALUE</b>.
///    dwFilter = Bitmask of flags enumerated from the CLUSTER_CHANGE enumeration that specifies the events that will cause
///               notifications to be stored in the queue. One or more of the following flags can be set using the OR operator, or
///               you can specify all of the flags by using the value <b>CLUSTER_CHANGE_ALL</b>.
///    dwNotifyKey = A user-specified value to be associated with retrieving notifications from the notification port. The
///                  <i>dwNotifyKey</i> is returned from GetClusterNotify when an event of one of the types specified in
///                  <i>dwFilter</i> occurs.
///Returns:
///    If the operation succeeds, the function returns a notification port handle. If the operation fails, the function
///    returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HCHANGE* CreateClusterNotifyPort(_HCHANGE* hChange, _HCLUSTER* hCluster, uint dwFilter, size_t dwNotifyKey);

///Adds an event type to the list of events stored for a notification port. The <b>PCLUSAPI_REGISTER_CLUSTER_NOTIFY</b>
///type defines a pointer to this function.
///Params:
///    hChange = Handle to a notification port created with the CreateClusterNotifyPort function.
///    dwFilterType = Bitmask of flags that describes the event to be added to the set of events currently being monitored by the
///                   notification port. For more information about these event types, see CreateClusterNotifyPort. The
///                   <i>dwFilterType</i> parameter can be set to one of the following flags.
///    hObject = Handle to the failover cluster object affected by the event specified in the <i>dwFilterType</i> parameter. The
///              type of handle depends on the value of <i>dwFilterType</i> as described in the following list.
///    dwNotifyKey = Notification key returned from GetClusterNotify when the requested event occurs.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint RegisterClusterNotify(_HCHANGE* hChange, uint dwFilterType, HANDLE hObject, size_t dwNotifyKey);

///Returns information relating to the next notification event that is stored for a notification port. The
///<b>PCLUSAPI_GET_CLUSTER_NOTIFY</b> type defines a pointer to this function.
///Params:
///    hChange = The handle to a notification port that is created with the CreateClusterNotifyPort function.
///    lpdwNotifyKey = A pointer to the notification key for the port that is identified by the <i>hChange</i> parameter.
///    lpdwFilterType = A pointer to a flag that indicates the type of returned event. This flag is one of the following values from the
///                     CLUSTER_CHANGE enumeration.
///    lpszName = A pointer to a null-terminated Unicode string containing the name of the cluster object that triggered the event.
///               The following list describes the content of <i>lpszName</i> by event type. Note that
///               <b>CLUSTER_CHANGE_REGISTRY_SUBTREE</b> is not included in the table; this event type is never handled by
///               <b>GetClusterNotify</b>.
///    lpcchName = A pointer to the size of the <i>lpszName</i> buffer as a count of characters. On input, specify the maximum
///                number of characters that the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the
///                number of characters in the resulting name, excluding the terminating <b>NULL</b>.
///    dwMilliseconds = Optional time-out value that specifies how long the caller is willing to wait for the notification.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible values. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td>
///    <td width="60%"> The handle that is represented in the <i>hChange</i> parameter is invalid or has been closed by
///    another thread. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAIT_TIMEOUT</b></dt> <dt>258 (0x102)</dt> </dl>
///    </td> <td width="60%"> The call timed out before the notification could be successfully returned. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The
///    buffer pointed to by the <i>lpszName</i> parameter is not big enough to hold the result. The <i>lpcchName</i>
///    parameter returns the number of characters in the result, excluding the terminating <b>NULL</b>. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
uint GetClusterNotify(_HCHANGE* hChange, size_t* lpdwNotifyKey, uint* lpdwFilterType, PWSTR lpszName, 
                      uint* lpcchName, uint dwMilliseconds);

///Closes a notification port established through CreateClusterNotifyPort. The <b>PCLUSAPI_CLOSE_CLUSTER_NOTIFY_PORT</b>
///type defines a pointer to this function.
///Params:
///    hChange = Handle to the notification port to close.
///Returns:
///    This function always returns <b>TRUE</b>.
///    
@DllImport("CLUSAPI")
BOOL CloseClusterNotifyPort(_HCHANGE* hChange);

///Opens an enumerator for iterating through cluster objects in a cluster. The <b>PCLUSAPI_CLUSTER_OPEN_ENUM</b> type
///defines a pointer to this function.
///Params:
///    hCluster = A handle to a cluster.
///    dwType = A bitmask that describes the type of objects to be enumerated. One or more of the following values of the
///             CLUSTER_ENUM enumeration are valid.
///Returns:
///    If the operation succeeds, <b>ClusterOpenEnum</b> returns a handle to a cluster enumerator. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call the function GetLastError.
///    
@DllImport("CLUSAPI")
_HCLUSENUM* ClusterOpenEnum(_HCLUSTER* hCluster, uint dwType);

///Returns the number of cluster objects associated with a cluster enumeration handle. The
///<b>PCLUSAPI_CLUSTER_GET_ENUM_COUNT</b> type defines a pointer to this function.
///Params:
///    hEnum = Handle to a cluster enumeration. This handle is obtained from ClusterOpenEnum. A valid handle is required. This
///            parameter cannot be NULL.
@DllImport("CLUSAPI")
uint ClusterGetEnumCount(_HCLUSENUM* hEnum);

///Enumerates the cluster objects in a cluster, returning the name of one object with each call. The
///<b>PCLUSAPI_CLUSTER_ENUM</b> type defines a pointer to this function.
///Params:
///    hEnum = A cluster enumeration handle returned by the ClusterOpenEnum function.
///    dwIndex = The index used to identify the next entry to be enumerated. This parameter should be zero for the first call to
///              <b>ClusterEnum</b> and then incremented for subsequent calls.
///    lpdwType = A pointer to the type of object returned. One of the following values of the CLUSTER_ENUM enumeration is returned
///               with each call.
///    lpszName = A pointer to a null-terminated Unicode string containing the name of the returned object.
///    lpcchName = A pointer to the size of the <i>lpszName</i> buffer as a count of characters. On input, specify the maximum
///                number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                of characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt>
///    <dt>259 (0x103)</dt> </dl> </td> <td width="60%"> No more data is available. This value is returned if there are
///    no more objects of the requested type to be returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> More data is available. This
///    value is returned if the buffer pointed to by <i>lpszName</i> is not big enough to hold the result. The
///    <i>lpcchName</i> parameter returns the number of characters in the result, excluding the terminating <b>NULL</b>.
///    </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterEnum(_HCLUSENUM* hEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

///Closes a cluster enumeration handle originally opened by ClusterOpenEnum.
///Params:
///    hEnum = Cluster enumeration handle to close. This is a handle originally returned by the ClusterOpenEnum function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterCloseEnum(_HCLUSENUM* hEnum);

///Opens a handle to a cluster in order to iterate through its objects.
///Params:
///    hCluster = The handle to the cluster.
///    dwType = A bitmask that describes the type of objects to be enumerated. This must be one or more of the CLUSTER_ENUM
///             enumeration values.
///    pOptions = Options.
///Returns:
///    If the operation succeeds, returns a handle to a cluster enumerator. If the operation fails, the function returns
///    <b>NULL</b>. For more information about the error, call the function GetLastError.
///    
@DllImport("CLUSAPI")
_HCLUSENUMEX* ClusterOpenEnumEx(_HCLUSTER* hCluster, uint dwType, void* pOptions);

///Returns the number of cluster objects that are associated with a cluster enumeration handle.
///Params:
///    hClusterEnum = The handle to a cluster enumeration. This handle is obtained from the ClusterOpenEnumEx function. A valid handle
///                   is required. This parameter cannot be NULL.
///Returns:
///    The number of objects that are associated with the enumeration handle.
///    
@DllImport("CLUSAPI")
uint ClusterGetEnumCountEx(_HCLUSENUMEX* hClusterEnum);

///Enumerates the objects in a cluster, and then gets the name and properties of the cluster object.
///Params:
///    hClusterEnum = A handle to the enumerator that is returned by the ClusterOpenEnumEx function.
///    dwIndex = The index that identifies the next cluster object to enumerate. This parameter should be zero for the first call
///              to the <b>ClusterEnumEx</b> function and then be incremented for subsequent calls.
///    pItem = A pointer that receives the returned cluster object properties.
///    cbItem = On input, the size of the <i>pItem</i> parameter. On output, either the required size in bytes of the buffer if
///             the buffer is too small, or the number of bytes that are written into the buffer.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The <i>dwIndex</i> parameter is larger than the
///    number of items in the enumeration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The buffer is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The buffer was filled successfully. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
uint ClusterEnumEx(_HCLUSENUMEX* hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

///Closes a handle to an enumeration that was opened by the ClusterOpenEnumEx function.
///Params:
///    hClusterEnum = The handle to the cluster enumeration to close. This is a handle that originally was returned by
///                   ClusterOpenEnumEx.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterCloseEnumEx(_HCLUSENUMEX* hClusterEnum);

///Adds a groupset to a cluster and returns a handle to the newly added groupset.
///Params:
///    hCluster = A handle to the target cluster.
///    groupSetName = Pointer to a null-terminated Unicode string containing the name of the groupset to be added.
@DllImport("CLUSAPI")
_HGROUPSET* CreateClusterGroupSet(_HCLUSTER* hCluster, const(PWSTR) groupSetName);

///Opens a handle to the specified groupset.
///Params:
///    hCluster = A handle to the cluster containing the collection.
///    lpszGroupSetName = The name of the collection to be opened
@DllImport("CLUSAPI")
_HGROUPSET* OpenClusterGroupSet(_HCLUSTER* hCluster, const(PWSTR) lpszGroupSetName);

///Closes a groupset handle returned from OpenClusterGroupSet.
///Params:
///    hGroupSet = The handle to close
@DllImport("CLUSAPI")
BOOL CloseClusterGroupSet(_HGROUPSET* hGroupSet);

///Deletes the specified groupset from the cluster. The groupset must contain no groups.
///Params:
///    hGroupSet = A handle to the collection to be deleted
@DllImport("CLUSAPI")
uint DeleteClusterGroupSet(_HGROUPSET* hGroupSet);

///Adds the specified group to a groupset in the cluster. The group must not currently be in a groupset
///Params:
///    hGroupSet = The collection to which to add the group
///    hGroup = The group to add to the collection
@DllImport("CLUSAPI")
uint ClusterAddGroupToGroupSet(_HGROUPSET* hGroupSet, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ClusterAddGroupToGroupSetWithDomains(_HGROUPSET* hGroupSet, _HGROUP* hGroup, uint faultDomain, 
                                          uint updateDomain);

///Removes the specified group from the groupset to which it is currently a member.
///Params:
///    hGroup = A handle to the group to remove.
@DllImport("CLUSAPI")
uint ClusterRemoveGroupFromGroupSet(_HGROUP* hGroup);

///Initiates an operation affecting a groupset. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hGroupSet = Handle to the groupset to be affected.
///    hHostNode = If non-<b>NULL</b>, handle to the node to perform the operation represented by the control code. If <b>NULL</b>,
///                the node that owns the groupset performs the operation. Specifying <i>hHostNode</i> is optional.
///    dwControlCode = A Collection Control Code specifying the operation to be performed. For the syntax associated with a control
///                    code, refer to Control Code Architecture and the following topics. <ul> <li>
///                    CLUSCTL_GROUPSET_GET_COMMON_PROPERTIES </li> <li> CLUSCTL_GROUPSET_GET_GROUPS </li> <li>
///                    CLUSCTL_GROUPSET_GET_PROVIDER_GROUPS </li> <li> CLUSCTL_GROUPSET_GET_PROVIDER_COLLECTIONS </li> <li>
///                    CLUSCTL_GROUPSET_GET_RO_COMMON_PROPERTIES </li> <li> CLUSCTL_GROUPSET_SET_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_GROUP_GET_PROVIDER_GROUPS </li> <li> CLUSCTL_GROUP_GET_PROVIDER_COLLECTIONS </li> </ul>
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    cbInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    cbOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpBytesReturned</i>.
@DllImport("CLUSAPI")
uint ClusterGroupSetControl(_HGROUPSET* hGroupSet, _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, 
                            uint cbInBufferSize, void* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

///Adds a dependency between two cluster groups.
///Params:
///    hDependentGroup = The dependent group
///    hProviderGroup = The group <i>hDependentGroup</i> depends on
@DllImport("CLUSAPI")
uint AddClusterGroupDependency(_HGROUP* hDependentGroup, _HGROUP* hProviderGroup);

///Sets the dependency expression for a cluster group.
///Params:
///    hGroup = A handle to the group on which to set the dependency expression.
///    lpszDependencyExpression = The dependency expression to set on the group.
@DllImport("CLUSAPI")
uint SetGroupDependencyExpression(_HGROUP* hGroup, const(PWSTR) lpszDependencyExpression);

///Removes a dependency between two cluster groups.
///Params:
///    hGroup = The dependent group
///    hDependsOn = The group <i>hDependentGroup</i> depends on
@DllImport("CLUSAPI")
uint RemoveClusterGroupDependency(_HGROUP* hGroup, _HGROUP* hDependsOn);

///Adds a dependency between two cluster groupsets. A groupset can only be dependent on one other groupset.
///Params:
///    hDependentGroupSet = The dependent collection
///    hProviderGroupSet = The collection <i>hDependentGroupSet</i> depends on.
@DllImport("CLUSAPI")
uint AddClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, _HGROUPSET* hProviderGroupSet);

///Sets the dependency expression for a cluster groupset.
///Params:
///    hGroupSet = The collection to receive the dependency expression
///    lpszDependencyExprssion = The dependency expression for <i>hCollection</i>
@DllImport("CLUSAPI")
uint SetClusterGroupSetDependencyExpression(_HGROUPSET* hGroupSet, const(PWSTR) lpszDependencyExprssion);

///Removes a groupset from a groupset's dependency expression.
///Params:
///    hGroupSet = The groupset from which to remove the dependency.
///    hDependsOn = The collection to remove
@DllImport("CLUSAPI")
uint RemoveClusterGroupSetDependency(_HGROUPSET* hGroupSet, _HGROUPSET* hDependsOn);

///Adds a dependency between a cluster group and a cluster groupset.A group can only be dependent on one groupset.
///Params:
///    hDependentGroup = The dependent group
///    hProviderGroupSet = The collection <i>hDependentGroup</i> depends on
@DllImport("CLUSAPI")
uint AddClusterGroupToGroupSetDependency(_HGROUP* hDependentGroup, _HGROUPSET* hProviderGroupSet);

///Removes a groupset from a group's dependency expression.
///Params:
///    hGroup = The group from which to remove the dependency.
///    hDependsOn = The groupset to remove.
@DllImport("CLUSAPI")
uint RemoveClusterGroupToGroupSetDependency(_HGROUP* hGroup, _HGROUPSET* hDependsOn);

///Starts the enumeration of groupset for a cluster.
///Params:
///    hCluster = A handle to the cluster containing the groupset.
@DllImport("CLUSAPI")
_HGROUPSETENUM* ClusterGroupSetOpenEnum(_HCLUSTER* hCluster);

///Gets the number of items contained the enumerator's collection.
///Params:
///    hGroupSetEnum = A handle to an enumerator returned by ClusterGroupSetOpenEnum.
@DllImport("CLUSAPI")
uint ClusterGroupSetGetEnumCount(_HGROUPSETENUM* hGroupSetEnum);

///Returns the next enumerable object.
///Params:
///    hGroupSetEnum = A handle to an open cluster node enumeration returned by ClusterNodeOpenEnum
///    dwIndex = The index to enumerate, zero for the first call to this function and then incremented for subsequent calls.
///    lpszName = Points to a buffer that receives the name of the object, including the terminating null character.
///    lpcchName = Points to a variable that specifies the size, in characters, of the buffer pointed to by the <i>lpszName</i>
///                parameter. This size should include the terminating null character. When the function returns, the variable
///                contains the number of characters stored in the buffer, not including the terminating null character.
@DllImport("CLUSAPI")
uint ClusterGroupSetEnum(_HGROUPSETENUM* hGroupSetEnum, uint dwIndex, PWSTR lpszName, uint* lpcchName);

///Closes an open enumeration for a groupset.
///Params:
///    hGroupSetEnum = The enumeration to be closed.
@DllImport("CLUSAPI")
uint ClusterGroupSetCloseEnum(_HGROUPSETENUM* hGroupSetEnum);

@DllImport("CLUSAPI")
uint AddCrossClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, const(PWSTR) lpRemoteClusterName, 
                                       const(PWSTR) lpRemoteGroupSetName);

@DllImport("CLUSAPI")
uint RemoveCrossClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, const(PWSTR) lpRemoteClusterName, 
                                          const(PWSTR) lpRemoteGroupSetName);

@DllImport("CLUSAPI")
_HGROUPSET* CreateClusterAvailabilitySet(_HCLUSTER* hCluster, const(PWSTR) lpAvailabilitySetName, 
                                         CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);

@DllImport("CLUSAPI")
uint ClusterNodeReplacement(_HCLUSTER* hCluster, const(PWSTR) lpszNodeNameCurrent, const(PWSTR) lpszNodeNameNew);

@DllImport("CLUSAPI")
uint ClusterCreateAffinityRule(_HCLUSTER* hCluster, const(PWSTR) ruleName, CLUS_AFFINITY_RULE_TYPE ruleType);

@DllImport("CLUSAPI")
uint ClusterRemoveAffinityRule(_HCLUSTER* hCluster, const(PWSTR) ruleName);

@DllImport("CLUSAPI")
uint ClusterAddGroupToAffinityRule(_HCLUSTER* hCluster, const(PWSTR) ruleName, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ClusterRemoveGroupFromAffinityRule(_HCLUSTER* hCluster, const(PWSTR) ruleName, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ClusterAffinityRuleControl(_HCLUSTER* hCluster, const(PWSTR) affinityRuleName, _HNODE* hHostNode, 
                                uint dwControlCode, void* lpInBuffer, uint cbInBufferSize, void* lpOutBuffer, 
                                uint cbOutBufferSize, uint* lpBytesReturned);

///Opens a node and returns a handle to it. The <b>PCLUSAPI_OPEN_CLUSTER_NODE</b> type defines a pointer to this
///function.
///Params:
///    hCluster = Handle to a cluster returned from the OpenCluster or OpenClusterEx functions.
///    lpszNodeName = Pointer to the NetBIOS name of an existing node. If the DNS name of the node is used, the <b>OpenClusterNode</b>
///                   function will fail and GetLastError will return <b>ERROR_CLUSTER_NODE_NOT_FOUND</b>.
///Returns:
///    If the operation was successful, <b>OpenClusterNode</b> returns a node handle. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. For more information about the error, call the function GetLastError. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
_HNODE* OpenClusterNode(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName);

///Opens a node and returns a handle to it.
///Params:
///    hCluster = Handle to a cluster returned from the OpenCluster or OpenClusterEx functions.
///    lpszNodeName = Pointer to the NetBIOS name of an existing node. If the DNS name of the node is used, the
///                   <b>OpenClusterNodeEx</b> function will fail and GetLastError will return <b>ERROR_CLUSTER_NODE_NOT_FOUND</b>.
///    dwDesiredAccess = The requested access privileges. This may be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0) and undefined
///                      error may be returned. Using <b>GENERIC_ALL</b> is the same as calling OpenClusterNode.
///    lpdwGrantedAccess = Optional parameter that contains the address of a <b>DWORD</b> that will receive the access rights granted. If
///                        the <i>DesiredAccess</i> parameter is <b>MAXIMUM_ALLOWED</b> (0x02000000) then the <b>DWORD</b> pointed to by
///                        this parameter will contain the maximum privileges granted to this user.
///Returns:
///    If the operation was successful, <b>OpenClusterNodeEx</b> returns a node handle. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> </dl> </td> <td width="60%">
///    The operation was not successful. For more information about the error, call the GetLastError function. If the
///    target server does not support the OpenClusterNodeEx function (for example if the target server is running
///    Windows Server 2008 or earlier) then the <b>GetLastError</b> function will return
///    <b>RPC_S_PROCNUM_OUT_OF_RANGE</b> (1745). </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HNODE* OpenClusterNodeEx(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, uint dwDesiredAccess, 
                          uint* lpdwGrantedAccess);

@DllImport("CLUSAPI")
_HNODE* OpenClusterNodeById(_HCLUSTER* hCluster, uint nodeId);

///Closes a node handle. The <b>PCLUSAPI_CLOSE_CLUSTER_NODE</b> type defines a pointer to this function.
///Params:
///    hNode = Handle to an existing node.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The operation was not successful. For more information about
///    the error, call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
BOOL CloseClusterNode(_HNODE* hNode);

///Returns the current state of a node. The <b>PCLUSAPI_GET_CLUSTER_NODE_STATE</b> type defines a pointer to this
///function.
///Params:
///    hNode = Handle to the node for which state information should be returned.
///Returns:
///    <b>GetClusterNodeState</b> returns the current state of the node, which is represented by one of the following
///    values. The returned values are from the CLUSTER_NODE_STATE enumeration. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterNodeUp</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The node is physically plugged in, turned on, booted, and capable of executing programs. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ClusterNodeDown</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The node is
///    turned off or not operational. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterNodeJoining</b></dt>
///    <dt>3</dt> </dl> </td> <td width="60%"> The node is in the process of joining a cluster. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ClusterNodePaused</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The node is running
///    but not participating in cluster operations. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterNodeStateUnknown</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> The operation was not
///    successful. For more information about the error, call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
CLUSTER_NODE_STATE GetClusterNodeState(_HNODE* hNode);

///Returns the unique identifier of a cluster node. The <b>PCLUSAPI_GET_CLUSTER_NODE_ID</b> type defines a pointer to
///this function.
///Params:
///    hNode = Handle to the node with the identifier to be returned or <b>NULL</b>. If <i>hNode</i> is set to <b>NULL</b>, the
///            node identifier for the node on which the application is running is returned in the content of <i>lpszNodeId</i>.
///    lpszNodeId = This parameter points to a buffer that receives the unique ID of <i>hNode</i>, including the terminating
///                 <b>NULL</b> character.
///    lpcchName = On input, pointer to the count of characters in the buffer pointed to by the <i>lpszNodeId</i> parameter,
///                including the <b>NULL</b> terminator. On output, pointer to the count of characters stored in the buffer
///                excluding the <b>NULL</b> terminator.
///Returns:
///    This function returns a system error code. The following are the possible values: <table> <tr> <th>Return
///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt>
///    </dl> </td> <td width="60%"> The operation completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> More data is available. This
///    value is returned if the buffer pointed to by <i>lpszNodeId</i> is not long enough to hold the required number of
///    characters. GetClusterNodeId sets the content of <i>lpcchName</i> to the required length. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint GetClusterNodeId(_HNODE* hNode, PWSTR lpszNodeId, uint* lpcchName);

///Returns a handle to the cluster associated with a node. The <b>PCLUSAPI_GET_CLUSTER_FROM_NODE</b> type defines a
///pointer to this function.
///Params:
///    hNode = Handle to the node.
///Returns:
///    If the operation succeeds, the function returns a handle to the cluster that owns the node. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromNode(_HNODE* hNode);

///Requests that a node temporarily suspend its cluster activity. The <b>PCLUSAPI_PAUSE_CLUSTER_NODE</b> type defines a
///pointer to this function.
///Params:
///    hNode = Handle to the node to suspend activity.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint PauseClusterNode(_HNODE* hNode);

///Requests that a paused node resume its cluster activity. The <b>PCLUSAPI_RESUME_CLUSTER_NODE</b> type defines a
///pointer to this function.
///Params:
///    hNode = Handle to the paused node.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ResumeClusterNode(_HNODE* hNode);

///Deletes a node from the cluster database. The <b>PCLUSAPI_EVICT_CLUSTER_NODE</b> type defines a pointer to this
///function.
///Params:
///    hNode = Handle to the node to delete.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint EvictClusterNode(_HNODE* hNode);

///Opens an enumerator for iterating through the installed network interfaces.
///Params:
///    hCluster = Handle to a cluster
///    lpszNodeName = The name of the node.
///    lpszNetworkName = The name of the network.
@DllImport("CLUSAPI")
_HNETINTERFACEENUM* ClusterNetInterfaceOpenEnum(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, 
                                                const(PWSTR) lpszNetworkName);

///Enumerates the network interfaces installed on a cluster, returning one name with each call.
///Params:
///    hNetInterfaceEnum = Handle to an existing enumeration object originally returned by the ClusterNetInterfaceOpenEnum function.
///    dwIndex = Index used to identify the entry to be enumerated. This parameter should be zero for the first call and then
///              incremented for each subsequent call.
///    lpszName = Pointer to a null-terminated Unicode string containing the name of the returned object.
///    lpcchName = Pointer to the size, in characters, of the <i>lpszName</i> buffer. On input, specify the maximum number of
///                characters the buffer can hold, including the terminating <b>NULL</b>. On output, indicates the number of
///                characters in the resulting name, excluding the terminating <b>NULL</b>.
@DllImport("CLUSAPI")
uint ClusterNetInterfaceEnum(_HNETINTERFACEENUM* hNetInterfaceEnum, uint dwIndex, PWSTR lpszName, uint* lpcchName);

///Closes a network interface enumeration handle.
///Params:
///    hNetInterfaceEnum = Handle to the node enumerator to close. This is a handle originally returned by the ClusterNetInterfaceOpenEnum
///                        function.
@DllImport("CLUSAPI")
uint ClusterNetInterfaceCloseEnum(_HNETINTERFACEENUM* hNetInterfaceEnum);

///Opens an enumerator for iterating through the network interfaces or groups installed on a node. The
///<b>PCLUSAPI_CLUSTER_NODE_OPEN_ENUM</b> type defines a pointer to this function.
///Params:
///    hNode = Handle to a node.
///    dwType = Bitmask describing the type of objects to be enumerated. The following values of the CLUSTER_NODE_ENUM
///             enumeration are valid.
///Returns:
///    If the operation succeeds, <b>ClusterNodeOpenEnum</b> returns a handle to a node enumerator. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call the GetLastError function.
///    
@DllImport("CLUSAPI")
_HNODEENUM* ClusterNodeOpenEnum(_HNODE* hNode, uint dwType);

///Opens an enumerator that can iterate through the network interfaces or groups that are installed on a node.
///Params:
///    hNode = A handle to the node.
///    dwType = A bitmask that describes the type of objects to enumerate. This parameter is retrieved from a CLUSTER_NODE_ENUM
///             enumeration value.
///    pOptions = Options.
///Returns:
///    If the operation succeeds, the <b>ClusterNodeOpenEnumEx</b> function returns a handle to a node enumerator. If
///    the operation fails, the function returns <b>NULL</b>. For more information about the error, call the
///    GetLastError function.
///    
@DllImport("CLUSAPI")
_HNODEENUMEX* ClusterNodeOpenEnumEx(_HNODE* hNode, uint dwType, void* pOptions);

///Returns the number of cluster objects that are associated with a node enumeration handle.
///Params:
///    hNodeEnum = The handle to a node enumeration that was retrieved by the ClusterNodeOpenEnumEx function. A valid handle is
///                required. This parameter cannot be <b>NULL</b>.
///Returns:
///    The number of objects that are associated with the enumeration handle.
///    
@DllImport("CLUSAPI")
uint ClusterNodeGetEnumCountEx(_HNODEENUMEX* hNodeEnum);

///Retrieves the specified cluster node from a CLUSTER_ENUM_ITEM enumeration.
///Params:
///    hNodeEnum = A handle to the CLUSTER_ENUM_ITEM enumeration that contains the cluster node to retrieve.
///    dwIndex = The index that identifies the next object to enumerate. This parameter should be zero for the first call to the
///              ClusterEnumEx function and then be incremented for subsequent calls.
///    pItem = A pointer that receives the returned cluster node.
///    cbItem = On input, the size of the <i>pItem</i> parameter. On output, either the required size in bytes of the buffer if
///             the buffer is too small, or the number of bytes written into the buffer.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> <i>dwIndex</i> is larger than the number of
///    items in the enumeration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The buffer is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl>
///    </td> <td width="60%"> The buffer was filled successfully. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterNodeEnumEx(_HNODEENUMEX* hNodeEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

///Closes a node enumeration handle.
///Params:
///    hNodeEnum = The handle to the node enumeration to close. This handle is returned by the ClusterNodeOpenEnumEx function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterNodeCloseEnumEx(_HNODEENUMEX* hNodeEnum);

///Returns the number of cluster objects associated with a node enumeration handle.
///Params:
///    hNodeEnum = Handle to a node enumeration. This handle is obtained from ClusterNodeOpenEnum. A valid handle is required. This
///                parameter cannot be <b>NULL</b>.
@DllImport("CLUSAPI")
uint ClusterNodeGetEnumCount(_HNODEENUM* hNodeEnum);

///Closes a node enumeration handle. The <b>PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM</b> type defines a pointer to this
///function.
///Params:
///    hNodeEnum = Handle to the node enumerator to close. This is a handle originally returned by the ClusterNodeOpenEnum function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterNodeCloseEnum(_HNODEENUM* hNodeEnum);

///Enumerates the network interfaces or groups installed on a node, returning the name of each with each call. The
///<b>PCLUSAPI_CLUSTER_NODE_ENUM</b> type defines a pointer to this function.
///Params:
///    hNodeEnum = Handle to an existing enumeration object originally returned by the ClusterNodeOpenEnum function.
///    dwIndex = Index used to identify the next entry to be enumerated. This parameter should be zero for the first call to
///              <b>ClusterNodeEnum</b> and then incremented for subsequent calls.
///    lpdwType = Pointer to the type of object returned. The following value of the CLUSTER_NODE_ENUM enumeration is returned with
///               each call.
///    lpszName = Pointer to a null-terminated Unicode string containing the name of the returned object.
///    lpcchName = Pointer to the size of the <i>lpszName</i> buffer as a count of characters. On input, specify the maximum number
///                of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number of
///                characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt>
///    <dt>259 (0x103)</dt> </dl> </td> <td width="60%"> No more data is available. This value is returned if there are
///    no more objects of the requested type to be returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> More data is available. This
///    value is returned if the buffer pointed to by <i>lpszName</i> is not big enough to hold the result. The
///    <i>lpcchName</i> parameter returns the number of characters in the result, excluding the terminating <b>NULL</b>.
///    </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterNodeEnum(_HNODEENUM* hNodeEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

///Evicts a node from the cluster and initiates cleanup operations on the node. The
///<b>PCLUSAPI_EVICT_CLUSTER_NODE_EX</b> type defines a pointer to this function.
///Params:
///    hNode = Handle to the node to remove from the cluster.
///    dwTimeOut = Specifies the number of milliseconds for the function to wait for cleanup operations to occur. The function will
///                return when the cleanup is complete or when the specified time elapses, whichever is sooner.
///    phrCleanupStatus = Pointer to an <b>HRESULT</b> that describes the results of the cleanup operation.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code, including the following value. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CLUSTER_EVICT_WITHOUT_CLEANUP</b></dt> </dl>
///    </td> <td width="60%"> The node was evicted but the cleanup operation returned a value other than S_OK. </td>
///    </tr> </table>
///    
@DllImport("CLUSAPI")
uint EvictClusterNodeEx(_HNODE* hNode, uint dwTimeOut, HRESULT* phrCleanupStatus);

///Opens the root of the cluster database subtree for a resource type.
///Params:
///    hCluster = Handle to a cluster.
///    lpszTypeName = Pointer to a NULL-terminated Unicode string specifying the name of a resource type (the registered type name, not
///                   the display name).
///    samDesired = Access mask that describes the security access needed for the opened key.
///Returns:
///    If the operation succeeds, the function returns a registry key handle for the resource type. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
HKEY GetClusterResourceTypeKey(_HCLUSTER* hCluster, const(PWSTR) lpszTypeName, uint samDesired);

///Adds a group to a cluster and returns a handle to the newly added group. The <b>PCLUSAPI_CREATE_CLUSTER_GROUP</b>
///type defines a pointer to this function.
///Params:
///    hCluster = Handle to the target cluster.
///    lpszGroupName = Pointer to a null-terminated Unicode string containing the name of the group to be added to the cluster
///                    identified by <i>hCluster</i>. If there is not a group by this name, <b>CreateClusterGroup</b> creates it.
///Returns:
///    If the operation succeeds, the function returns a group handle. If the operation fails, the function returns
///    <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HGROUP* CreateClusterGroup(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName);

///Opens a failover cluster group and returns a handle to it.
///Params:
///    hCluster = Handle to a cluster that includes the group to open.
///    lpszGroupName = Name of the group to open.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt>
///    </dl> </td> <td width="60%"> The operation was not successful. For information about the error, call the function
///    GetLastError. </td> </tr> </table> If the operation was successful, <b>OpenClusterGroup</b> returns a group
///    handle.
///    
@DllImport("CLUSAPI")
_HGROUP* OpenClusterGroup(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName);

///Opens a failover cluster group and returns a handle to it.
///Params:
///    hCluster = Handle to a cluster that includes the group to open.
///    lpszGroupName = Name of the group to open.
///    dwDesiredAccess = The requested access privileges. This may be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0) and undefined
///                      error may be returned. Using <b>GENERIC_ALL</b> is the same as calling OpenClusterGroup.
///    lpdwGrantedAccess = Optional parameter that contains the address of a <b>DWORD</b> that will receive the access rights granted. If
///                        the <i>DesiredAccess</i> parameter is <b>MAXIMUM_ALLOWED</b> (0x02000000) then the <b>DWORD</b> pointed to by
///                        this parameter will contain the maximum privileges granted to this user.
///Returns:
///    If the operation was successful, <b>OpenClusterGroupEx</b> returns a group handle. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> </dl> </td> <td width="60%">
///    The operation was not successful. For more information about the error, call the GetLastError function. If the
///    target server does not support the OpenClusterGroupEx function (for example if the target server is running
///    Windows Server 2008 or earlier) then the <b>GetLastError</b> function will return
///    <b>RPC_S_PROCNUM_OUT_OF_RANGE</b> (1745). </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HGROUP* OpenClusterGroupEx(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName, uint dwDesiredAccess, 
                            uint* lpdwGrantedAccess);

///Requests that a node temporarily suspends its cluster activity.
///Params:
///    hNode = A handle to the node to suspend.
///    bDrainNode = <b>TRUE</b> to drain the node; otherwise <b>FALSE</b>.
///    dwPauseFlags = One of the following flags: - CLUSAPI_NODE_PAUSE_REMAIN_ON_PAUSED_NODE_ON_MOVE_ERROR 0x00000001 -
///                   CLUSAPI_NODE_AVOID_PLACEMENT 0x00000002 - CLUSAPI_NODE_PAUSE_RETRY_DRAIN_ON_FAILURE 0x00000004
///    hNodeDrainTarget = The node drain topic.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint PauseClusterNodeEx(_HNODE* hNode, BOOL bDrainNode, uint dwPauseFlags, _HNODE* hNodeDrainTarget);

///Initiates the specified failback operation, and then requests that a paused node resumes cluster activity.
///Params:
///    hNode = The handle to the paused node.
///    eResumeFailbackType = The type of failback operation to use when cluster activity resumes. The available failback types are specified
///                          in the CLUSTER_NODE_RESUME_FAILBACK_TYPE enumeration.
///    dwResumeFlagsReserved = This parameter is reserved for future use.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ResumeClusterNodeEx(_HNODE* hNode, CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                         uint dwResumeFlagsReserved);

///Creates a new cluster group with the options specified in the <b>CLUSTER_CREATE_GROUP_INFO</b> structure in a single
///operation.The <b>PCLUSAPI_CREATE_CLUSTER_GROUPEX</b> type defines a pointer to this function.
///Params:
///    hCluster = The handle to the cluster in which the group will be created.
///    lpszGroupName = The name of the new cluster group.
///    pGroupInfo = The additional information used to create the group.
///Returns:
///    If the operation is successful, the function returns a handle to the newly created group. If the operation fails,
///    the function returns <b>NULL</b>.
///    
@DllImport("CLUSAPI")
_HGROUP* CreateClusterGroupEx(_HCLUSTER* hCluster, const(PWSTR) lpszGroupName, 
                              CLUSTER_CREATE_GROUP_INFO* pGroupInfo);

///Opens a handle to the group enumeration.The <b>PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM_EX</b> type defines a pointer to this
///function.
///Params:
///    hCluster = The handle to the cluster on which the enumeration will be performed.
///    lpszProperties = A pointer to a list of names of common properties.
///    cbProperties = The size, in bytes, of the <b>lpszProperties</b> field.
///    lpszRoProperties = A pointer to a list of names of read-only common properties.
///    cbRoProperties = The size, in bytes, of the <b>lpszRoProperties</b> field.
///    dwFlags = Reserved for future use. This value must be 0.
///Returns:
///    If the operation is successful, the function returns a handle to the enumeration. If the operation fails, the
///    function returns <b>NULL</b>.
///    
@DllImport("CLUSAPI")
_HGROUPENUMEX* ClusterGroupOpenEnumEx(_HCLUSTER* hCluster, const(PWSTR) lpszProperties, uint cbProperties, 
                                      const(PWSTR) lpszRoProperties, uint cbRoProperties, uint dwFlags);

///Returns the number of elements in the enumeration.The <b>PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT_EX</b> type defines a
///pointer to this function.
///Params:
///    hGroupEnumEx = The handle to the enumeration from which the number of entries will be returned.
///Returns:
///    The number of items in the enumeration.
///    
@DllImport("CLUSAPI")
uint ClusterGroupGetEnumCountEx(_HGROUPENUMEX* hGroupEnumEx);

///Retrieves an item in the enumeration.The <b>PCLUSAPI_CLUSTER_GROUP_ENUM_EX</b> type defines a pointer to this
///function.
///Params:
///    hGroupEnumEx = The handle to the enumeration from which the item will be retrieved.
///    dwIndex = The zero-based index of the item in the enumeration.
///    pItem = A pointer to the buffer to be filled.
///    cbItem = On input, the size of <i>pItem</i>. On output, either the required size in bytes of the buffer if the buffer is
///             too small, or the number of bytes written into the buffer.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> <i>dwIndex</i> is larger than the number of
///    items in the enumeration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The buffer is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl>
///    </td> <td width="60%"> The buffer was filled successfully. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterGroupEnumEx(_HGROUPENUMEX* hGroupEnumEx, uint dwIndex, CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);

///Closes the enumeration and frees any memory held by the <i>hGroupEnumEx</i> handle. The
///<b>PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM_EX</b> type defines a pointer to this function.
///Params:
///    hGroupEnumEx = The handle to the enumeration that will be freed.
///Returns:
///    ERROR_SUCCESS is returned when the enumeration handle is freed.
///    
@DllImport("CLUSAPI")
uint ClusterGroupCloseEnumEx(_HGROUPENUMEX* hGroupEnumEx);

///Opens a handle to a resource enumeration that enables iteration through a resource's dependencies and nodes.
///Params:
///    hCluster = A handle to the resource to iterate through.
///    lpszProperties = A pointer to a list of names of common properties.
///    cbProperties = The size, in bytes, of the <i>lpszProperties</i> parameter.
///    lpszRoProperties = A pointer to a list of names of read-only common properties.
///    cbRoProperties = The size, in bytes, of the <i>lpszRoProperties</i> parameter.
///    dwFlags = The index that identifies the next object to enumerate. This parameter should be zero for the first call to
///              <b>ClusterResourceOpenEnumEx</b> and then be incremented for subsequent calls.
///Returns:
///    If the operation succeeds, the function returns an enumeration handle. If the operation fails, the function
///    returns <b>NULL</b>. For more information about the error, call the GetLastError function.
///    
@DllImport("CLUSAPI")
_HRESENUMEX* ClusterResourceOpenEnumEx(_HCLUSTER* hCluster, const(PWSTR) lpszProperties, uint cbProperties, 
                                       const(PWSTR) lpszRoProperties, uint cbRoProperties, uint dwFlags);

///Returns the number of cluster objects that are associated with a resource enumeration handle.
///Params:
///    hResourceEnumEx = The handle to a resource enumeration. This handle is obtained from the ClusterResourceOpenEnumEx function. A
///                      valid handle is required. This parameter cannot be <b>NULL</b>.
///Returns:
///    The number of objects that are associated with the enumeration handle.
///    
@DllImport("CLUSAPI")
uint ClusterResourceGetEnumCountEx(_HRESENUMEX* hResourceEnumEx);

///Enumerates a resource and then returns a pointer to the current dependent resource or node.
///Params:
///    hResourceEnumEx = A handle to a resource enumeration that is returned from the ClusterResourceOpenEnumEx function.
///    dwIndex = The index of the resource or node object to return. This parameter should be zero for the first call to the
///              <b>ClusterResourceEnumEx</b> function and then be incremented for subsequent calls.
///    pItem = A pointer that receives the returned object.
///    cbItem = On input, the size of the <i>pItem</i> parameter. On output, either the required size in bytes of the buffer if
///             the buffer is too small, or the number of bytes written into the buffer.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation finished successfully, or the <i>lpszName</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The buffer to
///    which the <i>lpszName</i> parameter points is not big enough to hold the result. The <i>lpcchName</i> parameter
///    returns the number of characters in the result, excluding the terminating null character. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259 (0x103)</dt> </dl> </td> <td width="60%"> There are
///    no more objects to be returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl>
///    </td> <td width="60%"> Any other returned error code indicates that the operation failed. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterResourceEnumEx(_HRESENUMEX* hResourceEnumEx, uint dwIndex, CLUSTER_RESOURCE_ENUM_ITEM* pItem, 
                           uint* cbItem);

///Closes a handle to a resource enumeration.
///Params:
///    hResourceEnumEx = The handle to a resource enumeration to close.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a different system error code.
///    
@DllImport("CLUSAPI")
uint ClusterResourceCloseEnumEx(_HRESENUMEX* hResourceEnumEx);

///Brings a group online.
///Params:
///    hGroup = A handle to the group to be brought online.
///    hDestinationNode = A handle to the node that is to host the group.
///    dwOnlineFlags = A flag that specifies settings for the resource that is to be brought online.
///    lpInBuffer = A pointer to the input buffer that receives instructions for the operation. The <i>lpInBuffer</i> parameter is
///                 formatted as a property list.
///    cbInBufferSize = The size of the <i>lpInBuffer</i> parameter, in bytes.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_NODE_NOT_AVAILABLE</b></dt> </dl> </td>
///    <td width="60%"> A suitable host node was not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> The operation is in progress. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint OnlineClusterGroupEx(_HGROUP* hGroup, _HNODE* hDestinationNode, uint dwOnlineFlags, ubyte* lpInBuffer, 
                          uint cbInBufferSize);

///Extends the OfflineClusterGroup method. The client can use the flags to control failover policies of the group and
///the input buffer to send specific instructions for the offline operation to the resources in the target group. For
///instance, the input buffer can be used to instruct a virtual machine to go offline by saving its state as opposed to
///shutting down.
///Params:
///    hGroup = The handle to a cluster group.
///    dwOfflineFlags = Flags that influence the offline policy. Along with 0x0, the following is an acceptable value:
///                     <b>CLUSAPI_GROUP_OFFLINE_IGNORE_RESOURCE_LOCKED_STATUS</b> (0x00000001): disregard if a resource has indicated
///                     that it should be “locked” in its current state.
///    lpInBuffer = Contains instructions for the offline operation that are targeted at specific resources within the group.
///                 <i>lpInBuffer</i> is formatted as a property list, which means that the instructions are contained in property
///                 values. Resources in the group search the property list for property names that they support for offline
///                 operations and then interpret the instructions in the associated property value. Note that the properties
///                 supported by a resource in an <b>OfflineClusterGroupEx</b> operation are not related to the private properties
///                 associated with a resource.
///    cbInBufferSize = The size of <i>lpInBuffer</i>, in bytes.
///Returns:
///    <b>OfflineClusterGroupEx</b> returns <b>ERROR_IO_PENDING</b> if the offline command has been accepted and is in
///    progress. <b>OfflineClusterGroupEx</b> returns a nonzero error code if the offline command was rejected
///    immediately with no changes to group state.
///    
@DllImport("CLUSAPI")
uint OfflineClusterGroupEx(_HGROUP* hGroup, uint dwOfflineFlags, ubyte* lpInBuffer, uint cbInBufferSize);

///Brings an offline or failed resource online.
///Params:
///    hResource = The handle to the resource to bring online.
///    dwOnlineFlags = A flag that specifies settings for the resource that is to be brought online.
///    lpInBuffer = A pointer to the input buffer that receives instructions for the operation. The <i>lpInBuffer</i> parameter is
///                 formatted as a property list.
///    cbInBufferSize = The size of <i>lpInBuffer</i>, in bytes.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td
///    width="60%"> The resource or one of the resources that it depends on has returned <b>ERROR_IO_PENDING</b> from
///    its Online entry point function. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint OnlineClusterResourceEx(_HRESOURCE* hResource, uint dwOnlineFlags, ubyte* lpInBuffer, uint cbInBufferSize);

///Extends the OfflineClusterResource method. The client can use the flags to control policies of the resource and the
///input buffer to send specific instructions for the offline operation to the resource. For instance, the input buffer
///can be used to instruct a VM to go offline by saving its state as opposed to shutting down.
///Params:
///    hResource = The handle to a cluster resource.
///    dwOfflineFlags = Flags that influence the offline policy. This parameter can be set to one or more of the following values:
///    lpInBuffer = Contains instructions for the offline operation that are targeted at the specific resource. <i>lpInBuffer</i> is
///                 formatted as a property list, which means that the instructions are contained in property values. The resource
///                 DLL searches the property list for property names that it supports for offline operations and then interprets the
///                 instructions in the associated property value. Note that the properties supported by a resource in an
///                 <b>OfflineClusterResourceEx</b> operation are not related to the private properties associated with a resource.
///    cbInBufferSize = The size of <i>lpInBuffer</i>, in bytes.
///Returns:
///    <b>OfflineClusterResourceEx</b> returns <b>ERROR_IO_PENDING</b> if the offline command has been accepted and is
///    in progress. <b>OfflineClusterResourceEx</b> returns a nonzero error code if the offline command was rejected
///    immediately with no changes to resource state.
///    
@DllImport("CLUSAPI")
uint OfflineClusterResourceEx(_HRESOURCE* hResource, uint dwOfflineFlags, ubyte* lpInBuffer, uint cbInBufferSize);

///Extends the existing MoveClusterGroup method with the addition of flags and a buffer. The flags control the behavior
///of the cluster failover policy, and the input buffer enables the client to send special instructions to the resources
///in the group.
///Params:
///    hGroup = The handle to a cluster group.
///    hDestinationNode = The handle to a cluster node, indicating the node to which the group should be moved. This parameter is optional.
///                       If left <b>NULL</b>, the cluster will move the group to the most suitable node, according to failover policies
///                       configured for the cluster and for this particular group.
///    dwMoveFlags = A bitwise combination of the flags that influence the failover policy with respect to this move operation.
///    lpInBuffer = A property list that contains move operation instructions for specific resources within the group. The
///                 instructions are contained in property values. Resources in the group search the property list for property names
///                 that they support for move operations and then interpret the instructions in the associated property value. The
///                 properties supported by a resource in a <b>MoveClusterGroupEx</b> operation are not related to the private
///                 properties associated with a resource.
///    cbInBufferSize = The size of <i>lpInBuffer</i>, in bytes.
///Returns:
///    <b>MoveClusterGroupEx</b> returns <b>ERROR_IO_PENDING</b> if the move command has been accepted and is in
///    progress. <b>MoveClusterGroupEx</b> returns a nonzero error code if the move command was rejected immediately
///    with no changes to group state. For instance, this would happen if <i>hDestinationNode</i> is not Up at the time
///    of the move request.
///    
@DllImport("CLUSAPI")
uint MoveClusterGroupEx(_HGROUP* hGroup, _HNODE* hDestinationNode, uint dwMoveFlags, ubyte* lpInBuffer, 
                        uint cbInBufferSize);

///Enables a client to cancel a MoveClusterGroup or MoveClusterGroupEx operation that is pending for a group. The group
///is then returned to its persistent state.
///Params:
///    hGroup = The handle to a cluster group.
///    dwCancelFlags_RESERVED = This parameter is reserved for future use and must be set to zero.
///Returns:
///    <b>CancelClusterGroupOperation</b> returns <b>ERROR_SUCCESS</b> if the move operation on the group was
///    successfully cancelled. <b>CancelClusterGroupOperation</b> returns <b>ERROR_IO_PENDING</b> if the cancellation of
///    the move operation is now in progress. <b>CancelClusterGroupOperation</b> returns a different nonzero error code
///    if there was a failure issuing the cancellation for the move group operation on the designated group.
///    
@DllImport("CLUSAPI")
uint CancelClusterGroupOperation(_HGROUP* hGroup, uint dwCancelFlags_RESERVED);

///Restarts a cluster resource. The <b>PCLUSAPI_RESTART_CLUSTER_RESOURCE</b> type defines a pointer to this function.
///Params:
///    hResource = A handle to the cluster resource.
///    dwFlags = TBD
///Returns:
///    TBD
///    
@DllImport("CLUSAPI")
uint RestartClusterResource(_HRESOURCE* hResource, uint dwFlags);

///Closes a group handle. The <b>PCLUSAPI_CLOSE_CLUSTER_GROUP</b> type defines a pointer to this function.
///Params:
///    hGroup = Handle to the group to close.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The operation was not successful. For more information about
///    the error, call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
BOOL CloseClusterGroup(_HGROUP* hGroup);

///Returns a handle to the cluster associated with a group. The <b>PCLUSAPI_GET_CLUSTER_FROM_GROUP</b> type defines a
///pointer to this function.
///Params:
///    hGroup = Handle to the group.
///Returns:
///    If the operation succeeds, the function returns a handle to the cluster that owns the group. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromGroup(_HGROUP* hGroup);

///Returns the current state of a group. The <b>PCLUSAPI_GET_CLUSTER_GROUP_STATE</b> type defines a pointer to this
///function.
///Params:
///    hGroup = Handle to the group for which state information should be returned.
///    lpszNodeName = Pointer to a null-terminated Unicode string containing the name of the node that currently owns the group.
///    lpcchNodeName = Pointer to the size of the <i>lpszNodeName</i> buffer as a count of characters. On input, specify the maximum
///                    number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                    of characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    <b>GetClusterGroupState</b> returns the current state of the group, which is represented by one of the following
///    values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterGroupStateUnknown</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> The operation was not
///    successful. For more information about the error, call the function GetLastError. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ClusterGroupOnline</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> All of the resources
///    in the group are online. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterGroupOffline</b></dt> <dt>1</dt>
///    </dl> </td> <td width="60%"> All of the resources in the group are offline or there are no resources in the
///    group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterGroupFailed</b></dt> <dt>2</dt> </dl> </td> <td
///    width="60%"> At least one resource in the group has failed (set a state of <b>ClusterResourceFailed</b> from the
///    CLUSTER_RESOURCE_STATE enumeration). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterGroupPartialOnline</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> At least one resource in the
///    group is online. No resources are pending or failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterGroupPending</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> At least one resource in the group is
///    in a pending state. There are no failed resources. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
CLUSTER_GROUP_STATE GetClusterGroupState(_HGROUP* hGroup, PWSTR lpszNodeName, uint* lpcchNodeName);

///Sets the name for a group. The <b>PCLUSAPI_SET_CLUSTER_GROUP_NAME</b> type defines a pointer to this function.
///Params:
///    hGroup = Handle to the group to name.
///    lpszGroupName = Pointer to the new name for the group identified by <i>hGroup</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint SetClusterGroupName(_HGROUP* hGroup, const(PWSTR) lpszGroupName);

///Sets the preferred node list for a group. The <b>PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST</b> type defines a pointer to
///this function.
///Params:
///    hGroup = Handle to the group to be assigned the list of nodes.
///    NodeCount = Count of nodes in the list identified by <i>NodeList</i>.
///    NodeList = Array of handles to nodes, in order by preference, with the first node being the most preferred and the last node
///               the least preferred. The number of nodes in the <i>NodeList</i> array is controlled by the <i>NodeCount</i>
///               parameter.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint SetClusterGroupNodeList(_HGROUP* hGroup, uint NodeCount, _HNODE** NodeList);

///Brings a group online. The <b>PCLUSAPI_ONLINE_CLUSTER_GROUP</b> type defines a pointer to this function.
///Params:
///    hGroup = Handle to the group to be brought online.
///    hDestinationNode = Handle to the node where the group identified by <i>hGroup</i> should be brought online or <b>NULL</b>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_NODE_NOT_AVAILABLE</b></dt> </dl> </td>
///    <td width="60%"> A suitable host node was not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> The operation is in progress. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint OnlineClusterGroup(_HGROUP* hGroup, _HNODE* hDestinationNode);

///Moves a group and all of its resources from one node to another. The <b>PCLUSAPI_MOVE_CLUSTER_GROUP</b> type defines
///a pointer to this function.
///Params:
///    hGroup = Handle to the group to be moved.
///    hDestinationNode = Handle to the node where the moved group should be brought back online or <b>NULL</b>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is one of the possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td
///    width="60%"> The reassignment of ownership of the group is in progress. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint MoveClusterGroup(_HGROUP* hGroup, _HNODE* hDestinationNode);

///Takes a group offline. The <b>PCLUSAPI_OFFLINE_CLUSTER_GROUP</b> type defines a pointer to this function.
///Params:
///    hGroup = Handle to the group to be taken offline.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is one of the possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td
///    width="60%"> The operation is in progress. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint OfflineClusterGroup(_HGROUP* hGroup);

///Removes an offline and empty group from a cluster. The <b>PCLUSAPI_DELETE_CLUSTER_GROUP</b> type defines a pointer to
///this function.
///Params:
///    hGroup = Handle to the group to be removed. You must close this handle separately.
///Returns:
///    This function returns a system error code. If the operation completes successfully the function returns
///    <b>ERROR_SUCCESS</b> (0). Any other returned system error code would indicate that the operation failed.
///    
@DllImport("CLUSAPI")
uint DeleteClusterGroup(_HGROUP* hGroup);

///Deletes the specified group from a cluster. Unlike DeleteClusterGroup the group can contain resources and it can be
///online. The <b>PCLUSAPI_DESTROY_CLUSTER_GROUP</b> type defines a pointer to this function.
///Params:
///    hGroup = This parameter takes a handle to the cluster group to be destroyed.
///Returns:
///    This function returns a system error code. If the operation completes successfully the function returns
///    <b>ERROR_SUCCESS</b> (0). Any other returned system error code would indicate that the operation failed.
///    
@DllImport("CLUSAPI")
uint DestroyClusterGroup(_HGROUP* hGroup);

///Opens an enumerator for iterating through a group's resources and/or the nodes that are included in its list of
///preferred owners. The <b>PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM</b> type defines a pointer to this function.
///Params:
///    hGroup = A handle to the group to be enumerated.
///    dwType = A bitmask that describes the cluster objects to be enumerated. The following are valid values of the
///             CLUSTER_GROUP_ENUM enumeration.
///Returns:
///    If the operation succeeds, <b>ClusterGroupOpenEnum</b> returns a handle to an enumerator that can be passed to
///    the ClusterGroupEnum function. If the operation fails, the function returns <b>NULL</b>. For more information
///    about the error, call the function GetLastError.
///    
@DllImport("CLUSAPI")
_HGROUPENUM* ClusterGroupOpenEnum(_HGROUP* hGroup, uint dwType);

///Returns the number of cluster objects associated with a group enumeration handle. The
///<b>PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT</b> type defines a pointer to this function.
///Params:
///    hGroupEnum = Handle to a group enumeration. This handle is obtained from ClusterGroupOpenEnum. A valid handle is required.
///                 This parameter cannot be <b>NULL</b>.
@DllImport("CLUSAPI")
uint ClusterGroupGetEnumCount(_HGROUPENUM* hGroupEnum);

///Enumerates the resources in a group or the nodes that are the preferred owners of a group, returning the name of the
///resource or node with each call. The <b>PCLUSAPI_CLUSTER_GROUP_ENUM</b> type defines a pointer to this function.
///Params:
///    hGroupEnum = A group enumeration handle returned by the ClusterGroupOpenEnum function.
///    dwIndex = The index of the resource or node to return. This parameter should be zero for the first call to
///              <b>ClusterGroupEnum</b> and then incremented for subsequent calls.
///    lpdwType = A pointer to the type of object returned by <b>ClusterGroupEnum</b>. The following are valid values of the
///               CLUSTER_GROUP_ENUM enumeration.
///    lpszResourceName = A pointer to a null-terminated Unicode string containing the name of the returned resource or node.
///    lpcchName = A pointer to the size of the <i>lpszResourceName</i> buffer as a count of characters. On input, specify the
///                maximum number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the
///                number of characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    The function can returns one of the following values. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> More data is available. This
///    value is returned if the buffer pointed to by <i>lpszResourceName</i> is not big enough to hold the result. The
///    <i>lpcchName</i> parameter returns the number of characters in the result, excluding the terminating <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259 (0x103)</dt> </dl> </td> <td
///    width="60%"> No more data is available. This value is returned if there are no more resources or nodes to be
///    returned. </td> </tr> </table> If the operation was not successful due to a problem other than those described
///    with the <b>ERROR_NO_MORE_ITEMS</b> or <b>ERROR_MORE_DATA</b> values, <b>ClusterGroupEnum</b> returns a system
///    error code.
///    
@DllImport("CLUSAPI")
uint ClusterGroupEnum(_HGROUPENUM* hGroupEnum, uint dwIndex, uint* lpdwType, PWSTR lpszResourceName, 
                      uint* lpcchName);

///Closes a group enumeration handle. The <b>PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM</b> type defines a pointer to this
///function.
///Params:
///    hGroupEnum = Enumeration handle to close.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterGroupCloseEnum(_HGROUPENUM* hGroupEnum);

///Creates a resource in a cluster. The <b>PCLUSAPI_CREATE_CLUSTER_RESOURCE</b> type defines a pointer to this function.
///Params:
///    hGroup = Handle to the group that should receive the resource.
///    lpszResourceName = Pointer to a null-terminated Unicode string containing the name of the new resource. The specified name must be
///                       unique within the cluster.
///    lpszResourceType = Pointer to the type of new resource. The specified type must be installed in the cluster.
///    dwFlags = Bitmask describing how the resource should be added to the cluster. The <i>dwFlags</i> parameter can be set to
///              one of the following values enumerated from the CLUSTER_RESOURCE_CREATE_FLAGS enumeration.
///Returns:
///    If the operation succeeds, the function returns a resource handle. If the operation fails, the function returns
///    <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HRESOURCE* CreateClusterResource(_HGROUP* hGroup, const(PWSTR) lpszResourceName, const(PWSTR) lpszResourceType, 
                                  uint dwFlags);

///Opens a resource and returns a handle to it. The <b>PCLUSAPI_OPEN_CLUSTER_RESOURCE</b> type defines a pointer to this
///function.
///Params:
///    hCluster = Handle to a cluster.
///    lpszResourceName = Pointer to a null-terminated Unicode string containing the name of the resource to be opened. Resource names are
///                       not case sensitive. A resource name must be unique within the cluster. The name is set when the resource is
///                       created and can be changed using the SetClusterResourceName function.
///Returns:
///    If the operation was successful, <b>OpenClusterResource</b> returns a handle to the opened resource. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> </dl> </td> <td
///    width="60%"> The operation was not successful. For information about the error, call the function GetLastError.
///    </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HRESOURCE* OpenClusterResource(_HCLUSTER* hCluster, const(PWSTR) lpszResourceName);

///Opens a resource and returns a handle to it.
///Params:
///    hCluster = Handle to a cluster.
///    lpszResourceName = Pointer to a null-terminated Unicode string containing the name of the resource to be opened. Resource names are
///                       not case sensitive. A resource name must be unique within the cluster. The name is set when the resource is
///                       created and can be changed using the SetClusterResourceName function.
///    dwDesiredAccess = The requested access privileges. This may be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0) and undefined
///                      error may be returned. Using <b>GENERIC_ALL</b> is the same as calling OpenClusterResource.
///    lpdwGrantedAccess = Optional parameter that contains the address of a <b>DWORD</b> that will receive the access rights granted. If
///                        the <i>DesiredAccess</i> parameter is <b>MAXIMUM_ALLOWED</b> (0x02000000) then the <b>DWORD</b> pointed to by
///                        this parameter will contain the maximum privileges granted to this user.
///Returns:
///    If the operation was successful, <b>OpenClusterResourceEx</b> returns a handle to the opened resource. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> </dl> </td>
///    <td width="60%"> The operation was not successful. For more information about the error, call the GetLastError
///    function. If the target server does not support the OpenClusterResourceEx function (for example if the target
///    server is running Windows Server 2008 or earlier) then the <b>GetLastError</b> function will return
///    <b>RPC_S_PROCNUM_OUT_OF_RANGE</b> (1745). </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HRESOURCE* OpenClusterResourceEx(_HCLUSTER* hCluster, const(PWSTR) lpszResourceName, uint dwDesiredAccess, 
                                  uint* lpdwGrantedAccess);

///Closes a resource handle. The <b>PCLUSAPI_CLOSE_CLUSTER_RESOURCE</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to the resource to be closed.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The operation was not successful. For information about the
///    error, call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
BOOL CloseClusterResource(_HRESOURCE* hResource);

///Returns a handle to the cluster associated with a resource. The <b>PCLUSAPI_GET_CLUSTER_FROM_RESOURCE</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to the resource.
///Returns:
///    If the operation succeeds, the function returns a handle to the cluster that owns the resource. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromResource(_HRESOURCE* hResource);

///Removes an offline resource from a cluster. The <b>PCLUSAPI_DELETE_CLUSTER_RESOURCE</b> type defines a pointer to
///this function.
///Params:
///    hResource = Handle to an offline resource. You must close this handle separately.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code, such as one of these values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_ONLINE</b></dt> </dl> </td> <td width="60%"> Windows
///    Server 2008 R2: The resource identified by <i>hResource</i> is not offline currently. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> Windows Server 2012: The
///    resource identified by <i>hResource</i> is not offline currently. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint DeleteClusterResource(_HRESOURCE* hResource);

///Returns the current state of a resource. The <b>PCLUSAPI_GET_CLUSTER_RESOURCE_STATE</b> type defines a pointer to
///this function.
///Params:
///    hResource = Handle specifying the resource for which state information should be returned.
///    lpszNodeName = Pointer to a buffer that receives the name of the specified resource's current owner node as a
///                   <b>NULL</b>-terminated Unicode string. Pass <b>NULL</b> if the node name is not required.
///    lpcchNodeName = Pointer to the size of the <i>lpszNodeName</i> buffer as a count of characters. This pointer cannot be
///                    <b>NULL</b> unless <i>lpszNodeName</i> is also <b>NULL</b>. On input, specifies the maximum number of characters
///                    the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number of characters in the
///                    resulting name, excluding the terminating <b>NULL</b>.
///    lpszGroupName = Pointer to a buffer that receives the name of the group that contains the specified resource. The name is
///                    returned as a <b>NULL</b>-terminated Unicode string. Pass <b>NULL</b> if the group name is not required.
///    lpcchGroupName = Pointer to the size of the <i>lpszGroupName</i> buffer as a count of characters. This pointer cannot be
///                     <b>NULL</b> unless <i>lpszNodeName</i> is also <b>NULL</b>. On input, specifies the maximum number of characters
///                     the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number of characters in the
///                     resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    <b>GetClusterResourceState</b> returns the current state of the resource enumerated from the
///    CLUSTER_RESOURCE_STATE enumeration, which can be represented by one of the following values. <table> <tr>
///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterResourceInitializing</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The resource is performing
///    initialization. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterResourceOnline</b></dt> <dt>2</dt> </dl>
///    </td> <td width="60%"> The resource is operational and functioning normally. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ClusterResourceOffline</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The resource is not
///    operational. This value will be returned if the resource reported a state of <b>ClusterResourceOffline</b> (3) or
///    <b>ClusterResourceCannotComeOnlineOnThisNode</b> (127). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterResourceFailed</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The resource has failed. This value
///    will be returned if the resource reported a state of <b>ClusterResourceFailed</b> (4) or
///    <b>ClusterResourceCannotComeOnlineOnAnyNode</b> (126). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterResourcePending</b></dt> <dt>128</dt> </dl> </td> <td width="60%"> The resource is in the process
///    of coming online or going offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterResourceOnlinePending</b></dt> <dt>129</dt> </dl> </td> <td width="60%"> The resource is in the
///    process of coming online. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterResourceOfflinePending</b></dt>
///    <dt>130</dt> </dl> </td> <td width="60%"> The resource is in the process of going offline. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ClusterResourceStateUnknown</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> The
///    operation was not successful. For more information about the error, call the function GetLastError. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
CLUSTER_RESOURCE_STATE GetClusterResourceState(_HRESOURCE* hResource, PWSTR lpszNodeName, uint* lpcchNodeName, 
                                               PWSTR lpszGroupName, uint* lpcchGroupName);

///Sets the name for a resource. The <b>PCLUSAPI_SET_CLUSTER_RESOURCE_NAME</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to a resource to rename.
///    lpszResourceName = Pointer to the new name for the resource identified by <i>hResource</i>. Resource names are not case sensitive. A
///                       resource name must be unique within the cluster.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint SetClusterResourceName(_HRESOURCE* hResource, const(PWSTR) lpszResourceName);

///Initiates a resource failure. The <b>PCLUSAPI_FAIL_CLUSTER_RESOURCE</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to the resource that is the target of the failure.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint FailClusterResource(_HRESOURCE* hResource);

///Brings an offline or failed resource online. The <b>PCLUSAPI_ONLINE_CLUSTER_RESOURCE</b> type defines a pointer to
///this function.
///Params:
///    hResource = Handle to the resource to be brought online.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td
///    width="60%"> The resource or one of the resources it depends on has returned <b>ERROR_IO_PENDING</b> from its
///    Online entry point function. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint OnlineClusterResource(_HRESOURCE* hResource);

///Takes a resource offline. The <b>PCLUSAPI_OFFLINE_CLUSTER_RESOURCE</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to the resource to be taken offline.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns one of the following system error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> The resource or one of
///    the resources it depends on has returned <b>ERROR_IO_PENDING</b> from its Offline entry point function. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_FAILED</b></dt> </dl> </td> <td width="60%"> This system
///    error code is not returned. <b>Windows Server 2008 Datacenter and Windows Server 2008 Enterprise: </b>The
///    function attempted to take offline a failed resource, so the failed resource has not been transitioned to an
///    offline state. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint OfflineClusterResource(_HRESOURCE* hResource);

///Moves a resource from one group to another. The <b>PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP</b> type defines a pointer
///to this function.
///Params:
///    hResource = Handle of the resource to be moved.
///    hGroup = Handle of the group that should receive the resource identified by <i>hResource</i>.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the system
///    error codes.
///    
@DllImport("CLUSAPI")
uint ChangeClusterResourceGroup(_HRESOURCE* hResource, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ChangeClusterResourceGroupEx(_HRESOURCE* hResource, _HGROUP* hGroup, ulong Flags);

///Adds a node to the list of possible nodes that a resource can run on. The <b>PCLUSAPI_ADD_CLUSTER_RESOURCE_NODE</b>
///type defines a pointer to this function.
///Params:
///    hResource = Handle to a resource that will add a node to its possible owners list.
///    hNode = Handle to the node to be added to the list of potential host nodes belonging to the resource identified by
///            <i>hResource</i>.
///Returns:
///    If the operation succeeds, it returns <b>ERROR_SUCCESS</b>. If the operation fails, <b>AddClusterResourceNode</b>
///    returns one of the system error codes.
///    
@DllImport("CLUSAPI")
uint AddClusterResourceNode(_HRESOURCE* hResource, _HNODE* hNode);

///Removes a node from the list of nodes that can host a resource. The <b>PCLUSAPI_REMOVE_CLUSTER_RESOURCE_NODE</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to the target resource.
///    hNode = Handle to the node that should be removed from the list of potential host nodes belonging to the resource
///            identified by <i>hResource</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint RemoveClusterResourceNode(_HRESOURCE* hResource, _HNODE* hNode);

///Creates a dependency relationship between two resources. The <b>PCLUSAPI_ADD_CLUSTER_RESOURCE_DEPENDENCY</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to the dependent resource.
///    hDependsOn = Handle to the resource that the resource identified by <i>hResource</i> should depend on.
///Returns:
///    If the operation succeeds, it returns <b>ERROR_SUCCESS</b> (0). If the operation fails,
///    <b>AddClusterResourceDependency</b> returns one of the system error codes. The following are possible return
///    values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CIRCULAR_DEPENDENCY</b></dt> <dt>1059 (0x423)</dt> </dl> </td> <td width="60%"> A resource depends
///    on itself. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DEPENDENCY_ALREADY_EXISTS</b></dt> <dt>5003
///    (0x138B)</dt> </dl> </td> <td width="60%"> The resource dependency already exists. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DEPENDENCY_NOT_ALLOWED</b></dt> <dt>5069 (0x13CD)</dt> </dl> </td> <td
///    width="60%"> The dependent resource is the quorum. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> <dt>87 (0x57)</dt> </dl> </td> <td width="60%"> The resources are not in
///    the same group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_NOT_AVAILABLE</b></dt> <dt>5006
///    (0x138E)</dt> </dl> </td> <td width="60%"> At least one of the resources is marked for deletion. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_ONLINE</b></dt> <dt>5019 (0x139B)</dt> </dl> </td> <td width="60%">
///    The dependent resource is already online. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint AddClusterResourceDependency(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);

///Removes a dependency relationship between two resources. The <b>PCLUSAPI_REMOVE_CLUSTER_RESOURCE_DEPENDENCY</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to the dependent resource.
///    hDependsOn = Handle to the resource that the resource identified by <i>hResource</i> currently depends on.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint RemoveClusterResourceDependency(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);

///Specifies the dependency expression to be associated with the resource referred to by <i>hResource</i>. Any existing
///dependency relationships for the resource will be overwritten. The
///<b>PCLUSAPI_SET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to the resource.
///    lpszDependencyExpression = Address of Unicode string containing the dependency expression.
///Returns:
///    <b>ERROR_SUCCESS</b> (0) if successful.
///    
@DllImport("CLUSAPI")
uint SetClusterResourceDependencyExpression(_HRESOURCE* hResource, const(PWSTR) lpszDependencyExpression);

///Retrieves the dependency expression associated with the specified resource. The
///<b>PCLUSAPI_GET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to the resource.
///    lpszDependencyExpression = Address of buffer that will receive the dependency expression.
///    lpcchDependencyExpression = Size in characters of the buffer pointed to by the <i>lpszDependencyExpression</i> parameter.
///Returns:
///    <b>ERROR_SUCCESS</b> (0) if successful.
///    
@DllImport("CLUSAPI")
uint GetClusterResourceDependencyExpression(_HRESOURCE* hResource, PWSTR lpszDependencyExpression, 
                                            uint* lpcchDependencyExpression);

///Adds storage to Cluster Shared Volumes. The <b>PCLUSAPI_ADD_RESOURCE_TO_CLUSTER_SHARED_VOLUMES</b> type defines a
///pointer to this function.
///Params:
///    hResource = Handle to the physical disk resource to add to Cluster Shared Volumes.
///Returns:
///    If the operation succeeds, it returns <b>ERROR_SUCCESS</b>. If the operation fails,
///    <b>AddResourceToClusterSharedVolumes</b> returns one of the system error codes.
///    
@DllImport("CLUSAPI")
uint AddResourceToClusterSharedVolumes(_HRESOURCE* hResource);

///Removes storage from Cluster Shared Volumes. The <b>PCLUSAPI_REMOVE_RESOURCE_FROM_CLUSTER_SHARED_VOLUMES</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to the physical disk resource to remove from Cluster Shared Volumes.
///Returns:
///    If the operation succeeds, it returns <b>ERROR_SUCCESS</b>. If the operation fails,
///    <b>RemoveResourceFromClusterSharedVolumes</b> returns one of the system error codes.
///    
@DllImport("CLUSAPI")
uint RemoveResourceFromClusterSharedVolumes(_HRESOURCE* hResource);

///Specifies whether the file is on the cluster shared volume.
///Params:
///    lpszPathName = A Unicode string that specifies the path of the cluster shared volume. The string ends with a terminating null
///                   character.
///    pbFileIsOnSharedVolume = <b>True</b> if the file is on the cluster shared volume; otherwise <b>false.</b>
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the system
///    error codes.
///    
@DllImport("CLUSAPI")
uint IsFileOnClusterSharedVolume(const(PWSTR) lpszPathName, BOOL* pbFileIsOnSharedVolume);

///Updates the state of a snapshot of a cluster shared volume.
///Params:
///    guidSnapshotSet = The <b>GUID</b> of the snapshot.
///    lpszVolumeName = A pointer to the name of the cluster shared volume.
///    state = A CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE enumeration value that specifies the state of the snapshot.
///Returns:
///    If the operation succeeds, the function returns a resource handle. If the operation fails, the function returns
///    <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
uint ClusterSharedVolumeSetSnapshotState(GUID guidSnapshotSet, const(PWSTR) lpszVolumeName, 
                                         CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);

///Determines if one resource can be dependent upon another resource. The <b>PCLUSAPI_CAN_RESOURCE_BE_DEPENDENT</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to the resource in question.
///    hResourceDependent = Handle to the resource upon which the resource identified by <i>hResource</i> may depend.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The resource identified by <i>hResource</i> can depend on the resource identified by
///    <i>hResourceDependent</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td
///    width="60%"> The resource identified by <i>hResource</i> cannot depend on the resource identified by
///    <i>hResourceDependent</i>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
BOOL CanResourceBeDependent(_HRESOURCE* hResource, _HRESOURCE* hResourceDependent);

///Initiates an operation affecting a resource. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hResource = Handle to the resource to be affected.
///    hHostNode = Optional handle to the node to perform the operation. If <b>NULL</b>, the node that owns the resource identified
///                by <i>hResource</i> performs the operation.
///    dwControlCode = A resource control code, enumerated by the CLUSCTL_RESOURCE_CODES enumeration, specifying the operation to be
///                    performed. For the syntax associated with a control code, refer to Control Code Architecture and the following
///                    topics: <ul> <li> CLUSCTL_RESOURCE_UNKNOWN </li> <li> CLUSCTL_RESOURCE_GET_CHARACTERISTICS </li> <li>
///                    CLUSCTL_RESOURCE_GET_FLAGS </li> <li> CLUSCTL_RESOURCE_GET_CLASS_INFO </li> <li>
///                    CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES </li> <li> CLUSCTL_RESOURCE_GET_NAME </li> <li>
///                    CLUSCTL_RESOURCE_GET_ID </li> <li> CLUSCTL_RESOURCE_GET_RESOURCE_TYPE </li> <li>
///                    CLUSCTL_RESOURCE_ENUM_COMMON_PROPERTIES </li> <li> CLUSCTL_RESOURCE_GET_RO_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_RESOURCE_GET_COMMON_PROPERTIES </li> <li> CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_RESOURCE_VALIDATE_COMMON_PROPERTIES </li> <li> CLUSCTL_RESOURCE_GET_COMMON_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_RESOURCE_ENUM_PRIVATE_PROPERTIES </li> <li> CLUSCTL_RESOURCE_GET_RO_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_RESOURCE_VALIDATE_PRIVATE_PROPERTIES </li> <li> CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT </li> <li> CLUSCTL_RESOURCE_DELETE_REGISTRY_CHECKPOINT </li> <li>
///                    CLUSCTL_RESOURCE_GET_REGISTRY_CHECKPOINTS </li> <li> CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT </li> <li>
///                    CLUSCTL_RESOURCE_DELETE_CRYPTO_CHECKPOINT </li> <li> CLUSCTL_RESOURCE_GET_CRYPTO_CHECKPOINTS </li> <li>
///                    CLUSCTL_RESOURCE_GET_LOADBAL_PROCESS_LIST </li> <li> CLUSCTL_RESOURCE_GET_NETWORK_NAME </li> <li>
///                    CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN </li> <li> CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFO </li> <li>
///                    CLUSCTL_RESOURCE_NETNAME_DELETE_CO </li> <li> CLUSCTL_RESOURCE_NETNAME_VALIDATE_VCO </li> <li>
///                    CLUSCTL_RESOURCE_NETNAME_RESET_VCO </li> <li> CLUSCTL_RESOURCE_NETNAME_REGISTER_DNS_RECORDS </li> <li>
///                    CLUSCTL_RESOURCE_GET_DNS_NAME </li> <li> CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO </li> <li>
///                    CLUSCTL_RESOURCE_STORAGE_IS_PATH_VALID </li> <li> CLUSCTL_RESOURCE_QUERY_DELETE </li> <li>
///                    CLUSCTL_RESOURCE_UPGRADE_DLL </li> <li> CLUSCTL_RESOURCE_IPADDRESS_RENEW_LEASE </li> <li>
///                    CLUSCTL_RESOURCE_IPADDRESS_RELEASE_LEASE </li> <li> CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_64BIT </li> <li>
///                    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_32BIT </li> <li> CLUSCTL_RESOURCE_QUERY_MAINTENANCE_MODE </li> <li>
///                    CLUSCTL_RESOURCE_SET_MAINTENANCE_MODE </li> <li> CLUSCTL_RESOURCE_STORAGE_SET_DRIVELETTER </li> <li>
///                    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX </li> <li> CLUSCTL_RESOURCE_FILESERVER_SHARE_ADD </li> <li>
///                    CLUSCTL_RESOURCE_FILESERVER_SHARE_DEL </li> <li> CLUSCTL_RESOURCE_FILESERVER_SHARE_MODIFY </li> <li>
///                    CLUSCTL_RESOURCE_FILESERVER_SHARE_REPORT </li> <li> CLUSCTL_RESOURCE_STORAGE_GET_MOUNTPOINTS </li> <li>
///                    CLUSCTL_RESOURCE_STORAGE_CLUSTER_DISK </li> <li> CLUSCTL_RESOURCE_STORAGE_GET_DIRTY </li> <li>
///                    CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE </li> <li> CLUSCTL_RESOURCE_ENABLE_SHARED_VOLUME_DIRECTIO </li> <li>
///                    CLUSCTL_RESOURCE_DISABLE_SHARED_VOLUME_DIRECTIO </li> <li> CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE </li>
///                    <li> CLUSCTL_RESOURCE_DELETE </li> <li> CLUSCTL_RESOURCE_INSTALL_NODE </li> <li> CLUSCTL_RESOURCE_EVICT_NODE
///                    </li> <li> CLUSCTL_RESOURCE_ADD_DEPENDENCY </li> <li> CLUSCTL_RESOURCE_REMOVE_DEPENDENCY </li> <li>
///                    CLUSCTL_RESOURCE_ADD_OWNER </li> <li> CLUSCTL_RESOURCE_REMOVE_OWNER </li> <li> CLUSCTL_RESOURCE_SET_NAME </li>
///                    <li> CLUSCTL_RESOURCE_CLUSTER_NAME_CHANGED </li> <li> CLUSCTL_RESOURCE_CLUSTER_VERSION_CHANGED </li> <li>
///                    CLUSCTL_RESOURCE_FORCE_QUORUM </li> <li> CLUSCTL_RESOURCE_INITIALIZE </li> <li>
///                    CLUSCTL_RESOURCE_STATE_CHANGE_REASON </li> <li> CLUSCTL_RESOURCE_PROVIDER_STATE_CHANGE </li> <li>
///                    CLUSCTL_RESOURCE_LEAVING_GROUP </li> <li> CLUSCTL_RESOURCE_JOINING_GROUP </li> <li>
///                    CLUSCTL_RESOURCE_FSWITNESS_GET_EPOCH_INFO </li> <li> CLUSCTL_RESOURCE_FSWITNESS_SET_EPOCH_INFO </li> <li>
///                    CLUSCTL_RESOURCE_FSWITNESS_RELEASE_LOCK </li> <li> CLUSCTL_RESOURCE_NETNAME_CREDS_UPDATED </li> </ul>
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    cbInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    cbOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpBytesReturned</i>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation was successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b>
///    on input) points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The output buffer pointed to by
///    <i>lpOutBuffer</i> was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i>
///    parameter (if not <b>NULL</b> on input) points to the size required for the output buffer. Only operations
///    requiring an output buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and
///    the <i>cbOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not
///    <b>ERROR_MORE_DATA</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_PROPERTIES_STORED</b></dt>
///    <dt>5024 (0x13A0)</dt> </dl> </td> <td width="60%"> Applies only to CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES and
///    CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES. Indicates that the properties were successfully stored but have not yet
///    been applied to the resource. The new properties will take effect after the resource is taken offline and brought
///    online again. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_NODE_NOT_RESOURCE_OWNER</b></dt> <dt>5015
///    (0x1397)</dt> </dl> </td> <td width="60%"> The node specified by the <i>hNode</i> parameter is not the node that
///    owns the resource specified by <i>hResource</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error
///    code</b></dt> </dl> </td> <td width="60%"> The operation was not successful. If the operation required an output
///    buffer, the value specified by <i>lpBytesReturned</i> (if not <b>NULL</b> on input) is unreliable. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
uint ClusterResourceControl(_HRESOURCE* hResource, _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, 
                            uint cbInBufferSize, void* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

///Initiates an operation affecting a resource. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hResource = Handle to the resource to be affected.
///    hHostNode = Optional handle to the node to perform the operation. If <b>NULL</b>, the node that owns the resource identified
///                by <i>hResource</i> performs the operation.
///    dwControlCode = A resource control code, enumerated by the CLUSCTL_RESOURCE_CODES enumeration, specifying the operation to be
///                    performed. For the syntax associated with a control code, refer to the link on the <b>CLUSCTL_RESOURCE_CODES</b>
///                    topic.
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    cbInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    cbOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpBytesReturned</i>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation was successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b>
///    on input) points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The output buffer pointed to by
///    <i>lpOutBuffer</i> was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i>
///    parameter (if not <b>NULL</b> on input) points to the size required for the output buffer. Only operations
///    requiring an output buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and
///    the <i>cbOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not
///    <b>ERROR_MORE_DATA</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_PROPERTIES_STORED</b></dt>
///    <dt>5024 (0x13A0)</dt> </dl> </td> <td width="60%"> Applies only to CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES and
///    CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES. Indicates that the properties were successfully stored but have not yet
///    been applied to the resource. The new properties will take effect after the resource is taken offline and brought
///    online again. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_NODE_NOT_RESOURCE_OWNER</b></dt> <dt>5015
///    (0x1397)</dt> </dl> </td> <td width="60%"> The node specified by the <i>hNode</i> parameter is not the node that
///    owns the resource specified by <i>hResource</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error
///    code</b></dt> </dl> </td> <td width="60%"> The operation was not successful. If the operation required an output
///    buffer, the value specified by <i>lpBytesReturned</i> (if not <b>NULL</b> on input) is unreliable. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
uint ClusterResourceControlAsUser(_HRESOURCE* hResource, _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, 
                                  uint cbInBufferSize, void* lpOutBuffer, uint cbOutBufferSize, 
                                  uint* lpBytesReturned);

///Initiates an operation affecting a resource type. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hCluster = Handle to the cluster containing the resource type identified in <i>lpszResourceTypeName</i>.
///    lpszResourceTypeName = Pointer to a <b>NULL</b>-terminated Unicode string containing the name of the resource type to be affected.
///    hHostNode = Handle to the node hosting the affected resource type.
///    dwControlCode = A resource type control code specifying the operation to be performed. For the syntax associated with a control
///                    code, refer to Control Code Architecture and the following topics: <ul> <li>
///                    CLUSCTL_RESOURCE_TYPE_ENUM_COMMON_PROPERTIES </li> <li> CLUSCTL_RESOURCE_TYPE_ENUM_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_GET_CHARACTERISTICS </li> <li> CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTIES </li> <li> CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_GET_COMMON_RESOURCE_PROPERTY_FMTS </li> <li> CLUSCTL_RESOURCE_TYPE_GET_CRYPTO_CHECKPOINTS
///                    </li> <li> CLUSCTL_RESOURCE_TYPE_GET_FLAGS </li> <li> CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_RESOURCE_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_GET_REGISTRY_CHECKPOINTS </li> <li> CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES </li>
///                    <li> CLUSCTL_RESOURCE_TYPE_GET_RO_COMMON_PROPERTIES </li> <li> CLUSCTL_RESOURCE_TYPE_GET_RO_PRIVATE_PROPERTIES
///                    </li> <li> CLUSCTL_RESOURCE_TYPE_QUERY_DELETE </li> <li> CLUSCTL_RESOURCE_TYPE_SET_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_SET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS </li>
///                    <li> CLUSCTL_RESOURCE_TYPE_STORAGE_GET_RESOURCEID </li> <li> CLUSCTL_RESOURCE_TYPE_UNKNOWN </li> <li>
///                    CLUSCTL_RESOURCE_TYPE_VALIDATE_COMMON_PROPERTIES </li> <li> CLUSCTL_RESOURCE_TYPE_VALIDATE_PRIVATE_PROPERTIES
///                    </li> </ul>
///    lpInBuffer = Pointer to the input buffer with information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    nInBufferSize = Number of bytes in the buffer pointed to by <i>lpInBuffer</i>.
///    lpOutBuffer = Pointer to the output buffer with information resulting from the operation, or <b>NULL</b> if nothing will be
///                  returned.
///    nOutBufferSize = Number of bytes in the output buffer pointed to by <i>lpOutBuffer</i>, or zero if the caller does not know how
///                     much data will be returned.
///    lpBytesReturned = Pointer to the number of bytes in the buffer pointed to by <i>lpOutBuffer</i> that were actually filled in as a
///                      result of the operation. The caller can pass <b>NULL</b> for <i>lpBytesReturned</i> if
///                      <b>ClusterResourceTypeControl</b> does not need to pass back the number of bytes in the output buffer.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation was
///    successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b> on input)
///    points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer pointed to by <i>lpOutBuffer</i>
///    was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i> parameter (if not
///    <b>NULL</b> on input) points to the size required for the output buffer. Only operations requiring an output
///    buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and the
///    <i>nOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not <b>ERROR_MORE_DATA</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. If the operation required an output buffer, the value specified by
///    <i>lpBytesReturned</i> is unreliable. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterResourceTypeControl(_HCLUSTER* hCluster, const(PWSTR) lpszResourceTypeName, _HNODE* hHostNode, 
                                uint dwControlCode, void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, 
                                uint nOutBufferSize, uint* lpBytesReturned);

///Initiates an operation affecting a resource type. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hCluster = Handle to the cluster containing the resource type identified in <i>lpszResourceTypeName</i>.
///    lpszResourceTypeName = Pointer to a <b>NULL</b>-terminated Unicode string containing the name of the resource type to be affected.
///    hHostNode = Handle to the node hosting the affected resource type.
///    dwControlCode = A resource control code, enumerated by the CLUSCTL_RESOURCE_TYPE_CODES enumeration, specifying the operation to
///                    be performed. For the syntax associated with a control code, refer to the link on the
///                    <b>CLUSCTL_RESOURCE_TYPE_CODES</b> topic.
///    lpInBuffer = Pointer to the input buffer with information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    nInBufferSize = Number of bytes in the buffer pointed to by <i>lpInBuffer</i>.
///    lpOutBuffer = Pointer to the output buffer with information resulting from the operation, or <b>NULL</b> if nothing will be
///                  returned.
///    nOutBufferSize = Number of bytes in the output buffer pointed to by <i>lpOutBuffer</i>, or zero if the caller does not know how
///                     much data will be returned.
///    lpBytesReturned = Pointer to the number of bytes in the buffer pointed to by <i>lpOutBuffer</i> that were actually filled in as a
///                      result of the operation. The caller can pass <b>NULL</b> for <i>lpBytesReturned</i> if ClusterResourceTypeControl
///                      does not need to pass back the number of bytes in the output buffer.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation was
///    successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b> on input)
///    points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer pointed to by <i>lpOutBuffer</i>
///    was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i> parameter (if not
///    <b>NULL</b> on input) points to the size required for the output buffer. Only operations requiring an output
///    buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and the
///    <i>nOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not <b>ERROR_MORE_DATA</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. If the operation required an output buffer, the value specified by
///    <i>lpBytesReturned</i> is unreliable. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterResourceTypeControlAsUser(_HCLUSTER* hCluster, const(PWSTR) lpszResourceTypeName, _HNODE* hHostNode, 
                                      uint dwControlCode, void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, 
                                      uint nOutBufferSize, uint* lpBytesReturned);

///Initiates an operation that affects a group. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hGroup = Handle to the group to be affected.
///    hHostNode = If non-<b>NULL</b>, handle to the node to perform the operation represented by the control code. If <b>NULL</b>,
///                the node that owns the group performs the operation. Specifying <i>hHostNode</i> is optional.
///    dwControlCode = A group control code specifying the operation to be performed. For the syntax associated with a control code,
///                    refer to Control Code Architecture and the following topics: <ul> <li> CLUSCTL_GROUP_ENUM_COMMON_PROPERTIES </li>
///                    <li> CLUSCTL_GROUP_ENUM_PRIVATE_PROPERTIES </li> <li> CLUSCTL_GROUP_GET_CHARACTERISTICS </li> <li>
///                    CLUSCTL_GROUP_GET_COMMON_PROPERTIES </li> <li> CLUSCTL_GROUP_GET_COMMON_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_GROUP_GET_FLAGS </li> <li> CLUSCTL_GROUP_GET_ID </li> <li> CLUSCTL_GROUP_GET_NAME </li> <li>
///                    CLUSCTL_GROUP_GET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_GROUP_GET_PRIVATE_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_GROUP_GET_RO_COMMON_PROPERTIES </li> <li> CLUSCTL_GROUP_GET_RO_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_GROUP_QUERY_DELETE </li> <li> CLUSCTL_GROUP_SET_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_GROUP_SET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_GROUP_UNKNOWN </li> <li>
///                    CLUSCTL_GROUP_VALIDATE_COMMON_PROPERTIES </li> <li> CLUSCTL_GROUP_VALIDATE_PRIVATE_PROPERTIES </li> </ul>
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    nInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    nOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpBytesReturned</i>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation was
///    successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b> on input)
///    points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer pointed to by <i>lpOutBuffer</i>
///    was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i> parameter (if not
///    <b>NULL</b> on input) points to the size required for the output buffer. Only operations requiring an output
///    buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and the
///    <i>nOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not <b>ERROR_MORE_DATA</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. If the operation required an output buffer, the value specified by
///    <i>lpBytesReturned</i> (if not <b>NULL</b> on input) is unreliable. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterGroupControl(_HGROUP* hGroup, _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, 
                         uint nInBufferSize, void* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

///Initiates an operation that affects a node. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hNode = Handle to the node to be affected.
///    hHostNode = If non-<b>NULL</b>, handle to the node that will perform the operation instead of the node specified in
///                <i>hNode</i>. If <b>NULL</b>, the node that handles the call performs the operation.
///    dwControlCode = A node control code specifying the operation to be performed. For the syntax associated with a control code,
///                    refer to Control Code Architecture and the following topics: <ul> <li> CLUSCTL_NODE_ENUM_COMMON_PROPERTIES </li>
///                    <li> CLUSCTL_NODE_ENUM_PRIVATE_PROPERTIES </li> <li> CLUSCTL_NODE_GET_CHARACTERISTICS </li> <li>
///                    CLUSCTL_NODE_GET_COMMON_PROPERTIES </li> <li> CLUSCTL_NODE_GET_COMMON_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_NODE_GET_FLAGS </li> <li> CLUSCTL_NODE_GET_ID </li> <li> CLUSCTL_NODE_GET_NAME </li> <li>
///                    CLUSCTL_NODE_GET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_NODE_GET_PRIVATE_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_NODE_GET_RO_COMMON_PROPERTIES </li> <li> CLUSCTL_NODE_GET_RO_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_NODE_SET_COMMON_PROPERTIES </li> <li> CLUSCTL_NODE_SET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_NODE_UNKNOWN
///                    </li> <li> CLUSCTL_NODE_VALIDATE_COMMON_PROPERTIES </li> <li> CLUSCTL_NODE_VALIDATE_PRIVATE_PROPERTIES </li>
///                    </ul>
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    nInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    nOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpBytesReturned</i>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation was
///    successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b> on input)
///    points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer pointed to by <i>lpOutBuffer</i>
///    was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i> parameter (if not
///    <b>NULL</b> on input) points to the size required for the output buffer. Only operations requiring an output
///    buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and the
///    <i>nOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not <b>ERROR_MORE_DATA</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. If the operation required an output buffer, the value specified by
///    <i>lpBytesReturned</i> (if not <b>NULL</b> on input) is unreliable. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterNodeControl(_HNODE* hNode, _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, uint nInBufferSize, 
                        void* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

///Retrieves the Name private property of the Network Name resource on which a resource is dependent. The
///<b>PCLUSAPI_GET_CLUSTER_RESOURCE_NETWORK_NAME</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to the dependent resource.
///    lpBuffer = Buffer containing a null-terminated Unicode string that contains the Name private property of the Network Name
///               resource on which the resource depends.
///    nSize = On input, pointer to a count of characters in the buffer pointed to by <i>lpBuffer</i>. On output, pointer to a
///            count of characters in the network name of the Network Name resource contained in the buffer pointed to by
///            <i>lpBuffer</i>, excluding the null-terminating character.
///Returns:
///    If the operation succeeds, the function returns <b>TRUE</b>. If the operation fails, the function returns
///    <b>FALSE</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
BOOL GetClusterResourceNetworkName(_HRESOURCE* hResource, PWSTR lpBuffer, uint* nSize);

///Opens an enumerator for iterating through a resource's dependencies and nodes. The
///<b>PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM</b> type defines a pointer to this function.
///Params:
///    hResource = A handle to a resource.
///    dwType = A bitmask that describes the type of cluster objects to be enumerated. The following values of the
///             CLUSTER_RESOURCE_ENUM enumeration are valid.
///Returns:
///    If the operation succeeds, the function returns an enumeration handle. If the operation fails, the function
///    returns <b>NULL</b>. For more information about the error, call the GetLastError function.
///    
@DllImport("CLUSAPI")
_HRESENUM* ClusterResourceOpenEnum(_HRESOURCE* hResource, uint dwType);

///Returns the number of cluster objects associated with a resource enumeration handle. The
///<b>PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT</b> type defines a pointer to this function.
///Params:
///    hResEnum = Handle to a resource enumeration. This handle is obtained from ClusterResourceOpenEnum. A valid handle is
///               required. This parameter cannot be <b>NULL</b>.
@DllImport("CLUSAPI")
uint ClusterResourceGetEnumCount(_HRESENUM* hResEnum);

///Enumerates a resource's dependent resources, nodes, or both. It returns the name of one cluster object with each
///call. The <b>PCLUSAPI_CLUSTER_RESOURCE_ENUM</b> type defines a pointer to this function.
///Params:
///    hResEnum = A resource enumeration handle returned from the ClusterResourceOpenEnum function.
///    dwIndex = The index of the resource or node object to return. This parameter should be zero for the first call to the
///              <b>ClusterResourceEnum</b> function and then incremented for subsequent calls.
///    lpdwType = The type of object returned by <b>ClusterResourceEnum</b>. The possible values are one of the following
///               CLUSTER_RESOURCE_ENUM enumeration values:
///    lpszName = A pointer to a null-terminated Unicode string containing the name of the returned object.
///    lpcchName = A pointer to the size of the <i>lpszName</i> buffer as a count of characters. On input, specify the maximum
///                number of characters the buffer can hold, including the terminating null character. On output, specifies the
///                number of characters in the resulting name, excluding the terminating null character.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation completed successfully or the <i>lpszName</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The buffer
///    pointed to by the <i>lpszName</i> parameter is not big enough to hold the result. The <i>lpcchName</i> parameter
///    returns the number of characters in the result, excluding the terminating null character. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259 (0x103)</dt> </dl> </td> <td width="60%"> There are
///    no more objects to be returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl>
///    </td> <td width="60%"> Any other returned error code indicates that the operation failed. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterResourceEnum(_HRESENUM* hResEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

///Closes a resource enumeration handle. The <b>PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM</b> type defines a pointer to this
///function.
///Params:
///    hResEnum = A resource enumeration handle to be closed.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a different system error code.
///    
@DllImport("CLUSAPI")
uint ClusterResourceCloseEnum(_HRESENUM* hResEnum);

///Creates a resource type in a cluster. The <b>PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE</b> type defines a pointer to this
///function.
///Params:
///    hCluster = Handle to the cluster to receive the new resource type.
///    lpszResourceTypeName = Pointer to a null-terminated Unicode string containing the name of the new resource type. The specified name must
///                           be unique within the cluster.
///    lpszDisplayName = Pointer to the display name for the new resource type. While the content of <i>lpszResourceTypeName</i> should
///                      uniquely identify the resource type on all clusters, the content of <i>lpszDisplayName</i> should be a localized
///                      friendly name for the resource suitable for displaying to administrators.
///    lpszResourceTypeDll = Pointer to the fully qualified name of the resource DLL for the new resource type or the path name relative to
///                          the Cluster directory.
///    dwLooksAlivePollInterval = Default millisecond value to be used as the poll interval needed by the new resource type's LooksAlive function.
///                               The <i>dwLooksAlivePollInterval</i> parameter is used to set the resource type's LooksAlivePollInterval property.
///    dwIsAlivePollInterval = Default millisecond value to be used as the poll interval needed by the new resource type's IsAlive function. The
///                            <i>dwIsAlivePollInterval</i> parameter is used to set the resource type's IsAlivePollInterval property.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint CreateClusterResourceType(_HCLUSTER* hCluster, const(PWSTR) lpszResourceTypeName, 
                               const(PWSTR) lpszDisplayName, const(PWSTR) lpszResourceTypeDll, 
                               uint dwLooksAlivePollInterval, uint dwIsAlivePollInterval);

///Removes a resource type from a cluster. The <b>PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE</b> type defines a pointer to
///this function.
///Params:
///    hCluster = Handle to the cluster containing the resource type to be removed.
///    lpszResourceTypeName = Pointer to a null-terminated Unicode string containing the name of the resource type to be removed.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint DeleteClusterResourceType(_HCLUSTER* hCluster, const(PWSTR) lpszResourceTypeName);

///Opens an enumerator for iterating through a resource type's possible owner nodes or resources. The
///<b>PCLUSAPI_CLUSTER_RESOURCE_TYPE_OPEN_ENUM</b> type defines a pointer to this function.
///Params:
///    hCluster = Cluster handle.
///    lpszResourceTypeName = A null-terminated Unicode string containing the name of the resource type.
///    dwType = Bitmask describing the type of cluster objects to be enumerated. The following values of the
///             CLUSTER_RESOURCE_TYPE_ENUM enumeration are valid.
///Returns:
///    If the operation succeeds, the function returns an enumeration handle which can be used in subsequent calls to
///    ClusterResourceTypeEnum. If the operation fails, the function returns <b>NULL</b>. For more information about the
///    error, call the function GetLastError.
///    
@DllImport("CLUSAPI")
_HRESTYPEENUM* ClusterResourceTypeOpenEnum(_HCLUSTER* hCluster, const(PWSTR) lpszResourceTypeName, uint dwType);

///Returns the number of cluster objects associated with a resource_type enumeration handle. The
///<b>PCLUSAPI_CLUSTER_RESOURCE_TYPE_GET_ENUM_COUNT</b> type defines a pointer to this function.
///Params:
///    hResTypeEnum = Handle to a resource type enumeration. This handle is obtained from ClusterResourceTypeOpenEnum. A valid handle
///                   is required. This parameter cannot be <b>NULL</b>.
@DllImport("CLUSAPI")
uint ClusterResourceTypeGetEnumCount(_HRESTYPEENUM* hResTypeEnum);

///Enumerates a resource type's possible owner nodes or resources, returning the name of one node or resource per call.
///The <b>PCLUSAPI_CLUSTER_RESOURCE_TYPE_ENUM</b> type defines a pointer to this function.
///Params:
///    hResTypeEnum = Resource type enumeration handle returned from ClusterResourceTypeOpenEnum.
///    dwIndex = Index of the resource or node object to return. This parameter should be zero for the first call to
///              <b>ClusterResourceTypeEnum</b> and then incremented for subsequent calls.
///    lpdwType = Type of object returned by <b>ClusterResourceTypeEnum</b>. The following values of the CLUSTER_RESOURCE_TYPE_ENUM
///               enumeration are valid.
///    lpszName = Pointer to a null-terminated Unicode string containing the name of the returned object.
///    lpcchName = Pointer to the size of the <i>lpszName</i> buffer as a count of characters. On input, specify the maximum number
///                of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number of
///                characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259</dt>
///    </dl> </td> <td width="60%"> There are no more objects to be returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234</dt> </dl> </td> <td width="60%"> The buffer pointed to by
///    <i>lpszName</i> is not big enough to hold the result. The <i>lpcchName</i> parameter returns the number of
///    characters in the result, excluding the terminating <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The operation failed. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterResourceTypeEnum(_HRESTYPEENUM* hResTypeEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, 
                             uint* lpcchName);

///Closes a resource type enumeration handle. The <b>PCLUSAPI_CLUSTER_RESOURCE_TYPE_CLOSE_ENUM</b> type defines a
///pointer to this function.
///Params:
///    hResTypeEnum = Enumeration handle to be closed.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterResourceTypeCloseEnum(_HRESTYPEENUM* hResTypeEnum);

///Opens a connection to a network and returns a handle to it. The <b>PCLUSAPI_OPEN_CLUSTER_NETWORK</b> type defines a
///pointer to this function.
///Params:
///    hCluster = Handle to a cluster.
///    lpszNetworkName = Pointer to the name of an existing network.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt>
///    </dl> </td> <td width="60%"> The operation was not successful. For more information about the error, call the
///    function GetLastError. </td> </tr> </table> If the operation was successful, <b>OpenClusterNetwork</b> returns a
///    network handle.
///    
@DllImport("CLUSAPI")
_HNETWORK* OpenClusterNetwork(_HCLUSTER* hCluster, const(PWSTR) lpszNetworkName);

///Opens a connection to a network and returns a handle to it.
///Params:
///    hCluster = Handle to a cluster.
///    lpszNetworkName = Pointer to the name of an existing network.
///    dwDesiredAccess = The requested access privileges. This may be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0) and undefined
///                      error may be returned. Using <b>GENERIC_ALL</b> is the same as calling OpenClusterNetwork.
///    lpdwGrantedAccess = Optional parameter that contains the address of a <b>DWORD</b> that will receive the access rights granted. If
///                        the <i>DesiredAccess</i> parameter is <b>MAXIMUM_ALLOWED</b> (0x02000000) then the <b>DWORD</b> pointed to by
///                        this parameter will contain the maximum privileges granted to this user.
///Returns:
///    If the operation was successful, <b>OpenClusterNetworkEx</b> returns a network handle. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULL</b></dt> </dl> </td> <td width="60%">
///    The operation was not successful. For more information about the error, call the GetLastError function. If the
///    target server does not support the OpenClusterNetworkEx function (for example if the target server is running
///    Windows Server 2008 or earlier) then the <b>GetLastError</b> function will return
///    <b>RPC_S_PROCNUM_OUT_OF_RANGE</b> (1745). </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HNETWORK* OpenClusterNetworkEx(_HCLUSTER* hCluster, const(PWSTR) lpszNetworkName, uint dwDesiredAccess, 
                                uint* lpdwGrantedAccess);

///Closes a network handle. The <b>PCLUSAPI_CLOSE_CLUSTER_NETWORK</b> type defines a pointer to this function.
///Params:
///    hNetwork = Handle to the network to close.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The operation was not successful; call the function
///    GetLastError for more information. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
BOOL CloseClusterNetwork(_HNETWORK* hNetwork);

///Returns a handle to the cluster associated with a network. The <b>PCLUSAPI_GET_CLUSTER_FROM_NETWORK</b> type defines
///a pointer to this function.
///Params:
///    hNetwork = Handle to the network.
///Returns:
///    If the operation succeeds, the function returns a handle to the cluster that owns the network. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromNetwork(_HNETWORK* hNetwork);

///Opens an enumerator for iterating through objects on a network. The <b>PCLUSAPI_CLUSTER_NETWORK_OPEN_ENUM</b> type
///defines a pointer to this function.
///Params:
///    hNetwork = A handle to a network.
///    dwType = A bitmask that describes the type of objects to be enumerated. One or more of the following values
///             CLUSTER_NETWORK_ENUM enumeration are valid.
///Returns:
///    If the operation was successful, <b>ClusterNetworkOpenEnum</b> returns a handle to a network enumerator. If the
///    operation fails, the function returns <b>NULL</b>. For more information about the error, call the function
///    GetLastError.
///    
@DllImport("CLUSAPI")
_HNETWORKENUM* ClusterNetworkOpenEnum(_HNETWORK* hNetwork, uint dwType);

///Returns the number of cluster objects associated with a network enumeration handle. The
///<b>PCLUSAPI_CLUSTER_NETWORK_GET_ENUM_COUNT</b> type defines a pointer to this function.
///Params:
///    hNetworkEnum = Handle to a network enumeration. This handle is obtained from ClusterNetworkOpenEnum. A valid handle is required.
///                   This parameter cannot be <b>NULL</b>.
@DllImport("CLUSAPI")
uint ClusterNetworkGetEnumCount(_HNETWORKENUM* hNetworkEnum);

///Enumerates cluster objects on a network, returning the name of one object with each call. The
///<b>PCLUSAPI_CLUSTER_NETWORK_ENUM</b> type defines a pointer to this function.
///Params:
///    hNetworkEnum = A handle to an existing enumeration object originally returned by the ClusterNetworkOpenEnum function.
///    dwIndex = The index used to identify the next entry to be enumerated. This parameter should be zero for the first call to
///              <b>ClusterNetworkEnum</b> and then incremented for subsequent calls.
///    lpdwType = A pointer to the type of object returned. The following value of the CLUSTER_NETWORK_ENUM enumeration is returned
///               with each call.
///    lpszName = A pointer to a null-terminated Unicode string containing the name of the returned object.
///    lpcchName = A pointer to the size of the <i>lpszName</i> buffer as a count of characters. On input, specify the maximum
///                number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                of characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234
///    (0xEA)</dt> </dl> </td> <td width="60%"> More data is available. This value is returned if the buffer pointed to
///    by <i>lpszName</i> is not big enough to hold the result. The <i>lpcchName</i> parameter returns the number of
///    characters in the result, excluding the terminating <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259 (0x103)</dt> </dl> </td> <td width="60%"> No more data is available.
///    This value is returned if there are no more objects of the requested type to be returned. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterNetworkEnum(_HNETWORKENUM* hNetworkEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

///Closes a network enumeration handle. The <b>PCLUSAPI_CLUSTER_NETWORK_CLOSE_ENUM</b> type defines a pointer to this
///function.
///Params:
///    hNetworkEnum = Handle to the network enumerator to close. This is a handle originally returned by the ClusterNetworkOpenEnum
///                   function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterNetworkCloseEnum(_HNETWORKENUM* hNetworkEnum);

///Returns the current state of a network. The <b>PCLUSAPI_GET_CLUSTER_NETWORK_STATE</b> type defines a pointer to this
///function.
///Params:
///    hNetwork = Handle to the network for which state information should be returned.
///Returns:
///    <b>GetClusterNetworkState</b> returns the current state of the network, which is represented by one of the
///    following values enumerated by the CLUSTER_NETWORK_STATE enumeration. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterNetworkUnavailable</b></dt> <dt>0</dt> </dl>
///    </td> <td width="60%"> All of the network interfaces on the network are unavailable, which means that the nodes
///    that own the network interfaces are down. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterNetworkDown</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The network is not operational; none
///    of the nodes on the network can communicate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterNetworkPartitioned</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The network is operational, but
///    two or more nodes on the network cannot communicate. Typically a path-specific problem has occurred. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ClusterNetworkUp</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The network
///    is operational; all of the nodes in the cluster can communicate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterNetworkStateUnknown</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> The operation was not
///    successful. For more information about the error, call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
CLUSTER_NETWORK_STATE GetClusterNetworkState(_HNETWORK* hNetwork);

///Sets the name for a network. The <b>PCLUSAPI_SET_CLUSTER_NETWORK_NAME</b> type defines a pointer to this function.
///Params:
///    hNetwork = Handle to a network to name.
///    lpszName = Pointer to a null-terminated Unicode string containing the new network name.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint SetClusterNetworkName(_HNETWORK* hNetwork, const(PWSTR) lpszName);

///Returns the identifier of a network. The <b>PCLUSAPI_GET_CLUSTER_NETWORK_ID</b> type defines a pointer to this
///function.
///Params:
///    hNetwork = Handle to a network.
///    lpszNetworkId = Pointer to the identifier of the network associated with <i>hNetwork</i>, including the null-terminating
///                    character.
///    lpcchName = Pointer to the size of the <i>lpszNetworkID</i> buffer as a count of characters. On input, specify the maximum
///                number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                of characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is one of the possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The buffer pointed to by <i>lpszNetworkID</i> is not big enough to hold the result. The
///    <i>lpcchNetworkID</i> parameter returns the number of characters in the result, excluding the terminating
///    <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint GetClusterNetworkId(_HNETWORK* hNetwork, PWSTR lpszNetworkId, uint* lpcchName);

///Initiates an operation on a network. The operation performed depends on the control code passed to the
///<i>dwControlCode</i> parameter.
///Params:
///    hNetwork = Handle to the network to be affected by the operation.
///    hHostNode = If non-<b>NULL</b>, handle to the node hosting the affected network. If <b>NULL</b>, the local node performs the
///                operation. Specifying <i>hHostNode</i> is optional.
///    dwControlCode = A network control code specifying the operation to be performed. For the syntax associated with a control code,
///                    refer to Control Code Architecture and the following topics: <ul> <li> CLUSCTL_NETWORK_ENUM_COMMON_PROPERTIES
///                    </li> <li> CLUSCTL_NETWORK_ENUM_PRIVATE_PROPERTIES </li> <li> CLUSCTL_NETWORK_GET_CHARACTERISTICS </li> <li>
///                    CLUSCTL_NETWORK_GET_COMMON_PROPERTIES </li> <li> CLUSCTL_NETWORK_GET_COMMON_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_NETWORK_GET_FLAGS </li> <li> CLUSCTL_NETWORK_GET_ID </li> <li> CLUSCTL_NETWORK_GET_NAME </li> <li>
///                    CLUSCTL_NETWORK_GET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_NETWORK_GET_PRIVATE_PROPERTY_FMTS </li> <li>
///                    CLUSCTL_NETWORK_GET_RO_COMMON_PROPERTIES </li> <li> CLUSCTL_NETWORK_GET_RO_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_NETWORK_SET_COMMON_PROPERTIES </li> <li> CLUSCTL_NETWORK_SET_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_NETWORK_UNKNOWN </li> <li> CLUSCTL_NETWORK_VALIDATE_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_NETWORK_VALIDATE_PRIVATE_PROPERTIES </li> </ul>
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    nInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    nOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpBytesReturned</i>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation was
///    successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b> on input)
///    points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer pointed to by <i>lpOutBuffer</i>
///    was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i> parameter (if not
///    <b>NULL</b> on input) points to the size required for the output buffer. Only operations requiring an output
///    buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and the
///    <i>nOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not <b>ERROR_MORE_DATA</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. If the operation required an output buffer, the value specified by
///    <i>lpBytesReturned</i> (if not <b>NULL</b> on input) is unreliable. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterNetworkControl(_HNETWORK* hNetwork, _HNODE* hHostNode, uint dwControlCode, void* lpInBuffer, 
                           uint nInBufferSize, void* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

///Opens a handle to a network interface. The <b>PCLUSAPI_OPEN_CLUSTER_NET_INTERFACE</b> type defines a pointer to this
///function.
///Params:
///    hCluster = Handle to a cluster.
///    lpszInterfaceName = Pointer to a null-terminated Unicode string containing the name of the network interface to open.
///Returns:
///    If the operation was successful, <b>OpenClusterNetInterface</b> returns an open handle to the specified network
///    interface. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NULL</b></dt> </dl> </td> <td width="60%"> The operation was not successful. For more information about
///    the error, call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HNETINTERFACE* OpenClusterNetInterface(_HCLUSTER* hCluster, const(PWSTR) lpszInterfaceName);

///Opens a handle to a network interface.
///Params:
///    hCluster = Handle to a cluster.
///    lpszInterfaceName = Pointer to a null-terminated Unicode string containing the name of the network interface to open.
///    dwDesiredAccess = The requested access privileges. This may be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0) and undefined
///                      error may be returned. Using <b>GENERIC_ALL</b> is the same as calling OpenClusterNetInterface.
///    lpdwGrantedAccess = Optional parameter that contains the address of a <b>DWORD</b> that will receive the access rights granted. If
///                        the <i>DesiredAccess</i> parameter is <b>MAXIMUM_ALLOWED</b> (0x02000000) then the <b>DWORD</b> pointed to by
///                        this parameter will contain the maximum privileges granted to this user.
///Returns:
///    If the operation was successful, <b>OpenClusterNetInterfaceEx</b> returns an open handle to the specified network
///    interface. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NULL</b></dt> </dl> </td> <td width="60%"> The operation was not successful. For more information about
///    the error, call the GetLastError function. If the target server does not support the OpenClusterNetInterfaceEx
///    function (for example if the target server is running Windows Server 2008 or earlier) then the
///    <b>GetLastError</b> function will return <b>RPC_S_PROCNUM_OUT_OF_RANGE</b> (1745). </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HNETINTERFACE* OpenClusterNetInterfaceEx(_HCLUSTER* hCluster, const(PWSTR) lpszInterfaceName, 
                                          uint dwDesiredAccess, uint* lpdwGrantedAccess);

///Returns the name of a node's interface to a network in a cluster. The <b>PCLUSAPI_GET_CLUSTER_NET_INTERFACE</b> type
///defines a pointer to this function.
///Params:
///    hCluster = Handle to a cluster.
///    lpszNodeName = Pointer to a null-terminated Unicode string containing the name of the node in the cluster.
///    lpszNetworkName = Pointer to a null-terminated Unicode string containing the name of the network.
///    lpszInterfaceName = Pointer to an output buffer holding the name of the network interface.
///    lpcchInterfaceName = Pointer to the size of the <i>lpszInterfaceName</i> buffer as a count of characters. On input, specify the
///                         maximum number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the
///                         number of characters in the resulting name, excluding the terminating <b>NULL</b>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is one of the possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The buffer pointed to by <i>lpszInterfaceName</i> is not big enough to hold the result. The
///    <i>lpcchInterfaceName</i> parameter returns the number of characters in the result, excluding the terminating
///    <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint GetClusterNetInterface(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, const(PWSTR) lpszNetworkName, 
                            PWSTR lpszInterfaceName, uint* lpcchInterfaceName);

///Closes a network interface handle. The <b>PCLUSAPI_CLOSE_CLUSTER_NET_INTERFACE</b> type defines a pointer to this
///function.
///Params:
///    hNetInterface = Handle of the network interface to close.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The operation was not successful; call the function
///    GetLastError for more information. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
BOOL CloseClusterNetInterface(_HNETINTERFACE* hNetInterface);

///Returns a handle to the cluster associated with a network interface. The
///<b>PCLUSAPI_GET_CLUSTER_FROM_NET_INTERFACE</b> type defines a pointer to this function.
///Params:
///    hNetInterface = Handle to the network interface.
///Returns:
///    If the operation succeeds, the function returns a handle to the cluster that owns the network interface. If the
///    operation fails, the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromNetInterface(_HNETINTERFACE* hNetInterface);

///Returns the current state of a network interface. The <b>PCLUSAPI_GET_CLUSTER_NET_INTERFACE_STATE</b> type defines a
///pointer to this function.
///Params:
///    hNetInterface = Handle to the network interface for which state information should be returned.
///Returns:
///    <b>GetClusterNetInterfaceState</b> returns the current state of the network interface, which is represented by
///    one of the following values enumerated by the CLUSTER_NETINTERFACE_STATE enumeration. <table> <tr> <th>Return
///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterNetInterfaceFailed</b></dt>
///    <dt>1</dt> </dl> </td> <td width="60%"> The network interface cannot communicate with any other network
///    interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterNetInterfaceUnreachable</b></dt> <dt>2</dt> </dl>
///    </td> <td width="60%"> The network interface cannot communicate with at least one other network interface whose
///    state is not <b>ClusterNetInterfaceFailed</b> or <b>ClusterNetInterfaceUnavailable</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ClusterNetInterfaceUp</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The network
///    interface can communicate with all other network interfaces whose state is not <b>ClusterNetInterfaceFailed</b>
///    or <b>ClusterNetInterfaceUnavailable</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterNetInterfaceUnavailable</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The node that owns the
///    network interface is down. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterNetInterfaceStateUnknown</b></dt>
///    <dt>-1</dt> </dl> </td> <td width="60%"> The operation was not successful. For more information about the error,
///    call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
CLUSTER_NETINTERFACE_STATE GetClusterNetInterfaceState(_HNETINTERFACE* hNetInterface);

///Initiates an operation that affects a network interface. The operation performed depends on the control code passed
///to the <i>dwControlCode</i> parameter.
///Params:
///    hNetInterface = Handle to the network interface to be affected.
///    hHostNode = If non-<b>NULL</b>, handle to the node that owns the network interface to be affected. If <b>NULL</b>, the local
///                node performs the operation. Specifying <i>hHostNode</i> is optional.
///    dwControlCode = A network interface control code specifying the operation to be performed. For the syntax associated with a
///                    control code, refer to Control Code Architecture and the following topics: <ul> <li>
///                    CLUSCTL_NETINTERFACE_ENUM_COMMON_PROPERTIES </li> <li> CLUSCTL_NETINTERFACE_ENUM_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_NETINTERFACE_GET_CHARACTERISTICS </li> <li> CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTIES </li> <li>
///                    CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTY_FMTS </li> <li> CLUSCTL_NETINTERFACE_GET_FLAGS </li> <li>
///                    CLUSCTL_NETINTERFACE_GET_ID </li> <li> CLUSCTL_NETINTERFACE_GET_NAME </li> <li> CLUSCTL_NETINTERFACE_GET_NETWORK
///                    </li> <li> CLUSCTL_NETINTERFACE_GET_NODE </li> <li> CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTIES </li> <li>
///                    CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTY_FMTS </li> <li> CLUSCTL_NETINTERFACE_GET_RO_COMMON_PROPERTIES </li>
///                    <li> CLUSCTL_NETINTERFACE_GET_RO_PRIVATE_PROPERTIES </li> <li> CLUSCTL_NETINTERFACE_SET_COMMON_PROPERTIES </li>
///                    <li> CLUSCTL_NETINTERFACE_SET_PRIVATE_PROPERTIES </li> <li> CLUSCTL_NETINTERFACE_UNKNOWN </li> <li>
///                    CLUSCTL_NETINTERFACE_VALIDATE_COMMON_PROPERTIES </li> <li> CLUSCTL_NETINTERFACE_VALIDATE_PRIVATE_PROPERTIES </li>
///                    </ul>
///    lpInBuffer = Pointer to an input buffer containing information needed for the operation, or <b>NULL</b> if no information is
///                 needed.
///    nInBufferSize = The allocated size (in bytes) of the input buffer.
///    lpOutBuffer = Pointer to an output buffer to receive the data resulting from the operation, or <b>NULL</b> if no data will be
///                  returned.
///    nOutBufferSize = The allocated size (in bytes) of the output buffer.
///    lpBytesReturned = Returns the actual size (in bytes) of the data resulting from the operation. If this information is not needed,
///                      pass <b>NULL</b> for <i>lpBytesReturned</i>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation was
///    successful. If the operation required an output buffer, <i>lpBytesReturned</i> (if not <b>NULL</b> on input)
///    points to the actual size of the data returned in the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer pointed to by <i>lpOutBuffer</i>
///    was not large enough to hold the data resulting from the operation. The <i>lpBytesReturned</i> parameter (if not
///    <b>NULL</b> on input) points to the size required for the output buffer. Only operations requiring an output
///    buffer return <b>ERROR_MORE_DATA</b>. If the <i>lpOutBuffer</i> parameter is <b>NULL</b> and the
///    <i>nOutBufferSize</i> parameter is zero, then <b>ERROR_SUCCESS</b> may be returned, not <b>ERROR_MORE_DATA</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The
///    operation was not successful. If the operation required an output buffer, the value specified by
///    <i>lpBytesReturned</i> (if not <b>NULL</b> on input) is unreliable. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterNetInterfaceControl(_HNETINTERFACE* hNetInterface, _HNODE* hHostNode, uint dwControlCode, 
                                void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, uint nOutBufferSize, 
                                uint* lpBytesReturned);

///Opens the root of the cluster database subtree for a cluster.
///Params:
///    hCluster = Handle to a cluster.
///    samDesired = Access mask that describes the security access needed for the new key. For more information and possible values,
///                 see Registry Key Security and Access Rights.
///Returns:
///    If the operation succeeds, the function returns a database key handle for the cluster. If the operation fails,
///    the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
HKEY GetClusterKey(_HCLUSTER* hCluster, uint samDesired);

///Opens the root of the cluster database subtree for a group.
///Params:
///    hGroup = Handle to a group.
///    samDesired = Access mask that describes the security access needed for the key.
///Returns:
///    If the operation succeeds, the function returns a database key handle for the group. If the operation fails, the
///    function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
HKEY GetClusterGroupKey(_HGROUP* hGroup, uint samDesired);

///Opens the root of the cluster database subtree for a resource.
///Params:
///    hResource = Handle to a resource.
///    samDesired = Access mask that describes the security access needed for the opened key.
///Returns:
///    If the operation succeeds, the function returns a registry key handle for the resource. If the operation fails,
///    the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
HKEY GetClusterResourceKey(_HRESOURCE* hResource, uint samDesired);

///Opens the root of the cluster database subtree for a node.
///Params:
///    hNode = Handle to a node.
///    samDesired = Access mask that describes the security access needed for the key.
///Returns:
///    If the operation succeeds, the function returns a registry key handle for the node. If the operation fails, the
///    function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
HKEY GetClusterNodeKey(_HNODE* hNode, uint samDesired);

///Opens the root of the cluster database subtree for a network.
///Params:
///    hNetwork = Handle to a network.
///    samDesired = Access mask that describes the security access needed for the new key.
///Returns:
///    If the operation succeeds, the function returns a registry key handle for the network. If the operation fails,
///    the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
HKEY GetClusterNetworkKey(_HNETWORK* hNetwork, uint samDesired);

///Opens the root of the cluster database subtree for a network interface object.
///Params:
///    hNetInterface = Handle to a network interface.
///    samDesired = Access mask that describes the security access needed for the key.
///Returns:
///    If the operation succeeds, the function returns a registry key handle for the network interface. If the operation
///    fails, the function returns <b>NULL</b>. For more information about the error, call GetLastError.
///    
@DllImport("CLUSAPI")
HKEY GetClusterNetInterfaceKey(_HNETINTERFACE* hNetInterface, uint samDesired);

///Creates a specified cluster database key. If the key already exists in the database, <b>ClusterRegCreateKey</b> opens
///it without making changes.
///Params:
///    hKey = Handle to an open cluster database key. This parameter cannot be <b>NULL</b>.
///    lpszSubKey = Pointer to a null-terminated Unicode string specifying the name of the subkey to be created or opened. The
///                 <i>lpszSubKey</i> parameter must point to a subkey that: <ul> <li>Is a child key of the key identified by
///                 <i>hKey</i>.</li> <li>Must not begin with the backslash character ( \ ).</li> <li>Must not be <b>NULL</b>.</li>
///                 </ul> The <i>lpszSubKey</i> parameter can point to an empty string, causing <b>ClusterRegCreateKey</b> to return
///                 a handle to the database key represented by <i>hKey</i>.
///    dwOptions = Specifies special options for this key. Currently, <i>dwOptions</i> can be set to the following value.
///    samDesired = Access mask that specifies the needed security access for the new key. The following values are valid. For more
///                 information, see Registry Key Security and Access Rights.
///    lpSecurityAttributes = This parameter is ignored. To set the security attributes on a new registry key, call the
///                           ClusterRegSetKeySecurity function after <b>ClusterRegCreateKey</b> has returned successfully.
///    phkResult = Pointer to the handle of the opened or created key.
///    lpdwDisposition = Pointer to a value that describes whether the key pointed to by <i>lpszSubKey</i> was opened or created. The
///                      following values are valid.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegCreateKey(HKEY hKey, const(PWSTR) lpszSubKey, uint dwOptions, uint samDesired, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);

///Opens an existing cluster database key.
///Params:
///    hKey = Handle to a currently open key. This parameter cannot be <b>NULL</b>.
///    lpszSubKey = Pointer to a null-terminated Unicode string specifying the name of the subkey to be created or opened. The
///                 <i>lpszSubKey</i> parameter must point to a subkey that: <ul> <li>Is a child key of the key identified by
///                 <i>hKey</i>.</li> <li>Must not begin with the backslash character ( \ ).</li> <li>Must not be <b>NULL</b>.</li>
///                 </ul> The <i>lpszSubKey</i> parameter can point to an empty string, causing ClusterRegCreateKey to return a
///                 handle to the database key represented by <i>hKey</i>.
///    samDesired = Access mask that specifies the security access needed for the new key.
///    phkResult = Pointer to a handle to the opened or created key.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegOpenKey(HKEY hKey, const(PWSTR) lpszSubKey, uint samDesired, HKEY* phkResult);

///Deletes a cluster database key.
///Params:
///    hKey = Handle to a currently open key.
///    lpszSubKey = Pointer to a null-terminated Unicode string specifying the name of the key to delete. The key pointed to by
///                 <i>lpszSubKey</i> cannot have subkeys; <b>ClusterRegDeleteKey</b> can only delete keys without subkeys. This
///                 parameter cannot be <b>NULL</b>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegDeleteKey(HKEY hKey, const(PWSTR) lpszSubKey);

///Releases the handle of a cluster database key.
///Params:
///    hKey = Handle to the cluster database key to be closed.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegCloseKey(HKEY hKey);

///Enumerates the subkeys of an open cluster database key.
///Params:
///    hKey = <b>HKEY</b> specifying a currently open key.
///    dwIndex = Index used to identify the next subkey to be enumerated. This parameter should be zero for the first call to
///              <b>ClusterRegEnumKey</b> and then incremented for subsequent calls. Because subkeys are not ordered, any new
///              subkey has an arbitrary index. This means that <b>ClusterRegEnumKey</b> may return subkeys in any order.
///    lpszName = Pointer to a buffer that receives the name of the subkey, including the null-terminating character. The function
///               copies only the name of the subkey, not the full key hierarchy, to the buffer.
///    lpcchName = Pointer to the size of the <i>lpszName</i> buffer as a count of characters. On input, specify the maximum number
///                of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number of
///                characters in the resulting name, excluding the terminating <b>NULL</b>.
///    lpftLastWriteTime = Pointer to the last time the enumerated subkey was modified.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259
///    (0x103)</dt> </dl> </td> <td width="60%"> There are no more subkeys to be returned. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The buffer
///    pointed to by <i>lpszName</i> is not big enough to hold the result. The <i>lpcchName</i> parameter returns the
///    number of characters in the result, excluding the terminating <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The operation failed. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegEnumKey(HKEY hKey, uint dwIndex, PWSTR lpszName, uint* lpcchName, FILETIME* lpftLastWriteTime);

///Sets a value for a cluster database key.
///Params:
///    hKey = Handle to a cluster database key.
///    lpszValueName = Pointer to a null-terminated Unicode string containing the name of the value to set. If a value with this name is
///                    not already present in the resource, <b>ClusterRegSetValue</b> adds it to the resource.
///    dwType = Type of information to be stored as the value's data. This parameter can be one of the following values. For more
///             information see Registry Value Types.
///    lpData = Pointer to the data to be stored with the name pointed to by <i>lpszValueName</i>.
///    cbData = Count of bytes in the data pointed to by the <i>lpbData</i> parameter. If the data is of type <b>REG_SZ</b>,
///             <b>REG_EXPAND_SZ</b> or <b>REG_MULTI_SZ</b>, <i>cbData</i> must include the size of the null-terminating
///             character.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterRegSetValue(HKEY hKey, const(PWSTR) lpszValueName, uint dwType, const(ubyte)* lpData, uint cbData);

///Removes a named value from a cluster database key.
///Params:
///    hKey = Handle to a currently open key.
///    lpszValueName = Pointer to a null-terminated Unicode string containing the name of the value to be removed.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterRegDeleteValue(HKEY hKey, const(PWSTR) lpszValueName);

///Returns the name, type, and data components associated with a value for an open cluster database key.
///Params:
///    hKey = Handle of the cluster database key to query.
///    lpszValueName = Pointer to a null-terminated Unicode string containing the name of the value to be queried.
///    lpdwValueType = Pointer to the key's value type. This parameter can be <b>NULL</b> if the type is not required; otherwise, the
///                    value returned through this parameter is one of the following.
///    lpData = Pointer to the value's data. This parameter can be <b>NULL</b> if the data is not required.
///    lpcbData = On input, pointer to the count of bytes in the buffer pointed to by the <i>lpbData</i> parameter. On output,
///               pointer to the count of bytes in the value's data, which is placed in the content of <i>lpbData</i> if the caller
///               passes in a valid pointer. The <i>lpbData</i> parameter can be <b>NULL</b> only if <i>lpbData</i> is also
///               <b>NULL</b>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The
///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234
///    (0xEA)</dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpbData</i> is not large enough to hold the
///    data for the value. ClusterRegQueryValue stores the required size in the content of <i>lpbData</i>. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
int ClusterRegQueryValue(HKEY hKey, const(PWSTR) lpszValueName, uint* lpdwValueType, ubyte* lpData, uint* lpcbData);

///Enumerates the values of an open cluster database key.
///Params:
///    hKey = Handle of the cluster database key to enumerate.
///    dwIndex = Index used to identify the next value to be enumerated. This parameter should be zero for the first call to
///              <b>ClusterRegEnumValue</b> and then incremented for subsequent calls. Because values are not ordered, any new
///              value has an arbitrary index. This means that <b>ClusterRegEnumValue</b> may return values in any order.
///    lpszValueName = Pointer to a null-terminated Unicode string containing the name of the returned value.
///    lpcchValueName = Pointer to the size of the <i>lpszValueName</i> buffer as a count of characters. On input, specify the maximum
///                     number of characters the buffer can hold, including the terminating <b>NULL</b>. On output, specifies the number
///                     of characters in the resulting name, excluding the terminating <b>NULL</b>.
///    lpdwType = Pointer to the type code for the value entry, or <b>NULL</b> if the type code is not required. The type code can
///               be one of the following values.
///    lpData = Pointer to the data for the value entry. This parameter can be <b>NULL</b> if the data is not required.
///    lpcbData = On input, pointer to a count of bytes in the buffer pointed to by the <i>lpbData</i> parameter. On output,
///               pointer to a count of bytes resulting from the operation. This parameter can be <b>NULL</b> only if
///               <i>lpbData</i> is <b>NULL</b>.
///Returns:
///    The function returns one of the following values. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The
///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259
///    (0x103)</dt> </dl> </td> <td width="60%"> There are no more values to be returned. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> One of the
///    output buffers (<i>lpszValueName</i> or <i>lpbData</i>) is too small to hold the resulting data. The
///    <i>lpcchValueName</i> and the <i>lpbData</i> parameters indicate the required size (note that
///    <i>lpcchValueName</i> does not include the terminating <b>NULL</b> in the character count). </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>System error code</b></dt> </dl> </td> <td width="60%"> The operation failed. </td>
///    </tr> </table>
///    
@DllImport("CLUSAPI")
uint ClusterRegEnumValue(HKEY hKey, uint dwIndex, PWSTR lpszValueName, uint* lpcchValueName, uint* lpdwType, 
                         ubyte* lpData, uint* lpcbData);

///Returns information about a cluster database key.
///Params:
///    hKey = Handle to a cluster database key. All subsequent parameters describe the contents of the key.
///    lpcSubKeys = If not <b>NULL</b>, pointer to the number of subkeys in the specified key.
///    lpcchMaxSubKeyLen = If not <b>NULL</b>, pointer to the number of characters in the longest subkey name in the specified key. The
///                        number does not include the terminating <b>NULL</b>.
///    lpcValues = If not <b>NULL</b>, pointer to the number of values in the specified key.
///    lpcchMaxValueNameLen = If not <b>NULL</b>, pointer to the number of characters in the longest value name in the specified key. The
///                           number does not include the terminating <b>NULL</b>.
///    lpcbMaxValueLen = If not <b>NULL</b>, pointer to the byte size of the largest data value in the specified key.
///    lpcbSecurityDescriptor = If not <b>NULL</b>, pointer to the byte size of the specified key's security descriptor.
///    lpftLastWriteTime = If not <b>NULL</b>, pointer to the time of the most recent modification to the specified key or any of its
///                        contents.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegQueryInfoKey(HKEY hKey, uint* lpcSubKeys, uint* lpcchMaxSubKeyLen, uint* lpcValues, 
                           uint* lpcchMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                           FILETIME* lpftLastWriteTime);

///Returns a copy of the security descriptor protecting the specified cluster database key.
///Params:
///    hKey = Handle to a cluster database key.
///    RequestedInformation = A SECURITY_INFORMATION structure that indicates the requested security descriptor.
///    pSecurityDescriptor = Pointer to a SECURITY_DESCRIPTOR structure containing a copy of the requested security descriptor.
///    lpcbSecurityDescriptor = On input, pointer to a count of the number of bytes in the buffer pointed to by <i>pSecurityDescriptor</i>. On
///                             output, pointer to a count of the number of bytes written to the buffer.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegGetKeySecurity(HKEY hKey, uint RequestedInformation, void* pSecurityDescriptor, 
                             uint* lpcbSecurityDescriptor);

///Sets the security attributes for a cluster database key.
///Params:
///    hKey = Handle to a cluster database key.
///    SecurityInformation = A SECURITY_INFORMATION structure that indicates the content of the security descriptor pointed to by
///                          <i>pSecurityDescriptor</i>.
///    pSecurityDescriptor = Pointer to a SECURITY_DESCRIPTOR structure that describes the security attributes to set for the key
///                          corresponding to <i>hKey</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegSetKeySecurity(HKEY hKey, uint SecurityInformation, void* pSecurityDescriptor);

///Synchronizes the Cluster Database with a cluster.
///Params:
///    hCluster = A handle to the cluster to synchronize with the cluster database.
///    flags = This parameter is reserved for future use.
///Returns:
///    If the operation succeeds, returns <b>ERROR_SUCCESS</b> (0); otherwise, returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegSyncDatabase(_HCLUSTER* hCluster, uint flags);

///Creates a batch that will execute commands on a cluster registry key. These commands will be added to the batch by
///the ClusterRegBatchAddCommand function and either executed or ignored by the ClusterRegCloseBatch function.
///Params:
///    hKey = The handle of the opened cluster registry key. All the operations on the batch are relative to this cluster
///           registry key.
///    pHREGBATCH = The pointer to the handle of the created batch.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14 (0xE)</dt> </dl> </td> <td width="60%"> Not enough storage is available
///    to complete this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> <dt>31
///    (0x1F)</dt> </dl> </td> <td width="60%"> A device attached to the system is not functioning. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> <dt>87 (0x57)</dt> </dl> </td> <td width="60%"> The
///    parameter is incorrect. This value will be returned if the <i>hKey</i> parameter is <b>NULL</b>. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCreateBatch(HKEY hKey, _HREGBATCH** pHREGBATCH);

///Adds a command to a batch that will be executed on a cluster registry key. Additional calls to the function will
///yield additional commands added to the batch. The batch was created by the ClusterRegCreateBatch function and will be
///either executed or ignored by the ClusterRegCloseBatch function.
///Params:
///    hRegBatch = The handle of the batch to which a command will be added.
///    dwCommand = A command supported by this API that is taken from the CLUSTER_REG_COMMAND enumeration. The possible commands are
///                as follows.
///    wzName = The name of the value or key relative to the command issued by the <i>dwCommand</i> parameter.
///    dwOptions = If <i>dwCommand</i> takes the <b>CLUSREG_SET_VALUE</b> command, then this parameter takes one of the standard
///                registry value types. If not, then <i>dwCommand</i> is set to 0.
///    lpData = A pointer to the data relative to the command issued by <i>dwCommand</i>. The value of this parameter is
///             <b>NULL</b> for all but the <b>CLUSREG_SET_VALUE</b> command.
///    cbData = The count, in bytes, of the data relative to the command issued by <i>dwCommand</i>. The value of this parameter
///             is 0 for all but the <b>CLUSREG_SET_VALUE</b> command.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FUNCTION</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Incorrect function. This value is
///    returned if <i>dwCommand</i> takes any command other than the commands described in the previous section. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The
///    handle is not valid. This value is returned if the <i>hRegBatch</i> parameter is <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14 (0xE)</dt> </dl> </td> <td width="60%"> Not enough
///    storage is available to complete this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_GEN_FAILURE</b></dt> <dt>31 (0x1F)</dt> </dl> </td> <td width="60%"> A device attached to the system
///    is not functioning. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> <dt>87
///    (0x57)</dt> </dl> </td> <td width="60%"> The parameter is incorrect. This value will be returned if the cluster
///    registry key that the batch is attempting to execute commands on is not the current key. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegBatchAddCommand(_HREGBATCH* hRegBatch, CLUSTER_REG_COMMAND dwCommand, const(PWSTR) wzName, 
                              uint dwOptions, const(void)* lpData, uint cbData);

///Executes or ignores the batch created by the ClusterRegCreateBatch function.
///Params:
///    hRegBatch = The handle of the cluster registry key opened by ClusterRegCreateBatch. After the completion of
///                <b>ClusterRegCloseBatch</b>, this handle is no longer valid and memory associated with it is freed.
///    bCommit = If the value this parameter takes is true, then a batch is sent for execution to a cluster server.
///    failedCommandNumber = If execution of the batch is not successful, the number of the command that failed is returned in the form of a
///                          <i>failedCommandNumber</i> argument. The first command in the batch has number 0, the second has number 1, and so
///                          on.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The handle is not valid. This value
///    is returned if the <i>hRegBatch</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCloseBatch(_HREGBATCH* hRegBatch, BOOL bCommit, int* failedCommandNumber);

///Executes or ignores the batch created by the ClusterRegCreateBatch function.
///Params:
///    hRegBatch = The handle of the cluster registry key opened by ClusterRegCreateBatch. After the completion of
///                ClusterRegCloseBatch, this handle is no longer valid and memory associated with it is freed.
///    flags = 
///    failedCommandNumber = If execution of the batch is not successful, the number of the command that failed is returned in the form of a
///                          <i>failedCommandNumber</i> argument. The first command in the batch has number 0, the second has number 1, and so
///                          on.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The handle is not valid. This value
///    is returned if the <i>hRegBatch</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCloseBatchEx(_HREGBATCH* hRegBatch, uint flags, int* failedCommandNumber);

///Reads a command from a batch notification.
///Params:
///    hBatchNotification = A handle to the batch notification.
///    pBatchCommand = Pointer to a CLUSTER_BATCH_COMMAND structure that will be filled with information about the command on successful
///                    return.
///Returns:
///    The function returns one of the following system error codes.
///    
@DllImport("CLUSAPI")
int ClusterRegBatchReadCommand(_HREGBATCHNOTIFICATION* hBatchNotification, CLUSTER_BATCH_COMMAND* pBatchCommand);

///Frees the memory associated with the batch notification.
///Params:
///    hBatchNotification = A handle to the batch notification.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. This error returns if the command is properly filled. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The handle is
///    not valid. This error is returned if the <i>hBatchNotification</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegBatchCloseNotification(_HREGBATCHNOTIFICATION* hBatchNotification);

///Creates a subscription to a batch notification port. The batch notification port needs to be closed after it is no
///longer needed. This is done via the ClusterRegCloseBatchNotifyPort function.
///Params:
///    hKey = A cluster registry key. Any updates performed at this key or keys below it will be posted to a notification port.
///    phBatchNotifyPort = A handle to a batch notification port that allows subsequent reading batch notifications via the
///                        ClusterRegGetBatchNotification function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
int ClusterRegCreateBatchNotifyPort(HKEY hKey, _HREGBATCHPORT** phBatchNotifyPort);

///Closes a subscription to a batch notification port created by the ClusterRegCreateBatchNotifyPort function.
///Params:
///    hBatchNotifyPort = A handle to the batch notification port created earlier via the ClusterRegCreateBatchNotifyPort function.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCloseBatchNotifyPort(_HREGBATCHPORT* hBatchNotifyPort);

///Fetches the batch notification. After the batch notification has been fetched, it is interpreted via the
///ClusterRegBatchReadCommand function. After the batch notification is processed, it needs to be closed via the
///ClusterRegBatchCloseNotification function.
///Params:
///    hBatchNotify = The handle to the batch notification port opened earlier via the ClusterRegCreateBatchNotifyPort function.
///    phBatchNotification = A handle to the batch notification that represents all of the changes at or below the cluster registry key of
///                          interest that have happened since the last call to <b>ClusterRegGetBatchNotification</b> or since the batch
///                          notification port was opened.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> <dt>13 (0xD)</dt> </dl> </td> <td width="60%"> The data is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14 (0xE)</dt> </dl> </td> <td width="60%">
///    Not enough storage is available to complete this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_GEN_FAILURE</b></dt> <dt>31 (0x1F)</dt> </dl> </td> <td width="60%"> A device attached to the system
///    is not functioning. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegGetBatchNotification(_HREGBATCHPORT* hBatchNotify, _HREGBATCHNOTIFICATION** phBatchNotification);

///Creates a handle to the read batch that executes read commands on the cluster registry key.
///Params:
///    hKey = The handle to the opened cluster registry key. All of the operations on the batch are relative to this cluster
///           registry key.
///    phRegReadBatch = A pointer to the handle of the created read batch.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> Not enough storage is available to
///    complete this operation. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCreateReadBatch(HKEY hKey, _HREGREADBATCH** phRegReadBatch);

///Adds a read command to a batch that executes on a cluster registry key.
///Params:
///    hRegReadBatch = The handle of the read batch to which a command will be added. Create a batch by calling the
///                    ClusterRegCreateReadBatch function.
///    wzSubkeyName = The name of the key relative to the cluster registry key. If this name is <b>NULL</b>, the read is performed on
///                   the cluster registry key represented in the <i>hRegReadBatch</i> parameter.
///    wzValueName = The name of the registry value to be read. If this name is <b>NULL</b>, the content of the default value is
///                  returned.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> Not enough storage is available to
///    complete this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt>
///    </dl> </td> <td width="60%"> <i>hRegReadBatch</i> is <b>NULL</b> or not valid. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegReadBatchAddCommand(_HREGREADBATCH* hRegReadBatch, const(PWSTR) wzSubkeyName, 
                                  const(PWSTR) wzValueName);

///Executes a read batch and returns results from the read batch executions.
///Params:
///    hRegReadBatch = The handle of the read batch. After the <b>ClusterRegCloseReadBatch</b> function completes, this handle is no
///                    longer valid, and memory associated with it is freed.
///    phRegReadBatchReply = A pointer to the handle of the created read batch result. You must close this handle later by calling the
///                          ClusterRegCloseReadBatchReply function.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> Not enough storage is available to
///    complete this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt>
///    </dl> </td> <td width="60%"> <i>hRegReadBatch</i> is <b>NULL</b> or not valid. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCloseReadBatch(_HREGREADBATCH* hRegReadBatch, _HREGREADBATCHREPLY** phRegReadBatchReply);

///Executes a read batch and returns results from the read batch executions.
///Params:
///    hRegReadBatch = The handle of the read batch. After the ClusterRegCloseReadBatch function completes, this handle is no longer
///                    valid, and memory associated with it is freed.
///    flags = The flags for the operation.
///    phRegReadBatchReply = A pointer to the handle of the created read batch result. You must close this handle later by calling the
///                          ClusterRegCloseReadBatchReply function.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> Not enough storage is available to
///    complete this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt>
///    </dl> </td> <td width="60%"> <i>hRegReadBatch</i> is <b>NULL</b> or not valid. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCloseReadBatchEx(_HREGREADBATCH* hRegReadBatch, uint flags, 
                               _HREGREADBATCHREPLY** phRegReadBatchReply);

///Reads the next command from a read batch result.
///Params:
///    hRegReadBatchReply = A handle to a read batch result that was created by calling the ClusterRegCloseReadBatch function. You must close
///                         this handle later by calling the ClusterRegCloseReadBatchReply function.
///    pBatchCommand = A pointer to a CLUSTER_READ_BATCH_COMMAND structure that contains information about the read command.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> <i>hRegReadBatchReply</i> is
///    <b>NULL</b> or not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259</dt>
///    </dl> </td> <td width="60%"> There is no more information in <i>hRegReadBatchReply</i>. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegReadBatchReplyNextCommand(_HREGREADBATCHREPLY* hRegReadBatchReply, 
                                        CLUSTER_READ_BATCH_COMMAND* pBatchCommand);

///Closes a read batch result handle and frees the memory associated with it.
///Params:
///    hRegReadBatchReply = A handle to a read batch result that was created by calling the ClusterRegCloseReadBatch function.
///Returns:
///    The function returns one of the following system error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td
///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> <i>hRegReadBatchReply</i> is
///    <b>NULL</b> or not valid. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
int ClusterRegCloseReadBatchReply(_HREGREADBATCHREPLY* hRegReadBatchReply);

///Updates an account access list (ACL) for a cluster.
///Params:
///    hCluster = A handle to the cluster.
///    szAccountSID = The security identifier (SID) or the account name for the new account access entry (ACE).
///    dwAccess = The access rights controlled by the ACE. The possible values are:
///    dwControlType = The ACE type to use. The possible values are:
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint ClusterSetAccountAccess(_HCLUSTER* hCluster, const(PWSTR) szAccountSID, uint dwAccess, uint dwControlType);

///Creates and starts a cluster. The cluster consists of the set of nodes specified, with the Network Name, IP Address,
///and quorum resources if specified. The <b>PCLUSAPI_CREATE_CLUSTER</b> type defines a pointer to this function.
///Params:
///    pConfig = Address of a CREATE_CLUSTER_CONFIG structure containing configuration information about the cluster to be
///              created.
///    pfnProgressCallback = Address of callback function that matches the PCLUSTER_SETUP_PROGRESS_CALLBACK function pointer that will be
///                          called periodically to provide progress on the cluster creation.
///    pvCallbackArg = Argument for the callback function.
///Returns:
///    Handle to the newly created cluster or <b>NULL</b>. A non <b>NULL</b> value does not indicate complete success
///    (all nodes will have been added, but not all IP Address or Network Name resources may have been created. The
///    parameters passed to the function pointed to by the <i>pfnProgressCallback</i> parameter should be checked.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>NULL</b></b></dt> </dl> </td> <td width="60%"> Less than a majority of nodes were successfully created.
///    For more information about the error, call the function GetLastError. </td> </tr> </table>
///    
@DllImport("CLUSAPI")
_HCLUSTER* CreateCluster(CREATE_CLUSTER_CONFIG* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                         void* pvCallbackArg);

///Creates a cluster name resource and then uses it add a cluster to a domain, even if the machines that host the
///cluster aren't members of the domain.The <b>PCLUSAPI_CREATE_CLUSTER_NAME_ACCOUNT</b> type defines a pointer to this
///function.
///Params:
///    hCluster = A handle to the cluster to add the cluster name resource to.
///    pConfig = A pointer to the CREATE_CLUSTER_NAME_ACCOUNT structure that contains the information about the cluster name
///              resource to create, and the domain credentials to use.
///    pfnProgressCallback = A pointer to the ClusterSetupProgressCallback callback function that receives the status of updates to the
///                          cluster.
///    pvCallbackArg = Callback function arguments for the <i>pfnProgressCallback</i> parameter.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("CLUSAPI")
uint CreateClusterNameAccount(_HCLUSTER* hCluster, CREATE_CLUSTER_NAME_ACCOUNT* pConfig, 
                              PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI")
uint RemoveClusterNameAccount(_HCLUSTER* hCluster, BOOL bDeleteComputerObjects);

@DllImport("CLUSAPI")
uint DetermineCNOResTypeFromNodelist(uint cNodes, PWSTR* ppszNodeNames, CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI")
uint DetermineCNOResTypeFromCluster(_HCLUSTER* hCluster, CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI")
uint DetermineClusterCloudTypeFromNodelist(uint cNodes, PWSTR* ppszNodeNames, CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI")
uint DetermineClusterCloudTypeFromCluster(_HCLUSTER* hCluster, CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI")
uint GetNodeCloudTypeDW(const(PWSTR) ppszNodeName, uint* NodeCloudType);

///Adds a notification type to a cluster notification port.This allows an application to register for notification
///events that only affect a particular cluster object.
///Params:
///    hChange = A handle to the notification port.
///    hCluster = A handle to the cluster object.
///    Flags = A CLUSTER_CHANGE_RESOURCE_TYPE_V2 enumeration value that specifies the notification type to add.
///    resTypeName = A pointer to a null-terminated Unicode string that contains the name of the resource type.
///    dwNotifyKey = The notification key that is returned from the GetClusterNotifyV2 function when the event occurs.
///Returns:
///    <b>ERROR_SUCCESS</b> if the operation is successful; otherwise, a system error code.
///    
@DllImport("CLUSAPI")
uint RegisterClusterResourceTypeNotifyV2(_HCHANGE* hChange, _HCLUSTER* hCluster, long Flags, 
                                         const(PWSTR) resTypeName, size_t dwNotifyKey);

///Adds a node to an existing cluster. The <b>PCLUSAPI_ADD_CLUSTER_NODE</b> type defines a pointer to this function.
///Params:
///    hCluster = Handle to a cluster, returned by the OpenCluster or CreateCluster function.
///    lpszNodeName = Name of the computer to add to the cluster.
///    pfnProgressCallback = Optional address to a PCLUSTER_SETUP_PROGRESS_CALLBACK callback function.
///    pvCallbackArg = Argument for the callback function.
///Returns:
///    Handle to the new node or <b>NULL</b> to indicate that the node was not successfully added to the cluster. For
///    more information about the error, call the GetLastError function.
///    
@DllImport("CLUSAPI")
_HNODE* AddClusterNode(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, 
                       PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI")
uint AddClusterStorageNode(_HCLUSTER* hCluster, const(PWSTR) lpszNodeName, 
                           PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, 
                           const(PWSTR) lpszClusterStorageNodeDescription, 
                           const(PWSTR) lpszClusterStorageNodeLocation);

@DllImport("CLUSAPI")
uint RemoveClusterStorageNode(_HCLUSTER* hCluster, const(PWSTR) lpszClusterStorageEnclosureName, uint dwTimeout, 
                              uint dwFlags);

///Removes a cluster. The <b>PCLUSAPI_DESTROY_CLUSTER</b> type defines a pointer to this function.
///Params:
///    hCluster = Handle to a cluster, returned by the OpenCluster or CreateCluster function.
///    pfnProgressCallback = Address of callback function that matches the PCLUSTER_SETUP_PROGRESS_CALLBACK function pointer that will be
///                          called periodically to provide progress on the cluster destruction.
///    pvCallbackArg = Argument for the callback function.
///    fdeleteVirtualComputerObjects = If <b>TRUE</b>, then delete the virtual computer objects associated with the cluster from the directory.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the cluster was completely removed or a system error code for the last failed
///    operation.
///    
@DllImport("CLUSAPI")
uint DestroyCluster(_HCLUSTER* hCluster, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, 
                    BOOL fdeleteVirtualComputerObjects);

///TBD
///Params:
///    clusterHealthFault = TBD
@DllImport("RESUTILS")
uint InitializeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

///TBD
///Params:
///    clusterHealthFaultArray = TBD
@DllImport("RESUTILS")
uint InitializeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

///TBD
///Params:
///    clusterHealthFault = TBD
@DllImport("RESUTILS")
uint FreeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

///TBD
///Params:
///    clusterHealthFaultArray = TBD
@DllImport("RESUTILS")
uint FreeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

///TBD
///Params:
///    hCluster = TBD
///    objects = TBD
///    flags = TBD
@DllImport("RESUTILS")
uint ClusGetClusterHealthFaults(_HCLUSTER* hCluster, CLUSTER_HEALTH_FAULT_ARRAY* objects, uint flags);

///TBD
///Params:
///    hCluster = TBD
///    id = TBD
///    flags = TBD
@DllImport("RESUTILS")
uint ClusRemoveClusterHealthFault(_HCLUSTER* hCluster, const(PWSTR) id, uint flags);

///TBD
///Params:
///    hCluster = TBD
///    failure = TBD
///    arg3 = TBD
@DllImport("RESUTILS")
uint ClusAddClusterHealthFault(_HCLUSTER* hCluster, CLUSTER_HEALTH_FAULT* failure, uint param2);

///Starts a service. The <b>PRESUTIL_START_RESOURCE_SERVICE</b> type defines a pointer to this function.
///Params:
///    pszServiceName = Null-terminated Unicode string containing the name of the service to start.
///    phServiceHandle = Optional pointer to a handle in which the handle to the started service is returned. This handle must be closed
///                      either by a call to the cluster utility function ResUtilStopService or the function CloseServiceHandle.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NEVER_STARTED</b></dt> </dl> </td> <td
///    width="60%"> The service was not started. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilStartResourceService(const(PWSTR) pszServiceName, SC_HANDLE__** phServiceHandle);

///Verifies that a named service is starting or currently running. The <b>PRESUTIL_VERIFY_RESOURCE_SERVICE</b> type
///defines a pointer to this function.
///Params:
///    pszServiceName = Null-terminated Unicode string containing the name of the service to verify.
@DllImport("RESUTILS")
uint ResUtilVerifyResourceService(const(PWSTR) pszServiceName);

///Stops a named service. The <b>PRESUTIL_STOP_RESOURCE_SERVICE</b> type defines a pointer to this function.
///Params:
///    pszServiceName = Null-terminated Unicode string containing the name of the service to stop.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_TIMEOUT</b></dt> </dl> </td> <td width="60%">
///    Service did not stop after a reasonable number of retries. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilStopResourceService(const(PWSTR) pszServiceName);

///Checks if a service identified by a handle is starting or currently running. The <b>PRESUTIL_VERIFY_SERVICE</b> type
///defines a pointer to this function.
///Params:
///    hServiceHandle = Handle of the service to verify.
@DllImport("RESUTILS")
uint ResUtilVerifyService(SC_HANDLE__* hServiceHandle);

///Stops a service identified by a handle. The <b>PRESUTIL_STOP_SERVICE</b> type defines a pointer to this function.
///Params:
///    hServiceHandle = Handle of the service to stop.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_TIMEOUT</b></dt> </dl> </td> <td width="60%">
///    Service did not stop after a reasonable number of retries. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilStopService(SC_HANDLE__* hServiceHandle);

///Creates every directory specified in a path, skipping directories that already exist. The
///<b>PRESUTIL_CREATE_DIRECTORY_TREE</b> type defines a pointer to this function.
///Params:
///    pszPath = Pointer to a null-terminated Unicode string specifying a path. The string can end with a trailing backslash.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilCreateDirectoryTree(const(PWSTR) pszPath);

///Checks whether a path is syntactically valid.
///Params:
///    pszPath = Pointer to the path to check.
@DllImport("RESUTILS")
BOOL ResUtilIsPathValid(const(PWSTR) pszPath);

///Enumerates the property names of a cluster object. The <b>PRESUTIL_ENUM_PROPERTIES</b> type defines a pointer to this
///function.
///Params:
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures describing properties to enumerate.
///    pszOutProperties = Pointer to the output buffer in which to return the names of all of the properties in multiple string format.
///                       Each property name is stored as a null-terminated Unicode string. The last property name is followed by a final
///                       null-terminating character.
///    cbOutPropertiesSize = Size in bytes of the output buffer pointed to by <i>pszOutProperties</i>.
///    pcbBytesReturned = Pointer to the total number of bytes in the property list pointed to by <i>pszOutProperties</i>.
///    pcbRequired = Number of bytes required if the output buffer is too small.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was an error allocating memory. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The size of the
///    output buffer is too small to hold the resulting data. The <i>pcbRequired</i> parameter points to the correct
///    size. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilEnumProperties(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, PWSTR pszOutProperties, 
                           uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);

///Retrieves the names of a cluster object's private properties. The <b>PRESUTIL_ENUM_PRIVATE_PROPERTIES</b> type
///defines a pointer to this function.
///Params:
///    hkeyClusterKey = Key identifying the location of the private properties in the cluster database.
///    pszOutProperties = Pointer to an output buffer in which to receive the names of the enumerated properties.
///    cbOutPropertiesSize = Size of the output buffer pointed to by <i>pszOutProperties</i>.
///    pcbBytesReturned = Pointer to the total number of bytes returned in the output buffer.
///    pcbRequired = Pointer to the required number of bytes if the output buffer is too small to hold all of the enumerated
///                  properties.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was an error allocating memory. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The size of the
///    output buffer is too small to hold the resulting data. The <i>pcbRequired</i> parameter points to the correct
///    size. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilEnumPrivateProperties(HKEY hkeyClusterKey, PWSTR pszOutProperties, uint cbOutPropertiesSize, 
                                  uint* pcbBytesReturned, uint* pcbRequired);

///Retrieves properties specified by a property table from the cluster database and returns them in a property list. The
///<b>PRESUTIL_GET_PROPERTIES</b> type defines a pointer to this function.
///Params:
///    hkeyClusterKey = Pointer to the cluster database key that identifies the location of the properties to retrieve.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures that describe the properties to retrieve.
///    pOutPropertyList = Pointer to an output buffer in which to return the property list.
///    cbOutPropertyListSize = Size in bytes of the output buffer pointed to by <i>pOutPropertyList</i>.
///    pcbBytesReturned = Pointer to the total number of bytes in the property list pointed to by <i>pOutPropertyList</i>.
///    pcbRequired = Pointer to the number of bytes that is required if <i>pOutPropertyList</i> is too small.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The output buffer was too small to contain the
///    resulting data. The <i>pcbRequired</i> parameter indicates the required size. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was an error allocating memory.
///    </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                          void* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                          uint* pcbRequired);

///Returns a property list that includes all of the default and unknown properties for a cluster object. The
///<b>PRESUTIL_GET_ALL_PROPERTIES</b> type defines a pointer to this function.
///Params:
///    hkeyClusterKey = Pointer to the cluster database key that identifies the location of the properties to retrieve.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures that describe the properties to retrieve.
///    pOutPropertyList = Pointer to an output buffer in which to return the property list.
///    cbOutPropertyListSize = Size in bytes of the output buffer pointed to by <i>OutBuffer</i>.
///    pcbBytesReturned = Pointer to the total number of bytes in the property list pointed to by <i>OutBuffer</i>.
///    pcbRequired = Pointer to the number of bytes that is required if <i>OutBuffer</i> is too small.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was an error allocating memory. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The size of the
///    output buffer is too small to hold the resulting data. The <i>pcbRequired</i> parameter points to the correct
///    size. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetAllProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                             void* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                             uint* pcbRequired);

///Returns private properties for a cluster object. The <b>PRESUTIL_GET_PRIVATE_PROPERTIES</b> type defines a pointer to
///this function.
///Params:
///    hkeyClusterKey = Pointer to the cluster database key that identifies the location of the private properties to retrieve.
///    pOutPropertyList = Pointer to an output buffer in which a property list with the names and values of the private properties is
///                       returned.
///    cbOutPropertyListSize = Size of the output buffer pointed to by <i>pOutPropertyList</i>.
///    pcbBytesReturned = Pointer to the total number of bytes in the property list pointed to by <i>pOutPropertyList</i>.
///    pcbRequired = Pointer to the number of bytes that is required if <i>pOutPropertyList</i> is too small to hold all of the
///                  private properties.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was an error allocating memory. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The size of the
///    output buffer is too small to hold the resulting data. The <i>pcbRequired</i> parameter points to the correct
///    size. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetPrivateProperties(HKEY hkeyClusterKey, void* pOutPropertyList, uint cbOutPropertyListSize, 
                                 uint* pcbBytesReturned, uint* pcbRequired);

///Returns the total number of bytes required for a specified property.
///Params:
///    hkeyClusterKey = Cluster database key identifying the location of the property to size.
///    pPropertyTableItem = Pointer to a RESUTIL_PROPERTY_ITEM structure describing the property to size.
///    pcbOutPropertyListSize = Pointer to the total number of bytes required for the property value, which includes the CLUSPROP_VALUE structure
///                             and the data.
///    pnPropertyCount = Pointer to the total number of properties. This value is incremented to include this property if
///                      <b>ResUtilGetPropertySize</b> is successful.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The data type of a property specified in the
///    property table does not match the data type of the same-named property stored in the cluster database. </td>
///    </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetPropertySize(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                            uint* pcbOutPropertyListSize, uint* pnPropertyCount);

///Returns a specified property from the cluster database. The <b>PRESUTIL_GET_PROPERTY</b> type defines a pointer to
///this function.
///Params:
///    hkeyClusterKey = Pointer to the cluster database key identifying the location of the property to retrieve.
///    pPropertyTableItem = Pointer to a RESUTIL_PROPERTY_ITEM structure that describes the property to retrieve.
///    pOutPropertyItem = Pointer to an output buffer in which to return the requested property. It is assumed that the buffer is part of a
///                       property list.
///    pcbOutPropertyItemSize = Pointer to the size in bytes of the output buffer pointed to by <i>pOutPropertyItem</i>.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetProperty(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                        void** pOutPropertyItem, uint* pcbOutPropertyItemSize);

///Uses a property table to verify that a property list is correctly formatted.
///Params:
///    pPropertyTable = Pointer to a property table describing the properties that will be validated in the property list.
///    Reserved = This parameter is reserved for future use.
///    bAllowUnknownProperties = If <b>TRUE</b>, the function ignores all properties in the property list that are not included in the property
///                              table. If <b>FALSE</b>, any property in the property list that is not included in the property table causes the
///                              function to return <b>ERROR_INVALID_PARAMETER</b>.
///    pInPropertyList = Pointer to the input buffer containing the property list to validate.
///    cbInPropertyListSize = Size in bytes of the input buffer pointed to by <i>pInPropertyList</i>.
///    pOutParams = Pointer to a parameter block.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The property list buffer is larger than reported by the <i>cbInPropertyListSize</i> parameter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> No property list
///    buffer was specified, or the property list is formatted incorrectly </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The property list is formatted incorrectly.
///    If <i>bAllowUnknownProperties</i> is set to <b>FALSE</b>, the property list may contain properties that are not
///    present in the property table. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilVerifyPropertyTable(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                                BOOL bAllowUnknownProperties, const(void)* pInPropertyList, 
                                uint cbInPropertyListSize, ubyte* pOutParams);

///Sets properties in the cluster database based on a property list from a property table..
///Params:
///    hkeyClusterKey = Cluster database key identifying the location of the properties to set.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures describing the properties to set.
///    Reserved = Reserved.
///    bAllowUnknownProperties = Indicates whether unknown properties should be accepted. This parameter is set to <b>TRUE</b> if they should be
///                              accepted, and <b>FALSE</b> if not.
///    pInPropertyList = Pointer to the input buffer containing a property list.
///    cbInPropertyListSize = Size in bytes of the input buffer pointed to by <i>cbInPropertyList</i>.
///    pOutParams = Pointer to a parameter block to hold returned data. If specified, parameters are only written if they differ from
///                 those in the input buffer.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the input buffer specified in
///    <i>cbInPropertyListSize</i> is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The input buffer pointed to by
///    <i>pInPropertyList</i> is <b>NULL</b>, a property name is not valid, or a property value is too small. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The syntax,
///    format, or type of a property in the property table pointed to by <i>pPropertyTable</i> is incorrect, or a
///    property is read-only and cannot be set. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetPropertyTable(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                             BOOL bAllowUnknownProperties, const(void)* pInPropertyList, uint cbInPropertyListSize, 
                             ubyte* pOutParams);

///Sets properties in the cluster database based on a property list from a property table.
///Params:
///    hkeyClusterKey = Cluster database key identifying the location of the properties to set.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures describing the properties to set.
///    Reserved = Reserved.
///    bAllowUnknownProperties = Indicates whether unknown properties should be accepted. This parameter is set to <b>TRUE</b> if they should be
///                              accepted and <b>FALSE</b> if not.
///    pInPropertyList = Pointer to the input buffer containing a property list.
///    cbInPropertyListSize = Size in bytes of the input buffer pointed to by <i>cbInPropertyList</i>.
///    bForceWrite = Forces the property values to be written to the cluster database even if the new values are identical to the
///                  existing values
///    pOutParams = Pointer to a parameter block to hold returned data. When this is pointer is specified, only parameters that
///                 differ from those in the input buffer are written to the parameter block.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the input buffer specified in
///    <i>cbInPropertyListSize</i> is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The input buffer pointed to by
///    <i>pInPropertyList</i> is <b>NULL</b>, a property name is not valid, or a property value is too small. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The syntax,
///    format, or type of a property in the property table pointed to by <i>pPropertyTable</i> is incorrect, or a
///    property is read-only and cannot be set. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetPropertyTableEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                               BOOL bAllowUnknownProperties, const(void)* pInPropertyList, uint cbInPropertyListSize, 
                               BOOL bForceWrite, ubyte* pOutParams);

///Sets properties in the cluster database from a parameter block.
///Params:
///    hkeyClusterKey = Cluster database key identifying the location for the properties to set.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures describing the properties to set.
///    Reserved = Reserved.
///    pInParams = Pointer to an input parameter block containing the data for the properties described in the property table
///                pointed to by <i>pPropertyTable</i>.
///    pInPropertyList = Pointer to the input buffer containing a property list or <b>NULL</b>. If <i>pInPropertyList</i> is not
///                      <b>NULL</b>, any properties listed in the property list that are not listed in the property table are also set in
///                      the cluster database.
///    cbInPropertyListSize = Size in bytes of the input buffer pointed to by <i>pInPropertyList</i>.
///    pOutParams = Pointer to a parameter block to receive data copied from the <i>pInParams</i> parameter.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The syntax, format, or type of a property in the property table pointed to by <i>pPropertyTable</i>
///    is incorrect, or a property is read-only and cannot be updated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td width="60%"> One or more of the input parameters were
///    invalid. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetPropertyParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                      void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, 
                                      uint cbInPropertyListSize, ubyte* pOutParams);

///Sets properties in the cluster database from a parameter block.
///Params:
///    hkeyClusterKey = Cluster database key identifying the location for the properties to set.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures describing the properties to set.
///    Reserved = Reserved.
///    pInParams = Pointer to an input parameter block containing the data for the properties described in the property table
///                pointed to by <i>pPropertyTable</i>.
///    pInPropertyList = Pointer to the input buffer containing a property list or <b>NULL</b>. If <i>pInPropertyList</i> is not
///                      <b>NULL</b>, any properties listed in the property list that are not listed in the property table are also set in
///                      the cluster database.
///    cbInPropertyListSize = Size in bytes of the input buffer pointed to by <i>pInPropertyList</i>.
///    bForceWrite = Forces the property values to be written to the cluster database even if the new values are identical to the
///                  existing values
///    pOutParams = Pointer to a parameter block to receive data copied from the <i>pInParams</i> parameter.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The syntax, format, or type of a property in the property table pointed to by <i>pPropertyTable</i>
///    is incorrect, or a property is read-only and cannot be updated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td width="60%"> One or more of the input parameters were
///    invalid. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetPropertyParameterBlockEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                        void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, 
                                        uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);

///Stores a cluster object's unknown properties in the cluster database.
///Params:
///    hkeyClusterKey = Cluster database key identifying the location of the properties to set.
///    pPropertyTable = Pointer to a property table specifying properties that should NOT be set by this function.
///    pInPropertyList = Pointer to a property list. Any properties that appear in this list and that do NOT appear in
///                      <i>pInPropertyList</i> are set.
///    cbInPropertyListSize = Pointer to the size in bytes of the input buffer pointed to by <i>pInPropertyList</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilSetUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                 const(void)* pInPropertyList, uint cbInPropertyListSize);

///Retrieves properties specified by a property table from the cluster database and returns them in a parameter block.
///Params:
///    hkeyClusterKey = Pointer to the cluster database key that identifies the location of the properties to retrieve.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures that describes the properties to process.
///    pOutParams = Pointer to the output parameter block to fill.
///    bCheckForRequiredProperties = Specifies whether an error should be generated if required properties are missing.
///    pszNameOfPropInError = Address of the string pointer in which to return the name of the error generated by a missing required property.
///                           The <i>ppszNameOfPropInError</i> property is optional.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was an error allocating memory. </td>
///    </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetPropertiesToParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                          ubyte* pOutParams, BOOL bCheckForRequiredProperties, 
                                          PWSTR* pszNameOfPropInError);

///Constructs a property list from a property table and a parameter block.
///Params:
///    pPropertyTable = Pointer to a property table describing the properties that will be included in the resulting property list.
///    pOutPropertyList = Pointer to an output buffer that receives the property list.
///    pcbOutPropertyListSize = Pointer to the size of the output buffer in bytes.
///    pInParams = Pointer to the parameter block in which the property values are stored.
///    pcbBytesReturned = If the function returns <b>ERROR_SUCCESS</b>, <i>pcbBytesReturned</i> points to the actual byte size of the
///                       property list pointed to by <i>pOutPropertyList</i>. If the function does not return <b>ERROR_SUCCESS</b>,
///                       <i>pcbBytesReturned</i> points to a value of zero.
///    pcbRequired = If the function returns <b>ERROR_MORE_DATA</b>, <i>pcbRequired</i> points to the byte size required to contain
///                  the property list. If the function does not return <b>ERROR_MORE_DATA</b>, <i>pcbBytesReturned</i> points to a
///                  value of zero.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The output buffer is too small to contain the resulting property list. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td width="60%"> One or more of the input
///    parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> There was an error allocating memory. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilPropertyListFromParameterBlock(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* pOutPropertyList, 
                                           uint* pcbOutPropertyListSize, const(ubyte)* pInParams, 
                                           uint* pcbBytesReturned, uint* pcbRequired);

///Performs a member-wise copy of the data from one parameter block to another.
///Params:
///    pOutParams = Pointer to the duplicated parameter block.
///    pInParams = Pointer to the original parameter block.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures describing properties in the original parameter block.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilDupParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, 
                              const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

///Deallocates memory that has been allocated for a parameter block by ResUtilDupParameterBlock.
///Params:
///    pOutParams = Pointer to the parameter block to deallocate.
///    pInParams = Pointer to the parameter block to use as a reference.
///    pPropertyTable = Pointer to an array of RESUTIL_PROPERTY_ITEM structures describing the properties in the input parameter block.
@DllImport("RESUTILS")
void ResUtilFreeParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, 
                               const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

///Retrieves a set of unknown properties from the cluster database and appends them to the end of a property list.
///Params:
///    hkeyClusterKey = Pointer to the cluster database key that identifies the location for the properties to read.
///    pPropertyTable = Pointer to a property table describing the common and private properties of an object. Any properties found in
///                     the cluster database that are not in this property table are added to the property list.
///    pOutPropertyList = Pointer to a buffer in which to receive the returned properties. On input, the buffer can contain an existing
///                       property list, or it can be empty. On output, the retrieved properties will be appended to the end of the
///                       existing list, or, if the buffer is empty, will return as a new property list.
///    pcbOutPropertyListSize = Total byte size of the buffer pointed to by <i>pOutPropertyList</i>. The size of the buffer must be large enough
///                             to contain the existing property list and the property list to be returned.
///    pcbBytesReturned = On input, pointer to the byte size of the property list contained by the pOutPropertyList buffer. On output,
///                       pointer to the total number of bytes in the property list pointed to by <i>pOutPropertyList</i>.
///    pcbRequired = On output, points to the total number of bytes required to hold the returned property list. If the
///                  <i>pOutPropertyList</i> buffer was too small, it can be reallocated to the required size.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There was an error allocating memory. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilAddUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                 void* pOutPropertyList, uint pcbOutPropertyListSize, uint* pcbBytesReturned, 
                                 uint* pcbRequired);

///Sets the private properties of a cluster object.
///Params:
///    hkeyClusterKey = Cluster database key identifying the location of the properties to set.
///    pInPropertyList = Pointer to an input buffer containing a property list with the names and values of the properties to set.
///    cbInPropertyListSize = Pointer to the size in bytes of the input buffer pointed to by <i>pInPropertyList</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> There was a problem with the length of a
///    property's data. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The input buffer pointed to by <i>pInPropertyList</i> was NULL. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The syntax of a property name was
///    invalid. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetPrivatePropertyList(HKEY hkeyClusterKey, const(void)* pInPropertyList, uint cbInPropertyListSize);

///Verifies that a property list is correctly formatted.
///Params:
///    pInPropertyList = Pointer to an input buffer containing the property list to verify.
///    cbInPropertyListSize = Size of the input buffer pointed to by <i>pInPropertyList</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilVerifyPrivatePropertyList(const(void)* pInPropertyList, uint cbInPropertyListSize);

///Duplicates a null-terminated Unicode string.
///Params:
///    pszInString = Pointer to the string to duplicate.
///Returns:
///    If the operation succeeds, the function returns a pointer to a buffer containing the duplicate string. If the
///    operation fails, the function returns <b>NULL</b>. For more information, call the function GetLastError.
///    
@DllImport("RESUTILS")
PWSTR ResUtilDupString(const(PWSTR) pszInString);

///Returns a binary value from the cluster database.
///Params:
///    hkeyClusterKey = Key in the cluster database that identifies the location of the value to retrieve.
///    pszValueName = Pointer to a null-terminated Unicode string containing the name of the value to retrieve.
///    ppbOutValue = Address of the pointer to the retrieved value.
///    pcbOutValueSize = Pointer to a <b>DWORD</b> in which the size in bytes of the buffer pointed to by <i>ppbOutValue</i> is returned.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There was an error allocating memory for the value. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetBinaryValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ubyte** ppbOutValue, 
                           uint* pcbOutValueSize);

///Returns a string value from the cluster database.
///Params:
///    hkeyClusterKey = Key identifying the location of the value in the cluster database.
///    pszValueName = A null-terminated Unicode string containing the name of the value to retrieve.
///Returns:
///    If the operation succeeds, the function returns a pointer to a buffer containing the string value. If the
///    operation fails, the function returns <b>NULL</b>. For more information, call the function GetLastError.
///    
@DllImport("RESUTILS")
PWSTR ResUtilGetSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName);

///Returns a numeric value from the cluster database.
///Params:
///    hkeyClusterKey = Key identifying the location of the numeric value in the cluster database.
///    pszValueName = Pointer to a null-terminated Unicode string containing the name of the value to retrieve.
///    pdwOutValue = Pointer to the retrieved value.
///    dwDefaultValue = Value to return if the value pointed to by <i>pszValueName</i> is not found.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The value pointed to by <i>ValueName</i> is not a numeric value. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetDwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, uint* pdwOutValue, uint dwDefaultValue);

///TBD
///Params:
///    hkeyClusterKey = TBD
///    pszValueName = TBD
///    pqwOutValue = TBD
@DllImport("RESUTILS")
uint ResUtilGetQwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ulong* pqwOutValue, ulong qwDefaultValue);

///Sets a binary value in the cluster database.
///Params:
///    hkeyClusterKey = Key identifying the location of the binary value in the cluster database.
///    pszValueName = A null-terminated Unicode string containing the name of the value to update.
///    pbNewValue = Pointer to the new binary value.
///    cbNewValueSize = Size of the new binary value.
///    ppbOutValue = Address of a pointer to the new binary value.
///    pcbOutValueSize = Pointer to a <b>DWORD</b> in which the size in bytes of the value pointed to by <i>ppbOutValue</i> is returned.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetBinaryValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, const(ubyte)* pbNewValue, 
                           uint cbNewValueSize, ubyte** ppbOutValue, uint* pcbOutValueSize);

///Sets a string value in the cluster database. The <b>PRESUTIL_SET_SZ_VALUE</b> type defines a pointer to this
///function.
///Params:
///    hkeyClusterKey = Key identifying the location of the string value in the cluster database.
///    pszValueName = Null-terminated Unicode string containing the name of the value to update.
///    pszNewValue = Pointer to the new string value.
///    ppszOutString = Pointer to a string pointer that receives a copy of the updated value. If used, callers must call LocalFree on
///                    *<i>ppszOutValue</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred while attempting to allocate memory. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, const(PWSTR) pszNewValue, 
                       PWSTR* ppszOutString);

///Sets an expandable string value in the cluster database. The <b>PRESUTIL_SET_EXPAND_SZ_VALUE</b> type defines a
///pointer to this function.
///Params:
///    hkeyClusterKey = Key identifying the location of the expandable string value in the cluster database.
///    pszValueName = null-terminated Unicode string containing the name of the value to update.
///    pszNewValue = Pointer to the new expandable string value.
///    ppszOutString = Pointer to a string pointer that receives a copy of the updated value. If used, callers must call LocalFree on
///                    *<i>ppszOutValue</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred while attempting to allocate memory. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetExpandSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, const(PWSTR) pszNewValue, 
                             PWSTR* ppszOutString);

///Sets a multiple string value in the cluster database. The <b>PRESUTIL_SET_MULTI_SZ_VALUE</b> type defines a pointer
///to this function.
///Params:
///    hkeyClusterKey = Key identifying the location of the multiple string value in the cluster database.
///    pszValueName = Null-terminated Unicode string containing the name of the value to update.
///    pszNewValue = Pointer to the new multiple string value.
///    cbNewValueSize = Size of the new value.
///    ppszOutValue = Pointer to a string pointer that receives a copy of the updated value. If used, callers must call LocalFree on
///                   *<i>ppszOutValue</i>.
///    pcbOutValueSize = Pointer that receives the size of the new value.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred while attempting to allocate memory. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilSetMultiSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, const(PWSTR) pszNewValue, 
                            uint cbNewValueSize, PWSTR* ppszOutValue, uint* pcbOutValueSize);

///Sets a numeric value in the cluster database. The <b>PRESUTIL_SET_DWORD_VALUE</b> type defines a pointer to this
///function.
///Params:
///    hkeyClusterKey = Key identifying the location of the numeric value in the cluster database.
///    pszValueName = A null-terminated Unicode string containing the name of the value to update.
///    dwNewValue = New <b>DWORD</b> value.
///    pdwOutValue = Optional. Pointer to where the updated value should be copied.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilSetDwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, uint dwNewValue, uint* pdwOutValue);

///TBD. The <b>PRESUTIL_SET_QWORD_VALUE</b> type defines a pointer to this function.
///Params:
///    hkeyClusterKey = 
///    pszValueName = 
///    qwNewValue = 
@DllImport("RESUTILS")
uint ResUtilSetQwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ulong qwNewValue, ulong* pqwOutValue);

///Sets a value in the cluster database.
///Params:
///    hkeyClusterKey = A key that identifies the location of the value in the cluster database.
///    valueName = A Null-terminated Unicode string that contains the name of the value to update.
///    valueType = A flag that indicates the type of the value to update.
///    valueData = A pointer to the new data for the value.
///    valueSize = The size of the new value, in bytes.
///    flags = The flags that specify settings for the operation.
@DllImport("RESUTILS")
uint ResUtilSetValueEx(HKEY hkeyClusterKey, const(PWSTR) valueName, uint valueType, const(ubyte)* valueData, 
                       uint valueSize, uint flags);

///Retrieves a binary property from a property list and advances a pointer to the next property in the list. The
///<b>PRESUTIL_GET_BINARY_PROPERTY</b> type defines a pointer to this function.
///Params:
///    ppbOutValue = Address of a pointer in which the binary value from the property list will be returned.
///    pcbOutValueSize = Pointer to the size of the output value.
///    pValueStruct = Pointer to a CLUSPROP_BINARY structure specifying the binary value to retrieve from the property list.
///    pbOldValue = Pointer to the previous value of the property.
///    cbOldValueSize = Pointer to the length of the previous value of the property.
///    ppPropertyList = Address of the pointer to the property list buffer containing the binary property. This pointer will be advanced
///                     to the beginning of the next property.
///    pcbPropertyListSize = Pointer to the size of the property list buffer. The size will be decremented to account for the advance of the
///                          <i>ppPropertyList</i> pointer.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The data is formatted incorrectly. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetBinaryProperty(ubyte** ppbOutValue, uint* pcbOutValueSize, const(CLUSPROP_BINARY)* pValueStruct, 
                              const(ubyte)* pbOldValue, uint cbOldValueSize, ubyte** ppPropertyList, 
                              uint* pcbPropertyListSize);

///Retrieves a string property from a property list and advances a pointer to the next property in the list. The
///<b>PRESUTIL_GET_SZ_PROPERTY</b> type defines a pointer to this function.
///Params:
///    ppszOutValue = Address of a pointer in which the string value from the property list will be returned.
///    pValueStruct = Pointer to a CLUSPROP_SZ structure specifying the string value to retrieve from the property list.
///    pszOldValue = Pointer to the previous value of the property.
///    ppPropertyList = Address of the pointer to the property list buffer containing the string property. This pointer will be advanced
///                     to the beginning of the next property.
///    pcbPropertyListSize = Pointer to the size of the property list buffer. The size will be decremented to account for the advance of the
///                          <i>ppPropertyList</i> pointer.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The data is formatted incorrectly. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetSzProperty(PWSTR* ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, const(PWSTR) pszOldValue, 
                          ubyte** ppPropertyList, uint* pcbPropertyListSize);

///Retrieves a multiple string property from a property list and advances a pointer to the next property in the list.
///The <b>PRESUTIL_GET_MULTI_SZ_PROPERTY</b> type defines a pointer to this function.
///Params:
///    ppszOutValue = Address of a pointer in which the multiple string value from the property list will be returned.
///    pcbOutValueSize = Pointer to the size of the output value.
///    pValueStruct = Pointer to a CLUSPROP_MULTI_SZ structure specifying the multiple string value to retrieve from the property list.
///    pszOldValue = Pointer to the previous value of the property.
///    cbOldValueSize = Pointer to the length of the previous value of the property.
///    ppPropertyList = Address of the pointer to the property list buffer containing the multiple string property. This pointer will be
///                     advanced to the beginning of the next property.
///    pcbPropertyListSize = Pointer to the size of the property list buffer. The size will be decremented to account for the advance of the
///                          <i>ppPropertyList</i> pointer.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The data is formatted incorrectly. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetMultiSzProperty(PWSTR* ppszOutValue, uint* pcbOutValueSize, const(CLUSPROP_SZ)* pValueStruct, 
                               const(PWSTR) pszOldValue, uint cbOldValueSize, ubyte** ppPropertyList, 
                               uint* pcbPropertyListSize);

///Retrieves a <b>DWORD</b> property from a property list and advances a pointer to the next property in the list. The
///<b>PRESUTIL_GET_DWORD_PROPERTY</b> type defines a pointer to this function.
///Params:
///    pdwOutValue = Address of a pointer in which the <b>DWORD</b> value from the property list will be returned.
///    pValueStruct = Pointer to a CLUSPROP_DWORD structure specifying the <b>DWORD</b> value to retrieve from the property list.
///    dwOldValue = Specifies the previous value of the property.
///    dwMinimum = Specifies the minimum value allowed for the property.
///    dwMaximum = Specifies the maximum value allowed for the property.
///    ppPropertyList = Address of the pointer to the property list buffer containing the <b>DWORD</b> property. This pointer will be
///                     advanced to the beginning of the next property.
///    pcbPropertyListSize = Pointer to the size of the property list buffer. The size will be decremented to account for the advance of the
///                          <i>ppPropertyList</i> pointer.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The data is formatted incorrectly. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetDwordProperty(uint* pdwOutValue, const(CLUSPROP_DWORD)* pValueStruct, uint dwOldValue, 
                             uint dwMinimum, uint dwMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

///TBD. The <b>PRESUTIL_GET_LONG_PROPERTY</b> type defines a pointer to this function.
///Params:
///    plOutValue = TBD
///    pValueStruct = TBD
///    lOldValue = TBD
///    lMinimum = TBD
///    lMaximum = TBD
///    ppPropertyList = TBD
@DllImport("RESUTILS")
uint ResUtilGetLongProperty(int* plOutValue, const(CLUSPROP_LONG)* pValueStruct, int lOldValue, int lMinimum, 
                            int lMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

///TBD. The <b>PRESUTIL_GET_FILETIME_PROPERTY</b> type defines a pointer to this function.
///Params:
///    pftOutValue = 
///    pValueStruct = 
///    ftOldValue = 
///    ftMinimum = 
///    ftMaximum = 
///    ppPropertyList = 
@DllImport("RESUTILS")
uint ResUtilGetFileTimeProperty(FILETIME* pftOutValue, const(CLUSPROP_FILETIME)* pValueStruct, FILETIME ftOldValue, 
                                FILETIME ftMinimum, FILETIME ftMaximum, ubyte** ppPropertyList, 
                                uint* pcbPropertyListSize);

///Adjusts environment data for a resource so that the resource uses a cluster network name to identify its location.
///The resource must be dependent on a Network Name resource. The <b>PRESUTIL_GET_ENVIRONMENT_WITH_NET_NAME</b> type
///defines a pointer to this function.
///Params:
///    hResource = Handle to a resource that depends on a Network Name resource.
///Returns:
///    If the operations succeeds, the function returns a pointer to the environment block. If the operation fails, the
///    function returns <b>NULL</b>. For more information, call GetLastError.
///    
@DllImport("RESUTILS")
void* ResUtilGetEnvironmentWithNetName(_HRESOURCE* hResource);

///Destroys the environment variable block created with ResUtilGetEnvironmentWithNetName. The
///<b>PRESUTIL_FREE_ENVIRONMENT</b> type defines a pointer to this function.
///Params:
///    lpEnvironment = Pointer to the environment variable block returned from ResUtilGetEnvironmentWithNetName.
///Returns:
///    This function has no return values.
///    
@DllImport("RESUTILS")
uint ResUtilFreeEnvironment(void* lpEnvironment);

///Expands strings containing unexpanded references to environment variables. The
///<b>PRESUTIL_EXPAND_ENVIRONMENT_STRINGS</b> type defines a pointer to this function.
///Params:
///    pszSrc = Pointer to a null-terminated Unicode string containing unexpanded references to environment variables (an
///             expandable string).
///Returns:
///    If the operation succeeds, the function returns a pointer to the expanded string (REG_EXPAND_SZ). The function
///    allocates the necessary memory with LocalAlloc. To prevent memory leaks, be sure to release the memory with
///    LocalFree. If the operation fails, the function returns <b>NULL</b>. For more information, call GetLastError.
///    
@DllImport("RESUTILS")
PWSTR ResUtilExpandEnvironmentStrings(const(PWSTR) pszSrc);

///Adjusts the environment data for a service so that the service uses a cluster network name to identify its location.
///This function must be called from a resource DLL. The <b>PRESUTIL_SET_RESOURCE_SERVICE_ENVIRONMENT</b> type defines a
///pointer to this function.
///Params:
///    pszServiceName = Pointer a null-terminated Unicode string containing the name of the service.
///    hResource = Resource handle for the service obtained from OpenClusterResource.
///    pfnLogEvent = Pointer to the LogEvent entry point function of the resource DLL managing the service.
///    hResourceHandle = Resource handle required by the LogEvent entry point function. Use the handle passed to the DLL in the Open entry
///                      point function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilSetResourceServiceEnvironment(const(PWSTR) pszServiceName, _HRESOURCE* hResource, 
                                          PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

///Removes the environment data from a service. This function must be called from a resource DLL. The
///<b>PRESUTIL_REMOVE_RESOURCE_SERVICE_ENVIRONMENT</b> type defines a pointer to this function.
///Params:
///    pszServiceName = Pointer to a null-terminated Unicode string that contains the name of the service.
///    pfnLogEvent = Pointer to the LogEvent entry point function of the resource DLL that manages the service.
///    hResourceHandle = Resource handle that the LogEvent entry point function requires. Use the handle passed to the DLL in the Open
///                      entry point function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilRemoveResourceServiceEnvironment(const(PWSTR) pszServiceName, PLOG_EVENT_ROUTINE pfnLogEvent, 
                                             ptrdiff_t hResourceHandle);

///Adjusts the start parameters of a specified service so that it will operate correctly as a cluster resource. It must
///be called from a resource DLL. The <b>PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS</b> type defines a pointer to
///this function.
///Params:
///    pszServiceName = Pointer to a null-terminated Unicode string specifying the name of the service.
///    schSCMHandle = Handle to the Service Control Manager (SCM) or <b>NULL</b>. If <b>NULL</b>, the function will attempt to open a
///                   handle to the SCM.
///    phService = On input, a <b>NULL</b> service handle. On output, handle to the specified service if the call was successful,
///                otherwise <b>NULL</b>.
///    pfnLogEvent = Pointer to the LogEvent entry point function of the resource DLL managing the service.
///    hResourceHandle = Resource handle required by the LogEvent entry point function. Use the handle passed to the DLL in the Open entry
///                      point function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilSetResourceServiceStartParameters(const(PWSTR) pszServiceName, SC_HANDLE__* schSCMHandle, 
                                              SC_HANDLE__** phService, PLOG_EVENT_ROUTINE pfnLogEvent, 
                                              ptrdiff_t hResourceHandle);

///Locates a string property in a property list. The <b>PRESUTIL_FIND_SZ_PROPERTY</b> type defines a pointer to this
///function.
///Params:
///    pPropertyList = Pointer to the property list in which to locate the value.
///    cbPropertyListSize = Size in bytes of the data included in <i>pPropertyList</i>.
///    pszPropertyName = Pointer to a null-terminated Unicode string containing the name of the value to locate.
///    pszPropertyValue = Pointer to a <b>WCHAR</b> pointer to a buffer (allocated by the function) containing a copy of the property
///                       value. You must call LocalFree (on *<i>pszPropertyValue</i>) to free the allocated memory. If no value is
///                       required, pass <b>NULL</b> for this parameter.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The property list is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The function could not allocate a buffer in
///    which to return the property value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The specified property could not be located in the property list. </td> </tr>
///    </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindSzProperty(const(void)* pPropertyList, uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                           PWSTR* pszPropertyValue);

///Locates an expandable string property in a property list. The <b>PRESUTIL_FIND_EXPAND_SZ_PROPERTY</b> type defines a
///pointer to this function.
///Params:
///    pPropertyList = Pointer to the property list in which to locate the value.
///    cbPropertyListSize = Size in bytes of the data included in <i>pPropertyList</i>.
///    pszPropertyName = Pointer to a null-terminated Unicode string containing the name of the value to locate.
///    pszPropertyValue = Pointer to a <b>WCHAR</b> pointer to a buffer (allocated by the function) containing a copy of the property
///                       value. You must call LocalFree (on *<i>pszPropertyValue</i>) to free the allocated memory. If no value is
///                       required, pass <b>NULL</b> for this parameter.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The property list is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The function could not allocate a buffer in
///    which to return the property value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The specified property could not be located in the property list. </td> </tr>
///    </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindExpandSzProperty(const(void)* pPropertyList, uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                 PWSTR* pszPropertyValue);

///Locates an expanded string property value in a property list. The <b>PRESUTIL_FIND_EXPANDED_SZ_PROPERTY</b> type
///defines a pointer to this function.
///Params:
///    pPropertyList = Pointer to the property list in which to locate the value.
///    cbPropertyListSize = Size in bytes of the data included in <i>pPropertyList</i>.
///    pszPropertyName = Pointer to a null-terminated Unicode string containing the name of the value to locate.
///    pszPropertyValue = Pointer to a <b>WCHAR</b> pointer to a buffer (allocated by the function) containing a copy of the property
///                       value. You must call LocalFree (on *<i>pszPropertyValue</i>) to free the allocated memory. If no value is
///                       required, pass <b>NULL</b> for this parameter.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The property list is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The function could not allocate a buffer in
///    which to return the property value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The specified property could not be located in the property list. </td> </tr>
///    </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindExpandedSzProperty(const(void)* pPropertyList, uint cbPropertyListSize, 
                                   const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue);

///Locates an unsigned long property value in a property list. The <b>PRESUTIL_FIND_DWORD_PROPERTY</b> type defines a
///pointer to this function.
///Params:
///    pPropertyList = Pointer to the property list in which to locate the value.
///    cbPropertyListSize = Size in bytes of the data included in <i>pPropertyList</i>.
///    pszPropertyName = Pointer to a null-terminated Unicode string containing the name of the value to locate.
///    pdwPropertyValue = Pointer to the actual value of the data stored in the property list buffer.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The data is in an incorrect format. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The property could not be located in the
///    property list. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindDwordProperty(const(void)* pPropertyList, uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                              uint* pdwPropertyValue);

///Locates a specified binary property in a property list and can also return the value of the property. The
///<b>PRESUTIL_FIND_BINARY_PROPERTY</b> type defines a pointer to this function.
///Params:
///    pPropertyList = Pointer to the property list in which to locate the value.
///    cbPropertyListSize = Size, in bytes, of the property list specified by <i>pPropertyList</i>.
///    pszPropertyName = Pointer to a null-terminated Unicode string containing the name of the property to locate.
///    pbPropertyValue = Pointer to a <b>BYTE</b> pointer to a buffer (allocated by the function) containing a copy of the property value.
///                      You must call LocalFree (on *<i>pbPropertyValue</i>) to free the allocated memory. If no value is required, pass
///                      <b>NULL</b> for this parameter.
///    pcbPropertyValueSize = Pointer to the size, in bytes, of the value returned. If no size is required, pass <b>NULL</b> for this
///                           parameter.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The property list is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The function could not allocate a buffer in
///    which to return the property value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The specified property could not be located in the property list. </td> </tr>
///    </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindBinaryProperty(const(void)* pPropertyList, uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                               ubyte** pbPropertyValue, uint* pcbPropertyValueSize);

///Locates a multiple string property in a property list. The <b>PRESUTIL_FIND_MULTI_SZ_PROPERTY</b> type defines a
///pointer to this function.
///Params:
///    pPropertyList = Pointer to the property list in which to locate the value.
///    cbPropertyListSize = Size in bytes of the data included in <i>pPropertyList</i>.
///    pszPropertyName = Pointer to a null-terminated Unicode string containing the name of the value to locate.
///    pszPropertyValue = Pointer to a <b>WCHAR</b> pointer to a buffer (allocated by the function) containing a copy of the property
///                       value. You must call LocalFree (on *<i>pbPropertyValue</i>) to free the allocated memory. If no value is
///                       required, pass <b>NULL</b> for this parameter.
///    pcbPropertyValueSize = Pointer to the size, in bytes, of the value returned. If no size is required, pass <b>NULL</b> for this
///                           parameter.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The property list is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The function could not allocate a buffer in
///    which to return the property value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The specified property could not be located in the property list. </td> </tr>
///    </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindMultiSzProperty(const(void)* pPropertyList, uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                PWSTR* pszPropertyValue, uint* pcbPropertyValueSize);

///Locates a signed long property value in a property list. The <b>PRESUTIL_FIND_LONG_PROPERTY</b> type defines a
///pointer to this function.
///Params:
///    pPropertyList = Pointer to the property list in which to locate the value.
///    cbPropertyListSize = Size in bytes of the data included in <i>pPropertyList</i>.
///    pszPropertyName = Pointer to a null-terminated Unicode string containing the name of the value to locate.
///    plPropertyValue = Pointer to the actual value of the data stored in the property list buffer.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The data is in an incorrect format. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The property could not be located in the
///    property list. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindLongProperty(const(void)* pPropertyList, uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                             int* plPropertyValue);

///Gets a large integer property value from a property list. The <b>PRESUTIL_FIND_ULARGEINTEGER_PROPERTY</b> type
///defines a pointer to this function.
///Params:
///    pPropertyList = A pointer to the property list.
///    cbPropertyListSize = The size of the data in <i>pPropertyList</i>, in bytes.
///    pszPropertyName = The name of the property.
///    plPropertyValue = The value of the property.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. The following is a possible error code.
///    
@DllImport("RESUTILS")
uint ResUtilFindULargeIntegerProperty(const(void)* pPropertyList, uint cbPropertyListSize, 
                                      const(PWSTR) pszPropertyName, ulong* plPropertyValue);

///TBD. The <b>PRESUTIL_FIND_FILETIME_PROPERTY</b> type defines a pointer to this function.
///Params:
///    pPropertyList = 
///    cbPropertyListSize = 
///    pszPropertyName = 
@DllImport("RESUTILS")
uint ResUtilFindFileTimeProperty(const(void)* pPropertyList, uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                 FILETIME* pftPropertyValue);

///Creates a worker thread. The <b>PCLUSAPI_CLUS_WORKER_CREATE</b> type defines a pointer to this function.
///Params:
///    lpWorker = Pointer to a zero-initialized CLUS_WORKER structure that on return is filled in with a handle to the created
///               thread and a flag that indicates whether the handle should be terminated. The caller should never need to refer
///               to or change the members of this structure.
///    lpStartAddress = Pointer to the address of a function that should be called by the worker thread.
///    lpParameter = A parameter to pass to the function whose address is pointed to by <i>lpStartAddress</i>.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ClusWorkerCreate(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, void* lpParameter);

///Determines whether a worker thread should exit as soon as possible. The <b>PCLUSAPIClusWorkerCheckTerminate</b> type
///defines a pointer to this function.
///Params:
///    lpWorker = Pointer to a CLUS_WORKER structure describing the thread to check.
///Returns:
///    <b>ClusWorkerCheckTerminate</b> returns one of the following values. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt> <dt>1</dt> </dl> </td> <td
///    width="60%"> The thread should terminate. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> <dt>0</dt>
///    </dl> </td> <td width="60%"> The thread should not terminate. </td> </tr> </table>
///    
@DllImport("RESUTILS")
BOOL ClusWorkerCheckTerminate(CLUS_WORKER* lpWorker);

///Terminates a worker thread. The [PCLUSAPI_CLUS_WORKER_TERMINATE](nc-resapi-pclusapi_clus_worker_terminate.md) type
///defines a pointer to this function.
///Params:
///    lpWorker = Pointer to a [CLUS_WORKER](ns-resapi-clus_worker.md) structure describing the thread to terminate.
@DllImport("RESUTILS")
void ClusWorkerTerminate(CLUS_WORKER* lpWorker);

///Waits for a worker thread to terminate up to the specified timeout. This function can signal the thread to terminate
///before wait starts, or just wait passively if specified.
///Params:
///    ClusWorker = Pointer to a CLUS_WORKER structure describing the worker thread to terminate.
///    TimeoutInMilliseconds = The timeout in milliseconds.
///    WaitOnly = If set <b>TRUE</b>, the function will wait for up to specified timeout without signaling the thread to terminate;
///               otherwise it will signal the thread to terminate before waiting for the thread.
///Returns:
///    Returns a system error code on failure. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> All worker threads are terminated.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAIT_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The worker
///    thread is not terminated within the specified timeout. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ClusWorkerTerminateEx(CLUS_WORKER* ClusWorker, uint TimeoutInMilliseconds, BOOL WaitOnly);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Waits for multiple worker threads to terminate up to the specified timeout. This function can signal
///the thread to terminate before wait starts, or just wait passively if specified.
///Params:
///    ClusWorkers = Pointer to an array of CLUS_WORKER structures describing the threads to terminate.
///    ClusWorkersCount = The number of structures in the <i>ClusWorkers</i> parameter.
///    TimeoutInMilliseconds = The timeout in milliseconds.
///    WaitOnly = If set <b>TRUE</b>, the function will wait for up to specified timeout without signaling the thread to terminate;
///               otherwise it will signal the thread to terminate before waiting for the thread.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> All worker threads are terminated. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WAIT_TIMEOUT</b></dt> </dl> </td> <td width="60%"> At least one worker thread is not
///    terminated within the specified timeout. </td> </tr> </table> Returns a system error code on failure.
///    
@DllImport("RESUTILS")
uint ClusWorkersTerminate(CLUS_WORKER** ClusWorkers, const(size_t) ClusWorkersCount, uint TimeoutInMilliseconds, 
                          BOOL WaitOnly);

///Tests whether two resource handles represent the same resource. The <b>PRESUTIL_RESOURCES_EQUAL</b> type defines a
///pointer to this function.
///Params:
///    hSelf = Handle to one of the resources.
///    hResource = Handle to the other resource.
///Returns:
///    If the resources are equal, the function returns <b>TRUE</b>. If the resources are not equal, the function
///    returns <b>FALSE</b>.
///    
@DllImport("RESUTILS")
BOOL ResUtilResourcesEqual(_HRESOURCE* hSelf, _HRESOURCE* hResource);

///Tests whether a resource type matches the resource type name of a specified resource. The
///<b>PRESUTIL_RESOURCE_TYPES_EQUAL</b> type defines a pointer to this function.
///Params:
///    lpszResourceTypeName = Pointer to the resource type name to test.
///    hResource = Handle of the resource to test.
///Returns:
///    If the resource types are equal, the function returns <b>TRUE</b>. If the resource types are not equal, the
///    function returns <b>FALSE</b>.
///    
@DllImport("RESUTILS")
BOOL ResUtilResourceTypesEqual(const(PWSTR) lpszResourceTypeName, _HRESOURCE* hResource);

///Tests whether the resource class of a specified resource is equal to a specified resource class. The
///<b>PRESUTIL_IS_RESOURCE_CLASS_EQUAL</b> type defines a pointer to this function.
///Params:
///    prci = Pointer to a CLUS_RESOURCE_CLASS_INFO structure describing the resource class.
///    hResource = Handle to the resource whose class is to be compared to <i>prci</i>.
///Returns:
///    If the resource classes are equal, the function returns <b>TRUE</b>. If the resource classes are not equal, the
///    function returns <b>FALSE</b>.
///    
@DllImport("RESUTILS")
BOOL ResUtilIsResourceClassEqual(CLUS_RESOURCE_CLASS_INFO* prci, _HRESOURCE* hResource);

///Enumerates all of the resources in the local cluster and initiates a user-defined operation for each resource. The
///<b>PRESUTIL_ENUM_RESOURCES</b> type defines a pointer to this function.
///Params:
///    hSelf = Optional handle to a cluster resource. The callback function is not invoked for a resource identified by
///            <i>hSelf</i>.
///    lpszResTypeName = Optional pointer to a name of a resource type that narrows the scope of resources to enumerate. If
///                      <i>lpszResTypeName</i> is specified, only resources of the specified type are enumerated.
///    pResCallBack = Pointer to a user-defined function which will be called for each enumerated resource. This function must conform
///                   to the definition of the ResourceCallback callback function (note that parameter names are not part of the
///                   definition; they have been added here for clarity): <pre class="syntax" xml:space="preserve"><code>DWORD
///                   (*LPRESOURCE_CALLBACK)( HRESOURCE hSelf, HRESOURCE hEnum, PVOID pParameter );</code></pre>
///    pParameter = A generic buffer that allows you to pass any kind of data to the callback function. <b>ResUtilEnumResources</b>
///                 does not use this parameter at all, it merely passes the pointer to the callback function. Whether you can pass
///                 <b>NULL</b> for the parameter depends on how the callback function is implemented.
///Returns:
///    If the operation succeeds or if <i>pResCallBack</i> returns <b>ERROR_NO_MORE_ITEMS</b>, the function returns
///    <b>ERROR_SUCCESS</b>. If the operation fails, the function immediately halts the enumeration and returns the
///    value returned by the callback function.
///    
@DllImport("RESUTILS")
uint ResUtilEnumResources(_HRESOURCE* hSelf, const(PWSTR) lpszResTypeName, LPRESOURCE_CALLBACK pResCallBack, 
                          void* pParameter);

///Enumerates all of the resources in a specified cluster and initiates a user-defined operation for each resource. The
///<b>PRESUTIL_ENUM_RESOURCES_EX</b> type defines a pointer to this function.
///Params:
///    hCluster = A handle to the cluster that contains the resources to enumerate.
///    hSelf = An optional handle to a cluster resource. The callback function is not invoked for a resource that is identified
///            by <i>hSelf</i>.
///    lpszResTypeName = An optional pointer to a name of a resource type that narrows the scope of resources to enumerate. If
///                      <i>lpszResTypeName</i> is specified, only resources of the specified type are enumerated.
///    pResCallBack = A pointer to a user-defined function that is called for each enumerated resource. This function must conform to
///                   the definition of the ResourceCallbackEx callback function. Note that parameter names are not part of the
///                   definition; they have been added here for clarity. <pre class="syntax" xml:space="preserve"><code>DWORD
///                   (*LPRESOURCE_CALLBACK_EX)( HCLUSTER hCluster, HRESOURCE hSelf, HRESOURCE hEnum, PVOID pParameter );</code></pre>
///    pParameter = A generic buffer that enables you to pass any kind of data to the callback function.
///                 <b>ResUtilEnumResourcesEx</b> does not use this parameter at all; it merely passes the pointer to the callback
///                 function. Whether you can pass <b>NULL</b> for the parameter depends on how the callback function is implemented.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    immediately halts the enumeration and returns the value that is returned by the callback function.
///    
@DllImport("RESUTILS")
uint ResUtilEnumResourcesEx(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(PWSTR) lpszResTypeName, 
                            LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);

///Enumerates the dependencies of a specified resource and returns a handle to a dependency of a specified type. The
///<b>PRESUTIL_GET_RESOURCE_DEPENDENCY</b> type defines a pointer to this function.
///Params:
///    hSelf = Handle to the dependent resource. This resource depends on one or more resources.
///    lpszResourceType = Null-terminated Unicode string specifying the resource type of the dependency to return.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource specified
///    by <i>hSelf</i> depends. The caller is responsible for closing the handle by calling CloseClusterResource. If the
///    operation fails, the function returns <b>NULL</b>. For more information, call the GetLastError function.
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependency(HANDLE hSelf, const(PWSTR) lpszResourceType);

///Enumerates the dependencies of a specified resource in a specified cluster and returns a handle to a dependency of a
///specified type. The <b>PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME</b> type defines a pointer to this function.
///Params:
///    hCluster = Handle to the cluster to which the resource belongs.
///    hSelf = Handle to the dependent resource. This resource depends on one or more resources.
///    lpszResourceType = NULL-terminated Unicode string specifying the resource type of the dependency to return.
///    bRecurse = Determines the scope of the search. If <b>TRUE</b>, the function checks the entire dependency tree under the
///               dependent resource. If <b>FALSE</b>, the function checks only the resources on which the dependent resource
///               directly depends.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource specified
///    by <i>hSelf</i> depends. The caller is responsible for closing the handle by calling CloseClusterResource. If the
///    operation fails, the function returns <b>NULL</b>. For more information, call the GetLastError function. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESOURCE</b></dt> </dl>
///    </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>NULL</b></b></dt> </dl> </td> <td
///    width="60%"> The operation was not successful. For more information, call the function GetLastError. </td> </tr>
///    </table>
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByName(_HCLUSTER* hCluster, HANDLE hSelf, const(PWSTR) lpszResourceType, 
                                               BOOL bRecurse);

///Enumerates the dependencies of a specified resource in a specified cluster and returns a handle to a dependency that
///matches a specified resource class. The <b>PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS</b> type defines a pointer to
///this function.
///Params:
///    hCluster = Handle to the cluster to which the resource belongs.
///    hSelf = Handle to the dependent resource. This resource depends on one or more resources.
///    prci = Pointer to a CLUS_RESOURCE_CLASS_INFO structure describing the resource class of the dependency to return.
///    bRecurse = Determines the scope of the search. If <b>TRUE</b>, the function checks the entire dependency tree under the
///               dependent resource. If <b>FALSE</b>, the function checks only the resources on which the dependent resource
///               directly depends.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource specified
///    by <i>hSelf</i> depends. The caller is responsible for closing the handle by calling CloseClusterResource. If the
///    operation fails, the function returns <b>NULL</b>. For more information, call the GetLastError function.
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByClass(_HCLUSTER* hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, 
                                                BOOL bRecurse);

///Enumerates the dependencies of a specified resource in the local cluster and returns a handle to a dependency of a
///specified resource type. The <b>PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY</b> type defines a pointer to this function.
///Params:
///    lpszResourceName = Null-terminated Unicode string specifying the name of the dependent resource. This resource depends on one or
///                       more resources.
///    lpszResourceType = Null-terminated Unicode string specifying the resource type of the dependency to return.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource specified
///    by <i>lpszResourceName</i> depends. The caller is responsible for closing the handle by calling
///    CloseClusterResource. If the operation fails, the function returns <b>NULL</b>. For more information, call the
///    function GetLastError.
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceNameDependency(const(PWSTR) lpszResourceName, const(PWSTR) lpszResourceType);

///Retrieves the private properties of the first IP Address dependency found for a specified resource. The
///<b>PRESUTIL_GET_RESOURCE_DEPENDENTIP_ADDRESS_PROPS</b> type defines a pointer to this function.
///Params:
///    hResource = Handle to the resource to query for dependencies.
///    pszAddress = Output buffer for returning the value of the Address private property.
///    pcchAddress = On input, specifies the size of the <i>pszAddress</i> buffer as a count of <b>WCHAR</b>s. On output, specifies
///                  the size of the resulting data as a count of <b>WCHAR</b>s that includes the terminating <b>NULL</b>.
///    pszSubnetMask = Output buffer for returning the value of the SubnetMask private property.
///    pcchSubnetMask = On input, specifies the size of the <i>pszSubnetMask</i> buffer as a count of <b>WCHAR</b>s. On output, specifies
///                     the size of the resulting data as a count of <b>WCHAR</b>s that includes the terminating <b>NULL</b>.
///    pszNetwork = Output buffer for returning the value of the Network private property.
///    pcchNetwork = On input, specifies the size of the <i>pszNetwork</i> buffer as a count of <b>WCHAR</b>s. On output, specifies
///                  the size of the resulting data as a count of <b>WCHAR</b>s that includes the terminating <b>NULL</b>. <b>Windows
///                  Server 2008 R2 and Windows Server 2008: </b>This parameter is named <i>pcch</i> prior to Windows Server 2012.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> <dt>259 (0x103)</dt>
///    </dl> </td> <td width="60%"> No IP Address dependency was found in the specified resource's list of dependencies.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_NOT_PRESENT</b></dt> <dt>4316 (0x10DC)</dt> </dl>
///    </td> <td width="60%"> No IP Address dependency was found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> <dt>234 (0xEA)</dt> </dl> </td> <td width="60%"> The size of one of the buffers
///    was too small to hold the resulting data. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilGetResourceDependentIPAddressProps(_HRESOURCE* hResource, PWSTR pszAddress, uint* pcchAddress, 
                                               PWSTR pszSubnetMask, uint* pcchSubnetMask, PWSTR pszNetwork, 
                                               uint* pcchNetwork);

///Retrieves the drive letter associated with a Physical Disk dependency of a resource. The
///<b>PRESUTIL_FIND_DEPENDENT_DISK_RESOURCE_DRIVE_LETTER</b> type defines a pointer to this function.
///Params:
///    hCluster = Cluster handle.
///    hResource = Handle to the resource to query for dependencies.
///    pszDriveLetter = Buffer in which to store the drive letter.
///    pcchDriveLetter = On input, specifies the size of the <i>pszDriveLetter</i> buffer as a count of <b>WCHAR</b>s. On output,
///                      specifies the size of the resulting data as a count of <b>WCHAR</b>s that includes the terminating <b>NULL</b>.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b> (0). If the operation fails, the function
///    returns a system error code. The following are possible error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td
///    width="60%"> No Physical Disk dependency was found in the specified resource's list of dependencies. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> No drive
///    letter could be returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The buffer passed in was too small. The <i>pcchDriveLetter</i> parameter specifies the required
///    size. </td> </tr> </table>
///    
@DllImport("RESUTILS")
uint ResUtilFindDependentDiskResourceDriveLetter(_HCLUSTER* hCluster, _HRESOURCE* hResource, PWSTR pszDriveLetter, 
                                                 uint* pcchDriveLetter);

///Attempts to terminate the process of a service being managed as a cluster resource by a resource DLL. The
///<b>PRESUTIL_TERMINATE_SERVICE_PROCESS_FROM_RES_DLL</b> type defines a pointer to this function.
///Params:
///    dwServicePid = The process ID of the service process to terminate.
///    bOffline = Indicates whether the resource is being taken offline or is being terminated. Specify <b>TRUE</b> if calling from
///               the Offline entry point or from a worker thread created to take the resource offline. Otherwise specify
///               <b>FALSE</b> and the function will assume you are terminating the resource.
///    pdwResourceState = Optional pointer to a <b>DWORD</b> which returns the resulting state of the resource, which will be either
///                       <b>ClusterResourceFailed</b> or <b>ClusterResourceOffline</b> (for a complete list of resource states see
///                       GetClusterResourceState). Pass <b>NULL</b> if you don't need this information.
///    pfnLogEvent = Pointer to the LogEvent function used by your resource DLL. This pointer is passed to your resource DLL in the
///                  Startup entry point.
///    hResourceHandle = The Resource Monitor's handle to the resource. This handle is passed to your resource DLL in the Open entry point
///                      and must be saved as part of the resource's instance data.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code. Note that <b>ResUtilTerminateServiceProcessFromResDll</b> uses <i>pfnLogEvent</i>
///    and <i>hResourceHandle</i> to write to your resource DLL's event log, which may help troubleshoot failures.
///    
@DllImport("RESUTILS")
uint ResUtilTerminateServiceProcessFromResDll(uint dwServicePid, BOOL bOffline, uint* pdwResourceState, 
                                              PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

///Returns a property format list describing the format of a specified set of properties. The
///<b>PRESUTIL_GET_PROPERTY_FORMATS</b> type defines a pointer to this function.
///Params:
///    pPropertyTable = Pointer to a RESUTIL_PROPERTY_ITEM property table specifying the properties whose formats are to be retrieved.
///    pOutPropertyFormatList = On input, pointer to a buffer. On a successful return, pointer to a property format list describing the format of
///                             each property specified by <i>pPropertyTable</i>.
///    cbPropertyFormatListSize = Specifies the allocated size (in bytes) of the buffer pointed to by <i>pOutPropertyFormatList</i>.
///    pcbBytesReturned = Pointer to the actual size (in bytes) of the property format list that results from the operation.
///    pcbRequired = If the buffer pointed to by the <i>pOutPropertyFormatList</i> parameter is too small to hold the resulting data,
///                  <i>pcbRequired</i> points to the required buffer size (in bytes).
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation was successful.
///    
@DllImport("RESUTILS")
uint ResUtilGetPropertyFormats(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* pOutPropertyFormatList, 
                               uint cbPropertyFormatListSize, uint* pcbBytesReturned, uint* pcbRequired);

///Returns handles to the core Network Name, IP Address and quorum resources. The
///<b>PRESUTIL_GET_CORE_CLUSTER_RESOURCES</b> type defines a pointer to this function.
///Params:
///    hCluster = Cluster handle (see OpenCluster).
///    phClusterNameResource = Pointer to a resource handle to the core Network Name resource for the cluster, which stores the cluster name.
///    phClusterIPAddressResource = Not used.
///    phClusterQuorumResource = Pointer to a resource handle to the cluster's quorum resource.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilGetCoreClusterResources(_HCLUSTER* hCluster, _HRESOURCE** phClusterNameResource, 
                                    _HRESOURCE** phClusterIPAddressResource, _HRESOURCE** phClusterQuorumResource);

///Returns the name of a resource. The <b>PRESUTIL_GET_RESOURCE_NAME</b> type defines a pointer to this function.
///Params:
///    hResource = Resource handle (see OpenClusterResource).
///    pszResourceName = Pointer to a buffer that receives the resource name.
///    pcchResourceNameInOut = On input, specifies the size of the buffer pointed to by <i>pszResourceName</i>, in wide characters. On output,
///                            specifies the actual size of the resource name returned as a count of wide characters.
@DllImport("RESUTILS")
uint ResUtilGetResourceName(_HRESOURCE* hResource, PWSTR pszResourceName, uint* pcchResourceNameInOut);

///Determines whether or not a specific role has been assigned to a cluster.
///Params:
///    hCluster = The handle of the queried cluster.
///    eClusterRole = The role the cluster was queried about. The possible values for this parameter are enumerators from the
///                   CLUSTER_ROLE enumeration. The following values are valid.
///Returns:
///    The possible return values for this function are enumerators from the CLUSTER_ROLE_STATE enumeration. The
///    following values are valid. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ClusterRoleUnknown</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> It is unknown
///    whether or not the role is clustered. If this value is returned then an error has occurred. For more information
///    call GetLastError. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ClusterRoleClustered</b></dt> <dt>0</dt> </dl>
///    </td> <td width="60%"> The role is clustered. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ClusterRoleUnclustered</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The role is not clustered. </td>
///    </tr> </table>
///    
@DllImport("RESUTILS")
CLUSTER_ROLE_STATE ResUtilGetClusterRoleState(_HCLUSTER* hCluster, CLUSTER_ROLE eClusterRole);

///Determines whether a path is on a cluster shared volume (CSV). This is used to determine whether
///ClusterGetVolumeNameForVolumeMountPoint or ClusterGetVolumePathName should be called instead of
///GetVolumeNameForVolumeMountPoint or GetVolumePathName. The <b>PCLUSTER_IS_PATH_ON_SHARED_VOLUME</b> type defines a
///pointer to this function.
///Params:
///    lpszPathName = A pointer to the input path string.
///Returns:
///    <b>TRUE</b> if the path is on a CSV and this function is called from a domain account, or if the path is on a CSV
///    that is owned by a local cluster node; otherwise, <b>FALSE</b>.
///    
@DllImport("RESUTILS")
BOOL ClusterIsPathOnSharedVolume(const(PWSTR) lpszPathName);

///<p class="CCE_Message">[<b>ClusterGetVolumePathName</b> is available for use in the operating systems specified in
///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use GetVolumePathName.]
///Retrieves the volume mount point on the cluster where the specified path is mounted.
///Params:
///    lpszFileName = A pointer to the input path string. Both absolute and relative file and directory names, for example "..", are
///                   acceptable in this path. If you specify a relative directory or file name without a volume qualifier,
///                   <b>ClusterGetVolumePathName</b> returns the drive letter of the current volume. If this parameter is an empty
///                   string, "", the function fails but the last error is set to <b>ERROR_SUCCESS</b>.
///    lpszVolumePathName = A pointer to a string that receives the volume mount point for the input path.
///    cchBufferLength = The length of the output buffer, in <b>WCHARs</b>.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("RESUTILS")
BOOL ClusterGetVolumePathName(const(PWSTR) lpszFileName, PWSTR lpszVolumePathName, uint cchBufferLength);

///<p class="CCE_Message">[<b>ClusterGetVolumeNameForVolumeMountPoint</b> is available for use in the operating systems
///specified in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
///GetVolumeNameForVolumeMountPoint.] Retrieves a cluster volume <b>GUID</b> path for the volume that is associated with
///the specified cluster shared volume (CSV) mount point (drive letter, volume <b>GUID</b> path, or mounted folder).
///Params:
///    lpszVolumeMountPoint = A pointer to a string that contains the path of a mounted folder (for example, "Y:\MountX\") or a drive letter
///                           (for example, "X:\"). The string must end with a trailing backslash (\\).
///    lpszVolumeName = A pointer to a string that receives the volume <b>GUID</b> path. This path is of the form
///                     "\\?\Volume{<i>GUID</i>}\" where <i>GUID</i> is a <b>GUID</b> that identifies the volume. If there is more than
///                     one volume <b>GUID</b> path for the volume, only the first one in the mount manager's cache is returned. The
///                     string returned is in the format required for IVssBackupComponents::AddToSnapshotSet and
///                     IVssBackupComponents::IsVolumeSupported.
///    cchBufferLength = The length of the output buffer, in <b>WCHARs</b>. A reasonable size for the buffer to accommodate the largest
///                      possible volume <b>GUID</b> path is 51 characters.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. If the input CSV is not locally mounted the call will fail with an
///    <b>ERROR_CSV_VOLUME_NOT_LOCAL</b> (5951) error.
///    
@DllImport("RESUTILS")
BOOL ClusterGetVolumeNameForVolumeMountPoint(const(PWSTR) lpszVolumeMountPoint, PWSTR lpszVolumeName, 
                                             uint cchBufferLength);

///<p class="CCE_Message">[<b>ClusterPrepareSharedVolumeForBackup</b> is available for use in the operating systems
///specified in the Requirements section. It may be altered or unavailable in subsequent versions.] A call to this
///function is not required. The function does not do anything other than retrieve the volume path and the volume name.
///<b>Windows Server 2008 R2: </b>Prepares a cluster shared volume (CSV) for backup. This will mount the CSV locally,
///pin it to this cluster node, disable direct I/O, and set the volume state to "Backup in Progress".
///Params:
///    lpszFileName = Path to a directory or file on a cluster shared volume.
///    lpszVolumePathName = Address of buffer that will receive the CSV reparse point.
///    lpcchVolumePathName = Address of a <b>DWORD</b> that on input contains the size of the buffer (in <b>WCHAR</b> characters) pointed to
///                          by the <i>lpszVolumePathName</i> parameter and on output contains the size of the string written to that buffer.
///                          If size on input is not large enough then the function will fail and return <b>ERROR_MORE_DATA</b> and set the
///                          <b>DWORD</b> to the required size.
///    lpszVolumeName = Address of buffer that will receive the volume GUID path for the CSV.
///    lpcchVolumeName = Address of a <b>DWORD</b> that on input contains the size of the buffer (in <b>WCHAR</b> characters) pointed to
///                      by the <i>lpszVolumeName</i> parameter and on output contains the size of the string written to that buffer. If
///                      size on input is not large enough then the function will fail and return <b>ERROR_MORE_DATA</b> and set the
///                      <b>DWORD</b> to the required size.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the system
///    error codes.
///    
@DllImport("RESUTILS")
uint ClusterPrepareSharedVolumeForBackup(const(PWSTR) lpszFileName, PWSTR lpszVolumePathName, 
                                         uint* lpcchVolumePathName, PWSTR lpszVolumeName, uint* lpcchVolumeName);

///Clears the backup state for the cluster shared volume (CSV). The <b>PCLUSTER_CLEAR_BACKUP_STATE_FOR_SHARED_VOLUME</b>
///type defines a pointer to this function.
///Params:
///    lpszVolumePathName = Path to a file on a CSV. If the path is not a CSV path, <b>ClusterClearBackupStateForSharedVolume</b> will return
///                         <b>ERROR_INVALID_PARAMETER</b> (87).
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b> (0). If the function fails, it returns one of the
///    system error codes.
///    
@DllImport("RESUTILS")
uint ClusterClearBackupStateForSharedVolume(const(PWSTR) lpszVolumePathName);

///Adjusts the start parameters of a specified service so that it operates correctly as a cluster resource. It must be
///called from a resource DLL. The <b>PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS_EX</b> type defines a pointer to
///this function.
///Params:
///    pszServiceName = A pointer to a null-terminated Unicode string that specifies the name of the service.
///    schSCMHandle = A handle to the Service Control Manager (SCM) or <b>NULL</b>. If <b>NULL</b>, the function attempts to open a
///                   handle to the SCM.
///    phService = On input, a <b>NULL</b> service handle. On output, handle to the specified service if the call was successful;
///                otherwise <b>NULL</b>.
///    dwDesiredAccess = The requested access privileges. This might be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0), an undefined
///                      error might be returned. Using <b>GENERIC_ALL</b> is the same as calling
///                      ResUtilSetResourceServiceStartParameters.
///    pfnLogEvent = A pointer to the LogEvent entry point function of the resource DLL that manages the service.
///    hResourceHandle = A resource handle that is required by the LogEvent entry point function. Use the handle that is passed to the DLL
///                      in the Open entry point function.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilSetResourceServiceStartParametersEx(const(PWSTR) pszServiceName, SC_HANDLE__* schSCMHandle, 
                                                SC_HANDLE__** phService, uint dwDesiredAccess, 
                                                PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

///Enumerates all of the resources in a specified cluster and initiates a user-defined operation for each resource. The
///<b>PRESUTIL_ENUM_RESOURCES_EX2</b> type defines a pointer to this function.
///Params:
///    hCluster = A handle to the cluster that contains the resources to enumerate.
///    hSelf = An optional handle to a cluster resource. The callback function is not invoked for a resource identified by
///            <i>hSelf</i>.
///    lpszResTypeName = An optional pointer to a name of a resource type that narrows the scope of resources to enumerate. If
///                      <i>lpszResTypeName</i> is specified, only resources of the specified type are enumerated.
///    pResCallBack = A pointer to a user-defined function which will be called for each enumerated resource. This function must
///                   conform to the definition of the ResourceCallbackEx callback function (note that parameter names are not part of
///                   the definition; they have been added here for clarity): <pre class="syntax" xml:space="preserve"><code>DWORD
///                   (*LPRESOURCE_CALLBACK_EX)( HCLUSTER hCluster, HRESOURCE hSelf, HRESOURCE hEnum, PVOID pParameter );</code></pre>
///    pParameter = A generic buffer that allows you to pass any kind of data to the callback function. ResUtilEnumResourcesEx does
///                 not use this parameter at all, it merely passes the pointer to the callback function. Whether or not you can pass
///                 <b>NULL</b> for the parameter depends on how the callback function is implemented.
///    dwDesiredAccess = The requested access privileges. This may be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or M<b>AXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0), an undefined
///                      error may be returned. Using <b>GENERIC_ALL</b> is the same as calling ResUtilEnumResourcesEx.
///Returns:
///    If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    immediately halts the enumeration and returns the value returned by the callback function.
///    
@DllImport("RESUTILS")
uint ResUtilEnumResourcesEx2(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(PWSTR) lpszResTypeName, 
                             LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter, uint dwDesiredAccess);

///Enumerates the dependencies of a specified resource and returns a handle to a dependency of a specified type. The
///<b>PRESUTIL_GET_RESOURCE_DEPENDENCY_EX</b> type defines a pointer to this function.
///Params:
///    hSelf = A handle to the dependent resource.
///    lpszResourceType = A null-terminated Unicode string that specifies the resource type of the dependency to return.
///    dwDesiredAccess = The requested access privileges. This might be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0), an undefined
///                      error might be returned. Using <b>GENERIC_ALL</b> is the same as calling ResUtilGetResourceDependency.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource that is
///    specified by <i>hSelf</i> depends. The caller is responsible for closing the handle by calling the
///    CloseClusterResource function. If the operation fails, the function returns <b>NULL</b>. For more information,
///    call the GetLastError function.
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyEx(HANDLE hSelf, const(PWSTR) lpszResourceType, uint dwDesiredAccess);

///Enumerates the dependencies of a specified resource in a specified cluster and returns a handle to a dependency of a
///specified type. The <b>PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME_EX</b> type defines a pointer to this function.
///Params:
///    hCluster = A handle to the cluster to which the resource belongs.
///    hSelf = A handle to the dependent resource. This resource depends on one or more resources.
///    lpszResourceType = A null-terminated Unicode string that specifies the resource type of the dependency to return.
///    bRecurse = Determines the scope of the search. If <b>TRUE</b>, the function checks the entire dependency tree under the
///               dependent resource. If <b>FALSE</b>, the function checks only the resources on which the dependent resource
///               directly depends.
///    dwDesiredAccess = The requested access privileges. This might be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0), an undefined
///                      error might be returned. Using <b>GENERIC_ALL</b> is the same as calling ResUtilGetResourceDependencyByName.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource that is
///    specified by <i>hSelf</i> depends. The caller is responsible for closing the handle by calling
///    CloseClusterResource. If the operation fails, the function returns <b>NULL</b>. For more information, call the
///    GetLastError function. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESOURCE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b><b>NULL</b></b></dt> </dl> </td> <td width="60%"> The operation was not successful. For more information,
///    call the function GetLastError. </td> </tr> </table>
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByNameEx(_HCLUSTER* hCluster, HANDLE hSelf, const(PWSTR) lpszResourceType, 
                                                 BOOL bRecurse, uint dwDesiredAccess);

///Enumerates the dependencies of a specified resource in a specified cluster and returns a handle to a dependency that
///matches a specified resource class. The <b>PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS_EX</b> type defines a pointer to
///this function.
///Params:
///    hCluster = A handle to the cluster to which the resource belongs.
///    hSelf = A handle to the dependent resource. This resource depends on one or more resources.
///    prci = A pointer to a PCLUS_RESOURCE_CLASS_INFO structure that describes the resource class of the dependency to return.
///    bRecurse = Determines the scope of the search. If <b>TRUE</b>, the function checks the entire dependency tree under the
///               dependent resource. If <b>FALSE</b>, the function checks only the resources on which the dependent resource
///               directly depends.
///    dwDesiredAccess = The requested access privileges. This might be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0), an undefined
///                      error might be returned. Using <b>GENERIC_ALL</b> is the same as calling ResUtilGetResourceDependencyByClass.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource that is
///    specified by <i>hSelf</i> depends. The caller is responsible for closing the handle by calling
///    CloseClusterResource. If the operation fails, the function returns <b>NULL</b>. For more information, call the
///    GetLastError function.
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByClassEx(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                  CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse, 
                                                  uint dwDesiredAccess);

///Enumerates the dependencies of a specified resource in the local cluster and returns a handle to a dependency of a
///specified resource type. The <b>PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY_EX</b> type defines a pointer to this function.
///Params:
///    lpszResourceName = A null-terminated Unicode string that specifies the name of the dependent resource. This resource depends on one
///                       or more resources.
///    lpszResourceType = A null-terminated Unicode string that specifies the resource type of the dependency to return.
///    dwDesiredAccess = The requested access privileges. This might be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or <b>MAXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0), an undefined
///                      error might be returned. Using <b>GENERIC_ALL</b> is the same as calling ResUtilGetResourceNameDependency.
///Returns:
///    If the operation succeeds, the function returns a handle to one of the resources on which the resource that is
///    specified by <i>lpszResourceName</i> depends. The caller is responsible for closing the handle by calling
///    CloseClusterResource. If the operation fails, the function returns <b>NULL</b>. For more information, call the
///    function GetLastError.
///    
@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceNameDependencyEx(const(PWSTR) lpszResourceName, const(PWSTR) lpszResourceType, 
                                               uint dwDesiredAccess);

///Returns handles to the core, Network Name, IP Address, and quorum resources. The
///<b>PRESUTIL_GET_CORE_CLUSTER_RESOURCES_EX</b> type defines a pointer to this function.
///Params:
///    hClusterIn = The cluster handle (see OpenCluster).
///    phClusterNameResourceOut = A pointer to a resource handle to the core Network Name resource for the cluster, which stores the cluster name.
///    phClusterQuorumResourceOut = Not used.
///    dwDesiredAccess = The requested access privileges. This might be any combination of <b>GENERIC_READ</b> (0x80000000),
///                      <b>GENERIC_ALL</b> (0x10000000), or M<b>AXIMUM_ALLOWED</b> (0x02000000). If this value is zero (0), an undefined
///                      error might be returned. Using <b>GENERIC_ALL</b> is the same as calling ResUtilGetCoreClusterResources.
///Returns:
///    If the operations succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails, the function
///    returns a system error code.
///    
@DllImport("RESUTILS")
uint ResUtilGetCoreClusterResourcesEx(_HCLUSTER* hClusterIn, _HRESOURCE** phClusterNameResourceOut, 
                                      _HRESOURCE** phClusterQuorumResourceOut, uint dwDesiredAccess);

///Opens a handle to a Cryptographic Service Provider (CSP) in order to manage the encryption of Checkpointing data for
///a cluster resource. The <b>POPEN_CLUSTER_CRYPT_PROVIDER</b> type defines a pointer to this function.
///Params:
///    lpszResource = A pointer to a null-terminated Unicode string that contains the name of the cluster resource that is associated
///                   with the Checkpointing data.
///    lpszProvider = A pointer to a null-terminated Unicode string that contains the name of the CSP.
///    dwType = A bitmask that specifies the CSP type. This parameter can be set to one of the following values:
///    dwFlags = The flags that specify the settings for the operation. This parameter can be set to the default value "0", or
///              <b>CLUS_CREATE_CRYPT_CONTAINER_NOT_FOUND</b> (0x0001).
///Returns:
///    If the operation completes successfully, this function returns a HCLUSCRYPTPROVIDER structure containing a handle
///    to the CSP.
///    
@DllImport("RESUTILS")
_HCLUSCRYPTPROVIDER* OpenClusterCryptProvider(const(PWSTR) lpszResource, byte* lpszProvider, uint dwType, 
                                              uint dwFlags);

@DllImport("RESUTILS")
_HCLUSCRYPTPROVIDER* OpenClusterCryptProviderEx(const(PWSTR) lpszResource, const(PWSTR) lpszKeyname, 
                                                byte* lpszProvider, uint dwType, uint dwFlags);

///Closes a handle to a Cryptographic Service Provider (CSP). The <b>PCLOSE_CLUSTER_CRYPT_PROVIDER</b> type defines a
///pointer to this function.
///Params:
///    hClusCryptProvider = A HCLUSCRYPTPROVIDER structure that contains a handle to a CSP.
///Returns:
///    If the operation completes successfully, this function returns <b>ERROR_SUCCESS</b>; otherwise, it returns a
///    system error code.
///    
@DllImport("RESUTILS")
uint CloseClusterCryptProvider(_HCLUSCRYPTPROVIDER* hClusCryptProvider);

///Encrypts Checkpointing data for a Cryptographic Service Provider (CSP).
///Params:
///    hClusCryptProvider = A HCLUSCRYPTPROVIDER structure that contains a handle to the CSP.
///    pData = A pointer to the data to encrypt.
///    cbData = The total number of bytes in the data pointed to by the <i>pDta</i> parameter.
///    ppData = A pointer to a buffer that receives the encrypted data.
///    pcbData = The total number of bytes in the data pointed to by the <i>pcbData</i> parameter.
///Returns:
///    If the operation completes successfully, this function returns <b>ERROR_SUCCESS</b>; otherwise, it returns a
///    system error code.
///    
@DllImport("RESUTILS")
uint ClusterEncrypt(_HCLUSCRYPTPROVIDER* hClusCryptProvider, ubyte* pData, uint cbData, ubyte** ppData, 
                    uint* pcbData);

///Decrypts Checkpointing data for a Cryptographic Service Provider (CSP).
///Params:
///    hClusCryptProvider = A HCLUSCRYPTPROVIDER structure that contains a handle to the CSP.
///    pCryptInput = A pointer to the data to decrypt.
///    cbCryptInput = The total number of bytes in the data pointed to by the <i>pCryptInput</i> parameter.
///    ppCryptOutput = A pointer to a buffer that receives the decrypted data.
///    pcbCryptOutput = The total number of bytes in the data pointed to by the <i>ppCryptOutput</i> parameter.
///Returns:
///    If the operation completes successfully, this function returns <b>ERROR_SUCCESS</b>; otherwise, it returns a
///    system error code.
///    
@DllImport("RESUTILS")
uint ClusterDecrypt(_HCLUSCRYPTPROVIDER* hClusCryptProvider, ubyte* pCryptInput, uint cbCryptInput, 
                    ubyte** ppCryptOutput, uint* pcbCryptOutput);

///TBD
///Params:
///    pCryptInfo = TBD
///Returns:
///    If the operation completes successfully, this function returns <b>ERROR_SUCCESS</b>; otherwise, it returns a
///    system error code.
///    
@DllImport("RESUTILS")
uint FreeClusterCrypt(void* pCryptInfo);

///Compares two Paxos tags and indicates whether they have the same values.
///Params:
///    left = The PaxosTagCStruct structure that represents the first Paxos tag to use in the comparison.
///    right = The PaxosTagCStruct structure that represents the second Paxos tag to use in the comparison.
///Returns:
///    <b>TRUE</b> if the Paxos tags have the same values; otherwise <b>FALSE</b>.
///    
@DllImport("RESUTILS")
BOOL ResUtilPaxosComparer(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

///Indicates whether a specified Paxos tag contains older cluster configuration information than another specified Paxos
///tag.
///Params:
///    left = The PaxosTagCStruct structure that represents the first Paxos tag to use in the comparison.
///    right = The PaxosTagCStruct structure that represents the 2nd Paxos tag to use in the comparison.
///Returns:
///    <b>TRUE</b> if the cluster configuration of the first Paxos tag is older than the that of the second Paxos tag;
///    otherwise <b>FALSE</b>.
///    
@DllImport("RESUTILS")
BOOL ResUtilLeftPaxosIsLessThanRight(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

@DllImport("RESUTILS")
uint ResUtilsDeleteKeyTree(HKEY key, const(PWSTR) keyName, BOOL treatNoKeyAsError);

@DllImport("RESUTILS")
uint ResUtilGroupsEqual(_HGROUP* hSelf, _HGROUP* hGroup, BOOL* pEqual);

@DllImport("RESUTILS")
uint ResUtilEnumGroups(_HCLUSTER* hCluster, _HGROUP* hSelf, LPGROUP_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS")
uint ResUtilEnumGroupsEx(_HCLUSTER* hCluster, _HGROUP* hSelf, CLUSGROUP_TYPE groupType, 
                         LPGROUP_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS")
uint ResUtilDupGroup(_HGROUP* group, _HGROUP** copy);

@DllImport("RESUTILS")
uint ResUtilGetClusterGroupType(_HGROUP* hGroup, CLUSGROUP_TYPE* groupType);

@DllImport("RESUTILS")
_HGROUP* ResUtilGetCoreGroup(_HCLUSTER* hCluster);

@DllImport("RESUTILS")
uint ResUtilResourceDepEnum(_HRESOURCE* hSelf, uint enumType, LPRESOURCE_CALLBACK_EX pResCallBack, 
                            void* pParameter);

@DllImport("RESUTILS")
uint ResUtilDupResource(_HRESOURCE* group, _HRESOURCE** copy);

@DllImport("RESUTILS")
uint ResUtilGetClusterId(_HCLUSTER* hCluster, GUID* guid);

@DllImport("RESUTILS")
uint ResUtilNodeEnum(_HCLUSTER* hCluster, LPNODE_CALLBACK pNodeCallBack, void* pParameter);

///Registers the <i>AppInstance</i> ID for a process.
///Params:
///    ProcessHandle = A process handle for the current process or a remote process to be tagged with the <i>AppInstanceId</i>. To tag a
///                    remote process, the handle must have <b>PROCESS_TERMINATE</b> access to that process.
///    AppInstanceId = The application instance ID, which is a <b>GUID</b>.
///    ChildrenInheritAppInstance = <b>TRUE</b> to tag the child processes spawned by the process specified by <i>ProcessHandle</i>; otherwise,
///                                 <b>FALSE</b>.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The CCF Filter failed to allocate the proper
///    cache objects to fulfill this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The current process that's trying to tag the
///    process specified by <i>ProcessHandle</i> doesn't have <b>PROCESS_TERMINATE</b> access to that process. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    <i>ProcessHandle</i> is not a handle to a process. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The CCF mini-filter is not found. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_OBJECT_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> Another
///    <i>AppInstance</i><b>GUID</b> is provided for the same process, which means that the RegisterAppInstance function
///    was called twice or the application was registered twice. </td> </tr> </table>
///    
@DllImport("NTLANMAN")
uint RegisterAppInstance(HANDLE ProcessHandle, GUID* AppInstanceId, BOOL ChildrenInheritAppInstance);

@DllImport("NTLANMAN")
uint RegisterAppInstanceVersion(GUID* AppInstanceId, ulong InstanceVersionHigh, ulong InstanceVersionLow);

@DllImport("NTLANMAN")
uint QueryAppInstanceVersion(GUID* AppInstanceId, ulong* InstanceVersionHigh, ulong* InstanceVersionLow, 
                             NTSTATUS* VersionStatus);

@DllImport("NTLANMAN")
uint ResetAllAppInstanceVersions();

///Sets the flags that affect connections from the application instance.
///Params:
///    ProcessHandle = A process handle for the current process or a remote process to be tagged with the application instance. To tag a
///                    remote process, the handle must have <b>PROCESS_TERMINATE</b> access to that process.
///    Mask = A bitmask that indicates the flags that are modified by the <i>Flags</i> parameter.
///    Flags = New values of the flags.
///Returns:
///    Returns "0" if the operation is successful; otherwise, one of the following error codes is returned: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The CCF filter failed to allocate the cache
///    objects for the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> The current process that's trying to tag the process specified by <i>ProcessHandle</i> doesn't
///    have <b>PROCESS_TERMINATE</b> access to that process. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The CCF mini-filter was not found. </td> </tr>
///    </table>
///    
@DllImport("NTLANMAN")
uint SetAppInstanceCsvFlags(HANDLE ProcessHandle, uint Mask, uint Flags);


// Interfaces

@GUID("F2E606E5-2631-11D1-89F1-00A0C90D061E")
struct ClusApplication;

@GUID("F2E606E3-2631-11D1-89F1-00A0C90D061E")
struct Cluster;

@GUID("F2E60715-2631-11D1-89F1-00A0C90D061E")
struct ClusVersion;

@GUID("F2E6070F-2631-11D1-89F1-00A0C90D061E")
struct ClusResType;

@GUID("F2E606FD-2631-11D1-89F1-00A0C90D061E")
struct ClusProperty;

@GUID("F2E606FF-2631-11D1-89F1-00A0C90D061E")
struct ClusProperties;

@GUID("F2E606E1-2631-11D1-89F1-00A0C90D061E")
struct DomainNames;

@GUID("F2E606F1-2631-11D1-89F1-00A0C90D061E")
struct ClusNetwork;

@GUID("F2E606ED-2631-11D1-89F1-00A0C90D061E")
struct ClusNetInterface;

@GUID("F2E606EF-2631-11D1-89F1-00A0C90D061E")
struct ClusNetInterfaces;

@GUID("F2E60703-2631-11D1-89F1-00A0C90D061E")
struct ClusResDependencies;

@GUID("F2E606E9-2631-11D1-89F1-00A0C90D061E")
struct ClusResGroupResources;

@GUID("F2E60713-2631-11D1-89F1-00A0C90D061E")
struct ClusResTypeResources;

@GUID("F2E606E7-2631-11D1-89F1-00A0C90D061E")
struct ClusResGroupPreferredOwnerNodes;

@GUID("F2E6070D-2631-11D1-89F1-00A0C90D061E")
struct ClusResPossibleOwnerNodes;

@GUID("F2E606F3-2631-11D1-89F1-00A0C90D061E")
struct ClusNetworks;

@GUID("F2E606F5-2631-11D1-89F1-00A0C90D061E")
struct ClusNetworkNetInterfaces;

@GUID("F2E606FB-2631-11D1-89F1-00A0C90D061E")
struct ClusNodeNetInterfaces;

@GUID("F2E60701-2631-11D1-89F1-00A0C90D061E")
struct ClusRefObject;

@GUID("F2E606EB-2631-11D1-89F1-00A0C90D061E")
struct ClusterNames;

@GUID("F2E606F7-2631-11D1-89F1-00A0C90D061E")
struct ClusNode;

@GUID("F2E606F9-2631-11D1-89F1-00A0C90D061E")
struct ClusNodes;

@GUID("F2E60705-2631-11D1-89F1-00A0C90D061E")
struct ClusResGroup;

@GUID("F2E60707-2631-11D1-89F1-00A0C90D061E")
struct ClusResGroups;

@GUID("F2E60709-2631-11D1-89F1-00A0C90D061E")
struct ClusResource;

@GUID("F2E6070B-2631-11D1-89F1-00A0C90D061E")
struct ClusResources;

@GUID("F2E60711-2631-11D1-89F1-00A0C90D061E")
struct ClusResTypes;

@GUID("F2E60717-2631-11D1-89F1-00A0C90D061E")
struct ClusResTypePossibleOwnerNodes;

@GUID("F2E60719-2631-11D1-89F1-00A0C90D061E")
struct ClusPropertyValue;

@GUID("F2E6071B-2631-11D1-89F1-00A0C90D061E")
struct ClusPropertyValues;

@GUID("F2E6071D-2631-11D1-89F1-00A0C90D061E")
struct ClusPropertyValueData;

@GUID("F2E6071F-2631-11D1-89F1-00A0C90D061E")
struct ClusPartition;

@GUID("53D51D26-B51B-4A79-B2C3-5048D93A98FC")
struct ClusPartitionEx;

@GUID("F2E60721-2631-11D1-89F1-00A0C90D061E")
struct ClusPartitions;

@GUID("F2E60723-2631-11D1-89F1-00A0C90D061E")
struct ClusDisk;

@GUID("F2E60725-2631-11D1-89F1-00A0C90D061E")
struct ClusDisks;

@GUID("F2E60727-2631-11D1-89F1-00A0C90D061E")
struct ClusScsiAddress;

@GUID("F2E60729-2631-11D1-89F1-00A0C90D061E")
struct ClusRegistryKeys;

@GUID("F2E6072B-2631-11D1-89F1-00A0C90D061E")
struct ClusCryptoKeys;

@GUID("F2E6072D-2631-11D1-89F1-00A0C90D061E")
struct ClusResDependents;

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] Called by a Failover Cluster Administrator
///extension to retrieve information about Failover Cluster Administrator's user interface.
@GUID("97DEDE50-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterUIInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns the name of the cluster.
    ///Params:
    ///    lpszName = Pointer to a null-terminated Unicode string containing the name of the cluster, or <b>NULL</b> to indicate
    ///               that the caller is requesting only the length of the name. Although declared as a <b>BSTR</b>, this parameter
    ///               is implemented as an <b>LPWSTR</b>.
    ///    pcchName = On input, pointer to the count of characters in the buffer pointed to by the <i>lpszName</i> parameter. On
    ///               output, pointer to the total number of characters in the buffer including the <b>NULL</b>-terminating
    ///               character.
    ///Returns:
    ///    If <b>GetClusterName</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr>
    ///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> One or more of the parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt>
    ///    <dt>0x800700ea</dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpszName</i> is too small to
    ///    hold the requested name. GetClusterName returns the required number of characters in the content of
    ///    <i>pcchName</i>. </td> </tr> </table>
    ///    
    HRESULT GetClusterName(BSTR lpszName, int* pcchName);
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns the locale identifier to be used
    ///with property and wizard pages.
    ///Returns:
    ///    <b>GetLocale</b> always returns the locale identifier for the cluster.
    ///    
    uint    GetLocale();
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns a handle to the font to be
    ///displayed on property and wizard pages.
    ///Returns:
    ///    If <b>GetFont</b> is successful, it returns a font handle.
    ///    
    HFONT   GetFont();
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns a handle to the icon to use in the
    ///upper-left corner of property and wizard pages.
    ///Returns:
    ///    <b>GetIcon</b> always returns a handle to an icon.
    ///    
    HICON   GetIcon();
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IGetClusterDataInfo</b> interface is
///called by a Failover Cluster Administrator extension to retrieve information about a cluster.
@GUID("97DEDE51-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterDataInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns the name of the cluster.
    ///Params:
    ///    lpszName = Pointer to a null-terminated Unicode string containing the name of the cluster; or <b>NULL</b> to indicate
    ///               that the caller is requesting only the length of the name. Although declared as a <b>BSTR</b>, this parameter
    ///               is implemented as an <b>LPWSTR</b>.
    ///    pcchName = On input, pointer to the size of the buffer, in characters, pointed to by the <i>lpszName</i> parameter. On
    ///               output, pointer to the total number of characters in the buffer including the <b>NULL</b>-terminating
    ///               character.
    ///Returns:
    ///    If <b>GetClusterName</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr>
    ///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> One or more of the parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt>
    ///    <dt>0x800700ea</dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpszName</i> is too small to
    ///    hold the requested name. GetClusterName returns the required number of characters in the content of
    ///    <i>pcchName</i>. </td> </tr> </table>
    ///    
    HRESULT GetClusterName(BSTR lpszName, int* pcchName);
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns a handle to the cluster.
    ///Returns:
    ///    A cluster handle.
    ///    
    _HCLUSTER* GetClusterHandle();
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns a count of the number of selected
    ///cluster objects.
    ///Returns:
    ///    A count of the number of selected objects.
    ///    
    int     GetObjectCount();
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IGetClusterObjectInfo</b> interface
///is called by a Failover Cluster Administrator extension to retrieve information about a cluster object.
@GUID("97DEDE52-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterObjectInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns the name of a cluster object.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target object. <i>lObjIndex</i> is restricted to the number
    ///                that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///    lpszName = Pointer to a null-terminated Unicode string containing the name of the object associated with
    ///               <i>lObjIndex</i>. The <i>lpszName</i> parameter can be <b>NULL</b>, indicating that the caller is requesting
    ///               only the name length. Although declared as a <b>BSTR</b>, this parameter is implemented as an <b>LPWSTR</b>.
    ///    pcchName = On input, pointer to the count of characters in the buffer pointed to by the <i>lpszName</i> parameter. The
    ///               <i>pcchName</i> parameter cannot be <b>NULL</b>. On output, pointer to the count of characters in the name
    ///               stored in the content of <i>lpszName</i>, including the <b>NULL</b>-terminating character.
    ///Returns:
    ///    If <b>GetObjectName</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt> <dt>0</dt>
    ///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> One or more of the parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt>
    ///    <dt>0x800700ea</dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpszName</i> is too small to
    ///    hold the requested name. GetObjectName returns the required number of characters in the content of
    ///    <i>pcchName</i>. </td> </tr> </table>
    ///    
    HRESULT GetObjectName(int lObjIndex, BSTR lpszName, int* pcchName);
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns the type of a cluster object.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target object. This parameter is restricted to the number
    ///                that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///Returns:
    ///    If GetObjectType is successful, it returns one of the following values enumerated by the
    ///    <b>CLUADMEX_OBJECT_TYPE</b> enumeration representing the object types: If <b>GetObjectType</b> is not
    ///    successful, it returns –1. For more information, call GetLastError.
    ///    
    CLUADMEX_OBJECT_TYPE GetObjectType(int lObjIndex);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IGetClusterNodeInfo</b> interface is
///called by a Failover Cluster Administrator extension to retrieve information about a node.
@GUID("97DEDE53-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterNodeInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns a handle to a node.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target node. <i>lObjIndex</i> is restricted to the number
    ///                that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///Returns:
    ///    If <b>GetNodeHandle</b> is successful, it returns a handle for the node represented by <i>lObjIndex</i>. If
    ///    <b>GetNodeHandle</b> is not successful, it returns <b>NULL</b>. For more information about the error, call
    ///    the function GetLastError.
    ///    
    _HNODE* GetNodeHandle(int lObjIndex);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IGetClusterGroupInfo</b> interface is
///called by a Failover Cluster Administrator extension to retrieve information about a group.
@GUID("97DEDE54-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterGroupInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns a handle to a group.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target group. <i>lObjIndex</i> is restricted to the number
    ///                that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///Returns:
    ///    If <b>GetGroupHandle</b> is successful, it returns a handle for the group represented by <i>lObjIndex</i>. If
    ///    <b>GetGroupHandle</b> is not successful, it returns <b>NULL</b>. For more information about the error, call
    ///    the function GetLastError.
    ///    
    _HGROUP* GetGroupHandle(int lObjIndex);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IGetClusterResourceInfo</b> interface
///is called by a Failover Cluster Administrator extension to retrieve information about a resource.
@GUID("97DEDE55-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterResourceInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns a handle to a resource.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target resource. <i>lObjIndex</i> is restricted to the
    ///                number that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///Returns:
    ///    If <b>GetResourceHandle</b> is successful, it returns a handle for the resource represented by
    ///    <i>lObjIndex</i>. If <b>GetResourceHandle</b> is not successful, it returns <b>NULL</b>. For more information
    ///    about the error, call the function GetLastError.
    ///    
    _HRESOURCE* GetResourceHandle(int lObjIndex);
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns the type of a resource.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target resource. <i>lObjIndex</i> is restricted to the
    ///                number that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///    lpszResTypeName = Pointer to the type of the resource associated with <i>lObjIndex</i>. The <i>lpResTypeName</i> parameter can
    ///                      be <b>NULL</b>, indicating that the caller is requesting only the length of the resource type. Although
    ///                      declared as a <b>BSTR</b>, this parameter is implemented as an <b>LPWSTR</b>.
    ///    pcchResTypeName = On input, pointer to the count of characters in the buffer pointed to by the <i>lpResTypeName</i> parameter.
    ///                      The <i>pcchResTypeName</i> parameter cannot be <b>NULL</b>. On output, pointer to the count of characters in
    ///                      the resource type name stored in the content of <i>lpResTypeName</i>, including the <b>NULL</b>-terminating
    ///                      character.
    ///Returns:
    ///    If <b>GetResourceTypeName</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr>
    ///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> One or more of the parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt>
    ///    <dt>0x800700ea</dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpResTypeName</i> is too small
    ///    to hold the requested resource type. GetResourceTypeName returns the required number of characters in the
    ///    content of <i>pcchResTypeName</i>. </td> </tr> </table>
    ///    
    HRESULT GetResourceTypeName(int lObjIndex, BSTR lpszResTypeName, int* pcchResTypeName);
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Returns the name of the network managed by
    ///the Network Name resource on which a resource depends.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target resource. The target resource may or may not depend
    ///                on a Network Name resource. <i>lObjIndex</i> is restricted to the number that can be retrieved by calling
    ///                IGetClusterDataInfo::GetObjectCount.
    ///    lpszNetName = Pointer to a null-terminated Unicode string containing the name of the network upon which the resource
    ///                  indexed by <i>lObjIndex</i> depends. Although declared as a <b>BSTR</b>, this parameter is implemented as an
    ///                  <b>LPWSTR</b>.
    ///    pcchNetName = Pointer to the maximum count in characters of the buffer pointed to by <i>lpszNetName</i>. On input, this
    ///                  value should be large enough to contain <b>MAX_COMPUTERNAME_LENGTH</b> + 1 characters. On output,
    ///                  <i>pcchNetName</i> points to the actual number of characters copied to the content of <i>lpszNetName</i>.
    ///Returns:
    ///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TRUE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The resource indexed by <i>lObjIndex</i> has a
    ///    dependency on a Network Name resource, and the name of the network was successfully returned. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The resource indexed
    ///    by <i>lObjIndex</i> does not have a dependency on a Network Name resource. </td> </tr> </table>
    ///    
    BOOL    GetResourceNetworkName(int lObjIndex, BSTR lpszNetName, uint* pcchNetName);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IGetClusterNetworkInfo</b> interface
///is called by a Failover Cluster Administrator extension to retrieve information about a network.
@GUID("97DEDE56-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterNetworkInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Retrieves a handle to a network.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target network. <i>lObjIndex</i> is restricted to the
    ///                number that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///Returns:
    ///    If <b>GetNetworkHandle</b> is successful, it returns a handle for the network represented by
    ///    <i>lObjIndex</i>. If <b>GetNetworkHandle</b> is not successful, it returns <b>NULL</b>. For more information
    ///    about the error, call the function GetLastError.
    ///    
    _HNETWORK* GetNetworkHandle(int lObjIndex);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IGetClusterNetInterfaceInfo</b>
///interface is called by a Failover Cluster Administrator extension to retrieve information about a network interface.
@GUID("97DEDE57-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterNetInterfaceInfo : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Retrieves a handle to a node.
    ///Params:
    ///    lObjIndex = A number representing the zero-based index of the target network interface. <i>lObjIndex</i> is restricted to
    ///                the number that can be retrieved by calling IGetClusterDataInfo::GetObjectCount.
    ///Returns:
    ///    If <b>GetNetInterfaceHandle</b> is successful, it returns a handle for the network interface represented by
    ///    <i>lObjIndex</i>. If <b>GetNetInterfaceHandle</b> is not successful, it returns <b>NULL</b>. For more
    ///    information about the error, call the function GetLastError.
    ///    
    _HNETINTERFACE* GetNetInterfaceHandle(int lObjIndex);
}

///The <b>IWCPropertySheetCallback</b> interface is called by a Failover Cluster Administrator extension to add property
///pages to a Failover Cluster Administrator property sheet.
@GUID("97DEDE60-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCPropertySheetCallback : IUnknown
{
    ///Adds a property page to a Failover Cluster Administrator property sheet.
    ///Params:
    ///    hpage = Handle to the property page to be added.
    ///Returns:
    ///    If <b>AddPropertySheetPage</b> was not successful, it can return other <b>HRESULT</b> values. <table> <tr>
    ///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> The <i>hpage</i> parameter is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT AddPropertySheetPage(int* hpage);
}

///Implement the <b>IWEExtendPropertySheet</b> interface to create property sheet pages for a cluster object and add
///them to a Failover Cluster Administrator property sheet.
@GUID("97DEDE61-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendPropertySheet : IUnknown
{
    ///Creates property pages for a cluster object and adds them to a Failover Cluster Administrator property sheet.
    ///Params:
    ///    piData = IUnknown interface pointer for retrieving information relating to the new property pages. By calling the
    ///             IUnknown::QueryInterface method with the <i>piData</i> pointer, the following interfaces are available: <ul>
    ///             <li> IGetClusterUIInfo </li> <li> IGetClusterDataInfo </li> <li> IGetClusterObjectInfo </li> </ul> Depending
    ///             on the type of cluster object for which property sheet pages are being created, a pointer to one of the
    ///             following interfaces is also available: <ul> <li> IGetClusterNodeInfo, if the property page relates to a
    ///             node.</li> <li> IGetClusterGroupInfo, if the property page relates to a group.</li> <li>
    ///             IGetClusterNetworkInfo, if the property page relates to a network.</li> <li> IGetClusterNetInterfaceInfo, if
    ///             the property page relates to a network interface.</li> <li> IGetClusterResourceInfo, if the property page
    ///             relates to a resource.</li> </ul>
    ///    piCallback = Pointer to an IWCPropertySheetCallback interface implementation for adding property pages to the Cluster
    ///                 Administrator property sheet.
    ///Returns:
    ///    Return one of the following values or any <b>HRESULT</b> that describes the results of the operation. <table>
    ///    <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> At least one of the parameters
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> <dt>0x80004001</dt> </dl> </td>
    ///    <td width="60%"> The extension does not support adding property pages. </td> </tr> </table>
    ///    
    HRESULT CreatePropertySheetPages(IUnknown piData, IWCPropertySheetCallback piCallback);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IWCWizardCallback</b> interface is
///called by a Failover Cluster Administrator extension to add a property page to a Failover Cluster Administrator
///Wizard and to manage navigation.
@GUID("97DEDE62-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCWizardCallback : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Adds a property page to a Failover Cluster
    ///Administrator Wizard.
    ///Params:
    ///    hpage = Handle to the property page to be added.
    ///Returns:
    ///    If <b>AddWizardPage</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt> <dt>0</dt>
    ///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> The <i>hpage</i> parameter
    ///    represents an unknown page. </td> </tr> </table>
    ///    
    HRESULT AddWizardPage(int* hpage);
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Enables or disables the <b>Next</b> or
    ///<b>Finish</b> button on a Failover Cluster Administrator Wizard page, depending on whether the current page is
    ///last.
    ///Params:
    ///    hpage = Handle to the property page containing the button to be enabled or disabled.
    ///    bEnable = Value indicating whether to enable or disable the button. If <i>bEnable</i> is set to <b>TRUE</b>, the
    ///              appropriate button is enabled. If <i>bEnable</i> is set to <b>FALSE</b>, it is disabled.
    ///Returns:
    ///    If <b>EnableNext</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt> <dt>0</dt>
    ///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> The <i>hpage</i> parameter
    ///    represents an unknown page. </td> </tr> </table>
    ///    
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] Implement the <b>IWEExtendWizard</b>
///interface to add wizard pages to Failover Cluster Administrator's New Resource Wizard or Cluster Application Wizard.
@GUID("97DEDE63-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendWizard : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Allows you to create wizard pages and add
    ///them to Failover Cluster Administrator's New Resource Wizard or Cluster Application Wizard.
    ///Params:
    ///    piData = IUnknown interface pointer for retrieving information relating to the wizard pages to be added. By calling
    ///             IUnknown::QueryInterface with the <i>piData</i> pointer, the following interfaces are available: <ul> <li>
    ///             IGetClusterUIInfo </li> <li> IGetClusterDataInfo </li> <li> IGetClusterObjectInfo </li> </ul> Depending on
    ///             the type of cluster object for which the wizard page is being created, a pointer to one of the following
    ///             interfaces is also available: <ul> <li> IGetClusterNodeInfo, if the property page relates to a node.</li>
    ///             <li> IGetClusterGroupInfo, if the property page relates to a group.</li> <li> IGetClusterNetworkInfo, if the
    ///             property page relates to a network.</li> <li> IGetClusterNetInterfaceInfo, if the property page relates to a
    ///             network interface.</li> <li> IGetClusterResourceInfo, if the property page relates to a resource.</li> </ul>
    ///    piCallback = Pointer to an IWCWizardCallback interface implementation used to add the new property pages to the wizard.
    ///Returns:
    ///    Return one of the following values or any <b>HRESULT</b> that describes the results of the operation. <table>
    ///    <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> At least one of the parameters
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> <dt>0x80004001</dt> </dl> </td>
    ///    <td width="60%"> The extension does not support adding a property page to the Create Group Wizard or Create
    ///    Resource Wizard. </td> </tr> </table>
    ///    
    HRESULT CreateWizardPages(IUnknown piData, IWCWizardCallback piCallback);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IWCContextMenuCallback</b> interface
///is called by a Failover Cluster Administrator extension to add items to a Failover Cluster Administrator context
///menu.
@GUID("97DEDE64-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCContextMenuCallback : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Adds a menu item to a Failover Cluster
    ///Administrator context menu.
    ///Params:
    ///    lpszName = Pointer to a null-terminated Unicode string containing the name of the item to be added to the menu. Although
    ///               declared as a <b>BSTR</b>, this parameter is implemented as an <b>LPWSTR</b>.
    ///    lpszStatusBarText = Pointer to text to display on the status bar when the new item is selected. Although declared as a
    ///                        <b>BSTR</b>, this parameter is implemented as an <b>LPWSTR</b>.
    ///    nCommandID = Identifier for the command to be invoked when the menu item is selected. The <i>nCommandID</i> parameter must
    ///                 not be set to –1.
    ///    nSubmenuCommandID = Identifier for a submenu. Submenus are not supported, and the <i>nSubmenuCommandID</i> parameter must be
    ///                        zero.
    ///    uFlags = Bitmask of flags that describes the new menu item. One or more of the following values may be set.
    ///Returns:
    ///    If <b>AddExtensionMenuItem</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr>
    ///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> The <i>uFlags</i> parameter was
    ///    set to either <b>MF_OWNERDRAW</b> or <b>MF_POPUP</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> <dt>0x8007000e</dt> </dl> </td> <td width="60%"> There was an error allocating
    ///    the menu item. </td> </tr> </table>
    ///    
    HRESULT AddExtensionMenuItem(BSTR lpszName, BSTR lpszStatusBarText, uint nCommandID, uint nSubmenuCommandID, 
                                 uint uFlags);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] Implement the <b>IWEExtendContextMenu</b>
///interface to extend a Failover Cluster Administrator context menu for a cluster object.
@GUID("97DEDE65-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendContextMenu : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Allows you to create context menu items for
    ///a cluster object and add the items to a Failover Cluster Administrator context menu.
    ///Params:
    ///    piData = IUnknown interface pointer for retrieving information relating to the new menu item. By calling the
    ///             IUnknown::QueryInterface method with the <i>piData</i> pointer, the following interfaces are available: <ul>
    ///             <li> IGetClusterUIInfo </li> <li> IGetClusterDataInfo </li> <li> IGetClusterObjectInfo </li> </ul> Depending
    ///             on the type of cluster object for which the context menu is being created, one of the following interfaces
    ///             may also be available: <ul> <li> IGetClusterNodeInfo, if the menu item relates to a node.</li> <li>
    ///             IGetClusterGroupInfo, if the menu item relates to a group.</li> <li> IGetClusterNetworkInfo, if the menu item
    ///             relates to a network.</li> <li> IGetClusterNetInterfaceInfo, if the menu item relates to a network
    ///             interface.</li> <li> IGetClusterResourceInfo, if the menu item relates to a resource.</li> </ul>
    ///    piCallback = Pointer to an IWCContextMenuCallback interface implementation for adding new items to the Cluster
    ///                 Administrator context menu.
    ///Returns:
    ///    Return one of the following values or any <b>HRESULT</b> that describes the results of the operation. <table>
    ///    <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> At least one of the parameters
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> <dt>0x80004001</dt> </dl> </td>
    ///    <td width="60%"> The extension does not support adding context menu items. </td> </tr> </table>
    ///    
    HRESULT AddContextMenuItems(IUnknown piData, IWCContextMenuCallback piCallback);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] Failover Cluster Administrator calls your
///implementation of the <b>IWEInvokeCommand</b> interface when users select context menu items that you created with
///the IWEExtendContextMenu interface.
@GUID("97DEDE66-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEInvokeCommand : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Allows you to implement procedures that
    ///execute when users select your context menu items.
    ///Params:
    ///    nCommandID = Identifier of the menu item containing the command to perform. The identifier represented by
    ///                 <i>nCommandID</i> is the identifier passed to the IWCContextMenuCallback::AddExtensionMenuItem method.
    ///    piData = IUnknown interface pointer for retrieving information associated with the command identified by
    ///             <i>nCommandID</i>. By calling the IUnknown::QueryInterface method with the <i>piData</i> pointer, the
    ///             following interfaces are available: <ul> <li> IGetClusterUIInfo </li> <li> IGetClusterDataInfo </li> <li>
    ///             IGetClusterObjectInfo </li> </ul> Depending on the type of cluster object to which the context menu item
    ///             applies, a pointer to one of the following interfaces is also available: <ul> <li> IGetClusterNodeInfo, if
    ///             the property page relates to a node.</li> <li> IGetClusterGroupInfo, if the property page relates to a
    ///             group.</li> <li> IGetClusterNetworkInfo, if the property page relates to a network.</li> <li>
    ///             IGetClusterNetInterfaceInfo, if the property page relates to a network interface.</li> <li>
    ///             IGetClusterResourceInfo, if the property page relates to a resource.</li> </ul>
    ///Returns:
    ///    Returns one of the following values or any <b>HRESULT</b> that describes the results of the operation.
    ///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NOERROR</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> <dt>0x80004001</dt> </dl> </td> <td width="60%"> The
    ///    operation is not implemented by this method. </td> </tr> </table>
    ///    
    HRESULT InvokeCommand(uint nCommandID, IUnknown piData);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] The <b>IWCWizard97Callback</b> interface is
///called by a Failover Cluster Administrator extension to add a Wizard97 property page to a Wizard97 wizard, such as
///the Cluster Application Wizard.
@GUID("97DEDE67-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCWizard97Callback : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Adds a Wizard97 property page to a Wizard97
    ///wizard, such as the Failover Cluster Application Wizard.
    ///Params:
    ///    hpage = Handle to the property page to be added.
    ///Returns:
    ///    If <b>AddWizard97Page</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr>
    ///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> The <i>hpage</i> parameter
    ///    represents an unknown page. </td> </tr> </table>
    ///    
    HRESULT AddWizard97Page(int* hpage);
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Enables or disables the <b>Next</b> or
    ///<b>Finish</b> button on a Wizard97 wizard page, depending on whether the current page is last.
    ///Params:
    ///    hpage = Handle to the property page containing the button to be enabled or disabled.
    ///    bEnable = Value indicating whether to enable or disable the button. If <i>bEnable</i> is set to <b>TRUE</b>, the
    ///              appropriate button is enabled. If <i>bEnable</i> is set to <b>FALSE</b>, it is disabled.
    ///Returns:
    ///    If <b>EnableNext</b> is not successful, it can return other <b>HRESULT</b> values. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt> <dt>0</dt>
    ///    </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> The <i>hpage</i> parameter
    ///    represents an unknown page. </td> </tr> </table>
    ///    
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

///<p class="CCE_Message">[This interface is available for use in the operating systems specified in the Requirements
///section. Support for this interface was removed in Windows Server 2008.] Implement the <b>IWEExtendWizard97</b>
///interface to add Wizard97-style wizard pages to a Failover Cluster Administrator wizard.
@GUID("97DEDE68-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendWizard97 : IUnknown
{
    ///<p class="CCE_Message">[This method is available for use in the operating systems specified in the Requirements
    ///section. Support for this method was removed in Windows Server 2008.] Allows you to create Wizard97 property
    ///pages and add them to a Failover Cluster Administrator Wizard.
    ///Params:
    ///    piData = IUnknown interface pointer for retrieving information relating to the wizard97 pages to be added. By calling
    ///             IUnknown::QueryInterface with the <i>piData</i> pointer, the following interfaces are available: <ul> <li>
    ///             IGetClusterUIInfo </li> <li> IGetClusterDataInfo </li> <li> IGetClusterObjectInfo </li> </ul> Depending on
    ///             the type of cluster object, a pointer to one of the following interfaces is also available: <ul> <li>
    ///             IGetClusterNodeInfo, if the property page relates to a node.</li> <li> IGetClusterGroupInfo, if the property
    ///             page relates to a group.</li> <li> IGetClusterNetworkInfo, if the property page relates to a network.</li>
    ///             <li> IGetClusterNetInterfaceInfo, if the property page relates to a network interface.</li> <li>
    ///             IGetClusterResourceInfo, if the property page relates to a resource.</li> </ul>
    ///    piCallback = Pointer to an IWCWizard97Callback interface implementation used to add the new Wizard97 property pages to the
    ///                 wizard.
    ///Returns:
    ///    Return one of the following values or any <b>HRESULT</b> that describes the results of the operation. <table>
    ///    <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NOERROR</b></dt>
    ///    <dt>0</dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> At least one of the parameters
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> <dt>0x80004001</dt> </dl> </td>
    ///    <td width="60%"> The extension does not support adding Wizard97 pages. </td> </tr> </table>
    ///    
    HRESULT CreateWizard97Pages(IUnknown piData, IWCWizard97Callback piCallback);
}

@GUID("F2E606E6-2631-11D1-89F1-00A0C90D061E")
interface ISClusApplication : IDispatch
{
    HRESULT get_DomainNames(ISDomainNames* ppDomains);
    HRESULT get_ClusterNames(BSTR bstrDomainName, ISClusterNames* ppClusters);
    HRESULT OpenCluster(BSTR bstrClusterName, ISCluster* pCluster);
}

@GUID("F2E606E2-2631-11D1-89F1-00A0C90D061E")
interface ISDomainNames : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrDomainName);
}

@GUID("F2E606EC-2631-11D1-89F1-00A0C90D061E")
interface ISClusterNames : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrClusterName);
    HRESULT get_DomainName(BSTR* pbstrDomainName);
}

@GUID("F2E60702-2631-11D1-89F1-00A0C90D061E")
interface ISClusRefObject : IDispatch
{
    HRESULT get_Handle(size_t* phandle);
}

@GUID("F2E60716-2631-11D1-89F1-00A0C90D061E")
interface ISClusVersion : IDispatch
{
    HRESULT get_Name(BSTR* pbstrClusterName);
    HRESULT get_MajorVersion(int* pnMajorVersion);
    HRESULT get_MinorVersion(int* pnMinorVersion);
    HRESULT get_BuildNumber(short* pnBuildNumber);
    HRESULT get_VendorId(BSTR* pbstrVendorId);
    HRESULT get_CSDVersion(BSTR* pbstrCSDVersion);
    HRESULT get_ClusterHighestVersion(int* pnClusterHighestVersion);
    HRESULT get_ClusterLowestVersion(int* pnClusterLowestVersion);
    HRESULT get_Flags(int* pnFlags);
    HRESULT get_MixedVersion(VARIANT* pvarMixedVersion);
}

@GUID("F2E606E4-2631-11D1-89F1-00A0C90D061E")
interface ISCluster : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(size_t* phandle);
    HRESULT Open(BSTR bstrClusterName);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrClusterName);
    HRESULT get_Version(ISClusVersion* ppClusVersion);
    HRESULT put_QuorumResource(ISClusResource pClusterResource);
    HRESULT get_QuorumResource(ISClusResource* pClusterResource);
    HRESULT get_QuorumLogSize(int* pnLogSize);
    HRESULT put_QuorumLogSize(int nLogSize);
    HRESULT get_QuorumPath(BSTR* ppPath);
    HRESULT put_QuorumPath(BSTR pPath);
    HRESULT get_Nodes(ISClusNodes* ppNodes);
    HRESULT get_ResourceGroups(ISClusResGroups* ppClusterResourceGroups);
    HRESULT get_Resources(ISClusResources* ppClusterResources);
    HRESULT get_ResourceTypes(ISClusResTypes* ppResourceTypes);
    HRESULT get_Networks(ISClusNetworks* ppNetworks);
    HRESULT get_NetInterfaces(ISClusNetInterfaces* ppNetInterfaces);
}

@GUID("F2E606F8-2631-11D1-89F1-00A0C90D061E")
interface ISClusNode : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Handle(size_t* phandle);
    HRESULT get_NodeID(BSTR* pbstrNodeID);
    HRESULT get_State(CLUSTER_NODE_STATE* dwState);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Evict();
    HRESULT get_ResourceGroups(ISClusResGroups* ppResourceGroups);
    HRESULT get_Cluster(ISCluster* ppCluster);
    HRESULT get_NetInterfaces(ISClusNodeNetInterfaces* ppClusNetInterfaces);
}

@GUID("F2E606FA-2631-11D1-89F1-00A0C90D061E")
interface ISClusNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
}

@GUID("F2E606F2-2631-11D1-89F1-00A0C90D061E")
interface ISClusNetwork : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(size_t* phandle);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrNetworkName);
    HRESULT get_NetworkID(BSTR* pbstrNetworkID);
    HRESULT get_State(CLUSTER_NETWORK_STATE* dwState);
    HRESULT get_NetInterfaces(ISClusNetworkNetInterfaces* ppClusNetInterfaces);
    HRESULT get_Cluster(ISCluster* ppCluster);
}

@GUID("F2E606F4-2631-11D1-89F1-00A0C90D061E")
interface ISClusNetworks : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetwork* ppClusNetwork);
}

@GUID("F2E606EE-2631-11D1-89F1-00A0C90D061E")
interface ISClusNetInterface : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Handle(size_t* phandle);
    HRESULT get_State(CLUSTER_NETINTERFACE_STATE* dwState);
    HRESULT get_Cluster(ISCluster* ppCluster);
}

@GUID("F2E606F0-2631-11D1-89F1-00A0C90D061E")
interface ISClusNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

@GUID("F2E606FC-2631-11D1-89F1-00A0C90D061E")
interface ISClusNodeNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

@GUID("F2E606F6-2631-11D1-89F1-00A0C90D061E")
interface ISClusNetworkNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

@GUID("F2E60706-2631-11D1-89F1-00A0C90D061E")
interface ISClusResGroup : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(size_t* phandle);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrGroupName);
    HRESULT get_State(CLUSTER_GROUP_STATE* dwState);
    HRESULT get_OwnerNode(ISClusNode* ppOwnerNode);
    HRESULT get_Resources(ISClusResGroupResources* ppClusterGroupResources);
    HRESULT get_PreferredOwnerNodes(ISClusResGroupPreferredOwnerNodes* ppOwnerNodes);
    HRESULT Delete();
    HRESULT Online(VARIANT varTimeout, VARIANT varNode, VARIANT* pvarPending);
    HRESULT Move(VARIANT varTimeout, VARIANT varNode, VARIANT* pvarPending);
    HRESULT Offline(VARIANT varTimeout, VARIANT* pvarPending);
    HRESULT get_Cluster(ISCluster* ppCluster);
}

@GUID("F2E60708-2631-11D1-89F1-00A0C90D061E")
interface ISClusResGroups : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResGroup* ppClusResGroup);
    HRESULT CreateItem(BSTR bstrResourceGroupName, ISClusResGroup* ppResourceGroup);
    HRESULT DeleteItem(VARIANT varIndex);
}

@GUID("F2E6070A-2631-11D1-89F1-00A0C90D061E")
interface ISClusResource : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(size_t* phandle);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrResourceName);
    HRESULT get_State(CLUSTER_RESOURCE_STATE* dwState);
    HRESULT get_CoreFlag(CLUS_FLAGS* dwCoreFlag);
    HRESULT BecomeQuorumResource(BSTR bstrDevicePath, int lMaxLogSize);
    HRESULT Delete();
    HRESULT Fail();
    HRESULT Online(int nTimeout, VARIANT* pvarPending);
    HRESULT Offline(int nTimeout, VARIANT* pvarPending);
    HRESULT ChangeResourceGroup(ISClusResGroup pResourceGroup);
    HRESULT AddResourceNode(ISClusNode pNode);
    HRESULT RemoveResourceNode(ISClusNode pNode);
    HRESULT CanResourceBeDependent(ISClusResource pResource, VARIANT* pvarDependent);
    HRESULT get_PossibleOwnerNodes(ISClusResPossibleOwnerNodes* ppOwnerNodes);
    HRESULT get_Dependencies(ISClusResDependencies* ppResDependencies);
    HRESULT get_Dependents(ISClusResDependents* ppResDependents);
    HRESULT get_Group(ISClusResGroup* ppResGroup);
    HRESULT get_OwnerNode(ISClusNode* ppOwnerNode);
    HRESULT get_Cluster(ISCluster* ppCluster);
    HRESULT get_ClassInfo(CLUSTER_RESOURCE_CLASS* prcClassInfo);
    HRESULT get_Disk(ISClusDisk* ppDisk);
    HRESULT get_RegistryKeys(ISClusRegistryKeys* ppRegistryKeys);
    HRESULT get_CryptoKeys(ISClusCryptoKeys* ppCryptoKeys);
    HRESULT get_TypeName(BSTR* pbstrTypeName);
    HRESULT get_Type(ISClusResType* ppResourceType);
    HRESULT get_MaintenanceMode(BOOL* pbMaintenanceMode);
    HRESULT put_MaintenanceMode(BOOL bMaintenanceMode);
}

@GUID("F2E60704-2631-11D1-89F1-00A0C90D061E")
interface ISClusResDependencies : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, 
                       ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
    HRESULT AddItem(ISClusResource pResource);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("F2E606EA-2631-11D1-89F1-00A0C90D061E")
interface ISClusResGroupResources : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, 
                       ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
}

@GUID("F2E60714-2631-11D1-89F1-00A0C90D061E")
interface ISClusResTypeResources : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrGroupName, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, 
                       ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
}

@GUID("F2E6070C-2631-11D1-89F1-00A0C90D061E")
interface ISClusResources : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, BSTR bstrGroupName, 
                       CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
}

@GUID("F2E606E8-2631-11D1-89F1-00A0C90D061E")
interface ISClusResGroupPreferredOwnerNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
    HRESULT InsertItem(ISClusNode pNode, int nPosition);
    HRESULT RemoveItem(VARIANT varIndex);
    HRESULT get_Modified(VARIANT* pvarModified);
    HRESULT SaveChanges();
    HRESULT AddItem(ISClusNode pNode);
}

@GUID("F2E6070E-2631-11D1-89F1-00A0C90D061E")
interface ISClusResPossibleOwnerNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
    HRESULT AddItem(ISClusNode pNode);
    HRESULT RemoveItem(VARIANT varIndex);
    HRESULT get_Modified(VARIANT* pvarModified);
}

@GUID("F2E60718-2631-11D1-89F1-00A0C90D061E")
interface ISClusResTypePossibleOwnerNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
}

@GUID("F2E60710-2631-11D1-89F1-00A0C90D061E")
interface ISClusResType : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT Delete();
    HRESULT get_Cluster(ISCluster* ppCluster);
    HRESULT get_Resources(ISClusResTypeResources* ppClusterResTypeResources);
    HRESULT get_PossibleOwnerNodes(ISClusResTypePossibleOwnerNodes* ppOwnerNodes);
    HRESULT get_AvailableDisks(ISClusDisks* ppAvailableDisks);
}

@GUID("F2E60712-2631-11D1-89F1-00A0C90D061E")
interface ISClusResTypes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResType* ppClusResType);
    HRESULT CreateItem(BSTR bstrResourceTypeName, BSTR bstrDisplayName, BSTR bstrResourceTypeDll, 
                       int dwLooksAlivePollInterval, int dwIsAlivePollInterval, ISClusResType* ppResourceType);
    HRESULT DeleteItem(VARIANT varIndex);
}

@GUID("F2E606FE-2631-11D1-89F1-00A0C90D061E")
interface ISClusProperty : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Length(int* pLength);
    HRESULT get_ValueCount(int* pCount);
    HRESULT get_Values(ISClusPropertyValues* ppClusterPropertyValues);
    HRESULT get_Value(VARIANT* pvarValue);
    HRESULT put_Value(VARIANT varValue);
    HRESULT get_Type(CLUSTER_PROPERTY_TYPE* pType);
    HRESULT put_Type(CLUSTER_PROPERTY_TYPE Type);
    HRESULT get_Format(CLUSTER_PROPERTY_FORMAT* pFormat);
    HRESULT put_Format(CLUSTER_PROPERTY_FORMAT Format);
    HRESULT get_ReadOnly(VARIANT* pvarReadOnly);
    HRESULT get_Private(VARIANT* pvarPrivate);
    HRESULT get_Common(VARIANT* pvarCommon);
    HRESULT get_Modified(VARIANT* pvarModified);
    HRESULT UseDefaultValue();
}

@GUID("F2E6071A-2631-11D1-89F1-00A0C90D061E")
interface ISClusPropertyValue : IDispatch
{
    HRESULT get_Value(VARIANT* pvarValue);
    HRESULT put_Value(VARIANT varValue);
    HRESULT get_Type(CLUSTER_PROPERTY_TYPE* pType);
    HRESULT put_Type(CLUSTER_PROPERTY_TYPE Type);
    HRESULT get_Format(CLUSTER_PROPERTY_FORMAT* pFormat);
    HRESULT put_Format(CLUSTER_PROPERTY_FORMAT Format);
    HRESULT get_Length(int* pLength);
    HRESULT get_DataCount(int* pCount);
    HRESULT get_Data(ISClusPropertyValueData* ppClusterPropertyValueData);
}

@GUID("F2E6071C-2631-11D1-89F1-00A0C90D061E")
interface ISClusPropertyValues : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusPropertyValue* ppPropertyValue);
    HRESULT CreateItem(BSTR bstrName, VARIANT varValue, ISClusPropertyValue* ppPropertyValue);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("F2E60700-2631-11D1-89F1-00A0C90D061E")
interface ISClusProperties : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusProperty* ppClusProperty);
    HRESULT CreateItem(BSTR bstrName, VARIANT varValue, ISClusProperty* pProperty);
    HRESULT UseDefaultValue(VARIANT varIndex);
    HRESULT SaveChanges(VARIANT* pvarStatusCode);
    HRESULT get_ReadOnly(VARIANT* pvarReadOnly);
    HRESULT get_Private(VARIANT* pvarPrivate);
    HRESULT get_Common(VARIANT* pvarCommon);
    HRESULT get_Modified(VARIANT* pvarModified);
}

@GUID("F2E6071E-2631-11D1-89F1-00A0C90D061E")
interface ISClusPropertyValueData : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, VARIANT* pvarValue);
    HRESULT CreateItem(VARIANT varValue, VARIANT* pvarData);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("F2E60720-2631-11D1-89F1-00A0C90D061E")
interface ISClusPartition : IDispatch
{
    HRESULT get_Flags(int* plFlags);
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    HRESULT get_VolumeLabel(BSTR* pbstrVolumeLabel);
    HRESULT get_SerialNumber(int* plSerialNumber);
    HRESULT get_MaximumComponentLength(int* plMaximumComponentLength);
    HRESULT get_FileSystemFlags(int* plFileSystemFlags);
    HRESULT get_FileSystem(BSTR* pbstrFileSystem);
}

///Provides extended information about a partition on a Physical Disk resource. <ul> <li>Properties</li> </ul><h3><a
///id="properties"></a>Properties</h3>The <b xmlns:loc="http://microsoft.com/wdcml/l10n">ClusPartitionEx</b> object has
///these properties. <table class="members" id="memberListProperties"> <tr> <th align="left" width="27%">Property</th>
///<th align="left" width="10%">Access type</th> <th align="left" width="63%">Description</th> </tr> <tr
///data="declared;"> <td align="left" width="27%" xml:space="preserve"> DeviceNumber </td> <td align="left" width="10%">
///Read-only </td> <td align="left" width="63%"> Gets the device number of the partition. </td> </tr> <tr
///data="declared;"> <td align="left" width="27%" xml:space="preserve"> FreeSpace </td> <td align="left" width="10%">
///Read-only </td> <td align="left" width="63%"> Gets the total disk space available to the partition in megabytes.
///</td> </tr> <tr data="declared;"> <td align="left" width="27%" xml:space="preserve"> PartitionNumber </td> <td
///align="left" width="10%"> Read-only </td> <td align="left" width="63%"> Gets the partition number of the partition.
///</td> </tr> <tr data="declared;"> <td align="left" width="27%" xml:space="preserve"> TotalSize </td> <td align="left"
///width="10%"> Read-only </td> <td align="left" width="63%"> Gets the total size of the partition in megabytes. </td>
///</tr> <tr data="declared;"> <td align="left" width="27%" xml:space="preserve"> VolumeGuid </td> <td align="left"
///width="10%"> Read-only </td> <td align="left" width="63%"> Gets the volume <b>GUID</b> of the partition. </td> </tr>
///</table>
@GUID("8802D4FE-B32E-4AD1-9DBD-64F18E1166CE")
interface ISClusPartitionEx : ISClusPartition
{
    HRESULT get_TotalSize(int* plTotalSize);
    HRESULT get_FreeSpace(int* plFreeSpace);
    HRESULT get_DeviceNumber(int* plDeviceNumber);
    HRESULT get_PartitionNumber(int* plPartitionNumber);
    HRESULT get_VolumeGuid(BSTR* pbstrVolumeGuid);
}

@GUID("F2E60722-2631-11D1-89F1-00A0C90D061E")
interface ISClusPartitions : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusPartition* ppPartition);
}

@GUID("F2E60724-2631-11D1-89F1-00A0C90D061E")
interface ISClusDisk : IDispatch
{
    HRESULT get_Signature(int* plSignature);
    HRESULT get_ScsiAddress(ISClusScsiAddress* ppScsiAddress);
    HRESULT get_DiskNumber(int* plDiskNumber);
    HRESULT get_Partitions(ISClusPartitions* ppPartitions);
}

@GUID("F2E60726-2631-11D1-89F1-00A0C90D061E")
interface ISClusDisks : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusDisk* ppDisk);
}

@GUID("F2E60728-2631-11D1-89F1-00A0C90D061E")
interface ISClusScsiAddress : IDispatch
{
    HRESULT get_PortNumber(VARIANT* pvarPortNumber);
    HRESULT get_PathId(VARIANT* pvarPathId);
    HRESULT get_TargetId(VARIANT* pvarTargetId);
    HRESULT get_Lun(VARIANT* pvarLun);
}

@GUID("F2E6072A-2631-11D1-89F1-00A0C90D061E")
interface ISClusRegistryKeys : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrRegistryKey);
    HRESULT AddItem(BSTR bstrRegistryKey);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("F2E6072C-2631-11D1-89F1-00A0C90D061E")
interface ISClusCryptoKeys : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrCyrptoKey);
    HRESULT AddItem(BSTR bstrCryptoKey);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("F2E6072E-2631-11D1-89F1-00A0C90D061E")
interface ISClusResDependents : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, 
                       ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
    HRESULT AddItem(ISClusResource pResource);
    HRESULT RemoveItem(VARIANT varIndex);
}


// GUIDs

const GUID CLSID_ClusApplication                 = GUIDOF!ClusApplication;
const GUID CLSID_ClusCryptoKeys                  = GUIDOF!ClusCryptoKeys;
const GUID CLSID_ClusDisk                        = GUIDOF!ClusDisk;
const GUID CLSID_ClusDisks                       = GUIDOF!ClusDisks;
const GUID CLSID_ClusNetInterface                = GUIDOF!ClusNetInterface;
const GUID CLSID_ClusNetInterfaces               = GUIDOF!ClusNetInterfaces;
const GUID CLSID_ClusNetwork                     = GUIDOF!ClusNetwork;
const GUID CLSID_ClusNetworkNetInterfaces        = GUIDOF!ClusNetworkNetInterfaces;
const GUID CLSID_ClusNetworks                    = GUIDOF!ClusNetworks;
const GUID CLSID_ClusNode                        = GUIDOF!ClusNode;
const GUID CLSID_ClusNodeNetInterfaces           = GUIDOF!ClusNodeNetInterfaces;
const GUID CLSID_ClusNodes                       = GUIDOF!ClusNodes;
const GUID CLSID_ClusPartition                   = GUIDOF!ClusPartition;
const GUID CLSID_ClusPartitionEx                 = GUIDOF!ClusPartitionEx;
const GUID CLSID_ClusPartitions                  = GUIDOF!ClusPartitions;
const GUID CLSID_ClusProperties                  = GUIDOF!ClusProperties;
const GUID CLSID_ClusProperty                    = GUIDOF!ClusProperty;
const GUID CLSID_ClusPropertyValue               = GUIDOF!ClusPropertyValue;
const GUID CLSID_ClusPropertyValueData           = GUIDOF!ClusPropertyValueData;
const GUID CLSID_ClusPropertyValues              = GUIDOF!ClusPropertyValues;
const GUID CLSID_ClusRefObject                   = GUIDOF!ClusRefObject;
const GUID CLSID_ClusRegistryKeys                = GUIDOF!ClusRegistryKeys;
const GUID CLSID_ClusResDependencies             = GUIDOF!ClusResDependencies;
const GUID CLSID_ClusResDependents               = GUIDOF!ClusResDependents;
const GUID CLSID_ClusResGroup                    = GUIDOF!ClusResGroup;
const GUID CLSID_ClusResGroupPreferredOwnerNodes = GUIDOF!ClusResGroupPreferredOwnerNodes;
const GUID CLSID_ClusResGroupResources           = GUIDOF!ClusResGroupResources;
const GUID CLSID_ClusResGroups                   = GUIDOF!ClusResGroups;
const GUID CLSID_ClusResPossibleOwnerNodes       = GUIDOF!ClusResPossibleOwnerNodes;
const GUID CLSID_ClusResType                     = GUIDOF!ClusResType;
const GUID CLSID_ClusResTypePossibleOwnerNodes   = GUIDOF!ClusResTypePossibleOwnerNodes;
const GUID CLSID_ClusResTypeResources            = GUIDOF!ClusResTypeResources;
const GUID CLSID_ClusResTypes                    = GUIDOF!ClusResTypes;
const GUID CLSID_ClusResource                    = GUIDOF!ClusResource;
const GUID CLSID_ClusResources                   = GUIDOF!ClusResources;
const GUID CLSID_ClusScsiAddress                 = GUIDOF!ClusScsiAddress;
const GUID CLSID_ClusVersion                     = GUIDOF!ClusVersion;
const GUID CLSID_Cluster                         = GUIDOF!Cluster;
const GUID CLSID_ClusterNames                    = GUIDOF!ClusterNames;
const GUID CLSID_DomainNames                     = GUIDOF!DomainNames;

const GUID IID_IGetClusterDataInfo               = GUIDOF!IGetClusterDataInfo;
const GUID IID_IGetClusterGroupInfo              = GUIDOF!IGetClusterGroupInfo;
const GUID IID_IGetClusterNetInterfaceInfo       = GUIDOF!IGetClusterNetInterfaceInfo;
const GUID IID_IGetClusterNetworkInfo            = GUIDOF!IGetClusterNetworkInfo;
const GUID IID_IGetClusterNodeInfo               = GUIDOF!IGetClusterNodeInfo;
const GUID IID_IGetClusterObjectInfo             = GUIDOF!IGetClusterObjectInfo;
const GUID IID_IGetClusterResourceInfo           = GUIDOF!IGetClusterResourceInfo;
const GUID IID_IGetClusterUIInfo                 = GUIDOF!IGetClusterUIInfo;
const GUID IID_ISClusApplication                 = GUIDOF!ISClusApplication;
const GUID IID_ISClusCryptoKeys                  = GUIDOF!ISClusCryptoKeys;
const GUID IID_ISClusDisk                        = GUIDOF!ISClusDisk;
const GUID IID_ISClusDisks                       = GUIDOF!ISClusDisks;
const GUID IID_ISClusNetInterface                = GUIDOF!ISClusNetInterface;
const GUID IID_ISClusNetInterfaces               = GUIDOF!ISClusNetInterfaces;
const GUID IID_ISClusNetwork                     = GUIDOF!ISClusNetwork;
const GUID IID_ISClusNetworkNetInterfaces        = GUIDOF!ISClusNetworkNetInterfaces;
const GUID IID_ISClusNetworks                    = GUIDOF!ISClusNetworks;
const GUID IID_ISClusNode                        = GUIDOF!ISClusNode;
const GUID IID_ISClusNodeNetInterfaces           = GUIDOF!ISClusNodeNetInterfaces;
const GUID IID_ISClusNodes                       = GUIDOF!ISClusNodes;
const GUID IID_ISClusPartition                   = GUIDOF!ISClusPartition;
const GUID IID_ISClusPartitionEx                 = GUIDOF!ISClusPartitionEx;
const GUID IID_ISClusPartitions                  = GUIDOF!ISClusPartitions;
const GUID IID_ISClusProperties                  = GUIDOF!ISClusProperties;
const GUID IID_ISClusProperty                    = GUIDOF!ISClusProperty;
const GUID IID_ISClusPropertyValue               = GUIDOF!ISClusPropertyValue;
const GUID IID_ISClusPropertyValueData           = GUIDOF!ISClusPropertyValueData;
const GUID IID_ISClusPropertyValues              = GUIDOF!ISClusPropertyValues;
const GUID IID_ISClusRefObject                   = GUIDOF!ISClusRefObject;
const GUID IID_ISClusRegistryKeys                = GUIDOF!ISClusRegistryKeys;
const GUID IID_ISClusResDependencies             = GUIDOF!ISClusResDependencies;
const GUID IID_ISClusResDependents               = GUIDOF!ISClusResDependents;
const GUID IID_ISClusResGroup                    = GUIDOF!ISClusResGroup;
const GUID IID_ISClusResGroupPreferredOwnerNodes = GUIDOF!ISClusResGroupPreferredOwnerNodes;
const GUID IID_ISClusResGroupResources           = GUIDOF!ISClusResGroupResources;
const GUID IID_ISClusResGroups                   = GUIDOF!ISClusResGroups;
const GUID IID_ISClusResPossibleOwnerNodes       = GUIDOF!ISClusResPossibleOwnerNodes;
const GUID IID_ISClusResType                     = GUIDOF!ISClusResType;
const GUID IID_ISClusResTypePossibleOwnerNodes   = GUIDOF!ISClusResTypePossibleOwnerNodes;
const GUID IID_ISClusResTypeResources            = GUIDOF!ISClusResTypeResources;
const GUID IID_ISClusResTypes                    = GUIDOF!ISClusResTypes;
const GUID IID_ISClusResource                    = GUIDOF!ISClusResource;
const GUID IID_ISClusResources                   = GUIDOF!ISClusResources;
const GUID IID_ISClusScsiAddress                 = GUIDOF!ISClusScsiAddress;
const GUID IID_ISClusVersion                     = GUIDOF!ISClusVersion;
const GUID IID_ISCluster                         = GUIDOF!ISCluster;
const GUID IID_ISClusterNames                    = GUIDOF!ISClusterNames;
const GUID IID_ISDomainNames                     = GUIDOF!ISDomainNames;
const GUID IID_IWCContextMenuCallback            = GUIDOF!IWCContextMenuCallback;
const GUID IID_IWCPropertySheetCallback          = GUIDOF!IWCPropertySheetCallback;
const GUID IID_IWCWizard97Callback               = GUIDOF!IWCWizard97Callback;
const GUID IID_IWCWizardCallback                 = GUIDOF!IWCWizardCallback;
const GUID IID_IWEExtendContextMenu              = GUIDOF!IWEExtendContextMenu;
const GUID IID_IWEExtendPropertySheet            = GUIDOF!IWEExtendPropertySheet;
const GUID IID_IWEExtendWizard                   = GUIDOF!IWEExtendWizard;
const GUID IID_IWEExtendWizard97                 = GUIDOF!IWEExtendWizard97;
const GUID IID_IWEInvokeCommand                  = GUIDOF!IWEInvokeCommand;
