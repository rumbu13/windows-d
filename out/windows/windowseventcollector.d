// Written in the D programming language.

module windows.windowseventcollector;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


///The <b>EC_SUBSCRIPTION_PROPERTY_ID</b> enumeration defines values to identify event subscription properties used for
///subscription configuration.
alias EC_SUBSCRIPTION_PROPERTY_ID = int;
enum : int
{
    ///The <b>Enabled</b> property of the subscription that is used to enable or disable the subscription or obtain the
    ///current status of a subscription. This property is an EcVarTypeBoolean value.
    EcSubscriptionEnabled                      = 0x00000000,
    ///The <b>EventSources</b> property of the subscription that contains a collection of information about the local or
    ///remote computers (event sources) that can forward events to the event collector. This property is a handle to an
    ///array (an EcVarObjectArrayPropertyHandle value). This value is typically used for collector initiated
    ///subscriptions. It can be used for source initiated subscriptions to disable the collection of events from a
    ///particular event source.
    EcSubscriptionEventSources                 = 0x00000001,
    ///The <b>EventSourceAddress</b> property of the subscription that contains the IP address or fully qualified domain
    ///name (FQDN) of the local or remote computer (event source) from which the events are collected. This property is
    ///an EcVarTypeString value.
    EcSubscriptionEventSourceAddress           = 0x00000002,
    ///The <b>EventSourceEnabled</b> property of the subscription that is used to enable or disable an event source.
    ///This property is an EcVarTypeBoolean value.
    EcSubscriptionEventSourceEnabled           = 0x00000003,
    ///The <b>EventSourceUserName</b> property of the subscription that contains the user name, which is used by the
    ///remote computer (event source) to authenticate the user. This property is an EcVarTypeString value. This property
    ///cannot be used for source initiated subscriptions.
    EcSubscriptionEventSourceUserName          = 0x00000004,
    ///The <b>EventSourcePassword</b> property of the subscription that contains the password, which is used by the
    ///remote computer (event source) to authenticate the user. This property is an EcVarTypeString value. This property
    ///cannot be used for source initiated subscriptions.
    EcSubscriptionEventSourcePassword          = 0x00000005,
    ///The <b>Description</b> property of the subscription that contains a description of the subscription. This
    ///property is an EcVarTypeString value.
    EcSubscriptionDescription                  = 0x00000006,
    ///The <b>URI</b> property of the subscription that contains the URI, which is used by WS-Management to connect to a
    ///computer. For example, the URI can be `http://schemas.microsoft.com/wbem/wsman/1/logrecord/sel` for hardware
    ///events or it can be `http://schemas.microsoft.com/wbem/wsman/1/windows/EventLog` for events that are published in
    ///the event log. This property is an EcVarTypeString value.
    EcSubscriptionURI                          = 0x00000007,
    ///The <b>ConfigurationMode</b> property of the subscription that specifies how events are delivered to the
    ///subscription. This property is an EcVarTypeUInt32 value from the EC_SUBSCRIPTION_CONFIGURATION_MODE enumeration.
    EcSubscriptionConfigurationMode            = 0x00000008,
    ///The <b>Expires</b> property of the subscription that contains the date when the subscription will end. The
    ///maximum date that can be used is 3000-12-31T23:59:59.999Z. If this property is not defined, the subscription will
    ///not expire. This property is an EcVarTypeDateTime value.
    EcSubscriptionExpires                      = 0x00000009,
    ///The <b>Query</b> property of the subscription that contains the query, which is used by the event source for
    ///selecting events to forward to the event collector. This property is an EcVarTypeString value.
    EcSubscriptionQuery                        = 0x0000000a,
    ///The <b>TransportName</b> property of the subscription that specifies the type of transport, which is used to
    ///connect to the remote computer (event source). This value can be either HTTP, which is the default, or it can be
    ///HTTPS. This property is an EcVarTypeString value.
    EcSubscriptionTransportName                = 0x0000000b,
    ///The <b>TransportPort</b> property of the subscription that specifies the port number, which the transport uses to
    ///connect to the remote computer (event source). The default port number for HTTP is 80 and the default port number
    ///for HTTPS is 443. This property is an EcVarTypeUInt32 value.
    EcSubscriptionTransportPort                = 0x0000000c,
    ///The <b>DeliveryMode</b> property of the subscription that specifies whether events are delivered to the
    ///subscription with either a push or pull model. This property is an EC_SUBSCRIPTION_DELIVERY_MODE enumeration
    ///value. This property cannot be used for source initiated subscriptions.
    EcSubscriptionDeliveryMode                 = 0x0000000d,
    ///The <b>DeliveryMaxItems</b> property of the subscription that specifies the maximum number of events that can be
    ///batched when forwarded from the event sources. When the <b>EcSubscriptionDeliveryMode</b> property is set to
    ///<b>EcDeliveryModePush</b>, this property determines the number of events that are included in a batch sent from
    ///the event source. When the <b>EcSubscriptionDeliveryMode</b> property is set to <b>EcDeliveryModePull</b>, this
    ///property determines the maximum number of items that will forwarded from an event source for each request. This
    ///property is an EcVarTypeUInt32 value.
    EcSubscriptionDeliveryMaxItems             = 0x0000000e,
    ///The <b>DeliveryMaxLatencyTime</b> property of the subscription that specifies how long, in milliseconds, the
    ///event source should wait before sending events (even if it did not collect enough events to reach the maximum
    ///number of items). This value is used when the <b>EcSubscriptionDeliveryMode</b> property is set to
    ///<b>EcDeliveryModePush</b>. This property is an EcVarTypeUInt32 value.
    EcSubscriptionDeliveryMaxLatencyTime       = 0x0000000f,
    ///The <b>HeartbeatInterval</b> property of the subscription that defines the heartbeat time interval, in
    ///milliseconds, which is observed between the sent heartbeat messages. When the <b>EcSubscriptionDeliveryMode</b>
    ///property is set to <b>EcDeliveryModePush</b>, the event collector uses this property to determine the
    ///availability of the event source. When the <b>EcSubscriptionDeliveryMode</b> property is set to
    ///<b>EcDeliveryModePull</b>, the event collector uses this property to determine the interval between queries to
    ///the event source. This property is an EcVarTypeUInt32 value.
    EcSubscriptionHeartbeatInterval            = 0x00000010,
    ///The <b>Locale</b> property of the subscription that specifies the locale (for example, en-us) of the events. This
    ///property is an EcVarTypeString value.
    EcSubscriptionLocale                       = 0x00000011,
    ///The <b>ContentFormat</b> property of the subscription that specifies the format in which the event content should
    ///be delivered. This property is an EC_SUBSCRIPTION_CONTENT_FORMAT enumeration value.
    EcSubscriptionContentFormat                = 0x00000012,
    ///The <b>LogFile</b> property of the subscription that specifies the log file where the events collected from the
    ///event sources will be stored. This property is an EcVarTypeString value.
    EcSubscriptionLogFile                      = 0x00000013,
    ///The <b>PublisherName</b> property of the subscription that contains the name of publisher that the event
    ///collector computer will raise events to the local log as. This is used when you want to collect events in a log
    ///other than the ForwardedEvents log. This property is an EcVarTypeString value.
    EcSubscriptionPublisherName                = 0x00000014,
    ///The <b>CredentialsType</b> property of the subscription that specifies the type of credentials used in the event
    ///subscription. This property is an EC_SUBSCRIPTION_CREDENTIALS_TYPE enumeration value. This property cannot be
    ///used for source initiated subscriptions.
    EcSubscriptionCredentialsType              = 0x00000015,
    ///The <b>CommonUserName</b> property of the subscription that contains the common user name, which is used by the
    ///local and remote computers to authenticate the user. This property is an EcVarTypeString value. This property
    ///cannot be used for source initiated subscriptions.
    EcSubscriptionCommonUserName               = 0x00000016,
    ///The <b>CommonPassword</b> property of the subscription that contains the common password, which is used by the
    ///local and remote computers to authenticate the user. This property is an EcVarTypeString value. This property
    ///cannot be used for source initiated subscriptions.
    EcSubscriptionCommonPassword               = 0x00000017,
    ///The <b>HostName</b> property of the subscription that specifies the fully qualified domain name (FQDN) of the
    ///local computer. This property is used by an event source to forward events and is used in scenarios that involve
    ///multihomed servers that may have multiple FQDNs. This property is an EcVarTypeString value and must only be used
    ///for a push subscription.
    EcSubscriptionHostName                     = 0x00000018,
    ///The <b>ReadExistingEvents</b> property of the subscription that determines whether to collect existing events or
    ///not. This property is an EcVarTypeBoolean value.
    EcSubscriptionReadExistingEvents           = 0x00000019,
    ///The <b>Dialect</b> property of the subscription that specifies the dialect of the query string. For example, the
    ///dialect for SQL based filters would be SQL, and the dialect for WMI based filters would be WQL. This property is
    ///an EcVarTypeString value.
    EcSubscriptionDialect                      = 0x0000001a,
    ///The <b>Type</b> property of the subscription that defines whether the subscription is initiated by an event
    ///source or collector. This property is a <b>EC_SUBSCRPTION_TYPE</b> value.
    EcSubscriptionType                         = 0x0000001b,
    ///The <b>AllowedIssuerCAs</b> property of the subscription that contains the certificate authorities (CAs) allowed
    ///if the subscription uses certificate-based authentication. This is used for source initiated subscriptions. This
    ///property is an EcVarTypeString value.
    EcSubscriptionAllowedIssuerCAs             = 0x0000001c,
    ///The <b>AllowedSubjects</b> property of the subscription that contains the subjects that are allowed for the
    ///subscription. This is used for source initiated subscriptions. The subject specifies names, such as domain names,
    ///for all the event source computers that are allowed in the subscription. This property is an EcVarTypeString
    ///value.
    EcSubscriptionAllowedSubjects              = 0x0000001d,
    ///The <b>DeniedSubjects</b> property of the subscription that contains the subjects that are not allowed for the
    ///subscription. This is used for source initiated subscriptions. The subject specifies names, such as domain names,
    ///for all the event source computers that are not allowed in the subscription. This property is an EcVarTypeString
    ///value.
    EcSubscriptionDeniedSubjects               = 0x0000001e,
    ///The <b>AllowedSourceDomainComputers</b> property of the subscription that contains the source computers that are
    ///allowed to send events to the collector computer defined by an SDDL string. This property is an EcVarTypeString
    ///value.
    EcSubscriptionAllowedSourceDomainComputers = 0x0000001f,
    EcSubscriptionPropertyIdEND                = 0x00000020,
}

///The <b>EC_SUBSCRIPTION_CREDENTIALS_TYPE</b> enumeration specifies the type of credentials to use when communicating
///with event sources.
alias EC_SUBSCRIPTION_CREDENTIALS_TYPE = int;
enum : int
{
    ///Negotiate with event sources to specify a proper authentication type without specifying a username and password
    ///for the subscription credentials.
    EcSubscriptionCredDefault      = 0x00000000,
    ///WinRM will negotiate with event sources to specify a proper authentication type for the subscription credentials.
    EcSubscriptionCredNegotiate    = 0x00000001,
    ///Use digest authentication for the subscription credentials.
    EcSubscriptionCredDigest       = 0x00000002,
    ///Send a username and password to use as credentials for the subscription.
    EcSubscriptionCredBasic        = 0x00000003,
    EcSubscriptionCredLocalMachine = 0x00000004,
}

///The <b>EC_SUBSCRIPTION_TYPE</b> enumeration specifies the type of subscription to use (a source initiated or
///collector initiated subscription).
alias EC_SUBSCRIPTION_TYPE = int;
enum : int
{
    ///Allows you to define an event subscription on an event collector computer without defining the event source
    ///computers. Multiple remote event source computers can then be set up (using a group policy setting) to forward
    ///events to the event collector computer. For more information, see Setting up a Source Initiated Subscription.
    ///This subscription type is useful when you do not know or you do not want to specify all the event sources
    ///computers that will forward events.
    EcSubscriptionTypeSourceInitiated    = 0x00000000,
    EcSubscriptionTypeCollectorInitiated = 0x00000001,
}

///The <b>EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID</b> enumeration specifies the values used to get the status of a
///subscription or the status of a particular event source with respect to a subscription. The values are used in the
///EcGetSubscriptionRunTimeStatus function.
alias EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID = int;
enum : int
{
    ///Get the status of an active or inactive subscription or an event source. This will return an unsigned 32-bit
    ///integer value from the EC_SUBSCRIPTION_RUNTIME_STATUS_ACTIVE_STATUS enumeration.
    EcSubscriptionRunTimeStatusActive            = 0x00000000,
    ///Get the last error status of a subscription or an event source. This will return an EcVarTypeUInt32 value.
    EcSubscriptionRunTimeStatusLastError         = 0x00000001,
    ///Get the last error message for a subscription or an event source. This will return an EcVarTypeString value.
    EcSubscriptionRunTimeStatusLastErrorMessage  = 0x00000002,
    ///Get the time that the last error occurred for a subscription or an event source. This will return an
    ///EcVarTypeDateTime value.
    EcSubscriptionRunTimeStatusLastErrorTime     = 0x00000003,
    ///Get the next time that the subscription or an event source will try to run (after an error). This will return an
    ///EcVarTypeDateTime value.
    EcSubscriptionRunTimeStatusNextRetryTime     = 0x00000004,
    ///Get the event sources for the subscription. For collector initiated subscriptions, this list will be identical to
    ///the one in the subscription's configuration. For source initiated subscriptions, this list will be the set of
    ///event sources that collector has heard from in the last 30 days. This list is persistent across reboots of the
    ///event collector. This will return an EcVarTypeString value.
    EcSubscriptionRunTimeStatusEventSources      = 0x00000005,
    ///Get the last time that a heartbeat (a signal used to signify the subscription is working) occurred for a
    ///subscription or an event source. This will return an EcVarTypeDateTime value.
    EcSubscriptionRunTimeStatusLastHeartbeatTime = 0x00000006,
    EcSubscriptionRunTimeStatusInfoIdEND         = 0x00000007,
}

///The <b>EC_VARIANT_TYPE</b> enumeration defines the values that specify the data types that are used in the Windows
///Event Collector functions.
alias EC_VARIANT_TYPE = int;
enum : int
{
    ///Null content that implies that the element that contains the content does not exist.
    EcVarTypeNull                  = 0x00000000,
    ///A Boolean value.
    EcVarTypeBoolean               = 0x00000001,
    ///An unsigned 32-bit value.
    EcVarTypeUInt32                = 0x00000002,
    ///A ULONGLONG value.
    EcVarTypeDateTime              = 0x00000003,
    ///A string value.
    EcVarTypeString                = 0x00000004,
    EcVarObjectArrayPropertyHandle = 0x00000005,
}

///The <b>EC_SUBSCRIPTION_CONFIGURATION_MODE</b> enumeration specifies different configuration modes that change the
///default settings for a subscription. Each configuration mode is used to define default settings for a different
///scenario, and sets the subscription delivery mode and default property values.
alias EC_SUBSCRIPTION_CONFIGURATION_MODE = int;
enum : int
{
    ///This mode is used when an administrator needs the events to be delivered reliably and for the subscription to
    ///work with minimal configuration, and when network usage is not a concern. This mode sets the default subscription
    ///delivery mode to pull subscriptions.
    EcConfigurationModeNormal       = 0x00000000,
    ///This subscription mode allows custom values for the DeliveryMode property, the DeliveryMaxItems property, the
    ///DeliveryMaxLatencyTime, and the HeartBeatInterval property.
    EcConfigurationModeCustom       = 0x00000001,
    ///This mode is used for alerts and critical events because it configures the subscription to send events as soon as
    ///they occur with minimal delay. This mode sets the default subscription delivery mode to push subscriptions.
    EcConfigurationModeMinLatency   = 0x00000002,
    ///This mode is used when network activity is controllable, and when network usage is expensive. This mode sets the
    ///default subscription delivery mode to push subscriptions.
    EcConfigurationModeMinBandwidth = 0x00000003,
}

///The <b>EC_SUBSCRIPTION_DELIVERY_MODE</b> enumeration defines values that indicate how events are delivered in a
///subscription. Events are delivered through subscriptions using either the push or pull model. For more information,
///see Subscribing to Events.
alias EC_SUBSCRIPTION_DELIVERY_MODE = int;
enum : int
{
    ///Events are delivered through the subscription using the pull model.
    EcDeliveryModePull = 0x00000001,
    EcDeliveryModePush = 0x00000002,
}

///The <b>EC_SUBSCRIPTION_CONTENT_FORMAT</b> enumeration specifies how events will be rendered on the computer that
///sends the events before the events are sent to the event collector computer.
alias EC_SUBSCRIPTION_CONTENT_FORMAT = int;
enum : int
{
    ///When an event is received, the Event Collector service sends an event as the received event to an event log. The
    ///service sends the raw event data only, and not any localized event data.
    EcContentFormatEvents       = 0x00000001,
    EcContentFormatRenderedText = 0x00000002,
}

///The <b>EC_SUBSCRIPTION_RUNTIME_STATUS_ACTIVE_STATUS</b> enumeration specifies the status of a subscription or an
///event source with respect to a subscription.
alias EC_SUBSCRIPTION_RUNTIME_STATUS_ACTIVE_STATUS = int;
enum : int
{
    ///The subscription or event source is disabled.
    EcRuntimeStatusActiveStatusDisabled = 0x00000001,
    ///The subscription or event source is running.
    EcRuntimeStatusActiveStatusActive   = 0x00000002,
    ///The subscription or event source is inactive. You can query the System event log to see the error events sent by
    ///the Event Collector service. Use the EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID values to obtain information on why
    ///the subscription or source is inactive.
    EcRuntimeStatusActiveStatusInactive = 0x00000003,
    EcRuntimeStatusActiveStatusTrying   = 0x00000004,
}

// Structs


///The <b>EC_VARIANT</b> structure contains event collector data (subscription data) or property values.
struct EC_VARIANT
{
    union
    {
        BOOL          BooleanVal;
        uint          UInt32Val;
        ulong         DateTimeVal;
        const(wchar)* StringVal;
        ubyte*        BinaryVal;
        int*          BooleanArr;
        int*          Int32Arr;
        ushort**      StringArr;
        ptrdiff_t     PropertyHandleVal;
    }
    ///The number of elements (not length) in bytes. Used for arrays and binary or string types.
    uint Count;
    uint Type;
}

// Functions

///The <b>EcOpenSubscriptionEnum</b> function is creates a subscription enumerator to enumerate all registered
///subscriptions on the local machine.
///Params:
///    Flags = Reserved. Must be 0.
///Returns:
///    If the function succeeds, it returns an handle (EC_HANDLE) to a new subscription enumerator object. Returns
///    <b>NULL</b> otherwise, in which case use the GetLastError function to obtain the error code.
///    
@DllImport("WecApi")
ptrdiff_t EcOpenSubscriptionEnum(uint Flags);

///The <b>EcEnumNextSubscription</b> function continues the enumeration of the subscriptions registered on the local
///machine.
///Params:
///    SubscriptionEnum = The handle to the enumerator object that is returned from the EcOpenSubscriptionEnum function.
///    SubscriptionNameBufferSize = The size of the user-supplied buffer (in chars) to store the subscription name.
///    SubscriptionNameBuffer = The user-supplied buffer to store the subscription name.
///    SubscriptionNameBufferUsed = The size of the user-supplied buffer that is used by the function on successful return, or the size that is
///                                 necessary to store the subscription name when the function fails with <b>ERROR_INSUFFICIENT_BUFFER</b>.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcEnumNextSubscription(ptrdiff_t SubscriptionEnum, uint SubscriptionNameBufferSize, 
                            const(wchar)* SubscriptionNameBuffer, uint* SubscriptionNameBufferUsed);

///The <b>EcOpenSubscription</b> function is used to open an existing subscription or create a new subscription
///according to the flag value specified.
///Params:
///    SubscriptionName = Specifies the name of the subscription. The value provided for this parameter should be unique within the
///                       computer's scope.
///    AccessMask = An access mask that specifies the desired access rights to the subscription. Use the EC_READ_ACCESS or
///                 EC_WRITE_ACCESS constants to specify the access rights. The function fails if the security descriptor of the
///                 subscription does not permit the requested access for the calling process.
///    Flags = A value specifying whether a new or existing subscription will be opened. Use the <b>EC_CREATE_NEW</b>,
///            <b>EC_OPEN_ALWAYS</b>, or <b>EC_OPEN_EXISTING</b> constants.
///Returns:
///    If the function succeeds, it returns an handle (EC_HANDLE) to a new subscription object. Returns <b>NULL</b>
///    otherwise, in which case use the GetLastError function to obtain the error code.
///    
@DllImport("WecApi")
ptrdiff_t EcOpenSubscription(const(wchar)* SubscriptionName, uint AccessMask, uint Flags);

///The <b>EcSetSubscriptionProperty</b> function sets new values or updates existing values of a subscription. New
///values set through this method will not be active unless they are saved by the EcSaveSubscription method.
///Params:
///    Subscription = The handle to the subscription object.
///    PropertyId = A value from the EC_SUBSCRIPTION_PROPERTY_ID enumeration that specifies which property of the subscription to
///                 set.
///    Flags = Reserved. Must be 0.
///    PropertyValue = The value of the property to set for the indicated subscription property.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcSetSubscriptionProperty(ptrdiff_t Subscription, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint Flags, 
                               EC_VARIANT* PropertyValue);

///The <b>EcGetSubscriptionProperty</b> function retrieves a specific property value from a subscription object. The
///subscription object is specified by the handle passed into the <i>Subscription</i> parameter.
///Params:
///    Subscription = The handle to the subscription object.
///    PropertyId = An identifier that specifies which property of the subscription to get. Specify a value from the
///                 EC_SUBSCRIPTION_PROPERTY_ID enumeration. If you specify the <b>EcSubscriptionEventSources</b> value, then a
///                 handle to an array (EC_OBJECT_ARRAY_PROPERTY_HANDLE) will be returned. You can then use the
///                 EcGetObjectArrayProperty and EcSetObjectArrayProperty functions to get and set the Address, Enabled, UserName,
///                 and Password properties in the array.
///    Flags = Reserved. Must be <b>NULL</b>.
///    PropertyValueBufferSize = The size of the user-supplied buffer to store the property value into.
///    PropertyValueBuffer = The user-supplied buffer to store property value into.
///    PropertyValueBufferUsed = The size of the user-supplied buffer that is used by the function on successful return, or the size that is
///                              necessary to store the property value when function fails with <b>ERROR_INSUFFICIENT_BUFFER</b>.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcGetSubscriptionProperty(ptrdiff_t Subscription, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint Flags, 
                               uint PropertyValueBufferSize, EC_VARIANT* PropertyValueBuffer, 
                               uint* PropertyValueBufferUsed);

///The <b>EcSaveSubscription</b> function saves subscription configuration information. This function should be called
///whenever new values are added or updated to the subscription by the EcSetSubscriptionProperty method. If the
///subscription is enabled, the subscription will be activated when it is saved.
///Params:
///    Subscription = The handle to the subscription object.
///    Flags = Reserved. Must be <b>NULL</b>.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcSaveSubscription(ptrdiff_t Subscription, uint Flags);

///The <b>EcDeleteSubscription</b> function deletes an existing subscription that is specified by the
///<i>SubscriptionName</i> parameter. The function fails if the security descriptor of the subscription does not permit
///delete access for the calling process. If the subscription is active at the moment this API is called, then the
///subscription is deactivated.
///Params:
///    SubscriptionName = The subscription to be deleted.
///    Flags = Reserved, must be 0.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcDeleteSubscription(const(wchar)* SubscriptionName, uint Flags);

///The <b>EcGetObjectArraySize</b> function retrieves the size (the number of indexes) of the array of property values
///for the event sources of a subscription.
///Params:
///    ObjectArray = A handle to the array from which to get the size. The array contains property values for the event sources of a
///                  subscription. The array handle is returned by the EcGetSubscriptionProperty method when the
///                  <b>EcSubscriptionEventSources</b> value is passed into the <i>PropertyId</i> parameter.
///    ObjectArraySize = The size of the array (the number of indexes).
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcGetObjectArraySize(ptrdiff_t ObjectArray, uint* ObjectArraySize);

///The <b>EcSetObjectArrayProperty</b> function sets a property value in an array of property values for the event
///sources of a subscription.
///Params:
///    ObjectArray = A handle to the array that contains the property value to set. The array contains property values for the event
///                  sources of a subscription. The array handle is returned by the EcGetSubscriptionProperty method when the
///                  <b>EcSubscriptionEventSources</b> value is passed into the <i>Subscription</i> parameter.
///    PropertyId = An identifier that specifies which property to set. Specify a value from the EC_SUBSCRIPTION_PROPERTY_ID
///                 enumeration. Set the Address, Enabled, UserName, and Password properties in the array by specifying the
///                 <b>EcSubscriptionEventSourceAddress</b>, <b>EcSubscriptionEventSourceEnabled</b>,
///                 <b>EcSubscriptionEventSourceUserName</b>, or <b>EcSubscriptionEventSourcePassword</b> values.
///    ArrayIndex = The index of the object in the array to set a property value on.
///    Flags = Reserved. Must be 0.
///    PropertyValue = The value of the property.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcSetObjectArrayProperty(ptrdiff_t ObjectArray, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint ArrayIndex, 
                              uint Flags, EC_VARIANT* PropertyValue);

///The <b>EcGetObjectArrayProperty</b> function retrieves property values from a handle to an array of event source
///properties. The array contains property values for the event sources of a subscription.
///Params:
///    ObjectArray = A handle to an array of properties for the event sources for a subscription. An array handle that is returned by
///                  the EcGetSubscriptionProperty method when the <b>EcSubscriptionEventSources</b> value is passed into the
///                  <i>PropertyId</i> parameter.
///    PropertyId = The property identifier for properties in the array. Specify a value from the EC_SUBSCRIPTION_PROPERTY_ID
///                 enumeration. Get the <b>Address</b>, <b>Enabled</b>, <b>UserName</b>, and <b>Password</b> properties in the array
///                 by specifying the <b>EcSubscriptionEventSourceAddress</b>, <b>EcSubscriptionEventSourceEnabled</b>,
///                 <b>EcSubscriptionEventSourceUserName</b>, or <b>EcSubscriptionEventSourcePassword</b> values.
///    ArrayIndex = The index of the array that specifies which event source to get the property from.
///    Flags = Reserved. Must be 0.
///    PropertyValueBufferSize = The size of the buffer that contains the value of the property. The size must be at least the size of an
///                              EC_VARIANT value.
///    PropertyValueBuffer = The user-supplied buffer to store property value into.
///    PropertyValueBufferUsed = The size of the user-supplied buffer that is used by the function on successful return, or the size that is
///                              necessary to store the property value when the function fails with <b>ERROR_INSUFFICIENT_BUFFER</b>.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcGetObjectArrayProperty(ptrdiff_t ObjectArray, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint ArrayIndex, 
                              uint Flags, uint PropertyValueBufferSize, EC_VARIANT* PropertyValueBuffer, 
                              uint* PropertyValueBufferUsed);

///The <b>EcInsertObjectArrayElement</b> function inserts an empty object into an array of property values for the event
///sources of a subscription. The object is inserted at a specified array index.
///Params:
///    ObjectArray = A handle to the array in which the object is inserted into. The array contains property values for the event
///                  sources of a subscription. The array handle is returned by the EcGetSubscriptionProperty method when the
///                  <b>EcSubscriptionEventSources</b> value is passed into the <i>Subscription</i> parameter.
///    ArrayIndex = An array index indicating where to insert the object.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcInsertObjectArrayElement(ptrdiff_t ObjectArray, uint ArrayIndex);

///The <b>EcRemoveObjectArrayElement</b> function removes an element from an array of objects that contain property
///values for the event sources of a subscription.
///Params:
///    ObjectArray = A handle to the array in which to remove the element. The array contains property values for the event sources of
///                  a subscription. The array handle is returned by the EcGetSubscriptionProperty method when the
///                  <b>EcSubscriptionEventSources</b> value is passed into the <i>Subscription</i> parameter.
///    ArrayIndex = The index of the element to remove from the array.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcRemoveObjectArrayElement(ptrdiff_t ObjectArray, uint ArrayIndex);

///The <b>EcGetSubscriptionRunTimeStatus</b> function retrieves the run time status information for an event source of a
///subscription or the subscription itself. The subscription is specified by its name. If the event source is
///<b>NULL</b>, then the status for the overall subscription is retrieved.
///Params:
///    SubscriptionName = The name of the subscription to get the run time status information from.
///    StatusInfoId = An identifier that specifies which run time status information to get from the subscription. Specify a value from
///                   the EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID enumeration. The <b>EcSubscriptionRunTimeStatusEventSources</b> value
///                   can be used to obtain the list of event sources associated with a subscription.
///    EventSourceName = The name of the event source to get the status from. Each subscription can have multiple event sources.
///    Flags = Reserved. Must be <b>NULL</b>.
///    StatusValueBufferSize = The size of the user-supplied buffer that will hold the run time status information.
///    StatusValueBuffer = The user-supplied buffer that will hold the run time status information. The buffer will hold the appropriate
///                        value depending on the EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID value passed into the <i>StatusInfoId</i>
///                        parameter.
///    StatusValueBufferUsed = The size of the user supplied buffer that is used by the function on successful return, or the size that is
///                            necessary to store the property value when function fails with <b>ERROR_INSUFFICIENT_BUFFER</b>.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcGetSubscriptionRunTimeStatus(const(wchar)* SubscriptionName, 
                                    EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID StatusInfoId, 
                                    const(wchar)* EventSourceName, uint Flags, uint StatusValueBufferSize, 
                                    EC_VARIANT* StatusValueBuffer, uint* StatusValueBufferUsed);

///The <b>EcRetrySubscription</b> function is used to retry connecting to the event source of a subscription that is not
///connected.
///Params:
///    SubscriptionName = The name of the subscription to which to connect.
///    EventSourceName = The name of the event source of the subscription. This parameter is optional and can be <b>NULL</b>. This
///                      parameter must be <b>NULL</b> when the subscription is source initiated. If this parameter is <b>NULL</b>, the
///                      entire subscription will be retried.
///    Flags = Reserved. Must be <b>NULL</b>.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcRetrySubscription(const(wchar)* SubscriptionName, const(wchar)* EventSourceName, uint Flags);

///The <b>EcClose</b> function closes a handle received from other Event Collector functions. Any handle returned by an
///event collector management API call must be closed using this call when the user is finished with the handle. The
///handle becomes invalid when this function is successfully called.
///Params:
///    Object = A valid open handle returned from an event collector management API call.
///Returns:
///    This function returns BOOL.
///    
@DllImport("WecApi")
BOOL EcClose(ptrdiff_t Object);


