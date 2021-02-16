module windows.operationrecorder;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Structs


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

// Functions

@DllImport("ADVAPI32")
BOOL OperationStart(OPERATION_START_PARAMETERS* OperationStartParams);

@DllImport("ADVAPI32")
BOOL OperationEnd(OPERATION_END_PARAMETERS* OperationEndParams);


