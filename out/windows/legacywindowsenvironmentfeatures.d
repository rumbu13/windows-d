module windows.legacywindowsenvironmentfeatures;

public import windows.core;
public import windows.com : HRESULT, IMoniker, IOleObject, IUnknown;
public import windows.structuredstorage : IStorage;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : HKEY;

extern(Windows):


// Enums


enum : int
{
    RECONCILEF_MAYBOTHERUSER        = 0x00000001,
    RECONCILEF_FEEDBACKWINDOWVALID  = 0x00000002,
    RECONCILEF_NORESIDUESOK         = 0x00000004,
    RECONCILEF_OMITSELFRESIDUE      = 0x00000008,
    RECONCILEF_RESUMERECONCILIATION = 0x00000010,
    RECONCILEF_YOUMAYDOTHEUPDATES   = 0x00000020,
    RECONCILEF_ONLYYOUWERECHANGED   = 0x00000040,
    ALL_RECONCILE_FLAGS             = 0x0000007f,
}
alias _reconcilef = int;

enum : int
{
    SortOrder_Ascending  = 0x00000000,
    SortOrder_Descending = 0x00000001,
}
alias _ColumnSortOrder = int;

// Interfaces

@GUID("6E793361-73C6-11D0-8469-00AA00442901")
interface IEmptyVolumeCacheCallBack : IUnknown
{
    HRESULT ScanProgress(ulong dwlSpaceUsed, uint dwFlags, const(wchar)* pcwszStatus);
    HRESULT PurgeProgress(ulong dwlSpaceFreed, ulong dwlSpaceToFree, uint dwFlags, const(wchar)* pcwszStatus);
}

@GUID("8FCE5227-04DA-11D1-A004-00805F8ABE06")
interface IEmptyVolumeCache : IUnknown
{
    HRESULT Initialize(HKEY hkRegKey, const(wchar)* pcwszVolume, ushort** ppwszDisplayName, 
                       ushort** ppwszDescription, uint* pdwFlags);
    HRESULT GetSpaceUsed(ulong* pdwlSpaceUsed, IEmptyVolumeCacheCallBack picb);
    HRESULT Purge(ulong dwlSpaceToFree, IEmptyVolumeCacheCallBack picb);
    HRESULT ShowProperties(HWND hwnd);
    HRESULT Deactivate(uint* pdwFlags);
}

@GUID("02B7E3BA-4DB3-11D2-B2D9-00C04F8EEC8C")
interface IEmptyVolumeCache2 : IEmptyVolumeCache
{
    HRESULT InitializeEx(HKEY hkRegKey, const(wchar)* pcwszVolume, const(wchar)* pcwszKeyName, 
                         ushort** ppwszDisplayName, ushort** ppwszDescription, ushort** ppwszBtnText, uint* pdwFlags);
}

@GUID("99180161-DA16-101A-935C-444553540000")
interface IReconcileInitiator : IUnknown
{
    HRESULT SetAbortCallback(IUnknown punkForAbort);
    HRESULT SetProgressFeedback(uint ulProgress, uint ulProgressMax);
}

@GUID("99180162-DA16-101A-935C-444553540000")
interface IReconcilableObject : IUnknown
{
    HRESULT Reconcile(IReconcileInitiator pInitiator, uint dwFlags, HWND hwndOwner, HWND hwndProgressFeedback, 
                      uint ulcInput, char* rgpmkOtherInput, int* plOutIndex, IStorage pstgNewResidues, 
                      void* pvReserved);
    HRESULT GetProgressFeedbackMaxEstimate(uint* pulProgressMax);
}

@GUID("99180164-DA16-101A-935C-444553540000")
interface IBriefcaseInitiator : IUnknown
{
    HRESULT IsMonikerInBriefcase(IMoniker pmk);
}

@GUID("52502EE0-EC80-11D0-89AB-00C04FC2972D")
interface IActiveDesktopP : IUnknown
{
    HRESULT SetSafeMode(uint dwFlags);
    HRESULT EnsureUpdateHTML();
    HRESULT SetScheme(const(wchar)* pwszSchemeName, uint dwFlags);
    HRESULT GetScheme(const(wchar)* pwszSchemeName, uint* pdwcchBuffer, uint dwFlags);
}

@GUID("B22754E2-4574-11D1-9888-006097DEACF9")
interface IADesktopP2 : IUnknown
{
    HRESULT ReReadWallpaper();
    HRESULT GetADObjectFlags(uint* pdwFlags, uint dwMask);
    HRESULT UpdateAllDesktopSubscriptions();
    HRESULT MakeDynamicChanges(IOleObject pOleObj);
}


// GUIDs


const GUID IID_IADesktopP2               = GUIDOF!IADesktopP2;
const GUID IID_IActiveDesktopP           = GUIDOF!IActiveDesktopP;
const GUID IID_IBriefcaseInitiator       = GUIDOF!IBriefcaseInitiator;
const GUID IID_IEmptyVolumeCache         = GUIDOF!IEmptyVolumeCache;
const GUID IID_IEmptyVolumeCache2        = GUIDOF!IEmptyVolumeCache2;
const GUID IID_IEmptyVolumeCacheCallBack = GUIDOF!IEmptyVolumeCacheCallBack;
const GUID IID_IReconcilableObject       = GUIDOF!IReconcilableObject;
const GUID IID_IReconcileInitiator       = GUIDOF!IReconcileInitiator;
