// Written in the D programming language.

module windows.perf;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, PSTR, PWSTR;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///Indicates the types of information that you can request about a performance counter set by calling the
///PerfQueryCounterSetRegistrationInfo function.
enum PerfRegInfoType : int
{
    ///Gets the registration information for a counter set and all of the counters it contains as a
    ///PERF_COUNTERSET_REG_INFO block. The block includes a <b>PERF_COUNTERSET_REG_INFO</b> structure followed by one or
    ///more PERF_COUNTER_REG_INFO structures.
    PERF_REG_COUNTERSET_STRUCT       = 0x00000001,
    ///Gets the registration information for a performance counter as a PERF_COUNTER_REG_INFO structure. Use the
    ///<i>requestLangId</i> parameter of the PerfQueryCounterSetRegistrationInfo function to specify the counter
    ///identifier.
    PERF_REG_COUNTER_STRUCT          = 0x00000002,
    ///Gets a null-terminated UTF16-LE string that indicates the name of the counter set. Use the <i>requestLangId</i>
    ///parameter of the PerfQueryCounterSetRegistrationInfo function to specify the preferred locale of the result.
    PERF_REG_COUNTERSET_NAME_STRING  = 0x00000003,
    ///Gets a null-terminated UTF16-LE string that contains the help string for the counter set. Use the
    ///<i>requestLangId</i> parameter of the PerfQueryCounterSetRegistrationInfo function to specify the preferred
    ///locale of the result.
    PERF_REG_COUNTERSET_HELP_STRING  = 0x00000004,
    ///Gets the names of the performance counters in the counter set as a PERF_STRING_BUFFER_HEADER block. The block
    ///includes a <b>PERF_STRING_BUFFER_HEADER</b> structure, followed by one or more PERF_STRING_COUNTER_HEADER
    ///structures, followed by string data that indicates the counter names. Use the <i>requestLangId</i> parameter of
    ///the PerfQueryCounterSetRegistrationInfo function to specify the preferred locale of the result.
    PERF_REG_COUNTER_NAME_STRINGS    = 0x00000005,
    ///Gets the help strings for the performance counters in the counter set as a PERF_STRING_BUFFER_HEADER block. The
    ///block includes a <b>PERF_STRING_BUFFER_HEADER</b> structure, followed by one or more PERF_STRING_COUNTER_HEADER
    ///structures, followed by string data that contains the help strings. Use the <i>requestLangId</i> parameter of the
    ///PerfQueryCounterSetRegistrationInfo function to specify the preferred locale of the result.
    PERF_REG_COUNTER_HELP_STRINGS    = 0x00000006,
    ///Gets a null-terminated UTF-16LE string that indicates the name of the provider for the counter set.
    PERF_REG_PROVIDER_NAME           = 0x00000007,
    ///Gets the GUID of the provider for the counter set.
    PERF_REG_PROVIDER_GUID           = 0x00000008,
    ///Gets a null-terminated UTF-16LE string that contains the name of the counter set in English. This value is
    ///equivalent to setting the <i>requestCode</i> parameter to <b>PERF_REG_COUNTERSET_NAME_STRING</b> and the
    ///<i>requestLangId</i> parameter to 0 when you call the PerfQueryCounterSetRegistrationInfo function.
    PERF_REG_COUNTERSET_ENGLISH_NAME = 0x00000009,
    ///Gets the English names of the performance counters in the counter set as a PERF_STRING_BUFFER_HEADER block. The
    ///block includes a <b>PERF_STRING_BUFFER_HEADER</b> structure, followed by one or more PERF_STRING_COUNTER_HEADER
    ///structures, followed by string data that indicates the counter names. This value is equivalent to setting the
    ///<i>requestCode</i> parameter to <b>PERF_REG_COUNTER_NAME_STRINGS</b> and the <i>requestLangId</i> parameter to 0
    ///when you call the PerfQueryCounterSetRegistrationInfo function.
    PERF_REG_COUNTER_ENGLISH_NAMES   = 0x0000000a,
}

///Indicates the content type of a PERF_COUNTER_HEADER block that the PerfQueryCounterData function includes as part of
///the PERF_DATA_HEADER block that the function produces as output.
enum PerfCounterDataType : int
{
    ///An error occurred when the performance counter value was queried.
    PERF_ERROR_RETURN       = 0x00000000,
    ///The query returned a single counter from a single instance.
    PERF_SINGLE_COUNTER     = 0x00000001,
    ///The query returned multiple counters from a single instance.
    PERF_MULTIPLE_COUNTERS  = 0x00000002,
    ///The query returned a single counter from each of multiple instances.
    PERF_MULTIPLE_INSTANCES = 0x00000004,
    ///The query returned multiple counters from each of multiple instances.
    PERF_COUNTERSET         = 0x00000006,
}

// Callbacks

///Collects the performance data and returns it to the consumer. Implement and export this function if you are writing a
///performance DLL to provide performance data. The system calls this function whenever a consumer queries the registry
///for performance data. The **CollectPerformanceData** function is a placeholder for the application-defined function
///name.
///Params:
///    lpValueName = Type: **LPWSTR** Null-terminated string that contains the query string (for example, "Global" or "238") passed to
///                  the [RegQueryValueEx](/windows/desktop/api/winreg/nf-winreg-regqueryvalueexa) function. For a list of possible
///                  values for *lpValueName*, see [Using the Registry Functions to Consume Counter
///                  Data](/windows/desktop/PerfCtrs/using-the-registry-functions-to-consume-counter-data). > [!NOTE] > This parameter
///                  is annotated as optional (nullable), however a null value is not valid and can result in an error.
///    lppData = Type: **LPVOID \*** Consumer-allocated buffer that contains the performance data. On output (where *pData* refers
///              to the pointer pointed to by *lppData*), set *pData* to one byte past the end of your data. Note that the data
///              must conform to the [PERF_OBJECT_TYPE](ns-winperf-perf_object_type.md) structure. If this function fails, leave
///              the *pData* pointer value unchanged.
///    lpcbTotalBytes = Type: **LPDWORD** On input, specifies the size, in bytes, of the *pData* buffer (where *pData* refers to the
///                     pointer pointed to by *lppData*). On output, set *lpcbTotalBytes* to the size, in bytes, of the data written to
///                     the *pData* buffer. The size must be 8-byte aligned. If this function fails, set *lpcbTotalBytes* to zero.
///    lpNumObjectTypes = Type: **LPDWORD** Set *lpNumObjectTypes* to the number of object [types](ns-winperf-perf_object_type.md) (not
///                       [instances](ns-winperf-perf_instance_definition.md)) written to the *pData* buffer (where *pData* refers to the
///                       pointer pointed to by *lppData*). If this function fails, set *lpNumObjectTypes* to zero. > [!NOTE] > This
///                       parameter is annotated as both *In* and *Out*, however this parameter should not be used as input.
///Returns:
///    One of the following values: | Return code | Description | |-------------|-------------| | **ERROR_MORE_DATA** |
///    The size of the *pData* buffer (where *pData* refers to the pointer pointed to by *lppData*) as specified by
///    *lpcbTotalBytes* is not large enough to store the data. Leave *pData* unchanged, and set *lpcbTotalBytes* and
///    *lpNumObjectTypes* to zero. No attempt is made to indicate the required buffer size, because this can change
///    before the next call. | | **ERROR_SUCCESS** | Return this value in all cases other than the **ERROR_MORE_DATA**
///    case, even if no data is returned or an error occurs. To report errors other than insufficient buffer size, use
///    the Application Event Log. |
///    
alias PM_COLLECT_PROC = uint function(PWSTR lpValueName, void** lppData, uint* lpcbTotalBytes, 
                                      uint* lpNumObjectTypes);
///Performs the cleanup required by your performance DLL. Implement and export this function if you are writing a
///performance DLL to provide performance data. The system calls this function whenever a consumer closes the registry
///key used to collect performance data. The <b>ClosePerformanceData</b> function is a placeholder for the
///application-defined function name.
///Params:
///    Arg1 = 
///Returns:
///    This function should return ERROR_SUCCESS.
///    
alias PM_CLOSE_PROC = uint function();
///Providers can implement this function to receive notification when consumers perform certain actions, such as adding
///or removing counters from a query. PERFLIB calls the callback before the consumer's request completes. The
///<b>PERFLIBREQUEST</b> type defines a pointer to this callback function. The <b>ControlCallback</b> function is a
///placeholder for the application-defined function name.
///Params:
///    RequestCode = The request code can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="PERF_ADD_COUNTER"></a><a id="perf_add_counter"></a><dl>
///                  <dt><b><b>PERF_ADD_COUNTER</b></b></dt> </dl> </td> <td width="60%"> The consumer is adding a counter to the
///                  query. PERFLIB calls the callback with this request code for each counter being added to the query. The
///                  <i>Buffer</i> parameter contains a PERF_COUNTER_IDENTITY structure that identifies the counter being added.
///                  Providers can use this notification to start counting. </td> </tr> <tr> <td width="40%"><a
///                  id="PERF_REMOVE_COUNTER"></a><a id="perf_remove_counter"></a><dl> <dt><b><b>PERF_REMOVE_COUNTER</b></b></dt>
///                  </dl> </td> <td width="60%"> The consumer is removing a counter from the query. PERFLIB calls the callback with
///                  this request code for each counter being removed from the query. The <i>Buffer</i> parameter contains a
///                  PERF_COUNTER_IDENTITY structure that identifies the counter being removed. Providers can use this notification to
///                  stop counting. </td> </tr> <tr> <td width="40%"><a id="PERF_ENUM_INSTANCES"></a><a
///                  id="perf_enum_instances"></a><dl> <dt><b><b>PERF_ENUM_INSTANCES</b></b></dt> </dl> </td> <td width="60%"> The
///                  consumer is enumerating instances of the counter set. The <i>Buffer</i> parameter contains a null-terminated
///                  Unicode string that identifies the name of the computer (or its IP address) from which the consumer is
///                  enumerating the instances. </td> </tr> <tr> <td width="40%"><a id="PERF_COLLECT_START"></a><a
///                  id="perf_collect_start"></a><dl> <dt><b><b>PERF_COLLECT_START</b></b></dt> </dl> </td> <td width="60%"> The
///                  consumer is beginning to collect counter data. The <i>Buffer</i> parameter contains a null-terminated Unicode
///                  string that identifies the name of the computer (or its IP address) from which the consumer is collecting data.
///                  Providers can use this notification if the raw data state is critical (for example, transaction-related counters
///                  where partial updates are not allowed). This notification gives the provider a chance to flush all pending
///                  updates and lock future updates before collection begins. </td> </tr> <tr> <td width="40%"><a
///                  id="PERF_COLLECT_END"></a><a id="perf_collect_end"></a><dl> <dt><b><b>PERF_COLLECT_END</b></b></dt> </dl> </td>
///                  <td width="60%"> The counter data collection is complete. The <i>Buffer</i> parameter contains a null-terminated
///                  Unicode string that identifies the name of the computer (or its IP address) from which the consumer collected
///                  data. Providers can use this notification to release the update lock imposed by the collection start notification
///                  so that updates to the counter data can resume. </td> </tr> </table>
///    Buffer = The contents of the buffer depends on the request. For possible content, see the <i>RequestCode</i> parameter.
///    BufferSize = Size, in bytes, of the <i>Buffer</i> parameter.
///Returns:
///    Return ERROR_SUCCESS if the callback succeeds. If the callback fails, PERFLIB will return the error code to the
///    consumer if the request is <b>PERF_ADD_COUNTER</b>, <b>PERF_ENUM_INSTANCES</b>, or <b>PERF_COLLECT_START</b>;
///    otherwise, the error code is ignored.
///    
alias PERFLIBREQUEST = uint function(uint RequestCode, void* Buffer, uint BufferSize);
///Providers implement this function to provide custom memory management for PERFLIB. PERFLIB calls this callback when
///it needs to allocate memory. By default, PERFLIB uses the process heap to allocate memory. The <b>PERF_MEM_ALLOC</b>
///type defines a pointer to this callback function. The <b>AllocateMemory</b> function is a placeholder for the
///application-defined function name.
///Params:
///    AllocSize = Number of bytes to allocate.
///    pContext = Context information set in the <b>pMemContext</b> member of PERF_PROVIDER_CONTEXT.
///Returns:
///    Pointer to the allocated memory or <b>NULL</b> if an error occurred.
///    
alias PERF_MEM_ALLOC = void* function(size_t AllocSize, void* pContext);
///Providers implement this function to provide custom memory management for PERFLIB. PERFLIB calls this callback when
///it needs to free memory that it allocated using AllocateMemory. The <b>PERF_MEM_FREE</b> type defines a pointer to
///this callback function. The <b>FreeMemory</b> function is a placeholder for the application-defined function name.
///Params:
///    pBuffer = Memory to free.
///    pContext = Context information set in the <b>pMemContext</b> member of PERF_PROVIDER_CONTEXT.
alias PERF_MEM_FREE = void function(void* pBuffer, void* pContext);
///Applications implement the <b>CounterPathCallBack</b> function to process the counter path strings returned by the
///<b>Browse</b> dialog box.
///Params:
///    Arg1 = User-defined value passed to the callback function by the <b>Browse</b> dialog box. You set this value in the
///           <b>dwCallBackArg</b> member of the PDH_BROWSE_DLG_CONFIG structure.
///Returns:
///    Return ERROR_SUCCESS if the function succeeds. If the function fails due to a transient error, you can return
///    PDH_RETRY and PDH will call your callback immediately. Otherwise, return an appropriate error code. The error
///    code is passed back to the caller of PdhBrowseCounters.
///    
alias CounterPathCallBack = int function(size_t param0);

// Structs


///Describes the performance data block that you queried, for example, the number of performance objects returned by the
///provider and the time-based values that you use when calculating performance values.
struct PERF_DATA_BLOCK
{
    ///Array of four wide-characters that contains "PERF".
    ushort[4]     Signature;
    ///Indicates if the counter values are in big endian format or little endian format. If one, the counter values are
    ///in little endian format. If zero, the counter values are in big endian format. This value may be zero (big endian
    ///format) if you retrieve performance data from a foreign computer, such as a UNIX computer.
    uint          LittleEndian;
    ///Version of the performance structures.
    uint          Version;
    ///Revision of the performance structures.
    uint          Revision;
    ///Total size of the performance data block, in bytes.
    uint          TotalByteLength;
    ///Size of this structure, in bytes. You use the header length to find the first PERF_OBJECT_TYPE structure in the
    ///performance data block.
    uint          HeaderLength;
    ///Number of performance objects in the performance data block.
    uint          NumObjectTypes;
    ///Reserved.
    int           DefaultObject;
    ///Time when the system was monitored. This member is in Coordinated Universal Time (UTC) format.
    SYSTEMTIME    SystemTime;
    ///Performance-counter value, in counts, for the system being monitored. For more information, see
    ///QueryPerformanceCounter.
    LARGE_INTEGER PerfTime;
    ///Performance-counter frequency, in counts per second, for the system being monitored. For more information, see
    ///QueryPerformanceFrequency.
    LARGE_INTEGER PerfFreq;
    ///Performance-counter value, in 100 nanosecond units, for the system being monitored. For more information, see
    ///GetSystemTimeAsFileTime.
    LARGE_INTEGER PerfTime100nSec;
    ///Size of the computer name located at <b>SystemNameOffset</b>, in bytes.
    uint          SystemNameLength;
    ///Offset from the beginning of this structure to the Unicode name of the computer being monitored.
    uint          SystemNameOffset;
}

///Describes object-specific performance information, for example, the number of instances of the object and the number
///of counters that the object defines.
struct PERF_OBJECT_TYPE
{
    ///Size of the object-specific data, in bytes. This member is the offset from the beginning of this structure to the
    ///next <b>PERF_OBJECT_TYPE</b> structure, if one exists.
    uint          TotalByteLength;
    ///Size of this structure plus the size of all the PERF_COUNTER_DEFINITION structures. If the object is a multiple
    ///instance object (the <b>NumInstances</b> member is not zero), this member is the offset from the beginning of
    ///this structure to the first PERF_INSTANCE_DEFINITION structure. Otherwise, this value is the offset to the
    ///PERF_COUNTER_BLOCK.
    uint          DefinitionLength;
    ///Size of this structure, in bytes. This member is the offset from the beginning of this structure to the first
    ///PERF_COUNTER_DEFINITION structure.
    uint          HeaderLength;
    ///Index to the object's name in the title database. For details on using the index to retrieve the object's name,
    ///see Retrieving Counter Names and Help Text. Providers specify the index value in their initialization file. For
    ///details, see Adding Counter Names and Descriptions to the Registry.
    uint          ObjectNameTitleIndex;
    ///Reserved.
    PWSTR         ObjectNameTitle;
    ///Index to the object's help text in the title database. For details on using the index to retrieve the object's
    ///help text, see Retrieving Counter Names and Help Text. Providers specify the index value in their initialization
    ///file. For details, see Adding Counter Names and Descriptions to the Registry.
    uint          ObjectHelpTitleIndex;
    ///Reserved.
    PWSTR         ObjectHelpTitle;
    ///Level of detail. Consumers use this value to control display complexity. This value is the minimum detail level
    ///of all the counters for a given object. This member can be one of the following values. <table> <tr> <th>Detail
    ///level</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
    ///id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> The counter data
    ///is provided for all users. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
    ///id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter
    ///data is provided for advanced users. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
    ///id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> The counter data
    ///is provided for expert users. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
    ///id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> The counter data
    ///is provided for system designers. </td> </tr> </table>
    uint          DetailLevel;
    ///Number of PERF_COUNTER_DEFINITION blocks returned by the object.
    uint          NumCounters;
    ///Index to the counter's name in the title database of the default counter whose information is to be displayed
    ///when this object is selected in the Performance tool. This member may be –1 to indicate that there is no
    ///default.
    int           DefaultCounter;
    ///Number of object instances for which counters are being provided. If the object can have zero or more instances,
    ///but has none at present, this value should be zero. If the object cannot have multiple instances, this value
    ///should be PERF_NO_INSTANCES.
    int           NumInstances;
    ///This member is zero if the instance strings are Unicode strings. Otherwise, this member is the code-page
    ///identifier of the instance names. You can use the code-page value when calling MultiByteToWideChar to convert the
    ///string to Unicode.
    uint          CodePage;
    ///Provider generated timestamp that consumers use when calculating counter values. For example, this could be the
    ///current value, in counts, of the high-resolution performance counter. Providers need to provide this value if the
    ///counter types of their counters include the <b>PERF_OBJECT_TIMER</b> flag. Otherwise, consumers use the
    ///<b>PerfTime</b> value from PERF_DATA_BLOCK.
    LARGE_INTEGER PerfTime;
    ///Provider generated frequency value that consumers use when calculating counter values. For example, this could be
    ///the current frequency, in counts per second, of the high-resolution performance counter. Providers need to
    ///provide this value if the counter types of their counters include the <b>PERF_OBJECT_TIMER</b> flag. Otherwise,
    ///consumers use the <b>PerfFreq</b> value from PERF_DATA_BLOCK.
    LARGE_INTEGER PerfFreq;
}

///Describes a performance counter.
struct PERF_COUNTER_DEFINITION
{
    ///Size of this structure, in bytes.
    uint  ByteLength;
    ///Index of the counter's name in the title database. For details on using the index to retrieve the counter's name,
    ///see Retrieving Counter Names and Help Text. To set this value, providers add the counter's offset value defined
    ///in their symbol file to the <b>First Counter</b> registry value. For details, see Adding Counter Names and
    ///Descriptions to the Registry and Implementing the OpenPerformanceData function. This value should be zero if the
    ///counter is a base counter (<b>CounterType</b> includes the PERF_COUNTER_BASE flag).
    uint  CounterNameTitleIndex;
    ///Reserved.
    PWSTR CounterNameTitle;
    ///Index to the counter's help text in the title database. For details on using the index to retrieve the counter's
    ///help text, see Retrieving Counter Names and Help Text. To set this value, providers add the counter's offset
    ///value defined in their symbol file to the <b>First Help</b> registry value. For details, see Adding Counter Names
    ///and Descriptions to the Registry and Implementing the OpenPerformanceData function. This value should be zero if
    ///the counter is a base counter (<b>CounterType</b> includes the PERF_COUNTER_BASE flag).
    uint  CounterHelpTitleIndex;
    ///Reserved.
    PWSTR CounterHelpTitle;
    ///Scale factor to use when graphing the counter value. Valid values range from -7 to 7 (the values correspond to
    ///0.0000001 - 10000000). If this value is zero, the scale value is 1; if this value is 1, the scale value is 10; if
    ///this value is –1, the scale value is .10; and so on.
    int   DefaultScale;
    ///Level of detail for the counter. Consumers use this value to control display complexity. This member can be one
    ///of the following values. <table> <tr> <th>Detail level</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td>
    ///<td width="60%"> The counter data is provided for all users. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl>
    ///</td> <td width="60%"> The counter data is provided for advanced users. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_DETAIL_EXPERT"></a><a id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td>
    ///<td width="60%"> The counter data is provided for expert users. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_DETAIL_WIZARD"></a><a id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td>
    ///<td width="60%"> The counter data is provided for system designers. </td> </tr> </table>
    uint  DetailLevel;
    ///Type of counter. For a list of predefined counter types, see the Counter Types section of the Windows Server 2003
    ///Deployment Kit. Consumers use the counter type to determine how to calculate and display the counter value.
    ///Providers should limit their choice of counter types to the predefined list.
    uint  CounterType;
    ///Counter size, in bytes. Currently, only DWORDs (4 bytes) and ULONGLONGs (8 bytes) are used to provide counter
    ///values.
    uint  CounterSize;
    ///Offset from the start of the PERF_COUNTER_BLOCK structure to the first byte of this counter. The location of the
    ///<b>PERF_COUNTER_BLOCK</b> structure within the PERF_OBJECT_TYPE block depends on if the object contains
    ///instances. For details, see Performance Data Format. Note that multiple counters can use the same raw data and
    ///point to the same offset in the PERF_COUNTER_BLOCK block.
    uint  CounterOffset;
}

///Describes an instance of a performance object.
struct PERF_INSTANCE_DEFINITION
{
    ///Size of this structure, including the instance name that follows, in bytes. This value must be an 8-byte
    ///multiple.
    uint ByteLength;
    ///Index of the name of the parent object in the title database. For example, if the object is a thread, the parent
    ///object is a process, or if the object is a logical drive, the parent is a physical drive.
    uint ParentObjectTitleIndex;
    ///Position of the instance within the parent object that is associated with this instance. The position is
    ///zero-based.
    uint ParentObjectInstance;
    ///A unique identifier that you can use to identify the instance instead of using the name to identify the instance.
    ///If you do not use unique identifiers to distinguish the counter instances, set this member to PERF_NO_UNIQUE_ID.
    int  UniqueID;
    ///Offset from the beginning of this structure to the Unicode name of this instance.
    uint NameOffset;
    ///Length of the instance name, including the null-terminator, in bytes. This member is zero if the instance does
    ///not have a name. Do not include in the length any padding that you added to the instance name to ensure that
    ///<b>ByteLength</b> is aligned to an 8-byte boundary.
    uint NameLength;
}

///Describes the block of memory that contains the raw performance counter data for an object's counters.
struct PERF_COUNTER_BLOCK
{
    ///Size of this structure and the raw counter data that follows, in bytes.
    uint ByteLength;
}

@RAIIFree!PerfStopProvider
struct PerfProviderHandle
{
    ptrdiff_t Value;
}

@RAIIFree!PerfCloseQueryHandle
struct PerfQueryHandle
{
    ptrdiff_t Value;
}

///Defines information about a counter set that a provider uses. The CTRPP tool automatically generates this structure
///based on the schema you specify.
struct PERF_COUNTERSET_INFO
{
    ///GUID that uniquely identifies the counter set. The <b>guid</b> attribute of the counterSet element contains the
    ///GUID.
    GUID CounterSetGuid;
    ///GUID that uniquely identifies the provider that supports the counter set. The <b>providerGuid</b> attribute of
    ///the provider element contains the GUID.
    GUID ProviderGuid;
    ///Number of counters in the counter set. See Remarks.
    uint NumCounters;
    ///Specifies whether the counter set allows multiple instances such as processes and physical disks, or a single
    ///instance such as memory. The following are the possible instance types. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_COUNTERSET_SINGLE_INSTANCE"></a><a
    ///id="perf_counterset_single_instance"></a><dl> <dt><b>PERF_COUNTERSET_SINGLE_INSTANCE</b></dt> </dl> </td> <td
    ///width="60%"> The counter set contains single instance counters, for example, a counter that measures physical
    ///memory. </td> </tr> <tr> <td width="40%"><a id="PERF_COUNTERSET_MULTI_INSTANCES"></a><a
    ///id="perf_counterset_multi_instances"></a><dl> <dt><b>PERF_COUNTERSET_MULTI_INSTANCES</b></dt> </dl> </td> <td
    ///width="60%"> The counter set contains multiple instance counters, for example, a counter that measures the
    ///average disk I/O for a process. </td> </tr> <tr> <td width="40%"><a id="PERF_COUNTERSET_SINGLE_AGGREGATE"></a><a
    ///id="perf_counterset_single_aggregate"></a><dl> <dt><b>PERF_COUNTERSET_SINGLE_AGGREGATE</b></dt> </dl> </td> <td
    ///width="60%"> The counter set contains single instance counters whose aggregate value is obtained from one or more
    ///sources. For example, a counter in this type of counter set might obtain the number of reads from each of the
    ///three hard disks on the computer and sum their values. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_COUNTERSET_MULTI_AGGREGATE"></a><a id="perf_counterset_multi_aggregate"></a><dl>
    ///<dt><b>PERF_COUNTERSET_MULTI_AGGREGATE</b></dt> </dl> </td> <td width="60%"> The counter set contains multiple
    ///instance counters whose aggregate value is obtained from all instances of the counter. For example, a counter in
    ///this type of counter set might obtain the total thread execution time for all threads in a multi-threaded
    ///application and sum their values. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_COUNTERSET_SINGLE_AGGREGATE_HISTORY"></a><a id="perf_counterset_single_aggregate_history"></a><dl>
    ///<dt><b>PERF_COUNTERSET_SINGLE_AGGREGATE_HISTORY</b></dt> </dl> </td> <td width="60%"> The difference between this
    ///type and <b>PERF_COUNTERSET_SINGLE_AGGREGATE</b> is that this counter set type stores all counter values for the
    ///lifetime of the consumer application (the counter value is cached beyond the lifetime of the counter). For
    ///example, if one of the hard disks in the single aggregate example above were to become unavailable, the total
    ///bytes read by that disk would still be available and used to calculate the aggregate value. </td> </tr> <tr> <td
    ///width="40%"><a id="PERF_COUNTERSET_INSTANCE_AGGREGATE"></a><a id="perf_counterset_instance_aggregate"></a><dl>
    ///<dt><b>PERF_COUNTERSET_INSTANCE_AGGREGATE</b></dt> </dl> </td> <td width="60%"> This type is similar to
    ///PERF_COUNTERSET_MULTI_AGGREGATE, except that instead of aggregating all instance data to one aggregated (_Total)
    ///instance, it will aggregate counter data from instances of the same name. For example, if multiple provider
    ///processes contained instances named IExplore, PERF_COUNTERSET_MULTIPLE and PERF_COUNTERSET_MULTI_AGGREGATE
    ///CounterSet will show multiple IExplore instances (IExplore, IExplore
    uint InstanceType;
}

///Defines information about a counter that a provider uses. The CTRPP tool automatically generates this structure based
///on the schema you specify.
struct PERF_COUNTER_INFO
{
    ///Identifier that uniquely identifies the counter within the counter set.
    uint  CounterId;
    ///Specifies the type of counter. For possible counter types, see Counter Types in the Windows 2003 Deployment
    ///Guide.
    uint  Type;
    ///One or more attributes that indicate how to display this counter. The possible values are: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_ATTRIB_BY_REFERENCE"></a><a
    ///id="perf_attrib_by_reference"></a><dl> <dt><b>PERF_ATTRIB_BY_REFERENCE</b></dt> </dl> </td> <td width="60%">
    ///Retrieve the value of the counter by reference as opposed to by value. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_ATTRIB_NO_DISPLAYABLE"></a><a id="perf_attrib_no_displayable"></a><dl>
    ///<dt><b>PERF_ATTRIB_NO_DISPLAYABLE</b></dt> </dl> </td> <td width="60%"> Do not display the counter value. </td>
    ///</tr> <tr> <td width="40%"><a id="PERF_ATTRIB_NO_GROUP_SEPARATOR"></a><a
    ///id="perf_attrib_no_group_separator"></a><dl> <dt><b>PERF_ATTRIB_NO_GROUP_SEPARATOR</b></dt> </dl> </td> <td
    ///width="60%"> Do not use digit separators when displaying counter value. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_ATTRIB_DISPLAY_AS_REAL"></a><a id="perf_attrib_display_as_real"></a><dl>
    ///<dt><b>PERF_ATTRIB_DISPLAY_AS_REAL</b></dt> </dl> </td> <td width="60%"> Display the counter value as a real
    ///value. </td> </tr> <tr> <td width="40%"><a id="PERF_ATTRIB_DISPLAY_AS_HEX"></a><a
    ///id="perf_attrib_display_as_hex"></a><dl> <dt><b>PERF_ATTRIB_DISPLAY_AS_HEX</b></dt> </dl> </td> <td width="60%">
    ///Display the counter value as a hexadecimal number. </td> </tr> </table> The attributes
    ///PERF_ATTRIB_NO_GROUP_SEPARATOR, PERF_ATTRIB_DISPLAY_AS_REAL, and PERF_ATTRIB_DISPLAY_AS_HEX are not mutually
    ///exclusive. If you specify all three attributes, precedence is given to the attributes in the order given.
    ulong Attrib;
    ///Size, in bytes, of this structure.
    uint  Size;
    ///Specify the target audience for the counter. Possible values are: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl>
    ///<dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> You can display the counter to any level of user.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl>
    ///<dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter is complicated and should be
    ///displayed only to advanced users. </td> </tr> </table>
    uint  DetailLevel;
    ///Scale factor to apply to the counter value. Valid values range from –10 through 10. Zero if no scale is
    ///applied. If this value is zero, the scale value is 1; if this value is 1, the scale value is 10; if this value is
    ///–1, the scale value is .10; and so on.
    int   Scale;
    ///Byte offset from the beginning of the PERF_COUNTERSET_INSTANCE block to the counter value.
    uint  Offset;
}

///Defines an instance of a counter set.
struct PERF_COUNTERSET_INSTANCE
{
    ///GUID that identifies the counter set to which this instance belongs.
    GUID CounterSetGuid;
    ///Size, in bytes, of the instance block. The instance block contains this structure, followed by one or more
    ///PERF_COUNTER_INFO blocks, and ends with the instance name.
    uint dwSize;
    ///Identifier that uniquely identifies this instance. The provider specified the identifier when calling
    ///PerfCreateInstance.
    uint InstanceId;
    ///Byte offset from the beginning of this structure to the null-terminated Unicode instance name. The provider
    ///specified the instance name when calling PerfCreateInstance.
    uint InstanceNameOffset;
    ///Size, in bytes, of the instance name. The size includes the null-terminator.
    uint InstanceNameSize;
}

///Defines the counter that is sent to a provider's callback when the consumer adds or removes a counter from the query.
struct PERF_COUNTER_IDENTITY
{
    ///GUID that uniquely identifies the counter set that this counter belongs to.
    GUID CounterSetGuid;
    ///Size, in bytes, of this structure and the computer name and instance name that are appended to this structure in
    ///memory.
    uint BufferSize;
    ///Unique identifier of the counter in the counter set. This member is set to <b>PERF_WILDCARD_COUNTER</b> if the
    ///consumer wants to add or remove all counters in the counter set.
    uint CounterId;
    ///Identifier of the counter set instance to which the counter belongs. Ignore this value if the instance name at
    ///<b>NameOffset</b> is PERF_WILDCARD_INSTANCE.
    uint InstanceId;
    ///Offset to the null-terminated Unicode computer name that follows this structure in memory.
    uint MachineOffset;
    ///Offset to the null-terminated Unicode instance name that follows this structure in memory.
    uint NameOffset;
    ///Reserved.
    uint Reserved;
}

///Defines provider context information.
struct PERF_PROVIDER_CONTEXT
{
    ///The size of this structure.
    uint           ContextSize;
    ///Reserved.
    uint           Reserved;
    ///The name of the ControlCallback function that PERFLIB calls to notify you of consumer requests, such as a request
    ///to add or remove counters from the query. Set this member if the <b>callback</b> attribute of the provider
    ///element is "custom" or you used the <b>-NotificationCallback</b> argument when calling CTRPP. Otherwise,
    ///<b>NULL</b>.
    PERFLIBREQUEST ControlCallback;
    ///The name of the AllocateMemory function that PERFLIB calls to allocate memory. Set this member if you used the
    ///<b>-MemoryRoutines</b> argument when calling CTRPP. Otherwise, <b>NULL</b>.
    PERF_MEM_ALLOC MemAllocRoutine;
    ///The name of the FreeMemory function that PERFLIB calls to free memory allocated by the AllocateMemory function.
    ///Must be <b>NULL</b> if <b>MemAllocRoutine</b> is <b>NULL</b>.
    PERF_MEM_FREE  MemFreeRoutine;
    ///Context information passed to the memory allocation and free routines. Can be <b>NULL</b>.
    void*          pMemContext;
}

///Provides information about the <b>PERF_INSTANCE_HEADER</b> block that contains the structure. A
///<b>PERF_INSTANCE_HEADER</b> block provides information about the instances in a counter set, or the instances for
///which performance counter results are provided in a multiple-instance query. The <b>PERF_INSTANCE_HEADER</b> block
///consists of the following items in order: <ol> <li>A <b>PERF_INSTANCE_HEADER</b> structure that contains the size of
///the <b>PERF_INSTANCE_HEADER</b> block and the instance identifier</li> <li>A null-terminated UTF-16LE string that
///contains the instance name.</li> <li>Padding such that the total size of the <b>PERF_INSTANCE_HEADER</b> block is a
///multiple of 8 bytes. </li> </ol>
struct PERF_INSTANCE_HEADER
{
    ///The total size of the <b>PERF_INSTANCE_HEADER</b> block, in bytes. This total size is the sum of the sizes of the
    ///<b>PERF_INSTANCE_HEADER</b> structures, the string that contains the instance name, and the padding.
    uint Size;
    ///The instance identifier.
    uint InstanceId;
}

///Contains information about the <b>PERF_COUNTERSET_REG_INFO</b> block that contains the structure. A
///<b>PERF_COUNTERSET_REG_INFO</b> block provides registration information for a counter set and the performance
///counters it contains, and consists of a <b>PERF_COUNTERSET_REG_INFO</b>structure immediately followed by a set
///PERF_COUNTER_REG_INFO structures that correspond to the performance counters in the counter set.
struct PERF_COUNTERSET_REG_INFO
{
    ///The unique identifier for the counter set.
    GUID CounterSetGuid;
    ///Reserved.
    uint CounterSetType;
    ///The target audience for the counters in the counter set. The possible values are: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl>
    ///<dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> You can display the counter to any level of user.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl>
    ///<dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter is complicated and should be
    ///displayed only to advanced users. </td> </tr> </table>
    uint DetailLevel;
    ///The number of PERF_COUNTER_REG_INFO structures in this <b>PERF_COUNTERSET_REG_INFO</b> block.
    uint NumCounters;
    ///Specifies whether the counter set allows multiple instances such as processes and physical disks, or a single
    ///instance such as memory. The following are the possible instance types. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_COUNTERSET_SINGLE_INSTANCE"></a><a
    ///id="perf_counterset_single_instance"></a><dl> <dt><b>PERF_COUNTERSET_SINGLE_INSTANCE</b></dt> </dl> </td> <td
    ///width="60%"> The counter set contains single instance counters, for example, a counter that measures physical
    ///memory. </td> </tr> <tr> <td width="40%"><a id="PERF_COUNTERSET_MULTI_INSTANCES"></a><a
    ///id="perf_counterset_multi_instances"></a><dl> <dt><b>PERF_COUNTERSET_MULTI_INSTANCES</b></dt> </dl> </td> <td
    ///width="60%"> The counter set contains multiple instance counters, for example, a counter that measures the
    ///average disk I/O for a process. </td> </tr> <tr> <td width="40%"><a id="PERF_COUNTERSET_SINGLE_AGGREGATE"></a><a
    ///id="perf_counterset_single_aggregate"></a><dl> <dt><b>PERF_COUNTERSET_SINGLE_AGGREGATE</b></dt> </dl> </td> <td
    ///width="60%"> The counter set contains single instance counters whose aggregate value is obtained from one or more
    ///sources. For example, a counter in this type of counter set might obtain the number of reads from each of the
    ///three hard disks on the computer and sum their values. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_COUNTERSET_MULTI_AGGREGATE"></a><a id="perf_counterset_multi_aggregate"></a><dl>
    ///<dt><b>PERF_COUNTERSET_MULTI_AGGREGATE</b></dt> </dl> </td> <td width="60%"> The counter set contains multiple
    ///instance counters whose aggregate value is obtained from all instances of the counter. For example, a counter in
    ///this type of counter set might obtain the total thread execution time for all threads in a multi-threaded
    ///application and sum their values. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_COUNTERSET_SINGLE_AGGREGATE_HISTORY"></a><a id="perf_counterset_single_aggregate_history"></a><dl>
    ///<dt><b>PERF_COUNTERSET_SINGLE_AGGREGATE_HISTORY</b></dt> </dl> </td> <td width="60%"> The difference between this
    ///type and <b>PERF_COUNTERSET_SINGLE_AGGREGATE</b> is that this counter set type stores all counter values for the
    ///lifetime of the consumer application (the counter value is cached beyond the lifetime of the counter). For
    ///example, if one of the hard disks in the single aggregate example above were to become unavailable, the total
    ///bytes read by that disk would still be available and used to calculate the aggregate value. </td> </tr> <tr> <td
    ///width="40%"><a id="PERF_COUNTERSET_INSTANCE_AGGREGATE"></a><a id="perf_counterset_instance_aggregate"></a><dl>
    ///<dt><b>PERF_COUNTERSET_INSTANCE_AGGREGATE</b></dt> </dl> </td> <td width="60%"> Not implemented. </td> </tr>
    ///</table>
    uint InstanceType;
}

///Provides registration information about a performance counter.
struct PERF_COUNTER_REG_INFO
{
    ///A unique identifier for the performance counter within the counter set. A counter set can contain a maximum of
    ///64,000 performance counters.
    uint  CounterId;
    ///The type of the performance counter. For information about the predefined counter types, see the Counter Types
    ///section of the Windows Server 2003 Deployment Kit. Consumers use the counter type to determine how to calculate
    ///and display the counter value. Providers should limit their choice of counter types to the predefined list. The
    ///possible values are: <a id="PERF_100NSEC_MULTI_TIMER"></a> <a id="perf_100nsec_multi_timer"></a>
    uint  Type;
    ///One or more attributes that indicate how to display this counter. The possible values are: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_ATTRIB_BY_REFERENCE"></a><a
    ///id="perf_attrib_by_reference"></a><dl> <dt><b>PERF_ATTRIB_BY_REFERENCE</b></dt> </dl> </td> <td width="60%">
    ///Retrieve the value of the counter by reference as opposed to by value. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_ATTRIB_NO_DISPLAYABLE"></a><a id="perf_attrib_no_displayable"></a><dl>
    ///<dt><b>PERF_ATTRIB_NO_DISPLAYABLE</b></dt> </dl> </td> <td width="60%"> Do not display the counter value. </td>
    ///</tr> <tr> <td width="40%"><a id="PERF_ATTRIB_NO_GROUP_SEPARATOR"></a><a
    ///id="perf_attrib_no_group_separator"></a><dl> <dt><b>PERF_ATTRIB_NO_GROUP_SEPARATOR</b></dt> </dl> </td> <td
    ///width="60%"> Do not use digit separators when displaying counter value. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_ATTRIB_DISPLAY_AS_REAL"></a><a id="perf_attrib_display_as_real"></a><dl>
    ///<dt><b>PERF_ATTRIB_DISPLAY_AS_REAL</b></dt> </dl> </td> <td width="60%"> Display the counter value as a real
    ///value. </td> </tr> <tr> <td width="40%"><a id="PERF_ATTRIB_DISPLAY_AS_HEX"></a><a
    ///id="perf_attrib_display_as_hex"></a><dl> <dt><b>PERF_ATTRIB_DISPLAY_AS_HEX</b></dt> </dl> </td> <td width="60%">
    ///Display the counter value as a hexadecimal number. </td> </tr> </table> The attributes
    ///<b>PERF_ATTRIB_NO_GROUP_SEPARATOR</b>, <b>PERF_ATTRIB_DISPLAY_AS_REAL</b>, and <b>PERF_ATTRIB_DISPLAY_AS_HEX</b>
    ///are not mutually exclusive. If you specify all three attributes, precedence is given to the attributes in the
    ///order given.
    ulong Attrib;
    ///The target audience for the counter. The possible values are: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl>
    ///<dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> You can display the counter to any level of user.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl>
    ///<dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter is complicated and should be
    ///displayed only to advanced users. </td> </tr> </table>
    uint  DetailLevel;
    ///The scaling factor to apply to the raw performance counter value. Valid values range from –10 through 10. Zero
    ///if no scale is applied. If this value is zero, the scale value is 1; if this value is 1, the scale value is 10;
    ///if this value is –1, the scale value is .10; and so on. The scaled value of the performance counter is equal to
    ///the raw value of the performance counter multiplied by 10 raised to the power that the <b>DefaultScale</b> member
    ///specifies.
    int   DefaultScale;
    ///The counter identifier of the base counter. 0xFFFFFFFF indicates that there is no base counter.
    uint  BaseCounterId;
    ///The counter identifier of the performance counter. 0xFFFFFFFF indicates that there is no performance counter.
    uint  PerfTimeId;
    ///The counter identifier of the frequency counter. 0xFFFFFFFF indicates that there is no frequency counter.
    uint  PerfFreqId;
    ///The counter identifier of the multi-counter. 0xFFFFFFFF indicates that there is no multi-counter.
    uint  MultiId;
    ///The aggregation function the client should apply to the counter if the counter set to which the counter belongs
    ///is of type Global Aggregate, Multiple Instance Aggregate, or Global Aggregate History. The client specifies the
    ///counter instances across which the aggregation is performed if the counter set type is Multiple Instance
    ///Aggregate; otherwise, the client must aggregate values across all instances of the counter set. One of the
    ///following values must be specified. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PERF_AGGREGATE_UNDEFINED"></a><a id="perf_aggregate_undefined"></a><dl>
    ///<dt><b>PERF_AGGREGATE_UNDEFINED</b></dt> </dl> </td> <td width="60%"> Undefined. </td> </tr> <tr> <td
    ///width="40%"><a id="PERF_AGGREGATE_TOTAL"></a><a id="perf_aggregate_total"></a><dl>
    ///<dt><b>PERF_AGGREGATE_TOTAL</b></dt> </dl> </td> <td width="60%"> The sum of the values of the returned counter
    ///instances. </td> </tr> <tr> <td width="40%"><a id="PERF_AGGREGATE_AVG"></a><a id="perf_aggregate_avg"></a><dl>
    ///<dt><b>PERF_AGGREGATE_AVG</b></dt> </dl> </td> <td width="60%"> The average of the values of the returned counter
    ///instances. </td> </tr> <tr> <td width="40%"><a id="PERF_AGGREGATE_MIN"></a><a id="perf_aggregate_min"></a><dl>
    ///<dt><b>PERF_AGGREGATE_MIN</b></dt> </dl> </td> <td width="60%"> The minimum value of the returned counter
    ///instance values. </td> </tr> <tr> <td width="40%"><a id="PERF_AGGREGATE_MAX_"></a><a
    ///id="perf_aggregate_max_"></a><dl> <dt><b>PERF_AGGREGATE_MAX </b></dt> </dl> </td> <td width="60%"> The maximum
    ///value of the returned counter instance values. </td> </tr> </table>
    uint  AggregateFunc;
    ///Reserved.
    uint  Reserved;
}

///Provides information about the <b>PERF_STRING_BUFFER_HEADER</b> block that contains the structure. The
///<b>PERF_STRING_BUFFER_HEADER</b> block provides the names or help strings for the performance counters in a counter
///set, amd consists of the following items in order:<ol> <li>A <b>PERF_STRING_BUFFER_HEADER</b>structure</li> <li>A
///number of PERF_STRING_COUNTER_HEADERstructures. The <b>dwCounters</b> member of the <b>PERF_STRING_BUFFER_HEADER</b>
///structure specifies how many <b>PERF_STRING_COUNTER_HEADER</b>structures the <b>PERF_STRING_BUFFER_HEADER</b> block
///contains.</li> <li>A block of string data.</li> </ol>
struct PERF_STRING_BUFFER_HEADER
{
    ///The total size of the <b>PERF_STRING_BUFFER_HEADER</b> block, in bytes. This total size is the sum of the sizes
    ///of the <b>PERF_STRING_BUFFER_HEADER</b> structure, all of the PERF_STRING_COUNTER_HEADER structures, and the
    ///block of string data.
    uint dwSize;
    ///The number of PERF_STRING_COUNTER_HEADER structures in the <b>PERF_STRING_BUFFER_HEADER</b> block.
    uint dwCounters;
}

///Indicates where in the PERF_STRING_BUFFER_HEADER block that the string that contains the name or help string for the
///indicated performance counter starts. The <b>PERF_STRING_COUNTER_HEADER</b> structure is part of the
///PERF_STRING_BUFFER_HEADER block
struct PERF_STRING_COUNTER_HEADER
{
    ///The identifier of the performance counter.
    uint dwCounterId;
    ///The number of bytes from the start of the PERF_STRING_BUFFER_HEADER block to the null-terminated UTF-16LE data. A
    ///value of 0xFFFFFFFF indicates that the string is not present; in other words, that the value of the string is
    ///NULL.
    uint dwOffset;
}

///Contains information about the <b>PERF_COUNTER_IDENTIFIER</b> block that contains the structure. A
///<b>PERF_COUNTER_IDENTIFIER</b> block provides information about a performance counter specification, and consists of
///the following items in order: <ol> <li>A <b>PERF_COUNTER_IDENTIFIER</b>structure</li> <li>An optional null-terminated
///UTF-16LE string that specifies the instance name</li> <li>Padding as needed to make the size of the block a multiple
///of 8 bytes. </li> </ol>
struct PERF_COUNTER_IDENTIFIER
{
    ///The <b>GUID</b> of the performance counter set.
    GUID CounterSetGuid;
    ///An error code that indicates whether the operation to add or delete a performance counter succeeded or failed.
    uint Status;
    ///The total size of the <b>PERF_COUNTER_IDENTIFIER</b> block, in bytes. The total size of the block is the sum of
    ///the sizes of the <b>PERF_COUNTER_IDENTIFIER</b> structure, the string that specifies the instance name, and the
    ///padding.
    uint Size;
    ///The identifier of the performance counter. <b>PERF_WILDCARD_COUNTER</b> specifies all counters.
    uint CounterId;
    ///The instance identifier. Specify 0xFFFFFFFF if you do not want to filter the results based on the instance
    ///identifier.
    uint InstanceId;
    ///The position in the sequence of <b>PERF_COUNTER_IDENTIFIER</b> blocks at which the counter data that corresponds
    ///to this <b>PERF_COUNTER_IDENTIFIER</b> block is returned. Set by PerfQueryCounterInfo.
    uint Index;
    ///Reserved.
    uint Reserved;
}

///Provides information about the <b>PERF_DATA_HEADER</b> block that contains the structure. A <b>PERF_DATA_HEADER</b>
///block corresponds to one query specification in a query, and consists of a <b>PERF_DATA_HEADER</b>structure followed
///by a sequence of PERF_COUNTER_HEADER blocks.
struct PERF_DATA_HEADER
{
    ///The sum of the size of the <b>PERF_DATA_HEADER</b> structure and the sizes of all of the PERF_COUNTER_HEADER
    ///blocks in the <b>PERF_DATA_HEADER</b> block.
    uint       dwTotalSize;
    ///The number of PERF_COUNTER_HEADER blocks that the <b>PERF_DATA_HEADER</b> block contains.
    uint       dwNumCounters;
    ///The timestamp from a high-resolution clock.
    long       PerfTimeStamp;
    ///The number of 100 nanosecond intervals since January 1, 1601, in Coordinated Universal Time (UTC).
    long       PerfTime100NSec;
    ///The frequency of a high-resolution clock.
    long       PerfFreq;
    ///The time at which data is collected by the provider.
    SYSTEMTIME SystemTime;
}

///Contains information about the <b>PERF_COUNTER_HEADER</b> block that contains the structure. A
///<b>PERF_COUNTER_HEADER</b> block provides error information and data for performance counter queries, and consists of
///a <b>PERF_COUNTER_HEADER</b> structure followed by additional performance counter data.
struct PERF_COUNTER_HEADER
{
    ///An error code that indicates whether the operation to query the performance succeeded or failed.
    uint                dwStatus;
    ///The type of performance counter information that the <b>PERF_COUNTER_HEADER</b> block provides. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_ERROR_RETURN"></a><a
    ///id="perf_error_return"></a><dl> <dt><b>PERF_ERROR_RETURN</b></dt> </dl> </td> <td width="60%"> An error that was
    ///the result of a performance counter query. The performance library cannot get valid counter data back from
    ///provider. No additional data follows the <b>PERF_COUNTER_HEADER</b> structure. The <b>dwStatus</b> member of the
    ///structure contains the error code. </td> </tr> <tr> <td width="40%"><a id="PERF_SINGLE_COUNTER"></a><a
    ///id="perf_single_counter"></a><dl> <dt><b>PERF_SINGLE_COUNTER</b></dt> </dl> </td> <td width="60%"> The result of
    ///a single-counter, single-instance query; for example, "\Processor(_Total)\% Processor Time". The additional data
    ///consists of a PERF_COUNTER_DATA block. </td> </tr> <tr> <td width="40%"><a id="PERF_MULTIPLE_COUNTERS"></a><a
    ///id="perf_multiple_counters"></a><dl> <dt><b>PERF_MULTIPLE_COUNTERS</b></dt> </dl> </td> <td width="60%"> The
    ///result of a multi-counter, single-instance query; for example, "\Processor(_Total)\*". The additional data
    ///consists of a PERF_MULTI_COUNTERS block followed by PERF_COUNTER_DATA blocks. </td> </tr> <tr> <td width="40%"><a
    ///id="PERF_MULTIPLE_INSTANCES"></a><a id="perf_multiple_instances"></a><dl> <dt><b>PERF_MULTIPLE_INSTANCES</b></dt>
    ///</dl> </td> <td width="60%"> The result of a single-counter, multi-instance query; for example, "\Processor(*)\%
    ///Processor Time". The additional data consists of a PERF_MULTI_INSTANCES block. </td> </tr> <tr> <td
    ///width="40%"><a id="PERF_COUNTERSET"></a><a id="perf_counterset"></a><dl> <dt><b>PERF_COUNTERSET</b></dt> </dl>
    ///</td> <td width="60%"> The result of a multi-counter, multi-instance query; for example, "\Processor(*)\*". The
    ///additional data consists of a PERF_MULTI_COUNTERS block followed by a PERF_MULTI_INSTANCES block. </td> </tr>
    ///</table>
    PerfCounterDataType dwType;
    ///The total size of the <b>PERF_COUNTER_HEADER</b> block, which equals the sum of the size of the
    ///<b>PERF_COUNTER_HEADER</b> structure and the size of the additional data.
    uint                dwSize;
    ///Reserved.
    uint                Reserved;
}

///Provides information about the <b>PERF_MULTI_INSTANCES</b> block that contains the structure. A
///<b>PERF_MULTI_INSTANCES</b> block indicates the number of instances for which results are provided as part of the
///PERF_COUNTER_HEADER block in multiple-instance query. The <b>PERF_MULTI_INSTANCES</b> block consists of the following
///items in order:<ol> <li>A <b>PERF_MULTI_INSTANCES</b> structure</li> <li>A number of instance data blocks. The number
///of instance data blocks that the <b>PERF_MULTI_INSTANCES</b> block contains is indicated ny the <b>dwInstances</b>
///member of the <b>PERF_MULTI_INSTANCES</b> structure. Each instance data block consists of the following items in
///order:<ol> <li>A PERF_INSTANCE_HEADER block</li> <li>A number of PERF_COUNTER_DATA blocks. The number of
///<b>PERF_COUNTER_DATA</b> blocks depends on the context:<ul> <li>If the <b>PERF_MULTI_INSTANCES</b> block is part of a
///PERF_COUNTER_HEADER block with type <b>PERF_MULTIPLE_INSTANCES</b>, the instance data block contains one
///PERF_COUNTER_DATA block.</li> <li> If the <b>PERF_MULTI_INSTANCES</b> block is part of a PERF_COUNTER_HEADER block
///with type <b>PERF_COUNTERSET</b>, the number of PERF_COUNTER_DATA blocks is indicated by the PERF_MULTI_COUNTERS
///block.</li> </ul> </li> </ol> </li> </ol>
struct PERF_MULTI_INSTANCES
{
    ///The total size of the <b>PERF_MULTI_INSTANCES</b> block, in bytes. This total size is the sum of the sizes of the
    ///<b>PERF_MULTI_INSTANCES</b> structure and the instance data blocks.
    uint dwTotalSize;
    ///The number of instance data blocks in the <b>PERF_MULTI_INSTANCES</b> block.
    uint dwInstances;
}

///Provides information about the <b>PERF_MULTI_COUNTERS</b> block that contains the structure. A
///<b>PERF_MULTI_COUNTERS</b> block indicates the performance counters for which results are provided as part of the
///PERF_COUNTER_HEADER block in multiple-counter query. The <b>PERF_MULTI_COUNTERS</b> block consists of a
///<b>PERF_MULTI_COUNTERS</b> structure followed by a sequence of <b>DWORD</b> values that specify performance counter
///identifiers.
struct PERF_MULTI_COUNTERS
{
    ///The total size of the <b>PERF_MULTI_COUNTERS</b> block, in bytes. This total size is the sum of the sizes of the
    ///<b>PERF_MULTI_COUNTERS</b> structure and all of the performance counter identifiers.
    uint dwSize;
    ///The number of performance counter identifiers that the <b>PERF_MULTI_COUNTERS</b> block contains.
    uint dwCounters;
}

///Contains information about the <b>PERF_COUNTER_DATA</b> block that contains the structure. A <b>PERF_COUNTER_DATA</b>
///block provides raw performance counter data, and consists of the following items in order: <ol> <li>A
///<b>PERF_COUNTER_DATA</b> structure.</li> <li>Raw performance counter data.</li> <li>Padding to make the total size of
///the block a multiple of eight bytes.</li> </ol>
struct PERF_COUNTER_DATA
{
    ///The size of the raw performance counter data that follows the <b>PERF_COUNTER_DATA</b> structure in the
    ///<b>PERF_COUNTER_DATA</b> block, in bytes.
    uint dwDataSize;
    ///The total size of the <b>PERF_COUNTER_DATA</b> block, which is the sum of the sizes opf the following items: <ul>
    ///<li>The <b>PERF_COUNTER_DATA</b> structure</li> <li>The raw performance counter data</li> <li>The padding that
    ///ensures that the size of the <b>PERF_COUNTER_DATA</b> block is a multiple of 8 bytes</li> </ul>
    uint dwSize;
}

///The <b>PDH_RAW_COUNTER</b> structure returns the data as it was collected from the counter provider. No translation,
///formatting, or other interpretation is performed on the data.
struct PDH_RAW_COUNTER
{
    ///Counter status that indicates if the counter value is valid. Check this member before using the data in a
    ///calculation or displaying its value. For a list of possible values, see Checking PDH Interface Return Values.
    uint     CStatus;
    ///Local time for when the data was collected, in FILETIME format.
    FILETIME TimeStamp;
    ///First raw counter value.
    long     FirstValue;
    ///Second raw counter value. Rate counters require two values in order to compute a displayable value.
    long     SecondValue;
    ///If the counter type contains the PERF_MULTI_COUNTER flag, this member contains the additional counter data used
    ///in the calculation. For example, the PERF_100NSEC_MULTI_TIMER counter type contains the PERF_MULTI_COUNTER flag.
    uint     MultiCount;
}

///The <b>PDH_RAW_COUNTER_ITEM</b> structure contains the instance name and raw value of a counter.
struct PDH_RAW_COUNTER_ITEM_A
{
    ///Pointer to a null-terminated string that specifies the instance name of the counter. The string is appended to
    ///the end of this structure.
    PSTR            szName;
    ///A PDH_RAW_COUNTER structure that contains the raw counter value of the instance.
    PDH_RAW_COUNTER RawValue;
}

///The <b>PDH_RAW_COUNTER_ITEM</b> structure contains the instance name and raw value of a counter.
struct PDH_RAW_COUNTER_ITEM_W
{
    ///Pointer to a null-terminated string that specifies the instance name of the counter. The string is appended to
    ///the end of this structure.
    PWSTR           szName;
    ///A PDH_RAW_COUNTER structure that contains the raw counter value of the instance.
    PDH_RAW_COUNTER RawValue;
}

///The <b>PDH_FMT_COUNTERVALUE</b> structure contains the computed value of the counter and its status.
struct PDH_FMT_COUNTERVALUE
{
    ///Counter status that indicates if the counter value is valid. Check this member before using the data in a
    ///calculation or displaying its value. For a list of possible values, see Checking PDH Interface Return Values.
    uint CStatus;
union
    {
        int          longValue;
        double       doubleValue;
        long         largeValue;
        const(PSTR)  AnsiStringValue;
        const(PWSTR) WideStringValue;
    }
}

///The <b>PDH_FMT_COUNTERVALUE_ITEM</b> structure contains the instance name and formatted value of a counter.
struct PDH_FMT_COUNTERVALUE_ITEM_A
{
    ///Pointer to a null-terminated string that specifies the instance name of the counter. The string is appended to
    ///the end of this structure.
    PSTR                 szName;
    ///A PDH_FMT_COUNTERVALUE structure that contains the counter value of the instance.
    PDH_FMT_COUNTERVALUE FmtValue;
}

///The <b>PDH_FMT_COUNTERVALUE_ITEM</b> structure contains the instance name and formatted value of a counter.
struct PDH_FMT_COUNTERVALUE_ITEM_W
{
    ///Pointer to a null-terminated string that specifies the instance name of the counter. The string is appended to
    ///the end of this structure.
    PWSTR                szName;
    ///A PDH_FMT_COUNTERVALUE structure that contains the counter value of the instance.
    PDH_FMT_COUNTERVALUE FmtValue;
}

///The <b>PDH_STATISTICS</b> structure contains the minimum, maximum, and mean values for an array of raw counters
///values.
struct PDH_STATISTICS
{
    ///Format of the data. The format is specified in the <i>dwFormat</i> when calling PdhComputeCounterStatistics.
    uint                 dwFormat;
    ///Number of values in the array.
    uint                 count;
    ///Minimum of the values.
    PDH_FMT_COUNTERVALUE min;
    ///Maximum of the values.
    PDH_FMT_COUNTERVALUE max;
    ///Mean of the values.
    PDH_FMT_COUNTERVALUE mean;
}

///The <b>PDH_COUNTER_PATH_ELEMENTS</b> structure contains the components of a counter path.
struct PDH_COUNTER_PATH_ELEMENTS_A
{
    ///Pointer to a null-terminated string that specifies the computer name.
    PSTR szMachineName;
    ///Pointer to a null-terminated string that specifies the object name.
    PSTR szObjectName;
    ///Pointer to a null-terminated string that specifies the instance name. Can contain a wildcard character.
    PSTR szInstanceName;
    ///Pointer to a null-terminated string that specifies the parent instance name. Can contain a wildcard character.
    PSTR szParentInstance;
    ///Index used to uniquely identify duplicate instance names.
    uint dwInstanceIndex;
    ///Pointer to a null-terminated string that specifies the counter name.
    PSTR szCounterName;
}

///The <b>PDH_COUNTER_PATH_ELEMENTS</b> structure contains the components of a counter path.
struct PDH_COUNTER_PATH_ELEMENTS_W
{
    ///Pointer to a null-terminated string that specifies the computer name.
    PWSTR szMachineName;
    ///Pointer to a null-terminated string that specifies the object name.
    PWSTR szObjectName;
    ///Pointer to a null-terminated string that specifies the instance name. Can contain a wildcard character.
    PWSTR szInstanceName;
    ///Pointer to a null-terminated string that specifies the parent instance name. Can contain a wildcard character.
    PWSTR szParentInstance;
    ///Index used to uniquely identify duplicate instance names.
    uint  dwInstanceIndex;
    ///Pointer to a null-terminated string that specifies the counter name.
    PWSTR szCounterName;
}

///The <b>PDH_DATA_ITEM_PATH_ELEMENTS</b> structure contains the path elements of a specific data item.
struct PDH_DATA_ITEM_PATH_ELEMENTS_A
{
    ///Pointer to a null-terminated string that specifies the name of the computer where the data item resides.
    PSTR szMachineName;
    ///GUID of the object where the data item resides.
    GUID ObjectGUID;
    ///Identifier of the data item.
    uint dwItemId;
    ///Pointer to a null-terminated string that specifies the name of the data item instance.
    PSTR szInstanceName;
}

///The <b>PDH_DATA_ITEM_PATH_ELEMENTS</b> structure contains the path elements of a specific data item.
struct PDH_DATA_ITEM_PATH_ELEMENTS_W
{
    ///Pointer to a null-terminated string that specifies the name of the computer where the data item resides.
    PWSTR szMachineName;
    ///GUID of the object where the data item resides.
    GUID  ObjectGUID;
    ///Identifier of the data item.
    uint  dwItemId;
    ///Pointer to a null-terminated string that specifies the name of the data item instance.
    PWSTR szInstanceName;
}

///The <b>PDH_COUNTER_INFO</b> structure contains information describing the properties of a counter. This information
///also includes the counter path.
struct PDH_COUNTER_INFO_A
{
    ///Size of the structure, including the appended strings, in bytes.
    uint    dwLength;
    ///Counter type. For a list of counter types, see the Counter Types section of the Windows Server 2003 Deployment
    ///Kit. The counter type constants are defined in Winperf.h.
    uint    dwType;
    ///Counter version information. Not used.
    uint    CVersion;
    ///Counter status that indicates if the counter value is valid. For a list of possible values, see Checking PDH
    ///Interface Return Values.
    uint    CStatus;
    ///Scale factor to use when computing the displayable value of the counter. The scale factor is a power of ten. The
    ///valid range of this parameter is PDH_MIN_SCALE (–7) (the returned value is the actual value times
    ///10<sup>–</sup>⁷) to PDH_MAX_SCALE (+7) (the returned value is the actual value times 10⁺⁷). A value of
    ///zero will set the scale to one, so that the actual value is returned
    int     lScale;
    ///Default scale factor as suggested by the counter's provider.
    int     lDefaultScale;
    ///The value passed in the <i>dwUserData</i> parameter when calling PdhAddCounter.
    size_t  dwUserData;
    ///The value passed in the <i>dwUserData</i> parameter when calling PdhOpenQuery.
    size_t  dwQueryUserData;
    ///<b>Null</b>-terminated string that specifies the full counter path. The string follows this structure in memory.
    PSTR    szFullPath;
union
    {
        PDH_DATA_ITEM_PATH_ELEMENTS_A DataItemPath;
        PDH_COUNTER_PATH_ELEMENTS_A CounterPath;
struct
        {
            PSTR szMachineName;
            PSTR szObjectName;
            PSTR szInstanceName;
            PSTR szParentInstance;
            uint dwInstanceIndex;
            PSTR szCounterName;
        }
    }
    ///Help text that describes the counter. Is <b>NULL</b> if the source is a log file.
    PSTR    szExplainText;
    ///Start of the string data that is appended to the structure.
    uint[1] DataBuffer;
}

///The <b>PDH_COUNTER_INFO</b> structure contains information describing the properties of a counter. This information
///also includes the counter path.
struct PDH_COUNTER_INFO_W
{
    ///Size of the structure, including the appended strings, in bytes.
    uint    dwLength;
    ///Counter type. For a list of counter types, see the Counter Types section of the Windows Server 2003 Deployment
    ///Kit. The counter type constants are defined in Winperf.h.
    uint    dwType;
    ///Counter version information. Not used.
    uint    CVersion;
    ///Counter status that indicates if the counter value is valid. For a list of possible values, see Checking PDH
    ///Interface Return Values.
    uint    CStatus;
    ///Scale factor to use when computing the displayable value of the counter. The scale factor is a power of ten. The
    ///valid range of this parameter is PDH_MIN_SCALE (–7) (the returned value is the actual value times
    ///10<sup>–</sup>⁷) to PDH_MAX_SCALE (+7) (the returned value is the actual value times 10⁺⁷). A value of
    ///zero will set the scale to one, so that the actual value is returned
    int     lScale;
    ///Default scale factor as suggested by the counter's provider.
    int     lDefaultScale;
    ///The value passed in the <i>dwUserData</i> parameter when calling PdhAddCounter.
    size_t  dwUserData;
    ///The value passed in the <i>dwUserData</i> parameter when calling PdhOpenQuery.
    size_t  dwQueryUserData;
    ///<b>Null</b>-terminated string that specifies the full counter path. The string follows this structure in memory.
    PWSTR   szFullPath;
union
    {
        PDH_DATA_ITEM_PATH_ELEMENTS_W DataItemPath;
        PDH_COUNTER_PATH_ELEMENTS_W CounterPath;
struct
        {
            PWSTR szMachineName;
            PWSTR szObjectName;
            PWSTR szInstanceName;
            PWSTR szParentInstance;
            uint  dwInstanceIndex;
            PWSTR szCounterName;
        }
    }
    ///Help text that describes the counter. Is <b>NULL</b> if the source is a log file.
    PWSTR   szExplainText;
    ///Start of the string data that is appended to the structure.
    uint[1] DataBuffer;
}

///The <b>PDH_TIME_INFO</b> structure contains information on time intervals as applied to the sampling of performance
///data.
struct PDH_TIME_INFO
{
    ///Starting time of the sample interval, in local FILETIME format.
    long StartTime;
    ///Ending time of the sample interval, in local FILETIME format.
    long EndTime;
    ///Number of samples collected during the interval.
    uint SampleCount;
}

///The <b>PDH_RAW_LOG_RECORD</b> structure contains information about a binary trace log file record.
struct PDH_RAW_LOG_RECORD
{
    ///Size of this structure, in bytes. The size includes this structure and the <b>RawBytes</b> appended to the end of
    ///this structure.
    uint     dwStructureSize;
    ///Type of record. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_BINARY"></a><a id="pdh_log_type_binary"></a><dl>
    ///<dt><b>PDH_LOG_TYPE_BINARY</b></dt> </dl> </td> <td width="60%"> A binary trace format record </td> </tr> <tr>
    ///<td width="40%"><a id="PDH_LOG_TYPE_CSV"></a><a id="pdh_log_type_csv"></a><dl> <dt><b>PDH_LOG_TYPE_CSV</b></dt>
    ///</dl> </td> <td width="60%"> A comma-separated-value format record </td> </tr> <tr> <td width="40%"><a
    ///id="PDH_LOG_TYPE_PERFMON"></a><a id="pdh_log_type_perfmon"></a><dl> <dt><b>PDH_LOG_TYPE_PERFMON</b></dt> </dl>
    ///</td> <td width="60%"> A Perfmon format record </td> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_SQL"></a><a
    ///id="pdh_log_type_sql"></a><dl> <dt><b>PDH_LOG_TYPE_SQL</b></dt> </dl> </td> <td width="60%"> A SQL format record
    ///</td> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_TSV"></a><a id="pdh_log_type_tsv"></a><dl>
    ///<dt><b>PDH_LOG_TYPE_TSV</b></dt> </dl> </td> <td width="60%"> A tab-separated-value format record </td> </tr>
    ///</table>
    uint     dwRecordType;
    ///Size of the <b>RawBytes</b> data.
    uint     dwItems;
    ///Binary record.
    ubyte[1] RawBytes;
}

struct PDH_LOG_SERVICE_QUERY_INFO_A
{
    uint dwSize;
    uint dwFlags;
    uint dwLogQuota;
    PSTR szLogFileCaption;
    PSTR szDefaultDir;
    PSTR szBaseFileName;
    uint dwFileType;
    uint dwReserved;
union
    {
struct
        {
            uint     PdlAutoNameInterval;
            uint     PdlAutoNameUnits;
            PSTR     PdlCommandFilename;
            PSTR     PdlCounterList;
            uint     PdlAutoNameFormat;
            uint     PdlSampleInterval;
            FILETIME PdlLogStartTime;
            FILETIME PdlLogEndTime;
        }
struct
        {
            uint TlNumberOfBuffers;
            uint TlMinimumBuffers;
            uint TlMaximumBuffers;
            uint TlFreeBuffers;
            uint TlBufferSize;
            uint TlEventsLost;
            uint TlLoggerThreadId;
            uint TlBuffersWritten;
            uint TlLogHandle;
            PSTR TlLogFileName;
        }
    }
}

struct PDH_LOG_SERVICE_QUERY_INFO_W
{
    uint  dwSize;
    uint  dwFlags;
    uint  dwLogQuota;
    PWSTR szLogFileCaption;
    PWSTR szDefaultDir;
    PWSTR szBaseFileName;
    uint  dwFileType;
    uint  dwReserved;
union
    {
struct
        {
            uint     PdlAutoNameInterval;
            uint     PdlAutoNameUnits;
            PWSTR    PdlCommandFilename;
            PWSTR    PdlCounterList;
            uint     PdlAutoNameFormat;
            uint     PdlSampleInterval;
            FILETIME PdlLogStartTime;
            FILETIME PdlLogEndTime;
        }
struct
        {
            uint  TlNumberOfBuffers;
            uint  TlMinimumBuffers;
            uint  TlMaximumBuffers;
            uint  TlFreeBuffers;
            uint  TlBufferSize;
            uint  TlEventsLost;
            uint  TlLoggerThreadId;
            uint  TlBuffersWritten;
            uint  TlLogHandle;
            PWSTR TlLogFileName;
        }
    }
}

///The <b>PDH_BROWSE_DLG_CONFIG_H</b> structure is used by the PdhBrowseCountersH function to configure the <b>Browse
///Performance Counters</b> dialog box.
struct PDH_BROWSE_DLG_CONFIG_HW
{
    uint                _bitfield91;
    ///Handle of the window to own the dialog. If <b>NULL</b>, the owner is the desktop.
    HWND                hWndOwner;
    ///Handle to a data source returned by the PdhBindInputDataSource function.
    ptrdiff_t           hDataSource;
    ///Pointer to a MULTI_SZ that contains the selected counter paths. If <b>bInitializePath</b> is <b>TRUE</b>, you can
    ///use this member to specify a counter path whose components are used to highlight entries in computer, object,
    ///counter, and instance lists when the dialog is first displayed.
    PWSTR               szReturnPathBuffer;
    ///Size of the <b>szReturnPathBuffer</b> buffer, in <b>TCHARs</b>. If the callback function reallocates a new
    ///buffer, it must also update this value.
    uint                cchReturnPathLength;
    ///Pointer to the callback function that processes the user's selection. For more information, see
    ///CounterPathCallBack.
    CounterPathCallBack pCallBack;
    ///Caller-defined value that is passed to the callback function.
    size_t              dwCallBackArg;
    ///On entry to the callback function, this member contains the status of the path buffer. On exit, the callback
    ///function sets the status value resulting from processing. If the buffer is too small to load the current
    ///selection, the dialog sets this value to PDH_MORE_DATA. If this value is ERROR_SUCCESS, then the
    ///<b>szReturnPathBuffer</b> member contains a valid counter path or counter path list. If the callback function
    ///reallocates a new buffer, it should set this member to PDH_RETRY so that the dialog will try to load the buffer
    ///with the selected paths and call the callback function again. If some other error occurred, then the callback
    ///function should return the appropriate PDH error status value.
    int                 CallBackStatus;
    ///Default detail level to show in the <b>Detail level</b> list if <b>bHideDetailBox</b> is <b>FALSE</b>. If
    ///<b>bHideDetailBox</b> is <b>TRUE</b>, the dialog uses this value to filter the displayed performance counters and
    ///objects. You can specify one of the following values: <table> <tr> <th>Detail level</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl>
    ///<dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> A novice user can understand the counter data.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl>
    ///<dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter data is provided for advanced
    ///users. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a id="perf_detail_expert"></a><dl>
    ///<dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> The counter data is provided for expert users.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a id="perf_detail_wizard"></a><dl>
    ///<dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> The counter data is provided for system
    ///designers. </td> </tr> </table>
    uint                dwDefaultDetailLevel;
    ///Pointer to a <b>null</b>-terminated string that specifies the optional caption to display in the caption bar of
    ///the dialog box. If this member is <b>NULL</b>, the caption will be <b>Browse Performance Counters</b>.
    PWSTR               szDialogBoxCaption;
}

///The <b>PDH_BROWSE_DLG_CONFIG_H</b> structure is used by the PdhBrowseCountersH function to configure the <b>Browse
///Performance Counters</b> dialog box.
struct PDH_BROWSE_DLG_CONFIG_HA
{
    uint                _bitfield92;
    ///Handle of the window to own the dialog. If <b>NULL</b>, the owner is the desktop.
    HWND                hWndOwner;
    ///Handle to a data source returned by the PdhBindInputDataSource function.
    ptrdiff_t           hDataSource;
    ///Pointer to a MULTI_SZ that contains the selected counter paths. If <b>bInitializePath</b> is <b>TRUE</b>, you can
    ///use this member to specify a counter path whose components are used to highlight entries in computer, object,
    ///counter, and instance lists when the dialog is first displayed.
    PSTR                szReturnPathBuffer;
    ///Size of the <b>szReturnPathBuffer</b> buffer, in <b>TCHARs</b>. If the callback function reallocates a new
    ///buffer, it must also update this value.
    uint                cchReturnPathLength;
    ///Pointer to the callback function that processes the user's selection. For more information, see
    ///CounterPathCallBack.
    CounterPathCallBack pCallBack;
    ///Caller-defined value that is passed to the callback function.
    size_t              dwCallBackArg;
    ///On entry to the callback function, this member contains the status of the path buffer. On exit, the callback
    ///function sets the status value resulting from processing. If the buffer is too small to load the current
    ///selection, the dialog sets this value to PDH_MORE_DATA. If this value is ERROR_SUCCESS, then the
    ///<b>szReturnPathBuffer</b> member contains a valid counter path or counter path list. If the callback function
    ///reallocates a new buffer, it should set this member to PDH_RETRY so that the dialog will try to load the buffer
    ///with the selected paths and call the callback function again. If some other error occurred, then the callback
    ///function should return the appropriate PDH error status value.
    int                 CallBackStatus;
    ///Default detail level to show in the <b>Detail level</b> list if <b>bHideDetailBox</b> is <b>FALSE</b>. If
    ///<b>bHideDetailBox</b> is <b>TRUE</b>, the dialog uses this value to filter the displayed performance counters and
    ///objects. You can specify one of the following values: <table> <tr> <th>Detail level</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl>
    ///<dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> A novice user can understand the counter data.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl>
    ///<dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter data is provided for advanced
    ///users. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a id="perf_detail_expert"></a><dl>
    ///<dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> The counter data is provided for expert users.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a id="perf_detail_wizard"></a><dl>
    ///<dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> The counter data is provided for system
    ///designers. </td> </tr> </table>
    uint                dwDefaultDetailLevel;
    ///Pointer to a <b>null</b>-terminated string that specifies the optional caption to display in the caption bar of
    ///the dialog box. If this member is <b>NULL</b>, the caption will be <b>Browse Performance Counters</b>.
    PSTR                szDialogBoxCaption;
}

///The <b>PDH_BROWSE_DLG_CONFIG</b> structure is used by the PdhBrowseCounters function to configure the <b>Browse
///Performance Counters</b> dialog box.
struct PDH_BROWSE_DLG_CONFIG_W
{
    uint                _bitfield93;
    ///Handle of the window to own the dialog. If <b>NULL</b>, the owner is the desktop.
    HWND                hWndOwner;
    ///Pointer to a <b>null</b>-terminated string that specifies the name of the log file from which the list of
    ///counters is retrieved. If <b>NULL</b>, the list of counters is retrieved from the local computer (or remote
    ///computer if specified).
    PWSTR               szDataSource;
    ///Pointer to a MULTI_SZ that contains the selected counter paths. If <b>bInitializePath</b> is <b>TRUE</b>, you can
    ///use this member to specify a counter path whose components are used to highlight entries in computer, object,
    ///counter, and instance lists when the dialog is first displayed.
    PWSTR               szReturnPathBuffer;
    ///Size of the <b>szReturnPathBuffer</b> buffer, in <b>TCHARs</b>. If the callback function reallocates a new
    ///buffer, it must also update this value.
    uint                cchReturnPathLength;
    ///Pointer to the callback function that processes the user's selection. For more information, see
    ///CounterPathCallBack.
    CounterPathCallBack pCallBack;
    ///Caller-defined value that is passed to the callback function.
    size_t              dwCallBackArg;
    ///On entry to the callback function, this member contains the status of the path buffer. On exit, the callback
    ///function sets the status value resulting from processing. If the buffer is too small to load the current
    ///selection, the dialog sets this value to PDH_MORE_DATA. If this value is ERROR_SUCCESS, then the
    ///<b>szReturnPathBuffer</b> member contains a valid counter path or counter path list. If the callback function
    ///reallocates a new buffer, it should set this member to PDH_RETRY so that the dialog will try to load the buffer
    ///with the selected paths and call the callback function again. If some other error occurred, then the callback
    ///function should return the appropriate PDH error status value.
    int                 CallBackStatus;
    ///Default detail level to show in the <b>Detail level</b> list if <b>bHideDetailBox</b> is <b>FALSE</b>. If
    ///<b>bHideDetailBox</b> is <b>TRUE</b>, the dialog uses this value to filter the displayed performance counters and
    ///objects. You can specify one of the following values: <table> <tr> <th>Detail level</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl>
    ///<dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> A novice user can understand the counter data.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl>
    ///<dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter data is provided for advanced
    ///users. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a id="perf_detail_expert"></a><dl>
    ///<dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> The counter data is provided for expert users.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a id="perf_detail_wizard"></a><dl>
    ///<dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> The counter data is provided for system
    ///designers. </td> </tr> </table>
    uint                dwDefaultDetailLevel;
    ///Pointer to a <b>null</b>-terminated string that specifies the optional caption to display in the caption bar of
    ///the dialog box. If this member is <b>NULL</b>, the caption will be <b>Browse Performance Counters</b>.
    PWSTR               szDialogBoxCaption;
}

///The <b>PDH_BROWSE_DLG_CONFIG</b> structure is used by the PdhBrowseCounters function to configure the <b>Browse
///Performance Counters</b> dialog box.
struct PDH_BROWSE_DLG_CONFIG_A
{
    uint                _bitfield94;
    ///Handle of the window to own the dialog. If <b>NULL</b>, the owner is the desktop.
    HWND                hWndOwner;
    ///Pointer to a <b>null</b>-terminated string that specifies the name of the log file from which the list of
    ///counters is retrieved. If <b>NULL</b>, the list of counters is retrieved from the local computer (or remote
    ///computer if specified).
    PSTR                szDataSource;
    ///Pointer to a MULTI_SZ that contains the selected counter paths. If <b>bInitializePath</b> is <b>TRUE</b>, you can
    ///use this member to specify a counter path whose components are used to highlight entries in computer, object,
    ///counter, and instance lists when the dialog is first displayed.
    PSTR                szReturnPathBuffer;
    ///Size of the <b>szReturnPathBuffer</b> buffer, in <b>TCHARs</b>. If the callback function reallocates a new
    ///buffer, it must also update this value.
    uint                cchReturnPathLength;
    ///Pointer to the callback function that processes the user's selection. For more information, see
    ///CounterPathCallBack.
    CounterPathCallBack pCallBack;
    ///Caller-defined value that is passed to the callback function.
    size_t              dwCallBackArg;
    ///On entry to the callback function, this member contains the status of the path buffer. On exit, the callback
    ///function sets the status value resulting from processing. If the buffer is too small to load the current
    ///selection, the dialog sets this value to PDH_MORE_DATA. If this value is ERROR_SUCCESS, then the
    ///<b>szReturnPathBuffer</b> member contains a valid counter path or counter path list. If the callback function
    ///reallocates a new buffer, it should set this member to PDH_RETRY so that the dialog will try to load the buffer
    ///with the selected paths and call the callback function again. If some other error occurred, then the callback
    ///function should return the appropriate PDH error status value.
    int                 CallBackStatus;
    ///Default detail level to show in the <b>Detail level</b> list if <b>bHideDetailBox</b> is <b>FALSE</b>. If
    ///<b>bHideDetailBox</b> is <b>TRUE</b>, the dialog uses this value to filter the displayed performance counters and
    ///objects. You can specify one of the following values: <table> <tr> <th>Detail level</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a id="perf_detail_novice"></a><dl>
    ///<dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> A novice user can understand the counter data.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a id="perf_detail_advanced"></a><dl>
    ///<dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> The counter data is provided for advanced
    ///users. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a id="perf_detail_expert"></a><dl>
    ///<dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> The counter data is provided for expert users.
    ///</td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a id="perf_detail_wizard"></a><dl>
    ///<dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> The counter data is provided for system
    ///designers. </td> </tr> </table>
    uint                dwDefaultDetailLevel;
    ///Pointer to a <b>null</b>-terminated string that specifies the optional caption to display in the caption bar of
    ///the dialog box. If this member is <b>NULL</b>, the caption will be <b>Browse Performance Counters</b>.
    PSTR                szDialogBoxCaption;
}

// Functions

///Loads onto the computer the performance objects and counters defined in the specified initialization file.
///Params:
///    lpCommandLine = Null-terminated string that consists of one or more arbitrary letters, a space, and then the name of the
///                    initialization (.ini) file. The name can include the path to the initialization file. The function uses only the
///                    initialization file; the first argument is discarded. For example, to load an initialization file called
///                    "myfile.ini", the <i>commandLine</i> string could be "xx myfile.ini". The letters before the space (here "xx")
///                    are discarded, and the second part, following the space, is interpreted as the initialization file specification.
///    bQuietModeArg = Set to <b>TRUE</b> to prevent the function from displaying the output from the <b>Lodctr</b> tool; otherwise,
///                    <b>FALSE</b>. This parameter has meaning only if the application is run from a command prompt.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is one of the system
///    error codes.
///    
@DllImport("loadperf")
uint LoadPerfCounterTextStringsA(PSTR lpCommandLine, BOOL bQuietModeArg);

///Loads onto the computer the performance objects and counters defined in the specified initialization file.
///Params:
///    lpCommandLine = Null-terminated string that consists of one or more arbitrary letters, a space, and then the name of the
///                    initialization (.ini) file. The name can include the path to the initialization file. The function uses only the
///                    initialization file; the first argument is discarded. For example, to load an initialization file called
///                    "myfile.ini", the <i>commandLine</i> string could be "xx myfile.ini". The letters before the space (here "xx")
///                    are discarded, and the second part, following the space, is interpreted as the initialization file specification.
///    bQuietModeArg = Set to <b>TRUE</b> to prevent the function from displaying the output from the <b>Lodctr</b> tool; otherwise,
///                    <b>FALSE</b>. This parameter has meaning only if the application is run from a command prompt.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is one of the system
///    error codes.
///    
@DllImport("loadperf")
uint LoadPerfCounterTextStringsW(PWSTR lpCommandLine, BOOL bQuietModeArg);

///Unloads performance objects and counters from the computer for the specified application.
///Params:
///    lpCommandLine = Null-terminated string that consists of one or more arbitrary letters, a space, and then the name of the
///                    application. The name of the application must match the <b>drivername</b> key value found in the initialization
///                    (.ini) file used to load the text strings.
///    bQuietModeArg = Set to <b>TRUE</b> to prevent the function from displaying the output from the <b>Unlodctr</b> tool; otherwise,
///                    <b>FALSE</b>. This parameter has meaning only if the application is run from a command prompt.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes.
///    
@DllImport("loadperf")
uint UnloadPerfCounterTextStringsW(PWSTR lpCommandLine, BOOL bQuietModeArg);

///Unloads performance objects and counters from the computer for the specified application.
///Params:
///    lpCommandLine = Null-terminated string that consists of one or more arbitrary letters, a space, and then the name of the
///                    application. The name of the application must match the <b>drivername</b> key value found in the initialization
///                    (.ini) file used to load the text strings.
///    bQuietModeArg = Set to <b>TRUE</b> to prevent the function from displaying the output from the <b>Unlodctr</b> tool; otherwise,
///                    <b>FALSE</b>. This parameter has meaning only if the application is run from a command prompt.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes.
///    
@DllImport("loadperf")
uint UnloadPerfCounterTextStringsA(PSTR lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf")
uint UpdatePerfNameFilesA(const(PSTR) szNewCtrFilePath, const(PSTR) szNewHlpFilePath, PSTR szLanguageID, 
                          size_t dwFlags);

@DllImport("loadperf")
uint UpdatePerfNameFilesW(const(PWSTR) szNewCtrFilePath, const(PWSTR) szNewHlpFilePath, PWSTR szLanguageID, 
                          size_t dwFlags);

@DllImport("loadperf")
uint SetServiceAsTrustedA(const(PSTR) szReserved, const(PSTR) szServiceName);

@DllImport("loadperf")
uint SetServiceAsTrustedW(const(PWSTR) szReserved, const(PWSTR) szServiceName);

@DllImport("loadperf")
uint BackupPerfRegistryToFileW(const(PWSTR) szFileName, const(PWSTR) szCommentString);

@DllImport("loadperf")
uint RestorePerfRegistryFromFileW(const(PWSTR) szFileName, const(PWSTR) szLangId);

///Registers the provider.
///Params:
///    ProviderGuid = GUID that uniquely identifies the provider. The <b>providerGuid</b> attribute of the provider element specifies
///                   the GUID.
///    ControlCallback = ControlCallback function that PERFLIB calls to notify you of consumer requests, such as a request to add or
///                      remove counters from the query. This parameter is set if the <b>callback</b> attribute of the <b>counters</b>
///                      element is "custom"; otherwise, <b>NULL</b>.
///    phProvider = Handle to the provider. You must call PerfStopProvider to release resources associated with the handle.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfStartProvider(GUID* ProviderGuid, PERFLIBREQUEST ControlCallback, PerfProviderHandle* phProvider);

///Registers the provider.
///Params:
///    ProviderGuid = GUID that uniquely identifies the provider. The <b>providerGuid</b> attribute of the provider element specifies
///                   the GUID.
///    ProviderContext = A PERF_PROVIDER_CONTEXT structure that contains pointers to the control callback, memory management routines, and
///                      context information.
///    Provider = Handle to the provider. You must call PerfStopProvider to release resources associated with the handle.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfStartProviderEx(GUID* ProviderGuid, PERF_PROVIDER_CONTEXT* ProviderContext, PerfProviderHandle* Provider);

///Removes the provider's registration from the list of registered providers and frees all resources associated with the
///provider.
///Params:
///    ProviderHandle = Handle to the provider.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfStopProvider(PerfProviderHandle ProviderHandle);

///Specifies the layout of a particular counter set.
///Params:
///    ProviderHandle = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///                     variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///                     function returns the handle.
///    Template = Buffer that contains the counter set information. For details, see PERF_COUNTERSET_INFO.
///    TemplateSize = Size, in bytes, of the <i>pTemplate</i> buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfSetCounterSetInfo(HANDLE ProviderHandle, PERF_COUNTERSET_INFO* Template, uint TemplateSize);

///Creates an instance of the specified counter set. Providers use this function.
///Params:
///    ProviderHandle = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///                     variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///                     function returns the handle.
///    CounterSetGuid = GUID that uniquely identifies the counter set that you want to create an instance of. This is the same GUID
///                     specified in the <b>guid</b> attribute of the counterSet element. Use the GUID variable that the CTRPP tool
///                     generated for you. For the name of the variable, see the <b>symbol</b> attribute of the <b>counterSet</b>
///                     element. <b>Windows Vista: </b>The GUID variable is not available.
///    Name = <b>Null</b>-terminated Unicode string that contains a unique name for this instance.
///    Id = Unique identifier for this instance of the counter set. The identifier can be a serial number that you increment
///         for each new instance.
///Returns:
///    A PERF_COUNTERSET_INSTANCE structure that contains the instance of the counter set or <b>NULL</b> if PERFLIB
///    could not create the instance. Cache this pointer to use in later calls instead of calling PerfQueryInstance to
///    retrieve the pointer to the instance. This function returns <b>NULL</b> if an error occurred. To determine the
///    error that occurred, call GetLastError.
///    
@DllImport("ADVAPI32")
PERF_COUNTERSET_INSTANCE* PerfCreateInstance(PerfProviderHandle ProviderHandle, GUID* CounterSetGuid, 
                                             const(PWSTR) Name, uint Id);

///Deletes an instance of the counter set created by the PerfCreateInstance function. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    InstanceBlock = A PERF_COUNTERSET_INSTANCE structure that contains the instance of the counter set to delete.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfDeleteInstance(PerfProviderHandle Provider, PERF_COUNTERSET_INSTANCE* InstanceBlock);

///Retrieves a pointer to the specified counter set instance. Providers use this function.
///Params:
///    ProviderHandle = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///                     variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///                     function returns the handle.
///    CounterSetGuid = GUID that uniquely identifies the counter set that you want to query. This is the same GUID specified in the
///                     <b>guid</b> attribute of the counterSet element. Use the GUID variable that the CTRPP tool generated for you. For
///                     the name of the variable, see the <b>symbol</b> attribute of the <b>counterSet</b> element. <b>Windows Vista:
///                     </b>The GUID variable is not available.
///    Name = <b>Null</b>-terminated Unicode string that contains the name of counter set instance that you want to retrieve.
///    Id = Unique identifier of the counter set instance that you want to retrieve.
///Returns:
///    A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance or <b>NULL</b> if the instance does
///    not exist. This function returns <b>NULL</b> if an error occurred. To determine the error that occurred, call
///    GetLastError.
///    
@DllImport("ADVAPI32")
PERF_COUNTERSET_INSTANCE* PerfQueryInstance(HANDLE ProviderHandle, GUID* CounterSetGuid, const(PWSTR) Name, 
                                            uint Id);

///Updates the value of a counter whose value is a pointer to the actual data. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    Instance = A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance. The PerfCreateInstance function
///               returns this pointer.
///    CounterId = Identifier that uniquely identifies the counter to update in the instance block. The identifier is defined in the
///                <b>id</b> attribute of the counter element and must match the <b>CounterId</b> member of one of the
///                PERF_COUNTER_INFO structures in the instance block. Use the counter ID constant that the CTRPP tool generated for
///                you. For the name of the constant, see the <b>symbol</b> attribute of the <b>counter</b> element. <b>Windows
///                Vista: </b>The counter ID constant is not available.
///    Address = Pointer to the actual counter data. If <b>NULL</b>, the consumer receives ERROR_NO_DATA. To indicate that the
///              counter data is accessed by reference, the counter declaration in the manifest must include a counterAttribute
///              element whose <b>name</b> attribute is set to "reference".
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfSetCounterRefValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, void* Address);

///Updates the value of a counter whose value is a 4-byte unsigned integer. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    Instance = A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance. The PerfCreateInstance function
///               returns this pointer.
///    CounterId = Identifier that uniquely identifies the counter to update in the instance block. The identifier is defined in the
///                <b>id</b> attribute of the counter element and must match the <b>CounterId</b> member of one of the
///                PERF_COUNTER_INFO structures in the instance block. Use the counter ID constant that the CTRPP tool generated for
///                you. For the name of the constant, see the <b>symbol</b> attribute of the <b>counter</b> element. <b>Windows
///                Vista: </b>The counter ID constant is not available.
///    Value = New 4-byte counter value.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfSetULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, uint Value);

///Updates the value of a counter whose value is an 8-byte unsigned integer. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    Instance = A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance. The PerfCreateInstance function
///               returns this pointer.
///    CounterId = Identifier that uniquely identifies the counter to update in the instance block. The identifier is defined in the
///                <b>id</b> attribute of the counter element and must match the <b>CounterId</b> member of one of the
///                PERF_COUNTER_INFO structures in the instance block. Use the counter ID constant that the CTRPP tool generated for
///                you. For the name of the constant, see the <b>symbol</b> attribute of the <b>counter</b> element. <b>Windows
///                Vista: </b>The counter ID constant is not available.
///    Value = New 8-byte counter value.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfSetULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, ulong Value);

///Increments the value of a counter whose value is a 4-byte unsigned integer. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    Instance = A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance. The PerfCreateInstance function
///               returns this pointer.
///    CounterId = Identifier that uniquely identifies the counter to update in the instance block. The identifier is defined in the
///                <b>id</b> attribute of the counter element and must match the <b>CounterId</b> member of one of the
///                PERF_COUNTER_INFO structures in the instance block. Use the counter ID constant that the CTRPP tool generated for
///                you. For the name of the constant, see the <b>symbol</b> attribute of the <b>counter</b> element. <b>Windows
///                Vista: </b>The counter ID constant is not available.
///    Value = Value by which to increment the counter.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfIncrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                    uint Value);

///Increments the value of a counter whose value is an 8-byte unsigned integer. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    Instance = A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance. The PerfCreateInstance function
///               returns this pointer.
///    CounterId = Identifier that uniquely identifies the counter to update in the instance block. The identifier is defined in the
///                <b>id</b> attribute of the counter element and must match the <b>CounterId</b> member of one of the
///                PERF_COUNTER_INFO structures in the instance block. Use the counter ID constant that the CTRPP tool generated for
///                you. For the name of the constant, see the <b>symbol</b> attribute of the <b>counter</b> element. <b>Windows
///                Vista: </b>The counter ID constant is not available.
///    Value = Value by which to increment the counter.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfIncrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                        ulong Value);

///Decrements the value of a counter whose value is a 4-byte unsigned integer. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    Instance = A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance. The PerfCreateInstance function
///               returns this pointer.
///    CounterId = Identifier that uniquely identifies the counter to update in the instance block. The identifier is defined in the
///                <b>id</b> attribute of the counter element and must match the <b>CounterId</b> member of one of the
///                PERF_COUNTER_INFO structures in the instance block. Use the counter ID constant that the CTRPP tool generated for
///                you. For the name of the constant, see the <b>symbol</b> attribute of the <b>counter</b> element. <b>Windows
///                Vista: </b>The counter ID constant is not available.
///    Value = Value by which to decrement the counter.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfDecrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                    uint Value);

///Decrements the value of a counter whose value is an 8-byte unsigned integer. Providers use this function.
///Params:
///    Provider = The handle of the provider. Use the handle variable that the CTRPP tool generated for you. For the name of the
///               variable, see the <b>symbol</b> attribute of the provider element. <b>Windows Vista: </b>The PerfStartProvider
///               function returns the handle.
///    Instance = A PERF_COUNTERSET_INSTANCE structure that contains the counter set instance. The PerfCreateInstance function
///               returns this pointer.
///    CounterId = Identifier that uniquely identifies the counter to update in the instance block. The identifier is defined in the
///                <b>id</b> attribute of the counter element and must match the <b>CounterId</b> member of one of the
///                PERF_COUNTER_INFO structures in the instance block. Use the counter ID constant that the CTRPP tool generated for
///                you. For the name of the constant, see the <b>symbol</b> attribute of the <b>counter</b> element. <b>Windows
///                Vista: </b>The counter ID constant is not available.
///    Value = Value by which to decrement the counter.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfDecrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                        ulong Value);

///Gets the counter set identifiers of the counter sets that are registered on the specified system. Counter set
///identifiers are globally unique identifiers (GUIDs).
///Params:
///    szMachine = The name of the machine for which to get the counter set identifiers. If NULL, the function retrieves the counter
///                set identifiers for the local machine.
///    pCounterSetIds = A pointer to a buffer that has enough space to receive the number of GUIDs that the <i>cCounterSetIds</i>
///                     parameter specifies. May be NULL if <i>cCounterSetIds</i> is 0.
///    cCounterSetIds = The size of the buffer that the <i>pCounterSetIds</i> parameter specifies, measured in GUIDs.
///    pcCounterSetIdsActual = The size of the buffer actually required to get the counter set identifiers. The meaning depends on the value
///                            that the function returns. <table> <tr> <th>Function Return Value</th> <th>Meaning of
///                            <i>pcCounterSetIdsActual</i></th> </tr> <tr> <td><b>ERROR_SUCCESS</b></td> <td>The number of GUIDs that the
///                            function stored in the buffer that <i>pCounterSetIds</i> specified.</td> </tr> <tr> <td><b>
///                            ERROR_NOT_ENOUGH_MEMORY</b></td> <td>The size (in GUIDs) of the buffer required. Enlarge the buffer to the
///                            required size and call the function again. </td> </tr> <tr> <td>Other</td> <td>The value is undefined and should
///                            not be used.</td> </tr> </table>
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function successfully stored all of the content
///    set identifiers in the buffer that <i>pCounterSetIds</i> specified. The value that <i>pcCounterSetIdsActual</i>
///    points to indicates the number of counter set identifiers actually stored in the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The buffer that
///    <i>pCounterSetIds</i> specified was not large enough to store all of the counter set identifiers for the counter
///    sets on the specified system. The value that <i>pcCounterSetIdsActual</i> points to indicates the size of the
///    buffer required to store all of the counter set identifiers. Enlarge the buffer to the required size and call the
///    function again. </td> </tr> </table> For other types of failures, the return value is a system error code.
///    
@DllImport("ADVAPI32")
uint PerfEnumerateCounterSet(const(PWSTR) szMachine, GUID* pCounterSetIds, uint cCounterSetIds, 
                             uint* pcCounterSetIdsActual);

///Gets the names and identifiers of the active instances of a counter set on the specified system.
///Params:
///    szMachine = The name of the machine for which to get the information about the active instances of the counter set that the
///                <i>pCounterSet</i> parameter specifies. If NULL, the function retrieves information about the active instances of
///                the specified counter set for the local machine.
///    pCounterSetId = The counter set identifier of the counter set for which you want to get the information about of the active
///                    instances.
///    pInstances = Pointer to a buffer that is large enough to receive the amount of data that the <i>cbInstances</i> parameter
///                 specifies. May be NULL if <i>cbInstances</i> is 0.
///    cbInstances = The size of the buffer that the <i>pInstances</i> parameter specifies, in bytes.
///    pcbInstancesActual = The size of the buffer actually required to get the information about of the active instances. The meaning
///                         depends on the value that the function returns. <table> <tr> <th>Function Return Value</th> <th>Meaning of
///                         <i>pcbInstancesActual</i></th> </tr> <tr> <td><b>ERROR_SUCCESS</b></td> <td>The number of bytes of information
///                         about the active instances of the specified counter set that the function stored in the buffer that
///                         <i>pInstances</i> specified.</td> </tr> <tr> <td><b> ERROR_NOT_ENOUGH_MEMORY</b></td> <td>The size of the buffer
///                         required to store the information about the active instances of the counter set on the specified machine, in
///                         bytes. Enlarge the buffer to the required size and call the function again. </td> </tr> <tr> <td>Other</td>
///                         <td>The value is undefined and should not be used.</td> </tr> </table>
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function successfully stored all of the
///    information about the active instances of the counter set in the buffer that <i>pInstances</i> specified. The
///    value that <i>pcbInstancesActual</i> points to indicates amount of information actually stored in the buffer, in
///    bytes. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> The buffer that <i>pInstances</i> specified was not large enough to store all of the information
///    about the active instances of the counter set. The value that <i>pcbInstancesActual</i> points to indicates the
///    size of the buffer required to store all of the information. Enlarge the buffer to the required size and call the
///    function again. </td> </tr> </table> For other types of failures, the return value is a system error code.
///    
@DllImport("ADVAPI32")
uint PerfEnumerateCounterSetInstances(const(PWSTR) szMachine, GUID* pCounterSetId, 
                                      PERF_INSTANCE_HEADER* pInstances, uint cbInstances, uint* pcbInstancesActual);

///Gets information about a counter set on the specified system.
///Params:
///    szMachine = The name of the machine for which to get the information about the counter set that the <i>pCounterSet</i>
///                parameter specifies. If NULL, the function retrieves information about the specified counter set for the local
///                machine.
///    pCounterSetId = The counter set identifier of the counter set for which you want to get information.
///    requestCode = The type of information that you want to get about the counter set. See PerfRegInfoType for a list of possible
///                  values.
///    requestLangId = The preferred locale identifier for the strings that contain the requested information if <i>requestCode</i> is
///                    <b>PERF_REG_COUNTERSET_NAME_STRING</b>, <b>PERF_REG_COUNTERSET_HELP_STRING</b>,
///                    <b>PERF_REG_COUNTER_NAME_STRINGS</b>, or <b>PERF_REG_COUNTER_HELP_STRINGS</b>. The counter identifier of the
///                    counter for which you want data, if <i>requestCode</i> is <b>PERF_REG_COUNTER_STRUCT</b>. Set to 0 for all other
///                    values of <i>requestCode</i>.
///    pbRegInfo = Pointer to a buffer that is large enough to receive the amount of data that the <i>cbRegInfo</i> parameter
///                specifies, in bytes. May be NULL if <i>cbRegInfo</i> is 0.
///    cbRegInfo = The size of the buffer that the <i>pbRegInfo</i> parameter specifies, in bytes.
///    pcbRegInfoActual = The size of the buffer actually required to get the information about the counter set. The meaning depends on the
///                       value that the function returns. <table> <tr> <th>Function Return Value</th> <th>Meaning of
///                       <i>pcbRegInfoActual</i></th> </tr> <tr> <td><b>ERROR_SUCCESS</b></td> <td>The number of bytes of information
///                       about the specified counter set that the function stored in the buffer that <i>pbRegInfo</i> specified.</td>
///                       </tr> <tr> <td><b> ERROR_NOT_ENOUGH_MEMORY</b></td> <td>The size of the buffer required to store the information
///                       about the counter set on the specified machine, in bytes. Enlarge the buffer to the required size and call the
///                       function again. </td> </tr> <tr> <td>Other</td> <td>The value is undefined and should not be used.</td> </tr>
///                       </table>
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function successfully stored all of the
///    information about the counter set in the buffer that <i>pbRegInfo</i> specified. The value that
///    <i>pcbRegInfoActual</i> points to indicates amount of information actually stored in the buffer, in bytes. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The buffer
///    that <i>pbRegInfo</i> specified was not large enough to store all of the information about the counter set. The
///    value that <i>pcbRegInfoActual</i> points to indicates the size of the buffer required to store all of the
///    information. Enlarge the buffer to the required size and call the function again. </td> </tr> </table> For other
///    types of failures, the return value is a system error code.
///    
@DllImport("ADVAPI32")
uint PerfQueryCounterSetRegistrationInfo(const(PWSTR) szMachine, GUID* pCounterSetId, PerfRegInfoType requestCode, 
                                         uint requestLangId, ubyte* pbRegInfo, uint cbRegInfo, 
                                         uint* pcbRegInfoActual);

///Creates a handle that references a query on the specified system. A query is a list of counter specifications.
///Params:
///    szMachine = The name of the machine for which you want to get the query handle.
///    phQuery = The handle to the query. Call PerfCloseQueryHandle to close ths handle when you no longer need it.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfOpenQueryHandle(const(PWSTR) szMachine, PerfQueryHandle* phQuery);

///Closes a query handle that you opened by calling PerfOpenQueryHandle.
///Params:
///    hQuery = A handle to the query that you want to close
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfCloseQueryHandle(HANDLE hQuery);

///Gets the counter specifications in the specified query.
///Params:
///    hQuery = A handle to the query for which you want to get the counter specifications
///    pCounters = Pointer to a buffer that is large enough to hold the amount of data that the <i>cbCounters</i> parameter
///                specifies, in bytes. May be NULL if <i>cbCounters</i> is 0.
///    cbCounters = The size of the <i>pCounters</i> buffer, in bytes.
///    pcbCountersActual = The size of the buffer actually required to get the counter specifications. The meaning depends on the value that
///                        the function returns. <table> <tr> <th>Function Return Value</th> <th>Meaning of <i>pcbCountersActual</i></th>
///                        </tr> <tr> <td><b>ERROR_SUCCESS</b></td> <td>The number of bytes of information about the counter specifications
///                        that the function stored in the buffer that <i>pCounters</i> specified.</td> </tr> <tr> <td><b>
///                        ERROR_NOT_ENOUGH_MEMORY</b></td> <td>The size of the buffer required to store the information about the counter
///                        specifications, in bytes. Enlarge the buffer to the required size and call the function again. </td> </tr> <tr>
///                        <td>Other</td> <td>The value is undefined and should not be used.</td> </tr> </table>
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function successfully stored all of the
///    information about the counter specifications in the buffer that <i>pCounters</i> specified. The value that
///    <i>pcbCountersActual</i> points to indicates amount of information actually stored in the buffer, in bytes. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The buffer
///    that <i>pCounters</i> specified was not large enough to store all of the information about the counter
///    specifications. The value that <i>pcbCountersActual</i> points to indicates the size of the buffer required to
///    store all of the information. Enlarge the buffer to the required size and call the function again. </td> </tr>
///    </table> For other types of failures, the return value is a system error code.
///    
@DllImport("ADVAPI32")
uint PerfQueryCounterInfo(PerfQueryHandle hQuery, PERF_COUNTER_IDENTIFIER* pCounters, uint cbCounters, 
                          uint* pcbCountersActual);

///Gets the values of the performance counters that match the counter specifications in the specified query.
///Params:
///    hQuery = A handle to a query for the counter specifications of the performance counters for which you want to get the
///             values.
///    pCounterBlock = A pointer to a buffer that has enough space to receive the amount of data that the <i>cbCounterBlock</i>
///                    parameter specifies, in bytes. May be NULL if <i>cbCounterBlock</i> is 0.
///    cbCounterBlock = The size of the buffer that the <i>pCounterBlock</i> parameter specifies, in bytes.
///    pcbCounterBlockActual = The size of the buffer actually required to get the performance counter values. The meaning depends on the value
///                            that the function returns. <table> <tr> <th>Function Return Value</th> <th>Meaning of
///                            <i>pcbCounterBlockActual</i></th> </tr> <tr> <td><b>ERROR_SUCCESS</b></td> <td>The number of bytes of performance
///                            counter values that the function stored in the buffer that <i>pCounterBlock</i> specified.</td> </tr> <tr>
///                            <td><b> ERROR_NOT_ENOUGH_MEMORY</b></td> <td>The size of the buffer required to store the performance counter
///                            values, in bytes. Enlarge the buffer to the required size and call the function again. </td> </tr> <tr>
///                            <td>Other</td> <td>The value is undefined and should not be used.</td> </tr> </table>
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function successfully stored all of the requested
///    performance counter values in the buffer that <i>pCounterBlock</i> specified. The value that
///    <i>pcbCounterBlockActual</i> points to indicates amount of information actually stored in the buffer, in bytes.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The
///    buffer that <i>pCounterBlock</i> specified was not large enough to store all of the requested performance counter
///    values. The value that <i>pcbCounterBlockActual</i> points to indicates the size of the buffer required to store
///    all of the information. Enlarge the buffer to the required size and call the function again. </td> </tr> </table>
///    For other types of failures, the return value is a system error code.
///    
@DllImport("ADVAPI32")
uint PerfQueryCounterData(PerfQueryHandle hQuery, PERF_DATA_HEADER* pCounterBlock, uint cbCounterBlock, 
                          uint* pcbCounterBlockActual);

///Adds performance counter specifications to the specified query.
///Params:
///    hQuery = A handle to the query to which you want to add performance counter specifications.
///    pCounters = A pointer to the performance counter specifications that you want to add.
///    cbCounters = The size of the buffer that the <i>pCounters</i> parameter specifies, in bytes.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfAddCounters(PerfQueryHandle hQuery, PERF_COUNTER_IDENTIFIER* pCounters, uint cbCounters);

///Removes the specified performance counter specifications from the specified query.
///Params:
///    hQuery = A handle to the query from which you want to remove performance counter specifications.
///    pCounters = A pointer to the performance counter specifications that you want to remove.
///    cbCounters = The size of the buffer that the <i>pCounters</i> parameter specifies, in bytes.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code.
///    
@DllImport("ADVAPI32")
uint PerfDeleteCounters(PerfQueryHandle hQuery, PERF_COUNTER_IDENTIFIER* pCounters, uint cbCounters);

///Returns the version of the currently installed Pdh.dll file. <div class="alert"><b>Note</b> This function is obsolete
///and no longer supported.</div><div> </div>
///Params:
///    lpdwVersion = Pointer to a variable that receives the version of Pdh.dll. This parameter can be one of the following values.
///                  <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_CVERSION_WIN50"></a><a
///                  id="pdh_cversion_win50"></a><dl> <dt><b>PDH_CVERSION_WIN50</b></dt> </dl> </td> <td width="60%"> The file version
///                  is a legacy operating system. </td> </tr> <tr> <td width="40%"><a id="PDH_VERSION"></a><a
///                  id="pdh_version"></a><dl> <dt><b>PDH_VERSION</b></dt> </dl> </td> <td width="60%"> The file version is Windows
///                  XP. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values.
///    
@DllImport("pdh")
int PdhGetDllVersion(uint* lpdwVersion);

///Creates a new query that is used to manage the collection of performance data. To use handles to data sources, use
///the PdhOpenQueryH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of the log file from which to retrieve performance data. If
///                   <b>NULL</b>, performance data is collected from a real-time data source.
///    dwUserData = User-defined value to associate with this query. To retrieve the user data later, call PdhGetCounterInfo and
///                 access the <b>dwQueryUserData</b> member of PDH_COUNTER_INFO.
///    phQuery = Handle to the query. You use this handle in subsequent calls.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhOpenQueryW(const(PWSTR) szDataSource, size_t dwUserData, ptrdiff_t* phQuery);

///Creates a new query that is used to manage the collection of performance data. To use handles to data sources, use
///the PdhOpenQueryH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of the log file from which to retrieve performance data. If
///                   <b>NULL</b>, performance data is collected from a real-time data source.
///    dwUserData = User-defined value to associate with this query. To retrieve the user data later, call PdhGetCounterInfo and
///                 access the <b>dwQueryUserData</b> member of PDH_COUNTER_INFO.
///    phQuery = Handle to the query. You use this handle in subsequent calls.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhOpenQueryA(const(PSTR) szDataSource, size_t dwUserData, ptrdiff_t* phQuery);

///Adds the specified counter to the query.
///Params:
///    hQuery = Handle to the query to which you want to add the counter. This handle is returned by the PdhOpenQuery function.
///    szFullCounterPath = Null-terminated string that contains the counter path. For details on the format of a counter path, see
///                        Specifying a Counter Path. The maximum length of a counter path is PDH_MAX_COUNTER_PATH.
///    dwUserData = User-defined value. This value becomes part of the counter information. To retrieve this value later, call the
///                 PdhGetCounterInfo function and access the <b>dwUserData</b> member of the PDH_COUNTER_INFO structure.
///    phCounter = Handle to the counter that was added to the query. You may need to reference this handle in subsequent calls.
///Returns:
///    Return ERROR_SUCCESS if the function succeeds. If the function fails, the return value is a system error code or
///    a PDH error code. The following are possible values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter
///    path could not be parsed or interpreted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> Unable to find the specified counter on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt>
///    </dl> </td> <td width="60%"> The counter path is empty. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The path did not contain a computer name, and
///    the function was unable to retrieve the local computer name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> Unable to find the specified object on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_FUNCTION_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> Unable to determine the calculation function to use for this counter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    query handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt>
///    </dl> </td> <td width="60%"> Unable to allocate memory required to complete the function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhAddCounterW(ptrdiff_t hQuery, const(PWSTR) szFullCounterPath, size_t dwUserData, ptrdiff_t* phCounter);

///Adds the specified counter to the query.
///Params:
///    hQuery = Handle to the query to which you want to add the counter. This handle is returned by the PdhOpenQuery function.
///    szFullCounterPath = Null-terminated string that contains the counter path. For details on the format of a counter path, see
///                        Specifying a Counter Path. The maximum length of a counter path is PDH_MAX_COUNTER_PATH.
///    dwUserData = User-defined value. This value becomes part of the counter information. To retrieve this value later, call the
///                 PdhGetCounterInfo function and access the <b>dwUserData</b> member of the PDH_COUNTER_INFO structure.
///    phCounter = Handle to the counter that was added to the query. You may need to reference this handle in subsequent calls.
///Returns:
///    Return ERROR_SUCCESS if the function succeeds. If the function fails, the return value is a system error code or
///    a PDH error code. The following are possible values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter
///    path could not be parsed or interpreted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> Unable to find the specified counter on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt>
///    </dl> </td> <td width="60%"> The counter path is empty. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The path did not contain a computer name, and
///    the function was unable to retrieve the local computer name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> Unable to find the specified object on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_FUNCTION_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> Unable to determine the calculation function to use for this counter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    query handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt>
///    </dl> </td> <td width="60%"> Unable to allocate memory required to complete the function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhAddCounterA(ptrdiff_t hQuery, const(PSTR) szFullCounterPath, size_t dwUserData, ptrdiff_t* phCounter);

///Adds the specified language-neutral counter to the query.
///Params:
///    hQuery = Handle to the query to which you want to add the counter. This handle is returned by the PdhOpenQuery function.
///    szFullCounterPath = Null-terminated string that contains the counter path. For details on the format of a counter path, see
///                        Specifying a Counter Path. The maximum length of a counter path is PDH_MAX_COUNTER_PATH.
///    dwUserData = User-defined value. This value becomes part of the counter information. To retrieve this value later, call the
///                 PdhGetCounterInfo function and access the <b>dwQueryUserData</b> member of the PDH_COUNTER_INFO structure.
///    phCounter = Handle to the counter that was added to the query. You may need to reference this handle in subsequent calls.
///Returns:
///    Return ERROR_SUCCESS if the function succeeds. If the function fails, the return value is a system error code or
///    a PDH error code. The following are possible values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter
///    path could not be parsed or interpreted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> Unable to find the specified counter on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt>
///    </dl> </td> <td width="60%"> The counter path is empty. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The path did not contain a computer name and
///    the function was unable to retrieve the local computer name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> Unable to find the specified object on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_FUNCTION_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> Unable to determine the calculation function to use for this counter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    query handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt>
///    </dl> </td> <td width="60%"> Unable to allocate memory required to complete the function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhAddEnglishCounterW(ptrdiff_t hQuery, const(PWSTR) szFullCounterPath, size_t dwUserData, 
                          ptrdiff_t* phCounter);

///Adds the specified language-neutral counter to the query.
///Params:
///    hQuery = Handle to the query to which you want to add the counter. This handle is returned by the PdhOpenQuery function.
///    szFullCounterPath = Null-terminated string that contains the counter path. For details on the format of a counter path, see
///                        Specifying a Counter Path. The maximum length of a counter path is PDH_MAX_COUNTER_PATH.
///    dwUserData = User-defined value. This value becomes part of the counter information. To retrieve this value later, call the
///                 PdhGetCounterInfo function and access the <b>dwQueryUserData</b> member of the PDH_COUNTER_INFO structure.
///    phCounter = Handle to the counter that was added to the query. You may need to reference this handle in subsequent calls.
///Returns:
///    Return ERROR_SUCCESS if the function succeeds. If the function fails, the return value is a system error code or
///    a PDH error code. The following are possible values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter
///    path could not be parsed or interpreted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> Unable to find the specified counter on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt>
///    </dl> </td> <td width="60%"> The counter path is empty. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The path did not contain a computer name and
///    the function was unable to retrieve the local computer name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> Unable to find the specified object on the
///    computer or in the log file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_FUNCTION_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> Unable to determine the calculation function to use for this counter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    query handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt>
///    </dl> </td> <td width="60%"> Unable to allocate memory required to complete the function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhAddEnglishCounterA(ptrdiff_t hQuery, const(PSTR) szFullCounterPath, size_t dwUserData, ptrdiff_t* phCounter);

///Collects the current raw data value for all counters in the specified query and updates the status code of each
///counter.
///Params:
///    hQuery = Handle of the query for which you want to collect data. The PdhOpenQuery function returns this handle.
///    pllTimeStamp = Time stamp when the first counter value in the query was retrieved. The time is specified as FILETIME.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. Otherwise, the function returns a system error code or a PDH
///    error code. The following are possible values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The query handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_NO_DATA</b></dt> </dl> </td> <td width="60%"> The query
///    does not currently have any counters. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhCollectQueryDataWithTime(ptrdiff_t hQuery, long* pllTimeStamp);

///Validates that the specified counter is present on the computer or in the log file.
///Params:
///    hDataSource = Handle to the data source. The PdhOpenLog and PdhBindInputDataSource functions return this handle. To validate
///                  that the counter is present on the local computer, specify <b>NULL</b> (this is the same as calling
///                  PdhValidatePath).
///    szFullPathBuffer = <b>Null</b>-terminated string that specifies the counter path to validate. The maximum length of a counter path
///                       is PDH_MAX_COUNTER_PATH.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_INSTANCE</b></dt> </dl> </td> <td
///    width="60%"> The specified instance of the performance object was not found. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The specified counter was not found in
///    the performance object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified performance object was not found on the computer or in the log file. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified
///    computer could not be found or connected to. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter path string could not be
///    parsed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> The function is unable to allocate a required temporary buffer. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhValidatePathExW(ptrdiff_t hDataSource, const(PWSTR) szFullPathBuffer);

///Validates that the specified counter is present on the computer or in the log file.
///Params:
///    hDataSource = Handle to the data source. The PdhOpenLog and PdhBindInputDataSource functions return this handle. To validate
///                  that the counter is present on the local computer, specify <b>NULL</b> (this is the same as calling
///                  PdhValidatePath).
///    szFullPathBuffer = <b>Null</b>-terminated string that specifies the counter path to validate. The maximum length of a counter path
///                       is PDH_MAX_COUNTER_PATH.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_INSTANCE</b></dt> </dl> </td> <td
///    width="60%"> The specified instance of the performance object was not found. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The specified counter was not found in
///    the performance object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified performance object was not found on the computer or in the log file. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified
///    computer could not be found or connected to. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter path string could not be
///    parsed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> The function is unable to allocate a required temporary buffer. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhValidatePathExA(ptrdiff_t hDataSource, const(PSTR) szFullPathBuffer);

///Removes a counter from a query.
///Params:
///    hCounter = Handle of the counter to remove from its query. The PdhAddCounter function returns this handle.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following is a possible value. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The counter handle is not valid. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhRemoveCounter(ptrdiff_t hCounter);

///Collects the current raw data value for all counters in the specified query and updates the status code of each
///counter.
///Params:
///    hQuery = Handle of the query for which you want to collect data. The PdhOpenQuery function returns this handle.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. Otherwise, the function returns a system error code or a PDH
///    error code. The following are possible values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The query handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_NO_DATA</b></dt> </dl> </td> <td width="60%"> The query
///    does not currently contain any counters. The query may not contain data because the user is not running with an
///    elevated token (see Limited User Access Support). </td> </tr> </table>
///    
@DllImport("pdh")
int PdhCollectQueryData(ptrdiff_t hQuery);

///Closes all counters contained in the specified query, closes all handles related to the query, and frees all memory
///associated with the query.
///Params:
///    hQuery = Handle to the query to close. This handle is returned by the PdhOpenQuery function.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. Otherwise, the function returns a system error code or a PDH
///    error code. The following is a possible value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The query handle is not
///    valid. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhCloseQuery(ptrdiff_t hQuery);

///Computes a displayable value for the specified counter.
///Params:
///    hCounter = Handle of the counter for which you want to compute a displayable value. The PdhAddCounter function returns this
///               handle.
///    dwFormat = Determines the data type of the formatted value. Specify one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_DOUBLE"></a><a id="pdh_fmt_double"></a><dl>
///               <dt><b>PDH_FMT_DOUBLE</b></dt> </dl> </td> <td width="60%"> Return data as a double-precision floating point
///               real. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LARGE"></a><a id="pdh_fmt_large"></a><dl>
///               <dt><b>PDH_FMT_LARGE</b></dt> </dl> </td> <td width="60%"> Return data as a 64-bit integer. </td> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_LONG"></a><a id="pdh_fmt_long"></a><dl> <dt><b>PDH_FMT_LONG</b></dt> </dl> </td> <td
///               width="60%"> Return data as a long integer. </td> </tr> </table> You can use the bitwise inclusive OR operator
///               (|) to combine the data type with one of the following scaling factors. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOSCALE"></a><a id="pdh_fmt_noscale"></a><dl>
///               <dt><b>PDH_FMT_NOSCALE</b></dt> </dl> </td> <td width="60%"> Do not apply the counter's default scaling factor.
///               </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOCAP100"></a><a id="pdh_fmt_nocap100"></a><dl>
///               <dt><b>PDH_FMT_NOCAP100</b></dt> </dl> </td> <td width="60%"> Counter values greater than 100 (for example,
///               counter values measuring the processor load on multiprocessor computers) will not be reset to 100. The default
///               behavior is that counter values are capped at a value of 100. </td> </tr> <tr> <td width="40%"><a
///               id="PDH_FMT_1000"></a><a id="pdh_fmt_1000"></a><dl> <dt><b>PDH_FMT_1000</b></dt> </dl> </td> <td width="60%">
///               Multiply the actual value by 1,000. </td> </tr> </table>
///    lpdwType = Receives the counter type. For a list of counter types, see the Counter Types section of the Windows Server 2003
///               Deployment Kit. This parameter is optional.
///    pValue = A PDH_FMT_COUNTERVALUE structure that receives the counter value.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The specified counter does not contain valid data
///    or a successful status code. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The counter handle is not valid. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetFormattedCounterValue(ptrdiff_t hCounter, uint dwFormat, uint* lpdwType, PDH_FMT_COUNTERVALUE* pValue);

///Returns an array of formatted counter values. Use this function when you want to format the counter values of a
///counter that contains a wildcard character for the instance name.
///Params:
///    hCounter = Handle to the counter whose current value you want to format. The PdhAddCounter function returns this handle.
///    dwFormat = Determines the data type of the formatted value. Specify one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_DOUBLE"></a><a id="pdh_fmt_double"></a><dl>
///               <dt><b>PDH_FMT_DOUBLE</b></dt> </dl> </td> <td width="60%"> Return data as a double-precision floating point
///               real. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LARGE"></a><a id="pdh_fmt_large"></a><dl>
///               <dt><b>PDH_FMT_LARGE</b></dt> </dl> </td> <td width="60%"> Return data as a 64-bit integer. </td> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_LONG"></a><a id="pdh_fmt_long"></a><dl> <dt><b>PDH_FMT_LONG</b></dt> </dl> </td> <td
///               width="60%"> Return data as a long integer. </td> </tr> </table> You can use the bitwise inclusive OR operator
///               (|) to combine the data type with one of the following scaling factors. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOSCALE"></a><a id="pdh_fmt_noscale"></a><dl>
///               <dt><b>PDH_FMT_NOSCALE</b></dt> </dl> </td> <td width="60%"> Do not apply the counter's default scaling factor.
///               </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOCAP100"></a><a id="pdh_fmt_nocap100"></a><dl>
///               <dt><b>PDH_FMT_NOCAP100</b></dt> </dl> </td> <td width="60%"> Counter values greater than 100 (for example,
///               counter values measuring the processor load on multiprocessor computers) will not be reset to 100. The default
///               behavior is that counter values are capped at a value of 100. </td> </tr> <tr> <td width="40%"><a
///               id="PDH_FMT_1000"></a><a id="pdh_fmt_1000"></a><dl> <dt><b>PDH_FMT_1000</b></dt> </dl> </td> <td width="60%">
///               Multiply the actual value by 1,000. </td> </tr> </table>
///    lpdwBufferSize = Size of the <i>ItemBuffer</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA and sets
///                     this parameter to the required buffer size. If the buffer is larger than the required size, the function sets
///                     this parameter to the actual size of the buffer that was used. If the specified size on input is greater than
///                     zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpdwItemCount = Number of counter values in the <i>ItemBuffer</i> buffer.
///    ItemBuffer = Caller-allocated buffer that receives an array of PDH_FMT_COUNTERVALUE_ITEM structures; the structures contain
///                 the counter values. Set to <b>NULL</b> if <i>lpdwBufferSize</i> is zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>ItemBuffer</i> buffer is not large enough to contain the object name. This return value is expected if
///    <i>lpdwBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhGetFormattedCounterArrayA(ptrdiff_t hCounter, uint dwFormat, uint* lpdwBufferSize, uint* lpdwItemCount, 
                                 PDH_FMT_COUNTERVALUE_ITEM_A* ItemBuffer);

///Returns an array of formatted counter values. Use this function when you want to format the counter values of a
///counter that contains a wildcard character for the instance name.
///Params:
///    hCounter = Handle to the counter whose current value you want to format. The PdhAddCounter function returns this handle.
///    dwFormat = Determines the data type of the formatted value. Specify one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_DOUBLE"></a><a id="pdh_fmt_double"></a><dl>
///               <dt><b>PDH_FMT_DOUBLE</b></dt> </dl> </td> <td width="60%"> Return data as a double-precision floating point
///               real. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LARGE"></a><a id="pdh_fmt_large"></a><dl>
///               <dt><b>PDH_FMT_LARGE</b></dt> </dl> </td> <td width="60%"> Return data as a 64-bit integer. </td> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_LONG"></a><a id="pdh_fmt_long"></a><dl> <dt><b>PDH_FMT_LONG</b></dt> </dl> </td> <td
///               width="60%"> Return data as a long integer. </td> </tr> </table> You can use the bitwise inclusive OR operator
///               (|) to combine the data type with one of the following scaling factors. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOSCALE"></a><a id="pdh_fmt_noscale"></a><dl>
///               <dt><b>PDH_FMT_NOSCALE</b></dt> </dl> </td> <td width="60%"> Do not apply the counter's default scaling factor.
///               </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOCAP100"></a><a id="pdh_fmt_nocap100"></a><dl>
///               <dt><b>PDH_FMT_NOCAP100</b></dt> </dl> </td> <td width="60%"> Counter values greater than 100 (for example,
///               counter values measuring the processor load on multiprocessor computers) will not be reset to 100. The default
///               behavior is that counter values are capped at a value of 100. </td> </tr> <tr> <td width="40%"><a
///               id="PDH_FMT_1000"></a><a id="pdh_fmt_1000"></a><dl> <dt><b>PDH_FMT_1000</b></dt> </dl> </td> <td width="60%">
///               Multiply the actual value by 1,000. </td> </tr> </table>
///    lpdwBufferSize = Size of the <i>ItemBuffer</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA and sets
///                     this parameter to the required buffer size. If the buffer is larger than the required size, the function sets
///                     this parameter to the actual size of the buffer that was used. If the specified size on input is greater than
///                     zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpdwItemCount = Number of counter values in the <i>ItemBuffer</i> buffer.
///    ItemBuffer = Caller-allocated buffer that receives an array of PDH_FMT_COUNTERVALUE_ITEM structures; the structures contain
///                 the counter values. Set to <b>NULL</b> if <i>lpdwBufferSize</i> is zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>ItemBuffer</i> buffer is not large enough to contain the object name. This return value is expected if
///    <i>lpdwBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhGetFormattedCounterArrayW(ptrdiff_t hCounter, uint dwFormat, uint* lpdwBufferSize, uint* lpdwItemCount, 
                                 PDH_FMT_COUNTERVALUE_ITEM_W* ItemBuffer);

///Returns the current raw value of the counter.
///Params:
///    hCounter = Handle of the counter from which to retrieve the current raw value. The PdhAddCounter function returns this
///               handle.
///    lpdwType = Receives the counter type. For a list of counter types, see the Counter Types section of the Windows Server 2003
///               Deployment Kit. This parameter is optional.
///    pValue = A PDH_RAW_COUNTER structure that receives the counter value.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhGetRawCounterValue(ptrdiff_t hCounter, uint* lpdwType, PDH_RAW_COUNTER* pValue);

///Returns an array of raw values from the specified counter. Use this function when you want to retrieve the raw
///counter values of a counter that contains a wildcard character for the instance name.
///Params:
///    hCounter = Handle of the counter for whose current raw instance values you want to retrieve. The PdhAddCounter function
///               returns this handle.
///    lpdwBufferSize = Size of the <i>ItemBuffer</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA and sets
///                     this parameter to the required buffer size. If the buffer is larger than the required size, the function sets
///                     this parameter to the actual size of the buffer that was used. If the specified size on input is greater than
///                     zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpdwItemCount = Number of raw counter values in the <i>ItemBuffer</i> buffer.
///    ItemBuffer = Caller-allocated buffer that receives the array of PDH_RAW_COUNTER_ITEM structures; the structures contain the
///                 raw instance counter values. Set to <b>NULL</b> if <i>lpdwBufferSize</i> is zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>ItemBuffer</i> buffer is not large enough to contain the object name. This return value is expected if
///    <i>lpdwBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhGetRawCounterArrayA(ptrdiff_t hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, 
                           PDH_RAW_COUNTER_ITEM_A* ItemBuffer);

///Returns an array of raw values from the specified counter. Use this function when you want to retrieve the raw
///counter values of a counter that contains a wildcard character for the instance name.
///Params:
///    hCounter = Handle of the counter for whose current raw instance values you want to retrieve. The PdhAddCounter function
///               returns this handle.
///    lpdwBufferSize = Size of the <i>ItemBuffer</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA and sets
///                     this parameter to the required buffer size. If the buffer is larger than the required size, the function sets
///                     this parameter to the actual size of the buffer that was used. If the specified size on input is greater than
///                     zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpdwItemCount = Number of raw counter values in the <i>ItemBuffer</i> buffer.
///    ItemBuffer = Caller-allocated buffer that receives the array of PDH_RAW_COUNTER_ITEM structures; the structures contain the
///                 raw instance counter values. Set to <b>NULL</b> if <i>lpdwBufferSize</i> is zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>ItemBuffer</i> buffer is not large enough to contain the object name. This return value is expected if
///    <i>lpdwBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhGetRawCounterArrayW(ptrdiff_t hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, 
                           PDH_RAW_COUNTER_ITEM_W* ItemBuffer);

///Calculates the displayable value of two raw counter values.
///Params:
///    hCounter = Handle to the counter to calculate. The function uses information from the counter to determine how to calculate
///               the value. This handle is returned by the PdhAddCounter function.
///    dwFormat = Determines the data type of the calculated value. Specify one of the following values. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_DOUBLE"></a><a
///               id="pdh_fmt_double"></a><dl> <dt><b>PDH_FMT_DOUBLE</b></dt> </dl> </td> <td width="60%"> Return the calculated
///               value as a double-precision floating point real. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LARGE"></a><a
///               id="pdh_fmt_large"></a><dl> <dt><b>PDH_FMT_LARGE</b></dt> </dl> </td> <td width="60%"> Return the calculated
///               value as a 64-bit integer. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LONG"></a><a
///               id="pdh_fmt_long"></a><dl> <dt><b>PDH_FMT_LONG</b></dt> </dl> </td> <td width="60%"> Return the calculated value
///               as a long integer. </td> </tr> </table> You can use the bitwise inclusive OR operator (|) to combine the data
///               type with one of the following scaling factors. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_NOSCALE"></a><a id="pdh_fmt_noscale"></a><dl> <dt><b>PDH_FMT_NOSCALE</b></dt> </dl>
///               </td> <td width="60%"> Do not apply the counter's scaling factor in the calculation. </td> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_NOCAP100"></a><a id="pdh_fmt_nocap100"></a><dl> <dt><b>PDH_FMT_NOCAP100</b></dt> </dl>
///               </td> <td width="60%"> Counter values greater than 100 (for example, counter values measuring the processor load
///               on multiprocessor computers) will not be reset to 100. The default behavior is that counter values are capped at
///               a value of 100. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_1000"></a><a id="pdh_fmt_1000"></a><dl>
///               <dt><b>PDH_FMT_1000</b></dt> </dl> </td> <td width="60%"> Multiply the final value by 1,000. </td> </tr> </table>
///    rawValue1 = Raw counter value used to compute the displayable counter value. For details, see the PDH_RAW_COUNTER structure.
///    rawValue2 = Raw counter value used to compute the displayable counter value. For details, see PDH_RAW_COUNTER. Some counters
///                (for example, rate counters) require two raw values to calculate a displayable value. If the counter type does
///                not require a second value, set this parameter to <b>NULL</b>. This value must be the older of the two raw
///                values.
///    fmtValue = A PDH_FMT_COUNTERVALUE structure that receives the calculated counter value.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> An argument is not correct or is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhCalculateCounterFromRawValue(ptrdiff_t hCounter, uint dwFormat, PDH_RAW_COUNTER* rawValue1, 
                                    PDH_RAW_COUNTER* rawValue2, PDH_FMT_COUNTERVALUE* fmtValue);

///Computes statistics for a counter from an array of raw values.
///Params:
///    hCounter = Handle of the counter for which you want to compute statistics. The PdhAddCounter function returns this handle.
///    dwFormat = Determines the data type of the formatted value. Specify one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_DOUBLE"></a><a id="pdh_fmt_double"></a><dl>
///               <dt><b>PDH_FMT_DOUBLE</b></dt> </dl> </td> <td width="60%"> Return the calculated value as a double-precision
///               floating point real. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LARGE"></a><a id="pdh_fmt_large"></a><dl>
///               <dt><b>PDH_FMT_LARGE</b></dt> </dl> </td> <td width="60%"> Return the calculated value as a 64-bit integer. </td>
///               </tr> <tr> <td width="40%"><a id="PDH_FMT_LONG"></a><a id="pdh_fmt_long"></a><dl> <dt><b>PDH_FMT_LONG</b></dt>
///               </dl> </td> <td width="60%"> Return the calculated value as a long integer. </td> </tr> </table> You can use the
///               bitwise inclusive OR operator (|) to combine the data type with one of the following scaling factors. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOSCALE"></a><a
///               id="pdh_fmt_noscale"></a><dl> <dt><b>PDH_FMT_NOSCALE</b></dt> </dl> </td> <td width="60%"> Do not apply the
///               counter's scaling factors in the calculation. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_NOCAP100"></a><a
///               id="pdh_fmt_nocap100"></a><dl> <dt><b>PDH_FMT_NOCAP100</b></dt> </dl> </td> <td width="60%"> Counter values
///               greater than 100 (for example, counter values measuring the processor load on multiprocessor computers) will not
///               be reset to 100. The default behavior is that counter values are capped at a value of 100. </td> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_1000"></a><a id="pdh_fmt_1000"></a><dl> <dt><b>PDH_FMT_1000</b></dt> </dl> </td> <td
///               width="60%"> Multiply the final value by 1,000. </td> </tr> </table>
///    dwFirstEntry = Zero-based index of the first raw counter value to use to begin the calculations. The index value must point to
///                   the oldest entry in the buffer. The function starts at this entry and scans through the buffer, wrapping at the
///                   last entry back to the beginning of the buffer and up to the <i>dwFirstEntry-1</i> entry, which is assumed to be
///                   the newest or most recent data.
///    dwNumEntries = Number of raw counter values in the <i>lpRawValueArray</i> buffer.
///    lpRawValueArray = Array of PDH_RAW_COUNTER structures that contain <i>dwNumEntries</i> entries.
///    data = A PDH_STATISTICS structure that receives the counter statistics.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> An argument is not correct or is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhComputeCounterStatistics(ptrdiff_t hCounter, uint dwFormat, uint dwFirstEntry, uint dwNumEntries, 
                                PDH_RAW_COUNTER* lpRawValueArray, PDH_STATISTICS* data);

///Retrieves information about a counter, such as data size, counter type, path, and user-supplied data values.
///Params:
///    hCounter = Handle of the counter from which you want to retrieve information. The PdhAddCounter function returns this
///               handle.
///    bRetrieveExplainText = Determines whether explain text is retrieved. If you set this parameter to <b>TRUE</b>, the explain text for the
///                           counter is retrieved. If you set this parameter to <b>FALSE</b>, the field in the returned buffer is <b>NULL</b>.
///    pdwBufferSize = Size of the <i>lpBuffer</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA and sets this
///                    parameter to the required buffer size. If the buffer is larger than the required size, the function sets this
///                    parameter to the actual size of the buffer that was used. If the specified size on input is greater than zero but
///                    less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpBuffer = Caller-allocated buffer that receives a PDH_COUNTER_INFO structure. The structure is variable-length, because the
///               string data is appended to the end of the fixed-format portion of the structure. This is done so that all data is
///               returned in a single buffer allocated by the caller. Set to <b>NULL</b> if <i>pdwBufferSize</i> is zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. For example, on some releases you could
///    receive this error if the specified size on input is greater than zero but less than the required size. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter
///    handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The <i>lpBuffer</i> buffer is too small to hold the counter information. This return value is
///    expected if <i>pdwBufferSize</i> is zero on input. If the specified size on input is greater than zero but less
///    than the required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetCounterInfoW(ptrdiff_t hCounter, ubyte bRetrieveExplainText, uint* pdwBufferSize, 
                       PDH_COUNTER_INFO_W* lpBuffer);

///Retrieves information about a counter, such as data size, counter type, path, and user-supplied data values.
///Params:
///    hCounter = Handle of the counter from which you want to retrieve information. The PdhAddCounter function returns this
///               handle.
///    bRetrieveExplainText = Determines whether explain text is retrieved. If you set this parameter to <b>TRUE</b>, the explain text for the
///                           counter is retrieved. If you set this parameter to <b>FALSE</b>, the field in the returned buffer is <b>NULL</b>.
///    pdwBufferSize = Size of the <i>lpBuffer</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA and sets this
///                    parameter to the required buffer size. If the buffer is larger than the required size, the function sets this
///                    parameter to the actual size of the buffer that was used. If the specified size on input is greater than zero but
///                    less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpBuffer = Caller-allocated buffer that receives a PDH_COUNTER_INFO structure. The structure is variable-length, because the
///               string data is appended to the end of the fixed-format portion of the structure. This is done so that all data is
///               returned in a single buffer allocated by the caller. Set to <b>NULL</b> if <i>pdwBufferSize</i> is zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. For example, on some releases you could
///    receive this error if the specified size on input is greater than zero but less than the required size. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter
///    handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The <i>lpBuffer</i> buffer is too small to hold the counter information. This return value is
///    expected if <i>pdwBufferSize</i> is zero on input. If the specified size on input is greater than zero but less
///    than the required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetCounterInfoA(ptrdiff_t hCounter, ubyte bRetrieveExplainText, uint* pdwBufferSize, 
                       PDH_COUNTER_INFO_A* lpBuffer);

///Sets the scale factor that is applied to the calculated value of the specified counter when you request the formatted
///counter value. If the PDH_FMT_NOSCALE flag is set, then this scale factor is ignored.
///Params:
///    hCounter = Handle of the counter to apply the scale factor to. The PdhAddCounter function returns this handle.
///    lFactor = Power of ten by which to multiply the calculated value before returning it. The minimum value of this parameter
///              is PDH_MIN_SCALE (–7), where the returned value is the actual value multiplied by 10<sup>–</sup>⁷. The
///              maximum value of this parameter is PDH_MAX_SCALE (+7), where the returned value is the actual value multiplied by
///              10⁺⁷. A value of zero will set the scale to one, so that the actual value is returned.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> The scale value is out of range. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhSetCounterScaleFactor(ptrdiff_t hCounter, int lFactor);

///Connects to the specified computer.
///Params:
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer to connect to. If <b>NULL</b>, PDH connects
///                    to the local computer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td
///    width="60%"> Unable to connect to the specified computer. Could be caused by the computer not being on, not
///    supporting PDH, not being connected to the network, or having the permissions set on the registry that prevent
///    remote connections or remote performance monitoring by the user. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate a dynamic memory
///    block. Occurs when there is a serious memory shortage in the system due to too many applications running on the
///    system or an insufficient memory paging file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhConnectMachineW(const(PWSTR) szMachineName);

///Connects to the specified computer.
///Params:
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer to connect to. If <b>NULL</b>, PDH connects
///                    to the local computer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td
///    width="60%"> Unable to connect to the specified computer. Could be caused by the computer not being on, not
///    supporting PDH, not being connected to the network, or having the permissions set on the registry that prevent
///    remote connections or remote performance monitoring by the user. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate a dynamic memory
///    block. Occurs when there is a serious memory shortage in the system due to too many applications running on the
///    system or an insufficient memory paging file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhConnectMachineA(const(PSTR) szMachineName);

///Returns a list of the computer names associated with counters in a log file. The computer names were either specified
///when adding counters to the query or when calling the PdhConnectMachine function. The computers listed include those
///that are currently connected and online, in addition to those that are offline or not returning performance data. To
///use handles to data sources, use the PdhEnumMachinesH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of a log file. The function enumerates the names of the
///                   computers whose counter data is in the log file. If <b>NULL</b>, the function enumerates the list of computers
///                   that were specified when adding counters to a real time query or when calling the PdhConnectMachine function.
///    mszMachineList = Caller-allocated buffer to receive the list of <b>null</b>-terminated strings that contain the computer names.
///                     The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if <i>pcchBufferLength</i>
///                     is zero.
///    pcchBufferSize = Size of the <i>mszMachineNameList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszMachineNameList</i> buffer is too small to contain all the data. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For
///    example, on some releases you could receive this error if the specified size on input is greater than zero but
///    less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumMachinesW(const(PWSTR) szDataSource, 
                     /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszMachineList, 
                     uint* pcchBufferSize);

///Returns a list of the computer names associated with counters in a log file. The computer names were either specified
///when adding counters to the query or when calling the PdhConnectMachine function. The computers listed include those
///that are currently connected and online, in addition to those that are offline or not returning performance data. To
///use handles to data sources, use the PdhEnumMachinesH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of a log file. The function enumerates the names of the
///                   computers whose counter data is in the log file. If <b>NULL</b>, the function enumerates the list of computers
///                   that were specified when adding counters to a real time query or when calling the PdhConnectMachine function.
///    mszMachineList = Caller-allocated buffer to receive the list of <b>null</b>-terminated strings that contain the computer names.
///                     The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if <i>pcchBufferLength</i>
///                     is zero.
///    pcchBufferSize = Size of the <i>mszMachineNameList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszMachineNameList</i> buffer is too small to contain all the data. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For
///    example, on some releases you could receive this error if the specified size on input is greater than zero but
///    less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumMachinesA(const(PSTR) szDataSource, 
                     /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszMachineList, 
                     uint* pcchBufferSize);

///Returns a list of objects available on the specified computer or in the specified log file. To use handles to data
///sources, use the PdhEnumObjectsH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of the log file used to enumerate the performance objects.
///                   If <b>NULL</b>, the function uses the computer specified in the <i>szMachineName</i> parameter to enumerate the
///                   names.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to enumerate the performance objects.
///                    Include the leading slashes in the computer name, for example, \\computername. If the <i>szDataSource</i>
///                    parameter is <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify the local computer.
///    mszObjectList = Caller-allocated buffer that receives the list of object names. Each object name in this list is terminated by a
///                    <b>null</b> character. The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if
///                    the <i>pcchBufferLength</i> parameter is zero.
///    pcchBufferSize = Size of the <i>mszObjectList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                     and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                     sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                     than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///                     <b>Windows XP: </b>Add one to the required buffer size.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    bRefresh = Indicates if the cached object list should be automatically refreshed. Specify one of the following values. If
///               you call this function twice, once to get the size of the list and a second time to get the actual list, set this
///               parameter to <b>TRUE</b> on the first call and <b>FALSE</b> on the second call. If both calls are <b>TRUE</b>,
///               the second call may also return PDH_MORE_DATA because the object data may have changed between calls. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
///               <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The object cache is automatically refreshed before the objects
///               are returned. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt>
///               </dl> </td> <td width="60%"> Do not automatically refresh the cache. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszObjectList</i> buffer is too small to hold the list of objects. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified computer is
///    offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectsW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, 
                    /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszObjectList, 
                    uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

///Returns a list of objects available on the specified computer or in the specified log file. To use handles to data
///sources, use the PdhEnumObjectsH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of the log file used to enumerate the performance objects.
///                   If <b>NULL</b>, the function uses the computer specified in the <i>szMachineName</i> parameter to enumerate the
///                   names.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to enumerate the performance objects.
///                    Include the leading slashes in the computer name, for example, \\computername. If the <i>szDataSource</i>
///                    parameter is <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify the local computer.
///    mszObjectList = Caller-allocated buffer that receives the list of object names. Each object name in this list is terminated by a
///                    <b>null</b> character. The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if
///                    the <i>pcchBufferLength</i> parameter is zero.
///    pcchBufferSize = Size of the <i>mszObjectList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                     and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                     sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                     than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///                     <b>Windows XP: </b>Add one to the required buffer size.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    bRefresh = Indicates if the cached object list should be automatically refreshed. Specify one of the following values. If
///               you call this function twice, once to get the size of the list and a second time to get the actual list, set this
///               parameter to <b>TRUE</b> on the first call and <b>FALSE</b> on the second call. If both calls are <b>TRUE</b>,
///               the second call may also return PDH_MORE_DATA because the object data may have changed between calls. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
///               <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The object cache is automatically refreshed before the objects
///               are returned. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt>
///               </dl> </td> <td width="60%"> Do not automatically refresh the cache. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszObjectList</i> buffer is too small to hold the list of objects. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified computer is
///    offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectsA(const(PSTR) szDataSource, const(PSTR) szMachineName, 
                    /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszObjectList, 
                    uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

///Returns the specified object's counter and instance names that exist on the specified computer or in the specified
///log file. To use handles to data sources, use the PdhEnumObjectItemsH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of the log file used to enumerate the counter and instance
///                   names. If <b>NULL</b>, the function uses the computer specified in the <i>szMachineName</i> parameter to
///                   enumerate the names.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer that contains the counter and instance
///                    names that you want to enumerate. Include the leading slashes in the computer name, for example, \\computername.
///                    If the <i>szDataSource</i> parameter is <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify
///                    the local computer.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose counter and instance names you want to
///                   enumerate.
///    mszCounterList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter names provided by the specified
///                     object. The list contains unique counter names. The list is terminated by two <b>NULL</b> characters. Set to
///                     <b>NULL</b> if the <i>pcchCounterListLength</i>parameter is zero.
///    pcchCounterListLength = Size of the <i>mszCounterList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                            returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                            required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                            size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                            reallocate the buffer.
///    mszInstanceList = Caller-allocated buffer that receives a list of <b>null</b>-terminated instance names provided by the specified
///                      object. The list contains unique instance names. The list is terminated by two <b>NULL</b> characters. Set to
///                      <b>NULL</b> if <i>pcchInstanceListLength</i> is zero.
///    pcchInstanceListLength = Size of the <i>mszInstanceList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                             returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                             required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                             size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                             reallocate the buffer. If the specified object does not support variable instances, then the returned value will
///                             be zero. If the specified object does support variable instances, but does not currently have any instances, then
///                             the value returned is 2, which is the size of an empty MULTI_SZ list string.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    dwFlags = This parameter must be zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    One of the buffers is too small to contain the list of names. This return value is expected if
///    <i>pcchCounterListLength</i> or <i>pcchInstanceListLength</i> is zero on input. If the specified size on input is
///    greater than zero but less than the required size, you should not rely on the returned size to reallocate the
///    buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%">
///    A parameter is not valid. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to support
///    this function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td
///    width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> The specified object could not be found on the
///    specified computer or in the specified log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectItemsW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                        /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszCounterList, 
                        uint* pcchCounterListLength, 
                        /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszInstanceList, 
                        uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

///Returns the specified object's counter and instance names that exist on the specified computer or in the specified
///log file. To use handles to data sources, use the PdhEnumObjectItemsH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the name of the log file used to enumerate the counter and instance
///                   names. If <b>NULL</b>, the function uses the computer specified in the <i>szMachineName</i> parameter to
///                   enumerate the names.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer that contains the counter and instance
///                    names that you want to enumerate. Include the leading slashes in the computer name, for example, \\computername.
///                    If the <i>szDataSource</i> parameter is <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify
///                    the local computer.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose counter and instance names you want to
///                   enumerate.
///    mszCounterList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter names provided by the specified
///                     object. The list contains unique counter names. The list is terminated by two <b>NULL</b> characters. Set to
///                     <b>NULL</b> if the <i>pcchCounterListLength</i>parameter is zero.
///    pcchCounterListLength = Size of the <i>mszCounterList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                            returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                            required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                            size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                            reallocate the buffer.
///    mszInstanceList = Caller-allocated buffer that receives a list of <b>null</b>-terminated instance names provided by the specified
///                      object. The list contains unique instance names. The list is terminated by two <b>NULL</b> characters. Set to
///                      <b>NULL</b> if <i>pcchInstanceListLength</i> is zero.
///    pcchInstanceListLength = Size of the <i>mszInstanceList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                             returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                             required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                             size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                             reallocate the buffer. If the specified object does not support variable instances, then the returned value will
///                             be zero. If the specified object does support variable instances, but does not currently have any instances, then
///                             the value returned is 2, which is the size of an empty MULTI_SZ list string.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    dwFlags = This parameter must be zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    One of the buffers is too small to contain the list of names. This return value is expected if
///    <i>pcchCounterListLength</i> or <i>pcchInstanceListLength</i> is zero on input. If the specified size on input is
///    greater than zero but less than the required size, you should not rely on the returned size to reallocate the
///    buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%">
///    A parameter is not valid. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to support
///    this function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td
///    width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> The specified object could not be found on the
///    specified computer or in the specified log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectItemsA(const(PSTR) szDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                        /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszCounterList, 
                        uint* pcchCounterListLength, 
                        /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszInstanceList, 
                        uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

///Creates a full counter path using the members specified in the PDH_COUNTER_PATH_ELEMENTS structure.
///Params:
///    pCounterPathElements = A PDH_COUNTER_PATH_ELEMENTS structure that contains the members used to make up the path. Only the
///                           <b>szObjectName</b> and <b>szCounterName</b> members are required, the others are optional. If the instance name
///                           member is <b>NULL</b>, the path will not contain an instance reference and the <b>szParentInstance</b> and
///                           <b>dwInstanceIndex</b> members will be ignored.
///    szFullPathBuffer = Caller-allocated buffer that receives a <b>null</b>-terminated counter path. The maximum length of a counter path
///                       is PDH_MAX_COUNTER_PATH. Set to <b>NULL</b> if <i>pcchBufferSize</i> is zero.
///    pcchBufferSize = Size of the <i>szFullPathBuffer</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///    dwFlags = Format of the input and output counter values. You can specify one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_PATH_WBEM_RESULT"></a><a
///              id="pdh_path_wbem_result"></a><dl> <dt><b>PDH_PATH_WBEM_RESULT</b></dt> </dl> </td> <td width="60%"> Converts a
///              PDH path to the WMI class and property name format. </td> </tr> <tr> <td width="40%"><a
///              id="PDH_PATH_WBEM_INPUT"></a><a id="pdh_path_wbem_input"></a><dl> <dt><b>PDH_PATH_WBEM_INPUT</b></dt> </dl> </td>
///              <td width="60%"> Converts the WMI class and property name to a PDH path. </td> </tr> <tr> <td width="40%"><a
///              id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> Returns the path in the PDH format, for example,
///              \\computer\object(parent/instance
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szFullPathBuffer</i> buffer is too small to contain the counter name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhMakeCounterPathW(PDH_COUNTER_PATH_ELEMENTS_W* pCounterPathElements, PWSTR szFullPathBuffer, 
                        uint* pcchBufferSize, uint dwFlags);

///Creates a full counter path using the members specified in the PDH_COUNTER_PATH_ELEMENTS structure.
///Params:
///    pCounterPathElements = A PDH_COUNTER_PATH_ELEMENTS structure that contains the members used to make up the path. Only the
///                           <b>szObjectName</b> and <b>szCounterName</b> members are required, the others are optional. If the instance name
///                           member is <b>NULL</b>, the path will not contain an instance reference and the <b>szParentInstance</b> and
///                           <b>dwInstanceIndex</b> members will be ignored.
///    szFullPathBuffer = Caller-allocated buffer that receives a <b>null</b>-terminated counter path. The maximum length of a counter path
///                       is PDH_MAX_COUNTER_PATH. Set to <b>NULL</b> if <i>pcchBufferSize</i> is zero.
///    pcchBufferSize = Size of the <i>szFullPathBuffer</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///    dwFlags = Format of the input and output counter values. You can specify one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_PATH_WBEM_RESULT"></a><a
///              id="pdh_path_wbem_result"></a><dl> <dt><b>PDH_PATH_WBEM_RESULT</b></dt> </dl> </td> <td width="60%"> Converts a
///              PDH path to the WMI class and property name format. </td> </tr> <tr> <td width="40%"><a
///              id="PDH_PATH_WBEM_INPUT"></a><a id="pdh_path_wbem_input"></a><dl> <dt><b>PDH_PATH_WBEM_INPUT</b></dt> </dl> </td>
///              <td width="60%"> Converts the WMI class and property name to a PDH path. </td> </tr> <tr> <td width="40%"><a
///              id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> Returns the path in the PDH format, for example,
///              \\computer\object(parent/instance
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szFullPathBuffer</i> buffer is too small to contain the counter name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhMakeCounterPathA(PDH_COUNTER_PATH_ELEMENTS_A* pCounterPathElements, PSTR szFullPathBuffer, 
                        uint* pcchBufferSize, uint dwFlags);

///Parses the elements of the counter path and stores the results in the PDH_COUNTER_PATH_ELEMENTS structure.
///Params:
///    szFullPathBuffer = <b>Null</b>-terminated string that contains the counter path to parse. The maximum length of a counter path is
///                       PDH_MAX_COUNTER_PATH.
///    pCounterPathElements = Caller-allocated buffer that receives a PDH_COUNTER_PATH_ELEMENTS structure. The structure contains pointers to
///                           the individual string elements of the path referenced by the <i>szFullPathBuffer</i> parameter. The function
///                           appends the strings to the end of the <b>PDH_COUNTER_PATH_ELEMENTS</b> structure. The allocated buffer should be
///                           large enough for the structure and the strings. Set to <b>NULL</b> if <i>pdwBufferSize</i> is zero.
///    pdwBufferSize = Size of the <i>pCounterPathElements</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA
///                    and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                    sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                    than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    dwFlags = Reserved. Must be zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>pCounterPathElements</i> buffer is too small to contain the path elements. This
///    return value is expected if <i>pdwBufferSize</i> is zero on input. If the specified size on input is greater than
///    zero but less than the required size, you should not rely on the returned size to reallocate the buffer. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> The path is not
///    formatted correctly and cannot be parsed. For example, on some releases you could receive this error if the
///    specified size on input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in
///    order to complete the function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhParseCounterPathW(const(PWSTR) szFullPathBuffer, PDH_COUNTER_PATH_ELEMENTS_W* pCounterPathElements, 
                         uint* pdwBufferSize, uint dwFlags);

///Parses the elements of the counter path and stores the results in the PDH_COUNTER_PATH_ELEMENTS structure.
///Params:
///    szFullPathBuffer = <b>Null</b>-terminated string that contains the counter path to parse. The maximum length of a counter path is
///                       PDH_MAX_COUNTER_PATH.
///    pCounterPathElements = Caller-allocated buffer that receives a PDH_COUNTER_PATH_ELEMENTS structure. The structure contains pointers to
///                           the individual string elements of the path referenced by the <i>szFullPathBuffer</i> parameter. The function
///                           appends the strings to the end of the <b>PDH_COUNTER_PATH_ELEMENTS</b> structure. The allocated buffer should be
///                           large enough for the structure and the strings. Set to <b>NULL</b> if <i>pdwBufferSize</i> is zero.
///    pdwBufferSize = Size of the <i>pCounterPathElements</i> buffer, in bytes. If zero on input, the function returns PDH_MORE_DATA
///                    and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                    sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                    than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    dwFlags = Reserved. Must be zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>pCounterPathElements</i> buffer is too small to contain the path elements. This
///    return value is expected if <i>pdwBufferSize</i> is zero on input. If the specified size on input is greater than
///    zero but less than the required size, you should not rely on the returned size to reallocate the buffer. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> The path is not
///    formatted correctly and cannot be parsed. For example, on some releases you could receive this error if the
///    specified size on input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in
///    order to complete the function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhParseCounterPathA(const(PSTR) szFullPathBuffer, PDH_COUNTER_PATH_ELEMENTS_A* pCounterPathElements, 
                         uint* pdwBufferSize, uint dwFlags);

///Parses the elements of an instance string.
///Params:
///    szInstanceString = <b>Null</b>-terminated string that specifies the instance string to parse into individual components. This string
///                       can contain the following formats, and is less than MAX_PATH characters in length: <ul> <li>instance</li>
///                       <li>instance
///    szInstanceName = Caller-allocated buffer that receives the <b>null</b>-terminated instance name. Set to <b>NULL</b> if
///                     <i>pcchInstanceNameLength</i> is zero.
///    pcchInstanceNameLength = Size of the <i>szInstanceName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                             and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                             sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                             than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    szParentName = Caller-allocated buffer that receives the <b>null</b>-terminated name of the parent instance, if one is
///                   specified. Set to <b>NULL</b> if <i>pcchParentNameLength</i> is zero.
///    pcchParentNameLength = Size of the <i>szParentName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                           and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                           sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                           than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpIndex = Index value of the instance. If an index entry is not present in the string, then this value is zero. This
///              parameter can be <b>NULL</b>.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid. For example, on some releases you could receive this error if the
///    specified size on input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> One or both of the string buffers are too small
///    to contain the data. This return value is expected if the corresponding size buffer is zero on input. If the
///    specified size on input is greater than zero but less than the required size, you should not rely on the returned
///    size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_INSTANCE</b></dt> </dl>
///    </td> <td width="60%"> The instance string is incorrectly formatted, exceeds MAX_PATH characters in length, or
///    cannot be parsed. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhParseInstanceNameW(const(PWSTR) szInstanceString, PWSTR szInstanceName, uint* pcchInstanceNameLength, 
                          PWSTR szParentName, uint* pcchParentNameLength, uint* lpIndex);

///Parses the elements of an instance string.
///Params:
///    szInstanceString = <b>Null</b>-terminated string that specifies the instance string to parse into individual components. This string
///                       can contain the following formats, and is less than MAX_PATH characters in length: <ul> <li>instance</li>
///                       <li>instance
///    szInstanceName = Caller-allocated buffer that receives the <b>null</b>-terminated instance name. Set to <b>NULL</b> if
///                     <i>pcchInstanceNameLength</i> is zero.
///    pcchInstanceNameLength = Size of the <i>szInstanceName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                             and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                             sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                             than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    szParentName = Caller-allocated buffer that receives the <b>null</b>-terminated name of the parent instance, if one is
///                   specified. Set to <b>NULL</b> if <i>pcchParentNameLength</i> is zero.
///    pcchParentNameLength = Size of the <i>szParentName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                           and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                           sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                           than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///    lpIndex = Index value of the instance. If an index entry is not present in the string, then this value is zero. This
///              parameter can be <b>NULL</b>.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid. For example, on some releases you could receive this error if the
///    specified size on input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> One or both of the string buffers are too small
///    to contain the data. This return value is expected if the corresponding size buffer is zero on input. If the
///    specified size on input is greater than zero but less than the required size, you should not rely on the returned
///    size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_INSTANCE</b></dt> </dl>
///    </td> <td width="60%"> The instance string is incorrectly formatted, exceeds MAX_PATH characters in length, or
///    cannot be parsed. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhParseInstanceNameA(const(PSTR) szInstanceString, PSTR szInstanceName, uint* pcchInstanceNameLength, 
                          PSTR szParentName, uint* pcchParentNameLength, uint* lpIndex);

///Validates that the counter is present on the computer specified in the counter path.
///Params:
///    szFullPathBuffer = Null-terminated string that contains the counter path to validate. The maximum length of a counter path is
///                       PDH_MAX_COUNTER_PATH.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_INSTANCE</b></dt> </dl> </td> <td
///    width="60%"> The specified instance of the performance object was not found. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The specified counter was not found in
///    the performance object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified performance object was not found on the computer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified computer
///    could not be found or connected to. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter path string could not be
///    parsed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> The function is unable to allocate a required temporary buffer. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhValidatePathW(const(PWSTR) szFullPathBuffer);

///Validates that the counter is present on the computer specified in the counter path.
///Params:
///    szFullPathBuffer = Null-terminated string that contains the counter path to validate. The maximum length of a counter path is
///                       PDH_MAX_COUNTER_PATH.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_INSTANCE</b></dt> </dl> </td> <td
///    width="60%"> The specified instance of the performance object was not found. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The specified counter was not found in
///    the performance object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified performance object was not found on the computer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified computer
///    could not be found or connected to. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_BAD_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The counter path string could not be
///    parsed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> The function is unable to allocate a required temporary buffer. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhValidatePathA(const(PSTR) szFullPathBuffer);

///Retrieves the name of the default object. This name can be used to set the initial object selection in the Browse
///Counter dialog box. To use handles to data sources, use the PdhGetDefaultPerfObjectH function.
///Params:
///    szDataSource = Should be <b>NULL</b>. If you specify a log file, the <i>szDefaultObjectName</i> parameter will be a <b>null</b>
///                   string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the name.
///    szDefaultObjectName = Caller-allocated buffer that receives the <b>null</b>-terminated default object name. Set to <b>NULL</b> if the
///                          <i>pcchBufferSize</i> parameter is zero. Note that PDH always returns Processor for the default object name.
///    pcchBufferSize = Size of the <i>szDefaultObjectName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultObjectName</i> buffer is too small to contain the object name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfObjectW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, PWSTR szDefaultObjectName, 
                             uint* pcchBufferSize);

///Retrieves the name of the default object. This name can be used to set the initial object selection in the Browse
///Counter dialog box. To use handles to data sources, use the PdhGetDefaultPerfObjectH function.
///Params:
///    szDataSource = Should be <b>NULL</b>. If you specify a log file, the <i>szDefaultObjectName</i> parameter will be a <b>null</b>
///                   string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the name.
///    szDefaultObjectName = Caller-allocated buffer that receives the <b>null</b>-terminated default object name. Set to <b>NULL</b> if the
///                          <i>pcchBufferSize</i> parameter is zero. Note that PDH always returns Processor for the default object name.
///    pcchBufferSize = Size of the <i>szDefaultObjectName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultObjectName</i> buffer is too small to contain the object name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfObjectA(const(PSTR) szDataSource, const(PSTR) szMachineName, PSTR szDefaultObjectName, 
                             uint* pcchBufferSize);

///Retrieves the name of the default counter for the specified object. This name can be used to set the initial counter
///selection in the Browse Counter dialog box. To use handles to data sources, use the PdhGetDefaultPerfCounterH
///function.
///Params:
///    szDataSource = Should be <b>NULL</b>. If you specify a log file, <i>szDefaultCounterName</i> will be a <b>null</b> string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the object name.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose default counter name you want to
///                   retrieve.
///    szDefaultCounterName = Caller-allocated buffer that receives the <b>null</b>-terminated default counter name. Set to <b>NULL</b> if
///                           <i>pcchBufferSize</i> is zero.
///    pcchBufferSize = Size of the <i>szDefaultCounterName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultCounterName</i> buffer is too small to contain the counter name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The default counter name cannot be read
///    or found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td
///    width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The object did not specify a default counter.
///    </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfCounterW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                              PWSTR szDefaultCounterName, uint* pcchBufferSize);

///Retrieves the name of the default counter for the specified object. This name can be used to set the initial counter
///selection in the Browse Counter dialog box. To use handles to data sources, use the PdhGetDefaultPerfCounterH
///function.
///Params:
///    szDataSource = Should be <b>NULL</b>. If you specify a log file, <i>szDefaultCounterName</i> will be a <b>null</b> string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the object name.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose default counter name you want to
///                   retrieve.
///    szDefaultCounterName = Caller-allocated buffer that receives the <b>null</b>-terminated default counter name. Set to <b>NULL</b> if
///                           <i>pcchBufferSize</i> is zero.
///    pcchBufferSize = Size of the <i>szDefaultCounterName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultCounterName</i> buffer is too small to contain the counter name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The default counter name cannot be read
///    or found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td
///    width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The object did not specify a default counter.
///    </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfCounterA(const(PSTR) szDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                              PSTR szDefaultCounterName, uint* pcchBufferSize);

///Displays a <b>Browse Counters</b> dialog box that the user can use to select one or more counters that they want to
///add to the query. To use handles to data sources, use the PdhBrowseCountersH function.
///Params:
///    pBrowseDlgData = A PDH_BROWSE_DLG_CONFIG structure that specifies the behavior of the dialog box.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhBrowseCountersW(PDH_BROWSE_DLG_CONFIG_W* pBrowseDlgData);

///Displays a <b>Browse Counters</b> dialog box that the user can use to select one or more counters that they want to
///add to the query. To use handles to data sources, use the PdhBrowseCountersH function.
///Params:
///    pBrowseDlgData = A PDH_BROWSE_DLG_CONFIG structure that specifies the behavior of the dialog box.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhBrowseCountersA(PDH_BROWSE_DLG_CONFIG_A* pBrowseDlgData);

///Examines the specified computer (or local computer if none is specified) for counters and instances of counters that
///match the wildcard strings in the counter path. <div class="alert"><b>Note</b> This function is superseded by the
///PdhExpandWildCardPath function.</div><div> </div>
///Params:
///    szWildCardPath = <b>Null</b>-terminated string that contains the counter path to expand. The function searches the computer
///                     specified in the path for matches. If the path does not specify a computer, the function searches the local
///                     computer. The maximum length of a counter path is PDH_MAX_COUNTER_PATH.
///    mszExpandedPathList = Caller-allocated buffer that receives the list of expanded counter paths that match the wildcard specification in
///                          <i>szWildCardPath</i>. Each counter path in this list is terminated by a <b>null</b> character. The list is
///                          terminated with two <b>NULL</b> characters. Set to <b>NULL</b> if <i>pcchPathListLength</i> is zero.
///    pcchPathListLength = Size of the <i>mszExpandedPathList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                         PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                         size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                         input is greater than zero but less than the required size, you should not rely on the returned size to
///                         reallocate the buffer. <div class="alert"><b>Note</b> You must add one to the required size on Windows XP.</div>
///                         <div> </div>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>mszExpandedPathList</i> buffer is too small to
///    contain the list of paths. This return value is expected if <i>pcchPathListLength</i> is zero on input. If the
///    specified size on input is greater than zero but less than the required size, you should not rely on the returned
///    size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl>
///    </td> <td width="60%"> A parameter is not valid. For example, on some releases you could receive this error if
///    the specified size on input is greater than zero but less than the required size. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate
///    memory to support this function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhExpandCounterPathW(const(PWSTR) szWildCardPath, 
                          /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszExpandedPathList, 
                          uint* pcchPathListLength);

///Examines the specified computer (or local computer if none is specified) for counters and instances of counters that
///match the wildcard strings in the counter path. <div class="alert"><b>Note</b> This function is superseded by the
///PdhExpandWildCardPath function.</div><div> </div>
///Params:
///    szWildCardPath = <b>Null</b>-terminated string that contains the counter path to expand. The function searches the computer
///                     specified in the path for matches. If the path does not specify a computer, the function searches the local
///                     computer. The maximum length of a counter path is PDH_MAX_COUNTER_PATH.
///    mszExpandedPathList = Caller-allocated buffer that receives the list of expanded counter paths that match the wildcard specification in
///                          <i>szWildCardPath</i>. Each counter path in this list is terminated by a <b>null</b> character. The list is
///                          terminated with two <b>NULL</b> characters. Set to <b>NULL</b> if <i>pcchPathListLength</i> is zero.
///    pcchPathListLength = Size of the <i>mszExpandedPathList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                         PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                         size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                         input is greater than zero but less than the required size, you should not rely on the returned size to
///                         reallocate the buffer. <div class="alert"><b>Note</b> You must add one to the required size on Windows XP.</div>
///                         <div> </div>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>mszExpandedPathList</i> buffer is too small to
///    contain the list of paths. This return value is expected if <i>pcchPathListLength</i> is zero on input. If the
///    specified size on input is greater than zero but less than the required size, you should not rely on the returned
///    size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl>
///    </td> <td width="60%"> A parameter is not valid. For example, on some releases you could receive this error if
///    the specified size on input is greater than zero but less than the required size. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate
///    memory to support this function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhExpandCounterPathA(const(PSTR) szWildCardPath, 
                          /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszExpandedPathList, 
                          uint* pcchPathListLength);

///Returns the performance object name or counter name corresponding to the specified index.
///Params:
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer where the specified performance object or
///                    counter is located. The computer name can be specified by the DNS name or the IP address. If <b>NULL</b>, the
///                    function uses the local computer.
///    dwNameIndex = Index of the performance object or counter.
///    szNameBuffer = Caller-allocated buffer that receives the <b>null</b>-terminated name of the performance object or counter. Set
///                   to <b>NULL</b> if <i>pcchNameBufferSize</i> is zero.
///    pcchNameBufferSize = Size of the <i>szNameBuffer</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                         and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                         sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                         than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szNameBuffer</i> buffer is not large enough to contain the counter name. This return value is expected if
///    <i>pcchNameBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhLookupPerfNameByIndexW(const(PWSTR) szMachineName, uint dwNameIndex, PWSTR szNameBuffer, 
                              uint* pcchNameBufferSize);

///Returns the performance object name or counter name corresponding to the specified index.
///Params:
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer where the specified performance object or
///                    counter is located. The computer name can be specified by the DNS name or the IP address. If <b>NULL</b>, the
///                    function uses the local computer.
///    dwNameIndex = Index of the performance object or counter.
///    szNameBuffer = Caller-allocated buffer that receives the <b>null</b>-terminated name of the performance object or counter. Set
///                   to <b>NULL</b> if <i>pcchNameBufferSize</i> is zero.
///    pcchNameBufferSize = Size of the <i>szNameBuffer</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                         and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                         sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                         than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szNameBuffer</i> buffer is not large enough to contain the counter name. This return value is expected if
///    <i>pcchNameBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid or
///    is incorrectly formatted. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhLookupPerfNameByIndexA(const(PSTR) szMachineName, uint dwNameIndex, PSTR szNameBuffer, 
                              uint* pcchNameBufferSize);

///Returns the counter index corresponding to the specified counter name.
///Params:
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer where the specified counter is located. The
///                    computer name can be specified by the DNS name or the IP address. If <b>NULL</b>, the function uses the local
///                    computer.
///    szNameBuffer = <b>Null</b>-terminated string that contains the counter name.
///    pdwIndex = Index of the counter.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following is a possible value. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhLookupPerfIndexByNameW(const(PWSTR) szMachineName, const(PWSTR) szNameBuffer, uint* pdwIndex);

///Returns the counter index corresponding to the specified counter name.
///Params:
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer where the specified counter is located. The
///                    computer name can be specified by the DNS name or the IP address. If <b>NULL</b>, the function uses the local
///                    computer.
///    szNameBuffer = <b>Null</b>-terminated string that contains the counter name.
///    pdwIndex = Index of the counter.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following is a possible value. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhLookupPerfIndexByNameA(const(PSTR) szMachineName, const(PSTR) szNameBuffer, uint* pdwIndex);

///Examines the specified computer or log file and returns those counter paths that match the given counter path which
///contains wildcard characters. To use handles to data sources, use the PdhExpandWildCardPathH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that contains the name of a log file. The function uses the performance objects and
///                   counters defined in the log file to expand the path specified in the <i>szWildCardPath</i> parameter. If
///                   <b>NULL</b>, the function searches the computer specified in <i>szWildCardPath</i>.
///    szWildCardPath = <b>Null</b>-terminated string that specifies the counter path to expand. The maximum length of a counter path is
///                     PDH_MAX_COUNTER_PATH. If the <i>szDataSource</i> parameter is <b>NULL</b>, the function searches the computer
///                     specified in the path for matches. If the path does not specify a computer, the function searches the local
///                     computer.
///    mszExpandedPathList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter paths that match the wildcard
///                          specification in the <i>szWildCardPath</i>. The list is terminated by two <b>NULL</b> characters. Set to
///                          <b>NULL</b> if <i>pcchPathListLength</i> is zero.
///    pcchPathListLength = Size of the <i>mszExpandedPathList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the
///                         function returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than
///                         the required size, the function sets this parameter to the actual size of the buffer that was used. If the
///                         specified size on input is greater than zero but less than the required size, you should not rely on the returned
///                         size to reallocate the buffer. <div class="alert"><b>Note</b> You must add one to the required size on Windows
///                         XP.</div> <div> </div>
///    dwFlags = Flags that indicate which wildcard characters not to expand. You can specify one or more flags. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_NOEXPANDCOUNTERS"></a><a
///              id="pdh_noexpandcounters"></a><dl> <dt><b>PDH_NOEXPANDCOUNTERS</b></dt> </dl> </td> <td width="60%"> Do not
///              expand the counter name if the path contains a wildcard character for counter name. </td> </tr> <tr> <td
///              width="40%"><a id="PDH_NOEXPANDINSTANCES"></a><a id="pdh_noexpandinstances"></a><dl>
///              <dt><b>PDH_NOEXPANDINSTANCES</b></dt> </dl> </td> <td width="60%"> Do not expand the instance name if the path
///              contains a wildcard character for parent instance, instance name, or instance index. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>mszExpandedPathList</i> buffer is not large
///    enough to contain the list of paths. This return value is expected if <i>pcchPathListLength</i> is zero on input.
///    If the specified size on input is greater than zero but less than the required size, you should not rely on the
///    returned size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_PATH</b></dt> </dl> </td> <td
///    width="60%"> The specified object does not contain an instance. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to support
///    this function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td
///    width="60%"> Unable to find the specified object on the computer or in the log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhExpandWildCardPathA(const(PSTR) szDataSource, const(PSTR) szWildCardPath, 
                           /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszExpandedPathList, 
                           uint* pcchPathListLength, uint dwFlags);

///Examines the specified computer or log file and returns those counter paths that match the given counter path which
///contains wildcard characters. To use handles to data sources, use the PdhExpandWildCardPathH function.
///Params:
///    szDataSource = <b>Null</b>-terminated string that contains the name of a log file. The function uses the performance objects and
///                   counters defined in the log file to expand the path specified in the <i>szWildCardPath</i> parameter. If
///                   <b>NULL</b>, the function searches the computer specified in <i>szWildCardPath</i>.
///    szWildCardPath = <b>Null</b>-terminated string that specifies the counter path to expand. The maximum length of a counter path is
///                     PDH_MAX_COUNTER_PATH. If the <i>szDataSource</i> parameter is <b>NULL</b>, the function searches the computer
///                     specified in the path for matches. If the path does not specify a computer, the function searches the local
///                     computer.
///    mszExpandedPathList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter paths that match the wildcard
///                          specification in the <i>szWildCardPath</i>. The list is terminated by two <b>NULL</b> characters. Set to
///                          <b>NULL</b> if <i>pcchPathListLength</i> is zero.
///    pcchPathListLength = Size of the <i>mszExpandedPathList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the
///                         function returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than
///                         the required size, the function sets this parameter to the actual size of the buffer that was used. If the
///                         specified size on input is greater than zero but less than the required size, you should not rely on the returned
///                         size to reallocate the buffer. <div class="alert"><b>Note</b> You must add one to the required size on Windows
///                         XP.</div> <div> </div>
///    dwFlags = Flags that indicate which wildcard characters not to expand. You can specify one or more flags. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_NOEXPANDCOUNTERS"></a><a
///              id="pdh_noexpandcounters"></a><dl> <dt><b>PDH_NOEXPANDCOUNTERS</b></dt> </dl> </td> <td width="60%"> Do not
///              expand the counter name if the path contains a wildcard character for counter name. </td> </tr> <tr> <td
///              width="40%"><a id="PDH_NOEXPANDINSTANCES"></a><a id="pdh_noexpandinstances"></a><dl>
///              <dt><b>PDH_NOEXPANDINSTANCES</b></dt> </dl> </td> <td width="60%"> Do not expand the instance name if the path
///              contains a wildcard character for parent instance, instance name, or instance index. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>mszExpandedPathList</i> buffer is not large
///    enough to contain the list of paths. This return value is expected if <i>pcchPathListLength</i> is zero on input.
///    If the specified size on input is greater than zero but less than the required size, you should not rely on the
///    returned size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_PATH</b></dt> </dl> </td> <td
///    width="60%"> The specified object does not contain an instance. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to support
///    this function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td
///    width="60%"> Unable to find the specified object on the computer or in the log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhExpandWildCardPathW(const(PWSTR) szDataSource, const(PWSTR) szWildCardPath, 
                           /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszExpandedPathList, 
                           uint* pcchPathListLength, uint dwFlags);

///Opens the specified log file for reading or writing.
///Params:
///    szLogFileName = <b>Null</b>-terminated string that specifies the name of the log file to open. The name can contain an absolute
///                    or relative path. If the <i>lpdwLogType</i> parameter is <b>PDH_LOG_TYPE_SQL</b>, specify the name of the log
///                    file in the form, <b>SQL:</b><i>DataSourceName</i><b>!</b><i>LogFileName</i>.
///    dwAccessFlags = Type of access to use to open the log file. Specify one of the following values. <table> <tr> <th>Value</th>
///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_LOG_READ_ACCESS"></a><a id="pdh_log_read_access"></a><dl>
///                    <dt><b>PDH_LOG_READ_ACCESS</b></dt> </dl> </td> <td width="60%"> Open the log file for reading. </td> </tr> <tr>
///                    <td width="40%"><a id="PDH_LOG_WRITE_ACCESS"></a><a id="pdh_log_write_access"></a><dl>
///                    <dt><b>PDH_LOG_WRITE_ACCESS</b></dt> </dl> </td> <td width="60%"> Open a new log file for writing. </td> </tr>
///                    <tr> <td width="40%"><a id="PDH_LOG_UPDATE_ACCESS"></a><a id="pdh_log_update_access"></a><dl>
///                    <dt><b>PDH_LOG_UPDATE_ACCESS</b></dt> </dl> </td> <td width="60%"> Open an existing log file for writing. </td>
///                    </tr> </table> You can use the bitwise inclusive <b>OR</b> operator (|) to combine the access type with one or
///                    more of the following creation flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_CREATE_NEW"></a><a id="pdh_log_create_new"></a><dl> <dt><b>PDH_LOG_CREATE_NEW</b></dt> </dl> </td>
///                    <td width="60%"> Creates a new log file with the specified name. </td> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_CREATE_ALWAYS"></a><a id="pdh_log_create_always"></a><dl> <dt><b>PDH_LOG_CREATE_ALWAYS</b></dt> </dl>
///                    </td> <td width="60%"> Creates a new log file with the specified name. If the log file already exists, the
///                    function removes the existing log file before creating the new file. </td> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_OPEN_EXISTING"></a><a id="pdh_log_open_existing"></a><dl> <dt><b>PDH_LOG_OPEN_EXISTING</b></dt> </dl>
///                    </td> <td width="60%"> Opens an existing log file with the specified name. If a log file with the specified name
///                    does not exist, this is equal to PDH_LOG_CREATE_NEW. </td> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_OPEN_ALWAYS"></a><a id="pdh_log_open_always"></a><dl> <dt><b>PDH_LOG_OPEN_ALWAYS</b></dt> </dl> </td>
///                    <td width="60%"> Opens an existing log file with the specified name or creates a new log file with the specified
///                    name. </td> </tr> <tr> <td width="40%"><a id="PDH_LOG_OPT_CIRCULAR"></a><a id="pdh_log_opt_circular"></a><dl>
///                    <dt><b>PDH_LOG_OPT_CIRCULAR</b></dt> </dl> </td> <td width="60%"> Creates a circular log file with the specified
///                    name. When the file reaches the value of the <i>dwMaxSize</i> parameter, data wraps to the beginning of the log
///                    file. You can specify this flag only if the <i>lpdwLogType</i> parameter is <b>PDH_LOG_TYPE_BINARY</b>. </td>
///                    </tr> <tr> <td width="40%"><a id="PDH_LOG_USER_STRING"></a><a id="pdh_log_user_string"></a><dl>
///                    <dt><b>PDH_LOG_USER_STRING</b></dt> </dl> </td> <td width="60%"> Used with <b>PDH_LOG_TYPE_TSV</b> to write the
///                    user caption or log file description indicated by the <i>szUserString</i> parameter of PdhUpdateLog or
///                    <b>PdhOpenLog</b>. The user caption or log file description is written as the last column in the first line of
///                    the text log. </td> </tr> </table>
///    lpdwLogType = Type of log file to open. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_UNDEFINED"></a><a
///                  id="pdh_log_type_undefined"></a><dl> <dt><b>PDH_LOG_TYPE_UNDEFINED</b></dt> </dl> </td> <td width="60%">
///                  Undefined log file format. If specified, PDH determines the log file type. You cannot specify this value if the
///                  <i>dwAccessFlags</i> parameter is <b>PDH_LOG_WRITE_ACCESS</b>. </td> </tr> <tr> <td width="40%"><a
///                  id="PDH_LOG_TYPE_CSV"></a><a id="pdh_log_type_csv"></a><dl> <dt><b>PDH_LOG_TYPE_CSV</b></dt> </dl> </td> <td
///                  width="60%"> Text file containing column headers in the first line, and individual data records in each
///                  subsequent line. The fields of each data record are comma-delimited. The first line also contains information
///                  about the format of the file, the PDH version used to create the log file, and the names and paths of each of the
///                  counters. </td> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_SQL"></a><a id="pdh_log_type_sql"></a><dl>
///                  <dt><b>PDH_LOG_TYPE_SQL</b></dt> </dl> </td> <td width="60%"> The data source of the log file is an SQL database.
///                  </td> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_TSV"></a><a id="pdh_log_type_tsv"></a><dl>
///                  <dt><b>PDH_LOG_TYPE_TSV</b></dt> </dl> </td> <td width="60%"> Text file containing column headers in the first
///                  line, and individual data records in each subsequent line. The fields of each data record are tab-delimited. The
///                  first line also contains information about the format of the file, the PDH version used to create the log file,
///                  and the names and paths of each of the counters. </td> </tr> <tr> <td width="40%"><a
///                  id="PDH_LOG_TYPE_BINARY"></a><a id="pdh_log_type_binary"></a><dl> <dt><b>PDH_LOG_TYPE_BINARY</b></dt> </dl> </td>
///                  <td width="60%"> Binary log file format. </td> </tr> </table>
///    hQuery = Specify a query handle if you are writing query data to a log file. The PdhOpenQuery function returns this
///             handle. This parameter is ignored and should be <b>NULL</b> if you are reading from the log file.
///    dwMaxSize = Maximum size of the log file, in bytes. Specify the maximum size if you want to limit the file size or if
///                <i>dwAccessFlags</i> specifies <b>PDH_LOG_OPT_CIRCULAR</b>; otherwise, set to 0. For circular log files, you must
///                specify a value large enough to hold at least one sample. Sample size depends on data being collected. However,
///                specifying a value of at least one megabyte will cover most samples.
///    szUserCaption = <b>Null</b>-terminated string that specifies the user-defined caption of the log file. A log file caption
///                    generally describes the contents of the log file. When an existing log file is opened, the value of this
///                    parameter is ignored.
///    phLog = Handle to the opened log file.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhOpenLogW(const(PWSTR) szLogFileName, uint dwAccessFlags, uint* lpdwLogType, ptrdiff_t hQuery, 
                uint dwMaxSize, const(PWSTR) szUserCaption, ptrdiff_t* phLog);

///Opens the specified log file for reading or writing.
///Params:
///    szLogFileName = <b>Null</b>-terminated string that specifies the name of the log file to open. The name can contain an absolute
///                    or relative path. If the <i>lpdwLogType</i> parameter is <b>PDH_LOG_TYPE_SQL</b>, specify the name of the log
///                    file in the form, <b>SQL:</b><i>DataSourceName</i><b>!</b><i>LogFileName</i>.
///    dwAccessFlags = Type of access to use to open the log file. Specify one of the following values. <table> <tr> <th>Value</th>
///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_LOG_READ_ACCESS"></a><a id="pdh_log_read_access"></a><dl>
///                    <dt><b>PDH_LOG_READ_ACCESS</b></dt> </dl> </td> <td width="60%"> Open the log file for reading. </td> </tr> <tr>
///                    <td width="40%"><a id="PDH_LOG_WRITE_ACCESS"></a><a id="pdh_log_write_access"></a><dl>
///                    <dt><b>PDH_LOG_WRITE_ACCESS</b></dt> </dl> </td> <td width="60%"> Open a new log file for writing. </td> </tr>
///                    <tr> <td width="40%"><a id="PDH_LOG_UPDATE_ACCESS"></a><a id="pdh_log_update_access"></a><dl>
///                    <dt><b>PDH_LOG_UPDATE_ACCESS</b></dt> </dl> </td> <td width="60%"> Open an existing log file for writing. </td>
///                    </tr> </table> You can use the bitwise inclusive <b>OR</b> operator (|) to combine the access type with one or
///                    more of the following creation flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_CREATE_NEW"></a><a id="pdh_log_create_new"></a><dl> <dt><b>PDH_LOG_CREATE_NEW</b></dt> </dl> </td>
///                    <td width="60%"> Creates a new log file with the specified name. </td> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_CREATE_ALWAYS"></a><a id="pdh_log_create_always"></a><dl> <dt><b>PDH_LOG_CREATE_ALWAYS</b></dt> </dl>
///                    </td> <td width="60%"> Creates a new log file with the specified name. If the log file already exists, the
///                    function removes the existing log file before creating the new file. </td> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_OPEN_EXISTING"></a><a id="pdh_log_open_existing"></a><dl> <dt><b>PDH_LOG_OPEN_EXISTING</b></dt> </dl>
///                    </td> <td width="60%"> Opens an existing log file with the specified name. If a log file with the specified name
///                    does not exist, this is equal to PDH_LOG_CREATE_NEW. </td> </tr> <tr> <td width="40%"><a
///                    id="PDH_LOG_OPEN_ALWAYS"></a><a id="pdh_log_open_always"></a><dl> <dt><b>PDH_LOG_OPEN_ALWAYS</b></dt> </dl> </td>
///                    <td width="60%"> Opens an existing log file with the specified name or creates a new log file with the specified
///                    name. </td> </tr> <tr> <td width="40%"><a id="PDH_LOG_OPT_CIRCULAR"></a><a id="pdh_log_opt_circular"></a><dl>
///                    <dt><b>PDH_LOG_OPT_CIRCULAR</b></dt> </dl> </td> <td width="60%"> Creates a circular log file with the specified
///                    name. When the file reaches the value of the <i>dwMaxSize</i> parameter, data wraps to the beginning of the log
///                    file. You can specify this flag only if the <i>lpdwLogType</i> parameter is <b>PDH_LOG_TYPE_BINARY</b>. </td>
///                    </tr> <tr> <td width="40%"><a id="PDH_LOG_USER_STRING"></a><a id="pdh_log_user_string"></a><dl>
///                    <dt><b>PDH_LOG_USER_STRING</b></dt> </dl> </td> <td width="60%"> Used with <b>PDH_LOG_TYPE_TSV</b> to write the
///                    user caption or log file description indicated by the <i>szUserString</i> parameter of PdhUpdateLog or
///                    <b>PdhOpenLog</b>. The user caption or log file description is written as the last column in the first line of
///                    the text log. </td> </tr> </table>
///    lpdwLogType = Type of log file to open. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_UNDEFINED"></a><a
///                  id="pdh_log_type_undefined"></a><dl> <dt><b>PDH_LOG_TYPE_UNDEFINED</b></dt> </dl> </td> <td width="60%">
///                  Undefined log file format. If specified, PDH determines the log file type. You cannot specify this value if the
///                  <i>dwAccessFlags</i> parameter is <b>PDH_LOG_WRITE_ACCESS</b>. </td> </tr> <tr> <td width="40%"><a
///                  id="PDH_LOG_TYPE_CSV"></a><a id="pdh_log_type_csv"></a><dl> <dt><b>PDH_LOG_TYPE_CSV</b></dt> </dl> </td> <td
///                  width="60%"> Text file containing column headers in the first line, and individual data records in each
///                  subsequent line. The fields of each data record are comma-delimited. The first line also contains information
///                  about the format of the file, the PDH version used to create the log file, and the names and paths of each of the
///                  counters. </td> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_SQL"></a><a id="pdh_log_type_sql"></a><dl>
///                  <dt><b>PDH_LOG_TYPE_SQL</b></dt> </dl> </td> <td width="60%"> The data source of the log file is an SQL database.
///                  </td> </tr> <tr> <td width="40%"><a id="PDH_LOG_TYPE_TSV"></a><a id="pdh_log_type_tsv"></a><dl>
///                  <dt><b>PDH_LOG_TYPE_TSV</b></dt> </dl> </td> <td width="60%"> Text file containing column headers in the first
///                  line, and individual data records in each subsequent line. The fields of each data record are tab-delimited. The
///                  first line also contains information about the format of the file, the PDH version used to create the log file,
///                  and the names and paths of each of the counters. </td> </tr> <tr> <td width="40%"><a
///                  id="PDH_LOG_TYPE_BINARY"></a><a id="pdh_log_type_binary"></a><dl> <dt><b>PDH_LOG_TYPE_BINARY</b></dt> </dl> </td>
///                  <td width="60%"> Binary log file format. </td> </tr> </table>
///    hQuery = Specify a query handle if you are writing query data to a log file. The PdhOpenQuery function returns this
///             handle. This parameter is ignored and should be <b>NULL</b> if you are reading from the log file.
///    dwMaxSize = Maximum size of the log file, in bytes. Specify the maximum size if you want to limit the file size or if
///                <i>dwAccessFlags</i> specifies <b>PDH_LOG_OPT_CIRCULAR</b>; otherwise, set to 0. For circular log files, you must
///                specify a value large enough to hold at least one sample. Sample size depends on data being collected. However,
///                specifying a value of at least one megabyte will cover most samples.
///    szUserCaption = <b>Null</b>-terminated string that specifies the user-defined caption of the log file. A log file caption
///                    generally describes the contents of the log file. When an existing log file is opened, the value of this
///                    parameter is ignored.
///    phLog = Handle to the opened log file.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhOpenLogA(const(PSTR) szLogFileName, uint dwAccessFlags, uint* lpdwLogType, ptrdiff_t hQuery, uint dwMaxSize, 
                const(PSTR) szUserCaption, ptrdiff_t* phLog);

///Collects counter data for the current query and writes the data to the log file.
///Params:
///    hLog = Handle of a single log file to update. The PdhOpenLog function returns this handle.
///    szUserString = Null-terminated string that contains a user-defined comment to add to the data record. The string can not be
///                   empty.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The log file handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> An empty string was passed in the
///    <i>szUserString</i> parameter. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhUpdateLogW(ptrdiff_t hLog, const(PWSTR) szUserString);

///Collects counter data for the current query and writes the data to the log file.
///Params:
///    hLog = Handle of a single log file to update. The PdhOpenLog function returns this handle.
///    szUserString = Null-terminated string that contains a user-defined comment to add to the data record. The string can not be
///                   empty.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The log file handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> An empty string was passed in the
///    <i>szUserString</i> parameter. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhUpdateLogA(ptrdiff_t hLog, const(PSTR) szUserString);

///Synchronizes the information in the log file catalog with the performance data in the log file. <div
///class="alert"><b>Note</b> This function is obsolete.</div><div> </div>
///Params:
///    hLog = Handle to the log file containing the file catalog to update. The PdhOpenLog function.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_NOT_IMPLEMENTED</b></dt> </dl> </td> <td
///    width="60%"> A handle to a CSV or TSV log file was specified. These log file types do not have catalogs. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_UNKNOWN_LOG_FORMAT</b></dt> </dl> </td> <td width="60%"> A handle to
///    a log file with an unknown format was specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is not valid. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhUpdateLogFileCatalog(ptrdiff_t hLog);

///Returns the size of the specified log file.
///Params:
///    hLog = Handle to the log file. The PdhOpenLog or PdhBindInputDataSource function returns this handle.
///    llSize = Size of the log file, in bytes.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_LOG_FILE_OPEN_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred when trying to open the log file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is not valid. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetLogFileSize(ptrdiff_t hLog, long* llSize);

///Closes the specified log file.
///Params:
///    hLog = Handle to the log file to be closed. This handle is returned by the PdhOpenLog function.
///    dwFlags = You can specify the following flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="PDH_FLAGS_CLOSE_QUERY"></a><a id="pdh_flags_close_query"></a><dl> <dt><b>PDH_FLAGS_CLOSE_QUERY</b></dt> </dl>
///              </td> <td width="60%"> Closes the query associated with the specified log file handle. See the <i>hQuery</i>
///              parameter of PdhOpenLog. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS and closes and deletes the query. If the function fails, the
///    return value is a system error code or a PDH error code. The following is a possible value. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt>
///    </dl> </td> <td width="60%"> The log file handle is not valid. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhCloseLog(ptrdiff_t hLog, uint dwFlags);

///Displays a dialog window that prompts the user to specify the source of the performance data.
///Params:
///    hWndOwner = Owner of the dialog window. This can be <b>NULL</b> if there is no owner (the desktop becomes the owner).
///    dwFlags = Dialog boxes that will be displayed to prompt for the data source. This parameter can be one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="PDH_FLAGS_FILE_BROWSER_ONLY"></a><a id="pdh_flags_file_browser_only"></a><dl>
///              <dt><b>PDH_FLAGS_FILE_BROWSER_ONLY</b></dt> </dl> </td> <td width="60%"> Display the file browser only. Set this
///              flag when you want to prompt for the name and location of a log file only. </td> </tr> <tr> <td width="40%"><a
///              id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> Display the data source selection dialog box. The
///              dialog box lets the user select performance data from either a log file or a real-time source. If the user
///              specified that data is to be collected from a log file, a file browser is displayed for the user to specify the
///              name and location of the log file. </td> </tr> </table>
///    szDataSource = Caller-allocated buffer that receives a <b>null</b>-terminated string that contains the name of a log file that
///                   the user selected. The log file name is truncated to the size of the buffer if the buffer is too small. If the
///                   user selected a real time source, the buffer is empty.
///    pcchBufferLength = Maximum size of the <i>szDataSource</i> buffer, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> The length of the buffer passed in the <i>pcchBufferLength</i> is not equal to the actual length of
///    the <i>szDataSource</i> buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> A zero-length buffer was passed in the
///    <i>szDataSource</i> parameter. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhSelectDataSourceW(HWND hWndOwner, uint dwFlags, PWSTR szDataSource, uint* pcchBufferLength);

///Displays a dialog window that prompts the user to specify the source of the performance data.
///Params:
///    hWndOwner = Owner of the dialog window. This can be <b>NULL</b> if there is no owner (the desktop becomes the owner).
///    dwFlags = Dialog boxes that will be displayed to prompt for the data source. This parameter can be one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="PDH_FLAGS_FILE_BROWSER_ONLY"></a><a id="pdh_flags_file_browser_only"></a><dl>
///              <dt><b>PDH_FLAGS_FILE_BROWSER_ONLY</b></dt> </dl> </td> <td width="60%"> Display the file browser only. Set this
///              flag when you want to prompt for the name and location of a log file only. </td> </tr> <tr> <td width="40%"><a
///              id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> Display the data source selection dialog box. The
///              dialog box lets the user select performance data from either a log file or a real-time source. If the user
///              specified that data is to be collected from a log file, a file browser is displayed for the user to specify the
///              name and location of the log file. </td> </tr> </table>
///    szDataSource = Caller-allocated buffer that receives a <b>null</b>-terminated string that contains the name of a log file that
///                   the user selected. The log file name is truncated to the size of the buffer if the buffer is too small. If the
///                   user selected a real time source, the buffer is empty.
///    pcchBufferLength = Maximum size of the <i>szDataSource</i> buffer, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> The length of the buffer passed in the <i>pcchBufferLength</i> is not equal to the actual length of
///    the <i>szDataSource</i> buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> A zero-length buffer was passed in the
///    <i>szDataSource</i> parameter. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhSelectDataSourceA(HWND hWndOwner, uint dwFlags, PSTR szDataSource, uint* pcchBufferLength);

///Determines if the specified query is a real-time query.
///Params:
///    hQuery = Handle to the query. The PdhOpenQuery function returns this handle.
///Returns:
///    If the query is a real-time query, the return value is <b>TRUE</b>. If the query is not a real-time query, the
///    return value is <b>FALSE</b>.
///    
@DllImport("pdh")
BOOL PdhIsRealTimeQuery(ptrdiff_t hQuery);

///Limits the samples that you can read from a log file to those within the specified time range, inclusively.
///Params:
///    hQuery = Handle to the query. The PdhOpenQuery function returns this handle.
///    pInfo = A PDH_TIME_INFO structure that specifies the time range. Specify the time as local file time. The end time must
///            be greater than the start time. You can specify 0 for the start time and the maximum 64-bit value for the end
///            time if you want to read all records.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The query handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> The ending time range value must be greater
///    than the starting time range value. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhSetQueryTimeRange(ptrdiff_t hQuery, PDH_TIME_INFO* pInfo);

///Determines the time range, number of entries and, if applicable, the size of the buffer containing the performance
///data from the specified input source. To use handles to data sources, use the PdhGetDataSourceTimeRangeH function.
///Params:
///    szDataSource = Null-terminated string that specifies the name of a log file from which the time range information is retrieved.
///    pdwNumEntries = Number of structures in the <i>pInfo</i> buffer. This function collects information for only one time range, so
///                    the value is typically 1, or zero if an error occurred.
///    pInfo = A PDH_TIME_INFO structure that receives the time range.
///    pdwBufferSize = Size of the PDH_TIME_INFO structure, in bytes.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_DATA_SOURCE_IS_REAL_TIME</b></dt> </dl> </td> <td width="60%"> The current data
///    source is a real-time data source. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDataSourceTimeRangeW(const(PWSTR) szDataSource, uint* pdwNumEntries, PDH_TIME_INFO* pInfo, 
                               uint* pdwBufferSize);

///Determines the time range, number of entries and, if applicable, the size of the buffer containing the performance
///data from the specified input source. To use handles to data sources, use the PdhGetDataSourceTimeRangeH function.
///Params:
///    szDataSource = Null-terminated string that specifies the name of a log file from which the time range information is retrieved.
///    pdwNumEntries = Number of structures in the <i>pInfo</i> buffer. This function collects information for only one time range, so
///                    the value is typically 1, or zero if an error occurred.
///    pInfo = A PDH_TIME_INFO structure that receives the time range.
///    pdwBufferSize = Size of the PDH_TIME_INFO structure, in bytes.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_DATA_SOURCE_IS_REAL_TIME</b></dt> </dl> </td> <td width="60%"> The current data
///    source is a real-time data source. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDataSourceTimeRangeA(const(PSTR) szDataSource, uint* pdwNumEntries, PDH_TIME_INFO* pInfo, 
                               uint* pdwBufferSize);

///Uses a separate thread to collect the current raw data value for all counters in the specified query. The function
///then signals the application-defined event and waits the specified time interval before returning.
///Params:
///    hQuery = Handle of the query. The query identifies the counters that you want to collect. The PdhOpenQuery function
///             returns this handle.
///    dwIntervalTime = Time interval to wait, in seconds.
///    hNewDataEvent = Handle to the event that you want PDH to signal after the time interval expires. To create an event object, call
///                    the CreateEvent function.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The query handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_NO_DATA</b></dt>
///    </dl> </td> <td width="60%"> The query does not currently have any counters. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhCollectQueryDataEx(ptrdiff_t hQuery, uint dwIntervalTime, HANDLE hNewDataEvent);

///Computes a displayable value for the given raw counter values.
///Params:
///    dwCounterType = Type of counter. Typically, you call PdhGetCounterInfo to retrieve the counter type at the time you call
///                    PdhGetRawCounterValue to retrieve the raw counter value. For a list of counter types, see the Counter Types
///                    section of the Windows Server 2003 Deployment Kit. (The constant values are defined in Winperf.h.) Note that you
///                    cannot specify base types, for example, PERF_LARGE_RAW_BASE.
///    dwFormat = Determines the data type of the calculated value. Specify one of the following values. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_FMT_DOUBLE"></a><a
///               id="pdh_fmt_double"></a><dl> <dt><b>PDH_FMT_DOUBLE</b></dt> </dl> </td> <td width="60%"> Return the calculated
///               value as a double-precision floating point real. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LARGE"></a><a
///               id="pdh_fmt_large"></a><dl> <dt><b>PDH_FMT_LARGE</b></dt> </dl> </td> <td width="60%"> Return the calculated
///               value as a 64-bit integer. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_LONG"></a><a
///               id="pdh_fmt_long"></a><dl> <dt><b>PDH_FMT_LONG</b></dt> </dl> </td> <td width="60%"> Return the calculated value
///               as a long integer. </td> </tr> </table> You can use the bitwise inclusive OR operator (|) to combine the data
///               type with one of the following scaling factors. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_NOSCALE"></a><a id="pdh_fmt_noscale"></a><dl> <dt><b>PDH_FMT_NOSCALE</b></dt> </dl>
///               </td> <td width="60%"> Do not apply the counter's scaling factor in the calculation. </td> </tr> <tr> <td
///               width="40%"><a id="PDH_FMT_NOCAP100"></a><a id="pdh_fmt_nocap100"></a><dl> <dt><b>PDH_FMT_NOCAP100</b></dt> </dl>
///               </td> <td width="60%"> Counter values greater than 100 (for example, counter values measuring the processor load
///               on multiprocessor computers) will not be reset to 100. The default behavior is that counter values are capped at
///               a value of 100. </td> </tr> <tr> <td width="40%"><a id="PDH_FMT_1000"></a><a id="pdh_fmt_1000"></a><dl>
///               <dt><b>PDH_FMT_1000</b></dt> </dl> </td> <td width="60%"> Multiply the final value by 1,000. </td> </tr> </table>
///    pTimeBase = Pointer to the time base, if necessary for the format conversion. If time base information is not necessary for
///                the format conversion, the value of this parameter is ignored. To retrieve the time base of the counter, call
///                PdhGetCounterTimeBase.
///    pRawValue1 = Raw counter value used to compute the displayable counter value. For details, see PDH_RAW_COUNTER.
///    pRawValue2 = Raw counter value used to compute the displayable counter value. For details, see PDH_RAW_COUNTER. Some counters,
///                 for example, rate counters, require two raw values to calculate a displayable value. If the counter type does not
///                 require a second value, set this parameter to <b>NULL</b>. This value must be the older of the two raw values.
///    pFmtValue = A PDH_FMT_COUNTERVALUE structure that receives the calculated counter value.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhFormatFromRawValue(uint dwCounterType, uint dwFormat, long* pTimeBase, PDH_RAW_COUNTER* pRawValue1, 
                          PDH_RAW_COUNTER* pRawValue2, PDH_FMT_COUNTERVALUE* pFmtValue);

///Returns the time base of the specified counter.
///Params:
///    hCounter = Handle to the counter. The PdhAddCounter function returns this handle.
///    pTimeBase = Time base that specifies the number of performance values a counter samples per second.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> The specified counter does not use a time base. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr>
///    </table>
///    
@DllImport("pdh")
int PdhGetCounterTimeBase(ptrdiff_t hCounter, long* pTimeBase);

///Reads the information in the specified binary trace log file.
///Params:
///    hLog = Handle to the log file. The PdhOpenLog or PdhBindInputDataSource function returns this handle.
///    ftRecord = Time stamp of the record to be read. If the time stamp does not match a record in the log file, the function
///               returns the record that has a time stamp closest to (but not greater than) the given time stamp.
///    pRawLogRecord = Caller-allocated buffer that receives a PDH_RAW_LOG_RECORD structure; the structure contains the log file record
///                    information. Set to <b>NULL</b> if <i>pdwBufferLength</i> is zero.
///    pdwBufferLength = Size of the <i>pRawLogRecord</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                      and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                      sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                      than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid. For example, on some releases you could receive this error if the
///    specified size on input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>pRawLogRecord</i> buffer is too small to
///    contain the path elements. This return value is expected if <i>pdwBufferLength</i> is zero on input. If the
///    specified size on input is greater than zero but less than the required size, you should not rely on the returned
///    size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhReadRawLogRecord(ptrdiff_t hLog, FILETIME ftRecord, PDH_RAW_LOG_RECORD* pRawLogRecord, 
                        uint* pdwBufferLength);

///Specifies the source of the real-time data.
///Params:
///    dwDataSourceId = Source of the performance data. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                     <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DATA_SOURCE_REGISTRY"></a><a
///                     id="data_source_registry"></a><dl> <dt><b>DATA_SOURCE_REGISTRY</b></dt> </dl> </td> <td width="60%"> The data
///                     source is the registry interface. This is the default. </td> </tr> <tr> <td width="40%"><a
///                     id="DATA_SOURCE_WBEM"></a><a id="data_source_wbem"></a><dl> <dt><b>DATA_SOURCE_WBEM</b></dt> </dl> </td> <td
///                     width="60%"> The data source is a WMI provider. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following is a possible value. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> The parameter is not valid. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhSetDefaultRealTimeDataSource(uint dwDataSourceId);

///Binds one or more binary log files together for reading log data.
///Params:
///    phDataSource = Handle to the bound data sources.
///    LogFileNameList = <b>Null</b>-terminated string that contains one or more binary log files to bind together. Terminate each log
///                      file name with a <b>null</b>-terminator character and the list with one additional <b>null</b>-terminator
///                      character. The log file names can contain absolute or relative paths. You cannot specify more than 32 log files.
///                      If <b>NULL</b>, the source is a real-time data source.
///Returns:
///    Returns ERROR_SUCCESS if the function succeeds. If the function fails, the return value is a system error code or
///    a PDH error code.
///    
@DllImport("pdh")
int PdhBindInputDataSourceW(ptrdiff_t* phDataSource, const(PWSTR) LogFileNameList);

///Binds one or more binary log files together for reading log data.
///Params:
///    phDataSource = Handle to the bound data sources.
///    LogFileNameList = <b>Null</b>-terminated string that contains one or more binary log files to bind together. Terminate each log
///                      file name with a <b>null</b>-terminator character and the list with one additional <b>null</b>-terminator
///                      character. The log file names can contain absolute or relative paths. You cannot specify more than 32 log files.
///                      If <b>NULL</b>, the source is a real-time data source.
///Returns:
///    Returns ERROR_SUCCESS if the function succeeds. If the function fails, the return value is a system error code or
///    a PDH error code.
///    
@DllImport("pdh")
int PdhBindInputDataSourceA(ptrdiff_t* phDataSource, const(PSTR) LogFileNameList);

///Creates a new query that is used to manage the collection of performance data. This function is identical to the
///PdhOpenQuery function, except that it supports the use of handles to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    dwUserData = User-defined value to associate with this query. To retrieve the user data later, call the PdhGetCounterInfo
///                 function and access the <b>dwQueryUserData</b> member of PDH_COUNTER_INFO.
///    phQuery = Handle to the query. You use this handle in subsequent calls.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhOpenQueryH(ptrdiff_t hDataSource, size_t dwUserData, ptrdiff_t* phQuery);

///Returns a list of the computer names associated with counters in a log file. The computer names were either specified
///when adding counters to the query or when calling the PdhConnectMachine function. The computers listed include those
///that are currently connected and online, in addition to those that are offline or not returning performance data.
///This function is identical to the PdhEnumMachines function, except that it supports the use of handles to data
///sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    mszMachineList = Caller-allocated buffer to receive the list of <b>null</b>-terminated strings that contain the computer names.
///                     The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if <i>pcchBufferLength</i>
///                     is zero.
///    pcchBufferSize = Size of the <i>mszMachineNameList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszMachineNameList</i> buffer is too small to contain all the data. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For
///    example, on some releases you could receive this error if the specified size on input is greater than zero but
///    less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumMachinesHW(ptrdiff_t hDataSource, 
                      /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszMachineList, 
                      uint* pcchBufferSize);

///Returns a list of the computer names associated with counters in a log file. The computer names were either specified
///when adding counters to the query or when calling the PdhConnectMachine function. The computers listed include those
///that are currently connected and online, in addition to those that are offline or not returning performance data.
///This function is identical to the PdhEnumMachines function, except that it supports the use of handles to data
///sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    mszMachineList = Caller-allocated buffer to receive the list of <b>null</b>-terminated strings that contain the computer names.
///                     The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if <i>pcchBufferLength</i>
///                     is zero.
///    pcchBufferSize = Size of the <i>mszMachineNameList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszMachineNameList</i> buffer is too small to contain all the data. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For
///    example, on some releases you could receive this error if the specified size on input is greater than zero but
///    less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumMachinesHA(ptrdiff_t hDataSource, 
                      /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszMachineList, 
                      uint* pcchBufferSize);

///Returns a list of objects available on the specified computer or in the specified log file. This function is
///identical to PdhEnumObjects, except that it supports the use of handles to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to enumerate the performance objects.
///                    Include the leading slashes in the computer name, for example, \\computername. If <i>szDataSource</i> is
///                    <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify the local computer.
///    mszObjectList = Caller-allocated buffer that receives the list of object names. Each object name in this list is terminated by a
///                    <b>null</b> character. The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if
///                    <i>pcchBufferLength</i> is zero.
///    pcchBufferSize = Size of the <i>mszObjectList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                     and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                     sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                     than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///                     <b>Windows XP: </b>Add one to the required buffer size.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    bRefresh = Indicates if the cached object list should be automatically refreshed. Specify one of the following values. If
///               you call this function twice, once to get the size of the list and a second time to get the actual list, set this
///               parameter to <b>TRUE</b> on the first call and <b>FALSE</b> on the second call. If both calls are <b>TRUE</b>,
///               the second call may also return PDH_MORE_DATA because the object data may have changed between calls. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
///               <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The object cache is automatically refreshed before the objects
///               are returned. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt>
///               </dl> </td> <td width="60%"> Do not automatically refresh the cache. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszObjectList</i> buffer is too small to hold the list of objects. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified computer is
///    offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectsHW(ptrdiff_t hDataSource, const(PWSTR) szMachineName, 
                     /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszObjectList, 
                     uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

///Returns a list of objects available on the specified computer or in the specified log file. This function is
///identical to PdhEnumObjects, except that it supports the use of handles to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to enumerate the performance objects.
///                    Include the leading slashes in the computer name, for example, \\computername. If <i>szDataSource</i> is
///                    <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify the local computer.
///    mszObjectList = Caller-allocated buffer that receives the list of object names. Each object name in this list is terminated by a
///                    <b>null</b> character. The list is terminated with two <b>null</b>-terminator characters. Set to <b>NULL</b> if
///                    <i>pcchBufferLength</i> is zero.
///    pcchBufferSize = Size of the <i>mszObjectList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns PDH_MORE_DATA
///                     and sets this parameter to the required buffer size. If the buffer is larger than the required size, the function
///                     sets this parameter to the actual size of the buffer that was used. If the specified size on input is greater
///                     than zero but less than the required size, you should not rely on the returned size to reallocate the buffer.
///                     <b>Windows XP: </b>Add one to the required buffer size.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    bRefresh = Indicates if the cached object list should be automatically refreshed. Specify one of the following values. If
///               you call this function twice, once to get the size of the list and a second time to get the actual list, set this
///               parameter to <b>TRUE</b> on the first call and <b>FALSE</b> on the second call. If both calls are <b>TRUE</b>,
///               the second call may also return PDH_MORE_DATA because the object data may have changed between calls. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
///               <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The object cache is automatically refreshed before the objects
///               are returned. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt>
///               </dl> </td> <td width="60%"> Do not automatically refresh the cache. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>mszObjectList</i> buffer is too small to hold the list of objects. This return value is expected if
///    <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td width="60%"> The specified computer is
///    offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td>
///    <td width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectsHA(ptrdiff_t hDataSource, const(PSTR) szMachineName, 
                     /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszObjectList, 
                     uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

///Returns the specified object's counter and instance names that exist on the specified computer or in the specified
///log file. This function is identical to the PdhEnumObjectItems function, except that it supports the use of handles
///to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer that contains the counter and instance
///                    names that you want to enumerate. Include the leading slashes in the computer name, for example, \\computername.
///                    If the <i>szDataSource</i> parameter is <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify
///                    the local computer.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose counter and instance names you want to
///                   enumerate.
///    mszCounterList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter names provided by the specified
///                     object. The list contains unique counter names. The list is terminated by two <b>NULL</b> characters. Set to
///                     <b>NULL</b> if the <i>pcchCounterListLength</i> parameter is zero.
///    pcchCounterListLength = Size of the <i>mszCounterList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                            returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                            required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                            size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                            reallocate the buffer.
///    mszInstanceList = Caller-allocated buffer that receives a list of <b>null</b>-terminated instance names provided by the specified
///                      object. The list contains unique instance names. The list is terminated by two <b>NULL</b> characters. Set to
///                      <b>NULL</b> if the <i>pcchInstanceListLength</i> parameter is zero.
///    pcchInstanceListLength = Size of the <i>mszInstanceList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                             returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                             required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                             size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                             reallocate the buffer. If the specified object does not support variable instances, then the returned value will
///                             be zero. If the specified object does support variable instances, but does not currently have any instances, then
///                             the value returned is 2, which is the size of an empty MULTI_SZ list string.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    dwFlags = This parameter must be zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    One of the buffers is too small to contain the list of names. This return value is expected if
///    <i>pcchCounterListLength</i> or <i>pcchInstanceListLength</i> is zero on input. If the specified size on input is
///    greater than zero but less than the required size, you should not rely on the returned size to reallocate the
///    buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%">
///    A parameter is not valid. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to support
///    this function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td
///    width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> The specified object could not be found on the
///    specified computer or in the specified log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectItemsHW(ptrdiff_t hDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                         /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszCounterList, 
                         uint* pcchCounterListLength, 
                         /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszInstanceList, 
                         uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

///Returns the specified object's counter and instance names that exist on the specified computer or in the specified
///log file. This function is identical to the PdhEnumObjectItems function, except that it supports the use of handles
///to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer that contains the counter and instance
///                    names that you want to enumerate. Include the leading slashes in the computer name, for example, \\computername.
///                    If the <i>szDataSource</i> parameter is <b>NULL</b>, you can set <i>szMachineName</i> to <b>NULL</b> to specify
///                    the local computer.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose counter and instance names you want to
///                   enumerate.
///    mszCounterList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter names provided by the specified
///                     object. The list contains unique counter names. The list is terminated by two <b>NULL</b> characters. Set to
///                     <b>NULL</b> if the <i>pcchCounterListLength</i> parameter is zero.
///    pcchCounterListLength = Size of the <i>mszCounterList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                            returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                            required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                            size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                            reallocate the buffer.
///    mszInstanceList = Caller-allocated buffer that receives a list of <b>null</b>-terminated instance names provided by the specified
///                      object. The list contains unique instance names. The list is terminated by two <b>NULL</b> characters. Set to
///                      <b>NULL</b> if the <i>pcchInstanceListLength</i> parameter is zero.
///    pcchInstanceListLength = Size of the <i>mszInstanceList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the function
///                             returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the
///                             required size, the function sets this parameter to the actual size of the buffer that was used. If the specified
///                             size on input is greater than zero but less than the required size, you should not rely on the returned size to
///                             reallocate the buffer. If the specified object does not support variable instances, then the returned value will
///                             be zero. If the specified object does support variable instances, but does not currently have any instances, then
///                             the value returned is 2, which is the size of an empty MULTI_SZ list string.
///    dwDetailLevel = Detail level of the performance items to return. All items that are of the specified detail level or less will be
///                    returned (the levels are listed in increasing order). This parameter can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_NOVICE"></a><a
///                    id="perf_detail_novice"></a><dl> <dt><b>PERF_DETAIL_NOVICE</b></dt> </dl> </td> <td width="60%"> Novice user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_ADVANCED"></a><a
///                    id="perf_detail_advanced"></a><dl> <dt><b>PERF_DETAIL_ADVANCED</b></dt> </dl> </td> <td width="60%"> Advanced
///                    user level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_EXPERT"></a><a
///                    id="perf_detail_expert"></a><dl> <dt><b>PERF_DETAIL_EXPERT</b></dt> </dl> </td> <td width="60%"> Expert user
///                    level of detail. </td> </tr> <tr> <td width="40%"><a id="PERF_DETAIL_WIZARD"></a><a
///                    id="perf_detail_wizard"></a><dl> <dt><b>PERF_DETAIL_WIZARD</b></dt> </dl> </td> <td width="60%"> System designer
///                    level of detail. </td> </tr> </table>
///    dwFlags = This parameter must be zero.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    One of the buffers is too small to contain the list of names. This return value is expected if
///    <i>pcchCounterListLength</i> or <i>pcchInstanceListLength</i> is zero on input. If the specified size on input is
///    greater than zero but less than the required size, you should not rely on the returned size to reallocate the
///    buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%">
///    A parameter is not valid. For example, on some releases you could receive this error if the specified size on
///    input is greater than zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to support
///    this function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td> <td
///    width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> The specified object could not be found on the
///    specified computer or in the specified log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumObjectItemsHA(ptrdiff_t hDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                         /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszCounterList, 
                         uint* pcchCounterListLength, 
                         /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszInstanceList, 
                         uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

///Examines the specified computer or log file and returns those counter paths that match the given counter path which
///contains wildcard characters. This function is identical to the PdhExpandWildCardPath function, except that it
///supports the use of handles to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    szWildCardPath = <b>Null</b>-terminated string that specifies the counter path to expand. The maximum length of a counter path is
///                     PDH_MAX_COUNTER_PATH. If <i>hDataSource</i> is a real time data source, the function searches the computer
///                     specified in the path for matches. If the path does not specify a computer, the function searches the local
///                     computer.
///    mszExpandedPathList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter paths that match the wildcard
///                          specification in the <i>szWildCardPath</i>. The list is terminated by two <b>NULL</b> characters. Set to
///                          <b>NULL</b> if <i>pcchPathListLength</i> is zero.
///    pcchPathListLength = Size of the <i>mszExpandedPathList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the
///                         function returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than
///                         the required size, the function sets this parameter to the actual size of the buffer that was used. If the
///                         specified size on input is greater than zero but less than the required size, you should not rely on the returned
///                         size to reallocate the buffer. <div class="alert"><b>Note</b> You must add one to the required size on Windows
///                         XP.</div> <div> </div>
///    dwFlags = Flags that indicate which wildcard characters not to expand. You can specify one or more flags. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_NOEXPANDCOUNTERS"></a><a
///              id="pdh_noexpandcounters"></a><dl> <dt><b>PDH_NOEXPANDCOUNTERS</b></dt> </dl> </td> <td width="60%"> Do not
///              expand the counter name if the path contains a wildcard character for counter name. </td> </tr> <tr> <td
///              width="40%"><a id="PDH_NOEXPANDINSTANCES"></a><a id="pdh_noexpandinstances"></a><dl>
///              <dt><b>PDH_NOEXPANDINSTANCES</b></dt> </dl> </td> <td width="60%"> Do not expand the instance name if the path
///              contains a wildcard character for parent instance, instance name, or instance index. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>mszExpandedPathList</i> buffer is not large
///    enough to contain the list of paths. This return value is expected if <i>pcchPathListLength</i> is zero on input.
///    If the specified size on input is greater than zero but less than the required size, you should not rely on the
///    returned size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td>
///    <td width="60%"> Unable to allocate memory to support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> Unable to find the specified object on the
///    computer or in the log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhExpandWildCardPathHW(ptrdiff_t hDataSource, const(PWSTR) szWildCardPath, 
                            /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszExpandedPathList, 
                            uint* pcchPathListLength, uint dwFlags);

///Examines the specified computer or log file and returns those counter paths that match the given counter path which
///contains wildcard characters. This function is identical to the PdhExpandWildCardPath function, except that it
///supports the use of handles to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    szWildCardPath = <b>Null</b>-terminated string that specifies the counter path to expand. The maximum length of a counter path is
///                     PDH_MAX_COUNTER_PATH. If <i>hDataSource</i> is a real time data source, the function searches the computer
///                     specified in the path for matches. If the path does not specify a computer, the function searches the local
///                     computer.
///    mszExpandedPathList = Caller-allocated buffer that receives a list of <b>null</b>-terminated counter paths that match the wildcard
///                          specification in the <i>szWildCardPath</i>. The list is terminated by two <b>NULL</b> characters. Set to
///                          <b>NULL</b> if <i>pcchPathListLength</i> is zero.
///    pcchPathListLength = Size of the <i>mszExpandedPathList</i> buffer, in <b>TCHARs</b>. If zero on input and the object exists, the
///                         function returns PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than
///                         the required size, the function sets this parameter to the actual size of the buffer that was used. If the
///                         specified size on input is greater than zero but less than the required size, you should not rely on the returned
///                         size to reallocate the buffer. <div class="alert"><b>Note</b> You must add one to the required size on Windows
///                         XP.</div> <div> </div>
///    dwFlags = Flags that indicate which wildcard characters not to expand. You can specify one or more flags. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PDH_NOEXPANDCOUNTERS"></a><a
///              id="pdh_noexpandcounters"></a><dl> <dt><b>PDH_NOEXPANDCOUNTERS</b></dt> </dl> </td> <td width="60%"> Do not
///              expand the counter name if the path contains a wildcard character for counter name. </td> </tr> <tr> <td
///              width="40%"><a id="PDH_NOEXPANDINSTANCES"></a><a id="pdh_noexpandinstances"></a><dl>
///              <dt><b>PDH_NOEXPANDINSTANCES</b></dt> </dl> </td> <td width="60%"> Do not expand the instance name if the path
///              contains a wildcard character for parent instance, instance name, or instance index. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>mszExpandedPathList</i> buffer is not large
///    enough to contain the list of paths. This return value is expected if <i>pcchPathListLength</i> is zero on input.
///    If the specified size on input is greater than zero but less than the required size, you should not rely on the
///    returned size to reallocate the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid. For example, on some
///    releases you could receive this error if the specified size on input is greater than zero but less than the
///    required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td>
///    <td width="60%"> Unable to allocate memory to support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td width="60%"> Unable to find the specified object on the
///    computer or in the log file. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhExpandWildCardPathHA(ptrdiff_t hDataSource, const(PSTR) szWildCardPath, 
                            /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszExpandedPathList, 
                            uint* pcchPathListLength, uint dwFlags);

///Determines the time range, number of entries and, if applicable, the size of the buffer containing the performance
///data from the specified input source. This function is identical to the PdhGetDataSourceTimeRange function, except
///that it supports the use of handles to data sources.
///Params:
///    hDataSource = Handle to a data source returned by the PdhBindInputDataSource function.
///    pdwNumEntries = Number of structures in the <i>pInfo</i> buffer. This function collects information for only one time range, so
///                    the value is typically 1, or zero if an error occurred.
///    pInfo = A PDH_TIME_INFO structure that receives the time range. The information spans all bound log files.
///    pdwBufferSize = Size of the PDH_TIME_INFO structure, in bytes.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td
///    width="60%"> A parameter is not valid or is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The counter handle is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_DATA_SOURCE_IS_REAL_TIME</b></dt> </dl> </td> <td width="60%"> The current data
///    source is a real-time data source. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDataSourceTimeRangeH(ptrdiff_t hDataSource, uint* pdwNumEntries, PDH_TIME_INFO* pInfo, 
                               uint* pdwBufferSize);

///Retrieves the name of the default object. This name can be used to set the initial object selection in the Browse
///Counter dialog box. This function is identical to the PdhGetDefaultPerfObject function, except that it supports the
///use of handles to data sources.
///Params:
///    hDataSource = Should be <b>NULL</b>. If you specify a log file handle, <i>szDefaultObjectName</i> will be a <b>null</b> string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the name.
///    szDefaultObjectName = Caller-allocated buffer that receives the <b>null</b>-terminated default object name. Set to <b>NULL</b> if
///                          <i>pcchBufferSize</i> is zero. Note that PDH always returns Processor for the default object name.
///    pcchBufferSize = Size of the <i>szDefaultObjectName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultObjectName</i> buffer is too small to contain the object name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The default object name cannot be read or
///    found. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfObjectHW(ptrdiff_t hDataSource, const(PWSTR) szMachineName, PWSTR szDefaultObjectName, 
                              uint* pcchBufferSize);

///Retrieves the name of the default object. This name can be used to set the initial object selection in the Browse
///Counter dialog box. This function is identical to the PdhGetDefaultPerfObject function, except that it supports the
///use of handles to data sources.
///Params:
///    hDataSource = Should be <b>NULL</b>. If you specify a log file handle, <i>szDefaultObjectName</i> will be a <b>null</b> string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the name.
///    szDefaultObjectName = Caller-allocated buffer that receives the <b>null</b>-terminated default object name. Set to <b>NULL</b> if
///                          <i>pcchBufferSize</i> is zero. Note that PDH always returns Processor for the default object name.
///    pcchBufferSize = Size of the <i>szDefaultObjectName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultObjectName</i> buffer is too small to contain the object name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The default object name cannot be read or
///    found. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfObjectHA(ptrdiff_t hDataSource, const(PSTR) szMachineName, PSTR szDefaultObjectName, 
                              uint* pcchBufferSize);

///Retrieves the name of the default counter for the specified object. This name can be used to set the initial counter
///selection in the Browse Counter dialog box. This function is identical to PdhGetDefaultPerfCounter, except that it
///supports the use of handles to data sources.
///Params:
///    hDataSource = Should be <b>NULL</b>. If you specify a log file handle, <i>szDefaultCounterName</i> will be a <b>null</b>
///                  string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the name.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose default counter name you want to
///                   retrieve.
///    szDefaultCounterName = Caller-allocated buffer that receives the <b>null</b>-terminated default counter name. Set to <b>NULL</b> if
///                           <i>pcchBufferSize</i> is zero.
///    pcchBufferSize = Size of the <i>szDefaultCounterName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultCounterName</i> buffer is too small to contain the counter name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The default counter name cannot be read
///    or found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td
///    width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The object did not specify a default counter.
///    </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfCounterHW(ptrdiff_t hDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                               PWSTR szDefaultCounterName, uint* pcchBufferSize);

///Retrieves the name of the default counter for the specified object. This name can be used to set the initial counter
///selection in the Browse Counter dialog box. This function is identical to PdhGetDefaultPerfCounter, except that it
///supports the use of handles to data sources.
///Params:
///    hDataSource = Should be <b>NULL</b>. If you specify a log file handle, <i>szDefaultCounterName</i> will be a <b>null</b>
///                  string.
///    szMachineName = <b>Null</b>-terminated string that specifies the name of the computer used to verify the object name. If
///                    <b>NULL</b>, the local computer is used to verify the name.
///    szObjectName = <b>Null</b>-terminated string that specifies the name of the object whose default counter name you want to
///                   retrieve.
///    szDefaultCounterName = Caller-allocated buffer that receives the <b>null</b>-terminated default counter name. Set to <b>NULL</b> if
///                           <i>pcchBufferSize</i> is zero.
///    pcchBufferSize = Size of the <i>szDefaultCounterName</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                     PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                     size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                     input is greater than zero but less than the required size, you should not rely on the returned size to
///                     reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The <i>szDefaultCounterName</i> buffer is too small to contain the counter name. This return value is expected if
///    <i>pcchBufferSize</i> is zero on input. If the specified size on input is greater than zero but less than the
///    required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A required parameter is not
///    valid. For example, on some releases you could receive this error if the specified size on input is greater than
///    zero but less than the required size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_MEMORY_ALLOCATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory in order to
///    complete the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_MACHINE</b></dt> </dl> </td>
///    <td width="60%"> The specified computer is offline or unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTERNAME</b></dt> </dl> </td> <td width="60%"> The default counter name cannot be read
///    or found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_CSTATUS_NO_OBJECT</b></dt> </dl> </td> <td
///    width="60%"> The specified object could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDH_CSTATUS_NO_COUNTER</b></dt> </dl> </td> <td width="60%"> The object did not specify a default counter.
///    </td> </tr> </table>
///    
@DllImport("pdh")
int PdhGetDefaultPerfCounterHA(ptrdiff_t hDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                               PSTR szDefaultCounterName, uint* pcchBufferSize);

///Displays a <b>Browse Counters</b> dialog box that the user can use to select one or more counters that they want to
///add to the query. This function is identical to the PdhBrowseCounters function, except that it supports the use of
///handles to data sources.
///Params:
///    pBrowseDlgData = A PDH_BROWSE_DLG_CONFIG_H structure that specifies the behavior of the dialog box.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhBrowseCountersHW(PDH_BROWSE_DLG_CONFIG_HW* pBrowseDlgData);

///Displays a <b>Browse Counters</b> dialog box that the user can use to select one or more counters that they want to
///add to the query. This function is identical to the PdhBrowseCounters function, except that it supports the use of
///handles to data sources.
///Params:
///    pBrowseDlgData = A PDH_BROWSE_DLG_CONFIG_H structure that specifies the behavior of the dialog box.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code.
///    
@DllImport("pdh")
int PdhBrowseCountersHA(PDH_BROWSE_DLG_CONFIG_HA* pBrowseDlgData);

@DllImport("pdh")
int PdhVerifySQLDBW(const(PWSTR) szDataSource);

@DllImport("pdh")
int PdhVerifySQLDBA(const(PSTR) szDataSource);

@DllImport("pdh")
int PdhCreateSQLTablesW(const(PWSTR) szDataSource);

@DllImport("pdh")
int PdhCreateSQLTablesA(const(PSTR) szDataSource);

///Enumerates the names of the log sets within the DSN.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the DSN.
///    mszDataSetNameList = Caller-allocated buffer that receives the list of <b>null</b>-terminated log set names. The list is terminated
///                         with a <b>null</b>-terminator character. Set to <b>NULL</b> if the <i>pcchBufferLength</i> parameter is zero.
///    pcchBufferLength = Size of the <i>mszLogSetNameList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                       PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                       size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                       input is greater than zero but less than the required size, you should not rely on the returned size to
///                       reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The size of the <i>mszLogSetNameList</i> buffer is too small to contain all the data. This return value is
///    expected if <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but
///    less than the required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid.
///    For example, on some releases you could receive this error if the specified size on input is greater than zero
///    but less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumLogSetNamesW(const(PWSTR) szDataSource, 
                        /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR mszDataSetNameList, 
                        uint* pcchBufferLength);

///Enumerates the names of the log sets within the DSN.
///Params:
///    szDataSource = <b>Null</b>-terminated string that specifies the DSN.
///    mszDataSetNameList = Caller-allocated buffer that receives the list of <b>null</b>-terminated log set names. The list is terminated
///                         with a <b>null</b>-terminator character. Set to <b>NULL</b> if the <i>pcchBufferLength</i> parameter is zero.
///    pcchBufferLength = Size of the <i>mszLogSetNameList</i> buffer, in <b>TCHARs</b>. If zero on input, the function returns
///                       PDH_MORE_DATA and sets this parameter to the required buffer size. If the buffer is larger than the required
///                       size, the function sets this parameter to the actual size of the buffer that was used. If the specified size on
///                       input is greater than zero but less than the required size, you should not rely on the returned size to
///                       reallocate the buffer.
///Returns:
///    If the function succeeds, it returns ERROR_SUCCESS. If the function fails, the return value is a system error
///    code or a PDH error code. The following are possible values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDH_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    The size of the <i>mszLogSetNameList</i> buffer is too small to contain all the data. This return value is
///    expected if <i>pcchBufferLength</i> is zero on input. If the specified size on input is greater than zero but
///    less than the required size, you should not rely on the returned size to reallocate the buffer. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDH_INVALID_ARGUMENT</b></dt> </dl> </td> <td width="60%"> A parameter is not valid.
///    For example, on some releases you could receive this error if the specified size on input is greater than zero
///    but less than the required size. </td> </tr> </table>
///    
@DllImport("pdh")
int PdhEnumLogSetNamesA(const(PSTR) szDataSource, 
                        /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PSTR mszDataSetNameList, 
                        uint* pcchBufferLength);

@DllImport("pdh")
int PdhGetLogSetGUID(ptrdiff_t hLog, GUID* pGuid, int* pRunId);

@DllImport("pdh")
int PdhSetLogSetRunID(ptrdiff_t hLog, int RunId);


