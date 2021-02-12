module windows.systemrestore;

public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

struct RESTOREPOINTINFOA
{
    uint dwEventType;
    uint dwRestorePtType;
    long llSequenceNumber;
    byte szDescription;
}

struct RESTOREPOINTINFOW
{
    uint dwEventType;
    uint dwRestorePtType;
    long llSequenceNumber;
    ushort szDescription;
}

struct _RESTOREPTINFOEX
{
    FILETIME ftCreation;
    uint dwEventType;
    uint dwRestorePtType;
    uint dwRPNum;
    ushort szDescription;
}

struct STATEMGRSTATUS
{
    uint nStatus;
    long llSequenceNumber;
}

@DllImport("sfc.dll")
BOOL SRSetRestorePointA(RESTOREPOINTINFOA* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);

@DllImport("sfc.dll")
BOOL SRSetRestorePointW(RESTOREPOINTINFOW* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);

