// Written in the D programming language.

module windows.win32.system.services;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, HANDLE, PSTR, PWSTR;
public import windows.win32.security : OBJECT_SECURITY_INFORMATION, PSECURITY_DESCRIPTOR;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Enums


alias ENUM_SERVICE_STATE = uint;
enum : uint
{
    SERVICE_ACTIVE    = 0x00000001U,
    SERVICE_INACTIVE  = 0x00000002U,
    SERVICE_STATE_ALL = 0x00000003U,
}

//ENUM ATTR: AssociatedConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SERVICE_NO_CHANGE))], [])
alias SERVICE_ERROR = uint;
enum : uint
{
    SERVICE_ERROR_CRITICAL = 0x00000003U,
    SERVICE_ERROR_IGNORE   = 0x00000000U,
    SERVICE_ERROR_NORMAL   = 0x00000001U,
    SERVICE_ERROR_SEVERE   = 0x00000002U,
}

alias SERVICE_CONFIG = uint;
enum : uint
{
    SERVICE_CONFIG_DELAYED_AUTO_START_INFO  = 0x00000003U,
    SERVICE_CONFIG_DESCRIPTION              = 0x00000001U,
    SERVICE_CONFIG_FAILURE_ACTIONS          = 0x00000002U,
    SERVICE_CONFIG_FAILURE_ACTIONS_FLAG     = 0x00000004U,
    SERVICE_CONFIG_PREFERRED_NODE           = 0x00000009U,
    SERVICE_CONFIG_PRESHUTDOWN_INFO         = 0x00000007U,
    SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO = 0x00000006U,
    SERVICE_CONFIG_SERVICE_SID_INFO         = 0x00000005U,
    SERVICE_CONFIG_TRIGGER_INFO             = 0x00000008U,
    SERVICE_CONFIG_LAUNCH_PROTECTED         = 0x0000000cU,
}

//ENUM ATTR: AssociatedConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SERVICE_NO_CHANGE))], [])
alias ENUM_SERVICE_TYPE = uint;
enum : uint
{
    SERVICE_DRIVER              = 0x0000000bU,
    SERVICE_KERNEL_DRIVER       = 0x00000001U,
    SERVICE_WIN32               = 0x00000030U,
    SERVICE_WIN32_SHARE_PROCESS = 0x00000020U,
    SERVICE_ADAPTER             = 0x00000004U,
    SERVICE_FILE_SYSTEM_DRIVER  = 0x00000002U,
    SERVICE_RECOGNIZER_DRIVER   = 0x00000008U,
    SERVICE_WIN32_OWN_PROCESS   = 0x00000010U,
    SERVICE_USER_OWN_PROCESS    = 0x00000050U,
    SERVICE_USER_SHARE_PROCESS  = 0x00000060U,
}

//ENUM ATTR: AssociatedConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SERVICE_NO_CHANGE))], [])
alias SERVICE_START_TYPE = uint;
enum : uint
{
    SERVICE_AUTO_START   = 0x00000002U,
    SERVICE_BOOT_START   = 0x00000000U,
    SERVICE_DEMAND_START = 0x00000003U,
    SERVICE_DISABLED     = 0x00000004U,
    SERVICE_SYSTEM_START = 0x00000001U,
}

alias SERVICE_NOTIFY = uint;
enum : uint
{
    SERVICE_NOTIFY_CREATED          = 0x00000080U,
    SERVICE_NOTIFY_CONTINUE_PENDING = 0x00000010U,
    SERVICE_NOTIFY_DELETE_PENDING   = 0x00000200U,
    SERVICE_NOTIFY_DELETED          = 0x00000100U,
    SERVICE_NOTIFY_PAUSE_PENDING    = 0x00000020U,
    SERVICE_NOTIFY_PAUSED           = 0x00000040U,
    SERVICE_NOTIFY_RUNNING          = 0x00000008U,
    SERVICE_NOTIFY_START_PENDING    = 0x00000002U,
    SERVICE_NOTIFY_STOP_PENDING     = 0x00000004U,
    SERVICE_NOTIFY_STOPPED          = 0x00000001U,
}

alias SERVICE_RUNS_IN_PROCESS = uint;
enum : uint
{
    SERVICE_RUNS_IN_NON_SYSTEM_OR_NOT_RUNNING = 0x00000000U,
    SERVICE_RUNS_IN_SYSTEM_PROCESS            = 0x00000001U,
}

alias SERVICE_TRIGGER_ACTION = uint;
enum : uint
{
    SERVICE_TRIGGER_ACTION_SERVICE_START = 0x00000001U,
    SERVICE_TRIGGER_ACTION_SERVICE_STOP  = 0x00000002U,
}

alias SERVICE_TRIGGER_TYPE = uint;
enum : uint
{
    SERVICE_TRIGGER_TYPE_CUSTOM                   = 0x00000014U,
    SERVICE_TRIGGER_TYPE_DEVICE_INTERFACE_ARRIVAL = 0x00000001U,
    SERVICE_TRIGGER_TYPE_DOMAIN_JOIN              = 0x00000003U,
    SERVICE_TRIGGER_TYPE_FIREWALL_PORT_EVENT      = 0x00000004U,
    SERVICE_TRIGGER_TYPE_GROUP_POLICY             = 0x00000005U,
    SERVICE_TRIGGER_TYPE_IP_ADDRESS_AVAILABILITY  = 0x00000002U,
    SERVICE_TRIGGER_TYPE_NETWORK_ENDPOINT         = 0x00000006U,
}

alias SERVICE_TRIGGER_SPECIFIC_DATA_ITEM_DATA_TYPE = uint;
enum : uint
{
    SERVICE_TRIGGER_DATA_TYPE_BINARY      = 0x00000001U,
    SERVICE_TRIGGER_DATA_TYPE_STRING      = 0x00000002U,
    SERVICE_TRIGGER_DATA_TYPE_LEVEL       = 0x00000003U,
    SERVICE_TRIGGER_DATA_TYPE_KEYWORD_ANY = 0x00000004U,
    SERVICE_TRIGGER_DATA_TYPE_KEYWORD_ALL = 0x00000005U,
}

alias SERVICE_STATUS_CURRENT_STATE = uint;
enum : uint
{
    SERVICE_CONTINUE_PENDING = 0x00000005U,
    SERVICE_PAUSE_PENDING    = 0x00000006U,
    SERVICE_PAUSED           = 0x00000007U,
    SERVICE_RUNNING          = 0x00000004U,
    SERVICE_START_PENDING    = 0x00000002U,
    SERVICE_STOP_PENDING     = 0x00000003U,
    SERVICE_STOPPED          = 0x00000001U,
}

alias SC_ACTION_TYPE = int;
enum : int
{
    SC_ACTION_NONE        = 0x00000000,
    SC_ACTION_RESTART     = 0x00000001,
    SC_ACTION_REBOOT      = 0x00000002,
    SC_ACTION_RUN_COMMAND = 0x00000003,
    SC_ACTION_OWN_RESTART = 0x00000004,
}

alias SC_STATUS_TYPE = int;
enum : int
{
    SC_STATUS_PROCESS_INFO = 0x00000000,
}

alias SC_ENUM_TYPE = int;
enum : int
{
    SC_ENUM_PROCESS_INFO = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Services/sc-event-type
alias SC_EVENT_TYPE = int;
enum : int
{
    SC_EVENT_DATABASE_CHANGE = 0x00000000,
    SC_EVENT_PROPERTY_CHANGE = 0x00000001,
    SC_EVENT_STATUS_CHANGE   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_registry_state_type
alias SERVICE_REGISTRY_STATE_TYPE = int;
enum : int
{
    ServiceRegistryStateParameters = 0x00000000,
    ServiceRegistryStatePersistent = 0x00000001,
    MaxServiceRegistryStateType    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_directory_type
alias SERVICE_DIRECTORY_TYPE = int;
enum : int
{
    ServiceDirectoryPersistentState = 0x00000000,
    ServiceDirectoryTypeMax         = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_shared_registry_state_type
alias SERVICE_SHARED_REGISTRY_STATE_TYPE = int;
enum : int
{
    ServiceSharedRegistryPersistentState = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_shared_directory_type
alias SERVICE_SHARED_DIRECTORY_TYPE = int;
enum : int
{
    ServiceSharedDirectoryPersistentState = 0x00000000,
}

// Constants


enum uint SERVICE_ALL_ACCESS = 0x000f01ffU;
enum uint SC_MANAGER_ALL_ACCESS = 0x000f003fU;
enum const(wchar)* SERVICES_ACTIVE_DATABASEW = "ServicesActive";
enum const(wchar)* SERVICES_FAILED_DATABASEW = "ServicesFailed";
// Native encoding: ansi
enum const(wchar)* SERVICES_ACTIVE_DATABASEA = "ServicesActive";
// Native encoding: ansi
enum const(wchar)* SERVICES_FAILED_DATABASEA = "ServicesFailed";
enum const(wchar)* SERVICES_ACTIVE_DATABASE = "ServicesActive";
enum const(wchar)* SERVICES_FAILED_DATABASE = "ServicesFailed";

enum : uint
{
    SERVICE_NO_CHANGE                     = 0xffffffffU,
    SERVICE_CONTROL_STOP                  = 0x00000001U,
    SERVICE_CONTROL_PAUSE                 = 0x00000002U,
    SERVICE_CONTROL_CONTINUE              = 0x00000003U,
    SERVICE_CONTROL_INTERROGATE           = 0x00000004U,
    SERVICE_CONTROL_SHUTDOWN              = 0x00000005U,
    SERVICE_CONTROL_PARAMCHANGE           = 0x00000006U,
    SERVICE_CONTROL_NETBINDADD            = 0x00000007U,
    SERVICE_CONTROL_NETBINDREMOVE         = 0x00000008U,
    SERVICE_CONTROL_NETBINDENABLE         = 0x00000009U,
    SERVICE_CONTROL_NETBINDDISABLE        = 0x0000000aU,
    SERVICE_CONTROL_DEVICEEVENT           = 0x0000000bU,
    SERVICE_CONTROL_HARDWAREPROFILECHANGE = 0x0000000cU,
    SERVICE_CONTROL_POWEREVENT            = 0x0000000dU,
    SERVICE_CONTROL_SESSIONCHANGE         = 0x0000000eU,
    SERVICE_CONTROL_PRESHUTDOWN           = 0x0000000fU,
    SERVICE_CONTROL_TIMECHANGE            = 0x00000010U,
    SERVICE_CONTROL_TRIGGEREVENT          = 0x00000020U,
    SERVICE_CONTROL_LOWRESOURCES          = 0x00000060U,
    SERVICE_CONTROL_SYSTEMLOWRESOURCES    = 0x00000061U,
}

enum : uint
{
    SERVICE_ACCEPT_STOP                  = 0x00000001U,
    SERVICE_ACCEPT_PAUSE_CONTINUE        = 0x00000002U,
    SERVICE_ACCEPT_SHUTDOWN              = 0x00000004U,
    SERVICE_ACCEPT_PARAMCHANGE           = 0x00000008U,
    SERVICE_ACCEPT_NETBINDCHANGE         = 0x00000010U,
    SERVICE_ACCEPT_HARDWAREPROFILECHANGE = 0x00000020U,
    SERVICE_ACCEPT_POWEREVENT            = 0x00000040U,
    SERVICE_ACCEPT_SESSIONCHANGE         = 0x00000080U,
    SERVICE_ACCEPT_PRESHUTDOWN           = 0x00000100U,
    SERVICE_ACCEPT_TIMECHANGE            = 0x00000200U,
    SERVICE_ACCEPT_TRIGGEREVENT          = 0x00000400U,
    SERVICE_ACCEPT_USER_LOGOFF           = 0x00000800U,
    SERVICE_ACCEPT_LOWRESOURCES          = 0x00002000U,
    SERVICE_ACCEPT_SYSTEMLOWRESOURCES    = 0x00004000U,
}

enum : uint
{
    SC_MANAGER_CONNECT           = 0x00000001U,
    SC_MANAGER_CREATE_SERVICE    = 0x00000002U,
    SC_MANAGER_ENUMERATE_SERVICE = 0x00000004U,
}

enum : uint
{
    SC_MANAGER_LOCK              = 0x00000008U,
    SC_MANAGER_QUERY_LOCK_STATUS = 0x00000010U,
}

enum uint SC_MANAGER_MODIFY_BOOT_CONFIG = 0x00000020U;
enum uint SERVICE_QUERY_CONFIG = 0x00000001U;
enum uint SERVICE_CHANGE_CONFIG = 0x00000002U;
enum uint SERVICE_QUERY_STATUS = 0x00000004U;
enum uint SERVICE_ENUMERATE_DEPENDENTS = 0x00000008U;

enum : uint
{
    SERVICE_START          = 0x00000010U,
    SERVICE_STOP           = 0x00000020U,
    SERVICE_PAUSE_CONTINUE = 0x00000040U,
}

enum : uint
{
    SERVICE_INTERROGATE          = 0x00000080U,
    SERVICE_USER_DEFINED_CONTROL = 0x00000100U,
}

enum : uint
{
    SERVICE_NOTIFY_STATUS_CHANGE_1 = 0x00000001U,
    SERVICE_NOTIFY_STATUS_CHANGE_2 = 0x00000002U,
    SERVICE_NOTIFY_STATUS_CHANGE   = 0x00000002U,
}

enum : uint
{
    SERVICE_STOP_REASON_FLAG_MIN                        = 0x00000000U,
    SERVICE_STOP_REASON_FLAG_UNPLANNED                  = 0x10000000U,
    SERVICE_STOP_REASON_FLAG_CUSTOM                     = 0x20000000U,
    SERVICE_STOP_REASON_FLAG_PLANNED                    = 0x40000000U,
    SERVICE_STOP_REASON_FLAG_MAX                        = 0x80000000U,
    SERVICE_STOP_REASON_MAJOR_MIN                       = 0x00000000U,
    SERVICE_STOP_REASON_MAJOR_OTHER                     = 0x00010000U,
    SERVICE_STOP_REASON_MAJOR_HARDWARE                  = 0x00020000U,
    SERVICE_STOP_REASON_MAJOR_OPERATINGSYSTEM           = 0x00030000U,
    SERVICE_STOP_REASON_MAJOR_SOFTWARE                  = 0x00040000U,
    SERVICE_STOP_REASON_MAJOR_APPLICATION               = 0x00050000U,
    SERVICE_STOP_REASON_MAJOR_NONE                      = 0x00060000U,
    SERVICE_STOP_REASON_MAJOR_MAX                       = 0x00070000U,
    SERVICE_STOP_REASON_MAJOR_MIN_CUSTOM                = 0x00400000U,
    SERVICE_STOP_REASON_MAJOR_MAX_CUSTOM                = 0x00ff0000U,
    SERVICE_STOP_REASON_MINOR_MIN                       = 0x00000000U,
    SERVICE_STOP_REASON_MINOR_OTHER                     = 0x00000001U,
    SERVICE_STOP_REASON_MINOR_MAINTENANCE               = 0x00000002U,
    SERVICE_STOP_REASON_MINOR_INSTALLATION              = 0x00000003U,
    SERVICE_STOP_REASON_MINOR_UPGRADE                   = 0x00000004U,
    SERVICE_STOP_REASON_MINOR_RECONFIG                  = 0x00000005U,
    SERVICE_STOP_REASON_MINOR_HUNG                      = 0x00000006U,
    SERVICE_STOP_REASON_MINOR_UNSTABLE                  = 0x00000007U,
    SERVICE_STOP_REASON_MINOR_DISK                      = 0x00000008U,
    SERVICE_STOP_REASON_MINOR_NETWORKCARD               = 0x00000009U,
    SERVICE_STOP_REASON_MINOR_ENVIRONMENT               = 0x0000000aU,
    SERVICE_STOP_REASON_MINOR_HARDWARE_DRIVER           = 0x0000000bU,
    SERVICE_STOP_REASON_MINOR_OTHERDRIVER               = 0x0000000cU,
    SERVICE_STOP_REASON_MINOR_SERVICEPACK               = 0x0000000dU,
    SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE           = 0x0000000eU,
    SERVICE_STOP_REASON_MINOR_SECURITYFIX               = 0x0000000fU,
    SERVICE_STOP_REASON_MINOR_SECURITY                  = 0x00000010U,
    SERVICE_STOP_REASON_MINOR_NETWORK_CONNECTIVITY      = 0x00000011U,
    SERVICE_STOP_REASON_MINOR_WMI                       = 0x00000012U,
    SERVICE_STOP_REASON_MINOR_SERVICEPACK_UNINSTALL     = 0x00000013U,
    SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE_UNINSTALL = 0x00000014U,
    SERVICE_STOP_REASON_MINOR_SECURITYFIX_UNINSTALL     = 0x00000015U,
    SERVICE_STOP_REASON_MINOR_MMC                       = 0x00000016U,
    SERVICE_STOP_REASON_MINOR_NONE                      = 0x00000017U,
    SERVICE_STOP_REASON_MINOR_MEMOTYLIMIT               = 0x00000018U,
    SERVICE_STOP_REASON_MINOR_MAX                       = 0x00000019U,
    SERVICE_STOP_REASON_MINOR_MIN_CUSTOM                = 0x00000100U,
    SERVICE_STOP_REASON_MINOR_MAX_CUSTOM                = 0x0000ffffU,
}

enum uint SERVICE_CONTROL_STATUS_REASON_INFO = 0x00000001U;

enum : uint
{
    SERVICE_SID_TYPE_NONE         = 0x00000000U,
    SERVICE_SID_TYPE_UNRESTRICTED = 0x00000001U,
}

enum : uint
{
    SERVICE_TRIGGER_TYPE_CUSTOM_SYSTEM_STATE_CHANGE = 0x00000007U,
    SERVICE_TRIGGER_TYPE_AGGREGATE                  = 0x0000001eU,
}

enum : uint
{
    SERVICE_START_REASON_DEMAND             = 0x00000001U,
    SERVICE_START_REASON_AUTO               = 0x00000002U,
    SERVICE_START_REASON_TRIGGER            = 0x00000004U,
    SERVICE_START_REASON_RESTART_ON_FAILURE = 0x00000008U,
    SERVICE_START_REASON_DELAYEDAUTO        = 0x00000010U,
}

enum uint SERVICE_DYNAMIC_INFORMATION_LEVEL_START_REASON = 0x00000001U;

enum : uint
{
    SERVICE_LAUNCH_PROTECTED_NONE              = 0x00000000U,
    SERVICE_LAUNCH_PROTECTED_WINDOWS           = 0x00000001U,
    SERVICE_LAUNCH_PROTECTED_WINDOWS_LIGHT     = 0x00000002U,
    SERVICE_LAUNCH_PROTECTED_ANTIMALWARE_LIGHT = 0x00000003U,
}

enum GUID NETWORK_MANAGER_FIRST_IP_ADDRESS_ARRIVAL_GUID = GUID("4f27f2de-14e2-430b-a549-7cd48cbc8245");
enum GUID NETWORK_MANAGER_LAST_IP_ADDRESS_REMOVAL_GUID = GUID("cc4ba62a-162e-4648-847a-b6bdf993e335");

enum : GUID
{
    DOMAIN_JOIN_GUID  = GUID("1ce20aba-9851-4421-9430-1ddeb766e809"),
    DOMAIN_LEAVE_GUID = GUID("ddaf516e-58c2-4866-9574-c3b615d42ea1"),
}

enum : GUID
{
    FIREWALL_PORT_OPEN_GUID  = GUID("b7569e07-8421-4ee0-ad10-86915afdad09"),
    FIREWALL_PORT_CLOSE_GUID = GUID("a144ed38-8e12-4de4-9d96-e64740b1a524"),
}

enum GUID MACHINE_POLICY_PRESENT_GUID = GUID("659fcae6-5bdb-4da9-b1ff-ca2a178d46e0");
enum GUID USER_POLICY_PRESENT_GUID = GUID("54fb46c8-f089-464c-b1fd-59d1b62c3b50");
enum GUID RPC_INTERFACE_EVENT_GUID = GUID("bc90d167-9470-4139-a9ba-be0bbbf5b74d");
enum GUID NAMED_PIPE_EVENT_GUID = GUID("1f81d131-3fac-4537-9e0c-7e7b0c2f4b55");
enum GUID CUSTOM_SYSTEM_STATE_CHANGE_EVENT_GUID = GUID("2d7a2816-0c5e-45fc-9ce7-570e5ecde9c9");
enum const(wchar)* SERVICE_TRIGGER_STARTED_ARGUMENT = "TriggerStarted";
enum const(wchar)* SC_AGGREGATE_STORAGE_KEY = "System\\CurrentControlSet\\Control\\ServiceAggregatedEvents";

// Callbacks

alias SERVICE_MAIN_FUNCTIONW = void function(uint dwNumServicesArgs, PWSTR* lpServiceArgVectors);
alias SERVICE_MAIN_FUNCTIONA = void function(uint dwNumServicesArgs, byte** lpServiceArgVectors);
alias LPSERVICE_MAIN_FUNCTIONW = void function(uint dwNumServicesArgs, PWSTR* lpServiceArgVectors);
alias LPSERVICE_MAIN_FUNCTIONA = void function(uint dwNumServicesArgs, PSTR* lpServiceArgVectors);
alias HANDLER_FUNCTION = void function(uint dwControl);
alias HANDLER_FUNCTION_EX = uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias LPHANDLER_FUNCTION = void function(uint dwControl);
alias LPHANDLER_FUNCTION_EX = uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias PFN_SC_NOTIFY_CALLBACK = void function(void* pParameter);
alias PSC_NOTIFICATION_CALLBACK = void function(uint dwNotify, void* pCallbackContext);

// Structs


@RAIIFree!CloseServiceHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SC_HANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SERVICE_STATUS_HANDLE
{
    void* Value;
}

struct PSC_NOTIFICATION_REGISTRATION
{
    ptrdiff_t Value;
}

struct SERVICE_TRIGGER_CUSTOM_STATE_ID
{
    uint[2] Data;
}

struct SERVICE_CUSTOM_SYSTEM_STATE_CHANGE_DATA_ITEM
{
    union u
    {
        SERVICE_TRIGGER_CUSTOM_STATE_ID CustomStateId;
        struct s
        {
            uint     DataOffset;
            ubyte[1] Data; // Flexible array
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_descriptiona
struct SERVICE_DESCRIPTIONA
{
    PSTR lpDescription;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_descriptionw
struct SERVICE_DESCRIPTIONW
{
    PWSTR lpDescription;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-sc_action
struct SC_ACTION
{
    SC_ACTION_TYPE Type;
    uint           Delay;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_failure_actionsa
struct SERVICE_FAILURE_ACTIONSA
{
    uint       dwResetPeriod;
    PSTR       lpRebootMsg;
    PSTR       lpCommand;
    uint       cActions;
    SC_ACTION* lpsaActions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_failure_actionsw
struct SERVICE_FAILURE_ACTIONSW
{
    uint       dwResetPeriod;
    PWSTR      lpRebootMsg;
    PWSTR      lpCommand;
    uint       cActions;
    SC_ACTION* lpsaActions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_delayed_auto_start_info
struct SERVICE_DELAYED_AUTO_START_INFO
{
    BOOL fDelayedAutostart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_failure_actions_flag
struct SERVICE_FAILURE_ACTIONS_FLAG
{
    BOOL fFailureActionsOnNonCrashFailures;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_sid_info
struct SERVICE_SID_INFO
{
    uint dwServiceSidType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_required_privileges_infoa
struct SERVICE_REQUIRED_PRIVILEGES_INFOA
{
    PSTR pmszRequiredPrivileges;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_required_privileges_infow
struct SERVICE_REQUIRED_PRIVILEGES_INFOW
{
    PWSTR pmszRequiredPrivileges;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_preshutdown_info
struct SERVICE_PRESHUTDOWN_INFO
{
    uint dwPreshutdownTimeout;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_trigger_specific_data_item
struct SERVICE_TRIGGER_SPECIFIC_DATA_ITEM
{
    SERVICE_TRIGGER_SPECIFIC_DATA_ITEM_DATA_TYPE dwDataType;
    uint   cbData;
    ubyte* pData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_trigger
struct SERVICE_TRIGGER
{
    SERVICE_TRIGGER_TYPE dwTriggerType;
    SERVICE_TRIGGER_ACTION dwAction;
    GUID*                pTriggerSubtype;
    uint                 cDataItems;
    SERVICE_TRIGGER_SPECIFIC_DATA_ITEM* pDataItems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_trigger_info
struct SERVICE_TRIGGER_INFO
{
    uint             cTriggers;
    SERVICE_TRIGGER* pTriggers;
    ubyte*           pReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_preferred_node_info
struct SERVICE_PREFERRED_NODE_INFO
{
    ushort  usPreferredNode;
    BOOLEAN fDelete;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_timechange_info
struct SERVICE_TIMECHANGE_INFO
{
    long liNewTime;
    long liOldTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_launch_protected_info
struct SERVICE_LAUNCH_PROTECTED_INFO
{
    uint dwLaunchProtected;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_status
struct SERVICE_STATUS
{
    ENUM_SERVICE_TYPE dwServiceType;
    SERVICE_STATUS_CURRENT_STATE dwCurrentState;
    uint              dwControlsAccepted;
    uint              dwWin32ExitCode;
    uint              dwServiceSpecificExitCode;
    uint              dwCheckPoint;
    uint              dwWaitHint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_status_process
struct SERVICE_STATUS_PROCESS
{
    ENUM_SERVICE_TYPE dwServiceType;
    SERVICE_STATUS_CURRENT_STATE dwCurrentState;
    uint              dwControlsAccepted;
    uint              dwWin32ExitCode;
    uint              dwServiceSpecificExitCode;
    uint              dwCheckPoint;
    uint              dwWaitHint;
    uint              dwProcessId;
    SERVICE_RUNS_IN_PROCESS dwServiceFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_statusa
struct ENUM_SERVICE_STATUSA
{
    PSTR           lpServiceName;
    PSTR           lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_statusw
struct ENUM_SERVICE_STATUSW
{
    PWSTR          lpServiceName;
    PWSTR          lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_status_processa
struct ENUM_SERVICE_STATUS_PROCESSA
{
    PSTR lpServiceName;
    PSTR lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_status_processw
struct ENUM_SERVICE_STATUS_PROCESSW
{
    PWSTR lpServiceName;
    PWSTR lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_lock_statusa
struct QUERY_SERVICE_LOCK_STATUSA
{
    uint fIsLocked;
    PSTR lpLockOwner;
    uint dwLockDuration;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_lock_statusw
struct QUERY_SERVICE_LOCK_STATUSW
{
    uint  fIsLocked;
    PWSTR lpLockOwner;
    uint  dwLockDuration;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_configa
struct QUERY_SERVICE_CONFIGA
{
    ENUM_SERVICE_TYPE  dwServiceType;
    SERVICE_START_TYPE dwStartType;
    SERVICE_ERROR      dwErrorControl;
    PSTR               lpBinaryPathName;
    PSTR               lpLoadOrderGroup;
    uint               dwTagId;
    PSTR               lpDependencies;
    PSTR               lpServiceStartName;
    PSTR               lpDisplayName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_configw
struct QUERY_SERVICE_CONFIGW
{
    ENUM_SERVICE_TYPE  dwServiceType;
    SERVICE_START_TYPE dwStartType;
    SERVICE_ERROR      dwErrorControl;
    PWSTR              lpBinaryPathName;
    PWSTR              lpLoadOrderGroup;
    uint               dwTagId;
    PWSTR              lpDependencies;
    PWSTR              lpServiceStartName;
    PWSTR              lpDisplayName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_table_entrya
struct SERVICE_TABLE_ENTRYA
{
    PSTR lpServiceName;
    LPSERVICE_MAIN_FUNCTIONA lpServiceProc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_table_entryw
struct SERVICE_TABLE_ENTRYW
{
    PWSTR lpServiceName;
    LPSERVICE_MAIN_FUNCTIONW lpServiceProc;
}

struct SERVICE_NOTIFY_1
{
    uint  dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint  dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_notify_2a
struct SERVICE_NOTIFY_2A
{
    uint  dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint  dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint  dwNotificationTriggered;
    PSTR  pszServiceNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_notify_2w
struct SERVICE_NOTIFY_2W
{
    uint  dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint  dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint  dwNotificationTriggered;
    PWSTR pszServiceNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_control_status_reason_paramsa
struct SERVICE_CONTROL_STATUS_REASON_PARAMSA
{
    uint dwReason;
    PSTR pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_control_status_reason_paramsw
struct SERVICE_CONTROL_STATUS_REASON_PARAMSW
{
    uint  dwReason;
    PWSTR pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_START_REASON
{
    uint dwReason;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetServiceBits(SERVICE_STATUS_HANDLE hServiceStatus, uint dwServiceBits, BOOL bSetBitsOn, 
                    BOOL bUpdateImmediately);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfigA(SC_HANDLE hService, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                          SERVICE_ERROR dwErrorControl, const(PSTR) lpBinaryPathName, const(PSTR) lpLoadOrderGroup, 
                          uint* lpdwTagId, const(PSTR) lpDependencies, const(PSTR) lpServiceStartName, 
                          const(PSTR) lpPassword, const(PSTR) lpDisplayName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfigW(SC_HANDLE hService, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                          SERVICE_ERROR dwErrorControl, const(PWSTR) lpBinaryPathName, const(PWSTR) lpLoadOrderGroup, 
                          uint* lpdwTagId, const(PWSTR) lpDependencies, const(PWSTR) lpServiceStartName, 
                          const(PWSTR) lpPassword, const(PWSTR) lpDisplayName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfig2A(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, void* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfig2W(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, void* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CloseServiceHandle(SC_HANDLE hSCObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ControlService(SC_HANDLE hService, uint dwControl, SERVICE_STATUS* lpServiceStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE CreateServiceA(SC_HANDLE hSCManager, const(PSTR) lpServiceName, const(PSTR) lpDisplayName, 
                         uint dwDesiredAccess, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                         SERVICE_ERROR dwErrorControl, const(PSTR) lpBinaryPathName, const(PSTR) lpLoadOrderGroup, 
                         uint* lpdwTagId, const(PSTR) lpDependencies, const(PSTR) lpServiceStartName, 
                         const(PSTR) lpPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE CreateServiceW(SC_HANDLE hSCManager, const(PWSTR) lpServiceName, const(PWSTR) lpDisplayName, 
                         uint dwDesiredAccess, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                         SERVICE_ERROR dwErrorControl, const(PWSTR) lpBinaryPathName, const(PWSTR) lpLoadOrderGroup, 
                         uint* lpdwTagId, const(PWSTR) lpDependencies, const(PWSTR) lpServiceStartName, 
                         const(PWSTR) lpPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL DeleteService(SC_HANDLE hService);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumDependentServicesA(SC_HANDLE hService, ENUM_SERVICE_STATE dwServiceState, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ENUM_SERVICE_STATUSA* lpServices, 
                            uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumDependentServicesW(SC_HANDLE hService, ENUM_SERVICE_STATE dwServiceState, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ENUM_SERVICE_STATUSW* lpServices, 
                            uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusA(SC_HANDLE hSCManager, ENUM_SERVICE_TYPE dwServiceType, ENUM_SERVICE_STATE dwServiceState, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ENUM_SERVICE_STATUSA* lpServices, 
                         uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusW(SC_HANDLE hSCManager, ENUM_SERVICE_TYPE dwServiceType, ENUM_SERVICE_STATE dwServiceState, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ENUM_SERVICE_STATUSW* lpServices, 
                         uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusExA(SC_HANDLE hSCManager, SC_ENUM_TYPE InfoLevel, ENUM_SERVICE_TYPE dwServiceType, 
                           ENUM_SERVICE_STATE dwServiceState, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* lpServices, 
                           uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle, 
                           const(PSTR) pszGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusExW(SC_HANDLE hSCManager, SC_ENUM_TYPE InfoLevel, ENUM_SERVICE_TYPE dwServiceType, 
                           ENUM_SERVICE_STATE dwServiceState, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* lpServices, 
                           uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle, 
                           const(PWSTR) pszGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceKeyNameA(SC_HANDLE hSCManager, const(PSTR) lpDisplayName, PSTR lpServiceName, uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceKeyNameW(SC_HANDLE hSCManager, const(PWSTR) lpDisplayName, PWSTR lpServiceName, uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceDisplayNameA(SC_HANDLE hSCManager, const(PSTR) lpServiceName, PSTR lpDisplayName, uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceDisplayNameW(SC_HANDLE hSCManager, const(PWSTR) lpServiceName, PWSTR lpDisplayName, 
                            uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void* LockServiceDatabase(SC_HANDLE hSCManager);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL NotifyBootConfigStatus(BOOL BootAcceptable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenSCManagerA(const(PSTR) lpMachineName, const(PSTR) lpDatabaseName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenSCManagerW(const(PWSTR) lpMachineName, const(PWSTR) lpDatabaseName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenServiceA(SC_HANDLE hSCManager, const(PSTR) lpServiceName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenServiceW(SC_HANDLE hSCManager, const(PWSTR) lpServiceName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfigA(SC_HANDLE hService, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_CONFIGA* lpServiceConfig, 
                         uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfigW(SC_HANDLE hService, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_CONFIGW* lpServiceConfig, 
                         uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfig2A(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpBuffer, 
                          uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfig2W(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpBuffer, 
                          uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceLockStatusA(SC_HANDLE hSCManager, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_LOCK_STATUSA* lpLockStatus, 
                             uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceLockStatusW(SC_HANDLE hSCManager, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_LOCK_STATUSW* lpLockStatus, 
                             uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceObjectSecurity(SC_HANDLE hService, uint dwSecurityInformation, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR lpSecurityDescriptor, 
                                uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceStatus(SC_HANDLE hService, SERVICE_STATUS* lpServiceStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceStatusEx(SC_HANDLE hService, SC_STATUS_TYPE InfoLevel, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpBuffer, 
                          uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerA(const(PSTR) lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerW(const(PWSTR) lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerExA(const(PSTR) lpServiceName, LPHANDLER_FUNCTION_EX lpHandlerProc, 
                                                    void* lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerExW(const(PWSTR) lpServiceName, 
                                                    LPHANDLER_FUNCTION_EX lpHandlerProc, void* lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetServiceObjectSecurity(SC_HANDLE hService, OBJECT_SECURITY_INFORMATION dwSecurityInformation, 
                              PSECURITY_DESCRIPTOR lpSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetServiceStatus(SERVICE_STATUS_HANDLE hServiceStatus, SERVICE_STATUS* lpServiceStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceCtrlDispatcherA(const(SERVICE_TABLE_ENTRYA)* lpServiceStartTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceCtrlDispatcherW(const(SERVICE_TABLE_ENTRYW)* lpServiceStartTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceA(SC_HANDLE hService, uint dwNumServiceArgs, const(PSTR)* lpServiceArgVectors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceW(SC_HANDLE hService, uint dwNumServiceArgs, const(PWSTR)* lpServiceArgVectors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL UnlockServiceDatabase(void* ScLock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint NotifyServiceStatusChangeA(SC_HANDLE hService, SERVICE_NOTIFY dwNotifyMask, 
                                /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/SERVICE_NOTIFY_2A* pNotifyBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint NotifyServiceStatusChangeW(SC_HANDLE hService, SERVICE_NOTIFY dwNotifyMask, 
                                /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/SERVICE_NOTIFY_2W* pNotifyBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL ControlServiceExA(SC_HANDLE hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL ControlServiceExW(SC_HANDLE hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceDynamicInformation(SERVICE_STATUS_HANDLE hServiceStatus, uint dwInfoLevel, void** ppDynamicInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Services/subscribeservicechangenotifications
@DllImport("SecHost.dll")
uint SubscribeServiceChangeNotifications(SC_HANDLE hService, SC_EVENT_TYPE eEventType, 
                                         PSC_NOTIFICATION_CALLBACK pCallback, void* pCallbackContext, 
                                         PSC_NOTIFICATION_REGISTRATION* pSubscription);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Services/unsubscribeservicechangenotifications
@DllImport("SecHost.dll")
void UnsubscribeServiceChangeNotifications(PSC_NOTIFICATION_REGISTRATION pSubscription);

@DllImport("ADVAPI32.dll")
uint WaitServiceState(SC_HANDLE hService, uint dwNotify, uint dwTimeout, HANDLE hCancelEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("api-ms-win-service-core-l1-1-3.dll")
uint GetServiceRegistryStateKey(SERVICE_STATUS_HANDLE ServiceStatusHandle, SERVICE_REGISTRY_STATE_TYPE StateType, 
                                uint AccessMask, HKEY* ServiceStateKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("api-ms-win-service-core-l1-1-4.dll")
uint GetServiceDirectory(SERVICE_STATUS_HANDLE hServiceStatus, SERVICE_DIRECTORY_TYPE eDirectoryType, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR lpPathBuffer, 
                         uint cchPathBufferLength, uint* lpcchRequiredBufferLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getsharedserviceregistrystatekey
@DllImport("api-ms-win-service-core-l1-1-5.dll")
uint GetSharedServiceRegistryStateKey(SC_HANDLE ServiceHandle, SERVICE_SHARED_REGISTRY_STATE_TYPE StateType, 
                                      uint AccessMask, HKEY* ServiceStateKey);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getsharedservicedirectory
@DllImport("api-ms-win-service-core-l1-1-5.dll")
uint GetSharedServiceDirectory(SC_HANDLE ServiceHandle, SERVICE_SHARED_DIRECTORY_TYPE DirectoryType, 
                               /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR PathBuffer, 
                               uint PathBufferLength, uint* RequiredBufferLength);


