// Written in the D programming language.

module windows.windowsfirewall;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.security : SID, SID_AND_ATTRIBUTES;
public import windows.systemservices : BOOL, HANDLE, PWSTR;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>NETCON_CHARACTERISTIC_FLAGS</b> enumeration type specifies possible
///characteristics for a network connection.
alias NETCON_CHARACTERISTIC_FLAGS = int;
enum : int
{
    ///No special characteristics.
    NCCF_NONE              = 0x00000000,
    ///Connection is available to all users.
    NCCF_ALL_USERS         = 0x00000001,
    ///Connection is duplicable.
    NCCF_ALLOW_DUPLICATION = 0x00000002,
    ///Connection is removable.
    NCCF_ALLOW_REMOVAL     = 0x00000004,
    ///Connection can be renamed.
    NCCF_ALLOW_RENAME      = 0x00000008,
    ///Direction is "incoming" only.
    NCCF_INCOMING_ONLY     = 0x00000020,
    ///Direction is "outgoing" only.
    NCCF_OUTGOING_ONLY     = 0x00000040,
    ///Icons are branded.
    NCCF_BRANDED           = 0x00000080,
    ///Connection is shared.
    NCCF_SHARED            = 0x00000100,
    ///Connection is bridged.
    NCCF_BRIDGED           = 0x00000200,
    ///Connection is firewalled.
    NCCF_FIREWALLED        = 0x00000400,
    ///Connection is the default connection.
    NCCF_DEFAULT           = 0x00000800,
    ///Device supports home networking.
    NCCF_HOMENET_CAPABLE   = 0x00001000,
    ///Connection is private (part of ICS).
    NCCF_SHARED_PRIVATE    = 0x00002000,
    ///Connection is quarantined.
    NCCF_QUARANTINED       = 0x00004000,
    ///Unused.
    NCCF_RESERVED          = 0x00008000,
    NCCF_HOSTED_NETWORK    = 0x00010000,
    NCCF_VIRTUAL_STATION   = 0x00020000,
    NCCF_WIFI_DIRECT       = 0x00040000,
    ///Bluetooth characteristics.
    NCCF_BLUETOOTH_MASK    = 0x000f0000,
    ///LAN characteristics.
    NCCF_LAN_MASK          = 0x00f00000,
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>NETCON_STATUS</b> type enumerates possible status conditions for a network
///connection.
alias NETCON_STATUS = int;
enum : int
{
    ///The connection is disconnected.
    NCS_DISCONNECTED             = 0x00000000,
    ///The connection is in the process of connecting.
    NCS_CONNECTING               = 0x00000001,
    ///The connection is in a connected state.
    NCS_CONNECTED                = 0x00000002,
    ///The connection is in the process of disconnecting.
    NCS_DISCONNECTING            = 0x00000003,
    ///The hardware for the connection, for example network interface card (NIC), is not present.
    NCS_HARDWARE_NOT_PRESENT     = 0x00000004,
    ///The hardware for the connection is present, but is not enabled.
    NCS_HARDWARE_DISABLED        = 0x00000005,
    ///A malfunction has occurred in the hardware for the connection.
    NCS_HARDWARE_MALFUNCTION     = 0x00000006,
    ///The media, for example the network cable, is disconnected.
    NCS_MEDIA_DISCONNECTED       = 0x00000007,
    ///The connection is waiting for authentication to occur.
    NCS_AUTHENTICATING           = 0x00000008,
    ///Authentication has succeeded on this connection.
    NCS_AUTHENTICATION_SUCCEEDED = 0x00000009,
    ///Authentication has failed on this connection.
    NCS_AUTHENTICATION_FAILED    = 0x0000000a,
    ///The address is invalid.
    NCS_INVALID_ADDRESS          = 0x0000000b,
    ///Security credentials are required.
    NCS_CREDENTIALS_REQUIRED     = 0x0000000c,
    NCS_ACTION_REQUIRED          = 0x0000000d,
    NCS_ACTION_REQUIRED_RETRY    = 0x0000000e,
    NCS_CONNECT_FAILED           = 0x0000000f,
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>NETCON_TYPE</b> type enumerates the various kinds of network connections.
alias NETCON_TYPE = int;
enum : int
{
    ///Direct serial connection through a serial port.
    NCT_DIRECT_CONNECT = 0x00000000,
    ///Another computer dials in to the local computer through this connection.
    NCT_INBOUND        = 0x00000001,
    ///The connection is to the public Internet.
    NCT_INTERNET       = 0x00000002,
    ///The connection is to a local area network (LAN).
    NCT_LAN            = 0x00000003,
    ///The connection is a dial-up connection over a phone line.
    NCT_PHONE          = 0x00000004,
    ///The connection is a virtual private network (VPN) connection.
    NCT_TUNNEL         = 0x00000005,
    ///The connection is a bridged connection.
    NCT_BRIDGE         = 0x00000006,
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The values of the <b>NETCON_MEDIATYPE</b> enumerate the possible ways the computer
///connects to the network.
alias NETCON_MEDIATYPE = int;
enum : int
{
    ///No media is present.
    NCM_NONE                 = 0x00000000,
    ///Direct serial connection through a serial port.
    NCM_DIRECT               = 0x00000001,
    ///Connection is through an integrated services digital network (ISDN) line.
    NCM_ISDN                 = 0x00000002,
    ///Connection is to a local area network (LAN).
    NCM_LAN                  = 0x00000003,
    ///Dial-up connection over a conventional phone line.
    NCM_PHONE                = 0x00000004,
    ///Virtual private network (VPN) connection.
    NCM_TUNNEL               = 0x00000005,
    ///Point-to-Point protocol (PPP) over Ethernet.
    NCM_PPPOE                = 0x00000006,
    ///Bridged connection.
    NCM_BRIDGE               = 0x00000007,
    ///Shared connection to a LAN.
    NCM_SHAREDACCESSHOST_LAN = 0x00000008,
    ///Shared connection to a remote or wide area network (WAN).
    NCM_SHAREDACCESSHOST_RAS = 0x00000009,
}

alias NETCONMGR_ENUM_FLAGS = int;
enum : int
{
    NCME_DEFAULT = 0x00000000,
    NCME_HIDDEN  = 0x00000001,
}

alias NETCONUI_CONNECT_FLAGS = int;
enum : int
{
    NCUC_DEFAULT        = 0x00000000,
    NCUC_NO_UI          = 0x00000001,
    NCUC_ENABLE_DISABLE = 0x00000002,
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The values of the <b>SHARINGCONNECTIONTYPE</b> type enumerate the possible types of
///shared connections.
alias SHARINGCONNECTIONTYPE = int;
enum : int
{
    ///The connection is public.
    ICSSHARINGTYPE_PUBLIC  = 0x00000000,
    ///The connection is private.
    ICSSHARINGTYPE_PRIVATE = 0x00000001,
}

alias SHARINGCONNECTION_ENUM_FLAGS = int;
enum : int
{
    ICSSC_DEFAULT = 0x00000000,
    ICSSC_ENABLED = 0x00000001,
}

alias ICS_TARGETTYPE = int;
enum : int
{
    ICSTT_NAME      = 0x00000000,
    ICSTT_IPADDRESS = 0x00000001,
}

///> [!NOTE] >The Windows Firewall API is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the [Firewall
///with Advanced Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page)Windows
///API is recommended. The **NET_FW_POLICY_TYPE** enumerated type specifies the type of policy.
alias NET_FW_POLICY_TYPE = int;
enum : int
{
    ///Policy type is group.
    NET_FW_POLICY_GROUP     = 0x00000000,
    ///Policy type is local.
    NET_FW_POLICY_LOCAL     = 0x00000001,
    ///Policy type is effective.
    NET_FW_POLICY_EFFECTIVE = 0x00000002,
    ///Used for boundary checking only. Not valid for application programming.
    NET_FW_POLICY_TYPE_MAX  = 0x00000003,
}

///> [!NOTE] >The Windows Firewall API is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the [Firewall
///with Advanced Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page)Windows
///API is recommended. The **NET_FW_PROFILE_TYPE** enumerated type specifies the type of profile.
alias NET_FW_PROFILE_TYPE = int;
enum : int
{
    ///Profile type is domain.
    NET_FW_PROFILE_DOMAIN   = 0x00000000,
    ///Profile type is standard.
    NET_FW_PROFILE_STANDARD = 0x00000001,
    ///Profile type is current.
    NET_FW_PROFILE_CURRENT  = 0x00000002,
    ///Used for boundary checking only. Not valid for application programming.
    NET_FW_PROFILE_TYPE_MAX = 0x00000003,
}

///The <b>NET_FW_PROFILE_TYPE2</b> enumerated type specifies the type of profile.
alias NET_FW_PROFILE_TYPE2 = int;
enum : int
{
    ///Profile type is domain.
    NET_FW_PROFILE2_DOMAIN  = 0x00000001,
    ///Profile type is private. This profile type is used for home and other private network types.
    NET_FW_PROFILE2_PRIVATE = 0x00000002,
    ///Profile type is public. This profile type is used for public Internet access points.
    NET_FW_PROFILE2_PUBLIC  = 0x00000004,
    NET_FW_PROFILE2_ALL     = 0x7fffffff,
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>NET_FW_IP_VERSION</b> enumerated type
///specifies the IP version for a port.
alias NET_FW_IP_VERSION = int;
enum : int
{
    ///The port supports IPv4.
    NET_FW_IP_VERSION_V4  = 0x00000000,
    ///The port supports IPv6.
    NET_FW_IP_VERSION_V6  = 0x00000001,
    ///The port supports either version of IP.
    NET_FW_IP_VERSION_ANY = 0x00000002,
    ///This value is used for boundary checking only and is not valid for application programming.
    NET_FW_IP_VERSION_MAX = 0x00000003,
}

///> [!NOTE] >The Windows Firewall API is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the [Firewall
///with Advanced Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page)Windows
///API is recommended. The <b>NET_FW_SCOPE</b> enumerated type specifies the scope of addresses from which a port can
///listen.
alias NET_FW_SCOPE = int;
enum : int
{
    ///Scope is all.
    NET_FW_SCOPE_ALL          = 0x00000000,
    ///Scope is local subnet only.
    NET_FW_SCOPE_LOCAL_SUBNET = 0x00000001,
    ///Scope is custom.
    NET_FW_SCOPE_CUSTOM       = 0x00000002,
    ///Used for boundary checking only. Not valid for application programming.
    NET_FW_SCOPE_MAX          = 0x00000003,
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] <p class="CCE_Message">[The Windows Firewall API is
///available for use in the operating systems specified in the Requirements section. It may be altered or unavailable in
///subsequent versions. For Windows Vista and later, use of the Windows Firewall with Advanced Security API is
///recommended.] The <b>NET_FW_IP_PROTOCOL</b> enumeration type specifies the Internet protocol.
alias NET_FW_IP_PROTOCOL = int;
enum : int
{
    ///Transmission Control Protocol.
    NET_FW_IP_PROTOCOL_TCP = 0x00000006,
    ///User Datagram Protocol.
    NET_FW_IP_PROTOCOL_UDP = 0x00000011,
    NET_FW_IP_PROTOCOL_ANY = 0x00000100,
}

///> [!NOTE] >The Windows Firewall API is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the [Firewall
///with Advanced Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page)Windows
///API is recommended. The **NET_FW_SERVICE_TYPE** enumerated type specifies the type of service.
alias NET_FW_SERVICE_TYPE = int;
enum : int
{
    ///Service type is File and Print Sharing.
    NET_FW_SERVICE_FILE_AND_PRINT = 0x00000000,
    ///Service type is UPnP Framework.
    NET_FW_SERVICE_UPNP           = 0x00000001,
    ///Service type is Remote Desktop.
    NET_FW_SERVICE_REMOTE_DESKTOP = 0x00000002,
    ///Not a valid service type. This is used to indicate that a port is not part of a service.
    NET_FW_SERVICE_NONE           = 0x00000003,
    ///Used for boundary checking only. Not valid for application programming.
    NET_FW_SERVICE_TYPE_MAX       = 0x00000004,
}

///The <b>NET_FW_RULE_DIRECTION</b> enumerated type specifies the direction of traffic to which a rule applies.
alias NET_FW_RULE_DIRECTION = int;
enum : int
{
    ///The rule applies to inbound traffic.
    NET_FW_RULE_DIR_IN  = 0x00000001,
    ///The rule applies to outbound traffic.
    NET_FW_RULE_DIR_OUT = 0x00000002,
    ///This value is used for boundary checking only and is not valid for application programming.
    NET_FW_RULE_DIR_MAX = 0x00000003,
}

///The <b>NET_FW_ACTION</b> enumerated type specifies the action for a rule or default setting.
alias NET_FW_ACTION = int;
enum : int
{
    ///Block traffic.
    NET_FW_ACTION_BLOCK = 0x00000000,
    ///Allow traffic.
    NET_FW_ACTION_ALLOW = 0x00000001,
    ///Maximum traffic.
    NET_FW_ACTION_MAX   = 0x00000002,
}

///The NET_FW_MODIFY_STATE enumerated type specifies the effect of modifications to the current policy.
alias NET_FW_MODIFY_STATE = int;
enum : int
{
    ///Changing or adding a firewall rule or firewall group to the current profile will take effect.
    NET_FW_MODIFY_STATE_OK              = 0x00000000,
    ///Changing or adding a firewall rule or firewall group to the current profile will not take effect because the
    ///profile is controlled by the group policy.
    NET_FW_MODIFY_STATE_GP_OVERRIDE     = 0x00000001,
    ///Changing or adding a firewall rule or firewall group to the current profile will not take effect because
    ///unsolicited inbound traffic is not allowed.
    NET_FW_MODIFY_STATE_INBOUND_BLOCKED = 0x00000002,
}

///The <b>NET_FW_RULE_CATEGORY</b> enumerated type specifies the firewall rule category.
alias NET_FW_RULE_CATEGORY = int;
enum : int
{
    ///Specifies boot time filters.
    NET_FW_RULE_CATEGORY_BOOT     = 0x00000000,
    ///Specifies stealth filters.
    NET_FW_RULE_CATEGORY_STEALTH  = 0x00000001,
    ///Specifies firewall filters.
    NET_FW_RULE_CATEGORY_FIREWALL = 0x00000002,
    ///Specifies connection security filters.
    NET_FW_RULE_CATEGORY_CONSEC   = 0x00000003,
    ///Maximum value for testing purposes.
    NET_FW_RULE_CATEGORY_MAX      = 0x00000004,
}

///The <b>NET_FW_EDGE_TRAVERSAL_TYPE</b> enumerated type specifies the conditions under which edge traversal traffic is
///allowed.
alias NET_FW_EDGE_TRAVERSAL_TYPE = int;
enum : int
{
    ///Edge traversal traffic is always blocked. This is the same as setting the EdgeTraversal property using INetFwRule
    ///to <b>VARIANT_FALSE</b>.
    NET_FW_EDGE_TRAVERSAL_TYPE_DENY          = 0x00000000,
    ///Edge traversal traffic is always allowed. This is the same as setting the EdgeTraversal property using INetFwRule
    ///to <b>VARIANT_TRUE</b>.
    NET_FW_EDGE_TRAVERSAL_TYPE_ALLOW         = 0x00000001,
    ///Edge traversal traffic is allowed when the application sets the IPV6_PROTECTION_LEVEL socket option to
    ///<b>PROTECTION_LEVEL_UNRESTRICTED</b>. Otherwise, it is blocked.
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_APP  = 0x00000002,
    ///The user is prompted whether to allow edge traversal traffic when the application sets the IPV6_PROTECTION_LEVEL
    ///socket option to <b>PROTECTION_LEVEL_UNRESTRICTED</b>. If the user chooses to allow edge traversal traffic, the
    ///rule is modified to defer to the application's settings. If the application has not set the IPV6_PROTECTION_LEVEL
    ///socket option to <b>PROTECTION_LEVEL_UNRESTRICTED</b>, edge traversal traffic is blocked. In order to use this
    ///option, the firewall rule must have both the application path and protocol scopes specified. This option cannot
    ///be used if port(s) are defined.
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_USER = 0x00000003,
}

///The <b>NET_FW_AUTHENTICATE_TYPE</b> enumerated type specifies the type of authentication which must occur in order
///for traffic to be allowed..
alias NET_FW_AUTHENTICATE_TYPE = int;
enum : int
{
    ///No security check is performed.
    NET_FW_AUTHENTICATE_NONE                     = 0x00000000,
    ///The traffic is allowed if it is IPsec-protected with authentication and no encapsulation protection. This means
    ///that the peer is authenticated, but there is no integrity protection on the data.
    NET_FW_AUTHENTICATE_NO_ENCAPSULATION         = 0x00000001,
    ///The traffic is allowed if it is IPsec-protected with authentication and integrity protection.
    NET_FW_AUTHENTICATE_WITH_INTEGRITY           = 0x00000002,
    ///The traffic is allowed if its is IPsec-protected with authentication and integrity protection. In addition,
    ///negotiation of encryption protections on subsequent packets is requested.
    NET_FW_AUTHENTICATE_AND_NEGOTIATE_ENCRYPTION = 0x00000003,
    ///The traffic is allowed if it is IPsec-protected with authentication, integrity and encryption protection since
    ///the very first packet.
    NET_FW_AUTHENTICATE_AND_ENCRYPT              = 0x00000004,
}

///The <b>NETISO_FLAG</b> enumerated type specifies whether binaries should be returned for app containers.
alias NETISO_FLAG = int;
enum : int
{
    ///Specifies that all binaries will be computed before the app container is returned. This flag should be set if the
    ///caller requires up-to-date and complete information on app container binaries. If this flag is not set, returned
    ///data may be stale or incomplete.
    NETISO_FLAG_FORCE_COMPUTE_BINARIES = 0x00000001,
    ///Maximum value for testing purposes.
    NETISO_FLAG_MAX                    = 0x00000002,
}

///The <b>INET_FIREWALL_AC_CREATION_TYPE</b> enumeration specifies the type of app container creation events for which
///notifications will be delivered.
alias INET_FIREWALL_AC_CREATION_TYPE = int;
enum : int
{
    ///This value is reserved for system use.
    INET_FIREWALL_AC_NONE            = 0x00000000,
    ///Notifications will be delivered when an app container is created with a package identifier.
    INET_FIREWALL_AC_PACKAGE_ID_ONLY = 0x00000001,
    ///Notifications will be delivered when an app container is created with a binary path.
    INET_FIREWALL_AC_BINARY          = 0x00000002,
    ///Maximum value for testing purposes.
    INET_FIREWALL_AC_MAX             = 0x00000004,
}

///The <b>INET_FIREWALL_AC_CHANGE_TYPE</b> enumeration specifies which type of app container change occurred.
alias INET_FIREWALL_AC_CHANGE_TYPE = int;
enum : int
{
    ///This value is reserved for system use.
    INET_FIREWALL_AC_CHANGE_INVALID = 0x00000000,
    ///An app container was created.
    INET_FIREWALL_AC_CHANGE_CREATE  = 0x00000001,
    ///An app container was deleted.
    INET_FIREWALL_AC_CHANGE_DELETE  = 0x00000002,
    ///Maximum value for testing purposes.
    INET_FIREWALL_AC_CHANGE_MAX     = 0x00000003,
}

///The <b>NETISO_ERROR_TYPE</b> enumerated type specifies the type of error related to a network isolation operation.
alias NETISO_ERROR_TYPE = int;
enum : int
{
    ///No error.
    NETISO_ERROR_TYPE_NONE                   = 0x00000000,
    ///The failure was caused because the privateNetworkClientServer capability is missing.
    NETISO_ERROR_TYPE_PRIVATE_NETWORK        = 0x00000001,
    ///The failure was caused because the internetClient capability is missing.
    NETISO_ERROR_TYPE_INTERNET_CLIENT        = 0x00000002,
    ///The failure was caused because the internetClientServer capability is missing.
    NETISO_ERROR_TYPE_INTERNET_CLIENT_SERVER = 0x00000003,
    ///Maximum value for testing purposes.
    NETISO_ERROR_TYPE_MAX                    = 0x00000004,
}

// Callbacks

///The <b>PAC_CHANGES_CALLBACK_FN</b> function is used to add custom behavior to the app container change notification
///process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              NetworkIsolationRegisterForAppContainerChanges function.
///    pChange = Type: <b>const INET_FIREWALL_AC_CHANGE*</b> The app container change information.
alias PAC_CHANGES_CALLBACK_FN = void function(void* context, const(INET_FIREWALL_AC_CHANGE)* pChange);
alias PNETISO_EDP_ID_CALLBACK_FN = void function(void* context, const(PWSTR) wszEnterpriseId, uint dwErr);

// Structs


///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>NETCON_PROPERTIES</b> structure stores values that describe the properties of a
///network connection.
struct NETCON_PROPERTIES
{
    ///Globally-unique identifier (GUID) for this connection.
    GUID             guidId;
    ///Name of the connection itself.
    PWSTR            pszwName;
    ///Name of the device associated with the connection.
    PWSTR            pszwDeviceName;
    ///Current status of the connection.
    NETCON_STATUS    Status;
    ///Media type associated with this connection.
    NETCON_MEDIATYPE MediaType;
    ///Characteristics for this connection.
    uint             dwCharacter;
    ///Class identifier for the connection object.
    GUID             clsidThisObject;
    ///Class identifier for the user-interface object.
    GUID             clsidUiObject;
}

///The <b>INET_FIREWALL_AC_CAPABILITIES</b> structure contains information about the capabilities of an app container.
struct INET_FIREWALL_AC_CAPABILITIES
{
    ///Type: <b>DWORD</b> The number of security identifiers (SIDs) in the <b>capabilities</b> member.
    uint                count;
    SID_AND_ATTRIBUTES* capabilities;
}

///The <b>INET_FIREWALL_AC_BINARIES</b> structure contains the binary paths to applications running in an app container.
struct INET_FIREWALL_AC_BINARIES
{
    ///The number of paths in the <b>binaries</b> member.
    uint   count;
    PWSTR* binaries;
}

///The INET_FIREWALL_AC_CHANGE structure contains information about a change made to an app container.
struct INET_FIREWALL_AC_CHANGE
{
    ///Type: <b>INET_FIREWALL_AC_CHANGE_TYPE</b> The type of change made.
    INET_FIREWALL_AC_CHANGE_TYPE changeType;
    ///Type: <b>INET_FIREWALL_AC_CREATION_TYPE</b> The method by which the app container was created.
    INET_FIREWALL_AC_CREATION_TYPE createType;
    ///Type: <b>SID*</b> The package identifier of the app container
    SID*  appContainerSid;
    ///Type: <b>SID*</b> The security identifier (SID) of the user to whom the app container belongs.
    SID*  userSid;
    ///Type: <b>LPWSTR</b> Friendly name of the app container.
    PWSTR displayName;
union
    {
        INET_FIREWALL_AC_CAPABILITIES capabilities;
        INET_FIREWALL_AC_BINARIES binaries;
    }
}

///The <b>INET_FIREWALL_APP_CONTAINER</b> structure contains information about an specific app container. <div
///class="code"></div>
struct INET_FIREWALL_APP_CONTAINER
{
    ///Type: <b>SID*</b> The package identifier of the app container
    SID*  appContainerSid;
    ///Type: <b>SID*</b> The security identifier (SID) of the user to whom the app container belongs.
    SID*  userSid;
    ///Type: <b>LPWSTR</b> The app container's globally unique name. Also referred to as the Package Family Name, for
    ///the app container of a Windows Store app.
    PWSTR appContainerName;
    ///Type: <b>LPWSTR</b> Friendly name of the app container
    PWSTR displayName;
    ///Type: <b>LPWSTR</b> A description of the app container (its use, the objective of the application that uses it,
    ///etc.)
    PWSTR description;
    ///Type: <b>INET_FIREWALL_AC_CAPABILITIES</b> The capabilities of the app container.
    INET_FIREWALL_AC_CAPABILITIES capabilities;
    ///Type: <b>INET_FIREWALL_AC_BINARIES</b> Binary paths to the applications running in the app container.
    INET_FIREWALL_AC_BINARIES binaries;
    PWSTR workingDirectory;
    PWSTR packageFullName;
}

// Functions

///The <b>NetworkIsolationSetupAppContainerBinaries</b> function is used by software installers to provide information
///about the image paths of applications that are running in an app container. This information is provided to
///third-party firewall applications about the applications in order to enhance user experience and security decisions.
///Params:
///    applicationContainerSid = Type: <b>PSID</b> The package identifier of the app container.
///    packageFullName = Type: <b>LPCWSTR</b> A string representing the package identity of the app that owns this app container. Contains
///                      the 5-part tuple as individual fields (name, version, architecture, resourceid, publisher).
///    packageFolder = Type: <b>LPCWSTR</b> The file location of the app that owns this app container.
///    displayName = Type: <b>LPCWSTR</b> The friendly name of the app container.
///    bBinariesFullyComputed = Type: <b>BOOL</b> True if the binary files are being provided by the caller; otherwise, false.
///    binaries = Type: <b>LPCWSTR*</b> An array of paths to the applications running in the app container.
///    binariesCount = Type: <b>DWORD</b> The number of paths contained in the <i>binaries</i> parameter.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. If the function fails, it returns an
///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("api-ms-win-net-isolation-l1-1-0")
HRESULT NetworkIsolationSetupAppContainerBinaries(void* applicationContainerSid, const(PWSTR) packageFullName, 
                                                  const(PWSTR) packageFolder, const(PWSTR) displayName, 
                                                  BOOL bBinariesFullyComputed, PWSTR* binaries, uint binariesCount);

///The <b>NetworkIsolationRegisterForAppContainerChanges</b> function is used to register for the delivery of
///notifications regarding changes to an app container.
///Params:
///    flags = Type: <b>DWORD</b> A bitmask value of control flags which specify when to receive notifications. May contain one
///            or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="INET_FIREWALL_AC_NONE"></a><a id="inet_firewall_ac_none"></a><dl> <dt><b>INET_FIREWALL_AC_NONE</b></dt>
///            <dt>0x00</dt> </dl> </td> <td width="60%"> No notifications will be delivered. </td> </tr> <tr> <td
///            width="40%"><a id="INET_FIREWALL_AC_PACKAGE_ID_ONLY_"></a><a id="inet_firewall_ac_package_id_only_"></a><dl>
///            <dt><b>INET_FIREWALL_AC_PACKAGE_ID_ONLY </b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> Notifications will
///            be delivered when an app container is created with a package identifier. </td> </tr> <tr> <td width="40%"><a
///            id="INET_FIREWALL_AC_BINARY"></a><a id="inet_firewall_ac_binary"></a><dl> <dt><b>INET_FIREWALL_AC_BINARY</b></dt>
///            <dt>0x02</dt> </dl> </td> <td width="60%"> Notifications will be delivered when an app container is created with
///            a binary path. </td> </tr> <tr> <td width="40%"><a id="INET_FIREWALL_AC_MAX"></a><a
///            id="inet_firewall_ac_max"></a><dl> <dt><b>INET_FIREWALL_AC_MAX</b></dt> <dt>0x04</dt> </dl> </td> <td
///            width="60%"> Maximum value for testing purposes. </td> </tr> </table>
///    callback = Type: <b>PAC_CHANGES_CALLBACK_FN</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>PVOID</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the change.
///    registrationObject = Type: <b>HANDLE*</b> Handle to the newly created registration.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationRegisterForAppContainerChanges(uint flags, PAC_CHANGES_CALLBACK_FN callback, void* context, 
                                                    HANDLE* registrationObject);

///The <b>NetworkIsolationUnregisterForAppContainerChanges</b> function is used to cancel an app container change
///registration and stop receiving notifications.
///Params:
///    registrationObject = Type: <b>HANDLE</b> Handle to the previously created registration.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationUnregisterForAppContainerChanges(HANDLE registrationObject);

///The <b>NetworkIsolationFreeAppContainers</b> function is used to release memory resources allocated to one or more
///app containers
///Params:
///    pPublicAppCs = Type: <b>PINET_FIREWALL_APP_CONTAINER</b> The app container memory resources to be freed.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationFreeAppContainers(INET_FIREWALL_APP_CONTAINER* pPublicAppCs);

///The <b>NetworkIsolationEnumAppContainers</b> function enumerates all of the app containers that have been created in
///the system.
///Params:
///    Flags = Type: <b>DWORD</b> May be set to <b>NETISO_FLAG_FORCE_COMPUTE_BINARIES</b> to ensure that all binaries are
///            computed before the app container is returned. This flag should be set if the caller requires up-to-date and
///            complete information on app container binaries. If this flag is not set, returned data may be stale or
///            incomplete. See NETISO_FLAG for more information.
///    pdwNumPublicAppCs = Type: <b>DWORD*</b> The number of app containers in the <b>ppPublicAppCs</b> member.
///    ppPublicAppCs = Type: <b>PINET_FIREWALL_APP_CONTAINER*</b> The list of app container structure elements.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise. ERROR_OUTOFMEMORY will be
///    returned if memory is unavailable.
///    
@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationEnumAppContainers(uint Flags, uint* pdwNumPublicAppCs, 
                                       INET_FIREWALL_APP_CONTAINER** ppPublicAppCs);

///The <b>NetworkIsolationGetAppContainerConfig</b> function is used to retrieve configuration information about one or
///more app containers.
///Params:
///    pdwNumPublicAppCs = Type: <b>DWORD*</b> The number of app containers in the <b>appContainerSids</b> member.
///    appContainerSids = Type: <b>PSID_AND_ATTRIBUTES*</b> The security identifiers (SIDs) of app containers that are allowed to send
///                       loopback traffic. Used for debugging purposes.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationGetAppContainerConfig(uint* pdwNumPublicAppCs, SID_AND_ATTRIBUTES** appContainerSids);

///The <b>NetworkIsolationSetAppContainerConfig</b> function is used to set the configuration of one or more app
///containers.
///Params:
///    dwNumPublicAppCs = Type: <b>DWORD</b> The number of app containers in the <b>appContainerSids</b> member.
///    appContainerSids = Type: <b>PSID_AND_ATTRIBUTES</b> The security identifiers (SIDs) of app containers that are allowed to send
///                       loopback traffic. Used for debugging purposes.
@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationSetAppContainerConfig(uint dwNumPublicAppCs, SID_AND_ATTRIBUTES* appContainerSids);

///The <b>NetworkIsolationDiagnoseConnectFailureAndGetInfo</b> function gets information about a network isolation
///connection failure due to a missing capability. This function can be used to identify the capabilities required to
///connect to a server.
///Params:
///    wszServerName = Type: <b>LPCWSTR</b> Name (or IP address literal string) of the server to which a connection was attempted.
///    netIsoError = Type: <b>NETISO_ERROR_TYPE*</b> The error that has occurred, indicating which network capability was missing and
///                  thus caused the failure.
///Returns:
///    Type: <b>DWORD</b> Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationDiagnoseConnectFailureAndGetInfo(const(PWSTR) wszServerName, NETISO_ERROR_TYPE* netIsoError);


// Interfaces

@GUID("AE1E00AA-3FD5-403C-8A27-2BBDC30CD0E1")
struct UPnPNAT;

@GUID("5C63C1AD-3956-4FF8-8486-40034758315B")
struct NetSharingManager;

@GUID("2C5BC43E-3369-4C33-AB0C-BE9469677AF4")
struct NetFwRule;

@GUID("0CA545C6-37AD-4A6C-BF92-9F7610067EF5")
struct NetFwOpenPort;

@GUID("EC9846B3-2762-4A6B-A214-6ACB603462D2")
struct NetFwAuthorizedApplication;

@GUID("E2B3C97F-6AE1-41AC-817A-F6F92166D7DD")
struct NetFwPolicy2;

@GUID("9D745ED8-C514-4D1D-BF42-751FED2D5AC7")
struct NetFwProduct;

@GUID("CC19079B-8272-4D73-BB70-CDB533527B61")
struct NetFwProducts;

@GUID("304CE942-6E39-40D8-943A-B913C40C9CD4")
struct NetFwMgr;

///The <b>IUPnPNAT</b> interface is the primary interface for managing Network Address Translation (NAT) with UPnP. The
///<b>IUPnPNAT</b> interface provides access directly or indirectly to all the other interfaces in the NAT API with UPnP
///technology.
@GUID("B171C812-CC76-485A-94D8-B6B3A2794E99")
interface IUPnPNAT : IDispatch
{
    ///The <b>get_StaticPortMappingCollection</b> method retrieves an interface for the collection of static port
    ///mappings on the NAT used by the local computer.
    ///Params:
    ///    ppSPMs = Pointer to an interface pointer that points to an IStaticPortMappingCollection interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_StaticPortMappingCollection(IStaticPortMappingCollection* ppSPMs);
    HRESULT get_DynamicPortMappingCollection(IDynamicPortMappingCollection* ppDPMs);
    ///The <b>get_NATEventManager</b> method retrieves an INATEventManager interface for the NAT used by the local
    ///computer.
    ///Params:
    ///    ppNEM = Pointer to an interface pointer that points to an INATEventManager interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_NATEventManager(INATEventManager* ppNEM);
}

///The <b>INATEventManager</b> interface provides methods for NAT applications with UPnP technology to register callback
///interfaces with the NAT. The system calls the methods in these interfaces when the configuration of the NAT changes.
@GUID("624BD588-9060-4109-B0B0-1ADBBCAC32DF")
interface INATEventManager : IDispatch
{
    ///The <b>put_ExternalIPAddressCallback</b> method enables the NAT application with UPnP technology to register a
    ///callback interface with the NAT. The system calls the first method in this callback interface if the external IP
    ///address of the NAT changes.
    ///Params:
    ///    pUnk = Pointer to an object that supports either the IUnknown interface or the IDispatch interface. See the Remarks
    ///           section for more information.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT put_ExternalIPAddressCallback(IUnknown pUnk);
    ///The <b>put_NumberOfEntriesCallback</b> method enables the NAT application with UPnP technology to register a
    ///callback interface with the NAT. The system calls the first method in this callback interface if the number of
    ///NAT port mappings changes.
    ///Params:
    ///    pUnk = Pointer to an object that supports either the IUnknown interface or the IDispatch interface. See the Remarks
    ///           section for more information.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT put_NumberOfEntriesCallback(IUnknown pUnk);
}

///The <b>INATExternalIPAddressCallback</b> interface is implemented by the NAT application with UPnP technology. It
///provides a method that the system calls if the external IP address of the NAT computer changes.
@GUID("9C416740-A34E-446F-BA06-ABD04C3149AE")
interface INATExternalIPAddressCallback : IUnknown
{
    ///The system calls the <b>NewExternalIPAddress</b> method if the external IP address of the NAT computer changes.
    ///Params:
    ///    bstrNewExternalIPAddress = Specifies a BSTR variable that contains the new external IP address.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT NewExternalIPAddress(BSTR bstrNewExternalIPAddress);
}

///The <b>INATNumberOfEntriesCallback</b> interface provides a method that the system calls if the number of port
///mappings changes.
@GUID("C83A0A74-91EE-41B6-B67A-67E0F00BBD78")
interface INATNumberOfEntriesCallback : IUnknown
{
    ///The system calls the <b>NewNumberOfEntries</b> method if the total number of NAT port mappings changes.
    ///Params:
    ///    lNewNumberOfEntries = Specifies a <b>long</b> variable that contains the new number of port mappings.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT NewNumberOfEntries(int lNewNumberOfEntries);
}

@GUID("B60DE00F-156E-4E8D-9EC1-3A2342C10899")
interface IDynamicPortMappingCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Item(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol, IDynamicPortMapping* ppDPM);
    HRESULT get_Count(int* pVal);
    HRESULT Remove(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol);
    HRESULT Add(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol, int lInternalPort, 
                BSTR bstrInternalClient, short bEnabled, BSTR bstrDescription, int lLeaseDuration, 
                IDynamicPortMapping* ppDPM);
}

@GUID("4FC80282-23B6-4378-9A27-CD8F17C9400C")
interface IDynamicPortMapping : IDispatch
{
    HRESULT get_ExternalIPAddress(BSTR* pVal);
    HRESULT get_RemoteHost(BSTR* pVal);
    HRESULT get_ExternalPort(int* pVal);
    HRESULT get_Protocol(BSTR* pVal);
    HRESULT get_InternalPort(int* pVal);
    HRESULT get_InternalClient(BSTR* pVal);
    HRESULT get_Enabled(short* pVal);
    HRESULT get_Description(BSTR* pVal);
    HRESULT get_LeaseDuration(int* pVal);
    HRESULT RenewLease(int lLeaseDurationDesired, int* pLeaseDurationReturned);
    HRESULT EditInternalClient(BSTR bstrInternalClient);
    HRESULT Enable(short vb);
    HRESULT EditDescription(BSTR bstrDescription);
    HRESULT EditInternalPort(int lInternalPort);
}

///The <b>IStaticPortMappingCollection</b> interface provides methods to manage the collection of static port mappings.
@GUID("CD1F3E77-66D6-4664-82C7-36DBB641D0F1")
interface IStaticPortMappingCollection : IDispatch
{
    ///The <b>get__NewEnum</b> method retrieves an enumerator for the static port mappings collection.
    ///Params:
    ///    pVal = Pointer to an interface pointer that receives a pointer to an IUnknown interface for the collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get__NewEnum(IUnknown* pVal);
    ///The <b>get_Item</b> method retrieves the specified port mapping from the collection.
    ///Params:
    ///    lExternalPort = Specifies the external port for this port mapping.
    ///    bstrProtocol = Specifies the protocol. This parameter should be either UDP or TCP.
    ///    ppSPM = Pointer to an interface pointer that points to an IStaticPortMapping interface for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Item(int lExternalPort, BSTR bstrProtocol, IStaticPortMapping* ppSPM);
    ///The <b>get_Count</b> method retrieves the number of port mappings in the collection.
    ///Params:
    ///    pVal = Pointer to a <b>long</b> variable that receives the number of port mappings in the collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Count(int* pVal);
    ///The <b>Remove</b> method removes the specified port mapping from the collection.
    ///Params:
    ///    lExternalPort = Specifies the external port for this port mapping.
    ///    bstrProtocol = Specifies the protocol. This parameter should be either UDP or TCP.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Remove(int lExternalPort, BSTR bstrProtocol);
    ///The <b>Add</b> method creates a new port mapping and adds it to the collection.
    ///Params:
    ///    lExternalPort = Specifies the external port for this port mapping.
    ///    bstrProtocol = Specifies the protocol. This parameter should be either UDP or TCP.
    ///    lInternalPort = Specifies the internal port for this port mapping.
    ///    bstrInternalClient = Specifies the name of the client on the private network that uses this port mapping.
    ///    bEnabled = Specifies whether the port is enabled.
    ///    bstrDescription = Specifies a description for this port mapping.
    ///    ppSPM = Pointer to an interface pointer that, on successful return, receives a pointer to an IStaticPortMapping
    ///            interface.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Add(int lExternalPort, BSTR bstrProtocol, int lInternalPort, BSTR bstrInternalClient, short bEnabled, 
                BSTR bstrDescription, IStaticPortMapping* ppSPM);
}

///The <b>IStaticPortMapping</b> interface provides methods to retrieve and change the information for a particular port
///mapping.
@GUID("6F10711F-729B-41E5-93B8-F21D0F818DF1")
interface IStaticPortMapping : IDispatch
{
    ///The <b>get_ExternalIPAddress</b> method retrieves the external IP address for this port mapping on the NAT
    ///computer.
    ///Params:
    ///    pVal = Pointer to a BSTR variable that receives the external IP address for this port mapping on the NAT computer.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ExternalIPAddress(BSTR* pVal);
    ///The <b>get_ExternalPort</b> method retrieves the external port on the NAT computer for this port mapping.
    ///Params:
    ///    pVal = Pointer to a <b>long</b> variable that receives the external port on the NAT computer for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ExternalPort(int* pVal);
    ///The <b>get_InternalPort</b> method retrieves the internal port on the client computer for this port mapping.
    ///Params:
    ///    pVal = Pointer to a <b>long</b> variable that receives the internal port on the client computer for this port
    ///           mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_InternalPort(int* pVal);
    ///The <b>get_Protocol</b> method retrieves the protocol associated with this port mapping.
    ///Params:
    ///    pVal = Pointer to a BSTR variable that, receives the protocol for this port mapping. The protocol is either "UDP" or
    ///           "TCP".
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Protocol(BSTR* pVal);
    ///The <b>get_InternalClient</b> method retrieves the name of the internal client for this port mapping.
    ///Params:
    ///    pVal = Pointer to a BSTR variable that receives the name of the internal client for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_InternalClient(BSTR* pVal);
    ///The <b>get_Enabled</b> method retrieves whether the port mapping is enabled.
    ///Params:
    ///    pVal = Pointer to a <b>VARIANT_BOOL</b> that receives a value that indicates whether the port mapping is enabled.
    ///           The value is VARIANT_TRUE if the port mapping is enabled, VARIANT_FALSE otherwise.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Enabled(short* pVal);
    ///The <b>get_Description</b> method retrieves the description associated with this port mapping.
    ///Params:
    ///    pVal = Pointer to a BSTR variable that, on successful return, receives the description associated with this port
    ///           mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Description(BSTR* pVal);
    ///The <b>EditInternalClient</b> method sets the internal client property of this port mapping to the specified
    ///value.
    ///Params:
    ///    bstrInternalClient = Specifies the new value for the internal client property of this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table> <div> </div>
    ///    
    HRESULT EditInternalClient(BSTR bstrInternalClient);
    ///The <b>Enable</b> method enables or disables this port mapping.
    ///Params:
    ///    vb = Specifies a value that indicates whether the port mapping should be enabled or disabled. To enable the port
    ///         mapping specify VARIANT_TRUE. To disable the port mapping specify VARIANT_FALSE.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Enable(short vb);
    ///The <b>EditDescription</b> method sets the description property of this port mapping to the specified value.
    ///Params:
    ///    bstrDescription = Specifies the new value for the description property of this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT EditDescription(BSTR bstrDescription);
    ///The <b>EditInternalPort</b> method sets the internal port for this port mapping.
    ///Params:
    ///    lInternalPort = Specifies the new internal port for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT EditInternalPort(int lInternalPort);
}

@GUID("C08956A0-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetConnection : IUnknown
{
    HRESULT Next(uint celt, INetConnection* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetConnection* ppenum);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetConnection</b> interface provides methods to manage network connections.
@GUID("C08956A1-1CD3-11D1-B1C5-00805FC1270E")
interface INetConnection : IUnknown
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Connect</b> method connects, or establishes, this network
    ///connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Connect();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Disconnect</b> method disconnects this connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Disconnect();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Delete</b> method deletes this connection from connections folder.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Delete();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Duplicate</b> method creates a duplicate of this connection in the
    ///connections folder.
    ///Params:
    ///    pszwDuplicateName = Pointer to a Unicode string that specifies the name for the new connection.
    ///    ppCon = Pointer to an interface pointer that, on successful return, points to an INetConnection interface for the new
    ///            connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Duplicate(const(PWSTR) pszwDuplicateName, INetConnection* ppCon);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>GetProperties</b> method retrieves a structure that contains the
    ///properties for this network connection.
    ///Params:
    ///    ppProps = Pointer to a pointer that, on successful return, points to a NETCON_PROPERTIES structure that contains the
    ///              properties for this network connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetProperties(NETCON_PROPERTIES** ppProps);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>GetUiObjectClassId</b> method retrieves the class identifier of
    ///the user interface object for this connection.
    ///Params:
    ///    pclsid = Pointer to a <b>CLSID</b> variable that, on successful return, points to the class identifier of the user
    ///             interface object for this connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetUiObjectClassId(GUID* pclsid);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Rename</b> method renames this connection.
    ///Params:
    ///    pszwNewName = Pointer to a Unicode string that contains the new name for the connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Rename(const(PWSTR) pszwNewName);
}

@GUID("C08956A2-1CD3-11D1-B1C5-00805FC1270E")
interface INetConnectionManager : IUnknown
{
    HRESULT EnumConnections(NETCONMGR_ENUM_FLAGS Flags, IEnumNetConnection* ppEnum);
}

@GUID("C08956A3-1CD3-11D1-B1C5-00805FC1270E")
interface INetConnectionConnectUi : IUnknown
{
    HRESULT SetConnection(INetConnection pCon);
    HRESULT Connect(HWND hwndParent, uint dwFlags);
    HRESULT Disconnect(HWND hwndParent, uint dwFlags);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>IEnumNetSharingPortMapping</b> interface provides methods to enumerate the port
///mappings for a particular connection.
@GUID("C08956B0-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingPortMapping : IUnknown
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Next</b> method retrieves the specified number of port mappings
    ///that start from the current enumeration position.
    ///Params:
    ///    celt = Specifies the number of port mappings to retrieve.
    ///    rgVar = Pointer to a VARIANT variable for the port mapping. This variant contains a pointer to an
    ///            INetSharingPortMapping interface.
    ///    pceltFetched = Pointer to a <b>ULONG</b> variable that, on successful return, specifies the number of port mappings actually
    ///                   returned.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pceltFetched);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Skip</b> method skips the specified number of port mappings for
    ///this enumeration.
    ///Params:
    ///    celt = Specifies the number of port mappings to skip.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Skip(uint celt);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Reset</b> method causes subsequent enumeration calls to operate
    ///from the beginning of the enumeration.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Clone</b> method creates a new enumeration interface from this
    ///enumeration.
    ///Params:
    ///    ppenum = Pointer to an interface pointer that, on successful return, points to an IEnumNetSharingPortMapping interface
    ///             for the new enumeration.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Clone(IEnumNetSharingPortMapping* ppenum);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingPortMappingProps</b> interface provides methods that retrieve and
///set the properties of a network connection port mapping.
@GUID("24B7E9B5-E38F-4685-851B-00892CF5F940")
interface INetSharingPortMappingProps : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Name</b> method retrieves the name for this port mapping.
    ///Params:
    ///    pbstrName = Pointer to a BSTR variable that receives the name of the port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Name(BSTR* pbstrName);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_IPProtocol</b> method retrieves the IP Protocol associated
    ///with this port mapping.
    ///Params:
    ///    pucIPProt = Pointer to a <b>UCHAR</b> variable that receives the IP Protocol for the port mapping. The IP Protocol is one
    ///                of the following values: NAT_PROTOCOL_TCP NAT_PROTOCOL_UDP
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_IPProtocol(ubyte* pucIPProt);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_ExternalPort</b> method retrieves the external port associated
    ///with this port mapping.
    ///Params:
    ///    pusPort = Pointer to a <b>LONG</b> variable that receives the external port for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ExternalPort(int* pusPort);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_InternalPort</b> method retrieves the internal port associated
    ///with this port mapping.
    ///Params:
    ///    pusPort = Pointer to a <b>LONG</b> variable that receives the internal port for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_InternalPort(int* pusPort);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Options</b> method retrieves the options associated with this
    ///port mapping.
    ///Params:
    ///    pdwOptions = Pointer to a <b>DWORD</b> variable that receives the options associated with this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Options(int* pdwOptions);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_TargetName</b> method retrieves the name of the target
    ///computer for this port mapping.
    ///Params:
    ///    pbstrTargetName = Pointer to a BSTR variable that receives the name of the target computer for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_TargetName(BSTR* pbstrTargetName);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_TargetIPAddress</b> method retrieves the IP address of the
    ///target computer for this port mapping.
    ///Params:
    ///    pbstrTargetIPAddress = Pointer to a BSTR variable that receives the IP address of the target computer for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_TargetIPAddress(BSTR* pbstrTargetIPAddress);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Enabled</b> method retrieves the status for this port mapping.
    ///Params:
    ///    pbool = Pointer to a VARIANT_BOOL variable that receives the status of the port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Enabled(short* pbool);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingPortMapping</b> interface provides methods for managing a particular
///port mapping.
@GUID("C08956B1-1CD3-11D1-B1C5-00805FC1270E")
interface INetSharingPortMapping : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Disable</b> method disables a port mapping for a particular
    ///connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Disable();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Enable</b> method enables a port mapping for a particular
    ///connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Enable();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Properties</b> method retrieves the properties for a port
    ///mapping.
    ///Params:
    ///    ppNSPMP = Pointer to an interface pointer that, on successful return, points to an INetSharingPortMappingProps
    ///              interface for this port mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Properties(INetSharingPortMappingProps* ppNSPMP);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Delete</b> method deletes a port mapping from the list of port
    ///mappings for a particular connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Delete();
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>IEnumNetSharingEveryConnection</b> interface provides methods for enumerating
///all the connections in the Connections folder.
@GUID("C08956B8-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingEveryConnection : IUnknown
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Next</b> method retrieves the specified number of connections from
    ///the Connections folder starting from the current enumeration position.
    ///Params:
    ///    celt = Specifies the number of privately-shared connections to retrieve.
    ///    rgVar = Pointer to a VARIANT variable for the connection. This variant contains a pointer to an INetConnection
    ///            interface.
    ///    pceltFetched = Pointer to a <b>ULONG</b> variable that, on successful return, specifies the number of privately-shared
    ///                   connections actually returned.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pceltFetched);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Skip</b> method skips the specified number of privately-shared
    ///connections for this enumeration.
    ///Params:
    ///    celt = Specifies the number of privately-shared connections to skip.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Skip(uint celt);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Reset</b> method causes subsequent enumeration calls to operate
    ///from the beginning of the enumeration.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Clone</b> method creates a new enumeration interface from this
    ///enumeration.
    ///Params:
    ///    ppenum = Pointer to an interface pointer that, on successful return, points to an IEnumNetSharingEveryConnection
    ///             interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Clone(IEnumNetSharingEveryConnection* ppenum);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>IEnumNetSharingPublicConnection</b> interface provides methods for enumerating
///the currently configured publicly-shared connections.
@GUID("C08956B4-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingPublicConnection : IUnknown
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Next</b> method retrieves the specified number of privately-shared
    ///connections that start from the current enumeration position.
    ///Params:
    ///    celt = Specifies the number of publicly-shared connections to retrieve.
    ///    rgVar = Pointer to a VARIANT variable for the connection. This variant contains a pointer to an INetConnection
    ///            interface.
    ///    pceltFetched = Pointer to a <b>ULONG</b> variable that, on successful return, specifies the number of publicly-shared
    ///                   connections actually returned.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pceltFetched);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Skip</b> method skips the specified number of publicly-shared
    ///connections for this enumeration.
    ///Params:
    ///    celt = Specifies the number of publicly-shared connections to skip.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Skip(uint celt);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Reset</b> method causes subsequent enumeration calls to operate
    ///from the beginning of the enumeration.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Clone</b> method creates a new enumeration interface from this
    ///enumeration.
    ///Params:
    ///    ppenum = Pointer to an interface pointer that, on successful return, points to an IEnumNetSharingPublicConnection
    ///             interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Clone(IEnumNetSharingPublicConnection* ppenum);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>IEnumNetSharingPrivateConnection</b> interface provides methods for enumerating
///the currently configured privately-shared connections.
@GUID("C08956B5-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingPrivateConnection : IUnknown
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Next</b> method retrieves the specified number of privately-shared
    ///connections that start from the current enumeration position.
    ///Params:
    ///    celt = Specifies the number of privately-shared connections to retrieve.
    ///    rgVar = Pointer to a VARIANT variable for the connection. This variant contains a pointer to an INetConnection
    ///            interface.
    ///    pCeltFetched = Pointer to a <b>ULONG</b> variable that, on successful return, specifies the number of privately-shared
    ///                   connections actually returned.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table> <div> </div>
    ///    
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pCeltFetched);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Skip</b> method skips the specified number of privately-shared
    ///connections for this enumeration.
    ///Params:
    ///    celt = Specifies the number of privately-shared connections to skip.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Skip(uint celt);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Reset</b> method causes subsequent enumeration calls to operate
    ///from the beginning of the enumeration.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>Clone</b> method creates a new enumeration interface from this
    ///enumeration.
    ///Params:
    ///    ppenum = Pointer to an interface pointer that, on successful return, points to an IEnumNetSharingPrivateConnection
    ///             interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT Clone(IEnumNetSharingPrivateConnection* ppenum);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingPortMappingCollection</b> interface makes it possible for scripting
///languages such as VBScript and JScript to enumerate port mappings.
@GUID("02E4A2DE-DA20-4E34-89C8-AC22275A010B")
interface INetSharingPortMappingCollection : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get__NewEnum</b> method retrieves an enumerator for the port
    ///mapping collection.
    ///Params:
    ///    pVal = Pointer to an interface pointer that, on successful return, receives a pointer to an IUnknown interface for
    ///           the collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get__NewEnum(IUnknown* pVal);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get__Count</b> method retrieves the number of items in the port
    ///mapping collection.
    ///Params:
    ///    pVal = Pointer to a long variable that, on successful return, receives the number of items in the port mapping
    ///           collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Count(int* pVal);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] Use the <b>INetConnectionProps</b> interface to retrieve the properties for a
///connection.
@GUID("F4277C95-CE5B-463D-8167-5662D9BCAA72")
interface INetConnectionProps : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Guid</b> method retrieves the globally-unique identifier
    ///(GUID) for the connection.
    ///Params:
    ///    pbstrGuid = Pointer to a BSTR variable that, on successful return, receives the GUID for the connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Guid(BSTR* pbstrGuid);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Name</b> method retrieves the name of the connection.
    ///Params:
    ///    pbstrName = Pointer to a BSTR variable that, on successful return, receives the name of the connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Name(BSTR* pbstrName);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_DeviceName</b> method retrieves the name of the device
    ///associated with the connection.
    ///Params:
    ///    pbstrDeviceName = Pointer to a BSTR variable that, on successful return, receives the name of the device associated with the
    ///                      connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Status</b> method retrieves the status of the connection.
    ///Params:
    ///    pStatus = Pointer to a variable of type NETCON_STATUS that, on successful return, receives a code that specifies the
    ///              status of the connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Status(NETCON_STATUS* pStatus);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_MediaType</b> method retrieves the media type for the
    ///connection.
    ///Params:
    ///    pMediaType = Pointer to a variable of type NETCON_MEDIATYPE that, on successful return, receives a code that specifies the
    ///                 media type for the connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_MediaType(NETCON_MEDIATYPE* pMediaType);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Characteristics</b> method retrieves the media type for the
    ///connection.
    ///Params:
    ///    pdwFlags = Media types as defined by NETCON_MEDIATYPE.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Characteristics(uint* pdwFlags);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingConfiguration</b> interface provides methods to manage connection
///sharing, port mapping, and Internet Connection Firewall.
@GUID("C08956B6-1CD3-11D1-B1C5-00805FC1270E")
interface INetSharingConfiguration : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_SharingEnabled</b> method determines whether sharing is
    ///enabled on this connection.
    ///Params:
    ///    pbEnabled = Pointer to a <b>VARIANT_BOOL</b> variable that, on successful return, specifies whether sharing is enable on
    ///                this connection. If sharing is enable, this value is <b>TRUE</b>. Otherwise, it is <b>FALSE</b>.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_SharingEnabled(short* pbEnabled);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_SharingConnectionType</b> method determines the type of
    ///sharing that is enabled on this connection.
    ///Params:
    ///    pType = Pointer to a variable of type SHARINGCONNECTIONTYPE that specifies whether this connection is shared publicly
    ///            or privately.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_SharingConnectionType(SHARINGCONNECTIONTYPE* pType);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>DisableSharing</b> method disables sharing on this connection. It
    ///also disables all mappings on this connection. It does not disable Internet Connection Firewall or bridge
    ///configuration.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT DisableSharing();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>EnableSharing</b> method enables sharing on this connection.
    ///Params:
    ///    Type = Specifies whether this connection is shared publicly or privately.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT EnableSharing(SHARINGCONNECTIONTYPE Type);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_InternetFirewallEnabled</b> method determines whether Internet
    ///Connection Firewall is enabled on this connection.
    ///Params:
    ///    pbEnabled = Pointer to a <b>VARIANT_BOOL</b> variable that, on successful return, specifies whether Internet Connection
    ///                Firewall is enabled. If Internet Connection Firewall is enabled, this value is <b>TRUE</b>. Otherwise, it is
    ///                <b>FALSE</b>.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was stopped. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_InternetFirewallEnabled(short* pbEnabled);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>DisableInternetFirewall</b> method disables Internet Connection
    ///Firewall on this connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was stopped. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT DisableInternetFirewall();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>EnableInternetFirewall</b> methods enables Internet Connection
    ///Firewall on this connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was stopped. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT EnableInternetFirewall();
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_EnumPortMappings</b> method retrieves an
    ///IEnumNetSharingPortMapping interface. Use this interface to enumerate the port mappings for this connection.
    ///Params:
    ///    Flags = This parameter must be ICSSC_DEFAULT.
    ///    ppColl = Pointer to an interface pointer that, on successful return, points to a INetSharingPortMappingCollection
    ///             interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_EnumPortMappings(SHARINGCONNECTION_ENUM_FLAGS Flags, INetSharingPortMappingCollection* ppColl);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>AddPortMapping</b> method adds a service port mapping for this
    ///connection.
    ///Params:
    ///    bstrName = Pointer to a BSTR variable that contains the name for this port mapping.
    ///    ucIPProtocol = Specifies the IP Protocol to set for the port mapping. The IP Protocol is one of the following values:
    ///                   NAT_PROTOCOL_TCP NAT_PROTOCOL_UDP
    ///    usExternalPort = Specifies the external port for this port mapping.
    ///    usInternalPort = Specifies the internal port for this port mapping.
    ///    dwOptions = This parameter is reserved and not used at this time.
    ///    bstrTargetNameOrIPAddress = Pointer to a BSTR variable that contains the name of the target computer for this port mapping. Specify
    ///                                either the target name or the target IP address, but not both.
    ///    eTargetType = Indicates target type.
    ///    ppMapping = Pointer to a pointer that, on successful return, points to an INetSharingPortMapping interface for the port
    ///                mapping.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT AddPortMapping(BSTR bstrName, ubyte ucIPProtocol, ushort usExternalPort, ushort usInternalPort, 
                           uint dwOptions, BSTR bstrTargetNameOrIPAddress, ICS_TARGETTYPE eTargetType, 
                           INetSharingPortMapping* ppMapping);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>RemovePortMapping</b> method removes a service port mapping from
    ///the list of mappings for this connection.
    ///Params:
    ///    pMapping = Pointer to an INetSharingPortMapping interface for the port mapping to remove.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT RemovePortMapping(INetSharingPortMapping pMapping);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingEveryConnectionCollection</b> interface makes it possible for
///scripting languages such as VBScript and JScript to enumerate all the connections in the connections folder.
@GUID("33C4643C-7811-46FA-A89A-768597BD7223")
interface INetSharingEveryConnectionCollection : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get__NewEnum</b> method retrieves an enumerator for the
    ///connections collection.
    ///Params:
    ///    pVal = Pointer to an interface pointer that, on successful return, receives a pointer to an IUnknown interface for
    ///           the collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get__NewEnum(IUnknown* pVal);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get__Count</b> method retrieves the number of items in the
    ///connections collection.
    ///Params:
    ///    pVal = Pointer to a long variable that, on successful return, receives the number of items in the connections
    ///           collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Count(int* pVal);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingPublicConnectionCollection</b> interface makes it possible for
///scripting languages such as VBScript and JScript to enumerate public connections.
@GUID("7D7A6355-F372-4971-A149-BFC927BE762A")
interface INetSharingPublicConnectionCollection : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get__NewEnum</b> method retrieves an enumerator for the public
    ///connections collection.
    ///Params:
    ///    pVal = Pointer to an interface pointer that receives a pointer to an IUnknown interface for the collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get__NewEnum(IUnknown* pVal);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_Count</b> method retrieves the number of items in the public
    ///connections collection.
    ///Params:
    ///    pVal = Pointer to a <b>long</b> variable that receives the number of items in the public connections collection.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Count(int* pVal);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingPrivateConnectionCollection</b> interface makes it possible for
///scripting languages such as VBScript and JScript to enumerate private connections.
@GUID("38AE69E0-4409-402A-A2CB-E965C727F840")
interface INetSharingPrivateConnectionCollection : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get__NewEnum</b> method retrieves an enumerator for the private
    ///connections collection.
    ///Params:
    ///    pVal = Pointer to an interface pointer that receives a pointer to an IUnknown interface for the collection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get__NewEnum(IUnknown* pVal);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get__Count</b> method retrieves the number of items in the private
    ///connections collection.
    ///Params:
    ///    pVal = Pointer to a <b>long</b> variable that receives the number of items in the private connections collection.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Count(int* pVal);
}

///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions. Instead,
///use the Windows Firewall API.] The <b>INetSharingManager</b> interface is the primary interface for the Manager
///object. <b>INetSharingManager</b> provides methods to determine if sharing is installed, to manage port mappings, and
///to obtain enumeration interfaces for public and private connections.
@GUID("C08956B7-1CD3-11D1-B1C5-00805FC1270E")
interface INetSharingManager : IDispatch
{
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_SharingInstalled</b> method reports whether the
    ///currently-installed version of Windows XP supports connection sharing.
    ///Params:
    ///    pbInstalled = A pointer to a <b>VARIANT_BOOL</b> that specifies whether the currently-installed version Windows XP supports
    ///                  connection sharing. For more information, see Remarks.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_SharingInstalled(short* pbInstalled);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>EnumPublicConnections</b> method retrieves an enumeration
    ///interface for publicly-shared connections.
    ///Params:
    ///    Flags = This parameter must be ICSSC_DEFAULT.
    ///    ppColl = Pointer to a pointer that, on successful return, points to an INetSharingPublicConnectionCollection
    ///             interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_EnumPublicConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, 
                                      INetSharingPublicConnectionCollection* ppColl);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_EnumPrivateConnections</b> method retrieves an enumeration
    ///interface for privately-shared connections.
    ///Params:
    ///    Flags = This parameter must be ICSSC_DEFAULT.
    ///    ppColl = Pointer to a pointer that, on successful return, points to an INetSharingPrivateConnectionCollection
    ///             interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_EnumPrivateConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, 
                                       INetSharingPrivateConnectionCollection* ppColl);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_INetSharingConfigurationForINetConnection</b> method retrieves
    ///an INetSharingConfiguration interface for the specified connection.
    ///Params:
    ///    pNetConnection = Pointer to an INetConnection interface for an Internet connection.
    ///    ppNetSharingConfiguration = Pointer to an interface pointer that, on successful return, points to an INetSharingConfiguration interface
    ///                                for the connection specified by the <i>pNetConnection</i> parameter.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_INetSharingConfigurationForINetConnection(INetConnection pNetConnection, 
                                                          INetSharingConfiguration* ppNetSharingConfiguration);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_EnumEveryConnection</b> method retrieves an enumeration
    ///interface for all the connections in the connection folder.
    ///Params:
    ///    ppColl = Pointer to a pointer that, on successful return, points to an INetSharingEveryConnectionCollection interface.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table> <div> </div>
    ///    
    HRESULT get_EnumEveryConnection(INetSharingEveryConnectionCollection* ppColl);
    ///<p class="CCE_Message">[Internet Connection Firewall may be altered or unavailable in subsequent versions.
    ///Instead, use the Windows Firewall API.] The <b>get_NetConnectionProps</b> method retrieves a properties interface
    ///for the specified connection.
    ///Params:
    ///    pNetConnection = Pointer to an INetConnection interface for the connection for which to retrieve the properties interface.
    ///    ppProps = Pointer to an interface pointer that, on successful return, points to an INetConnectionProps interface for
    ///              the connection.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> A specified interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> A specified method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A pointer passed as a parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for unknown reasons. </td> </tr>
    ///    </table>
    ///    
    HRESULT get_NetConnectionProps(INetConnection pNetConnection, INetConnectionProps* ppProps);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwRemoteAdminSettings</b> interface
///provides access to the settings that control remote administration.
@GUID("D4BECDDF-6F73-4A83-B832-9C66874CD20E")
interface INetFwRemoteAdminSettings : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the IP version. This property is
    ///read/write.
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the IP version. This property is
    ///read/write.
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Controls the network scope from which remote
    ///administration is allowed. This property is read/write.
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Controls the network scope from which remote
    ///administration is allowed. This property is read/write.
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of remote addresses from
    ///which remote administration is allowed. This property is read/write.
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of remote addresses from
    ///which remote administration is allowed. This property is read/write.
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether remote administration is
    ///enabled.. This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether remote administration is
    ///enabled.. This property is read/write.
    HRESULT put_Enabled(short enabled);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwIcmpSettings</b> interface provides
///access to the settings controlling ICMP packets.
@GUID("A6207B2E-7CDD-426A-951E-5E1CBC5AFEAD")
interface INetFwIcmpSettings : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT get_AllowOutboundDestinationUnreachable(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT put_AllowOutboundDestinationUnreachable(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether redirect is allowed. This
    ///property is read/write.
    HRESULT get_AllowRedirect(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether redirect is allowed. This
    ///property is read/write.
    HRESULT put_AllowRedirect(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT get_AllowInboundEchoRequest(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT put_AllowInboundEchoRequest(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether exceeding the outbound time
    ///is allowed. This property is read/write.
    HRESULT get_AllowOutboundTimeExceeded(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether exceeding the outbound time
    ///is allowed. This property is read/write.
    HRESULT put_AllowOutboundTimeExceeded(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT get_AllowOutboundParameterProblem(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT put_AllowOutboundParameterProblem(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether outbound source quench is
    ///allowed. This property is read/write.
    HRESULT get_AllowOutboundSourceQuench(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether outbound source quench is
    ///allowed. This property is read/write.
    HRESULT put_AllowOutboundSourceQuench(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT get_AllowInboundRouterRequest(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT put_AllowInboundRouterRequest(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT get_AllowInboundTimestampRequest(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT put_AllowInboundTimestampRequest(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT get_AllowInboundMaskRequest(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT put_AllowInboundMaskRequest(short allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT get_AllowOutboundPacketTooBig(short* allow);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether this is allowed. This
    ///property is read/write.
    HRESULT put_AllowOutboundPacketTooBig(short allow);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwOpenPort</b> interface provides access
///to the properties of a port that has been opened in the firewall.
@GUID("E0483BA0-47FF-4D9C-A6D6-7741D0B195F7")
interface INetFwOpenPort : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the friendly name of this port.
    ///This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the friendly name of this port.
    ///This property is read/write.
    HRESULT put_Name(BSTR name);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the IP version setting for this
    ///port. This property is read/write.
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the IP version setting for this
    ///port. This property is read/write.
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the protocol type setting for this
    ///port. This property is read/write.
    HRESULT get_Protocol(NET_FW_IP_PROTOCOL* ipProtocol);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the protocol type setting for this
    ///port. This property is read/write.
    HRESULT put_Protocol(NET_FW_IP_PROTOCOL ipProtocol);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifiess the host-ordered port number for
    ///this port. This property is read/write.
    HRESULT get_Port(int* portNumber);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifiess the host-ordered port number for
    ///this port. This property is read/write.
    HRESULT put_Port(int portNumber);
    ///<p class="CCE_Message">[The Windows Firewall API is > [!NOTE] > The Windows Firewall API is available for use in
    ///the operating systems specified in the Requirements section. It may be altered or unavailable in subsequent
    ///versions. For Windows Vista and later, use of the [Windows Firewall with Advanced
    ///Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page) API is
    ///recommended. Controls the network scope from which the port can listen. This property is read/write.
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    ///> [!NOTE] > The Windows Firewall API is available for use in the operating systems specified in the Requirements
    ///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the
    ///[Windows Firewall with Advanced
    ///Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page) API is
    ///recommended. Controls the network scope from which the port can listen. This property is read/write.
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of remote addresses from
    ///which the port can listen for traffic. This property is read/write.
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of remote addresses from
    ///which the port can listen for traffic. This property is read/write.
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the settings for this port
    ///are currently enabled. This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the settings for this port
    ///are currently enabled. This property is read/write.
    HRESULT put_Enabled(short enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the port is defined by the
    ///system. This property is read-only.
    HRESULT get_BuiltIn(short* builtIn);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwOpenPorts</b> interface is a standard
///Automation collection interface.
@GUID("C0E9D7FA-E07E-430A-B19A-090CE82D92E2")
interface INetFwOpenPorts : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves a read-only element yielding the
    ///number of items in the collection. This property is read-only.
    HRESULT get_Count(int* count);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Opens a new port and adds it to the
    ///collection.
    ///Params:
    ///    port = Port to add to the collection.
    ///Returns:
    ///    <h3>C++</h3> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed because the object is already in the collection. </td> </tr> </table> <h3>VB</h3> If the method
    ///    succeeds, the return value is S_OK. If the method fails, the return value is one of the following error
    ///    codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed because the object is already in the collection. </td> </tr> </table>
    ///    
    HRESULT Add(INetFwOpenPort port);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Closes a port and removes it from the
    ///collection.
    ///Params:
    ///    portNumber = Port number to remove.
    ///    ipProtocol = Protocol of the port to remove.
    ///Returns:
    ///    <h3>C++</h3> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> </table> <h3>VB</h3> If the method succeeds, the return value is <b>S_OK</b>. If the method
    ///    fails, the return value is one of the following error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate required memory. </td> </tr> </table>
    ///    
    HRESULT Remove(int portNumber, NET_FW_IP_PROTOCOL ipProtocol);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Returns the specified port if it is in the
    ///collection.
    ///Params:
    ///    portNumber = Port number to find.
    ///    ipProtocol = Protocol of the port to find by type NET_FW_IP_PROTOCOL.
    ///    openPort = Reference to the returned INetFwOpenPort object.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds, the return value is S_OK. If the method fails, the return value is one
    ///    of the following error codes. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <a
    ///    id="E_ACCESSDENIED"></a><a id="e_accessdenied"></a>E_ACCESSDENIED </td> <td width="60%"> The operation was
    ///    aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <a id="E_INVALIDARG"></a><a
    ///    id="e_invalidarg"></a>E_INVALIDARG </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <a id="E_OUTOFMEMORY"></a><a id="e_outofmemory"></a>E_OUTOFMEMORY </td> <td
    ///    width="60%"> The method was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <a
    ///    id="E_POINTER"></a><a id="e_pointer"></a>E_POINTER </td> <td width="60%"> The method failed due to an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <a id="HRESULT_FROM_WIN32_ERROR_FILE_NOT_FOUND__"></a><a
    ///    id="hresult_from_win32_error_file_not_found__"></a>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND) </td> <td
    ///    width="60%"> The requested item does not exist. </td> </tr> </table> <h3>VB</h3> Reference to the returned
    ///    INetFwOpenPort object.
    ///    
    HRESULT Item(int portNumber, NET_FW_IP_PROTOCOL ipProtocol, INetFwOpenPort* openPort);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Returns an object supporting
    ///<b>IEnumVARIANT</b> that can be used to iterate through all the ports in the collection. Iteration through a
    ///collection is done using the <b>for each</b> construct in VBScript. See Iterating a Collection for an example.
    ///This property is read-only.
    HRESULT get__NewEnum(IUnknown* newEnum);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwService</b> interface provides access
///to the properties of a service that may be authorized to listen through the firewall.
@GUID("79FD57C8-908E-4A36-9888-D5B3F0A444CF")
interface INetFwService : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the friendly name of the service.
    ///This property is read-only.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the type of the service. This
    ///property is read-only.
    HRESULT get_Type(NET_FW_SERVICE_TYPE* type);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether at least one of the ports
    ///associated with the service has been customized. This property is read-only.
    HRESULT get_Customized(short* customized);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the firewall IP version for which
    ///the service is authorized. This property is read/write.
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the firewall IP version for which
    ///the service is authorized. This property is read/write.
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    ///> [!NOTE] > The Windows Firewall API is available for use in the operating systems specified in the Requirements
    ///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the
    ///[Windows Firewall with Advanced
    ///Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page) API is
    ///recommended. Controls the network scope from which the port can listen. This property is read/write.
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    ///> [!NOTE] > The Windows Firewall API is available for use in the operating systems specified in the Requirements
    ///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the
    ///[Windows Firewall with Advanced
    ///Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page) API is
    ///recommended. Controls the network scope from which the port can listen. This property is read/write.
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of the remote addresses from
    ///which the service ports can listen for traffic. This property is read/write.
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of the remote addresses from
    ///which the service ports can listen for traffic. This property is read/write.
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether all the ports associated
    ///with the service are enabled. This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether all the ports associated
    ///with the service are enabled. This property is read/write.
    HRESULT put_Enabled(short enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the collection of globally open
    ///ports associated with the service. This property is read-only.
    HRESULT get_GloballyOpenPorts(INetFwOpenPorts* openPorts);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwServices</b> interface is a standard
///Automation interface which provides access to a collection of services that may be authorized to listen through the
///firewall.
@GUID("79649BB4-903E-421B-94C9-79848E79F6EE")
interface INetFwServices : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves a read-only element yielding the
    ///number of items in the collection. This property is read-only.
    HRESULT get_Count(int* count);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Returns the specified service if it is in the
    ///collection.
    ///Params:
    ///    svcType = <table> <tr> <td><strong>C++</strong></td> <td> Type of service to fetch. </td> </tr> <tr>
    ///              <td><strong>VB</strong></td> <td> Type of service to fetch. See NET_FW_SERVICE_TYPE </td> </tr> </table>
    ///    service = <table> <tr> <td><strong>C++</strong></td> <td> Reference to the returned <b>INetFwService</b> object. </td>
    ///              </tr> <tr> <td><strong>VB</strong></td> <td> Reference to the returned INetFwService object. </td> </tr>
    ///              </table>
    ///Returns:
    ///    <h3>C++</h3> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The
    ///    method was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid pointer. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed
    ///    due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The method failed
    ///    because the requested item does not exist. </td> </tr> </table> <h3>VB</h3> If the method succeeds, the
    ///    return value is S_OK. If the method fails, the return value is one of the following error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt>
    ///    </dl> </td> <td width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed due to an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td>
    ///    <td width="60%"> The method failed because the requested item does not exist. </td> </tr> </table>
    ///    
    HRESULT Item(NET_FW_SERVICE_TYPE svcType, INetFwService* service);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Returns an object supporting
    ///<b>IEnumVARIANT</b> that can be used to iterate through all the services in the collection. Iteration through a
    ///collection is done using the <b>for each</b> construct in VBScript. See Iterating a Collection for an example.
    ///This property is read-only.
    HRESULT get__NewEnum(IUnknown* newEnum);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwAuthorizedApplication</b> interface
///provides access to the properties of an application that has been authorized have openings in the firewall.
@GUID("B5E64FFA-C2C5-444E-A301-FB5E00018050")
interface INetFwAuthorizedApplication : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the friendly name of this
    ///application. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the friendly name of this
    ///application. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the process image file name for
    ///this application. This property is read/write.
    HRESULT get_ProcessImageFileName(BSTR* imageFileName);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the process image file name for
    ///this application. This property is read/write.
    HRESULT put_ProcessImageFileName(BSTR imageFileName);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the IP version setting for this
    ///application. This property is read/write.
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the IP version setting for this
    ///application. This property is read/write.
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Controls the network scope from which the
    ///port can listen. This property is read/write.
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    ///> [!NOTE] > The Windows Firewall API is available for use in the operating systems specified in the Requirements
    ///section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of the
    ///[Windows Firewall with Advanced
    ///Security](/previous-versions/windows/desktop/ics/windows-firewall-advanced-security-start-page) API is
    ///recommended. Controls the network scope from which the port can listen. This property is read/write.
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of the remote addresses from
    ///which the application can listen for traffic. This property is read/write.
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies a set of the remote addresses from
    ///which the application can listen for traffic. This property is read/write.
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the settings for this
    ///application are currently enabled. This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the settings for this
    ///application are currently enabled. This property is read/write.
    HRESULT put_Enabled(short enabled);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwAuthorizedApplications</b> interface
///provides access to a collection of applications authorized open ports in the firewall.
@GUID("644EFD52-CCF9-486C-97A2-39F352570B30")
interface INetFwAuthorizedApplications : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the number of items in the
    ///collection. This property is read-only.
    HRESULT get_Count(int* count);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] The <b>Add</b> method adds a new application
    ///to the collection.
    ///Params:
    ///    app = <table> <tr> <td><strong>C++</strong></td> <td> Application to add to the collection via an
    ///          INetFWAuthorizedApplication object. </td> </tr> <tr> <td><strong>VB</strong></td> <td> Application to add to
    ///          the collection via an INetFWAuthorizedApplication object. </td> </tr> </table>
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed because the object is already in the collection. </td> </tr> </table> <h3>VB</h3> If the method
    ///    succeeds the return value is S_OK. If the method fails, the return value is one of the following error codes.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed because the object is already in the collection. </td> </tr> </table>
    ///    
    HRESULT Add(INetFwAuthorizedApplication app);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] The <b>Remove</b> method removes an
    ///application from the collection.
    ///Params:
    ///    imageFileName = Application name to be removed.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is
    ///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due
    ///    to permissions issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> </table> <h3>VB</h3> If the method succeeds the return value is <b>S_OK</b>. If the method fails,
    ///    the return value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation
    ///    was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required
    ///    memory. </td> </tr> </table>
    ///    
    HRESULT Remove(BSTR imageFileName);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] The <b>Item</b> method returns the specified
    ///application if it is in the collection.
    ///Params:
    ///    imageFileName = Application to retrieve.
    ///    app = Reference to the returned INetFwAuthorizedApplication object.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed due to an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> The requested item
    ///    does not exist. </td> </tr> </table> <h3>VB</h3> If the method succeeds the return value is S_OK. If the
    ///    method fails, the return value is one of the following error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed due to an invalid pointer. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> The requested
    ///    item does not exist. </td> </tr> </table>
    ///    
    HRESULT Item(BSTR imageFileName, INetFwAuthorizedApplication* app);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Returns an object supporting
    ///<b>IEnumVARIANT</b> that can be used to iterate through all the applications in the collection. Iteration through
    ///a collection is done using the <b>for each</b> construct in VBScript. See Iterating a Collection for an example.
    ///This property is read-only.
    HRESULT get__NewEnum(IUnknown* newEnum);
}

///The <b>INetFwRule</b> interface provides access to the properties of a rule.
@GUID("AF230D27-BABA-4E42-ACED-F524F22CFCE2")
interface INetFwRule : IDispatch
{
    ///Specifies the friendly name of this rule. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///Specifies the friendly name of this rule. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///Specifies the description of this rule. This property is read/write.
    HRESULT get_Description(BSTR* desc);
    ///Specifies the description of this rule. This property is read/write.
    HRESULT put_Description(BSTR desc);
    ///Specifies the friendly name of the application to which this rule applies. This property is read/write.
    HRESULT get_ApplicationName(BSTR* imageFileName);
    ///Specifies the friendly name of the application to which this rule applies. This property is read/write.
    HRESULT put_ApplicationName(BSTR imageFileName);
    ///Specifies the service name property of the application. This property is read/write.
    HRESULT get_ServiceName(BSTR* serviceName);
    ///Specifies the service name property of the application. This property is read/write.
    HRESULT put_ServiceName(BSTR serviceName);
    ///Specifies the IP protocol of this rule. This property is read/write.
    HRESULT get_Protocol(int* protocol);
    ///Specifies the IP protocol of this rule. This property is read/write.
    HRESULT put_Protocol(int protocol);
    ///Specifies the list of local ports for this rule. This property is read/write.
    HRESULT get_LocalPorts(BSTR* portNumbers);
    ///Specifies the list of local ports for this rule. This property is read/write.
    HRESULT put_LocalPorts(BSTR portNumbers);
    ///Specifies the list of remote ports for this rule. This property is read/write.
    HRESULT get_RemotePorts(BSTR* portNumbers);
    ///Specifies the list of remote ports for this rule. This property is read/write.
    HRESULT put_RemotePorts(BSTR portNumbers);
    ///Specifies the list of local addresses for this rule. This property is read/write.
    HRESULT get_LocalAddresses(BSTR* localAddrs);
    ///Specifies the list of local addresses for this rule. This property is read/write.
    HRESULT put_LocalAddresses(BSTR localAddrs);
    ///Specifies the list of remote addresses for this rule. This property is read/write.
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    ///Specifies the list of remote addresses for this rule. This property is read/write.
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    ///Specifies the list of ICMP types and codes for this rule. This property is read/write.
    HRESULT get_IcmpTypesAndCodes(BSTR* icmpTypesAndCodes);
    ///Specifies the list of ICMP types and codes for this rule. This property is read/write.
    HRESULT put_IcmpTypesAndCodes(BSTR icmpTypesAndCodes);
    ///Specifies the direction of traffic for which the rule applies. This property is read/write.
    HRESULT get_Direction(NET_FW_RULE_DIRECTION* dir);
    ///Specifies the direction of traffic for which the rule applies. This property is read/write.
    HRESULT put_Direction(NET_FW_RULE_DIRECTION dir);
    ///Specifies the list of interfaces for which the rule applies. This property is read/write.
    HRESULT get_Interfaces(VARIANT* interfaces);
    ///Specifies the list of interfaces for which the rule applies. This property is read/write.
    HRESULT put_Interfaces(VARIANT interfaces);
    ///Specifies the list of interface types for which the rule applies. This property is read/write.
    HRESULT get_InterfaceTypes(BSTR* interfaceTypes);
    ///Specifies the list of interface types for which the rule applies. This property is read/write.
    HRESULT put_InterfaceTypes(BSTR interfaceTypes);
    ///Enables or disables a rule. This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///Enables or disables a rule. This property is read/write.
    HRESULT put_Enabled(short enabled);
    ///Specifies the group to which an individual rule belongs. This property is read/write.
    HRESULT get_Grouping(BSTR* context);
    ///Specifies the group to which an individual rule belongs. This property is read/write.
    HRESULT put_Grouping(BSTR context);
    ///Specifies the profiles to which the rule belongs. This property is read/write.
    HRESULT get_Profiles(int* profileTypesBitmask);
    ///Specifies the profiles to which the rule belongs. This property is read/write.
    HRESULT put_Profiles(int profileTypesBitmask);
    ///Indicates whether edge traversal is enabled or disabled for this rule. This property is read/write.
    HRESULT get_EdgeTraversal(short* enabled);
    ///Indicates whether edge traversal is enabled or disabled for this rule. This property is read/write.
    HRESULT put_EdgeTraversal(short enabled);
    ///Specifies the action for a rule or default setting. This property is read/write.
    HRESULT get_Action(NET_FW_ACTION* action);
    ///Specifies the action for a rule or default setting. This property is read/write.
    HRESULT put_Action(NET_FW_ACTION action);
}

///The <b>INetFwRule2</b> interface allows an application or service to access all the properties of INetFwRule as well
///as the four edge properties of a firewall rule specified by NET_FW_EDGE_TRAVERSAL_TYPE.
@GUID("9C27C8DA-189B-4DDE-89F7-8B39A316782C")
interface INetFwRule2 : INetFwRule
{
    ///This property can be used to access the edge properties of a firewall rule defined by NET_FW_EDGE_TRAVERSAL_TYPE.
    ///This property is read/write.
    HRESULT get_EdgeTraversalOptions(int* lOptions);
    ///This property can be used to access the edge properties of a firewall rule defined by NET_FW_EDGE_TRAVERSAL_TYPE.
    ///This property is read/write.
    HRESULT put_EdgeTraversalOptions(int lOptions);
}

///The <b>INetFwRule3</b> interface allows an application or service to access all the properties of INetFwRule2 and to
///provide access to the requirements of app containers.
@GUID("B21563FF-D696-4222-AB46-4E89B73AB34A")
interface INetFwRule3 : INetFwRule2
{
    ///Specifies the package identifier or the app container identifier of a process, whether from a Windows Store app
    ///or a desktop app. This property is read/write.
    HRESULT get_LocalAppPackageId(BSTR* wszPackageId);
    ///Specifies the package identifier or the app container identifier of a process, whether from a Windows Store app
    ///or a desktop app. This property is read/write.
    HRESULT put_LocalAppPackageId(BSTR wszPackageId);
    ///Specifies the user security identifier (SID) of the user who is the owner of the rule. This property is
    ///read/write.
    HRESULT get_LocalUserOwner(BSTR* wszUserOwner);
    ///Specifies the user security identifier (SID) of the user who is the owner of the rule. This property is
    ///read/write.
    HRESULT put_LocalUserOwner(BSTR wszUserOwner);
    ///Specifies a list of authorized local users for an app container. This property is read/write.
    HRESULT get_LocalUserAuthorizedList(BSTR* wszUserAuthList);
    ///Specifies a list of authorized local users for an app container. This property is read/write.
    HRESULT put_LocalUserAuthorizedList(BSTR wszUserAuthList);
    ///Specifies a list of remote users who are authorized to access an app container. This property is read/write.
    HRESULT get_RemoteUserAuthorizedList(BSTR* wszUserAuthList);
    ///Specifies a list of remote users who are authorized to access an app container. This property is read/write.
    HRESULT put_RemoteUserAuthorizedList(BSTR wszUserAuthList);
    ///Specifies a list of remote computers which are authorized to access an app container. This property is
    ///read/write.
    HRESULT get_RemoteMachineAuthorizedList(BSTR* wszUserAuthList);
    ///Specifies a list of remote computers which are authorized to access an app container. This property is
    ///read/write.
    HRESULT put_RemoteMachineAuthorizedList(BSTR wszUserAuthList);
    ///Specifies which firewall verifications of security levels provided by IPsec must be guaranteed to allow the
    ///collection. The allowed values must correspond to those of the NET_FW_AUTHENTICATE_TYPE enumeration. This
    ///property is read/write.
    HRESULT get_SecureFlags(int* lOptions);
    ///Specifies which firewall verifications of security levels provided by IPsec must be guaranteed to allow the
    ///collection. The allowed values must correspond to those of the NET_FW_AUTHENTICATE_TYPE enumeration. This
    ///property is read/write.
    HRESULT put_SecureFlags(int lOptions);
}

///The <b>INetFwRules</b> interface provides a collection of firewall rules.
@GUID("9C4C6277-5027-441E-AFAE-CA1F542DA009")
interface INetFwRules : IDispatch
{
    ///Returns the number of rules in a collection. This property is read-only.
    HRESULT get_Count(int* count);
    ///The <b>Add</b> method adds a new rule to the collection.
    ///Params:
    ///    rule = Rule to be added to the collection via an INetFwRule object.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed because the object is already in
    ///    the collection. </td> </tr> </table> <h3>VB</h3> If the method succeeds the return value is S_OK. If the
    ///    method fails, the return value is one of the following error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed because a parameter was not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because the object is already in the collection. </td> </tr> </table>
    ///    
    HRESULT Add(INetFwRule rule);
    ///The <b>Remove</b> method removes a rule from the collection.
    ///Params:
    ///    name = Name of the rule to remove from the collection.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> </table> <h3>VB</h3> If the method succeeds the return value is S_OK. If the method fails, the
    ///    return value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation
    ///    was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required
    ///    memory. </td> </tr> </table>
    ///    
    HRESULT Remove(BSTR name);
    ///The <b>Item</b> method returns the specified rule if it is in the collection.
    ///Params:
    ///    name = Name of the rule to retrieve.
    ///    rule = Reference to the returned INetFwRule object.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed due to an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> The requested item
    ///    does not exist. </td> </tr> </table> <h3>VB</h3> If the method succeeds the return value is S_OK. If the
    ///    method fails, the return value is one of the following error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed due to an invalid pointer. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> The requested
    ///    item does not exist. </td> </tr> </table>
    ///    
    HRESULT Item(BSTR name, INetFwRule* rule);
    ///Returns an object supporting <b>IEnumVARIANT</b> that can be used to iterate through all the rules in the
    ///collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* newEnum);
}

///The <b>INetFwServiceRestriction</b> interface provides access to the Windows Service Hardening networking rules.
@GUID("8267BBE3-F890-491C-B7B6-2DB1EF0E5D2B")
interface INetFwServiceRestriction : IDispatch
{
    ///The <b>RestrictService</b> method turns service restriction on or off for a given service.
    ///Params:
    ///    serviceName = Name of the service for which service restriction is being turned on or off.
    ///    appName = Name of the application for which service restriction is being turned on or off.
    ///    restrictService = Indicates whether service restriction is being turned on or off. If this value is true (<b>VARIANT_TRUE</b>),
    ///                      the service will be restricted when sending or receiving network traffic. The Windows Service Hardening rules
    ///                      collection can contain rules which can allow this service specific inbound or outbound network access per
    ///                      specific requirements. If false (<b>VARIANT_FALSE</b>), the service is not restricted by Windows Service
    ///                      Hardening.
    ///    serviceSidRestricted = Indicates the type of service SID for the specified service. If this value is true (<b>VARIANT_TRUE</b>), the
    ///                           service SID will be restricted. Otherwise, it will be unrestricted.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> </table> <h3>VB</h3> If the method succeeds the return
    ///    value is S_OK. If the method fails, the return value is one of the following error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt>
    ///    </dl> </td> <td width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an
    ///    invalid parameter. </td> </tr> </table>
    ///    
    HRESULT RestrictService(BSTR serviceName, BSTR appName, short restrictService, short serviceSidRestricted);
    ///The <b>ServiceRestricted</b> method indicates whether service restriction rules are enabled to limit traffic to
    ///the resources specified by the firewall rules.
    ///Params:
    ///    serviceName = Name of the service being queried concerning service restriction state.
    ///    appName = Name of the application being queried concerning service restriction state.
    ///    serviceRestricted = Indicates whether service restriction rules are in place to restrict the specified service. If true
    ///                        (<b>VARIANT_TRUE</b>), service is restricted. Otherwise, service is not restricted to the resources specified
    ///                        by firewall rules.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed due to an invalid pointer. </td> </tr> </table> <h3>VB</h3> If the method succeeds the return value is
    ///    S_OK. If the method fails, the return value is one of the following error codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td>
    ///    <td width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed due to an invalid pointer. </td> </tr> </table>
    ///    
    HRESULT ServiceRestricted(BSTR serviceName, BSTR appName, short* serviceRestricted);
    ///Retrieves the collection of Windows Service Hardening networking rules. This property is read-only.
    HRESULT get_Rules(INetFwRules* rules);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwProfile</b> interface provides access
///to the firewall settings profile.
@GUID("174A0DDA-E9F9-449D-993B-21AB667CA456")
interface INetFwProfile : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Speciifes the type of the profile. This
    ///property is read-only.
    HRESULT get_Type(NET_FW_PROFILE_TYPE* type);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the firewall is enabled.
    ///This property is read/write.
    HRESULT get_FirewallEnabled(short* enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the firewall is enabled.
    ///This property is read/write.
    HRESULT put_FirewallEnabled(short enabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the firewall should not
    ///allow exceptions. This property is read/write.
    HRESULT get_ExceptionsNotAllowed(short* notAllowed);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the firewall should not
    ///allow exceptions. This property is read/write.
    HRESULT put_ExceptionsNotAllowed(short notAllowed);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether interactive firewall
    ///notifications are disabled. This property is read/write.
    HRESULT get_NotificationsDisabled(short* disabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether interactive firewall
    ///notifications are disabled. This property is read/write.
    HRESULT put_NotificationsDisabled(short disabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the firewall should not
    ///allow unicast responses to multicast and broadcast traffic. This property is read/write.
    HRESULT get_UnicastResponsesToMulticastBroadcastDisabled(short* disabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Indicates whether the firewall should not
    ///allow unicast responses to multicast and broadcast traffic. This property is read/write.
    HRESULT put_UnicastResponsesToMulticastBroadcastDisabled(short disabled);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Specifies the settings governing remote
    ///administration. This property is read-only.
    HRESULT get_RemoteAdminSettings(INetFwRemoteAdminSettings* remoteAdminSettings);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the ICMP settings of the profile.
    ///This property is read-only.
    HRESULT get_IcmpSettings(INetFwIcmpSettings* icmpSettings);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the collection of globally open
    ///ports of the profile. This property is read-only.
    HRESULT get_GloballyOpenPorts(INetFwOpenPorts* openPorts);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the collection of services of the
    ///profile. This property is read-only.
    HRESULT get_Services(INetFwServices* services);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the collection of authorized
    ///applications of the profile. This property is read-only.
    HRESULT get_AuthorizedApplications(INetFwAuthorizedApplications* apps);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The <b>INetFwPolicy</b> interface provides access to
///a firewall policy.
@GUID("D46D2478-9AC9-4008-9DC7-5563CE5536CC")
interface INetFwPolicy : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the current firewall profile. This
    ///property is read-only.
    HRESULT get_CurrentProfile(INetFwProfile* profile);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the profile of the requested type.
    ///Params:
    ///    profileType = Type of profile from NET_FW_PROFILE_TYPE.
    ///    profile = Retrieved profile of type INetFwProfile. Retrieved profile of type INetFwProfile.
    ///Returns:
    ///    <h3>C++</h3> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed due to an invalid pointer. </td> </tr> </table> <h3>VB</h3> If the method succeeds, the return value
    ///    is S_OK. If the method fails, the return value is one of the following error codes. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td>
    ///    <td width="60%"> The operation was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed due to an invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetProfileByType(NET_FW_PROFILE_TYPE profileType, INetFwProfile* profile);
}

///The <b>INetFwPolicy2</b> interface allows an application or service to access the firewall policy.
@GUID("98325047-C671-4174-8D81-DEFCD3F03186")
interface INetFwPolicy2 : IDispatch
{
    ///Retrieves the currently active firewall profile. This property is read-only.
    HRESULT get_CurrentProfileTypes(int* profileTypesBitmask);
    ///Indicates whether a firewall is enabled locally (the effective result may differ due to group policy settings).
    ///This property is read/write.
    HRESULT get_FirewallEnabled(NET_FW_PROFILE_TYPE2 profileType, short* enabled);
    ///Indicates whether a firewall is enabled locally (the effective result may differ due to group policy settings).
    ///This property is read/write.
    HRESULT put_FirewallEnabled(NET_FW_PROFILE_TYPE2 profileType, short enabled);
    ///Specifies a list of interfaces on which firewall settings are excluded. This property is read/write.
    HRESULT get_ExcludedInterfaces(NET_FW_PROFILE_TYPE2 profileType, VARIANT* interfaces);
    ///Specifies a list of interfaces on which firewall settings are excluded. This property is read/write.
    HRESULT put_ExcludedInterfaces(NET_FW_PROFILE_TYPE2 profileType, VARIANT interfaces);
    ///Indicates whether the firewall should not allow inbound traffic. This property is read/write.
    HRESULT get_BlockAllInboundTraffic(NET_FW_PROFILE_TYPE2 profileType, short* Block);
    ///Indicates whether the firewall should not allow inbound traffic. This property is read/write.
    HRESULT put_BlockAllInboundTraffic(NET_FW_PROFILE_TYPE2 profileType, short Block);
    ///Indicates whether interactive firewall notifications are disabled. This property is read/write.
    HRESULT get_NotificationsDisabled(NET_FW_PROFILE_TYPE2 profileType, short* disabled);
    ///Indicates whether interactive firewall notifications are disabled. This property is read/write.
    HRESULT put_NotificationsDisabled(NET_FW_PROFILE_TYPE2 profileType, short disabled);
    ///Indicates whether the firewall should not allow unicast responses to multicast and broadcast traffic. This
    ///property is read/write.
    HRESULT get_UnicastResponsesToMulticastBroadcastDisabled(NET_FW_PROFILE_TYPE2 profileType, short* disabled);
    ///Indicates whether the firewall should not allow unicast responses to multicast and broadcast traffic. This
    ///property is read/write.
    HRESULT put_UnicastResponsesToMulticastBroadcastDisabled(NET_FW_PROFILE_TYPE2 profileType, short disabled);
    ///Retrieves the collection of firewall rules. This property is read-only.
    HRESULT get_Rules(INetFwRules* rules);
    ///Retrieves the interface used to access the Windows Service Hardening store. This property is read-only.
    HRESULT get_ServiceRestriction(INetFwServiceRestriction* ServiceRestriction);
    ///The <b>EnableRuleGroup</b> method enables or disables a specified group of firewall rules.
    ///Params:
    ///    profileTypesBitmask = A bitmask of profiles from NET_FW_PROFILE_TYPE2.
    ///    group = A string that was used to group rules together. It can be the group name or an indirect string to the group
    ///            name in the form of "@C:\Program Files\Contoso Storefront\StorefrontRes.dll,-1234". Rules belonging to this
    ///            group would be enabled or disabled.
    ///    enable = Indicates whether the group of rules identified by the <i>group</i> parameter are to be enabled or disabled.
    ///             If this value is set to true (<b>VARIANT_TRUE</b>), the group of rules will be enabled; otherwise the group
    ///             is disabled.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The requested group does not exist. </td> </tr> </table> <h3>VB</h3> If the
    ///    method succeeds the return value is S_OK. If the method fails, the return value is one of the following error
    ///    codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The requested group does not exist. </td> </tr> </table>
    ///    
    HRESULT EnableRuleGroup(int profileTypesBitmask, BSTR group, short enable);
    ///The <b>IsRuleGroupEnabled</b> method determines whether a specified group of firewall rules are enabled or
    ///disabled.
    ///Params:
    ///    profileTypesBitmask = A bitmask of profiles from NET_FW_PROFILE_TYPE2.
    ///    group = A string that was used to group rules together. It can be the group name or an indirect string to the group
    ///            name in the form of "@yourresourcedll.dll,-23255". Rules belonging to this group would be queried.
    ///    enabled = Indicates whether the group of rules identified by the <i>group</i> parameter are enabled or disabled. If
    ///              this value is set to true (<b>VARIANT_TRUE</b>), the group of rules is enabled; otherwise the group is
    ///              disabled.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds, the return value is S_OK. If the method fails, the return value is one
    ///    of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to
    ///    permissions issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method failed because a pointer was invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The requested group
    ///    does not exist. </td> </tr> </table> <h3>VB</h3> This call returns a boolean enable status which indicates
    ///    whether the group of rules identified by the group parameter are enabled or disabled. If this value is set to
    ///    true (VARIANT_TRUE), the group of rules is enabled; otherwise, the group is disabled.
    ///    
    HRESULT IsRuleGroupEnabled(int profileTypesBitmask, BSTR group, short* enabled);
    ///The <b>RestoreLocalFirewallDefaults</b> method restores the local firewall configuration to its default state.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds the return value is S_OK. If the method fails, the return value is one of
    ///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> </table> <h3>VB</h3> If the method succeeds the return value is S_OK. If the method
    ///    fails, the return value is one of the following error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was aborted due to permissions issues. </td> </tr> </table>
    ///    
    HRESULT RestoreLocalFirewallDefaults();
    ///Specifies the default action for inbound traffic. These settings are Block by default. This property is
    ///read/write.
    HRESULT get_DefaultInboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION* action);
    ///Specifies the default action for inbound traffic. These settings are Block by default. This property is
    ///read/write.
    HRESULT put_DefaultInboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION action);
    ///Specifies the default action for outbound traffic. These settings are Allow by default. This property is
    ///read/write.
    HRESULT get_DefaultOutboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION* action);
    ///Specifies the default action for outbound traffic. These settings are Allow by default. This property is
    ///read/write.
    HRESULT put_DefaultOutboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION action);
    ///The <b>get_IsRuleGroupCurrentlyEnabled</b> method determines whether a specified group of firewall rules are
    ///enabled or disabled for the current profile.
    ///Params:
    ///    group = A string that was used to group rules together. It can be the group name or an indirect string to the group
    ///            name in the form of "@C:\Program Files\Contoso Storefront\StorefrontRes.dll,-1234". Rules belonging to this
    ///            group would be queried.
    ///    enabled = Indicates whether the group of rules identified by the <i>group</i> parameter are enabled or disabled. If
    ///              this value is set to true (<b>VARIANT_TRUE</b>), the group of rules is enabled; otherwise the group is
    ///              disabled. For Windows 7 and later, this value will be set to true (<b>VARIANT_TRUE</b>) if the rule group is
    ///              enabled on at least one active profile.
    ///Returns:
    ///    <h3>C++</h3> If the method succeeds, the return value is S_OK. If the method fails, the return value is one
    ///    of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to
    ///    permissions issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method failed because a pointer was invalid. </td>
    ///    </tr> </table> For Windows 7 and later, if multiple profiles are active and the profiles have different
    ///    answers for <b>IsRuleGroupCurrentlyEnabled</b>, the return value is S_FALSE; if the profiles have the same
    ///    answer for <b>IsRuleGroupCurrentlyEnabled</b>, the return value is S_TRUE. <h3>VB</h3> This call returns a
    ///    boolean enable status which indicates whether the group of rules identified by the group parameter are
    ///    enabled or disabled. If this value is set to true (<b>VARIANT_TRUE</b>), the group of rules is enabled;
    ///    otherwise, the group is disabled.
    ///    
    HRESULT get_IsRuleGroupCurrentlyEnabled(BSTR group, short* enabled);
    ///The LocalPolicyModifyState attribute determines if adding or setting a rule or group of rules will take effect in
    ///the current firewall profile. This property is read-only.
    HRESULT get_LocalPolicyModifyState(NET_FW_MODIFY_STATE* modifyState);
}

///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use of
///the Windows Firewall with Advanced Security API is recommended.] The INetFwMgr interface provides access to the
///firewall settings for a computer.
@GUID("F7898AF5-CAC4-4632-A2EC-DA06E5111AF2")
interface INetFwMgr : IDispatch
{
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the local firewall policy. This
    ///property is read-only.
    HRESULT get_LocalPolicy(INetFwPolicy* localPolicy);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Retrieves the type of firewall profile
    ///currently in effect. This property is read-only.
    HRESULT get_CurrentProfileType(NET_FW_PROFILE_TYPE* profileType);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Restores the local configuration to its
    ///default, installed state.
    ///Returns:
    ///    <h3>C++</h3> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was stopped because of permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The
    ///    method was unable to allocate required memory. </td> </tr> </table> <h3>VB</h3> If the method succeeds, the
    ///    return value is S_OK. If the method fails, the return value is one of the following error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt>
    ///    </dl> </td> <td width="60%"> The operation was stopped because of permissions issues. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    allocate required memory. </td> </tr> </table>
    ///    
    HRESULT RestoreDefaults();
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Determines whether an application can listen
    ///for inbound traffic on the specified port.
    ///Params:
    ///    imageFileName = The image file name of the process listening on the network. It must be a fully qualified path, but may
    ///                    contain environment variables. If <i>imageFileName</i> is <b>NULL</b>, the function determines whether the
    ///                    port is allowed for all applications.
    ///    ipVersion = IP version of the traffic. If <i>localAddress</i> is non-<b>NULL</b>, this must not be
    ///                <b>NET_FW_IP_VERSION_ANY</b>.
    ///    portNumber = Local IP port number of the traffic.
    ///    localAddress = Either a dotted-decimal IPv4 address or an IPv6 hex address specifying the local address of the traffic.
    ///                   Typically, this is the address passed to bind. If <i>localAddress</i> is <b>NULL</b>, the function determines
    ///                   whether the port is allowed for all interfaces.
    ///    ipProtocol = IP protocol of the traffic, either <b>NET_FW_IP_PROTOCOL_TCP</b> or <b>NET_FW_IP_PROTOCOL_UDP</b>.
    ///    allowed = Indicates by a value of VARIANT_TRUE or VARIANT_FALSE whether the port is allowed for at least some local
    ///              interfaces and remote addresses.
    ///    restricted = Indicates by a value of VARIANT_TRUE or VARIANT_FALSE whether some local interfaces or remote addresses are
    ///                 blocked for this port. For example, if the port is restricted to the local subnet only.
    ///Returns:
    ///    <h3>C++</h3> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was stopped because of permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed because a pointer was not valid. </td> </tr> </table> <h3>VB</h3> If the method succeeds, the return
    ///    value is S_OK. If the method fails, the return value is one of the following error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt>
    ///    </dl> </td> <td width="60%"> The operation was stopped because of permissions issues. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed because a
    ///    parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The method was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method failed because a pointer was not valid.
    ///    </td> </tr> </table>
    ///    
    HRESULT IsPortAllowed(BSTR imageFileName, NET_FW_IP_VERSION ipVersion, int portNumber, BSTR localAddress, 
                          NET_FW_IP_PROTOCOL ipProtocol, VARIANT* allowed, VARIANT* restricted);
    ///<p class="CCE_Message">[The Windows Firewall API is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For Windows Vista and later, use
    ///of the Windows Firewall with Advanced Security API is recommended.] Determines whether the specified ICMP type is
    ///allowed.
    ///Params:
    ///    ipVersion = IP version of the traffic. This cannot be <b>NET_FW_IP_VERSION_ANY</b>. IP version of the traffic. This
    ///                cannot be <b>NET_FW_IP_VERSION_ANY</b>.
    ///    localAddress = Either a dotted-decimal IPv4 address or an IPv6 hex address specifying the local address of the traffic.
    ///                   Typically, this is the address passed to bind. If <i>localAddress</i> is <b>NULL</b>, the function determines
    ///                   whether the port is allowed for all interfaces. Either a dotted-decimal IPv4 address or an IPv6 hex address
    ///                   specifying the local address of the traffic. Typically, this is the address passed to bind. If
    ///                   <i>localAddress</i> is <b>NULL</b>, the function determines whether the port is allowed for all interfaces.
    ///    type = ICMP type. For a list of possible ICMP types, see ICMP Type Numbers. ICMP type.
    ///    allowed = Indicates by a value of VARIANT_TRUE or VARIANT_FALSE whether the port is allowed for at least some local
    ///              interfaces and remote addresses. Indicates by a value of VARIANT_TRUE or VARIANT_FALSE whether the port is
    ///              allowed for at least some local interfaces and remote addresses.
    ///    restricted = Indicates by a value of VARIANT_TRUE or VARIANT_FALSE whether some local interfaces or remote addresses are
    ///                 blocked for this port. For example, if the port is restricted to the local subnet only. Indicates by a value
    ///                 of VARIANT_TRUE or VARIANT_FALSE whether some local interfaces or remote addresses are blocked for this port.
    ///                 For example, if the port is restricted to the local subnet only.
    ///Returns:
    ///    <h3>C++</h3> <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was stopped because of permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed because a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed because a pointer was not valid. </td> </tr> </table> <h3>VB</h3> If the method succeeds the return
    ///    value is <b>S_OK</b>. If the method fails, the return value is one of the following error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt>
    ///    </dl> </td> <td width="60%"> The operation was stopped because of permissions issues. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed because a
    ///    parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The method was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method failed because a pointer was not valid.
    ///    </td> </tr> </table>
    ///    
    HRESULT IsIcmpTypeAllowed(NET_FW_IP_VERSION ipVersion, BSTR localAddress, ubyte type, VARIANT* allowed, 
                              VARIANT* restricted);
}

///The <b>INetFwProduct</b> interface allows an application or service to access the properties of a third-party
///firewall registration.
@GUID("71881699-18F4-458B-B892-3FFCE5E07F75")
interface INetFwProduct : IDispatch
{
    ///For a third-party firewall product registration, indicates the rule categories for which the third-party firewall
    ///wishes to take ownership from Windows Firewall. This property is read/write.
    HRESULT get_RuleCategories(VARIANT* ruleCategories);
    ///For a third-party firewall product registration, indicates the rule categories for which the third-party firewall
    ///wishes to take ownership from Windows Firewall. This property is read/write.
    HRESULT put_RuleCategories(VARIANT ruleCategories);
    ///Indicates the display name for a third-party firewall product registration. This property is read/write.
    HRESULT get_DisplayName(BSTR* displayName);
    ///Indicates the display name for a third-party firewall product registration. This property is read/write.
    HRESULT put_DisplayName(BSTR displayName);
    ///Indicates the path to the signed executable file of a third-party firewall product registration. This property is
    ///read-only.
    HRESULT get_PathToSignedProductExe(BSTR* path);
}

///The <b>INetFwProducts</b> interface allows an application or service to access the methods and properties for
///registering third-party firewall products with Windows Firewall and for enumerating registered products.
@GUID("39EB36E0-2097-40BD-8AF2-63A13B525362")
interface INetFwProducts : IDispatch
{
    ///Indicates the number of registered third-party firewall products. This property is read-only.
    HRESULT get_Count(int* count);
    ///The <b>Register</b> method registers a third-party firewall product.
    ///Params:
    ///    product = The INetFwProduct object that defines the product to be registered.
    ///    registration = The registration handle. The registration will be removed when this object is released.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>SEC_E_CANNOT_INSTALL</b></dt> </dl> </td> <td width="60%"> The product binary has not been
    ///    signed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%">
    ///    The operation was aborted due to permissions issues. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The method failed due to an invalid parameter.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed due to an invalid pointer. </td> </tr> </table>
    ///    
    HRESULT Register(INetFwProduct product, IUnknown* registration);
    ///The <b>Item</b> method returns the product with the specified index if it is in the collection.
    ///Params:
    ///    index = Index of the product to retrieve.
    ///    product = Reference to the returned INetFwProduct object.
    ///Returns:
    ///    If the method succeeds the return value is S_OK. If the method fails, the return value is one of the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The operation was aborted due to permissions
    ///    issues. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed due to an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate required memory.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed due to an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND) </b></dt> </dl> </td> <td width="60%"> The requested item
    ///    does not exist. </td> </tr> </table>
    ///    
    HRESULT Item(int index, INetFwProduct* product);
    ///Returns an object supporting <b>IEnumVARIANT</b> that can be used to iterate through all the registered
    ///third-party firewall products in the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* newEnum);
}


// GUIDs

const GUID CLSID_NetFwAuthorizedApplication = GUIDOF!NetFwAuthorizedApplication;
const GUID CLSID_NetFwMgr                   = GUIDOF!NetFwMgr;
const GUID CLSID_NetFwOpenPort              = GUIDOF!NetFwOpenPort;
const GUID CLSID_NetFwPolicy2               = GUIDOF!NetFwPolicy2;
const GUID CLSID_NetFwProduct               = GUIDOF!NetFwProduct;
const GUID CLSID_NetFwProducts              = GUIDOF!NetFwProducts;
const GUID CLSID_NetFwRule                  = GUIDOF!NetFwRule;
const GUID CLSID_NetSharingManager          = GUIDOF!NetSharingManager;
const GUID CLSID_UPnPNAT                    = GUIDOF!UPnPNAT;

const GUID IID_IDynamicPortMapping                    = GUIDOF!IDynamicPortMapping;
const GUID IID_IDynamicPortMappingCollection          = GUIDOF!IDynamicPortMappingCollection;
const GUID IID_IEnumNetConnection                     = GUIDOF!IEnumNetConnection;
const GUID IID_IEnumNetSharingEveryConnection         = GUIDOF!IEnumNetSharingEveryConnection;
const GUID IID_IEnumNetSharingPortMapping             = GUIDOF!IEnumNetSharingPortMapping;
const GUID IID_IEnumNetSharingPrivateConnection       = GUIDOF!IEnumNetSharingPrivateConnection;
const GUID IID_IEnumNetSharingPublicConnection        = GUIDOF!IEnumNetSharingPublicConnection;
const GUID IID_INATEventManager                       = GUIDOF!INATEventManager;
const GUID IID_INATExternalIPAddressCallback          = GUIDOF!INATExternalIPAddressCallback;
const GUID IID_INATNumberOfEntriesCallback            = GUIDOF!INATNumberOfEntriesCallback;
const GUID IID_INetConnection                         = GUIDOF!INetConnection;
const GUID IID_INetConnectionConnectUi                = GUIDOF!INetConnectionConnectUi;
const GUID IID_INetConnectionManager                  = GUIDOF!INetConnectionManager;
const GUID IID_INetConnectionProps                    = GUIDOF!INetConnectionProps;
const GUID IID_INetFwAuthorizedApplication            = GUIDOF!INetFwAuthorizedApplication;
const GUID IID_INetFwAuthorizedApplications           = GUIDOF!INetFwAuthorizedApplications;
const GUID IID_INetFwIcmpSettings                     = GUIDOF!INetFwIcmpSettings;
const GUID IID_INetFwMgr                              = GUIDOF!INetFwMgr;
const GUID IID_INetFwOpenPort                         = GUIDOF!INetFwOpenPort;
const GUID IID_INetFwOpenPorts                        = GUIDOF!INetFwOpenPorts;
const GUID IID_INetFwPolicy                           = GUIDOF!INetFwPolicy;
const GUID IID_INetFwPolicy2                          = GUIDOF!INetFwPolicy2;
const GUID IID_INetFwProduct                          = GUIDOF!INetFwProduct;
const GUID IID_INetFwProducts                         = GUIDOF!INetFwProducts;
const GUID IID_INetFwProfile                          = GUIDOF!INetFwProfile;
const GUID IID_INetFwRemoteAdminSettings              = GUIDOF!INetFwRemoteAdminSettings;
const GUID IID_INetFwRule                             = GUIDOF!INetFwRule;
const GUID IID_INetFwRule2                            = GUIDOF!INetFwRule2;
const GUID IID_INetFwRule3                            = GUIDOF!INetFwRule3;
const GUID IID_INetFwRules                            = GUIDOF!INetFwRules;
const GUID IID_INetFwService                          = GUIDOF!INetFwService;
const GUID IID_INetFwServiceRestriction               = GUIDOF!INetFwServiceRestriction;
const GUID IID_INetFwServices                         = GUIDOF!INetFwServices;
const GUID IID_INetSharingConfiguration               = GUIDOF!INetSharingConfiguration;
const GUID IID_INetSharingEveryConnectionCollection   = GUIDOF!INetSharingEveryConnectionCollection;
const GUID IID_INetSharingManager                     = GUIDOF!INetSharingManager;
const GUID IID_INetSharingPortMapping                 = GUIDOF!INetSharingPortMapping;
const GUID IID_INetSharingPortMappingCollection       = GUIDOF!INetSharingPortMappingCollection;
const GUID IID_INetSharingPortMappingProps            = GUIDOF!INetSharingPortMappingProps;
const GUID IID_INetSharingPrivateConnectionCollection = GUIDOF!INetSharingPrivateConnectionCollection;
const GUID IID_INetSharingPublicConnectionCollection  = GUIDOF!INetSharingPublicConnectionCollection;
const GUID IID_IStaticPortMapping                     = GUIDOF!IStaticPortMapping;
const GUID IID_IStaticPortMappingCollection           = GUIDOF!IStaticPortMappingCollection;
const GUID IID_IUPnPNAT                               = GUIDOF!IUPnPNAT;
