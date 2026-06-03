// Written in the D programming language.

module windows.win32.networking.clustering;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, FILETIME, HANDLE,
                                         HRESULT, NTSTATUS, PWSTR, SYSTEMTIME;
public import windows.win32.graphics.gdi : HFONT;
public import windows.win32.security : OBJECT_SECURITY_INFORMATION, PSECURITY_DESCRIPTOR,
                                       SECURITY_ATTRIBUTES, SECURITY_DESCRIPTOR_RELATIVE;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.services : SC_HANDLE;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


alias CLUSTER_QUORUM_TYPE = int;
enum : int
{
    OperationalQuorum = 0x00000000,
    ModifyQuorum      = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-node_cluster_state
alias NODE_CLUSTER_STATE = int;
enum : int
{
    ClusterStateNotInstalled  = 0x00000000,
    ClusterStateNotConfigured = 0x00000001,
    ClusterStateNotRunning    = 0x00000003,
    ClusterStateRunning       = 0x00000013,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_state_change_reason
alias CLUSTER_RESOURCE_STATE_CHANGE_REASON = int;
enum : int
{
    eResourceStateChangeReasonUnknown    = 0x00000000,
    eResourceStateChangeReasonMove       = 0x00000001,
    eResourceStateChangeReasonFailover   = 0x00000002,
    eResourceStateChangeReasonFailedMove = 0x00000003,
    eResourceStateChangeReasonShutdown   = 0x00000004,
    eResourceStateChangeReasonRundown    = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_reg_command
alias CLUSTER_REG_COMMAND = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusgroup_type
alias CLUSGROUP_TYPE = int;
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
    ClusGroupTypeCoreSddc                 = 0x0000007b,
    ClusGroupTypeUserManager              = 0x0000007c,
    ClusGroupTypeKeyValueStoreManager     = 0x0000007d,
    ClusGroupTypeHcsVirtualMachine        = 0x0000007e,
    ClusGroupTypeMetaVirtualMachine       = 0x0000007f,
    ClusGroupTypeUnknown                  = 0x0000270f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_mgmt_point_type
alias CLUSTER_MGMT_POINT_TYPE = int;
enum : int
{
    CLUSTER_MGMT_POINT_TYPE_NONE     = 0x00000000,
    CLUSTER_MGMT_POINT_TYPE_CNO      = 0x00000001,
    CLUSTER_MGMT_POINT_TYPE_DNS_ONLY = 0x00000002,
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clus_group_start_setting
alias CLUS_GROUP_START_SETTING = int;
enum : int
{
    CLUS_GROUP_START_ALWAYS  = 0x00000000,
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

alias CLUS_ADAPTER_EXCLUSION_TYPE = int;
enum : int
{
    CLUS_ADAPTER_EXCLUSION_TYPE_IPPREFIX     = 0x00000000,
    CLUS_ADAPTER_EXCLUSION_TYPE_DESCRIPTION  = 0x00000001,
    CLUS_ADAPTER_EXCLUSION_TYPE_FRIENDLYNAME = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_quorum_value
alias CLUSTER_QUORUM_VALUE = int;
enum : int
{
    CLUSTER_QUORUM_MAINTAINED = 0x00000000,
    CLUSTER_QUORUM_LOST       = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_upgrade_phase
alias CLUSTER_UPGRADE_PHASE = int;
enum : int
{
    ClusterUpgradePhaseInitialize              = 0x00000001,
    ClusterUpgradePhaseValidatingUpgrade       = 0x00000002,
    ClusterUpgradePhaseUpgradingComponents     = 0x00000003,
    ClusterUpgradePhaseInstallingNewComponents = 0x00000004,
    ClusterUpgradePhaseUpgradeComplete         = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change
alias CLUSTER_CHANGE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_notifications_version
alias CLUSTER_NOTIFICATIONS_VERSION = int;
enum : int
{
    CLUSTER_NOTIFICATIONS_V1 = 0x00000001,
    CLUSTER_NOTIFICATIONS_V2 = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_cluster_v2
alias CLUSTER_CHANGE_CLUSTER_V2 = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_group_v2
alias CLUSTER_CHANGE_GROUP_V2 = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_groupset_v2
alias CLUSTER_CHANGE_GROUPSET_V2 = int;
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

alias CLUSTER_CHANGE_RESOURCE_V2 = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_resource_type_v2
alias CLUSTER_CHANGE_RESOURCE_TYPE_V2 = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_netinterface_v2
alias CLUSTER_CHANGE_NETINTERFACE_V2 = int;
enum : int
{
    CLUSTER_CHANGE_NETINTERFACE_DELETED_V2          = 0x00000001,
    CLUSTER_CHANGE_NETINTERFACE_COMMON_PROPERTY_V2  = 0x00000002,
    CLUSTER_CHANGE_NETINTERFACE_PRIVATE_PROPERTY_V2 = 0x00000004,
    CLUSTER_CHANGE_NETINTERFACE_STATE_V2            = 0x00000008,
    CLUSTER_CHANGE_NETINTERFACE_HANDLE_CLOSE_V2     = 0x00000010,
    CLUSTER_CHANGE_NETINTERFACE_ALL_V2              = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_network_v2
alias CLUSTER_CHANGE_NETWORK_V2 = int;
enum : int
{
    CLUSTER_CHANGE_NETWORK_DELETED_V2          = 0x00000001,
    CLUSTER_CHANGE_NETWORK_COMMON_PROPERTY_V2  = 0x00000002,
    CLUSTER_CHANGE_NETWORK_PRIVATE_PROPERTY_V2 = 0x00000004,
    CLUSTER_CHANGE_NETWORK_STATE_V2            = 0x00000008,
    CLUSTER_CHANGE_NETWORK_HANDLE_CLOSE_V2     = 0x00000010,
    CLUSTER_CHANGE_NETWORK_ALL_V2              = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_node_v2
alias CLUSTER_CHANGE_NODE_V2 = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_registry_v2
alias CLUSTER_CHANGE_REGISTRY_V2 = int;
enum : int
{
    CLUSTER_CHANGE_REGISTRY_ATTRIBUTES_V2   = 0x00000001,
    CLUSTER_CHANGE_REGISTRY_NAME_V2         = 0x00000002,
    CLUSTER_CHANGE_REGISTRY_SUBTREE_V2      = 0x00000004,
    CLUSTER_CHANGE_REGISTRY_VALUE_V2        = 0x00000008,
    CLUSTER_CHANGE_REGISTRY_HANDLE_CLOSE_V2 = 0x00000010,
    CLUSTER_CHANGE_REGISTRY_ALL_V2          = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_quorum_v2
alias CLUSTER_CHANGE_QUORUM_V2 = int;
enum : int
{
    CLUSTER_CHANGE_QUORUM_STATE_V2 = 0x00000001,
    CLUSTER_CHANGE_QUORUM_ALL_V2   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_shared_volume_v2
alias CLUSTER_CHANGE_SHARED_VOLUME_V2 = int;
enum : int
{
    CLUSTER_CHANGE_SHARED_VOLUME_STATE_V2   = 0x00000001,
    CLUSTER_CHANGE_SHARED_VOLUME_ADDED_V2   = 0x00000002,
    CLUSTER_CHANGE_SHARED_VOLUME_REMOVED_V2 = 0x00000004,
    CLUSTER_CHANGE_SHARED_VOLUME_ALL_V2     = 0x00000007,
}

alias CLUSTER_CHANGE_SPACEPORT_V2 = int;
enum : int
{
    CLUSTER_CHANGE_SPACEPORT_CUSTOM_PNP_V2 = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_change_node_upgrade_phase_v2
alias CLUSTER_CHANGE_NODE_UPGRADE_PHASE_V2 = int;
enum : int
{
    CLUSTER_CHANGE_UPGRADE_NODE_PREPARE    = 0x00000001,
    CLUSTER_CHANGE_UPGRADE_NODE_COMMIT     = 0x00000002,
    CLUSTER_CHANGE_UPGRADE_NODE_POSTCOMMIT = 0x00000004,
    CLUSTER_CHANGE_UPGRADE_ALL             = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_object_type
alias CLUSTER_OBJECT_TYPE = int;
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
    CLUSTER_OBJECT_TYPE_FAULTDOMAIN       = 0x00000011,
}

alias CLUSTERSET_OBJECT_TYPE = int;
enum : int
{
    CLUSTERSET_OBJECT_TYPE_NONE     = 0x00000000,
    CLUSTERSET_OBJECT_TYPE_MEMBER   = 0x00000001,
    CLUSTERSET_OBJECT_TYPE_WORKLOAD = 0x00000002,
    CLUSTERSET_OBJECT_TYPE_DATABASE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_enum
alias CLUSTER_ENUM = int;
enum : int
{
    CLUSTER_ENUM_NODE                   = 0x00000001,
    CLUSTER_ENUM_RESTYPE                = 0x00000002,
    CLUSTER_ENUM_RESOURCE               = 0x00000004,
    CLUSTER_ENUM_GROUP                  = 0x00000008,
    CLUSTER_ENUM_NETWORK                = 0x00000010,
    CLUSTER_ENUM_NETINTERFACE           = 0x00000020,
    CLUSTER_ENUM_CAPACITY_NODE          = 0x10000000,
    CLUSTER_ENUM_SHARED_VOLUME_GROUP    = 0x20000000,
    CLUSTER_ENUM_SHARED_VOLUME_RESOURCE = 0x40000000,
    CLUSTER_ENUM_INTERNAL_NETWORK       = 0x80000000,
    CLUSTER_ENUM_ALL                    = 0x0000003f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_node_enum
alias CLUSTER_NODE_ENUM = int;
enum : int
{
    CLUSTER_NODE_ENUM_NETINTERFACES    = 0x00000001,
    CLUSTER_NODE_ENUM_GROUPS           = 0x00000002,
    CLUSTER_NODE_ENUM_PREFERRED_GROUPS = 0x00000004,
    CLUSTER_NODE_ENUM_ALL              = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_node_state
alias CLUSTER_NODE_STATE = int;
enum : int
{
    ClusterNodeStateUnknown = 0xffffffff,
    ClusterNodeUp           = 0x00000000,
    ClusterNodeDown         = 0x00000001,
    ClusterNodePaused       = 0x00000002,
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_node_drain_status
alias CLUSTER_NODE_DRAIN_STATUS = int;
enum : int
{
    NodeDrainStatusNotInitiated = 0x00000000,
    NodeDrainStatusInProgress   = 0x00000001,
    NodeDrainStatusCompleted    = 0x00000002,
    NodeDrainStatusFailed       = 0x00000003,
    ClusterNodeDrainStatusCount = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_node_status
alias CLUSTER_NODE_STATUS = int;
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

alias CLUSTER_NODE_FAILBACK_STATUS = int;
enum : int
{
    NodeFailbackStatusNotInitiated = 0x00000000,
    NodeFailbackStatusInProgress   = 0x00000001,
    NodeFailbackStatusCompleted    = 0x00000002,
    NodeFailbackStatusFailed       = 0x00000003,
    ClusterNodeFailbackStatusCount = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_group_enum
alias CLUSTER_GROUP_ENUM = int;
enum : int
{
    CLUSTER_GROUP_ENUM_CONTAINS = 0x00000001,
    CLUSTER_GROUP_ENUM_NODES    = 0x00000002,
    CLUSTER_GROUP_ENUM_ALL      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_group_state
alias CLUSTER_GROUP_STATE = int;
enum : int
{
    ClusterGroupStateUnknown  = 0xffffffff,
    ClusterGroupOnline        = 0x00000000,
    ClusterGroupOffline       = 0x00000001,
    ClusterGroupFailed        = 0x00000002,
    ClusterGroupPartialOnline = 0x00000003,
    ClusterGroupPending       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_group_priority
alias CLUSTER_GROUP_PRIORITY = int;
enum : int
{
    PriorityDisabled = 0x00000000,
    PriorityLow      = 0x000003e8,
    PriorityMedium   = 0x000007d0,
    PriorityHigh     = 0x00000bb8,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_group_autofailback_type
alias CLUSTER_GROUP_AUTOFAILBACK_TYPE = int;
enum : int
{
    ClusterGroupPreventFailback   = 0x00000000,
    ClusterGroupAllowFailback     = 0x00000001,
    ClusterGroupFailbackTypeCount = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_node_resume_failback_type
alias CLUSTER_NODE_RESUME_FAILBACK_TYPE = int;
enum : int
{
    DoNotFailbackGroups                = 0x00000000,
    FailbackGroupsImmediately          = 0x00000001,
    FailbackGroupsPerPolicy            = 0x00000002,
    ClusterNodeResumeFailbackTypeCount = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_state
alias CLUSTER_RESOURCE_STATE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_restart_action
alias CLUSTER_RESOURCE_RESTART_ACTION = int;
enum : int
{
    ClusterResourceDontRestart        = 0x00000000,
    ClusterResourceRestartNoNotify    = 0x00000001,
    ClusterResourceRestartNotify      = 0x00000002,
    ClusterResourceRestartActionCount = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_embedded_failure_action
alias CLUSTER_RESOURCE_EMBEDDED_FAILURE_ACTION = int;
enum : int
{
    ClusterResourceEmbeddedFailureActionNone    = 0x00000000,
    ClusterResourceEmbeddedFailureActionLogOnly = 0x00000001,
    ClusterResourceEmbeddedFailureActionRecover = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_create_flags
alias CLUSTER_RESOURCE_CREATE_FLAGS = int;
enum : int
{
    CLUSTER_RESOURCE_DEFAULT_MONITOR  = 0x00000000,
    CLUSTER_RESOURCE_SEPARATE_MONITOR = 0x00000001,
    CLUSTER_RESOURCE_VALID_FLAGS      = 0x00000001,
}

alias CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE = int;
enum : int
{
    ClusterSharedVolumeSnapshotStateUnknown = 0x00000000,
    ClusterSharedVolumePrepareForHWSnapshot = 0x00000001,
    ClusterSharedVolumeHWSnapshotCompleted  = 0x00000002,
    ClusterSharedVolumePrepareForFreeze     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_property_type
alias CLUSTER_PROPERTY_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_property_format
alias CLUSTER_PROPERTY_FORMAT = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_property_syntax
alias CLUSTER_PROPERTY_SYNTAX = uint;
enum : uint
{
    CLUSPROP_SYNTAX_ENDMARK                        = 0x00000000U,
    CLUSPROP_SYNTAX_NAME                           = 0x00040003U,
    CLUSPROP_SYNTAX_RESCLASS                       = 0x00020002U,
    CLUSPROP_SYNTAX_LIST_VALUE_SZ                  = 0x00010003U,
    CLUSPROP_SYNTAX_LIST_VALUE_EXPAND_SZ           = 0x00010004U,
    CLUSPROP_SYNTAX_LIST_VALUE_DWORD               = 0x00010002U,
    CLUSPROP_SYNTAX_LIST_VALUE_BINARY              = 0x00010001U,
    CLUSPROP_SYNTAX_LIST_VALUE_MULTI_SZ            = 0x00010005U,
    CLUSPROP_SYNTAX_LIST_VALUE_LONG                = 0x00010007U,
    CLUSPROP_SYNTAX_LIST_VALUE_EXPANDED_SZ         = 0x00010008U,
    CLUSPROP_SYNTAX_LIST_VALUE_SECURITY_DESCRIPTOR = 0x00010009U,
    CLUSPROP_SYNTAX_LIST_VALUE_LARGE_INTEGER       = 0x0001000aU,
    CLUSPROP_SYNTAX_LIST_VALUE_ULARGE_INTEGER      = 0x00010006U,
    CLUSPROP_SYNTAX_LIST_VALUE_WORD                = 0x0001000bU,
    CLUSPROP_SYNTAX_LIST_VALUE_PROPERTY_LIST       = 0x0001000eU,
    CLUSPROP_SYNTAX_LIST_VALUE_FILETIME            = 0x0001000cU,
    CLUSPROP_SYNTAX_DISK_SIGNATURE                 = 0x00050002U,
    CLUSPROP_SYNTAX_SCSI_ADDRESS                   = 0x00060002U,
    CLUSPROP_SYNTAX_DISK_NUMBER                    = 0x00070002U,
    CLUSPROP_SYNTAX_PARTITION_INFO                 = 0x00080001U,
    CLUSPROP_SYNTAX_FTSET_INFO                     = 0x00090001U,
    CLUSPROP_SYNTAX_DISK_SERIALNUMBER              = 0x000a0003U,
    CLUSPROP_SYNTAX_DISK_GUID                      = 0x000b0003U,
    CLUSPROP_SYNTAX_DISK_SIZE                      = 0x000c0006U,
    CLUSPROP_SYNTAX_PARTITION_INFO_EX              = 0x000d0001U,
    CLUSPROP_SYNTAX_PARTITION_INFO_EX2             = 0x000e0001U,
    CLUSPROP_SYNTAX_STORAGE_DEVICE_ID_DESCRIPTOR   = 0x000f0001U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_control_object
alias CLUSTER_CONTROL_OBJECT = int;
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

alias CLCTL_CODES = int;
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
    CLCTL_CHECK_VOTER_EVICT_WITNESS                                 = 0x0000006d,
    CLCTL_CHECK_VOTER_DOWN_WITNESS                                  = 0x00000071,
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
    CLCTL_GET_NODE_NETWORK_CONNECTIVITY                             = 0x0000031d,
    CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX2_INT                       = 0x00001fe1,
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS          = 0x000020e1,
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN                       = 0x004020e6,
    CLCTL_RESOURCE_PREPARE_UPGRADE                                  = 0x004020ea,
    CLCTL_RESOURCE_UPGRADE_COMPLETED                                = 0x004020ee,
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 0x000020f1,
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY                         = 0x004020f6,
    CLCTL_REPLICATION_ADD_REPLICATION_GROUP                         = 0x00002142,
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
    CLCTL_GET_NODES_IN_FD                                           = 0x00002de1,
    CLCTL_FORCE_DB_FLUSH                                            = 0x00402de6,
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_resource_codes
alias CLUSCTL_RESOURCE_CODES = int;
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
    CLUSCTL_RESOURCE_GET_NODES_IN_FD                           = 0x01002de1,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_resource_type_codes
alias CLUSCTL_RESOURCE_TYPE_CODES = int;
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
    CLUSCTL_RESOURCE_TYPE_REPLICATION_ADD_REPLICATION_GROUP           = 0x02002142,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS          = 0x020020e1,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 0x020020f1,
    CLUSCTL_RESOURCE_TYPE_PREPARE_UPGRADE                             = 0x024020ea,
    CLUSCTL_RESOURCE_TYPE_UPGRADE_COMPLETED                           = 0x024020ee,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_MONITOR_SHUTTING_DOWN                = 0x02100081,
    CLUSCTL_RESOURCE_TYPE_CHECK_DRAIN_VETO                            = 0x0210212d,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_DRAIN_COMPLETE                       = 0x02102131,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_group_codes
alias CLUSCTL_GROUP_CODES = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_node_codes
alias CLUSCTL_NODE_CODES = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_network_codes
alias CLUSCTL_NETWORK_CODES = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_netinterface_codes
alias CLUSCTL_NETINTERFACE_CODES = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_cluster_codes
alias CLUSCTL_CLUSTER_CODES = int;
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
    CLUSCTL_CLUSTER_GET_NODES_IN_FD                              = 0x07002de1,
    CLUSCTL_CLUSTER_FORCE_FLUSH_DB                               = 0x07402de6,
    CLUSCTL_CLUSTER_GET_CLMUSR_TOKEN                             = 0x0700016d,
    CLUSCTL_CLUSTER_CHECK_VOTER_EVICT_WITNESS                    = 0x0700006d,
    CLUSCTL_CLUSTER_CHECK_VOTER_DOWN_WITNESS                     = 0x07000071,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusctl_groupset_codes
alias CLUSCTL_GROUPSET_CODES = int;
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

alias CLUSCTL_AFFINITYRULE_CODES = int;
enum : int
{
    CLUSCTL_AFFINITYRULE_GET_COMMON_PROPERTIES    = 0x09000059,
    CLUSCTL_AFFINITYRULE_GET_RO_COMMON_PROPERTIES = 0x09000055,
    CLUSCTL_AFFINITYRULE_SET_COMMON_PROPERTIES    = 0x0940005e,
    CLUSCTL_AFFINITYRULE_GET_ID                   = 0x09000039,
    CLUSCTL_AFFINITYRULE_GET_GROUPNAMES           = 0x09002d71,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_class
alias CLUSTER_RESOURCE_CLASS = int;
enum : int
{
    CLUS_RESCLASS_UNKNOWN = 0x00000000,
    CLUS_RESCLASS_STORAGE = 0x00000001,
    CLUS_RESCLASS_NETWORK = 0x00000002,
    CLUS_RESCLASS_USER    = 0x00008000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clus_ressubclass
alias CLUS_RESSUBCLASS = int;
enum : int
{
    CLUS_RESSUBCLASS_SHARED = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clus_ressubclass_storage
alias CLUS_RESSUBCLASS_STORAGE = int;
enum : int
{
    CLUS_RESSUBCLASS_STORAGE_SHARED_BUS  = 0x80000000,
    CLUS_RESSUBCLASS_STORAGE_DISK        = 0x40000000,
    CLUS_RESSUBCLASS_STORAGE_REPLICATION = 0x10000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clus_ressubclass_network
alias CLUS_RESSUBCLASS_NETWORK = int;
enum : int
{
    CLUS_RESSUBCLASS_NETWORK_INTERNET_PROTOCOL = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clus_characteristics
alias CLUS_CHARACTERISTICS = int;
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
    CLUS_CHAR_DRAIN_LOCAL_OFFLINE            = 0x00080000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clus_flags
alias CLUS_FLAGS = int;
enum : int
{
    CLUS_FLAG_CORE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-clusprop_piflags
alias CLUSPROP_PIFLAGS = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_csv_volume_fault_state
alias CLUSTER_CSV_VOLUME_FAULT_STATE = int;
enum : int
{
    VolumeStateNoFaults      = 0x00000000,
    VolumeStateNoDirectIO    = 0x00000001,
    VolumeStateNoAccess      = 0x00000002,
    VolumeStateInMaintenance = 0x00000004,
    VolumeStateDismounted    = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_shared_volume_backup_state
alias CLUSTER_SHARED_VOLUME_BACKUP_STATE = int;
enum : int
{
    VolumeBackupNone       = 0x00000000,
    VolumeBackupInProgress = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_shared_volume_state
alias CLUSTER_SHARED_VOLUME_STATE = int;
enum : int
{
    SharedVolumeStateUnavailable            = 0x00000000,
    SharedVolumeStatePaused                 = 0x00000001,
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-maintenance_mode_type_enum
alias MAINTENANCE_MODE_TYPE_ENUM = int;
enum : int
{
    MaintenanceModeTypeDisableIsAliveCheck = 0x00000001,
    MaintenanceModeTypeOfflineResource     = 0x00000002,
    MaintenanceModeTypeUnclusterResource   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-clusprop_ipaddr_enablenetbios
alias CLUSPROP_IPADDR_ENABLENETBIOS = int;
enum : int
{
    CLUSPROP_IPADDR_ENABLENETBIOS_DISABLED  = 0x00000000,
    CLUSPROP_IPADDR_ENABLENETBIOS_ENABLED   = 0x00000001,
    CLUSPROP_IPADDR_ENABLENETBIOS_TRACK_NIC = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-fileshare_change_enum
alias FILESHARE_CHANGE_ENUM = int;
enum : int
{
    FILESHARE_CHANGE_NONE   = 0x00000000,
    FILESHARE_CHANGE_ADD    = 0x00000001,
    FILESHARE_CHANGE_DEL    = 0x00000002,
    FILESHARE_CHANGE_MODIFY = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_enum
alias CLUSTER_RESOURCE_ENUM = int;
enum : int
{
    CLUSTER_RESOURCE_ENUM_DEPENDS  = 0x00000001,
    CLUSTER_RESOURCE_ENUM_PROVIDES = 0x00000002,
    CLUSTER_RESOURCE_ENUM_NODES    = 0x00000004,
    CLUSTER_RESOURCE_ENUM_ALL      = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_resource_type_enum
alias CLUSTER_RESOURCE_TYPE_ENUM = int;
enum : int
{
    CLUSTER_RESOURCE_TYPE_ENUM_NODES     = 0x00000001,
    CLUSTER_RESOURCE_TYPE_ENUM_RESOURCES = 0x00000002,
    CLUSTER_RESOURCE_TYPE_ENUM_ALL       = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_network_enum
alias CLUSTER_NETWORK_ENUM = int;
enum : int
{
    CLUSTER_NETWORK_ENUM_NETINTERFACES = 0x00000001,
    CLUSTER_NETWORK_ENUM_ALL           = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_network_state
alias CLUSTER_NETWORK_STATE = int;
enum : int
{
    ClusterNetworkStateUnknown = 0xffffffff,
    ClusterNetworkUnavailable  = 0x00000000,
    ClusterNetworkDown         = 0x00000001,
    ClusterNetworkPartitioned  = 0x00000002,
    ClusterNetworkUp           = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_network_role
alias CLUSTER_NETWORK_ROLE = int;
enum : int
{
    ClusterNetworkRoleNone              = 0x00000000,
    ClusterNetworkRoleInternalUse       = 0x00000001,
    ClusterNetworkRoleClientAccess      = 0x00000002,
    ClusterNetworkRoleInternalAndClient = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ne-msclus-cluster_netinterface_state
alias CLUSTER_NETINTERFACE_STATE = int;
enum : int
{
    ClusterNetInterfaceStateUnknown = 0xffffffff,
    ClusterNetInterfaceUnavailable  = 0x00000000,
    ClusterNetInterfaceFailed       = 0x00000001,
    ClusterNetInterfaceUnreachable  = 0x00000002,
    ClusterNetInterfaceUp           = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_setup_phase
alias CLUSTER_SETUP_PHASE = int;
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
    ClusterSetupPhaseApplyNetworkATCIntents     = 0x0000012f,
    ClusterSetupPhaseMoveGroup                  = 0x00000190,
    ClusterSetupPhaseDeleteGroup                = 0x00000191,
    ClusterSetupPhaseCleanupCOs                 = 0x00000192,
    ClusterSetupPhaseOfflineGroup               = 0x00000193,
    ClusterSetupPhaseEvictNode                  = 0x00000194,
    ClusterSetupPhaseCleanupNode                = 0x00000195,
    ClusterSetupPhaseCoreGroupCleanup           = 0x00000196,
    ClusterSetupPhaseRepairCNOAccount           = 0x000001f4,
    ClusterSetupPhaseRepairDNSPermissions       = 0x000001f5,
    ClusterSetupPhaseFailureCleanup             = 0x000003e7,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_setup_phase_type
alias CLUSTER_SETUP_PHASE_TYPE = int;
enum : int
{
    ClusterSetupPhaseStart    = 0x00000001,
    ClusterSetupPhaseContinue = 0x00000002,
    ClusterSetupPhaseEnd      = 0x00000003,
    ClusterSetupPhaseReport   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-cluster_setup_phase_severity
alias CLUSTER_SETUP_PHASE_SEVERITY = int;
enum : int
{
    ClusterSetupPhaseInformational = 0x00000001,
    ClusterSetupPhaseWarning       = 0x00000002,
    ClusterSetupPhaseFatal         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-placement_options
alias PLACEMENT_OPTIONS = int;
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

alias GRP_PLACEMENT_OPTIONS = int;
enum : int
{
    GRP_PLACEMENT_OPTIONS_MIN_VALUE             = 0x00000000,
    GRP_PLACEMENT_OPTIONS_DEFAULT               = 0x00000000,
    GRP_PLACEMENT_OPTIONS_DISABLE_AUTOBALANCING = 0x00000001,
    GRP_PLACEMENT_OPTIONS_ALL                   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-sr_replicated_disk_type
alias SR_REPLICATED_DISK_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ne-clusapi-sr_disk_replication_eligible
alias SR_DISK_REPLICATION_ELIGIBLE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-vm_resdll_context
alias VM_RESDLL_CONTEXT = int;
enum : int
{
    VmResdllContextTurnOff       = 0x00000000,
    VmResdllContextSave          = 0x00000001,
    VmResdllContextShutdown      = 0x00000002,
    VmResdllContextShutdownForce = 0x00000003,
    VmResdllContextLiveMigration = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-resdll_context_operation_type
alias RESDLL_CONTEXT_OPERATION_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-log_level
alias LOG_LEVEL = int;
enum : int
{
    LOG_INFORMATION = 0x00000000,
    LOG_WARNING     = 0x00000001,
    LOG_ERROR       = 0x00000002,
    LOG_SEVERE      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-resource_exit_state
alias RESOURCE_EXIT_STATE = int;
enum : int
{
    ResourceExitStateContinue  = 0x00000000,
    ResourceExitStateTerminate = 0x00000001,
    ResourceExitStateMax       = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-failure_type
alias FAILURE_TYPE = int;
enum : int
{
    FAILURE_TYPE_GENERAL      = 0x00000000,
    FAILURE_TYPE_EMBEDDED     = 0x00000001,
    FAILURE_TYPE_NETWORK_LOSS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-cluster_resource_application_state
alias CLUSTER_RESOURCE_APPLICATION_STATE = int;
enum : int
{
    ClusterResourceApplicationStateUnknown = 0x00000001,
    ClusterResourceApplicationOSHeartBeat  = 0x00000002,
    ClusterResourceApplicationReady        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-resource_monitor_state
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-cluster_role
alias CLUSTER_ROLE = int;
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
    ClusterRoleKeyValueStore               = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ne-resapi-cluster_role_state
alias CLUSTER_ROLE_STATE = int;
enum : int
{
    ClusterRoleUnknown     = 0xffffffff,
    ClusterRoleClustered   = 0x00000000,
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

// Constants


enum : uint
{
    CLUSTER_VERSION_FLAG_MIXED_MODE = 0x00000001U,
    CLUSTER_VERSION_UNKNOWN         = 0xffffffffU,
}

enum uint NT4_MAJOR_VERSION = 0x00000001U;
enum uint NT4SP4_MAJOR_VERSION = 0x00000002U;
enum uint NT5_MAJOR_VERSION = 0x00000003U;
enum uint NT51_MAJOR_VERSION = 0x00000004U;
enum uint NT6_MAJOR_VERSION = 0x00000005U;
enum uint NT7_MAJOR_VERSION = 0x00000006U;
enum uint NT8_MAJOR_VERSION = 0x00000007U;
enum uint NT9_MAJOR_VERSION = 0x00000008U;
enum uint NT10_MAJOR_VERSION = 0x00000009U;
enum uint NT11_MAJOR_VERSION = 0x0000000aU;
enum uint NT12_MAJOR_VERSION = 0x0000000bU;
enum uint NT13_MAJOR_VERSION = 0x0000000cU;
enum uint WS2016_TP4_UPGRADE_VERSION = 0x00000006U;
enum uint WS2016_TP5_UPGRADE_VERSION = 0x00000007U;
enum uint WS2016_RTM_UPGRADE_VERSION = 0x00000008U;
enum uint RS3_UPGRADE_VERSION = 0x00000001U;
enum uint RS4_UPGRADE_VERSION = 0x00000002U;
enum uint RS5_UPGRADE_VERSION = 0x00000003U;
enum uint NINETEEN_H1_UPGRADE_VERSION = 0x00000001U;
enum uint NINETEEN_H2_UPGRADE_VERSION = 0x00000002U;
enum uint MN_UPGRADE_VERSION = 0x00000003U;
enum uint FE_UPGRADE_VERSION = 0x00000004U;
enum uint FE_22H2_UPGRADE_VERSION = 0x00000005U;
enum uint CA_UPGRADE_VERSION = 0x00000001U;
enum uint NI_UPGRADE_VERSION = 0x00000002U;
enum uint CU_UPGRADE_VERSION = 0x00000003U;
enum uint ZN_UPGRADE_VERSION = 0x00000004U;
enum uint GA_UPGRADE_VERSION = 0x00000005U;
enum uint GE_UPGRADE_VERSION = 0x00000006U;
enum uint HCI_UPGRADE_BIT = 0x00008000U;
enum const(wchar)* CLUSREG_NAME_MIXED_MODE = "MixedMode";

enum : uint
{
    CLUSAPI_VERSION_SERVER2008   = 0x00000600U,
    CLUSAPI_VERSION_SERVER2008R2 = 0x00000700U,
    CLUSAPI_VERSION_WINDOWS8     = 0x00000701U,
    CLUSAPI_VERSION_WINDOWSBLUE  = 0x00000702U,
    CLUSAPI_VERSION_WINTHRESHOLD = 0x00000703U,
    CLUSAPI_VERSION_RS3          = 0x00000a00U,
    CLUSAPI_VERSION_NI           = 0x00000a0cU,
    CLUSAPI_VERSION_CU           = 0x00000c03U,
    CLUSAPI_VERSION_ZN           = 0x00000c04U,
    CLUSAPI_VERSION_GA           = 0x00000c05U,
    CLUSAPI_VERSION              = 0x00000c05U,
}

enum : uint
{
    CREATE_CLUSTER_VERSION            = 0x00000600U,
    CREATE_CLUSTER_MAJOR_VERSION_MASK = 0xffffff00U,
}

enum uint MAX_CLUSTERNAME_LENGTH = 0x0000003fU;

enum : uint
{
    CLUSTER_INSTALLED  = 0x00000001U,
    CLUSTER_CONFIGURED = 0x00000002U,
    CLUSTER_RUNNING    = 0x00000010U,
}

enum uint CLUS_HYBRID_QUORUM = 0x00000400U;
enum uint CLUS_NODE_MAJORITY_QUORUM = 0x00000000U;
enum uint CLUSCTL_RESOURCE_STATE_CHANGE_REASON_VERSION_1 = 0x00000001U;

enum : uint
{
    CLUSREG_DATABASE_SYNC_WRITE_TO_ALL_NODES = 0x00000001U,
    CLUSREG_DATABASE_ISOLATE_READ            = 0x00000002U,
}

enum : uint
{
    CLUSTER_ENUM_ITEM_VERSION_1 = 0x00000001U,
    CLUSTER_ENUM_ITEM_VERSION   = 0x00000001U,
}

enum : uint
{
    CLUSTER_CREATE_GROUP_INFO_VERSION_1 = 0x00000001U,
    CLUSTER_CREATE_GROUP_INFO_VERSION   = 0x00000001U,
}

enum : uint
{
    GROUPSET_READY_SETTING_DELAY             = 0x00000001U,
    GROUPSET_READY_SETTING_ONLINE            = 0x00000002U,
    GROUPSET_READY_SETTING_OS_HEARTBEAT      = 0x00000003U,
    GROUPSET_READY_SETTING_APPLICATION_READY = 0x00000004U,
}

enum : uint
{
    CLUS_GRP_MOVE_ALLOWED = 0x00000000U,
    CLUS_GRP_MOVE_LOCKED  = 0x00000001U,
}

enum : int
{
    CLUSAPI_READ_ACCESS   = 0x00000001,
    CLUSAPI_CHANGE_ACCESS = 0x00000002,
}

enum int CLUSAPI_NO_ACCESS = 0x00000004;

enum : uint
{
    CLUSTER_SET_ACCESS_TYPE_ALLOWED = 0x00000000U,
    CLUSTER_SET_ACCESS_TYPE_DENIED  = 0x00000001U,
}

enum uint CLUSTER_DELETE_ACCESS_CONTROL_ENTRY = 0x00000002U;

enum : ulong
{
    CLUSGROUPSET_STATUS_GROUPS_PENDING    = 0x0000000000000001UL,
    CLUSGROUPSET_STATUS_GROUPS_ONLINE     = 0x0000000000000002UL,
    CLUSGROUPSET_STATUS_OS_HEARTBEAT      = 0x0000000000000004UL,
    CLUSGROUPSET_STATUS_APPLICATION_READY = 0x0000000000000008UL,
}

enum uint CLUSTER_AVAILABILITY_SET_CONFIG_V1 = 0x00000001U;

enum : uint
{
    CLUSTER_GROUP_ENUM_ITEM_VERSION_1 = 0x00000001U,
    CLUSTER_GROUP_ENUM_ITEM_VERSION   = 0x00000001U,
}

enum : uint
{
    CLUSTER_RESOURCE_ENUM_ITEM_VERSION_1 = 0x00000001U,
    CLUSTER_RESOURCE_ENUM_ITEM_VERSION   = 0x00000001U,
}

enum uint CLUSAPI_NODE_PAUSE_REMAIN_ON_PAUSED_NODE_ON_MOVE_ERROR = 0x00000001U;

enum : uint
{
    CLUSAPI_NODE_AVOID_PLACEMENT              = 0x00000002U,
    CLUSAPI_NODE_PAUSE_RETRY_DRAIN_ON_FAILURE = 0x00000004U,
}

enum : uint
{
    CLUSAPI_NODE_RESUME_FAILBACK_STORAGE         = 0x00000001U,
    CLUSAPI_NODE_RESUME_FAILBACK_VMS             = 0x00000002U,
    CLUSAPI_NODE_RESUME_FAILBACK_PINNED_VMS_ONLY = 0x00000004U,
    CLUSAPI_NODE_RESUME_FAILBACK_VMS_FORCEFULLY  = 0x00000008U,
}

enum : ulong
{
    CLUSGRP_STATUS_LOCKED_MODE               = 0x0000000000000001UL,
    CLUSGRP_STATUS_PREEMPTED                 = 0x0000000000000002UL,
    CLUSGRP_STATUS_WAITING_IN_QUEUE_FOR_MOVE = 0x0000000000000004UL,
}

enum ulong CLUSGRP_STATUS_PHYSICAL_RESOURCES_LACKING = 0x0000000000000008UL;

enum : ulong
{
    CLUSGRP_STATUS_WAITING_TO_START                     = 0x0000000000000010UL,
    CLUSGRP_STATUS_EMBEDDED_FAILURE                     = 0x0000000000000020UL,
    CLUSGRP_STATUS_OFFLINE_DUE_TO_ANTIAFFINITY_CONFLICT = 0x0000000000000040UL,
}

enum : ulong
{
    CLUSGRP_STATUS_NETWORK_FAILURE              = 0x0000000000000080UL,
    CLUSGRP_STATUS_UNMONITORED                  = 0x0000000000000100UL,
    CLUSGRP_STATUS_OS_HEARTBEAT                 = 0x0000000000000200UL,
    CLUSGRP_STATUS_APPLICATION_READY            = 0x0000000000000400UL,
    CLUSGRP_STATUS_OFFLINE_NOT_LOCAL_DISK_OWNER = 0x0000000000000800UL,
}

enum ulong CLUSGRP_STATUS_WAITING_FOR_DEPENDENCIES = 0x0000000000001000UL;

enum : ulong
{
    CLUSRES_STATUS_LOCKED_MODE                                  = 0x0000000000000001UL,
    CLUSRES_STATUS_EMBEDDED_FAILURE                             = 0x0000000000000002UL,
    CLUSRES_STATUS_FAILED_DUE_TO_INSUFFICIENT_CPU               = 0x0000000000000004UL,
    CLUSRES_STATUS_FAILED_DUE_TO_INSUFFICIENT_MEMORY            = 0x0000000000000008UL,
    CLUSRES_STATUS_FAILED_DUE_TO_INSUFFICIENT_GENERIC_RESOURCES = 0x0000000000000010UL,
}

enum : ulong
{
    CLUSRES_STATUS_NETWORK_FAILURE              = 0x0000000000000020UL,
    CLUSRES_STATUS_UNMONITORED                  = 0x0000000000000040UL,
    CLUSRES_STATUS_OS_HEARTBEAT                 = 0x0000000000000080UL,
    CLUSRES_STATUS_APPLICATION_READY            = 0x0000000000000100UL,
    CLUSRES_STATUS_OFFLINE_NOT_LOCAL_DISK_OWNER = 0x0000000000000200UL,
}

enum : uint
{
    CLUSAPI_GROUP_ONLINE_IGNORE_RESOURCE_STATUS = 0x00000001U,
    CLUSAPI_GROUP_ONLINE_SYNCHRONOUS            = 0x00000002U,
    CLUSAPI_GROUP_ONLINE_BEST_POSSIBLE_NODE     = 0x00000004U,
    CLUSAPI_GROUP_ONLINE_IGNORE_AFFINITY_RULE   = 0x00000008U,
}

enum uint CLUSAPI_GROUP_OFFLINE_IGNORE_RESOURCE_STATUS = 0x00000001U;

enum : uint
{
    CLUSAPI_RESOURCE_ONLINE_IGNORE_RESOURCE_STATUS          = 0x00000001U,
    CLUSAPI_RESOURCE_ONLINE_DO_NOT_UPDATE_PERSISTENT_STATE  = 0x00000002U,
    CLUSAPI_RESOURCE_ONLINE_NECESSARY_FOR_QUORUM            = 0x00000004U,
    CLUSAPI_RESOURCE_ONLINE_BEST_POSSIBLE_NODE              = 0x00000008U,
    CLUSAPI_RESOURCE_ONLINE_IGNORE_AFFINITY_RULE            = 0x00000020U,
    CLUSAPI_RESOURCE_OFFLINE_IGNORE_RESOURCE_STATUS         = 0x00000001U,
    CLUSAPI_RESOURCE_OFFLINE_FORCE_WITH_TERMINATION         = 0x00000002U,
    CLUSAPI_RESOURCE_OFFLINE_DO_NOT_UPDATE_PERSISTENT_STATE = 0x00000004U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_NONE                    = 0x00000000U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_UNKNOWN                 = 0x00000001U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_MOVING                  = 0x00000002U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_USER_REQUESTED          = 0x00000004U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_BEING_DELETED           = 0x00000008U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_BEING_RESTARTED         = 0x00000010U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_PREEMPTED               = 0x00000020U,
    CLUSAPI_RESOURCE_OFFLINE_REASON_SHUTTING_DOWN           = 0x00000040U,
}

enum : uint
{
    CLUSAPI_GROUP_MOVE_IGNORE_RESOURCE_STATUS         = 0x00000001U,
    CLUSAPI_GROUP_MOVE_RETURN_TO_SOURCE_NODE_ON_ERROR = 0x00000002U,
}

enum : uint
{
    CLUSAPI_GROUP_MOVE_QUEUE_ENABLED        = 0x00000004U,
    CLUSAPI_GROUP_MOVE_HIGH_PRIORITY_START  = 0x00000008U,
    CLUSAPI_GROUP_MOVE_FAILBACK             = 0x00000010U,
    CLUSAPI_GROUP_MOVE_IGNORE_AFFINITY_RULE = 0x00000020U,
}

enum ulong CLUSAPI_CHANGE_RESOURCE_GROUP_FORCE_MOVE_TO_CSV = 0x0000000000000001UL;
enum ulong CLUSAPI_VALID_CHANGE_RESOURCE_GROUP_FLAGS = 0x0000000000000001UL;
enum uint GROUP_FAILURE_INFO_VERSION_1 = 0x00000001U;
enum uint RESOURCE_FAILURE_INFO_VERSION_1 = 0x00000001U;

enum : uint
{
    CLUS_ACCESS_ANY   = 0x00000000U,
    CLUS_ACCESS_READ  = 0x00000001U,
    CLUS_ACCESS_WRITE = 0x00000002U,
}

enum uint CLUS_NO_MODIFY = 0x00000000U;

enum : uint
{
    CLUS_MODIFY     = 0x00000001U,
    CLUS_NOT_GLOBAL = 0x00000000U,
}

enum uint CLUS_GLOBAL = 0x00000001U;
enum uint CLUSCTL_ACCESS_SHIFT = 0x00000000U;
enum uint CLUSCTL_FUNCTION_SHIFT = 0x00000002U;
enum uint CLCTL_INTERNAL_SHIFT = 0x00000014U;
enum uint CLCTL_USER_SHIFT = 0x00000015U;
enum uint CLCTL_MODIFY_SHIFT = 0x00000016U;
enum uint CLCTL_GLOBAL_SHIFT = 0x00000017U;
enum uint CLUSCTL_OBJECT_SHIFT = 0x00000018U;
enum uint CLUSCTL_CONTROL_CODE_MASK = 0x003fffffU;

enum : uint
{
    CLUSCTL_OBJECT_MASK      = 0x000000ffU,
    CLUSCTL_ACCESS_MODE_MASK = 0x00000003U,
}

enum uint CLCTL_CLUSTER_BASE = 0x00000000U;

enum : int
{
    BitLockerEnabled   = 0x00000001,
    BitLockerDecrypted = 0x00000004,
}

enum int BitlockerEncrypted = 0x00000008;
enum int BitLockerDecrypting = 0x00000010;
enum int BitlockerEncrypting = 0x00000020;

enum : int
{
    BitLockerPaused  = 0x00000040,
    BitLockerStopped = 0x00000080,
}

enum : ulong
{
    RedirectedIOReasonUserRequest            = 0x0000000000000001UL,
    RedirectedIOReasonUnsafeFileSystemFilter = 0x0000000000000002UL,
    RedirectedIOReasonUnsafeVolumeFilter     = 0x0000000000000004UL,
    RedirectedIOReasonFileSystemTiering      = 0x0000000000000008UL,
    RedirectedIOReasonBitLockerInitializing  = 0x0000000000000010UL,
    RedirectedIOReasonReFs                   = 0x0000000000000020UL,
    RedirectedIOReasonMax                    = 0x8000000000000000UL,
}

enum : ulong
{
    VolumeRedirectedIOReasonNoDiskConnectivity       = 0x0000000000000001UL,
    VolumeRedirectedIOReasonStorageSpaceNotAttached  = 0x0000000000000002UL,
    VolumeRedirectedIOReasonVolumeReplicationEnabled = 0x0000000000000004UL,
    VolumeRedirectedIOReasonMax                      = 0x8000000000000000UL,
}

enum uint MAX_OBJECTID = 0x00000040U;
enum uint MAX_CO_PASSWORD_LENGTH = 0x00000010U;
enum uint GUID_PRESENT = 0x00000001U;
enum uint CREATEDC_PRESENT = 0x00000002U;

enum : uint
{
    MAX_CO_PASSWORD_LENGTHEX  = 0x0000007fU,
    MAX_CO_PASSWORD_STORAGEEX = 0x00000080U,
}

enum uint MAX_CREATINGDC_LENGTH = 0x00000100U;
enum uint DNS_LENGTH = 0x00000040U;
enum uint MAINTENANCE_MODE_V2_SIG = 0xabbaf00fU;
enum uint NNLEN = 0x00000050U;

enum : const(wchar)*
{
    CLUS_RESTYPE_NAME_GENAPP                = "Generic Application",
    CLUS_RESTYPE_NAME_GENSVC                = "Generic Service",
    CLUS_RESTYPE_NAME_GENSCRIPT             = "Generic Script",
    CLUS_RESTYPE_NAME_IPADDR                = "IP Address",
    CLUS_RESTYPE_NAME_NETNAME               = "Network Name",
    CLUS_RESTYPE_NAME_DNN                   = "Distributed Network Name",
    CLUS_RESTYPE_NAME_FILESHR               = "File Share",
    CLUS_RESTYPE_NAME_PRTSPLR               = "Print Spooler",
    CLUS_RESTYPE_NAME_IPV6_NATIVE           = "IPv6 Address",
    CLUS_RESTYPE_NAME_IPV6_TUNNEL           = "IPv6 Tunnel Address",
    CLUS_RESTYPE_NAME_VSSTASK               = "Volume Shadow Copy Service Task",
    CLUS_RESTYPE_NAME_WINS                  = "WINS Service",
    CLUS_RESTYPE_NAME_DHCP                  = "DHCP Service",
    CLUS_RESTYPE_NAME_MSMQ                  = "Microsoft Message Queue Server",
    CLUS_RESTYPE_NAME_NEW_MSMQ              = "MSMQ",
    CLUS_RESTYPE_NAME_MSMQ_TRIGGER          = "MSMQTriggers",
    CLUS_RESTYPE_NAME_MSDTC                 = "Distributed Transaction Coordinator",
    CLUS_RESTYPE_NAME_NFS                   = "NFS Share",
    CLUS_RESTYPE_NAME_NETWORK_FILE_SYSTEM   = "Network File System",
    CLUS_RESTYPE_NAME_ISNS                  = "Microsoft iSNS",
    CLUS_RESTYPE_NAME_HARDDISK              = "Physical Disk",
    CLUS_RESTYPE_NAME_PHYS_DISK             = "Physical Disk",
    CLUS_RESTYPE_NAME_FSWITNESS             = "File Share Witness",
    CLUS_RESTYPE_NAME_FILESERVER            = "File Server",
    CLUS_RESTYPE_NAME_SODAFILESERVER        = "Scale Out File Server",
    CLUS_RESTYPE_NAME_DFS                   = "Distributed File System",
    CLUS_RESTYPE_NAME_DFSR                  = "DFS Replicated Folder",
    CLUS_RESTYPE_NAME_VM                    = "Virtual Machine",
    CLUS_RESTYPE_NAME_VM_CONFIG             = "Virtual Machine Configuration",
    CLUS_RESTYPE_NAME_ISCSITARGET           = "iSCSI Target Server",
    CLUS_RESTYPE_NAME_STORAGE_POOL          = "Storage Pool",
    CLUS_RESTYPE_NAME_TASKSCHEDULER         = "Task Scheduler",
    CLUS_RESTYPE_NAME_VMREPLICA_BROKER      = "Virtual Machine Replication Broker",
    CLUS_RESTYPE_NAME_VMREPLICA_COORDINATOR = "Virtual Machine Replication Coordinator",
    CLUS_RESTYPE_NAME_NFS_V2                = "Network File System",
    CLUS_RESTYPE_NAME_NFS_MSNS              = "NFS Multi Server Namespace",
    CLUS_RESTYPE_NAME_CAU                   = "ClusterAwareUpdatingResource",
    CLUS_RESTYPE_NAME_NV_PROVIDER_ADDRESS   = "Provider Address",
    CLUS_RESTYPE_NAME_NAT                   = "Nat",
    CLUS_RESTYPE_NAME_STORAGE_POLICIES      = "Storage Policies",
    CLUS_RESTYPE_NAME_STORQOS               = "Storage QoS Policy Manager",
    CLUS_RESTYPE_NAME_HEALTH_SERVICE        = "Health Service",
    CLUS_RESTYPE_NAME_VM_WMI                = "Virtual Machine Cluster WMI",
    CLUS_RESTYPE_NAME_SDDC_MANAGEMENT       = "SDDC Management",
    CLUS_RESTYPE_NAME_HCSVM                 = "HCS Virtual Machine",
    CLUS_RESTYPE_NAME_VIRTUAL_IPV4          = "Disjoint IPv4 Address",
    CLUS_RESTYPE_NAME_VIRTUAL_IPV6          = "Disjoint IPv6 Address",
    CLUS_RESTYPE_NAME_CLOUD_WITNESS         = "Cloud Witness",
    CLUS_RESTYPE_NAME_STORAGE_REPLICA       = "Storage Replica",
    CLUS_RESTYPE_NAME_CROSS_CLUSTER         = "Cross Cluster Dependency Orchestrator",
    CLUS_RESTYPE_NAME_SCALEOUT_MASTER       = "Scaleout Master",
    CLUS_RESTYPE_NAME_SCALEOUT_WORKER       = "Scaleout Worker",
    CLUS_RESTYPE_NAME_CONTAINER             = "Container",
}

enum : const(wchar)*
{
    CLUS_RES_NAME_SCALEOUT_MASTER = "Scaleout Master",
    CLUS_RES_NAME_SCALEOUT_WORKER = "Scaleout Worker",
}

enum const(wchar)* CLUS_RESTYPE_NAME_KEY_VALUE_STORE = "Key Value Store";

enum : const(wchar)*
{
    CLUSREG_NAME_CLUS_DESC                 = "Description",
    CLUSREG_NAME_CLUS_SD                   = "Security Descriptor",
    CLUSREG_NAME_CLUS_DEFAULT_NETWORK_ROLE = "DefaultNetworkRole",
}

enum const(wchar)* CLUSREG_NAME_QUORUM_ARBITRATION_TIMEOUT = "QuorumArbitrationTimeMax";

enum : const(wchar)*
{
    CLUSTER_HANG_TIMEOUT_KEYNAME         = "ClusSvcHangTimeout",
    CLUSTER_HANG_RECOVERY_ACTION_KEYNAME = "HangRecoveryAction",
}

enum const(wchar)* CLUSTER_CSA_VSS_STATE = "BackupInProgress";
enum const(wchar)* CLUSTER_REQUEST_REPLY_TIMEOUT = "RequestReplyTimeout";

enum : const(wchar)*
{
    CLUSTER_WITNESS_FAILED_RESTART_INTERVAL = "WitnessRestartInterval",
    CLUSTER_WITNESS_DATABASE_WRITE_TIMEOUT  = "WitnessDatabaseWriteTimeout",
}

enum const(wchar)* CLUSTER_ADD_EVICT_DELAY = "AddEvictDelay";

enum : const(wchar)*
{
    CLUSREG_NAME_FIXQUORUM               = "FixQuorum",
    CLUSREG_NAME_PREVENTQUORUM           = "PreventQuorum",
    CLUSREG_NAME_IGNORE_PERSISTENT_STATE = "IgnorePersistentStateOnStartup",
}

enum const(wchar)* CLUSTER_SHARED_VOLUMES_ROOT = "SharedVolumesRoot";
enum const(wchar)* ENABLE_CLUSTER_SHARED_VOLUMES = "EnableSharedVolumes";
enum const(wchar)* CLUSTER_SHARED_VOLUME_VSS_WRITER_OPERATION_TIMEOUT = "SharedVolumeVssWriterOperationTimeout";
enum const(wchar)* USE_CLIENT_ACCESS_NETWORKS_FOR_CSV = "UseClientAccessNetworksForSharedVolumes";
enum const(wchar)* CLUSTER_CSV_COMPATIBLE_FILTERS = "SharedVolumeCompatibleFilters";
enum const(wchar)* CLUSTER_CSV_INCOMPATIBLE_FILTERS = "SharedVolumeIncompatibleFilters";
enum const(wchar)* CLUSTER_GROUP_WAIT_DELAY = "ClusterGroupWaitDelay";
enum const(wchar)* MINIMUM_PREEMPTOR_PRIORITY = "MinimumPreemptorPriority";
enum const(wchar)* MINIMUM_NEVER_PREEMPT_PRIORITY = "MinimumNeverPreemptPriority";
enum const(wchar)* CLUSTER_ENFORCED_ANTIAFFINITY = "ClusterEnforcedAntiaffinity";
enum const(wchar)* CLUSREG_NAME_SHUTDOWN_TIMEOUT_MINUTES = "ShutdownTimeoutInMinutes";

enum : const(wchar)*
{
    CLUSREG_NAME_CSV_MDS_SD                   = "SharedVolumeSecurityDescriptor",
    CLUSREG_NAME_FAILOVER_MOVE_MIGRATION_TYPE = "FailoverMoveMigrationType",
}

enum : const(wchar)*
{
    CLUSREG_NAME_CSV_BLOCK_CACHE      = "BlockCacheSize",
    CLUSREG_NAME_ROUTE_HISTORY_LENGTH = "RouteHistoryLength",
}

enum const(wchar)* CLUSREG_NAME_LAST_RECENT_EVENTS_RESET_TIME = "RecentEventsResetTime";

enum : const(wchar)*
{
    CLUSREG_NAME_DRAIN_ON_SHUTDOWN      = "DrainOnShutdown",
    CLUSREG_NAME_NETFT_IPSEC_ENABLED    = "NetftIPSecEnabled",
    CLUSREG_NAME_WITNESS_DYNAMIC_WEIGHT = "WitnessDynamicWeight",
}

enum const(wchar)* CLUSREG_NAME_MESSAGE_BUFFER_LENGTH = "MessageBufferLength";
enum const(wchar)* CLUSREG_NAME_DATABASE_READ_WRITE_MODE = "DatabaseReadWriteMode";

enum : const(wchar)*
{
    CLUSREG_NAME_FUNCTIONAL_LEVEL           = "ClusterFunctionalLevel",
    CLUSREG_NAME_UPGRADE_VERSION            = "ClusterUpgradeVersion",
    CLUSREG_NAME_RESILIENCY_LEVEL           = "ResiliencyLevel",
    CLUSREG_NAME_RESILIENCY_DEFAULT_SECONDS = "ResiliencyDefaultPeriod",
}

enum : const(wchar)*
{
    CLUSREG_NAME_QUARANTINE_THRESHOLD = "QuarantineThreshold",
    CLUSREG_NAME_QUARANTINE_DURATION  = "QuarantineDuration",
}

enum : const(wchar)*
{
    CLUSTER_S2D_ENABLED                = "S2DEnabled",
    CLUSTER_S2D_BUS_TYPES              = "S2DBusTypes",
    CLUSTER_S2D_CACHE_PAGE_SIZE_KBYTES = "S2DCachePageSizeKBytes",
}

enum : const(wchar)*
{
    CLUSTER_S2D_OPTIMIZATIONS        = "S2DOptimizations",
    CLUSTER_S2D_IO_LATENCY_THRESHOLD = "S2DIOLatencyThreshold",
}

enum : const(wchar)*
{
    CLUSTER_S2D_CACHE_DESIRED_STATE         = "S2DCacheDesiredState",
    CLUSTER_S2D_CACHE_METADATA_RESERVE      = "S2DCacheMetadataReserveBytes",
    CLUSTER_S2D_CACHE_FLASH_RESERVE_PERCENT = "S2DCacheFlashReservePercent",
    CLUSTER_S2D_CACHE_BEHAVIOR_FLAGS        = "S2DCacheBehavior",
}

enum : const(wchar)*
{
    CLUSTER_NAME_PREFERRED_SITE      = "PreferredSite",
    CLUSTER_NAME_AUTO_BALANCER_MODE  = "AutoBalancerMode",
    CLUSTER_NAME_AUTO_BALANCER_LEVEL = "AutoBalancerLevel",
}

enum const(wchar)* CLUSREG_NAME_GROUP_DEPENDENCY_TIMEOUT = "GroupDependencyTimeout";

enum : const(wchar)*
{
    CLUSREG_NAME_PLACEMENT_OPTIONS       = "PlacementOptions",
    CLUSREG_NAME_ENABLED_EVENT_LOGS      = "EnabledEventLogs",
    CLUSREG_NAME_MAX_PARALLEL_MIGRATIONS = "MaximumParallelMigrations",
}

enum : const(wchar)*
{
    CLUSREG_NAME_ACCELERATED_NETWORKING_ENABLED      = "AcceleratedNetworkingEnabled",
    CLUSREG_NAME_ACCELERATED_NETWORKING_NODE_RESERVE = "AcceleratedNetworkingNodeReserve",
}

enum : const(wchar)*
{
    CLUSREG_NAME_SAME_SUBNET_DELAY     = "SameSubnetDelay",
    CLUSREG_NAME_CROSS_SUBNET_DELAY    = "CrossSubnetDelay",
    CLUSREG_NAME_CROSS_SITE_DELAY      = "CrossSiteDelay",
    CLUSREG_NAME_SAME_SUBNET_THRESHOLD = "SameSubnetThreshold",
}

enum : const(wchar)*
{
    CLUSREG_NAME_CROSS_SUBNET_THRESHOLD = "CrossSubnetThreshold",
    CLUSREG_NAME_CROSS_SITE_THRESHOLD   = "CrossSiteThreshold",
}

enum const(wchar)* CLUSREG_NAME_PLUMB_ALL_CROSS_SUBNET_ROUTES = "PlumbAllCrossSubnetRoutes";

enum : const(wchar)*
{
    CLUSREG_NAME_NODE_NAME                   = "NodeName",
    CLUSREG_NAME_NODE_HIGHEST_VERSION        = "NodeHighestVersion",
    CLUSREG_NAME_NODE_LOWEST_VERSION         = "NodeLowestVersion",
    CLUSREG_NAME_NODE_DESC                   = "Description",
    CLUSREG_NAME_NODE_MAJOR_VERSION          = "MajorVersion",
    CLUSREG_NAME_NODE_MINOR_VERSION          = "MinorVersion",
    CLUSREG_NAME_NODE_BUILD_NUMBER           = "BuildNumber",
    CLUSREG_NAME_NODE_CSDVERSION             = "CSDVersion",
    CLUSREG_NAME_NODE_WEIGHT                 = "NodeWeight",
    CLUSREG_NAME_NODE_DYNAMIC_WEIGHT         = "DynamicWeight",
    CLUSREG_NAME_NODE_IS_PRIMARY             = "IsPrimary",
    CLUSREG_NAME_NODE_DRAIN_STATUS           = "NodeDrainStatus",
    CLUSREG_NAME_NODE_DRAIN_TARGET           = "NodeDrainTarget",
    CLUSREG_NAME_NODE_NEEDS_PQ               = "NeedsPreventQuorum",
    CLUSREG_NAME_NODE_FDID                   = "FaultDomainId",
    CLUSREG_NAME_NODE_STATUS_INFO            = "StatusInformation",
    CLUSREG_NAME_NODE_FAULT_DOMAIN           = "FaultDomain",
    CLUSREG_NAME_NODE_MODEL                  = "Model",
    CLUSREG_NAME_NODE_SERIALNUMBER           = "SerialNumber",
    CLUSREG_NAME_NODE_MANUFACTURER           = "Manufacturer",
    CLUSREG_NAME_NODE_UNIQUEID               = "UniqueID",
    CLUSREG_NAME_NODE_DRAIN_ERROR_CODE       = "DrainErrorCode",
    CLUSREG_NAME_NODE_FAILBACK_STATUS        = "NodeFailbackStatus",
    CLUSREG_NAME_NODE_FAILBACK_ERROR_CODE    = "FailbackErrorCode",
    CLUSREG_NAME_NODE_HYPERTHREADING_ENABLED = "HyperthreadingEnabled",
}

enum : const(wchar)*
{
    CLUSREG_NAME_GRP_NAME                       = "Name",
    CLUSREG_NAME_GRP_TYPE                       = "GroupType",
    CLUSREG_NAME_GRP_DESC                       = "Description",
    CLUSREG_NAME_GRP_PERSISTENT_STATE           = "PersistentState",
    CLUSREG_NAME_GRP_FAILBACK_TYPE              = "AutoFailbackType",
    CLUSREG_NAME_GRP_FAILBACK_WIN_START         = "FailbackWindowStart",
    CLUSREG_NAME_GRP_FAILBACK_WIN_END           = "FailbackWindowEnd",
    CLUSREG_NAME_GRP_FAILOVER_THRESHOLD         = "FailoverThreshold",
    CLUSREG_NAME_GRP_FAILOVER_PERIOD            = "FailoverPeriod",
    CLUSREG_NAME_GRP_PRIORITY                   = "Priority",
    CLUSREG_NAME_GRP_DEFAULT_OWNER              = "DefaultOwner",
    CLUSREG_NAME_GRP_STATUS_INFORMATION         = "StatusInformation",
    CLUSREG_NAME_GRP_ANTI_AFFINITY_CLASS_NAME   = "AntiAffinityClassNames",
    CLUSREG_NAME_GRP_START_DELAY                = "GroupStartDelay",
    CLUSREG_NAME_GRP_CCF_EPOCH                  = "CCFEpoch",
    CLUSREG_NAME_GRP_CCF_EPOCH_HIGH             = "CCFEpochHigh",
    CLUSREG_NAME_GRP_RESILIENCY_PERIOD          = "ResiliencyPeriod",
    CLUSREG_NAME_GRP_PREFERRED_SITE             = "PreferredSite",
    CLUSREG_NAME_GRP_COLD_START_SETTING         = "ColdStartSetting",
    CLUSREG_NAME_GRP_FAULT_DOMAIN               = "FaultDomain",
    CLUSREG_NAME_GRP_UPDATE_DOMAIN              = "UpdateDomain",
    CLUSREG_NAME_GRP_PLACEMENT_OPTIONS          = "PlacementOptions",
    CLUSREG_NAME_GRP_LOCK_MOVE                  = "LockedFromMoving",
    CLUSREG_NAME_RES_NAME                       = "Name",
    CLUSREG_NAME_RES_TYPE                       = "Type",
    CLUSREG_NAME_RES_DESC                       = "Description",
    CLUSREG_NAME_RES_SEPARATE_MONITOR           = "SeparateMonitor",
    CLUSREG_NAME_RES_PERSISTENT_STATE           = "PersistentState",
    CLUSREG_NAME_RES_LOOKS_ALIVE                = "LooksAlivePollInterval",
    CLUSREG_NAME_RES_IS_ALIVE                   = "IsAlivePollInterval",
    CLUSREG_NAME_RES_RESTART_ACTION             = "RestartAction",
    CLUSREG_NAME_RES_RESTART_THRESHOLD          = "RestartThreshold",
    CLUSREG_NAME_RES_RESTART_PERIOD             = "RestartPeriod",
    CLUSREG_NAME_RES_RESTART_DELAY              = "RestartDelay",
    CLUSREG_NAME_RES_RETRY_PERIOD_ON_FAILURE    = "RetryPeriodOnFailure",
    CLUSREG_NAME_RES_EMBEDDED_FAILURE_ACTION    = "EmbeddedFailureAction",
    CLUSREG_NAME_RES_PENDING_TIMEOUT            = "PendingTimeout",
    CLUSREG_NAME_RES_DEADLOCK_TIMEOUT           = "DeadlockTimeout",
    CLUSREG_NAME_RES_MONITOR_PID                = "MonitorProcessId",
    CLUSREG_NAME_RES_STATUS_INFORMATION         = "StatusInformation",
    CLUSREG_NAME_RES_LAST_OPERATION_STATUS_CODE = "LastOperationStatusCode",
}

enum : const(wchar)*
{
    CLUSREG_NAME_RES_DATA1                  = "ResourceSpecificData1",
    CLUSREG_NAME_RES_DATA2                  = "ResourceSpecificData2",
    CLUSREG_NAME_RES_STATUS                 = "ResourceSpecificStatus",
    CLUSREG_NAME_RESTYPE_NAME               = "Name",
    CLUSREG_NAME_RESTYPE_DESC               = "Description",
    CLUSREG_NAME_RESTYPE_DLL_NAME           = "DllName",
    CLUSREG_NAME_RESTYPE_ADMIN_EXTENSIONS   = "AdminExtensions",
    CLUSREG_NAME_RESTYPE_LOOKS_ALIVE        = "LooksAlivePollInterval",
    CLUSREG_NAME_RESTYPE_IS_ALIVE           = "IsAlivePollInterval",
    CLUSREG_NAME_RESTYPE_PENDING_TIMEOUT    = "PendingTimeout",
    CLUSREG_NAME_RESTYPE_DEADLOCK_TIMEOUT   = "DeadlockTimeout",
    CLUSREG_NAME_RESTYPE_DUMP_POLICY        = "DumpPolicy",
    CLUSREG_NAME_RESTYPE_DUMP_LOG_QUERY     = "DumpLogQuery",
    CLUSREG_NAME_RESTYPE_DUMP_SERVICES      = "DumpServices",
    CLUSREG_NAME_RESTYPE_ENABLED_EVENT_LOGS = "EnabledEventLogs",
    CLUSREG_NAME_RESTYPE_MAX_MONITORS       = "MaximumMonitors",
    CLUSREG_NAME_RESTYPE_WPR_START_AFTER    = "WprStartAfter",
    CLUSREG_NAME_RESTYPE_WPR_PROFILES       = "WprProfiles",
}

enum : const(wchar)*
{
    CLUSREG_NAME_NET_NAME                                        = "Name",
    CLUSREG_NAME_NET_IPV6_ADDRESSES                              = "IPv6Addresses",
    CLUSREG_NAME_NET_IPV6_PREFIXLENGTHS                          = "IPv6PrefixLengths",
    CLUSREG_NAME_NET_IPV4_ADDRESSES                              = "IPv4Addresses",
    CLUSREG_NAME_NET_IPV4_PREFIXLENGTHS                          = "IPv4PrefixLengths",
    CLUSREG_NAME_NET_ADDRESS                                     = "Address",
    CLUSREG_NAME_NET_ADDRESS_MASK                                = "AddressMask",
    CLUSREG_NAME_NET_DESC                                        = "Description",
    CLUSREG_NAME_NET_ROLE                                        = "Role",
    CLUSREG_NAME_NET_SPEED                                       = "LinkSpeed",
    CLUSREG_NAME_NET_RDMA_CAPABLE                                = "RdmaCapable",
    CLUSREG_NAME_NET_RSS_CAPABLE                                 = "RssCapable",
    CLUSREG_NAME_NET_METRIC                                      = "Metric",
    CLUSREG_NAME_NET_AUTOMETRIC                                  = "AutoMetric",
    CLUSREG_NAME_NETIFACE_NAME                                   = "Name",
    CLUSREG_NAME_NETIFACE_NODE                                   = "Node",
    CLUSREG_NAME_NETIFACE_NETWORK                                = "Network",
    CLUSREG_NAME_NETIFACE_ADAPTER_NAME                           = "Adapter",
    CLUSREG_NAME_NETIFACE_ADAPTER_ID                             = "AdapterId",
    CLUSREG_NAME_NETIFACE_DHCP_ENABLED                           = "DhcpEnabled",
    CLUSREG_NAME_NETIFACE_IPV6_ADDRESSES                         = "IPv6Addresses",
    CLUSREG_NAME_NETIFACE_IPV4_ADDRESSES                         = "IPv4Addresses",
    CLUSREG_NAME_NETIFACE_ADDRESS                                = "Address",
    CLUSREG_NAME_NETIFACE_DESC                                   = "Description",
    CLUSREG_NAME_GROUPSET_NAME                                   = "Name",
    CLUSREG_NAME_GROUPSET_STARTUP_SETTING                        = "StartupSetting",
    CLUSREG_NAME_GROUPSET_STARTUP_COUNT                          = "StartupCount",
    CLUSREG_NAME_GROUPSET_STARTUP_DELAY                          = "StartupDelay",
    CLUSREG_NAME_GROUPSET_IS_GLOBAL                              = "IsGlobal",
    CLUSREG_NAME_GROUPSET_STATUS_INFORMATION                     = "StatusInformation",
    CLUSREG_NAME_GROUPSET_IS_AVAILABILITY_SET                    = "IsAvailabilitySet",
    CLUSREG_NAME_GROUPSET_UPDATE_DOMAINS                         = "UpdateDomains",
    CLUSREG_NAME_GROUPSET_FAULT_DOMAINS                          = "FaultDomains",
    CLUSREG_NAME_GROUPSET_RESERVE_NODE                           = "ReserveSpareNode",
    CLUSREG_NAME_GROUPSET_AVAILABILITY_SET_INDEX_TO_NODE_MAPPING = "NodeDomainInfo",
}

enum : const(wchar)*
{
    CLUSREG_NAME_AFFINITYRULE_NAME             = "Name",
    CLUSREG_NAME_AFFINITYRULE_TYPE             = "RuleType",
    CLUSREG_NAME_AFFINITYRULE_GROUPS           = "Groups",
    CLUSREG_NAME_AFFINITYRULE_ENABLED          = "Enabled",
    CLUSREG_NAME_AFFINITYRULE_SOFTANTIAFFINITY = "SoftAntiAffinity",
}

enum : const(wchar)*
{
    CLUSREG_NAME_START_MEMORY           = "StartMemory",
    CLUSREG_NAME_VIRTUAL_NUMA_COUNT     = "VirtualNumaCount",
    CLUSREG_NAME_DDA_DEVICE_ALLOCATIONS = "DdaDeviceAllocations",
}

enum const(wchar)* CLUSREG_NAME_GPUP_DEVICE_ALLOCATIONS = "GpupDeviceAllocations";

enum : const(wchar)*
{
    CLUSREG_NAME_PHYSDISK_DISKIDTYPE          = "DiskIdType",
    CLUSREG_NAME_PHYSDISK_DISKSIGNATURE       = "DiskSignature",
    CLUSREG_NAME_PHYSDISK_DISKIDGUID          = "DiskIdGuid",
    CLUSREG_NAME_PHYSDISK_DISKRUNCHKDSK       = "DiskRunChkDsk",
    CLUSREG_NAME_PHYSDISK_DISKUNIQUEIDS       = "DiskUniqueIds",
    CLUSREG_NAME_PHYSDISK_DISKVOLUMEINFO      = "DiskVolumeInfo",
    CLUSREG_NAME_PHYSDISK_DISKARBTYPE         = "DiskArbType",
    CLUSREG_NAME_PHYSDISK_DISKARBINTERVAL     = "DiskArbInterval",
    CLUSREG_NAME_PHYSDISK_DISKPATH            = "DiskPath",
    CLUSREG_NAME_PHYSDISK_DISKRELOAD          = "DiskReload",
    CLUSREG_NAME_PHYSDISK_MAINTMODE           = "MaintenanceMode",
    CLUSREG_NAME_PHYSDISK_DISKIODELAY         = "MaxIoLatency",
    CLUSREG_NAME_PHYSDISK_MIGRATEFIXUP        = "MigrateDriveLetters",
    CLUSREG_NAME_PHYSDISK_CSVWRITETHROUGH     = "CsvEnforceWriteThrough",
    CLUSREG_NAME_PHYSDISK_CSVBLOCKCACHE       = "EnableBlockCache",
    CLUSREG_NAME_PHYSDISK_FASTONLINEARBITRATE = "FastOnlineArbitrate",
    CLUSREG_NAME_PHYSDISK_SPACEIDGUID         = "VirtualDiskId",
}

enum const(wchar)* CLUSREG_NAME_STORAGESPACE_POOLIDGUID = "PoolId";

enum : const(wchar)*
{
    CLUSREG_NAME_PHYSDISK_CSVSNAPSHOTDIFFAREASIZE = "SnapshotDiffSize",
    CLUSREG_NAME_PHYSDISK_CSVSNAPSHOTAGELIMIT     = "SnapshotAgeLimit",
    CLUSREG_NAME_PHYSDISK_DISKGUID                = "DiskGuid",
    CLUSREG_NAME_PHYSDISK_VOLSNAPACTIVATETIMEOUT  = "VolsnapActivateTimeout",
    CLUSREG_NAME_PHYSDISK_DISKRECOVERYACTION      = "DiskRecoveryAction",
}

enum : const(wchar)*
{
    CLUSREG_NAME_STORAGESPACE_NAME                 = "VirtualDiskName",
    CLUSREG_NAME_STORAGESPACE_DESCRIPTION          = "VirtualDiskDescription",
    CLUSREG_NAME_STORAGESPACE_HEALTH               = "VirtualDiskHealth",
    CLUSREG_NAME_STORAGESPACE_STATE                = "VirtualDiskState",
    CLUSREG_NAME_STORAGESPACE_PROVISIONING         = "VirtualDiskProvisioning",
    CLUSREG_NAME_STORAGESPACE_RESILIENCYTYPE       = "VirtualDiskResiliencyType",
    CLUSREG_NAME_STORAGESPACE_RESILIENCYCOLUMNS    = "VirtualDiskResiliencyColumns",
    CLUSREG_NAME_STORAGESPACE_RESILIENCYINTERLEAVE = "VirtualDiskResiliencyInterleave",
}

enum : const(wchar)*
{
    CLUSREG_NAME_GENAPP_COMMAND_LINE       = "CommandLine",
    CLUSREG_NAME_GENAPP_CURRENT_DIRECTORY  = "CurrentDirectory",
    CLUSREG_NAME_GENAPP_USE_NETWORK_NAME   = "UseNetworkName",
    CLUSREG_NAME_GENSCRIPT_SCRIPT_FILEPATH = "ScriptFilepath",
    CLUSREG_NAME_GENSVC_SERVICE_NAME       = "ServiceName",
    CLUSREG_NAME_GENSVC_STARTUP_PARAMS     = "StartupParameters",
    CLUSREG_NAME_GENSVC_USE_NETWORK_NAME   = "UseNetworkName",
}

enum : const(wchar)*
{
    CLUSREG_NAME_IPADDR_NETWORK                 = "Network",
    CLUSREG_NAME_IPADDR_ADDRESS                 = "Address",
    CLUSREG_NAME_IPADDR_SUBNET_MASK             = "SubnetMask",
    CLUSREG_NAME_IPADDR_ENABLE_NETBIOS          = "EnableNetBIOS",
    CLUSREG_NAME_IPADDR_OVERRIDE_ADDRMATCH      = "OverrideAddressMatch",
    CLUSREG_NAME_IPADDR_ENABLE_DHCP             = "EnableDhcp",
    CLUSREG_NAME_IPADDR_LEASE_OBTAINED_TIME     = "LeaseObtainedTime",
    CLUSREG_NAME_IPADDR_LEASE_TERMINATES_TIME   = "LeaseExpiresTime",
    CLUSREG_NAME_IPADDR_T1                      = "T1",
    CLUSREG_NAME_IPADDR_T2                      = "T2",
    CLUSREG_NAME_IPADDR_DHCP_SERVER             = "DhcpServer",
    CLUSREG_NAME_IPADDR_DHCP_ADDRESS            = "DhcpAddress",
    CLUSREG_NAME_IPADDR_DHCP_SUBNET_MASK        = "DhcpSubnetMask",
    CLUSREG_NAME_IPADDR_SHARED_NETNAME          = "SharedNetname",
    CLUSREG_NAME_IPADDR_PROBE_PORT              = "ProbePort",
    CLUSREG_NAME_IPADDR_PROBE_FAILURE_THRESHOLD = "ProbeFailureThreshold",
}

enum : const(wchar)*
{
    CLUSREG_NAME_IPV6_NATIVE_NETWORK       = "Network",
    CLUSREG_NAME_IPV6_NATIVE_ADDRESS       = "Address",
    CLUSREG_NAME_IPV6_NATIVE_PREFIX_LENGTH = "PrefixLength",
    CLUSREG_NAME_IPV6_TUNNEL_ADDRESS       = "Address",
    CLUSREG_NAME_IPV6_TUNNEL_TUNNELTYPE    = "TunnelType",
}

enum : const(wchar)*
{
    CLUSREG_NAME_NETNAME_NAME               = "Name",
    CLUSREG_NAME_NETNAME_CREATING_DC        = "CreatingDC",
    CLUSREG_NAME_NETNAME_OBJECT_ID          = "ObjectGUID",
    CLUSREG_NAME_NETNAME_DNS_NAME           = "DnsName",
    CLUSREG_NAME_NETNAME_REMAP_PIPE_NAMES   = "RemapPipeNames",
    CLUSREG_NAME_NETNAME_RESOURCE_DATA      = "ResourceData",
    CLUSREG_NAME_NETNAME_STATUS_NETBIOS     = "StatusNetBIOS",
    CLUSREG_NAME_NETNAME_STATUS_DNS         = "StatusDNS",
    CLUSREG_NAME_NETNAME_STATUS_KERBEROS    = "StatusKerberos",
    CLUSREG_NAME_NETNAME_VCO_CONTAINER      = "VcoContainer",
    CLUSREG_NAME_NETNAME_LAST_DNS_UPDATE    = "LastDNSUpdateTime",
    CLUSREG_NAME_NETNAME_CONTAINERGUID      = "CryptoContainerGUID",
    CLUSREG_NAME_NETNAME_HOST_TTL           = "HostRecordTTL",
    CLUSREG_NAME_NETNAME_PUBLISH_PTR        = "PublishPTRRecords",
    CLUSREG_NAME_NETNAME_REMOVEVCO_ONDELETE = "DeleteVcoOnResCleanup",
    CLUSREG_NAME_NETNAME_REGISTER_ALL_IP    = "RegisterAllProvidersIP",
}

enum const(wchar)* CLUSREG_KEYNAME_OBJECTGUIDS = "ObjectGUIDs";

enum : const(wchar)*
{
    CLUSREG_NAME_NETNAME_EXCLUDE_NETWORKS   = "ExcludeNetworks",
    CLUSREG_NAME_NETNAME_ALIASES            = "Aliases",
    CLUSREG_NAME_NETNAME_IN_USE_NETWORKS    = "InUseNetworks",
    CLUSREG_NAME_NETNAME_DNS_SUFFIX         = "DnsSuffix",
    CLUSREG_NAME_NETNAME_AD_AWARE           = "ADAware",
    CLUSREG_NAME_NETNAME_DNN_DISABLE_CLONES = "DisableClones",
}

enum : const(wchar)*
{
    CLUSREG_NAME_PRTSPOOL_DEFAULT_SPOOL_DIR = "DefaultSpoolDirectory",
    CLUSREG_NAME_PRTSPOOL_TIMEOUT           = "JobCompletionTimeout",
    CLUSREG_NAME_FILESHR_SERVER_NAME        = "ServerName",
    CLUSREG_NAME_FILESHR_SHARE_NAME         = "ShareName",
    CLUSREG_NAME_FILESHR_PATH               = "Path",
    CLUSREG_NAME_FILESHR_REMARK             = "Remark",
    CLUSREG_NAME_FILESHR_MAX_USERS          = "MaxUsers",
    CLUSREG_NAME_FILESHR_SD                 = "Security Descriptor",
    CLUSREG_NAME_FILESHR_SHARE_SUBDIRS      = "ShareSubDirs",
    CLUSREG_NAME_FILESHR_HIDE_SUBDIR_SHARES = "HideSubDirShares",
    CLUSREG_NAME_FILESHR_IS_DFS_ROOT        = "IsDfsRoot",
    CLUSREG_NAME_FILESHR_SHARE_FLAGS        = "ShareFlags",
    CLUSREG_NAME_FILESHR_CA_TIMEOUT         = "CATimeout",
    CLUSREG_NAME_FILESHR_QOS_FLOWSCOPE      = "QosFlowScope",
    CLUSREG_NAME_FILESHR_QOS_POLICYID       = "QosPolicyId",
}

enum : const(wchar)*
{
    CLUSREG_NAME_DHCP_DATABASE_PATH       = "DatabasePath",
    CLUSREG_NAME_DHCP_BACKUP_PATH         = "BackupPath",
    CLUSREG_NAME_LOG_FILE_PATH            = "LogFilePath",
    CLUSREG_NAME_WINS_DATABASE_PATH       = "DatabasePath",
    CLUSREG_NAME_WINS_BACKUP_PATH         = "BackupPath",
    CLUSREG_NAME_VSSTASK_CURRENTDIRECTORY = "CurrentDirectory",
    CLUSREG_NAME_VSSTASK_APPNAME          = "ApplicationName",
    CLUSREG_NAME_VSSTASK_APPPARAMS        = "ApplicationParams",
    CLUSREG_NAME_VSSTASK_TRIGGERARRAY     = "TriggerArray",
}

enum : const(wchar)*
{
    CLUSREG_NAME_FSWITNESS_SHARE_PATH      = "SharePath",
    CLUSREG_NAME_FSWITNESS_ARB_DELAY       = "ArbitrationDelay",
    CLUSREG_NAME_FSWITNESS_IMPERSONATE_CNO = "ImpersonateCNO",
}

enum : const(wchar)*
{
    CLUSREG_NAME_STORAGESPACE_POOLNAME              = "Name",
    CLUSREG_NAME_STORAGESPACE_POOLDESC              = "Description",
    CLUSREG_NAME_STORAGESPACE_POOLDRIVEIDS          = "DriveIds",
    CLUSREG_NAME_STORAGESPACE_POOLHEALTH            = "Health",
    CLUSREG_NAME_STORAGESPACE_POOLSTATE             = "State",
    CLUSREG_NAME_STORAGESPACE_POOLTOTALCAPACITY     = "TotalCapacity",
    CLUSREG_NAME_STORAGESPACE_POOLCONSUMEDCAPACITY  = "ConsumedCapacity",
    CLUSREG_NAME_STORAGESPACE_POOLARBITRATE         = "Arbitrate",
    CLUSREG_NAME_STORAGESPACE_POOLREEVALTIMEOUT     = "ReEvaluatePlacementTimeout",
    CLUSREG_NAME_STORAGESPACE_POOLQUORUMSHARE       = "PoolQuorumShare",
    CLUSREG_NAME_STORAGESPACE_POOLQUORUMUSERACCOUNT = "PoolQuorumUserAccount",
}

enum const(wchar)* CLUSREG_NAME_SOFS_SMBASYMMETRYMODE = "SmbAsymmetryMode";

enum : const(wchar)*
{
    CLUSREG_NAME_VIP_PREFIX_LENGTH             = "PrefixLength",
    CLUSREG_NAME_VIP_ADAPTER_NAME              = "AdapterName",
    CLUSREG_NAME_VIP_ADDRESS                   = "Address",
    CLUSREG_NAME_VIP_VSID                      = "VSID",
    CLUSREG_NAME_VIP_RDID                      = "RDID",
    CLUSREG_NAME_CLOUDWITNESS_PRIMARY_TOKEN    = "PrimaryToken",
    CLUSREG_NAME_CLOUDWITNESS_PRIMARY_KEY      = "PrimaryKey",
    CLUSREG_NAME_CLOUDWITNESS_ACCOUNT_NAME     = "AccountName",
    CLUSREG_NAME_CLOUDWITNESS_ENDPOINT_INFO    = "EndpointInfo",
    CLUSREG_NAME_CLOUDWITNESS_CONTAINER_NAME   = "ContainerName",
    CLUSREG_NAME_CLOUDWITNESS_MANAGED_IDENTITY = "IsManagedIdentity",
}

enum const(wchar)* CLOUD_WITNESS_CONTAINER_NAME = "msft-cloud-witness";

enum : const(wchar)*
{
    CLUS_NAME_RES_TYPE_SOURCE_RESID           = "SourceResourceId",
    CLUS_NAME_RES_TYPE_TARGET_RESID           = "TargetResourceId",
    CLUS_NAME_RES_TYPE_SOURCE_VOLUMES         = "SourceVolumes",
    CLUS_NAME_RES_TYPE_TARGET_VOLUMES         = "TargetVolumes",
    CLUS_NAME_RES_TYPE_DATA_RESID             = "DataResourceId",
    CLUS_NAME_RES_TYPE_LOG_RESID              = "LogResourceId",
    CLUS_NAME_RES_TYPE_LOG_VOLUME             = "LogVolume",
    CLUS_NAME_RES_TYPE_REPLICATION_GROUPID    = "ReplicationGroupId",
    CLUS_NAME_RES_TYPE_CLUSTER_GROUPID        = "ClusterGroupId",
    CLUS_NAME_RES_TYPE_REPLICATION_GROUP_TYPE = "ReplicationClusterGroupType",
    CLUS_NAME_RES_TYPE_MINIMUM_LOG_SIZE       = "MinimumLogSizeInBytes",
    CLUS_NAME_RES_TYPE_UNIT_LOG_SIZE_CHANGE   = "UnitOfLogSizeChangeInBytes",
    CLUS_NAME_RES_TYPE_LOG_MULTIPLE           = "LogSizeMultiple",
}

enum : const(wchar)*
{
    CLUSREG_NAME_KEYVALUESTORE_NAME        = "KeyValueStores",
    CLUSREG_NAME_KEYVALUESTORE_MANAGERNAME = "ManagerName",
    CLUSREG_NAME_KEYVALUESTORE_MANAGERPATH = "ManagerPath",
}

enum uint SR_REPLICATED_PARTITION_DISALLOW_MULTINODE_IO = 0x00000001U;

enum : uint
{
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_FLAG_ADD_VOLUME_INFO          = 0x00000001U,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_FLAG_FILTER_BY_POOL           = 0x00000002U,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_FLAG_INCLUDE_NON_SHARED_DISKS = 0x00000004U,
}

// Native encoding: ansi
enum const(wchar)* STARTUP_ROUTINE = "Startup";
enum uint CLRES_VERSION_V1_00 = 0x00000100U;
// Native encoding: ansi
enum const(wchar)* STARTUP_EX_ROUTINE = "StartupEx";

enum : uint
{
    CLRES_VERSION_V2_00 = 0x00000200U,
    CLRES_VERSION_V3_00 = 0x00000300U,
    CLRES_VERSION_V4_00 = 0x00000400U,
}

enum uint CLUSCTL_GET_OPERATION_CONTEXT_PARAMS_VERSION_1 = 0x00000001U;
enum const(wchar)* CLUSRES_NAME_GET_OPERATION_CONTEXT_FLAGS = "Flags";

enum : uint
{
    CLUSRESDLL_STATUS_OFFLINE_BUSY                  = 0x00000001U,
    CLUSRESDLL_STATUS_OFFLINE_SOURCE_THROTTLED      = 0x00000002U,
    CLUSRESDLL_STATUS_OFFLINE_DESTINATION_THROTTLED = 0x00000004U,
    CLUSRESDLL_STATUS_OFFLINE_DESTINATION_REJECTED  = 0x00000008U,
}

enum : uint
{
    CLUSRESDLL_STATUS_INSUFFICIENT_MEMORY          = 0x00000010U,
    CLUSRESDLL_STATUS_INSUFFICIENT_PROCESSOR       = 0x00000020U,
    CLUSRESDLL_STATUS_INSUFFICIENT_OTHER_RESOURCES = 0x00000040U,
    CLUSRESDLL_STATUS_INVALID_PARAMETERS           = 0x00000080U,
    CLUSRESDLL_STATUS_NETWORK_NOT_AVAILABLE        = 0x00000100U,
    CLUSRESDLL_STATUS_DO_NOT_COLLECT_WER_REPORT    = 0x40000000U,
    CLUSRESDLL_STATUS_DUMP_NOW                     = 0x80000000U,
}

enum uint CLUS_RESDLL_OPEN_RECOVER_MONITOR_STATE = 0x00000001U;

enum : uint
{
    CLUS_RESDLL_ONLINE_RECOVER_MONITOR_STATE          = 0x00000001U,
    CLUS_RESDLL_ONLINE_IGNORE_RESOURCE_STATUS         = 0x00000002U,
    CLUS_RESDLL_ONLINE_RETURN_TO_SOURCE_NODE_ON_ERROR = 0x00000004U,
    CLUS_RESDLL_ONLINE_RESTORE_ONLINE_STATE           = 0x00000008U,
    CLUS_RESDLL_ONLINE_IGNORE_NETWORK_CONNECTIVITY    = 0x00000010U,
}

enum : uint
{
    CLUS_RESDLL_OFFLINE_IGNORE_RESOURCE_STATUS         = 0x00000001U,
    CLUS_RESDLL_OFFLINE_RETURN_TO_SOURCE_NODE_ON_ERROR = 0x00000002U,
}

enum : uint
{
    CLUS_RESDLL_OFFLINE_QUEUE_ENABLED                             = 0x00000004U,
    CLUS_RESDLL_OFFLINE_RETURNING_TO_SOURCE_NODE_BECAUSE_OF_ERROR = 0x00000008U,
}

enum : uint
{
    CLUS_RESDLL_OFFLINE_DUE_TO_EMBEDDED_FAILURE        = 0x00000010U,
    CLUS_RESDLL_OFFLINE_IGNORE_NETWORK_CONNECTIVITY    = 0x00000020U,
    CLUS_RESDLL_OFFLINE_DO_NOT_UPDATE_PERSISTENT_STATE = 0x00000040U,
}

enum uint CLUS_RESDLL_OPEN_DONT_DELETE_TEMP_DISK = 0x00000002U;

enum : uint
{
    RESTYPE_MONITOR_SHUTTING_DOWN_NODE_STOP     = 0x00000001U,
    RESTYPE_MONITOR_SHUTTING_DOWN_CLUSSVC_CRASH = 0x00000002U,
}

enum : uint
{
    RESUTIL_PROPITEM_READ_ONLY = 0x00000001U,
    RESUTIL_PROPITEM_REQUIRED  = 0x00000002U,
    RESUTIL_PROPITEM_SIGNED    = 0x00000004U,
    RESUTIL_PROPITEM_IN_MEMORY = 0x00000008U,
}

enum uint LOCKED_MODE_FLAGS_DONT_REMOVE_FROM_MOVE_QUEUE = 0x00000001U;

enum : uint
{
    CLUSRES_DISABLE_WPR_WATCHDOG_FOR_ONLINE_CALLS  = 0x00000001U,
    CLUSRES_DISABLE_WPR_WATCHDOG_FOR_OFFLINE_CALLS = 0x00000002U,
}

enum const(wchar)* CLUSTER_HEALTH_FAULT_PROPERTY_NAME = "ClusterHealth";

enum : uint
{
    CLUSTER_HEALTH_FAULT_ARGS        = 0x00000007U,
    CLUSTER_HEALTH_FAULT_ID          = 0x00000000U,
    CLUSTER_HEALTH_FAULT_ERRORTYPE   = 0x00000001U,
    CLUSTER_HEALTH_FAULT_ERRORCODE   = 0x00000002U,
    CLUSTER_HEALTH_FAULT_DESCRIPTION = 0x00000003U,
    CLUSTER_HEALTH_FAULT_PROVIDER    = 0x00000004U,
    CLUSTER_HEALTH_FAULT_FLAGS       = 0x00000005U,
    CLUSTER_HEALTH_FAULT_RESERVED    = 0x00000006U,
}

enum : const(wchar)*
{
    CLUSTER_HEALTH_FAULT_ID_LABEL          = "Id",
    CLUSTER_HEALTH_FAULT_ERRORTYPE_LABEL   = "ErrorType",
    CLUSTER_HEALTH_FAULT_ERRORCODE_LABEL   = "ErrorCode",
    CLUSTER_HEALTH_FAULT_DESCRIPTION_LABEL = "Description",
    CLUSTER_HEALTH_FAULT_PROVIDER_LABEL    = "Provider",
    CLUSTER_HEALTH_FAULT_FLAGS_LABEL       = "Flags",
    CLUSTER_HEALTH_FAULT_RESERVED_LABEL    = "Reserved",
}

enum uint CLUS_CREATE_CRYPT_CONTAINER_NOT_FOUND = 0x00000001U;
enum uint SET_APPINSTANCE_CSV_FLAGS_VALID_ONLY_IF_CSV_COORDINATOR = 0x00000001U;

// Callbacks

alias PCLUSAPI_PFN_REASON_HANDLER = BOOL function(void* lpParameter, HCLUSTER hCluster, PWSTR szReason, 
                                                  uint* lpSize);
alias PCLUSAPI_SET_REASON_HANDLER = CLUSAPI_REASON_HANDLER* function(CLUSAPI_REASON_HANDLER* lpHandler);
alias PCLUSAPI_GET_NODE_CLUSTER_STATE = uint function(const(PWSTR) lpszNodeName, uint* pdwClusterState);
alias PCLUSAPI_OPEN_CLUSTER = HCLUSTER function(const(PWSTR) lpszClusterName);
alias PCLUSAPI_OPEN_CLUSTER_EX = HCLUSTER function(const(PWSTR) lpszClusterName, uint dwDesiredAccess, 
                                                   uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER = BOOL function(HCLUSTER hCluster);
alias PCLUSAPI_SetClusterName = uint function(HCLUSTER hCluster, const(PWSTR) lpszNewClusterName);
alias PCLUSAPI_SET_CLUSTER_NAME_EX = uint function(HCLUSTER hCluster, const(PWSTR) lpszNewClusterName, 
                                                   const(PWSTR) lpszReason);
alias PCLUSAPI_GET_CLUSTER_INFORMATION = uint function(HCLUSTER hCluster, PWSTR lpszClusterName, 
                                                       uint* lpcchClusterName, CLUSTERVERSIONINFO* lpClusterInfo);
alias PCLUSAPI_GET_CLUSTER_QUORUM_RESOURCE = uint function(HCLUSTER hCluster, PWSTR lpszResourceName, 
                                                           uint* lpcchResourceName, PWSTR lpszDeviceName, 
                                                           uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);
alias PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE = uint function(HRESOURCE hResource, const(PWSTR) lpszDeviceName, 
                                                           uint dwMaxQuoLogSize);
alias PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE_EX = uint function(HRESOURCE hResource, const(PWSTR) lpszDeviceName, 
                                                              uint dwMaxQuorumLogSize, const(PWSTR) lpszReason);
alias PCLUSAPI_BACKUP_CLUSTER_DATABASE = uint function(HCLUSTER hCluster, const(PWSTR) lpszPathName);
alias PCLUSAPI_RESTORE_CLUSTER_DATABASE = uint function(const(PWSTR) lpszPathName, BOOL bForce, 
                                                        const(PWSTR) lpszQuorumDriveLetter);
alias PCLUSAPI_SET_CLUSTER_NETWORK_PRIORITY_ORDER = uint function(HCLUSTER hCluster, uint NetworkCount, 
                                                                  HNETWORK* NetworkList);
alias PCLUSAPI_SET_CLUSTER_SERVICE_ACCOUNT_PASSWORD = uint function(const(PWSTR) lpszClusterName, 
                                                                    const(PWSTR) lpszNewPassword, uint dwFlags, 
                                                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/CLUSTER_SET_PASSWORD_STATUS* lpReturnStatusBuffer, 
                                                                    uint* lpcbReturnStatusBufferSize);
alias PCLUSAPI_CLUSTER_CONTROL = uint function(HCLUSTER hCluster, HNODE hHostNode, uint dwControlCode, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                               uint nInBufferSize, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                               uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_CONTROL_EX = uint function(HCLUSTER hCluster, HNODE hHostNode, uint dwControlCode, 
                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                  uint nInBufferSize, 
                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                  uint nOutBufferSize, uint* lpBytesReturned, 
                                                  const(PWSTR) lpszReason);
alias PCLUSTER_UPGRADE_PROGRESS_CALLBACK = BOOL function(void* pvCallbackArg, CLUSTER_UPGRADE_PHASE eUpgradePhase);
alias PCLUSAPI_CLUSTER_UPGRADE = uint function(HCLUSTER hCluster, BOOL perform, 
                                               PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, 
                                               void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT_V2 = HCHANGE function(HCHANGE hChange, HCLUSTER hCluster, 
                                                                NOTIFY_FILTER_AND_TYPE* Filters, uint dwFilterCount, 
                                                                size_t dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY_V2 = uint function(HCHANGE hChange, NOTIFY_FILTER_AND_TYPE Filter, 
                                                          HANDLE hObject, size_t dwNotifyKey);
alias PCLUSAPI_GET_NOTIFY_EVENT_HANDLE_V2 = uint function(HCHANGE hChange, HANDLE* lphTargetEvent);
alias PCLUSAPI_GET_CLUSTER_NOTIFY_V2 = uint function(HCHANGE hChange, size_t* lpdwNotifyKey, 
                                                     NOTIFY_FILTER_AND_TYPE* pFilterAndType, ubyte* buffer, 
                                                     uint* lpcchBufferSize, PWSTR lpszObjectId, uint* lpcchObjectId, 
                                                     PWSTR lpszParentId, uint* lpcchParentId, PWSTR lpszName, 
                                                     uint* lpcchName, PWSTR lpszType, uint* lpcchType, 
                                                     uint dwMilliseconds);
alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT = HCHANGE function(HCHANGE hChange, HCLUSTER hCluster, uint dwFilter, 
                                                             size_t dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY = uint function(HCHANGE hChange, uint dwFilterType, HANDLE hObject, 
                                                       size_t dwNotifyKey);
alias PCLUSAPI_GET_CLUSTER_NOTIFY = uint function(HCHANGE hChange, size_t* lpdwNotifyKey, uint* lpdwFilterType, 
                                                  PWSTR lpszName, uint* lpcchName, uint dwMilliseconds);
alias PCLUSAPI_CLOSE_CLUSTER_NOTIFY_PORT = BOOL function(HCHANGE hChange);
alias PCLUSAPI_CLUSTER_OPEN_ENUM = HCLUSENUM function(HCLUSTER hCluster, uint dwType);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT = uint function(HCLUSENUM hEnum);
alias PCLUSAPI_CLUSTER_ENUM = uint function(HCLUSENUM hEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, 
                                            uint* lpcchName);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM = uint function(HCLUSENUM hEnum);
alias PCLUSAPI_CLUSTER_OPEN_ENUM_EX = HCLUSENUMEX function(HCLUSTER hCluster, uint dwType, void* pOptions);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT_EX = uint function(HCLUSENUMEX hClusterEnum);
alias PCLUSAPI_CLUSTER_ENUM_EX = uint function(HCLUSENUMEX hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, 
                                               uint* cbItem);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM_EX = uint function(HCLUSENUMEX hClusterEnum);
alias PCLUSAPI_CREATE_CLUSTER_GROUP_GROUPSET = HGROUPSET function(HCLUSTER hCluster, const(PWSTR) lpszGroupSetName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_GROUPSET = HGROUPSET function(HCLUSTER hCluster, const(PWSTR) lpszGroupSetName);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP_GROUPSET = BOOL function(HGROUPSET hGroupSet);
alias PCLUSAPI_DELETE_CLUSTER_GROUP_GROUPSET = uint function(HGROUPSET hGroupSet);
alias PCLUSAPI_DELETE_CLUSTER_GROUP_GROUPSET_EX = uint function(HGROUPSET hGroupSet, const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_GROUP_GROUPSET = uint function(HGROUPSET hGroupSet, HGROUP hGroup);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_GROUPSET_WITH_DOMAINS_EX = uint function(HGROUPSET hGroupSet, HGROUP hGroup, 
                                                                             uint faultDomain, uint updateDomain, 
                                                                             const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_GROUPSET = uint function(HGROUPSET hGroupSet);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_GROUPSET_EX = uint function(HGROUPSET hGroupSet, const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_GROUP_GROUPSET_CONTROL = uint function(HGROUPSET hGroupSet, HNODE hHostNode, 
                                                              uint dwControlCode, 
                                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                              uint cbInBufferSize, 
                                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                              uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_GROUP_GROUPSET_CONTROL_EX = uint function(HGROUPSET hGroupSet, HNODE hHostNode, 
                                                                 uint dwControlCode, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                                 uint cbInBufferSize, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                                 uint cbOutBufferSize, uint* lpBytesReturned, 
                                                                 const(PWSTR) lpszReason);
alias PCLUSAPI_ADD_CLUSTER_GROUP_DEPENDENCY = uint function(HGROUP hDependentGroup, HGROUP hProviderGroup);
alias PCLUSAPI_ADD_CLUSTER_GROUP_DEPENDENCY_EX = uint function(HGROUP hDependentGroup, HGROUP hProviderGroup, 
                                                               const(PWSTR) lpszReason);
alias PCLUSAPI_SET_GROUP_DEPENDENCY_EXPRESSION = uint function(HGROUP hGroupSet, 
                                                               const(PWSTR) lpszDependencyExpression);
alias PCLUSAPI_SET_GROUP_DEPENDENCY_EXPRESSION_EX = uint function(HGROUP hGroup, 
                                                                  const(PWSTR) lpszDependencyExpression, 
                                                                  const(PWSTR) lpszReason);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_DEPENDENCY = uint function(HGROUP hGroup, HGROUP hDependsOn);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_DEPENDENCY_EX = uint function(HGROUP hGroup, HGROUP hDependsOn, 
                                                                  const(PWSTR) lpszReason);
alias PCLUSAPI_ADD_CLUSTER_GROUP_GROUPSET_DEPENDENCY = uint function(HGROUPSET hDependentGroupSet, 
                                                                     HGROUPSET hProviderGroupSet);
alias PCLUSAPI_ADD_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EX = uint function(HGROUPSET hDependentGroupSet, 
                                                                        HGROUPSET hProviderGroupSet, 
                                                                        const(PWSTR) lpszReason);
alias PCLUSAPI_SET_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EXPRESSION = uint function(HGROUPSET hGroupSet, 
                                                                                const(PWSTR) lpszDependencyExpression);
alias PCLUSAPI_SET_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EXPRESSION_EX = uint function(HGROUPSET hGroupSet, 
                                                                                   const(PWSTR) lpszDependencyExpression, 
                                                                                   const(PWSTR) lpszReason);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_GROUPSET_DEPENDENCY = uint function(HGROUPSET hGroupSet, HGROUPSET hDependsOn);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EX = uint function(HGROUPSET hGroupSet, 
                                                                           HGROUPSET hDependsOn, 
                                                                           const(PWSTR) lpszReason);
alias PCLUSAPI_ADD_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = uint function(HGROUP hDependentGroup, 
                                                                              HGROUPSET hProviderGroupSet);
alias PCLUSAPI_ADD_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY_EX = uint function(HGROUP hDependentGroup, 
                                                                                 HGROUPSET hProviderGroupSet, 
                                                                                 const(PWSTR) lpszReason);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = uint function(HGROUP hGroup, 
                                                                                 HGROUPSET hDependsOn);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY_EX = uint function(HGROUP hGroup, 
                                                                                    HGROUPSET hDependsOn, 
                                                                                    const(PWSTR) lpszReason);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP_GROUPSET = HCLUSTER function(HGROUPSET hGroupSet);
alias PCLUSAPI_ADD_CROSS_CLUSTER_GROUPSET_DEPENDENCY = uint function(HGROUPSET hDependentGroupSet, 
                                                                     const(PWSTR) lpRemoteClusterName, 
                                                                     const(PWSTR) lpRemoteGroupSetName);
alias PCLUSAPI_REMOVE_CROSS_CLUSTER_GROUPSET_DEPENDENCY = uint function(HGROUPSET hDependentGroupSet, 
                                                                        const(PWSTR) lpRemoteClusterName, 
                                                                        const(PWSTR) lpRemoteGroupSetName);
alias PCLUSAPI_CREATE_CLUSTER_AVAILABILITY_SET = HGROUPSET function(HCLUSTER hCluster, 
                                                                    const(PWSTR) lpAvailabilitySetName, 
                                                                    CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);
alias PCLUSAPI_CLUSTER_CREATE_AFFINITY_RULE = uint function(HCLUSTER hCluster, const(PWSTR) ruleName, 
                                                            CLUS_AFFINITY_RULE_TYPE ruleType);
alias PCLUSAPI_CLUSTER_REMOVE_AFFINITY_RULE = uint function(HCLUSTER hCluster, const(PWSTR) ruleName);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_AFFINITY_RULE = uint function(HCLUSTER hCluster, const(PWSTR) ruleName, 
                                                                  HGROUP hGroup);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_AFFINITY_RULE = uint function(HCLUSTER hCluster, const(PWSTR) ruleName, 
                                                                       HGROUP hGroup);
alias PCLUSAPI_CLUSTER_AFFINITY_RULE_CONTROL = uint function(HCLUSTER hCluster, const(PWSTR) affinityRuleName, 
                                                             HNODE hHostNode, uint dwControlCode, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                                             uint cbInBufferSize, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                                             uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_OPEN_CLUSTER_NODE = HNODE function(HCLUSTER hCluster, const(PWSTR) lpszNodeName);
alias PCLUSAPI_OPEN_CLUSTER_NODE_EX = HNODE function(HCLUSTER hCluster, const(PWSTR) lpszNodeName, 
                                                     uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_OPEN_NODE_BY_ID = HNODE function(HCLUSTER hCluster, uint nodeId);
alias PCLUSAPI_CLOSE_CLUSTER_NODE = BOOL function(HNODE hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_STATE = CLUSTER_NODE_STATE function(HNODE hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_ID = uint function(HNODE hNode, PWSTR lpszNodeId, uint* lpcchName);
alias PCLUSAPI_GET_CLUSTER_FROM_NODE = HCLUSTER function(HNODE hNode);
alias PCLUSAPI_PAUSE_CLUSTER_NODE = uint function(HNODE hNode);
alias PCLUSAPI_RESUME_CLUSTER_NODE = uint function(HNODE hNode);
alias PCLUSAPI_EVICT_CLUSTER_NODE = uint function(HNODE hNode);
alias PCLUSAPI_CLUSTER_NODE_OPEN_ENUM = HNODEENUM function(HNODE hNode, uint dwType);
alias PCLUSAPI_CLUSTER_NODE_OPEN_ENUM_EX = HNODEENUMEX function(HNODE hNode, uint dwType, void* pOptions);
alias PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT_EX = uint function(HNODEENUMEX hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_ENUM_EX = uint function(HNODEENUMEX hNodeEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, 
                                                    uint* cbItem);
alias PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM_EX = uint function(HNODEENUMEX hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT = uint function(HNODEENUM hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM = uint function(HNODEENUM hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_ENUM = uint function(HNODEENUM hNodeEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, 
                                                 uint* lpcchName);
alias PCLUSAPI_EVICT_CLUSTER_NODE_EX = uint function(HNODE hNode, uint dwTimeOut, HRESULT* phrCleanupStatus);
alias PCLUSAPI_EVICT_CLUSTER_NODE_EX2 = uint function(HNODE hNode, uint dwTimeout, HRESULT* phrCleanupStatus, 
                                                      const(PWSTR) lpszReason);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_TYPE_KEY = HKEY function(HCLUSTER hCluster, const(PWSTR) lpszTypeName, 
                                                             uint samDesired);
alias PCLUSAPI_CREATE_CLUSTER_GROUP = HGROUP function(HCLUSTER hCluster, const(PWSTR) lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP = HGROUP function(HCLUSTER hCluster, const(PWSTR) lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_EX = HGROUP function(HCLUSTER hCluster, const(PWSTR) lpszGroupName, 
                                                       uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_PAUSE_CLUSTER_NODE_EX = uint function(HNODE hNode, BOOL bDrainNode, uint dwPauseFlags, 
                                                     HNODE hNodeDrainTarget);
alias PCLUSAPI_PAUSE_CLUSTER_NODE_EX2 = uint function(HNODE hNode, BOOL bDrainNode, uint dwPauseFlags, 
                                                      HNODE hNodeDrainTarget, const(PWSTR) lpszReason);
alias PCLUSAPI_RESUME_CLUSTER_NODE_EX = uint function(HNODE hNode, 
                                                      CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                                                      uint dwResumeFlagsReserved);
alias PCLUSAPI_RESUME_CLUSTER_NODE_EX2 = uint function(HNODE hNode, 
                                                       CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                                                       uint dwResumeFlagsReserved, const(PWSTR) lpszReason);
alias PCLUSAPI_CREATE_CLUSTER_GROUPEX = HGROUP function(HCLUSTER hCluster, const(PWSTR) lpszGroupName, 
                                                        CLUSTER_CREATE_GROUP_INFO* pGroupInfo);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM_EX = HGROUPENUMEX function(HCLUSTER hCluster, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PWSTR) lpszProperties, 
                                                                  uint cbProperties, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PWSTR) lpszRoProperties, 
                                                                  uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT_EX = uint function(HGROUPENUMEX hGroupEnumEx);
alias PCLUSAPI_CLUSTER_GROUP_ENUM_EX = uint function(HGROUPENUMEX hGroupEnumEx, uint dwIndex, 
                                                     CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM_EX = uint function(HGROUPENUMEX hGroupEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM_EX = HRESENUMEX function(HCLUSTER hCluster, 
                                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PWSTR) lpszProperties, 
                                                                   uint cbProperties, 
                                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PWSTR) lpszRoProperties, 
                                                                   uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT_EX = uint function(HRESENUMEX hResourceEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM_EX = uint function(HRESENUMEX hResourceEnumEx, uint dwIndex, 
                                                        CLUSTER_RESOURCE_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM_EX = uint function(HRESENUMEX hResourceEnumEx);
alias PCLUSAPI_RESTART_CLUSTER_RESOURCE = uint function(HRESOURCE hResource, uint dwFlags);
alias PCLUSAPI_RESTART_CLUSTER_RESOURCE_EX = uint function(HRESOURCE hResource, uint dwFlags);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP = BOOL function(HGROUP hGroup);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP = HCLUSTER function(HGROUP hGroup);
alias PCLUSAPI_GET_CLUSTER_GROUP_STATE = CLUSTER_GROUP_STATE function(HGROUP hGroup, PWSTR lpszNodeName, 
                                                                      uint* lpcchNodeName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NAME = uint function(HGROUP hGroup, const(PWSTR) lpszGroupName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST = uint function(HGROUP hGroup, uint NodeCount, HNODE* NodeList);
alias PCLUSAPI_SET_CLUSTER_GROUP_NAME_EX = uint function(HGROUP hGroup, const(PWSTR) lpszGroupName, 
                                                         const(PWSTR) lpszReason);
alias PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST_EX = uint function(HGROUP hGroup, uint NodeCount, HNODE* NodeList, 
                                                              const(PWSTR) lpszReason);
alias PCLUSAPI_ONLINE_CLUSTER_GROUP = uint function(HGROUP hGroup, HNODE hDestinationNode);
alias PCLUSAPI_MOVE_CLUSTER_GROUP = uint function(HGROUP hGroup, HNODE hDestinationNode);
alias PCLUSAPI_OFFLINE_CLUSTER_GROUP = uint function(HGROUP hGroup);
alias PCLUSAPI_DELETE_CLUSTER_GROUP = uint function(HGROUP hGroup);
alias PCLUSAPI_DESTROY_CLUSTER_GROUP = uint function(HGROUP hGroup);
alias PCLUSAPI_DELETE_CLUSTER_GROUP_EX = uint function(HGROUP hGroup, const(PWSTR) lpszReason);
alias PCLUSAPI_DESTROY_CLUSTER_GROUP_EX = uint function(HGROUP hGroup, const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM = HGROUPENUM function(HGROUP hGroup, uint dwType);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT = uint function(HGROUPENUM hGroupEnum);
alias PCLUSAPI_CLUSTER_GROUP_ENUM = uint function(HGROUPENUM hGroupEnum, uint dwIndex, uint* lpdwType, 
                                                  PWSTR lpszResourceName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM = uint function(HGROUPENUM hGroupEnum);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE = HRESOURCE function(HGROUP hGroup, const(PWSTR) lpszResourceName, 
                                                            const(PWSTR) lpszResourceType, uint dwFlags);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE_EX = HRESOURCE function(HGROUP hGroup, const(PWSTR) lpszResourceName, 
                                                               const(PWSTR) lpszResourceType, uint dwFlags, 
                                                               const(PWSTR) lpszReason);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE = HRESOURCE function(HCLUSTER hCluster, const(PWSTR) lpszResourceName);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE_EX = HRESOURCE function(HCLUSTER hCluster, const(PWSTR) lpszResourceName, 
                                                             uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_RESOURCE = BOOL function(HRESOURCE hResource);
alias PCLUSAPI_GET_CLUSTER_FROM_RESOURCE = HCLUSTER function(HRESOURCE hResource);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE = uint function(HRESOURCE hResource);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE_EX = uint function(HRESOURCE hResource, const(PWSTR) lpszReason);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_STATE = CLUSTER_RESOURCE_STATE function(HRESOURCE hResource, 
                                                                            PWSTR lpszNodeName, uint* lpcchNodeName, 
                                                                            PWSTR lpszGroupName, 
                                                                            uint* lpcchGroupName);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_NAME = uint function(HRESOURCE hResource, const(PWSTR) lpszResourceName);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_NAME_EX = uint function(HRESOURCE hResource, const(PWSTR) lpszResourceName, 
                                                            const(PWSTR) lpszReason);
alias PCLUSAPI_FAIL_CLUSTER_RESOURCE = uint function(HRESOURCE hResource);
alias PCLUSAPI_FAIL_CLUSTER_RESOURCE_EX = uint function(HRESOURCE hResource, const(PWSTR) lpszReason);
alias PCLUSAPI_ONLINE_CLUSTER_RESOURCE = uint function(HRESOURCE hResource);
alias PCLUSAPI_OFFLINE_CLUSTER_RESOURCE = uint function(HRESOURCE hResource);
alias PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP = uint function(HRESOURCE hResource, HGROUP hGroup);
alias PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP_EX = uint function(HRESOURCE hResource, HGROUP hGroup, ulong Flags);
alias PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP_EX2 = uint function(HRESOURCE hResource, HGROUP hGroup, ulong Flags, 
                                                                 const(PWSTR) lpszReason);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_NODE = uint function(HRESOURCE hResource, HNODE hNode);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_NODE = uint function(HRESOURCE hResource, HNODE hNode);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_NODE_EX = uint function(HRESOURCE hResource, HNODE hNode, 
                                                            const(PWSTR) lpszReason);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_NODE_EX = uint function(HRESOURCE hResource, HNODE hNode, 
                                                               const(PWSTR) lpszReason);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_DEPENDENCY = uint function(HRESOURCE hResource, HRESOURCE hDependsOn);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_DEPENDENCY = uint function(HRESOURCE hResource, HRESOURCE hDependsOn);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_DEPENDENCY_EX = uint function(HRESOURCE hResource, HRESOURCE hDependsOn, 
                                                                  const(PWSTR) lpszReason);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_DEPENDENCY_EX = uint function(HRESOURCE hResource, HRESOURCE hDependsOn, 
                                                                     const(PWSTR) lpszReason);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION = uint function(HRESOURCE hResource, 
                                                                          const(PWSTR) lpszDependencyExpression);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION = uint function(HRESOURCE hResource, 
                                                                          PWSTR lpszDependencyExpression, 
                                                                          uint* lpcchDependencyExpression);
alias PCLUSAPI_ADD_RESOURCE_TO_CLUSTER_SHARED_VOLUMES = uint function(HRESOURCE hResource);
alias PCLUSAPI_REMOVE_RESOURCE_FROM_CLUSTER_SHARED_VOLUMES = uint function(HRESOURCE hResource);
alias PCLUSAPI_IS_FILE_ON_CLUSTER_SHARED_VOLUME = uint function(const(PWSTR) lpszPathName, 
                                                                BOOL* pbFileIsOnSharedVolume);
alias PCLUSAPI_SHARED_VOLUME_SET_SNAPSHOT_STATE = uint function(GUID guidSnapshotSet, const(PWSTR) lpszVolumeName, 
                                                                CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);
alias PCLUSAPI_CAN_RESOURCE_BE_DEPENDENT = BOOL function(HRESOURCE hResource, HRESOURCE hResourceDependent);
alias PCLUSAPI_CLUSTER_RESOURCE_CONTROL = uint function(HRESOURCE hResource, HNODE hHostNode, uint dwControlCode, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                        uint cbInBufferSize, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                        uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL = uint function(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, 
                                                             HNODE hHostNode, uint dwControlCode, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                                             uint nInBufferSize, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                                             uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_GROUP_CONTROL = uint function(HGROUP hGroup, HNODE hHostNode, uint dwControlCode, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                     uint nInBufferSize, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                     uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_RESOURCE_CONTROL_EX = uint function(HRESOURCE hResource, HNODE hHostNode, 
                                                           uint dwControlCode, 
                                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                           uint cbInBufferSize, 
                                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                           uint cbOutBufferSize, uint* lpBytesReturned, 
                                                           const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_RESOURCE_CONTROL_AS_USER_EX = uint function(HRESOURCE hResource, HNODE hHostNode, 
                                                                   uint dwControlCode, 
                                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                                   uint cbInBufferSize, 
                                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                                   uint cbOutBufferSize, uint* lpBytesReturned, 
                                                                   const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL_EX = uint function(HCLUSTER hCluster, 
                                                                const(PWSTR) lpszResourceTypeName, HNODE hHostNode, 
                                                                uint dwControlCode, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                                                uint nInBufferSize, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                                                uint nOutBufferSize, uint* lpBytesReturned, 
                                                                const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL_AS_USER_EX = uint function(HCLUSTER hCluster, 
                                                                        const(PWSTR) lpszResourceTypeName, 
                                                                        HNODE hHostNode, uint dwControlCode, 
                                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                                                        uint nInBufferSize, 
                                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                                                        uint nOutBufferSize, uint* lpBytesReturned, 
                                                                        const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_GROUP_CONTROL_EX = uint function(HGROUP hGroup, HNODE hHostNode, uint dwControlCode, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                        uint nInBufferSize, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                        uint nOutBufferSize, uint* lpBytesReturned, 
                                                        const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_NODE_CONTROL = uint function(HNODE hNode, HNODE hHostNode, uint dwControlCode, 
                                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                    uint nInBufferSize, 
                                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                    uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_NODE_CONTROL_EX = uint function(HNODE hNode, HNODE hHostNode, uint dwControlCode, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                       uint nInBufferSize, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                       uint nOutBufferSize, uint* lpBytesReturned, 
                                                       const(PWSTR) lpszReason);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_NETWORK_NAME = BOOL function(HRESOURCE hResource, PWSTR lpBuffer, uint* nSize);
alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM = HRESENUM function(HRESOURCE hResource, uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT = uint function(HRESENUM hResEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM = uint function(HRESENUM hResEnum, uint dwIndex, uint* lpdwType, 
                                                     PWSTR lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM = uint function(HRESENUM hResEnum);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE = uint function(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, 
                                                            const(PWSTR) lpszDisplayName, 
                                                            const(PWSTR) lpszResourceTypeDll, 
                                                            uint dwLooksAlivePollInterval, 
                                                            uint dwIsAlivePollInterval);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE = uint function(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE_EX = uint function(HCLUSTER hCluster, 
                                                               const(PWSTR) lpszResourceTypeName, 
                                                               const(PWSTR) lpszDisplayName, 
                                                               const(PWSTR) lpszResourceTypeDll, 
                                                               uint dwLooksAlivePollInterval, 
                                                               uint dwIsAlivePollInterval, const(PWSTR) lpszReason);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE_EX = uint function(HCLUSTER hCluster, const(PWSTR) lpszTypeName, 
                                                               const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_OPEN_ENUM = HRESTYPEENUM function(HCLUSTER hCluster, 
                                                                       const(PWSTR) lpszResourceTypeName, 
                                                                       uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_GET_ENUM_COUNT = uint function(HRESTYPEENUM hResTypeEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_ENUM = uint function(HRESTYPEENUM hResTypeEnum, uint dwIndex, uint* lpdwType, 
                                                          PWSTR lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CLOSE_ENUM = uint function(HRESTYPEENUM hResTypeEnum);
alias PCLUSAPI_OPEN_CLUSTER_NETWORK = HNETWORK function(HCLUSTER hCluster, const(PWSTR) lpszNetworkName);
alias PCLUSAPI_OPEN_CLUSTER_NETWORK_EX = HNETWORK function(HCLUSTER hCluster, const(PWSTR) lpszNetworkName, 
                                                           uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_NETWORK = BOOL function(HNETWORK hNetwork);
alias PCLUSAPI_GET_CLUSTER_FROM_NETWORK = HCLUSTER function(HNETWORK hNetwork);
alias PCLUSAPI_CLUSTER_NETWORK_OPEN_ENUM = HNETWORKENUM function(HNETWORK hNetwork, uint dwType);
alias PCLUSAPI_CLUSTER_NETWORK_GET_ENUM_COUNT = uint function(HNETWORKENUM hNetworkEnum);
alias PCLUSAPI_CLUSTER_NETWORK_ENUM = uint function(HNETWORKENUM hNetworkEnum, uint dwIndex, uint* lpdwType, 
                                                    PWSTR lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CLOSE_ENUM = uint function(HNETWORKENUM hNetworkEnum);
alias PCLUSAPI_GET_CLUSTER_NETWORK_STATE = CLUSTER_NETWORK_STATE function(HNETWORK hNetwork);
alias PCLUSAPI_SET_CLUSTER_NETWORK_NAME = uint function(HNETWORK hNetwork, const(PWSTR) lpszName);
alias PCLUSAPI_SET_CLUSTER_NETWORK_NAME_EX = uint function(HNETWORK hNetwork, const(PWSTR) lpszName, 
                                                           const(PWSTR) lpszReason);
alias PCLUSAPI_GET_CLUSTER_NETWORK_ID = uint function(HNETWORK hNetwork, PWSTR lpszNetworkId, uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CONTROL = uint function(HNETWORK hNetwork, HNODE hHostNode, uint dwControlCode, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                       uint nInBufferSize, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                       uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_NETWORK_CONTROL_EX = uint function(HNETWORK hNetwork, HNODE hHostNode, uint dwControlCode, 
                                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                          uint nInBufferSize, 
                                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                          uint nOutBufferSize, uint* lpBytesReturned, 
                                                          const(PWSTR) lpszReason);
alias PCLUSAPI_OPEN_CLUSTER_NET_INTERFACE = HNETINTERFACE function(HCLUSTER hCluster, 
                                                                   const(PWSTR) lpszInterfaceName);
alias PCLUSAPI_OPEN_CLUSTER_NETINTERFACE_EX = HNETINTERFACE function(HCLUSTER hCluster, 
                                                                     const(PWSTR) lpszNetInterfaceName, 
                                                                     uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE = uint function(HCLUSTER hCluster, const(PWSTR) lpszNodeName, 
                                                         const(PWSTR) lpszNetworkName, PWSTR lpszInterfaceName, 
                                                         uint* lpcchInterfaceName);
alias PCLUSAPI_CLOSE_CLUSTER_NET_INTERFACE = BOOL function(HNETINTERFACE hNetInterface);
alias PCLUSAPI_GET_CLUSTER_FROM_NET_INTERFACE = HCLUSTER function(HNETINTERFACE hNetInterface);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_STATE = CLUSTER_NETINTERFACE_STATE function(HNETINTERFACE hNetInterface);
alias PCLUSAPI_CLUSTER_NET_INTERFACE_CONTROL = uint function(HNETINTERFACE hNetInterface, HNODE hHostNode, 
                                                             uint dwControlCode, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                             uint nInBufferSize, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                             uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_NET_INTERFACE_CONTROL_EX = uint function(HNETINTERFACE hNetInterface, HNODE hHostNode, 
                                                                uint dwControlCode, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                                                uint nInBufferSize, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                                                uint nOutBufferSize, uint* lpBytesReturned, 
                                                                const(PWSTR) lpszReason);
alias PCLUSAPI_GET_CLUSTER_KEY = HKEY function(HCLUSTER hCluster, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_GROUP_KEY = HKEY function(HGROUP hGroup, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_KEY = HKEY function(HRESOURCE hResource, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NODE_KEY = HKEY function(HNODE hNode, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NETWORK_KEY = HKEY function(HNETWORK hNetwork, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_KEY = HKEY function(HNETINTERFACE hNetInterface, uint samDesired);
alias PCLUSAPI_CLUSTER_REG_CREATE_KEY = int function(HKEY hKey, const(PWSTR) lpszSubKey, uint dwOptions, 
                                                     uint samDesired, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                                                     HKEY* phkResult, uint* lpdwDisposition);
alias PCLUSAPI_CLUSTER_REG_CREATE_KEY_EX = int function(HKEY hKey, const(PWSTR) lpszSubKey, uint dwOptions, 
                                                        uint samDesired, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                                                        HKEY* phkResult, uint* lpdwDisposition, 
                                                        const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_REG_OPEN_KEY = int function(HKEY hKey, const(PWSTR) lpszSubKey, uint samDesired, 
                                                   HKEY* phkResult);
alias PCLUSAPI_CLUSTER_REG_DELETE_KEY = int function(HKEY hKey, const(PWSTR) lpszSubKey);
alias PCLUSAPI_CLUSTER_REG_DELETE_KEY_EX = int function(HKEY hKey, const(PWSTR) lpSubKey, const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_REG_CLOSE_KEY = int function(HKEY hKey);
alias PCLUSAPI_CLUSTER_REG_ENUM_KEY = int function(HKEY hKey, uint dwIndex, PWSTR lpszName, uint* lpcchName, 
                                                   FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_SET_VALUE = uint function(HKEY hKey, const(PWSTR) lpszValueName, uint dwType, 
                                                     const(ubyte)* lpData, uint cbData);
alias PCLUSAPI_CLUSTER_REG_DELETE_VALUE = uint function(HKEY hKey, const(PWSTR) lpszValueName);
alias PCLUSAPI_CLUSTER_REG_SET_VALUE_EX = uint function(HKEY hKey, const(PWSTR) lpszValueName, uint dwType, 
                                                        const(ubyte)* lpData, uint cbData, const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_REG_DELETE_VALUE_EX = uint function(HKEY hKey, const(PWSTR) lpszValueName, 
                                                           const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_REG_QUERY_VALUE = int function(HKEY hKey, const(PWSTR) lpszValueName, uint* lpdwValueType, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpData, 
                                                      uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_ENUM_VALUE = uint function(HKEY hKey, uint dwIndex, PWSTR lpszValueName, 
                                                      uint* lpcchValueName, uint* lpdwType, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpData, 
                                                      uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_QUERY_INFO_KEY = int function(HKEY hKey, uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, 
                                                         uint* lpcValues, uint* lpcbMaxValueNameLen, 
                                                         uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                                                         FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_GET_KEY_SECURITY = int function(HKEY hKey, uint RequestedInformation, 
                                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                                                           uint* lpcbSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SET_KEY_SECURITY = int function(HKEY hKey, uint SecurityInformation, 
                                                           PSECURITY_DESCRIPTOR pSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SET_KEY_SECURITY_EX = int function(HKEY hKey, uint SecurityInformation, 
                                                              PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                                                              const(PWSTR) lpszReason);
alias PCLUSAPI_CLUSTER_REG_SYNC_DATABASE = int function(HCLUSTER hCluster, uint flags);
alias PCLUSAPI_CLUSTER_REG_CREATE_BATCH = int function(HKEY hKey, HREGBATCH* pHREGBATCH);
alias PCLUSTER_REG_BATCH_ADD_COMMAND = int function(HREGBATCH hRegBatch, CLUSTER_REG_COMMAND dwCommand, 
                                                    PWSTR wzName, uint dwOptions, 
                                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* lpData, 
                                                    uint cbData);
alias PCLUSTER_REG_CLOSE_BATCH = int function(HREGBATCH hRegBatch, BOOL bCommit, int* failedCommandNumber);
alias PCLUSTER_REG_BATCH_READ_COMMAND = int function(HREGBATCHNOTIFICATION hBatchNotification, 
                                                     CLUSTER_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_BATCH_CLOSE_NOTIFICATION = int function(HREGBATCHNOTIFICATION hBatchNotification);
alias PCLUSTER_REG_CREATE_BATCH_NOTIFY_PORT = int function(HKEY hKey, HREGBATCHPORT* phBatchNotifyPort);
alias PCLUSTER_REG_CLOSE_BATCH_NOTIFY_PORT = int function(HREGBATCHPORT hBatchNotifyPort);
alias PCLUSTER_REG_GET_BATCH_NOTIFICATION = int function(HREGBATCHPORT hBatchNotify, 
                                                         HREGBATCHNOTIFICATION* phBatchNotification);
alias PCLUSTER_REG_CREATE_READ_BATCH = int function(HKEY hKey, HREGREADBATCH* phRegReadBatch);
alias PCLUSTER_REG_READ_BATCH_ADD_COMMAND = int function(HREGREADBATCH hRegReadBatch, const(PWSTR) wzSubkeyName, 
                                                         const(PWSTR) wzValueName);
alias PCLUSTER_REG_CLOSE_READ_BATCH = int function(HREGREADBATCH hRegReadBatch, 
                                                   HREGREADBATCHREPLY* phRegReadBatchReply);
alias PCLUSTER_REG_CLOSE_READ_BATCH_EX = int function(HREGREADBATCH hRegReadBatch, uint flags, 
                                                      HREGREADBATCHREPLY* phRegReadBatchReply);
alias PCLUSTER_REG_READ_BATCH_REPLY_NEXT_COMMAND = int function(HREGREADBATCHREPLY hRegReadBatchReply, 
                                                                CLUSTER_READ_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_CLOSE_READ_BATCH_REPLY = int function(HREGREADBATCHREPLY hRegReadBatchReply);
alias PCLUSTER_SET_ACCOUNT_ACCESS = uint function(HCLUSTER hCluster, const(PWSTR) szAccountSID, uint dwAccess, 
                                                  uint dwControlType);
alias PCLUSTER_SETUP_PROGRESS_CALLBACK = BOOL function(void* pvCallbackArg, CLUSTER_SETUP_PHASE eSetupPhase, 
                                                       CLUSTER_SETUP_PHASE_TYPE ePhaseType, 
                                                       CLUSTER_SETUP_PHASE_SEVERITY ePhaseSeverity, 
                                                       uint dwPercentComplete, const(PWSTR) lpszObjectName, 
                                                       uint dwStatus);
alias PCLUSAPI_CREATE_CLUSTER = HCLUSTER function(CREATE_CLUSTER_CONFIG* pConfig, 
                                                  PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                  void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_CNOLESS = HCLUSTER function(CREATE_CLUSTER_CONFIG* pConfig, 
                                                          PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                          void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_NAME_ACCOUNT = uint function(HCLUSTER hCluster, CREATE_CLUSTER_NAME_ACCOUNT* pConfig, 
                                                           PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                           void* pvCallbackArg);
alias PCLUSAPI_REPAIR_CLUSTER_NAME_ACCOUNT = uint function(HCLUSTER hCluster);
alias PCLUSAPI_REMOVE_CLUSTER_NAME_ACCOUNT = uint function(HCLUSTER hCluster);
alias PCLUSAPI_ADD_CLUSTER_NODE = HNODE function(HCLUSTER hCluster, const(PWSTR) lpszNodeName, 
                                                 PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                 void* pvCallbackArg);
alias PCLUSAPI_ADD_CLUSTER_NODE_EX = HNODE function(HCLUSTER hCluster, const(PWSTR) lpszNodeName, uint dwFlags, 
                                                    PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                                    void* pvCallbackArg);
alias PCLUSAPI_DESTROY_CLUSTER = uint function(HCLUSTER hCluster, 
                                               PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                                               void* pvCallbackArg, BOOL fdeleteVirtualComputerObjects);
alias PSET_RESOURCE_STATUS_ROUTINE_EX = uint function(ptrdiff_t ResourceHandle, RESOURCE_STATUS_EX* ResourceStatus);
alias PSET_RESOURCE_STATUS_ROUTINE = uint function(ptrdiff_t ResourceHandle, RESOURCE_STATUS* ResourceStatus);
alias PQUORUM_RESOURCE_LOST = void function(ptrdiff_t Resource);
alias PLOG_EVENT_ROUTINE = void function(ptrdiff_t ResourceHandle, LOG_LEVEL LogLevel, const(PWSTR) FormatString);
alias POPEN_ROUTINE = void* function(const(PWSTR) ResourceName, HKEY ResourceKey, ptrdiff_t ResourceHandle);
alias PCLOSE_ROUTINE = void function(void* Resource);
alias PONLINE_ROUTINE = uint function(void* Resource, HANDLE* EventHandle);
alias POFFLINE_ROUTINE = uint function(void* Resource);
alias PTERMINATE_ROUTINE = void function(void* Resource);
alias PIS_ALIVE_ROUTINE = BOOL function(void* Resource);
alias PLOOKS_ALIVE_ROUTINE = BOOL function(void* Resource);
alias PARBITRATE_ROUTINE = uint function(void* Resource, PQUORUM_RESOURCE_LOST LostQuorumResource);
alias PRELEASE_ROUTINE = uint function(void* Resource);
alias PRESOURCE_CONTROL_ROUTINE = uint function(void* Resource, uint ControlCode, void* InBuffer, 
                                                uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                                uint* BytesReturned);
alias PRESOURCE_TYPE_CONTROL_ROUTINE = uint function(const(PWSTR) ResourceTypeName, uint ControlCode, 
                                                     void* InBuffer, uint InBufferSize, void* OutBuffer, 
                                                     uint OutBufferSize, uint* BytesReturned);
alias POPEN_V2_ROUTINE = void* function(const(PWSTR) ResourceName, HKEY ResourceKey, ptrdiff_t ResourceHandle, 
                                        uint OpenFlags);
alias PONLINE_V2_ROUTINE = uint function(void* Resource, HANDLE* EventHandle, uint OnlineFlags, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* InBuffer, 
                                         uint InBufferSize, uint Reserved);
alias POFFLINE_V2_ROUTINE = uint function(void* Resource, const(PWSTR) DestinationNodeName, uint OfflineFlags, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* InBuffer, 
                                          uint InBufferSize, uint Reserved);
alias PCANCEL_ROUTINE = uint function(void* Resource, uint CancelFlags_RESERVED);
alias PBEGIN_RESCALL_ROUTINE = uint function(void* Resource, uint ControlCode, void* InBuffer, uint InBufferSize, 
                                             void* OutBuffer, uint OutBufferSize, uint* BytesReturned, long context, 
                                             BOOL* ReturnedAsynchronously);
alias PBEGIN_RESTYPECALL_ROUTINE = uint function(const(PWSTR) ResourceTypeName, uint ControlCode, void* InBuffer, 
                                                 uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                                 uint* BytesReturned, long context, BOOL* ReturnedAsynchronously);
alias PBEGIN_RESCALL_AS_USER_ROUTINE = uint function(void* Resource, HANDLE TokenHandle, uint ControlCode, 
                                                     void* InBuffer, uint InBufferSize, void* OutBuffer, 
                                                     uint OutBufferSize, uint* BytesReturned, long context, 
                                                     BOOL* ReturnedAsynchronously);
alias PBEGIN_RESTYPECALL_AS_USER_ROUTINE = uint function(const(PWSTR) ResourceTypeName, HANDLE TokenHandle, 
                                                         uint ControlCode, void* InBuffer, uint InBufferSize, 
                                                         void* OutBuffer, uint OutBufferSize, uint* BytesReturned, 
                                                         long context, BOOL* ReturnedAsynchronously);
alias PSTARTUP_ROUTINE = uint function(const(PWSTR) ResourceType, uint MinVersionSupported, 
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
alias PRAISE_RES_TYPE_NOTIFICATION = uint function(const(PWSTR) ResourceType, 
                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(ubyte)* pPayload, 
                                                   uint payloadSize);
alias PCHANGE_RESOURCE_PROCESS_FOR_DUMPS = uint function(ptrdiff_t resource, const(PWSTR) processName, 
                                                         uint processId, BOOL isAdd);
alias PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS = uint function(const(PWSTR) resourceTypeName, const(PWSTR) processName, 
                                                         uint processId, BOOL isAdd);
alias PSET_INTERNAL_STATE = uint function(ptrdiff_t param0, CLUSTER_RESOURCE_APPLICATION_STATE stateType, 
                                          BOOL active);
alias PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE = uint function(ptrdiff_t ResourceHandle, BOOL LockedModeEnabled, 
                                                           uint LockedModeReason, uint LockedModeFlags);
alias PREQUEST_DUMP_ROUTINE = uint function(ptrdiff_t ResourceHandle, BOOL DumpDueToCallInProgress, 
                                            uint DumpDelayInMs);
alias PSET_RESOURCE_WPR_POLICY_ROUTINE = uint function(ptrdiff_t ResourceHandle, uint WprPolicyFlags);
alias PARM_WPR_WATCHDOG_FOR_CURRENT_RESOURCE_CALL_ROUTINE = uint function(ptrdiff_t ResourceHandle, 
                                                                          ulong TimeoutInMs);
alias PSTARTUP_EX_ROUTINE = uint function(const(PWSTR) ResourceType, uint MinVersionSupported, 
                                          uint MaxVersionSupported, 
                                          CLRES_CALLBACK_FUNCTION_TABLE* MonitorCallbackFunctions, 
                                          CLRES_FUNCTION_TABLE** ResourceDllInterfaceFunctions);
alias PRESUTIL_START_RESOURCE_SERVICE = uint function(const(PWSTR) pszServiceName, SC_HANDLE* phServiceHandle);
alias PRESUTIL_VERIFY_RESOURCE_SERVICE = uint function(const(PWSTR) pszServiceName);
alias PRESUTIL_STOP_RESOURCE_SERVICE = uint function(const(PWSTR) pszServiceName);
alias PRESUTIL_VERIFY_SERVICE = uint function(SC_HANDLE hServiceHandle);
alias PRESUTIL_STOP_SERVICE = uint function(SC_HANDLE hServiceHandle);
alias PRESUTIL_CREATE_DIRECTORY_TREE = uint function(const(PWSTR) pszPath);
alias PRESUTIL_IS_PATH_VALID = BOOL function(const(PWSTR) pszPath);
alias PRESUTIL_ENUM_PROPERTIES = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR pszOutProperties, 
                                               uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_ENUM_PRIVATE_PROPERTIES = uint function(HKEY hkeyClusterKey, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR pszOutProperties, 
                                                       uint cbOutPropertiesSize, uint* pcbBytesReturned, 
                                                       uint* pcbRequired);
alias PRESUTIL_GET_PROPERTIES = uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pOutPropertyList, 
                                              uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_ALL_PROPERTIES = uint function(HKEY hkeyClusterKey, 
                                                  const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pOutPropertyList, 
                                                  uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                                                  uint* pcbRequired);
alias PRESUTIL_GET_PRIVATE_PROPERTIES = uint function(HKEY hkeyClusterKey, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pOutPropertyList, 
                                                      uint cbOutPropertyListSize, uint* pcbBytesReturned, 
                                                      uint* pcbRequired);
alias PRESUTIL_GET_PROPERTY_SIZE = uint function(HKEY hkeyClusterKey, 
                                                 const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                                                 uint* pcbOutPropertyListSize, uint* pnPropertyCount);
alias PRESUTIL_GET_PROPERTY = uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void** pOutPropertyItem, 
                                            uint* pcbOutPropertyItemSize);
alias PRESUTIL_VERIFY_PROPERTY_TABLE = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                                                     BOOL bAllowUnknownProperties, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pInPropertyList, 
                                                     uint cbInPropertyListSize, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_TABLE = uint function(HKEY hkeyClusterKey, 
                                                  const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                                                  BOOL bAllowUnknownProperties, 
                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* pInPropertyList, 
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
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* pInPropertyList, 
                                                      uint cbInPropertyListSize);
alias PRESUTIL_GET_PROPERTIES_TO_PARAMETER_BLOCK = uint function(HKEY hkeyClusterKey, 
                                                                 const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                                 ubyte* pOutParams, BOOL bCheckForRequiredProperties, 
                                                                 PWSTR* pszNameOfPropInError);
alias PRESUTIL_PROPERTY_LIST_FROM_PARAMETER_BLOCK = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pOutPropertyList, 
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
alias PRESUTIL_SET_PRIVATE_PROPERTY_LIST = uint function(HKEY hkeyClusterKey, 
                                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pInPropertyList, 
                                                         uint cbInPropertyListSize);
alias PRESUTIL_VERIFY_PRIVATE_PROPERTY_LIST = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pInPropertyList, 
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
                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(ubyte)* pbNewValue, 
                                                uint cbNewValueSize, 
                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte** ppbOutValue, 
                                                uint* pcbOutValueSize);
alias PRESUTIL_SET_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                            const(PWSTR) pszNewValue, PWSTR* ppszOutString);
alias PRESUTIL_SET_EXPAND_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                                   const(PWSTR) pszNewValue, PWSTR* ppszOutString);
alias PRESUTIL_SET_MULTI_SZ_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(PWSTR) pszNewValue, 
                                                  uint cbNewValueSize, PWSTR* ppszOutValue, uint* pcbOutValueSize);
alias PRESUTIL_SET_DWORD_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, uint dwNewValue, 
                                               uint* pdwOutValue);
alias PRESUTIL_SET_QWORD_VALUE = uint function(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ulong qwNewValue, 
                                               ulong* pqwOutValue);
alias PRESUTIL_GET_BINARY_PROPERTY = uint function(ubyte** ppbOutValue, uint* pcbOutValueSize, 
                                                   const(CLUSPROP_BINARY)* pValueStruct, 
                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(ubyte)* pbOldValue, 
                                                   uint cbOldValueSize, 
                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte** ppPropertyList, 
                                                   uint* pcbPropertyListSize);
alias PRESUTIL_GET_SZ_PROPERTY = uint function(PWSTR* ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, 
                                               const(PWSTR) pszOldValue, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte** ppPropertyList, 
                                               uint* pcbPropertyListSize);
alias PRESUTIL_GET_MULTI_SZ_PROPERTY = uint function(PWSTR* ppszOutValue, uint* pcbOutValueSize, 
                                                     const(CLUSPROP_SZ)* pValueStruct, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PWSTR) pszOldValue, 
                                                     uint cbOldValueSize, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte** ppPropertyList, 
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
alias PRESUTIL_GET_ENVIRONMENT_WITH_NET_NAME = void* function(HRESOURCE hResource);
alias PRESUTIL_FREE_ENVIRONMENT = uint function(void* lpEnvironment);
alias PRESUTIL_EXPAND_ENVIRONMENT_STRINGS = PWSTR function(const(PWSTR) pszSrc);
alias PRESUTIL_SET_RESOURCE_SERVICE_ENVIRONMENT = uint function(const(PWSTR) pszServiceName, HRESOURCE hResource, 
                                                                PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                ptrdiff_t hResourceHandle);
alias PRESUTIL_REMOVE_RESOURCE_SERVICE_ENVIRONMENT = uint function(const(PWSTR) pszServiceName, 
                                                                   PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                   ptrdiff_t hResourceHandle);
alias PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS = uint function(const(PWSTR) pszServiceName, 
                                                                     SC_HANDLE schSCMHandle, SC_HANDLE* phService, 
                                                                     PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                     ptrdiff_t hResourceHandle);
alias PRESUTIL_FIND_SZ_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                PWSTR* pszPropertyValue);
alias PRESUTIL_FIND_EXPAND_SZ_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                       uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                       PWSTR* pszPropertyValue);
alias PRESUTIL_FIND_EXPANDED_SZ_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                         uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                         PWSTR* pszPropertyValue);
alias PRESUTIL_FIND_DWORD_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                   uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                   uint* pdwPropertyValue);
alias PRESUTIL_FIND_BINARY_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                    uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                    ubyte** pbPropertyValue, uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_MULTI_SZ_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                      uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                      PWSTR* pszPropertyValue, uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_LONG_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                  uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                  int* plPropertyValue);
alias PRESUTIL_FIND_ULARGEINTEGER_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                           uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                           ulong* plPropertyValue);
alias PRESUTIL_FIND_FILETIME_PROPERTY = uint function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                                      uint cbPropertyListSize, const(PWSTR) pszPropertyName, 
                                                      FILETIME* pftPropertyValue);
alias PWORKER_START_ROUTINE = uint function(CLUS_WORKER* pWorker, void* lpThreadParameter);
alias PCLUSAPI_CLUS_WORKER_CREATE = uint function(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, 
                                                  void* lpParameter);
alias PCLUSAPIClusWorkerCheckTerminate = BOOL function(CLUS_WORKER* lpWorker);
alias PCLUSAPI_CLUS_WORKER_TERMINATE = void function(CLUS_WORKER* lpWorker);
alias LPRESOURCE_CALLBACK = uint function(HRESOURCE param0, HRESOURCE param1, void* param2);
alias LPRESOURCE_CALLBACK_EX = uint function(HCLUSTER param0, HRESOURCE param1, HRESOURCE param2, void* param3);
alias LPGROUP_CALLBACK_EX = uint function(HCLUSTER param0, HGROUP param1, HGROUP param2, void* param3);
alias LPNODE_CALLBACK = uint function(HCLUSTER param0, HNODE param1, CLUSTER_NODE_STATE param2, void* param3);
alias PRESUTIL_RESOURCES_EQUAL = BOOL function(HRESOURCE hSelf, HRESOURCE hResource);
alias PRESUTIL_RESOURCE_TYPES_EQUAL = BOOL function(const(PWSTR) lpszResourceTypeName, HRESOURCE hResource);
alias PRESUTIL_IS_RESOURCE_CLASS_EQUAL = BOOL function(CLUS_RESOURCE_CLASS_INFO* prci, HRESOURCE hResource);
alias PRESUTIL_ENUM_RESOURCES = uint function(HRESOURCE hSelf, const(PWSTR) lpszResTypeName, 
                                              LPRESOURCE_CALLBACK pResCallBack, void* pParameter);
alias PRESUTIL_ENUM_RESOURCES_EX = uint function(HCLUSTER hCluster, HRESOURCE hSelf, const(PWSTR) lpszResTypeName, 
                                                 LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY = HRESOURCE function(HANDLE hSelf, const(PWSTR) lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME = HRESOURCE function(HCLUSTER hCluster, HANDLE hSelf, 
                                                                    const(PWSTR) lpszResourceType, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS = HRESOURCE function(HCLUSTER hCluster, HANDLE hSelf, 
                                                                     CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY = HRESOURCE function(const(PWSTR) lpszResourceName, 
                                                                 const(PWSTR) lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENTIP_ADDRESS_PROPS = uint function(HRESOURCE hResource, PWSTR pszAddress, 
                                                                      uint* pcchAddress, PWSTR pszSubnetMask, 
                                                                      uint* pcchSubnetMask, PWSTR pszNetwork, 
                                                                      uint* pcchNetwork);
alias PRESUTIL_FIND_DEPENDENT_DISK_RESOURCE_DRIVE_LETTER = uint function(HCLUSTER hCluster, HRESOURCE hResource, 
                                                                         PWSTR pszDriveLetter, uint* pcchDriveLetter);
alias PRESUTIL_TERMINATE_SERVICE_PROCESS_FROM_RES_DLL = uint function(uint dwServicePid, BOOL bOffline, 
                                                                      uint* pdwResourceState, 
                                                                      PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                      ptrdiff_t hResourceHandle);
alias PRESUTIL_GET_PROPERTY_FORMATS = uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pOutPropertyFormatList, 
                                                    uint cbPropertyFormatListSize, uint* pcbBytesReturned, 
                                                    uint* pcbRequired);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES = uint function(HCLUSTER hCluster, HRESOURCE* phClusterNameResource, 
                                                          HRESOURCE* phClusterIPAddressResource, 
                                                          HRESOURCE* phClusterQuorumResource);
alias PRESUTIL_GET_RESOURCE_NAME = uint function(HRESOURCE hResource, PWSTR pszResourceName, 
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
                                                                        SC_HANDLE schSCMHandle, SC_HANDLE* phService, 
                                                                        uint dwDesiredAccess, 
                                                                        PLOG_EVENT_ROUTINE pfnLogEvent, 
                                                                        ptrdiff_t hResourceHandle);
alias PRESUTIL_ENUM_RESOURCES_EX2 = uint function(HCLUSTER hCluster, HRESOURCE hSelf, const(PWSTR) lpszResTypeName, 
                                                  LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter, 
                                                  uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_EX = HRESOURCE function(HANDLE hSelf, const(PWSTR) lpszResourceType, 
                                                               uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME_EX = HRESOURCE function(HCLUSTER hCluster, HANDLE hSelf, 
                                                                       const(PWSTR) lpszResourceType, BOOL bRecurse, 
                                                                       uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS_EX = HRESOURCE function(HCLUSTER hCluster, HANDLE hSelf, 
                                                                        CLUS_RESOURCE_CLASS_INFO* prci, 
                                                                        BOOL bRecurse, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY_EX = HRESOURCE function(const(PWSTR) lpszResourceName, 
                                                                    const(PWSTR) lpszResourceType, 
                                                                    uint dwDesiredAccess);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES_EX = uint function(HCLUSTER hClusterIn, 
                                                             HRESOURCE* phClusterNameResourceOut, 
                                                             HRESOURCE* phClusterIPAddressResourceOut, 
                                                             HRESOURCE* phClusterQuorumResourceOut, 
                                                             uint dwDesiredAccess);
alias POPEN_CLUSTER_CRYPT_PROVIDER = HCLUSCRYPTPROVIDER function(const(PWSTR) lpszResource, byte* lpszProvider, 
                                                                 uint dwType, uint dwFlags);
alias POPEN_CLUSTER_CRYPT_PROVIDEREX = HCLUSCRYPTPROVIDER function(const(PWSTR) lpszResource, 
                                                                   const(PWSTR) lpszKeyname, byte* lpszProvider, 
                                                                   uint dwType, uint dwFlags);
alias PCLOSE_CLUSTER_CRYPT_PROVIDER = uint function(HCLUSCRYPTPROVIDER hClusCryptProvider);
alias PCLUSTER_ENCRYPT = uint function(HCLUSCRYPTPROVIDER hClusCryptProvider, ubyte* pData, uint cbData, 
                                       ubyte** ppData, uint* pcbData);
alias PCLUSTER_DECRYPT = uint function(HCLUSCRYPTPROVIDER hClusCryptProvider, ubyte* pCryptInput, 
                                       uint cbCryptInput, ubyte** ppCryptOutput, uint* pcbCryptOutput);
alias PFREE_CLUSTER_CRYPT = uint function(void* pCryptInfo);
alias PRES_UTIL_VERIFY_SHUTDOWN_SAFE = uint function(uint flags, uint reason, uint* pResult);
alias PREGISTER_APPINSTANCE = uint function(HANDLE ProcessHandle, GUID* AppInstanceId, 
                                            BOOL ChildrenInheritAppInstance);
alias PREGISTER_APPINSTANCE_VERSION = uint function(GUID* AppInstanceId, ulong InstanceVersionHigh, 
                                                    ulong InstanceVersionLow);
alias PQUERY_APPINSTANCE_VERSION = uint function(GUID* AppInstanceId, ulong* InstanceVersionHigh, 
                                                 ulong* InstanceVersionLow, NTSTATUS* VersionStatus);
alias PRESET_ALL_APPINSTANCE_VERSIONS = uint function();
alias SET_APP_INSTANCE_CSV_FLAGS = uint function(HANDLE ProcessHandle, uint Mask, uint Flags);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_resource_class_info
struct CLUSPROP_RESOURCE_CLASS_INFO
{
    CLUSPROP_VALUE Base;
    CLUS_RESOURCE_CLASS_INFO Base2;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT
{
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME Base;
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_NAME Base2;
}

struct CLUSTER_SHARED_VOLUME_RENAME_GUID_INPUT
{
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME Base;
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_GUID_NAME Base2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_partition_info
struct CLUSPROP_PARTITION_INFO
{
    CLUSPROP_VALUE      Base;
    CLUS_PARTITION_INFO Base2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_partition_info_ex
struct CLUSPROP_PARTITION_INFO_EX
{
    CLUSPROP_VALUE Base;
    CLUS_PARTITION_INFO_EX Base2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_partition_info_ex2
struct CLUSPROP_PARTITION_INFO_EX2
{
    CLUSPROP_PARTITION_INFO_EX Base;
    CLUS_PARTITION_INFO_EX2 Base2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_ftset_info
struct CLUSPROP_FTSET_INFO
{
    CLUSPROP_VALUE  Base;
    CLUS_FTSET_INFO Base2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_scsi_address
struct CLUSPROP_SCSI_ADDRESS
{
    CLUSPROP_VALUE    Base;
    CLUS_SCSI_ADDRESS Base2;
}

struct HCHANGE
{
    ptrdiff_t Value;
}

struct HCLUSCRYPTPROVIDER
{
    ptrdiff_t Value;
}

struct HCLUSENUM
{
    ptrdiff_t Value;
}

struct HCLUSENUMEX
{
    ptrdiff_t Value;
}

struct HCLUSTER
{
    ptrdiff_t Value;
}

struct HGROUP
{
    ptrdiff_t Value;
}

struct HGROUPENUM
{
    ptrdiff_t Value;
}

struct HGROUPENUMEX
{
    ptrdiff_t Value;
}

struct HGROUPSET
{
    ptrdiff_t Value;
}

struct HGROUPSETENUM
{
    ptrdiff_t Value;
}

struct HNETINTERFACE
{
    ptrdiff_t Value;
}

struct HNETINTERFACEENUM
{
    ptrdiff_t Value;
}

struct HNETWORK
{
    ptrdiff_t Value;
}

struct HNETWORKENUM
{
    ptrdiff_t Value;
}

struct HNODE
{
    ptrdiff_t Value;
}

struct HNODEENUM
{
    ptrdiff_t Value;
}

struct HNODEENUMEX
{
    ptrdiff_t Value;
}

struct HREGBATCH
{
    ptrdiff_t Value;
}

struct HREGBATCHNOTIFICATION
{
    ptrdiff_t Value;
}

struct HREGBATCHPORT
{
    ptrdiff_t Value;
}

struct HREGREADBATCH
{
    ptrdiff_t Value;
}

struct HREGREADBATCHREPLY
{
    ptrdiff_t Value;
}

struct HRESENUM
{
    ptrdiff_t Value;
}

struct HRESENUMEX
{
    ptrdiff_t Value;
}

struct HRESOURCE
{
    ptrdiff_t Value;
}

struct HRESTYPEENUM
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusterversioninfo_nt4
struct CLUSTERVERSIONINFO_NT4
{
    uint      dwVersionInfoSize;
    ushort    MajorVersion;
    ushort    MinorVersion;
    ushort    BuildNumber;
    wchar[64] szVendorId;
    wchar[64] szCSDVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusterversioninfo
struct CLUSTERVERSIONINFO
{
    uint      dwVersionInfoSize;
    ushort    MajorVersion;
    ushort    MinorVersion;
    ushort    BuildNumber;
    wchar[64] szVendorId;
    wchar[64] szCSDVersion;
    uint      dwClusterHighestVersion;
    uint      dwClusterLowestVersion;
    uint      dwFlags;
    uint      dwReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_starting_params
struct CLUS_STARTING_PARAMS
{
    uint dwSize;
    BOOL bForm;
    BOOL bFirst;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusctl_resource_state_change_reason_struct
struct CLUSCTL_RESOURCE_STATE_CHANGE_REASON_STRUCT
{
    uint dwSize;
    uint dwVersion;
    CLUSTER_RESOURCE_STATE_CHANGE_REASON eReason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_batch_command
struct CLUSTER_BATCH_COMMAND
{
    CLUSTER_REG_COMMAND Command;
    uint                dwOptions;
    const(PWSTR)        wzName;
    const(ubyte)*       lpData;
    uint                cbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_read_batch_command
struct CLUSTER_READ_BATCH_COMMAND
{
    CLUSTER_REG_COMMAND Command;
    uint                dwOptions;
    const(PWSTR)        wzSubkeyName;
    const(PWSTR)        wzValueName;
    const(ubyte)*       lpData;
    uint                cbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-cluster_enum_item
struct CLUSTER_ENUM_ITEM
{
    uint  dwVersion;
    uint  dwType;
    uint  cbId;
    PWSTR lpszId;
    uint  cbName;
    PWSTR lpszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-cluster_create_group_info
struct CLUSTER_CREATE_GROUP_INFO
{
    uint           dwVersion;
    CLUSGROUP_TYPE groupType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_validate_path
struct CLUSTER_VALIDATE_PATH
{
    wchar[1] szPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_validate_directory
struct CLUSTER_VALIDATE_DIRECTORY
{
    wchar[1] szPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_validate_netname
struct CLUSTER_VALIDATE_NETNAME
{
    wchar[1] szNetworkName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_validate_csv_filename
struct CLUSTER_VALIDATE_CSV_FILENAME
{
    wchar[1] szFileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_set_password_status
struct CLUSTER_SET_PASSWORD_STATUS
{
    uint    NodeId;
    BOOLEAN SetAttempted;
    uint    ReturnStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_ip_entry
struct CLUSTER_IP_ENTRY
{
    const(PWSTR) lpszIpAddress;
    uint         dwPrefixLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-create_cluster_config
struct CREATE_CLUSTER_CONFIG
{
    uint              dwVersion;
    const(PWSTR)      lpszClusterName;
    uint              cNodes;
    const(PWSTR)*     ppszNodeNames;
    uint              cIpEntries;
    CLUSTER_IP_ENTRY* pIpEntries;
    BOOLEAN           fEmptyCluster;
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
    const(PWSTR)      pszUserName;
    const(PWSTR)      pszPassword;
    const(PWSTR)      pszDomain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-create_cluster_name_account
struct CREATE_CLUSTER_NAME_ACCOUNT
{
    uint         dwVersion;
    const(PWSTR) lpszClusterName;
    uint         dwFlags;
    const(PWSTR) pszUserName;
    const(PWSTR) pszPassword;
    const(PWSTR) pszDomain;
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
    BOOLEAN      bUpgradeVCOs;
}

struct REPAIR_CLUSTER_NAME_ACCOUNT_CONFIG
{
    uint         dwVersion;
    uint         dwFlags;
    const(PWSTR) pszUserName;
    const(PWSTR) pszPassword;
    const(PWSTR) pszDomain;
}

struct CLUSAPI_REASON_HANDLER
{
    void* lpParameter;
    PCLUSAPI_PFN_REASON_HANDLER pfnHandler;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-notify_filter_and_type
struct NOTIFY_FILTER_AND_TYPE
{
    uint dwObjectType;
    long FilterFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-cluster_membership_info
struct CLUSTER_MEMBERSHIP_INFO
{
    BOOL     HasQuorum;
    uint     UpnodesSize;
    ubyte[1] Upnodes; // Flexible array
}

struct CLUSTER_AVAILABILITY_SET_CONFIG
{
    uint dwVersion;
    uint dwUpdateDomains;
    uint dwFaultDomains;
    BOOL bReserveSpareNode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-cluster_group_enum_item
struct CLUSTER_GROUP_ENUM_ITEM
{
    uint                dwVersion;
    uint                cbId;
    PWSTR               lpszId;
    uint                cbName;
    PWSTR               lpszName;
    CLUSTER_GROUP_STATE state;
    uint                cbOwnerNode;
    PWSTR               lpszOwnerNode;
    uint                dwFlags;
    uint                cbProperties;
    void*               pProperties;
    uint                cbRoProperties;
    void*               pRoProperties;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-cluster_resource_enum_item
struct CLUSTER_RESOURCE_ENUM_ITEM
{
    uint  dwVersion;
    uint  cbId;
    PWSTR lpszId;
    uint  cbName;
    PWSTR lpszName;
    uint  cbOwnerGroupName;
    PWSTR lpszOwnerGroupName;
    uint  cbOwnerGroupId;
    PWSTR lpszOwnerGroupId;
    uint  cbProperties;
    void* pProperties;
    uint  cbRoProperties;
    void* pRoProperties;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-group_failure_info
struct GROUP_FAILURE_INFO
{
    uint dwFailoverAttemptsRemaining;
    uint dwFailoverPeriodRemaining;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-group_failure_info_buffer
struct GROUP_FAILURE_INFO_BUFFER
{
    uint               dwVersion;
    GROUP_FAILURE_INFO Info;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-resource_failure_info
struct RESOURCE_FAILURE_INFO
{
    uint dwRestartAttemptsRemaining;
    uint dwRestartPeriodRemaining;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/ns-msclus-resource_failure_info_buffer
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

struct NodeSriovInfo
{
    uint VFTotal;
    uint VFUsed;
    uint QPTotal;
    uint QPUsed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_syntax
union CLUSPROP_SYNTAX
{
    uint dw;
    struct
    {
        ushort wFormat;
        ushort wType;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_value
struct CLUSPROP_VALUE
{
    CLUSPROP_SYNTAX Syntax;
    uint            cbLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_binary
struct CLUSPROP_BINARY
{
    CLUSPROP_VALUE Base;
    ubyte[1]       rgb;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_word
struct CLUSPROP_WORD
{
    CLUSPROP_VALUE Base;
    ushort         w;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_dword
struct CLUSPROP_DWORD
{
    CLUSPROP_VALUE Base;
    uint           dw;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_long
struct CLUSPROP_LONG
{
    CLUSPROP_VALUE Base;
    int            l;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_sz
struct CLUSPROP_SZ
{
    CLUSPROP_VALUE Base;
    wchar[1]       sz;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_ularge_integer
struct CLUSPROP_ULARGE_INTEGER
{
    CLUSPROP_VALUE Base;
    ulong          li;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_large_integer
struct CLUSPROP_LARGE_INTEGER
{
    CLUSPROP_VALUE Base;
    long           li;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_security_descriptor
struct CLUSPROP_SECURITY_DESCRIPTOR
{
    CLUSPROP_VALUE Base;
    union
    {
        SECURITY_DESCRIPTOR_RELATIVE sd;
        ubyte[1] rgbSecurityDescriptor;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_filetime
struct CLUSPROP_FILETIME
{
    CLUSPROP_VALUE Base;
    FILETIME       ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_resource_class_info
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
        ulong li;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_resource_class
struct CLUSPROP_RESOURCE_CLASS
{
    CLUSPROP_VALUE Base;
    CLUSTER_RESOURCE_CLASS rc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_required_dependency
union CLUSPROP_REQUIRED_DEPENDENCY
{
    CLUSPROP_VALUE Value;
    CLUSPROP_RESOURCE_CLASS ResClass;
    CLUSPROP_SZ    ResTypeName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_force_quorum_info
struct CLUS_FORCE_QUORUM_INFO
{
    uint     dwSize;
    uint     dwNodeBitMask;
    uint     dwMaxNumberofNodes;
    wchar[1] multiszNodeList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_partition_info
struct CLUS_PARTITION_INFO
{
    uint       dwFlags;
    wchar[260] szDeviceName;
    wchar[260] szVolumeLabel;
    uint       dwSerialNumber;
    uint       rgdwMaximumComponentLength;
    uint       dwFileSystemFlags;
    wchar[32]  szFileSystem;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_partition_info_ex
struct CLUS_PARTITION_INFO_EX
{
    uint       dwFlags;
    wchar[260] szDeviceName;
    wchar[260] szVolumeLabel;
    uint       dwSerialNumber;
    uint       rgdwMaximumComponentLength;
    uint       dwFileSystemFlags;
    wchar[32]  szFileSystem;
    ulong      TotalSizeInBytes;
    ulong      FreeSizeInBytes;
    uint       DeviceNumber;
    uint       PartitionNumber;
    GUID       VolumeGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_partition_info_ex2
struct CLUS_PARTITION_INFO_EX2
{
    GUID       GptPartitionId;
    wchar[260] szPartitionName;
    uint       EncryptionFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_csv_volume_info
struct CLUS_CSV_VOLUME_INFO
{
    ulong      VolumeOffset;
    uint       PartitionNumber;
    CLUSTER_CSV_VOLUME_FAULT_STATE FaultState;
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    wchar[260] szVolumeFriendlyName;
    wchar[50]  szVolumeName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_csv_volume_name
struct CLUS_CSV_VOLUME_NAME
{
    long       VolumeOffset;
    wchar[260] szVolumeName;
    wchar[263] szRootPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-cluster_shared_volume_state_info
struct CLUSTER_SHARED_VOLUME_STATE_INFO
{
    wchar[260] szVolumeName;
    wchar[260] szNodeName;
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
}

struct CLUSTER_SHARED_VOLUME_STATE_INFO_EX
{
    wchar[260] szVolumeName;
    wchar[260] szNodeName;
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
    wchar[260] szVolumeFriendlyName;
    ulong      RedirectedIOReason;
    ulong      VolumeRedirectedIOReason;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME
{
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE InputType;
    union
    {
        ulong      VolumeOffset;
        wchar[260] VolumeId;
        wchar[260] VolumeName;
        wchar[50]  VolumeGuid;
    }
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_NAME
{
    wchar[260] NewVolumeName;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_GUID_NAME
{
    wchar[260] NewVolumeName;
    wchar[50]  NewVolumeGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_chkdsk_info
struct CLUS_CHKDSK_INFO
{
    uint     PartitionNumber;
    uint     ChkdskState;
    uint     FileIdCount;
    ulong[1] FileIdList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_disk_number_info
struct CLUS_DISK_NUMBER_INFO
{
    uint DiskNumber;
    uint BytesPerSector;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_shared_volume_backup_mode
struct CLUS_SHARED_VOLUME_BACKUP_MODE
{
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    uint       DelayTimerInSecs;
    wchar[260] VolumeName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_ftset_info
struct CLUS_FTSET_INFO
{
    uint dwRootSignature;
    uint dwFtType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_scsi_address
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_netname_vs_token_info
struct CLUS_NETNAME_VS_TOKEN_INFO
{
    uint ProcessID;
    uint DesiredAccess;
    BOOL InheritHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_netname_pwd_info
struct CLUS_NETNAME_PWD_INFO
{
    uint       Flags;
    wchar[16]  Password;
    wchar[258] CreatingDC;
    wchar[64]  ObjectGuid;
}

struct CLUS_NETNAME_PWD_INFOEX
{
    uint       Flags;
    wchar[128] Password;
    wchar[258] CreatingDC;
    wchar[64]  ObjectGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_dnn_leader_status
struct CLUS_DNN_LEADER_STATUS
{
    BOOL IsOnline;
    BOOL IsFileServerPresent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_dnn_sodafs_clone_status
struct CLUS_DNN_SODAFS_CLONE_STATUS
{
    uint NodeId;
    CLUSTER_RESOURCE_STATE Status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_netname_ip_info_entry
struct CLUS_NETNAME_IP_INFO_ENTRY
{
    uint     NodeId;
    uint     AddressSize;
    ubyte[1] Address; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_netname_ip_info_for_multichannel
struct CLUS_NETNAME_IP_INFO_FOR_MULTICHANNEL
{
    wchar[64] szName;
    uint      NumEntries;
    CLUS_NETNAME_IP_INFO_ENTRY[1] IpInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_maintenance_mode_info
struct CLUS_MAINTENANCE_MODE_INFO
{
    BOOL InMaintenance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_csv_maintenance_mode_info
struct CLUS_CSV_MAINTENANCE_MODE_INFO
{
    BOOL       InMaintenance;
    wchar[260] VolumeName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_maintenance_mode_infoex
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
    ubyte[1] ExtraParameter; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_storage_set_driveletter
struct CLUS_STORAGE_SET_DRIVELETTER
{
    uint PartitionNumber;
    uint DriveLetterMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_storage_get_available_driveletters
struct CLUS_STORAGE_GET_AVAILABLE_DRIVELETTERS
{
    uint AvailDrivelettersMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_storage_remap_driveletter
struct CLUS_STORAGE_REMAP_DRIVELETTER
{
    uint CurrentDriveLetterMask;
    uint TargetDriveLetterMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clus_provider_state_change_info
struct CLUS_PROVIDER_STATE_CHANGE_INFO
{
    uint     dwSize;
    CLUSTER_RESOURCE_STATE resourceState;
    wchar[1] szProviderId; // Flexible array
}

struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_INPUT
{
    wchar[16] FileServerName;
}

struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_OUTPUT
{
    wchar[260] FileServerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_list
struct CLUSPROP_LIST
{
    uint        nPropertyCount;
    CLUSPROP_SZ PropertyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-fileshare_change
struct FILESHARE_CHANGE
{
    FILESHARE_CHANGE_ENUM Change;
    wchar[84] ShareName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-fileshare_change_list
struct FILESHARE_CHANGE_LIST
{
    uint                NumEntries;
    FILESHARE_CHANGE[1] ChangeEntry; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusctl_group_get_last_move_time_output
struct CLUSCTL_GROUP_GET_LAST_MOVE_TIME_OUTPUT
{
    ulong      GetTickCount64;
    SYSTEMTIME GetSystemTime;
    uint       NodeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-clusprop_buffer_helper
union CLUSPROP_BUFFER_HELPER
{
    ubyte*             pb;
    ushort*            pw;
    uint*              pdw;
    int*               pl;
    PWSTR              psz;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_replicated_partition_info
struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO
{
    ulong PartitionOffset;
    uint  Capabilities;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_replicated_partition_array
struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_ARRAY
{
    uint Count;
    SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO[1] PartitionArray; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_query_eligible_logdisks
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_LOGDISKS
{
    GUID    DataDiskGuid;
    BOOLEAN IncludeOfflineDisks;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_query_eligible_target_datadisks
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_TARGET_DATADISKS
{
    GUID    SourceDataDiskGuid;
    GUID    TargetReplicationGroupGuid;
    BOOLEAN SkipConnectivityCheck;
    BOOLEAN IncludeOfflineDisks;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_query_eligible_source_datadisks
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_SOURCE_DATADISKS
{
    GUID    DataDiskGuid;
    BOOLEAN IncludeAvailableStoargeDisks;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_disk_info
struct SR_RESOURCE_TYPE_DISK_INFO
{
    SR_DISK_REPLICATION_ELIGIBLE Reason;
    GUID DiskGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_eligible_disks_result
struct SR_RESOURCE_TYPE_ELIGIBLE_DISKS_RESULT
{
    ushort Count;
    SR_RESOURCE_TYPE_DISK_INFO[1] DiskInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_replicated_disk
struct SR_RESOURCE_TYPE_REPLICATED_DISK
{
    SR_REPLICATED_DISK_TYPE Type;
    GUID       ClusterDiskResourceGuid;
    GUID       ReplicationGroupId;
    wchar[260] ReplicationGroupName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/clusapi/ns-clusapi-sr_resource_type_replicated_disks_result
struct SR_RESOURCE_TYPE_REPLICATED_DISKS_RESULT
{
    ushort Count;
    SR_RESOURCE_TYPE_REPLICATED_DISK[1] ReplicatedDisks; // Flexible array
}

struct SR_RESOURCE_TYPE_ADD_REPLICATION_GROUP
{
    wchar[260] ReplicationGroupName;
    wchar[260] Description;
    wchar[260] LogPath;
    ulong      MaxLogSizeInBytes;
    ushort     LogType;
    uint       ReplicationMode;
    uint       MinimumPartnersInSync;
    BOOLEAN    EnableWriteConsistency;
    BOOLEAN    EnableEncryption;
    BOOLEAN    EnableCompression;
    wchar[260] CertificateThumbprint;
    uint       VolumeNameCount;
    wchar[260] VolumeNames;
}

struct SR_RESOURCE_TYPE_ADD_REPLICATION_GROUP_RESULT
{
    uint       Result;
    wchar[260] ErrorString;
}

struct CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INPUT
{
    uint dwFlags;
    GUID guidPoolFilter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-resource_status
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-clres_v1_functions
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-clres_v2_functions
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-clres_v3_functions
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-clres_v4_functions
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-clres_function_table
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-resutil_largeint_data
struct RESUTIL_LARGEINT_DATA
{
    long Default;
    long Minimum;
    long Maximum;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-resutil_ulargeint_data
struct RESUTIL_ULARGEINT_DATA
{
    ulong Default;
    ulong Minimum;
    ulong Maximum;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-resutil_filetime_data
struct RESUTIL_FILETIME_DATA
{
    FILETIME Default;
    FILETIME Minimum;
    FILETIME Maximum;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-resutil_property_item
struct RESUTIL_PROPERTY_ITEM
{
    PWSTR Name;
    PWSTR KeyName;
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
    uint  Minimum;
    uint  Maximum;
    uint  Flags;
    uint  Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-clres_callback_function_table
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
    PREQUEST_DUMP_ROUTINE RequestDump;
    PSET_RESOURCE_WPR_POLICY_ROUTINE SetResourceWprPolicy;
    PARM_WPR_WATCHDOG_FOR_CURRENT_RESOURCE_CALL_ROUTINE ArmWprWatchdogForCurrentResourceCall;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-monitor_state
struct MONITOR_STATE
{
    long   LastUpdate;
    RESOURCE_MONITOR_STATE State;
    HANDLE ActiveResource;
    BOOL   ResmonStop;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-post_upgrade_version_info
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
    PWSTR Id;
    uint  ErrorType;
    uint  ErrorCode;
    PWSTR Description;
    PWSTR Provider;
    uint  Flags;
    uint  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-cluster_health_fault_array
struct CLUSTER_HEALTH_FAULT_ARRAY
{
    uint numFaults;
    CLUSTER_HEALTH_FAULT* faults;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-clus_worker
struct CLUS_WORKER
{
    HANDLE hThread;
    BOOL   Terminate;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-witnesstagupdatehelper
struct WitnessTagUpdateHelper
{
    int             Version;
    PaxosTagCStruct paxosToSet;
    PaxosTagCStruct paxosToValidate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/ns-resapi-witnesstaghelper
struct WitnessTagHelper
{
    int             Version;
    PaxosTagCStruct paxosToValidate;
}

// Functions

@DllImport("CLUSAPI.dll")
CLUSAPI_REASON_HANDLER* ClusapiSetReasonHandler(CLUSAPI_REASON_HANDLER* lpHandler);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetNodeClusterState(const(PWSTR) lpszNodeName, uint* pdwClusterState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER OpenCluster(const(PWSTR) lpszClusterName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER OpenClusterEx(const(PWSTR) lpszClusterName, uint DesiredAccess, uint* GrantedAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseCluster(HCLUSTER hCluster);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterName(HCLUSTER hCluster, const(PWSTR) lpszNewClusterName);

@DllImport("CLUSAPI.dll")
uint SetClusterNameEx(HCLUSTER hCluster, const(PWSTR) lpszNewClusterName, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterInformation(HCLUSTER hCluster, PWSTR lpszClusterName, uint* lpcchClusterName, 
                           CLUSTERVERSIONINFO* lpClusterInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterQuorumResource(HCLUSTER hCluster, PWSTR lpszResourceName, uint* lpcchResourceName, 
                              PWSTR lpszDeviceName, uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterQuorumResource(HRESOURCE hResource, const(PWSTR) lpszDeviceName, uint dwMaxQuoLogSize);

@DllImport("CLUSAPI.dll")
uint SetClusterQuorumResourceEx(HRESOURCE hResource, const(PWSTR) lpszDeviceName, uint dwMaxQuorumLogSize, 
                                const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("CLUSAPI.dll")
uint BackupClusterDatabase(HCLUSTER hCluster, const(PWSTR) lpszPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("CLUSAPI.dll")
uint RestoreClusterDatabase(const(PWSTR) lpszPathName, BOOL bForce, const(PWSTR) lpszQuorumDriveLetter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterNetworkPriorityOrder(HCLUSTER hCluster, uint NetworkCount, HNETWORK* NetworkList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterServiceAccountPassword(const(PWSTR) lpszClusterName, const(PWSTR) lpszNewPassword, uint dwFlags, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/CLUSTER_SET_PASSWORD_STATUS* lpReturnStatusBuffer, 
                                      uint* lpcbReturnStatusBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterControl(HCLUSTER hCluster, HNODE hHostNode, uint dwControlCode, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                    uint nInBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                    uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterControlEx(HCLUSTER hCluster, HNODE hHostNode, uint dwControlCode, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                      uint nInBufferSize, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                      uint nOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterUpgradeFunctionalLevel(HCLUSTER hCluster, BOOL perform, 
                                   PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
HCHANGE CreateClusterNotifyPortV2(HCHANGE hChange, HCLUSTER hCluster, NOTIFY_FILTER_AND_TYPE* Filters, 
                                  uint dwFilterCount, size_t dwNotifyKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint RegisterClusterNotifyV2(HCHANGE hChange, NOTIFY_FILTER_AND_TYPE Filter, HANDLE hObject, size_t dwNotifyKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint GetNotifyEventHandle(HCHANGE hChange, HANDLE* lphTargetEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterNotifyV2(HCHANGE hChange, size_t* lpdwNotifyKey, NOTIFY_FILTER_AND_TYPE* pFilterAndType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* buffer, 
                        uint* lpbBufferSize, PWSTR lpszObjectId, uint* lpcchObjectId, PWSTR lpszParentId, 
                        uint* lpcchParentId, PWSTR lpszName, uint* lpcchName, PWSTR lpszType, uint* lpcchType, 
                        uint dwMilliseconds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCHANGE CreateClusterNotifyPort(HCHANGE hChange, HCLUSTER hCluster, uint dwFilter, size_t dwNotifyKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint RegisterClusterNotify(HCHANGE hChange, uint dwFilterType, HANDLE hObject, size_t dwNotifyKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterNotify(HCHANGE hChange, size_t* lpdwNotifyKey, uint* lpdwFilterType, PWSTR lpszName, 
                      uint* lpcchName, uint dwMilliseconds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseClusterNotifyPort(HCHANGE hChange);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSENUM ClusterOpenEnum(HCLUSTER hCluster, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGetEnumCount(HCLUSENUM hEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterEnum(HCLUSENUM hEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterCloseEnum(HCLUSENUM hEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSENUMEX ClusterOpenEnumEx(HCLUSTER hCluster, uint dwType, void* pOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGetEnumCountEx(HCLUSENUMEX hClusterEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterEnumEx(HCLUSENUMEX hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterCloseEnumEx(HCLUSENUMEX hClusterEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
HGROUPSET CreateClusterGroupSet(HCLUSTER hCluster, const(PWSTR) groupSetName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
HGROUPSET OpenClusterGroupSet(HCLUSTER hCluster, const(PWSTR) lpszGroupSetName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseClusterGroupSet(HGROUPSET hGroupSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint DeleteClusterGroupSet(HGROUPSET hGroupSet);

@DllImport("CLUSAPI.dll")
uint DeleteClusterGroupSetEx(HGROUPSET hGroupSet, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterAddGroupToGroupSet(HGROUPSET hGroupSet, HGROUP hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterAddGroupToGroupSetWithDomains(HGROUPSET hGroupSet, HGROUP hGroup, uint faultDomain, uint updateDomain);

@DllImport("CLUSAPI.dll")
uint ClusterAddGroupToGroupSetWithDomainsEx(HGROUPSET hGroupSet, HGROUP hGroup, uint faultDomain, 
                                            uint updateDomain, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterRemoveGroupFromGroupSet(HGROUP hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterRemoveGroupFromGroupSetEx(HGROUP hGroup, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupSetControl(HGROUPSET hGroupSet, HNODE hHostNode, uint dwControlCode, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                            uint cbInBufferSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                            uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterGroupSetControlEx(HGROUPSET hGroupSet, HNODE hHostNode, uint dwControlCode, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                              uint cbInBufferSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                              uint cbOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint AddClusterGroupDependency(HGROUP hDependentGroup, HGROUP hProviderGroup);

@DllImport("CLUSAPI.dll")
uint AddClusterGroupDependencyEx(HGROUP hDependentGroup, HGROUP hProviderGroup, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint SetGroupDependencyExpression(HGROUP hGroup, const(PWSTR) lpszDependencyExpression);

@DllImport("CLUSAPI.dll")
uint SetGroupDependencyExpressionEx(HGROUP hGroup, const(PWSTR) lpszDependencyExpression, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupDependency(HGROUP hGroup, HGROUP hDependsOn);

@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupDependencyEx(HGROUP hGroup, HGROUP hDependsOn, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint AddClusterGroupSetDependency(HGROUPSET hDependentGroupSet, HGROUPSET hProviderGroupSet);

@DllImport("CLUSAPI.dll")
uint AddClusterGroupSetDependencyEx(HGROUPSET hDependentGroupSet, HGROUPSET hProviderGroupSet, 
                                    const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterGroupSetDependencyExpression(HGROUPSET hGroupSet, const(PWSTR) lpszDependencyExprssion);

@DllImport("CLUSAPI.dll")
uint SetClusterGroupSetDependencyExpressionEx(HGROUPSET hGroupSet, const(PWSTR) lpszDependencyExpression, 
                                              const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupSetDependency(HGROUPSET hGroupSet, HGROUPSET hDependsOn);

@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupSetDependencyEx(HGROUPSET hGroupSet, HGROUPSET hDependsOn, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint AddClusterGroupToGroupSetDependency(HGROUP hDependentGroup, HGROUPSET hProviderGroupSet);

@DllImport("CLUSAPI.dll")
uint AddClusterGroupToGroupSetDependencyEx(HGROUP hDependentGroup, HGROUPSET hProviderGroupSet, 
                                           const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupToGroupSetDependency(HGROUP hGroup, HGROUPSET hDependsOn);

@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupToGroupSetDependencyEx(HGROUP hGroup, HGROUPSET hDependsOn, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
HGROUPSETENUM ClusterGroupSetOpenEnum(HCLUSTER hCluster);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupSetGetEnumCount(HGROUPSETENUM hGroupSetEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupSetEnum(HGROUPSETENUM hGroupSetEnum, uint dwIndex, PWSTR lpszName, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupSetCloseEnum(HGROUPSETENUM hGroupSetEnum);

@DllImport("CLUSAPI.dll")
uint AddCrossClusterGroupSetDependency(HGROUPSET hDependentGroupSet, const(PWSTR) lpRemoteClusterName, 
                                       const(PWSTR) lpRemoteGroupSetName);

@DllImport("CLUSAPI.dll")
uint RemoveCrossClusterGroupSetDependency(HGROUPSET hDependentGroupSet, const(PWSTR) lpRemoteClusterName, 
                                          const(PWSTR) lpRemoteGroupSetName);

@DllImport("CLUSAPI.dll")
HGROUPSET CreateClusterAvailabilitySet(HCLUSTER hCluster, const(PWSTR) lpAvailabilitySetName, 
                                       CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);

@DllImport("CLUSAPI.dll")
uint ClusterNodeReplacement(HCLUSTER hCluster, const(PWSTR) lpszNodeNameCurrent, const(PWSTR) lpszNodeNameNew);

@DllImport("CLUSAPI.dll")
uint ClusterCreateAffinityRule(HCLUSTER hCluster, const(PWSTR) ruleName, CLUS_AFFINITY_RULE_TYPE ruleType);

@DllImport("CLUSAPI.dll")
uint ClusterRemoveAffinityRule(HCLUSTER hCluster, const(PWSTR) ruleName);

@DllImport("CLUSAPI.dll")
uint ClusterAddGroupToAffinityRule(HCLUSTER hCluster, const(PWSTR) ruleName, HGROUP hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterRemoveGroupFromAffinityRule(HCLUSTER hCluster, const(PWSTR) ruleName, HGROUP hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterAffinityRuleControl(HCLUSTER hCluster, const(PWSTR) affinityRuleName, HNODE hHostNode, 
                                uint dwControlCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                uint cbInBufferSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                uint cbOutBufferSize, uint* lpBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNODE OpenClusterNode(HCLUSTER hCluster, const(PWSTR) lpszNodeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNODE OpenClusterNodeEx(HCLUSTER hCluster, const(PWSTR) lpszNodeName, uint dwDesiredAccess, 
                        uint* lpdwGrantedAccess);

@DllImport("CLUSAPI.dll")
HNODE OpenClusterNodeById(HCLUSTER hCluster, uint nodeId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseClusterNode(HNODE hNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
CLUSTER_NODE_STATE GetClusterNodeState(HNODE hNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterNodeId(HNODE hNode, PWSTR lpszNodeId, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER GetClusterFromNode(HNODE hNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint PauseClusterNode(HNODE hNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ResumeClusterNode(HNODE hNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint EvictClusterNode(HNODE hNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
HNETINTERFACEENUM ClusterNetInterfaceOpenEnum(HCLUSTER hCluster, const(PWSTR) lpszNodeName, 
                                              const(PWSTR) lpszNetworkName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNetInterfaceEnum(HNETINTERFACEENUM hNetInterfaceEnum, uint dwIndex, PWSTR lpszName, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNetInterfaceCloseEnum(HNETINTERFACEENUM hNetInterfaceEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNODEENUM ClusterNodeOpenEnum(HNODE hNode, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNODEENUMEX ClusterNodeOpenEnumEx(HNODE hNode, uint dwType, void* pOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNodeGetEnumCountEx(HNODEENUMEX hNodeEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNodeEnumEx(HNODEENUMEX hNodeEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNodeCloseEnumEx(HNODEENUMEX hNodeEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNodeGetEnumCount(HNODEENUM hNodeEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNodeCloseEnum(HNODEENUM hNodeEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNodeEnum(HNODEENUM hNodeEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint EvictClusterNodeEx(HNODE hNode, uint dwTimeOut, HRESULT* phrCleanupStatus);

@DllImport("CLUSAPI.dll")
uint EvictClusterNodeEx2(HNODE hNode, uint dwTimeout, HRESULT* phrCleanupStatus, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HKEY GetClusterResourceTypeKey(HCLUSTER hCluster, const(PWSTR) lpszTypeName, uint samDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HGROUP CreateClusterGroup(HCLUSTER hCluster, const(PWSTR) lpszGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HGROUP OpenClusterGroup(HCLUSTER hCluster, const(PWSTR) lpszGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HGROUP OpenClusterGroupEx(HCLUSTER hCluster, const(PWSTR) lpszGroupName, uint dwDesiredAccess, 
                          uint* lpdwGrantedAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint PauseClusterNodeEx(HNODE hNode, BOOL bDrainNode, uint dwPauseFlags, HNODE hNodeDrainTarget);

@DllImport("CLUSAPI.dll")
uint PauseClusterNodeEx2(HNODE hNode, BOOL bDrainNode, uint dwPauseFlags, HNODE hNodeDrainTarget, 
                         const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint ResumeClusterNodeEx(HNODE hNode, CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                         uint dwResumeFlagsReserved);

@DllImport("CLUSAPI.dll")
uint ResumeClusterNodeEx2(HNODE hNode, CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, 
                          uint dwResumeFlagsReserved, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
HGROUP CreateClusterGroupEx(HCLUSTER hCluster, const(PWSTR) lpszGroupName, CLUSTER_CREATE_GROUP_INFO* pGroupInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
HGROUPENUMEX ClusterGroupOpenEnumEx(HCLUSTER hCluster, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PWSTR) lpszProperties, 
                                    uint cbProperties, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PWSTR) lpszRoProperties, 
                                    uint cbRoProperties, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupGetEnumCountEx(HGROUPENUMEX hGroupEnumEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupEnumEx(HGROUPENUMEX hGroupEnumEx, uint dwIndex, CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupCloseEnumEx(HGROUPENUMEX hGroupEnumEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
HRESENUMEX ClusterResourceOpenEnumEx(HCLUSTER hCluster, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PWSTR) lpszProperties, 
                                     uint cbProperties, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PWSTR) lpszRoProperties, 
                                     uint cbRoProperties, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceGetEnumCountEx(HRESENUMEX hResourceEnumEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceEnumEx(HRESENUMEX hResourceEnumEx, uint dwIndex, CLUSTER_RESOURCE_ENUM_ITEM* pItem, 
                           uint* cbItem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceCloseEnumEx(HRESENUMEX hResourceEnumEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint OnlineClusterGroupEx(HGROUP hGroup, HNODE hDestinationNode, uint dwOnlineFlags, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpInBuffer, 
                          uint cbInBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint OfflineClusterGroupEx(HGROUP hGroup, uint dwOfflineFlags, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpInBuffer, 
                           uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint OnlineClusterGroupEx2(HGROUP hGroup, HNODE hDestinationNode, uint dwOnlineFlags, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpInBuffer, 
                           uint cbInBufferSize, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint OfflineClusterGroupEx2(HGROUP hGroup, uint dwOfflineFlags, ubyte* lpInBuffer, uint cbInBufferSize, 
                            const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint OnlineClusterResourceEx(HRESOURCE hResource, uint dwOnlineFlags, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpInBuffer, 
                             uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint OnlineClusterResourceEx2(HRESOURCE hResource, uint dwOnlineFlags, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpInBuffer, 
                              uint cbInBufferSize, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint OfflineClusterResourceEx(HRESOURCE hResource, uint dwOfflineFlags, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpInBuffer, 
                              uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint OfflineClusterResourceEx2(HRESOURCE hResource, uint dwOfflineFlags, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpInBuffer, 
                               uint cbInBufferSize, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint MoveClusterGroupEx(HGROUP hGroup, HNODE hDestinationNode, uint dwMoveFlags, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpInBuffer, 
                        uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint MoveClusterGroupEx2(HGROUP hGroup, HNODE hDestinationNode, uint dwMoveFlags, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpInBuffer, 
                         uint cbInBufferSize, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint CancelClusterGroupOperation(HGROUP hGroup, uint dwCancelFlags_RESERVED);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
uint RestartClusterResource(HRESOURCE hResource, uint dwFlags);

@DllImport("CLUSAPI.dll")
uint RestartClusterResourceEx(HRESOURCE hResource, uint dwFlags, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseClusterGroup(HGROUP hGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER GetClusterFromGroup(HGROUP hGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
CLUSTER_GROUP_STATE GetClusterGroupState(HGROUP hGroup, PWSTR lpszNodeName, uint* lpcchNodeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterGroupName(HGROUP hGroup, const(PWSTR) lpszGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterGroupNodeList(HGROUP hGroup, uint NodeCount, HNODE* NodeList);

@DllImport("CLUSAPI.dll")
uint SetClusterGroupNameEx(HGROUP hGroup, const(PWSTR) lpszGroupName, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint SetClusterGroupNodeListEx(HGROUP hGroup, uint NodeCount, HNODE* NodeList, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint OnlineClusterGroup(HGROUP hGroup, HNODE hDestinationNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint MoveClusterGroup(HGROUP hGroup, HNODE hDestinationNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint OfflineClusterGroup(HGROUP hGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint DeleteClusterGroup(HGROUP hGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint DestroyClusterGroup(HGROUP hGroup);

@DllImport("CLUSAPI.dll")
uint DeleteClusterGroupEx(HGROUP hGroup, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint DestroyClusterGroupEx(HGROUP hGroup, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HGROUPENUM ClusterGroupOpenEnum(HGROUP hGroup, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupGetEnumCount(HGROUPENUM hGroupEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupEnum(HGROUPENUM hGroupEnum, uint dwIndex, uint* lpdwType, PWSTR lpszResourceName, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupCloseEnum(HGROUPENUM hGroupEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HRESOURCE CreateClusterResource(HGROUP hGroup, const(PWSTR) lpszResourceName, const(PWSTR) lpszResourceType, 
                                uint dwFlags);

@DllImport("CLUSAPI.dll")
HRESOURCE CreateClusterResourceEx(HGROUP hGroup, const(PWSTR) lpszResourceName, const(PWSTR) lpszResourceType, 
                                  uint dwFlags, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HRESOURCE OpenClusterResource(HCLUSTER hCluster, const(PWSTR) lpszResourceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HRESOURCE OpenClusterResourceEx(HCLUSTER hCluster, const(PWSTR) lpszResourceName, uint dwDesiredAccess, 
                                uint* lpdwGrantedAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseClusterResource(HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER GetClusterFromResource(HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint DeleteClusterResource(HRESOURCE hResource);

@DllImport("CLUSAPI.dll")
uint DeleteClusterResourceEx(HRESOURCE hResource, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
CLUSTER_RESOURCE_STATE GetClusterResourceState(HRESOURCE hResource, PWSTR lpszNodeName, uint* lpcchNodeName, 
                                               PWSTR lpszGroupName, uint* lpcchGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterResourceName(HRESOURCE hResource, const(PWSTR) lpszResourceName);

@DllImport("CLUSAPI.dll")
uint SetClusterResourceNameEx(HRESOURCE hResource, const(PWSTR) lpszResourceName, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint FailClusterResource(HRESOURCE hResource);

@DllImport("CLUSAPI.dll")
uint FailClusterResourceEx(HRESOURCE hResource, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint OnlineClusterResource(HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint OfflineClusterResource(HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ChangeClusterResourceGroup(HRESOURCE hResource, HGROUP hGroup);

@DllImport("CLUSAPI.dll")
uint ChangeClusterResourceGroupEx(HRESOURCE hResource, HGROUP hGroup, ulong Flags);

@DllImport("CLUSAPI.dll")
uint ChangeClusterResourceGroupEx2(HRESOURCE hResource, HGROUP hGroup, ulong Flags, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint AddClusterResourceNode(HRESOURCE hResource, HNODE hNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint RemoveClusterResourceNode(HRESOURCE hResource, HNODE hNode);

@DllImport("CLUSAPI.dll")
uint AddClusterResourceNodeEx(HRESOURCE hResource, HNODE hNode, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint RemoveClusterResourceNodeEx(HRESOURCE hResource, HNODE hNode, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint AddClusterResourceDependency(HRESOURCE hResource, HRESOURCE hDependsOn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint RemoveClusterResourceDependency(HRESOURCE hResource, HRESOURCE hDependsOn);

@DllImport("CLUSAPI.dll")
uint AddClusterResourceDependencyEx(HRESOURCE hResource, HRESOURCE hDependsOn, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint RemoveClusterResourceDependencyEx(HRESOURCE hResource, HRESOURCE hDependsOn, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterResourceDependencyExpression(HRESOURCE hResource, const(PWSTR) lpszDependencyExpression);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterResourceDependencyExpression(HRESOURCE hResource, PWSTR lpszDependencyExpression, 
                                            uint* lpcchDependencyExpression);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint AddResourceToClusterSharedVolumes(HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint RemoveResourceFromClusterSharedVolumes(HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint IsFileOnClusterSharedVolume(const(PWSTR) lpszPathName, BOOL* pbFileIsOnSharedVolume);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterSharedVolumeSetSnapshotState(GUID guidSnapshotSet, const(PWSTR) lpszVolumeName, 
                                         CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CanResourceBeDependent(HRESOURCE hResource, HRESOURCE hResourceDependent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceControl(HRESOURCE hResource, HNODE hHostNode, uint dwControlCode, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                            uint cbInBufferSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                            uint cbOutBufferSize, uint* lpBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceControlAsUser(HRESOURCE hResource, HNODE hHostNode, uint dwControlCode, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                  uint cbInBufferSize, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                  uint cbOutBufferSize, uint* lpBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeControl(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, HNODE hHostNode, 
                                uint dwControlCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                uint nInBufferSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                uint nOutBufferSize, uint* lpBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeControlAsUser(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, HNODE hHostNode, 
                                      uint dwControlCode, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                      uint nInBufferSize, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                      uint nOutBufferSize, uint* lpBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterGroupControl(HGROUP hGroup, HNODE hHostNode, uint dwControlCode, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                         uint nInBufferSize, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                         uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterResourceControlEx(HRESOURCE hResource, HNODE hHostNode, uint dwControlCode, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                              uint cbInBufferSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                              uint cbOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint ClusterResourceControlAsUserEx(HRESOURCE hResource, HNODE hHostNode, uint dwControlCode, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                    uint cbInBufferSize, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                    uint cbOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeControlEx(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, HNODE hHostNode, 
                                  uint dwControlCode, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                  uint nInBufferSize, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                  uint nOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeControlAsUserEx(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, HNODE hHostNode, 
                                        uint dwControlCode, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpInBuffer, 
                                        uint nInBufferSize, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpOutBuffer, 
                                        uint nOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint ClusterGroupControlEx(HGROUP hGroup, HNODE hHostNode, uint dwControlCode, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                           uint nInBufferSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                           uint nOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNodeControl(HNODE hNode, HNODE hHostNode, uint dwControlCode, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                        uint nInBufferSize, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                        uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterNodeControlEx(HNODE hNode, HNODE hHostNode, uint dwControlCode, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                          uint nInBufferSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                          uint nOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL GetClusterResourceNetworkName(HRESOURCE hResource, PWSTR lpBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HRESENUM ClusterResourceOpenEnum(HRESOURCE hResource, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceGetEnumCount(HRESENUM hResEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceEnum(HRESENUM hResEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceCloseEnum(HRESENUM hResEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint CreateClusterResourceType(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, const(PWSTR) lpszDisplayName, 
                               const(PWSTR) lpszResourceTypeDll, uint dwLooksAlivePollInterval, 
                               uint dwIsAlivePollInterval);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint DeleteClusterResourceType(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName);

@DllImport("CLUSAPI.dll")
uint CreateClusterResourceTypeEx(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, 
                                 const(PWSTR) lpszDisplayName, const(PWSTR) lpszResourceTypeDll, 
                                 uint dwLooksAlivePollInterval, uint dwIsAlivePollInterval, const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint DeleteClusterResourceTypeEx(HCLUSTER hCluster, const(PWSTR) lpszTypeName, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HRESTYPEENUM ClusterResourceTypeOpenEnum(HCLUSTER hCluster, const(PWSTR) lpszResourceTypeName, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeGetEnumCount(HRESTYPEENUM hResTypeEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeEnum(HRESTYPEENUM hResTypeEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, 
                             uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeCloseEnum(HRESTYPEENUM hResTypeEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNETWORK OpenClusterNetwork(HCLUSTER hCluster, const(PWSTR) lpszNetworkName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNETWORK OpenClusterNetworkEx(HCLUSTER hCluster, const(PWSTR) lpszNetworkName, uint dwDesiredAccess, 
                              uint* lpdwGrantedAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseClusterNetwork(HNETWORK hNetwork);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER GetClusterFromNetwork(HNETWORK hNetwork);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNETWORKENUM ClusterNetworkOpenEnum(HNETWORK hNetwork, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNetworkGetEnumCount(HNETWORKENUM hNetworkEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNetworkEnum(HNETWORKENUM hNetworkEnum, uint dwIndex, uint* lpdwType, PWSTR lpszName, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNetworkCloseEnum(HNETWORKENUM hNetworkEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
CLUSTER_NETWORK_STATE GetClusterNetworkState(HNETWORK hNetwork);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint SetClusterNetworkName(HNETWORK hNetwork, const(PWSTR) lpszName);

@DllImport("CLUSAPI.dll")
uint SetClusterNetworkNameEx(HNETWORK hNetwork, const(PWSTR) lpszName, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterNetworkId(HNETWORK hNetwork, PWSTR lpszNetworkId, uint* lpcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNetworkControl(HNETWORK hNetwork, HNODE hHostNode, uint dwControlCode, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                           uint nInBufferSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                           uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterNetworkControlEx(HNETWORK hNetwork, HNODE hHostNode, uint dwControlCode, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                             uint nInBufferSize, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                             uint nOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNETINTERFACE OpenClusterNetInterface(HCLUSTER hCluster, const(PWSTR) lpszInterfaceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNETINTERFACE OpenClusterNetInterfaceEx(HCLUSTER hCluster, const(PWSTR) lpszInterfaceName, uint dwDesiredAccess, 
                                        uint* lpdwGrantedAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint GetClusterNetInterface(HCLUSTER hCluster, const(PWSTR) lpszNodeName, const(PWSTR) lpszNetworkName, 
                            PWSTR lpszInterfaceName, uint* lpcchInterfaceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
BOOL CloseClusterNetInterface(HNETINTERFACE hNetInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER GetClusterFromNetInterface(HNETINTERFACE hNetInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
CLUSTER_NETINTERFACE_STATE GetClusterNetInterfaceState(HNETINTERFACE hNetInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterNetInterfaceControl(HNETINTERFACE hNetInterface, HNODE hHostNode, uint dwControlCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                uint nInBufferSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterNetInterfaceControlEx(HNETINTERFACE hNetInterface, HNODE hHostNode, uint dwControlCode, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpInBuffer, 
                                  uint nInBufferSize, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpOutBuffer, 
                                  uint nOutBufferSize, uint* lpBytesReturned, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HKEY GetClusterKey(HCLUSTER hCluster, uint samDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HKEY GetClusterGroupKey(HGROUP hGroup, uint samDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HKEY GetClusterResourceKey(HRESOURCE hResource, uint samDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HKEY GetClusterNodeKey(HNODE hNode, uint samDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HKEY GetClusterNetworkKey(HNETWORK hNetwork, uint samDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HKEY GetClusterNetInterfaceKey(HNETINTERFACE hNetInterface, uint samDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCreateKey(HKEY hKey, const(PWSTR) lpszSubKey, uint dwOptions, uint samDesired, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);

@DllImport("CLUSAPI.dll")
int ClusterRegCreateKeyEx(HKEY hKey, const(PWSTR) lpSubKey, uint dwOptions, uint samDesired, 
                          SECURITY_ATTRIBUTES* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition, 
                          const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegOpenKey(HKEY hKey, const(PWSTR) lpszSubKey, uint samDesired, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegDeleteKey(HKEY hKey, const(PWSTR) lpszSubKey);

@DllImport("CLUSAPI.dll")
int ClusterRegDeleteKeyEx(HKEY hKey, const(PWSTR) lpSubKey, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCloseKey(HKEY hKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegEnumKey(HKEY hKey, uint dwIndex, PWSTR lpszName, uint* lpcchName, FILETIME* lpftLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterRegSetValue(HKEY hKey, const(PWSTR) lpszValueName, uint dwType, const(ubyte)* lpData, uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterRegDeleteValue(HKEY hKey, const(PWSTR) lpszValueName);

@DllImport("CLUSAPI.dll")
uint ClusterRegSetValueEx(HKEY hKey, const(PWSTR) lpszValueName, uint dwType, const(ubyte)* lpData, uint cbData, 
                          const(PWSTR) lpszReason);

@DllImport("CLUSAPI.dll")
uint ClusterRegDeleteValueEx(HKEY hKey, const(PWSTR) lpszValueName, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegQueryValue(HKEY hKey, const(PWSTR) lpszValueName, uint* lpdwValueType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpData, 
                         uint* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint ClusterRegEnumValue(HKEY hKey, uint dwIndex, PWSTR lpszValueName, uint* lpcchValueName, uint* lpdwType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpData, 
                         uint* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegQueryInfoKey(HKEY hKey, uint* lpcSubKeys, uint* lpcchMaxSubKeyLen, uint* lpcValues, 
                           uint* lpcchMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                           FILETIME* lpftLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegGetKeySecurity(HKEY hKey, uint RequestedInformation, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                             uint* lpcbSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegSetKeySecurity(HKEY hKey, uint SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);

@DllImport("CLUSAPI.dll")
int ClusterRegSetKeySecurityEx(HKEY hKey, OBJECT_SECURITY_INFORMATION SecurityInformation, 
                               PSECURITY_DESCRIPTOR pSecurityDescriptor, const(PWSTR) lpszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegSyncDatabase(HCLUSTER hCluster, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCreateBatch(HKEY hKey, HREGBATCH* pHREGBATCH);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegBatchAddCommand(HREGBATCH hRegBatch, CLUSTER_REG_COMMAND dwCommand, const(PWSTR) wzName, 
                              uint dwOptions, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* lpData, 
                              uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCloseBatch(HREGBATCH hRegBatch, BOOL bCommit, int* failedCommandNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCloseBatchEx(HREGBATCH hRegBatch, uint flags, int* failedCommandNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegBatchReadCommand(HREGBATCHNOTIFICATION hBatchNotification, CLUSTER_BATCH_COMMAND* pBatchCommand);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegBatchCloseNotification(HREGBATCHNOTIFICATION hBatchNotification);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCreateBatchNotifyPort(HKEY hKey, HREGBATCHPORT* phBatchNotifyPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCloseBatchNotifyPort(HREGBATCHPORT hBatchNotifyPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegGetBatchNotification(HREGBATCHPORT hBatchNotify, HREGBATCHNOTIFICATION* phBatchNotification);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCreateReadBatch(HKEY hKey, HREGREADBATCH* phRegReadBatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegReadBatchAddCommand(HREGREADBATCH hRegReadBatch, const(PWSTR) wzSubkeyName, const(PWSTR) wzValueName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCloseReadBatch(HREGREADBATCH hRegReadBatch, HREGREADBATCHREPLY* phRegReadBatchReply);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCloseReadBatchEx(HREGREADBATCH hRegReadBatch, uint flags, HREGREADBATCHREPLY* phRegReadBatchReply);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegReadBatchReplyNextCommand(HREGREADBATCHREPLY hRegReadBatchReply, 
                                        CLUSTER_READ_BATCH_COMMAND* pBatchCommand);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("CLUSAPI.dll")
int ClusterRegCloseReadBatchReply(HREGREADBATCHREPLY hRegReadBatchReply);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint ClusterSetAccountAccess(HCLUSTER hCluster, const(PWSTR) szAccountSID, uint dwAccess, uint dwControlType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HCLUSTER CreateCluster(CREATE_CLUSTER_CONFIG* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, 
                       void* pvCallbackArg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint CreateClusterNameAccount(HCLUSTER hCluster, CREATE_CLUSTER_NAME_ACCOUNT* pConfig, 
                              PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
uint RemoveClusterNameAccount(HCLUSTER hCluster, BOOL bDeleteComputerObjects);

@DllImport("CLUSAPI.dll")
uint RepairClusterNameAccount(HCLUSTER hCluster, REPAIR_CLUSTER_NAME_ACCOUNT_CONFIG* pConfig, 
                              PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
uint DetermineCNOResTypeFromNodelist(uint cNodes, const(PWSTR)* ppszNodeNames, 
                                     CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI.dll")
uint DetermineCNOResTypeFromCluster(HCLUSTER hCluster, CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI.dll")
uint DetermineClusterCloudTypeFromNodelist(uint cNodes, const(PWSTR)* ppszNodeNames, 
                                           CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI.dll")
uint DetermineClusterCloudTypeFromCluster(HCLUSTER hCluster, CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI.dll")
uint GetNodeCloudTypeDW(const(PWSTR) ppszNodeName, uint* NodeCloudType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("CLUSAPI.dll")
uint RegisterClusterResourceTypeNotifyV2(HCHANGE hChange, HCLUSTER hCluster, long Flags, const(PWSTR) resTypeName, 
                                         size_t dwNotifyKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
HNODE AddClusterNode(HCLUSTER hCluster, const(PWSTR) lpszNodeName, 
                     PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
uint AddClusterStorageNode(HCLUSTER hCluster, const(PWSTR) lpszNodeName, 
                           PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, 
                           const(PWSTR) lpszClusterStorageNodeDescription, 
                           const(PWSTR) lpszClusterStorageNodeLocation);

@DllImport("CLUSAPI.dll")
HNODE AddClusterNodeEx(HCLUSTER hCluster, const(PWSTR) lpszNodeName, uint dwFlags, 
                       PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
uint RemoveClusterStorageNode(HCLUSTER hCluster, const(PWSTR) lpszClusterStorageEnclosureName, uint dwTimeout, 
                              uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("CLUSAPI.dll")
uint DestroyCluster(HCLUSTER hCluster, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, 
                    BOOL fdeleteVirtualComputerObjects);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint InitializeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint InitializeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint FreeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint FreeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint ClusGetClusterHealthFaults(HCLUSTER hCluster, CLUSTER_HEALTH_FAULT_ARRAY* objects, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint ClusRemoveClusterHealthFault(HCLUSTER hCluster, const(PWSTR) id, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint ClusAddClusterHealthFault(HCLUSTER hCluster, CLUSTER_HEALTH_FAULT* failure, uint param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilStartResourceService(const(PWSTR) pszServiceName, SC_HANDLE* phServiceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilVerifyResourceService(const(PWSTR) pszServiceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilStopResourceService(const(PWSTR) pszServiceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilVerifyService(SC_HANDLE hServiceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilStopService(SC_HANDLE hServiceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilCreateDirectoryTree(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ResUtilIsPathValid(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilEnumProperties(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR pszOutProperties, 
                           uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilEnumPrivateProperties(HKEY hkeyClusterKey, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR pszOutProperties, 
                                  uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pOutPropertyList, 
                          uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetAllProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pOutPropertyList, 
                             uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetPrivateProperties(HKEY hkeyClusterKey, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pOutPropertyList, 
                                 uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetPropertySize(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                            uint* pcbOutPropertyListSize, uint* pnPropertyCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetProperty(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void** pOutPropertyItem, 
                        uint* pcbOutPropertyItemSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilVerifyPropertyTable(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                                BOOL bAllowUnknownProperties, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pInPropertyList, 
                                uint cbInPropertyListSize, ubyte* pOutParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyTable(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                             BOOL bAllowUnknownProperties, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* pInPropertyList, 
                             uint cbInPropertyListSize, ubyte* pOutParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyTableEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, 
                               BOOL bAllowUnknownProperties, const(void)* pInPropertyList, uint cbInPropertyListSize, 
                               BOOL bForceWrite, ubyte* pOutParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                      void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, 
                                      uint cbInPropertyListSize, ubyte* pOutParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyParameterBlockEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                        void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, 
                                        uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* pInPropertyList, 
                                 uint cbInPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetPropertiesToParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                          ubyte* pOutParams, BOOL bCheckForRequiredProperties, 
                                          PWSTR* pszNameOfPropInError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilPropertyListFromParameterBlock(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pOutPropertyList, 
                                           uint* pcbOutPropertyListSize, const(ubyte)* pInParams, 
                                           uint* pcbBytesReturned, uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilDupParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, 
                              const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
void ResUtilFreeParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, 
                               const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilAddUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                                 void* pOutPropertyList, uint pcbOutPropertyListSize, uint* pcbBytesReturned, 
                                 uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetPrivatePropertyList(HKEY hkeyClusterKey, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pInPropertyList, 
                                   uint cbInPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilVerifyPrivatePropertyList(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pInPropertyList, 
                                      uint cbInPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
PWSTR ResUtilDupString(const(PWSTR) pszInString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetBinaryValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ubyte** ppbOutValue, 
                           uint* pcbOutValueSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
PWSTR ResUtilGetSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetDwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, uint* pdwOutValue, uint dwDefaultValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetQwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ulong* pqwOutValue, ulong qwDefaultValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetBinaryValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(ubyte)* pbNewValue, 
                           uint cbNewValueSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte** ppbOutValue, 
                           uint* pcbOutValueSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, const(PWSTR) pszNewValue, 
                       PWSTR* ppszOutString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetExpandSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, const(PWSTR) pszNewValue, 
                             PWSTR* ppszOutString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetMultiSzValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(PWSTR) pszNewValue, 
                            uint cbNewValueSize, PWSTR* ppszOutValue, uint* pcbOutValueSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetDwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, uint dwNewValue, uint* pdwOutValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetQwordValue(HKEY hkeyClusterKey, const(PWSTR) pszValueName, ulong qwNewValue, ulong* pqwOutValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetValueEx(HKEY hkeyClusterKey, const(PWSTR) valueName, uint valueType, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(ubyte)* valueData, 
                       uint valueSize, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetBinaryProperty(ubyte** ppbOutValue, uint* pcbOutValueSize, const(CLUSPROP_BINARY)* pValueStruct, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(ubyte)* pbOldValue, 
                              uint cbOldValueSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte** ppPropertyList, 
                              uint* pcbPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetSzProperty(PWSTR* ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, const(PWSTR) pszOldValue, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte** ppPropertyList, 
                          uint* pcbPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetMultiSzProperty(PWSTR* ppszOutValue, uint* pcbOutValueSize, const(CLUSPROP_SZ)* pValueStruct, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PWSTR) pszOldValue, 
                               uint cbOldValueSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte** ppPropertyList, 
                               uint* pcbPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetDwordProperty(uint* pdwOutValue, const(CLUSPROP_DWORD)* pValueStruct, uint dwOldValue, 
                             uint dwMinimum, uint dwMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetLongProperty(int* plOutValue, const(CLUSPROP_LONG)* pValueStruct, int lOldValue, int lMinimum, 
                            int lMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetFileTimeProperty(FILETIME* pftOutValue, const(CLUSPROP_FILETIME)* pValueStruct, FILETIME ftOldValue, 
                                FILETIME ftMinimum, FILETIME ftMaximum, ubyte** ppPropertyList, 
                                uint* pcbPropertyListSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
void* ResUtilGetEnvironmentWithNetName(HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFreeEnvironment(void* lpEnvironment);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
PWSTR ResUtilExpandEnvironmentStrings(const(PWSTR) pszSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetResourceServiceEnvironment(const(PWSTR) pszServiceName, HRESOURCE hResource, 
                                          PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilRemoveResourceServiceEnvironment(const(PWSTR) pszServiceName, PLOG_EVENT_ROUTINE pfnLogEvent, 
                                             ptrdiff_t hResourceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetResourceServiceStartParameters(const(PWSTR) pszServiceName, SC_HANDLE schSCMHandle, 
                                              SC_HANDLE* phService, PLOG_EVENT_ROUTINE pfnLogEvent, 
                                              ptrdiff_t hResourceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindSzProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                           uint cbPropertyListSize, const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindExpandSzProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                 uint cbPropertyListSize, const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindExpandedSzProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                   uint cbPropertyListSize, const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindDwordProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                              uint cbPropertyListSize, const(PWSTR) pszPropertyName, uint* pdwPropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindBinaryProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                               uint cbPropertyListSize, const(PWSTR) pszPropertyName, ubyte** pbPropertyValue, 
                               uint* pcbPropertyValueSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindMultiSzProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                uint cbPropertyListSize, const(PWSTR) pszPropertyName, PWSTR* pszPropertyValue, 
                                uint* pcbPropertyValueSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindLongProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                             uint cbPropertyListSize, const(PWSTR) pszPropertyName, int* plPropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindULargeIntegerProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                      uint cbPropertyListSize, const(PWSTR) pszPropertyName, ulong* plPropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindFileTimeProperty(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pPropertyList, 
                                 uint cbPropertyListSize, const(PWSTR) pszPropertyName, FILETIME* pftPropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ClusWorkerCreate(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, void* lpParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ClusWorkerCheckTerminate(CLUS_WORKER* lpWorker);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/resapi/nf-resapi-clusworkerterminate
@DllImport("RESUTILS.dll")
void ClusWorkerTerminate(CLUS_WORKER* lpWorker);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint ClusWorkerTerminateEx(CLUS_WORKER* ClusWorker, uint TimeoutInMilliseconds, BOOL WaitOnly);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
uint ClusWorkersTerminate(CLUS_WORKER** ClusWorkers, const(size_t) ClusWorkersCount, uint TimeoutInMilliseconds, 
                          BOOL WaitOnly);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ResUtilResourcesEqual(HRESOURCE hSelf, HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ResUtilResourceTypesEqual(const(PWSTR) lpszResourceTypeName, HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ResUtilIsResourceClassEqual(CLUS_RESOURCE_CLASS_INFO* prci, HRESOURCE hResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilEnumResources(HRESOURCE hSelf, const(PWSTR) lpszResTypeName, LPRESOURCE_CALLBACK pResCallBack, 
                          void* pParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilEnumResourcesEx(HCLUSTER hCluster, HRESOURCE hSelf, const(PWSTR) lpszResTypeName, 
                            LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceDependency(HANDLE hSelf, const(PWSTR) lpszResourceType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceDependencyByName(HCLUSTER hCluster, HANDLE hSelf, const(PWSTR) lpszResourceType, 
                                             BOOL bRecurse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceDependencyByClass(HCLUSTER hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, 
                                              BOOL bRecurse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceNameDependency(const(PWSTR) lpszResourceName, const(PWSTR) lpszResourceType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetResourceDependentIPAddressProps(HRESOURCE hResource, PWSTR pszAddress, uint* pcchAddress, 
                                               PWSTR pszSubnetMask, uint* pcchSubnetMask, PWSTR pszNetwork, 
                                               uint* pcchNetwork);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilFindDependentDiskResourceDriveLetter(HCLUSTER hCluster, HRESOURCE hResource, PWSTR pszDriveLetter, 
                                                 uint* pcchDriveLetter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilTerminateServiceProcessFromResDll(uint dwServicePid, BOOL bOffline, uint* pdwResourceState, 
                                              PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetPropertyFormats(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pOutPropertyFormatList, 
                               uint cbPropertyFormatListSize, uint* pcbBytesReturned, uint* pcbRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetCoreClusterResources(HCLUSTER hCluster, HRESOURCE* phClusterNameResource, 
                                    HRESOURCE* phClusterIPAddressResource, HRESOURCE* phClusterQuorumResource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetResourceName(HRESOURCE hResource, PWSTR pszResourceName, uint* pcchResourceNameInOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
CLUSTER_ROLE_STATE ResUtilGetClusterRoleState(HCLUSTER hCluster, CLUSTER_ROLE eClusterRole);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ClusterIsPathOnSharedVolume(const(PWSTR) lpszPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ClusterGetVolumePathName(const(PWSTR) lpszFileName, PWSTR lpszVolumePathName, uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
BOOL ClusterGetVolumeNameForVolumeMountPoint(const(PWSTR) lpszVolumeMountPoint, PWSTR lpszVolumeName, 
                                             uint cchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ClusterPrepareSharedVolumeForBackup(const(PWSTR) lpszFileName, PWSTR lpszVolumePathName, 
                                         uint* lpcchVolumePathName, PWSTR lpszVolumeName, uint* lpcchVolumeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("RESUTILS.dll")
uint ClusterClearBackupStateForSharedVolume(const(PWSTR) lpszVolumePathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint ResUtilSetResourceServiceStartParametersEx(const(PWSTR) pszServiceName, SC_HANDLE schSCMHandle, 
                                                SC_HANDLE* phService, uint dwDesiredAccess, 
                                                PLOG_EVENT_ROUTINE pfnLogEvent, ptrdiff_t hResourceHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint ResUtilEnumResourcesEx2(HCLUSTER hCluster, HRESOURCE hSelf, const(PWSTR) lpszResTypeName, 
                             LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceDependencyEx(HANDLE hSelf, const(PWSTR) lpszResourceType, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceDependencyByNameEx(HCLUSTER hCluster, HANDLE hSelf, const(PWSTR) lpszResourceType, 
                                               BOOL bRecurse, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceDependencyByClassEx(HCLUSTER hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, 
                                                BOOL bRecurse, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
HRESOURCE ResUtilGetResourceNameDependencyEx(const(PWSTR) lpszResourceName, const(PWSTR) lpszResourceType, 
                                             uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint ResUtilGetCoreClusterResourcesEx(HCLUSTER hClusterIn, HRESOURCE* phClusterNameResourceOut, 
                                      HRESOURCE* phClusterQuorumResourceOut, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
HCLUSCRYPTPROVIDER OpenClusterCryptProvider(const(PWSTR) lpszResource, byte* lpszProvider, uint dwType, 
                                            uint dwFlags);

@DllImport("RESUTILS.dll")
HCLUSCRYPTPROVIDER OpenClusterCryptProviderEx(const(PWSTR) lpszResource, const(PWSTR) lpszKeyname, 
                                              byte* lpszProvider, uint dwType, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint CloseClusterCryptProvider(HCLUSCRYPTPROVIDER hClusCryptProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint ClusterEncrypt(HCLUSCRYPTPROVIDER hClusCryptProvider, ubyte* pData, uint cbData, ubyte** ppData, 
                    uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint ClusterDecrypt(HCLUSCRYPTPROVIDER hClusCryptProvider, ubyte* pCryptInput, uint cbCryptInput, 
                    ubyte** ppCryptOutput, uint* pcbCryptOutput);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("RESUTILS.dll")
uint FreeClusterCrypt(void* pCryptInfo);

@DllImport("RESUTILS.dll")
uint ResUtilVerifyShutdownSafe(uint flags, uint reason, uint* pResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
BOOL ResUtilPaxosComparer(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("RESUTILS.dll")
BOOL ResUtilLeftPaxosIsLessThanRight(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

@DllImport("RESUTILS.dll")
uint ResUtilsDeleteKeyTree(HKEY key, const(PWSTR) keyName, BOOL treatNoKeyAsError);

@DllImport("RESUTILS.dll")
uint ResUtilGroupsEqual(HGROUP hSelf, HGROUP hGroup, BOOL* pEqual);

@DllImport("RESUTILS.dll")
uint ResUtilEnumGroups(HCLUSTER hCluster, HGROUP hSelf, LPGROUP_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
uint ResUtilEnumGroupsEx(HCLUSTER hCluster, HGROUP hSelf, CLUSGROUP_TYPE groupType, 
                         LPGROUP_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
uint ResUtilDupGroup(HGROUP group, HGROUP* copy);

@DllImport("RESUTILS.dll")
uint ResUtilGetClusterGroupType(HGROUP hGroup, CLUSGROUP_TYPE* groupType);

@DllImport("RESUTILS.dll")
HGROUP ResUtilGetCoreGroup(HCLUSTER hCluster);

@DllImport("RESUTILS.dll")
uint ResUtilResourceDepEnum(HRESOURCE hSelf, uint enumType, LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
uint ResUtilDupResource(HRESOURCE group, HRESOURCE* copy);

@DllImport("RESUTILS.dll")
uint ResUtilGetClusterId(HCLUSTER hCluster, GUID* guid);

@DllImport("RESUTILS.dll")
uint ResUtilNodeEnum(HCLUSTER hCluster, LPNODE_CALLBACK pNodeCallBack, void* pParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("NTLANMAN.dll")
uint RegisterAppInstance(HANDLE ProcessHandle, GUID* AppInstanceId, BOOL ChildrenInheritAppInstance);

@DllImport("NTLANMAN.dll")
uint RegisterAppInstanceVersion(GUID* AppInstanceId, ulong InstanceVersionHigh, ulong InstanceVersionLow);

@DllImport("NTLANMAN.dll")
uint QueryAppInstanceVersion(GUID* AppInstanceId, ulong* InstanceVersionHigh, ulong* InstanceVersionLow, 
                             NTSTATUS* VersionStatus);

@DllImport("NTLANMAN.dll")
uint ResetAllAppInstanceVersions();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
@DllImport("NTLANMAN.dll")
uint SetAppInstanceCsvFlags(HANDLE ProcessHandle, uint Mask, uint Flags);


// Interfaces

@GUID("f2e606e5-2631-11d1-89f1-00a0c90d061e")
struct ClusApplication;

@GUID("f2e606e3-2631-11d1-89f1-00a0c90d061e")
struct Cluster;

@GUID("f2e60715-2631-11d1-89f1-00a0c90d061e")
struct ClusVersion;

@GUID("f2e6070f-2631-11d1-89f1-00a0c90d061e")
struct ClusResType;

@GUID("f2e606fd-2631-11d1-89f1-00a0c90d061e")
struct ClusProperty;

@GUID("f2e606ff-2631-11d1-89f1-00a0c90d061e")
struct ClusProperties;

@GUID("f2e606e1-2631-11d1-89f1-00a0c90d061e")
struct DomainNames;

@GUID("f2e606f1-2631-11d1-89f1-00a0c90d061e")
struct ClusNetwork;

@GUID("f2e606ed-2631-11d1-89f1-00a0c90d061e")
struct ClusNetInterface;

@GUID("f2e606ef-2631-11d1-89f1-00a0c90d061e")
struct ClusNetInterfaces;

@GUID("f2e60703-2631-11d1-89f1-00a0c90d061e")
struct ClusResDependencies;

@GUID("f2e606e9-2631-11d1-89f1-00a0c90d061e")
struct ClusResGroupResources;

@GUID("f2e60713-2631-11d1-89f1-00a0c90d061e")
struct ClusResTypeResources;

@GUID("f2e606e7-2631-11d1-89f1-00a0c90d061e")
struct ClusResGroupPreferredOwnerNodes;

@GUID("f2e6070d-2631-11d1-89f1-00a0c90d061e")
struct ClusResPossibleOwnerNodes;

@GUID("f2e606f3-2631-11d1-89f1-00a0c90d061e")
struct ClusNetworks;

@GUID("f2e606f5-2631-11d1-89f1-00a0c90d061e")
struct ClusNetworkNetInterfaces;

@GUID("f2e606fb-2631-11d1-89f1-00a0c90d061e")
struct ClusNodeNetInterfaces;

@GUID("f2e60701-2631-11d1-89f1-00a0c90d061e")
struct ClusRefObject;

@GUID("f2e606eb-2631-11d1-89f1-00a0c90d061e")
struct ClusterNames;

@GUID("f2e606f7-2631-11d1-89f1-00a0c90d061e")
struct ClusNode;

@GUID("f2e606f9-2631-11d1-89f1-00a0c90d061e")
struct ClusNodes;

@GUID("f2e60705-2631-11d1-89f1-00a0c90d061e")
struct ClusResGroup;

@GUID("f2e60707-2631-11d1-89f1-00a0c90d061e")
struct ClusResGroups;

@GUID("f2e60709-2631-11d1-89f1-00a0c90d061e")
struct ClusResource;

@GUID("f2e6070b-2631-11d1-89f1-00a0c90d061e")
struct ClusResources;

@GUID("f2e60711-2631-11d1-89f1-00a0c90d061e")
struct ClusResTypes;

@GUID("f2e60717-2631-11d1-89f1-00a0c90d061e")
struct ClusResTypePossibleOwnerNodes;

@GUID("f2e60719-2631-11d1-89f1-00a0c90d061e")
struct ClusPropertyValue;

@GUID("f2e6071b-2631-11d1-89f1-00a0c90d061e")
struct ClusPropertyValues;

@GUID("f2e6071d-2631-11d1-89f1-00a0c90d061e")
struct ClusPropertyValueData;

@GUID("f2e6071f-2631-11d1-89f1-00a0c90d061e")
struct ClusPartition;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/nn-msclus-iscluspartitionex
@GUID("53d51d26-b51b-4a79-b2c3-5048d93a98fc")
struct ClusPartitionEx;

@GUID("f2e60721-2631-11d1-89f1-00a0c90d061e")
struct ClusPartitions;

@GUID("f2e60723-2631-11d1-89f1-00a0c90d061e")
struct ClusDisk;

@GUID("f2e60725-2631-11d1-89f1-00a0c90d061e")
struct ClusDisks;

@GUID("f2e60727-2631-11d1-89f1-00a0c90d061e")
struct ClusScsiAddress;

@GUID("f2e60729-2631-11d1-89f1-00a0c90d061e")
struct ClusRegistryKeys;

@GUID("f2e6072b-2631-11d1-89f1-00a0c90d061e")
struct ClusCryptoKeys;

@GUID("f2e6072d-2631-11d1-89f1-00a0c90d061e")
struct ClusResDependents;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclusteruiinfo
@GUID("97dede50-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterUIInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusteruiinfo-getclustername
    HRESULT GetClusterName(BSTR lpszName, int* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusteruiinfo-getlocale
    uint    GetLocale();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusteruiinfo-getfont
    HFONT   GetFont();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusteruiinfo-geticon
    HICON   GetIcon();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclusterdatainfo
@GUID("97dede51-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterDataInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterdatainfo-getclustername
    HRESULT  GetClusterName(BSTR lpszName, int* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterdatainfo-getclusterhandle
    HCLUSTER GetClusterHandle();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterdatainfo-getobjectcount
    int      GetObjectCount();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclusterobjectinfo
@GUID("97dede52-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterObjectInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterobjectinfo-getobjectname
    HRESULT GetObjectName(int lObjIndex, BSTR lpszName, int* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterobjectinfo-getobjecttype
    CLUADMEX_OBJECT_TYPE GetObjectType(int lObjIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclusternodeinfo
@GUID("97dede53-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterNodeInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusternodeinfo-getnodehandle
    HNODE GetNodeHandle(int lObjIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclustergroupinfo
@GUID("97dede54-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterGroupInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclustergroupinfo-getgrouphandle
    HGROUP GetGroupHandle(int lObjIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclusterresourceinfo
@GUID("97dede55-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterResourceInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterresourceinfo-getresourcehandle
    HRESOURCE GetResourceHandle(int lObjIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterresourceinfo-getresourcetypename
    HRESULT GetResourceTypeName(int lObjIndex, BSTR lpszResTypeName, int* pcchResTypeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusterresourceinfo-getresourcenetworkname
    BOOL    GetResourceNetworkName(int lObjIndex, BSTR lpszNetName, uint* pcchNetName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclusternetworkinfo
@GUID("97dede56-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterNetworkInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusternetworkinfo-getnetworkhandle
    HNETWORK GetNetworkHandle(int lObjIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-igetclusternetinterfaceinfo
@GUID("97dede57-fc6b-11cf-b5f5-00a0c90ab505")
interface IGetClusterNetInterfaceInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-igetclusternetinterfaceinfo-getnetinterfacehandle
    HNETINTERFACE GetNetInterfaceHandle(int lObjIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iwcpropertysheetcallback
@GUID("97dede60-fc6b-11cf-b5f5-00a0c90ab505")
interface IWCPropertySheetCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iwcpropertysheetcallback-addpropertysheetpage
    HRESULT AddPropertySheetPage(int* hpage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iweextendpropertysheet
@GUID("97dede61-fc6b-11cf-b5f5-00a0c90ab505")
interface IWEExtendPropertySheet : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iweextendpropertysheet-createpropertysheetpages
    HRESULT CreatePropertySheetPages(IUnknown piData, IWCPropertySheetCallback piCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iwcwizardcallback
@GUID("97dede62-fc6b-11cf-b5f5-00a0c90ab505")
interface IWCWizardCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iwcwizardcallback-addwizardpage
    HRESULT AddWizardPage(int* hpage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iwcwizardcallback-enablenext
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iweextendwizard
@GUID("97dede63-fc6b-11cf-b5f5-00a0c90ab505")
interface IWEExtendWizard : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iweextendwizard-createwizardpages
    HRESULT CreateWizardPages(IUnknown piData, IWCWizardCallback piCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iwccontextmenucallback
@GUID("97dede64-fc6b-11cf-b5f5-00a0c90ab505")
interface IWCContextMenuCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iwccontextmenucallback-addextensionmenuitem
    HRESULT AddExtensionMenuItem(BSTR lpszName, BSTR lpszStatusBarText, uint nCommandID, uint nSubmenuCommandID, 
                                 uint uFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iweextendcontextmenu
@GUID("97dede65-fc6b-11cf-b5f5-00a0c90ab505")
interface IWEExtendContextMenu : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iweextendcontextmenu-addcontextmenuitems
    HRESULT AddContextMenuItems(IUnknown piData, IWCContextMenuCallback piCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iweinvokecommand
@GUID("97dede66-fc6b-11cf-b5f5-00a0c90ab505")
interface IWEInvokeCommand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iweinvokecommand-invokecommand
    HRESULT InvokeCommand(uint nCommandID, IUnknown piData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iwcwizard97callback
@GUID("97dede67-fc6b-11cf-b5f5-00a0c90ab505")
interface IWCWizard97Callback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iwcwizard97callback-addwizard97page
    HRESULT AddWizard97Page(int* hpage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iwcwizard97callback-enablenext
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nn-cluadmex-iweextendwizard97
@GUID("97dede68-fc6b-11cf-b5f5-00a0c90ab505")
interface IWEExtendWizard97 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cluadmex/nf-cluadmex-iweextendwizard97-createwizard97pages
    HRESULT CreateWizard97Pages(IUnknown piData, IWCWizard97Callback piCallback);
}

@GUID("f2e606e6-2631-11d1-89f1-00a0c90d061e")
interface ISClusApplication : IDispatch
{
    HRESULT get_DomainNames(ISDomainNames* ppDomains);
    HRESULT get_ClusterNames(BSTR bstrDomainName, ISClusterNames* ppClusters);
    HRESULT OpenCluster(BSTR bstrClusterName, ISCluster* pCluster);
}

@GUID("f2e606e2-2631-11d1-89f1-00a0c90d061e")
interface ISDomainNames : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrDomainName);
}

@GUID("f2e606ec-2631-11d1-89f1-00a0c90d061e")
interface ISClusterNames : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrClusterName);
    HRESULT get_DomainName(BSTR* pbstrDomainName);
}

@GUID("f2e60702-2631-11d1-89f1-00a0c90d061e")
interface ISClusRefObject : IDispatch
{
    HRESULT get_Handle(size_t* phandle);
}

@GUID("f2e60716-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606e4-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606f8-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606fa-2631-11d1-89f1-00a0c90d061e")
interface ISClusNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
}

@GUID("f2e606f2-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606f4-2631-11d1-89f1-00a0c90d061e")
interface ISClusNetworks : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetwork* ppClusNetwork);
}

@GUID("f2e606ee-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606f0-2631-11d1-89f1-00a0c90d061e")
interface ISClusNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

@GUID("f2e606fc-2631-11d1-89f1-00a0c90d061e")
interface ISClusNodeNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

@GUID("f2e606f6-2631-11d1-89f1-00a0c90d061e")
interface ISClusNetworkNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

@GUID("f2e60706-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e60708-2631-11d1-89f1-00a0c90d061e")
interface ISClusResGroups : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResGroup* ppClusResGroup);
    HRESULT CreateItem(BSTR bstrResourceGroupName, ISClusResGroup* ppResourceGroup);
    HRESULT DeleteItem(VARIANT varIndex);
}

@GUID("f2e6070a-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e60704-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606ea-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e60714-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e6070c-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606e8-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e6070e-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e60718-2631-11d1-89f1-00a0c90d061e")
interface ISClusResTypePossibleOwnerNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
}

@GUID("f2e60710-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e60712-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e606fe-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e6071a-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e6071c-2631-11d1-89f1-00a0c90d061e")
interface ISClusPropertyValues : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusPropertyValue* ppPropertyValue);
    HRESULT CreateItem(BSTR bstrName, VARIANT varValue, ISClusPropertyValue* ppPropertyValue);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("f2e60700-2631-11d1-89f1-00a0c90d061e")
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

@GUID("f2e6071e-2631-11d1-89f1-00a0c90d061e")
interface ISClusPropertyValueData : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, VARIANT* pvarValue);
    HRESULT CreateItem(VARIANT varValue, VARIANT* pvarData);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("f2e60720-2631-11d1-89f1-00a0c90d061e")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msclus/nn-msclus-iscluspartitionex
@GUID("8802d4fe-b32e-4ad1-9dbd-64f18e1166ce")
interface ISClusPartitionEx : ISClusPartition
{
    HRESULT get_TotalSize(int* plTotalSize);
    HRESULT get_FreeSpace(int* plFreeSpace);
    HRESULT get_DeviceNumber(int* plDeviceNumber);
    HRESULT get_PartitionNumber(int* plPartitionNumber);
    HRESULT get_VolumeGuid(BSTR* pbstrVolumeGuid);
}

@GUID("f2e60722-2631-11d1-89f1-00a0c90d061e")
interface ISClusPartitions : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusPartition* ppPartition);
}

@GUID("f2e60724-2631-11d1-89f1-00a0c90d061e")
interface ISClusDisk : IDispatch
{
    HRESULT get_Signature(int* plSignature);
    HRESULT get_ScsiAddress(ISClusScsiAddress* ppScsiAddress);
    HRESULT get_DiskNumber(int* plDiskNumber);
    HRESULT get_Partitions(ISClusPartitions* ppPartitions);
}

@GUID("f2e60726-2631-11d1-89f1-00a0c90d061e")
interface ISClusDisks : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusDisk* ppDisk);
}

@GUID("f2e60728-2631-11d1-89f1-00a0c90d061e")
interface ISClusScsiAddress : IDispatch
{
    HRESULT get_PortNumber(VARIANT* pvarPortNumber);
    HRESULT get_PathId(VARIANT* pvarPathId);
    HRESULT get_TargetId(VARIANT* pvarTargetId);
    HRESULT get_Lun(VARIANT* pvarLun);
}

@GUID("f2e6072a-2631-11d1-89f1-00a0c90d061e")
interface ISClusRegistryKeys : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrRegistryKey);
    HRESULT AddItem(BSTR bstrRegistryKey);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("f2e6072c-2631-11d1-89f1-00a0c90d061e")
interface ISClusCryptoKeys : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrCyrptoKey);
    HRESULT AddItem(BSTR bstrCryptoKey);
    HRESULT RemoveItem(VARIANT varIndex);
}

@GUID("f2e6072e-2631-11d1-89f1-00a0c90d061e")
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
