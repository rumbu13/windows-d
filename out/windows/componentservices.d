module windows.componentservices;

public import system;
public import windows.automation;
public import windows.com;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsprogramming;

extern(Windows):

@DllImport("OLE32.dll")
HRESULT CoGetDefaultContext(APTTYPE aptType, const(Guid)* riid, void** ppv);

@DllImport("comsvcs.dll")
HRESULT CoCreateActivity(IUnknown pIUnknown, const(Guid)* riid, void** ppObj);

@DllImport("comsvcs.dll")
HRESULT CoEnterServiceDomain(IUnknown pConfigObject);

@DllImport("comsvcs.dll")
void CoLeaveServiceDomain(IUnknown pUnkStatus);

@DllImport("comsvcs.dll")
HRESULT GetManagedExtensions(uint* dwExts);

@DllImport("comsvcs.dll")
void* SafeRef(const(Guid)* rid, IUnknown pUnk);

@DllImport("comsvcs.dll")
HRESULT RecycleSurrogate(int lReasonCode);

@DllImport("comsvcs.dll")
HRESULT MTSCreateActivity(const(Guid)* riid, void** ppobj);

@DllImport("MTxDM.dll")
HRESULT GetDispenserManager(IDispenserManager* param0);

const GUID CLSID_SecurityIdentity = {0xECABB0A5, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0A5, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct SecurityIdentity;

const GUID CLSID_SecurityCallers = {0xECABB0A6, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0A6, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct SecurityCallers;

const GUID CLSID_SecurityCallContext = {0xECABB0A7, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0A7, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct SecurityCallContext;

const GUID CLSID_GetSecurityCallContextAppObject = {0xECABB0A8, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0A8, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct GetSecurityCallContextAppObject;

const GUID CLSID_Dummy30040732 = {0xECABB0A9, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0A9, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct Dummy30040732;

const GUID CLSID_TransactionContext = {0x7999FC25, 0xD3C6, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]};
@GUID(0x7999FC25, 0xD3C6, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]);
struct TransactionContext;

const GUID CLSID_TransactionContextEx = {0x5CB66670, 0xD3D4, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]};
@GUID(0x5CB66670, 0xD3D4, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]);
struct TransactionContextEx;

const GUID CLSID_ByotServerEx = {0xECABB0AA, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0AA, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct ByotServerEx;

const GUID CLSID_CServiceConfig = {0xECABB0C8, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0C8, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct CServiceConfig;

const GUID CLSID_ServicePool = {0xECABB0C9, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0C9, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct ServicePool;

const GUID CLSID_ServicePoolConfig = {0xECABB0CA, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0CA, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct ServicePoolConfig;

const GUID CLSID_SharedProperty = {0x2A005C05, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]};
@GUID(0x2A005C05, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]);
struct SharedProperty;

const GUID CLSID_SharedPropertyGroup = {0x2A005C0B, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]};
@GUID(0x2A005C0B, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]);
struct SharedPropertyGroup;

const GUID CLSID_SharedPropertyGroupManager = {0x2A005C11, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]};
@GUID(0x2A005C11, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]);
struct SharedPropertyGroupManager;

const GUID CLSID_COMEvents = {0xECABB0AB, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0AB, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct COMEvents;

const GUID CLSID_CoMTSLocator = {0xECABB0AC, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0AC, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct CoMTSLocator;

const GUID CLSID_MtsGrp = {0x4B2E958D, 0x0393, 0x11D1, [0xB1, 0xAB, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0x4B2E958D, 0x0393, 0x11D1, [0xB1, 0xAB, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
struct MtsGrp;

const GUID CLSID_ComServiceEvents = {0xECABB0C3, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0C3, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct ComServiceEvents;

const GUID CLSID_ComSystemAppEventData = {0xECABB0C6, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0C6, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct ComSystemAppEventData;

const GUID CLSID_CRMClerk = {0xECABB0BD, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0BD, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct CRMClerk;

const GUID CLSID_CRMRecoveryClerk = {0xECABB0BE, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0BE, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct CRMRecoveryClerk;

const GUID CLSID_LBEvents = {0xECABB0C1, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0C1, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct LBEvents;

const GUID CLSID_MessageMover = {0xECABB0BF, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0BF, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct MessageMover;

const GUID CLSID_DispenserManager = {0xECABB0C0, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABB0C0, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct DispenserManager;

const GUID CLSID_PoolMgr = {0xECABAFB5, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABAFB5, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct PoolMgr;

const GUID CLSID_EventServer = {0xECABAFBC, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABAFBC, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct EventServer;

const GUID CLSID_TrackerServer = {0xECABAFB9, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xECABAFB9, 0x7F19, 0x11D2, [0x97, 0x8E, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
struct TrackerServer;

const GUID CLSID_AppDomainHelper = {0xEF24F689, 0x14F8, 0x4D92, [0xB4, 0xAF, 0xD7, 0xB1, 0xF0, 0xE7, 0x0F, 0xD4]};
@GUID(0xEF24F689, 0x14F8, 0x4D92, [0xB4, 0xAF, 0xD7, 0xB1, 0xF0, 0xE7, 0x0F, 0xD4]);
struct AppDomainHelper;

const GUID CLSID_ClrAssemblyLocator = {0x458AA3B5, 0x265A, 0x4B75, [0xBC, 0x05, 0x9B, 0xEA, 0x46, 0x30, 0xCF, 0x18]};
@GUID(0x458AA3B5, 0x265A, 0x4B75, [0xBC, 0x05, 0x9B, 0xEA, 0x46, 0x30, 0xCF, 0x18]);
struct ClrAssemblyLocator;

const GUID CLSID_COMAdminCatalog = {0xF618C514, 0xDFB8, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]};
@GUID(0xF618C514, 0xDFB8, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]);
struct COMAdminCatalog;

const GUID CLSID_COMAdminCatalogObject = {0xF618C515, 0xDFB8, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]};
@GUID(0xF618C515, 0xDFB8, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]);
struct COMAdminCatalogObject;

const GUID CLSID_COMAdminCatalogCollection = {0xF618C516, 0xDFB8, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]};
@GUID(0xF618C516, 0xDFB8, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]);
struct COMAdminCatalogCollection;

const GUID IID_ICOMAdminCatalog = {0xDD662187, 0xDFC2, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]};
@GUID(0xDD662187, 0xDFC2, 0x11D1, [0xA2, 0xCF, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x35]);
interface ICOMAdminCatalog : IDispatch
{
    HRESULT GetCollection(BSTR bstrCollName, IDispatch* ppCatalogCollection);
    HRESULT Connect(BSTR bstrCatalogServerName, IDispatch* ppCatalogCollection);
    HRESULT get_MajorVersion(int* plMajorVersion);
    HRESULT get_MinorVersion(int* plMinorVersion);
    HRESULT GetCollectionByQuery(BSTR bstrCollName, SAFEARRAY** ppsaVarQuery, IDispatch* ppCatalogCollection);
    HRESULT ImportComponent(BSTR bstrApplIDOrName, BSTR bstrCLSIDOrProgID);
    HRESULT InstallComponent(BSTR bstrApplIDOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    HRESULT ShutdownApplication(BSTR bstrApplIDOrName);
    HRESULT ExportApplication(BSTR bstrApplIDOrName, BSTR bstrApplicationFile, int lOptions);
    HRESULT InstallApplication(BSTR bstrApplicationFile, BSTR bstrDestinationDirectory, int lOptions, BSTR bstrUserId, BSTR bstrPassword, BSTR bstrRSN);
    HRESULT StopRouter();
    HRESULT RefreshRouter();
    HRESULT StartRouter();
    HRESULT Reserved1();
    HRESULT Reserved2();
    HRESULT InstallMultipleComponents(BSTR bstrApplIDOrName, SAFEARRAY** ppsaVarFileNames, SAFEARRAY** ppsaVarCLSIDs);
    HRESULT GetMultipleComponentsInfo(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarClassNames, SAFEARRAY** ppsaVarFileFlags, SAFEARRAY** ppsaVarComponentFlags);
    HRESULT RefreshComponents();
    HRESULT BackupREGDB(BSTR bstrBackupFilePath);
    HRESULT RestoreREGDB(BSTR bstrBackupFilePath);
    HRESULT QueryApplicationFile(BSTR bstrApplicationFile, BSTR* pbstrApplicationName, BSTR* pbstrApplicationDescription, short* pbHasUsers, short* pbIsProxy, SAFEARRAY** ppsaVarFileNames);
    HRESULT StartApplication(BSTR bstrApplIdOrName);
    HRESULT ServiceCheck(int lService, int* plStatus);
    HRESULT InstallMultipleEventClasses(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, SAFEARRAY** ppsaVarCLSIDS);
    HRESULT InstallEventClass(BSTR bstrApplIdOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    HRESULT GetEventClassesForIID(BSTR bstrIID, SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarProgIDs, SAFEARRAY** ppsaVarDescriptions);
}

enum COMAdminInUse
{
    COMAdminNotInUse = 0,
    COMAdminInUseByCatalog = 1,
    COMAdminInUseByRegistryUnknown = 2,
    COMAdminInUseByRegistryProxyStub = 3,
    COMAdminInUseByRegistryTypeLib = 4,
    COMAdminInUseByRegistryClsid = 5,
}

const GUID IID_ICOMAdminCatalog2 = {0x790C6E0B, 0x9194, 0x4CC9, [0x94, 0x26, 0xA4, 0x8A, 0x63, 0x18, 0x56, 0x96]};
@GUID(0x790C6E0B, 0x9194, 0x4CC9, [0x94, 0x26, 0xA4, 0x8A, 0x63, 0x18, 0x56, 0x96]);
interface ICOMAdminCatalog2 : ICOMAdminCatalog
{
    HRESULT GetCollectionByQuery2(BSTR bstrCollectionName, VARIANT* pVarQueryStrings, IDispatch* ppCatalogCollection);
    HRESULT GetApplicationInstanceIDFromProcessID(int lProcessID, BSTR* pbstrApplicationInstanceID);
    HRESULT ShutdownApplicationInstances(VARIANT* pVarApplicationInstanceID);
    HRESULT PauseApplicationInstances(VARIANT* pVarApplicationInstanceID);
    HRESULT ResumeApplicationInstances(VARIANT* pVarApplicationInstanceID);
    HRESULT RecycleApplicationInstances(VARIANT* pVarApplicationInstanceID, int lReasonCode);
    HRESULT AreApplicationInstancesPaused(VARIANT* pVarApplicationInstanceID, short* pVarBoolPaused);
    HRESULT DumpApplicationInstance(BSTR bstrApplicationInstanceID, BSTR bstrDirectory, int lMaxImages, BSTR* pbstrDumpFile);
    HRESULT get_IsApplicationInstanceDumpSupported(short* pVarBoolDumpSupported);
    HRESULT CreateServiceForApplication(BSTR bstrApplicationIDOrName, BSTR bstrServiceName, BSTR bstrStartType, BSTR bstrErrorControl, BSTR bstrDependencies, BSTR bstrRunAs, BSTR bstrPassword, short bDesktopOk);
    HRESULT DeleteServiceForApplication(BSTR bstrApplicationIDOrName);
    HRESULT GetPartitionID(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionID);
    HRESULT GetPartitionName(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionName);
    HRESULT put_CurrentPartition(BSTR bstrPartitionIDOrName);
    HRESULT get_CurrentPartitionID(BSTR* pbstrPartitionID);
    HRESULT get_CurrentPartitionName(BSTR* pbstrPartitionName);
    HRESULT get_GlobalPartitionID(BSTR* pbstrGlobalPartitionID);
    HRESULT FlushPartitionCache();
    HRESULT CopyApplications(BSTR bstrSourcePartitionIDOrName, VARIANT* pVarApplicationID, BSTR bstrDestinationPartitionIDOrName);
    HRESULT CopyComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, BSTR bstrDestinationApplicationIDOrName);
    HRESULT MoveComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, BSTR bstrDestinationApplicationIDOrName);
    HRESULT AliasComponent(BSTR bstrSrcApplicationIDOrName, BSTR bstrCLSIDOrProgID, BSTR bstrDestApplicationIDOrName, BSTR bstrNewProgId, BSTR bstrNewClsid);
    HRESULT IsSafeToDelete(BSTR bstrDllName, COMAdminInUse* pCOMAdminInUse);
    HRESULT ImportUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, VARIANT* pVarComponentType);
    HRESULT PromoteUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, VARIANT* pVarComponentType);
    HRESULT ImportComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, VARIANT* pVarComponentType);
    HRESULT get_Is64BitCatalogServer(short* pbIs64Bit);
    HRESULT ExportPartition(BSTR bstrPartitionIDOrName, BSTR bstrPartitionFileName, int lOptions);
    HRESULT InstallPartition(BSTR bstrFileName, BSTR bstrDestDirectory, int lOptions, BSTR bstrUserID, BSTR bstrPassword, BSTR bstrRSN);
    HRESULT QueryApplicationFile2(BSTR bstrApplicationFile, IDispatch* ppFilesForImport);
    HRESULT GetComponentVersionCount(BSTR bstrCLSIDOrProgID, int* plVersionCount);
}

const GUID IID_ICatalogObject = {0x6EB22871, 0x8A19, 0x11D0, [0x81, 0xB6, 0x00, 0xA0, 0xC9, 0x23, 0x1C, 0x29]};
@GUID(0x6EB22871, 0x8A19, 0x11D0, [0x81, 0xB6, 0x00, 0xA0, 0xC9, 0x23, 0x1C, 0x29]);
interface ICatalogObject : IDispatch
{
    HRESULT get_Value(BSTR bstrPropName, VARIANT* pvarRetVal);
    HRESULT put_Value(BSTR bstrPropName, VARIANT val);
    HRESULT get_Key(VARIANT* pvarRetVal);
    HRESULT get_Name(VARIANT* pvarRetVal);
    HRESULT IsPropertyReadOnly(BSTR bstrPropName, short* pbRetVal);
    HRESULT get_Valid(short* pbRetVal);
    HRESULT IsPropertyWriteOnly(BSTR bstrPropName, short* pbRetVal);
}

const GUID IID_ICatalogCollection = {0x6EB22872, 0x8A19, 0x11D0, [0x81, 0xB6, 0x00, 0xA0, 0xC9, 0x23, 0x1C, 0x29]};
@GUID(0x6EB22872, 0x8A19, 0x11D0, [0x81, 0xB6, 0x00, 0xA0, 0xC9, 0x23, 0x1C, 0x29]);
interface ICatalogCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppEnumVariant);
    HRESULT get_Item(int lIndex, IDispatch* ppCatalogObject);
    HRESULT get_Count(int* plObjectCount);
    HRESULT Remove(int lIndex);
    HRESULT Add(IDispatch* ppCatalogObject);
    HRESULT Populate();
    HRESULT SaveChanges(int* pcChanges);
    HRESULT GetCollection(BSTR bstrCollName, VARIANT varObjectKey, IDispatch* ppCatalogCollection);
    HRESULT get_Name(VARIANT* pVarNamel);
    HRESULT get_AddEnabled(short* pVarBool);
    HRESULT get_RemoveEnabled(short* pVarBool);
    HRESULT GetUtilInterface(IDispatch* ppIDispatch);
    HRESULT get_DataStoreMajorVersion(int* plMajorVersion);
    HRESULT get_DataStoreMinorVersion(int* plMinorVersionl);
    HRESULT PopulateByKey(SAFEARRAY* psaKeys);
    HRESULT PopulateByQuery(BSTR bstrQueryString, int lQueryType);
}

enum COMAdminComponentType
{
    COMAdmin32BitComponent = 1,
    COMAdmin64BitComponent = 2,
}

enum COMAdminApplicationInstallOptions
{
    COMAdminInstallNoUsers = 0,
    COMAdminInstallUsers = 1,
    COMAdminInstallForceOverwriteOfFiles = 2,
}

enum COMAdminApplicationExportOptions
{
    COMAdminExportNoUsers = 0,
    COMAdminExportUsers = 1,
    COMAdminExportApplicationProxy = 2,
    COMAdminExportForceOverwriteOfFiles = 4,
    COMAdminExportIn10Format = 16,
}

enum COMAdminThreadingModels
{
    COMAdminThreadingModelApartment = 0,
    COMAdminThreadingModelFree = 1,
    COMAdminThreadingModelMain = 2,
    COMAdminThreadingModelBoth = 3,
    COMAdminThreadingModelNeutral = 4,
    COMAdminThreadingModelNotSpecified = 5,
}

enum COMAdminTransactionOptions
{
    COMAdminTransactionIgnored = 0,
    COMAdminTransactionNone = 1,
    COMAdminTransactionSupported = 2,
    COMAdminTransactionRequired = 3,
    COMAdminTransactionRequiresNew = 4,
}

enum COMAdminTxIsolationLevelOptions
{
    COMAdminTxIsolationLevelAny = 0,
    COMAdminTxIsolationLevelReadUnCommitted = 1,
    COMAdminTxIsolationLevelReadCommitted = 2,
    COMAdminTxIsolationLevelRepeatableRead = 3,
    COMAdminTxIsolationLevelSerializable = 4,
}

enum COMAdminSynchronizationOptions
{
    COMAdminSynchronizationIgnored = 0,
    COMAdminSynchronizationNone = 1,
    COMAdminSynchronizationSupported = 2,
    COMAdminSynchronizationRequired = 3,
    COMAdminSynchronizationRequiresNew = 4,
}

enum COMAdminActivationOptions
{
    COMAdminActivationInproc = 0,
    COMAdminActivationLocal = 1,
}

enum COMAdminAccessChecksLevelOptions
{
    COMAdminAccessChecksApplicationLevel = 0,
    COMAdminAccessChecksApplicationComponentLevel = 1,
}

enum COMAdminAuthenticationLevelOptions
{
    COMAdminAuthenticationDefault = 0,
    COMAdminAuthenticationNone = 1,
    COMAdminAuthenticationConnect = 2,
    COMAdminAuthenticationCall = 3,
    COMAdminAuthenticationPacket = 4,
    COMAdminAuthenticationIntegrity = 5,
    COMAdminAuthenticationPrivacy = 6,
}

enum COMAdminImpersonationLevelOptions
{
    COMAdminImpersonationAnonymous = 1,
    COMAdminImpersonationIdentify = 2,
    COMAdminImpersonationImpersonate = 3,
    COMAdminImpersonationDelegate = 4,
}

enum COMAdminAuthenticationCapabilitiesOptions
{
    COMAdminAuthenticationCapabilitiesNone = 0,
    COMAdminAuthenticationCapabilitiesSecureReference = 2,
    COMAdminAuthenticationCapabilitiesStaticCloaking = 32,
    COMAdminAuthenticationCapabilitiesDynamicCloaking = 64,
}

enum COMAdminOS
{
    COMAdminOSNotInitialized = 0,
    COMAdminOSWindows3_1 = 1,
    COMAdminOSWindows9x = 2,
    COMAdminOSWindows2000 = 3,
    COMAdminOSWindows2000AdvancedServer = 4,
    COMAdminOSWindows2000Unknown = 5,
    COMAdminOSUnknown = 6,
    COMAdminOSWindowsXPPersonal = 11,
    COMAdminOSWindowsXPProfessional = 12,
    COMAdminOSWindowsNETStandardServer = 13,
    COMAdminOSWindowsNETEnterpriseServer = 14,
    COMAdminOSWindowsNETDatacenterServer = 15,
    COMAdminOSWindowsNETWebServer = 16,
    COMAdminOSWindowsLonghornPersonal = 17,
    COMAdminOSWindowsLonghornProfessional = 18,
    COMAdminOSWindowsLonghornStandardServer = 19,
    COMAdminOSWindowsLonghornEnterpriseServer = 20,
    COMAdminOSWindowsLonghornDatacenterServer = 21,
    COMAdminOSWindowsLonghornWebServer = 22,
    COMAdminOSWindows7Personal = 23,
    COMAdminOSWindows7Professional = 24,
    COMAdminOSWindows7StandardServer = 25,
    COMAdminOSWindows7EnterpriseServer = 26,
    COMAdminOSWindows7DatacenterServer = 27,
    COMAdminOSWindows7WebServer = 28,
    COMAdminOSWindows8Personal = 29,
    COMAdminOSWindows8Professional = 30,
    COMAdminOSWindows8StandardServer = 31,
    COMAdminOSWindows8EnterpriseServer = 32,
    COMAdminOSWindows8DatacenterServer = 33,
    COMAdminOSWindows8WebServer = 34,
    COMAdminOSWindowsBluePersonal = 35,
    COMAdminOSWindowsBlueProfessional = 36,
    COMAdminOSWindowsBlueStandardServer = 37,
    COMAdminOSWindowsBlueEnterpriseServer = 38,
    COMAdminOSWindowsBlueDatacenterServer = 39,
    COMAdminOSWindowsBlueWebServer = 40,
}

enum COMAdminServiceOptions
{
    COMAdminServiceLoadBalanceRouter = 1,
}

enum COMAdminServiceStatusOptions
{
    COMAdminServiceStopped = 0,
    COMAdminServiceStartPending = 1,
    COMAdminServiceStopPending = 2,
    COMAdminServiceRunning = 3,
    COMAdminServiceContinuePending = 4,
    COMAdminServicePausePending = 5,
    COMAdminServicePaused = 6,
    COMAdminServiceUnknownState = 7,
}

enum COMAdminQCMessageAuthenticateOptions
{
    COMAdminQCMessageAuthenticateSecureApps = 0,
    COMAdminQCMessageAuthenticateOff = 1,
    COMAdminQCMessageAuthenticateOn = 2,
}

enum COMAdminFileFlags
{
    COMAdminFileFlagLoadable = 1,
    COMAdminFileFlagCOM = 2,
    COMAdminFileFlagContainsPS = 4,
    COMAdminFileFlagContainsComp = 8,
    COMAdminFileFlagContainsTLB = 16,
    COMAdminFileFlagSelfReg = 32,
    COMAdminFileFlagSelfUnReg = 64,
    COMAdminFileFlagUnloadableDLL = 128,
    COMAdminFileFlagDoesNotExist = 256,
    COMAdminFileFlagAlreadyInstalled = 512,
    COMAdminFileFlagBadTLB = 1024,
    COMAdminFileFlagGetClassObjFailed = 2048,
    COMAdminFileFlagClassNotAvailable = 4096,
    COMAdminFileFlagRegistrar = 8192,
    COMAdminFileFlagNoRegistrar = 16384,
    COMAdminFileFlagDLLRegsvrFailed = 32768,
    COMAdminFileFlagRegTLBFailed = 65536,
    COMAdminFileFlagRegistrarFailed = 131072,
    COMAdminFileFlagError = 262144,
}

enum COMAdminComponentFlags
{
    COMAdminCompFlagTypeInfoFound = 1,
    COMAdminCompFlagCOMPlusPropertiesFound = 2,
    COMAdminCompFlagProxyFound = 4,
    COMAdminCompFlagInterfacesFound = 8,
    COMAdminCompFlagAlreadyInstalled = 16,
    COMAdminCompFlagNotInApplication = 32,
}

enum COMAdminErrorCodes
{
    COMAdminErrObjectErrors = -2146368511,
    COMAdminErrObjectInvalid = -2146368510,
    COMAdminErrKeyMissing = -2146368509,
    COMAdminErrAlreadyInstalled = -2146368508,
    COMAdminErrAppFileWriteFail = -2146368505,
    COMAdminErrAppFileReadFail = -2146368504,
    COMAdminErrAppFileVersion = -2146368503,
    COMAdminErrBadPath = -2146368502,
    COMAdminErrApplicationExists = -2146368501,
    COMAdminErrRoleExists = -2146368500,
    COMAdminErrCantCopyFile = -2146368499,
    COMAdminErrNoUser = -2146368497,
    COMAdminErrInvalidUserids = -2146368496,
    COMAdminErrNoRegistryCLSID = -2146368495,
    COMAdminErrBadRegistryProgID = -2146368494,
    COMAdminErrAuthenticationLevel = -2146368493,
    COMAdminErrUserPasswdNotValid = -2146368492,
    COMAdminErrCLSIDOrIIDMismatch = -2146368488,
    COMAdminErrRemoteInterface = -2146368487,
    COMAdminErrDllRegisterServer = -2146368486,
    COMAdminErrNoServerShare = -2146368485,
    COMAdminErrDllLoadFailed = -2146368483,
    COMAdminErrBadRegistryLibID = -2146368482,
    COMAdminErrAppDirNotFound = -2146368481,
    COMAdminErrRegistrarFailed = -2146368477,
    COMAdminErrCompFileDoesNotExist = -2146368476,
    COMAdminErrCompFileLoadDLLFail = -2146368475,
    COMAdminErrCompFileGetClassObj = -2146368474,
    COMAdminErrCompFileClassNotAvail = -2146368473,
    COMAdminErrCompFileBadTLB = -2146368472,
    COMAdminErrCompFileNotInstallable = -2146368471,
    COMAdminErrNotChangeable = -2146368470,
    COMAdminErrNotDeletable = -2146368469,
    COMAdminErrSession = -2146368468,
    COMAdminErrCompMoveLocked = -2146368467,
    COMAdminErrCompMoveBadDest = -2146368466,
    COMAdminErrRegisterTLB = -2146368464,
    COMAdminErrSystemApp = -2146368461,
    COMAdminErrCompFileNoRegistrar = -2146368460,
    COMAdminErrCoReqCompInstalled = -2146368459,
    COMAdminErrServiceNotInstalled = -2146368458,
    COMAdminErrPropertySaveFailed = -2146368457,
    COMAdminErrObjectExists = -2146368456,
    COMAdminErrComponentExists = -2146368455,
    COMAdminErrRegFileCorrupt = -2146368453,
    COMAdminErrPropertyOverflow = -2146368452,
    COMAdminErrNotInRegistry = -2146368450,
    COMAdminErrObjectNotPoolable = -2146368449,
    COMAdminErrApplidMatchesClsid = -2146368442,
    COMAdminErrRoleDoesNotExist = -2146368441,
    COMAdminErrStartAppNeedsComponents = -2146368440,
    COMAdminErrRequiresDifferentPlatform = -2146368439,
    COMAdminErrQueuingServiceNotAvailable = -2146367998,
    COMAdminErrObjectParentMissing = -2146367480,
    COMAdminErrObjectDoesNotExist = -2146367479,
    COMAdminErrCanNotExportAppProxy = -2146368438,
    COMAdminErrCanNotStartApp = -2146368437,
    COMAdminErrCanNotExportSystemApp = -2146368436,
    COMAdminErrCanNotSubscribeToComponent = -2146368435,
    COMAdminErrAppNotRunning = -2146367478,
    COMAdminErrEventClassCannotBeSubscriber = -2146368434,
    COMAdminErrLibAppProxyIncompatible = -2146368433,
    COMAdminErrBasePartitionOnly = -2146368432,
    COMAdminErrDuplicatePartitionName = -2146368425,
    COMAdminErrPartitionInUse = -2146368423,
    COMAdminErrImportedComponentsNotAllowed = -2146368421,
    COMAdminErrRegdbNotInitialized = -2146368398,
    COMAdminErrRegdbNotOpen = -2146368397,
    COMAdminErrRegdbSystemErr = -2146368396,
    COMAdminErrRegdbAlreadyRunning = -2146368395,
    COMAdminErrMigVersionNotSupported = -2146368384,
    COMAdminErrMigSchemaNotFound = -2146368383,
    COMAdminErrCatBitnessMismatch = -2146368382,
    COMAdminErrCatUnacceptableBitness = -2146368381,
    COMAdminErrCatWrongAppBitnessBitness = -2146368380,
    COMAdminErrCatPauseResumeNotSupported = -2146368379,
    COMAdminErrCatServerFault = -2146368378,
    COMAdminErrCantRecycleLibraryApps = -2146367473,
    COMAdminErrCantRecycleServiceApps = -2146367471,
    COMAdminErrProcessAlreadyRecycled = -2146367470,
    COMAdminErrPausedProcessMayNotBeRecycled = -2146367469,
    COMAdminErrInvalidPartition = -2146367477,
    COMAdminErrPartitionMsiOnly = -2146367463,
    COMAdminErrStartAppDisabled = -2146368431,
    COMAdminErrCompMoveSource = -2146367460,
    COMAdminErrCompMoveDest = -2146367459,
    COMAdminErrCompMovePrivate = -2146367458,
    COMAdminErrCannotCopyEventClass = -2146367456,
}

struct BOID
{
    ubyte rgb;
}

enum TX_MISC_CONSTANTS
{
    MAX_TRAN_DESC = 40,
}

enum ISOLATIONLEVEL
{
    ISOLATIONLEVEL_UNSPECIFIED = -1,
    ISOLATIONLEVEL_CHAOS = 16,
    ISOLATIONLEVEL_READUNCOMMITTED = 256,
    ISOLATIONLEVEL_BROWSE = 256,
    ISOLATIONLEVEL_CURSORSTABILITY = 4096,
    ISOLATIONLEVEL_READCOMMITTED = 4096,
    ISOLATIONLEVEL_REPEATABLEREAD = 65536,
    ISOLATIONLEVEL_SERIALIZABLE = 1048576,
    ISOLATIONLEVEL_ISOLATED = 1048576,
}

struct XACTTRANSINFO
{
    BOID uow;
    int isoLevel;
    uint isoFlags;
    uint grfTCSupported;
    uint grfRMSupported;
    uint grfTCSupportedRetaining;
    uint grfRMSupportedRetaining;
}

struct XACTSTATS
{
    uint cOpen;
    uint cCommitting;
    uint cCommitted;
    uint cAborting;
    uint cAborted;
    uint cInDoubt;
    uint cHeuristicDecision;
    FILETIME timeTransactionsUp;
}

enum ISOFLAG
{
    ISOFLAG_RETAIN_COMMIT_DC = 1,
    ISOFLAG_RETAIN_COMMIT = 2,
    ISOFLAG_RETAIN_COMMIT_NO = 3,
    ISOFLAG_RETAIN_ABORT_DC = 4,
    ISOFLAG_RETAIN_ABORT = 8,
    ISOFLAG_RETAIN_ABORT_NO = 12,
    ISOFLAG_RETAIN_DONTCARE = 5,
    ISOFLAG_RETAIN_BOTH = 10,
    ISOFLAG_RETAIN_NONE = 15,
    ISOFLAG_OPTIMISTIC = 16,
    ISOFLAG_READONLY = 32,
}

enum XACTTC
{
    XACTTC_NONE = 0,
    XACTTC_SYNC_PHASEONE = 1,
    XACTTC_SYNC_PHASETWO = 2,
    XACTTC_SYNC = 2,
    XACTTC_ASYNC_PHASEONE = 4,
    XACTTC_ASYNC = 4,
}

enum XACTRM
{
    XACTRM_OPTIMISTICLASTWINS = 1,
    XACTRM_NOREADONLYPREPARES = 2,
}

enum XACTCONST
{
    XACTCONST_TIMEOUTINFINITE = 0,
}

enum XACTHEURISTIC
{
    XACTHEURISTIC_ABORT = 1,
    XACTHEURISTIC_COMMIT = 2,
    XACTHEURISTIC_DAMAGE = 3,
    XACTHEURISTIC_DANGER = 4,
}

enum XACTSTAT
{
    XACTSTAT_NONE = 0,
    XACTSTAT_OPENNORMAL = 1,
    XACTSTAT_OPENREFUSED = 2,
    XACTSTAT_PREPARING = 4,
    XACTSTAT_PREPARED = 8,
    XACTSTAT_PREPARERETAINING = 16,
    XACTSTAT_PREPARERETAINED = 32,
    XACTSTAT_COMMITTING = 64,
    XACTSTAT_COMMITRETAINING = 128,
    XACTSTAT_ABORTING = 256,
    XACTSTAT_ABORTED = 512,
    XACTSTAT_COMMITTED = 1024,
    XACTSTAT_HEURISTIC_ABORT = 2048,
    XACTSTAT_HEURISTIC_COMMIT = 4096,
    XACTSTAT_HEURISTIC_DAMAGE = 8192,
    XACTSTAT_HEURISTIC_DANGER = 16384,
    XACTSTAT_FORCED_ABORT = 32768,
    XACTSTAT_FORCED_COMMIT = 65536,
    XACTSTAT_INDOUBT = 131072,
    XACTSTAT_CLOSED = 262144,
    XACTSTAT_OPEN = 3,
    XACTSTAT_NOTPREPARED = 524227,
    XACTSTAT_ALL = 524287,
}

struct XACTOPT
{
    uint ulTimeout;
    byte szDescription;
}

const GUID IID_ITransaction = {0x0FB15084, 0xAF41, 0x11CE, [0xBD, 0x2B, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]};
@GUID(0x0FB15084, 0xAF41, 0x11CE, [0xBD, 0x2B, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]);
interface ITransaction : IUnknown
{
    HRESULT Commit(BOOL fRetaining, uint grfTC, uint grfRM);
    HRESULT Abort(BOID* pboidReason, BOOL fRetaining, BOOL fAsync);
    HRESULT GetTransactionInfo(XACTTRANSINFO* pinfo);
}

const GUID IID_ITransactionCloner = {0x02656950, 0x2152, 0x11D0, [0x94, 0x4C, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x02656950, 0x2152, 0x11D0, [0x94, 0x4C, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface ITransactionCloner : ITransaction
{
    HRESULT CloneWithCommitDisabled(ITransaction* ppITransaction);
}

const GUID IID_ITransaction2 = {0x34021548, 0x0065, 0x11D3, [0xBA, 0xC1, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xE2]};
@GUID(0x34021548, 0x0065, 0x11D3, [0xBA, 0xC1, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xE2]);
interface ITransaction2 : ITransactionCloner
{
    HRESULT GetTransactionInfo2(XACTTRANSINFO* pinfo);
}

const GUID IID_ITransactionDispenser = {0x3A6AD9E1, 0x23B9, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]};
@GUID(0x3A6AD9E1, 0x23B9, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]);
interface ITransactionDispenser : IUnknown
{
    HRESULT GetOptionsObject(ITransactionOptions* ppOptions);
    HRESULT BeginTransaction(IUnknown punkOuter, int isoLevel, uint isoFlags, ITransactionOptions pOptions, ITransaction* ppTransaction);
}

const GUID IID_ITransactionOptions = {0x3A6AD9E0, 0x23B9, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]};
@GUID(0x3A6AD9E0, 0x23B9, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]);
interface ITransactionOptions : IUnknown
{
    HRESULT SetOptions(XACTOPT* pOptions);
    HRESULT GetOptions(XACTOPT* pOptions);
}

const GUID IID_ITransactionOutcomeEvents = {0x3A6AD9E2, 0x23B9, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]};
@GUID(0x3A6AD9E2, 0x23B9, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]);
interface ITransactionOutcomeEvents : IUnknown
{
    HRESULT Committed(BOOL fRetaining, BOID* pNewUOW, HRESULT hr);
    HRESULT Aborted(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW, HRESULT hr);
    HRESULT HeuristicDecision(uint dwDecision, BOID* pboidReason, HRESULT hr);
    HRESULT Indoubt();
}

const GUID IID_ITmNodeName = {0x30274F88, 0x6EE4, 0x474E, [0x9B, 0x95, 0x78, 0x07, 0xBC, 0x9E, 0xF8, 0xCF]};
@GUID(0x30274F88, 0x6EE4, 0x474E, [0x9B, 0x95, 0x78, 0x07, 0xBC, 0x9E, 0xF8, 0xCF]);
interface ITmNodeName : IUnknown
{
    HRESULT GetNodeNameSize(uint* pcbNodeNameSize);
    HRESULT GetNodeName(uint cbNodeNameBufferSize, const(wchar)* pNodeNameBuffer);
}

const GUID IID_IKernelTransaction = {0x79427A2B, 0xF895, 0x40E0, [0xBE, 0x79, 0xB5, 0x7D, 0xC8, 0x2E, 0xD2, 0x31]};
@GUID(0x79427A2B, 0xF895, 0x40E0, [0xBE, 0x79, 0xB5, 0x7D, 0xC8, 0x2E, 0xD2, 0x31]);
interface IKernelTransaction : IUnknown
{
    HRESULT GetHandle(HANDLE* pHandle);
}

const GUID IID_ITransactionResourceAsync = {0x69E971F0, 0x23CE, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]};
@GUID(0x69E971F0, 0x23CE, 0x11CF, [0xAD, 0x60, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xCD]);
interface ITransactionResourceAsync : IUnknown
{
    HRESULT PrepareRequest(BOOL fRetaining, uint grfRM, BOOL fWantMoniker, BOOL fSinglePhase);
    HRESULT CommitRequest(uint grfRM, BOID* pNewUOW);
    HRESULT AbortRequest(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW);
    HRESULT TMDown();
}

const GUID IID_ITransactionLastResourceAsync = {0xC82BD532, 0x5B30, 0x11D3, [0x8A, 0x91, 0x00, 0xC0, 0x4F, 0x79, 0xEB, 0x6D]};
@GUID(0xC82BD532, 0x5B30, 0x11D3, [0x8A, 0x91, 0x00, 0xC0, 0x4F, 0x79, 0xEB, 0x6D]);
interface ITransactionLastResourceAsync : IUnknown
{
    HRESULT DelegateCommit(uint grfRM);
    HRESULT ForgetRequest(BOID* pNewUOW);
}

const GUID IID_ITransactionResource = {0xEE5FF7B3, 0x4572, 0x11D0, [0x94, 0x52, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0xEE5FF7B3, 0x4572, 0x11D0, [0x94, 0x52, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface ITransactionResource : IUnknown
{
    HRESULT PrepareRequest(BOOL fRetaining, uint grfRM, BOOL fWantMoniker, BOOL fSinglePhase);
    HRESULT CommitRequest(uint grfRM, BOID* pNewUOW);
    HRESULT AbortRequest(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW);
    HRESULT TMDown();
}

const GUID IID_ITransactionEnlistmentAsync = {0x0FB15081, 0xAF41, 0x11CE, [0xBD, 0x2B, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]};
@GUID(0x0FB15081, 0xAF41, 0x11CE, [0xBD, 0x2B, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]);
interface ITransactionEnlistmentAsync : IUnknown
{
    HRESULT PrepareRequestDone(HRESULT hr, IMoniker pmk, BOID* pboidReason);
    HRESULT CommitRequestDone(HRESULT hr);
    HRESULT AbortRequestDone(HRESULT hr);
}

const GUID IID_ITransactionLastEnlistmentAsync = {0xC82BD533, 0x5B30, 0x11D3, [0x8A, 0x91, 0x00, 0xC0, 0x4F, 0x79, 0xEB, 0x6D]};
@GUID(0xC82BD533, 0x5B30, 0x11D3, [0x8A, 0x91, 0x00, 0xC0, 0x4F, 0x79, 0xEB, 0x6D]);
interface ITransactionLastEnlistmentAsync : IUnknown
{
    HRESULT TransactionOutcome(XACTSTAT XactStat, BOID* pboidReason);
}

const GUID IID_ITransactionExportFactory = {0xE1CF9B53, 0x8745, 0x11CE, [0xA9, 0xBA, 0x00, 0xAA, 0x00, 0x6C, 0x37, 0x06]};
@GUID(0xE1CF9B53, 0x8745, 0x11CE, [0xA9, 0xBA, 0x00, 0xAA, 0x00, 0x6C, 0x37, 0x06]);
interface ITransactionExportFactory : IUnknown
{
    HRESULT GetRemoteClassId(Guid* pclsid);
    HRESULT Create(uint cbWhereabouts, char* rgbWhereabouts, ITransactionExport* ppExport);
}

const GUID IID_ITransactionImportWhereabouts = {0x0141FDA4, 0x8FC0, 0x11CE, [0xBD, 0x18, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]};
@GUID(0x0141FDA4, 0x8FC0, 0x11CE, [0xBD, 0x18, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]);
interface ITransactionImportWhereabouts : IUnknown
{
    HRESULT GetWhereaboutsSize(uint* pcbWhereabouts);
    HRESULT GetWhereabouts(uint cbWhereabouts, ubyte* rgbWhereabouts, uint* pcbUsed);
}

const GUID IID_ITransactionExport = {0x0141FDA5, 0x8FC0, 0x11CE, [0xBD, 0x18, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]};
@GUID(0x0141FDA5, 0x8FC0, 0x11CE, [0xBD, 0x18, 0x20, 0x4C, 0x4F, 0x4F, 0x50, 0x20]);
interface ITransactionExport : IUnknown
{
    HRESULT Export(IUnknown punkTransaction, uint* pcbTransactionCookie);
    HRESULT GetTransactionCookie(IUnknown punkTransaction, uint cbTransactionCookie, ubyte* rgbTransactionCookie, uint* pcbUsed);
}

const GUID IID_ITransactionImport = {0xE1CF9B5A, 0x8745, 0x11CE, [0xA9, 0xBA, 0x00, 0xAA, 0x00, 0x6C, 0x37, 0x06]};
@GUID(0xE1CF9B5A, 0x8745, 0x11CE, [0xA9, 0xBA, 0x00, 0xAA, 0x00, 0x6C, 0x37, 0x06]);
interface ITransactionImport : IUnknown
{
    HRESULT Import(uint cbTransactionCookie, char* rgbTransactionCookie, Guid* piid, void** ppvTransaction);
}

const GUID IID_ITipTransaction = {0x17CF72D0, 0xBAC5, 0x11D1, [0xB1, 0xBF, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]};
@GUID(0x17CF72D0, 0xBAC5, 0x11D1, [0xB1, 0xBF, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]);
interface ITipTransaction : IUnknown
{
    HRESULT Push(byte* i_pszRemoteTmUrl, byte** o_ppszRemoteTxUrl);
    HRESULT GetTransactionUrl(byte** o_ppszLocalTxUrl);
}

const GUID IID_ITipHelper = {0x17CF72D1, 0xBAC5, 0x11D1, [0xB1, 0xBF, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]};
@GUID(0x17CF72D1, 0xBAC5, 0x11D1, [0xB1, 0xBF, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]);
interface ITipHelper : IUnknown
{
    HRESULT Pull(byte* i_pszTxUrl, ITransaction* o_ppITransaction);
    HRESULT PullAsync(byte* i_pszTxUrl, ITipPullSink i_pTipPullSink, ITransaction* o_ppITransaction);
    HRESULT GetLocalTmUrl(byte** o_ppszLocalTmUrl);
}

const GUID IID_ITipPullSink = {0x17CF72D2, 0xBAC5, 0x11D1, [0xB1, 0xBF, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]};
@GUID(0x17CF72D2, 0xBAC5, 0x11D1, [0xB1, 0xBF, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]);
interface ITipPullSink : IUnknown
{
    HRESULT PullComplete(HRESULT i_hrPull);
}

const GUID IID_IDtcNetworkAccessConfig = {0x9797C15D, 0xA428, 0x4291, [0x87, 0xB6, 0x09, 0x95, 0x03, 0x1A, 0x67, 0x8D]};
@GUID(0x9797C15D, 0xA428, 0x4291, [0x87, 0xB6, 0x09, 0x95, 0x03, 0x1A, 0x67, 0x8D]);
interface IDtcNetworkAccessConfig : IUnknown
{
    HRESULT GetAnyNetworkAccess(int* pbAnyNetworkAccess);
    HRESULT SetAnyNetworkAccess(BOOL bAnyNetworkAccess);
    HRESULT GetNetworkAdministrationAccess(int* pbNetworkAdministrationAccess);
    HRESULT SetNetworkAdministrationAccess(BOOL bNetworkAdministrationAccess);
    HRESULT GetNetworkTransactionAccess(int* pbNetworkTransactionAccess);
    HRESULT SetNetworkTransactionAccess(BOOL bNetworkTransactionAccess);
    HRESULT GetNetworkClientAccess(int* pbNetworkClientAccess);
    HRESULT SetNetworkClientAccess(BOOL bNetworkClientAccess);
    HRESULT GetNetworkTIPAccess(int* pbNetworkTIPAccess);
    HRESULT SetNetworkTIPAccess(BOOL bNetworkTIPAccess);
    HRESULT GetXAAccess(int* pbXAAccess);
    HRESULT SetXAAccess(BOOL bXAAccess);
    HRESULT RestartDtcService();
}

enum AUTHENTICATION_LEVEL
{
    NO_AUTHENTICATION_REQUIRED = 0,
    INCOMING_AUTHENTICATION_REQUIRED = 1,
    MUTUAL_AUTHENTICATION_REQUIRED = 2,
}

const GUID IID_IDtcNetworkAccessConfig2 = {0xA7AA013B, 0xEB7D, 0x4F42, [0xB4, 0x1C, 0xB2, 0xDE, 0xC0, 0x9A, 0xE0, 0x34]};
@GUID(0xA7AA013B, 0xEB7D, 0x4F42, [0xB4, 0x1C, 0xB2, 0xDE, 0xC0, 0x9A, 0xE0, 0x34]);
interface IDtcNetworkAccessConfig2 : IDtcNetworkAccessConfig
{
    HRESULT GetNetworkInboundAccess(int* pbInbound);
    HRESULT GetNetworkOutboundAccess(int* pbOutbound);
    HRESULT SetNetworkInboundAccess(BOOL bInbound);
    HRESULT SetNetworkOutboundAccess(BOOL bOutbound);
    HRESULT GetAuthenticationLevel(AUTHENTICATION_LEVEL* pAuthLevel);
    HRESULT SetAuthenticationLevel(AUTHENTICATION_LEVEL AuthLevel);
}

const GUID IID_IDtcNetworkAccessConfig3 = {0x76E4B4F3, 0x2CA5, 0x466B, [0x89, 0xD5, 0xFD, 0x21, 0x8E, 0xE7, 0x5B, 0x49]};
@GUID(0x76E4B4F3, 0x2CA5, 0x466B, [0x89, 0xD5, 0xFD, 0x21, 0x8E, 0xE7, 0x5B, 0x49]);
interface IDtcNetworkAccessConfig3 : IDtcNetworkAccessConfig2
{
    HRESULT GetLUAccess(int* pbLUAccess);
    HRESULT SetLUAccess(BOOL bLUAccess);
}

enum XACT_DTC_CONSTANTS
{
    XACT_E_CONNECTION_REQUEST_DENIED = -2147168000,
    XACT_E_TOOMANY_ENLISTMENTS = -2147167999,
    XACT_E_DUPLICATE_GUID = -2147167998,
    XACT_E_NOTSINGLEPHASE = -2147167997,
    XACT_E_RECOVERYALREADYDONE = -2147167996,
    XACT_E_PROTOCOL = -2147167995,
    XACT_E_RM_FAILURE = -2147167994,
    XACT_E_RECOVERY_FAILED = -2147167993,
    XACT_E_LU_NOT_FOUND = -2147167992,
    XACT_E_DUPLICATE_LU = -2147167991,
    XACT_E_LU_NOT_CONNECTED = -2147167990,
    XACT_E_DUPLICATE_TRANSID = -2147167989,
    XACT_E_LU_BUSY = -2147167988,
    XACT_E_LU_NO_RECOVERY_PROCESS = -2147167987,
    XACT_E_LU_DOWN = -2147167986,
    XACT_E_LU_RECOVERING = -2147167985,
    XACT_E_LU_RECOVERY_MISMATCH = -2147167984,
    XACT_E_RM_UNAVAILABLE = -2147167983,
    XACT_E_LRMRECOVERYALREADYDONE = -2147167982,
    XACT_E_NOLASTRESOURCEINTERFACE = -2147167981,
    XACT_S_NONOTIFY = 315648,
    XACT_OK_NONOTIFY = 315649,
    dwUSER_MS_SQLSERVER = 65535,
}

struct xid_t
{
    int formatID;
    int gtrid_length;
    int bqual_length;
    byte data;
}

struct xa_switch_t
{
    byte name;
    int flags;
    int version;
    int xa_open_entry;
    int xa_close_entry;
    int xa_start_entry;
    int xa_end_entry;
    int xa_rollback_entry;
    int xa_prepare_entry;
    int xa_commit_entry;
    int xa_recover_entry;
    int xa_forget_entry;
    int xa_complete_entry;
}

const GUID IID_IXATransLookup = {0xF3B1F131, 0xEEDA, 0x11CE, [0xAE, 0xD4, 0x00, 0xAA, 0x00, 0x51, 0xE2, 0xC4]};
@GUID(0xF3B1F131, 0xEEDA, 0x11CE, [0xAE, 0xD4, 0x00, 0xAA, 0x00, 0x51, 0xE2, 0xC4]);
interface IXATransLookup : IUnknown
{
    HRESULT Lookup(ITransaction* ppTransaction);
}

const GUID IID_IXATransLookup2 = {0xBF193C85, 0x0D1A, 0x4290, [0xB8, 0x8F, 0xD2, 0xCB, 0x88, 0x73, 0xD1, 0xE7]};
@GUID(0xBF193C85, 0x0D1A, 0x4290, [0xB8, 0x8F, 0xD2, 0xCB, 0x88, 0x73, 0xD1, 0xE7]);
interface IXATransLookup2 : IUnknown
{
    HRESULT Lookup(xid_t* pXID, ITransaction* ppTransaction);
}

const GUID IID_IResourceManagerSink = {0x0D563181, 0xDEFB, 0x11CE, [0xAE, 0xD1, 0x00, 0xAA, 0x00, 0x51, 0xE2, 0xC4]};
@GUID(0x0D563181, 0xDEFB, 0x11CE, [0xAE, 0xD1, 0x00, 0xAA, 0x00, 0x51, 0xE2, 0xC4]);
interface IResourceManagerSink : IUnknown
{
    HRESULT TMDown();
}

const GUID IID_IResourceManager = {0x13741D21, 0x87EB, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]};
@GUID(0x13741D21, 0x87EB, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]);
interface IResourceManager : IUnknown
{
    HRESULT Enlist(ITransaction pTransaction, ITransactionResourceAsync pRes, BOID* pUOW, int* pisoLevel, ITransactionEnlistmentAsync* ppEnlist);
    HRESULT Reenlist(char* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
    HRESULT ReenlistmentComplete();
    HRESULT GetDistributedTransactionManager(const(Guid)* iid, void** ppvObject);
}

const GUID IID_ILastResourceManager = {0x4D964AD4, 0x5B33, 0x11D3, [0x8A, 0x91, 0x00, 0xC0, 0x4F, 0x79, 0xEB, 0x6D]};
@GUID(0x4D964AD4, 0x5B33, 0x11D3, [0x8A, 0x91, 0x00, 0xC0, 0x4F, 0x79, 0xEB, 0x6D]);
interface ILastResourceManager : IUnknown
{
    HRESULT TransactionCommitted(char* pPrepInfo, uint cbPrepInfo);
    HRESULT RecoveryDone();
}

const GUID IID_IResourceManager2 = {0xD136C69A, 0xF749, 0x11D1, [0x8F, 0x47, 0x00, 0xC0, 0x4F, 0x8E, 0xE5, 0x7D]};
@GUID(0xD136C69A, 0xF749, 0x11D1, [0x8F, 0x47, 0x00, 0xC0, 0x4F, 0x8E, 0xE5, 0x7D]);
interface IResourceManager2 : IResourceManager
{
    HRESULT Enlist2(ITransaction pTransaction, ITransactionResourceAsync pResAsync, BOID* pUOW, int* pisoLevel, xid_t* pXid, ITransactionEnlistmentAsync* ppEnlist);
    HRESULT Reenlist2(xid_t* pXid, uint dwTimeout, XACTSTAT* pXactStat);
}

const GUID IID_IResourceManagerRejoinable = {0x6F6DE620, 0xB5DF, 0x4F3E, [0x9C, 0xFA, 0xC8, 0xAE, 0xBD, 0x05, 0x17, 0x2B]};
@GUID(0x6F6DE620, 0xB5DF, 0x4F3E, [0x9C, 0xFA, 0xC8, 0xAE, 0xBD, 0x05, 0x17, 0x2B]);
interface IResourceManagerRejoinable : IResourceManager2
{
    HRESULT Rejoin(char* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
}

const GUID IID_IXAConfig = {0xC8A6E3A1, 0x9A8C, 0x11CF, [0xA3, 0x08, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0xC8A6E3A1, 0x9A8C, 0x11CF, [0xA3, 0x08, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IXAConfig : IUnknown
{
    HRESULT Initialize(Guid clsidHelperDll);
    HRESULT Terminate();
}

const GUID IID_IRMHelper = {0xE793F6D1, 0xF53D, 0x11CF, [0xA6, 0x0D, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0xE793F6D1, 0xF53D, 0x11CF, [0xA6, 0x0D, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IRMHelper : IUnknown
{
    HRESULT RMCount(uint dwcTotalNumberOfRMs);
    HRESULT RMInfo(xa_switch_t* pXa_Switch, BOOL fCDeclCallingConv, byte* pszOpenString, byte* pszCloseString, Guid guidRMRecovery);
}

const GUID IID_IXAObtainRMInfo = {0xE793F6D2, 0xF53D, 0x11CF, [0xA6, 0x0D, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0xE793F6D2, 0xF53D, 0x11CF, [0xA6, 0x0D, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IXAObtainRMInfo : IUnknown
{
    HRESULT ObtainRMInfo(IRMHelper pIRMHelper);
}

const GUID IID_IResourceManagerFactory = {0x13741D20, 0x87EB, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]};
@GUID(0x13741D20, 0x87EB, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]);
interface IResourceManagerFactory : IUnknown
{
    HRESULT Create(Guid* pguidRM, byte* pszRMName, IResourceManagerSink pIResMgrSink, IResourceManager* ppResMgr);
}

const GUID IID_IResourceManagerFactory2 = {0x6B369C21, 0xFBD2, 0x11D1, [0x8F, 0x47, 0x00, 0xC0, 0x4F, 0x8E, 0xE5, 0x7D]};
@GUID(0x6B369C21, 0xFBD2, 0x11D1, [0x8F, 0x47, 0x00, 0xC0, 0x4F, 0x8E, 0xE5, 0x7D]);
interface IResourceManagerFactory2 : IResourceManagerFactory
{
    HRESULT CreateEx(Guid* pguidRM, byte* pszRMName, IResourceManagerSink pIResMgrSink, const(Guid)* riidRequested, void** ppvResMgr);
}

const GUID IID_IPrepareInfo = {0x80C7BFD0, 0x87EE, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]};
@GUID(0x80C7BFD0, 0x87EE, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]);
interface IPrepareInfo : IUnknown
{
    HRESULT GetPrepareInfoSize(uint* pcbPrepInfo);
    HRESULT GetPrepareInfo(ubyte* pPrepInfo);
}

const GUID IID_IPrepareInfo2 = {0x5FAB2547, 0x9779, 0x11D1, [0xB8, 0x86, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0x5FAB2547, 0x9779, 0x11D1, [0xB8, 0x86, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface IPrepareInfo2 : IUnknown
{
    HRESULT GetPrepareInfoSize(uint* pcbPrepInfo);
    HRESULT GetPrepareInfo(uint cbPrepareInfo, char* pPrepInfo);
}

const GUID IID_IGetDispenser = {0xC23CC370, 0x87EF, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]};
@GUID(0xC23CC370, 0x87EF, 0x11CE, [0x80, 0x81, 0x00, 0x80, 0xC7, 0x58, 0x52, 0x7E]);
interface IGetDispenser : IUnknown
{
    HRESULT GetDispenser(const(Guid)* iid, void** ppvObject);
}

const GUID IID_ITransactionVoterBallotAsync2 = {0x5433376C, 0x414D, 0x11D3, [0xB2, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]};
@GUID(0x5433376C, 0x414D, 0x11D3, [0xB2, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]);
interface ITransactionVoterBallotAsync2 : IUnknown
{
    HRESULT VoteRequestDone(HRESULT hr, BOID* pboidReason);
}

const GUID IID_ITransactionVoterNotifyAsync2 = {0x5433376B, 0x414D, 0x11D3, [0xB2, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]};
@GUID(0x5433376B, 0x414D, 0x11D3, [0xB2, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]);
interface ITransactionVoterNotifyAsync2 : ITransactionOutcomeEvents
{
    HRESULT VoteRequest();
}

const GUID IID_ITransactionVoterFactory2 = {0x5433376A, 0x414D, 0x11D3, [0xB2, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]};
@GUID(0x5433376A, 0x414D, 0x11D3, [0xB2, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0xF3, 0xEF]);
interface ITransactionVoterFactory2 : IUnknown
{
    HRESULT Create(ITransaction pTransaction, ITransactionVoterNotifyAsync2 pVoterNotify, ITransactionVoterBallotAsync2* ppVoterBallot);
}

const GUID IID_ITransactionPhase0EnlistmentAsync = {0x82DC88E1, 0xA954, 0x11D1, [0x8F, 0x88, 0x00, 0x60, 0x08, 0x95, 0xE7, 0xD5]};
@GUID(0x82DC88E1, 0xA954, 0x11D1, [0x8F, 0x88, 0x00, 0x60, 0x08, 0x95, 0xE7, 0xD5]);
interface ITransactionPhase0EnlistmentAsync : IUnknown
{
    HRESULT Enable();
    HRESULT WaitForEnlistment();
    HRESULT Phase0Done();
    HRESULT Unenlist();
    HRESULT GetTransaction(ITransaction* ppITransaction);
}

const GUID IID_ITransactionPhase0NotifyAsync = {0xEF081809, 0x0C76, 0x11D2, [0x87, 0xA6, 0x00, 0xC0, 0x4F, 0x99, 0x0F, 0x34]};
@GUID(0xEF081809, 0x0C76, 0x11D2, [0x87, 0xA6, 0x00, 0xC0, 0x4F, 0x99, 0x0F, 0x34]);
interface ITransactionPhase0NotifyAsync : IUnknown
{
    HRESULT Phase0Request(BOOL fAbortingHint);
    HRESULT EnlistCompleted(HRESULT status);
}

const GUID IID_ITransactionPhase0Factory = {0x82DC88E0, 0xA954, 0x11D1, [0x8F, 0x88, 0x00, 0x60, 0x08, 0x95, 0xE7, 0xD5]};
@GUID(0x82DC88E0, 0xA954, 0x11D1, [0x8F, 0x88, 0x00, 0x60, 0x08, 0x95, 0xE7, 0xD5]);
interface ITransactionPhase0Factory : IUnknown
{
    HRESULT Create(ITransactionPhase0NotifyAsync pPhase0Notify, ITransactionPhase0EnlistmentAsync* ppPhase0Enlistment);
}

const GUID IID_ITransactionTransmitter = {0x59313E01, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]};
@GUID(0x59313E01, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]);
interface ITransactionTransmitter : IUnknown
{
    HRESULT Set(ITransaction pTransaction);
    HRESULT GetPropagationTokenSize(uint* pcbToken);
    HRESULT MarshalPropagationToken(uint cbToken, char* rgbToken, uint* pcbUsed);
    HRESULT UnmarshalReturnToken(uint cbReturnToken, char* rgbReturnToken);
    HRESULT Reset();
}

const GUID IID_ITransactionTransmitterFactory = {0x59313E00, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]};
@GUID(0x59313E00, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]);
interface ITransactionTransmitterFactory : IUnknown
{
    HRESULT Create(ITransactionTransmitter* ppTransmitter);
}

const GUID IID_ITransactionReceiver = {0x59313E03, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]};
@GUID(0x59313E03, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]);
interface ITransactionReceiver : IUnknown
{
    HRESULT UnmarshalPropagationToken(uint cbToken, char* rgbToken, ITransaction* ppTransaction);
    HRESULT GetReturnTokenSize(uint* pcbReturnToken);
    HRESULT MarshalReturnToken(uint cbReturnToken, char* rgbReturnToken, uint* pcbUsed);
    HRESULT Reset();
}

const GUID IID_ITransactionReceiverFactory = {0x59313E02, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]};
@GUID(0x59313E02, 0xB36C, 0x11CF, [0xA5, 0x39, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xC3]);
interface ITransactionReceiverFactory : IUnknown
{
    HRESULT Create(ITransactionReceiver* ppReceiver);
}

struct _ProxyConfigParams
{
    ushort wcThreadsMax;
}

const GUID IID_IDtcLuConfigure = {0x4131E760, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E760, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuConfigure : IUnknown
{
    HRESULT Add(char* pucLuPair, uint cbLuPair);
    HRESULT Delete(char* pucLuPair, uint cbLuPair);
}

const GUID IID_IDtcLuRecovery = {0xAC2B8AD2, 0xD6F0, 0x11D0, [0xB3, 0x86, 0x00, 0xA0, 0xC9, 0x08, 0x33, 0x65]};
@GUID(0xAC2B8AD2, 0xD6F0, 0x11D0, [0xB3, 0x86, 0x00, 0xA0, 0xC9, 0x08, 0x33, 0x65]);
interface IDtcLuRecovery : IUnknown
{
}

const GUID IID_IDtcLuRecoveryFactory = {0x4131E762, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E762, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRecoveryFactory : IUnknown
{
    HRESULT Create(char* pucLuPair, uint cbLuPair, IDtcLuRecovery* ppRecovery);
}

enum _DtcLu_LocalRecovery_Work
{
    DTCINITIATEDRECOVERYWORK_CHECKLUSTATUS = 1,
    DTCINITIATEDRECOVERYWORK_TRANS = 2,
    DTCINITIATEDRECOVERYWORK_TMDOWN = 3,
}

enum _DtcLu_Xln
{
    DTCLUXLN_COLD = 1,
    DTCLUXLN_WARM = 2,
}

enum _DtcLu_Xln_Confirmation
{
    DTCLUXLNCONFIRMATION_CONFIRM = 1,
    DTCLUXLNCONFIRMATION_LOGNAMEMISMATCH = 2,
    DTCLUXLNCONFIRMATION_COLDWARMMISMATCH = 3,
    DTCLUXLNCONFIRMATION_OBSOLETE = 4,
}

enum _DtcLu_Xln_Response
{
    DTCLUXLNRESPONSE_OK_SENDOURXLNBACK = 1,
    DTCLUXLNRESPONSE_OK_SENDCONFIRMATION = 2,
    DTCLUXLNRESPONSE_LOGNAMEMISMATCH = 3,
    DTCLUXLNRESPONSE_COLDWARMMISMATCH = 4,
}

enum _DtcLu_Xln_Error
{
    DTCLUXLNERROR_PROTOCOL = 1,
    DTCLUXLNERROR_LOGNAMEMISMATCH = 2,
    DTCLUXLNERROR_COLDWARMMISMATCH = 3,
}

enum _DtcLu_CompareState
{
    DTCLUCOMPARESTATE_COMMITTED = 1,
    DTCLUCOMPARESTATE_HEURISTICCOMMITTED = 2,
    DTCLUCOMPARESTATE_HEURISTICMIXED = 3,
    DTCLUCOMPARESTATE_HEURISTICRESET = 4,
    DTCLUCOMPARESTATE_INDOUBT = 5,
    DTCLUCOMPARESTATE_RESET = 6,
}

enum _DtcLu_CompareStates_Confirmation
{
    DTCLUCOMPARESTATESCONFIRMATION_CONFIRM = 1,
    DTCLUCOMPARESTATESCONFIRMATION_PROTOCOL = 2,
}

enum _DtcLu_CompareStates_Error
{
    DTCLUCOMPARESTATESERROR_PROTOCOL = 1,
}

enum _DtcLu_CompareStates_Response
{
    DTCLUCOMPARESTATESRESPONSE_OK = 1,
    DTCLUCOMPARESTATESRESPONSE_PROTOCOL = 2,
}

const GUID IID_IDtcLuRecoveryInitiatedByDtcTransWork = {0x4131E765, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E765, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRecoveryInitiatedByDtcTransWork : IUnknown
{
    HRESULT GetLogNameSizes(uint* pcbOurLogName, uint* pcbRemoteLogName);
    HRESULT GetOurXln(_DtcLu_Xln* pXln, ubyte* pOurLogName, ubyte* pRemoteLogName, uint* pdwProtocol);
    HRESULT HandleConfirmationFromOurXln(_DtcLu_Xln_Confirmation Confirmation);
    HRESULT HandleTheirXlnResponse(_DtcLu_Xln Xln, ubyte* pRemoteLogName, uint cbRemoteLogName, uint dwProtocol, _DtcLu_Xln_Confirmation* pConfirmation);
    HRESULT HandleErrorFromOurXln(_DtcLu_Xln_Error Error);
    HRESULT CheckForCompareStates(int* fCompareStates);
    HRESULT GetOurTransIdSize(uint* pcbOurTransId);
    HRESULT GetOurCompareStates(ubyte* pOurTransId, _DtcLu_CompareState* pCompareState);
    HRESULT HandleTheirCompareStatesResponse(_DtcLu_CompareState CompareState, _DtcLu_CompareStates_Confirmation* pConfirmation);
    HRESULT HandleErrorFromOurCompareStates(_DtcLu_CompareStates_Error Error);
    HRESULT ConversationLost();
    HRESULT GetRecoverySeqNum(int* plRecoverySeqNum);
    HRESULT ObsoleteRecoverySeqNum(int lNewRecoverySeqNum);
}

const GUID IID_IDtcLuRecoveryInitiatedByDtcStatusWork = {0x4131E766, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E766, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRecoveryInitiatedByDtcStatusWork : IUnknown
{
    HRESULT HandleCheckLuStatus(int lRecoverySeqNum);
}

const GUID IID_IDtcLuRecoveryInitiatedByDtc = {0x4131E764, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E764, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRecoveryInitiatedByDtc : IUnknown
{
    HRESULT GetWork(_DtcLu_LocalRecovery_Work* pWork, void** ppv);
}

const GUID IID_IDtcLuRecoveryInitiatedByLuWork = {0xAC2B8AD1, 0xD6F0, 0x11D0, [0xB3, 0x86, 0x00, 0xA0, 0xC9, 0x08, 0x33, 0x65]};
@GUID(0xAC2B8AD1, 0xD6F0, 0x11D0, [0xB3, 0x86, 0x00, 0xA0, 0xC9, 0x08, 0x33, 0x65]);
interface IDtcLuRecoveryInitiatedByLuWork : IUnknown
{
    HRESULT HandleTheirXln(int lRecoverySeqNum, _DtcLu_Xln Xln, ubyte* pRemoteLogName, uint cbRemoteLogName, ubyte* pOurLogName, uint cbOurLogName, uint dwProtocol, _DtcLu_Xln_Response* pResponse);
    HRESULT GetOurLogNameSize(uint* pcbOurLogName);
    HRESULT GetOurXln(_DtcLu_Xln* pXln, ubyte* pOurLogName, uint* pdwProtocol);
    HRESULT HandleConfirmationOfOurXln(_DtcLu_Xln_Confirmation Confirmation);
    HRESULT HandleTheirCompareStates(ubyte* pRemoteTransId, uint cbRemoteTransId, _DtcLu_CompareState CompareState, _DtcLu_CompareStates_Response* pResponse, _DtcLu_CompareState* pCompareState);
    HRESULT HandleConfirmationOfOurCompareStates(_DtcLu_CompareStates_Confirmation Confirmation);
    HRESULT HandleErrorFromOurCompareStates(_DtcLu_CompareStates_Error Error);
    HRESULT ConversationLost();
}

const GUID IID_IDtcLuRecoveryInitiatedByLu = {0x4131E768, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E768, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRecoveryInitiatedByLu : IUnknown
{
    HRESULT GetObjectToHandleWorkFromLu(IDtcLuRecoveryInitiatedByLuWork* ppWork);
}

const GUID IID_IDtcLuRmEnlistment = {0x4131E769, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E769, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRmEnlistment : IUnknown
{
    HRESULT Unplug(BOOL fConversationLost);
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT RequestCommit();
}

const GUID IID_IDtcLuRmEnlistmentSink = {0x4131E770, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E770, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRmEnlistmentSink : IUnknown
{
    HRESULT AckUnplug();
    HRESULT TmDown();
    HRESULT SessionLost();
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT Prepare();
    HRESULT RequestCommit();
}

const GUID IID_IDtcLuRmEnlistmentFactory = {0x4131E771, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E771, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuRmEnlistmentFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, ITransaction pITransaction, ubyte* pTransId, uint cbTransId, IDtcLuRmEnlistmentSink pRmEnlistmentSink, IDtcLuRmEnlistment* ppRmEnlistment);
}

const GUID IID_IDtcLuSubordinateDtc = {0x4131E773, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E773, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuSubordinateDtc : IUnknown
{
    HRESULT Unplug(BOOL fConversationLost);
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT Prepare();
    HRESULT RequestCommit();
}

const GUID IID_IDtcLuSubordinateDtcSink = {0x4131E774, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E774, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuSubordinateDtcSink : IUnknown
{
    HRESULT AckUnplug();
    HRESULT TmDown();
    HRESULT SessionLost();
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT RequestCommit();
}

const GUID IID_IDtcLuSubordinateDtcFactory = {0x4131E775, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]};
@GUID(0x4131E775, 0x1AEA, 0x11D0, [0x94, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x6E]);
interface IDtcLuSubordinateDtcFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, IUnknown punkTransactionOuter, int isoLevel, uint isoFlags, ITransactionOptions pOptions, ITransaction* ppTransaction, ubyte* pTransId, uint cbTransId, IDtcLuSubordinateDtcSink pSubordinateDtcSink, IDtcLuSubordinateDtc* ppSubordinateDtc);
}

const GUID IID_ISecurityIdentityColl = {0xCAFC823C, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xCAFC823C, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
interface ISecurityIdentityColl : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

const GUID IID_ISecurityCallersColl = {0xCAFC823D, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xCAFC823D, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
interface ISecurityCallersColl : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(int lIndex, ISecurityIdentityColl* pObj);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

const GUID IID_ISecurityCallContext = {0xCAFC823E, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xCAFC823E, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
interface ISecurityCallContext : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT IsCallerInRole(BSTR bstrRole, short* pfInRole);
    HRESULT IsSecurityEnabled(short* pfIsEnabled);
    HRESULT IsUserInRole(VARIANT* pUser, BSTR bstrRole, short* pfInRole);
}

const GUID IID_IGetSecurityCallContext = {0xCAFC823F, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]};
@GUID(0xCAFC823F, 0xB441, 0x11D1, [0xB8, 0x2B, 0x00, 0x00, 0xF8, 0x75, 0x7E, 0x2A]);
interface IGetSecurityCallContext : IDispatch
{
    HRESULT GetSecurityCallContext(ISecurityCallContext* ppObject);
}

const GUID IID_SecurityProperty = {0xE74A7215, 0x014D, 0x11D1, [0xA6, 0x3C, 0x00, 0xA0, 0xC9, 0x11, 0xB4, 0xE0]};
@GUID(0xE74A7215, 0x014D, 0x11D1, [0xA6, 0x3C, 0x00, 0xA0, 0xC9, 0x11, 0xB4, 0xE0]);
interface SecurityProperty : IDispatch
{
    HRESULT GetDirectCallerName(BSTR* bstrUserName);
    HRESULT GetDirectCreatorName(BSTR* bstrUserName);
    HRESULT GetOriginalCallerName(BSTR* bstrUserName);
    HRESULT GetOriginalCreatorName(BSTR* bstrUserName);
}

const GUID IID_ContextInfo = {0x19A5A02C, 0x0AC8, 0x11D2, [0xB2, 0x86, 0x00, 0xC0, 0x4F, 0x8E, 0xF9, 0x34]};
@GUID(0x19A5A02C, 0x0AC8, 0x11D2, [0xB2, 0x86, 0x00, 0xC0, 0x4F, 0x8E, 0xF9, 0x34]);
interface ContextInfo : IDispatch
{
    HRESULT IsInTransaction(short* pbIsInTx);
    HRESULT GetTransaction(IUnknown* ppTx);
    HRESULT GetTransactionId(BSTR* pbstrTxId);
    HRESULT GetActivityId(BSTR* pbstrActivityId);
    HRESULT GetContextId(BSTR* pbstrCtxId);
}

const GUID IID_ContextInfo2 = {0xC99D6E75, 0x2375, 0x11D4, [0x83, 0x31, 0x00, 0xC0, 0x4F, 0x60, 0x55, 0x88]};
@GUID(0xC99D6E75, 0x2375, 0x11D4, [0x83, 0x31, 0x00, 0xC0, 0x4F, 0x60, 0x55, 0x88]);
interface ContextInfo2 : ContextInfo
{
    HRESULT GetPartitionId(BSTR* __MIDL__ContextInfo20000);
    HRESULT GetApplicationId(BSTR* __MIDL__ContextInfo20001);
    HRESULT GetApplicationInstanceId(BSTR* __MIDL__ContextInfo20002);
}

const GUID IID_ObjectContext = {0x74C08646, 0xCEDB, 0x11CF, [0x8B, 0x49, 0x00, 0xAA, 0x00, 0xB8, 0xA7, 0x90]};
@GUID(0x74C08646, 0xCEDB, 0x11CF, [0x8B, 0x49, 0x00, 0xAA, 0x00, 0xB8, 0xA7, 0x90]);
interface ObjectContext : IDispatch
{
    HRESULT CreateInstance(BSTR bstrProgID, VARIANT* pObject);
    HRESULT SetComplete();
    HRESULT SetAbort();
    HRESULT EnableCommit();
    HRESULT DisableCommit();
    HRESULT IsInTransaction(short* pbIsInTx);
    HRESULT IsSecurityEnabled(short* pbIsEnabled);
    HRESULT IsCallerInRole(BSTR bstrRole, short* pbInRole);
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT get_Security(SecurityProperty* ppSecurityProperty);
    HRESULT get_ContextInfo(ContextInfo* ppContextInfo);
}

const GUID IID_ITransactionContextEx = {0x7999FC22, 0xD3C6, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]};
@GUID(0x7999FC22, 0xD3C6, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]);
interface ITransactionContextEx : IUnknown
{
    HRESULT CreateInstance(const(Guid)* rclsid, const(Guid)* riid, void** pObject);
    HRESULT Commit();
    HRESULT Abort();
}

const GUID IID_ITransactionContext = {0x7999FC21, 0xD3C6, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]};
@GUID(0x7999FC21, 0xD3C6, 0x11CF, [0xAC, 0xAB, 0x00, 0xA0, 0x24, 0xA5, 0x5A, 0xEF]);
interface ITransactionContext : IDispatch
{
    HRESULT CreateInstance(BSTR pszProgId, VARIANT* pObject);
    HRESULT Commit();
    HRESULT Abort();
}

const GUID IID_ICreateWithTransactionEx = {0x455ACF57, 0x5345, 0x11D2, [0x99, 0xCF, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xC9]};
@GUID(0x455ACF57, 0x5345, 0x11D2, [0x99, 0xCF, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xC9]);
interface ICreateWithTransactionEx : IUnknown
{
    HRESULT CreateInstance(ITransaction pTransaction, const(Guid)* rclsid, const(Guid)* riid, void** pObject);
}

const GUID IID_ICreateWithLocalTransaction = {0x227AC7A8, 0x8423, 0x42CE, [0xB7, 0xCF, 0x03, 0x06, 0x1E, 0xC9, 0xAA, 0xA3]};
@GUID(0x227AC7A8, 0x8423, 0x42CE, [0xB7, 0xCF, 0x03, 0x06, 0x1E, 0xC9, 0xAA, 0xA3]);
interface ICreateWithLocalTransaction : IUnknown
{
    HRESULT CreateInstanceWithSysTx(IUnknown pTransaction, const(Guid)* rclsid, const(Guid)* riid, void** pObject);
}

const GUID IID_ICreateWithTipTransactionEx = {0x455ACF59, 0x5345, 0x11D2, [0x99, 0xCF, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xC9]};
@GUID(0x455ACF59, 0x5345, 0x11D2, [0x99, 0xCF, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xC9]);
interface ICreateWithTipTransactionEx : IUnknown
{
    HRESULT CreateInstance(BSTR bstrTipUrl, const(Guid)* rclsid, const(Guid)* riid, void** pObject);
}

struct COMSVCSEVENTINFO
{
    uint cbSize;
    uint dwPid;
    long lTime;
    int lMicroTime;
    long perfCount;
    Guid guidApp;
    ushort* sMachineName;
}

const GUID IID_IComLTxEvents = {0x605CF82C, 0x578E, 0x4298, [0x97, 0x5D, 0x82, 0xBA, 0xBC, 0xD9, 0xE0, 0x53]};
@GUID(0x605CF82C, 0x578E, 0x4298, [0x97, 0x5D, 0x82, 0xBA, 0xBC, 0xD9, 0xE0, 0x53]);
interface IComLTxEvents : IUnknown
{
    HRESULT OnLtxTransactionStart(COMSVCSEVENTINFO* pInfo, Guid guidLtx, Guid tsid, BOOL fRoot, int nIsolationLevel);
    HRESULT OnLtxTransactionPrepare(COMSVCSEVENTINFO* pInfo, Guid guidLtx, BOOL fVote);
    HRESULT OnLtxTransactionAbort(COMSVCSEVENTINFO* pInfo, Guid guidLtx);
    HRESULT OnLtxTransactionCommit(COMSVCSEVENTINFO* pInfo, Guid guidLtx);
    HRESULT OnLtxTransactionPromote(COMSVCSEVENTINFO* pInfo, Guid guidLtx, Guid txnId);
}

const GUID IID_IComUserEvent = {0x683130A4, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130A4, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComUserEvent : IUnknown
{
    HRESULT OnUserEvent(COMSVCSEVENTINFO* pInfo, VARIANT* pvarEvent);
}

const GUID IID_IComThreadEvents = {0x683130A5, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130A5, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComThreadEvents : IUnknown
{
    HRESULT OnThreadStart(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    HRESULT OnThreadTerminate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    HRESULT OnThreadBindToApartment(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt, uint dwLowCnt);
    HRESULT OnThreadUnBind(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt);
    HRESULT OnThreadWorkEnque(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkPrivate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID);
    HRESULT OnThreadWorkPublic(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkRedirect(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen, ulong ThreadNum);
    HRESULT OnThreadWorkReject(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadAssignApartment(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, ulong AptID);
    HRESULT OnThreadUnassignApartment(COMSVCSEVENTINFO* pInfo, ulong AptID);
}

const GUID IID_IComAppEvents = {0x683130A6, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130A6, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComAppEvents : IUnknown
{
    HRESULT OnAppActivation(COMSVCSEVENTINFO* pInfo, Guid guidApp);
    HRESULT OnAppShutdown(COMSVCSEVENTINFO* pInfo, Guid guidApp);
    HRESULT OnAppForceShutdown(COMSVCSEVENTINFO* pInfo, Guid guidApp);
}

const GUID IID_IComInstanceEvents = {0x683130A7, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130A7, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComInstanceEvents : IUnknown
{
    HRESULT OnObjectCreate(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* clsid, const(Guid)* tsid, ulong CtxtID, ulong ObjectID);
    HRESULT OnObjectDestroy(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

const GUID IID_IComTransactionEvents = {0x683130A8, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130A8, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComTransactionEvents : IUnknown
{
    HRESULT OnTransactionStart(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx, const(Guid)* tsid, BOOL fRoot);
    HRESULT OnTransactionPrepare(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx, BOOL fVoteYes);
    HRESULT OnTransactionAbort(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx);
    HRESULT OnTransactionCommit(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx);
}

const GUID IID_IComMethodEvents = {0x683130A9, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130A9, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComMethodEvents : IUnknown
{
    HRESULT OnMethodCall(COMSVCSEVENTINFO* pInfo, ulong oid, const(Guid)* guidCid, const(Guid)* guidRid, uint iMeth);
    HRESULT OnMethodReturn(COMSVCSEVENTINFO* pInfo, ulong oid, const(Guid)* guidCid, const(Guid)* guidRid, uint iMeth, HRESULT hresult);
    HRESULT OnMethodException(COMSVCSEVENTINFO* pInfo, ulong oid, const(Guid)* guidCid, const(Guid)* guidRid, uint iMeth);
}

const GUID IID_IComObjectEvents = {0x683130AA, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130AA, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComObjectEvents : IUnknown
{
    HRESULT OnObjectActivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    HRESULT OnObjectDeactivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    HRESULT OnDisableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnEnableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnSetComplete(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnSetAbort(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

const GUID IID_IComResourceEvents = {0x683130AB, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130AB, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComResourceEvents : IUnknown
{
    HRESULT OnResourceCreate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId, BOOL enlisted);
    HRESULT OnResourceAllocate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId, BOOL enlisted, uint NumRated, uint Rating);
    HRESULT OnResourceRecycle(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId);
    HRESULT OnResourceDestroy(COMSVCSEVENTINFO* pInfo, ulong ObjectID, HRESULT hr, ushort* pszType, ulong resId);
    HRESULT OnResourceTrack(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId, BOOL enlisted);
}

const GUID IID_IComSecurityEvents = {0x683130AC, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130AC, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComSecurityEvents : IUnknown
{
    HRESULT OnAuthenticate(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, ulong ObjectID, const(Guid)* guidIID, uint iMeth, uint cbByteOrig, char* pSidOriginalUser, uint cbByteCur, char* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
    HRESULT OnAuthenticateFail(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, ulong ObjectID, const(Guid)* guidIID, uint iMeth, uint cbByteOrig, char* pSidOriginalUser, uint cbByteCur, char* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
}

const GUID IID_IComObjectPoolEvents = {0x683130AD, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130AD, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComObjectPoolEvents : IUnknown
{
    HRESULT OnObjPoolPutObject(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, int nReason, uint dwAvailable, ulong oid);
    HRESULT OnObjPoolGetObject(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* guidObject, uint dwAvailable, ulong oid);
    HRESULT OnObjPoolRecycleToTx(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* guidObject, const(Guid)* guidTx, ulong objid);
    HRESULT OnObjPoolGetFromTx(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* guidObject, const(Guid)* guidTx, ulong objid);
}

const GUID IID_IComObjectPoolEvents2 = {0x683130AE, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130AE, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComObjectPoolEvents2 : IUnknown
{
    HRESULT OnObjPoolCreateObject(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, uint dwObjsCreated, ulong oid);
    HRESULT OnObjPoolDestroyObject(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, uint dwObjsCreated, ulong oid);
    HRESULT OnObjPoolCreateDecision(COMSVCSEVENTINFO* pInfo, uint dwThreadsWaiting, uint dwAvail, uint dwCreated, uint dwMin, uint dwMax);
    HRESULT OnObjPoolTimeout(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, const(Guid)* guidActivity, uint dwTimeout);
    HRESULT OnObjPoolCreatePool(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, uint dwMin, uint dwMax, uint dwTimeout);
}

const GUID IID_IComObjectConstructionEvents = {0x683130AF, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130AF, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComObjectConstructionEvents : IUnknown
{
    HRESULT OnObjectConstruct(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, ushort* sConstructString, ulong oid);
}

const GUID IID_IComActivityEvents = {0x683130B0, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130B0, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComActivityEvents : IUnknown
{
    HRESULT OnActivityCreate(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity);
    HRESULT OnActivityDestroy(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity);
    HRESULT OnActivityEnter(COMSVCSEVENTINFO* pInfo, const(Guid)* guidCurrent, const(Guid)* guidEntered, uint dwThread);
    HRESULT OnActivityTimeout(COMSVCSEVENTINFO* pInfo, const(Guid)* guidCurrent, const(Guid)* guidEntered, uint dwThread, uint dwTimeout);
    HRESULT OnActivityReenter(COMSVCSEVENTINFO* pInfo, const(Guid)* guidCurrent, uint dwThread, uint dwCallDepth);
    HRESULT OnActivityLeave(COMSVCSEVENTINFO* pInfo, const(Guid)* guidCurrent, const(Guid)* guidLeft);
    HRESULT OnActivityLeaveSame(COMSVCSEVENTINFO* pInfo, const(Guid)* guidCurrent, uint dwCallDepth);
}

const GUID IID_IComIdentityEvents = {0x683130B1, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130B1, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComIdentityEvents : IUnknown
{
    HRESULT OnIISRequestInfo(COMSVCSEVENTINFO* pInfo, ulong ObjId, ushort* pszClientIP, ushort* pszServerIP, ushort* pszURL);
}

const GUID IID_IComQCEvents = {0x683130B2, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130B2, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComQCEvents : IUnknown
{
    HRESULT OnQCRecord(COMSVCSEVENTINFO* pInfo, ulong objid, char* szQueue, const(Guid)* guidMsgId, const(Guid)* guidWorkFlowId, HRESULT msmqhr);
    HRESULT OnQCQueueOpen(COMSVCSEVENTINFO* pInfo, char* szQueue, ulong QueueID, HRESULT hr);
    HRESULT OnQCReceive(COMSVCSEVENTINFO* pInfo, ulong QueueID, const(Guid)* guidMsgId, const(Guid)* guidWorkFlowId, HRESULT hr);
    HRESULT OnQCReceiveFail(COMSVCSEVENTINFO* pInfo, ulong QueueID, HRESULT msmqhr);
    HRESULT OnQCMoveToReTryQueue(COMSVCSEVENTINFO* pInfo, const(Guid)* guidMsgId, const(Guid)* guidWorkFlowId, uint RetryIndex);
    HRESULT OnQCMoveToDeadQueue(COMSVCSEVENTINFO* pInfo, const(Guid)* guidMsgId, const(Guid)* guidWorkFlowId);
    HRESULT OnQCPlayback(COMSVCSEVENTINFO* pInfo, ulong objid, const(Guid)* guidMsgId, const(Guid)* guidWorkFlowId, HRESULT hr);
}

const GUID IID_IComExceptionEvents = {0x683130B3, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130B3, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComExceptionEvents : IUnknown
{
    HRESULT OnExceptionUser(COMSVCSEVENTINFO* pInfo, uint code, ulong address, ushort* pszStackTrace);
}

const GUID IID_ILBEvents = {0x683130B4, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130B4, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface ILBEvents : IUnknown
{
    HRESULT TargetUp(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT TargetDown(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT EngineDefined(BSTR bstrPropName, VARIANT* varPropValue, BSTR bstrClsidEng);
}

const GUID IID_IComCRMEvents = {0x683130B5, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x683130B5, 0x2E50, 0x11D2, [0x98, 0xA5, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComCRMEvents : IUnknown
{
    HRESULT OnCRMRecoveryStart(COMSVCSEVENTINFO* pInfo, Guid guidApp);
    HRESULT OnCRMRecoveryDone(COMSVCSEVENTINFO* pInfo, Guid guidApp);
    HRESULT OnCRMCheckpoint(COMSVCSEVENTINFO* pInfo, Guid guidApp);
    HRESULT OnCRMBegin(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID, Guid guidActivity, Guid guidTx, char* szProgIdCompensator, char* szDescription);
    HRESULT OnCRMPrepare(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMCommit(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMAbort(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMIndoubt(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMDone(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMRelease(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMAnalyze(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID, uint dwCrmRecordType, uint dwRecordSize);
    HRESULT OnCRMWrite(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
    HRESULT OnCRMForget(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMForce(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID);
    HRESULT OnCRMDeliver(COMSVCSEVENTINFO* pInfo, Guid guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
}

const GUID IID_IComMethod2Events = {0xFB388AAA, 0x567D, 0x4024, [0xAF, 0x8E, 0x6E, 0x93, 0xEE, 0x74, 0x85, 0x73]};
@GUID(0xFB388AAA, 0x567D, 0x4024, [0xAF, 0x8E, 0x6E, 0x93, 0xEE, 0x74, 0x85, 0x73]);
interface IComMethod2Events : IUnknown
{
    HRESULT OnMethodCall2(COMSVCSEVENTINFO* pInfo, ulong oid, const(Guid)* guidCid, const(Guid)* guidRid, uint dwThread, uint iMeth);
    HRESULT OnMethodReturn2(COMSVCSEVENTINFO* pInfo, ulong oid, const(Guid)* guidCid, const(Guid)* guidRid, uint dwThread, uint iMeth, HRESULT hresult);
    HRESULT OnMethodException2(COMSVCSEVENTINFO* pInfo, ulong oid, const(Guid)* guidCid, const(Guid)* guidRid, uint dwThread, uint iMeth);
}

const GUID IID_IComTrackingInfoEvents = {0x4E6CDCC9, 0xFB25, 0x4FD5, [0x9C, 0xC5, 0xC9, 0xF4, 0xB6, 0x55, 0x9C, 0xEC]};
@GUID(0x4E6CDCC9, 0xFB25, 0x4FD5, [0x9C, 0xC5, 0xC9, 0xF4, 0xB6, 0x55, 0x9C, 0xEC]);
interface IComTrackingInfoEvents : IUnknown
{
    HRESULT OnNewTrackingInfo(IUnknown pToplevelCollection);
}

enum TRACKING_COLL_TYPE
{
    TRKCOLL_PROCESSES = 0,
    TRKCOLL_APPLICATIONS = 1,
    TRKCOLL_COMPONENTS = 2,
}

const GUID IID_IComTrackingInfoCollection = {0xC266C677, 0xC9AD, 0x49AB, [0x9F, 0xD9, 0xD9, 0x66, 0x10, 0x78, 0x58, 0x8A]};
@GUID(0xC266C677, 0xC9AD, 0x49AB, [0x9F, 0xD9, 0xD9, 0x66, 0x10, 0x78, 0x58, 0x8A]);
interface IComTrackingInfoCollection : IUnknown
{
    HRESULT Type(TRACKING_COLL_TYPE* pType);
    HRESULT Count(uint* pCount);
    HRESULT Item(uint ulIndex, const(Guid)* riid, void** ppv);
}

const GUID IID_IComTrackingInfoObject = {0x116E42C5, 0xD8B1, 0x47BF, [0xAB, 0x1E, 0xC8, 0x95, 0xED, 0x3E, 0x23, 0x72]};
@GUID(0x116E42C5, 0xD8B1, 0x47BF, [0xAB, 0x1E, 0xC8, 0x95, 0xED, 0x3E, 0x23, 0x72]);
interface IComTrackingInfoObject : IUnknown
{
    HRESULT GetValue(ushort* szPropertyName, VARIANT* pvarOut);
}

const GUID IID_IComTrackingInfoProperties = {0x789B42BE, 0x6F6B, 0x443A, [0x89, 0x8E, 0x67, 0xAB, 0xF3, 0x90, 0xAA, 0x14]};
@GUID(0x789B42BE, 0x6F6B, 0x443A, [0x89, 0x8E, 0x67, 0xAB, 0xF3, 0x90, 0xAA, 0x14]);
interface IComTrackingInfoProperties : IUnknown
{
    HRESULT PropCount(uint* pCount);
    HRESULT GetPropName(uint ulIndex, ushort** ppszPropName);
}

const GUID IID_IComApp2Events = {0x1290BC1A, 0xB219, 0x418D, [0xB0, 0x78, 0x59, 0x34, 0xDE, 0xD0, 0x82, 0x42]};
@GUID(0x1290BC1A, 0xB219, 0x418D, [0xB0, 0x78, 0x59, 0x34, 0xDE, 0xD0, 0x82, 0x42]);
interface IComApp2Events : IUnknown
{
    HRESULT OnAppActivation2(COMSVCSEVENTINFO* pInfo, Guid guidApp, Guid guidProcess);
    HRESULT OnAppShutdown2(COMSVCSEVENTINFO* pInfo, Guid guidApp);
    HRESULT OnAppForceShutdown2(COMSVCSEVENTINFO* pInfo, Guid guidApp);
    HRESULT OnAppPaused2(COMSVCSEVENTINFO* pInfo, Guid guidApp, BOOL bPaused);
    HRESULT OnAppRecycle2(COMSVCSEVENTINFO* pInfo, Guid guidApp, Guid guidProcess, int lReason);
}

const GUID IID_IComTransaction2Events = {0xA136F62A, 0x2F94, 0x4288, [0x86, 0xE0, 0xD8, 0xA1, 0xFA, 0x4C, 0x02, 0x99]};
@GUID(0xA136F62A, 0x2F94, 0x4288, [0x86, 0xE0, 0xD8, 0xA1, 0xFA, 0x4C, 0x02, 0x99]);
interface IComTransaction2Events : IUnknown
{
    HRESULT OnTransactionStart2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx, const(Guid)* tsid, BOOL fRoot, int nIsolationLevel);
    HRESULT OnTransactionPrepare2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx, BOOL fVoteYes);
    HRESULT OnTransactionAbort2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx);
    HRESULT OnTransactionCommit2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidTx);
}

const GUID IID_IComInstance2Events = {0x20E3BF07, 0xB506, 0x4AD5, [0xA5, 0x0C, 0xD2, 0xCA, 0x5B, 0x9C, 0x15, 0x8E]};
@GUID(0x20E3BF07, 0xB506, 0x4AD5, [0xA5, 0x0C, 0xD2, 0xCA, 0x5B, 0x9C, 0x15, 0x8E]);
interface IComInstance2Events : IUnknown
{
    HRESULT OnObjectCreate2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* clsid, const(Guid)* tsid, ulong CtxtID, ulong ObjectID, const(Guid)* guidPartition);
    HRESULT OnObjectDestroy2(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

const GUID IID_IComObjectPool2Events = {0x65BF6534, 0x85EA, 0x4F64, [0x8C, 0xF4, 0x3D, 0x97, 0x4B, 0x2A, 0xB1, 0xCF]};
@GUID(0x65BF6534, 0x85EA, 0x4F64, [0x8C, 0xF4, 0x3D, 0x97, 0x4B, 0x2A, 0xB1, 0xCF]);
interface IComObjectPool2Events : IUnknown
{
    HRESULT OnObjPoolPutObject2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, int nReason, uint dwAvailable, ulong oid);
    HRESULT OnObjPoolGetObject2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* guidObject, uint dwAvailable, ulong oid, const(Guid)* guidPartition);
    HRESULT OnObjPoolRecycleToTx2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* guidObject, const(Guid)* guidTx, ulong objid);
    HRESULT OnObjPoolGetFromTx2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidActivity, const(Guid)* guidObject, const(Guid)* guidTx, ulong objid, const(Guid)* guidPartition);
}

const GUID IID_IComObjectConstruction2Events = {0x4B5A7827, 0x8DF2, 0x45C0, [0x8F, 0x6F, 0x57, 0xEA, 0x1F, 0x85, 0x6A, 0x9F]};
@GUID(0x4B5A7827, 0x8DF2, 0x45C0, [0x8F, 0x6F, 0x57, 0xEA, 0x1F, 0x85, 0x6A, 0x9F]);
interface IComObjectConstruction2Events : IUnknown
{
    HRESULT OnObjectConstruct2(COMSVCSEVENTINFO* pInfo, const(Guid)* guidObject, ushort* sConstructString, ulong oid, const(Guid)* guidPartition);
}

const GUID IID_ISystemAppEventData = {0xD6D48A3C, 0xD5C5, 0x49E7, [0x8C, 0x74, 0x99, 0xE4, 0x88, 0x9E, 0xD5, 0x2F]};
@GUID(0xD6D48A3C, 0xD5C5, 0x49E7, [0x8C, 0x74, 0x99, 0xE4, 0x88, 0x9E, 0xD5, 0x2F]);
interface ISystemAppEventData : IUnknown
{
    HRESULT Startup();
    HRESULT OnDataChanged(uint dwPID, uint dwMask, uint dwNumberSinks, BSTR bstrDwMethodMask, uint dwReason, ulong u64TraceHandle);
}

const GUID IID_IMtsEvents = {0xBACEDF4D, 0x74AB, 0x11D0, [0xB1, 0x62, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0xBACEDF4D, 0x74AB, 0x11D0, [0xB1, 0x62, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
interface IMtsEvents : IDispatch
{
    HRESULT get_PackageName(BSTR* pVal);
    HRESULT get_PackageGuid(BSTR* pVal);
    HRESULT PostEvent(VARIANT* vEvent);
    HRESULT get_FireEvents(short* pVal);
    HRESULT GetProcessID(int* id);
}

const GUID IID_IMtsEventInfo = {0xD56C3DC1, 0x8482, 0x11D0, [0xB1, 0x70, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0xD56C3DC1, 0x8482, 0x11D0, [0xB1, 0x70, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
interface IMtsEventInfo : IDispatch
{
    HRESULT get_Names(IUnknown* pUnk);
    HRESULT get_DisplayName(BSTR* sDisplayName);
    HRESULT get_EventID(BSTR* sGuidEventID);
    HRESULT get_Count(int* lCount);
    HRESULT get_Value(BSTR sKey, VARIANT* pVal);
}

const GUID IID_IMTSLocator = {0xD19B8BFD, 0x7F88, 0x11D0, [0xB1, 0x6E, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0xD19B8BFD, 0x7F88, 0x11D0, [0xB1, 0x6E, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
interface IMTSLocator : IDispatch
{
    HRESULT GetEventDispatcher(IUnknown* pUnk);
}

const GUID IID_IMtsGrp = {0x4B2E958C, 0x0393, 0x11D1, [0xB1, 0xAB, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0x4B2E958C, 0x0393, 0x11D1, [0xB1, 0xAB, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
interface IMtsGrp : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT Item(int lIndex, IUnknown* ppUnkDispatcher);
    HRESULT Refresh();
}

const GUID IID_IMessageMover = {0x588A085A, 0xB795, 0x11D1, [0x80, 0x54, 0x00, 0xC0, 0x4F, 0xC3, 0x40, 0xEE]};
@GUID(0x588A085A, 0xB795, 0x11D1, [0x80, 0x54, 0x00, 0xC0, 0x4F, 0xC3, 0x40, 0xEE]);
interface IMessageMover : IDispatch
{
    HRESULT get_SourcePath(BSTR* pVal);
    HRESULT put_SourcePath(BSTR newVal);
    HRESULT get_DestPath(BSTR* pVal);
    HRESULT put_DestPath(BSTR newVal);
    HRESULT get_CommitBatchSize(int* pVal);
    HRESULT put_CommitBatchSize(int newVal);
    HRESULT MoveMessages(int* plMessagesMoved);
}

const GUID IID_IEventServerTrace = {0x9A9F12B8, 0x80AF, 0x47AB, [0xA5, 0x79, 0x35, 0xEA, 0x57, 0x72, 0x53, 0x70]};
@GUID(0x9A9F12B8, 0x80AF, 0x47AB, [0xA5, 0x79, 0x35, 0xEA, 0x57, 0x72, 0x53, 0x70]);
interface IEventServerTrace : IDispatch
{
    HRESULT StartTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT StopTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT EnumTraceGuid(int* plCntGuids, BSTR* pbstrGuidList);
}

struct RECYCLE_INFO
{
    Guid guidCombaseProcessIdentifier;
    long ProcessStartTime;
    uint dwRecycleLifetimeLimit;
    uint dwRecycleMemoryLimit;
    uint dwRecycleExpirationTimeout;
}

enum DUMPTYPE
{
    DUMPTYPE_FULL = 0,
    DUMPTYPE_MINI = 1,
    DUMPTYPE_NONE = 2,
}

struct HANG_INFO
{
    BOOL fAppHangMonitorEnabled;
    BOOL fTerminateOnHang;
    DUMPTYPE DumpType;
    uint dwHangTimeout;
    uint dwDumpCount;
    uint dwInfoMsgCount;
}

enum COMPLUS_APPTYPE
{
    APPTYPE_UNKNOWN = -1,
    APPTYPE_SERVER = 1,
    APPTYPE_LIBRARY = 0,
    APPTYPE_SWC = 2,
}

struct CAppStatistics
{
    uint m_cTotalCalls;
    uint m_cTotalInstances;
    uint m_cTotalClasses;
    uint m_cCallsPerSecond;
}

struct CAppData
{
    uint m_idApp;
    ushort m_szAppGuid;
    uint m_dwAppProcessId;
    CAppStatistics m_AppStatistics;
}

struct CCLSIDData
{
    Guid m_clsid;
    uint m_cReferences;
    uint m_cBound;
    uint m_cPooled;
    uint m_cInCall;
    uint m_dwRespTime;
    uint m_cCallsCompleted;
    uint m_cCallsFailed;
}

struct CCLSIDData2
{
    Guid m_clsid;
    Guid m_appid;
    Guid m_partid;
    ushort* m_pwszAppName;
    ushort* m_pwszCtxName;
    COMPLUS_APPTYPE m_eAppType;
    uint m_cReferences;
    uint m_cBound;
    uint m_cPooled;
    uint m_cInCall;
    uint m_dwRespTime;
    uint m_cCallsCompleted;
    uint m_cCallsFailed;
}

enum GetAppTrackerDataFlags
{
    GATD_INCLUDE_PROCESS_EXE_NAME = 1,
    GATD_INCLUDE_LIBRARY_APPS = 2,
    GATD_INCLUDE_SWC = 4,
    GATD_INCLUDE_CLASS_NAME = 8,
    GATD_INCLUDE_APPLICATION_NAME = 16,
}

struct ApplicationProcessSummary
{
    Guid PartitionIdPrimaryApplication;
    Guid ApplicationIdPrimaryApplication;
    Guid ApplicationInstanceId;
    uint ProcessId;
    COMPLUS_APPTYPE Type;
    const(wchar)* ProcessExeName;
    BOOL IsService;
    BOOL IsPaused;
    BOOL IsRecycled;
}

struct ApplicationProcessStatistics
{
    uint NumCallsOutstanding;
    uint NumTrackedComponents;
    uint NumComponentInstances;
    uint AvgCallsPerSecond;
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
}

struct ApplicationProcessRecycleInfo
{
    BOOL IsRecyclable;
    BOOL IsRecycled;
    FILETIME TimeRecycled;
    FILETIME TimeToTerminate;
    int RecycleReasonCode;
    BOOL IsPendingRecycle;
    BOOL HasAutomaticLifetimeRecycling;
    FILETIME TimeForAutomaticRecycling;
    uint MemoryLimitInKB;
    uint MemoryUsageInKBLastCheck;
    uint ActivationLimit;
    uint NumActivationsLastReported;
    uint CallLimit;
    uint NumCallsLastReported;
}

struct ApplicationSummary
{
    Guid ApplicationInstanceId;
    Guid PartitionId;
    Guid ApplicationId;
    COMPLUS_APPTYPE Type;
    const(wchar)* ApplicationName;
    uint NumTrackedComponents;
    uint NumComponentInstances;
}

struct ComponentSummary
{
    Guid ApplicationInstanceId;
    Guid PartitionId;
    Guid ApplicationId;
    Guid Clsid;
    const(wchar)* ClassName;
    const(wchar)* ApplicationName;
}

struct ComponentStatistics
{
    uint NumInstances;
    uint NumBoundReferences;
    uint NumPooledObjects;
    uint NumObjectsInCall;
    uint AvgResponseTimeInMs;
    uint NumCallsCompletedRecent;
    uint NumCallsFailedRecent;
    uint NumCallsCompletedTotal;
    uint NumCallsFailedTotal;
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
}

struct ComponentHangMonitorInfo
{
    BOOL IsMonitored;
    BOOL TerminateOnHang;
    uint AvgCallThresholdInMs;
}

const GUID IID_IGetAppTrackerData = {0x507C3AC8, 0x3E12, 0x4CB0, [0x93, 0x66, 0x65, 0x3D, 0x3E, 0x05, 0x06, 0x38]};
@GUID(0x507C3AC8, 0x3E12, 0x4CB0, [0x93, 0x66, 0x65, 0x3D, 0x3E, 0x05, 0x06, 0x38]);
interface IGetAppTrackerData : IUnknown
{
    HRESULT GetApplicationProcesses(const(Guid)* PartitionId, const(Guid)* ApplicationId, uint Flags, uint* NumApplicationProcesses, char* ApplicationProcesses);
    HRESULT GetApplicationProcessDetails(const(Guid)* ApplicationInstanceId, uint ProcessId, uint Flags, ApplicationProcessSummary* Summary, ApplicationProcessStatistics* Statistics, ApplicationProcessRecycleInfo* RecycleInfo, int* AnyComponentsHangMonitored);
    HRESULT GetApplicationsInProcess(const(Guid)* ApplicationInstanceId, uint ProcessId, const(Guid)* PartitionId, uint Flags, uint* NumApplicationsInProcess, char* Applications);
    HRESULT GetComponentsInProcess(const(Guid)* ApplicationInstanceId, uint ProcessId, const(Guid)* PartitionId, const(Guid)* ApplicationId, uint Flags, uint* NumComponentsInProcess, char* Components);
    HRESULT GetComponentDetails(const(Guid)* ApplicationInstanceId, uint ProcessId, const(Guid)* Clsid, uint Flags, ComponentSummary* Summary, ComponentStatistics* Statistics, ComponentHangMonitorInfo* HangMonitorInfo);
    HRESULT GetTrackerDataAsCollectionObject(IUnknown* TopLevelCollection);
    HRESULT GetSuggestedPollingInterval(uint* PollingIntervalInSeconds);
}

const GUID IID_IDispenserManager = {0x5CB31E10, 0x2B5F, 0x11CF, [0xBE, 0x10, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x5CB31E10, 0x2B5F, 0x11CF, [0xBE, 0x10, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IDispenserManager : IUnknown
{
    HRESULT RegisterDispenser(IDispenserDriver __MIDL__IDispenserManager0000, ushort* szDispenserName, IHolder* __MIDL__IDispenserManager0001);
    HRESULT GetContext(uint* __MIDL__IDispenserManager0002, uint* __MIDL__IDispenserManager0003);
}

const GUID IID_IHolder = {0xBF6A1850, 0x2B45, 0x11CF, [0xBE, 0x10, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0xBF6A1850, 0x2B45, 0x11CF, [0xBE, 0x10, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IHolder : IUnknown
{
    HRESULT AllocResource(const(uint) __MIDL__IHolder0000, uint* __MIDL__IHolder0001);
    HRESULT FreeResource(const(uint) __MIDL__IHolder0002);
    HRESULT TrackResource(const(uint) __MIDL__IHolder0003);
    HRESULT TrackResourceS(ushort* __MIDL__IHolder0004);
    HRESULT UntrackResource(const(uint) __MIDL__IHolder0005, const(int) __MIDL__IHolder0006);
    HRESULT UntrackResourceS(ushort* __MIDL__IHolder0007, const(int) __MIDL__IHolder0008);
    HRESULT Close();
    HRESULT RequestDestroyResource(const(uint) __MIDL__IHolder0009);
}

const GUID IID_IDispenserDriver = {0x208B3651, 0x2B48, 0x11CF, [0xBE, 0x10, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x208B3651, 0x2B48, 0x11CF, [0xBE, 0x10, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IDispenserDriver : IUnknown
{
    HRESULT CreateResource(const(uint) ResTypId, uint* pResId, int* pSecsFreeBeforeDestroy);
    HRESULT RateResource(const(uint) ResTypId, const(uint) ResId, const(int) fRequiresTransactionEnlistment, uint* pRating);
    HRESULT EnlistResource(const(uint) ResId, const(uint) TransId);
    HRESULT ResetResource(const(uint) ResId);
    HRESULT DestroyResource(const(uint) ResId);
    HRESULT DestroyResourceS(ushort* ResId);
}

const GUID IID_ITransactionProxy = {0x02558374, 0xDF2E, 0x4DAE, [0xBD, 0x6B, 0x1D, 0x5C, 0x99, 0x4F, 0x9B, 0xDC]};
@GUID(0x02558374, 0xDF2E, 0x4DAE, [0xBD, 0x6B, 0x1D, 0x5C, 0x99, 0x4F, 0x9B, 0xDC]);
interface ITransactionProxy : IUnknown
{
    HRESULT Commit(Guid guid);
    HRESULT Abort();
    HRESULT Promote(ITransaction* pTransaction);
    HRESULT CreateVoter(ITransactionVoterNotifyAsync2 pTxAsync, ITransactionVoterBallotAsync2* ppBallot);
    HRESULT GetIsolationLevel(int* __MIDL__ITransactionProxy0000);
    HRESULT GetIdentifier(Guid* pbstrIdentifier);
    HRESULT IsReusable(int* pfIsReusable);
}

const GUID IID_IContextSecurityPerimeter = {0xA7549A29, 0xA7C4, 0x42E1, [0x8D, 0xC1, 0x7E, 0x3D, 0x74, 0x8D, 0xC2, 0x4A]};
@GUID(0xA7549A29, 0xA7C4, 0x42E1, [0x8D, 0xC1, 0x7E, 0x3D, 0x74, 0x8D, 0xC2, 0x4A]);
interface IContextSecurityPerimeter : IUnknown
{
    HRESULT GetPerimeterFlag(int* pFlag);
    HRESULT SetPerimeterFlag(BOOL fFlag);
}

const GUID IID_ITxProxyHolder = {0x13D86F31, 0x0139, 0x41AF, [0xBC, 0xAD, 0xC7, 0xD5, 0x04, 0x35, 0xFE, 0x9F]};
@GUID(0x13D86F31, 0x0139, 0x41AF, [0xBC, 0xAD, 0xC7, 0xD5, 0x04, 0x35, 0xFE, 0x9F]);
interface ITxProxyHolder : IUnknown
{
    void GetIdentifier(Guid* pGuidLtx);
}

const GUID IID_IObjectContext = {0x51372AE0, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AE0, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IObjectContext : IUnknown
{
    HRESULT CreateInstance(const(Guid)* rclsid, const(Guid)* riid, void** ppv);
    HRESULT SetComplete();
    HRESULT SetAbort();
    HRESULT EnableCommit();
    HRESULT DisableCommit();
    BOOL IsInTransaction();
    BOOL IsSecurityEnabled();
    HRESULT IsCallerInRole(BSTR bstrRole, int* pfIsInRole);
}

const GUID IID_IObjectControl = {0x51372AEC, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AEC, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IObjectControl : IUnknown
{
    HRESULT Activate();
    void Deactivate();
    BOOL CanBePooled();
}

const GUID IID_IEnumNames = {0x51372AF2, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AF2, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IEnumNames : IUnknown
{
    HRESULT Next(uint celt, BSTR* rgname, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNames* ppenum);
}

const GUID IID_ISecurityProperty = {0x51372AEA, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AEA, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface ISecurityProperty : IUnknown
{
    HRESULT GetDirectCreatorSID(void** pSID);
    HRESULT GetOriginalCreatorSID(void** pSID);
    HRESULT GetDirectCallerSID(void** pSID);
    HRESULT GetOriginalCallerSID(void** pSID);
    HRESULT ReleaseSID(void* pSID);
}

const GUID IID_ObjectControl = {0x7DC41850, 0x0C31, 0x11D0, [0x8B, 0x79, 0x00, 0xAA, 0x00, 0xB8, 0xA7, 0x90]};
@GUID(0x7DC41850, 0x0C31, 0x11D0, [0x8B, 0x79, 0x00, 0xAA, 0x00, 0xB8, 0xA7, 0x90]);
interface ObjectControl : IUnknown
{
    HRESULT Activate();
    HRESULT Deactivate();
    HRESULT CanBePooled(short* pbPoolable);
}

const GUID IID_ISharedProperty = {0x2A005C01, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]};
@GUID(0x2A005C01, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]);
interface ISharedProperty : IDispatch
{
    HRESULT get_Value(VARIANT* pVal);
    HRESULT put_Value(VARIANT val);
}

const GUID IID_ISharedPropertyGroup = {0x2A005C07, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]};
@GUID(0x2A005C07, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]);
interface ISharedPropertyGroup : IDispatch
{
    HRESULT CreatePropertyByPosition(int Index, short* fExists, ISharedProperty* ppProp);
    HRESULT get_PropertyByPosition(int Index, ISharedProperty* ppProperty);
    HRESULT CreateProperty(BSTR Name, short* fExists, ISharedProperty* ppProp);
    HRESULT get_Property(BSTR Name, ISharedProperty* ppProperty);
}

const GUID IID_ISharedPropertyGroupManager = {0x2A005C0D, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]};
@GUID(0x2A005C0D, 0xA5DE, 0x11CF, [0x9E, 0x66, 0x00, 0xAA, 0x00, 0xA3, 0xF4, 0x64]);
interface ISharedPropertyGroupManager : IDispatch
{
    HRESULT CreatePropertyGroup(BSTR Name, int* dwIsoMode, int* dwRelMode, short* fExists, ISharedPropertyGroup* ppGroup);
    HRESULT get_Group(BSTR Name, ISharedPropertyGroup* ppGroup);
    HRESULT get__NewEnum(IUnknown* retval);
}

const GUID IID_IObjectConstruct = {0x41C4F8B3, 0x7439, 0x11D2, [0x98, 0xCB, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x41C4F8B3, 0x7439, 0x11D2, [0x98, 0xCB, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IObjectConstruct : IUnknown
{
    HRESULT Construct(IDispatch pCtorObj);
}

const GUID IID_IObjectConstructString = {0x41C4F8B2, 0x7439, 0x11D2, [0x98, 0xCB, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x41C4F8B2, 0x7439, 0x11D2, [0x98, 0xCB, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IObjectConstructString : IDispatch
{
    HRESULT get_ConstructString(BSTR* pVal);
}

const GUID IID_IObjectContextActivity = {0x51372AFC, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AFC, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IObjectContextActivity : IUnknown
{
    HRESULT GetActivityId(Guid* pGUID);
}

const GUID IID_IObjectContextInfo = {0x75B52DDB, 0xE8ED, 0x11D1, [0x93, 0xAD, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0x75B52DDB, 0xE8ED, 0x11D1, [0x93, 0xAD, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
interface IObjectContextInfo : IUnknown
{
    BOOL IsInTransaction();
    HRESULT GetTransaction(IUnknown* pptrans);
    HRESULT GetTransactionId(Guid* pGuid);
    HRESULT GetActivityId(Guid* pGUID);
    HRESULT GetContextId(Guid* pGuid);
}

const GUID IID_IObjectContextInfo2 = {0x594BE71A, 0x4BC4, 0x438B, [0x91, 0x97, 0xCF, 0xD1, 0x76, 0x24, 0x8B, 0x09]};
@GUID(0x594BE71A, 0x4BC4, 0x438B, [0x91, 0x97, 0xCF, 0xD1, 0x76, 0x24, 0x8B, 0x09]);
interface IObjectContextInfo2 : IObjectContextInfo
{
    HRESULT GetPartitionId(Guid* pGuid);
    HRESULT GetApplicationId(Guid* pGuid);
    HRESULT GetApplicationInstanceId(Guid* pGuid);
}

const GUID IID_ITransactionStatus = {0x61F589E8, 0x3724, 0x4898, [0xA0, 0xA4, 0x66, 0x4A, 0xE9, 0xE1, 0xD1, 0xB4]};
@GUID(0x61F589E8, 0x3724, 0x4898, [0xA0, 0xA4, 0x66, 0x4A, 0xE9, 0xE1, 0xD1, 0xB4]);
interface ITransactionStatus : IUnknown
{
    HRESULT SetTransactionStatus(HRESULT hrStatus);
    HRESULT GetTransactionStatus(int* pHrStatus);
}

const GUID IID_IObjectContextTip = {0x92FD41CA, 0xBAD9, 0x11D2, [0x9A, 0x2D, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xC9]};
@GUID(0x92FD41CA, 0xBAD9, 0x11D2, [0x9A, 0x2D, 0x00, 0xC0, 0x4F, 0x79, 0x7B, 0xC9]);
interface IObjectContextTip : IUnknown
{
    HRESULT GetTipUrl(BSTR* pTipUrl);
}

const GUID IID_IPlaybackControl = {0x51372AFD, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AFD, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IPlaybackControl : IUnknown
{
    HRESULT FinalClientRetry();
    HRESULT FinalServerRetry();
}

const GUID IID_IGetContextProperties = {0x51372AF4, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AF4, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IGetContextProperties : IUnknown
{
    HRESULT Count(int* plCount);
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    HRESULT EnumNames(IEnumNames* ppenum);
}

enum TransactionVote
{
    TxCommit = 0,
    TxAbort = 1,
}

const GUID IID_IContextState = {0x3C05E54B, 0xA42A, 0x11D2, [0xAF, 0xC4, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x3C05E54B, 0xA42A, 0x11D2, [0xAF, 0xC4, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IContextState : IUnknown
{
    HRESULT SetDeactivateOnReturn(short bDeactivate);
    HRESULT GetDeactivateOnReturn(short* pbDeactivate);
    HRESULT SetMyTransactionVote(TransactionVote txVote);
    HRESULT GetMyTransactionVote(TransactionVote* ptxVote);
}

const GUID IID_IPoolManager = {0x0A469861, 0x5A91, 0x43A0, [0x99, 0xB6, 0xD5, 0xE1, 0x79, 0xBB, 0x06, 0x31]};
@GUID(0x0A469861, 0x5A91, 0x43A0, [0x99, 0xB6, 0xD5, 0xE1, 0x79, 0xBB, 0x06, 0x31]);
interface IPoolManager : IDispatch
{
    HRESULT ShutdownPool(BSTR CLSIDOrProgID);
}

const GUID IID_ISelectCOMLBServer = {0xDCF443F4, 0x3F8A, 0x4872, [0xB9, 0xF0, 0x36, 0x9A, 0x79, 0x6D, 0x12, 0xD6]};
@GUID(0xDCF443F4, 0x3F8A, 0x4872, [0xB9, 0xF0, 0x36, 0x9A, 0x79, 0x6D, 0x12, 0xD6]);
interface ISelectCOMLBServer : IUnknown
{
    HRESULT Init();
    HRESULT GetLBServer(IUnknown pUnk);
}

const GUID IID_ICOMLBArguments = {0x3A0F150F, 0x8EE5, 0x4B94, [0xB4, 0x0E, 0xAE, 0xF2, 0xF9, 0xE4, 0x2E, 0xD2]};
@GUID(0x3A0F150F, 0x8EE5, 0x4B94, [0xB4, 0x0E, 0xAE, 0xF2, 0xF9, 0xE4, 0x2E, 0xD2]);
interface ICOMLBArguments : IUnknown
{
    HRESULT GetCLSID(Guid* pCLSID);
    HRESULT SetCLSID(Guid* pCLSID);
    HRESULT GetMachineName(uint cchSvr, char* szServerName);
    HRESULT SetMachineName(uint cchSvr, char* szServerName);
}

const GUID IID_ICrmLogControl = {0xA0E174B3, 0xD26E, 0x11D2, [0x8F, 0x84, 0x00, 0x80, 0x5F, 0xC7, 0xBC, 0xD9]};
@GUID(0xA0E174B3, 0xD26E, 0x11D2, [0x8F, 0x84, 0x00, 0x80, 0x5F, 0xC7, 0xBC, 0xD9]);
interface ICrmLogControl : IUnknown
{
    HRESULT get_TransactionUOW(BSTR* pVal);
    HRESULT RegisterCompensator(const(wchar)* lpcwstrProgIdCompensator, const(wchar)* lpcwstrDescription, int lCrmRegFlags);
    HRESULT WriteLogRecordVariants(VARIANT* pLogRecord);
    HRESULT ForceLog();
    HRESULT ForgetLogRecord();
    HRESULT ForceTransactionToAbort();
    HRESULT WriteLogRecord(char* rgBlob, uint cBlob);
}

const GUID IID_ICrmCompensatorVariants = {0xF0BAF8E4, 0x7804, 0x11D1, [0x82, 0xE9, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]};
@GUID(0xF0BAF8E4, 0x7804, 0x11D1, [0x82, 0xE9, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]);
interface ICrmCompensatorVariants : IUnknown
{
    HRESULT SetLogControlVariants(ICrmLogControl pLogControl);
    HRESULT BeginPrepareVariants();
    HRESULT PrepareRecordVariants(VARIANT* pLogRecord, short* pbForget);
    HRESULT EndPrepareVariants(short* pbOkToPrepare);
    HRESULT BeginCommitVariants(short bRecovery);
    HRESULT CommitRecordVariants(VARIANT* pLogRecord, short* pbForget);
    HRESULT EndCommitVariants();
    HRESULT BeginAbortVariants(short bRecovery);
    HRESULT AbortRecordVariants(VARIANT* pLogRecord, short* pbForget);
    HRESULT EndAbortVariants();
}

struct CrmLogRecordRead
{
    uint dwCrmFlags;
    uint dwSequenceNumber;
    BLOB blobUserData;
}

const GUID IID_ICrmCompensator = {0xBBC01830, 0x8D3B, 0x11D1, [0x82, 0xEC, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]};
@GUID(0xBBC01830, 0x8D3B, 0x11D1, [0x82, 0xEC, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]);
interface ICrmCompensator : IUnknown
{
    HRESULT SetLogControl(ICrmLogControl pLogControl);
    HRESULT BeginPrepare();
    HRESULT PrepareRecord(CrmLogRecordRead crmLogRec, int* pfForget);
    HRESULT EndPrepare(int* pfOkToPrepare);
    HRESULT BeginCommit(BOOL fRecovery);
    HRESULT CommitRecord(CrmLogRecordRead crmLogRec, int* pfForget);
    HRESULT EndCommit();
    HRESULT BeginAbort(BOOL fRecovery);
    HRESULT AbortRecord(CrmLogRecordRead crmLogRec, int* pfForget);
    HRESULT EndAbort();
}

enum CrmTransactionState
{
    TxState_Active = 0,
    TxState_Committed = 1,
    TxState_Aborted = 2,
    TxState_Indoubt = 3,
}

const GUID IID_ICrmMonitorLogRecords = {0x70C8E441, 0xC7ED, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]};
@GUID(0x70C8E441, 0xC7ED, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]);
interface ICrmMonitorLogRecords : IUnknown
{
    HRESULT get_Count(int* pVal);
    HRESULT get_TransactionState(CrmTransactionState* pVal);
    HRESULT get_StructuredRecords(short* pVal);
    HRESULT GetLogRecord(uint dwIndex, CrmLogRecordRead* pCrmLogRec);
    HRESULT GetLogRecordVariants(VARIANT IndexNumber, VARIANT* pLogRecord);
}

const GUID IID_ICrmMonitorClerks = {0x70C8E442, 0xC7ED, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]};
@GUID(0x70C8E442, 0xC7ED, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]);
interface ICrmMonitorClerks : IDispatch
{
    HRESULT Item(VARIANT Index, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT ProgIdCompensator(VARIANT Index, VARIANT* pItem);
    HRESULT Description(VARIANT Index, VARIANT* pItem);
    HRESULT TransactionUOW(VARIANT Index, VARIANT* pItem);
    HRESULT ActivityId(VARIANT Index, VARIANT* pItem);
}

const GUID IID_ICrmMonitor = {0x70C8E443, 0xC7ED, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]};
@GUID(0x70C8E443, 0xC7ED, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]);
interface ICrmMonitor : IUnknown
{
    HRESULT GetClerks(ICrmMonitorClerks* pClerks);
    HRESULT HoldClerk(VARIANT Index, VARIANT* pItem);
}

const GUID IID_ICrmFormatLogRecords = {0x9C51D821, 0xC98B, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]};
@GUID(0x9C51D821, 0xC98B, 0x11D1, [0x82, 0xFB, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xE9]);
interface ICrmFormatLogRecords : IUnknown
{
    HRESULT GetColumnCount(int* plColumnCount);
    HRESULT GetColumnHeaders(VARIANT* pHeaders);
    HRESULT GetColumn(CrmLogRecordRead CrmLogRec, VARIANT* pFormattedLogRecord);
    HRESULT GetColumnVariants(VARIANT LogRecord, VARIANT* pFormattedLogRecord);
}

enum CSC_InheritanceConfig
{
    CSC_Inherit = 0,
    CSC_Ignore = 1,
}

enum CSC_ThreadPool
{
    CSC_ThreadPoolNone = 0,
    CSC_ThreadPoolInherit = 1,
    CSC_STAThreadPool = 2,
    CSC_MTAThreadPool = 3,
}

enum CSC_Binding
{
    CSC_NoBinding = 0,
    CSC_BindToPoolThread = 1,
}

enum CSC_TransactionConfig
{
    CSC_NoTransaction = 0,
    CSC_IfContainerIsTransactional = 1,
    CSC_CreateTransactionIfNecessary = 2,
    CSC_NewTransaction = 3,
}

enum CSC_SynchronizationConfig
{
    CSC_NoSynchronization = 0,
    CSC_IfContainerIsSynchronized = 1,
    CSC_NewSynchronizationIfNecessary = 2,
    CSC_NewSynchronization = 3,
}

enum CSC_TrackerConfig
{
    CSC_DontUseTracker = 0,
    CSC_UseTracker = 1,
}

enum CSC_PartitionConfig
{
    CSC_NoPartition = 0,
    CSC_InheritPartition = 1,
    CSC_NewPartition = 2,
}

enum CSC_IISIntrinsicsConfig
{
    CSC_NoIISIntrinsics = 0,
    CSC_InheritIISIntrinsics = 1,
}

enum CSC_COMTIIntrinsicsConfig
{
    CSC_NoCOMTIIntrinsics = 0,
    CSC_InheritCOMTIIntrinsics = 1,
}

enum CSC_SxsConfig
{
    CSC_NoSxs = 0,
    CSC_InheritSxs = 1,
    CSC_NewSxs = 2,
}

const GUID IID_IServiceIISIntrinsicsConfig = {0x1A0CF920, 0xD452, 0x46F4, [0xBC, 0x36, 0x48, 0x11, 0x8D, 0x54, 0xEA, 0x52]};
@GUID(0x1A0CF920, 0xD452, 0x46F4, [0xBC, 0x36, 0x48, 0x11, 0x8D, 0x54, 0xEA, 0x52]);
interface IServiceIISIntrinsicsConfig : IUnknown
{
    HRESULT IISIntrinsicsConfig(CSC_IISIntrinsicsConfig iisIntrinsicsConfig);
}

const GUID IID_IServiceComTIIntrinsicsConfig = {0x09E6831E, 0x04E1, 0x4ED4, [0x9D, 0x0F, 0xE8, 0xB1, 0x68, 0xBA, 0xFE, 0xAF]};
@GUID(0x09E6831E, 0x04E1, 0x4ED4, [0x9D, 0x0F, 0xE8, 0xB1, 0x68, 0xBA, 0xFE, 0xAF]);
interface IServiceComTIIntrinsicsConfig : IUnknown
{
    HRESULT ComTIIntrinsicsConfig(CSC_COMTIIntrinsicsConfig comtiIntrinsicsConfig);
}

const GUID IID_IServiceSxsConfig = {0xC7CD7379, 0xF3F2, 0x4634, [0x81, 0x1B, 0x70, 0x32, 0x81, 0xD7, 0x3E, 0x08]};
@GUID(0xC7CD7379, 0xF3F2, 0x4634, [0x81, 0x1B, 0x70, 0x32, 0x81, 0xD7, 0x3E, 0x08]);
interface IServiceSxsConfig : IUnknown
{
    HRESULT SxsConfig(CSC_SxsConfig scsConfig);
    HRESULT SxsName(const(wchar)* szSxsName);
    HRESULT SxsDirectory(const(wchar)* szSxsDirectory);
}

const GUID IID_ICheckSxsConfig = {0x0FF5A96F, 0x11FC, 0x47D1, [0xBA, 0xA6, 0x25, 0xDD, 0x34, 0x7E, 0x72, 0x42]};
@GUID(0x0FF5A96F, 0x11FC, 0x47D1, [0xBA, 0xA6, 0x25, 0xDD, 0x34, 0x7E, 0x72, 0x42]);
interface ICheckSxsConfig : IUnknown
{
    HRESULT IsSameSxsConfig(const(wchar)* wszSxsName, const(wchar)* wszSxsDirectory, const(wchar)* wszSxsAppName);
}

const GUID IID_IServiceInheritanceConfig = {0x92186771, 0xD3B4, 0x4D77, [0xA8, 0xEA, 0xEE, 0x84, 0x2D, 0x58, 0x6F, 0x35]};
@GUID(0x92186771, 0xD3B4, 0x4D77, [0xA8, 0xEA, 0xEE, 0x84, 0x2D, 0x58, 0x6F, 0x35]);
interface IServiceInheritanceConfig : IUnknown
{
    HRESULT ContainingContextTreatment(CSC_InheritanceConfig inheritanceConfig);
}

const GUID IID_IServiceThreadPoolConfig = {0x186D89BC, 0xF277, 0x4BCC, [0x80, 0xD5, 0x4D, 0xF7, 0xB8, 0x36, 0xEF, 0x4A]};
@GUID(0x186D89BC, 0xF277, 0x4BCC, [0x80, 0xD5, 0x4D, 0xF7, 0xB8, 0x36, 0xEF, 0x4A]);
interface IServiceThreadPoolConfig : IUnknown
{
    HRESULT SelectThreadPool(CSC_ThreadPool threadPool);
    HRESULT SetBindingInfo(CSC_Binding binding);
}

const GUID IID_IServiceTransactionConfigBase = {0x772B3FBE, 0x6FFD, 0x42FB, [0xB5, 0xF8, 0x8F, 0x9B, 0x26, 0x0F, 0x38, 0x10]};
@GUID(0x772B3FBE, 0x6FFD, 0x42FB, [0xB5, 0xF8, 0x8F, 0x9B, 0x26, 0x0F, 0x38, 0x10]);
interface IServiceTransactionConfigBase : IUnknown
{
    HRESULT ConfigureTransaction(CSC_TransactionConfig transactionConfig);
    HRESULT IsolationLevel(COMAdminTxIsolationLevelOptions option);
    HRESULT TransactionTimeout(uint ulTimeoutSec);
    HRESULT BringYourOwnTransaction(const(wchar)* szTipURL);
    HRESULT NewTransactionDescription(const(wchar)* szTxDesc);
}

const GUID IID_IServiceTransactionConfig = {0x59F4C2A3, 0xD3D7, 0x4A31, [0xB6, 0xE4, 0x6A, 0xB3, 0x17, 0x7C, 0x50, 0xB9]};
@GUID(0x59F4C2A3, 0xD3D7, 0x4A31, [0xB6, 0xE4, 0x6A, 0xB3, 0x17, 0x7C, 0x50, 0xB9]);
interface IServiceTransactionConfig : IServiceTransactionConfigBase
{
    HRESULT ConfigureBYOT(ITransaction pITxByot);
}

const GUID IID_IServiceSysTxnConfig = {0x33CAF1A1, 0xFCB8, 0x472B, [0xB4, 0x5E, 0x96, 0x74, 0x48, 0xDE, 0xD6, 0xD8]};
@GUID(0x33CAF1A1, 0xFCB8, 0x472B, [0xB4, 0x5E, 0x96, 0x74, 0x48, 0xDE, 0xD6, 0xD8]);
interface IServiceSysTxnConfig : IServiceTransactionConfig
{
    HRESULT ConfigureBYOTSysTxn(ITransactionProxy pTxProxy);
}

const GUID IID_IServiceSynchronizationConfig = {0xFD880E81, 0x6DCE, 0x4C58, [0xAF, 0x83, 0xA2, 0x08, 0x84, 0x6C, 0x00, 0x30]};
@GUID(0xFD880E81, 0x6DCE, 0x4C58, [0xAF, 0x83, 0xA2, 0x08, 0x84, 0x6C, 0x00, 0x30]);
interface IServiceSynchronizationConfig : IUnknown
{
    HRESULT ConfigureSynchronization(CSC_SynchronizationConfig synchConfig);
}

const GUID IID_IServiceTrackerConfig = {0x6C3A3E1D, 0x0BA6, 0x4036, [0xB7, 0x6F, 0xD0, 0x40, 0x4D, 0xB8, 0x16, 0xC9]};
@GUID(0x6C3A3E1D, 0x0BA6, 0x4036, [0xB7, 0x6F, 0xD0, 0x40, 0x4D, 0xB8, 0x16, 0xC9]);
interface IServiceTrackerConfig : IUnknown
{
    HRESULT TrackerConfig(CSC_TrackerConfig trackerConfig, const(wchar)* szTrackerAppName, const(wchar)* szTrackerCtxName);
}

const GUID IID_IServicePartitionConfig = {0x80182D03, 0x5EA4, 0x4831, [0xAE, 0x97, 0x55, 0xBE, 0xFF, 0xC2, 0xE5, 0x90]};
@GUID(0x80182D03, 0x5EA4, 0x4831, [0xAE, 0x97, 0x55, 0xBE, 0xFF, 0xC2, 0xE5, 0x90]);
interface IServicePartitionConfig : IUnknown
{
    HRESULT PartitionConfig(CSC_PartitionConfig partitionConfig);
    HRESULT PartitionID(const(Guid)* guidPartitionID);
}

const GUID IID_IServiceCall = {0xBD3E2E12, 0x42DD, 0x40F4, [0xA0, 0x9A, 0x95, 0xA5, 0x0C, 0x58, 0x30, 0x4B]};
@GUID(0xBD3E2E12, 0x42DD, 0x40F4, [0xA0, 0x9A, 0x95, 0xA5, 0x0C, 0x58, 0x30, 0x4B]);
interface IServiceCall : IUnknown
{
    HRESULT OnCall();
}

const GUID IID_IAsyncErrorNotify = {0xFE6777FB, 0xA674, 0x4177, [0x8F, 0x32, 0x6D, 0x70, 0x7E, 0x11, 0x34, 0x84]};
@GUID(0xFE6777FB, 0xA674, 0x4177, [0x8F, 0x32, 0x6D, 0x70, 0x7E, 0x11, 0x34, 0x84]);
interface IAsyncErrorNotify : IUnknown
{
    HRESULT OnError(HRESULT hr);
}

const GUID IID_IServiceActivity = {0x67532E0C, 0x9E2F, 0x4450, [0xA3, 0x54, 0x03, 0x56, 0x33, 0x94, 0x4E, 0x17]};
@GUID(0x67532E0C, 0x9E2F, 0x4450, [0xA3, 0x54, 0x03, 0x56, 0x33, 0x94, 0x4E, 0x17]);
interface IServiceActivity : IUnknown
{
    HRESULT SynchronousCall(IServiceCall pIServiceCall);
    HRESULT AsynchronousCall(IServiceCall pIServiceCall);
    HRESULT BindToCurrentThread();
    HRESULT UnbindFromThread();
}

const GUID IID_IThreadPoolKnobs = {0x51372AF7, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AF7, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IThreadPoolKnobs : IUnknown
{
    HRESULT GetMaxThreads(int* plcMaxThreads);
    HRESULT GetCurrentThreads(int* plcCurrentThreads);
    HRESULT SetMaxThreads(int lcMaxThreads);
    HRESULT GetDeleteDelay(int* pmsecDeleteDelay);
    HRESULT SetDeleteDelay(int msecDeleteDelay);
    HRESULT GetMaxQueuedRequests(int* plcMaxQueuedRequests);
    HRESULT GetCurrentQueuedRequests(int* plcCurrentQueuedRequests);
    HRESULT SetMaxQueuedRequests(int lcMaxQueuedRequests);
    HRESULT SetMinThreads(int lcMinThreads);
    HRESULT SetQueueDepth(int lcQueueDepth);
}

const GUID IID_IComStaThreadPoolKnobs = {0x324B64FA, 0x33B6, 0x11D2, [0x98, 0xB7, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]};
@GUID(0x324B64FA, 0x33B6, 0x11D2, [0x98, 0xB7, 0x00, 0xC0, 0x4F, 0x8E, 0xE1, 0xC4]);
interface IComStaThreadPoolKnobs : IUnknown
{
    HRESULT SetMinThreadCount(uint minThreads);
    HRESULT GetMinThreadCount(uint* minThreads);
    HRESULT SetMaxThreadCount(uint maxThreads);
    HRESULT GetMaxThreadCount(uint* maxThreads);
    HRESULT SetActivityPerThread(uint activitiesPerThread);
    HRESULT GetActivityPerThread(uint* activitiesPerThread);
    HRESULT SetActivityRatio(double activityRatio);
    HRESULT GetActivityRatio(double* activityRatio);
    HRESULT GetThreadCount(uint* pdwThreads);
    HRESULT GetQueueDepth(uint* pdwQDepth);
    HRESULT SetQueueDepth(int dwQDepth);
}

const GUID IID_IComMtaThreadPoolKnobs = {0xF9A76D2E, 0x76A5, 0x43EB, [0xA0, 0xC4, 0x49, 0xBE, 0xC8, 0xE4, 0x84, 0x80]};
@GUID(0xF9A76D2E, 0x76A5, 0x43EB, [0xA0, 0xC4, 0x49, 0xBE, 0xC8, 0xE4, 0x84, 0x80]);
interface IComMtaThreadPoolKnobs : IUnknown
{
    HRESULT MTASetMaxThreadCount(uint dwMaxThreads);
    HRESULT MTAGetMaxThreadCount(uint* pdwMaxThreads);
    HRESULT MTASetThrottleValue(uint dwThrottle);
    HRESULT MTAGetThrottleValue(uint* pdwThrottle);
}

const GUID IID_IComStaThreadPoolKnobs2 = {0x73707523, 0xFF9A, 0x4974, [0xBF, 0x84, 0x21, 0x08, 0xDC, 0x21, 0x37, 0x40]};
@GUID(0x73707523, 0xFF9A, 0x4974, [0xBF, 0x84, 0x21, 0x08, 0xDC, 0x21, 0x37, 0x40]);
interface IComStaThreadPoolKnobs2 : IComStaThreadPoolKnobs
{
    HRESULT GetMaxCPULoad(uint* pdwLoad);
    HRESULT SetMaxCPULoad(int pdwLoad);
    HRESULT GetCPUMetricEnabled(int* pbMetricEnabled);
    HRESULT SetCPUMetricEnabled(BOOL bMetricEnabled);
    HRESULT GetCreateThreadsAggressively(int* pbMetricEnabled);
    HRESULT SetCreateThreadsAggressively(BOOL bMetricEnabled);
    HRESULT GetMaxCSR(uint* pdwCSR);
    HRESULT SetMaxCSR(int dwCSR);
    HRESULT GetWaitTimeForThreadCleanup(uint* pdwThreadCleanupWaitTime);
    HRESULT SetWaitTimeForThreadCleanup(int dwThreadCleanupWaitTime);
}

const GUID IID_IProcessInitializer = {0x1113F52D, 0xDC7F, 0x4943, [0xAE, 0xD6, 0x88, 0xD0, 0x40, 0x27, 0xE3, 0x2A]};
@GUID(0x1113F52D, 0xDC7F, 0x4943, [0xAE, 0xD6, 0x88, 0xD0, 0x40, 0x27, 0xE3, 0x2A]);
interface IProcessInitializer : IUnknown
{
    HRESULT Startup(IUnknown punkProcessControl);
    HRESULT Shutdown();
}

const GUID IID_IServicePoolConfig = {0xA9690656, 0x5BCA, 0x470C, [0x84, 0x51, 0x25, 0x0C, 0x1F, 0x43, 0xA3, 0x3E]};
@GUID(0xA9690656, 0x5BCA, 0x470C, [0x84, 0x51, 0x25, 0x0C, 0x1F, 0x43, 0xA3, 0x3E]);
interface IServicePoolConfig : IUnknown
{
    HRESULT put_MaxPoolSize(uint dwMaxPool);
    HRESULT get_MaxPoolSize(uint* pdwMaxPool);
    HRESULT put_MinPoolSize(uint dwMinPool);
    HRESULT get_MinPoolSize(uint* pdwMinPool);
    HRESULT put_CreationTimeout(uint dwCreationTimeout);
    HRESULT get_CreationTimeout(uint* pdwCreationTimeout);
    HRESULT put_TransactionAffinity(BOOL fTxAffinity);
    HRESULT get_TransactionAffinity(int* pfTxAffinity);
    HRESULT put_ClassFactory(IClassFactory pFactory);
    HRESULT get_ClassFactory(IClassFactory* pFactory);
}

const GUID IID_IServicePool = {0xB302DF81, 0xEA45, 0x451E, [0x99, 0xA2, 0x09, 0xF9, 0xFD, 0x1B, 0x1E, 0x13]};
@GUID(0xB302DF81, 0xEA45, 0x451E, [0x99, 0xA2, 0x09, 0xF9, 0xFD, 0x1B, 0x1E, 0x13]);
interface IServicePool : IUnknown
{
    HRESULT Initialize(IUnknown pPoolConfig);
    HRESULT GetObjectA(const(Guid)* riid, void** ppv);
    HRESULT Shutdown();
}

const GUID IID_IManagedPooledObj = {0xC5DA4BEA, 0x1B42, 0x4437, [0x89, 0x26, 0xB6, 0xA3, 0x88, 0x60, 0xA7, 0x70]};
@GUID(0xC5DA4BEA, 0x1B42, 0x4437, [0x89, 0x26, 0xB6, 0xA3, 0x88, 0x60, 0xA7, 0x70]);
interface IManagedPooledObj : IUnknown
{
    HRESULT SetHeld(BOOL m_bHeld);
}

const GUID IID_IManagedPoolAction = {0xDA91B74E, 0x5388, 0x4783, [0x94, 0x9D, 0xC1, 0xCD, 0x5F, 0xB0, 0x05, 0x06]};
@GUID(0xDA91B74E, 0x5388, 0x4783, [0x94, 0x9D, 0xC1, 0xCD, 0x5F, 0xB0, 0x05, 0x06]);
interface IManagedPoolAction : IUnknown
{
    HRESULT LastRelease();
}

const GUID IID_IManagedObjectInfo = {0x1427C51A, 0x4584, 0x49D8, [0x90, 0xA0, 0xC5, 0x0D, 0x80, 0x86, 0xCB, 0xE9]};
@GUID(0x1427C51A, 0x4584, 0x49D8, [0x90, 0xA0, 0xC5, 0x0D, 0x80, 0x86, 0xCB, 0xE9]);
interface IManagedObjectInfo : IUnknown
{
    HRESULT GetIUnknown(IUnknown* pUnk);
    HRESULT GetIObjectControl(IObjectControl* pCtrl);
    HRESULT SetInPool(BOOL bInPool, IManagedPooledObj pPooledObj);
    HRESULT SetWrapperStrength(BOOL bStrong);
}

const GUID IID_IAppDomainHelper = {0xC7B67079, 0x8255, 0x42C6, [0x9E, 0xC0, 0x69, 0x94, 0xA3, 0x54, 0x87, 0x80]};
@GUID(0xC7B67079, 0x8255, 0x42C6, [0x9E, 0xC0, 0x69, 0x94, 0xA3, 0x54, 0x87, 0x80]);
interface IAppDomainHelper : IDispatch
{
    HRESULT Initialize(IUnknown pUnkAD, HRESULT***** __MIDL__IAppDomainHelper0000, void* pPool);
    HRESULT DoCallback(IUnknown pUnkAD, HRESULT***** __MIDL__IAppDomainHelper0001, void* pPool);
}

const GUID IID_IAssemblyLocator = {0x391FFBB9, 0xA8EE, 0x432A, [0xAB, 0xC8, 0xBA, 0xA2, 0x38, 0xDA, 0xB9, 0x0F]};
@GUID(0x391FFBB9, 0xA8EE, 0x432A, [0xAB, 0xC8, 0xBA, 0xA2, 0x38, 0xDA, 0xB9, 0x0F]);
interface IAssemblyLocator : IDispatch
{
    HRESULT GetModules(BSTR applicationDir, BSTR applicationName, BSTR assemblyName, SAFEARRAY** pModules);
}

const GUID IID_IManagedActivationEvents = {0xA5F325AF, 0x572F, 0x46DA, [0xB8, 0xAB, 0x82, 0x7C, 0x3D, 0x95, 0xD9, 0x9E]};
@GUID(0xA5F325AF, 0x572F, 0x46DA, [0xB8, 0xAB, 0x82, 0x7C, 0x3D, 0x95, 0xD9, 0x9E]);
interface IManagedActivationEvents : IUnknown
{
    HRESULT CreateManagedStub(IManagedObjectInfo pInfo, BOOL fDist);
    HRESULT DestroyManagedStub(IManagedObjectInfo pInfo);
}

const GUID IID_ISendMethodEvents = {0x2732FD59, 0xB2B4, 0x4D44, [0x87, 0x8C, 0x8B, 0x8F, 0x09, 0x62, 0x60, 0x08]};
@GUID(0x2732FD59, 0xB2B4, 0x4D44, [0x87, 0x8C, 0x8B, 0x8F, 0x09, 0x62, 0x60, 0x08]);
interface ISendMethodEvents : IUnknown
{
    HRESULT SendMethodCall(const(void)* pIdentity, const(Guid)* riid, uint dwMeth);
    HRESULT SendMethodReturn(const(void)* pIdentity, const(Guid)* riid, uint dwMeth, HRESULT hrCall, HRESULT hrServer);
}

const GUID IID_ITransactionResourcePool = {0xC5FEB7C1, 0x346A, 0x11D1, [0xB1, 0xCC, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0xC5FEB7C1, 0x346A, 0x11D1, [0xB1, 0xCC, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
interface ITransactionResourcePool : IUnknown
{
    HRESULT PutResource(IObjPool pPool, IUnknown pUnk);
    HRESULT GetResource(IObjPool pPool, IUnknown* ppUnk);
}

const GUID IID_IMTSCall = {0x51372AEF, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AEF, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IMTSCall : IUnknown
{
    HRESULT OnCall();
}

const GUID IID_IContextProperties = {0xD396DA85, 0xBF8F, 0x11D1, [0xBB, 0xAE, 0x00, 0xC0, 0x4F, 0xC2, 0xFA, 0x5F]};
@GUID(0xD396DA85, 0xBF8F, 0x11D1, [0xBB, 0xAE, 0x00, 0xC0, 0x4F, 0xC2, 0xFA, 0x5F]);
interface IContextProperties : IUnknown
{
    HRESULT Count(int* plCount);
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    HRESULT EnumNames(IEnumNames* ppenum);
    HRESULT SetProperty(BSTR name, VARIANT property);
    HRESULT RemoveProperty(BSTR name);
}

const GUID IID_IObjPool = {0x7D8805A0, 0x2EA7, 0x11D1, [0xB1, 0xCC, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]};
@GUID(0x7D8805A0, 0x2EA7, 0x11D1, [0xB1, 0xCC, 0x00, 0xAA, 0x00, 0xBA, 0x32, 0x58]);
interface IObjPool : IUnknown
{
    void Reserved1();
    void Reserved2();
    void Reserved3();
    void Reserved4();
    void PutEndTx(IUnknown pObj);
    void Reserved5();
    void Reserved6();
}

const GUID IID_ITransactionProperty = {0x788EA814, 0x87B1, 0x11D1, [0xBB, 0xA6, 0x00, 0xC0, 0x4F, 0xC2, 0xFA, 0x5F]};
@GUID(0x788EA814, 0x87B1, 0x11D1, [0xBB, 0xA6, 0x00, 0xC0, 0x4F, 0xC2, 0xFA, 0x5F]);
interface ITransactionProperty : IUnknown
{
    void Reserved1();
    void Reserved2();
    void Reserved3();
    void Reserved4();
    void Reserved5();
    void Reserved6();
    void Reserved7();
    void Reserved8();
    void Reserved9();
    HRESULT GetTransactionResourcePool(ITransactionResourcePool* ppTxPool);
    void Reserved10();
    void Reserved11();
    void Reserved12();
    void Reserved13();
    void Reserved14();
    void Reserved15();
    void Reserved16();
    void Reserved17();
}

const GUID IID_IMTSActivity = {0x51372AF0, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]};
@GUID(0x51372AF0, 0xCAE7, 0x11CF, [0xBE, 0x81, 0x00, 0xAA, 0x00, 0xA2, 0xFA, 0x25]);
interface IMTSActivity : IUnknown
{
    HRESULT SynchronousCall(IMTSCall pCall);
    HRESULT AsyncCall(IMTSCall pCall);
    void Reserved1();
    HRESULT BindToCurrentThread();
    HRESULT UnbindFromThread();
}

enum __MIDL___MIDL_itf_autosvcs_0001_0150_0001
{
    mtsErrCtxAborted = -2147164158,
    mtsErrCtxAborting = -2147164157,
    mtsErrCtxNoContext = -2147164156,
    mtsErrCtxNotRegistered = -2147164155,
    mtsErrCtxSynchTimeout = -2147164154,
    mtsErrCtxOldReference = -2147164153,
    mtsErrCtxRoleNotFound = -2147164148,
    mtsErrCtxNoSecurity = -2147164147,
    mtsErrCtxWrongThread = -2147164146,
    mtsErrCtxTMNotAvailable = -2147164145,
    comQCErrApplicationNotQueued = -2146368000,
    comQCErrNoQueueableInterfaces = -2146367999,
    comQCErrQueuingServiceNotAvailable = -2146367998,
    comQCErrQueueTransactMismatch = -2146367997,
    comqcErrRecorderMarshalled = -2146367996,
    comqcErrOutParam = -2146367995,
    comqcErrRecorderNotTrusted = -2146367994,
    comqcErrPSLoad = -2146367993,
    comqcErrMarshaledObjSameTxn = -2146367992,
    comqcErrInvalidMessage = -2146367920,
    comqcErrMsmqSidUnavailable = -2146367919,
    comqcErrWrongMsgExtension = -2146367918,
    comqcErrMsmqServiceUnavailable = -2146367917,
    comqcErrMsgNotAuthenticated = -2146367916,
    comqcErrMsmqConnectorUsed = -2146367915,
    comqcErrBadMarshaledObject = -2146367914,
}

enum __MIDL___MIDL_itf_autosvcs_0001_0159_0001
{
    LockSetGet = 0,
    LockMethod = 1,
}

enum __MIDL___MIDL_itf_autosvcs_0001_0159_0002
{
    Standard = 0,
    Process = 1,
}

enum CRMFLAGS
{
    CRMFLAG_FORGETTARGET = 1,
    CRMFLAG_WRITTENDURINGPREPARE = 2,
    CRMFLAG_WRITTENDURINGCOMMIT = 4,
    CRMFLAG_WRITTENDURINGABORT = 8,
    CRMFLAG_WRITTENDURINGRECOVERY = 16,
    CRMFLAG_WRITTENDURINGREPLAY = 32,
    CRMFLAG_REPLAYINPROGRESS = 64,
}

enum CRMREGFLAGS
{
    CRMREGFLAG_PREPAREPHASE = 1,
    CRMREGFLAG_COMMITPHASE = 2,
    CRMREGFLAG_ABORTPHASE = 4,
    CRMREGFLAG_ALLPHASES = 7,
    CRMREGFLAG_FAILIFINDOUBTSREMAIN = 16,
}

const GUID CLSID_CEventSystem = {0x4E14FBA2, 0x2E22, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]};
@GUID(0x4E14FBA2, 0x2E22, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]);
struct CEventSystem;

const GUID CLSID_CEventPublisher = {0xAB944620, 0x79C6, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]};
@GUID(0xAB944620, 0x79C6, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]);
struct CEventPublisher;

const GUID CLSID_CEventClass = {0xCDBEC9C0, 0x7A68, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]};
@GUID(0xCDBEC9C0, 0x7A68, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]);
struct CEventClass;

const GUID CLSID_CEventSubscription = {0x7542E960, 0x79C7, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]};
@GUID(0x7542E960, 0x79C7, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]);
struct CEventSubscription;

const GUID CLSID_EventObjectChange = {0xD0565000, 0x9DF4, 0x11D1, [0xA2, 0x81, 0x00, 0xC0, 0x4F, 0xCA, 0x0A, 0xA7]};
@GUID(0xD0565000, 0x9DF4, 0x11D1, [0xA2, 0x81, 0x00, 0xC0, 0x4F, 0xCA, 0x0A, 0xA7]);
struct EventObjectChange;

const GUID CLSID_EventObjectChange2 = {0xBB07BACD, 0xCD56, 0x4E63, [0xA8, 0xFF, 0xCB, 0xF0, 0x35, 0x5F, 0xB9, 0xF4]};
@GUID(0xBB07BACD, 0xCD56, 0x4E63, [0xA8, 0xFF, 0xCB, 0xF0, 0x35, 0x5F, 0xB9, 0xF4]);
struct EventObjectChange2;

const GUID IID_IEventSystem = {0x4E14FB9F, 0x2E22, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]};
@GUID(0x4E14FB9F, 0x2E22, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]);
interface IEventSystem : IDispatch
{
    HRESULT Query(BSTR progID, BSTR queryCriteria, int* errorIndex, IUnknown* ppInterface);
    HRESULT Store(BSTR ProgID, IUnknown pInterface);
    HRESULT Remove(BSTR progID, BSTR queryCriteria, int* errorIndex);
    HRESULT get_EventObjectChangeEventClassID(BSTR* pbstrEventClassID);
    HRESULT QueryS(BSTR progID, BSTR queryCriteria, IUnknown* ppInterface);
    HRESULT RemoveS(BSTR progID, BSTR queryCriteria);
}

const GUID IID_IEventClass = {0xFB2B72A0, 0x7A68, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]};
@GUID(0xFB2B72A0, 0x7A68, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]);
interface IEventClass : IDispatch
{
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    HRESULT get_EventClassName(BSTR* pbstrEventClassName);
    HRESULT put_EventClassName(BSTR bstrEventClassName);
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    HRESULT get_FiringInterfaceID(BSTR* pbstrFiringInterfaceID);
    HRESULT put_FiringInterfaceID(BSTR bstrFiringInterfaceID);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_CustomConfigCLSID(BSTR* pbstrCustomConfigCLSID);
    HRESULT put_CustomConfigCLSID(BSTR bstrCustomConfigCLSID);
    HRESULT get_TypeLib(BSTR* pbstrTypeLib);
    HRESULT put_TypeLib(BSTR bstrTypeLib);
}

const GUID IID_IEventClass2 = {0xFB2B72A1, 0x7A68, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]};
@GUID(0xFB2B72A1, 0x7A68, 0x11D1, [0x88, 0xF9, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]);
interface IEventClass2 : IEventClass
{
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    HRESULT get_MultiInterfacePublisherFilterCLSID(BSTR* pbstrPubFilCLSID);
    HRESULT put_MultiInterfacePublisherFilterCLSID(BSTR bstrPubFilCLSID);
    HRESULT get_AllowInprocActivation(int* pfAllowInprocActivation);
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    HRESULT get_FireInParallel(int* pfFireInParallel);
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

const GUID IID_IEventSubscription = {0x4A6B0E15, 0x2E38, 0x11D1, [0x99, 0x65, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]};
@GUID(0x4A6B0E15, 0x2E38, 0x11D1, [0x99, 0x65, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]);
interface IEventSubscription : IDispatch
{
    HRESULT get_SubscriptionID(BSTR* pbstrSubscriptionID);
    HRESULT put_SubscriptionID(BSTR bstrSubscriptionID);
    HRESULT get_SubscriptionName(BSTR* pbstrSubscriptionName);
    HRESULT put_SubscriptionName(BSTR bstrSubscriptionName);
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    HRESULT get_MethodName(BSTR* pbstrMethodName);
    HRESULT put_MethodName(BSTR bstrMethodName);
    HRESULT get_SubscriberCLSID(BSTR* pbstrSubscriberCLSID);
    HRESULT put_SubscriberCLSID(BSTR bstrSubscriberCLSID);
    HRESULT get_SubscriberInterface(IUnknown* ppSubscriberInterface);
    HRESULT put_SubscriberInterface(IUnknown pSubscriberInterface);
    HRESULT get_PerUser(int* pfPerUser);
    HRESULT put_PerUser(BOOL fPerUser);
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    HRESULT get_Enabled(int* pfEnabled);
    HRESULT put_Enabled(BOOL fEnabled);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_MachineName(BSTR* pbstrMachineName);
    HRESULT put_MachineName(BSTR bstrMachineName);
    HRESULT GetPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT PutPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT RemovePublisherProperty(BSTR bstrPropertyName);
    HRESULT GetPublisherPropertyCollection(IEventObjectCollection* collection);
    HRESULT GetSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT PutSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT RemoveSubscriberProperty(BSTR bstrPropertyName);
    HRESULT GetSubscriberPropertyCollection(IEventObjectCollection* collection);
    HRESULT get_InterfaceID(BSTR* pbstrInterfaceID);
    HRESULT put_InterfaceID(BSTR bstrInterfaceID);
}

const GUID IID_IFiringControl = {0xE0498C93, 0x4EFE, 0x11D1, [0x99, 0x71, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]};
@GUID(0xE0498C93, 0x4EFE, 0x11D1, [0x99, 0x71, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]);
interface IFiringControl : IDispatch
{
    HRESULT FireSubscription(IEventSubscription subscription);
}

const GUID IID_IPublisherFilter = {0x465E5CC0, 0x7B26, 0x11D1, [0x88, 0xFB, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]};
@GUID(0x465E5CC0, 0x7B26, 0x11D1, [0x88, 0xFB, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]);
interface IPublisherFilter : IUnknown
{
    HRESULT Initialize(BSTR methodName, IDispatch dispUserDefined);
    HRESULT PrepareToFire(BSTR methodName, IFiringControl firingControl);
}

const GUID IID_IMultiInterfacePublisherFilter = {0x465E5CC1, 0x7B26, 0x11D1, [0x88, 0xFB, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]};
@GUID(0x465E5CC1, 0x7B26, 0x11D1, [0x88, 0xFB, 0x00, 0x80, 0xC7, 0xD7, 0x71, 0xBF]);
interface IMultiInterfacePublisherFilter : IUnknown
{
    HRESULT Initialize(IMultiInterfaceEventControl pEIC);
    HRESULT PrepareToFire(const(Guid)* iid, BSTR methodName, IFiringControl firingControl);
}

const GUID IID_IEventObjectChange = {0xF4A07D70, 0x2E25, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]};
@GUID(0xF4A07D70, 0x2E25, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]);
interface IEventObjectChange : IUnknown
{
    HRESULT ChangedSubscription(EOC_ChangeType changeType, BSTR bstrSubscriptionID);
    HRESULT ChangedEventClass(EOC_ChangeType changeType, BSTR bstrEventClassID);
    HRESULT ChangedPublisher(EOC_ChangeType changeType, BSTR bstrPublisherID);
}

struct COMEVENTSYSCHANGEINFO
{
    uint cbSize;
    EOC_ChangeType changeType;
    BSTR objectId;
    BSTR partitionId;
    BSTR applicationId;
    Guid reserved;
}

const GUID IID_IEventObjectChange2 = {0x7701A9C3, 0xBD68, 0x438F, [0x83, 0xE0, 0x67, 0xBF, 0x4F, 0x53, 0xA4, 0x22]};
@GUID(0x7701A9C3, 0xBD68, 0x438F, [0x83, 0xE0, 0x67, 0xBF, 0x4F, 0x53, 0xA4, 0x22]);
interface IEventObjectChange2 : IUnknown
{
    HRESULT ChangedSubscription(COMEVENTSYSCHANGEINFO* pInfo);
    HRESULT ChangedEventClass(COMEVENTSYSCHANGEINFO* pInfo);
}

const GUID IID_IEnumEventObject = {0xF4A07D63, 0x2E25, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]};
@GUID(0xF4A07D63, 0x2E25, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]);
interface IEnumEventObject : IUnknown
{
    HRESULT Clone(IEnumEventObject* ppInterface);
    HRESULT Next(uint cReqElem, char* ppInterface, uint* cRetElem);
    HRESULT Reset();
    HRESULT Skip(uint cSkipElem);
}

const GUID IID_IEventObjectCollection = {0xF89AC270, 0xD4EB, 0x11D1, [0xB6, 0x82, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x16]};
@GUID(0xF89AC270, 0xD4EB, 0x11D1, [0xB6, 0x82, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x16]);
interface IEventObjectCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnkEnum);
    HRESULT get_Item(BSTR objectID, VARIANT* pItem);
    HRESULT get_NewEnum(IEnumEventObject* ppEnum);
    HRESULT get_Count(int* pCount);
    HRESULT Add(VARIANT* item, BSTR objectID);
    HRESULT Remove(BSTR objectID);
}

const GUID IID_IEventControl = {0x0343E2F4, 0x86F6, 0x11D1, [0xB7, 0x60, 0x00, 0xC0, 0x4F, 0xB9, 0x26, 0xAF]};
@GUID(0x0343E2F4, 0x86F6, 0x11D1, [0xB7, 0x60, 0x00, 0xC0, 0x4F, 0xB9, 0x26, 0xAF]);
interface IEventControl : IDispatch
{
    HRESULT SetPublisherFilter(BSTR methodName, IPublisherFilter pPublisherFilter);
    HRESULT get_AllowInprocActivation(int* pfAllowInprocActivation);
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    HRESULT GetSubscriptions(BSTR methodName, BSTR optionalCriteria, int* optionalErrorIndex, IEventObjectCollection* ppCollection);
    HRESULT SetDefaultQuery(BSTR methodName, BSTR criteria, int* errorIndex);
}

const GUID IID_IMultiInterfaceEventControl = {0x0343E2F5, 0x86F6, 0x11D1, [0xB7, 0x60, 0x00, 0xC0, 0x4F, 0xB9, 0x26, 0xAF]};
@GUID(0x0343E2F5, 0x86F6, 0x11D1, [0xB7, 0x60, 0x00, 0xC0, 0x4F, 0xB9, 0x26, 0xAF]);
interface IMultiInterfaceEventControl : IUnknown
{
    HRESULT SetMultiInterfacePublisherFilter(IMultiInterfacePublisherFilter classFilter);
    HRESULT GetSubscriptions(const(Guid)* eventIID, BSTR bstrMethodName, BSTR optionalCriteria, int* optionalErrorIndex, IEventObjectCollection* ppCollection);
    HRESULT SetDefaultQuery(const(Guid)* eventIID, BSTR bstrMethodName, BSTR bstrCriteria, int* errorIndex);
    HRESULT get_AllowInprocActivation(int* pfAllowInprocActivation);
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    HRESULT get_FireInParallel(int* pfFireInParallel);
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

const GUID IID_IDontSupportEventSubscription = {0x784121F1, 0x62A6, 0x4B89, [0x85, 0x5F, 0xD6, 0x5F, 0x29, 0x6D, 0xE8, 0x3A]};
@GUID(0x784121F1, 0x62A6, 0x4B89, [0x85, 0x5F, 0xD6, 0x5F, 0x29, 0x6D, 0xE8, 0x3A]);
interface IDontSupportEventSubscription : IUnknown
{
}

