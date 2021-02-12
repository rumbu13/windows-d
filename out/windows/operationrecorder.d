module windows.operationrecorder;

public import windows.systemservices;

extern(Windows):

struct OPERATION_START_PARAMETERS
{
    uint Version;
    uint OperationId;
    uint Flags;
}

struct OPERATION_END_PARAMETERS
{
    uint Version;
    uint OperationId;
    uint Flags;
}

@DllImport("ADVAPI32.dll")
BOOL OperationStart(OPERATION_START_PARAMETERS* OperationStartParams);

@DllImport("ADVAPI32.dll")
BOOL OperationEnd(OPERATION_END_PARAMETERS* OperationEndParams);

