module windows.windowsfirewall;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.security : SID, SID_AND_ATTRIBUTES;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    NCCF_NONE              = 0x00000000,
    NCCF_ALL_USERS         = 0x00000001,
    NCCF_ALLOW_DUPLICATION = 0x00000002,
    NCCF_ALLOW_REMOVAL     = 0x00000004,
    NCCF_ALLOW_RENAME      = 0x00000008,
    NCCF_INCOMING_ONLY     = 0x00000020,
    NCCF_OUTGOING_ONLY     = 0x00000040,
    NCCF_BRANDED           = 0x00000080,
    NCCF_SHARED            = 0x00000100,
    NCCF_BRIDGED           = 0x00000200,
    NCCF_FIREWALLED        = 0x00000400,
    NCCF_DEFAULT           = 0x00000800,
    NCCF_HOMENET_CAPABLE   = 0x00001000,
    NCCF_SHARED_PRIVATE    = 0x00002000,
    NCCF_QUARANTINED       = 0x00004000,
    NCCF_RESERVED          = 0x00008000,
    NCCF_HOSTED_NETWORK    = 0x00010000,
    NCCF_VIRTUAL_STATION   = 0x00020000,
    NCCF_WIFI_DIRECT       = 0x00040000,
    NCCF_BLUETOOTH_MASK    = 0x000f0000,
    NCCF_LAN_MASK          = 0x00f00000,
}
alias NETCON_CHARACTERISTIC_FLAGS = int;

enum : int
{
    NCS_DISCONNECTED             = 0x00000000,
    NCS_CONNECTING               = 0x00000001,
    NCS_CONNECTED                = 0x00000002,
    NCS_DISCONNECTING            = 0x00000003,
    NCS_HARDWARE_NOT_PRESENT     = 0x00000004,
    NCS_HARDWARE_DISABLED        = 0x00000005,
    NCS_HARDWARE_MALFUNCTION     = 0x00000006,
    NCS_MEDIA_DISCONNECTED       = 0x00000007,
    NCS_AUTHENTICATING           = 0x00000008,
    NCS_AUTHENTICATION_SUCCEEDED = 0x00000009,
    NCS_AUTHENTICATION_FAILED    = 0x0000000a,
    NCS_INVALID_ADDRESS          = 0x0000000b,
    NCS_CREDENTIALS_REQUIRED     = 0x0000000c,
    NCS_ACTION_REQUIRED          = 0x0000000d,
    NCS_ACTION_REQUIRED_RETRY    = 0x0000000e,
    NCS_CONNECT_FAILED           = 0x0000000f,
}
alias NETCON_STATUS = int;

enum : int
{
    NCT_DIRECT_CONNECT = 0x00000000,
    NCT_INBOUND        = 0x00000001,
    NCT_INTERNET       = 0x00000002,
    NCT_LAN            = 0x00000003,
    NCT_PHONE          = 0x00000004,
    NCT_TUNNEL         = 0x00000005,
    NCT_BRIDGE         = 0x00000006,
}
alias NETCON_TYPE = int;

enum : int
{
    NCM_NONE                 = 0x00000000,
    NCM_DIRECT               = 0x00000001,
    NCM_ISDN                 = 0x00000002,
    NCM_LAN                  = 0x00000003,
    NCM_PHONE                = 0x00000004,
    NCM_TUNNEL               = 0x00000005,
    NCM_PPPOE                = 0x00000006,
    NCM_BRIDGE               = 0x00000007,
    NCM_SHAREDACCESSHOST_LAN = 0x00000008,
    NCM_SHAREDACCESSHOST_RAS = 0x00000009,
}
alias NETCON_MEDIATYPE = int;

enum : int
{
    NCME_DEFAULT = 0x00000000,
    NCME_HIDDEN  = 0x00000001,
}
alias NETCONMGR_ENUM_FLAGS = int;

enum : int
{
    NCUC_DEFAULT        = 0x00000000,
    NCUC_NO_UI          = 0x00000001,
    NCUC_ENABLE_DISABLE = 0x00000002,
}
alias NETCONUI_CONNECT_FLAGS = int;

enum : int
{
    ICSSHARINGTYPE_PUBLIC  = 0x00000000,
    ICSSHARINGTYPE_PRIVATE = 0x00000001,
}
alias SHARINGCONNECTIONTYPE = int;

enum : int
{
    ICSSC_DEFAULT = 0x00000000,
    ICSSC_ENABLED = 0x00000001,
}
alias SHARINGCONNECTION_ENUM_FLAGS = int;

enum : int
{
    ICSTT_NAME      = 0x00000000,
    ICSTT_IPADDRESS = 0x00000001,
}
alias ICS_TARGETTYPE = int;

enum : int
{
    NET_FW_POLICY_GROUP     = 0x00000000,
    NET_FW_POLICY_LOCAL     = 0x00000001,
    NET_FW_POLICY_EFFECTIVE = 0x00000002,
    NET_FW_POLICY_TYPE_MAX  = 0x00000003,
}
alias NET_FW_POLICY_TYPE = int;

enum : int
{
    NET_FW_PROFILE_DOMAIN   = 0x00000000,
    NET_FW_PROFILE_STANDARD = 0x00000001,
    NET_FW_PROFILE_CURRENT  = 0x00000002,
    NET_FW_PROFILE_TYPE_MAX = 0x00000003,
}
alias NET_FW_PROFILE_TYPE = int;

enum : int
{
    NET_FW_PROFILE2_DOMAIN  = 0x00000001,
    NET_FW_PROFILE2_PRIVATE = 0x00000002,
    NET_FW_PROFILE2_PUBLIC  = 0x00000004,
    NET_FW_PROFILE2_ALL     = 0x7fffffff,
}
alias NET_FW_PROFILE_TYPE2 = int;

enum : int
{
    NET_FW_IP_VERSION_V4  = 0x00000000,
    NET_FW_IP_VERSION_V6  = 0x00000001,
    NET_FW_IP_VERSION_ANY = 0x00000002,
    NET_FW_IP_VERSION_MAX = 0x00000003,
}
alias NET_FW_IP_VERSION = int;

enum : int
{
    NET_FW_SCOPE_ALL          = 0x00000000,
    NET_FW_SCOPE_LOCAL_SUBNET = 0x00000001,
    NET_FW_SCOPE_CUSTOM       = 0x00000002,
    NET_FW_SCOPE_MAX          = 0x00000003,
}
alias NET_FW_SCOPE = int;

enum : int
{
    NET_FW_IP_PROTOCOL_TCP = 0x00000006,
    NET_FW_IP_PROTOCOL_UDP = 0x00000011,
    NET_FW_IP_PROTOCOL_ANY = 0x00000100,
}
alias NET_FW_IP_PROTOCOL = int;

enum : int
{
    NET_FW_SERVICE_FILE_AND_PRINT = 0x00000000,
    NET_FW_SERVICE_UPNP           = 0x00000001,
    NET_FW_SERVICE_REMOTE_DESKTOP = 0x00000002,
    NET_FW_SERVICE_NONE           = 0x00000003,
    NET_FW_SERVICE_TYPE_MAX       = 0x00000004,
}
alias NET_FW_SERVICE_TYPE = int;

enum : int
{
    NET_FW_RULE_DIR_IN  = 0x00000001,
    NET_FW_RULE_DIR_OUT = 0x00000002,
    NET_FW_RULE_DIR_MAX = 0x00000003,
}
alias NET_FW_RULE_DIRECTION = int;

enum : int
{
    NET_FW_ACTION_BLOCK = 0x00000000,
    NET_FW_ACTION_ALLOW = 0x00000001,
    NET_FW_ACTION_MAX   = 0x00000002,
}
alias NET_FW_ACTION = int;

enum : int
{
    NET_FW_MODIFY_STATE_OK              = 0x00000000,
    NET_FW_MODIFY_STATE_GP_OVERRIDE     = 0x00000001,
    NET_FW_MODIFY_STATE_INBOUND_BLOCKED = 0x00000002,
}
alias NET_FW_MODIFY_STATE = int;

enum : int
{
    NET_FW_RULE_CATEGORY_BOOT     = 0x00000000,
    NET_FW_RULE_CATEGORY_STEALTH  = 0x00000001,
    NET_FW_RULE_CATEGORY_FIREWALL = 0x00000002,
    NET_FW_RULE_CATEGORY_CONSEC   = 0x00000003,
    NET_FW_RULE_CATEGORY_MAX      = 0x00000004,
}
alias NET_FW_RULE_CATEGORY = int;

enum : int
{
    NET_FW_EDGE_TRAVERSAL_TYPE_DENY          = 0x00000000,
    NET_FW_EDGE_TRAVERSAL_TYPE_ALLOW         = 0x00000001,
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_APP  = 0x00000002,
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_USER = 0x00000003,
}
alias NET_FW_EDGE_TRAVERSAL_TYPE = int;

enum : int
{
    NET_FW_AUTHENTICATE_NONE                     = 0x00000000,
    NET_FW_AUTHENTICATE_NO_ENCAPSULATION         = 0x00000001,
    NET_FW_AUTHENTICATE_WITH_INTEGRITY           = 0x00000002,
    NET_FW_AUTHENTICATE_AND_NEGOTIATE_ENCRYPTION = 0x00000003,
    NET_FW_AUTHENTICATE_AND_ENCRYPT              = 0x00000004,
}
alias NET_FW_AUTHENTICATE_TYPE = int;

enum : int
{
    NETISO_FLAG_FORCE_COMPUTE_BINARIES = 0x00000001,
    NETISO_FLAG_MAX                    = 0x00000002,
}
alias NETISO_FLAG = int;

enum : int
{
    INET_FIREWALL_AC_NONE            = 0x00000000,
    INET_FIREWALL_AC_PACKAGE_ID_ONLY = 0x00000001,
    INET_FIREWALL_AC_BINARY          = 0x00000002,
    INET_FIREWALL_AC_MAX             = 0x00000004,
}
alias INET_FIREWALL_AC_CREATION_TYPE = int;

enum : int
{
    INET_FIREWALL_AC_CHANGE_INVALID = 0x00000000,
    INET_FIREWALL_AC_CHANGE_CREATE  = 0x00000001,
    INET_FIREWALL_AC_CHANGE_DELETE  = 0x00000002,
    INET_FIREWALL_AC_CHANGE_MAX     = 0x00000003,
}
alias INET_FIREWALL_AC_CHANGE_TYPE = int;

enum : int
{
    NETISO_ERROR_TYPE_NONE                   = 0x00000000,
    NETISO_ERROR_TYPE_PRIVATE_NETWORK        = 0x00000001,
    NETISO_ERROR_TYPE_INTERNET_CLIENT        = 0x00000002,
    NETISO_ERROR_TYPE_INTERNET_CLIENT_SERVER = 0x00000003,
    NETISO_ERROR_TYPE_MAX                    = 0x00000004,
}
alias NETISO_ERROR_TYPE = int;

// Callbacks

alias PAC_CHANGES_CALLBACK_FN = void function(void* context, const(INET_FIREWALL_AC_CHANGE)* pChange);
alias PNETISO_EDP_ID_CALLBACK_FN = void function(void* context, const(ushort)* wszEnterpriseId, uint dwErr);

// Structs


struct NETCON_PROPERTIES
{
    GUID             guidId;
    const(wchar)*    pszwName;
    const(wchar)*    pszwDeviceName;
    NETCON_STATUS    Status;
    NETCON_MEDIATYPE MediaType;
    uint             dwCharacter;
    GUID             clsidThisObject;
    GUID             clsidUiObject;
}

struct INET_FIREWALL_AC_CAPABILITIES
{
    uint                count;
    SID_AND_ATTRIBUTES* capabilities;
}

struct INET_FIREWALL_AC_BINARIES
{
    uint     count;
    ushort** binaries;
}

struct INET_FIREWALL_AC_CHANGE
{
    INET_FIREWALL_AC_CHANGE_TYPE changeType;
    INET_FIREWALL_AC_CREATION_TYPE createType;
    SID*          appContainerSid;
    SID*          userSid;
    const(wchar)* displayName;
    union
    {
        INET_FIREWALL_AC_CAPABILITIES capabilities;
        INET_FIREWALL_AC_BINARIES binaries;
    }
}

struct INET_FIREWALL_APP_CONTAINER
{
    SID*          appContainerSid;
    SID*          userSid;
    const(wchar)* appContainerName;
    const(wchar)* displayName;
    const(wchar)* description;
    INET_FIREWALL_AC_CAPABILITIES capabilities;
    INET_FIREWALL_AC_BINARIES binaries;
    const(wchar)* workingDirectory;
    const(wchar)* packageFullName;
}

// Functions

@DllImport("api-ms-win-net-isolation-l1-1-0")
HRESULT NetworkIsolationSetupAppContainerBinaries(void* applicationContainerSid, const(wchar)* packageFullName, 
                                                  const(wchar)* packageFolder, const(wchar)* displayName, 
                                                  BOOL bBinariesFullyComputed, char* binaries, uint binariesCount);

@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationRegisterForAppContainerChanges(uint flags, PAC_CHANGES_CALLBACK_FN callback, void* context, 
                                                    HANDLE* registrationObject);

@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationUnregisterForAppContainerChanges(HANDLE registrationObject);

@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationFreeAppContainers(INET_FIREWALL_APP_CONTAINER* pPublicAppCs);

@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationEnumAppContainers(uint Flags, uint* pdwNumPublicAppCs, 
                                       INET_FIREWALL_APP_CONTAINER** ppPublicAppCs);

@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationGetAppContainerConfig(uint* pdwNumPublicAppCs, SID_AND_ATTRIBUTES** appContainerSids);

@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationSetAppContainerConfig(uint dwNumPublicAppCs, char* appContainerSids);

@DllImport("api-ms-win-net-isolation-l1-1-0")
uint NetworkIsolationDiagnoseConnectFailureAndGetInfo(const(wchar)* wszServerName, NETISO_ERROR_TYPE* netIsoError);


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

@GUID("B171C812-CC76-485A-94D8-B6B3A2794E99")
interface IUPnPNAT : IDispatch
{
    HRESULT get_StaticPortMappingCollection(IStaticPortMappingCollection* ppSPMs);
    HRESULT get_DynamicPortMappingCollection(IDynamicPortMappingCollection* ppDPMs);
    HRESULT get_NATEventManager(INATEventManager* ppNEM);
}

@GUID("624BD588-9060-4109-B0B0-1ADBBCAC32DF")
interface INATEventManager : IDispatch
{
    HRESULT put_ExternalIPAddressCallback(IUnknown pUnk);
    HRESULT put_NumberOfEntriesCallback(IUnknown pUnk);
}

@GUID("9C416740-A34E-446F-BA06-ABD04C3149AE")
interface INATExternalIPAddressCallback : IUnknown
{
    HRESULT NewExternalIPAddress(BSTR bstrNewExternalIPAddress);
}

@GUID("C83A0A74-91EE-41B6-B67A-67E0F00BBD78")
interface INATNumberOfEntriesCallback : IUnknown
{
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

@GUID("CD1F3E77-66D6-4664-82C7-36DBB641D0F1")
interface IStaticPortMappingCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Item(int lExternalPort, BSTR bstrProtocol, IStaticPortMapping* ppSPM);
    HRESULT get_Count(int* pVal);
    HRESULT Remove(int lExternalPort, BSTR bstrProtocol);
    HRESULT Add(int lExternalPort, BSTR bstrProtocol, int lInternalPort, BSTR bstrInternalClient, short bEnabled, 
                BSTR bstrDescription, IStaticPortMapping* ppSPM);
}

@GUID("6F10711F-729B-41E5-93B8-F21D0F818DF1")
interface IStaticPortMapping : IDispatch
{
    HRESULT get_ExternalIPAddress(BSTR* pVal);
    HRESULT get_ExternalPort(int* pVal);
    HRESULT get_InternalPort(int* pVal);
    HRESULT get_Protocol(BSTR* pVal);
    HRESULT get_InternalClient(BSTR* pVal);
    HRESULT get_Enabled(short* pVal);
    HRESULT get_Description(BSTR* pVal);
    HRESULT EditInternalClient(BSTR bstrInternalClient);
    HRESULT Enable(short vb);
    HRESULT EditDescription(BSTR bstrDescription);
    HRESULT EditInternalPort(int lInternalPort);
}

@GUID("C08956A0-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetConnection* ppenum);
}

@GUID("C08956A1-1CD3-11D1-B1C5-00805FC1270E")
interface INetConnection : IUnknown
{
    HRESULT Connect();
    HRESULT Disconnect();
    HRESULT Delete();
    HRESULT Duplicate(const(wchar)* pszwDuplicateName, INetConnection* ppCon);
    HRESULT GetProperties(NETCON_PROPERTIES** ppProps);
    HRESULT GetUiObjectClassId(GUID* pclsid);
    HRESULT Rename(const(wchar)* pszwNewName);
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

@GUID("C08956B0-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingPortMapping : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingPortMapping* ppenum);
}

@GUID("24B7E9B5-E38F-4685-851B-00892CF5F940")
interface INetSharingPortMappingProps : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_IPProtocol(ubyte* pucIPProt);
    HRESULT get_ExternalPort(int* pusPort);
    HRESULT get_InternalPort(int* pusPort);
    HRESULT get_Options(int* pdwOptions);
    HRESULT get_TargetName(BSTR* pbstrTargetName);
    HRESULT get_TargetIPAddress(BSTR* pbstrTargetIPAddress);
    HRESULT get_Enabled(short* pbool);
}

@GUID("C08956B1-1CD3-11D1-B1C5-00805FC1270E")
interface INetSharingPortMapping : IDispatch
{
    HRESULT Disable();
    HRESULT Enable();
    HRESULT get_Properties(INetSharingPortMappingProps* ppNSPMP);
    HRESULT Delete();
}

@GUID("C08956B8-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingEveryConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingEveryConnection* ppenum);
}

@GUID("C08956B4-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingPublicConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingPublicConnection* ppenum);
}

@GUID("C08956B5-1CD3-11D1-B1C5-00805FC1270E")
interface IEnumNetSharingPrivateConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pCeltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingPrivateConnection* ppenum);
}

@GUID("02E4A2DE-DA20-4E34-89C8-AC22275A010B")
interface INetSharingPortMappingCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

@GUID("F4277C95-CE5B-463D-8167-5662D9BCAA72")
interface INetConnectionProps : IDispatch
{
    HRESULT get_Guid(BSTR* pbstrGuid);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    HRESULT get_Status(NETCON_STATUS* pStatus);
    HRESULT get_MediaType(NETCON_MEDIATYPE* pMediaType);
    HRESULT get_Characteristics(uint* pdwFlags);
}

@GUID("C08956B6-1CD3-11D1-B1C5-00805FC1270E")
interface INetSharingConfiguration : IDispatch
{
    HRESULT get_SharingEnabled(short* pbEnabled);
    HRESULT get_SharingConnectionType(SHARINGCONNECTIONTYPE* pType);
    HRESULT DisableSharing();
    HRESULT EnableSharing(SHARINGCONNECTIONTYPE Type);
    HRESULT get_InternetFirewallEnabled(short* pbEnabled);
    HRESULT DisableInternetFirewall();
    HRESULT EnableInternetFirewall();
    HRESULT get_EnumPortMappings(SHARINGCONNECTION_ENUM_FLAGS Flags, INetSharingPortMappingCollection* ppColl);
    HRESULT AddPortMapping(BSTR bstrName, ubyte ucIPProtocol, ushort usExternalPort, ushort usInternalPort, 
                           uint dwOptions, BSTR bstrTargetNameOrIPAddress, ICS_TARGETTYPE eTargetType, 
                           INetSharingPortMapping* ppMapping);
    HRESULT RemovePortMapping(INetSharingPortMapping pMapping);
}

@GUID("33C4643C-7811-46FA-A89A-768597BD7223")
interface INetSharingEveryConnectionCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

@GUID("7D7A6355-F372-4971-A149-BFC927BE762A")
interface INetSharingPublicConnectionCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

@GUID("38AE69E0-4409-402A-A2CB-E965C727F840")
interface INetSharingPrivateConnectionCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

@GUID("C08956B7-1CD3-11D1-B1C5-00805FC1270E")
interface INetSharingManager : IDispatch
{
    HRESULT get_SharingInstalled(short* pbInstalled);
    HRESULT get_EnumPublicConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, 
                                      INetSharingPublicConnectionCollection* ppColl);
    HRESULT get_EnumPrivateConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, 
                                       INetSharingPrivateConnectionCollection* ppColl);
    HRESULT get_INetSharingConfigurationForINetConnection(INetConnection pNetConnection, 
                                                          INetSharingConfiguration* ppNetSharingConfiguration);
    HRESULT get_EnumEveryConnection(INetSharingEveryConnectionCollection* ppColl);
    HRESULT get_NetConnectionProps(INetConnection pNetConnection, INetConnectionProps* ppProps);
}

@GUID("D4BECDDF-6F73-4A83-B832-9C66874CD20E")
interface INetFwRemoteAdminSettings : IDispatch
{
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
}

@GUID("A6207B2E-7CDD-426A-951E-5E1CBC5AFEAD")
interface INetFwIcmpSettings : IDispatch
{
    HRESULT get_AllowOutboundDestinationUnreachable(short* allow);
    HRESULT put_AllowOutboundDestinationUnreachable(short allow);
    HRESULT get_AllowRedirect(short* allow);
    HRESULT put_AllowRedirect(short allow);
    HRESULT get_AllowInboundEchoRequest(short* allow);
    HRESULT put_AllowInboundEchoRequest(short allow);
    HRESULT get_AllowOutboundTimeExceeded(short* allow);
    HRESULT put_AllowOutboundTimeExceeded(short allow);
    HRESULT get_AllowOutboundParameterProblem(short* allow);
    HRESULT put_AllowOutboundParameterProblem(short allow);
    HRESULT get_AllowOutboundSourceQuench(short* allow);
    HRESULT put_AllowOutboundSourceQuench(short allow);
    HRESULT get_AllowInboundRouterRequest(short* allow);
    HRESULT put_AllowInboundRouterRequest(short allow);
    HRESULT get_AllowInboundTimestampRequest(short* allow);
    HRESULT put_AllowInboundTimestampRequest(short allow);
    HRESULT get_AllowInboundMaskRequest(short* allow);
    HRESULT put_AllowInboundMaskRequest(short allow);
    HRESULT get_AllowOutboundPacketTooBig(short* allow);
    HRESULT put_AllowOutboundPacketTooBig(short allow);
}

@GUID("E0483BA0-47FF-4D9C-A6D6-7741D0B195F7")
interface INetFwOpenPort : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    HRESULT get_Protocol(NET_FW_IP_PROTOCOL* ipProtocol);
    HRESULT put_Protocol(NET_FW_IP_PROTOCOL ipProtocol);
    HRESULT get_Port(int* portNumber);
    HRESULT put_Port(int portNumber);
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_BuiltIn(short* builtIn);
}

@GUID("C0E9D7FA-E07E-430A-B19A-090CE82D92E2")
interface INetFwOpenPorts : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Add(INetFwOpenPort port);
    HRESULT Remove(int portNumber, NET_FW_IP_PROTOCOL ipProtocol);
    HRESULT Item(int portNumber, NET_FW_IP_PROTOCOL ipProtocol, INetFwOpenPort* openPort);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("79FD57C8-908E-4A36-9888-D5B3F0A444CF")
interface INetFwService : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_Type(NET_FW_SERVICE_TYPE* type);
    HRESULT get_Customized(short* customized);
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_GloballyOpenPorts(INetFwOpenPorts* openPorts);
}

@GUID("79649BB4-903E-421B-94C9-79848E79F6EE")
interface INetFwServices : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Item(NET_FW_SERVICE_TYPE svcType, INetFwService* service);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("B5E64FFA-C2C5-444E-A301-FB5E00018050")
interface INetFwAuthorizedApplication : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_ProcessImageFileName(BSTR* imageFileName);
    HRESULT put_ProcessImageFileName(BSTR imageFileName);
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
}

@GUID("644EFD52-CCF9-486C-97A2-39F352570B30")
interface INetFwAuthorizedApplications : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Add(INetFwAuthorizedApplication app);
    HRESULT Remove(BSTR imageFileName);
    HRESULT Item(BSTR imageFileName, INetFwAuthorizedApplication* app);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("AF230D27-BABA-4E42-ACED-F524F22CFCE2")
interface INetFwRule : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Description(BSTR* desc);
    HRESULT put_Description(BSTR desc);
    HRESULT get_ApplicationName(BSTR* imageFileName);
    HRESULT put_ApplicationName(BSTR imageFileName);
    HRESULT get_ServiceName(BSTR* serviceName);
    HRESULT put_ServiceName(BSTR serviceName);
    HRESULT get_Protocol(int* protocol);
    HRESULT put_Protocol(int protocol);
    HRESULT get_LocalPorts(BSTR* portNumbers);
    HRESULT put_LocalPorts(BSTR portNumbers);
    HRESULT get_RemotePorts(BSTR* portNumbers);
    HRESULT put_RemotePorts(BSTR portNumbers);
    HRESULT get_LocalAddresses(BSTR* localAddrs);
    HRESULT put_LocalAddresses(BSTR localAddrs);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_IcmpTypesAndCodes(BSTR* icmpTypesAndCodes);
    HRESULT put_IcmpTypesAndCodes(BSTR icmpTypesAndCodes);
    HRESULT get_Direction(NET_FW_RULE_DIRECTION* dir);
    HRESULT put_Direction(NET_FW_RULE_DIRECTION dir);
    HRESULT get_Interfaces(VARIANT* interfaces);
    HRESULT put_Interfaces(VARIANT interfaces);
    HRESULT get_InterfaceTypes(BSTR* interfaceTypes);
    HRESULT put_InterfaceTypes(BSTR interfaceTypes);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_Grouping(BSTR* context);
    HRESULT put_Grouping(BSTR context);
    HRESULT get_Profiles(int* profileTypesBitmask);
    HRESULT put_Profiles(int profileTypesBitmask);
    HRESULT get_EdgeTraversal(short* enabled);
    HRESULT put_EdgeTraversal(short enabled);
    HRESULT get_Action(NET_FW_ACTION* action);
    HRESULT put_Action(NET_FW_ACTION action);
}

@GUID("9C27C8DA-189B-4DDE-89F7-8B39A316782C")
interface INetFwRule2 : INetFwRule
{
    HRESULT get_EdgeTraversalOptions(int* lOptions);
    HRESULT put_EdgeTraversalOptions(int lOptions);
}

@GUID("B21563FF-D696-4222-AB46-4E89B73AB34A")
interface INetFwRule3 : INetFwRule2
{
    HRESULT get_LocalAppPackageId(BSTR* wszPackageId);
    HRESULT put_LocalAppPackageId(BSTR wszPackageId);
    HRESULT get_LocalUserOwner(BSTR* wszUserOwner);
    HRESULT put_LocalUserOwner(BSTR wszUserOwner);
    HRESULT get_LocalUserAuthorizedList(BSTR* wszUserAuthList);
    HRESULT put_LocalUserAuthorizedList(BSTR wszUserAuthList);
    HRESULT get_RemoteUserAuthorizedList(BSTR* wszUserAuthList);
    HRESULT put_RemoteUserAuthorizedList(BSTR wszUserAuthList);
    HRESULT get_RemoteMachineAuthorizedList(BSTR* wszUserAuthList);
    HRESULT put_RemoteMachineAuthorizedList(BSTR wszUserAuthList);
    HRESULT get_SecureFlags(int* lOptions);
    HRESULT put_SecureFlags(int lOptions);
}

@GUID("9C4C6277-5027-441E-AFAE-CA1F542DA009")
interface INetFwRules : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Add(INetFwRule rule);
    HRESULT Remove(BSTR name);
    HRESULT Item(BSTR name, INetFwRule* rule);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("8267BBE3-F890-491C-B7B6-2DB1EF0E5D2B")
interface INetFwServiceRestriction : IDispatch
{
    HRESULT RestrictService(BSTR serviceName, BSTR appName, short restrictService, short serviceSidRestricted);
    HRESULT ServiceRestricted(BSTR serviceName, BSTR appName, short* serviceRestricted);
    HRESULT get_Rules(INetFwRules* rules);
}

@GUID("174A0DDA-E9F9-449D-993B-21AB667CA456")
interface INetFwProfile : IDispatch
{
    HRESULT get_Type(NET_FW_PROFILE_TYPE* type);
    HRESULT get_FirewallEnabled(short* enabled);
    HRESULT put_FirewallEnabled(short enabled);
    HRESULT get_ExceptionsNotAllowed(short* notAllowed);
    HRESULT put_ExceptionsNotAllowed(short notAllowed);
    HRESULT get_NotificationsDisabled(short* disabled);
    HRESULT put_NotificationsDisabled(short disabled);
    HRESULT get_UnicastResponsesToMulticastBroadcastDisabled(short* disabled);
    HRESULT put_UnicastResponsesToMulticastBroadcastDisabled(short disabled);
    HRESULT get_RemoteAdminSettings(INetFwRemoteAdminSettings* remoteAdminSettings);
    HRESULT get_IcmpSettings(INetFwIcmpSettings* icmpSettings);
    HRESULT get_GloballyOpenPorts(INetFwOpenPorts* openPorts);
    HRESULT get_Services(INetFwServices* services);
    HRESULT get_AuthorizedApplications(INetFwAuthorizedApplications* apps);
}

@GUID("D46D2478-9AC9-4008-9DC7-5563CE5536CC")
interface INetFwPolicy : IDispatch
{
    HRESULT get_CurrentProfile(INetFwProfile* profile);
    HRESULT GetProfileByType(NET_FW_PROFILE_TYPE profileType, INetFwProfile* profile);
}

@GUID("98325047-C671-4174-8D81-DEFCD3F03186")
interface INetFwPolicy2 : IDispatch
{
    HRESULT get_CurrentProfileTypes(int* profileTypesBitmask);
    HRESULT get_FirewallEnabled(NET_FW_PROFILE_TYPE2 profileType, short* enabled);
    HRESULT put_FirewallEnabled(NET_FW_PROFILE_TYPE2 profileType, short enabled);
    HRESULT get_ExcludedInterfaces(NET_FW_PROFILE_TYPE2 profileType, VARIANT* interfaces);
    HRESULT put_ExcludedInterfaces(NET_FW_PROFILE_TYPE2 profileType, VARIANT interfaces);
    HRESULT get_BlockAllInboundTraffic(NET_FW_PROFILE_TYPE2 profileType, short* Block);
    HRESULT put_BlockAllInboundTraffic(NET_FW_PROFILE_TYPE2 profileType, short Block);
    HRESULT get_NotificationsDisabled(NET_FW_PROFILE_TYPE2 profileType, short* disabled);
    HRESULT put_NotificationsDisabled(NET_FW_PROFILE_TYPE2 profileType, short disabled);
    HRESULT get_UnicastResponsesToMulticastBroadcastDisabled(NET_FW_PROFILE_TYPE2 profileType, short* disabled);
    HRESULT put_UnicastResponsesToMulticastBroadcastDisabled(NET_FW_PROFILE_TYPE2 profileType, short disabled);
    HRESULT get_Rules(INetFwRules* rules);
    HRESULT get_ServiceRestriction(INetFwServiceRestriction* ServiceRestriction);
    HRESULT EnableRuleGroup(int profileTypesBitmask, BSTR group, short enable);
    HRESULT IsRuleGroupEnabled(int profileTypesBitmask, BSTR group, short* enabled);
    HRESULT RestoreLocalFirewallDefaults();
    HRESULT get_DefaultInboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION* action);
    HRESULT put_DefaultInboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION action);
    HRESULT get_DefaultOutboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION* action);
    HRESULT put_DefaultOutboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION action);
    HRESULT get_IsRuleGroupCurrentlyEnabled(BSTR group, short* enabled);
    HRESULT get_LocalPolicyModifyState(NET_FW_MODIFY_STATE* modifyState);
}

@GUID("F7898AF5-CAC4-4632-A2EC-DA06E5111AF2")
interface INetFwMgr : IDispatch
{
    HRESULT get_LocalPolicy(INetFwPolicy* localPolicy);
    HRESULT get_CurrentProfileType(NET_FW_PROFILE_TYPE* profileType);
    HRESULT RestoreDefaults();
    HRESULT IsPortAllowed(BSTR imageFileName, NET_FW_IP_VERSION ipVersion, int portNumber, BSTR localAddress, 
                          NET_FW_IP_PROTOCOL ipProtocol, VARIANT* allowed, VARIANT* restricted);
    HRESULT IsIcmpTypeAllowed(NET_FW_IP_VERSION ipVersion, BSTR localAddress, ubyte type, VARIANT* allowed, 
                              VARIANT* restricted);
}

@GUID("71881699-18F4-458B-B892-3FFCE5E07F75")
interface INetFwProduct : IDispatch
{
    HRESULT get_RuleCategories(VARIANT* ruleCategories);
    HRESULT put_RuleCategories(VARIANT ruleCategories);
    HRESULT get_DisplayName(BSTR* displayName);
    HRESULT put_DisplayName(BSTR displayName);
    HRESULT get_PathToSignedProductExe(BSTR* path);
}

@GUID("39EB36E0-2097-40BD-8AF2-63A13B525362")
interface INetFwProducts : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Register(INetFwProduct product, IUnknown* registration);
    HRESULT Item(int index, INetFwProduct* product);
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
