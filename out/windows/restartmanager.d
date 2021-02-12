module windows.restartmanager;

public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

enum RM_APP_TYPE
{
    RmUnknownApp = 0,
    RmMainWindow = 1,
    RmOtherWindow = 2,
    RmService = 3,
    RmExplorer = 4,
    RmConsole = 5,
    RmCritical = 1000,
}

enum RM_SHUTDOWN_TYPE
{
    RmForceShutdown = 1,
    RmShutdownOnlyRegistered = 16,
}

enum RM_APP_STATUS
{
    RmStatusUnknown = 0,
    RmStatusRunning = 1,
    RmStatusStopped = 2,
    RmStatusStoppedOther = 4,
    RmStatusRestarted = 8,
    RmStatusErrorOnStop = 16,
    RmStatusErrorOnRestart = 32,
    RmStatusShutdownMasked = 64,
    RmStatusRestartMasked = 128,
}

enum RM_REBOOT_REASON
{
    RmRebootReasonNone = 0,
    RmRebootReasonPermissionDenied = 1,
    RmRebootReasonSessionMismatch = 2,
    RmRebootReasonCriticalProcess = 4,
    RmRebootReasonCriticalService = 8,
    RmRebootReasonDetectedSelf = 16,
}

struct RM_UNIQUE_PROCESS
{
    uint dwProcessId;
    FILETIME ProcessStartTime;
}

struct RM_PROCESS_INFO
{
    RM_UNIQUE_PROCESS Process;
    ushort strAppName;
    ushort strServiceShortName;
    RM_APP_TYPE ApplicationType;
    uint AppStatus;
    uint TSSessionId;
    BOOL bRestartable;
}

enum RM_FILTER_TRIGGER
{
    RmFilterTriggerInvalid = 0,
    RmFilterTriggerFile = 1,
    RmFilterTriggerProcess = 2,
    RmFilterTriggerService = 3,
}

enum RM_FILTER_ACTION
{
    RmInvalidFilterAction = 0,
    RmNoRestart = 1,
    RmNoShutdown = 2,
}

struct RM_FILTER_INFO
{
    RM_FILTER_ACTION FilterAction;
    RM_FILTER_TRIGGER FilterTrigger;
    uint cbNextOffset;
    _Anonymous_e__Union Anonymous;
}

alias RM_WRITE_STATUS_CALLBACK = extern(Windows) void function(uint nPercentComplete);
@DllImport("rstrtmgr.dll")
uint RmStartSession(uint* pSessionHandle, uint dwSessionFlags, char* strSessionKey);

@DllImport("RstrtMgr.dll")
uint RmJoinSession(uint* pSessionHandle, char* strSessionKey);

@DllImport("rstrtmgr.dll")
uint RmEndSession(uint dwSessionHandle);

@DllImport("rstrtmgr.dll")
uint RmRegisterResources(uint dwSessionHandle, uint nFiles, char* rgsFileNames, uint nApplications, char* rgApplications, uint nServices, char* rgsServiceNames);

@DllImport("rstrtmgr.dll")
uint RmGetList(uint dwSessionHandle, uint* pnProcInfoNeeded, uint* pnProcInfo, char* rgAffectedApps, uint* lpdwRebootReasons);

@DllImport("rstrtmgr.dll")
uint RmShutdown(uint dwSessionHandle, uint lActionFlags, RM_WRITE_STATUS_CALLBACK fnStatus);

@DllImport("rstrtmgr.dll")
uint RmRestart(uint dwSessionHandle, uint dwRestartFlags, RM_WRITE_STATUS_CALLBACK fnStatus);

@DllImport("RstrtMgr.dll")
uint RmCancelCurrentTask(uint dwSessionHandle);

@DllImport("RstrtMgr.dll")
uint RmAddFilter(uint dwSessionHandle, const(wchar)* strModuleName, RM_UNIQUE_PROCESS* pProcess, const(wchar)* strServiceShortName, RM_FILTER_ACTION FilterAction);

@DllImport("RstrtMgr.dll")
uint RmRemoveFilter(uint dwSessionHandle, const(wchar)* strModuleName, RM_UNIQUE_PROCESS* pProcess, const(wchar)* strServiceShortName);

@DllImport("RstrtMgr.dll")
uint RmGetFilterList(uint dwSessionHandle, char* pbFilterBuf, uint cbFilterBuf, uint* cbFilterBufNeeded);

