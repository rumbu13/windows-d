module windows.enhancedstorage;

public import windows.com;
public import windows.systemservices;
public import windows.windowsportabledevices;

extern(Windows):

struct ENHANCED_STORAGE_PASSWORD_SILO_INFORMATION
{
    ubyte CurrentAdminFailures;
    ubyte CurrentUserFailures;
    uint TotalUserAuthenticationCount;
    uint TotalAdminAuthenticationCount;
    BOOL FipsCompliant;
    BOOL SecurityIDAvailable;
    BOOL InitializeInProgress;
    BOOL ITMSArmed;
    BOOL ITMSArmable;
    BOOL UserCreated;
    BOOL ResetOnPORDefault;
    BOOL ResetOnPORCurrent;
    ubyte MaxAdminFailures;
    ubyte MaxUserFailures;
    uint TimeToCompleteInitialization;
    uint TimeRemainingToCompleteInitialization;
    uint MinTimeToAuthenticate;
    ubyte MaxAdminPasswordSize;
    ubyte MinAdminPasswordSize;
    ubyte MaxAdminHintSize;
    ubyte MaxUserPasswordSize;
    ubyte MinUserPasswordSize;
    ubyte MaxUserHintSize;
    ubyte MaxUserNameSize;
    ubyte MaxSiloNameSize;
    ushort MaxChallengeSize;
}

const GUID CLSID_EnumEnhancedStorageACT = {0xFE841493, 0x835C, 0x4FA3, [0xB6, 0xCC, 0xB4, 0xB2, 0xD4, 0x71, 0x98, 0x48]};
@GUID(0xFE841493, 0x835C, 0x4FA3, [0xB6, 0xCC, 0xB4, 0xB2, 0xD4, 0x71, 0x98, 0x48]);
struct EnumEnhancedStorageACT;

const GUID CLSID_EnhancedStorageACT = {0xAF076A15, 0x2ECE, 0x4AD4, [0xBB, 0x21, 0x29, 0xF0, 0x40, 0xE1, 0x76, 0xD8]};
@GUID(0xAF076A15, 0x2ECE, 0x4AD4, [0xBB, 0x21, 0x29, 0xF0, 0x40, 0xE1, 0x76, 0xD8]);
struct EnhancedStorageACT;

const GUID CLSID_EnhancedStorageSilo = {0xCB25220C, 0x76C7, 0x4FEE, [0x84, 0x2B, 0xF3, 0x38, 0x3C, 0xD0, 0x22, 0xBC]};
@GUID(0xCB25220C, 0x76C7, 0x4FEE, [0x84, 0x2B, 0xF3, 0x38, 0x3C, 0xD0, 0x22, 0xBC]);
struct EnhancedStorageSilo;

const GUID CLSID_EnhancedStorageSiloAction = {0x886D29DD, 0xB506, 0x466B, [0x9F, 0xBF, 0xB4, 0x4F, 0xF3, 0x83, 0xFB, 0x3F]};
@GUID(0x886D29DD, 0xB506, 0x466B, [0x9F, 0xBF, 0xB4, 0x4F, 0xF3, 0x83, 0xFB, 0x3F]);
struct EnhancedStorageSiloAction;

struct ACT_AUTHORIZATION_STATE
{
    uint ulState;
}

struct SILO_INFO
{
    uint ulSTID;
    ubyte SpecificationMajor;
    ubyte SpecificationMinor;
    ubyte ImplementationMajor;
    ubyte ImplementationMinor;
    ubyte type;
    ubyte capabilities;
}

enum ACT_AUTHORIZATION_STATE_VALUE
{
    ACT_UNAUTHORIZED = 0,
    ACT_AUTHORIZED = 1,
}

const GUID IID_IEnumEnhancedStorageACT = {0x09B224BD, 0x1335, 0x4631, [0xA7, 0xFF, 0xCF, 0xD3, 0xA9, 0x26, 0x46, 0xD7]};
@GUID(0x09B224BD, 0x1335, 0x4631, [0xA7, 0xFF, 0xCF, 0xD3, 0xA9, 0x26, 0x46, 0xD7]);
interface IEnumEnhancedStorageACT : IUnknown
{
    HRESULT GetACTs(IEnhancedStorageACT** pppIEnhancedStorageACTs, uint* pcEnhancedStorageACTs);
    HRESULT GetMatchingACT(const(wchar)* szVolume, IEnhancedStorageACT* ppIEnhancedStorageACT);
}

const GUID IID_IEnhancedStorageACT = {0x6E7781F4, 0xE0F2, 0x4239, [0xB9, 0x76, 0xA0, 0x1A, 0xBA, 0xB5, 0x29, 0x30]};
@GUID(0x6E7781F4, 0xE0F2, 0x4239, [0xB9, 0x76, 0xA0, 0x1A, 0xBA, 0xB5, 0x29, 0x30]);
interface IEnhancedStorageACT : IUnknown
{
    HRESULT Authorize(uint hwndParent, uint dwFlags);
    HRESULT Unauthorize();
    HRESULT GetAuthorizationState(ACT_AUTHORIZATION_STATE* pState);
    HRESULT GetMatchingVolume(ushort** ppwszVolume);
    HRESULT GetUniqueIdentity(ushort** ppwszIdentity);
    HRESULT GetSilos(IEnhancedStorageSilo** pppIEnhancedStorageSilos, uint* pcEnhancedStorageSilos);
}

const GUID IID_IEnhancedStorageACT2 = {0x4DA57D2E, 0x8EB3, 0x41F6, [0xA0, 0x7E, 0x98, 0xB5, 0x2B, 0x88, 0x24, 0x2B]};
@GUID(0x4DA57D2E, 0x8EB3, 0x41F6, [0xA0, 0x7E, 0x98, 0xB5, 0x2B, 0x88, 0x24, 0x2B]);
interface IEnhancedStorageACT2 : IEnhancedStorageACT
{
    HRESULT GetDeviceName(ushort** ppwszDeviceName);
    HRESULT IsDeviceRemovable(int* pIsDeviceRemovable);
}

const GUID IID_IEnhancedStorageACT3 = {0x022150A1, 0x113D, 0x11DF, [0xBB, 0x61, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0x022150A1, 0x113D, 0x11DF, [0xBB, 0x61, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
interface IEnhancedStorageACT3 : IEnhancedStorageACT2
{
    HRESULT UnauthorizeEx(uint dwFlags);
    HRESULT IsQueueFrozen(int* pIsQueueFrozen);
    HRESULT GetShellExtSupport(int* pShellExtSupport);
}

const GUID IID_IEnhancedStorageSilo = {0x5AEF78C6, 0x2242, 0x4703, [0xBF, 0x49, 0x44, 0xB2, 0x93, 0x57, 0xA3, 0x59]};
@GUID(0x5AEF78C6, 0x2242, 0x4703, [0xBF, 0x49, 0x44, 0xB2, 0x93, 0x57, 0xA3, 0x59]);
interface IEnhancedStorageSilo : IUnknown
{
    HRESULT GetInfo(SILO_INFO* pSiloInfo);
    HRESULT GetActions(IEnhancedStorageSiloAction** pppIEnhancedStorageSiloActions, uint* pcEnhancedStorageSiloActions);
    HRESULT SendCommand(ubyte Command, ubyte* pbCommandBuffer, uint cbCommandBuffer, ubyte* pbResponseBuffer, uint* pcbResponseBuffer);
    HRESULT GetPortableDevice(IPortableDevice* ppIPortableDevice);
    HRESULT GetDevicePath(ushort** ppwszSiloDevicePath);
}

const GUID IID_IEnhancedStorageSiloAction = {0xB6F7F311, 0x206F, 0x4FF8, [0x9C, 0x4B, 0x27, 0xEF, 0xEE, 0x77, 0xA8, 0x6F]};
@GUID(0xB6F7F311, 0x206F, 0x4FF8, [0x9C, 0x4B, 0x27, 0xEF, 0xEE, 0x77, 0xA8, 0x6F]);
interface IEnhancedStorageSiloAction : IUnknown
{
    HRESULT GetName(ushort** ppwszActionName);
    HRESULT GetDescription(ushort** ppwszActionDescription);
    HRESULT Invoke();
}

