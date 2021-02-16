module windows.windowsserverbackup;

public import windows.core;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


enum : int
{
    WSB_OB_ET_UNDEFINED = 0x00000000,
    WSB_OB_ET_STRING    = 0x00000001,
    WSB_OB_ET_NUMBER    = 0x00000002,
    WSB_OB_ET_DATETIME  = 0x00000003,
    WSB_OB_ET_TIME      = 0x00000004,
    WSB_OB_ET_SIZE      = 0x00000005,
    WSB_OB_ET_MAX       = 0x00000006,
}
alias WSB_OB_STATUS_ENTRY_PAIR_TYPE = int;

// Structs


struct WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR
{
    const(wchar)* m_wszObStatusEntryPairValue;
    WSB_OB_STATUS_ENTRY_PAIR_TYPE m_ObStatusEntryPairType;
}

struct WSB_OB_STATUS_ENTRY
{
    uint m_dwIcon;
    uint m_dwStatusEntryName;
    uint m_dwStatusEntryValue;
    uint m_cValueTypePair;
    WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR* m_rgValueTypePair;
}

struct WSB_OB_STATUS_INFO
{
    GUID                 m_guidSnapinId;
    uint                 m_cStatusEntry;
    WSB_OB_STATUS_ENTRY* m_rgStatusEntry;
}

struct WSB_OB_REGISTRATION_INFO
{
    const(wchar)* m_wszResourceDLL;
    GUID          m_guidSnapinId;
    uint          m_dwProviderName;
    uint          m_dwProviderIcon;
    ubyte         m_bSupportsRemoting;
}

// Interfaces

@GUID("1EFF3510-4A27-46AD-B9E0-08332F0F4F6D")
interface IWsbApplicationBackupSupport : IUnknown
{
    HRESULT CheckConsistency(const(wchar)* wszWriterMetadata, const(wchar)* wszComponentName, 
                             const(wchar)* wszComponentLogicalPath, uint cVolumes, char* rgwszSourceVolumePath, 
                             char* rgwszSnapshotVolumePath, IWsbApplicationAsync* ppAsync);
}

@GUID("8D3BDB38-4EE8-4718-85F9-C7DBC4AB77AA")
interface IWsbApplicationRestoreSupport : IUnknown
{
    HRESULT PreRestore(const(wchar)* wszWriterMetadata, const(wchar)* wszComponentName, 
                       const(wchar)* wszComponentLogicalPath, ubyte bNoRollForward);
    HRESULT PostRestore(const(wchar)* wszWriterMetadata, const(wchar)* wszComponentName, 
                        const(wchar)* wszComponentLogicalPath, ubyte bNoRollForward);
    HRESULT OrderComponents(uint cComponents, char* rgComponentName, char* rgComponentLogicalPaths, 
                            char* prgComponentName, char* prgComponentLogicalPath);
    HRESULT IsRollForwardSupported(ubyte* pbRollForwardSupported);
}

@GUID("0843F6F7-895C-44A6-B0C2-05A5022AA3A1")
interface IWsbApplicationAsync : IUnknown
{
    HRESULT QueryStatus(int* phrResult);
    HRESULT Abort();
}


// GUIDs


const GUID IID_IWsbApplicationAsync          = GUIDOF!IWsbApplicationAsync;
const GUID IID_IWsbApplicationBackupSupport  = GUIDOF!IWsbApplicationBackupSupport;
const GUID IID_IWsbApplicationRestoreSupport = GUIDOF!IWsbApplicationRestoreSupport;
