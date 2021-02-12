module windows.serialcontroller;

public import windows.systemservices;

extern(Windows):

struct HCOMDB__
{
    int unused;
}

@DllImport("MSPORTS.dll")
int ComDBOpen(HCOMDB__** PHComDB);

@DllImport("MSPORTS.dll")
int ComDBClose(HCOMDB__* HComDB);

@DllImport("MSPORTS.dll")
int ComDBGetCurrentPortUsage(HCOMDB__* HComDB, char* Buffer, uint BufferSize, uint ReportType, uint* MaxPortsReported);

@DllImport("MSPORTS.dll")
int ComDBClaimNextFreePort(HCOMDB__* HComDB, uint* ComNumber);

@DllImport("MSPORTS.dll")
int ComDBClaimPort(HCOMDB__* HComDB, uint ComNumber, BOOL ForceClaim, int* Forced);

@DllImport("MSPORTS.dll")
int ComDBReleasePort(HCOMDB__* HComDB, uint ComNumber);

@DllImport("MSPORTS.dll")
int ComDBResizeDatabase(HCOMDB__* HComDB, uint NewSize);

