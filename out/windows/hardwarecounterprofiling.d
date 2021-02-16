module windows.hardwarecounterprofiling;

public import windows.core;
public import windows.systemservices : HANDLE;

extern(Windows):


// Enums


enum : int
{
    PMCCounter             = 0x00000000,
    MaxHardwareCounterType = 0x00000001,
}
alias HARDWARE_COUNTER_TYPE = int;

// Structs


struct HARDWARE_COUNTER_DATA
{
    HARDWARE_COUNTER_TYPE Type;
    uint  Reserved;
    ulong Value;
}

struct PERFORMANCE_DATA
{
    ushort Size;
    ubyte  Version;
    ubyte  HwCountersCount;
    uint   ContextSwitchCount;
    ulong  WaitReasonBitMap;
    ulong  CycleTime;
    uint   RetryCount;
    uint   Reserved;
    HARDWARE_COUNTER_DATA[16] HwCounters;
}

// Functions

@DllImport("KERNEL32")
uint EnableThreadProfiling(HANDLE ThreadHandle, uint Flags, ulong HardwareCounters, HANDLE* PerformanceDataHandle);

@DllImport("KERNEL32")
uint DisableThreadProfiling(HANDLE PerformanceDataHandle);

@DllImport("KERNEL32")
uint QueryThreadProfiling(HANDLE ThreadHandle, ubyte* Enabled);

@DllImport("KERNEL32")
uint ReadThreadProfilingData(HANDLE PerformanceDataHandle, uint Flags, PERFORMANCE_DATA* PerformanceData);


