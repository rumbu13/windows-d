module windows.windowsclustering;

public import system;
public import windows.automation;
public import windows.com;
public import windows.gdi;
public import windows.security;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

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

enum CLUSTER_QUORUM_TYPE
{
    OperationalQuorum = 0,
    ModifyQuorum = 1,
}

struct CLUSTERVERSIONINFO_NT4
{
    uint dwVersionInfoSize;
    ushort MajorVersion;
    ushort MinorVersion;
    ushort BuildNumber;
    ushort szVendorId;
    ushort szCSDVersion;
}

struct CLUSTERVERSIONINFO
{
    uint dwVersionInfoSize;
    ushort MajorVersion;
    ushort MinorVersion;
    ushort BuildNumber;
    ushort szVendorId;
    ushort szCSDVersion;
    uint dwClusterHighestVersion;
    uint dwClusterLowestVersion;
    uint dwFlags;
    uint dwReserved;
}

struct CLUS_STARTING_PARAMS
{
    uint dwSize;
    BOOL bForm;
    BOOL bFirst;
}

enum NODE_CLUSTER_STATE
{
    ClusterStateNotInstalled = 0,
    ClusterStateNotConfigured = 1,
    ClusterStateNotRunning = 3,
    ClusterStateRunning = 19,
}

enum CLUSTER_RESOURCE_STATE_CHANGE_REASON
{
    eResourceStateChangeReasonUnknown = 0,
    eResourceStateChangeReasonMove = 1,
    eResourceStateChangeReasonFailover = 2,
    eResourceStateChangeReasonFailedMove = 3,
    eResourceStateChangeReasonShutdown = 4,
    eResourceStateChangeReasonRundown = 5,
}

enum CLUSTER_REG_COMMAND
{
    CLUSREG_COMMAND_NONE = 0,
    CLUSREG_SET_VALUE = 1,
    CLUSREG_CREATE_KEY = 2,
    CLUSREG_DELETE_KEY = 3,
    CLUSREG_DELETE_VALUE = 4,
    CLUSREG_SET_KEY_SECURITY = 5,
    CLUSREG_VALUE_DELETED = 6,
    CLUSREG_READ_KEY = 7,
    CLUSREG_READ_VALUE = 8,
    CLUSREG_READ_ERROR = 9,
    CLUSREG_CONTROL_COMMAND = 10,
    CLUSREG_CONDITION_EXISTS = 11,
    CLUSREG_CONDITION_NOT_EXISTS = 12,
    CLUSREG_CONDITION_IS_EQUAL = 13,
    CLUSREG_CONDITION_IS_NOT_EQUAL = 14,
    CLUSREG_CONDITION_IS_GREATER_THAN = 15,
    CLUSREG_CONDITION_IS_LESS_THAN = 16,
    CLUSREG_CONDITION_KEY_EXISTS = 17,
    CLUSREG_CONDITION_KEY_NOT_EXISTS = 18,
    CLUSREG_LAST_COMMAND = 19,
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
    uint dwOptions;
    const(wchar)* wzName;
    const(ubyte)* lpData;
    uint cbData;
}

struct CLUSTER_READ_BATCH_COMMAND
{
    CLUSTER_REG_COMMAND Command;
    uint dwOptions;
    const(wchar)* wzSubkeyName;
    const(wchar)* wzValueName;
    const(ubyte)* lpData;
    uint cbData;
}

struct CLUSTER_ENUM_ITEM
{
    uint dwVersion;
    uint dwType;
    uint cbId;
    const(wchar)* lpszId;
    uint cbName;
    const(wchar)* lpszName;
}

enum CLUSGROUP_TYPE
{
    ClusGroupTypeCoreCluster = 1,
    ClusGroupTypeAvailableStorage = 2,
    ClusGroupTypeTemporary = 3,
    ClusGroupTypeSharedVolume = 4,
    ClusGroupTypeStoragePool = 5,
    ClusGroupTypeFileServer = 100,
    ClusGroupTypePrintServer = 101,
    ClusGroupTypeDhcpServer = 102,
    ClusGroupTypeDtc = 103,
    ClusGroupTypeMsmq = 104,
    ClusGroupTypeWins = 105,
    ClusGroupTypeStandAloneDfs = 106,
    ClusGroupTypeGenericApplication = 107,
    ClusGroupTypeGenericService = 108,
    ClusGroupTypeGenericScript = 109,
    ClusGroupTypeIScsiNameService = 110,
    ClusGroupTypeVirtualMachine = 111,
    ClusGroupTypeTsSessionBroker = 112,
    ClusGroupTypeIScsiTarget = 113,
    ClusGroupTypeScaleoutFileServer = 114,
    ClusGroupTypeVMReplicaBroker = 115,
    ClusGroupTypeTaskScheduler = 116,
    ClusGroupTypeClusterUpdateAgent = 117,
    ClusGroupTypeScaleoutCluster = 118,
    ClusGroupTypeStorageReplica = 119,
    ClusGroupTypeVMReplicaCoordinator = 120,
    ClusGroupTypeCrossClusterOrchestrator = 121,
    ClusGroupTypeInfrastructureFileServer = 122,
    ClusGroupTypeUnknown = 9999,
}

struct CLUSTER_CREATE_GROUP_INFO
{
    uint dwVersion;
    CLUSGROUP_TYPE groupType;
}

enum CLUSTER_MGMT_POINT_TYPE
{
    CLUSTER_MGMT_POINT_TYPE_NONE = 0,
    CLUSTER_MGMT_POINT_TYPE_CNO = 1,
    CLUSTER_MGMT_POINT_TYPE_DNS_ONLY = 2,
    CLUSTER_MGMT_POINT_TYPE_CNO_ONLY = 3,
}

enum CLUSTER_MGMT_POINT_RESTYPE
{
    CLUSTER_MGMT_POINT_RESTYPE_AUTO = 0,
    CLUSTER_MGMT_POINT_RESTYPE_SNN = 1,
    CLUSTER_MGMT_POINT_RESTYPE_DNN = 2,
}

enum CLUSTER_CLOUD_TYPE
{
    CLUSTER_CLOUD_TYPE_NONE = 0,
    CLUSTER_CLOUD_TYPE_AZURE = 1,
    CLUSTER_CLOUD_TYPE_MIXED = 128,
    CLUSTER_CLOUD_TYPE_UNKNOWN = -1,
}

enum CLUS_GROUP_START_SETTING
{
    CLUS_GROUP_START_ALWAYS = 0,
    CLUS_GROUP_DO_NOT_START = 1,
    CLUS_GROUP_START_ALLOWED = 2,
}

enum CLUS_AFFINITY_RULE_TYPE
{
    CLUS_AFFINITY_RULE_NONE = 0,
    CLUS_AFFINITY_RULE_SAME_FAULT_DOMAIN = 1,
    CLUS_AFFINITY_RULE_SAME_NODE = 2,
    CLUS_AFFINITY_RULE_DIFFERENT_FAULT_DOMAIN = 3,
    CLUS_AFFINITY_RULE_DIFFERENT_NODE = 4,
    CLUS_AFFINITY_RULE_MIN = 0,
    CLUS_AFFINITY_RULE_MAX = 4,
}

enum CLUSTER_QUORUM_VALUE
{
    CLUSTER_QUORUM_MAINTAINED = 0,
    CLUSTER_QUORUM_LOST = 1,
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
    uint NodeId;
    ubyte SetAttempted;
    uint ReturnStatus;
}

struct CLUSTER_IP_ENTRY
{
    const(wchar)* lpszIpAddress;
    uint dwPrefixLength;
}

struct CREATE_CLUSTER_CONFIG
{
    uint dwVersion;
    const(wchar)* lpszClusterName;
    uint cNodes;
    ushort** ppszNodeNames;
    uint cIpEntries;
    CLUSTER_IP_ENTRY* pIpEntries;
    ubyte fEmptyCluster;
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
}

struct CREATE_CLUSTER_NAME_ACCOUNT
{
    uint dwVersion;
    const(wchar)* lpszClusterName;
    uint dwFlags;
    const(wchar)* pszUserName;
    const(wchar)* pszPassword;
    const(wchar)* pszDomain;
    CLUSTER_MGMT_POINT_TYPE managementPointType;
    CLUSTER_MGMT_POINT_RESTYPE managementPointResType;
    ubyte bUpgradeVCOs;
}

alias PCLUSAPI_GET_NODE_CLUSTER_STATE = extern(Windows) uint function(const(wchar)* lpszNodeName, uint* pdwClusterState);
alias PCLUSAPI_OPEN_CLUSTER = extern(Windows) _HCLUSTER* function(const(wchar)* lpszClusterName);
alias PCLUSAPI_OPEN_CLUSTER_EX = extern(Windows) _HCLUSTER* function(const(wchar)* lpszClusterName, uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER = extern(Windows) BOOL function(_HCLUSTER* hCluster);
alias PCLUSAPI_SetClusterName = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszNewClusterName);
alias PCLUSAPI_GET_CLUSTER_INFORMATION = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszClusterName, uint* lpcchClusterName, CLUSTERVERSIONINFO* lpClusterInfo);
alias PCLUSAPI_GET_CLUSTER_QUORUM_RESOURCE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, uint* lpcchResourceName, const(wchar)* lpszDeviceName, uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);
alias PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE = extern(Windows) uint function(_HRESOURCE* hResource, const(wchar)* lpszDeviceName, uint dwMaxQuoLogSize);
alias PCLUSAPI_BACKUP_CLUSTER_DATABASE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszPathName);
alias PCLUSAPI_RESTORE_CLUSTER_DATABASE = extern(Windows) uint function(const(wchar)* lpszPathName, BOOL bForce, const(wchar)* lpszQuorumDriveLetter);
alias PCLUSAPI_SET_CLUSTER_NETWORK_PRIORITY_ORDER = extern(Windows) uint function(_HCLUSTER* hCluster, uint NetworkCount, char* NetworkList);
alias PCLUSAPI_SET_CLUSTER_SERVICE_ACCOUNT_PASSWORD = extern(Windows) uint function(const(wchar)* lpszClusterName, const(wchar)* lpszNewPassword, uint dwFlags, char* lpReturnStatusBuffer, uint* lpcbReturnStatusBufferSize);
alias PCLUSAPI_CLUSTER_CONTROL = extern(Windows) uint function(_HCLUSTER* hCluster, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);
enum CLUSTER_UPGRADE_PHASE
{
    ClusterUpgradePhaseInitialize = 1,
    ClusterUpgradePhaseValidatingUpgrade = 2,
    ClusterUpgradePhaseUpgradingComponents = 3,
    ClusterUpgradePhaseInstallingNewComponents = 4,
    ClusterUpgradePhaseUpgradeComplete = 5,
}

alias PCLUSTER_UPGRADE_PROGRESS_CALLBACK = extern(Windows) BOOL function(void* pvCallbackArg, CLUSTER_UPGRADE_PHASE eUpgradePhase);
alias PCLUSAPI_CLUSTER_UPGRADE = extern(Windows) uint function(_HCLUSTER* hCluster, BOOL perform, PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);
enum CLUSTER_CHANGE
{
    CLUSTER_CHANGE_NODE_STATE = 1,
    CLUSTER_CHANGE_NODE_DELETED = 2,
    CLUSTER_CHANGE_NODE_ADDED = 4,
    CLUSTER_CHANGE_NODE_PROPERTY = 8,
    CLUSTER_CHANGE_REGISTRY_NAME = 16,
    CLUSTER_CHANGE_REGISTRY_ATTRIBUTES = 32,
    CLUSTER_CHANGE_REGISTRY_VALUE = 64,
    CLUSTER_CHANGE_REGISTRY_SUBTREE = 128,
    CLUSTER_CHANGE_RESOURCE_STATE = 256,
    CLUSTER_CHANGE_RESOURCE_DELETED = 512,
    CLUSTER_CHANGE_RESOURCE_ADDED = 1024,
    CLUSTER_CHANGE_RESOURCE_PROPERTY = 2048,
    CLUSTER_CHANGE_GROUP_STATE = 4096,
    CLUSTER_CHANGE_GROUP_DELETED = 8192,
    CLUSTER_CHANGE_GROUP_ADDED = 16384,
    CLUSTER_CHANGE_GROUP_PROPERTY = 32768,
    CLUSTER_CHANGE_RESOURCE_TYPE_DELETED = 65536,
    CLUSTER_CHANGE_RESOURCE_TYPE_ADDED = 131072,
    CLUSTER_CHANGE_RESOURCE_TYPE_PROPERTY = 262144,
    CLUSTER_CHANGE_CLUSTER_RECONNECT = 524288,
    CLUSTER_CHANGE_NETWORK_STATE = 1048576,
    CLUSTER_CHANGE_NETWORK_DELETED = 2097152,
    CLUSTER_CHANGE_NETWORK_ADDED = 4194304,
    CLUSTER_CHANGE_NETWORK_PROPERTY = 8388608,
    CLUSTER_CHANGE_NETINTERFACE_STATE = 16777216,
    CLUSTER_CHANGE_NETINTERFACE_DELETED = 33554432,
    CLUSTER_CHANGE_NETINTERFACE_ADDED = 67108864,
    CLUSTER_CHANGE_NETINTERFACE_PROPERTY = 134217728,
    CLUSTER_CHANGE_QUORUM_STATE = 268435456,
    CLUSTER_CHANGE_CLUSTER_STATE = 536870912,
    CLUSTER_CHANGE_CLUSTER_PROPERTY = 1073741824,
    CLUSTER_CHANGE_HANDLE_CLOSE = -2147483648,
    CLUSTER_CHANGE_ALL = -1,
}

enum CLUSTER_NOTIFICATIONS_VERSION
{
    CLUSTER_NOTIFICATIONS_V1 = 1,
    CLUSTER_NOTIFICATIONS_V2 = 2,
}

enum CLUSTER_CHANGE_CLUSTER_V2
{
    CLUSTER_CHANGE_CLUSTER_RECONNECT_V2 = 1,
    CLUSTER_CHANGE_CLUSTER_STATE_V2 = 2,
    CLUSTER_CHANGE_CLUSTER_GROUP_ADDED_V2 = 4,
    CLUSTER_CHANGE_CLUSTER_HANDLE_CLOSE_V2 = 8,
    CLUSTER_CHANGE_CLUSTER_NETWORK_ADDED_V2 = 16,
    CLUSTER_CHANGE_CLUSTER_NODE_ADDED_V2 = 32,
    CLUSTER_CHANGE_CLUSTER_RESOURCE_TYPE_ADDED_V2 = 64,
    CLUSTER_CHANGE_CLUSTER_COMMON_PROPERTY_V2 = 128,
    CLUSTER_CHANGE_CLUSTER_PRIVATE_PROPERTY_V2 = 256,
    CLUSTER_CHANGE_CLUSTER_LOST_NOTIFICATIONS_V2 = 512,
    CLUSTER_CHANGE_CLUSTER_RENAME_V2 = 1024,
    CLUSTER_CHANGE_CLUSTER_MEMBERSHIP_V2 = 2048,
    CLUSTER_CHANGE_CLUSTER_UPGRADED_V2 = 4096,
    CLUSTER_CHANGE_CLUSTER_ALL_V2 = 8191,
}

enum CLUSTER_CHANGE_GROUP_V2
{
    CLUSTER_CHANGE_GROUP_DELETED_V2 = 1,
    CLUSTER_CHANGE_GROUP_COMMON_PROPERTY_V2 = 2,
    CLUSTER_CHANGE_GROUP_PRIVATE_PROPERTY_V2 = 4,
    CLUSTER_CHANGE_GROUP_STATE_V2 = 8,
    CLUSTER_CHANGE_GROUP_OWNER_NODE_V2 = 16,
    CLUSTER_CHANGE_GROUP_PREFERRED_OWNERS_V2 = 32,
    CLUSTER_CHANGE_GROUP_RESOURCE_ADDED_V2 = 64,
    CLUSTER_CHANGE_GROUP_RESOURCE_GAINED_V2 = 128,
    CLUSTER_CHANGE_GROUP_RESOURCE_LOST_V2 = 256,
    CLUSTER_CHANGE_GROUP_HANDLE_CLOSE_V2 = 512,
    CLUSTER_CHANGE_GROUP_ALL_V2 = 1023,
}

enum CLUSTER_CHANGE_GROUPSET_V2
{
    CLUSTER_CHANGE_GROUPSET_DELETED_v2 = 1,
    CLUSTER_CHANGE_GROUPSET_COMMON_PROPERTY_V2 = 2,
    CLUSTER_CHANGE_GROUPSET_PRIVATE_PROPERTY_V2 = 4,
    CLUSTER_CHANGE_GROUPSET_STATE_V2 = 8,
    CLUSTER_CHANGE_GROUPSET_GROUP_ADDED = 16,
    CLUSTER_CHANGE_GROUPSET_GROUP_REMOVED = 32,
    CLUSTER_CHANGE_GROUPSET_DEPENDENCIES_V2 = 64,
    CLUSTER_CHANGE_GROUPSET_DEPENDENTS_V2 = 128,
    CLUSTER_CHANGE_GROUPSET_HANDLE_CLOSE_v2 = 256,
    CLUSTER_CHANGE_GROUPSET_ALL_V2 = 511,
}

enum CLUSTER_CHANGE_RESOURCE_V2
{
    CLUSTER_CHANGE_RESOURCE_COMMON_PROPERTY_V2 = 1,
    CLUSTER_CHANGE_RESOURCE_PRIVATE_PROPERTY_V2 = 2,
    CLUSTER_CHANGE_RESOURCE_STATE_V2 = 4,
    CLUSTER_CHANGE_RESOURCE_OWNER_GROUP_V2 = 8,
    CLUSTER_CHANGE_RESOURCE_DEPENDENCIES_V2 = 16,
    CLUSTER_CHANGE_RESOURCE_DEPENDENTS_V2 = 32,
    CLUSTER_CHANGE_RESOURCE_POSSIBLE_OWNERS_V2 = 64,
    CLUSTER_CHANGE_RESOURCE_DELETED_V2 = 128,
    CLUSTER_CHANGE_RESOURCE_DLL_UPGRADED_V2 = 256,
    CLUSTER_CHANGE_RESOURCE_HANDLE_CLOSE_V2 = 512,
    CLUSTER_CHANGE_RESOURCE_TERMINAL_STATE_V2 = 1024,
    CLUSTER_CHANGE_RESOURCE_ALL_V2 = 2047,
}

enum CLUSTER_CHANGE_RESOURCE_TYPE_V2
{
    CLUSTER_CHANGE_RESOURCE_TYPE_DELETED_V2 = 1,
    CLUSTER_CHANGE_RESOURCE_TYPE_COMMON_PROPERTY_V2 = 2,
    CLUSTER_CHANGE_RESOURCE_TYPE_PRIVATE_PROPERTY_V2 = 4,
    CLUSTER_CHANGE_RESOURCE_TYPE_POSSIBLE_OWNERS_V2 = 8,
    CLUSTER_CHANGE_RESOURCE_TYPE_DLL_UPGRADED_V2 = 16,
    CLUSTER_RESOURCE_TYPE_SPECIFIC_V2 = 32,
    CLUSTER_CHANGE_RESOURCE_TYPE_ALL_V2 = 63,
}

enum CLUSTER_CHANGE_NETINTERFACE_V2
{
    CLUSTER_CHANGE_NETINTERFACE_DELETED_V2 = 1,
    CLUSTER_CHANGE_NETINTERFACE_COMMON_PROPERTY_V2 = 2,
    CLUSTER_CHANGE_NETINTERFACE_PRIVATE_PROPERTY_V2 = 4,
    CLUSTER_CHANGE_NETINTERFACE_STATE_V2 = 8,
    CLUSTER_CHANGE_NETINTERFACE_HANDLE_CLOSE_V2 = 16,
    CLUSTER_CHANGE_NETINTERFACE_ALL_V2 = 31,
}

enum CLUSTER_CHANGE_NETWORK_V2
{
    CLUSTER_CHANGE_NETWORK_DELETED_V2 = 1,
    CLUSTER_CHANGE_NETWORK_COMMON_PROPERTY_V2 = 2,
    CLUSTER_CHANGE_NETWORK_PRIVATE_PROPERTY_V2 = 4,
    CLUSTER_CHANGE_NETWORK_STATE_V2 = 8,
    CLUSTER_CHANGE_NETWORK_HANDLE_CLOSE_V2 = 16,
    CLUSTER_CHANGE_NETWORK_ALL_V2 = 31,
}

enum CLUSTER_CHANGE_NODE_V2
{
    CLUSTER_CHANGE_NODE_NETINTERFACE_ADDED_V2 = 1,
    CLUSTER_CHANGE_NODE_DELETED_V2 = 2,
    CLUSTER_CHANGE_NODE_COMMON_PROPERTY_V2 = 4,
    CLUSTER_CHANGE_NODE_PRIVATE_PROPERTY_V2 = 8,
    CLUSTER_CHANGE_NODE_STATE_V2 = 16,
    CLUSTER_CHANGE_NODE_GROUP_GAINED_V2 = 32,
    CLUSTER_CHANGE_NODE_GROUP_LOST_V2 = 64,
    CLUSTER_CHANGE_NODE_HANDLE_CLOSE_V2 = 128,
    CLUSTER_CHANGE_NODE_ALL_V2 = 255,
}

enum CLUSTER_CHANGE_REGISTRY_V2
{
    CLUSTER_CHANGE_REGISTRY_ATTRIBUTES_V2 = 1,
    CLUSTER_CHANGE_REGISTRY_NAME_V2 = 2,
    CLUSTER_CHANGE_REGISTRY_SUBTREE_V2 = 4,
    CLUSTER_CHANGE_REGISTRY_VALUE_V2 = 8,
    CLUSTER_CHANGE_REGISTRY_HANDLE_CLOSE_V2 = 16,
    CLUSTER_CHANGE_REGISTRY_ALL_V2 = 31,
}

enum CLUSTER_CHANGE_QUORUM_V2
{
    CLUSTER_CHANGE_QUORUM_STATE_V2 = 1,
    CLUSTER_CHANGE_QUORUM_ALL_V2 = 1,
}

enum CLUSTER_CHANGE_SHARED_VOLUME_V2
{
    CLUSTER_CHANGE_SHARED_VOLUME_STATE_V2 = 1,
    CLUSTER_CHANGE_SHARED_VOLUME_ADDED_V2 = 2,
    CLUSTER_CHANGE_SHARED_VOLUME_REMOVED_V2 = 4,
    CLUSTER_CHANGE_SHARED_VOLUME_ALL_V2 = 7,
}

enum CLUSTER_CHANGE_SPACEPORT_V2
{
    CLUSTER_CHANGE_SPACEPORT_CUSTOM_PNP_V2 = 1,
}

enum CLUSTER_CHANGE_NODE_UPGRADE_PHASE_V2
{
    CLUSTER_CHANGE_UPGRADE_NODE_PREPARE = 1,
    CLUSTER_CHANGE_UPGRADE_NODE_COMMIT = 2,
    CLUSTER_CHANGE_UPGRADE_NODE_POSTCOMMIT = 4,
    CLUSTER_CHANGE_UPGRADE_ALL = 7,
}

enum CLUSTER_OBJECT_TYPE
{
    CLUSTER_OBJECT_TYPE_NONE = 0,
    CLUSTER_OBJECT_TYPE_CLUSTER = 1,
    CLUSTER_OBJECT_TYPE_GROUP = 2,
    CLUSTER_OBJECT_TYPE_RESOURCE = 3,
    CLUSTER_OBJECT_TYPE_RESOURCE_TYPE = 4,
    CLUSTER_OBJECT_TYPE_NETWORK_INTERFACE = 5,
    CLUSTER_OBJECT_TYPE_NETWORK = 6,
    CLUSTER_OBJECT_TYPE_NODE = 7,
    CLUSTER_OBJECT_TYPE_REGISTRY = 8,
    CLUSTER_OBJECT_TYPE_QUORUM = 9,
    CLUSTER_OBJECT_TYPE_SHARED_VOLUME = 10,
    CLUSTER_OBJECT_TYPE_GROUPSET = 13,
    CLUSTER_OBJECT_TYPE_AFFINITYRULE = 16,
}

enum CLUSTERSET_OBJECT_TYPE
{
    CLUSTERSET_OBJECT_TYPE_NONE = 0,
    CLUSTERSET_OBJECT_TYPE_MEMBER = 1,
    CLUSTERSET_OBJECT_TYPE_WORKLOAD = 2,
    CLUSTERSET_OBJECT_TYPE_DATABASE = 3,
}

struct NOTIFY_FILTER_AND_TYPE
{
    uint dwObjectType;
    long FilterFlags;
}

struct CLUSTER_MEMBERSHIP_INFO
{
    BOOL HasQuorum;
    uint UpnodesSize;
    ubyte Upnodes;
}

alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT_V2 = extern(Windows) _HCHANGE* function(_HCHANGE* hChange, _HCLUSTER* hCluster, NOTIFY_FILTER_AND_TYPE* Filters, uint dwFilterCount, uint dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY_V2 = extern(Windows) uint function(_HCHANGE* hChange, NOTIFY_FILTER_AND_TYPE Filter, HANDLE hObject, uint dwNotifyKey);
alias PCLUSAPI_GET_NOTIFY_EVENT_HANDLE_V2 = extern(Windows) uint function(_HCHANGE* hChange, int* lphTargetEvent);
alias PCLUSAPI_GET_CLUSTER_NOTIFY_V2 = extern(Windows) uint function(_HCHANGE* hChange, uint* lpdwNotifyKey, NOTIFY_FILTER_AND_TYPE* pFilterAndType, ubyte* buffer, uint* lpcchBufferSize, const(wchar)* lpszObjectId, uint* lpcchObjectId, const(wchar)* lpszParentId, uint* lpcchParentId, const(wchar)* lpszName, uint* lpcchName, const(wchar)* lpszType, uint* lpcchType, uint dwMilliseconds);
alias PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT = extern(Windows) _HCHANGE* function(_HCHANGE* hChange, _HCLUSTER* hCluster, uint dwFilter, uint dwNotifyKey);
alias PCLUSAPI_REGISTER_CLUSTER_NOTIFY = extern(Windows) uint function(_HCHANGE* hChange, uint dwFilterType, HANDLE hObject, uint dwNotifyKey);
alias PCLUSAPI_GET_CLUSTER_NOTIFY = extern(Windows) uint function(_HCHANGE* hChange, uint* lpdwNotifyKey, uint* lpdwFilterType, const(wchar)* lpszName, uint* lpcchName, uint dwMilliseconds);
alias PCLUSAPI_CLOSE_CLUSTER_NOTIFY_PORT = extern(Windows) BOOL function(_HCHANGE* hChange);
enum CLUSTER_ENUM
{
    CLUSTER_ENUM_NODE = 1,
    CLUSTER_ENUM_RESTYPE = 2,
    CLUSTER_ENUM_RESOURCE = 4,
    CLUSTER_ENUM_GROUP = 8,
    CLUSTER_ENUM_NETWORK = 16,
    CLUSTER_ENUM_NETINTERFACE = 32,
    CLUSTER_ENUM_SHARED_VOLUME_GROUP = 536870912,
    CLUSTER_ENUM_SHARED_VOLUME_RESOURCE = 1073741824,
    CLUSTER_ENUM_INTERNAL_NETWORK = -2147483648,
    CLUSTER_ENUM_ALL = 63,
}

alias PCLUSAPI_CLUSTER_OPEN_ENUM = extern(Windows) _HCLUSENUM* function(_HCLUSTER* hCluster, uint dwType);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT = extern(Windows) uint function(_HCLUSENUM* hEnum);
alias PCLUSAPI_CLUSTER_ENUM = extern(Windows) uint function(_HCLUSENUM* hEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM = extern(Windows) uint function(_HCLUSENUM* hEnum);
alias PCLUSAPI_CLUSTER_OPEN_ENUM_EX = extern(Windows) _HCLUSENUMEX* function(_HCLUSTER* hCluster, uint dwType, void* pOptions);
alias PCLUSAPI_CLUSTER_GET_ENUM_COUNT_EX = extern(Windows) uint function(_HCLUSENUMEX* hClusterEnum);
alias PCLUSAPI_CLUSTER_ENUM_EX = extern(Windows) uint function(_HCLUSENUMEX* hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_CLOSE_ENUM_EX = extern(Windows) uint function(_HCLUSENUMEX* hClusterEnum);
alias PCLUSAPI_CREATE_CLUSTER_GROUP_GROUPSET = extern(Windows) _HGROUPSET* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupSetName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_GROUPSET = extern(Windows) _HGROUPSET* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupSetName);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP_GROUPSET = extern(Windows) BOOL function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_DELETE_CLUSTER_GROUP_GROUPSET = extern(Windows) uint function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_GROUP_GROUPSET = extern(Windows) uint function(_HGROUPSET* hGroupSet, _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_GROUP_GROUPSET = extern(Windows) uint function(_HGROUPSET* hGroupSet, _HGROUP* hGroupName);
alias PCLUSAPI_CLUSTER_GROUP_GROUPSET_CONTROL = extern(Windows) uint function(_HGROUPSET* hGroupSet, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_ADD_CLUSTER_GROUP_DEPENDENCY = extern(Windows) uint function(_HGROUP* hDependentGroup, _HGROUP* hProviderGroup);
alias PCLUSAPI_SET_GROUP_DEPENDENCY_EXPRESSION = extern(Windows) uint function(_HGROUP* hGroupSet, const(wchar)* lpszDependencyExpression);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_DEPENDENCY = extern(Windows) uint function(_HGROUP* hGroup, _HGROUP* hDependsOn);
alias PCLUSAPI_ADD_CLUSTER_GROUP_GROUPSET_DEPENDENCY = extern(Windows) uint function(_HGROUPSET* hDependentGroupSet, _HGROUPSET* hProviderGroupSet);
alias PCLUSAPI_SET_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EXPRESSION = extern(Windows) uint function(_HGROUPSET* hGroupSet, const(wchar)* lpszDependencyExpression);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_GROUPSET_DEPENDENCY = extern(Windows) uint function(_HGROUPSET* hGroupSet, _HGROUPSET* hDependsOn);
alias PCLUSAPI_ADD_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = extern(Windows) uint function(_HGROUP* hDependentGroup, _HGROUPSET* hProviderGroupSet);
alias PCLUSAPI_REMOVE_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY = extern(Windows) uint function(_HGROUP* hGroup, _HGROUPSET* hDependsOn);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP_GROUPSET = extern(Windows) _HCLUSTER* function(_HGROUPSET* hGroupSet);
alias PCLUSAPI_ADD_CROSS_CLUSTER_GROUPSET_DEPENDENCY = extern(Windows) uint function(_HGROUPSET* hDependentGroupSet, const(wchar)* lpRemoteClusterName, const(wchar)* lpRemoteGroupSetName);
alias PCLUSAPI_REMOVE_CROSS_CLUSTER_GROUPSET_DEPENDENCY = extern(Windows) uint function(_HGROUPSET* hDependentGroupSet, const(wchar)* lpRemoteClusterName, const(wchar)* lpRemoteGroupSetName);
struct CLUSTER_AVAILABILITY_SET_CONFIG
{
    uint dwVersion;
    uint dwUpdateDomains;
    uint dwFaultDomains;
    BOOL bReserveSpareNode;
}

alias PCLUSAPI_CREATE_CLUSTER_AVAILABILITY_SET = extern(Windows) _HGROUPSET* function(_HCLUSTER* hCluster, const(wchar)* lpAvailabilitySetName, CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);
alias PCLUSAPI_CLUSTER_CREATE_AFFINITY_RULE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* ruleName, CLUS_AFFINITY_RULE_TYPE ruleType);
alias PCLUSAPI_CLUSTER_REMOVE_AFFINITY_RULE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* ruleName);
alias PCLUSAPI_CLUSTER_ADD_GROUP_TO_AFFINITY_RULE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* ruleName, _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_AFFINITY_RULE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* ruleName, _HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_AFFINITY_RULE_CONTROL = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* affinityRuleName, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);
enum CLUSTER_NODE_ENUM
{
    CLUSTER_NODE_ENUM_NETINTERFACES = 1,
    CLUSTER_NODE_ENUM_GROUPS = 2,
    CLUSTER_NODE_ENUM_PREFERRED_GROUPS = 4,
    CLUSTER_NODE_ENUM_ALL = 3,
}

enum CLUSTER_NODE_STATE
{
    ClusterNodeStateUnknown = -1,
    ClusterNodeUp = 0,
    ClusterNodeDown = 1,
    ClusterNodePaused = 2,
    ClusterNodeJoining = 3,
}

enum CLUSTER_STORAGENODE_STATE
{
    ClusterStorageNodeStateUnknown = 0,
    ClusterStorageNodeUp = 1,
    ClusterStorageNodeDown = 2,
    ClusterStorageNodePaused = 3,
    ClusterStorageNodeStarting = 4,
    ClusterStorageNodeStopping = 5,
}

enum CLUSTER_NODE_DRAIN_STATUS
{
    NodeDrainStatusNotInitiated = 0,
    NodeDrainStatusInProgress = 1,
    NodeDrainStatusCompleted = 2,
    NodeDrainStatusFailed = 3,
    ClusterNodeDrainStatusCount = 4,
}

enum CLUSTER_NODE_STATUS
{
    NodeStatusNormal = 0,
    NodeStatusIsolated = 1,
    NodeStatusQuarantined = 2,
    NodeStatusDrainInProgress = 4,
    NodeStatusDrainCompleted = 8,
    NodeStatusDrainFailed = 16,
    NodeStatusAvoidPlacement = 32,
    NodeStatusMax = 51,
}

alias PCLUSAPI_OPEN_CLUSTER_NODE = extern(Windows) _HNODE* function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName);
alias PCLUSAPI_OPEN_CLUSTER_NODE_EX = extern(Windows) _HNODE* function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_OPEN_NODE_BY_ID = extern(Windows) _HNODE* function(_HCLUSTER* hCluster, uint nodeId);
alias PCLUSAPI_CLOSE_CLUSTER_NODE = extern(Windows) BOOL function(_HNODE* hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_STATE = extern(Windows) CLUSTER_NODE_STATE function(_HNODE* hNode);
alias PCLUSAPI_GET_CLUSTER_NODE_ID = extern(Windows) uint function(_HNODE* hNode, const(wchar)* lpszNodeId, uint* lpcchName);
alias PCLUSAPI_GET_CLUSTER_FROM_NODE = extern(Windows) _HCLUSTER* function(_HNODE* hNode);
alias PCLUSAPI_PAUSE_CLUSTER_NODE = extern(Windows) uint function(_HNODE* hNode);
alias PCLUSAPI_RESUME_CLUSTER_NODE = extern(Windows) uint function(_HNODE* hNode);
alias PCLUSAPI_EVICT_CLUSTER_NODE = extern(Windows) uint function(_HNODE* hNode);
alias PCLUSAPI_CLUSTER_NODE_OPEN_ENUM = extern(Windows) _HNODEENUM* function(_HNODE* hNode, uint dwType);
alias PCLUSAPI_CLUSTER_NODE_OPEN_ENUM_EX = extern(Windows) _HNODEENUMEX* function(_HNODE* hNode, uint dwType, void* pOptions);
alias PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT_EX = extern(Windows) uint function(_HNODEENUMEX* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_ENUM_EX = extern(Windows) uint function(_HNODEENUMEX* hNodeEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM_EX = extern(Windows) uint function(_HNODEENUMEX* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT = extern(Windows) uint function(_HNODEENUM* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM = extern(Windows) uint function(_HNODEENUM* hNodeEnum);
alias PCLUSAPI_CLUSTER_NODE_ENUM = extern(Windows) uint function(_HNODEENUM* hNodeEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_EVICT_CLUSTER_NODE_EX = extern(Windows) uint function(_HNODE* hNode, uint dwTimeOut, int* phrCleanupStatus);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_TYPE_KEY = extern(Windows) HKEY function(_HCLUSTER* hCluster, const(wchar)* lpszTypeName, uint samDesired);
enum CLUSTER_GROUP_ENUM
{
    CLUSTER_GROUP_ENUM_CONTAINS = 1,
    CLUSTER_GROUP_ENUM_NODES = 2,
    CLUSTER_GROUP_ENUM_ALL = 3,
}

enum CLUSTER_GROUP_STATE
{
    ClusterGroupStateUnknown = -1,
    ClusterGroupOnline = 0,
    ClusterGroupOffline = 1,
    ClusterGroupFailed = 2,
    ClusterGroupPartialOnline = 3,
    ClusterGroupPending = 4,
}

enum CLUSTER_GROUP_PRIORITY
{
    PriorityDisabled = 0,
    PriorityLow = 1000,
    PriorityMedium = 2000,
    PriorityHigh = 3000,
}

enum CLUSTER_GROUP_AUTOFAILBACK_TYPE
{
    ClusterGroupPreventFailback = 0,
    ClusterGroupAllowFailback = 1,
    ClusterGroupFailbackTypeCount = 2,
}

struct CLUSTER_GROUP_ENUM_ITEM
{
    uint dwVersion;
    uint cbId;
    const(wchar)* lpszId;
    uint cbName;
    const(wchar)* lpszName;
    CLUSTER_GROUP_STATE state;
    uint cbOwnerNode;
    const(wchar)* lpszOwnerNode;
    uint dwFlags;
    uint cbProperties;
    void* pProperties;
    uint cbRoProperties;
    void* pRoProperties;
}

struct CLUSTER_RESOURCE_ENUM_ITEM
{
    uint dwVersion;
    uint cbId;
    const(wchar)* lpszId;
    uint cbName;
    const(wchar)* lpszName;
    uint cbOwnerGroupName;
    const(wchar)* lpszOwnerGroupName;
    uint cbOwnerGroupId;
    const(wchar)* lpszOwnerGroupId;
    uint cbProperties;
    void* pProperties;
    uint cbRoProperties;
    void* pRoProperties;
}

alias PCLUSAPI_CREATE_CLUSTER_GROUP = extern(Windows) _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP = extern(Windows) _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);
alias PCLUSAPI_OPEN_CLUSTER_GROUP_EX = extern(Windows) _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_PAUSE_CLUSTER_NODE_EX = extern(Windows) uint function(_HNODE* hNode, BOOL bDrainNode, uint dwPauseFlags, _HNODE* hNodeDrainTarget);
enum CLUSTER_NODE_RESUME_FAILBACK_TYPE
{
    DoNotFailbackGroups = 0,
    FailbackGroupsImmediately = 1,
    FailbackGroupsPerPolicy = 2,
    ClusterNodeResumeFailbackTypeCount = 3,
}

alias PCLUSAPI_RESUME_CLUSTER_NODE_EX = extern(Windows) uint function(_HNODE* hNode, CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, uint dwResumeFlagsReserved);
alias PCLUSAPI_CREATE_CLUSTER_GROUPEX = extern(Windows) _HGROUP* function(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, CLUSTER_CREATE_GROUP_INFO* pGroupInfo);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM_EX = extern(Windows) _HGROUPENUMEX* function(_HCLUSTER* hCluster, const(wchar)* lpszProperties, uint cbProperties, const(wchar)* lpszRoProperties, uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT_EX = extern(Windows) uint function(_HGROUPENUMEX* hGroupEnumEx);
alias PCLUSAPI_CLUSTER_GROUP_ENUM_EX = extern(Windows) uint function(_HGROUPENUMEX* hGroupEnumEx, uint dwIndex, CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM_EX = extern(Windows) uint function(_HGROUPENUMEX* hGroupEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM_EX = extern(Windows) _HRESENUMEX* function(_HCLUSTER* hCluster, const(wchar)* lpszProperties, uint cbProperties, const(wchar)* lpszRoProperties, uint cbRoProperties, uint dwFlags);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT_EX = extern(Windows) uint function(_HRESENUMEX* hResourceEnumEx);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM_EX = extern(Windows) uint function(_HRESENUMEX* hResourceEnumEx, uint dwIndex, CLUSTER_RESOURCE_ENUM_ITEM* pItem, uint* cbItem);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM_EX = extern(Windows) uint function(_HRESENUMEX* hResourceEnumEx);
alias PCLUSAPI_RESTART_CLUSTER_RESOURCE = extern(Windows) uint function(_HRESOURCE* hResource, uint dwFlags);
alias PCLUSAPI_CLOSE_CLUSTER_GROUP = extern(Windows) BOOL function(_HGROUP* hGroup);
alias PCLUSAPI_GET_CLUSTER_FROM_GROUP = extern(Windows) _HCLUSTER* function(_HGROUP* hGroup);
alias PCLUSAPI_GET_CLUSTER_GROUP_STATE = extern(Windows) CLUSTER_GROUP_STATE function(_HGROUP* hGroup, const(wchar)* lpszNodeName, uint* lpcchNodeName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NAME = extern(Windows) uint function(_HGROUP* hGroup, const(wchar)* lpszGroupName);
alias PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST = extern(Windows) uint function(_HGROUP* hGroup, uint NodeCount, char* NodeList);
alias PCLUSAPI_ONLINE_CLUSTER_GROUP = extern(Windows) uint function(_HGROUP* hGroup, _HNODE* hDestinationNode);
alias PCLUSAPI_MOVE_CLUSTER_GROUP = extern(Windows) uint function(_HGROUP* hGroup, _HNODE* hDestinationNode);
alias PCLUSAPI_OFFLINE_CLUSTER_GROUP = extern(Windows) uint function(_HGROUP* hGroup);
alias PCLUSAPI_DELETE_CLUSTER_GROUP = extern(Windows) uint function(_HGROUP* hGroup);
alias PCLUSAPI_DESTROY_CLUSTER_GROUP = extern(Windows) uint function(_HGROUP* hGroup);
alias PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM = extern(Windows) _HGROUPENUM* function(_HGROUP* hGroup, uint dwType);
alias PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT = extern(Windows) uint function(_HGROUPENUM* hGroupEnum);
alias PCLUSAPI_CLUSTER_GROUP_ENUM = extern(Windows) uint function(_HGROUPENUM* hGroupEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszResourceName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM = extern(Windows) uint function(_HGROUPENUM* hGroupEnum);
enum CLUSTER_RESOURCE_STATE
{
    ClusterResourceStateUnknown = -1,
    ClusterResourceInherited = 0,
    ClusterResourceInitializing = 1,
    ClusterResourceOnline = 2,
    ClusterResourceOffline = 3,
    ClusterResourceFailed = 4,
    ClusterResourcePending = 128,
    ClusterResourceOnlinePending = 129,
    ClusterResourceOfflinePending = 130,
}

enum CLUSTER_RESOURCE_RESTART_ACTION
{
    ClusterResourceDontRestart = 0,
    ClusterResourceRestartNoNotify = 1,
    ClusterResourceRestartNotify = 2,
    ClusterResourceRestartActionCount = 3,
}

enum CLUSTER_RESOURCE_EMBEDDED_FAILURE_ACTION
{
    ClusterResourceEmbeddedFailureActionNone = 0,
    ClusterResourceEmbeddedFailureActionLogOnly = 1,
    ClusterResourceEmbeddedFailureActionRecover = 2,
}

enum CLUSTER_RESOURCE_CREATE_FLAGS
{
    CLUSTER_RESOURCE_DEFAULT_MONITOR = 0,
    CLUSTER_RESOURCE_SEPARATE_MONITOR = 1,
    CLUSTER_RESOURCE_VALID_FLAGS = 1,
}

enum CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE
{
    ClusterSharedVolumeSnapshotStateUnknown = 0,
    ClusterSharedVolumePrepareForHWSnapshot = 1,
    ClusterSharedVolumeHWSnapshotCompleted = 2,
    ClusterSharedVolumePrepareForFreeze = 3,
}

alias PCLUSAPI_CREATE_CLUSTER_RESOURCE = extern(Windows) _HRESOURCE* function(_HGROUP* hGroup, const(wchar)* lpszResourceName, const(wchar)* lpszResourceType, uint dwFlags);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE = extern(Windows) _HRESOURCE* function(_HCLUSTER* hCluster, const(wchar)* lpszResourceName);
alias PCLUSAPI_OPEN_CLUSTER_RESOURCE_EX = extern(Windows) _HRESOURCE* function(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_RESOURCE = extern(Windows) BOOL function(_HRESOURCE* hResource);
alias PCLUSAPI_GET_CLUSTER_FROM_RESOURCE = extern(Windows) _HCLUSTER* function(_HRESOURCE* hResource);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE = extern(Windows) uint function(_HRESOURCE* hResource);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_STATE = extern(Windows) CLUSTER_RESOURCE_STATE function(_HRESOURCE* hResource, const(wchar)* lpszNodeName, uint* lpcchNodeName, const(wchar)* lpszGroupName, uint* lpcchGroupName);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_NAME = extern(Windows) uint function(_HRESOURCE* hResource, const(wchar)* lpszResourceName);
alias PCLUSAPI_FAIL_CLUSTER_RESOURCE = extern(Windows) uint function(_HRESOURCE* hResource);
alias PCLUSAPI_ONLINE_CLUSTER_RESOURCE = extern(Windows) uint function(_HRESOURCE* hResource);
alias PCLUSAPI_OFFLINE_CLUSTER_RESOURCE = extern(Windows) uint function(_HRESOURCE* hResource);
alias PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP = extern(Windows) uint function(_HRESOURCE* hResource, _HGROUP* hGroup);
alias PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP_EX = extern(Windows) uint function(_HRESOURCE* hResource, _HGROUP* hGroup, ulong Flags);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_NODE = extern(Windows) uint function(_HRESOURCE* hResource, _HNODE* hNode);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_NODE = extern(Windows) uint function(_HRESOURCE* hResource, _HNODE* hNode);
alias PCLUSAPI_ADD_CLUSTER_RESOURCE_DEPENDENCY = extern(Windows) uint function(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);
alias PCLUSAPI_REMOVE_CLUSTER_RESOURCE_DEPENDENCY = extern(Windows) uint function(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);
alias PCLUSAPI_SET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION = extern(Windows) uint function(_HRESOURCE* hResource, const(wchar)* lpszDependencyExpression);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION = extern(Windows) uint function(_HRESOURCE* hResource, const(wchar)* lpszDependencyExpression, uint* lpcchDependencyExpression);
alias PCLUSAPI_ADD_RESOURCE_TO_CLUSTER_SHARED_VOLUMES = extern(Windows) uint function(_HRESOURCE* hResource);
alias PCLUSAPI_REMOVE_RESOURCE_FROM_CLUSTER_SHARED_VOLUMES = extern(Windows) uint function(_HRESOURCE* hResource);
alias PCLUSAPI_IS_FILE_ON_CLUSTER_SHARED_VOLUME = extern(Windows) uint function(const(wchar)* lpszPathName, int* pbFileIsOnSharedVolume);
alias PCLUSAPI_SHARED_VOLUME_SET_SNAPSHOT_STATE = extern(Windows) uint function(Guid guidSnapshotSet, const(wchar)* lpszVolumeName, CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);
alias PCLUSAPI_CAN_RESOURCE_BE_DEPENDENT = extern(Windows) BOOL function(_HRESOURCE* hResource, _HRESOURCE* hResourceDependent);
alias PCLUSAPI_CLUSTER_RESOURCE_CONTROL = extern(Windows) uint function(_HRESOURCE* hResource, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_GROUP_CONTROL = extern(Windows) uint function(_HGROUP* hGroup, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_CLUSTER_NODE_CONTROL = extern(Windows) uint function(_HNODE* hNode, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_NETWORK_NAME = extern(Windows) BOOL function(_HRESOURCE* hResource, const(wchar)* lpBuffer, uint* nSize);
enum CLUSTER_PROPERTY_TYPE
{
    CLUSPROP_TYPE_UNKNOWN = -1,
    CLUSPROP_TYPE_ENDMARK = 0,
    CLUSPROP_TYPE_LIST_VALUE = 1,
    CLUSPROP_TYPE_RESCLASS = 2,
    CLUSPROP_TYPE_RESERVED1 = 3,
    CLUSPROP_TYPE_NAME = 4,
    CLUSPROP_TYPE_SIGNATURE = 5,
    CLUSPROP_TYPE_SCSI_ADDRESS = 6,
    CLUSPROP_TYPE_DISK_NUMBER = 7,
    CLUSPROP_TYPE_PARTITION_INFO = 8,
    CLUSPROP_TYPE_FTSET_INFO = 9,
    CLUSPROP_TYPE_DISK_SERIALNUMBER = 10,
    CLUSPROP_TYPE_DISK_GUID = 11,
    CLUSPROP_TYPE_DISK_SIZE = 12,
    CLUSPROP_TYPE_PARTITION_INFO_EX = 13,
    CLUSPROP_TYPE_PARTITION_INFO_EX2 = 14,
    CLUSPROP_TYPE_STORAGE_DEVICE_ID_DESCRIPTOR = 15,
    CLUSPROP_TYPE_USER = 32768,
}

enum CLUSTER_PROPERTY_FORMAT
{
    CLUSPROP_FORMAT_UNKNOWN = 0,
    CLUSPROP_FORMAT_BINARY = 1,
    CLUSPROP_FORMAT_DWORD = 2,
    CLUSPROP_FORMAT_SZ = 3,
    CLUSPROP_FORMAT_EXPAND_SZ = 4,
    CLUSPROP_FORMAT_MULTI_SZ = 5,
    CLUSPROP_FORMAT_ULARGE_INTEGER = 6,
    CLUSPROP_FORMAT_LONG = 7,
    CLUSPROP_FORMAT_EXPANDED_SZ = 8,
    CLUSPROP_FORMAT_SECURITY_DESCRIPTOR = 9,
    CLUSPROP_FORMAT_LARGE_INTEGER = 10,
    CLUSPROP_FORMAT_WORD = 11,
    CLUSPROP_FORMAT_FILETIME = 12,
    CLUSPROP_FORMAT_VALUE_LIST = 13,
    CLUSPROP_FORMAT_PROPERTY_LIST = 14,
    CLUSPROP_FORMAT_USER = 32768,
}

enum CLUSTER_PROPERTY_SYNTAX
{
    CLUSPROP_SYNTAX_ENDMARK = 0,
    CLUSPROP_SYNTAX_NAME = 262147,
    CLUSPROP_SYNTAX_RESCLASS = 131074,
    CLUSPROP_SYNTAX_LIST_VALUE_SZ = 65539,
    CLUSPROP_SYNTAX_LIST_VALUE_EXPAND_SZ = 65540,
    CLUSPROP_SYNTAX_LIST_VALUE_DWORD = 65538,
    CLUSPROP_SYNTAX_LIST_VALUE_BINARY = 65537,
    CLUSPROP_SYNTAX_LIST_VALUE_MULTI_SZ = 65541,
    CLUSPROP_SYNTAX_LIST_VALUE_LONG = 65543,
    CLUSPROP_SYNTAX_LIST_VALUE_EXPANDED_SZ = 65544,
    CLUSPROP_SYNTAX_LIST_VALUE_SECURITY_DESCRIPTOR = 65545,
    CLUSPROP_SYNTAX_LIST_VALUE_LARGE_INTEGER = 65546,
    CLUSPROP_SYNTAX_LIST_VALUE_ULARGE_INTEGER = 65542,
    CLUSPROP_SYNTAX_LIST_VALUE_WORD = 65547,
    CLUSPROP_SYNTAX_LIST_VALUE_PROPERTY_LIST = 65550,
    CLUSPROP_SYNTAX_LIST_VALUE_FILETIME = 65548,
    CLUSPROP_SYNTAX_DISK_SIGNATURE = 327682,
    CLUSPROP_SYNTAX_SCSI_ADDRESS = 393218,
    CLUSPROP_SYNTAX_DISK_NUMBER = 458754,
    CLUSPROP_SYNTAX_PARTITION_INFO = 524289,
    CLUSPROP_SYNTAX_FTSET_INFO = 589825,
    CLUSPROP_SYNTAX_DISK_SERIALNUMBER = 655363,
    CLUSPROP_SYNTAX_DISK_GUID = 720899,
    CLUSPROP_SYNTAX_DISK_SIZE = 786438,
    CLUSPROP_SYNTAX_PARTITION_INFO_EX = 851969,
    CLUSPROP_SYNTAX_PARTITION_INFO_EX2 = 917505,
    CLUSPROP_SYNTAX_STORAGE_DEVICE_ID_DESCRIPTOR = 983041,
}

struct GROUP_FAILURE_INFO
{
    uint dwFailoverAttemptsRemaining;
    uint dwFailoverPeriodRemaining;
}

struct GROUP_FAILURE_INFO_BUFFER
{
    uint dwVersion;
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

enum CLUSTER_CONTROL_OBJECT
{
    CLUS_OBJECT_INVALID = 0,
    CLUS_OBJECT_RESOURCE = 1,
    CLUS_OBJECT_RESOURCE_TYPE = 2,
    CLUS_OBJECT_GROUP = 3,
    CLUS_OBJECT_NODE = 4,
    CLUS_OBJECT_NETWORK = 5,
    CLUS_OBJECT_NETINTERFACE = 6,
    CLUS_OBJECT_CLUSTER = 7,
    CLUS_OBJECT_GROUPSET = 8,
    CLUS_OBJECT_AFFINITYRULE = 9,
    CLUS_OBJECT_USER = 128,
}

enum CLCTL_CODES
{
    CLCTL_UNKNOWN = 0,
    CLCTL_GET_CHARACTERISTICS = 5,
    CLCTL_GET_FLAGS = 9,
    CLCTL_GET_CLASS_INFO = 13,
    CLCTL_GET_REQUIRED_DEPENDENCIES = 17,
    CLCTL_GET_ARB_TIMEOUT = 21,
    CLCTL_GET_FAILURE_INFO = 25,
    CLCTL_GET_NAME = 41,
    CLCTL_GET_RESOURCE_TYPE = 45,
    CLCTL_GET_NODE = 49,
    CLCTL_GET_NETWORK = 53,
    CLCTL_GET_ID = 57,
    CLCTL_GET_FQDN = 61,
    CLCTL_GET_CLUSTER_SERVICE_ACCOUNT_NAME = 65,
    CLCTL_CHECK_VOTER_EVICT = 69,
    CLCTL_CHECK_VOTER_DOWN = 73,
    CLCTL_SHUTDOWN = 77,
    CLCTL_ENUM_COMMON_PROPERTIES = 81,
    CLCTL_GET_RO_COMMON_PROPERTIES = 85,
    CLCTL_GET_COMMON_PROPERTIES = 89,
    CLCTL_SET_COMMON_PROPERTIES = 4194398,
    CLCTL_VALIDATE_COMMON_PROPERTIES = 97,
    CLCTL_GET_COMMON_PROPERTY_FMTS = 101,
    CLCTL_GET_COMMON_RESOURCE_PROPERTY_FMTS = 105,
    CLCTL_ENUM_PRIVATE_PROPERTIES = 121,
    CLCTL_GET_RO_PRIVATE_PROPERTIES = 125,
    CLCTL_GET_PRIVATE_PROPERTIES = 129,
    CLCTL_SET_PRIVATE_PROPERTIES = 4194438,
    CLCTL_VALIDATE_PRIVATE_PROPERTIES = 137,
    CLCTL_GET_PRIVATE_PROPERTY_FMTS = 141,
    CLCTL_GET_PRIVATE_RESOURCE_PROPERTY_FMTS = 145,
    CLCTL_ADD_REGISTRY_CHECKPOINT = 4194466,
    CLCTL_DELETE_REGISTRY_CHECKPOINT = 4194470,
    CLCTL_GET_REGISTRY_CHECKPOINTS = 169,
    CLCTL_ADD_CRYPTO_CHECKPOINT = 4194478,
    CLCTL_DELETE_CRYPTO_CHECKPOINT = 4194482,
    CLCTL_GET_CRYPTO_CHECKPOINTS = 181,
    CLCTL_RESOURCE_UPGRADE_DLL = 4194490,
    CLCTL_ADD_REGISTRY_CHECKPOINT_64BIT = 4194494,
    CLCTL_ADD_REGISTRY_CHECKPOINT_32BIT = 4194498,
    CLCTL_GET_LOADBAL_PROCESS_LIST = 201,
    CLCTL_SET_ACCOUNT_ACCESS = 4194546,
    CLCTL_GET_NETWORK_NAME = 361,
    CLCTL_NETNAME_GET_VIRTUAL_SERVER_TOKEN = 365,
    CLCTL_NETNAME_REGISTER_DNS_RECORDS = 370,
    CLCTL_GET_DNS_NAME = 373,
    CLCTL_NETNAME_SET_PWD_INFO = 378,
    CLCTL_NETNAME_DELETE_CO = 382,
    CLCTL_NETNAME_VALIDATE_VCO = 385,
    CLCTL_NETNAME_RESET_VCO = 389,
    CLCTL_NETNAME_REPAIR_VCO = 397,
    CLCTL_STORAGE_GET_DISK_INFO = 401,
    CLCTL_STORAGE_GET_AVAILABLE_DISKS = 405,
    CLCTL_STORAGE_IS_PATH_VALID = 409,
    CLCTL_STORAGE_SYNC_CLUSDISK_DB = 4194718,
    CLCTL_STORAGE_GET_DISK_NUMBER_INFO = 417,
    CLCTL_QUERY_DELETE = 441,
    CLCTL_IPADDRESS_RENEW_LEASE = 4194750,
    CLCTL_IPADDRESS_RELEASE_LEASE = 4194754,
    CLCTL_QUERY_MAINTENANCE_MODE = 481,
    CLCTL_SET_MAINTENANCE_MODE = 4194790,
    CLCTL_STORAGE_SET_DRIVELETTER = 4194794,
    CLCTL_STORAGE_GET_DRIVELETTERS = 493,
    CLCTL_STORAGE_GET_DISK_INFO_EX = 497,
    CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX = 501,
    CLCTL_STORAGE_GET_DISK_INFO_EX2 = 505,
    CLCTL_STORAGE_GET_CLUSPORT_DISK_COUNT = 509,
    CLCTL_STORAGE_REMAP_DRIVELETTER = 513,
    CLCTL_STORAGE_GET_DISKID = 517,
    CLCTL_STORAGE_IS_CLUSTERABLE = 521,
    CLCTL_STORAGE_REMOVE_VM_OWNERSHIP = 4194830,
    CLCTL_STORAGE_GET_MOUNTPOINTS = 529,
    CLCTL_STORAGE_GET_DIRTY = 537,
    CLCTL_STORAGE_GET_SHARED_VOLUME_INFO = 549,
    CLCTL_STORAGE_IS_CSV_FILE = 553,
    CLCTL_STORAGE_GET_RESOURCEID = 557,
    CLCTL_VALIDATE_PATH = 561,
    CLCTL_VALIDATE_NETNAME = 565,
    CLCTL_VALIDATE_DIRECTORY = 569,
    CLCTL_BATCH_BLOCK_KEY = 574,
    CLCTL_BATCH_UNBLOCK_KEY = 577,
    CLCTL_FILESERVER_SHARE_ADD = 4194886,
    CLCTL_FILESERVER_SHARE_DEL = 4194890,
    CLCTL_FILESERVER_SHARE_MODIFY = 4194894,
    CLCTL_FILESERVER_SHARE_REPORT = 593,
    CLCTL_NETNAME_GET_OU_FOR_VCO = 4194926,
    CLCTL_ENABLE_SHARED_VOLUME_DIRECTIO = 4194954,
    CLCTL_DISABLE_SHARED_VOLUME_DIRECTIO = 4194958,
    CLCTL_GET_SHARED_VOLUME_ID = 657,
    CLCTL_SET_CSV_MAINTENANCE_MODE = 4194966,
    CLCTL_SET_SHARED_VOLUME_BACKUP_MODE = 4194970,
    CLCTL_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES = 669,
    CLCTL_STORAGE_GET_SHARED_VOLUME_STATES = 4194978,
    CLCTL_STORAGE_IS_SHARED_VOLUME = 677,
    CLCTL_GET_CLUSDB_TIMESTAMP = 681,
    CLCTL_RW_MODIFY_NOOP = 4194990,
    CLCTL_IS_QUORUM_BLOCKED = 689,
    CLCTL_POOL_GET_DRIVE_INFO = 693,
    CLCTL_GET_GUM_LOCK_OWNER = 697,
    CLCTL_GET_STUCK_NODES = 701,
    CLCTL_INJECT_GEM_FAULT = 705,
    CLCTL_INTRODUCE_GEM_REPAIR_DELAY = 709,
    CLCTL_SEND_DUMMY_GEM_MESSAGES = 713,
    CLCTL_BLOCK_GEM_SEND_RECV = 717,
    CLCTL_GET_GEMID_VECTOR = 721,
    CLCTL_ADD_CRYPTO_CHECKPOINT_EX = 4195030,
    CLCTL_GROUP_GET_LAST_MOVE_TIME = 729,
    CLCTL_SET_STORAGE_CONFIGURATION = 4195042,
    CLCTL_GET_STORAGE_CONFIGURATION = 741,
    CLCTL_GET_STORAGE_CONFIG_ATTRIBUTES = 745,
    CLCTL_REMOVE_NODE = 4195054,
    CLCTL_IS_FEATURE_INSTALLED = 753,
    CLCTL_IS_S2D_FEATURE_SUPPORTED = 757,
    CLCTL_STORAGE_GET_PHYSICAL_DISK_INFO = 761,
    CLCTL_STORAGE_GET_CLUSBFLT_PATHS = 765,
    CLCTL_STORAGE_GET_CLUSBFLT_PATHINFO = 769,
    CLCTL_CLEAR_NODE_CONNECTION_INFO = 4195078,
    CLCTL_SET_DNS_DOMAIN = 4195082,
    CTCTL_GET_ROUTESTATUS_BASIC = 781,
    CTCTL_GET_ROUTESTATUS_EXTENDED = 785,
    CTCTL_GET_FAULT_DOMAIN_STATE = 789,
    CLCTL_NETNAME_SET_PWD_INFOEX = 794,
    CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX2_INT = 8161,
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS = 8417,
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN = 4202726,
    CLCTL_RESOURCE_PREPARE_UPGRADE = 4202730,
    CLCTL_RESOURCE_UPGRADE_COMPLETED = 4202734,
    CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 8433,
    CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY = 4202742,
    CLCTL_REPLICATION_GET_LOG_INFO = 8517,
    CLCTL_REPLICATION_GET_ELIGIBLE_LOGDISKS = 8521,
    CLCTL_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS = 8525,
    CLCTL_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS = 8529,
    CLCTL_REPLICATION_GET_REPLICATED_DISKS = 8533,
    CLCTL_REPLICATION_GET_REPLICA_VOLUMES = 8537,
    CLCTL_REPLICATION_GET_LOG_VOLUME = 8541,
    CLCTL_REPLICATION_GET_RESOURCE_GROUP = 8545,
    CLCTL_REPLICATION_GET_REPLICATED_PARTITION_INFO = 8549,
    CLCTL_GET_STATE_CHANGE_TIME = 11613,
    CLCTL_SET_CLUSTER_S2D_ENABLED = 4205922,
    CLCTL_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES = 4205934,
    CLCTL_GROUPSET_GET_GROUPS = 11633,
    CLCTL_GROUPSET_GET_PROVIDER_GROUPS = 11637,
    CLCTL_GROUPSET_GET_PROVIDER_GROUPSETS = 11641,
    CLCTL_GROUP_GET_PROVIDER_GROUPS = 11645,
    CLCTL_GROUP_GET_PROVIDER_GROUPSETS = 11649,
    CLCTL_GROUP_SET_CCF_FROM_MASTER = 4205958,
    CLCTL_GET_INFRASTRUCTURE_SOFS_BUFFER = 11657,
    CLCTL_SET_INFRASTRUCTURE_SOFS_BUFFER = 4205966,
    CLCTL_NOTIFY_INFRASTRUCTURE_SOFS_CHANGED = 4205970,
    CLCTL_SCALEOUT_COMMAND = 4205974,
    CLCTL_SCALEOUT_CONTROL = 4205978,
    CLCTL_SCALEOUT_GET_CLUSTERS = 4205981,
    CLCTL_RELOAD_AUTOLOGGER_CONFIG = 11730,
    CLCTL_STORAGE_RENAME_SHARED_VOLUME = 11734,
    CLCTL_STORAGE_RENAME_SHARED_VOLUME_GUID = 11738,
    CLCTL_ENUM_AFFINITY_RULE_NAMES = 11741,
    CLCTL_DELETE = 5242886,
    CLCTL_INSTALL_NODE = 5242890,
    CLCTL_EVICT_NODE = 5242894,
    CLCTL_ADD_DEPENDENCY = 5242898,
    CLCTL_REMOVE_DEPENDENCY = 5242902,
    CLCTL_ADD_OWNER = 5242906,
    CLCTL_REMOVE_OWNER = 5242910,
    CLCTL_SET_NAME = 5242918,
    CLCTL_CLUSTER_NAME_CHANGED = 5242922,
    CLCTL_CLUSTER_VERSION_CHANGED = 5242926,
    CLCTL_FIXUP_ON_UPGRADE = 5242930,
    CLCTL_STARTING_PHASE1 = 5242934,
    CLCTL_STARTING_PHASE2 = 5242938,
    CLCTL_HOLD_IO = 5242942,
    CLCTL_RESUME_IO = 5242946,
    CLCTL_FORCE_QUORUM = 5242950,
    CLCTL_INITIALIZE = 5242954,
    CLCTL_STATE_CHANGE_REASON = 5242958,
    CLCTL_PROVIDER_STATE_CHANGE = 5242962,
    CLCTL_LEAVING_GROUP = 5242966,
    CLCTL_JOINING_GROUP = 5242970,
    CLCTL_FSWITNESS_GET_EPOCH_INFO = 1048669,
    CLCTL_FSWITNESS_SET_EPOCH_INFO = 5242978,
    CLCTL_FSWITNESS_RELEASE_LOCK = 5242982,
    CLCTL_NETNAME_CREDS_NOTIFYCAM = 5242986,
    CLCTL_NOTIFY_QUORUM_STATUS = 5243006,
    CLCTL_NOTIFY_MONITOR_SHUTTING_DOWN = 1048705,
    CLCTL_UNDELETE = 5243014,
    CLCTL_GET_OPERATION_CONTEXT = 1057001,
    CLCTL_NOTIFY_OWNER_CHANGE = 5251362,
    CLCTL_VALIDATE_CHANGE_GROUP = 1057061,
    CLCTL_CHECK_DRAIN_VETO = 1057069,
    CLCTL_NOTIFY_DRAIN_COMPLETE = 1057073,
}

enum CLUSCTL_RESOURCE_CODES
{
    CLUSCTL_RESOURCE_UNKNOWN = 16777216,
    CLUSCTL_RESOURCE_GET_CHARACTERISTICS = 16777221,
    CLUSCTL_RESOURCE_GET_FLAGS = 16777225,
    CLUSCTL_RESOURCE_GET_CLASS_INFO = 16777229,
    CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES = 16777233,
    CLUSCTL_RESOURCE_GET_NAME = 16777257,
    CLUSCTL_RESOURCE_GET_ID = 16777273,
    CLUSCTL_RESOURCE_GET_RESOURCE_TYPE = 16777261,
    CLUSCTL_RESOURCE_ENUM_COMMON_PROPERTIES = 16777297,
    CLUSCTL_RESOURCE_GET_RO_COMMON_PROPERTIES = 16777301,
    CLUSCTL_RESOURCE_GET_COMMON_PROPERTIES = 16777305,
    CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES = 20971614,
    CLUSCTL_RESOURCE_VALIDATE_COMMON_PROPERTIES = 16777313,
    CLUSCTL_RESOURCE_GET_COMMON_PROPERTY_FMTS = 16777317,
    CLUSCTL_RESOURCE_ENUM_PRIVATE_PROPERTIES = 16777337,
    CLUSCTL_RESOURCE_GET_RO_PRIVATE_PROPERTIES = 16777341,
    CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTIES = 16777345,
    CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES = 20971654,
    CLUSCTL_RESOURCE_VALIDATE_PRIVATE_PROPERTIES = 16777353,
    CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTY_FMTS = 16777357,
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT = 20971682,
    CLUSCTL_RESOURCE_DELETE_REGISTRY_CHECKPOINT = 20971686,
    CLUSCTL_RESOURCE_GET_REGISTRY_CHECKPOINTS = 16777385,
    CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT = 20971694,
    CLUSCTL_RESOURCE_DELETE_CRYPTO_CHECKPOINT = 20971698,
    CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT_EX = 20972246,
    CLUSCTL_RESOURCE_GET_CRYPTO_CHECKPOINTS = 16777397,
    CLUSCTL_RESOURCE_GET_LOADBAL_PROCESS_LIST = 16777417,
    CLUSCTL_RESOURCE_GET_NETWORK_NAME = 16777577,
    CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN = 16777581,
    CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFO = 16777594,
    CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFOEX = 16778010,
    CLUSCTL_RESOURCE_NETNAME_DELETE_CO = 16777598,
    CLUSCTL_RESOURCE_NETNAME_VALIDATE_VCO = 16777601,
    CLUSCTL_RESOURCE_NETNAME_RESET_VCO = 16777605,
    CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO = 16777613,
    CLUSCTL_RESOURCE_NETNAME_REGISTER_DNS_RECORDS = 16777586,
    CLUSCTL_RESOURCE_GET_DNS_NAME = 16777589,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO = 16777617,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_NUMBER_INFO = 16777633,
    CLUSCTL_RESOURCE_STORAGE_IS_PATH_VALID = 16777625,
    CLUSCTL_RESOURCE_QUERY_DELETE = 16777657,
    CLUSCTL_RESOURCE_UPGRADE_DLL = 20971706,
    CLUSCTL_RESOURCE_IPADDRESS_RENEW_LEASE = 20971966,
    CLUSCTL_RESOURCE_IPADDRESS_RELEASE_LEASE = 20971970,
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_64BIT = 20971710,
    CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_32BIT = 20971714,
    CLUSCTL_RESOURCE_QUERY_MAINTENANCE_MODE = 16777697,
    CLUSCTL_RESOURCE_SET_MAINTENANCE_MODE = 20972006,
    CLUSCTL_RESOURCE_STORAGE_SET_DRIVELETTER = 20972010,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX = 16777713,
    CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX2 = 16777721,
    CLUSCTL_RESOURCE_STORAGE_GET_MOUNTPOINTS = 16777745,
    CLUSCTL_RESOURCE_STORAGE_GET_DIRTY = 16777753,
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_INFO = 16777765,
    CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE = 20972182,
    CLUSCTL_RESOURCE_ENABLE_SHARED_VOLUME_DIRECTIO = 20972170,
    CLUSCTL_RESOURCE_DISABLE_SHARED_VOLUME_DIRECTIO = 20972174,
    CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE = 20972186,
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES = 16777885,
    CLUSCTL_RESOURCE_GET_FAILURE_INFO = 16777241,
    CLUSCTL_RESOURCE_STORAGE_GET_DISKID = 16777733,
    CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_STATES = 20972194,
    CLUSCTL_RESOURCE_STORAGE_IS_SHARED_VOLUME = 16777893,
    CLUSCTL_RESOURCE_IS_QUORUM_BLOCKED = 16777905,
    CLUSCTL_RESOURCE_POOL_GET_DRIVE_INFO = 16777909,
    CLUSCTL_RESOURCE_RLUA_GET_VIRTUAL_SERVER_TOKEN = 16777581,
    CLUSCTL_RESOURCE_RLUA_SET_PWD_INFO = 16777594,
    CLUSCTL_RESOURCE_RLUA_SET_PWD_INFOEX = 16778010,
    CLUSCTL_RESOURCE_DELETE = 22020102,
    CLUSCTL_RESOURCE_UNDELETE = 22020230,
    CLUSCTL_RESOURCE_INSTALL_NODE = 22020106,
    CLUSCTL_RESOURCE_EVICT_NODE = 22020110,
    CLUSCTL_RESOURCE_ADD_DEPENDENCY = 22020114,
    CLUSCTL_RESOURCE_REMOVE_DEPENDENCY = 22020118,
    CLUSCTL_RESOURCE_ADD_OWNER = 22020122,
    CLUSCTL_RESOURCE_REMOVE_OWNER = 22020126,
    CLUSCTL_RESOURCE_SET_NAME = 22020134,
    CLUSCTL_RESOURCE_CLUSTER_NAME_CHANGED = 22020138,
    CLUSCTL_RESOURCE_CLUSTER_VERSION_CHANGED = 22020142,
    CLUSCTL_RESOURCE_FORCE_QUORUM = 22020166,
    CLUSCTL_RESOURCE_INITIALIZE = 22020170,
    CLUSCTL_RESOURCE_STATE_CHANGE_REASON = 22020174,
    CLUSCTL_RESOURCE_PROVIDER_STATE_CHANGE = 22020178,
    CLUSCTL_RESOURCE_LEAVING_GROUP = 22020182,
    CLUSCTL_RESOURCE_JOINING_GROUP = 22020186,
    CLUSCTL_RESOURCE_FSWITNESS_GET_EPOCH_INFO = 17825885,
    CLUSCTL_RESOURCE_FSWITNESS_SET_EPOCH_INFO = 22020194,
    CLUSCTL_RESOURCE_FSWITNESS_RELEASE_LOCK = 22020198,
    CLUSCTL_RESOURCE_NETNAME_CREDS_NOTIFYCAM = 22020202,
    CLUSCTL_RESOURCE_GET_OPERATION_CONTEXT = 17834217,
    CLUSCTL_RESOURCE_RW_MODIFY_NOOP = 20972206,
    CLUSCTL_RESOURCE_NOTIFY_QUORUM_STATUS = 22020222,
    CLUSCTL_RESOURCE_NOTIFY_OWNER_CHANGE = 22028578,
    CLUSCTL_RESOURCE_VALIDATE_CHANGE_GROUP = 17834277,
    CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME = 16788950,
    CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME_GUID = 16788954,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN = 20979942,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY = 20979958,
    CLUSCTL_RESOURCE_PREPARE_UPGRADE = 20979946,
    CLUSCTL_RESOURCE_UPGRADE_COMPLETED = 20979950,
    CLUSCTL_RESOURCE_GET_STATE_CHANGE_TIME = 16788829,
    CLUSCTL_RESOURCE_GET_INFRASTRUCTURE_SOFS_BUFFER = 16788873,
    CLUSCTL_RESOURCE_SET_INFRASTRUCTURE_SOFS_BUFFER = 20983182,
    CLUSCTL_RESOURCE_SCALEOUT_COMMAND = 20983190,
    CLUSCTL_RESOURCE_SCALEOUT_CONTROL = 20983194,
    CLUSCTL_RESOURCE_SCALEOUT_GET_CLUSTERS = 20983197,
    CLUSCTL_RESOURCE_CHECK_DRAIN_VETO = 17834285,
    CLUSCTL_RESOURCE_NOTIFY_DRAIN_COMPLETE = 17834289,
}

enum CLUSCTL_RESOURCE_TYPE_CODES
{
    CLUSCTL_RESOURCE_TYPE_UNKNOWN = 33554432,
    CLUSCTL_RESOURCE_TYPE_GET_CHARACTERISTICS = 33554437,
    CLUSCTL_RESOURCE_TYPE_GET_FLAGS = 33554441,
    CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO = 33554445,
    CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES = 33554449,
    CLUSCTL_RESOURCE_TYPE_GET_ARB_TIMEOUT = 33554453,
    CLUSCTL_RESOURCE_TYPE_ENUM_COMMON_PROPERTIES = 33554513,
    CLUSCTL_RESOURCE_TYPE_GET_RO_COMMON_PROPERTIES = 33554517,
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTIES = 33554521,
    CLUSCTL_RESOURCE_TYPE_VALIDATE_COMMON_PROPERTIES = 33554529,
    CLUSCTL_RESOURCE_TYPE_SET_COMMON_PROPERTIES = 37748830,
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTY_FMTS = 33554533,
    CLUSCTL_RESOURCE_TYPE_GET_COMMON_RESOURCE_PROPERTY_FMTS = 33554537,
    CLUSCTL_RESOURCE_TYPE_ENUM_PRIVATE_PROPERTIES = 33554553,
    CLUSCTL_RESOURCE_TYPE_GET_RO_PRIVATE_PROPERTIES = 33554557,
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTIES = 33554561,
    CLUSCTL_RESOURCE_TYPE_SET_PRIVATE_PROPERTIES = 37748870,
    CLUSCTL_RESOURCE_TYPE_VALIDATE_PRIVATE_PROPERTIES = 33554569,
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTY_FMTS = 33554573,
    CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_RESOURCE_PROPERTY_FMTS = 33554577,
    CLUSCTL_RESOURCE_TYPE_GET_REGISTRY_CHECKPOINTS = 33554601,
    CLUSCTL_RESOURCE_TYPE_GET_CRYPTO_CHECKPOINTS = 33554613,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS = 33554837,
    CLUSCTL_RESOURCE_TYPE_STORAGE_SYNC_CLUSDISK_DB = 37749150,
    CLUSCTL_RESOURCE_TYPE_NETNAME_VALIDATE_NETNAME = 33554997,
    CLUSCTL_RESOURCE_TYPE_NETNAME_GET_OU_FOR_VCO = 37749358,
    CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_PATH = 33554993,
    CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_DIRECTORY = 33555001,
    CLUSCTL_RESOURCE_TYPE_GEN_SCRIPT_VALIDATE_PATH = 33554993,
    CLUSCTL_RESOURCE_TYPE_QUERY_DELETE = 33554873,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DRIVELETTERS = 33554925,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX = 33554933,
    CLUSCTL_RESOURCE_TYPE_STORAGE_REMAP_DRIVELETTER = 33554945,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DISKID = 33554949,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_RESOURCEID = 33554989,
    CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CLUSTERABLE = 33554953,
    CLUSCTL_RESOURCE_TYPE_STORAGE_REMOVE_VM_OWNERSHIP = 37749262,
    CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CSV_FILE = 16777769,
    CLUSCTL_RESOURCE_TYPE_WITNESS_VALIDATE_PATH = 33554993,
    CLUSCTL_RESOURCE_TYPE_INSTALL_NODE = 38797322,
    CLUSCTL_RESOURCE_TYPE_EVICT_NODE = 38797326,
    CLUSCTL_RESOURCE_TYPE_CLUSTER_VERSION_CHANGED = 38797358,
    CLUSCTL_RESOURCE_TYPE_FIXUP_ON_UPGRADE = 38797362,
    CLUSCTL_RESOURCE_TYPE_STARTING_PHASE1 = 38797366,
    CLUSCTL_RESOURCE_TYPE_STARTING_PHASE2 = 38797370,
    CLUSCTL_RESOURCE_TYPE_HOLD_IO = 38797374,
    CLUSCTL_RESOURCE_TYPE_RESUME_IO = 38797378,
    CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INT = 33562593,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_LOGDISKS = 33562953,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS = 33562957,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS = 33562961,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_DISKS = 33562965,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICA_VOLUMES = 33562969,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_VOLUME = 33562973,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_RESOURCE_GROUP = 33562977,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_PARTITION_INFO = 33562981,
    CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_INFO = 33562949,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS = 33562849,
    CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY = 33562865,
    CLUSCTL_RESOURCE_TYPE_PREPARE_UPGRADE = 37757162,
    CLUSCTL_RESOURCE_TYPE_UPGRADE_COMPLETED = 37757166,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_MONITOR_SHUTTING_DOWN = 34603137,
    CLUSCTL_RESOURCE_TYPE_CHECK_DRAIN_VETO = 34611501,
    CLUSCTL_RESOURCE_TYPE_NOTIFY_DRAIN_COMPLETE = 34611505,
}

enum CLUSCTL_GROUP_CODES
{
    CLUSCTL_GROUP_UNKNOWN = 50331648,
    CLUSCTL_GROUP_GET_CHARACTERISTICS = 50331653,
    CLUSCTL_GROUP_GET_FLAGS = 50331657,
    CLUSCTL_GROUP_GET_NAME = 50331689,
    CLUSCTL_GROUP_GET_ID = 50331705,
    CLUSCTL_GROUP_ENUM_COMMON_PROPERTIES = 50331729,
    CLUSCTL_GROUP_GET_RO_COMMON_PROPERTIES = 50331733,
    CLUSCTL_GROUP_GET_COMMON_PROPERTIES = 50331737,
    CLUSCTL_GROUP_SET_COMMON_PROPERTIES = 54526046,
    CLUSCTL_GROUP_VALIDATE_COMMON_PROPERTIES = 50331745,
    CLUSCTL_GROUP_ENUM_PRIVATE_PROPERTIES = 50331769,
    CLUSCTL_GROUP_GET_RO_PRIVATE_PROPERTIES = 50331773,
    CLUSCTL_GROUP_GET_PRIVATE_PROPERTIES = 50331777,
    CLUSCTL_GROUP_SET_PRIVATE_PROPERTIES = 54526086,
    CLUSCTL_GROUP_VALIDATE_PRIVATE_PROPERTIES = 50331785,
    CLUSCTL_GROUP_QUERY_DELETE = 50332089,
    CLUSCTL_GROUP_GET_COMMON_PROPERTY_FMTS = 50331749,
    CLUSCTL_GROUP_GET_PRIVATE_PROPERTY_FMTS = 50331789,
    CLUSCTL_GROUP_GET_FAILURE_INFO = 50331673,
    CLUSCTL_GROUP_GET_LAST_MOVE_TIME = 50332377,
    CLUSCTL_GROUP_SET_CCF_FROM_MASTER = 54537606,
}

enum CLUSCTL_NODE_CODES
{
    CLUSCTL_NODE_UNKNOWN = 67108864,
    CLUSCTL_NODE_GET_CHARACTERISTICS = 67108869,
    CLUSCTL_NODE_GET_FLAGS = 67108873,
    CLUSCTL_NODE_GET_NAME = 67108905,
    CLUSCTL_NODE_GET_ID = 67108921,
    CLUSCTL_NODE_ENUM_COMMON_PROPERTIES = 67108945,
    CLUSCTL_NODE_GET_RO_COMMON_PROPERTIES = 67108949,
    CLUSCTL_NODE_GET_COMMON_PROPERTIES = 67108953,
    CLUSCTL_NODE_SET_COMMON_PROPERTIES = 71303262,
    CLUSCTL_NODE_VALIDATE_COMMON_PROPERTIES = 67108961,
    CLUSCTL_NODE_ENUM_PRIVATE_PROPERTIES = 67108985,
    CLUSCTL_NODE_GET_RO_PRIVATE_PROPERTIES = 67108989,
    CLUSCTL_NODE_GET_PRIVATE_PROPERTIES = 67108993,
    CLUSCTL_NODE_SET_PRIVATE_PROPERTIES = 71303302,
    CLUSCTL_NODE_VALIDATE_PRIVATE_PROPERTIES = 67109001,
    CLUSCTL_NODE_GET_COMMON_PROPERTY_FMTS = 67108965,
    CLUSCTL_NODE_GET_PRIVATE_PROPERTY_FMTS = 67109005,
    CLUSCTL_NODE_GET_CLUSTER_SERVICE_ACCOUNT_NAME = 67108929,
    CLUSCTL_NODE_GET_STUCK_NODES = 67109565,
    CLUSCTL_NODE_INJECT_GEM_FAULT = 67109569,
    CLUSCTL_NODE_INTRODUCE_GEM_REPAIR_DELAY = 67109573,
    CLUSCTL_NODE_SEND_DUMMY_GEM_MESSAGES = 67109577,
    CLUSCTL_NODE_BLOCK_GEM_SEND_RECV = 67109581,
    CLUSCTL_NODE_GET_GEMID_VECTOR = 67109585,
}

enum CLUSCTL_NETWORK_CODES
{
    CLUSCTL_NETWORK_UNKNOWN = 83886080,
    CLUSCTL_NETWORK_GET_CHARACTERISTICS = 83886085,
    CLUSCTL_NETWORK_GET_FLAGS = 83886089,
    CLUSCTL_NETWORK_GET_NAME = 83886121,
    CLUSCTL_NETWORK_GET_ID = 83886137,
    CLUSCTL_NETWORK_ENUM_COMMON_PROPERTIES = 83886161,
    CLUSCTL_NETWORK_GET_RO_COMMON_PROPERTIES = 83886165,
    CLUSCTL_NETWORK_GET_COMMON_PROPERTIES = 83886169,
    CLUSCTL_NETWORK_SET_COMMON_PROPERTIES = 88080478,
    CLUSCTL_NETWORK_VALIDATE_COMMON_PROPERTIES = 83886177,
    CLUSCTL_NETWORK_ENUM_PRIVATE_PROPERTIES = 83886201,
    CLUSCTL_NETWORK_GET_RO_PRIVATE_PROPERTIES = 83886205,
    CLUSCTL_NETWORK_GET_PRIVATE_PROPERTIES = 83886209,
    CLUSCTL_NETWORK_SET_PRIVATE_PROPERTIES = 88080518,
    CLUSCTL_NETWORK_VALIDATE_PRIVATE_PROPERTIES = 83886217,
    CLUSCTL_NETWORK_GET_COMMON_PROPERTY_FMTS = 83886181,
    CLUSCTL_NETWORK_GET_PRIVATE_PROPERTY_FMTS = 83886221,
}

enum CLUSCTL_NETINTERFACE_CODES
{
    CLUSCTL_NETINTERFACE_UNKNOWN = 100663296,
    CLUSCTL_NETINTERFACE_GET_CHARACTERISTICS = 100663301,
    CLUSCTL_NETINTERFACE_GET_FLAGS = 100663305,
    CLUSCTL_NETINTERFACE_GET_NAME = 100663337,
    CLUSCTL_NETINTERFACE_GET_ID = 100663353,
    CLUSCTL_NETINTERFACE_GET_NODE = 100663345,
    CLUSCTL_NETINTERFACE_GET_NETWORK = 100663349,
    CLUSCTL_NETINTERFACE_ENUM_COMMON_PROPERTIES = 100663377,
    CLUSCTL_NETINTERFACE_GET_RO_COMMON_PROPERTIES = 100663381,
    CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTIES = 100663385,
    CLUSCTL_NETINTERFACE_SET_COMMON_PROPERTIES = 104857694,
    CLUSCTL_NETINTERFACE_VALIDATE_COMMON_PROPERTIES = 100663393,
    CLUSCTL_NETINTERFACE_ENUM_PRIVATE_PROPERTIES = 100663417,
    CLUSCTL_NETINTERFACE_GET_RO_PRIVATE_PROPERTIES = 100663421,
    CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTIES = 100663425,
    CLUSCTL_NETINTERFACE_SET_PRIVATE_PROPERTIES = 104857734,
    CLUSCTL_NETINTERFACE_VALIDATE_PRIVATE_PROPERTIES = 100663433,
    CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTY_FMTS = 100663397,
    CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTY_FMTS = 100663437,
}

enum CLUSCTL_CLUSTER_CODES
{
    CLUSCTL_CLUSTER_UNKNOWN = 117440512,
    CLUSCTL_CLUSTER_GET_FQDN = 117440573,
    CLUSCTL_CLUSTER_SET_STORAGE_CONFIGURATION = 121635554,
    CLUSCTL_CLUSTER_GET_STORAGE_CONFIGURATION = 117441253,
    CLUSCTL_CLUSTER_GET_STORAGE_CONFIG_ATTRIBUTES = 117441257,
    CLUSCTL_CLUSTER_ENUM_COMMON_PROPERTIES = 117440593,
    CLUSCTL_CLUSTER_GET_RO_COMMON_PROPERTIES = 117440597,
    CLUSCTL_CLUSTER_GET_COMMON_PROPERTIES = 117440601,
    CLUSCTL_CLUSTER_SET_COMMON_PROPERTIES = 121634910,
    CLUSCTL_CLUSTER_VALIDATE_COMMON_PROPERTIES = 117440609,
    CLUSCTL_CLUSTER_ENUM_PRIVATE_PROPERTIES = 117440633,
    CLUSCTL_CLUSTER_GET_RO_PRIVATE_PROPERTIES = 117440637,
    CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTIES = 117440641,
    CLUSCTL_CLUSTER_SET_PRIVATE_PROPERTIES = 121634950,
    CLUSCTL_CLUSTER_VALIDATE_PRIVATE_PROPERTIES = 117440649,
    CLUSCTL_CLUSTER_GET_COMMON_PROPERTY_FMTS = 117440613,
    CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTY_FMTS = 117440653,
    CLUSCTL_CLUSTER_CHECK_VOTER_EVICT = 117440581,
    CLUSCTL_CLUSTER_CHECK_VOTER_DOWN = 117440585,
    CLUSCTL_CLUSTER_SHUTDOWN = 117440589,
    CLUSCTL_CLUSTER_BATCH_BLOCK_KEY = 117441086,
    CLUSCTL_CLUSTER_BATCH_UNBLOCK_KEY = 117441089,
    CLUSCTL_CLUSTER_GET_SHARED_VOLUME_ID = 117441169,
    CLUSCTL_CLUSTER_GET_CLUSDB_TIMESTAMP = 117441193,
    CLUSCTL_CLUSTER_GET_GUM_LOCK_OWNER = 117441209,
    CLUSCTL_CLUSTER_REMOVE_NODE = 121635566,
    CLUSCTL_CLUSTER_SET_ACCOUNT_ACCESS = 121635058,
    CLUSCTL_CLUSTER_CLEAR_NODE_CONNECTION_INFO = 121635590,
    CLUSCTL_CLUSTER_SET_DNS_DOMAIN = 121635594,
    CLUSCTL_CLUSTER_SET_CLUSTER_S2D_ENABLED = 121646434,
    CLUSCTL_CLUSTER_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES = 121646446,
    CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME = 117452246,
    CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME_GUID = 117452250,
    CLUSCTL_CLUSTER_RELOAD_AUTOLOGGER_CONFIG = 117452242,
    CLUSCTL_CLUSTER_ENUM_AFFINITY_RULE_NAMES = 117452253,
}

enum CLUSCTL_GROUPSET_CODES
{
    CLUSCTL_GROUPSET_GET_COMMON_PROPERTIES = 134217817,
    CLUSCTL_GROUPSET_GET_RO_COMMON_PROPERTIES = 134217813,
    CLUSCTL_GROUPSET_SET_COMMON_PROPERTIES = 138412126,
    CLUSCTL_GROUPSET_GET_GROUPS = 134229361,
    CLUSCTL_GROUPSET_GET_PROVIDER_GROUPS = 134229365,
    CLUSCTL_GROUPSET_GET_PROVIDER_GROUPSETS = 134229369,
    CLUSCTL_GROUP_GET_PROVIDER_GROUPS = 134229373,
    CLUSCTL_GROUP_GET_PROVIDER_GROUPSETS = 134229377,
    CLUSCTL_GROUPSET_GET_ID = 134217785,
}

enum CLUSCTL_AFFINITYRULE_CODES
{
    CLUSCTL_AFFINITYRULE_GET_COMMON_PROPERTIES = 150995033,
    CLUSCTL_AFFINITYRULE_GET_RO_COMMON_PROPERTIES = 150995029,
    CLUSCTL_AFFINITYRULE_SET_COMMON_PROPERTIES = 155189342,
    CLUSCTL_AFFINITYRULE_GET_ID = 150995001,
    CLUSCTL_AFFINITYRULE_GET_GROUPNAMES = 151006577,
}

enum CLUSTER_RESOURCE_CLASS
{
    CLUS_RESCLASS_UNKNOWN = 0,
    CLUS_RESCLASS_STORAGE = 1,
    CLUS_RESCLASS_NETWORK = 2,
    CLUS_RESCLASS_USER = 32768,
}

enum CLUS_RESSUBCLASS
{
    CLUS_RESSUBCLASS_SHARED = -2147483648,
}

enum CLUS_RESSUBCLASS_STORAGE
{
    CLUS_RESSUBCLASS_STORAGE_SHARED_BUS = -2147483648,
    CLUS_RESSUBCLASS_STORAGE_DISK = 1073741824,
    CLUS_RESSUBCLASS_STORAGE_REPLICATION = 268435456,
}

enum CLUS_RESSUBCLASS_NETWORK
{
    CLUS_RESSUBCLASS_NETWORK_INTERNET_PROTOCOL = -2147483648,
}

enum CLUS_CHARACTERISTICS
{
    CLUS_CHAR_UNKNOWN = 0,
    CLUS_CHAR_QUORUM = 1,
    CLUS_CHAR_DELETE_REQUIRES_ALL_NODES = 2,
    CLUS_CHAR_LOCAL_QUORUM = 4,
    CLUS_CHAR_LOCAL_QUORUM_DEBUG = 8,
    CLUS_CHAR_REQUIRES_STATE_CHANGE_REASON = 16,
    CLUS_CHAR_BROADCAST_DELETE = 32,
    CLUS_CHAR_SINGLE_CLUSTER_INSTANCE = 64,
    CLUS_CHAR_SINGLE_GROUP_INSTANCE = 128,
    CLUS_CHAR_COEXIST_IN_SHARED_VOLUME_GROUP = 256,
    CLUS_CHAR_PLACEMENT_DATA = 512,
    CLUS_CHAR_MONITOR_DETACH = 1024,
    CLUS_CHAR_MONITOR_REATTACH = 2048,
    CLUS_CHAR_OPERATION_CONTEXT = 4096,
    CLUS_CHAR_CLONES = 8192,
    CLUS_CHAR_NOT_PREEMPTABLE = 16384,
    CLUS_CHAR_NOTIFY_NEW_OWNER = 32768,
    CLUS_CHAR_SUPPORTS_UNMONITORED_STATE = 65536,
    CLUS_CHAR_INFRASTRUCTURE = 131072,
    CLUS_CHAR_VETO_DRAIN = 262144,
}

enum CLUS_FLAGS
{
    CLUS_FLAG_CORE = 1,
}

struct CLUSPROP_SYNTAX
{
    uint dw;
    _Anonymous_e__Struct Anonymous;
}

struct CLUSPROP_VALUE
{
    CLUSPROP_SYNTAX Syntax;
    uint cbLength;
}

struct CLUSPROP_BINARY
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5092_C41;
    ubyte rgb;
}

struct CLUSPROP_WORD
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5102_C39;
    ushort w;
}

struct CLUSPROP_DWORD
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5112_C40;
    uint dw;
}

struct CLUSPROP_LONG
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5122_C39;
    int l;
}

struct CLUSPROP_SZ
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5132_C37;
    ushort sz;
}

struct CLUSPROP_ULARGE_INTEGER
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5149_C14;
    ULARGE_INTEGER li;
}

struct CLUSPROP_LARGE_INTEGER
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5162_C14;
    LARGE_INTEGER li;
}

struct CLUSPROP_SECURITY_DESCRIPTOR
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5174_C54;
    _Anonymous_e__Union Anonymous;
}

struct CLUSPROP_FILETIME
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5188_C14;
    FILETIME ft;
}

struct CLUS_RESOURCE_CLASS_INFO
{
    _Anonymous_e__Union Anonymous;
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

struct CLUSPROP_REQUIRED_DEPENDENCY
{
    CLUSPROP_VALUE Value;
    CLUSPROP_RESOURCE_CLASS ResClass;
    CLUSPROP_SZ ResTypeName;
}

enum CLUSPROP_PIFLAGS
{
    CLUSPROP_PIFLAG_STICKY = 1,
    CLUSPROP_PIFLAG_REMOVABLE = 2,
    CLUSPROP_PIFLAG_USABLE = 4,
    CLUSPROP_PIFLAG_DEFAULT_QUORUM = 8,
    CLUSPROP_PIFLAG_USABLE_FOR_CSV = 16,
    CLUSPROP_PIFLAG_ENCRYPTION_ENABLED = 32,
    CLUSPROP_PIFLAG_RAW = 64,
    CLUSPROP_PIFLAG_UNKNOWN = -2147483648,
}

struct CLUS_FORCE_QUORUM_INFO
{
    uint dwSize;
    uint dwNodeBitMask;
    uint dwMaxNumberofNodes;
    ushort multiszNodeList;
}

struct CLUS_PARTITION_INFO
{
    uint dwFlags;
    ushort szDeviceName;
    ushort szVolumeLabel;
    uint dwSerialNumber;
    uint rgdwMaximumComponentLength;
    uint dwFileSystemFlags;
    ushort szFileSystem;
}

struct CLUS_PARTITION_INFO_EX
{
    uint dwFlags;
    ushort szDeviceName;
    ushort szVolumeLabel;
    uint dwSerialNumber;
    uint rgdwMaximumComponentLength;
    uint dwFileSystemFlags;
    ushort szFileSystem;
    ULARGE_INTEGER TotalSizeInBytes;
    ULARGE_INTEGER FreeSizeInBytes;
    uint DeviceNumber;
    uint PartitionNumber;
    Guid VolumeGuid;
}

struct CLUS_PARTITION_INFO_EX2
{
    Guid GptPartitionId;
    ushort szPartitionName;
    uint EncryptionFlags;
}

enum CLUSTER_CSV_VOLUME_FAULT_STATE
{
    VolumeStateNoFaults = 0,
    VolumeStateNoDirectIO = 1,
    VolumeStateNoAccess = 2,
    VolumeStateInMaintenance = 4,
    VolumeStateDismounted = 8,
}

enum CLUSTER_SHARED_VOLUME_BACKUP_STATE
{
    VolumeBackupNone = 0,
    VolumeBackupInProgress = 1,
}

struct CLUS_CSV_VOLUME_INFO
{
    ULARGE_INTEGER VolumeOffset;
    uint PartitionNumber;
    CLUSTER_CSV_VOLUME_FAULT_STATE FaultState;
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    ushort szVolumeFriendlyName;
    ushort szVolumeName;
}

struct CLUS_CSV_VOLUME_NAME
{
    LARGE_INTEGER VolumeOffset;
    ushort szVolumeName;
    ushort szRootPath;
}

enum CLUSTER_SHARED_VOLUME_STATE
{
    SharedVolumeStateUnavailable = 0,
    SharedVolumeStatePaused = 1,
    SharedVolumeStateActive = 2,
    SharedVolumeStateActiveRedirected = 3,
    SharedVolumeStateActiveVolumeRedirected = 4,
}

struct CLUSTER_SHARED_VOLUME_STATE_INFO
{
    ushort szVolumeName;
    ushort szNodeName;
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
}

struct CLUSTER_SHARED_VOLUME_STATE_INFO_EX
{
    ushort szVolumeName;
    ushort szNodeName;
    CLUSTER_SHARED_VOLUME_STATE VolumeState;
    ushort szVolumeFriendlyName;
    ulong RedirectedIOReason;
    ulong VolumeRedirectedIOReason;
}

enum CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE
{
    ClusterSharedVolumeRenameInputTypeNone = 0,
    ClusterSharedVolumeRenameInputTypeVolumeOffset = 1,
    ClusterSharedVolumeRenameInputTypeVolumeId = 2,
    ClusterSharedVolumeRenameInputTypeVolumeName = 3,
    ClusterSharedVolumeRenameInputTypeVolumeGuid = 4,
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME
{
    CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE InputType;
    _Anonymous_e__Union Anonymous;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_NAME
{
    ushort NewVolumeName;
}

struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_GUID_NAME
{
    ushort NewVolumeName;
    ushort NewVolumeGuid;
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
    uint PartitionNumber;
    uint ChkdskState;
    uint FileIdCount;
    ulong FileIdList;
}

struct CLUS_DISK_NUMBER_INFO
{
    uint DiskNumber;
    uint BytesPerSector;
}

struct CLUS_SHARED_VOLUME_BACKUP_MODE
{
    CLUSTER_SHARED_VOLUME_BACKUP_STATE BackupState;
    uint DelayTimerInSecs;
    ushort VolumeName;
}

struct CLUSPROP_PARTITION_INFO
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5470_C14;
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
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5518_C14;
    CLUS_FTSET_INFO __AnonymousBase_clusapi_L5519_C14;
}

struct CLUS_SCSI_ADDRESS
{
    _Anonymous_e__Union Anonymous;
}

struct CLUSPROP_SCSI_ADDRESS
{
    CLUSPROP_VALUE __AnonymousBase_clusapi_L5546_C14;
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
    uint Flags;
    ushort Password;
    ushort CreatingDC;
    ushort ObjectGuid;
}

struct CLUS_NETNAME_PWD_INFOEX
{
    uint Flags;
    ushort Password;
    ushort CreatingDC;
    ushort ObjectGuid;
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
    uint NodeId;
    uint AddressSize;
    ubyte Address;
}

struct CLUS_NETNAME_IP_INFO_FOR_MULTICHANNEL
{
    ushort szName;
    uint NumEntries;
    CLUS_NETNAME_IP_INFO_ENTRY IpInfo;
}

struct CLUS_MAINTENANCE_MODE_INFO
{
    BOOL InMaintenance;
}

struct CLUS_CSV_MAINTENANCE_MODE_INFO
{
    BOOL InMaintenance;
    ushort VolumeName;
}

enum MAINTENANCE_MODE_TYPE_ENUM
{
    MaintenanceModeTypeDisableIsAliveCheck = 1,
    MaintenanceModeTypeOfflineResource = 2,
    MaintenanceModeTypeUnclusterResource = 3,
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
    BOOL InMaintenance;
    uint ExtraParameterSize;
    ubyte ExtraParameter;
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
    uint dwSize;
    CLUSTER_RESOURCE_STATE resourceState;
    ushort szProviderId;
}

struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_INPUT
{
    ushort FileServerName;
}

struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_OUTPUT
{
    ushort FileServerName;
}

struct CLUSPROP_LIST
{
    uint nPropertyCount;
    CLUSPROP_SZ PropertyName;
}

enum CLUSPROP_IPADDR_ENABLENETBIOS
{
    CLUSPROP_IPADDR_ENABLENETBIOS_DISABLED = 0,
    CLUSPROP_IPADDR_ENABLENETBIOS_ENABLED = 1,
    CLUSPROP_IPADDR_ENABLENETBIOS_TRACK_NIC = 2,
}

enum FILESHARE_CHANGE_ENUM
{
    FILESHARE_CHANGE_NONE = 0,
    FILESHARE_CHANGE_ADD = 1,
    FILESHARE_CHANGE_DEL = 2,
    FILESHARE_CHANGE_MODIFY = 3,
}

struct FILESHARE_CHANGE
{
    FILESHARE_CHANGE_ENUM Change;
    ushort ShareName;
}

struct FILESHARE_CHANGE_LIST
{
    uint NumEntries;
    FILESHARE_CHANGE ChangeEntry;
}

struct CLUSCTL_GROUP_GET_LAST_MOVE_TIME_OUTPUT
{
    ulong GetTickCount64;
    SYSTEMTIME GetSystemTime;
    uint NodeId;
}

struct CLUSPROP_BUFFER_HELPER
{
    ubyte* pb;
    ushort* pw;
    uint* pdw;
    int* pl;
    const(wchar)* psz;
    CLUSPROP_LIST* pList;
    CLUSPROP_SYNTAX* pSyntax;
    CLUSPROP_SZ* pName;
    CLUSPROP_VALUE* pValue;
    CLUSPROP_BINARY* pBinaryValue;
    CLUSPROP_WORD* pWordValue;
    CLUSPROP_DWORD* pDwordValue;
    CLUSPROP_LONG* pLongValue;
    CLUSPROP_ULARGE_INTEGER* pULargeIntegerValue;
    CLUSPROP_LARGE_INTEGER* pLargeIntegerValue;
    CLUSPROP_SZ* pStringValue;
    CLUSPROP_SZ* pMultiSzValue;
    CLUSPROP_SECURITY_DESCRIPTOR* pSecurityDescriptor;
    CLUSPROP_RESOURCE_CLASS* pResourceClassValue;
    CLUSPROP_RESOURCE_CLASS_INFO* pResourceClassInfoValue;
    CLUSPROP_DWORD* pDiskSignatureValue;
    CLUSPROP_SCSI_ADDRESS* pScsiAddressValue;
    CLUSPROP_DWORD* pDiskNumberValue;
    CLUSPROP_PARTITION_INFO* pPartitionInfoValue;
    CLUSPROP_REQUIRED_DEPENDENCY* pRequiredDependencyValue;
    CLUSPROP_PARTITION_INFO_EX* pPartitionInfoValueEx;
    CLUSPROP_PARTITION_INFO_EX2* pPartitionInfoValueEx2;
    CLUSPROP_FILETIME* pFileTimeValue;
}

enum CLUSTER_RESOURCE_ENUM
{
    CLUSTER_RESOURCE_ENUM_DEPENDS = 1,
    CLUSTER_RESOURCE_ENUM_PROVIDES = 2,
    CLUSTER_RESOURCE_ENUM_NODES = 4,
    CLUSTER_RESOURCE_ENUM_ALL = 7,
}

enum CLUSTER_RESOURCE_TYPE_ENUM
{
    CLUSTER_RESOURCE_TYPE_ENUM_NODES = 1,
    CLUSTER_RESOURCE_TYPE_ENUM_RESOURCES = 2,
    CLUSTER_RESOURCE_TYPE_ENUM_ALL = 3,
}

alias PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM = extern(Windows) _HRESENUM* function(_HRESOURCE* hResource, uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT = extern(Windows) uint function(_HRESENUM* hResEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_ENUM = extern(Windows) uint function(_HRESENUM* hResEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM = extern(Windows) uint function(_HRESENUM* hResEnum);
alias PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, const(wchar)* lpszDisplayName, const(wchar)* lpszResourceTypeDll, uint dwLooksAlivePollInterval, uint dwIsAlivePollInterval);
alias PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_OPEN_ENUM = extern(Windows) _HRESTYPEENUM* function(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, uint dwType);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_GET_ENUM_COUNT = extern(Windows) uint function(_HRESTYPEENUM* hResTypeEnum);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_ENUM = extern(Windows) uint function(_HRESTYPEENUM* hResTypeEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_RESOURCE_TYPE_CLOSE_ENUM = extern(Windows) uint function(_HRESTYPEENUM* hResTypeEnum);
enum CLUSTER_NETWORK_ENUM
{
    CLUSTER_NETWORK_ENUM_NETINTERFACES = 1,
    CLUSTER_NETWORK_ENUM_ALL = 1,
}

enum CLUSTER_NETWORK_STATE
{
    ClusterNetworkStateUnknown = -1,
    ClusterNetworkUnavailable = 0,
    ClusterNetworkDown = 1,
    ClusterNetworkPartitioned = 2,
    ClusterNetworkUp = 3,
}

enum CLUSTER_NETWORK_ROLE
{
    ClusterNetworkRoleNone = 0,
    ClusterNetworkRoleInternalUse = 1,
    ClusterNetworkRoleClientAccess = 2,
    ClusterNetworkRoleInternalAndClient = 3,
}

alias PCLUSAPI_OPEN_CLUSTER_NETWORK = extern(Windows) _HNETWORK* function(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName);
alias PCLUSAPI_OPEN_CLUSTER_NETWORK_EX = extern(Windows) _HNETWORK* function(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName, uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_CLOSE_CLUSTER_NETWORK = extern(Windows) BOOL function(_HNETWORK* hNetwork);
alias PCLUSAPI_GET_CLUSTER_FROM_NETWORK = extern(Windows) _HCLUSTER* function(_HNETWORK* hNetwork);
alias PCLUSAPI_CLUSTER_NETWORK_OPEN_ENUM = extern(Windows) _HNETWORKENUM* function(_HNETWORK* hNetwork, uint dwType);
alias PCLUSAPI_CLUSTER_NETWORK_GET_ENUM_COUNT = extern(Windows) uint function(_HNETWORKENUM* hNetworkEnum);
alias PCLUSAPI_CLUSTER_NETWORK_ENUM = extern(Windows) uint function(_HNETWORKENUM* hNetworkEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CLOSE_ENUM = extern(Windows) uint function(_HNETWORKENUM* hNetworkEnum);
alias PCLUSAPI_GET_CLUSTER_NETWORK_STATE = extern(Windows) CLUSTER_NETWORK_STATE function(_HNETWORK* hNetwork);
alias PCLUSAPI_SET_CLUSTER_NETWORK_NAME = extern(Windows) uint function(_HNETWORK* hNetwork, const(wchar)* lpszName);
alias PCLUSAPI_GET_CLUSTER_NETWORK_ID = extern(Windows) uint function(_HNETWORK* hNetwork, const(wchar)* lpszNetworkId, uint* lpcchName);
alias PCLUSAPI_CLUSTER_NETWORK_CONTROL = extern(Windows) uint function(_HNETWORK* hNetwork, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);
enum CLUSTER_NETINTERFACE_STATE
{
    ClusterNetInterfaceStateUnknown = -1,
    ClusterNetInterfaceUnavailable = 0,
    ClusterNetInterfaceFailed = 1,
    ClusterNetInterfaceUnreachable = 2,
    ClusterNetInterfaceUp = 3,
}

alias PCLUSAPI_OPEN_CLUSTER_NET_INTERFACE = extern(Windows) _HNETINTERFACE* function(_HCLUSTER* hCluster, const(wchar)* lpszInterfaceName);
alias PCLUSAPI_OPEN_CLUSTER_NETINTERFACE_EX = extern(Windows) _HNETINTERFACE* function(_HCLUSTER* hCluster, const(wchar)* lpszNetInterfaceName, uint dwDesiredAccess, uint* lpdwGrantedAccess);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, const(wchar)* lpszNetworkName, const(wchar)* lpszInterfaceName, uint* lpcchInterfaceName);
alias PCLUSAPI_CLOSE_CLUSTER_NET_INTERFACE = extern(Windows) BOOL function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_GET_CLUSTER_FROM_NET_INTERFACE = extern(Windows) _HCLUSTER* function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_STATE = extern(Windows) CLUSTER_NETINTERFACE_STATE function(_HNETINTERFACE* hNetInterface);
alias PCLUSAPI_CLUSTER_NET_INTERFACE_CONTROL = extern(Windows) uint function(_HNETINTERFACE* hNetInterface, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);
alias PCLUSAPI_GET_CLUSTER_KEY = extern(Windows) HKEY function(_HCLUSTER* hCluster, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_GROUP_KEY = extern(Windows) HKEY function(_HGROUP* hGroup, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_RESOURCE_KEY = extern(Windows) HKEY function(_HRESOURCE* hResource, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NODE_KEY = extern(Windows) HKEY function(_HNODE* hNode, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NETWORK_KEY = extern(Windows) HKEY function(_HNETWORK* hNetwork, uint samDesired);
alias PCLUSAPI_GET_CLUSTER_NET_INTERFACE_KEY = extern(Windows) HKEY function(_HNETINTERFACE* hNetInterface, uint samDesired);
alias PCLUSAPI_CLUSTER_REG_CREATE_KEY = extern(Windows) int function(HKEY hKey, const(wchar)* lpszSubKey, uint dwOptions, uint samDesired, SECURITY_ATTRIBUTES* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);
alias PCLUSAPI_CLUSTER_REG_OPEN_KEY = extern(Windows) int function(HKEY hKey, const(wchar)* lpszSubKey, uint samDesired, HKEY* phkResult);
alias PCLUSAPI_CLUSTER_REG_DELETE_KEY = extern(Windows) int function(HKEY hKey, const(wchar)* lpszSubKey);
alias PCLUSAPI_CLUSTER_REG_CLOSE_KEY = extern(Windows) int function(HKEY hKey);
alias PCLUSAPI_CLUSTER_REG_ENUM_KEY = extern(Windows) int function(HKEY hKey, uint dwIndex, const(wchar)* lpszName, uint* lpcchName, FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_SET_VALUE = extern(Windows) uint function(HKEY hKey, const(wchar)* lpszValueName, uint dwType, const(ubyte)* lpData, uint cbData);
alias PCLUSAPI_CLUSTER_REG_DELETE_VALUE = extern(Windows) uint function(HKEY hKey, const(wchar)* lpszValueName);
alias PCLUSAPI_CLUSTER_REG_QUERY_VALUE = extern(Windows) int function(HKEY hKey, const(wchar)* lpszValueName, uint* lpdwValueType, char* lpData, uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_ENUM_VALUE = extern(Windows) uint function(HKEY hKey, uint dwIndex, const(wchar)* lpszValueName, uint* lpcchValueName, uint* lpdwType, char* lpData, uint* lpcbData);
alias PCLUSAPI_CLUSTER_REG_QUERY_INFO_KEY = extern(Windows) int function(HKEY hKey, uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, uint* lpcValues, uint* lpcbMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);
alias PCLUSAPI_CLUSTER_REG_GET_KEY_SECURITY = extern(Windows) int function(HKEY hKey, uint RequestedInformation, char* pSecurityDescriptor, uint* lpcbSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SET_KEY_SECURITY = extern(Windows) int function(HKEY hKey, uint SecurityInformation, void* pSecurityDescriptor);
alias PCLUSAPI_CLUSTER_REG_SYNC_DATABASE = extern(Windows) int function(_HCLUSTER* hCluster, uint flags);
alias PCLUSAPI_CLUSTER_REG_CREATE_BATCH = extern(Windows) int function(HKEY hKey, _HREGBATCH** pHREGBATCH);
alias PCLUSTER_REG_BATCH_ADD_COMMAND = extern(Windows) int function(_HREGBATCH* hRegBatch, CLUSTER_REG_COMMAND dwCommand, const(wchar)* wzName, uint dwOptions, char* lpData, uint cbData);
alias PCLUSTER_REG_CLOSE_BATCH = extern(Windows) int function(_HREGBATCH* hRegBatch, BOOL bCommit, int* failedCommandNumber);
alias PCLUSTER_REG_BATCH_READ_COMMAND = extern(Windows) int function(_HREGBATCHNOTIFICATION* hBatchNotification, CLUSTER_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_BATCH_CLOSE_NOTIFICATION = extern(Windows) int function(_HREGBATCHNOTIFICATION* hBatchNotification);
alias PCLUSTER_REG_CREATE_BATCH_NOTIFY_PORT = extern(Windows) int function(HKEY hKey, _HREGBATCHPORT** phBatchNotifyPort);
alias PCLUSTER_REG_CLOSE_BATCH_NOTIFY_PORT = extern(Windows) int function(_HREGBATCHPORT* hBatchNotifyPort);
alias PCLUSTER_REG_GET_BATCH_NOTIFICATION = extern(Windows) int function(_HREGBATCHPORT* hBatchNotify, _HREGBATCHNOTIFICATION** phBatchNotification);
alias PCLUSTER_REG_CREATE_READ_BATCH = extern(Windows) int function(HKEY hKey, _HREGREADBATCH** phRegReadBatch);
alias PCLUSTER_REG_READ_BATCH_ADD_COMMAND = extern(Windows) int function(_HREGREADBATCH* hRegReadBatch, const(wchar)* wzSubkeyName, const(wchar)* wzValueName);
alias PCLUSTER_REG_CLOSE_READ_BATCH = extern(Windows) int function(_HREGREADBATCH* hRegReadBatch, _HREGREADBATCHREPLY** phRegReadBatchReply);
alias PCLUSTER_REG_CLOSE_READ_BATCH_EX = extern(Windows) int function(_HREGREADBATCH* hRegReadBatch, uint flags, _HREGREADBATCHREPLY** phRegReadBatchReply);
alias PCLUSTER_REG_READ_BATCH_REPLY_NEXT_COMMAND = extern(Windows) int function(_HREGREADBATCHREPLY* hRegReadBatchReply, CLUSTER_READ_BATCH_COMMAND* pBatchCommand);
alias PCLUSTER_REG_CLOSE_READ_BATCH_REPLY = extern(Windows) int function(_HREGREADBATCHREPLY* hRegReadBatchReply);
alias PCLUSTER_SET_ACCOUNT_ACCESS = extern(Windows) uint function(_HCLUSTER* hCluster, const(wchar)* szAccountSID, uint dwAccess, uint dwControlType);
enum CLUSTER_SETUP_PHASE
{
    ClusterSetupPhaseInitialize = 1,
    ClusterSetupPhaseValidateNodeState = 100,
    ClusterSetupPhaseValidateNetft = 102,
    ClusterSetupPhaseValidateClusDisk = 103,
    ClusterSetupPhaseConfigureClusSvc = 104,
    ClusterSetupPhaseStartingClusSvc = 105,
    ClusterSetupPhaseQueryClusterNameAccount = 106,
    ClusterSetupPhaseValidateClusterNameAccount = 107,
    ClusterSetupPhaseCreateClusterAccount = 108,
    ClusterSetupPhaseConfigureClusterAccount = 109,
    ClusterSetupPhaseFormingCluster = 200,
    ClusterSetupPhaseAddClusterProperties = 201,
    ClusterSetupPhaseCreateResourceTypes = 202,
    ClusterSetupPhaseCreateGroups = 203,
    ClusterSetupPhaseCreateIPAddressResources = 204,
    ClusterSetupPhaseCreateNetworkName = 205,
    ClusterSetupPhaseClusterGroupOnline = 206,
    ClusterSetupPhaseGettingCurrentMembership = 300,
    ClusterSetupPhaseAddNodeToCluster = 301,
    ClusterSetupPhaseNodeUp = 302,
    ClusterSetupPhaseMoveGroup = 400,
    ClusterSetupPhaseDeleteGroup = 401,
    ClusterSetupPhaseCleanupCOs = 402,
    ClusterSetupPhaseOfflineGroup = 403,
    ClusterSetupPhaseEvictNode = 404,
    ClusterSetupPhaseCleanupNode = 405,
    ClusterSetupPhaseCoreGroupCleanup = 406,
    ClusterSetupPhaseFailureCleanup = 999,
}

enum CLUSTER_SETUP_PHASE_TYPE
{
    ClusterSetupPhaseStart = 1,
    ClusterSetupPhaseContinue = 2,
    ClusterSetupPhaseEnd = 3,
    ClusterSetupPhaseReport = 4,
}

enum CLUSTER_SETUP_PHASE_SEVERITY
{
    ClusterSetupPhaseInformational = 1,
    ClusterSetupPhaseWarning = 2,
    ClusterSetupPhaseFatal = 3,
}

alias PCLUSTER_SETUP_PROGRESS_CALLBACK = extern(Windows) BOOL function(void* pvCallbackArg, CLUSTER_SETUP_PHASE eSetupPhase, CLUSTER_SETUP_PHASE_TYPE ePhaseType, CLUSTER_SETUP_PHASE_SEVERITY ePhaseSeverity, uint dwPercentComplete, const(wchar)* lpszObjectName, uint dwStatus);
alias PCLUSAPI_CREATE_CLUSTER = extern(Windows) _HCLUSTER* function(CREATE_CLUSTER_CONFIG* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_CNOLESS = extern(Windows) _HCLUSTER* function(CREATE_CLUSTER_CONFIG* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);
alias PCLUSAPI_CREATE_CLUSTER_NAME_ACCOUNT = extern(Windows) uint function(_HCLUSTER* hCluster, CREATE_CLUSTER_NAME_ACCOUNT* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);
alias PCLUSAPI_REMOVE_CLUSTER_NAME_ACCOUNT = extern(Windows) uint function(_HCLUSTER* hCluster);
alias PCLUSAPI_ADD_CLUSTER_NODE = extern(Windows) _HNODE* function(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);
alias PCLUSAPI_DESTROY_CLUSTER = extern(Windows) uint function(_HCLUSTER* hCluster, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, BOOL fdeleteVirtualComputerObjects);
enum PLACEMENT_OPTIONS
{
    PLACEMENT_OPTIONS_MIN_VALUE = 0,
    PLACEMENT_OPTIONS_DEFAULT_PLACEMENT_OPTIONS = 0,
    PLACEMENT_OPTIONS_DISABLE_CSV_VM_DEPENDENCY = 1,
    PLACEMENT_OPTIONS_CONSIDER_OFFLINE_VMS = 2,
    PLACEMENT_OPTIONS_DONT_USE_MEMORY = 4,
    PLACEMENT_OPTIONS_DONT_USE_CPU = 8,
    PLACEMENT_OPTIONS_DONT_USE_LOCAL_TEMP_DISK = 16,
    PLACEMENT_OPTIONS_DONT_RESUME_VMS_WITH_EXISTING_TEMP_DISK = 32,
    PLACEMENT_OPTIONS_SAVE_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE = 64,
    PLACEMENT_OPTIONS_DONT_RESUME_AVAILABILTY_SET_VMS_WITH_EXISTING_TEMP_DISK = 128,
    PLACEMENT_OPTIONS_SAVE_AVAILABILTY_SET_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE = 256,
    PLACEMENT_OPTIONS_AVAILABILITY_SET_DOMAIN_AFFINITY = 512,
    PLACEMENT_OPTIONS_ALL = 1023,
}

enum GRP_PLACEMENT_OPTIONS
{
    GRP_PLACEMENT_OPTIONS_MIN_VALUE = 0,
    GRP_PLACEMENT_OPTIONS_DEFAULT = 0,
    GRP_PLACEMENT_OPTIONS_DISABLE_AUTOBALANCING = 1,
    GRP_PLACEMENT_OPTIONS_ALL = 1,
}

struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO
{
    ulong PartitionOffset;
    uint Capabilities;
}

struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_ARRAY
{
    uint Count;
    SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO PartitionArray;
}

enum SR_REPLICATED_DISK_TYPE
{
    SrReplicatedDiskTypeNone = 0,
    SrReplicatedDiskTypeSource = 1,
    SrReplicatedDiskTypeLogSource = 2,
    SrReplicatedDiskTypeDestination = 3,
    SrReplicatedDiskTypeLogDestination = 4,
    SrReplicatedDiskTypeNotInParthership = 5,
    SrReplicatedDiskTypeLogNotInParthership = 6,
    SrReplicatedDiskTypeOther = 7,
}

enum SR_DISK_REPLICATION_ELIGIBLE
{
    SrDiskReplicationEligibleNone = 0,
    SrDiskReplicationEligibleYes = 1,
    SrDiskReplicationEligibleOffline = 2,
    SrDiskReplicationEligibleNotGpt = 3,
    SrDiskReplicationEligiblePartitionLayoutMismatch = 4,
    SrDiskReplicationEligibleInsufficientFreeSpace = 5,
    SrDiskReplicationEligibleNotInSameSite = 6,
    SrDiskReplicationEligibleInSameSite = 7,
    SrDiskReplicationEligibleFileSystemNotSupported = 8,
    SrDiskReplicationEligibleAlreadyInReplication = 9,
    SrDiskReplicationEligibleSameAsSpecifiedDisk = 10,
    SrDiskReplicationEligibleOther = 9999,
}

struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_LOGDISKS
{
    Guid DataDiskGuid;
    ubyte IncludeOfflineDisks;
}

struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_TARGET_DATADISKS
{
    Guid SourceDataDiskGuid;
    Guid TargetReplicationGroupGuid;
    ubyte SkipConnectivityCheck;
    ubyte IncludeOfflineDisks;
}

struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_SOURCE_DATADISKS
{
    Guid DataDiskGuid;
    ubyte IncludeAvailableStoargeDisks;
}

struct SR_RESOURCE_TYPE_DISK_INFO
{
    SR_DISK_REPLICATION_ELIGIBLE Reason;
    Guid DiskGuid;
}

struct SR_RESOURCE_TYPE_ELIGIBLE_DISKS_RESULT
{
    ushort Count;
    SR_RESOURCE_TYPE_DISK_INFO DiskInfo;
}

struct SR_RESOURCE_TYPE_REPLICATED_DISK
{
    SR_REPLICATED_DISK_TYPE Type;
    Guid ClusterDiskResourceGuid;
    Guid ReplicationGroupId;
    ushort ReplicationGroupName;
}

struct SR_RESOURCE_TYPE_REPLICATED_DISKS_RESULT
{
    ushort Count;
    SR_RESOURCE_TYPE_REPLICATED_DISK ReplicatedDisks;
}

struct CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INPUT
{
    uint dwFlags;
    Guid guidPoolFilter;
}

struct RESOURCE_STATUS
{
    CLUSTER_RESOURCE_STATE ResourceState;
    uint CheckPoint;
    uint WaitHint;
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

enum VM_RESDLL_CONTEXT
{
    VmResdllContextTurnOff = 0,
    VmResdllContextSave = 1,
    VmResdllContextShutdown = 2,
    VmResdllContextShutdownForce = 3,
    VmResdllContextLiveMigration = 4,
}

enum RESDLL_CONTEXT_OPERATION_TYPE
{
    ResdllContextOperationTypeFailback = 0,
    ResdllContextOperationTypeDrain = 1,
    ResdllContextOperationTypeDrainFailure = 2,
    ResdllContextOperationTypeEmbeddedFailure = 3,
    ResdllContextOperationTypePreemption = 4,
    ResdllContextOperationTypeNetworkDisconnect = 5,
    ResdllContextOperationTypeNetworkDisconnectMoveRetry = 6,
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
    uint CheckPoint;
    HANDLE EventHandle;
    uint ApplicationSpecificErrorCode;
    uint Flags;
    uint WaitHint;
}

alias PSET_RESOURCE_STATUS_ROUTINE_EX = extern(Windows) uint function(int ResourceHandle, RESOURCE_STATUS_EX* ResourceStatus);
alias PSET_RESOURCE_STATUS_ROUTINE = extern(Windows) uint function(int ResourceHandle, RESOURCE_STATUS* ResourceStatus);
alias PQUORUM_RESOURCE_LOST = extern(Windows) void function(int Resource);
enum LOG_LEVEL
{
    LOG_INFORMATION = 0,
    LOG_WARNING = 1,
    LOG_ERROR = 2,
    LOG_SEVERE = 3,
}

alias PLOG_EVENT_ROUTINE = extern(Windows) void function(int ResourceHandle, LOG_LEVEL LogLevel, const(wchar)* FormatString);
alias POPEN_ROUTINE = extern(Windows) void* function(const(wchar)* ResourceName, HKEY ResourceKey, int ResourceHandle);
alias PCLOSE_ROUTINE = extern(Windows) void function(void* Resource);
alias PONLINE_ROUTINE = extern(Windows) uint function(void* Resource, int* EventHandle);
alias POFFLINE_ROUTINE = extern(Windows) uint function(void* Resource);
alias PTERMINATE_ROUTINE = extern(Windows) void function(void* Resource);
alias PIS_ALIVE_ROUTINE = extern(Windows) BOOL function(void* Resource);
alias PLOOKS_ALIVE_ROUTINE = extern(Windows) BOOL function(void* Resource);
alias PARBITRATE_ROUTINE = extern(Windows) uint function(void* Resource, PQUORUM_RESOURCE_LOST LostQuorumResource);
alias PRELEASE_ROUTINE = extern(Windows) uint function(void* Resource);
alias PRESOURCE_CONTROL_ROUTINE = extern(Windows) uint function(void* Resource, uint ControlCode, void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, uint* BytesReturned);
alias PRESOURCE_TYPE_CONTROL_ROUTINE = extern(Windows) uint function(const(wchar)* ResourceTypeName, uint ControlCode, void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, uint* BytesReturned);
alias POPEN_V2_ROUTINE = extern(Windows) void* function(const(wchar)* ResourceName, HKEY ResourceKey, int ResourceHandle, uint OpenFlags);
alias PONLINE_V2_ROUTINE = extern(Windows) uint function(void* Resource, int* EventHandle, uint OnlineFlags, char* InBuffer, uint InBufferSize, uint Reserved);
alias POFFLINE_V2_ROUTINE = extern(Windows) uint function(void* Resource, const(wchar)* DestinationNodeName, uint OfflineFlags, char* InBuffer, uint InBufferSize, uint Reserved);
alias PCANCEL_ROUTINE = extern(Windows) uint function(void* Resource, uint CancelFlags_RESERVED);
alias PBEGIN_RESCALL_ROUTINE = extern(Windows) uint function(void* Resource, uint ControlCode, void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, uint* BytesReturned, long context, int* ReturnedAsynchronously);
alias PBEGIN_RESTYPECALL_ROUTINE = extern(Windows) uint function(const(wchar)* ResourceTypeName, uint ControlCode, void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, uint* BytesReturned, long context, int* ReturnedAsynchronously);
enum RESOURCE_EXIT_STATE
{
    ResourceExitStateContinue = 0,
    ResourceExitStateTerminate = 1,
    ResourceExitStateMax = 2,
}

alias PBEGIN_RESCALL_AS_USER_ROUTINE = extern(Windows) uint function(void* Resource, HANDLE TokenHandle, uint ControlCode, void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, uint* BytesReturned, long context, int* ReturnedAsynchronously);
alias PBEGIN_RESTYPECALL_AS_USER_ROUTINE = extern(Windows) uint function(const(wchar)* ResourceTypeName, HANDLE TokenHandle, uint ControlCode, void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, uint* BytesReturned, long context, int* ReturnedAsynchronously);
struct CLRES_V1_FUNCTIONS
{
    POPEN_ROUTINE Open;
    PCLOSE_ROUTINE Close;
    PONLINE_ROUTINE Online;
    POFFLINE_ROUTINE Offline;
    PTERMINATE_ROUTINE Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE IsAlive;
    PARBITRATE_ROUTINE Arbitrate;
    PRELEASE_ROUTINE Release;
    PRESOURCE_CONTROL_ROUTINE ResourceControl;
    PRESOURCE_TYPE_CONTROL_ROUTINE ResourceTypeControl;
}

struct CLRES_V2_FUNCTIONS
{
    POPEN_V2_ROUTINE Open;
    PCLOSE_ROUTINE Close;
    PONLINE_V2_ROUTINE Online;
    POFFLINE_V2_ROUTINE Offline;
    PTERMINATE_ROUTINE Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE IsAlive;
    PARBITRATE_ROUTINE Arbitrate;
    PRELEASE_ROUTINE Release;
    PRESOURCE_CONTROL_ROUTINE ResourceControl;
    PRESOURCE_TYPE_CONTROL_ROUTINE ResourceTypeControl;
    PCANCEL_ROUTINE Cancel;
}

struct CLRES_V3_FUNCTIONS
{
    POPEN_V2_ROUTINE Open;
    PCLOSE_ROUTINE Close;
    PONLINE_V2_ROUTINE Online;
    POFFLINE_V2_ROUTINE Offline;
    PTERMINATE_ROUTINE Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE IsAlive;
    PARBITRATE_ROUTINE Arbitrate;
    PRELEASE_ROUTINE Release;
    PBEGIN_RESCALL_ROUTINE BeginResourceControl;
    PBEGIN_RESTYPECALL_ROUTINE BeginResourceTypeControl;
    PCANCEL_ROUTINE Cancel;
}

struct CLRES_V4_FUNCTIONS
{
    POPEN_V2_ROUTINE Open;
    PCLOSE_ROUTINE Close;
    PONLINE_V2_ROUTINE Online;
    POFFLINE_V2_ROUTINE Offline;
    PTERMINATE_ROUTINE Terminate;
    PLOOKS_ALIVE_ROUTINE LooksAlive;
    PIS_ALIVE_ROUTINE IsAlive;
    PARBITRATE_ROUTINE Arbitrate;
    PRELEASE_ROUTINE Release;
    PBEGIN_RESCALL_ROUTINE BeginResourceControl;
    PBEGIN_RESTYPECALL_ROUTINE BeginResourceTypeControl;
    PCANCEL_ROUTINE Cancel;
    PBEGIN_RESCALL_AS_USER_ROUTINE BeginResourceControlAsUser;
    PBEGIN_RESTYPECALL_AS_USER_ROUTINE BeginResourceTypeControlAsUser;
}

struct CLRES_FUNCTION_TABLE
{
    uint TableSize;
    uint Version;
    _Anonymous_e__Union Anonymous;
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
    uint Format;
    _Anonymous_e__Union Anonymous;
    uint Minimum;
    uint Maximum;
    uint Flags;
    uint Offset;
}

alias PSTARTUP_ROUTINE = extern(Windows) uint function(const(wchar)* ResourceType, uint MinVersionSupported, uint MaxVersionSupported, PSET_RESOURCE_STATUS_ROUTINE SetResourceStatus, PLOG_EVENT_ROUTINE LogEvent, CLRES_FUNCTION_TABLE** FunctionTable);
enum FAILURE_TYPE
{
    FAILURE_TYPE_GENERAL = 0,
    FAILURE_TYPE_EMBEDDED = 1,
    FAILURE_TYPE_NETWORK_LOSS = 2,
}

enum CLUSTER_RESOURCE_APPLICATION_STATE
{
    ClusterResourceApplicationStateUnknown = 1,
    ClusterResourceApplicationOSHeartBeat = 2,
    ClusterResourceApplicationReady = 3,
}

alias PSET_RESOURCE_LOCKED_MODE_ROUTINE = extern(Windows) uint function(int ResourceHandle, BOOL LockedModeEnabled, uint LockedModeReason);
alias PSIGNAL_FAILURE_ROUTINE = extern(Windows) uint function(int ResourceHandle, FAILURE_TYPE FailureType, uint ApplicationSpecificErrorCode);
alias PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE = extern(Windows) uint function(int ResourceHandle, ubyte* propertyListBuffer, uint propertyListBufferSize);
alias PEND_CONTROL_CALL = extern(Windows) uint function(const(long) context, uint status);
alias PEND_TYPE_CONTROL_CALL = extern(Windows) uint function(const(long) context, uint status);
alias PEXTEND_RES_CONTROL_CALL = extern(Windows) uint function(const(long) context, uint newTimeoutInMs);
alias PEXTEND_RES_TYPE_CONTROL_CALL = extern(Windows) uint function(const(long) context, uint newTimeoutInMs);
alias PRAISE_RES_TYPE_NOTIFICATION = extern(Windows) uint function(const(wchar)* ResourceType, char* pPayload, uint payloadSize);
alias PCHANGE_RESOURCE_PROCESS_FOR_DUMPS = extern(Windows) uint function(int resource, const(wchar)* processName, uint processId, BOOL isAdd);
alias PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS = extern(Windows) uint function(const(wchar)* resourceTypeName, const(wchar)* processName, uint processId, BOOL isAdd);
alias PSET_INTERNAL_STATE = extern(Windows) uint function(int param0, CLUSTER_RESOURCE_APPLICATION_STATE stateType, BOOL active);
alias PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE = extern(Windows) uint function(int ResourceHandle, BOOL LockedModeEnabled, uint LockedModeReason, uint LockedModeFlags);
struct CLRES_CALLBACK_FUNCTION_TABLE
{
    PLOG_EVENT_ROUTINE LogEvent;
    PSET_RESOURCE_STATUS_ROUTINE_EX SetResourceStatusEx;
    PSET_RESOURCE_LOCKED_MODE_ROUTINE SetResourceLockedMode;
    PSIGNAL_FAILURE_ROUTINE SignalFailure;
    PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE SetResourceInMemoryNodeLocalProperties;
    PEND_CONTROL_CALL EndControlCall;
    PEND_TYPE_CONTROL_CALL EndTypeControlCall;
    PEXTEND_RES_CONTROL_CALL ExtendControlCall;
    PEXTEND_RES_TYPE_CONTROL_CALL ExtendTypeControlCall;
    PRAISE_RES_TYPE_NOTIFICATION RaiseResTypeNotification;
    PCHANGE_RESOURCE_PROCESS_FOR_DUMPS ChangeResourceProcessForDumps;
    PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS ChangeResTypeProcessForDumps;
    PSET_INTERNAL_STATE SetInternalState;
    PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE SetResourceLockedModeEx;
}

alias PSTARTUP_EX_ROUTINE = extern(Windows) uint function(const(wchar)* ResourceType, uint MinVersionSupported, uint MaxVersionSupported, CLRES_CALLBACK_FUNCTION_TABLE* MonitorCallbackFunctions, CLRES_FUNCTION_TABLE** ResourceDllInterfaceFunctions);
enum RESOURCE_MONITOR_STATE
{
    RmonInitializing = 0,
    RmonIdle = 1,
    RmonStartingResource = 2,
    RmonInitializingResource = 3,
    RmonOnlineResource = 4,
    RmonOfflineResource = 5,
    RmonShutdownResource = 6,
    RmonDeletingResource = 7,
    RmonIsAlivePoll = 8,
    RmonLooksAlivePoll = 9,
    RmonArbitrateResource = 10,
    RmonReleaseResource = 11,
    RmonResourceControl = 12,
    RmonResourceTypeControl = 13,
    RmonTerminateResource = 14,
    RmonDeadlocked = 15,
}

struct MONITOR_STATE
{
    LARGE_INTEGER LastUpdate;
    RESOURCE_MONITOR_STATE State;
    HANDLE ActiveResource;
    BOOL ResmonStop;
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
    uint ErrorType;
    uint ErrorCode;
    const(wchar)* Description;
    const(wchar)* Provider;
    uint Flags;
    uint Reserved;
}

struct CLUSTER_HEALTH_FAULT_ARRAY
{
    uint numFaults;
    CLUSTER_HEALTH_FAULT* faults;
}

alias PRESUTIL_START_RESOURCE_SERVICE = extern(Windows) uint function(const(wchar)* pszServiceName, SC_HANDLE__** phServiceHandle);
alias PRESUTIL_VERIFY_RESOURCE_SERVICE = extern(Windows) uint function(const(wchar)* pszServiceName);
alias PRESUTIL_STOP_RESOURCE_SERVICE = extern(Windows) uint function(const(wchar)* pszServiceName);
alias PRESUTIL_VERIFY_SERVICE = extern(Windows) uint function(SC_HANDLE__* hServiceHandle);
alias PRESUTIL_STOP_SERVICE = extern(Windows) uint function(SC_HANDLE__* hServiceHandle);
alias PRESUTIL_CREATE_DIRECTORY_TREE = extern(Windows) uint function(const(wchar)* pszPath);
alias PRESUTIL_IS_PATH_VALID = extern(Windows) BOOL function(const(wchar)* pszPath);
alias PRESUTIL_ENUM_PROPERTIES = extern(Windows) uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, const(wchar)* pszOutProperties, uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_ENUM_PRIVATE_PROPERTIES = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszOutProperties, uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_PROPERTIES = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_ALL_PROPERTIES = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_PRIVATE_PROPERTIES = extern(Windows) uint function(HKEY hkeyClusterKey, char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_PROPERTY_SIZE = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, uint* pcbOutPropertyListSize, uint* pnPropertyCount);
alias PRESUTIL_GET_PROPERTY = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, char* pOutPropertyItem, uint* pcbOutPropertyItemSize);
alias PRESUTIL_VERIFY_PROPERTY_TABLE = extern(Windows) uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, BOOL bAllowUnknownProperties, char* pInPropertyList, uint cbInPropertyListSize, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_TABLE = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, BOOL bAllowUnknownProperties, char* pInPropertyList, uint cbInPropertyListSize, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_TABLE_EX = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, BOOL bAllowUnknownProperties, const(void)* pInPropertyList, uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_PARAMETER_BLOCK = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, uint cbInPropertyListSize, ubyte* pOutParams);
alias PRESUTIL_SET_PROPERTY_PARAMETER_BLOCK_EX = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);
alias PRESUTIL_SET_UNKNOWN_PROPERTIES = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pInPropertyList, uint cbInPropertyListSize);
alias PRESUTIL_GET_PROPERTIES_TO_PARAMETER_BLOCK = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, ubyte* pOutParams, BOOL bCheckForRequiredProperties, ushort** pszNameOfPropInError);
alias PRESUTIL_PROPERTY_LIST_FROM_PARAMETER_BLOCK = extern(Windows) uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyList, uint* pcbOutPropertyListSize, const(ubyte)* pInParams, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_DUP_PARAMETER_BLOCK = extern(Windows) uint function(ubyte* pOutParams, const(ubyte)* pInParams, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);
alias PRESUTIL_FREE_PARAMETER_BLOCK = extern(Windows) void function(ubyte* pOutParams, const(ubyte)* pInParams, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);
alias PRESUTIL_ADD_UNKNOWN_PROPERTIES = extern(Windows) uint function(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* pOutPropertyList, uint pcbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_SET_PRIVATE_PROPERTY_LIST = extern(Windows) uint function(HKEY hkeyClusterKey, char* pInPropertyList, uint cbInPropertyListSize);
alias PRESUTIL_VERIFY_PRIVATE_PROPERTY_LIST = extern(Windows) uint function(char* pInPropertyList, uint cbInPropertyListSize);
alias PRESUTIL_DUP_STRING = extern(Windows) ushort* function(const(wchar)* pszInString);
alias PRESUTIL_GET_BINARY_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* ppbOutValue, uint* pcbOutValueSize);
alias PRESUTIL_GET_SZ_VALUE = extern(Windows) ushort* function(HKEY hkeyClusterKey, const(wchar)* pszValueName);
alias PRESUTIL_GET_EXPAND_SZ_VALUE = extern(Windows) ushort* function(HKEY hkeyClusterKey, const(wchar)* pszValueName, BOOL bExpand);
alias PRESUTIL_GET_DWORD_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint* pdwOutValue, uint dwDefaultValue);
alias PRESUTIL_GET_QWORD_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong* pqwOutValue, ulong qwDefaultValue);
alias PRESUTIL_SET_BINARY_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* pbNewValue, uint cbNewValueSize, char* ppbOutValue, uint* pcbOutValueSize);
alias PRESUTIL_SET_SZ_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, ushort** ppszOutString);
alias PRESUTIL_SET_EXPAND_SZ_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, ushort** ppszOutString);
alias PRESUTIL_SET_MULTI_SZ_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, uint cbNewValueSize, char* ppszOutValue, uint* pcbOutValueSize);
alias PRESUTIL_SET_DWORD_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint dwNewValue, uint* pdwOutValue);
alias PRESUTIL_SET_QWORD_VALUE = extern(Windows) uint function(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong qwNewValue, ulong* pqwOutValue);
alias PRESUTIL_GET_BINARY_PROPERTY = extern(Windows) uint function(ubyte** ppbOutValue, uint* pcbOutValueSize, const(CLUSPROP_BINARY)* pValueStruct, char* pbOldValue, uint cbOldValueSize, char* ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_SZ_PROPERTY = extern(Windows) uint function(ushort** ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, const(wchar)* pszOldValue, char* ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_MULTI_SZ_PROPERTY = extern(Windows) uint function(ushort** ppszOutValue, uint* pcbOutValueSize, const(CLUSPROP_SZ)* pValueStruct, const(wchar)* pszOldValue, uint cbOldValueSize, char* ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_DWORD_PROPERTY = extern(Windows) uint function(uint* pdwOutValue, const(CLUSPROP_DWORD)* pValueStruct, uint dwOldValue, uint dwMinimum, uint dwMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_LONG_PROPERTY = extern(Windows) uint function(int* plOutValue, const(CLUSPROP_LONG)* pValueStruct, int lOldValue, int lMinimum, int lMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_FILETIME_PROPERTY = extern(Windows) uint function(FILETIME* pftOutValue, const(CLUSPROP_FILETIME)* pValueStruct, FILETIME ftOldValue, FILETIME ftMinimum, FILETIME ftMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);
alias PRESUTIL_GET_ENVIRONMENT_WITH_NET_NAME = extern(Windows) void* function(_HRESOURCE* hResource);
alias PRESUTIL_FREE_ENVIRONMENT = extern(Windows) uint function(void* lpEnvironment);
alias PRESUTIL_EXPAND_ENVIRONMENT_STRINGS = extern(Windows) ushort* function(const(wchar)* pszSrc);
alias PRESUTIL_SET_RESOURCE_SERVICE_ENVIRONMENT = extern(Windows) uint function(const(wchar)* pszServiceName, _HRESOURCE* hResource, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);
alias PRESUTIL_REMOVE_RESOURCE_SERVICE_ENVIRONMENT = extern(Windows) uint function(const(wchar)* pszServiceName, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);
alias PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS = extern(Windows) uint function(const(wchar)* pszServiceName, SC_HANDLE__* schSCMHandle, SC_HANDLE__** phService, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);
alias PRESUTIL_FIND_SZ_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ushort** pszPropertyValue);
alias PRESUTIL_FIND_EXPAND_SZ_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ushort** pszPropertyValue);
alias PRESUTIL_FIND_EXPANDED_SZ_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ushort** pszPropertyValue);
alias PRESUTIL_FIND_DWORD_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, uint* pdwPropertyValue);
alias PRESUTIL_FIND_BINARY_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, char* pbPropertyValue, uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_MULTI_SZ_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, char* pszPropertyValue, uint* pcbPropertyValueSize);
alias PRESUTIL_FIND_LONG_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, int* plPropertyValue);
alias PRESUTIL_FIND_ULARGEINTEGER_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ulong* plPropertyValue);
alias PRESUTIL_FIND_FILETIME_PROPERTY = extern(Windows) uint function(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, FILETIME* pftPropertyValue);
struct CLUS_WORKER
{
    HANDLE hThread;
    BOOL Terminate;
}

alias PWORKER_START_ROUTINE = extern(Windows) uint function(CLUS_WORKER* pWorker, void* lpThreadParameter);
alias PCLUSAPI_CLUS_WORKER_CREATE = extern(Windows) uint function(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, void* lpParameter);
alias PCLUSAPIClusWorkerCheckTerminate = extern(Windows) BOOL function(CLUS_WORKER* lpWorker);
alias PCLUSAPI_CLUS_WORKER_TERMINATE = extern(Windows) void function(CLUS_WORKER* lpWorker);
alias LPRESOURCE_CALLBACK = extern(Windows) uint function(_HRESOURCE* param0, _HRESOURCE* param1, void* param2);
alias LPRESOURCE_CALLBACK_EX = extern(Windows) uint function(_HCLUSTER* param0, _HRESOURCE* param1, _HRESOURCE* param2, void* param3);
alias LPGROUP_CALLBACK_EX = extern(Windows) uint function(_HCLUSTER* param0, _HGROUP* param1, _HGROUP* param2, void* param3);
alias LPNODE_CALLBACK = extern(Windows) uint function(_HCLUSTER* param0, _HNODE* param1, CLUSTER_NODE_STATE param2, void* param3);
alias PRESUTIL_RESOURCES_EQUAL = extern(Windows) BOOL function(_HRESOURCE* hSelf, _HRESOURCE* hResource);
alias PRESUTIL_RESOURCE_TYPES_EQUAL = extern(Windows) BOOL function(const(wchar)* lpszResourceTypeName, _HRESOURCE* hResource);
alias PRESUTIL_IS_RESOURCE_CLASS_EQUAL = extern(Windows) BOOL function(CLUS_RESOURCE_CLASS_INFO* prci, _HRESOURCE* hResource);
alias PRESUTIL_ENUM_RESOURCES = extern(Windows) uint function(_HRESOURCE* hSelf, const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK pResCallBack, void* pParameter);
alias PRESUTIL_ENUM_RESOURCES_EX = extern(Windows) uint function(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY = extern(Windows) _HRESOURCE* function(HANDLE hSelf, const(wchar)* lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME = extern(Windows) _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, const(wchar)* lpszResourceType, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS = extern(Windows) _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY = extern(Windows) _HRESOURCE* function(const(wchar)* lpszResourceName, const(wchar)* lpszResourceType);
alias PRESUTIL_GET_RESOURCE_DEPENDENTIP_ADDRESS_PROPS = extern(Windows) uint function(_HRESOURCE* hResource, const(wchar)* pszAddress, uint* pcchAddress, const(wchar)* pszSubnetMask, uint* pcchSubnetMask, const(wchar)* pszNetwork, uint* pcchNetwork);
alias PRESUTIL_FIND_DEPENDENT_DISK_RESOURCE_DRIVE_LETTER = extern(Windows) uint function(_HCLUSTER* hCluster, _HRESOURCE* hResource, const(wchar)* pszDriveLetter, uint* pcchDriveLetter);
alias PRESUTIL_TERMINATE_SERVICE_PROCESS_FROM_RES_DLL = extern(Windows) uint function(uint dwServicePid, BOOL bOffline, uint* pdwResourceState, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);
alias PRESUTIL_GET_PROPERTY_FORMATS = extern(Windows) uint function(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyFormatList, uint cbPropertyFormatListSize, uint* pcbBytesReturned, uint* pcbRequired);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES = extern(Windows) uint function(_HCLUSTER* hCluster, _HRESOURCE** phClusterNameResource, _HRESOURCE** phClusterIPAddressResource, _HRESOURCE** phClusterQuorumResource);
alias PRESUTIL_GET_RESOURCE_NAME = extern(Windows) uint function(_HRESOURCE* hResource, const(wchar)* pszResourceName, uint* pcchResourceNameInOut);
enum CLUSTER_ROLE
{
    ClusterRoleDHCP = 0,
    ClusterRoleDTC = 1,
    ClusterRoleFileServer = 2,
    ClusterRoleGenericApplication = 3,
    ClusterRoleGenericScript = 4,
    ClusterRoleGenericService = 5,
    ClusterRoleISCSINameServer = 6,
    ClusterRoleMSMQ = 7,
    ClusterRoleNFS = 8,
    ClusterRolePrintServer = 9,
    ClusterRoleStandAloneNamespaceServer = 10,
    ClusterRoleVolumeShadowCopyServiceTask = 11,
    ClusterRoleWINS = 12,
    ClusterRoleTaskScheduler = 13,
    ClusterRoleNetworkFileSystem = 14,
    ClusterRoleDFSReplicatedFolder = 15,
    ClusterRoleDistributedFileSystem = 16,
    ClusterRoleDistributedNetworkName = 17,
    ClusterRoleFileShare = 18,
    ClusterRoleFileShareWitness = 19,
    ClusterRoleHardDisk = 20,
    ClusterRoleIPAddress = 21,
    ClusterRoleIPV6Address = 22,
    ClusterRoleIPV6TunnelAddress = 23,
    ClusterRoleISCSITargetServer = 24,
    ClusterRoleNetworkName = 25,
    ClusterRolePhysicalDisk = 26,
    ClusterRoleSODAFileServer = 27,
    ClusterRoleStoragePool = 28,
    ClusterRoleVirtualMachine = 29,
    ClusterRoleVirtualMachineConfiguration = 30,
    ClusterRoleVirtualMachineReplicaBroker = 31,
}

enum CLUSTER_ROLE_STATE
{
    ClusterRoleUnknown = -1,
    ClusterRoleClustered = 0,
    ClusterRoleUnclustered = 1,
}

alias PCLUSTER_IS_PATH_ON_SHARED_VOLUME = extern(Windows) BOOL function(const(wchar)* lpszPathName);
alias PCLUSTER_GET_VOLUME_PATH_NAME = extern(Windows) BOOL function(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, uint cchBufferLength);
alias PCLUSTER_GET_VOLUME_NAME_FOR_VOLUME_MOUNT_POINT = extern(Windows) BOOL function(const(wchar)* lpszVolumeMountPoint, const(wchar)* lpszVolumeName, uint cchBufferLength);
alias PCLUSTER_PREPARE_SHARED_VOLUME_FOR_BACKUP = extern(Windows) uint function(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, uint* lpcchVolumePathName, const(wchar)* lpszVolumeName, uint* lpcchVolumeName);
alias PCLUSTER_CLEAR_BACKUP_STATE_FOR_SHARED_VOLUME = extern(Windows) uint function(const(wchar)* lpszVolumePathName);
alias PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS_EX = extern(Windows) uint function(const(wchar)* pszServiceName, SC_HANDLE__* schSCMHandle, SC_HANDLE__** phService, uint dwDesiredAccess, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);
alias PRESUTIL_ENUM_RESOURCES_EX2 = extern(Windows) uint function(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_EX = extern(Windows) _HRESOURCE* function(HANDLE hSelf, const(wchar)* lpszResourceType, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME_EX = extern(Windows) _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, const(wchar)* lpszResourceType, BOOL bRecurse, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS_EX = extern(Windows) _HRESOURCE* function(_HCLUSTER* hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse, uint dwDesiredAccess);
alias PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY_EX = extern(Windows) _HRESOURCE* function(const(wchar)* lpszResourceName, const(wchar)* lpszResourceType, uint dwDesiredAccess);
alias PRESUTIL_GET_CORE_CLUSTER_RESOURCES_EX = extern(Windows) uint function(_HCLUSTER* hClusterIn, _HRESOURCE** phClusterNameResourceOut, _HRESOURCE** phClusterIPAddressResourceOut, _HRESOURCE** phClusterQuorumResourceOut, uint dwDesiredAccess);
struct _HCLUSCRYPTPROVIDER
{
}

alias POPEN_CLUSTER_CRYPT_PROVIDER = extern(Windows) _HCLUSCRYPTPROVIDER* function(const(wchar)* lpszResource, byte* lpszProvider, uint dwType, uint dwFlags);
alias POPEN_CLUSTER_CRYPT_PROVIDEREX = extern(Windows) _HCLUSCRYPTPROVIDER* function(const(wchar)* lpszResource, const(wchar)* lpszKeyname, byte* lpszProvider, uint dwType, uint dwFlags);
alias PCLOSE_CLUSTER_CRYPT_PROVIDER = extern(Windows) uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider);
alias PCLUSTER_ENCRYPT = extern(Windows) uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pData, uint cbData, ubyte** ppData, uint* pcbData);
alias PCLUSTER_DECRYPT = extern(Windows) uint function(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pCryptInput, uint cbCryptInput, ubyte** ppCryptOutput, uint* pcbCryptOutput);
alias PFREE_CLUSTER_CRYPT = extern(Windows) uint function(void* pCryptInfo);
struct PaxosTagCStruct
{
    ulong __padding__PaxosTagVtable;
    ulong __padding__NextEpochVtable;
    ulong __padding__NextEpoch_DateTimeVtable;
    ulong NextEpoch_DateTime_ticks;
    int NextEpoch_Value;
    uint __padding__BoundryNextEpoch;
    ulong __padding__EpochVtable;
    ulong __padding__Epoch_DateTimeVtable;
    ulong Epoch_DateTime_ticks;
    int Epoch_Value;
    uint __padding__BoundryEpoch;
    int Sequence;
    uint __padding__BoundrySequence;
}

struct WitnessTagUpdateHelper
{
    int Version;
    PaxosTagCStruct paxosToSet;
    PaxosTagCStruct paxosToValidate;
}

struct WitnessTagHelper
{
    int Version;
    PaxosTagCStruct paxosToValidate;
}

alias PREGISTER_APPINSTANCE = extern(Windows) uint function(HANDLE ProcessHandle, Guid* AppInstanceId, BOOL ChildrenInheritAppInstance);
alias PREGISTER_APPINSTANCE_VERSION = extern(Windows) uint function(Guid* AppInstanceId, ulong InstanceVersionHigh, ulong InstanceVersionLow);
alias PQUERY_APPINSTANCE_VERSION = extern(Windows) uint function(Guid* AppInstanceId, ulong* InstanceVersionHigh, ulong* InstanceVersionLow, int* VersionStatus);
alias PRESET_ALL_APPINSTANCE_VERSIONS = extern(Windows) uint function();
alias SET_APP_INSTANCE_CSV_FLAGS = extern(Windows) uint function(HANDLE ProcessHandle, uint Mask, uint Flags);
enum CLUADMEX_OBJECT_TYPE
{
    CLUADMEX_OT_NONE = 0,
    CLUADMEX_OT_CLUSTER = 1,
    CLUADMEX_OT_NODE = 2,
    CLUADMEX_OT_GROUP = 3,
    CLUADMEX_OT_RESOURCE = 4,
    CLUADMEX_OT_RESOURCETYPE = 5,
    CLUADMEX_OT_NETWORK = 6,
    CLUADMEX_OT_NETINTERFACE = 7,
}

const GUID IID_IGetClusterUIInfo = {0x97DEDE50, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE50, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterUIInfo : IUnknown
{
    HRESULT GetClusterName(BSTR lpszName, int* pcchName);
    uint GetLocale();
    HFONT GetFont();
    HICON GetIcon();
}

const GUID IID_IGetClusterDataInfo = {0x97DEDE51, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE51, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterDataInfo : IUnknown
{
    HRESULT GetClusterName(BSTR lpszName, int* pcchName);
    _HCLUSTER* GetClusterHandle();
    int GetObjectCount();
}

const GUID IID_IGetClusterObjectInfo = {0x97DEDE52, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE52, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterObjectInfo : IUnknown
{
    HRESULT GetObjectName(int lObjIndex, BSTR lpszName, int* pcchName);
    CLUADMEX_OBJECT_TYPE GetObjectType(int lObjIndex);
}

const GUID IID_IGetClusterNodeInfo = {0x97DEDE53, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE53, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterNodeInfo : IUnknown
{
    _HNODE* GetNodeHandle(int lObjIndex);
}

const GUID IID_IGetClusterGroupInfo = {0x97DEDE54, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE54, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterGroupInfo : IUnknown
{
    _HGROUP* GetGroupHandle(int lObjIndex);
}

const GUID IID_IGetClusterResourceInfo = {0x97DEDE55, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE55, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterResourceInfo : IUnknown
{
    _HRESOURCE* GetResourceHandle(int lObjIndex);
    HRESULT GetResourceTypeName(int lObjIndex, BSTR lpszResTypeName, int* pcchResTypeName);
    BOOL GetResourceNetworkName(int lObjIndex, BSTR lpszNetName, uint* pcchNetName);
}

const GUID IID_IGetClusterNetworkInfo = {0x97DEDE56, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE56, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterNetworkInfo : IUnknown
{
    _HNETWORK* GetNetworkHandle(int lObjIndex);
}

const GUID IID_IGetClusterNetInterfaceInfo = {0x97DEDE57, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE57, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IGetClusterNetInterfaceInfo : IUnknown
{
    _HNETINTERFACE* GetNetInterfaceHandle(int lObjIndex);
}

const GUID IID_IWCPropertySheetCallback = {0x97DEDE60, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE60, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWCPropertySheetCallback : IUnknown
{
    HRESULT AddPropertySheetPage(int* hpage);
}

const GUID IID_IWEExtendPropertySheet = {0x97DEDE61, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE61, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWEExtendPropertySheet : IUnknown
{
    HRESULT CreatePropertySheetPages(IUnknown piData, IWCPropertySheetCallback piCallback);
}

const GUID IID_IWCWizardCallback = {0x97DEDE62, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE62, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWCWizardCallback : IUnknown
{
    HRESULT AddWizardPage(int* hpage);
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

const GUID IID_IWEExtendWizard = {0x97DEDE63, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE63, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWEExtendWizard : IUnknown
{
    HRESULT CreateWizardPages(IUnknown piData, IWCWizardCallback piCallback);
}

const GUID IID_IWCContextMenuCallback = {0x97DEDE64, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE64, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWCContextMenuCallback : IUnknown
{
    HRESULT AddExtensionMenuItem(BSTR lpszName, BSTR lpszStatusBarText, uint nCommandID, uint nSubmenuCommandID, uint uFlags);
}

const GUID IID_IWEExtendContextMenu = {0x97DEDE65, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE65, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWEExtendContextMenu : IUnknown
{
    HRESULT AddContextMenuItems(IUnknown piData, IWCContextMenuCallback piCallback);
}

const GUID IID_IWEInvokeCommand = {0x97DEDE66, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE66, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWEInvokeCommand : IUnknown
{
    HRESULT InvokeCommand(uint nCommandID, IUnknown piData);
}

const GUID IID_IWCWizard97Callback = {0x97DEDE67, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE67, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWCWizard97Callback : IUnknown
{
    HRESULT AddWizard97Page(int* hpage);
    HRESULT EnableNext(int* hpage, BOOL bEnable);
}

const GUID IID_IWEExtendWizard97 = {0x97DEDE68, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]};
@GUID(0x97DEDE68, 0xFC6B, 0x11CF, [0xB5, 0xF5, 0x00, 0xA0, 0xC9, 0x0A, 0xB5, 0x05]);
interface IWEExtendWizard97 : IUnknown
{
    HRESULT CreateWizard97Pages(IUnknown piData, IWCWizard97Callback piCallback);
}

const GUID CLSID_ClusApplication = {0xF2E606E5, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E5, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusApplication;

const GUID CLSID_Cluster = {0xF2E606E3, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E3, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct Cluster;

const GUID CLSID_ClusVersion = {0xF2E60715, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60715, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusVersion;

const GUID CLSID_ClusResType = {0xF2E6070F, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6070F, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResType;

const GUID CLSID_ClusProperty = {0xF2E606FD, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606FD, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusProperty;

const GUID CLSID_ClusProperties = {0xF2E606FF, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606FF, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusProperties;

const GUID CLSID_DomainNames = {0xF2E606E1, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E1, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct DomainNames;

const GUID CLSID_ClusNetwork = {0xF2E606F1, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F1, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNetwork;

const GUID CLSID_ClusNetInterface = {0xF2E606ED, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606ED, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNetInterface;

const GUID CLSID_ClusNetInterfaces = {0xF2E606EF, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606EF, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNetInterfaces;

const GUID CLSID_ClusResDependencies = {0xF2E60703, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60703, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResDependencies;

const GUID CLSID_ClusResGroupResources = {0xF2E606E9, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E9, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResGroupResources;

const GUID CLSID_ClusResTypeResources = {0xF2E60713, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60713, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResTypeResources;

const GUID CLSID_ClusResGroupPreferredOwnerNodes = {0xF2E606E7, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E7, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResGroupPreferredOwnerNodes;

const GUID CLSID_ClusResPossibleOwnerNodes = {0xF2E6070D, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6070D, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResPossibleOwnerNodes;

const GUID CLSID_ClusNetworks = {0xF2E606F3, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F3, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNetworks;

const GUID CLSID_ClusNetworkNetInterfaces = {0xF2E606F5, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F5, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNetworkNetInterfaces;

const GUID CLSID_ClusNodeNetInterfaces = {0xF2E606FB, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606FB, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNodeNetInterfaces;

const GUID CLSID_ClusRefObject = {0xF2E60701, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60701, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusRefObject;

const GUID CLSID_ClusterNames = {0xF2E606EB, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606EB, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusterNames;

const GUID CLSID_ClusNode = {0xF2E606F7, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F7, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNode;

const GUID CLSID_ClusNodes = {0xF2E606F9, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F9, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusNodes;

const GUID CLSID_ClusResGroup = {0xF2E60705, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60705, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResGroup;

const GUID CLSID_ClusResGroups = {0xF2E60707, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60707, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResGroups;

const GUID CLSID_ClusResource = {0xF2E60709, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60709, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResource;

const GUID CLSID_ClusResources = {0xF2E6070B, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6070B, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResources;

const GUID CLSID_ClusResTypes = {0xF2E60711, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60711, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResTypes;

const GUID CLSID_ClusResTypePossibleOwnerNodes = {0xF2E60717, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60717, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResTypePossibleOwnerNodes;

const GUID CLSID_ClusPropertyValue = {0xF2E60719, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60719, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusPropertyValue;

const GUID CLSID_ClusPropertyValues = {0xF2E6071B, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6071B, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusPropertyValues;

const GUID CLSID_ClusPropertyValueData = {0xF2E6071D, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6071D, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusPropertyValueData;

const GUID CLSID_ClusPartition = {0xF2E6071F, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6071F, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusPartition;

const GUID CLSID_ClusPartitionEx = {0x53D51D26, 0xB51B, 0x4A79, [0xB2, 0xC3, 0x50, 0x48, 0xD9, 0x3A, 0x98, 0xFC]};
@GUID(0x53D51D26, 0xB51B, 0x4A79, [0xB2, 0xC3, 0x50, 0x48, 0xD9, 0x3A, 0x98, 0xFC]);
struct ClusPartitionEx;

const GUID CLSID_ClusPartitions = {0xF2E60721, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60721, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusPartitions;

const GUID CLSID_ClusDisk = {0xF2E60723, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60723, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusDisk;

const GUID CLSID_ClusDisks = {0xF2E60725, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60725, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusDisks;

const GUID CLSID_ClusScsiAddress = {0xF2E60727, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60727, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusScsiAddress;

const GUID CLSID_ClusRegistryKeys = {0xF2E60729, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60729, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusRegistryKeys;

const GUID CLSID_ClusCryptoKeys = {0xF2E6072B, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6072B, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusCryptoKeys;

const GUID CLSID_ClusResDependents = {0xF2E6072D, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6072D, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
struct ClusResDependents;

const GUID IID_ISClusApplication = {0xF2E606E6, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E6, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusApplication : IDispatch
{
    HRESULT get_DomainNames(ISDomainNames* ppDomains);
    HRESULT get_ClusterNames(BSTR bstrDomainName, ISClusterNames* ppClusters);
    HRESULT OpenCluster(BSTR bstrClusterName, ISCluster* pCluster);
}

const GUID IID_ISDomainNames = {0xF2E606E2, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E2, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISDomainNames : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrDomainName);
}

const GUID IID_ISClusterNames = {0xF2E606EC, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606EC, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusterNames : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrClusterName);
    HRESULT get_DomainName(BSTR* pbstrDomainName);
}

const GUID IID_ISClusRefObject = {0xF2E60702, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60702, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusRefObject : IDispatch
{
    HRESULT get_Handle(uint* phandle);
}

const GUID IID_ISClusVersion = {0xF2E60716, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60716, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISCluster = {0xF2E606E4, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E4, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISCluster : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(uint* phandle);
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

const GUID IID_ISClusNode = {0xF2E606F8, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F8, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNode : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Handle(uint* phandle);
    HRESULT get_NodeID(BSTR* pbstrNodeID);
    HRESULT get_State(CLUSTER_NODE_STATE* dwState);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Evict();
    HRESULT get_ResourceGroups(ISClusResGroups* ppResourceGroups);
    HRESULT get_Cluster(ISCluster* ppCluster);
    HRESULT get_NetInterfaces(ISClusNodeNetInterfaces* ppClusNetInterfaces);
}

const GUID IID_ISClusNodes = {0xF2E606FA, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606FA, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
}

const GUID IID_ISClusNetwork = {0xF2E606F2, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F2, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNetwork : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(uint* phandle);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrNetworkName);
    HRESULT get_NetworkID(BSTR* pbstrNetworkID);
    HRESULT get_State(CLUSTER_NETWORK_STATE* dwState);
    HRESULT get_NetInterfaces(ISClusNetworkNetInterfaces* ppClusNetInterfaces);
    HRESULT get_Cluster(ISCluster* ppCluster);
}

const GUID IID_ISClusNetworks = {0xF2E606F4, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F4, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNetworks : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetwork* ppClusNetwork);
}

const GUID IID_ISClusNetInterface = {0xF2E606EE, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606EE, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNetInterface : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Handle(uint* phandle);
    HRESULT get_State(CLUSTER_NETINTERFACE_STATE* dwState);
    HRESULT get_Cluster(ISCluster* ppCluster);
}

const GUID IID_ISClusNetInterfaces = {0xF2E606F0, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F0, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

const GUID IID_ISClusNodeNetInterfaces = {0xF2E606FC, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606FC, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNodeNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

const GUID IID_ISClusNetworkNetInterfaces = {0xF2E606F6, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606F6, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusNetworkNetInterfaces : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNetInterface* ppClusNetInterface);
}

const GUID IID_ISClusResGroup = {0xF2E60706, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60706, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResGroup : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(uint* phandle);
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

const GUID IID_ISClusResGroups = {0xF2E60708, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60708, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResGroups : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResGroup* ppClusResGroup);
    HRESULT CreateItem(BSTR bstrResourceGroupName, ISClusResGroup* ppResourceGroup);
    HRESULT DeleteItem(VARIANT varIndex);
}

const GUID IID_ISClusResource = {0xF2E6070A, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6070A, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResource : IDispatch
{
    HRESULT get_CommonProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateProperties(ISClusProperties* ppProperties);
    HRESULT get_CommonROProperties(ISClusProperties* ppProperties);
    HRESULT get_PrivateROProperties(ISClusProperties* ppProperties);
    HRESULT get_Handle(uint* phandle);
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

const GUID IID_ISClusResDependencies = {0xF2E60704, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60704, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResDependencies : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
    HRESULT AddItem(ISClusResource pResource);
    HRESULT RemoveItem(VARIANT varIndex);
}

const GUID IID_ISClusResGroupResources = {0xF2E606EA, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606EA, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResGroupResources : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
}

const GUID IID_ISClusResTypeResources = {0xF2E60714, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60714, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResTypeResources : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrGroupName, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
}

const GUID IID_ISClusResources = {0xF2E6070C, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6070C, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResources : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, BSTR bstrGroupName, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
}

const GUID IID_ISClusResGroupPreferredOwnerNodes = {0xF2E606E8, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606E8, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISClusResPossibleOwnerNodes = {0xF2E6070E, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6070E, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISClusResTypePossibleOwnerNodes = {0xF2E60718, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60718, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResTypePossibleOwnerNodes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusNode* ppNode);
}

const GUID IID_ISClusResType = {0xF2E60710, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60710, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISClusResTypes = {0xF2E60712, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60712, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResTypes : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResType* ppClusResType);
    HRESULT CreateItem(BSTR bstrResourceTypeName, BSTR bstrDisplayName, BSTR bstrResourceTypeDll, int dwLooksAlivePollInterval, int dwIsAlivePollInterval, ISClusResType* ppResourceType);
    HRESULT DeleteItem(VARIANT varIndex);
}

const GUID IID_ISClusProperty = {0xF2E606FE, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E606FE, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISClusPropertyValue = {0xF2E6071A, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6071A, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISClusPropertyValues = {0xF2E6071C, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6071C, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusPropertyValues : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusPropertyValue* ppPropertyValue);
    HRESULT CreateItem(BSTR bstrName, VARIANT varValue, ISClusPropertyValue* ppPropertyValue);
    HRESULT RemoveItem(VARIANT varIndex);
}

const GUID IID_ISClusProperties = {0xF2E60700, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60700, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISClusPropertyValueData = {0xF2E6071E, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6071E, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusPropertyValueData : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, VARIANT* pvarValue);
    HRESULT CreateItem(VARIANT varValue, VARIANT* pvarData);
    HRESULT RemoveItem(VARIANT varIndex);
}

const GUID IID_ISClusPartition = {0xF2E60720, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60720, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
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

const GUID IID_ISClusPartitionEx = {0x8802D4FE, 0xB32E, 0x4AD1, [0x9D, 0xBD, 0x64, 0xF1, 0x8E, 0x11, 0x66, 0xCE]};
@GUID(0x8802D4FE, 0xB32E, 0x4AD1, [0x9D, 0xBD, 0x64, 0xF1, 0x8E, 0x11, 0x66, 0xCE]);
interface ISClusPartitionEx : ISClusPartition
{
    HRESULT get_TotalSize(int* plTotalSize);
    HRESULT get_FreeSpace(int* plFreeSpace);
    HRESULT get_DeviceNumber(int* plDeviceNumber);
    HRESULT get_PartitionNumber(int* plPartitionNumber);
    HRESULT get_VolumeGuid(BSTR* pbstrVolumeGuid);
}

const GUID IID_ISClusPartitions = {0xF2E60722, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60722, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusPartitions : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusPartition* ppPartition);
}

const GUID IID_ISClusDisk = {0xF2E60724, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60724, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusDisk : IDispatch
{
    HRESULT get_Signature(int* plSignature);
    HRESULT get_ScsiAddress(ISClusScsiAddress* ppScsiAddress);
    HRESULT get_DiskNumber(int* plDiskNumber);
    HRESULT get_Partitions(ISClusPartitions* ppPartitions);
}

const GUID IID_ISClusDisks = {0xF2E60726, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60726, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusDisks : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT varIndex, ISClusDisk* ppDisk);
}

const GUID IID_ISClusScsiAddress = {0xF2E60728, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E60728, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusScsiAddress : IDispatch
{
    HRESULT get_PortNumber(VARIANT* pvarPortNumber);
    HRESULT get_PathId(VARIANT* pvarPathId);
    HRESULT get_TargetId(VARIANT* pvarTargetId);
    HRESULT get_Lun(VARIANT* pvarLun);
}

const GUID IID_ISClusRegistryKeys = {0xF2E6072A, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6072A, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusRegistryKeys : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrRegistryKey);
    HRESULT AddItem(BSTR bstrRegistryKey);
    HRESULT RemoveItem(VARIANT varIndex);
}

const GUID IID_ISClusCryptoKeys = {0xF2E6072C, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6072C, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusCryptoKeys : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, BSTR* pbstrCyrptoKey);
    HRESULT AddItem(BSTR bstrCryptoKey);
    HRESULT RemoveItem(VARIANT varIndex);
}

const GUID IID_ISClusResDependents = {0xF2E6072E, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]};
@GUID(0xF2E6072E, 0x2631, 0x11D1, [0x89, 0xF1, 0x00, 0xA0, 0xC9, 0x0D, 0x06, 0x1E]);
interface ISClusResDependents : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Refresh();
    HRESULT get_Item(VARIANT varIndex, ISClusResource* ppClusResource);
    HRESULT CreateItem(BSTR bstrResourceName, BSTR bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS dwFlags, ISClusResource* ppClusterResource);
    HRESULT DeleteItem(VARIANT varIndex);
    HRESULT AddItem(ISClusResource pResource);
    HRESULT RemoveItem(VARIANT varIndex);
}

@DllImport("CLUSAPI.dll")
uint GetNodeClusterState(const(wchar)* lpszNodeName, uint* pdwClusterState);

@DllImport("CLUSAPI.dll")
_HCLUSTER* OpenCluster(const(wchar)* lpszClusterName);

@DllImport("CLUSAPI.dll")
_HCLUSTER* OpenClusterEx(const(wchar)* lpszClusterName, uint DesiredAccess, uint* GrantedAccess);

@DllImport("CLUSAPI.dll")
BOOL CloseCluster(_HCLUSTER* hCluster);

@DllImport("CLUSAPI.dll")
uint SetClusterName(_HCLUSTER* hCluster, const(wchar)* lpszNewClusterName);

@DllImport("CLUSAPI.dll")
uint GetClusterInformation(_HCLUSTER* hCluster, const(wchar)* lpszClusterName, uint* lpcchClusterName, CLUSTERVERSIONINFO* lpClusterInfo);

@DllImport("CLUSAPI.dll")
uint GetClusterQuorumResource(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, uint* lpcchResourceName, const(wchar)* lpszDeviceName, uint* lpcchDeviceName, uint* lpdwMaxQuorumLogSize);

@DllImport("CLUSAPI.dll")
uint SetClusterQuorumResource(_HRESOURCE* hResource, const(wchar)* lpszDeviceName, uint dwMaxQuoLogSize);

@DllImport("CLUSAPI.dll")
uint BackupClusterDatabase(_HCLUSTER* hCluster, const(wchar)* lpszPathName);

@DllImport("CLUSAPI.dll")
uint RestoreClusterDatabase(const(wchar)* lpszPathName, BOOL bForce, const(wchar)* lpszQuorumDriveLetter);

@DllImport("CLUSAPI.dll")
uint SetClusterNetworkPriorityOrder(_HCLUSTER* hCluster, uint NetworkCount, char* NetworkList);

@DllImport("CLUSAPI.dll")
uint SetClusterServiceAccountPassword(const(wchar)* lpszClusterName, const(wchar)* lpszNewPassword, uint dwFlags, char* lpReturnStatusBuffer, uint* lpcbReturnStatusBufferSize);

@DllImport("CLUSAPI.dll")
uint ClusterControl(_HCLUSTER* hCluster, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterUpgradeFunctionalLevel(_HCLUSTER* hCluster, BOOL perform, PCLUSTER_UPGRADE_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
_HCHANGE* CreateClusterNotifyPortV2(_HCHANGE* hChange, _HCLUSTER* hCluster, NOTIFY_FILTER_AND_TYPE* Filters, uint dwFilterCount, uint dwNotifyKey);

@DllImport("CLUSAPI.dll")
uint RegisterClusterNotifyV2(_HCHANGE* hChange, NOTIFY_FILTER_AND_TYPE Filter, HANDLE hObject, uint dwNotifyKey);

@DllImport("CLUSAPI.dll")
uint GetNotifyEventHandle(_HCHANGE* hChange, int* lphTargetEvent);

@DllImport("CLUSAPI.dll")
uint GetClusterNotifyV2(_HCHANGE* hChange, uint* lpdwNotifyKey, NOTIFY_FILTER_AND_TYPE* pFilterAndType, char* buffer, uint* lpbBufferSize, const(wchar)* lpszObjectId, uint* lpcchObjectId, const(wchar)* lpszParentId, uint* lpcchParentId, const(wchar)* lpszName, uint* lpcchName, const(wchar)* lpszType, uint* lpcchType, uint dwMilliseconds);

@DllImport("CLUSAPI.dll")
_HCHANGE* CreateClusterNotifyPort(_HCHANGE* hChange, _HCLUSTER* hCluster, uint dwFilter, uint dwNotifyKey);

@DllImport("CLUSAPI.dll")
uint RegisterClusterNotify(_HCHANGE* hChange, uint dwFilterType, HANDLE hObject, uint dwNotifyKey);

@DllImport("CLUSAPI.dll")
uint GetClusterNotify(_HCHANGE* hChange, uint* lpdwNotifyKey, uint* lpdwFilterType, const(wchar)* lpszName, uint* lpcchName, uint dwMilliseconds);

@DllImport("CLUSAPI.dll")
BOOL CloseClusterNotifyPort(_HCHANGE* hChange);

@DllImport("CLUSAPI.dll")
_HCLUSENUM* ClusterOpenEnum(_HCLUSTER* hCluster, uint dwType);

@DllImport("CLUSAPI.dll")
uint ClusterGetEnumCount(_HCLUSENUM* hEnum);

@DllImport("CLUSAPI.dll")
uint ClusterEnum(_HCLUSENUM* hEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterCloseEnum(_HCLUSENUM* hEnum);

@DllImport("CLUSAPI.dll")
_HCLUSENUMEX* ClusterOpenEnumEx(_HCLUSTER* hCluster, uint dwType, void* pOptions);

@DllImport("CLUSAPI.dll")
uint ClusterGetEnumCountEx(_HCLUSENUMEX* hClusterEnum);

@DllImport("CLUSAPI.dll")
uint ClusterEnumEx(_HCLUSENUMEX* hClusterEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

@DllImport("CLUSAPI.dll")
uint ClusterCloseEnumEx(_HCLUSENUMEX* hClusterEnum);

@DllImport("CLUSAPI.dll")
_HGROUPSET* CreateClusterGroupSet(_HCLUSTER* hCluster, const(wchar)* groupSetName);

@DllImport("CLUSAPI.dll")
_HGROUPSET* OpenClusterGroupSet(_HCLUSTER* hCluster, const(wchar)* lpszGroupSetName);

@DllImport("CLUSAPI.dll")
BOOL CloseClusterGroupSet(_HGROUPSET* hGroupSet);

@DllImport("CLUSAPI.dll")
uint DeleteClusterGroupSet(_HGROUPSET* hGroupSet);

@DllImport("CLUSAPI.dll")
uint ClusterAddGroupToGroupSet(_HGROUPSET* hGroupSet, _HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterAddGroupToGroupSetWithDomains(_HGROUPSET* hGroupSet, _HGROUP* hGroup, uint faultDomain, uint updateDomain);

@DllImport("CLUSAPI.dll")
uint ClusterRemoveGroupFromGroupSet(_HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterGroupSetControl(_HGROUPSET* hGroupSet, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint AddClusterGroupDependency(_HGROUP* hDependentGroup, _HGROUP* hProviderGroup);

@DllImport("CLUSAPI.dll")
uint SetGroupDependencyExpression(_HGROUP* hGroup, const(wchar)* lpszDependencyExpression);

@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupDependency(_HGROUP* hGroup, _HGROUP* hDependsOn);

@DllImport("CLUSAPI.dll")
uint AddClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, _HGROUPSET* hProviderGroupSet);

@DllImport("CLUSAPI.dll")
uint SetClusterGroupSetDependencyExpression(_HGROUPSET* hGroupSet, const(wchar)* lpszDependencyExprssion);

@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupSetDependency(_HGROUPSET* hGroupSet, _HGROUPSET* hDependsOn);

@DllImport("CLUSAPI.dll")
uint AddClusterGroupToGroupSetDependency(_HGROUP* hDependentGroup, _HGROUPSET* hProviderGroupSet);

@DllImport("CLUSAPI.dll")
uint RemoveClusterGroupToGroupSetDependency(_HGROUP* hGroup, _HGROUPSET* hDependsOn);

@DllImport("CLUSAPI.dll")
_HGROUPSETENUM* ClusterGroupSetOpenEnum(_HCLUSTER* hCluster);

@DllImport("CLUSAPI.dll")
uint ClusterGroupSetGetEnumCount(_HGROUPSETENUM* hGroupSetEnum);

@DllImport("CLUSAPI.dll")
uint ClusterGroupSetEnum(_HGROUPSETENUM* hGroupSetEnum, uint dwIndex, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterGroupSetCloseEnum(_HGROUPSETENUM* hGroupSetEnum);

@DllImport("CLUSAPI.dll")
uint AddCrossClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, const(wchar)* lpRemoteClusterName, const(wchar)* lpRemoteGroupSetName);

@DllImport("CLUSAPI.dll")
uint RemoveCrossClusterGroupSetDependency(_HGROUPSET* hDependentGroupSet, const(wchar)* lpRemoteClusterName, const(wchar)* lpRemoteGroupSetName);

@DllImport("CLUSAPI.dll")
_HGROUPSET* CreateClusterAvailabilitySet(_HCLUSTER* hCluster, const(wchar)* lpAvailabilitySetName, CLUSTER_AVAILABILITY_SET_CONFIG* pAvailabilitySetConfig);

@DllImport("CLUSAPI.dll")
uint ClusterNodeReplacement(_HCLUSTER* hCluster, const(wchar)* lpszNodeNameCurrent, const(wchar)* lpszNodeNameNew);

@DllImport("CLUSAPI.dll")
uint ClusterCreateAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName, CLUS_AFFINITY_RULE_TYPE ruleType);

@DllImport("CLUSAPI.dll")
uint ClusterRemoveAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName);

@DllImport("CLUSAPI.dll")
uint ClusterAddGroupToAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName, _HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterRemoveGroupFromAffinityRule(_HCLUSTER* hCluster, const(wchar)* ruleName, _HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
uint ClusterAffinityRuleControl(_HCLUSTER* hCluster, const(wchar)* affinityRuleName, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
_HNODE* OpenClusterNode(_HCLUSTER* hCluster, const(wchar)* lpszNodeName);

@DllImport("CLUSAPI.dll")
_HNODE* OpenClusterNodeEx(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, uint dwDesiredAccess, uint* lpdwGrantedAccess);

@DllImport("CLUSAPI.dll")
_HNODE* OpenClusterNodeById(_HCLUSTER* hCluster, uint nodeId);

@DllImport("CLUSAPI.dll")
BOOL CloseClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI.dll")
CLUSTER_NODE_STATE GetClusterNodeState(_HNODE* hNode);

@DllImport("CLUSAPI.dll")
uint GetClusterNodeId(_HNODE* hNode, const(wchar)* lpszNodeId, uint* lpcchName);

@DllImport("CLUSAPI.dll")
_HCLUSTER* GetClusterFromNode(_HNODE* hNode);

@DllImport("CLUSAPI.dll")
uint PauseClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI.dll")
uint ResumeClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI.dll")
uint EvictClusterNode(_HNODE* hNode);

@DllImport("CLUSAPI.dll")
_HNETINTERFACEENUM* ClusterNetInterfaceOpenEnum(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, const(wchar)* lpszNetworkName);

@DllImport("CLUSAPI.dll")
uint ClusterNetInterfaceEnum(_HNETINTERFACEENUM* hNetInterfaceEnum, uint dwIndex, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterNetInterfaceCloseEnum(_HNETINTERFACEENUM* hNetInterfaceEnum);

@DllImport("CLUSAPI.dll")
_HNODEENUM* ClusterNodeOpenEnum(_HNODE* hNode, uint dwType);

@DllImport("CLUSAPI.dll")
_HNODEENUMEX* ClusterNodeOpenEnumEx(_HNODE* hNode, uint dwType, void* pOptions);

@DllImport("CLUSAPI.dll")
uint ClusterNodeGetEnumCountEx(_HNODEENUMEX* hNodeEnum);

@DllImport("CLUSAPI.dll")
uint ClusterNodeEnumEx(_HNODEENUMEX* hNodeEnum, uint dwIndex, CLUSTER_ENUM_ITEM* pItem, uint* cbItem);

@DllImport("CLUSAPI.dll")
uint ClusterNodeCloseEnumEx(_HNODEENUMEX* hNodeEnum);

@DllImport("CLUSAPI.dll")
uint ClusterNodeGetEnumCount(_HNODEENUM* hNodeEnum);

@DllImport("CLUSAPI.dll")
uint ClusterNodeCloseEnum(_HNODEENUM* hNodeEnum);

@DllImport("CLUSAPI.dll")
uint ClusterNodeEnum(_HNODEENUM* hNodeEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint EvictClusterNodeEx(_HNODE* hNode, uint dwTimeOut, int* phrCleanupStatus);

@DllImport("CLUSAPI.dll")
HKEY GetClusterResourceTypeKey(_HCLUSTER* hCluster, const(wchar)* lpszTypeName, uint samDesired);

@DllImport("CLUSAPI.dll")
_HGROUP* CreateClusterGroup(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);

@DllImport("CLUSAPI.dll")
_HGROUP* OpenClusterGroup(_HCLUSTER* hCluster, const(wchar)* lpszGroupName);

@DllImport("CLUSAPI.dll")
_HGROUP* OpenClusterGroupEx(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, uint dwDesiredAccess, uint* lpdwGrantedAccess);

@DllImport("CLUSAPI.dll")
uint PauseClusterNodeEx(_HNODE* hNode, BOOL bDrainNode, uint dwPauseFlags, _HNODE* hNodeDrainTarget);

@DllImport("CLUSAPI.dll")
uint ResumeClusterNodeEx(_HNODE* hNode, CLUSTER_NODE_RESUME_FAILBACK_TYPE eResumeFailbackType, uint dwResumeFlagsReserved);

@DllImport("CLUSAPI.dll")
_HGROUP* CreateClusterGroupEx(_HCLUSTER* hCluster, const(wchar)* lpszGroupName, CLUSTER_CREATE_GROUP_INFO* pGroupInfo);

@DllImport("CLUSAPI.dll")
_HGROUPENUMEX* ClusterGroupOpenEnumEx(_HCLUSTER* hCluster, const(wchar)* lpszProperties, uint cbProperties, const(wchar)* lpszRoProperties, uint cbRoProperties, uint dwFlags);

@DllImport("CLUSAPI.dll")
uint ClusterGroupGetEnumCountEx(_HGROUPENUMEX* hGroupEnumEx);

@DllImport("CLUSAPI.dll")
uint ClusterGroupEnumEx(_HGROUPENUMEX* hGroupEnumEx, uint dwIndex, CLUSTER_GROUP_ENUM_ITEM* pItem, uint* cbItem);

@DllImport("CLUSAPI.dll")
uint ClusterGroupCloseEnumEx(_HGROUPENUMEX* hGroupEnumEx);

@DllImport("CLUSAPI.dll")
_HRESENUMEX* ClusterResourceOpenEnumEx(_HCLUSTER* hCluster, const(wchar)* lpszProperties, uint cbProperties, const(wchar)* lpszRoProperties, uint cbRoProperties, uint dwFlags);

@DllImport("CLUSAPI.dll")
uint ClusterResourceGetEnumCountEx(_HRESENUMEX* hResourceEnumEx);

@DllImport("CLUSAPI.dll")
uint ClusterResourceEnumEx(_HRESENUMEX* hResourceEnumEx, uint dwIndex, CLUSTER_RESOURCE_ENUM_ITEM* pItem, uint* cbItem);

@DllImport("CLUSAPI.dll")
uint ClusterResourceCloseEnumEx(_HRESENUMEX* hResourceEnumEx);

@DllImport("CLUSAPI.dll")
uint OnlineClusterGroupEx(_HGROUP* hGroup, _HNODE* hDestinationNode, uint dwOnlineFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint OfflineClusterGroupEx(_HGROUP* hGroup, uint dwOfflineFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint OnlineClusterResourceEx(_HRESOURCE* hResource, uint dwOnlineFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint OfflineClusterResourceEx(_HRESOURCE* hResource, uint dwOfflineFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint MoveClusterGroupEx(_HGROUP* hGroup, _HNODE* hDestinationNode, uint dwMoveFlags, char* lpInBuffer, uint cbInBufferSize);

@DllImport("CLUSAPI.dll")
uint CancelClusterGroupOperation(_HGROUP* hGroup, uint dwCancelFlags_RESERVED);

@DllImport("CLUSAPI.dll")
uint RestartClusterResource(_HRESOURCE* hResource, uint dwFlags);

@DllImport("CLUSAPI.dll")
BOOL CloseClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
_HCLUSTER* GetClusterFromGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
CLUSTER_GROUP_STATE GetClusterGroupState(_HGROUP* hGroup, const(wchar)* lpszNodeName, uint* lpcchNodeName);

@DllImport("CLUSAPI.dll")
uint SetClusterGroupName(_HGROUP* hGroup, const(wchar)* lpszGroupName);

@DllImport("CLUSAPI.dll")
uint SetClusterGroupNodeList(_HGROUP* hGroup, uint NodeCount, char* NodeList);

@DllImport("CLUSAPI.dll")
uint OnlineClusterGroup(_HGROUP* hGroup, _HNODE* hDestinationNode);

@DllImport("CLUSAPI.dll")
uint MoveClusterGroup(_HGROUP* hGroup, _HNODE* hDestinationNode);

@DllImport("CLUSAPI.dll")
uint OfflineClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
uint DeleteClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
uint DestroyClusterGroup(_HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
_HGROUPENUM* ClusterGroupOpenEnum(_HGROUP* hGroup, uint dwType);

@DllImport("CLUSAPI.dll")
uint ClusterGroupGetEnumCount(_HGROUPENUM* hGroupEnum);

@DllImport("CLUSAPI.dll")
uint ClusterGroupEnum(_HGROUPENUM* hGroupEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszResourceName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterGroupCloseEnum(_HGROUPENUM* hGroupEnum);

@DllImport("CLUSAPI.dll")
_HRESOURCE* CreateClusterResource(_HGROUP* hGroup, const(wchar)* lpszResourceName, const(wchar)* lpszResourceType, uint dwFlags);

@DllImport("CLUSAPI.dll")
_HRESOURCE* OpenClusterResource(_HCLUSTER* hCluster, const(wchar)* lpszResourceName);

@DllImport("CLUSAPI.dll")
_HRESOURCE* OpenClusterResourceEx(_HCLUSTER* hCluster, const(wchar)* lpszResourceName, uint dwDesiredAccess, uint* lpdwGrantedAccess);

@DllImport("CLUSAPI.dll")
BOOL CloseClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
_HCLUSTER* GetClusterFromResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
uint DeleteClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
CLUSTER_RESOURCE_STATE GetClusterResourceState(_HRESOURCE* hResource, const(wchar)* lpszNodeName, uint* lpcchNodeName, const(wchar)* lpszGroupName, uint* lpcchGroupName);

@DllImport("CLUSAPI.dll")
uint SetClusterResourceName(_HRESOURCE* hResource, const(wchar)* lpszResourceName);

@DllImport("CLUSAPI.dll")
uint FailClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
uint OnlineClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
uint OfflineClusterResource(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
uint ChangeClusterResourceGroup(_HRESOURCE* hResource, _HGROUP* hGroup);

@DllImport("CLUSAPI.dll")
uint ChangeClusterResourceGroupEx(_HRESOURCE* hResource, _HGROUP* hGroup, ulong Flags);

@DllImport("CLUSAPI.dll")
uint AddClusterResourceNode(_HRESOURCE* hResource, _HNODE* hNode);

@DllImport("CLUSAPI.dll")
uint RemoveClusterResourceNode(_HRESOURCE* hResource, _HNODE* hNode);

@DllImport("CLUSAPI.dll")
uint AddClusterResourceDependency(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);

@DllImport("CLUSAPI.dll")
uint RemoveClusterResourceDependency(_HRESOURCE* hResource, _HRESOURCE* hDependsOn);

@DllImport("CLUSAPI.dll")
uint SetClusterResourceDependencyExpression(_HRESOURCE* hResource, const(wchar)* lpszDependencyExpression);

@DllImport("CLUSAPI.dll")
uint GetClusterResourceDependencyExpression(_HRESOURCE* hResource, const(wchar)* lpszDependencyExpression, uint* lpcchDependencyExpression);

@DllImport("CLUSAPI.dll")
uint AddResourceToClusterSharedVolumes(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
uint RemoveResourceFromClusterSharedVolumes(_HRESOURCE* hResource);

@DllImport("CLUSAPI.dll")
uint IsFileOnClusterSharedVolume(const(wchar)* lpszPathName, int* pbFileIsOnSharedVolume);

@DllImport("CLUSAPI.dll")
uint ClusterSharedVolumeSetSnapshotState(Guid guidSnapshotSet, const(wchar)* lpszVolumeName, CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE state);

@DllImport("CLUSAPI.dll")
BOOL CanResourceBeDependent(_HRESOURCE* hResource, _HRESOURCE* hResourceDependent);

@DllImport("CLUSAPI.dll")
uint ClusterResourceControl(_HRESOURCE* hResource, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterResourceControlAsUser(_HRESOURCE* hResource, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeControl(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeControlAsUser(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterGroupControl(_HGROUP* hGroup, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
uint ClusterNodeControl(_HNODE* hNode, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
BOOL GetClusterResourceNetworkName(_HRESOURCE* hResource, const(wchar)* lpBuffer, uint* nSize);

@DllImport("CLUSAPI.dll")
_HRESENUM* ClusterResourceOpenEnum(_HRESOURCE* hResource, uint dwType);

@DllImport("CLUSAPI.dll")
uint ClusterResourceGetEnumCount(_HRESENUM* hResEnum);

@DllImport("CLUSAPI.dll")
uint ClusterResourceEnum(_HRESENUM* hResEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterResourceCloseEnum(_HRESENUM* hResEnum);

@DllImport("CLUSAPI.dll")
uint CreateClusterResourceType(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, const(wchar)* lpszDisplayName, const(wchar)* lpszResourceTypeDll, uint dwLooksAlivePollInterval, uint dwIsAlivePollInterval);

@DllImport("CLUSAPI.dll")
uint DeleteClusterResourceType(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName);

@DllImport("CLUSAPI.dll")
_HRESTYPEENUM* ClusterResourceTypeOpenEnum(_HCLUSTER* hCluster, const(wchar)* lpszResourceTypeName, uint dwType);

@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeGetEnumCount(_HRESTYPEENUM* hResTypeEnum);

@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeEnum(_HRESTYPEENUM* hResTypeEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterResourceTypeCloseEnum(_HRESTYPEENUM* hResTypeEnum);

@DllImport("CLUSAPI.dll")
_HNETWORK* OpenClusterNetwork(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName);

@DllImport("CLUSAPI.dll")
_HNETWORK* OpenClusterNetworkEx(_HCLUSTER* hCluster, const(wchar)* lpszNetworkName, uint dwDesiredAccess, uint* lpdwGrantedAccess);

@DllImport("CLUSAPI.dll")
BOOL CloseClusterNetwork(_HNETWORK* hNetwork);

@DllImport("CLUSAPI.dll")
_HCLUSTER* GetClusterFromNetwork(_HNETWORK* hNetwork);

@DllImport("CLUSAPI.dll")
_HNETWORKENUM* ClusterNetworkOpenEnum(_HNETWORK* hNetwork, uint dwType);

@DllImport("CLUSAPI.dll")
uint ClusterNetworkGetEnumCount(_HNETWORKENUM* hNetworkEnum);

@DllImport("CLUSAPI.dll")
uint ClusterNetworkEnum(_HNETWORKENUM* hNetworkEnum, uint dwIndex, uint* lpdwType, const(wchar)* lpszName, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterNetworkCloseEnum(_HNETWORKENUM* hNetworkEnum);

@DllImport("CLUSAPI.dll")
CLUSTER_NETWORK_STATE GetClusterNetworkState(_HNETWORK* hNetwork);

@DllImport("CLUSAPI.dll")
uint SetClusterNetworkName(_HNETWORK* hNetwork, const(wchar)* lpszName);

@DllImport("CLUSAPI.dll")
uint GetClusterNetworkId(_HNETWORK* hNetwork, const(wchar)* lpszNetworkId, uint* lpcchName);

@DllImport("CLUSAPI.dll")
uint ClusterNetworkControl(_HNETWORK* hNetwork, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
_HNETINTERFACE* OpenClusterNetInterface(_HCLUSTER* hCluster, const(wchar)* lpszInterfaceName);

@DllImport("CLUSAPI.dll")
_HNETINTERFACE* OpenClusterNetInterfaceEx(_HCLUSTER* hCluster, const(wchar)* lpszInterfaceName, uint dwDesiredAccess, uint* lpdwGrantedAccess);

@DllImport("CLUSAPI.dll")
uint GetClusterNetInterface(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, const(wchar)* lpszNetworkName, const(wchar)* lpszInterfaceName, uint* lpcchInterfaceName);

@DllImport("CLUSAPI.dll")
BOOL CloseClusterNetInterface(_HNETINTERFACE* hNetInterface);

@DllImport("CLUSAPI.dll")
_HCLUSTER* GetClusterFromNetInterface(_HNETINTERFACE* hNetInterface);

@DllImport("CLUSAPI.dll")
CLUSTER_NETINTERFACE_STATE GetClusterNetInterfaceState(_HNETINTERFACE* hNetInterface);

@DllImport("CLUSAPI.dll")
uint ClusterNetInterfaceControl(_HNETINTERFACE* hNetInterface, _HNODE* hHostNode, uint dwControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, uint nOutBufferSize, uint* lpBytesReturned);

@DllImport("CLUSAPI.dll")
HKEY GetClusterKey(_HCLUSTER* hCluster, uint samDesired);

@DllImport("CLUSAPI.dll")
HKEY GetClusterGroupKey(_HGROUP* hGroup, uint samDesired);

@DllImport("CLUSAPI.dll")
HKEY GetClusterResourceKey(_HRESOURCE* hResource, uint samDesired);

@DllImport("CLUSAPI.dll")
HKEY GetClusterNodeKey(_HNODE* hNode, uint samDesired);

@DllImport("CLUSAPI.dll")
HKEY GetClusterNetworkKey(_HNETWORK* hNetwork, uint samDesired);

@DllImport("CLUSAPI.dll")
HKEY GetClusterNetInterfaceKey(_HNETINTERFACE* hNetInterface, uint samDesired);

@DllImport("CLUSAPI.dll")
int ClusterRegCreateKey(HKEY hKey, const(wchar)* lpszSubKey, uint dwOptions, uint samDesired, SECURITY_ATTRIBUTES* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);

@DllImport("CLUSAPI.dll")
int ClusterRegOpenKey(HKEY hKey, const(wchar)* lpszSubKey, uint samDesired, HKEY* phkResult);

@DllImport("CLUSAPI.dll")
int ClusterRegDeleteKey(HKEY hKey, const(wchar)* lpszSubKey);

@DllImport("CLUSAPI.dll")
int ClusterRegCloseKey(HKEY hKey);

@DllImport("CLUSAPI.dll")
int ClusterRegEnumKey(HKEY hKey, uint dwIndex, const(wchar)* lpszName, uint* lpcchName, FILETIME* lpftLastWriteTime);

@DllImport("CLUSAPI.dll")
uint ClusterRegSetValue(HKEY hKey, const(wchar)* lpszValueName, uint dwType, const(ubyte)* lpData, uint cbData);

@DllImport("CLUSAPI.dll")
uint ClusterRegDeleteValue(HKEY hKey, const(wchar)* lpszValueName);

@DllImport("CLUSAPI.dll")
int ClusterRegQueryValue(HKEY hKey, const(wchar)* lpszValueName, uint* lpdwValueType, char* lpData, uint* lpcbData);

@DllImport("CLUSAPI.dll")
uint ClusterRegEnumValue(HKEY hKey, uint dwIndex, const(wchar)* lpszValueName, uint* lpcchValueName, uint* lpdwType, char* lpData, uint* lpcbData);

@DllImport("CLUSAPI.dll")
int ClusterRegQueryInfoKey(HKEY hKey, uint* lpcSubKeys, uint* lpcchMaxSubKeyLen, uint* lpcValues, uint* lpcchMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);

@DllImport("CLUSAPI.dll")
int ClusterRegGetKeySecurity(HKEY hKey, uint RequestedInformation, char* pSecurityDescriptor, uint* lpcbSecurityDescriptor);

@DllImport("CLUSAPI.dll")
int ClusterRegSetKeySecurity(HKEY hKey, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("CLUSAPI.dll")
int ClusterRegSyncDatabase(_HCLUSTER* hCluster, uint flags);

@DllImport("CLUSAPI.dll")
int ClusterRegCreateBatch(HKEY hKey, _HREGBATCH** pHREGBATCH);

@DllImport("CLUSAPI.dll")
int ClusterRegBatchAddCommand(_HREGBATCH* hRegBatch, CLUSTER_REG_COMMAND dwCommand, const(wchar)* wzName, uint dwOptions, char* lpData, uint cbData);

@DllImport("CLUSAPI.dll")
int ClusterRegCloseBatch(_HREGBATCH* hRegBatch, BOOL bCommit, int* failedCommandNumber);

@DllImport("CLUSAPI.dll")
int ClusterRegCloseBatchEx(_HREGBATCH* hRegBatch, uint flags, int* failedCommandNumber);

@DllImport("CLUSAPI.dll")
int ClusterRegBatchReadCommand(_HREGBATCHNOTIFICATION* hBatchNotification, CLUSTER_BATCH_COMMAND* pBatchCommand);

@DllImport("CLUSAPI.dll")
int ClusterRegBatchCloseNotification(_HREGBATCHNOTIFICATION* hBatchNotification);

@DllImport("CLUSAPI.dll")
int ClusterRegCreateBatchNotifyPort(HKEY hKey, _HREGBATCHPORT** phBatchNotifyPort);

@DllImport("CLUSAPI.dll")
int ClusterRegCloseBatchNotifyPort(_HREGBATCHPORT* hBatchNotifyPort);

@DllImport("CLUSAPI.dll")
int ClusterRegGetBatchNotification(_HREGBATCHPORT* hBatchNotify, _HREGBATCHNOTIFICATION** phBatchNotification);

@DllImport("CLUSAPI.dll")
int ClusterRegCreateReadBatch(HKEY hKey, _HREGREADBATCH** phRegReadBatch);

@DllImport("CLUSAPI.dll")
int ClusterRegReadBatchAddCommand(_HREGREADBATCH* hRegReadBatch, const(wchar)* wzSubkeyName, const(wchar)* wzValueName);

@DllImport("CLUSAPI.dll")
int ClusterRegCloseReadBatch(_HREGREADBATCH* hRegReadBatch, _HREGREADBATCHREPLY** phRegReadBatchReply);

@DllImport("CLUSAPI.dll")
int ClusterRegCloseReadBatchEx(_HREGREADBATCH* hRegReadBatch, uint flags, _HREGREADBATCHREPLY** phRegReadBatchReply);

@DllImport("CLUSAPI.dll")
int ClusterRegReadBatchReplyNextCommand(_HREGREADBATCHREPLY* hRegReadBatchReply, CLUSTER_READ_BATCH_COMMAND* pBatchCommand);

@DllImport("CLUSAPI.dll")
int ClusterRegCloseReadBatchReply(_HREGREADBATCHREPLY* hRegReadBatchReply);

@DllImport("CLUSAPI.dll")
uint ClusterSetAccountAccess(_HCLUSTER* hCluster, const(wchar)* szAccountSID, uint dwAccess, uint dwControlType);

@DllImport("CLUSAPI.dll")
_HCLUSTER* CreateCluster(CREATE_CLUSTER_CONFIG* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
uint CreateClusterNameAccount(_HCLUSTER* hCluster, CREATE_CLUSTER_NAME_ACCOUNT* pConfig, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
uint RemoveClusterNameAccount(_HCLUSTER* hCluster, BOOL bDeleteComputerObjects);

@DllImport("CLUSAPI.dll")
uint DetermineCNOResTypeFromNodelist(uint cNodes, ushort** ppszNodeNames, CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI.dll")
uint DetermineCNOResTypeFromCluster(_HCLUSTER* hCluster, CLUSTER_MGMT_POINT_RESTYPE* pCNOResType);

@DllImport("CLUSAPI.dll")
uint DetermineClusterCloudTypeFromNodelist(uint cNodes, ushort** ppszNodeNames, CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI.dll")
uint DetermineClusterCloudTypeFromCluster(_HCLUSTER* hCluster, CLUSTER_CLOUD_TYPE* pCloudType);

@DllImport("CLUSAPI.dll")
uint GetNodeCloudTypeDW(const(wchar)* ppszNodeName, uint* NodeCloudType);

@DllImport("CLUSAPI.dll")
uint RegisterClusterResourceTypeNotifyV2(_HCHANGE* hChange, _HCLUSTER* hCluster, long Flags, const(wchar)* resTypeName, uint dwNotifyKey);

@DllImport("CLUSAPI.dll")
_HNODE* AddClusterNode(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg);

@DllImport("CLUSAPI.dll")
uint AddClusterStorageNode(_HCLUSTER* hCluster, const(wchar)* lpszNodeName, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, const(wchar)* lpszClusterStorageNodeDescription, const(wchar)* lpszClusterStorageNodeLocation);

@DllImport("CLUSAPI.dll")
uint RemoveClusterStorageNode(_HCLUSTER* hCluster, const(wchar)* lpszClusterStorageEnclosureName, uint dwTimeout, uint dwFlags);

@DllImport("CLUSAPI.dll")
uint DestroyCluster(_HCLUSTER* hCluster, PCLUSTER_SETUP_PROGRESS_CALLBACK pfnProgressCallback, void* pvCallbackArg, BOOL fdeleteVirtualComputerObjects);

@DllImport("RESUTILS.dll")
uint InitializeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

@DllImport("RESUTILS.dll")
uint InitializeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

@DllImport("RESUTILS.dll")
uint FreeClusterHealthFault(CLUSTER_HEALTH_FAULT* clusterHealthFault);

@DllImport("RESUTILS.dll")
uint FreeClusterHealthFaultArray(CLUSTER_HEALTH_FAULT_ARRAY* clusterHealthFaultArray);

@DllImport("RESUTILS.dll")
uint ClusGetClusterHealthFaults(_HCLUSTER* hCluster, CLUSTER_HEALTH_FAULT_ARRAY* objects, uint flags);

@DllImport("RESUTILS.dll")
uint ClusRemoveClusterHealthFault(_HCLUSTER* hCluster, const(wchar)* id, uint flags);

@DllImport("RESUTILS.dll")
uint ClusAddClusterHealthFault(_HCLUSTER* hCluster, CLUSTER_HEALTH_FAULT* failure, uint param2);

@DllImport("RESUTILS.dll")
uint ResUtilStartResourceService(const(wchar)* pszServiceName, SC_HANDLE__** phServiceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilVerifyResourceService(const(wchar)* pszServiceName);

@DllImport("RESUTILS.dll")
uint ResUtilStopResourceService(const(wchar)* pszServiceName);

@DllImport("RESUTILS.dll")
uint ResUtilVerifyService(SC_HANDLE__* hServiceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilStopService(SC_HANDLE__* hServiceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilCreateDirectoryTree(const(wchar)* pszPath);

@DllImport("RESUTILS.dll")
BOOL ResUtilIsPathValid(const(wchar)* pszPath);

@DllImport("RESUTILS.dll")
uint ResUtilEnumProperties(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, const(wchar)* pszOutProperties, uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilEnumPrivateProperties(HKEY hkeyClusterKey, const(wchar)* pszOutProperties, uint cbOutPropertiesSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilGetProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilGetAllProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilGetPrivateProperties(HKEY hkeyClusterKey, char* pOutPropertyList, uint cbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilGetPropertySize(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, uint* pcbOutPropertyListSize, uint* pnPropertyCount);

@DllImport("RESUTILS.dll")
uint ResUtilGetProperty(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTableItem, char* pOutPropertyItem, uint* pcbOutPropertyItemSize);

@DllImport("RESUTILS.dll")
uint ResUtilVerifyPropertyTable(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, BOOL bAllowUnknownProperties, char* pInPropertyList, uint cbInPropertyListSize, ubyte* pOutParams);

@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyTable(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, BOOL bAllowUnknownProperties, char* pInPropertyList, uint cbInPropertyListSize, ubyte* pOutParams);

@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyTableEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, BOOL bAllowUnknownProperties, const(void)* pInPropertyList, uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);

@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, uint cbInPropertyListSize, ubyte* pOutParams);

@DllImport("RESUTILS.dll")
uint ResUtilSetPropertyParameterBlockEx(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* Reserved, const(ubyte)* pInParams, const(void)* pInPropertyList, uint cbInPropertyListSize, BOOL bForceWrite, ubyte* pOutParams);

@DllImport("RESUTILS.dll")
uint ResUtilSetUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pInPropertyList, uint cbInPropertyListSize);

@DllImport("RESUTILS.dll")
uint ResUtilGetPropertiesToParameterBlock(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, ubyte* pOutParams, BOOL bCheckForRequiredProperties, ushort** pszNameOfPropInError);

@DllImport("RESUTILS.dll")
uint ResUtilPropertyListFromParameterBlock(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyList, uint* pcbOutPropertyListSize, const(ubyte)* pInParams, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilDupParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

@DllImport("RESUTILS.dll")
void ResUtilFreeParameterBlock(ubyte* pOutParams, const(ubyte)* pInParams, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable);

@DllImport("RESUTILS.dll")
uint ResUtilAddUnknownProperties(HKEY hkeyClusterKey, const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, void* pOutPropertyList, uint pcbOutPropertyListSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilSetPrivatePropertyList(HKEY hkeyClusterKey, char* pInPropertyList, uint cbInPropertyListSize);

@DllImport("RESUTILS.dll")
uint ResUtilVerifyPrivatePropertyList(char* pInPropertyList, uint cbInPropertyListSize);

@DllImport("RESUTILS.dll")
ushort* ResUtilDupString(const(wchar)* pszInString);

@DllImport("RESUTILS.dll")
uint ResUtilGetBinaryValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* ppbOutValue, uint* pcbOutValueSize);

@DllImport("RESUTILS.dll")
ushort* ResUtilGetSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName);

@DllImport("RESUTILS.dll")
uint ResUtilGetDwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint* pdwOutValue, uint dwDefaultValue);

@DllImport("RESUTILS.dll")
uint ResUtilGetQwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong* pqwOutValue, ulong qwDefaultValue);

@DllImport("RESUTILS.dll")
uint ResUtilSetBinaryValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, char* pbNewValue, uint cbNewValueSize, char* ppbOutValue, uint* pcbOutValueSize);

@DllImport("RESUTILS.dll")
uint ResUtilSetSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, ushort** ppszOutString);

@DllImport("RESUTILS.dll")
uint ResUtilSetExpandSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, ushort** ppszOutString);

@DllImport("RESUTILS.dll")
uint ResUtilSetMultiSzValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, const(wchar)* pszNewValue, uint cbNewValueSize, char* ppszOutValue, uint* pcbOutValueSize);

@DllImport("RESUTILS.dll")
uint ResUtilSetDwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, uint dwNewValue, uint* pdwOutValue);

@DllImport("RESUTILS.dll")
uint ResUtilSetQwordValue(HKEY hkeyClusterKey, const(wchar)* pszValueName, ulong qwNewValue, ulong* pqwOutValue);

@DllImport("RESUTILS.dll")
uint ResUtilSetValueEx(HKEY hkeyClusterKey, const(wchar)* valueName, uint valueType, char* valueData, uint valueSize, uint flags);

@DllImport("RESUTILS.dll")
uint ResUtilGetBinaryProperty(ubyte** ppbOutValue, uint* pcbOutValueSize, const(CLUSPROP_BINARY)* pValueStruct, char* pbOldValue, uint cbOldValueSize, char* ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS.dll")
uint ResUtilGetSzProperty(ushort** ppszOutValue, const(CLUSPROP_SZ)* pValueStruct, const(wchar)* pszOldValue, char* ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS.dll")
uint ResUtilGetMultiSzProperty(ushort** ppszOutValue, uint* pcbOutValueSize, const(CLUSPROP_SZ)* pValueStruct, const(wchar)* pszOldValue, uint cbOldValueSize, char* ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS.dll")
uint ResUtilGetDwordProperty(uint* pdwOutValue, const(CLUSPROP_DWORD)* pValueStruct, uint dwOldValue, uint dwMinimum, uint dwMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS.dll")
uint ResUtilGetLongProperty(int* plOutValue, const(CLUSPROP_LONG)* pValueStruct, int lOldValue, int lMinimum, int lMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS.dll")
uint ResUtilGetFileTimeProperty(FILETIME* pftOutValue, const(CLUSPROP_FILETIME)* pValueStruct, FILETIME ftOldValue, FILETIME ftMinimum, FILETIME ftMaximum, ubyte** ppPropertyList, uint* pcbPropertyListSize);

@DllImport("RESUTILS.dll")
void* ResUtilGetEnvironmentWithNetName(_HRESOURCE* hResource);

@DllImport("RESUTILS.dll")
uint ResUtilFreeEnvironment(void* lpEnvironment);

@DllImport("RESUTILS.dll")
ushort* ResUtilExpandEnvironmentStrings(const(wchar)* pszSrc);

@DllImport("RESUTILS.dll")
uint ResUtilSetResourceServiceEnvironment(const(wchar)* pszServiceName, _HRESOURCE* hResource, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilRemoveResourceServiceEnvironment(const(wchar)* pszServiceName, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilSetResourceServiceStartParameters(const(wchar)* pszServiceName, SC_HANDLE__* schSCMHandle, SC_HANDLE__** phService, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilFindSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ushort** pszPropertyValue);

@DllImport("RESUTILS.dll")
uint ResUtilFindExpandSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ushort** pszPropertyValue);

@DllImport("RESUTILS.dll")
uint ResUtilFindExpandedSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ushort** pszPropertyValue);

@DllImport("RESUTILS.dll")
uint ResUtilFindDwordProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, uint* pdwPropertyValue);

@DllImport("RESUTILS.dll")
uint ResUtilFindBinaryProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, char* pbPropertyValue, uint* pcbPropertyValueSize);

@DllImport("RESUTILS.dll")
uint ResUtilFindMultiSzProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, char* pszPropertyValue, uint* pcbPropertyValueSize);

@DllImport("RESUTILS.dll")
uint ResUtilFindLongProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, int* plPropertyValue);

@DllImport("RESUTILS.dll")
uint ResUtilFindULargeIntegerProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, ulong* plPropertyValue);

@DllImport("RESUTILS.dll")
uint ResUtilFindFileTimeProperty(char* pPropertyList, uint cbPropertyListSize, const(wchar)* pszPropertyName, FILETIME* pftPropertyValue);

@DllImport("RESUTILS.dll")
uint ClusWorkerCreate(CLUS_WORKER* lpWorker, PWORKER_START_ROUTINE lpStartAddress, void* lpParameter);

@DllImport("RESUTILS.dll")
BOOL ClusWorkerCheckTerminate(CLUS_WORKER* lpWorker);

@DllImport("RESUTILS.dll")
void ClusWorkerTerminate(CLUS_WORKER* lpWorker);

@DllImport("RESUTILS.dll")
uint ClusWorkerTerminateEx(CLUS_WORKER* ClusWorker, uint TimeoutInMilliseconds, BOOL WaitOnly);

@DllImport("RESUTILS.dll")
uint ClusWorkersTerminate(char* ClusWorkers, const(uint) ClusWorkersCount, uint TimeoutInMilliseconds, BOOL WaitOnly);

@DllImport("RESUTILS.dll")
BOOL ResUtilResourcesEqual(_HRESOURCE* hSelf, _HRESOURCE* hResource);

@DllImport("RESUTILS.dll")
BOOL ResUtilResourceTypesEqual(const(wchar)* lpszResourceTypeName, _HRESOURCE* hResource);

@DllImport("RESUTILS.dll")
BOOL ResUtilIsResourceClassEqual(CLUS_RESOURCE_CLASS_INFO* prci, _HRESOURCE* hResource);

@DllImport("RESUTILS.dll")
uint ResUtilEnumResources(_HRESOURCE* hSelf, const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
uint ResUtilEnumResourcesEx(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceDependency(HANDLE hSelf, const(wchar)* lpszResourceType);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceDependencyByName(_HCLUSTER* hCluster, HANDLE hSelf, const(wchar)* lpszResourceType, BOOL bRecurse);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceDependencyByClass(_HCLUSTER* hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceNameDependency(const(wchar)* lpszResourceName, const(wchar)* lpszResourceType);

@DllImport("RESUTILS.dll")
uint ResUtilGetResourceDependentIPAddressProps(_HRESOURCE* hResource, const(wchar)* pszAddress, uint* pcchAddress, const(wchar)* pszSubnetMask, uint* pcchSubnetMask, const(wchar)* pszNetwork, uint* pcchNetwork);

@DllImport("RESUTILS.dll")
uint ResUtilFindDependentDiskResourceDriveLetter(_HCLUSTER* hCluster, _HRESOURCE* hResource, const(wchar)* pszDriveLetter, uint* pcchDriveLetter);

@DllImport("RESUTILS.dll")
uint ResUtilTerminateServiceProcessFromResDll(uint dwServicePid, BOOL bOffline, uint* pdwResourceState, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilGetPropertyFormats(const(RESUTIL_PROPERTY_ITEM)* pPropertyTable, char* pOutPropertyFormatList, uint cbPropertyFormatListSize, uint* pcbBytesReturned, uint* pcbRequired);

@DllImport("RESUTILS.dll")
uint ResUtilGetCoreClusterResources(_HCLUSTER* hCluster, _HRESOURCE** phClusterNameResource, _HRESOURCE** phClusterIPAddressResource, _HRESOURCE** phClusterQuorumResource);

@DllImport("RESUTILS.dll")
uint ResUtilGetResourceName(_HRESOURCE* hResource, const(wchar)* pszResourceName, uint* pcchResourceNameInOut);

@DllImport("RESUTILS.dll")
CLUSTER_ROLE_STATE ResUtilGetClusterRoleState(_HCLUSTER* hCluster, CLUSTER_ROLE eClusterRole);

@DllImport("RESUTILS.dll")
BOOL ClusterIsPathOnSharedVolume(const(wchar)* lpszPathName);

@DllImport("RESUTILS.dll")
BOOL ClusterGetVolumePathName(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, uint cchBufferLength);

@DllImport("RESUTILS.dll")
BOOL ClusterGetVolumeNameForVolumeMountPoint(const(wchar)* lpszVolumeMountPoint, const(wchar)* lpszVolumeName, uint cchBufferLength);

@DllImport("RESUTILS.dll")
uint ClusterPrepareSharedVolumeForBackup(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, uint* lpcchVolumePathName, const(wchar)* lpszVolumeName, uint* lpcchVolumeName);

@DllImport("RESUTILS.dll")
uint ClusterClearBackupStateForSharedVolume(const(wchar)* lpszVolumePathName);

@DllImport("RESUTILS.dll")
uint ResUtilSetResourceServiceStartParametersEx(const(wchar)* pszServiceName, SC_HANDLE__* schSCMHandle, SC_HANDLE__** phService, uint dwDesiredAccess, PLOG_EVENT_ROUTINE pfnLogEvent, int hResourceHandle);

@DllImport("RESUTILS.dll")
uint ResUtilEnumResourcesEx2(_HCLUSTER* hCluster, _HRESOURCE* hSelf, const(wchar)* lpszResTypeName, LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter, uint dwDesiredAccess);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceDependencyEx(HANDLE hSelf, const(wchar)* lpszResourceType, uint dwDesiredAccess);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceDependencyByNameEx(_HCLUSTER* hCluster, HANDLE hSelf, const(wchar)* lpszResourceType, BOOL bRecurse, uint dwDesiredAccess);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceDependencyByClassEx(_HCLUSTER* hCluster, HANDLE hSelf, CLUS_RESOURCE_CLASS_INFO* prci, BOOL bRecurse, uint dwDesiredAccess);

@DllImport("RESUTILS.dll")
_HRESOURCE* ResUtilGetResourceNameDependencyEx(const(wchar)* lpszResourceName, const(wchar)* lpszResourceType, uint dwDesiredAccess);

@DllImport("RESUTILS.dll")
uint ResUtilGetCoreClusterResourcesEx(_HCLUSTER* hClusterIn, _HRESOURCE** phClusterNameResourceOut, _HRESOURCE** phClusterQuorumResourceOut, uint dwDesiredAccess);

@DllImport("RESUTILS.dll")
_HCLUSCRYPTPROVIDER* OpenClusterCryptProvider(const(wchar)* lpszResource, byte* lpszProvider, uint dwType, uint dwFlags);

@DllImport("RESUTILS.dll")
_HCLUSCRYPTPROVIDER* OpenClusterCryptProviderEx(const(wchar)* lpszResource, const(wchar)* lpszKeyname, byte* lpszProvider, uint dwType, uint dwFlags);

@DllImport("RESUTILS.dll")
uint CloseClusterCryptProvider(_HCLUSCRYPTPROVIDER* hClusCryptProvider);

@DllImport("RESUTILS.dll")
uint ClusterEncrypt(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pData, uint cbData, ubyte** ppData, uint* pcbData);

@DllImport("RESUTILS.dll")
uint ClusterDecrypt(_HCLUSCRYPTPROVIDER* hClusCryptProvider, char* pCryptInput, uint cbCryptInput, ubyte** ppCryptOutput, uint* pcbCryptOutput);

@DllImport("RESUTILS.dll")
uint FreeClusterCrypt(void* pCryptInfo);

@DllImport("RESUTILS.dll")
BOOL ResUtilPaxosComparer(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

@DllImport("RESUTILS.dll")
BOOL ResUtilLeftPaxosIsLessThanRight(const(PaxosTagCStruct)* left, const(PaxosTagCStruct)* right);

@DllImport("RESUTILS.dll")
uint ResUtilsDeleteKeyTree(HKEY key, const(wchar)* keyName, BOOL treatNoKeyAsError);

@DllImport("RESUTILS.dll")
uint ResUtilGroupsEqual(_HGROUP* hSelf, _HGROUP* hGroup, int* pEqual);

@DllImport("RESUTILS.dll")
uint ResUtilEnumGroups(_HCLUSTER* hCluster, _HGROUP* hSelf, LPGROUP_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
uint ResUtilEnumGroupsEx(_HCLUSTER* hCluster, _HGROUP* hSelf, CLUSGROUP_TYPE groupType, LPGROUP_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
uint ResUtilDupGroup(_HGROUP* group, _HGROUP** copy);

@DllImport("RESUTILS.dll")
uint ResUtilGetClusterGroupType(_HGROUP* hGroup, CLUSGROUP_TYPE* groupType);

@DllImport("RESUTILS.dll")
_HGROUP* ResUtilGetCoreGroup(_HCLUSTER* hCluster);

@DllImport("RESUTILS.dll")
uint ResUtilResourceDepEnum(_HRESOURCE* hSelf, uint enumType, LPRESOURCE_CALLBACK_EX pResCallBack, void* pParameter);

@DllImport("RESUTILS.dll")
uint ResUtilDupResource(_HRESOURCE* group, _HRESOURCE** copy);

@DllImport("RESUTILS.dll")
uint ResUtilGetClusterId(_HCLUSTER* hCluster, Guid* guid);

@DllImport("RESUTILS.dll")
uint ResUtilNodeEnum(_HCLUSTER* hCluster, LPNODE_CALLBACK pNodeCallBack, void* pParameter);

@DllImport("NTLANMAN.dll")
uint RegisterAppInstance(HANDLE ProcessHandle, Guid* AppInstanceId, BOOL ChildrenInheritAppInstance);

@DllImport("NTLANMAN.dll")
uint RegisterAppInstanceVersion(Guid* AppInstanceId, ulong InstanceVersionHigh, ulong InstanceVersionLow);

@DllImport("NTLANMAN.dll")
uint QueryAppInstanceVersion(Guid* AppInstanceId, ulong* InstanceVersionHigh, ulong* InstanceVersionLow, int* VersionStatus);

@DllImport("NTLANMAN.dll")
uint ResetAllAppInstanceVersions();

@DllImport("NTLANMAN.dll")
uint SetAppInstanceCsvFlags(HANDLE ProcessHandle, uint Mask, uint Flags);

