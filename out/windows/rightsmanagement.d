module windows.rightsmanagement;

public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct DRMID
{
    uint uVersion;
    const(wchar)* wszIDType;
    const(wchar)* wszID;
}

enum DRMTIMETYPE
{
    DRMTIMETYPE_SYSTEMUTC = 0,
    DRMTIMETYPE_SYSTEMLOCAL = 1,
}

enum DRMENCODINGTYPE
{
    DRMENCODINGTYPE_BASE64 = 0,
    DRMENCODINGTYPE_STRING = 1,
    DRMENCODINGTYPE_LONG = 2,
    DRMENCODINGTYPE_TIME = 3,
    DRMENCODINGTYPE_UINT = 4,
    DRMENCODINGTYPE_RAW = 5,
}

enum DRMATTESTTYPE
{
    DRMATTESTTYPE_FULLENVIRONMENT = 0,
    DRMATTESTTYPE_HASHONLY = 1,
}

enum DRMSPECTYPE
{
    DRMSPECTYPE_UNKNOWN = 0,
    DRMSPECTYPE_FILENAME = 1,
}

enum DRMSECURITYPROVIDERTYPE
{
    DRMSECURITYPROVIDERTYPE_SOFTWARESECREP = 0,
}

enum DRMGLOBALOPTIONS
{
    DRMGLOBALOPTIONS_USE_WINHTTP = 0,
    DRMGLOBALOPTIONS_USE_SERVERSECURITYPROCESSOR = 1,
}

struct DRMBOUNDLICENSEPARAMS
{
    uint uVersion;
    uint hEnablingPrincipal;
    uint hSecureStore;
    const(wchar)* wszRightsRequested;
    const(wchar)* wszRightsGroup;
    DRMID idResource;
    uint cAuthenticatorCount;
    uint* rghAuthenticators;
    const(wchar)* wszDefaultEnablingPrincipalCredentials;
    uint dwFlags;
}

struct DRM_LICENSE_ACQ_DATA
{
    uint uVersion;
    const(wchar)* wszURL;
    const(wchar)* wszLocalFilename;
    ubyte* pbPostData;
    uint dwPostDataSize;
    const(wchar)* wszFriendlyName;
}

struct DRM_ACTSERV_INFO
{
    uint uVersion;
    const(wchar)* wszPubKey;
    const(wchar)* wszURL;
}

struct DRM_CLIENT_VERSION_INFO
{
    uint uStructVersion;
    uint dwVersion;
    ushort wszHierarchy;
    ushort wszProductId;
    ushort wszProductDescription;
}

enum DRM_STATUS_MSG
{
    DRM_MSG_ACTIVATE_MACHINE = 0,
    DRM_MSG_ACTIVATE_GROUPIDENTITY = 1,
    DRM_MSG_ACQUIRE_LICENSE = 2,
    DRM_MSG_ACQUIRE_ADVISORY = 3,
    DRM_MSG_SIGN_ISSUANCE_LICENSE = 4,
    DRM_MSG_ACQUIRE_CLIENTLICENSOR = 5,
    DRM_MSG_ACQUIRE_ISSUANCE_LICENSE_TEMPLATE = 6,
}

enum DRM_USAGEPOLICY_TYPE
{
    DRM_USAGEPOLICY_TYPE_BYNAME = 0,
    DRM_USAGEPOLICY_TYPE_BYPUBLICKEY = 1,
    DRM_USAGEPOLICY_TYPE_BYDIGEST = 2,
    DRM_USAGEPOLICY_TYPE_OSEXCLUSION = 3,
}

enum DRM_DISTRIBUTION_POINT_INFO
{
    DRM_DISTRIBUTION_POINT_LICENSE_ACQUISITION = 0,
    DRM_DISTRIBUTION_POINT_PUBLISHING = 1,
    DRM_DISTRIBUTION_POINT_REFERRAL_INFO = 2,
}

alias DRMCALLBACK = extern(Windows) HRESULT function(DRM_STATUS_MSG param0, HRESULT param1, void* param2, void* param3);
@DllImport("msdrm.dll")
HRESULT DRMSetGlobalOptions(DRMGLOBALOPTIONS eGlobalOptions, void* pvdata, uint dwlen);

@DllImport("msdrm.dll")
HRESULT DRMGetClientVersion(DRM_CLIENT_VERSION_INFO* pDRMClientVersionInfo);

@DllImport("msdrm.dll")
HRESULT DRMInitEnvironment(DRMSECURITYPROVIDERTYPE eSecurityProviderType, DRMSPECTYPE eSpecification, const(wchar)* wszSecurityProvider, const(wchar)* wszManifestCredentials, const(wchar)* wszMachineCredentials, uint* phEnv, uint* phDefaultLibrary);

@DllImport("msdrm.dll")
HRESULT DRMLoadLibrary(uint hEnv, DRMSPECTYPE eSpecification, const(wchar)* wszLibraryProvider, const(wchar)* wszCredentials, uint* phLibrary);

@DllImport("msdrm.dll")
HRESULT DRMCreateEnablingPrincipal(uint hEnv, uint hLibrary, const(wchar)* wszObject, DRMID* pidPrincipal, const(wchar)* wszCredentials, uint* phEnablingPrincipal);

@DllImport("msdrm.dll")
HRESULT DRMCloseHandle(uint handle);

@DllImport("msdrm.dll")
HRESULT DRMCloseEnvironmentHandle(uint hEnv);

@DllImport("msdrm.dll")
HRESULT DRMDuplicateHandle(uint hToCopy, uint* phCopy);

@DllImport("msdrm.dll")
HRESULT DRMDuplicateEnvironmentHandle(uint hToCopy, uint* phCopy);

@DllImport("msdrm.dll")
HRESULT DRMRegisterRevocationList(uint hEnv, const(wchar)* wszRevocationList);

@DllImport("msdrm.dll")
HRESULT DRMCheckSecurity(uint hEnv, uint cLevel);

@DllImport("msdrm.dll")
HRESULT DRMRegisterContent(BOOL fRegister);

@DllImport("msdrm.dll")
HRESULT DRMEncrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, ubyte* pbOutData);

@DllImport("msdrm.dll")
HRESULT DRMDecrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, ubyte* pbOutData);

@DllImport("msdrm.dll")
HRESULT DRMCreateBoundLicense(uint hEnv, DRMBOUNDLICENSEPARAMS* pParams, const(wchar)* wszLicenseChain, uint* phBoundLicense, uint* phErrorLog);

@DllImport("msdrm.dll")
HRESULT DRMCreateEnablingBitsDecryptor(uint hBoundLicense, const(wchar)* wszRight, uint hAuxLib, const(wchar)* wszAuxPlug, uint* phDecryptor);

@DllImport("msdrm.dll")
HRESULT DRMCreateEnablingBitsEncryptor(uint hBoundLicense, const(wchar)* wszRight, uint hAuxLib, const(wchar)* wszAuxPlug, uint* phEncryptor);

@DllImport("msdrm.dll")
HRESULT DRMAttest(uint hEnablingPrincipal, const(wchar)* wszData, DRMATTESTTYPE eType, uint* pcAttestedBlob, const(wchar)* wszAttestedBlob);

@DllImport("msdrm.dll")
HRESULT DRMGetTime(uint hEnv, DRMTIMETYPE eTimerIdType, SYSTEMTIME* poTimeObject);

@DllImport("msdrm.dll")
HRESULT DRMGetInfo(uint handle, const(wchar)* wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

@DllImport("msdrm.dll")
HRESULT DRMGetEnvironmentInfo(uint handle, const(wchar)* wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

@DllImport("msdrm.dll")
HRESULT DRMGetProcAddress(uint hLibrary, const(wchar)* wszProcName, FARPROC* ppfnProcAddress);

@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseObjectCount(uint hQueryRoot, const(wchar)* wszSubObjectType, uint* pcSubObjects);

@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseObject(uint hQueryRoot, const(wchar)* wszSubObjectType, uint iWhich, uint* phSubObject);

@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseAttributeCount(uint hQueryRoot, const(wchar)* wszAttribute, uint* pcAttributes);

@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseAttribute(uint hQueryRoot, const(wchar)* wszAttribute, uint iWhich, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

@DllImport("msdrm.dll")
HRESULT DRMCreateClientSession(DRMCALLBACK pfnCallback, uint uCallbackVersion, const(wchar)* wszGroupIDProviderType, const(wchar)* wszGroupID, uint* phClient);

@DllImport("msdrm.dll")
HRESULT DRMIsActivated(uint hClient, uint uFlags, DRM_ACTSERV_INFO* pActServInfo);

@DllImport("msdrm.dll")
HRESULT DRMActivate(uint hClient, uint uFlags, uint uLangID, DRM_ACTSERV_INFO* pActServInfo, void* pvContext, HWND hParentWnd);

@DllImport("msdrm.dll")
HRESULT DRMGetServiceLocation(uint hClient, uint uServiceType, uint uServiceLocation, const(wchar)* wszIssuanceLicense, uint* puServiceURLLength, const(wchar)* wszServiceURL);

@DllImport("msdrm.dll")
HRESULT DRMCreateLicenseStorageSession(uint hEnv, uint hDefaultLibrary, uint hClient, uint uFlags, const(wchar)* wszIssuanceLicense, uint* phLicenseStorage);

@DllImport("msdrm.dll")
HRESULT DRMAddLicense(uint hLicenseStorage, uint uFlags, const(wchar)* wszLicense);

@DllImport("msdrm.dll")
HRESULT DRMAcquireAdvisories(uint hLicenseStorage, const(wchar)* wszLicense, const(wchar)* wszURL, void* pvContext);

@DllImport("msdrm.dll")
HRESULT DRMEnumerateLicense(uint hSession, uint uFlags, uint uIndex, int* pfSharedFlag, uint* puCertificateDataLen, const(wchar)* wszCertificateData);

@DllImport("msdrm.dll")
HRESULT DRMAcquireLicense(uint hSession, uint uFlags, const(wchar)* wszGroupIdentityCredential, const(wchar)* wszRequestedRights, const(wchar)* wszCustomData, const(wchar)* wszURL, void* pvContext);

@DllImport("msdrm.dll")
HRESULT DRMDeleteLicense(uint hSession, const(wchar)* wszLicenseId);

@DllImport("msdrm.dll")
HRESULT DRMCloseSession(uint hSession);

@DllImport("msdrm.dll")
HRESULT DRMDuplicateSession(uint hSessionIn, uint* phSessionOut);

@DllImport("msdrm.dll")
HRESULT DRMGetSecurityProvider(uint uFlags, uint* puTypeLen, const(wchar)* wszType, uint* puPathLen, const(wchar)* wszPath);

@DllImport("msdrm.dll")
HRESULT DRMEncode(const(wchar)* wszAlgID, uint uDataLen, ubyte* pbDecodedData, uint* puEncodedStringLen, const(wchar)* wszEncodedString);

@DllImport("msdrm.dll")
HRESULT DRMDecode(const(wchar)* wszAlgID, const(wchar)* wszEncodedString, uint* puDecodedDataLen, ubyte* pbDecodedData);

@DllImport("msdrm.dll")
HRESULT DRMConstructCertificateChain(uint cCertificates, char* rgwszCertificates, uint* pcChain, const(wchar)* wszChain);

@DllImport("msdrm.dll")
HRESULT DRMParseUnboundLicense(const(wchar)* wszCertificate, uint* phQueryRoot);

@DllImport("msdrm.dll")
HRESULT DRMCloseQueryHandle(uint hQuery);

@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseObjectCount(uint hQueryRoot, const(wchar)* wszSubObjectType, uint* pcSubObjects);

@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseObject(uint hQueryRoot, const(wchar)* wszSubObjectType, uint iIndex, uint* phSubQuery);

@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseAttributeCount(uint hQueryRoot, const(wchar)* wszAttributeType, uint* pcAttributes);

@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseAttribute(uint hQueryRoot, const(wchar)* wszAttributeType, uint iWhich, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

@DllImport("msdrm.dll")
HRESULT DRMGetCertificateChainCount(const(wchar)* wszChain, uint* pcCertCount);

@DllImport("msdrm.dll")
HRESULT DRMDeconstructCertificateChain(const(wchar)* wszChain, uint iWhich, uint* pcCert, const(wchar)* wszCert);

@DllImport("msdrm.dll")
HRESULT DRMVerify(const(wchar)* wszData, uint* pcAttestedData, const(wchar)* wszAttestedData, DRMATTESTTYPE* peType, uint* pcPrincipal, const(wchar)* wszPrincipal, uint* pcManifest, const(wchar)* wszManifest);

@DllImport("msdrm.dll")
HRESULT DRMCreateUser(const(wchar)* wszUserName, const(wchar)* wszUserId, const(wchar)* wszUserIdType, uint* phUser);

@DllImport("msdrm.dll")
HRESULT DRMCreateRight(const(wchar)* wszRightName, SYSTEMTIME* pstFrom, SYSTEMTIME* pstUntil, uint cExtendedInfo, char* pwszExtendedInfoName, char* pwszExtendedInfoValue, uint* phRight);

@DllImport("msdrm.dll")
HRESULT DRMCreateIssuanceLicense(SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, const(wchar)* wszReferralInfoName, const(wchar)* wszReferralInfoURL, uint hOwner, const(wchar)* wszIssuanceLicense, uint hBoundLicense, uint* phIssuanceLicense);

@DllImport("msdrm.dll")
HRESULT DRMAddRightWithUser(uint hIssuanceLicense, uint hRight, uint hUser);

@DllImport("msdrm.dll")
HRESULT DRMClearAllRights(uint hIssuanceLicense);

@DllImport("msdrm.dll")
HRESULT DRMSetMetaData(uint hIssuanceLicense, const(wchar)* wszContentId, const(wchar)* wszContentIdType, const(wchar)* wszSKUId, const(wchar)* wszSKUIdType, const(wchar)* wszContentType, const(wchar)* wszContentName);

@DllImport("msdrm.dll")
HRESULT DRMSetUsagePolicy(uint hIssuanceLicense, DRM_USAGEPOLICY_TYPE eUsagePolicyType, BOOL fDelete, BOOL fExclusion, const(wchar)* wszName, const(wchar)* wszMinVersion, const(wchar)* wszMaxVersion, const(wchar)* wszPublicKey, const(wchar)* wszDigestAlgorithm, ubyte* pbDigest, uint cbDigest);

@DllImport("msdrm.dll")
HRESULT DRMSetRevocationPoint(uint hIssuanceLicense, BOOL fDelete, const(wchar)* wszId, const(wchar)* wszIdType, const(wchar)* wszURL, SYSTEMTIME* pstFrequency, const(wchar)* wszName, const(wchar)* wszPublicKey);

@DllImport("msdrm.dll")
HRESULT DRMSetApplicationSpecificData(uint hIssuanceLicense, BOOL fDelete, const(wchar)* wszName, const(wchar)* wszValue);

@DllImport("msdrm.dll")
HRESULT DRMSetNameAndDescription(uint hIssuanceLicense, BOOL fDelete, uint lcid, const(wchar)* wszName, const(wchar)* wszDescription);

@DllImport("msdrm.dll")
HRESULT DRMSetIntervalTime(uint hIssuanceLicense, uint cDays);

@DllImport("msdrm.dll")
HRESULT DRMGetIssuanceLicenseTemplate(uint hIssuanceLicense, uint* puIssuanceLicenseTemplateLength, const(wchar)* wszIssuanceLicenseTemplate);

@DllImport("msdrm.dll")
HRESULT DRMGetSignedIssuanceLicense(uint hEnv, uint hIssuanceLicense, uint uFlags, ubyte* pbSymKey, uint cbSymKey, const(wchar)* wszSymKeyType, const(wchar)* wszClientLicensorCertificate, DRMCALLBACK pfnCallback, const(wchar)* wszURL, void* pvContext);

@DllImport("msdrm.dll")
HRESULT DRMGetSignedIssuanceLicenseEx(uint hEnv, uint hIssuanceLicense, uint uFlags, char* pbSymKey, uint cbSymKey, const(wchar)* wszSymKeyType, void* pvReserved, uint hEnablingPrincipal, uint hBoundLicenseCLC, DRMCALLBACK pfnCallback, void* pvContext);

@DllImport("msdrm.dll")
HRESULT DRMClosePubHandle(uint hPub);

@DllImport("msdrm.dll")
HRESULT DRMDuplicatePubHandle(uint hPubIn, uint* phPubOut);

@DllImport("msdrm.dll")
HRESULT DRMGetUserInfo(uint hUser, uint* puUserNameLength, const(wchar)* wszUserName, uint* puUserIdLength, const(wchar)* wszUserId, uint* puUserIdTypeLength, const(wchar)* wszUserIdType);

@DllImport("msdrm.dll")
HRESULT DRMGetRightInfo(uint hRight, uint* puRightNameLength, const(wchar)* wszRightName, SYSTEMTIME* pstFrom, SYSTEMTIME* pstUntil);

@DllImport("msdrm.dll")
HRESULT DRMGetRightExtendedInfo(uint hRight, uint uIndex, uint* puExtendedInfoNameLength, const(wchar)* wszExtendedInfoName, uint* puExtendedInfoValueLength, const(wchar)* wszExtendedInfoValue);

@DllImport("msdrm.dll")
HRESULT DRMGetUsers(uint hIssuanceLicense, uint uIndex, uint* phUser);

@DllImport("msdrm.dll")
HRESULT DRMGetUserRights(uint hIssuanceLicense, uint hUser, uint uIndex, uint* phRight);

@DllImport("msdrm.dll")
HRESULT DRMGetMetaData(uint hIssuanceLicense, uint* puContentIdLength, const(wchar)* wszContentId, uint* puContentIdTypeLength, const(wchar)* wszContentIdType, uint* puSKUIdLength, const(wchar)* wszSKUId, uint* puSKUIdTypeLength, const(wchar)* wszSKUIdType, uint* puContentTypeLength, const(wchar)* wszContentType, uint* puContentNameLength, const(wchar)* wszContentName);

@DllImport("msdrm.dll")
HRESULT DRMGetApplicationSpecificData(uint hIssuanceLicense, uint uIndex, uint* puNameLength, const(wchar)* wszName, uint* puValueLength, const(wchar)* wszValue);

@DllImport("msdrm.dll")
HRESULT DRMGetIssuanceLicenseInfo(uint hIssuanceLicense, SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, uint uFlags, uint* puDistributionPointNameLength, const(wchar)* wszDistributionPointName, uint* puDistributionPointURLLength, const(wchar)* wszDistributionPointURL, uint* phOwner, int* pfOfficial);

@DllImport("msdrm.dll")
HRESULT DRMGetRevocationPoint(uint hIssuanceLicense, uint* puIdLength, const(wchar)* wszId, uint* puIdTypeLength, const(wchar)* wszIdType, uint* puURLLength, const(wchar)* wszRL, SYSTEMTIME* pstFrequency, uint* puNameLength, const(wchar)* wszName, uint* puPublicKeyLength, const(wchar)* wszPublicKey);

@DllImport("msdrm.dll")
HRESULT DRMGetUsagePolicy(uint hIssuanceLicense, uint uIndex, DRM_USAGEPOLICY_TYPE* peUsagePolicyType, int* pfExclusion, uint* puNameLength, const(wchar)* wszName, uint* puMinVersionLength, const(wchar)* wszMinVersion, uint* puMaxVersionLength, const(wchar)* wszMaxVersion, uint* puPublicKeyLength, const(wchar)* wszPublicKey, uint* puDigestAlgorithmLength, const(wchar)* wszDigestAlgorithm, uint* pcbDigest, ubyte* pbDigest);

@DllImport("msdrm.dll")
HRESULT DRMGetNameAndDescription(uint hIssuanceLicense, uint uIndex, uint* pulcid, uint* puNameLength, const(wchar)* wszName, uint* puDescriptionLength, const(wchar)* wszDescription);

@DllImport("msdrm.dll")
HRESULT DRMGetOwnerLicense(uint hIssuanceLicense, uint* puOwnerLicenseLength, const(wchar)* wszOwnerLicense);

@DllImport("msdrm.dll")
HRESULT DRMGetIntervalTime(uint hIssuanceLicense, uint* pcDays);

@DllImport("msdrm.dll")
HRESULT DRMRepair();

@DllImport("msdrm.dll")
HRESULT DRMRegisterProtectedWindow(uint hEnv, HWND hwnd);

@DllImport("msdrm.dll")
HRESULT DRMIsWindowProtected(HWND hwnd, int* pfProtected);

@DllImport("msdrm.dll")
HRESULT DRMAcquireIssuanceLicenseTemplate(uint hClient, uint uFlags, void* pvReserved, uint cTemplates, char* pwszTemplateIds, const(wchar)* wszUrl, void* pvContext);

