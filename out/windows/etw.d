module windows.etw;

public import system;
public import windows.automation;
public import windows.com;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

alias TDH_HANDLE = int;
struct WNODE_HEADER
{
    uint BufferSize;
    uint ProviderId;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    Guid Guid;
    uint ClientContext;
    uint Flags;
}

struct OFFSETINSTANCEDATAANDLENGTH
{
    uint OffsetInstanceData;
    uint LengthInstanceData;
}

struct WNODE_ALL_DATA
{
    WNODE_HEADER WnodeHeader;
    uint DataBlockOffset;
    uint InstanceCount;
    uint OffsetInstanceNameOffsets;
    _Anonymous_e__Union Anonymous;
}

struct WNODE_SINGLE_INSTANCE
{
    WNODE_HEADER WnodeHeader;
    uint OffsetInstanceName;
    uint InstanceIndex;
    uint DataBlockOffset;
    uint SizeDataBlock;
    ubyte VariableData;
}

struct WNODE_SINGLE_ITEM
{
    WNODE_HEADER WnodeHeader;
    uint OffsetInstanceName;
    uint InstanceIndex;
    uint ItemId;
    uint DataBlockOffset;
    uint SizeDataItem;
    ubyte VariableData;
}

struct WNODE_METHOD_ITEM
{
    WNODE_HEADER WnodeHeader;
    uint OffsetInstanceName;
    uint InstanceIndex;
    uint MethodId;
    uint DataBlockOffset;
    uint SizeDataBlock;
    ubyte VariableData;
}

struct WNODE_EVENT_ITEM
{
    WNODE_HEADER WnodeHeader;
}

struct WNODE_EVENT_REFERENCE
{
    WNODE_HEADER WnodeHeader;
    Guid TargetGuid;
    uint TargetDataBlockSize;
    _Anonymous_e__Union Anonymous;
}

struct WNODE_TOO_SMALL
{
    WNODE_HEADER WnodeHeader;
    uint SizeNeeded;
}

struct WMIREGGUIDW
{
    Guid Guid;
    uint Flags;
    uint InstanceCount;
    _Anonymous_e__Union Anonymous;
}

struct WMIREGINFOW
{
    uint BufferSize;
    uint NextWmiRegInfo;
    uint RegistryPath;
    uint MofResourceName;
    uint GuidCount;
    WMIREGGUIDW WmiRegGuid;
}

enum WMIDPREQUESTCODE
{
    WMI_GET_ALL_DATA = 0,
    WMI_GET_SINGLE_INSTANCE = 1,
    WMI_SET_SINGLE_INSTANCE = 2,
    WMI_SET_SINGLE_ITEM = 3,
    WMI_ENABLE_EVENTS = 4,
    WMI_DISABLE_EVENTS = 5,
    WMI_ENABLE_COLLECTION = 6,
    WMI_DISABLE_COLLECTION = 7,
    WMI_REGINFO = 8,
    WMI_EXECUTE_METHOD = 9,
    WMI_CAPTURE_STATE = 10,
}

enum ETW_COMPRESSION_RESUMPTION_MODE
{
    EtwCompressionModeRestart = 0,
    EtwCompressionModeNoDisable = 1,
    EtwCompressionModeNoRestart = 2,
}

struct EVENT_TRACE_HEADER
{
    ushort Size;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    uint ThreadId;
    uint ProcessId;
    LARGE_INTEGER TimeStamp;
    _Anonymous3_e__Union Anonymous3;
    _Anonymous4_e__Union Anonymous4;
}

struct EVENT_INSTANCE_HEADER
{
    ushort Size;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    uint ThreadId;
    uint ProcessId;
    LARGE_INTEGER TimeStamp;
    ulong RegHandle;
    uint InstanceId;
    uint ParentInstanceId;
    _Anonymous3_e__Union Anonymous3;
    ulong ParentRegHandle;
}

struct MOF_FIELD
{
    ulong DataPtr;
    uint Length;
    uint DataType;
}

struct TRACE_LOGFILE_HEADER
{
    uint BufferSize;
    _Anonymous1_e__Union Anonymous1;
    uint ProviderVersion;
    uint NumberOfProcessors;
    LARGE_INTEGER EndTime;
    uint TimerResolution;
    uint MaximumFileSize;
    uint LogFileMode;
    uint BuffersWritten;
    _Anonymous2_e__Union Anonymous2;
    const(wchar)* LoggerName;
    const(wchar)* LogFileName;
    TIME_ZONE_INFORMATION TimeZone;
    LARGE_INTEGER BootTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER StartTime;
    uint ReservedFlags;
    uint BuffersLost;
}

struct TRACE_LOGFILE_HEADER32
{
    uint BufferSize;
    _Anonymous1_e__Union Anonymous1;
    uint ProviderVersion;
    uint NumberOfProcessors;
    LARGE_INTEGER EndTime;
    uint TimerResolution;
    uint MaximumFileSize;
    uint LogFileMode;
    uint BuffersWritten;
    _Anonymous2_e__Union Anonymous2;
    uint LoggerName;
    uint LogFileName;
    TIME_ZONE_INFORMATION TimeZone;
    LARGE_INTEGER BootTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER StartTime;
    uint ReservedFlags;
    uint BuffersLost;
}

struct TRACE_LOGFILE_HEADER64
{
    uint BufferSize;
    _Anonymous1_e__Union Anonymous1;
    uint ProviderVersion;
    uint NumberOfProcessors;
    LARGE_INTEGER EndTime;
    uint TimerResolution;
    uint MaximumFileSize;
    uint LogFileMode;
    uint BuffersWritten;
    _Anonymous2_e__Union Anonymous2;
    ulong LoggerName;
    ulong LogFileName;
    TIME_ZONE_INFORMATION TimeZone;
    LARGE_INTEGER BootTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER StartTime;
    uint ReservedFlags;
    uint BuffersLost;
}

struct EVENT_INSTANCE_INFO
{
    HANDLE RegHandle;
    uint InstanceId;
}

struct EVENT_TRACE_PROPERTIES
{
    WNODE_HEADER Wnode;
    uint BufferSize;
    uint MinimumBuffers;
    uint MaximumBuffers;
    uint MaximumFileSize;
    uint LogFileMode;
    uint FlushTimer;
    uint EnableFlags;
    _Anonymous_e__Union Anonymous;
    uint NumberOfBuffers;
    uint FreeBuffers;
    uint EventsLost;
    uint BuffersWritten;
    uint LogBuffersLost;
    uint RealTimeBuffersLost;
    HANDLE LoggerThreadId;
    uint LogFileNameOffset;
    uint LoggerNameOffset;
}

struct EVENT_TRACE_PROPERTIES_V2
{
    WNODE_HEADER Wnode;
    uint BufferSize;
    uint MinimumBuffers;
    uint MaximumBuffers;
    uint MaximumFileSize;
    uint LogFileMode;
    uint FlushTimer;
    uint EnableFlags;
    _Anonymous1_e__Union Anonymous1;
    uint NumberOfBuffers;
    uint FreeBuffers;
    uint EventsLost;
    uint BuffersWritten;
    uint LogBuffersLost;
    uint RealTimeBuffersLost;
    HANDLE LoggerThreadId;
    uint LogFileNameOffset;
    uint LoggerNameOffset;
    _Anonymous2_e__Union Anonymous2;
    uint FilterDescCount;
    EVENT_FILTER_DESCRIPTOR* FilterDesc;
    _Anonymous3_e__Union Anonymous3;
}

struct TRACE_GUID_REGISTRATION
{
    Guid* Guid;
    HANDLE RegHandle;
}

struct TRACE_GUID_PROPERTIES
{
    Guid Guid;
    uint GuidType;
    uint LoggerId;
    uint EnableLevel;
    uint EnableFlags;
    ubyte IsEnable;
}

struct ETW_BUFFER_CONTEXT
{
    _Anonymous_e__Union Anonymous;
    ushort LoggerId;
}

struct TRACE_ENABLE_INFO
{
    uint IsEnabled;
    ubyte Level;
    ubyte Reserved1;
    ushort LoggerId;
    uint EnableProperty;
    uint Reserved2;
    ulong MatchAnyKeyword;
    ulong MatchAllKeyword;
}

struct TRACE_PROVIDER_INSTANCE_INFO
{
    uint NextOffset;
    uint EnableCount;
    uint Pid;
    uint Flags;
}

struct TRACE_GUID_INFO
{
    uint InstanceCount;
    uint Reserved;
}

struct PROFILE_SOURCE_INFO
{
    uint NextEntryOffset;
    uint Source;
    uint MinInterval;
    uint MaxInterval;
    ulong Reserved;
    ushort Description;
}

struct EVENT_TRACE
{
    EVENT_TRACE_HEADER Header;
    uint InstanceId;
    uint ParentInstanceId;
    Guid ParentGuid;
    void* MofData;
    uint MofLength;
    _Anonymous_e__Union Anonymous;
}

alias PEVENT_TRACE_BUFFER_CALLBACKW = extern(Windows) uint function(EVENT_TRACE_LOGFILEW* Logfile);
alias PEVENT_TRACE_BUFFER_CALLBACKA = extern(Windows) uint function(EVENT_TRACE_LOGFILEA* Logfile);
alias PEVENT_CALLBACK = extern(Windows) void function(EVENT_TRACE* pEvent);
alias PEVENT_RECORD_CALLBACK = extern(Windows) void function(EVENT_RECORD* EventRecord);
alias WMIDPREQUEST = extern(Windows) uint function(WMIDPREQUESTCODE RequestCode, void* RequestContext, uint* BufferSize, void* Buffer);
struct EVENT_TRACE_LOGFILEW
{
    const(wchar)* LogFileName;
    const(wchar)* LoggerName;
    long CurrentTime;
    uint BuffersRead;
    _Anonymous1_e__Union Anonymous1;
    EVENT_TRACE CurrentEvent;
    TRACE_LOGFILE_HEADER LogfileHeader;
    PEVENT_TRACE_BUFFER_CALLBACKW BufferCallback;
    uint BufferSize;
    uint Filled;
    uint EventsLost;
    _Anonymous2_e__Union Anonymous2;
    uint IsKernelTrace;
    void* Context;
}

struct EVENT_TRACE_LOGFILEA
{
    const(char)* LogFileName;
    const(char)* LoggerName;
    long CurrentTime;
    uint BuffersRead;
    _Anonymous1_e__Union Anonymous1;
    EVENT_TRACE CurrentEvent;
    TRACE_LOGFILE_HEADER LogfileHeader;
    PEVENT_TRACE_BUFFER_CALLBACKA BufferCallback;
    uint BufferSize;
    uint Filled;
    uint EventsLost;
    _Anonymous2_e__Union Anonymous2;
    uint IsKernelTrace;
    void* Context;
}

struct ENABLE_TRACE_PARAMETERS_V1
{
    uint Version;
    uint EnableProperty;
    uint ControlFlags;
    Guid SourceId;
    EVENT_FILTER_DESCRIPTOR* EnableFilterDesc;
}

struct ENABLE_TRACE_PARAMETERS
{
    uint Version;
    uint EnableProperty;
    uint ControlFlags;
    Guid SourceId;
    EVENT_FILTER_DESCRIPTOR* EnableFilterDesc;
    uint FilterDescCount;
}

enum TRACE_QUERY_INFO_CLASS
{
    TraceGuidQueryList = 0,
    TraceGuidQueryInfo = 1,
    TraceGuidQueryProcess = 2,
    TraceStackTracingInfo = 3,
    TraceSystemTraceEnableFlagsInfo = 4,
    TraceSampledProfileIntervalInfo = 5,
    TraceProfileSourceConfigInfo = 6,
    TraceProfileSourceListInfo = 7,
    TracePmcEventListInfo = 8,
    TracePmcCounterListInfo = 9,
    TraceSetDisallowList = 10,
    TraceVersionInfo = 11,
    TraceGroupQueryList = 12,
    TraceGroupQueryInfo = 13,
    TraceDisallowListQuery = 14,
    TraceInfoReserved15 = 15,
    TracePeriodicCaptureStateListInfo = 16,
    TracePeriodicCaptureStateInfo = 17,
    TraceProviderBinaryTracking = 18,
    TraceMaxLoggersQuery = 19,
    TraceLbrConfigurationInfo = 20,
    TraceLbrEventListInfo = 21,
    TraceMaxPmcCounterQuery = 22,
    MaxTraceSetInfoClass = 23,
}

struct CLASSIC_EVENT_ID
{
    Guid EventGuid;
    ubyte Type;
    ubyte Reserved;
}

struct TRACE_PROFILE_INTERVAL
{
    uint Source;
    uint Interval;
}

struct TRACE_VERSION_INFO
{
    uint EtwTraceProcessingVersion;
    uint Reserved;
}

struct TRACE_PERIODIC_CAPTURE_STATE_INFO
{
    uint CaptureStateFrequencyInSeconds;
    ushort ProviderCount;
    ushort Reserved;
}

enum ETW_PROCESS_HANDLE_INFO_TYPE
{
    EtwQueryPartitionInformation = 1,
    EtwQueryPartitionInformationV2 = 2,
    EtwQueryLastDroppedTimes = 3,
    EtwQueryProcessHandleInfoMax = 4,
}

struct ETW_TRACE_PARTITION_INFORMATION
{
    Guid PartitionId;
    Guid ParentId;
    long QpcOffsetFromRoot;
    uint PartitionType;
}

struct ETW_TRACE_PARTITION_INFORMATION_V2
{
    long QpcOffsetFromRoot;
    uint PartitionType;
    const(wchar)* PartitionId;
    const(wchar)* ParentId;
}

struct EVENT_DATA_DESCRIPTOR
{
    ulong Ptr;
    uint Size;
    _Anonymous_e__Union Anonymous;
}

struct EVENT_DESCRIPTOR
{
    ushort Id;
    ubyte Version;
    ubyte Channel;
    ubyte Level;
    ubyte Opcode;
    ushort Task;
    ulong Keyword;
}

struct EVENT_FILTER_DESCRIPTOR
{
    ulong Ptr;
    uint Size;
    uint Type;
}

struct EVENT_FILTER_HEADER
{
    ushort Id;
    ubyte Version;
    ubyte Reserved;
    ulong InstanceId;
    uint Size;
    uint NextOffset;
}

struct EVENT_FILTER_EVENT_ID
{
    ubyte FilterIn;
    ubyte Reserved;
    ushort Count;
    ushort Events;
}

struct EVENT_FILTER_EVENT_NAME
{
    ulong MatchAnyKeyword;
    ulong MatchAllKeyword;
    ubyte Level;
    ubyte FilterIn;
    ushort NameCount;
    ubyte Names;
}

struct EVENT_FILTER_LEVEL_KW
{
    ulong MatchAnyKeyword;
    ulong MatchAllKeyword;
    ubyte Level;
    ubyte FilterIn;
}

enum EVENT_INFO_CLASS
{
    EventProviderBinaryTrackInfo = 0,
    EventProviderSetReserved1 = 1,
    EventProviderSetTraits = 2,
    EventProviderUseDescriptorType = 3,
    MaxEventInfo = 4,
}

alias PENABLECALLBACK = extern(Windows) void function(Guid* SourceId, uint IsEnabled, ubyte Level, ulong MatchAnyKeyword, ulong MatchAllKeyword, EVENT_FILTER_DESCRIPTOR* FilterData, void* CallbackContext);
struct EVENT_HEADER_EXTENDED_DATA_ITEM
{
    ushort Reserved1;
    ushort ExtType;
    _Anonymous_e__Struct Anonymous;
    ushort DataSize;
    ulong DataPtr;
}

struct EVENT_EXTENDED_ITEM_INSTANCE
{
    uint InstanceId;
    uint ParentInstanceId;
    Guid ParentGuid;
}

struct EVENT_EXTENDED_ITEM_RELATED_ACTIVITYID
{
    Guid RelatedActivityId;
}

struct EVENT_EXTENDED_ITEM_TS_ID
{
    uint SessionId;
}

struct EVENT_EXTENDED_ITEM_STACK_TRACE32
{
    ulong MatchId;
    uint Address;
}

struct EVENT_EXTENDED_ITEM_STACK_TRACE64
{
    ulong MatchId;
    ulong Address;
}

struct EVENT_EXTENDED_ITEM_PEBS_INDEX
{
    ulong PebsIndex;
}

struct EVENT_EXTENDED_ITEM_PMC_COUNTERS
{
    ulong Counter;
}

struct EVENT_EXTENDED_ITEM_PROCESS_START_KEY
{
    ulong ProcessStartKey;
}

struct EVENT_EXTENDED_ITEM_EVENT_KEY
{
    ulong Key;
}

struct EVENT_HEADER
{
    ushort Size;
    ushort HeaderType;
    ushort Flags;
    ushort EventProperty;
    uint ThreadId;
    uint ProcessId;
    LARGE_INTEGER TimeStamp;
    Guid ProviderId;
    EVENT_DESCRIPTOR EventDescriptor;
    _Anonymous_e__Union Anonymous;
    Guid ActivityId;
}

struct EVENT_RECORD
{
    EVENT_HEADER EventHeader;
    ETW_BUFFER_CONTEXT BufferContext;
    ushort ExtendedDataCount;
    ushort UserDataLength;
    EVENT_HEADER_EXTENDED_DATA_ITEM* ExtendedData;
    void* UserData;
    void* UserContext;
}

enum ETW_PROVIDER_TRAIT_TYPE
{
    EtwProviderTraitTypeGroup = 1,
    EtwProviderTraitDecodeGuid = 2,
    EtwProviderTraitTypeMax = 3,
}

enum EVENTSECURITYOPERATION
{
    EventSecuritySetDACL = 0,
    EventSecuritySetSACL = 1,
    EventSecurityAddDACL = 2,
    EventSecurityAddSACL = 3,
    EventSecurityMax = 4,
}

struct EVENT_MAP_ENTRY
{
    uint OutputOffset;
    _Anonymous_e__Union Anonymous;
}

enum MAP_FLAGS
{
    EVENTMAP_INFO_FLAG_MANIFEST_VALUEMAP = 1,
    EVENTMAP_INFO_FLAG_MANIFEST_BITMAP = 2,
    EVENTMAP_INFO_FLAG_MANIFEST_PATTERNMAP = 4,
    EVENTMAP_INFO_FLAG_WBEM_VALUEMAP = 8,
    EVENTMAP_INFO_FLAG_WBEM_BITMAP = 16,
    EVENTMAP_INFO_FLAG_WBEM_FLAG = 32,
    EVENTMAP_INFO_FLAG_WBEM_NO_MAP = 64,
}

enum MAP_VALUETYPE
{
    EVENTMAP_ENTRY_VALUETYPE_ULONG = 0,
    EVENTMAP_ENTRY_VALUETYPE_STRING = 1,
}

struct EVENT_MAP_INFO
{
    uint NameOffset;
    MAP_FLAGS Flag;
    uint EntryCount;
    _Anonymous_e__Union Anonymous;
    EVENT_MAP_ENTRY MapEntryArray;
}

enum _TDH_IN_TYPE
{
    TDH_INTYPE_NULL = 0,
    TDH_INTYPE_UNICODESTRING = 1,
    TDH_INTYPE_ANSISTRING = 2,
    TDH_INTYPE_INT8 = 3,
    TDH_INTYPE_UINT8 = 4,
    TDH_INTYPE_INT16 = 5,
    TDH_INTYPE_UINT16 = 6,
    TDH_INTYPE_INT32 = 7,
    TDH_INTYPE_UINT32 = 8,
    TDH_INTYPE_INT64 = 9,
    TDH_INTYPE_UINT64 = 10,
    TDH_INTYPE_FLOAT = 11,
    TDH_INTYPE_DOUBLE = 12,
    TDH_INTYPE_BOOLEAN = 13,
    TDH_INTYPE_BINARY = 14,
    TDH_INTYPE_GUID = 15,
    TDH_INTYPE_POINTER = 16,
    TDH_INTYPE_FILETIME = 17,
    TDH_INTYPE_SYSTEMTIME = 18,
    TDH_INTYPE_SID = 19,
    TDH_INTYPE_HEXINT32 = 20,
    TDH_INTYPE_HEXINT64 = 21,
    TDH_INTYPE_MANIFEST_COUNTEDSTRING = 22,
    TDH_INTYPE_MANIFEST_COUNTEDANSISTRING = 23,
    TDH_INTYPE_RESERVED24 = 24,
    TDH_INTYPE_MANIFEST_COUNTEDBINARY = 25,
    TDH_INTYPE_COUNTEDSTRING = 300,
    TDH_INTYPE_COUNTEDANSISTRING = 301,
    TDH_INTYPE_REVERSEDCOUNTEDSTRING = 302,
    TDH_INTYPE_REVERSEDCOUNTEDANSISTRING = 303,
    TDH_INTYPE_NONNULLTERMINATEDSTRING = 304,
    TDH_INTYPE_NONNULLTERMINATEDANSISTRING = 305,
    TDH_INTYPE_UNICODECHAR = 306,
    TDH_INTYPE_ANSICHAR = 307,
    TDH_INTYPE_SIZET = 308,
    TDH_INTYPE_HEXDUMP = 309,
    TDH_INTYPE_WBEMSID = 310,
}

enum _TDH_OUT_TYPE
{
    TDH_OUTTYPE_NULL = 0,
    TDH_OUTTYPE_STRING = 1,
    TDH_OUTTYPE_DATETIME = 2,
    TDH_OUTTYPE_BYTE = 3,
    TDH_OUTTYPE_UNSIGNEDBYTE = 4,
    TDH_OUTTYPE_SHORT = 5,
    TDH_OUTTYPE_UNSIGNEDSHORT = 6,
    TDH_OUTTYPE_INT = 7,
    TDH_OUTTYPE_UNSIGNEDINT = 8,
    TDH_OUTTYPE_LONG = 9,
    TDH_OUTTYPE_UNSIGNEDLONG = 10,
    TDH_OUTTYPE_FLOAT = 11,
    TDH_OUTTYPE_DOUBLE = 12,
    TDH_OUTTYPE_BOOLEAN = 13,
    TDH_OUTTYPE_GUID = 14,
    TDH_OUTTYPE_HEXBINARY = 15,
    TDH_OUTTYPE_HEXINT8 = 16,
    TDH_OUTTYPE_HEXINT16 = 17,
    TDH_OUTTYPE_HEXINT32 = 18,
    TDH_OUTTYPE_HEXINT64 = 19,
    TDH_OUTTYPE_PID = 20,
    TDH_OUTTYPE_TID = 21,
    TDH_OUTTYPE_PORT = 22,
    TDH_OUTTYPE_IPV4 = 23,
    TDH_OUTTYPE_IPV6 = 24,
    TDH_OUTTYPE_SOCKETADDRESS = 25,
    TDH_OUTTYPE_CIMDATETIME = 26,
    TDH_OUTTYPE_ETWTIME = 27,
    TDH_OUTTYPE_XML = 28,
    TDH_OUTTYPE_ERRORCODE = 29,
    TDH_OUTTYPE_WIN32ERROR = 30,
    TDH_OUTTYPE_NTSTATUS = 31,
    TDH_OUTTYPE_HRESULT = 32,
    TDH_OUTTYPE_CULTURE_INSENSITIVE_DATETIME = 33,
    TDH_OUTTYPE_JSON = 34,
    TDH_OUTTYPE_UTF8 = 35,
    TDH_OUTTYPE_PKCS7_WITH_TYPE_INFO = 36,
    TDH_OUTTYPE_CODE_POINTER = 37,
    TDH_OUTTYPE_DATETIME_UTC = 38,
    TDH_OUTTYPE_REDUCEDSTRING = 300,
    TDH_OUTTYPE_NOPRINT = 301,
}

enum PROPERTY_FLAGS
{
    PropertyStruct = 1,
    PropertyParamLength = 2,
    PropertyParamCount = 4,
    PropertyWBEMXmlFragment = 8,
    PropertyParamFixedLength = 16,
    PropertyParamFixedCount = 32,
    PropertyHasTags = 64,
    PropertyHasCustomSchema = 128,
}

struct EVENT_PROPERTY_INFO
{
    PROPERTY_FLAGS Flags;
    uint NameOffset;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    _Anonymous4_e__Union Anonymous4;
}

enum DECODING_SOURCE
{
    DecodingSourceXMLFile = 0,
    DecodingSourceWbem = 1,
    DecodingSourceWPP = 2,
    DecodingSourceTlg = 3,
    DecodingSourceMax = 4,
}

enum TEMPLATE_FLAGS
{
    TEMPLATE_EVENT_DATA = 1,
    TEMPLATE_USER_DATA = 2,
    TEMPLATE_CONTROL_GUID = 4,
}

struct TRACE_EVENT_INFO
{
    Guid ProviderGuid;
    Guid EventGuid;
    EVENT_DESCRIPTOR EventDescriptor;
    DECODING_SOURCE DecodingSource;
    uint ProviderNameOffset;
    uint LevelNameOffset;
    uint ChannelNameOffset;
    uint KeywordsNameOffset;
    uint TaskNameOffset;
    uint OpcodeNameOffset;
    uint EventMessageOffset;
    uint ProviderMessageOffset;
    uint BinaryXMLOffset;
    uint BinaryXMLSize;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    uint PropertyCount;
    uint TopLevelPropertyCount;
    _Anonymous3_e__Union Anonymous3;
    EVENT_PROPERTY_INFO EventPropertyInfoArray;
}

struct PROPERTY_DATA_DESCRIPTOR
{
    ulong PropertyName;
    uint ArrayIndex;
    uint Reserved;
}

enum PAYLOAD_OPERATOR
{
    PAYLOADFIELD_EQ = 0,
    PAYLOADFIELD_NE = 1,
    PAYLOADFIELD_LE = 2,
    PAYLOADFIELD_GT = 3,
    PAYLOADFIELD_LT = 4,
    PAYLOADFIELD_GE = 5,
    PAYLOADFIELD_BETWEEN = 6,
    PAYLOADFIELD_NOTBETWEEN = 7,
    PAYLOADFIELD_MODULO = 8,
    PAYLOADFIELD_CONTAINS = 20,
    PAYLOADFIELD_DOESNTCONTAIN = 21,
    PAYLOADFIELD_IS = 30,
    PAYLOADFIELD_ISNOT = 31,
    PAYLOADFIELD_INVALID = 32,
}

struct PAYLOAD_FILTER_PREDICATE
{
    const(wchar)* FieldName;
    ushort CompareOp;
    const(wchar)* Value;
}

struct PROVIDER_FILTER_INFO
{
    ubyte Id;
    ubyte Version;
    uint MessageOffset;
    uint Reserved;
    uint PropertyCount;
    EVENT_PROPERTY_INFO EventPropertyInfoArray;
}

enum EVENT_FIELD_TYPE
{
    EventKeywordInformation = 0,
    EventLevelInformation = 1,
    EventChannelInformation = 2,
    EventTaskInformation = 3,
    EventOpcodeInformation = 4,
    EventInformationMax = 5,
}

struct PROVIDER_FIELD_INFO
{
    uint NameOffset;
    uint DescriptionOffset;
    ulong Value;
}

struct PROVIDER_FIELD_INFOARRAY
{
    uint NumberOfElements;
    EVENT_FIELD_TYPE FieldType;
    PROVIDER_FIELD_INFO FieldInfoArray;
}

struct TRACE_PROVIDER_INFO
{
    Guid ProviderGuid;
    uint SchemaSource;
    uint ProviderNameOffset;
}

struct PROVIDER_ENUMERATION_INFO
{
    uint NumberOfProviders;
    uint Reserved;
    TRACE_PROVIDER_INFO TraceProviderInfoArray;
}

struct PROVIDER_EVENT_INFO
{
    uint NumberOfEvents;
    uint Reserved;
    EVENT_DESCRIPTOR EventDescriptorsArray;
}

enum TDH_CONTEXT_TYPE
{
    TDH_CONTEXT_WPP_TMFFILE = 0,
    TDH_CONTEXT_WPP_TMFSEARCHPATH = 1,
    TDH_CONTEXT_WPP_GMT = 2,
    TDH_CONTEXT_POINTERSIZE = 3,
    TDH_CONTEXT_PDB_PATH = 4,
    TDH_CONTEXT_MAXIMUM = 5,
}

struct TDH_CONTEXT
{
    ulong ParameterValue;
    TDH_CONTEXT_TYPE ParameterType;
    uint ParameterSize;
}

const GUID CLSID_CTraceRelogger = {0x7B40792D, 0x05FF, 0x44C4, [0x90, 0x58, 0xF4, 0x40, 0xC7, 0x1F, 0x17, 0xD4]};
@GUID(0x7B40792D, 0x05FF, 0x44C4, [0x90, 0x58, 0xF4, 0x40, 0xC7, 0x1F, 0x17, 0xD4]);
struct CTraceRelogger;

const GUID IID_ITraceEvent = {0x8CC97F40, 0x9028, 0x4FF3, [0x9B, 0x62, 0x7D, 0x1F, 0x79, 0xCA, 0x7B, 0xCB]};
@GUID(0x8CC97F40, 0x9028, 0x4FF3, [0x9B, 0x62, 0x7D, 0x1F, 0x79, 0xCA, 0x7B, 0xCB]);
interface ITraceEvent : IUnknown
{
    HRESULT Clone(ITraceEvent* NewEvent);
    HRESULT GetUserContext(void** UserContext);
    HRESULT GetEventRecord(EVENT_RECORD** EventRecord);
    HRESULT SetPayload(ubyte* Payload, uint PayloadSize);
    HRESULT SetEventDescriptor(EVENT_DESCRIPTOR* EventDescriptor);
    HRESULT SetProcessId(uint ProcessId);
    HRESULT SetProcessorIndex(uint ProcessorIndex);
    HRESULT SetThreadId(uint ThreadId);
    HRESULT SetThreadTimes(uint KernelTime, uint UserTime);
    HRESULT SetActivityId(Guid* ActivityId);
    HRESULT SetTimeStamp(LARGE_INTEGER* TimeStamp);
    HRESULT SetProviderId(Guid* ProviderId);
}

const GUID IID_ITraceEventCallback = {0x3ED25501, 0x593F, 0x43E9, [0x8F, 0x38, 0x3A, 0xB4, 0x6F, 0x5A, 0x4A, 0x52]};
@GUID(0x3ED25501, 0x593F, 0x43E9, [0x8F, 0x38, 0x3A, 0xB4, 0x6F, 0x5A, 0x4A, 0x52]);
interface ITraceEventCallback : IUnknown
{
    HRESULT OnBeginProcessTrace(ITraceEvent HeaderEvent, ITraceRelogger Relogger);
    HRESULT OnFinalizeProcessTrace(ITraceRelogger Relogger);
    HRESULT OnEvent(ITraceEvent Event, ITraceRelogger Relogger);
}

const GUID IID_ITraceRelogger = {0xF754AD43, 0x3BCC, 0x4286, [0x80, 0x09, 0x9C, 0x5D, 0xA2, 0x14, 0xE8, 0x4E]};
@GUID(0xF754AD43, 0x3BCC, 0x4286, [0x80, 0x09, 0x9C, 0x5D, 0xA2, 0x14, 0xE8, 0x4E]);
interface ITraceRelogger : IUnknown
{
    HRESULT AddLogfileTraceStream(BSTR LogfileName, void* UserContext, ulong* TraceHandle);
    HRESULT AddRealtimeTraceStream(BSTR LoggerName, void* UserContext, ulong* TraceHandle);
    HRESULT RegisterCallback(ITraceEventCallback Callback);
    HRESULT Inject(ITraceEvent Event);
    HRESULT CreateEventInstance(ulong TraceHandle, uint Flags, ITraceEvent* Event);
    HRESULT ProcessTrace();
    HRESULT SetOutputFilename(BSTR LogfileName);
    HRESULT SetCompressionMode(ubyte CompressionMode);
    HRESULT Cancel();
}

@DllImport("ADVAPI32.dll")
uint StartTraceW(ulong* TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint StartTraceA(ulong* TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint StopTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint StopTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint QueryTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint QueryTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint UpdateTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint UpdateTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint FlushTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint FlushTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32.dll")
uint ControlTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties, uint ControlCode);

@DllImport("ADVAPI32.dll")
uint ControlTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties, uint ControlCode);

@DllImport("ADVAPI32.dll")
uint QueryAllTracesW(char* PropertyArray, uint PropertyArrayCount, uint* LoggerCount);

@DllImport("ADVAPI32.dll")
uint QueryAllTracesA(char* PropertyArray, uint PropertyArrayCount, uint* LoggerCount);

@DllImport("ADVAPI32.dll")
uint EnableTrace(uint Enable, uint EnableFlag, uint EnableLevel, Guid* ControlGuid, ulong TraceHandle);

@DllImport("ADVAPI32.dll")
uint EnableTraceEx(Guid* ProviderId, Guid* SourceId, ulong TraceHandle, uint IsEnabled, ubyte Level, ulong MatchAnyKeyword, ulong MatchAllKeyword, uint EnableProperty, EVENT_FILTER_DESCRIPTOR* EnableFilterDesc);

@DllImport("ADVAPI32.dll")
uint EnableTraceEx2(ulong TraceHandle, Guid* ProviderId, uint ControlCode, ubyte Level, ulong MatchAnyKeyword, ulong MatchAllKeyword, uint Timeout, ENABLE_TRACE_PARAMETERS* EnableParameters);

@DllImport("ADVAPI32.dll")
uint EnumerateTraceGuidsEx(TRACE_QUERY_INFO_CLASS TraceQueryInfoClass, char* InBuffer, uint InBufferSize, char* OutBuffer, uint OutBufferSize, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
uint TraceSetInformation(ulong SessionHandle, TRACE_QUERY_INFO_CLASS InformationClass, char* TraceInformation, uint InformationLength);

@DllImport("ADVAPI32.dll")
uint TraceQueryInformation(ulong SessionHandle, TRACE_QUERY_INFO_CLASS InformationClass, char* TraceInformation, uint InformationLength, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
uint CreateTraceInstanceId(HANDLE RegHandle, EVENT_INSTANCE_INFO* InstInfo);

@DllImport("ADVAPI32.dll")
uint TraceEvent(ulong TraceHandle, EVENT_TRACE_HEADER* EventTrace);

@DllImport("ADVAPI32.dll")
uint TraceEventInstance(ulong TraceHandle, EVENT_INSTANCE_HEADER* EventTrace, EVENT_INSTANCE_INFO* InstInfo, EVENT_INSTANCE_INFO* ParentInstInfo);

@DllImport("ADVAPI32.dll")
uint RegisterTraceGuidsW(WMIDPREQUEST RequestAddress, void* RequestContext, Guid* ControlGuid, uint GuidCount, char* TraceGuidReg, const(wchar)* MofImagePath, const(wchar)* MofResourceName, ulong* RegistrationHandle);

@DllImport("ADVAPI32.dll")
uint RegisterTraceGuidsA(WMIDPREQUEST RequestAddress, void* RequestContext, Guid* ControlGuid, uint GuidCount, char* TraceGuidReg, const(char)* MofImagePath, const(char)* MofResourceName, ulong* RegistrationHandle);

@DllImport("ADVAPI32.dll")
uint EnumerateTraceGuids(char* GuidPropertiesArray, uint PropertyArrayCount, uint* GuidCount);

@DllImport("ADVAPI32.dll")
uint UnregisterTraceGuids(ulong RegistrationHandle);

@DllImport("ADVAPI32.dll")
ulong GetTraceLoggerHandle(void* Buffer);

@DllImport("ADVAPI32.dll")
ubyte GetTraceEnableLevel(ulong TraceHandle);

@DllImport("ADVAPI32.dll")
uint GetTraceEnableFlags(ulong TraceHandle);

@DllImport("ADVAPI32.dll")
ulong OpenTraceW(EVENT_TRACE_LOGFILEW* Logfile);

@DllImport("ADVAPI32.dll")
uint ProcessTrace(char* HandleArray, uint HandleCount, FILETIME* StartTime, FILETIME* EndTime);

@DllImport("ADVAPI32.dll")
uint CloseTrace(ulong TraceHandle);

@DllImport("ADVAPI32.dll")
uint QueryTraceProcessingHandle(ulong ProcessingHandle, ETW_PROCESS_HANDLE_INFO_TYPE InformationClass, void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
ulong OpenTraceA(EVENT_TRACE_LOGFILEA* Logfile);

@DllImport("ADVAPI32.dll")
uint SetTraceCallback(Guid* pGuid, PEVENT_CALLBACK EventCallback);

@DllImport("ADVAPI32.dll")
uint RemoveTraceCallback(Guid* pGuid);

@DllImport("ADVAPI32.dll")
uint TraceMessage(ulong LoggerHandle, uint MessageFlags, Guid* MessageGuid, ushort MessageNumber);

@DllImport("ADVAPI32.dll")
uint TraceMessageVa(ulong LoggerHandle, uint MessageFlags, Guid* MessageGuid, ushort MessageNumber, byte* MessageArgList);

@DllImport("ADVAPI32.dll")
uint EventRegister(Guid* ProviderId, PENABLECALLBACK EnableCallback, void* CallbackContext, ulong* RegHandle);

@DllImport("ADVAPI32.dll")
uint EventUnregister(ulong RegHandle);

@DllImport("ADVAPI32.dll")
uint EventSetInformation(ulong RegHandle, EVENT_INFO_CLASS InformationClass, char* EventInformation, uint InformationLength);

@DllImport("ADVAPI32.dll")
ubyte EventEnabled(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor);

@DllImport("ADVAPI32.dll")
ubyte EventProviderEnabled(ulong RegHandle, ubyte Level, ulong Keyword);

@DllImport("ADVAPI32.dll")
uint EventWrite(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, uint UserDataCount, char* UserData);

@DllImport("ADVAPI32.dll")
uint EventWriteTransfer(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, Guid* ActivityId, Guid* RelatedActivityId, uint UserDataCount, char* UserData);

@DllImport("ADVAPI32.dll")
uint EventWriteEx(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, ulong Filter, uint Flags, Guid* ActivityId, Guid* RelatedActivityId, uint UserDataCount, char* UserData);

@DllImport("ADVAPI32.dll")
uint EventWriteString(ulong RegHandle, ubyte Level, ulong Keyword, const(wchar)* String);

@DllImport("ADVAPI32.dll")
uint EventActivityIdControl(uint ControlCode, Guid* ActivityId);

@DllImport("ADVAPI32.dll")
uint EventAccessControl(Guid* Guid, uint Operation, void* Sid, uint Rights, ubyte AllowOrDeny);

@DllImport("ADVAPI32.dll")
uint EventAccessQuery(Guid* Guid, char* Buffer, uint* BufferSize);

@DllImport("ADVAPI32.dll")
uint EventAccessRemove(Guid* Guid);

@DllImport("tdh.dll")
uint TdhCreatePayloadFilter(Guid* ProviderGuid, EVENT_DESCRIPTOR* EventDescriptor, ubyte EventMatchANY, uint PayloadPredicateCount, char* PayloadPredicates, void** PayloadFilter);

@DllImport("tdh.dll")
uint TdhDeletePayloadFilter(void** PayloadFilter);

@DllImport("tdh.dll")
uint TdhAggregatePayloadFilters(uint PayloadFilterCount, char* PayloadFilterPtrs, char* EventMatchALLFlags, EVENT_FILTER_DESCRIPTOR* EventFilterDescriptor);

@DllImport("tdh.dll")
uint TdhCleanupPayloadEventFilterDescriptor(EVENT_FILTER_DESCRIPTOR* EventFilterDescriptor);

@DllImport("TDH.dll")
uint TdhGetEventInformation(EVENT_RECORD* Event, uint TdhContextCount, char* TdhContext, char* Buffer, uint* BufferSize);

@DllImport("TDH.dll")
uint TdhGetEventMapInformation(EVENT_RECORD* pEvent, const(wchar)* pMapName, char* pBuffer, uint* pBufferSize);

@DllImport("TDH.dll")
uint TdhGetPropertySize(EVENT_RECORD* pEvent, uint TdhContextCount, char* pTdhContext, uint PropertyDataCount, char* pPropertyData, uint* pPropertySize);

@DllImport("TDH.dll")
uint TdhGetProperty(EVENT_RECORD* pEvent, uint TdhContextCount, char* pTdhContext, uint PropertyDataCount, char* pPropertyData, uint BufferSize, char* pBuffer);

@DllImport("TDH.dll")
uint TdhEnumerateProviders(char* pBuffer, uint* pBufferSize);

@DllImport("TDH.dll")
uint TdhQueryProviderFieldInformation(Guid* pGuid, ulong EventFieldValue, EVENT_FIELD_TYPE EventFieldType, char* pBuffer, uint* pBufferSize);

@DllImport("TDH.dll")
uint TdhEnumerateProviderFieldInformation(Guid* pGuid, EVENT_FIELD_TYPE EventFieldType, char* pBuffer, uint* pBufferSize);

@DllImport("tdh.dll")
uint TdhEnumerateProviderFilters(Guid* Guid, uint TdhContextCount, char* TdhContext, uint* FilterCount, char* Buffer, uint* BufferSize);

@DllImport("TDH.dll")
uint TdhLoadManifest(const(wchar)* Manifest);

@DllImport("TDH.dll")
uint TdhLoadManifestFromMemory(char* pData, uint cbData);

@DllImport("TDH.dll")
uint TdhUnloadManifest(const(wchar)* Manifest);

@DllImport("TDH.dll")
uint TdhUnloadManifestFromMemory(char* pData, uint cbData);

@DllImport("TDH.dll")
uint TdhFormatProperty(TRACE_EVENT_INFO* EventInfo, EVENT_MAP_INFO* MapInfo, uint PointerSize, ushort PropertyInType, ushort PropertyOutType, ushort PropertyLength, ushort UserDataLength, char* UserData, uint* BufferSize, const(wchar)* Buffer, ushort* UserDataConsumed);

@DllImport("tdh.dll")
uint TdhOpenDecodingHandle(TDH_HANDLE* Handle);

@DllImport("tdh.dll")
uint TdhSetDecodingParameter(TDH_HANDLE Handle, TDH_CONTEXT* TdhContext);

@DllImport("tdh.dll")
uint TdhGetDecodingParameter(TDH_HANDLE Handle, TDH_CONTEXT* TdhContext);

@DllImport("tdh.dll")
uint TdhGetWppProperty(TDH_HANDLE Handle, EVENT_RECORD* EventRecord, const(wchar)* PropertyName, uint* BufferSize, char* Buffer);

@DllImport("tdh.dll")
uint TdhGetWppMessage(TDH_HANDLE Handle, EVENT_RECORD* EventRecord, uint* BufferSize, char* Buffer);

@DllImport("tdh.dll")
uint TdhCloseDecodingHandle(TDH_HANDLE Handle);

@DllImport("tdh.dll")
uint TdhLoadManifestFromBinary(const(wchar)* BinaryPath);

@DllImport("TDH.dll")
uint TdhEnumerateManifestProviderEvents(Guid* ProviderGuid, char* Buffer, uint* BufferSize);

@DllImport("TDH.dll")
uint TdhGetManifestEventInformation(Guid* ProviderGuid, EVENT_DESCRIPTOR* EventDescriptor, char* Buffer, uint* BufferSize);

@DllImport("ADVAPI32.dll")
int CveEventWrite(const(wchar)* CveId, const(wchar)* AdditionalDetails);

