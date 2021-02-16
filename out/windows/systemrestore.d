module windows.systemrestore;

public import windows.core;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Structs


struct RESTOREPOINTINFOA
{
align (1):
    uint     dwEventType;
    uint     dwRestorePtType;
    long     llSequenceNumber;
    byte[64] szDescription;
}

struct RESTOREPOINTINFOW
{
align (1):
    uint        dwEventType;
    uint        dwRestorePtType;
    long        llSequenceNumber;
    ushort[256] szDescription;
}

struct _RESTOREPTINFOEX
{
align (1):
    FILETIME    ftCreation;
    uint        dwEventType;
    uint        dwRestorePtType;
    uint        dwRPNum;
    ushort[256] szDescription;
}

struct STATEMGRSTATUS
{
align (1):
    uint nStatus;
    long llSequenceNumber;
}

// Functions

@DllImport("sfc")
BOOL SRSetRestorePointA(RESTOREPOINTINFOA* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);

@DllImport("sfc")
BOOL SRSetRestorePointW(RESTOREPOINTINFOW* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);


