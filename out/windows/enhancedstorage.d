module windows.enhancedstorage;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;
public import windows.windowsportabledevices : IPortableDevice;

extern(Windows):


// Enums


enum : int
{
    ACT_UNAUTHORIZED = 0x00000000,
    ACT_AUTHORIZED   = 0x00000001,
}
alias ACT_AUTHORIZATION_STATE_VALUE = int;

// Structs


struct ENHANCED_STORAGE_PASSWORD_SILO_INFORMATION
{
    ubyte  CurrentAdminFailures;
    ubyte  CurrentUserFailures;
    uint   TotalUserAuthenticationCount;
    uint   TotalAdminAuthenticationCount;
    BOOL   FipsCompliant;
    BOOL   SecurityIDAvailable;
    BOOL   InitializeInProgress;
    BOOL   ITMSArmed;
    BOOL   ITMSArmable;
    BOOL   UserCreated;
    BOOL   ResetOnPORDefault;
    BOOL   ResetOnPORCurrent;
    ubyte  MaxAdminFailures;
    ubyte  MaxUserFailures;
    uint   TimeToCompleteInitialization;
    uint   TimeRemainingToCompleteInitialization;
    uint   MinTimeToAuthenticate;
    ubyte  MaxAdminPasswordSize;
    ubyte  MinAdminPasswordSize;
    ubyte  MaxAdminHintSize;
    ubyte  MaxUserPasswordSize;
    ubyte  MinUserPasswordSize;
    ubyte  MaxUserHintSize;
    ubyte  MaxUserNameSize;
    ubyte  MaxSiloNameSize;
    ushort MaxChallengeSize;
}

struct ACT_AUTHORIZATION_STATE
{
    uint ulState;
}

struct SILO_INFO
{
    uint  ulSTID;
    ubyte SpecificationMajor;
    ubyte SpecificationMinor;
    ubyte ImplementationMajor;
    ubyte ImplementationMinor;
    ubyte type;
    ubyte capabilities;
}

// Interfaces

@GUID("FE841493-835C-4FA3-B6CC-B4B2D4719848")
struct EnumEnhancedStorageACT;

@GUID("AF076A15-2ECE-4AD4-BB21-29F040E176D8")
struct EnhancedStorageACT;

@GUID("CB25220C-76C7-4FEE-842B-F3383CD022BC")
struct EnhancedStorageSilo;

@GUID("886D29DD-B506-466B-9FBF-B44FF383FB3F")
struct EnhancedStorageSiloAction;

@GUID("09B224BD-1335-4631-A7FF-CFD3A92646D7")
interface IEnumEnhancedStorageACT : IUnknown
{
    HRESULT GetACTs(IEnhancedStorageACT** pppIEnhancedStorageACTs, uint* pcEnhancedStorageACTs);
    HRESULT GetMatchingACT(const(wchar)* szVolume, IEnhancedStorageACT* ppIEnhancedStorageACT);
}

@GUID("6E7781F4-E0F2-4239-B976-A01ABAB52930")
interface IEnhancedStorageACT : IUnknown
{
    HRESULT Authorize(uint hwndParent, uint dwFlags);
    HRESULT Unauthorize();
    HRESULT GetAuthorizationState(ACT_AUTHORIZATION_STATE* pState);
    HRESULT GetMatchingVolume(ushort** ppwszVolume);
    HRESULT GetUniqueIdentity(ushort** ppwszIdentity);
    HRESULT GetSilos(IEnhancedStorageSilo** pppIEnhancedStorageSilos, uint* pcEnhancedStorageSilos);
}

@GUID("4DA57D2E-8EB3-41F6-A07E-98B52B88242B")
interface IEnhancedStorageACT2 : IEnhancedStorageACT
{
    HRESULT GetDeviceName(ushort** ppwszDeviceName);
    HRESULT IsDeviceRemovable(int* pIsDeviceRemovable);
}

@GUID("022150A1-113D-11DF-BB61-001AA01BBC58")
interface IEnhancedStorageACT3 : IEnhancedStorageACT2
{
    HRESULT UnauthorizeEx(uint dwFlags);
    HRESULT IsQueueFrozen(int* pIsQueueFrozen);
    HRESULT GetShellExtSupport(int* pShellExtSupport);
}

@GUID("5AEF78C6-2242-4703-BF49-44B29357A359")
interface IEnhancedStorageSilo : IUnknown
{
    HRESULT GetInfo(SILO_INFO* pSiloInfo);
    HRESULT GetActions(IEnhancedStorageSiloAction** pppIEnhancedStorageSiloActions, 
                       uint* pcEnhancedStorageSiloActions);
    HRESULT SendCommand(ubyte Command, ubyte* pbCommandBuffer, uint cbCommandBuffer, ubyte* pbResponseBuffer, 
                        uint* pcbResponseBuffer);
    HRESULT GetPortableDevice(IPortableDevice* ppIPortableDevice);
    HRESULT GetDevicePath(ushort** ppwszSiloDevicePath);
}

@GUID("B6F7F311-206F-4FF8-9C4B-27EFEE77A86F")
interface IEnhancedStorageSiloAction : IUnknown
{
    HRESULT GetName(ushort** ppwszActionName);
    HRESULT GetDescription(ushort** ppwszActionDescription);
    HRESULT Invoke();
}


// GUIDs

const GUID CLSID_EnhancedStorageACT        = GUIDOF!EnhancedStorageACT;
const GUID CLSID_EnhancedStorageSilo       = GUIDOF!EnhancedStorageSilo;
const GUID CLSID_EnhancedStorageSiloAction = GUIDOF!EnhancedStorageSiloAction;
const GUID CLSID_EnumEnhancedStorageACT    = GUIDOF!EnumEnhancedStorageACT;

const GUID IID_IEnhancedStorageACT        = GUIDOF!IEnhancedStorageACT;
const GUID IID_IEnhancedStorageACT2       = GUIDOF!IEnhancedStorageACT2;
const GUID IID_IEnhancedStorageACT3       = GUIDOF!IEnhancedStorageACT3;
const GUID IID_IEnhancedStorageSilo       = GUIDOF!IEnhancedStorageSilo;
const GUID IID_IEnhancedStorageSiloAction = GUIDOF!IEnhancedStorageSiloAction;
const GUID IID_IEnumEnhancedStorageACT    = GUIDOF!IEnumEnhancedStorageACT;
