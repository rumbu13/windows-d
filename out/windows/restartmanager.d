module windows.restartmanager;

public import windows.core;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    RmUnknownApp  = 0x00000000,
    RmMainWindow  = 0x00000001,
    RmOtherWindow = 0x00000002,
    RmService     = 0x00000003,
    RmExplorer    = 0x00000004,
    RmConsole     = 0x00000005,
    RmCritical    = 0x000003e8,
}
alias RM_APP_TYPE = int;

enum : int
{
    RmForceShutdown          = 0x00000001,
    RmShutdownOnlyRegistered = 0x00000010,
}
alias RM_SHUTDOWN_TYPE = int;

enum : int
{
    RmStatusUnknown        = 0x00000000,
    RmStatusRunning        = 0x00000001,
    RmStatusStopped        = 0x00000002,
    RmStatusStoppedOther   = 0x00000004,
    RmStatusRestarted      = 0x00000008,
    RmStatusErrorOnStop    = 0x00000010,
    RmStatusErrorOnRestart = 0x00000020,
    RmStatusShutdownMasked = 0x00000040,
    RmStatusRestartMasked  = 0x00000080,
}
alias RM_APP_STATUS = int;

enum : int
{
    RmRebootReasonNone             = 0x00000000,
    RmRebootReasonPermissionDenied = 0x00000001,
    RmRebootReasonSessionMismatch  = 0x00000002,
    RmRebootReasonCriticalProcess  = 0x00000004,
    RmRebootReasonCriticalService  = 0x00000008,
    RmRebootReasonDetectedSelf     = 0x00000010,
}
alias RM_REBOOT_REASON = int;

enum : int
{
    RmFilterTriggerInvalid = 0x00000000,
    RmFilterTriggerFile    = 0x00000001,
    RmFilterTriggerProcess = 0x00000002,
    RmFilterTriggerService = 0x00000003,
}
alias RM_FILTER_TRIGGER = int;

enum : int
{
    RmInvalidFilterAction = 0x00000000,
    RmNoRestart           = 0x00000001,
    RmNoShutdown          = 0x00000002,
}
alias RM_FILTER_ACTION = int;

// Callbacks

alias RM_WRITE_STATUS_CALLBACK = void function(uint nPercentComplete);

// Structs


struct RM_UNIQUE_PROCESS
{
    uint     dwProcessId;
    FILETIME ProcessStartTime;
}

struct RM_PROCESS_INFO
{
    RM_UNIQUE_PROCESS Process;
    ushort[256]       strAppName;
    ushort[64]        strServiceShortName;
    RM_APP_TYPE       ApplicationType;
    uint              AppStatus;
    uint              TSSessionId;
    BOOL              bRestartable;
}

struct RM_FILTER_INFO
{
    RM_FILTER_ACTION  FilterAction;
    RM_FILTER_TRIGGER FilterTrigger;
    uint              cbNextOffset;
    union
    {
        const(wchar)*     strFilename;
        RM_UNIQUE_PROCESS Process;
        const(wchar)*     strServiceShortName;
    }
}

// Functions

@DllImport("rstrtmgr")
uint RmStartSession(uint* pSessionHandle, uint dwSessionFlags, char* strSessionKey);

@DllImport("RstrtMgr")
uint RmJoinSession(uint* pSessionHandle, char* strSessionKey);

@DllImport("rstrtmgr")
uint RmEndSession(uint dwSessionHandle);

@DllImport("rstrtmgr")
uint RmRegisterResources(uint dwSessionHandle, uint nFiles, char* rgsFileNames, uint nApplications, 
                         char* rgApplications, uint nServices, char* rgsServiceNames);

@DllImport("rstrtmgr")
uint RmGetList(uint dwSessionHandle, uint* pnProcInfoNeeded, uint* pnProcInfo, char* rgAffectedApps, 
               uint* lpdwRebootReasons);

@DllImport("rstrtmgr")
uint RmShutdown(uint dwSessionHandle, uint lActionFlags, RM_WRITE_STATUS_CALLBACK fnStatus);

@DllImport("rstrtmgr")
uint RmRestart(uint dwSessionHandle, uint dwRestartFlags, RM_WRITE_STATUS_CALLBACK fnStatus);

@DllImport("RstrtMgr")
uint RmCancelCurrentTask(uint dwSessionHandle);

@DllImport("RstrtMgr")
uint RmAddFilter(uint dwSessionHandle, const(wchar)* strModuleName, RM_UNIQUE_PROCESS* pProcess, 
                 const(wchar)* strServiceShortName, RM_FILTER_ACTION FilterAction);

@DllImport("RstrtMgr")
uint RmRemoveFilter(uint dwSessionHandle, const(wchar)* strModuleName, RM_UNIQUE_PROCESS* pProcess, 
                    const(wchar)* strServiceShortName);

@DllImport("RstrtMgr")
uint RmGetFilterList(uint dwSessionHandle, char* pbFilterBuf, uint cbFilterBuf, uint* cbFilterBufNeeded);


