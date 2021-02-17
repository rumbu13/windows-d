// Written in the D programming language.

module windows.hardwarecounterprofiling;

public import windows.core;
public import windows.systemservices : HANDLE;

extern(Windows):


// Enums


///Defines the types of hardware counters being profiled.
alias HARDWARE_COUNTER_TYPE = int;
enum : int
{
    ///Hardware performance monitoring counters.
    PMCCounter             = 0x00000000,
    ///The maximum enumeration value for this enumeration.
    MaxHardwareCounterType = 0x00000001,
}

// Structs


///Contains the hardware counter value.
struct HARDWARE_COUNTER_DATA
{
    ///The type of hardware counter data collected. For possible values, see the HARDWARE_COUNTER_TYPE enumeration.
    HARDWARE_COUNTER_TYPE Type;
    ///Reserved. Initialize to zero.
    uint  Reserved;
    ///The counter index. Each hardware counter in a processor's performance monitoring unit (PMU) is identified by an
    ///index.
    ulong Value;
}

///Contains the thread profiling and hardware counter data that you requested.
struct PERFORMANCE_DATA
{
    ///The size of this structure.
    ushort Size;
    ///The version of this structure. Must be set to PERFORMANCE_DATA_VERSION.
    ubyte  Version;
    ///The number of array elements in the <b>HwCounters</b> array that contain hardware counter data. A value of 3
    ///means that the array contains data for three hardware counters, not that elements 0 through 2 contain counter
    ///data.
    ubyte  HwCountersCount;
    ///The number of context switches that occurred from the time profiling was enabled.
    uint   ContextSwitchCount;
    ///A bitmask that identifies the reasons for the context switches that occurred since the last time the data was
    ///read. For possible values, see the <b>KWAIT_REASON</b> enumeration (the enumeration is included in the Wdm.h file
    ///in the WDK).
    ulong  WaitReasonBitMap;
    ///The cycle time of the thread (excludes the time spent interrupted) from the time profiling was enabled.
    ulong  CycleTime;
    ///The number of times that the read operation read the data to ensure a consistent snapshot of the data.
    uint   RetryCount;
    ///Reserved. Set to zero.
    uint   Reserved;
    ///An array of HARDWARE_COUNTER_DATA structures that contain the counter values. The elements of the array that
    ///contain counter data relate directly to the bits set in the <i>HardwareCounters</i> bitmask that you specified
    ///when you called the EnableThreadProfiling function. For example, if you set bit 3 in the <i>HardwareCounters</i>
    ///bitmask, HwCounters[3] will contain the counter data for that counter.
    HARDWARE_COUNTER_DATA[16] HwCounters;
}

// Functions

///Enables thread profiling on the specified thread.
///Params:
///    ThreadHandle = The handle to the thread on which you want to enable profiling. This must be the current thread.
///    Flags = To receive thread profiling data such as context switch count, set this parameter to
///            THREAD_PROFILING_FLAG_DISPATCH; otherwise, set to 0.
///    HardwareCounters = To receive hardware performance counter data, set this parameter to a bitmask that identifies the hardware
///                       counters to collect. You can specify up to 16 performance counters. Each bit relates directly to the zero-based
///                       hardware counter index for the hardware performance counters that you configured. Set to zero if you are not
///                       collecting hardware counter data. If you set a bit for a hardware counter that has not been configured, the
///                       counter value that is read for that counter is zero.
///    PerformanceDataHandle = An opaque handle that you use when calling the ReadThreadProfilingData and DisableThreadProfiling functions.
///Returns:
///    Returns ERROR_SUCCESS if the call is successful; otherwise, a system error code (see Winerror.h).
///    
@DllImport("KERNEL32")
uint EnableThreadProfiling(HANDLE ThreadHandle, uint Flags, ulong HardwareCounters, HANDLE* PerformanceDataHandle);

///Disables thread profiling.
///Params:
///    PerformanceDataHandle = The handle that the EnableThreadProfiling function returned.
///Returns:
///    Returns ERROR_SUCCESS if the call is successful; otherwise, a system error code (see Winerror.h).
///    
@DllImport("KERNEL32")
uint DisableThreadProfiling(HANDLE PerformanceDataHandle);

///Determines whether thread profiling is enabled for the specified thread.
///Params:
///    ThreadHandle = The handle to the thread of interest.
///    Enabled = Is <b>TRUE</b> if thread profiling is enabled for the specified thread; otherwise, <b>FALSE</b>.
///Returns:
///    Returns ERROR_SUCCESS if the call is successful; otherwise, a system error code (see Winerror.h).
///    
@DllImport("KERNEL32")
uint QueryThreadProfiling(HANDLE ThreadHandle, ubyte* Enabled);

///Reads the specified profiling data associated with the thread.
///Params:
///    PerformanceDataHandle = The handle that the EnableThreadProfiling function returned.
///    Flags = One or more of the following flags that specify the counter data to read. The flags must have been set when you
///            called the EnableThreadProfiling function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="READ_THREAD_PROFILING_FLAG_DISPATCHING"></a><a
///            id="read_thread_profiling_flag_dispatching"></a><dl> <dt><b>READ_THREAD_PROFILING_FLAG_DISPATCHING</b></dt>
///            <dt>0x00000001</dt> </dl> </td> <td width="60%"> Get the thread profiling data. </td> </tr> <tr> <td
///            width="40%"><a id="READ_THREAD_PROFILING_FLAG_HARDWARE_COUNTERS"></a><a
///            id="read_thread_profiling_flag_hardware_counters"></a><dl>
///            <dt><b>READ_THREAD_PROFILING_FLAG_HARDWARE_COUNTERS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Get
///            the hardware performance counters data. </td> </tr> </table>
///    PerformanceData = A PERFORMANCE_DATA structure that contains the thread profiling and hardware counter data.
///Returns:
///    Returns ERROR_SUCCESS if the call is successful; otherwise, a system error code (see Winerror.h).
///    
@DllImport("KERNEL32")
uint ReadThreadProfilingData(HANDLE PerformanceDataHandle, uint Flags, PERFORMANCE_DATA* PerformanceData);


