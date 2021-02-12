module windows.hardwarecounterprofiling;

public import windows.systemservices;

extern(Windows):

enum HARDWARE_COUNTER_TYPE
{
    PMCCounter = 0,
    MaxHardwareCounterType = 1,
}

struct HARDWARE_COUNTER_DATA
{
    HARDWARE_COUNTER_TYPE Type;
    uint Reserved;
    ulong Value;
}

struct PERFORMANCE_DATA
{
    ushort Size;
    ubyte Version;
    ubyte HwCountersCount;
    uint ContextSwitchCount;
    ulong WaitReasonBitMap;
    ulong CycleTime;
    uint RetryCount;
    uint Reserved;
    HARDWARE_COUNTER_DATA HwCounters;
}

@DllImport("KERNEL32.dll")
uint EnableThreadProfiling(HANDLE ThreadHandle, uint Flags, ulong HardwareCounters, HANDLE* PerformanceDataHandle);

@DllImport("KERNEL32.dll")
uint DisableThreadProfiling(HANDLE PerformanceDataHandle);

@DllImport("KERNEL32.dll")
uint QueryThreadProfiling(HANDLE ThreadHandle, ubyte* Enabled);

@DllImport("KERNEL32.dll")
uint ReadThreadProfilingData(HANDLE PerformanceDataHandle, uint Flags, PERFORMANCE_DATA* PerformanceData);

