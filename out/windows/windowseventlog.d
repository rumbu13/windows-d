// Written in the D programming language.

module windows.windowseventlog;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///Defines the possible data types of a variant data item.
alias EVT_VARIANT_TYPE = int;
enum : int
{
    ///Null content that implies that the element that contains the content does not exist.
    EvtVarTypeNull       = 0x00000000,
    ///A null-terminated Unicode string.
    EvtVarTypeString     = 0x00000001,
    ///A null-terminated ANSI string.
    EvtVarTypeAnsiString = 0x00000002,
    ///A signed 8-bit integer value.
    EvtVarTypeSByte      = 0x00000003,
    ///An unsigned 8-bit integer value.
    EvtVarTypeByte       = 0x00000004,
    ///An signed 16-bit integer value.
    EvtVarTypeInt16      = 0x00000005,
    ///An unsigned 16-bit integer value.
    EvtVarTypeUInt16     = 0x00000006,
    ///A signed 32-bit integer value.
    EvtVarTypeInt32      = 0x00000007,
    ///An unsigned 32-bit integer value.
    EvtVarTypeUInt32     = 0x00000008,
    ///A signed 64-bit integer value.
    EvtVarTypeInt64      = 0x00000009,
    ///An unsigned 64-bit integer value.
    EvtVarTypeUInt64     = 0x0000000a,
    ///A single-precision real value.
    EvtVarTypeSingle     = 0x0000000b,
    ///A double-precision real value.
    EvtVarTypeDouble     = 0x0000000c,
    ///A Boolean value.
    EvtVarTypeBoolean    = 0x0000000d,
    ///A hexadecimal binary value.
    EvtVarTypeBinary     = 0x0000000e,
    ///A GUID value.
    EvtVarTypeGuid       = 0x0000000f,
    ///An unsigned 32-bit or 64-bit integer value that contains a pointer address.
    EvtVarTypeSizeT      = 0x00000010,
    ///A FILETIME value.
    EvtVarTypeFileTime   = 0x00000011,
    ///A SYSTEMTIME value.
    EvtVarTypeSysTime    = 0x00000012,
    ///A security identifier (SID) structure
    EvtVarTypeSid        = 0x00000013,
    ///A 32-bit hexadecimal number.
    EvtVarTypeHexInt32   = 0x00000014,
    ///A 64-bit hexadecimal number.
    EvtVarTypeHexInt64   = 0x00000015,
    ///An EVT_HANDLE value.
    EvtVarTypeEvtHandle  = 0x00000020,
    ///A null-terminated Unicode string that contains XML.
    EvtVarTypeEvtXml     = 0x00000023,
}

///Defines the types of connection methods you can use to connect to the remote computer.
alias EVT_LOGIN_CLASS = int;
enum : int
{
    ///Use Remote Procedure Call (RPC) login.
    EvtRpcLogin = 0x00000001,
}

///Defines the types of authentication that you can use to authenticate the user when connecting to a remote computer.
alias EVT_RPC_LOGIN_FLAGS = int;
enum : int
{
    ///Use the default authentication method during RPC login. The default authentication method is Negotiate.
    EvtRpcLoginAuthDefault   = 0x00000000,
    ///Use the Negotiate authentication method during RPC login. The client and server negotiate whether to use NTLM or
    ///Kerberos.
    EvtRpcLoginAuthNegotiate = 0x00000001,
    ///Use Kerberos authentication during RPC login.
    EvtRpcLoginAuthKerberos  = 0x00000002,
    ///Use NTLM authentication during RPC login.
    EvtRpcLoginAuthNTLM      = 0x00000003,
}

///Defines the values that specify how to return the query results and whether you are query against a channel or log
///file.
alias EVT_QUERY_FLAGS = int;
enum : int
{
    ///Specifies that the query is against one or more channels. The <i>Path</i> parameter of the EvtQuery function must
    ///specify the name of a channel or <b>NULL</b>.
    EvtQueryChannelPath         = 0x00000001,
    ///Specifies that the query is against one or more log files. The <i>Path</i> parameter of the EvtQuery function
    ///must specify the full path to a log file or <b>NULL</b>.
    EvtQueryFilePath            = 0x00000002,
    ///Specifies that the events in the query result are ordered from oldest to newest. This is the default.
    EvtQueryForwardDirection    = 0x00000100,
    ///Specifies that the events in the query result are ordered from newest to oldest.
    EvtQueryReverseDirection    = 0x00000200,
    ///Specifies that EvtQuery should run the query even if the part of the query generates an error (is not well
    ///formed). The service validates the syntax of the XPath query to determine if it is well formed. If the validation
    ///fails, the service parses the XPath into individual expressions. It builds a new XPath beginning with the left
    ///most expression. The service validates the expression and if it is valid, the service adds the next expression to
    ///the XPath. The service repeats this process until it finds the expression that is failing. It then uses the valid
    ///expressions that it found beginning with the leftmost expression as the XPath query (which means that you may not
    ///get the events that you expected). If no part of the XPath is valid, the <b>EvtQuery</b> call fails.
    EvtQueryTolerateQueryErrors = 0x00001000,
}

///Defines the relative position in the result set from which to seek.
alias EVT_SEEK_FLAGS = int;
enum : int
{
    ///Seek to the specified offset from the first entry in the result set. The offset must be a positive value.
    EvtSeekRelativeToFirst    = 0x00000001,
    ///Seek to the specified offset from the last entry in the result set. The offset must be a negative value.
    EvtSeekRelativeToLast     = 0x00000002,
    ///Seek to the specified offset from the current entry in the result set. The offset can be a positive or negative
    ///value.
    EvtSeekRelativeToCurrent  = 0x00000003,
    ///Seek to the specified offset from the bookmarked entry in the result set. The offset can be a positive or
    ///negative value.
    EvtSeekRelativeToBookmark = 0x00000004,
    ///A bitmask that you can use to determine which of the following flags is set: <ul> <li>EvtSeekRelativeToFirst</li>
    ///<li>EvtSeekRelativeToLast</li> <li>EvtSeekRelativeToBookmark</li> </ul>
    EvtSeekOriginMask         = 0x00000007,
    ///Force the function to fail if the event does not exist.
    EvtSeekStrict             = 0x00010000,
}

///Defines the possible values that specify when to start subscribing to events.
alias EVT_SUBSCRIBE_FLAGS = int;
enum : int
{
    ///Subscribe to only future events that match the query criteria.
    EvtSubscribeToFutureEvents      = 0x00000001,
    ///Subscribe to all existing and future events that match the query criteria.
    EvtSubscribeStartAtOldestRecord = 0x00000002,
    ///Subscribe to all existing and future events that match the query criteria that begin after the bookmarked event.
    ///If you include the EvtSubscribeStrict flag, the EvtSubscribe function fails if the bookmarked event does not
    ///exist. If you do not include the EvtSubscribeStrict flag and the bookmarked event does not exist, the
    ///subscription begins with the event that is after the event that is closest to the bookmarked event.
    EvtSubscribeStartAfterBookmark  = 0x00000003,
    ///A bitmask that you can use to determine which of the following flags is set: <ul>
    ///<li>EvtSubscribeToFutureEvents</li> <li>EvtSubscribeStartAtOldestRecord</li>
    ///<li>EvtSubscribeStartAfterBookmark</li> </ul>
    EvtSubscribeOriginMask          = 0x00000003,
    ///Complete the subscription even if the part of the query generates an error (is not well formed). The service
    ///validates the syntax of the XPath query to determine if it is well formed. If the validation fails, the service
    ///parses the XPath into individual expressions. It builds a new XPath beginning with the left most expression. The
    ///service validates the expression and if it is valid, the service adds the next expression to the XPath. The
    ///service repeats this process until it finds the expression that is failing. It then uses the valid expressions
    ///that it found beginning with the leftmost expression as the XPath query (which means that you may not get the
    ///events that you expected). If no part of the XPath is valid, the EvtSubscribe call fails.
    EvtSubscribeTolerateQueryErrors = 0x00001000,
    ///Forces the EvtSubscribe call to fail if you specify EvtSubscribeStartAfterBookmark and the bookmarked event is
    ///not found (the return value is ERROR_NOT_FOUND). Also, set this flag if you want to receive notification in your
    ///callback when event records are missing.
    EvtSubscribeStrict              = 0x00010000,
}

///Defines the possible types of data that the subscription service can deliver to your callback.
alias EVT_SUBSCRIBE_NOTIFY_ACTION = int;
enum : int
{
    ///Indicates that the <i>Event</i> parameter contains a Win32 error code.
    EvtSubscribeActionError   = 0x00000000,
    ///Indicates that the <i>Event</i> parameter contains an event that matches the subscriber's query.
    EvtSubscribeActionDeliver = 0x00000001,
}

///Defines the identifiers that identify the system-specific properties of an event.
alias EVT_SYSTEM_PROPERTY_ID = int;
enum : int
{
    ///Identifies the <b>Name</b> attribute of the provider element. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtSystemProviderName      = 0x00000000,
    ///Identifies the <b>Guid</b> attribute of the provider element. The variant type for this property is
    ///<b>EvtVarTypeGuid</b>.
    EvtSystemProviderGuid      = 0x00000001,
    ///Identifies the <b>EventID</b> element. The variant type for this property is <b>EvtVarTypeUInt16</b>.
    EvtSystemEventID           = 0x00000002,
    ///Identifies the <b>Qualifiers</b> attribute of the EventID element. The variant type for this property is
    ///<b>EvtVarTypeUInt16</b>.
    EvtSystemQualifiers        = 0x00000003,
    ///Identifies the <b>Level</b> element. The variant type for this property is <b>EvtVarTypeUInt8</b>.
    EvtSystemLevel             = 0x00000004,
    ///Identifies the <b>Task</b> element. The variant type for this property is <b>EvtVarTypeUInt16</b>.
    EvtSystemTask              = 0x00000005,
    ///Identifies the <b>Opcode</b> element. The variant type for this property is <b>EvtVarTypeUInt8</b>.
    EvtSystemOpcode            = 0x00000006,
    ///Identifies the <b>Keywords</b> element. The variant type for this property is <b>EvtVarTypeInt64</b>.
    EvtSystemKeywords          = 0x00000007,
    ///Identifies the <b>SystemTime</b> attribute of the TimeCreated element. The variant type for this property is
    ///<b>EvtVarTypeFileTime</b>.
    EvtSystemTimeCreated       = 0x00000008,
    ///Identifies the <b>EventRecordID</b> element. The variant type for this property is <b>EvtVarTypeUInt64</b>.
    EvtSystemEventRecordId     = 0x00000009,
    ///Identifies the <b>ActivityID</b> attribute of the Correlation element. The variant type for this property is
    ///<b>EvtVarTypeGuid</b>.
    EvtSystemActivityID        = 0x0000000a,
    ///Identifies the <b>RelatedActivityID</b> attribute of the Correlation element. The variant type for this property
    ///is <b>EvtVarTypeGuid</b>.
    EvtSystemRelatedActivityID = 0x0000000b,
    ///Identifies the <b>ProcessID</b> attribute of the Execution element. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EvtSystemProcessID         = 0x0000000c,
    ///Identifies the <b>ThreadID</b> attribute of the Execution element. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EvtSystemThreadID          = 0x0000000d,
    ///Identifies the <b>Channel</b> element. The variant type for this property is <b>EvtVarTypeString</b>.
    EvtSystemChannel           = 0x0000000e,
    ///Identifies the <b>Computer</b> element. The variant type for this property is <b>EvtVarTypeString</b>.
    EvtSystemComputer          = 0x0000000f,
    ///Identifies the <b>UserID</b> element. The variant type for this property is <b>EvtVarTypeSid</b>.
    EvtSystemUserID            = 0x00000010,
    ///Identifies the <b>Version</b> element. The variant type for this property is <b>EvtVarTypeUInt8</b>.
    EvtSystemVersion           = 0x00000011,
    ///This enumeration value marks the end of the enumeration values.
    EvtSystemPropertyIdEND     = 0x00000012,
}

///Defines the values that specify the type of information to access from the event.
alias EVT_RENDER_CONTEXT_FLAGS = int;
enum : int
{
    ///Render specific properties from the event.
    EvtRenderContextValues = 0x00000000,
    ///Render the system properties under the <b>System</b> element. The properties are returned in the order defined in
    ///the EVT_SYSTEM_PROPERTY_ID enumeration.
    EvtRenderContextSystem = 0x00000001,
    ///Render all user-defined properties under the <b>UserData</b> or <b>EventData</b> element. If the data template
    ///associated with the event contains a <b>UserData</b> section, the <b>UserData</b> properties are rendered;
    ///otherwise, the <b>EventData</b> properties are rendered.
    EvtRenderContextUser   = 0x00000002,
}

///Defines the values that specify what to render.
alias EVT_RENDER_FLAGS = int;
enum : int
{
    ///Render the event properties specified in the rendering context.
    EvtRenderEventValues = 0x00000000,
    ///Render the event as an XML string. For details on the contents of the XML string, see the Event schema.
    EvtRenderEventXml    = 0x00000001,
    EvtRenderBookmark    = 0x00000002,
}

///Defines the values that specify the message string from the event to format.
alias EVT_FORMAT_MESSAGE_FLAGS = int;
enum : int
{
    ///Format the event's message string.
    EvtFormatMessageEvent    = 0x00000001,
    ///Format the message string of the level specified in the event.
    EvtFormatMessageLevel    = 0x00000002,
    ///Format the message string of the task specified in the event.
    EvtFormatMessageTask     = 0x00000003,
    ///Format the message string of the opcode specified in the event.
    EvtFormatMessageOpcode   = 0x00000004,
    ///Format the message string of the keywords specified in the event. If the event specifies multiple keywords, the
    ///formatted string is a list of null-terminated strings. Increment through the strings until your pointer points
    ///past the end of the used buffer.
    EvtFormatMessageKeyword  = 0x00000005,
    ///Format the message string of the channel specified in the event.
    EvtFormatMessageChannel  = 0x00000006,
    ///Format the provider's message string.
    EvtFormatMessageProvider = 0x00000007,
    ///Format the message string associated with a resource identifier. The provider's metadata contains the resource
    ///identifiers; the message compiler assigns a resource identifier to each string when it compiles the manifest.
    EvtFormatMessageId       = 0x00000008,
    ///Format all the message strings in the event. The formatted message is an XML string that contains the event
    ///details and the message strings. The message strings are included in the RenderingInfo section of the event
    ///details.
    EvtFormatMessageXml      = 0x00000009,
}

///Defines the values that specify whether to open a channel or exported log file.
alias EVT_OPEN_LOG_FLAGS = int;
enum : int
{
    ///Open a channel.
    EvtOpenChannelPath = 0x00000001,
    ///Open an exported log file.
    EvtOpenFilePath    = 0x00000002,
}

///Defines the identifiers that identify the log file metadata properties of a channel or log file.
alias EVT_LOG_PROPERTY_ID = int;
enum : int
{
    ///Identifies the property that contains the time that the channel or log file was created. The variant type for
    ///this property is <b>EvtVarTypeFileTime</b>.
    EvtLogCreationTime       = 0x00000000,
    ///Identifies the property that contains the last time that the channel or log file was accessed. The variant type
    ///for this property is <b>EvtVarTypeFileTime</b>.
    EvtLogLastAccessTime     = 0x00000001,
    ///Identifies the property that contains the last time that the channel or log file was written to. The variant type
    ///for this property is <b>EvtVarTypeFileTime</b>.
    EvtLogLastWriteTime      = 0x00000002,
    ///Identifies the property that contains the size of the file, in bytes. The variant type for this property is
    ///<b>EvtVarTypeUInt64</b>.
    EvtLogFileSize           = 0x00000003,
    ///Identifies the property that contains the file attributes (for details on the file attributes, see the
    ///GetFileAttributesEx function). The variant type for this property is <b>EvtVarTypeUInt32</b>.
    EvtLogAttributes         = 0x00000004,
    ///Identifies the property that contains the number of records in the channel or log file. The variant type for this
    ///property is <b>EvtVarTypeUInt64</b>.
    EvtLogNumberOfLogRecords = 0x00000005,
    ///Identifies the property that contains the record number of the oldest event in the channel or log file. The
    ///variant type for this property is <b>EvtVarTypeUInt64</b>.
    EvtLogOldestRecordNumber = 0x00000006,
    ///Identifies the property that you use to determine whether the channel or log file is full. The variant type for
    ///this property is <b>EvtVarTypeBoolean</b>. The channel is full if another event cannot be written to the channel
    ///(for example, if the channel is sequential and maximum size is reached). The property will always be false if the
    ///channel is circular or the sequential log is automatically backed up.
    EvtLogFull               = 0x00000007,
}

///Defines values that indicate whether the events come from a channel or log file.
alias EVT_EXPORTLOG_FLAGS = int;
enum : int
{
    ///The source of the events is a channel.
    EvtExportLogChannelPath         = 0x00000001,
    ///The source of the events is a previously exported log file.
    EvtExportLogFilePath            = 0x00000002,
    ///Export events even if part of the query generates an error (is not well formed). The service validates the syntax
    ///of the XPath query to determine whether it is well formed. If the validation fails, the service parses the XPath
    ///into individual expressions. It builds a new XPath beginning with the leftmost expression. The service validates
    ///the expression and if it is valid, the service adds the next expression to the XPath. The service repeats this
    ///process until it finds the expression that is failing. It then uses the valid expressions as the XPath query
    ///(which means that you may not get the events that you expected). If no part of the XPath is valid, the
    ///EvtExportLog call fails.
    EvtExportLogTolerateQueryErrors = 0x00001000,
    EvtExportLogOverwrite           = 0x00002000,
}

///Defines the identifiers that identify the configuration properties of a channel.
alias EVT_CHANNEL_CONFIG_PROPERTY_ID = int;
enum : int
{
    ///Identifies the <b>enabled</b> attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeBoolean</b>. You cannot set this property for the Application, System, and Security channels.
    EvtChannelConfigEnabled               = 0x00000000,
    ///Identifies the <b>isolation</b> attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. For possible isolation values, see the EVT_CHANNEL_ISOLATION_TYPE enumeration. You
    ///cannot set this property for the Application, System, and Security channels.
    EvtChannelConfigIsolation             = 0x00000001,
    ///Identifies the <b>type</b> attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. For possible isolation values, see the EVT_CHANNEL_TYPE enumeration. You cannot set this
    ///property.
    EvtChannelConfigType                  = 0x00000002,
    ///Identifies the <b>name</b> attribute of the provider that defined the channel. The variant type for this property
    ///is <b>EvtVarTypeString</b>. You cannot set this property.
    EvtChannelConfigOwningPublisher       = 0x00000003,
    ///Identifies the configuration property that indicates whether the channel is a classic event channel (for example
    ///the Application or System log). The variant type for this property is <b>EvtVarTypeBoolean</b>. You cannot set
    ///this property.
    EvtChannelConfigClassicEventlog       = 0x00000004,
    ///Identifies the <b>access</b> attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtChannelConfigAccess                = 0x00000005,
    ///Identifies the <b>retention</b> logging attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeBoolean</b>.
    EvtChannelLoggingConfigRetention      = 0x00000006,
    ///Identifies the <b>autoBackup</b> logging attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeBoolean</b>.
    EvtChannelLoggingConfigAutoBackup     = 0x00000007,
    ///Identifies the <b>maxSize</b> logging attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt64</b>.
    EvtChannelLoggingConfigMaxSize        = 0x00000008,
    ///Identifies the configuration property that contains the path to the file that backs the channel. The variant type
    ///for this property is <b>EvtVarTypeString</b>.
    EvtChannelLoggingConfigLogFilePath    = 0x00000009,
    ///Identifies the <b>level</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. To set this property, you must first disable the debug or analytic channel.
    EvtChannelPublishingConfigLevel       = 0x0000000a,
    ///Identifies the <b>keywords</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt64</b>. To set this property, you must first disable the debug or analytic channel.
    EvtChannelPublishingConfigKeywords    = 0x0000000b,
    ///Identifies the <b>controlGuid</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeGuid</b>. You cannot set this property.
    EvtChannelPublishingConfigControlGuid = 0x0000000c,
    ///Identifies the <b>bufferSize</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. You cannot set this property.
    EvtChannelPublishingConfigBufferSize  = 0x0000000d,
    ///Identifies the <b>minBuffers</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. You cannot set this property.
    EvtChannelPublishingConfigMinBuffers  = 0x0000000e,
    ///Identifies the <b>maxBuffers</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. You cannot set this property.
    EvtChannelPublishingConfigMaxBuffers  = 0x0000000f,
    ///Identifies the <b>latency</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. You cannot set this property.
    EvtChannelPublishingConfigLatency     = 0x00000010,
    ///Identifies the <b>clockType</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. For possible clock type values, see the EVT_CHANNEL_CLOCK_TYPE enumeration. You cannot
    ///set this property.
    EvtChannelPublishingConfigClockType   = 0x00000011,
    ///Identifies the <b>sidType</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. For possible SID type values, see the EVT_CHANNEL_SID_TYPE enumeration. You cannot set
    ///this property.
    EvtChannelPublishingConfigSidType     = 0x00000012,
    ///Identifies the configuration property that contains the list of providers that import this channel. The variant
    ///type for this property is <b>EvtVarTypeString | EVT_VARIANT_TYPE_ARRAY</b>. You cannot set this property.
    EvtChannelPublisherList               = 0x00000013,
    ///Identifies the <b>fileMax</b> publishing attribute of the channel. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EvtChannelPublishingConfigFileMax     = 0x00000014,
    ///This enumeration value marks the end of the enumeration values.
    EvtChannelConfigPropertyIdEND         = 0x00000015,
}

///Defines the type of a channel.
alias EVT_CHANNEL_TYPE = int;
enum : int
{
    ///The channel's type is Admin.
    EvtChannelTypeAdmin       = 0x00000000,
    ///The channel's type is Operational.
    EvtChannelTypeOperational = 0x00000001,
    ///The channel's type is Analytic.
    EvtChannelTypeAnalytic    = 0x00000002,
    ///The channel's type is Debug.
    EvtChannelTypeDebug       = 0x00000003,
}

///Defines the default access permissions to apply to the channel.
alias EVT_CHANNEL_ISOLATION_TYPE = int;
enum : int
{
    ///Provides open access to the channel.
    EvtChannelIsolationTypeApplication = 0x00000000,
    ///Provides restricted access to the channel and is used by applications running under system service accounts,
    ///drivers, or an application that logs events that relate to the health of the computer.
    EvtChannelIsolationTypeSystem      = 0x00000001,
    ///Provides custom access to the channel.
    EvtChannelIsolationTypeCustom      = 0x00000002,
}

///Defines the values that specify the type of time stamp to use when logging events channel.
alias EVT_CHANNEL_CLOCK_TYPE = int;
enum : int
{
    ///Uses the system time for the time stamp. The system time provides a low-resolution (10 milliseconds) time stamp
    ///but is comparatively less expensive to retrieve. System time is the default. Note that if the volume of events is
    ///high, the resolution for system time may not be fine enough to determine the sequence of events. If multiple
    ///events contain the same time stamp, the events may be delivered in the wrong order.
    EvtChannelClockTypeSystemTime = 0x00000000,
    ///Uses the query performance counter (QPC) for the time stamp. The QPC time stamp provides a high-resolution (100
    ///nanoseconds) time stamp but is comparatively more expensive to retrieve. You should use this resolution if you
    ///have high event rates or if the consumer merges events from different buffers. Note that on older computers, the
    ///time stamp may not be accurate because the counter sometimes skips forward due to hardware errors.
    EvtChannelClockTypeQPC        = 0x00000001,
}

///Defines the values that determine whether the event includes the security identifier (SID) of the principal that
///logged the event.
alias EVT_CHANNEL_SID_TYPE = int;
enum : int
{
    ///Do not include with the event the SID of the principal that logged the event.
    EvtChannelSidTypeNone       = 0x00000000,
    ///Include with the event the SID of the principal that logged the event.
    EvtChannelSidTypePublishing = 0x00000001,
}

///Defines the values that specify how a channel is referenced.
alias EVT_CHANNEL_REFERENCE_FLAGS = int;
enum : int
{
    ///Specifies that the channel is imported.
    EvtChannelReferenceImported = 0x00000001,
}

///Defines the identifiers that identify the metadata properties of a provider.
alias EVT_PUBLISHER_METADATA_PROPERTY_ID = int;
enum : int
{
    ///Identifies the <b>guid</b> attribute of the provider. The variant type for this property is
    ///<b>EvtVarTypeGuid</b>.
    EvtPublisherMetadataPublisherGuid             = 0x00000000,
    ///Identifies the <b>resourceFilePath</b> attribute of the provider. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataResourceFilePath          = 0x00000001,
    ///Identifies the <b>parameterFilePath</b> attribute of the provider. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataParameterFilePath         = 0x00000002,
    ///Identifies the <b>messageFilePath</b> attribute of the provider. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataMessageFilePath           = 0x00000003,
    ///Identifies the <b>helpLink</b> attribute of the provider. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataHelpLink                  = 0x00000004,
    ///Identifies the <b>message</b> attribute of the provider. The metadata is the resource identifier assigned to the
    ///message string. To get the message string, call the EvtFormatMessage function. The variant type for this property
    ///is <b>EvtVarTypeUInt32</b>. If the provider does not specify a message, the value is –1.
    EvtPublisherMetadataPublisherMessageID        = 0x00000005,
    ///Identifies the <b>channels</b> child element of the provider. The variant type for this property is
    ///<b>EvtVarTypeEvtHandle</b>. To access the metadata of the channels that the provider defines or imports, use this
    ///handle when calling the EvtGetObjectArrayProperty function. For details, see Remarks. When you are done with the
    ///handle, call the EvtClose function.
    EvtPublisherMetadataChannelReferences         = 0x00000006,
    ///Identifies the <b>name</b> attribute of the channel. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataChannelReferencePath      = 0x00000007,
    ///Identifies the zero-based index value of the channel in the list of channels. Use this identifier when calling
    ///the EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EvtPublisherMetadataChannelReferenceIndex     = 0x00000008,
    ///Identifies the <b>value</b> attribute of the channel. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EvtPublisherMetadataChannelReferenceID        = 0x00000009,
    ///Identifies the flags value that indicates whether this channel is imported from another provider. The channel is
    ///imported if the EvtChannelReferenceImported flag value is set. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EvtPublisherMetadataChannelReferenceFlags     = 0x0000000a,
    ///Identifies the <b>message</b> attribute of the channel. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. The property contains the resource identifier that is assigned to the message string. To
    ///get the message string, call the EvtFormatMessage function. If the channel does not specify a message, the value
    ///is –1.
    EvtPublisherMetadataChannelReferenceMessageID = 0x0000000b,
    ///Identifies the <b>levels</b> child element of the provider. The variant type for this property is
    ///<b>EvtVarTypeEvtHandle</b>. To access the metadata of the levels that the provider defines or references, use
    ///this handle when calling the EvtGetObjectArrayProperty function. For details, see Remarks. When you are done with
    ///the handle, call the EvtClose function.
    EvtPublisherMetadataLevels                    = 0x0000000c,
    ///Identifies the <b>name</b> attribute of the level. Use this identifier when calling the EvtGetObjectArrayProperty
    ///function. For details, see Remarks. The variant type for this property is <b>EvtVarTypeString</b>.
    EvtPublisherMetadataLevelName                 = 0x0000000d,
    ///Identifies the <b>value</b> attribute of the level. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EvtPublisherMetadataLevelValue                = 0x0000000e,
    ///Identifies the <b>message</b> attribute of the level. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. The property contains the resource identifier that is assigned to the message string. To
    ///get the message string, call the EvtFormatMessage function. If the level does not specify a message, the value is
    ///–1.
    EvtPublisherMetadataLevelMessageID            = 0x0000000f,
    ///Identifies the <b>tasks</b> child element of the provider. The variant type for this property is
    ///<b>EvtVarTypeEvtHandle</b>. To access the metadata of the tasks that the provider defines, use this handle when
    ///calling the EvtGetObjectArrayProperty function. For details, see Remarks. When you are done with the handle, call
    ///the EvtClose function.
    EvtPublisherMetadataTasks                     = 0x00000010,
    ///Identifies the <b>name</b> attribute of the task. Use this identifier when calling the EvtGetObjectArrayProperty
    ///function. For details, see Remarks. The variant type for this property is <b>EvtVarTypeString</b>.
    EvtPublisherMetadataTaskName                  = 0x00000011,
    ///Identifies the <b>eventGuid</b> attribute of the task. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataTaskEventGuid             = 0x00000012,
    ///Identifies the <b>value</b> attribute of the task. Use this identifier when calling the EvtGetObjectArrayProperty
    ///function. For details, see Remarks. The variant type for this property is <b>EvtVarTypeUInt32</b>.
    EvtPublisherMetadataTaskValue                 = 0x00000013,
    ///Identifies the <b>message</b> attribute of the task. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. The property contains the resource identifier that is assigned to the message string. To
    ///get the message string, call the EvtFormatMessage function. If the task does not specify a message, the value is
    ///–1.
    EvtPublisherMetadataTaskMessageID             = 0x00000014,
    ///Identifies the <b>opcodes</b> child element of the provider. The variant type for this property is
    ///<b>EvtVarTypeEvtHandle</b>. To access the metadata of the opcodes that the provider defines or references, use
    ///this handle when calling the EvtGetObjectArrayProperty function. For details, see Remarks. When you are done with
    ///the handle, call the EvtClose function.
    EvtPublisherMetadataOpcodes                   = 0x00000015,
    ///Identifies the <b>name</b> attribute of the opcode. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataOpcodeName                = 0x00000016,
    ///Identifies the <b>value</b> attribute of the opcode. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. The high word contains the opcode value and the low word contains the task to which it
    ///belongs. If the low word is zero, the opcode is defined globally; otherwise, the opcode is task specific. Use the
    ///low word value to determine the task that defines the opcode.
    EvtPublisherMetadataOpcodeValue               = 0x00000017,
    ///Identifies the <b>message</b> attribute of the opcode. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. The property contains the resource identifier that is assigned to the message string. To
    ///get the message string, call the EvtFormatMessage function. If the opcode does not specify a message, the value
    ///is –1.
    EvtPublisherMetadataOpcodeMessageID           = 0x00000018,
    ///Identifies the <b>keywords</b> child element of the provider. The variant type for this property is
    ///<b>EvtVarTypeEvtHandle</b>. To access the metadata of the keywords that the provider defines, use this handle
    ///when calling the EvtGetObjectArrayProperty function. For details, see Remarks. When you are done with the handle,
    ///call the EvtClose function.
    EvtPublisherMetadataKeywords                  = 0x00000019,
    ///Identifies the <b>name</b> attribute of the keyword. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeString</b>.
    EvtPublisherMetadataKeywordName               = 0x0000001a,
    ///Identifies the <b>mask</b> attribute of the keyword. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt64</b>.
    EvtPublisherMetadataKeywordValue              = 0x0000001b,
    ///Identifies the <b>message</b> attribute of the keyword. Use this identifier when calling the
    ///EvtGetObjectArrayProperty function. For details, see Remarks. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. The property contains the resource identifier that is assigned to the message string. To
    ///get the message string, call the EvtFormatMessage function. If the keyword does not specify a message, the value
    ///is –1.
    EvtPublisherMetadataKeywordMessageID          = 0x0000001c,
    ///This enumeration value marks the end of the enumeration values.
    EvtPublisherMetadataPropertyIdEND             = 0x0000001d,
}

///Defines the identifiers that identify the metadata properties of an event definition.
alias EVT_EVENT_METADATA_PROPERTY_ID = int;
enum : int
{
    ///Identifies the <b>value</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EventMetadataEventID          = 0x00000000,
    ///Identifies the <b>version</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>.
    EventMetadataEventVersion     = 0x00000001,
    ///Identifies the <b>channel</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. This property does not contain the channel identifier that you specified in the event
    ///definition but instead contains the <b>value</b> attribute of the channel. The value is zero if the event
    ///definition does not specify a channel.
    EventMetadataEventChannel     = 0x00000002,
    ///Identifies the <b>level</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. This property does not contain the level name that you specified in the event definition
    ///but instead contains the <b>value</b> attribute of the level. The value is zero if the event definition does not
    ///specify a level.
    EventMetadataEventLevel       = 0x00000003,
    ///Identifies the <b>opcode</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. This property does not contain the opcode name that you specified in the event
    ///definition but instead contains the <b>value</b> attribute of the opcode. The value is zero if the event
    ///definition does not specify an opcode.
    EventMetadataEventOpcode      = 0x00000004,
    ///Identifies the <b>task</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. This property does not contain the task name that you specified in the event definition
    ///but instead contains the <b>value</b> attribute of the task. The value is zero if the event definition does not
    ///specify a task.
    EventMetadataEventTask        = 0x00000005,
    ///Identifies the <b>keyword</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt64</b>. This property does not contain the list of keyword names that you specified in the event
    ///definition but instead contains a 64-bitmask of all the keywords. The top 16 bits of the mask are reserved for
    ///internal use and should be ignored when determining the keyword bits that the event definition set.
    EventMetadataEventKeyword     = 0x00000006,
    ///Identifies the <b>message</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeUInt32</b>. The property contains the resource identifier that is assigned to the message string. To
    ///get the message string, call the EvtFormatMessage function. If the event definition does not specify a message,
    ///the value is –1.
    EventMetadataEventMessageID   = 0x00000007,
    ///Identifies the <b>template</b> attribute of the event definition. The variant type for this property is
    ///<b>EvtVarTypeString</b>. This property does not contain the template name that you specified in the event
    ///definition but instead contains an XML string that includes the template node and each data node; the string does
    ///not include the UserData. The value is an empty string if the event definition does not specify a template.
    EventMetadataEventTemplate    = 0x00000008,
    ///This enumeration value marks the end of the enumeration values.
    EvtEventMetadataPropertyIdEND = 0x00000009,
}

///Defines the identifiers that identify the query information that you can retrieve.
alias EVT_QUERY_PROPERTY_ID = int;
enum : int
{
    ///Identifies the property that contains the list of channel or log file names that are specified in the query. The
    ///variant type for this property is <b>EvtVarTypeString | EVT_VARIANT_TYPE_ARRAY</b>.
    EvtQueryNames         = 0x00000000,
    ///Identifies the property that contains the list of Win32 error codes that correspond directly to the list of
    ///channel or log file names that the EvtQueryNames property returns. The error codes indicate the success or
    ///failure of the query for the specific channel or log file. The variant type for this property is
    ///<b>EvtVarTypeUInt32 | EVT_VARIANT_TYPE_ARRAY</b>.
    EvtQueryStatuses      = 0x00000001,
    ///This enumeration value marks the end of the enumeration values.
    EvtQueryPropertyIdEND = 0x00000002,
}

///Defines the values that determine the query information to retrieve.
alias EVT_EVENT_PROPERTY_ID = int;
enum : int
{
    ///Not supported. The identifier of the query that selected the event. The variant type of this property is
    ///EvtVarTypeInt32.
    EvtEventQueryIDs      = 0x00000000,
    ///The channel or log file from which the event came. The variant type of this property is EvtVarTypeString.
    EvtEventPath          = 0x00000001,
    ///This enumeration value marks the end of the enumeration values. It can be used to exit a loop when retrieving all
    ///the properties.
    EvtEventPropertyIdEND = 0x00000002,
}

// Callbacks

///Implement this callback if you call the EvtSubscribe function to receive events that match your query. The service
///calls your callback when events that match your query criteria are raised.
///Params:
///    Action = Determines whether the <i>Event</i> parameter contains an event or an error code. For possible notify action
///             values, see the EVT_SUBSCRIBE_NOTIFY_ACTION enumeration.
///    UserContext = The context that the subscriber passed to the EvtSubscribe function.
///    Event = A handle to the event. The event handle is only valid for the duration of the callback function. You can use this
///            handle with any event log function that takes an event handle (for example, EvtRender or EvtFormatMessage). Do
///            not call EvtClose to close this handle; the service will close the handle when the callback returns. If the
///            <i>Action</i> parameter is EvtSubscribeActionError, cast <i>Event</i> to a DWORD to access the Win32 error code.
///Returns:
///    The service ignores the return code that you return.
///    
alias EVT_SUBSCRIBE_CALLBACK = uint function(EVT_SUBSCRIBE_NOTIFY_ACTION Action, void* UserContext, 
                                             ptrdiff_t Event);

// Structs


///Contains event data or property values.
struct EVT_VARIANT
{
union
    {
        BOOL         BooleanVal;
        byte         SByteVal;
        short        Int16Val;
        int          Int32Val;
        long         Int64Val;
        ubyte        ByteVal;
        ushort       UInt16Val;
        uint         UInt32Val;
        ulong        UInt64Val;
        float        SingleVal;
        double       DoubleVal;
        ulong        FileTimeVal;
        SYSTEMTIME*  SysTimeVal;
        GUID*        GuidVal;
        const(PWSTR) StringVal;
        const(PSTR)  AnsiStringVal;
        ubyte*       BinaryVal;
        void*        SidVal;
        size_t       SizeTVal;
        BOOL*        BooleanArr;
        byte*        SByteArr;
        short*       Int16Arr;
        int*         Int32Arr;
        long*        Int64Arr;
        ubyte*       ByteArr;
        ushort*      UInt16Arr;
        uint*        UInt32Arr;
        ulong*       UInt64Arr;
        float*       SingleArr;
        double*      DoubleArr;
        FILETIME*    FileTimeArr;
        SYSTEMTIME*  SysTimeArr;
        GUID*        GuidArr;
        PWSTR*       StringArr;
        PSTR*        AnsiStringArr;
        void**       SidArr;
        size_t*      SizeTArr;
        ptrdiff_t    EvtHandleVal;
        const(PWSTR) XmlVal;
        PWSTR*       XmlValArr;
    }
    ///The number of elements in the array of values. Use <b>Count</b> if the <b>Type</b> member has the
    ///<b>EVT_VARIANT_TYPE_ARRAY</b> flag set.
    uint Count;
    ///A flag that specifies the data type of the variant. For possible values, see the EVT_VARIANT_TYPE enumeration.
    ///The variant contains an array of values, if the <b>EVT_VARIANT_TYPE_ARRAY</b> flag is set. The members that end
    ///in "Arr" contain arrays of values. For example, you would use the <b>StringArr</b> member to access the variant
    ///data if the type is EvtVarTypeString and the <b>EVT_VARIANT_TYPE_ARRAY</b> flag is set. You can use the
    ///EVT_VARIANT_TYPE_MASK constant to mask out the array bit to determine the variant's type.
    uint Type;
}

///Contains the information used to connect to a remote computer.
struct EVT_RPC_LOGIN
{
    ///The name of the remote computer to connect to.
    PWSTR Server;
    ///The user name to use to connect to the remote computer.
    PWSTR User;
    ///The domain to which the user account belongs. Optional.
    PWSTR Domain;
    ///The password for the user account.
    PWSTR Password;
    ///The authentication method to use to authenticate the user when connecting to the remote computer. For possible
    ///authentication methods, see the EVT_RPC_LOGIN_FLAGS enumeration.
    uint  Flags;
}

// Functions

///Establishes a connection to a remote computer that you can use when calling the other Windows Event Log functions.
///Params:
///    LoginClass = The connection method to use to connect to the remote computer. For possible values, see the EVT_LOGIN_CLASS
///                 enumeration.
///    Login = A EVT_RPC_LOGIN structure that identifies the remote computer that you want to connect to, the user's
///            credentials, and the type of authentication to use when connecting.
///    Timeout = Reserved. Must be zero.
///    Flags = Reserved. Must be zero.
///Returns:
///    If successful, the function returns a session handle that you can use to access event log information on the
///    remote computer; otherwise, <b>NULL</b>. If <b>NULL</b>, call GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtOpenSession(EVT_LOGIN_CLASS LoginClass, void* Login, uint Timeout, uint Flags);

///Closes an open handle.
///Params:
///    Object = An open event handle to close.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtClose(ptrdiff_t Object);

///Cancels all pending operations on a handle.
///Params:
///    Object = The handle whose operation you want to cancel. You can cancel the following operations: <ul> <li> EvtClearLog
///             </li> <li> EvtExportLog </li> <li> EvtNext </li> <li> EvtQuery </li> <li> EvtSeek </li> <li> EvtSubscribe </li>
///             </ul> To cancel the EvtClearLog, EvtExportLog, EvtQuery, and EvtSubscribe operations, you must pass the session
///             handle. To specify the default session (local session), set this parameter to <b>NULL</b>.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtCancel(ptrdiff_t Object);

///Gets a text message that contains the extended error information for the current error.
///Params:
///    BufferSize = The size of the <i>Buffer</i> buffer, in characters.
///    Buffer = A caller-allocated string buffer that will receive the extended error information. You can set this parameter to
///             <b>NULL</b> to determine the required buffer size.
///    BufferUsed = The size, in characters, of the caller-allocated buffer that the function used or the required buffer size if the
///                 function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    The return value is ERROR_SUCCESS if the call succeeded; otherwise, a Win32 error code.
///    
@DllImport("wevtapi")
uint EvtGetExtendedStatus(uint BufferSize, PWSTR Buffer, uint* BufferUsed);

///Runs a query to retrieve events from a channel or log file that match the specified query criteria.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> to query for events on the
///              local computer.
///    Path = The name of the channel or the full path to a log file that contains the events that you want to query. You can
///           specify an .evt, .evtx, or.etl log file. The path is required if the <i>Query</i> parameter contains an XPath
///           query; the path is ignored if the <i>Query</i> parameter contains a structured XML query and the query specifies
///           the path.
///    Query = A query that specifies the types of events that you want to retrieve. You can specify an XPath 1.0 query or
///            structured XML query. If your XPath contains more than 20 expressions, use a structured XML query. To receive all
///            events, set this parameter to <b>NULL</b> or "*".
///    Flags = One or more flags that specify the order that you want to receive the events and whether you are querying against
///            a channel or log file. For possible values, see the EVT_QUERY_FLAGS enumeration.
///Returns:
///    A handle to the query results if successful; otherwise, <b>NULL</b>. If the function returns <b>NULL</b>, call
///    the GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtQuery(ptrdiff_t Session, const(PWSTR) Path, const(PWSTR) Query, uint Flags);

///Gets the next event from the query or subscription results.
///Params:
///    ResultSet = The handle to a query or subscription result set that the EvtQuery function or the EvtSubscribe function returns.
///    EventsSize = The number of elements in the <i>EventArray</i> array. The function will try to retrieve this number of elements
///                 from the result set.
///    Events = A pointer to an array of handles that will be set to the handles to the events from the result set.
///    Timeout = The number of milliseconds that you are willing to wait for a result. Set to INFINITE to indicate no time-out
///              value. If the time-out expires, the last error is set to ERROR_TIMEOUT.
///    Flags = Reserved. Must be zero.
///    Returned = The number of handles in the array that are set.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtNext(ptrdiff_t ResultSet, uint EventsSize, ptrdiff_t* Events, uint Timeout, uint Flags, uint* Returned);

///Seeks to a specific event in a query result set.
///Params:
///    ResultSet = The handle to a query result set that the EvtQuery function returns.
///    Position = The zero-based offset to an event in the result set. The flag that you specify in the <i>Flags</i> parameter
///               indicates the beginning relative position in the result set from which to seek. For example, you can seek from
///               the beginning of the results or from the end of the results. Set to 0 to move to the relative position specified
///               by the flag.
///    Bookmark = A handle to a bookmark that the EvtCreateBookmark function returns. The bookmark identifies an event in the
///               result set to which you want to seek. Set this parameter only if the <i>Flags</i> parameter has the
///               EvtSeekRelativeToBookmark flag set.
///    Timeout = Reserved. Must be zero.
///    Flags = One or more flags that indicate the relative position in the result set from which to seek. For possible values,
///            see the EVT_SEEK_FLAGS enumeration.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function was successful. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtSeek(ptrdiff_t ResultSet, long Position, ptrdiff_t Bookmark, uint Timeout, uint Flags);

///Creates a subscription that will receive current and future events from a channel or log file that match the
///specified query criteria.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> to subscribe to events on
///              the local computer.
///    SignalEvent = The handle to an event object that the service will signal when new events are available that match your query
///                  criteria. This parameter must be <b>NULL</b> if the <i>Callback</i> parameter is not <b>NULL</b>.
///    ChannelPath = The name of the Admin or Operational channel that contains the events that you want to subscribe to (you cannot
///                  subscribe to Analytic or Debug channels). The path is required if the <i>Query</i> parameter contains an XPath
///                  query; the path is ignored if the <i>Query</i> parameter contains a structured XML query.
///    Query = A query that specifies the types of events that you want the subscription service to return. You can specify an
///            XPath 1.0 query or structured XML query. If your XPath contains more than 20 expressions, use a structured XML
///            query. To receive all events, set this parameter to <b>NULL</b> or "*".
///    Bookmark = A handle to a bookmark that identifies the starting point for the subscription. To get a bookmark handle, call
///               the EvtCreateBookmark function. You must set this parameter if the <i>Flags</i> parameter contains the
///               EvtSubscribeStartAfterBookmark flag; otherwise, <b>NULL</b>.
///    Context = A caller-defined context value that the subscription service will pass to the specified callback each time it
///              delivers an event.
///    Callback = Pointer to your EVT_SUBSCRIBE_CALLBACK callback function that will receive the subscription events. This
///               parameter must be <b>NULL</b> if the <i>SignalEvent</i> parameter is not <b>NULL</b>.
///    Flags = One or more flags that specify when to start subscribing to events. For example, if you specify
///            EvtSubscribeStartAtOldestRecord, the service will retrieve all current and future events that match your query
///            criteria; however, if you specify EvtSubscribeToFutureEvents, the service returns only future events that match
///            your query criteria. For possible values, see the EVT_SUBSCRIBE_FLAGS enumeration.
///Returns:
///    A handle to the subscription if successful; otherwise, <b>NULL</b>. If the function returns <b>NULL</b>, call the
///    GetLastError function to get the error code. You must call the EvtClose function with the subscription handle
///    when done.
///    
@DllImport("wevtapi")
ptrdiff_t EvtSubscribe(ptrdiff_t Session, HANDLE SignalEvent, const(PWSTR) ChannelPath, const(PWSTR) Query, 
                       ptrdiff_t Bookmark, void* Context, EVT_SUBSCRIBE_CALLBACK Callback, uint Flags);

///Creates a context that specifies the information in the event that you want to render.
///Params:
///    ValuePathsCount = The number of XPath expressions in the <i>ValuePaths</i> parameter.
///    ValuePaths = An array of XPath expressions that uniquely identify a node or attribute in the event that you want to render.
///                 Set to **NULL** if the **EvtRenderContextValues** context flag is not set in the *Flags* parameter. The
///                 expressions must not contain the **OR** or **AND** operator. Attribute names in the expressions must not be
///                 followed by a space.
///    Flags = One or more flags that identify the information in the event that you want to render. For example, the system
///            information, user information, or specific values. For possible values, see the EVT_RENDER_CONTEXT_FLAGS
///            enumeration.
///Returns:
///    A context handle that you use when calling the EvtRender function to render the contents of an event; otherwise,
///    <b>NULL</b>. If <b>NULL</b>, call the GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtCreateRenderContext(uint ValuePathsCount, PWSTR* ValuePaths, uint Flags);

///Renders an XML fragment based on the rendering context that you specify.
///Params:
///    Context = A handle to the rendering context that the EvtCreateRenderContext function returns. This parameter must be set to
///              <b>NULL</b> if the <i>Flags</i> parameter is set to EvtRenderEventXml or EvtRenderBookmark.
///    Fragment = A handle to an event or to a bookmark. Set this parameter to a bookmark handle if the <i>Flags</i> parameter is
///               set to EvtRenderBookmark; otherwise, set to an event handle.
///    Flags = A flag that identifies what to render. For example, the entire event or specific properties of the event. For
///            possible values, see the EVT_RENDER_FLAGS enumeration.
///    BufferSize = The size of the <i>Buffer</i> buffer, in bytes.
///    Buffer = A caller-allocated buffer that will receive the rendered output. The contents is a <b>null</b>-terminated Unicode
///             string if the <i>Flags</i> parameter is set to EvtRenderEventXml or EvtRenderBookmark. Otherwise, if <i>Flags</i>
///             is set to EvtRenderEventValues, the buffer contains an array of EVT_VARIANT structures; one for each property
///             specified by the rendering context. The <i>PropertyCount</i> parameter contains the number of elements in the
///             array. You can set this parameter to <b>NULL</b> to determine the required buffer size.
///    BufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                 function fails with ERROR_INSUFFICIENT_BUFFER.
///    PropertyCount = The number of the properties in the <i>Buffer</i> parameter if the <i>Flags</i> parameter is set to
///                    EvtRenderEventValues; otherwise, zero.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. Call the
///    GetLastError function to get the error code. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtRender(ptrdiff_t Context, ptrdiff_t Fragment, uint Flags, uint BufferSize, void* Buffer, uint* BufferUsed, 
               uint* PropertyCount);

///Formats a message string.
///Params:
///    PublisherMetadata = A handle to the provider's metadata that the EvtOpenPublisherMetadata function returns. The handle acts as a
///                        formatting context for the event or message identifier. You can set this parameter to <b>NULL</b> if the Windows
///                        Event Collector service forwarded the event. Forwarded events include a <b>RenderingInfo</b> section that
///                        contains the rendered message strings. You can also set this parameter to <b>NULL</b> if the event property that
///                        you are formatting is defined in the Winmeta.xml file (for example, if level is set to win:Error). In the latter
///                        case, the service uses the Winmeta provider as the formatting context and will format only those message strings
///                        that you reference in your event that are defined in the Winmeta.xml file.
///    Event = A handle to an event. The <i>Flags</i> parameter specifies the message string in the event that you want to
///            format. This parameter must be <b>NULL</b> if the <i>Flags</i> parameter is set to <b>EvtFormatMessageId</b>.
///    MessageId = The resource identifier of the message string that you want to format. To get the resource identifier for a
///                message string, call the GetPublisherMetadataProperty function. Set this parameter only if the <i>Flags</i>
///                parameter is set to <b>EvtFormatMessageId</b>.
///    ValueCount = The number of values in the <i>Values</i> parameter.
///    Values = An array of insertion values to use when formatting the event's message string. Typically, you set this parameter
///             to <b>NULL</b> and the function gets the insertion values from the event data itself. You would use this
///             parameter to override the default behavior and supply the insertion values to use. For example, you might use
///             this parameter if you wanted to resolve a SID to a principal name before inserting the value. To override the
///             insertion values, the <i>Flags</i> parameter must be set to EvtFormatMessageEvent, EvtFormatMessageXML, or
///             EvtFormatMessageId. If <i>Flags</i> is set to EvtFormatMessageId, the resource identifier must identify the
///             event's message string.
///    Flags = A flag that specifies the message string in the event to format. For possible values, see the
///            EVT_FORMAT_MESSAGE_FLAGS enumeration.
///    BufferSize = The size of the <i>Buffer</i> buffer, in characters.
///    Buffer = A caller-allocated buffer that will receive the formatted message string. You can set this parameter to
///             <b>NULL</b> to determine the required buffer size.
///    BufferUsed = The size, in characters of the caller-allocated buffer that the function used or the required buffer size if the
///                 function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. Call the
///    GetLastError function to get the error code. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtFormatMessage(ptrdiff_t PublisherMetadata, ptrdiff_t Event, uint MessageId, uint ValueCount, 
                      EVT_VARIANT* Values, uint Flags, uint BufferSize, PWSTR Buffer, uint* BufferUsed);

///Gets a handle to a channel or log file that you can then use to get information about the channel or log file.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> to open a channel or log on
///              the local computer.
///    Path = The name of the channel or the full path to the exported log file.
///    Flags = A flag that determines whether the <i>Path</i> parameter points to a log file or channel. For possible values,
///            see the EVT_OPEN_LOG_FLAGS enumeration.
///Returns:
///    If successful, the function returns a handle to the file or channel; otherwise, <b>NULL</b>. If <b>NULL</b>, call
///    GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtOpenLog(ptrdiff_t Session, const(PWSTR) Path, uint Flags);

///Gets information about a channel or log file.
///Params:
///    Log = A handle to the channel or log file that the EvtOpenLog function returns.
///    PropertyId = The identifier of the property to retrieve. For a list of property identifiers, see the EVT_LOG_PROPERTY_ID
///                 enumeration.
///    PropertyValueBufferSize = The size of the <i>PropertyValueBuffer</i> buffer, in bytes.
///    PropertyValueBuffer = A caller-allocated buffer that will receive the property value. The buffer contains an EVT_VARIANT object. You
///                          can set this parameter to <b>NULL</b> to determine the required buffer size.
///    PropertyValueBufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                              function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetLogInfo(ptrdiff_t Log, EVT_LOG_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                   EVT_VARIANT* PropertyValueBuffer, uint* PropertyValueBufferUsed);

///Removes all events from the specified channel and writes them to the target log file.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> for local channels.
///    ChannelPath = The name of the channel to clear.
///    TargetFilePath = The full path to the target log file that will receive the events. Set to <b>NULL</b> to clear the log file and
///                     not save the events.
///    Flags = Reserved. Must be zero.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. Use the
///    GetLastError function to get the error code. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtClearLog(ptrdiff_t Session, const(PWSTR) ChannelPath, const(PWSTR) TargetFilePath, uint Flags);

///Copies events from the specified channel or log file and writes them to the target log file.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> for local channels.
///    Path = The name of the channel or the full path to a log file that contains the events that you want to export. If the
///           <i>Query</i> parameter contains an XPath query, you must specify the channel or log file. If the <i>Flags</i>
///           parameter contains EvtExportLogFilePath, you must specify the log file. If the <i>Query</i> parameter contains a
///           structured XML query, the channel or path that you specify here must match the channel or path in the query. If
///           the <i>Flags</i> parameter contains EvtExportLogChannelPath, this parameter can be <b>NULL</b> if the query is a
///           structured XML query that specifies the channel.
///    Query = A query that specifies the types of events that you want to export. You can specify an XPath 1.0 query or
///            structured XML query. If your XPath contains more than 20 expressions, use a structured XML query. To export all
///            events, set this parameter to <b>NULL</b> or "*".
///    TargetFilePath = The full path to the target log file that will receive the events. The target log file must not exist.
///    Flags = Flags that indicate whether the events come from a channel or log file. For possible values, see the
///            EVT_EXPORTLOG_FLAGS enumeration.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. Use the
///    GetLastError function to get the error code. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtExportLog(ptrdiff_t Session, const(PWSTR) Path, const(PWSTR) Query, const(PWSTR) TargetFilePath, 
                  uint Flags);

///Adds localized strings to the events in the specified log file.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> for local channels.
///    LogFilePath = The full path to the exported log file that contains the events to localize.
///    Locale = The locale to use to localize the strings that the service adds to the events in the log file. If zero, the
///             function uses the calling thread's locale. If the provider's resources does not contain the locale, the string is
///             empty.
///    Flags = Reserved. Must be zero.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. Use the
///    GetLastError function to get the error code. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtArchiveExportedLog(ptrdiff_t Session, const(PWSTR) LogFilePath, uint Locale, uint Flags);

///Gets a handle that you use to enumerate the list of channels that are registered on the computer.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> to enumerate the channels on
///              the local computer.
///    Flags = Reserved. Must be zero.
///Returns:
///    If successful, the function returns a handle to the list of channel names that are registered on the computer;
///    otherwise, <b>NULL</b>. If <b>NULL</b>, call GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtOpenChannelEnum(ptrdiff_t Session, uint Flags);

///Gets a channel name from the enumerator.
///Params:
///    ChannelEnum = A handle to the enumerator that the EvtOpenChannelEnum function returns.
///    ChannelPathBufferSize = The size of the <i>ChannelPathBuffer</i> buffer, in characters.
///    ChannelPathBuffer = A caller-allocated buffer that will receive the name of the channel. You can set this parameter to <b>NULL</b> to
///                        determine the required buffer size.
///    ChannelPathBufferUsed = The size, in characters, of the caller-allocated buffer that the function used or the required buffer size if the
///                            function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtNextChannelPath(ptrdiff_t ChannelEnum, uint ChannelPathBufferSize, PWSTR ChannelPathBuffer, 
                        uint* ChannelPathBufferUsed);

///Gets a handle that you use to read or modify a channel's configuration property.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> to access a channel on the
///              local computer.
///    ChannelPath = The name of the channel to access.
///    Flags = Reserved. Must be zero.
///Returns:
///    If successful, the function returns a handle to the channel's configuration; otherwise, <b>NULL</b>. If
///    <b>NULL</b>, call GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtOpenChannelConfig(ptrdiff_t Session, const(PWSTR) ChannelPath, uint Flags);

///Saves the changes made to a channel's configuration.
///Params:
///    ChannelConfig = A handle to the channel's configuration properties that the EvtOpenChannelConfig function returns.
///    Flags = Reserved. Must be zero.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtSaveChannelConfig(ptrdiff_t ChannelConfig, uint Flags);

///Sets the specified configuration property of a channel.
///Params:
///    ChannelConfig = A handle to the channel's configuration properties that the EvtOpenChannelConfig function returns.
///    PropertyId = The identifier of the channel property to set. For a list of property identifiers, see the
///                 EVT_CHANNEL_CONFIG_PROPERTY_ID enumeration.
///    Flags = Reserved. Must be zero.
///    PropertyValue = The property value to set. A caller-allocated buffer that contains the new configuration property value. The
///                    buffer contains an EVT_VARIANT object. Be sure to set the configuration value and variant type.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtSetChannelConfigProperty(ptrdiff_t ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, 
                                 EVT_VARIANT* PropertyValue);

///Gets the specified channel configuration property.
///Params:
///    ChannelConfig = A handle to the channel's configuration properties that the EvtOpenChannelConfig function returns.
///    PropertyId = The identifier of the channel property to retrieve. For a list of property identifiers, see the
///                 EVT_CHANNEL_CONFIG_PROPERTY_ID enumeration.
///    Flags = Reserved. Must be zero.
///    PropertyValueBufferSize = The size of the <i>PropertyValueBuffer</i> buffer, in bytes.
///    PropertyValueBuffer = A caller-allocated buffer that will receive the configuration property. The buffer contains an EVT_VARIANT
///                          object. You can set this parameter to <b>NULL</b> to determine the required buffer size.
///    PropertyValueBufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                              function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetChannelConfigProperty(ptrdiff_t ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, 
                                 uint PropertyValueBufferSize, EVT_VARIANT* PropertyValueBuffer, 
                                 uint* PropertyValueBufferUsed);

///Gets a handle that you use to enumerate the list of registered providers on the computer.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> to enumerate the registered
///              providers on the local computer.
///    Flags = Reserved. Must be zero.
///Returns:
///    If successful, the function returns a handle to the list of registered providers; otherwise, <b>NULL</b>. If
///    <b>NULL</b>, call GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtOpenPublisherEnum(ptrdiff_t Session, uint Flags);

///Gets the identifier of a provider from the enumerator.
///Params:
///    PublisherEnum = A handle to the registered providers enumerator that the EvtOpenPublisherEnum function returns.
///    PublisherIdBufferSize = The size of the <i>PublisherIdBuffer</i> buffer, in characters.
///    PublisherIdBuffer = A caller-allocated buffer that will receive the name of the registered provider. You can set this parameter to
///                        <b>NULL</b> to determine the required buffer size.
///    PublisherIdBufferUsed = The size, in characters, of the caller-allocated buffer that the function used or the required buffer size if the
///                            function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtNextPublisherId(ptrdiff_t PublisherEnum, uint PublisherIdBufferSize, PWSTR PublisherIdBuffer, 
                        uint* PublisherIdBufferUsed);

///Gets a handle that you use to read the specified provider's metadata.
///Params:
///    Session = A remote session handle that the EvtOpenSession function returns. Set to <b>NULL</b> to get the metadata for a
///              provider on the local computer.
///    PublisherId = The name of the provider. To enumerate the names of the providers registered on the computer, call the
///                  EvtOpenPublisherEnum function.
///    LogFilePath = The full path to an archived log file that contains the events that the provider logged. An archived log file
///                  also contains the provider's metadata. Use this parameter when the provider is not registered on the local
///                  computer. Set to <b>NULL</b> when reading the metadata from a registered provider..
///    Locale = The locale identifier to use when accessing the localized metadata from the provider. To create the locale
///             identifier, use the MAKELCID macro. Set to 0 to use the locale identifier of the calling thread.
///    Flags = Reserved. Must be zero.
///Returns:
///    If successful, the function returns a handle to the provider's metadata; otherwise, <b>NULL</b>. If <b>NULL</b>,
///    call GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtOpenPublisherMetadata(ptrdiff_t Session, const(PWSTR) PublisherId, const(PWSTR) LogFilePath, 
                                   uint Locale, uint Flags);

///Gets the specified provider metadata property.
///Params:
///    PublisherMetadata = A handle to the metadata that the EvtOpenPublisherMetadata function returns.
///    PropertyId = The identifier of the metadata property to retrieve. For a list of property identifiers, see the
///                 EVT_PUBLISHER_METADATA_PROPERTY_ID enumeration.
///    Flags = Reserved. Must be zero.
///    PublisherMetadataPropertyBufferSize = The size of the <i>PublisherMetadataPropertyBuffer</i> buffer, in bytes.
///    PublisherMetadataPropertyBuffer = A caller-allocated buffer that will receive the metadata property. The buffer contains an EVT_VARIANT object. You
///                                      can set this parameter to <b>NULL</b> to determine the required buffer size.
///    PublisherMetadataPropertyBufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                                          function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetPublisherMetadataProperty(ptrdiff_t PublisherMetadata, EVT_PUBLISHER_METADATA_PROPERTY_ID PropertyId, 
                                     uint Flags, uint PublisherMetadataPropertyBufferSize, 
                                     EVT_VARIANT* PublisherMetadataPropertyBuffer, 
                                     uint* PublisherMetadataPropertyBufferUsed);

///Gets a handle that you use to enumerate the list of events that the provider defines.
///Params:
///    PublisherMetadata = A handle to the provider's metadata that the EvtOpenPublisherMetadata function returns.
///    Flags = Reserved. Must be zero.
///Returns:
///    If successful, the function returns a handle to the list of events that the provider defines; otherwise,
///    <b>NULL</b>. If <b>NULL</b>, call GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtOpenEventMetadataEnum(ptrdiff_t PublisherMetadata, uint Flags);

///Gets an event definition from the enumerator.
///Params:
///    EventMetadataEnum = A handle to the event definition enumerator that the EvtOpenEventMetadataEnum function returns.
///    Flags = Reserved. Must be zero.
///Returns:
///    If successful, the function returns a handle to the event's metadata; otherwise, <b>NULL</b>. If <b>NULL</b>,
///    call GetLastError function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtNextEventMetadata(ptrdiff_t EventMetadataEnum, uint Flags);

///Gets the specified event metadata property.
///Params:
///    EventMetadata = A handle to the event metadata that the EvtNextEventMetadata function returns.
///    PropertyId = The identifier of the metadata property to retrieve. For a list of property identifiers, see the
///                 EVT_EVENT_METADATA_PROPERTY_ID enumeration.
///    Flags = Reserved. Must be zero.
///    EventMetadataPropertyBufferSize = The size of the <i>EventMetadataPropertyBuffer</i> buffer, in bytes.
///    EventMetadataPropertyBuffer = A caller-allocated buffer that will receive the metadata property. The buffer contains an EVT_VARIANT object. You
///                                  can set this parameter to <b>NULL</b> to determine the required buffer size.
///    EventMetadataPropertyBufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                                      function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetEventMetadataProperty(ptrdiff_t EventMetadata, EVT_EVENT_METADATA_PROPERTY_ID PropertyId, uint Flags, 
                                 uint EventMetadataPropertyBufferSize, EVT_VARIANT* EventMetadataPropertyBuffer, 
                                 uint* EventMetadataPropertyBufferUsed);

///Gets the number of elements in the array of objects.
///Params:
///    ObjectArray = A handle to an array of objects that the EvtGetPublisherMetadataProperty function returns.
///    ObjectArraySize = The number of elements in the array.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetObjectArraySize(ptrdiff_t ObjectArray, uint* ObjectArraySize);

///Gets a provider metadata property from the specified object in the array.
///Params:
///    ObjectArray = A handle to an array of objects that the EvtGetPublisherMetadataProperty function returns.
///    PropertyId = The property identifier of the metadata property that you want to get from the specified object. For possible
///                 values, see the Remarks section of EVT_PUBLISHER_METADATA_PROPERTY_ID.
///    ArrayIndex = The zero-based index of the object in the array.
///    Flags = Reserved. Must be zero.
///    PropertyValueBufferSize = The size of the <i>PropertyValueBuffer</i> buffer, in bytes.
///    PropertyValueBuffer = A caller-allocated buffer that will receive the metadata property. The buffer contains an EVT_VARIANT object. You
///                          can set this parameter to <b>NULL</b> to determine the required buffer size.
///    PropertyValueBufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                              function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetObjectArrayProperty(ptrdiff_t ObjectArray, uint PropertyId, uint ArrayIndex, uint Flags, 
                               uint PropertyValueBufferSize, EVT_VARIANT* PropertyValueBuffer, 
                               uint* PropertyValueBufferUsed);

///Gets information about a query that you ran that identifies the list of channels or log files that the query
///attempted to access. The function also gets a list of return codes that indicates the success or failure of each
///access.
///Params:
///    QueryOrSubscription = A handle to the query that theEvtQuery or EvtSubscribe function returns.
///    PropertyId = The identifier of the query information to retrieve. For a list of identifiers, see the EVT_QUERY_PROPERTY_ID
///                 enumeration.
///    PropertyValueBufferSize = The size of the <i>PropertyValueBuffer</i> buffer, in bytes.
///    PropertyValueBuffer = A caller-allocated buffer that will receive the query information. The buffer contains an EVT_VARIANT object. You
///                          can set this parameter to <b>NULL</b> to determine the required buffer size.
///    PropertyValueBufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                              function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. To get the
///    error code, call the GetLastError function. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetQueryInfo(ptrdiff_t QueryOrSubscription, EVT_QUERY_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                     EVT_VARIANT* PropertyValueBuffer, uint* PropertyValueBufferUsed);

///Creates a bookmark that identifies an event in a channel.
///Params:
///    BookmarkXml = An XML string that contains the bookmark or <b>NULL</b> if creating a bookmark.
///Returns:
///    A handle to the bookmark if the call succeeds; otherwise, <b>NULL</b>. If <b>NULL</b>, call the GetLastError
///    function to get the error code.
///    
@DllImport("wevtapi")
ptrdiff_t EvtCreateBookmark(const(PWSTR) BookmarkXml);

///Updates the bookmark with information that identifies the specified event.
///Params:
///    Bookmark = The handle to the bookmark to be updated. The EvtCreateBookmark function returns this handle.
///    Event = The handle to the event to bookmark.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. Call the
///    GetLastError function to get the error code. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtUpdateBookmark(ptrdiff_t Bookmark, ptrdiff_t Event);

///Gets information that identifies the structured XML query that selected the event and the channel or log file that
///contained the event.
///Params:
///    Event = A handle to an event for which you want to retrieve information.
///    PropertyId = A flag that identifies the information to retrieve. For example, the query identifier or the path. For possible
///                 values, see the EVT_EVENT_PROPERTY_ID enumeration.
///    PropertyValueBufferSize = The size of the <i>PropertyValueBuffer</i> buffer, in bytes.
///    PropertyValueBuffer = A caller-allocated buffer that will receive the information. The buffer contains an EVT_VARIANT object. You can
///                          set this parameter to <b>NULL</b> to determine the required buffer size.
///    PropertyValueBufferUsed = The size, in bytes, of the caller-allocated buffer that the function used or the required buffer size if the
///                              function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TRUE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> <dt></dt> </dl> </td> <td width="60%"> The function failed. Use the
///    GetLastError function to get the error code. </td> </tr> </table>
///    
@DllImport("wevtapi")
BOOL EvtGetEventInfo(ptrdiff_t Event, EVT_EVENT_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                     EVT_VARIANT* PropertyValueBuffer, uint* PropertyValueBufferUsed);


