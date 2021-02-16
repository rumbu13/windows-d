module windows.windowsclustering;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HFONT, HICON;
public import windows.security : SC_HANDLE__;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, SECURITY_ATTRIBUTES, SECURITY_DESCRIPTOR_RELATIVE,
                                       ULARGE_INTEGER;
public import windows.windowsprogramming : FILETIME, HKEY, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    OperationalQuorum = 0x00000000,
    ModifyQuorum      = 0x00000001,
}
alias CLUSTER_QUORUM_TYPE = int;

enum : int
{
    ClusterStateNotInstalled  = 0x00000000,
    ClusterStateNotConfigured = 0x00000001,
    ClusterStateNotRunning    = 0x00000003,
    ClusterStateRunning       = 0x00000013,
}
alias NODE_CLUSTER_STATE = int;

enum : int
{
    eResourceStateChangeReasonUnknown    = 0x00000000,
    eResourceStateChangeReasonMove       = 0x00000001,
    eResourceStateChangeReasonFailover   = 0x00000002,
    eResourceStateChangeReasonFailedMove = 0x00000003,
    eResourceStateChangeReasonShutdown   = 0x00000004,
    eResourceStateChangeReasonRundown    = 0x00000005,
}
alias CLUSTER_RESOURCE_STATE_CHANGE_REASON = int;

enum : int
{
    CLUSREG_COMMAND_NONE              = 0x00000000,
    CLUSREG_SET_VALUE                 = 0x00000001,
    CLUSREG_CREATE_KEY                = 0x00000002,
    CLUSREG_DELETE_KEY                = 0x00000003,
    CLUSREG_DELETE_VALUE              = 0x00000004,
    CLUSREG_SET_KEY_SECURITY          = 0x00000005,
    CLUSREG_VALUE_DELETED             = 0x00000006,
    CLUSREG_READ_KEY                  = 0x00000007,
    CLUSREG_READ_VALUE                = 0x00000008,
    CLUSREG_READ_ERROR                = 0x00000009,
    CLUSREG_CONTROL_COMMAND           = 0x0000000a,
    CLUSREG_CONDITION_EXISTS          = 0x0000000b,
    CLUSREG_CONDITION_NOT_EXISTS      = 0x0000000c,
    CLUSREG_CONDITION_IS_EQUAL        = 0x0000000d,
    CLUSREG_CONDITION_IS_NOT_EQUAL    = 0x0000000e,
    CLUSREG_CONDITION_IS_GREATER_THAN = 0x0000000f,
    CLUSREG_CONDITION_IS_LESS_THAN    = 0x00000010,
    CLUSREG_CONDITION_KEY_EXISTS      = 0x00000011,
    CLUSREG_CONDITION_KEY_NOT_EXISTS  = 0x00000012,
    CLUSREG_LAST_COMMAND              = 0x00000013,
}
alias CLUSTER_REG_COMMAND = int;

enum : int
{
    ClusGroupTypeCoreCluster              = 0x00000001,
    ClusGroupTypeAvailableStorage         = 0x00000002,
    ClusGroupTypeTemporary                = 0x00000003,
    ClusGroupTypeSharedVolume             = 0x00000004,
    ClusGroupTypeStoragePool              = 0x00000005,
    ClusGroupTypeFileServer               = 0x00000064,
    ClusGroupTypePrintServer              = 0x00000065,
    ClusGroupTypeDhcpServer               = 0x00000066,
    ClusGroupTypeDtc                      = 0x00000067,
    ClusGroupTypeMsmq                     = 0x00000068,
    ClusGroupTypeWins                     = 0x00000069,
    ClusGroupTypeStandAloneDfs            = 0x0000006a,
    ClusGroupTypeGenericApplication       = 0x0000006b,
    ClusGroupTypeGenericService           = 0x0000006c,
    ClusGroupTypeGenericScript            = 0x0000006d,
    ClusGroupTypeIScsiNameService         = 0x0000006e,
    ClusGroupTypeVirtualMachine           = 0x0000006f,
    ClusGroupTypeTsSessionBroker          = 0x00000070,
    ClusGroupTypeIScsiTarget              = 0x00000071,
    ClusGroupTypeScaleoutFileServer       = 0x00000072,
    ClusGroupTypeVMReplicaBroker          = 0x00000073,
    ClusGroupTypeTaskScheduler            = 0x00000074,
    ClusGroupTypeClusterUpdateAgent       = 0x00000075,
    ClusGroupTypeScaleoutCluster          = 0x00000076,
    ClusGroupTypeStorageReplica           = 0x00000077,
    ClusGroupTypeVMReplicaCoordinator     = 0x00000078,
    ClusGroupTypeCrossClusterOrchestrator = 0x00000079,
    ClusGroupTypeInfrastructureFileServer = 0x0000007a,
    ClusGroupTypeUnknown                  = 0x0000270f,
}
alias CLUSGROUP_TYPE = int;

enum : int
{
    CLUSTER_MGMT_POINT_TYPE_NONE     = 0x00000000,
    CLUSTER_MGMT_POINT_TYPE_CNO      = 0x00000001,
    CLUSTER_MGMT_POINT_TYPE_DNS_ONLY = 0x00000002,
    CLUSTER_MGMT_POINT_TYPE_CNO_ONLY = 0x00000003,
}
alias CLUSTER_MGMT_POINT_TYPE = int;

enum : int
{
    CLUSTER_MGMT_POINT_RESTYPE_AUTO = 0x00000000,
    CLUSTER_MGMT_POINT_RESTYPE_SNN  = 0x00000001,
    CLUSTER_MGMT_POINT_RESTYPE_DNN  = 0x00000002,
}
alias CLUSTER_MGMT_POINT_RESTYPE = int;

enum : int
{
    CLUSTER_CLOUD_TYPE_NONE    = 0x00000000,
    CLUSTER_CLOUD_TYPE_AZURE   = 0x00000001,
    CLUSTER_CLOUD_TYPE_MIXED   = 0x00000080,
    CLUSTER_CLOUD_TYPE_UNKNOWN = 0xffffffff,
}
alias CLUSTER_CLOUD_TYPE = int;

enum : int
{
    CLUS_GROUP_START_ALWAYS  = 0x00000000,
    CLUS_GROUP_DO_NOT_START  = 0x00000001,
    CLUS_GROUP_START_ALLOWED = 0x00000002,
}
alias CLUS_GROUP_START_SETTING = int;

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
alias CLUS_AFFINITY_RULE_TYPE = int;

enum : int
{
    CLUSTER_QUORUM_MAINTAINED = 0x00000000,
    CLUSTER_QUORUM_LOST       = 0x00000001,
}
alias CLUSTER_QUORUM_VALUE = int;

enum : int
{
    ClusterUpgradePhaseInitialize              = 0x00000001,
    ClusterUpgradePhaseValidatingUpgrade       = 0x00000002,
    ClusterUpgradePhaseUpgradingComponents     = 0x00000003,
    ClusterUpgradePhaseInstallingNewComponents = 0x00000004,
    ClusterUpgradePhaseUpgradeComplete         = 0x00000005,
}
alias CLUSTER_UPGRADE_PHASE = int;

enum : int
{
    CLUSTER_CHANGE_NODE_STATE             = 0x00000001,
    CLUSTER_CHANGE_NODE_DELETED           = 0x00000002,
    CLUSTER_CHANGE_NODE_ADDED             = 0x00000004,
    CLUSTER_CHANGE_NODE_PROPERTY          = 0x00000008,
    CLUSTER_CHANGE_REGISTRY_NAME          = 0x00000010,
    CLUSTER_CHANGE_REGISTRY_ATTRIBUTES    = 0x00000020,
    CLUSTER_CHANGE_REGISTRY_VALUE         = 0x00000040,
    CLUSTER_CHANGE_REGISTRY_SUBTREE       = 0x00000080,
    CLUSTER_CHANGE_RESOURCE_STATE         = 0x00000100,
    CLUSTER_CHANGE_RESOURCE_DELETED       = 0x00000200,
    CLUSTER_CHANGE_RESOURCE_ADDED         = 0x00000400,
    CLUSTER_CHANGE_RESOURCE_PROPERTY      = 0x00000800,
    CLUSTER_CHANGE_GROUP_STATE            = 0x00001000,
    CLUSTER_CHANGE_GROUP_DELETED          = 0x00002000,
    CLUSTER_CHANGE_GROUP_ADDED            = 0x00004000,
    CLUSTER_CHANGE_GROUP_PROPERTY         = 0x00008000,
    CLUSTER_CHANGE_RESOURCE_TYPE_DELETED  = 0x00010000,
    CLUSTER_CHANGE_RESOURCE_TYPE_ADDED    = 0x00020000,
    CLUSTER_CHANGE_RESOURCE_TYPE_PROPERTY = 0x00040000,
    CLUSTER_CHANGE_CLUSTER_RECONNECT      = 0x00080000,
    CLUSTER_CHANGE_NETWORK_STATE          = 0x00100000,
    CLUSTER_CHANGE_NETWORK_DELETED        = 0x00200000,
    CLUSTER_CHANGE_NETWORK_ADDED          = 0x00400000,
    CLUSTER_CHANGE_NETWORK_PROPERTY       = 0x00800000,
    CLUSTER_CHANGE_NETINTERFACE_STATE     = 0x01000000,
    CLUSTER_CHANGE_NETINTERFACE_DELETED   = 0x02000000,
    CLUSTER_CHANGE_NETINTERFACE_ADDED     = 0x04000000,
    CLUSTER_CHANGE_NETINTERFACE_PROPERTY  = 0x08000000,
    CLUSTER_CHANGE_QUORUM_STATE           = 0x10000000,
    CLUSTER_CHANGE_CLUSTER_STATE          = 0x20000000,
    CLUSTER_CHANGE_CLUSTER_PROPERTY       = 0x40000000,
    CLUSTER_CHANGE_HANDLE_CLOSE           = 0x80000000,
    CLUSTER_CHANGE_ALL                    = 0xffffffff,
}
alias CLUSTER_CHANGE = int;

enum : int
{
    CLUSTER_NOTIFICATIONS_V1 = 0x00000001,
    CLUSTER_NOTIFICATIONS_V2 = 0x00000002,
}
alias CLUSTER_NOTIFICATIONS_VERSION = int;

enum : int
{
    CLUSTER_CHANGE_CLUSTER_RECONNECT_V2           = 0x00000001,
    CLUSTER_CHANGE_CLUSTER_STATE_V2               = 0x00000002,
    CLUSTER_CHANGE_CLUSTER_GROUP_ADDED_V2         = 0x00000004,
    CLUSTER_CHANGE_CLUSTER_HANDLE_CLOSE_V2        = 0x00000008,
    CLUSTER_CHANGE_CLUSTER_NETWORK_ADDED_V2       = 0x00000010,
    CLUSTER_CHANGE_CLUSTER_NODE_ADDED_V2          = 0x00000020,
    CLUSTER_CHANGE_CLUSTER_RESOURCE_TYPE_ADDED_V2 = 0x00000040,
    CLUSTER_CHANGE_CLUSTER_COMMON_PROPERTY_V2     = 0x00000080,
    CLUSTER_CHANGE_CLUSTER_PRIVATE_PROPERTY_V2    = 0x00000100,
    CLUSTER_CHANGE_CLUSTER_LOST_NOTIFICATIONS_V2  = 0x00000200,
    CLUSTER_CHANGE_CLUSTER_RENAME_V2              = 0x00000400,
    CLUSTER_CHANGE_CLUSTER_MEMBERSHIP_V2          = 0x00000800,
    CLUSTER_CHANGE_CLUSTER_UPGRADED_V2            = 0x00001000,
    CLUSTER_CHANGE_CLUSTER_ALL_V2                 = 0x00001fff,
}
alias CLUSTER_CHANGE_CLUSTER_V2 = int;

enum : int
{
    CLUSTER_CHANGE_GROUP_DELETED_V2          = 0x00000001,
    CLUSTER_CHANGE_GROUP_COMMON_PROPERTY_V2  = 0x00000002,
    CLUSTER_CHANGE_GROUP_PRIVATE_PROPERTY_V2 = 0x00000004,
    CLUSTER_CHANGE_GROUP_STATE_V2            = 0x00000008,
    CLUSTER_CHANGE_GROUP_OWNER_NODE_V2       = 0x00000010,
    CLUSTER_CHANGE_GROUP_PREFERRED_OWNERS_V2 = 0x00000020,
    CLUSTER_CHANGE_GROUP_RESOURCE_ADDED_V2   = 0x00000040,
    CLUSTER_CHANGE_GROUP_RESOURCE_GAINED_V2  = 0x00000080,
    CLUSTER_CHANGE_GROUP_RESOURCE_LOST_V2    = 0x00000100,
    CLUSTER_CHANGE_GROUP_HANDLE_CLOSE_V2     = 0x00000200,
    CLUSTER_CHANGE_GROUP_ALL_V2              = 0x000003ff,
}
alias CLUSTER_CHANGE_GROUP_V2 = int;

enum : int
{
    CLUSTER_CHANGE_GROUPSET_DELETED_v2          = 0x00000001,
    CLUSTER_CHANGE_GROUPSET_COMMON_PROPERTY_V2  = 0x00000002,
    CLUSTER_CHANGE_GROUPSET_PRIVATE_PROPERTY_V2 = 0x00000004,
    CLUSTER_CHANGE_GROUPSET_STATE_V2            = 0x00000008,
    CLUSTER_CHANGE_GROUPSET_GROUP_ADDED         = 0x00000010,
    CLUSTER_CHANGE_GROUPSET_GROUP_REMOVED       = 0x00000020,
    CLUSTER_CHANGE_GROUPSET_DEPENDENCIES_V2     = 0x00000040,
    CLUSTER_CHANGE_GROUPSET_DEPENDENTS_V2       = 0x00000080,
    CLUSTER_CHANGE_GROUPSET_HANDLE_CLOSE_v2     = 0x00000100,
    CLUSTER_CHANGE_GROUPSET_ALL_V2              = 0x000001ff,
}
alias CLUSTER_CHANGE_GROUPSET_V2 = int;

enum : int
{
    CLUSTER_CHANGE_RESOURCE_COMMON_PROPERTY_V2  = 0x00000001,
    CLUSTER_CHANGE_RESOURCE_PRIVATE_PROPERTY_V2 = 0x00000002,
    CLUSTER_CHANGE_RESOURCE_STATE_V2            = 0x00000004,
    CLUSTER_CHANGE_RESOURCE_OWNER_GROUP_V2      = 0x00000008,
    CLUSTER_CHANGE_RESOURCE_DEPENDENCIES_V2     = 0x00000010,
    CLUSTER_CHANGE_RESOURCE_DEPENDENTS_V2       = 0x00000020,
    CLUSTER_CHANGE_RESOURCE_POSSIBLE_OWNERS_V2  = 0x00000040,
    CLUSTER_CHANGE_RESOURCE_DELETED_V2          = 0x00000080,
    CLUSTER_CHANGE_RESOURCE_DLL_UPGRADED_V2     = 0x00000100,
    CLUSTER_CHANGE_RESOURCE_HANDLE_CLOSE_V2     = 0x00000200,
    CLUSTER_CHANGE_RESOURCE_TERMINAL_STATE_V2   = 0x00000400,
    CLUSTER_CHANGE_RESOURCE_ALL_V2              = 0x000007ff,
}
alias CLUSTER_CHANGE_RESOURCE_V2 = int;

enum : int
{
    CLUSTER_CHANGE_RESOURCE_TYPE_DELETED_V2          = 0x00000001,
    CLUSTER_CHANGE_RESOURCE_TYPE_COMMON_PROPERTY_V2  = 0x00000002,
    CLUSTER_CHANGE_RESOURCE_TYPE_PRIVATE_PROPERTY_V2 = 0x00000004,
    CLUSTER_CHANGE_RESOURCE_TYPE_POSSIBLE_OWNERS_V2  = 0x00000008,
    CLUSTER_CHANGE_RESOURCE_TYPE_DLL_UPGRADED_V2     = 0x00000010,
    CLUSTER_RESOURCE_TYPE_SPECIFIC_V2                = 0x00000020,
    CLUSTER_CHANGE_RESOURCE_TYPE_ALL_V2              = 0x0000003f,
}
alias CLUSTER_CHANGE_RESOURCE_TYPE_V2 = int;

enum : int
{
    CLUSTER_CHANGE_NETINTERFACE_DELETED_V2          = 0x00000001,
    CLUSTER_CHANGE_NETINTERFACE_COMMON_PROPERTY_V2  = 0x00000002,
    CLUSTER_CHANGE_NETINTERFACE_PRIVATE_PROPERTY_V2 = 0x00000004,
    CLUSTER_CHANGE_NETINTERFACE_STATE_V2            = 0x00000008,
    CLUSTER_CHANGE_NETINTERFACE_HANDLE_CLOSE_V2     = 0x00000010,
    CLUSTER_CHANGE_NETINTERFACE_ALL_V2              = 0x0000001f,
}
alias CLUSTER_CHANGE_NETINTERFACE_V2 = int;

enum : int
{
    CLUSTER_CHANGE_NETWORK_DELETED_V2          = 0x00000001,
    CLUSTER_CHANGE_NETWORK_COMMON_PROPERTY_V2  = 0x00000002,
    CLUSTER_CHANGE_NETWORK_PRIVATE_PROPERTY_V2 = 0x00000004,
    CLUSTER_CHANGE_NETWORK_STATE_V2            = 0x00000008,
    CLUSTER_CHANGE_NETWORK_HANDLE_CLOSE_V2     = 0x00000010,
    CLUSTER_CHANGE_NETWORK_ALL_V2              = 0x0000001f,
}
alias CLUSTER_CHANGE_NETWORK_V2 = int;

enum : int
{
    CLUSTER_CHANGE_NODE_NETINTERFACE_ADDED_V2 = 0x00000001,
    CLUSTER_CHANGE_NODE_DELETED_V2            = 0x00000002,
    CLUSTER_CHANGE_NODE_COMMON_PROPERTY_V2    = 0x00000004,
    CLUSTER_CHANGE_NODE_PRIVATE_PROPERTY_V2   = 0x00000008,
    CLUSTER_CHANGE_NODE_STATE_V2              = 0x00000010,
    CLUSTER_CHANGE_NODE_GROUP_GAINED_V2       = 0x00000020,
    CLUSTER_CHANGE_NODE_GROUP_LOST_V2         = 0x00000040,
    CLUSTER_CHANGE_NODE_HANDLE_CLOSE_V2       = 0x00000080,
    CLUSTER_CHANGE_NODE_ALL_V2                = 0x000000ff,
}
alias CLUSTER_CHANGE_NODE_V2 = int;

enum : int
{
    CLUSTER_CHANGE_REGISTRY_ATTRIBUTES_V2   = 0x00000001,
    CLUSTER_CHANGE_REGISTRY_NAME_V2         = 0x00000002,
    CLUSTER_CHANGE_REGISTRY_SUBTREE_V2      = 0x00000004,
    CLUSTER_CHANGE_REGISTRY_VALUE_V2        = 0x00000008,
    CLUSTER_CHANGE_REGISTRY_HANDLE_CLOSE_V2 = 0x00000010,
    CLUSTER_CHANGE_REGISTRY_ALL_V2          = 0x0000001f,
}
alias CLUSTER_CHANGE_REGISTRY_V2 = int;

enum : int
{
    CLUSTER_CHANGE_QUORUM_STATE_V2 = 0x00000001,
    CLUSTER_CHANGE_QUORUM_ALL_V2   = 0x00000001,
}
alias CLUSTER_CHANGE_QUORUM_V2 = int;

enum : int
{
    CLUSTER_CHANGE_SHARED_VOLUME_STATE_V2   = 0x00000001,
    CLUSTER_CHANGE_SHARED_VOLUME_ADDED_V2   = 0x00000002,
    CLUSTER_CHANGE_SHARED_VOLUME_REMOVED_V2 = 0x00000004,
    CLUSTER_CHANGE_SHARED_VOLUME_ALL_V2     = 0x00000007,
}
alias CLUSTER_CHANGE_SHARED_VOLUME_V2 = int;

enum : int
{
    CLUSTER_CHANGE_SPACEPORT_CUSTOM_PNP_V2 = 0x00000001,
}
alias CLUSTER_CHANGE_SPACEPORT_V2 = int;

enum : int
{
    CLUSTER_CHANGE_UPGRADE_NODE_PREPARE    = 0x00000001,
    CLUSTER_CHANGE_UPGRADE_NODE_COMMIT     = 0x00000002,
    CLUSTER_CHANGE_UPGRADE_NODE_POSTCOMMIT = 0x00000004,
    CLUSTER_CHANGE_UPGRADE_ALL             = 0x00000007,
}
alias CLUSTER_CHANGE_NODE_UPGRADE_PHASE_V2 = int;

enum : int
{
    CLUSTER_OBJECT_TYPE_NONE              = 0x00000000,
    CLUSTER_OBJECT_TYPE_CLUSTER           = 0x00000001,
    CLUSTER_OBJECT_TYPE_GROUP             = 0x00000002,
    CLUSTER_OBJECT_TYPE_RESOURCE          = 0x00000003,
    CLUSTER_OBJECT_TYPE_RESOURCE_TYPE     = 0x00000004,
    CLUSTER_OBJECT_TYPE_NETWORK_INTERFACE = 0x00000005,
    CLUSTER_OBJECT_TYPE_NETWORK           = 0x00000006,
    CLUSTER_OBJECT_TYPE_NODE              = 0x00000007,
    CLUSTER_OBJECT_TYPE_REGISTRY          = 0x00000008,
    CLUSTER_OBJECT_TYPE_QUORUM            = 0x00000009,
    CLUSTER_OBJECT_TYPE_SHARED_VOLUME     = 0x0000000a,
    CLUSTER_OBJECT_TYPE_GROUPSET          = 0x0000000d,
    CLUSTER_OBJECT_TYPE_AFFINITYRULE      = 0x00000010,
}
alias CLUSTER_OBJECT_TYPE = int;

enum : int
{
    CLUSTERSET_OBJECT_TYPE_NONE     = 0x00000000,
    CLUSTERSET_OBJECT_TYPE_MEMBER   = 0x00000001,
    CLUSTERSET_OBJECT_TYPE_WORKLOAD = 0x00000002,
    CLUSTERSET_OBJECT_TYPE_DATABASE = 0x00000003,
}
alias CLUSTERSET_OBJECT_TYPE = int;

enum : int
{
    CLUSTER_ENUM_NODE                   = 0x00000001,
    CLUSTER_ENUM_RESTYPE                = 0x00000002,
    CLUSTER_ENUM_RESOURCE               = 0x00000004,
    CLUSTER_ENUM_GROUP                  = 0x00000008,
    CLUSTER_ENUM_NETWORK                = 0x00000010,
    CLUSTER_ENUM_NETINTERFACE           = 0x00000020,
    CLUSTER_ENUM_SHARED_VOLUME_GROUP    = 0x20000000,
    CLUSTER_ENUM_SHARED_VOLUME_RESOURCE = 0x40000000,
    CLUSTER_ENUM_INTERNAL_NETWORK       = 0x80000000,
    CLUSTER_ENUM_ALL                    = 0x0000003f,
}
alias CLUSTER_ENUM = int;

enum : int
{
    CLUSTER_NODE_ENUM_NETINTERFACES    = 0x00000001,
    CLUSTER_NODE_ENUM_GROUPS           = 0x00000002,
    CLUSTER_NODE_ENUM_PREFERRED_GROUPS = 0x00000004,
    CLUSTER_NODE_ENUM_ALL              = 0x00000003,
}
alias CLUSTER_NODE_ENUM = int;

enum : int
{
    ClusterNodeStateUnknown = 0xffffffff,
    ClusterNodeUp           = 0x00000000,
    ClusterNodeDown         = 0x00000001,
    ClusterNodePaused       = 0x00000002,
    ClusterNodeJoining      = 0x00000003,
}
alias CLUSTER_NODE_STATE = int;

enum : int
{
    ClusterStorageNodeStateUnknown = 0x00000000,
    ClusterStorageNodeUp           = 0x00000001,
    ClusterStorageNodeDown         = 0x00000002,
    ClusterStorageNodePaused       = 0x00000003,
    ClusterStorageNodeStarting     = 0x00000004,
    ClusterStorageNodeStopping     = 0x00000005,
}
alias CLUSTER_STORAGENODE_STATE = int;

enum : int
{
    NodeDrainStatusNotInitiated = 0x00000000,
    NodeDrainStatusInProgress   = 0x00000001,
    NodeDrainStatusCompleted    = 0x00000002,
    NodeDrainStatusFailed       = 0x00000003,
    ClusterNodeDrainStatusCount = 0x00000004,
}
alias CLUSTER_NODE_DRAIN_STATUS = int;

enum : int
{
    NodeStatusNormal          = 0x00000000,
    NodeStatusIsolated        = 0x00000001,
    NodeStatusQuarantined     = 0x00000002,
    NodeStatusDrainInProgress = 0x00000004,
    NodeStatusDrainCompleted  = 0x00000008,
    NodeStatusDrainFailed     = 0x00000010,
    NodeStatusAvoidPlacement  = 0x00000020,
    NodeStatusMax             = 0x00000033,
}
alias CLUSTER_NODE_STATUS = int;

enum : int
{
    CLUSTER_GROUP_ENUM_CONTAINS = 0x00000001,
    CLUSTER_GROUP_ENUM_NODES    = 0x00000002,
    CLUSTER_GROUP_ENUM_ALL      = 0x00000003,
}
alias CLUSTER_GROUP_ENUM = int;

enum : int
{
    ClusterGroupStateUnknown  = 0xffffffff,
    ClusterGroupOnline        = 0x00000000,
    ClusterGroupOffline       = 0x00000001,
    ClusterGroupFailed        = 0x00000002,
    ClusterGroupPartialOnline = 0x00000003,
    ClusterGroupPending       = 0x00000004,
}
alias CLUSTER_GROUP_STATE = int;

enum : int
{
    PriorityDisabled = 0x00000000,
    PriorityLow      = 0x000003e8,
    PriorityMedium   = 0x000007d0,
    PriorityHigh     = 0x00000bb8,
}
alias CLUSTER_GROUP_PRIORITY = int;

enum : int
{
    ClusterGroupPreventFailback   = 0x00000000,
    ClusterGroupAllowFailback     = 0x00000001,
    ClusterGroupFailbackTypeCount = 0x00000002,
}
alias CLUSTER_GROUP_AUTOFAILBACK_TYPE = int;

enum : int
{
    DoNotFailbackGroups                = 0x00000000,
    FailbackGroupsImmediately          = 0x00000001,
    FailbackGroupsPerPolicy            = 0x00000002,
    ClusterNodeResumeFailbackTypeCount = 0x00000003,
}
alias CLUSTER_NODE_RESUME_FAILBACK_TYPE = int;

enum : int
{
    ClusterResourceStateUnknown   = 0xffffffff,
    ClusterResourceInherited      = 0x00000000,
    ClusterResourceInitializing   = 0x00000001,
    ClusterResourceOnline         = 0x00000002,
    ClusterResourceOffline        = 0x00000003,
    ClusterResourceFailed         = 0x00000004,
    ClusterResourcePending        = 0x00000080,
    ClusterResourceOnlinePending  = 0x00000081,
    ClusterResourceOfflinePending = 0x00000082,
}
alias CLUSTER_RESOURCE_STATE = int;

enum : int
{
    ClusterResourceDontRestart        = 0x00000000,
    ClusterResourceRestartNoNotify    = 0x00000001,
    ClusterResourceRestartNotify      = 0x00000002,
    ClusterResourceRestartActionCount = 0x00000003,
}
alias CLUSTER_RESOURCE_RESTART_ACTION = int;

enum : int
{
    ClusterResourceEmbeddedFailureActionNone    = 0x00000000,
    ClusterResourceEmbeddedFailureActionLogOnly = 0x00000001,
    ClusterResourceEmbeddedFailureActionRecover = 0x00000002,
}
alias CLUSTER_RESOURCE_EMBEDDED_FAILURE_ACTION = int;

enum : int
{
    CLUSTER_RESOURCE_DEFAULT_MONITOR  = 0x00000000,
    CLUSTER_RESOURCE_SEPARATE_MONITOR = 0x00000001,
    CLUSTER_RESOURCE_VALID_FLAGS      = 0x00000001,
}
alias CLUSTER_RESOURCE_CREATE_FLAGS = int;

enum : int
{
    ClusterSharedVolumeSnapshotStateUnknown = 0x00000000,
    ClusterSharedVolumePrepareForHWSnapshot = 0x00000001,
    ClusterSharedVolumeHWSnapshotCompleted  = 0x00000002,
    ClusterSharedVolumePrepareForFreeze     = 0x00000003,
}
alias CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE = int;

enum : int
{
    CLUSPROP_TYPE_UNKNOWN                      = 0xffffffff,
    CLUSPROP_TYPE_ENDMARK                      = 0x00000000,
    CLUSPROP_TYPE_LIST_VALUE                   = 0x00000001,
    CLUSPROP_TYPE_RESCLASS                     = 0x00000002,
    CLUSPROP_TYPE_RESERVED1                    = 0x00000003,
    CLUSPROP_TYPE_NAME                         = 0x00000004,
    CLUSPROP_TYPE_SIGNATURE                    = 0x00000005,
    CLUSPROP_TYPE_SCSI_ADDRESS                 = 0x00000006,
    CLUSPROP_TYPE_DISK_NUMBER                  = 0x00000007,
    CLUSPROP_TYPE_PARTITION_INFO               = 0x00000008,
    CLUSPROP_TYPE_FTSET_INFO                   = 0x00000009,
    CLUSPROP_TYPE_DISK_SERIALNUMBER            = 0x0000000a,
    CLUSPROP_TYPE_DISK_GUID                    = 0x0000000b,
    CLUSPROP_TYPE_DISK_SIZE                    = 0x0000000c,
    CLUSPROP_TYPE_PARTITION_INFO_EX            = 0x0000000d,
    CLUSPROP_TYPE_PARTITION_INFO_EX2           = 0x0000000e,
    CLUSPROP_TYPE_STORAGE_DEVICE_ID_DESCRIPTOR = 0x0000000f,
    CLUSPROP_TYPE_USER                         = 0x00008000,
}
alias CLUSTER_PROPERTY_TYPE = int;

enum : int
{
    CLUSPROP_FORMAT_UNKNOWN             = 0x00000000,
    CLUSPROP_FORMAT_BINARY              = 0x00000001,
    CLUSPROP_FORMAT_DWORD               = 0x00000002,
    CLUSPROP_FORMAT_SZ                  = 0x00000003,
    CLUSPROP_FORMAT_EXPAND_SZ           = 0x00000004,
    CLUSPROP_FORMAT_MULTI_SZ            = 0x00000005,
    CLUSPROP_FORMAT_ULARGE_INTEGER      = 0x00000006,
    CLUSPROP_FORMAT_LONG                = 0x00000007,
    CLUSPROP_FORMAT_EXPANDED_SZ         = 0x00000008,
    CLUSPROP_FORMAT_SECURITY_DESCRIPTOR = 0x00000009,
    CLUSPROP_FORMAT_LARGE_INTEGER       = 0x0000000a,
    CLUSPROP_FORMAT_WORD                = 0x0000000b,
    CLUSPROP_FORMAT_FILETIME            = 0x0000000c,
    CLUSPROP_FORMAT_VALUE_LIST          = 0x0000000d,
    CLUSPROP_FORMAT_PROPERTY_LIST       = 0x0000000e,
    CLUSPROP_FORMAT_USER                = 0x00008000,
}
alias CLUSTER_PROPERTY_FORMAT = int;

enum : uint
{
    CLUSPROP_SYNTAX_ENDMARK                        = 0x00000000,
    CLUSPROP_SYNTAX_NAME                           = 0x00040003,
    CLUSPROP_SYNTAX_RESCLASS                       = 0x00020002,
    CLUSPROP_SYNTAX_LIST_VALUE_SZ                  = 0x00010003,
    CLUSPROP_SYNTAX_LIST_VALUE_EXPAND_SZ           = 0x00010004,
    CLUSPROP_SYNTAX_LIST_VALUE_DWORD               = 0x00010002,
    CLUSPROP_SYNTAX_LIST_VALUE_BINARY              = 0x00010001,
    CLUSPROP_SYNTAX_LIST_VALUE_MULTI_SZ            = 0x00010005,
    CLUSPROP_SYNTAX_LIST_VALUE_LONG                = 0x00010007,
    CLUSPROP_SYNTAX_LIST_VALUE_EXPANDED_SZ         = 0x00010008,
    CLUSPROP_SYNTAX_LIST_VALUE_SECURITY_DESCRIPTOR = 0x00010009,
    CLUSPROP_SYNTAX_LIST_VALUE_LARGE_INTEGER       = 0x0001000a,
    CLUSPROP_SYNTAX_LIST_VALUE_ULARGE_INTEGER      = 0x00010006,
    CLUSPROP_SYNTAX_LIST_VALUE_WORD                = 0x0001000b,
    CLUSPROP_SYNTAX_LIST_VALUE_PROPERTY_LIST       = 0x0001000e,
    CLUSPROP_SYNTAX_LIST_VALUE_FILETIME            = 0x0001000c,
    CLUSPROP_SYNTAX_DISK_SIGNATURE                 = 0x00050002,
    CLUSPROP_SYNTAX_SCSI_ADDRESS                   = 0x00060002,
    CLUSPROP_SYNTAX_DISK_NUMBER                    = 0x00070002,
    CLUSPROP_SYNTAX_PARTITION_INFO                 = 0x00080001,
    CLUSPROP_SYNTAX_FTSET_INFO                     = 0x00090001,
    CLUSPROP_SYNTAX_DISK_SERIALNUMBER              = 0x000a0003,
    CLUSPROP_SYNTAX_DISK_GUID                      = 0x000b0003,
    CLUSPROP_SYNTAX_DISK_SIZE                      = 0x000c0006,
    CLUSPROP_SYNTAX_PARTITION_INFO_EX              = 0x000d0001,
    CLUSPROP_SYNTAX_PARTITION_INFO_EX2             = 0x000e0001,
    CLUSPROP_SYNTAX_STORAGE_DEVICE_ID_DESCRIPTOR   = 0x000f0001,
}
alias CLUSTER_PROPERTY_SYNTAX = uint;

enum : int
{
    CLUS_OBJECT_INVALID       = 0x00000000,
    CLUS_OBJECT_RESOURCE      = 0x00000001,
    CLUS_OBJECT_RESOURCE_TYPE = 0x00000002,
    CLUS_OBJECT_GROUP         = 0x00000003,
    CLUS_OBJECT_NODE          = 0x00000004,
    CLUS_OBJECT_NETWORK       = 0x00000005,
    CLUS_OBJECT_NETINTERFACE  = 0x00000006,
    CLUS_OBJECT_CLUSTER       = 0x00000007,
    CLUS_OBJECT_GROUPSET      = 0x00000008,
    CLUS_OBJECT_AFFINITYRULE  = 0x00000009,
    CLUS_OBJECT_USER          = 0x00000080,
}
alias CLUSTER_CONTROL_OBJECT = int;

enum : int
{
    CLCTL_UNKNOWN                                                   = 0x00000000,
    CLCTL_GET_CHARACTERISTICS                                       = 0x00000005,
    CLCTL_GET_FLAGS                                                 = 0x00000009,
    CLCTL_GET_CLASS_INFO                                            = 0x0000000d,
    CLCTL_GET_REQUIRED_DEPENDENCIES                                 = 0x00000011,
    CLCTL_GET_ARB_TIMEOUT                                           = 0x00000015,
    CLCTL_GET_FAILURE_INFO                                          = 0x00000019,
    CLCTL_GET_NAME                                                  = 0x00000029,
    CLCTL_GET_RESOURCE_TYPE                                         = 0x0000002d,
    CLCTL_GET_NODE                                                  = 0x00000031,
    CLCTL_GET_NETWORK                                               = 0x00000035,
    CLCTL_GET_ID                                                    = 0x00000039,
    CLCTL_GET_FQDN                                                  = 0x0000003d,
    CLCTL_GET_CLUSTER_SERVICE_ACCOUNT_NAME                          = 0x00000041,
    CLCTL_CHECK_VOTER_EVICT                                         = 0x00000045,
    CLCTL_CHECK_VOTER_DOWN                                          = 0x00000049,
    CLCTL_SHUTDOWN                                                  = 0x0000004d,
    CLCTL_ENUM_COMMON_PROPERTIES                                    = 0x00000051,
    CLCTL_GET_RO_COMMON_PROPERTIES                                  = 0x00000055,
    CLCTL_GET_COMMON_PROPERTIES                                     = 0x00000059,
    CLCTL_SET_COMMON_PROPERTIES                                     = 0x0040005e,
    CLCTL_VALIDATE_COMMON_PROPERTIES                                = 0x00000061,
    CLCTL_GET_COMMON_PROPERTY_FMTS                                  = 0x00000065,
    CLCTL_GET_COMMON_RESOURCE_PROPERTY_FMTS                         = 0x00000069,
    CLCTL_ENUM_PRIVATE_PROPERTIES                                   = 0x00000079,
    CLCTL_GET_RO_PRIVATE_PROPERTIES                                 = 0x0000007d,
    CLCTL_GET_PRIVATE_PROPERTIES                                    = 0x00000081,
    CLCTL_SET_PRIVATE_PROPERTIES                                    = 0x00400086,
    CLCTL_VALIDATE_PRIVATE_PROPERTIES                               = 0x00000089,
    CLCTL_GET_PRIVATE_PROPERTY_FMTS                                 = 0x0000008d,
    CLCTL_GET_PRIVATE_RESOURCE_PROPERTY_FMTS                        = 0x00000091,
    CLCTL_ADD_REGISTRY_CHECKPOINT                                   = 0x004000a2,
    CLCTL_DELETE_REGISTRY_CHECKPOINT                                = 0x004000a6,
    CLCTL_GET_REGISTRY_CHECKPOINTS                                  = 0x000000a9,
    CLCTL_ADD_CRYPTO_CHECKPOINT                                     = 0x004000ae,
    CLCTL_DELETE_CRYPTO_CHECKPOINT                                  = 0x004000b2,
    CLCTL_GET_CRYPTO_CHECKPOINTS                                    = 0x000000b5,
    CLCTL_RESOURCE_UPGRADE_DLL                                      = 0x004000ba,
    CLCTL_ADD_REGISTRY_CHECKPOINT_64BIT                             = 0x004000be,
    CLCTL_ADD_REGISTRY_CHECKPOINT_32BIT                             = 0x004000c2,
    CLCTL_GET_LOADBAL_PROCESS_LIST                                  = 0x000000c9,
    CLCTL_SET_ACCOUNT_ACCESS                                        = 0x004000f2,
    CLCTL_GET_NETWORK_NAME                                          = 0x00000169,
    CLCTL_NETNAME_GET_VIRTUAL_SERVER_TOKEN                          = 0x0000016d,
    CLCTL_NETNAME_REGISTER_DNS_RECORDS                              = 0x00000172,
    CLCTL_GET_DNS_NAME                                              = 0x00000175,
    CLCTL_NETNAME_SET_PWD_INFO                                      = 0x0000017a,
    CLCTL_NETNAME_DELETE_CO                                         = 0x0000017e,
    CLCTL_NETNAME_VALIDATE_VCO                                      = 0x00000181,
    CLCTL_NETNAME_RESET_VCO                                         = 0x00000185,
    CLCTL_NETNAME_REPAIR_VCO                                        = 0x0000018d,
    CLCTL_STORAGE_GET_DISK_INFO                                     = 0x00000191,
    CLCTL_STORAGE_GET_AVAILABLE_DISKS                               = 0x00000195,
    CLCTL_STORAGE_IS_PATH_VALID                                     = 0x00000199,
    CLCTL_STORAGE_SYNC_CLUSDISK_DB                                  = 0x0040019e,
    CLCTL_STORAGE_GET_DISK_NUMBER_INFO                              = 0x000001a1,
    CLCTL_QUERY_DELETE                                              = 0x000001b9,
    CLCTL_IPADDRESS_RENEW_LEASE                                     = 0x004001be,
    CLCTL_IPADDRESS_RELEASE_LEASE                                   = 0x004001c2,
    CLCTL_QUERY_MAINTENANCE_MODE                                    = 0x000001e1,
    CLCTL_SET_MAINTENANCE_MODE                                      = 0x004001e6,
    CLCTL_STORAGE_SET_DRIVELETTER                                   = 0x004001ea,
    CLCTL_STORAGE_GET_DRIVELETTERS                                  = 0x000001ed,
    CLCTL_STORAGE_GET_DISK_INFO_EX                                  = 0x000001f1,
    CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX                            = 0x000001f5,
    CLCTL_STORAGE_GET_DISK_INFO_EX2                                 = 0x000001f9,
    CLCTL_STORAGE_GET_CLUSPORT_DISK_COUNT                           = 0x000001fd,
    CLCTL_STORAGE_REMAP_DRIVELETTER                                 = 0x00000201,
    CLCTL_STORAGE_GET_DISKID                                        = 0x00000205,
    CLCTL_STORAGE_IS_CLUSTERABLE                                    = 0x00000209,
    CLCTL_STORAGE_REMOVE_VM_OWNERSHIP                               = 0x0040020e,
    CLCTL_STORAGE_GET_MOUNTPOINTS                                   = 0x00000211,
    CLCTL_STORAGE_GET_DIRTY                                         = 0x00000219,
    CLCTL_STORAGE_GET_SHARED_VOLUME_INFO                            = 0x00000225,
    CLCTL_STORAGE_IS_CSV_FILE                                       = 0x00000229,
    CLCTL_STORAGE_GET_RESOURCEID                                    = 0x0000022d,
    CLCTL_VALIDATE_PATH                                             = 0x00000231,
    CLCTL_VALIDATE_NETNAME                                          = 0x00000235,
    CLCTL_VALIDATE_DIRECTORY                                        = 0x00000239,
    CLCTL_BATCH_BLOCK_KEY                                           = 0x0000023e,
    CLCTL_BATCH_UNBLOCK_KEY                                         = 0x00000241,
    CLCTL_FILESERVER_SHARE_ADD                                      = 0x00400246,
    CLCTL_FILESERVER_SHARE_DEL                                      = 0x0040024a,
    CLCTL_FILESERVER_SHARE_MODIFY                                   = 0x0040024e,
    CLCTL_FILESERVER_SHARE_REPORT                                   = 0x00000251,
    CLCTL_NETNAME_GET_OU_FOR_VCO                                    = 0x0040026e,
    CLCTL_ENABLE_SHARED_VOLUME_DIRECTIO                             = 0x0040028a,
    CLCTL_DISABLE_SHARED_VOLUME_DIRECTIO                            = 0x0040028e,
    CLCTL_GET_SHARED_VOLUME_ID                                      = 0x00000291,
    CLCTL_SET_CSV_MAINTENANCE_MODE                                  = 0x00400296,
    CLCTL_SET_SHARED_VOLUME_BACKUP_MODE                             = 0x0040029a,
    CLCTL_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES                 = 0x0000029d,
    CLCTL_STORAGE_GET_SHARED_VOLUME_STATES                          = 0x004002a2,
    CLCTL_STORAGE_IS_SHARED_VOLUME                                  = 0x000002a5,
    CLCTL_GET_CLUSDB_TIMESTAMP                                      = 0x000002a9,
    CLCTL_RW_MODIFY_NOOP                                            = 0x004002ae,
    CLCTL_IS_QUORUM_BLOCKED                                         = 0x000002b1,
    CLCTL_POOL_GET_DRIVE_INFO                                       = 0x000002b5,
    CLCTL_GET_GUM_LOCK_OWNER                                        = 0x000002b9,
    CLCTL_GET_STUCK_NODES                                           = 0x000002bd,
    CLCTL_INJECT_GEM_FAULT                                          = 0x000002c1,
    CLCTL_INTRODUCE_GEM_REPAIR_DELAY                                = 0x000002c5,
    CLCTL_SEND_DUMMY_GEM_MESSAGES                                   = 0x000002c9,
    CLCTL_BLOCK_GEM_SEND_RECV                                       = 0x000002cd,
    CLCTL_GET_GEMID_VECTOR                                          = 0x000002d1,
    CLCTL_ADD_CRYPTO_CHECKPOINT_EX                                  = 0x004002d6,
    CLCTL_GROUP_GET_LAST_MOVE_TIME                                  = 0x000002d9,
    CLCTL_SET_STORAGE_CONFIGURATION                                 = 0x004002e2,
    CLCTL_GET_STORAGE_CONFIGURATION                                 = 0x000002e5,
    CLCTL_GET_STORAGE_CONFIG_ATTRIBUTES                             = 0x000002e9,
    CLCTL_REMOVE_NODE                                               = 0x004002ee,
    CLCTL_IS_FEATURE_INSTALLED                                      = 0x000002f1,
    CLCTL_IS_S2D_FEATURE_SUPPORTED                                  = 0x000002f5,
    CLCTL_STORAGE_GET_PHYSICAL_DISK_INFO                            = 0x000002f9,
    CLCTL_STORAGE_GET_CLUSBFLT_PATHS                                = 0x000002fd,
    CLCTL_STORAGE_GET_CLUSBFLT_PATHINFO                             = 0x00000301,
    CLCTL_CLEAR_NODE_CONNECTION_INFO                                = 0x00400306,
    CLCTL_SET_DNS_DOMAIN                                            = 0x0040030a,
    CTCTL_GET_ROUTESTATUS_BASIC                                     = 0x0000030d,
    CTCTL_GET_ROUTESTATUS_EXTENDED                                  = 0x00000311,
    CTCTL_GET_FAULT_DOMAIN_STATE                                    = 0x00000315,
    CLCTL_NETNAME_SET_PWD_INFOEX                                    = 0x0000031a,
    CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX2_INT                       = 0x00001fe1,
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS          = 0x000020e1,
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN                       = 0x004020e6,
    CLCTL_RESOURCE_PREPARE_UPGRADE                                  = 0x004020ea,
    CLCTL_RESOURCE_UPGRADE_COMPLETED                                = 0x004020ee,
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 0x000020f1,
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY                         = 0x004020f6,
    CLCTL_REPLICATION_GET_LOG_INFO                                  = 0x00002145,
    CLCTL_REPLICATION_GET_ELIGIBLE_LOGDISKS                         = 0x00002149,
    CLCTL_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS                 = 0x0000214d,
    CLCTL_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS                 = 0x00002151,
    CLCTL_REPLICATION_GET_REPLICATED_DISKS                          = 0x00002155,
    CLCTL_REPLICATION_GET_REPLICA_VOLUMES                           = 0x00002159,
    CLCTL_REPLICATION_GET_LOG_VOLUME                                = 0x0000215d,
    CLCTL_REPLICATION_GET_RESOURCE_GROUP                            = 0x00002161,
    CLCTL_REPLICATION_GET_REPLICATED_PARTITION_INFO                 = 0x00002165,
    CLCTL_GET_STATE_CHANGE_TIME                                     = 0x00002d5d,
    CLCTL_SET_CLUSTER_S2D_ENABLED                                   = 0x00402d62,
    CLCTL_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES              = 0x00402d6e,
    CLCTL_GROUPSET_GET_GROUPS                                       = 0x00002d71,
    CLCTL_GROUPSET_GET_PROVIDER_GROUPS                              = 0x00002d75,
    CLCTL_GROUPSET_GET_PROVIDER_GROUPSETS                           = 0x00002d79,
    CLCTL_GROUP_GET_PROVIDER_GROUPS                                 = 0x00002d7d,
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
    CLCTL_DELETE                                                    = 0x00500006,
    CLCTL_INSTALL_NODE                                              = 0x0050000a,
    CLCTL_EVICT_NODE                                                = 0x0050000e,
    CLCTL_ADD_DEPENDENCY                                            = 0x00500012,
    CLCTL_REMOVE_DEPENDENCY                                         = 0x00500016,
    CLCTL_ADD_OWNER                                                 = 0x0050001a,
    CLCTL_REMOVE_OWNER                                              = 0x0050001e,
    CLCTL_SET_NAME                                                  = 0x00500026,
    CLCTL_CLUSTER_NAME_CHANGED                                      = 0x0050002a,
    CLCTL_CLUSTER_VERSION_CHANGED                                   = 0x0050002e,
    CLCTL_FIXUP_ON_UPGRADE                                          = 0x00500032,
    CLCTL_STARTING_PHASE1                                           = 0x00500036,
    CLCTL_STARTING_PHASE2                                           = 0x0050003a,
    CLCTL_HOLD_IO                                                   = 0x0050003e,
    CLCTL_RESUME_IO                                                 = 0x00500042,
    CLCTL_FORCE_QUORUM                                              = 0x00500046,
    CLCTL_INITIALIZE                                                = 0x0050004a,
    CLCTL_STATE_CHANGE_REASON                                       = 0x0050004e,
    CLCTL_PROVIDER_STATE_CHANGE                                     = 0x00500052,
    CLCTL_LEAVING_GROUP                                             = 0x00500056,
    CLCTL_JOINING_GROUP                                             = 0x0050005a,
    CLCTL_FSWITNESS_GET_EPOCH_INFO                                  = 0x0010005d,
    CLCTL_FSWITNESS_SET_EPOCH_INFO                                  = 0x00500062,
    CLCTL_FSWITNESS_RELEASE_LOCK                                    = 0x00500066,
    CLCTL_NETNAME_CREDS_NOTIFYCAM                                   = 0x0050006a,
    CLCTL_NOTIFY_QUORUM_STATUS                                      = 0x0050007e,
    CLCTL_NOTIFY_MONITOR_SHUTTING_DOWN                              = 0x00100081,
    CLCTL_UNDELETE                                                  = 0x00500086,
    CLCTL_GET_OPERATION_CONTEXT                                     = 0x001020e9,
    CLCTL_NOTIFY_OWNER_CHANGE                                       = 0x00502122,
    CLCTL_VALIDATE_CHANGE_GROUP                                     = 0x00102125,
    CLCTL_CHECK_DRAIN_VETO                                          = 0x0010212d,
    CLCTL_NOTIFY_DRAIN_COMPLETE                                     = 0x00102131,
}
alias CLCTL_CODES = int;

enum : int
{
    CLUSCTL_RESOURCE_UNKNOWN                                   = 0x01000000,
    CLUSCTL_RESOURCE_GET_CHARACTERISTICS                       = 0x01000005,
    CLUSCTL_RESOURCE_GET_FLAGS                                 = 0x01000009,
    CLUSCTL_RESOURCE_GET_CLASS_INFO                            = 0x0100000d,
    CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES                 = 0x01000011,
    CLUSCTL_RESOURCE_GET_NAME                                  = 0x01000029,
    CLUSCTL_RESOURCE_GET_ID                                    = 0x01000039,
    CLUSCTL_RESOURCE_GET_RESOURCE_TYPE                         = 0x0100002d,
    CLUSCTL_RESOURCE_ENUM_COMMON_PROPERTIES                    = 0x01000051,
    CLUSCTL_RESOURCE_GET_RO_COMMON_PROPERTIES                  = 0x01000055,
    CLUSCTL_RESOURCE_GET_COMMON_PROPERTIES                     = 0x01000059,
    CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES                     = 0x0140005e,
    CLUSCTL_RESOURCE_VALIDATE_COMMON_PROPERTIES                = 0x01000061,
    CLUSCTL_RESOURCE_GET_COMMON_PROPERTY_FMTS                  = 0x01000065,
    CLUSCTL_RESOURCE_ENUM_PRIVATE_PROPERTIES                   = 0x01000079,
    CLUSCTL_RESOURCE_GET_RO_PRIVATE_PROPERTIES                 = 0x0100007d,
    CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTIES                    = 0x01000081,
    CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES                    = 0x01400086,
    CLUSCTL_RESOURCE_VALIDATE_PRIVATE_PROPERTIES               = 0x01000089,
    CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTY_FMTS                 = 0x0100008d,
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT                   = 0x014000a2,
    CLUSCTL_RESOURCE_DELETE_REGISTRY_CHECKPOINT                = 0x014000a6,
    CLUSCTL_RESOURCE_GET_REGISTRY_CHECKPOINTS                  = 0x010000a9,
    CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT                     = 0x014000ae,
    CLUSCTL_RESOURCE_DELETE_CRYPTO_CHECKPOINT                  = 0x014000b2,
    CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT_EX                  = 0x014002d6,
    CLUSCTL_RESOURCE_GET_CRYPTO_CHECKPOINTS                    = 0x010000b5,
    CLUSCTL_RESOURCE_GET_LOADBAL_PROCESS_LIST                  = 0x010000c9,
    CLUSCTL_RESOURCE_GET_NETWORK_NAME                          = 0x01000169,
    CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN          = 0x0100016d,
    CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFO                      = 0x0100017a,
    CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFOEX                    = 0x0100031a,
    CLUSCTL_RESOURCE_NETNAME_DELETE_CO                         = 0x0100017e,
    CLUSCTL_RESOURCE_NETNAME_VALIDATE_VCO                      = 0x01000181,
    CLUSCTL_RESOURCE_NETNAME_RESET_VCO                         = 0x01000185,
    CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO                        = 0x0100018d,
    CLUSCTL_RESOURCE_NETNAME_REGISTER_DNS_RECORDS              = 0x01000172,
    CLUSCTL_RESOURCE_GET_DNS_NAME                              = 0x01000175,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO                     = 0x01000191,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_NUMBER_INFO              = 0x010001a1,
    CLUSCTL_RESOURCE_STORAGE_IS_PATH_VALID                     = 0x01000199,
    CLUSCTL_RESOURCE_QUERY_DELETE                              = 0x010001b9,
    CLUSCTL_RESOURCE_UPGRADE_DLL                               = 0x014000ba,
    CLUSCTL_RESOURCE_IPADDRESS_RENEW_LEASE                     = 0x014001be,
    CLUSCTL_RESOURCE_IPADDRESS_RELEASE_LEASE                   = 0x014001c2,
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_64BIT             = 0x014000be,
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_32BIT             = 0x014000c2,
    CLUSCTL_RESOURCE_QUERY_MAINTENANCE_MODE                    = 0x010001e1,
    CLUSCTL_RESOURCE_SET_MAINTENANCE_MODE                      = 0x014001e6,
    CLUSCTL_RESOURCE_STORAGE_SET_DRIVELETTER                   = 0x014001ea,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX                  = 0x010001f1,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX2                 = 0x010001f9,
    CLUSCTL_RESOURCE_STORAGE_GET_MOUNTPOINTS                   = 0x01000211,
    CLUSCTL_RESOURCE_STORAGE_GET_DIRTY                         = 0x01000219,
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_INFO            = 0x01000225,
    CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE                  = 0x01400296,
    CLUSCTL_RESOURCE_ENABLE_SHARED_VOLUME_DIRECTIO             = 0x0140028a,
    CLUSCTL_RESOURCE_DISABLE_SHARED_VOLUME_DIRECTIO            = 0x0140028e,
    CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE             = 0x0140029a,
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES = 0x0100029d,
    CLUSCTL_RESOURCE_GET_FAILURE_INFO                          = 0x01000019,
    CLUSCTL_RESOURCE_STORAGE_GET_DISKID                        = 0x01000205,
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_STATES          = 0x014002a2,
    CLUSCTL_RESOURCE_STORAGE_IS_SHARED_VOLUME                  = 0x010002a5,
    CLUSCTL_RESOURCE_IS_QUORUM_BLOCKED                         = 0x010002b1,
    CLUSCTL_RESOURCE_POOL_GET_DRIVE_INFO                       = 0x010002b5,
    CLUSCTL_RESOURCE_RLUA_GET_VIRTUAL_SERVER_TOKEN             = 0x0100016d,
    CLUSCTL_RESOURCE_RLUA_SET_PWD_INFO                         = 0x0100017a,
    CLUSCTL_RESOURCE_RLUA_SET_PWD_INFOEX                       = 0x0100031a,
    CLUSCTL_RESOURCE_DELETE                                    = 0x01500006,
    CLUSCTL_RESOURCE_UNDELETE                                  = 0x01500086,
    CLUSCTL_RESOURCE_INSTALL_NODE                              = 0x0150000a,
    CLUSCTL_RESOURCE_EVICT_NODE                                = 0x0150000e,
    CLUSCTL_RESOURCE_ADD_DEPENDENCY                            = 0x01500012,
    CLUSCTL_RESOURCE_REMOVE_DEPENDENCY                         = 0x01500016,
    CLUSCTL_RESOURCE_ADD_OWNER                                 = 0x0150001a,
    CLUSCTL_RESOURCE_REMOVE_OWNER                              = 0x0150001e,
    CLUSCTL_RESOURCE_SET_NAME                                  = 0x01500026,
    CLUSCTL_RESOURCE_CLUSTER_NAME_CHANGED                      = 0x0150002a,
    CLUSCTL_RESOURCE_CLUSTER_VERSION_CHANGED                   = 0x0150002e,
    CLUSCTL_RESOURCE_FORCE_QUORUM                              = 0x01500046,
    CLUSCTL_RESOURCE_INITIALIZE                                = 0x0150004a,
    CLUSCTL_RESOURCE_STATE_CHANGE_REASON                       = 0x0150004e,
    CLUSCTL_RESOURCE_PROVIDER_STATE_CHANGE                     = 0x01500052,
    CLUSCTL_RESOURCE_LEAVING_GROUP                             = 0x01500056,
    CLUSCTL_RESOURCE_JOINING_GROUP                             = 0x0150005a,
    CLUSCTL_RESOURCE_FSWITNESS_GET_EPOCH_INFO                  = 0x0110005d,
    CLUSCTL_RESOURCE_FSWITNESS_SET_EPOCH_INFO                  = 0x01500062,
    CLUSCTL_RESOURCE_FSWITNESS_RELEASE_LOCK                    = 0x01500066,
    CLUSCTL_RESOURCE_NETNAME_CREDS_NOTIFYCAM                   = 0x0150006a,
    CLUSCTL_RESOURCE_GET_OPERATION_CONTEXT                     = 0x011020e9,
    CLUSCTL_RESOURCE_RW_MODIFY_NOOP                            = 0x014002ae,
    CLUSCTL_RESOURCE_NOTIFY_QUORUM_STATUS                      = 0x0150007e,
    CLUSCTL_RESOURCE_NOTIFY_OWNER_CHANGE                       = 0x01502122,
    CLUSCTL_RESOURCE_VALIDATE_CHANGE_GROUP                     = 0x01102125,
    CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME              = 0x01002dd6,
    CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME_GUID         = 0x01002dda,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN                = 0x014020e6,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY                  = 0x014020f6,
    CLUSCTL_RESOURCE_PREPARE_UPGRADE                           = 0x014020ea,
    CLUSCTL_RESOURCE_UPGRADE_COMPLETED                         = 0x014020ee,
    CLUSCTL_RESOURCE_GET_STATE_CHANGE_TIME                     = 0x01002d5d,
    CLUSCTL_RESOURCE_GET_INFRASTRUCTURE_SOFS_BUFFER            = 0x01002d89,
    CLUSCTL_RESOURCE_SET_INFRASTRUCTURE_SOFS_BUFFER            = 0x01402d8e,
    CLUSCTL_RESOURCE_SCALEOUT_COMMAND                          = 0x01402d96,
    CLUSCTL_RESOURCE_SCALEOUT_CONTROL                          = 0x01402d9a,
    CLUSCTL_RESOURCE_SCALEOUT_GET_CLUSTERS                     = 0x01402d9d,
    CLUSCTL_RESOURCE_CHECK_DRAIN_VETO                          = 0x0110212d,
    CLUSCTL_RESOURCE_NOTIFY_DRAIN_COMPLETE                     = 0x01102131,
}
alias CLUSCTL_RESOURCE_CODES = int;

enum : int
{
    CLUSCTL_RESOURCE_TYPE_UNKNOWN                                     = 0x02000000,
    CLUSCTL_RESOURCE_TYPE_GET_CHARACTERISTICS                         = 0x02000005,
    CLUSCTL_RESOURCE_TYPE_GET_FLAGS                                   = 0x02000009,
    CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO                              = 0x0200000d,
    CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES                   = 0x02000011,
    CLUSCTL_RESOURCE_TYPE_GET_ARB_TIMEOUT                             = 0x02000015,
    CLUSCTL_RESOURCE_TYPE_ENUM_COMMON_PROPERTIES                      = 0x02000051,
    CLUSCTL_RESOURCE_TYPE_GET_RO_COMMON_PROPERTIES                    = 0x02000055,
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTIES                       = 0x02000059,
    CLUSCTL_RESOURCE_TYPE_VALIDATE_COMMON_PROPERTIES                  = 0x02000061,
    CLUSCTL_RESOURCE_TYPE_SET_COMMON_PROPERTIES                       = 0x0240005e,
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTY_FMTS                    = 0x02000065,
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_RESOURCE_PROPERTY_FMTS           = 0x02000069,
    CLUSCTL_RESOURCE_TYPE_ENUM_PRIVATE_PROPERTIES                     = 0x02000079,
    CLUSCTL_RESOURCE_TYPE_GET_RO_PRIVATE_PROPERTIES                   = 0x0200007d,
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTIES                      = 0x02000081,
    CLUSCTL_RESOURCE_TYPE_SET_PRIVATE_PROPERTIES                      = 0x02400086,
    CLUSCTL_RESOURCE_TYPE_VALIDATE_PRIVATE_PROPERTIES                 = 0x02000089,
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTY_FMTS                   = 0x0200008d,
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_RESOURCE_PROPERTY_FMTS          = 0x02000091,
    CLUSCTL_RESOURCE_TYPE_GET_REGISTRY_CHECKPOINTS                    = 0x020000a9,
    CLUSCTL_RESOURCE_TYPE_GET_CRYPTO_CHECKPOINTS                      = 0x020000b5,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS                 = 0x02000195,
    CLUSCTL_RESOURCE_TYPE_STORAGE_SYNC_CLUSDISK_DB                    = 0x0240019e,
    CLUSCTL_RESOURCE_TYPE_NETNAME_VALIDATE_NETNAME                    = 0x02000235,
    CLUSCTL_RESOURCE_TYPE_NETNAME_GET_OU_FOR_VCO                      = 0x0240026e,
    CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_PATH                       = 0x02000231,
    CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_DIRECTORY                  = 0x02000239,
    CLUSCTL_RESOURCE_TYPE_GEN_SCRIPT_VALIDATE_PATH                    = 0x02000231,
    CLUSCTL_RESOURCE_TYPE_QUERY_DELETE                                = 0x020001b9,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DRIVELETTERS                    = 0x020001ed,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX              = 0x020001f5,
    CLUSCTL_RESOURCE_TYPE_STORAGE_REMAP_DRIVELETTER                   = 0x02000201,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DISKID                          = 0x02000205,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_RESOURCEID                      = 0x0200022d,
    CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CLUSTERABLE                      = 0x02000209,
    CLUSCTL_RESOURCE_TYPE_STORAGE_REMOVE_VM_OWNERSHIP                 = 0x0240020e,
    CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CSV_FILE                         = 0x01000229,
    CLUSCTL_RESOURCE_TYPE_WITNESS_VALIDATE_PATH                       = 0x02000231,
    CLUSCTL_RESOURCE_TYPE_INSTALL_NODE                                = 0x0250000a,
    CLUSCTL_RESOURCE_TYPE_EVICT_NODE                                  = 0x0250000e,
    CLUSCTL_RESOURCE_TYPE_CLUSTER_VERSION_CHANGED                     = 0x0250002e,
    CLUSCTL_RESOURCE_TYPE_FIXUP_ON_UPGRADE                            = 0x02500032,
    CLUSCTL_RESOURCE_TYPE_STARTING_PHASE1                             = 0x02500036,
    CLUSCTL_RESOURCE_TYPE_STARTING_PHASE2                             = 0x0250003a,
    CLUSCTL_RESOURCE_TYPE_HOLD_IO                                     = 0x0250003e,
    CLUSCTL_RESOURCE_TYPE_RESUME_IO                                   = 0x02500042,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INT         = 0x02001fe1,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_LOGDISKS           = 0x02002149,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS   = 0x0200214d,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS   = 0x02002151,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_DISKS            = 0x02002155,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICA_VOLUMES             = 0x02002159,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_VOLUME                  = 0x0200215d,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_RESOURCE_GROUP              = 0x02002161,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_PARTITION_INFO   = 0x02002165,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_INFO                    = 0x02002145,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS          = 0x020020e1,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 0x020020f1,
    CLUSCTL_RESOURCE_TYPE_PREPARE_UPGRADE                             = 0x024020ea,
    CLUSCTL_RESOURCE_TYPE_UPGRADE_COMPLETED                           = 0x024020ee,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_MONITOR_SHUTTING_DOWN                = 0x02100081,
    CLUSCTL_RESOURCE_TYPE_CHECK_DRAIN_VETO                            = 0x0210212d,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_DRAIN_COMPLETE                       = 0x02102131,
}
alias CLUSCTL_RESOURCE_TYPE_CODES = int;

enum : int
{
    CLUSCTL_GROUP_UNKNOWN                     = 0x03000000,
    CLUSCTL_GROUP_GET_CHARACTERISTICS         = 0x03000005,
    CLUSCTL_GROUP_GET_FLAGS                   = 0x03000009,
    CLUSCTL_GROUP_GET_NAME                    = 0x03000029,
    CLUSCTL_GROUP_GET_ID                      = 0x03000039,
    CLUSCTL_GROUP_ENUM_COMMON_PROPERTIES      = 0x03000051,
    CLUSCTL_GROUP_GET_RO_COMMON_PROPERTIES    = 0x03000055,
    CLUSCTL_GROUP_GET_COMMON_PROPERTIES       = 0x03000059,
    CLUSCTL_GROUP_SET_COMMON_PROPERTIES       = 0x0340005e,
    CLUSCTL_GROUP_VALIDATE_COMMON_PROPERTIES  = 0x03000061,
    CLUSCTL_GROUP_ENUM_PRIVATE_PROPERTIES     = 0x03000079,
    CLUSCTL_GROUP_GET_RO_PRIVATE_PROPERTIES   = 0x0300007d,
    CLUSCTL_GROUP_GET_PRIVATE_PROPERTIES      = 0x03000081,
    CLUSCTL_GROUP_SET_PRIVATE_PROPERTIES      = 0x03400086,
    CLUSCTL_GROUP_VALIDATE_PRIVATE_PROPERTIES = 0x03000089,
    CLUSCTL_GROUP_QUERY_DELETE                = 0x030001b9,
    CLUSCTL_GROUP_GET_COMMON_PROPERTY_FMTS    = 0x03000065,
    CLUSCTL_GROUP_GET_PRIVATE_PROPERTY_FMTS   = 0x0300008d,
    CLUSCTL_GROUP_GET_FAILURE_INFO            = 0x03000019,
    CLUSCTL_GROUP_GET_LAST_MOVE_TIME          = 0x030002d9,
    CLUSCTL_GROUP_SET_CCF_FROM_MASTER         = 0x03402d86,
}
alias CLUSCTL_GROUP_CODES = int;

enum : int
{
    CLUSCTL_NODE_UNKNOWN                          = 0x04000000,
    CLUSCTL_NODE_GET_CHARACTERISTICS              = 0x04000005,
    CLUSCTL_NODE_GET_FLAGS                        = 0x04000009,
    CLUSCTL_NODE_GET_NAME                         = 0x04000029,
    CLUSCTL_NODE_GET_ID                           = 0x04000039,
    CLUSCTL_NODE_ENUM_COMMON_PROPERTIES           = 0x04000051,
    CLUSCTL_NODE_GET_RO_COMMON_PROPERTIES         = 0x04000055,
    CLUSCTL_NODE_GET_COMMON_PROPERTIES            = 0x04000059,
    CLUSCTL_NODE_SET_COMMON_PROPERTIES            = 0x0440005e,
    CLUSCTL_NODE_VALIDATE_COMMON_PROPERTIES       = 0x04000061,
    CLUSCTL_NODE_ENUM_PRIVATE_PROPERTIES          = 0x04000079,
    CLUSCTL_NODE_GET_RO_PRIVATE_PROPERTIES        = 0x0400007d,
    CLUSCTL_NODE_GET_PRIVATE_PROPERTIES           = 0x04000081,
    CLUSCTL_NODE_SET_PRIVATE_PROPERTIES           = 0x04400086,
    CLUSCTL_NODE_VALIDATE_PRIVATE_PROPERTIES      = 0x04000089,
    CLUSCTL_NODE_GET_COMMON_PROPERTY_FMTS         = 0x04000065,
    CLUSCTL_NODE_GET_PRIVATE_PROPERTY_FMTS        = 0x0400008d,
    CLUSCTL_NODE_GET_CLUSTER_SERVICE_ACCOUNT_NAME = 0x04000041,
    CLUSCTL_NODE_GET_STUCK_NODES                  = 0x040002bd,
    CLUSCTL_NODE_INJECT_GEM_FAULT                 = 0x040002c1,
    CLUSCTL_NODE_INTRODUCE_GEM_REPAIR_DELAY       = 0x040002c5,
    CLUSCTL_NODE_SEND_DUMMY_GEM_MESSAGES          = 0x040002c9,
    CLUSCTL_NODE_BLOCK_GEM_SEND_RECV              = 0x040002cd,
    CLUSCTL_NODE_GET_GEMID_VECTOR                 = 0x040002d1,
}
alias CLUSCTL_NODE_CODES = int;

enum : int
{
    CLUSCTL_NETWORK_UNKNOWN                     = 0x05000000,
    CLUSCTL_NETWORK_GET_CHARACTERISTICS         = 0x05000005,
    CLUSCTL_NETWORK_GET_FLAGS                   = 0x05000009,
    CLUSCTL_NETWORK_GET_NAME                    = 0x05000029,
    CLUSCTL_NETWORK_GET_ID                      = 0x05000039,
    CLUSCTL_NETWORK_ENUM_COMMON_PROPERTIES      = 0x05000051,
    CLUSCTL_NETWORK_GET_RO_COMMON_PROPERTIES    = 0x05000055,
    CLUSCTL_NETWORK_GET_COMMON_PROPERTIES       = 0x05000059,
    CLUSCTL_NETWORK_SET_COMMON_PROPERTIES       = 0x0540005e,
    CLUSCTL_NETWORK_VALIDATE_COMMON_PROPERTIES  = 0x05000061,
    CLUSCTL_NETWORK_ENUM_PRIVATE_PROPERTIES     = 0x05000079,
    CLUSCTL_NETWORK_GET_RO_PRIVATE_PROPERTIES   = 0x0500007d,
    CLUSCTL_NETWORK_GET_PRIVATE_PROPERTIES      = 0x05000081,
    CLUSCTL_NETWORK_SET_PRIVATE_PROPERTIES      = 0x05400086,
    CLUSCTL_NETWORK_VALIDATE_PRIVATE_PROPERTIES = 0x05000089,
    CLUSCTL_NETWORK_GET_COMMON_PROPERTY_FMTS    = 0x05000065,
    CLUSCTL_NETWORK_GET_PRIVATE_PROPERTY_FMTS   = 0x0500008d,
}
alias CLUSCTL_NETWORK_CODES = int;

enum : int
{
    CLUSCTL_NETINTERFACE_UNKNOWN                     = 0x06000000,
    CLUSCTL_NETINTERFACE_GET_CHARACTERISTICS         = 0x06000005,
    CLUSCTL_NETINTERFACE_GET_FLAGS                   = 0x06000009,
    CLUSCTL_NETINTERFACE_GET_NAME                    = 0x06000029,
    CLUSCTL_NETINTERFACE_GET_ID                      = 0x06000039,
    CLUSCTL_NETINTERFACE_GET_NODE                    = 0x06000031,
    CLUSCTL_NETINTERFACE_GET_NETWORK                 = 0x06000035,
    CLUSCTL_NETINTERFACE_ENUM_COMMON_PROPERTIES      = 0x06000051,
    CLUSCTL_NETINTERFACE_GET_RO_COMMON_PROPERTIES    = 0x06000055,
    CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTIES       = 0x06000059,
    CLUSCTL_NETINTERFACE_SET_COMMON_PROPERTIES       = 0x0640005e,
    CLUSCTL_NETINTERFACE_VALIDATE_COMMON_PROPERTIES  = 0x06000061,
    CLUSCTL_NETINTERFACE_ENUM_PRIVATE_PROPERTIES     = 0x06000079,
    CLUSCTL_NETINTERFACE_GET_RO_PRIVATE_PROPERTIES   = 0x0600007d,
    CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTIES      = 0x06000081,
    CLUSCTL_NETINTERFACE_SET_PRIVATE_PROPERTIES      = 0x06400086,
    CLUSCTL_NETINTERFACE_VALIDATE_PRIVATE_PROPERTIES = 0x06000089,
    CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTY_FMTS    = 0x06000065,
    CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTY_FMTS   = 0x0600008d,
}
alias CLUSCTL_NETINTERFACE_CODES = int;

enum : int
{
    CLUSCTL_CLUSTER_UNKNOWN                                      = 0x07000000,
    CLUSCTL_CLUSTER_GET_FQDN                                     = 0x0700003d,
    CLUSCTL_CLUSTER_SET_STORAGE_CONFIGURATION                    = 0x074002e2,
    CLUSCTL_CLUSTER_GET_STORAGE_CONFIGURATION                    = 0x070002e5,
    CLUSCTL_CLUSTER_GET_STORAGE_CONFIG_ATTRIBUTES                = 0x070002e9,
    CLUSCTL_CLUSTER_ENUM_COMMON_PROPERTIES                       = 0x07000051,
    CLUSCTL_CLUSTER_GET_RO_COMMON_PROPERTIES                     = 0x07000055,
    CLUSCTL_CLUSTER_GET_COMMON_PROPERTIES                        = 0x07000059,
    CLUSCTL_CLUSTER_SET_COMMON_PROPERTIES                        = 0x0740005e,
    CLUSCTL_CLUSTER_VALIDATE_COMMON_PROPERTIES                   = 0x07000061,
    CLUSCTL_CLUSTER_ENUM_PRIVATE_PROPERTIES                      = 0x07000079,
    CLUSCTL_CLUSTER_GET_RO_PRIVATE_PROPERTIES                    = 0x0700007d,
    CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTIES                       = 0x07000081,
    CLUSCTL_CLUSTER_SET_PRIVATE_PROPERTIES                       = 0x07400086,
    CLUSCTL_CLUSTER_VALIDATE_PRIVATE_PROPERTIES                  = 0x07000089,
    CLUSCTL_CLUSTER_GET_COMMON_PROPERTY_FMTS                     = 0x07000065,
    CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTY_FMTS                    = 0x0700008d,
    CLUSCTL_CLUSTER_CHECK_VOTER_EVICT                            = 0x07000045,
    CLUSCTL_CLUSTER_CHECK_VOTER_DOWN                             = 0x07000049,
    CLUSCTL_CLUSTER_SHUTDOWN                                     = 0x0700004d,
    CLUSCTL_CLUSTER_BATCH_BLOCK_KEY                              = 0x0700023e,
    CLUSCTL_CLUSTER_BATCH_UNBLOCK_KEY                            = 0x07000241,
    CLUSCTL_CLUSTER_GET_SHARED_VOLUME_ID                         = 0x07000291,
    CLUSCTL_CLUSTER_GET_CLUSDB_TIMESTAMP                         = 0x070002a9,
    CLUSCTL_CLUSTER_GET_GUM_LOCK_OWNER                           = 0x070002b9,
    CLUSCTL_CLUSTER_REMOVE_NODE                                  = 0x074002ee,
    CLUSCTL_CLUSTER_SET_ACCOUNT_ACCESS                           = 0x074000f2,
    CLUSCTL_CLUSTER_CLEAR_NODE_CONNECTION_INFO                   = 0x07400306,
    CLUSCTL_CLUSTER_SET_DNS_DOMAIN                               = 0x0740030a,
    CLUSCTL_CLUSTER_SET_CLUSTER_S2D_ENABLED                      = 0x07402d62,
    CLUSCTL_CLUSTER_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES = 0x07402d6e,
    CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME                 = 0x07002dd6,
    CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME_GUID            = 0x07002dda,
    CLUSCTL_CLUSTER_RELOAD_AUTOLOGGER_CONFIG                     = 0x07002dd2,
    CLUSCTL_CLUSTER_ENUM_AFFINITY_RULE_NAMES                     = 0x07002ddd,
}
alias CLUSCTL_CLUSTER_CODES = int;

enum : int
{
    CLUSCTL_GROUPSET_GET_COMMON_PROPERTIES    = 0x08000059,
    CLUSCTL_GROUPSET_GET_RO_COMMON_PROPERTIES = 0x08000055,
    CLUSCTL_GROUPSET_SET_COMMON_PROPERTIES    = 0x0840005e,
    CLUSCTL_GROUPSET_GET_GROUPS               = 0x08002d71,
    CLUSCTL_GROUPSET_GET_PROVIDER_GROUPS      = 0x08002d75,
    CLUSCTL_GROUPSET_GET_PROVIDER_GROUPSETS   = 0x08002d79,
    CLUSCTL_GROUP_GET_PROVIDER_GROUPS         = 0x08002d7d,
    CLUSCTL_GROUP_GET_PROVIDER_GROUPSETS      = 0x08002d81,
    CLUSCTL_GROUPSET_GET_ID                   = 0x08000039,
}
alias CLUSCTL_GROUPSET_CODES = int;

enum : int
{
    CLUSCTL_AFFINITYRULE_GET_COMMON_PROPERTIES    = 0x09000059,
    CLUSCTL_AFFINITYRULE_GET_RO_COMMON_PROPERTIES = 0x09000055,
    CLUSCTL_AFFINITYRULE_SET_COMMON_PROPERTIES    = 0x0940005e,
    CLUSCTL_AFFINITYRULE_GET_ID                   = 0x09000039,
    CLUSCTL_AFFINITYRULE_GET_GROUPNAMES           = 0x09002d71,
}
alias CLUSCTL_AFFINITYRULE_CODES = int;

enum : int
{
    CLUS_RESCLASS_UNKNOWN = 0x00000000,
    CLUS_RESCLASS_STORAGE = 0x00000001,
    CLUS_RESCLASS_NETWORK = 0x00000002,
    CLUS_RESCLASS_USER    = 0x00008000,
}
alias CLUSTER_RESOURCE_CLASS = int;

enum : int
{
    CLUS_RESSUBCLASS_SHARED = 0x80000000,
}
alias CLUS_RESSUBCLASS = int;

enum : int
{
    CLUS_RESSUBCLASS_STORAGE_SHARED_BUS  = 0x80000000,
    CLUS_RESSUBCLASS_STORAGE_DISK        = 0x40000000,
    CLUS_RESSUBCLASS_STORAGE_REPLICATION = 0x10000000,
}
alias CLUS_RESSUBCLASS_STORAGE = int;

enum : int
{
    CLUS_RESSUBCLASS_NETWORK_INTERNET_PROTOCOL = 0x80000000,
}
alias CLUS_RESSUBCLASS_NETWORK = int;

enum : int
{
    CLUS_CHAR_UNKNOWN                        = 0x00000000,
    CLUS_CHAR_QUORUM                         = 0x00000001,
    CLUS_CHAR_DELETE_REQUIRES_ALL_NODES      = 0x00000002,
    CLUS_CHAR_LOCAL_QUORUM                   = 0x00000004,
    CLUS_CHAR_LOCAL_QUORUM_DEBUG             = 0x00000008,
    CLUS_CHAR_REQUIRES_STATE_CHANGE_REASON   = 0x00000010,
    CLUS_CHAR_BROADCAST_DELETE               = 0x00000020,
    CLUS_CHAR_SINGLE_CLUSTER_INSTANCE        = 0x00000040,
    CLUS_CHAR_SINGLE_GROUP_INSTANCE          = 0x00000080,
    CLUS_CHAR_COEXIST_IN_SHARED_VOLUME_GROUP = 0x00000100,
    CLUS_CHAR_PLACEMENT_DATA                 = 0x00000200,
    CLUS_CHAR_MONITOR_DETACH                 = 0x00000400,
    CLUS_CHAR_MONITOR_REATTACH               = 0x00000800,
    CLUS_CHAR_OPERATION_CONTEXT              = 0x00001000,
    CLUS_CHAR_CLONES                         = 0x00002000,
    CLUS_CHAR_NOT_PREEMPTABLE                = 0x00004000,
    CLUS_CHAR_NOTIFY_NEW_OWNER               = 0x00008000,
    CLUS_CHAR_SUPPORTS_UNMONITORED_STATE     = 0x00010000,
    CLUS_CHAR_INFRASTRUCTURE                 = 0x00020000,
    CLUS_CHAR_VETO_DRAIN                     = 0x00040000,
}
alias CLUS_CHARACTERISTICS = int;

enum : int
{
    CLUS_FLAG_CORE = 0x00000001,
}
alias CLUS_FLAGS = int;

enum : int
{
    CLUSPROP_PIFLAG_STICKY             = 0x00000001,
    CLUSPROP_PIFLAG_REMOVABLE          = 0x00000002,
    CLUSPROP_PIFLAG_USABLE             = 0x00000004,
    CLUSPROP_PIFLAG_DEFAULT_QUORUM     = 0x00000008,
    CLUSPROP_PIFLAG_USABLE_FOR_CSV     = 0x00000010,
    CLUSPROP_PIFLAG_ENCRYPTION_ENABLED = 0x00000020,
    CLUSPROP_PIFLAG_RAW                = 0x00000040,
    CLUSPROP_PIFLAG_UNKNOWN            = 0x80000000,
}
alias CLUSPROP_PIFLAGS = int;

enum : int
{
    VolumeStateNoFaults      = 0x00000000,
    VolumeStateNoDirectIO    = 0x00000001,
    VolumeStateNoAccess      = 0x00000002,
    VolumeStateInMaintenance = 0x00000004,
    VolumeStateDismounted    = 0x00000008,
}
alias CLUSTER_CSV_VOLUME_FAULT_STATE = int;

enum : int
{
    VolumeBackupNone       = 0x00000000,
    VolumeBackupInProgress = 0x00000001,
}
alias CLUSTER_SHARED_VOLUME_BACKUP_STATE = int;

enum : int
{
    SharedVolumeStateUnavailable            = 0x00000000,
    SharedVolumeStatePaused                 = 0x00000001,
    SharedVolumeStateActive                 = 0x00000002,
    SharedVolumeStateActiveRedirected       = 0x00000003,
    SharedVolumeStateActiveVolumeRedirected = 0x00000004,
}
alias CLUSTER_SHARED_VOLUME_STATE = int;

enum : int
{
    ClusterSharedVolumeRenameInputTypeNone         = 0x00000000,
    ClusterSharedVolumeRenameInputTypeVolumeOffset = 0x00000001,
    ClusterSharedVolumeRenameInputTypeVolumeId     = 0x00000002,
    ClusterSharedVolumeRenameInputTypeVolumeName   = 0x00000003,
    ClusterSharedVolumeRenameInputTypeVolumeGuid   = 0x00000004,
}
alias CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE = int;

enum : int
{
    MaintenanceModeTypeDisableIsAliveCheck = 0x00000001,
    MaintenanceModeTypeOfflineResource     = 0x00000002,
    MaintenanceModeTypeUnclusterResource   = 0x00000003,
}
alias MAINTENANCE_MODE_TYPE_ENUM = int;

enum : int
{
    CLUSPROP_IPADDR_ENABLENETBIOS_DISABLED  = 0x00000000,
    CLUSPROP_IPADDR_ENABLENETBIOS_ENABLED   = 0x00000001,
    CLUSPROP_IPADDR_ENABLENETBIOS_TRACK_NIC = 0x00000002,
}
alias CLUSPROP_IPADDR_ENABLENETBIOS = int;

enum : int
{
    FILESHARE_CHANGE_NONE   = 0x00000000,
    FILESHARE_CHANGE_ADD    = 0x00000001,
    FILESHARE_CHANGE_DEL    = 0x00000002,
    FILESHARE_CHANGE_MODIFY = 0x00000003,
}
alias FILESHARE_CHANGE_ENUM = int;

enum : int
{
    CLUSTER_RESOURCE_ENUM_DEPENDS  = 0x00000001,
    CLUSTER_RESOURCE_ENUM_PROVIDES = 0x00000002,
    CLUSTER_RESOURCE_ENUM_NODES    = 0x00000004,
    CLUSTER_RESOURCE_ENUM_ALL      = 0x00000007,
}
alias CLUSTER_RESOURCE_ENUM = int;

enum : int
{
    CLUSTER_RESOURCE_TYPE_ENUM_NODES     = 0x00000001,
    CLUSTER_RESOURCE_TYPE_ENUM_RESOURCES = 0x00000002,
    CLUSTER_RESOURCE_TYPE_ENUM_ALL       = 0x00000003,
}
alias CLUSTER_RESOURCE_TYPE_ENUM = int;

enum : int
{
    CLUSTER_NETWORK_ENUM_NETINTERFACES = 0x00000001,
    CLUSTER_NETWORK_ENUM_ALL           = 0x00000001,
}
alias CLUSTER_NETWORK_ENUM = int;

enum : int
{
    ClusterNetworkStateUnknown = 0xffffffff,
    ClusterNetworkUnavailable  = 0x00000000,
    ClusterNetworkDown         = 0x00000001,
    ClusterNetworkPartitioned  = 0x00000002,
    ClusterNetworkUp           = 0x00000003,
}
alias CLUSTER_NETWORK_STATE = int;

enum : int
{
    ClusterNetworkRoleNone              = 0x00000000,
    ClusterNetworkRoleInternalUse       = 0x00000001,
    ClusterNetworkRoleClientAccess      = 0x00000002,
    ClusterNetworkRoleInternalAndClient = 0x00000003,
}
alias CLUSTER_NETWORK_ROLE = int;

enum : int
{
    ClusterNetInterfaceStateUnknown = 0xffffffff,
    ClusterNetInterfaceUnavailable  = 0x00000000,
    ClusterNetInterfaceFailed       = 0x00000001,
    ClusterNetInterfaceUnreachable  = 0x00000002,
    ClusterNetInterfaceUp           = 0x00000003,
}
alias CLUSTER_NETINTERFACE_STATE = int;

enum : int
{
    ClusterSetupPhaseInitialize                 = 0x00000001,
    ClusterSetupPhaseValidateNodeState          = 0x00000064,
    ClusterSetupPhaseValidateNetft              = 0x00000066,
    ClusterSetupPhaseValidateClusDisk           = 0x00000067,
    ClusterSetupPhaseConfigureClusSvc           = 0x00000068,
    ClusterSetupPhaseStartingClusSvc            = 0x00000069,
    ClusterSetupPhaseQueryClusterNameAccount    = 0x0000006a,
    ClusterSetupPhaseValidateClusterNameAccount = 0x0000006b,
    ClusterSetupPhaseCreateClusterAccount       = 0x0000006c,
    ClusterSetupPhaseConfigureClusterAccount    = 0x0000006d,
    ClusterSetupPhaseFormingCluster             = 0x000000c8,
    ClusterSetupPhaseAddClusterProperties       = 0x000000c9,
    ClusterSetupPhaseCreateResourceTypes        = 0x000000ca,
    ClusterSetupPhaseCreateGroups               = 0x000000cb,
    ClusterSetupPhaseCreateIPAddressResources   = 0x000000cc,
    ClusterSetupPhaseCreateNetworkName          = 0x000000cd,
    ClusterSetupPhaseClusterGroupOnline         = 0x000000ce,
    ClusterSetupPhaseGettingCurrentMembership   = 0x0000012c,
    ClusterSetupPhaseAddNodeToCluster           = 0x0000012d,
    ClusterSetupPhaseNodeUp                     = 0x0000012e,
    ClusterSetupPhaseMoveGroup                  = 0x00000190,
    ClusterSetupPhaseDeleteGroup                = 0x00000191,
    ClusterSetupPhaseCleanupCOs                 = 0x00000192,
    ClusterSetupPhaseOfflineGroup               = 0x00000193,
    ClusterSetupPhaseEvictNode                  = 0x00000194,
    ClusterSetupPhaseCleanupNode                = 0x00000195,
    ClusterSetupPhaseCoreGroupCleanup           = 0x00000196,
    ClusterSetupPhaseFailureCleanup             = 0x000003e7,
}
alias CLUSTER_SETUP_PHASE = int;

enum : int
{
    ClusterSetupPhaseStart    = 0x00000001,
    ClusterSetupPhaseContinue = 0x00000002,
    ClusterSetupPhaseEnd      = 0x00000003,
    ClusterSetupPhaseReport   = 0x00000004,
}
alias CLUSTER_SETUP_PHASE_TYPE = int;

enum : int
{
    ClusterSetupPhaseInformational = 0x00000001,
    ClusterSetupPhaseWarning       = 0x00000002,
    ClusterSetupPhaseFatal         = 0x00000003,
}
alias CLUSTER_SETUP_PHASE_SEVERITY = int;

enum : int
{
    PLACEMENT_OPTIONS_MIN_VALUE                                                   = 0x00000000,
    PLACEMENT_OPTIONS_DEFAULT_PLACEMENT_OPTIONS                                   = 0x00000000,
    PLACEMENT_OPTIONS_DISABLE_CSV_VM_DEPENDENCY                                   = 0x00000001,
    PLACEMENT_OPTIONS_CONSIDER_OFFLINE_VMS                                        = 0x00000002,
    PLACEMENT_OPTIONS_DONT_USE_MEMORY                                             = 0x00000004,
    PLACEMENT_OPTIONS_DONT_USE_CPU                                                = 0x00000008,
    PLACEMENT_OPTIONS_DONT_USE_LOCAL_TEMP_DISK                                    = 0x00000010,
    PLACEMENT_OPTIONS_DONT_RESUME_VMS_WITH_EXISTING_TEMP_DISK                     = 0x00000020,
    PLACEMENT_OPTIONS_SAVE_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE                 = 0x00000040,
    PLACEMENT_OPTIONS_DONT_RESUME_AVAILABILTY_SET_VMS_WITH_EXISTING_TEMP_DISK     = 0x00000080,
    PLACEMENT_OPTIONS_SAVE_AVAILABILTY_SET_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE = 0x00000100,
    PLACEMENT_OPTIONS_AVAILABILITY_SET_DOMAIN_AFFINITY                            = 0x00000200,
    PLACEMENT_OPTIONS_ALL                                                         = 0x000003ff,
}
alias PLACEMENT_OPTIONS = int;

enum : int
{
    GRP_PLACEMENT_OPTIONS_MIN_VALUE             = 0x00000000,
    GRP_PLACEMENT_OPTIONS_DEFAULT               = 0x00000000,
    GRP_PLACEMENT_OPTIONS_DISABLE_AUTOBALANCING = 0x00000001,
    GRP_PLACEMENT_OPTIONS_ALL                   = 0x00000001,
}
alias GRP_PLACEMENT_OPTIONS = int;

enum : int
{
    SrReplicatedDiskTypeNone                = 0x00000000,
    SrReplicatedDiskTypeSource              = 0x00000001,
    SrReplicatedDiskTypeLogSource           = 0x00000002,
    SrReplicatedDiskTypeDestination         = 0x00000003,
    SrReplicatedDiskTypeLogDestination      = 0x00000004,
    SrReplicatedDiskTypeNotInParthership    = 0x00000005,
    SrReplicatedDiskTypeLogNotInParthership = 0x00000006,
    SrReplicatedDiskTypeOther               = 0x00000007,
}
alias SR_REPLICATED_DISK_TYPE = int;

enum : int
{
    SrDiskReplicationEligibleNone                    = 0x00000000,
    SrDiskReplicationEligibleYes                     = 0x00000001,
    SrDiskReplicationEligibleOffline                 = 0x00000002,
    SrDiskReplicationEligibleNotGpt                  = 0x00000003,
    SrDiskReplicationEligiblePartitionLayoutMismatch = 0x00000004,
    SrDiskReplicationEligibleInsufficientFreeSpace   = 0x00000005,
    SrDiskReplicationEligibleNotInSameSite           = 0x00000006,
    SrDiskReplicationEligibleInSameSite              = 0x00000007,
    SrDiskReplicationEligibleFileSystemNotSupported  = 0x00000008,
    SrDiskReplicationEligibleAlreadyInReplication    = 0x00000009,
    SrDiskReplicationEligibleSameAsSpecifiedDisk     = 0x0000000a,
    SrDiskReplicationEligibleOther                   = 0x0000270f,
}
alias SR_DISK_REPLICATION_ELIGIBLE = int;

enum : int
{
    VmResdllContextTurnOff       = 0x00000000,
    VmResdllContextSave          = 0x00000001,
    VmResdllContextShutdown      = 0x00000002,
    VmResdllContextShutdownForce = 0x00000003,
    VmResdllContextLiveMigration = 0x00000004,
}
alias VM_RESDLL_CONTEXT = int;

enum : int
{
    ResdllContextOperationTypeFailback                   = 0x00000000,
    ResdllContextOperationTypeDrain                      = 0x00000001,
    ResdllContextOperationTypeDrainFailure               = 0x00000002,
    ResdllContextOperationTypeEmbeddedFailure            = 0x00000003,
    ResdllContextOperationTypePreemption                 = 0x00000004,
    ResdllContextOperationTypeNetworkDisconnect          = 0x00000005,
    ResdllContextOperationTypeNetworkDisconnectMoveRetry = 0x00000006,
}
alias RESDLL_CONTEXT_OPERATION_TYPE = int;

enum : int
{
    LOG_INFORMATION = 0x00000000,
    LOG_WARNING     = 0x00000001,
    LOG_ERROR       = 0x00000002,
    LOG_SEVERE      = 0x00000003,
}
alias LOG_LEVEL = int;

enum : int
{
    ResourceExitStateContinue  = 0x00000000,
    ResourceExitStateTerminate = 0x00000001,
    ResourceExitStateMax       = 0x00000002,
}
alias RESOURCE_EXIT_STATE = int;

enum : int
{
    FAILURE_TYPE_GENERAL      = 0x00000000,
    FAILURE_TYPE_EMBEDDED     = 0x00000001,
    FAILURE_TYPE_NETWORK_LOSS = 0x00000002,
}
alias FAILURE_TYPE = int;

enum : int
{
    ClusterResourceApplicationStateUnknown = 0x00000001,
    ClusterResourceApplicationOSHeartBeat  = 0x00000002,
    ClusterResourceApplicationReady        = 0x00000003,
}
alias CLUSTER_RESOURCE_APPLICATION_STATE = int;

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
alias RESOURCE_MONITOR_STATE = int;

enum : int
{
    ClusterRoleDHCP                        = 0x00000000,
    ClusterRoleDTC                         = 0x00000001,
    ClusterRoleFileServer                  = 0x00000002,
    ClusterRoleGenericApplication          = 0x00000003,
    ClusterRoleGenericScript               = 0x00000004,
    ClusterRoleGenericService              = 0x00000005,
    ClusterRoleISCSINameServer             = 0x00000006,
    ClusterRoleMSMQ                        = 0x00000007,
    ClusterRoleNFS                         = 0x00000008,
    ClusterRolePrintServer                 = 0x00000009,
    ClusterRoleStandAloneNamespaceServer   = 0x0000000a,
    ClusterRoleVolumeShadowCopyServiceTask = 0x0000000b,
    ClusterRoleWINS                        = 0x0000000c,
    ClusterRoleTaskScheduler               = 0x0000000d,
    ClusterRoleNetworkFileSystem           = 0x0000000e,
    ClusterRoleDFSReplicatedFolder         = 0x0000000f,
    ClusterRoleDistributedFileSystem       = 0x00000010,
    ClusterRoleDistributedNetworkName      = 0x00000011,
    ClusterRoleFileShare                   = 0x00000012,
    ClusterRoleFileShareWitness            = 0x00000013,
    ClusterRoleHardDisk                    = 0x00000014,
    ClusterRoleIPAddress                   = 0x00000015,
    ClusterRoleIPV6Address                 = 0x00000016,
    ClusterRoleIPV6TunnelAddress           = 0x00000017,
    ClusterRoleISCSITargetServer           = 0x00000018,
    ClusterRoleNetworkName                 = 0x00000019,
    ClusterRolePhysicalDisk                = 0x0000001a,
    ClusterRoleSODAFileServer              = 0x0000001b,
    ClusterRoleStoragePool                 = 0x0000001c,
    ClusterRoleVirtualMachine              = 0x0000001d,
    ClusterRoleVirtualMachineConfiguration = 0x0000001e,
    ClusterRoleVirtualMachineReplicaBroker = 0x0000001f,
}
alias CLUSTER_ROLE = int;

enum : int
{
    ClusterRoleUnknown     = 0xffffffff,
    ClusterRoleClustered   = 0x00000000,
    ClusterRoleUnclustered = 0x00000001,
}
alias CLUSTER_ROLE_STATE = int;

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
alias CLUADMEX_OBJECT_TYPE = int;

// Callbacks

alias PCLUSAPI_GET_NODE_CLUSTER_STATE = uint function(const(wchar)* lpszNodeName, uint* pdwClusterState);
alias PCLUSAPI_OPEN_CLUSTER = _HCLUSTER* function(const(wchar)* lpszClusterName);
alias PCLUSAPI_OPEN_CLUSTER_EX = _HCLUSTER* function(const(wchar)* lpszClusterName, uint dwDesiredAccess, 
                                                     uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER = BOOL function(_HCLUSTER* hCluster);
alias PCLUSAPI_SetClusterName = uint function(_HCLUSTER* hCluster, const(wchar)* lpszNewClusterName);
alias PCLUSAPI_GET_CLUSTER_INFORMATION = uint function(_HCLUSTER* hCluster, const(wchar)* lpszClusterName, 
                                                       uint* lpcchClusterName, CLUSTERVERSIONINFO* lpClusterInfo);
alias PCLUSAPI_GET_CLUSTER_QUORUM_RESOURCE = uint function(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, 
                                                           uint* lpcchResourceName, const(wchar)* lpszDeviceName, 
                                                           uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);
alias PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE = uint function(_HRESOURCE* hResource, const(wchar)* lpszDeviceName, 
                                                           uint dwMaxQuoLogSize);
alias PCLUSAPI_BACKUP_CLUSTER_DATABASE = uint function(_HCLUSTER* hCluster, const(wchar)* lpszPathName);
alias PCLUSAPI_RESTORE_CLUSTER_DATABASE = uint function(const(wchar)* lpszPathName, BOOL bForce, 
                                                        const(wchar)* lpszQuorumDriveLetter);
alias PCLUSAPI_SET_CLUSTER_NETWORK_PRIORITY_ORDER = uint function(_HCLUSTER* hCluster, uint NetworkCount, 
                                                                  char* NetworkList);
alias PCLUSAPI_SET_CLUSTER_SERVICE_ACCOUNT_PASSWORD = uint function(const(wchar)* lpszClusterName, 
                                                                    const(wchar)* lpszNewPassword, uint dwFlags, 
                                                                    char* lpReturnStatusBuffer, 
                                                                    uint* lpcbReturnStatusBufferSize);
alias PCLUSAPI_CLUSTER_CONTROL = uint function(_HCLUSTER* hCluster, _HNODE* hHostNode, uint dwControlCode, 
                                               char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                                               uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSTER_UPGRADE_PROGRESS_CALLBACK = BOOL function(void* pvCallbackArg, CLUSTER_UPGRADE_PHASE eUpgradePhase);
alias PCLUSAPI_CLUSTER_UPGRADE = uint function(_HCLUSTER* hCluster, BOOL perform, 
                                               PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, 
                                               void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT_V2 = _HCHANGE* function(_HCHANGE* hChange, _HCLUSTER* hCluster, 
                                                                  NOTIFY_FILTER_AND_TYPE* Filters, 
                                                                  uint dwFilterCount, size_t dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY_V2 = uint function(_HCHANGE* hChange, NOTIFY_FILTER_AND_TYPE Filter, 
                                                          HANDLE hObject, size_t dwNotifyKey);
alias PCLUSAPI_GET_NOTIFY_EVENT_HANDLE_V2 = uint function(_HCHANGE* hChange, ptrdiff_t* lphTargetEvent);
alias PCLUSAPI_GET_CLUSTER_NOTIFY_V2 = uint function(_HCHANGE* hChange, size_t* lpdwNotifyKey, 
                                                     NOTIFY_FILTER_AND_TYPE* pFilterAndType, ubyte* buffer, 
                                                     uint* lpcchBufferSize, const(wchar)* lpszObjectId, 
                                                     uint* lpcchObjectId, const(wchar)* lpszParentId, 
                                                     uint* lpcchParentId, const(wchar)* lpszName, uint* lpcchName, 
                                                     const(wchar)* lpszType, uint* lpcchType, uint dwMilliseconds);
alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT = _HCHANGE* function(_HCHANGE* hChange, _HCLUSTER* hCluster, 
                                                               uint dwFilter, size_t dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY = uint function(_HCHANGE* hChange, uint dwFilterType, HANDLE hObject, 
                                                       size_t dwNotifyKey);
alias PCLUSAPI_GET_CLUSTER_NOTIFY = uint function(_HCHANGE* hChange, size_t* lpdwNotifyKey, uint* lpdwFilterType, 
                                                  const(wchar)* lpszName, uint* lpcchName, uint dwMilliseconds);
alias PCLUSAPI_CLOSE_CLUSTER_NOTIFY_PORT = BOOL function(_HCHANGE* hChange);
alias PCLUSAPI_CLUSTER_OPEN_ENUM = _HCLUSENUM* function(_HCLUSTER* hCluster, uint dwType);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT = uint function(_HCLUSENUM* hEnum);
alias PCLUSAPI_CLUSTER_ENUM = uint function(_HCLUSENUM* hEnum, uint dwIndex, uint* lpdwType, 
                                            const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM = uint function(_HCLUSENUM* hEnum);
alias PCLUSAPI_CLUSTER_OPEN_ENUM_EX = _HCLUSENUMEX* function(_HCLUSTER* hCluster, uint dwType, void* pOptions);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT_EX = uint function(_HCLUSENUMEX* hClusterEnum);
alias PCLUSAPI_CLUSTER_ENUM_EX = uint function(_HCLUSENUMEX* hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, 
                                               uint* cbItem);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM_EX = uint function(_HCLUSENUMEX* hClusterEnum);
alias PCLUSAPI_CREATE_CLUSTER_GROUP_GROUPSET = _HGROUPSET* function(_HCLUSTER* hCluster, 
                                                                    const(wchar)* lpszGroupSetName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_GROUPSET = _HGROUPSET* function(_HCLUSTER* hCluster, 
                                                                  const(wchar)* lpszGroupSetName);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP_GROUPSET = BOOL function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_DELETE_CLUSTER_GROUP_GROUPSET = uint function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_GROUP_GROUPSET = uint function(_HGROUPSET* hGroupSet, _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_GROUP_GROUPSET = uint function(_HGROUPSET* hGroupSet, _HGROUP* hGroupName);
alias PCLUSAPI_CLUSTER_GROUP_GROUPSET_CONTROL = uint function(_HGROUPSET* hGroupSet, _HNODE* hHostNode, 
                                                              uint dwControlCode, char* lpInBuffer, 
                                                              uint cbInBufferSize, char* lpOutBuffer, 
                                                              uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_ADD_CLUSTER_GROUP_DEPENDENCY = uint function(_HGROUP* hDependentGroup, _HGROUP* hProviderGroup);
alias PCLUSAPI_SET_GROUP_DEPENDENCY_EXPRESSION = uint function(_HGROUP* hGroupSet, 
                                                               const(wchar)* lpszDependencyExpression);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_DEPENDENCY = uint function(_HGROUP* hGroup, _HGROUP* hDependsOn);
alias PCLUSAPI_ADD_CLUSTER_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hDependentGroupSet, 
                                                                     _HGROUPSET* hProviderGroupSet);
alias PCLUSAPI_SET_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EXPRESSION = uint function(_HGROUPSET* hGroupSet, 
                                                                                const(wchar)* lpszDependencyExpression);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hGroupSet, 
                                                                        _HGROUPSET* hDependsOn);
alias PCLUSAPI_ADD_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUP* hDependentGroup, 
                                                                              _HGROUPSET* hProviderGroupSet);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = uint function(_HGROUP* hGroup, 
                                                                                 _HGROUPSET* hDependsOn);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP_GROUPSET = _HCLUSTER* function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_ADD_CROSS_CLUSTER_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hDependentGroupSet, 
                                                                     const(wchar)* lpRemoteClusterName, 
                                                                     const(wchar)* lpRemoteGroupSetName);
alias PCLUSAPI_REMOVE_CROSS_CLUSTER_GROUPSET_DEPENDENCY = uint function(_HGROUPSET* hDependentGroupSet, 
                                                                        const(wchar)* lpRemoteClusterName, 
                                                                        const(wchar)* lpRemoteGroupSetName);
alias PCLUSAPI_CREATE_CLUSTER_AVAILABILITY_SET = _HGROUPSET* function(_HCLUSTER* hCluster, 
                                                                      const(wchar)* lpAvailabilitySetName, 
                                                                      CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);
alias PCLUSAPI_CLUSTER_CREATE_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(wchar)* ruleName, 
                                                            CLUS_AFFINITY_RULE_TYPE ruleType);
alias PCLUSAPI_CLUSTER_REMOVE_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(wchar)* ruleName);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(wchar)* ruleName, 
                                                                  _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_AFFINITY_RULE = uint function(_HCLUSTER* hCluster, const(wchar)* ruleName, 
                                                                       _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_AFFINITY_RULE_CONTROL = uint function(_HCLUSTER* hCluster, const(wchar)* affinityRuleName, 
                                                             _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, 
                                                             uint cbInBufferSize, char* lpOutBuffer, 
                                                             uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_OPEN_CLUSTER_NODE = _HNODE* function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName);
alias PCLUSAPI_OPEN_CLUSTER_NODE_EX = _HNODE* function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, 
                                                       uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_OPEN_NODE_BY_ID = _HNODE* function(_HCLUSTER* hCluster, uint nodeId);
alias PCLUSAPI_CLOSE_CLUSTER_NODE = BOOL function(_HNODE* hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_STATE = CLUSTER_NODE_STATE function(_HNODE* hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_ID = uint function(_HNODE* hNode, const(wchar)* lpszNodeId, uint* lpcchName);
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
                                                 const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_EVICT_CLUSTER_NODE_EX = uint function(_HNODE* hNode, uint dwTimeOut, int* phrCleanupStatus);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_TYPE_KEY = HKEY function(_HCLUSTER* hCluster, const(wchar)* lpszTypeName, 
                                                             uint samDesired);
alias PCLUSAPI_CREATE_CLUSTER_GROUP = _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP = _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_EX = _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, 
                                                         uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_PAUSE_CLUSTER_NODE_EX = uint function(_HNODE* hNode, BOOL bDrainNode, uint dwPauseFlags, 
                                                     _HNODE* hNodeDrainTarget);
alias PCLUSAPI_RESUME_CLUSTER_NODE_EX = uint function(_HNODE* hNode, 
                                                      CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                                                      uint dwResumeFlagsReserved);
alias PCLUSAPI_CREATE_CLUSTER_GROUPEX = _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, 
                                                          CLUSTER_CREATE_GROUP_INFO* pGroupInfo);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM_EX = _HGROUPENUMEX* function(_HCLUSTER* hCluster, 
                                                                    const(wchar)* lpszProperties, uint cbProperties, 
                                                                    const(wchar)* lpszRoProperties, 
                                                                    uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT_EX = uint function(_HGROUPENUMEX* hGroupEnumEx);
alias PCLUSAPI_CLUSTER_GROUP_ENUM_EX = uint function(_HGROUPENUMEX* hGroupEnumEx, uint dwIndex, 
                                                     CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM_EX = uint function(_HGROUPENUMEX* hGroupEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM_EX = _HRESENUMEX* function(_HCLUSTER* hCluster, 
                                                                     const(wchar)* lpszProperties, uint cbProperties, 
                                                                     const(wchar)* lpszRoProperties, 
                                                                     uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT_EX = uint function(_HRESENUMEX* hResourceEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM_EX = uint function(_HRESENUMEX* hResourceEnumEx, uint dwIndex, 
                                                        CLUSTER_RESOURCE_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM_EX = uint function(_HRESENUMEX* hResourceEnumEx);
alias PCLUSAPI_RESTART_CLUSTER_RESOURCE = uint function(_HRESOURCE* hResource, uint dwFlags);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP = BOOL function(_HGROUP* hGroup);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP = _HCLUSTER* function(_HGROUP* hGroup);
alias PCLUSAPI_GET_CLUSTER_GROUP_STATE = CLUSTER_GROUP_STATE function(_HGROUP* hGroup, const(wchar)* lpszNodeName, 
                                                                      uint* lpcchNodeName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NAME = uint function(_HGROUP* hGroup, const(wchar)* lpszGroupName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST = uint function(_HGROUP* hGroup, uint NodeCount, char* NodeList);
alias PCLUSAPI_ONLINE_CLUSTER_GROUP = uint function(_HGROUP* hGroup, _HNODE* hDestinationNode);
alias PCLUSAPI_MOVE_CLUSTER_GROUP = uint function(_HGROUP* hGroup, _HNODE* hDestinationNode);
alias PCLUSAPI_OFFLINE_CLUSTER_GROUP = uint function(_HGROUP* hGroup);
alias PCLUSAPI_DELETE_CLUSTER_GROUP = uint function(_HGROUP* hGroup);
alias PCLUSAPI_DESTROY_CLUSTER_GROUP = uint function(_HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM = _HGROUPENUM* function(_HGROUP* hGroup, uint dwType);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT = uint function(_HGROUPENUM* hGroupEnum);
alias PCLUSAPI_CLUSTER_GROUP_ENUM = uint function(_HGROUPENUM* hGroupEnum, uint dwIndex, uint* lpdwType, 
                                                  const(wchar)* lpszResourceName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM = uint function(_HGROUPENUM* hGroupEnum);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE = _HRESOURCE* function(_HGROUP* hGroup, const(wchar)* lpszResourceName, 
                                                              const(wchar)* lpszResourceType, uint dwFlags);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE = _HRESOURCE* function(_HCLUSTER* hCluster, const(wchar)* lpszResourceName);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE_EX = _HRESOURCE* function(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, 
                                                               uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_RESOURCE = BOOL function(_HRESOURCE* hResource);
alias PCLUSAPI_GET_CLUSTER_FROM_RESOURCE = _HCLUSTER* function(_HRESOURCE* hResource);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_STATE = CLUSTER_RESOURCE_STATE function(_HRESOURCE* hResource, 
                                                                            const(wchar)* lpszNodeName, 
                                                                            uint* lpcchNodeName, 
                                                                            const(wchar)* lpszGroupName, 
                                                                            uint* lpcchGroupName);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_NAME = uint function(_HRESOURCE* hResource, const(wchar)* lpszResourceName);
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
                                                                          const(wchar)* lpszDependencyExpression);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION = uint function(_HRESOURCE* hResource, 
                                                                          const(wchar)* lpszDependencyExpression, 
                                                                          uint* lpcchDependencyExpression);
alias PCLUSAPI_ADD_RESOURCE_TO_CLUSTER_SHARED_VOLUMES = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_REMOVE_RESOURCE_FROM_CLUSTER_SHARED_VOLUMES = uint function(_HRESOURCE* hResource);
alias PCLUSAPI_IS_FILE_ON_CLUSTER_SHARED_VOLUME = uint function(const(wchar)* lpszPathName, 
                                                                int* pbFileIsOnSharedVolume);
alias PCLUSAPI_SHARED_VOLUME_SET_SNAPSHOT_STATE = uint function(GUID guidSnapshotSet, const(wchar)* lpszVolumeName, 
                                                                CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);
alias PCLUSAPI_CAN_RESOURCE_BE_DEPENDENT = BOOL function(_HRESOURCE* hResource, _HRESOURCE* hResourceDependent);
alias PCLUSAPI_CLUSTER_RESOURCE_CONTROL = uint function(_HRESOURCE* hResource, _HNODE* hHostNode, 
                                                        uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, 
                                                        char* lpOutBuffer, uint cbOutBufferSize, 
                                                        uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL = uint function(_HCLUSTER* hCluster, 
                                                             const(wchar)* lpszResourceTypeName, _HNODE* hHostNode, 
                                                             uint dwControlCode, char* lpInBuffer, 
                                                             uint nInBufferSize, char* lpOutBuffer, 
                                                             uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_GROUP_CONTROL = uint function(_HGROUP* hGroup, _HNODE* hHostNode, uint dwControlCode, 
                                                     char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                                                     uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_NODE_CONTROL = uint function(_HNODE* hNode, _HNODE* hHostNode, uint dwControlCode, 
                                                    char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                                                    uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_NETWORK_NAME = BOOL function(_HRESOURCE* hResource, const(wchar)* lpBuffer, 
                                                                 uint* nSize);
alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM = _HRESENUM* function(_HRESOURCE* hResource, uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT = uint function(_HRESENUM* hResEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM = uint function(_HRESENUM* hResEnum, uint dwIndex, uint* lpdwType, 
                                                     const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM = uint function(_HRESENUM* hResEnum);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE = uint function(_HCLUSTER* hCluster, 
                                                            const(wchar)* lpszResourceTypeName, 
                                                            const(wchar)* lpszDisplayName, 
                                                            const(wchar)* lpszResourceTypeDll, 
                                                            uint dwLooksAlivePollInterval, 
                                                            uint dwIsAlivePollInterval);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE = uint function(_HCLUSTER* hCluster, 
                                                            const(wchar)* lpszResourceTypeName);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_OPEN_ENUM = _HRESTYPEENUM* function(_HCLUSTER* hCluster, 
                                                                         const(wchar)* lpszResourceTypeName, 
                                                                         uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_GET_ENUM_COUNT = uint function(_HRESTYPEENUM* hResTypeEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_ENUM = uint function(_HRESTYPEENUM* hResTypeEnum, uint dwIndex, 
                                                          uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CLOSE_ENUM = uint function(_HRESTYPEENUM* hResTypeEnum);
alias PCLUSAPI_OPEN_CLUSTER_NETWORK = _HNETWORK* function(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName);
alias PCLUSAPI_OPEN_CLUSTER_NETWORK_EX = _HNETWORK* function(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName, 
                                                             uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_NETWORK = BOOL function(_HNETWORK* hNetwork);
alias PCLUSAPI_GET_CLUSTER_FROM_NETWORK = _HCLUSTER* function(_HNETWORK* hNetwork);
alias PCLUSAPI_CLUSTER_NETWORK_OPEN_ENUM = _HNETWORKENUM* function(_HNETWORK* hNetwork, uint dwType);
alias PCLUSAPI_CLUSTER_NETWORK_GET_ENUM_COUNT = uint function(_HNETWORKENUM* hNetworkEnum);
alias PCLUSAPI_CLUSTER_NETWORK_ENUM = uint function(_HNETWORKENUM* hNetworkEnum, uint dwIndex, uint* lpdwType, 
                                                    const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CLOSE_ENUM = uint function(_HNETWORKENUM* hNetworkEnum);
alias PCLUSAPI_GET_CLUSTER_NETWORK_STATE = CLUSTER_NETWORK_STATE function(_HNETWORK* hNetwork);
alias PCLUSAPI_SET_CLUSTER_NETWORK_NAME = uint function(_HNETWORK* hNetwork, const(wchar)* lpszName);
alias PCLUSAPI_GET_CLUSTER_NETWORK_ID = uint function(_HNETWORK* hNetwork, const(wchar)* lpszNetworkId, 
                                                      uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CONTROL = uint function(_HNETWORK* hNetwork, _HNODE* hHostNode, uint dwControlCode, 
                                                       char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                                                       uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_OPEN_CLUSTER_NET_INTERFACE = _HNETINTERFACE* function(_HCLUSTER* hCluster, 
                                                                     const(wchar)* lpszInterfaceName);
alias PCLUSAPI_OPEN_CLUSTER_NETINTERFACE_EX = _HNETINTERFACE* function(_HCLUSTER* hCluster, 
                                                                       const(wchar)* lpszNetInterfaceName, 
                                                                       uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE = uint function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, 
                                                         const(wchar)* lpszNetworkName, 
                                                         const(wchar)* lpszInterfaceName, uint* lpcchInterfaceName);
alias PCLUSAPI_CLOSE_CLUSTER_NET_INTERFACE = BOOL function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_GET_CLUSTER_FROM_NET_INTERFACE = _HCLUSTER* function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_STATE = CLUSTER_NETINTERFACE_STATE function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_CLUSTER_NET_INTERFACE_CONTROL = uint function(_HNETINTERFACE* hNetInterface, _HNODE* hHostNode, 
                                                             uint dwControlCode, char* lpInBuffer, 
                                                             uint nInBufferSize, char* lpOutBuffer, 
                                                             uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_GET_CLUSTER_KEY = HKEY function(_HCLUSTER* hCluster, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_GROUP_KEY = HKEY function(_HGROUP* hGroup, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_KEY = HKEY function(_HRESOURCE* hResource, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NODE_KEY = HKEY function(_HNODE* hNode, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NETWORK_KEY = HKEY function(_HNETWORK* hNetwork, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_KEY = HKEY function(_HNETINTERFACE* hNetInterface, uint samDesired);
alias PCLUSAPI_CLUSTER_REG_CREATE_KEY = int function(HKEY hKey, const(wchar)* lpszSubKey, uint dwOptions, 
                                                     uint samDesired, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                                                     HKEY* phkResult, uint* lpdwDisposition);
alias PCLUSAPI_CLUSTER_REG_OPEN_KEY = int function(HKEY hKey, const(wchar)* lpszSubKey, uint samDesired, 
                                                   HKEY* phkResult);
alias PCLUSAPI_CLUSTER_REG_DELETE_KEY = int function(HKEY hKey, const(wchar)* lpszSubKey);
alias PCLUSAPI_CLUSTER_REG_CLOSE_KEY = int function(HKEY hKey);
alias PCLUSAPI_CLUSTER_REG_ENUM_KEY = int function(HKEY hKey, uint dwIndex, const(wchar)* lpszName, 
                                                   uint* lpcchName, FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_SET_VALUE = uint function(HKEY hKey, const(wchar)* lpszValueName, uint dwType, 
                                                     const(ubyte)* lpData, uint cbData);
alias PCLUSAPI_CLUSTER_REG_DELETE_VALUE = uint function(HKEY hKey, const(wchar)* lpszValueName);
alias PCLUSAPI_CLUSTER_REG_QUERY_VALUE = int function(HKEY hKey, const(wchar)* lpszValueName, uint* lpdwValueType, 
                                                      char* lpData, uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_ENUM_VALUE = uint function(HKEY hKey, uint dwIndex, const(wchar)* lpszValueName, 
                                                      uint* lpcchValueName, uint* lpdwType, char* lpData, 
                                                      uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_QUERY_INFO_KEY = int function(HKEY hKey, uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, 
                                                         uint* lpcValues, uint* lpcbMaxValueNameLen, 
                                                         uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                                                         FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_GET_KEY_SECURITY = int function(HKEY hKey, uint RequestedInformation, 
                                                           char* pSecurityDescriptor, uint* lpcbSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SET_KEY_SECURITY = int function(HKEY hKey, uint SecurityInformation, 
                                                           void* pSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SYNC_DATABASE = int function(_HCLUSTER* hCluster, uint flags);
alias PCLUSAPI_CLUSTER_REG_CREATE_BATCH = int function(HKEY hKey, _HREGBATCH** pHREGBATCH);
alias PCLUSTER_REG_BATCH_ADD_COMMAND = int function(_HREGBATCH* hRegBatch, CLUSTER_REG_COMMAND dwCommand, 
                                                    const(wchar)* wzName, uint dwOptions, char* lpData, uint cbData);
alias PCLUSTER_REG_CLOSE_BATCH = int function(_HREGBATCH* hRegBatch, BOOL bCommit, int* failedCommandNumber);
alias PCLUSTER_REG_BATCH_READ_COMMAND = int function(_HREGBATCHNOTIFICATION* hBatchNotification, 
                                                     CLUSTER_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_BATCH_CLOSE_NOTIFICATION = int function(_HREGBATCHNOTIFICATION* hBatchNotification);
alias PCLUSTER_REG_CREATE_BATCH_NOTIFY_PORT = int function(HKEY hKey, _HREGBATCHPORT** phBatchNotifyPort);
alias PCLUSTER_REG_CLOSE_BATCH_NOTIFY_PORT = int function(_HREGBATCHPORT* hBatchNotifyPort);
alias PCLUSTER_REG_GET_BATCH_NOTIFICATION = int function(_HREGBATCHPORT* hBatchNotify, 
                                                         _HREGBATCHNOTIFICATION** phBatchNotification);
alias PCLUSTER_REG_CREATE_READ_BATCH = int function(HKEY hKey, _HREGREADBATCH** phRegReadBatch);
alias PCLUSTER_REG_READ_BATCH_ADD_COMMAND = int function(_HREGREADBATCH* hRegReadBatch, const(wchar)* wzSubkeyName, 
                                                         const(wchar)* wzValueName);
alias PCLUSTER_REG_CLOSE_READ_BATCH = int function(_HREGREADBATCH* hRegReadBatch, 
                                                   _HREGREADBATCHREPLY** phRegReadBatchReply);
alias PCLUSTER_REG_CLOSE_READ_BATCH_EX = int function(_HREGREADBATCH* hRegReadBatch, uint flags, 
                                                      _HREGREADBATCHREPLY** phRegReadBatchReply);
alias PCLUSTER_REG_READ_BATCH_REPLY_NEXT_COMMAND = int function(_HREGREADBATCHREPLY* hRegReadBatchReply, 
                                                                CLUSTER_READ_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_CLOSE_READ_BATCH_REPLY = int function(_HREGREADBATCHREPLY* hRegReadBatchReply);
alias PCLUSTER_SET_ACCOUNT_ACCESS = uint function(_HCLUSTER* hCluster, const(wchar)* szAccountSID, uint dwAccess, 
                                                  uint dwControlType);
alias PCLUSTER_SETUP_PROGRESS_CALLBACK = BOOL function(void* pvCallbackArg, CLUSTER_SETUP_PHASE eSetupPhase, 
                                                       CLUSTER_SETUP_PHASE_TYPE ePhaseType, 
                                                       CLUSTER_SETUP_PHASE_SEVERITY ePhaseSeverity, 
                                                       uint dwPercentComplete, const(wchar)* lpszObjectName, 
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
alias PCLUSAPI_ADD_CLUSTER_NODE = _HNODE* function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, 
                                                   PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                   void* pvCallbackArg);
alias PCLUSAPI_DESTROY_CLUSTER = uint function(_HCLUSTER* hCluster, 
                                               PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                               void* pvCallbackArg, BOOL fdeleteVirtualComputerObjects);
alias PSET_RESOURCE_STATUS_ROUTINE_EX = uint function(ptrdiff_t ResourceHandle, RESOURCE_STATUS_EX* ResourceStatus);
alias PSET_RESOURCE_STATUS_ROUTINE = uint function(ptrdiff_t ResourceHandle, RESOURCE_STATUS* ResourceStatus);
alias PQUORUM_RESOURCE_LOST = void function(ptrdiff_t Resource);
alias PLOG_EVENT_ROUTINE = void function(ptrdiff_t ResourceHandle, LOG_LEVEL LogLevel, const(wchar)* FormatString);
alias POPEN_ROUTINE = void* function(const(wchar)* ResourceName, HKEY ResourceKey, ptrdiff_t ResourceHandle);
alias PCLOSE_ROUTINE = void function(void* Resource);
alias PONLINE_ROUTINE = uint function(void* Resource, ptrdiff_t* EventHandle);
alias POFFLINE_ROUTINE = uint function(void* Resource);
alias PTERMINATE_ROUTINE = void function(void* Resource);
alias PIS_ALIVE_ROUTINE = BOOL function(void* Resource);
alias PLOOKS_ALIVE_ROUTINE = BOOL function(void* Resource);
alias PARBITRATE_ROUTINE = uint function(void* Resource, PQUORUM_RESOURCE_LOST LostQuorumResource);
alias PRELEASE_ROUTINE = uint function(void* Resource);
alias PRESOURCE_CONTROL_ROUTINE = uint function(void* Resource, uint ControlCode, void* InBuffer, 
                                                uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                                uint* BytesReturned);
alias PRESOURCE_TYPE_CONTROL_ROUTINE = uint function(const(wchar)* ResourceTypeName, uint ControlCode, 
                                                     void* InBuffer, uint InBufferSize, void* OutBuffer, 
                                                     uint OutBufferSize, uint* BytesReturned);
alias POPEN_V2_ROUTINE = void* function(const(wchar)* ResourceName, HKEY ResourceKey, ptrdiff_t ResourceHandle, 
                                        uint OpenFlags);
alias PONLINE_V2_ROUTINE = uint function(void* Resource, ptrdiff_t* EventHandle, uint OnlineFlags, char* InBuffer, 
                                         uint InBufferSize, uint Reserved);
alias POFFLINE_V2_ROUTINE = uint function(void* Resource, const(wchar)* DestinationNodeName, uint OfflineFlags, 
                                          char* InBuffer, uint InBufferSize, uint Reserved);
alias PCANCEL_ROUTINE = uint function(void* Resource, uint CancelFlags_RESERVED);
alias PBEGIN_RESCALL_ROUTINE = uint function(void* Resource, uint ControlCode, void* InBuffer, uint InBufferSize, 
                                             void* OutBuffer, uint OutBufferSize, uint* BytesReturned, long context, 
                                             int* ReturnedAsynchronously);
alias PBEGIN_RESTYPECALL_ROUTINE = uint function(const(wchar)* ResourceTypeName, uint ControlCode, void* InBuffer, 
                                                 uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                                 uint* BytesReturned, long context, int* ReturnedAsynchronously);
alias PBEGIN_RESCALL_AS_USER_ROUTINE = uint function(void* Resource, HANDLE TokenHandle, uint ControlCode, 
                                                     void* InBuffer, uint InBufferSize, void* OutBuffer, 
                                                     uint OutBufferSize, uint* BytesReturned, long context, 
                                                     int* ReturnedAsynchronously);
alias PBEGIN_RESTYPECALL_AS_USER_ROUTINE = uint function(const(wchar)* ResourceTypeName, HANDLE TokenHandle, 
                                                         uint ControlCode, void* InBuffer, uint InBufferSize, 
                                                         void* OutBuffer, uint OutBufferSize, uint* BytesReturned, 
                                                         long context, int* ReturnedAsynchronously);
alias PSTARTUP_ROUTINE = uint function(const(wchar)* ResourceType, uint MinVersionSupported, 
                                       uint MaxVersionSupported, PSET_RESOURCE_STATUS_ROUTINE SetResourceStatus, 
                                       PLOG_EVENT_ROUTINE LogEvent, CLRES_FUNCTION_TABLE** FunctionTable);
alias PSET_RESOURCE_LOCKED_MODE_ROUTINE = uint function(ptrdiff_t ResourceHandle, BOOL LockedModeEnabled, 
                                                        uint LockedModeReason);
alias PSIGNAL_FAILURE_ROUTINE = uint function(ptrdiff_t ResourceHandle, FAILURE_TYPE FailureType, 
                                              uint ApplicationSpecificErrorCode);
alias PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE = uint function(ptrdiff_t ResourceHandle, 
                                                                          ubyte* propertyListBuffer, 
                                                                          uint propertyListBufferSize);
alias PEND_CONTROL_CALL = uint function(const(long) context, uint status);
alias PEND_TYPE_CONTROL_CALL = uint function(const(long) context, uint status);
alias PEXTEND_RES_CONTROL_CALL = uint function(const(long) context, uint newTimeoutInMs);
alias PEXTEND_RES_TYPE_CONTROL_CALL = uint function(const(long) context, uint newTimeoutInMs);
alias PRAISE_RES_TYPE_NOTIFICATION = uint function(const(wchar)* ResourceType, char* pPayload, uint payloadSize);
alias PCHANGE_RESOURCE_PROCESS_FOR_DUMPS = uint function(ptrdiff_t resource, const(wchar)* processName, 
                                                         uint processId, BOOL isAdd);
alias PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS = uint function(const(wchar)* resourceTypeName, const(wchar)* processName, 
                                                         uint processId, BOOL isAdd);
alias PSET_INTERNAL_STATE = uint function(ptrdiff_t param0, CLUSTER_RESOURCE_APPLICATION_STATE stateType, 
                                          BOOL active);
alias PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE = uint function(ptrdiff_t ResourceHandle, BOOL LockedModeEnabled, 
                                                           uint LockedModeReason, uint LockedModeFlags);
alias PSTARTUP_EX_ROUTINE = uint function(const(wchar)* ResourceType, uint MinVersionSupported, 
                                          uint MaxVersionSupported, 
                                          CLRES_CALLBACK_FUNCTION_TABLE* MonitorCallbackFunctions, 
                                          CLRES_FUNCTION_TABLE** ResourceDllInterfaceFunctions);
alias PRESUTIL_START_RESOURCE_SERVICE = uint function(const(wchar)* pszServiceName, SC_HANDLE__** phServiceHandle);
alias PRESUTIL_VERIFY_RESOURCE_SERVICE = uint function(const(wchar)* pszServiceName);
alias PRESUTIL_STOP_RESOURCE_SERVICE = uint function(const(wchar)* pszServiceName);
alias PRESUTIL_VERIFY_SERVICE = uint function(SC_HANDLE__* hServiceHandle);
alias PRESUTIL_STOP_SERVICE = uint function(SC_HANDLE__* hServiceHandle);
alias PRESUTIL_CREATE_DIRECTORY_TREE = uint function(const(wchar)* pszPath);
alias PRESUTIL_IS_PATH_VALID = BOOL function(const(wchar)* pszPath);
alias PRESUTIL_ENUM_PROPERTIES = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                               const(wchar)* pszOutProperties, uint cbOutPropertiesSize, 
                                               uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_ENUM_PRIVATE_PROPERTIES = uint function(HKEY hkeyClusterKey, const(wchar)* pszOutProperties, 
                                                       uint cbOutPropertiesSize, uint* pcbBytesReturned, 
                                                       uint* pcbRequired);
alias PRESUTIL_GET_PROPERTIES = uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                              char* pOutPropertyList, uint cbOutPropertyListSize, 
                                              uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_ALL_PROPERTIES = uint function(HKEY hkeyClusterKey, 
                                                  const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                  char* pOutPropertyList, uint cbOutPropertyListSize, 
                                                  uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_PRIVATE_PROPERTIES = uint function(HKEY hkeyClusterKey, char* pOutPropertyList, 
                                                      uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                                                      uint* pcbRequired);
alias PRESUTIL_GET_PROPERTY_SIZE = uint function(HKEY hkeyClusterKey, 
                                                 const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                                                 uint* pcbOutPropertyListSize, uint* pnPropertyCount);
alias PRESUTIL_GET_PROPERTY = uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                                            char* pOutPropertyItem, uint* pcbOutPropertyItemSize);
alias PRESUTIL_VERIFY_PROPERTY_TABLE = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                                                     BOOL bAllowUnknownProperties, char* pInPropertyList, 
                                                     uint cbInPropertyListSize, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_TABLE = uint function(HKEY hkeyClusterKey, 
                                                  const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                                                  BOOL bAllowUnknownProperties, char* pInPropertyList, 
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
                                                      char* pInPropertyList, uint cbInPropertyListSize);
alias PRESUTIL_GET_PROPERTIES_TO_PARAMETER_BLOCK = uint function(HKEY hkeyClusterKey, 
                                                                 const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                                 ubyte* pOutParams, BOOL bCheckForRequiredProperties, 
                                                                 ushort** pszNameOfPropInError);
alias PRESUTIL_PROPERTY_LIST_FROM_PARAMETER_BLOCK = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                                  char* pOutPropertyList, 
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
alias PRESUTIL_SET_PRIVATE_PROPERTY_LIST = uint function(HKEY hkeyClusterKey, char* pInPropertyList, 
                                                         uint cbInPropertyListSize);
alias PRESUTIL_VERIFY_PRIVATE_PROPERTY_LIST = uint function(char* pInPropertyList, uint cbInPropertyListSize);
alias PRESUTIL_DUP_STRING = ushort* function(const(wchar)* pszInString);
alias PRESUTIL_GET_BINARY_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* ppbOutValue, 
                                                uint* pcbOutValueSize);
alias PRESUTIL_GET_SZ_VALUE = ushort* function(HKEY hkeyClusterKey, const(wchar)* pszValueName);
alias PRESUTIL_GET_EXPAND_SZ_VALUE = ushort* function(HKEY hkeyClusterKey, const(wchar)* pszValueName, 
                                                      BOOL bExpand);
alias PRESUTIL_GET_DWORD_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint* pdwOutValue, 
                                               uint dwDefaultValue);
alias PRESUTIL_GET_QWORD_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong* pqwOutValue, 
                                               ulong qwDefaultValue);
alias PRESUTIL_SET_BINARY_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* pbNewValue, 
                                                uint cbNewValueSize, char* ppbOutValue, uint* pcbOutValueSize);
alias PRESUTIL_SET_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, 
                                            const(wchar)* pszNewValue, ushort** ppszOutString);
alias PRESUTIL_SET_EXPAND_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, 
                                                   const(wchar)* pszNewValue, ushort** ppszOutString);
alias PRESUTIL_SET_MULTI_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, 
                                                  const(wchar)* pszNewValue, uint cbNewValueSize, char* ppszOutValue, 
                                                  uint* pcbOutValueSize);
alias PRESUTIL_SET_DWORD_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint dwNewValue, 
                                               uint* pdwOutValue);
alias PRESUTIL_SET_QWORD_VALUE = uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong qwNewValue, 
                                               ulong* pqwOutValue);
alias PRESUTIL_GET_BINARY_PROPERTY = uint function(ubyte** ppbOutValue, uint* pcbOutValueSize, 
                                                   const(CLUSPROP_BINARY)* pValueStruct, char* pbOldValue, 
                                                   uint cbOldValueSize, char* ppPropertyList, 
                                                   uint* pcbPropertyListSize);
alias PRESUTIL_GET_SZ_PROPERTY = uint function(ushort** ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, 
                                               const(wchar)* pszOldValue, char* ppPropertyList, 
                                               uint* pcbPropertyListSize);
alias PRESUTIL_GET_MULTI_SZ_PROPERTY = uint function(ushort** ppszOutValue, uint* pcbOutValueSize, 
                                                     const(CLUSPROP_SZ)* pValueStruct, const(wchar)* pszOldValue, 
                                                     uint cbOldValueSize, char* ppPropertyList, 
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
alias PRESUTIL_EXPAND_ENVIRONMENT_STRINGS = ushort* function(const(wchar)* pszSrc);
alias PRESUTIL_SET_RESOURCE_SERVICE_ENVIRONMENT = uint function(const(wchar)* pszServiceName, 
                                                                _HRESOURCE* hResource, 
                                                                PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                ptrdiff_t hResourceHandle);
alias PRESUTIL_REMOVE_RESOURCE_SERVICE_ENVIRONMENT = uint function(const(wchar)* pszServiceName, 
                                                                   PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                   ptrdiff_t hResourceHandle);
alias PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS = uint function(const(wchar)* pszServiceName, 
                                                                     SC_HANDLE__* schSCMHandle, 
                                                                     SC_HANDLE__** phService, 
                                                                     PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                     ptrdiff_t hResourceHandle);
alias PRESUTIL_FIND_SZ_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                const(wchar)* pszPropertyName, ushort** pszPropertyValue);
alias PRESUTIL_FIND_EXPAND_SZ_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                       const(wchar)* pszPropertyName, ushort** pszPropertyValue);
alias PRESUTIL_FIND_EXPANDED_SZ_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                         const(wchar)* pszPropertyName, ushort** pszPropertyValue);
alias PRESUTIL_FIND_DWORD_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                   const(wchar)* pszPropertyName, uint* pdwPropertyValue);
alias PRESUTIL_FIND_BINARY_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                    const(wchar)* pszPropertyName, char* pbPropertyValue, 
                                                    uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_MULTI_SZ_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                      const(wchar)* pszPropertyName, char* pszPropertyValue, 
                                                      uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_LONG_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                  const(wchar)* pszPropertyName, int* plPropertyValue);
alias PRESUTIL_FIND_ULARGEINTEGER_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                           const(wchar)* pszPropertyName, ulong* plPropertyValue);
alias PRESUTIL_FIND_FILETIME_PROPERTY = uint function(char* pPropertyList, uint cbPropertyListSize, 
                                                      const(wchar)* pszPropertyName, FILETIME* pftPropertyValue);
alias PWORKER_START_ROUTINE = uint function(CLUS_WORKER* pWorker, void* lpThreadParameter);
alias PCLUSAPI_CLUS_WORKER_CREATE = uint function(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, 
                                                  void* lpParameter);
alias PCLUSAPIClusWorkerCheckTerminate = BOOL function(CLUS_WORKER* lpWorker);
alias PCLUSAPI_CLUS_WORKER_TERMINATE = void function(CLUS_WORKER* lpWorker);
alias LPRESOURCE_CALLBACK = uint function(_HRESOURCE* param0, _HRESOURCE* param1, void* param2);
alias LPRESOURCE_CALLBACK_EX = uint function(_HCLUSTER* param0, _HRESOURCE* param1, _HRESOURCE* param2, 
                                             void* param3);
alias LPGROUP_CALLBACK_EX = uint function(_HCLUSTER* param0, _HGROUP* param1, _HGROUP* param2, void* param3);
alias LPNODE_CALLBACK = uint function(_HCLUSTER* param0, _HNODE* param1, CLUSTER_NODE_STATE param2, void* param3);
alias PRESUTIL_RESOURCES_EQUAL = BOOL function(_HRESOURCE* hSelf, _HRESOURCE* hResource);
alias PRESUTIL_RESOURCE_TYPES_EQUAL = BOOL function(const(wchar)* lpszResourceTypeName, _HRESOURCE* hResource);
alias PRESUTIL_IS_RESOURCE_CLASS_EQUAL = BOOL function(CLUS_RESOURCE_CLASS_INFO* prci, _HRESOURCE* hResource);
alias PRESUTIL_ENUM_RESOURCES = uint function(_HRESOURCE* hSelf, const(wchar)* lpszResTypeName, 
                                              LPRESOURCE_CALLBACK pResCallBack, void* pParameter);
alias PRESUTIL_ENUM_RESOURCES_EX = uint function(_HCLUSTER* hCluster, _HRESOURCE* hSelf, 
                                                 const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, 
                                                 void* pParameter);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY = _HRESOURCE* function(HANDLE hSelf, const(wchar)* lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                      const(wchar)* lpszResourceType, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                       CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY = _HRESOURCE* function(const(wchar)* lpszResourceName, 
                                                                   const(wchar)* lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENTIP_ADDRESS_PROPS = uint function(_HRESOURCE* hResource, 
                                                                      const(wchar)* pszAddress, uint* pcchAddress, 
                                                                      const(wchar)* pszSubnetMask, 
                                                                      uint* pcchSubnetMask, const(wchar)* pszNetwork, 
                                                                      uint* pcchNetwork);
alias PRESUTIL_FIND_DEPENDENT_DISK_RESOURCE_DRIVE_LETTER = uint function(_HCLUSTER* hCluster, 
                                                                         _HRESOURCE* hResource, 
                                                                         const(wchar)* pszDriveLetter, 
                                                                         uint* pcchDriveLetter);
alias PRESUTIL_TERMINATE_SERVICE_PROCESS_FROM_RES_DLL = uint function(uint dwServicePid, BOOL bOffline, 
                                                                      uint* pdwResourceState, 
                                                                      PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                      ptrdiff_t hResourceHandle);
alias PRESUTIL_GET_PROPERTY_FORMATS = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                    char* pOutPropertyFormatList, uint cbPropertyFormatListSize, 
                                                    uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES = uint function(_HCLUSTER* hCluster, _HRESOURCE** phClusterNameResource, 
                                                          _HRESOURCE** phClusterIPAddressResource, 
                                                          _HRESOURCE** phClusterQuorumResource);
alias PRESUTIL_GET_RESOURCE_NAME = uint function(_HRESOURCE* hResource, const(wchar)* pszResourceName, 
                                                 uint* pcchResourceNameInOut);
alias PCLUSTER_IS_PATH_ON_SHARED_VOLUME = BOOL function(const(wchar)* lpszPathName);
alias PCLUSTER_GET_VOLUME_PATH_NAME = BOOL function(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, 
                                                    uint cchBufferLength);
alias PCLUSTER_GET_VOLUME_NAME_FOR_VOLUME_MOUNT_POINT = BOOL function(const(wchar)* lpszVolumeMountPoint, 
                                                                      const(wchar)* lpszVolumeName, 
                                                                      uint cchBufferLength);
alias PCLUSTER_PREPARE_SHARED_VOLUME_FOR_BACKUP = uint function(const(wchar)* lpszFileName, 
                                                                const(wchar)* lpszVolumePathName, 
                                                                uint* lpcchVolumePathName, 
                                                                const(wchar)* lpszVolumeName, uint* lpcchVolumeName);
alias PCLUSTER_CLEAR_BACKUP_STATE_FOR_SHARED_VOLUME = uint function(const(wchar)* lpszVolumePathName);
alias PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS_EX = uint function(const(wchar)* pszServiceName, 
                                                                        SC_HANDLE__* schSCMHandle, 
                                                                        SC_HANDLE__** phService, 
                                                                        uint dwDesiredAccess, 
                                                                        PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                        ptrdiff_t hResourceHandle);
alias PRESUTIL_ENUM_RESOURCES_EX2 = uint function(_HCLUSTER* hCluster, _HRESOURCE* hSelf, 
                                                  const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, 
                                                  void* pParameter, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_EX = _HRESOURCE* function(HANDLE hSelf, const(wchar)* lpszResourceType, 
                                                                 uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME_EX = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                         const(wchar)* lpszResourceType, 
                                                                         BOOL bRecurse, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS_EX = _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                                          CLUS_RESOURCE_CLASS_INFO* prci, 
                                                                          BOOL bRecurse, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY_EX = _HRESOURCE* function(const(wchar)* lpszResourceName, 
                                                                      const(wchar)* lpszResourceType, 
                                                                      uint dwDesiredAccess);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES_EX = uint function(_HCLUSTER* hClusterIn, 
                                                             _HRESOURCE** phClusterNameResourceOut, 
                                                             _HRESOURCE** phClusterIPAddressResourceOut, 
                                                             _HRESOURCE** phClusterQuorumResourceOut, 
                                                             uint dwDesiredAccess);
alias POPEN_CLUSTER_CRYPT_PROVIDER = _HCLUSCRYPTPROVIDER* function(const(wchar)* lpszResource, byte* lpszProvider, 
                                                                   uint dwType, uint dwFlags);
alias POPEN_CLUSTER_CRYPT_PROVIDEREX = _HCLUSCRYPTPROVIDER* function(const(wchar)* lpszResource, 
                                                                     const(wchar)* lpszKeyname, byte* lpszProvider, 
                                                                     uint dwType, uint dwFlags);
alias PCLOSE_CLUSTER_CRYPT_PROVIDER = uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider);
alias PCLUSTER_ENCRYPT = uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pData, uint cbData, 
                                       ubyte** ppData, uint* pcbData);
alias PCLUSTER_DECRYPT = uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pCryptInput, 
                                       uint cbCryptInput, ubyte** ppCryptOutput, uint* pcbCryptOutput);
alias PFREE_CLUSTER_CRYPT = uint function(void* pCryptInfo);
alias PREGISTER_APPINSTANCE = uint function(HANDLE ProcessHandle, GUID* AppInstanceId, 
                                            BOOL ChildrenInheritAppInstance);
alias PREGISTER_APPINSTANCE_VERSION = uint function(GUID* AppInstanceId, ulong InstanceVersionHigh, 
                                                    ulong InstanceVersionLow);
alias PQUERY_APPINSTANCE_VERSION = uint function(GUID* AppInstanceId, ulong* InstanceVersionHigh, 
                                                 ulong* InstanceVersionLow, int* VersionStatus);
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

struct CLUSTERVERSIONINFO_NT4
{
    uint       dwVersionInfoSize;
    ushort     MajorVersion;
    ushort     MinorVersion;
    ushort     BuildNumber;
    ushort[64] szVendorId;
    ushort[64] szCSDVersion;
}

struct CLUSTERVERSIONINFO
{
    uint       dwVersionInfoSize;
    ushort     MajorVersion;
    ushort     MinorVersion;
    ushort     BuildNumber;
    ushort[64] szVendorId;
    ushort[64] szCSDVersion;
    uint       dwClusterHighestVersion;
    uint       dwClusterLowestVersion;
    uint       dwFlags;
    uint       dwReserved;
}

struct CLUS_STARTING_PARAMS
{
    uint dwSize;
    BOOL bForm;
    BOOL bFirst;
}

struct CLUSCTL_RESOURCE_STATE_CHANGE_REASON_STRUCT
{
    uint dwSize;
    uint dwVersion;
    CLUSTER_RESOURCE_STATE_CHANGE_REASON eReason;
}

struct CLUSTER_BATCH_COMMAND
{
    CLUSTER_REG_COMMAND Command;
    uint                dwOptions;
    const(wchar)*       wzName;
    const(ubyte)*       lpData;
    uint                cbData;
}

struct CLUSTER_READ_BATCH_COMMAND
{
    CLUSTER_REG_COMMAND Command;
    uint                dwOptions;
    const(wchar)*       wzSubkeyName;
    const(wchar)*       wzValueName;
    const(ubyte)*       lpData;
    uint                cbData;
}

struct CLUSTER_ENUM_ITEM
{
    uint          dwVersion;
    uint          dwType;
    uint          cbId;
    const(wchar)* lpszId;
    uint          cbName;
    const(wchar)* lpszName;
}

struct CLUSTER_CREATE_GROUP_INFO
{
    uint           dwVersion;
    CLUSGROUP_TYPE groupType;
}

struct CLUSTER_VALIDATE_PATH
{
    ushort szPath;
}

struct CLUSTER_VALIDATE_DIRECTORY
{
    ushort szPath;
}

struct CLUSTER_VALIDATE_NETNAME
{
    ushort szNetworkName;
}

struct CLUSTER_VALIDATE_CSV_FILENAME
{
    ushort szFileName;
}

struct CLUSTER_SET_PASSWORD_STATUS
{
    uint  NodeId;
    ubyte SetAttempted;
    uint  ReturnStatus;
}

struct CLUSTER_IP_ENTRY
{
    const(wchar)* lpszIpAddress;
    uint          dwPrefixLength;
}

struct CREATE_CLUSTER_CONFIG
{
    uint              dwVersion;
    const(wchar)*     lpszClusterName;
    uint              cNodes;
    ushort**          ppszNodeNames;
    uint              cIpEntries;
    CLUSTER_IP_ENTRY* pIpEntries;
    ubyte             fEmptyCluster;
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
}

struct CREATE_CLUSTER_NAME_ACCOUNT
{
    uint          dwVersion;
    const(wchar)* lpszClusterName;
    uint          dwFlags;
    const(wchar)* pszUserName;
    const(wchar)* pszPassword;
    const(wchar)* pszDomain;
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
    ubyte         bUpgradeVCOs;
}

struct NOTIFY_FILTER_AND_TYPE
{
    uint dwObjectType;
    long FilterFlags;
}

struct CLUSTER_MEMBERSHIP_INFO
{
    BOOL     HasQuorum;
    uint     UpnodesSize;
    ubyte[1] Upnodes;
}

struct CLUSTER_AVAILABILITY_SET_CONFIG
{
    uint dwVersion;
    uint dwUpdateDomains;
    uint dwFaultDomains;
    BOOL bReserveSpareNode;
}

struct CLUSTER_GROUP_ENUM_ITEM
{
    uint                dwVersion;
    uint                cbId;
    const(wchar)*       lpszId;
    uint                cbName;
    const(wchar)*       lpszName;
    CLUSTER_GROUP_STATE state;
    uint                cbOwnerNode;
    const(wchar)*       lpszOwnerNode;
    uint                dwFlags;
    uint                cbProperties;
    void*               pProperties;
    uint                cbRoProperties;
    void*               pRoProperties;
}

struct CLUSTER_RESOURCE_ENUM_ITEM
{
    uint          dwVersion;
    uint          cbId;
    const(wchar)* lpszId;
    uint          cbName;
    const(wchar)* lpszName;
    uint          cbOwnerGroupName;
    const(wchar)* lpszOwnerGroupName;
    uint          cbOwnerGroupId;
    const(wchar)* lpszOwnerGroupId;
    uint          cbProperties;
    void*         pProperties;
    uint          cbRoProperties;
    void*         pRoProperties;
}

struct GROUP_FAILURE_INFO
{
    uint dwFailoverAttemptsRemaining;
    uint dwFailoverPeriodRemaining;
}

struct GROUP_FAILURE_INFO_BUFFER
{
    uint               dwVersion;
    GROUP_FAILURE_INFO Info;
}

struct RESOURCE_FAILURE_INFO
{
    uint dwRestartAttemptsRemaining;
    uint dwRestartPeriodRemaining;
}

struct RESOURCE_FAILURE_INFO_BUFFER
{
    uint dwVersion;
    RESOURCE_FAILURE_INFO Info;
}

struct RESOURCE_TERMINAL_FAILURE_INFO_BUFFER
{
    BOOL isTerminalFailure;
    uint restartPeriodRemaining;
}

union CLUSPROP_SYNTAX
{
    uint dw;
    struct
    {
        ushort wFormat;
        ushort wType;
    }
}

struct CLUSPROP_VALUE
{
    CLUSPROP_SYNTAX Syntax;
    uint            cbLength;
}

struct CLUSPROP_BINARY
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5092_C41;
    ubyte          rgb;
}

struct CLUSPROP_WORD
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5102_C39;
    ushort         w;
}

struct CLUSPROP_DWORD
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5112_C40;
    uint           dw;
}

struct CLUSPROP_LONG
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5122_C39;
    int            l;
}

struct CLUSPROP_SZ
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5132_C37;
    ushort         sz;
}

struct CLUSPROP_ULARGE_INTEGER
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5149_C14;
    ULARGE_INTEGER li;
}

struct CLUSPROP_LARGE_INTEGER
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5162_C14;
    LARGE_INTEGER  li;
}

struct CLUSPROP_SECURITY_DESCRIPTOR
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5174_C54;
    union
    {
        SECURITY_DESCRIPTOR_RELATIVE sd;
        ubyte rgbSecurityDescriptor;
    }
}

struct CLUSPROP_FILETIME
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5188_C14;
    FILETIME       ft;
}

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

struct CLUSPROP_RESOURCE_CLASS
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5213_C14;
    CLUSTER_RESOURCE_CLASS rc;
}

struct CLUSPROP_RESOURCE_CLASS_INFO
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5224_C14;
    CLUS_RESOURCE_CLASS_INFO __AnonymousBase_clusapi_L5225_C14;
}

union CLUSPROP_REQUIRED_DEPENDENCY
{
    CLUSPROP_VALUE Value;
    CLUSPROP_RESOURCE_CLASS ResClass;
    CLUSPROP_SZ    ResTypeName;
}

struct CLUS_FORCE_QUORUM_INFO
{
    uint      dwSize;
    uint      dwNodeBitMask;
    uint      dwMaxNumberofNodes;
    ushort[1] multiszNodeList;
}

struct CLUS_PARTITION_INFO
{
    uint        dwFlags;
    ushort[260] szDeviceName;
    ushort[260] szVolumeLabel;
    uint        dwSerialNumber;
    uint        rgdwMaximumComponentLength;
    uint        dwFileSystemFlags;
    ushort[32]  szFileSystem;
}

struct CLUS_PARTITION_INFO_EX
{
    uint           dwFlags;
    ushort[260]    szDeviceName;
    ushort[260]    szVolumeLabel;
    uint           dwSerialNumber;
    uint           rgdwMaximumComponentLength;
    uint           dwFileSystemFlags;
    ushort[32]     szFileSystem;
    ULARGE_INTEGER TotalSizeInBytes;
    ULARGE_INTEGER FreeSizeInBytes;
    uint           DeviceNumber;
    uint           PartitionNumber;
    GUID           VolumeGuid;
}

struct CLUS_PARTITION_INFO_EX2
{
    GUID        GptPartitionId;
    ushort[260] szPartitionName;
    uint        EncryptionFlags;
}

struct CLUS_CSV_VOLUME_INFO
{
    ULARGE_INTEGER VolumeOffset;
    uint           PartitionNumber;
    CLUSTER_CSV_VOLUME_FAULT_STATE FaultState;
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    ushort[260]    szVolumeFriendlyName;
    ushort[50]     szVolumeName;
}

struct CLUS_CSV_VOLUME_NAME
{
    LARGE_INTEGER VolumeOffset;
    ushort[260]   szVolumeName;
    ushort[263]   szRootPath;
}

struct CLUSTER_SHARED_VOLUME_STATE_INFO
{
    ushort[260] szVolumeName;
    ushort[260] szNodeName;
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
}

struct CLUSTER_SHARED_VOLUME_STATE_INFO_EX
{
    ushort[260] szVolumeName;
    ushort[260] szNodeName;
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
    ushort[260] szVolumeFriendlyName;
    ulong       RedirectedIOReason;
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

struct CLUS_CHKDSK_INFO
{
    uint     PartitionNumber;
    uint     ChkdskState;
    uint     FileIdCount;
    ulong[1] FileIdList;
}

struct CLUS_DISK_NUMBER_INFO
{
    uint DiskNumber;
    uint BytesPerSector;
}

struct CLUS_SHARED_VOLUME_BACKUP_MODE
{
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    uint        DelayTimerInSecs;
    ushort[260] VolumeName;
}

struct CLUSPROP_PARTITION_INFO
{
    CLUSPROP_VALUE      __AnonymousBase_clusapi_L5470_C14;
    CLUS_PARTITION_INFO __AnonymousBase_clusapi_L5471_C14;
}

struct CLUSPROP_PARTITION_INFO_EX
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5482_C14;
    CLUS_PARTITION_INFO_EX __AnonymousBase_clusapi_L5483_C14;
}

struct CLUSPROP_PARTITION_INFO_EX2
{
    CLUSPROP_PARTITION_INFO_EX __AnonymousBase_clusapi_L5496_C14;
    CLUS_PARTITION_INFO_EX2 __AnonymousBase_clusapi_L5497_C14;
}

struct CLUS_FTSET_INFO
{
    uint dwRootSignature;
    uint dwFtType;
}

struct CLUSPROP_FTSET_INFO
{
    CLUSPROP_VALUE  __AnonymousBase_clusapi_L5518_C14;
    CLUS_FTSET_INFO __AnonymousBase_clusapi_L5519_C14;
}

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

struct CLUSPROP_SCSI_ADDRESS
{
    CLUSPROP_VALUE    __AnonymousBase_clusapi_L5546_C14;
    CLUS_SCSI_ADDRESS __AnonymousBase_clusapi_L5547_C14;
}

struct CLUS_NETNAME_VS_TOKEN_INFO
{
    uint ProcessID;
    uint DesiredAccess;
    BOOL InheritHandle;
}

struct CLUS_NETNAME_PWD_INFO
{
    uint        Flags;
    ushort[16]  Password;
    ushort[258] CreatingDC;
    ushort[64]  ObjectGuid;
}

struct CLUS_NETNAME_PWD_INFOEX
{
    uint        Flags;
    ushort[128] Password;
    ushort[258] CreatingDC;
    ushort[64]  ObjectGuid;
}

struct CLUS_DNN_LEADER_STATUS
{
    BOOL IsOnline;
    BOOL IsFileServerPresent;
}

struct CLUS_DNN_SODAFS_CLONE_STATUS
{
    uint NodeId;
    CLUSTER_RESOURCE_STATE Status;
}

struct CLUS_NETNAME_IP_INFO_ENTRY
{
    uint     NodeId;
    uint     AddressSize;
    ubyte[1] Address;
}

struct CLUS_NETNAME_IP_INFO_FOR_MULTICHANNEL
{
    ushort[64] szName;
    uint       NumEntries;
    CLUS_NETNAME_IP_INFO_ENTRY[1] IpInfo;
}

struct CLUS_MAINTENANCE_MODE_INFO
{
    BOOL InMaintenance;
}

struct CLUS_CSV_MAINTENANCE_MODE_INFO
{
    BOOL        InMaintenance;
    ushort[260] VolumeName;
}

struct CLUS_MAINTENANCE_MODE_INFOEX
{
    BOOL InMaintenance;
    MAINTENANCE_MODE_TYPE_ENUM MaintainenceModeType;
    CLUSTER_RESOURCE_STATE InternalState;
    uint Signature;
}

struct CLUS_SET_MAINTENANCE_MODE_INPUT
{
    BOOL     InMaintenance;
    uint     ExtraParameterSize;
    ubyte[1] ExtraParameter;
}

struct CLUS_STORAGE_SET_DRIVELETTER
{
    uint PartitionNumber;
    uint DriveLetterMask;
}

struct CLUS_STORAGE_GET_AVAILABLE_DRIVELETTERS
{
    uint AvailDrivelettersMask;
}

struct CLUS_STORAGE_REMAP_DRIVELETTER
{
    uint CurrentDriveLetterMask;
    uint TargetDriveLetterMask;
}

struct CLUS_PROVIDER_STATE_CHANGE_INFO
{
    uint      dwSize;
    CLUSTER_RESOURCE_STATE resourceState;
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

struct CLUSPROP_LIST
{
    uint        nPropertyCount;
    CLUSPROP_SZ PropertyName;
}

struct FILESHARE_CHANGE
{
    FILESHARE_CHANGE_ENUM Change;
    ushort[84] ShareName;
}

struct FILESHARE_CHANGE_LIST
{
    uint                NumEntries;
    FILESHARE_CHANGE[1] ChangeEntry;
}

struct CLUSCTL_GROUP_GET_LAST_MOVE_TIME_OUTPUT
{
    ulong      GetTickCount64;
    SYSTEMTIME GetSystemTime;
    uint       NodeId;
}

union CLUSPROP_BUFFER_HELPER
{
    ubyte*             pb;
    ushort*            pw;
    uint*              pdw;
    int*               pl;
    const(wchar)*      psz;
    CLUSPROP_LIST*     pList;
    CLUSPROP_SYNTAX*   pSyntax;
    CLUSPROP_SZ*       pName;
    CLUSPROP_VALUE*    pValue;
    CLUSPROP_BINARY*   pBinaryValue;
    CLUSPROP_WORD*     pWordValue;
    CLUSPROP_DWORD*    pDwordValue;
    CLUSPROP_LONG*     pLongValue;
    CLUSPROP_ULARGE_INTEGER* pULargeIntegerValue;
    CLUSPROP_LARGE_INTEGER* pLargeIntegerValue;
    CLUSPROP_SZ*       pStringValue;
    CLUSPROP_SZ*       pMultiSzValue;
    CLUSPROP_SECURITY_DESCRIPTOR* pSecurityDescriptor;
    CLUSPROP_RESOURCE_CLASS* pResourceClassValue;
    CLUSPROP_RESOURCE_CLASS_INFO* pResourceClassInfoValue;
    CLUSPROP_DWORD*    pDiskSignatureValue;
    CLUSPROP_SCSI_ADDRESS* pScsiAddressValue;
    CLUSPROP_DWORD*    pDiskNumberValue;
    CLUSPROP_PARTITION_INFO* pPartitionInfoValue;
    CLUSPROP_REQUIRED_DEPENDENCY* pRequiredDependencyValue;
    CLUSPROP_PARTITION_INFO_EX* pPartitionInfoValueEx;
    CLUSPROP_PARTITION_INFO_EX2* pPartitionInfoValueEx2;
    CLUSPROP_FILETIME* pFileTimeValue;
}

struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO
{
    ulong PartitionOffset;
    uint  Capabilities;
}

struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_ARRAY
{
    uint Count;
    SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO[1] PartitionArray;
}

struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_LOGDISKS
{
    GUID  DataDiskGuid;
    ubyte IncludeOfflineDisks;
}

struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_TARGET_DATADISKS
{
    GUID  SourceDataDiskGuid;
    GUID  TargetReplicationGroupGuid;
    ubyte SkipConnectivityCheck;
    ubyte IncludeOfflineDisks;
}

struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_SOURCE_DATADISKS
{
    GUID  DataDiskGuid;
    ubyte IncludeAvailableStoargeDisks;
}

struct SR_RESOURCE_TYPE_DISK_INFO
{
    SR_DISK_REPLICATION_ELIGIBLE Reason;
    GUID DiskGuid;
}

struct SR_RESOURCE_TYPE_ELIGIBLE_DISKS_RESULT
{
    ushort Count;
    SR_RESOURCE_TYPE_DISK_INFO[1] DiskInfo;
}

struct SR_RESOURCE_TYPE_REPLICATED_DISK
{
    SR_REPLICATED_DISK_TYPE Type;
    GUID        ClusterDiskResourceGuid;
    GUID        ReplicationGroupId;
    ushort[260] ReplicationGroupName;
}

struct SR_RESOURCE_TYPE_REPLICATED_DISKS_RESULT
{
    ushort Count;
    SR_RESOURCE_TYPE_REPLICATED_DISK[1] ReplicatedDisks;
}

struct CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INPUT
{
    uint dwFlags;
    GUID guidPoolFilter;
}

struct RESOURCE_STATUS
{
    CLUSTER_RESOURCE_STATE ResourceState;
    uint   CheckPoint;
    uint   WaitHint;
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

struct GET_OPERATION_CONTEXT_PARAMS
{
    uint Size;
    uint Version;
    RESDLL_CONTEXT_OPERATION_TYPE Type;
    uint Priority;
}

struct RESOURCE_STATUS_EX
{
    CLUSTER_RESOURCE_STATE ResourceState;
    uint   CheckPoint;
    HANDLE EventHandle;
    uint   ApplicationSpecificErrorCode;
    uint   Flags;
    uint   WaitHint;
}

struct CLRES_V1_FUNCTIONS
{
    POPEN_ROUTINE        Open;
    PCLOSE_ROUTINE       Close;
    PONLINE_ROUTINE      Online;
    POFFLINE_ROUTINE     Offline;
    PTERMINATE_ROUTINE   Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE    IsAlive;
    PARBITRATE_ROUTINE   Arbitrate;
    PRELEASE_ROUTINE     Release;
    PRESOURCE_CONTROL_ROUTINE ResourceControl;
    PRESOURCE_TYPE_CONTROL_ROUTINE ResourceTypeControl;
}

struct CLRES_V2_FUNCTIONS
{
    POPEN_V2_ROUTINE     Open;
    PCLOSE_ROUTINE       Close;
    PONLINE_V2_ROUTINE   Online;
    POFFLINE_V2_ROUTINE  Offline;
    PTERMINATE_ROUTINE   Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE    IsAlive;
    PARBITRATE_ROUTINE   Arbitrate;
    PRELEASE_ROUTINE     Release;
    PRESOURCE_CONTROL_ROUTINE ResourceControl;
    PRESOURCE_TYPE_CONTROL_ROUTINE ResourceTypeControl;
    PCANCEL_ROUTINE      Cancel;
}

struct CLRES_V3_FUNCTIONS
{
    POPEN_V2_ROUTINE     Open;
    PCLOSE_ROUTINE       Close;
    PONLINE_V2_ROUTINE   Online;
    POFFLINE_V2_ROUTINE  Offline;
    PTERMINATE_ROUTINE   Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE    IsAlive;
    PARBITRATE_ROUTINE   Arbitrate;
    PRELEASE_ROUTINE     Release;
    PBEGIN_RESCALL_ROUTINE BeginResourceControl;
    PBEGIN_RESTYPECALL_ROUTINE BeginResourceTypeControl;
    PCANCEL_ROUTINE      Cancel;
}

struct CLRES_V4_FUNCTIONS
{
    POPEN_V2_ROUTINE     Open;
    PCLOSE_ROUTINE       Close;
    PONLINE_V2_ROUTINE   Online;
    POFFLINE_V2_ROUTINE  Offline;
    PTERMINATE_ROUTINE   Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE    IsAlive;
    PARBITRATE_ROUTINE   Arbitrate;
    PRELEASE_ROUTINE     Release;
    PBEGIN_RESCALL_ROUTINE BeginResourceControl;
    PBEGIN_RESTYPECALL_ROUTINE BeginResourceTypeControl;
    PCANCEL_ROUTINE      Cancel;
    PBEGIN_RESCALL_AS_USER_ROUTINE BeginResourceControlAsUser;
    PBEGIN_RESTYPECALL_AS_USER_ROUTINE BeginResourceTypeControlAsUser;
}

struct CLRES_FUNCTION_TABLE
{
    uint TableSize;
    uint Version;
    union
    {
        CLRES_V1_FUNCTIONS V1Functions;
        CLRES_V2_FUNCTIONS V2Functions;
        CLRES_V3_FUNCTIONS V3Functions;
        CLRES_V4_FUNCTIONS V4Functions;
    }
}

struct RESUTIL_LARGEINT_DATA
{
    LARGE_INTEGER Default;
    LARGE_INTEGER Minimum;
    LARGE_INTEGER Maximum;
}

struct RESUTIL_ULARGEINT_DATA
{
    ULARGE_INTEGER Default;
    ULARGE_INTEGER Minimum;
    ULARGE_INTEGER Maximum;
}

struct RESUTIL_FILETIME_DATA
{
    FILETIME Default;
    FILETIME Minimum;
    FILETIME Maximum;
}

struct RESUTIL_PROPERTY_ITEM
{
    const(wchar)* Name;
    const(wchar)* KeyName;
    uint          Format;
    union
    {
        size_t DefaultPtr;
        uint   Default;
        void*  lpDefault;
        RESUTIL_LARGEINT_DATA* LargeIntData;
        RESUTIL_ULARGEINT_DATA* ULargeIntData;
        RESUTIL_FILETIME_DATA* FileTimeData;
    }
    uint          Minimum;
    uint          Maximum;
    uint          Flags;
    uint          Offset;
}

struct CLRES_CALLBACK_FUNCTION_TABLE
{
    PLOG_EVENT_ROUTINE  LogEvent;
    PSET_RESOURCE_STATUS_ROUTINE_EX SetResourceStatusEx;
    PSET_RESOURCE_LOCKED_MODE_ROUTINE SetResourceLockedMode;
    PSIGNAL_FAILURE_ROUTINE SignalFailure;
    PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE SetResourceInMemoryNodeLocalProperties;
    PEND_CONTROL_CALL   EndControlCall;
    PEND_TYPE_CONTROL_CALL EndTypeControlCall;
    PEXTEND_RES_CONTROL_CALL ExtendControlCall;
    PEXTEND_RES_TYPE_CONTROL_CALL ExtendTypeControlCall;
    PRAISE_RES_TYPE_NOTIFICATION RaiseResTypeNotification;
    PCHANGE_RESOURCE_PROCESS_FOR_DUMPS ChangeResourceProcessForDumps;
    PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS ChangeResTypeProcessForDumps;
    PSET_INTERNAL_STATE SetInternalState;
    PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE SetResourceLockedModeEx;
}

struct MONITOR_STATE
{
    LARGE_INTEGER LastUpdate;
    RESOURCE_MONITOR_STATE State;
    HANDLE        ActiveResource;
    BOOL          ResmonStop;
}

struct POST_UPGRADE_VERSION_INFO
{
    uint newMajorVersion;
    uint newUpgradeVersion;
    uint oldMajorVersion;
    uint oldUpgradeVersion;
    uint reserved;
}

struct CLUSTER_HEALTH_FAULT
{
    const(wchar)* Id;
    uint          ErrorType;
    uint          ErrorCode;
    const(wchar)* Description;
    const(wchar)* Provider;
    uint          Flags;
    uint          Reserved;
}

struct CLUSTER_HEALTH_FAULT_ARRAY
{
    uint numFaults;
    CLUSTER_HEALTH_FAULT* faults;
}

struct CLUS_WORKER
{
    HANDLE hThread;
    BOOL   Terminate;
}

struct _HCLUSCRYPTPROVIDER
{
}

struct PaxosTagCStruct
{
    ulong __padding__PaxosTagVtable;
    ulong __padding__NextEpochVtable;
    ulong __padding__NextEpoch_DateTimeVtable;
    ulong NextEpoch_DateTime_ticks;
    int   NextEpoch_Value;
    uint  __padding__BoundryNextEpoch;
    ulong __padding__EpochVtable;
    ulong __padding__Epoch_DateTimeVtable;
    ulong Epoch_DateTime_ticks;
    int   Epoch_Value;
    uint  __padding__BoundryEpoch;
    int   Sequence;
    uint  __padding__BoundrySequence;
}

struct WitnessTagUpdateHelper
{
    int             Version;
    PaxosTagCStruct paxosToSet;
    PaxosTagCStruct paxosToValidate;
}

struct WitnessTagHelper
{
    int             Version;
    PaxosTagCStruct paxosToValidate;
}

// Functions

@DllImport("CLUSAPI")
uint GetNodeClusterState(const(wchar)* lpszNodeName, uint* pdwClusterState);

@DllImport("CLUSAPI")
_HCLUSTER* OpenCluster(const(wchar)* lpszClusterName);

@DllImport("CLUSAPI")
_HCLUSTER* OpenClusterEx(const(wchar)* lpszClusterName, uint DesiredAccess, uint* GrantedAccess);

@DllImport("CLUSAPI")
BOOL CloseCluster(_HCLUSTER* hCluster);

@DllImport("CLUSAPI")
uint SetClusterName(_HCLUSTER* hCluster, const(wchar)* lpszNewClusterName);

@DllImport("CLUSAPI")
uint GetClusterInformation(_HCLUSTER* hCluster, const(wchar)* lpszClusterName, uint* lpcchClusterName, 
                           CLUSTERVERSIONINFO* lpClusterInfo);

@DllImport("CLUSAPI")
uint GetClusterQuorumResource(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, uint* lpcchResourceName, 
                              const(wchar)* lpszDeviceName, uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);

@DllImport("CLUSAPI")
uint SetClusterQuorumResource(_HRESOURCE* hResource, const(wchar)* lpszDeviceName, uint dwMaxQuoLogSize);

@DllImport("CLUSAPI")
uint BackupClusterDatabase(_HCLUSTER* hCluster, const(wchar)* lpszPathName);

@DllImport("CLUSAPI")
uint RestoreClusterDatabase(const(wchar)* lpszPathName, BOOL bForce, const(wchar)* lpszQuorumDriveLetter);

@DllImport("CLUSAPI")
uint SetClusterNetworkPriorityOrder(_HCLUSTER* hCluster, uint NetworkCount, char* NetworkList);

@DllImport("CLUSAPI")
uint SetClusterServiceAccountPassword(const(wchar)* lpszClusterName, const(wchar)* lpszNewPassword, uint dwFlags, 
                                      char* lpReturnStatusBuffer, uint* lpcbReturnStatusBufferSize);

@DllImport("CLUSAPI")
uint ClusterControl(_HCLUSTER* hCluster, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, 
                    uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
uint ClusterUpgradeFunctionalLevel(_HCLUSTER* hCluster, BOOL perform, 
                                   PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI")
_HCHANGE* CreateClusterNotifyPortV2(_HCHANGE* hChange, _HCLUSTER* hCluster, NOTIFY_FILTER_AND_TYPE* Filters, 
                                    uint dwFilterCount, size_t dwNotifyKey);

@DllImport("CLUSAPI")
uint RegisterClusterNotifyV2(_HCHANGE* hChange, NOTIFY_FILTER_AND_TYPE Filter, HANDLE hObject, size_t dwNotifyKey);

@DllImport("CLUSAPI")
uint GetNotifyEventHandle(_HCHANGE* hChange, ptrdiff_t* lphTargetEvent);

@DllImport("CLUSAPI")
uint GetClusterNotifyV2(_HCHANGE* hChange, size_t* lpdwNotifyKey, NOTIFY_FILTER_AND_TYPE* pFilterAndType, 
                        char* buffer, uint* lpbBufferSize, const(wchar)* lpszObjectId, uint* lpcchObjectId, 
                        const(wchar)* lpszParentId, uint* lpcchParentId, const(wchar)* lpszName, uint* lpcchName, 
                        const(wchar)* lpszType, uint* lpcchType, uint dwMilliseconds);

@DllImport("CLUSAPI")
_HCHANGE* CreateClusterNotifyPort(_HCHANGE* hChange, _HCLUSTER* hCluster, uint dwFilter, size_t dwNotifyKey);

@DllImport("CLUSAPI")
uint RegisterClusterNotify(_HCHANGE* hChange, uint dwFilterType, HANDLE hObject, size_t dwNotifyKey);

@DllImport("CLUSAPI")
uint GetClusterNotify(_HCHANGE* hChange, size_t* lpdwNotifyKey, uint* lpdwFilterType, const(wchar)* lpszName, 
                      uint* lpcchName, uint dwMilliseconds);

@DllImport("CLUSAPI")
BOOL CloseClusterNotifyPort(_HCHANGE* hChange);

@DllImport("CLUSAPI")
_HCLUSENUM* ClusterOpenEnum(_HCLUSTER* hCluster, uint dwType);

@DllImport("CLUSAPI")
uint ClusterGetEnumCount(_HCLUSENUM* hEnum);

@DllImport("CLUSAPI")
uint ClusterEnum(_HCLUSENUM* hEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterCloseEnum(_HCLUSENUM* hEnum);

@DllImport("CLUSAPI")
_HCLUSENUMEX* ClusterOpenEnumEx(_HCLUSTER* hCluster, uint dwType, void* pOptions);

@DllImport("CLUSAPI")
uint ClusterGetEnumCountEx(_HCLUSENUMEX* hClusterEnum);

@DllImport("CLUSAPI")
uint ClusterEnumEx(_HCLUSENUMEX* hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

@DllImport("CLUSAPI")
uint ClusterCloseEnumEx(_HCLUSENUMEX* hClusterEnum);

@DllImport("CLUSAPI")
_HGROUPSET* CreateClusterGroupSet(_HCLUSTER* hCluster, const(wchar)* groupSetName);

@DllImport("CLUSAPI")
_HGROUPSET* OpenClusterGroupSet(_HCLUSTER* hCluster, const(wchar)* lpszGroupSetName);

@DllImport("CLUSAPI")
BOOL CloseClusterGroupSet(_HGROUPSET* hGroupSet);

@DllImport("CLUSAPI")
uint DeleteClusterGroupSet(_HGROUPSET* hGroupSet);

@DllImport("CLUSAPI")
uint ClusterAddGroupToGroupSet(_HGROUPSET* hGroupSet, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ClusterAddGroupToGroupSetWithDomains(_HGROUPSET* hGroupSet, _HGROUP* hGroup, uint faultDomain, 
                                          uint updateDomain);

@DllImport("CLUSAPI")
uint ClusterRemoveGroupFromGroupSet(_HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ClusterGroupSetControl(_HGROUPSET* hGroupSet, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, 
                            uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
uint AddClusterGroupDependency(_HGROUP* hDependentGroup, _HGROUP* hProviderGroup);

@DllImport("CLUSAPI")
uint SetGroupDependencyExpression(_HGROUP* hGroup, const(wchar)* lpszDependencyExpression);

@DllImport("CLUSAPI")
uint RemoveClusterGroupDependency(_HGROUP* hGroup, _HGROUP* hDependsOn);

@DllImport("CLUSAPI")
uint AddClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, _HGROUPSET* hProviderGroupSet);

@DllImport("CLUSAPI")
uint SetClusterGroupSetDependencyExpression(_HGROUPSET* hGroupSet, const(wchar)* lpszDependencyExprssion);

@DllImport("CLUSAPI")
uint RemoveClusterGroupSetDependency(_HGROUPSET* hGroupSet, _HGROUPSET* hDependsOn);

@DllImport("CLUSAPI")
uint AddClusterGroupToGroupSetDependency(_HGROUP* hDependentGroup, _HGROUPSET* hProviderGroupSet);

@DllImport("CLUSAPI")
uint RemoveClusterGroupToGroupSetDependency(_HGROUP* hGroup, _HGROUPSET* hDependsOn);

@DllImport("CLUSAPI")
_HGROUPSETENUM* ClusterGroupSetOpenEnum(_HCLUSTER* hCluster);

@DllImport("CLUSAPI")
uint ClusterGroupSetGetEnumCount(_HGROUPSETENUM* hGroupSetEnum);

@DllImport("CLUSAPI")
uint ClusterGroupSetEnum(_HGROUPSETENUM* hGroupSetEnum, uint dwIndex, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterGroupSetCloseEnum(_HGROUPSETENUM* hGroupSetEnum);

@DllImport("CLUSAPI")
uint AddCrossClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, const(wchar)* lpRemoteClusterName, 
                                       const(wchar)* lpRemoteGroupSetName);

@DllImport("CLUSAPI")
uint RemoveCrossClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, const(wchar)* lpRemoteClusterName, 
                                          const(wchar)* lpRemoteGroupSetName);

@DllImport("CLUSAPI")
_HGROUPSET* CreateClusterAvailabilitySet(_HCLUSTER* hCluster, const(wchar)* lpAvailabilitySetName, 
                                         CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);

@DllImport("CLUSAPI")
uint ClusterNodeReplacement(_HCLUSTER* hCluster, const(wchar)* lpszNodeNameCurrent, const(wchar)* lpszNodeNameNew);

@DllImport("CLUSAPI")
uint ClusterCreateAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName, CLUS_AFFINITY_RULE_TYPE ruleType);

@DllImport("CLUSAPI")
uint ClusterRemoveAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName);

@DllImport("CLUSAPI")
uint ClusterAddGroupToAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ClusterRemoveGroupFromAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ClusterAffinityRuleControl(_HCLUSTER* hCluster, const(wchar)* affinityRuleName, _HNODE* hHostNode, 
                                uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, 
                                uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
_HNODE* OpenClusterNode(_HCLUSTER* hCluster, const(wchar)* lpszNodeName);

@DllImport("CLUSAPI")
_HNODE* OpenClusterNodeEx(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, uint dwDesiredAccess, 
                          uint* lpdwGrantedAccess);

@DllImport("CLUSAPI")
_HNODE* OpenClusterNodeById(_HCLUSTER* hCluster, uint nodeId);

@DllImport("CLUSAPI")
BOOL CloseClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI")
CLUSTER_NODE_STATE GetClusterNodeState(_HNODE* hNode);

@DllImport("CLUSAPI")
uint GetClusterNodeId(_HNODE* hNode, const(wchar)* lpszNodeId, uint* lpcchName);

@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromNode(_HNODE* hNode);

@DllImport("CLUSAPI")
uint PauseClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI")
uint ResumeClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI")
uint EvictClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI")
_HNETINTERFACEENUM* ClusterNetInterfaceOpenEnum(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, 
                                                const(wchar)* lpszNetworkName);

@DllImport("CLUSAPI")
uint ClusterNetInterfaceEnum(_HNETINTERFACEENUM* hNetInterfaceEnum, uint dwIndex, const(wchar)* lpszName, 
                             uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterNetInterfaceCloseEnum(_HNETINTERFACEENUM* hNetInterfaceEnum);

@DllImport("CLUSAPI")
_HNODEENUM* ClusterNodeOpenEnum(_HNODE* hNode, uint dwType);

@DllImport("CLUSAPI")
_HNODEENUMEX* ClusterNodeOpenEnumEx(_HNODE* hNode, uint dwType, void* pOptions);

@DllImport("CLUSAPI")
uint ClusterNodeGetEnumCountEx(_HNODEENUMEX* hNodeEnum);

@DllImport("CLUSAPI")
uint ClusterNodeEnumEx(_HNODEENUMEX* hNodeEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

@DllImport("CLUSAPI")
uint ClusterNodeCloseEnumEx(_HNODEENUMEX* hNodeEnum);

@DllImport("CLUSAPI")
uint ClusterNodeGetEnumCount(_HNODEENUM* hNodeEnum);

@DllImport("CLUSAPI")
uint ClusterNodeCloseEnum(_HNODEENUM* hNodeEnum);

@DllImport("CLUSAPI")
uint ClusterNodeEnum(_HNODEENUM* hNodeEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI")
uint EvictClusterNodeEx(_HNODE* hNode, uint dwTimeOut, int* phrCleanupStatus);

@DllImport("CLUSAPI")
HKEY GetClusterResourceTypeKey(_HCLUSTER* hCluster, const(wchar)* lpszTypeName, uint samDesired);

@DllImport("CLUSAPI")
_HGROUP* CreateClusterGroup(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);

@DllImport("CLUSAPI")
_HGROUP* OpenClusterGroup(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);

@DllImport("CLUSAPI")
_HGROUP* OpenClusterGroupEx(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, uint dwDesiredAccess, 
                            uint* lpdwGrantedAccess);

@DllImport("CLUSAPI")
uint PauseClusterNodeEx(_HNODE* hNode, BOOL bDrainNode, uint dwPauseFlags, _HNODE* hNodeDrainTarget);

@DllImport("CLUSAPI")
uint ResumeClusterNodeEx(_HNODE* hNode, CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                         uint dwResumeFlagsReserved);

@DllImport("CLUSAPI")
_HGROUP* CreateClusterGroupEx(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, 
                              CLUSTER_CREATE_GROUP_INFO* pGroupInfo);

@DllImport("CLUSAPI")
_HGROUPENUMEX* ClusterGroupOpenEnumEx(_HCLUSTER* hCluster, const(wchar)* lpszProperties, uint cbProperties, 
                                      const(wchar)* lpszRoProperties, uint cbRoProperties, uint dwFlags);

@DllImport("CLUSAPI")
uint ClusterGroupGetEnumCountEx(_HGROUPENUMEX* hGroupEnumEx);

@DllImport("CLUSAPI")
uint ClusterGroupEnumEx(_HGROUPENUMEX* hGroupEnumEx, uint dwIndex, CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);

@DllImport("CLUSAPI")
uint ClusterGroupCloseEnumEx(_HGROUPENUMEX* hGroupEnumEx);

@DllImport("CLUSAPI")
_HRESENUMEX* ClusterResourceOpenEnumEx(_HCLUSTER* hCluster, const(wchar)* lpszProperties, uint cbProperties, 
                                       const(wchar)* lpszRoProperties, uint cbRoProperties, uint dwFlags);

@DllImport("CLUSAPI")
uint ClusterResourceGetEnumCountEx(_HRESENUMEX* hResourceEnumEx);

@DllImport("CLUSAPI")
uint ClusterResourceEnumEx(_HRESENUMEX* hResourceEnumEx, uint dwIndex, CLUSTER_RESOURCE_ENUM_ITEM* pItem, 
                           uint* cbItem);

@DllImport("CLUSAPI")
uint ClusterResourceCloseEnumEx(_HRESENUMEX* hResourceEnumEx);

@DllImport("CLUSAPI")
uint OnlineClusterGroupEx(_HGROUP* hGroup, _HNODE* hDestinationNode, uint dwOnlineFlags, char* lpInBuffer, 
                          uint cbInBufferSize);

@DllImport("CLUSAPI")
uint OfflineClusterGroupEx(_HGROUP* hGroup, uint dwOfflineFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI")
uint OnlineClusterResourceEx(_HRESOURCE* hResource, uint dwOnlineFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI")
uint OfflineClusterResourceEx(_HRESOURCE* hResource, uint dwOfflineFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI")
uint MoveClusterGroupEx(_HGROUP* hGroup, _HNODE* hDestinationNode, uint dwMoveFlags, char* lpInBuffer, 
                        uint cbInBufferSize);

@DllImport("CLUSAPI")
uint CancelClusterGroupOperation(_HGROUP* hGroup, uint dwCancelFlags_RESERVED);

@DllImport("CLUSAPI")
uint RestartClusterResource(_HRESOURCE* hResource, uint dwFlags);

@DllImport("CLUSAPI")
BOOL CloseClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI")
CLUSTER_GROUP_STATE GetClusterGroupState(_HGROUP* hGroup, const(wchar)* lpszNodeName, uint* lpcchNodeName);

@DllImport("CLUSAPI")
uint SetClusterGroupName(_HGROUP* hGroup, const(wchar)* lpszGroupName);

@DllImport("CLUSAPI")
uint SetClusterGroupNodeList(_HGROUP* hGroup, uint NodeCount, char* NodeList);

@DllImport("CLUSAPI")
uint OnlineClusterGroup(_HGROUP* hGroup, _HNODE* hDestinationNode);

@DllImport("CLUSAPI")
uint MoveClusterGroup(_HGROUP* hGroup, _HNODE* hDestinationNode);

@DllImport("CLUSAPI")
uint OfflineClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI")
uint DeleteClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI")
uint DestroyClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI")
_HGROUPENUM* ClusterGroupOpenEnum(_HGROUP* hGroup, uint dwType);

@DllImport("CLUSAPI")
uint ClusterGroupGetEnumCount(_HGROUPENUM* hGroupEnum);

@DllImport("CLUSAPI")
uint ClusterGroupEnum(_HGROUPENUM* hGroupEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszResourceName, 
                      uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterGroupCloseEnum(_HGROUPENUM* hGroupEnum);

@DllImport("CLUSAPI")
_HRESOURCE* CreateClusterResource(_HGROUP* hGroup, const(wchar)* lpszResourceName, const(wchar)* lpszResourceType, 
                                  uint dwFlags);

@DllImport("CLUSAPI")
_HRESOURCE* OpenClusterResource(_HCLUSTER* hCluster, const(wchar)* lpszResourceName);

@DllImport("CLUSAPI")
_HRESOURCE* OpenClusterResourceEx(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, uint dwDesiredAccess, 
                                  uint* lpdwGrantedAccess);

@DllImport("CLUSAPI")
BOOL CloseClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
uint DeleteClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
CLUSTER_RESOURCE_STATE GetClusterResourceState(_HRESOURCE* hResource, const(wchar)* lpszNodeName, 
                                               uint* lpcchNodeName, const(wchar)* lpszGroupName, 
                                               uint* lpcchGroupName);

@DllImport("CLUSAPI")
uint SetClusterResourceName(_HRESOURCE* hResource, const(wchar)* lpszResourceName);

@DllImport("CLUSAPI")
uint FailClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
uint OnlineClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
uint OfflineClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
uint ChangeClusterResourceGroup(_HRESOURCE* hResource, _HGROUP* hGroup);

@DllImport("CLUSAPI")
uint ChangeClusterResourceGroupEx(_HRESOURCE* hResource, _HGROUP* hGroup, ulong Flags);

@DllImport("CLUSAPI")
uint AddClusterResourceNode(_HRESOURCE* hResource, _HNODE* hNode);

@DllImport("CLUSAPI")
uint RemoveClusterResourceNode(_HRESOURCE* hResource, _HNODE* hNode);

@DllImport("CLUSAPI")
uint AddClusterResourceDependency(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);

@DllImport("CLUSAPI")
uint RemoveClusterResourceDependency(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);

@DllImport("CLUSAPI")
uint SetClusterResourceDependencyExpression(_HRESOURCE* hResource, const(wchar)* lpszDependencyExpression);

@DllImport("CLUSAPI")
uint GetClusterResourceDependencyExpression(_HRESOURCE* hResource, const(wchar)* lpszDependencyExpression, 
                                            uint* lpcchDependencyExpression);

@DllImport("CLUSAPI")
uint AddResourceToClusterSharedVolumes(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
uint RemoveResourceFromClusterSharedVolumes(_HRESOURCE* hResource);

@DllImport("CLUSAPI")
uint IsFileOnClusterSharedVolume(const(wchar)* lpszPathName, int* pbFileIsOnSharedVolume);

@DllImport("CLUSAPI")
uint ClusterSharedVolumeSetSnapshotState(GUID guidSnapshotSet, const(wchar)* lpszVolumeName, 
                                         CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);

@DllImport("CLUSAPI")
BOOL CanResourceBeDependent(_HRESOURCE* hResource, _HRESOURCE* hResourceDependent);

@DllImport("CLUSAPI")
uint ClusterResourceControl(_HRESOURCE* hResource, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, 
                            uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
uint ClusterResourceControlAsUser(_HRESOURCE* hResource, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, 
                                  uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, 
                                  uint* lpBytesReturned);

@DllImport("CLUSAPI")
uint ClusterResourceTypeControl(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, _HNODE* hHostNode, 
                                uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                                uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
uint ClusterResourceTypeControlAsUser(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, _HNODE* hHostNode, 
                                      uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                                      uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
uint ClusterGroupControl(_HGROUP* hGroup, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, 
                         uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
uint ClusterNodeControl(_HNODE* hNode, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, 
                        char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
BOOL GetClusterResourceNetworkName(_HRESOURCE* hResource, const(wchar)* lpBuffer, uint* nSize);

@DllImport("CLUSAPI")
_HRESENUM* ClusterResourceOpenEnum(_HRESOURCE* hResource, uint dwType);

@DllImport("CLUSAPI")
uint ClusterResourceGetEnumCount(_HRESENUM* hResEnum);

@DllImport("CLUSAPI")
uint ClusterResourceEnum(_HRESENUM* hResEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, 
                         uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterResourceCloseEnum(_HRESENUM* hResEnum);

@DllImport("CLUSAPI")
uint CreateClusterResourceType(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, 
                               const(wchar)* lpszDisplayName, const(wchar)* lpszResourceTypeDll, 
                               uint dwLooksAlivePollInterval, uint dwIsAlivePollInterval);

@DllImport("CLUSAPI")
uint DeleteClusterResourceType(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName);

@DllImport("CLUSAPI")
_HRESTYPEENUM* ClusterResourceTypeOpenEnum(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, uint dwType);

@DllImport("CLUSAPI")
uint ClusterResourceTypeGetEnumCount(_HRESTYPEENUM* hResTypeEnum);

@DllImport("CLUSAPI")
uint ClusterResourceTypeEnum(_HRESTYPEENUM* hResTypeEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, 
                             uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterResourceTypeCloseEnum(_HRESTYPEENUM* hResTypeEnum);

@DllImport("CLUSAPI")
_HNETWORK* OpenClusterNetwork(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName);

@DllImport("CLUSAPI")
_HNETWORK* OpenClusterNetworkEx(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName, uint dwDesiredAccess, 
                                uint* lpdwGrantedAccess);

@DllImport("CLUSAPI")
BOOL CloseClusterNetwork(_HNETWORK* hNetwork);

@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromNetwork(_HNETWORK* hNetwork);

@DllImport("CLUSAPI")
_HNETWORKENUM* ClusterNetworkOpenEnum(_HNETWORK* hNetwork, uint dwType);

@DllImport("CLUSAPI")
uint ClusterNetworkGetEnumCount(_HNETWORKENUM* hNetworkEnum);

@DllImport("CLUSAPI")
uint ClusterNetworkEnum(_HNETWORKENUM* hNetworkEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, 
                        uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterNetworkCloseEnum(_HNETWORKENUM* hNetworkEnum);

@DllImport("CLUSAPI")
CLUSTER_NETWORK_STATE GetClusterNetworkState(_HNETWORK* hNetwork);

@DllImport("CLUSAPI")
uint SetClusterNetworkName(_HNETWORK* hNetwork, const(wchar)* lpszName);

@DllImport("CLUSAPI")
uint GetClusterNetworkId(_HNETWORK* hNetwork, const(wchar)* lpszNetworkId, uint* lpcchName);

@DllImport("CLUSAPI")
uint ClusterNetworkControl(_HNETWORK* hNetwork, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, 
                           uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI")
_HNETINTERFACE* OpenClusterNetInterface(_HCLUSTER* hCluster, const(wchar)* lpszInterfaceName);

@DllImport("CLUSAPI")
_HNETINTERFACE* OpenClusterNetInterfaceEx(_HCLUSTER* hCluster, const(wchar)* lpszInterfaceName, 
                                          uint dwDesiredAccess, uint* lpdwGrantedAccess);

@DllImport("CLUSAPI")
uint GetClusterNetInterface(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, const(wchar)* lpszNetworkName, 
                            const(wchar)* lpszInterfaceName, uint* lpcchInterfaceName);

@DllImport("CLUSAPI")
BOOL CloseClusterNetInterface(_HNETINTERFACE* hNetInterface);

@DllImport("CLUSAPI")
_HCLUSTER* GetClusterFromNetInterface(_HNETINTERFACE* hNetInterface);

@DllImport("CLUSAPI")
CLUSTER_NETINTERFACE_STATE GetClusterNetInterfaceState(_HNETINTERFACE* hNetInterface);

@DllImport("CLUSAPI")
uint ClusterNetInterfaceControl(_HNETINTERFACE* hNetInterface, _HNODE* hHostNode, uint dwControlCode, 
                                char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, 
                                uint* lpBytesReturned);

@DllImport("CLUSAPI")
HKEY GetClusterKey(_HCLUSTER* hCluster, uint samDesired);

@DllImport("CLUSAPI")
HKEY GetClusterGroupKey(_HGROUP* hGroup, uint samDesired);

@DllImport("CLUSAPI")
HKEY GetClusterResourceKey(_HRESOURCE* hResource, uint samDesired);

@DllImport("CLUSAPI")
HKEY GetClusterNodeKey(_HNODE* hNode, uint samDesired);

@DllImport("CLUSAPI")
HKEY GetClusterNetworkKey(_HNETWORK* hNetwork, uint samDesired);

@DllImport("CLUSAPI")
HKEY GetClusterNetInterfaceKey(_HNETINTERFACE* hNetInterface, uint samDesired);

@DllImport("CLUSAPI")
int ClusterRegCreateKey(HKEY hKey, const(wchar)* lpszSubKey, uint dwOptions, uint samDesired, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);

@DllImport("CLUSAPI")
int ClusterRegOpenKey(HKEY hKey, const(wchar)* lpszSubKey, uint samDesired, HKEY* phkResult);

@DllImport("CLUSAPI")
int ClusterRegDeleteKey(HKEY hKey, const(wchar)* lpszSubKey);

@DllImport("CLUSAPI")
int ClusterRegCloseKey(HKEY hKey);

@DllImport("CLUSAPI")
int ClusterRegEnumKey(HKEY hKey, uint dwIndex, const(wchar)* lpszName, uint* lpcchName, 
                      FILETIME* lpftLastWriteTime);

@DllImport("CLUSAPI")
uint ClusterRegSetValue(HKEY hKey, const(wchar)* lpszValueName, uint dwType, const(ubyte)* lpData, uint cbData);

@DllImport("CLUSAPI")
uint ClusterRegDeleteValue(HKEY hKey, const(wchar)* lpszValueName);

@DllImport("CLUSAPI")
int ClusterRegQueryValue(HKEY hKey, const(wchar)* lpszValueName, uint* lpdwValueType, char* lpData, uint* lpcbData);

@DllImport("CLUSAPI")
uint ClusterRegEnumValue(HKEY hKey, uint dwIndex, const(wchar)* lpszValueName, uint* lpcchValueName, 
                         uint* lpdwType, char* lpData, uint* lpcbData);

@DllImport("CLUSAPI")
int ClusterRegQueryInfoKey(HKEY hKey, uint* lpcSubKeys, uint* lpcchMaxSubKeyLen, uint* lpcValues, 
                           uint* lpcchMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                           FILETIME* lpftLastWriteTime);

@DllImport("CLUSAPI")
int ClusterRegGetKeySecurity(HKEY hKey, uint RequestedInformation, char* pSecurityDescriptor, 
                             uint* lpcbSecurityDescriptor);

@DllImport("CLUSAPI")
int ClusterRegSetKeySecurity(HKEY hKey, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("CLUSAPI")
int ClusterRegSyncDatabase(_HCLUSTER* hCluster, uint flags);

@DllImport("CLUSAPI")
int ClusterRegCreateBatch(HKEY hKey, _HREGBATCH** pHREGBATCH);

@DllImport("CLUSAPI")
int ClusterRegBatchAddCommand(_HREGBATCH* hRegBatch, CLUSTER_REG_COMMAND dwCommand, const(wchar)* wzName, 
                              uint dwOptions, char* lpData, uint cbData);

@DllImport("CLUSAPI")
int ClusterRegCloseBatch(_HREGBATCH* hRegBatch, BOOL bCommit, int* failedCommandNumber);

@DllImport("CLUSAPI")
int ClusterRegCloseBatchEx(_HREGBATCH* hRegBatch, uint flags, int* failedCommandNumber);

@DllImport("CLUSAPI")
int ClusterRegBatchReadCommand(_HREGBATCHNOTIFICATION* hBatchNotification, CLUSTER_BATCH_COMMAND* pBatchCommand);

@DllImport("CLUSAPI")
int ClusterRegBatchCloseNotification(_HREGBATCHNOTIFICATION* hBatchNotification);

@DllImport("CLUSAPI")
int ClusterRegCreateBatchNotifyPort(HKEY hKey, _HREGBATCHPORT** phBatchNotifyPort);

@DllImport("CLUSAPI")
int ClusterRegCloseBatchNotifyPort(_HREGBATCHPORT* hBatchNotifyPort);

@DllImport("CLUSAPI")
int ClusterRegGetBatchNotification(_HREGBATCHPORT* hBatchNotify, _HREGBATCHNOTIFICATION** phBatchNotification);

@DllImport("CLUSAPI")
int ClusterRegCreateReadBatch(HKEY hKey, _HREGREADBATCH** phRegReadBatch);

@DllImport("CLUSAPI")
int ClusterRegReadBatchAddCommand(_HREGREADBATCH* hRegReadBatch, const(wchar)* wzSubkeyName, 
                                  const(wchar)* wzValueName);

@DllImport("CLUSAPI")
int ClusterRegCloseReadBatch(_HREGREADBATCH* hRegReadBatch, _HREGREADBATCHREPLY** phRegReadBatchReply);

@DllImport("CLUSAPI")
int ClusterRegCloseReadBatchEx(_HREGREADBATCH* hRegReadBatch, uint flags, 
                               _HREGREADBATCHREPLY** phRegReadBatchReply);

@DllImport("CLUSAPI")
int ClusterRegReadBatchReplyNextCommand(_HREGREADBATCHREPLY* hRegReadBatchReply, 
                                        CLUSTER_READ_BATCH_COMMAND* pBatchCommand);

@DllImport("CLUSAPI")
int ClusterRegCloseReadBatchReply(_HREGREADBATCHREPLY* hRegReadBatchReply);

@DllImport("CLUSAPI")
uint ClusterSetAccountAccess(_HCLUSTER* hCluster, const(wchar)* szAccountSID, uint dwAccess, uint dwControlType);

@DllImport("CLUSAPI")
_HCLUSTER* CreateCluster(CREATE_CLUSTER_CONFIG* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                         void* pvCallbackArg);

@DllImport("CLUSAPI")
uint CreateClusterNameAccount(_HCLUSTER* hCluster, CREATE_CLUSTER_NAME_ACCOUNT* pConfig, 
                              PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI")
uint RemoveClusterNameAccount(_HCLUSTER* hCluster, BOOL bDeleteComputerObjects);

@DllImport("CLUSAPI")
uint DetermineCNOResTypeFromNodelist(uint cNodes, ushort** ppszNodeNames, CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI")
uint DetermineCNOResTypeFromCluster(_HCLUSTER* hCluster, CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI")
uint DetermineClusterCloudTypeFromNodelist(uint cNodes, ushort** ppszNodeNames, CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI")
uint DetermineClusterCloudTypeFromCluster(_HCLUSTER* hCluster, CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI")
uint GetNodeCloudTypeDW(const(wchar)* ppszNodeName, uint* NodeCloudType);

@DllImport("CLUSAPI")
uint RegisterClusterResourceTypeNotifyV2(_HCHANGE* hChange, _HCLUSTER* hCluster, long Flags, 
                                         const(wchar)* resTypeName, size_t dwNotifyKey);

@DllImport("CLUSAPI")
_HNODE* AddClusterNode(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, 
                       PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI")
uint AddClusterStorageNode(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, 
                           PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, 
                           const(wchar)* lpszClusterStorageNodeDescription, 
                           const(wchar)* lpszClusterStorageNodeLocation);

@DllImport("CLUSAPI")
uint RemoveClusterStorageNode(_HCLUSTER* hCluster, const(wchar)* lpszClusterStorageEnclosureName, uint dwTimeout, 
                              uint dwFlags);

@DllImport("CLUSAPI")
uint DestroyCluster(_HCLUSTER* hCluster, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, 
                    BOOL fdeleteVirtualComputerObjects);

@DllImport("RESUTILS")
uint InitializeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

@DllImport("RESUTILS")
uint InitializeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

@DllImport("RESUTILS")
uint FreeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

@DllImport("RESUTILS")
uint FreeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

@DllImport("RESUTILS")
uint ClusGetClusterHealthFaults(_HCLUSTER* hCluster, CLUSTER_HEALTH_FAULT_ARRAY* objects, uint flags);

@DllImport("RESUTILS")
uint ClusRemoveClusterHealthFault(_HCLUSTER* hCluster, const(wchar)* id, uint flags);

@DllImport("RESUTILS")
uint ClusAddClusterHealthFault(_HCLUSTER* hCluster, CLUSTER_HEALTH_FAULT* failure, uint param2);

@DllImport("RESUTILS")
uint ResUtilStartResourceService(const(wchar)* pszServiceName, SC_HANDLE__** phServiceHandle);

@DllImport("RESUTILS")
uint ResUtilVerifyResourceService(const(wchar)* pszServiceName);

@DllImport("RESUTILS")
uint ResUtilStopResourceService(const(wchar)* pszServiceName);

@DllImport("RESUTILS")
uint ResUtilVerifyService(SC_HANDLE__* hServiceHandle);

@DllImport("RESUTILS")
uint ResUtilStopService(SC_HANDLE__* hServiceHandle);

@DllImport("RESUTILS")
uint ResUtilCreateDirectoryTree(const(wchar)* pszPath);

@DllImport("RESUTILS")
BOOL ResUtilIsPathValid(const(wchar)* pszPath);

@DllImport("RESUTILS")
uint ResUtilEnumProperties(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, const(wchar)* pszOutProperties, 
                           uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilEnumPrivateProperties(HKEY hkeyClusterKey, const(wchar)* pszOutProperties, uint cbOutPropertiesSize, 
                                  uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilGetProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                          char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                          uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilGetAllProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                             char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                             uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilGetPrivateProperties(HKEY hkeyClusterKey, char* pOutPropertyList, uint cbOutPropertyListSize, 
                                 uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilGetPropertySize(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                            uint* pcbOutPropertyListSize, uint* pnPropertyCount);

@DllImport("RESUTILS")
uint ResUtilGetProperty(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                        char* pOutPropertyItem, uint* pcbOutPropertyItemSize);

@DllImport("RESUTILS")
uint ResUtilVerifyPropertyTable(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                                BOOL bAllowUnknownProperties, char* pInPropertyList, uint cbInPropertyListSize, 
                                ubyte* pOutParams);

@DllImport("RESUTILS")
uint ResUtilSetPropertyTable(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                             BOOL bAllowUnknownProperties, char* pInPropertyList, uint cbInPropertyListSize, 
                             ubyte* pOutParams);

@DllImport("RESUTILS")
uint ResUtilSetPropertyTableEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                               BOOL bAllowUnknownProperties, const(void)* pInPropertyList, uint cbInPropertyListSize, 
                               BOOL bForceWrite, ubyte* pOutParams);

@DllImport("RESUTILS")
uint ResUtilSetPropertyParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                      void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, 
                                      uint cbInPropertyListSize, ubyte* pOutParams);

@DllImport("RESUTILS")
uint ResUtilSetPropertyParameterBlockEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                        void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, 
                                        uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);

@DllImport("RESUTILS")
uint ResUtilSetUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                 char* pInPropertyList, uint cbInPropertyListSize);

@DllImport("RESUTILS")
uint ResUtilGetPropertiesToParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                          ubyte* pOutParams, BOOL bCheckForRequiredProperties, 
                                          ushort** pszNameOfPropInError);

@DllImport("RESUTILS")
uint ResUtilPropertyListFromParameterBlock(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyList, 
                                           uint* pcbOutPropertyListSize, const(ubyte)* pInParams, 
                                           uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilDupParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, 
                              const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

@DllImport("RESUTILS")
void ResUtilFreeParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, 
                               const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

@DllImport("RESUTILS")
uint ResUtilAddUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                 void* pOutPropertyList, uint pcbOutPropertyListSize, uint* pcbBytesReturned, 
                                 uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilSetPrivatePropertyList(HKEY hkeyClusterKey, char* pInPropertyList, uint cbInPropertyListSize);

@DllImport("RESUTILS")
uint ResUtilVerifyPrivatePropertyList(char* pInPropertyList, uint cbInPropertyListSize);

@DllImport("RESUTILS")
ushort* ResUtilDupString(const(wchar)* pszInString);

@DllImport("RESUTILS")
uint ResUtilGetBinaryValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* ppbOutValue, 
                           uint* pcbOutValueSize);

@DllImport("RESUTILS")
ushort* ResUtilGetSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName);

@DllImport("RESUTILS")
uint ResUtilGetDwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint* pdwOutValue, uint dwDefaultValue);

@DllImport("RESUTILS")
uint ResUtilGetQwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong* pqwOutValue, 
                          ulong qwDefaultValue);

@DllImport("RESUTILS")
uint ResUtilSetBinaryValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* pbNewValue, uint cbNewValueSize, 
                           char* ppbOutValue, uint* pcbOutValueSize);

@DllImport("RESUTILS")
uint ResUtilSetSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, 
                       ushort** ppszOutString);

@DllImport("RESUTILS")
uint ResUtilSetExpandSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, 
                             ushort** ppszOutString);

@DllImport("RESUTILS")
uint ResUtilSetMultiSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, 
                            uint cbNewValueSize, char* ppszOutValue, uint* pcbOutValueSize);

@DllImport("RESUTILS")
uint ResUtilSetDwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint dwNewValue, uint* pdwOutValue);

@DllImport("RESUTILS")
uint ResUtilSetQwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong qwNewValue, ulong* pqwOutValue);

@DllImport("RESUTILS")
uint ResUtilSetValueEx(HKEY hkeyClusterKey, const(wchar)* valueName, uint valueType, char* valueData, 
                       uint valueSize, uint flags);

@DllImport("RESUTILS")
uint ResUtilGetBinaryProperty(ubyte** ppbOutValue, uint* pcbOutValueSize, const(CLUSPROP_BINARY)* pValueStruct, 
                              char* pbOldValue, uint cbOldValueSize, char* ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS")
uint ResUtilGetSzProperty(ushort** ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, const(wchar)* pszOldValue, 
                          char* ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS")
uint ResUtilGetMultiSzProperty(ushort** ppszOutValue, uint* pcbOutValueSize, const(CLUSPROP_SZ)* pValueStruct, 
                               const(wchar)* pszOldValue, uint cbOldValueSize, char* ppPropertyList, 
                               uint* pcbPropertyListSize);

@DllImport("RESUTILS")
uint ResUtilGetDwordProperty(uint* pdwOutValue, const(CLUSPROP_DWORD)* pValueStruct, uint dwOldValue, 
                             uint dwMinimum, uint dwMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS")
uint ResUtilGetLongProperty(int* plOutValue, const(CLUSPROP_LONG)* pValueStruct, int lOldValue, int lMinimum, 
                            int lMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS")
uint ResUtilGetFileTimeProperty(FILETIME* pftOutValue, const(CLUSPROP_FILETIME)* pValueStruct, FILETIME ftOldValue, 
                                FILETIME ftMinimum, FILETIME ftMaximum, ubyte** ppPropertyList, 
                                uint* pcbPropertyListSize);

@DllImport("RESUTILS")
void* ResUtilGetEnvironmentWithNetName(_HRESOURCE* hResource);

@DllImport("RESUTILS")
uint ResUtilFreeEnvironment(void* lpEnvironment);

@DllImport("RESUTILS")
ushort* ResUtilExpandEnvironmentStrings(const(wchar)* pszSrc);

@DllImport("RESUTILS")
uint ResUtilSetResourceServiceEnvironment(const(wchar)* pszServiceName, _HRESOURCE* hResource, 
                                          PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

@DllImport("RESUTILS")
uint ResUtilRemoveResourceServiceEnvironment(const(wchar)* pszServiceName, PLOG_EVENT_ROUTINE pfnLogEvent, 
                                             ptrdiff_t hResourceHandle);

@DllImport("RESUTILS")
uint ResUtilSetResourceServiceStartParameters(const(wchar)* pszServiceName, SC_HANDLE__* schSCMHandle, 
                                              SC_HANDLE__** phService, PLOG_EVENT_ROUTINE pfnLogEvent, 
                                              ptrdiff_t hResourceHandle);

@DllImport("RESUTILS")
uint ResUtilFindSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                           ushort** pszPropertyValue);

@DllImport("RESUTILS")
uint ResUtilFindExpandSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                                 ushort** pszPropertyValue);

@DllImport("RESUTILS")
uint ResUtilFindExpandedSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                                   ushort** pszPropertyValue);

@DllImport("RESUTILS")
uint ResUtilFindDwordProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                              uint* pdwPropertyValue);

@DllImport("RESUTILS")
uint ResUtilFindBinaryProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                               char* pbPropertyValue, uint* pcbPropertyValueSize);

@DllImport("RESUTILS")
uint ResUtilFindMultiSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                                char* pszPropertyValue, uint* pcbPropertyValueSize);

@DllImport("RESUTILS")
uint ResUtilFindLongProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                             int* plPropertyValue);

@DllImport("RESUTILS")
uint ResUtilFindULargeIntegerProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                                      ulong* plPropertyValue);

@DllImport("RESUTILS")
uint ResUtilFindFileTimeProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, 
                                 FILETIME* pftPropertyValue);

@DllImport("RESUTILS")
uint ClusWorkerCreate(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, void* lpParameter);

@DllImport("RESUTILS")
BOOL ClusWorkerCheckTerminate(CLUS_WORKER* lpWorker);

@DllImport("RESUTILS")
void ClusWorkerTerminate(CLUS_WORKER* lpWorker);

@DllImport("RESUTILS")
uint ClusWorkerTerminateEx(CLUS_WORKER* ClusWorker, uint TimeoutInMilliseconds, BOOL WaitOnly);

@DllImport("RESUTILS")
uint ClusWorkersTerminate(char* ClusWorkers, const(size_t) ClusWorkersCount, uint TimeoutInMilliseconds, 
                          BOOL WaitOnly);

@DllImport("RESUTILS")
BOOL ResUtilResourcesEqual(_HRESOURCE* hSelf, _HRESOURCE* hResource);

@DllImport("RESUTILS")
BOOL ResUtilResourceTypesEqual(const(wchar)* lpszResourceTypeName, _HRESOURCE* hResource);

@DllImport("RESUTILS")
BOOL ResUtilIsResourceClassEqual(CLUS_RESOURCE_CLASS_INFO* prci, _HRESOURCE* hResource);

@DllImport("RESUTILS")
uint ResUtilEnumResources(_HRESOURCE* hSelf, const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK pResCallBack, 
                          void* pParameter);

@DllImport("RESUTILS")
uint ResUtilEnumResourcesEx(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(wchar)* lpszResTypeName, 
                            LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependency(HANDLE hSelf, const(wchar)* lpszResourceType);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByName(_HCLUSTER* hCluster, HANDLE hSelf, const(wchar)* lpszResourceType, 
                                               BOOL bRecurse);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByClass(_HCLUSTER* hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, 
                                                BOOL bRecurse);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceNameDependency(const(wchar)* lpszResourceName, const(wchar)* lpszResourceType);

@DllImport("RESUTILS")
uint ResUtilGetResourceDependentIPAddressProps(_HRESOURCE* hResource, const(wchar)* pszAddress, uint* pcchAddress, 
                                               const(wchar)* pszSubnetMask, uint* pcchSubnetMask, 
                                               const(wchar)* pszNetwork, uint* pcchNetwork);

@DllImport("RESUTILS")
uint ResUtilFindDependentDiskResourceDriveLetter(_HCLUSTER* hCluster, _HRESOURCE* hResource, 
                                                 const(wchar)* pszDriveLetter, uint* pcchDriveLetter);

@DllImport("RESUTILS")
uint ResUtilTerminateServiceProcessFromResDll(uint dwServicePid, BOOL bOffline, uint* pdwResourceState, 
                                              PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

@DllImport("RESUTILS")
uint ResUtilGetPropertyFormats(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyFormatList, 
                               uint cbPropertyFormatListSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS")
uint ResUtilGetCoreClusterResources(_HCLUSTER* hCluster, _HRESOURCE** phClusterNameResource, 
                                    _HRESOURCE** phClusterIPAddressResource, _HRESOURCE** phClusterQuorumResource);

@DllImport("RESUTILS")
uint ResUtilGetResourceName(_HRESOURCE* hResource, const(wchar)* pszResourceName, uint* pcchResourceNameInOut);

@DllImport("RESUTILS")
CLUSTER_ROLE_STATE ResUtilGetClusterRoleState(_HCLUSTER* hCluster, CLUSTER_ROLE eClusterRole);

@DllImport("RESUTILS")
BOOL ClusterIsPathOnSharedVolume(const(wchar)* lpszPathName);

@DllImport("RESUTILS")
BOOL ClusterGetVolumePathName(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, uint cchBufferLength);

@DllImport("RESUTILS")
BOOL ClusterGetVolumeNameForVolumeMountPoint(const(wchar)* lpszVolumeMountPoint, const(wchar)* lpszVolumeName, 
                                             uint cchBufferLength);

@DllImport("RESUTILS")
uint ClusterPrepareSharedVolumeForBackup(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, 
                                         uint* lpcchVolumePathName, const(wchar)* lpszVolumeName, 
                                         uint* lpcchVolumeName);

@DllImport("RESUTILS")
uint ClusterClearBackupStateForSharedVolume(const(wchar)* lpszVolumePathName);

@DllImport("RESUTILS")
uint ResUtilSetResourceServiceStartParametersEx(const(wchar)* pszServiceName, SC_HANDLE__* schSCMHandle, 
                                                SC_HANDLE__** phService, uint dwDesiredAccess, 
                                                PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

@DllImport("RESUTILS")
uint ResUtilEnumResourcesEx2(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(wchar)* lpszResTypeName, 
                             LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter, uint dwDesiredAccess);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyEx(HANDLE hSelf, const(wchar)* lpszResourceType, uint dwDesiredAccess);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByNameEx(_HCLUSTER* hCluster, HANDLE hSelf, const(wchar)* lpszResourceType, 
                                                 BOOL bRecurse, uint dwDesiredAccess);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceDependencyByClassEx(_HCLUSTER* hCluster, HANDLE hSelf, 
                                                  CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse, 
                                                  uint dwDesiredAccess);

@DllImport("RESUTILS")
_HRESOURCE* ResUtilGetResourceNameDependencyEx(const(wchar)* lpszResourceName, const(wchar)* lpszResourceType, 
                                               uint dwDesiredAccess);

@DllImport("RESUTILS")
uint ResUtilGetCoreClusterResourcesEx(_HCLUSTER* hClusterIn, _HRESOURCE** phClusterNameResourceOut, 
                                      _HRESOURCE** phClusterQuorumResourceOut, uint dwDesiredAccess);

@DllImport("RESUTILS")
_HCLUSCRYPTPROVIDER* OpenClusterCryptProvider(const(wchar)* lpszResource, byte* lpszProvider, uint dwType, 
                                              uint dwFlags);

@DllImport("RESUTILS")
_HCLUSCRYPTPROVIDER* OpenClusterCryptProviderEx(const(wchar)* lpszResource, const(wchar)* lpszKeyname, 
                                                byte* lpszProvider, uint dwType, uint dwFlags);

@DllImport("RESUTILS")
uint CloseClusterCryptProvider(_HCLUSCRYPTPROVIDER* hClusCryptProvider);

@DllImport("RESUTILS")
uint ClusterEncrypt(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pData, uint cbData, ubyte** ppData, 
                    uint* pcbData);

@DllImport("RESUTILS")
uint ClusterDecrypt(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pCryptInput, uint cbCryptInput, 
                    ubyte** ppCryptOutput, uint* pcbCryptOutput);

@DllImport("RESUTILS")
uint FreeClusterCrypt(void* pCryptInfo);

@DllImport("RESUTILS")
BOOL ResUtilPaxosComparer(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

@DllImport("RESUTILS")
BOOL ResUtilLeftPaxosIsLessThanRight(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

@DllImport("RESUTILS")
uint ResUtilsDeleteKeyTree(HKEY key, const(wchar)* keyName, BOOL treatNoKeyAsError);

@DllImport("RESUTILS")
uint ResUtilGroupsEqual(_HGROUP* hSelf, _HGROUP* hGroup, int* pEqual);

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

@DllImport("NTLANMAN")
uint RegisterAppInstance(HANDLE ProcessHandle, GUID* AppInstanceId, BOOL ChildrenInheritAppInstance);

@DllImport("NTLANMAN")
uint RegisterAppInstanceVersion(GUID* AppInstanceId, ulong InstanceVersionHigh, ulong InstanceVersionLow);

@DllImport("NTLANMAN")
uint QueryAppInstanceVersion(GUID* AppInstanceId, ulong* InstanceVersionHigh, ulong* InstanceVersionLow, 
                             int* VersionStatus);

@DllImport("NTLANMAN")
uint ResetAllAppInstanceVersions();

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

@GUID("97DEDE50-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterUIInfo : IUnknown
{
    HRESULT GetClusterName(BSTR lpszName, int* pcchName);
    uint    GetLocale();
    HFONT   GetFont();
    HICON   GetIcon();
}

@GUID("97DEDE51-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterDataInfo : IUnknown
{
    HRESULT GetClusterName(BSTR lpszName, int* pcchName);
    _HCLUSTER* GetClusterHandle();
    int     GetObjectCount();
}

@GUID("97DEDE52-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterObjectInfo : IUnknown
{
    HRESULT GetObjectName(int lObjIndex, BSTR lpszName, int* pcchName);
    CLUADMEX_OBJECT_TYPE GetObjectType(int lObjIndex);
}

@GUID("97DEDE53-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterNodeInfo : IUnknown
{
    _HNODE* GetNodeHandle(int lObjIndex);
}

@GUID("97DEDE54-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterGroupInfo : IUnknown
{
    _HGROUP* GetGroupHandle(int lObjIndex);
}

@GUID("97DEDE55-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterResourceInfo : IUnknown
{
    _HRESOURCE* GetResourceHandle(int lObjIndex);
    HRESULT GetResourceTypeName(int lObjIndex, BSTR lpszResTypeName, int* pcchResTypeName);
    BOOL    GetResourceNetworkName(int lObjIndex, BSTR lpszNetName, uint* pcchNetName);
}

@GUID("97DEDE56-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterNetworkInfo : IUnknown
{
    _HNETWORK* GetNetworkHandle(int lObjIndex);
}

@GUID("97DEDE57-FC6B-11CF-B5F5-00A0C90AB505")
interface IGetClusterNetInterfaceInfo : IUnknown
{
    _HNETINTERFACE* GetNetInterfaceHandle(int lObjIndex);
}

@GUID("97DEDE60-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCPropertySheetCallback : IUnknown
{
    HRESULT AddPropertySheetPage(int* hpage);
}

@GUID("97DEDE61-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendPropertySheet : IUnknown
{
    HRESULT CreatePropertySheetPages(IUnknown piData, IWCPropertySheetCallback piCallback);
}

@GUID("97DEDE62-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCWizardCallback : IUnknown
{
    HRESULT AddWizardPage(int* hpage);
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

@GUID("97DEDE63-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendWizard : IUnknown
{
    HRESULT CreateWizardPages(IUnknown piData, IWCWizardCallback piCallback);
}

@GUID("97DEDE64-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCContextMenuCallback : IUnknown
{
    HRESULT AddExtensionMenuItem(BSTR lpszName, BSTR lpszStatusBarText, uint nCommandID, uint nSubmenuCommandID, 
                                 uint uFlags);
}

@GUID("97DEDE65-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendContextMenu : IUnknown
{
    HRESULT AddContextMenuItems(IUnknown piData, IWCContextMenuCallback piCallback);
}

@GUID("97DEDE66-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEInvokeCommand : IUnknown
{
    HRESULT InvokeCommand(uint nCommandID, IUnknown piData);
}

@GUID("97DEDE67-FC6B-11CF-B5F5-00A0C90AB505")
interface IWCWizard97Callback : IUnknown
{
    HRESULT AddWizard97Page(int* hpage);
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

@GUID("97DEDE68-FC6B-11CF-B5F5-00A0C90AB505")
interface IWEExtendWizard97 : IUnknown
{
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
    HRESULT get_MaintenanceMode(int* pbMaintenanceMode);
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
