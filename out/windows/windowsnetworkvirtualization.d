module windows.windowsnetworkvirtualization;

public import windows.core;
public import windows.iphelper : NL_DAD_STATE;
public import windows.systemservices : HANDLE, OVERLAPPED;
public import windows.winsock : in6_addr, in_addr;
public import windows.windowsfiltering : DL_EUI48;

extern(Windows):


// Enums


enum : int
{
    WnvPolicyMismatchType  = 0x00000000,
    WnvRedirectType        = 0x00000001,
    WnvObjectChangeType    = 0x00000002,
    WnvNotificationTypeMax = 0x00000003,
}
alias WNV_NOTIFICATION_TYPE = int;

enum : int
{
    WnvProviderAddressType = 0x00000000,
    WnvCustomerAddressType = 0x00000001,
    WnvObjectTypeMax       = 0x00000002,
}
alias WNV_OBJECT_TYPE = int;

enum : int
{
    WnvCustomerAddressAdded   = 0x00000000,
    WnvCustomerAddressDeleted = 0x00000001,
    WnvCustomerAddressMoved   = 0x00000002,
    WnvCustomerAddressMax     = 0x00000003,
}
alias WNV_CA_NOTIFICATION_TYPE = int;

// Structs


struct WNV_OBJECT_HEADER
{
    ubyte MajorVersion;
    ubyte MinorVersion;
    uint  Size;
}

struct WNV_NOTIFICATION_PARAM
{
    WNV_OBJECT_HEADER Header;
    WNV_NOTIFICATION_TYPE NotificationType;
    uint              PendingNotifications;
    ubyte*            Buffer;
}

struct WNV_IP_ADDRESS
{
    union IP
    {
        in_addr   v4;
        in6_addr  v6;
        ubyte[16] Addr;
    }
}

struct WNV_POLICY_MISMATCH_PARAM
{
    ushort         CAFamily;
    ushort         PAFamily;
    uint           VirtualSubnetId;
    WNV_IP_ADDRESS CA;
    WNV_IP_ADDRESS PA;
}

struct WNV_PROVIDER_ADDRESS_CHANGE_PARAM
{
    ushort         PAFamily;
    WNV_IP_ADDRESS PA;
    NL_DAD_STATE   AddressState;
}

struct WNV_CUSTOMER_ADDRESS_CHANGE_PARAM
{
    DL_EUI48       MACAddress;
    ushort         CAFamily;
    WNV_IP_ADDRESS CA;
    uint           VirtualSubnetId;
    ushort         PAFamily;
    WNV_IP_ADDRESS PA;
    WNV_CA_NOTIFICATION_TYPE NotificationReason;
}

struct WNV_OBJECT_CHANGE_PARAM
{
    WNV_OBJECT_TYPE ObjectType;
    union ObjectParam
    {
        WNV_PROVIDER_ADDRESS_CHANGE_PARAM ProviderAddressChange;
        WNV_CUSTOMER_ADDRESS_CHANGE_PARAM CustomerAddressChange;
    }
}

struct WNV_REDIRECT_PARAM
{
    ushort         CAFamily;
    ushort         PAFamily;
    ushort         NewPAFamily;
    uint           VirtualSubnetId;
    WNV_IP_ADDRESS CA;
    WNV_IP_ADDRESS PA;
    WNV_IP_ADDRESS NewPA;
}

// Functions

@DllImport("wnvapi")
HANDLE WnvOpen();

@DllImport("wnvapi")
uint WnvRequestNotification(HANDLE WnvHandle, WNV_NOTIFICATION_PARAM* NotificationParam, OVERLAPPED* Overlapped, 
                            uint* BytesTransferred);


