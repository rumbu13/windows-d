module windows.windowsserverbackup;

public import system;
public import windows.com;

extern(Windows):

const GUID IID_IWsbApplicationBackupSupport = {0x1EFF3510, 0x4A27, 0x46AD, [0xB9, 0xE0, 0x08, 0x33, 0x2F, 0x0F, 0x4F, 0x6D]};
@GUID(0x1EFF3510, 0x4A27, 0x46AD, [0xB9, 0xE0, 0x08, 0x33, 0x2F, 0x0F, 0x4F, 0x6D]);
interface IWsbApplicationBackupSupport : IUnknown
{
    HRESULT CheckConsistency(const(wchar)* wszWriterMetadata, const(wchar)* wszComponentName, const(wchar)* wszComponentLogicalPath, uint cVolumes, char* rgwszSourceVolumePath, char* rgwszSnapshotVolumePath, IWsbApplicationAsync* ppAsync);
}

const GUID IID_IWsbApplicationRestoreSupport = {0x8D3BDB38, 0x4EE8, 0x4718, [0x85, 0xF9, 0xC7, 0xDB, 0xC4, 0xAB, 0x77, 0xAA]};
@GUID(0x8D3BDB38, 0x4EE8, 0x4718, [0x85, 0xF9, 0xC7, 0xDB, 0xC4, 0xAB, 0x77, 0xAA]);
interface IWsbApplicationRestoreSupport : IUnknown
{
    HRESULT PreRestore(const(wchar)* wszWriterMetadata, const(wchar)* wszComponentName, const(wchar)* wszComponentLogicalPath, ubyte bNoRollForward);
    HRESULT PostRestore(const(wchar)* wszWriterMetadata, const(wchar)* wszComponentName, const(wchar)* wszComponentLogicalPath, ubyte bNoRollForward);
    HRESULT OrderComponents(uint cComponents, char* rgComponentName, char* rgComponentLogicalPaths, char* prgComponentName, char* prgComponentLogicalPath);
    HRESULT IsRollForwardSupported(ubyte* pbRollForwardSupported);
}

const GUID IID_IWsbApplicationAsync = {0x0843F6F7, 0x895C, 0x44A6, [0xB0, 0xC2, 0x05, 0xA5, 0x02, 0x2A, 0xA3, 0xA1]};
@GUID(0x0843F6F7, 0x895C, 0x44A6, [0xB0, 0xC2, 0x05, 0xA5, 0x02, 0x2A, 0xA3, 0xA1]);
interface IWsbApplicationAsync : IUnknown
{
    HRESULT QueryStatus(int* phrResult);
    HRESULT Abort();
}

enum WSB_OB_STATUS_ENTRY_PAIR_TYPE
{
    WSB_OB_ET_UNDEFINED = 0,
    WSB_OB_ET_STRING = 1,
    WSB_OB_ET_NUMBER = 2,
    WSB_OB_ET_DATETIME = 3,
    WSB_OB_ET_TIME = 4,
    WSB_OB_ET_SIZE = 5,
    WSB_OB_ET_MAX = 6,
}

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
    Guid m_guidSnapinId;
    uint m_cStatusEntry;
    WSB_OB_STATUS_ENTRY* m_rgStatusEntry;
}

struct WSB_OB_REGISTRATION_INFO
{
    const(wchar)* m_wszResourceDLL;
    Guid m_guidSnapinId;
    uint m_dwProviderName;
    uint m_dwProviderIcon;
    ubyte m_bSupportsRemoting;
}

