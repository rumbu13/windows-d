module windows.windowseventcollector;

public import windows.systemservices;

extern(Windows):

enum EC_SUBSCRIPTION_PROPERTY_ID
{
    EcSubscriptionEnabled = 0,
    EcSubscriptionEventSources = 1,
    EcSubscriptionEventSourceAddress = 2,
    EcSubscriptionEventSourceEnabled = 3,
    EcSubscriptionEventSourceUserName = 4,
    EcSubscriptionEventSourcePassword = 5,
    EcSubscriptionDescription = 6,
    EcSubscriptionURI = 7,
    EcSubscriptionConfigurationMode = 8,
    EcSubscriptionExpires = 9,
    EcSubscriptionQuery = 10,
    EcSubscriptionTransportName = 11,
    EcSubscriptionTransportPort = 12,
    EcSubscriptionDeliveryMode = 13,
    EcSubscriptionDeliveryMaxItems = 14,
    EcSubscriptionDeliveryMaxLatencyTime = 15,
    EcSubscriptionHeartbeatInterval = 16,
    EcSubscriptionLocale = 17,
    EcSubscriptionContentFormat = 18,
    EcSubscriptionLogFile = 19,
    EcSubscriptionPublisherName = 20,
    EcSubscriptionCredentialsType = 21,
    EcSubscriptionCommonUserName = 22,
    EcSubscriptionCommonPassword = 23,
    EcSubscriptionHostName = 24,
    EcSubscriptionReadExistingEvents = 25,
    EcSubscriptionDialect = 26,
    EcSubscriptionType = 27,
    EcSubscriptionAllowedIssuerCAs = 28,
    EcSubscriptionAllowedSubjects = 29,
    EcSubscriptionDeniedSubjects = 30,
    EcSubscriptionAllowedSourceDomainComputers = 31,
    EcSubscriptionPropertyIdEND = 32,
}

enum EC_SUBSCRIPTION_CREDENTIALS_TYPE
{
    EcSubscriptionCredDefault = 0,
    EcSubscriptionCredNegotiate = 1,
    EcSubscriptionCredDigest = 2,
    EcSubscriptionCredBasic = 3,
    EcSubscriptionCredLocalMachine = 4,
}

enum EC_SUBSCRIPTION_TYPE
{
    EcSubscriptionTypeSourceInitiated = 0,
    EcSubscriptionTypeCollectorInitiated = 1,
}

enum EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID
{
    EcSubscriptionRunTimeStatusActive = 0,
    EcSubscriptionRunTimeStatusLastError = 1,
    EcSubscriptionRunTimeStatusLastErrorMessage = 2,
    EcSubscriptionRunTimeStatusLastErrorTime = 3,
    EcSubscriptionRunTimeStatusNextRetryTime = 4,
    EcSubscriptionRunTimeStatusEventSources = 5,
    EcSubscriptionRunTimeStatusLastHeartbeatTime = 6,
    EcSubscriptionRunTimeStatusInfoIdEND = 7,
}

enum EC_VARIANT_TYPE
{
    EcVarTypeNull = 0,
    EcVarTypeBoolean = 1,
    EcVarTypeUInt32 = 2,
    EcVarTypeDateTime = 3,
    EcVarTypeString = 4,
    EcVarObjectArrayPropertyHandle = 5,
}

struct EC_VARIANT
{
    _Anonymous_e__Union Anonymous;
    uint Count;
    uint Type;
}

enum EC_SUBSCRIPTION_CONFIGURATION_MODE
{
    EcConfigurationModeNormal = 0,
    EcConfigurationModeCustom = 1,
    EcConfigurationModeMinLatency = 2,
    EcConfigurationModeMinBandwidth = 3,
}

enum EC_SUBSCRIPTION_DELIVERY_MODE
{
    EcDeliveryModePull = 1,
    EcDeliveryModePush = 2,
}

enum EC_SUBSCRIPTION_CONTENT_FORMAT
{
    EcContentFormatEvents = 1,
    EcContentFormatRenderedText = 2,
}

enum EC_SUBSCRIPTION_RUNTIME_STATUS_ACTIVE_STATUS
{
    EcRuntimeStatusActiveStatusDisabled = 1,
    EcRuntimeStatusActiveStatusActive = 2,
    EcRuntimeStatusActiveStatusInactive = 3,
    EcRuntimeStatusActiveStatusTrying = 4,
}

@DllImport("WecApi.dll")
int EcOpenSubscriptionEnum(uint Flags);

@DllImport("WecApi.dll")
BOOL EcEnumNextSubscription(int SubscriptionEnum, uint SubscriptionNameBufferSize, const(wchar)* SubscriptionNameBuffer, uint* SubscriptionNameBufferUsed);

@DllImport("WecApi.dll")
int EcOpenSubscription(const(wchar)* SubscriptionName, uint AccessMask, uint Flags);

@DllImport("WecApi.dll")
BOOL EcSetSubscriptionProperty(int Subscription, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint Flags, EC_VARIANT* PropertyValue);

@DllImport("WecApi.dll")
BOOL EcGetSubscriptionProperty(int Subscription, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint Flags, uint PropertyValueBufferSize, EC_VARIANT* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("WecApi.dll")
BOOL EcSaveSubscription(int Subscription, uint Flags);

@DllImport("WecApi.dll")
BOOL EcDeleteSubscription(const(wchar)* SubscriptionName, uint Flags);

@DllImport("WecApi.dll")
BOOL EcGetObjectArraySize(int ObjectArray, uint* ObjectArraySize);

@DllImport("WecApi.dll")
BOOL EcSetObjectArrayProperty(int ObjectArray, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint ArrayIndex, uint Flags, EC_VARIANT* PropertyValue);

@DllImport("WecApi.dll")
BOOL EcGetObjectArrayProperty(int ObjectArray, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint ArrayIndex, uint Flags, uint PropertyValueBufferSize, EC_VARIANT* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("WecApi.dll")
BOOL EcInsertObjectArrayElement(int ObjectArray, uint ArrayIndex);

@DllImport("WecApi.dll")
BOOL EcRemoveObjectArrayElement(int ObjectArray, uint ArrayIndex);

@DllImport("WecApi.dll")
BOOL EcGetSubscriptionRunTimeStatus(const(wchar)* SubscriptionName, EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID StatusInfoId, const(wchar)* EventSourceName, uint Flags, uint StatusValueBufferSize, EC_VARIANT* StatusValueBuffer, uint* StatusValueBufferUsed);

@DllImport("WecApi.dll")
BOOL EcRetrySubscription(const(wchar)* SubscriptionName, const(wchar)* EventSourceName, uint Flags);

@DllImport("WecApi.dll")
BOOL EcClose(int Object);

