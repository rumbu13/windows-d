module windows.grouppolicymanagementconsole;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT, VARIANT;
public import windows.com : HRESULT;

extern(Windows):


// Enums


enum : int
{
    rsopUnknown  = 0x00000000,
    rsopPlanning = 0x00000001,
    rsopLogging  = 0x00000002,
}
alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0001 = int;

enum GPMPermissionType : int
{
    permGPOApply                 = 0x00010000,
    permGPORead                  = 0x00010100,
    permGPOEdit                  = 0x00010101,
    permGPOEditSecurityAndDelete = 0x00010102,
    permGPOCustom                = 0x00010103,
    permWMIFilterEdit            = 0x00020000,
    permWMIFilterFullControl     = 0x00020001,
    permWMIFilterCustom          = 0x00020002,
    permSOMLink                  = 0x001c0000,
    permSOMLogging               = 0x00180100,
    permSOMPlanning              = 0x00180200,
    permSOMWMICreate             = 0x00100300,
    permSOMWMIFullControl        = 0x00100301,
    permSOMGPOCreate             = 0x00100400,
    permStarterGPORead           = 0x00030500,
    permStarterGPOEdit           = 0x00030501,
    permStarterGPOFullControl    = 0x00030502,
    permStarterGPOCustom         = 0x00030503,
    permSOMStarterGPOCreate      = 0x00100500,
}

enum GPMSearchProperty : int
{
    gpoPermissions                 = 0x00000000,
    gpoEffectivePermissions        = 0x00000001,
    gpoDisplayName                 = 0x00000002,
    gpoWMIFilter                   = 0x00000003,
    gpoID                          = 0x00000004,
    gpoComputerExtensions          = 0x00000005,
    gpoUserExtensions              = 0x00000006,
    somLinks                       = 0x00000007,
    gpoDomain                      = 0x00000008,
    backupMostRecent               = 0x00000009,
    starterGPOPermissions          = 0x0000000a,
    starterGPOEffectivePermissions = 0x0000000b,
    starterGPODisplayName          = 0x0000000c,
    starterGPOID                   = 0x0000000d,
    starterGPODomain               = 0x0000000e,
}

enum : int
{
    opEquals      = 0x00000000,
    opContains    = 0x00000001,
    opNotContains = 0x00000002,
    opNotEquals   = 0x00000003,
}
alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0004 = int;

enum : int
{
    repXML                    = 0x00000000,
    repHTML                   = 0x00000001,
    repInfraXML               = 0x00000002,
    repInfraRefreshXML        = 0x00000003,
    repClientHealthXML        = 0x00000004,
    repClientHealthRefreshXML = 0x00000005,
}
alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0005 = int;

enum : int
{
    typeUser           = 0x00000000,
    typeComputer       = 0x00000001,
    typeLocalGroup     = 0x00000002,
    typeGlobalGroup    = 0x00000003,
    typeUniversalGroup = 0x00000004,
    typeUNCPath        = 0x00000005,
    typeUnknown        = 0x00000006,
}
alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0006 = int;

enum : int
{
    opDestinationSameAsSource   = 0x00000000,
    opDestinationNone           = 0x00000001,
    opDestinationByRelativeName = 0x00000002,
    opDestinationSet            = 0x00000003,
}
alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0007 = int;

enum GPMReportingOptions : int
{
    opReportLegacy   = 0x00000000,
    opReportComments = 0x00000001,
}

enum : int
{
    somSite   = 0x00000000,
    somDomain = 0x00000001,
    somOU     = 0x00000002,
}
alias __MIDL_IGPMSOM_0001 = int;

enum GPMBackupType : int
{
    typeGPO        = 0x00000000,
    typeStarterGPO = 0x00000001,
}

enum GPMStarterGPOType : int
{
    typeSystem = 0x00000000,
    typeCustom = 0x00000001,
}

// Interfaces

@GUID("F5694708-88FE-4B35-BABF-E56162D5FBC8")
struct GPM;

@GUID("710901BE-1050-4CB1-838A-C5CFF259E183")
struct GPMDomain;

@GUID("229F5C42-852C-4B30-945F-C522BE9BD386")
struct GPMSitesContainer;

@GUID("FCE4A59D-0F21-4AFA-B859-E6D0C62CD10C")
struct GPMBackupDir;

@GUID("32D93FAC-450E-44CF-829C-8B22FF6BDAE1")
struct GPMSOM;

@GUID("17AACA26-5CE0-44FA-8CC0-5259E6483566")
struct GPMSearchCriteria;

@GUID("5871A40A-E9C0-46EC-913E-944EF9225A94")
struct GPMPermission;

@GUID("547A5E8F-9162-4516-A4DF-9DDB9686D846")
struct GPMSecurityInfo;

@GUID("ED1A54B8-5EFA-482A-93C0-8AD86F0D68C3")
struct GPMBackup;

@GUID("EB8F035B-70DB-4A9F-9676-37C25994E9DC")
struct GPMBackupCollection;

@GUID("24C1F147-3720-4F5B-A9C3-06B4E4F931D2")
struct GPMSOMCollection;

@GUID("626745D8-0DEA-4062-BF60-CFC5B1CA1286")
struct GPMWMIFilter;

@GUID("74DC6D28-E820-47D6-A0B8-F08D93D7FA33")
struct GPMWMIFilterCollection;

@GUID("489B0CAF-9EC2-4EB7-91F5-B6F71D43DA8C")
struct GPMRSOP;

@GUID("D2CE2994-59B5-4064-B581-4D68486A16C4")
struct GPMGPO;

@GUID("7A057325-832D-4DE3-A41F-C780436A4E09")
struct GPMGPOCollection;

@GUID("C1DF9880-5303-42C6-8A3C-0488E1BF7364")
struct GPMGPOLink;

@GUID("F6ED581A-49A5-47E2-B771-FD8DC02B6259")
struct GPMGPOLinksCollection;

@GUID("372796A9-76EC-479D-AD6C-556318ED5F9D")
struct GPMAsyncCancel;

@GUID("2824E4BE-4BCC-4CAC-9E60-0E3ED7F12496")
struct GPMStatusMsgCollection;

@GUID("4B77CC94-D255-409B-BC62-370881715A19")
struct GPMStatusMessage;

@GUID("C54A700D-19B6-4211-BCB0-E8E2475E471E")
struct GPMTrustee;

@GUID("C1A2E70E-659C-4B1A-940B-F88B0AF9C8A4")
struct GPMClientSideExtension;

@GUID("CF92B828-2D44-4B61-B10A-B327AFD42DA8")
struct GPMCSECollection;

@GUID("3855E880-CD9E-4D0C-9EAF-1579283A1888")
struct GPMConstants;

@GUID("92101AC0-9287-4206-A3B2-4BDB73D225F6")
struct GPMResult;

@GUID("0CF75D5B-A3A1-4C55-B4FE-9E149C41F66D")
struct GPMMapEntryCollection;

@GUID("8C975253-5431-4471-B35D-0626C928258A")
struct GPMMapEntry;

@GUID("55AF4043-2A06-4F72-ABEF-631B44079C76")
struct GPMMigrationTable;

@GUID("E8C0988A-CF03-4C5B-8BE2-2AA9AD32AADA")
struct GPMBackupDirEx;

@GUID("E75EA59D-1AEB-4CB5-A78A-281DAA582406")
struct GPMStarterGPOBackupCollection;

@GUID("389E400A-D8EF-455B-A861-5F9CA34A6A02")
struct GPMStarterGPOBackup;

@GUID("ECF1D454-71DA-4E2F-A8C0-8185465911D9")
struct GPMTemplate;

@GUID("82F8AA8B-49BA-43B2-956E-3397F9B94C3A")
struct GPMStarterGPOCollection;

@GUID("F5FAE809-3BD6-4DA9-A65E-17665B41D763")
interface IGPM : IDispatch
{
    HRESULT GetDomain(BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, IGPMDomain* pIGPMDomain);
    HRESULT GetBackupDir(BSTR bstrBackupDir, IGPMBackupDir* pIGPMBackupDir);
    HRESULT GetSitesContainer(BSTR bstrForest, BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, 
                              IGPMSitesContainer* ppIGPMSitesContainer);
    HRESULT GetRSOP(__MIDL___MIDL_itf_gpmgmt_0000_0000_0001 gpmRSoPMode, BSTR bstrNamespace, int lFlags, 
                    IGPMRSOP* ppIGPMRSOP);
    HRESULT CreatePermission(BSTR bstrTrustee, GPMPermissionType perm, short bInheritable, IGPMPermission* ppPerm);
    HRESULT CreateSearchCriteria(IGPMSearchCriteria* ppIGPMSearchCriteria);
    HRESULT CreateTrustee(BSTR bstrTrustee, IGPMTrustee* ppIGPMTrustee);
    HRESULT GetClientSideExtensions(IGPMCSECollection* ppIGPMCSECollection);
    HRESULT GetConstants(IGPMConstants* ppIGPMConstants);
    HRESULT GetMigrationTable(BSTR bstrMigrationTablePath, IGPMMigrationTable* ppMigrationTable);
    HRESULT CreateMigrationTable(IGPMMigrationTable* ppMigrationTable);
    HRESULT InitializeReporting(BSTR bstrAdmPath);
}

@GUID("6B21CC14-5A00-4F44-A738-FEEC8A94C7E3")
interface IGPMDomain : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT CreateGPO(IGPMGPO* ppNewGPO);
    HRESULT GetGPO(BSTR bstrGuid, IGPMGPO* ppGPO);
    HRESULT SearchGPOs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMGPOCollection* ppIGPMGPOCollection);
    HRESULT RestoreGPO(IGPMBackup pIGPMBackup, int lDCFlags, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                       IGPMResult* ppIGPMResult);
    HRESULT GetSOM(BSTR bstrPath, IGPMSOM* ppSOM);
    HRESULT SearchSOMs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
    HRESULT GetWMIFilter(BSTR bstrPath, IGPMWMIFilter* ppWMIFilter);
    HRESULT SearchWMIFilters(IGPMSearchCriteria pIGPMSearchCriteria, 
                             IGPMWMIFilterCollection* ppIGPMWMIFilterCollection);
}

@GUID("B1568BED-0A93-4ACC-810F-AFE7081019B9")
interface IGPMBackupDir : IDispatch
{
    HRESULT get_BackupDirectory(BSTR* pVal);
    HRESULT GetBackup(BSTR bstrID, IGPMBackup* ppBackup);
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, IGPMBackupCollection* ppIGPMBackupCollection);
}

@GUID("4725A899-2782-4D27-A6BB-D499246FFD72")
interface IGPMSitesContainer : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT get_Forest(BSTR* pVal);
    HRESULT GetSite(BSTR bstrSiteName, IGPMSOM* ppSOM);
    HRESULT SearchSites(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
}

@GUID("D6F11C42-829B-48D4-83F5-3615B67DFC22")
interface IGPMSearchCriteria : IDispatch
{
    HRESULT Add(GPMSearchProperty searchProperty, __MIDL___MIDL_itf_gpmgmt_0000_0000_0004 searchOperation, 
                VARIANT varValue);
}

@GUID("3B466DA8-C1A4-4B2A-999A-BEFCDD56CEFB")
interface IGPMTrustee : IDispatch
{
    HRESULT get_TrusteeSid(BSTR* bstrVal);
    HRESULT get_TrusteeName(BSTR* bstrVal);
    HRESULT get_TrusteeDomain(BSTR* bstrVal);
    HRESULT get_TrusteeDSPath(BSTR* pVal);
    HRESULT get_TrusteeType(int* lVal);
}

@GUID("35EBCA40-E1A1-4A02-8905-D79416FB464A")
interface IGPMPermission : IDispatch
{
    HRESULT get_Inherited(short* pVal);
    HRESULT get_Inheritable(short* pVal);
    HRESULT get_Denied(short* pVal);
    HRESULT get_Permission(GPMPermissionType* pVal);
    HRESULT get_Trustee(IGPMTrustee* ppIGPMTrustee);
}

@GUID("B6C31ED4-1C93-4D3E-AE84-EB6D61161B60")
interface IGPMSecurityInfo : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppEnum);
    HRESULT Add(IGPMPermission pPerm);
    HRESULT Remove(IGPMPermission pPerm);
    HRESULT RemoveTrustee(BSTR bstrTrustee);
}

@GUID("D8A16A35-3B0D-416B-8D02-4DF6F95A7119")
interface IGPMBackup : IDispatch
{
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_GPOID(BSTR* pVal);
    HRESULT get_GPODomain(BSTR* pVal);
    HRESULT get_GPODisplayName(BSTR* pVal);
    HRESULT get_Timestamp(double* pVal);
    HRESULT get_Comment(BSTR* pVal);
    HRESULT get_BackupDir(BSTR* pVal);
    HRESULT Delete();
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
}

@GUID("C786FC0F-26D8-4BAB-A745-39CA7E800CAC")
interface IGPMBackupCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMBackup);
}

@GUID("C0A7F09E-05A1-4F0C-8158-9E5C33684F6B")
interface IGPMSOM : IDispatch
{
    HRESULT get_GPOInheritanceBlocked(short* pVal);
    HRESULT put_GPOInheritanceBlocked(short newVal);
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_Path(BSTR* pVal);
    HRESULT CreateGPOLink(int lLinkPos, IGPMGPO pGPO, IGPMGPOLink* ppNewGPOLink);
    HRESULT get_Type(__MIDL_IGPMSOM_0001* pVal);
    HRESULT GetGPOLinks(IGPMGPOLinksCollection* ppGPOLinks);
    HRESULT GetInheritedGPOLinks(IGPMGPOLinksCollection* ppGPOLinks);
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

@GUID("ADC1688E-00E4-4495-ABBA-BED200DF0CAB")
interface IGPMSOMCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMSOM);
}

@GUID("EF2FF9B4-3C27-459A-B979-038305CEC75D")
interface IGPMWMIFilter : IDispatch
{
    HRESULT get_Path(BSTR* pVal);
    HRESULT put_Name(BSTR newVal);
    HRESULT get_Name(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
    HRESULT get_Description(BSTR* pVal);
    HRESULT GetQueryList(VARIANT* pQryList);
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

@GUID("5782D582-1A36-4661-8A94-C3C32551945B")
interface IGPMWMIFilterCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

@GUID("49ED785A-3237-4FF2-B1F0-FDF5A8D5A1EE")
interface IGPMRSOP : IDispatch
{
    HRESULT get_Mode(__MIDL___MIDL_itf_gpmgmt_0000_0000_0001* pVal);
    HRESULT get_Namespace(BSTR* bstrVal);
    HRESULT put_LoggingComputer(BSTR bstrVal);
    HRESULT get_LoggingComputer(BSTR* bstrVal);
    HRESULT put_LoggingUser(BSTR bstrVal);
    HRESULT get_LoggingUser(BSTR* bstrVal);
    HRESULT put_LoggingFlags(int lVal);
    HRESULT get_LoggingFlags(int* lVal);
    HRESULT put_PlanningFlags(int lVal);
    HRESULT get_PlanningFlags(int* lVal);
    HRESULT put_PlanningDomainController(BSTR bstrVal);
    HRESULT get_PlanningDomainController(BSTR* bstrVal);
    HRESULT put_PlanningSiteName(BSTR bstrVal);
    HRESULT get_PlanningSiteName(BSTR* bstrVal);
    HRESULT put_PlanningUser(BSTR bstrVal);
    HRESULT get_PlanningUser(BSTR* bstrVal);
    HRESULT put_PlanningUserSOM(BSTR bstrVal);
    HRESULT get_PlanningUserSOM(BSTR* bstrVal);
    HRESULT put_PlanningUserWMIFilters(VARIANT varVal);
    HRESULT get_PlanningUserWMIFilters(VARIANT* varVal);
    HRESULT put_PlanningUserSecurityGroups(VARIANT varVal);
    HRESULT get_PlanningUserSecurityGroups(VARIANT* varVal);
    HRESULT put_PlanningComputer(BSTR bstrVal);
    HRESULT get_PlanningComputer(BSTR* bstrVal);
    HRESULT put_PlanningComputerSOM(BSTR bstrVal);
    HRESULT get_PlanningComputerSOM(BSTR* bstrVal);
    HRESULT put_PlanningComputerWMIFilters(VARIANT varVal);
    HRESULT get_PlanningComputerWMIFilters(VARIANT* varVal);
    HRESULT put_PlanningComputerSecurityGroups(VARIANT varVal);
    HRESULT get_PlanningComputerSecurityGroups(VARIANT* varVal);
    HRESULT LoggingEnumerateUsers(VARIANT* varVal);
    HRESULT CreateQueryResults();
    HRESULT ReleaseQueryResults();
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
}

@GUID("58CC4352-1CA3-48E5-9864-1DA4D6E0D60F")
interface IGPMGPO : IDispatch
{
    HRESULT get_DisplayName(BSTR* pVal);
    HRESULT put_DisplayName(BSTR newVal);
    HRESULT get_Path(BSTR* pVal);
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_DomainName(BSTR* pVal);
    HRESULT get_CreationTime(double* pDate);
    HRESULT get_ModificationTime(double* pDate);
    HRESULT get_UserDSVersionNumber(int* pVal);
    HRESULT get_ComputerDSVersionNumber(int* pVal);
    HRESULT get_UserSysvolVersionNumber(int* pVal);
    HRESULT get_ComputerSysvolVersionNumber(int* pVal);
    HRESULT GetWMIFilter(IGPMWMIFilter* ppIGPMWMIFilter);
    HRESULT SetWMIFilter(IGPMWMIFilter pIGPMWMIFilter);
    HRESULT SetUserEnabled(short vbEnabled);
    HRESULT SetComputerEnabled(short vbEnabled);
    HRESULT IsUserEnabled(short* pvbEnabled);
    HRESULT IsComputerEnabled(short* pvbEnabled);
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
    HRESULT Delete();
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    HRESULT Import(int lFlags, IGPMBackup pIGPMBackup, VARIANT* pvarMigrationTable, VARIANT* pvarGPMProgress, 
                   VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
    HRESULT CopyTo(int lFlags, IGPMDomain pIGPMDomain, VARIANT* pvarNewDisplayName, VARIANT* pvarMigrationTable, 
                   VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT SetSecurityDescriptor(int lFlags, IDispatch pSD);
    HRESULT GetSecurityDescriptor(int lFlags, IDispatch* ppSD);
    HRESULT IsACLConsistent(short* pvbConsistent);
    HRESULT MakeACLConsistent();
}

@GUID("F0F0D5CF-70CA-4C39-9E29-B642F8726C01")
interface IGPMGPOCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMGPOs);
}

@GUID("434B99BD-5DE7-478A-809C-C251721DF70C")
interface IGPMGPOLink : IDispatch
{
    HRESULT get_GPOID(BSTR* pVal);
    HRESULT get_GPODomain(BSTR* pVal);
    HRESULT get_Enabled(short* pVal);
    HRESULT put_Enabled(short newVal);
    HRESULT get_Enforced(short* pVal);
    HRESULT put_Enforced(short newVal);
    HRESULT get_SOMLinkOrder(int* lVal);
    HRESULT get_SOM(IGPMSOM* ppIGPMSOM);
    HRESULT Delete();
}

@GUID("189D7B68-16BD-4D0D-A2EC-2E6AA2288C7F")
interface IGPMGPOLinksCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMLinks);
}

@GUID("2E52A97D-0A4A-4A6F-85DB-201622455DA0")
interface IGPMCSECollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMCSEs);
}

@GUID("69DA7488-B8DB-415E-9266-901BE4D49928")
interface IGPMClientSideExtension : IDispatch
{
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_DisplayName(BSTR* pVal);
    HRESULT IsUserEnabled(short* pvbEnabled);
    HRESULT IsComputerEnabled(short* pvbEnabled);
}

@GUID("DDC67754-BE67-4541-8166-F48166868C9C")
interface IGPMAsyncCancel : IDispatch
{
    HRESULT Cancel();
}

@GUID("6AAC29F8-5948-4324-BF70-423818942DBC")
interface IGPMAsyncProgress : IDispatch
{
    HRESULT Status(int lProgressNumerator, int lProgressDenominator, HRESULT hrStatus, VARIANT* pResult, 
                   IGPMStatusMsgCollection ppIGPMStatusMsgCollection);
}

@GUID("9B6E1AF0-1A92-40F3-A59D-F36AC1F728B7")
interface IGPMStatusMsgCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

@GUID("8496C22F-F3DE-4A1F-8F58-603CAAA93D7B")
interface IGPMStatusMessage : IDispatch
{
    HRESULT get_ObjectPath(BSTR* pVal);
    HRESULT ErrorCode();
    HRESULT get_ExtensionName(BSTR* pVal);
    HRESULT get_SettingsName(BSTR* pVal);
    HRESULT OperationCode();
    HRESULT get_Message(BSTR* pVal);
}

@GUID("50EF73E6-D35C-4C8D-BE63-7EA5D2AAC5C4")
interface IGPMConstants : IDispatch
{
    HRESULT get_PermGPOApply(GPMPermissionType* pVal);
    HRESULT get_PermGPORead(GPMPermissionType* pVal);
    HRESULT get_PermGPOEdit(GPMPermissionType* pVal);
    HRESULT get_PermGPOEditSecurityAndDelete(GPMPermissionType* pVal);
    HRESULT get_PermGPOCustom(GPMPermissionType* pVal);
    HRESULT get_PermWMIFilterEdit(GPMPermissionType* pVal);
    HRESULT get_PermWMIFilterFullControl(GPMPermissionType* pVal);
    HRESULT get_PermWMIFilterCustom(GPMPermissionType* pVal);
    HRESULT get_PermSOMLink(GPMPermissionType* pVal);
    HRESULT get_PermSOMLogging(GPMPermissionType* pVal);
    HRESULT get_PermSOMPlanning(GPMPermissionType* pVal);
    HRESULT get_PermSOMGPOCreate(GPMPermissionType* pVal);
    HRESULT get_PermSOMWMICreate(GPMPermissionType* pVal);
    HRESULT get_PermSOMWMIFullControl(GPMPermissionType* pVal);
    HRESULT get_SearchPropertyGPOPermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOEffectivePermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPODisplayName(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOWMIFilter(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOID(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOComputerExtensions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOUserExtensions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertySOMLinks(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPODomain(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyBackupMostRecent(GPMSearchProperty* pVal);
    HRESULT get_SearchOpEquals(__MIDL___MIDL_itf_gpmgmt_0000_0000_0004* pVal);
    HRESULT get_SearchOpContains(__MIDL___MIDL_itf_gpmgmt_0000_0000_0004* pVal);
    HRESULT get_SearchOpNotContains(__MIDL___MIDL_itf_gpmgmt_0000_0000_0004* pVal);
    HRESULT get_SearchOpNotEquals(__MIDL___MIDL_itf_gpmgmt_0000_0000_0004* pVal);
    HRESULT get_UsePDC(int* pVal);
    HRESULT get_UseAnyDC(int* pVal);
    HRESULT get_DoNotUseW2KDC(int* pVal);
    HRESULT get_SOMSite(__MIDL_IGPMSOM_0001* pVal);
    HRESULT get_SOMDomain(__MIDL_IGPMSOM_0001* pVal);
    HRESULT get_SOMOU(__MIDL_IGPMSOM_0001* pVal);
    HRESULT get_SecurityFlags(short vbOwner, short vbGroup, short vbDACL, short vbSACL, int* pVal);
    HRESULT get_DoNotValidateDC(int* pVal);
    HRESULT get_ReportHTML(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005* pVal);
    HRESULT get_ReportXML(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005* pVal);
    HRESULT get_RSOPModeUnknown(__MIDL___MIDL_itf_gpmgmt_0000_0000_0001* pVal);
    HRESULT get_RSOPModePlanning(__MIDL___MIDL_itf_gpmgmt_0000_0000_0001* pVal);
    HRESULT get_RSOPModeLogging(__MIDL___MIDL_itf_gpmgmt_0000_0000_0001* pVal);
    HRESULT get_EntryTypeUser(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pVal);
    HRESULT get_EntryTypeComputer(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pVal);
    HRESULT get_EntryTypeLocalGroup(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pVal);
    HRESULT get_EntryTypeGlobalGroup(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pVal);
    HRESULT get_EntryTypeUniversalGroup(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pVal);
    HRESULT get_EntryTypeUNCPath(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pVal);
    HRESULT get_EntryTypeUnknown(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pVal);
    HRESULT get_DestinationOptionSameAsSource(__MIDL___MIDL_itf_gpmgmt_0000_0000_0007* pVal);
    HRESULT get_DestinationOptionNone(__MIDL___MIDL_itf_gpmgmt_0000_0000_0007* pVal);
    HRESULT get_DestinationOptionByRelativeName(__MIDL___MIDL_itf_gpmgmt_0000_0000_0007* pVal);
    HRESULT get_DestinationOptionSet(__MIDL___MIDL_itf_gpmgmt_0000_0000_0007* pVal);
    HRESULT get_MigrationTableOnly(int* pVal);
    HRESULT get_ProcessSecurity(int* pVal);
    HRESULT get_RsopLoggingNoComputer(int* pVal);
    HRESULT get_RsopLoggingNoUser(int* pVal);
    HRESULT get_RsopPlanningAssumeSlowLink(int* pVal);
    HRESULT get_RsopPlanningLoopbackOption(short vbMerge, int* pVal);
    HRESULT get_RsopPlanningAssumeUserWQLFilterTrue(int* pVal);
    HRESULT get_RsopPlanningAssumeCompWQLFilterTrue(int* pVal);
}

@GUID("86DFF7E9-F76F-42AB-9570-CEBC6BE8A52D")
interface IGPMResult : IDispatch
{
    HRESULT get_Status(IGPMStatusMsgCollection* ppIGPMStatusMsgCollection);
    HRESULT get_Result(VARIANT* pvarResult);
    HRESULT OverallStatus();
}

@GUID("BB0BF49B-E53F-443F-B807-8BE22BFB6D42")
interface IGPMMapEntryCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

@GUID("8E79AD06-2381-4444-BE4C-FF693E6E6F2B")
interface IGPMMapEntry : IDispatch
{
    HRESULT get_Source(BSTR* pbstrSource);
    HRESULT get_Destination(BSTR* pbstrDestination);
    HRESULT get_DestinationOption(__MIDL___MIDL_itf_gpmgmt_0000_0000_0007* pgpmDestOption);
    HRESULT get_EntryType(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pgpmEntryType);
}

@GUID("48F823B1-EFAF-470B-B6ED-40D14EE1A4EC")
interface IGPMMigrationTable : IDispatch
{
    HRESULT Save(BSTR bstrMigrationTablePath);
    HRESULT Add(int lFlags, VARIANT var);
    HRESULT AddEntry(BSTR bstrSource, __MIDL___MIDL_itf_gpmgmt_0000_0000_0006 gpmEntryType, 
                     VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    HRESULT GetEntry(BSTR bstrSource, IGPMMapEntry* ppEntry);
    HRESULT DeleteEntry(BSTR bstrSource);
    HRESULT UpdateDestination(BSTR bstrSource, VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    HRESULT Validate(IGPMResult* ppResult);
    HRESULT GetEntries(IGPMMapEntryCollection* ppEntries);
}

@GUID("F8DC55ED-3BA0-4864-AAD4-D365189EE1D5")
interface IGPMBackupDirEx : IDispatch
{
    HRESULT get_BackupDir(BSTR* pbstrBackupDir);
    HRESULT get_BackupType(GPMBackupType* pgpmBackupType);
    HRESULT GetBackup(BSTR bstrID, VARIANT* pvarBackup);
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, VARIANT* pvarBackupCollection);
}

@GUID("C998031D-ADD0-4BB5-8DEA-298505D8423B")
interface IGPMStarterGPOBackupCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTmplBackup);
}

@GUID("51D98EDA-A87E-43DD-B80A-0B66EF1938D6")
interface IGPMStarterGPOBackup : IDispatch
{
    HRESULT get_BackupDir(BSTR* pbstrBackupDir);
    HRESULT get_Comment(BSTR* pbstrComment);
    HRESULT get_DisplayName(BSTR* pbstrDisplayName);
    HRESULT get_Domain(BSTR* pbstrTemplateDomain);
    HRESULT get_StarterGPOID(BSTR* pbstrTemplateID);
    HRESULT get_ID(BSTR* pbstrID);
    HRESULT get_Timestamp(double* pTimestamp);
    HRESULT get_Type(GPMStarterGPOType* pType);
    HRESULT Delete();
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
}

@GUID("00238F8A-3D86-41AC-8F5E-06A6638A634A")
interface IGPM2 : IGPM
{
    HRESULT GetBackupDirEx(BSTR bstrBackupDir, GPMBackupType backupDirType, IGPMBackupDirEx* ppIGPMBackupDirEx);
    HRESULT InitializeReportingEx(BSTR bstrAdmPath, int reportingOptions);
}

@GUID("DFC3F61B-8880-4490-9337-D29C7BA8C2F0")
interface IGPMStarterGPO : IDispatch
{
    HRESULT get_DisplayName(BSTR* pVal);
    HRESULT put_DisplayName(BSTR newVal);
    HRESULT get_Description(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
    HRESULT get_Author(BSTR* pVal);
    HRESULT get_Product(BSTR* pVal);
    HRESULT get_CreationTime(double* pVal);
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_ModifiedTime(double* pVal);
    HRESULT get_Type(GPMStarterGPOType* pVal);
    HRESULT get_ComputerVersion(ushort* pVal);
    HRESULT get_UserVersion(ushort* pVal);
    HRESULT get_StarterGPOVersion(BSTR* pVal);
    HRESULT Delete();
    HRESULT Save(BSTR bstrSaveFile, short bOverwrite, short bSaveAsSystem, VARIANT* bstrLanguage, 
                 VARIANT* bstrAuthor, VARIANT* bstrProduct, VARIANT* bstrUniqueID, VARIANT* bstrVersion, 
                 VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    HRESULT CopyTo(VARIANT* pvarNewDisplayName, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

@GUID("2E522729-2219-44AD-933A-64DFD650C423")
interface IGPMStarterGPOCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTemplates);
}

@GUID("7CA6BB8B-F1EB-490A-938D-3C4E51C768E6")
interface IGPMDomain2 : IGPMDomain
{
    HRESULT CreateStarterGPO(IGPMStarterGPO* ppnewTemplate);
    HRESULT CreateGPOFromStarterGPO(IGPMStarterGPO pGPOTemplate, IGPMGPO* ppnewGPO);
    HRESULT GetStarterGPO(BSTR bstrGuid, IGPMStarterGPO* ppTemplate);
    HRESULT SearchStarterGPOs(IGPMSearchCriteria pIGPMSearchCriteria, 
                              IGPMStarterGPOCollection* ppIGPMTemplateCollection);
    HRESULT LoadStarterGPO(BSTR bstrLoadFile, short bOverwrite, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    HRESULT RestoreStarterGPO(IGPMStarterGPOBackup pIGPMTmplBackup, VARIANT* pvarGPMProgress, 
                              VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
}

@GUID("05AE21B0-AC09-4032-A26F-9E7DA786DC19")
interface IGPMConstants2 : IGPMConstants
{
    HRESULT get_BackupTypeGPO(GPMBackupType* pVal);
    HRESULT get_BackupTypeStarterGPO(GPMBackupType* pVal);
    HRESULT get_StarterGPOTypeSystem(GPMStarterGPOType* pVal);
    HRESULT get_StarterGPOTypeCustom(GPMStarterGPOType* pVal);
    HRESULT get_SearchPropertyStarterGPOPermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPOEffectivePermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPODisplayName(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPOID(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPODomain(GPMSearchProperty* pVal);
    HRESULT get_PermStarterGPORead(GPMPermissionType* pVal);
    HRESULT get_PermStarterGPOEdit(GPMPermissionType* pVal);
    HRESULT get_PermStarterGPOFullControl(GPMPermissionType* pVal);
    HRESULT get_PermStarterGPOCustom(GPMPermissionType* pVal);
    HRESULT get_ReportLegacy(GPMReportingOptions* pVal);
    HRESULT get_ReportComments(GPMReportingOptions* pVal);
}

@GUID("8A66A210-B78B-4D99-88E2-C306A817C925")
interface IGPMGPO2 : IGPMGPO
{
    HRESULT get_Description(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
}

@GUID("0077FDFE-88C7-4ACF-A11D-D10A7C310A03")
interface IGPMDomain3 : IGPMDomain2
{
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT get_InfrastructureDC(BSTR* pVal);
    HRESULT put_InfrastructureDC(BSTR newVal);
    HRESULT put_InfrastructureFlags(uint dwFlags);
}

@GUID("7CF123A1-F94A-4112-BFAE-6AA1DB9CB248")
interface IGPMGPO3 : IGPMGPO2
{
    HRESULT get_InfrastructureDC(BSTR* pVal);
    HRESULT put_InfrastructureDC(BSTR newVal);
    HRESULT put_InfrastructureFlags(uint dwFlags);
}


// GUIDs

const GUID CLSID_GPM                           = GUIDOF!GPM;
const GUID CLSID_GPMAsyncCancel                = GUIDOF!GPMAsyncCancel;
const GUID CLSID_GPMBackup                     = GUIDOF!GPMBackup;
const GUID CLSID_GPMBackupCollection           = GUIDOF!GPMBackupCollection;
const GUID CLSID_GPMBackupDir                  = GUIDOF!GPMBackupDir;
const GUID CLSID_GPMBackupDirEx                = GUIDOF!GPMBackupDirEx;
const GUID CLSID_GPMCSECollection              = GUIDOF!GPMCSECollection;
const GUID CLSID_GPMClientSideExtension        = GUIDOF!GPMClientSideExtension;
const GUID CLSID_GPMConstants                  = GUIDOF!GPMConstants;
const GUID CLSID_GPMDomain                     = GUIDOF!GPMDomain;
const GUID CLSID_GPMGPO                        = GUIDOF!GPMGPO;
const GUID CLSID_GPMGPOCollection              = GUIDOF!GPMGPOCollection;
const GUID CLSID_GPMGPOLink                    = GUIDOF!GPMGPOLink;
const GUID CLSID_GPMGPOLinksCollection         = GUIDOF!GPMGPOLinksCollection;
const GUID CLSID_GPMMapEntry                   = GUIDOF!GPMMapEntry;
const GUID CLSID_GPMMapEntryCollection         = GUIDOF!GPMMapEntryCollection;
const GUID CLSID_GPMMigrationTable             = GUIDOF!GPMMigrationTable;
const GUID CLSID_GPMPermission                 = GUIDOF!GPMPermission;
const GUID CLSID_GPMRSOP                       = GUIDOF!GPMRSOP;
const GUID CLSID_GPMResult                     = GUIDOF!GPMResult;
const GUID CLSID_GPMSOM                        = GUIDOF!GPMSOM;
const GUID CLSID_GPMSOMCollection              = GUIDOF!GPMSOMCollection;
const GUID CLSID_GPMSearchCriteria             = GUIDOF!GPMSearchCriteria;
const GUID CLSID_GPMSecurityInfo               = GUIDOF!GPMSecurityInfo;
const GUID CLSID_GPMSitesContainer             = GUIDOF!GPMSitesContainer;
const GUID CLSID_GPMStarterGPOBackup           = GUIDOF!GPMStarterGPOBackup;
const GUID CLSID_GPMStarterGPOBackupCollection = GUIDOF!GPMStarterGPOBackupCollection;
const GUID CLSID_GPMStarterGPOCollection       = GUIDOF!GPMStarterGPOCollection;
const GUID CLSID_GPMStatusMessage              = GUIDOF!GPMStatusMessage;
const GUID CLSID_GPMStatusMsgCollection        = GUIDOF!GPMStatusMsgCollection;
const GUID CLSID_GPMTemplate                   = GUIDOF!GPMTemplate;
const GUID CLSID_GPMTrustee                    = GUIDOF!GPMTrustee;
const GUID CLSID_GPMWMIFilter                  = GUIDOF!GPMWMIFilter;
const GUID CLSID_GPMWMIFilterCollection        = GUIDOF!GPMWMIFilterCollection;

const GUID IID_IGPM                           = GUIDOF!IGPM;
const GUID IID_IGPM2                          = GUIDOF!IGPM2;
const GUID IID_IGPMAsyncCancel                = GUIDOF!IGPMAsyncCancel;
const GUID IID_IGPMAsyncProgress              = GUIDOF!IGPMAsyncProgress;
const GUID IID_IGPMBackup                     = GUIDOF!IGPMBackup;
const GUID IID_IGPMBackupCollection           = GUIDOF!IGPMBackupCollection;
const GUID IID_IGPMBackupDir                  = GUIDOF!IGPMBackupDir;
const GUID IID_IGPMBackupDirEx                = GUIDOF!IGPMBackupDirEx;
const GUID IID_IGPMCSECollection              = GUIDOF!IGPMCSECollection;
const GUID IID_IGPMClientSideExtension        = GUIDOF!IGPMClientSideExtension;
const GUID IID_IGPMConstants                  = GUIDOF!IGPMConstants;
const GUID IID_IGPMConstants2                 = GUIDOF!IGPMConstants2;
const GUID IID_IGPMDomain                     = GUIDOF!IGPMDomain;
const GUID IID_IGPMDomain2                    = GUIDOF!IGPMDomain2;
const GUID IID_IGPMDomain3                    = GUIDOF!IGPMDomain3;
const GUID IID_IGPMGPO                        = GUIDOF!IGPMGPO;
const GUID IID_IGPMGPO2                       = GUIDOF!IGPMGPO2;
const GUID IID_IGPMGPO3                       = GUIDOF!IGPMGPO3;
const GUID IID_IGPMGPOCollection              = GUIDOF!IGPMGPOCollection;
const GUID IID_IGPMGPOLink                    = GUIDOF!IGPMGPOLink;
const GUID IID_IGPMGPOLinksCollection         = GUIDOF!IGPMGPOLinksCollection;
const GUID IID_IGPMMapEntry                   = GUIDOF!IGPMMapEntry;
const GUID IID_IGPMMapEntryCollection         = GUIDOF!IGPMMapEntryCollection;
const GUID IID_IGPMMigrationTable             = GUIDOF!IGPMMigrationTable;
const GUID IID_IGPMPermission                 = GUIDOF!IGPMPermission;
const GUID IID_IGPMRSOP                       = GUIDOF!IGPMRSOP;
const GUID IID_IGPMResult                     = GUIDOF!IGPMResult;
const GUID IID_IGPMSOM                        = GUIDOF!IGPMSOM;
const GUID IID_IGPMSOMCollection              = GUIDOF!IGPMSOMCollection;
const GUID IID_IGPMSearchCriteria             = GUIDOF!IGPMSearchCriteria;
const GUID IID_IGPMSecurityInfo               = GUIDOF!IGPMSecurityInfo;
const GUID IID_IGPMSitesContainer             = GUIDOF!IGPMSitesContainer;
const GUID IID_IGPMStarterGPO                 = GUIDOF!IGPMStarterGPO;
const GUID IID_IGPMStarterGPOBackup           = GUIDOF!IGPMStarterGPOBackup;
const GUID IID_IGPMStarterGPOBackupCollection = GUIDOF!IGPMStarterGPOBackupCollection;
const GUID IID_IGPMStarterGPOCollection       = GUIDOF!IGPMStarterGPOCollection;
const GUID IID_IGPMStatusMessage              = GUIDOF!IGPMStatusMessage;
const GUID IID_IGPMStatusMsgCollection        = GUIDOF!IGPMStatusMsgCollection;
const GUID IID_IGPMTrustee                    = GUIDOF!IGPMTrustee;
const GUID IID_IGPMWMIFilter                  = GUIDOF!IGPMWMIFilter;
const GUID IID_IGPMWMIFilterCollection        = GUIDOF!IGPMWMIFilterCollection;
