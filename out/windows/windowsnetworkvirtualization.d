module windows.windowsnetworkvirtualization;

public import windows.iphelper;
public import windows.systemservices;
public import windows.windowsfiltering;

extern(Windows):

enum WNV_NOTIFICATION_TYPE
{
    WnvPolicyMismatchType = 0,
    WnvRedirectType = 1,
    WnvObjectChangeType = 2,
    WnvNotificationTypeMax = 3,
}

enum WNV_OBJECT_TYPE
{
    WnvProviderAddressType = 0,
    WnvCustomerAddressType = 1,
    WnvObjectTypeMax = 2,
}

enum WNV_CA_NOTIFICATION_TYPE
{
    WnvCustomerAddressAdded = 0,
    WnvCustomerAddressDeleted = 1,
    WnvCustomerAddressMoved = 2,
    WnvCustomerAddressMax = 3,
}

struct WNV_OBJECT_HEADER
{
    ubyte MajorVersion;
    ubyte MinorVersion;
    uint Size;
}

struct WNV_NOTIFICATION_PARAM
{
    WNV_OBJECT_HEADER Header;
    WNV_NOTIFICATION_TYPE NotificationType;
    uint PendingNotifications;
    ubyte* Buffer;
}

struct WNV_IP_ADDRESS
{
    _IP_e__Union IP;
}

struct WNV_POLICY_MISMATCH_PARAM
{
    ushort CAFamily;
    ushort PAFamily;
    uint VirtualSubnetId;
    WNV_IP_ADDRESS CA;
    WNV_IP_ADDRESS PA;
}

struct WNV_PROVIDER_ADDRESS_CHANGE_PARAM
{
    ushort PAFamily;
    WNV_IP_ADDRESS PA;
    NL_DAD_STATE AddressState;
}

struct WNV_CUSTOMER_ADDRESS_CHANGE_PARAM
{
    DL_EUI48 MACAddress;
    ushort CAFamily;
    WNV_IP_ADDRESS CA;
    uint VirtualSubnetId;
    ushort PAFamily;
    WNV_IP_ADDRESS PA;
    WNV_CA_NOTIFICATION_TYPE NotificationReason;
}

struct WNV_OBJECT_CHANGE_PARAM
{
    WNV_OBJECT_TYPE ObjectType;
    _ObjectParam_e__Union ObjectParam;
}

struct WNV_REDIRECT_PARAM
{
    ushort CAFamily;
    ushort PAFamily;
    ushort NewPAFamily;
    uint VirtualSubnetId;
    WNV_IP_ADDRESS CA;
    WNV_IP_ADDRESS PA;
    WNV_IP_ADDRESS NewPA;
}

@DllImport("wnvapi.dll")
HANDLE WnvOpen();

@DllImport("wnvapi.dll")
uint WnvRequestNotification(HANDLE WnvHandle, WNV_NOTIFICATION_PARAM* NotificationParam, OVERLAPPED* Overlapped, uint* BytesTransferred);

