// Written in the D programming language.

module windows.rightsmanagement;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL, FARPROC, PWSTR;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///>[!Note] The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMTIMETYPE</b> enumeration specifies a time type.
alias DRMTIMETYPE = int;
enum : int
{
    ///Greenwich Mean Time (Universal Time).
    DRMTIMETYPE_SYSTEMUTC   = 0x00000000,
    ///Local time.
    DRMTIMETYPE_SYSTEMLOCAL = 0x00000001,
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMENCODINGTYPE</b> enumeration identifies
///possible encoding types used in licenses.
alias DRMENCODINGTYPE = int;
enum : int
{
    ///Base 64 encoded value.
    DRMENCODINGTYPE_BASE64 = 0x00000000,
    ///String value.
    DRMENCODINGTYPE_STRING = 0x00000001,
    ///Long value.
    DRMENCODINGTYPE_LONG   = 0x00000002,
    ///Time value.
    DRMENCODINGTYPE_TIME   = 0x00000003,
    ///Unsigned integer.
    DRMENCODINGTYPE_UINT   = 0x00000004,
    ///Binary data.
    DRMENCODINGTYPE_RAW    = 0x00000005,
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMATTESTTYPE</b> enumeration specifies what kind
///of signature to create for a data blob.
alias DRMATTESTTYPE = int;
enum : int
{
    ///Create a signature using full environment information.
    DRMATTESTTYPE_FULLENVIRONMENT = 0x00000000,
    ///Create a signature using only a hash of the environment.
    DRMATTESTTYPE_HASHONLY        = 0x00000001,
}

///>[!Note] >[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMSPECTYPE</b> enumeration indicates what type of
///security or library providers are used.
alias DRMSPECTYPE = int;
enum : int
{
    ///Currently not supported.
    DRMSPECTYPE_UNKNOWN  = 0x00000000,
    ///File name.
    DRMSPECTYPE_FILENAME = 0x00000001,
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMSECURITYPROVIDERTYPE</b> enumeration specifies
///the type of secure DRM environment used.
alias DRMSECURITYPROVIDERTYPE = int;
enum : int
{
    ///Software-level security, using a lockbox.
    DRMSECURITYPROVIDERTYPE_SOFTWARESECREP = 0x00000000,
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMGLOBALOPTIONS</b> enumeration defines values
///for specifying which protocol is used for the transport protocol and whether the server lockbox is used. This
///enumeration is used by the DRMSetGlobalOptions function.
alias DRMGLOBALOPTIONS = int;
enum : int
{
    ///The WinHTTP protocol is used for the transport protocol. By default, the WinINet protocol is used.
    DRMGLOBALOPTIONS_USE_WINHTTP                 = 0x00000000,
    ///The server lockbox is used. For more information, see Lockboxes.
    DRMGLOBALOPTIONS_USE_SERVERSECURITYPROCESSOR = 0x00000001,
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRM_STATUS_MSG</b> enumeration is used by the
///custom callback function to specify why the callback function is being called.
alias DRM_STATUS_MSG = int;
enum : int
{
    ///AD RMS is attempting to activate the machine. For more information, see the DRM_MSG_ACTIVATE_MACHINE message.
    DRM_MSG_ACTIVATE_MACHINE                  = 0x00000000,
    ///AD RMS is attempting to activate a user. For more information, see the DRM_MSG_ACTIVATE_GROUPIDENTITY message.
    DRM_MSG_ACTIVATE_GROUPIDENTITY            = 0x00000001,
    ///AD RMS is attempting to acquire a license. For more information, see the DRM_MSG_ACQUIRE_LICENSE message.
    DRM_MSG_ACQUIRE_LICENSE                   = 0x00000002,
    ///AD RMS is attempting to acquire a revocation list. For more information, see the DRM_MSG_ACQUIRE_ADVISORY
    ///message.
    DRM_MSG_ACQUIRE_ADVISORY                  = 0x00000003,
    ///AD RMS is attempting to acquire a signed issuance license. For more information, see the
    ///DRM_MSG_SIGN_ISSUANCE_LICENSE message.
    DRM_MSG_SIGN_ISSUANCE_LICENSE             = 0x00000004,
    ///AD RMS is attempting to acquire a client licensor certificate. For more information, see the
    ///DRM_MSG_ACQUIRE_CLIENTLICENSOR message.
    DRM_MSG_ACQUIRE_CLIENTLICENSOR            = 0x00000005,
    ///AD RMS is attempting to acquire a template collection. For more information, see the
    ///DRM_MSG_ACQUIRE_ISSUANCE_LICENSE_TEMPLATE message.
    DRM_MSG_ACQUIRE_ISSUANCE_LICENSE_TEMPLATE = 0x00000006,
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRM_USAGEPOLICY_TYPE</b> enumeration is used with
///the DRMGetUsagePolicy and DRMSetUsagePolicy functions to specify a type of usage policy.
alias DRM_USAGEPOLICY_TYPE = int;
enum : int
{
    ///The usage policy is tied to an application name.
    DRM_USAGEPOLICY_TYPE_BYNAME      = 0x00000000,
    ///The usage policy is tied to an application's public key.
    DRM_USAGEPOLICY_TYPE_BYPUBLICKEY = 0x00000001,
    ///The usage policy is tied to a digest of an application.
    DRM_USAGEPOLICY_TYPE_BYDIGEST    = 0x00000002,
    ///The usage policy is tied to an operating system.
    DRM_USAGEPOLICY_TYPE_OSEXCLUSION = 0x00000003,
}

///> [!NOTE] > The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in
///Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be
///altered or unavailable in subsequent versions. Instead, use [Active Directory Rights Management Services SDK
///2.1](/previous-versions/windows/desktop/msipc/microsoft-information-protection-and-control-client-portal), which
///leverages functionality exposed by the client in **Msipc.dll**. The **DRM_DISTRIBUTION_POINT_INFO** enumeration
///specifies the type of distribution point to retrieve information about when calling
///[DRMGetIssuanceLicenseInfo](/previous-versions/windows/desktop/api/msdrm/nf-msdrm-drmgetissuancelicenseinfo).
alias DRM_DISTRIBUTION_POINT_INFO = int;
enum : int
{
    ///Retrieves information about the default end-user license acquisition URL contained in the issuance license. Use
    ///this constant to retrieve information about the silent intranet URL. The following example shows a license
    ///acquisition URL. ```xml <DISTRIBUTIONPOINT> <OBJECT type="License-Acquisition-URL"> <ID type="MS-GUID">
    ///{0045FD50-383B-43AA-90A4-ED013CD0CFE5} </ID> <NAME>Contoso Licensing Authority</NAME> <ADDRESS type="URL">
    ///http://Contoso.com/_wmcs/licensing </ADDRESS> </OBJECT> </DISTRIBUTIONPOINT> ```
    DRM_DISTRIBUTION_POINT_LICENSE_ACQUISITION = 0x00000000,
    ///Retrieves information about the issuance license signing service URL contained in the issuance license. The
    ///following example shows a signing service URL. ```xml <DISTRIBUTIONPOINT> <OBJECT type="Publishing-URL"> <ID
    ///type="MS-GUID">{9A23D98E-4449-4ba5-812A-F30808F3CB16}</ID> <NAME>Publishing Point</NAME> <ADDRESS
    ///type="URL">HTTP://petx64a526/_wmcs/licensing</ADDRESS> </OBJECT> </DISTRIBUTIONPOINT> ```
    DRM_DISTRIBUTION_POINT_PUBLISHING          = 0x00000001,
    ///Retrieves information about the nonsilent end-user license acquisition URL in the issuance license. >[!Note]
    ///>Beginning with RMS 1.0 SP1, nonsilent license acquisition is no longer supported. ```xml <DISTRIBUTIONPOINT>
    ///<OBJECT type="Referral-Info"> <ID type="MS-GUID">{81C42010-208A-4ABA-BAB6-C3C60F06DD5F}</ID> <NAME>Contoso Credit
    ///Card Splash Page</NAME> <ADDRESS type="URL"> https://www.contoso.com/CreditCardOffers.htm </ADDRESS> </OBJECT>
    ///</DISTRIBUTIONPOINT> ```
    DRM_DISTRIBUTION_POINT_REFERRAL_INFO       = 0x00000002,
}

// Constants


enum uint DRMIDVERSION = 0x00000000;
enum uint DRMBINDINGFLAGS_IGNORE_VALIDITY_INTERVALS = 0x00000001;
enum uint DRMACTSERVINFOVERSION = 0x00000000;
enum uint DRMCALLBACKVERSION = 0x00000001;

// Callbacks

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. Some of the functions included in the AD RMS SDK provide
///status information and licenses to your application by using a callback function that you must implement. The
///callback syntax is shown below.
///Params:
///    Arg1 = Specifies the action being performed. This can be one of the DRM_STATUS_MSG enumeration values.
///    Arg2 = The status of the current action.
///     = An application-defined value, such as a pointer to a callback function or a pointer to an event handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
alias DRMCALLBACK = HRESULT function(DRM_STATUS_MSG param0, HRESULT param1, void* param2, void* param3);

// Structs


///>[!Note] >[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMID</b> structure identifies an object. It is
///used by the DRMBOUNDLICENSEPARAMS structure and by the DRMCreateEnablingPrincipal function.
struct DRMID
{
    ///Specifies the version of the structure. If you are programming in C, this should be set to <b>DRMIDVERSION</b>
    ///(0).
    uint  uVersion;
    ///A pointer to a null-terminated Unicode string that contains the ID type. If you are using this parameter to
    ///create a bound license, you must specify the same value that you set in the <i>wszIDType</i> parameter of the
    ///DRMSetMetaData function. For more information, see DRMBOUNDLICENSEPARAMS. If you are using this parameter in the
    ///DRMCreateEnablingPrincipal function, the value can be <b>NULL</b>.
    PWSTR wszIDType;
    ///A pointer to a null-terminated Unicode string that contains the object ID. If you are using this parameter to
    ///create a bound license, you must specify the same value that you set in the <i>wszID</i> parameter of the
    ///DRMSetMetaData function. For more information, see DRMBOUNDLICENSEPARAMS. If you are using this parameter in the
    ///DRMCreateEnablingPrincipal function, the value can be <b>NULL</b>.
    PWSTR wszID;
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRMBOUNDLICENSEPARAMS</b> structure is used by
///DRMCreateBoundLicense to bind to a license.
struct DRMBOUNDLICENSEPARAMS
{
    ///Specifies the version of the structure. This member should be set to <b>DRMBOUNDLICENSEPARAMSVERSION</b>.
    uint  uVersion;
    ///A handle to an enabling principal in the end-user license that should be bound. Create this handle by using the
    ///DRMCreateEnablingPrincipal function. The default for this member is <b>NULL</b>. If <b>NULL</b> is used, the
    ///application will bind to the first principal in the license.
    uint  hEnablingPrincipal;
    ///Reserved for future use. This member must be set to <b>NULL</b>.
    uint  hSecureStore;
    ///A pointer to a null-terminated Unicode string that contains a comma-delimited list of the rights requested. This
    ///member cannot be <b>NULL</b>, and the string must contain valid rights such as EDIT and OWNER.
    PWSTR wszRightsRequested;
    ///A pointer to a null-terminated Unicode string that contains the name of the rights group to use in the license;
    ///for more information, see Remarks. This member can be set to <b>NULL</b> if it is not used.
    PWSTR wszRightsGroup;
    ///A DRMID structure that identifies the content to which you are trying to bind. You must set the <i>wszID</i> and
    ///<i>wszIDType</i> parameters of this structure to the values you specified in the <i>wszContentId</i> and
    ///<i>wszContentIdType</i> parameters, respectively, in the DRMSetMetaData function. If the values are <b>NULL</b>
    ///or they do not match the corresponding values in <b>DRMSetMetaData</b>, the DRMCreateBoundLicense function
    ///returns an error.
    DRMID idResource;
    ///Reserved for future use. This member must be set to zero.
    uint  cAuthenticatorCount;
    ///Reserved for future use. This member must be set to <b>NULL</b>.
    uint* rghAuthenticators;
    ///A pointer to a null-terminated Unicode string that contains the certificate for the enabling principal (the
    ///rights account certificate). This member can be set to <b>NULL</b> if it is not used.
    PWSTR wszDefaultEnablingPrincipalCredentials;
    ///Optional. Contains flags for additional settings. This member can be zero or the following value.
    uint  dwFlags;
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. Not supported. The <b>DRM_LICENSE_ACQ_DATA</b> structure
///holds license acquisition data during nonsilent license acquisition. <div class="alert"><b>Note</b> nonsilent license
///acquisition is supported only in Rights Management Services client 1.0. Effective with RMS client 1.0 SP1, nonsilent
///license acquisition is no longer supported.</div><div> </div>
struct DRM_LICENSE_ACQ_DATA
{
    ///Version of this structure, for backward compatibility. In C, this value should be initialized to
    ///<b>DRMLICENSEACQDATAVERSION</b>.
    uint   uVersion;
    ///URL of a license-granting website.
    PWSTR  wszURL;
    ///The path and file name of a local HTML file that will automatically send a license request when loaded in a
    ///browser.
    PWSTR  wszLocalFilename;
    ///Pointer to a URL-safe base64-encoded string containing the license request.
    ubyte* pbPostData;
    ///The post data size in characters, plus one for a null terminator.
    uint   dwPostDataSize;
    ///A human-readable name for the license-granting website.
    PWSTR  wszFriendlyName;
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRM_ACTSERV_INFO</b> structure stores information
///about the activation server.
struct DRM_ACTSERV_INFO
{
    ///Version of this structure, for backward compatibility. When using C, this value should be initialized to
    ///<b>DRMACTSERVINFOVERSION</b>. In C++ this is done automatically.
    uint  uVersion;
    ///This member is reserved and must be set to <b>NULL</b>.
    PWSTR wszPubKey;
    ///URL for a service that performs activation. Use DRMGetServiceLocation to find a service location if none is
    ///known, or pass in <b>NULL</b> to use Passport service discovery. The URL should have the form
    ///<b>http://</b><i>CompanyName</i><b>/_wmcs/certification</b>, for example,
    ///http://blueyonderairlines/_wmcs/certification. The parameter defaults to <b>NULL</b> in C++.
    PWSTR wszURL;
}

///>[!Note] >The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in Windows
///Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be altered
///or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1, which
///leverages functionality exposed by the client in Msipc.dll. The <b>DRM_CLIENT_VERSION_INFO</b> structure receives
///information about the version of the Active Directory Rights Management Services (AD RMS) client and the hierarchy,
///such as Production or Pre-production. This structure is used by the DRMGetClientVersion function.
struct DRM_CLIENT_VERSION_INFO
{
    ///Version of this structure, for backward compatibility. In C, this value should be initialized to
    ///<b>DRMCLIENTSTRUCTVERSION</b>.
    uint        uStructVersion;
    ///Array of type <b>DWORD</b> that receives the version number of the Active Directory Rights Management Services
    ///client software. The version number consists of the following parts.
    uint[4]     dwVersion;
    ///Array of type <b>WCHAR</b> that receives the hierarchy information, such as Production or Pre-production.
    ushort[256] wszHierarchy;
    ///Array of type <b>WCHAR</b> that receives the product ID. This member is not currently filled by the
    ///DRMGetClientVersion function.
    ushort[256] wszProductId;
    ///Array of type <b>WCHAR</b> that receives the product description. This member is not currently filled by the
    ///DRMGetClientVersion function.
    ushort[256] wszProductDescription;
}

// Functions

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMSetGlobalOptions</b> function sets
///the transport protocol to a specified value and optionally specifies whether the server lockbox is used.
///Params:
///    eGlobalOptions = A value of the DRMGLOBALOPTIONS enumeration that specifies the option to set. Only one option can be specified in
///                     each call to <b>DRMSetGlobalOptions</b>. For example, if both WinHTTP and the server lockbox are required, you
///                     must call <b>DRMSetGlobalOptions</b> twice, once with <i>eGlobalOptions</i> set to
///                     <b>DRMGLOBALOPTIONS_USE_WINHTTP</b> and once with <i>eGlobalOptions</i> set to
///                     <b>DRMGLOBALOPTIONS_USE_SERVERSECURITYPROCESSOR</b>.
///    pvdata = A pointer to a <b>void</b> value. This parameter is not currently used.
///    dwlen = The size, in bytes, of the <i>pvdata</i> buffer. This parameter is not currently used.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMSetGlobalOptions(DRMGLOBALOPTIONS eGlobalOptions, void* pvdata, uint dwlen);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetClientVersion</b> function
///returns the version number of the Active Directory Rights Management Services client software and whether the
///hierarchy is for Production or Pre-production purposes.
///Params:
///    pDRMClientVersionInfo = Pointer to a DRM_CLIENT_VERSION_INFO structure that receives the version number of the Active Directory Rights
///                            Management Services client software and the hierarchy information, such as Production or Pre-production.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetClientVersion(DRM_CLIENT_VERSION_INFO* pDRMClientVersionInfo);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMInitEnvironment</b> function
///creates a secure environment for all rights management calls.
///Params:
///    eSecurityProviderType = Specifies the type of security provider to use.
///    eSpecification = Specifies which security provider to use.
///    wszSecurityProvider = The file name and ID of the security provider. A security provider can be a file on the computer (the lockbox) or
///                          a hardware device that holds the secure machine key. The path to this key is obtained by calling
///                          DRMGetSecurityProvider.
///    wszManifestCredentials = A signed XrML structure that specifies conditions on the environment. For information about making a manifest,
///                             see Creating an Application Manifest.
///    wszMachineCredentials = The machine certificate.
///    phEnv = A pointer to an environment handle. Close the handle by calling DRMCloseEnvironmentHandle.
///    phDefaultLibrary = A pointer to the handle of the library used to create the principal object. You must close this handle before
///                       closing the environment handle. For more information, see the Remarks section. Close by calling DRMCloseHandle.
///Returns:
///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b>
///    value that indicates the error. Possible values include, but are not limited to, those in the following list. For
///    a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMInitEnvironment(DRMSECURITYPROVIDERTYPE eSecurityProviderType, DRMSPECTYPE eSpecification, 
                           PWSTR wszSecurityProvider, PWSTR wszManifestCredentials, PWSTR wszMachineCredentials, 
                           uint* phEnv, uint* phDefaultLibrary);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMLoadLibrary</b> function loads a
///handle to an approved library, as determined by the credentials.
///Params:
///    hEnv = A handle to an environment, created by DRMInitEnvironment.
///    eSpecification = The library provider type.
///    wszLibraryProvider = Name and optional path to the DLL. Every DLL must have a unique name. If similarly named DLLs are loaded, even if
///                         they are in different paths, only the first item will be included in the manifest and checked.
///    wszCredentials = Reserved, must be <b>NULL</b>. The DLL that is loaded must be referenced in the application manifest loaded by
///                     DRMInitEnvironment.
///    phLibrary = A handle to the library.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMLoadLibrary(uint hEnv, DRMSPECTYPE eSpecification, PWSTR wszLibraryProvider, PWSTR wszCredentials, 
                       uint* phLibrary);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateEnablingPrincipal</b>
///function creates an enabling principal needed to bind to a license.
///Params:
///    hEnv = A handle to an environment created by DRMInitEnvironment.
///    hLibrary = A handle to a library. Currently, the only valid library that can be used is the one passed out by
///               DRMInitEnvironment.
///    wszObject = A pointer to a null-terminated Unicode string that specifies the enabling principal type. An application can use
///                the object constants specified in Msdrmgetinfo.h.
///    pidPrincipal = A pointer to a DRMID structure that identifies the enabling principal. The <b>DRMID</b> members can be
///                   <b>NULL</b> to use the first principal in a license.
///    wszCredentials = A pointer to a null-terminated Unicode string that contains the rights account certificate of the current user.
///    phEnablingPrincipal = A pointer to a <b>DRMHANDLE</b> value that receives the created principal. Call DRMCloseHandle to close the
///                          handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateEnablingPrincipal(uint hEnv, uint hLibrary, PWSTR wszObject, DRMID* pidPrincipal, 
                                   PWSTR wszCredentials, uint* phEnablingPrincipal);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCloseHandle</b> function closes
///handles to objects created with <b>DRMCreate</b>* functions and libraries loaded by using DRMLoadLibrary.
///Params:
///    handle = A handle to close.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCloseHandle(uint handle);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCloseEnvironmentHandle</b> function
///closes an environment handle.
///Params:
///    hEnv = A handle to an environment.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCloseEnvironmentHandle(uint hEnv);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDuplicateHandle</b> function
///creates a copy of a <b>DRMHANDLE</b>.
///Params:
///    hToCopy = A handle to copy.
///    phCopy = A copy of the handle. Call DRMCloseHandle to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDuplicateHandle(uint hToCopy, uint* phCopy);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDuplicateEnvironmentHandle</b>
///function creates a copy of an environment handle.
///Params:
///    hToCopy = A handle to copy. An environment handle is created by using DRMInitEnvironment.
///    phCopy = A copy of the handle. Call DRMCloseEnvironmentHandle to close.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDuplicateEnvironmentHandle(uint hToCopy, uint* phCopy);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMRegisterRevocationList</b> function
///registers a rights revocation list on the client.
///Params:
///    hEnv = A handle to an environment, created by DRMInitEnvironment.
///    wszRevocationList = Revocation list as a null-terminated string.
///Returns:
///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b>
///    value that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMRegisterRevocationList(uint hEnv, PWSTR wszRevocationList);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] In the Rights Management Services client 1.0
///SP1 and later versions, the <b>DRMCheckSecurity</b> function returns <b>S_OK</b> for any level of the security check
///being run.
///Params:
///    hEnv = A handle to an environment.
///    cLevel = Level of the security check to run, from 1 to 10, with 10 being the most secure but most resource-intensive.
///Returns:
///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b>
///    value that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCheckSecurity(uint hEnv, uint cLevel);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMRegisterContent</b> function
///informs the Active Directory Rights Management Services (AD RMS) client that an AD RMS-protected document is being or
///is no longer being displayed.
///Params:
///    fRegister = Pass <b>TRUE</b> when you open an AD RMS-protected document. Pass <b>FALSE</b> when you close that document.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMRegisterContent(BOOL fRegister);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMEncrypt</b> function encrypts data.
///Params:
///    hCryptoProvider = A handle to an AD RMS encrypting object created by using the DRMCreateEnablingBitsEncryptor function.
///    iPosition = Position in the buffer at which to start encrypting. <b>0</b> corresponds to the first block in a buffer,
///                <b>1</b> corresponds to the second block, and so on. <div class="alert"><b>Note</b> If you use the <b>AES</b> key
///                when you sign the issuance license, <i>iPosition</i> can always be set to 0.</div> <div> </div>
///    cNumInBytes = The number of bytes to encrypt.
///    pbInData = A pointer to a buffer that contains the bytes to encrypt.
///    pcNumOutBytes = The number of encrypted bytes.
///    pbOutData = A pointer to the encrypted bytes.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMEncrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, 
                   ubyte* pbOutData);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDecrypt</b> function decrypts
///encrypted content.
///Params:
///    hCryptoProvider = A handle to an AD RMS decrypting object created by DRMCreateEnablingBitsDecryptor.
///    iPosition = Position in the buffer at which to start decrypting. <b>0</b> corresponds to the first block in a buffer,
///                <b>1</b> corresponds to the second block, and so on. See the example later in this topic.
///    cNumInBytes = Number of bytes to decrypt.
///    pbInData = Pointer to a buffer that contains the bytes to decrypt.
///    pcNumOutBytes = Size, in bytes, of the decrypted data.
///    pbOutData = Decrypted data.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDecrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, 
                   ubyte* pbOutData);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateBoundLicense</b> function
///allows an application to examine or exercise the rights on a locally stored license.
///Params:
///    hEnv = A handle to an environment; the handle is created by using the DRMInitEnvironment function.
///    pParams = A pointer to a DRMBOUNDLICENSEPARAMS structure that specifies additional options; for more information, see the
///              Remarks section. The principal specified here is the one the application will try to bind to. If you pass in
///              <b>NULL</b> to identify the principal or rights group, the first principal or rights group in the license will be
///              used.
///    wszLicenseChain = A pointer to a null-terminated Unicode string that contains the end-user license (or license chain).
///    phBoundLicense = A pointer to a handle that receives the bound license. The <b>DRMHANDLE</b> passed back through
///                     <i>phBoundLicense</i> allows an application to navigate through all the license's objects (such as principals or
///                     rights) and attributes (such as maximum play count). A bound license consolidates duplicated rights information
///                     in the license and removes any rights information that is not available to the current user.
///    phErrorLog = This parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateBoundLicense(uint hEnv, DRMBOUNDLICENSEPARAMS* pParams, PWSTR wszLicenseChain, 
                              uint* phBoundLicense, uint* phErrorLog);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateEnablingBitsDecryptor</b>
///function creates a decryption object that is used to decrypt content data.
///Params:
///    hBoundLicense = A handle to a bound license object created by using DRMCreateBoundLicense.
///    wszRight = An optional null-terminated string that contains the right to exercise. A decrypting object can be bound to only
///               one right at a time.
///    hAuxLib = Reserved for future use. This parameter must be <b>NULL</b>.
///    wszAuxPlug = Reserved for future use. This parameter must be <b>NULL</b>.
///    phDecryptor = A pointer to the decrypting object.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateEnablingBitsDecryptor(uint hBoundLicense, PWSTR wszRight, uint hAuxLib, PWSTR wszAuxPlug, 
                                       uint* phDecryptor);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateEnablingBitsEncryptor</b>
///function creates an AD RMS encrypting object that is used to encrypt content data.
///Params:
///    hBoundLicense = A handle to a bound license, produced by DRMCreateBoundLicense.
///    wszRight = Optional null-terminated string containing a right. If you specify <b>NULL</b>, the AD RMS encrypting object
///               binds to the first valid right in the license.
///    hAuxLib = Reserved for future use. This parameter must be <b>NULL</b>.
///    wszAuxPlug = Reserved for future use. This parameter must be <b>NULL</b>.
///    phEncryptor = A pointer to the encrypting object.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateEnablingBitsEncryptor(uint hBoundLicense, PWSTR wszRight, uint hAuxLib, PWSTR wszAuxPlug, 
                                       uint* phEncryptor);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] <p class="CCE_Message">[The <b>DRMAttest</b>
///function is no longer supported and returns E_NOTIMPL.] For Rights Management Services 1.0, the <b>DRMAttest</b>
///function signs arbitrary data.
///Params:
///    hEnablingPrincipal = A handle to an enabling principal object created by using DRMCreateEnablingPrincipal.
///    wszData = The data to encode.
///    eType = An enumeration that determines whether to include full environment data or only a hash.
///    pcAttestedBlob = Length, in characters, of the string being returned, plus one for a terminating null character.
///    wszAttestedBlob = The signed data.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMAttest(uint hEnablingPrincipal, PWSTR wszData, DRMATTESTTYPE eType, uint* pcAttestedBlob, 
                  PWSTR wszAttestedBlob);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetTime</b> function requests a
///secure time from the rights management system.
///Params:
///    hEnv = Environment handle.
///    eTimerIdType = The type of time returned.
///    poTimeObject = Pointer to a time structure.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetTime(uint hEnv, DRMTIMETYPE eTimerIdType, SYSTEMTIME* poTimeObject);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetInfo</b> function retrieves
///information about encrypting or decrypting objects.
///Params:
///    handle = Specifies the handle to query. This can be created by using one of the following functions: <ul> <li>
///             DRMCreateEnablingBitsDecryptor </li> <li> DRMCreateEnablingBitsEncryptor </li> </ul> <div
///             class="alert"><b>Note</b> You can specify only the handle of an encrypting or a decrypting object. If you specify
///             any other handle, the function returns <b>E_DRM_INVALID_HANDLE</b>.</div> <div> </div>
///    wszAttribute = The attribute of the handle to query for. The supported attributes are <b>g_wszQUERY_BLOCKSIZE</b>, to determine
///                   the block size, and <b>g_wszQUERY_SYMMETRICKEY_TYPE</b>, to determine whether the cipher mode is AES ECB or AES
///                   CBC 4K. <div class="alert"><b>Note</b> You can use <b>g_wszQUERY_SYMMETRICKEY_TYPE</b> only in Windows 7. It is
///                   not available for earlier versions of AD RMS.</div> <div> </div>
///    peEncoding = Pointer to a DRMENCODINGTYPE enumeration that identifies the type of encoding to be applied to the information
///                 retrieved.
///    pcBuffer = A pointer to a <b>UINT</b> value that, on input, contains the size of the buffer pointed to by the
///               <i>pbBuffer</i> parameter. The size of the buffer is expressed as the number of Unicode characters, including the
///               terminating null character. On output, the value contains the number of characters copied to the buffer. The
///               number copied includes the terminating null character.
///    pbBuffer = A pointer to a null-terminated Unicode string that receives the value associated with the attribute specified by
///               the <i>wszAttribute</i> parameter. The size of this buffer is specified by the <i>pcBuffer</i> parameter. The
///               size is expressed as the number of Unicode characters, including the terminating null character. <div
///               class="alert"><b>Important</b> If the publishing license was signed using the <b>AES_CBC4K</b> value, and the
///               <i>wszAttribute</i> parameter is specified as <b>g_wszQUERY_BLOCKSIZE</b>, <i>pbBuffer</i> returns a value of
///               <b>4096</b>.</div> <div> </div> <div class="alert"><b>Important</b> If <i>wszAttribute</i> is specified as
///               <b>g_wszQUERY_SYMMETRICKEY_TYPE</b>, possible values for <i>pbBuffer</i> include <b>AES</b> for ECB encryption
///               and <b>AES_CBC4K</b> for CBC encryption.</div> <div> </div>
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetInfo(uint handle, PWSTR wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] <p class="CCE_Message">[The
///<b>DRMGetEnvironmentInfo</b> function is no longer supported and returns S_OK. Instead, use the DRMGetInfo function.]
///The <b>DRMGetEnvironmentInfo</b> function returns information about a secure environment.
///Params:
///    handle = Environment handle.
///    wszAttribute = The attribute to query for. In Rights Management Services client 1.0 SP1, the only supported attribute is
///                   <b>g_wszQUERY_BLOCKSIZE</b>. In Rights Management Services client 1.0, the attributes that can be queried are
///                   listed in the header file Msdrmgetinfo.h. Attributes include <b>g_wszQUERY_MANIFESTSOURCE</b> and
///                   <b>g_wszQUERY_APIVERSION</b>.
///    peEncoding = Encoding type used.
///    pcBuffer = A pointer to a UINT value that, on input, contains the size of the buffer pointed to by the <i>pbBuffer</i>
///               parameter. The size of the buffer is expressed as the number of Unicode characters, including the terminating
///               null character. On output, the value contains the number of characters copied to the buffer. The number copied
///               includes the terminating null character.
///    pbBuffer = A pointer to a null-terminated Unicode string that receives the value associated with the attribute specified by
///               the <i>wszAttribute</i> parameter. The size of this buffer is specified by the <i>pcBuffer</i> parameter. The
///               size is expressed as the number of Unicode characters, including the terminating null character.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetEnvironmentInfo(uint handle, PWSTR wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, 
                              ubyte* pbBuffer);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetProcAddress</b> function returns
///the address of a function in a library. It is the secure version of the GetProcAddress function.
///Params:
///    hLibrary = A handle to the library where the function resides. Output from DRMLoadLibrary or DRMInitEnvironment.
///    wszProcName = The name of the function to find the address of.
///    ppfnProcAddress = Address of the procedure to run.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetProcAddress(uint hLibrary, PWSTR wszProcName, FARPROC* ppfnProcAddress);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetBoundLicenseObjectCount</b>
///function retrieves the number of occurrences of an object within a specified branch of a license.
///Params:
///    hQueryRoot = A handle to the branch of the license to query, from DRMGetBoundLicenseObject or DRMCreateBoundLicense.
///    wszSubObjectType = The type of XrML object to find. For more information, see Remarks.
///    pcSubObjects = Number of objects of this type within this branch.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetBoundLicenseObjectCount(uint hQueryRoot, PWSTR wszSubObjectType, uint* pcSubObjects);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetBoundLicenseObject</b> function
///returns an object from a bound license.
///Params:
///    hQueryRoot = A handle to a license or license object, from a previous call to this function or from DRMCreateBoundLicense.
///    wszSubObjectType = The type of XrML object to find. For more information, see Remarks.
///    iWhich = Zero-based index specifying which occurrence to retrieve.
///    phSubObject = A handle to the returned license object. Call DRMCloseHandle to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetBoundLicenseObject(uint hQueryRoot, PWSTR wszSubObjectType, uint iWhich, uint* phSubObject);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetBoundLicenseAttributeCount</b>
///function retrieves the number of occurrences of an attribute in a license.
///Params:
///    hQueryRoot = A handle to a license or license object, from DRMGetBoundLicenseObject or DRMCreateBoundLicense.
///    wszAttribute = Name of the attribute to count.
///    pcAttributes = Count of attribute occurrences.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetBoundLicenseAttributeCount(uint hQueryRoot, PWSTR wszAttribute, uint* pcAttributes);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetBoundLicenseAttribute</b>
///function retrieves a bound license attribute from the license XrML.
///Params:
///    hQueryRoot = A handle to a root query object, from a previous call to this function or from DRMCreateBoundLicense.
///    wszAttribute = The attribute to retrieve.
///    iWhich = Zero-based index of the occurrence to retrieve.
///    peEncoding = Encoding type used.
///    pcBuffer = Size, in characters, of the attribute retrieved plus one for a terminating null character.
///    pbBuffer = Pointer to the attribute object.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetBoundLicenseAttribute(uint hQueryRoot, PWSTR wszAttribute, uint iWhich, DRMENCODINGTYPE* peEncoding, 
                                    uint* pcBuffer, ubyte* pbBuffer);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateClientSession</b> function
///creates a client session, which hosts license storage sessions and is used in activation and other function calls.
///Params:
///    pfnCallback = A pointer to an application-defined callback function that will receive asynchronous function status messages in
///                  response to other AD RMS functions, such as DRMActivate. The format of this callback function is defined in
///                  Callback Prototype. This parameter cannot be <b>NULL</b>.
///    uCallbackVersion = Specifies the version of the callback function. Currently, only version zero is supported.
///    wszGroupIDProviderType = A pointer to a null-terminated Unicode string that specifies the authentication type of the submitted rights
///                             account certificate (RAC). This can be one of the following values.
///    wszGroupID = A pointer to a null-terminated Unicode string that contains an email address for the user in the format
///                 <i>someone@example.com</i>. Typically, this value already exists in Active Directory (AD) and is the same ID as
///                 that supplied in the logon credentials. If it is not the same, later calls to DRMIsActivated and
///                 DRMEnumerateLicense will fail. For more information, see Remarks. Set this parameter to <b>NULL</b> if you intend
///                 only to use the client session handle created by this function to retrieve a service location by calling
///                 DRMGetServiceLocation.
///    phClient = A pointer to a <b>DRMHSESSION</b> value that receives the client session handle. When you have finished using the
///               client session, close it by passing this handle to the DRMCloseSession function.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateClientSession(DRMCALLBACK pfnCallback, uint uCallbackVersion, PWSTR wszGroupIDProviderType, 
                               PWSTR wszGroupID, uint* phClient);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMIsActivated</b> function indicates
///whether the current user or machine is activated.
///Params:
///    hClient = A handle to a client session created by using the DRMCreateClientSession function.
///    uFlags = A value that determines whether the current user or machine is being queried for activation status. This can be
///             one of the following values.
///    pActServInfo = This parameter is reserved and must be set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMIsActivated(uint hClient, uint uFlags, DRM_ACTSERV_INFO* pActServInfo);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMActivate</b> function obtains a
///lockbox and machine certificate for a machine or a rights account certificate for a user.
///Params:
///    hClient = A handle to a client session, created by DRMCreateClientSession.
///    uFlags = Specifies the type of activation wanted, plus additional options; for more information, see Remarks. This
///             parameter can be a combination of one or more of the following flags.
///    uLangID = The language ID used by the application. If this parameter is set to zero, the default language ID for the
///              logged-on user is used.
///    pActServInfo = Optional server information. If the client has not been configured to use Active Directory Federation Services
///                   (ADFS) with AD RMS, you can pass <b>NULL</b> to use the Windows Live ID service for service discovery. If the
///                   client has been configured to use ADFS, you must pass the Windows Live certification URL. <!-- Currently, the
///                   Windows Live ID certification service URL is
///                   https://certification.isv.drm.microsoft.com/certification/certification.asmx.--> For more information about
///                   service discovery, see DRMGetServiceLocation.
///    pvContext = A 32-bit, application-defined value that is sent in the <i>pvContext</i> parameter of the callback function. This
///                value can be a pointer to data, a pointer to an event handle, or whatever else the custom callback function is
///                designed to handle. For more information, see Callback Prototype.
///    hParentWnd = Parent window handle used in nonsilent Windows Live ID activation (user activation only). In nonsilent
///                 activation, a Windows Live ID window opens to request user information. This parameter allows the application to
///                 assign an arbitrary window as the window's parent. If this parameter is <b>NULL</b>, the active window is used.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMActivate(uint hClient, uint uFlags, uint uLangID, DRM_ACTSERV_INFO* pActServInfo, void* pvContext, 
                    HWND hParentWnd);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetServiceLocation</b> function
///retrieves the URL of a server that can perform various rights management services, such as activation or license
///acquisition.
///Params:
///    hClient = A handle to a client session. The handle can be obtained by using the DRMCreateClientSession function. The handle
///              is optional and can be <b>NULL</b>.
///    uServiceType = Specifies the type of service desired. This can be one of the following values.
///    uServiceLocation = Specifies where to find the AD RMS server. This can be one of the following values.
///    wszIssuanceLicense = A pointer to a null-terminated Unicode string that contains a signed issuance license. This parameter can be
///                         <b>NULL</b>. For more information, see Remarks.
///    puServiceURLLength = A pointer to a <b>UINT</b> that, on input, contains the size, in characters, of the <i>wszServiceURL</i> buffer.
///                         This value includes the terminating null character. After the function returns, this <b>UINT</b> contains the
///                         number of characters, including the terminating null character, that were copied to the <i>wszServiceURL</i>
///                         buffer. If <i>wszServiceURL</i> is <b>NULL</b>, this <b>UINT</b> receives the number of characters, including the
///                         terminating null character, that are required for the server URL.
///    wszServiceURL = A pointer to a Unicode string buffer that receives the URL of the server. The <i>puServiceURLLength</i> parameter
///                    contains the size, in characters, including the terminating null character, of this buffer. If this parameter is
///                    <b>NULL</b>, <i>puServiceURLLength</i> receives the number of characters, including the terminating null
///                    character, that are required for the server URL.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetServiceLocation(uint hClient, uint uServiceType, uint uServiceLocation, PWSTR wszIssuanceLicense, 
                              uint* puServiceURLLength, PWSTR wszServiceURL);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateLicenseStorageSession</b>
///function creates a license storage session, which is needed to acquire or manipulate a license.
///Params:
///    hEnv = A handle to the AD RMS environment. This handle is obtained by using the DRMInitEnvironment function.
///    hDefaultLibrary = A handle to the default library. This handle is obtained by using the DRMInitEnvironment function.
///    hClient = A handle to a client session. This handle is obtained by using the DRMCreateClientSession function.
///    uFlags = This parameter is reserved and must be set to zero.
///    wszIssuanceLicense = A pointer to a null-terminated Unicode string that contains a signed issuance license. The created license
///                         storage session is associated with this issuance license.
///    phLicenseStorage = A pointer to a handle that receives the license storage session handle. This handle must be passed to the
///                       DRMCloseSession function when the license storage session is no longer needed.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateLicenseStorageSession(uint hEnv, uint hDefaultLibrary, uint hClient, uint uFlags, 
                                       PWSTR wszIssuanceLicense, uint* phLicenseStorage);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMAddLicense</b> function adds an
///end-user license to the temporary or permanent license store.
///Params:
///    hLicenseStorage = A handle to a license storage session, created using DRMCreateLicenseStorageSession.
///    uFlags = Value that specifies whether the temporary or permanent license store is used. This parameter can be one of the
///             following values.
///    wszLicense = A pointer to null-terminated string that contains the end-user license chain to add to the temporary or permanent
///                 license store.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMAddLicense(uint hLicenseStorage, uint uFlags, PWSTR wszLicense);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMAcquireAdvisories</b> function
///retrieves revocation lists required by a submitted license. Retrieved revocation lists are added to the user's
///permanent license store. A revocation list is a signed XrML document that specifies principals that have been revoked
///because they are no longer considered trustworthy or valid. These principals can include rights account certificates,
///machine certificates, code-signing certificates, manifests, and server licensor certificates, among other things.
///Params:
///    hLicenseStorage = A handle to a license storage session created by using the DRMCreateLicenseStorageSession function.
///    wszLicense = A pointer to a null-terminated Unicode string that contains the license that requires a revocation list. This can
///                 be any license or certificate (or certificate chain or concatenated licenses) that supports revocation lists,
///                 including end-user licenses, rights account certificates, or client licensor certificates.
///    wszURL = A pointer to a null-terminated Unicode string that contains an additional URL to query for advisories. This will
///             be checked in addition to any URLs mentioned in the license passed in. This parameter can be set to <b>NULL</b>.
///    pvContext = A 32-bit, application-defined value that is sent in the <i>pvContext</i> parameter of the callback function. This
///                value can be a pointer to data, a pointer to an event handle, or whatever else the custom callback function is
///                designed to handle. For more information, see Callback Prototype.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMAcquireAdvisories(uint hLicenseStorage, PWSTR wszLicense, PWSTR wszURL, void* pvContext);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMEnumerateLicense</b> function
///enumerates valid licenses, machine certificates or rights account certificates, revocation lists for the current
///user, or issuance license templates.
///Params:
///    hSession = A handle to a client or license storage session. The type of session passed into <i>hSession</i> depends on the
///               type of item to enumerate. To enumerate end-user licenses, use a license storage session created by using the
///               DRMCreateLicenseStorageSession function. To enumerate machine certificates, rights account certificates, client
///               licensor certificates, or issuance license templates, use a client session created by using the
///               DRMCreateClientSession function. Use either type of handle to enumerate revocation lists.
///    uFlags = Contains one or more of the following values that specifies which types of items to enumerate and other options.
///             The following flag can be combined with other flags to specify additional enumeration options.
///    uIndex = The index number of the certificate or license to retrieve. To begin an enumeration, pass in zero for this
///             parameter. To obtain subsequent licenses, increment this value until the function returns
///             <b>E_DRM_NO_MORE_DATA</b>. For more information, see Remarks.
///    pfSharedFlag = A pointer to a <b>BOOL</b> value that receives one (1) if the retrieved license is shared or zero (0) if the
///                   retrieved license is not shared.
///    puCertificateDataLen = A pointer to a UINT value that, on entry, contains the size of the <i>wszCertificateData</i> buffer. This size
///                           includes the terminating null character. After the function returns, this value contains the number of characters
///                           copied to the buffer, including the terminating null character. To obtain the necessary size of the buffer, pass
///                           <b>NULL</b> for <i>wszCertificateData</i>. The required number of characters, including the terminating null
///                           character, will be placed in this value.
///    wszCertificateData = A pointer to a null-terminated Unicode string that receives the license, ID, or template depending on which flags
///                         were set. To obtain the necessary size of this buffer, pass <b>NULL</b> for <i>wszCertificateData</i>. The
///                         required number of characters, including the terminating null character, will be placed in
///                         <i>puCertificateDataLen</i>.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMEnumerateLicense(uint hSession, uint uFlags, uint uIndex, BOOL* pfSharedFlag, 
                            uint* puCertificateDataLen, PWSTR wszCertificateData);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMAcquireLicense</b> function
///attempts to acquire an end-user license or client licensor certificate asynchronously.
///Params:
///    hSession = A handle to a client or license storage session. A client session handle is obtained by using the
///               DRMCreateClientSession function. In this case, a client licensor certificate is acquired. The application
///               callback function specified in the <b>DRMCreateClientSession</b> function will be called with the
///               DRM_MSG_ACQUIRE_CLIENTLICENSOR message to provide status feedback. A license storage session handle is obtained
///               by calling the DRMCreateLicenseStorageSession function. In this case, an end-user license is acquired. The
///               application callback function specified in the client session passed in the <i>hClient</i> parameter of the
///               <b>DRMCreateLicenseStorageSession</b> function will be called with the DRM_MSG_ACQUIRE_LICENSE message to provide
///               status feedback.
///    uFlags = Specifies options for the function call. This parameter can be zero or a combination of one or more of the
///             following flags.
///    wszGroupIdentityCredential = An optional rights account certificate (RAC). If this is not used, this function will check the license store for
///                                 a RAC that matches the license used to create <i>hSession</i>. If none is found, this function will fail.
///    wszRequestedRights = This parameter is reserved and must be <b>NULL</b>.
///    wszCustomData = Optional application-specific data that might be required for a license. This must be a valid XML string. After
///                    returning control to the caller, this function creates a license request by using the application-specific data
///                    specified here.
///    wszURL = A license acquisition URL. This parameter is required when a client licensor certificate is being acquired and
///             optional when an end-user license is being acquired. The URL can be used for both silent and nonsilent license
///             acquisition. When present, this URL overrides the URL specified in the license that was used to create the
///             license storage session passed into <i>hSession</i>. A license may hold multiple license acquisition URLs, but
///             only the first is used by default. To use any of the other URLs specified, you must parse the license. For more
///             information, see the Remarks section.
///    pvContext = A 32-bit, application-defined value that is sent in the <i>pvContext</i> parameter of the callback function. This
///                value can be a pointer to data, a pointer to an event handle, or whatever else the custom callback function is
///                designed to handle. For more information, see Callback Prototype.
///Returns:
///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b>
///    value that indicates the error. Possible values include, but are not limited to, those in the following list. For
///    a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMAcquireLicense(uint hSession, uint uFlags, PWSTR wszGroupIdentityCredential, PWSTR wszRequestedRights, 
                          PWSTR wszCustomData, PWSTR wszURL, void* pvContext);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDeleteLicense</b> function deletes
///a license, client licensor certificate, revocation list, or issuance license template.
///Params:
///    hSession = A handle to a license storage session or client session. You can use a storage session handle to delete end-user
///               licenses and revocation lists. You can use a client session handle to delete end-user licenses, rights account
///               certificates, client licensor certificates, and issuance license templates. You can retrieve a handle to a
///               license storage session by using the DRMCreateLicenseStorageSession function. You can retrieve a handle to a
///               client session by using the DRMCreateClientSession function.
///    wszLicenseId = A pointer to a null-terminated string that contains the ID of the license or template to be deleted. The license
///                   ID can be found inside the <b>ID</b> element of the license XrML, by querying using the license querying
///                   functions and the <b>g_wszQUERY_CONTENTIDVALUE</b> constant. The template ID is a GUID. You can enumerate the
///                   GUIDs by calling the DRMEnumerateLicense function.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDeleteLicense(uint hSession, PWSTR wszLicenseId);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCloseSession</b> function closes a
///client session or a license storage session.
///Params:
///    hSession = A handle to the session to be closed.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCloseSession(uint hSession);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDuplicateSession</b> function
///duplicates a client or license storage session.
///Params:
///    hSessionIn = A handle to a session to duplicate.
///    phSessionOut = Pointer to the duplicated session handle. Call DRMCloseSession to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDuplicateSession(uint hSessionIn, uint* phSessionOut);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetSecurityProvider</b> function
///retrieves the path to a lockbox.
///Params:
///    uFlags = Reserved.
///    puTypeLen = On input, length of the allocated <i>wszType</i> buffer. On output, actual length, in characters, plus one for a
///                null terminator, of the value returned by <i>wszType</i>.
///    wszType = Type of security provider (such as "filename").
///    puPathLen = On input, length of the allocated <i>wszPath</i> buffer. On output, actual length, in characters, plus one for a
///                null terminator, of the value returned by <i>wszPath</i>.
///    wszPath = Path to the lockbox.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetSecurityProvider(uint uFlags, uint* puTypeLen, PWSTR wszType, uint* puPathLen, PWSTR wszPath);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMEncode</b> function encodes data
///using a public encoding method, such as base64.
///Params:
///    wszAlgID = The encoding algorithm. Currently the only valid value is "base64".
///    uDataLen = Length of the input data, in bytes.
///    pbDecodedData = Pointer to the data to encode.
///    puEncodedStringLen = Length of the output data, in bytes.
///    wszEncodedString = The encoded string.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMEncode(PWSTR wszAlgID, uint uDataLen, ubyte* pbDecodedData, uint* puEncodedStringLen, 
                  PWSTR wszEncodedString);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDecode</b> function decodes a
///string encoded with a common algorithm, such as base64.
///Params:
///    wszAlgID = The encoding algorithm name. Currently "base64" is the only valid value.
///    wszEncodedString = The encoded string.
///    puDecodedDataLen = The length of the decoded string, in characters, plus one for a null terminator.
///    pbDecodedData = Pointer to the decoded data.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDecode(PWSTR wszAlgID, PWSTR wszEncodedString, uint* puDecodedDataLen, ubyte* pbDecodedData);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMConstructCertificateChain</b>
///function builds a certificate chain from an arbitrary number of certificates.
///Params:
///    cCertificates = The number of certificates in the <i>rgwszCertificates</i> array.
///    rgwszCertificates = An array of null-terminated Unicode string pointers that contain the certificates to construct the chain from.
///                        The number of elements in this array is specified by the <i>cCertificates</i> parameter.
///    pcChain = A pointer to a <b>UINT</b> that, on input, contains the size, in Unicode characters, of the <i>wszChain</i>
///              string. This character count must include the terminating null character. On output, this <b>UINT</b> receives
///              the number of Unicode characters copied into the buffer, including the terminating null character.
///    wszChain = A pointer to a null-terminated Unicode string that receives the constructed chain. To determine the required size
///               for this buffer, call this function with <b>NULL</b> for the <i>wszChain</i> parameter. The required number of
///               Unicode characters, including the terminating null character, will be returned in the <i>pcChain</i> parameter.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMConstructCertificateChain(uint cCertificates, PWSTR* rgwszCertificates, uint* pcChain, PWSTR wszChain);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMParseUnboundLicense</b> function
///creates a handle to an unbound license, to allow an application to navigate its objects and attributes. For more
///information, see Remarks.
///Params:
///    wszCertificate = The leaf certificate on the license to be examined, in plain text (not encoded).
///    phQueryRoot = Pointer to a handle to the root object of the license. Call DRMCloseQueryHandle to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMParseUnboundLicense(PWSTR wszCertificate, uint* phQueryRoot);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCloseQueryHandle</b> function
///closes a handle to an unbound license object.
///Params:
///    hQuery = A handle to an object in an unbound license.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCloseQueryHandle(uint hQuery);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUnboundLicenseObjectCount</b>
///function counts the instances of an object within a specified branch of the license.
///Params:
///    hQueryRoot = A handle to a license or object in the license, created using DRMGetUnboundLicenseObject or
///                 DRMParseUnboundLicense.
///    wszSubObjectType = The type of XrML object to find. For more information, see Remarks.
///    pcSubObjects = Count of object instances one level down within the specified branch.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseObjectCount(uint hQueryRoot, PWSTR wszSubObjectType, uint* pcSubObjects);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUnboundLicenseObject</b>
///function retrieves an object of a specified type in an unbound license.
///Params:
///    hQueryRoot = A handle to a license or object in the license, created using <b>DRMGetUnboundLicenseObject</b> or
///                 DRMParseUnboundLicense.
///    wszSubObjectType = Name of the object to find.
///    iIndex = Zero-based index indicating which instance to retrieve, if more than one exists.
///    phSubQuery = The retrieved object. Call DRMCloseHandle to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseObject(uint hQueryRoot, PWSTR wszSubObjectType, uint iIndex, uint* phSubQuery);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUnboundLicenseAttributeCount</b>
///function retrieves the number of occurrences of an attribute within an object in an unbound license.
///Params:
///    hQueryRoot = A handle to a license or an object in the license, created using DRMGetUnboundLicenseObject or
///                 DRMParseUnboundLicense.
///    wszAttributeType = Name of the attribute to retrieve.
///    pcAttributes = Count of attribute occurrences one level down within the specified branch.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseAttributeCount(uint hQueryRoot, PWSTR wszAttributeType, uint* pcAttributes);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUnboundLicenseAttribute</b>
///function retrieves an unbound license attribute from the underlying XrML.
///Params:
///    hQueryRoot = A handle to a license or object in the license, created by using DRMGetUnboundLicenseObject or
///                 DRMParseUnboundLicense.
///    wszAttributeType = Name of the attribute to retrieve.
///    iWhich = Zero-based index of the attribute to retrieve.
///    peEncoding = An enumeration value specifying the encoding type of the return value.
///    pcBuffer = Size of the returned data, in characters, plus one for a null terminator.
///    pbBuffer = Attribute value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseAttribute(uint hQueryRoot, PWSTR wszAttributeType, uint iWhich, 
                                      DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetCertificateChainCount</b>
///function retrieves the number of certificates in a certificate chain.
///Params:
///    wszChain = The chain to count.
///    pcCertCount = The number of certificates in the chain.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetCertificateChainCount(PWSTR wszChain, uint* pcCertCount);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDeconstructCertificateChain</b>
///function retrieves a specified certificate from a certificate chain.
///Params:
///    wszChain = The certificate chain.
///    iWhich = A zero-based index specifying which certificate to retrieve.
///    pcCert = The length of the retrieved certificate, in characters, plus one for a null terminator.
///    wszCert = The certificate requested.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDeconstructCertificateChain(PWSTR wszChain, uint iWhich, uint* pcCert, PWSTR wszCert);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] <p class="CCE_Message">[The <b>DRMVerify</b>
///function is no longer supported and returns E_NOTIMPL.] For Rights Management Services 1.0, the <b>DRMVerify</b>
///function verifies data signed with DRMAttest.
///Params:
///    wszData = The data to verify (original data).
///    pcAttestedData = Length, in characters, of the data to verify, plus one for a terminating null character.
///    wszAttestedData = The signed data.
///    peType = Whether full environment information, or just a hash of the environment, is included.
///    pcPrincipal = Size, in characters, of the <i>wszPrincipalCredentials</i> parameter, plus one for a terminating null character.
///    wszPrincipal = Certificate chain of the principal attesting the data. This chain is needed to create the principal used to
///                   verify the data.
///    pcManifest = Size, in characters, of the manifest used to sign the data, plus one for a terminating null character. For
///                 information about making a manifest, see Creating an Application Manifest.
///    wszManifest = The manifest used to sign, as a null-terminated string.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMVerify(PWSTR wszData, uint* pcAttestedData, PWSTR wszAttestedData, DRMATTESTTYPE* peType, 
                  uint* pcPrincipal, PWSTR wszPrincipal, uint* pcManifest, PWSTR wszManifest);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateUser</b> function creates a
///user that will be granted a right.
///Params:
///    wszUserName = A null-terminated string that identifies a user or group of users (see Remarks). This parameter is often an email
///                  address. When the user created is passed in as <i>hOwner</i> to DRMCreateIssuanceLicense, this value is attached
///                  to the Owner node in the license XrML. For more information about possible values for this parameter, see the
///                  <i>wszUserIdType</i> parameter.
///    wszUserId = A null-terminated string that identifies a user that will be granted a right. This parameter can be a Passport ID
///                (PUID), Windows ID security ID (SID), or <b>NULL</b>. If this parameter is <b>NULL</b>, <i>wszUserIdType</i> must
///                contain "Unspecified". This ID is verified by the Active Directory Rights Management Services system. For more
///                information about possible values for this parameter, see the <i>wszUserIdType</i> parameter.
///    wszUserIdType = The user ID type. This parameter can be one of the following values.
///    phUser = A pointer to the handle of the created user. Call DRMClosePubHandle to close the handle.
///Returns:
///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b>
///    value that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateUser(PWSTR wszUserName, PWSTR wszUserId, PWSTR wszUserIdType, uint* phUser);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateRight</b> function creates an
///XrML right that will define a right granted to a user or group.
///Params:
///    wszRightName = A pointer to a null-terminated Unicode string that contains the name of a user-defined or standard XrML (version
///                   1.2) right. For more information, see Official Template XrML.
///    pstFrom = A pointer to a SYSTEMTIME structure that contains the time, in UTC time, when this right will become valid. For
///              more information, see Remarks. Both <i>pstFrom</i> and <i>pstUntil</i> must be specified, or both must be
///              <b>NULL</b>.
///    pstUntil = A pointer to a SYSTEMTIME structure that contains the time, in UTC time, when this right will expire. For more
///               information, see Remarks. Both <i>pstFrom</i> and <i>pstUntil</i> must be specified, or both must be <b>NULL</b>.
///    cExtendedInfo = The number of elements in the <i>pwszExtendedInfoName</i> and <i>pwszExtendedInfoValue</i> arrays. If this
///                    parameter is zero, then both the <i>pwszExtendedInfoName</i> and <i>pwszExtendedInfoValue</i> parameters must be
///                    <b>NULL</b>.
///    pwszExtendedInfoName = An array of null-terminated Unicode string pointers that contains the names of extended information data. Each
///                           name in this array must be unique. The <b>cExtendedInfo</b> parameter contains the number of elements in this
///                           array.
///    pwszExtendedInfoValue = An array of null-terminated Unicode string pointers that contains the values of the extended information items.
///                            The <b>cExtendedInfo</b> parameter contains the number of elements in this array.
///    phRight = A pointer to a handle that receives the handle of the created right. This handle can be used with the
///              DRMAddRightWithUser function to bind the right to a user. Call DRMClosePubHandle to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateRight(PWSTR wszRightName, SYSTEMTIME* pstFrom, SYSTEMTIME* pstUntil, uint cExtendedInfo, 
                       PWSTR* pwszExtendedInfoName, PWSTR* pwszExtendedInfoValue, uint* phRight);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMCreateIssuanceLicense</b> function
///creates an issuance license from scratch, from a template, or from a signed issuance license.
///Params:
///    pstTimeFrom = The starting UTC validity time for the license. If this value is <b>NULL</b>, the <i>pstTimeUntil</i> parameter
///                  must also be <b>NULL</b>. If both parameters are not <b>NULL</b>, <b>E_DRM_INVALID_TIMEINFO</b> is returned if
///                  the range time is logically inconsistent. For example, <i>pstTimeFrom</i> cannot be later than
///                  <i>pstTimeUntil</i>.
///    pstTimeUntil = The ending UTC validity time for the license. If this value is <b>NULL</b>, the <i>pstTimeFrom</i> parameter must
///                   also be <b>NULL</b>. If both parameters are not <b>NULL</b>, <b>E_DRM_INVALID_TIMEINFO</b> is returned if the
///                   range time is logically inconsistent. For example, <i>pstTimeFrom</i> cannot be later than <i>pstTimeUntil</i>.
///    wszReferralInfoName = Nonsilent license acquisition is not supported; set this parameter to <b>NULL</b>. For Rights Management Services
///                          (RMS) client 1.0, this parameter is a pointer to a null-terminated Unicode string that contains the display name
///                          for the URL in <i>wszReferralInfoURL</i>. This parameter is optional and can be <b>NULL</b>.
///    wszReferralInfoURL = Nonsilent license acquisition is not supported; set this parameter to <b>NULL</b>. For RMS client 1.0, this
///                         parameter is a pointer to a null-terminated Unicode string that contains the URL where an application should go
///                         to request a license for the content nonsilently. This should be an HTML page that hosts the ActiveX control.
///                         This parameter is optional and can be <b>NULL</b>.
///    hOwner = A handle to the user that owns the issuance license. The handle is created by calling the DRMCreateUser function.
///             The owner is identified under the <b>Owner</b> node in the issuance license XrML. This parameter is optional and
///             can be <b>NULL</b>. Do not confuse the owner of an issuance license with a user who has been granted the OWNER
///             right. Ownership of an issuance license does not automatically grant any rights to use or modify content.
///             Specifying a value for the optional <i>hOwner</i> parameter merely enables an application to identify the content
///             owner or author. The ID is added as metadata to the license. The OWNER right, on the other hand, grants a user
///             the authority to exercise all rights contained in the license. Granting yourself (or anyone else) the OWNER right
///             must be done explicitly by using DRMAddRightWithUser. Zero, one, or more users can be granted the OWNER right,
///             which never expires. If specified, the issuance license owner is added as metadata beneath the &lt;WORK&gt; node
///             of the license. ``` <WORK> <OBJECT type="contentType"> <ID type="contentIdType">contentId</ID>
///             <NAME>contentName</NAME> </OBJECT> <METADATA> <OWNER> <OBJECT> <ID type="Windows"/>
///             <NAME>david@contoso.com</NAME> </OBJECT> </OWNER> </METADATA> ... ``` If granted, the OWNER right is added as an
///             attribute of the &lt;RIGHT&gt; element in the license XrML. ``` <WORK> ... <RIGHTSGROUP name="MainRights">
///             <RIGHTSLIST> <VIEW> ... </VIEW> <RIGHT name="OWNER"> <CONDITIONLIST> ... </CONDITIONLIST> </RIGHT> </RIGHTSLIST>
///             </RIGHTSGROUP> ``` <div class="alert"><b>Note</b> In the case where you set <i>hOwner</i> to the license author
///             and use a template where you check the <b>Grant Owner (author) full control right with no expiration</b> check
///             box, the license author can subsequently get an end-user license with Owner rights. See Understanding XrML Rights
///             for more information.</div> <div> </div>
///    wszIssuanceLicense = A pointer to a null-terminated Unicode string that contains an issuance license template or a signed issuance
///                         license. You can call the DRMGetIssuanceLicenseTemplate function to retrieve a template. If this parameter is
///                         <b>NULL</b>, an issuance license is created.
///    hBoundLicense = A handle to a bound license that contains the VIEWRIGHTSDATA, EDITRIGHTSDATA or OWNER right, which allows an
///                    application to reuse rights data or reuse the content key from a previous issuance license. This parameter is
///                    optional and can be <b>NULL</b>. For further information about rights, see Understanding XrML Rights. <div
///                    class="alert"><b>Note</b> If your intent is to create a new issuance license, but you want to use the content key
///                    from the original signed issuance license, ensure that the <i>hBoundLicense</i> you pass in to
///                    <b>DRMCreateIssuanceLicense</b> is bound to either the OWNER or EDITRIGHTSDATA right. In a subsequent call to
///                    DRMGetSignedIssuanceLicense, pass in the issuance license handle obtained from <b>DRMCreateIssuanceLicense</b>
///                    and the DRM_REUSE_KEY flag in order to reuse the content key.</div> <div> </div>
///    phIssuanceLicense = A pointer to a DRMPUBHANDLE that receives the handle to the new issuance license.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMCreateIssuanceLicense(SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, PWSTR wszReferralInfoName, 
                                 PWSTR wszReferralInfoURL, uint hOwner, PWSTR wszIssuanceLicense, uint hBoundLicense, 
                                 uint* phIssuanceLicense);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMAddRightWithUser</b> function
///assigns a right to a user in an issuance license.
///Params:
///    hIssuanceLicense = The handle of the issuance license to add the right to. This handle is obtained by using the
///                       DRMCreateIssuanceLicense function.
///    hRight = The handle of the right to add to the issuance license. This handle is obtained by using the DRMCreateRight
///             function.
///    hUser = The handle of the user to apply the right to. This handle is obtained by using the DRMCreateUser function.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMAddRightWithUser(uint hIssuanceLicense, uint hRight, uint hUser);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMClearAllRights</b> function removes
///all rights from an existing issuance license.
///Params:
///    hIssuanceLicense = A handle to the issuance license to remove the rights from.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMClearAllRights(uint hIssuanceLicense);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMSetMetaData</b> function adds
///application-specific metadata to an issuance license.
///Params:
///    hIssuanceLicense = The handle of the issuance license to which the metadata will be added.
///    wszContentId = A pointer to a null-terminated Unicode string that uniquely identifies an item of content. The string can contain
///                   up to 40 characters plus a terminating null character. We recommend that you use <b>CoCreateGUID</b> to create a
///                   GUID. For more information about content IDs, see Remarks.
///    wszContentIdType = A pointer to a null-terminated Unicode string that specifies the type of identifier represented by the
///                       <i>wszContentId</i> parameter. Possible examples include "MSGUID", "ISBN", "CatalogNumber", and any other that
///                       you consider appropriate.
///    wszSKUId = A pointer to a null-terminated Unicode string that contains an optional identifier. The string can contain up to
///               40 characters plus a terminating null character. The SKU ID is optional and allows for further content
///               identification beyond that provided by the required content ID. If <i>wszSKUIdType</i> is specified, the
///               <i>wszSKUId</i> parameter must be specified. Otherwise, it can be <b>NULL</b>.
///    wszSKUIdType = A pointer to a null-terminated Unicode string that contains the type of identifier represented by the
///                   <i>wszSKUId</i> parameter. If <i>wszSKUId</i> is specified, the <i>wszSKUIdType</i> parameter must be specified.
///                   Otherwise, it can be <b>NULL</b>.
///    wszContentType = A pointer to a null-terminated Unicode string that contains application-defined information about the content.
///                     Examples include "Financial Statement", "Source Code", "Office Document", and any other that you consider
///                     appropriate. This parameter is optional and can be <b>NULL</b>.
///    wszContentName = A pointer to a null-terminated Unicode string that contains a display name for the content. This parameter is
///                     optional and can be <b>NULL</b>.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMSetMetaData(uint hIssuanceLicense, PWSTR wszContentId, PWSTR wszContentIdType, PWSTR wszSKUId, 
                       PWSTR wszSKUIdType, PWSTR wszContentType, PWSTR wszContentName);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMSetUsagePolicy</b> function sets a
///usage policy that requires or denies access to content based on application name, version, or other environment
///characteristics.
///Params:
///    hIssuanceLicense = A handle to an issuance license.
///    eUsagePolicyType = One of the DRM_USAGEPOLICY_TYPE values that specifies the type of usage policy to be added or deleted. Only one
///                       type may be selected.
///    fDelete = Determines whether the policy should be added or removed. <b>TRUE</b> indicates the policy should be deleted.
///              <b>FALSE</b> indicates the policy should be added.
///    fExclusion = Determines whether the application is prohibited from, or required to, exercise the rights. <b>FALSE</b>
///                 indicates that the application is required to exercise the rights. <b>TRUE</b> indicates that the application is
///                 prohibited from exercising the rights. You must specify <b>TRUE</b> if you set the <i>eUsagePolicyType</i>
///                 parameter to <b>DRM_USAGEPOLICY_TYPE_BYNAME</b> or <b>DRM_USAGEPOLICY_TYPE_BYDIGEST</b>.
///    wszName = A pointer to a null-terminated Unicode string that contains the name of the application. This parameter is
///              required when <i>eUsagePolicyType</i> contains <b>DRM_USAGEPOLICY_TYPE_BYNAME</b>. It is ignored for all other
///              <i>eUsagePolicyType</i> values.
///    wszMinVersion = A pointer to a null-terminated Unicode string that contains the minimum version of the application that is
///                    required to or prohibited from exercising rights. This should be a version string in a form similar to "1.0.1" or
///                    "1.00.0000". This parameter is required when <i>eUsagePolicyType</i> contains <b>DRM_USAGEPOLICY_TYPE_BYNAME</b>
///                    or <b>DRM_USAGEPOLICY_TYPE_OSEXCLUSION</b>. It is ignored for all other <i>eUsagePolicyType</i> values.
///    wszMaxVersion = A pointer to a null-terminated Unicode string that contains the maximum version of the application that is
///                    required to or prohibited from exercising rights. This should be a version string in a form similar to "1.0.1" or
///                    "1.00.0000". This parameter is required when <i>eUsagePolicyType</i> contains <b>DRM_USAGEPOLICY_TYPE_BYNAME</b>
///                    and optional when <i>eUsagePolicyType</i> contains <b>DRM_USAGEPOLICY_TYPE_OSEXCLUSION</b>. It is ignored for all
///                    other <i>eUsagePolicyType</i> values. If <i>eUsagePolicyType</i> contains <b>DRM_USAGEPOLICY_TYPE_OSEXCLUSION</b>
///                    and this parameter is specified, the version must be greater than <i>wszMinVersion</i>.
///    wszPublicKey = A pointer to a null-terminated Unicode string that contains the public key used to sign the digest of the
///                   application required to or prohibited from exercising rights. This string must be a well-formed XrML node. This
///                   parameter is required when <i>eUsagePolicyType</i> contains <b>DRM_USAGEPOLICY_TYPE_BYPUBLICKEY</b>. It is
///                   ignored for all other <i>eUsagePolicyType</i> values.
///    wszDigestAlgorithm = A pointer to a null-terminated Unicode string that contains the algorithm used to create the application digest
///                         that is specified by <i>pbDigest</i>. This parameter is required when <i>eUsagePolicyType</i> contains
///                         <b>DRM_USAGEPOLICY_TYPE_BYDIGEST</b>. It is ignored for all other <i>eUsagePolicyType</i> values.
///    pbDigest = A pointer to an array of bytes that contains the application digest required or prohibited from exercising
///               rights. The size of this array is contained in the <i>cbDigest</i> parameter. This parameter is required when
///               <i>eUsagePolicyType</i> contains <b>DRM_USAGEPOLICY_TYPE_BYDIGEST</b>. It is ignored for all other
///               <i>eUsagePolicyType</i> values.
///    cbDigest = The number of bytes in the <i>pbDigest</i> array. This parameter is required when <i>eUsagePolicyType</i>
///               contains <b>DRM_USAGEPOLICY_TYPE_BYDIGEST</b>. It is ignored for all other <i>eUsagePolicyType</i> values.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMSetUsagePolicy(uint hIssuanceLicense, DRM_USAGEPOLICY_TYPE eUsagePolicyType, BOOL fDelete, 
                          BOOL fExclusion, PWSTR wszName, PWSTR wszMinVersion, PWSTR wszMaxVersion, 
                          PWSTR wszPublicKey, PWSTR wszDigestAlgorithm, ubyte* pbDigest, uint cbDigest);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMSetRevocationPoint</b> function
///sets a refresh rate and location to obtain a revocation list.
///Params:
///    hIssuanceLicense = A handle to an issuance license.
///    fDelete = Flag indicating whether the existing item should be deleted: <b>TRUE</b> indicates it should be deleted;
///              <b>FALSE</b> indicates it should be added.
///    wszId = ID of the revocation authority posting the revocation list. This must match the ID given in the <b>ISSUER</b>
///            node of the revocation list.
///    wszIdType = Type of ID used by <i>wszId</i>.
///    wszURL = URL of revocation file list.
///    pstFrequency = How often the list must be updated.
///    wszName = Optional human-readable name for a revocation list site.
///    wszPublicKey = Public key of key pair used to sign and verify the revocation list.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMSetRevocationPoint(uint hIssuanceLicense, BOOL fDelete, PWSTR wszId, PWSTR wszIdType, PWSTR wszURL, 
                              SYSTEMTIME* pstFrequency, PWSTR wszName, PWSTR wszPublicKey);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMSetApplicationSpecificData</b>
///function allows an issuance license to store arbitrary name-value pairs for use by the content-consuming application.
///Params:
///    hIssuanceLicense = A handle to an issuance license.
///    fDelete = A flag that indicates whether to add or delete this name-value pair. <b>FALSE</b> indicates add; <b>TRUE</b>
///              indicates delete.
///    wszName = The name of the data.
///    wszValue = The value of the data.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMSetApplicationSpecificData(uint hIssuanceLicense, BOOL fDelete, PWSTR wszName, PWSTR wszValue);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMSetNameAndDescription</b> function
///allows an application to specify names and descriptions of the license in multiple (human) languages.
///Params:
///    hIssuanceLicense = A handle to an issuance license.
///    fDelete = Flag indicating whether the existing item should be deleted: <b>TRUE</b> indicates it should be deleted;
///              <b>FALSE</b> indicates it should be added.
///    lcid = A locale ID for this name and description. If <i>lcid</i> is given as <b>NULL</b> or zero, the name and
///           description given become the default license name and description. There may be only one name and description for
///           any LCID (locale identifier).
///    wszName = A license name, in the language specified by this locale.
///    wszDescription = An optional license description, in the language specified by this locale.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMSetNameAndDescription(uint hIssuanceLicense, BOOL fDelete, uint lcid, PWSTR wszName, 
                                 PWSTR wszDescription);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMSetIntervalTime</b> function
///specifies the number of days from issuance that can pass before an end–user license must be renewed. This value is
///specified in an issuance license.
///Params:
///    hIssuanceLicense = The handle of the issuance license in which to set the interval time.
///    cDays = An unsigned integer value that specifies the interval period, in days. For example, if you specify 30, the
///            end–user license must be renewed within 30 days of the day it was issued.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMSetIntervalTime(uint hIssuanceLicense, uint cDays);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetIssuanceLicenseTemplate</b>
///function obtains an issuance license template from an existing issuance license.
///Params:
///    hIssuanceLicense = The handle of the issuance license to create a template from.
///    puIssuanceLicenseTemplateLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the
///                                      <i>wszIssuanceLicenseTemplate</i> buffer. This length must include the terminating null character. After the
///                                      function returns, this value contains the number of characters, including the terminating null character, that
///                                      were copied to the <i>wszIssuanceLicenseTemplate</i> buffer.
///    wszIssuanceLicenseTemplate = A pointer to a null-terminated Unicode string that receives the issuance license template XrML. The size of this
///                                 buffer is specified by the <i>puIssuanceLicenseTemplateLength</i> parameter. To determine the required size of
///                                 this buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///                                 terminating null character, in the <i>puIssuanceLicenseTemplateLength</i> value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetIssuanceLicenseTemplate(uint hIssuanceLicense, uint* puIssuanceLicenseTemplateLength, 
                                      PWSTR wszIssuanceLicenseTemplate);

///> [!NOTE] > The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for use in
///Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It may be
///altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK 2.1,
///which leverages functionality exposed by the client in Msipc.dll. The <b>DRMGetSignedIssuanceLicense</b> function
///acquires a signed issuance license online or offline, or produces an unsigned issuance license that can be signed
///later.
///Params:
///    hEnv = A handle to a secure environment created by using the DRMInitEnvironment function. The handle is required for
///           offline signing and optional for online signing. Applications that do not use a lockbox should pass <b>NULL</b>
///           for this parameter.
///    hIssuanceLicense = A handle to an issuance license to sign, created by using the DRMCreateIssuanceLicense function.
///    uFlags = Contains various options for acquiring the signed issuance license. This parameter can be one of the following
///             values (although <b>DRM_AUTO_GENERATE_KEY</b> and <b>DRM_OWNER_LICENSE_NOPERSIST</b> can be combined with other
///             flags). If <b>DRM_AUTO_GENERATE_KEY</b> is not specified, you must provide your own content key with a
///             cryptographic system, such as the CryptoAPI functions.
///    pbSymKey = The content key used to encrypt the document. If this value is <b>NULL</b>, the <i>uFlags</i> parameter must
///               specify <b>DRM_AUTO_GENERATE_KEY</b> or <b>DRM_REUSE_KEY</b>. These <i>uFlags</i> values cause <i>pbSymKey</i> to
///               be ignored.
///    cbSymKey = The size, in bytes, of the content key. Currently, this parameter can only be 16 unless the <i>uFlags</i>
///               parameter specifies <b>DRM_AUTO_GENERATE_KEY</b> or <b>DRM_REUSE_KEY</b>, in which case this parameter can be
///               zero.
///    wszSymKeyType = The key type. The value <b>AES</b> specifies the Advanced Encryption Standard (AES) algorithm with the electronic
///                    code book (ECB) cipher mode. If you are using Windows 7, the value <b>AES_CBC4K</b> can be used to specify the
///                    AES algorithm with cipher-block chaining (CBC) cipher mode. See the DRMEncrypt code examples for more
///                    information.
///    wszClientLicensorCertificate = A pointer to null-terminated Unicode string that contains a client licensor certificate obtained by using the
///                                   DRMAcquireLicense function. If you are attempting online signing, this parameter should be <b>NULL</b>. If you
///                                   are developing a server application that does not use a lockbox and if you are using the
///                                   <b>DRM_SERVER_ISSUANCELICENSE</b> flag in <i>uFlags</i>, pass in the server license certificate chain. The server
///                                   licensor certificate chain can be retrieved by using the GetLicensorCertificate SOAP method; however, to make the
///                                   chain usable, it must be reordered by using the DRMConstructCertificateChain function.
///    pfnCallback = A pointer to the callback function used to notify the application of an asynchronous request's progress. For the
///                  signature of the callback function you must provide, see Callback Prototype.
///    wszURL = A pointer to a null-terminated Unicode string that contains the URL of an AD RMS licensing server that was
///             obtained by using the DRMGetServiceLocation function. This string takes the form
///             "<i>ADRMSLicensingServerURL</i>/_wmcs/Licensing". This parameter value is required for online license requests;
///             you can use <b>NULL</b> for offline license requests. This URL is entered in the signed issuance license as the
///             default silent license acquisition URL, which is where an application will automatically go to acquire an
///             end-user license if none is specified in DRMAcquireLicense.
///    pvContext = A 32-bit, application-defined value that is sent in the <i>pvContext</i> parameter of the callback function. This
///                value can be a pointer to data, a pointer to an event handle, or whatever else the custom callback function is
///                designed to handle. For more information, see Creating a Callback Function.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetSignedIssuanceLicense(uint hEnv, uint hIssuanceLicense, uint uFlags, ubyte* pbSymKey, uint cbSymKey, 
                                    PWSTR wszSymKeyType, PWSTR wszClientLicensorCertificate, DRMCALLBACK pfnCallback, 
                                    PWSTR wszURL, void* pvContext);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetSignedIssuanceLicenseEx</b>
///function acquires a signed issuance license offline. When you call the function, you can pass in the handle to a
///client licensor certificate (CLC) and the handle to a rights account certificate (RAC), therefore specifying the CLC
///and the RAC to use when acquiring the signed issuance license.
///Params:
///    hEnv = A handle to a secure environment created by using the DRMInitEnvironment function. The handle is required for
///           offline signing. Applications that do not use a lockbox should pass <b>NULL</b> for this parameter.
///    hIssuanceLicense = A handle to an issuance license to sign, created by using the DRMCreateIssuanceLicense function.
///    uFlags = Contains various options for acquiring the signed issuance license. This parameter can be one of the following
///             values (although <b>DRM_AUTO_GENERATE_KEY</b> and <b>DRM_OWNER_LICENSE_NOPERSIST</b> can be combined with other
///             flags). If <b>DRM_AUTO_GENERATE_KEY</b> is not specified, you must provide your own content key with a
///             cryptographic system, such as the CryptoAPI functions from the Platform SDK.
///    pbSymKey = The content key used to encrypt the document. If this value is <b>NULL</b>, the <i>uFlags</i> parameter must
///               specify <b>DRM_AUTO_GENERATE_KEY</b> or <b>DRM_REUSE_KEY</b>. These <i>uFlags</i> values cause <i>pbSymKey</i> to
///               be ignored.
///    cbSymKey = The size, in bytes, of the content key. Currently, this parameter can only be 16 unless the <i>uFlags</i>
///               parameter specifies <b>DRM_AUTO_GENERATE_KEY</b> or <b>DRM_REUSE_KEY</b>, in which case this parameter can be
///               zero.
///    wszSymKeyType = The key type. The value <b>AES</b> specifies the Advanced Encryption Standard (AES) algorithm with the electronic
///                    code book (ECB) cipher mode. If you are using Windows 7, the value <b>AES_CBC4K</b> can be used to specify the
///                    AES algorithm with cipher-block chaining (CBC) cipher mode. See the DRMEncrypt code examples for more
///                    information.
///    pvReserved = Reserved for future use.
///    hEnablingPrincipal = A handle to an enabling principal in the end-user license that should be bound. Create this handle by using the
///                         DRMCreateEnablingPrincipal function by passing in the rights account certificate. This parameter is required.
///    hBoundLicenseCLC = A handle to the bound license corresponding to the client licensor certificate created using
///                       DRMCreateBoundLicense. This can be created by binding the <i>wszClientLicensorCertificate</i> to the <b>ISSUE</b>
///                       right using the <i>hEnablingPrincipal</i> handle. This parameter is required.
///    pfnCallback = A pointer to the callback function used to notify the application of an asynchronous request's progress. For the
///                  signature of the callback function you must provide, see Callback Prototype.
///    pvContext = A 32-bit, application-defined value that is sent in the <i>pvContext</i> parameter of the callback function. This
///                value can be a pointer to data, a pointer to an event handle, or whatever else the custom callback function is
///                designed to handle. For more information, see Creating a Callback Function.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetSignedIssuanceLicenseEx(uint hEnv, uint hIssuanceLicense, uint uFlags, ubyte* pbSymKey, 
                                      uint cbSymKey, PWSTR wszSymKeyType, void* pvReserved, uint hEnablingPrincipal, 
                                      uint hBoundLicenseCLC, DRMCALLBACK pfnCallback, void* pvContext);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMClosePubHandle</b> function closes
///a previously created <b>DRMPUBHANDLE</b>.
///Params:
///    hPub = A handle to a publishing object.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMClosePubHandle(uint hPub);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMDuplicatePubHandle</b> function
///makes a copy of a <b>DRMPUBHANDLE</b>.
///Params:
///    hPubIn = The <b>DRMPUBHANDLE</b> to make a copy of.
///    phPubOut = A pointer to a <b>DRMPUBHANDLE</b> value that receives the duplicate handle. When this handle is no longer
///               needed, release it by passing it to the DRMClosePubHandle function.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMDuplicatePubHandle(uint hPubIn, uint* phPubOut);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUserInfo</b> function obtains
///information about a user.
///Params:
///    hUser = The handle of the user to obtain information for.
///    puUserNameLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszUserName</i>
///                       buffer. This length must include the terminating null character. After the function returns, this value contains
///                       the number of characters, including the terminating null character, that were copied to the <i>wszUserName</i>
///                       buffer.
///    wszUserName = A pointer to a null-terminated Unicode string that receives the user name as a fully qualified SMTP email
///                  address. This is not enforced or used to check identities; it is only included to provide a human-readable
///                  identification. The size of this buffer is specified by the <i>puUserNameLength</i> parameter. To determine the
///                  required size of this buffer, pass <b>NULL</b> for this parameter. The function will place the size, in
///                  characters, including the terminating null character, in the <i>puUserNameLength</i> value.
///    puUserIdLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszUserId</i>
///                     buffer. This length must include the terminating null character. After the function returns, this value contains
///                     the number of characters, including the terminating null character, that were copied to the <i>wszUserId</i>
///                     buffer.
///    wszUserId = A pointer to a null-terminated Unicode string that receives the user's ID. The size of this buffer is specified
///                by the <i>puUserIdLength</i> parameter. To determine the required size of this buffer, pass <b>NULL</b> for this
///                parameter. The function will place the size, in characters, including the terminating null character, in the
///                <i>puUserIdLength</i> value.
///    puUserIdTypeLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszUserIdType</i>
///                         buffer. This length must include the terminating null character. After the function returns, this value contains
///                         the number of characters, including the terminating null character, that were copied to the <i>wszUserIdType</i>
///                         buffer.
///    wszUserIdType = A pointer to a null-terminated Unicode string that receives the type of ID used to identify the user (such as
///                    Passport, Windows, or other). The size of this buffer is specified by the <i>puUserIdTypeLength</i> parameter. To
///                    determine the required size of this buffer, pass <b>NULL</b> for this parameter. The function will place the
///                    size, in characters, including the terminating null character, in the <i>puUserIdTypeLength</i> value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUserInfo(uint hUser, uint* puUserNameLength, PWSTR wszUserName, uint* puUserIdLength, 
                       PWSTR wszUserId, uint* puUserIdTypeLength, PWSTR wszUserIdType);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetRightInfo</b> function obtains
///information about a previously created right.
///Params:
///    hRight = The handle of the right to retrieve information from.
///    puRightNameLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszRightName</i>
///                        buffer. This length must include the terminating null character. After the function returns, this value contains
///                        the number of characters, including the terminating null character, that were copied to the <i>wszRightName</i>
///                        buffer.
///    wszRightName = A pointer to a null-terminated Unicode string that receives the name of the right. The size of this buffer is
///                   specified by the <i>puRightNameLength</i> parameter. If this information is not required, set this parameter to
///                   <b>NULL</b>. To determine the required size of this buffer, pass <b>NULL</b> for this parameter. The function
///                   will place the size, in characters, including the terminating null character, in the <i>puRightNameLength</i>
///                   value.
///    pstFrom = A pointer to a SYSTEMTIME structure that receives the starting validity time, in UTC time, of the right. If this
///              information is not required, set this parameter to <b>NULL</b>.
///    pstUntil = A pointer to a SYSTEMTIME structure that receives the ending validity time, in UTC time, of the right. If this
///               information is not required, set this parameter to <b>NULL</b>.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetRightInfo(uint hRight, uint* puRightNameLength, PWSTR wszRightName, SYSTEMTIME* pstFrom, 
                        SYSTEMTIME* pstUntil);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetRightExtendedInfo</b> function
///retrieves custom name-value pairs attached to a right.
///Params:
///    hRight = The handle of the right to retrieve information from.
///    uIndex = The zero-based index of the name-value pair to retrieve.
///    puExtendedInfoNameLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the
///                               <i>wszExtendedInfoName</i> buffer. This length must include the terminating null character. After the function
///                               returns, this value contains the number of characters, including the terminating null character, that were copied
///                               to the <i>wszExtendedInfoName</i> buffer.
///    wszExtendedInfoName = A pointer to a null-terminated Unicode string that receives the name of the item. The size of this buffer is
///                          specified by the <i>puExtendedInfoNameLength</i> parameter. To determine the required size of this buffer, pass
///                          <b>NULL</b> for this parameter. The function will place the size, in characters, including the terminating null
///                          character, in the <i>puExtendedInfoNameLength</i> value.
///    puExtendedInfoValueLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the
///                                <i>wszExtendedInfoValue</i> buffer. This length must include the terminating null character. After the function
///                                returns, this value contains the number of characters, including the terminating null character, that were copied
///                                to the <i>wszExtendedInfoValue</i> buffer.
///    wszExtendedInfoValue = A pointer to a null-terminated Unicode string that receives the value associated with the name. The size of this
///                           buffer is specified by the <i>puExtendedInfoValueLength</i> parameter. To determine the required size of this
///                           buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///                           terminating null character, in the <i>puExtendedInfoValueLength</i> value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetRightExtendedInfo(uint hRight, uint uIndex, uint* puExtendedInfoNameLength, 
                                PWSTR wszExtendedInfoName, uint* puExtendedInfoValueLength, 
                                PWSTR wszExtendedInfoValue);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUsers</b> function retrieves a
///specific user from an issuance license.
///Params:
///    hIssuanceLicense = The handle of the issuance license to retrieve the user from.
///    uIndex = The zero-based index of the user in the issuance license to retrieve. To enumerate all the users in the issuance
///             license, create a loop starting at zero and incrementing by one. When the function returns
///             <b>E_DRM_NO_MORE_DATA</b>, there are no more users in the issuance license.
///    phUser = A pointer to a <b>DRMPUBHANDLE</b> value that receives the handle to the requested user. Call DRMClosePubHandle
///             to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUsers(uint hIssuanceLicense, uint uIndex, uint* phUser);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUserRights</b> function
///retrieves user/right pairs from an issuance license.
///Params:
///    hIssuanceLicense = The handle of the issuance license to retrieve the user rights from.
///    hUser = The handle of a user in the issuance license to retrieve the rights for.
///    uIndex = The zero-based index that indicates which right to retrieve for the specified user. To enumerate all the rights
///             assigned to a user in the issuance license, create a loop starting at zero and incrementing by one. When the
///             function returns <b>E_DRM_NO_MORE_DATA</b>, there are no more rights assigned to that user.
///    phRight = A pointer to a <b>DRMPUBHANDLE</b> value that receives the handle to the requested right. Call DRMClosePubHandle
///              to close the handle.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUserRights(uint hIssuanceLicense, uint hUser, uint uIndex, uint* phRight);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetMetaData</b> function retrieves
///metadata from an issuance license.
///Params:
///    hIssuanceLicense = A handle to the issuance license to get the metadata from.
///    puContentIdLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszContentId</i>
///                        buffer (required). This length must include the terminating null character. After the function returns, this
///                        value contains the number of characters, including the terminating null character, that were copied to the
///                        <i>wszContentId</i> buffer.
///    wszContentId = A pointer to a null-terminated Unicode string that receives the GUID that identifies the content. The size of
///                   this buffer is specified by the <i>puContentIdLength</i> parameter. To determine the required size of this
///                   buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///                   terminating null character, in the <i>puContentIdLength</i> value.
///    puContentIdTypeLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the
///                            <i>wszContentIdType</i> buffer (required). This length must include the terminating null character. After the
///                            function returns, this value contains the number of characters, including the terminating null character, that
///                            were copied to the <i>wszContentIdType</i> buffer.
///    wszContentIdType = A pointer to a null-terminated Unicode string that receives the type of GUID used to identify the content. The
///                       size of this buffer is specified by the <i>puContentIdTypeLength</i> parameter. To determine the required size of
///                       this buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///                       terminating null character, in the <i>puContentIdTypeLength</i> value.
///    puSKUIdLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszSKUId</i>
///                    buffer. This length must include the terminating null character. After the function returns, this value contains
///                    the number of characters, including the terminating null character, that were copied to the <i>wszSKUId</i>
///                    buffer.
///    wszSKUId = A pointer to a null-terminated Unicode string that receives the GUID that identifies the SKU of the content. The
///               size of this buffer is specified by the <i>puSKUIdLength</i> parameter. To determine the required size of this
///               buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///               terminating null character, in the <i>puSKUIdLength</i> value.
///    puSKUIdTypeLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszSKUIdType</i>
///                        buffer. This length must include the terminating null character. After the function returns, this value contains
///                        the number of characters, including the terminating null character, that were copied to the <i>wszSKUIdType</i>
///                        buffer.
///    wszSKUIdType = A pointer to a null-terminated Unicode string that receives the type of SKU ID used to identify content. The size
///                   of this buffer is specified by the <i>puSKUIdTypeLength</i> parameter. To determine the required size of this
///                   buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///                   terminating null character, in the <i>puSKUIdTypeLength</i> value.
///    puContentTypeLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszContentType</i>
///                          buffer. This length must include the terminating null character. After the function returns, this value contains
///                          the number of characters, including the terminating null character, that were copied to the <i>wszContentType</i>
///                          buffer.
///    wszContentType = A pointer to a null-terminated Unicode string that receives the Multipurpose Internet Mail Extensions (MIME) type
///                     of the content. The size of this buffer is specified by the <i>puContentTypeLength</i> parameter. To determine
///                     the required size of this buffer, pass <b>NULL</b> for this parameter. The function will place the size, in
///                     characters, including the terminating null character, in the <i>puContentTypeLength</i> value.
///    puContentNameLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszContentName</i>
///                          buffer. This length must include the terminating null character. After the function returns, this value contains
///                          the number of characters, including the terminating null character, that were copied to the <i>wszContentName</i>
///                          buffer.
///    wszContentName = A pointer to a null-terminated Unicode string that receives the name of the content. The size of this buffer is
///                     specified by the <i>puContentNameLength</i> parameter. To determine the required size of this buffer, pass
///                     <b>NULL</b> for this parameter. The function will place the size, in characters, including the terminating null
///                     character, in the <i>puContentNameLength</i> value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetMetaData(uint hIssuanceLicense, uint* puContentIdLength, PWSTR wszContentId, 
                       uint* puContentIdTypeLength, PWSTR wszContentIdType, uint* puSKUIdLength, PWSTR wszSKUId, 
                       uint* puSKUIdTypeLength, PWSTR wszSKUIdType, uint* puContentTypeLength, PWSTR wszContentType, 
                       uint* puContentNameLength, PWSTR wszContentName);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetApplicationSpecificData</b>
///function retrieves a name-value pair of arbitrary application-specific information.
///Params:
///    hIssuanceLicense = A handle to the issuance license to obtain the data from.
///    uIndex = The zero-based index of the name-value pair in the array of stored name-value pairs to retrieve.
///    puNameLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszName</i>
///                   buffer. This length must include the terminating null character. After the function returns, this value contains
///                   the number of characters, including the terminating null character, that were copied to the <i>wszName</i>
///                   buffer.
///    wszName = A pointer to a Unicode character buffer that receives the name portion of the name-value pair. The size of this
///              buffer is specified by the <i>puNameLength</i> parameter. To determine the required size of this buffer, pass
///              <b>NULL</b> for this parameter. The function will place the size, in characters, including the terminating null
///              character, in the <i>puNameLength</i> value.
///    puValueLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszValue</i>
///                    buffer. This length must include the terminating null character. After the function returns, this value contains
///                    the number of characters, including the terminating null character, that were copied to the <i>wszValue</i>
///                    buffer.
///    wszValue = A pointer to a Unicode character buffer that receives the value portion of the name-value pair. The size of this
///               buffer is specified by the <i>puValueLength</i> parameter. To determine the required size of this buffer, pass
///               <b>NULL</b> for this parameter. The function will place the size, in characters, including the terminating null
///               character, in the <i>puValueLength</i> value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetApplicationSpecificData(uint hIssuanceLicense, uint uIndex, uint* puNameLength, PWSTR wszName, 
                                      uint* puValueLength, PWSTR wszValue);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetIssuanceLicenseInfo</b> function
///retrieves various information from an issuance license.
///Params:
///    hIssuanceLicense = A handle to the issuance license to retrieve information from.
///    pstTimeFrom = A pointer to a SYSTEMTIME structure that receives the starting validity time, in UTC time, of the license. If
///                  this information is not required, set this parameter to <b>NULL</b>.
///    pstTimeUntil = A pointer to a SYSTEMTIME structure that receives the ending validity time, in UTC time, of the license. If this
///                   information is not required, set this parameter to <b>NULL</b>.
///    uFlags = A value of the DRM_DISTRIBUTION_POINT_INFO enumeration that specifies the type of service provided by this
///             distribution point (such as publishing or license acquisition). Only one flag can be used.
///    puDistributionPointNameLength = A pointer to a UINT value that, on entry, contains the length, in characters, of the
///                                    <i>wszDistributionPointName</i> buffer. This size must include the terminating null character. After the function
///                                    returns, this value contains the number of characters, including the terminating null character, that were copied
///                                    to the <i>wszDistributionPointName</i> buffer. If the <i>wszDistributionPointName</i> string is not required, set
///                                    this parameter to <b>NULL</b>.
///    wszDistributionPointName = A pointer to a null-terminated Unicode string that receives the name of a website that can distribute end-user
///                               licenses. The size of this buffer is specified by the <i>puDistributionPointNameLength</i> parameter. To
///                               determine the required size of this buffer, pass <b>NULL</b> for this parameter. The function will place the
///                               size, in characters, including the terminating null character, in the <i>puDistributionPointNameLength</i> value.
///    puDistributionPointURLLength = A pointer to a UINT value that, on entry, contains the length, in characters, of the
///                                   <i>wszDistributionPointURL</i> buffer. This size must include the terminating null character. After the function
///                                   returns, this value contains the number of characters, including the terminating null character, that were copied
///                                   to the <i>wszDistributionPointURL</i> buffer. If the <i>wszDistributionPointURL</i> string is not required, set
///                                   this parameter to <b>NULL</b>.
///    wszDistributionPointURL = A pointer to a null-terminated Unicode string that receives the URL of a website that can distribute end-user
///                              licenses. The size of this buffer is specified by the <i>puDistributionPointURLLength</i> parameter. To determine
///                              the required size of this buffer, pass <b>NULL</b> for this parameter. The function will place the size, in
///                              characters, including the terminating null character, in the <i>puDistributionPointURLLength</i> value.
///    phOwner = A pointer to a <b>DRMPUBHANDLE</b> value that receives the handle of the issuance license owner. If this
///              information is not required, set this parameter to <b>NULL</b>. Call DRMClosePubHandle to close the handle.
///    pfOfficial = A pointer to a Boolean value that specifies whether the issuance license is based on an official template. A
///                 nonzero value indicates that the license is based on an official template. Official templates are created and
///                 signed by the AD RMS server. Unofficial templates are created by the client from scratch or by adapting an
///                 official template. If this information is not required, set this parameter to <b>NULL</b>. For more information,
///                 see Creating a License From a Template.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetIssuanceLicenseInfo(uint hIssuanceLicense, SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, 
                                  uint uFlags, uint* puDistributionPointNameLength, PWSTR wszDistributionPointName, 
                                  uint* puDistributionPointURLLength, PWSTR wszDistributionPointURL, uint* phOwner, 
                                  BOOL* pfOfficial);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetRevocationPoint</b> function
///retrieves information about the revocation point for an issuance license.
///Params:
///    hIssuanceLicense = A handle to the issuance license to get the information from.
///    puIdLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszId</i> buffer.
///                 This length must include the terminating null character. After the function returns, this value contains the
///                 number of characters, including the terminating null character, that were copied to the <i>wszId</i> buffer.
///    wszId = A pointer to a null-terminated Unicode string that receives the GUID that identifies the revocation point. The
///            size of this buffer is specified by the <i>puIdLength</i> parameter. To determine the required size of this
///            buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///            terminating null character, in the <i>puIdLength</i> value.
///    puIdTypeLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszIdType</i>
///                     buffer. This length must include the terminating null character. After the function returns, this value contains
///                     the number of characters, including the terminating null character, that were copied to the <i>wszIdType</i>
///                     buffer.
///    wszIdType = A pointer to a null-terminated Unicode string that receives the type of the revocation point identifier. The size
///                of this buffer is specified by the <i>puIdTypeLength</i> parameter. To determine the required size of this
///                buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///                terminating null character, in the <i>puIdTypeLength</i> value.
///    puURLLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszURL</i> buffer.
///                  This length must include the terminating null character. After the function returns, this value contains the
///                  number of characters, including the terminating null character, that were copied to the <i>wszURL</i> buffer.
///    wszRL = A pointer to a null-terminated Unicode string that receives the URL where a revocation list can be obtained. The
///            size of this buffer is specified by the <i>puURLLength</i> parameter. To determine the required size of this
///            buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///            terminating null character, in the <i>puURLLength</i> value.
///    pstFrequency = A pointer to a SYSTEMTIME structure that receives the frequency that the revocation list must be refreshed. This
///                   parameter is required and cannot be <b>NULL</b>.
///    puNameLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszName</i>
///                   buffer. This length must include the terminating null character. After the function returns, this value contains
///                   the number of characters, including the terminating null character, that were copied to the <i>wszName</i>
///                   buffer.
///    wszName = A pointer to a null-terminated Unicode string that receives the human-readable name for the revocation location.
///              The size of this buffer is specified by the <i>puNameLength</i> parameter. To determine the required size of this
///              buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///              terminating null character, in the <i>puNameLength</i> value.
///    puPublicKeyLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszPublicKey</i>
///                        buffer. This length must include the terminating null character. After the function returns, this value contains
///                        the number of characters, including the terminating null character, that were copied to the <i>wszPublicKey</i>
///                        buffer.
///    wszPublicKey = A pointer to a null-terminated Unicode string that receives the optional public key to identify a revocation list
///                   outside the content's chain of trust. The size of this buffer is specified by the <i>puPublicKeyLength</i>
///                   parameter. To determine the required size of this buffer, pass <b>NULL</b> for this parameter. The function will
///                   place the size, in characters, including the terminating null character, in the <i>puPublicKeyLength</i> value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetRevocationPoint(uint hIssuanceLicense, uint* puIdLength, PWSTR wszId, uint* puIdTypeLength, 
                              PWSTR wszIdType, uint* puURLLength, PWSTR wszRL, SYSTEMTIME* pstFrequency, 
                              uint* puNameLength, PWSTR wszName, uint* puPublicKeyLength, PWSTR wszPublicKey);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetUsagePolicy</b> function gets a
///usage policy that requires, or denies, access to content based on application name, version, or other application
///characteristics.
///Params:
///    hIssuanceLicense = The handle of the issuance license that the usage policy is contained in.
///    uIndex = The zero-based index of the policy to retrieve.
///    peUsagePolicyType = A pointer to a DRM_USAGEPOLICY_TYPE value that receives one of the <b>DRM_USAGEPOLICY_TYPE</b> values that
///                        specifies the type of usage policy (name, public key, and so on). If a usage policy of type
///                        <b>DRM_USAGEPOLICY_TYPE_BYNAME</b> is chosen, then application versions between, and including, the minimum and
///                        maximum versions specified in <i>wszMinVersion</i> and <i>wszMaxVersion</i>, respectively, will be included or
///                        excluded.
///    pfExclusion = A pointer to a <b>BOOL</b> value that receives a value the specifies whether the policy is an exclusion policy.
///                  <b>TRUE</b> indicates that the application is prohibited from exercising the rights. <b>FALSE</b> indicates that
///                  the application is required to exercise the rights.
///    puNameLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszName</i>
///                   buffer. This length must include the terminating null character. After the function returns, this value contains
///                   the number of characters, including the terminating null character, that were copied to the <i>wszName</i>
///                   buffer.
///    wszName = A pointer to a null-terminated Unicode string that receives the name of the application required to exercise or
///              prohibited from exercising rights. The size of this buffer is specified by the <i>puNameLength</i> parameter. To
///              determine the required size of this buffer, pass <b>NULL</b> for this parameter. The function will place the
///              size, in characters, including the terminating null character, in the <i>puNameLength</i> value.
///    puMinVersionLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszMinVersion</i>
///                         buffer. This length must include the terminating null character. After the function returns, this value contains
///                         the number of characters, including the terminating null character, that were copied to the <i>wszMinVersion</i>
///                         buffer.
///    wszMinVersion = A pointer to a null-terminated Unicode string that receives the minimum version of the application required to
///                    exercise or prohibited from exercising rights. The size of this buffer is specified by the
///                    <i>puMinVersionLength</i> parameter. To determine the required size of this buffer, pass <b>NULL</b> for this
///                    parameter. The function will place the size, in characters, including the terminating null character, in the
///                    <i>puMinVersionLength</i> value. This will be a version string in a form similar to "1.0.1" or "1.00.0000".
///    puMaxVersionLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszMaxVersion</i>
///                         buffer. This length must include the terminating null character. After the function returns, this value contains
///                         the number of characters, including the terminating null character, that were copied to the <i>wszMaxVersion</i>
///                         buffer.
///    wszMaxVersion = A pointer to a null-terminated Unicode string that receives the maximum version of the application required to
///                    exercise or prohibited from exercising rights. The size of this buffer is specified by the
///                    <i>puMaxVersionLength</i> parameter. To determine the required size of this buffer, pass <b>NULL</b> for this
///                    parameter. The function will place the size, in characters, including the terminating null character, in the
///                    <i>puMaxVersionLength</i> value. This will be a version string in a form similar to "1.0.1" or "1.00.0000".
///    puPublicKeyLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the <i>wszPublicKey</i>
///                        buffer. This length must include the terminating null character. After the function returns, this value contains
///                        the number of characters, including the terminating null character, that were copied to the <i>wszPublicKey</i>
///                        buffer.
///    wszPublicKey = A pointer to a null-terminated Unicode string that receives the public key used to sign the digest of the
///                   application required to exercise or prohibited from exercising rights. The key is a well-formed XrML node. The
///                   size of this buffer is specified by the <i>puPublicKeyLength</i> parameter. To determine the required size of
///                   this buffer, pass <b>NULL</b> for this parameter. The function will place the size, in characters, including the
///                   terminating null character, in the <i>puPublicKeyLength</i> value.
///    puDigestAlgorithmLength = A pointer to a <b>UINT</b> value that, on entry, contains the length, in characters, of the
///                              <i>wszDigestAlgorithm</i> buffer. This length must include the terminating null character. After the function
///                              returns, this value contains the number of characters, including the terminating null character, that were copied
///                              to the <i>wszDigestAlgorithm</i> buffer.
///    wszDigestAlgorithm = A pointer to a null-terminated Unicode string that receives the algorithm used to create the application digest
///                         that was specified in <i>pbDigest</i>. The size of this buffer is specified by the <i>puDigestAlgorithmLength</i>
///                         parameter. To determine the required size of this buffer, pass <b>NULL</b> for this parameter. The function will
///                         place the size, in characters, including the terminating null character, in the <i>puDigestAlgorithmLength</i>
///                         value.
///    pcbDigest = A pointer to a <b>UINT</b> value that, on entry, contains the length, in bytes, of the <i>pbDigest</i> buffer.
///                After the function returns, this value contains the number of bytes copied to the <i>pbDigest</i> buffer.
///    pbDigest = A pointer to a buffer that receives the application digest that is required to exercise or prohibited from
///               exercising rights. The size of this buffer is specified by the <i>pcbDigest</i> parameter. To determine the
///               required size of this buffer, pass <b>NULL</b> for this parameter. The function will place the size, in bytes, in
///               the <i>pcbDigest</i> value.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetUsagePolicy(uint hIssuanceLicense, uint uIndex, DRM_USAGEPOLICY_TYPE* peUsagePolicyType, 
                          BOOL* pfExclusion, uint* puNameLength, PWSTR wszName, uint* puMinVersionLength, 
                          PWSTR wszMinVersion, uint* puMaxVersionLength, PWSTR wszMaxVersion, 
                          uint* puPublicKeyLength, PWSTR wszPublicKey, uint* puDigestAlgorithmLength, 
                          PWSTR wszDigestAlgorithm, uint* pcbDigest, ubyte* pbDigest);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetNameAndDescription</b> function
///retrieves a language specific name and description from an issuance license.
///Params:
///    hIssuanceLicense = A handle to the issuance license to get the information from.
///    uIndex = The zero-based index of the name and description pair to retrieve.
///    pulcid = A pointer to a <b>UINT</b> that receives the locale ID of the name and description pair.
///    puNameLength = A pointer to a <b>UINT</b> that, on input, contains the length, in characters, of the <i>wszName</i> buffer. This
///                   length must include the terminating null character. After the function returns, this <b>UINT</b> contains the
///                   number of characters, including the terminating null character, that were copied to the <i>wszName</i> buffer.
///    wszName = A pointer to a null-terminated Unicode string that receives the name. The size of this buffer is specified by the
///              <i>puNameLength</i> parameter. To determine the required size of this buffer, pass <b>NULL</b> for this
///              parameter. The function will place the size, in characters, including the terminating null character, in the
///              <i>puNameLength</i> parameter.
///    puDescriptionLength = A pointer to a <b>UINT</b> that, on input, contains the length, in characters, of the <i>wszDescription</i>
///                          buffer. This length must include the terminating null character. After the function returns, this <b>UINT</b>
///                          contains the number of characters, including the terminating null character, that were copied to the
///                          <i>wszDescription</i> buffer.
///    wszDescription = A pointer to a null-terminated Unicode string that receives the description. The size of this buffer is specified
///                     by the <i>puDescriptionLength</i> parameter. To determine the required size of this buffer, pass <b>NULL</b> for
///                     this parameter. The function will place the size, in characters, including the terminating null character, in the
///                     <i>puDescriptionLength</i> parameter.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetNameAndDescription(uint hIssuanceLicense, uint uIndex, uint* pulcid, uint* puNameLength, 
                                 PWSTR wszName, uint* puDescriptionLength, PWSTR wszDescription);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetOwnerLicense</b> function
///retrieves an owner license created by calling the DRMGetSignedIssuanceLicense.
///Params:
///    hIssuanceLicense = A handle to a signed issuance license.
///    puOwnerLicenseLength = An unsigned integer that contains the length, in characters, of the owner license retrieved by this function. The
///                           terminating null character is included in the length.
///    wszOwnerLicense = A null-terminated string that contains the owner license in XrML format. For example XrML owner license, see
///                      Owner License XML Example.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetOwnerLicense(uint hIssuanceLicense, uint* puOwnerLicenseLength, PWSTR wszOwnerLicense);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMGetIntervalTime</b> function
///retrieves the number of days from issuance that can pass before an end–user license must be renewed. This value is
///retrieved from an issuance license.
///Params:
///    hIssuanceLicense = The handle of the issuance license from which the interval time can be retrieved.
///    pcDays = A pointer to a <b>UINT</b> that specifies the interval period, in days. For example, if the value is 30, the
///             end–user license must be renewed within 30 days of the day it was issued.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMGetIntervalTime(uint hIssuanceLicense, uint* pcDays);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMRepair</b> function repairs a
///client machine by deleting certificates previously created for the machine or user.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. For a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMRepair();

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMRegisterProtectedWindow</b>
///function registers a window in the protected environment.
///Params:
///    hEnv = A handle to the secure environment.
///    hwnd = A handle to the window to be registered.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMRegisterProtectedWindow(uint hEnv, HWND hwnd);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMIsWindowProtected</b> function
///indicates whether a window is associated with a protected environment.
///Params:
///    hwnd = The window handle.
///    pfProtected = A pointer to a <b>BOOL</b> that indicates whether the window is associated with a protected environment.
///Returns:
///    If the function succeeds, the function returns S_OK. If the function fails, it returns an <b>HRESULT</b> value
///    that indicates the error. Possible values include, but are not limited to, those in the following list. For a
///    list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMIsWindowProtected(HWND hwnd, BOOL* pfProtected);

///<p class="CCE_Message">[The AD RMS SDK leveraging functionality exposed by the client in Msdrm.dll is available for
///use in Windows Server 2008, Windows Vista, Windows Server 2008 R2, Windows 7, Windows Server 2012, and Windows 8. It
///may be altered or unavailable in subsequent versions. Instead, use Active Directory Rights Management Services SDK
///2.1, which leverages functionality exposed by the client in Msipc.dll.] The <b>DRMAcquireIssuanceLicenseTemplate</b>
///function asynchronously retrieves issuance license templates from a server.
///Params:
///    hClient = A handle to a client session. The handle is obtained by calling the DRMCreateClientSession function. When you
///              call <b>DRMCreateClientSession</b>, you must specify a callback function that AD RMS can use to return the result
///              of an operation. A string that contains the templates is sent to the callback function in a
///              DRM_MSG_ACQUIRE_ISSUANCE_LICENSE_TEMPLATE message.
///    uFlags = Specifies options for the function call. This parameter can be a combination of one or more of the following
///             flags.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///    cTemplates = Reserved for future use. This value must be zero.
///    pwszTemplateIds = Reserved for future use. This parameter must be <b>NULL</b>.
///    wszUrl = A null-terminated Unicode string that contains the template acquisition URL. You can retrieve this value by
///             calling DRMGetServiceLocation and setting the <i>uServiceType</i> parameter to
///             <b>DRM_SERVICE_TYPE_CLIENTLICENSOR</b>.
///    pvContext = A 32-bit, application-defined value that is returned in the <i>pvContext</i> parameter of the callback function.
///                This value can be a pointer to data, a pointer to an event handle, or whatever else the custom callback function
///                is designed to handle. For more information, see Callback Prototype.
///Returns:
///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an <b>HRESULT</b>
///    value that indicates the error. Possible values include, but are not limited to, those in the following list. For
///    a list of common error codes, see Common HRESULT Values.
///    
@DllImport("msdrm")
HRESULT DRMAcquireIssuanceLicenseTemplate(uint hClient, uint uFlags, void* pvReserved, uint cTemplates, 
                                          PWSTR* pwszTemplateIds, PWSTR wszUrl, void* pvContext);


