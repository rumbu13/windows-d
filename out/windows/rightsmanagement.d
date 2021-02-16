module windows.rightsmanagement;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL, FARPROC;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    DRMTIMETYPE_SYSTEMUTC   = 0x00000000,
    DRMTIMETYPE_SYSTEMLOCAL = 0x00000001,
}
alias DRMTIMETYPE = int;

enum : int
{
    DRMENCODINGTYPE_BASE64 = 0x00000000,
    DRMENCODINGTYPE_STRING = 0x00000001,
    DRMENCODINGTYPE_LONG   = 0x00000002,
    DRMENCODINGTYPE_TIME   = 0x00000003,
    DRMENCODINGTYPE_UINT   = 0x00000004,
    DRMENCODINGTYPE_RAW    = 0x00000005,
}
alias DRMENCODINGTYPE = int;

enum : int
{
    DRMATTESTTYPE_FULLENVIRONMENT = 0x00000000,
    DRMATTESTTYPE_HASHONLY        = 0x00000001,
}
alias DRMATTESTTYPE = int;

enum : int
{
    DRMSPECTYPE_UNKNOWN  = 0x00000000,
    DRMSPECTYPE_FILENAME = 0x00000001,
}
alias DRMSPECTYPE = int;

enum : int
{
    DRMSECURITYPROVIDERTYPE_SOFTWARESECREP = 0x00000000,
}
alias DRMSECURITYPROVIDERTYPE = int;

enum : int
{
    DRMGLOBALOPTIONS_USE_WINHTTP                 = 0x00000000,
    DRMGLOBALOPTIONS_USE_SERVERSECURITYPROCESSOR = 0x00000001,
}
alias DRMGLOBALOPTIONS = int;

enum : int
{
    DRM_MSG_ACTIVATE_MACHINE                  = 0x00000000,
    DRM_MSG_ACTIVATE_GROUPIDENTITY            = 0x00000001,
    DRM_MSG_ACQUIRE_LICENSE                   = 0x00000002,
    DRM_MSG_ACQUIRE_ADVISORY                  = 0x00000003,
    DRM_MSG_SIGN_ISSUANCE_LICENSE             = 0x00000004,
    DRM_MSG_ACQUIRE_CLIENTLICENSOR            = 0x00000005,
    DRM_MSG_ACQUIRE_ISSUANCE_LICENSE_TEMPLATE = 0x00000006,
}
alias DRM_STATUS_MSG = int;

enum : int
{
    DRM_USAGEPOLICY_TYPE_BYNAME      = 0x00000000,
    DRM_USAGEPOLICY_TYPE_BYPUBLICKEY = 0x00000001,
    DRM_USAGEPOLICY_TYPE_BYDIGEST    = 0x00000002,
    DRM_USAGEPOLICY_TYPE_OSEXCLUSION = 0x00000003,
}
alias DRM_USAGEPOLICY_TYPE = int;

enum : int
{
    DRM_DISTRIBUTION_POINT_LICENSE_ACQUISITION = 0x00000000,
    DRM_DISTRIBUTION_POINT_PUBLISHING          = 0x00000001,
    DRM_DISTRIBUTION_POINT_REFERRAL_INFO       = 0x00000002,
}
alias DRM_DISTRIBUTION_POINT_INFO = int;

// Constants


enum uint DRMIDVERSION = 0x00000000;
enum uint DRMBINDINGFLAGS_IGNORE_VALIDITY_INTERVALS = 0x00000001;
enum uint DRMACTSERVINFOVERSION = 0x00000000;
enum uint DRMCALLBACKVERSION = 0x00000001;

// Callbacks

alias DRMCALLBACK = HRESULT function(DRM_STATUS_MSG param0, HRESULT param1, void* param2, void* param3);

// Structs


struct DRMID
{
    uint          uVersion;
    const(wchar)* wszIDType;
    const(wchar)* wszID;
}

struct DRMBOUNDLICENSEPARAMS
{
    uint          uVersion;
    uint          hEnablingPrincipal;
    uint          hSecureStore;
    const(wchar)* wszRightsRequested;
    const(wchar)* wszRightsGroup;
    DRMID         idResource;
    uint          cAuthenticatorCount;
    uint*         rghAuthenticators;
    const(wchar)* wszDefaultEnablingPrincipalCredentials;
    uint          dwFlags;
}

struct DRM_LICENSE_ACQ_DATA
{
    uint          uVersion;
    const(wchar)* wszURL;
    const(wchar)* wszLocalFilename;
    ubyte*        pbPostData;
    uint          dwPostDataSize;
    const(wchar)* wszFriendlyName;
}

struct DRM_ACTSERV_INFO
{
    uint          uVersion;
    const(wchar)* wszPubKey;
    const(wchar)* wszURL;
}

struct DRM_CLIENT_VERSION_INFO
{
    uint        uStructVersion;
    uint[4]     dwVersion;
    ushort[256] wszHierarchy;
    ushort[256] wszProductId;
    ushort[256] wszProductDescription;
}

// Functions

@DllImport("msdrm")
HRESULT DRMSetGlobalOptions(DRMGLOBALOPTIONS eGlobalOptions, void* pvdata, uint dwlen);

@DllImport("msdrm")
HRESULT DRMGetClientVersion(DRM_CLIENT_VERSION_INFO* pDRMClientVersionInfo);

@DllImport("msdrm")
HRESULT DRMInitEnvironment(DRMSECURITYPROVIDERTYPE eSecurityProviderType, DRMSPECTYPE eSpecification, 
                           const(wchar)* wszSecurityProvider, const(wchar)* wszManifestCredentials, 
                           const(wchar)* wszMachineCredentials, uint* phEnv, uint* phDefaultLibrary);

@DllImport("msdrm")
HRESULT DRMLoadLibrary(uint hEnv, DRMSPECTYPE eSpecification, const(wchar)* wszLibraryProvider, 
                       const(wchar)* wszCredentials, uint* phLibrary);

@DllImport("msdrm")
HRESULT DRMCreateEnablingPrincipal(uint hEnv, uint hLibrary, const(wchar)* wszObject, DRMID* pidPrincipal, 
                                   const(wchar)* wszCredentials, uint* phEnablingPrincipal);

@DllImport("msdrm")
HRESULT DRMCloseHandle(uint handle);

@DllImport("msdrm")
HRESULT DRMCloseEnvironmentHandle(uint hEnv);

@DllImport("msdrm")
HRESULT DRMDuplicateHandle(uint hToCopy, uint* phCopy);

@DllImport("msdrm")
HRESULT DRMDuplicateEnvironmentHandle(uint hToCopy, uint* phCopy);

@DllImport("msdrm")
HRESULT DRMRegisterRevocationList(uint hEnv, const(wchar)* wszRevocationList);

@DllImport("msdrm")
HRESULT DRMCheckSecurity(uint hEnv, uint cLevel);

@DllImport("msdrm")
HRESULT DRMRegisterContent(BOOL fRegister);

@DllImport("msdrm")
HRESULT DRMEncrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, 
                   ubyte* pbOutData);

@DllImport("msdrm")
HRESULT DRMDecrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, 
                   ubyte* pbOutData);

@DllImport("msdrm")
HRESULT DRMCreateBoundLicense(uint hEnv, DRMBOUNDLICENSEPARAMS* pParams, const(wchar)* wszLicenseChain, 
                              uint* phBoundLicense, uint* phErrorLog);

@DllImport("msdrm")
HRESULT DRMCreateEnablingBitsDecryptor(uint hBoundLicense, const(wchar)* wszRight, uint hAuxLib, 
                                       const(wchar)* wszAuxPlug, uint* phDecryptor);

@DllImport("msdrm")
HRESULT DRMCreateEnablingBitsEncryptor(uint hBoundLicense, const(wchar)* wszRight, uint hAuxLib, 
                                       const(wchar)* wszAuxPlug, uint* phEncryptor);

@DllImport("msdrm")
HRESULT DRMAttest(uint hEnablingPrincipal, const(wchar)* wszData, DRMATTESTTYPE eType, uint* pcAttestedBlob, 
                  const(wchar)* wszAttestedBlob);

@DllImport("msdrm")
HRESULT DRMGetTime(uint hEnv, DRMTIMETYPE eTimerIdType, SYSTEMTIME* poTimeObject);

@DllImport("msdrm")
HRESULT DRMGetInfo(uint handle, const(wchar)* wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, 
                   ubyte* pbBuffer);

@DllImport("msdrm")
HRESULT DRMGetEnvironmentInfo(uint handle, const(wchar)* wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, 
                              ubyte* pbBuffer);

@DllImport("msdrm")
HRESULT DRMGetProcAddress(uint hLibrary, const(wchar)* wszProcName, FARPROC* ppfnProcAddress);

@DllImport("msdrm")
HRESULT DRMGetBoundLicenseObjectCount(uint hQueryRoot, const(wchar)* wszSubObjectType, uint* pcSubObjects);

@DllImport("msdrm")
HRESULT DRMGetBoundLicenseObject(uint hQueryRoot, const(wchar)* wszSubObjectType, uint iWhich, uint* phSubObject);

@DllImport("msdrm")
HRESULT DRMGetBoundLicenseAttributeCount(uint hQueryRoot, const(wchar)* wszAttribute, uint* pcAttributes);

@DllImport("msdrm")
HRESULT DRMGetBoundLicenseAttribute(uint hQueryRoot, const(wchar)* wszAttribute, uint iWhich, 
                                    DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

@DllImport("msdrm")
HRESULT DRMCreateClientSession(DRMCALLBACK pfnCallback, uint uCallbackVersion, 
                               const(wchar)* wszGroupIDProviderType, const(wchar)* wszGroupID, uint* phClient);

@DllImport("msdrm")
HRESULT DRMIsActivated(uint hClient, uint uFlags, DRM_ACTSERV_INFO* pActServInfo);

@DllImport("msdrm")
HRESULT DRMActivate(uint hClient, uint uFlags, uint uLangID, DRM_ACTSERV_INFO* pActServInfo, void* pvContext, 
                    HWND hParentWnd);

@DllImport("msdrm")
HRESULT DRMGetServiceLocation(uint hClient, uint uServiceType, uint uServiceLocation, 
                              const(wchar)* wszIssuanceLicense, uint* puServiceURLLength, 
                              const(wchar)* wszServiceURL);

@DllImport("msdrm")
HRESULT DRMCreateLicenseStorageSession(uint hEnv, uint hDefaultLibrary, uint hClient, uint uFlags, 
                                       const(wchar)* wszIssuanceLicense, uint* phLicenseStorage);

@DllImport("msdrm")
HRESULT DRMAddLicense(uint hLicenseStorage, uint uFlags, const(wchar)* wszLicense);

@DllImport("msdrm")
HRESULT DRMAcquireAdvisories(uint hLicenseStorage, const(wchar)* wszLicense, const(wchar)* wszURL, void* pvContext);

@DllImport("msdrm")
HRESULT DRMEnumerateLicense(uint hSession, uint uFlags, uint uIndex, int* pfSharedFlag, uint* puCertificateDataLen, 
                            const(wchar)* wszCertificateData);

@DllImport("msdrm")
HRESULT DRMAcquireLicense(uint hSession, uint uFlags, const(wchar)* wszGroupIdentityCredential, 
                          const(wchar)* wszRequestedRights, const(wchar)* wszCustomData, const(wchar)* wszURL, 
                          void* pvContext);

@DllImport("msdrm")
HRESULT DRMDeleteLicense(uint hSession, const(wchar)* wszLicenseId);

@DllImport("msdrm")
HRESULT DRMCloseSession(uint hSession);

@DllImport("msdrm")
HRESULT DRMDuplicateSession(uint hSessionIn, uint* phSessionOut);

@DllImport("msdrm")
HRESULT DRMGetSecurityProvider(uint uFlags, uint* puTypeLen, const(wchar)* wszType, uint* puPathLen, 
                               const(wchar)* wszPath);

@DllImport("msdrm")
HRESULT DRMEncode(const(wchar)* wszAlgID, uint uDataLen, ubyte* pbDecodedData, uint* puEncodedStringLen, 
                  const(wchar)* wszEncodedString);

@DllImport("msdrm")
HRESULT DRMDecode(const(wchar)* wszAlgID, const(wchar)* wszEncodedString, uint* puDecodedDataLen, 
                  ubyte* pbDecodedData);

@DllImport("msdrm")
HRESULT DRMConstructCertificateChain(uint cCertificates, char* rgwszCertificates, uint* pcChain, 
                                     const(wchar)* wszChain);

@DllImport("msdrm")
HRESULT DRMParseUnboundLicense(const(wchar)* wszCertificate, uint* phQueryRoot);

@DllImport("msdrm")
HRESULT DRMCloseQueryHandle(uint hQuery);

@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseObjectCount(uint hQueryRoot, const(wchar)* wszSubObjectType, uint* pcSubObjects);

@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseObject(uint hQueryRoot, const(wchar)* wszSubObjectType, uint iIndex, uint* phSubQuery);

@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseAttributeCount(uint hQueryRoot, const(wchar)* wszAttributeType, uint* pcAttributes);

@DllImport("msdrm")
HRESULT DRMGetUnboundLicenseAttribute(uint hQueryRoot, const(wchar)* wszAttributeType, uint iWhich, 
                                      DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

@DllImport("msdrm")
HRESULT DRMGetCertificateChainCount(const(wchar)* wszChain, uint* pcCertCount);

@DllImport("msdrm")
HRESULT DRMDeconstructCertificateChain(const(wchar)* wszChain, uint iWhich, uint* pcCert, const(wchar)* wszCert);

@DllImport("msdrm")
HRESULT DRMVerify(const(wchar)* wszData, uint* pcAttestedData, const(wchar)* wszAttestedData, 
                  DRMATTESTTYPE* peType, uint* pcPrincipal, const(wchar)* wszPrincipal, uint* pcManifest, 
                  const(wchar)* wszManifest);

@DllImport("msdrm")
HRESULT DRMCreateUser(const(wchar)* wszUserName, const(wchar)* wszUserId, const(wchar)* wszUserIdType, 
                      uint* phUser);

@DllImport("msdrm")
HRESULT DRMCreateRight(const(wchar)* wszRightName, SYSTEMTIME* pstFrom, SYSTEMTIME* pstUntil, uint cExtendedInfo, 
                       char* pwszExtendedInfoName, char* pwszExtendedInfoValue, uint* phRight);

@DllImport("msdrm")
HRESULT DRMCreateIssuanceLicense(SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, 
                                 const(wchar)* wszReferralInfoName, const(wchar)* wszReferralInfoURL, uint hOwner, 
                                 const(wchar)* wszIssuanceLicense, uint hBoundLicense, uint* phIssuanceLicense);

@DllImport("msdrm")
HRESULT DRMAddRightWithUser(uint hIssuanceLicense, uint hRight, uint hUser);

@DllImport("msdrm")
HRESULT DRMClearAllRights(uint hIssuanceLicense);

@DllImport("msdrm")
HRESULT DRMSetMetaData(uint hIssuanceLicense, const(wchar)* wszContentId, const(wchar)* wszContentIdType, 
                       const(wchar)* wszSKUId, const(wchar)* wszSKUIdType, const(wchar)* wszContentType, 
                       const(wchar)* wszContentName);

@DllImport("msdrm")
HRESULT DRMSetUsagePolicy(uint hIssuanceLicense, DRM_USAGEPOLICY_TYPE eUsagePolicyType, BOOL fDelete, 
                          BOOL fExclusion, const(wchar)* wszName, const(wchar)* wszMinVersion, 
                          const(wchar)* wszMaxVersion, const(wchar)* wszPublicKey, const(wchar)* wszDigestAlgorithm, 
                          ubyte* pbDigest, uint cbDigest);

@DllImport("msdrm")
HRESULT DRMSetRevocationPoint(uint hIssuanceLicense, BOOL fDelete, const(wchar)* wszId, const(wchar)* wszIdType, 
                              const(wchar)* wszURL, SYSTEMTIME* pstFrequency, const(wchar)* wszName, 
                              const(wchar)* wszPublicKey);

@DllImport("msdrm")
HRESULT DRMSetApplicationSpecificData(uint hIssuanceLicense, BOOL fDelete, const(wchar)* wszName, 
                                      const(wchar)* wszValue);

@DllImport("msdrm")
HRESULT DRMSetNameAndDescription(uint hIssuanceLicense, BOOL fDelete, uint lcid, const(wchar)* wszName, 
                                 const(wchar)* wszDescription);

@DllImport("msdrm")
HRESULT DRMSetIntervalTime(uint hIssuanceLicense, uint cDays);

@DllImport("msdrm")
HRESULT DRMGetIssuanceLicenseTemplate(uint hIssuanceLicense, uint* puIssuanceLicenseTemplateLength, 
                                      const(wchar)* wszIssuanceLicenseTemplate);

@DllImport("msdrm")
HRESULT DRMGetSignedIssuanceLicense(uint hEnv, uint hIssuanceLicense, uint uFlags, ubyte* pbSymKey, uint cbSymKey, 
                                    const(wchar)* wszSymKeyType, const(wchar)* wszClientLicensorCertificate, 
                                    DRMCALLBACK pfnCallback, const(wchar)* wszURL, void* pvContext);

@DllImport("msdrm")
HRESULT DRMGetSignedIssuanceLicenseEx(uint hEnv, uint hIssuanceLicense, uint uFlags, char* pbSymKey, uint cbSymKey, 
                                      const(wchar)* wszSymKeyType, void* pvReserved, uint hEnablingPrincipal, 
                                      uint hBoundLicenseCLC, DRMCALLBACK pfnCallback, void* pvContext);

@DllImport("msdrm")
HRESULT DRMClosePubHandle(uint hPub);

@DllImport("msdrm")
HRESULT DRMDuplicatePubHandle(uint hPubIn, uint* phPubOut);

@DllImport("msdrm")
HRESULT DRMGetUserInfo(uint hUser, uint* puUserNameLength, const(wchar)* wszUserName, uint* puUserIdLength, 
                       const(wchar)* wszUserId, uint* puUserIdTypeLength, const(wchar)* wszUserIdType);

@DllImport("msdrm")
HRESULT DRMGetRightInfo(uint hRight, uint* puRightNameLength, const(wchar)* wszRightName, SYSTEMTIME* pstFrom, 
                        SYSTEMTIME* pstUntil);

@DllImport("msdrm")
HRESULT DRMGetRightExtendedInfo(uint hRight, uint uIndex, uint* puExtendedInfoNameLength, 
                                const(wchar)* wszExtendedInfoName, uint* puExtendedInfoValueLength, 
                                const(wchar)* wszExtendedInfoValue);

@DllImport("msdrm")
HRESULT DRMGetUsers(uint hIssuanceLicense, uint uIndex, uint* phUser);

@DllImport("msdrm")
HRESULT DRMGetUserRights(uint hIssuanceLicense, uint hUser, uint uIndex, uint* phRight);

@DllImport("msdrm")
HRESULT DRMGetMetaData(uint hIssuanceLicense, uint* puContentIdLength, const(wchar)* wszContentId, 
                       uint* puContentIdTypeLength, const(wchar)* wszContentIdType, uint* puSKUIdLength, 
                       const(wchar)* wszSKUId, uint* puSKUIdTypeLength, const(wchar)* wszSKUIdType, 
                       uint* puContentTypeLength, const(wchar)* wszContentType, uint* puContentNameLength, 
                       const(wchar)* wszContentName);

@DllImport("msdrm")
HRESULT DRMGetApplicationSpecificData(uint hIssuanceLicense, uint uIndex, uint* puNameLength, 
                                      const(wchar)* wszName, uint* puValueLength, const(wchar)* wszValue);

@DllImport("msdrm")
HRESULT DRMGetIssuanceLicenseInfo(uint hIssuanceLicense, SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, 
                                  uint uFlags, uint* puDistributionPointNameLength, 
                                  const(wchar)* wszDistributionPointName, uint* puDistributionPointURLLength, 
                                  const(wchar)* wszDistributionPointURL, uint* phOwner, int* pfOfficial);

@DllImport("msdrm")
HRESULT DRMGetRevocationPoint(uint hIssuanceLicense, uint* puIdLength, const(wchar)* wszId, uint* puIdTypeLength, 
                              const(wchar)* wszIdType, uint* puURLLength, const(wchar)* wszRL, 
                              SYSTEMTIME* pstFrequency, uint* puNameLength, const(wchar)* wszName, 
                              uint* puPublicKeyLength, const(wchar)* wszPublicKey);

@DllImport("msdrm")
HRESULT DRMGetUsagePolicy(uint hIssuanceLicense, uint uIndex, DRM_USAGEPOLICY_TYPE* peUsagePolicyType, 
                          int* pfExclusion, uint* puNameLength, const(wchar)* wszName, uint* puMinVersionLength, 
                          const(wchar)* wszMinVersion, uint* puMaxVersionLength, const(wchar)* wszMaxVersion, 
                          uint* puPublicKeyLength, const(wchar)* wszPublicKey, uint* puDigestAlgorithmLength, 
                          const(wchar)* wszDigestAlgorithm, uint* pcbDigest, ubyte* pbDigest);

@DllImport("msdrm")
HRESULT DRMGetNameAndDescription(uint hIssuanceLicense, uint uIndex, uint* pulcid, uint* puNameLength, 
                                 const(wchar)* wszName, uint* puDescriptionLength, const(wchar)* wszDescription);

@DllImport("msdrm")
HRESULT DRMGetOwnerLicense(uint hIssuanceLicense, uint* puOwnerLicenseLength, const(wchar)* wszOwnerLicense);

@DllImport("msdrm")
HRESULT DRMGetIntervalTime(uint hIssuanceLicense, uint* pcDays);

@DllImport("msdrm")
HRESULT DRMRepair();

@DllImport("msdrm")
HRESULT DRMRegisterProtectedWindow(uint hEnv, HWND hwnd);

@DllImport("msdrm")
HRESULT DRMIsWindowProtected(HWND hwnd, int* pfProtected);

@DllImport("msdrm")
HRESULT DRMAcquireIssuanceLicenseTemplate(uint hClient, uint uFlags, void* pvReserved, uint cTemplates, 
                                          char* pwszTemplateIds, const(wchar)* wszUrl, void* pvContext);


