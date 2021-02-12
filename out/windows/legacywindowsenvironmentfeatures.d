module windows.legacywindowsenvironmentfeatures;

public import windows.com;
public import windows.structuredstorage;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

const GUID IID_IEmptyVolumeCacheCallBack = {0x6E793361, 0x73C6, 0x11D0, [0x84, 0x69, 0x00, 0xAA, 0x00, 0x44, 0x29, 0x01]};
@GUID(0x6E793361, 0x73C6, 0x11D0, [0x84, 0x69, 0x00, 0xAA, 0x00, 0x44, 0x29, 0x01]);
interface IEmptyVolumeCacheCallBack : IUnknown
{
    HRESULT ScanProgress(ulong dwlSpaceUsed, uint dwFlags, const(wchar)* pcwszStatus);
    HRESULT PurgeProgress(ulong dwlSpaceFreed, ulong dwlSpaceToFree, uint dwFlags, const(wchar)* pcwszStatus);
}

const GUID IID_IEmptyVolumeCache = {0x8FCE5227, 0x04DA, 0x11D1, [0xA0, 0x04, 0x00, 0x80, 0x5F, 0x8A, 0xBE, 0x06]};
@GUID(0x8FCE5227, 0x04DA, 0x11D1, [0xA0, 0x04, 0x00, 0x80, 0x5F, 0x8A, 0xBE, 0x06]);
interface IEmptyVolumeCache : IUnknown
{
    HRESULT Initialize(HKEY hkRegKey, const(wchar)* pcwszVolume, ushort** ppwszDisplayName, ushort** ppwszDescription, uint* pdwFlags);
    HRESULT GetSpaceUsed(ulong* pdwlSpaceUsed, IEmptyVolumeCacheCallBack picb);
    HRESULT Purge(ulong dwlSpaceToFree, IEmptyVolumeCacheCallBack picb);
    HRESULT ShowProperties(HWND hwnd);
    HRESULT Deactivate(uint* pdwFlags);
}

const GUID IID_IEmptyVolumeCache2 = {0x02B7E3BA, 0x4DB3, 0x11D2, [0xB2, 0xD9, 0x00, 0xC0, 0x4F, 0x8E, 0xEC, 0x8C]};
@GUID(0x02B7E3BA, 0x4DB3, 0x11D2, [0xB2, 0xD9, 0x00, 0xC0, 0x4F, 0x8E, 0xEC, 0x8C]);
interface IEmptyVolumeCache2 : IEmptyVolumeCache
{
    HRESULT InitializeEx(HKEY hkRegKey, const(wchar)* pcwszVolume, const(wchar)* pcwszKeyName, ushort** ppwszDisplayName, ushort** ppwszDescription, ushort** ppwszBtnText, uint* pdwFlags);
}

const GUID IID_IReconcileInitiator = {0x99180161, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x99180161, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface IReconcileInitiator : IUnknown
{
    HRESULT SetAbortCallback(IUnknown punkForAbort);
    HRESULT SetProgressFeedback(uint ulProgress, uint ulProgressMax);
}

enum _reconcilef
{
    RECONCILEF_MAYBOTHERUSER = 1,
    RECONCILEF_FEEDBACKWINDOWVALID = 2,
    RECONCILEF_NORESIDUESOK = 4,
    RECONCILEF_OMITSELFRESIDUE = 8,
    RECONCILEF_RESUMERECONCILIATION = 16,
    RECONCILEF_YOUMAYDOTHEUPDATES = 32,
    RECONCILEF_ONLYYOUWERECHANGED = 64,
    ALL_RECONCILE_FLAGS = 127,
}

const GUID IID_IReconcilableObject = {0x99180162, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x99180162, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface IReconcilableObject : IUnknown
{
    HRESULT Reconcile(IReconcileInitiator pInitiator, uint dwFlags, HWND hwndOwner, HWND hwndProgressFeedback, uint ulcInput, char* rgpmkOtherInput, int* plOutIndex, IStorage pstgNewResidues, void* pvReserved);
    HRESULT GetProgressFeedbackMaxEstimate(uint* pulProgressMax);
}

const GUID IID_IBriefcaseInitiator = {0x99180164, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x99180164, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface IBriefcaseInitiator : IUnknown
{
    HRESULT IsMonikerInBriefcase(IMoniker pmk);
}

const GUID IID_IActiveDesktopP = {0x52502EE0, 0xEC80, 0x11D0, [0x89, 0xAB, 0x00, 0xC0, 0x4F, 0xC2, 0x97, 0x2D]};
@GUID(0x52502EE0, 0xEC80, 0x11D0, [0x89, 0xAB, 0x00, 0xC0, 0x4F, 0xC2, 0x97, 0x2D]);
interface IActiveDesktopP : IUnknown
{
    HRESULT SetSafeMode(uint dwFlags);
    HRESULT EnsureUpdateHTML();
    HRESULT SetScheme(const(wchar)* pwszSchemeName, uint dwFlags);
    HRESULT GetScheme(const(wchar)* pwszSchemeName, uint* pdwcchBuffer, uint dwFlags);
}

const GUID IID_IADesktopP2 = {0xB22754E2, 0x4574, 0x11D1, [0x98, 0x88, 0x00, 0x60, 0x97, 0xDE, 0xAC, 0xF9]};
@GUID(0xB22754E2, 0x4574, 0x11D1, [0x98, 0x88, 0x00, 0x60, 0x97, 0xDE, 0xAC, 0xF9]);
interface IADesktopP2 : IUnknown
{
    HRESULT ReReadWallpaper();
    HRESULT GetADObjectFlags(uint* pdwFlags, uint dwMask);
    HRESULT UpdateAllDesktopSubscriptions();
    HRESULT MakeDynamicChanges(IOleObject pOleObj);
}

enum _ColumnSortOrder
{
    SortOrder_Ascending = 0,
    SortOrder_Descending = 1,
}

