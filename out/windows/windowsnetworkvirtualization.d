// Written in the D programming language.

module windows.windowsnetworkvirtualization;

public import windows.core;
public import windows.iphelper : NL_DAD_STATE;
public import windows.systemservices : HANDLE, OVERLAPPED;
public import windows.winsock : in6_addr, in_addr;
public import windows.windowsfiltering : DL_EUI48;

extern(Windows) @nogc nothrow:


// Enums


///Specifies the type of a given Windows Network Virtualization (WNV) notification.
alias WNV_NOTIFICATION_TYPE = int;
enum : int
{
    ///A policy mismatch notification.
    WnvPolicyMismatchType  = 0x00000000,
    ///A notification that an Internet Control Message Protocol (ICMP) redirect message has been received.
    WnvRedirectType        = 0x00000001,
    ///A notification that a network object has changed.
    WnvObjectChangeType    = 0x00000002,
    ///The maximum possible value for this enumeration type. This is not a legal value.
    WnvNotificationTypeMax = 0x00000003,
}

///Specifies the object type of a given Windows Network Virtualization (WNV) notification when the WNV notification type
///is <b>WnvObjectChangeType</b>.
alias WNV_OBJECT_TYPE = int;
enum : int
{
    ///The notification is about a change in a property of a provider address object.
    WnvProviderAddressType = 0x00000000,
    WnvCustomerAddressType = 0x00000001,
    ///The maximum possible value for this enumeration type. This is not a legal value.
    WnvObjectTypeMax       = 0x00000002,
}

alias WNV_CA_NOTIFICATION_TYPE = int;
enum : int
{
    WnvCustomerAddressAdded   = 0x00000000,
    WnvCustomerAddressDeleted = 0x00000001,
    WnvCustomerAddressMoved   = 0x00000002,
    WnvCustomerAddressMax     = 0x00000003,
}

// Structs


///Specifies the major version, minor version, and buffer size of the WNV_NOTIFICATION_PARAM structure that is passed to
///the WnvRequestNotification function.
struct WNV_OBJECT_HEADER
{
    ///Type: <b>UCHAR</b> The major version number. This value must be <b>WNV_API_MAJOR_VERSION_1</b>.
    ubyte MajorVersion;
    ///Type: <b>UCHAR</b> The minor version number. This value must be <b>WNV_API_MINOR_VERSION_0</b>.
    ubyte MinorVersion;
    ///Type: <b>ULONG</b> The size of the <b>Buffer</b> field in the WNV_NOTIFICATION_PARAM structure that is passed to
    ///the WnvRequestNotification function.
    uint  Size;
}

///Specifies the version, notification type, and the buffer location in a WnvRequestNotification function call. The
///buffer specified in this structure is filled by the Windows Network Virtualization (WNV) driver when the
///notifications of the specific type are available.
struct WNV_NOTIFICATION_PARAM
{
    ///Type: <b>WNV_OBJECT_HEADER</b> The version and buffer size for this structure.
    WNV_OBJECT_HEADER Header;
    ///Type: <b>WNV_NOTIFICATION_TYPE</b> A value of the WNV_NOTIFICATION_TYPE enumeration that specifies the type of
    ///notifications requested, such as policy mismatches, Internet Control Message Protocol (ICMP) redirect message
    ///arrivals, and object changes.
    WNV_NOTIFICATION_TYPE NotificationType;
    ///Type: <b>ULONG</b> An output value that provides the caller information about the number of pending events of the
    ///specified notification type. The pending events are queued within the WNV driver along with the events that have
    ///already been added to the <b>Buffer</b> field when the current WnvRequestNotification function call is completed.
    ///This field allows the WNV driver to indicate the number of remaining events to the caller of
    ///<b>WnvRequestNotification</b>, so the caller can estimate the size of the buffer required. The caller should post
    ///another call with enough buffer size to <b>WnvRequestNotification</b> to consume these remaining events.
    uint              PendingNotifications;
    ubyte*            Buffer;
}

///Defines an IP address object.
struct WNV_IP_ADDRESS
{
union IP
    {
        in_addr   v4;
        in6_addr  v6;
        ubyte[16] Addr;
    }
}

///Specifies the parameters of an event (typically an incoming packet) that causes the Windows Network Virtualization
///(WNV) driver to generate a <b>WnvPolicyMismatchType</b> notification. As a result, the WNV driver fills the buffer
///that is passed in the <i>NotificationParam</i> argument's WNV_NOTIFICATION_PARAM structure with one or more instances
///of this structure and completes the WnvRequestNotification function call.
struct WNV_POLICY_MISMATCH_PARAM
{
    ///Type: <b>ADDRESS_FAMILY</b> The address family (<b>AF_INET</b> or <b>AF_INET6</b>) for the customer address.
    ushort         CAFamily;
    ///Type: <b>ADDRESS_FAMILY</b> The address family (<b>AF_INET</b> or <b>AF_INET6</b>) for the provider address.
    ushort         PAFamily;
    ///Type: <b>ULONG</b> The identifier of a customer virtual subnet. This value ranges from 4096 (0x00001000) to
    ///16777214 (0x00FFFFFE).
    uint           VirtualSubnetId;
    ///Type: <b>WNV_IP_ADDRESS</b> The IP address object for the customer address, which is the IP address configured on
    ///the virtual machine for network virtualization.
    WNV_IP_ADDRESS CA;
    ///Type: <b>WNV_IP_ADDRESS</b> The IP address object for the provider address, which is the matching IP address used
    ///on the physical network for the customer address.
    WNV_IP_ADDRESS PA;
}

///Specifies the provider address's DAD (duplicate address detection) status change, which causes the Windows Network
///Virtualization (WNV) driver to generate a <b>WnvObjectChangeType</b> notification that specifies the
///<b>WnvProviderAddressType</b> object type containing this structure.
struct WNV_PROVIDER_ADDRESS_CHANGE_PARAM
{
    ///Type: <b>ADDRESS_FAMILY</b> The address family (<b>AF_INET</b> or <b>AF_INET6</b>) for the provider address.
    ushort         PAFamily;
    ///Type: <b>WNV_IP_ADDRESS</b> The IP address object for the provider address, which is the matching IP address used
    ///on the physical network for the customer address.
    WNV_IP_ADDRESS PA;
    ///Type: <b>NL_DAD_STATE</b> A value of the NL_DAD_STATE enumeration that represents the new DAD state. Duplicate
    ///address detection is applicable to both IPv4 and IPv6 addresses. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IpDadStateInvalid"></a><a id="ipdadstateinvalid"></a><a
    ///id="IPDADSTATEINVALID"></a><dl> <dt><b>IpDadStateInvalid</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The DAD
    ///state is not valid. </td> </tr> <tr> <td width="40%"><a id="IpDadStateTentative"></a><a
    ///id="ipdadstatetentative"></a><a id="IPDADSTATETENTATIVE"></a><dl> <dt><b>IpDadStateTentative</b></dt> <dt>1</dt>
    ///</dl> </td> <td width="60%"> The DAD state is tentative. </td> </tr> <tr> <td width="40%"><a
    ///id="IpDadStateDuplicate"></a><a id="ipdadstateduplicate"></a><a id="IPDADSTATEDUPLICATE"></a><dl>
    ///<dt><b>IpDadStateDuplicate</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> A duplicate IP address has been
    ///detected. </td> </tr> <tr> <td width="40%"><a id="IpDadStateDeprecated"></a><a id="ipdadstatedeprecated"></a><a
    ///id="IPDADSTATEDEPRECATED"></a><dl> <dt><b>IpDadStateDeprecated</b></dt> <dt>3</dt> </dl> </td> <td width="60%">
    ///The IP address has been deprecated. </td> </tr> <tr> <td width="40%"><a id="IpDadStatePreferred"></a><a
    ///id="ipdadstatepreferred"></a><a id="IPDADSTATEPREFERRED"></a><dl> <dt><b>IpDadStatePreferred</b></dt> <dt>4</dt>
    ///</dl> </td> <td width="60%"> The IP address is the preferred address. </td> </tr> </table>
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

///Specifies the parameters of an event that causes the Windows Network Virtualization (WNV) driver to generate a
///<b>WnvObjectChangeType</b> type of notification. If there is a pending call to the WnvRequestNotification function of
///this type, the WNV driver fills the buffer that is passed in the <i>NotificationParam</i> argument's
///WNV_NOTIFICATION_PARAM structure with one or more instances of this structure and completes the
///<b>WnvRequestNotification</b> function call.
struct WNV_OBJECT_CHANGE_PARAM
{
    ///Type: <b>WNV_OBJECT_TYPE</b> The object type that causes the change notification.
    WNV_OBJECT_TYPE ObjectType;
union ObjectParam
    {
        WNV_PROVIDER_ADDRESS_CHANGE_PARAM ProviderAddressChange;
        WNV_CUSTOMER_ADDRESS_CHANGE_PARAM CustomerAddressChange;
    }
}

///Specifies the parameters of the event (receiving an incoming Internet Control Message Protocol redirect packet) that
///causes the Windows Network Virtualization (WNV) driver to generate a <b>WnvRedirectType</b> notification. If there is
///a pending call to the WnvRequestNotification function of this type, the WNV driver fills the buffer that is passed in
///the <i>NotificationParam</i> argument's WNV_NOTIFICATION_PARAM structure with one or more instances of this structure
///and completes the <b>WnvRequestNotification</b> function call.
struct WNV_REDIRECT_PARAM
{
    ///Type: <b>ADDRESS_FAMILY</b> The address family (<b>AF_INET</b> or <b>AF_INET6</b>) for the customer address.
    ushort         CAFamily;
    ///Type: <b>ADDRESS_FAMILY</b> The address family (<b>AF_INET</b> or <b>AF_INET6</b>) for the original provider
    ///address.
    ushort         PAFamily;
    ///Type: <b>ADDRESS_FAMILY</b> The address family (<b>AF_INET</b> or <b>AF_INET6</b>) for the new provider address.
    ushort         NewPAFamily;
    ///Type: <b>ULONG</b> The identifier of a customer virtual subnet. This value ranges from 4096 (0x00001000) to
    ///16777214 (0x00FFFFFE).
    uint           VirtualSubnetId;
    ///Type: <b>WNV_IP_ADDRESS</b> The IP address object for the customer address, which is the IP address configured on
    ///the virtual machine for network virtualization.
    WNV_IP_ADDRESS CA;
    ///Type: <b>WNV_IP_ADDRESS</b> The IP address object for the provider address, which is the matching IP address used
    ///on the physical network for the customer address.
    WNV_IP_ADDRESS PA;
    ///Type: <b>WNV_IP_ADDRESS</b> The updated provider address when a virtual machine is migrated from one host to
    ///another.
    WNV_IP_ADDRESS NewPA;
}

// Functions

///Provides a handle to the Windows Network Virtualization (WNV) driver object to be used to request and receive WNV
///notifications.
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, it returns the handle to the WNV driver object. If the function
///    fails, it returns <b>NULL</b>.
///    
@DllImport("wnvapi")
HANDLE WnvOpen();

///Requests notification from the Windows Network Virtualization (WNV) driver whenever a certain type of event occurs.
///Params:
///    WnvHandle = Type: <b>HANDLE</b> An object handle that is returned from a call to the WnvOpen function.
///    NotificationParam = Type: <b>PWNV_NOTIFICATION_PARAM</b> A pointer to the notification type for the request.
///    Overlapped = Type: <b>LPOVERLAPPED</b> Information about the asynchronous completion of this request. If this parameter is
///                 <b>NULL</b>, the request is synchronous.
///    BytesTransferred = Type: <b>PULONG</b> When this function returns, the <i>BytesTransferred</i> parameter points to the size of the
///                       buffer that is filled with the notification structures of the specific event type.
///Returns:
///    Type: <b>ULONG</b> If the operation succeeds, the function returns <b>ERROR_SUCCESS</b>. If the operation fails,
///    the function returns one of the following system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> There is a problem with the <i>NotificationParam</i> parameter, in the WNV_NOTIFICATION_PARAM
///    structure's <b>Header</b> field: <ul> <li>The major and minor version values of the WNV_OBJECT_HEADER structure
///    are incorrect</li> <li>The size specified in the WNV_OBJECT_HEADER structure is smaller than at least one
///    notification structure of these types:<ul> <li> WNV_OBJECT_CHANGE_PARAM </li> <li> WNV_POLICY_MISMATCH_PARAM
///    </li> <li> WNV_REDIRECT_PARAM </li> </ul> </li> </ul> </td> </tr> </table>
///    
@DllImport("wnvapi")
uint WnvRequestNotification(HANDLE WnvHandle, WNV_NOTIFICATION_PARAM* NotificationParam, OVERLAPPED* Overlapped, 
                            uint* BytesTransferred);


