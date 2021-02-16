module windows.serialcontroller;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Structs


struct HCOMDB__
{
    int unused;
}

// Functions

@DllImport("MSPORTS")
int ComDBOpen(HCOMDB__** PHComDB);

@DllImport("MSPORTS")
int ComDBClose(HCOMDB__* HComDB);

@DllImport("MSPORTS")
int ComDBGetCurrentPortUsage(HCOMDB__* HComDB, char* Buffer, uint BufferSize, uint ReportType, 
                             uint* MaxPortsReported);

@DllImport("MSPORTS")
int ComDBClaimNextFreePort(HCOMDB__* HComDB, uint* ComNumber);

@DllImport("MSPORTS")
int ComDBClaimPort(HCOMDB__* HComDB, uint ComNumber, BOOL ForceClaim, int* Forced);

@DllImport("MSPORTS")
int ComDBReleasePort(HCOMDB__* HComDB, uint ComNumber);

@DllImport("MSPORTS")
int ComDBResizeDatabase(HCOMDB__* HComDB, uint NewSize);


