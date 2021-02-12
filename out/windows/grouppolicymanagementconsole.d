module windows.grouppolicymanagementconsole;

public import windows.automation;
public import windows.com;

extern(Windows):

const GUID CLSID_GPM = {0xF5694708, 0x88FE, 0x4B35, [0xBA, 0xBF, 0xE5, 0x61, 0x62, 0xD5, 0xFB, 0xC8]};
@GUID(0xF5694708, 0x88FE, 0x4B35, [0xBA, 0xBF, 0xE5, 0x61, 0x62, 0xD5, 0xFB, 0xC8]);
struct GPM;

const GUID CLSID_GPMDomain = {0x710901BE, 0x1050, 0x4CB1, [0x83, 0x8A, 0xC5, 0xCF, 0xF2, 0x59, 0xE1, 0x83]};
@GUID(0x710901BE, 0x1050, 0x4CB1, [0x83, 0x8A, 0xC5, 0xCF, 0xF2, 0x59, 0xE1, 0x83]);
struct GPMDomain;

const GUID CLSID_GPMSitesContainer = {0x229F5C42, 0x852C, 0x4B30, [0x94, 0x5F, 0xC5, 0x22, 0xBE, 0x9B, 0xD3, 0x86]};
@GUID(0x229F5C42, 0x852C, 0x4B30, [0x94, 0x5F, 0xC5, 0x22, 0xBE, 0x9B, 0xD3, 0x86]);
struct GPMSitesContainer;

const GUID CLSID_GPMBackupDir = {0xFCE4A59D, 0x0F21, 0x4AFA, [0xB8, 0x59, 0xE6, 0xD0, 0xC6, 0x2C, 0xD1, 0x0C]};
@GUID(0xFCE4A59D, 0x0F21, 0x4AFA, [0xB8, 0x59, 0xE6, 0xD0, 0xC6, 0x2C, 0xD1, 0x0C]);
struct GPMBackupDir;

const GUID CLSID_GPMSOM = {0x32D93FAC, 0x450E, 0x44CF, [0x82, 0x9C, 0x8B, 0x22, 0xFF, 0x6B, 0xDA, 0xE1]};
@GUID(0x32D93FAC, 0x450E, 0x44CF, [0x82, 0x9C, 0x8B, 0x22, 0xFF, 0x6B, 0xDA, 0xE1]);
struct GPMSOM;

const GUID CLSID_GPMSearchCriteria = {0x17AACA26, 0x5CE0, 0x44FA, [0x8C, 0xC0, 0x52, 0x59, 0xE6, 0x48, 0x35, 0x66]};
@GUID(0x17AACA26, 0x5CE0, 0x44FA, [0x8C, 0xC0, 0x52, 0x59, 0xE6, 0x48, 0x35, 0x66]);
struct GPMSearchCriteria;

const GUID CLSID_GPMPermission = {0x5871A40A, 0xE9C0, 0x46EC, [0x91, 0x3E, 0x94, 0x4E, 0xF9, 0x22, 0x5A, 0x94]};
@GUID(0x5871A40A, 0xE9C0, 0x46EC, [0x91, 0x3E, 0x94, 0x4E, 0xF9, 0x22, 0x5A, 0x94]);
struct GPMPermission;

const GUID CLSID_GPMSecurityInfo = {0x547A5E8F, 0x9162, 0x4516, [0xA4, 0xDF, 0x9D, 0xDB, 0x96, 0x86, 0xD8, 0x46]};
@GUID(0x547A5E8F, 0x9162, 0x4516, [0xA4, 0xDF, 0x9D, 0xDB, 0x96, 0x86, 0xD8, 0x46]);
struct GPMSecurityInfo;

const GUID CLSID_GPMBackup = {0xED1A54B8, 0x5EFA, 0x482A, [0x93, 0xC0, 0x8A, 0xD8, 0x6F, 0x0D, 0x68, 0xC3]};
@GUID(0xED1A54B8, 0x5EFA, 0x482A, [0x93, 0xC0, 0x8A, 0xD8, 0x6F, 0x0D, 0x68, 0xC3]);
struct GPMBackup;

const GUID CLSID_GPMBackupCollection = {0xEB8F035B, 0x70DB, 0x4A9F, [0x96, 0x76, 0x37, 0xC2, 0x59, 0x94, 0xE9, 0xDC]};
@GUID(0xEB8F035B, 0x70DB, 0x4A9F, [0x96, 0x76, 0x37, 0xC2, 0x59, 0x94, 0xE9, 0xDC]);
struct GPMBackupCollection;

const GUID CLSID_GPMSOMCollection = {0x24C1F147, 0x3720, 0x4F5B, [0xA9, 0xC3, 0x06, 0xB4, 0xE4, 0xF9, 0x31, 0xD2]};
@GUID(0x24C1F147, 0x3720, 0x4F5B, [0xA9, 0xC3, 0x06, 0xB4, 0xE4, 0xF9, 0x31, 0xD2]);
struct GPMSOMCollection;

const GUID CLSID_GPMWMIFilter = {0x626745D8, 0x0DEA, 0x4062, [0xBF, 0x60, 0xCF, 0xC5, 0xB1, 0xCA, 0x12, 0x86]};
@GUID(0x626745D8, 0x0DEA, 0x4062, [0xBF, 0x60, 0xCF, 0xC5, 0xB1, 0xCA, 0x12, 0x86]);
struct GPMWMIFilter;

const GUID CLSID_GPMWMIFilterCollection = {0x74DC6D28, 0xE820, 0x47D6, [0xA0, 0xB8, 0xF0, 0x8D, 0x93, 0xD7, 0xFA, 0x33]};
@GUID(0x74DC6D28, 0xE820, 0x47D6, [0xA0, 0xB8, 0xF0, 0x8D, 0x93, 0xD7, 0xFA, 0x33]);
struct GPMWMIFilterCollection;

const GUID CLSID_GPMRSOP = {0x489B0CAF, 0x9EC2, 0x4EB7, [0x91, 0xF5, 0xB6, 0xF7, 0x1D, 0x43, 0xDA, 0x8C]};
@GUID(0x489B0CAF, 0x9EC2, 0x4EB7, [0x91, 0xF5, 0xB6, 0xF7, 0x1D, 0x43, 0xDA, 0x8C]);
struct GPMRSOP;

const GUID CLSID_GPMGPO = {0xD2CE2994, 0x59B5, 0x4064, [0xB5, 0x81, 0x4D, 0x68, 0x48, 0x6A, 0x16, 0xC4]};
@GUID(0xD2CE2994, 0x59B5, 0x4064, [0xB5, 0x81, 0x4D, 0x68, 0x48, 0x6A, 0x16, 0xC4]);
struct GPMGPO;

const GUID CLSID_GPMGPOCollection = {0x7A057325, 0x832D, 0x4DE3, [0xA4, 0x1F, 0xC7, 0x80, 0x43, 0x6A, 0x4E, 0x09]};
@GUID(0x7A057325, 0x832D, 0x4DE3, [0xA4, 0x1F, 0xC7, 0x80, 0x43, 0x6A, 0x4E, 0x09]);
struct GPMGPOCollection;

const GUID CLSID_GPMGPOLink = {0xC1DF9880, 0x5303, 0x42C6, [0x8A, 0x3C, 0x04, 0x88, 0xE1, 0xBF, 0x73, 0x64]};
@GUID(0xC1DF9880, 0x5303, 0x42C6, [0x8A, 0x3C, 0x04, 0x88, 0xE1, 0xBF, 0x73, 0x64]);
struct GPMGPOLink;

const GUID CLSID_GPMGPOLinksCollection = {0xF6ED581A, 0x49A5, 0x47E2, [0xB7, 0x71, 0xFD, 0x8D, 0xC0, 0x2B, 0x62, 0x59]};
@GUID(0xF6ED581A, 0x49A5, 0x47E2, [0xB7, 0x71, 0xFD, 0x8D, 0xC0, 0x2B, 0x62, 0x59]);
struct GPMGPOLinksCollection;

const GUID CLSID_GPMAsyncCancel = {0x372796A9, 0x76EC, 0x479D, [0xAD, 0x6C, 0x55, 0x63, 0x18, 0xED, 0x5F, 0x9D]};
@GUID(0x372796A9, 0x76EC, 0x479D, [0xAD, 0x6C, 0x55, 0x63, 0x18, 0xED, 0x5F, 0x9D]);
struct GPMAsyncCancel;

const GUID CLSID_GPMStatusMsgCollection = {0x2824E4BE, 0x4BCC, 0x4CAC, [0x9E, 0x60, 0x0E, 0x3E, 0xD7, 0xF1, 0x24, 0x96]};
@GUID(0x2824E4BE, 0x4BCC, 0x4CAC, [0x9E, 0x60, 0x0E, 0x3E, 0xD7, 0xF1, 0x24, 0x96]);
struct GPMStatusMsgCollection;

const GUID CLSID_GPMStatusMessage = {0x4B77CC94, 0xD255, 0x409B, [0xBC, 0x62, 0x37, 0x08, 0x81, 0x71, 0x5A, 0x19]};
@GUID(0x4B77CC94, 0xD255, 0x409B, [0xBC, 0x62, 0x37, 0x08, 0x81, 0x71, 0x5A, 0x19]);
struct GPMStatusMessage;

const GUID CLSID_GPMTrustee = {0xC54A700D, 0x19B6, 0x4211, [0xBC, 0xB0, 0xE8, 0xE2, 0x47, 0x5E, 0x47, 0x1E]};
@GUID(0xC54A700D, 0x19B6, 0x4211, [0xBC, 0xB0, 0xE8, 0xE2, 0x47, 0x5E, 0x47, 0x1E]);
struct GPMTrustee;

const GUID CLSID_GPMClientSideExtension = {0xC1A2E70E, 0x659C, 0x4B1A, [0x94, 0x0B, 0xF8, 0x8B, 0x0A, 0xF9, 0xC8, 0xA4]};
@GUID(0xC1A2E70E, 0x659C, 0x4B1A, [0x94, 0x0B, 0xF8, 0x8B, 0x0A, 0xF9, 0xC8, 0xA4]);
struct GPMClientSideExtension;

const GUID CLSID_GPMCSECollection = {0xCF92B828, 0x2D44, 0x4B61, [0xB1, 0x0A, 0xB3, 0x27, 0xAF, 0xD4, 0x2D, 0xA8]};
@GUID(0xCF92B828, 0x2D44, 0x4B61, [0xB1, 0x0A, 0xB3, 0x27, 0xAF, 0xD4, 0x2D, 0xA8]);
struct GPMCSECollection;

const GUID CLSID_GPMConstants = {0x3855E880, 0xCD9E, 0x4D0C, [0x9E, 0xAF, 0x15, 0x79, 0x28, 0x3A, 0x18, 0x88]};
@GUID(0x3855E880, 0xCD9E, 0x4D0C, [0x9E, 0xAF, 0x15, 0x79, 0x28, 0x3A, 0x18, 0x88]);
struct GPMConstants;

const GUID CLSID_GPMResult = {0x92101AC0, 0x9287, 0x4206, [0xA3, 0xB2, 0x4B, 0xDB, 0x73, 0xD2, 0x25, 0xF6]};
@GUID(0x92101AC0, 0x9287, 0x4206, [0xA3, 0xB2, 0x4B, 0xDB, 0x73, 0xD2, 0x25, 0xF6]);
struct GPMResult;

const GUID CLSID_GPMMapEntryCollection = {0x0CF75D5B, 0xA3A1, 0x4C55, [0xB4, 0xFE, 0x9E, 0x14, 0x9C, 0x41, 0xF6, 0x6D]};
@GUID(0x0CF75D5B, 0xA3A1, 0x4C55, [0xB4, 0xFE, 0x9E, 0x14, 0x9C, 0x41, 0xF6, 0x6D]);
struct GPMMapEntryCollection;

const GUID CLSID_GPMMapEntry = {0x8C975253, 0x5431, 0x4471, [0xB3, 0x5D, 0x06, 0x26, 0xC9, 0x28, 0x25, 0x8A]};
@GUID(0x8C975253, 0x5431, 0x4471, [0xB3, 0x5D, 0x06, 0x26, 0xC9, 0x28, 0x25, 0x8A]);
struct GPMMapEntry;

const GUID CLSID_GPMMigrationTable = {0x55AF4043, 0x2A06, 0x4F72, [0xAB, 0xEF, 0x63, 0x1B, 0x44, 0x07, 0x9C, 0x76]};
@GUID(0x55AF4043, 0x2A06, 0x4F72, [0xAB, 0xEF, 0x63, 0x1B, 0x44, 0x07, 0x9C, 0x76]);
struct GPMMigrationTable;

const GUID CLSID_GPMBackupDirEx = {0xE8C0988A, 0xCF03, 0x4C5B, [0x8B, 0xE2, 0x2A, 0xA9, 0xAD, 0x32, 0xAA, 0xDA]};
@GUID(0xE8C0988A, 0xCF03, 0x4C5B, [0x8B, 0xE2, 0x2A, 0xA9, 0xAD, 0x32, 0xAA, 0xDA]);
struct GPMBackupDirEx;

const GUID CLSID_GPMStarterGPOBackupCollection = {0xE75EA59D, 0x1AEB, 0x4CB5, [0xA7, 0x8A, 0x28, 0x1D, 0xAA, 0x58, 0x24, 0x06]};
@GUID(0xE75EA59D, 0x1AEB, 0x4CB5, [0xA7, 0x8A, 0x28, 0x1D, 0xAA, 0x58, 0x24, 0x06]);
struct GPMStarterGPOBackupCollection;

const GUID CLSID_GPMStarterGPOBackup = {0x389E400A, 0xD8EF, 0x455B, [0xA8, 0x61, 0x5F, 0x9C, 0xA3, 0x4A, 0x6A, 0x02]};
@GUID(0x389E400A, 0xD8EF, 0x455B, [0xA8, 0x61, 0x5F, 0x9C, 0xA3, 0x4A, 0x6A, 0x02]);
struct GPMStarterGPOBackup;

const GUID CLSID_GPMTemplate = {0xECF1D454, 0x71DA, 0x4E2F, [0xA8, 0xC0, 0x81, 0x85, 0x46, 0x59, 0x11, 0xD9]};
@GUID(0xECF1D454, 0x71DA, 0x4E2F, [0xA8, 0xC0, 0x81, 0x85, 0x46, 0x59, 0x11, 0xD9]);
struct GPMTemplate;

const GUID CLSID_GPMStarterGPOCollection = {0x82F8AA8B, 0x49BA, 0x43B2, [0x95, 0x6E, 0x33, 0x97, 0xF9, 0xB9, 0x4C, 0x3A]};
@GUID(0x82F8AA8B, 0x49BA, 0x43B2, [0x95, 0x6E, 0x33, 0x97, 0xF9, 0xB9, 0x4C, 0x3A]);
struct GPMStarterGPOCollection;

enum __MIDL___MIDL_itf_gpmgmt_0000_0000_0001
{
    rsopUnknown = 0,
    rsopPlanning = 1,
    rsopLogging = 2,
}

enum GPMPermissionType
{
    permGPOApply = 65536,
    permGPORead = 65792,
    permGPOEdit = 65793,
    permGPOEditSecurityAndDelete = 65794,
    permGPOCustom = 65795,
    permWMIFilterEdit = 131072,
    permWMIFilterFullControl = 131073,
    permWMIFilterCustom = 131074,
    permSOMLink = 1835008,
    permSOMLogging = 1573120,
    permSOMPlanning = 1573376,
    permSOMWMICreate = 1049344,
    permSOMWMIFullControl = 1049345,
    permSOMGPOCreate = 1049600,
    permStarterGPORead = 197888,
    permStarterGPOEdit = 197889,
    permStarterGPOFullControl = 197890,
    permStarterGPOCustom = 197891,
    permSOMStarterGPOCreate = 1049856,
}

enum GPMSearchProperty
{
    gpoPermissions = 0,
    gpoEffectivePermissions = 1,
    gpoDisplayName = 2,
    gpoWMIFilter = 3,
    gpoID = 4,
    gpoComputerExtensions = 5,
    gpoUserExtensions = 6,
    somLinks = 7,
    gpoDomain = 8,
    backupMostRecent = 9,
    starterGPOPermissions = 10,
    starterGPOEffectivePermissions = 11,
    starterGPODisplayName = 12,
    starterGPOID = 13,
    starterGPODomain = 14,
}

enum __MIDL___MIDL_itf_gpmgmt_0000_0000_0004
{
    opEquals = 0,
    opContains = 1,
    opNotContains = 2,
    opNotEquals = 3,
}

enum __MIDL___MIDL_itf_gpmgmt_0000_0000_0005
{
    repXML = 0,
    repHTML = 1,
    repInfraXML = 2,
    repInfraRefreshXML = 3,
    repClientHealthXML = 4,
    repClientHealthRefreshXML = 5,
}

enum __MIDL___MIDL_itf_gpmgmt_0000_0000_0006
{
    typeUser = 0,
    typeComputer = 1,
    typeLocalGroup = 2,
    typeGlobalGroup = 3,
    typeUniversalGroup = 4,
    typeUNCPath = 5,
    typeUnknown = 6,
}

enum __MIDL___MIDL_itf_gpmgmt_0000_0000_0007
{
    opDestinationSameAsSource = 0,
    opDestinationNone = 1,
    opDestinationByRelativeName = 2,
    opDestinationSet = 3,
}

enum GPMReportingOptions
{
    opReportLegacy = 0,
    opReportComments = 1,
}

const GUID IID_IGPM = {0xF5FAE809, 0x3BD6, 0x4DA9, [0xA6, 0x5E, 0x17, 0x66, 0x5B, 0x41, 0xD7, 0x63]};
@GUID(0xF5FAE809, 0x3BD6, 0x4DA9, [0xA6, 0x5E, 0x17, 0x66, 0x5B, 0x41, 0xD7, 0x63]);
interface IGPM : IDispatch
{
    HRESULT GetDomain(BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, IGPMDomain* pIGPMDomain);
    HRESULT GetBackupDir(BSTR bstrBackupDir, IGPMBackupDir* pIGPMBackupDir);
    HRESULT GetSitesContainer(BSTR bstrForest, BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, IGPMSitesContainer* ppIGPMSitesContainer);
    HRESULT GetRSOP(__MIDL___MIDL_itf_gpmgmt_0000_0000_0001 gpmRSoPMode, BSTR bstrNamespace, int lFlags, IGPMRSOP* ppIGPMRSOP);
    HRESULT CreatePermission(BSTR bstrTrustee, GPMPermissionType perm, short bInheritable, IGPMPermission* ppPerm);
    HRESULT CreateSearchCriteria(IGPMSearchCriteria* ppIGPMSearchCriteria);
    HRESULT CreateTrustee(BSTR bstrTrustee, IGPMTrustee* ppIGPMTrustee);
    HRESULT GetClientSideExtensions(IGPMCSECollection* ppIGPMCSECollection);
    HRESULT GetConstants(IGPMConstants* ppIGPMConstants);
    HRESULT GetMigrationTable(BSTR bstrMigrationTablePath, IGPMMigrationTable* ppMigrationTable);
    HRESULT CreateMigrationTable(IGPMMigrationTable* ppMigrationTable);
    HRESULT InitializeReporting(BSTR bstrAdmPath);
}

const GUID IID_IGPMDomain = {0x6B21CC14, 0x5A00, 0x4F44, [0xA7, 0x38, 0xFE, 0xEC, 0x8A, 0x94, 0xC7, 0xE3]};
@GUID(0x6B21CC14, 0x5A00, 0x4F44, [0xA7, 0x38, 0xFE, 0xEC, 0x8A, 0x94, 0xC7, 0xE3]);
interface IGPMDomain : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT CreateGPO(IGPMGPO* ppNewGPO);
    HRESULT GetGPO(BSTR bstrGuid, IGPMGPO* ppGPO);
    HRESULT SearchGPOs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMGPOCollection* ppIGPMGPOCollection);
    HRESULT RestoreGPO(IGPMBackup pIGPMBackup, int lDCFlags, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GetSOM(BSTR bstrPath, IGPMSOM* ppSOM);
    HRESULT SearchSOMs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
    HRESULT GetWMIFilter(BSTR bstrPath, IGPMWMIFilter* ppWMIFilter);
    HRESULT SearchWMIFilters(IGPMSearchCriteria pIGPMSearchCriteria, IGPMWMIFilterCollection* ppIGPMWMIFilterCollection);
}

const GUID IID_IGPMBackupDir = {0xB1568BED, 0x0A93, 0x4ACC, [0x81, 0x0F, 0xAF, 0xE7, 0x08, 0x10, 0x19, 0xB9]};
@GUID(0xB1568BED, 0x0A93, 0x4ACC, [0x81, 0x0F, 0xAF, 0xE7, 0x08, 0x10, 0x19, 0xB9]);
interface IGPMBackupDir : IDispatch
{
    HRESULT get_BackupDirectory(BSTR* pVal);
    HRESULT GetBackup(BSTR bstrID, IGPMBackup* ppBackup);
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, IGPMBackupCollection* ppIGPMBackupCollection);
}

const GUID IID_IGPMSitesContainer = {0x4725A899, 0x2782, 0x4D27, [0xA6, 0xBB, 0xD4, 0x99, 0x24, 0x6F, 0xFD, 0x72]};
@GUID(0x4725A899, 0x2782, 0x4D27, [0xA6, 0xBB, 0xD4, 0x99, 0x24, 0x6F, 0xFD, 0x72]);
interface IGPMSitesContainer : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT get_Forest(BSTR* pVal);
    HRESULT GetSite(BSTR bstrSiteName, IGPMSOM* ppSOM);
    HRESULT SearchSites(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
}

const GUID IID_IGPMSearchCriteria = {0xD6F11C42, 0x829B, 0x48D4, [0x83, 0xF5, 0x36, 0x15, 0xB6, 0x7D, 0xFC, 0x22]};
@GUID(0xD6F11C42, 0x829B, 0x48D4, [0x83, 0xF5, 0x36, 0x15, 0xB6, 0x7D, 0xFC, 0x22]);
interface IGPMSearchCriteria : IDispatch
{
    HRESULT Add(GPMSearchProperty searchProperty, __MIDL___MIDL_itf_gpmgmt_0000_0000_0004 searchOperation, VARIANT varValue);
}

const GUID IID_IGPMTrustee = {0x3B466DA8, 0xC1A4, 0x4B2A, [0x99, 0x9A, 0xBE, 0xFC, 0xDD, 0x56, 0xCE, 0xFB]};
@GUID(0x3B466DA8, 0xC1A4, 0x4B2A, [0x99, 0x9A, 0xBE, 0xFC, 0xDD, 0x56, 0xCE, 0xFB]);
interface IGPMTrustee : IDispatch
{
    HRESULT get_TrusteeSid(BSTR* bstrVal);
    HRESULT get_TrusteeName(BSTR* bstrVal);
    HRESULT get_TrusteeDomain(BSTR* bstrVal);
    HRESULT get_TrusteeDSPath(BSTR* pVal);
    HRESULT get_TrusteeType(int* lVal);
}

const GUID IID_IGPMPermission = {0x35EBCA40, 0xE1A1, 0x4A02, [0x89, 0x05, 0xD7, 0x94, 0x16, 0xFB, 0x46, 0x4A]};
@GUID(0x35EBCA40, 0xE1A1, 0x4A02, [0x89, 0x05, 0xD7, 0x94, 0x16, 0xFB, 0x46, 0x4A]);
interface IGPMPermission : IDispatch
{
    HRESULT get_Inherited(short* pVal);
    HRESULT get_Inheritable(short* pVal);
    HRESULT get_Denied(short* pVal);
    HRESULT get_Permission(GPMPermissionType* pVal);
    HRESULT get_Trustee(IGPMTrustee* ppIGPMTrustee);
}

const GUID IID_IGPMSecurityInfo = {0xB6C31ED4, 0x1C93, 0x4D3E, [0xAE, 0x84, 0xEB, 0x6D, 0x61, 0x16, 0x1B, 0x60]};
@GUID(0xB6C31ED4, 0x1C93, 0x4D3E, [0xAE, 0x84, 0xEB, 0x6D, 0x61, 0x16, 0x1B, 0x60]);
interface IGPMSecurityInfo : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppEnum);
    HRESULT Add(IGPMPermission pPerm);
    HRESULT Remove(IGPMPermission pPerm);
    HRESULT RemoveTrustee(BSTR bstrTrustee);
}

const GUID IID_IGPMBackup = {0xD8A16A35, 0x3B0D, 0x416B, [0x8D, 0x02, 0x4D, 0xF6, 0xF9, 0x5A, 0x71, 0x19]};
@GUID(0xD8A16A35, 0x3B0D, 0x416B, [0x8D, 0x02, 0x4D, 0xF6, 0xF9, 0x5A, 0x71, 0x19]);
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
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
}

const GUID IID_IGPMBackupCollection = {0xC786FC0F, 0x26D8, 0x4BAB, [0xA7, 0x45, 0x39, 0xCA, 0x7E, 0x80, 0x0C, 0xAC]};
@GUID(0xC786FC0F, 0x26D8, 0x4BAB, [0xA7, 0x45, 0x39, 0xCA, 0x7E, 0x80, 0x0C, 0xAC]);
interface IGPMBackupCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMBackup);
}

enum __MIDL_IGPMSOM_0001
{
    somSite = 0,
    somDomain = 1,
    somOU = 2,
}

const GUID IID_IGPMSOM = {0xC0A7F09E, 0x05A1, 0x4F0C, [0x81, 0x58, 0x9E, 0x5C, 0x33, 0x68, 0x4F, 0x6B]};
@GUID(0xC0A7F09E, 0x05A1, 0x4F0C, [0x81, 0x58, 0x9E, 0x5C, 0x33, 0x68, 0x4F, 0x6B]);
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

const GUID IID_IGPMSOMCollection = {0xADC1688E, 0x00E4, 0x4495, [0xAB, 0xBA, 0xBE, 0xD2, 0x00, 0xDF, 0x0C, 0xAB]};
@GUID(0xADC1688E, 0x00E4, 0x4495, [0xAB, 0xBA, 0xBE, 0xD2, 0x00, 0xDF, 0x0C, 0xAB]);
interface IGPMSOMCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMSOM);
}

const GUID IID_IGPMWMIFilter = {0xEF2FF9B4, 0x3C27, 0x459A, [0xB9, 0x79, 0x03, 0x83, 0x05, 0xCE, 0xC7, 0x5D]};
@GUID(0xEF2FF9B4, 0x3C27, 0x459A, [0xB9, 0x79, 0x03, 0x83, 0x05, 0xCE, 0xC7, 0x5D]);
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

const GUID IID_IGPMWMIFilterCollection = {0x5782D582, 0x1A36, 0x4661, [0x8A, 0x94, 0xC3, 0xC3, 0x25, 0x51, 0x94, 0x5B]};
@GUID(0x5782D582, 0x1A36, 0x4661, [0x8A, 0x94, 0xC3, 0xC3, 0x25, 0x51, 0x94, 0x5B]);
interface IGPMWMIFilterCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

const GUID IID_IGPMRSOP = {0x49ED785A, 0x3237, 0x4FF2, [0xB1, 0xF0, 0xFD, 0xF5, 0xA8, 0xD5, 0xA1, 0xEE]};
@GUID(0x49ED785A, 0x3237, 0x4FF2, [0xB1, 0xF0, 0xFD, 0xF5, 0xA8, 0xD5, 0xA1, 0xEE]);
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
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
}

const GUID IID_IGPMGPO = {0x58CC4352, 0x1CA3, 0x48E5, [0x98, 0x64, 0x1D, 0xA4, 0xD6, 0xE0, 0xD6, 0x0F]};
@GUID(0x58CC4352, 0x1CA3, 0x48E5, [0x98, 0x64, 0x1D, 0xA4, 0xD6, 0xE0, 0xD6, 0x0F]);
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
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT Import(int lFlags, IGPMBackup pIGPMBackup, VARIANT* pvarMigrationTable, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
    HRESULT CopyTo(int lFlags, IGPMDomain pIGPMDomain, VARIANT* pvarNewDisplayName, VARIANT* pvarMigrationTable, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT SetSecurityDescriptor(int lFlags, IDispatch pSD);
    HRESULT GetSecurityDescriptor(int lFlags, IDispatch* ppSD);
    HRESULT IsACLConsistent(short* pvbConsistent);
    HRESULT MakeACLConsistent();
}

const GUID IID_IGPMGPOCollection = {0xF0F0D5CF, 0x70CA, 0x4C39, [0x9E, 0x29, 0xB6, 0x42, 0xF8, 0x72, 0x6C, 0x01]};
@GUID(0xF0F0D5CF, 0x70CA, 0x4C39, [0x9E, 0x29, 0xB6, 0x42, 0xF8, 0x72, 0x6C, 0x01]);
interface IGPMGPOCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMGPOs);
}

const GUID IID_IGPMGPOLink = {0x434B99BD, 0x5DE7, 0x478A, [0x80, 0x9C, 0xC2, 0x51, 0x72, 0x1D, 0xF7, 0x0C]};
@GUID(0x434B99BD, 0x5DE7, 0x478A, [0x80, 0x9C, 0xC2, 0x51, 0x72, 0x1D, 0xF7, 0x0C]);
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

const GUID IID_IGPMGPOLinksCollection = {0x189D7B68, 0x16BD, 0x4D0D, [0xA2, 0xEC, 0x2E, 0x6A, 0xA2, 0x28, 0x8C, 0x7F]};
@GUID(0x189D7B68, 0x16BD, 0x4D0D, [0xA2, 0xEC, 0x2E, 0x6A, 0xA2, 0x28, 0x8C, 0x7F]);
interface IGPMGPOLinksCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMLinks);
}

const GUID IID_IGPMCSECollection = {0x2E52A97D, 0x0A4A, 0x4A6F, [0x85, 0xDB, 0x20, 0x16, 0x22, 0x45, 0x5D, 0xA0]};
@GUID(0x2E52A97D, 0x0A4A, 0x4A6F, [0x85, 0xDB, 0x20, 0x16, 0x22, 0x45, 0x5D, 0xA0]);
interface IGPMCSECollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMCSEs);
}

const GUID IID_IGPMClientSideExtension = {0x69DA7488, 0xB8DB, 0x415E, [0x92, 0x66, 0x90, 0x1B, 0xE4, 0xD4, 0x99, 0x28]};
@GUID(0x69DA7488, 0xB8DB, 0x415E, [0x92, 0x66, 0x90, 0x1B, 0xE4, 0xD4, 0x99, 0x28]);
interface IGPMClientSideExtension : IDispatch
{
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_DisplayName(BSTR* pVal);
    HRESULT IsUserEnabled(short* pvbEnabled);
    HRESULT IsComputerEnabled(short* pvbEnabled);
}

const GUID IID_IGPMAsyncCancel = {0xDDC67754, 0xBE67, 0x4541, [0x81, 0x66, 0xF4, 0x81, 0x66, 0x86, 0x8C, 0x9C]};
@GUID(0xDDC67754, 0xBE67, 0x4541, [0x81, 0x66, 0xF4, 0x81, 0x66, 0x86, 0x8C, 0x9C]);
interface IGPMAsyncCancel : IDispatch
{
    HRESULT Cancel();
}

const GUID IID_IGPMAsyncProgress = {0x6AAC29F8, 0x5948, 0x4324, [0xBF, 0x70, 0x42, 0x38, 0x18, 0x94, 0x2D, 0xBC]};
@GUID(0x6AAC29F8, 0x5948, 0x4324, [0xBF, 0x70, 0x42, 0x38, 0x18, 0x94, 0x2D, 0xBC]);
interface IGPMAsyncProgress : IDispatch
{
    HRESULT Status(int lProgressNumerator, int lProgressDenominator, HRESULT hrStatus, VARIANT* pResult, IGPMStatusMsgCollection ppIGPMStatusMsgCollection);
}

const GUID IID_IGPMStatusMsgCollection = {0x9B6E1AF0, 0x1A92, 0x40F3, [0xA5, 0x9D, 0xF3, 0x6A, 0xC1, 0xF7, 0x28, 0xB7]};
@GUID(0x9B6E1AF0, 0x1A92, 0x40F3, [0xA5, 0x9D, 0xF3, 0x6A, 0xC1, 0xF7, 0x28, 0xB7]);
interface IGPMStatusMsgCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

const GUID IID_IGPMStatusMessage = {0x8496C22F, 0xF3DE, 0x4A1F, [0x8F, 0x58, 0x60, 0x3C, 0xAA, 0xA9, 0x3D, 0x7B]};
@GUID(0x8496C22F, 0xF3DE, 0x4A1F, [0x8F, 0x58, 0x60, 0x3C, 0xAA, 0xA9, 0x3D, 0x7B]);
interface IGPMStatusMessage : IDispatch
{
    HRESULT get_ObjectPath(BSTR* pVal);
    HRESULT ErrorCode();
    HRESULT get_ExtensionName(BSTR* pVal);
    HRESULT get_SettingsName(BSTR* pVal);
    HRESULT OperationCode();
    HRESULT get_Message(BSTR* pVal);
}

const GUID IID_IGPMConstants = {0x50EF73E6, 0xD35C, 0x4C8D, [0xBE, 0x63, 0x7E, 0xA5, 0xD2, 0xAA, 0xC5, 0xC4]};
@GUID(0x50EF73E6, 0xD35C, 0x4C8D, [0xBE, 0x63, 0x7E, 0xA5, 0xD2, 0xAA, 0xC5, 0xC4]);
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

const GUID IID_IGPMResult = {0x86DFF7E9, 0xF76F, 0x42AB, [0x95, 0x70, 0xCE, 0xBC, 0x6B, 0xE8, 0xA5, 0x2D]};
@GUID(0x86DFF7E9, 0xF76F, 0x42AB, [0x95, 0x70, 0xCE, 0xBC, 0x6B, 0xE8, 0xA5, 0x2D]);
interface IGPMResult : IDispatch
{
    HRESULT get_Status(IGPMStatusMsgCollection* ppIGPMStatusMsgCollection);
    HRESULT get_Result(VARIANT* pvarResult);
    HRESULT OverallStatus();
}

const GUID IID_IGPMMapEntryCollection = {0xBB0BF49B, 0xE53F, 0x443F, [0xB8, 0x07, 0x8B, 0xE2, 0x2B, 0xFB, 0x6D, 0x42]};
@GUID(0xBB0BF49B, 0xE53F, 0x443F, [0xB8, 0x07, 0x8B, 0xE2, 0x2B, 0xFB, 0x6D, 0x42]);
interface IGPMMapEntryCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

const GUID IID_IGPMMapEntry = {0x8E79AD06, 0x2381, 0x4444, [0xBE, 0x4C, 0xFF, 0x69, 0x3E, 0x6E, 0x6F, 0x2B]};
@GUID(0x8E79AD06, 0x2381, 0x4444, [0xBE, 0x4C, 0xFF, 0x69, 0x3E, 0x6E, 0x6F, 0x2B]);
interface IGPMMapEntry : IDispatch
{
    HRESULT get_Source(BSTR* pbstrSource);
    HRESULT get_Destination(BSTR* pbstrDestination);
    HRESULT get_DestinationOption(__MIDL___MIDL_itf_gpmgmt_0000_0000_0007* pgpmDestOption);
    HRESULT get_EntryType(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pgpmEntryType);
}

const GUID IID_IGPMMigrationTable = {0x48F823B1, 0xEFAF, 0x470B, [0xB6, 0xED, 0x40, 0xD1, 0x4E, 0xE1, 0xA4, 0xEC]};
@GUID(0x48F823B1, 0xEFAF, 0x470B, [0xB6, 0xED, 0x40, 0xD1, 0x4E, 0xE1, 0xA4, 0xEC]);
interface IGPMMigrationTable : IDispatch
{
    HRESULT Save(BSTR bstrMigrationTablePath);
    HRESULT Add(int lFlags, VARIANT var);
    HRESULT AddEntry(BSTR bstrSource, __MIDL___MIDL_itf_gpmgmt_0000_0000_0006 gpmEntryType, VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    HRESULT GetEntry(BSTR bstrSource, IGPMMapEntry* ppEntry);
    HRESULT DeleteEntry(BSTR bstrSource);
    HRESULT UpdateDestination(BSTR bstrSource, VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    HRESULT Validate(IGPMResult* ppResult);
    HRESULT GetEntries(IGPMMapEntryCollection* ppEntries);
}

enum GPMBackupType
{
    typeGPO = 0,
    typeStarterGPO = 1,
}

enum GPMStarterGPOType
{
    typeSystem = 0,
    typeCustom = 1,
}

const GUID IID_IGPMBackupDirEx = {0xF8DC55ED, 0x3BA0, 0x4864, [0xAA, 0xD4, 0xD3, 0x65, 0x18, 0x9E, 0xE1, 0xD5]};
@GUID(0xF8DC55ED, 0x3BA0, 0x4864, [0xAA, 0xD4, 0xD3, 0x65, 0x18, 0x9E, 0xE1, 0xD5]);
interface IGPMBackupDirEx : IDispatch
{
    HRESULT get_BackupDir(BSTR* pbstrBackupDir);
    HRESULT get_BackupType(GPMBackupType* pgpmBackupType);
    HRESULT GetBackup(BSTR bstrID, VARIANT* pvarBackup);
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, VARIANT* pvarBackupCollection);
}

const GUID IID_IGPMStarterGPOBackupCollection = {0xC998031D, 0xADD0, 0x4BB5, [0x8D, 0xEA, 0x29, 0x85, 0x05, 0xD8, 0x42, 0x3B]};
@GUID(0xC998031D, 0xADD0, 0x4BB5, [0x8D, 0xEA, 0x29, 0x85, 0x05, 0xD8, 0x42, 0x3B]);
interface IGPMStarterGPOBackupCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTmplBackup);
}

const GUID IID_IGPMStarterGPOBackup = {0x51D98EDA, 0xA87E, 0x43DD, [0xB8, 0x0A, 0x0B, 0x66, 0xEF, 0x19, 0x38, 0xD6]};
@GUID(0x51D98EDA, 0xA87E, 0x43DD, [0xB8, 0x0A, 0x0B, 0x66, 0xEF, 0x19, 0x38, 0xD6]);
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
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
}

const GUID IID_IGPM2 = {0x00238F8A, 0x3D86, 0x41AC, [0x8F, 0x5E, 0x06, 0xA6, 0x63, 0x8A, 0x63, 0x4A]};
@GUID(0x00238F8A, 0x3D86, 0x41AC, [0x8F, 0x5E, 0x06, 0xA6, 0x63, 0x8A, 0x63, 0x4A]);
interface IGPM2 : IGPM
{
    HRESULT GetBackupDirEx(BSTR bstrBackupDir, GPMBackupType backupDirType, IGPMBackupDirEx* ppIGPMBackupDirEx);
    HRESULT InitializeReportingEx(BSTR bstrAdmPath, int reportingOptions);
}

const GUID IID_IGPMStarterGPO = {0xDFC3F61B, 0x8880, 0x4490, [0x93, 0x37, 0xD2, 0x9C, 0x7B, 0xA8, 0xC2, 0xF0]};
@GUID(0xDFC3F61B, 0x8880, 0x4490, [0x93, 0x37, 0xD2, 0x9C, 0x7B, 0xA8, 0xC2, 0xF0]);
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
    HRESULT Save(BSTR bstrSaveFile, short bOverwrite, short bSaveAsSystem, VARIANT* bstrLanguage, VARIANT* bstrAuthor, VARIANT* bstrProduct, VARIANT* bstrUniqueID, VARIANT* bstrVersion, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT CopyTo(VARIANT* pvarNewDisplayName, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

const GUID IID_IGPMStarterGPOCollection = {0x2E522729, 0x2219, 0x44AD, [0x93, 0x3A, 0x64, 0xDF, 0xD6, 0x50, 0xC4, 0x23]};
@GUID(0x2E522729, 0x2219, 0x44AD, [0x93, 0x3A, 0x64, 0xDF, 0xD6, 0x50, 0xC4, 0x23]);
interface IGPMStarterGPOCollection : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTemplates);
}

const GUID IID_IGPMDomain2 = {0x7CA6BB8B, 0xF1EB, 0x490A, [0x93, 0x8D, 0x3C, 0x4E, 0x51, 0xC7, 0x68, 0xE6]};
@GUID(0x7CA6BB8B, 0xF1EB, 0x490A, [0x93, 0x8D, 0x3C, 0x4E, 0x51, 0xC7, 0x68, 0xE6]);
interface IGPMDomain2 : IGPMDomain
{
    HRESULT CreateStarterGPO(IGPMStarterGPO* ppnewTemplate);
    HRESULT CreateGPOFromStarterGPO(IGPMStarterGPO pGPOTemplate, IGPMGPO* ppnewGPO);
    HRESULT GetStarterGPO(BSTR bstrGuid, IGPMStarterGPO* ppTemplate);
    HRESULT SearchStarterGPOs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMStarterGPOCollection* ppIGPMTemplateCollection);
    HRESULT LoadStarterGPO(BSTR bstrLoadFile, short bOverwrite, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT RestoreStarterGPO(IGPMStarterGPOBackup pIGPMTmplBackup, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
}

const GUID IID_IGPMConstants2 = {0x05AE21B0, 0xAC09, 0x4032, [0xA2, 0x6F, 0x9E, 0x7D, 0xA7, 0x86, 0xDC, 0x19]};
@GUID(0x05AE21B0, 0xAC09, 0x4032, [0xA2, 0x6F, 0x9E, 0x7D, 0xA7, 0x86, 0xDC, 0x19]);
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

const GUID IID_IGPMGPO2 = {0x8A66A210, 0xB78B, 0x4D99, [0x88, 0xE2, 0xC3, 0x06, 0xA8, 0x17, 0xC9, 0x25]};
@GUID(0x8A66A210, 0xB78B, 0x4D99, [0x88, 0xE2, 0xC3, 0x06, 0xA8, 0x17, 0xC9, 0x25]);
interface IGPMGPO2 : IGPMGPO
{
    HRESULT get_Description(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
}

const GUID IID_IGPMDomain3 = {0x0077FDFE, 0x88C7, 0x4ACF, [0xA1, 0x1D, 0xD1, 0x0A, 0x7C, 0x31, 0x0A, 0x03]};
@GUID(0x0077FDFE, 0x88C7, 0x4ACF, [0xA1, 0x1D, 0xD1, 0x0A, 0x7C, 0x31, 0x0A, 0x03]);
interface IGPMDomain3 : IGPMDomain2
{
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    HRESULT get_InfrastructureDC(BSTR* pVal);
    HRESULT put_InfrastructureDC(BSTR newVal);
    HRESULT put_InfrastructureFlags(uint dwFlags);
}

const GUID IID_IGPMGPO3 = {0x7CF123A1, 0xF94A, 0x4112, [0xBF, 0xAE, 0x6A, 0xA1, 0xDB, 0x9C, 0xB2, 0x48]};
@GUID(0x7CF123A1, 0xF94A, 0x4112, [0xBF, 0xAE, 0x6A, 0xA1, 0xDB, 0x9C, 0xB2, 0x48]);
interface IGPMGPO3 : IGPMGPO2
{
    HRESULT get_InfrastructureDC(BSTR* pVal);
    HRESULT put_InfrastructureDC(BSTR newVal);
    HRESULT put_InfrastructureFlags(uint dwFlags);
}

