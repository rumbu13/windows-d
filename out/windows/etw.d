// Written in the D programming language.

module windows.etw;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : HANDLE, LARGE_INTEGER, PSTR, PWSTR;
public import windows.windowsprogramming : FILETIME, TIME_ZONE_INFORMATION;

extern(Windows) @nogc nothrow:


// Enums


alias WMIDPREQUESTCODE = int;
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

alias ETW_COMPRESSION_RESUMPTION_MODE = int;
enum : int
{
    EtwCompressionModeRestart   = 0x00000000,
    EtwCompressionModeNoDisable = 0x00000001,
    EtwCompressionModeNoRestart = 0x00000002,
}

///Determines the type of information to include with the trace.
alias TRACE_QUERY_INFO_CLASS = int;
enum : int
{
    ///Query an array of GUIDs of the providers that are registered on the computer.
    TraceGuidQueryList                = 0x00000000,
    ///Query information that each session used to enable the provider.
    TraceGuidQueryInfo                = 0x00000001,
    ///Query an array of GUIDs of the providers that registered themselves in the same process as the calling process.
    TraceGuidQueryProcess             = 0x00000002,
    ///Query the setting for call stack tracing for kernel events. The value is supported on Windows 7, Windows Server
    ///2008 R2, and later.
    TraceStackTracingInfo             = 0x00000003,
    ///Query the setting for the <b>EnableFlags</b> for the system trace provider. For more information, see the
    ///EVENT_TRACE_PROPERTIES structure. The value is supported on Windows 8, Windows Server 2012, and later.
    TraceSystemTraceEnableFlagsInfo   = 0x00000004,
    ///Queries the setting for the sampling profile interval for the supplied source. The value is supported on Windows
    ///8, Windows Server 2012, and later.
    TraceSampledProfileIntervalInfo   = 0x00000005,
    ///Query which sources will be traced. The value is supported on Windows 8, Windows Server 2012, and later.
    TraceProfileSourceConfigInfo      = 0x00000006,
    ///Query the setting for sampled profile list information. The value is supported on Windows 8, Windows Server 2012,
    ///and later.
    TraceProfileSourceListInfo        = 0x00000007,
    ///Query the list of system events on which performance monitoring counters will be collected. The value is
    ///supported on Windows 8, Windows Server 2012, and later.
    TracePmcEventListInfo             = 0x00000008,
    ///Query the list of performance monitoring counters to collect The value is supported on Windows 8, Windows Server
    ///2012, and later.
    TracePmcCounterListInfo           = 0x00000009,
    ///Set the list of providers that are disabled for a provider group enable on this session. For more information,
    ///see Provider Traits The value is supported on Windows 10.
    TraceSetDisallowList              = 0x0000000a,
    ///Query the trace file version information. The value is supported on Windows 10.
    TraceVersionInfo                  = 0x0000000b,
    ///Query an array of GUIDs of the provider groups that are active on the computer.
    TraceGroupQueryList               = 0x0000000c,
    ///Query information that each session used to enable the provider group.
    TraceGroupQueryInfo               = 0x0000000d,
    ///Query an array of GUIDs that are disallowed for group enables on this session.
    TraceDisallowListQuery            = 0x0000000e,
    TraceInfoReserved15               = 0x0000000f,
    ///Query the list of periodic capture states to collect.
    TracePeriodicCaptureStateListInfo = 0x00000010,
    ///Queries the settings used for periodic capture state.
    TracePeriodicCaptureStateInfo     = 0x00000011,
    ///Instructs ETW to begin tracking binaries for all providers that are enabled to the session. The tracking applies
    ///retroactively for providers that were enabled to the session prior to the call, as well as for all future
    ///providers that are enabled to the session. ETW fabricates tracking events for these tracked providers that
    ///contain a mapping between provider GUID(s). ETW also fabricates the file path that describes where the registered
    ///provider is located on disk. If the session is in realtime, the events are provided live in the realtime buffers.
    ///If the session is file-based (i.e. trace is saved to an .etl file), the events are aggregated and written to the
    ///file header; they will be among some of the first events the ETW runtime provides when the .etl file is played
    ///back. The binary tracking events will come from the EventTraceGuid provider, with an opcode of
    ///<b>WMI_LOG_TYPE_BINARY_PATH</b>. The value is supported on Windows 10, version 1709 and later.
    TraceProviderBinaryTracking       = 0x00000012,
    ///Queries the currently-configured maximum number of system loggers allowed by the operating system. Returns a
    ///ULONG. Used with EnumerateTraceGuidsEx. The value is supported on Windows 10, version 1709 and later.
    TraceMaxLoggersQuery              = 0x00000013,
    TraceLbrConfigurationInfo         = 0x00000014,
    TraceLbrEventListInfo             = 0x00000015,
    TraceMaxPmcCounterQuery           = 0x00000016,
    ///Marks the last value in the enumeration. Do not use.
    MaxTraceSetInfoClass              = 0x00000017,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Specifies what kind of operation will be done on a handle. currently used with the
///QueryTraceProcessingHandle function.
alias ETW_PROCESS_HANDLE_INFO_TYPE = int;
enum : int
{
    ///Used to query partition identifying information. <i>InBuffer</i> should be Null. <i>OutBuffer</i> should be large
    ///enough to hold the returned ETW_TRACE_PARTITION_INFORMATION structure. Note that this will only return a non-zero
    ///structure when the queried handle is for a trace file generated from a non-host partition on Windows 10, version
    ///1709.
    EtwQueryPartitionInformation   = 0x00000001,
    EtwQueryPartitionInformationV2 = 0x00000002,
    EtwQueryLastDroppedTimes       = 0x00000003,
    EtwQueryProcessHandleInfoMax   = 0x00000004,
}

///The <b>EVENT_INFO_CLASS</b> enumerated type defines a type of operation to perform on a registration object.
alias EVENT_INFO_CLASS = int;
enum : int
{
    ///Tracks the full path for the binary (DLL or EXE) from which the ETW registration was made.
    EventProviderBinaryTrackInfo   = 0x00000000,
    EventProviderSetReserved1      = 0x00000001,
    ///Sets traits for the provider. Implicitly indicates that the provider correctly initializes the
    ///EVENT_DATA_DESCRIPTOR values passed to EventWrite APIs, so the EVENT_DATA_DESCRIPTOR::Type field will be
    ///respected. For more information on the format of the traits, see Provider Traits.
    EventProviderSetTraits         = 0x00000002,
    ///Indicates whether the provider correctly initializes the EVENT_DATA_DESCRIPTOR values passed to EventWrite APIs,
    ///which in turn indicates whether the EVENT_DATA_DESCRIPTOR::Type field will be respected by the EventWrite APIs.
    EventProviderUseDescriptorType = 0x00000003,
    ///Maximum value for testing purposes.
    MaxEventInfo                   = 0x00000004,
}

alias ETW_PROVIDER_TRAIT_TYPE = int;
enum : int
{
    EtwProviderTraitTypeGroup  = 0x00000001,
    EtwProviderTraitDecodeGuid = 0x00000002,
    EtwProviderTraitTypeMax    = 0x00000003,
}

///Defines what component of the security descriptor that the EventAccessControl function modifies.
alias EVENTSECURITYOPERATION = int;
enum : int
{
    ///Clears the current discretionary access control list (DACL) and adds an ACE to the DACL. The <i>Sid</i>,
    ///<i>Rights</i>, and <i>AllowOrDeny</i> parameters of the EventAccessControl function determine the contents of the
    ///ACE (who has access to the provider or session and the type of access). To add a new ACE to the DACL without
    ///clearing the existing DACL, specify EventSecurityAddDACL.
    EventSecuritySetDACL = 0x00000000,
    ///Clears the current system access control list (SACL) and adds an audit ACE to the SACL. The <i>Sid</i> and
    ///<i>Rights</i> parameters of the EventAccessControl function determine the contents of the ACE (who generates an
    ///audit record when attempting the specified access). To add a new ACE to the SACL without clearing the existing
    ///SACL, specify EventSecurityAddSACL.
    EventSecuritySetSACL = 0x00000001,
    ///Adds an ACE to the current DACL. The <i>Sid</i>, <i>Rights</i>, and <i>AllowOrDeny</i> parameters of the
    ///EventAccessControl function determine the contents of the ACE (who has access to the provider or session and the
    ///type of access).
    EventSecurityAddDACL = 0x00000002,
    ///Adds an ACE to the current SACL. The <i>Sid</i> and <i>Rights</i> parameters of the EventAccessControl function
    ///determine the contents of the ACE (who generates an audit record when attempting the specified access).
    EventSecurityAddSACL = 0x00000003,
    ///Reserved.
    EventSecurityMax     = 0x00000004,
}

///Defines constant values that indicate if the map is a value map, bitmap, or pattern map.
alias MAP_FLAGS = int;
enum : int
{
    ///The manifest value map maps integer values to strings. For details, see the MapType complex type.
    EVENTMAP_INFO_FLAG_MANIFEST_VALUEMAP   = 0x00000001,
    ///The manifest value map maps bit values to strings. For details, see the MapType complex type.
    EVENTMAP_INFO_FLAG_MANIFEST_BITMAP     = 0x00000002,
    ///The manifest value map uses regular expressions to map one name to another name. For details, see the
    ///PatternMapType complex type.
    EVENTMAP_INFO_FLAG_MANIFEST_PATTERNMAP = 0x00000004,
    ///The WMI value map maps integer values to strings. For details, see ValueMap and Value Qualifiers.
    EVENTMAP_INFO_FLAG_WBEM_VALUEMAP       = 0x00000008,
    ///The WMI value map maps bit values to strings. For details, see BitMap and BitValue Qualifiers.
    EVENTMAP_INFO_FLAG_WBEM_BITMAP         = 0x00000010,
    ///This flag can be combined with the EVENTMAP_INFO_FLAG_WBEM_VALUEMAP flag to indicate that the ValueMap qualifier
    ///contains bit (flag) values instead of index values.
    EVENTMAP_INFO_FLAG_WBEM_FLAG           = 0x00000020,
    ///This flag can be combined with the EVENTMAP_INFO_FLAG_WBEM_VALUEMAP or EVENTMAP_INFO_FLAG_WBEM_BITMAP flag to
    ///indicate that the MOF class property contains a BitValues or Values qualifier but does not contain the BitMap or
    ///ValueMap qualifier.
    EVENTMAP_INFO_FLAG_WBEM_NO_MAP         = 0x00000040,
}

///Defines if the value map value is in a ULONG data type or a string.
alias MAP_VALUETYPE = int;
enum : int
{
    ///Use the <b>Value</b> member of EVENT_MAP_ENTRY to access the map value.
    EVENTMAP_ENTRY_VALUETYPE_ULONG  = 0x00000000,
    ///Use the <b>InputOffset</b> member of EVENT_MAP_ENTRY to access the map value.
    EVENTMAP_ENTRY_VALUETYPE_STRING = 0x00000001,
}

alias _TDH_IN_TYPE = int;
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

alias _TDH_OUT_TYPE = int;
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

///Defines if the property is contained in a structure or array.
alias PROPERTY_FLAGS = int;
enum : int
{
    ///The property information is contained in the <b>structType</b> member of the EVENT_PROPERTY_INFO structure.
    PropertyStruct           = 0x00000001,
    ///Use the <b>lengthPropertyIndex</b> member of the EVENT_PROPERTY_INFO structure to locate the property that
    ///contains the length value of the property.
    PropertyParamLength      = 0x00000002,
    ///Use the <b>countPropertyIndex</b> member of the EVENT_PROPERTY_INFO structure to locate the property that
    ///contains the size of the array.
    PropertyParamCount       = 0x00000004,
    ///Indicates that the MOF data is in XML format (the event data contains within itself a fully-rendered XML
    ///description). This flag is set if the MOF property contains the XMLFragment qualifier.
    PropertyWBEMXmlFragment  = 0x00000008,
    ///Indicates that the length member of the EVENT_PROPERTY_INFO structure contains a fixed length, e.g. as specified
    ///in the provider manifest with &lt;data length="12" … /&gt;. This flag will not be set for a variable-length
    ///field, e.g. &lt;data length="LengthField" … /&gt;, nor will this flag be set for fields where the length is not
    ///specified in the manifest, e.g. int32 or null-terminated string. As an example, if <i>PropertyParamLength</i> is
    ///unset, length is 0, and InType is <b>TDH_INTYPE_UNICODESTRING</b>, we must check the
    ///<i>PropertyParamFixedLength</i> flag to determine the length of the string. If <i>PropertyParamFixedLength</i> is
    ///set, the string length is fixed at 0. If <i>PropertyParamFixedLength</i> is unset, the string is null-terminated.
    PropertyParamFixedLength = 0x00000010,
    ///Indicates that the count member of the EVENT_PROPERTY_INFO structure contains a fixed array count, e.g. as
    ///specified in the provider manifest with &lt;data count="12" … /&gt;. This flag will not be set for a
    ///variable-length array, e.g. &lt;data count="ArrayCount" … /&gt;, nor will this flag be set for non-array
    ///fields. As an example, if <i>PropertyParamCount</i> is unset and count is 1, PropertyParamFixedCount flag must be
    ///checked to determine whether the field is a scalar value or a single-element array. If
    ///<i>PropertyParamFixedCount</i> is set, the field is a single-element array. If PropertyParamFixedCount is unset,
    ///the field is a scalar value, not an array. <div class="alert"><b>Caution</b> This flag is new in the Windows 10
    ///SDK. Earlier versions of the manifest compiler did not set this flag. For compatibility with manifests compiled
    ///with earlier versions of the compiler, event processing tools should only use this flag when determining whether
    ///to present a field with a fixed count of 1 as an array or a scalar.</div> <div> </div>
    PropertyParamFixedCount  = 0x00000020,
    ///Indicates that the <b>Tags</b> field contains valid field tag data.
    PropertyHasTags          = 0x00000040,
    ///Indicates that the <b>Type</b> is described with a custom schema. <div class="alert"><b>Note</b> This flag is new
    ///in the Windows 10 SDK.</div> <div> </div>
    PropertyHasCustomSchema  = 0x00000080,
}

///Defines the source of the event data.
alias DECODING_SOURCE = int;
enum : int
{
    ///The source of the event data is a XML manifest.
    DecodingSourceXMLFile = 0x00000000,
    ///The source of the event data is a WMI MOF class.
    DecodingSourceWbem    = 0x00000001,
    ///The source of the event data is a TMF file.
    DecodingSourceWPP     = 0x00000002,
    ///Indicates that the event was a self-describing event and was decoded using TraceLogging metadata.
    DecodingSourceTlg     = 0x00000003,
    DecodingSourceMax     = 0x00000004,
}

///Defines constant values that indicates the layout of the event data.
alias TEMPLATE_FLAGS = int;
enum : int
{
    ///The layout of the event data is determined by the order of the data items defined in the event data template
    ///definition.
    TEMPLATE_EVENT_DATA   = 0x00000001,
    ///The layout of the event data is determined by the XML fragment included in the event data template definition.
    TEMPLATE_USER_DATA    = 0x00000002,
    TEMPLATE_CONTROL_GUID = 0x00000004,
}

alias PAYLOAD_OPERATOR = int;
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

///Defines the provider information to retrieve.
alias EVENT_FIELD_TYPE = int;
enum : int
{
    ///Keyword information defined in the manifest. For providers that define themselves using MOF classes, this type
    ///returns the enable flags values if the provider class includes the Flags property. For details, see the
    ///"Specifying level and enable flags values for a provider" section of Event Tracing MOF Qualifiers.
    EventKeywordInformation = 0x00000000,
    ///Level information defined in the manifest.
    EventLevelInformation   = 0x00000001,
    ///Channel information defined in the manifest.
    EventChannelInformation = 0x00000002,
    ///Task information defined in the manifest.
    EventTaskInformation    = 0x00000003,
    ///Operation code information defined in the manifest.
    EventOpcodeInformation  = 0x00000004,
    ///Reserved.
    EventInformationMax     = 0x00000005,
}

///Defines the context type.
alias TDH_CONTEXT_TYPE = int;
enum : int
{
    ///Null-terminated Unicode string that contains the name of the .tmf file used for parsing the WPP log. Typically,
    ///the .tmf file name is picked up from the event GUID so you do not have to specify the file name.
    TDH_CONTEXT_WPP_TMFFILE       = 0x00000000,
    ///Null-terminated Unicode string that contains the path to the .tmf file. You do not have to specify this path if
    ///the search path contains the file. Only specify this context information if you also specify the
    ///TDH_CONTEXT_WPP_TMFFILE context type. If the file is not found, TDH searches the following locations in the given
    ///order: <ul> <li>The path specified in the TRACE_FORMAT_SEARCH_PATH environment variable</li> <li>The current
    ///folder</li> </ul>
    TDH_CONTEXT_WPP_TMFSEARCHPATH = 0x00000001,
    ///A 1-byte Boolean flag that indicates if the WPP event time stamp should be converted to Universal Time Coordinate
    ///(UTC). If 1, the time stamp is converted to UTC. If 0, the time stamp is in local time. By default, the time
    ///stamp is in local time.
    TDH_CONTEXT_WPP_GMT           = 0x00000002,
    ///Size, in bytes, of the pointer data types or size_t data types used in the event. Indicates if the event used
    ///4-byte or 8-byte values. By default, the pointer size is the pointer size of the decoding computer. To determine
    ///the size of the pointer or size_t value, use the <b>PointerSize</b> member of TRACE_LOGFILE_HEADER (the first
    ///event you receive in your EventRecordCallback callback contains this header in the data section). However, this
    ///value may not be accurate. For example, on a 64-bit computer, a 32-bit application will log 4-byte pointers;
    ///however, the session will set <b>PointerSize</b> to 8.
    TDH_CONTEXT_POINTERSIZE       = 0x00000003,
    ///Null-terminated Unicode string that contains the name of the .pdb file for the binary that contains WPP messages.
    ///This parameter can be used as an alternative to <b>TDH_CONTEXT_WPP_TMFFILE</b> or
    ///<b>TDH_CONTEXT_WPP_TMFSEARCHPATH</b>. <div class="alert"><b>Note</b> Available only for Windows 8 and Windows
    ///Server 2012.</div> <div> </div>
    TDH_CONTEXT_PDB_PATH          = 0x00000004,
    ///Reserved.
    TDH_CONTEXT_MAXIMUM           = 0x00000005,
}

// Constants


enum GUID CLSID_TraceRelogger = GUID("7b40792d-05ff-44c4-9058-f440c71f17d4");

// Callbacks

///Consumers implement this function to receive statistics about each buffer of events that ETW delivers to an event
///trace consumer. ETW calls this function after the events for each buffer are delivered. The
///<b>PEVENT_TRACE_BUFFER_CALLBACK</b> type defines a pointer to this callback function. <b>BufferCallback</b> is a
///placeholder for the application-defined function name.
///Params:
///    Logfile = Pointer to an EVENT_TRACE_LOGFILE structure that contains information about the buffer.
///Returns:
///    To continue processing events, return <b>TRUE</b>. Otherwise, return <b>FALSE</b>. Returning <b>FALSE</b> will
///    terminate the ProcessTrace function.
///    
alias PEVENT_TRACE_BUFFER_CALLBACKW = uint function(EVENT_TRACE_LOGFILEW* Logfile);
///Consumers implement this function to receive statistics about each buffer of events that ETW delivers to an event
///trace consumer. ETW calls this function after the events for each buffer are delivered. The
///<b>PEVENT_TRACE_BUFFER_CALLBACK</b> type defines a pointer to this callback function. <b>BufferCallback</b> is a
///placeholder for the application-defined function name.
///Params:
///    Logfile = Pointer to an EVENT_TRACE_LOGFILE structure that contains information about the buffer.
///Returns:
///    To continue processing events, return <b>TRUE</b>. Otherwise, return <b>FALSE</b>. Returning <b>FALSE</b> will
///    terminate the ProcessTrace function.
///    
alias PEVENT_TRACE_BUFFER_CALLBACKA = uint function(EVENT_TRACE_LOGFILEA* Logfile);
///Consumers implement this function to receive events from a session. The <b>PEVENT_CALLBACK</b> type defines a pointer
///to this callback function. <b>EventCallback</b> is a placeholder for the application-defined function name.
///Params:
///    pEvent = Pointer to an EVENT_TRACE structure that contains the event information.
alias PEVENT_CALLBACK = void function(EVENT_TRACE* pEvent);
///Consumers implement this callback to receive events from a session. The <b>PEVENT_RECORD_CALLBACK</b> type defines a
///pointer to this callback function. <b>EventRecordCallback</b> is a placeholder for the application-defined function
///name.
///Params:
///    EventRecord = Pointer to an EVENT_RECORD structure that contains the event information.
alias PEVENT_RECORD_CALLBACK = void function(EVENT_RECORD* EventRecord);
///Providers implement this function to receive enable or disable notification requests from controllers. The
///<b>WMIDPREQUEST</b> type defines a pointer to this callback function. <b>ControlCallback</b> is a placeholder for the
///application-defined function name.
///Params:
///    RequestCode = Request code. Specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="WMI_ENABLE_EVENTS"></a><a id="wmi_enable_events"></a><dl> <dt><b>WMI_ENABLE_EVENTS</b></dt>
///                  </dl> </td> <td width="60%"> Enables the provider. </td> </tr> <tr> <td width="40%"><a
///                  id="WMI_DISABLE_EVENTS"></a><a id="wmi_disable_events"></a><dl> <dt><b>WMI_DISABLE_EVENTS</b></dt> </dl> </td>
///                  <td width="60%"> Disables the provider. </td> </tr> </table>
///    RequestContext = Provider-defined context. The provider uses the <i>RequestContext</i> parameter of RegisterTraceGuids to specify
///                     the context.
///    BufferSize = Reserved for internal use.
///    Buffer = Pointer to a WNODE_HEADER structure that contains information about the event tracing session for which the
///             provider is being enabled or disabled.
///Returns:
///    You should return ERROR_SUCCESS if the callback succeeds. Note that ETW ignores the return value for this
///    function except when a controller calls EnableTrace to enable a provider and the provider has not yet called
///    RegisterTraceGuids. When this occurs, <b>RegisterTraceGuids</b> will return the return value of this callback if
///    the registration was successful.
///    
alias WMIDPREQUEST = uint function(WMIDPREQUESTCODE RequestCode, void* RequestContext, uint* BufferSize, 
                                   void* Buffer);
///Providers implement this function to receive enable or disable notification requests. The <b>PENABLECALLBACK</b> type
///defines a pointer to this callback function. <b>EnableCallback</b> is a placeholder for the application-defined
///function name.
///Params:
///    SourceId = GUID that identifies the session that enabled the provider. The value is GUID_NULL if EnableTraceEx did not
///               specify a source identifier.
///    IsEnabled = Indicates if the session is enabling or disabling the provider. A value of zero indicates that the session is
///                disabling the provider. A value of 1 indicates that the session is enabling the provider. Beginning with Windows
///                7, this value can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="EVENT_CONTROL_CODE_DISABLE_PROVIDER"></a><a id="event_control_code_disable_provider"></a><dl>
///                <dt><b>EVENT_CONTROL_CODE_DISABLE_PROVIDER</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The session is
///                disabling the provider. </td> </tr> <tr> <td width="40%"><a id="EVENT_CONTROL_CODE_ENABLE_PROVIDER"></a><a
///                id="event_control_code_enable_provider"></a><dl> <dt><b>EVENT_CONTROL_CODE_ENABLE_PROVIDER</b></dt> <dt>1</dt>
///                </dl> </td> <td width="60%"> The session is enabling the provider. </td> </tr> <tr> <td width="40%"><a
///                id="EVENT_CONTROL_CODE_CAPTURE_STATE"></a><a id="event_control_code_capture_state"></a><dl>
///                <dt><b>EVENT_CONTROL_CODE_CAPTURE_STATE</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The session is
///                requesting that the provider log its state information. The provider determines the state information that it
///                logs. </td> </tr> </table> If you receive a value (for example, EVENT_CONTROL_CODE_CAPTURE_STATE) that you do not
///                support, ignore the value (do not fail).
///    Level = Provider-defined value that specifies the verboseness of the events that the provider writes. The provider must
///            write the event if this value is less than or equal to the level value that the event defines. This value is
///            passed in the <i>Level</i> parameter of the EnableTraceEx function or the <i>EnableLevel</i> parameter of
///            EnableTrace.
///    MatchAnyKeyword = Bitmask of keywords that the provider uses to determine the category of events that it writes. This value is
///                      passed in the <i>MatchAnyKeyword</i> parameter of the EnableTraceEx function or the <i>EnableFlag</i> parameter
///                      of EnableTrace.
///    MatchAllKeyword = This bitmask is optional. This mask further restricts the category of events that the provider writes. This value
///                      is passed in the <i>MatchAllKeywords</i> parameter of the EnableTraceEx function.
///    FilterData = A list of filter data that one or more sessions passed to the provider. A session can specify only one filter but
///                 the list will contain filters from all sessions that used filter data to enable the provider. The filter data is
///                 valid only within the callback, so providers should make a local copy of the data.
///    CallbackContext = Context of the callback defined when the provider called EventRegister to register itself.
alias PENABLECALLBACK = void function(GUID* SourceId, uint IsEnabled, ubyte Level, ulong MatchAnyKeyword, 
                                      ulong MatchAllKeyword, EVENT_FILTER_DESCRIPTOR* FilterData, 
                                      void* CallbackContext);

// Structs


@RAIIFree!TdhCloseDecodingHandle
struct TDH_HANDLE
{
    ptrdiff_t Value;
}

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

///The <b>EVENT_TRACE_HEADER</b> structure contains standard event tracing information common to all events.
struct EVENT_TRACE_HEADER
{
    ///Total number of bytes of the event. <b>Size</b> includes the size of the header structure, plus the size of any
    ///event-specific data appended to the header. On input, the size must be less than the size of the event tracing
    ///session's buffer minus 72 (0x48). On output, do not use this number in calculations.
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
    ///On output, identifies the thread that generated the event. Note that on Windows 2000, <b>ThreadId</b> was a
    ///<b>ULONGLONG</b> value.
    uint          ThreadId;
    ///On output, identifies the process that generated the event. <b>Windows 2000: </b>This member is not supported.
    uint          ProcessId;
    ///On output, contains the time that the event occurred. The resolution is system time unless the
    ///<b>ProcessTraceMode</b> member of EVENT_TRACE_LOGFILE contains the PROCESS_TRACE_MODE_RAW_TIMESTAMP flag, in
    ///which case the resolution depends on the value of the <b>Wnode.ClientContext</b> member of EVENT_TRACE_PROPERTIES
    ///at the time the controller created the session.
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

///The <b>EVENT_INSTANCE_HEADER</b> structure contains standard event tracing information common to all events. The
///structure also contains registration handles for the event trace class and related parent event, which you use to
///trace instances of a transaction or hierarchical relationships between related events.
struct EVENT_INSTANCE_HEADER
{
    ///Total number of bytes of the event. <b>Size</b> must include the size of the <b>EVENT_INSTANCE_HEADER</b>
    ///structure, plus the size of any event-specific data appended to this structure. The size must be less than the
    ///size of the event tracing session's buffer minus 72 (0x48).
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
    ///On output, identifies the thread that generated the event. Note that on Windows 2000, <b>ThreadId</b> was a
    ///<b>ULONGLONG</b> value.
    uint          ThreadId;
    ///On output, identifies the process that generated the event. <b>Windows 2000: </b>This member is not supported.
    uint          ProcessId;
    ///On output, contains the time the event occurred, in 100-nanosecond intervals since midnight, January 1, 1601.
    LARGE_INTEGER TimeStamp;
    ///Handle to a registered event trace class. Set this property before calling the TraceEventInstance function. The
    ///RegisterTraceGuids function creates this handle (see the <i>TraceGuidReg</i> parameter).
    ulong         RegHandle;
    ///On output, contains the event trace instance identifier associated with <b>RegHandle</b>.
    uint          InstanceId;
    ///On output, contains the event trace instance identifier associated with <b>ParentRegHandle</b>.
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
    ///Handle to a registered event trace class of a parent event. Set this property before calling the
    ///TraceEventInstance function if you want to trace a hierarchical relationship (parent element/child element)
    ///between related events. The RegisterTraceGuids function creates this handle (see the <i>TraceGuidReg</i>
    ///parameter).
    ulong         ParentRegHandle;
}

///You may use the <b>MOF_FIELD</b> structures to append event data to the EVENT_TRACE_HEADER or EVENT_INSTANCE_HEADER
///structures.
struct MOF_FIELD
{
    ///Pointer to a event data item.
    ulong DataPtr;
    ///Length of the item pointed to by <b>DataPtr</b>, in bytes.
    uint  Length;
    ///Reserved.
    uint  DataType;
}

///The TRACE_LOGFILE_HEADER structure contains information about an event tracing session and its events.
struct TRACE_LOGFILE_HEADER
{
    ///Size of the event tracing session's buffers, in bytes.
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
    ///Build number of the operating system.
    uint          ProviderVersion;
    ///Number of processors on the system.
    uint          NumberOfProcessors;
    ///Time at which the event tracing session stopped, in 100-nanosecond intervals since midnight, January 1, 1601.
    ///This value may be 0 if you are consuming events in real time or from a log file to which the provide is still
    ///logging events.
    LARGE_INTEGER EndTime;
    ///Resolution of the hardware timer, in units of 100 nanoseconds. For usage, see the Remarks for EVENT_TRACE_HEADER.
    uint          TimerResolution;
    ///Maximum size of the log file, in megabytes.
    uint          MaximumFileSize;
    ///Current logging mode for the event tracing session. For a list of values, see Logging Mode Constants.
    uint          LogFileMode;
    ///Total number of buffers written by the event tracing session.
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
    ///Do not use. The name of the event tracing session is the first null-terminated string following this structure in
    ///memory.
    PWSTR         LoggerName;
    ///Do Not use. The name of the event tracing log file is the second null-terminated string following this structure
    ///in memory. The first string is the name of the session.
    PWSTR         LogFileName;
    ///A TIME_ZONE_INFORMATION structure that contains the time zone for the <b>BootTime</b>, <b>EndTime</b> and
    ///<b>StartTime</b> members.
    TIME_ZONE_INFORMATION TimeZone;
    ///Time at which the system was started, in 100-nanosecond intervals since midnight, January 1, 1601.
    ///<b>BootTime</b> is supported only for traces written to the Global Logger session.
    LARGE_INTEGER BootTime;
    ///Frequency of the high-resolution performance counter, if one exists.
    LARGE_INTEGER PerfFreq;
    ///Time at which the event tracing session started, in 100-nanosecond intervals since midnight, January 1, 1601.
    LARGE_INTEGER StartTime;
    ///Specifies the clock type. For details, see the <b>ClientContext</b> member of WNODE_HEADER.
    uint          ReservedFlags;
    ///Total number of buffers lost during the event tracing session.
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

///The <b>EVENT_INSTANCE_INFO</b> structure maps a unique transaction identifier to a registered event trace class.
struct EVENT_INSTANCE_INFO
{
    ///Handle to a registered event trace class.
    HANDLE RegHandle;
    ///Unique transaction identifier that maps an event to a specific transaction.
    uint   InstanceId;
}

///The <b>EVENT_TRACE_PROPERTIES</b> structure contains information about an event tracing session. You use this
///structure when you define a session, change the properties of a session, or query for the properties of a session.
struct EVENT_TRACE_PROPERTIES
{
    ///A WNODE_HEADER structure. You must specify the <b>BufferSize</b>, <b>Flags</b>, and <b>Guid</b> members, and
    ///optionally the <b>ClientContext</b> member.
    WNODE_HEADER Wnode;
    ///Amount of memory allocated for each event tracing session buffer, in kilobytes. The maximum buffer size is 1 MB.
    ///ETW uses the size of physical memory to calculate this value. For more information, see Remarks. If an
    ///application expects a relatively low event rate, the buffer size should be set to the memory page size. If the
    ///event rate is expected to be relatively high, the application should specify a larger buffer size, and should
    ///increase the maximum number of buffers. The buffer size affects the rate at which buffers fill and must be
    ///flushed. Although a small buffer size requires less memory, it increases the rate at which buffers must be
    ///flushed.
    uint         BufferSize;
    ///Minimum number of buffers allocated for the event tracing session's buffer pool. The minimum number of buffers
    ///that you can specify is two buffers per processor. For example, on a single processor computer, the minimum
    ///number of buffers is two. Note that if you use the EVENT_TRACE_NO_PER_PROCESSOR_BUFFERING logging mode, the
    ///number of processors is assumed to be 1.
    uint         MinimumBuffers;
    ///Maximum number of buffers allocated for the event tracing session's buffer pool. Typically, this value is the
    ///minimum number of buffers plus twenty. ETW uses the buffer size and the size of physical memory to calculate this
    ///value. This value must be greater than or equal to the value for <b>MinimumBuffers</b>. Note that you do not need
    ///to set this value if <b>LogFileMode</b> contains <b>EVENT_TRACE_BUFFERING_MODE</b>; instead, the total memory
    ///buffer size is instead the product of <b>MinimumBuffers</b> and <b>BufferSize</b>.
    uint         MaximumBuffers;
    ///Maximum size of the file used to log events, in megabytes. Typically, you use this member to limit the size of a
    ///circular log file when you set <b>LogFileMode</b> to <b>EVENT_TRACE_FILE_MODE_CIRCULAR</b>. This member must be
    ///specified if <b>LogFileMode</b> contains <b>EVENT_TRACE_FILE_MODE_PREALLOCATE</b>,
    ///<b>EVENT_TRACE_FILE_MODE_CIRCULAR</b> or <b>EVENT_TRACE_FILE_MODE_NEWFILE</b> If you are using the system drive
    ///(the drive that contains the operating system) for logging, ETW checks for an additional 200MB of disk space,
    ///regardless of whether you are using the maximum file size parameter. Therefore, if you specify 100MB as the
    ///maximum file size for the trace file in the system drive, you need to have 300MB of free space on the drive.
    uint         MaximumFileSize;
    ///Logging modes for the event tracing session. You use this member to specify that you want events written to a log
    ///file, a real-time consumer, or both. You can also use this member to specify that the session is a private logger
    ///session. You can specify one or more modes. For a list of possible modes, see Logging Mode Constants. Do not
    ///specify real-time logging unless there are real-time consumers ready to consume the events. If there are no
    ///real-time consumers, ETW writes the events to a playback file. However, the size of the playback file is limited.
    ///If the limit is reached, no new events are logged (to the log file or playback file) and the logging functions
    ///fail with STATUS_LOG_FILE_FULL.<b>Prior to Windows Vista: </b>If there was no real-time consumer, the events were
    ///discarded and logging continues.</p>If a consumer begins processing real-time events, the events in the playback
    ///file are consumed first. After all events in the playback file are consumed, the session will begin logging new
    ///events.
    uint         LogFileMode;
    ///How often, in seconds, the trace buffers are forcibly flushed. The minimum flush time is 1 second. This forced
    ///flush is in addition to the automatic flush that occurs whenever a buffer is full and when the trace session
    ///stops. If zero, ETW flushes buffers as soon as they become full. If nonzero, ETW flushes all buffers that contain
    ///events based on the timer value. Typically, you want to flush buffers only when they become full. Forcing the
    ///buffers to flush (either by setting this member to a nonzero value or by calling FlushTrace) can increase the
    ///file size of the log file with unfilled buffer space. If the consumer is consuming events in real time, you may
    ///want to set this member to a nonzero value if the event rate is low to force events to be delivered before the
    ///buffer is full. For the case of a realtime logger, a value of zero (the default value) means that the flush time
    ///will be set to 1 second. A realtime logger is when <b>LogFileMode</b> is set to
    ///<b>EVENT_TRACE_REAL_TIME_MODE</b>.
    uint         FlushTimer;
    ///A system logger must set <b>EnableFlags</b> to indicate which SystemTraceProvider events should be included in
    ///the trace. This is also used for NT Kernel Logger sessions. This member can contain one or more of the following
    ///values. In addition to the events you specify, the kernel logger also logs hardware configuration events on
    ///Windows XP or system configuration events on Windows Server 2003. <table> <tr> <th>Flag</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_ALPC"></a><a id="event_trace_flag_alpc"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_ALPC</b></b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Enables the ALPC
    ///event types. This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_CSWITCH"></a><a id="event_trace_flag_cswitch"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_CSWITCH</b></b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Enables the
    ///following Thread event type:<ul> <li> CSwitch </li> </ul> This value is supported on Windows Vista and later.
    ///</td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DBGPRINT"></a><a id="event_trace_flag_dbgprint"></a><dl>
    ///<dt><b>EVENT_TRACE_FLAG_DBGPRINT</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Enables the
    ///<b>DbgPrint</b> and <b>DbgPrintEx</b> calls to be converted to ETW events. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_DISK_FILE_IO"></a><a id="event_trace_flag_disk_file_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DISK_FILE_IO</b></b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Enables the
    ///following FileIo event type (you must also enable EVENT_TRACE_FLAG_DISK_IO): <ul> <li> FileIo_Name </li> </ul>
    ///</td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DISK_IO"></a><a id="event_trace_flag_disk_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DISK_IO</b></b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Enables the
    ///following DiskIo event types: <ul> <li> DiskIo_TypeGroup1 </li> <li> DiskIo_TypeGroup3 </li> </ul> </td> </tr>
    ///<tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DISK_IO_INIT"></a><a id="event_trace_flag_disk_io_init"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DISK_IO_INIT</b></b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> Enables the
    ///following DiskIo event type:<ul> <li> DiskIo_TypeGroup2 </li> </ul> This value is supported on Windows Vista and
    ///later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DISPATCHER"></a><a
    ///id="event_trace_flag_dispatcher"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_DISPATCHER</b></b></dt> <dt>0x00000800</dt>
    ///</dl> </td> <td width="60%"> Enables the following Thread event type:<ul> <li> ReadyThread </li> </ul> This value
    ///is supported on Windows 7, Windows Server 2008 R2, and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_DPC"></a><a id="event_trace_flag_dpc"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_DPC</b></b></dt>
    ///<dt>0x00000020</dt> </dl> </td> <td width="60%"> Enables the following PerfInfo event type:<ul> <li> DPC </li>
    ///</ul> This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_DRIVER"></a><a id="event_trace_flag_driver"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DRIVER</b></b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%"> Enables the
    ///following DiskIo event types:<ul> <li> DriverCompleteRequest </li> <li> DriverCompleteRequestReturn </li> <li>
    ///DriverCompletionRoutine </li> <li> DriverMajorFunctionCall </li> <li> DriverMajorFunctionReturn </li> </ul> This
    ///value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_FILE_IO"></a><a id="event_trace_flag_file_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_FILE_IO</b></b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> Enables the
    ///following FileIo event types:<ul> <li> FileIo_OpEnd </li> </ul> This value is supported on Windows Vista and
    ///later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_FILE_IO_INIT"></a><a
    ///id="event_trace_flag_file_io_init"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_FILE_IO_INIT</b></b></dt>
    ///<dt>0x04000000</dt> </dl> </td> <td width="60%"> Enables the following FileIo event type:<ul> <li> FileIo_Create
    ///</li> <li> FileIo_DirEnum </li> <li> FileIo_Info </li> <li> FileIo_ReadWrite </li> <li> FileIo_SimpleOp </li>
    ///</ul> This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_IMAGE_LOAD"></a><a id="event_trace_flag_image_load"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_IMAGE_LOAD</b></b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Enables the
    ///following Image event type: <ul> <li> Image_Load </li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_INTERRUPT"></a><a id="event_trace_flag_interrupt"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_INTERRUPT</b></b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Enables the
    ///following PerfInfo event type:<ul> <li> ISR </li> </ul> This value is supported on Windows Vista and later. </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_JOB"></a><a id="event_trace_flag_job"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_JOB</b></b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> This value is
    ///supported on Windows 10 </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_MEMORY_HARD_FAULTS"></a><a
    ///id="event_trace_flag_memory_hard_faults"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_MEMORY_HARD_FAULTS</b></b></dt>
    ///<dt>0x00002000</dt> </dl> </td> <td width="60%"> Enables the following PageFault_V2 event type: <ul> <li>
    ///PageFault_HardFault </li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_MEMORY_PAGE_FAULTS"></a><a id="event_trace_flag_memory_page_faults"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_MEMORY_PAGE_FAULTS</b></b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%">
    ///Enables the following PageFault_V2 event type: <ul> <li> PageFault_TypeGroup1 </li> </ul> </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_TRACE_FLAG_NETWORK_TCPIP"></a><a id="event_trace_flag_network_tcpip"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_NETWORK_TCPIP</b></b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> Enables
    ///the TcpIp and UdpIp event types. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_NO_SYSCONFIG"></a><a
    ///id="event_trace_flag_no_sysconfig"></a><dl> <dt><b>EVENT_TRACE_FLAG_NO_SYSCONFIG</b></dt> <dt>0x10000000</dt>
    ///</dl> </td> <td width="60%"> Do not do a system configuration rundown. This value is supported on Windows 8,
    ///Windows Server 2012, and later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_PROCESS"></a><a
    ///id="event_trace_flag_process"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_PROCESS</b></b></dt> <dt>0x00000001</dt> </dl>
    ///</td> <td width="60%"> Enables the following Process event type: <ul> <li> Process_TypeGroup1 </li> </ul> </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_PROCESS_COUNTERS"></a><a
    ///id="event_trace_flag_process_counters"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_PROCESS_COUNTERS</b></b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> Enables the following Process_V2 event type:<ul> <li>
    ///Process_V2_TypeGroup2 </li> </ul> This value is supported on Windows Vista and later. </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_TRACE_FLAG_PROFILE"></a><a id="event_trace_flag_profile"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_PROFILE</b></b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> Enables the
    ///following PerfInfo event type:<ul> <li> SampledProfile </li> </ul> This value is supported on Windows Vista and
    ///later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_REGISTRY"></a><a
    ///id="event_trace_flag_registry"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_REGISTRY</b></b></dt> <dt>0x00020000</dt>
    ///</dl> </td> <td width="60%"> Enables the Registry event types. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_SPLIT_IO"></a><a id="event_trace_flag_split_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_SPLIT_IO</b></b></dt> <dt>0x00200000</dt> </dl> </td> <td width="60%"> Enables the
    ///SplitIo event types. This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_SYSTEMCALL"></a><a id="event_trace_flag_systemcall"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_SYSTEMCALL</b></b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Enables the
    ///following PerfInfo event type:<ul> <li> SysCallEnter </li> <li> SysCallExit </li> </ul> This value is supported
    ///on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_THREAD"></a><a
    ///id="event_trace_flag_thread"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_THREAD</b></b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> Enables the following Thread event type: <ul> <li> Thread_TypeGroup1 </li> </ul> </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_VAMAP"></a><a id="event_trace_flag_vamap"></a><dl>
    ///<dt><b>EVENT_TRACE_FLAG_VAMAP</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> Enables the map and unmap
    ///(excluding image files) event type. This value is supported on Windows 8, Windows Server 2012, and later. </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_VIRTUAL_ALLOC"></a><a
    ///id="event_trace_flag_virtual_alloc"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_VIRTUAL_ALLOC</b></b></dt>
    ///<dt>0x00004000</dt> </dl> </td> <td width="60%"> Enables the following PageFault_V2 event type:<ul> <li>
    ///PageFault_VirtualAlloc </li> </ul> This value is supported on Windows 7, Windows Server 2008 R2, and later. </td>
    ///</tr> </table>
    uint         EnableFlags;
union
    {
        int AgeLimit;
        int FlushThreshold;
    }
    ///On output, the number of buffers allocated for the event tracing session's buffer pool.
    uint         NumberOfBuffers;
    ///On output, the number of buffers that are allocated but unused in the event tracing session's buffer pool.
    uint         FreeBuffers;
    ///On output, the number of events that were not recorded.
    uint         EventsLost;
    ///On output, the number of buffers written.
    uint         BuffersWritten;
    ///On output, the number of buffers that could not be written to the log file.
    uint         LogBuffersLost;
    ///On output, the number of buffers that could not be delivered in real-time to the consumer.
    uint         RealTimeBuffersLost;
    ///On output, the thread identifier for the event tracing session.
    HANDLE       LoggerThreadId;
    ///Offset from the start of the structure's allocated memory to beginning of the null-terminated string that
    ///contains the log file name. The file name should use the .etl extension. All folders in the path must exist. The
    ///path can be relative, absolute, local, or remote. The path cannot contain environment variables (they are not
    ///expanded). The user must have permission to write to the folder. The log file name is limited to 1,024
    ///characters. If you set <b>LogFileMode</b> to <b>EVENT_TRACE_PRIVATE_LOGGER_MODE</b> or
    ///<b>EVENT_TRACE_FILE_MODE_NEWFILE</b>, be sure to allocate enough memory to include the process identifier that is
    ///appended to the file name for private loggers sessions, and the sequential number that is added to log files
    ///created using the new file log mode. If you do not want to log events to a log file (for example, you specify
    ///<b>EVENT_TRACE_REAL_TIME_MODE</b> only), set <i>LogFileNameOffset</i> to 0. If you specify only real-time logging
    ///and also provide an offset with a valid log file name, ETW will use the log file name to create a sequential log
    ///file and log events to the log file. ETW also creates the sequential log file if <b>LogFileMode</b> is 0 and you
    ///provide an offset with a valid log file name. If you want to log events to a log file, you must allocate enough
    ///memory for this structure to include the log file name and session name following the structure. The log file
    ///name must follow the session name in memory. Trace files are created using the default security descriptor,
    ///meaning that the log file will have the same ACL as the parent directory. If you want access to the files
    ///restricted, create a parent directory with the appropriate ACLs.
    uint         LogFileNameOffset;
    ///Offset from the start of the structure's allocated memory to beginning of the null-terminated string that
    ///contains the session name. The session name is limited to 1,024 characters. The session name is case-insensitive
    ///and must be unique. <b>Windows 2000: </b>Session names are case-sensitive. As a result, duplicate session names
    ///are allowed. However, to reduce confusion, you should make sure your session names are unique. When you allocate
    ///the memory for this structure, you must allocate enough memory to include the session name and log file name
    ///following the structure. The session name must come before the log file name in memory. You must copy the log
    ///file name to the offset but you do not copy the session name to the offset—the StartTrace function copies the
    ///name for you.
    uint         LoggerNameOffset;
}

///The <b>EVENT_TRACE_PROPERTIES_V2</b> structure contains information about an event tracing session. You use this
///structure when you define a session, change the properties of a session, or query for the properties of a session.
///This is extended from the EVENT_TRACE_PROPERTIES structure.
struct EVENT_TRACE_PROPERTIES_V2
{
    ///A WNODE_HEADER structure. You must specify the <b>BufferSize</b>, <b>Flags</b>, and <b>Guid</b> members, and
    ///optionally the <b>ClientContext</b> member.
    WNODE_HEADER Wnode;
    ///Amount of memory allocated for each event tracing session buffer, in kilobytes. The maximum buffer size is 1 MB.
    ///ETW uses the size of physical memory to calculate this value. For more information, see Remarks. If an
    ///application expects a relatively low event rate, the buffer size should be set to the memory page size. If the
    ///event rate is expected to be relatively high, the application should specify a larger buffer size, and should
    ///increase the maximum number of buffers. The buffer size affects the rate at which buffers fill and must be
    ///flushed. Although a small buffer size requires less memory, it increases the rate at which buffers must be
    ///flushed.
    uint         BufferSize;
    ///Minimum number of buffers allocated for the event tracing session's buffer pool. The minimum number of buffers
    ///that you can specify is two buffers per processor. For example, on a single processor computer, the minimum
    ///number of buffers is two. Note that if you use the EVENT_TRACE_NO_PER_PROCESSOR_BUFFERING logging mode, the
    ///number of processors is assumed to be 1.
    uint         MinimumBuffers;
    ///Maximum number of buffers allocated for the event tracing session's buffer pool. Typically, this value is the
    ///minimum number of buffers plus twenty. ETW uses the buffer size and the size of physical memory to calculate this
    ///value. This value must be greater than or equal to the value for <b>MinimumBuffers</b>. Note that you do not need
    ///to set this value if <b>LogFileMode</b> contains <b>EVENT_TRACE_BUFFERING_MODE</b>; instead, the total memory
    ///buffer size is instead the product of <b>MinimumBuffers</b> and <b>BufferSize</b>.
    uint         MaximumBuffers;
    ///Maximum size of the file used to log events, in megabytes. Typically, you use this member to limit the size of a
    ///circular log file when you set <b>LogFileMode</b> to <b>EVENT_TRACE_FILE_MODE_CIRCULAR</b>. This member must be
    ///specified if <b>LogFileMode</b> contains <b>EVENT_TRACE_FILE_MODE_PREALLOCATE</b>,
    ///<b>EVENT_TRACE_FILE_MODE_CIRCULAR</b> or <b>EVENT_TRACE_FILE_MODE_NEWFILE</b> If you are using the system drive
    ///(the drive that contains the operating system) for logging, ETW checks for an additional 200MB of disk space,
    ///regardless of whether you are using the maximum file size parameter. Therefore, if you specify 100MB as the
    ///maximum file size for the trace file in the system drive, you need to have 300MB of free space on the drive.
    uint         MaximumFileSize;
    ///Logging modes for the event tracing session. You use this member to specify that you want events written to a log
    ///file, a real-time consumer, or both. You can also use this member to specify that the session is a private logger
    ///session. You can specify one or more modes. For a list of possible modes, see Logging Mode Constants. Do not
    ///specify real-time logging unless there are real-time consumers ready to consume the events. If there are no
    ///real-time consumers, ETW writes the events to a playback file. However, the size of the playback file is limited.
    ///If the limit is reached, no new events are logged (to the log file or playback file) and the logging functions
    ///fail with STATUS_LOG_FILE_FULL.<b>Prior to Windows Vista: </b>If there was no real-time consumer, the events were
    ///discarded and logging continues.</p>If a consumer begins processing real-time events, the events in the playback
    ///file are consumed first. After all events in the playback file are consumed, the session will begin logging new
    ///events.
    uint         LogFileMode;
    ///How often, in seconds, the trace buffers are forcibly flushed. The minimum flush time is 1 second. This forced
    ///flush is in addition to the automatic flush that occurs whenever a buffer is full and when the trace session
    ///stops. If zero, ETW flushes buffers as soon as they become full. If nonzero, ETW flushes all buffers that contain
    ///events based on the timer value. Typically, you want to flush buffers only when they become full. Forcing the
    ///buffers to flush (either by setting this member to a nonzero value or by calling FlushTrace) can increase the
    ///file size of the log file with unfilled buffer space. If the consumer is consuming events in real time, you may
    ///want to set this member to a nonzero value if the event rate is low to force events to be delivered before the
    ///buffer is full. For the case of a realtime logger, a value of zero (the default value) means that the flush time
    ///will be set to 1 second. A realtime logger is when <b>LogFileMode</b> is set to
    ///<b>EVENT_TRACE_REAL_TIME_MODE</b>.
    uint         FlushTimer;
    ///A system logger must set <b>EnableFlags</b> to indicate which SystemTraceProvider events should be included in
    ///the trace. This is also used for NT Kernel Logger sessions. This member can contain one or more of the following
    ///values. In addition to the events you specify, the kernel logger also logs hardware configuration events on
    ///Windows XP or system configuration events on Windows Server 2003. <table> <tr> <th>Flag</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_ALPC"></a><a id="event_trace_flag_alpc"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_ALPC</b></b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Enables the ALPC
    ///event types. This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_CSWITCH"></a><a id="event_trace_flag_cswitch"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_CSWITCH</b></b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Enables the
    ///following Thread event type:<ul> <li> CSwitch </li> </ul> This value is supported on Windows Vista and later.
    ///</td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DBGPRINT"></a><a id="event_trace_flag_dbgprint"></a><dl>
    ///<dt><b>EVENT_TRACE_FLAG_DBGPRINT</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Enables the
    ///<b>DbgPrint</b> and <b>DbgPrintEx</b> calls to be converted to ETW events. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_DISK_FILE_IO"></a><a id="event_trace_flag_disk_file_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DISK_FILE_IO</b></b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Enables the
    ///following FileIo event type (you must also enable EVENT_TRACE_FLAG_DISK_IO): <ul> <li> FileIo_Name </li> </ul>
    ///</td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DISK_IO"></a><a id="event_trace_flag_disk_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DISK_IO</b></b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Enables the
    ///following DiskIo event types: <ul> <li> DiskIo_TypeGroup1 </li> <li> DiskIo_TypeGroup3 </li> </ul> </td> </tr>
    ///<tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DISK_IO_INIT"></a><a id="event_trace_flag_disk_io_init"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DISK_IO_INIT</b></b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> Enables the
    ///following DiskIo event type:<ul> <li> DiskIo_TypeGroup2 </li> </ul> This value is supported on Windows Vista and
    ///later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_DISPATCHER"></a><a
    ///id="event_trace_flag_dispatcher"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_DISPATCHER</b></b></dt> <dt>0x00000800</dt>
    ///</dl> </td> <td width="60%"> Enables the following Thread event type:<ul> <li> ReadyThread </li> </ul> This value
    ///is supported on Windows 7, Windows Server 2008 R2, and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_DPC"></a><a id="event_trace_flag_dpc"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_DPC</b></b></dt>
    ///<dt>0x00000020</dt> </dl> </td> <td width="60%"> Enables the following PerfInfo event type:<ul> <li> DPC </li>
    ///</ul> This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_DRIVER"></a><a id="event_trace_flag_driver"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_DRIVER</b></b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%"> Enables the
    ///following DiskIo event types:<ul> <li> DriverCompleteRequest </li> <li> DriverCompleteRequestReturn </li> <li>
    ///DriverCompletionRoutine </li> <li> DriverMajorFunctionCall </li> <li> DriverMajorFunctionReturn </li> </ul> This
    ///value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_FILE_IO"></a><a id="event_trace_flag_file_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_FILE_IO</b></b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> Enables the
    ///following FileIo event types:<ul> <li> FileIo_OpEnd </li> </ul> This value is supported on Windows Vista and
    ///later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_FILE_IO_INIT"></a><a
    ///id="event_trace_flag_file_io_init"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_FILE_IO_INIT</b></b></dt>
    ///<dt>0x04000000</dt> </dl> </td> <td width="60%"> Enables the following FileIo event type:<ul> <li> FileIo_Create
    ///</li> <li> FileIo_DirEnum </li> <li> FileIo_Info </li> <li> FileIo_ReadWrite </li> <li> FileIo_SimpleOp </li>
    ///</ul> This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_IMAGE_LOAD"></a><a id="event_trace_flag_image_load"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_IMAGE_LOAD</b></b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Enables the
    ///following Image event type: <ul> <li> Image_Load </li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_INTERRUPT"></a><a id="event_trace_flag_interrupt"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_INTERRUPT</b></b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Enables the
    ///following PerfInfo event type:<ul> <li> ISR </li> </ul> This value is supported on Windows Vista and later. </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_JOB"></a><a id="event_trace_flag_job"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_JOB</b></b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> This value is
    ///supported on Windows 10 </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_MEMORY_HARD_FAULTS"></a><a
    ///id="event_trace_flag_memory_hard_faults"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_MEMORY_HARD_FAULTS</b></b></dt>
    ///<dt>0x00002000</dt> </dl> </td> <td width="60%"> Enables the following PageFault_V2 event type: <ul> <li>
    ///PageFault_HardFault </li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_MEMORY_PAGE_FAULTS"></a><a id="event_trace_flag_memory_page_faults"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_MEMORY_PAGE_FAULTS</b></b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%">
    ///Enables the following PageFault_V2 event type: <ul> <li> PageFault_TypeGroup1 </li> </ul> </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_TRACE_FLAG_NETWORK_TCPIP"></a><a id="event_trace_flag_network_tcpip"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_NETWORK_TCPIP</b></b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> Enables
    ///the TcpIp and UdpIp event types. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_NO_SYSCONFIG"></a><a
    ///id="event_trace_flag_no_sysconfig"></a><dl> <dt><b>EVENT_TRACE_FLAG_NO_SYSCONFIG</b></dt> <dt>0x10000000</dt>
    ///</dl> </td> <td width="60%"> Do not do a system configuration rundown. This value is supported on Windows 8,
    ///Windows Server 2012, and later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_PROCESS"></a><a
    ///id="event_trace_flag_process"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_PROCESS</b></b></dt> <dt>0x00000001</dt> </dl>
    ///</td> <td width="60%"> Enables the following Process event type: <ul> <li> Process_TypeGroup1 </li> </ul> </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_PROCESS_COUNTERS"></a><a
    ///id="event_trace_flag_process_counters"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_PROCESS_COUNTERS</b></b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> Enables the following Process_V2 event type:<ul> <li>
    ///Process_V2_TypeGroup2 </li> </ul> This value is supported on Windows Vista and later. </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_TRACE_FLAG_PROFILE"></a><a id="event_trace_flag_profile"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_PROFILE</b></b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> Enables the
    ///following PerfInfo event type:<ul> <li> SampledProfile </li> </ul> This value is supported on Windows Vista and
    ///later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_REGISTRY"></a><a
    ///id="event_trace_flag_registry"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_REGISTRY</b></b></dt> <dt>0x00020000</dt>
    ///</dl> </td> <td width="60%"> Enables the Registry event types. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_SPLIT_IO"></a><a id="event_trace_flag_split_io"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_SPLIT_IO</b></b></dt> <dt>0x00200000</dt> </dl> </td> <td width="60%"> Enables the
    ///SplitIo event types. This value is supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_TRACE_FLAG_SYSTEMCALL"></a><a id="event_trace_flag_systemcall"></a><dl>
    ///<dt><b><b>EVENT_TRACE_FLAG_SYSTEMCALL</b></b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Enables the
    ///following PerfInfo event type:<ul> <li> SysCallEnter </li> <li> SysCallExit </li> </ul> This value is supported
    ///on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_THREAD"></a><a
    ///id="event_trace_flag_thread"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_THREAD</b></b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> Enables the following Thread event type: <ul> <li> Thread_TypeGroup1 </li> </ul> </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_VAMAP"></a><a id="event_trace_flag_vamap"></a><dl>
    ///<dt><b>EVENT_TRACE_FLAG_VAMAP</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> Enables the map and unmap
    ///(excluding image files) event type. This value is supported on Windows 8, Windows Server 2012, and later. </td>
    ///</tr> <tr> <td width="40%"><a id="EVENT_TRACE_FLAG_VIRTUAL_ALLOC"></a><a
    ///id="event_trace_flag_virtual_alloc"></a><dl> <dt><b><b>EVENT_TRACE_FLAG_VIRTUAL_ALLOC</b></b></dt>
    ///<dt>0x00004000</dt> </dl> </td> <td width="60%"> Enables the following PageFault_V2 event type:<ul> <li>
    ///PageFault_VirtualAlloc </li> </ul> This value is supported on Windows 7, Windows Server 2008 R2, and later. </td>
    ///</tr> </table>
    uint         EnableFlags;
union
    {
        int AgeLimit;
        int FlushThreshold;
    }
    ///On output, the number of buffers allocated for the event tracing session's buffer pool.
    uint         NumberOfBuffers;
    ///On output, the number of buffers that are allocated but unused in the event tracing session's buffer pool.
    uint         FreeBuffers;
    ///On output, the number of events that were not recorded.
    uint         EventsLost;
    ///On output, the number of buffers written.
    uint         BuffersWritten;
    ///On output, the number of buffers that could not be written to the log file.
    uint         LogBuffersLost;
    ///On output, the number of buffers that could not be delivered in real-time to the consumer.
    uint         RealTimeBuffersLost;
    ///On output, the thread identifier for the event tracing session.
    HANDLE       LoggerThreadId;
    ///Offset from the start of the structure's allocated memory to beginning of the null-terminated string that
    ///contains the log file name. The file name should use the .etl extension. All folders in the path must exist. The
    ///path can be relative, absolute, local, or remote. The path cannot contain environment variables (they are not
    ///expanded). The user must have permission to write to the folder. The log file name is limited to 1,024
    ///characters. If you set <b>LogFileMode</b> to <b>EVENT_TRACE_PRIVATE_LOGGER_MODE</b> or
    ///<b>EVENT_TRACE_FILE_MODE_NEWFILE</b>, be sure to allocate enough memory to include the process identifier that is
    ///appended to the file name for private loggers sessions, and the sequential number that is added to log files
    ///created using the new file log mode. If you do not want to log events to a log file (for example, you specify
    ///<b>EVENT_TRACE_REAL_TIME_MODE</b> only), set <i>LogFileNameOffset</i> to 0. If you specify only real-time logging
    ///and also provide an offset with a valid log file name, ETW will use the log file name to create a sequential log
    ///file and log events to the log file. ETW also creates the sequential log file if <b>LogFileMode</b> is 0 and you
    ///provide an offset with a valid log file name. If you want to log events to a log file, you must allocate enough
    ///memory for this structure to include the log file name and session name following the structure. The log file
    ///name must follow the session name in memory. Trace files are created using the default security descriptor,
    ///meaning that the log file will have the same ACL as the parent directory. If you want access to the files
    ///restricted, create a parent directory with the appropriate ACLs.
    uint         LogFileNameOffset;
    ///Offset from the start of the structure's allocated memory to beginning of the null-terminated string that
    ///contains the session name. The session name is limited to 1,024 characters. The session name is case-insensitive
    ///and must be unique. <b>Windows 2000: </b>Session names are case-sensitive. As a result, duplicate session names
    ///are allowed. However, to reduce confusion, you should make sure your session names are unique. When you allocate
    ///the memory for this structure, you must allocate enough memory to include the session name and log file name
    ///following the structure. The session name must come before the log file name in memory. You must copy the log
    ///file name to the offset but you do not copy the session name to the offset—the StartTrace function copies the
    ///name for you.
    uint         LoggerNameOffset;
union
    {
struct
        {
            uint _bitfield36;
        }
        uint V2Control;
    }
    ///The number of filters that the <b>FilterDesc</b> points to. The only time this should not be zero is for system
    ///wide Private Loggers.
    uint         FilterDescCount;
    ///Supported EVENT_FILTER_DESCRIPTOR filter types for system wide private loggers:
    ///<b>EVENT_FILTER_TYPE_EXECUTABLE_NAME</b> and <b>EVENT_FILTER_TYPE_PID</b> A pointer to an array of
    ///EVENT_FILTER_DESCRIPTOR structures that points to the filter data. The number of elements in the array is
    ///specified in the <b>FilterDescCount</b> member. There can only be one filter for a specific filter type as
    ///specified by the <b>Type</b> member of the <b>EVENT_FILTER_DESCRIPTOR</b> structure. This is only applicable to
    ///Private Loggers. The only time this should not be null is when it is used for system wide Private Loggers.
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

///The <b>TRACE_GUID_REGISTRATION</b> structure is used to register event trace classes.
struct TRACE_GUID_REGISTRATION
{
    ///Class GUID of an event trace class that you are registering.
    GUID*  Guid;
    ///Handle to the registered event trace class. The RegisterTraceGuids function generates this value. Use this handle
    ///when you call the CreateTraceInstanceId function and to set the <b>RegHandle</b> member of EVENT_INSTANCE_HEADER
    ///when calling the TraceEventInstance function.
    HANDLE RegHandle;
}

///The <b>TRACE_GUID_PROPERTIES</b> structure contains information about an event trace provider.
struct TRACE_GUID_PROPERTIES
{
    ///Control GUID of the event trace provider.
    GUID  Guid;
    ///Not used.
    uint  GuidType;
    ///Session handle that identifies the event tracing session.
    uint  LoggerId;
    ///Value passed as the <i>EnableLevel</i> parameter to the EnableTrace function.
    uint  EnableLevel;
    ///Value passed as the <i>EnableFlag</i> parameter to the EnableTrace function.
    uint  EnableFlags;
    ///If this member is <b>TRUE</b>, the element identified by the <b>Guid</b> member is currently enabled for the
    ///session identified by the <b>LoggerId</b> member. If this member is <b>FALSE</b>, all other members have no
    ///meaning and should be zero.
    ubyte IsEnable;
}

///The <b>ETW_BUFFER_CONTEXT</b> structure provides context information about the event.
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
    ///Identifier of the session that logged the event.
    ushort LoggerId;
}

///Defines the session and the information that the session used to enable the provider.
struct TRACE_ENABLE_INFO
{
    ///Indicates if the provider is enabled to the session. The value is <b>TRUE</b> if the provider is enabled to the
    ///session, otherwise, the value is <b>FALSE</b>. This value should always be <b>TRUE</b>.
    uint   IsEnabled;
    ///Level of detail that the session asked the provider to include in the events. For details, see the <i>Level</i>
    ///parameter of the EnableTraceEx function.
    ubyte  Level;
    ///Reserved.
    ubyte  Reserved1;
    ///Identifies the session that enabled the provider.
    ushort LoggerId;
    ///Additional information that the session wants ETW to include in the log file. For details, see the
    ///<i>EnableProperty</i> parameter of the EnableTraceEx function.
    uint   EnableProperty;
    ///Reserved.
    uint   Reserved2;
    ///Keywords specify which events the session wants the provider to write. For details, see the
    ///<i>MatchAnyKeyword</i> parameter of the EnableTraceEx function.
    ulong  MatchAnyKeyword;
    ///Keywords specify which events the session wants the provider to write. For details, see the
    ///<i>MatchAllKeyword</i> parameter of the EnableTraceEx function.
    ulong  MatchAllKeyword;
}

///Defines an instance of the provider GUID.
struct TRACE_PROVIDER_INSTANCE_INFO
{
    ///Offset, in bytes, from the beginning of this structure to the next <b>TRACE_PROVIDER_INSTANCE_INFO</b> structure.
    ///The value is zero if there is not another instance info block.
    uint NextOffset;
    ///Number of TRACE_ENABLE_INFO structures in this block. Each structure represents a session that enabled the
    ///provider.
    uint EnableCount;
    ///Process identifier of the process that registered the provider.
    uint Pid;
    ///Can be one of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="TRACE_PROVIDER_FLAG_LEGACY"></a><a id="trace_provider_flag_legacy"></a><dl>
    ///<dt><b>TRACE_PROVIDER_FLAG_LEGACY</b></dt> </dl> </td> <td width="60%"> The provider used RegisterTraceGuids
    ///instead of EventRegister to register itself. </td> </tr> <tr> <td width="40%"><a
    ///id="TRACE_PROVIDER_FLAG_PRE_ENABLE"></a><a id="trace_provider_flag_pre_enable"></a><dl>
    ///<dt><b>TRACE_PROVIDER_FLAG_PRE_ENABLE</b></dt> </dl> </td> <td width="60%"> The provider is not registered;
    ///however, one or more sessions have enabled the provider. </td> </tr> </table>
    uint Flags;
}

///Defines the header to the list of sessions that enabled the provider specified in the <i>InBuffer</i> parameter of
///EnumerateTraceGuidsEx.
struct TRACE_GUID_INFO
{
    ///The number of TRACE_PROVIDER_INSTANCE_INFO blocks contained in the list. You can have multiple instances of the
    ///same provider if the provider lives in a DLL that is loaded by multiple processes.
    uint InstanceCount;
    ///Reserved.
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

///The <b>EVENT_TRACE</b> structure is used to deliver event information to an event trace consumer.
struct EVENT_TRACE
{
    ///An EVENT_TRACE_HEADER structure that contains standard event tracing information.
    EVENT_TRACE_HEADER Header;
    ///Instance identifier. Contains valid data when the provider calls the TraceEventInstance function to generate the
    ///event. Otherwise, the value is zero.
    uint               InstanceId;
    ///Instance identifier for a parent event. Contains valid data when the provider calls the TraceEventInstance
    ///function to generate the event. Otherwise, the value is zero.
    uint               ParentInstanceId;
    ///Class GUID of the parent event. Contains valid data when the provider calls the TraceEventInstance function to
    ///generate the event. Otherwise, the value is zero.
    GUID               ParentGuid;
    ///Pointer to the beginning of the event-specific data for this event.
    void*              MofData;
    ///Number of bytes to which <b>MofData</b> points.
    uint               MofLength;
union
    {
        uint               ClientContext;
        ETW_BUFFER_CONTEXT BufferContext;
    }
}

///The <b>EVENT_TRACE_LOGFILE</b> structure specifies how the consumer wants to read events (from a log file or in
///real-time) and the callbacks that will receive the events. When ETW flushes a buffer, this structure contains
///information about the event tracing session and the buffer that ETW flushed.
struct EVENT_TRACE_LOGFILEW
{
    ///Name of the log file used by the event tracing session. Specify a value for this member if you are consuming from
    ///a log file. This member must be <b>NULL</b> if <b>LoggerName</b> is specified. You must know the log file name
    ///the controller specified. If the controller logged events to a private session (the controller set the
    ///<b>LogFileMode</b> member of EVENT_TRACE_PROPERTIES to <b>EVENT_TRACE_PRIVATE_LOGGER_MODE</b>), the file name
    ///must include the process identifier that ETW appended to the log file name. For example, if the controller named
    ///the log file xyz.etl and the process identifier is 123, ETW uses xyz.etl_123 as the file name. If the controller
    ///set the <b>LogFileMode</b> member of EVENT_TRACE_PROPERTIES to <b>EVENT_TRACE_FILE_MODE_NEWFILE</b>, the log file
    ///name must include the sequential serial number used to create each new log file. The user consuming the events
    ///must have permissions to read the file.
    PWSTR                LogFileName;
    ///Name of the event tracing session. Specify a value for this member if you want to consume events in real time.
    ///This member must be <b>NULL</b> if <b>LogFileName</b> is specified. You can only consume events in real time if
    ///the controller set the <b>LogFileMode</b> member of EVENT_TRACE_PROPERTIES to <b>EVENT_TRACE_REAL_TIME_MODE</b>.
    ///Only users with administrative privileges, users in the Performance Log Users group, and applications running as
    ///LocalSystem, LocalService, NetworkService can consume events in real time. To grant a restricted user the ability
    ///to consume events in real time, add them to the Performance Log Users group or call EventAccessControl.
    ///<b>Windows XP and Windows 2000: </b>Anyone can consume real time events.
    PWSTR                LoggerName;
    ///On output, the current time, in 100-nanosecond intervals since midnight, January 1, 1601.
    long                 CurrentTime;
    ///On output, the number of buffers processed.
    uint                 BuffersRead;
union
    {
        uint LogFileMode;
        uint ProcessTraceMode;
    }
    ///On output, an EVENT_TRACE structure that contains the last event processed.
    EVENT_TRACE          CurrentEvent;
    ///On output, a TRACE_LOGFILE_HEADER structure that contains general information about the session and the computer
    ///on which the session ran.
    TRACE_LOGFILE_HEADER LogfileHeader;
    ///Pointer to the BufferCallback function that receives buffer-related statistics for each buffer ETW flushes. ETW
    ///calls this callback after it delivers all the events in the buffer. This callback is optional.
    PEVENT_TRACE_BUFFER_CALLBACKW BufferCallback;
    ///On output, contains the size of each buffer, in bytes.
    uint                 BufferSize;
    ///On output, contains the number of bytes in the buffer that contain valid information.
    uint                 Filled;
    ///Not used.
    uint                 EventsLost;
union
    {
        PEVENT_CALLBACK EventCallback;
        PEVENT_RECORD_CALLBACK EventRecordCallback;
    }
    ///On output, if this member is <b>TRUE</b>, the event tracing session is the NT Kernel Logger. Otherwise, it is
    ///another event tracing session.
    uint                 IsKernelTrace;
    ///Context data that a consumer can specify when calling OpenTrace. If the consumer uses EventRecordCallback to
    ///consume events, ETW sets the <b>UserContext</b> member of the EVENT_RECORD structure to this value. <b>Prior to
    ///Windows Vista: </b>Not supported.
    void*                Context;
}

///The <b>EVENT_TRACE_LOGFILE</b> structure specifies how the consumer wants to read events (from a log file or in
///real-time) and the callbacks that will receive the events. When ETW flushes a buffer, this structure contains
///information about the event tracing session and the buffer that ETW flushed.
struct EVENT_TRACE_LOGFILEA
{
    ///Name of the log file used by the event tracing session. Specify a value for this member if you are consuming from
    ///a log file. This member must be <b>NULL</b> if <b>LoggerName</b> is specified. You must know the log file name
    ///the controller specified. If the controller logged events to a private session (the controller set the
    ///<b>LogFileMode</b> member of EVENT_TRACE_PROPERTIES to <b>EVENT_TRACE_PRIVATE_LOGGER_MODE</b>), the file name
    ///must include the process identifier that ETW appended to the log file name. For example, if the controller named
    ///the log file xyz.etl and the process identifier is 123, ETW uses xyz.etl_123 as the file name. If the controller
    ///set the <b>LogFileMode</b> member of EVENT_TRACE_PROPERTIES to <b>EVENT_TRACE_FILE_MODE_NEWFILE</b>, the log file
    ///name must include the sequential serial number used to create each new log file. The user consuming the events
    ///must have permissions to read the file.
    PSTR                 LogFileName;
    ///Name of the event tracing session. Specify a value for this member if you want to consume events in real time.
    ///This member must be <b>NULL</b> if <b>LogFileName</b> is specified. You can only consume events in real time if
    ///the controller set the <b>LogFileMode</b> member of EVENT_TRACE_PROPERTIES to <b>EVENT_TRACE_REAL_TIME_MODE</b>.
    ///Only users with administrative privileges, users in the Performance Log Users group, and applications running as
    ///LocalSystem, LocalService, NetworkService can consume events in real time. To grant a restricted user the ability
    ///to consume events in real time, add them to the Performance Log Users group or call EventAccessControl.
    ///<b>Windows XP and Windows 2000: </b>Anyone can consume real time events.
    PSTR                 LoggerName;
    ///On output, the current time, in 100-nanosecond intervals since midnight, January 1, 1601.
    long                 CurrentTime;
    ///On output, the number of buffers processed.
    uint                 BuffersRead;
union
    {
        uint LogFileMode;
        uint ProcessTraceMode;
    }
    ///On output, an EVENT_TRACE structure that contains the last event processed.
    EVENT_TRACE          CurrentEvent;
    ///On output, a TRACE_LOGFILE_HEADER structure that contains general information about the session and the computer
    ///on which the session ran.
    TRACE_LOGFILE_HEADER LogfileHeader;
    ///Pointer to the BufferCallback function that receives buffer-related statistics for each buffer ETW flushes. ETW
    ///calls this callback after it delivers all the events in the buffer. This callback is optional.
    PEVENT_TRACE_BUFFER_CALLBACKA BufferCallback;
    ///On output, contains the size of each buffer, in bytes.
    uint                 BufferSize;
    ///On output, contains the number of bytes in the buffer that contain valid information.
    uint                 Filled;
    ///Not used.
    uint                 EventsLost;
union
    {
        PEVENT_CALLBACK EventCallback;
        PEVENT_RECORD_CALLBACK EventRecordCallback;
    }
    ///On output, if this member is <b>TRUE</b>, the event tracing session is the NT Kernel Logger. Otherwise, it is
    ///another event tracing session.
    uint                 IsKernelTrace;
    ///Context data that a consumer can specify when calling OpenTrace. If the consumer uses EventRecordCallback to
    ///consume events, ETW sets the <b>UserContext</b> member of the EVENT_RECORD structure to this value. <b>Prior to
    ///Windows Vista: </b>Not supported.
    void*                Context;
}

///The <b>ENABLE_TRACE_PARAMETERS_V1</b> structure defines the information used to enable a provider.
struct ENABLE_TRACE_PARAMETERS_V1
{
    ///Set to <b>ENABLE_TRACE_PARAMETERS_VERSION</b>.
    uint Version;
    ///Optional information that ETW can include when writing the event. The data is written to the extended data item
    ///section of the event. To include the optional information, specify one or more of the following flags; otherwise,
    ///set to zero. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="EVENT_ENABLE_PROPERTY_SID"></a><a id="event_enable_property_sid"></a><dl>
    ///<dt><b>EVENT_ENABLE_PROPERTY_SID</b></dt> </dl> </td> <td width="60%"> Include in the extended data the security
    ///identifier (SID) of the user. </td> </tr> <tr> <td width="40%"><a id="EVENT_ENABLE_PROPERTY_TS_ID"></a><a
    ///id="event_enable_property_ts_id"></a><dl> <dt><b>EVENT_ENABLE_PROPERTY_TS_ID</b></dt> </dl> </td> <td
    ///width="60%"> Include in the extended data the terminal session identifier. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_ENABLE_PROPERTY_STACK_TRACE"></a><a id="event_enable_property_stack_trace"></a><dl>
    ///<dt><b>EVENT_ENABLE_PROPERTY_STACK_TRACE</b></dt> </dl> </td> <td width="60%"> Include in the extended data a
    ///call stack trace for events written using EventWrite. If you set <b>EVENT_ENABLE_PROPERTY_STACK_TRACE</b>, ETW
    ///will drop the event if the total event size exceeds 64K. If the provider is logging events close in size to 64K
    ///maximum, it is possible that enabling stack capture will cause the event to be lost. If the stack is longer than
    ///the maximum number of frames (192), the frames will be cut from the bottom of the stack. For consumers, the
    ///events will include the EVENT_EXTENDED_ITEM_STACK_TRACE32 or EVENT_EXTENDED_ITEM_STACK_TRACE64 extended item.
    ///Note that on 64-bit computers, 32-bit processes will receive 64-bit stack traces. </td> </tr> </table>
    uint EnableProperty;
    ///Reserved. Set to 0.
    uint ControlFlags;
    ///A GUID that uniquely identifies the session that is enabling or disabling the provider. If the provider does not
    ///implement EnableCallback, the GUID is not used.
    GUID SourceId;
    ///An EVENT_FILTER_DESCRIPTOR structure that points to the filter data. The provider uses filter data to prevent
    ///events that match the filter criteria from being written to the session. The provider determines the layout of
    ///the data and how it applies the filter to the event's data. A session can pass only one filter to the provider. A
    ///session can call the TdhEnumerateProviderFilters function to determine the schematized filters that it can pass
    ///to the provider.
    EVENT_FILTER_DESCRIPTOR* EnableFilterDesc;
}

///The <b>ENABLE_TRACE_PARAMETERS</b> structure defines the information used to enable a provider.
struct ENABLE_TRACE_PARAMETERS
{
    ///Set to <b>ENABLE_TRACE_PARAMETERS_VERSION_2</b>.
    uint Version;
    ///Optional settings that ETW can include when writing the event. Some settings write extra data to the extended
    ///data item section of each event. Other settings refine which events will be included. To use these optional
    ///settings, specify one or more of the following flags; otherwise, set to zero. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="EVENT_ENABLE_PROPERTY_IGNORE_KEYWORD_0"></a><a
    ///id="event_enable_property_ignore_keyword_0"></a><dl> <dt><b>EVENT_ENABLE_PROPERTY_IGNORE_KEYWORD_0</b></dt> </dl>
    ///</td> <td width="60%"> Filters out all events that do not have a non-zero keyword specified. Supported on Windows
    ///10, version 1507 and later. This is also supported on Windows 8.1 and Windows 7 with SP1 via a patch. </td> </tr>
    ///<tr> <td width="40%"><a id="EVENT_ENABLE_PROPERTY_PROVIDER_GROUP"></a><a
    ///id="event_enable_property_provider_group"></a><dl> <dt><b>EVENT_ENABLE_PROPERTY_PROVIDER_GROUP</b></dt> </dl>
    ///</td> <td width="60%"> Indicates that this call to EnableTraceEx2 should enable a Provider Group rather than an
    ///individual Event Provider. Supported on Windows 10, version 1507 and later. This is also supported on Windows 8.1
    ///and Windows 7 with SP1 via a patch. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_ENABLE_PROPERTY_PROCESS_START_KEY"></a><a id="event_enable_property_process_start_key"></a><dl>
    ///<dt><b>EVENT_ENABLE_PROPERTY_PROCESS_START_KEY</b></dt> </dl> </td> <td width="60%"> Include the Process Start
    ///Key in the extended data. The Process Start Key is a sequence number that identifies the process. While the
    ///Process ID may be reused within a session, the Process Start Key is guaranteed uniqueness in the current boot
    ///session. Supported on Windows 10, version 1507 and later. This is also supported on Windows 8.1 and Windows 7
    ///with SP1 via a patch. </td> </tr> <tr> <td width="40%"><a id="EVENT_ENABLE_PROPERTY_EVENT_KEY"></a><a
    ///id="event_enable_property_event_key"></a><dl> <dt><b>EVENT_ENABLE_PROPERTY_EVENT_KEY</b></dt> </dl> </td> <td
    ///width="60%"> Include the Event Key in the extended data. The Event Key is a unique identifier for the event
    ///instance that will be constant across multiple trace sessions listening to this event. It can be used to
    ///correlate simultaneous trace sessions. Supported on Windows 10, version 1507 and later. </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_ENABLE_PROPERTY_EXCLUDE_INPRIVATE"></a><a
    ///id="event_enable_property_exclude_inprivate"></a><dl> <dt><b>EVENT_ENABLE_PROPERTY_EXCLUDE_INPRIVATE</b></dt>
    ///</dl> </td> <td width="60%"> Filters out all events that are either marked as an InPrivate event or come from a
    ///process that is marked as InPrivate. InPrivate implies that the event or process contains some data that would be
    ///considered private or personal. It is up to the process or event to designate itself as InPrivate for this to
    ///work. Supported on Windows 10, version 1507 and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_ENABLE_PROPERTY_SID"></a><a id="event_enable_property_sid"></a><dl>
    ///<dt><b>EVENT_ENABLE_PROPERTY_SID</b></dt> </dl> </td> <td width="60%"> Include in the extended data the security
    ///identifier (SID) of the user. Supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_ENABLE_PROPERTY_TS_ID"></a><a id="event_enable_property_ts_id"></a><dl>
    ///<dt><b>EVENT_ENABLE_PROPERTY_TS_ID</b></dt> </dl> </td> <td width="60%"> Include in the extended data the
    ///terminal session identifier. Supported on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_ENABLE_PROPERTY_STACK_TRACE"></a><a id="event_enable_property_stack_trace"></a><dl>
    ///<dt><b>EVENT_ENABLE_PROPERTY_STACK_TRACE</b></dt> </dl> </td> <td width="60%"> Include in the extended data a
    ///call stack trace for events written using EventWrite. If you set <b>EVENT_ENABLE_PROPERTY_STACK_TRACE</b>, ETW
    ///will drop the event if the total event size exceeds 64K. If the provider is logging events close in size to 64K
    ///maximum, it is possible that enabling stack capture will cause the event to be lost. If the stack is longer than
    ///the maximum number of frames (192), the frames will be cut from the bottom of the stack. For consumers, the
    ///events will include the EVENT_EXTENDED_ITEM_STACK_TRACE32 or EVENT_EXTENDED_ITEM_STACK_TRACE64 extended item.
    ///Note that on 64-bit computers, 32-bit processes will receive 64-bit stack traces. Supported on Windows 7 and
    ///later. </td> </tr> </table>
    uint EnableProperty;
    ///Reserved. Set to 0.
    uint ControlFlags;
    ///A GUID that uniquely identifies the session that is enabling or disabling the provider. If the provider does not
    ///implement EnableCallback, the GUID is not used.
    GUID SourceId;
    ///A pointer to an array of EVENT_FILTER_DESCRIPTOR structures that points to the filter data. The number of
    ///elements in the array is specified in the <b>FilterDescCount</b> member. There can only be one filter for a
    ///specific filter type as specified by the <b>Type</b> member of the <b>EVENT_FILTER_DESCRIPTOR</b> structure. For
    ///a schematized filter (a <b>Type</b> member equal to <b>EVENT_FILTER_TYPE_SCHEMATIZED</b>), the provider uses
    ///filter data to prevent events that match the filter criteria from being written to the session. The provider
    ///determines the layout of the data and how it applies the filter to the event's data. A session can pass only one
    ///schematized filter to the provider. A session can call the TdhEnumerateProviderFilters function to determine the
    ///schematized filters that it can pass to the provider.
    EVENT_FILTER_DESCRIPTOR* EnableFilterDesc;
    ///The number of elements (filters) in the EVENT_FILTER_DESCRIPTOR array pointed to by <b>EnableFilterDesc</b>
    ///member. The <b>FilterDescCount</b> member should match the number of EVENT_FILTER_DESCRIPTOR structures in the
    ///array pointed to by the <b>EnableFilterDesc</b> member. .
    uint FilterDescCount;
}

///Identifies the kernel event for which you want to enable call stack tracing.
struct CLASSIC_EVENT_ID
{
    ///The GUID that identifies the kernel event class.
    GUID     EventGuid;
    ///The event type that identifies the event within the kernel event class to enable.
    ubyte    Type;
    ///Reserved.
    ubyte[7] Reserved;
}

struct TRACE_PROFILE_INTERVAL
{
    uint Source;
    uint Interval;
}

///Determines the version information of the TraceLogging session.
struct TRACE_VERSION_INFO
{
    ///TraceLogging version information.
    uint EtwTraceProcessingVersion;
    ///Not used.
    uint Reserved;
}

///Information relating to a periodic capture state.
struct TRACE_PERIODIC_CAPTURE_STATE_INFO
{
    ///The frequency of state captures in seconds.
    uint   CaptureStateFrequencyInSeconds;
    ///The number of providers.
    ushort ProviderCount;
    ///Reserved for future use.
    ushort Reserved;
}

///Contains partition information pulled from an ETW trace. Most commonly used as a return structure for
///QueryTraceProcessingHandle.
struct ETW_TRACE_PARTITION_INFORMATION
{
    ///GUID to identify the machine.
    GUID PartitionId;
    ///GUID that identifies the partition instance that contains the traced partition. If the traced partition is a
    ///host, then <b>ParentId</b> will be 0.
    GUID ParentId;
    ///Reserved for future use.
    long QpcOffsetFromRoot;
    uint PartitionType;
}

struct ETW_TRACE_PARTITION_INFORMATION_V2
{
    long  QpcOffsetFromRoot;
    uint  PartitionType;
    PWSTR PartitionId;
    PWSTR ParentId;
}

///The <b>EVENT_DATA_DESCRIPTOR </b> structure defines one of the data items of the event data.
struct EVENT_DATA_DESCRIPTOR
{
    ///A pointer to the data.
    ulong Ptr;
    ///The size, in bytes, of the data.
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

///The <b>EVENT_DESCRIPTOR</b> structure contains metadata that defines the event.
struct EVENT_DESCRIPTOR
{
    ///The event identifier.
    ushort Id;
    ///The version of the event. The version indicates a revision to the event definition. You can use this member and
    ///the Id member to uniquely identify the event within the scope of a provider.
    ubyte  Version;
    ///The audience for the event (for example, administrator or developer).
    ubyte  Channel;
    ///The severity or level of detail included in the event (for example, informational or fatal).
    ubyte  Level;
    ///A step in a sequence of operations being performed within the Task.
    ubyte  Opcode;
    ///A larger unit of work within an application or component (is broader than the Opcode).
    ushort Task;
    ///A bitmask that specifies a logical group of related events. Each bit corresponds to one group. An event may
    ///belong to one or more groups. The keyword can contain one or more provider-defined keywords, standard keywords,
    ///or both.
    ulong  Keyword;
}

///The <b>EVENT_FILTER_DESCRIPTOR</b> structure defines the filter data that a session passes to the provider's enable
///callback function.
struct EVENT_FILTER_DESCRIPTOR
{
    ///A pointer to the filter data for the filter type specified in the <b>Type</b> member. If the <b>Type</b> member
    ///is set to <b>EVENT_FILTER_TYPE_PID</b>, the <b>Ptr</b> member points to an array of process IDs (PIDs). For other
    ///values of the <b>Type</b> member, the <b>Ptr</b> member points to a single structure or entry, not an array. If
    ///the <b>Type</b> member is set to <b>EVENT_FILTER_TYPE_EVENT_ID</b>, the <b>Ptr</b> member points to a
    ///EVENT_FILTER_EVENT_ID structure that contains an array of event IDs and a Boolean value that determines whether
    ///tracing is enabled or disabled for the specified event IDs. If the <b>Type</b> member is set to
    ///<b>EVENT_FILTER_TYPE_STACKWALK</b>, the <b>Ptr</b> member points to a EVENT_FILTER_EVENT_ID structure that
    ///contains an array of event IDs and a Boolean value that determines whether stack tracing is enabled or disabled
    ///for the specified event IDs. If the <b>Type</b> member is set to <b>EVENT_FILTER_TYPE_SCHEMATIZED</b>, see the
    ///EVENT_FILTER_HEADER structure for details on constructing the filter.
    ulong Ptr;
    ///The size of the data, in bytes. The maximum data size limit varies based on the specified <b>Type</b> member (the
    ///type of the filter). The maximum data size, in bytes, for many of the filter types is limited to
    ///<b>MAX_EVENT_FILTER_DATA_SIZE</b> defined in the <i>evntprov.h</i> header file to 1024.
    uint  Size;
    ///A provider-defined value that identifies the filter. For filters defined in an instrumentation manifest, set this
    ///member to <b>EVENT_FILTER_TYPE_SCHEMATIZED</b>. The possible values for this member are defined in the
    ///<i>Evntprov.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_NONE"></a><a id="event_filter_type_none"></a><dl> <dt><b>EVENT_FILTER_TYPE_NONE</b></dt>
    ///<dt>0x00000000</dt> </dl> </td> <td width="60%"> No filters. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_SCHEMATIZED"></a><a id="event_filter_type_schematized"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_SCHEMATIZED</b></dt> <dt>0x80000000</dt> </dl> </td> <td width="60%"> A schematized
    ///filter. This is the traditional filtering setup also called provider-side filtering. The controller defines a
    ///custom set of filters as a binary object that is passed to the provider in the EnableTrace, EnableTraceEx, or
    ///EnableTraceEx2 call. It is incumbent on the controller and provider to define and interpret these filters and the
    ///controller should only log applicable events. This requires a close coupling of the controller and provider since
    ///the type and format of the binary object of what can be filtered is not defined. The TdhEnumerateProviderFilters
    ///function can be used to retrieve the filters defined in a manifest. For more information on schematized filters,
    ///see Defining Filters. </td> </tr> <tr> <td width="40%"><a id="EVENT_FILTER_TYPE_SYSTEM_FLAGS"></a><a
    ///id="event_filter_type_system_flags"></a><dl> <dt><b>EVENT_FILTER_TYPE_SYSTEM_FLAGS</b></dt> <dt>0x80000001</dt>
    ///</dl> </td> <td width="60%"> Reserved for internal use. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_TRACEHANDLE"></a><a id="event_filter_type_tracehandle"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_TRACEHANDLE</b></dt> <dt>0x80000002</dt> </dl> </td> <td width="60%"> Used to capture a
    ///rundown of a particular trace session. The <i>ControlCode</i> parameter passed to the EnableTraceEx function must
    ///be set to <b>EVENT_CONTROL_CODE_CAPTURE_STATE</b> and the<i> ProviderId</i> parameter must be the
    ///<b>SystemTraceControlGuid</b>. The <b>EVENT_FILTER_DESCRIPTOR</b> structure should point to a single
    ///<b>TRACEHANDLE</b> that represents a current ETW session. A rundown will be performed for that particular
    ///session. </td> </tr> <tr> <td width="40%"><a id="EVENT_FILTER_TYPE_PID"></a><a
    ///id="event_filter_type_pid"></a><dl> <dt><b>EVENT_FILTER_TYPE_PID</b></dt> <dt>0x80000004</dt> </dl> </td> <td
    ///width="60%"> The process ID. This is one of the scope filters. Filtering ETW events based on process IDs will
    ///result in an event stream (file or real-time) that contains the events from the providers in the specified
    ///processes only. It will only enable the provider in the processes whose PIDs are provided. The list of PIDs is
    ///the PIDs of the processes running at the time when EnableTraceEx2 is called and will enable the provider in all
    ///the processes (for which PIDs are provided) at that particular time. The list of PIDs will not be stored in the
    ///session. So when a process is terminated and then reappears, the provider in it will not get automatically
    ///enabled to the trace session. The PIDs based filter-blob is only valid for a kernel mode logger session because
    ///the private logger session runs inside a user-mode process. The maximum number of process IDs that can be
    ///filtered is limited by <b>MAX_EVENT_FILTER_PID_COUNT</b> defined in the <i>evntprov.h</i> header file to 8. In
    ///case a process ID filter is provided, then the provider will be enabled in the user-mode processes only. In case,
    ///the same provider is registered by a kernel-mode driver, it will not be enabled. This is used with
    ///EVENT_TRACE_PROPERTIES_V2 for system wide private loggers. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_EXECUTABLE_NAME"></a><a id="event_filter_type_executable_name"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_EXECUTABLE_NAME</b></dt> <dt>0x80000008</dt> </dl> </td> <td width="60%"> The executable
    ///file name. This is one of the scope filters. This is used with EVENT_TRACE_PROPERTIES_V2 for system wide private
    ///loggers. </td> </tr> <tr> <td width="40%"><a id="EVENT_FILTER_TYPE_PACKAGE_ID"></a><a
    ///id="event_filter_type_package_id"></a><dl> <dt><b>EVENT_FILTER_TYPE_PACKAGE_ID</b></dt> <dt>0x80000010</dt> </dl>
    ///</td> <td width="60%"> The package ID. This is one of the scope filters This can be used to filter providers to
    ///events emitted from a particular Windows Store app package. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_PACKAGE_APP_ID"></a><a id="event_filter_type_package_app_id"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_PACKAGE_APP_ID</b></dt> <dt>0x80000020</dt> </dl> </td> <td width="60%"> The package
    ///relative app ID (PRAID). This is one of the scope filters This can be used to filter providers to events emitted
    ///from a particular Windows Store app package. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_PAYLOAD"></a><a id="event_filter_type_payload"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_PAYLOAD</b></dt> <dt>0x80000100</dt> </dl> </td> <td width="60%"> The event payload (the
    ///content of the event). The maximum data size, in bytes, for an event payload filter is limited to
    ///<b>MAX_EVENT_FILTER_PAYLOAD_SIZE</b> defined in the <i>evntprov.h</i> header file to 4096. </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_FILTER_TYPE_EVENT_ID"></a><a id="event_filter_type_event_id"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_EVENT_ID</b></dt> <dt>0x80000200</dt> </dl> </td> <td width="60%"> The event ID. This
    ///feature allows enabling or disabling filtering for a list of events. The provided filter includes a
    ///EVENT_FILTER_EVENT_ID structure that contains an array of event IDs and a Boolean value that indicates whether to
    ///enable or disable from filtering for the specified events. Each event write call will go through this array
    ///quickly to find out whether enable or disable logging the event. When applied to a TraceLogging provider this
    ///filter will be ignored as TraceLogging events do not have static event IDs. The maximum number of event IDs
    ///allowed in the EVENT_FILTER_EVENT_ID structure is limited by <b>MAX_EVENT_FILTER_EVENT_ID_COUNT</b> defined in
    ///the <i>evntprov.h</i> header file to 64. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_EVENT_NAME"></a><a id="event_filter_type_event_name"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_EVENT_NAME</b></dt> <dt>0x80000400</dt> </dl> </td> <td width="60%"> The TraceLogging
    ///event name. This feature allows enabling or disabling of TraceLogging events based on their names. The provided
    ///filter includes an EVENT_FILTER_EVENT_NAME structure that contains an array of event names, keyword bitmasks, and
    ///level to filter on, and a Boolean value that indicates whether to enable or disable the described events. When
    ///applied to a non-TraceLogging provider, this filter is ignored as those events do not have names specified in
    ///their payload. <div class="alert"><b>Note</b> Available on Windows 10, version 1709 and later.</div> <div> </div>
    ///</td> </tr> <tr> <td width="40%"><a id="EVENT_FILTER_TYPE_STACKWALK"></a><a
    ///id="event_filter_type_stackwalk"></a><dl> <dt><b>EVENT_FILTER_TYPE_STACKWALK</b></dt> <dt>0x80001000</dt> </dl>
    ///</td> <td width="60%"> A stack walk. When stack walking is enabled for a provider, then the stack is captured for
    ///all the events generated by the provider. Most of the time, the user is only interested in stack from only
    ///certain number of events. This feature allows enabling or disabling stack walking on a list of events. The
    ///provided filter includes a EVENT_FILTER_EVENT_ID structure that contains an array of event IDs and a Boolean
    ///value that indicates whether to enable or disable stack capturing for the specified events. Each event write call
    ///will go through this array quickly to find out whether the stack should be captured or not. When applied to a
    ///TraceLogging provider, this filter will be ignored as TraceLogging events do not have static event IDs. If you
    ///choose to use this filter, you still must specify <b>EVENT_ENABLE_PROPERTY_STACK_TRACE</b> in the
    ///ENABLE_TRACE_PARAMETERS structure when enabling the provider for any stacks to be collected from a provider. The
    ///maximum number of event IDs allowed in the EVENT_FILTER_EVENT_ID structure is limited by
    ///<b>MAX_EVENT_FILTER_EVENT_ID_COUNT</b> defined in the <i>evntprov.h</i> header file to 64. <div
    ///class="alert"><b>Note</b> Available on Windows 10, version 1709 and later.</div> <div> </div> </td> </tr> <tr>
    ///<td width="40%"><a id="EVENT_FILTER_TYPE_STACKWALK_NAME"></a><a id="event_filter_type_stackwalk_name"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_STACKWALK_NAME</b></dt> <dt>0x80002000</dt> </dl> </td> <td width="60%"> A TraceLogging
    ///event name. This feature allows filtering of stack collection for TraceLogging events based on the event names.
    ///The provided filter includes an EVENT_FILTER_EVENT_NAME structure that contains an array of event names, keyword
    ///bitmasks, and level to filter on, and a Boolean value that indicates whether to collect stacks or not for the
    ///described events. When applied to a non-TraceLogging provider, this filter is ignored as those events do not have
    ///names specified in their payload. If you choose to use this filter, you still must specify
    ///<b>EVENT_ENABLE_PROPERTY_STACK_TRACE</b> on the ENABLE_TRACE_PARAMETERS structure when enabling the provider for
    ///any stacks to be collected from a provider at all. <div class="alert"><b>Note</b> Available on Windows 10,
    ///version 1709 and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_FILTER_TYPE_STACKWALK_LEVEL_KW"></a><a id="event_filter_type_stackwalk_level_kw"></a><dl>
    ///<dt><b>EVENT_FILTER_TYPE_STACKWALK_LEVEL_KW</b></dt> <dt>0x80004000</dt> </dl> </td> <td width="60%"> Event level
    ///and keyword. This feature allows filtering of stack collection for events based on their level and keyword. The
    ///provided filter includes an EVENT_FILTER_LEVEL_KW structure that contains keyword bitmasks and level to filter
    ///on, as well as a Boolean value that indicates whether to collect stacks or not for the described events. If you
    ///choose to use this filter, you still must specify <b>EVENT_ENABLE_PROPERTY_STACK_TRACE</b> on the
    ///ENABLE_TRACE_PARAMETERS structure when enabling the provider for any stacks to be collected from a provider at
    ///all. <div class="alert"><b>Note</b> Available on Windows 10, version 1709 and later.</div> <div> </div> </td>
    ///</tr> </table>
    uint  Type;
}

///Defines the header data that must precede the filter data that is defined in the instrumentation manifest.
struct EVENT_FILTER_HEADER
{
    ///The identifier that identifies the filter in the manifest for a schematized filter. The <b>value</b> attribute of
    ///the <b>filter</b> element contains the identifier.
    ushort   Id;
    ///The version number of the filter for a schematized filter. The <b>version</b> attribute of the <b>filter</b>
    ///element contains the version number.
    ubyte    Version;
    ///Reserved
    ubyte[5] Reserved;
    ///An identifier that identifies the session that passed the filter. ETW sets this value; the session must set this
    ///member to zero. Providers use this value to set the <i>Filter</i> parameter of EventWriteEx to prevent the event
    ///from being written to the session if the event data does not match the filter criteria (the provider determines
    ///the semantics of how the filter data is used in determining whether the event is written to the session).
    ulong    InstanceId;
    ///The size, in bytes, of this header and the filter data that is appended to the end of this header.
    uint     Size;
    ///The offset from the beginning of this filter object to the next filter object. The value is zero if there are no
    ///more filter blocks. ETW sets this value; the session must set this member to zero.
    uint     NextOffset;
}

///The <b>EVENT_FILTER_EVENT_ID</b> structure defines event IDs used in an EVENT_FILTER_DESCRIPTOR structure for an
///event ID or stack walk filter.
struct EVENT_FILTER_EVENT_ID
{
    ///A value that indicates whether filtering should be enabled or disabled for the event IDs passed in the
    ///<b>Events</b> member. When this member is <b>TRUE</b>, filtering is enabled for the specified event IDs. When
    ///this member is <b>FALSE</b>, filtering is disabled for the event IDs.
    ubyte     FilterIn;
    ///A reserved value.
    ubyte     Reserved;
    ///The number of event IDs in the <b>Events</b> member.
    ushort    Count;
    ///An array of event IDs.
    ushort[1] Events;
}

///The <b>EVENT_FILTER_EVENT_NAME</b> structure defines event IDs used in an EVENT_FILTER_DESCRIPTOR structure for an
///event name or stalk walk name filter. This filter will only be applied to events that are otherwise enabled on the
///logging session, via level/keyword in the enable call.
struct EVENT_FILTER_EVENT_NAME
{
    ///Bitmask of keywords that determine the category of events to filter on.
    ulong    MatchAnyKeyword;
    ///This bitmask is optional. This mask further restricts the category of events that you want to filter on. If the
    ///event's keyword meets the <b>MatchAnyKeyword</b> condition, the provider will filter the event only if all of the
    ///bits in this mask exist in the event's keyword. This mask is not used if <b>MatchAnyKeyword</b> is zero.
    ulong    MatchAllKeyword;
    ///Defines the severity level of the event to filter on.
    ubyte    Level;
    ///<b>True</b> to filter the events matching the provided names in; <b>false</b> to filter them out. When used for
    ///the <b>EVENT_FILTER_TYPE_STACKWALK_NAME</b>filter type, the filtered in events will have stacks collected for
    ///them.
    ubyte    FilterIn;
    ///The number of names in the <b>Names</b> member.
    ushort   NameCount;
    ///An <b>NameCount</b> long array of null-terminated, UTF-8 event names.
    ubyte[1] Names;
}

///The <b>EVENT_FILTER_LEVEL_KW</b> structure defines event IDs used in an EVENT_FILTER_DESCRIPTOR structure for a stack
///walk level-keyword filter. This filter is only applied to events that are otherwise enabled on the logging session,
///via a level/keyword in the enable call.
struct EVENT_FILTER_LEVEL_KW
{
    ///Bitmask of keywords that determine the category of events to filter on.
    ulong MatchAnyKeyword;
    ///This bitmask is optional. This mask further restricts the category of events that you want to filter on. If the
    ///event's keyword meets the <b>MatchAnyKeyword</b> condition, the provider will filter the event only if all of the
    ///bits in this mask exist in the event's keyword. This mask is not used if <b>MatchAnyKeyword</b> is zero.
    ulong MatchAllKeyword;
    ///Defines the severity level of the event to filter on.
    ubyte Level;
    ubyte FilterIn;
}

///The <b>EVENT_HEADER_EXTENDED_DATA_ITEM</b> structure defines the extended data that ETW collects as part of the event
///data.
struct EVENT_HEADER_EXTENDED_DATA_ITEM
{
    ///Reserved.
    ushort Reserved1;
    ///Type of extended data. The following are possible values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="EVENT_HEADER_EXT_TYPE_RELATED_ACTIVITYID"></a><a
    ///id="event_header_ext_type_related_activityid"></a><dl> <dt><b>EVENT_HEADER_EXT_TYPE_RELATED_ACTIVITYID</b></dt>
    ///</dl> </td> <td width="60%"> The <b>DataPtr</b> member points to an EVENT_EXTENDED_ITEM_RELATED_ACTIVITYID
    ///structure that contains the related activity identifier if you called EventWriteTransfer to write the event.
    ///</td> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_EXT_TYPE_SID"></a><a id="event_header_ext_type_sid"></a><dl>
    ///<dt><b>EVENT_HEADER_EXT_TYPE_SID</b></dt> </dl> </td> <td width="60%"> The <b>DataPtr</b> member points to a SID
    ///structure that contains the security identifier (SID) of the user that logged the event. ETW includes the SID if
    ///you set the <i>EnableProperty</i> parameter of EnableTraceEx to EVENT_ENABLE_PROPERTY_SID. </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_HEADER_EXT_TYPE_TS_ID"></a><a id="event_header_ext_type_ts_id"></a><dl>
    ///<dt><b>EVENT_HEADER_EXT_TYPE_TS_ID</b></dt> </dl> </td> <td width="60%"> The <b>DataPtr</b> member points to an
    ///EVENT_EXTENDED_ITEM_TS_ID structure that contains the terminal session identifier. ETW includes the terminal
    ///session identifier if you set the <i>EnableProperty</i> parameter of EnableTraceEx to
    ///EVENT_ENABLE_PROPERTY_TS_ID. </td> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_EXT_TYPE_INSTANCE_INFO"></a><a
    ///id="event_header_ext_type_instance_info"></a><dl> <dt><b>EVENT_HEADER_EXT_TYPE_INSTANCE_INFO</b></dt> </dl> </td>
    ///<td width="60%"> The <b>DataPtr</b> member points to an EVENT_EXTENDED_ITEM_INSTANCE structure that contains the
    ///activity identifier if you called TraceEventInstance to write the event. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_HEADER_EXT_TYPE_STACK_TRACE32"></a><a id="event_header_ext_type_stack_trace32"></a><dl>
    ///<dt><b>EVENT_HEADER_EXT_TYPE_STACK_TRACE32</b></dt> </dl> </td> <td width="60%"> The <b>DataPtr</b> member points
    ///to an EVENT_EXTENDED_ITEM_STACK_TRACE32 structure that contains the call stack if the event is captured on a
    ///32-bit computer. </td> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_EXT_TYPE_STACK_TRACE64"></a><a
    ///id="event_header_ext_type_stack_trace64"></a><dl> <dt><b>EVENT_HEADER_EXT_TYPE_STACK_TRACE64</b></dt> </dl> </td>
    ///<td width="60%"> The <b>DataPtr</b> member points to an EVENT_EXTENDED_ITEM_STACK_TRACE64 structure that contains
    ///the call stack if the event is captured on a 64-bit computer. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_HEADER_EXT_TYPE_EVENT_SCHEMA_TL"></a><a id="event_header_ext_type_event_schema_tl"></a><dl>
    ///<dt><b>EVENT_HEADER_EXT_TYPE_EVENT_SCHEMA_TL</b></dt> </dl> </td> <td width="60%"> The <b>DataPtr</b> member
    ///points to an extended header item that contains TraceLogging event metadata information. </td> </tr> <tr> <td
    ///width="40%"><a id="_EVENT_HEADER_EXT_TYPE_PROV_TRAITS"></a><a id="_event_header_ext_type_prov_traits"></a><dl>
    ///<dt><b> EVENT_HEADER_EXT_TYPE_PROV_TRAITS</b></dt> </dl> </td> <td width="60%"> The <b>DataPtr</b> member points
    ///to an extended header item that contains provider traits data, for example traits set through
    ///EventSetInformation(EventProviderSetTraits) or specified through EVENT_DATA_DESCRIPTOR_TYPE_PROVIDER_METADATA.
    ///</td> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_EXT_TYPE_EVENT_KEY"></a><a
    ///id="event_header_ext_type_event_key"></a><dl> <dt><b>EVENT_HEADER_EXT_TYPE_EVENT_KEY</b></dt> </dl> </td> <td
    ///width="60%"> The <b>DataPtr</b> member points to an EVENT_EXTENDED_ITEM_EVENT_KEY structure that contains a
    ///unique event identifier which is a 64-bit scalar. The <b>EnableProperty</b>EVENT_ENABLE_PROPERTY_EVENT_KEY needs
    ///to be passed in for the EnableTrace call for a given provider to enable this feature. </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_HEADER_EXT_TYPE_PROCESS_START_KEY"></a><a
    ///id="event_header_ext_type_process_start_key"></a><dl> <dt><b>EVENT_HEADER_EXT_TYPE_PROCESS_START_KEY</b></dt>
    ///</dl> </td> <td width="60%"> The <b>DataPtr</b> member points to an EVENT_EXTENDED_ITEM_PROCESS_START_KEY
    ///structure that contains a unique process identifier (unique across the boot session). This identifier is a 64-bit
    ///scalar. The <b>EnableProperty</b>EVENT_ENABLE_PROPERTY_PROCESS_START_KEY needs to be passed in for the
    ///EnableTrace call for a given provider to enable this feature. </td> </tr> </table>
    ushort ExtType;
struct
    {
        ushort _bitfield38;
    }
    ///Size, in bytes, of the extended data that <b>DataPtr</b> points to.
    ushort DataSize;
    ///Pointer to the extended data. The <b>ExtType</b> member determines the type of extended data to which this member
    ///points.
    ulong  DataPtr;
}

///The <b>EVENT_EXTENDED_ITEM_INSTANCE</b> structure defines the relationship between events if TraceEventInstance was
///used to log related events.
struct EVENT_EXTENDED_ITEM_INSTANCE
{
    ///A unique transaction identifier that maps an event to a specific transaction.
    uint InstanceId;
    ///A unique transaction identifier of a parent event if you are mapping a hierarchical relationship.
    uint ParentInstanceId;
    ///A GUID that uniquely identifies the provider that logged the event referenced by the <b>ParentInstanceId</b>
    ///member.
    GUID ParentGuid;
}

///The <b>EVENT_EXTENDED_ITEM_RELATED_ACTIVITYID</b> structure defines the parent event of this event.
struct EVENT_EXTENDED_ITEM_RELATED_ACTIVITYID
{
    ///A GUID that uniquely identifies the parent activity to which this activity is related. The identifier is
    ///specified in the <i>RelatedActivityId</i> parameter passed to the EventWriteTransfer function.
    GUID RelatedActivityId;
}

///The <b>EVENT_EXTENDED_ITEM_TS_ID</b>defines the terminal session that logged the event.
struct EVENT_EXTENDED_ITEM_TS_ID
{
    ///Identifies the terminal session that logged the event.
    uint SessionId;
}

///The <b>EVENT_EXTENDED_ITEM_STACK_TRACE32</b> structure defines a call stack on a 32-bit computer.
struct EVENT_EXTENDED_ITEM_STACK_TRACE32
{
    ///A unique identifier that you use to match the kernel-mode calls to the user-mode calls; the kernel-mode calls and
    ///user-mode calls are captured in separate events if the environment prevents both from being captured in the same
    ///event. If the kernel-mode and user-mode calls were captured in the same event, the value is zero. Typically, on
    ///32-bit computers, you can always capture both the kernel-mode and user-mode calls in the same event. However, if
    ///you use the frame pointer optimization compiler option, the stack may not be captured, captured incorrectly, or
    ///truncated.
    ulong   MatchId;
    ///An array of call addresses on the stack.
    uint[1] Address;
}

///The <b>EVENT_EXTENDED_ITEM_STACK_TRACE64</b> structure defines a call stack on a 64-bit computer.
struct EVENT_EXTENDED_ITEM_STACK_TRACE64
{
    ///A unique identifier that you use to match the kernel-mode calls to the user-mode calls; the kernel-mode calls and
    ///user-mode calls are captured in separate events if the environment prevents both from being captured in the same
    ///event. If the kernel-mode and user-mode calls were captured in the same event, the value is zero.
    ulong    MatchId;
    ///An array of call addresses on the stack.
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

///Defines information about the event.
struct EVENT_HEADER
{
    ///Size of the event record, in bytes.
    ushort           Size;
    ///Reserved.
    ushort           HeaderType;
    ///Flags that provide information about the event such as the type of session it was logged to and if the event
    ///contains extended data. This member can contain one or more of the following flags. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_FLAG_EXTENDED_INFO"></a><a
    ///id="event_header_flag_extended_info"></a><dl> <dt><b>EVENT_HEADER_FLAG_EXTENDED_INFO</b></dt> </dl> </td> <td
    ///width="60%"> The <b>ExtendedData</b> member of EVENT_RECORD contains data. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_HEADER_FLAG_PRIVATE_SESSION"></a><a id="event_header_flag_private_session"></a><dl>
    ///<dt><b>EVENT_HEADER_FLAG_PRIVATE_SESSION</b></dt> </dl> </td> <td width="60%"> The event was logged to a private
    ///session. Use <b>ProcessorTime</b> for elapsed execution time. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_HEADER_FLAG_STRING_ONLY"></a><a id="event_header_flag_string_only"></a><dl>
    ///<dt><b>EVENT_HEADER_FLAG_STRING_ONLY</b></dt> </dl> </td> <td width="60%"> The event data is a null-terminated
    ///Unicode string. You do not need a manifest to parse the <b>UserData</b> member of EVENT_RECORD. </td> </tr> <tr>
    ///<td width="40%"><a id="EVENT_HEADER_FLAG_TRACE_MESSAGE"></a><a id="event_header_flag_trace_message"></a><dl>
    ///<dt><b>EVENT_HEADER_FLAG_TRACE_MESSAGE</b></dt> </dl> </td> <td width="60%"> The provider used TraceMessage or
    ///TraceMessageVa to log the event. Most providers do not use these functions to write events, so this flag
    ///typically indicates that the event was written by Windows Software Trace Preprocessor (WPP). </td> </tr> <tr> <td
    ///width="40%"><a id="EVENT_HEADER_FLAG_NO_CPUTIME"></a><a id="event_header_flag_no_cputime"></a><dl>
    ///<dt><b>EVENT_HEADER_FLAG_NO_CPUTIME</b></dt> </dl> </td> <td width="60%"> Use <b>ProcessorTime</b> for elapsed
    ///execution time. </td> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_FLAG_32_BIT_HEADER"></a><a
    ///id="event_header_flag_32_bit_header"></a><dl> <dt><b>EVENT_HEADER_FLAG_32_BIT_HEADER</b></dt> </dl> </td> <td
    ///width="60%"> Indicates that the provider was running on a 32-bit computer or in a WOW64 session. </td> </tr> <tr>
    ///<td width="40%"><a id="EVENT_HEADER_FLAG_64_BIT_HEADER"></a><a id="event_header_flag_64_bit_header"></a><dl>
    ///<dt><b>EVENT_HEADER_FLAG_64_BIT_HEADER</b></dt> </dl> </td> <td width="60%"> Indicates that the provider was
    ///running on a 64-bit computer. </td> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_FLAG_CLASSIC_HEADER"></a><a
    ///id="event_header_flag_classic_header"></a><dl> <dt><b>EVENT_HEADER_FLAG_CLASSIC_HEADER</b></dt> </dl> </td> <td
    ///width="60%"> Indicates that provider used TraceEvent to log the event. </td> </tr> </table>
    ushort           Flags;
    ///Indicates the source to use for parsing the event data. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="EVENT_HEADER_PROPERTY_XML"></a><a id="event_header_property_xml"></a><dl>
    ///<dt><b>EVENT_HEADER_PROPERTY_XML</b></dt> </dl> </td> <td width="60%"> Indicates that you need a manifest to
    ///parse the event data. </td> </tr> <tr> <td width="40%"><a id="EVENT_HEADER_PROPERTY_FORWARDED_XML"></a><a
    ///id="event_header_property_forwarded_xml"></a><dl> <dt><b>EVENT_HEADER_PROPERTY_FORWARDED_XML</b></dt> </dl> </td>
    ///<td width="60%"> Indicates that the event data contains within itself a fully-rendered XML description of the
    ///data, so you do not need a manifest to parse the event data. </td> </tr> <tr> <td width="40%"><a
    ///id="EVENT_HEADER_PROPERTY_LEGACY_EVENTLOG"></a><a id="event_header_property_legacy_eventlog"></a><dl>
    ///<dt><b>EVENT_HEADER_PROPERTY_LEGACY_EVENTLOG</b></dt> </dl> </td> <td width="60%"> Indicates that you need a WMI
    ///MOF class to parse the event data. </td> </tr> </table>
    ushort           EventProperty;
    ///Identifies the thread that generated the event.
    uint             ThreadId;
    ///Identifies the process that generated the event.
    uint             ProcessId;
    ///Contains the time that the event occurred. The resolution is system time unless the <b>ProcessTraceMode</b>
    ///member of EVENT_TRACE_LOGFILE contains the PROCESS_TRACE_MODE_RAW_TIMESTAMP flag, in which case the resolution
    ///depends on the value of the <b>Wnode.ClientContext</b> member of EVENT_TRACE_PROPERTIES at the time the
    ///controller created the session.
    LARGE_INTEGER    TimeStamp;
    ///GUID that uniquely identifies the provider that logged the event.
    GUID             ProviderId;
    ///Defines the information about the event such as the event identifier and severity level. For details, see
    ///EVENT_DESCRIPTOR.
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
    ///Identifier that relates two events. For details, see EventWriteTransfer.
    GUID             ActivityId;
}

///The <b>EVENT_RECORD</b> structure defines the layout of an event that ETW delivers.
struct EVENT_RECORD
{
    ///Information about the event such as the time stamp for when it was written. For details, see the EVENT_HEADER
    ///structure.
    EVENT_HEADER       EventHeader;
    ///Defines information such as the session that logged the event. For details, see the ETW_BUFFER_CONTEXT structure.
    ETW_BUFFER_CONTEXT BufferContext;
    ///The number of extended data structures in the <b>ExtendedData</b> member.
    ushort             ExtendedDataCount;
    ///The size, in bytes, of the data in the <b>UserData</b> member.
    ushort             UserDataLength;
    ///One or more extended data items that ETW collects. The extended data includes some items, such as the security
    ///identifier (SID) of the user that logged the event, only if the controller sets the <i>EnableProperty</i>
    ///parameter passed to the EnableTraceEx or EnableTraceEx2 function. The extended data includes other items, such as
    ///the related activity identifier and decoding information for trace logging, regardless whether the controller
    ///sets the <i>EnableProperty</i> parameter passed to <b>EnableTraceEx</b> or <b>EnableTraceEx2</b>. For details,
    ///see the EVENT_HEADER_EXTENDED_DATA_ITEM structure .
    EVENT_HEADER_EXTENDED_DATA_ITEM* ExtendedData;
    ///Event specific data. To parse this data, see Retrieving Event Data Using TDH. If the <b>Flags</b> member of
    ///EVENT_HEADER contains <b>EVENT_HEADER_FLAG_STRING_ONLY</b>, the data is a null-terminated Unicode string that you
    ///do not need TDH to parse.
    void*              UserData;
    ///Th context specified in the <b>Context</b> member of the EVENT_TRACE_LOGFILE structure that is passed to the
    ///OpenTrace function.
    void*              UserContext;
}

///Defines a single value map entry.
struct EVENT_MAP_ENTRY
{
    ///Offset from the beginning of the EVENT_MAP_INFO structure to a null-terminated Unicode string that contains the
    ///string associated with the map value in <b>Value</b> or <b>InputOffset</b>.
    uint OutputOffset;
union
    {
        uint Value;
        uint InputOffset;
    }
}

///Defines the metadata about the event map.
struct EVENT_MAP_INFO
{
    ///Offset from the beginning of this structure to a null-terminated Unicode string that contains the name of the
    ///event map.
    uint               NameOffset;
    ///Indicates if the map is a value map, bitmap, or pattern map. This member can contain one or more flag values. For
    ///possible values, see the MAP_FLAGS enumeration.
    MAP_FLAGS          Flag;
    ///Number of map entries in <b>MapEntryArray</b>.
    uint               EntryCount;
union
    {
        MAP_VALUETYPE MapEntryValueType;
        uint          FormatStringOffset;
    }
    ///Array of map entries. For details, see the EVENT_MAP_ENTRY structure.
    EVENT_MAP_ENTRY[1] MapEntryArray;
}

///Provides information about a single property of the event or filter.
struct EVENT_PROPERTY_INFO
{
    ///Flags that indicate if the property is contained in a structure or array. For possible values, see the
    ///PROPERTY_FLAGS enumeration.
    PROPERTY_FLAGS Flags;
    ///Offset to a null-terminated Unicode string that contains the name of the property. If this an event property, the
    ///offset is from the beginning of the TRACE_EVENT_INFO structure. If this is a filter property, the offset is from
    ///the beginning of the PROVIDER_FILTER_INFO structure.
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

///Defines the information about the event.
struct TRACE_EVENT_INFO
{
    ///A GUID that identifies the provider.
    GUID             ProviderGuid;
    ///A GUID that identifies the MOF class that contains the event. If the provider uses a manifest to define its
    ///events, this member is GUID_NULL.
    GUID             EventGuid;
    ///A EVENT_DESCRIPTOR structure that describes the event.
    EVENT_DESCRIPTOR EventDescriptor;
    ///A DECODING_SOURCE enumeration value that identifies the source used to parse the event's data (for example, an
    ///instrumenation manifest of WMI MOF class).
    DECODING_SOURCE  DecodingSource;
    ///The offset from the beginning of this structure to a null-terminated Unicode string that contains the name of the
    ///provider.
    uint             ProviderNameOffset;
    ///The offset from the beginning of this structure to a null-terminated Unicode string that contains the name of the
    ///level. For possible names, see Remarks in LevelType.
    uint             LevelNameOffset;
    ///The offset from the beginning of this structure to a null-terminated Unicode string that contains the name of the
    ///channel. For possible names, see Remarks in ChannelType.
    uint             ChannelNameOffset;
    ///The offset from the beginning of this structure to a list of null-terminated Unicode strings that contains the
    ///names of the keywords. The list is terminated with two NULL characters. For possible names, see Remarks in
    ///KeywordType.
    uint             KeywordsNameOffset;
    ///The offset from the beginning of this structure to a null-terminated Unicode string that contains the name of the
    ///task. For possible names, see Remarks in TaskType.
    uint             TaskNameOffset;
    ///The offset from the beginning of this structure to a null-terminated Unicode string that contains the name of the
    ///operation. For possible names, see Remarks in OpcodeType.
    uint             OpcodeNameOffset;
    ///The offset from the beginning of this structure to a null-terminated Unicode string that contains the event
    ///message string. The offset is zero if there is no message string. For information on message strings, see the
    ///<b>message</b> attribute for EventDefinitionType. The message string can contain insert sequences, for example,
    ///Unable to connect to the %1 printer. The number of the insert sequence identifies the property in the event data
    ///to use for the substitution.
    uint             EventMessageOffset;
    ///The offset from the beginning of this structure to a null-terminated Unicode string that contains the localized
    ///provider name.
    uint             ProviderMessageOffset;
    ///Reserved.
    uint             BinaryXMLOffset;
    ///Reserved.
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
    ///The number of elements in the <b>EventPropertyInfoArray</b> array.
    uint             PropertyCount;
    ///The number of properties in the <b>EventPropertyInfoArray</b> array that are top-level properties. This number
    ///does not include members of structures. Top-level properties come before all member properties in the array.
    uint             TopLevelPropertyCount;
union
    {
        TEMPLATE_FLAGS Flags;
struct
        {
            uint _bitfield40;
        }
    }
    ///An array of EVENT_PROPERTY_INFO structures that provides information about each property of the event's user
    ///data.
    EVENT_PROPERTY_INFO[1] EventPropertyInfoArray;
}

///Defines the property to retrieve.
struct PROPERTY_DATA_DESCRIPTOR
{
    ///Pointer to a null-terminated Unicode string that contains the case-sensitive property name. You can use the
    ///<b>NameOffset</b> member of the EVENT_PROPERTY_INFO structure to get the property name. The following table lists
    ///the possible values of <i>PropertyName</i> for WPP events. Use the suggested TDH data type when formatting the
    ///returned buffer from TdhGetProperty. <table> <tr> <th>Name</th> <th>TDH Data Type</th> <th>Description</th> </tr>
    ///<tr> <td>FormattedString</td> <td>TDH_INTYPE_UNICODESTRING</td> <td>The formatted WPP trace message.</td> </tr>
    ///<tr> <td>SequenceNum</td> <td>TDH_INTYPE_UINT32</td> <td>The local or global sequence number of the trace
    ///message. Local sequence numbers, which are unique only to this trace session, are the default.</td> </tr> <tr>
    ///<td>FunctionName</td> <td>TDH_INTYPE_UNICODESTRING</td> <td>The name of the function that generated the trace
    ///message.</td> </tr> <tr> <td>ComponentName</td> <td>TDH_INTYPE_UNICODESTRING</td> <td>The name of the component
    ///of the provider that generated the trace message. The component name appears only if it is specified in the
    ///tracing code.</td> </tr> <tr> <td>SubComponentName</td> <td>TDH_INTYPE_UNICODESTRING</td> <td>The name of the
    ///subcomponent of the provider that generated the trace message. The subcomponent name appears only if it is
    ///specified in the tracing code.</td> </tr> <tr> <td>TraceGuid</td> <td>TDH_INTYPE_GUID</td> <td>The GUID
    ///associated with the WPP trace message.</td> </tr> <tr> <td>GuidTypeName</td> <td>TDH_INTYPE_UNICODESTRING</td>
    ///<td>The file name concatenated with the line number from the source code from which the WPP trace message was
    ///traced.</td> </tr> <tr> <td>SystemTime</td> <td>TDH_INTYPE_SYSTEMTIME</td> <td>The time when the WPP trace
    ///message was generated.</td> </tr> <tr> <td>FlagsName</td> <td>TDH_INTYPE_UNICODESTRING</td> <td>The names of the
    ///trace flags enabling the trace message.</td> </tr> <tr> <td>LevelName</td> <td>TDH_INTYPE_UNICODESTRING</td>
    ///<td>The value of the trace level enabling the trace message.</td> </tr> </table>
    ulong PropertyName;
    ///Zero-based index for accessing elements of a property array. If the property data is not an array or if you want
    ///to address the entire array, specify ULONG_MAX (0xFFFFFFFF).
    uint  ArrayIndex;
    ///Reserved.
    uint  Reserved;
}

///The <b>PAYLOAD_FILTER_PREDICATE</b> structure defines an event payload filter predicate that describes how to filter
///on a single field in a trace session.
struct PAYLOAD_FILTER_PREDICATE
{
    ///The name of the field to filter in package manifest.
    PWSTR  FieldName;
    ///The payload operator to use for the comparison. This member can be one of the values for the
    ///<b>PAYLOAD_OPERATOR</b> enumeration defined in the <i>Tdh.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PAYLOADFIELD_EQ"></a><a id="payloadfield_eq"></a><dl>
    ///<dt><b>PAYLOADFIELD_EQ</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The value of the <b>FieldName</b>
    ///parameter is equal to the numeric value of the string in the <b>Value</b> member. This operator is for comparing
    ///integers and requires one value in the <b>Value</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="PAYLOADFIELD_NE"></a><a id="payloadfield_ne"></a><dl> <dt><b>PAYLOADFIELD_NE</b></dt> <dt>1</dt> </dl> </td>
    ///<td width="60%"> The value of the <b>FieldName</b> parameter is not equal to the numeric value of the string in
    ///the <b>Value</b> member. This operator is for comparing integers and requires one value in the <b>Value</b>
    ///member. </td> </tr> <tr> <td width="40%"><a id="PAYLOADFIELD_LE"></a><a id="payloadfield_le"></a><dl>
    ///<dt><b>PAYLOADFIELD_LE</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The value of the <b>FieldName</b>
    ///parameter is less than or equal to the numeric value of the string in the <b>Value</b> member. This operator is
    ///for comparing integers and requires one value in the <b>Value</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="PAYLOADFIELD_GT"></a><a id="payloadfield_gt"></a><dl> <dt><b>PAYLOADFIELD_GT</b></dt> <dt>3</dt> </dl> </td>
    ///<td width="60%"> The value of the <b>FieldName</b> parameter is greater than the numeric value of the string in
    ///the <b>Value</b> member. This operator is for comparing integers and requires one value in the <b>Value</b>
    ///member. </td> </tr> <tr> <td width="40%"><a id="PAYLOADFIELD_LT"></a><a id="payloadfield_lt"></a><dl>
    ///<dt><b>PAYLOADFIELD_LT</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The value of the <b>FieldName</b>
    ///parameter is less than the numeric value of the string in the <b>Value</b> member. This operator is for comparing
    ///integers and requires one value in the <b>Value</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="PAYLOADFIELD_GE"></a><a id="payloadfield_ge"></a><dl> <dt><b>PAYLOADFIELD_GE</b></dt> <dt>5</dt> </dl> </td>
    ///<td width="60%"> The value of the <b>FieldName</b> parameter is greater than or equal to the numeric value of the
    ///string in the <b>Value</b> member. This operator is for comparing integers and requires one value in the
    ///<b>Value</b> member. </td> </tr> <tr> <td width="40%"><a id="PAYLOADFIELD_BETWEEN"></a><a
    ///id="payloadfield_between"></a><dl> <dt><b>PAYLOADFIELD_BETWEEN</b></dt> <dt>6</dt> </dl> </td> <td width="60%">
    ///The value of the <b>FieldName</b> parameter is between the two numeric values in the string in the <b>Value</b>
    ///member. The <b>PAYLOADFIELD_BETWEEN</b> operator uses a closed interval (LowerBound &lt;= FieldValue &lt;=
    ///UpperBound). This operator is for comparing integers and requires two values in the <b>Value</b> member. The two
    ///values should be separated by a comma character (','). </td> </tr> <tr> <td width="40%"><a
    ///id="PAYLOADFIELD_NOTBETWEEN"></a><a id="payloadfield_notbetween"></a><dl> <dt><b>PAYLOADFIELD_NOTBETWEEN</b></dt>
    ///<dt>7</dt> </dl> </td> <td width="60%"> The value of the <b>FieldName</b> parameter is not between the two
    ///numeric values in the string in the <b>Value</b> member. This operator is for comparing integers and requires two
    ///values in the <b>Value</b> member. The two values should be separated by a comma character (','). </td> </tr>
    ///<tr> <td width="40%"><a id="PAYLOADFIELD_MODULO"></a><a id="payloadfield_modulo"></a><dl>
    ///<dt><b>PAYLOADFIELD_MODULO</b></dt> <dt>8</dt> </dl> </td> <td width="60%"> The value of the <b>FieldName</b>
    ///parameter is the modulo of the numeric value in the string in the <b>Value</b> member. The operator can be used
    ///for periodic sampling. This operator is for comparing integers and requires one value in the <b>Value</b> member.
    ///</td> </tr> <tr> <td width="40%"><a id="PAYLOADFIELD_CONTAINS"></a><a id="payloadfield_contains"></a><dl>
    ///<dt><b>PAYLOADFIELD_CONTAINS</b></dt> <dt>20</dt> </dl> </td> <td width="60%"> The value of the <b>FieldName</b>
    ///parameter contains the substring value in the <b>Value</b> member. String comparisons are case insensitive. This
    ///operator is for comparing strings and requires one value in the <b>Value</b> member. </td> </tr> <tr> <td
    ///width="40%"><a id="PAYLOADFIELD_DOESNTCONTAIN"></a><a id="payloadfield_doesntcontain"></a><dl>
    ///<dt><b>PAYLOADFIELD_DOESNTCONTAIN</b></dt> <dt>21</dt> </dl> </td> <td width="60%"> The value of the
    ///<b>FieldName</b> parameter does not contain the substring in the <b>Value</b> member. String comparisons are case
    ///insensitive. This operator is for comparing strings and requires one value in the <b>Value</b> member. </td>
    ///</tr> <tr> <td width="40%"><a id="PAYLOADFIELD_IS"></a><a id="payloadfield_is"></a><dl>
    ///<dt><b>PAYLOADFIELD_IS</b></dt> <dt>30</dt> </dl> </td> <td width="60%"> The value of the <b>FieldName</b>
    ///parameter is identical to the value of the string in the <b>Value</b> member. String comparisons are case
    ///insensitive. This operator is for comparing strings or other non-integer values and requires one value in the
    ///<b>Value</b> member. </td> </tr> <tr> <td width="40%"><a id="PAYLOADFIELD_ISNOT"></a><a
    ///id="payloadfield_isnot"></a><dl> <dt><b>PAYLOADFIELD_ISNOT</b></dt> <dt>31</dt> </dl> </td> <td width="60%"> The
    ///value of the <b>FieldName</b> parameter is not identical to the value of the string in the <b>Value</b> member.
    ///String comparisons are case insensitive. This operator is for comparing strings or other non-integer values and
    ///requires one value in the <b>Value</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="PAYLOADFIELD_INVALID"></a><a id="payloadfield_invalid"></a><dl> <dt><b>PAYLOADFIELD_INVALID</b></dt>
    ///<dt>32</dt> </dl> </td> <td width="60%"> A value of the payload operator that is not valid. </td> </tr> </table>
    ushort CompareOp;
    ///The string that contains one or values to compare depending on the <b>CompareOp</b> member.
    PWSTR  Value;
}

///Defines a filter and its data.
struct PROVIDER_FILTER_INFO
{
    ///The filter identifier that identifies the filter in the manifest. This is the same value as the <b>value</b>
    ///attribute of the FilterType complex type.
    ubyte Id;
    ///The version number that identifies the version of the filter definition in the manifest. This is the same value
    ///as the <b>version</b> attribute of the FilterType complex type.
    ubyte Version;
    ///Offset from the beginning of this structure to the message string that describes the filter. This is the same
    ///value as the <b>message</b> attribute of the FilterType complex type.
    uint  MessageOffset;
    ///Reserved.
    uint  Reserved;
    ///The number of elements in the <i>EventPropertyInfoArray</i> array.
    uint  PropertyCount;
    ///An array of EVENT_PROPERTY_INFO structures that define the filter data.
    EVENT_PROPERTY_INFO[1] EventPropertyInfoArray;
}

///Defines the field information.
struct PROVIDER_FIELD_INFO
{
    ///Offset to the null-terminated Unicode string that contains the name of the field, in English only.
    uint  NameOffset;
    ///Offset to the null-terminated Unicode string that contains the localized description of the field. The value is
    ///zero if the description does not exist.
    uint  DescriptionOffset;
    ///Field value.
    ulong Value;
}

///Defines metadata information about the requested field.
struct PROVIDER_FIELD_INFOARRAY
{
    ///Number of elements in the <b>FieldInfoArray</b> array.
    uint             NumberOfElements;
    ///Type of field information in the <b>FieldInfoArray</b> array. For possible values, see the EVENT_FIELD_TYPE
    ///enumeration.
    EVENT_FIELD_TYPE FieldType;
    ///Array of PROVIDER_FIELD_INFO structures that define the field's name, description and value.
    PROVIDER_FIELD_INFO[1] FieldInfoArray;
}

///Defines the GUID and name for a provider.
struct TRACE_PROVIDER_INFO
{
    ///GUID that uniquely identifies the provider.
    GUID ProviderGuid;
    ///Is zero if the provider uses a XML manifest to provide a description of its events. Otherwise, the value is 1 if
    ///the provider uses a WMI MOF class to provide a description of its events.
    uint SchemaSource;
    ///Offset to a null-terminated Unicode string that contains the name of the provider. The offset is from the
    ///beginning of the PROVIDER_ENUMERATION_INFO buffer that TdhEnumerateProviders returns.
    uint ProviderNameOffset;
}

///Defines the array of providers that have registered a MOF or manifest on the computer.
struct PROVIDER_ENUMERATION_INFO
{
    ///Number of elements in the <b>TraceProviderInfoArray</b> array.
    uint NumberOfProviders;
    uint Reserved;
    ///Array of TRACE_PROVIDER_INFO structures that contain information about each provider such as its name and unique
    ///identifier.
    TRACE_PROVIDER_INFO[1] TraceProviderInfoArray;
}

///The <b>PROVIDER_EVENT_INFO</b> structure defines an array of events in a provider manifest.
struct PROVIDER_EVENT_INFO
{
    ///The number of elements in the <b>EventDescriptorsArray</b> array.
    uint                NumberOfEvents;
    ///Reserved.
    uint                Reserved;
    ///An array of EVENT_DESCRIPTOR structures that contain information about each event.
    EVENT_DESCRIPTOR[1] EventDescriptorsArray;
}

///Defines the additional information required to parse an event.
struct TDH_CONTEXT
{
    ///Context value cast to a ULONGLONG. The context value is determined by the context type specified in
    ///<b>ParameterType</b>. For example, if the context type is TDH_CONTEXT_WPP_TMFFILE, the context value is a Unicode
    ///string that contains the name of the .tmf file.
    ulong            ParameterValue;
    ///Context type. For a list of types, see the TDH_CONTEXT_TYPE enumeration.
    TDH_CONTEXT_TYPE ParameterType;
    ///Reserved for future use.
    uint             ParameterSize;
}

// Functions

///The <b>StartTrace</b> function registers and starts an event tracing session.
///Params:
///    TraceHandle = Handle to the event tracing session. Do not use this handle if the function fails. Do not compare the session
///                  handle to INVALID_HANDLE_VALUE; the session handle is 0 if the handle is not valid.
///    InstanceName = Null-terminated string that contains the name of the event tracing session. The session name is limited to 1,024
///                   characters, is case-insensitive, and must be unique. <b>Windows 2000: </b>Session names are case-sensitive. As a
///                   result, duplicate session names are allowed. However, to reduce confusion, you should make sure your session
///                   names are unique. This function copies the session name that you provide to the offset that the
///                   <b>LoggerNameOffset</b> member of <i>Properties</i> points to.
///    Properties = Pointer to an EVENT_TRACE_PROPERTIES structure that specifies the behavior of the session. The following are key
///                 members of the structure to set: <ul> <li><b>Wnode.BufferSize</b></li> <li><b>Wnode.Guid</b></li>
///                 <li><b>Wnode.ClientContext</b></li> <li><b>Wnode.Flags</b></li> <li><b>LogFileMode</b></li>
///                 <li><b>LogFileNameOffset</b></li> <li><b>LoggerNameOffset</b></li> </ul> Depending on the type of log file you
///                 choose to create, you may also need to specify a value for <b>MaximumFileSize</b>. See the Remarks section for
///                 more information on setting the <i>Properties</i> parameter and the behavior of the session. <b>Starting with
///                 Windows 10, version 1703: </b>For better performance in cross process scenarios, you can now pass filtering in to
///                 <b>StartTrace</b> when starting system wide private loggers. You will need to pass in the new
///                 EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See Configuring and Starting a Private
///                 Logger Session for more details.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of <i>SessionName</i>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> One of the following is true: <ul> <li><i>Properties</i> is <b>NULL</b>.</li>
///    <li><i>SessionHandle</i> is <b>NULL</b>.</li> <li>The <b>LogFileNameOffset</b> member of <i>Properties</i> is not
///    valid.</li> <li>The <b>LoggerNameOffset</b> member of <i>Properties</i> is not valid.</li> <li>The
///    <b>LogFileMode</b> member of <i>Properties</i> specifies a combination of flags that is not valid.</li> <li>The
///    <b>Wnode.Guid</b> member is <b>SystemTraceControlGuid</b>, but the <i>SessionName</i> parameter is not
///    <b>KERNEL_LOGGER_NAME</b>.<b>Windows 2000: </b>This case does not return an error. </li> </ul> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> A session with the same
///    name or GUID is already running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl>
///    </td> <td width="60%"> You can receive this error for one of the following reasons: <ul> <li>Another session is
///    already using the file name specified by the <b>LogFileNameOffset</b> member of the <i>Properties</i>
///    structure.</li> <li>Both <b>LogFileMode</b> and <b>LogFileNameOffset</b> are zero.</li> </ul> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_DISK_FULL</b></dt> </dl> </td> <td width="60%"> There is not enough free space
///    on the drive for the log file. This occurs if: <ul> <li><b>MaximumFileSize</b> is nonzero and there is not
///    <b>MaximumFileSize</b> bytes available for the log file</li> <li>the drive is a system drive and there is not an
///    additional 200 MB available</li> <li><b>MaximumFileSize</b> is zero and there is not an additional 200 MB
///    available</li> </ul> Choose a drive with more space, or decrease the size specified in <b>MaximumFileSize</b> (if
///    used). <b>Windows 2000: </b>Does not require an additional 200 MB available disk space. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with administrative
///    privileges, users in the Performance Log Users group, and services running as LocalSystem, LocalService,
///    NetworkService can control event tracing sessions. To grant a restricted user the ability to control trace
///    sessions, add them to the Performance Log Users group. Only users with administrative privileges and services
///    running as LocalSystem can control an NT Kernel Logger session. <b>Windows XP and Windows 2000: </b>Anyone can
///    control a trace session. If the user is a member of the Performance Log Users group, they may not have permission
///    to create the log file in the specified folder. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> The maximum number of logging sessions on
///    the system has been reached. No new loggers can be created until a logging session has been stopped. This value
///    defaults to 64 on most systems. You can change this value by editing the <b>REG_DWORD</b> key at
///    <b>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI@EtwMaxLoggers</b>. Permissible values are 32 through
///    256, inclusive. A reboot is required for any change to take effect. Note that Loggers use system resources.
///    Increasing the number of loggers on the system will come at a performance cost if those slots are filled. Prior
///    to Windows 10, version 1709, this is a fixed cap of 64 loggers for non-private loggers. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint StartTraceW(ulong* TraceHandle, const(PWSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>StartTrace</b> function registers and starts an event tracing session.
///Params:
///    TraceHandle = Handle to the event tracing session. Do not use this handle if the function fails. Do not compare the session
///                  handle to INVALID_HANDLE_VALUE; the session handle is 0 if the handle is not valid.
///    InstanceName = Null-terminated string that contains the name of the event tracing session. The session name is limited to 1,024
///                   characters, is case-insensitive, and must be unique. <b>Windows 2000: </b>Session names are case-sensitive. As a
///                   result, duplicate session names are allowed. However, to reduce confusion, you should make sure your session
///                   names are unique. This function copies the session name that you provide to the offset that the
///                   <b>LoggerNameOffset</b> member of <i>Properties</i> points to.
///    Properties = Pointer to an EVENT_TRACE_PROPERTIES structure that specifies the behavior of the session. The following are key
///                 members of the structure to set: <ul> <li><b>Wnode.BufferSize</b></li> <li><b>Wnode.Guid</b></li>
///                 <li><b>Wnode.ClientContext</b></li> <li><b>Wnode.Flags</b></li> <li><b>LogFileMode</b></li>
///                 <li><b>LogFileNameOffset</b></li> <li><b>LoggerNameOffset</b></li> </ul> Depending on the type of log file you
///                 choose to create, you may also need to specify a value for <b>MaximumFileSize</b>. See the Remarks section for
///                 more information on setting the <i>Properties</i> parameter and the behavior of the session. <b>Starting with
///                 Windows 10, version 1703: </b>For better performance in cross process scenarios, you can now pass filtering in to
///                 <b>StartTrace</b> when starting system wide private loggers. You will need to pass in the new
///                 EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See Configuring and Starting a Private
///                 Logger Session for more details.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of <i>SessionName</i>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> One of the following is true: <ul> <li><i>Properties</i> is <b>NULL</b>.</li>
///    <li><i>SessionHandle</i> is <b>NULL</b>.</li> <li>The <b>LogFileNameOffset</b> member of <i>Properties</i> is not
///    valid.</li> <li>The <b>LoggerNameOffset</b> member of <i>Properties</i> is not valid.</li> <li>The
///    <b>LogFileMode</b> member of <i>Properties</i> specifies a combination of flags that is not valid.</li> <li>The
///    <b>Wnode.Guid</b> member is <b>SystemTraceControlGuid</b>, but the <i>SessionName</i> parameter is not
///    <b>KERNEL_LOGGER_NAME</b>.<b>Windows 2000: </b>This case does not return an error. </li> </ul> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> A session with the same
///    name or GUID is already running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl>
///    </td> <td width="60%"> You can receive this error for one of the following reasons: <ul> <li>Another session is
///    already using the file name specified by the <b>LogFileNameOffset</b> member of the <i>Properties</i>
///    structure.</li> <li>Both <b>LogFileMode</b> and <b>LogFileNameOffset</b> are zero.</li> </ul> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_DISK_FULL</b></dt> </dl> </td> <td width="60%"> There is not enough free space
///    on the drive for the log file. This occurs if: <ul> <li><b>MaximumFileSize</b> is nonzero and there is not
///    <b>MaximumFileSize</b> bytes available for the log file</li> <li>the drive is a system drive and there is not an
///    additional 200 MB available</li> <li><b>MaximumFileSize</b> is zero and there is not an additional 200 MB
///    available</li> </ul> Choose a drive with more space, or decrease the size specified in <b>MaximumFileSize</b> (if
///    used). <b>Windows 2000: </b>Does not require an additional 200 MB available disk space. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with administrative
///    privileges, users in the Performance Log Users group, and services running as LocalSystem, LocalService,
///    NetworkService can control event tracing sessions. To grant a restricted user the ability to control trace
///    sessions, add them to the Performance Log Users group. Only users with administrative privileges and services
///    running as LocalSystem can control an NT Kernel Logger session. <b>Windows XP and Windows 2000: </b>Anyone can
///    control a trace session. If the user is a member of the Performance Log Users group, they may not have permission
///    to create the log file in the specified folder. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> The maximum number of logging sessions on
///    the system has been reached. No new loggers can be created until a logging session has been stopped. This value
///    defaults to 64 on most systems. You can change this value by editing the <b>REG_DWORD</b> key at
///    <b>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI@EtwMaxLoggers</b>. Permissible values are 32 through
///    256, inclusive. A reboot is required for any change to take effect. Note that Loggers use system resources.
///    Increasing the number of loggers on the system will come at a performance cost if those slots are filled. Prior
///    to Windows 10, version 1709, this is a fixed cap of 64 loggers for non-private loggers. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint StartTraceA(ulong* TraceHandle, const(PSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>StopTrace</b> function stops the specified event tracing session. The ControlTrace function supersedes this
///function.
///Params:
///    TraceHandle = Handle to the event tracing session that you want to stop, or <b>NULL</b>. You must specify <i>SessionHandle</i>
///                  if <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i> is not <b>NULL</b>.
///                  The handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session that you want to stop,
///                   or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is <b>NULL</b>. To specify the NT
///                   Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an EVENT_TRACE_PROPERTIES structure that receives the final properties and statistics for the session.
///                 If you are using a newly initialized structure, you only need to set the <b>Wnode.BufferSize</b>,
///                 <b>Wnode.Guid</b>, <b>LoggerNameOffset</b>, and <b>LogFileNameOffset</b> members of the structure. You can use
///                 the maximum session name (1024 characters) and maximum log file name (1024 characters) lengths to calculate the
///                 buffer size and offsets if not known. <b>Starting with Windows 10, version 1703: </b>For better performance in
///                 cross process scenarios, you can now pass filtering in to <b>StopTrace</b> for system wide private loggers. You
///                 will need to pass in the new EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See
///                 Configuring and Starting a Private Logger Session for more details.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of the session name and log file name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li><i>SessionName</i> and <i>SessionHandle</i> are both
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> Only users with administrative privileges, users in the Performance Log Users group, and
///    services running as LocalSystem, LocalService, NetworkService can control event tracing sessions. To grant a
///    restricted user the ability to control trace sessions, add them to the Performance Log Users group. <b>Windows XP
///    and Windows 2000: </b>Anyone can control a trace session. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint StopTraceW(ulong TraceHandle, const(PWSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>StopTrace</b> function stops the specified event tracing session. The ControlTrace function supersedes this
///function.
///Params:
///    TraceHandle = Handle to the event tracing session that you want to stop, or <b>NULL</b>. You must specify <i>SessionHandle</i>
///                  if <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i> is not <b>NULL</b>.
///                  The handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session that you want to stop,
///                   or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is <b>NULL</b>. To specify the NT
///                   Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an EVENT_TRACE_PROPERTIES structure that receives the final properties and statistics for the session.
///                 If you are using a newly initialized structure, you only need to set the <b>Wnode.BufferSize</b>,
///                 <b>Wnode.Guid</b>, <b>LoggerNameOffset</b>, and <b>LogFileNameOffset</b> members of the structure. You can use
///                 the maximum session name (1024 characters) and maximum log file name (1024 characters) lengths to calculate the
///                 buffer size and offsets if not known. <b>Starting with Windows 10, version 1703: </b>For better performance in
///                 cross process scenarios, you can now pass filtering in to <b>StopTrace</b> for system wide private loggers. You
///                 will need to pass in the new EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See
///                 Configuring and Starting a Private Logger Session for more details.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of the session name and log file name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li><i>SessionName</i> and <i>SessionHandle</i> are both
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> Only users with administrative privileges, users in the Performance Log Users group, and
///    services running as LocalSystem, LocalService, NetworkService can control event tracing sessions. To grant a
///    restricted user the ability to control trace sessions, add them to the Performance Log Users group. <b>Windows XP
///    and Windows 2000: </b>Anyone can control a trace session. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint StopTraceA(ulong TraceHandle, const(PSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>QueryTrace</b> function retrieves the property settings and session statistics for the specified event tracing
///session. The ControlTrace function supersedes this function.
///Params:
///    TraceHandle = Handle to the event tracing session for whose properties and statistics you want to query, or <b>NULL</b>. You
///                  must specify <i>SessionHandle</i> if <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if
///                  <i>SessionName</i> is not <b>NULL</b>. The handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session whose properties and
///                   statistics you want to query, or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is
///                   <b>NULL</b>. To specify the NT Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. You only need to set the <b>Wnode.BufferSize</b>
///                 member of the EVENT_TRACE_PROPERTIES structure. You can use the maximum session name (1024 characters) and
///                 maximum log file name (1024 characters) lengths to calculate the buffer size and offsets if not known. On output,
///                 the structure members contain the property settings and session statistics for the event tracing session.
///                 <b>Starting with Windows 10, version 1703: </b>For better performance in cross process scenarios, you can now
///                 pass filtering in to <b>QueryTrace</b> for system wide private loggers. You will need to pass in the new
///                 EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See Configuring and Starting a Private
///                 Logger Session for more details.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of the session name and log file name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li><i>SessionName</i> and <i>SessionHandle</i> are both
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> Only users running with elevated administrative privileges, users in the Performance Log Users
///    group, and services running as LocalSystem, LocalService, NetworkService can query event tracing sessions. To
///    grant a restricted user the ability to query trace sessions, add them to the Performance Log Users group or see
///    EventAccessControl. <b>Windows XP and Windows 2000: </b>Anyone can control a trace session. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The given session is
///    not running. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint QueryTraceW(ulong TraceHandle, const(PWSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>QueryTrace</b> function retrieves the property settings and session statistics for the specified event tracing
///session. The ControlTrace function supersedes this function.
///Params:
///    TraceHandle = Handle to the event tracing session for whose properties and statistics you want to query, or <b>NULL</b>. You
///                  must specify <i>SessionHandle</i> if <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if
///                  <i>SessionName</i> is not <b>NULL</b>. The handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session whose properties and
///                   statistics you want to query, or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is
///                   <b>NULL</b>. To specify the NT Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. You only need to set the <b>Wnode.BufferSize</b>
///                 member of the EVENT_TRACE_PROPERTIES structure. You can use the maximum session name (1024 characters) and
///                 maximum log file name (1024 characters) lengths to calculate the buffer size and offsets if not known. On output,
///                 the structure members contain the property settings and session statistics for the event tracing session.
///                 <b>Starting with Windows 10, version 1703: </b>For better performance in cross process scenarios, you can now
///                 pass filtering in to <b>QueryTrace</b> for system wide private loggers. You will need to pass in the new
///                 EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See Configuring and Starting a Private
///                 Logger Session for more details.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of the session name and log file name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li><i>SessionName</i> and <i>SessionHandle</i> are both
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> Only users running with elevated administrative privileges, users in the Performance Log Users
///    group, and services running as LocalSystem, LocalService, NetworkService can query event tracing sessions. To
///    grant a restricted user the ability to query trace sessions, add them to the Performance Log Users group or see
///    EventAccessControl. <b>Windows XP and Windows 2000: </b>Anyone can control a trace session. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The given session is
///    not running. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint QueryTraceA(ulong TraceHandle, const(PSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>UpdateTrace</b> function updates the property setting of the specified event tracing session. The ControlTrace
///function supersedes this function.
///Params:
///    TraceHandle = Handle to the event tracing session to update, or <b>NULL</b>. You must specify <i>SessionHandle</i> if
///                  <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i> is not <b>NULL</b>. The
///                  handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session to update, or
///                   <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is <b>NULL</b>. To specify the NT Kernel
///                   Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. On input, the members must specify the new values for
///                 the properties to update. For information on which properties you can update, see Remarks. On output, the
///                 structure members contains the updated settings and statistics for the event tracing session.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> The <b>BufferSize</b> member of the <b>Wnode</b> member of <i>Properties</i> specifies an incorrect
///    size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    One of the following is true: <ul> <li><i>SessionName</i> and <i>SessionHandle</i> are both <b>NULL</b>.</li>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li>The <b>LogFileNameOffset</b> member of <i>Properties</i> is not
///    valid.</li> <li>The <b>LoggerNameOffset</b> member of <i>Properties</i> is not valid.</li> </ul> <b>Windows
///    Server 2003 and Windows XP: </b>The <b>Guid</b> member of the <b>Wnode</b> structure is SystemTraceControlGuid,
///    but the <i>SessionName</i> parameter is not KERNEL_LOGGER_NAME. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with administrative privileges, users
///    in the Performance Log Users group, and services running as LocalSystem, LocalService, NetworkService can control
///    event tracing sessions. To grant a restricted user the ability to control trace sessions, add them to the
///    Performance Log Users group. <b>Windows XP and Windows 2000: </b>Anyone can control a trace session. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
uint UpdateTraceW(ulong TraceHandle, const(PWSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>UpdateTrace</b> function updates the property setting of the specified event tracing session. The ControlTrace
///function supersedes this function.
///Params:
///    TraceHandle = Handle to the event tracing session to update, or <b>NULL</b>. You must specify <i>SessionHandle</i> if
///                  <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i> is not <b>NULL</b>. The
///                  handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session to update, or
///                   <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is <b>NULL</b>. To specify the NT Kernel
///                   Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. On input, the members must specify the new values for
///                 the properties to update. For information on which properties you can update, see Remarks. On output, the
///                 structure members contains the updated settings and statistics for the event tracing session.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> The <b>BufferSize</b> member of the <b>Wnode</b> member of <i>Properties</i> specifies an incorrect
///    size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    One of the following is true: <ul> <li><i>SessionName</i> and <i>SessionHandle</i> are both <b>NULL</b>.</li>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li>The <b>LogFileNameOffset</b> member of <i>Properties</i> is not
///    valid.</li> <li>The <b>LoggerNameOffset</b> member of <i>Properties</i> is not valid.</li> </ul> <b>Windows
///    Server 2003 and Windows XP: </b>The <b>Guid</b> member of the <b>Wnode</b> structure is SystemTraceControlGuid,
///    but the <i>SessionName</i> parameter is not KERNEL_LOGGER_NAME. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with administrative privileges, users
///    in the Performance Log Users group, and services running as LocalSystem, LocalService, NetworkService can control
///    event tracing sessions. To grant a restricted user the ability to control trace sessions, add them to the
///    Performance Log Users group. <b>Windows XP and Windows 2000: </b>Anyone can control a trace session. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
uint UpdateTraceA(ulong TraceHandle, const(PSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>FlushTrace</b> function causes an event tracing session to immediately deliver buffered events for the
///specified session. (An event tracing session does not deliver events until an active buffer is full.) The
///ControlTrace function supersedes this function.
///Params:
///    TraceHandle = Handle to the event tracing session for whose buffers you want to flush, or <b>NULL</b>. You must specify
///                  <i>SessionHandle</i> if <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i>
///                  is not <b>NULL</b>. The handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session whose buffers you want
///                   to flush, or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is <b>NULL</b>. To specify
///                   the NT Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. If you are using a newly initialized structure, you
///                 only need to set the <b>Wnode.BufferSize</b>, <b>Wnode.Guid</b>, <b>LoggerNameOffset</b>, and
///                 <b>LogFileNameOffset</b> members of the structure. You can use the maximum session name (1024 characters) and
///                 maximum log file name (1024 characters) lengths to calculate the buffer size and offsets if not known. On output,
///                 the structure receives the property settings and session statistics of the event tracing session, which reflect
///                 the state of the session after the flush.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the following is true: <ul> <li><i>Properties</i> is <b>NULL</b>.</li>
///    <li><i>SessionName</i> and <i>SessionHandle</i> are both <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td width="60%"> One of the following is true:
///    <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i> specifies an incorrect size.</li>
///    <li><i>Properties</i> does not have sufficient space allocated to hold a copy of the session name and log file
///    name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> Only users with administrative privileges, users in the Performance Log Users group, and
///    services running as LocalSystem, LocalService, NetworkService can control event tracing sessions. To grant a
///    restricted user the ability to control trace sessions, add them to the Performance Log Users group. <b>Windows XP
///    and Windows 2000: </b>Anyone can control a trace session. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint FlushTraceW(ulong TraceHandle, const(PWSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>FlushTrace</b> function causes an event tracing session to immediately deliver buffered events for the
///specified session. (An event tracing session does not deliver events until an active buffer is full.) The
///ControlTrace function supersedes this function.
///Params:
///    TraceHandle = Handle to the event tracing session for whose buffers you want to flush, or <b>NULL</b>. You must specify
///                  <i>SessionHandle</i> if <i>SessionName</i> is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i>
///                  is not <b>NULL</b>. The handle is returned by the StartTrace function.
///    InstanceName = Pointer to a null-terminated string that specifies the name of the event tracing session whose buffers you want
///                   to flush, or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is <b>NULL</b>. To specify
///                   the NT Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. If you are using a newly initialized structure, you
///                 only need to set the <b>Wnode.BufferSize</b>, <b>Wnode.Guid</b>, <b>LoggerNameOffset</b>, and
///                 <b>LogFileNameOffset</b> members of the structure. You can use the maximum session name (1024 characters) and
///                 maximum log file name (1024 characters) lengths to calculate the buffer size and offsets if not known. On output,
///                 the structure receives the property settings and session statistics of the event tracing session, which reflect
///                 the state of the session after the flush.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the following is true: <ul> <li><i>Properties</i> is <b>NULL</b>.</li>
///    <li><i>SessionName</i> and <i>SessionHandle</i> are both <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td width="60%"> One of the following is true:
///    <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i> specifies an incorrect size.</li>
///    <li><i>Properties</i> does not have sufficient space allocated to hold a copy of the session name and log file
///    name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> Only users with administrative privileges, users in the Performance Log Users group, and
///    services running as LocalSystem, LocalService, NetworkService can control event tracing sessions. To grant a
///    restricted user the ability to control trace sessions, add them to the Performance Log Users group. <b>Windows XP
///    and Windows 2000: </b>Anyone can control a trace session. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint FlushTraceA(ulong TraceHandle, const(PSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties);

///The <b>ControlTrace</b> function flushes, queries, updates, or stops the specified event tracing session.
///Params:
///    TraceHandle = Handle to an event tracing session, or <b>NULL</b>. You must specify <i>SessionHandle</i> if <i>SessionName</i>
///                  is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i> is not <b>NULL</b>. The handle is returned
///                  by the StartTrace function.
///    InstanceName = Name of an event tracing session, or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is
///                   <b>NULL</b>. To specify the NT Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. This structure should be zeroed out before it is
///                 used. If <i>ControlCode</i> specifies <b>EVENT_TRACE_CONTROL_STOP</b>, <b>EVENT_TRACE_CONTROL_QUERY</b> or
///                 <b>EVENT_TRACE_CONTROL_FLUSH</b>, you only need to set the <b>Wnode.BufferSize</b>, <b>Wnode.Guid</b>,
///                 <b>LoggerNameOffset</b>, and <b>LogFileNameOffset</b> members of the EVENT_TRACE_PROPERTIES structure. If the
///                 session is a private session, you also need to set <b>LogFileMode</b>. You can use the maximum session name (1024
///                 characters) and maximum log file name (1024 characters) lengths to calculate the buffer size and offsets if not
///                 known. If <i>ControlCode</i> specifies <b>EVENT_TRACE_CONTROL_UPDATE</b>, on input, the members must specify the
///                 new values for the properties to update. On output, <i>Properties</i> contains the properties and statistics for
///                 the event tracing session. You can update the following properties. <table> <tr> <th>Member</th> <th>Use</th>
///                 </tr> <tr> <td><b>EnableFlags</b></td> <td>Set this member to 0 to disable all kernel providers. Otherwise, you
///                 must specify the kernel providers that you want to enable or keep enabled. Applies only to NT Kernel Logger
///                 sessions.</td> </tr> <tr> <td><b>FlushTimer</b></td> <td>Set this member if you want to change the time to wait
///                 before flushing buffers. If this member is 0, the member is not updated.</td> </tr> <tr>
///                 <td><b>LogFileNameOffset</b></td> <td>Set this member if you want to switch to another log file. If this member
///                 is 0, the file name is not updated. If the offset is not zero and you do not change the log file name, the
///                 function returns an error.</td> </tr> <tr> <td><b>LogFileMode</b></td> <td>Set this member if you want to turn
///                 <b>EVENT_TRACE_REAL_TIME_MODE</b> on and off. To turn real time consuming off, set this member to 0. To turn real
///                 time consuming on, set this member to <b>EVENT_TRACE_REAL_TIME_MODE</b> and it will be OR'd with the current
///                 modes.</td> </tr> <tr> <td><b>MaximumBuffers</b></td> <td>Set this member if you want to change the maximum
///                 number of buffers that ETW uses. If this member is 0, the member is not updated.</td> </tr> </table> For private
///                 logger sessions, you can update only the <b>LogFileNameOffset</b> and <b>FlushTimer</b> members. If you are using
///                 a newly initialized EVENT_TRACE_PROPERTIES structure, the only members you need to specify, other than the
///                 members you are updating, are <b>Wnode.BufferSize</b>, <b>Wnode.Guid</b>, and <b>Wnode.Flags</b>. If you use the
///                 property structure you passed to StartTrace, make sure the <b>LogFileNameOffset</b> member is 0 unless you are
///                 changing the log file name. If you call the <b>ControlTrace</b> function to query the current session properties
///                 and then update those properties to update the session, make sure you set <b>LogFileNameOffset</b> to 0 (unless
///                 you are changing the log file name) and set EVENT_TRACE_PROPERTIES.Wnode.Flags to <b>WNODE_FLAG_TRACED_GUID</b>.
///                 <b>Starting with Windows 10, version 1703: </b>For better performance in cross process scenarios, you can now
///                 pass filtering in to <b>ControlTrace</b> for system wide private loggers. You will need to pass in the new
///                 EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See Configuring and Starting a Private
///                 Logger Session for more details.
///    ControlCode = Requested control function. You can specify one of the following values. <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_CONTROL_FLUSH"></a><a
///                  id="event_trace_control_flush"></a><dl> <dt><b><b>EVENT_TRACE_CONTROL_FLUSH</b></b></dt> </dl> </td> <td
///                  width="60%"> Flushes the session's active buffers. Typically, you do not need to flush buffers yourself. However,
///                  you may want to flush buffers if the event rate is low and you are delivering events in real time. <b>Windows
///                  2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_CONTROL_QUERY"></a><a
///                  id="event_trace_control_query"></a><dl> <dt><b><b>EVENT_TRACE_CONTROL_QUERY</b></b></dt> </dl> </td> <td
///                  width="60%"> Retrieves session properties and statistics. </td> </tr> <tr> <td width="40%"><a
///                  id="EVENT_TRACE_CONTROL_STOP"></a><a id="event_trace_control_stop"></a><dl>
///                  <dt><b><b>EVENT_TRACE_CONTROL_STOP</b></b></dt> </dl> </td> <td width="60%"> Stops the session. The session
///                  handle is no longer valid. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_CONTROL_UPDATE"></a><a
///                  id="event_trace_control_update"></a><dl> <dt><b><b>EVENT_TRACE_CONTROL_UPDATE</b></b></dt> </dl> </td> <td
///                  width="60%"> Updates the session properties. </td> </tr> </table> Note that it is not safe to flush buffers or
///                  stop a trace session from DllMain.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of the session name and log file name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li><i>SessionName</i> and <i>SessionHandle</i> are both
///    <b>NULL</b>.</li> <li>The <b>LogFileNameOffset</b> member of <i>Properties</i> is not valid.</li> <li>The
///    <b>LoggerNameOffset</b> member of <i>Properties</i> is not valid.</li> <li>The <b>LogFileMode</b> member of
///    <i>Properties</i> specifies a combination of flags that is not valid.</li> <li>The <b>Wnode.Guid</b> member of
///    <i>Properties</i> is <b>SystemTraceControlGuid</b>, but the <i>SessionName</i> parameter is not
///    KERNEL_LOGGER_NAME.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl>
///    </td> <td width="60%"> Another session is already using the file name specified by the <b>LogFileNameOffset</b>
///    member of the <i>Properties</i> structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    </dl> </td> <td width="60%"> The buffer for EVENT_TRACE_PROPERTIES is too small to hold all the information for
///    the session. If you do not need the session's property information, you can ignore this error. If you receive
///    this error when stopping the session, ETW will have already stopped the session before generating this error.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only
///    users running with elevated administrative privileges, users in the Performance Log Users group, and services
///    running as LocalSystem, LocalService, NetworkService can control event tracing sessions. To grant a restricted
///    user the ability to control trace sessions, add them to the Performance Log Users group. Only users with
///    administrative privileges and services running as LocalSystem can control an NT Kernel Logger session. <b>Windows
///    XP and Windows 2000: </b>Anyone can control a trace session. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The given session is not running. </td>
///    </tr> </table>
///    
@DllImport("ADVAPI32")
uint ControlTraceW(ulong TraceHandle, const(PWSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties, 
                   uint ControlCode);

///The <b>ControlTrace</b> function flushes, queries, updates, or stops the specified event tracing session.
///Params:
///    TraceHandle = Handle to an event tracing session, or <b>NULL</b>. You must specify <i>SessionHandle</i> if <i>SessionName</i>
///                  is <b>NULL</b>. However, ETW ignores the handle if <i>SessionName</i> is not <b>NULL</b>. The handle is returned
///                  by the StartTrace function.
///    InstanceName = Name of an event tracing session, or <b>NULL</b>. You must specify <i>SessionName</i> if <i>SessionHandle</i> is
///                   <b>NULL</b>. To specify the NT Kernel Logger session, set <i>SessionName</i> to <b>KERNEL_LOGGER_NAME</b>.
///    Properties = Pointer to an initialized EVENT_TRACE_PROPERTIES structure. This structure should be zeroed out before it is
///                 used. If <i>ControlCode</i> specifies <b>EVENT_TRACE_CONTROL_STOP</b>, <b>EVENT_TRACE_CONTROL_QUERY</b> or
///                 <b>EVENT_TRACE_CONTROL_FLUSH</b>, you only need to set the <b>Wnode.BufferSize</b>, <b>Wnode.Guid</b>,
///                 <b>LoggerNameOffset</b>, and <b>LogFileNameOffset</b> members of the EVENT_TRACE_PROPERTIES structure. If the
///                 session is a private session, you also need to set <b>LogFileMode</b>. You can use the maximum session name (1024
///                 characters) and maximum log file name (1024 characters) lengths to calculate the buffer size and offsets if not
///                 known. If <i>ControlCode</i> specifies <b>EVENT_TRACE_CONTROL_UPDATE</b>, on input, the members must specify the
///                 new values for the properties to update. On output, <i>Properties</i> contains the properties and statistics for
///                 the event tracing session. You can update the following properties. <table> <tr> <th>Member</th> <th>Use</th>
///                 </tr> <tr> <td><b>EnableFlags</b></td> <td>Set this member to 0 to disable all kernel providers. Otherwise, you
///                 must specify the kernel providers that you want to enable or keep enabled. Applies only to NT Kernel Logger
///                 sessions.</td> </tr> <tr> <td><b>FlushTimer</b></td> <td>Set this member if you want to change the time to wait
///                 before flushing buffers. If this member is 0, the member is not updated.</td> </tr> <tr>
///                 <td><b>LogFileNameOffset</b></td> <td>Set this member if you want to switch to another log file. If this member
///                 is 0, the file name is not updated. If the offset is not zero and you do not change the log file name, the
///                 function returns an error.</td> </tr> <tr> <td><b>LogFileMode</b></td> <td>Set this member if you want to turn
///                 <b>EVENT_TRACE_REAL_TIME_MODE</b> on and off. To turn real time consuming off, set this member to 0. To turn real
///                 time consuming on, set this member to <b>EVENT_TRACE_REAL_TIME_MODE</b> and it will be OR'd with the current
///                 modes.</td> </tr> <tr> <td><b>MaximumBuffers</b></td> <td>Set this member if you want to change the maximum
///                 number of buffers that ETW uses. If this member is 0, the member is not updated.</td> </tr> </table> For private
///                 logger sessions, you can update only the <b>LogFileNameOffset</b> and <b>FlushTimer</b> members. If you are using
///                 a newly initialized EVENT_TRACE_PROPERTIES structure, the only members you need to specify, other than the
///                 members you are updating, are <b>Wnode.BufferSize</b>, <b>Wnode.Guid</b>, and <b>Wnode.Flags</b>. If you use the
///                 property structure you passed to StartTrace, make sure the <b>LogFileNameOffset</b> member is 0 unless you are
///                 changing the log file name. If you call the <b>ControlTrace</b> function to query the current session properties
///                 and then update those properties to update the session, make sure you set <b>LogFileNameOffset</b> to 0 (unless
///                 you are changing the log file name) and set EVENT_TRACE_PROPERTIES.Wnode.Flags to <b>WNODE_FLAG_TRACED_GUID</b>.
///                 <b>Starting with Windows 10, version 1703: </b>For better performance in cross process scenarios, you can now
///                 pass filtering in to <b>ControlTrace</b> for system wide private loggers. You will need to pass in the new
///                 EVENT_TRACE_PROPERTIES_V2 structure to include filtering information. See Configuring and Starting a Private
///                 Logger Session for more details.
///    ControlCode = Requested control function. You can specify one of the following values. <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_CONTROL_FLUSH"></a><a
///                  id="event_trace_control_flush"></a><dl> <dt><b><b>EVENT_TRACE_CONTROL_FLUSH</b></b></dt> </dl> </td> <td
///                  width="60%"> Flushes the session's active buffers. Typically, you do not need to flush buffers yourself. However,
///                  you may want to flush buffers if the event rate is low and you are delivering events in real time. <b>Windows
///                  2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_CONTROL_QUERY"></a><a
///                  id="event_trace_control_query"></a><dl> <dt><b><b>EVENT_TRACE_CONTROL_QUERY</b></b></dt> </dl> </td> <td
///                  width="60%"> Retrieves session properties and statistics. </td> </tr> <tr> <td width="40%"><a
///                  id="EVENT_TRACE_CONTROL_STOP"></a><a id="event_trace_control_stop"></a><dl>
///                  <dt><b><b>EVENT_TRACE_CONTROL_STOP</b></b></dt> </dl> </td> <td width="60%"> Stops the session. The session
///                  handle is no longer valid. </td> </tr> <tr> <td width="40%"><a id="EVENT_TRACE_CONTROL_UPDATE"></a><a
///                  id="event_trace_control_update"></a><dl> <dt><b><b>EVENT_TRACE_CONTROL_UPDATE</b></b></dt> </dl> </td> <td
///                  width="60%"> Updates the session properties. </td> </tr> </table> Note that it is not safe to flush buffers or
///                  stop a trace session from DllMain.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <b>Wnode.BufferSize</b> member of <i>Properties</i>
///    specifies an incorrect size.</li> <li><i>Properties</i> does not have sufficient space allocated to hold a copy
///    of the session name and log file name (if used).</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>Properties</i> is <b>NULL</b>.</li> <li><i>SessionName</i> and <i>SessionHandle</i> are both
///    <b>NULL</b>.</li> <li>The <b>LogFileNameOffset</b> member of <i>Properties</i> is not valid.</li> <li>The
///    <b>LoggerNameOffset</b> member of <i>Properties</i> is not valid.</li> <li>The <b>LogFileMode</b> member of
///    <i>Properties</i> specifies a combination of flags that is not valid.</li> <li>The <b>Wnode.Guid</b> member of
///    <i>Properties</i> is <b>SystemTraceControlGuid</b>, but the <i>SessionName</i> parameter is not
///    KERNEL_LOGGER_NAME.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl>
///    </td> <td width="60%"> Another session is already using the file name specified by the <b>LogFileNameOffset</b>
///    member of the <i>Properties</i> structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    </dl> </td> <td width="60%"> The buffer for EVENT_TRACE_PROPERTIES is too small to hold all the information for
///    the session. If you do not need the session's property information, you can ignore this error. If you receive
///    this error when stopping the session, ETW will have already stopped the session before generating this error.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only
///    users running with elevated administrative privileges, users in the Performance Log Users group, and services
///    running as LocalSystem, LocalService, NetworkService can control event tracing sessions. To grant a restricted
///    user the ability to control trace sessions, add them to the Performance Log Users group. Only users with
///    administrative privileges and services running as LocalSystem can control an NT Kernel Logger session. <b>Windows
///    XP and Windows 2000: </b>Anyone can control a trace session. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The given session is not running. </td>
///    </tr> </table>
///    
@DllImport("ADVAPI32")
uint ControlTraceA(ulong TraceHandle, const(PSTR) InstanceName, EVENT_TRACE_PROPERTIES* Properties, 
                   uint ControlCode);

///The <b>QueryAllTraces</b> function retrieves the properties and statistics for all event tracing sessions started on
///the computer for which the caller has permissions to query.
///Params:
///    PropertyArray = An array of pointers to EVENT_TRACE_PROPERTIES structures that receive session properties and statistics for the
///                    event tracing sessions. You only need to set the <b>Wnode.BufferSize</b>, <b>LoggerNameOffset</b> , and
///                    <b>LogFileNameOffset</b> members of the EVENT_TRACE_PROPERTIES structure. The other members should all be set to
///                    zero.
///    PropertyArrayCount = Number of structures in the <i>PropertyArray</i> array. This value must be less than or equal to 64, the maximum
///                         number of event tracing sessions that ETW supports.
///    LoggerCount = Actual number of event tracing sessions started on the computer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the following is true: <ul> <li><i>PropertyArrayCount</i> is zero or greater than
///    the maximum number of supported sessions</li> <li><i>PropertyArray</i> is <b>NULL</b></li> </ul> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The property array is too
///    small to receive information for all sessions (<i>SessionCount</i> is greater than <i>PropertyArrayCount</i>).
///    The function fills the property array with the number of property structures specified in
///    <i>PropertyArrayCount</i>. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint QueryAllTracesW(EVENT_TRACE_PROPERTIES** PropertyArray, uint PropertyArrayCount, uint* LoggerCount);

///The <b>QueryAllTraces</b> function retrieves the properties and statistics for all event tracing sessions started on
///the computer for which the caller has permissions to query.
///Params:
///    PropertyArray = An array of pointers to EVENT_TRACE_PROPERTIES structures that receive session properties and statistics for the
///                    event tracing sessions. You only need to set the <b>Wnode.BufferSize</b>, <b>LoggerNameOffset</b> , and
///                    <b>LogFileNameOffset</b> members of the EVENT_TRACE_PROPERTIES structure. The other members should all be set to
///                    zero.
///    PropertyArrayCount = Number of structures in the <i>PropertyArray</i> array. This value must be less than or equal to 64, the maximum
///                         number of event tracing sessions that ETW supports.
///    LoggerCount = Actual number of event tracing sessions started on the computer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the following is true: <ul> <li><i>PropertyArrayCount</i> is zero or greater than
///    the maximum number of supported sessions</li> <li><i>PropertyArray</i> is <b>NULL</b></li> </ul> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The property array is too
///    small to receive information for all sessions (<i>SessionCount</i> is greater than <i>PropertyArrayCount</i>).
///    The function fills the property array with the number of property structures specified in
///    <i>PropertyArrayCount</i>. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint QueryAllTracesA(EVENT_TRACE_PROPERTIES** PropertyArray, uint PropertyArrayCount, uint* LoggerCount);

///Enables or disables the specified classic event trace provider. On Windows Vista and later, call the EnableTraceEx
///function to enable or disable a provider.
///Params:
///    Enable = If <b>TRUE</b>, the provider is enabled; otherwise, the provider is disabled.
///    EnableFlag = Provider-defined value that specifies the class of events for which the provider generates events. A provider
///                 that generates only one class of events will typically ignore this flag. If the provider is more complex, the
///                 provider could use the <i>TraceGuidReg</i> parameter of RegisterTraceGuids to register more than one class of
///                 events. For example, if the provider has a database component, a UI component, and a general processing
///                 component, the provider could register separate event classes for these components. This would then allow the
///                 controller the ability to turn on tracing in only the database component. The provider calls GetTraceEnableFlags
///                 from its ControlCallback function to obtain the enable flags.
///    EnableLevel = Provider-defined value that specifies the level of information the event generates. For example, you can use this
///                  value to indicate the severity level of the events (informational, warning, error) you want the provider to
///                  generate. Specify a value from zero to 255. ETW defines the following severity levels that you can use. Higher
///                  numbers imply that you get lower levels as well. For example, if you specify TRACE_LEVEL_WARNING, you also
///                  receive all warning, error, and fatal events. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="TRACE_LEVEL_CRITICAL"></a><a id="trace_level_critical"></a><dl>
///                  <dt><b>TRACE_LEVEL_CRITICAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Abnormal exit or termination events
///                  </td> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_ERROR"></a><a id="trace_level_error"></a><dl>
///                  <dt><b>TRACE_LEVEL_ERROR</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Severe error events </td> </tr> <tr>
///                  <td width="40%"><a id="TRACE_LEVEL_WARNING"></a><a id="trace_level_warning"></a><dl>
///                  <dt><b>TRACE_LEVEL_WARNING</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Warning events such as allocation
///                  failures </td> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_INFORMATION"></a><a
///                  id="trace_level_information"></a><dl> <dt><b>TRACE_LEVEL_INFORMATION</b></dt> <dt>4</dt> </dl> </td> <td
///                  width="60%"> Non-error events such as entry or exit events </td> </tr> <tr> <td width="40%"><a
///                  id="TRACE_LEVEL_VERBOSE"></a><a id="trace_level_verbose"></a><dl> <dt><b>TRACE_LEVEL_VERBOSE</b></dt> <dt>5</dt>
///                  </dl> </td> <td width="60%"> Detailed trace events </td> </tr> </table>
///    ControlGuid = GUID of the event trace provider that you want to enable or disable.
///    TraceHandle = Handle of the event tracing session to which you want to enable, disable, or change the logging level of the
///                  provider. The StartTrace function returns this handle.
///Returns:
///    If the function is successful, the return value is ERROR_SUCCESS. If the function fails, the return value is one
///    of the system error codes. The following table includes some common errors and their causes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>ControlGuid</i> is <b>NULL</b>.</li> <li><i>SessionHandle</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td width="60%"> You cannot change the
///    enable flags and level when the provider is not registered. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The provider is not registered. Occurs when
///    KB307331 or Windows 2000 Service Pack 4 is installed and the provider is not registered. To avoid this error, the
///    provider must first be registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES
///    </b></dt> </dl> </td> <td width="60%"> Exceeded the number of trace sessions that can enable the provider. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with
///    administrative privileges, users in the Performance Log Users group, and services running as LocalSystem,
///    LocalService, NetworkService can enable trace providers. To grant a restricted user the ability to enable a trace
///    provider, add them to the Performance Log Users group or see EventAccessControl. <b>Windows XP and Windows 2000:
///    </b>Anyone can enable a trace provider. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EnableTrace(uint Enable, uint EnableFlag, uint EnableLevel, GUID* ControlGuid, ulong TraceHandle);

///Enables or disables the specified event trace provider. The EnableTraceEx2 function supersedes this function.
///Params:
///    ProviderId = GUID of the event trace provider that you want to enable or disable.
///    SourceId = GUID that uniquely identifies the session that is enabling or disabling the provider. Can be <b>NULL</b>. If the
///               provider does not implement EnableCallback, the GUID is not used.
///    TraceHandle = Handle of the event tracing session to which you want to enable or disable the provider. The StartTrace function
///                  returns this handle.
///    IsEnabled = Set to 1 to receive events when the provider is registered; otherwise, set to 0 to no longer receive events from
///                the provider.
///    Level = Provider-defined value that specifies the level of detail included in the event. Specify one of the following
///            levels that are defined in Winmeta.h. Higher numbers imply that you get lower levels as well. For example, if you
///            specify TRACE_LEVEL_WARNING, you also receive all warning, error, and critical events. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_CRITICAL"></a><a
///            id="trace_level_critical"></a><dl> <dt><b>TRACE_LEVEL_CRITICAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
///            Abnormal exit or termination events </td> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_ERROR"></a><a
///            id="trace_level_error"></a><dl> <dt><b>TRACE_LEVEL_ERROR</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Severe
///            error events </td> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_WARNING"></a><a
///            id="trace_level_warning"></a><dl> <dt><b>TRACE_LEVEL_WARNING</b></dt> <dt>3</dt> </dl> </td> <td width="60%">
///            Warning events such as allocation failures </td> </tr> <tr> <td width="40%"><a
///            id="TRACE_LEVEL_INFORMATION"></a><a id="trace_level_information"></a><dl> <dt><b>TRACE_LEVEL_INFORMATION</b></dt>
///            <dt>4</dt> </dl> </td> <td width="60%"> Non-error events such as entry or exit events </td> </tr> <tr> <td
///            width="40%"><a id="TRACE_LEVEL_VERBOSE"></a><a id="trace_level_verbose"></a><dl>
///            <dt><b>TRACE_LEVEL_VERBOSE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Detailed trace events </td> </tr>
///            </table>
///    MatchAnyKeyword = Bitmask of keywords that determine the category of events that you want the provider to write. The provider
///                      writes the event if any of the event's keyword bits match any of the bits set in this mask. See Remarks.
///    MatchAllKeyword = This bitmask is optional. This mask further restricts the category of events that you want the provider to write.
///                      If the event's keyword meets the <i>MatchAnyKeyword</i> condition, the provider will write the event only if all
///                      of the bits in this mask exist in the event's keyword. This mask is not used if <i>MatchAnyKeyword</i> is zero.
///                      See Remarks.
///    EnableProperty = Optional information that ETW can include when writing the event. The data is written to the extended data item
///                     section of the event. To include the optional information, specify one or more of the following flags; otherwise,
///                     set to zero. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                     id="EVENT_ENABLE_PROPERTY_SID"></a><a id="event_enable_property_sid"></a><dl>
///                     <dt><b>EVENT_ENABLE_PROPERTY_SID</b></dt> </dl> </td> <td width="60%"> Include the security identifier (SID) of
///                     the user in the extended data. </td> </tr> <tr> <td width="40%"><a id="EVENT_ENABLE_PROPERTY_TS_ID"></a><a
///                     id="event_enable_property_ts_id"></a><dl> <dt><b>EVENT_ENABLE_PROPERTY_TS_ID</b></dt> </dl> </td> <td
///                     width="60%"> Include the terminal session identifier in the extended data. </td> </tr> </table>
///    EnableFilterDesc = An EVENT_FILTER_DESCRIPTOR structure that points to the filter data. The provider uses to filter data to prevent
///                       events that match the filter criteria from being written to the session; the provider determines the layout of
///                       the data and how it applies the filter to the event's data. A session can pass only one filter to the provider. A
///                       session can call the TdhEnumerateProviderFilters function to determine the filters that it can pass to the
///                       provider.
///Returns:
///    If the function is successful, the return value is ERROR_SUCCESS. If the function fails, the return value is one
///    of the system error codes. The following table includes some common errors and their causes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>ProviderId</i> is <b>NULL</b>.</li> <li><i>TraceHandle</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td width="60%"> You cannot update the level
///    when the provider is not registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES
///    </b></dt> </dl> </td> <td width="60%"> Exceeded the number of trace sessions that can enable the provider. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with
///    administrative privileges, users in the Performance Log Users group, and services running as LocalSystem,
///    LocalService, NetworkService can enable trace providers. To grant a restricted user the ability to enable a trace
///    provider, add them to the Performance Log Users group or see EventAccessControl. <b>Windows XP and Windows 2000:
///    </b>Anyone can enable a trace provider. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EnableTraceEx(GUID* ProviderId, GUID* SourceId, ulong TraceHandle, uint IsEnabled, ubyte Level, 
                   ulong MatchAnyKeyword, ulong MatchAllKeyword, uint EnableProperty, 
                   EVENT_FILTER_DESCRIPTOR* EnableFilterDesc);

///The <b>EnableTraceEx2</b> function enables or disables the specified event trace provider. This function supersedes
///the EnableTraceEx function.
///Params:
///    TraceHandle = A handle of the event tracing session to which you want to enable or disable the provider. The StartTrace
///                  function returns this handle.
///    ProviderId = A GUID of the event trace provider that you want to enable or disable.
///    ControlCode = You can specify one of the following control codes: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="EVENT_CONTROL_CODE_DISABLE_PROVIDER"></a><a id="event_control_code_disable_provider"></a><dl>
///                  <dt><b>EVENT_CONTROL_CODE_DISABLE_PROVIDER</b></dt> </dl> </td> <td width="60%"> Disables the provider. </td>
///                  </tr> <tr> <td width="40%"><a id="EVENT_CONTROL_CODE_ENABLE_PROVIDER"></a><a
///                  id="event_control_code_enable_provider"></a><dl> <dt><b>EVENT_CONTROL_CODE_ENABLE_PROVIDER</b></dt> </dl> </td>
///                  <td width="60%"> Enables the provider. The session receives events when the provider is registered. </td> </tr>
///                  <tr> <td width="40%"><a id="EVENT_CONTROL_CODE_CAPTURE_STATE"></a><a
///                  id="event_control_code_capture_state"></a><dl> <dt><b>EVENT_CONTROL_CODE_CAPTURE_STATE</b></dt> </dl> </td> <td
///                  width="60%"> Requests that the provider log its state information. First you would enable the provider and then
///                  call <b>EnableTraceEx2</b> with this control code to capture state information. </td> </tr> </table>
///    Level = A provider-defined value that specifies the level of detail included in the event. Specify one of the following
///            levels that are defined in the <i>Winmeta.h</i> header file. Higher numbers imply that you get lower levels as
///            well. For example, if you specify TRACE_LEVEL_WARNING, you also receive all warning, error, and critical events.
///            <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_CRITICAL"></a><a
///            id="trace_level_critical"></a><dl> <dt><b>TRACE_LEVEL_CRITICAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
///            Abnormal exit or termination events </td> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_ERROR"></a><a
///            id="trace_level_error"></a><dl> <dt><b>TRACE_LEVEL_ERROR</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Severe
///            error events </td> </tr> <tr> <td width="40%"><a id="TRACE_LEVEL_WARNING"></a><a
///            id="trace_level_warning"></a><dl> <dt><b>TRACE_LEVEL_WARNING</b></dt> <dt>3</dt> </dl> </td> <td width="60%">
///            Warning events such as allocation failures </td> </tr> <tr> <td width="40%"><a
///            id="TRACE_LEVEL_INFORMATION"></a><a id="trace_level_information"></a><dl> <dt><b>TRACE_LEVEL_INFORMATION</b></dt>
///            <dt>4</dt> </dl> </td> <td width="60%"> Non-error events such as entry or exit events </td> </tr> <tr> <td
///            width="40%"><a id="TRACE_LEVEL_VERBOSE"></a><a id="trace_level_verbose"></a><dl>
///            <dt><b>TRACE_LEVEL_VERBOSE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Detailed trace events </td> </tr>
///            </table>
///    MatchAnyKeyword = A bitmask of keywords that determine the category of events that you want the provider to write. The provider
///                      writes the event if any of the event's keyword bits match any of the bits set in this mask. See Remarks.
///    MatchAllKeyword = This bitmask is optional. This mask further restricts the category of events that you want the provider to write.
///                      If the event's keyword meets the <i>MatchAnyKeyword</i> condition, the provider will write the event only if all
///                      of the bits in this mask exist in the event's keyword. This mask is not used if <i>MatchAnyKeyword</i> is zero.
///                      See Remarks.
///    Timeout = Set to zero to enable the trace asynchronously; this is the default. If the timeout value is zero, this function
///              calls the provider's enable callback and returns immediately. To enable the trace synchronously, specify a
///              timeout value, in milliseconds. If you specify a timeout value, this function calls the provider's enable
///              callback and waits until the callback exits or the timeout expires. To wait forever, set to INFINITE.
///    EnableParameters = The trace parameters used to enable the provider. For details, see ENABLE_TRACE_PARAMETERS and
///                       ENABLE_TRACE_PARAMETERS_V1.
///Returns:
///    If the function is successful, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value
///    is one of the system error codes. The following table includes some common errors and their causes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This can occur if
///    any of the following are true: <ul> <li>The <i>ProviderId</i> is <b>NULL</b>.</li> <li>The <i>TraceHandle</i> is
///    <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_TIMEOUT</b></dt> </dl> </td> <td
///    width="60%"> The timeout value expired before the enable callback completed. For details, see the <i>Timeout</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td
///    width="60%"> You cannot update the level when the provider is not registered. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES </b></dt> </dl> </td> <td width="60%"> Exceeded the number of trace
///    sessions that can enable the provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt>
///    </dl> </td> <td width="60%"> Only users with administrative privileges, users in the <i>Performance Log Users</i>
///    group, and services running as <i>LocalSystem</i>, <i>LocalService</i>, or <i>NetworkService</i> can enable trace
///    providers. To grant a restricted user the ability to enable a trace provider, add them to the <i>Performance Log
///    Users</i> group or see EventAccessControl. <b>Windows XP and Windows 2000: </b>Anyone can enable a trace
///    provider. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EnableTraceEx2(ulong TraceHandle, GUID* ProviderId, uint ControlCode, ubyte Level, ulong MatchAnyKeyword, 
                    ulong MatchAllKeyword, uint Timeout, ENABLE_TRACE_PARAMETERS* EnableParameters);

///Use this function to retrieve information about trace providers that are registered on the computer.
///Params:
///    TraceQueryInfoClass = Determines the type of information to include with the list of registered providers. For possible values, see the
///                          TRACE_QUERY_INFO_CLASS enumeration.
///    InBuffer = GUID of the provider or provider group whose information you want to retrieve. Specify the GUID only if
///               <i>TraceQueryInfoClass</i> is <b>TraceGuidQueryInfo</b> or <b>TraceGroupQueryInfo</b>.
///    InBufferSize = Size, in bytes, of the data <i>InBuffer</i>.
///    OutBuffer = Application-allocated buffer that contains the enumerated information. The format of the information depends on
///                the value of <i>TraceQueryInfoClass</i>. For details, see Remarks.
///    OutBufferSize = Size, in bytes, of the <i>OutBuffer</i> buffer. If the function succeeds, the <i>ReturnLength</i> parameter
///                    receives the size of the buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER
///                    and the <i>ReturnLength</i> parameter receives the required buffer size. If the buffer size is zero on input, no
///                    data is returned in the buffer and the <i>ReturnLength</i> parameter receives the required buffer size.
///    ReturnLength = Actual size of the data in <i>OutBuffer</i>, in bytes.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The <i>OutBuffer</i> buffer is too small
///    to receive information for all registered providers. Reallocate the buffer using the size returned in
///    <i>ReturnLength</i>. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EnumerateTraceGuidsEx(TRACE_QUERY_INFO_CLASS TraceQueryInfoClass, void* InBuffer, uint InBufferSize, 
                           void* OutBuffer, uint OutBufferSize, uint* ReturnLength);

///The <b>TraceSetInformation</b> function enables or disables event tracing session settings for the specified
///information class.
///Params:
///    SessionHandle = A handle of the event tracing session that wants to capture the specified information. The StartTrace function
///                    returns this handle.
///    InformationClass = The information class to enable or disable. The information that the class captures is included in the extended
///                       data section of the event. For a list of information classes that you can enable, see the TRACE_INFO_CLASS
///                       enumeration.
///    TraceInformation = A pointer to information class specific data; the information class determines the contents of this parameter.
///                       For example, for the <b>TraceStackTracingInfo</b> information class, this parameter is an array of
///                       CLASSIC_EVENT_ID structures. The structures specify the event GUIDs for which stack tracing is enabled. The array
///                       is limited to 256 elements.
///    InformationLength = The size, in bytes, of the data in the <i>TraceInformation</i> buffer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td width="60%"> The program issued a command but the command
///    length is incorrect. This error is returned if the <i>InformationLength</i> parameter is less than a minimum
///    size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    The parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The request is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
uint TraceSetInformation(ulong SessionHandle, TRACE_QUERY_INFO_CLASS InformationClass, void* TraceInformation, 
                         uint InformationLength);

///The <b>TraceQueryInformation</b> function queries event tracing session settings for the specified information class.
///Params:
///    SessionHandle = A handle of the event tracing session that wants to capture the specified information. The StartTrace function
///                    returns this handle.
///    InformationClass = The information class to query. The information that the class captures is included in the extended data section
///                       of the event. For a list of information classes that you can query, see the TRACE_QUERY_INFO_CLASS enumeration.
///    TraceInformation = A pointer to a buffer to receive the returned information class specific data. The information class determines
///                       the contents of this parameter. For example, for the <b>TraceStackTracingInfo</b> information class, this
///                       parameter is an array of CLASSIC_EVENT_ID structures. The structures specify the event GUIDs for which stack
///                       tracing is enabled. The array is limited to 256 elements.
///    InformationLength = The size, in bytes, of the data returned in the <i>TraceInformation</i> buffer. If the function fails, this value
///                        indicates the required size of the <i>TraceInformation</i> buffer that is needed.
///    ReturnLength = A pointer a value that receives the size, in bytes, of the specific data returned in the <i>TraceInformation</i>
///                   buffer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td width="60%"> The program issued a command but the command
///    length is incorrect. This error is returned if the <i>InformationLength</i> parameter is less than a minimum
///    size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    The parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The request is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
uint TraceQueryInformation(ulong SessionHandle, TRACE_QUERY_INFO_CLASS InformationClass, void* TraceInformation, 
                           uint InformationLength, uint* ReturnLength);

///The <b>CreateTraceInstanceId</b> function creates a unique transaction identifier and maps it to a class GUID
///registration handle. You then use the transaction identifier when calling the TraceEventInstance function.
///Params:
///    RegHandle = Handle to a registered event trace class. The RegisterTraceGuids function returns this handle in the
///                <b>RegHandle</b> member of the TRACE_GUID_REGISTRATION structure.
///    InstInfo = Pointer to an EVENT_INSTANCE_INFO structure. The <b>InstanceId</b> member of this structure contains the
///               transaction identifier.
///Returns:
///    If the function is successful, the return value is ERROR_SUCCESS. If the function fails, the return value is one
///    of the system error codes. The following table includes some common errors and their causes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>RegHandle</i> is <b>NULL</b>.</li> <li><i>pInstInfo</i> is <b>NULL</b>.</li> </ul> </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint CreateTraceInstanceId(HANDLE RegHandle, EVENT_INSTANCE_INFO* InstInfo);

///The <b>TraceEvent</b> function sends an event to an event tracing session.
///Params:
///    TraceHandle = Handle to the event tracing session that records the event. The provider obtains the handle when it calls the
///                  GetTraceLoggerHandle function in its ControlCallback implementation.
///    EventTrace = Pointer to an EVENT_TRACE_HEADER structure. Event-specific data is optionally appended to the structure. The
///                 largest event you can log is 64K. You must specify values for the following members of the
///                 <b>EVENT_TRACE_HEADER</b> structure. <ul> <li><b>Size</b></li> <li><b>Guid</b> or <b>GuidPtr</b></li>
///                 <li><b>Flags</b></li> </ul> Depending on the complexity of the information your provider provides, you should
///                 also consider specifying values for the following members. <ul> <li><b>Class.Type</b></li>
///                 <li><b>Class.Level</b></li> </ul>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAG_NUMBER</b></dt> </dl>
///    </td> <td width="60%"> The <b>Flags</b> member of the EVENT_TRACE_HEADER structure is incorrect. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> <i>SessionHandle</i> is
///    not valid or specifies the NT Kernel Logger session handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The session ran out of free buffers to write
///    to. This can occur during high event rates because the disk subsystem is overloaded or the number of buffers is
///    too small. Rather than blocking until more buffers become available, TraceEvent discards the event. Consider
///    increasing the number and size of the buffers for the session, or reducing the number of events written or the
///    size of the events. <b>Windows 2000: </b>Not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The event is discarded because, although the
///    buffer pool has not reached its maximum size, there is insufficient available memory to allocate an additional
///    buffer and there is no buffer available to receive the event. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>SessionHandle</i> is <b>NULL</b>.</li> <li><i>EventTrace</i> is <b>NULL</b>.</li> <li>The <b>Size</b>
///    member of the EVENT_TRACE_HEADER structure is incorrect.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> Data from a single event cannot span multiple
///    buffers. A trace event is limited to the size of the event tracing session's buffer minus the size of the
///    EVENT_TRACE_HEADER structure. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint TraceEvent(ulong TraceHandle, EVENT_TRACE_HEADER* EventTrace);

///The <b>TraceEventInstance</b> function sends an event to an event tracing session. The event uses an instance
///identifier to associate the event with a transaction. This function may also be used to trace hierarchical
///relationships between related events.
///Params:
///    TraceHandle = Handle to the event tracing session that records the event instance. The provider obtains the handle when it
///                  calls the GetTraceLoggerHandle function in its ControlCallback implementation.
///    EventTrace = Pointer to an EVENT_INSTANCE_HEADER structure. Event-specific data is optionally appended to the structure. The
///                 largest event you can log is 64K. You must specify values for the following members of the
///                 <b>EVENT_INSTANCE_HEADER</b> structure. <ul> <li><b>Size</b></li> <li><b>Flags</b></li> <li><b>RegHandle</b></li>
///                 </ul> Depending on the complexity of the information your provider provides, you should also consider specifying
///                 values for the following members. <ul> <li><b>Class.Type</b></li> <li><b>Class.Level</b></li> </ul> To trace
///                 hierarchical relationships between related events, also set the <b>ParentRegHandle</b> member.
///    InstInfo = Pointer to an EVENT_INSTANCE_INFO structure, which contains the registration handle for this event trace class
///               and the instance identifier. Use the CreateTraceInstanceId function to initialize the structure.
///    ParentInstInfo = Pointer to an EVENT_INSTANCE_INFO structure, which contains the registration handle for the parent event trace
///                     class and its instance identifier. Use the CreateTraceInstanceId function to initialize the structure. Set to
///                     <b>NULL</b> if you are not tracing a hierarchical relationship.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td>
///    <td width="60%"> The <b>Flags</b> member of the EVENT_INSTANCE_HEADER does not contain
///    <b>WNODE_FLAG_TRACED_GUID</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There was insufficient memory to complete the function call. The causes for this error
///    code are described in the following Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>EventTrace</i> is <b>NULL</b>.</li> <li><i>pInstInfo</i> is <b>NULL</b>.</li> <li>The members of
///    <i>pInstInfo</i> are <b>NULL</b>.</li> <li><i>SessionHandle</i> is <b>NULL</b>.</li> <li>The <b>Size</b> member
///    of the EVENT_INSTANCE_HEADER is incorrect.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> <i>SessionHandle</i> is not valid or specifies
///    the NT Kernel Logger session handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The session ran out of free buffers to write
///    to. This can occur during high event rates because the disk subsystem is overloaded or the number of buffers is
///    too small. Rather than blocking until more buffers become available, TraceEvent discards the event. <b>Windows
///    2000 and Windows XP: </b>Not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt>
///    </dl> </td> <td width="60%"> The event is discarded because, although the buffer pool has not reached its maximum
///    size, there is insufficient available memory to allocate an additional buffer and there is no buffer available to
///    receive the event. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> Data from a single event cannot span multiple buffers. A trace event is limited to the size of the
///    event tracing session's buffer minus the size of the EVENT_INSTANCE_HEADER structure. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint TraceEventInstance(ulong TraceHandle, EVENT_INSTANCE_HEADER* EventTrace, EVENT_INSTANCE_INFO* InstInfo, 
                        EVENT_INSTANCE_INFO* ParentInstInfo);

///The <b>RegisterTraceGuids</b> function registers an event trace provider and the event trace classes that it uses to
///generate events. This function also specifies the function the provider uses to enable and disable tracing.
///Params:
///    RequestAddress = Pointer to a ControlCallback function that receives notification when the provider is enabled or disabled by an
///                     event tracing session. The EnableTrace function calls the callback.
///    RequestContext = Pointer to an optional provider-defined context that ETW passes to the function specified by
///                     <i>RequestAddress</i>.
///    ControlGuid = GUID of the registering provider.
///    GuidCount = Number of elements in the <i>TraceGuidReg</i> array. If <i>TraceGuidReg</i> is <b>NULL</b>, set this parameter to
///                0.
///    TraceGuidReg = Pointer to an array of TRACE_GUID_REGISTRATION structures. Each element identifies a category of events that the
///                   provider provides. On input, the <b>Guid</b> member of each structure contains an event trace class GUID assigned
///                   by the registering provider. The class GUID identifies a category of events that the provider provides. Providers
///                   use the same class GUID to set the Guid member of EVENT_TRACE_HEADER when calling the TraceEvent function to log
///                   the event. On output, the <b>RegHandle</b> member receives a handle to the event's class GUID registration. If
///                   the provider calls the TraceEventInstance function, use the <b>RegHandle</b> member of TRACE_GUID_REGISTRATION to
///                   set the <b>RegHandle</b> member of EVENT_INSTANCE_HEADER. This parameter can be <b>NULL</b> if the provider calls
///                   only the TraceEvent function to log events. If the provider calls the TraceEventInstance function to log events,
///                   this parameter cannot be <b>NULL</b>.
///    MofImagePath = This parameter is not supported, set to <b>NULL</b>. You should use Mofcomp.exe to register the MOF resource
///                   during the setup of your application. For more information see, Publishing Your Event Schema. <b>Windows XP with
///                   SP1, Windows XP and Windows 2000: </b>Pointer to an optional string that specifies the path of the DLL or
///                   executable program that contains the resource specified by <i>MofResourceName</i>. This parameter can be
///                   <b>NULL</b> if the event provider and consumer use another mechanism to share information about the event trace
///                   classes used by the provider.
///    MofResourceName = This parameter is not supported, set to <b>NULL</b>. You should use Mofcomp.exe to register the MOF resource
///                      during the setup of your application. For more information see, Publishing Your Event Schema. <b>Windows XP with
///                      SP1, Windows XP and Windows 2000: </b>Pointer to an optional string that specifies the string resource of
///                      <i>MofImagePath</i>. The string resource contains the name of the binary MOF file that describes the event trace
///                      classes supported by the provider.
///    RegistrationHandle = Pointer to the provider's registration handle. Use this handle when you call the UnregisterTraceGuids function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes.<div
///    class="alert"><b>Note</b> This function can return the return value from ControlCallback if a controller calls
///    EnableTrace to enable the provider and the provider has not yet called <b>RegisterTraceGuids</b>. When this
///    occurs, <b>RegisterTraceGuids</b> will return the return value of the callback if the registration was
///    successful.</div> <div> </div> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>RequestAddress</i> is <b>NULL</b>.</li> <li><i>ControlGuid</i> is <b>NULL</b>.</li>
///    <li><i>RegistrationHandle</i> is <b>NULL</b>.</li> </ul> <b>Windows XP and Windows 2000: </b><i>TraceGuidReg</i>
///    is <b>NULL</b> or <i>GuidCount</i> is less than or equal to zero. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint RegisterTraceGuidsW(WMIDPREQUEST RequestAddress, void* RequestContext, GUID* ControlGuid, uint GuidCount, 
                         TRACE_GUID_REGISTRATION* TraceGuidReg, const(PWSTR) MofImagePath, 
                         const(PWSTR) MofResourceName, ulong* RegistrationHandle);

///The <b>RegisterTraceGuids</b> function registers an event trace provider and the event trace classes that it uses to
///generate events. This function also specifies the function the provider uses to enable and disable tracing.
///Params:
///    RequestAddress = Pointer to a ControlCallback function that receives notification when the provider is enabled or disabled by an
///                     event tracing session. The EnableTrace function calls the callback.
///    RequestContext = Pointer to an optional provider-defined context that ETW passes to the function specified by
///                     <i>RequestAddress</i>.
///    ControlGuid = GUID of the registering provider.
///    GuidCount = Number of elements in the <i>TraceGuidReg</i> array. If <i>TraceGuidReg</i> is <b>NULL</b>, set this parameter to
///                0.
///    TraceGuidReg = Pointer to an array of TRACE_GUID_REGISTRATION structures. Each element identifies a category of events that the
///                   provider provides. On input, the <b>Guid</b> member of each structure contains an event trace class GUID assigned
///                   by the registering provider. The class GUID identifies a category of events that the provider provides. Providers
///                   use the same class GUID to set the Guid member of EVENT_TRACE_HEADER when calling the TraceEvent function to log
///                   the event. On output, the <b>RegHandle</b> member receives a handle to the event's class GUID registration. If
///                   the provider calls the TraceEventInstance function, use the <b>RegHandle</b> member of TRACE_GUID_REGISTRATION to
///                   set the <b>RegHandle</b> member of EVENT_INSTANCE_HEADER. This parameter can be <b>NULL</b> if the provider calls
///                   only the TraceEvent function to log events. If the provider calls the TraceEventInstance function to log events,
///                   this parameter cannot be <b>NULL</b>.
///    MofImagePath = This parameter is not supported, set to <b>NULL</b>. You should use Mofcomp.exe to register the MOF resource
///                   during the setup of your application. For more information see, Publishing Your Event Schema. <b>Windows XP with
///                   SP1, Windows XP and Windows 2000: </b>Pointer to an optional string that specifies the path of the DLL or
///                   executable program that contains the resource specified by <i>MofResourceName</i>. This parameter can be
///                   <b>NULL</b> if the event provider and consumer use another mechanism to share information about the event trace
///                   classes used by the provider.
///    MofResourceName = This parameter is not supported, set to <b>NULL</b>. You should use Mofcomp.exe to register the MOF resource
///                      during the setup of your application. For more information see, Publishing Your Event Schema. <b>Windows XP with
///                      SP1, Windows XP and Windows 2000: </b>Pointer to an optional string that specifies the string resource of
///                      <i>MofImagePath</i>. The string resource contains the name of the binary MOF file that describes the event trace
///                      classes supported by the provider.
///    RegistrationHandle = Pointer to the provider's registration handle. Use this handle when you call the UnregisterTraceGuids function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes.<div
///    class="alert"><b>Note</b> This function can return the return value from ControlCallback if a controller calls
///    EnableTrace to enable the provider and the provider has not yet called <b>RegisterTraceGuids</b>. When this
///    occurs, <b>RegisterTraceGuids</b> will return the return value of the callback if the registration was
///    successful.</div> <div> </div> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>RequestAddress</i> is <b>NULL</b>.</li> <li><i>ControlGuid</i> is <b>NULL</b>.</li>
///    <li><i>RegistrationHandle</i> is <b>NULL</b>.</li> </ul> <b>Windows XP and Windows 2000: </b><i>TraceGuidReg</i>
///    is <b>NULL</b> or <i>GuidCount</i> is less than or equal to zero. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint RegisterTraceGuidsA(WMIDPREQUEST RequestAddress, void* RequestContext, GUID* ControlGuid, uint GuidCount, 
                         TRACE_GUID_REGISTRATION* TraceGuidReg, const(PSTR) MofImagePath, 
                         const(PSTR) MofResourceName, ulong* RegistrationHandle);

///The <b>EnumerateTraceGuids</b> function retrieves information about registered event trace providers that are running
///on the computer. <div class="alert"><b>Note</b> This function has been superseded by
///EnumerateTraceGuidsEx.</div><div> </div>
///Params:
///    GuidPropertiesArray = An array of pointers to TRACE_GUID_PROPERTIES structures.
///    PropertyArrayCount = Number of elements in the <i>GuidPropertiesArray</i> array.
///    GuidCount = Actual number of event tracing providers registered on the computer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the following is true: <ul> <li><i>PropertyArrayCount</i> is zero</li>
///    <li><i>GuidPropertiesArray</i> is <b>NULL</b></li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The property array is too small to receive
///    information for all registered providers (<i>GuidCount</i> is greater than <i>PropertyArrayCount</i>). The
///    function fills the GUID property array with the number of structures specified in <i>PropertyArrayCount</i>.
///    </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EnumerateTraceGuids(TRACE_GUID_PROPERTIES** GuidPropertiesArray, uint PropertyArrayCount, uint* GuidCount);

///The <b>UnregisterTraceGuids</b> function unregisters an event trace provider and its event trace classes.
///Params:
///    RegistrationHandle = Handle to the event trace provider, obtained from an earlier call to the RegisterTraceGuids function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The <i>RegistrationHandle</i> parameter does not specify the handle to a registered
///    provider or is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint UnregisterTraceGuids(ulong RegistrationHandle);

///The <b>GetTraceLoggerHandle</b> function retrieves the handle of the event tracing session. Providers can only call
///this function from their ControlCallback function.
///Params:
///    Buffer = Pointer to a WNODE_HEADER structure. ETW passes this structure to the provider's ControlCallback function in the
///             <i>Buffer</i> parameter. The <b>HistoricalContext</b> member of WNODE_HEADER contains the session's handle.
///Returns:
///    If the function succeeds, it returns the event tracing session handle. If the function fails, it returns
///    <b>INVALID_HANDLE_VALUE</b>. To get extended error information, call the GetLastError function.
///    
@DllImport("ADVAPI32")
ulong GetTraceLoggerHandle(void* Buffer);

///The <b>GetTraceEnableLevel</b> function retrieves the severity level passed by the controller to indicate the level
///of logging the provider should perform. Providers can only call this function from their ControlCallback function.
///Params:
///    TraceHandle = Handle to an event tracing session, obtained by calling the GetTraceLoggerHandle function.
///Returns:
///    Returns the value the controller specified in the <i>EnableLevel</i> parameter when calling the EnableTrace
///    function. To determine if the function failed or the controller set the enable flags to 0, follow these
///    steps:<ul> <li>Call the SetLastError function to set the last error to <b>ERROR_SUCCESS</b>.</li> <li>Call the
///    <b>GetTraceEnableLevel</b> function to retrieve the enable level.</li> <li>If the enable level value is 0, call
///    the GetLastError function to retrieve the last known error.</li> <li>If the last known error is
///    <b>ERROR_SUCCESS</b>, the controller set the enable level to 0; otherwise, the <b>GetTraceEnableLevel</b>
///    function failed with the last known error. </li> </ul>
///    
@DllImport("ADVAPI32")
ubyte GetTraceEnableLevel(ulong TraceHandle);

///The <b>GetTraceEnableFlags</b> function retrieves the enable flags passed by the controller to indicate which
///category of events to trace. Providers can only call this function from their ControlCallback function.
///Params:
///    TraceHandle = Handle to an event tracing session, obtained by calling the GetTraceLoggerHandle function.
///Returns:
///    Returns the value the controller specified in the <i>EnableFlag</i> parameter when calling the EnableTrace
///    function. To determine if the function failed or the controller set the enable flags to 0, follow these
///    steps:<ul> <li>Call the SetLastError function to set the last error to <b>ERROR_SUCCESS</b>.</li> <li>Call the
///    <b>GetTraceEnableFlags</b> function to retrieve the enable flags.</li> <li>If the enable flags value is 0, call
///    the GetLastError function to retrieve the last known error.</li> <li>If the last known error is
///    <b>ERROR_SUCCESS</b>, the controller set the enable flags to 0; otherwise, the <b>GetTraceEnableFlags</b>
///    function failed with the last known error. </li> </ul>
///    
@DllImport("ADVAPI32")
uint GetTraceEnableFlags(ulong TraceHandle);

///The <b>OpenTrace</b> function opens a real-time trace session or log file for consuming.
///Params:
///    Logfile = Pointer to an EVENT_TRACE_LOGFILE structure. The structure specifies the source from which to consume events
///              (from a log file or the session in real time) and specifies the callbacks the consumer wants to use to receive
///              the events.
///Returns:
///    If the function succeeds, it returns a handle to the trace. If the function fails, it returns
///    INVALID_PROCESSTRACE_HANDLE. <div class="alert"><b>Note</b> <p class="note">If your code base supports Windows 7
///    and Windows Vista, and also supports earlier operating systems such as Windows XP and Windows Server 2003, do not
///    use the constants described above. Instead, determine the operating system on which you are running and compare
///    the return value to the following values. <table> <tr> <th>Operating system</th> <th>Application</th> <th>Return
///    value to compare</th> </tr> <tr> <td>Windows 7 and Windows Vista</td> <td>32-bit</td> <td>0x00000000FFFFFFFF</td>
///    </tr> <tr> <td>Windows 7 and Windows Vista</td> <td>64-bit</td> <td>0XFFFFFFFFFFFFFFFF</td> </tr> <tr>
///    <td>Windows XP and Windows Server 2003</td> <td>32- or 64-bit</td> <td>0XFFFFFFFFFFFFFFFF</td> </tr> </table>
///    </div> <div> </div> If the function returns INVALID_PROCESSTRACE_HANDLE, you can use the GetLastError function to
///    obtain extended error information. The following table lists some common errors and their causes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>Logfile</i> parameter is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl> </td> <td width="60%"> If you did
///    not specify the <b>LoggerName</b> member of EVENT_TRACE_LOGFILE, you must specify a valid log file name. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with
///    administrative privileges, users in the Performance Log Users group, and services running as LocalSystem,
///    LocalService, NetworkService can consume events in real time. To grant a restricted user the ability to consume
///    events in real time, add them to the Performance Log Users group. <b>Windows XP and Windows 2000: </b>Anyone can
///    consume real time events. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
ulong OpenTraceW(EVENT_TRACE_LOGFILEW* Logfile);

///The <b>ProcessTrace</b> function delivers events from one or more event tracing sessions to the consumer.
///Params:
///    HandleArray = Pointer to an array of trace handles obtained from earlier calls to the OpenTrace function. The number of handles
///                  that you can specify is limited to 64. The array can contain the handles to multiple log files, but only one
///                  real-time trace session.
///    HandleCount = Number of elements in <i>HandleArray</i>.
///    StartTime = Pointer to an optional FILETIME structure that specifies the beginning time period for which you want to receive
///                events. The function does not deliver events recorded prior to <i>StartTime</i>.
///    EndTime = Pointer to an optional FILETIME structure that specifies the ending time period for which you want to receive
///              events. The function does not deliver events recorded after <i>EndTime</i>. <b>Windows Server 2003: </b>This
///              value is ignored for real-time event delivery.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt> </dl> </td> <td
///    width="60%"> <i>HandleCount</i> is not valid or the number of handles is greater than 64. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> An element of
///    <i>HandleArray</i> is not a valid event tracing session handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_TIME</b></dt> </dl> </td> <td width="60%"> <i>EndTime</i> is less than <i>StartTime</i>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    <i>HandleArray</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOACCESS</b></dt> </dl>
///    </td> <td width="60%"> An exception occurred in one of the callback functions that receives the events. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> Indicates the
///    consumer canceled processing by returning <b>FALSE</b> in their BufferCallback function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The session from
///    which you are trying to consume events in real time is not running or does not have the real-time trace mode
///    enabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WMI_ALREADY_ENABLED</b></dt> </dl> </td> <td
///    width="60%"> The <i>HandleArray</i> parameter contains the handle to more than one real-time session. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
uint ProcessTrace(ulong* HandleArray, uint HandleCount, FILETIME* StartTime, FILETIME* EndTime);

///The <b>CloseTrace</b> function closes a trace.
///Params:
///    TraceHandle = Handle to the trace to close. The OpenTrace function returns this handle.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> One of the following is true: <ul> <li><i>TraceHandle</i> is <b>NULL</b>.</li>
///    <li><i>TraceHandle</i> is INVALID_HANDLE_VALUE.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td width="60%"> Prior to Windows Vista, you cannot close the trace until
///    the ProcessTrace function completes. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CTX_CLOSE_PENDING</b></dt> </dl> </td> <td width="60%"> The call was successful. The ProcessTrace
///    function will stop after it has processed all real-time events in its buffers (it will not receive any new
///    events). </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint CloseTrace(ulong TraceHandle);

///Queries the system for the trace processing handle.
///Params:
///    ProcessingHandle = A valid handle created with OpenTrace that the data should be queried from.
///    InformationClass = An ETW_PROCESS_HANDLE_INFO_TYPE value that specifies what kind of operation will be done on the handle.
///    InBuffer = Reserved for future use. May be null.
///    InBufferSize = Size in bytes of the <i>InBuffer</i>.
///    OutBuffer = Buffer provided by the caller to contain output data.
///    OutBufferSize = Size in bytes of <i>OutBuffer.</i>
///    ReturnLength = The size in bytes of the data that the API wrote into <i>OutBuffer</i>. Important for variable length returns.
@DllImport("ADVAPI32")
uint QueryTraceProcessingHandle(ulong ProcessingHandle, ETW_PROCESS_HANDLE_INFO_TYPE InformationClass, 
                                void* InBuffer, uint InBufferSize, void* OutBuffer, uint OutBufferSize, 
                                uint* ReturnLength);

///The <b>OpenTrace</b> function opens a real-time trace session or log file for consuming.
///Params:
///    Logfile = Pointer to an EVENT_TRACE_LOGFILE structure. The structure specifies the source from which to consume events
///              (from a log file or the session in real time) and specifies the callbacks the consumer wants to use to receive
///              the events.
///Returns:
///    If the function succeeds, it returns a handle to the trace. If the function fails, it returns
///    INVALID_PROCESSTRACE_HANDLE. <div class="alert"><b>Note</b> <p class="note">If your code base supports Windows 7
///    and Windows Vista, and also supports earlier operating systems such as Windows XP and Windows Server 2003, do not
///    use the constants described above. Instead, determine the operating system on which you are running and compare
///    the return value to the following values. <table> <tr> <th>Operating system</th> <th>Application</th> <th>Return
///    value to compare</th> </tr> <tr> <td>Windows 7 and Windows Vista</td> <td>32-bit</td> <td>0x00000000FFFFFFFF</td>
///    </tr> <tr> <td>Windows 7 and Windows Vista</td> <td>64-bit</td> <td>0XFFFFFFFFFFFFFFFF</td> </tr> <tr>
///    <td>Windows XP and Windows Server 2003</td> <td>32- or 64-bit</td> <td>0XFFFFFFFFFFFFFFFF</td> </tr> </table>
///    </div> <div> </div> If the function returns INVALID_PROCESSTRACE_HANDLE, you can use the GetLastError function to
///    obtain extended error information. The following table lists some common errors and their causes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>Logfile</i> parameter is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl> </td> <td width="60%"> If you did
///    not specify the <b>LoggerName</b> member of EVENT_TRACE_LOGFILE, you must specify a valid log file name. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Only users with
///    administrative privileges, users in the Performance Log Users group, and services running as LocalSystem,
///    LocalService, NetworkService can consume events in real time. To grant a restricted user the ability to consume
///    events in real time, add them to the Performance Log Users group. <b>Windows XP and Windows 2000: </b>Anyone can
///    consume real time events. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
ulong OpenTraceA(EVENT_TRACE_LOGFILEA* Logfile);

///<p class="CCE_Message">[Do not use this function; it may be unavailable in subsequent versions. Instead, filter for
///the event trace class in your EventRecordCallback function.] The <b>SetTraceCallback</b> function specifies an
///EventClassCallback function to process events for the specified event trace class.
///Params:
///    pGuid = Pointer to the class GUID of an event trace class for which you want to receive events. For a list of kernel
///            provider class GUIDs, see NT Kernel Logger Constants.
///    EventCallback = Pointer to an EventClassCallback function used to process events belonging to the event trace class.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the following is true: <ul> <li><i>pGuid</i> is <b>NULL</b>.</li>
///    <li><i>EventCallback</i> is <b>NULL</b>.</li> </ul> </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint SetTraceCallback(GUID* pGuid, PEVENT_CALLBACK EventCallback);

///<p class="CCE_Message">[Do not use this function; it may be unavailable in subsequent versions.] The
///<b>RemoveTraceCallback</b> function stops an EventClassCallback function from receiving events for an event trace
///class.
///Params:
///    pGuid = Pointer to the class GUID of the event trace class for which the callback receives events. Use the same class
///            GUID that you passed to the SetTraceCallback to begin receiving the events.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The <i>pGuid</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> There is no EventClassCallback function
///    associated with the event trace class. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint RemoveTraceCallback(GUID* pGuid);

///The <b>TraceMessage</b> function sends an informational message to an event tracing session.
///Params:
///    LoggerHandle = Handle to the event tracing session that records the event. The provider obtains the handle when it calls the
///                   GetTraceLoggerHandle function in its ControlCallback implementation.
///    MessageFlags = Adds additional information to the beginning of the provider-specific data section of the event. The
///                   provider-specific data section of the event will contain data only for those flags that are set. The variable
///                   list of argument data will follow this information. This parameter can be one or more of the following values.
///                   <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRACE_MESSAGE_COMPONENTID"></a><a
///                   id="trace_message_componentid"></a><dl> <dt><b>TRACE_MESSAGE_COMPONENTID</b></dt> </dl> </td> <td width="60%">
///                   Include the component identifier in the message. The <i>MessageGuid</i> parameter contains the component
///                   identifier. </td> </tr> <tr> <td width="40%"><a id="TRACE_MESSAGE_GUID"></a><a id="trace_message_guid"></a><dl>
///                   <dt><b>TRACE_MESSAGE_GUID</b></dt> </dl> </td> <td width="60%"> Include the event trace class GUID in the
///                   message. The <i>MessageGuid</i> parameter contains the event trace class GUID. </td> </tr> <tr> <td
///                   width="40%"><a id="TRACE_MESSAGE_SEQUENCE"></a><a id="trace_message_sequence"></a><dl>
///                   <dt><b>TRACE_MESSAGE_SEQUENCE</b></dt> </dl> </td> <td width="60%"> Include a sequence number in the message. The
///                   sequence number starts at one. To use this flag, the controller must have set the
///                   <b>EVENT_TRACE_USE_GLOBAL_SEQUENCE</b> or <b>EVENT_TRACE_USE_LOCAL_SEQUENCE</b> log file mode when creating the
///                   session. </td> </tr> <tr> <td width="40%"><a id="TRACE_MESSAGE_SYSTEMINFO"></a><a
///                   id="trace_message_systeminfo"></a><dl> <dt><b>TRACE_MESSAGE_SYSTEMINFO</b></dt> </dl> </td> <td width="60%">
///                   Include the thread identifier and process identifier in the message. </td> </tr> <tr> <td width="40%"><a
///                   id="TRACE_MESSAGE_TIMESTAMP"></a><a id="trace_message_timestamp"></a><dl> <dt><b>TRACE_MESSAGE_TIMESTAMP</b></dt>
///                   </dl> </td> <td width="60%"> Include a time stamp in the message. </td> </tr> </table>
///                   <b>TRACE_MESSAGE_COMPONENTID</b> and <b>TRACE_MESSAGE_GUID</b> are mutually exclusive. The information is
///                   included in the event data in the following order: <ul> <li>Sequence number</li> <li>Event trace class GUID (or
///                   component identifier)</li> <li>Time stamp</li> <li>Thread identifier</li> <li>Process identifier</li> </ul>
///    MessageGuid = Class GUID or component ID that identifies the message. Depends if <i>MessageFlags</i> contains the
///                  <b>TRACE_MESSAGE_COMPONENTID</b> or <b>TRACE_MESSAGE_GUID</b> flag.
///    MessageNumber = Number that uniquely identifies each occurrence of the message. You must define the value specified for this
///                    parameter; the value should be meaningful to the application.
///    arg5 = A list of variable arguments to be appended to the message. Use this list to specify your provider-specific event
///           data. The list must be composed of pairs of arguments, as described in the following table. <table> <tr> <th>Data
///           Type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PVOID"></a><a id="pvoid"></a><dl>
///           <dt><b>PVOID</b></dt> </dl> </td> <td width="60%"> Pointer to the argument data. </td> </tr> <tr> <td
///           width="40%"><a id="size_t"></a><a id="SIZE_T"></a><dl> <dt><b>size_t</b></dt> </dl> </td> <td width="60%"> The
///           size of the argument data, in bytes. </td> </tr> </table> Terminate the list using an argument pair consisting of
///           a pointer to <b>NULL</b> and zero. The caller must ensure that the sum of the sizes of the arguments + 72 does
///           not exceed the size of the event tracing session's buffer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> Either the <i>SessionHandle</i> is <b>NULL</b> or specifies the NT Kernel Logger session handle.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The
///    session ran out of free buffers to write to. This can occur during high event rates because the disk subsystem is
///    overloaded or the number of buffers is too small. Rather than blocking until more buffers become available,
///    TraceMessage discards the event. <b>Windows 2000 and Windows XP: </b>Not supported. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The event is discarded because,
///    although the buffer pool has not reached its maximum size, there is insufficient available memory to allocate an
///    additional buffer and there is no buffer available to receive the event. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>MessageFlags</i> contains a value that is
///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    Data from a single event cannot span multiple buffers. A trace event is limited to the size of the event tracing
///    session's buffer minus the size of the EVENT_TRACE_HEADER structure. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint TraceMessage(ulong LoggerHandle, uint MessageFlags, GUID* MessageGuid, ushort MessageNumber);

///The <b>TraceMessageVa</b> function sends an informational message with variable arguments to an event tracing
///session.
///Params:
///    LoggerHandle = Handle to the event tracing session that records the event. The provider obtains the handle when it calls the
///                   GetTraceLoggerHandle function in its ControlCallback implementation.
///    MessageFlags = Adds additional information to the beginning of the provider-specific data section of the event. The
///                   provider-specific data section of the event will contain data only for those flags that are set. The variable
///                   list of argument data will follow this information. This parameter can be one or more of the following values.
///                   <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRACE_MESSAGE_GUID"></a><a
///                   id="trace_message_guid"></a><dl> <dt><b>TRACE_MESSAGE_GUID</b></dt> </dl> </td> <td width="60%"> Include the
///                   event trace class GUID in the message. The <i>MessageGuid</i> parameter contains the event trace class GUID.
///                   </td> </tr> <tr> <td width="40%"><a id="TRACE_MESSAGE_SEQUENCE"></a><a id="trace_message_sequence"></a><dl>
///                   <dt><b>TRACE_MESSAGE_SEQUENCE</b></dt> </dl> </td> <td width="60%"> Include a sequence number in the message. The
///                   sequence number starts at one. To use this flag, the controller must have set the
///                   <b>EVENT_TRACE_USE_GLOBAL_SEQUENCE</b> or <b>EVENT_TRACE_USE_LOCAL_SEQUENCE</b> log file mode when creating the
///                   session. </td> </tr> <tr> <td width="40%"><a id="TRACE_MESSAGE_SYSTEMINFO"></a><a
///                   id="trace_message_systeminfo"></a><dl> <dt><b>TRACE_MESSAGE_SYSTEMINFO</b></dt> </dl> </td> <td width="60%">
///                   Include the thread identifier and process identifier in the message. </td> </tr> <tr> <td width="40%"><a
///                   id="TRACE_MESSAGE_TIMESTAMP"></a><a id="trace_message_timestamp"></a><dl> <dt><b>TRACE_MESSAGE_TIMESTAMP</b></dt>
///                   </dl> </td> <td width="60%"> Include a time stamp in the message. </td> </tr> </table> The information is
///                   included in the event data in the following order: <ul> <li>Sequence number</li> <li>Event trace class GUID</li>
///                   <li>Time stamp</li> <li>Thread identifier</li> <li>Process identifier</li> </ul>
///    MessageGuid = Class GUID that identifies the event trace message.
///    MessageNumber = Number that uniquely identifies each occurrence of the message. You must define the value specified for this
///                    parameter; the value should be meaningful to the application.
///    MessageArgList = List of variable arguments to be appended to the message. The list must be composed of pairs of arguments, as
///                     described in the following table. <table> <tr> <th>Data Type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                     id="PVOID"></a><a id="pvoid"></a><dl> <dt><b>PVOID</b></dt> </dl> </td> <td width="60%"> Pointer to the argument
///                     data. </td> </tr> <tr> <td width="40%"><a id="size_t"></a><a id="SIZE_T"></a><dl> <dt><b>size_t</b></dt> </dl>
///                     </td> <td width="60%"> The size of the argument data, in bytes. </td> </tr> </table> Terminate the list using an
///                     argument pair consisting of a pointer to <b>NULL</b> and zero. The caller must ensure that the sum of the sizes
///                     of the arguments + 72 does not exceed the size of the event tracing session's buffer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the system error codes. The following table includes some common errors and their causes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> Either the <i>SessionHandle</i> is <b>NULL</b> or specifies the NT Kernel Logger session handle.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The
///    session ran out of free buffers to write to. This can occur during high event rates because the disk subsystem is
///    overloaded or the number of buffers is too small. Rather than blocking until more buffers become available,
///    TraceMessage discards the event. <b>Windows 2000 and Windows XP: </b>Not supported. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The event is discarded because,
///    although the buffer pool has not reached its maximum size, there is insufficient available memory to allocate an
///    additional buffer and there is no buffer available to receive the event. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>MessageFlags</i> contains a value that is
///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    Data from a single event cannot span multiple buffers. A trace event is limited to the size of the event tracing
///    session's buffer minus the size of the EVENT_TRACE_HEADER structure. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint TraceMessageVa(ulong LoggerHandle, uint MessageFlags, GUID* MessageGuid, ushort MessageNumber, 
                    byte* MessageArgList);

///Registers the provider.
///Params:
///    ProviderId = GUID that uniquely identifies the provider.
///    EnableCallback = Callback that ETW calls to notify you when a session enables or disables your provider. Can be <b>NULL</b>.
///    CallbackContext = Provider-defined context data to pass to the callback when the provider is enabled or disabled. Can be
///                      <b>NULL</b>.
///    RegHandle = Registration handle. The handle is used by most provider function calls. Before your provider exits, you must
///                pass this handle to EventUnregister to free the handle.
///Returns:
///    Returns ERROR_SUCCESS if successful.
///    
@DllImport("ADVAPI32")
uint EventRegister(GUID* ProviderId, PENABLECALLBACK EnableCallback, void* CallbackContext, ulong* RegHandle);

///Removes the provider's registration. You must call this function before your process exits.
///Params:
///    RegHandle = Registration handle returned by EventRegister.
///Returns:
///    Returns ERROR_SUCCESS if successful.
///    
@DllImport("ADVAPI32")
uint EventUnregister(ulong RegHandle);

///Performs operations on a registration object.
///Params:
///    RegHandle = Type: <b>REGHANDLE</b> Registration handle returned by EventRegister.
///    InformationClass = Type: <b>EVENT_INFO_CLASS</b> Type of operation to be performed on the registration object.
///    EventInformation = Type: <b>PVOID</b> The input buffer.
///    InformationLength = Type: <b>ULONG</b> Size of the input buffer.
///Returns:
///    Type: <b>ULONG</b> If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter is
///    incorrect. This error is returned if the <i>RegHandle</i> parameter is not a valid registration handle. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is
///    not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EventSetInformation(ulong RegHandle, EVENT_INFO_CLASS InformationClass, void* EventInformation, 
                         uint InformationLength);

///Determines if the event is enabled for any session.
///Params:
///    RegHandle = Registration handle of the provider. The handle comes from EventRegister. <div class="alert"><b>Note</b> A valid
///                registration handle must be used.</div> <div> </div>
///    EventDescriptor = Describes the event. For details, see EVENT_DESCRIPTOR.
///Returns:
///    Returns <b>TRUE</b> if the event is enabled for a session; otherwise, <b>FALSE</b>.
///    
@DllImport("ADVAPI32")
ubyte EventEnabled(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor);

///Determines if the event is enabled for any session.
///Params:
///    RegHandle = Registration handle of the provider. The handle comes from EventRegister.
///    Level = Level of detail included in the event. Specify one of the following levels that are defined in Winmeta.h. Higher
///            numbers imply that you get lower levels as well. For example, if you specify TRACE_LEVEL_WARNING, you also
///            receive all warning, error, and fatal events. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="WINEVENT_LEVEL_CRITICAL"></a><a id="winevent_level_critical"></a><dl>
///            <dt><b>WINEVENT_LEVEL_CRITICAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Abnormal exit or termination
///            events. </td> </tr> <tr> <td width="40%"><a id="WINEVENT_LEVEL_ERROR"></a><a id="winevent_level_error"></a><dl>
///            <dt><b>WINEVENT_LEVEL_ERROR</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Severe error events. </td> </tr>
///            <tr> <td width="40%"><a id="WINEVENT_LEVEL_WARNING"></a><a id="winevent_level_warning"></a><dl>
///            <dt><b>WINEVENT_LEVEL_WARNING</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Warning events such as allocation
///            failures. </td> </tr> <tr> <td width="40%"><a id="WINEVENT_LEVEL_INFO"></a><a id="winevent_level_info"></a><dl>
///            <dt><b>WINEVENT_LEVEL_INFO</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Non-error events such as entry or
///            exit events. </td> </tr> <tr> <td width="40%"><a id="WINEVENT_LEVEL_VERBOSE"></a><a
///            id="winevent_level_verbose"></a><dl> <dt><b>WINEVENT_LEVEL_VERBOSE</b></dt> <dt>5</dt> </dl> </td> <td
///            width="60%"> Detailed trace events. </td> </tr> </table>
///    Keyword = Bitmask that specifies the event category. This mask should be the same keyword mask that you defined in the
///              manifest for the event.
///Returns:
///    Returns <b>TRUE</b> if the event is enabled for a session; otherwise, returns <b>FALSE</b>.
///    
@DllImport("ADVAPI32")
ubyte EventProviderEnabled(ulong RegHandle, ubyte Level, ulong Keyword);

///Use this function to write an event.
///Params:
///    RegHandle = Registration handle of the provider. The handle comes from EventRegister.
///    EventDescriptor = Metadata that identifies the event to write. For details, see EVENT_DESCRIPTOR.
///    UserDataCount = Number of EVENT_DATA_DESCRIPTOR structures in <i>UserData</i>. The maximum number is 128.
///    UserData = The event data to write. Allocate a block of memory that contains one or more EVENT_DATA_DESCRIPTOR structures.
///               Set this parameter to <b>NULL</b> if <i>UserDataCount</i> is zero. The data must be in the order specified in the
///               manifest.
///Returns:
///    Returns ERROR_SUCCESS if successful or one of the following values on error. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The registration handle of the provider is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ARITHMETIC_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> The event size is larger than the allowed maximum (64k - header). </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The session buffer size is too small for the
///    event. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Occurs when filled buffers are trying to flush to disk, but disk IOs are not happening fast enough.
///    This happens when the disk is slow and event traffic is heavy. Eventually, there are no more free (empty) buffers
///    and the event is dropped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOACCESS</b></dt> </dl> </td> <td
///    width="60%"> <i>UserData</i> points to an invalid memory location or the memory is not correctly aligned. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_LOG_FILE_FULL</b></dt> </dl> </td> <td width="60%"> The real-time
///    playback file is full. Events are not logged to the session until a real-time consumer consumes the events from
///    the playback file. Do not stop logging events based on this error code. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EventWrite(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, uint UserDataCount, 
                EVENT_DATA_DESCRIPTOR* UserData);

///Links events together when tracing events in an end-to-end scenario.
///Params:
///    RegHandle = Registration handle of the provider. The handle comes from EventRegister.
///    EventDescriptor = Metadata that identifies the event to write. For details, see EVENT_DESCRIPTOR.
///    ActivityId = GUID that uniquely identifies this activity. If <b>NULL</b>, ETW gets the identifier from the thread local
///                 storage. For details on getting this identifier, see EventActivityIdControl.
///    RelatedActivityId = Activity identifier from the previous component. Use this parameter to link your component's events to the
///                        previous component's events. To get the activity identifier that was set for the previous component, see the
///                        descriptions for the <i>ControlCode</i> parameter of the EventActivityIdControl function.
///    UserDataCount = Number of EVENT_DATA_DESCRIPTOR structures in <i>UserData</i>. The maximum number is 128.
///    UserData = The event data to write. Allocate a block of memory that contains one or more EVENT_DATA_DESCRIPTOR structures.
///               Set this parameter to <b>NULL</b> if <i>UserDataCount</i> is zero. The data must be in the order specified in the
///               manifest.
///Returns:
///    Returns ERROR_SUCCESS if successful or one of the following values on error. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The registration handle of the provider is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ARITHMETIC_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> The event size is larger than the allowed maximum (64k - header). </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The session buffer size is too small for the
///    event. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Occurs when filled buffers are trying to flush to disk, but disk IOs are not happening fast enough.
///    This happens when the disk is slow and event traffic is heavy. Eventually, there are no more free (empty) buffers
///    and the event is dropped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_LOG_FILE_FULL</b></dt> </dl> </td>
///    <td width="60%"> The real-time playback file is full. Events are not logged to the session until a real-time
///    consumer consumes the events from the playback file. Do not stop logging events based on this error code. </td>
///    </tr> </table>
///    
@DllImport("ADVAPI32")
uint EventWriteTransfer(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, GUID* ActivityId, 
                        GUID* RelatedActivityId, uint UserDataCount, EVENT_DATA_DESCRIPTOR* UserData);

///Use this function to write an event.
///Params:
///    RegHandle = Registration handle of the provider. The handle comes from EventRegister.
///    EventDescriptor = A descriptor that contains the metadata that identifies the event to write. For details, see EVENT_DESCRIPTOR.
///    Filter = The instance identifiers that identify the session to which the event will not written. Use a bitwise OR to
///             specify multiple identifiers. Set to zero if you do not support filters or if the event is being written to all
///             sessions (no filters failed). For information on getting the identifier for a session, see the <i>FilterData</i>
///             parameter of your EnableCallback callback.
///    Flags = Reserved. Must be zero.
///    ActivityId = GUID that uniquely identifies this activity. If <b>NULL</b>, ETW gets the identifier from the thread local
///                 storage. For details on getting this identifier, see EventActivityIdControl.
///    RelatedActivityId = Activity identifier from the previous component. Use this parameter to link your component's events to the
///                        previous component's events. To get the activity identifier that was set for the previous component, see the
///                        descriptions for the <i>ControlCode</i> parameter of the EventActivityIdControl function.
///    UserDataCount = Number of EVENT_DATA_DESCRIPTOR structures in <i>UserData</i>. The maximum number is 128.
///    UserData = The event data to write. Allocate a block of memory that contains one or more EVENT_DATA_DESCRIPTOR structures.
///               Set this parameter to <b>NULL</b> if <i>UserDataCount</i> is zero. The data must be in the order specified in the
///               manifest.
///Returns:
///    Returns ERROR_SUCCESS if successful or one of the following values on error. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The registration handle of the provider is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ARITHMETIC_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> The event size is larger than the allowed maximum (64k - header). </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The session buffer size is too small for the
///    event. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Occurs when filled buffers are trying to flush to disk, but disk IOs are not happening fast enough.
///    This happens when the disk is slow and event traffic is heavy. Eventually, there are no more free (empty) buffers
///    and the event is dropped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_LOG_FILE_FULL</b></dt> </dl> </td>
///    <td width="60%"> The real-time playback file is full. Events are not logged to the session until a real-time
///    consumer consumes the events from the playback file. Do not stop logging events based on this error code. </td>
///    </tr> </table>
///    
@DllImport("ADVAPI32")
uint EventWriteEx(ulong RegHandle, EVENT_DESCRIPTOR* EventDescriptor, ulong Filter, uint Flags, GUID* ActivityId, 
                  GUID* RelatedActivityId, uint UserDataCount, EVENT_DATA_DESCRIPTOR* UserData);

///Writes an event that contains a string as its data.
///Params:
///    RegHandle = Registration handle of the provider. The handle comes from EventRegister.
///    Level = Level of detail included in the event. If the provider uses a manifest to define the event, set this value to the
///            same level defined in the manifest. If the event is not defined in a manifest, set this value to 0 to ensure the
///            event is written, otherwise, the event is written based on the level rule defined in EnableTraceEx.
///    Keyword = Bitmask that specifies the event category. If the provider uses a manifest to define the event, set this value to
///              the same keyword mask defined in the manifest. If the event is not defined in a manifest, set this value to 0 to
///              ensure the event is written, otherwise, the event is written based on the keyword rules defined in EnableTraceEx.
///    String = Null-terminated string to write as the event data.
///Returns:
///    Returns ERROR_SUCCESS if successful or one of the following values on error. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The registration handle of the provider is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ARITHMETIC_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> The event size is larger than the allowed maximum (64k - header). </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The session buffer size is too small for the
///    event. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Occurs when filled buffers are trying to flush to disk, but disk IOs are not happening fast enough.
///    This happens when the disk is slow and event traffic is heavy. Eventually, there are no more free (empty) buffers
///    and the event is dropped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_LOG_FILE_FULL</b></dt> </dl> </td>
///    <td width="60%"> The real-time playback file is full. Events are not logged to the session until a real-time
///    consumer consumes the events from the playback file. Do not stop logging events based on this error code. </td>
///    </tr> </table>
///    
@DllImport("ADVAPI32")
uint EventWriteString(ulong RegHandle, ubyte Level, ulong Keyword, const(PWSTR) String);

///Creates, queries, and sets the current activity identifier used by the EventWriteTransfer function.
///Params:
///    ControlCode = A control code that specifies if you want to create, query or set the current activity identifier. You can
///                  specify one of the following codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="EVENT_ACTIVITY_CTRL_GET_ID"></a><a id="event_activity_ctrl_get_id"></a><dl>
///                  <dt><b>EVENT_ACTIVITY_CTRL_GET_ID</b></dt> </dl> </td> <td width="60%"> Sets the <i>ActivityId</i> parameter to
///                  the current identifier value from thread local storage. </td> </tr> <tr> <td width="40%"><a
///                  id="EVENT_ACTIVITY_CTRL_SET_ID"></a><a id="event_activity_ctrl_set_id"></a><dl>
///                  <dt><b>EVENT_ACTIVITY_CTRL_SET_ID</b></dt> </dl> </td> <td width="60%"> Uses the identifier in the
///                  <i>ActivityId</i> parameter to set the value of the current identifier in the thread local storage. </td> </tr>
///                  <tr> <td width="40%"><a id="EVENT_ACTIVITY_CTRL_CREATE_ID"></a><a id="event_activity_ctrl_create_id"></a><dl>
///                  <dt><b>EVENT_ACTIVITY_CTRL_CREATE_ID</b></dt> </dl> </td> <td width="60%"> Creates a new identifier and sets the
///                  <i>ActivityId</i> parameter to the value of the new identifier. </td> </tr> <tr> <td width="40%"><a
///                  id="EVENT_ACTIVITY_CTRL_GET_SET_ID"></a><a id="event_activity_ctrl_get_set_id"></a><dl>
///                  <dt><b>EVENT_ACTIVITY_CTRL_GET_SET_ID</b></dt> </dl> </td> <td width="60%"> Performs the following: <ul>
///                  <li>Copies the current identifier from thread local storage.</li> <li>Sets the current identifier in thread local
///                  storage to the new identifier specified in the <i>ActivityId</i> parameter.</li> <li>Sets the <i>ActivityId</i>
///                  parameter to the copy of the previous current identifier.</li> </ul> </td> </tr> <tr> <td width="40%"><a
///                  id="EVENT_ACTIVITY_CTRL_CREATE_SET_ID"></a><a id="event_activity_ctrl_create_set_id"></a><dl>
///                  <dt><b>EVENT_ACTIVITY_CTRL_CREATE_SET_ID</b></dt> </dl> </td> <td width="60%"> Performs the following: <ul>
///                  <li>Copies the current identifier from thread local storage.</li> <li>Creates a new identifier and sets the
///                  current identifier in thread local storage to the new identifier.</li> <li>Sets the <i>ActivityId</i> parameter
///                  to the copy of the previous current identifier.</li> </ul> </td> </tr> </table>
///    ActivityId = A GUID that uniquely identifies the activity. To determine when this parameter is an input parameter, an output
///                 parameter or both, see the descriptions for the <i>ControlCodes</i> parameter.
///Returns:
///    Returns ERROR_SUCCESS if successful.
///    
@DllImport("ADVAPI32")
uint EventActivityIdControl(uint ControlCode, GUID* ActivityId);

///Adds or modifies the permissions of the specified provider or session.
///Params:
///    Guid = GUID that uniquely identifies the provider or session whose permissions you want to add or modify.
///    Operation = Type of operation to perform, for example, add a DACL to the session's GUID or provider's GUID. For possible
///                values, see the EVENTSECURITYOPERATION enumeration.
///    Sid = The security identifier (SID) of the user or group to whom you want to grant or deny permissions.
///    Rights = You can specify one or more of the following permissions: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///             <td width="40%"><a id="WMIGUID_QUERY"></a><a id="wmiguid_query"></a><dl> <dt><b>WMIGUID_QUERY</b></dt> </dl>
///             </td> <td width="60%"> Allows the user to query information about the trace session. Set this permission on the
///             session's GUID. </td> </tr> <tr> <td width="40%"><a id="TRACELOG_CREATE_REALTIME"></a><a
///             id="tracelog_create_realtime"></a><dl> <dt><b>TRACELOG_CREATE_REALTIME</b></dt> </dl> </td> <td width="60%">
///             Allows the user to start or update a real-time session. Set this permission on the session's GUID. </td> </tr>
///             <tr> <td width="40%"><a id="TRACELOG_CREATE_ONDISK"></a><a id="tracelog_create_ondisk"></a><dl>
///             <dt><b>TRACELOG_CREATE_ONDISK</b></dt> </dl> </td> <td width="60%"> Allows the user to start or update a session
///             that writes events to a log file. Set this permission on the session's GUID. </td> </tr> <tr> <td width="40%"><a
///             id="TRACELOG_GUID_ENABLE"></a><a id="tracelog_guid_enable"></a><dl> <dt><b>TRACELOG_GUID_ENABLE</b></dt> </dl>
///             </td> <td width="60%"> Allows the user to enable the provider. Set this permission on the provider's GUID. </td>
///             </tr> <tr> <td width="40%"><a id="TRACELOG_ACCESS_KERNEL_LOGGER"></a><a
///             id="tracelog_access_kernel_logger"></a><dl> <dt><b>TRACELOG_ACCESS_KERNEL_LOGGER</b></dt> </dl> </td> <td
///             width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a id="TRACELOG_LOG_EVENT"></a><a
///             id="tracelog_log_event"></a><dl> <dt><b>TRACELOG_LOG_EVENT</b></dt> </dl> </td> <td width="60%"> Allows the user
///             to log events to a trace session if session is running in SECURE mode (the session set the
///             EVENT_TRACE_SECURE_MODE flag in the LogFileMode member of EVENT_TRACE_PROPERTIES). </td> </tr> <tr> <td
///             width="40%"><a id="TRACELOG_ACCESS_REALTIME"></a><a id="tracelog_access_realtime"></a><dl>
///             <dt><b>TRACELOG_ACCESS_REALTIME</b></dt> </dl> </td> <td width="60%"> Allows a user to consume events in
///             real-time. Set this permission on the session's GUID. </td> </tr> <tr> <td width="40%"><a
///             id="TRACELOG_REGISTER_GUIDS"></a><a id="tracelog_register_guids"></a><dl> <dt><b>TRACELOG_REGISTER_GUIDS</b></dt>
///             </dl> </td> <td width="60%"> Allows the user to register the provider. Set this permission on the provider's
///             GUID. </td> </tr> </table>
///    AllowOrDeny = If <b>TRUE</b>, grant the user permissions to the session or provider; otherwise, deny permissions. This value is
///                  ignored if the value of <i>Operation</i> is EventSecuritySetSACL or EventSecurityAddSACL.
///Returns:
///    Returns ERROR_SUCCESS if successful.
///    
@DllImport("ADVAPI32")
uint EventAccessControl(GUID* Guid, uint Operation, void* Sid, uint Rights, ubyte AllowOrDeny);

///Retrieves the permissions for the specified controller or provider.
///Params:
///    Guid = GUID that uniquely identifies the provider or session.
///    Buffer = Application-allocated buffer that will contain the security descriptor of the controller or provider.
///    BufferSize = Size of the security descriptor buffer, in bytes. If the function succeeds, this parameter receives the size of
///                 the buffer used. If the buffer is too small, the function returns ERROR_MORE_DATA and this parameter receives the
///                 required buffer size. If the buffer size is zero on input, no data is returned in the buffer and this parameter
///                 receives the required buffer size.
///Returns:
///    Returns ERROR_SUCCESS if successful. The function returns the following return code if an error occurs: <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    </dl> </td> <td width="60%"> The buffer is too small to receive the security descriptor. Reallocate the buffer
///    using the size returned in <i>BufferSize</i>. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint EventAccessQuery(GUID* Guid, void* Buffer, uint* BufferSize);

///Removes the permissions defined in the registry for the specified provider or session.
///Params:
///    Guid = GUID that uniquely identifies the provider or session whose permissions you want to remove from the registry.
///Returns:
///    Returns ERROR_SUCCESS if successful.
///    
@DllImport("ADVAPI32")
uint EventAccessRemove(GUID* Guid);

///The <b>TdhCreatePayloadFilter</b> function creates a single filter for a single payload to be used with the
///EnableTraceEx2 function.
///Params:
///    ProviderGuid = A GUID that identifies the manifest provider of the <i>EventDescriptor</i> parameter.
///    EventDescriptor = A pointer to the event descriptor whose payload will be filtered.
///    EventMatchANY = A Boolean value that indicates how events are handled when multiple conditions are specified. When this parameter
///                    is <b>TRUE</b>, an event will be written to a session if any of the specified conditions specified in the filter
///                    are <b>TRUE</b>. When this parameter is <b>FALSE</b>, an event will be written to a session only if all of the
///                    specified conditions specified in the filter are <b>TRUE</b>.
///    PayloadPredicateCount = The number of conditions specified in the filter. This value must be less than or equal to the
///                            <b>ETW_MAX_PAYLOAD_PREDICATES</b> constant defined in the <i>Tdh.h</i> header file.
///    PayloadPredicates = A pointer to an array of PAYLOAD_FILTER_PREDICATE structures that contain the list conditions that the filter
///                        specifies.
///    PayloadFilter = On success, this parameter returns a pointer to a single payload filter that is properly sized and built for the
///                    specified conditions. When the caller is finished using the returned payload filter with the EnableTraceEx2
///                    function, the TdhDeletePayloadFilter function should be called to free the allocated memory.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The metadata for the provider was not found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One
///    or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The resulting payload filter would not fit
///    within the <b>MAX_EVENT_FILTER_PAYLOAD_SIZE</b> limit imposed by the EnableTraceEx2 function on the
///    EVENT_FILTER_DESCRIPTOR structures in a payload. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to create the
///    payload filter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The schema information for supplied provider GUID was not found. </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhCreatePayloadFilter(GUID* ProviderGuid, EVENT_DESCRIPTOR* EventDescriptor, ubyte EventMatchANY, 
                            uint PayloadPredicateCount, PAYLOAD_FILTER_PREDICATE* PayloadPredicates, 
                            void** PayloadFilter);

///The <b>TdhDeletePayloadFilter</b> function frees the memory allocated for a single payload filter by the
///TdhCreatePayloadFilter function.
///Params:
///    PayloadFilter = A pointer to a single payload filter allocated by the TdhCreatePayloadFilter function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is not valid.
///    </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhDeletePayloadFilter(void** PayloadFilter);

///The <b>TdhAggregatePayloadFilters</b> function aggregates multiple payload filters for a single provider into a
///single data structure for use with the EnableTraceEx2 function.
///Params:
///    PayloadFilterCount = The count of payload filters.
///    PayloadFilterPtrs = An array of event payload single filters, each created by a call to the TdhCreatePayloadFilter function.
///    EventMatchALLFlags = An array of Boolean values that correspond to each payload filter passed in the <i>PayloadFilterPtrs</i>
///                         parameter and indicates how events are handled when multiple conditions are specified.. This parameter only
///                         affects situations where multiple payload filters are being specified for the same event. When a Boolean value is
///                         <b>TRUE</b>, an event will be written to a session if any of the specified conditions specified in the filter are
///                         <b>TRUE</b>. If this flag is set to <b>TRUE</b> on one or more filters for the same event Id or event version,
///                         then the event is only written if all the flagged filters for the event are satisfied. When a Boolean value is
///                         <b>FALSE</b>, an event will be written to a session only if all of the specified conditions specified in the
///                         filter are <b>TRUE</b>. If this flag is set to <b>FALSE</b> on one or more filters for the same event Id or event
///                         version, then the event is written if any of the non-flagged filters are satisfied.
///    EventFilterDescriptor = A pointer to an EVENT_FILTER_DESCRIPTOR structure to be used with the EnableTraceEx2 function. The
///                            <b>EVENT_FILTER_DESCRIPTOR</b> structure will contain a pointer to the aggregated payload filters, which have
///                            been allocated by this function. When the caller is finished using this EVENT_FILTER_DESCRIPTOR structure with
///                            the EnableTraceEx2 function, the TdhCleanupPayloadEventFilterDescriptor function should be called to free the
///                            allocated memory.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate memory to create the aggregated payload filter. </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhAggregatePayloadFilters(uint PayloadFilterCount, void** PayloadFilterPtrs, ubyte* EventMatchALLFlags, 
                                EVENT_FILTER_DESCRIPTOR* EventFilterDescriptor);

///The <b>TdhCleanupPayloadEventFilterDescriptor</b> function frees the aggregated structure of payload filters created
///using the TdhAggregatePayloadFilters function.
///Params:
///    EventFilterDescriptor = A pointer to an EVENT_FILTER_DESCRIPTOR structure that contains aggregated filters where the allocated memory is
///                            to be freed. The <b>EVENT_FILTER_DESCRIPTOR</b> structure passed was created by calling the
///                            TdhAggregatePayloadFilters function. If the call is successful, allocated memory is released for the aggregated
///                            filters and the fields in the returned EVENT_FILTER_DESCRIPTOR structure are re-initialized
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is not valid.
///    </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhCleanupPayloadEventFilterDescriptor(EVENT_FILTER_DESCRIPTOR* EventFilterDescriptor);

///Retrieves metadata about an event.
///Params:
///    Event = The event record passed to your EventRecordCallback callback. For details, see the EVENT_RECORD structure.
///    TdhContextCount = Number of elements in <i>pTdhContext</i>.
///    TdhContext = Array of context values for WPP or classic ETW events only; otherwise, <b>NULL</b>. For details, see the
///                 TDH_CONTEXT structure. The array must not contain duplicate context types.
///    Buffer = User-allocated buffer to receive the event information. For details, see the TRACE_EVENT_INFO structure.
///    BufferSize = Size, in bytes, of the <i>pBuffer</i> buffer. If the function succeeds, this parameter receives the size of the
///                 buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER and sets this parameter
///                 to the required buffer size. If the buffer size is zero on input, no data is returned in the buffer and this
///                 parameter receives the required buffer size.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>pBuffer</i> buffer is
///    too small. Use the required buffer size set in <i>pBufferSize</i> to allocate a new buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The schema for the event was not
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The <b>resourceFileName</b> attribute in the
///    manifest contains the location of the provider binary. When you register the manifest, the location is written to
///    the registry. TDH was unable to find the binary based on the registered location. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_WMI_SERVER_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The WMI service is
///    not available. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhGetEventInformation(EVENT_RECORD* Event, uint TdhContextCount, TDH_CONTEXT* TdhContext, 
                            TRACE_EVENT_INFO* Buffer, uint* BufferSize);

///Retrieves information about the event map contained in the event.
///Params:
///    pEvent = The event record passed to your EventRecordCallback callback. For details, see the EVENT_RECORD structure.
///    pMapName = Null-terminated Unicode string that contains the name of the map attribute value. The name comes from the
///               <b>MapNameOffset</b> member of the EVENT_PROPERTY_INFO structure.
///    pBuffer = User-allocated buffer to receive the event map. The map could be a value map, bitmap, or pattern map. For
///              details, see the EVENT_MAP_INFO structure.
///    pBufferSize = Size, in bytes, of the <i>pBuffer</i> buffer. If the function succeeds, this parameter receives the size of the
///                  buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER and sets this parameter
///                  to the required buffer size. If the buffer size is zero on input, no data is returned in the buffer and this
///                  parameter receives the required buffer size.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>pBuffer</i> buffer is
///    too small. Use the required buffer size set in <i>pBufferSize</i> to allocate a new buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The schema for the event was not
///    found or the specified map was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The <b>resourceFileName</b> attribute in the
///    manifest contains the location of the provider binary. When you register the manifest, the location is written to
///    the registry. TDH was unable to find the binary based on the registered location. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WMI_SERVER_UNAVAILABLE</b></dt>
///    </dl> </td> <td width="60%"> The WMI service is not available. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhGetEventMapInformation(EVENT_RECORD* pEvent, PWSTR pMapName, EVENT_MAP_INFO* pBuffer, uint* pBufferSize);

///Retrieves the size of one or more property values in the event data.
///Params:
///    pEvent = The event record passed to your EventRecordCallback callback. For details, see the EVENT_RECORD structure.
///    TdhContextCount = Number of elements in <i>pTdhContext</i>.
///    pTdhContext = Array of context values for WPP or classic ETW events only, otherwise, <b>NULL</b>. For details, see the
///                  TDH_CONTEXT structure. The array must not contain duplicate context types.
///    PropertyDataCount = Number of data descriptor structures in <i>pPropertyData</i>.
///    pPropertyData = Array of PROPERTY_DATA_DESCRIPTOR structures that define the property whose size you want to retrieve. You can
///                    pass this same array to the TdhGetProperty function to retrieve the property data. If you are retrieving the size
///                    of a property that is not a member of a structure, you can specify a single data descriptor. If you are
///                    retrieving the size of a property that is a member of a structure, specify an array of two data descriptors
///                    (structures cannot contain or reference other structures). For more information on specifying this parameter, see
///                    the example code below.
///    pPropertySize = Size of the property, in bytes. Use this value to allocate the buffer passed in the <i>pBuffer</i> parameter of
///                    the TdhGetProperty function.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The schema for the event was not found or the
///    specified map was not found. If you used a MOF class to define your event, TDH looks for the schema in the WMI
///    repository. If you used a manifest to define your event, TDH looks in the provider's resources. If you use a
///    manifest, the <b>resourceFileName</b> attribute of the <b>provider</b> element defines the location where TDH
///    expects to find the resources. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The <b>resourceFileName</b> attribute in the
///    manifest contains the location of the provider binary. When you register the manifest, the location is written to
///    the registry. TDH was unable to find the binary based on the registered location. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_WMI_SERVER_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The WMI service is
///    not available. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhGetPropertySize(EVENT_RECORD* pEvent, uint TdhContextCount, TDH_CONTEXT* pTdhContext, 
                        uint PropertyDataCount, PROPERTY_DATA_DESCRIPTOR* pPropertyData, uint* pPropertySize);

///Retrieves a property value from the event data.
///Params:
///    pEvent = The event record passed to your EventRecordCallback callback. For details, see the EVENT_RECORD structure.
///    TdhContextCount = Number of elements in <i>pTdhContext</i>.
///    pTdhContext = Array of context values for WPP or classic ETW events only; otherwise, <b>NULL</b>. For details, see the
///                  TDH_CONTEXT structure. The array must not contain duplicate context types.
///    PropertyDataCount = Number of data descriptor structures in <i>pPropertyData</i>.
///    pPropertyData = Array of PROPERTY_DATA_DESCRIPTOR structures that defines the property to retrieve. If you called the
///                    TdhGetPropertySize function to retrieve the required buffer size for the property, you can use the same data
///                    descriptors. If you are retrieving a property that is not a member of a structure, you can specify a single data
///                    descriptor. If you are retrieving a property that is a member of a structure, specify an array of two data
///                    descriptors (structures cannot contain or reference other structures).
///    BufferSize = Size of the <i>pBuffer</i> buffer, in bytes. You can get this value from the <i>pPropertySize</i> parameter when
///                 calling TdhGetPropertySize function.
///    pBuffer = User-allocated buffer that receives the property data.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The schema for the event was not found or the
///    specified property was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The pBuffer buffer is too small. To get
///    the required buffer size, call TdhGetPropertySize. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The
///    <b>resourceFileName</b> attribute in the manifest contains the location of the provider binary. When you register
///    the manifest, the location is written to the registry. TDH was unable to find the binary based on the registered
///    location. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WMI_SERVER_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The WMI service is not available. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhGetProperty(EVENT_RECORD* pEvent, uint TdhContextCount, TDH_CONTEXT* pTdhContext, uint PropertyDataCount, 
                    PROPERTY_DATA_DESCRIPTOR* pPropertyData, uint BufferSize, ubyte* pBuffer);

///Retrieves a list of providers that have registered a MOF class or manifest file on the computer.
///Params:
///    pBuffer = Array of providers that publicly define their events on the computer. For details, see the
///              PROVIDER_ENUMERATION_INFO structure.
///    pBufferSize = Size, in bytes, of the <i>pBuffer</i> buffer. If the function succeeds, this parameter receives the size of the
///                  buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER and sets this parameter
///                  to the required buffer size. If the buffer size is zero on input, no data is returned in the buffer and this
///                  parameter receives the required buffer size.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>pBuffer</i> buffer is
///    too small. Use the required buffer size set in <i>pBufferSize</i> to allocate a new buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    parameters is not valid. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhEnumerateProviders(PROVIDER_ENUMERATION_INFO* pBuffer, uint* pBufferSize);

///Retrieves information for the specified field from the event descriptions for those field values that match the given
///value.
///Params:
///    pGuid = GUID that identifies the provider whose information you want to retrieve.
///    EventFieldValue = Retrieve information about the field if the field's value matches this value. If the field type is a keyword, the
///                      information is retrieved for each event keyword bit contained in the mask.
///    EventFieldType = Specify the type of field for which you want to retrieve information. For possible values, see the
///                     EVENT_FIELD_TYPE enumeration.
///    pBuffer = User-allocated buffer to receive the field information. For details, see the PROVIDER_FIELD_INFOARRAY structure.
///    pBufferSize = Size, in bytes, of the <i>pBuffer</i> buffer. If the function succeeds, this parameter receives the size of the
///                  buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER and sets this parameter
///                  to the required buffer size. If the buffer size is zero on input, no data is returned in the buffer and this
///                  parameter receives the required buffer size.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>pBuffer</i> buffer is
///    too small. Use the required buffer size set in <i>pBufferSize</i> to allocate a new buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The requested field type is
///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The manifest or MOF class was not found or does not contain information for the requested field type, or a field
///    whose value matches the given value was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The
///    <b>resourceFileName</b> attribute in the manifest contains the location of the provider binary. When you register
///    the manifest, the location is written to the registry. TDH was unable to find the binary based on the registered
///    location. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhQueryProviderFieldInformation(GUID* pGuid, ulong EventFieldValue, EVENT_FIELD_TYPE EventFieldType, 
                                      PROVIDER_FIELD_INFOARRAY* pBuffer, uint* pBufferSize);

///Retrieves the specified field metadata for a given provider.
///Params:
///    pGuid = GUID that identifies the provider whose information you want to retrieve.
///    EventFieldType = Specify the type of field for which you want to retrieve information. For possible values, see the
///                     EVENT_FIELD_TYPE enumeration.
///    pBuffer = User-allocated buffer to receive the field information. For details, see the PROVIDER_FIELD_INFOARRAY structure.
///    pBufferSize = Size, in bytes, of the <i>pBuffer</i> buffer. If the function succeeds, this parameter receives the size of the
///                  buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER and sets this parameter
///                  to the required buffer size. If the buffer size is zero on input, no data is returned in the buffer and this
///                  parameter receives the required buffer size.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>pBuffer</i> buffer is
///    too small. Use the required buffer size set in <i>pBufferSize</i> to allocate a new buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The requested field type is
///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The manifest or MOF class was not found or does not contain information for the requested field type. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The <b>resourceFileName</b> attribute in the manifest contains the location of the
///    provider binary. When you register the manifest, the location is written to the registry. TDH was unable to find
///    the binary based on the registered location. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhEnumerateProviderFieldInformation(GUID* pGuid, EVENT_FIELD_TYPE EventFieldType, 
                                          PROVIDER_FIELD_INFOARRAY* pBuffer, uint* pBufferSize);

///The <b>TdhEnumerateProviderFilters</b> function enumerates the filters that the specified provider defined in the
///manifest.
///Params:
///    Guid = GUID that identifies the provider whose filters you want to retrieve.
///    TdhContextCount = Not used.
///    TdhContext = Not used.
///    FilterCount = The number of filter structures that the <i>pBuffer</i> buffer contains. Is zero if the <i>pBuffer</i> buffer is
///                  insufficient.
///    Buffer = User-allocated buffer to receive the filter information. For details, see the PROVIDER_FILTER_INFO structure.
///    BufferSize = Size, in bytes, of the <i>pBuffer</i> buffer. If the function succeeds, this parameter receives the size of the
///                 buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER and sets this parameter
///                 to the required buffer size. If the buffer size is zero on input, no data is returned in the buffer and this
///                 parameter receives the required buffer size.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>pBuffer</i> buffer is
///    too small. Use the required buffer size set in <i>pBufferSize</i> to allocate a new buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The schema for the event was not
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The <b>resourceFileName</b> attribute in the
///    manifest contains the location of the provider binary. When you register the manifest, the location is written to
///    the registry. TDH was unable to find the binary based on the registered location. </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhEnumerateProviderFilters(GUID* Guid, uint TdhContextCount, TDH_CONTEXT* TdhContext, uint* FilterCount, 
                                 PROVIDER_FILTER_INFO** Buffer, uint* BufferSize);

///Loads the manifest used to decode a log file.
///Params:
///    Manifest = The full path to the manifest.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The manifest file was not found at the
///    specified path. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>Manifest</i> parameter cannot be <b>NULL</b> and the path cannot exceed MAX_PATH. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_XML_PARSE_ERROR</b></dt> </dl> </td> <td width="60%"> The manifest did
///    not pass validation. To determine the validation errors, run the manifest through the message compiler (mc.exe).
///    </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhLoadManifest(PWSTR Manifest);

@DllImport("TDH")
uint TdhLoadManifestFromMemory(const(void)* pData, uint cbData);

///Unloads the manifest that was loaded by the TdhLoadManifest function.
///Params:
///    Manifest = The full path to the loaded manifest.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The manifest file was not found at the
///    specified path. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>Manifest</i> parameter cannot be <b>NULL</b> and the path cannot exceed MAX_PATH. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_XML_PARSE_ERROR</b></dt> </dl> </td> <td width="60%"> The manifest did
///    not pass validation. To determine the validation errors, run the manifest through the message compiler (mc.exe).
///    </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhUnloadManifest(PWSTR Manifest);

@DllImport("TDH")
uint TdhUnloadManifestFromMemory(const(void)* pData, uint cbData);

///Formats a property value for display.
///Params:
///    EventInfo = A TRACE_EVENT_INFO structure that contains the event information. To get this structure, call the
///                TdhGetEventInformation function.
///    MapInfo = An EVENT_MAP_INFO structure that maps integer and bit values to strings. To get this structure, call the
///              TdhGetEventMapInformation function. To get the name of the map, use the <b>MapNameOffset</b> member of the
///              EVENT_PROPERTY_INFO structure. If you do not provide the map information for a mapped property, the function
///              formats the integer or bit value.
///    PointerSize = The size of a pointer value in the event data. To get the size, access the EVENT_RECORD.EventHeader.Flags member.
///                  The pointer size is 4 bytes if the EVENT_HEADER_FLAG_32_BIT_HEADER flag is set; otherwise, it is 8 bytes if the
///                  EVENT_HEADER_FLAG_64_BIT_HEADER flag is set. The EVENT_RECORD structure is passed to your EventRecordCallback
///                  callback function.
///    PropertyInType = The input type of the property. Use the <b>InType</b> member of the EVENT_PROPERTY_INFO structure to set this
///                     parameter.
///    PropertyOutType = The output type of the property. Use the <b>OutType</b> member of the EVENT_PROPERTY_INFO structure to set this
///                      parameter.
///    PropertyLength = The length, in bytes, of the property. Use the <b>Length</b> member of the EVENT_PROPERTY_INFO structure to set
///                     this parameter.
///    UserDataLength = The size, in bytes, of the <i>UserData</i> buffer. See Remarks.
///    UserData = The buffer that contains the event data. See Remarks.
///    BufferSize = The size, in bytes, of the <i>Buffer</i> buffer. If the function succeeds, this parameter receives the size of
///                 the buffer used. If the buffer is too small, the function returns ERROR_INSUFFICIENT_BUFFER and sets this
///                 parameter to the required buffer size. If the buffer size is zero on input, no data is returned in the buffer and
///                 this parameter receives the required buffer size.
///    Buffer = A caller-allocated buffer that contains the formatted property value. To determine the required buffer size, set
///             this parameterto <b>NULL</b> and <i>BufferSize</i> to zero.
///    UserDataConsumed = The length, in bytes, of the consumed event data. Use this value to adjust the values of the <i>UserData</i> and
///                       <i>UserDataLength</i> parameters. See Remarks.
///Returns:
///    Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>pBuffer</i> buffer is
///    too small. Use the required buffer size set in <i>pBufferSize</i> to allocate a new buffer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EVT_INVALID_EVENT_DATA</b></dt>
///    </dl> </td> <td width="60%"> The event data does not match the event definition in the manifest. </td> </tr>
///    </table>
///    
@DllImport("TDH")
uint TdhFormatProperty(TRACE_EVENT_INFO* EventInfo, EVENT_MAP_INFO* MapInfo, uint PointerSize, 
                       ushort PropertyInType, ushort PropertyOutType, ushort PropertyLength, ushort UserDataLength, 
                       ubyte* UserData, uint* BufferSize, PWSTR Buffer, ushort* UserDataConsumed);

///Opens a decoding handle.
///Params:
///    Handle = Type: <b>PTDH_HANDLE</b> A valid decoding handle.
///Returns:
///    Type: <b>ULONG</b> Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following
///    return codes in addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter is
///    incorrect. This error is returned if the <i>Handle</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Memory allocations failed.
///    </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhOpenDecodingHandle(TDH_HANDLE* Handle);

///Sets the value of a decoding parameter.
///Params:
///    Handle = Type: <b>TDH_HANDLE</b> A valid decoding handle.
///    TdhContext = Type: <b>PTDH_CONTEXT</b> Array of context values. The array must not contain duplicate context types.
///Returns:
///    Type: <b>ULONG</b> Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following
///    return codes in addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    parameters is incorrect. This error is returned if the <i>Handle</i> or <i>TdhContext</i> parameter is
///    <b>NULL</b>. This error is also returned if the <b>ParameterValue</b> member of the TDH_CONTEXT struct pointed to
///    by the <i>TdhContext</i> parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY </b></dt> </dl> </td> <td width="60%"> Memory allocations failed. </td> </tr>
///    </table>
///    
@DllImport("tdh")
uint TdhSetDecodingParameter(TDH_HANDLE Handle, TDH_CONTEXT* TdhContext);

///Retrieves the value of a decoding parameter.
///Params:
///    Handle = Type: <b>TDH_HANDLE</b> A valid decoding handle.
///    TdhContext = Type: <b>PTDH_CONTEXT</b> Array of context values. The array must not contain duplicate context types.
///Returns:
///    Type: <b>ULONG</b> Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following
///    return codes in addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    parameters is incorrect. This error is returned if the <i>Handle</i> or <i>TdhContext</i> parameter is
///    <b>NULL</b>. This error is also returned if the <b>ParameterValue</b> member of the TDH_CONTEXT struct pointed to
///    by the <i>TdhContext</i> parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY </b></dt> </dl> </td> <td width="60%"> Memory allocations failed. </td> </tr>
///    </table>
///    
@DllImport("tdh")
uint TdhGetDecodingParameter(TDH_HANDLE Handle, TDH_CONTEXT* TdhContext);

///Retrieves a specific property associated with a WPP message.
///Params:
///    Handle = Type: <b>TDH_HANDLE</b> A valid decoding handle.
///    EventRecord = Type: <b>PEVENT_RECORD</b> The event record passed to your EventRecordCallback callback.
///    PropertyName = Type: <b>PWSTR</b> The name of the property to retrieve. For a list of possible values, see
///                   PROPERTY_DATA_DESCRIPTOR.
///    BufferSize = Type: <b>PULONG</b> Size of the <i>Buffer</i> parameter, in bytes.
///    Buffer = Type: <b>PBYTE</b> User-allocated buffer that receives the property data.
///Returns:
///    Type: <b>ULONG</b> Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following
///    return codes in addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified property was not
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> <i>BufferSize</i> is too small. To get the required buffer size, call TdhGetWppProperty twice, once
///    with a null buffer and a pointer to retrieve the buffer size and then again with the correctly sized buffer.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One
///    or more of the parameters is incorrect. This error is returned if the <i>Handle</i>, <i>EventRecord</i>,
///    <i>PropertyName</i>, or <i>Buffer</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhGetWppProperty(TDH_HANDLE Handle, EVENT_RECORD* EventRecord, PWSTR PropertyName, uint* BufferSize, 
                       ubyte* Buffer);

///Retrieves the formatted WPP message embedded into an EVENT_RECORD structure.
///Params:
///    Handle = Type: <b>TDH_HANDLE</b> A valid decoding handle.
///    EventRecord = Type: <b>PEVENT_RECORD</b> The event record passed to your EventRecordCallback callback.
///    BufferSize = Type: <b>PULONG</b> Size of the <i>Buffer</i> parameter, in bytes.
///    Buffer = Type: <b>PBYTE</b> User-allocated buffer that receives the property data.
///Returns:
///    Type: <b>ULONG</b> Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following
///    return codes in addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified property was not
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> <i>BufferSize</i> is too small. To get the required buffer size, call TdhGetPropertySize. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more
///    of the parameters is not valid. </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhGetWppMessage(TDH_HANDLE Handle, EVENT_RECORD* EventRecord, uint* BufferSize, ubyte* Buffer);

///Frees any resources associated with the input decoding handle.
///Params:
///    Handle = Type: <b>TDH_HANDLE</b> The decoding handle to be closed.
///Returns:
///    Type: <b>ULONG</b> This function returns ERROR_SUCCESS on completion.
///    
@DllImport("tdh")
uint TdhCloseDecodingHandle(TDH_HANDLE Handle);

///Takes a NULL-terminated path to a binary file that contains metadata resources needed to decode a specific event
///provider.
///Params:
///    BinaryPath = Type: <b>PWSTR</b> Path to the ETW provider binary that contains the metadata resources.
///Returns:
///    Type: <b>ULONG</b> Returns ERROR_SUCCESS if successful. Otherwise, this function returns one of the following
///    return codes in addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The file pointed to by <i>BinaryPath</i> was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY </b></dt> </dl> </td> <td width="60%"> Memory allocations failed. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The file does not
///    contain any eventing metadata resources. </td> </tr> </table>
///    
@DllImport("tdh")
uint TdhLoadManifestFromBinary(PWSTR BinaryPath);

///The <b>TdhEnumerateManifestProviderEvents</b> function retrieves the list of events present in the provider manifest.
///Params:
///    ProviderGuid = A GUID that identifies the manifest provider whose list of events you want to retrieve.
///    Buffer = A user-allocated buffer to receive the list of events. For details, see the PROVIDER_EVENT_INFO structure.
///    BufferSize = The size, in bytes, of the buffer pointed to by the <i>ProviderInfo</i> parameter. If the function succeeds, this
///                 parameter receives the size of the buffer used. If the buffer is too small, the function returns
///                 <b>ERROR_INSUFFICIENT_BUFFER</b> and sets this parameter to the required buffer size. If the buffer size is zero
///                 on input, no data is returned in the buffer and this parameter receives the required buffer size.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EMPTY</b></dt> </dl> </td> <td width="60%"> There are no events defined for the provider GUID in the
///    manifest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The metadata for the provider was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>ProviderInfo</i> buffer
///    is too small. Use the required buffer size set in the <i>BufferSize</i> parameter to allocate a new buffer. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more
///    of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The schema information for supplied provider GUID was not found. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhEnumerateManifestProviderEvents(GUID* ProviderGuid, PROVIDER_EVENT_INFO* Buffer, uint* BufferSize);

///The <b>TdhGetManifestEventInformation</b> function retrieves metadata about an event in a manifest.
///Params:
///    ProviderGuid = A GUID that identifies the manifest provider whose event metadata you want to retrieve.
///    EventDescriptor = A pointer to the event descriptor that contains information such as event id, version, op-code, and keyword. For
///                      details, see the EVENT_DESCRIPTOR structure
///    Buffer = A user-allocated buffer to receive the metadata about an event in a provider manifest. For details, see the
///             TRACE_EVENT_INFO structure.
///    BufferSize = The size, in bytes, of the buffer pointed to by the <i>Buffer</i> parameter. If the function succeeds, this
///                 parameter receives the size of the buffer used. If the buffer is too small, the function returns
///                 <b>ERROR_INSUFFICIENT_BUFFER</b> and sets this parameter to the required buffer size. If the buffer size is zero
///                 on input, no data is returned in the buffer and this parameter receives the required buffer size.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful. Otherwise, this function returns one of the following return codes in
///    addition to others. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EMPTY</b></dt> </dl> </td> <td width="60%"> There are no events defined for the provider GUID in the
///    manifest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The metadata for the provider was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the buffer pointed to by the
///    <i>Buffer</i> parameter is too small. Use the required buffer size set in the <i>BufferSize</i> parameter to
///    allocate a new buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The schema information for supplied provider GUID
///    was not found. </td> </tr> </table>
///    
@DllImport("TDH")
uint TdhGetManifestEventInformation(GUID* ProviderGuid, EVENT_DESCRIPTOR* EventDescriptor, 
                                    TRACE_EVENT_INFO* Buffer, uint* BufferSize);

///A tracing function for publishing events when an attempted security vulnerability exploit is detected in your
///user-mode application.
///Params:
///    CveId = A pointer to the CVE ID associated with the vulnerability for which this event is being raised.
///    AdditionalDetails = A pointer to a string giving additional details that the event producer may want to provide to the consumer of
///                        this event.
///Returns:
///    Returns ERROR_SUCCESS if successful or one of the following values on error. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ARITHMETIC_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The event size is larger than the allowed
///    maximum (64k - header). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> The session buffer size is too small for the event. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Occurs when filled buffers are trying to
///    flush to disk, but disk IOs are not happening fast enough. This happens when the disk is slow and event traffic
///    is heavy. Eventually, there are no more free (empty) buffers and the event is dropped. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_LOG_FILE_FULL</b></dt> </dl> </td> <td width="60%"> The real-time playback file
///    is full. Events are not logged to the session until a real-time consumer consumes the events from the playback
///    file. Do not stop logging events based on this error code. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
int CveEventWrite(const(PWSTR) CveId, const(PWSTR) AdditionalDetails);


// Interfaces

@GUID("7B40792D-05FF-44C4-9058-F440C71F17D4")
struct CTraceRelogger;

///The <b>ITraceEvent</b> interface provides access to data relating to a specific event.
@GUID("8CC97F40-9028-4FF3-9B62-7D1F79CA7BCB")
interface ITraceEvent : IUnknown
{
    ///The <b>Clone</b> method creates a duplicate copy of an event.
    ///Params:
    ///    NewEvent = Type: <b>IEvent**</b> The new event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(ITraceEvent* NewEvent);
    ///The <b>GetUserContext</b> method retrieves the user context associated with the stream to which the event
    ///belongs.
    ///Params:
    ///    UserContext = Type: <b>void**</b> The user context. This is the context specified in the call to
    ///                  ITraceRelogger::AddLogfileTraceStream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetUserContext(void** UserContext);
    ///The <b>GetEventRecord</b> method retrieves the event record that describes an event.
    ///Params:
    ///    EventRecord = Type: <b>PEVENT_RECORD*</b> The event record.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEventRecord(EVENT_RECORD** EventRecord);
    ///The <b>SetPayload</b> method sets the payload for an event.
    ///Params:
    ///    Payload = Type: <b>BYTE*</b> The event payload data.
    ///    PayloadSize = Type: <b>ULONG</b> Size of the payload data, in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetPayload(ubyte* Payload, uint PayloadSize);
    ///The <b>SetEventDescriptor</b> method sets the event descriptor for an event.
    ///Params:
    ///    EventDescriptor = Type: <b>PCEVENT_DESCRIPTOR</b> The event descriptor data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetEventDescriptor(EVENT_DESCRIPTOR* EventDescriptor);
    ///The <b>SetProcessId</b> method assigns an event to a specific process.
    ///Params:
    ///    ProcessId = Type: <b>ULONG</b> Identifier of the process that should own this event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetProcessId(uint ProcessId);
    HRESULT SetProcessorIndex(uint ProcessorIndex);
    ///The <b>SetThreadId</b> method sets the identifier of a thread that generates an event.
    ///Params:
    ///    ThreadId = Type: <b>ULONG</b> Identifier of the thread that generates the event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetThreadId(uint ThreadId);
    HRESULT SetThreadTimes(uint KernelTime, uint UserTime);
    HRESULT SetActivityId(GUID* ActivityId);
    ///The <b>SetTimeStamp</b> method sets the time at which an event occurred.
    ///Params:
    ///    TimeStamp = Type: <b>LARGE_INTEGER*</b> The time at which the event occurred, in system time.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTimeStamp(LARGE_INTEGER* TimeStamp);
    ///The <b>SetProviderId</b> method sets the GUID for the provider which traced an event.
    ///Params:
    ///    ProviderId = Type: <b>LPCGUID</b> Unique identifier of the provider.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetProviderId(GUID* ProviderId);
}

///The <b>ITraceEventCallback</b> interface is used by ETW to provide information to the relogger as the tracing process
///starts, ends, and logs events.
@GUID("3ED25501-593F-43E9-8F38-3AB46F5A4A52")
interface ITraceEventCallback : IUnknown
{
    ///The <b>OnBeginProcessTrace</b> trace method indicates that a trace is about to begin so that relogging can be
    ///started.
    ///Params:
    ///    HeaderEvent = Type: <b>ITraceEvent*</b> Supplies a pointer to the header event.
    ///    Relogger = Type: <b>ITraceRelogger*</b> Supplies a pointer to the <b>ITraceRelogger</b> interface, which exposes APIs
    ///               for actual event injection, synthesizing new events, and cloning existing events.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnBeginProcessTrace(ITraceEvent HeaderEvent, ITraceRelogger Relogger);
    ///The <b>OnFinalizeProcessTrace</b> trace method indicates that a trace is about to end so that relogging can be
    ///finalized.
    ///Params:
    ///    Relogger = Type: <b>ITraceRelogger*</b> The trace relogger that was used to register this callback and relog this trace.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnFinalizeProcessTrace(ITraceRelogger Relogger);
    ///The <b>OnEvent</b> method indicates that an event has been received on the trace streams associated with a
    ///relogger.
    ///Params:
    ///    Event = Type: <b>ITraceEvent*</b> The event being logged.
    ///    Relogger = Type: <b>ITraceRelogger*</b> The trace relogger that was used to register this callback and relog this trace.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnEvent(ITraceEvent Event, ITraceRelogger Relogger);
}

///The <b>ITraceRelogger</b> interface provides access to the relogging functionality, allowing you to manipulate and
///relog events from an ETW trace stream.
@GUID("F754AD43-3BCC-4286-8009-9C5DA214E84E")
interface ITraceRelogger : IUnknown
{
    ///The <b>AddLogfileTraceStream</b> method adds a new logfile-based ETW trace stream to the relogger.
    ///Params:
    ///    LogfileName = Type: <b>BSTR</b> The file that contains the events to be relogged.
    ///    UserContext = Type: <b>void*</b> The user context under which to relog these events.
    ///    TraceHandle = Type: <b>TRACEHANDLE*</b> Handle to be used when adding new artificial events to the trace stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddLogfileTraceStream(BSTR LogfileName, void* UserContext, ulong* TraceHandle);
    ///The <b>AddRealtimeTraceStream</b> method adds a new real-time ETW trace stream to the relogger.
    ///Params:
    ///    LoggerName = Type: <b>BSTR</b> The real-time logger generating the events to relog
    ///    UserContext = Type: <b>void*</b> The user context under which to relog these events.
    ///    TraceHandle = Type: <b>TRACEHANDLE*</b> Handle to be used when adding new artificial events to the trace stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddRealtimeTraceStream(BSTR LoggerName, void* UserContext, ulong* TraceHandle);
    ///The <b>RegisterCallback</b> method registers an implementation of IEventCallback with the relogger in order to
    ///signal trace activity (starting, stopping, and logging new events).
    ///Params:
    ///    Callback = Type: <b>IEventCallback*</b> The trace activity information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterCallback(ITraceEventCallback Callback);
    ///The <b>Inject</b> method injects a non-system-generated event into the event stream being written to the output
    ///trace logfile.
    ///Params:
    ///    Event = Type: <b>IEvent*</b> The event to be injected into the stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Inject(ITraceEvent Event);
    ///The <b>CreateEventInstance</b> method generates a new event.
    ///Params:
    ///    TraceHandle = Type: <b>TRACEHANDLE</b> The trace from which to create the event.
    ///    Flags = Type: <b>ULONG</b> Indicates whether the event is classic or crimson.
    ///    Event = Type: <b>ITraceEvent**</b> The newly generated event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEventInstance(ulong TraceHandle, uint Flags, ITraceEvent* Event);
    ///The <b>ProcessTrace</b> method delivers events from the associated trace streams to the consumer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProcessTrace();
    ///The <b>SetOutputFilename</b> method indicates the file to which ETW should write the new, relogged trace.
    ///Params:
    ///    LogfileName = Type: <b>BSTR</b> The new filename.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOutputFilename(BSTR LogfileName);
    ///The <b>SetCompressionMode</b> method enables or disables compression on the relogged trace.
    ///Params:
    ///    CompressionMode = Type: <b>BOOLEAN</b> True if compression is enabled; otherwise, false.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCompressionMode(ubyte CompressionMode);
    ///The <b>Cancel</b> method terminates the relogging process.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Cancel();
}


// GUIDs

const GUID CLSID_CTraceRelogger = GUIDOF!CTraceRelogger;

const GUID IID_ITraceEvent         = GUIDOF!ITraceEvent;
const GUID IID_ITraceEventCallback = GUIDOF!ITraceEventCallback;
const GUID IID_ITraceRelogger      = GUIDOF!ITraceRelogger;
