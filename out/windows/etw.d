module windows.etw;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : HANDLE, LARGE_INTEGER;
public import windows.windowsprogramming : FILETIME, TIME_ZONE_INFORMATION;

extern(Windows):


// Enums


enum : int
{
    WMI_GET_ALL_DATA        = 0x00000000,
    WMI_GET_SINGLE_INSTANCE = 0x00000001,
    WMI_SET_SINGLE_INSTANCE = 0x00000002,
    WMI_SET_SINGLE_ITEM     = 0x00000003,
    WMI_ENABLE_EVENTS       = 0x00000004,
    WMI_DISABLE_EVENTS      = 0x00000005,
    WMI_ENABLE_COLLECTION   = 0x00000006,
    WMI_DISABLE_COLLECTION  = 0x00000007,
    WMI_REGINFO             = 0x00000008,
    WMI_EXECUTE_METHOD      = 0x00000009,
    WMI_CAPTURE_STATE       = 0x0000000a,
}
alias WMIDPREQUESTCODE = int;

enum : int
{
    EtwCompressionModeRestart   = 0x00000000,
    EtwCompressionModeNoDisable = 0x00000001,
    EtwCompressionModeNoRestart = 0x00000002,
}
alias ETW_COMPRESSION_RESUMPTION_MODE = int;

enum : int
{
    TraceGuidQueryList                = 0x00000000,
    TraceGuidQueryInfo                = 0x00000001,
    TraceGuidQueryProcess             = 0x00000002,
    TraceStackTracingInfo             = 0x00000003,
    TraceSystemTraceEnableFlagsInfo   = 0x00000004,
    TraceSampledProfileIntervalInfo   = 0x00000005,
    TraceProfileSourceConfigInfo      = 0x00000006,
    TraceProfileSourceListInfo        = 0x00000007,
    TracePmcEventListInfo             = 0x00000008,
    TracePmcCounterListInfo           = 0x00000009,
    TraceSetDisallowList              = 0x0000000a,
    TraceVersionInfo                  = 0x0000000b,
    TraceGroupQueryList               = 0x0000000c,
    TraceGroupQueryInfo               = 0x0000000d,
    TraceDisallowListQuery            = 0x0000000e,
    TraceInfoReserved15               = 0x0000000f,
    TracePeriodicCaptureStateListInfo = 0x00000010,
    TracePeriodicCaptureStateInfo     = 0x00000011,
    TraceProviderBinaryTracking       = 0x00000012,
    TraceMaxLoggersQuery              = 0x00000013,
    TraceLbrConfigurationInfo         = 0x00000014,
    TraceLbrEventListInfo             = 0x00000015,
    TraceMaxPmcCounterQuery           = 0x00000016,
    MaxTraceSetInfoClass              = 0x00000017,
}
alias TRACE_QUERY_INFO_CLASS = int;

enum : int
{
    EtwQueryPartitionInformation   = 0x00000001,
    EtwQueryPartitionInformationV2 = 0x00000002,
    EtwQueryLastDroppedTimes       = 0x00000003,
    EtwQueryProcessHandleInfoMax   = 0x00000004,
}
alias ETW_PROCESS_HANDLE_INFO_TYPE = int;

enum : int
{
    EventProviderBinaryTrackInfo   = 0x00000000,
    EventProviderSetReserved1      = 0x00000001,
    EventProviderSetTraits         = 0x00000002,
    EventProviderUseDescriptorType = 0x00000003,
    MaxEventInfo                   = 0x00000004,
}
alias EVENT_INFO_CLASS = int;

enum : int
{
    EtwProviderTraitTypeGroup  = 0x00000001,
    EtwProviderTraitDecodeGuid = 0x00000002,
    EtwProviderTraitTypeMax    = 0x00000003,
}
alias ETW_PROVIDER_TRAIT_TYPE = int;

enum : int
{
    EventSecuritySetDACL = 0x00000000,
    EventSecuritySetSACL = 0x00000001,
    EventSecurityAddDACL = 0x00000002,
    EventSecurityAddSACL = 0x00000003,
    EventSecurityMax     = 0x00000004,
}
alias EVENTSECURITYOPERATION = int;

enum : int
{
    EVENTMAP_INFO_FLAG_MANIFEST_VALUEMAP   = 0x00000001,
    EVENTMAP_INFO_FLAG_MANIFEST_BITMAP     = 0x00000002,
    EVENTMAP_INFO_FLAG_MANIFEST_PATTERNMAP = 0x00000004,
    EVENTMAP_INFO_FLAG_WBEM_VALUEMAP       = 0x00000008,
    EVENTMAP_INFO_FLAG_WBEM_BITMAP         = 0x00000010,
    EVENTMAP_INFO_FLAG_WBEM_FLAG           = 0x00000020,
    EVENTMAP_INFO_FLAG_WBEM_NO_MAP         = 0x00000040,
}
alias MAP_FLAGS = int;

enum : int
{
    EVENTMAP_ENTRY_VALUETYPE_ULONG  = 0x00000000,
    EVENTMAP_ENTRY_VALUETYPE_STRING = 0x00000001,
}
alias MAP_VALUETYPE = int;

enum : int
{
    TDH_INTYPE_NULL                        = 0x00000000,
    TDH_INTYPE_UNICODESTRING               = 0x00000001,
    TDH_INTYPE_ANSISTRING                  = 0x00000002,
    TDH_INTYPE_INT8                        = 0x00000003,
    TDH_INTYPE_UINT8                       = 0x00000004,
    TDH_INTYPE_INT16                       = 0x00000005,
    TDH_INTYPE_UINT16                      = 0x00000006,
    TDH_INTYPE_INT32                       = 0x00000007,
    TDH_INTYPE_UINT32                      = 0x00000008,
    TDH_INTYPE_INT64                       = 0x00000009,
    TDH_INTYPE_UINT64                      = 0x0000000a,
    TDH_INTYPE_FLOAT                       = 0x0000000b,
    TDH_INTYPE_DOUBLE                      = 0x0000000c,
    TDH_INTYPE_BOOLEAN                     = 0x0000000d,
    TDH_INTYPE_BINARY                      = 0x0000000e,
    TDH_INTYPE_GUID                        = 0x0000000f,
    TDH_INTYPE_POINTER                     = 0x00000010,
    TDH_INTYPE_FILETIME                    = 0x00000011,
    TDH_INTYPE_SYSTEMTIME                  = 0x00000012,
    TDH_INTYPE_SID                         = 0x00000013,
    TDH_INTYPE_HEXINT32                    = 0x00000014,
    TDH_INTYPE_HEXINT64                    = 0x00000015,
    TDH_INTYPE_MANIFEST_COUNTEDSTRING      = 0x00000016,
    TDH_INTYPE_MANIFEST_COUNTEDANSISTRING  = 0x00000017,
    TDH_INTYPE_RESERVED24                  = 0x00000018,
    TDH_INTYPE_MANIFEST_COUNTEDBINARY      = 0x00000019,
    TDH_INTYPE_COUNTEDSTRING               = 0x0000012c,
    TDH_INTYPE_COUNTEDANSISTRING           = 0x0000012d,
    TDH_INTYPE_REVERSEDCOUNTEDSTRING       = 0x0000012e,
    TDH_INTYPE_REVERSEDCOUNTEDANSISTRING   = 0x0000012f,
    TDH_INTYPE_NONNULLTERMINATEDSTRING     = 0x00000130,
    TDH_INTYPE_NONNULLTERMINATEDANSISTRING = 0x00000131,
    TDH_INTYPE_UNICODECHAR                 = 0x00000132,
    TDH_INTYPE_ANSICHAR                    = 0x00000133,
    TDH_INTYPE_SIZET                       = 0x00000134,
    TDH_INTYPE_HEXDUMP                     = 0x00000135,
    TDH_INTYPE_WBEMSID                     = 0x00000136,
}
alias _TDH_IN_TYPE = int;

enum : int
{
    TDH_OUTTYPE_NULL                         = 0x00000000,
    TDH_OUTTYPE_STRING                       = 0x00000001,
    TDH_OUTTYPE_DATETIME                     = 0x00000002,
    TDH_OUTTYPE_BYTE                         = 0x00000003,
    TDH_OUTTYPE_UNSIGNEDBYTE                 = 0x00000004,
    TDH_OUTTYPE_SHORT                        = 0x00000005,
    TDH_OUTTYPE_UNSIGNEDSHORT                = 0x00000006,
    TDH_OUTTYPE_INT                          = 0x00000007,
    TDH_OUTTYPE_UNSIGNEDINT                  = 0x00000008,
    TDH_OUTTYPE_LONG                         = 0x00000009,
    TDH_OUTTYPE_UNSIGNEDLONG                 = 0x0000000a,
    TDH_OUTTYPE_FLOAT                        = 0x0000000b,
    TDH_OUTTYPE_DOUBLE                       = 0x0000000c,
    TDH_OUTTYPE_BOOLEAN                      = 0x0000000d,
    TDH_OUTTYPE_GUID                         = 0x0000000e,
    TDH_OUTTYPE_HEXBINARY                    = 0x0000000f,
    TDH_OUTTYPE_HEXINT8                      = 0x00000010,
    TDH_OUTTYPE_HEXINT16                     = 0x00000011,
    TDH_OUTTYPE_HEXINT32                     = 0x00000012,
    TDH_OUTTYPE_HEXINT64                     = 0x00000013,
    TDH_OUTTYPE_PID                          = 0x00000014,
    TDH_OUTTYPE_TID                          = 0x00000015,
    TDH_OUTTYPE_PORT                         = 0x00000016,
    TDH_OUTTYPE_IPV4                         = 0x00000017,
    TDH_OUTTYPE_IPV6                         = 0x00000018,
    TDH_OUTTYPE_SOCKETADDRESS                = 0x00000019,
    TDH_OUTTYPE_CIMDATETIME                  = 0x0000001a,
    TDH_OUTTYPE_ETWTIME                      = 0x0000001b,
    TDH_OUTTYPE_XML                          = 0x0000001c,
    TDH_OUTTYPE_ERRORCODE                    = 0x0000001d,
    TDH_OUTTYPE_WIN32ERROR                   = 0x0000001e,
    TDH_OUTTYPE_NTSTATUS                     = 0x0000001f,
    TDH_OUTTYPE_HRESULT                      = 0x00000020,
    TDH_OUTTYPE_CULTURE_INSENSITIVE_DATETIME = 0x00000021,
    TDH_OUTTYPE_JSON                         = 0x00000022,
    TDH_OUTTYPE_UTF8                         = 0x00000023,
    TDH_OUTTYPE_PKCS7_WITH_TYPE_INFO         = 0x00000024,
    TDH_OUTTYPE_CODE_POINTER                 = 0x00000025,
    TDH_OUTTYPE_DATETIME_UTC                 = 0x00000026,
    TDH_OUTTYPE_REDUCEDSTRING                = 0x0000012c,
    TDH_OUTTYPE_NOPRINT                      = 0x0000012d,
}
alias _TDH_OUT_TYPE = int;

enum : int
{
    PropertyStruct           = 0x00000001,
    PropertyParamLength      = 0x00000002,
    PropertyParamCount       = 0x00000004,
    PropertyWBEMXmlFragment  = 0x00000008,
    PropertyParamFixedLength = 0x00000010,
    PropertyParamFixedCount  = 0x00000020,
    PropertyHasTags          = 0x00000040,
    PropertyHasCustomSchema  = 0x00000080,
}
alias PROPERTY_FLAGS = int;

enum : int
{
    DecodingSourceXMLFile = 0x00000000,
    DecodingSourceWbem    = 0x00000001,
    DecodingSourceWPP     = 0x00000002,
    DecodingSourceTlg     = 0x00000003,
    DecodingSourceMax     = 0x00000004,
}
alias DECODING_SOURCE = int;

enum : int
{
    TEMPLATE_EVENT_DATA   = 0x00000001,
    TEMPLATE_USER_DATA    = 0x00000002,
    TEMPLATE_CONTROL_GUID = 0x00000004,
}
alias TEMPLATE_FLAGS = int;

enum : int
{
    PAYLOADFIELD_EQ            = 0x00000000,
    PAYLOADFIELD_NE            = 0x00000001,
    PAYLOADFIELD_LE            = 0x00000002,
    PAYLOADFIELD_GT            = 0x00000003,
    PAYLOADFIELD_LT            = 0x00000004,
    PAYLOADFIELD_GE            = 0x00000005,
    PAYLOADFIELD_BETWEEN       = 0x00000006,
    PAYLOADFIELD_NOTBETWEEN    = 0x00000007,
    PAYLOADFIELD_MODULO        = 0x00000008,
    PAYLOADFIELD_CONTAINS      = 0x00000014,
    PAYLOADFIELD_DOESNTCONTAIN = 0x00000015,
    PAYLOADFIELD_IS            = 0x0000001e,
    PAYLOADFIELD_ISNOT         = 0x0000001f,
    PAYLOADFIELD_INVALID       = 0x00000020,
}
alias PAYLOAD_OPERATOR = int;

enum : int
{
    EventKeywordInformation = 0x00000000,
    EventLevelInformation   = 0x00000001,
    EventChannelInformation = 0x00000002,
    EventTaskInformation    = 0x00000003,
    EventOpcodeInformation  = 0x00000004,
    EventInformationMax     = 0x00000005,
}
alias EVENT_FIELD_TYPE = int;

enum : int
{
    TDH_CONTEXT_WPP_TMFFILE       = 0x00000000,
    TDH_CONTEXT_WPP_TMFSEARCHPATH = 0x00000001,
    TDH_CONTEXT_WPP_GMT           = 0x00000002,
    TDH_CONTEXT_POINTERSIZE       = 0x00000003,
    TDH_CONTEXT_PDB_PATH          = 0x00000004,
    TDH_CONTEXT_MAXIMUM           = 0x00000005,
}
alias TDH_CONTEXT_TYPE = int;

// Callbacks

alias PEVENT_TRACE_BUFFER_CALLBACKW = uint function(EVENT_TRACE_LOGFILEW* Logfile);
alias PEVENT_TRACE_BUFFER_CALLBACKA = uint function(EVENT_TRACE_LOGFILEA* Logfile);
alias PEVENT_CALLBACK = void function(EVENT_TRACE* pEvent);
alias PEVENT_RECORD_CALLBACK = void function(EVENT_RECORD* EventRecord);
alias WMIDPREQUEST = uint function(WMIDPREQUESTCODE RequestCode, void* RequestContext, uint* BufferSize, 
                                   void* Buffer);
alias PENABLECALLBACK = void function(GUID* SourceId, uint IsEnabled, ubyte Level, ulong MatchAnyKeyword, 
                                      ulong MatchAllKeyword, EVENT_FILTER_DESCRIPTOR* FilterData, 
                                      void* CallbackContext);

// Structs


alias TDH_HANDLE = ptrdiff_t;

struct WNODE_HEADER
{
    uint BufferSize;
    uint ProviderId;
    union
    {
        ulong HistoricalContext;
        struct
        {
            uint Version;
            uint Linkage;
        }
    }
    union
    {
        uint          CountLost;
        HANDLE        KernelHandle;
        LARGE_INTEGER TimeStamp;
    }
    GUID Guid;
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
    uint         DataBlockOffset;
    uint         InstanceCount;
    uint         OffsetInstanceNameOffsets;
    union
    {
        uint FixedInstanceSize;
        OFFSETINSTANCEDATAANDLENGTH OffsetInstanceDataAndLength;
    }
}

struct WNODE_SINGLE_INSTANCE
{
    WNODE_HEADER WnodeHeader;
    uint         OffsetInstanceName;
    uint         InstanceIndex;
    uint         DataBlockOffset;
    uint         SizeDataBlock;
    ubyte        VariableData;
}

struct WNODE_SINGLE_ITEM
{
    WNODE_HEADER WnodeHeader;
    uint         OffsetInstanceName;
    uint         InstanceIndex;
    uint         ItemId;
    uint         DataBlockOffset;
    uint         SizeDataItem;
    ubyte        VariableData;
}

struct WNODE_METHOD_ITEM
{
    WNODE_HEADER WnodeHeader;
    uint         OffsetInstanceName;
    uint         InstanceIndex;
    uint         MethodId;
    uint         DataBlockOffset;
    uint         SizeDataBlock;
    ubyte        VariableData;
}

struct WNODE_EVENT_ITEM
{
    WNODE_HEADER WnodeHeader;
}

struct WNODE_EVENT_REFERENCE
{
    WNODE_HEADER WnodeHeader;
    GUID         TargetGuid;
    uint         TargetDataBlockSize;
    union
    {
        uint   TargetInstanceIndex;
        ushort TargetInstanceName;
    }
}

struct WNODE_TOO_SMALL
{
    WNODE_HEADER WnodeHeader;
    uint         SizeNeeded;
}

struct WMIREGGUIDW
{
    GUID Guid;
    uint Flags;
    uint InstanceCount;
    union
    {
        uint   InstanceNameList;
        uint   BaseNameOffset;
        size_t Pdo;
        size_t InstanceInfo;
    }
}

struct WMIREGINFOW
{
    uint        BufferSize;
    uint        NextWmiRegInfo;
    uint        RegistryPath;
    uint        MofResourceName;
    uint        GuidCount;
    WMIREGGUIDW WmiRegGuid;
}

struct EVENT_TRACE_HEADER
{
    ushort        Size;
    union
    {
        ushort FieldTypeFlags;
        struct
        {
            ubyte HeaderType;
            ubyte MarkerFlags;
        }
    }
    union
    {
        uint Version;
        struct Class
        {
            ubyte  Type;
            ubyte  Level;
            ushort Version;
        }
    }
    uint          ThreadId;
    uint          ProcessId;
    LARGE_INTEGER TimeStamp;
    union
    {
        GUID  Guid;
        ulong GuidPtr;
    }
    union
    {
        struct
        {
            uint KernelTime;
            uint UserTime;
        }
        ulong ProcessorTime;
        struct
        {
            uint ClientContext;
            uint Flags;
        }
    }
}

struct EVENT_INSTANCE_HEADER
{
    ushort        Size;
    union
    {
        ushort FieldTypeFlags;
        struct
        {
            ubyte HeaderType;
            ubyte MarkerFlags;
        }
    }
    union
    {
        uint Version;
        struct Class
        {
            ubyte  Type;
            ubyte  Level;
            ushort Version;
        }
    }
    uint          ThreadId;
    uint          ProcessId;
    LARGE_INTEGER TimeStamp;
    ulong         RegHandle;
    uint          InstanceId;
    uint          ParentInstanceId;
    union
    {
        struct
        {
            uint KernelTime;
            uint UserTime;
        }
        ulong ProcessorTime;
        struct
        {
            uint EventId;
            uint Flags;
        }
    }
    ulong         ParentRegHandle;
}

struct MOF_FIELD
{
    ulong DataPtr;
    uint  Length;
    uint  DataType;
}

struct TRACE_LOGFILE_HEADER
{
    uint          BufferSize;
    union
    {
        uint Version;
        struct VersionDetail
        {
            ubyte MajorVersion;
            ubyte MinorVersion;
            ubyte SubVersion;
            ubyte SubMinorVersion;
        }
    }
    uint          ProviderVersion;
    uint          NumberOfProcessors;
    LARGE_INTEGER EndTime;
    uint          TimerResolution;
    uint          MaximumFileSize;
    uint          LogFileMode;
    uint          BuffersWritten;
    union
    {
        GUID LogInstanceGuid;
        struct
        {
            uint StartBuffers;
            uint PointerSize;
            uint EventsLost;
            uint CpuSpeedInMHz;
        }
    }
    const(wchar)* LoggerName;
    const(wchar)* LogFileName;
    TIME_ZONE_INFORMATION TimeZone;
    LARGE_INTEGER BootTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER StartTime;
    uint          ReservedFlags;
    uint          BuffersLost;
}

struct TRACE_LOGFILE_HEADER32
{
    uint          BufferSize;
    union
    {
        uint Version;
        struct VersionDetail
        {
            ubyte MajorVersion;
            ubyte MinorVersion;
            ubyte SubVersion;
            ubyte SubMinorVersion;
        }
    }
    uint          ProviderVersion;
    uint          NumberOfProcessors;
    LARGE_INTEGER EndTime;
    uint          TimerResolution;
    uint          MaximumFileSize;
    uint          LogFileMode;
    uint          BuffersWritten;
    union
    {
        GUID LogInstanceGuid;
        struct
        {
            uint StartBuffers;
            uint PointerSize;
            uint EventsLost;
            uint CpuSpeedInMHz;
        }
    }
    uint          LoggerName;
    uint          LogFileName;
    TIME_ZONE_INFORMATION TimeZone;
    LARGE_INTEGER BootTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER StartTime;
    uint          ReservedFlags;
    uint          BuffersLost;
}

struct TRACE_LOGFILE_HEADER64
{
    uint          BufferSize;
    union
    {
        uint Version;
        struct VersionDetail
        {
            ubyte MajorVersion;
            ubyte MinorVersion;
            ubyte SubVersion;
            ubyte SubMinorVersion;
        }
    }
    uint          ProviderVersion;
    uint          NumberOfProcessors;
    LARGE_INTEGER EndTime;
    uint          TimerResolution;
    uint          MaximumFileSize;
    uint          LogFileMode;
    uint          BuffersWritten;
    union
    {
        GUID LogInstanceGuid;
        struct
        {
            uint StartBuffers;
            uint PointerSize;
            uint EventsLost;
            uint CpuSpeedInMHz;
        }
    }
    ulong         LoggerName;
    ulong         LogFileName;
    TIME_ZONE_INFORMATION TimeZone;
    LARGE_INTEGER BootTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER StartTime;
    uint          ReservedFlags;
    uint          BuffersLost;
}

struct EVENT_INSTANCE_INFO
{
    HANDLE RegHandle;
    uint   InstanceId;
}

struct EVENT_TRACE_PROPERTIES
{
    WNODE_HEADER Wnode;
    uint         BufferSize;
    uint         MinimumBuffers;
    uint         MaximumBuffers;
    uint         MaximumFileSize;
    uint         LogFileMode;
    uint         FlushTimer;
    uint         EnableFlags;
    union
    {
        int AgeLimit;
        int FlushThreshold;
    }
    uint         NumberOfBuffers;
    uint         FreeBuffers;
    uint         EventsLost;
    uint         BuffersWritten;
    uint         LogBuffersLost;
    uint         RealTimeBuffersLost;
    HANDLE       LoggerThreadId;
    uint         LogFileNameOffset;
    uint         LoggerNameOffset;
}

struct EVENT_TRACE_PROPERTIES_V2
{
    WNODE_HEADER Wnode;
    uint         BufferSize;
    uint         MinimumBuffers;
    uint         MaximumBuffers;
    uint         MaximumFileSize;
    uint         LogFileMode;
    uint         FlushTimer;
    uint         EnableFlags;
    union
    {
        int AgeLimit;
        int FlushThreshold;
    }
    uint         NumberOfBuffers;
    uint         FreeBuffers;
    uint         EventsLost;
    uint         BuffersWritten;
    uint         LogBuffersLost;
    uint         RealTimeBuffersLost;
    HANDLE       LoggerThreadId;
    uint         LogFileNameOffset;
    uint         LoggerNameOffset;
    union
    {
        struct
        {
            uint _bitfield36;
        }
        uint V2Control;
    }
    uint         FilterDescCount;
    EVENT_FILTER_DESCRIPTOR* FilterDesc;
    union
    {
        struct
        {
            uint _bitfield37;
        }
        ulong V2Options;
    }
}

struct TRACE_GUID_REGISTRATION
{
    GUID*  Guid;
    HANDLE RegHandle;
}

struct TRACE_GUID_PROPERTIES
{
    GUID  Guid;
    uint  GuidType;
    uint  LoggerId;
    uint  EnableLevel;
    uint  EnableFlags;
    ubyte IsEnable;
}

struct ETW_BUFFER_CONTEXT
{
    union
    {
        struct
        {
            ubyte ProcessorNumber;
            ubyte Alignment;
        }
        ushort ProcessorIndex;
    }
    ushort LoggerId;
}

struct TRACE_ENABLE_INFO
{
    uint   IsEnabled;
    ubyte  Level;
    ubyte  Reserved1;
    ushort LoggerId;
    uint   EnableProperty;
    uint   Reserved2;
    ulong  MatchAnyKeyword;
    ulong  MatchAllKeyword;
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
    uint      NextEntryOffset;
    uint      Source;
    uint      MinInterval;
    uint      MaxInterval;
    ulong     Reserved;
    ushort[1] Description;
}

struct EVENT_TRACE
{
    EVENT_TRACE_HEADER Header;
    uint               InstanceId;
    uint               ParentInstanceId;
    GUID               ParentGuid;
    void*              MofData;
    uint               MofLength;
    union
    {
        uint               ClientContext;
        ETW_BUFFER_CONTEXT BufferContext;
    }
}

struct EVENT_TRACE_LOGFILEW
{
    const(wchar)*        LogFileName;
    const(wchar)*        LoggerName;
    long                 CurrentTime;
    uint                 BuffersRead;
    union
    {
        uint LogFileMode;
        uint ProcessTraceMode;
    }
    EVENT_TRACE          CurrentEvent;
    TRACE_LOGFILE_HEADER LogfileHeader;
    PEVENT_TRACE_BUFFER_CALLBACKW BufferCallback;
    uint                 BufferSize;
    uint                 Filled;
    uint                 EventsLost;
    union
    {
        PEVENT_CALLBACK EventCallback;
        PEVENT_RECORD_CALLBACK EventRecordCallback;
    }
    uint                 IsKernelTrace;
    void*                Context;
}

struct EVENT_TRACE_LOGFILEA
{
    const(char)*         LogFileName;
    const(char)*         LoggerName;
    long                 CurrentTime;
    uint                 BuffersRead;
    union
    {
        uint LogFileMode;
        uint ProcessTraceMode;
    }
    EVENT_TRACE          CurrentEvent;
    TRACE_LOGFILE_HEADER LogfileHeader;
    PEVENT_TRACE_BUFFER_CALLBACKA BufferCallback;
    uint                 BufferSize;
    uint                 Filled;
    uint                 EventsLost;
    union
    {
        PEVENT_CALLBACK EventCallback;
        PEVENT_RECORD_CALLBACK EventRecordCallback;
    }
    uint                 IsKernelTrace;
    void*                Context;
}

struct ENABLE_TRACE_PARAMETERS_V1
{
    uint Version;
    uint EnableProperty;
    uint ControlFlags;
    GUID SourceId;
    EVENT_FILTER_DESCRIPTOR* EnableFilterDesc;
}

struct ENABLE_TRACE_PARAMETERS
{
    uint Version;
    uint EnableProperty;
    uint ControlFlags;
    GUID SourceId;
    EVENT_FILTER_DESCRIPTOR* EnableFilterDesc;
    uint FilterDescCount;
}

struct CLASSIC_EVENT_ID
{
    GUID     EventGuid;
    ubyte    Type;
    ubyte[7] Reserved;
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
    uint   CaptureStateFrequencyInSeconds;
    ushort ProviderCount;
    ushort Reserved;
}

struct ETW_TRACE_PARTITION_INFORMATION
{
    GUID PartitionId;
    GUID ParentId;
    long QpcOffsetFromRoot;
    uint PartitionType;
}

struct ETW_TRACE_PARTITION_INFORMATION_V2
{
    long          QpcOffsetFromRoot;
    uint          PartitionType;
    const(wchar)* PartitionId;
    const(wchar)* ParentId;
}

struct EVENT_DATA_DESCRIPTOR
{
    ulong Ptr;
    uint  Size;
    union
    {
        uint Reserved;
        struct
        {
            ubyte  Type;
            ubyte  Reserved1;
            ushort Reserved2;
        }
    }
}

struct EVENT_DESCRIPTOR
{
    ushort Id;
    ubyte  Version;
    ubyte  Channel;
    ubyte  Level;
    ubyte  Opcode;
    ushort Task;
    ulong  Keyword;
}

struct EVENT_FILTER_DESCRIPTOR
{
    ulong Ptr;
    uint  Size;
    uint  Type;
}

struct EVENT_FILTER_HEADER
{
    ushort   Id;
    ubyte    Version;
    ubyte[5] Reserved;
    ulong    InstanceId;
    uint     Size;
    uint     NextOffset;
}

struct EVENT_FILTER_EVENT_ID
{
    ubyte     FilterIn;
    ubyte     Reserved;
    ushort    Count;
    ushort[1] Events;
}

struct EVENT_FILTER_EVENT_NAME
{
    ulong    MatchAnyKeyword;
    ulong    MatchAllKeyword;
    ubyte    Level;
    ubyte    FilterIn;
    ushort   NameCount;
    ubyte[1] Names;
}

struct EVENT_FILTER_LEVEL_KW
{
    ulong MatchAnyKeyword;
    ulong MatchAllKeyword;
    ubyte Level;
    ubyte FilterIn;
}

struct EVENT_HEADER_EXTENDED_DATA_ITEM
{
    ushort Reserved1;
    ushort ExtType;
    struct
    {
        ushort _bitfield38;
    }
    ushort DataSize;
    ulong  DataPtr;
}

struct EVENT_EXTENDED_ITEM_INSTANCE
{
    uint InstanceId;
    uint ParentInstanceId;
    GUID ParentGuid;
}

struct EVENT_EXTENDED_ITEM_RELATED_ACTIVITYID
{
    GUID RelatedActivityId;
}

struct EVENT_EXTENDED_ITEM_TS_ID
{
    uint SessionId;
}

struct EVENT_EXTENDED_ITEM_STACK_TRACE32
{
    ulong   MatchId;
    uint[1] Address;
}

struct EVENT_EXTENDED_ITEM_STACK_TRACE64
{
    ulong    MatchId;
    ulong[1] Address;
}

struct EVENT_EXTENDED_ITEM_PEBS_INDEX
{
    ulong PebsIndex;
}

struct EVENT_EXTENDED_ITEM_PMC_COUNTERS
{
    ulong[1] Counter;
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
    ushort           Size;
    ushort           HeaderType;
    ushort           Flags;
    ushort           EventProperty;
    uint             ThreadId;
    uint             ProcessId;
    LARGE_INTEGER    TimeStamp;
    GUID             ProviderId;
    EVENT_DESCRIPTOR EventDescriptor;
    union
    {
        struct
        {
            uint KernelTime;
            uint UserTime;
        }
        ulong ProcessorTime;
    }
    GUID             ActivityId;
}

struct EVENT_RECORD
{
    EVENT_HEADER       EventHeader;
    ETW_BUFFER_CONTEXT BufferContext;
    ushort             ExtendedDataCount;
    ushort             UserDataLength;
    EVENT_HEADER_EXTENDED_DATA_ITEM* ExtendedData;
    void*              UserData;
    void*              UserContext;
}

struct EVENT_MAP_ENTRY
{
    uint OutputOffset;
    union
    {
        uint Value;
        uint InputOffset;
    }
}

struct EVENT_MAP_INFO
{
    uint               NameOffset;
    MAP_FLAGS          Flag;
    uint               EntryCount;
    union
    {
        MAP_VALUETYPE MapEntryValueType;
        uint          FormatStringOffset;
    }
    EVENT_MAP_ENTRY[1] MapEntryArray;
}

struct EVENT_PROPERTY_INFO
{
    PROPERTY_FLAGS Flags;
    uint           NameOffset;
    union
    {
        struct nonStructType
        {
            ushort InType;
            ushort OutType;
            uint   MapNameOffset;
        }
        struct structType
        {
            ushort StructStartIndex;
            ushort NumOfStructMembers;
            uint   padding;
        }
        struct customSchemaType
        {
            ushort InType;
            ushort OutType;
            uint   CustomSchemaOffset;
        }
    }
    union
    {
        ushort count;
        ushort countPropertyIndex;
    }
    union
    {
        ushort length;
        ushort lengthPropertyIndex;
    }
    union
    {
        uint Reserved;
        struct
        {
            uint _bitfield39;
        }
    }
}

struct TRACE_EVENT_INFO
{
    GUID             ProviderGuid;
    GUID             EventGuid;
    EVENT_DESCRIPTOR EventDescriptor;
    DECODING_SOURCE  DecodingSource;
    uint             ProviderNameOffset;
    uint             LevelNameOffset;
    uint             ChannelNameOffset;
    uint             KeywordsNameOffset;
    uint             TaskNameOffset;
    uint             OpcodeNameOffset;
    uint             EventMessageOffset;
    uint             ProviderMessageOffset;
    uint             BinaryXMLOffset;
    uint             BinaryXMLSize;
    union
    {
        uint EventNameOffset;
        uint ActivityIDNameOffset;
    }
    union
    {
        uint EventAttributesOffset;
        uint RelatedActivityIDNameOffset;
    }
    uint             PropertyCount;
    uint             TopLevelPropertyCount;
    union
    {
        TEMPLATE_FLAGS Flags;
        struct
        {
            uint _bitfield40;
        }
    }
    EVENT_PROPERTY_INFO[1] EventPropertyInfoArray;
}

struct PROPERTY_DATA_DESCRIPTOR
{
    ulong PropertyName;
    uint  ArrayIndex;
    uint  Reserved;
}

struct PAYLOAD_FILTER_PREDICATE
{
    const(wchar)* FieldName;
    ushort        CompareOp;
    const(wchar)* Value;
}

struct PROVIDER_FILTER_INFO
{
    ubyte Id;
    ubyte Version;
    uint  MessageOffset;
    uint  Reserved;
    uint  PropertyCount;
    EVENT_PROPERTY_INFO[1] EventPropertyInfoArray;
}

struct PROVIDER_FIELD_INFO
{
    uint  NameOffset;
    uint  DescriptionOffset;
    ulong Value;
}

struct PROVIDER_FIELD_INFOARRAY
{
    uint             NumberOfElements;
    EVENT_FIELD_TYPE FieldType;
    PROVIDER_FIELD_INFO[1] FieldInfoArray;
}

struct TRACE_PROVIDER_INFO
{
    GUID ProviderGuid;
    uint SchemaSource;
    uint ProviderNameOffset;
}

struct PROVIDER_ENUMERATION_INFO
{
    uint NumberOfProviders;
    uint Reserved;
    TRACE_PROVIDER_INFO[1] TraceProviderInfoArray;
}

struct PROVIDER_EVENT_INFO
{
    uint                NumberOfEvents;
    uint                Reserved;
    EVENT_DESCRIPTOR[1] EventDescriptorsArray;
}

struct TDH_CONTEXT
{
    ulong            ParameterValue;
    TDH_CONTEXT_TYPE ParameterType;
    uint             ParameterSize;
}

// Functions

@DllImport("ADVAPI32")
uint StartTraceW(ulong* TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint StartTraceA(ulong* TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint StopTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint StopTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint QueryTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint QueryTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint UpdateTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint UpdateTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint FlushTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint FlushTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties);

@DllImport("ADVAPI32")
uint ControlTraceW(ulong TraceHandle, const(wchar)* InstanceName, EVENT_TRACE_PROPERTIES* Properties, 
                   uint ControlCode);

@DllImport("ADVAPI32")
uint ControlTraceA(ulong TraceHandle, const(char)* InstanceName, EVENT_TRACE_PROPERTIES* Properties, 
                   uint ControlCode);

@DllImport("ADVAPI32")
uint QueryAllTracesW(char* PropertyArray, uint PropertyArrayCount, uint* LoggerCount);

@DllImport("ADVAPI32")
uint QueryAllTracesA(char* PropertyArray, uint PropertyArrayCount, uint* LoggerCount);

@DllImport("ADVAPI32")
uint EnableTrace(uint Enable, uint EnableFlag, uint EnableLevel, GUID* ControlGuid, ulong TraceHandle);

@DllImport("ADVAPI32")
uint EnableTraceEx(GUID* ProviderId, GUID* SourceId, ulong TraceHandle, uint IsEnabled, ubyte Level, 
                   ulong MatchAnyKeyword, ulong MatchAllKeyword, uint EnableProperty, 
                   EVENT_FILTER_DESCRIPTOR* EnableFilterDesc);

@DllImport("ADVAPI32")
uint EnableTraceEx2(ulong TraceHandle, GUID* ProviderId, uint ControlCode, ubyte Level, ulong MatchAnyKeyword, 
                    ulong MatchAllKeyword, uint Timeout, ENABLE_TRACE_PARAMETERS* EnableParameters);

@DllImport("ADVAPI32")
uint EnumerateTraceGuidsEx(TRACE_QUERY_INFO_CLASS TraceQueryInfoClass, char* InBuffer, uint InBufferSize, 
                           char* OutBuffer, uint OutBufferSize, uint* ReturnLength);

@DllImport("ADVAPI32")
uint TraceSetInformation(ulong SessionHandle, TRACE_QUERY_INFO_CLASS InformationClass, char* TraceInformation, 
                         uint InformationLength);

@DllImport("ADVAPI32")
uint TraceQueryInformation(ulong SessionHandle, TRACE_QUERY_INFO_CLASS InformationClass, char* TraceInformation, 
                           uint InformationLength, uint* ReturnLength);

@DllImport("ADVAPI32")
uint CreateTraceInstanceId(HANDLE RegHandle, EVENT_INSTANCE_INFO* InstInfo);

@DllImport("ADVAPI32")
uint TraceEvent(ulong TraceHandle, EVENT_TRACE_HEADER* EventTrace);

@DllImport("ADVAPI32")
uint TraceEventInstance(ulong TraceHandle, EVENT_INSTANCE_HEADER* EventTrace, EVENT_INSTANCE_INFO* InstInfo, 
                        EVENT_INSTANCE_INFO* ParentInstInfo);

@DllImport("ADVAPI32")
uint RegisterTraceGuidsW(WMIDPREQUEST RequestAddress, void* RequestContext, GUID* ControlGuid, uint GuidCount, 
                         char* TraceGuidReg, const(wchar)* MofImagePath, const(wchar)* MofResourceName, 
                         ulong* RegistrationHandle);

@DllImport("ADVAPI32")
uint RegisterTraceGuidsA(WMIDPREQUEST RequestAddress, void* RequestContext, GUID* ControlGuid, uint GuidCount, 
                         char* TraceGuidReg, const(char)* MofImagePath, const(char)* MofResourceName, 
                         ulong* RegistrationHandle);

@DllImport("ADVAPI32")
uint EnumerateTraceGuids(char* GuidPropertiesArray, uint PropertyArrayCount, uint* GuidCount);

@DllImport("ADVAPI32")
uint UnregisterTraceGuids(ulong RegistrationHandle);

@DllImport("ADVAPI32")
ulong GetTraceLoggerHandle(void* Buffer);

@DllImport("ADVAPI32")
ubyte GetTraceEnableLevel(ulong TraceHandle);

@DllImport("ADVAPI32")
uint GetTraceEnableFlags(ulong TraceHandle);

@DllImport("ADVAPI32")
ulong OpenTraceW(EVENT_TRACE_LOGFILEW* Logfile);

@DllImport("ADVAPI32")
uint ProcessTrace(char* HandleArray, uint HandleCount, FILETIME* StartTime, FILETIME* EndTime);

@DllImport("ADVAPI32")
uint CloseTrace(ulong TraceHandle);

@DllImport("ADVAPI32")
uint QueryTraceProcessingHandle(ulong ProcessingHandle, ETW_PROCESS_HANDLE_INFO_TYPE InformationClass, 
                                void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                uint* ReturnLength);

@DllImport("ADVAPI32")
ulong OpenTraceA(EVENT_TRACE_LOGFILEA* Logfile);

@DllImport("ADVAPI32")
uint SetTraceCallback(GUID* pGuid, PEVENT_CALLBACK EventCallback);

@DllImport("ADVAPI32")
uint RemoveTraceCallback(GUID* pGuid);

@DllImport("ADVAPI32")
uint TraceMessage(ulong LoggerHandle, uint MessageFlags, GUID* MessageGuid, ushort MessageNumber);

@DllImport("ADVAPI32")
uint TraceMessageVa(ulong LoggerHandle, uint MessageFlags, GUID* MessageGuid, ushort MessageNumber, 
                    byte* MessageArgList);

@DllImport("ADVAPI32")
uint EventRegister(GUID* ProviderId, PENABLECALLBACK EnableCallback, void* CallbackContext, ulong* RegHandle);

@DllImport("ADVAPI32")
uint EventUnregister(ulong RegHandle);

@DllImport("ADVAPI32")
uint EventSetInformation(ulong RegHandle, EVENT_INFO_CLASS InformationClass, char* EventInformation, 
                         uint InformationLength);

@DllImport("ADVAPI32")
ubyte EventEnabled(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor);

@DllImport("ADVAPI32")
ubyte EventProviderEnabled(ulong RegHandle, ubyte Level, ulong Keyword);

@DllImport("ADVAPI32")
uint EventWrite(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, uint UserDataCount, char* UserData);

@DllImport("ADVAPI32")
uint EventWriteTransfer(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, GUID* ActivityId, 
                        GUID* RelatedActivityId, uint UserDataCount, char* UserData);

@DllImport("ADVAPI32")
uint EventWriteEx(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, ulong Filter, uint Flags, GUID* ActivityId, 
                  GUID* RelatedActivityId, uint UserDataCount, char* UserData);

@DllImport("ADVAPI32")
uint EventWriteString(ulong RegHandle, ubyte Level, ulong Keyword, const(wchar)* String);

@DllImport("ADVAPI32")
uint EventActivityIdControl(uint ControlCode, GUID* ActivityId);

@DllImport("ADVAPI32")
uint EventAccessControl(GUID* Guid, uint Operation, void* Sid, uint Rights, ubyte AllowOrDeny);

@DllImport("ADVAPI32")
uint EventAccessQuery(GUID* Guid, char* Buffer, uint* BufferSize);

@DllImport("ADVAPI32")
uint EventAccessRemove(GUID* Guid);

@DllImport("tdh")
uint TdhCreatePayloadFilter(GUID* ProviderGuid, EVENT_DESCRIPTOR* EventDescriptor, ubyte EventMatchANY, 
                            uint PayloadPredicateCount, char* PayloadPredicates, void** PayloadFilter);

@DllImport("tdh")
uint TdhDeletePayloadFilter(void** PayloadFilter);

@DllImport("tdh")
uint TdhAggregatePayloadFilters(uint PayloadFilterCount, char* PayloadFilterPtrs, char* EventMatchALLFlags, 
                                EVENT_FILTER_DESCRIPTOR* EventFilterDescriptor);

@DllImport("tdh")
uint TdhCleanupPayloadEventFilterDescriptor(EVENT_FILTER_DESCRIPTOR* EventFilterDescriptor);

@DllImport("TDH")
uint TdhGetEventInformation(EVENT_RECORD* Event, uint TdhContextCount, char* TdhContext, char* Buffer, 
                            uint* BufferSize);

@DllImport("TDH")
uint TdhGetEventMapInformation(EVENT_RECORD* pEvent, const(wchar)* pMapName, char* pBuffer, uint* pBufferSize);

@DllImport("TDH")
uint TdhGetPropertySize(EVENT_RECORD* pEvent, uint TdhContextCount, char* pTdhContext, uint PropertyDataCount, 
                        char* pPropertyData, uint* pPropertySize);

@DllImport("TDH")
uint TdhGetProperty(EVENT_RECORD* pEvent, uint TdhContextCount, char* pTdhContext, uint PropertyDataCount, 
                    char* pPropertyData, uint BufferSize, char* pBuffer);

@DllImport("TDH")
uint TdhEnumerateProviders(char* pBuffer, uint* pBufferSize);

@DllImport("TDH")
uint TdhQueryProviderFieldInformation(GUID* pGuid, ulong EventFieldValue, EVENT_FIELD_TYPE EventFieldType, 
                                      char* pBuffer, uint* pBufferSize);

@DllImport("TDH")
uint TdhEnumerateProviderFieldInformation(GUID* pGuid, EVENT_FIELD_TYPE EventFieldType, char* pBuffer, 
                                          uint* pBufferSize);

@DllImport("tdh")
uint TdhEnumerateProviderFilters(GUID* Guid, uint TdhContextCount, char* TdhContext, uint* FilterCount, 
                                 char* Buffer, uint* BufferSize);

@DllImport("TDH")
uint TdhLoadManifest(const(wchar)* Manifest);

@DllImport("TDH")
uint TdhLoadManifestFromMemory(char* pData, uint cbData);

@DllImport("TDH")
uint TdhUnloadManifest(const(wchar)* Manifest);

@DllImport("TDH")
uint TdhUnloadManifestFromMemory(char* pData, uint cbData);

@DllImport("TDH")
uint TdhFormatProperty(TRACE_EVENT_INFO* EventInfo, EVENT_MAP_INFO* MapInfo, uint PointerSize, 
                       ushort PropertyInType, ushort PropertyOutType, ushort PropertyLength, ushort UserDataLength, 
                       char* UserData, uint* BufferSize, const(wchar)* Buffer, ushort* UserDataConsumed);

@DllImport("tdh")
uint TdhOpenDecodingHandle(TDH_HANDLE* Handle);

@DllImport("tdh")
uint TdhSetDecodingParameter(TDH_HANDLE Handle, TDH_CONTEXT* TdhContext);

@DllImport("tdh")
uint TdhGetDecodingParameter(TDH_HANDLE Handle, TDH_CONTEXT* TdhContext);

@DllImport("tdh")
uint TdhGetWppProperty(TDH_HANDLE Handle, EVENT_RECORD* EventRecord, const(wchar)* PropertyName, uint* BufferSize, 
                       char* Buffer);

@DllImport("tdh")
uint TdhGetWppMessage(TDH_HANDLE Handle, EVENT_RECORD* EventRecord, uint* BufferSize, char* Buffer);

@DllImport("tdh")
uint TdhCloseDecodingHandle(TDH_HANDLE Handle);

@DllImport("tdh")
uint TdhLoadManifestFromBinary(const(wchar)* BinaryPath);

@DllImport("TDH")
uint TdhEnumerateManifestProviderEvents(GUID* ProviderGuid, char* Buffer, uint* BufferSize);

@DllImport("TDH")
uint TdhGetManifestEventInformation(GUID* ProviderGuid, EVENT_DESCRIPTOR* EventDescriptor, char* Buffer, 
                                    uint* BufferSize);

@DllImport("ADVAPI32")
int CveEventWrite(const(wchar)* CveId, const(wchar)* AdditionalDetails);


// Interfaces

@GUID("7B40792D-05FF-44C4-9058-F440C71F17D4")
struct CTraceRelogger;

@GUID("8CC97F40-9028-4FF3-9B62-7D1F79CA7BCB")
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
    HRESULT SetActivityId(GUID* ActivityId);
    HRESULT SetTimeStamp(LARGE_INTEGER* TimeStamp);
    HRESULT SetProviderId(GUID* ProviderId);
}

@GUID("3ED25501-593F-43E9-8F38-3AB46F5A4A52")
interface ITraceEventCallback : IUnknown
{
    HRESULT OnBeginProcessTrace(ITraceEvent HeaderEvent, ITraceRelogger Relogger);
    HRESULT OnFinalizeProcessTrace(ITraceRelogger Relogger);
    HRESULT OnEvent(ITraceEvent Event, ITraceRelogger Relogger);
}

@GUID("F754AD43-3BCC-4286-8009-9C5DA214E84E")
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


// GUIDs

const GUID CLSID_CTraceRelogger = GUIDOF!CTraceRelogger;

const GUID IID_ITraceEvent         = GUIDOF!ITraceEvent;
const GUID IID_ITraceEventCallback = GUIDOF!ITraceEventCallback;
const GUID IID_ITraceRelogger      = GUIDOF!ITraceRelogger;
