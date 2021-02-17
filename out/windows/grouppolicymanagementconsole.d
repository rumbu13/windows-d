// Written in the D programming language.

module windows.grouppolicymanagementconsole;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT, VARIANT;
public import windows.com : HRESULT;

extern(Windows):


// Enums


alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0001 = int;
enum : int
{
    rsopUnknown  = 0x00000000,
    rsopPlanning = 0x00000001,
    rsopLogging  = 0x00000002,
}

///GPMPermissionType defines the categories, permissions included in the categories, and the object to which they can be
///applied.
enum GPMPermissionType : int
{
    ///The trustee can apply the GPO; corresponds to the READ and APPLY Group Policy access rights being set to "Allow"
    ///for a user.
    permGPOApply                 = 0x00010000,
    ///The trustee can read the GPO; corresponds to the READ Group Policy access right set to "Allow" for a user.
    permGPORead                  = 0x00010100,
    ///The trustee can read and edit the policy settings for the GPO; corresponds to the READ, WRITE, CREATE CHILD
    ///OBJECT, and DELETE CHILD OBJECT Group Policy access rights set to "Allow" for a user.
    permGPOEdit                  = 0x00010101,
    ///The trustee can read, edit and delete the permissions for the GPO; corresponds to the Group Policy access rights
    ///specified by <b>permGPOEdit</b> plus the DELETE, MODIFY PERMISSIONS, and MODIFY OWNER access rights set to
    ///"Allow" for a user.
    permGPOEditSecurityAndDelete = 0x00010102,
    ///The trustee has custom permissions for the GPO.
    permGPOCustom                = 0x00010103,
    ///The trustee can edit the WMI filter.
    permWMIFilterEdit            = 0x00020000,
    ///The trustee has full control over the WMI filter.
    permWMIFilterFullControl     = 0x00020001,
    ///The trustee has custom permissions for the WMI filter.
    permWMIFilterCustom          = 0x00020002,
    ///he trustee can link GPOs to the SOM. Applies to sites, domains and OUs.
    permSOMLink                  = 0x001c0000,
    ///The trustee can generate RSoP logging data for the SOM. Applies to domains and OUs.
    permSOMLogging               = 0x00180100,
    ///The trustee can generate RSoP planning data for the SOM. Applies to domains and OUs.
    permSOMPlanning              = 0x00180200,
    ///The trustee can create WMI filters in the domain. Applies to domains only.
    permSOMWMICreate             = 0x00100300,
    ///The trustee has full control over all WMI filters in the domain. Applies to domains only.
    permSOMWMIFullControl        = 0x00100301,
    ///The trustee can create GPOs in the domain. Applies to domains only.
    permSOMGPOCreate             = 0x00100400,
    ///The trustee can read the Starter GPO; corresponds to the READ Group Policy access right set to "Allow" for a
    ///user.
    permStarterGPORead           = 0x00030500,
    ///The trustee can read and edit the administrative template policy settings for the Starter GPO; corresponds to the
    ///READ, WRITE, CREATE CHILD OBJECT, and DELETE CHILD OBJECT Group Policy access rights set to "Allow" for a user.
    permStarterGPOEdit           = 0x00030501,
    ///The trustee has full control for the Starter GPO. Applies to domains only.
    permStarterGPOFullControl    = 0x00030502,
    ///The trustee has custom permissions for the Starter GPO.
    permStarterGPOCustom         = 0x00030503,
    permSOMStarterGPOCreate      = 0x00100500,
}

///<b>GPMSearchProperty</b> defines the property of the search criteria. The property of the search criteria. ```cpp
///typedef enum {gpoPermissions, gpoEffectivePermissions, gpoDisplayName, gpoWMIFilter, gpoID, gpoComputerExtensions,
///gpoUserExtensions, somLinks, gpoDomain, backupMostRecent, starterGPOPermissions, starterGPOEffectivePermissions,
///starterGPODisplayName, starterGPOID, starterGPODomain} GPMSearchProperty; ```
enum GPMSearchProperty : int
{
    ///The specified level of permission for a Group Policy Object.
    gpoPermissions                 = 0x00000000,
    ///A specific set of permissions, whether the permissions are explicitly set or derived as a result of group
    ///membership.
    gpoEffectivePermissions        = 0x00000001,
    ///Display name of a Group Policy object.
    gpoDisplayName                 = 0x00000002,
    ///Display name of a WMI filter.
    gpoWMIFilter                   = 0x00000003,
    ///GUID of a Group Policy object.
    gpoID                          = 0x00000004,
    ///Computer client-side extension
    gpoComputerExtensions          = 0x00000005,
    ///user client-side extension
    gpoUserExtensions              = 0x00000006,
    ///Scope of Management (SOM) that link to a Group Policy object.
    somLinks                       = 0x00000007,
    ///domain name
    gpoDomain                      = 0x00000008,
    ///The most recent backup
    backupMostRecent               = 0x00000009,
    ///The specified level of permission for a Starter Group Policy Object.
    starterGPOPermissions          = 0x0000000a,
    ///A specific set of permissions, whether the permissions are explicitly set or derived as a result of group
    ///membership.
    starterGPOEffectivePermissions = 0x0000000b,
    ///Display name of a Starter Group Policy object.
    starterGPODisplayName          = 0x0000000c,
    ///GUID of a Starter Group Policy object.
    starterGPOID                   = 0x0000000d,
    starterGPODomain               = 0x0000000e,
}

alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0004 = int;
enum : int
{
    opEquals      = 0x00000000,
    opContains    = 0x00000001,
    opNotContains = 0x00000002,
    opNotEquals   = 0x00000003,
}

alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0005 = int;
enum : int
{
    repXML                    = 0x00000000,
    repHTML                   = 0x00000001,
    repInfraXML               = 0x00000002,
    repInfraRefreshXML        = 0x00000003,
    repClientHealthXML        = 0x00000004,
    repClientHealthRefreshXML = 0x00000005,
}

alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0006 = int;
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

alias __MIDL___MIDL_itf_gpmgmt_0000_0000_0007 = int;
enum : int
{
    opDestinationSameAsSource   = 0x00000000,
    opDestinationNone           = 0x00000001,
    opDestinationByRelativeName = 0x00000002,
    opDestinationSet            = 0x00000003,
}

///<b>GPMReportingOptions</b> defines options for Group Policy Management Console reports. <b>GPMReportingOptions</b>
///defines options for Group Policy Management Console reports. ```cpp typedef enum { opReportLegacy = 0,
///opReportComments = 1, } GPMReportingOptions; ```
enum GPMReportingOptions : int
{
    ///Use administrative template ADM files.
    opReportLegacy   = 0x00000000,
    opReportComments = 0x00000001,
}

alias __MIDL_IGPMSOM_0001 = int;
enum : int
{
    somSite   = 0x00000000,
    somDomain = 0x00000001,
    somOU     = 0x00000002,
}

///<b>GPMBackupType</b> defines the type of backup created. <b>GPMBackupType</b> determines whether the backup is for a
///Group Policy object or a Starter Group Policy object. ```cpp typedef enum { typeGPO = 0, typeStarterGPO }
///GPMBackupType; ```
enum GPMBackupType : int
{
    ///Backup of a Group Policy object.
    typeGPO        = 0x00000000,
    typeStarterGPO = 0x00000001,
}

///<b>GPMStarterGPOType</b> defines if the Starter Group Policy object is a system Starter Group Policy object or a
///custom Starter Group Policy object. <b>GPMStarterGPOType</b> defines if the Starter Group Policy object is a system
///Starter Group Policy object or a custom Starter Group Policy object. ```cpp typedef enum { typeSystem = 0, typeCustom
///} GPMStarterGPOType; ```
enum GPMStarterGPOType : int
{
    ///A system Starter Group Policy object
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

///The <b>IGPM</b> interface provides methods that access other interfaces of the Group Policy Management Console (GPMC)
///and methods that create other objects on which various search operations can be performed. The <b>GPM</b> object is
///the only object used with the CoCreateInstance function.
@GUID("F5FAE809-3BD6-4DA9-A65E-17665B41D763")
interface IGPM : IDispatch
{
    ///Creates and returns a GPMDomain object that corresponds to the specified domain. The object allows you to do the
    ///following: <ul> <li>Create, query, and restore Group Policy objects (GPOs)</li> <li>Search scope of management
    ///(SOM) objects</li> <li>Search and retrieve Windows Management Instrumentation (WMI) filters</li> </ul>
    ///Params:
    ///    bstrDomain = Name of the domain specified as a string. This must be a full Domain Name System (DNS) name, such as
    ///                 contoso.com.
    ///    bstrDomainController = If specified, the name of the domain controller to use with the domain. The name can be a DNS name or a
    ///                           NetBIOS name. Otherwise, the method uses the primary domain controller (PDC). For more information, see the
    ///                           <i>lDCFlags</i> parameter. <b>Scripting: </b>This parameter must pass an empty string ("") when a domain
    ///                           controller is not specified.
    ///    lDCFlags = Flags to use to locate the domain controller for the domain. You can specify <b>GPM_USE_ANYDC</b>,
    ///               <b>GPM_USE_PDC</b>, or <b>GPM_DONOTUSE_W2KDC</b>. If this parameter is set to zero, and a
    ///               <i>bstrDomainController</i> is specified, the method uses the specified <i>bstrDomainController</i>.
    ///               Otherwise, the method uses the PDC.
    ///    pIGPMDomain = Address of a pointer to the IGPMDomain interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMDomain</b> object. <h3>VB</h3> Returns a reference to a <b>GPMDomain</b>
    ///    object.
    ///    
    HRESULT GetDomain(BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, IGPMDomain* pIGPMDomain);
    ///Creates and returns a GPMBackupDir object, which you can use to access the GPMBackup and GPMBackupCollection
    ///objects.
    ///Params:
    ///    bstrBackupDir = Required. The name of the file system directory that contains the Group Policy object (GPO) backups. The
    ///                    directory must already exist.
    ///    pIGPMBackupDir = Address of a pointer to the IGPMBackupDir interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMBackupDir</b> object. <h3>VB</h3> Returns a reference to a <b>GPMBackupDir</b>
    ///    object.
    ///    
    HRESULT GetBackupDir(BSTR bstrBackupDir, IGPMBackupDir* pIGPMBackupDir);
    ///Creates and returns a GPMSitesContainer object from which sites can be opened and queried.
    ///Params:
    ///    bstrForest = Required. Full DNS name of the forest in which to access sites; this is the name of the forest root domain.
    ///                 Use null-terminated string.
    ///    bstrDomain = Name of the domain in which to access sites. If specified, this must be a full Domain Name Server (DNS) name,
    ///                 such as example.microsoft.com. If a domain is specified in the <i>bstrDomain</i> parameter, the Group Policy
    ///                 Management Console (GPMC) accesses sites through that domain. If no domain is specified, the GPMC accesses
    ///                 the sites through the forest that is specified in the <i>bstrForest</i> parameter. Use a null-terminated
    ///                 string.
    ///    bstrDomainController = If specified, the name of the domain controller to use with the domain specified in the <i>bstrDomain</i>
    ///                           parameter. The name can be a DNS name or a NetBIOS name. Otherwise, the method uses the primary domain
    ///                           controller (PDC). Use a null-terminated string.
    ///    lDCFlags = Flags to use to locate the domain controller for the domain. Currently, the only supported value is
    ///               GPM_USE_ANYDC. If this parameter is set to zero, and <i>bstrDomainController</i> is specified, the method
    ///               uses the specified domain controller. Otherwise, the method uses the PDC.
    ///    ppIGPMSitesContainer = Address of a pointer to the IGPMSitesContainer interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMSitesContainer object. <h3>VB</h3> Returns a reference to a GPMSitesContainer
    ///    object.
    ///    
    HRESULT GetSitesContainer(BSTR bstrForest, BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, 
                              IGPMSitesContainer* ppIGPMSitesContainer);
    ///Creates and returns an GPMRSOP. You can specify the Resultant Set of Policy (RSoP) mode and a Windows Management
    ///Instrumentation (WMI) namespace.
    ///Params:
    ///    gpmRSoPMode = Required. Mode in which to open the object. The following modes are supported.
    ///    bstrNamespace = WMI namespace for the IGPMRSOP<b>GPMRSOP</b><b>GPMRSOP</b>. Use a null-terminated string. This parameter can
    ///                    be <b>NULL</b>. For more information about how to retrieve the namespace, see the "Remarks" section.
    ///    lFlags = This parameter must be zero.
    ///    ppIGPMRSOP = Address of a pointer to the IGPMRSOP interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMRSOP object. <h3>VB</h3> Returns a reference to a GPMRSOP object.
    ///    
    HRESULT GetRSOP(__MIDL___MIDL_itf_gpmgmt_0000_0000_0001 gpmRSoPMode, BSTR bstrNamespace, int lFlags, 
                    IGPMRSOP* ppIGPMRSOP);
    ///Creates and returns an interface or object that represents the trustee (such as a user, computer or security
    ///group) and permission that applies to a single object; for example, to a GPO, SOM or a WMI filter.
    ///Params:
    ///    bstrTrustee = Required. Trustee name. This parameter can be a string that specifies the security identifier (SID) of the
    ///                  account. This parameter can also be a Security Accounts Manager (SAM) account name, such as
    ///                  "Engineering\JSmith".
    ///    perm = Required. Permission to use for the trustee. The following policy-related permissions are supported. Note
    ///           that each permission value represents one or more access rights that apply to the GPO. The following GPO
    ///           permissions are supported.
    ///    bInheritable = <table> <tr> <td><strong>C++</strong></td> <td> <b>VARIANT_BOOL</b>. If <b>VARIANT_TRUE</b>, children inherit
    ///                   the permission. Note that this parameter is significant only when you add permissions to security information
    ///                   using the IGPMSecurityInfo::Add method. This parameter is ignored for searches. </td> </tr> <tr>
    ///                   <td><strong>JScript</strong></td> <td> If true, children inherit the permission. Note that this parameter is
    ///                   significant only when you add permissions to security information using the GPMSecurityInfo.Add method. This
    ///                   parameter is ignored for searches. </td> </tr> </table>
    ///    ppPerm = Address of a pointer to the IGPMPermission interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMPermission</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMPermission</b> object.
    ///    
    HRESULT CreatePermission(BSTR bstrTrustee, GPMPermissionType perm, short bInheritable, IGPMPermission* ppPerm);
    ///Creates and returns a GPMSearchCriteria that represents the criteria to use for performing search operations when
    ///you use the Group Policy Management Console (GPMC) interfaces.
    ///Params:
    ///    ppIGPMSearchCriteria = Address of a pointer to the IGPMSearchCriteria interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMSearchCriteria</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMSearchCriteria</b> object.
    ///    
    HRESULT CreateSearchCriteria(IGPMSearchCriteria* ppIGPMSearchCriteria);
    ///Creates and returns a GPMTrustee from which you can retrieve information about a trustee. A trustee is a user,
    ///computer, or security group that can be granted permissions on a Group Policy object (GPO), scope of management
    ///(SOM), or Windows Management Instrumentation (WMI) filter.
    ///Params:
    ///    bstrTrustee = Required. Trustee name or the security identifier (SID). Names are in a format that is compatible with
    ///                  Security Accounts Manager (SAM), such as <i>Exampledomain</i>&
    ///    ppIGPMTrustee = Address of a pointer to the IGPMTrustee interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMTrustee object. <h3>VB</h3> Returns a reference to a GPMTrustee object.
    ///    
    HRESULT CreateTrustee(BSTR bstrTrustee, IGPMTrustee* ppIGPMTrustee);
    ///Creates and returns a GPMCSECollection object that allows you to enumerate Group Policy client-side extensions
    ///(CSEs) that are registered on the local computer.
    ///Params:
    ///    ppIGPMCSECollection = Address of a pointer to the IGPMCSECollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMCSECollection</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMCSECollection</b> object.
    ///    
    HRESULT GetClientSideExtensions(IGPMCSECollection* ppIGPMCSECollection);
    ///Creates and returns a GPMConstants object that allows you to retrieve the value of multiple Group Policy
    ///Management Console (GPMC) constants.
    ///Params:
    ///    ppIGPMConstants = Address of a pointer to the IGPMConstants interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMConstants object. <h3>VB</h3> Returns a reference to a GPMConstants object.
    ///    
    HRESULT GetConstants(IGPMConstants* ppIGPMConstants);
    ///Loads the migration table at a specified path.
    ///Params:
    ///    bstrMigrationTablePath = The path of the migration table to be loaded. Use a null-terminated string.
    ///    ppMigrationTable = The migration table interface that contains the entries from the migration table.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMMigrationTable</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMMigrationTable</b> object.
    ///    
    HRESULT GetMigrationTable(BSTR bstrMigrationTablePath, IGPMMigrationTable* ppMigrationTable);
    ///Creates an empty migration table.
    ///Params:
    ///    ppMigrationTable = Receives the created migration table that contains no entries. See IGPMMigrationTable.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMMigrationTable</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMMigrationTable</b> object.
    ///    
    HRESULT CreateMigrationTable(IGPMMigrationTable* ppMigrationTable);
    ///The <b>InitializeReporting</b> method sets the location to search for .adm files. This method initializes
    ///reporting in an asynchronous manner. For both Group Policy object (GPO) reporting or Resultant Set of Policy
    ///(RSOP) reporting, the Group Policy Management Console (GPMC) searches for and loads .adm files in the following
    ///order. First it searches for the specified .adm files in the specified location. Then it searches for any
    ///additional .adm files in the default location. Finally it searches the GPO or RSoP for any additional .adm files.
    ///Params:
    ///    bstrAdmPath = Location to search for .adm files. Use a null-terminated string.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT InitializeReporting(BSTR bstrAdmPath);
}

///The <b>IGPMDomain</b> interface represents a specific domain and supports methods that allow you to perform the
///following tasks when you are using the Group Policy Management Console (GPMC) interfaces: <ul> <li>Query scope of
///management (SOM) objects.</li> <li>Create, restore and query Group Policy objects (GPOs).</li> <li>Create and query
///Windows Management Instrumentation (WMI) filters.</li> </ul>To create a <b>GPMDomain</b> object, call the
///IGPM::GetDomain method.
@GUID("6B21CC14-5A00-4F44-A738-FEEC8A94C7E3")
interface IGPMDomain : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    ///Creates and retrieves a GPMGPO object with a default display name. Typically, the caller sets the display name
    ///immediately after calling this method.
    ///Params:
    ///    ppNewGPO = Address of a pointer to the IGPMGPO interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMGPO</b> object. <h3>VB</h3> Returns a reference to a <b>GPMGPO</b> object.
    ///    
    HRESULT CreateGPO(IGPMGPO* ppNewGPO);
    ///Retrieves a GPMGPO object with a specified Group Policy object (GPO) ID. The group policy object ID is
    ///represented by a GUID.
    ///Params:
    ///    bstrGuid = Required. GUID representing the ID of the group policy object to access. Use null-terminated string.
    ///    ppGPO = Address of a pointer to the IGPMGPO interface for the group policy object ID and domain specified.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMGPO object. <h3>VB</h3> Returns a reference to a GPMGPO object.
    ///    
    HRESULT GetGPO(BSTR bstrGuid, IGPMGPO* ppGPO);
    ///Executes a search for GPMGPO objects in the domain and then returns a GPMGPOCollection object.
    ///Params:
    ///    pIGPMSearchCriteria = GPMSearchCriteria object to apply to the search. Pointer to the criteria to apply to the search.
    ///    ppIGPMGPOCollection = Address of a pointer to the IGPMGPOCollection interface representing the GPOs found by the search.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMGPOCollection object. <h3>VB</h3> Returns a reference to a GPMGPOCollection
    ///    object.
    ///    
    HRESULT SearchGPOs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMGPOCollection* ppIGPMGPOCollection);
    ///Restores a Group Policy object (GPO) from a GPMBackup object. You can only restore a GPO to the domain in which
    ///the GPO was originally created because the operation restores the GPO with its original GPO ID, policy settings,
    ///access control lists (ACLs), and links to Windows Management Instrumentation (WMI) filters.
    ///Params:
    ///    pIGPMBackup = Pointer to the GPMBackup object to restore.
    ///    lDCFlags = Flags to use for validation. If this parameter is set to zero, the method validates the domain controller to
    ///               determine whether the restore operation can be performed. If you specify <b>GPM_DONOT_VALIDATEDC</b>, the
    ///               method does not validate the DC. This parameter is ignored for GPOs that do not include software policy
    ///               settings. For more information about validation, see the "Remarks" section.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications
    ///                      about the progress of the restore operation. To receive asynchronous notifications, the caller must create
    ///                      this interface and then pass the interface pointer in this parameter. This parameter must be <b>NULL</b> if
    ///                      the client should not receive asynchronous notifications. The method will run asynchronously if this
    ///                      parameter is not <b>NULL</b> and will run synchronously if <b>NULL</b>.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the restore operation.
    ///                    This parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface that represents the result of the restore operation. That
    ///                   interface contains pointers to an IGPMGPO interface and an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. Returns
    ///    <b>E_OPERATION_NOT_SUPPORTED_ONDC</b> if the current domain controller is running an old Windows Server
    ///    version and the backed-up GPO contains software policy settings. <h3>JScript</h3> Returns a reference to a
    ///    GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT RestoreGPO(IGPMBackup pIGPMBackup, int lDCFlags, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                       IGPMResult* ppIGPMResult);
    ///Retrieves the IGPMSOM interface that represents the domain or the organizational unit (OU) at the specified path.
    ///Params:
    ///    bstrPath = Path of the scope of management (SOM) object. The path must be a fully qualified distinguished name. Use the
    ///               following syntax for the path: (ou=<i>MyOU</i>,dc=<i>domain_name</i>,dc=<i>com</i>). <b>C++: </b>If
    ///               <b>NULL</b> is specified, the method returns a pointer to the <b>IGPMSOM</b> interface for the domain.
    ///               <b>Scripting: </b>If an empty string ("") is specified, the method returns a pointer to the <b>IGPMSOM</b>
    ///               interface for the domain.
    ///    ppSOM = Address of a pointer to the IGPMSOM interface at the specified path.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMSOM</b> object. <h3>VB</h3> Returns a reference to a <b>GPMSOM</b> object.
    ///    
    HRESULT GetSOM(BSTR bstrPath, IGPMSOM* ppSOM);
    ///Executes a search for GPMSOM objects (domains and organizational units) in the domain and then returns a
    ///GPMSOMCollection object.
    ///Params:
    ///    pIGPMSearchCriteria = GPMSearchCriteria object to apply to the search.
    ///    ppIGPMSOMCollection = Address of a pointer to the IGPMSOMCollection interface that represents the scopes of management (SOMs) found
    ///                          by the search.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMSOMCollection</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMSOMCollection</b> object.
    ///    
    HRESULT SearchSOMs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
    ///Retrieves a GPMWMIFilter object for the specified path.
    ///Params:
    ///    bstrPath = Path of the GPMWMIFilter object to retrieve, in the following format: MSFT_SomFilter.Domain="<i>&lt;domain of
    ///               the WMI filter&gt;</i>", ID="<i>&lt;GUID that represents the WMI filter&gt;</i>". Consider this example:
    ///               MSFT_SomFilter.Domain="example.microsoft.com", ID="{7ab06d20-5e0a-4de9-8170-13dea779a528}".
    ///    ppWMIFilter = Address of a pointer to the IGPMWMIFilter interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMWMIFilter object. <h3>VB</h3> Returns a reference to a GPMWMIFilter object.
    ///    
    HRESULT GetWMIFilter(BSTR bstrPath, IGPMWMIFilter* ppWMIFilter);
    ///Executes a search for GPMWMIFilter objects in the domain and then returns a GPMWMIFilterCollection object.
    ///Params:
    ///    pIGPMSearchCriteria = This parameter should be <b>NULL</b>, or it should point to an empty IGPMSearchCriteria interface, because no
    ///                          search criteria are allowed for Windows Management Instrumentation (WMI) filters.
    ///    ppIGPMWMIFilterCollection = Address of a pointer to the IGPMWMIFilterCollection interface that represents the WMI filters found by the
    ///                                search.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMWMIFilterCollection object. <h3>VB</h3> Returns a reference to a
    ///    GPMWMIFilterCollection object.
    ///    
    HRESULT SearchWMIFilters(IGPMSearchCriteria pIGPMSearchCriteria, 
                             IGPMWMIFilterCollection* ppIGPMWMIFilterCollection);
}

///The <b>IGPMBackupDir</b> interface supports methods that allow you to query GPMBackup and GPMBackupCollection objects
///when you use the Group Policy Management Console (GPMC) interfaces. To create a <b>GPMBackupDir</b> object, call the
///IGPM::GetBackupDir method.
@GUID("B1568BED-0A93-4ACC-810F-AFE7081019B9")
interface IGPMBackupDir : IDispatch
{
    HRESULT get_BackupDirectory(BSTR* pVal);
    ///Retrieves the <b>GPMBackup</b> object that has the specified backup ID (GUID). The backup ID is the ID of the
    ///backed-up GPO, not the ID of the GPO.
    ///Params:
    ///    bstrID = ID of the IGPMBackup object to open.
    ///    ppBackup = Address of a pointer to the IGPMBackup interface for the specified ID.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMBackup object. <h3>VB</h3> Returns a reference to a GPMBackup object.
    ///    
    HRESULT GetBackup(BSTR bstrID, IGPMBackup* ppBackup);
    ///Executes a search for the GPMBackup object according to the specified criteria, and returns an
    ///GPMBackupCollection object.
    ///Params:
    ///    pIGPMSearchCriteria = Pointer to the criteria to apply to the search.
    ///    ppIGPMBackupCollection = Address of a pointer to the IGPMBackupCollection interface that represents the IGPMBackup objects found by
    ///                             the search.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMBackupCollection</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMBackupCollection</b> object.
    ///    
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, IGPMBackupCollection* ppIGPMBackupCollection);
}

///The <b>IGPMSitesContainer</b> interface provides the methods required to access the scope of management (SOM) objects
///that represent sites in a forest. The <b>GPMSitesContainer</b> object represents the forest-level container that
///contains the actual sites in a forest. To create a <b>GPMSitesContainer</b> object, call the IGPM::GetSitesContainer
///method.
@GUID("4725A899-2782-4D27-A6BB-D499246FFD72")
interface IGPMSitesContainer : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT get_Forest(BSTR* pVal);
    ///Returns the scope of management (SOM) object that corresponds to the site.
    ///Params:
    ///    bstrSiteName = Required. The site of interest; for example, Default-first-site-name. Use null-terminated string.
    ///    ppSOM = Address of a pointer to the IGPMSOM interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMSOM</b> object. <h3>VB</h3> Returns a reference to a <b>GPMSOM</b> object.
    ///    
    HRESULT GetSite(BSTR bstrSiteName, IGPMSOM* ppSOM);
    ///Retrieves a collection of scope of management (SOM) objects based on the specified search criteria. This method
    ///returns only site objects.
    ///Params:
    ///    pIGPMSearchCriteria = Pointer to criteria to supply to the search. Valid criteria for the search include the following.
    ///    ppIGPMSOMCollection = Address of a pointer to the IGPMSOMCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMSOMCollection</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMSOMCollection</b> object.
    ///    
    HRESULT SearchSites(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
}

///The <b>IGPMSearchCriteria</b> interface allows you to define the criteria to use for search operations when using the
///Group Policy Management Console (GPMC) interfaces. To create a <b>GPMSearchCriteria</b> object, call the
///IGPM::CreateSearchCriteria method.
@GUID("D6F11C42-829B-48D4-83F5-3615B67DFC22")
interface IGPMSearchCriteria : IDispatch
{
    ///Adds a criterion for search operations.
    ///Params:
    ///    searchProperty = The search property to evaluate. For a valid combination of search properties, search operations, and values,
    ///                     see the Remarks section.
    ///    searchOperation = The operation to use to evaluate <i>searchProperty</i> using the value specified by <i>varValue</i>.
    ///    varValue = The value to evaluate <i>searchProperty</i> against.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Add(GPMSearchProperty searchProperty, __MIDL___MIDL_itf_gpmgmt_0000_0000_0004 searchOperation, 
                VARIANT varValue);
}

///The <b>IGPMTrustee</b> interface contains methods to retrieve information about a given trustee when using the Group
///Policy Management Console (GPMC). The <b>GPMTrustee</b> object represents a user, group or security group in the
///domain. To create a <b>GPMTrustee</b> object, call the IGPM::CreateTrustee method.
@GUID("3B466DA8-C1A4-4B2A-999A-BEFCDD56CEFB")
interface IGPMTrustee : IDispatch
{
    HRESULT get_TrusteeSid(BSTR* bstrVal);
    HRESULT get_TrusteeName(BSTR* bstrVal);
    HRESULT get_TrusteeDomain(BSTR* bstrVal);
    HRESULT get_TrusteeDSPath(BSTR* pVal);
    HRESULT get_TrusteeType(int* lVal);
}

///The <b>IGPMPermission</b> interface contains methods to retrieve permission-related properties when using the GPMC.
///The <b>GPMPermission</b> object represents the pairing of a trustee (such as a user or security group) and a
///policy-related permission that applies to a single object; for example, to a GPO or a WMI filter. To create a
///<b>GPMPermission</b> object, call the IGPM::CreatePermission method.
@GUID("35EBCA40-E1A1-4A02-8905-D79416FB464A")
interface IGPMPermission : IDispatch
{
    HRESULT get_Inherited(short* pVal);
    HRESULT get_Inheritable(short* pVal);
    HRESULT get_Denied(short* pVal);
    HRESULT get_Permission(GPMPermissionType* pVal);
    HRESULT get_Trustee(IGPMTrustee* ppIGPMTrustee);
}

///The <b>IGPMSecurityInfo</b> interface defines the methods of the <b>GPMSecurityInfo</b> collection. This collection
///represents a set of policy-related permissions that can be set on a particular object, such as a scope of management
///(SOM), a GPO, or a WMI filter.
@GUID("B6C31ED4-1C93-4D3E-AE84-EB6D61161B60")
interface IGPMSecurityInfo : IDispatch
{
    ///Returns the number of GPMPermission objects in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a GPMPermission object from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    ppEnum = Pointer to an IEnumVARIANT interface of an enumerator object for the collection. <b>IEnumVARIANT</b> provides
    ///             a number of methods that you can use to iterate through the collection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppEnum);
    ///Adds the permission specified in a GPMPermission object to the GPMSecurityInfo collection. You can add a
    ///permission that is above the level of existing permissions. For more information about restrictions that apply,
    ///see the following Remarks section.
    ///Params:
    ///    pPerm = Pointer to the <b>GPMPermission</b> object to add to the collection.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Add(IGPMPermission pPerm);
    ///Removes the permission specified in a given GPMPermission object from the GPMSecurityInfo collection.
    ///Params:
    ///    pPerm = Pointer to the <b>GPMPermission</b> object to remove from the collection.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Remove(IGPMPermission pPerm);
    ///Removes all policy-related permissions for the specified trustee. A trustee is a user, computer, or security
    ///group that can be granted permissions on a GPO, SOM, or WMI filter.
    ///Params:
    ///    bstrTrustee = Required. The name or SID of the trustee for which all permissions should be removed. Names are in Security
    ///                  Accounts Manager (SAM) compatible format (Exampledomain\Someone). Use null-terminated string.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT RemoveTrustee(BSTR bstrTrustee);
}

///The <b>IGPMBackup</b> interface supports methods that allow you to delete <b>GPMBackup</b> objects and to retrieve
///various properties of <b>GPMBackup</b> objects.
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
    ///Removes the Group Policy object (GPO) backup from the backup directory and from the file system.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Delete();
    ///Gets the report for the backup Group Policy object (GPO).
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    pvarGPMProgress = Pointer to an IGPMAsyncProgress interface. If <i>pvarGPMProgress</i> is <b>NULL</b>, the call to
    ///                      <b>GenerateReport</b> is handled synchronously. If not <b>NULL</b>, the call to <b>GenerateReport</b> is
    ///                      handled asynchronously, and<i>pvarGPMCancel</i> returns a pointer to IGPMAsyncCancel .
    ///    pvarGPMCancel = Pointer to an IGPMAsyncCancel interface. A value for this parameter is returned only when
    ///                    <i>pvarGPMProgress</i> is specified and is not <b>NULL</b>.
    ///    ppIGPMResult = Pointer to an IGPMResult interface. The <b>Result</b> property contains a string of XML or HTML. The
    ///                   <b>Status</b> property contains a reference to an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///The <b>GenerateReportToFile</b> method gets the report for the backup Group Policy object (GPO) and then saves
    ///the report to a file in a specified path.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    bstrTargetFilePath = Binary string that contains the path of the file in which the report is being saved. Use a null-terminated
    ///                         string.
    ///    ppIGPMResult = Pointer to an IGPMResult interface. The <b>Status</b> property contains a reference to an
    ///                   IGPMStatusMsgCollection interface. <div class="alert"><b>Note</b> The value of the <b>Result</b> property is
    ///                   indeterminate and should not be relied upon.</div> <div> </div>
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b>
    ///    property is indeterminate and should not be relied upon.</div> <div> </div> <h3>VB</h3> Returns a reference
    ///    to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b> property is
    ///    indeterminate and should not be relied upon.</div> <div> </div>
    ///    
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
}

///The <b>IGPMBackupCollection</b> interface contains methods that enable applications to access a collection of
///GPMBackup objects when using the Group Policy Management Console (GPMC) interfaces.
@GUID("C786FC0F-26D8-4BAB-A745-39CA7E800CAC")
interface IGPMBackupCollection : IDispatch
{
    ///Returns the number of GPMBackup objects in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a GPMBackup object from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    ppIGPMBackup = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///                   provides several methods that you can use to iterate through the collection. For more information about
    ///                   <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMBackup);
}

///The <b>IGPMSOM</b> interface contains methods that allow you to create and retrieve GPO links for a scope of
///management (SOM), and to set and retrieve security attributes and various properties for a SOM. A SOM can be a site,
///domain or OU.
@GUID("C0A7F09E-05A1-4F0C-8158-9E5C33684F6B")
interface IGPMSOM : IDispatch
{
    HRESULT get_GPOInheritanceBlocked(short* pVal);
    HRESULT put_GPOInheritanceBlocked(short newVal);
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_Path(BSTR* pVal);
    ///Links the specified GPO to the specified position in the list of GPOs that are linked to a particular SOM. If
    ///another GPO link occupies the specified position, the method inserts the new link ahead of the older link, and
    ///moves the older link, and all subsequent links in the list, down by one.
    ///Params:
    ///    lLinkPos = Position in which the GPO should be linked. The position is 1-based. If this parameter is – 1, the GPO is
    ///               appended to the end of the list. If the position specified is greater than the current number of GPO links,
    ///               the method fails and returns <b>E_INVALIDARG</b>.
    ///    pGPO = GPO to link.
    ///    ppNewGPOLink = Address of a pointer to the IGPMGPOLink interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMGPOLink</b> object. <h3>VB</h3> Returns a reference to a <b>GPMGPOLink</b>
    ///    object.
    ///    
    HRESULT CreateGPOLink(int lLinkPos, IGPMGPO pGPO, IGPMGPOLink* ppNewGPOLink);
    HRESULT get_Type(__MIDL_IGPMSOM_0001* pVal);
    ///Returns a GPMGPOLinksCollection object that contains the GPO links for the scope of management (SOM). The
    ///collection is sorted in the SOM link order and contains both enabled and disabled links. See IGPMGPOLink for the
    ///definition of SOM link order.
    ///Params:
    ///    ppGPOLinks = Address of a pointer to an IGPMGPOLinksCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMGPOLinksCollection object. <h3>VB</h3> Returns a reference to a
    ///    GPMGPOLinksCollection object.
    ///    
    HRESULT GetGPOLinks(IGPMGPOLinksCollection* ppGPOLinks);
    ///Returns a GPOLinksCollection object that contains the GPO links that are applied to the scope of management
    ///(SOM), including links inherited from parent containers (OUs and domains). The collection does not include GPO
    ///links from site SOMs or disabled links. The collection is sorted in order of precedence, with the first
    ///(earliest) link having the highest priority and last (latest) link having the lowest priority. Note that the GPOs
    ///are applied in reverse order of their precedence. The last GPO in the list is applied first and the first GPO in
    ///the list is applied last.
    ///Params:
    ///    ppGPOLinks = Address of a pointer to an IGPMGPOLinksCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPOLinksCollection object. <h3>VB</h3> Returns a reference to a GPOLinksCollection
    ///    object.
    ///    
    HRESULT GetInheritedGPOLinks(IGPMGPOLinksCollection* ppGPOLinks);
    ///Returns an object that represents the collection of GPMPermission objects for the scope of management (SOM).
    ///Params:
    ///    ppSecurityInfo = Address of a pointer to an IGPMSecurityInfo interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMSecurityInfo object. <h3>VB</h3> Returns a reference to a GPMSecurityInfo object.
    ///    
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    ///Sets the list of permissions for the scope of management (SOM) to that of the specified object.
    ///Params:
    ///    pSecurityInfo = Pointer to an IGPMSecurityInfo interface.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

///The <b>IGPMSOMCollection</b> interface represents a collection of GPMSOM objects.
@GUID("ADC1688E-00E4-4495-ABBA-BED200DF0CAB")
interface IGPMSOMCollection : IDispatch
{
    ///Returns the number of SOMs in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a SOM from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    ppIGPMSOM = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///                provides a number of methods that you can use to iterate through the collection. For more information about
    ///                <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMSOM);
}

///The <b>IGPMWMIFilter</b> interface contains methods that allow you to set and retrieve security attributes and
///various properties for a WMI filter. WMI filter queries are specified using WMI Query Language (WQL).
@GUID("EF2FF9B4-3C27-459A-B979-038305CEC75D")
interface IGPMWMIFilter : IDispatch
{
    HRESULT get_Path(BSTR* pVal);
    HRESULT put_Name(BSTR newVal);
    HRESULT get_Name(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
    HRESULT get_Description(BSTR* pVal);
    ///Retrieves the query list stored in the WMI filter.
    ///Params:
    ///    pQryList = Pointer to a <b>SAFEARRAY</b> of <b>VARIANT</b> members that contain the <b>BSTR </b>strings representing the
    ///               queries. Each <b>BSTR</b> string contains the query string along with the namespace information for that
    ///               query.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    An array of strings representing the queries. Each string contains the query string along with the namespace
    ///    information for that query. <h3>VB</h3> An array of strings representing the queries. Each string contains
    ///    the query string along with the namespace information for that query.
    ///    
    HRESULT GetQueryList(VARIANT* pQryList);
    ///Returns an interface or object that represents the list of permissions for the current WMI filter.
    ///Params:
    ///    ppSecurityInfo = Address of a pointer to an IGPMSecurityInfo interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMSecurityInfo object. <h3>VB</h3> Returns a reference to a GPMSecurityInfo object.
    ///    
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    ///Sets the list of permissions for the current WMI filter to that specified by the object.
    ///Params:
    ///    pSecurityInfo = Pointer to an IGPMSecurityInfo interface. This parameter is required.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

///The <b>IGPMWMIFilterCollection</b> interface contains methods that enable applications to access a collection of WMI
///filters when using the Group Policy Management Console (GPMC) interfaces.
@GUID("5782D582-1A36-4661-8A94-C3C32551945B")
interface IGPMWMIFilterCollection : IDispatch
{
    ///Returns the number of WMI filters in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a WMI filter from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    pVal = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///           provides a number of methods that you can use to iterate through the collection. For more information about
    ///           <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

///The <b>IGPMRSOP</b> interface provides methods that support making Resultant Set of Policy (RSoP) queries in both
///logging and planning mode. The typical use of this interface is to set various properties required for a particular
///RSoP query and then to call the CreateQueryResults method. RSoP planning mode requires Windows Server on the domain
///controller used to perform the query. RSoP logging mode requires that the computer being targeted be running Windows
///Server. To create a <b>GPMRSOP</b> object, call the IGPM::GetRSOP method.
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
    ///Enumerates all users who have logging mode data on a specific computer.
    ///Params:
    ///    varVal = Pointer to a SAFEARRAY containing VARIANT members. Each VARIANT contains a Dispatch pointer to the
    ///             IGPMTrustee interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns an array of <b>GPMTrustee</b> object references. Note that the array is a normal array, not a GPMC
    ///    collection. <h3>VB</h3> Returns an array of <b>GPMTrustee</b> object references. Note that the array is a
    ///    normal array, not a GPMC collection.
    ///    
    HRESULT LoggingEnumerateUsers(VARIANT* varVal);
    ///Executes a Resultant Set of Policy (RSoP) query. The method supports both logging mode and planning mode queries.
    ///Before calling this method, set the appropriate logging mode or planning mode properties. For more information
    ///and a list of properties, see IGPMRSOP Property Methods. RSoP planning mode requires a domain controller running
    ///Windows Server to perform the query.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT CreateQueryResults();
    ///Releases the WMI namespace allocated by calls to the IGPMRSOP::CreateQueryResults method and by calls to the
    ///IGPM::GetRSOP method.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT ReleaseQueryResults();
    ///The GenerateReport method generates a report on the RSoP data.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    pvarGPMProgress = Pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications about the
    ///                      progress of report generation. If this parameter is not <b>NULL</b>, the call to <b>GenerateReport</b> is
    ///                      handled asynchronously. If this parameter is <b>NULL</b> the call to <b>GenerateReport</b> is handled
    ///                      synchronously and a pointer to a IGPMAsyncCancel interface is returned in <i>pvarGPMCancel</i>. This
    ///                      parameter must be <b>NULL</b> if the client should not receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the report generation.
    ///                    This parameter is not returned when <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Pointer to an IGPMResult. The <b>Result</b> property contains a binary string of XML or HTML. The Status
    ///                   property contains a reference to an IGPMStatusMsgCollection.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///The <b>GenerateReportToFile</b> method generates a report on the RSoP data and saves it to a file at a specified
    ///path.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    bstrTargetFilePath = Binary string that contains the path to the file where the report is being saved. Use null-terminated string.
    ///                         <div class="alert"><b>Note</b> If the path to the file is not specified, then the report will be created in
    ///                         the "%windir%\system32\" directory.</div> <div> </div>
    ///    ppIGPMResult = Pointer to an IGPMResult interface. The <b>Status</b> property contains a reference to an
    ///                   IGPMStatusMsgCollection. <div class="alert"><b>Note</b> The value of the <b>Result</b> property of the
    ///                   IGPMResult interface is indeterminate and should not be relied upon.</div> <div> </div>
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b>
    ///    property is indeterminate and should not be relied upon.</div> <div> </div> <h3>VB</h3> Returns a reference
    ///    to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b> property is
    ///    indeterminate and should not be relied upon.</div> <div> </div>
    ///    
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
}

///The <b>IGPMGPO</b> interface supports methods that enable you to manage Group Policy Objects (GPOs) in the directory
///service. Note that you cannot use this interface to manage local GPOs (LGPOs). You can instantiate a <b>GPMGPO</b>
///object by creating a new one with a call to IGPMDomain::CreateGPO, retrieving an existing one with a call to
///IGPMDomain::GetGPO, or by searching for one with a call to IGPMDomain::SearchGPOs. After creating the object, you can
///query the GPO and set properties related to the GPO.
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
    ///Retrieves the GPMWMIFilter object linked to the Group Policy object (GPO).
    ///Params:
    ///    ppIGPMWMIFilter = Address of a pointer to the IGPMWMIFilter interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns S_FALSE if no WMI filter is linked to the GPO.
    ///    Returns a failure code if an error occurs. <h3>JScript</h3> If the GPO is linked to a WMI filter, the method
    ///    returns a reference to a GPMWMIFilter object. If the GPO is not linked to a WMI filter, the method returns a
    ///    null reference. <h3>VB</h3> If the GPO is linked to a WMI filter, the method returns a reference to a
    ///    GPMWMIFilter object. If the GPO is not linked to a WMI filter, the method returns a null reference.
    ///    
    HRESULT GetWMIFilter(IGPMWMIFilter* ppIGPMWMIFilter);
    ///Links the GPMWMIFilter object to the current Group Policy object (GPO). This method can also be used to unlink
    ///existing WMI filters from the GPO.
    ///Params:
    ///    pIGPMWMIFilter = Pointer to the WMI filter to associate with the current GPO. Passing <b>NULL</b> in this parameter unlinks
    ///                     any existing WMI filters.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetWMIFilter(IGPMWMIFilter pIGPMWMIFilter);
    ///Enables or disables the user settings in the GPO.
    ///Params:
    ///    vbEnabled = Specifies whether to enable the user settings in the GPO. <b>C++: </b>If <b>VARIANT_TRUE</b>, the method
    ///                enables the settings; otherwise, the method disables them. <b>Scripting: </b>If true, the method enables the
    ///                settings; otherwise, the method disables them.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetUserEnabled(short vbEnabled);
    ///Enables or disables the computer settings in the GPO.
    ///Params:
    ///    vbEnabled = Specifies whether to enable the computer settings in the GPO. <b>C++: </b>If <b>VARIANT_TRUE</b>, the method
    ///                enables the settings; otherwise the method disables them. <b>Scripting: </b>If true, the method enables the
    ///                settings; otherwise the method disables them.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetComputerEnabled(short vbEnabled);
    ///Checks whether the user policies in the GPO are enabled.
    ///Params:
    ///    pvbEnabled = Value that indicates whether the user policies in the GPO are enabled. If <b>VARIANT_TRUE</b>, they are
    ///                 enabled.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Value that indicates whether the user policies in the GPO are enabled. If <b>VARIANT_TRUE</b>, they are
    ///    enabled. <h3>VB</h3> Value that indicates whether the user policies in the GPO are enabled. If
    ///    <b>VARIANT_TRUE</b>, they are enabled.
    ///    
    HRESULT IsUserEnabled(short* pvbEnabled);
    ///Checks whether the computer policies in the GPO are enabled.
    ///Params:
    ///    pvbEnabled = Value that indicates whether the computer policies in the GPO are enabled. If <b>VARIANT_TRUE</b>, they are
    ///                 enabled.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Value that indicates whether the computer policies in the GPO are enabled. If <b>VARIANT_TRUE</b>, they are
    ///    enabled. <h3>VB</h3> Value that indicates whether the computer policies in the GPO are enabled. If
    ///    <b>VARIANT_TRUE</b>, they are enabled.
    ///    
    HRESULT IsComputerEnabled(short* pvbEnabled);
    ///Retrieves the set of permissions for the GPO, such as who is granted permission to edit it.
    ///Params:
    ///    ppSecurityInfo = Address of a pointer to the IGPMSecurityInfo interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMSecurityInfo</b> object. <h3>VB</h3> Returns a reference to a
    ///    <b>GPMSecurityInfo</b> object.
    ///    
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    ///Sets the list of permissions for the group policy object (GPO), such as who is granted permission to edit it. The
    ///method replaces the existing list of permissions.
    ///Params:
    ///    pSecurityInfo = Pointer to the security information to apply to the GPO.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
    ///Deletes a Group Policy object (GPO) from the directory service and from the system volume folder (SYSVOL).
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Delete();
    ///Backs up a Group Policy object (GPO) to the specified directory. A backup operation transfers the contents of a
    ///GPO from the Active Directory directory service to the file system. The backup includes the policy settings, the
    ///GPO ID, and any access control lists (ACLs) that are associated with the GPO. This method is also used for
    ///exporting GPOs to the file system.
    ///Params:
    ///    bstrBackupDir = Name of the file system directory in which the GPMBackup object should be stored. The directory must already
    ///                    exist.
    ///    bstrComment = Comment to associate with the GPMBackup object.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications
    ///                      about the progress of the backup operation. The method runs synchronously if this parameter is <b>NULL</b>.
    ///                      The method runs asynchronously if this parameter is not <b>NULL</b>. This parameter must be <b>NULL</b> if
    ///                      the client should not receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the backup operation.
    ///                    This parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface that represents the result of the backup operation. That
    ///                   interface contains pointers to an IGPMBackup interface and to an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    ///Imports the policy settings from the specified GPMBackup object. An import operation transfers the policy
    ///settings from a backed-up GPO in the file system to a GPO in the Active Directory. The operation erases any
    ///previous policy settings in the destination GPO. The source GPO can be any backed-up GPO in the file system and
    ///the destination GPO must be an existing GPO in the Active Directory.
    ///Params:
    ///    lFlags = Specifies the options to use for security principal and path mapping. The following options are defined. For
    ///             more information, see Copying and Importing GPOs Across Domains.
    ///    pIGPMBackup = Pointer to the GPMBackup object from which settings should be imported.
    ///    pvarMigrationTable = Pointer to a IGPMMigrationTable to use for mapping. This parameter can be <b>NULL</b>.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications
    ///                      about the progress of the import operation. This parameter must be <b>NULL</b> if the client should not
    ///                      receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the import operation.
    ///                    This parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface representing the result of the import operation. That
    ///                   interface contains a pointer to an IGPMStatusMsgCollection interface and an IGPMGPO interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT Import(int lFlags, IGPMBackup pIGPMBackup, VARIANT* pvarMigrationTable, VARIANT* pvarGPMProgress, 
                   VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///Gets the report for a GPO.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    pvarGPMProgress = Pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications about the
    ///                      progress of the copy operation. If not <b>NULL</b>, the call to GenerateReport is handled asynchronously and
    ///                      <i>pvarGPMCancel</i> receives a pointer to an IGPMAsyncCancel interface. If this parameter is <b>NULL</b> the
    ///                      call to <b>GenerateReport</b> is handled synchronously. The <i>pvarGPMProgress</i> parameter must be
    ///                      <b>NULL</b> if the client should not receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the copy operation. This
    ///                    parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Pointer to an IGPMResult interface. The <b>Result</b> property contains a binary string of XML or HTML. The
    ///                   <b>Status</b> property contains a reference to an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///Gets the report for a GPO and then saves the report to a file in a specified path.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    bstrTargetFilePath = Binary string that contains the path of the file in which the report is being saved. Use a null-terminated
    ///                         string.
    ///    ppIGPMResult = Pointer to an IGPMResult interface. The <b>Status</b> property contains a reference to an
    ///                   IGPMStatusMsgCollection. <div class="alert"><b>Note</b> The value of the <b>Result</b> property of the
    ///                   IGPMResult interface is indeterminate and should not be relied upon.</div> <div> </div>
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b>
    ///    property is indeterminate and should not be relied upon.</div> <div> </div> <h3>VB</h3> Returns a reference
    ///    to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b> property is
    ///    indeterminate and should not be relied upon.</div> <div> </div>
    ///    
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
    ///Copies the current Group Policy object (GPO) to the specified domain and then returns a pointer to the copy of
    ///the GPO. This method copies the policy settings from the current GPO to the new GPO. The new GPO has a new GPO
    ///ID. The new GPO gets either the default GPO access control lists (ACLs) or the ACLs from the source GPO. The ACL
    ///that the new GPO gets depends on the value of the <i>lFlags</i> parameter. This method does not link any scopes
    ///of management (SOMs) to the new GPO.
    ///Params:
    ///    lFlags = Specifies the options to use for security principal and path mapping. For more information, see Copying and
    ///             Importing GPOs Across Domains. The following options are defined.
    ///    pIGPMDomain = Domain to which the GPO is copied.
    ///    pvarNewDisplayName = Display name for the copied GPO. A display name is assigned if the <b>VARIANT</b> structure does not contain
    ///                         a <b>BSTR</b> or if the <i>pvarNewDisplayName</i> parameter is <b>NULL</b>.
    ///    pvarMigrationTable = Pointer to the IGPMMigrationTable interface to use for mapping. This parameter can be <b>NULL</b>.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface. This interface allows the client to receive status
    ///                      notifications about the progress of the copy operation. This parameter must be <b>NULL</b> if the client does
    ///                      not receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the copy operation. This
    ///                    parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface that represents the result of the copy operation. That
    ///                   interface contains pointers to an IGPMGPO interface and to an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT CopyTo(int lFlags, IGPMDomain pIGPMDomain, VARIANT* pvarNewDisplayName, VARIANT* pvarMigrationTable, 
                   VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///Sets the security descriptor for the GPO. The method replaces the existing security descriptor.
    ///Params:
    ///    lFlags = Specifies a set of bit flags. Use this parameter to specify the parts of the security descriptor to set.
    ///    pSD = The security descriptor to set.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetSecurityDescriptor(int lFlags, IDispatch pSD);
    ///Retrieves a pointer to an <b>IDispatch</b> interface from which the security descriptor for the Group Policy
    ///object (GPO) can be retrieved. For script programmers, this method returns a reference to an
    ///IADsSecurityDescriptor object.
    ///Params:
    ///    lFlags = Specifies a set of bit flags. Use this parameter to specify the parts of the security descriptor to retrieve.
    ///             The following values are valid.
    ///    ppSD = Address of a pointer to an <b>IDispatch</b> interface. You can call the IUnknown::QueryInterface method to
    ///           obtain a pointer to the IADsSecurityDescriptor interface on the security descriptor of the GPO.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to an IADsSecurityDescriptor object. <h3>VB</h3> Returns a reference to an
    ///    IADsSecurityDescriptor object.
    ///    
    HRESULT GetSecurityDescriptor(int lFlags, IDispatch* ppSD);
    ///Checks for the consistency of ACLs between the Directory Service and the system volume folder (SysVol).
    ///Params:
    ///    pvbConsistent = Value that indicates whether the access control lists (ACLs) on the different parts of the GPO are
    ///                    consistent. If <b>VARIANT_TRUE</b>, they are consistent.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs or if the ACLs are
    ///    not consistent. <h3>JScript</h3> Value that indicates whether the ACLs are consistent. If
    ///    <b>VARIANT_TRUE</b>, they are consistent. For more information, see the following Remarks section.
    ///    <h3>VB</h3> Value that indicates whether the ACLs are consistent. If <b>VARIANT_TRUE</b>, they are
    ///    consistent. For more information, see the following Remarks section.
    ///    
    HRESULT IsACLConsistent(short* pvbConsistent);
    ///Makes ACLs consistent on the Directory Service and the system volume folder (SysVol) of the GPO. IsACLConsistent
    ///can be used to check for consistency of ACLs between the Directory Service and system volume folder (SysVol).
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT MakeACLConsistent();
}

///The <b>IGPMGPOCollection</b> interface contains methods that enable applications to access a collection of Group
///Policy Objects (GPOs) when using the Group Policy Management Console (GPMC) interfaces. You can obtain a
///<b>GPMGPOCollection</b> object by calling the IGPMDomain::SearchGPOs method.
@GUID("F0F0D5CF-70CA-4C39-9E29-B642F8726C01")
interface IGPMGPOCollection : IDispatch
{
    ///Returns the number of GPOs in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a pointer to an GPMGPO object from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    ppIGPMGPOs = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///                 provides a number of methods that you can use to iterate through the collection. For more information about
    ///                 <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMGPOs);
}

///The <b>IGPMGPOLink</b> interface supports methods that allow you to remove a GPO link from the scope of management
///(SOM), and to set and retrieve various properties of GPO links, including enabling and enforcing links.
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
    ///Removes the GPO link from the scope of management (SOM). The method does not delete the GPO.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Delete();
}

///The <b>IGPMGPOLinksCollection</b> interface contains methods that enable applications to access a collection of GPO
///links when using the Group Policy Management (GPMC) interfaces.
@GUID("189D7B68-16BD-4D0D-A2EC-2E6AA2288C7F")
interface IGPMGPOLinksCollection : IDispatch
{
    ///Returns the number of GPO links in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a GPO link from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///The <b>get_NewEnum</b> method retrieves an enumerator for the collection.
    ///Params:
    ///    ppIGPMLinks = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///                  provides a number of methods that you can use to iterate through the collection. For more information about
    ///                  <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMLinks);
}

///The <b>IGPMCSECollection</b> interface contains methods that enable applications to query a collection of client-side
///extensions (CSEs) when you use the Group Policy Management Console (GPMC) interfaces. To create a
///<b>GPMCSECollection</b> object, call the IGPM::GetClientSideExtensions method.
@GUID("2E52A97D-0A4A-4A6F-85DB-201622455DA0")
interface IGPMCSECollection : IDispatch
{
    ///Returns the number of client side extensions (CSEs) in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a client-side extension from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    ppIGPMCSEs = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///                 provides a number of methods that you can use to iterate through the collection. For more information about
    ///                 <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMCSEs);
}

///The <b>IGPMClientSideExtension</b> interface supports methods that allow you to query client-side extension
///properties when you use the Group Policy Management Console (GPMC) interfaces. You can also check whether a
///client-side extension can be called during the processing of policy.
@GUID("69DA7488-B8DB-415E-9266-901BE4D49928")
interface IGPMClientSideExtension : IDispatch
{
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_DisplayName(BSTR* pVal);
    ///Checks whether the client-side extension can be called during the processing of user policy.
    ///Params:
    ///    pvbEnabled = Value that indicates whether the client-side extension can be called during the processing of user policy. If
    ///                 <b>VARIANT_TRUE</b>, the client-side extension is called during the processing of user policy, provided that
    ///                 there are policy settings for the client-side extension in the user portion of one or more of the applied
    ///                 GPOs.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Value that indicates whether the client-side extension can be configured in the user portion of the GPO. If
    ///    <b>VARIANT_TRUE</b>, the client-side extension can be configured. <h3>VB</h3> Value that indicates whether
    ///    the client-side extension can be configured in the user portion of the GPO. If <b>VARIANT_TRUE</b>, the
    ///    client-side extension can be configured.
    ///    
    HRESULT IsUserEnabled(short* pvbEnabled);
    ///Checks whether the client-side extension can be called during the processing of computer policy.
    ///Params:
    ///    pvbEnabled = Value that indicates whether the client-side extension can be called during the processing of computer
    ///                 policy. If <b>VARIANT_TRUE</b>, the client-side extension is called during the processing of computer policy,
    ///                 provided that there are policy settings for the client-side extension in the computer portion of one or more
    ///                 of the applied GPOs.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Value that indicates whether the client-side extension can be configured in the computer portion of the GPO.
    ///    If <b>VARIANT_TRUE</b>, the client-side extension can be configured. <h3>VB</h3> Value that indicates whether
    ///    the client-side extension can be configured in the computer portion of the GPO. If <b>VARIANT_TRUE</b>, the
    ///    client-side extension can be configured.
    ///    
    HRESULT IsComputerEnabled(short* pvbEnabled);
}

///A pointer to the <b>IGPMAsyncCancel</b> interface is returned to the client by the Group Policy Management Console
///(GPMC) method that the client calls asynchronously. GPMC operations such as backup, restore, import, copy, and report
///generation can execute asynchronously. This object cannot be accessed through scripting.
@GUID("DDC67754-BE67-4541-8166-F48166868C9C")
interface IGPMAsyncCancel : IDispatch
{
    ///The client calls this method to cancel an asynchronous Group Policy Management Console (GPMC) operation. GPMC
    ///operations such as backup, restore, import, copy, and report generation can execute asynchronously.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Cancel();
}

///The <b>IGPMAsyncProgress</b> interface can be implemented by the client and passed as an input parameter to the Group
///Policy Management Console (GPMC) methods that can execute asynchronously. The server will then notify the client
///about the progress of the operation. Methods include IGPMGPO::GenerateReport, IGPMBackup::GenerateReport,
///IGPMRSOP::GenerateReport, RestoreGPO, Backup, Import, and CopyTo. This object cannot be accessed through scripting.
///For more information, see the "Remarks" section.
@GUID("6AAC29F8-5948-4324-BF70-423818942DBC")
interface IGPMAsyncProgress : IDispatch
{
    ///The server calls this method to notify the client about the status of a Group Policy Management Console (GPMC)
    ///operation.
    ///Params:
    ///    lProgressNumerator = Numerator of a fraction that represents the percent of the GPMC operation that is complete.
    ///    lProgressDenominator = Denominator of a fraction that represents the percent of the GPMC operation that is complete. The value of
    ///                           this parameter is proportional to the number of extensions in the Group Policy object (GPO), whether the GPO
    ///                           is a "live" GPO or a backed-up GPO. This value can be used to display the progress bar to the user. In the
    ///                           GPMC user interface, the progress bar is divided into <i>lProgressDenominator</i> intervals. When
    ///                           <i>lProgressNumerator</i>==<i>lProgressDenominator</i> the operation is complete.
    ///    hrStatus = Status of the operation. If no error occurred, the value of the parameter is <b>S_OK</b>.
    ///    pResult = Result of the operation. This parameter is an interface pointer to the object that resulted from the GPMC
    ///              operation. For example, it may be a pointer to a GPMGPO object or to a GPMBackup object. This object is only
    ///              returned when the operation is complete.
    ///    ppIGPMStatusMsgCollection = A pointer to the IGPMStatusMsgCollection interface that contains detailed status information about the
    ///                                operation. In cases where there are no errors, or if there are no detailed messages, Status passes in a null
    ///                                collection.
    ///Returns:
    ///    This method has no return values.
    ///    
    HRESULT Status(int lProgressNumerator, int lProgressDenominator, HRESULT hrStatus, VARIANT* pResult, 
                   IGPMStatusMsgCollection ppIGPMStatusMsgCollection);
}

///The <b>IGPMStatusMsgCollection</b> interface contains methods that enable applications to access a collection of
///status messages when using the Group Policy Management Console (GPMC) interfaces.
@GUID("9B6E1AF0-1A92-40F3-A59D-F36AC1F728B7")
interface IGPMStatusMsgCollection : IDispatch
{
    ///Returns the number of messages in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a message from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    pVal = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///           provides a number of methods that you can use to iterate through the collection. For more information about
    ///           <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

///The <b>IGPMStatusMessage</b> interface contains property methods that retrieve various properties of status messages
///related to GPO operations.
@GUID("8496C22F-F3DE-4A1F-8F58-603CAAA93D7B")
interface IGPMStatusMessage : IDispatch
{
    HRESULT get_ObjectPath(BSTR* pVal);
    ///Returns the error that occurred during the GPMC operation. If the operation was interacting with another system
    ///component, the error code is typically one returned by that component. Usually this is the first error GPMC hits
    ///while executing the operation. This error code is internally mapped to the operation error code returned by the
    ///OperationCode method. For example, if GPMC calls LookupAccountSid while resolving the destination of a security
    ///group in a GPO import operation, and <b>LookupAccountSid</b> returns <b>E_ACCESSDENIED</b>, then the error code
    ///for the message will be <b>E_ACCESSDENIED</b> and the operation code of the message will be
    ///STATUS_ENTRY_DEST_UNRESOLVED.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT ErrorCode();
    HRESULT get_ExtensionName(BSTR* pVal);
    HRESULT get_SettingsName(BSTR* pVal);
    ///Returns a code related to the GPMC operation. The code corresponds to warnings or other errors that occurred
    ///during the operation. In the case of warnings, the operation continues. In the case of other errors, the
    ///operation stops. The operation codes are internal identifiers that are defined in Gpmgmt.dll. You can extract a
    ///text description of the operation code by using the Message property of IGPMStatusMessage or by using
    ///FormatMessage.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT OperationCode();
    HRESULT get_Message(BSTR* pVal);
}

///The <b>IGPMConstants</b> interface supports methods that retrieve the value of multiple Group Policy Management
///Console (GPMC) constants. To create a <b>GPMConstants</b> object, call the IGPM::GetConstants method. The
///<b>GPMConstants</b> object that implements the <b>IGPMConstants</b> interface does not introduce new constants. All
///the constant values and enumeration types that are returned by the <b>GPMConstants</b> object can be found in either
///the GPMC header file (Gpmgmt.idl or Gpmgmt.h) or in the GPMC type library that is embedded in the Gpmgmt.dll
///dynamic-link library. Use the <b>GPMConstants</b> object only if you do not have access to the header or to the type
///library.
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
    ///Retrieves the value of the <b>SecurityFlags</b> property, which represents the portion of the security descriptor
    ///to retrieve or set for a GPO. You can pass the returned value in the <i>ulFlags</i> parameter to the
    ///IGPMGPO::GetSecurityDescriptor and IGPMGPO::SetSecurityDescriptor methods. This property is read-only.
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

///The <b>IGPMResult</b> interface contains methods to retrieve status message information while performing various
///types of GPO processing operations such as restore, import, copy and backup.
@GUID("86DFF7E9-F76F-42AB-9570-CEBC6BE8A52D")
interface IGPMResult : IDispatch
{
    HRESULT get_Status(IGPMStatusMsgCollection* ppIGPMStatusMsgCollection);
    HRESULT get_Result(VARIANT* pvarResult);
    ///Returns the overall status of a GPMC operation, such as a copy, restore, backup, or import. If no error occurred
    ///during the operation, the method returns a success code; otherwise the method returns a failure code. <div
    ///class="alert"><b>Note</b> You must check the code returned by this method as well as the one returned by the GPMC
    ///operation to determine whether or not the operation succeeded.</div><div> </div>
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT OverallStatus();
}

///The <b>IGPMMapEntryCollection</b> interface enables applications to access map entry objects.
@GUID("BB0BF49B-E53F-443F-B807-8BE22BFB6D42")
interface IGPMMapEntryCollection : IDispatch
{
    ///Returns the number of map entries in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a map entry from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    pVal = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///           provides a number of methods that you can use to iterate through the collection. For more information about
    ///           <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

///The <b>IGPMMapEntry</b> interface provides access to a map entry.
@GUID("8E79AD06-2381-4444-BE4C-FF693E6E6F2B")
interface IGPMMapEntry : IDispatch
{
    HRESULT get_Source(BSTR* pbstrSource);
    HRESULT get_Destination(BSTR* pbstrDestination);
    HRESULT get_DestinationOption(__MIDL___MIDL_itf_gpmgmt_0000_0000_0007* pgpmDestOption);
    HRESULT get_EntryType(__MIDL___MIDL_itf_gpmgmt_0000_0000_0006* pgpmEntryType);
}

///The <b>IGPMMigrationTable</b> interface provides an interface to a migration table.
@GUID("48F823B1-EFAF-470B-B6ED-40D14EE1A4EC")
interface IGPMMigrationTable : IDispatch
{
    ///Saves the migration table currently in memory in a specified location.
    ///Params:
    ///    bstrMigrationTablePath = Path to file location where the migration table currently in memory is to be saved.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Save(BSTR bstrMigrationTablePath);
    ///Adds entries from the IGPMGPO and IGPMBackup interfaces. The method updates any entries that are already present
    ///in the migration table.
    ///Params:
    ///    lFlags = This parameter must be one of the following values.
    ///    var = Dispatch pointer to an IGPMGPO or IGPMBackup interface.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Add(int lFlags, VARIANT var);
    ///Creates an entry in the migration table. The method updates an existing entry.
    ///Params:
    ///    bstrSource = Source field of the entry. This parameter cannot be null.
    ///    gpmEntryType = This parameter must be one of the following values.
    ///    pvarDestination = A pointer to a <b>VARIANT</b> structure. You can use the <b>DestinationOptions</b>:
    ///                      <b>opDestinationSameAsSource</b>, <b>opDestinationNone</b>, or <b>opDestinationByRelativeName</b> by passing
    ///                      in a <i>pvarDestination</i> with a <b>vt</b> member of VT_I4. To explicitly pass in the destination, pass in
    ///                      a <i>pvarDestination</i> with a <b>vt</b> member of VT_BSTR, and this sets the <b>DestinationOptions</b> to
    ///                      <b>opDestinationSet</b>. If you pass in null, <b>AddEntry</b> uses the default value for the destination
    ///                      option, <b>opDestinationSameAsSource</b>.
    ///    ppEntry = The new entry.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMMapEntry</b> object. <h3>VB</h3> Returns a reference to a <b>GPMMapEntry</b>
    ///    object.
    ///    
    HRESULT AddEntry(BSTR bstrSource, __MIDL___MIDL_itf_gpmgmt_0000_0000_0006 gpmEntryType, 
                     VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    ///The <b>GetEntry</b> method gets the entry in the migration table for a specified source field.
    ///Params:
    ///    bstrSource = Source field of the entry to retrieve.
    ///    ppEntry = A pointer to an IGPMMapEntry interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMMapEntry object. <h3>VB</h3> Returns a reference to a GPMMapEntry object.
    ///    
    HRESULT GetEntry(BSTR bstrSource, IGPMMapEntry* ppEntry);
    ///Deletes an entry from the migration table.
    ///Params:
    ///    bstrSource = Source field of the entry to delete. Use null-terminated string.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT DeleteEntry(BSTR bstrSource);
    ///Updates the destination field of an entry in a migration table. You can specify the destination option and the
    ///destination.
    ///Params:
    ///    bstrSource = The source field of the migration table which is to be updated.
    ///    pvarDestination = A pointer to a <b>VARIANT</b> structure. You can use the DestinationOptions: opDestinationSameAsSource,
    ///                      opDestinationNone, or opDestinationByRelativeName by passing in a <i>pvarDestination</i> with a <b>vt</b>
    ///                      member of VT_I4. To explicitly pass in the destination, pass in a <i>pvarDestination</i> with a <b>vt</b>
    ///                      member of VT_BSTR, and this will set the DestinationOption to opDestinationSet. If you pass in null,
    ///                      UpdateDestination uses the default value for the destination option, opDestinationSameAsSource.
    ///    ppEntry = The updated entry.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMMapEntry</b> object. <h3>VB</h3> Returns a reference to a <b>GPMMapEntry</b>
    ///    object.
    ///    
    HRESULT UpdateDestination(BSTR bstrSource, VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    ///Validates the migration table.
    ///Params:
    ///    ppResult = Reference to an IGPMResult interface. The <b>Result</b> property references whether the validation is
    ///               successful. The Status property references the IGPMStatusMsgCollection that contains the validation errors or
    ///               warnings.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a GPMResult object. The <b>Result</b> property references whether the validation was successful. The
    ///    Status property references the GPMStatusMsgCollection that contains the validation errors or warnings.
    ///    <h3>VB</h3> Returns a GPMResult object. The <b>Result</b> property references whether the validation was
    ///    successful. The Status property references the GPMStatusMsgCollection that contains the validation errors or
    ///    warnings.
    ///    
    HRESULT Validate(IGPMResult* ppResult);
    ///Returns a <b>IGPMMapEntryCollection</b> interface.
    ///Params:
    ///    ppEntries = The list of entries in the migration table.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMMapEntryCollection object. <h3>VB</h3> Returns a reference to a
    ///    GPMMapEntryCollection object.
    ///    
    HRESULT GetEntries(IGPMMapEntryCollection* ppEntries);
}

///The <b>IGPMBackupDirEx</b> interface supports methods that allow you to query GPMBackup, GPMBackupCollection,
///<b>GPMStarterGPOBackup</b>, and <b>GPMStarterGPOBackupCollection</b> objects when you are using the Group Policy
///Management Console (GPMC) interfaces. To create a <b>GPMBackupDirEx</b> object, call the IGPM2::GetBackupDirEx
///method.
@GUID("F8DC55ED-3BA0-4864-AAD4-D365189EE1D5")
interface IGPMBackupDirEx : IDispatch
{
    HRESULT get_BackupDir(BSTR* pbstrBackupDir);
    HRESULT get_BackupType(GPMBackupType* pgpmBackupType);
    ///Retrieves the <b>GPMBackup</b> or <b>GPMStarterGPOBackup</b> object with the specified backup ID. The backup ID
    ///is a GUID. The backup ID is the ID of the backed-up Group Policy object (GPO), not the ID of the GPO.
    ///Params:
    ///    bstrID = ID of the GPMBackup or <b>GPMStarterGPOBackup</b> object to open.
    ///    pvarBackup = Pointer to the IGPMBackup or <b>IGPMStarterGPOBackup</b> interface for the ID specified.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMBackup or <b>GPMStarterGPOBackup</b> object. <h3>VB</h3> Returns a reference to a
    ///    GPMBackup or <b>GPMStarterGPOBackup</b> object.
    ///    
    HRESULT GetBackup(BSTR bstrID, VARIANT* pvarBackup);
    ///Executes a search for a GPMBackup object or an <b>IGPMStarterGPOBackup</b> interface according to the specified
    ///criteria, and returns a GPMBackupCollection or <b>GPMStarterGPOBackupCollection</b> object.
    ///Params:
    ///    pIGPMSearchCriteria = Pointer to the criteria to be applied to the search.
    ///    pvarBackupCollection = Pointer to the IGPMBackupCollection or IGPMStarterGPOBackupCollection interface that represent the IGPMBackup
    ///                           or <b>IGPMStarterGPOBackup</b> objects that are found by the search.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a <b>GPMBackupCollection</b> or <b>GPMStarterGPOBackupCollection</b> object.
    ///    <h3>VB</h3> Returns a reference to a <b>GPMBackupCollection</b> or <b>GPMStarterGPOBackupCollection</b>
    ///    object.
    ///    
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, VARIANT* pvarBackupCollection);
}

///The <b>IGPMStarterGPOBackupCollection</b> interface contains methods that enable applications to access a collection
///of GPMStarterGPOBackup objects when using the Group Policy Management Console (GPMC) interfaces.
@GUID("C998031D-ADD0-4BB5-8DEA-298505D8423B")
interface IGPMStarterGPOBackupCollection : IDispatch
{
    ///Returns the number of GPMStarterGPOBackup objects in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns an GPMStarterGPOBackup object from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    ppIGPMTmplBackup = Pointer to an IEnumVARIANT interface of an enumerator object for the collection. IEnumVARIANT provides a
    ///                       number of methods that you can use to iterate through the collection. For more information about
    ///                       IEnumVARIANT, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTmplBackup);
}

///The <b>IGPMStarterGPOBackup</b> interface supports methods that allow you to delete <b>GPMStarterGPOBackup</b>
///objects and to retrieve various properties of <b>GPMStarterGPOBackup</b> objects.
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
    ///Removes the Starter GPO backup from the backup directory, and from the file system.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Delete();
    ///The GenerateReport method gets the report for the backup GPO.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    pvarGPMProgress = Pointer to an IGPMAsyncProgress interface. If <i>pvarGPMProgress</i> is null, the call to GenerateReport is
    ///                      handled synchronously. If not null, the call to <b>GenerateReport</b> is handled asynchronously and
    ///                      <i>pvarGPMCancel</i> returns a pointer to IGPMAsyncCancel.
    ///    pvarGPMCancel = Pointer to an IGPMAsyncCancel interface. A value for this parameter is returned only when
    ///                    <i>pvarGPMProgress</i> is specified and is not null.
    ///    ppIGPMResult = Pointer to an IGPMResult. The Result property contains a string of XML or HTML. The Status property contains
    ///                   a reference to an IGPMStatusMsgCollection.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///The GenerateReportToFile gets the report for the backup Starter GPO and saves it to a file at a specified path.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    bstrTargetFilePath = Binary string that contains the path to the file where the report is being saved. Use null-terminated string.
    ///    ppIGPMResult = Pointer to an IGPMResult interface. The <b>Status</b> property contains a reference to an
    ///                   IGPMStatusMsgCollection. <div class="alert"><b>Note</b> The value of the <b>Result</b> property is
    ///                   indeterminate and should not be relied upon.</div> <div> </div>
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b>
    ///    property is indeterminate and should not be relied upon.</div> <div> </div> <h3>VB</h3> Returns a reference
    ///    to a GPMResult object. <div class="alert"><b>Note</b> The value of the <b>Result</b> property is
    ///    indeterminate and should not be relied upon.</div> <div> </div>
    ///    
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
}

///The <b>IGPM2</b> interface extends the GPMBackupDir and InitializeReporting methods of the IGPM interface of the
///Group Policy Management Console (GPMC). The <b>GPM</b> object is the only object used with the CoCreateInstance
///function.
@GUID("00238F8A-3D86-41AC-8F5E-06A6638A634A")
interface IGPM2 : IGPM
{
    ///For a Group Policy object (GPO), the <b>GetBackupDirEx</b> method creates and returns a GPMBackupDirEx object,
    ///which you can use to access a GPMBackup or GPMBackupCollection object. For a Starter Group Policy object, the
    ///<b>GetBackupDirEx</b> method creates and returns a GPMBackupDirEx object, which you can use to access a
    ///GPMStarterGPOBackup or GPMStarterGPOBackupCollection object.
    ///Params:
    ///    bstrBackupDir = Required. The name of the file system directory containing the Group Policy object (GPO) backups. Note that
    ///                    the directory must already exist.
    ///    backupDirType = Determines whether the back up is for a Starter Group Policy object or a Group Policy object.
    ///    ppIGPMBackupDirEx = Address of a pointer to the IGPMBackupDirEx interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMBackupDirEx object. <h3>VB</h3> Returns a reference to a GPMBackupDirEx object.
    ///    
    HRESULT GetBackupDirEx(BSTR bstrBackupDir, GPMBackupType backupDirType, IGPMBackupDirEx* ppIGPMBackupDirEx);
    ///Sets the location to search for .adm files and the reporting option to determine whether to include comments in
    ///the report. This method initializes reporting in an asynchronous manner. For both Group Policy object (GPO)
    ///reporting or Resultant Set of Policy (RSOP) reporting, the Group Policy Management Console (GPMC) searches for
    ///and loads .adm files in the following order. First it searches for the specified .adm files in the specified
    ///location. Then it searches for any additional .adm files in the default location. Finally it searches the GPO or
    ///RSoP for any additional .adm files.
    ///Params:
    ///    bstrAdmPath = Location to search for .adm files.
    ///    reportingOptions = Reporting options. This parameter must be one of the following values.
    ///Returns:
    ///    <h3>JScript</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>VB</h3>
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT InitializeReportingEx(BSTR bstrAdmPath, int reportingOptions);
}

///The <b>IGPMStarterGPO</b> interface supports methods that enable you to manage Starter Group Policy Objects (GPOs) in
///the directory service. Note that you cannot use this interface to manage local GPOs (LGPOs). You can instantiate a
///<b>GPMStarterGPO</b> object by creating a new one with a call to IGPMDomain2::CreateStarterGPO, retrieving an
///existing one with a call to IGPMDomain2::GetStarterGPO, or by searching for one with a call to
///IGPMDomain2::SearchStarterGPOs. After creating the object, you can query the GPO and set properties related to the
///GPO.
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
    ///Deletes the GPO from the current domain's system volume folder(SysVol).
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Delete();
    ///Saves all Starter GPO settings into a single CAB file. Optionally the user may specify to save a custom Starter
    ///GPO as a system Starter GPO.
    ///Params:
    ///    bstrSaveFile = Name of the file to which the Starter GPO should be saved. Use null-terminated string.
    ///    bOverwrite = Boolean value that determines whether the file should be overwritten, if it exists.
    ///    bSaveAsSystem = Boolean value that specifies whether to convert the Starter GPO into a system template as part of the save.
    ///                    By default, the value is <b>VARIANT_FALSE</b>, save as a system Starter GPO. This option must be
    ///                    VARIANT_FALSE if the Starter GPO being saved is a system Starter GPO; entering VARIANT_TRUE for a system
    ///                    Starter GPO will return an invalid argument error.
    ///    bstrLanguage = Specifies the MUI language code all the language specific strings of the custom Starter GPO will be exported
    ///                   during the save. The custom Starter GPO strings are converted into MUI resources without performing any
    ///                   language checks on the strings. If bSaveAsSystem is VARIANT_FALSE this parameter is ignored. If this
    ///                   parameter is <b>NULL</b>, the user's current language code is used.
    ///    bstrAuthor = Specifies the Author property of the new system Starter GPO. If bSaveAsSystem is VARIANT_FALSE this parameter
    ///                 is ignored.
    ///    bstrProduct = Specifies the Product property of the new system Starter GPO. If bSaveAsSystem is VARIANT_FALSE this
    ///                  parameter is ignored
    ///    bstrUniqueID = Specifies the ID property of the new system Starter GPO. If the parameter is <b>NULL</b> a new unique ID will
    ///                   be generated. If bSaveAsSystem is VARIANT_FALSE this parameter is ignored.
    ///    bstrVersion = Specifies the Starter GPO version of the new system Starter GPO. The format of the string must be 4
    ///                  digits-dot-5 digits. If the value is <b>NULL</b> the version is set to 1.0. If bSaveAsSystem is VARIANT_FALSE
    ///                  this parameter is ignored
    ///    pvarGPMProgress = Pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications about the
    ///                      progress of the copy operation. If not <b>NULL</b>, the call to GenerateReport is handled asynchronously and
    ///                      <i>pvarGPMCancel</i> receives a pointer to an IGPMAsyncCancel interface. If this parameter is <b>NULL</b> the
    ///                      call to <b>GenerateReport</b> is handled synchronously. The <i>pvarGPMProgress</i> parameter must be
    ///                      <b>NULL</b> if the client should not receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the copy operation. This
    ///                    parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Pointer to an IGPMResult. The Result property contains a string representing the GUID of the saved Starter
    ///                   GPO. If bSaveAsSystem is <b>VARIANT_TRUE</b>, the Starter GPO will be saved with a new GUID as specified by
    ///                   bstrUniqueID. The Status property contains a reference to an IGPMStatusMsgCollection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT Save(BSTR bstrSaveFile, short bOverwrite, short bSaveAsSystem, VARIANT* bstrLanguage, 
                 VARIANT* bstrAuthor, VARIANT* bstrProduct, VARIANT* bstrUniqueID, VARIANT* bstrVersion, 
                 VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///Creates a backup of the current Starter GPO.
    ///Params:
    ///    bstrBackupDir = Name of the file system directory in which the <b>GPMStarterGPOBackup</b> object should be stored. The
    ///                    directory must already exist. Use a null-terminated string.
    ///    bstrComment = Comment to associate with the <b>GPMStarterGPOBackup</b> object.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications
    ///                      about the progress of the backup operation. The method runs synchronously if this parameter is <b>NULL</b>.
    ///                      The method runs asynchronously if this parameter is not <b>NULL</b>. This parameter must be <b>NULL</b> if
    ///                      the client should not receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the backup operation.
    ///                    This parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface representing the result of the backup operation. That
    ///                   interface contains pointers to an IGPMBackup interface and an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. For more information, see the
    ///    following Remarks section.
    ///    
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    ///The <b>CopyTo</b> method copies the current Starter GPO and returns a pointer to the copy of the Starter GPO. The
    ///method copies all the contents of the Starter GPO but creates the new Starter GPO with the default new Starter
    ///GPO delegation settings. Copying a system Starter GPO creates a new custom Starter GPO.
    ///Params:
    ///    pvarNewDisplayName = Display name to be put on the copied Starter GPO. A display name is assigned if the <b>VARIANT</b> structure
    ///                         does not contain a <b>BSTR</b>, or if <i>pvarNewDisplayName</i> is <b>NULL</b>.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications
    ///                      about the progress of the copy operation. This parameter must be <b>NULL</b> if the client does not receive
    ///                      asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the copy operation. This
    ///                    parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface that represents the result of the copy operation. That
    ///                   interface contains pointers to an IGPMGPO interface and an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. For more information, see the
    ///    following Remarks section.
    ///    
    HRESULT CopyTo(VARIANT* pvarNewDisplayName, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    ///Gets the report for the Starter GPO.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    pvarGPMProgress = Pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications about the
    ///                      progress of the copy operation. If not <b>NULL</b>, the call to GenerateReport is handled asynchronously and
    ///                      <i>pvarGPMCancel</i> receives a pointer to an IGPMAsyncCancel interface. If this parameter is <b>NULL</b> the
    ///                      call to <b>GenerateReport</b> is handled synchronously. The <i>pvarGPMProgress</i> parameter must be
    ///                      <b>NULL</b> if the client should not receive asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the copy operation. This
    ///                    parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Pointer to an IGPMResult. The Result property contains a binary string of XML or HTML. The Status property
    ///                   contains a reference to an IGPMStatusMsgCollection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT GenerateReport(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    ///The <b>GenerateReportToFile</b> method gets the report for the GPO and saves it to a file at a specified path.
    ///Params:
    ///    gpmReportType = Specifies whether the report is in XML or HTML.
    ///    bstrTargetFilePath = Binary string that contains the path to the file where the report is being saved. Use null-terminated string.
    ///    ppIGPMResult = Pointer to an IGPMResult interface. The <b>Status</b> property contains a reference to an
    ///                   IGPMStatusMsgCollection. <div class="alert"><b>Note</b> The value of the <b>Result</b> property of the
    ///                   IGPMResult interface is indeterminate and should not be relied upon.</div> <div> </div>
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT GenerateReportToFile(__MIDL___MIDL_itf_gpmgmt_0000_0000_0005 gpmReportType, BSTR bstrTargetFilePath, 
                                 IGPMResult* ppIGPMResult);
    ///Retrieves the set of permissions for the Starter GPO, such as who is granted permission to edit it.
    ///Params:
    ///    ppSecurityInfo = Address of a pointer to the IGPMSecurityInfo interface.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    ///Sets the list of permissions for the Group Policy object (GPO), such as who is granted permission to edit it. The
    ///method replaces the existing list of permissions.
    ///Params:
    ///    pSecurityInfo = Pointer to the security information to apply to the GPO.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

///The <b>IGPMStarterGPOCollection</b> interface contains methods that enable applications to access a collection of
///Group Policy Objects (GPOs) when using the Group Policy Management Console (GPMC) interfaces. You can obtain a
///<b>GPMStarterGPOCollection</b> object by calling the IGPMDomain2::SearchStarterGPOs method.
@GUID("2E522729-2219-44AD-933A-64DFD650C423")
interface IGPMStarterGPOCollection : IDispatch
{
    ///Returns the number of GPOs in the collection. This property is read-only.
    HRESULT get_Count(int* pVal);
    ///Given an index, returns a pointer to an IGPMGPO interface from the collection. This property is read-only.
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    ///Retrieves an enumerator for the collection.
    ///Params:
    ///    ppIGPMTemplates = Pointer to an <b>IEnumVARIANT</b> interface of an enumerator object for the collection. <b>IEnumVARIANT</b>
    ///                      provides a number of methods that you can use to iterate through the collection. For more information about
    ///                      <b>IEnumVARIANT</b>, see the COM documentation in the Platform SDK.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs.
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTemplates);
}

///The <b>IGPMDomain2</b> interface represents a specified domain and supports certain methods. These methods allow you
///to perform the following tasks when you are using the Group Policy Management Console (GPMC) interfaces: <ul>
///<li>Query scope of management (SOM) objects</li> <li>Create, restore, and query Starter Group Policy objects
///(GPOs)</li> <li>Create and query Windows Management Instrumentation (WMI) filters</li> </ul>To create a GPMDomain
///object, call the IGPM::GetDomain method.
@GUID("7CA6BB8B-F1EB-490A-938D-3C4E51C768E6")
interface IGPMDomain2 : IGPMDomain
{
    ///Creates and retrieves a GPMStarterGPO object that has a default display name and description. Typically, the
    ///caller sets the display name and description immediately after calling this method. The Starter Group Policy
    ///object (GPO) ID is generated automatically.
    ///Params:
    ///    ppnewTemplate = Address of a pointer to the GPMStarterGPO interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMStarterGPO object. <h3>VB</h3> Returns a reference to a GPMStarterGPO object.
    ///    
    HRESULT CreateStarterGPO(IGPMStarterGPO* ppnewTemplate);
    ///Creates and retrieves a GPMGPO object from a GPMStarterGPO object. This method creates a new GPMGPO object. Then,
    ///this method copies the contents of the GPMStarterGPO object into the <b>GPMGPO</b> object. Finally, this method
    ///updates the appropriate attributes of the <b>GPMGPO</b> object to reflect the configured data.
    ///Params:
    ///    pGPOTemplate = A pointer to a GPMStarterGPO object from which the new Group Policy object (GPO) will be created.
    ///    ppnewGPO = Address of a pointer to an GPMGPO object that represents the new GPO.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMGPO object. <h3>VB</h3> Returns a reference to a GPMGPO object.
    ///    
    HRESULT CreateGPOFromStarterGPO(IGPMStarterGPO pGPOTemplate, IGPMGPO* ppnewGPO);
    ///Retrieves a GPMStarterGPO object that has a specified Group Policy object ID. The GPO ID is represented by a
    ///GUID.
    ///Params:
    ///    bstrGuid = Required. GUID that represents the ID of the GPO to access. Use a null-terminated string.
    ///    ppTemplate = Address of a pointer to the IGPMStarterGPO interface for the specified Starter GPO ID.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMStarterGPO object. <h3>VB</h3> Returns a reference to a GPMStarterGPO object.
    ///    
    HRESULT GetStarterGPO(BSTR bstrGuid, IGPMStarterGPO* ppTemplate);
    ///Executes a search for GPMStarterGPO objects in the domain and returns a GPMStarterGPOCollection object.
    ///Params:
    ///    pIGPMSearchCriteria = Pointer to the criteria to apply to the search.
    ///    ppIGPMTemplateCollection = Address of a pointer to the IGPMStarterGPOCollection interface that represents the GPOs found by the search.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMStarterGPOCollection object. <h3>VB</h3> Returns a reference to a
    ///    GPMStarterGPOCollection object.
    ///    
    HRESULT SearchStarterGPOs(IGPMSearchCriteria pIGPMSearchCriteria, 
                              IGPMStarterGPOCollection* ppIGPMTemplateCollection);
    ///Opens a Starter Group Policy object (GPO) cabinet (CAB) file and imports it into the domain.
    ///Params:
    ///    bstrLoadFile = Required. Name of the CAB file to load. Use a null-terminated string.
    ///    bOverwrite = Determines whether to overwrite any existing versions of the Starter GPO. Loading a Starter GPO from a CAB
    ///                 retains the ID of the original Starter GPO used to create the CAB, therefore it is possible to have a version
    ///                 of the Starter GPO already existing in the domain when the <b>LoadStarterGPO</b> method is called.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications
    ///                      about the progress of the copy operation. This parameter must be <b>NULL</b> if the client does not receive
    ///                      asynchronous notifications.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the copy operation. This
    ///                    parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface that represents the result of the load operation. That
    ///                   interface contains pointers to an IGPMStarterGPO interface and to an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT LoadStarterGPO(BSTR bstrLoadFile, short bOverwrite, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    ///Restores the Starter Group Policy object (GPO) from a GPMStarterGPOBackup object. You can restore a Starter GPO
    ///only to the domain in which the Starter GPO was originally created. This is because the operation restores the
    ///Starter GPO with its original Starter GPO ID and policy settings.
    ///Params:
    ///    pIGPMTmplBackup = Pointer to the GPMStarterGPOBackup object to restore.
    ///    pvarGPMProgress = Specifies a pointer to an IGPMAsyncProgress interface that allows the client to receive status notifications
    ///                      about the progress of the restore operation. The caller must create this interface and then pass the
    ///                      interface pointer in this parameter to receive asynchronous notifications. This parameter must be <b>NULL</b>
    ///                      if the client should not receive asynchronous notifications. The method runs asynchronously if this parameter
    ///                      is not <b>NULL</b>, and the method runs synchronously if <b>NULL</b>.
    ///    pvarGPMCancel = Receives a pointer to an IGPMAsyncCancel interface that the client can use to cancel the restore operation.
    ///                    This parameter is not returned if <i>pvarGPMProgress</i> is <b>NULL</b>.
    ///    ppIGPMResult = Address of a pointer to the IGPMResult interface that represents the result of the restore operation. That
    ///                   interface contains pointers to an IGPMstarterGPO interface and to an IGPMStatusMsgCollection interface.
    ///Returns:
    ///    <h3>C++</h3> Returns <b>S_OK</b> if successful. Returns a failure code if an error occurs. <h3>JScript</h3>
    ///    Returns a reference to a GPMResult object. <h3>VB</h3> Returns a reference to a GPMResult object.
    ///    
    HRESULT RestoreStarterGPO(IGPMStarterGPOBackup pIGPMTmplBackup, VARIANT* pvarGPMProgress, 
                              VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
}

///The <b>IGPMConstants2</b> interface supports methods that retrieve the value of multiple Group Policy Management
///Console (GPMC) constants. The constants that are supported by <b>IGPMConstants2</b> provide Starter Group Policy
///object (GPO) and comment support. To create a <b>GPMConstants2</b> object, call the IGPM::GetConstants method. The
///<b>GPMConstants</b> object that implements the IGPMConstants2 interface does not introduce new constants. All the
///constant values and the enumeration types that are returned by the <b>GPMConstants</b> object can be found in either
///the GPMC header file (Gpmgmt.idl or Gpmgmt.h) or in the GPMC type library that is embedded in the Gpmgmt.dll
///dynamic-link library. Use the <b>GPMConstants</b> object only if you do not have access to the header or to the type
///library.
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

///The <b>IGPMGPO2</b> interface supports methods that enable you to manage Group Policy objects (GPOs) and Starter
///Group Policy objects in the directory service. Note that you cannot use this interface to manage local GPOs (LGPOs).
///You can instantiate a GPMGPO2 object by creating a new one with a call to IGPMDomain::CreateGPO, or
///<b>IGPMDomain2::CreateStarterGPO</b> retrieving an existing one with a call to IGPMDomain::GetGPO, calling
///<b>IGPMDomain2::GetStarterGPO</b> or by searching for one with a call to IGPMDomain::SearchGPOs. You can also create
///a GPO from an existing Starter GPO with a call to <b>IGPMDomain2::CreateGPOFromStarterGPO</b>. After creating the
///object, you can query the GPO and set properties related to the GPO.
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
