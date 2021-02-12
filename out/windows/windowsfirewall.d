module windows.windowsfirewall;

public import system;
public import windows.automation;
public import windows.com;
public import windows.security;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

const GUID CLSID_UPnPNAT = {0xAE1E00AA, 0x3FD5, 0x403C, [0x8A, 0x27, 0x2B, 0xBD, 0xC3, 0x0C, 0xD0, 0xE1]};
@GUID(0xAE1E00AA, 0x3FD5, 0x403C, [0x8A, 0x27, 0x2B, 0xBD, 0xC3, 0x0C, 0xD0, 0xE1]);
struct UPnPNAT;

const GUID IID_IUPnPNAT = {0xB171C812, 0xCC76, 0x485A, [0x94, 0xD8, 0xB6, 0xB3, 0xA2, 0x79, 0x4E, 0x99]};
@GUID(0xB171C812, 0xCC76, 0x485A, [0x94, 0xD8, 0xB6, 0xB3, 0xA2, 0x79, 0x4E, 0x99]);
interface IUPnPNAT : IDispatch
{
    HRESULT get_StaticPortMappingCollection(IStaticPortMappingCollection* ppSPMs);
    HRESULT get_DynamicPortMappingCollection(IDynamicPortMappingCollection* ppDPMs);
    HRESULT get_NATEventManager(INATEventManager* ppNEM);
}

const GUID IID_INATEventManager = {0x624BD588, 0x9060, 0x4109, [0xB0, 0xB0, 0x1A, 0xDB, 0xBC, 0xAC, 0x32, 0xDF]};
@GUID(0x624BD588, 0x9060, 0x4109, [0xB0, 0xB0, 0x1A, 0xDB, 0xBC, 0xAC, 0x32, 0xDF]);
interface INATEventManager : IDispatch
{
    HRESULT put_ExternalIPAddressCallback(IUnknown pUnk);
    HRESULT put_NumberOfEntriesCallback(IUnknown pUnk);
}

const GUID IID_INATExternalIPAddressCallback = {0x9C416740, 0xA34E, 0x446F, [0xBA, 0x06, 0xAB, 0xD0, 0x4C, 0x31, 0x49, 0xAE]};
@GUID(0x9C416740, 0xA34E, 0x446F, [0xBA, 0x06, 0xAB, 0xD0, 0x4C, 0x31, 0x49, 0xAE]);
interface INATExternalIPAddressCallback : IUnknown
{
    HRESULT NewExternalIPAddress(BSTR bstrNewExternalIPAddress);
}

const GUID IID_INATNumberOfEntriesCallback = {0xC83A0A74, 0x91EE, 0x41B6, [0xB6, 0x7A, 0x67, 0xE0, 0xF0, 0x0B, 0xBD, 0x78]};
@GUID(0xC83A0A74, 0x91EE, 0x41B6, [0xB6, 0x7A, 0x67, 0xE0, 0xF0, 0x0B, 0xBD, 0x78]);
interface INATNumberOfEntriesCallback : IUnknown
{
    HRESULT NewNumberOfEntries(int lNewNumberOfEntries);
}

const GUID IID_IDynamicPortMappingCollection = {0xB60DE00F, 0x156E, 0x4E8D, [0x9E, 0xC1, 0x3A, 0x23, 0x42, 0xC1, 0x08, 0x99]};
@GUID(0xB60DE00F, 0x156E, 0x4E8D, [0x9E, 0xC1, 0x3A, 0x23, 0x42, 0xC1, 0x08, 0x99]);
interface IDynamicPortMappingCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Item(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol, IDynamicPortMapping* ppDPM);
    HRESULT get_Count(int* pVal);
    HRESULT Remove(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol);
    HRESULT Add(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol, int lInternalPort, BSTR bstrInternalClient, short bEnabled, BSTR bstrDescription, int lLeaseDuration, IDynamicPortMapping* ppDPM);
}

const GUID IID_IDynamicPortMapping = {0x4FC80282, 0x23B6, 0x4378, [0x9A, 0x27, 0xCD, 0x8F, 0x17, 0xC9, 0x40, 0x0C]};
@GUID(0x4FC80282, 0x23B6, 0x4378, [0x9A, 0x27, 0xCD, 0x8F, 0x17, 0xC9, 0x40, 0x0C]);
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

const GUID IID_IStaticPortMappingCollection = {0xCD1F3E77, 0x66D6, 0x4664, [0x82, 0xC7, 0x36, 0xDB, 0xB6, 0x41, 0xD0, 0xF1]};
@GUID(0xCD1F3E77, 0x66D6, 0x4664, [0x82, 0xC7, 0x36, 0xDB, 0xB6, 0x41, 0xD0, 0xF1]);
interface IStaticPortMappingCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Item(int lExternalPort, BSTR bstrProtocol, IStaticPortMapping* ppSPM);
    HRESULT get_Count(int* pVal);
    HRESULT Remove(int lExternalPort, BSTR bstrProtocol);
    HRESULT Add(int lExternalPort, BSTR bstrProtocol, int lInternalPort, BSTR bstrInternalClient, short bEnabled, BSTR bstrDescription, IStaticPortMapping* ppSPM);
}

const GUID IID_IStaticPortMapping = {0x6F10711F, 0x729B, 0x41E5, [0x93, 0xB8, 0xF2, 0x1D, 0x0F, 0x81, 0x8D, 0xF1]};
@GUID(0x6F10711F, 0x729B, 0x41E5, [0x93, 0xB8, 0xF2, 0x1D, 0x0F, 0x81, 0x8D, 0xF1]);
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

const GUID CLSID_NetSharingManager = {0x5C63C1AD, 0x3956, 0x4FF8, [0x84, 0x86, 0x40, 0x03, 0x47, 0x58, 0x31, 0x5B]};
@GUID(0x5C63C1AD, 0x3956, 0x4FF8, [0x84, 0x86, 0x40, 0x03, 0x47, 0x58, 0x31, 0x5B]);
struct NetSharingManager;

const GUID IID_IEnumNetConnection = {0xC08956A0, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956A0, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface IEnumNetConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetConnection* ppenum);
}

enum NETCON_CHARACTERISTIC_FLAGS
{
    NCCF_NONE = 0,
    NCCF_ALL_USERS = 1,
    NCCF_ALLOW_DUPLICATION = 2,
    NCCF_ALLOW_REMOVAL = 4,
    NCCF_ALLOW_RENAME = 8,
    NCCF_INCOMING_ONLY = 32,
    NCCF_OUTGOING_ONLY = 64,
    NCCF_BRANDED = 128,
    NCCF_SHARED = 256,
    NCCF_BRIDGED = 512,
    NCCF_FIREWALLED = 1024,
    NCCF_DEFAULT = 2048,
    NCCF_HOMENET_CAPABLE = 4096,
    NCCF_SHARED_PRIVATE = 8192,
    NCCF_QUARANTINED = 16384,
    NCCF_RESERVED = 32768,
    NCCF_HOSTED_NETWORK = 65536,
    NCCF_VIRTUAL_STATION = 131072,
    NCCF_WIFI_DIRECT = 262144,
    NCCF_BLUETOOTH_MASK = 983040,
    NCCF_LAN_MASK = 15728640,
}

enum NETCON_STATUS
{
    NCS_DISCONNECTED = 0,
    NCS_CONNECTING = 1,
    NCS_CONNECTED = 2,
    NCS_DISCONNECTING = 3,
    NCS_HARDWARE_NOT_PRESENT = 4,
    NCS_HARDWARE_DISABLED = 5,
    NCS_HARDWARE_MALFUNCTION = 6,
    NCS_MEDIA_DISCONNECTED = 7,
    NCS_AUTHENTICATING = 8,
    NCS_AUTHENTICATION_SUCCEEDED = 9,
    NCS_AUTHENTICATION_FAILED = 10,
    NCS_INVALID_ADDRESS = 11,
    NCS_CREDENTIALS_REQUIRED = 12,
    NCS_ACTION_REQUIRED = 13,
    NCS_ACTION_REQUIRED_RETRY = 14,
    NCS_CONNECT_FAILED = 15,
}

enum NETCON_TYPE
{
    NCT_DIRECT_CONNECT = 0,
    NCT_INBOUND = 1,
    NCT_INTERNET = 2,
    NCT_LAN = 3,
    NCT_PHONE = 4,
    NCT_TUNNEL = 5,
    NCT_BRIDGE = 6,
}

enum NETCON_MEDIATYPE
{
    NCM_NONE = 0,
    NCM_DIRECT = 1,
    NCM_ISDN = 2,
    NCM_LAN = 3,
    NCM_PHONE = 4,
    NCM_TUNNEL = 5,
    NCM_PPPOE = 6,
    NCM_BRIDGE = 7,
    NCM_SHAREDACCESSHOST_LAN = 8,
    NCM_SHAREDACCESSHOST_RAS = 9,
}

struct NETCON_PROPERTIES
{
    Guid guidId;
    const(wchar)* pszwName;
    const(wchar)* pszwDeviceName;
    NETCON_STATUS Status;
    NETCON_MEDIATYPE MediaType;
    uint dwCharacter;
    Guid clsidThisObject;
    Guid clsidUiObject;
}

const GUID IID_INetConnection = {0xC08956A1, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956A1, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface INetConnection : IUnknown
{
    HRESULT Connect();
    HRESULT Disconnect();
    HRESULT Delete();
    HRESULT Duplicate(const(wchar)* pszwDuplicateName, INetConnection* ppCon);
    HRESULT GetProperties(NETCON_PROPERTIES** ppProps);
    HRESULT GetUiObjectClassId(Guid* pclsid);
    HRESULT Rename(const(wchar)* pszwNewName);
}

enum NETCONMGR_ENUM_FLAGS
{
    NCME_DEFAULT = 0,
    NCME_HIDDEN = 1,
}

const GUID IID_INetConnectionManager = {0xC08956A2, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956A2, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface INetConnectionManager : IUnknown
{
    HRESULT EnumConnections(NETCONMGR_ENUM_FLAGS Flags, IEnumNetConnection* ppEnum);
}

enum NETCONUI_CONNECT_FLAGS
{
    NCUC_DEFAULT = 0,
    NCUC_NO_UI = 1,
    NCUC_ENABLE_DISABLE = 2,
}

const GUID IID_INetConnectionConnectUi = {0xC08956A3, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956A3, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface INetConnectionConnectUi : IUnknown
{
    HRESULT SetConnection(INetConnection pCon);
    HRESULT Connect(HWND hwndParent, uint dwFlags);
    HRESULT Disconnect(HWND hwndParent, uint dwFlags);
}

const GUID IID_IEnumNetSharingPortMapping = {0xC08956B0, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956B0, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface IEnumNetSharingPortMapping : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingPortMapping* ppenum);
}

const GUID IID_INetSharingPortMappingProps = {0x24B7E9B5, 0xE38F, 0x4685, [0x85, 0x1B, 0x00, 0x89, 0x2C, 0xF5, 0xF9, 0x40]};
@GUID(0x24B7E9B5, 0xE38F, 0x4685, [0x85, 0x1B, 0x00, 0x89, 0x2C, 0xF5, 0xF9, 0x40]);
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

const GUID IID_INetSharingPortMapping = {0xC08956B1, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956B1, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface INetSharingPortMapping : IDispatch
{
    HRESULT Disable();
    HRESULT Enable();
    HRESULT get_Properties(INetSharingPortMappingProps* ppNSPMP);
    HRESULT Delete();
}

const GUID IID_IEnumNetSharingEveryConnection = {0xC08956B8, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956B8, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface IEnumNetSharingEveryConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingEveryConnection* ppenum);
}

const GUID IID_IEnumNetSharingPublicConnection = {0xC08956B4, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956B4, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface IEnumNetSharingPublicConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingPublicConnection* ppenum);
}

const GUID IID_IEnumNetSharingPrivateConnection = {0xC08956B5, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956B5, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface IEnumNetSharingPrivateConnection : IUnknown
{
    HRESULT Next(uint celt, char* rgVar, uint* pCeltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetSharingPrivateConnection* ppenum);
}

const GUID IID_INetSharingPortMappingCollection = {0x02E4A2DE, 0xDA20, 0x4E34, [0x89, 0xC8, 0xAC, 0x22, 0x27, 0x5A, 0x01, 0x0B]};
@GUID(0x02E4A2DE, 0xDA20, 0x4E34, [0x89, 0xC8, 0xAC, 0x22, 0x27, 0x5A, 0x01, 0x0B]);
interface INetSharingPortMappingCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

const GUID IID_INetConnectionProps = {0xF4277C95, 0xCE5B, 0x463D, [0x81, 0x67, 0x56, 0x62, 0xD9, 0xBC, 0xAA, 0x72]};
@GUID(0xF4277C95, 0xCE5B, 0x463D, [0x81, 0x67, 0x56, 0x62, 0xD9, 0xBC, 0xAA, 0x72]);
interface INetConnectionProps : IDispatch
{
    HRESULT get_Guid(BSTR* pbstrGuid);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    HRESULT get_Status(NETCON_STATUS* pStatus);
    HRESULT get_MediaType(NETCON_MEDIATYPE* pMediaType);
    HRESULT get_Characteristics(uint* pdwFlags);
}

enum SHARINGCONNECTIONTYPE
{
    ICSSHARINGTYPE_PUBLIC = 0,
    ICSSHARINGTYPE_PRIVATE = 1,
}

enum SHARINGCONNECTION_ENUM_FLAGS
{
    ICSSC_DEFAULT = 0,
    ICSSC_ENABLED = 1,
}

enum ICS_TARGETTYPE
{
    ICSTT_NAME = 0,
    ICSTT_IPADDRESS = 1,
}

const GUID IID_INetSharingConfiguration = {0xC08956B6, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956B6, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
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
    HRESULT AddPortMapping(BSTR bstrName, ubyte ucIPProtocol, ushort usExternalPort, ushort usInternalPort, uint dwOptions, BSTR bstrTargetNameOrIPAddress, ICS_TARGETTYPE eTargetType, INetSharingPortMapping* ppMapping);
    HRESULT RemovePortMapping(INetSharingPortMapping pMapping);
}

const GUID IID_INetSharingEveryConnectionCollection = {0x33C4643C, 0x7811, 0x46FA, [0xA8, 0x9A, 0x76, 0x85, 0x97, 0xBD, 0x72, 0x23]};
@GUID(0x33C4643C, 0x7811, 0x46FA, [0xA8, 0x9A, 0x76, 0x85, 0x97, 0xBD, 0x72, 0x23]);
interface INetSharingEveryConnectionCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

const GUID IID_INetSharingPublicConnectionCollection = {0x7D7A6355, 0xF372, 0x4971, [0xA1, 0x49, 0xBF, 0xC9, 0x27, 0xBE, 0x76, 0x2A]};
@GUID(0x7D7A6355, 0xF372, 0x4971, [0xA1, 0x49, 0xBF, 0xC9, 0x27, 0xBE, 0x76, 0x2A]);
interface INetSharingPublicConnectionCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

const GUID IID_INetSharingPrivateConnectionCollection = {0x38AE69E0, 0x4409, 0x402A, [0xA2, 0xCB, 0xE9, 0x65, 0xC7, 0x27, 0xF8, 0x40]};
@GUID(0x38AE69E0, 0x4409, 0x402A, [0xA2, 0xCB, 0xE9, 0x65, 0xC7, 0x27, 0xF8, 0x40]);
interface INetSharingPrivateConnectionCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
}

const GUID IID_INetSharingManager = {0xC08956B7, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0xC08956B7, 0x1CD3, 0x11D1, [0xB1, 0xC5, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
interface INetSharingManager : IDispatch
{
    HRESULT get_SharingInstalled(short* pbInstalled);
    HRESULT get_EnumPublicConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, INetSharingPublicConnectionCollection* ppColl);
    HRESULT get_EnumPrivateConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, INetSharingPrivateConnectionCollection* ppColl);
    HRESULT get_INetSharingConfigurationForINetConnection(INetConnection pNetConnection, INetSharingConfiguration* ppNetSharingConfiguration);
    HRESULT get_EnumEveryConnection(INetSharingEveryConnectionCollection* ppColl);
    HRESULT get_NetConnectionProps(INetConnection pNetConnection, INetConnectionProps* ppProps);
}

const GUID CLSID_NetFwRule = {0x2C5BC43E, 0x3369, 0x4C33, [0xAB, 0x0C, 0xBE, 0x94, 0x69, 0x67, 0x7A, 0xF4]};
@GUID(0x2C5BC43E, 0x3369, 0x4C33, [0xAB, 0x0C, 0xBE, 0x94, 0x69, 0x67, 0x7A, 0xF4]);
struct NetFwRule;

const GUID CLSID_NetFwOpenPort = {0x0CA545C6, 0x37AD, 0x4A6C, [0xBF, 0x92, 0x9F, 0x76, 0x10, 0x06, 0x7E, 0xF5]};
@GUID(0x0CA545C6, 0x37AD, 0x4A6C, [0xBF, 0x92, 0x9F, 0x76, 0x10, 0x06, 0x7E, 0xF5]);
struct NetFwOpenPort;

const GUID CLSID_NetFwAuthorizedApplication = {0xEC9846B3, 0x2762, 0x4A6B, [0xA2, 0x14, 0x6A, 0xCB, 0x60, 0x34, 0x62, 0xD2]};
@GUID(0xEC9846B3, 0x2762, 0x4A6B, [0xA2, 0x14, 0x6A, 0xCB, 0x60, 0x34, 0x62, 0xD2]);
struct NetFwAuthorizedApplication;

const GUID CLSID_NetFwPolicy2 = {0xE2B3C97F, 0x6AE1, 0x41AC, [0x81, 0x7A, 0xF6, 0xF9, 0x21, 0x66, 0xD7, 0xDD]};
@GUID(0xE2B3C97F, 0x6AE1, 0x41AC, [0x81, 0x7A, 0xF6, 0xF9, 0x21, 0x66, 0xD7, 0xDD]);
struct NetFwPolicy2;

const GUID CLSID_NetFwProduct = {0x9D745ED8, 0xC514, 0x4D1D, [0xBF, 0x42, 0x75, 0x1F, 0xED, 0x2D, 0x5A, 0xC7]};
@GUID(0x9D745ED8, 0xC514, 0x4D1D, [0xBF, 0x42, 0x75, 0x1F, 0xED, 0x2D, 0x5A, 0xC7]);
struct NetFwProduct;

const GUID CLSID_NetFwProducts = {0xCC19079B, 0x8272, 0x4D73, [0xBB, 0x70, 0xCD, 0xB5, 0x33, 0x52, 0x7B, 0x61]};
@GUID(0xCC19079B, 0x8272, 0x4D73, [0xBB, 0x70, 0xCD, 0xB5, 0x33, 0x52, 0x7B, 0x61]);
struct NetFwProducts;

const GUID CLSID_NetFwMgr = {0x304CE942, 0x6E39, 0x40D8, [0x94, 0x3A, 0xB9, 0x13, 0xC4, 0x0C, 0x9C, 0xD4]};
@GUID(0x304CE942, 0x6E39, 0x40D8, [0x94, 0x3A, 0xB9, 0x13, 0xC4, 0x0C, 0x9C, 0xD4]);
struct NetFwMgr;

enum NET_FW_POLICY_TYPE
{
    NET_FW_POLICY_GROUP = 0,
    NET_FW_POLICY_LOCAL = 1,
    NET_FW_POLICY_EFFECTIVE = 2,
    NET_FW_POLICY_TYPE_MAX = 3,
}

enum NET_FW_PROFILE_TYPE
{
    NET_FW_PROFILE_DOMAIN = 0,
    NET_FW_PROFILE_STANDARD = 1,
    NET_FW_PROFILE_CURRENT = 2,
    NET_FW_PROFILE_TYPE_MAX = 3,
}

enum NET_FW_PROFILE_TYPE2
{
    NET_FW_PROFILE2_DOMAIN = 1,
    NET_FW_PROFILE2_PRIVATE = 2,
    NET_FW_PROFILE2_PUBLIC = 4,
    NET_FW_PROFILE2_ALL = 2147483647,
}

enum NET_FW_IP_VERSION
{
    NET_FW_IP_VERSION_V4 = 0,
    NET_FW_IP_VERSION_V6 = 1,
    NET_FW_IP_VERSION_ANY = 2,
    NET_FW_IP_VERSION_MAX = 3,
}

enum NET_FW_SCOPE
{
    NET_FW_SCOPE_ALL = 0,
    NET_FW_SCOPE_LOCAL_SUBNET = 1,
    NET_FW_SCOPE_CUSTOM = 2,
    NET_FW_SCOPE_MAX = 3,
}

enum NET_FW_IP_PROTOCOL
{
    NET_FW_IP_PROTOCOL_TCP = 6,
    NET_FW_IP_PROTOCOL_UDP = 17,
    NET_FW_IP_PROTOCOL_ANY = 256,
}

enum NET_FW_SERVICE_TYPE
{
    NET_FW_SERVICE_FILE_AND_PRINT = 0,
    NET_FW_SERVICE_UPNP = 1,
    NET_FW_SERVICE_REMOTE_DESKTOP = 2,
    NET_FW_SERVICE_NONE = 3,
    NET_FW_SERVICE_TYPE_MAX = 4,
}

enum NET_FW_RULE_DIRECTION
{
    NET_FW_RULE_DIR_IN = 1,
    NET_FW_RULE_DIR_OUT = 2,
    NET_FW_RULE_DIR_MAX = 3,
}

enum NET_FW_ACTION
{
    NET_FW_ACTION_BLOCK = 0,
    NET_FW_ACTION_ALLOW = 1,
    NET_FW_ACTION_MAX = 2,
}

enum NET_FW_MODIFY_STATE
{
    NET_FW_MODIFY_STATE_OK = 0,
    NET_FW_MODIFY_STATE_GP_OVERRIDE = 1,
    NET_FW_MODIFY_STATE_INBOUND_BLOCKED = 2,
}

enum NET_FW_RULE_CATEGORY
{
    NET_FW_RULE_CATEGORY_BOOT = 0,
    NET_FW_RULE_CATEGORY_STEALTH = 1,
    NET_FW_RULE_CATEGORY_FIREWALL = 2,
    NET_FW_RULE_CATEGORY_CONSEC = 3,
    NET_FW_RULE_CATEGORY_MAX = 4,
}

enum NET_FW_EDGE_TRAVERSAL_TYPE
{
    NET_FW_EDGE_TRAVERSAL_TYPE_DENY = 0,
    NET_FW_EDGE_TRAVERSAL_TYPE_ALLOW = 1,
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_APP = 2,
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_USER = 3,
}

enum NET_FW_AUTHENTICATE_TYPE
{
    NET_FW_AUTHENTICATE_NONE = 0,
    NET_FW_AUTHENTICATE_NO_ENCAPSULATION = 1,
    NET_FW_AUTHENTICATE_WITH_INTEGRITY = 2,
    NET_FW_AUTHENTICATE_AND_NEGOTIATE_ENCRYPTION = 3,
    NET_FW_AUTHENTICATE_AND_ENCRYPT = 4,
}

enum NETISO_FLAG
{
    NETISO_FLAG_FORCE_COMPUTE_BINARIES = 1,
    NETISO_FLAG_MAX = 2,
}

enum INET_FIREWALL_AC_CREATION_TYPE
{
    INET_FIREWALL_AC_NONE = 0,
    INET_FIREWALL_AC_PACKAGE_ID_ONLY = 1,
    INET_FIREWALL_AC_BINARY = 2,
    INET_FIREWALL_AC_MAX = 4,
}

enum INET_FIREWALL_AC_CHANGE_TYPE
{
    INET_FIREWALL_AC_CHANGE_INVALID = 0,
    INET_FIREWALL_AC_CHANGE_CREATE = 1,
    INET_FIREWALL_AC_CHANGE_DELETE = 2,
    INET_FIREWALL_AC_CHANGE_MAX = 3,
}

struct INET_FIREWALL_AC_CAPABILITIES
{
    uint count;
    SID_AND_ATTRIBUTES* capabilities;
}

struct INET_FIREWALL_AC_BINARIES
{
    uint count;
    ushort** binaries;
}

struct INET_FIREWALL_AC_CHANGE
{
    INET_FIREWALL_AC_CHANGE_TYPE changeType;
    INET_FIREWALL_AC_CREATION_TYPE createType;
    SID* appContainerSid;
    SID* userSid;
    const(wchar)* displayName;
    _Anonymous_e__Union Anonymous;
}

struct INET_FIREWALL_APP_CONTAINER
{
    SID* appContainerSid;
    SID* userSid;
    const(wchar)* appContainerName;
    const(wchar)* displayName;
    const(wchar)* description;
    INET_FIREWALL_AC_CAPABILITIES capabilities;
    INET_FIREWALL_AC_BINARIES binaries;
    const(wchar)* workingDirectory;
    const(wchar)* packageFullName;
}

alias PAC_CHANGES_CALLBACK_FN = extern(Windows) void function(void* context, const(INET_FIREWALL_AC_CHANGE)* pChange);
enum NETISO_ERROR_TYPE
{
    NETISO_ERROR_TYPE_NONE = 0,
    NETISO_ERROR_TYPE_PRIVATE_NETWORK = 1,
    NETISO_ERROR_TYPE_INTERNET_CLIENT = 2,
    NETISO_ERROR_TYPE_INTERNET_CLIENT_SERVER = 3,
    NETISO_ERROR_TYPE_MAX = 4,
}

alias PNETISO_EDP_ID_CALLBACK_FN = extern(Windows) void function(void* context, const(ushort)* wszEnterpriseId, uint dwErr);
const GUID IID_INetFwRemoteAdminSettings = {0xD4BECDDF, 0x6F73, 0x4A83, [0xB8, 0x32, 0x9C, 0x66, 0x87, 0x4C, 0xD2, 0x0E]};
@GUID(0xD4BECDDF, 0x6F73, 0x4A83, [0xB8, 0x32, 0x9C, 0x66, 0x87, 0x4C, 0xD2, 0x0E]);
interface INetFwRemoteAdminSettings : IDispatch
{
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    HRESULT get_Scope(NET_FW_SCOPE* scope);
    HRESULT put_Scope(NET_FW_SCOPE scope);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
}

const GUID IID_INetFwIcmpSettings = {0xA6207B2E, 0x7CDD, 0x426A, [0x95, 0x1E, 0x5E, 0x1C, 0xBC, 0x5A, 0xFE, 0xAD]};
@GUID(0xA6207B2E, 0x7CDD, 0x426A, [0x95, 0x1E, 0x5E, 0x1C, 0xBC, 0x5A, 0xFE, 0xAD]);
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

const GUID IID_INetFwOpenPort = {0xE0483BA0, 0x47FF, 0x4D9C, [0xA6, 0xD6, 0x77, 0x41, 0xD0, 0xB1, 0x95, 0xF7]};
@GUID(0xE0483BA0, 0x47FF, 0x4D9C, [0xA6, 0xD6, 0x77, 0x41, 0xD0, 0xB1, 0x95, 0xF7]);
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
    HRESULT get_Scope(NET_FW_SCOPE* scope);
    HRESULT put_Scope(NET_FW_SCOPE scope);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_BuiltIn(short* builtIn);
}

const GUID IID_INetFwOpenPorts = {0xC0E9D7FA, 0xE07E, 0x430A, [0xB1, 0x9A, 0x09, 0x0C, 0xE8, 0x2D, 0x92, 0xE2]};
@GUID(0xC0E9D7FA, 0xE07E, 0x430A, [0xB1, 0x9A, 0x09, 0x0C, 0xE8, 0x2D, 0x92, 0xE2]);
interface INetFwOpenPorts : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Add(INetFwOpenPort port);
    HRESULT Remove(int portNumber, NET_FW_IP_PROTOCOL ipProtocol);
    HRESULT Item(int portNumber, NET_FW_IP_PROTOCOL ipProtocol, INetFwOpenPort* openPort);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

const GUID IID_INetFwService = {0x79FD57C8, 0x908E, 0x4A36, [0x98, 0x88, 0xD5, 0xB3, 0xF0, 0xA4, 0x44, 0xCF]};
@GUID(0x79FD57C8, 0x908E, 0x4A36, [0x98, 0x88, 0xD5, 0xB3, 0xF0, 0xA4, 0x44, 0xCF]);
interface INetFwService : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_Type(NET_FW_SERVICE_TYPE* type);
    HRESULT get_Customized(short* customized);
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    HRESULT get_Scope(NET_FW_SCOPE* scope);
    HRESULT put_Scope(NET_FW_SCOPE scope);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_GloballyOpenPorts(INetFwOpenPorts* openPorts);
}

const GUID IID_INetFwServices = {0x79649BB4, 0x903E, 0x421B, [0x94, 0xC9, 0x79, 0x84, 0x8E, 0x79, 0xF6, 0xEE]};
@GUID(0x79649BB4, 0x903E, 0x421B, [0x94, 0xC9, 0x79, 0x84, 0x8E, 0x79, 0xF6, 0xEE]);
interface INetFwServices : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Item(NET_FW_SERVICE_TYPE svcType, INetFwService* service);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

const GUID IID_INetFwAuthorizedApplication = {0xB5E64FFA, 0xC2C5, 0x444E, [0xA3, 0x01, 0xFB, 0x5E, 0x00, 0x01, 0x80, 0x50]};
@GUID(0xB5E64FFA, 0xC2C5, 0x444E, [0xA3, 0x01, 0xFB, 0x5E, 0x00, 0x01, 0x80, 0x50]);
interface INetFwAuthorizedApplication : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_ProcessImageFileName(BSTR* imageFileName);
    HRESULT put_ProcessImageFileName(BSTR imageFileName);
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    HRESULT get_Scope(NET_FW_SCOPE* scope);
    HRESULT put_Scope(NET_FW_SCOPE scope);
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
}

const GUID IID_INetFwAuthorizedApplications = {0x644EFD52, 0xCCF9, 0x486C, [0x97, 0xA2, 0x39, 0xF3, 0x52, 0x57, 0x0B, 0x30]};
@GUID(0x644EFD52, 0xCCF9, 0x486C, [0x97, 0xA2, 0x39, 0xF3, 0x52, 0x57, 0x0B, 0x30]);
interface INetFwAuthorizedApplications : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Add(INetFwAuthorizedApplication app);
    HRESULT Remove(BSTR imageFileName);
    HRESULT Item(BSTR imageFileName, INetFwAuthorizedApplication* app);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

const GUID IID_INetFwRule = {0xAF230D27, 0xBABA, 0x4E42, [0xAC, 0xED, 0xF5, 0x24, 0xF2, 0x2C, 0xFC, 0xE2]};
@GUID(0xAF230D27, 0xBABA, 0x4E42, [0xAC, 0xED, 0xF5, 0x24, 0xF2, 0x2C, 0xFC, 0xE2]);
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

const GUID IID_INetFwRule2 = {0x9C27C8DA, 0x189B, 0x4DDE, [0x89, 0xF7, 0x8B, 0x39, 0xA3, 0x16, 0x78, 0x2C]};
@GUID(0x9C27C8DA, 0x189B, 0x4DDE, [0x89, 0xF7, 0x8B, 0x39, 0xA3, 0x16, 0x78, 0x2C]);
interface INetFwRule2 : INetFwRule
{
    HRESULT get_EdgeTraversalOptions(int* lOptions);
    HRESULT put_EdgeTraversalOptions(int lOptions);
}

const GUID IID_INetFwRule3 = {0xB21563FF, 0xD696, 0x4222, [0xAB, 0x46, 0x4E, 0x89, 0xB7, 0x3A, 0xB3, 0x4A]};
@GUID(0xB21563FF, 0xD696, 0x4222, [0xAB, 0x46, 0x4E, 0x89, 0xB7, 0x3A, 0xB3, 0x4A]);
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

const GUID IID_INetFwRules = {0x9C4C6277, 0x5027, 0x441E, [0xAF, 0xAE, 0xCA, 0x1F, 0x54, 0x2D, 0xA0, 0x09]};
@GUID(0x9C4C6277, 0x5027, 0x441E, [0xAF, 0xAE, 0xCA, 0x1F, 0x54, 0x2D, 0xA0, 0x09]);
interface INetFwRules : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Add(INetFwRule rule);
    HRESULT Remove(BSTR name);
    HRESULT Item(BSTR name, INetFwRule* rule);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

const GUID IID_INetFwServiceRestriction = {0x8267BBE3, 0xF890, 0x491C, [0xB7, 0xB6, 0x2D, 0xB1, 0xEF, 0x0E, 0x5D, 0x2B]};
@GUID(0x8267BBE3, 0xF890, 0x491C, [0xB7, 0xB6, 0x2D, 0xB1, 0xEF, 0x0E, 0x5D, 0x2B]);
interface INetFwServiceRestriction : IDispatch
{
    HRESULT RestrictService(BSTR serviceName, BSTR appName, short restrictService, short serviceSidRestricted);
    HRESULT ServiceRestricted(BSTR serviceName, BSTR appName, short* serviceRestricted);
    HRESULT get_Rules(INetFwRules* rules);
}

const GUID IID_INetFwProfile = {0x174A0DDA, 0xE9F9, 0x449D, [0x99, 0x3B, 0x21, 0xAB, 0x66, 0x7C, 0xA4, 0x56]};
@GUID(0x174A0DDA, 0xE9F9, 0x449D, [0x99, 0x3B, 0x21, 0xAB, 0x66, 0x7C, 0xA4, 0x56]);
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

const GUID IID_INetFwPolicy = {0xD46D2478, 0x9AC9, 0x4008, [0x9D, 0xC7, 0x55, 0x63, 0xCE, 0x55, 0x36, 0xCC]};
@GUID(0xD46D2478, 0x9AC9, 0x4008, [0x9D, 0xC7, 0x55, 0x63, 0xCE, 0x55, 0x36, 0xCC]);
interface INetFwPolicy : IDispatch
{
    HRESULT get_CurrentProfile(INetFwProfile* profile);
    HRESULT GetProfileByType(NET_FW_PROFILE_TYPE profileType, INetFwProfile* profile);
}

const GUID IID_INetFwPolicy2 = {0x98325047, 0xC671, 0x4174, [0x8D, 0x81, 0xDE, 0xFC, 0xD3, 0xF0, 0x31, 0x86]};
@GUID(0x98325047, 0xC671, 0x4174, [0x8D, 0x81, 0xDE, 0xFC, 0xD3, 0xF0, 0x31, 0x86]);
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

const GUID IID_INetFwMgr = {0xF7898AF5, 0xCAC4, 0x4632, [0xA2, 0xEC, 0xDA, 0x06, 0xE5, 0x11, 0x1A, 0xF2]};
@GUID(0xF7898AF5, 0xCAC4, 0x4632, [0xA2, 0xEC, 0xDA, 0x06, 0xE5, 0x11, 0x1A, 0xF2]);
interface INetFwMgr : IDispatch
{
    HRESULT get_LocalPolicy(INetFwPolicy* localPolicy);
    HRESULT get_CurrentProfileType(NET_FW_PROFILE_TYPE* profileType);
    HRESULT RestoreDefaults();
    HRESULT IsPortAllowed(BSTR imageFileName, NET_FW_IP_VERSION ipVersion, int portNumber, BSTR localAddress, NET_FW_IP_PROTOCOL ipProtocol, VARIANT* allowed, VARIANT* restricted);
    HRESULT IsIcmpTypeAllowed(NET_FW_IP_VERSION ipVersion, BSTR localAddress, ubyte type, VARIANT* allowed, VARIANT* restricted);
}

const GUID IID_INetFwProduct = {0x71881699, 0x18F4, 0x458B, [0xB8, 0x92, 0x3F, 0xFC, 0xE5, 0xE0, 0x7F, 0x75]};
@GUID(0x71881699, 0x18F4, 0x458B, [0xB8, 0x92, 0x3F, 0xFC, 0xE5, 0xE0, 0x7F, 0x75]);
interface INetFwProduct : IDispatch
{
    HRESULT get_RuleCategories(VARIANT* ruleCategories);
    HRESULT put_RuleCategories(VARIANT ruleCategories);
    HRESULT get_DisplayName(BSTR* displayName);
    HRESULT put_DisplayName(BSTR displayName);
    HRESULT get_PathToSignedProductExe(BSTR* path);
}

const GUID IID_INetFwProducts = {0x39EB36E0, 0x2097, 0x40BD, [0x8A, 0xF2, 0x63, 0xA1, 0x3B, 0x52, 0x53, 0x62]};
@GUID(0x39EB36E0, 0x2097, 0x40BD, [0x8A, 0xF2, 0x63, 0xA1, 0x3B, 0x52, 0x53, 0x62]);
interface INetFwProducts : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Register(INetFwProduct product, IUnknown* registration);
    HRESULT Item(int index, INetFwProduct* product);
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
HRESULT NetworkIsolationSetupAppContainerBinaries(void* applicationContainerSid, const(wchar)* packageFullName, const(wchar)* packageFolder, const(wchar)* displayName, BOOL bBinariesFullyComputed, char* binaries, uint binariesCount);

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationRegisterForAppContainerChanges(uint flags, PAC_CHANGES_CALLBACK_FN callback, void* context, HANDLE* registrationObject);

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationUnregisterForAppContainerChanges(HANDLE registrationObject);

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationFreeAppContainers(INET_FIREWALL_APP_CONTAINER* pPublicAppCs);

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationEnumAppContainers(uint Flags, uint* pdwNumPublicAppCs, INET_FIREWALL_APP_CONTAINER** ppPublicAppCs);

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationGetAppContainerConfig(uint* pdwNumPublicAppCs, SID_AND_ATTRIBUTES** appContainerSids);

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationSetAppContainerConfig(uint dwNumPublicAppCs, char* appContainerSids);

@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationDiagnoseConnectFailureAndGetInfo(const(wchar)* wszServerName, NETISO_ERROR_TYPE* netIsoError);

