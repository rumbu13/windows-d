module windows.security;

public import system;
public import windows.audio;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.gdi;
public import windows.kernel;
public import windows.passwordmanagement;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;
public import windows.windowspropertiessystem;
public import windows.windowsstationsanddesktops;

extern(Windows):

enum MSA_INFO_LEVEL
{
    MsaInfoLevel0 = 0,
    MsaInfoLevelMax = 1,
}

enum MSA_INFO_STATE
{
    MsaInfoNotExist = 1,
    MsaInfoNotService = 2,
    MsaInfoCannotInstall = 3,
    MsaInfoCanInstall = 4,
    MsaInfoInstalled = 5,
}

struct MSA_INFO_0
{
    MSA_INFO_STATE State;
}

@DllImport("logoncli.dll")
NTSTATUS NetAddServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, const(wchar)* Password, uint Flags);

@DllImport("logoncli.dll")
NTSTATUS NetRemoveServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, uint Flags);

@DllImport("logoncli.dll")
NTSTATUS NetEnumerateServiceAccounts(const(wchar)* ServerName, uint Flags, uint* AccountsCount, ushort*** Accounts);

@DllImport("logoncli.dll")
NTSTATUS NetIsServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, int* IsService);

@DllImport("logoncli.dll")
NTSTATUS NetQueryServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, uint InfoLevel, ubyte** Buffer);

@DllImport("ADVAPI32.dll")
BOOL SetServiceBits(SERVICE_STATUS_HANDLE__* hServiceStatus, uint dwServiceBits, BOOL bSetBitsOn, BOOL bUpdateImmediately);

@DllImport("ADVAPI32.dll")
BOOL ImpersonateNamedPipeClient(HANDLE hNamedPipe);

@DllImport("USER32.dll")
BOOL SetUserObjectSecurity(HANDLE hObj, uint* pSIRequested, void* pSID);

@DllImport("USER32.dll")
BOOL GetUserObjectSecurity(HANDLE hObj, uint* pSIRequested, char* pSID, uint nLength, uint* lpnLengthNeeded);

@DllImport("ADVAPI32.dll")
BOOL AccessCheck(void* pSecurityDescriptor, HANDLE ClientToken, uint DesiredAccess, GENERIC_MAPPING* GenericMapping, char* PrivilegeSet, uint* PrivilegeSetLength, uint* GrantedAccess, int* AccessStatus);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckAndAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, const(wchar)* ObjectTypeName, const(wchar)* ObjectName, void* SecurityDescriptor, uint DesiredAccess, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByType(void* pSecurityDescriptor, void* PrincipalSelfSid, HANDLE ClientToken, uint DesiredAccess, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, char* PrivilegeSet, uint* PrivilegeSetLength, uint* GrantedAccess, int* AccessStatus);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultList(void* pSecurityDescriptor, void* PrincipalSelfSid, HANDLE ClientToken, uint DesiredAccess, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, char* PrivilegeSet, uint* PrivilegeSetLength, char* GrantedAccessList, char* AccessStatusList);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeAndAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, const(wchar)* ObjectTypeName, const(wchar)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, const(wchar)* ObjectTypeName, const(wchar)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, char* GrantedAccessList, char* AccessStatusList, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmByHandleW(const(wchar)* SubsystemName, void* HandleId, HANDLE ClientToken, const(wchar)* ObjectTypeName, const(wchar)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, char* GrantedAccessList, char* AccessStatusList, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AddAccessAllowedAce(ACL* pAcl, uint dwAceRevision, uint AccessMask, void* pSid);

@DllImport("ADVAPI32.dll")
BOOL AddAccessAllowedAceEx(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid);

@DllImport("ADVAPI32.dll")
BOOL AddAccessAllowedObjectAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, Guid* ObjectTypeGuid, Guid* InheritedObjectTypeGuid, void* pSid);

@DllImport("ADVAPI32.dll")
BOOL AddAccessDeniedAce(ACL* pAcl, uint dwAceRevision, uint AccessMask, void* pSid);

@DllImport("ADVAPI32.dll")
BOOL AddAccessDeniedAceEx(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid);

@DllImport("ADVAPI32.dll")
BOOL AddAccessDeniedObjectAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, Guid* ObjectTypeGuid, Guid* InheritedObjectTypeGuid, void* pSid);

@DllImport("ADVAPI32.dll")
BOOL AddAce(ACL* pAcl, uint dwAceRevision, uint dwStartingAceIndex, char* pAceList, uint nAceListLength);

@DllImport("ADVAPI32.dll")
BOOL AddAuditAccessAce(ACL* pAcl, uint dwAceRevision, uint dwAccessMask, void* pSid, BOOL bAuditSuccess, BOOL bAuditFailure);

@DllImport("ADVAPI32.dll")
BOOL AddAuditAccessAceEx(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint dwAccessMask, void* pSid, BOOL bAuditSuccess, BOOL bAuditFailure);

@DllImport("ADVAPI32.dll")
BOOL AddAuditAccessObjectAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, Guid* ObjectTypeGuid, Guid* InheritedObjectTypeGuid, void* pSid, BOOL bAuditSuccess, BOOL bAuditFailure);

@DllImport("ADVAPI32.dll")
BOOL AddMandatoryAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint MandatoryPolicy, void* pLabelSid);

@DllImport("KERNEL32.dll")
BOOL AddResourceAttributeAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid, CLAIM_SECURITY_ATTRIBUTES_INFORMATION* pAttributeInfo, uint* pReturnLength);

@DllImport("KERNEL32.dll")
BOOL AddScopedPolicyIDAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid);

@DllImport("ADVAPI32.dll")
BOOL AdjustTokenGroups(HANDLE TokenHandle, BOOL ResetToDefault, TOKEN_GROUPS* NewState, uint BufferLength, char* PreviousState, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
BOOL AdjustTokenPrivileges(HANDLE TokenHandle, BOOL DisableAllPrivileges, TOKEN_PRIVILEGES* NewState, uint BufferLength, char* PreviousState, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
BOOL AllocateAndInitializeSid(SID_IDENTIFIER_AUTHORITY* pIdentifierAuthority, ubyte nSubAuthorityCount, uint nSubAuthority0, uint nSubAuthority1, uint nSubAuthority2, uint nSubAuthority3, uint nSubAuthority4, uint nSubAuthority5, uint nSubAuthority6, uint nSubAuthority7, void** pSid);

@DllImport("ADVAPI32.dll")
BOOL AllocateLocallyUniqueId(LUID* Luid);

@DllImport("ADVAPI32.dll")
BOOL AreAllAccessesGranted(uint GrantedAccess, uint DesiredAccess);

@DllImport("ADVAPI32.dll")
BOOL AreAnyAccessesGranted(uint GrantedAccess, uint DesiredAccess);

@DllImport("ADVAPI32.dll")
BOOL CheckTokenMembership(HANDLE TokenHandle, void* SidToCheck, int* IsMember);

@DllImport("KERNEL32.dll")
BOOL CheckTokenCapability(HANDLE TokenHandle, void* CapabilitySidToCheck, int* HasCapability);

@DllImport("KERNEL32.dll")
BOOL GetAppContainerAce(ACL* Acl, uint StartingAceIndex, void** AppContainerAce, uint* AppContainerAceIndex);

@DllImport("KERNEL32.dll")
BOOL CheckTokenMembershipEx(HANDLE TokenHandle, void* SidToCheck, uint Flags, int* IsMember);

@DllImport("ADVAPI32.dll")
BOOL ConvertToAutoInheritPrivateObjectSecurity(void* ParentDescriptor, void* CurrentSecurityDescriptor, void** NewSecurityDescriptor, Guid* ObjectType, ubyte IsDirectoryObject, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32.dll")
BOOL CopySid(uint nDestinationSidLength, char* pDestinationSid, void* pSourceSid);

@DllImport("ADVAPI32.dll")
BOOL CreatePrivateObjectSecurity(void* ParentDescriptor, void* CreatorDescriptor, void** NewDescriptor, BOOL IsDirectoryObject, HANDLE Token, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32.dll")
BOOL CreatePrivateObjectSecurityEx(void* ParentDescriptor, void* CreatorDescriptor, void** NewDescriptor, Guid* ObjectType, BOOL IsContainerObject, uint AutoInheritFlags, HANDLE Token, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32.dll")
BOOL CreatePrivateObjectSecurityWithMultipleInheritance(void* ParentDescriptor, void* CreatorDescriptor, void** NewDescriptor, char* ObjectTypes, uint GuidCount, BOOL IsContainerObject, uint AutoInheritFlags, HANDLE Token, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32.dll")
BOOL CreateRestrictedToken(HANDLE ExistingTokenHandle, uint Flags, uint DisableSidCount, char* SidsToDisable, uint DeletePrivilegeCount, char* PrivilegesToDelete, uint RestrictedSidCount, char* SidsToRestrict, int* NewTokenHandle);

@DllImport("ADVAPI32.dll")
BOOL CreateWellKnownSid(WELL_KNOWN_SID_TYPE WellKnownSidType, void* DomainSid, char* pSid, uint* cbSid);

@DllImport("ADVAPI32.dll")
BOOL EqualDomainSid(void* pSid1, void* pSid2, int* pfEqual);

@DllImport("ADVAPI32.dll")
BOOL DeleteAce(ACL* pAcl, uint dwAceIndex);

@DllImport("ADVAPI32.dll")
BOOL DestroyPrivateObjectSecurity(void** ObjectDescriptor);

@DllImport("ADVAPI32.dll")
BOOL DuplicateToken(HANDLE ExistingTokenHandle, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, int* DuplicateTokenHandle);

@DllImport("ADVAPI32.dll")
BOOL DuplicateTokenEx(HANDLE hExistingToken, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpTokenAttributes, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, TOKEN_TYPE TokenType, int* phNewToken);

@DllImport("ADVAPI32.dll")
BOOL EqualPrefixSid(void* pSid1, void* pSid2);

@DllImport("ADVAPI32.dll")
BOOL EqualSid(void* pSid1, void* pSid2);

@DllImport("ADVAPI32.dll")
BOOL FindFirstFreeAce(ACL* pAcl, void** pAce);

@DllImport("ADVAPI32.dll")
void* FreeSid(void* pSid);

@DllImport("ADVAPI32.dll")
BOOL GetAce(ACL* pAcl, uint dwAceIndex, void** pAce);

@DllImport("ADVAPI32.dll")
BOOL GetAclInformation(ACL* pAcl, char* pAclInformation, uint nAclInformationLength, ACL_INFORMATION_CLASS dwAclInformationClass);

@DllImport("ADVAPI32.dll")
BOOL GetFileSecurityW(const(wchar)* lpFileName, uint RequestedInformation, char* pSecurityDescriptor, uint nLength, uint* lpnLengthNeeded);

@DllImport("ADVAPI32.dll")
BOOL GetKernelObjectSecurity(HANDLE Handle, uint RequestedInformation, char* pSecurityDescriptor, uint nLength, uint* lpnLengthNeeded);

@DllImport("ADVAPI32.dll")
uint GetLengthSid(char* pSid);

@DllImport("ADVAPI32.dll")
BOOL GetPrivateObjectSecurity(void* ObjectDescriptor, uint SecurityInformation, char* ResultantDescriptor, uint DescriptorLength, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorControl(void* pSecurityDescriptor, ushort* pControl, uint* lpdwRevision);

@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorDacl(void* pSecurityDescriptor, int* lpbDaclPresent, ACL** pDacl, int* lpbDaclDefaulted);

@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorGroup(void* pSecurityDescriptor, void** pGroup, int* lpbGroupDefaulted);

@DllImport("ADVAPI32.dll")
uint GetSecurityDescriptorLength(void* pSecurityDescriptor);

@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorOwner(void* pSecurityDescriptor, void** pOwner, int* lpbOwnerDefaulted);

@DllImport("ADVAPI32.dll")
uint GetSecurityDescriptorRMControl(void* SecurityDescriptor, ubyte* RMControl);

@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorSacl(void* pSecurityDescriptor, int* lpbSaclPresent, ACL** pSacl, int* lpbSaclDefaulted);

@DllImport("ADVAPI32.dll")
SID_IDENTIFIER_AUTHORITY* GetSidIdentifierAuthority(void* pSid);

@DllImport("ADVAPI32.dll")
uint GetSidLengthRequired(ubyte nSubAuthorityCount);

@DllImport("ADVAPI32.dll")
uint* GetSidSubAuthority(void* pSid, uint nSubAuthority);

@DllImport("ADVAPI32.dll")
ubyte* GetSidSubAuthorityCount(void* pSid);

@DllImport("ADVAPI32.dll")
BOOL GetTokenInformation(HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, char* TokenInformation, uint TokenInformationLength, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
BOOL GetWindowsAccountDomainSid(void* pSid, char* pDomainSid, uint* cbDomainSid);

@DllImport("ADVAPI32.dll")
BOOL ImpersonateAnonymousToken(HANDLE ThreadHandle);

@DllImport("ADVAPI32.dll")
BOOL ImpersonateLoggedOnUser(HANDLE hToken);

@DllImport("ADVAPI32.dll")
BOOL ImpersonateSelf(SECURITY_IMPERSONATION_LEVEL ImpersonationLevel);

@DllImport("ADVAPI32.dll")
BOOL InitializeAcl(char* pAcl, uint nAclLength, uint dwAclRevision);

@DllImport("ADVAPI32.dll")
BOOL InitializeSecurityDescriptor(void* pSecurityDescriptor, uint dwRevision);

@DllImport("ADVAPI32.dll")
BOOL InitializeSid(char* Sid, SID_IDENTIFIER_AUTHORITY* pIdentifierAuthority, ubyte nSubAuthorityCount);

@DllImport("ADVAPI32.dll")
BOOL IsTokenRestricted(HANDLE TokenHandle);

@DllImport("ADVAPI32.dll")
BOOL IsValidAcl(ACL* pAcl);

@DllImport("ADVAPI32.dll")
BOOL IsValidSecurityDescriptor(void* pSecurityDescriptor);

@DllImport("ADVAPI32.dll")
BOOL IsValidSid(void* pSid);

@DllImport("ADVAPI32.dll")
BOOL IsWellKnownSid(void* pSid, WELL_KNOWN_SID_TYPE WellKnownSidType);

@DllImport("ADVAPI32.dll")
BOOL MakeAbsoluteSD(void* pSelfRelativeSecurityDescriptor, char* pAbsoluteSecurityDescriptor, uint* lpdwAbsoluteSecurityDescriptorSize, char* pDacl, uint* lpdwDaclSize, char* pSacl, uint* lpdwSaclSize, char* pOwner, uint* lpdwOwnerSize, char* pPrimaryGroup, uint* lpdwPrimaryGroupSize);

@DllImport("ADVAPI32.dll")
BOOL MakeSelfRelativeSD(void* pAbsoluteSecurityDescriptor, char* pSelfRelativeSecurityDescriptor, uint* lpdwBufferLength);

@DllImport("ADVAPI32.dll")
void MapGenericMask(uint* AccessMask, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32.dll")
BOOL ObjectCloseAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectDeleteAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectOpenAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, const(wchar)* ObjectTypeName, const(wchar)* ObjectName, void* pSecurityDescriptor, HANDLE ClientToken, uint DesiredAccess, uint GrantedAccess, PRIVILEGE_SET* Privileges, BOOL ObjectCreation, BOOL AccessGranted, int* GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectPrivilegeAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, HANDLE ClientToken, uint DesiredAccess, PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32.dll")
BOOL PrivilegeCheck(HANDLE ClientToken, PRIVILEGE_SET* RequiredPrivileges, int* pfResult);

@DllImport("ADVAPI32.dll")
BOOL PrivilegedServiceAuditAlarmW(const(wchar)* SubsystemName, const(wchar)* ServiceName, HANDLE ClientToken, PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32.dll")
void QuerySecurityAccessMask(uint SecurityInformation, uint* DesiredAccess);

@DllImport("ADVAPI32.dll")
BOOL RevertToSelf();

@DllImport("ADVAPI32.dll")
BOOL SetAclInformation(ACL* pAcl, char* pAclInformation, uint nAclInformationLength, ACL_INFORMATION_CLASS dwAclInformationClass);

@DllImport("ADVAPI32.dll")
BOOL SetFileSecurityW(const(wchar)* lpFileName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ADVAPI32.dll")
BOOL SetKernelObjectSecurity(HANDLE Handle, uint SecurityInformation, void* SecurityDescriptor);

@DllImport("ADVAPI32.dll")
BOOL SetPrivateObjectSecurity(uint SecurityInformation, void* ModificationDescriptor, void** ObjectsSecurityDescriptor, GENERIC_MAPPING* GenericMapping, HANDLE Token);

@DllImport("ADVAPI32.dll")
BOOL SetPrivateObjectSecurityEx(uint SecurityInformation, void* ModificationDescriptor, void** ObjectsSecurityDescriptor, uint AutoInheritFlags, GENERIC_MAPPING* GenericMapping, HANDLE Token);

@DllImport("ADVAPI32.dll")
void SetSecurityAccessMask(uint SecurityInformation, uint* DesiredAccess);

@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorControl(void* pSecurityDescriptor, ushort ControlBitsOfInterest, ushort ControlBitsToSet);

@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorDacl(void* pSecurityDescriptor, BOOL bDaclPresent, ACL* pDacl, BOOL bDaclDefaulted);

@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorGroup(void* pSecurityDescriptor, void* pGroup, BOOL bGroupDefaulted);

@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorOwner(void* pSecurityDescriptor, void* pOwner, BOOL bOwnerDefaulted);

@DllImport("ADVAPI32.dll")
uint SetSecurityDescriptorRMControl(void* SecurityDescriptor, ubyte* RMControl);

@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorSacl(void* pSecurityDescriptor, BOOL bSaclPresent, ACL* pSacl, BOOL bSaclDefaulted);

@DllImport("ADVAPI32.dll")
BOOL SetTokenInformation(HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, char* TokenInformation, uint TokenInformationLength);

@DllImport("KERNEL32.dll")
BOOL SetCachedSigningLevel(char* SourceFiles, uint SourceFileCount, uint Flags, HANDLE TargetFile);

@DllImport("KERNEL32.dll")
BOOL GetCachedSigningLevel(HANDLE File, uint* Flags, uint* SigningLevel, char* Thumbprint, uint* ThumbprintSize, uint* ThumbprintAlgorithm);

@DllImport("api-ms-win-security-base-l1-2-2.dll")
BOOL DeriveCapabilitySidsFromName(const(wchar)* CapName, void*** CapabilityGroupSids, uint* CapabilityGroupSidCount, void*** CapabilitySids, uint* CapabilitySidCount);

@DllImport("KERNEL32.dll")
BOOL GetAppContainerNamedObjectPath(HANDLE Token, void* AppContainerSid, uint ObjectPathLength, const(wchar)* ObjectPath, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
BOOL CryptAcquireContextA(uint* phProv, const(char)* szContainer, const(char)* szProvider, uint dwProvType, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptAcquireContextW(uint* phProv, const(wchar)* szContainer, const(wchar)* szProvider, uint dwProvType, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptReleaseContext(uint hProv, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptGenKey(uint hProv, uint Algid, uint dwFlags, uint* phKey);

@DllImport("ADVAPI32.dll")
BOOL CryptDeriveKey(uint hProv, uint Algid, uint hBaseData, uint dwFlags, uint* phKey);

@DllImport("ADVAPI32.dll")
BOOL CryptDestroyKey(uint hKey);

@DllImport("ADVAPI32.dll")
BOOL CryptSetKeyParam(uint hKey, uint dwParam, const(ubyte)* pbData, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptGetKeyParam(uint hKey, uint dwParam, char* pbData, uint* pdwDataLen, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptSetHashParam(uint hHash, uint dwParam, const(ubyte)* pbData, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptGetHashParam(uint hHash, uint dwParam, char* pbData, uint* pdwDataLen, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptSetProvParam(uint hProv, uint dwParam, const(ubyte)* pbData, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptGetProvParam(uint hProv, uint dwParam, char* pbData, uint* pdwDataLen, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptGenRandom(uint hProv, uint dwLen, char* pbBuffer);

@DllImport("ADVAPI32.dll")
BOOL CryptGetUserKey(uint hProv, uint dwKeySpec, uint* phUserKey);

@DllImport("ADVAPI32.dll")
BOOL CryptExportKey(uint hKey, uint hExpKey, uint dwBlobType, uint dwFlags, char* pbData, uint* pdwDataLen);

@DllImport("ADVAPI32.dll")
BOOL CryptImportKey(uint hProv, char* pbData, uint dwDataLen, uint hPubKey, uint dwFlags, uint* phKey);

@DllImport("ADVAPI32.dll")
BOOL CryptEncrypt(uint hKey, uint hHash, BOOL Final, uint dwFlags, char* pbData, uint* pdwDataLen, uint dwBufLen);

@DllImport("ADVAPI32.dll")
BOOL CryptDecrypt(uint hKey, uint hHash, BOOL Final, uint dwFlags, char* pbData, uint* pdwDataLen);

@DllImport("ADVAPI32.dll")
BOOL CryptCreateHash(uint hProv, uint Algid, uint hKey, uint dwFlags, uint* phHash);

@DllImport("ADVAPI32.dll")
BOOL CryptHashData(uint hHash, char* pbData, uint dwDataLen, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptHashSessionKey(uint hHash, uint hKey, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptDestroyHash(uint hHash);

@DllImport("ADVAPI32.dll")
BOOL CryptSignHashA(uint hHash, uint dwKeySpec, const(char)* szDescription, uint dwFlags, char* pbSignature, uint* pdwSigLen);

@DllImport("ADVAPI32.dll")
BOOL CryptSignHashW(uint hHash, uint dwKeySpec, const(wchar)* szDescription, uint dwFlags, char* pbSignature, uint* pdwSigLen);

@DllImport("ADVAPI32.dll")
BOOL CryptVerifySignatureA(uint hHash, char* pbSignature, uint dwSigLen, uint hPubKey, const(char)* szDescription, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptVerifySignatureW(uint hHash, char* pbSignature, uint dwSigLen, uint hPubKey, const(wchar)* szDescription, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptSetProviderA(const(char)* pszProvName, uint dwProvType);

@DllImport("ADVAPI32.dll")
BOOL CryptSetProviderW(const(wchar)* pszProvName, uint dwProvType);

@DllImport("ADVAPI32.dll")
BOOL CryptSetProviderExA(const(char)* pszProvName, uint dwProvType, uint* pdwReserved, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptSetProviderExW(const(wchar)* pszProvName, uint dwProvType, uint* pdwReserved, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptGetDefaultProviderA(uint dwProvType, uint* pdwReserved, uint dwFlags, const(char)* pszProvName, uint* pcbProvName);

@DllImport("ADVAPI32.dll")
BOOL CryptGetDefaultProviderW(uint dwProvType, uint* pdwReserved, uint dwFlags, const(wchar)* pszProvName, uint* pcbProvName);

@DllImport("ADVAPI32.dll")
BOOL CryptEnumProviderTypesA(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, const(char)* szTypeName, uint* pcbTypeName);

@DllImport("ADVAPI32.dll")
BOOL CryptEnumProviderTypesW(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, const(wchar)* szTypeName, uint* pcbTypeName);

@DllImport("ADVAPI32.dll")
BOOL CryptEnumProvidersA(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, const(char)* szProvName, uint* pcbProvName);

@DllImport("ADVAPI32.dll")
BOOL CryptEnumProvidersW(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, const(wchar)* szProvName, uint* pcbProvName);

@DllImport("ADVAPI32.dll")
BOOL CryptContextAddRef(uint hProv, uint* pdwReserved, uint dwFlags);

@DllImport("ADVAPI32.dll")
BOOL CryptDuplicateKey(uint hKey, uint* pdwReserved, uint dwFlags, uint* phKey);

@DllImport("ADVAPI32.dll")
BOOL CryptDuplicateHash(uint hHash, uint* pdwReserved, uint dwFlags, uint* phHash);

@DllImport("bcrypt.dll")
NTSTATUS BCryptOpenAlgorithmProvider(void** phAlgorithm, const(wchar)* pszAlgId, const(wchar)* pszImplementation, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptEnumAlgorithms(uint dwAlgOperations, uint* pAlgCount, BCRYPT_ALGORITHM_IDENTIFIER** ppAlgList, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptEnumProviders(const(wchar)* pszAlgId, uint* pImplCount, BCRYPT_PROVIDER_NAME** ppImplList, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptGetProperty(void* hObject, const(wchar)* pszProperty, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptSetProperty(void* hObject, const(wchar)* pszProperty, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptCloseAlgorithmProvider(void* hAlgorithm, uint dwFlags);

@DllImport("bcrypt.dll")
void BCryptFreeBuffer(void* pvBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptGenerateSymmetricKey(void* hAlgorithm, void** phKey, char* pbKeyObject, uint cbKeyObject, char* pbSecret, uint cbSecret, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptGenerateKeyPair(void* hAlgorithm, void** phKey, uint dwLength, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptEncrypt(void* hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbIV, uint cbIV, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDecrypt(void* hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbIV, uint cbIV, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptExportKey(void* hKey, void* hExportKey, const(wchar)* pszBlobType, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptImportKey(void* hAlgorithm, void* hImportKey, const(wchar)* pszBlobType, void** phKey, char* pbKeyObject, uint cbKeyObject, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptImportKeyPair(void* hAlgorithm, void* hImportKey, const(wchar)* pszBlobType, void** phKey, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDuplicateKey(void* hKey, void** phNewKey, char* pbKeyObject, uint cbKeyObject, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptFinalizeKeyPair(void* hKey, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDestroyKey(void* hKey);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDestroySecret(void* hSecret);

@DllImport("bcrypt.dll")
NTSTATUS BCryptSignHash(void* hKey, void* pPaddingInfo, char* pbInput, uint cbInput, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptVerifySignature(void* hKey, void* pPaddingInfo, char* pbHash, uint cbHash, char* pbSignature, uint cbSignature, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptSecretAgreement(void* hPrivKey, void* hPubKey, void** phAgreedSecret, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDeriveKey(void* hSharedSecret, const(wchar)* pwszKDF, BCryptBufferDesc* pParameterList, char* pbDerivedKey, uint cbDerivedKey, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptKeyDerivation(void* hKey, BCryptBufferDesc* pParameterList, char* pbDerivedKey, uint cbDerivedKey, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptCreateHash(void* hAlgorithm, void** phHash, char* pbHashObject, uint cbHashObject, char* pbSecret, uint cbSecret, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptHashData(void* hHash, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptFinishHash(void* hHash, char* pbOutput, uint cbOutput, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptCreateMultiHash(void* hAlgorithm, void** phHash, uint nHashes, char* pbHashObject, uint cbHashObject, char* pbSecret, uint cbSecret, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptProcessMultiOperations(void* hObject, BCRYPT_MULTI_OPERATION_TYPE operationType, char* pOperations, uint cbOperations, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDuplicateHash(void* hHash, void** phNewHash, char* pbHashObject, uint cbHashObject, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDestroyHash(void* hHash);

@DllImport("bcrypt.dll")
NTSTATUS BCryptHash(void* hAlgorithm, char* pbSecret, uint cbSecret, char* pbInput, uint cbInput, char* pbOutput, uint cbOutput);

@DllImport("bcrypt.dll")
NTSTATUS BCryptGenRandom(void* hAlgorithm, char* pbBuffer, uint cbBuffer, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDeriveKeyCapi(void* hHash, void* hTargetAlg, char* pbDerivedKey, uint cbDerivedKey, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDeriveKeyPBKDF2(void* hPrf, char* pbPassword, uint cbPassword, char* pbSalt, uint cbSalt, ulong cIterations, char* pbDerivedKey, uint cbDerivedKey, uint dwFlags);

@DllImport("bcrypt.dll")
NTSTATUS BCryptQueryProviderRegistration(const(wchar)* pszProvider, uint dwMode, uint dwInterface, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptEnumRegisteredProviders(uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptCreateContext(uint dwTable, const(wchar)* pszContext, CRYPT_CONTEXT_CONFIG* pConfig);

@DllImport("bcrypt.dll")
NTSTATUS BCryptDeleteContext(uint dwTable, const(wchar)* pszContext);

@DllImport("bcrypt.dll")
NTSTATUS BCryptEnumContexts(uint dwTable, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptConfigureContext(uint dwTable, const(wchar)* pszContext, CRYPT_CONTEXT_CONFIG* pConfig);

@DllImport("bcrypt.dll")
NTSTATUS BCryptQueryContextConfiguration(uint dwTable, const(wchar)* pszContext, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptAddContextFunction(uint dwTable, const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, uint dwPosition);

@DllImport("bcrypt.dll")
NTSTATUS BCryptRemoveContextFunction(uint dwTable, const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction);

@DllImport("bcrypt.dll")
NTSTATUS BCryptEnumContextFunctions(uint dwTable, const(wchar)* pszContext, uint dwInterface, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptConfigureContextFunction(uint dwTable, const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, CRYPT_CONTEXT_FUNCTION_CONFIG* pConfig);

@DllImport("bcrypt.dll")
NTSTATUS BCryptQueryContextFunctionConfiguration(uint dwTable, const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptEnumContextFunctionProviders(uint dwTable, const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptSetContextFunctionProperty(uint dwTable, const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, const(wchar)* pszProperty, uint cbValue, char* pbValue);

@DllImport("bcrypt.dll")
NTSTATUS BCryptQueryContextFunctionProperty(uint dwTable, const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, const(wchar)* pszProperty, uint* pcbValue, char* ppbValue);

@DllImport("bcrypt.dll")
NTSTATUS BCryptRegisterConfigChangeNotify(HANDLE* phEvent);

@DllImport("bcrypt.dll")
NTSTATUS BCryptUnregisterConfigChangeNotify(HANDLE hEvent);

@DllImport("bcrypt.dll")
NTSTATUS BCryptResolveProviders(const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, const(wchar)* pszProvider, uint dwMode, uint dwFlags, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt.dll")
NTSTATUS BCryptGetFipsAlgorithmMode(ubyte* pfEnabled);

@DllImport("ncrypt.dll")
int NCryptOpenStorageProvider(uint* phProvider, const(wchar)* pszProviderName, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptEnumAlgorithms(uint hProvider, uint dwAlgOperations, uint* pdwAlgCount, NCryptAlgorithmName** ppAlgList, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptIsAlgSupported(uint hProvider, const(wchar)* pszAlgId, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptEnumKeys(uint hProvider, const(wchar)* pszScope, NCryptKeyName** ppKeyName, void** ppEnumState, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptEnumStorageProviders(uint* pdwProviderCount, NCryptProviderName** ppProviderList, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptFreeBuffer(void* pvInput);

@DllImport("ncrypt.dll")
int NCryptOpenKey(uint hProvider, uint* phKey, const(wchar)* pszKeyName, uint dwLegacyKeySpec, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptCreatePersistedKey(uint hProvider, uint* phKey, const(wchar)* pszAlgId, const(wchar)* pszKeyName, uint dwLegacyKeySpec, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptGetProperty(uint hObject, const(wchar)* pszProperty, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptSetProperty(uint hObject, const(wchar)* pszProperty, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptFinalizeKey(uint hKey, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptEncrypt(uint hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptDecrypt(uint hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptImportKey(uint hProvider, uint hImportKey, const(wchar)* pszBlobType, BCryptBufferDesc* pParameterList, uint* phKey, char* pbData, uint cbData, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptExportKey(uint hKey, uint hExportKey, const(wchar)* pszBlobType, BCryptBufferDesc* pParameterList, char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptSignHash(uint hKey, void* pPaddingInfo, char* pbHashValue, uint cbHashValue, char* pbSignature, uint cbSignature, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptVerifySignature(uint hKey, void* pPaddingInfo, char* pbHashValue, uint cbHashValue, char* pbSignature, uint cbSignature, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptDeleteKey(uint hKey, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptFreeObject(uint hObject);

@DllImport("ncrypt.dll")
BOOL NCryptIsKeyHandle(uint hKey);

@DllImport("ncrypt.dll")
int NCryptTranslateHandle(uint* phProvider, uint* phKey, uint hLegacyProv, uint hLegacyKey, uint dwLegacyKeySpec, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptNotifyChangeKey(uint hProvider, HANDLE* phEvent, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptSecretAgreement(uint hPrivKey, uint hPubKey, uint* phAgreedSecret, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptDeriveKey(uint hSharedSecret, const(wchar)* pwszKDF, BCryptBufferDesc* pParameterList, char* pbDerivedKey, uint cbDerivedKey, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptKeyDerivation(uint hKey, BCryptBufferDesc* pParameterList, char* pbDerivedKey, uint cbDerivedKey, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptCreateClaim(uint hSubjectKey, uint hAuthorityKey, uint dwClaimType, BCryptBufferDesc* pParameterList, char* pbClaimBlob, uint cbClaimBlob, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptVerifyClaim(uint hSubjectKey, uint hAuthorityKey, uint dwClaimType, BCryptBufferDesc* pParameterList, char* pbClaimBlob, uint cbClaimBlob, BCryptBufferDesc* pOutput, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL CryptFormatObject(uint dwCertEncodingType, uint dwFormatType, uint dwFormatStrType, void* pFormatStruct, const(char)* lpszStructType, char* pbEncoded, uint cbEncoded, char* pbFormat, uint* pcbFormat);

@DllImport("CRYPT32.dll")
BOOL CryptEncodeObjectEx(uint dwCertEncodingType, const(char)* lpszStructType, const(void)* pvStructInfo, uint dwFlags, CRYPT_ENCODE_PARA* pEncodePara, void* pvEncoded, uint* pcbEncoded);

@DllImport("CRYPT32.dll")
BOOL CryptEncodeObject(uint dwCertEncodingType, const(char)* lpszStructType, const(void)* pvStructInfo, char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32.dll")
BOOL CryptDecodeObjectEx(uint dwCertEncodingType, const(char)* lpszStructType, char* pbEncoded, uint cbEncoded, uint dwFlags, CRYPT_DECODE_PARA* pDecodePara, void* pvStructInfo, uint* pcbStructInfo);

@DllImport("CRYPT32.dll")
BOOL CryptDecodeObject(uint dwCertEncodingType, const(char)* lpszStructType, char* pbEncoded, uint cbEncoded, uint dwFlags, char* pvStructInfo, uint* pcbStructInfo);

@DllImport("CRYPT32.dll")
BOOL CryptInstallOIDFunctionAddress(int hModule, uint dwEncodingType, const(char)* pszFuncName, uint cFuncEntry, char* rgFuncEntry, uint dwFlags);

@DllImport("CRYPT32.dll")
void* CryptInitOIDFunctionSet(const(char)* pszFuncName, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL CryptGetOIDFunctionAddress(void* hFuncSet, uint dwEncodingType, const(char)* pszOID, uint dwFlags, void** ppvFuncAddr, void** phFuncAddr);

@DllImport("CRYPT32.dll")
BOOL CryptGetDefaultOIDDllList(void* hFuncSet, uint dwEncodingType, char* pwszDllList, uint* pcchDllList);

@DllImport("CRYPT32.dll")
BOOL CryptGetDefaultOIDFunctionAddress(void* hFuncSet, uint dwEncodingType, const(wchar)* pwszDll, uint dwFlags, void** ppvFuncAddr, void** phFuncAddr);

@DllImport("CRYPT32.dll")
BOOL CryptFreeOIDFunctionAddress(void* hFuncAddr, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL CryptRegisterOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, const(wchar)* pwszDll, const(char)* pszOverrideFuncName);

@DllImport("CRYPT32.dll")
BOOL CryptUnregisterOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID);

@DllImport("CRYPT32.dll")
BOOL CryptRegisterDefaultOIDFunction(uint dwEncodingType, const(char)* pszFuncName, uint dwIndex, const(wchar)* pwszDll);

@DllImport("CRYPT32.dll")
BOOL CryptUnregisterDefaultOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(wchar)* pwszDll);

@DllImport("CRYPT32.dll")
BOOL CryptSetOIDFunctionValue(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, const(wchar)* pwszValueName, uint dwValueType, char* pbValueData, uint cbValueData);

@DllImport("CRYPT32.dll")
BOOL CryptGetOIDFunctionValue(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, const(wchar)* pwszValueName, uint* pdwValueType, char* pbValueData, uint* pcbValueData);

@DllImport("CRYPT32.dll")
BOOL CryptEnumOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, uint dwFlags, void* pvArg, PFN_CRYPT_ENUM_OID_FUNC pfnEnumOIDFunc);

@DllImport("CRYPT32.dll")
CRYPT_OID_INFO* CryptFindOIDInfo(uint dwKeyType, void* pvKey, uint dwGroupId);

@DllImport("CRYPT32.dll")
BOOL CryptRegisterOIDInfo(CRYPT_OID_INFO* pInfo, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL CryptUnregisterOIDInfo(CRYPT_OID_INFO* pInfo);

@DllImport("CRYPT32.dll")
BOOL CryptEnumOIDInfo(uint dwGroupId, uint dwFlags, void* pvArg, PFN_CRYPT_ENUM_OID_INFO pfnEnumOIDInfo);

@DllImport("CRYPT32.dll")
ushort* CryptFindLocalizedName(const(wchar)* pwszCryptName);

@DllImport("CRYPT32.dll")
void* CryptMsgOpenToEncode(uint dwMsgEncodingType, uint dwFlags, uint dwMsgType, const(void)* pvMsgEncodeInfo, const(char)* pszInnerContentObjID, CMSG_STREAM_INFO* pStreamInfo);

@DllImport("CRYPT32.dll")
uint CryptMsgCalculateEncodedLength(uint dwMsgEncodingType, uint dwFlags, uint dwMsgType, const(void)* pvMsgEncodeInfo, const(char)* pszInnerContentObjID, uint cbData);

@DllImport("CRYPT32.dll")
void* CryptMsgOpenToDecode(uint dwMsgEncodingType, uint dwFlags, uint dwMsgType, uint hCryptProv, CERT_INFO* pRecipientInfo, CMSG_STREAM_INFO* pStreamInfo);

@DllImport("CRYPT32.dll")
void* CryptMsgDuplicate(void* hCryptMsg);

@DllImport("CRYPT32.dll")
BOOL CryptMsgClose(void* hCryptMsg);

@DllImport("CRYPT32.dll")
BOOL CryptMsgUpdate(void* hCryptMsg, char* pbData, uint cbData, BOOL fFinal);

@DllImport("CRYPT32.dll")
BOOL CryptMsgGetParam(void* hCryptMsg, uint dwParamType, uint dwIndex, char* pvData, uint* pcbData);

@DllImport("CRYPT32.dll")
BOOL CryptMsgControl(void* hCryptMsg, uint dwFlags, uint dwCtrlType, const(void)* pvCtrlPara);

@DllImport("CRYPT32.dll")
BOOL CryptMsgVerifyCountersignatureEncoded(uint hCryptProv, uint dwEncodingType, char* pbSignerInfo, uint cbSignerInfo, char* pbSignerInfoCountersignature, uint cbSignerInfoCountersignature, CERT_INFO* pciCountersigner);

@DllImport("CRYPT32.dll")
BOOL CryptMsgVerifyCountersignatureEncodedEx(uint hCryptProv, uint dwEncodingType, char* pbSignerInfo, uint cbSignerInfo, char* pbSignerInfoCountersignature, uint cbSignerInfoCountersignature, uint dwSignerType, void* pvSigner, uint dwFlags, void* pvExtra);

@DllImport("CRYPT32.dll")
BOOL CryptMsgCountersign(void* hCryptMsg, uint dwIndex, uint cCountersigners, char* rgCountersigners);

@DllImport("CRYPT32.dll")
BOOL CryptMsgCountersignEncoded(uint dwEncodingType, char* pbSignerInfo, uint cbSignerInfo, uint cCountersigners, char* rgCountersigners, char* pbCountersignature, uint* pcbCountersignature);

@DllImport("CRYPT32.dll")
void* CertOpenStore(const(char)* lpszStoreProvider, uint dwEncodingType, uint hCryptProv, uint dwFlags, const(void)* pvPara);

@DllImport("CRYPT32.dll")
void* CertDuplicateStore(void* hCertStore);

@DllImport("CRYPT32.dll")
BOOL CertSaveStore(void* hCertStore, uint dwEncodingType, uint dwSaveAs, uint dwSaveTo, void* pvSaveToPara, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL CertCloseStore(void* hCertStore, uint dwFlags);

@DllImport("CRYPT32.dll")
CERT_CONTEXT* CertGetSubjectCertificateFromStore(void* hCertStore, uint dwCertEncodingType, CERT_INFO* pCertId);

@DllImport("CRYPT32.dll")
CERT_CONTEXT* CertEnumCertificatesInStore(void* hCertStore, CERT_CONTEXT* pPrevCertContext);

@DllImport("CRYPT32.dll")
CERT_CONTEXT* CertFindCertificateInStore(void* hCertStore, uint dwCertEncodingType, uint dwFindFlags, uint dwFindType, const(void)* pvFindPara, CERT_CONTEXT* pPrevCertContext);

@DllImport("CRYPT32.dll")
CERT_CONTEXT* CertGetIssuerCertificateFromStore(void* hCertStore, CERT_CONTEXT* pSubjectContext, CERT_CONTEXT* pPrevIssuerContext, uint* pdwFlags);

@DllImport("CRYPT32.dll")
BOOL CertVerifySubjectCertificateContext(CERT_CONTEXT* pSubject, CERT_CONTEXT* pIssuer, uint* pdwFlags);

@DllImport("CRYPT32.dll")
CERT_CONTEXT* CertDuplicateCertificateContext(CERT_CONTEXT* pCertContext);

@DllImport("CRYPT32.dll")
CERT_CONTEXT* CertCreateCertificateContext(uint dwCertEncodingType, char* pbCertEncoded, uint cbCertEncoded);

@DllImport("CRYPT32.dll")
BOOL CertFreeCertificateContext(CERT_CONTEXT* pCertContext);

@DllImport("CRYPT32.dll")
BOOL CertSetCertificateContextProperty(CERT_CONTEXT* pCertContext, uint dwPropId, uint dwFlags, const(void)* pvData);

@DllImport("CRYPT32.dll")
BOOL CertGetCertificateContextProperty(CERT_CONTEXT* pCertContext, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32.dll")
uint CertEnumCertificateContextProperties(CERT_CONTEXT* pCertContext, uint dwPropId);

@DllImport("CRYPT32.dll")
BOOL CertCreateCTLEntryFromCertificateContextProperties(CERT_CONTEXT* pCertContext, uint cOptAttr, char* rgOptAttr, uint dwFlags, void* pvReserved, char* pCtlEntry, uint* pcbCtlEntry);

@DllImport("CRYPT32.dll")
BOOL CertSetCertificateContextPropertiesFromCTLEntry(CERT_CONTEXT* pCertContext, CTL_ENTRY* pCtlEntry, uint dwFlags);

@DllImport("CRYPT32.dll")
CRL_CONTEXT* CertGetCRLFromStore(void* hCertStore, CERT_CONTEXT* pIssuerContext, CRL_CONTEXT* pPrevCrlContext, uint* pdwFlags);

@DllImport("CRYPT32.dll")
CRL_CONTEXT* CertEnumCRLsInStore(void* hCertStore, CRL_CONTEXT* pPrevCrlContext);

@DllImport("CRYPT32.dll")
CRL_CONTEXT* CertFindCRLInStore(void* hCertStore, uint dwCertEncodingType, uint dwFindFlags, uint dwFindType, const(void)* pvFindPara, CRL_CONTEXT* pPrevCrlContext);

@DllImport("CRYPT32.dll")
CRL_CONTEXT* CertDuplicateCRLContext(CRL_CONTEXT* pCrlContext);

@DllImport("CRYPT32.dll")
CRL_CONTEXT* CertCreateCRLContext(uint dwCertEncodingType, char* pbCrlEncoded, uint cbCrlEncoded);

@DllImport("CRYPT32.dll")
BOOL CertFreeCRLContext(CRL_CONTEXT* pCrlContext);

@DllImport("CRYPT32.dll")
BOOL CertSetCRLContextProperty(CRL_CONTEXT* pCrlContext, uint dwPropId, uint dwFlags, const(void)* pvData);

@DllImport("CRYPT32.dll")
BOOL CertGetCRLContextProperty(CRL_CONTEXT* pCrlContext, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32.dll")
uint CertEnumCRLContextProperties(CRL_CONTEXT* pCrlContext, uint dwPropId);

@DllImport("CRYPT32.dll")
BOOL CertFindCertificateInCRL(CERT_CONTEXT* pCert, CRL_CONTEXT* pCrlContext, uint dwFlags, void* pvReserved, CRL_ENTRY** ppCrlEntry);

@DllImport("CRYPT32.dll")
BOOL CertIsValidCRLForCertificate(CERT_CONTEXT* pCert, CRL_CONTEXT* pCrl, uint dwFlags, void* pvReserved);

@DllImport("CRYPT32.dll")
BOOL CertAddEncodedCertificateToStore(void* hCertStore, uint dwCertEncodingType, char* pbCertEncoded, uint cbCertEncoded, uint dwAddDisposition, CERT_CONTEXT** ppCertContext);

@DllImport("CRYPT32.dll")
BOOL CertAddCertificateContextToStore(void* hCertStore, CERT_CONTEXT* pCertContext, uint dwAddDisposition, CERT_CONTEXT** ppStoreContext);

@DllImport("CRYPT32.dll")
BOOL CertAddSerializedElementToStore(void* hCertStore, char* pbElement, uint cbElement, uint dwAddDisposition, uint dwFlags, uint dwContextTypeFlags, uint* pdwContextType, const(void)** ppvContext);

@DllImport("CRYPT32.dll")
BOOL CertDeleteCertificateFromStore(CERT_CONTEXT* pCertContext);

@DllImport("CRYPT32.dll")
BOOL CertAddEncodedCRLToStore(void* hCertStore, uint dwCertEncodingType, char* pbCrlEncoded, uint cbCrlEncoded, uint dwAddDisposition, CRL_CONTEXT** ppCrlContext);

@DllImport("CRYPT32.dll")
BOOL CertAddCRLContextToStore(void* hCertStore, CRL_CONTEXT* pCrlContext, uint dwAddDisposition, CRL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32.dll")
BOOL CertDeleteCRLFromStore(CRL_CONTEXT* pCrlContext);

@DllImport("CRYPT32.dll")
BOOL CertSerializeCertificateStoreElement(CERT_CONTEXT* pCertContext, uint dwFlags, char* pbElement, uint* pcbElement);

@DllImport("CRYPT32.dll")
BOOL CertSerializeCRLStoreElement(CRL_CONTEXT* pCrlContext, uint dwFlags, char* pbElement, uint* pcbElement);

@DllImport("CRYPT32.dll")
CTL_CONTEXT* CertDuplicateCTLContext(CTL_CONTEXT* pCtlContext);

@DllImport("CRYPT32.dll")
CTL_CONTEXT* CertCreateCTLContext(uint dwMsgAndCertEncodingType, char* pbCtlEncoded, uint cbCtlEncoded);

@DllImport("CRYPT32.dll")
BOOL CertFreeCTLContext(CTL_CONTEXT* pCtlContext);

@DllImport("CRYPT32.dll")
BOOL CertSetCTLContextProperty(CTL_CONTEXT* pCtlContext, uint dwPropId, uint dwFlags, const(void)* pvData);

@DllImport("CRYPT32.dll")
BOOL CertGetCTLContextProperty(CTL_CONTEXT* pCtlContext, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32.dll")
uint CertEnumCTLContextProperties(CTL_CONTEXT* pCtlContext, uint dwPropId);

@DllImport("CRYPT32.dll")
CTL_CONTEXT* CertEnumCTLsInStore(void* hCertStore, CTL_CONTEXT* pPrevCtlContext);

@DllImport("CRYPT32.dll")
CTL_ENTRY* CertFindSubjectInCTL(uint dwEncodingType, uint dwSubjectType, void* pvSubject, CTL_CONTEXT* pCtlContext, uint dwFlags);

@DllImport("CRYPT32.dll")
CTL_CONTEXT* CertFindCTLInStore(void* hCertStore, uint dwMsgAndCertEncodingType, uint dwFindFlags, uint dwFindType, const(void)* pvFindPara, CTL_CONTEXT* pPrevCtlContext);

@DllImport("CRYPT32.dll")
BOOL CertAddEncodedCTLToStore(void* hCertStore, uint dwMsgAndCertEncodingType, char* pbCtlEncoded, uint cbCtlEncoded, uint dwAddDisposition, CTL_CONTEXT** ppCtlContext);

@DllImport("CRYPT32.dll")
BOOL CertAddCTLContextToStore(void* hCertStore, CTL_CONTEXT* pCtlContext, uint dwAddDisposition, CTL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32.dll")
BOOL CertSerializeCTLStoreElement(CTL_CONTEXT* pCtlContext, uint dwFlags, char* pbElement, uint* pcbElement);

@DllImport("CRYPT32.dll")
BOOL CertDeleteCTLFromStore(CTL_CONTEXT* pCtlContext);

@DllImport("CRYPT32.dll")
BOOL CertAddCertificateLinkToStore(void* hCertStore, CERT_CONTEXT* pCertContext, uint dwAddDisposition, CERT_CONTEXT** ppStoreContext);

@DllImport("CRYPT32.dll")
BOOL CertAddCRLLinkToStore(void* hCertStore, CRL_CONTEXT* pCrlContext, uint dwAddDisposition, CRL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32.dll")
BOOL CertAddCTLLinkToStore(void* hCertStore, CTL_CONTEXT* pCtlContext, uint dwAddDisposition, CTL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32.dll")
BOOL CertAddStoreToCollection(void* hCollectionStore, void* hSiblingStore, uint dwUpdateFlags, uint dwPriority);

@DllImport("CRYPT32.dll")
void CertRemoveStoreFromCollection(void* hCollectionStore, void* hSiblingStore);

@DllImport("CRYPT32.dll")
BOOL CertControlStore(void* hCertStore, uint dwFlags, uint dwCtrlType, const(void)* pvCtrlPara);

@DllImport("CRYPT32.dll")
BOOL CertSetStoreProperty(void* hCertStore, uint dwPropId, uint dwFlags, const(void)* pvData);

@DllImport("CRYPT32.dll")
BOOL CertGetStoreProperty(void* hCertStore, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32.dll")
void* CertCreateContext(uint dwContextType, uint dwEncodingType, char* pbEncoded, uint cbEncoded, uint dwFlags, CERT_CREATE_CONTEXT_PARA* pCreatePara);

@DllImport("CRYPT32.dll")
BOOL CertRegisterSystemStore(const(void)* pvSystemStore, uint dwFlags, CERT_SYSTEM_STORE_INFO* pStoreInfo, void* pvReserved);

@DllImport("CRYPT32.dll")
BOOL CertRegisterPhysicalStore(const(void)* pvSystemStore, uint dwFlags, const(wchar)* pwszStoreName, CERT_PHYSICAL_STORE_INFO* pStoreInfo, void* pvReserved);

@DllImport("CRYPT32.dll")
BOOL CertUnregisterSystemStore(const(void)* pvSystemStore, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL CertUnregisterPhysicalStore(const(void)* pvSystemStore, uint dwFlags, const(wchar)* pwszStoreName);

@DllImport("CRYPT32.dll")
BOOL CertEnumSystemStoreLocation(uint dwFlags, void* pvArg, PFN_CERT_ENUM_SYSTEM_STORE_LOCATION pfnEnum);

@DllImport("CRYPT32.dll")
BOOL CertEnumSystemStore(uint dwFlags, void* pvSystemStoreLocationPara, void* pvArg, PFN_CERT_ENUM_SYSTEM_STORE pfnEnum);

@DllImport("CRYPT32.dll")
BOOL CertEnumPhysicalStore(const(void)* pvSystemStore, uint dwFlags, void* pvArg, PFN_CERT_ENUM_PHYSICAL_STORE pfnEnum);

@DllImport("CRYPT32.dll")
BOOL CertGetEnhancedKeyUsage(CERT_CONTEXT* pCertContext, uint dwFlags, char* pUsage, uint* pcbUsage);

@DllImport("CRYPT32.dll")
BOOL CertSetEnhancedKeyUsage(CERT_CONTEXT* pCertContext, CTL_USAGE* pUsage);

@DllImport("CRYPT32.dll")
BOOL CertAddEnhancedKeyUsageIdentifier(CERT_CONTEXT* pCertContext, const(char)* pszUsageIdentifier);

@DllImport("CRYPT32.dll")
BOOL CertRemoveEnhancedKeyUsageIdentifier(CERT_CONTEXT* pCertContext, const(char)* pszUsageIdentifier);

@DllImport("CRYPT32.dll")
BOOL CertGetValidUsages(uint cCerts, char* rghCerts, int* cNumOIDs, char* rghOIDs, uint* pcbOIDs);

@DllImport("CRYPT32.dll")
BOOL CryptMsgGetAndVerifySigner(void* hCryptMsg, uint cSignerStore, char* rghSignerStore, uint dwFlags, CERT_CONTEXT** ppSigner, uint* pdwSignerIndex);

@DllImport("CRYPT32.dll")
BOOL CryptMsgSignCTL(uint dwMsgEncodingType, char* pbCtlContent, uint cbCtlContent, CMSG_SIGNED_ENCODE_INFO* pSignInfo, uint dwFlags, char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32.dll")
BOOL CryptMsgEncodeAndSignCTL(uint dwMsgEncodingType, CTL_INFO* pCtlInfo, CMSG_SIGNED_ENCODE_INFO* pSignInfo, uint dwFlags, char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32.dll")
BOOL CertFindSubjectInSortedCTL(CRYPTOAPI_BLOB* pSubjectIdentifier, CTL_CONTEXT* pCtlContext, uint dwFlags, void* pvReserved, CRYPTOAPI_BLOB* pEncodedAttributes);

@DllImport("CRYPT32.dll")
BOOL CertEnumSubjectInSortedCTL(CTL_CONTEXT* pCtlContext, void** ppvNextSubject, CRYPTOAPI_BLOB* pSubjectIdentifier, CRYPTOAPI_BLOB* pEncodedAttributes);

@DllImport("CRYPT32.dll")
BOOL CertVerifyCTLUsage(uint dwEncodingType, uint dwSubjectType, void* pvSubject, CTL_USAGE* pSubjectUsage, uint dwFlags, CTL_VERIFY_USAGE_PARA* pVerifyUsagePara, CTL_VERIFY_USAGE_STATUS* pVerifyUsageStatus);

@DllImport("CRYPT32.dll")
BOOL CertVerifyRevocation(uint dwEncodingType, uint dwRevType, uint cContext, char* rgpvContext, uint dwFlags, CERT_REVOCATION_PARA* pRevPara, CERT_REVOCATION_STATUS* pRevStatus);

@DllImport("CRYPT32.dll")
BOOL CertCompareIntegerBlob(CRYPTOAPI_BLOB* pInt1, CRYPTOAPI_BLOB* pInt2);

@DllImport("CRYPT32.dll")
BOOL CertCompareCertificate(uint dwCertEncodingType, CERT_INFO* pCertId1, CERT_INFO* pCertId2);

@DllImport("CRYPT32.dll")
BOOL CertCompareCertificateName(uint dwCertEncodingType, CRYPTOAPI_BLOB* pCertName1, CRYPTOAPI_BLOB* pCertName2);

@DllImport("CRYPT32.dll")
BOOL CertIsRDNAttrsInCertificateName(uint dwCertEncodingType, uint dwFlags, CRYPTOAPI_BLOB* pCertName, CERT_RDN* pRDN);

@DllImport("CRYPT32.dll")
BOOL CertComparePublicKeyInfo(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pPublicKey1, CERT_PUBLIC_KEY_INFO* pPublicKey2);

@DllImport("CRYPT32.dll")
uint CertGetPublicKeyLength(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pPublicKey);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyCertificateSignature(uint hCryptProv, uint dwCertEncodingType, char* pbEncoded, uint cbEncoded, CERT_PUBLIC_KEY_INFO* pPublicKey);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyCertificateSignatureEx(uint hCryptProv, uint dwCertEncodingType, uint dwSubjectType, void* pvSubject, uint dwIssuerType, void* pvIssuer, uint dwFlags, void* pvExtra);

@DllImport("CRYPT32.dll")
BOOL CertIsStrongHashToSign(CERT_STRONG_SIGN_PARA* pStrongSignPara, const(wchar)* pwszCNGHashAlgid, CERT_CONTEXT* pSigningCert);

@DllImport("CRYPT32.dll")
BOOL CryptHashToBeSigned(uint hCryptProv, uint dwCertEncodingType, char* pbEncoded, uint cbEncoded, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32.dll")
BOOL CryptHashCertificate(uint hCryptProv, uint Algid, uint dwFlags, char* pbEncoded, uint cbEncoded, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32.dll")
BOOL CryptHashCertificate2(const(wchar)* pwszCNGHashAlgid, uint dwFlags, void* pvReserved, char* pbEncoded, uint cbEncoded, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32.dll")
BOOL CryptSignCertificate(uint hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, char* pbEncodedToBeSigned, uint cbEncodedToBeSigned, CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, const(void)* pvHashAuxInfo, char* pbSignature, uint* pcbSignature);

@DllImport("CRYPT32.dll")
BOOL CryptSignAndEncodeCertificate(uint hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, const(char)* lpszStructType, const(void)* pvStructInfo, CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, const(void)* pvHashAuxInfo, char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32.dll")
int CertVerifyTimeValidity(FILETIME* pTimeToVerify, CERT_INFO* pCertInfo);

@DllImport("CRYPT32.dll")
int CertVerifyCRLTimeValidity(FILETIME* pTimeToVerify, CRL_INFO* pCrlInfo);

@DllImport("CRYPT32.dll")
BOOL CertVerifyValidityNesting(CERT_INFO* pSubjectInfo, CERT_INFO* pIssuerInfo);

@DllImport("CRYPT32.dll")
BOOL CertVerifyCRLRevocation(uint dwCertEncodingType, CERT_INFO* pCertId, uint cCrlInfo, char* rgpCrlInfo);

@DllImport("CRYPT32.dll")
byte* CertAlgIdToOID(uint dwAlgId);

@DllImport("CRYPT32.dll")
uint CertOIDToAlgId(const(char)* pszObjId);

@DllImport("CRYPT32.dll")
CERT_EXTENSION* CertFindExtension(const(char)* pszObjId, uint cExtensions, char* rgExtensions);

@DllImport("CRYPT32.dll")
CRYPT_ATTRIBUTE* CertFindAttribute(const(char)* pszObjId, uint cAttr, char* rgAttr);

@DllImport("CRYPT32.dll")
CERT_RDN_ATTR* CertFindRDNAttr(const(char)* pszObjId, CERT_NAME_INFO* pName);

@DllImport("CRYPT32.dll")
BOOL CertGetIntendedKeyUsage(uint dwCertEncodingType, CERT_INFO* pCertInfo, char* pbKeyUsage, uint cbKeyUsage);

@DllImport("CRYPT32.dll")
BOOL CryptInstallDefaultContext(uint hCryptProv, uint dwDefaultType, const(void)* pvDefaultPara, uint dwFlags, void* pvReserved, void** phDefaultContext);

@DllImport("CRYPT32.dll")
BOOL CryptUninstallDefaultContext(void* hDefaultContext, uint dwFlags, void* pvReserved);

@DllImport("CRYPT32.dll")
BOOL CryptExportPublicKeyInfo(uint hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, char* pInfo, uint* pcbInfo);

@DllImport("CRYPT32.dll")
BOOL CryptExportPublicKeyInfoEx(uint hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, const(char)* pszPublicKeyObjId, uint dwFlags, void* pvAuxInfo, char* pInfo, uint* pcbInfo);

@DllImport("CRYPT32.dll")
BOOL CryptExportPublicKeyInfoFromBCryptKeyHandle(void* hBCryptKey, uint dwCertEncodingType, const(char)* pszPublicKeyObjId, uint dwFlags, void* pvAuxInfo, char* pInfo, uint* pcbInfo);

@DllImport("CRYPT32.dll")
BOOL CryptImportPublicKeyInfo(uint hCryptProv, uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, uint* phKey);

@DllImport("CRYPT32.dll")
BOOL CryptImportPublicKeyInfoEx(uint hCryptProv, uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, uint aiKeyAlg, uint dwFlags, void* pvAuxInfo, uint* phKey);

@DllImport("CRYPT32.dll")
BOOL CryptImportPublicKeyInfoEx2(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, uint dwFlags, void* pvAuxInfo, void** phKey);

@DllImport("CRYPT32.dll")
BOOL CryptAcquireCertificatePrivateKey(CERT_CONTEXT* pCert, uint dwFlags, void* pvParameters, uint* phCryptProvOrNCryptKey, uint* pdwKeySpec, int* pfCallerFreeProvOrNCryptKey);

@DllImport("CRYPT32.dll")
BOOL CryptFindCertificateKeyProvInfo(CERT_CONTEXT* pCert, uint dwFlags, void* pvReserved);

@DllImport("CRYPT32.dll")
BOOL CryptImportPKCS8(CRYPT_PKCS8_IMPORT_PARAMS sPrivateKeyAndParams, uint dwFlags, uint* phCryptProv, void* pvAuxInfo);

@DllImport("CRYPT32.dll")
BOOL CryptExportPKCS8(uint hCryptProv, uint dwKeySpec, const(char)* pszPrivateKeyObjId, uint dwFlags, void* pvAuxInfo, char* pbPrivateKeyBlob, uint* pcbPrivateKeyBlob);

@DllImport("CRYPT32.dll")
BOOL CryptHashPublicKeyInfo(uint hCryptProv, uint Algid, uint dwFlags, uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32.dll")
uint CertRDNValueToStrA(uint dwValueType, CRYPTOAPI_BLOB* pValue, const(char)* psz, uint csz);

@DllImport("CRYPT32.dll")
uint CertRDNValueToStrW(uint dwValueType, CRYPTOAPI_BLOB* pValue, const(wchar)* psz, uint csz);

@DllImport("CRYPT32.dll")
uint CertNameToStrA(uint dwCertEncodingType, CRYPTOAPI_BLOB* pName, uint dwStrType, const(char)* psz, uint csz);

@DllImport("CRYPT32.dll")
uint CertNameToStrW(uint dwCertEncodingType, CRYPTOAPI_BLOB* pName, uint dwStrType, const(wchar)* psz, uint csz);

@DllImport("CRYPT32.dll")
BOOL CertStrToNameA(uint dwCertEncodingType, const(char)* pszX500, uint dwStrType, void* pvReserved, char* pbEncoded, uint* pcbEncoded, byte** ppszError);

@DllImport("CRYPT32.dll")
BOOL CertStrToNameW(uint dwCertEncodingType, const(wchar)* pszX500, uint dwStrType, void* pvReserved, char* pbEncoded, uint* pcbEncoded, ushort** ppszError);

@DllImport("CRYPT32.dll")
uint CertGetNameStringA(CERT_CONTEXT* pCertContext, uint dwType, uint dwFlags, void* pvTypePara, const(char)* pszNameString, uint cchNameString);

@DllImport("CRYPT32.dll")
uint CertGetNameStringW(CERT_CONTEXT* pCertContext, uint dwType, uint dwFlags, void* pvTypePara, const(wchar)* pszNameString, uint cchNameString);

@DllImport("CRYPT32.dll")
BOOL CryptSignMessage(CRYPT_SIGN_MESSAGE_PARA* pSignPara, BOOL fDetachedSignature, uint cToBeSigned, char* rgpbToBeSigned, char* rgcbToBeSigned, char* pbSignedBlob, uint* pcbSignedBlob);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyMessageSignature(CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, char* pbSignedBlob, uint cbSignedBlob, char* pbDecoded, uint* pcbDecoded, CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32.dll")
int CryptGetMessageSignerCount(uint dwMsgEncodingType, char* pbSignedBlob, uint cbSignedBlob);

@DllImport("CRYPT32.dll")
void* CryptGetMessageCertificates(uint dwMsgAndCertEncodingType, uint hCryptProv, uint dwFlags, char* pbSignedBlob, uint cbSignedBlob);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyDetachedMessageSignature(CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, char* pbDetachedSignBlob, uint cbDetachedSignBlob, uint cToBeSigned, char* rgpbToBeSigned, char* rgcbToBeSigned, CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32.dll")
BOOL CryptEncryptMessage(CRYPT_ENCRYPT_MESSAGE_PARA* pEncryptPara, uint cRecipientCert, char* rgpRecipientCert, char* pbToBeEncrypted, uint cbToBeEncrypted, char* pbEncryptedBlob, uint* pcbEncryptedBlob);

@DllImport("CRYPT32.dll")
BOOL CryptDecryptMessage(CRYPT_DECRYPT_MESSAGE_PARA* pDecryptPara, char* pbEncryptedBlob, uint cbEncryptedBlob, char* pbDecrypted, uint* pcbDecrypted, CERT_CONTEXT** ppXchgCert);

@DllImport("CRYPT32.dll")
BOOL CryptSignAndEncryptMessage(CRYPT_SIGN_MESSAGE_PARA* pSignPara, CRYPT_ENCRYPT_MESSAGE_PARA* pEncryptPara, uint cRecipientCert, char* rgpRecipientCert, char* pbToBeSignedAndEncrypted, uint cbToBeSignedAndEncrypted, char* pbSignedAndEncryptedBlob, uint* pcbSignedAndEncryptedBlob);

@DllImport("CRYPT32.dll")
BOOL CryptDecryptAndVerifyMessageSignature(CRYPT_DECRYPT_MESSAGE_PARA* pDecryptPara, CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, char* pbEncryptedBlob, uint cbEncryptedBlob, char* pbDecrypted, uint* pcbDecrypted, CERT_CONTEXT** ppXchgCert, CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32.dll")
BOOL CryptDecodeMessage(uint dwMsgTypeFlags, CRYPT_DECRYPT_MESSAGE_PARA* pDecryptPara, CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, char* pbEncodedBlob, uint cbEncodedBlob, uint dwPrevInnerContentType, uint* pdwMsgType, uint* pdwInnerContentType, char* pbDecoded, uint* pcbDecoded, CERT_CONTEXT** ppXchgCert, CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32.dll")
BOOL CryptHashMessage(CRYPT_HASH_MESSAGE_PARA* pHashPara, BOOL fDetachedHash, uint cToBeHashed, char* rgpbToBeHashed, char* rgcbToBeHashed, char* pbHashedBlob, uint* pcbHashedBlob, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyMessageHash(CRYPT_HASH_MESSAGE_PARA* pHashPara, char* pbHashedBlob, uint cbHashedBlob, char* pbToBeHashed, uint* pcbToBeHashed, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyDetachedMessageHash(CRYPT_HASH_MESSAGE_PARA* pHashPara, char* pbDetachedHashBlob, uint cbDetachedHashBlob, uint cToBeHashed, char* rgpbToBeHashed, char* rgcbToBeHashed, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32.dll")
BOOL CryptSignMessageWithKey(CRYPT_KEY_SIGN_MESSAGE_PARA* pSignPara, char* pbToBeSigned, uint cbToBeSigned, char* pbSignedBlob, uint* pcbSignedBlob);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyMessageSignatureWithKey(CRYPT_KEY_VERIFY_MESSAGE_PARA* pVerifyPara, CERT_PUBLIC_KEY_INFO* pPublicKeyInfo, char* pbSignedBlob, uint cbSignedBlob, char* pbDecoded, uint* pcbDecoded);

@DllImport("CRYPT32.dll")
void* CertOpenSystemStoreA(uint hProv, const(char)* szSubsystemProtocol);

@DllImport("CRYPT32.dll")
void* CertOpenSystemStoreW(uint hProv, const(wchar)* szSubsystemProtocol);

@DllImport("CRYPT32.dll")
BOOL CertAddEncodedCertificateToSystemStoreA(const(char)* szCertStoreName, char* pbCertEncoded, uint cbCertEncoded);

@DllImport("CRYPT32.dll")
BOOL CertAddEncodedCertificateToSystemStoreW(const(wchar)* szCertStoreName, char* pbCertEncoded, uint cbCertEncoded);

@DllImport("WINTRUST.dll")
HRESULT FindCertsByIssuer(char* pCertChains, uint* pcbCertChains, uint* pcCertChains, char* pbEncodedIssuerName, uint cbEncodedIssuerName, const(wchar)* pwszPurpose, uint dwKeySpec);

@DllImport("CRYPT32.dll")
BOOL CryptQueryObject(uint dwObjectType, const(void)* pvObject, uint dwExpectedContentTypeFlags, uint dwExpectedFormatTypeFlags, uint dwFlags, uint* pdwMsgAndCertEncodingType, uint* pdwContentType, uint* pdwFormatType, void** phCertStore, void** phMsg, const(void)** ppvContext);

@DllImport("CRYPT32.dll")
void* CryptMemAlloc(uint cbSize);

@DllImport("CRYPT32.dll")
void* CryptMemRealloc(void* pv, uint cbSize);

@DllImport("CRYPT32.dll")
void CryptMemFree(void* pv);

@DllImport("CRYPT32.dll")
BOOL CryptCreateAsyncHandle(uint dwFlags, HCRYPTASYNC* phAsync);

@DllImport("CRYPT32.dll")
BOOL CryptSetAsyncParam(HCRYPTASYNC hAsync, const(char)* pszParamOid, void* pvParam, PFN_CRYPT_ASYNC_PARAM_FREE_FUNC pfnFree);

@DllImport("CRYPT32.dll")
BOOL CryptGetAsyncParam(HCRYPTASYNC hAsync, const(char)* pszParamOid, void** ppvParam, PFN_CRYPT_ASYNC_PARAM_FREE_FUNC* ppfnFree);

@DllImport("CRYPT32.dll")
BOOL CryptCloseAsyncHandle(HCRYPTASYNC hAsync);

@DllImport("CRYPTNET.dll")
BOOL CryptRetrieveObjectByUrlA(const(char)* pszUrl, const(char)* pszObjectOid, uint dwRetrievalFlags, uint dwTimeout, void** ppvObject, HCRYPTASYNC hAsyncRetrieve, CRYPT_CREDENTIALS* pCredentials, void* pvVerify, CRYPT_RETRIEVE_AUX_INFO* pAuxInfo);

@DllImport("CRYPTNET.dll")
BOOL CryptRetrieveObjectByUrlW(const(wchar)* pszUrl, const(char)* pszObjectOid, uint dwRetrievalFlags, uint dwTimeout, void** ppvObject, HCRYPTASYNC hAsyncRetrieve, CRYPT_CREDENTIALS* pCredentials, void* pvVerify, CRYPT_RETRIEVE_AUX_INFO* pAuxInfo);

@DllImport("CRYPTNET.dll")
BOOL CryptInstallCancelRetrieval(PFN_CRYPT_CANCEL_RETRIEVAL pfnCancel, const(void)* pvArg, uint dwFlags, void* pvReserved);

@DllImport("CRYPTNET.dll")
BOOL CryptUninstallCancelRetrieval(uint dwFlags, void* pvReserved);

@DllImport("CRYPTNET.dll")
BOOL CryptGetObjectUrl(const(char)* pszUrlOid, void* pvPara, uint dwFlags, char* pUrlArray, uint* pcbUrlArray, char* pUrlInfo, uint* pcbUrlInfo, void* pvReserved);

@DllImport("CRYPT32.dll")
CERT_CONTEXT* CertCreateSelfSignCertificate(uint hCryptProvOrNCryptKey, CRYPTOAPI_BLOB* pSubjectIssuerBlob, uint dwFlags, CRYPT_KEY_PROV_INFO* pKeyProvInfo, CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, SYSTEMTIME* pStartTime, SYSTEMTIME* pEndTime, CERT_EXTENSIONS* pExtensions);

@DllImport("CRYPT32.dll")
BOOL CryptGetKeyIdentifierProperty(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwPropId, uint dwFlags, const(wchar)* pwszComputerName, void* pvReserved, char* pvData, uint* pcbData);

@DllImport("CRYPT32.dll")
BOOL CryptSetKeyIdentifierProperty(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwPropId, uint dwFlags, const(wchar)* pwszComputerName, void* pvReserved, const(void)* pvData);

@DllImport("CRYPT32.dll")
BOOL CryptEnumKeyIdentifierProperties(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwPropId, uint dwFlags, const(wchar)* pwszComputerName, void* pvReserved, void* pvArg, PFN_CRYPT_ENUM_KEYID_PROP pfnEnum);

@DllImport("CRYPT32.dll")
BOOL CryptCreateKeyIdentifierFromCSP(uint dwCertEncodingType, const(char)* pszPubKeyOID, char* pPubKeyStruc, uint cbPubKeyStruc, uint dwFlags, void* pvReserved, char* pbHash, uint* pcbHash);

@DllImport("CRYPT32.dll")
BOOL CertCreateCertificateChainEngine(CERT_CHAIN_ENGINE_CONFIG* pConfig, HCERTCHAINENGINE* phChainEngine);

@DllImport("CRYPT32.dll")
void CertFreeCertificateChainEngine(HCERTCHAINENGINE hChainEngine);

@DllImport("CRYPT32.dll")
BOOL CertResyncCertificateChainEngine(HCERTCHAINENGINE hChainEngine);

@DllImport("CRYPT32.dll")
BOOL CertGetCertificateChain(HCERTCHAINENGINE hChainEngine, CERT_CONTEXT* pCertContext, FILETIME* pTime, void* hAdditionalStore, CERT_CHAIN_PARA* pChainPara, uint dwFlags, void* pvReserved, CERT_CHAIN_CONTEXT** ppChainContext);

@DllImport("CRYPT32.dll")
void CertFreeCertificateChain(CERT_CHAIN_CONTEXT* pChainContext);

@DllImport("CRYPT32.dll")
CERT_CHAIN_CONTEXT* CertDuplicateCertificateChain(CERT_CHAIN_CONTEXT* pChainContext);

@DllImport("CRYPT32.dll")
CERT_CHAIN_CONTEXT* CertFindChainInStore(void* hCertStore, uint dwCertEncodingType, uint dwFindFlags, uint dwFindType, const(void)* pvFindPara, CERT_CHAIN_CONTEXT* pPrevChainContext);

@DllImport("CRYPT32.dll")
BOOL CertVerifyCertificateChainPolicy(const(char)* pszPolicyOID, CERT_CHAIN_CONTEXT* pChainContext, CERT_CHAIN_POLICY_PARA* pPolicyPara, CERT_CHAIN_POLICY_STATUS* pPolicyStatus);

@DllImport("CRYPT32.dll")
BOOL CryptStringToBinaryA(const(char)* pszString, uint cchString, uint dwFlags, char* pbBinary, uint* pcbBinary, uint* pdwSkip, uint* pdwFlags);

@DllImport("CRYPT32.dll")
BOOL CryptStringToBinaryW(const(wchar)* pszString, uint cchString, uint dwFlags, char* pbBinary, uint* pcbBinary, uint* pdwSkip, uint* pdwFlags);

@DllImport("CRYPT32.dll")
BOOL CryptBinaryToStringA(char* pbBinary, uint cbBinary, uint dwFlags, const(char)* pszString, uint* pcchString);

@DllImport("CRYPT32.dll")
BOOL CryptBinaryToStringW(char* pbBinary, uint cbBinary, uint dwFlags, const(wchar)* pszString, uint* pcchString);

@DllImport("CRYPT32.dll")
void* PFXImportCertStore(CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL PFXIsPFXBlob(CRYPTOAPI_BLOB* pPFX);

@DllImport("CRYPT32.dll")
BOOL PFXVerifyPassword(CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL PFXExportCertStoreEx(void* hStore, CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, void* pvPara, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL PFXExportCertStore(void* hStore, CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, uint dwFlags);

@DllImport("CRYPT32.dll")
void* CertOpenServerOcspResponse(CERT_CHAIN_CONTEXT* pChainContext, uint dwFlags, CERT_SERVER_OCSP_RESPONSE_OPEN_PARA* pOpenPara);

@DllImport("CRYPT32.dll")
void CertAddRefServerOcspResponse(void* hServerOcspResponse);

@DllImport("CRYPT32.dll")
void CertCloseServerOcspResponse(void* hServerOcspResponse, uint dwFlags);

@DllImport("CRYPT32.dll")
CERT_SERVER_OCSP_RESPONSE_CONTEXT* CertGetServerOcspResponseContext(void* hServerOcspResponse, uint dwFlags, void* pvReserved);

@DllImport("CRYPT32.dll")
void CertAddRefServerOcspResponseContext(CERT_SERVER_OCSP_RESPONSE_CONTEXT* pServerOcspResponseContext);

@DllImport("CRYPT32.dll")
void CertFreeServerOcspResponseContext(CERT_SERVER_OCSP_RESPONSE_CONTEXT* pServerOcspResponseContext);

@DllImport("CRYPT32.dll")
BOOL CertRetrieveLogoOrBiometricInfo(CERT_CONTEXT* pCertContext, const(char)* lpszLogoOrBiometricType, uint dwRetrievalFlags, uint dwTimeout, uint dwFlags, void* pvReserved, ubyte** ppbData, uint* pcbData, ushort** ppwszMimeType);

@DllImport("CRYPT32.dll")
BOOL CertSelectCertificateChains(Guid* pSelectionContext, uint dwFlags, CERT_SELECT_CHAIN_PARA* pChainParameters, uint cCriteria, char* rgpCriteria, void* hStore, uint* pcSelection, CERT_CHAIN_CONTEXT*** pprgpSelection);

@DllImport("CRYPT32.dll")
void CertFreeCertificateChainList(CERT_CHAIN_CONTEXT** prgpSelection);

@DllImport("CRYPT32.dll")
BOOL CryptRetrieveTimeStamp(const(wchar)* wszUrl, uint dwRetrievalFlags, uint dwTimeout, const(char)* pszHashId, const(CRYPT_TIMESTAMP_PARA)* pPara, char* pbData, uint cbData, CRYPT_TIMESTAMP_CONTEXT** ppTsContext, CERT_CONTEXT** ppTsSigner, void** phStore);

@DllImport("CRYPT32.dll")
BOOL CryptVerifyTimeStampSignature(char* pbTSContentInfo, uint cbTSContentInfo, char* pbData, uint cbData, void* hAdditionalStore, CRYPT_TIMESTAMP_CONTEXT** ppTsContext, CERT_CONTEXT** ppTsSigner, void** phStore);

@DllImport("CRYPT32.dll")
BOOL CertIsWeakHash(uint dwHashUseType, const(wchar)* pwszCNGHashAlgid, uint dwChainFlags, CERT_CHAIN_CONTEXT* pSignerChainContext, FILETIME* pTimeStamp, const(wchar)* pwszFileName);

@DllImport("CRYPT32.dll")
BOOL CryptProtectData(CRYPTOAPI_BLOB* pDataIn, const(wchar)* szDataDescr, CRYPTOAPI_BLOB* pOptionalEntropy, void* pvReserved, CRYPTPROTECT_PROMPTSTRUCT* pPromptStruct, uint dwFlags, CRYPTOAPI_BLOB* pDataOut);

@DllImport("CRYPT32.dll")
BOOL CryptUnprotectData(CRYPTOAPI_BLOB* pDataIn, ushort** ppszDataDescr, CRYPTOAPI_BLOB* pOptionalEntropy, void* pvReserved, CRYPTPROTECT_PROMPTSTRUCT* pPromptStruct, uint dwFlags, CRYPTOAPI_BLOB* pDataOut);

@DllImport("CRYPT32.dll")
BOOL CryptUpdateProtectedState(void* pOldSid, const(wchar)* pwszOldPassword, uint dwFlags, uint* pdwSuccessCount, uint* pdwFailureCount);

@DllImport("CRYPT32.dll")
BOOL CryptProtectMemory(void* pDataIn, uint cbDataIn, uint dwFlags);

@DllImport("CRYPT32.dll")
BOOL CryptUnprotectMemory(void* pDataIn, uint cbDataIn, uint dwFlags);

@DllImport("WinSCard.dll")
int SCardEstablishContext(uint dwScope, void* pvReserved1, void* pvReserved2, uint* phContext);

@DllImport("WinSCard.dll")
int SCardReleaseContext(uint hContext);

@DllImport("WinSCard.dll")
int SCardIsValidContext(uint hContext);

@DllImport("WinSCard.dll")
int SCardListReaderGroupsA(uint hContext, const(char)* mszGroups, uint* pcchGroups);

@DllImport("WinSCard.dll")
int SCardListReaderGroupsW(uint hContext, const(wchar)* mszGroups, uint* pcchGroups);

@DllImport("WinSCard.dll")
int SCardListReadersA(uint hContext, const(char)* mszGroups, const(char)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard.dll")
int SCardListReadersW(uint hContext, const(wchar)* mszGroups, const(wchar)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard.dll")
int SCardListCardsA(uint hContext, ubyte* pbAtr, char* rgquidInterfaces, uint cguidInterfaceCount, char* mszCards, uint* pcchCards);

@DllImport("WinSCard.dll")
int SCardListCardsW(uint hContext, ubyte* pbAtr, char* rgquidInterfaces, uint cguidInterfaceCount, char* mszCards, uint* pcchCards);

@DllImport("WinSCard.dll")
int SCardListInterfacesA(uint hContext, const(char)* szCard, Guid* pguidInterfaces, uint* pcguidInterfaces);

@DllImport("WinSCard.dll")
int SCardListInterfacesW(uint hContext, const(wchar)* szCard, Guid* pguidInterfaces, uint* pcguidInterfaces);

@DllImport("WinSCard.dll")
int SCardGetProviderIdA(uint hContext, const(char)* szCard, Guid* pguidProviderId);

@DllImport("WinSCard.dll")
int SCardGetProviderIdW(uint hContext, const(wchar)* szCard, Guid* pguidProviderId);

@DllImport("WinSCard.dll")
int SCardGetCardTypeProviderNameA(uint hContext, const(char)* szCardName, uint dwProviderId, char* szProvider, uint* pcchProvider);

@DllImport("WinSCard.dll")
int SCardGetCardTypeProviderNameW(uint hContext, const(wchar)* szCardName, uint dwProviderId, char* szProvider, uint* pcchProvider);

@DllImport("WinSCard.dll")
int SCardIntroduceReaderGroupA(uint hContext, const(char)* szGroupName);

@DllImport("WinSCard.dll")
int SCardIntroduceReaderGroupW(uint hContext, const(wchar)* szGroupName);

@DllImport("WinSCard.dll")
int SCardForgetReaderGroupA(uint hContext, const(char)* szGroupName);

@DllImport("WinSCard.dll")
int SCardForgetReaderGroupW(uint hContext, const(wchar)* szGroupName);

@DllImport("WinSCard.dll")
int SCardIntroduceReaderA(uint hContext, const(char)* szReaderName, const(char)* szDeviceName);

@DllImport("WinSCard.dll")
int SCardIntroduceReaderW(uint hContext, const(wchar)* szReaderName, const(wchar)* szDeviceName);

@DllImport("WinSCard.dll")
int SCardForgetReaderA(uint hContext, const(char)* szReaderName);

@DllImport("WinSCard.dll")
int SCardForgetReaderW(uint hContext, const(wchar)* szReaderName);

@DllImport("WinSCard.dll")
int SCardAddReaderToGroupA(uint hContext, const(char)* szReaderName, const(char)* szGroupName);

@DllImport("WinSCard.dll")
int SCardAddReaderToGroupW(uint hContext, const(wchar)* szReaderName, const(wchar)* szGroupName);

@DllImport("WinSCard.dll")
int SCardRemoveReaderFromGroupA(uint hContext, const(char)* szReaderName, const(char)* szGroupName);

@DllImport("WinSCard.dll")
int SCardRemoveReaderFromGroupW(uint hContext, const(wchar)* szReaderName, const(wchar)* szGroupName);

@DllImport("WinSCard.dll")
int SCardIntroduceCardTypeA(uint hContext, const(char)* szCardName, Guid* pguidPrimaryProvider, Guid* rgguidInterfaces, uint dwInterfaceCount, ubyte* pbAtr, ubyte* pbAtrMask, uint cbAtrLen);

@DllImport("WinSCard.dll")
int SCardIntroduceCardTypeW(uint hContext, const(wchar)* szCardName, Guid* pguidPrimaryProvider, Guid* rgguidInterfaces, uint dwInterfaceCount, ubyte* pbAtr, ubyte* pbAtrMask, uint cbAtrLen);

@DllImport("WinSCard.dll")
int SCardSetCardTypeProviderNameA(uint hContext, const(char)* szCardName, uint dwProviderId, const(char)* szProvider);

@DllImport("WinSCard.dll")
int SCardSetCardTypeProviderNameW(uint hContext, const(wchar)* szCardName, uint dwProviderId, const(wchar)* szProvider);

@DllImport("WinSCard.dll")
int SCardForgetCardTypeA(uint hContext, const(char)* szCardName);

@DllImport("WinSCard.dll")
int SCardForgetCardTypeW(uint hContext, const(wchar)* szCardName);

@DllImport("WinSCard.dll")
int SCardFreeMemory(uint hContext, void* pvMem);

@DllImport("WinSCard.dll")
HANDLE SCardAccessStartedEvent();

@DllImport("WinSCard.dll")
void SCardReleaseStartedEvent();

@DllImport("WinSCard.dll")
int SCardLocateCardsA(uint hContext, const(char)* mszCards, SCARD_READERSTATEA* rgReaderStates, uint cReaders);

@DllImport("WinSCard.dll")
int SCardLocateCardsW(uint hContext, const(wchar)* mszCards, SCARD_READERSTATEW* rgReaderStates, uint cReaders);

@DllImport("WinSCard.dll")
int SCardLocateCardsByATRA(uint hContext, SCARD_ATRMASK* rgAtrMasks, uint cAtrs, SCARD_READERSTATEA* rgReaderStates, uint cReaders);

@DllImport("WinSCard.dll")
int SCardLocateCardsByATRW(uint hContext, SCARD_ATRMASK* rgAtrMasks, uint cAtrs, SCARD_READERSTATEW* rgReaderStates, uint cReaders);

@DllImport("WinSCard.dll")
int SCardGetStatusChangeA(uint hContext, uint dwTimeout, SCARD_READERSTATEA* rgReaderStates, uint cReaders);

@DllImport("WinSCard.dll")
int SCardGetStatusChangeW(uint hContext, uint dwTimeout, SCARD_READERSTATEW* rgReaderStates, uint cReaders);

@DllImport("WinSCard.dll")
int SCardCancel(uint hContext);

@DllImport("WinSCard.dll")
int SCardConnectA(uint hContext, const(char)* szReader, uint dwShareMode, uint dwPreferredProtocols, uint* phCard, uint* pdwActiveProtocol);

@DllImport("WinSCard.dll")
int SCardConnectW(uint hContext, const(wchar)* szReader, uint dwShareMode, uint dwPreferredProtocols, uint* phCard, uint* pdwActiveProtocol);

@DllImport("WinSCard.dll")
int SCardReconnect(uint hCard, uint dwShareMode, uint dwPreferredProtocols, uint dwInitialization, uint* pdwActiveProtocol);

@DllImport("WinSCard.dll")
int SCardDisconnect(uint hCard, uint dwDisposition);

@DllImport("WinSCard.dll")
int SCardBeginTransaction(uint hCard);

@DllImport("WinSCard.dll")
int SCardEndTransaction(uint hCard, uint dwDisposition);

@DllImport("WinSCard.dll")
int SCardState(uint hCard, uint* pdwState, uint* pdwProtocol, char* pbAtr, uint* pcbAtrLen);

@DllImport("WinSCard.dll")
int SCardStatusA(uint hCard, const(char)* mszReaderNames, uint* pcchReaderLen, uint* pdwState, uint* pdwProtocol, char* pbAtr, uint* pcbAtrLen);

@DllImport("WinSCard.dll")
int SCardStatusW(uint hCard, const(wchar)* mszReaderNames, uint* pcchReaderLen, uint* pdwState, uint* pdwProtocol, char* pbAtr, uint* pcbAtrLen);

@DllImport("WinSCard.dll")
int SCardTransmit(uint hCard, SCARD_IO_REQUEST* pioSendPci, char* pbSendBuffer, uint cbSendLength, SCARD_IO_REQUEST* pioRecvPci, char* pbRecvBuffer, uint* pcbRecvLength);

@DllImport("WinSCard.dll")
int SCardGetTransmitCount(uint hCard, uint* pcTransmitCount);

@DllImport("WinSCard.dll")
int SCardControl(uint hCard, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("WinSCard.dll")
int SCardGetAttrib(uint hCard, uint dwAttrId, char* pbAttr, uint* pcbAttrLen);

@DllImport("WinSCard.dll")
int SCardSetAttrib(uint hCard, uint dwAttrId, char* pbAttr, uint cbAttrLen);

@DllImport("SCARDDLG.dll")
int SCardUIDlgSelectCardA(OPENCARDNAME_EXA* param0);

@DllImport("SCARDDLG.dll")
int SCardUIDlgSelectCardW(OPENCARDNAME_EXW* param0);

@DllImport("SCARDDLG.dll")
int GetOpenCardNameA(OPENCARDNAMEA* param0);

@DllImport("SCARDDLG.dll")
int GetOpenCardNameW(OPENCARDNAMEW* param0);

@DllImport("SCARDDLG.dll")
int SCardDlgExtendedError();

@DllImport("WinSCard.dll")
int SCardReadCacheA(uint hContext, Guid* CardIdentifier, uint FreshnessCounter, const(char)* LookupName, char* Data, uint* DataLen);

@DllImport("WinSCard.dll")
int SCardReadCacheW(uint hContext, Guid* CardIdentifier, uint FreshnessCounter, const(wchar)* LookupName, char* Data, uint* DataLen);

@DllImport("WinSCard.dll")
int SCardWriteCacheA(uint hContext, Guid* CardIdentifier, uint FreshnessCounter, const(char)* LookupName, char* Data, uint DataLen);

@DllImport("WinSCard.dll")
int SCardWriteCacheW(uint hContext, Guid* CardIdentifier, uint FreshnessCounter, const(wchar)* LookupName, char* Data, uint DataLen);

@DllImport("WinSCard.dll")
int SCardGetReaderIconA(uint hContext, const(char)* szReaderName, char* pbIcon, uint* pcbIcon);

@DllImport("WinSCard.dll")
int SCardGetReaderIconW(uint hContext, const(wchar)* szReaderName, char* pbIcon, uint* pcbIcon);

@DllImport("WinSCard.dll")
int SCardGetDeviceTypeIdA(uint hContext, const(char)* szReaderName, uint* pdwDeviceTypeId);

@DllImport("WinSCard.dll")
int SCardGetDeviceTypeIdW(uint hContext, const(wchar)* szReaderName, uint* pdwDeviceTypeId);

@DllImport("WinSCard.dll")
int SCardGetReaderDeviceInstanceIdA(uint hContext, const(char)* szReaderName, const(char)* szDeviceInstanceId, uint* pcchDeviceInstanceId);

@DllImport("WinSCard.dll")
int SCardGetReaderDeviceInstanceIdW(uint hContext, const(wchar)* szReaderName, const(wchar)* szDeviceInstanceId, uint* pcchDeviceInstanceId);

@DllImport("WinSCard.dll")
int SCardListReadersWithDeviceInstanceIdA(uint hContext, const(char)* szDeviceInstanceId, const(char)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard.dll")
int SCardListReadersWithDeviceInstanceIdW(uint hContext, const(wchar)* szDeviceInstanceId, const(wchar)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard.dll")
int SCardAudit(uint hContext, uint dwEvent);

@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfig2A(SC_HANDLE__* hService, uint dwInfoLevel, void* lpInfo);

@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfig2W(SC_HANDLE__* hService, uint dwInfoLevel, void* lpInfo);

@DllImport("ADVAPI32.dll")
BOOL CloseServiceHandle(SC_HANDLE__* hSCObject);

@DllImport("ADVAPI32.dll")
BOOL ControlService(SC_HANDLE__* hService, uint dwControl, SERVICE_STATUS* lpServiceStatus);

@DllImport("ADVAPI32.dll")
BOOL DeleteService(SC_HANDLE__* hService);

@DllImport("ADVAPI32.dll")
BOOL EnumDependentServicesA(SC_HANDLE__* hService, uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned);

@DllImport("ADVAPI32.dll")
BOOL EnumDependentServicesW(SC_HANDLE__* hService, uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned);

@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusA(SC_HANDLE__* hSCManager, uint dwServiceType, uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusW(SC_HANDLE__* hSCManager, uint dwServiceType, uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusExA(SC_HANDLE__* hSCManager, SC_ENUM_TYPE InfoLevel, uint dwServiceType, uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle, const(char)* pszGroupName);

@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusExW(SC_HANDLE__* hSCManager, SC_ENUM_TYPE InfoLevel, uint dwServiceType, uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle, const(wchar)* pszGroupName);

@DllImport("ADVAPI32.dll")
BOOL GetServiceKeyNameA(SC_HANDLE__* hSCManager, const(char)* lpDisplayName, const(char)* lpServiceName, uint* lpcchBuffer);

@DllImport("ADVAPI32.dll")
BOOL GetServiceKeyNameW(SC_HANDLE__* hSCManager, const(wchar)* lpDisplayName, const(wchar)* lpServiceName, uint* lpcchBuffer);

@DllImport("ADVAPI32.dll")
BOOL GetServiceDisplayNameA(SC_HANDLE__* hSCManager, const(char)* lpServiceName, const(char)* lpDisplayName, uint* lpcchBuffer);

@DllImport("ADVAPI32.dll")
BOOL GetServiceDisplayNameW(SC_HANDLE__* hSCManager, const(wchar)* lpServiceName, const(wchar)* lpDisplayName, uint* lpcchBuffer);

@DllImport("ADVAPI32.dll")
void* LockServiceDatabase(SC_HANDLE__* hSCManager);

@DllImport("ADVAPI32.dll")
BOOL NotifyBootConfigStatus(BOOL BootAcceptable);

@DllImport("ADVAPI32.dll")
SC_HANDLE__* OpenSCManagerA(const(char)* lpMachineName, const(char)* lpDatabaseName, uint dwDesiredAccess);

@DllImport("ADVAPI32.dll")
SC_HANDLE__* OpenSCManagerW(const(wchar)* lpMachineName, const(wchar)* lpDatabaseName, uint dwDesiredAccess);

@DllImport("ADVAPI32.dll")
SC_HANDLE__* OpenServiceA(SC_HANDLE__* hSCManager, const(char)* lpServiceName, uint dwDesiredAccess);

@DllImport("ADVAPI32.dll")
SC_HANDLE__* OpenServiceW(SC_HANDLE__* hSCManager, const(wchar)* lpServiceName, uint dwDesiredAccess);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfigA(SC_HANDLE__* hService, char* lpServiceConfig, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfigW(SC_HANDLE__* hService, char* lpServiceConfig, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfig2A(SC_HANDLE__* hService, uint dwInfoLevel, char* lpBuffer, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfig2W(SC_HANDLE__* hService, uint dwInfoLevel, char* lpBuffer, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceLockStatusA(SC_HANDLE__* hSCManager, char* lpLockStatus, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceLockStatusW(SC_HANDLE__* hSCManager, char* lpLockStatus, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceObjectSecurity(SC_HANDLE__* hService, uint dwSecurityInformation, char* lpSecurityDescriptor, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceStatus(SC_HANDLE__* hService, SERVICE_STATUS* lpServiceStatus);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceStatusEx(SC_HANDLE__* hService, SC_STATUS_TYPE InfoLevel, char* lpBuffer, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerA(const(char)* lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerW(const(wchar)* lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerExA(const(char)* lpServiceName, LPHANDLER_FUNCTION_EX lpHandlerProc, void* lpContext);

@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerExW(const(wchar)* lpServiceName, LPHANDLER_FUNCTION_EX lpHandlerProc, void* lpContext);

@DllImport("ADVAPI32.dll")
BOOL SetServiceObjectSecurity(SC_HANDLE__* hService, uint dwSecurityInformation, void* lpSecurityDescriptor);

@DllImport("ADVAPI32.dll")
BOOL SetServiceStatus(SERVICE_STATUS_HANDLE__* hServiceStatus, SERVICE_STATUS* lpServiceStatus);

@DllImport("ADVAPI32.dll")
BOOL StartServiceCtrlDispatcherA(const(SERVICE_TABLE_ENTRYA)* lpServiceStartTable);

@DllImport("ADVAPI32.dll")
BOOL StartServiceCtrlDispatcherW(const(SERVICE_TABLE_ENTRYW)* lpServiceStartTable);

@DllImport("ADVAPI32.dll")
BOOL StartServiceA(SC_HANDLE__* hService, uint dwNumServiceArgs, char* lpServiceArgVectors);

@DllImport("ADVAPI32.dll")
BOOL StartServiceW(SC_HANDLE__* hService, uint dwNumServiceArgs, char* lpServiceArgVectors);

@DllImport("ADVAPI32.dll")
BOOL UnlockServiceDatabase(void* ScLock);

@DllImport("ADVAPI32.dll")
uint NotifyServiceStatusChangeA(SC_HANDLE__* hService, uint dwNotifyMask, SERVICE_NOTIFY_2A* pNotifyBuffer);

@DllImport("ADVAPI32.dll")
uint NotifyServiceStatusChangeW(SC_HANDLE__* hService, uint dwNotifyMask, SERVICE_NOTIFY_2W* pNotifyBuffer);

@DllImport("ADVAPI32.dll")
BOOL ControlServiceExA(SC_HANDLE__* hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

@DllImport("ADVAPI32.dll")
BOOL ControlServiceExW(SC_HANDLE__* hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

@DllImport("ADVAPI32.dll")
BOOL QueryServiceDynamicInformation(SERVICE_STATUS_HANDLE__* hServiceStatus, uint dwInfoLevel, void** ppDynamicInfo);

@DllImport("ADVAPI32.dll")
uint WaitServiceState(SC_HANDLE__* hService, uint dwNotify, uint dwTimeout, HANDLE hCancelEvent);

@DllImport("api-ms-win-service-core-l1-1-3.dll")
uint GetServiceRegistryStateKey(SERVICE_STATUS_HANDLE__* ServiceStatusHandle, SERVICE_REGISTRY_STATE_TYPE StateType, uint AccessMask, HKEY* ServiceStateKey);

@DllImport("api-ms-win-service-core-l1-1-4.dll")
uint GetServiceDirectory(SERVICE_STATUS_HANDLE__* hServiceStatus, SERVICE_DIRECTORY_TYPE eDirectoryType, const(wchar)* lpPathBuffer, uint cchPathBufferLength, uint* lpcchRequiredBufferLength);

@DllImport("SspiCli.dll")
NTSTATUS LsaRegisterLogonProcess(STRING* LogonProcessName, LsaHandle* LsaHandle, uint* SecurityMode);

@DllImport("SspiCli.dll")
NTSTATUS LsaLogonUser(HANDLE LsaHandle, STRING* OriginName, SECURITY_LOGON_TYPE LogonType, uint AuthenticationPackage, char* AuthenticationInformation, uint AuthenticationInformationLength, TOKEN_GROUPS* LocalGroups, TOKEN_SOURCE* SourceContext, void** ProfileBuffer, uint* ProfileBufferLength, LUID* LogonId, int* Token, QUOTA_LIMITS* Quotas, int* SubStatus);

@DllImport("SspiCli.dll")
NTSTATUS LsaLookupAuthenticationPackage(HANDLE LsaHandle, STRING* PackageName, uint* AuthenticationPackage);

@DllImport("SspiCli.dll")
NTSTATUS LsaFreeReturnBuffer(void* Buffer);

@DllImport("SspiCli.dll")
NTSTATUS LsaCallAuthenticationPackage(HANDLE LsaHandle, uint AuthenticationPackage, char* ProtocolSubmitBuffer, uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, int* ProtocolStatus);

@DllImport("SspiCli.dll")
NTSTATUS LsaDeregisterLogonProcess(HANDLE LsaHandle);

@DllImport("SspiCli.dll")
NTSTATUS LsaConnectUntrusted(int* LsaHandle);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaFreeMemory(void* Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaClose(void* ObjectHandle);

@DllImport("SspiCli.dll")
NTSTATUS LsaEnumerateLogonSessions(uint* LogonSessionCount, LUID** LogonSessionList);

@DllImport("SspiCli.dll")
NTSTATUS LsaGetLogonSessionData(LUID* LogonId, SECURITY_LOGON_SESSION_DATA** ppLogonSessionData);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaOpenPolicy(UNICODE_STRING* SystemName, OBJECT_ATTRIBUTES* ObjectAttributes, uint DesiredAccess, void** PolicyHandle);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetCAPs(char* CAPDNs, uint CAPDNCount, uint Flags);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaGetAppliedCAPIDs(UNICODE_STRING* SystemName, void*** CAPIDs, uint* CAPIDCount);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryCAPs(char* CAPIDs, uint CAPIDCount, CENTRAL_ACCESS_POLICY** CAPs, uint* CAPCount);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryInformationPolicy(void* PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, void** Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetInformationPolicy(void* PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, void* Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryDomainInformationPolicy(void* PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, void** Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetDomainInformationPolicy(void* PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, void* Buffer);

@DllImport("SspiCli.dll")
NTSTATUS LsaRegisterPolicyChangeNotification(POLICY_NOTIFICATION_INFORMATION_CLASS InformationClass, HANDLE NotificationEventHandle);

@DllImport("SspiCli.dll")
NTSTATUS LsaUnregisterPolicyChangeNotification(POLICY_NOTIFICATION_INFORMATION_CLASS InformationClass, HANDLE NotificationEventHandle);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateTrustedDomains(void* PolicyHandle, uint* EnumerationContext, void** Buffer, uint PreferedMaximumLength, uint* CountReturned);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupNames(void* PolicyHandle, uint Count, UNICODE_STRING* Names, LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_SID** Sids);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupNames2(void* PolicyHandle, uint Flags, uint Count, UNICODE_STRING* Names, LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_SID2** Sids);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupSids(void* PolicyHandle, uint Count, void** Sids, LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_NAME** Names);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupSids2(void* PolicyHandle, uint LookupOptions, uint Count, void** Sids, LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_NAME** Names);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateAccountsWithUserRight(void* PolicyHandle, UNICODE_STRING* UserRight, void** Buffer, uint* CountReturned);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateAccountRights(void* PolicyHandle, void* AccountSid, UNICODE_STRING** UserRights, uint* CountOfRights);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaAddAccountRights(void* PolicyHandle, void* AccountSid, char* UserRights, uint CountOfRights);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaRemoveAccountRights(void* PolicyHandle, void* AccountSid, ubyte AllRights, char* UserRights, uint CountOfRights);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaOpenTrustedDomainByName(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, uint DesiredAccess, void** TrustedDomainHandle);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryTrustedDomainInfo(void* PolicyHandle, void* TrustedDomainSid, TRUSTED_INFORMATION_CLASS InformationClass, void** Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetTrustedDomainInformation(void* PolicyHandle, void* TrustedDomainSid, TRUSTED_INFORMATION_CLASS InformationClass, void* Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaDeleteTrustedDomain(void* PolicyHandle, void* TrustedDomainSid);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryTrustedDomainInfoByName(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, TRUSTED_INFORMATION_CLASS InformationClass, void** Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetTrustedDomainInfoByName(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, TRUSTED_INFORMATION_CLASS InformationClass, void* Buffer);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateTrustedDomainsEx(void* PolicyHandle, uint* EnumerationContext, void** Buffer, uint PreferedMaximumLength, uint* CountReturned);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaCreateTrustedDomainEx(void* PolicyHandle, TRUSTED_DOMAIN_INFORMATION_EX* TrustedDomainInformation, TRUSTED_DOMAIN_AUTH_INFORMATION* AuthenticationInformation, uint DesiredAccess, void** TrustedDomainHandle);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryForestTrustInformation(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, LSA_FOREST_TRUST_INFORMATION** ForestTrustInfo);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetForestTrustInformation(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, LSA_FOREST_TRUST_INFORMATION* ForestTrustInfo, ubyte CheckOnly, LSA_FOREST_TRUST_COLLISION_INFORMATION** CollisionInfo);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaStorePrivateData(void* PolicyHandle, UNICODE_STRING* KeyName, UNICODE_STRING* PrivateData);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaRetrievePrivateData(void* PolicyHandle, UNICODE_STRING* KeyName, UNICODE_STRING** PrivateData);

@DllImport("ADVAPI32.dll")
uint LsaNtStatusToWinError(NTSTATUS Status);

@DllImport("ADVAPI32.dll")
ubyte SystemFunction036(char* RandomBuffer, uint RandomBufferLength);

@DllImport("ADVAPI32.dll")
NTSTATUS SystemFunction040(char* Memory, uint MemorySize, uint OptionFlags);

@DllImport("ADVAPI32.dll")
NTSTATUS SystemFunction041(char* Memory, uint MemorySize, uint OptionFlags);

@DllImport("ADVAPI32.dll")
ubyte AuditSetSystemPolicy(char* pAuditPolicy, uint dwPolicyCount);

@DllImport("ADVAPI32.dll")
ubyte AuditSetPerUserPolicy(const(void)* pSid, char* pAuditPolicy, uint dwPolicyCount);

@DllImport("ADVAPI32.dll")
ubyte AuditQuerySystemPolicy(char* pSubCategoryGuids, uint dwPolicyCount, AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32.dll")
ubyte AuditQueryPerUserPolicy(const(void)* pSid, char* pSubCategoryGuids, uint dwPolicyCount, AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32.dll")
ubyte AuditEnumeratePerUserPolicy(POLICY_AUDIT_SID_ARRAY** ppAuditSidArray);

@DllImport("ADVAPI32.dll")
ubyte AuditComputeEffectivePolicyBySid(const(void)* pSid, char* pSubCategoryGuids, uint dwPolicyCount, AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32.dll")
ubyte AuditComputeEffectivePolicyByToken(HANDLE hTokenHandle, char* pSubCategoryGuids, uint dwPolicyCount, AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32.dll")
ubyte AuditEnumerateCategories(Guid** ppAuditCategoriesArray, uint* pdwCountReturned);

@DllImport("ADVAPI32.dll")
ubyte AuditEnumerateSubCategories(const(Guid)* pAuditCategoryGuid, ubyte bRetrieveAllSubCategories, Guid** ppAuditSubCategoriesArray, uint* pdwCountReturned);

@DllImport("ADVAPI32.dll")
ubyte AuditLookupCategoryNameW(const(Guid)* pAuditCategoryGuid, ushort** ppszCategoryName);

@DllImport("ADVAPI32.dll")
ubyte AuditLookupCategoryNameA(const(Guid)* pAuditCategoryGuid, byte** ppszCategoryName);

@DllImport("ADVAPI32.dll")
ubyte AuditLookupSubCategoryNameW(const(Guid)* pAuditSubCategoryGuid, ushort** ppszSubCategoryName);

@DllImport("ADVAPI32.dll")
ubyte AuditLookupSubCategoryNameA(const(Guid)* pAuditSubCategoryGuid, byte** ppszSubCategoryName);

@DllImport("ADVAPI32.dll")
ubyte AuditLookupCategoryIdFromCategoryGuid(const(Guid)* pAuditCategoryGuid, POLICY_AUDIT_EVENT_TYPE* pAuditCategoryId);

@DllImport("ADVAPI32.dll")
ubyte AuditLookupCategoryGuidFromCategoryId(POLICY_AUDIT_EVENT_TYPE AuditCategoryId, Guid* pAuditCategoryGuid);

@DllImport("ADVAPI32.dll")
ubyte AuditSetSecurity(uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ADVAPI32.dll")
ubyte AuditQuerySecurity(uint SecurityInformation, void** ppSecurityDescriptor);

@DllImport("ADVAPI32.dll")
ubyte AuditSetGlobalSaclW(const(wchar)* ObjectTypeName, ACL* Acl);

@DllImport("ADVAPI32.dll")
ubyte AuditSetGlobalSaclA(const(char)* ObjectTypeName, ACL* Acl);

@DllImport("ADVAPI32.dll")
ubyte AuditQueryGlobalSaclW(const(wchar)* ObjectTypeName, ACL** Acl);

@DllImport("ADVAPI32.dll")
ubyte AuditQueryGlobalSaclA(const(char)* ObjectTypeName, ACL** Acl);

@DllImport("ADVAPI32.dll")
void AuditFree(void* Buffer);

@DllImport("SspiCli.dll")
int AcquireCredentialsHandleW(const(wchar)* pszPrincipal, const(wchar)* pszPackage, uint fCredentialUse, void* pvLogonId, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, SecHandle* phCredential, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int AcquireCredentialsHandleA(const(char)* pszPrincipal, const(char)* pszPackage, uint fCredentialUse, void* pvLogonId, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, SecHandle* phCredential, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int FreeCredentialsHandle(SecHandle* phCredential);

@DllImport("SspiCli.dll")
int AddCredentialsW(SecHandle* hCredentials, const(wchar)* pszPrincipal, const(wchar)* pszPackage, uint fCredentialUse, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int AddCredentialsA(SecHandle* hCredentials, const(char)* pszPrincipal, const(char)* pszPackage, uint fCredentialUse, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int ChangeAccountPasswordW(ushort* pszPackageName, ushort* pszDomainName, ushort* pszAccountName, ushort* pszOldPassword, ushort* pszNewPassword, ubyte bImpersonating, uint dwReserved, SecBufferDesc* pOutput);

@DllImport("SspiCli.dll")
int ChangeAccountPasswordA(byte* pszPackageName, byte* pszDomainName, byte* pszAccountName, byte* pszOldPassword, byte* pszNewPassword, ubyte bImpersonating, uint dwReserved, SecBufferDesc* pOutput);

@DllImport("SspiCli.dll")
int InitializeSecurityContextW(SecHandle* phCredential, SecHandle* phContext, ushort* pszTargetName, uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int InitializeSecurityContextA(SecHandle* phCredential, SecHandle* phContext, byte* pszTargetName, uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int AcceptSecurityContext(SecHandle* phCredential, SecHandle* phContext, SecBufferDesc* pInput, uint fContextReq, uint TargetDataRep, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int CompleteAuthToken(SecHandle* phContext, SecBufferDesc* pToken);

@DllImport("SspiCli.dll")
int ImpersonateSecurityContext(SecHandle* phContext);

@DllImport("SspiCli.dll")
int RevertSecurityContext(SecHandle* phContext);

@DllImport("SspiCli.dll")
int QuerySecurityContextToken(SecHandle* phContext, void** Token);

@DllImport("SspiCli.dll")
int DeleteSecurityContext(SecHandle* phContext);

@DllImport("SspiCli.dll")
int ApplyControlToken(SecHandle* phContext, SecBufferDesc* pInput);

@DllImport("SspiCli.dll")
int QueryContextAttributesW(SecHandle* phContext, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli.dll")
int QueryContextAttributesExW(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int QueryContextAttributesA(SecHandle* phContext, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli.dll")
int QueryContextAttributesExA(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int SetContextAttributesW(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int SetContextAttributesA(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int QueryCredentialsAttributesW(SecHandle* phCredential, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli.dll")
int QueryCredentialsAttributesExW(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int QueryCredentialsAttributesA(SecHandle* phCredential, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli.dll")
int QueryCredentialsAttributesExA(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int SetCredentialsAttributesW(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int SetCredentialsAttributesA(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli.dll")
int FreeContextBuffer(void* pvContextBuffer);

@DllImport("SspiCli.dll")
int MakeSignature(SecHandle* phContext, uint fQOP, SecBufferDesc* pMessage, uint MessageSeqNo);

@DllImport("SspiCli.dll")
int VerifySignature(SecHandle* phContext, SecBufferDesc* pMessage, uint MessageSeqNo, uint* pfQOP);

@DllImport("SspiCli.dll")
int EncryptMessage(SecHandle* phContext, uint fQOP, SecBufferDesc* pMessage, uint MessageSeqNo);

@DllImport("SspiCli.dll")
int DecryptMessage(SecHandle* phContext, SecBufferDesc* pMessage, uint MessageSeqNo, uint* pfQOP);

@DllImport("SspiCli.dll")
int EnumerateSecurityPackagesW(uint* pcPackages, SecPkgInfoW** ppPackageInfo);

@DllImport("SspiCli.dll")
int EnumerateSecurityPackagesA(uint* pcPackages, SecPkgInfoA** ppPackageInfo);

@DllImport("SspiCli.dll")
int QuerySecurityPackageInfoW(const(wchar)* pszPackageName, SecPkgInfoW** ppPackageInfo);

@DllImport("SspiCli.dll")
int QuerySecurityPackageInfoA(const(char)* pszPackageName, SecPkgInfoA** ppPackageInfo);

@DllImport("SspiCli.dll")
int ExportSecurityContext(SecHandle* phContext, uint fFlags, SecBuffer* pPackedContext, void** pToken);

@DllImport("SspiCli.dll")
int ImportSecurityContextW(const(wchar)* pszPackage, SecBuffer* pPackedContext, void* Token, SecHandle* phContext);

@DllImport("SspiCli.dll")
int ImportSecurityContextA(const(char)* pszPackage, SecBuffer* pPackedContext, void* Token, SecHandle* phContext);

@DllImport("SspiCli.dll")
SecurityFunctionTableA* InitSecurityInterfaceA();

@DllImport("SspiCli.dll")
SecurityFunctionTableW* InitSecurityInterfaceW();

@DllImport("SspiCli.dll")
int SaslEnumerateProfilesA(byte** ProfileList, uint* ProfileCount);

@DllImport("SspiCli.dll")
int SaslEnumerateProfilesW(ushort** ProfileList, uint* ProfileCount);

@DllImport("SspiCli.dll")
int SaslGetProfilePackageA(const(char)* ProfileName, SecPkgInfoA** PackageInfo);

@DllImport("SspiCli.dll")
int SaslGetProfilePackageW(const(wchar)* ProfileName, SecPkgInfoW** PackageInfo);

@DllImport("SspiCli.dll")
int SaslIdentifyPackageA(SecBufferDesc* pInput, SecPkgInfoA** PackageInfo);

@DllImport("SspiCli.dll")
int SaslIdentifyPackageW(SecBufferDesc* pInput, SecPkgInfoW** PackageInfo);

@DllImport("SspiCli.dll")
int SaslInitializeSecurityContextW(SecHandle* phCredential, SecHandle* phContext, const(wchar)* pszTargetName, uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int SaslInitializeSecurityContextA(SecHandle* phCredential, SecHandle* phContext, const(char)* pszTargetName, uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int SaslAcceptSecurityContext(SecHandle* phCredential, SecHandle* phContext, SecBufferDesc* pInput, uint fContextReq, uint TargetDataRep, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli.dll")
int SaslSetContextOption(SecHandle* ContextHandle, uint Option, void* Value, uint Size);

@DllImport("SspiCli.dll")
int SaslGetContextOption(SecHandle* ContextHandle, uint Option, void* Value, uint Size, uint* Needed);

@DllImport("credui.dll")
uint SspiPromptForCredentialsW(const(wchar)* pszTargetName, void* pUiInfo, uint dwAuthError, const(wchar)* pszPackage, void* pInputAuthIdentity, void** ppAuthIdentity, int* pfSave, uint dwFlags);

@DllImport("credui.dll")
uint SspiPromptForCredentialsA(const(char)* pszTargetName, void* pUiInfo, uint dwAuthError, const(char)* pszPackage, void* pInputAuthIdentity, void** ppAuthIdentity, int* pfSave, uint dwFlags);

@DllImport("SspiCli.dll")
int SspiPrepareForCredRead(void* AuthIdentity, const(wchar)* pszTargetName, uint* pCredmanCredentialType, ushort** ppszCredmanTargetName);

@DllImport("SspiCli.dll")
int SspiPrepareForCredWrite(void* AuthIdentity, const(wchar)* pszTargetName, uint* pCredmanCredentialType, ushort** ppszCredmanTargetName, ushort** ppszCredmanUserName, ubyte** ppCredentialBlob, uint* pCredentialBlobSize);

@DllImport("SspiCli.dll")
int SspiEncryptAuthIdentity(void* AuthData);

@DllImport("SspiCli.dll")
int SspiEncryptAuthIdentityEx(uint Options, void* AuthData);

@DllImport("SspiCli.dll")
int SspiDecryptAuthIdentity(void* EncryptedAuthData);

@DllImport("SspiCli.dll")
int SspiDecryptAuthIdentityEx(uint Options, void* EncryptedAuthData);

@DllImport("SspiCli.dll")
ubyte SspiIsAuthIdentityEncrypted(void* EncryptedAuthData);

@DllImport("SspiCli.dll")
int SspiEncodeAuthIdentityAsStrings(void* pAuthIdentity, ushort** ppszUserName, ushort** ppszDomainName, ushort** ppszPackedCredentialsString);

@DllImport("SspiCli.dll")
int SspiValidateAuthIdentity(void* AuthData);

@DllImport("SspiCli.dll")
int SspiCopyAuthIdentity(void* AuthData, void** AuthDataCopy);

@DllImport("SspiCli.dll")
void SspiFreeAuthIdentity(void* AuthData);

@DllImport("SspiCli.dll")
void SspiZeroAuthIdentity(void* AuthData);

@DllImport("SspiCli.dll")
void SspiLocalFree(void* DataBuffer);

@DllImport("SspiCli.dll")
int SspiEncodeStringsAsAuthIdentity(const(wchar)* pszUserName, const(wchar)* pszDomainName, const(wchar)* pszPackedCredentialsString, void** ppAuthIdentity);

@DllImport("SspiCli.dll")
int SspiCompareAuthIdentities(void* AuthIdentity1, void* AuthIdentity2, ubyte* SameSuppliedUser, ubyte* SameSuppliedIdentity);

@DllImport("SspiCli.dll")
int SspiMarshalAuthIdentity(void* AuthIdentity, uint* AuthIdentityLength, byte** AuthIdentityByteArray);

@DllImport("SspiCli.dll")
int SspiUnmarshalAuthIdentity(uint AuthIdentityLength, char* AuthIdentityByteArray, void** ppAuthIdentity);

@DllImport("credui.dll")
ubyte SspiIsPromptingNeeded(uint ErrorOrNtStatus);

@DllImport("SspiCli.dll")
int SspiGetTargetHostName(const(wchar)* pszTargetName, ushort** pszHostName);

@DllImport("SspiCli.dll")
int SspiExcludePackage(void* AuthIdentity, const(wchar)* pszPackageName, void** ppNewAuthIdentity);

@DllImport("SspiCli.dll")
int AddSecurityPackageA(const(char)* pszPackageName, SECURITY_PACKAGE_OPTIONS* pOptions);

@DllImport("SspiCli.dll")
int AddSecurityPackageW(const(wchar)* pszPackageName, SECURITY_PACKAGE_OPTIONS* pOptions);

@DllImport("SspiCli.dll")
int DeleteSecurityPackageA(const(char)* pszPackageName);

@DllImport("SspiCli.dll")
int DeleteSecurityPackageW(const(wchar)* pszPackageName);

@DllImport("ADVAPI32.dll")
BOOL CredWriteW(CREDENTIALW* Credential, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredWriteA(CREDENTIALA* Credential, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredReadW(const(wchar)* TargetName, uint Type, uint Flags, CREDENTIALW** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredReadA(const(char)* TargetName, uint Type, uint Flags, CREDENTIALA** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredEnumerateW(const(wchar)* Filter, uint Flags, uint* Count, CREDENTIALW*** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredEnumerateA(const(char)* Filter, uint Flags, uint* Count, CREDENTIALA*** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredWriteDomainCredentialsW(CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, CREDENTIALW* Credential, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredWriteDomainCredentialsA(CREDENTIAL_TARGET_INFORMATIONA* TargetInfo, CREDENTIALA* Credential, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredReadDomainCredentialsW(CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, uint Flags, uint* Count, CREDENTIALW*** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredReadDomainCredentialsA(CREDENTIAL_TARGET_INFORMATIONA* TargetInfo, uint Flags, uint* Count, CREDENTIALA*** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredDeleteW(const(wchar)* TargetName, uint Type, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredDeleteA(const(char)* TargetName, uint Type, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredRenameW(const(wchar)* OldTargetName, const(wchar)* NewTargetName, uint Type, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredRenameA(const(char)* OldTargetName, const(char)* NewTargetName, uint Type, uint Flags);

@DllImport("ADVAPI32.dll")
BOOL CredGetTargetInfoW(const(wchar)* TargetName, uint Flags, CREDENTIAL_TARGET_INFORMATIONW** TargetInfo);

@DllImport("ADVAPI32.dll")
BOOL CredGetTargetInfoA(const(char)* TargetName, uint Flags, CREDENTIAL_TARGET_INFORMATIONA** TargetInfo);

@DllImport("ADVAPI32.dll")
BOOL CredMarshalCredentialW(CRED_MARSHAL_TYPE CredType, void* Credential, ushort** MarshaledCredential);

@DllImport("ADVAPI32.dll")
BOOL CredMarshalCredentialA(CRED_MARSHAL_TYPE CredType, void* Credential, byte** MarshaledCredential);

@DllImport("ADVAPI32.dll")
BOOL CredUnmarshalCredentialW(const(wchar)* MarshaledCredential, CRED_MARSHAL_TYPE* CredType, void** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredUnmarshalCredentialA(const(char)* MarshaledCredential, CRED_MARSHAL_TYPE* CredType, void** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredIsMarshaledCredentialW(const(wchar)* MarshaledCredential);

@DllImport("ADVAPI32.dll")
BOOL CredIsMarshaledCredentialA(const(char)* MarshaledCredential);

@DllImport("credui.dll")
BOOL CredUnPackAuthenticationBufferW(uint dwFlags, char* pAuthBuffer, uint cbAuthBuffer, const(wchar)* pszUserName, uint* pcchMaxUserName, const(wchar)* pszDomainName, uint* pcchMaxDomainName, const(wchar)* pszPassword, uint* pcchMaxPassword);

@DllImport("credui.dll")
BOOL CredUnPackAuthenticationBufferA(uint dwFlags, char* pAuthBuffer, uint cbAuthBuffer, const(char)* pszUserName, uint* pcchlMaxUserName, const(char)* pszDomainName, uint* pcchMaxDomainName, const(char)* pszPassword, uint* pcchMaxPassword);

@DllImport("credui.dll")
BOOL CredPackAuthenticationBufferW(uint dwFlags, const(wchar)* pszUserName, const(wchar)* pszPassword, char* pPackedCredentials, uint* pcbPackedCredentials);

@DllImport("credui.dll")
BOOL CredPackAuthenticationBufferA(uint dwFlags, const(char)* pszUserName, const(char)* pszPassword, char* pPackedCredentials, uint* pcbPackedCredentials);

@DllImport("ADVAPI32.dll")
BOOL CredProtectW(BOOL fAsSelf, const(wchar)* pszCredentials, uint cchCredentials, const(wchar)* pszProtectedCredentials, uint* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);

@DllImport("ADVAPI32.dll")
BOOL CredProtectA(BOOL fAsSelf, const(char)* pszCredentials, uint cchCredentials, const(char)* pszProtectedCredentials, uint* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);

@DllImport("ADVAPI32.dll")
BOOL CredUnprotectW(BOOL fAsSelf, const(wchar)* pszProtectedCredentials, uint cchProtectedCredentials, const(wchar)* pszCredentials, uint* pcchMaxChars);

@DllImport("ADVAPI32.dll")
BOOL CredUnprotectA(BOOL fAsSelf, const(char)* pszProtectedCredentials, uint cchProtectedCredentials, const(char)* pszCredentials, uint* pcchMaxChars);

@DllImport("ADVAPI32.dll")
BOOL CredIsProtectedW(const(wchar)* pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);

@DllImport("ADVAPI32.dll")
BOOL CredIsProtectedA(const(char)* pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);

@DllImport("ADVAPI32.dll")
BOOL CredFindBestCredentialW(const(wchar)* TargetName, uint Type, uint Flags, CREDENTIALW** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredFindBestCredentialA(const(char)* TargetName, uint Type, uint Flags, CREDENTIALA** Credential);

@DllImport("ADVAPI32.dll")
BOOL CredGetSessionTypes(uint MaximumPersistCount, char* MaximumPersist);

@DllImport("ADVAPI32.dll")
void CredFree(void* Buffer);

@DllImport("credui.dll")
uint CredUIPromptForCredentialsW(CREDUI_INFOW* pUiInfo, const(wchar)* pszTargetName, SecHandle* pContext, uint dwAuthError, const(wchar)* pszUserName, uint ulUserNameBufferSize, const(wchar)* pszPassword, uint ulPasswordBufferSize, int* save, uint dwFlags);

@DllImport("credui.dll")
uint CredUIPromptForCredentialsA(CREDUI_INFOA* pUiInfo, const(char)* pszTargetName, SecHandle* pContext, uint dwAuthError, const(char)* pszUserName, uint ulUserNameBufferSize, const(char)* pszPassword, uint ulPasswordBufferSize, int* save, uint dwFlags);

@DllImport("credui.dll")
uint CredUIPromptForWindowsCredentialsW(CREDUI_INFOW* pUiInfo, uint dwAuthError, uint* pulAuthPackage, char* pvInAuthBuffer, uint ulInAuthBufferSize, char* ppvOutAuthBuffer, uint* pulOutAuthBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui.dll")
uint CredUIPromptForWindowsCredentialsA(CREDUI_INFOA* pUiInfo, uint dwAuthError, uint* pulAuthPackage, char* pvInAuthBuffer, uint ulInAuthBufferSize, char* ppvOutAuthBuffer, uint* pulOutAuthBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui.dll")
uint CredUIParseUserNameW(const(wchar)* UserName, char* user, uint userBufferSize, char* domain, uint domainBufferSize);

@DllImport("credui.dll")
uint CredUIParseUserNameA(const(char)* userName, char* user, uint userBufferSize, char* domain, uint domainBufferSize);

@DllImport("credui.dll")
uint CredUICmdLinePromptForCredentialsW(const(wchar)* pszTargetName, SecHandle* pContext, uint dwAuthError, const(wchar)* UserName, uint ulUserBufferSize, const(wchar)* pszPassword, uint ulPasswordBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui.dll")
uint CredUICmdLinePromptForCredentialsA(const(char)* pszTargetName, SecHandle* pContext, uint dwAuthError, const(char)* UserName, uint ulUserBufferSize, const(char)* pszPassword, uint ulPasswordBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui.dll")
uint CredUIConfirmCredentialsW(const(wchar)* pszTargetName, BOOL bConfirm);

@DllImport("credui.dll")
uint CredUIConfirmCredentialsA(const(char)* pszTargetName, BOOL bConfirm);

@DllImport("credui.dll")
uint CredUIStoreSSOCredW(const(wchar)* pszRealm, const(wchar)* pszUsername, const(wchar)* pszPassword, BOOL bPersist);

@DllImport("credui.dll")
uint CredUIReadSSOCredW(const(wchar)* pszRealm, ushort** ppszUsername);

@DllImport("SECUR32.dll")
NTSTATUS CredMarshalTargetInfo(CREDENTIAL_TARGET_INFORMATIONW* InTargetInfo, ushort** Buffer, uint* BufferSize);

@DllImport("SECUR32.dll")
NTSTATUS CredUnmarshalTargetInfo(char* Buffer, uint BufferSize, CREDENTIAL_TARGET_INFORMATIONW** RetTargetInfo, uint* RetActualSize);

@DllImport("SCHANNEL.dll")
BOOL SslEmptyCacheA(const(char)* pszTargetName, uint dwFlags);

@DllImport("SCHANNEL.dll")
BOOL SslEmptyCacheW(const(wchar)* pszTargetName, uint dwFlags);

@DllImport("SCHANNEL.dll")
void SslGenerateRandomBits(ubyte* pRandomData, int cRandomData);

@DllImport("SCHANNEL.dll")
BOOL SslCrackCertificate(ubyte* pbCertificate, uint cbCertificate, uint dwFlags, X509Certificate** ppCertificate);

@DllImport("SCHANNEL.dll")
void SslFreeCertificate(X509Certificate* pCertificate);

@DllImport("SCHANNEL.dll")
uint SslGetMaximumKeySize(uint Reserved);

@DllImport("SCHANNEL.dll")
int SslGetServerIdentity(char* ClientHello, uint ClientHelloSize, ubyte** ServerIdentity, uint* ServerIdentitySize, uint Flags);

@DllImport("SCHANNEL.dll")
int SslGetExtensions(char* clientHello, uint clientHelloByteSize, char* genericExtensions, ubyte genericExtensionsCount, uint* bytesToRead, SchGetExtensionsOptions flags);

@DllImport("KeyCredMgr.dll")
HRESULT KeyCredentialManagerGetOperationErrorStates(KeyCredentialManagerOperationType keyCredentialManagerOperationType, int* isReady, KeyCredentialManagerOperationErrorStates* keyCredentialManagerOperationErrorStates);

@DllImport("KeyCredMgr.dll")
HRESULT KeyCredentialManagerShowUIOperation(HWND hWndOwner, KeyCredentialManagerOperationType keyCredentialManagerOperationType);

@DllImport("KeyCredMgr.dll")
HRESULT KeyCredentialManagerGetInformation(KeyCredentialManagerInfo** keyCredentialManagerInfo);

@DllImport("KeyCredMgr.dll")
void KeyCredentialManagerFreeInformation(KeyCredentialManagerInfo* keyCredentialManagerInfo);

@DllImport("davclnt.dll")
uint NPAddConnection(NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName);

@DllImport("davclnt.dll")
uint NPAddConnection3(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName, uint dwFlags);

@DllImport("NTLANMAN.dll")
uint NPAddConnection4(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* lpAuthBuffer, uint cbAuthBuffer, uint dwFlags, char* lpUseOptions, uint cbUseOptions);

@DllImport("davclnt.dll")
uint NPCancelConnection(const(wchar)* lpName, BOOL fForce);

@DllImport("davclnt.dll")
uint NPGetConnection(const(wchar)* lpLocalName, const(wchar)* lpRemoteName, uint* lpnBufferLen);

@DllImport("NTLANMAN.dll")
uint NPGetConnection3(const(wchar)* lpLocalName, uint dwLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("davclnt.dll")
uint NPGetUniversalName(const(wchar)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("NTLANMAN.dll")
uint NPGetConnectionPerformance(const(wchar)* lpRemoteName, NETCONNECTINFOSTRUCT* lpNetConnectInfo);

@DllImport("davclnt.dll")
uint NPOpenEnum(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, int* lphEnum);

@DllImport("davclnt.dll")
uint NPEnumResource(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

@DllImport("davclnt.dll")
uint NPCloseEnum(HANDLE hEnum);

@DllImport("davclnt.dll")
uint NPGetCaps(uint ndex);

@DllImport("davclnt.dll")
uint NPGetUser(const(wchar)* lpName, const(wchar)* lpUserName, uint* lpnBufferLen);

@DllImport("NTLANMAN.dll")
uint NPGetPersistentUseOptionsForConnection(const(wchar)* lpRemotePath, char* lpReadUseOptions, uint cbReadUseOptions, char* lpWriteUseOptions, uint* lpSizeWriteUseOptions);

@DllImport("davclnt.dll")
uint NPGetResourceParent(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize);

@DllImport("davclnt.dll")
uint NPGetResourceInformation(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize, ushort** lplpSystem);

@DllImport("davclnt.dll")
uint NPFormatNetworkName(const(wchar)* lpRemoteName, const(wchar)* lpFormattedName, uint* lpnLength, uint dwFlags, uint dwAveCharPerLine);

@DllImport("MPR.dll")
void WNetSetLastErrorA(uint err, const(char)* lpError, const(char)* lpProviders);

@DllImport("MPR.dll")
void WNetSetLastErrorW(uint err, const(wchar)* lpError, const(wchar)* lpProviders);

@DllImport("certpoleng.dll")
NTSTATUS PstGetTrustAnchors(UNICODE_STRING* pTargetName, uint cCriteria, char* rgpCriteria, SecPkgContext_IssuerListInfoEx** ppTrustedIssuers);

@DllImport("certpoleng.dll")
NTSTATUS PstGetTrustAnchorsEx(UNICODE_STRING* pTargetName, uint cCriteria, char* rgpCriteria, CERT_CONTEXT* pCertContext, SecPkgContext_IssuerListInfoEx** ppTrustedIssuers);

@DllImport("certpoleng.dll")
NTSTATUS PstGetCertificateChain(CERT_CONTEXT* pCert, SecPkgContext_IssuerListInfoEx* pTrustedIssuers, CERT_CHAIN_CONTEXT** ppCertChainContext);

@DllImport("certpoleng.dll")
NTSTATUS PstGetCertificates(UNICODE_STRING* pTargetName, uint cCriteria, char* rgpCriteria, BOOL bIsClient, uint* pdwCertChainContextCount, CERT_CHAIN_CONTEXT*** ppCertChainContexts);

@DllImport("certpoleng.dll")
NTSTATUS PstAcquirePrivateKey(CERT_CONTEXT* pCert);

@DllImport("certpoleng.dll")
NTSTATUS PstValidate(UNICODE_STRING* pTargetName, BOOL bIsClient, CERT_USAGE_MATCH* pRequestedIssuancePolicy, void** phAdditionalCertStore, CERT_CONTEXT* pCert, Guid* pProvGUID);

@DllImport("certpoleng.dll")
NTSTATUS PstMapCertificate(CERT_CONTEXT* pCert, LSA_TOKEN_INFORMATION_TYPE* pTokenInformationType, void** ppTokenInformation);

@DllImport("certpoleng.dll")
NTSTATUS PstGetUserNameForCertificate(CERT_CONTEXT* pCertContext, UNICODE_STRING* UserName);

@DllImport("SAS.dll")
void SendSAS(BOOL AsUser);

@DllImport("AUTHZ.dll")
BOOL AuthzAccessCheck(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent, void* pSecurityDescriptor, char* OptionalSecurityDescriptorArray, uint OptionalSecurityDescriptorCount, AUTHZ_ACCESS_REPLY* pReply, AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__** phAccessCheckResults);

@DllImport("AUTHZ.dll")
BOOL AuthzCachedAccessCheck(uint Flags, AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__* hAccessCheckResults, AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent, AUTHZ_ACCESS_REPLY* pReply);

@DllImport("AUTHZ.dll")
BOOL AuthzOpenObjectAudit(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent, void* pSecurityDescriptor, char* OptionalSecurityDescriptorArray, uint OptionalSecurityDescriptorCount, AUTHZ_ACCESS_REPLY* pReply);

@DllImport("AUTHZ.dll")
BOOL AuthzFreeHandle(AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__* hAccessCheckResults);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeResourceManager(uint Flags, PFN_AUTHZ_DYNAMIC_ACCESS_CHECK pfnDynamicAccessCheck, PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS pfnComputeDynamicGroups, PFN_AUTHZ_FREE_DYNAMIC_GROUPS pfnFreeDynamicGroups, const(wchar)* szResourceManagerName, AUTHZ_RESOURCE_MANAGER_HANDLE__** phAuthzResourceManager);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeResourceManagerEx(uint Flags, AUTHZ_INIT_INFO* pAuthzInitInfo, AUTHZ_RESOURCE_MANAGER_HANDLE__** phAuthzResourceManager);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeRemoteResourceManager(AUTHZ_RPC_INIT_INFO_CLIENT* pRpcInitInfo, AUTHZ_RESOURCE_MANAGER_HANDLE__** phAuthzResourceManager);

@DllImport("AUTHZ.dll")
BOOL AuthzFreeResourceManager(AUTHZ_RESOURCE_MANAGER_HANDLE__* hAuthzResourceManager);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeContextFromToken(uint Flags, HANDLE TokenHandle, AUTHZ_RESOURCE_MANAGER_HANDLE__* hAuthzResourceManager, LARGE_INTEGER* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, AUTHZ_CLIENT_CONTEXT_HANDLE__** phAuthzClientContext);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeContextFromSid(uint Flags, void* UserSid, AUTHZ_RESOURCE_MANAGER_HANDLE__* hAuthzResourceManager, LARGE_INTEGER* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, AUTHZ_CLIENT_CONTEXT_HANDLE__** phAuthzClientContext);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeContextFromAuthzContext(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, LARGE_INTEGER* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, AUTHZ_CLIENT_CONTEXT_HANDLE__** phNewAuthzClientContext);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeCompoundContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* UserContext, AUTHZ_CLIENT_CONTEXT_HANDLE__* DeviceContext, AUTHZ_CLIENT_CONTEXT_HANDLE__** phCompoundContext);

@DllImport("AUTHZ.dll")
BOOL AuthzAddSidsToContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, SID_AND_ATTRIBUTES* Sids, uint SidCount, SID_AND_ATTRIBUTES* RestrictedSids, uint RestrictedSidCount, AUTHZ_CLIENT_CONTEXT_HANDLE__** phNewAuthzClientContext);

@DllImport("AUTHZ.dll")
BOOL AuthzModifySecurityAttributes(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, char* pOperations, AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAttributes);

@DllImport("AUTHZ.dll")
BOOL AuthzModifyClaims(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, AUTHZ_CONTEXT_INFORMATION_CLASS ClaimClass, char* pClaimOperations, AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pClaims);

@DllImport("AUTHZ.dll")
BOOL AuthzModifySids(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, AUTHZ_CONTEXT_INFORMATION_CLASS SidClass, char* pSidOperations, TOKEN_GROUPS* pSids);

@DllImport("AUTHZ.dll")
BOOL AuthzSetAppContainerInformation(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, void* pAppContainerSid, uint CapabilityCount, char* pCapabilitySids);

@DllImport("AUTHZ.dll")
BOOL AuthzGetInformationFromContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, AUTHZ_CONTEXT_INFORMATION_CLASS InfoClass, uint BufferSize, uint* pSizeRequired, void* Buffer);

@DllImport("AUTHZ.dll")
BOOL AuthzFreeContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeObjectAccessAuditEvent(uint Flags, AUTHZ_AUDIT_EVENT_TYPE_HANDLE__* hAuditEventType, const(wchar)* szOperationType, const(wchar)* szObjectType, const(wchar)* szObjectName, const(wchar)* szAdditionalInfo, AUTHZ_AUDIT_EVENT_HANDLE__** phAuditEvent, uint dwAdditionalParameterCount);

@DllImport("AUTHZ.dll")
BOOL AuthzInitializeObjectAccessAuditEvent2(uint Flags, AUTHZ_AUDIT_EVENT_TYPE_HANDLE__* hAuditEventType, const(wchar)* szOperationType, const(wchar)* szObjectType, const(wchar)* szObjectName, const(wchar)* szAdditionalInfo, const(wchar)* szAdditionalInfo2, AUTHZ_AUDIT_EVENT_HANDLE__** phAuditEvent, uint dwAdditionalParameterCount);

@DllImport("AUTHZ.dll")
BOOL AuthzFreeAuditEvent(AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent);

@DllImport("AUTHZ.dll")
BOOL AuthzEvaluateSacl(AUTHZ_CLIENT_CONTEXT_HANDLE__* AuthzClientContext, AUTHZ_ACCESS_REQUEST* pRequest, ACL* Sacl, uint GrantedAccess, BOOL AccessGranted, int* pbGenerateAudit);

@DllImport("AUTHZ.dll")
BOOL AuthzInstallSecurityEventSource(uint dwFlags, AUTHZ_SOURCE_SCHEMA_REGISTRATION* pRegistration);

@DllImport("AUTHZ.dll")
BOOL AuthzUninstallSecurityEventSource(uint dwFlags, const(wchar)* szEventSourceName);

@DllImport("AUTHZ.dll")
BOOL AuthzEnumerateSecurityEventSources(uint dwFlags, AUTHZ_SOURCE_SCHEMA_REGISTRATION* Buffer, uint* pdwCount, uint* pdwLength);

@DllImport("AUTHZ.dll")
BOOL AuthzRegisterSecurityEventSource(uint dwFlags, const(wchar)* szEventSourceName, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__** phEventProvider);

@DllImport("AUTHZ.dll")
BOOL AuthzUnregisterSecurityEventSource(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__** phEventProvider);

@DllImport("AUTHZ.dll")
BOOL AuthzReportSecurityEvent(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__* hEventProvider, uint dwAuditId, void* pUserSid, uint dwCount);

@DllImport("AUTHZ.dll")
BOOL AuthzReportSecurityEventFromParams(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__* hEventProvider, uint dwAuditId, void* pUserSid, AUDIT_PARAMS* pParams);

@DllImport("AUTHZ.dll")
BOOL AuthzRegisterCapChangeNotification(AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__** phCapChangeSubscription, LPTHREAD_START_ROUTINE pfnCapChangeCallback, void* pCallbackContext);

@DllImport("AUTHZ.dll")
BOOL AuthzUnregisterCapChangeNotification(AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__* hCapChangeSubscription);

@DllImport("AUTHZ.dll")
BOOL AuthzFreeCentralAccessPolicyCache();

@DllImport("ACLUI.dll")
HPROPSHEETPAGE CreateSecurityPage(ISecurityInformation psi);

@DllImport("ACLUI.dll")
BOOL EditSecurity(HWND hwndOwner, ISecurityInformation psi);

@DllImport("ACLUI.dll")
HRESULT EditSecurityAdvanced(HWND hwndOwner, ISecurityInformation psi, SI_PAGE_TYPE uSIPage);

@DllImport("ADVAPI32.dll")
uint SetEntriesInAclA(uint cCountOfExplicitEntries, char* pListOfExplicitEntries, ACL* OldAcl, ACL** NewAcl);

@DllImport("ADVAPI32.dll")
uint SetEntriesInAclW(uint cCountOfExplicitEntries, char* pListOfExplicitEntries, ACL* OldAcl, ACL** NewAcl);

@DllImport("ADVAPI32.dll")
uint GetExplicitEntriesFromAclA(ACL* pacl, uint* pcCountOfExplicitEntries, EXPLICIT_ACCESS_A** pListOfExplicitEntries);

@DllImport("ADVAPI32.dll")
uint GetExplicitEntriesFromAclW(ACL* pacl, uint* pcCountOfExplicitEntries, EXPLICIT_ACCESS_W** pListOfExplicitEntries);

@DllImport("ADVAPI32.dll")
uint GetEffectiveRightsFromAclA(ACL* pacl, TRUSTEE_A* pTrustee, uint* pAccessRights);

@DllImport("ADVAPI32.dll")
uint GetEffectiveRightsFromAclW(ACL* pacl, TRUSTEE_W* pTrustee, uint* pAccessRights);

@DllImport("ADVAPI32.dll")
uint GetAuditedPermissionsFromAclA(ACL* pacl, TRUSTEE_A* pTrustee, uint* pSuccessfulAuditedRights, uint* pFailedAuditRights);

@DllImport("ADVAPI32.dll")
uint GetAuditedPermissionsFromAclW(ACL* pacl, TRUSTEE_W* pTrustee, uint* pSuccessfulAuditedRights, uint* pFailedAuditRights);

@DllImport("ADVAPI32.dll")
uint GetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void** ppsidOwner, void** ppsidGroup, ACL** ppDacl, ACL** ppSacl, void** ppSecurityDescriptor);

@DllImport("ADVAPI32.dll")
uint GetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void** ppsidOwner, void** ppsidGroup, ACL** ppDacl, ACL** ppSacl, void** ppSecurityDescriptor);

@DllImport("ADVAPI32.dll")
uint GetSecurityInfo(HANDLE handle, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void** ppsidOwner, void** ppsidGroup, ACL** ppDacl, ACL** ppSacl, void** ppSecurityDescriptor);

@DllImport("ADVAPI32.dll")
uint SetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* psidOwner, void* psidGroup, ACL* pDacl, ACL* pSacl);

@DllImport("ADVAPI32.dll")
uint SetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* psidOwner, void* psidGroup, ACL* pDacl, ACL* pSacl);

@DllImport("ADVAPI32.dll")
uint SetSecurityInfo(HANDLE handle, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* psidOwner, void* psidGroup, ACL* pDacl, ACL* pSacl);

@DllImport("ADVAPI32.dll")
uint GetInheritanceSourceA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, BOOL Container, char* pObjectClassGuids, uint GuidCount, ACL* pAcl, _FN_OBJECT_MGR_FUNCTIONS* pfnArray, GENERIC_MAPPING* pGenericMapping, INHERITED_FROMA* pInheritArray);

@DllImport("ADVAPI32.dll")
uint GetInheritanceSourceW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, BOOL Container, char* pObjectClassGuids, uint GuidCount, ACL* pAcl, _FN_OBJECT_MGR_FUNCTIONS* pfnArray, GENERIC_MAPPING* pGenericMapping, INHERITED_FROMW* pInheritArray);

@DllImport("ADVAPI32.dll")
uint FreeInheritedFromArray(char* pInheritArray, ushort AceCnt, _FN_OBJECT_MGR_FUNCTIONS* pfnArray);

@DllImport("ADVAPI32.dll")
uint TreeResetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, BOOL KeepExplicit, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32.dll")
uint TreeResetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, BOOL KeepExplicit, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32.dll")
uint TreeSetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, uint dwAction, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32.dll")
uint TreeSetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, uint dwAction, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32.dll")
uint BuildSecurityDescriptorA(TRUSTEE_A* pOwner, TRUSTEE_A* pGroup, uint cCountOfAccessEntries, char* pListOfAccessEntries, uint cCountOfAuditEntries, char* pListOfAuditEntries, void* pOldSD, uint* pSizeNewSD, void** pNewSD);

@DllImport("ADVAPI32.dll")
uint BuildSecurityDescriptorW(TRUSTEE_W* pOwner, TRUSTEE_W* pGroup, uint cCountOfAccessEntries, char* pListOfAccessEntries, uint cCountOfAuditEntries, char* pListOfAuditEntries, void* pOldSD, uint* pSizeNewSD, void** pNewSD);

@DllImport("ADVAPI32.dll")
uint LookupSecurityDescriptorPartsA(TRUSTEE_A** ppOwner, TRUSTEE_A** ppGroup, uint* pcCountOfAccessEntries, EXPLICIT_ACCESS_A** ppListOfAccessEntries, uint* pcCountOfAuditEntries, EXPLICIT_ACCESS_A** ppListOfAuditEntries, void* pSD);

@DllImport("ADVAPI32.dll")
uint LookupSecurityDescriptorPartsW(TRUSTEE_W** ppOwner, TRUSTEE_W** ppGroup, uint* pcCountOfAccessEntries, EXPLICIT_ACCESS_W** ppListOfAccessEntries, uint* pcCountOfAuditEntries, EXPLICIT_ACCESS_W** ppListOfAuditEntries, void* pSD);

@DllImport("ADVAPI32.dll")
void BuildExplicitAccessWithNameA(EXPLICIT_ACCESS_A* pExplicitAccess, const(char)* pTrusteeName, uint AccessPermissions, ACCESS_MODE AccessMode, uint Inheritance);

@DllImport("ADVAPI32.dll")
void BuildExplicitAccessWithNameW(EXPLICIT_ACCESS_W* pExplicitAccess, const(wchar)* pTrusteeName, uint AccessPermissions, ACCESS_MODE AccessMode, uint Inheritance);

@DllImport("ADVAPI32.dll")
void BuildImpersonateExplicitAccessWithNameA(EXPLICIT_ACCESS_A* pExplicitAccess, const(char)* pTrusteeName, TRUSTEE_A* pTrustee, uint AccessPermissions, ACCESS_MODE AccessMode, uint Inheritance);

@DllImport("ADVAPI32.dll")
void BuildImpersonateExplicitAccessWithNameW(EXPLICIT_ACCESS_W* pExplicitAccess, const(wchar)* pTrusteeName, TRUSTEE_W* pTrustee, uint AccessPermissions, ACCESS_MODE AccessMode, uint Inheritance);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithNameA(TRUSTEE_A* pTrustee, const(char)* pName);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithNameW(TRUSTEE_W* pTrustee, const(wchar)* pName);

@DllImport("ADVAPI32.dll")
void BuildImpersonateTrusteeA(TRUSTEE_A* pTrustee, TRUSTEE_A* pImpersonateTrustee);

@DllImport("ADVAPI32.dll")
void BuildImpersonateTrusteeW(TRUSTEE_W* pTrustee, TRUSTEE_W* pImpersonateTrustee);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithSidA(TRUSTEE_A* pTrustee, void* pSid);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithSidW(TRUSTEE_W* pTrustee, void* pSid);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndSidA(TRUSTEE_A* pTrustee, OBJECTS_AND_SID* pObjSid, Guid* pObjectGuid, Guid* pInheritedObjectGuid, void* pSid);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndSidW(TRUSTEE_W* pTrustee, OBJECTS_AND_SID* pObjSid, Guid* pObjectGuid, Guid* pInheritedObjectGuid, void* pSid);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndNameA(TRUSTEE_A* pTrustee, OBJECTS_AND_NAME_A* pObjName, SE_OBJECT_TYPE ObjectType, const(char)* ObjectTypeName, const(char)* InheritedObjectTypeName, const(char)* Name);

@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndNameW(TRUSTEE_W* pTrustee, OBJECTS_AND_NAME_W* pObjName, SE_OBJECT_TYPE ObjectType, const(wchar)* ObjectTypeName, const(wchar)* InheritedObjectTypeName, const(wchar)* Name);

@DllImport("ADVAPI32.dll")
byte* GetTrusteeNameA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32.dll")
ushort* GetTrusteeNameW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_TYPE GetTrusteeTypeA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_TYPE GetTrusteeTypeW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_FORM GetTrusteeFormA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_FORM GetTrusteeFormW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32.dll")
MULTIPLE_TRUSTEE_OPERATION GetMultipleTrusteeOperationA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32.dll")
MULTIPLE_TRUSTEE_OPERATION GetMultipleTrusteeOperationW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_A* GetMultipleTrusteeA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_W* GetMultipleTrusteeW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32.dll")
BOOL ConvertSidToStringSidA(void* Sid, byte** StringSid);

@DllImport("ADVAPI32.dll")
BOOL ConvertSidToStringSidW(void* Sid, ushort** StringSid);

@DllImport("ADVAPI32.dll")
BOOL ConvertStringSidToSidA(const(char)* StringSid, void** Sid);

@DllImport("ADVAPI32.dll")
BOOL ConvertStringSidToSidW(const(wchar)* StringSid, void** Sid);

@DllImport("ADVAPI32.dll")
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorA(const(char)* StringSecurityDescriptor, uint StringSDRevision, void** SecurityDescriptor, uint* SecurityDescriptorSize);

@DllImport("ADVAPI32.dll")
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorW(const(wchar)* StringSecurityDescriptor, uint StringSDRevision, void** SecurityDescriptor, uint* SecurityDescriptorSize);

@DllImport("ADVAPI32.dll")
BOOL ConvertSecurityDescriptorToStringSecurityDescriptorA(void* SecurityDescriptor, uint RequestedStringSDRevision, uint SecurityInformation, byte** StringSecurityDescriptor, uint* StringSecurityDescriptorLen);

@DllImport("ADVAPI32.dll")
BOOL ConvertSecurityDescriptorToStringSecurityDescriptorW(void* SecurityDescriptor, uint RequestedStringSDRevision, uint SecurityInformation, ushort** StringSecurityDescriptor, uint* StringSecurityDescriptorLen);

@DllImport("DSSEC.dll")
HRESULT DSCreateISecurityInfoObject(const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, uint dwFlags, ISecurityInformation* ppSI, PFNREADOBJECTSECURITY pfnReadSD, PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

@DllImport("DSSEC.dll")
HRESULT DSCreateISecurityInfoObjectEx(const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, const(wchar)* pwszServer, const(wchar)* pwszUserName, const(wchar)* pwszPassword, uint dwFlags, ISecurityInformation* ppSI, PFNREADOBJECTSECURITY pfnReadSD, PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

@DllImport("DSSEC.dll")
HRESULT DSCreateSecurityPage(const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, uint dwFlags, HPROPSHEETPAGE* phPage, PFNREADOBJECTSECURITY pfnReadSD, PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

@DllImport("DSSEC.dll")
HRESULT DSEditSecurity(HWND hwndOwner, const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, uint dwFlags, const(wchar)* pwszCaption, PFNREADOBJECTSECURITY pfnReadSD, PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

@DllImport("certadm.dll")
HRESULT CertSrvIsServerOnlineW(const(wchar)* pwszServerName, int* pfServerOnline);

@DllImport("certadm.dll")
HRESULT CertSrvBackupGetDynamicFileListW(void* hbc, ushort** ppwszzFileList, uint* pcbSize);

@DllImport("certadm.dll")
HRESULT CertSrvBackupPrepareW(const(wchar)* pwszServerName, uint grbitJet, uint dwBackupFlags, void** phbc);

@DllImport("certadm.dll")
HRESULT CertSrvBackupGetDatabaseNamesW(void* hbc, ushort** ppwszzAttachmentInformation, uint* pcbSize);

@DllImport("certadm.dll")
HRESULT CertSrvBackupOpenFileW(void* hbc, const(wchar)* pwszAttachmentName, uint cbReadHintSize, LARGE_INTEGER* pliFileSize);

@DllImport("certadm.dll")
HRESULT CertSrvBackupRead(void* hbc, void* pvBuffer, uint cbBuffer, uint* pcbRead);

@DllImport("certadm.dll")
HRESULT CertSrvBackupClose(void* hbc);

@DllImport("certadm.dll")
HRESULT CertSrvBackupGetBackupLogsW(void* hbc, ushort** ppwszzBackupLogFiles, uint* pcbSize);

@DllImport("certadm.dll")
HRESULT CertSrvBackupTruncateLogs(void* hbc);

@DllImport("certadm.dll")
HRESULT CertSrvBackupEnd(void* hbc);

@DllImport("certadm.dll")
void CertSrvBackupFree(void* pv);

@DllImport("certadm.dll")
HRESULT CertSrvRestoreGetDatabaseLocationsW(void* hbc, ushort** ppwszzDatabaseLocationList, uint* pcbSize);

@DllImport("certadm.dll")
HRESULT CertSrvRestorePrepareW(const(wchar)* pwszServerName, uint dwRestoreFlags, void** phbc);

@DllImport("certadm.dll")
HRESULT CertSrvRestoreRegisterW(void* hbc, const(wchar)* pwszCheckPointFilePath, const(wchar)* pwszLogPath, CSEDB_RSTMAPW* rgrstmap, int crstmap, const(wchar)* pwszBackupLogPath, uint genLow, uint genHigh);

@DllImport("certadm.dll")
HRESULT CertSrvRestoreRegisterThroughFile(void* hbc, const(wchar)* pwszCheckPointFilePath, const(wchar)* pwszLogPath, CSEDB_RSTMAPW* rgrstmap, int crstmap, const(wchar)* pwszBackupLogPath, uint genLow, uint genHigh);

@DllImport("certadm.dll")
HRESULT CertSrvRestoreRegisterComplete(void* hbc, HRESULT hrRestoreState);

@DllImport("certadm.dll")
HRESULT CertSrvRestoreEnd(void* hbc);

@DllImport("certadm.dll")
HRESULT CertSrvServerControlW(const(wchar)* pwszServerName, uint dwControlFlags, uint* pcbOut, ubyte** ppbOut);

@DllImport("ncrypt.dll")
int NCryptRegisterProtectionDescriptorName(const(wchar)* pwszName, const(wchar)* pwszDescriptorString, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptQueryProtectionDescriptorName(const(wchar)* pwszName, const(wchar)* pwszDescriptorString, uint* pcDescriptorString, uint dwFlags);

@DllImport("ncrypt.dll")
int NCryptCreateProtectionDescriptor(const(wchar)* pwszDescriptorString, uint dwFlags, NCRYPT_DESCRIPTOR_HANDLE__** phDescriptor);

@DllImport("ncrypt.dll")
int NCryptCloseProtectionDescriptor(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor);

@DllImport("ncrypt.dll")
int NCryptGetProtectionDescriptorInfo(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, const(NCRYPT_ALLOC_PARA)* pMemPara, uint dwInfoType, void** ppvInfo);

@DllImport("ncrypt.dll")
int NCryptProtectSecret(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, uint dwFlags, char* pbData, uint cbData, const(NCRYPT_ALLOC_PARA)* pMemPara, HWND hWnd, ubyte** ppbProtectedBlob, uint* pcbProtectedBlob);

@DllImport("ncrypt.dll")
int NCryptUnprotectSecret(NCRYPT_DESCRIPTOR_HANDLE__** phDescriptor, uint dwFlags, char* pbProtectedBlob, uint cbProtectedBlob, const(NCRYPT_ALLOC_PARA)* pMemPara, HWND hWnd, ubyte** ppbData, uint* pcbData);

@DllImport("ncrypt.dll")
int NCryptStreamOpenToProtect(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, uint dwFlags, HWND hWnd, NCRYPT_PROTECT_STREAM_INFO* pStreamInfo, NCRYPT_STREAM_HANDLE__** phStream);

@DllImport("ncrypt.dll")
int NCryptStreamOpenToUnprotect(NCRYPT_PROTECT_STREAM_INFO* pStreamInfo, uint dwFlags, HWND hWnd, NCRYPT_STREAM_HANDLE__** phStream);

@DllImport("ncrypt.dll")
int NCryptStreamOpenToUnprotectEx(NCRYPT_PROTECT_STREAM_INFO_EX* pStreamInfo, uint dwFlags, HWND hWnd, NCRYPT_STREAM_HANDLE__** phStream);

@DllImport("ncrypt.dll")
int NCryptStreamUpdate(NCRYPT_STREAM_HANDLE__* hStream, char* pbData, uint cbData, BOOL fFinal);

@DllImport("ncrypt.dll")
int NCryptStreamClose(NCRYPT_STREAM_HANDLE__* hStream);

@DllImport("TOKENBINDING.dll")
int TokenBindingGenerateBinding(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, const(wchar)* targetURL, TOKENBINDING_TYPE bindingType, char* tlsEKM, uint tlsEKMSize, TOKENBINDING_EXTENSION_FORMAT extensionFormat, const(void)* extensionData, void** tokenBinding, uint* tokenBindingSize, TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING.dll")
int TokenBindingGenerateMessage(char* tokenBindings, char* tokenBindingsSize, uint tokenBindingsCount, void** tokenBindingMessage, uint* tokenBindingMessageSize);

@DllImport("TOKENBINDING.dll")
int TokenBindingVerifyMessage(char* tokenBindingMessage, uint tokenBindingMessageSize, TOKENBINDING_KEY_PARAMETERS_TYPE keyType, char* tlsEKM, uint tlsEKMSize, TOKENBINDING_RESULT_LIST** resultList);

@DllImport("TOKENBINDING.dll")
int TokenBindingGetKeyTypesClient(TOKENBINDING_KEY_TYPES** keyTypes);

@DllImport("TOKENBINDING.dll")
int TokenBindingGetKeyTypesServer(TOKENBINDING_KEY_TYPES** keyTypes);

@DllImport("TOKENBINDING.dll")
int TokenBindingDeleteBinding(const(wchar)* targetURL);

@DllImport("TOKENBINDING.dll")
int TokenBindingDeleteAllBindings();

@DllImport("TOKENBINDING.dll")
int TokenBindingGenerateID(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, char* publicKey, uint publicKeySize, TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING.dll")
int TokenBindingGenerateIDForUri(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, const(wchar)* targetUri, TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING.dll")
int TokenBindingGetHighestSupportedVersion(ubyte* majorVersion, ubyte* minorVersion);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlClose(void* hCryptXml);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlGetTransforms(const(CRYPT_XML_TRANSFORM_CHAIN_CONFIG)** ppConfig);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlOpenToEncode(const(CRYPT_XML_TRANSFORM_CHAIN_CONFIG)* pConfig, uint dwFlags, const(wchar)* wszId, char* rgProperty, uint cProperty, const(CRYPT_XML_BLOB)* pEncoded, void** phSignature);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlOpenToDecode(const(CRYPT_XML_TRANSFORM_CHAIN_CONFIG)* pConfig, uint dwFlags, char* rgProperty, uint cProperty, const(CRYPT_XML_BLOB)* pEncoded, void** phCryptXml);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlAddObject(void* hSignatureOrObject, uint dwFlags, char* rgProperty, uint cProperty, const(CRYPT_XML_BLOB)* pEncoded, const(CRYPT_XML_OBJECT)** ppObject);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlCreateReference(void* hCryptXml, uint dwFlags, const(wchar)* wszId, const(wchar)* wszURI, const(wchar)* wszType, const(CRYPT_XML_ALGORITHM)* pDigestMethod, uint cTransform, char* rgTransform, void** phReference);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlDigestReference(void* hReference, uint dwFlags, CRYPT_XML_DATA_PROVIDER* pDataProviderIn);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlSetHMACSecret(void* hSignature, char* pbSecret, uint cbSecret);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlSign(void* hSignature, uint hKey, uint dwKeySpec, uint dwFlags, CRYPT_XML_KEYINFO_SPEC dwKeyInfoSpec, const(void)* pvKeyInfoSpec, const(CRYPT_XML_ALGORITHM)* pSignatureMethod, const(CRYPT_XML_ALGORITHM)* pCanonicalization);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlImportPublicKey(uint dwFlags, const(CRYPT_XML_KEY_VALUE)* pKeyValue, void** phKey);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlVerifySignature(void* hSignature, void* hKey, uint dwFlags);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlGetDocContext(void* hCryptXml, const(CRYPT_XML_DOC_CTXT)** ppStruct);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlGetSignature(void* hCryptXml, const(CRYPT_XML_SIGNATURE)** ppStruct);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlGetReference(void* hCryptXml, const(CRYPT_XML_REFERENCE)** ppStruct);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlGetStatus(void* hCryptXml, CRYPT_XML_STATUS* pStatus);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlEncode(void* hCryptXml, CRYPT_XML_CHARSET dwCharset, char* rgProperty, uint cProperty, void* pvCallbackState, PFN_CRYPT_XML_WRITE_CALLBACK pfnWrite);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlGetAlgorithmInfo(const(CRYPT_XML_ALGORITHM)* pXmlAlgorithm, uint dwFlags, CRYPT_XML_ALGORITHM_INFO** ppAlgInfo);

@DllImport("CRYPTXML.dll")
CRYPT_XML_ALGORITHM_INFO* CryptXmlFindAlgorithmInfo(uint dwFindByType, const(void)* pvFindBy, uint dwGroupId, uint dwFlags);

@DllImport("CRYPTXML.dll")
HRESULT CryptXmlEnumAlgorithmInfo(uint dwGroupId, uint dwFlags, void* pvArg, PFN_CRYPT_XML_ENUM_ALG_INFO pfnEnumAlgInfo);

@DllImport("WINTRUST.dll")
int WinVerifyTrust(HWND hwnd, Guid* pgActionID, void* pWVTData);

@DllImport("WINTRUST.dll")
HRESULT WinVerifyTrustEx(HWND hwnd, Guid* pgActionID, WINTRUST_DATA* pWinTrustData);

@DllImport("WINTRUST.dll")
void WintrustGetRegPolicyFlags(uint* pdwPolicyFlags);

@DllImport("WINTRUST.dll")
BOOL WintrustSetRegPolicyFlags(uint dwPolicyFlags);

@DllImport("WINTRUST.dll")
BOOL WintrustAddActionID(Guid* pgActionID, uint fdwFlags, CRYPT_REGISTER_ACTIONID* psProvInfo);

@DllImport("WINTRUST.dll")
BOOL WintrustRemoveActionID(Guid* pgActionID);

@DllImport("WINTRUST.dll")
BOOL WintrustLoadFunctionPointers(Guid* pgActionID, CRYPT_PROVIDER_FUNCTIONS* pPfns);

@DllImport("WINTRUST.dll")
BOOL WintrustAddDefaultForUsage(const(byte)* pszUsageOID, CRYPT_PROVIDER_REGDEFUSAGE* psDefUsage);

@DllImport("WINTRUST.dll")
BOOL WintrustGetDefaultForUsage(uint dwAction, const(byte)* pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psUsage);

@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_SGNR* WTHelperGetProvSignerFromChain(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, BOOL fCounterSigner, uint idxCounterSigner);

@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_CERT* WTHelperGetProvCertFromChain(CRYPT_PROVIDER_SGNR* pSgnr, uint idxCert);

@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_DATA* WTHelperProvDataFromStateData(HANDLE hStateData);

@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_PRIVDATA* WTHelperGetProvPrivateDataFromChain(CRYPT_PROVIDER_DATA* pProvData, Guid* pgProviderID);

@DllImport("WINTRUST.dll")
BOOL WTHelperCertIsSelfSigned(uint dwEncoding, CERT_INFO* pCert);

@DllImport("WINTRUST.dll")
HRESULT WTHelperCertCheckValidSignature(CRYPT_PROVIDER_DATA* pProvData);

@DllImport("WINTRUST.dll")
BOOL OpenPersonalTrustDBDialogEx(HWND hwndParent, uint dwFlags, void** pvReserved);

@DllImport("WINTRUST.dll")
BOOL OpenPersonalTrustDBDialog(HWND hwndParent);

@DllImport("WINTRUST.dll")
void WintrustSetDefaultIncludePEPageHashes(BOOL fIncludePEPageHashes);

@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgViewContext(uint dwContextType, const(void)* pvContext, HWND hwnd, const(wchar)* pwszTitle, uint dwFlags, void* pvReserved);

@DllImport("CRYPTUI.dll")
CERT_CONTEXT* CryptUIDlgSelectCertificateFromStore(void* hCertStore, HWND hwnd, const(wchar)* pwszTitle, const(wchar)* pwszDisplayString, uint dwDontUseColumn, uint dwFlags, void* pvReserved);

@DllImport("CRYPTUI.dll")
HRESULT CertSelectionGetSerializedBlob(CERT_SELECTUI_INPUT* pcsi, void** ppOutBuffer, uint* pulOutBufferSize);

@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgCertMgr(CRYPTUI_CERT_MGR_STRUCT* pCryptUICertMgr);

@DllImport("CRYPTUI.dll")
BOOL CryptUIWizDigitalSign(uint dwFlags, HWND hwndParent, const(wchar)* pwszWizardTitle, CRYPTUI_WIZ_DIGITAL_SIGN_INFO* pDigitalSignInfo, CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT** ppSignContext);

@DllImport("CRYPTUI.dll")
BOOL CryptUIWizFreeDigitalSignContext(CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT* pSignContext);

@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgViewCertificateW(CRYPTUI_VIEWCERTIFICATE_STRUCTW* pCertViewInfo, int* pfPropertiesChanged);

@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgViewCertificateA(CRYPTUI_VIEWCERTIFICATE_STRUCTA* pCertViewInfo, int* pfPropertiesChanged);

@DllImport("CRYPTUI.dll")
BOOL CryptUIWizExport(uint dwFlags, HWND hwndParent, const(wchar)* pwszWizardTitle, CRYPTUI_WIZ_EXPORT_INFO* pExportInfo, void* pvoid);

@DllImport("CRYPTUI.dll")
BOOL CryptUIWizImport(uint dwFlags, HWND hwndParent, const(wchar)* pwszWizardTitle, CRYPTUI_WIZ_IMPORT_SRC_INFO* pImportSrc, void* hDestCertStore);

@DllImport("CRYPT32.dll")
BOOL CryptSIPGetSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, uint* pdwEncodingType, uint dwIndex, uint* pcbSignedDataMsg, ubyte* pbSignedDataMsg);

@DllImport("CRYPT32.dll")
BOOL CryptSIPPutSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, uint dwEncodingType, uint* pdwIndex, uint cbSignedDataMsg, ubyte* pbSignedDataMsg);

@DllImport("CRYPT32.dll")
BOOL CryptSIPCreateIndirectData(SIP_SUBJECTINFO* pSubjectInfo, uint* pcbIndirectData, SIP_INDIRECT_DATA* pIndirectData);

@DllImport("CRYPT32.dll")
BOOL CryptSIPVerifyIndirectData(SIP_SUBJECTINFO* pSubjectInfo, SIP_INDIRECT_DATA* pIndirectData);

@DllImport("CRYPT32.dll")
BOOL CryptSIPRemoveSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, uint dwIndex);

@DllImport("CRYPT32.dll")
BOOL CryptSIPLoad(const(Guid)* pgSubject, uint dwFlags, SIP_DISPATCH_INFO* pSipDispatch);

@DllImport("CRYPT32.dll")
BOOL CryptSIPRetrieveSubjectGuid(const(wchar)* FileName, HANDLE hFileIn, Guid* pgSubject);

@DllImport("CRYPT32.dll")
BOOL CryptSIPRetrieveSubjectGuidForCatalogFile(const(wchar)* FileName, HANDLE hFileIn, Guid* pgSubject);

@DllImport("CRYPT32.dll")
BOOL CryptSIPAddProvider(SIP_ADD_NEWPROVIDER* psNewProv);

@DllImport("CRYPT32.dll")
BOOL CryptSIPRemoveProvider(Guid* pgProv);

@DllImport("CRYPT32.dll")
BOOL CryptSIPGetCaps(SIP_SUBJECTINFO* pSubjInfo, SIP_CAP_SET_V3* pCaps);

@DllImport("CRYPT32.dll")
BOOL CryptSIPGetSealedDigest(SIP_SUBJECTINFO* pSubjectInfo, char* pSig, uint dwSig, char* pbDigest, uint* pcbDigest);

@DllImport("WINTRUST.dll")
HANDLE CryptCATOpen(const(wchar)* pwszFileName, uint fdwOpenFlags, uint hProv, uint dwPublicVersion, uint dwEncodingType);

@DllImport("WINTRUST.dll")
BOOL CryptCATClose(HANDLE hCatalog);

@DllImport("WINTRUST.dll")
CRYPTCATSTORE* CryptCATStoreFromHandle(HANDLE hCatalog);

@DllImport("WINTRUST.dll")
HANDLE CryptCATHandleFromStore(CRYPTCATSTORE* pCatStore);

@DllImport("WINTRUST.dll")
BOOL CryptCATPersistStore(HANDLE hCatalog);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATGetCatAttrInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATPutCatAttrInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag, uint dwAttrTypeAndAction, uint cbData, ubyte* pbData);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATEnumerateCatAttr(HANDLE hCatalog, CRYPTCATATTRIBUTE* pPrevAttr);

@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATGetMemberInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATAllocSortedMemberInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST.dll")
void CryptCATFreeSortedMemberInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATGetAttrInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATPutMemberInfo(HANDLE hCatalog, const(wchar)* pwszFileName, const(wchar)* pwszReferenceTag, Guid* pgSubjectType, uint dwCertVersion, uint cbSIPIndirectData, ubyte* pbSIPIndirectData);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATPutAttrInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, const(wchar)* pwszReferenceTag, uint dwAttrTypeAndAction, uint cbData, ubyte* pbData);

@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATEnumerateMember(HANDLE hCatalog, CRYPTCATMEMBER* pPrevMember);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATEnumerateAttr(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, CRYPTCATATTRIBUTE* pPrevAttr);

@DllImport("WINTRUST.dll")
CRYPTCATCDF* CryptCATCDFOpen(const(wchar)* pwszFilePath, PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST.dll")
BOOL CryptCATCDFClose(CRYPTCATCDF* pCDF);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATCDFEnumCatAttributes(CRYPTCATCDF* pCDF, CRYPTCATATTRIBUTE* pPrevAttr, PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATCDFEnumMembers(CRYPTCATCDF* pCDF, CRYPTCATMEMBER* pPrevMember, PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATCDFEnumAttributes(CRYPTCATCDF* pCDF, CRYPTCATMEMBER* pMember, CRYPTCATATTRIBUTE* pPrevAttr, PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST.dll")
BOOL IsCatalogFile(HANDLE hFile, ushort* pwszFileName);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminAcquireContext(int* phCatAdmin, const(Guid)* pgSubsystem, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminAcquireContext2(int* phCatAdmin, const(Guid)* pgSubsystem, const(wchar)* pwszHashAlgorithm, CERT_STRONG_SIGN_PARA* pStrongHashPolicy, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminReleaseContext(int hCatAdmin, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminReleaseCatalogContext(int hCatAdmin, int hCatInfo, uint dwFlags);

@DllImport("WINTRUST.dll")
int CryptCATAdminEnumCatalogFromHash(int hCatAdmin, char* pbHash, uint cbHash, uint dwFlags, int* phPrevCatInfo);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminCalcHashFromFileHandle(HANDLE hFile, uint* pcbHash, char* pbHash, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminCalcHashFromFileHandle2(int hCatAdmin, HANDLE hFile, uint* pcbHash, char* pbHash, uint dwFlags);

@DllImport("WINTRUST.dll")
int CryptCATAdminAddCatalog(int hCatAdmin, const(wchar)* pwszCatalogFile, const(wchar)* pwszSelectBaseName, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminRemoveCatalog(int hCatAdmin, const(wchar)* pwszCatalogFile, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATCatalogInfoFromContext(int hCatInfo, CATALOG_INFO* psCatInfo, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminResolveCatalogPath(int hCatAdmin, ushort* pwszCatalogFile, CATALOG_INFO* psCatInfo, uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminPauseServiceForBackup(uint dwFlags, BOOL fResume);

@DllImport("ADVAPI32.dll")
BOOL SaferGetPolicyInformation(uint dwScopeId, SAFER_POLICY_INFO_CLASS SaferPolicyInfoClass, uint InfoBufferSize, char* InfoBuffer, uint* InfoBufferRetSize, void* lpReserved);

@DllImport("ADVAPI32.dll")
BOOL SaferSetPolicyInformation(uint dwScopeId, SAFER_POLICY_INFO_CLASS SaferPolicyInfoClass, uint InfoBufferSize, char* InfoBuffer, void* lpReserved);

@DllImport("ADVAPI32.dll")
BOOL SaferCreateLevel(uint dwScopeId, uint dwLevelId, uint OpenFlags, SAFER_LEVEL_HANDLE__** pLevelHandle, void* lpReserved);

@DllImport("ADVAPI32.dll")
BOOL SaferCloseLevel(SAFER_LEVEL_HANDLE__* hLevelHandle);

@DllImport("ADVAPI32.dll")
BOOL SaferIdentifyLevel(uint dwNumProperties, char* pCodeProperties, SAFER_LEVEL_HANDLE__** pLevelHandle, void* lpReserved);

@DllImport("ADVAPI32.dll")
BOOL SaferComputeTokenFromLevel(SAFER_LEVEL_HANDLE__* LevelHandle, HANDLE InAccessToken, int* OutAccessToken, uint dwFlags, void* lpReserved);

@DllImport("ADVAPI32.dll")
BOOL SaferGetLevelInformation(SAFER_LEVEL_HANDLE__* LevelHandle, SAFER_OBJECT_INFO_CLASS dwInfoType, char* lpQueryBuffer, uint dwInBufferSize, uint* lpdwOutBufferSize);

@DllImport("ADVAPI32.dll")
BOOL SaferSetLevelInformation(SAFER_LEVEL_HANDLE__* LevelHandle, SAFER_OBJECT_INFO_CLASS dwInfoType, char* lpQueryBuffer, uint dwInBufferSize);

@DllImport("ADVAPI32.dll")
BOOL SaferRecordEventLogEntry(SAFER_LEVEL_HANDLE__* hLevel, const(wchar)* szTargetPath, void* lpReserved);

@DllImport("ADVAPI32.dll")
BOOL SaferiIsExecutableFileType(const(wchar)* szFullPathname, ubyte bFromShellExecute);

@DllImport("SLC.dll")
HRESULT SLOpen(void** phSLC);

@DllImport("SLC.dll")
HRESULT SLClose(void* hSLC);

@DllImport("SLC.dll")
HRESULT SLInstallProofOfPurchase(void* hSLC, const(wchar)* pwszPKeyAlgorithm, const(wchar)* pwszPKeyString, uint cbPKeySpecificData, char* pbPKeySpecificData, Guid* pPkeyId);

@DllImport("SLC.dll")
HRESULT SLUninstallProofOfPurchase(void* hSLC, const(Guid)* pPKeyId);

@DllImport("SLC.dll")
HRESULT SLInstallLicense(void* hSLC, uint cbLicenseBlob, char* pbLicenseBlob, Guid* pLicenseFileId);

@DllImport("SLC.dll")
HRESULT SLUninstallLicense(void* hSLC, const(Guid)* pLicenseFileId);

@DllImport("SLC.dll")
HRESULT SLConsumeRight(void* hSLC, const(Guid)* pAppId, const(Guid)* pProductSkuId, const(wchar)* pwszRightName, void* pvReserved);

@DllImport("SLC.dll")
HRESULT SLGetProductSkuInformation(void* hSLC, const(Guid)* pProductSkuId, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC.dll")
HRESULT SLGetPKeyInformation(void* hSLC, const(Guid)* pPKeyId, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC.dll")
HRESULT SLGetLicenseInformation(void* hSLC, const(Guid)* pSLLicenseId, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC.dll")
HRESULT SLGetLicensingStatusInformation(void* hSLC, const(Guid)* pAppID, const(Guid)* pProductSkuId, const(wchar)* pwszRightName, uint* pnStatusCount, SL_LICENSING_STATUS** ppLicensingStatus);

@DllImport("SLC.dll")
HRESULT SLGetPolicyInformation(void* hSLC, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC.dll")
HRESULT SLGetPolicyInformationDWORD(void* hSLC, const(wchar)* pwszValueName, uint* pdwValue);

@DllImport("SLC.dll")
HRESULT SLGetServiceInformation(void* hSLC, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC.dll")
HRESULT SLGetApplicationInformation(void* hSLC, const(Guid)* pApplicationId, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("slcext.dll")
HRESULT SLActivateProduct(void* hSLC, const(Guid)* pProductSkuId, uint cbAppSpecificData, const(void)* pvAppSpecificData, const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, const(wchar)* pwszProxyServer, ushort wProxyPort);

@DllImport("slcext.dll")
HRESULT SLGetServerStatus(const(wchar)* pwszServerURL, const(wchar)* pwszAcquisitionType, const(wchar)* pwszProxyServer, ushort wProxyPort, int* phrStatus);

@DllImport("SLC.dll")
HRESULT SLGenerateOfflineInstallationId(void* hSLC, const(Guid)* pProductSkuId, ushort** ppwszInstallationId);

@DllImport("SLC.dll")
HRESULT SLGenerateOfflineInstallationIdEx(void* hSLC, const(Guid)* pProductSkuId, const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, ushort** ppwszInstallationId);

@DllImport("SLC.dll")
HRESULT SLDepositOfflineConfirmationId(void* hSLC, const(Guid)* pProductSkuId, const(wchar)* pwszInstallationId, const(wchar)* pwszConfirmationId);

@DllImport("SLC.dll")
HRESULT SLDepositOfflineConfirmationIdEx(void* hSLC, const(Guid)* pProductSkuId, const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, const(wchar)* pwszInstallationId, const(wchar)* pwszConfirmationId);

@DllImport("SLC.dll")
HRESULT SLGetPKeyId(void* hSLC, const(wchar)* pwszPKeyAlgorithm, const(wchar)* pwszPKeyString, uint cbPKeySpecificData, char* pbPKeySpecificData, Guid* pPKeyId);

@DllImport("SLC.dll")
HRESULT SLGetInstalledProductKeyIds(void* hSLC, const(Guid)* pProductSkuId, uint* pnProductKeyIds, Guid** ppProductKeyIds);

@DllImport("SLC.dll")
HRESULT SLSetCurrentProductKey(void* hSLC, const(Guid)* pProductSkuId, const(Guid)* pProductKeyId);

@DllImport("SLC.dll")
HRESULT SLGetSLIDList(void* hSLC, SLIDTYPE eQueryIdType, const(Guid)* pQueryId, SLIDTYPE eReturnIdType, uint* pnReturnIds, Guid** ppReturnIds);

@DllImport("SLC.dll")
HRESULT SLGetLicenseFileId(void* hSLC, uint cbLicenseBlob, char* pbLicenseBlob, Guid* pLicenseFileId);

@DllImport("SLC.dll")
HRESULT SLGetLicense(void* hSLC, const(Guid)* pLicenseFileId, uint* pcbLicenseFile, ubyte** ppbLicenseFile);

@DllImport("SLC.dll")
HRESULT SLFireEvent(void* hSLC, const(wchar)* pwszEventId, const(Guid)* pApplicationId);

@DllImport("SLC.dll")
HRESULT SLRegisterEvent(void* hSLC, const(wchar)* pwszEventId, const(Guid)* pApplicationId, HANDLE hEvent);

@DllImport("SLC.dll")
HRESULT SLUnregisterEvent(void* hSLC, const(wchar)* pwszEventId, const(Guid)* pApplicationId, HANDLE hEvent);

@DllImport("SLC.dll")
HRESULT SLGetWindowsInformation(const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC.dll")
HRESULT SLGetWindowsInformationDWORD(const(wchar)* pwszValueName, uint* pdwValue);

@DllImport("SLWGA.dll")
HRESULT SLIsGenuineLocal(const(Guid)* pAppId, SL_GENUINE_STATE* pGenuineState, SL_NONGENUINE_UI_OPTIONS* pUIOptions);

@DllImport("slcext.dll")
HRESULT SLAcquireGenuineTicket(void** ppTicketBlob, uint* pcbTicketBlob, const(wchar)* pwszTemplateId, const(wchar)* pwszServerUrl, const(wchar)* pwszClientToken);

@DllImport("SLC.dll")
HRESULT SLSetGenuineInformation(const(Guid)* pQueryId, const(wchar)* pwszValueName, SLDATATYPE eDataType, uint cbValue, char* pbValue);

@DllImport("slcext.dll")
HRESULT SLGetReferralInformation(void* hSLC, SLREFERRALTYPE eReferralType, const(Guid)* pSkuOrAppId, const(wchar)* pwszValueName, ushort** ppwszValue);

@DllImport("SLC.dll")
HRESULT SLGetGenuineInformation(const(Guid)* pQueryId, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("api-ms-win-core-slapi-l1-1-0.dll")
HRESULT SLQueryLicenseValueFromApp(const(wchar)* valueName, uint* valueType, char* dataBuffer, uint dataSize, uint* resultDataSize);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqCreateSession(DdqAccessLevel accessLevel, HDIAGNOSTIC_DATA_QUERY_SESSION__** hSession);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqCloseSession(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetSessionAccessLevel(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, DdqAccessLevel* accessLevel);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticDataAccessLevelAllowed(DdqAccessLevel* accessLevel);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordStats(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, const(DIAGNOSTIC_DATA_SEARCH_CRITERIA)* searchCriteria, uint* recordCount, long* minRowId, long* maxRowId);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordPayload(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, long rowId, ushort** payload);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordLocaleTags(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, const(wchar)* locale, HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__** hTagDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordLocaleTags(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__* hTagDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordLocaleTagAtIndex(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__* hTagDescription, uint index, DIAGNOSTIC_DATA_EVENT_TAG_DESCRIPTION* tagDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordLocaleTagCount(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__* hTagDescription, uint* tagDescriptionCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducers(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__** hProducerDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordProducers(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__* hProducerDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducerAtIndex(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__* hProducerDescription, uint index, DIAGNOSTIC_DATA_EVENT_PRODUCER_DESCRIPTION* producerDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducerCount(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__* hProducerDescription, uint* producerDescriptionCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducerCategories(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, const(wchar)* producerName, HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__** hCategoryDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordProducerCategories(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__* hCategoryDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordCategoryAtIndex(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__* hCategoryDescription, uint index, DIAGNOSTIC_DATA_EVENT_CATEGORY_DESCRIPTION* categoryDescription);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordCategoryCount(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__* hCategoryDescription, uint* categoryDescriptionCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqIsDiagnosticRecordSampledIn(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, const(Guid)* providerGroup, const(Guid)* providerId, const(wchar)* providerName, const(uint)* eventId, const(wchar)* eventName, const(uint)* eventVersion, const(ulong)* eventKeywords, int* isSampledIn);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordPage(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, DIAGNOSTIC_DATA_SEARCH_CRITERIA* searchCriteria, uint offset, uint pageRecordCount, long baseRowId, HDIAGNOSTIC_RECORD__** hRecord);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordPage(HDIAGNOSTIC_RECORD__* hRecord);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordAtIndex(HDIAGNOSTIC_RECORD__* hRecord, uint index, DIAGNOSTIC_DATA_RECORD* record);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordCount(HDIAGNOSTIC_RECORD__* hRecord, uint* recordCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReportStoreReportCount(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, uint reportStoreType, uint* reportCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqCancelDiagnosticRecordOperation(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReport(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, uint reportStoreType, HDIAGNOSTIC_REPORT__** hReport);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticReport(HDIAGNOSTIC_REPORT__* hReport);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReportAtIndex(HDIAGNOSTIC_REPORT__* hReport, uint index, DIAGNOSTIC_REPORT_DATA* report);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReportCount(HDIAGNOSTIC_REPORT__* hReport, uint* reportCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqExtractDiagnosticReport(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, uint reportStoreType, const(wchar)* reportKey, const(wchar)* destinationPath);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordTagDistribution(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, char* producerNames, uint producerNameCount, char* tagStats, uint* statCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordBinaryDistribution(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, char* producerNames, uint producerNameCount, uint topNBinaries, char* binaryStats, uint* statCount);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordSummary(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, char* producerNames, uint producerNameCount, DIAGNOSTIC_DATA_GENERAL_STATS* generalStats);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqSetTranscriptConfiguration(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, const(DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION)* desiredConfig);

@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetTranscriptConfiguration(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION* currentConfig);

@DllImport("ADVAPI32.dll")
BOOL SetThreadToken(int* Thread, HANDLE Token);

@DllImport("ADVAPI32.dll")
BOOL OpenProcessToken(HANDLE ProcessHandle, uint DesiredAccess, int* TokenHandle);

@DllImport("ADVAPI32.dll")
BOOL OpenThreadToken(HANDLE ThreadHandle, uint DesiredAccess, BOOL OpenAsSelf, int* TokenHandle);

@DllImport("KERNEL32.dll")
BOOL InstallELAMCertificateInfo(HANDLE ELAMFile);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckAndAuditAlarmA(const(char)* SubsystemName, void* HandleId, const(char)* ObjectTypeName, const(char)* ObjectName, void* SecurityDescriptor, uint DesiredAccess, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeAndAuditAlarmA(const(char)* SubsystemName, void* HandleId, const(char)* ObjectTypeName, const(char)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmA(const(char)* SubsystemName, void* HandleId, const(char)* ObjectTypeName, const(char)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, char* GrantedAccess, char* AccessStatusList, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmByHandleA(const(char)* SubsystemName, void* HandleId, HANDLE ClientToken, const(char)* ObjectTypeName, const(char)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, char* GrantedAccess, char* AccessStatusList, int* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectOpenAuditAlarmA(const(char)* SubsystemName, void* HandleId, const(char)* ObjectTypeName, const(char)* ObjectName, void* pSecurityDescriptor, HANDLE ClientToken, uint DesiredAccess, uint GrantedAccess, PRIVILEGE_SET* Privileges, BOOL ObjectCreation, BOOL AccessGranted, int* GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectPrivilegeAuditAlarmA(const(char)* SubsystemName, void* HandleId, HANDLE ClientToken, uint DesiredAccess, PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32.dll")
BOOL ObjectCloseAuditAlarmA(const(char)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectDeleteAuditAlarmA(const(char)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL PrivilegedServiceAuditAlarmA(const(char)* SubsystemName, const(char)* ServiceName, HANDLE ClientToken, PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32.dll")
BOOL AddConditionalAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, ubyte AceType, uint AccessMask, void* pSid, const(wchar)* ConditionStr, uint* ReturnLength);

@DllImport("ADVAPI32.dll")
BOOL SetFileSecurityA(const(char)* lpFileName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ADVAPI32.dll")
BOOL GetFileSecurityA(const(char)* lpFileName, uint RequestedInformation, char* pSecurityDescriptor, uint nLength, uint* lpnLengthNeeded);

@DllImport("ADVAPI32.dll")
BOOL LookupAccountSidA(const(char)* lpSystemName, void* Sid, const(char)* Name, uint* cchName, const(char)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32.dll")
BOOL LookupAccountSidW(const(wchar)* lpSystemName, void* Sid, const(wchar)* Name, uint* cchName, const(wchar)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32.dll")
BOOL LookupAccountNameA(const(char)* lpSystemName, const(char)* lpAccountName, char* Sid, uint* cbSid, const(char)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32.dll")
BOOL LookupAccountNameW(const(wchar)* lpSystemName, const(wchar)* lpAccountName, char* Sid, uint* cbSid, const(wchar)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeValueA(const(char)* lpSystemName, const(char)* lpName, LUID* lpLuid);

@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeValueW(const(wchar)* lpSystemName, const(wchar)* lpName, LUID* lpLuid);

@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeNameA(const(char)* lpSystemName, LUID* lpLuid, const(char)* lpName, uint* cchName);

@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeNameW(const(wchar)* lpSystemName, LUID* lpLuid, const(wchar)* lpName, uint* cchName);

@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeDisplayNameA(const(char)* lpSystemName, const(char)* lpName, const(char)* lpDisplayName, uint* cchDisplayName, uint* lpLanguageId);

@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeDisplayNameW(const(wchar)* lpSystemName, const(wchar)* lpName, const(wchar)* lpDisplayName, uint* cchDisplayName, uint* lpLanguageId);

@DllImport("ADVAPI32.dll")
BOOL LogonUserA(const(char)* lpszUsername, const(char)* lpszDomain, const(char)* lpszPassword, uint dwLogonType, uint dwLogonProvider, int* phToken);

@DllImport("ADVAPI32.dll")
BOOL LogonUserW(const(wchar)* lpszUsername, const(wchar)* lpszDomain, const(wchar)* lpszPassword, uint dwLogonType, uint dwLogonProvider, int* phToken);

@DllImport("ADVAPI32.dll")
BOOL LogonUserExA(const(char)* lpszUsername, const(char)* lpszDomain, const(char)* lpszPassword, uint dwLogonType, uint dwLogonProvider, int* phToken, void** ppLogonSid, char* ppProfileBuffer, uint* pdwProfileLength, QUOTA_LIMITS* pQuotaLimits);

@DllImport("ADVAPI32.dll")
BOOL LogonUserExW(const(wchar)* lpszUsername, const(wchar)* lpszDomain, const(wchar)* lpszPassword, uint dwLogonType, uint dwLogonProvider, int* phToken, void** ppLogonSid, char* ppProfileBuffer, uint* pdwProfileLength, QUOTA_LIMITS* pQuotaLimits);

@DllImport("ADVAPI32.dll")
LSTATUS RegGetKeySecurity(HKEY hKey, uint SecurityInformation, char* pSecurityDescriptor, uint* lpcbSecurityDescriptor);

@DllImport("ADVAPI32.dll")
LSTATUS RegSetKeySecurity(HKEY hKey, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ntdll.dll")
NTSTATUS RtlConvertSidToUnicodeString(UNICODE_STRING* UnicodeString, void* Sid, ubyte AllocateDestinationString);

alias HCERTCHAINENGINE = int;
alias HCRYPTASYNC = int;
alias LsaHandle = int;
struct GENERIC_MAPPING
{
    uint GenericRead;
    uint GenericWrite;
    uint GenericExecute;
    uint GenericAll;
}

struct LUID_AND_ATTRIBUTES
{
    LUID Luid;
    uint Attributes;
}

struct SID_IDENTIFIER_AUTHORITY
{
    ubyte Value;
}

struct SID
{
    ubyte Revision;
    ubyte SubAuthorityCount;
    SID_IDENTIFIER_AUTHORITY IdentifierAuthority;
    uint SubAuthority;
}

enum SID_NAME_USE
{
    SidTypeUser = 1,
    SidTypeGroup = 2,
    SidTypeDomain = 3,
    SidTypeAlias = 4,
    SidTypeWellKnownGroup = 5,
    SidTypeDeletedAccount = 6,
    SidTypeInvalid = 7,
    SidTypeUnknown = 8,
    SidTypeComputer = 9,
    SidTypeLabel = 10,
    SidTypeLogonSession = 11,
}

struct SID_AND_ATTRIBUTES
{
    void* Sid;
    uint Attributes;
}

struct SID_AND_ATTRIBUTES_HASH
{
    uint SidCount;
    SID_AND_ATTRIBUTES* SidAttr;
    uint Hash;
}

enum WELL_KNOWN_SID_TYPE
{
    WinNullSid = 0,
    WinWorldSid = 1,
    WinLocalSid = 2,
    WinCreatorOwnerSid = 3,
    WinCreatorGroupSid = 4,
    WinCreatorOwnerServerSid = 5,
    WinCreatorGroupServerSid = 6,
    WinNtAuthoritySid = 7,
    WinDialupSid = 8,
    WinNetworkSid = 9,
    WinBatchSid = 10,
    WinInteractiveSid = 11,
    WinServiceSid = 12,
    WinAnonymousSid = 13,
    WinProxySid = 14,
    WinEnterpriseControllersSid = 15,
    WinSelfSid = 16,
    WinAuthenticatedUserSid = 17,
    WinRestrictedCodeSid = 18,
    WinTerminalServerSid = 19,
    WinRemoteLogonIdSid = 20,
    WinLogonIdsSid = 21,
    WinLocalSystemSid = 22,
    WinLocalServiceSid = 23,
    WinNetworkServiceSid = 24,
    WinBuiltinDomainSid = 25,
    WinBuiltinAdministratorsSid = 26,
    WinBuiltinUsersSid = 27,
    WinBuiltinGuestsSid = 28,
    WinBuiltinPowerUsersSid = 29,
    WinBuiltinAccountOperatorsSid = 30,
    WinBuiltinSystemOperatorsSid = 31,
    WinBuiltinPrintOperatorsSid = 32,
    WinBuiltinBackupOperatorsSid = 33,
    WinBuiltinReplicatorSid = 34,
    WinBuiltinPreWindows2000CompatibleAccessSid = 35,
    WinBuiltinRemoteDesktopUsersSid = 36,
    WinBuiltinNetworkConfigurationOperatorsSid = 37,
    WinAccountAdministratorSid = 38,
    WinAccountGuestSid = 39,
    WinAccountKrbtgtSid = 40,
    WinAccountDomainAdminsSid = 41,
    WinAccountDomainUsersSid = 42,
    WinAccountDomainGuestsSid = 43,
    WinAccountComputersSid = 44,
    WinAccountControllersSid = 45,
    WinAccountCertAdminsSid = 46,
    WinAccountSchemaAdminsSid = 47,
    WinAccountEnterpriseAdminsSid = 48,
    WinAccountPolicyAdminsSid = 49,
    WinAccountRasAndIasServersSid = 50,
    WinNTLMAuthenticationSid = 51,
    WinDigestAuthenticationSid = 52,
    WinSChannelAuthenticationSid = 53,
    WinThisOrganizationSid = 54,
    WinOtherOrganizationSid = 55,
    WinBuiltinIncomingForestTrustBuildersSid = 56,
    WinBuiltinPerfMonitoringUsersSid = 57,
    WinBuiltinPerfLoggingUsersSid = 58,
    WinBuiltinAuthorizationAccessSid = 59,
    WinBuiltinTerminalServerLicenseServersSid = 60,
    WinBuiltinDCOMUsersSid = 61,
    WinBuiltinIUsersSid = 62,
    WinIUserSid = 63,
    WinBuiltinCryptoOperatorsSid = 64,
    WinUntrustedLabelSid = 65,
    WinLowLabelSid = 66,
    WinMediumLabelSid = 67,
    WinHighLabelSid = 68,
    WinSystemLabelSid = 69,
    WinWriteRestrictedCodeSid = 70,
    WinCreatorOwnerRightsSid = 71,
    WinCacheablePrincipalsGroupSid = 72,
    WinNonCacheablePrincipalsGroupSid = 73,
    WinEnterpriseReadonlyControllersSid = 74,
    WinAccountReadonlyControllersSid = 75,
    WinBuiltinEventLogReadersGroup = 76,
    WinNewEnterpriseReadonlyControllersSid = 77,
    WinBuiltinCertSvcDComAccessGroup = 78,
    WinMediumPlusLabelSid = 79,
    WinLocalLogonSid = 80,
    WinConsoleLogonSid = 81,
    WinThisOrganizationCertificateSid = 82,
    WinApplicationPackageAuthoritySid = 83,
    WinBuiltinAnyPackageSid = 84,
    WinCapabilityInternetClientSid = 85,
    WinCapabilityInternetClientServerSid = 86,
    WinCapabilityPrivateNetworkClientServerSid = 87,
    WinCapabilityPicturesLibrarySid = 88,
    WinCapabilityVideosLibrarySid = 89,
    WinCapabilityMusicLibrarySid = 90,
    WinCapabilityDocumentsLibrarySid = 91,
    WinCapabilitySharedUserCertificatesSid = 92,
    WinCapabilityEnterpriseAuthenticationSid = 93,
    WinCapabilityRemovableStorageSid = 94,
    WinBuiltinRDSRemoteAccessServersSid = 95,
    WinBuiltinRDSEndpointServersSid = 96,
    WinBuiltinRDSManagementServersSid = 97,
    WinUserModeDriversSid = 98,
    WinBuiltinHyperVAdminsSid = 99,
    WinAccountCloneableControllersSid = 100,
    WinBuiltinAccessControlAssistanceOperatorsSid = 101,
    WinBuiltinRemoteManagementUsersSid = 102,
    WinAuthenticationAuthorityAssertedSid = 103,
    WinAuthenticationServiceAssertedSid = 104,
    WinLocalAccountSid = 105,
    WinLocalAccountAndAdministratorSid = 106,
    WinAccountProtectedUsersSid = 107,
    WinCapabilityAppointmentsSid = 108,
    WinCapabilityContactsSid = 109,
    WinAccountDefaultSystemManagedSid = 110,
    WinBuiltinDefaultSystemManagedGroupSid = 111,
    WinBuiltinStorageReplicaAdminsSid = 112,
    WinAccountKeyAdminsSid = 113,
    WinAccountEnterpriseKeyAdminsSid = 114,
    WinAuthenticationKeyTrustSid = 115,
    WinAuthenticationKeyPropertyMFASid = 116,
    WinAuthenticationKeyPropertyAttestationSid = 117,
    WinAuthenticationFreshKeyAuthSid = 118,
    WinBuiltinDeviceOwnersSid = 119,
}

struct ACL
{
    ubyte AclRevision;
    ubyte Sbz1;
    ushort AclSize;
    ushort AceCount;
    ushort Sbz2;
}

struct ACE_HEADER
{
    ubyte AceType;
    ubyte AceFlags;
    ushort AceSize;
}

struct ACCESS_ALLOWED_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct ACCESS_DENIED_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_AUDIT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_ALARM_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_RESOURCE_ATTRIBUTE_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_SCOPED_POLICY_ID_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_MANDATORY_LABEL_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct ACCESS_ALLOWED_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

struct ACCESS_DENIED_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

struct SYSTEM_AUDIT_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

struct SYSTEM_ALARM_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

struct ACCESS_ALLOWED_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct ACCESS_DENIED_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_AUDIT_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct SYSTEM_ALARM_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint SidStart;
}

struct ACCESS_ALLOWED_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

struct ACCESS_DENIED_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

struct SYSTEM_AUDIT_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

struct SYSTEM_ALARM_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint Mask;
    uint Flags;
    Guid ObjectType;
    Guid InheritedObjectType;
    uint SidStart;
}

enum ACL_INFORMATION_CLASS
{
    AclRevisionInformation = 1,
    AclSizeInformation = 2,
}

struct ACL_REVISION_INFORMATION
{
    uint AclRevision;
}

struct ACL_SIZE_INFORMATION
{
    uint AceCount;
    uint AclBytesInUse;
    uint AclBytesFree;
}

struct SECURITY_DESCRIPTOR
{
    ubyte Revision;
    ubyte Sbz1;
    ushort Control;
    void* Owner;
    void* Group;
    ACL* Sacl;
    ACL* Dacl;
}

struct OBJECT_TYPE_LIST
{
    ushort Level;
    ushort Sbz;
    Guid* ObjectType;
}

enum AUDIT_EVENT_TYPE
{
    AuditEventObjectAccess = 0,
    AuditEventDirectoryServiceAccess = 1,
}

struct PRIVILEGE_SET
{
    uint PrivilegeCount;
    uint Control;
    LUID_AND_ATTRIBUTES Privilege;
}

enum SECURITY_IMPERSONATION_LEVEL
{
    SecurityAnonymous = 0,
    SecurityIdentification = 1,
    SecurityImpersonation = 2,
    SecurityDelegation = 3,
}

enum TOKEN_TYPE
{
    TokenPrimary = 1,
    TokenImpersonation = 2,
}

enum TOKEN_ELEVATION_TYPE
{
    TokenElevationTypeDefault = 1,
    TokenElevationTypeFull = 2,
    TokenElevationTypeLimited = 3,
}

enum TOKEN_INFORMATION_CLASS
{
    TokenUser = 1,
    TokenGroups = 2,
    TokenPrivileges = 3,
    TokenOwner = 4,
    TokenPrimaryGroup = 5,
    TokenDefaultDacl = 6,
    TokenSource = 7,
    TokenType = 8,
    TokenImpersonationLevel = 9,
    TokenStatistics = 10,
    TokenRestrictedSids = 11,
    TokenSessionId = 12,
    TokenGroupsAndPrivileges = 13,
    TokenSessionReference = 14,
    TokenSandBoxInert = 15,
    TokenAuditPolicy = 16,
    TokenOrigin = 17,
    TokenElevationType = 18,
    TokenLinkedToken = 19,
    TokenElevation = 20,
    TokenHasRestrictions = 21,
    TokenAccessInformation = 22,
    TokenVirtualizationAllowed = 23,
    TokenVirtualizationEnabled = 24,
    TokenIntegrityLevel = 25,
    TokenUIAccess = 26,
    TokenMandatoryPolicy = 27,
    TokenLogonSid = 28,
    TokenIsAppContainer = 29,
    TokenCapabilities = 30,
    TokenAppContainerSid = 31,
    TokenAppContainerNumber = 32,
    TokenUserClaimAttributes = 33,
    TokenDeviceClaimAttributes = 34,
    TokenRestrictedUserClaimAttributes = 35,
    TokenRestrictedDeviceClaimAttributes = 36,
    TokenDeviceGroups = 37,
    TokenRestrictedDeviceGroups = 38,
    TokenSecurityAttributes = 39,
    TokenIsRestricted = 40,
    TokenProcessTrustLevel = 41,
    TokenPrivateNameSpace = 42,
    TokenSingletonAttributes = 43,
    TokenBnoIsolation = 44,
    TokenChildProcessFlags = 45,
    TokenIsLessPrivilegedAppContainer = 46,
    TokenIsSandboxed = 47,
    TokenOriginatingProcessTrustLevel = 48,
    MaxTokenInfoClass = 49,
}

struct TOKEN_USER
{
    SID_AND_ATTRIBUTES User;
}

struct TOKEN_GROUPS
{
    uint GroupCount;
    SID_AND_ATTRIBUTES Groups;
}

struct TOKEN_PRIVILEGES
{
    uint PrivilegeCount;
    LUID_AND_ATTRIBUTES Privileges;
}

struct TOKEN_OWNER
{
    void* Owner;
}

struct TOKEN_PRIMARY_GROUP
{
    void* PrimaryGroup;
}

struct TOKEN_DEFAULT_DACL
{
    ACL* DefaultDacl;
}

struct TOKEN_USER_CLAIMS
{
    void* UserClaims;
}

struct TOKEN_DEVICE_CLAIMS
{
    void* DeviceClaims;
}

struct TOKEN_GROUPS_AND_PRIVILEGES
{
    uint SidCount;
    uint SidLength;
    SID_AND_ATTRIBUTES* Sids;
    uint RestrictedSidCount;
    uint RestrictedSidLength;
    SID_AND_ATTRIBUTES* RestrictedSids;
    uint PrivilegeCount;
    uint PrivilegeLength;
    LUID_AND_ATTRIBUTES* Privileges;
    LUID AuthenticationId;
}

struct TOKEN_LINKED_TOKEN
{
    HANDLE LinkedToken;
}

struct TOKEN_ELEVATION
{
    uint TokenIsElevated;
}

struct TOKEN_MANDATORY_LABEL
{
    SID_AND_ATTRIBUTES Label;
}

struct TOKEN_MANDATORY_POLICY
{
    uint Policy;
}

struct TOKEN_ACCESS_INFORMATION
{
    SID_AND_ATTRIBUTES_HASH* SidHash;
    SID_AND_ATTRIBUTES_HASH* RestrictedSidHash;
    TOKEN_PRIVILEGES* Privileges;
    LUID AuthenticationId;
    TOKEN_TYPE TokenType;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    TOKEN_MANDATORY_POLICY MandatoryPolicy;
    uint Flags;
    uint AppContainerNumber;
    void* PackageSid;
    SID_AND_ATTRIBUTES_HASH* CapabilitiesHash;
    void* TrustLevelSid;
    void* SecurityAttributes;
}

struct TOKEN_AUDIT_POLICY
{
    ubyte PerUserPolicy;
}

struct TOKEN_SOURCE
{
    byte SourceName;
    LUID SourceIdentifier;
}

struct TOKEN_STATISTICS
{
    LUID TokenId;
    LUID AuthenticationId;
    LARGE_INTEGER ExpirationTime;
    TOKEN_TYPE TokenType;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    uint DynamicCharged;
    uint DynamicAvailable;
    uint GroupCount;
    uint PrivilegeCount;
    LUID ModifiedId;
}

struct TOKEN_CONTROL
{
    LUID TokenId;
    LUID AuthenticationId;
    LUID ModifiedId;
    TOKEN_SOURCE TokenSource;
}

struct TOKEN_ORIGIN
{
    LUID OriginatingLogonSession;
}

enum MANDATORY_LEVEL
{
    MandatoryLevelUntrusted = 0,
    MandatoryLevelLow = 1,
    MandatoryLevelMedium = 2,
    MandatoryLevelHigh = 3,
    MandatoryLevelSystem = 4,
    MandatoryLevelSecureProcess = 5,
    MandatoryLevelCount = 6,
}

struct TOKEN_APPCONTAINER_INFORMATION
{
    void* TokenAppContainer;
}

struct CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
{
    ulong Version;
    const(wchar)* Name;
}

struct CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
{
    void* pValue;
    uint ValueLength;
}

struct CLAIM_SECURITY_ATTRIBUTE_V1
{
    const(wchar)* Name;
    ushort ValueType;
    ushort Reserved;
    uint Flags;
    uint ValueCount;
    _Values_e__Union Values;
}

struct CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1
{
    uint Name;
    ushort ValueType;
    ushort Reserved;
    uint Flags;
    uint ValueCount;
    _Values_e__Union Values;
}

struct CLAIM_SECURITY_ATTRIBUTES_INFORMATION
{
    ushort Version;
    ushort Reserved;
    uint AttributeCount;
    _Attribute_e__Union Attribute;
}

struct SECURITY_QUALITY_OF_SERVICE
{
    uint Length;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    ubyte ContextTrackingMode;
    ubyte EffectiveOnly;
}

struct SECURITY_CAPABILITIES
{
    void* AppContainerSid;
    SID_AND_ATTRIBUTES* Capabilities;
    uint CapabilityCount;
    uint Reserved;
}

struct QUOTA_LIMITS
{
    uint PagedPoolLimit;
    uint NonPagedPoolLimit;
    uint MinimumWorkingSetSize;
    uint MaximumWorkingSetSize;
    uint PagefileLimit;
    LARGE_INTEGER TimeLimit;
}

struct UNICODE_STRING
{
    ushort Length;
    ushort MaximumLength;
    const(wchar)* Buffer;
}

struct SEC_WINNT_AUTH_IDENTITY_W
{
    ushort* User;
    uint UserLength;
    ushort* Domain;
    uint DomainLength;
    ushort* Password;
    uint PasswordLength;
    uint Flags;
}

struct SEC_WINNT_AUTH_IDENTITY_A
{
    ubyte* User;
    uint UserLength;
    ubyte* Domain;
    uint DomainLength;
    ubyte* Password;
    uint PasswordLength;
    uint Flags;
}

struct CMS_KEY_INFO
{
    uint dwVersion;
    uint Algid;
    ubyte* pbOID;
    uint cbOID;
}

struct HMAC_Info
{
    uint HashAlgid;
    ubyte* pbInnerString;
    uint cbInnerString;
    ubyte* pbOuterString;
    uint cbOuterString;
}

struct SCHANNEL_ALG
{
    uint dwUse;
    uint Algid;
    uint cBits;
    uint dwFlags;
    uint dwReserved;
}

struct PROV_ENUMALGS
{
    uint aiAlgid;
    uint dwBitLen;
    uint dwNameLen;
    byte szName;
}

struct PROV_ENUMALGS_EX
{
    uint aiAlgid;
    uint dwDefaultLen;
    uint dwMinLen;
    uint dwMaxLen;
    uint dwProtocols;
    uint dwNameLen;
    byte szName;
    uint dwLongNameLen;
    byte szLongName;
}

struct PUBLICKEYSTRUC
{
    ubyte bType;
    ubyte bVersion;
    ushort reserved;
    uint aiKeyAlg;
}

struct RSAPUBKEY
{
    uint magic;
    uint bitlen;
    uint pubexp;
}

struct PUBKEY
{
    uint magic;
    uint bitlen;
}

struct DSSSEED
{
    uint counter;
    ubyte seed;
}

struct PUBKEYVER3
{
    uint magic;
    uint bitlenP;
    uint bitlenQ;
    uint bitlenJ;
    DSSSEED DSSSeed;
}

struct PRIVKEYVER3
{
    uint magic;
    uint bitlenP;
    uint bitlenQ;
    uint bitlenJ;
    uint bitlenX;
    DSSSEED DSSSeed;
}

struct KEY_TYPE_SUBTYPE
{
    uint dwKeySpec;
    Guid Type;
    Guid Subtype;
}

struct CERT_FORTEZZA_DATA_PROP
{
    ubyte SerialNumber;
    int CertIndex;
    ubyte CertLabel;
}

struct CRYPT_RC4_KEY_STATE
{
    ubyte Key;
    ubyte SBox;
    ubyte i;
    ubyte j;
}

struct CRYPT_DES_KEY_STATE
{
    ubyte Key;
    ubyte IV;
    ubyte Feedback;
}

struct CRYPT_3DES_KEY_STATE
{
    ubyte Key;
    ubyte IV;
    ubyte Feedback;
}

struct CRYPT_AES_128_KEY_STATE
{
    ubyte Key;
    ubyte IV;
    ubyte EncryptionState;
    ubyte DecryptionState;
    ubyte Feedback;
}

struct CRYPT_AES_256_KEY_STATE
{
    ubyte Key;
    ubyte IV;
    ubyte EncryptionState;
    ubyte DecryptionState;
    ubyte Feedback;
}

struct CRYPTOAPI_BLOB
{
    uint cbData;
    ubyte* pbData;
}

struct CMS_DH_KEY_INFO
{
    uint dwVersion;
    uint Algid;
    const(char)* pszContentEncObjId;
    CRYPTOAPI_BLOB PubInfo;
    void* pReserved;
}

struct BCRYPT_KEY_LENGTHS_STRUCT
{
    uint dwMinLength;
    uint dwMaxLength;
    uint dwIncrement;
}

struct BCRYPT_OID
{
    uint cbOID;
    ubyte* pbOID;
}

struct BCRYPT_OID_LIST
{
    uint dwOIDCount;
    BCRYPT_OID* pOIDs;
}

struct BCRYPT_PKCS1_PADDING_INFO
{
    const(wchar)* pszAlgId;
}

struct BCRYPT_PSS_PADDING_INFO
{
    const(wchar)* pszAlgId;
    uint cbSalt;
}

struct BCRYPT_OAEP_PADDING_INFO
{
    const(wchar)* pszAlgId;
    ubyte* pbLabel;
    uint cbLabel;
}

struct BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO
{
    uint cbSize;
    uint dwInfoVersion;
    ubyte* pbNonce;
    uint cbNonce;
    ubyte* pbAuthData;
    uint cbAuthData;
    ubyte* pbTag;
    uint cbTag;
    ubyte* pbMacContext;
    uint cbMacContext;
    uint cbAAD;
    ulong cbData;
    uint dwFlags;
}

struct BCryptBuffer
{
    uint cbBuffer;
    uint BufferType;
    void* pvBuffer;
}

struct BCryptBufferDesc
{
    uint ulVersion;
    uint cBuffers;
    BCryptBuffer* pBuffers;
}

struct BCRYPT_KEY_BLOB
{
    uint Magic;
}

struct BCRYPT_RSAKEY_BLOB
{
    uint Magic;
    uint BitLength;
    uint cbPublicExp;
    uint cbModulus;
    uint cbPrime1;
    uint cbPrime2;
}

struct BCRYPT_ECCKEY_BLOB
{
    uint dwMagic;
    uint cbKey;
}

struct SSL_ECCKEY_BLOB
{
    uint dwCurveType;
    uint cbKey;
}

enum ECC_CURVE_TYPE_ENUM
{
    BCRYPT_ECC_PRIME_SHORT_WEIERSTRASS_CURVE = 1,
    BCRYPT_ECC_PRIME_TWISTED_EDWARDS_CURVE = 2,
    BCRYPT_ECC_PRIME_MONTGOMERY_CURVE = 3,
}

enum ECC_CURVE_ALG_ID_ENUM
{
    BCRYPT_NO_CURVE_GENERATION_ALG_ID = 0,
}

struct BCRYPT_ECCFULLKEY_BLOB
{
    uint dwMagic;
    uint dwVersion;
    ECC_CURVE_TYPE_ENUM dwCurveType;
    ECC_CURVE_ALG_ID_ENUM dwCurveGenerationAlgId;
    uint cbFieldLength;
    uint cbSubgroupOrder;
    uint cbCofactor;
    uint cbSeed;
}

struct BCRYPT_DH_KEY_BLOB
{
    uint dwMagic;
    uint cbKey;
}

struct BCRYPT_DH_PARAMETER_HEADER
{
    uint cbLength;
    uint dwMagic;
    uint cbKeyLength;
}

struct BCRYPT_DSA_KEY_BLOB
{
    uint dwMagic;
    uint cbKey;
    ubyte Count;
    ubyte Seed;
    ubyte q;
}

enum HASHALGORITHM_ENUM
{
    DSA_HASH_ALGORITHM_SHA1 = 0,
    DSA_HASH_ALGORITHM_SHA256 = 1,
    DSA_HASH_ALGORITHM_SHA512 = 2,
}

enum DSAFIPSVERSION_ENUM
{
    DSA_FIPS186_2 = 0,
    DSA_FIPS186_3 = 1,
}

struct BCRYPT_DSA_KEY_BLOB_V2
{
    uint dwMagic;
    uint cbKey;
    HASHALGORITHM_ENUM hashAlgorithm;
    DSAFIPSVERSION_ENUM standardVersion;
    uint cbSeedLength;
    uint cbGroupSize;
    ubyte Count;
}

struct BCRYPT_KEY_DATA_BLOB_HEADER
{
    uint dwMagic;
    uint dwVersion;
    uint cbKeyData;
}

struct BCRYPT_DSA_PARAMETER_HEADER
{
    uint cbLength;
    uint dwMagic;
    uint cbKeyLength;
    ubyte Count;
    ubyte Seed;
    ubyte q;
}

struct BCRYPT_DSA_PARAMETER_HEADER_V2
{
    uint cbLength;
    uint dwMagic;
    uint cbKeyLength;
    HASHALGORITHM_ENUM hashAlgorithm;
    DSAFIPSVERSION_ENUM standardVersion;
    uint cbSeedLength;
    uint cbGroupSize;
    ubyte Count;
}

struct BCRYPT_ECC_CURVE_NAMES
{
    uint dwEccCurveNames;
    ushort** pEccCurveNames;
}

enum BCRYPT_HASH_OPERATION_TYPE
{
    BCRYPT_HASH_OPERATION_HASH_DATA = 1,
    BCRYPT_HASH_OPERATION_FINISH_HASH = 2,
}

struct BCRYPT_MULTI_HASH_OPERATION
{
    uint iHash;
    BCRYPT_HASH_OPERATION_TYPE hashOperation;
    ubyte* pbBuffer;
    uint cbBuffer;
}

enum BCRYPT_MULTI_OPERATION_TYPE
{
    BCRYPT_OPERATION_TYPE_HASH = 1,
}

struct BCRYPT_MULTI_OBJECT_LENGTH_STRUCT
{
    uint cbPerObject;
    uint cbPerElement;
}

struct BCRYPT_ALGORITHM_IDENTIFIER
{
    const(wchar)* pszName;
    uint dwClass;
    uint dwFlags;
}

struct BCRYPT_PROVIDER_NAME
{
    const(wchar)* pszProviderName;
}

struct BCRYPT_INTERFACE_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct CRYPT_INTERFACE_REG
{
    uint dwInterface;
    uint dwFlags;
    uint cFunctions;
    ushort** rgpszFunctions;
}

struct CRYPT_IMAGE_REG
{
    const(wchar)* pszImage;
    uint cInterfaces;
    CRYPT_INTERFACE_REG** rgpInterfaces;
}

struct CRYPT_PROVIDER_REG
{
    uint cAliases;
    ushort** rgpszAliases;
    CRYPT_IMAGE_REG* pUM;
    CRYPT_IMAGE_REG* pKM;
}

struct CRYPT_PROVIDERS
{
    uint cProviders;
    ushort** rgpszProviders;
}

struct CRYPT_CONTEXT_CONFIG
{
    uint dwFlags;
    uint dwReserved;
}

struct CRYPT_CONTEXT_FUNCTION_CONFIG
{
    uint dwFlags;
    uint dwReserved;
}

struct CRYPT_CONTEXTS
{
    uint cContexts;
    ushort** rgpszContexts;
}

struct CRYPT_CONTEXT_FUNCTIONS
{
    uint cFunctions;
    ushort** rgpszFunctions;
}

struct CRYPT_CONTEXT_FUNCTION_PROVIDERS
{
    uint cProviders;
    ushort** rgpszProviders;
}

struct CRYPT_PROPERTY_REF
{
    const(wchar)* pszProperty;
    uint cbValue;
    ubyte* pbValue;
}

struct CRYPT_IMAGE_REF
{
    const(wchar)* pszImage;
    uint dwFlags;
}

struct CRYPT_PROVIDER_REF
{
    uint dwInterface;
    const(wchar)* pszFunction;
    const(wchar)* pszProvider;
    uint cProperties;
    CRYPT_PROPERTY_REF** rgpProperties;
    CRYPT_IMAGE_REF* pUM;
    CRYPT_IMAGE_REF* pKM;
}

struct CRYPT_PROVIDER_REFS
{
    uint cProviders;
    CRYPT_PROVIDER_REF** rgpProviders;
}

alias PFN_NCRYPT_ALLOC = extern(Windows) void* function(uint cbSize);
alias PFN_NCRYPT_FREE = extern(Windows) void function(void* pv);
struct NCRYPT_ALLOC_PARA
{
    uint cbSize;
    PFN_NCRYPT_ALLOC pfnAlloc;
    PFN_NCRYPT_FREE pfnFree;
}

struct NCRYPT_CIPHER_PADDING_INFO
{
    uint cbSize;
    uint dwFlags;
    ubyte* pbIV;
    uint cbIV;
    ubyte* pbOtherInfo;
    uint cbOtherInfo;
}

struct NCRYPT_PLATFORM_ATTEST_PADDING_INFO
{
    uint magic;
    uint pcrMask;
}

struct NCRYPT_KEY_ATTEST_PADDING_INFO
{
    uint magic;
    ubyte* pbKeyBlob;
    uint cbKeyBlob;
    ubyte* pbKeyAuth;
    uint cbKeyAuth;
}

struct NCRYPT_ISOLATED_KEY_ATTESTED_ATTRIBUTES
{
    uint Version;
    uint Flags;
    uint cbPublicKeyBlob;
}

struct NCRYPT_VSM_KEY_ATTESTATION_STATEMENT
{
    uint Magic;
    uint Version;
    uint cbSignature;
    uint cbReport;
    uint cbAttributes;
}

struct NCRYPT_VSM_KEY_ATTESTATION_CLAIM_RESTRICTIONS
{
    uint Version;
    ulong TrustletId;
    uint MinSvn;
    uint FlagsMask;
    uint FlagsExpected;
    uint _bitfield;
}

struct NCRYPT_EXPORTED_ISOLATED_KEY_HEADER
{
    uint Version;
    uint KeyUsage;
    uint _bitfield;
    uint cbAlgName;
    uint cbNonce;
    uint cbAuthTag;
    uint cbWrappingKey;
    uint cbIsolatedKey;
}

struct NCRYPT_EXPORTED_ISOLATED_KEY_ENVELOPE
{
    NCRYPT_EXPORTED_ISOLATED_KEY_HEADER Header;
}

struct __NCRYPT_PCP_TPM_WEB_AUTHN_ATTESTATION_STATEMENT
{
    uint Magic;
    uint Version;
    uint HeaderSize;
    uint cbCertifyInfo;
    uint cbSignature;
    uint cbTpmPublic;
}

struct NCRYPT_TPM_PLATFORM_ATTESTATION_STATEMENT
{
    uint Magic;
    uint Version;
    uint pcrAlg;
    uint cbSignature;
    uint cbQuote;
    uint cbPcrs;
}

struct NCryptAlgorithmName
{
    const(wchar)* pszName;
    uint dwClass;
    uint dwAlgOperations;
    uint dwFlags;
}

struct NCryptKeyName
{
    const(wchar)* pszName;
    const(wchar)* pszAlgid;
    uint dwLegacyKeySpec;
    uint dwFlags;
}

struct NCryptProviderName
{
    const(wchar)* pszName;
    const(wchar)* pszComment;
}

struct NCRYPT_UI_POLICY
{
    uint dwVersion;
    uint dwFlags;
    const(wchar)* pszCreationTitle;
    const(wchar)* pszFriendlyName;
    const(wchar)* pszDescription;
}

struct __NCRYPT_KEY_ACCESS_POLICY_BLOB
{
    uint dwVersion;
    uint dwPolicyFlags;
    uint cbUserSid;
    uint cbApplicationSid;
}

struct NCRYPT_SUPPORTED_LENGTHS
{
    uint dwMinLength;
    uint dwMaxLength;
    uint dwIncrement;
    uint dwDefaultLength;
}

struct __NCRYPT_PCP_HMAC_AUTH_SIGNATURE_INFO
{
    uint dwVersion;
    int iExpiration;
    ubyte pabNonce;
    ubyte pabPolicyRef;
    ubyte pabHMAC;
}

struct __NCRYPT_PCP_TPM_FW_VERSION_INFO
{
    ushort major1;
    ushort major2;
    ushort minor1;
    ushort minor2;
}

struct __NCRYPT_PCP_RAW_POLICYDIGEST
{
    uint dwVersion;
    uint cbDigest;
}

struct NCRYPT_KEY_BLOB_HEADER
{
    uint cbSize;
    uint dwMagic;
    uint cbAlgName;
    uint cbKeyData;
}

struct NCRYPT_TPM_LOADABLE_KEY_BLOB_HEADER
{
    uint magic;
    uint cbHeader;
    uint cbPublic;
    uint cbPrivate;
    uint cbName;
}

struct CRYPT_BIT_BLOB
{
    uint cbData;
    ubyte* pbData;
    uint cUnusedBits;
}

struct CRYPT_ALGORITHM_IDENTIFIER
{
    const(char)* pszObjId;
    CRYPTOAPI_BLOB Parameters;
}

struct CRYPT_OBJID_TABLE
{
    uint dwAlgId;
    const(char)* pszObjId;
}

struct CRYPT_HASH_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB Hash;
}

struct CERT_EXTENSION
{
    const(char)* pszObjId;
    BOOL fCritical;
    CRYPTOAPI_BLOB Value;
}

struct CRYPT_ATTRIBUTE_TYPE_VALUE
{
    const(char)* pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct CRYPT_ATTRIBUTE
{
    const(char)* pszObjId;
    uint cValue;
    CRYPTOAPI_BLOB* rgValue;
}

struct CRYPT_ATTRIBUTES
{
    uint cAttr;
    CRYPT_ATTRIBUTE* rgAttr;
}

struct CERT_RDN_ATTR
{
    const(char)* pszObjId;
    uint dwValueType;
    CRYPTOAPI_BLOB Value;
}

struct CERT_RDN
{
    uint cRDNAttr;
    CERT_RDN_ATTR* rgRDNAttr;
}

struct CERT_NAME_INFO
{
    uint cRDN;
    CERT_RDN* rgRDN;
}

struct CERT_NAME_VALUE
{
    uint dwValueType;
    CRYPTOAPI_BLOB Value;
}

struct CERT_PUBLIC_KEY_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPT_BIT_BLOB PublicKey;
}

struct CRYPT_ECC_PRIVATE_KEY_INFO
{
    uint dwVersion;
    CRYPTOAPI_BLOB PrivateKey;
    const(char)* szCurveOid;
    CRYPT_BIT_BLOB PublicKey;
}

struct CRYPT_PRIVATE_KEY_INFO
{
    uint Version;
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPTOAPI_BLOB PrivateKey;
    CRYPT_ATTRIBUTES* pAttributes;
}

struct CRYPT_ENCRYPTED_PRIVATE_KEY_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER EncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedPrivateKey;
}

alias PCRYPT_DECRYPT_PRIVATE_KEY_FUNC = extern(Windows) BOOL function(CRYPT_ALGORITHM_IDENTIFIER Algorithm, CRYPTOAPI_BLOB EncryptedPrivateKey, char* pbClearTextKey, uint* pcbClearTextKey, void* pVoidDecryptFunc);
alias PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC = extern(Windows) BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pAlgorithm, CRYPTOAPI_BLOB* pClearTextPrivateKey, char* pbEncryptedKey, uint* pcbEncryptedKey, void* pVoidEncryptFunc);
alias PCRYPT_RESOLVE_HCRYPTPROV_FUNC = extern(Windows) BOOL function(CRYPT_PRIVATE_KEY_INFO* pPrivateKeyInfo, uint* phCryptProv, void* pVoidResolveFunc);
struct CRYPT_PKCS8_IMPORT_PARAMS
{
    CRYPTOAPI_BLOB PrivateKey;
    PCRYPT_RESOLVE_HCRYPTPROV_FUNC pResolvehCryptProvFunc;
    void* pVoidResolveFunc;
    PCRYPT_DECRYPT_PRIVATE_KEY_FUNC pDecryptPrivateKeyFunc;
    void* pVoidDecryptFunc;
}

struct CRYPT_PKCS8_EXPORT_PARAMS
{
    uint hCryptProv;
    uint dwKeySpec;
    const(char)* pszPrivateKeyObjId;
    PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC pEncryptPrivateKeyFunc;
    void* pVoidEncryptFunc;
}

struct CERT_INFO
{
    uint dwVersion;
    CRYPTOAPI_BLOB SerialNumber;
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPTOAPI_BLOB Issuer;
    FILETIME NotBefore;
    FILETIME NotAfter;
    CRYPTOAPI_BLOB Subject;
    CERT_PUBLIC_KEY_INFO SubjectPublicKeyInfo;
    CRYPT_BIT_BLOB IssuerUniqueId;
    CRYPT_BIT_BLOB SubjectUniqueId;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRL_ENTRY
{
    CRYPTOAPI_BLOB SerialNumber;
    FILETIME RevocationDate;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRL_INFO
{
    uint dwVersion;
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPTOAPI_BLOB Issuer;
    FILETIME ThisUpdate;
    FILETIME NextUpdate;
    uint cCRLEntry;
    CRL_ENTRY* rgCRLEntry;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CERT_OR_CRL_BLOB
{
    uint dwChoice;
    uint cbEncoded;
    ubyte* pbEncoded;
}

struct CERT_OR_CRL_BUNDLE
{
    uint cItem;
    CERT_OR_CRL_BLOB* rgItem;
}

struct CERT_REQUEST_INFO
{
    uint dwVersion;
    CRYPTOAPI_BLOB Subject;
    CERT_PUBLIC_KEY_INFO SubjectPublicKeyInfo;
    uint cAttribute;
    CRYPT_ATTRIBUTE* rgAttribute;
}

struct CERT_KEYGEN_REQUEST_INFO
{
    uint dwVersion;
    CERT_PUBLIC_KEY_INFO SubjectPublicKeyInfo;
    const(wchar)* pwszChallengeString;
}

struct CERT_SIGNED_CONTENT_INFO
{
    CRYPTOAPI_BLOB ToBeSigned;
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPT_BIT_BLOB Signature;
}

struct CTL_USAGE
{
    uint cUsageIdentifier;
    byte** rgpszUsageIdentifier;
}

struct CTL_ENTRY
{
    CRYPTOAPI_BLOB SubjectIdentifier;
    uint cAttribute;
    CRYPT_ATTRIBUTE* rgAttribute;
}

struct CTL_INFO
{
    uint dwVersion;
    CTL_USAGE SubjectUsage;
    CRYPTOAPI_BLOB ListIdentifier;
    CRYPTOAPI_BLOB SequenceNumber;
    FILETIME ThisUpdate;
    FILETIME NextUpdate;
    CRYPT_ALGORITHM_IDENTIFIER SubjectAlgorithm;
    uint cCTLEntry;
    CTL_ENTRY* rgCTLEntry;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRYPT_TIME_STAMP_REQUEST_INFO
{
    const(char)* pszTimeStampAlgorithm;
    const(char)* pszContentType;
    CRYPTOAPI_BLOB Content;
    uint cAttribute;
    CRYPT_ATTRIBUTE* rgAttribute;
}

struct CRYPT_ENROLLMENT_NAME_VALUE_PAIR
{
    const(wchar)* pwszName;
    const(wchar)* pwszValue;
}

struct CRYPT_CSP_PROVIDER
{
    uint dwKeySpec;
    const(wchar)* pwszProviderName;
    CRYPT_BIT_BLOB Signature;
}

alias PFN_CRYPT_ALLOC = extern(Windows) void* function(uint cbSize);
alias PFN_CRYPT_FREE = extern(Windows) void function(void* pv);
struct CRYPT_ENCODE_PARA
{
    uint cbSize;
    PFN_CRYPT_ALLOC pfnAlloc;
    PFN_CRYPT_FREE pfnFree;
}

struct CRYPT_DECODE_PARA
{
    uint cbSize;
    PFN_CRYPT_ALLOC pfnAlloc;
    PFN_CRYPT_FREE pfnFree;
}

struct CERT_EXTENSIONS
{
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CERT_AUTHORITY_KEY_ID_INFO
{
    CRYPTOAPI_BLOB KeyId;
    CRYPTOAPI_BLOB CertIssuer;
    CRYPTOAPI_BLOB CertSerialNumber;
}

struct CERT_PRIVATE_KEY_VALIDITY
{
    FILETIME NotBefore;
    FILETIME NotAfter;
}

struct CERT_KEY_ATTRIBUTES_INFO
{
    CRYPTOAPI_BLOB KeyId;
    CRYPT_BIT_BLOB IntendedKeyUsage;
    CERT_PRIVATE_KEY_VALIDITY* pPrivateKeyUsagePeriod;
}

struct CERT_POLICY_ID
{
    uint cCertPolicyElementId;
    byte** rgpszCertPolicyElementId;
}

struct CERT_KEY_USAGE_RESTRICTION_INFO
{
    uint cCertPolicyId;
    CERT_POLICY_ID* rgCertPolicyId;
    CRYPT_BIT_BLOB RestrictedKeyUsage;
}

struct CERT_OTHER_NAME
{
    const(char)* pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct CERT_ALT_NAME_ENTRY
{
    uint dwAltNameChoice;
    _Anonymous_e__Union Anonymous;
}

struct CERT_ALT_NAME_INFO
{
    uint cAltEntry;
    CERT_ALT_NAME_ENTRY* rgAltEntry;
}

struct CERT_BASIC_CONSTRAINTS_INFO
{
    CRYPT_BIT_BLOB SubjectType;
    BOOL fPathLenConstraint;
    uint dwPathLenConstraint;
    uint cSubtreesConstraint;
    CRYPTOAPI_BLOB* rgSubtreesConstraint;
}

struct CERT_BASIC_CONSTRAINTS2_INFO
{
    BOOL fCA;
    BOOL fPathLenConstraint;
    uint dwPathLenConstraint;
}

struct CERT_POLICY_QUALIFIER_INFO
{
    const(char)* pszPolicyQualifierId;
    CRYPTOAPI_BLOB Qualifier;
}

struct CERT_POLICY_INFO
{
    const(char)* pszPolicyIdentifier;
    uint cPolicyQualifier;
    CERT_POLICY_QUALIFIER_INFO* rgPolicyQualifier;
}

struct CERT_POLICIES_INFO
{
    uint cPolicyInfo;
    CERT_POLICY_INFO* rgPolicyInfo;
}

struct CERT_POLICY_QUALIFIER_NOTICE_REFERENCE
{
    const(char)* pszOrganization;
    uint cNoticeNumbers;
    int* rgNoticeNumbers;
}

struct CERT_POLICY_QUALIFIER_USER_NOTICE
{
    CERT_POLICY_QUALIFIER_NOTICE_REFERENCE* pNoticeReference;
    const(wchar)* pszDisplayText;
}

struct CPS_URLS
{
    const(wchar)* pszURL;
    CRYPT_ALGORITHM_IDENTIFIER* pAlgorithm;
    CRYPTOAPI_BLOB* pDigest;
}

struct CERT_POLICY95_QUALIFIER1
{
    const(wchar)* pszPracticesReference;
    const(char)* pszNoticeIdentifier;
    const(char)* pszNSINoticeIdentifier;
    uint cCPSURLs;
    CPS_URLS* rgCPSURLs;
}

struct CERT_POLICY_MAPPING
{
    const(char)* pszIssuerDomainPolicy;
    const(char)* pszSubjectDomainPolicy;
}

struct CERT_POLICY_MAPPINGS_INFO
{
    uint cPolicyMapping;
    CERT_POLICY_MAPPING* rgPolicyMapping;
}

struct CERT_POLICY_CONSTRAINTS_INFO
{
    BOOL fRequireExplicitPolicy;
    uint dwRequireExplicitPolicySkipCerts;
    BOOL fInhibitPolicyMapping;
    uint dwInhibitPolicyMappingSkipCerts;
}

struct CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY
{
    const(char)* pszObjId;
    uint cValue;
    CRYPTOAPI_BLOB* rgValue;
}

struct CRYPT_CONTENT_INFO
{
    const(char)* pszObjId;
    CRYPTOAPI_BLOB Content;
}

struct CRYPT_SEQUENCE_OF_ANY
{
    uint cValue;
    CRYPTOAPI_BLOB* rgValue;
}

struct CERT_AUTHORITY_KEY_ID2_INFO
{
    CRYPTOAPI_BLOB KeyId;
    CERT_ALT_NAME_INFO AuthorityCertIssuer;
    CRYPTOAPI_BLOB AuthorityCertSerialNumber;
}

struct CERT_ACCESS_DESCRIPTION
{
    const(char)* pszAccessMethod;
    CERT_ALT_NAME_ENTRY AccessLocation;
}

struct CERT_AUTHORITY_INFO_ACCESS
{
    uint cAccDescr;
    CERT_ACCESS_DESCRIPTION* rgAccDescr;
}

struct CRL_DIST_POINT_NAME
{
    uint dwDistPointNameChoice;
    _Anonymous_e__Union Anonymous;
}

struct CRL_DIST_POINT
{
    CRL_DIST_POINT_NAME DistPointName;
    CRYPT_BIT_BLOB ReasonFlags;
    CERT_ALT_NAME_INFO CRLIssuer;
}

struct CRL_DIST_POINTS_INFO
{
    uint cDistPoint;
    CRL_DIST_POINT* rgDistPoint;
}

struct CROSS_CERT_DIST_POINTS_INFO
{
    uint dwSyncDeltaTime;
    uint cDistPoint;
    CERT_ALT_NAME_INFO* rgDistPoint;
}

struct CERT_PAIR
{
    CRYPTOAPI_BLOB Forward;
    CRYPTOAPI_BLOB Reverse;
}

struct CRL_ISSUING_DIST_POINT
{
    CRL_DIST_POINT_NAME DistPointName;
    BOOL fOnlyContainsUserCerts;
    BOOL fOnlyContainsCACerts;
    CRYPT_BIT_BLOB OnlySomeReasonFlags;
    BOOL fIndirectCRL;
}

struct CERT_GENERAL_SUBTREE
{
    CERT_ALT_NAME_ENTRY Base;
    uint dwMinimum;
    BOOL fMaximum;
    uint dwMaximum;
}

struct CERT_NAME_CONSTRAINTS_INFO
{
    uint cPermittedSubtree;
    CERT_GENERAL_SUBTREE* rgPermittedSubtree;
    uint cExcludedSubtree;
    CERT_GENERAL_SUBTREE* rgExcludedSubtree;
}

struct CERT_DSS_PARAMETERS
{
    CRYPTOAPI_BLOB p;
    CRYPTOAPI_BLOB q;
    CRYPTOAPI_BLOB g;
}

struct CERT_DH_PARAMETERS
{
    CRYPTOAPI_BLOB p;
    CRYPTOAPI_BLOB g;
}

struct CERT_ECC_SIGNATURE
{
    CRYPTOAPI_BLOB r;
    CRYPTOAPI_BLOB s;
}

struct CERT_X942_DH_VALIDATION_PARAMS
{
    CRYPT_BIT_BLOB seed;
    uint pgenCounter;
}

struct CERT_X942_DH_PARAMETERS
{
    CRYPTOAPI_BLOB p;
    CRYPTOAPI_BLOB g;
    CRYPTOAPI_BLOB q;
    CRYPTOAPI_BLOB j;
    CERT_X942_DH_VALIDATION_PARAMS* pValidationParams;
}

struct CRYPT_X942_OTHER_INFO
{
    const(char)* pszContentEncryptionObjId;
    ubyte rgbCounter;
    ubyte rgbKeyLength;
    CRYPTOAPI_BLOB PubInfo;
}

struct CRYPT_ECC_CMS_SHARED_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPTOAPI_BLOB EntityUInfo;
    ubyte rgbSuppPubInfo;
}

struct CRYPT_RC2_CBC_PARAMETERS
{
    uint dwVersion;
    BOOL fIV;
    ubyte rgbIV;
}

struct CRYPT_SMIME_CAPABILITY
{
    const(char)* pszObjId;
    CRYPTOAPI_BLOB Parameters;
}

struct CRYPT_SMIME_CAPABILITIES
{
    uint cCapability;
    CRYPT_SMIME_CAPABILITY* rgCapability;
}

struct CERT_QC_STATEMENT
{
    const(char)* pszStatementId;
    CRYPTOAPI_BLOB StatementInfo;
}

struct CERT_QC_STATEMENTS_EXT_INFO
{
    uint cStatement;
    CERT_QC_STATEMENT* rgStatement;
}

struct CRYPT_MASK_GEN_ALGORITHM
{
    const(char)* pszObjId;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
}

struct CRYPT_RSA_SSA_PSS_PARAMETERS
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_MASK_GEN_ALGORITHM MaskGenAlgorithm;
    uint dwSaltLength;
    uint dwTrailerField;
}

struct CRYPT_PSOURCE_ALGORITHM
{
    const(char)* pszObjId;
    CRYPTOAPI_BLOB EncodingParameters;
}

struct CRYPT_RSAES_OAEP_PARAMETERS
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_MASK_GEN_ALGORITHM MaskGenAlgorithm;
    CRYPT_PSOURCE_ALGORITHM PSourceAlgorithm;
}

struct CMC_TAGGED_ATTRIBUTE
{
    uint dwBodyPartID;
    CRYPT_ATTRIBUTE Attribute;
}

struct CMC_TAGGED_CERT_REQUEST
{
    uint dwBodyPartID;
    CRYPTOAPI_BLOB SignedCertRequest;
}

struct CMC_TAGGED_REQUEST
{
    uint dwTaggedRequestChoice;
    _Anonymous_e__Union Anonymous;
}

struct CMC_TAGGED_CONTENT_INFO
{
    uint dwBodyPartID;
    CRYPTOAPI_BLOB EncodedContentInfo;
}

struct CMC_TAGGED_OTHER_MSG
{
    uint dwBodyPartID;
    const(char)* pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct CMC_DATA_INFO
{
    uint cTaggedAttribute;
    CMC_TAGGED_ATTRIBUTE* rgTaggedAttribute;
    uint cTaggedRequest;
    CMC_TAGGED_REQUEST* rgTaggedRequest;
    uint cTaggedContentInfo;
    CMC_TAGGED_CONTENT_INFO* rgTaggedContentInfo;
    uint cTaggedOtherMsg;
    CMC_TAGGED_OTHER_MSG* rgTaggedOtherMsg;
}

struct CMC_RESPONSE_INFO
{
    uint cTaggedAttribute;
    CMC_TAGGED_ATTRIBUTE* rgTaggedAttribute;
    uint cTaggedContentInfo;
    CMC_TAGGED_CONTENT_INFO* rgTaggedContentInfo;
    uint cTaggedOtherMsg;
    CMC_TAGGED_OTHER_MSG* rgTaggedOtherMsg;
}

struct CMC_PEND_INFO
{
    CRYPTOAPI_BLOB PendToken;
    FILETIME PendTime;
}

struct CMC_STATUS_INFO
{
    uint dwStatus;
    uint cBodyList;
    uint* rgdwBodyList;
    const(wchar)* pwszStatusString;
    uint dwOtherInfoChoice;
    _Anonymous_e__Union Anonymous;
}

struct CMC_ADD_EXTENSIONS_INFO
{
    uint dwCmcDataReference;
    uint cCertReference;
    uint* rgdwCertReference;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CMC_ADD_ATTRIBUTES_INFO
{
    uint dwCmcDataReference;
    uint cCertReference;
    uint* rgdwCertReference;
    uint cAttribute;
    CRYPT_ATTRIBUTE* rgAttribute;
}

struct CERT_TEMPLATE_EXT
{
    const(char)* pszObjId;
    uint dwMajorVersion;
    BOOL fMinorVersion;
    uint dwMinorVersion;
}

struct CERT_HASHED_URL
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB Hash;
    const(wchar)* pwszUrl;
}

struct CERT_LOGOTYPE_DETAILS
{
    const(wchar)* pwszMimeType;
    uint cHashedUrl;
    CERT_HASHED_URL* rgHashedUrl;
}

struct CERT_LOGOTYPE_REFERENCE
{
    uint cHashedUrl;
    CERT_HASHED_URL* rgHashedUrl;
}

struct CERT_LOGOTYPE_IMAGE_INFO
{
    uint dwLogotypeImageInfoChoice;
    uint dwFileSize;
    uint dwXSize;
    uint dwYSize;
    uint dwLogotypeImageResolutionChoice;
    _Anonymous_e__Union Anonymous;
    const(wchar)* pwszLanguage;
}

struct CERT_LOGOTYPE_IMAGE
{
    CERT_LOGOTYPE_DETAILS LogotypeDetails;
    CERT_LOGOTYPE_IMAGE_INFO* pLogotypeImageInfo;
}

struct CERT_LOGOTYPE_AUDIO_INFO
{
    uint dwFileSize;
    uint dwPlayTime;
    uint dwChannels;
    uint dwSampleRate;
    const(wchar)* pwszLanguage;
}

struct CERT_LOGOTYPE_AUDIO
{
    CERT_LOGOTYPE_DETAILS LogotypeDetails;
    CERT_LOGOTYPE_AUDIO_INFO* pLogotypeAudioInfo;
}

struct CERT_LOGOTYPE_DATA
{
    uint cLogotypeImage;
    CERT_LOGOTYPE_IMAGE* rgLogotypeImage;
    uint cLogotypeAudio;
    CERT_LOGOTYPE_AUDIO* rgLogotypeAudio;
}

struct CERT_LOGOTYPE_INFO
{
    uint dwLogotypeInfoChoice;
    _Anonymous_e__Union Anonymous;
}

struct CERT_OTHER_LOGOTYPE_INFO
{
    const(char)* pszObjId;
    CERT_LOGOTYPE_INFO LogotypeInfo;
}

struct CERT_LOGOTYPE_EXT_INFO
{
    uint cCommunityLogo;
    CERT_LOGOTYPE_INFO* rgCommunityLogo;
    CERT_LOGOTYPE_INFO* pIssuerLogo;
    CERT_LOGOTYPE_INFO* pSubjectLogo;
    uint cOtherLogo;
    CERT_OTHER_LOGOTYPE_INFO* rgOtherLogo;
}

struct CERT_BIOMETRIC_DATA
{
    uint dwTypeOfBiometricDataChoice;
    _Anonymous_e__Union Anonymous;
    CERT_HASHED_URL HashedUrl;
}

struct CERT_BIOMETRIC_EXT_INFO
{
    uint cBiometricData;
    CERT_BIOMETRIC_DATA* rgBiometricData;
}

struct OCSP_SIGNATURE_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPT_BIT_BLOB Signature;
    uint cCertEncoded;
    CRYPTOAPI_BLOB* rgCertEncoded;
}

struct OCSP_SIGNED_REQUEST_INFO
{
    CRYPTOAPI_BLOB ToBeSigned;
    OCSP_SIGNATURE_INFO* pOptionalSignatureInfo;
}

struct OCSP_CERT_ID
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB IssuerNameHash;
    CRYPTOAPI_BLOB IssuerKeyHash;
    CRYPTOAPI_BLOB SerialNumber;
}

struct OCSP_REQUEST_ENTRY
{
    OCSP_CERT_ID CertId;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct OCSP_REQUEST_INFO
{
    uint dwVersion;
    CERT_ALT_NAME_ENTRY* pRequestorName;
    uint cRequestEntry;
    OCSP_REQUEST_ENTRY* rgRequestEntry;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct OCSP_RESPONSE_INFO
{
    uint dwStatus;
    const(char)* pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct OCSP_BASIC_SIGNED_RESPONSE_INFO
{
    CRYPTOAPI_BLOB ToBeSigned;
    OCSP_SIGNATURE_INFO SignatureInfo;
}

struct OCSP_BASIC_REVOKED_INFO
{
    FILETIME RevocationDate;
    uint dwCrlReasonCode;
}

struct OCSP_BASIC_RESPONSE_ENTRY
{
    OCSP_CERT_ID CertId;
    uint dwCertStatus;
    _Anonymous_e__Union Anonymous;
    FILETIME ThisUpdate;
    FILETIME NextUpdate;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct OCSP_BASIC_RESPONSE_INFO
{
    uint dwVersion;
    uint dwResponderIdChoice;
    _Anonymous_e__Union Anonymous;
    FILETIME ProducedAt;
    uint cResponseEntry;
    OCSP_BASIC_RESPONSE_ENTRY* rgResponseEntry;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CERT_SUPPORTED_ALGORITHM_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPT_BIT_BLOB IntendedKeyUsage;
    CERT_POLICIES_INFO IntendedCertPolicies;
}

struct CERT_TPM_SPECIFICATION_INFO
{
    const(wchar)* pwszFamily;
    uint dwLevel;
    uint dwRevision;
}

struct CRYPT_OID_FUNC_ENTRY
{
    const(char)* pszOID;
    void* pvFuncAddr;
}

alias PFN_CRYPT_ENUM_OID_FUNC = extern(Windows) BOOL function(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, uint cValue, char* rgdwValueType, char* rgpwszValueName, char* rgpbValueData, char* rgcbValueData, void* pvArg);
struct CRYPT_OID_INFO
{
    uint cbSize;
    const(char)* pszOID;
    const(wchar)* pwszName;
    uint dwGroupId;
    _Anonymous_e__Union Anonymous;
    CRYPTOAPI_BLOB ExtraInfo;
}

alias PFN_CRYPT_ENUM_OID_INFO = extern(Windows) BOOL function(CRYPT_OID_INFO* pInfo, void* pvArg);
struct CERT_STRONG_SIGN_SERIALIZED_INFO
{
    uint dwFlags;
    const(wchar)* pwszCNGSignHashAlgids;
    const(wchar)* pwszCNGPubKeyMinBitLengths;
}

struct CERT_STRONG_SIGN_PARA
{
    uint cbSize;
    uint dwInfoChoice;
    _Anonymous_e__Union Anonymous;
}

struct CERT_ISSUER_SERIAL_NUMBER
{
    CRYPTOAPI_BLOB Issuer;
    CRYPTOAPI_BLOB SerialNumber;
}

struct CERT_ID
{
    uint dwIdChoice;
    _Anonymous_e__Union Anonymous;
}

struct CMSG_SIGNER_ENCODE_INFO
{
    uint cbSize;
    CERT_INFO* pCertInfo;
    _Anonymous_e__Union Anonymous;
    uint dwKeySpec;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void* pvHashAuxInfo;
    uint cAuthAttr;
    CRYPT_ATTRIBUTE* rgAuthAttr;
    uint cUnauthAttr;
    CRYPT_ATTRIBUTE* rgUnauthAttr;
}

struct CMSG_SIGNED_ENCODE_INFO
{
    uint cbSize;
    uint cSigners;
    CMSG_SIGNER_ENCODE_INFO* rgSigners;
    uint cCertEncoded;
    CRYPTOAPI_BLOB* rgCertEncoded;
    uint cCrlEncoded;
    CRYPTOAPI_BLOB* rgCrlEncoded;
}

struct CMSG_ENVELOPED_ENCODE_INFO
{
    uint cbSize;
    uint hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void* pvEncryptionAuxInfo;
    uint cRecipients;
    CERT_INFO** rgpRecipients;
}

struct CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO
{
    uint cbSize;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    void* pvKeyEncryptionAuxInfo;
    uint hCryptProv;
    CRYPT_BIT_BLOB RecipientPublicKey;
    CERT_ID RecipientId;
}

struct CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO
{
    uint cbSize;
    CRYPT_BIT_BLOB RecipientPublicKey;
    CERT_ID RecipientId;
    FILETIME Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO
{
    uint cbSize;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    void* pvKeyEncryptionAuxInfo;
    CRYPT_ALGORITHM_IDENTIFIER KeyWrapAlgorithm;
    void* pvKeyWrapAuxInfo;
    uint hCryptProv;
    uint dwKeySpec;
    uint dwKeyChoice;
    _Anonymous_e__Union Anonymous;
    CRYPTOAPI_BLOB UserKeyingMaterial;
    uint cRecipientEncryptedKeys;
    CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO** rgpRecipientEncryptedKeys;
}

struct CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO
{
    uint cbSize;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    void* pvKeyEncryptionAuxInfo;
    uint hCryptProv;
    uint dwKeyChoice;
    _Anonymous_e__Union Anonymous;
    CRYPTOAPI_BLOB KeyId;
    FILETIME Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_RECIPIENT_ENCODE_INFO
{
    uint dwRecipientChoice;
    _Anonymous_e__Union Anonymous;
}

struct CMSG_RC2_AUX_INFO
{
    uint cbSize;
    uint dwBitLen;
}

struct CMSG_SP3_COMPATIBLE_AUX_INFO
{
    uint cbSize;
    uint dwFlags;
}

struct CMSG_RC4_AUX_INFO
{
    uint cbSize;
    uint dwBitLen;
}

struct CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO
{
    uint cbSize;
    CMSG_SIGNED_ENCODE_INFO SignedInfo;
    CMSG_ENVELOPED_ENCODE_INFO EnvelopedInfo;
}

struct CMSG_HASHED_ENCODE_INFO
{
    uint cbSize;
    uint hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void* pvHashAuxInfo;
}

struct CMSG_ENCRYPTED_ENCODE_INFO
{
    uint cbSize;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void* pvEncryptionAuxInfo;
}

alias PFN_CMSG_STREAM_OUTPUT = extern(Windows) BOOL function(const(void)* pvArg, char* pbData, uint cbData, BOOL fFinal);
struct CMSG_STREAM_INFO
{
    uint cbContent;
    PFN_CMSG_STREAM_OUTPUT pfnStreamOutput;
    void* pvArg;
}

struct CMSG_SIGNER_INFO
{
    uint dwVersion;
    CRYPTOAPI_BLOB Issuer;
    CRYPTOAPI_BLOB SerialNumber;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_ALGORITHM_IDENTIFIER HashEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedHash;
    CRYPT_ATTRIBUTES AuthAttrs;
    CRYPT_ATTRIBUTES UnauthAttrs;
}

struct CMSG_CMS_SIGNER_INFO
{
    uint dwVersion;
    CERT_ID SignerId;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_ALGORITHM_IDENTIFIER HashEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedHash;
    CRYPT_ATTRIBUTES AuthAttrs;
    CRYPT_ATTRIBUTES UnauthAttrs;
}

struct CMSG_KEY_TRANS_RECIPIENT_INFO
{
    uint dwVersion;
    CERT_ID RecipientId;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
}

struct CMSG_RECIPIENT_ENCRYPTED_KEY_INFO
{
    CERT_ID RecipientId;
    CRYPTOAPI_BLOB EncryptedKey;
    FILETIME Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_KEY_AGREE_RECIPIENT_INFO
{
    uint dwVersion;
    uint dwOriginatorChoice;
    _Anonymous_e__Union Anonymous;
    CRYPTOAPI_BLOB UserKeyingMaterial;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    uint cRecipientEncryptedKeys;
    CMSG_RECIPIENT_ENCRYPTED_KEY_INFO** rgpRecipientEncryptedKeys;
}

struct CMSG_MAIL_LIST_RECIPIENT_INFO
{
    uint dwVersion;
    CRYPTOAPI_BLOB KeyId;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
    FILETIME Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_CMS_RECIPIENT_INFO
{
    uint dwRecipientChoice;
    _Anonymous_e__Union Anonymous;
}

struct CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA
{
    uint cbSize;
    uint hCryptProv;
    uint dwSignerIndex;
    uint dwSignerType;
    void* pvSigner;
}

struct CMSG_CTRL_DECRYPT_PARA
{
    uint cbSize;
    _Anonymous_e__Union Anonymous;
    uint dwKeySpec;
    uint dwRecipientIndex;
}

struct CMSG_CTRL_KEY_TRANS_DECRYPT_PARA
{
    uint cbSize;
    _Anonymous_e__Union Anonymous;
    uint dwKeySpec;
    CMSG_KEY_TRANS_RECIPIENT_INFO* pKeyTrans;
    uint dwRecipientIndex;
}

struct CMSG_CTRL_KEY_AGREE_DECRYPT_PARA
{
    uint cbSize;
    _Anonymous_e__Union Anonymous;
    uint dwKeySpec;
    CMSG_KEY_AGREE_RECIPIENT_INFO* pKeyAgree;
    uint dwRecipientIndex;
    uint dwRecipientEncryptedKeyIndex;
    CRYPT_BIT_BLOB OriginatorPublicKey;
}

struct CMSG_CTRL_MAIL_LIST_DECRYPT_PARA
{
    uint cbSize;
    uint hCryptProv;
    CMSG_MAIL_LIST_RECIPIENT_INFO* pMailList;
    uint dwRecipientIndex;
    uint dwKeyChoice;
    _Anonymous_e__Union Anonymous;
}

struct CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA
{
    uint cbSize;
    uint dwSignerIndex;
    CRYPTOAPI_BLOB blob;
}

struct CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA
{
    uint cbSize;
    uint dwSignerIndex;
    uint dwUnauthAttrIndex;
}

alias PFN_CMSG_ALLOC = extern(Windows) void* function(uint cb);
alias PFN_CMSG_FREE = extern(Windows) void function(void* pv);
alias PFN_CMSG_GEN_ENCRYPT_KEY = extern(Windows) BOOL function(uint* phCryptProv, CRYPT_ALGORITHM_IDENTIFIER* paiEncrypt, void* pvEncryptAuxInfo, CERT_PUBLIC_KEY_INFO* pPublicKeyInfo, PFN_CMSG_ALLOC pfnAlloc, uint* phEncryptKey, ubyte** ppbEncryptParameters, uint* pcbEncryptParameters);
alias PFN_CMSG_EXPORT_ENCRYPT_KEY = extern(Windows) BOOL function(uint hCryptProv, uint hEncryptKey, CERT_PUBLIC_KEY_INFO* pPublicKeyInfo, char* pbData, uint* pcbData);
alias PFN_CMSG_IMPORT_ENCRYPT_KEY = extern(Windows) BOOL function(uint hCryptProv, uint dwKeySpec, CRYPT_ALGORITHM_IDENTIFIER* paiEncrypt, CRYPT_ALGORITHM_IDENTIFIER* paiPubKey, char* pbEncodedKey, uint cbEncodedKey, uint* phEncryptKey);
struct CMSG_CONTENT_ENCRYPT_INFO
{
    uint cbSize;
    uint hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void* pvEncryptionAuxInfo;
    uint cRecipients;
    CMSG_RECIPIENT_ENCODE_INFO* rgCmsRecipients;
    PFN_CMSG_ALLOC pfnAlloc;
    PFN_CMSG_FREE pfnFree;
    uint dwEncryptFlags;
    _Anonymous_e__Union Anonymous;
    uint dwFlags;
    BOOL fCNG;
    ubyte* pbCNGContentEncryptKeyObject;
    ubyte* pbContentEncryptKey;
    uint cbContentEncryptKey;
}

alias PFN_CMSG_GEN_CONTENT_ENCRYPT_KEY = extern(Windows) BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, uint dwFlags, void* pvReserved);
struct CMSG_KEY_TRANS_ENCRYPT_INFO
{
    uint cbSize;
    uint dwRecipientIndex;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
    uint dwFlags;
}

alias PFN_CMSG_EXPORT_KEY_TRANS = extern(Windows) BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO* pKeyTransEncodeInfo, CMSG_KEY_TRANS_ENCRYPT_INFO* pKeyTransEncryptInfo, uint dwFlags, void* pvReserved);
struct CMSG_KEY_AGREE_KEY_ENCRYPT_INFO
{
    uint cbSize;
    CRYPTOAPI_BLOB EncryptedKey;
}

struct CMSG_KEY_AGREE_ENCRYPT_INFO
{
    uint cbSize;
    uint dwRecipientIndex;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB UserKeyingMaterial;
    uint dwOriginatorChoice;
    _Anonymous_e__Union Anonymous;
    uint cKeyAgreeKeyEncryptInfo;
    CMSG_KEY_AGREE_KEY_ENCRYPT_INFO** rgpKeyAgreeKeyEncryptInfo;
    uint dwFlags;
}

alias PFN_CMSG_EXPORT_KEY_AGREE = extern(Windows) BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO* pKeyAgreeEncodeInfo, CMSG_KEY_AGREE_ENCRYPT_INFO* pKeyAgreeEncryptInfo, uint dwFlags, void* pvReserved);
struct CMSG_MAIL_LIST_ENCRYPT_INFO
{
    uint cbSize;
    uint dwRecipientIndex;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
    uint dwFlags;
}

alias PFN_CMSG_EXPORT_MAIL_LIST = extern(Windows) BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO* pMailListEncodeInfo, CMSG_MAIL_LIST_ENCRYPT_INFO* pMailListEncryptInfo, uint dwFlags, void* pvReserved);
alias PFN_CMSG_IMPORT_KEY_TRANS = extern(Windows) BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pContentEncryptionAlgorithm, CMSG_CTRL_KEY_TRANS_DECRYPT_PARA* pKeyTransDecryptPara, uint dwFlags, void* pvReserved, uint* phContentEncryptKey);
alias PFN_CMSG_IMPORT_KEY_AGREE = extern(Windows) BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pContentEncryptionAlgorithm, CMSG_CTRL_KEY_AGREE_DECRYPT_PARA* pKeyAgreeDecryptPara, uint dwFlags, void* pvReserved, uint* phContentEncryptKey);
alias PFN_CMSG_IMPORT_MAIL_LIST = extern(Windows) BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pContentEncryptionAlgorithm, CMSG_CTRL_MAIL_LIST_DECRYPT_PARA* pMailListDecryptPara, uint dwFlags, void* pvReserved, uint* phContentEncryptKey);
struct CMSG_CNG_CONTENT_DECRYPT_INFO
{
    uint cbSize;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    PFN_CMSG_ALLOC pfnAlloc;
    PFN_CMSG_FREE pfnFree;
    uint hNCryptKey;
    ubyte* pbContentEncryptKey;
    uint cbContentEncryptKey;
    void* hCNGContentEncryptKey;
    ubyte* pbCNGContentEncryptKeyObject;
}

alias PFN_CMSG_CNG_IMPORT_KEY_TRANS = extern(Windows) BOOL function(CMSG_CNG_CONTENT_DECRYPT_INFO* pCNGContentDecryptInfo, CMSG_CTRL_KEY_TRANS_DECRYPT_PARA* pKeyTransDecryptPara, uint dwFlags, void* pvReserved);
alias PFN_CMSG_CNG_IMPORT_KEY_AGREE = extern(Windows) BOOL function(CMSG_CNG_CONTENT_DECRYPT_INFO* pCNGContentDecryptInfo, CMSG_CTRL_KEY_AGREE_DECRYPT_PARA* pKeyAgreeDecryptPara, uint dwFlags, void* pvReserved);
alias PFN_CMSG_CNG_IMPORT_CONTENT_ENCRYPT_KEY = extern(Windows) BOOL function(CMSG_CNG_CONTENT_DECRYPT_INFO* pCNGContentDecryptInfo, uint dwFlags, void* pvReserved);
struct CERT_CONTEXT
{
    uint dwCertEncodingType;
    ubyte* pbCertEncoded;
    uint cbCertEncoded;
    CERT_INFO* pCertInfo;
    void* hCertStore;
}

struct CRL_CONTEXT
{
    uint dwCertEncodingType;
    ubyte* pbCrlEncoded;
    uint cbCrlEncoded;
    CRL_INFO* pCrlInfo;
    void* hCertStore;
}

struct CTL_CONTEXT
{
    uint dwMsgAndCertEncodingType;
    ubyte* pbCtlEncoded;
    uint cbCtlEncoded;
    CTL_INFO* pCtlInfo;
    void* hCertStore;
    void* hCryptMsg;
    ubyte* pbCtlContent;
    uint cbCtlContent;
}

enum CertKeyType
{
    KeyTypeOther = 0,
    KeyTypeVirtualSmartCard = 1,
    KeyTypePhysicalSmartCard = 2,
    KeyTypePassport = 3,
    KeyTypePassportRemote = 4,
    KeyTypePassportSmartCard = 5,
    KeyTypeHardware = 6,
    KeyTypeSoftware = 7,
    KeyTypeSelfSigned = 8,
}

struct CRYPT_KEY_PROV_PARAM
{
    uint dwParam;
    ubyte* pbData;
    uint cbData;
    uint dwFlags;
}

struct CRYPT_KEY_PROV_INFO
{
    const(wchar)* pwszContainerName;
    const(wchar)* pwszProvName;
    uint dwProvType;
    uint dwFlags;
    uint cProvParam;
    CRYPT_KEY_PROV_PARAM* rgProvParam;
    uint dwKeySpec;
}

struct CERT_KEY_CONTEXT
{
    uint cbSize;
    _Anonymous_e__Union Anonymous;
    uint dwKeySpec;
}

struct ROOT_INFO_LUID
{
    uint LowPart;
    int HighPart;
}

struct CRYPT_SMART_CARD_ROOT_INFO
{
    ubyte rgbCardID;
    ROOT_INFO_LUID luid;
}

struct CERT_SYSTEM_STORE_RELOCATE_PARA
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct CERT_REGISTRY_STORE_CLIENT_GPT_PARA
{
    HKEY hKeyBase;
    const(wchar)* pwszRegPath;
}

struct CERT_REGISTRY_STORE_ROAMING_PARA
{
    HKEY hKey;
    const(wchar)* pwszStoreDirectory;
}

struct CERT_LDAP_STORE_OPENED_PARA
{
    void* pvLdapSessionHandle;
    const(wchar)* pwszLdapUrl;
}

struct CERT_STORE_PROV_INFO
{
    uint cbSize;
    uint cStoreProvFunc;
    void** rgpvStoreProvFunc;
    void* hStoreProv;
    uint dwStoreProvFlags;
    void* hStoreProvFuncAddr2;
}

alias PFN_CERT_DLL_OPEN_STORE_PROV_FUNC = extern(Windows) BOOL function(const(char)* lpszStoreProvider, uint dwEncodingType, uint hCryptProv, uint dwFlags, const(void)* pvPara, void* hCertStore, CERT_STORE_PROV_INFO* pStoreProvInfo);
alias PFN_CERT_STORE_PROV_CLOSE = extern(Windows) void function(void* hStoreProv, uint dwFlags);
alias PFN_CERT_STORE_PROV_READ_CERT = extern(Windows) BOOL function(void* hStoreProv, CERT_CONTEXT* pStoreCertContext, uint dwFlags, CERT_CONTEXT** ppProvCertContext);
alias PFN_CERT_STORE_PROV_WRITE_CERT = extern(Windows) BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_DELETE_CERT = extern(Windows) BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_SET_CERT_PROPERTY = extern(Windows) BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, uint dwPropId, uint dwFlags, const(void)* pvData);
alias PFN_CERT_STORE_PROV_READ_CRL = extern(Windows) BOOL function(void* hStoreProv, CRL_CONTEXT* pStoreCrlContext, uint dwFlags, CRL_CONTEXT** ppProvCrlContext);
alias PFN_CERT_STORE_PROV_WRITE_CRL = extern(Windows) BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_DELETE_CRL = extern(Windows) BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_SET_CRL_PROPERTY = extern(Windows) BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, uint dwPropId, uint dwFlags, const(void)* pvData);
alias PFN_CERT_STORE_PROV_READ_CTL = extern(Windows) BOOL function(void* hStoreProv, CTL_CONTEXT* pStoreCtlContext, uint dwFlags, CTL_CONTEXT** ppProvCtlContext);
alias PFN_CERT_STORE_PROV_WRITE_CTL = extern(Windows) BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_DELETE_CTL = extern(Windows) BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_SET_CTL_PROPERTY = extern(Windows) BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, uint dwPropId, uint dwFlags, const(void)* pvData);
alias PFN_CERT_STORE_PROV_CONTROL = extern(Windows) BOOL function(void* hStoreProv, uint dwFlags, uint dwCtrlType, const(void)* pvCtrlPara);
struct CERT_STORE_PROV_FIND_INFO
{
    uint cbSize;
    uint dwMsgAndCertEncodingType;
    uint dwFindFlags;
    uint dwFindType;
    const(void)* pvFindPara;
}

alias PFN_CERT_STORE_PROV_FIND_CERT = extern(Windows) BOOL function(void* hStoreProv, CERT_STORE_PROV_FIND_INFO* pFindInfo, CERT_CONTEXT* pPrevCertContext, uint dwFlags, void** ppvStoreProvFindInfo, CERT_CONTEXT** ppProvCertContext);
alias PFN_CERT_STORE_PROV_FREE_FIND_CERT = extern(Windows) BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, void* pvStoreProvFindInfo, uint dwFlags);
alias PFN_CERT_STORE_PROV_GET_CERT_PROPERTY = extern(Windows) BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, uint dwPropId, uint dwFlags, char* pvData, uint* pcbData);
alias PFN_CERT_STORE_PROV_FIND_CRL = extern(Windows) BOOL function(void* hStoreProv, CERT_STORE_PROV_FIND_INFO* pFindInfo, CRL_CONTEXT* pPrevCrlContext, uint dwFlags, void** ppvStoreProvFindInfo, CRL_CONTEXT** ppProvCrlContext);
alias PFN_CERT_STORE_PROV_FREE_FIND_CRL = extern(Windows) BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, void* pvStoreProvFindInfo, uint dwFlags);
alias PFN_CERT_STORE_PROV_GET_CRL_PROPERTY = extern(Windows) BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, uint dwPropId, uint dwFlags, char* pvData, uint* pcbData);
alias PFN_CERT_STORE_PROV_FIND_CTL = extern(Windows) BOOL function(void* hStoreProv, CERT_STORE_PROV_FIND_INFO* pFindInfo, CTL_CONTEXT* pPrevCtlContext, uint dwFlags, void** ppvStoreProvFindInfo, CTL_CONTEXT** ppProvCtlContext);
alias PFN_CERT_STORE_PROV_FREE_FIND_CTL = extern(Windows) BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, void* pvStoreProvFindInfo, uint dwFlags);
alias PFN_CERT_STORE_PROV_GET_CTL_PROPERTY = extern(Windows) BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, uint dwPropId, uint dwFlags, char* pvData, uint* pcbData);
struct CRL_FIND_ISSUED_FOR_PARA
{
    CERT_CONTEXT* pSubjectCert;
    CERT_CONTEXT* pIssuerCert;
}

struct CTL_ANY_SUBJECT_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER SubjectAlgorithm;
    CRYPTOAPI_BLOB SubjectIdentifier;
}

struct CTL_FIND_USAGE_PARA
{
    uint cbSize;
    CTL_USAGE SubjectUsage;
    CRYPTOAPI_BLOB ListIdentifier;
    CERT_INFO* pSigner;
}

struct CTL_FIND_SUBJECT_PARA
{
    uint cbSize;
    CTL_FIND_USAGE_PARA* pUsagePara;
    uint dwSubjectType;
    void* pvSubject;
}

alias PFN_CERT_CREATE_CONTEXT_SORT_FUNC = extern(Windows) BOOL function(uint cbTotalEncoded, uint cbRemainEncoded, uint cEntry, void* pvSort);
struct CERT_CREATE_CONTEXT_PARA
{
    uint cbSize;
    PFN_CRYPT_FREE pfnFree;
    void* pvFree;
    PFN_CERT_CREATE_CONTEXT_SORT_FUNC pfnSort;
    void* pvSort;
}

struct CERT_SYSTEM_STORE_INFO
{
    uint cbSize;
}

struct CERT_PHYSICAL_STORE_INFO
{
    uint cbSize;
    const(char)* pszOpenStoreProvider;
    uint dwOpenEncodingType;
    uint dwOpenFlags;
    CRYPTOAPI_BLOB OpenParameters;
    uint dwFlags;
    uint dwPriority;
}

alias PFN_CERT_ENUM_SYSTEM_STORE_LOCATION = extern(Windows) BOOL function(const(wchar)* pwszStoreLocation, uint dwFlags, void* pvReserved, void* pvArg);
alias PFN_CERT_ENUM_SYSTEM_STORE = extern(Windows) BOOL function(const(void)* pvSystemStore, uint dwFlags, CERT_SYSTEM_STORE_INFO* pStoreInfo, void* pvReserved, void* pvArg);
alias PFN_CERT_ENUM_PHYSICAL_STORE = extern(Windows) BOOL function(const(void)* pvSystemStore, uint dwFlags, const(wchar)* pwszStoreName, CERT_PHYSICAL_STORE_INFO* pStoreInfo, void* pvReserved, void* pvArg);
struct CTL_VERIFY_USAGE_PARA
{
    uint cbSize;
    CRYPTOAPI_BLOB ListIdentifier;
    uint cCtlStore;
    void** rghCtlStore;
    uint cSignerStore;
    void** rghSignerStore;
}

struct CTL_VERIFY_USAGE_STATUS
{
    uint cbSize;
    uint dwError;
    uint dwFlags;
    CTL_CONTEXT** ppCtl;
    uint dwCtlEntryIndex;
    CERT_CONTEXT** ppSigner;
    uint dwSignerIndex;
}

struct CERT_REVOCATION_CRL_INFO
{
    uint cbSize;
    CRL_CONTEXT* pBaseCrlContext;
    CRL_CONTEXT* pDeltaCrlContext;
    CRL_ENTRY* pCrlEntry;
    BOOL fDeltaCrlEntry;
}

struct CERT_REVOCATION_PARA
{
    uint cbSize;
    CERT_CONTEXT* pIssuerCert;
    uint cCertStore;
    void** rgCertStore;
    void* hCrlStore;
    FILETIME* pftTimeToUse;
}

struct CERT_REVOCATION_STATUS
{
    uint cbSize;
    uint dwIndex;
    uint dwError;
    uint dwReason;
    BOOL fHasFreshnessTime;
    uint dwFreshnessTime;
}

struct CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO
{
    CRYPTOAPI_BLOB CertSignHashCNGAlgPropData;
    CRYPTOAPI_BLOB CertIssuerPubKeyBitLengthPropData;
}

struct CRYPT_VERIFY_CERT_SIGN_WEAK_HASH_INFO
{
    uint cCNGHashAlgid;
    ushort** rgpwszCNGHashAlgid;
    uint dwWeakIndex;
}

alias PFN_CRYPT_EXTRACT_ENCODED_SIGNATURE_PARAMETERS_FUNC = extern(Windows) BOOL function(uint dwCertEncodingType, CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, void** ppvDecodedSignPara, ushort** ppwszCNGHashAlgid);
alias PFN_CRYPT_SIGN_AND_ENCODE_HASH_FUNC = extern(Windows) BOOL function(uint hKey, uint dwCertEncodingType, CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, void* pvDecodedSignPara, const(wchar)* pwszCNGPubKeyAlgid, const(wchar)* pwszCNGHashAlgid, char* pbComputedHash, uint cbComputedHash, char* pbSignature, uint* pcbSignature);
alias PFN_CRYPT_VERIFY_ENCODED_SIGNATURE_FUNC = extern(Windows) BOOL function(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pPubKeyInfo, CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, void* pvDecodedSignPara, const(wchar)* pwszCNGPubKeyAlgid, const(wchar)* pwszCNGHashAlgid, char* pbComputedHash, uint cbComputedHash, char* pbSignature, uint cbSignature);
struct CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA
{
    uint cOID;
    byte** rgpszOID;
}

alias PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_EX2_FUNC = extern(Windows) BOOL function(uint hNCryptKey, uint dwCertEncodingType, const(char)* pszPublicKeyObjId, uint dwFlags, void* pvAuxInfo, char* pInfo, uint* pcbInfo);
alias PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_FROM_BCRYPT_HANDLE_FUNC = extern(Windows) BOOL function(void* hBCryptKey, uint dwCertEncodingType, const(char)* pszPublicKeyObjId, uint dwFlags, void* pvAuxInfo, char* pInfo, uint* pcbInfo);
alias PFN_IMPORT_PUBLIC_KEY_INFO_EX2_FUNC = extern(Windows) BOOL function(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, uint dwFlags, void* pvAuxInfo, void** phKey);
alias PFN_IMPORT_PRIV_KEY_FUNC = extern(Windows) BOOL function(uint hCryptProv, CRYPT_PRIVATE_KEY_INFO* pPrivateKeyInfo, uint dwFlags, void* pvAuxInfo);
alias PFN_EXPORT_PRIV_KEY_FUNC = extern(Windows) BOOL function(uint hCryptProv, uint dwKeySpec, const(char)* pszPrivateKeyObjId, uint dwFlags, void* pvAuxInfo, char* pPrivateKeyInfo, uint* pcbPrivateKeyInfo);
alias PFN_CRYPT_GET_SIGNER_CERTIFICATE = extern(Windows) CERT_CONTEXT* function(void* pvGetArg, uint dwCertEncodingType, CERT_INFO* pSignerId, void* hMsgCertStore);
struct CRYPT_SIGN_MESSAGE_PARA
{
    uint cbSize;
    uint dwMsgEncodingType;
    CERT_CONTEXT* pSigningCert;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void* pvHashAuxInfo;
    uint cMsgCert;
    CERT_CONTEXT** rgpMsgCert;
    uint cMsgCrl;
    CRL_CONTEXT** rgpMsgCrl;
    uint cAuthAttr;
    CRYPT_ATTRIBUTE* rgAuthAttr;
    uint cUnauthAttr;
    CRYPT_ATTRIBUTE* rgUnauthAttr;
    uint dwFlags;
    uint dwInnerContentType;
}

struct CRYPT_VERIFY_MESSAGE_PARA
{
    uint cbSize;
    uint dwMsgAndCertEncodingType;
    uint hCryptProv;
    PFN_CRYPT_GET_SIGNER_CERTIFICATE pfnGetSignerCertificate;
    void* pvGetArg;
}

struct CRYPT_ENCRYPT_MESSAGE_PARA
{
    uint cbSize;
    uint dwMsgEncodingType;
    uint hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void* pvEncryptionAuxInfo;
    uint dwFlags;
    uint dwInnerContentType;
}

struct CRYPT_DECRYPT_MESSAGE_PARA
{
    uint cbSize;
    uint dwMsgAndCertEncodingType;
    uint cCertStore;
    void** rghCertStore;
}

struct CRYPT_HASH_MESSAGE_PARA
{
    uint cbSize;
    uint dwMsgEncodingType;
    uint hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void* pvHashAuxInfo;
}

struct CRYPT_KEY_SIGN_MESSAGE_PARA
{
    uint cbSize;
    uint dwMsgAndCertEncodingType;
    _Anonymous_e__Union Anonymous;
    uint dwKeySpec;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void* pvHashAuxInfo;
    CRYPT_ALGORITHM_IDENTIFIER PubKeyAlgorithm;
}

struct CRYPT_KEY_VERIFY_MESSAGE_PARA
{
    uint cbSize;
    uint dwMsgEncodingType;
    uint hCryptProv;
}

struct CERT_CHAIN
{
    uint cCerts;
    CRYPTOAPI_BLOB* certs;
    CRYPT_KEY_PROV_INFO keyLocatorInfo;
}

alias PFN_CRYPT_ASYNC_PARAM_FREE_FUNC = extern(Windows) void function(const(char)* pszParamOid, void* pvParam);
struct CRYPT_BLOB_ARRAY
{
    uint cBlob;
    CRYPTOAPI_BLOB* rgBlob;
}

struct CRYPT_CREDENTIALS
{
    uint cbSize;
    const(char)* pszCredentialsOid;
    void* pvCredentials;
}

struct CRYPT_PASSWORD_CREDENTIALSA
{
    uint cbSize;
    const(char)* pszUsername;
    const(char)* pszPassword;
}

struct CRYPT_PASSWORD_CREDENTIALSW
{
    uint cbSize;
    const(wchar)* pszUsername;
    const(wchar)* pszPassword;
}

alias PFN_FREE_ENCODED_OBJECT_FUNC = extern(Windows) void function(const(char)* pszObjectOid, CRYPT_BLOB_ARRAY* pObject, void* pvFreeContext);
struct CRYPTNET_URL_CACHE_PRE_FETCH_INFO
{
    uint cbSize;
    uint dwObjectType;
    uint dwError;
    uint dwReserved;
    FILETIME ThisUpdateTime;
    FILETIME NextUpdateTime;
    FILETIME PublishTime;
}

struct CRYPTNET_URL_CACHE_FLUSH_INFO
{
    uint cbSize;
    uint dwExemptSeconds;
    FILETIME ExpireTime;
}

struct CRYPTNET_URL_CACHE_RESPONSE_INFO
{
    uint cbSize;
    ushort wResponseType;
    ushort wResponseFlags;
    FILETIME LastModifiedTime;
    uint dwMaxAge;
    const(wchar)* pwszETag;
    uint dwProxyId;
}

struct CRYPT_RETRIEVE_AUX_INFO
{
    uint cbSize;
    FILETIME* pLastSyncTime;
    uint dwMaxUrlRetrievalByteCount;
    CRYPTNET_URL_CACHE_PRE_FETCH_INFO* pPreFetchInfo;
    CRYPTNET_URL_CACHE_FLUSH_INFO* pFlushInfo;
    CRYPTNET_URL_CACHE_RESPONSE_INFO** ppResponseInfo;
    const(wchar)* pwszCacheFileNamePrefix;
    FILETIME* pftCacheResync;
    BOOL fProxyCacheRetrieval;
    uint dwHttpStatusCode;
    ushort** ppwszErrorResponseHeaders;
    CRYPTOAPI_BLOB** ppErrorContentBlob;
}

alias PFN_CRYPT_CANCEL_RETRIEVAL = extern(Windows) BOOL function(uint dwFlags, void* pvArg);
alias PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC = extern(Windows) void function(void* pvCompletion, uint dwCompletionCode, const(char)* pszUrl, const(char)* pszObjectOid, void* pvObject);
struct CRYPT_ASYNC_RETRIEVAL_COMPLETION
{
    PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC pfnCompletion;
    void* pvCompletion;
}

alias PFN_CANCEL_ASYNC_RETRIEVAL_FUNC = extern(Windows) BOOL function(HCRYPTASYNC hAsyncRetrieve);
struct CRYPT_URL_ARRAY
{
    uint cUrl;
    ushort** rgwszUrl;
}

struct CRYPT_URL_INFO
{
    uint cbSize;
    uint dwSyncDeltaTime;
    uint cGroup;
    uint* rgcGroupEntry;
}

struct CERT_CRL_CONTEXT_PAIR
{
    CERT_CONTEXT* pCertContext;
    CRL_CONTEXT* pCrlContext;
}

struct CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO
{
    uint cbSize;
    int iDeltaCrlIndicator;
    FILETIME* pftCacheResync;
    FILETIME* pLastSyncTime;
    FILETIME* pMaxAgeTime;
    CERT_REVOCATION_CHAIN_PARA* pChainPara;
    CRYPTOAPI_BLOB* pDeltaCrlIndicator;
}

alias PFN_CRYPT_ENUM_KEYID_PROP = extern(Windows) BOOL function(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwFlags, void* pvReserved, void* pvArg, uint cProp, char* rgdwPropId, char* rgpvData, char* rgcbData);
struct CERT_CHAIN_ENGINE_CONFIG
{
    uint cbSize;
    void* hRestrictedRoot;
    void* hRestrictedTrust;
    void* hRestrictedOther;
    uint cAdditionalStore;
    void** rghAdditionalStore;
    uint dwFlags;
    uint dwUrlRetrievalTimeout;
    uint MaximumCachedCertificates;
    uint CycleDetectionModulus;
    void* hExclusiveRoot;
    void* hExclusiveTrustedPeople;
    uint dwExclusiveFlags;
}

struct CERT_TRUST_STATUS
{
    uint dwErrorStatus;
    uint dwInfoStatus;
}

struct CERT_REVOCATION_INFO
{
    uint cbSize;
    uint dwRevocationResult;
    const(char)* pszRevocationOid;
    void* pvOidSpecificInfo;
    BOOL fHasFreshnessTime;
    uint dwFreshnessTime;
    CERT_REVOCATION_CRL_INFO* pCrlInfo;
}

struct CERT_TRUST_LIST_INFO
{
    uint cbSize;
    CTL_ENTRY* pCtlEntry;
    CTL_CONTEXT* pCtlContext;
}

struct CERT_CHAIN_ELEMENT
{
    uint cbSize;
    CERT_CONTEXT* pCertContext;
    CERT_TRUST_STATUS TrustStatus;
    CERT_REVOCATION_INFO* pRevocationInfo;
    CTL_USAGE* pIssuanceUsage;
    CTL_USAGE* pApplicationUsage;
    const(wchar)* pwszExtendedErrorInfo;
}

struct CERT_SIMPLE_CHAIN
{
    uint cbSize;
    CERT_TRUST_STATUS TrustStatus;
    uint cElement;
    CERT_CHAIN_ELEMENT** rgpElement;
    CERT_TRUST_LIST_INFO* pTrustListInfo;
    BOOL fHasRevocationFreshnessTime;
    uint dwRevocationFreshnessTime;
}

struct CERT_CHAIN_CONTEXT
{
    uint cbSize;
    CERT_TRUST_STATUS TrustStatus;
    uint cChain;
    CERT_SIMPLE_CHAIN** rgpChain;
    uint cLowerQualityChainContext;
    CERT_CHAIN_CONTEXT** rgpLowerQualityChainContext;
    BOOL fHasRevocationFreshnessTime;
    uint dwRevocationFreshnessTime;
    uint dwCreateFlags;
    Guid ChainId;
}

struct CERT_USAGE_MATCH
{
    uint dwType;
    CTL_USAGE Usage;
}

struct CTL_USAGE_MATCH
{
    uint dwType;
    CTL_USAGE Usage;
}

struct CERT_CHAIN_PARA
{
    uint cbSize;
    CERT_USAGE_MATCH RequestedUsage;
}

struct CERT_REVOCATION_CHAIN_PARA
{
    uint cbSize;
    HCERTCHAINENGINE hChainEngine;
    void* hAdditionalStore;
    uint dwChainFlags;
    uint dwUrlRetrievalTimeout;
    FILETIME* pftCurrentTime;
    FILETIME* pftCacheResync;
    uint cbMaxUrlRetrievalByteCount;
}

struct CRL_REVOCATION_INFO
{
    CRL_ENTRY* pCrlEntry;
    CRL_CONTEXT* pCrlContext;
    CERT_CHAIN_CONTEXT* pCrlIssuerChain;
}

alias PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK = extern(Windows) BOOL function(CERT_CONTEXT* pCert, void* pvFindArg);
struct CERT_CHAIN_FIND_BY_ISSUER_PARA
{
    uint cbSize;
    const(char)* pszUsageIdentifier;
    uint dwKeySpec;
    uint dwAcquirePrivateKeyFlags;
    uint cIssuer;
    CRYPTOAPI_BLOB* rgIssuer;
    PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK pfnFindCallback;
    void* pvFindArg;
}

struct CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwFlags;
    void* pvExtraPolicyPara;
}

struct CERT_CHAIN_POLICY_STATUS
{
    uint cbSize;
    uint dwError;
    int lChainIndex;
    int lElementIndex;
    void* pvExtraPolicyStatus;
}

struct AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwRegPolicySettings;
    CMSG_SIGNER_INFO* pSignerInfo;
}

struct AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint cbSize;
    BOOL fCommercial;
}

struct AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwRegPolicySettings;
    BOOL fCommercial;
}

struct HTTPSPolicyCallbackData
{
    _Anonymous_e__Union Anonymous;
    uint dwAuthType;
    uint fdwChecks;
    ushort* pwszServerName;
}

struct EV_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwRootProgramQualifierFlags;
}

struct EV_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint cbSize;
    uint dwQualifiers;
    uint dwIssuanceUsageIndex;
}

struct SSL_F12_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint cbSize;
    uint dwErrorLevel;
    uint dwErrorCategory;
    uint dwReserved;
    ushort wszErrorText;
}

struct SSL_HPKP_HEADER_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwReserved;
    const(wchar)* pwszServerName;
    byte* rgpszHpkpValue;
}

struct SSL_KEY_PIN_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwReserved;
    const(wchar)* pwszServerName;
}

struct SSL_KEY_PIN_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint cbSize;
    int lError;
    ushort wszErrorText;
}

struct CRYPT_PKCS12_PBE_PARAMS
{
    int iIterations;
    uint cbSalt;
}

struct PKCS12_PBES2_EXPORT_PARAMS
{
    uint dwSize;
    void* hNcryptDescriptor;
    const(wchar)* pwszPbes2Alg;
}

struct CERT_SERVER_OCSP_RESPONSE_CONTEXT
{
    uint cbSize;
    ubyte* pbEncodedOcspResponse;
    uint cbEncodedOcspResponse;
}

alias PFN_CERT_SERVER_OCSP_RESPONSE_UPDATE_CALLBACK = extern(Windows) void function(CERT_CHAIN_CONTEXT* pChainContext, CERT_SERVER_OCSP_RESPONSE_CONTEXT* pServerOcspResponseContext, CRL_CONTEXT* pNewCrlContext, CRL_CONTEXT* pPrevCrlContext, void* pvArg, uint dwWriteOcspFileError);
struct CERT_SERVER_OCSP_RESPONSE_OPEN_PARA
{
    uint cbSize;
    uint dwFlags;
    uint* pcbUsedSize;
    const(wchar)* pwszOcspDirectory;
    PFN_CERT_SERVER_OCSP_RESPONSE_UPDATE_CALLBACK pfnUpdateCallback;
    void* pvUpdateCallbackArg;
}

struct CERT_SELECT_CHAIN_PARA
{
    HCERTCHAINENGINE hChainEngine;
    FILETIME* pTime;
    void* hAdditionalStore;
    CERT_CHAIN_PARA* pChainPara;
    uint dwFlags;
}

struct CERT_SELECT_CRITERIA
{
    uint dwType;
    uint cPara;
    void** ppPara;
}

struct CRYPT_TIMESTAMP_REQUEST
{
    uint dwVersion;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB HashedMessage;
    const(char)* pszTSAPolicyId;
    CRYPTOAPI_BLOB Nonce;
    BOOL fCertReq;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRYPT_TIMESTAMP_RESPONSE
{
    uint dwStatus;
    uint cFreeText;
    ushort** rgFreeText;
    CRYPT_BIT_BLOB FailureInfo;
    CRYPTOAPI_BLOB ContentInfo;
}

struct CRYPT_TIMESTAMP_ACCURACY
{
    uint dwSeconds;
    uint dwMillis;
    uint dwMicros;
}

struct CRYPT_TIMESTAMP_INFO
{
    uint dwVersion;
    const(char)* pszTSAPolicyId;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB HashedMessage;
    CRYPTOAPI_BLOB SerialNumber;
    FILETIME ftTime;
    CRYPT_TIMESTAMP_ACCURACY* pvAccuracy;
    BOOL fOrdering;
    CRYPTOAPI_BLOB Nonce;
    CRYPTOAPI_BLOB Tsa;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRYPT_TIMESTAMP_CONTEXT
{
    uint cbEncoded;
    ubyte* pbEncoded;
    CRYPT_TIMESTAMP_INFO* pTimeStamp;
}

struct CRYPT_TIMESTAMP_PARA
{
    const(char)* pszTSAPolicyId;
    BOOL fRequestCerts;
    CRYPTOAPI_BLOB Nonce;
    uint cExtension;
    CERT_EXTENSION* rgExtension;
}

alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH = extern(Windows) BOOL function(void* pContext, char* rgIdentifierOrNameList, uint dwIdentifierOrNameListCount);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET = extern(Windows) BOOL function(void* pPluginContext, CRYPTOAPI_BLOB* pIdentifier, uint dwNameType, CRYPTOAPI_BLOB* pNameBlob, ubyte** ppbContent, uint* pcbContent, ushort** ppwszPassword, CRYPTOAPI_BLOB** ppIdentifier);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE = extern(Windows) void function(uint dwReason, void* pPluginContext);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD = extern(Windows) void function(void* pPluginContext, const(wchar)* pwszPassword);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE = extern(Windows) void function(void* pPluginContext, ubyte* pbData);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER = extern(Windows) void function(void* pPluginContext, CRYPTOAPI_BLOB* pIdentifier);
struct CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE
{
    uint cbSize;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET pfnGet;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE pfnRelease;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD pfnFreePassword;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE pfnFree;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER pfnFreeIdentifier;
}

alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_INITIALIZE = extern(Windows) BOOL function(PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH pfnFlush, void* pContext, uint* pdwExpectedObjectCount, CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE** ppFuncTable, void** ppPluginContext);
alias PFN_CERT_IS_WEAK_HASH = extern(Windows) BOOL function(uint dwHashUseType, const(wchar)* pwszCNGHashAlgid, uint dwChainFlags, CERT_CHAIN_CONTEXT* pSignerChainContext, FILETIME* pTimeStamp, const(wchar)* pwszFileName);
struct CRYPTPROTECT_PROMPTSTRUCT
{
    uint cbSize;
    uint dwPromptFlags;
    HWND hwndApp;
    const(wchar)* szPrompt;
}

struct SCARD_READERSTATEA
{
    const(char)* szReader;
    void* pvUserData;
    uint dwCurrentState;
    uint dwEventState;
    uint cbAtr;
    ubyte rgbAtr;
}

struct SCARD_READERSTATEW
{
    const(wchar)* szReader;
    void* pvUserData;
    uint dwCurrentState;
    uint dwEventState;
    uint cbAtr;
    ubyte rgbAtr;
}

struct SCARD_ATRMASK
{
    uint cbAtr;
    ubyte rgbAtr;
    ubyte rgbMask;
}

alias LPOCNCONNPROCA = extern(Windows) uint function(uint param0, const(char)* param1, const(char)* param2, void* param3);
alias LPOCNCONNPROCW = extern(Windows) uint function(uint param0, const(wchar)* param1, const(wchar)* param2, void* param3);
alias LPOCNCHKPROC = extern(Windows) BOOL function(uint param0, uint param1, void* param2);
alias LPOCNDSCPROC = extern(Windows) void function(uint param0, uint param1, void* param2);
struct OPENCARD_SEARCH_CRITERIAA
{
    uint dwStructSize;
    const(char)* lpstrGroupNames;
    uint nMaxGroupNames;
    Guid* rgguidInterfaces;
    uint cguidInterfaces;
    const(char)* lpstrCardNames;
    uint nMaxCardNames;
    LPOCNCHKPROC lpfnCheck;
    LPOCNCONNPROCA lpfnConnect;
    LPOCNDSCPROC lpfnDisconnect;
    void* pvUserData;
    uint dwShareMode;
    uint dwPreferredProtocols;
}

struct OPENCARD_SEARCH_CRITERIAW
{
    uint dwStructSize;
    const(wchar)* lpstrGroupNames;
    uint nMaxGroupNames;
    Guid* rgguidInterfaces;
    uint cguidInterfaces;
    const(wchar)* lpstrCardNames;
    uint nMaxCardNames;
    LPOCNCHKPROC lpfnCheck;
    LPOCNCONNPROCW lpfnConnect;
    LPOCNDSCPROC lpfnDisconnect;
    void* pvUserData;
    uint dwShareMode;
    uint dwPreferredProtocols;
}

struct OPENCARDNAME_EXA
{
    uint dwStructSize;
    uint hSCardContext;
    HWND hwndOwner;
    uint dwFlags;
    const(char)* lpstrTitle;
    const(char)* lpstrSearchDesc;
    HICON hIcon;
    OPENCARD_SEARCH_CRITERIAA* pOpenCardSearchCriteria;
    LPOCNCONNPROCA lpfnConnect;
    void* pvUserData;
    uint dwShareMode;
    uint dwPreferredProtocols;
    const(char)* lpstrRdr;
    uint nMaxRdr;
    const(char)* lpstrCard;
    uint nMaxCard;
    uint dwActiveProtocol;
    uint hCardHandle;
}

struct OPENCARDNAME_EXW
{
    uint dwStructSize;
    uint hSCardContext;
    HWND hwndOwner;
    uint dwFlags;
    const(wchar)* lpstrTitle;
    const(wchar)* lpstrSearchDesc;
    HICON hIcon;
    OPENCARD_SEARCH_CRITERIAW* pOpenCardSearchCriteria;
    LPOCNCONNPROCW lpfnConnect;
    void* pvUserData;
    uint dwShareMode;
    uint dwPreferredProtocols;
    const(wchar)* lpstrRdr;
    uint nMaxRdr;
    const(wchar)* lpstrCard;
    uint nMaxCard;
    uint dwActiveProtocol;
    uint hCardHandle;
}

enum READER_SEL_REQUEST_MATCH_TYPE
{
    RSR_MATCH_TYPE_READER_AND_CONTAINER = 1,
    RSR_MATCH_TYPE_SERIAL_NUMBER = 2,
    RSR_MATCH_TYPE_ALL_CARDS = 3,
}

struct READER_SEL_REQUEST
{
    uint dwShareMode;
    uint dwPreferredProtocols;
    READER_SEL_REQUEST_MATCH_TYPE MatchType;
    _Anonymous_e__Union Anonymous;
}

struct READER_SEL_RESPONSE
{
    uint cbReaderNameOffset;
    uint cchReaderNameLength;
    uint cbCardNameOffset;
    uint cchCardNameLength;
}

struct OPENCARDNAMEA
{
    uint dwStructSize;
    HWND hwndOwner;
    uint hSCardContext;
    const(char)* lpstrGroupNames;
    uint nMaxGroupNames;
    const(char)* lpstrCardNames;
    uint nMaxCardNames;
    Guid* rgguidInterfaces;
    uint cguidInterfaces;
    const(char)* lpstrRdr;
    uint nMaxRdr;
    const(char)* lpstrCard;
    uint nMaxCard;
    const(char)* lpstrTitle;
    uint dwFlags;
    void* pvUserData;
    uint dwShareMode;
    uint dwPreferredProtocols;
    uint dwActiveProtocol;
    LPOCNCONNPROCA lpfnConnect;
    LPOCNCHKPROC lpfnCheck;
    LPOCNDSCPROC lpfnDisconnect;
    uint hCardHandle;
}

struct OPENCARDNAMEW
{
    uint dwStructSize;
    HWND hwndOwner;
    uint hSCardContext;
    const(wchar)* lpstrGroupNames;
    uint nMaxGroupNames;
    const(wchar)* lpstrCardNames;
    uint nMaxCardNames;
    Guid* rgguidInterfaces;
    uint cguidInterfaces;
    const(wchar)* lpstrRdr;
    uint nMaxRdr;
    const(wchar)* lpstrCard;
    uint nMaxCard;
    const(wchar)* lpstrTitle;
    uint dwFlags;
    void* pvUserData;
    uint dwShareMode;
    uint dwPreferredProtocols;
    uint dwActiveProtocol;
    LPOCNCONNPROCW lpfnConnect;
    LPOCNCHKPROC lpfnCheck;
    LPOCNDSCPROC lpfnDisconnect;
    uint hCardHandle;
}

struct SERVICE_TRIGGER_CUSTOM_STATE_ID
{
    uint Data;
}

struct SERVICE_CUSTOM_SYSTEM_STATE_CHANGE_DATA_ITEM
{
    _u_e__Union u;
}

struct SERVICE_DESCRIPTIONA
{
    const(char)* lpDescription;
}

struct SERVICE_DESCRIPTIONW
{
    const(wchar)* lpDescription;
}

enum SC_ACTION_TYPE
{
    SC_ACTION_NONE = 0,
    SC_ACTION_RESTART = 1,
    SC_ACTION_REBOOT = 2,
    SC_ACTION_RUN_COMMAND = 3,
    SC_ACTION_OWN_RESTART = 4,
}

struct SC_ACTION
{
    SC_ACTION_TYPE Type;
    uint Delay;
}

struct SERVICE_FAILURE_ACTIONSA
{
    uint dwResetPeriod;
    const(char)* lpRebootMsg;
    const(char)* lpCommand;
    uint cActions;
    SC_ACTION* lpsaActions;
}

struct SERVICE_FAILURE_ACTIONSW
{
    uint dwResetPeriod;
    const(wchar)* lpRebootMsg;
    const(wchar)* lpCommand;
    uint cActions;
    SC_ACTION* lpsaActions;
}

struct SERVICE_DELAYED_AUTO_START_INFO
{
    BOOL fDelayedAutostart;
}

struct SERVICE_FAILURE_ACTIONS_FLAG
{
    BOOL fFailureActionsOnNonCrashFailures;
}

struct SERVICE_SID_INFO
{
    uint dwServiceSidType;
}

struct SERVICE_REQUIRED_PRIVILEGES_INFOA
{
    const(char)* pmszRequiredPrivileges;
}

struct SERVICE_REQUIRED_PRIVILEGES_INFOW
{
    const(wchar)* pmszRequiredPrivileges;
}

struct SERVICE_PRESHUTDOWN_INFO
{
    uint dwPreshutdownTimeout;
}

struct SERVICE_TRIGGER_SPECIFIC_DATA_ITEM
{
    uint dwDataType;
    uint cbData;
    ubyte* pData;
}

struct SERVICE_TRIGGER
{
    uint dwTriggerType;
    uint dwAction;
    Guid* pTriggerSubtype;
    uint cDataItems;
    SERVICE_TRIGGER_SPECIFIC_DATA_ITEM* pDataItems;
}

struct SERVICE_TRIGGER_INFO
{
    uint cTriggers;
    SERVICE_TRIGGER* pTriggers;
    ubyte* pReserved;
}

struct SERVICE_PREFERRED_NODE_INFO
{
    ushort usPreferredNode;
    ubyte fDelete;
}

struct SERVICE_TIMECHANGE_INFO
{
    LARGE_INTEGER liNewTime;
    LARGE_INTEGER liOldTime;
}

struct SERVICE_LAUNCH_PROTECTED_INFO
{
    uint dwLaunchProtected;
}

struct SC_HANDLE__
{
    int unused;
}

struct SERVICE_STATUS_HANDLE__
{
    int unused;
}

enum SC_STATUS_TYPE
{
    SC_STATUS_PROCESS_INFO = 0,
}

enum SC_ENUM_TYPE
{
    SC_ENUM_PROCESS_INFO = 0,
}

struct SERVICE_STATUS
{
    uint dwServiceType;
    uint dwCurrentState;
    uint dwControlsAccepted;
    uint dwWin32ExitCode;
    uint dwServiceSpecificExitCode;
    uint dwCheckPoint;
    uint dwWaitHint;
}

struct SERVICE_STATUS_PROCESS
{
    uint dwServiceType;
    uint dwCurrentState;
    uint dwControlsAccepted;
    uint dwWin32ExitCode;
    uint dwServiceSpecificExitCode;
    uint dwCheckPoint;
    uint dwWaitHint;
    uint dwProcessId;
    uint dwServiceFlags;
}

struct ENUM_SERVICE_STATUSA
{
    const(char)* lpServiceName;
    const(char)* lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

struct ENUM_SERVICE_STATUSW
{
    const(wchar)* lpServiceName;
    const(wchar)* lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

struct ENUM_SERVICE_STATUS_PROCESSA
{
    const(char)* lpServiceName;
    const(char)* lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

struct ENUM_SERVICE_STATUS_PROCESSW
{
    const(wchar)* lpServiceName;
    const(wchar)* lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

struct QUERY_SERVICE_LOCK_STATUSA
{
    uint fIsLocked;
    const(char)* lpLockOwner;
    uint dwLockDuration;
}

struct QUERY_SERVICE_LOCK_STATUSW
{
    uint fIsLocked;
    const(wchar)* lpLockOwner;
    uint dwLockDuration;
}

struct QUERY_SERVICE_CONFIGA
{
    uint dwServiceType;
    uint dwStartType;
    uint dwErrorControl;
    const(char)* lpBinaryPathName;
    const(char)* lpLoadOrderGroup;
    uint dwTagId;
    const(char)* lpDependencies;
    const(char)* lpServiceStartName;
    const(char)* lpDisplayName;
}

struct QUERY_SERVICE_CONFIGW
{
    uint dwServiceType;
    uint dwStartType;
    uint dwErrorControl;
    const(wchar)* lpBinaryPathName;
    const(wchar)* lpLoadOrderGroup;
    uint dwTagId;
    const(wchar)* lpDependencies;
    const(wchar)* lpServiceStartName;
    const(wchar)* lpDisplayName;
}

alias SERVICE_MAIN_FUNCTIONW = extern(Windows) void function(uint dwNumServicesArgs, ushort** lpServiceArgVectors);
alias SERVICE_MAIN_FUNCTIONA = extern(Windows) void function(uint dwNumServicesArgs, byte** lpServiceArgVectors);
alias LPSERVICE_MAIN_FUNCTIONW = extern(Windows) void function(uint dwNumServicesArgs, ushort** lpServiceArgVectors);
alias LPSERVICE_MAIN_FUNCTIONA = extern(Windows) void function(uint dwNumServicesArgs, byte** lpServiceArgVectors);
struct SERVICE_TABLE_ENTRYA
{
    const(char)* lpServiceName;
    LPSERVICE_MAIN_FUNCTIONA lpServiceProc;
}

struct SERVICE_TABLE_ENTRYW
{
    const(wchar)* lpServiceName;
    LPSERVICE_MAIN_FUNCTIONW lpServiceProc;
}

alias HANDLER_FUNCTION = extern(Windows) void function(uint dwControl);
alias HANDLER_FUNCTION_EX = extern(Windows) uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias LPHANDLER_FUNCTION = extern(Windows) void function(uint dwControl);
alias LPHANDLER_FUNCTION_EX = extern(Windows) uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias PFN_SC_NOTIFY_CALLBACK = extern(Windows) void function(void* pParameter);
struct SERVICE_NOTIFY_1
{
    uint dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_NOTIFY_2A
{
    uint dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint dwNotificationTriggered;
    const(char)* pszServiceNames;
}

struct SERVICE_NOTIFY_2W
{
    uint dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint dwNotificationTriggered;
    const(wchar)* pszServiceNames;
}

struct SERVICE_CONTROL_STATUS_REASON_PARAMSA
{
    uint dwReason;
    const(char)* pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_CONTROL_STATUS_REASON_PARAMSW
{
    uint dwReason;
    const(wchar)* pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_START_REASON
{
    uint dwReason;
}

enum SC_EVENT_TYPE
{
    SC_EVENT_DATABASE_CHANGE = 0,
    SC_EVENT_PROPERTY_CHANGE = 1,
    SC_EVENT_STATUS_CHANGE = 2,
}

alias SC_NOTIFICATION_CALLBACK = extern(Windows) void function(uint dwNotify, void* pCallbackContext);
alias PSC_NOTIFICATION_CALLBACK = extern(Windows) void function();
struct _SC_NOTIFICATION_REGISTRATION
{
}

enum SERVICE_REGISTRY_STATE_TYPE
{
    ServiceRegistryStateParameters = 0,
    ServiceRegistryStatePersistent = 1,
    MaxServiceRegistryStateType = 2,
}

enum SERVICE_DIRECTORY_TYPE
{
    ServiceDirectoryPersistentState = 0,
    ServiceDirectoryTypeMax = 1,
}

struct LSA_TRUST_INFORMATION
{
    UNICODE_STRING Name;
    void* Sid;
}

struct LSA_REFERENCED_DOMAIN_LIST
{
    uint Entries;
    LSA_TRUST_INFORMATION* Domains;
}

struct LSA_TRANSLATED_SID2
{
    SID_NAME_USE Use;
    void* Sid;
    int DomainIndex;
    uint Flags;
}

struct LSA_TRANSLATED_NAME
{
    SID_NAME_USE Use;
    UNICODE_STRING Name;
    int DomainIndex;
}

struct POLICY_ACCOUNT_DOMAIN_INFO
{
    UNICODE_STRING DomainName;
    void* DomainSid;
}

struct POLICY_DNS_DOMAIN_INFO
{
    UNICODE_STRING Name;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING DnsForestName;
    Guid DomainGuid;
    void* Sid;
}

enum LSA_LOOKUP_DOMAIN_INFO_CLASS
{
    AccountDomainInformation = 5,
    DnsDomainInformation = 12,
}

enum SECURITY_LOGON_TYPE
{
    UndefinedLogonType = 0,
    Interactive = 2,
    Network = 3,
    Batch = 4,
    Service = 5,
    Proxy = 6,
    Unlock = 7,
    NetworkCleartext = 8,
    NewCredentials = 9,
    RemoteInteractive = 10,
    CachedInteractive = 11,
    CachedRemoteInteractive = 12,
    CachedUnlock = 13,
}

enum SE_ADT_PARAMETER_TYPE
{
    SeAdtParmTypeNone = 0,
    SeAdtParmTypeString = 1,
    SeAdtParmTypeFileSpec = 2,
    SeAdtParmTypeUlong = 3,
    SeAdtParmTypeSid = 4,
    SeAdtParmTypeLogonId = 5,
    SeAdtParmTypeNoLogonId = 6,
    SeAdtParmTypeAccessMask = 7,
    SeAdtParmTypePrivs = 8,
    SeAdtParmTypeObjectTypes = 9,
    SeAdtParmTypeHexUlong = 10,
    SeAdtParmTypePtr = 11,
    SeAdtParmTypeTime = 12,
    SeAdtParmTypeGuid = 13,
    SeAdtParmTypeLuid = 14,
    SeAdtParmTypeHexInt64 = 15,
    SeAdtParmTypeStringList = 16,
    SeAdtParmTypeSidList = 17,
    SeAdtParmTypeDuration = 18,
    SeAdtParmTypeUserAccountControl = 19,
    SeAdtParmTypeNoUac = 20,
    SeAdtParmTypeMessage = 21,
    SeAdtParmTypeDateTime = 22,
    SeAdtParmTypeSockAddr = 23,
    SeAdtParmTypeSD = 24,
    SeAdtParmTypeLogonHours = 25,
    SeAdtParmTypeLogonIdNoSid = 26,
    SeAdtParmTypeUlongNoConv = 27,
    SeAdtParmTypeSockAddrNoPort = 28,
    SeAdtParmTypeAccessReason = 29,
    SeAdtParmTypeStagingReason = 30,
    SeAdtParmTypeResourceAttribute = 31,
    SeAdtParmTypeClaims = 32,
    SeAdtParmTypeLogonIdAsSid = 33,
    SeAdtParmTypeMultiSzString = 34,
    SeAdtParmTypeLogonIdEx = 35,
}

struct SE_ADT_OBJECT_TYPE
{
    Guid ObjectType;
    ushort Flags;
    ushort Level;
    uint AccessMask;
}

struct SE_ADT_PARAMETER_ARRAY_ENTRY
{
    SE_ADT_PARAMETER_TYPE Type;
    uint Length;
    uint Data;
    void* Address;
}

struct SE_ADT_ACCESS_REASON
{
    uint AccessMask;
    uint AccessReasons;
    uint ObjectTypeIndex;
    uint AccessGranted;
    void* SecurityDescriptor;
}

struct SE_ADT_CLAIMS
{
    uint Length;
    void* Claims;
}

struct SE_ADT_PARAMETER_ARRAY
{
    uint CategoryId;
    uint AuditId;
    uint ParameterCount;
    uint Length;
    ushort FlatSubCategoryId;
    ushort Type;
    uint Flags;
    SE_ADT_PARAMETER_ARRAY_ENTRY Parameters;
}

struct SE_ADT_PARAMETER_ARRAY_EX
{
    uint CategoryId;
    uint AuditId;
    uint Version;
    uint ParameterCount;
    uint Length;
    ushort FlatSubCategoryId;
    ushort Type;
    uint Flags;
    SE_ADT_PARAMETER_ARRAY_ENTRY Parameters;
}

enum POLICY_AUDIT_EVENT_TYPE
{
    AuditCategorySystem = 0,
    AuditCategoryLogon = 1,
    AuditCategoryObjectAccess = 2,
    AuditCategoryPrivilegeUse = 3,
    AuditCategoryDetailedTracking = 4,
    AuditCategoryPolicyChange = 5,
    AuditCategoryAccountManagement = 6,
    AuditCategoryDirectoryServiceAccess = 7,
    AuditCategoryAccountLogon = 8,
}

struct LSA_TRANSLATED_SID
{
    SID_NAME_USE Use;
    uint RelativeId;
    int DomainIndex;
}

enum POLICY_LSA_SERVER_ROLE
{
    PolicyServerRoleBackup = 2,
    PolicyServerRolePrimary = 3,
}

enum POLICY_INFORMATION_CLASS
{
    PolicyAuditLogInformation = 1,
    PolicyAuditEventsInformation = 2,
    PolicyPrimaryDomainInformation = 3,
    PolicyPdAccountInformation = 4,
    PolicyAccountDomainInformation = 5,
    PolicyLsaServerRoleInformation = 6,
    PolicyReplicaSourceInformation = 7,
    PolicyDefaultQuotaInformation = 8,
    PolicyModificationInformation = 9,
    PolicyAuditFullSetInformation = 10,
    PolicyAuditFullQueryInformation = 11,
    PolicyDnsDomainInformation = 12,
    PolicyDnsDomainInformationInt = 13,
    PolicyLocalAccountDomainInformation = 14,
    PolicyMachineAccountInformation = 15,
    PolicyLastEntry = 16,
}

struct POLICY_AUDIT_LOG_INFO
{
    uint AuditLogPercentFull;
    uint MaximumLogSize;
    LARGE_INTEGER AuditRetentionPeriod;
    ubyte AuditLogFullShutdownInProgress;
    LARGE_INTEGER TimeToShutdown;
    uint NextAuditRecordId;
}

struct POLICY_AUDIT_EVENTS_INFO
{
    ubyte AuditingMode;
    uint* EventAuditingOptions;
    uint MaximumAuditEventCount;
}

struct POLICY_AUDIT_SUBCATEGORIES_INFO
{
    uint MaximumSubCategoryCount;
    uint* EventAuditingOptions;
}

struct POLICY_AUDIT_CATEGORIES_INFO
{
    uint MaximumCategoryCount;
    POLICY_AUDIT_SUBCATEGORIES_INFO* SubCategoriesInfo;
}

struct POLICY_PRIMARY_DOMAIN_INFO
{
    UNICODE_STRING Name;
    void* Sid;
}

struct POLICY_PD_ACCOUNT_INFO
{
    UNICODE_STRING Name;
}

struct POLICY_LSA_SERVER_ROLE_INFO
{
    POLICY_LSA_SERVER_ROLE LsaServerRole;
}

struct POLICY_REPLICA_SOURCE_INFO
{
    UNICODE_STRING ReplicaSource;
    UNICODE_STRING ReplicaAccountName;
}

struct POLICY_DEFAULT_QUOTA_INFO
{
    QUOTA_LIMITS QuotaLimits;
}

struct POLICY_MODIFICATION_INFO
{
    LARGE_INTEGER ModifiedId;
    LARGE_INTEGER DatabaseCreationTime;
}

struct POLICY_AUDIT_FULL_SET_INFO
{
    ubyte ShutDownOnFull;
}

struct POLICY_AUDIT_FULL_QUERY_INFO
{
    ubyte ShutDownOnFull;
    ubyte LogIsFull;
}

enum POLICY_DOMAIN_INFORMATION_CLASS
{
    PolicyDomainEfsInformation = 2,
    PolicyDomainKerberosTicketInformation = 3,
}

struct POLICY_DOMAIN_EFS_INFO
{
    uint InfoLength;
    ubyte* EfsBlob;
}

struct POLICY_DOMAIN_KERBEROS_TICKET_INFO
{
    uint AuthenticationOptions;
    LARGE_INTEGER MaxServiceTicketAge;
    LARGE_INTEGER MaxTicketAge;
    LARGE_INTEGER MaxRenewAge;
    LARGE_INTEGER MaxClockSkew;
    LARGE_INTEGER Reserved;
}

struct POLICY_MACHINE_ACCT_INFO
{
    uint Rid;
    void* Sid;
}

enum POLICY_NOTIFICATION_INFORMATION_CLASS
{
    PolicyNotifyAuditEventsInformation = 1,
    PolicyNotifyAccountDomainInformation = 2,
    PolicyNotifyServerRoleInformation = 3,
    PolicyNotifyDnsDomainInformation = 4,
    PolicyNotifyDomainEfsInformation = 5,
    PolicyNotifyDomainKerberosTicketInformation = 6,
    PolicyNotifyMachineAccountPasswordInformation = 7,
    PolicyNotifyGlobalSaclInformation = 8,
    PolicyNotifyMax = 9,
}

enum TRUSTED_INFORMATION_CLASS
{
    TrustedDomainNameInformation = 1,
    TrustedControllersInformation = 2,
    TrustedPosixOffsetInformation = 3,
    TrustedPasswordInformation = 4,
    TrustedDomainInformationBasic = 5,
    TrustedDomainInformationEx = 6,
    TrustedDomainAuthInformation = 7,
    TrustedDomainFullInformation = 8,
    TrustedDomainAuthInformationInternal = 9,
    TrustedDomainFullInformationInternal = 10,
    TrustedDomainInformationEx2Internal = 11,
    TrustedDomainFullInformation2Internal = 12,
    TrustedDomainSupportedEncryptionTypes = 13,
}

struct TRUSTED_DOMAIN_NAME_INFO
{
    UNICODE_STRING Name;
}

struct TRUSTED_CONTROLLERS_INFO
{
    uint Entries;
    UNICODE_STRING* Names;
}

struct TRUSTED_POSIX_OFFSET_INFO
{
    uint Offset;
}

struct TRUSTED_PASSWORD_INFO
{
    UNICODE_STRING Password;
    UNICODE_STRING OldPassword;
}

struct TRUSTED_DOMAIN_INFORMATION_EX
{
    UNICODE_STRING Name;
    UNICODE_STRING FlatName;
    void* Sid;
    uint TrustDirection;
    uint TrustType;
    uint TrustAttributes;
}

struct TRUSTED_DOMAIN_INFORMATION_EX2
{
    UNICODE_STRING Name;
    UNICODE_STRING FlatName;
    void* Sid;
    uint TrustDirection;
    uint TrustType;
    uint TrustAttributes;
    uint ForestTrustLength;
    ubyte* ForestTrustInfo;
}

struct LSA_AUTH_INFORMATION
{
    LARGE_INTEGER LastUpdateTime;
    uint AuthType;
    uint AuthInfoLength;
    ubyte* AuthInfo;
}

struct TRUSTED_DOMAIN_AUTH_INFORMATION
{
    uint IncomingAuthInfos;
    LSA_AUTH_INFORMATION* IncomingAuthenticationInformation;
    LSA_AUTH_INFORMATION* IncomingPreviousAuthenticationInformation;
    uint OutgoingAuthInfos;
    LSA_AUTH_INFORMATION* OutgoingAuthenticationInformation;
    LSA_AUTH_INFORMATION* OutgoingPreviousAuthenticationInformation;
}

struct TRUSTED_DOMAIN_FULL_INFORMATION
{
    TRUSTED_DOMAIN_INFORMATION_EX Information;
    TRUSTED_POSIX_OFFSET_INFO PosixOffset;
    TRUSTED_DOMAIN_AUTH_INFORMATION AuthInformation;
}

struct TRUSTED_DOMAIN_FULL_INFORMATION2
{
    TRUSTED_DOMAIN_INFORMATION_EX2 Information;
    TRUSTED_POSIX_OFFSET_INFO PosixOffset;
    TRUSTED_DOMAIN_AUTH_INFORMATION AuthInformation;
}

struct TRUSTED_DOMAIN_SUPPORTED_ENCRYPTION_TYPES
{
    uint SupportedEncryptionTypes;
}

enum LSA_FOREST_TRUST_RECORD_TYPE
{
    ForestTrustTopLevelName = 0,
    ForestTrustTopLevelNameEx = 1,
    ForestTrustDomainInfo = 2,
    ForestTrustRecordTypeLast = 2,
}

struct LSA_FOREST_TRUST_DOMAIN_INFO
{
    void* Sid;
    UNICODE_STRING DnsName;
    UNICODE_STRING NetbiosName;
}

struct LSA_FOREST_TRUST_BINARY_DATA
{
    uint Length;
    ubyte* Buffer;
}

struct LSA_FOREST_TRUST_RECORD
{
    uint Flags;
    LSA_FOREST_TRUST_RECORD_TYPE ForestTrustType;
    LARGE_INTEGER Time;
    _ForestTrustData_e__Union ForestTrustData;
}

struct LSA_FOREST_TRUST_INFORMATION
{
    uint RecordCount;
    LSA_FOREST_TRUST_RECORD** Entries;
}

enum LSA_FOREST_TRUST_COLLISION_RECORD_TYPE
{
    CollisionTdo = 0,
    CollisionXref = 1,
    CollisionOther = 2,
}

struct LSA_FOREST_TRUST_COLLISION_RECORD
{
    uint Index;
    LSA_FOREST_TRUST_COLLISION_RECORD_TYPE Type;
    uint Flags;
    UNICODE_STRING Name;
}

struct LSA_FOREST_TRUST_COLLISION_INFORMATION
{
    uint RecordCount;
    LSA_FOREST_TRUST_COLLISION_RECORD** Entries;
}

struct LSA_ENUMERATION_INFORMATION
{
    void* Sid;
}

struct LSA_LAST_INTER_LOGON_INFO
{
    LARGE_INTEGER LastSuccessfulLogon;
    LARGE_INTEGER LastFailedLogon;
    uint FailedAttemptCountSinceLastSuccessfulLogon;
}

struct SECURITY_LOGON_SESSION_DATA
{
    uint Size;
    LUID LogonId;
    UNICODE_STRING UserName;
    UNICODE_STRING LogonDomain;
    UNICODE_STRING AuthenticationPackage;
    uint LogonType;
    uint Session;
    void* Sid;
    LARGE_INTEGER LogonTime;
    UNICODE_STRING LogonServer;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING Upn;
    uint UserFlags;
    LSA_LAST_INTER_LOGON_INFO LastLogonInfo;
    UNICODE_STRING LogonScript;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING HomeDirectoryDrive;
    LARGE_INTEGER LogoffTime;
    LARGE_INTEGER KickOffTime;
    LARGE_INTEGER PasswordLastSet;
    LARGE_INTEGER PasswordCanChange;
    LARGE_INTEGER PasswordMustChange;
}

struct CENTRAL_ACCESS_POLICY_ENTRY
{
    UNICODE_STRING Name;
    UNICODE_STRING Description;
    UNICODE_STRING ChangeId;
    uint LengthAppliesTo;
    ubyte* AppliesTo;
    uint LengthSD;
    void* SD;
    uint LengthStagedSD;
    void* StagedSD;
    uint Flags;
}

struct CENTRAL_ACCESS_POLICY
{
    void* CAPID;
    UNICODE_STRING Name;
    UNICODE_STRING Description;
    UNICODE_STRING ChangeId;
    uint Flags;
    uint CAPECount;
    CENTRAL_ACCESS_POLICY_ENTRY** CAPEs;
}

enum NEGOTIATE_MESSAGES
{
    NegEnumPackagePrefixes = 0,
    NegGetCallerName = 1,
    NegTransferCredentials = 2,
    NegMsgReserved1 = 3,
    NegCallPackageMax = 4,
}

struct NEGOTIATE_PACKAGE_PREFIX
{
    uint PackageId;
    void* PackageDataA;
    void* PackageDataW;
    uint PrefixLen;
    ubyte Prefix;
}

struct NEGOTIATE_PACKAGE_PREFIXES
{
    uint MessageType;
    uint PrefixCount;
    uint Offset;
    uint Pad;
}

struct NEGOTIATE_CALLER_NAME_REQUEST
{
    uint MessageType;
    LUID LogonId;
}

struct NEGOTIATE_CALLER_NAME_RESPONSE
{
    uint MessageType;
    const(wchar)* CallerName;
}

struct DOMAIN_PASSWORD_INFORMATION
{
    ushort MinPasswordLength;
    ushort PasswordHistoryLength;
    uint PasswordProperties;
    LARGE_INTEGER MaxPasswordAge;
    LARGE_INTEGER MinPasswordAge;
}

alias PSAM_PASSWORD_NOTIFICATION_ROUTINE = extern(Windows) NTSTATUS function(UNICODE_STRING* UserName, uint RelativeId, UNICODE_STRING* NewPassword);
alias PSAM_INIT_NOTIFICATION_ROUTINE = extern(Windows) ubyte function();
alias PSAM_PASSWORD_FILTER_ROUTINE = extern(Windows) ubyte function(UNICODE_STRING* AccountName, UNICODE_STRING* FullName, UNICODE_STRING* Password, ubyte SetOperation);
enum MSV1_0_LOGON_SUBMIT_TYPE
{
    MsV1_0InteractiveLogon = 2,
    MsV1_0Lm20Logon = 3,
    MsV1_0NetworkLogon = 4,
    MsV1_0SubAuthLogon = 5,
    MsV1_0WorkstationUnlockLogon = 7,
    MsV1_0S4ULogon = 12,
    MsV1_0VirtualLogon = 82,
    MsV1_0NoElevationLogon = 83,
    MsV1_0LuidLogon = 84,
}

enum MSV1_0_PROFILE_BUFFER_TYPE
{
    MsV1_0InteractiveProfile = 2,
    MsV1_0Lm20LogonProfile = 3,
    MsV1_0SmartCardProfile = 4,
}

struct MSV1_0_INTERACTIVE_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Password;
}

struct MSV1_0_INTERACTIVE_PROFILE
{
    MSV1_0_PROFILE_BUFFER_TYPE MessageType;
    ushort LogonCount;
    ushort BadPasswordCount;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER LogoffTime;
    LARGE_INTEGER KickOffTime;
    LARGE_INTEGER PasswordLastSet;
    LARGE_INTEGER PasswordCanChange;
    LARGE_INTEGER PasswordMustChange;
    UNICODE_STRING LogonScript;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING FullName;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING HomeDirectoryDrive;
    UNICODE_STRING LogonServer;
    uint UserFlags;
}

struct MSV1_0_LM20_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Workstation;
    ubyte ChallengeToClient;
    STRING CaseSensitiveChallengeResponse;
    STRING CaseInsensitiveChallengeResponse;
    uint ParameterControl;
}

struct MSV1_0_SUBAUTH_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Workstation;
    ubyte ChallengeToClient;
    STRING AuthenticationInfo1;
    STRING AuthenticationInfo2;
    uint ParameterControl;
    uint SubAuthPackageId;
}

struct MSV1_0_S4U_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    uint Flags;
    UNICODE_STRING UserPrincipalName;
    UNICODE_STRING DomainName;
}

struct MSV1_0_LM20_LOGON_PROFILE
{
    MSV1_0_PROFILE_BUFFER_TYPE MessageType;
    LARGE_INTEGER KickOffTime;
    LARGE_INTEGER LogoffTime;
    uint UserFlags;
    ubyte UserSessionKey;
    UNICODE_STRING LogonDomainName;
    ubyte LanmanSessionKey;
    UNICODE_STRING LogonServer;
    UNICODE_STRING UserParameters;
}

enum MSV1_0_CREDENTIAL_KEY_TYPE
{
    InvalidCredKey = 0,
    DeprecatedIUMCredKey = 1,
    DomainUserCredKey = 2,
    LocalUserCredKey = 3,
    ExternallySuppliedCredKey = 4,
}

struct MSV1_0_CREDENTIAL_KEY
{
    ubyte Data;
}

struct MSV1_0_SUPPLEMENTAL_CREDENTIAL
{
    uint Version;
    uint Flags;
    ubyte LmPassword;
    ubyte NtPassword;
}

struct MSV1_0_SUPPLEMENTAL_CREDENTIAL_V2
{
    uint Version;
    uint Flags;
    ubyte NtPassword;
    MSV1_0_CREDENTIAL_KEY CredentialKey;
}

struct MSV1_0_SUPPLEMENTAL_CREDENTIAL_V3
{
    uint Version;
    uint Flags;
    MSV1_0_CREDENTIAL_KEY_TYPE CredentialKeyType;
    ubyte NtPassword;
    MSV1_0_CREDENTIAL_KEY CredentialKey;
    ubyte ShaPassword;
}

struct MSV1_0_IUM_SUPPLEMENTAL_CREDENTIAL
{
    uint Version;
    uint EncryptedCredsSize;
    ubyte EncryptedCreds;
}

struct MSV1_0_REMOTE_SUPPLEMENTAL_CREDENTIAL
{
    uint Version;
    uint Flags;
    MSV1_0_CREDENTIAL_KEY CredentialKey;
    MSV1_0_CREDENTIAL_KEY_TYPE CredentialKeyType;
    uint EncryptedCredsSize;
    ubyte EncryptedCreds;
}

struct MSV1_0_NTLM3_RESPONSE
{
    ubyte Response;
    ubyte RespType;
    ubyte HiRespType;
    ushort Flags;
    uint MsgWord;
    ulong TimeStamp;
    ubyte ChallengeFromClient;
    uint AvPairsOff;
    ubyte Buffer;
}

enum MSV1_0_AVID
{
    MsvAvEOL = 0,
    MsvAvNbComputerName = 1,
    MsvAvNbDomainName = 2,
    MsvAvDnsComputerName = 3,
    MsvAvDnsDomainName = 4,
    MsvAvDnsTreeName = 5,
    MsvAvFlags = 6,
    MsvAvTimestamp = 7,
    MsvAvRestrictions = 8,
    MsvAvTargetName = 9,
    MsvAvChannelBindings = 10,
}

struct MSV1_0_AV_PAIR
{
    ushort AvId;
    ushort AvLen;
}

enum MSV1_0_PROTOCOL_MESSAGE_TYPE
{
    MsV1_0Lm20ChallengeRequest = 0,
    MsV1_0Lm20GetChallengeResponse = 1,
    MsV1_0EnumerateUsers = 2,
    MsV1_0GetUserInfo = 3,
    MsV1_0ReLogonUsers = 4,
    MsV1_0ChangePassword = 5,
    MsV1_0ChangeCachedPassword = 6,
    MsV1_0GenericPassthrough = 7,
    MsV1_0CacheLogon = 8,
    MsV1_0SubAuth = 9,
    MsV1_0DeriveCredential = 10,
    MsV1_0CacheLookup = 11,
    MsV1_0SetProcessOption = 12,
    MsV1_0ConfigLocalAliases = 13,
    MsV1_0ClearCachedCredentials = 14,
    MsV1_0LookupToken = 15,
    MsV1_0ValidateAuth = 16,
    MsV1_0CacheLookupEx = 17,
    MsV1_0GetCredentialKey = 18,
    MsV1_0SetThreadOption = 19,
    MsV1_0DecryptDpapiMasterKey = 20,
    MsV1_0GetStrongCredentialKey = 21,
    MsV1_0TransferCred = 22,
    MsV1_0ProvisionTbal = 23,
    MsV1_0DeleteTbalSecrets = 24,
}

struct MSV1_0_CHANGEPASSWORD_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING AccountName;
    UNICODE_STRING OldPassword;
    UNICODE_STRING NewPassword;
    ubyte Impersonating;
}

struct MSV1_0_CHANGEPASSWORD_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    ubyte PasswordInfoValid;
    DOMAIN_PASSWORD_INFORMATION DomainPasswordInfo;
}

struct MSV1_0_PASSTHROUGH_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING PackageName;
    uint DataLength;
    ubyte* LogonData;
    uint Pad;
}

struct MSV1_0_PASSTHROUGH_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Pad;
    uint DataLength;
    ubyte* ValidationData;
}

struct MSV1_0_SUBAUTH_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint SubAuthPackageId;
    uint SubAuthInfoLength;
    ubyte* SubAuthSubmitBuffer;
}

struct MSV1_0_SUBAUTH_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint SubAuthInfoLength;
    ubyte* SubAuthReturnBuffer;
}

enum KERB_LOGON_SUBMIT_TYPE
{
    KerbInteractiveLogon = 2,
    KerbSmartCardLogon = 6,
    KerbWorkstationUnlockLogon = 7,
    KerbSmartCardUnlockLogon = 8,
    KerbProxyLogon = 9,
    KerbTicketLogon = 10,
    KerbTicketUnlockLogon = 11,
    KerbS4ULogon = 12,
    KerbCertificateLogon = 13,
    KerbCertificateS4ULogon = 14,
    KerbCertificateUnlockLogon = 15,
    KerbNoElevationLogon = 83,
    KerbLuidLogon = 84,
}

struct KERB_INTERACTIVE_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Password;
}

struct KERB_INTERACTIVE_UNLOCK_LOGON
{
    KERB_INTERACTIVE_LOGON Logon;
    LUID LogonId;
}

struct KERB_SMART_CARD_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING Pin;
    uint CspDataLength;
    ubyte* CspData;
}

struct KERB_SMART_CARD_UNLOCK_LOGON
{
    KERB_SMART_CARD_LOGON Logon;
    LUID LogonId;
}

struct KERB_CERTIFICATE_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Pin;
    uint Flags;
    uint CspDataLength;
    ubyte* CspData;
}

struct KERB_CERTIFICATE_UNLOCK_LOGON
{
    KERB_CERTIFICATE_LOGON Logon;
    LUID LogonId;
}

struct KERB_CERTIFICATE_S4U_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint Flags;
    UNICODE_STRING UserPrincipalName;
    UNICODE_STRING DomainName;
    uint CertificateLength;
    ubyte* Certificate;
}

struct KERB_TICKET_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint Flags;
    uint ServiceTicketLength;
    uint TicketGrantingTicketLength;
    ubyte* ServiceTicket;
    ubyte* TicketGrantingTicket;
}

struct KERB_TICKET_UNLOCK_LOGON
{
    KERB_TICKET_LOGON Logon;
    LUID LogonId;
}

struct KERB_S4U_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint Flags;
    UNICODE_STRING ClientUpn;
    UNICODE_STRING ClientRealm;
}

enum KERB_PROFILE_BUFFER_TYPE
{
    KerbInteractiveProfile = 2,
    KerbSmartCardProfile = 4,
    KerbTicketProfile = 6,
}

struct KERB_INTERACTIVE_PROFILE
{
    KERB_PROFILE_BUFFER_TYPE MessageType;
    ushort LogonCount;
    ushort BadPasswordCount;
    LARGE_INTEGER LogonTime;
    LARGE_INTEGER LogoffTime;
    LARGE_INTEGER KickOffTime;
    LARGE_INTEGER PasswordLastSet;
    LARGE_INTEGER PasswordCanChange;
    LARGE_INTEGER PasswordMustChange;
    UNICODE_STRING LogonScript;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING FullName;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING HomeDirectoryDrive;
    UNICODE_STRING LogonServer;
    uint UserFlags;
}

struct KERB_SMART_CARD_PROFILE
{
    KERB_INTERACTIVE_PROFILE Profile;
    uint CertificateSize;
    ubyte* CertificateData;
}

struct KERB_CRYPTO_KEY
{
    int KeyType;
    uint Length;
    ubyte* Value;
}

struct KERB_CRYPTO_KEY32
{
    int KeyType;
    uint Length;
    uint Offset;
}

struct KERB_TICKET_PROFILE
{
    KERB_INTERACTIVE_PROFILE Profile;
    KERB_CRYPTO_KEY SessionKey;
}

enum KERB_PROTOCOL_MESSAGE_TYPE
{
    KerbDebugRequestMessage = 0,
    KerbQueryTicketCacheMessage = 1,
    KerbChangeMachinePasswordMessage = 2,
    KerbVerifyPacMessage = 3,
    KerbRetrieveTicketMessage = 4,
    KerbUpdateAddressesMessage = 5,
    KerbPurgeTicketCacheMessage = 6,
    KerbChangePasswordMessage = 7,
    KerbRetrieveEncodedTicketMessage = 8,
    KerbDecryptDataMessage = 9,
    KerbAddBindingCacheEntryMessage = 10,
    KerbSetPasswordMessage = 11,
    KerbSetPasswordExMessage = 12,
    KerbVerifyCredentialsMessage = 13,
    KerbQueryTicketCacheExMessage = 14,
    KerbPurgeTicketCacheExMessage = 15,
    KerbRefreshSmartcardCredentialsMessage = 16,
    KerbAddExtraCredentialsMessage = 17,
    KerbQuerySupplementalCredentialsMessage = 18,
    KerbTransferCredentialsMessage = 19,
    KerbQueryTicketCacheEx2Message = 20,
    KerbSubmitTicketMessage = 21,
    KerbAddExtraCredentialsExMessage = 22,
    KerbQueryKdcProxyCacheMessage = 23,
    KerbPurgeKdcProxyCacheMessage = 24,
    KerbQueryTicketCacheEx3Message = 25,
    KerbCleanupMachinePkinitCredsMessage = 26,
    KerbAddBindingCacheEntryExMessage = 27,
    KerbQueryBindingCacheMessage = 28,
    KerbPurgeBindingCacheMessage = 29,
    KerbPinKdcMessage = 30,
    KerbUnpinAllKdcsMessage = 31,
    KerbQueryDomainExtendedPoliciesMessage = 32,
    KerbQueryS4U2ProxyCacheMessage = 33,
    KerbRetrieveKeyTabMessage = 34,
}

struct KERB_QUERY_TKT_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
}

struct KERB_TICKET_CACHE_INFO
{
    UNICODE_STRING ServerName;
    UNICODE_STRING RealmName;
    LARGE_INTEGER StartTime;
    LARGE_INTEGER EndTime;
    LARGE_INTEGER RenewTime;
    int EncryptionType;
    uint TicketFlags;
}

struct KERB_TICKET_CACHE_INFO_EX
{
    UNICODE_STRING ClientName;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ServerName;
    UNICODE_STRING ServerRealm;
    LARGE_INTEGER StartTime;
    LARGE_INTEGER EndTime;
    LARGE_INTEGER RenewTime;
    int EncryptionType;
    uint TicketFlags;
}

struct KERB_TICKET_CACHE_INFO_EX2
{
    UNICODE_STRING ClientName;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ServerName;
    UNICODE_STRING ServerRealm;
    LARGE_INTEGER StartTime;
    LARGE_INTEGER EndTime;
    LARGE_INTEGER RenewTime;
    int EncryptionType;
    uint TicketFlags;
    uint SessionKeyType;
    uint BranchId;
}

struct KERB_TICKET_CACHE_INFO_EX3
{
    UNICODE_STRING ClientName;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ServerName;
    UNICODE_STRING ServerRealm;
    LARGE_INTEGER StartTime;
    LARGE_INTEGER EndTime;
    LARGE_INTEGER RenewTime;
    int EncryptionType;
    uint TicketFlags;
    uint SessionKeyType;
    uint BranchId;
    uint CacheFlags;
    UNICODE_STRING KdcCalled;
}

struct KERB_QUERY_TKT_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO Tickets;
}

struct KERB_QUERY_TKT_CACHE_EX_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX Tickets;
}

struct KERB_QUERY_TKT_CACHE_EX2_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX2 Tickets;
}

struct KERB_QUERY_TKT_CACHE_EX3_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX3 Tickets;
}

struct SecHandle
{
    uint dwLower;
    uint dwUpper;
}

struct KERB_AUTH_DATA
{
    uint Type;
    uint Length;
    ubyte* Data;
}

struct KERB_NET_ADDRESS
{
    uint Family;
    uint Length;
    const(char)* Address;
}

struct KERB_NET_ADDRESSES
{
    uint Number;
    KERB_NET_ADDRESS Addresses;
}

struct KERB_EXTERNAL_NAME
{
    short NameType;
    ushort NameCount;
    UNICODE_STRING Names;
}

struct KERB_EXTERNAL_TICKET
{
    KERB_EXTERNAL_NAME* ServiceName;
    KERB_EXTERNAL_NAME* TargetName;
    KERB_EXTERNAL_NAME* ClientName;
    UNICODE_STRING DomainName;
    UNICODE_STRING TargetDomainName;
    UNICODE_STRING AltTargetDomainName;
    KERB_CRYPTO_KEY SessionKey;
    uint TicketFlags;
    uint Flags;
    LARGE_INTEGER KeyExpirationTime;
    LARGE_INTEGER StartTime;
    LARGE_INTEGER EndTime;
    LARGE_INTEGER RenewUntil;
    LARGE_INTEGER TimeSkew;
    uint EncodedTicketSize;
    ubyte* EncodedTicket;
}

struct KERB_RETRIEVE_TKT_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    UNICODE_STRING TargetName;
    uint TicketFlags;
    uint CacheOptions;
    int EncryptionType;
    SecHandle CredentialsHandle;
}

struct KERB_RETRIEVE_TKT_RESPONSE
{
    KERB_EXTERNAL_TICKET Ticket;
}

struct KERB_PURGE_TKT_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    UNICODE_STRING ServerName;
    UNICODE_STRING RealmName;
}

struct KERB_PURGE_TKT_CACHE_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    uint Flags;
    KERB_TICKET_CACHE_INFO_EX TicketTemplate;
}

struct KERB_SUBMIT_TKT_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    uint Flags;
    KERB_CRYPTO_KEY32 Key;
    uint KerbCredSize;
    uint KerbCredOffset;
}

struct KERB_QUERY_KDC_PROXY_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    LUID LogonId;
}

struct KDC_PROXY_CACHE_ENTRY_DATA
{
    ulong SinceLastUsed;
    UNICODE_STRING DomainName;
    UNICODE_STRING ProxyServerName;
    UNICODE_STRING ProxyServerVdir;
    ushort ProxyServerPort;
    LUID LogonId;
    UNICODE_STRING CredUserName;
    UNICODE_STRING CredDomainName;
    ubyte GlobalCache;
}

struct KERB_QUERY_KDC_PROXY_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfEntries;
    KDC_PROXY_CACHE_ENTRY_DATA* Entries;
}

struct KERB_PURGE_KDC_PROXY_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    LUID LogonId;
}

struct KERB_PURGE_KDC_PROXY_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfPurged;
}

struct KERB_S4U2PROXY_CACHE_ENTRY_INFO
{
    UNICODE_STRING ServerName;
    uint Flags;
    NTSTATUS LastStatus;
    LARGE_INTEGER Expiry;
}

struct KERB_S4U2PROXY_CRED
{
    UNICODE_STRING UserName;
    UNICODE_STRING DomainName;
    uint Flags;
    NTSTATUS LastStatus;
    LARGE_INTEGER Expiry;
    uint CountOfEntries;
    KERB_S4U2PROXY_CACHE_ENTRY_INFO* Entries;
}

struct KERB_QUERY_S4U2PROXY_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    LUID LogonId;
}

struct KERB_QUERY_S4U2PROXY_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfCreds;
    KERB_S4U2PROXY_CRED* Creds;
}

struct KERB_RETRIEVE_KEY_TAB_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    UNICODE_STRING UserName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
}

struct KERB_RETRIEVE_KEY_TAB_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint KeyTabLength;
    ubyte* KeyTab;
}

struct KERB_CHANGEPASSWORD_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING AccountName;
    UNICODE_STRING OldPassword;
    UNICODE_STRING NewPassword;
    ubyte Impersonating;
}

struct KERB_SETPASSWORD_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    SecHandle CredentialsHandle;
    uint Flags;
    UNICODE_STRING DomainName;
    UNICODE_STRING AccountName;
    UNICODE_STRING Password;
}

struct KERB_SETPASSWORD_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    SecHandle CredentialsHandle;
    uint Flags;
    UNICODE_STRING AccountRealm;
    UNICODE_STRING AccountName;
    UNICODE_STRING Password;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ClientName;
    ubyte Impersonating;
    UNICODE_STRING KdcAddress;
    uint KdcAddressType;
}

struct KERB_DECRYPT_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    uint Flags;
    int CryptoType;
    int KeyUsage;
    KERB_CRYPTO_KEY Key;
    uint EncryptedDataSize;
    uint InitialVectorSize;
    ubyte* InitialVector;
    ubyte* EncryptedData;
}

struct KERB_DECRYPT_RESPONSE
{
    ubyte DecryptedData;
}

struct KERB_ADD_BINDING_CACHE_ENTRY_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING RealmName;
    UNICODE_STRING KdcAddress;
    uint AddressType;
}

struct KERB_REFRESH_SCCRED_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING CredentialBlob;
    LUID LogonId;
    uint Flags;
}

struct KERB_ADD_CREDENTIALS_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING UserName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
    LUID LogonId;
    uint Flags;
}

struct KERB_ADD_CREDENTIALS_REQUEST_EX
{
    KERB_ADD_CREDENTIALS_REQUEST Credentials;
    uint PrincipalNameCount;
    UNICODE_STRING PrincipalNames;
}

struct KERB_TRANSFER_CRED_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID OriginLogonId;
    LUID DestinationLogonId;
    uint Flags;
}

struct KERB_CLEANUP_MACHINE_PKINIT_CREDS_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
}

struct KERB_BINDING_CACHE_ENTRY_DATA
{
    ulong DiscoveryTime;
    UNICODE_STRING RealmName;
    UNICODE_STRING KdcAddress;
    uint AddressType;
    uint Flags;
    uint DcFlags;
    uint CacheFlags;
    UNICODE_STRING KdcName;
}

struct KERB_QUERY_BINDING_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfEntries;
    KERB_BINDING_CACHE_ENTRY_DATA* Entries;
}

struct KERB_ADD_BINDING_CACHE_ENTRY_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING RealmName;
    UNICODE_STRING KdcAddress;
    uint AddressType;
    uint DcFlags;
}

struct KERB_QUERY_BINDING_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
}

struct KERB_PURGE_BINDING_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
}

struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    UNICODE_STRING DomainName;
}

struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    uint ExtendedPolicies;
    uint DsFlags;
}

enum KERB_CERTIFICATE_INFO_TYPE
{
    CertHashInfo = 1,
}

struct KERB_CERTIFICATE_HASHINFO
{
    ushort StoreNameLength;
    ushort HashLength;
}

struct KERB_CERTIFICATE_INFO
{
    uint CertInfoSize;
    uint InfoType;
}

struct POLICY_AUDIT_SID_ARRAY
{
    uint UsersCount;
    void** UserSidArray;
}

struct AUDIT_POLICY_INFORMATION
{
    Guid AuditSubCategoryGuid;
    uint AuditingInformation;
    Guid AuditCategoryGuid;
}

struct PKU2U_CERT_BLOB
{
    uint CertOffset;
    ushort CertLength;
}

struct PKU2U_CREDUI_CONTEXT
{
    ulong Version;
    ushort cbHeaderLength;
    uint cbStructureLength;
    ushort CertArrayCount;
    uint CertArrayOffset;
}

enum PKU2U_LOGON_SUBMIT_TYPE
{
    Pku2uCertificateS4ULogon = 14,
}

struct PKU2U_CERTIFICATE_S4U_LOGON
{
    PKU2U_LOGON_SUBMIT_TYPE MessageType;
    uint Flags;
    UNICODE_STRING UserPrincipalName;
    UNICODE_STRING DomainName;
    uint CertificateLength;
    ubyte* Certificate;
}

struct SecPkgInfoW
{
    uint fCapabilities;
    ushort wVersion;
    ushort wRPCID;
    uint cbMaxToken;
    ushort* Name;
    ushort* Comment;
}

struct SecPkgInfoA
{
    uint fCapabilities;
    ushort wVersion;
    ushort wRPCID;
    uint cbMaxToken;
    byte* Name;
    byte* Comment;
}

struct SecBuffer
{
    uint cbBuffer;
    uint BufferType;
    void* pvBuffer;
}

struct SecBufferDesc
{
    uint ulVersion;
    uint cBuffers;
    SecBuffer* pBuffers;
}

struct SEC_NEGOTIATION_INFO
{
    uint Size;
    uint NameLength;
    ushort* Name;
    void* Reserved;
}

struct SEC_CHANNEL_BINDINGS
{
    uint dwInitiatorAddrType;
    uint cbInitiatorLength;
    uint dwInitiatorOffset;
    uint dwAcceptorAddrType;
    uint cbAcceptorLength;
    uint dwAcceptorOffset;
    uint cbApplicationDataLength;
    uint dwApplicationDataOffset;
}

enum SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT
{
    SecApplicationProtocolNegotiationExt_None = 0,
    SecApplicationProtocolNegotiationExt_NPN = 1,
    SecApplicationProtocolNegotiationExt_ALPN = 2,
}

struct SEC_APPLICATION_PROTOCOL_LIST
{
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT ProtoNegoExt;
    ushort ProtocolListSize;
    ubyte ProtocolList;
}

struct SEC_APPLICATION_PROTOCOLS
{
    uint ProtocolListsSize;
    SEC_APPLICATION_PROTOCOL_LIST ProtocolLists;
}

struct SEC_SRTP_PROTECTION_PROFILES
{
    ushort ProfilesSize;
    ushort ProfilesList;
}

struct SEC_SRTP_MASTER_KEY_IDENTIFIER
{
    ubyte MasterKeyIdentifierSize;
    ubyte MasterKeyIdentifier;
}

struct SEC_TOKEN_BINDING
{
    ubyte MajorVersion;
    ubyte MinorVersion;
    ushort KeyParametersSize;
    ubyte KeyParameters;
}

struct SEC_PRESHAREDKEY
{
    ushort KeySize;
    ubyte Key;
}

struct SEC_PRESHAREDKEY_IDENTITY
{
    ushort KeyIdentitySize;
    ubyte KeyIdentity;
}

struct SEC_DTLS_MTU
{
    ushort PathMTU;
}

struct SEC_FLAGS
{
    ulong Flags;
}

enum SEC_TRAFFIC_SECRET_TYPE
{
    SecTrafficSecret_None = 0,
    SecTrafficSecret_Client = 1,
    SecTrafficSecret_Server = 2,
}

struct SEC_TRAFFIC_SECRETS
{
    ushort SymmetricAlgId;
    ushort ChainingMode;
    ushort HashAlgId;
    ushort KeySize;
    ushort IvSize;
    ushort MsgSequenceStart;
    ushort MsgSequenceEnd;
    SEC_TRAFFIC_SECRET_TYPE TrafficSecretType;
    ushort TrafficSecretSize;
    ubyte TrafficSecret;
}

struct SecPkgCredentials_NamesW
{
    ushort* sUserName;
}

struct SecPkgCredentials_NamesA
{
    byte* sUserName;
}

struct SecPkgCredentials_SSIProviderW
{
    ushort* sProviderName;
    uint ProviderInfoLength;
    byte* ProviderInfo;
}

struct SecPkgCredentials_SSIProviderA
{
    byte* sProviderName;
    uint ProviderInfoLength;
    byte* ProviderInfo;
}

struct SecPkgCredentials_KdcProxySettingsW
{
    uint Version;
    uint Flags;
    ushort ProxyServerOffset;
    ushort ProxyServerLength;
    ushort ClientTlsCredOffset;
    ushort ClientTlsCredLength;
}

struct SecPkgCredentials_Cert
{
    uint EncodedCertSize;
    ubyte* EncodedCert;
}

struct SecPkgContext_SubjectAttributes
{
    void* AttributeInfo;
}

enum SECPKG_CRED_CLASS
{
    SecPkgCredClass_None = 0,
    SecPkgCredClass_Ephemeral = 10,
    SecPkgCredClass_PersistedGeneric = 20,
    SecPkgCredClass_PersistedSpecific = 30,
    SecPkgCredClass_Explicit = 40,
}

struct SecPkgContext_CredInfo
{
    SECPKG_CRED_CLASS CredClass;
    uint IsPromptingNeeded;
}

struct SecPkgContext_NegoPackageInfo
{
    uint PackageMask;
}

struct SecPkgContext_NegoStatus
{
    uint LastStatus;
}

struct SecPkgContext_Sizes
{
    uint cbMaxToken;
    uint cbMaxSignature;
    uint cbBlockSize;
    uint cbSecurityTrailer;
}

struct SecPkgContext_StreamSizes
{
    uint cbHeader;
    uint cbTrailer;
    uint cbMaximumMessage;
    uint cBuffers;
    uint cbBlockSize;
}

struct SecPkgContext_NamesW
{
    ushort* sUserName;
}

enum SECPKG_ATTR_LCT_STATUS
{
    SecPkgAttrLastClientTokenYes = 0,
    SecPkgAttrLastClientTokenNo = 1,
    SecPkgAttrLastClientTokenMaybe = 2,
}

struct SecPkgContext_LastClientTokenStatus
{
    SECPKG_ATTR_LCT_STATUS LastClientTokenStatus;
}

struct SecPkgContext_NamesA
{
    byte* sUserName;
}

struct SecPkgContext_Lifespan
{
    LARGE_INTEGER tsStart;
    LARGE_INTEGER tsExpiry;
}

struct SecPkgContext_DceInfo
{
    uint AuthzSvc;
    void* pPac;
}

struct SecPkgContext_KeyInfoA
{
    byte* sSignatureAlgorithmName;
    byte* sEncryptAlgorithmName;
    uint KeySize;
    uint SignatureAlgorithm;
    uint EncryptAlgorithm;
}

struct SecPkgContext_KeyInfoW
{
    ushort* sSignatureAlgorithmName;
    ushort* sEncryptAlgorithmName;
    uint KeySize;
    uint SignatureAlgorithm;
    uint EncryptAlgorithm;
}

struct SecPkgContext_AuthorityA
{
    byte* sAuthorityName;
}

struct SecPkgContext_AuthorityW
{
    ushort* sAuthorityName;
}

struct SecPkgContext_ProtoInfoA
{
    byte* sProtocolName;
    uint majorVersion;
    uint minorVersion;
}

struct SecPkgContext_ProtoInfoW
{
    ushort* sProtocolName;
    uint majorVersion;
    uint minorVersion;
}

struct SecPkgContext_PasswordExpiry
{
    LARGE_INTEGER tsPasswordExpires;
}

struct SecPkgContext_LogoffTime
{
    LARGE_INTEGER tsLogoffTime;
}

struct SecPkgContext_SessionKey
{
    uint SessionKeyLength;
    ubyte* SessionKey;
}

struct SecPkgContext_NegoKeys
{
    uint KeyType;
    ushort KeyLength;
    ubyte* KeyValue;
    uint VerifyKeyType;
    ushort VerifyKeyLength;
    ubyte* VerifyKeyValue;
}

struct SecPkgContext_PackageInfoW
{
    SecPkgInfoW* PackageInfo;
}

struct SecPkgContext_PackageInfoA
{
    SecPkgInfoA* PackageInfo;
}

struct SecPkgContext_UserFlags
{
    uint UserFlags;
}

struct SecPkgContext_Flags
{
    uint Flags;
}

struct SecPkgContext_NegotiationInfoA
{
    SecPkgInfoA* PackageInfo;
    uint NegotiationState;
}

struct SecPkgContext_NegotiationInfoW
{
    SecPkgInfoW* PackageInfo;
    uint NegotiationState;
}

struct SecPkgContext_NativeNamesW
{
    ushort* sClientName;
    ushort* sServerName;
}

struct SecPkgContext_NativeNamesA
{
    byte* sClientName;
    byte* sServerName;
}

struct SecPkgContext_CredentialNameW
{
    uint CredentialType;
    ushort* sCredentialName;
}

struct SecPkgContext_CredentialNameA
{
    uint CredentialType;
    byte* sCredentialName;
}

struct SecPkgContext_AccessToken
{
    void* AccessToken;
}

struct SecPkgContext_TargetInformation
{
    uint MarshalledTargetInfoLength;
    ubyte* MarshalledTargetInfo;
}

struct SecPkgContext_AuthzID
{
    uint AuthzIDLength;
    byte* AuthzID;
}

struct SecPkgContext_Target
{
    uint TargetLength;
    byte* Target;
}

struct SecPkgContext_ClientSpecifiedTarget
{
    ushort* sTargetName;
}

struct SecPkgContext_Bindings
{
    uint BindingsLength;
    SEC_CHANNEL_BINDINGS* Bindings;
}

enum SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS
{
    SecApplicationProtocolNegotiationStatus_None = 0,
    SecApplicationProtocolNegotiationStatus_Success = 1,
    SecApplicationProtocolNegotiationStatus_SelectedClientOnly = 2,
}

struct SecPkgContext_ApplicationProtocol
{
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS ProtoNegoStatus;
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT ProtoNegoExt;
    ubyte ProtocolIdSize;
    ubyte ProtocolId;
}

struct SecPkgContext_NegotiatedTlsExtensions
{
    uint ExtensionsCount;
    ushort* Extensions;
}

struct SECPKG_APP_MODE_INFO
{
    uint UserFunction;
    uint Argument1;
    uint Argument2;
    SecBuffer UserData;
    ubyte ReturnToLsa;
}

alias SEC_GET_KEY_FN = extern(Windows) void function(void* Arg, void* Principal, uint KeyVer, void** Key, int* Status);
alias ACQUIRE_CREDENTIALS_HANDLE_FN_W = extern(Windows) int function(ushort* param0, ushort* param1, uint param2, void* param3, void* param4, SEC_GET_KEY_FN param5, void* param6, SecHandle* param7, LARGE_INTEGER* param8);
alias ACQUIRE_CREDENTIALS_HANDLE_FN_A = extern(Windows) int function(byte* param0, byte* param1, uint param2, void* param3, void* param4, SEC_GET_KEY_FN param5, void* param6, SecHandle* param7, LARGE_INTEGER* param8);
alias FREE_CREDENTIALS_HANDLE_FN = extern(Windows) int function(SecHandle* param0);
alias ADD_CREDENTIALS_FN_W = extern(Windows) int function(SecHandle* param0, ushort* param1, ushort* param2, uint param3, void* param4, SEC_GET_KEY_FN param5, void* param6, LARGE_INTEGER* param7);
alias ADD_CREDENTIALS_FN_A = extern(Windows) int function(SecHandle* param0, byte* param1, byte* param2, uint param3, void* param4, SEC_GET_KEY_FN param5, void* param6, LARGE_INTEGER* param7);
alias CHANGE_PASSWORD_FN_W = extern(Windows) int function(ushort* param0, ushort* param1, ushort* param2, ushort* param3, ushort* param4, ubyte param5, uint param6, SecBufferDesc* param7);
alias CHANGE_PASSWORD_FN_A = extern(Windows) int function(byte* param0, byte* param1, byte* param2, byte* param3, byte* param4, ubyte param5, uint param6, SecBufferDesc* param7);
alias INITIALIZE_SECURITY_CONTEXT_FN_W = extern(Windows) int function(SecHandle* param0, SecHandle* param1, ushort* param2, uint param3, uint param4, uint param5, SecBufferDesc* param6, uint param7, SecHandle* param8, SecBufferDesc* param9, uint* param10, LARGE_INTEGER* param11);
alias INITIALIZE_SECURITY_CONTEXT_FN_A = extern(Windows) int function(SecHandle* param0, SecHandle* param1, byte* param2, uint param3, uint param4, uint param5, SecBufferDesc* param6, uint param7, SecHandle* param8, SecBufferDesc* param9, uint* param10, LARGE_INTEGER* param11);
alias ACCEPT_SECURITY_CONTEXT_FN = extern(Windows) int function(SecHandle* param0, SecHandle* param1, SecBufferDesc* param2, uint param3, uint param4, SecHandle* param5, SecBufferDesc* param6, uint* param7, LARGE_INTEGER* param8);
alias COMPLETE_AUTH_TOKEN_FN = extern(Windows) int function(SecHandle* param0, SecBufferDesc* param1);
alias IMPERSONATE_SECURITY_CONTEXT_FN = extern(Windows) int function(SecHandle* param0);
alias REVERT_SECURITY_CONTEXT_FN = extern(Windows) int function(SecHandle* param0);
alias QUERY_SECURITY_CONTEXT_TOKEN_FN = extern(Windows) int function(SecHandle* param0, void** param1);
alias DELETE_SECURITY_CONTEXT_FN = extern(Windows) int function(SecHandle* param0);
alias APPLY_CONTROL_TOKEN_FN = extern(Windows) int function(SecHandle* param0, SecBufferDesc* param1);
alias QUERY_CONTEXT_ATTRIBUTES_FN_W = extern(Windows) int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CONTEXT_ATTRIBUTES_EX_FN_W = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias QUERY_CONTEXT_ATTRIBUTES_FN_A = extern(Windows) int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CONTEXT_ATTRIBUTES_EX_FN_A = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CONTEXT_ATTRIBUTES_FN_W = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CONTEXT_ATTRIBUTES_FN_A = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias QUERY_CREDENTIALS_ATTRIBUTES_FN_W = extern(Windows) int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_W = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias QUERY_CREDENTIALS_ATTRIBUTES_FN_A = extern(Windows) int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_A = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CREDENTIALS_ATTRIBUTES_FN_W = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CREDENTIALS_ATTRIBUTES_FN_A = extern(Windows) int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias FREE_CONTEXT_BUFFER_FN = extern(Windows) int function(void* param0);
alias MAKE_SIGNATURE_FN = extern(Windows) int function(SecHandle* param0, uint param1, SecBufferDesc* param2, uint param3);
alias VERIFY_SIGNATURE_FN = extern(Windows) int function(SecHandle* param0, SecBufferDesc* param1, uint param2, uint* param3);
alias ENCRYPT_MESSAGE_FN = extern(Windows) int function(SecHandle* param0, uint param1, SecBufferDesc* param2, uint param3);
alias DECRYPT_MESSAGE_FN = extern(Windows) int function(SecHandle* param0, SecBufferDesc* param1, uint param2, uint* param3);
alias ENUMERATE_SECURITY_PACKAGES_FN_W = extern(Windows) int function(uint* param0, SecPkgInfoW** param1);
alias ENUMERATE_SECURITY_PACKAGES_FN_A = extern(Windows) int function(uint* param0, SecPkgInfoA** param1);
alias QUERY_SECURITY_PACKAGE_INFO_FN_W = extern(Windows) int function(ushort* param0, SecPkgInfoW** param1);
alias QUERY_SECURITY_PACKAGE_INFO_FN_A = extern(Windows) int function(byte* param0, SecPkgInfoA** param1);
enum SecDelegationType
{
    SecFull = 0,
    SecService = 1,
    SecTree = 2,
    SecDirectory = 3,
    SecObject = 4,
}

alias EXPORT_SECURITY_CONTEXT_FN = extern(Windows) int function(SecHandle* param0, uint param1, SecBuffer* param2, void** param3);
alias IMPORT_SECURITY_CONTEXT_FN_W = extern(Windows) int function(ushort* param0, SecBuffer* param1, void* param2, SecHandle* param3);
alias IMPORT_SECURITY_CONTEXT_FN_A = extern(Windows) int function(byte* param0, SecBuffer* param1, void* param2, SecHandle* param3);
struct SecurityFunctionTableW
{
    uint dwVersion;
    ENUMERATE_SECURITY_PACKAGES_FN_W EnumerateSecurityPackagesW;
    QUERY_CREDENTIALS_ATTRIBUTES_FN_W QueryCredentialsAttributesW;
    ACQUIRE_CREDENTIALS_HANDLE_FN_W AcquireCredentialsHandleW;
    FREE_CREDENTIALS_HANDLE_FN FreeCredentialsHandle;
    void* Reserved2;
    INITIALIZE_SECURITY_CONTEXT_FN_W InitializeSecurityContextW;
    ACCEPT_SECURITY_CONTEXT_FN AcceptSecurityContext;
    COMPLETE_AUTH_TOKEN_FN CompleteAuthToken;
    DELETE_SECURITY_CONTEXT_FN DeleteSecurityContext;
    APPLY_CONTROL_TOKEN_FN ApplyControlToken;
    QUERY_CONTEXT_ATTRIBUTES_FN_W QueryContextAttributesW;
    IMPERSONATE_SECURITY_CONTEXT_FN ImpersonateSecurityContext;
    REVERT_SECURITY_CONTEXT_FN RevertSecurityContext;
    MAKE_SIGNATURE_FN MakeSignature;
    VERIFY_SIGNATURE_FN VerifySignature;
    FREE_CONTEXT_BUFFER_FN FreeContextBuffer;
    QUERY_SECURITY_PACKAGE_INFO_FN_W QuerySecurityPackageInfoW;
    void* Reserved3;
    void* Reserved4;
    EXPORT_SECURITY_CONTEXT_FN ExportSecurityContext;
    IMPORT_SECURITY_CONTEXT_FN_W ImportSecurityContextW;
    ADD_CREDENTIALS_FN_W AddCredentialsW;
    void* Reserved8;
    QUERY_SECURITY_CONTEXT_TOKEN_FN QuerySecurityContextToken;
    ENCRYPT_MESSAGE_FN EncryptMessage;
    DECRYPT_MESSAGE_FN DecryptMessage;
    SET_CONTEXT_ATTRIBUTES_FN_W SetContextAttributesW;
    SET_CREDENTIALS_ATTRIBUTES_FN_W SetCredentialsAttributesW;
    CHANGE_PASSWORD_FN_W ChangeAccountPasswordW;
    QUERY_CONTEXT_ATTRIBUTES_EX_FN_W QueryContextAttributesExW;
    QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_W QueryCredentialsAttributesExW;
}

struct SecurityFunctionTableA
{
    uint dwVersion;
    ENUMERATE_SECURITY_PACKAGES_FN_A EnumerateSecurityPackagesA;
    QUERY_CREDENTIALS_ATTRIBUTES_FN_A QueryCredentialsAttributesA;
    ACQUIRE_CREDENTIALS_HANDLE_FN_A AcquireCredentialsHandleA;
    FREE_CREDENTIALS_HANDLE_FN FreeCredentialsHandle;
    void* Reserved2;
    INITIALIZE_SECURITY_CONTEXT_FN_A InitializeSecurityContextA;
    ACCEPT_SECURITY_CONTEXT_FN AcceptSecurityContext;
    COMPLETE_AUTH_TOKEN_FN CompleteAuthToken;
    DELETE_SECURITY_CONTEXT_FN DeleteSecurityContext;
    APPLY_CONTROL_TOKEN_FN ApplyControlToken;
    QUERY_CONTEXT_ATTRIBUTES_FN_A QueryContextAttributesA;
    IMPERSONATE_SECURITY_CONTEXT_FN ImpersonateSecurityContext;
    REVERT_SECURITY_CONTEXT_FN RevertSecurityContext;
    MAKE_SIGNATURE_FN MakeSignature;
    VERIFY_SIGNATURE_FN VerifySignature;
    FREE_CONTEXT_BUFFER_FN FreeContextBuffer;
    QUERY_SECURITY_PACKAGE_INFO_FN_A QuerySecurityPackageInfoA;
    void* Reserved3;
    void* Reserved4;
    EXPORT_SECURITY_CONTEXT_FN ExportSecurityContext;
    IMPORT_SECURITY_CONTEXT_FN_A ImportSecurityContextA;
    ADD_CREDENTIALS_FN_A AddCredentialsA;
    void* Reserved8;
    QUERY_SECURITY_CONTEXT_TOKEN_FN QuerySecurityContextToken;
    ENCRYPT_MESSAGE_FN EncryptMessage;
    DECRYPT_MESSAGE_FN DecryptMessage;
    SET_CONTEXT_ATTRIBUTES_FN_A SetContextAttributesA;
    SET_CREDENTIALS_ATTRIBUTES_FN_A SetCredentialsAttributesA;
    CHANGE_PASSWORD_FN_A ChangeAccountPasswordA;
    QUERY_CONTEXT_ATTRIBUTES_EX_FN_A QueryContextAttributesExA;
    QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_A QueryCredentialsAttributesExA;
}

alias INIT_SECURITY_INTERFACE_A = extern(Windows) SecurityFunctionTableA* function();
alias INIT_SECURITY_INTERFACE_W = extern(Windows) SecurityFunctionTableW* function();
enum SASL_AUTHZID_STATE
{
    Sasl_AuthZIDForbidden = 0,
    Sasl_AuthZIDProcessed = 1,
}

struct SEC_WINNT_AUTH_IDENTITY_EX2
{
    uint Version;
    ushort cbHeaderLength;
    uint cbStructureLength;
    uint UserOffset;
    ushort UserLength;
    uint DomainOffset;
    ushort DomainLength;
    uint PackedCredentialsOffset;
    ushort PackedCredentialsLength;
    uint Flags;
    uint PackageListOffset;
    ushort PackageListLength;
}

struct SEC_WINNT_AUTH_IDENTITY_EXW
{
    uint Version;
    uint Length;
    ushort* User;
    uint UserLength;
    ushort* Domain;
    uint DomainLength;
    ushort* Password;
    uint PasswordLength;
    uint Flags;
    ushort* PackageList;
    uint PackageListLength;
}

struct SEC_WINNT_AUTH_IDENTITY_EXA
{
    uint Version;
    uint Length;
    ubyte* User;
    uint UserLength;
    ubyte* Domain;
    uint DomainLength;
    ubyte* Password;
    uint PasswordLength;
    uint Flags;
    ubyte* PackageList;
    uint PackageListLength;
}

struct SEC_WINNT_AUTH_IDENTITY_INFO
{
    SEC_WINNT_AUTH_IDENTITY_EXW AuthIdExw;
    SEC_WINNT_AUTH_IDENTITY_EXA AuthIdExa;
    SEC_WINNT_AUTH_IDENTITY_A AuthId_a;
    SEC_WINNT_AUTH_IDENTITY_W AuthId_w;
    SEC_WINNT_AUTH_IDENTITY_EX2 AuthIdEx2;
}

struct SECURITY_PACKAGE_OPTIONS
{
    uint Size;
    uint Type;
    uint Flags;
    uint SignatureSize;
    void* Signature;
}

struct CREDENTIAL_ATTRIBUTEA
{
    const(char)* Keyword;
    uint Flags;
    uint ValueSize;
    ubyte* Value;
}

struct CREDENTIAL_ATTRIBUTEW
{
    const(wchar)* Keyword;
    uint Flags;
    uint ValueSize;
    ubyte* Value;
}

struct CREDENTIALA
{
    uint Flags;
    uint Type;
    const(char)* TargetName;
    const(char)* Comment;
    FILETIME LastWritten;
    uint CredentialBlobSize;
    ubyte* CredentialBlob;
    uint Persist;
    uint AttributeCount;
    CREDENTIAL_ATTRIBUTEA* Attributes;
    const(char)* TargetAlias;
    const(char)* UserName;
}

struct CREDENTIALW
{
    uint Flags;
    uint Type;
    const(wchar)* TargetName;
    const(wchar)* Comment;
    FILETIME LastWritten;
    uint CredentialBlobSize;
    ubyte* CredentialBlob;
    uint Persist;
    uint AttributeCount;
    CREDENTIAL_ATTRIBUTEW* Attributes;
    const(wchar)* TargetAlias;
    const(wchar)* UserName;
}

struct CREDENTIAL_TARGET_INFORMATIONA
{
    const(char)* TargetName;
    const(char)* NetbiosServerName;
    const(char)* DnsServerName;
    const(char)* NetbiosDomainName;
    const(char)* DnsDomainName;
    const(char)* DnsTreeName;
    const(char)* PackageName;
    uint Flags;
    uint CredTypeCount;
    uint* CredTypes;
}

struct CREDENTIAL_TARGET_INFORMATIONW
{
    const(wchar)* TargetName;
    const(wchar)* NetbiosServerName;
    const(wchar)* DnsServerName;
    const(wchar)* NetbiosDomainName;
    const(wchar)* DnsDomainName;
    const(wchar)* DnsTreeName;
    const(wchar)* PackageName;
    uint Flags;
    uint CredTypeCount;
    uint* CredTypes;
}

struct CERT_CREDENTIAL_INFO
{
    uint cbSize;
    ubyte rgbHashOfCert;
}

struct USERNAME_TARGET_CREDENTIAL_INFO
{
    const(wchar)* UserName;
}

struct BINARY_BLOB_CREDENTIAL_INFO
{
    uint cbBlob;
    ubyte* pbBlob;
}

enum CRED_MARSHAL_TYPE
{
    CertCredential = 1,
    UsernameTargetCredential = 2,
    BinaryBlobCredential = 3,
    UsernameForPackedCredentials = 4,
    BinaryBlobForSystem = 5,
}

enum CRED_PROTECTION_TYPE
{
    CredUnprotected = 0,
    CredUserProtection = 1,
    CredTrustedProtection = 2,
    CredForSystemProtection = 3,
}

struct CREDUI_INFOA
{
    uint cbSize;
    HWND hwndParent;
    const(char)* pszMessageText;
    const(char)* pszCaptionText;
    HBITMAP hbmBanner;
}

struct CREDUI_INFOW
{
    uint cbSize;
    HWND hwndParent;
    const(wchar)* pszMessageText;
    const(wchar)* pszCaptionText;
    HBITMAP hbmBanner;
}

enum LSA_TOKEN_INFORMATION_TYPE
{
    LsaTokenInformationNull = 0,
    LsaTokenInformationV1 = 1,
    LsaTokenInformationV2 = 2,
    LsaTokenInformationV3 = 3,
}

struct LSA_TOKEN_INFORMATION_NULL
{
    LARGE_INTEGER ExpirationTime;
    TOKEN_GROUPS* Groups;
}

struct LSA_TOKEN_INFORMATION_V1
{
    LARGE_INTEGER ExpirationTime;
    TOKEN_USER User;
    TOKEN_GROUPS* Groups;
    TOKEN_PRIMARY_GROUP PrimaryGroup;
    TOKEN_PRIVILEGES* Privileges;
    TOKEN_OWNER Owner;
    TOKEN_DEFAULT_DACL DefaultDacl;
}

struct LSA_TOKEN_INFORMATION_V3
{
    LARGE_INTEGER ExpirationTime;
    TOKEN_USER User;
    TOKEN_GROUPS* Groups;
    TOKEN_PRIMARY_GROUP PrimaryGroup;
    TOKEN_PRIVILEGES* Privileges;
    TOKEN_OWNER Owner;
    TOKEN_DEFAULT_DACL DefaultDacl;
    TOKEN_USER_CLAIMS UserClaims;
    TOKEN_DEVICE_CLAIMS DeviceClaims;
    TOKEN_GROUPS* DeviceGroups;
}

alias LSA_CREATE_LOGON_SESSION = extern(Windows) NTSTATUS function(LUID* LogonId);
alias LSA_DELETE_LOGON_SESSION = extern(Windows) NTSTATUS function(LUID* LogonId);
alias LSA_ADD_CREDENTIAL = extern(Windows) NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, STRING* PrimaryKeyValue, STRING* Credentials);
alias LSA_GET_CREDENTIALS = extern(Windows) NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, uint* QueryContext, ubyte RetrieveAllCredentials, STRING* PrimaryKeyValue, uint* PrimaryKeyLength, STRING* Credentials);
alias LSA_DELETE_CREDENTIAL = extern(Windows) NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, STRING* PrimaryKeyValue);
alias LSA_ALLOCATE_LSA_HEAP = extern(Windows) void* function(uint Length);
alias LSA_FREE_LSA_HEAP = extern(Windows) void function(void* Base);
alias LSA_ALLOCATE_PRIVATE_HEAP = extern(Windows) void* function(uint Length);
alias LSA_FREE_PRIVATE_HEAP = extern(Windows) void function(void* Base);
alias LSA_ALLOCATE_CLIENT_BUFFER = extern(Windows) NTSTATUS function(void** ClientRequest, uint LengthRequired, void** ClientBaseAddress);
alias LSA_FREE_CLIENT_BUFFER = extern(Windows) NTSTATUS function(void** ClientRequest, void* ClientBaseAddress);
alias LSA_COPY_TO_CLIENT_BUFFER = extern(Windows) NTSTATUS function(void** ClientRequest, uint Length, char* ClientBaseAddress, char* BufferToCopy);
alias LSA_COPY_FROM_CLIENT_BUFFER = extern(Windows) NTSTATUS function(void** ClientRequest, uint Length, char* BufferToCopy, char* ClientBaseAddress);
alias PLSA_CREATE_LOGON_SESSION = extern(Windows) NTSTATUS function();
alias PLSA_DELETE_LOGON_SESSION = extern(Windows) NTSTATUS function();
alias PLSA_ADD_CREDENTIAL = extern(Windows) NTSTATUS function();
alias PLSA_GET_CREDENTIALS = extern(Windows) NTSTATUS function();
alias PLSA_DELETE_CREDENTIAL = extern(Windows) NTSTATUS function();
alias PLSA_ALLOCATE_LSA_HEAP = extern(Windows) void* function();
alias PLSA_FREE_LSA_HEAP = extern(Windows) void function();
alias PLSA_ALLOCATE_PRIVATE_HEAP = extern(Windows) void* function();
alias PLSA_FREE_PRIVATE_HEAP = extern(Windows) void function();
alias PLSA_ALLOCATE_CLIENT_BUFFER = extern(Windows) NTSTATUS function();
alias PLSA_FREE_CLIENT_BUFFER = extern(Windows) NTSTATUS function();
alias PLSA_COPY_TO_CLIENT_BUFFER = extern(Windows) NTSTATUS function();
alias PLSA_COPY_FROM_CLIENT_BUFFER = extern(Windows) NTSTATUS function();
struct LSA_DISPATCH_TABLE
{
    PLSA_CREATE_LOGON_SESSION CreateLogonSession;
    PLSA_DELETE_LOGON_SESSION DeleteLogonSession;
    PLSA_ADD_CREDENTIAL AddCredential;
    PLSA_GET_CREDENTIALS GetCredentials;
    PLSA_DELETE_CREDENTIAL DeleteCredential;
    PLSA_ALLOCATE_LSA_HEAP AllocateLsaHeap;
    PLSA_FREE_LSA_HEAP FreeLsaHeap;
    PLSA_ALLOCATE_CLIENT_BUFFER AllocateClientBuffer;
    PLSA_FREE_CLIENT_BUFFER FreeClientBuffer;
    PLSA_COPY_TO_CLIENT_BUFFER CopyToClientBuffer;
    PLSA_COPY_FROM_CLIENT_BUFFER CopyFromClientBuffer;
}

alias LSA_AP_INITIALIZE_PACKAGE = extern(Windows) NTSTATUS function(uint AuthenticationPackageId, LSA_DISPATCH_TABLE* LsaDispatchTable, STRING* Database, STRING* Confidentiality, STRING** AuthenticationPackageName);
alias LSA_AP_LOGON_USER = extern(Windows) NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, char* AuthenticationInformation, void* ClientAuthenticationBase, uint AuthenticationInformationLength, void** ProfileBuffer, uint* ProfileBufferLength, LUID* LogonId, int* SubStatus, LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, void** TokenInformation, UNICODE_STRING** AccountName, UNICODE_STRING** AuthenticatingAuthority);
alias LSA_AP_LOGON_USER_EX = extern(Windows) NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, char* AuthenticationInformation, void* ClientAuthenticationBase, uint AuthenticationInformationLength, void** ProfileBuffer, uint* ProfileBufferLength, LUID* LogonId, int* SubStatus, LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, void** TokenInformation, UNICODE_STRING** AccountName, UNICODE_STRING** AuthenticatingAuthority, UNICODE_STRING** MachineName);
alias LSA_AP_CALL_PACKAGE = extern(Windows) NTSTATUS function(void** ClientRequest, char* ProtocolSubmitBuffer, void* ClientBufferBase, uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, int* ProtocolStatus);
alias LSA_AP_CALL_PACKAGE_PASSTHROUGH = extern(Windows) NTSTATUS function(void** ClientRequest, char* ProtocolSubmitBuffer, void* ClientBufferBase, uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, int* ProtocolStatus);
alias LSA_AP_LOGON_TERMINATED = extern(Windows) void function(LUID* LogonId);
alias LSA_AP_CALL_PACKAGE_UNTRUSTED = extern(Windows) NTSTATUS function();
alias PLSA_AP_INITIALIZE_PACKAGE = extern(Windows) NTSTATUS function();
alias PLSA_AP_LOGON_USER = extern(Windows) NTSTATUS function();
alias PLSA_AP_LOGON_USER_EX = extern(Windows) NTSTATUS function();
alias PLSA_AP_CALL_PACKAGE = extern(Windows) NTSTATUS function();
alias PLSA_AP_CALL_PACKAGE_PASSTHROUGH = extern(Windows) NTSTATUS function();
alias PLSA_AP_LOGON_TERMINATED = extern(Windows) void function();
alias PLSA_AP_CALL_PACKAGE_UNTRUSTED = extern(Windows) NTSTATUS function();
alias PSAM_CREDENTIAL_UPDATE_NOTIFY_ROUTINE = extern(Windows) NTSTATUS function(UNICODE_STRING* ClearPassword, char* OldCredentials, uint OldCredentialSize, uint UserAccountControl, UNICODE_STRING* UPN, UNICODE_STRING* UserName, UNICODE_STRING* NetbiosDomainName, UNICODE_STRING* DnsDomainName, void** NewCredentials, uint* NewCredentialSize);
alias PSAM_CREDENTIAL_UPDATE_REGISTER_ROUTINE = extern(Windows) ubyte function(UNICODE_STRING* CredentialName);
alias PSAM_CREDENTIAL_UPDATE_FREE_ROUTINE = extern(Windows) void function(void* p);
struct SAM_REGISTER_MAPPING_ELEMENT
{
    const(char)* Original;
    const(char)* Mapped;
    ubyte Continuable;
}

struct SAM_REGISTER_MAPPING_LIST
{
    uint Count;
    SAM_REGISTER_MAPPING_ELEMENT* Elements;
}

struct SAM_REGISTER_MAPPING_TABLE
{
    uint Count;
    SAM_REGISTER_MAPPING_LIST* Lists;
}

alias PSAM_CREDENTIAL_UPDATE_REGISTER_MAPPED_ENTRYPOINTS_ROUTINE = extern(Windows) NTSTATUS function(SAM_REGISTER_MAPPING_TABLE* Table);
alias SEC_THREAD_START = extern(Windows) uint function();
struct SECPKG_CLIENT_INFO
{
    LUID LogonId;
    uint ProcessID;
    uint ThreadID;
    ubyte HasTcbPrivilege;
    ubyte Impersonating;
    ubyte Restricted;
    ubyte ClientFlags;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    HANDLE ClientToken;
}

struct SECPKG_CALL_INFO
{
    uint ProcessId;
    uint ThreadId;
    uint Attributes;
    uint CallCount;
    void* MechOid;
}

struct SECPKG_SUPPLEMENTAL_CRED
{
    UNICODE_STRING PackageName;
    uint CredentialSize;
    ubyte* Credentials;
}

struct SECPKG_BYTE_VECTOR
{
    uint ByteArrayOffset;
    ushort ByteArrayLength;
}

struct SECPKG_SHORT_VECTOR
{
    uint ShortArrayOffset;
    ushort ShortArrayCount;
}

struct SECPKG_SUPPLIED_CREDENTIAL
{
    ushort cbHeaderLength;
    ushort cbStructureLength;
    SECPKG_SHORT_VECTOR UserName;
    SECPKG_SHORT_VECTOR DomainName;
    SECPKG_BYTE_VECTOR PackedCredentials;
    uint CredFlags;
}

struct SECPKG_CREDENTIAL
{
    ulong Version;
    ushort cbHeaderLength;
    uint cbStructureLength;
    uint ClientProcess;
    uint ClientThread;
    LUID LogonId;
    HANDLE ClientToken;
    uint SessionId;
    LUID ModifiedId;
    uint fCredentials;
    uint Flags;
    SECPKG_BYTE_VECTOR PrincipalName;
    SECPKG_BYTE_VECTOR PackageList;
    SECPKG_BYTE_VECTOR MarshaledSuppliedCreds;
}

struct SECPKG_SUPPLEMENTAL_CRED_ARRAY
{
    uint CredentialCount;
    SECPKG_SUPPLEMENTAL_CRED Credentials;
}

struct SECPKG_SURROGATE_LOGON_ENTRY
{
    Guid Type;
    void* Data;
}

struct SECPKG_SURROGATE_LOGON
{
    uint Version;
    LUID SurrogateLogonID;
    uint EntryCount;
    SECPKG_SURROGATE_LOGON_ENTRY* Entries;
}

alias LSA_CALLBACK_FUNCTION = extern(Windows) NTSTATUS function(uint Argument1, uint Argument2, SecBuffer* InputBuffer, SecBuffer* OutputBuffer);
alias PLSA_CALLBACK_FUNCTION = extern(Windows) NTSTATUS function();
struct SECPKG_PRIMARY_CRED
{
    LUID LogonId;
    UNICODE_STRING DownlevelName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
    UNICODE_STRING OldPassword;
    void* UserSid;
    uint Flags;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING Upn;
    UNICODE_STRING LogonServer;
    UNICODE_STRING Spare1;
    UNICODE_STRING Spare2;
    UNICODE_STRING Spare3;
    UNICODE_STRING Spare4;
}

struct SECPKG_PRIMARY_CRED_EX
{
    LUID LogonId;
    UNICODE_STRING DownlevelName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
    UNICODE_STRING OldPassword;
    void* UserSid;
    uint Flags;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING Upn;
    UNICODE_STRING LogonServer;
    UNICODE_STRING Spare1;
    UNICODE_STRING Spare2;
    UNICODE_STRING Spare3;
    UNICODE_STRING Spare4;
    uint PackageId;
    LUID PrevLogonId;
}

struct SECPKG_PARAMETERS
{
    uint Version;
    uint MachineState;
    uint SetupMode;
    void* DomainSid;
    UNICODE_STRING DomainName;
    UNICODE_STRING DnsDomainName;
    Guid DomainGuid;
}

enum SECPKG_EXTENDED_INFORMATION_CLASS
{
    SecpkgGssInfo = 1,
    SecpkgContextThunks = 2,
    SecpkgMutualAuthLevel = 3,
    SecpkgWowClientDll = 4,
    SecpkgExtraOids = 5,
    SecpkgMaxInfo = 6,
    SecpkgNego2Info = 7,
}

struct SECPKG_GSS_INFO
{
    uint EncodedIdLength;
    ubyte EncodedId;
}

struct SECPKG_CONTEXT_THUNKS
{
    uint InfoLevelCount;
    uint Levels;
}

struct SECPKG_MUTUAL_AUTH_LEVEL
{
    uint MutualAuthLevel;
}

struct SECPKG_WOW_CLIENT_DLL
{
    UNICODE_STRING WowClientDllPath;
}

struct SECPKG_SERIALIZED_OID
{
    uint OidLength;
    uint OidAttributes;
    ubyte OidValue;
}

struct SECPKG_EXTRA_OIDS
{
    uint OidCount;
    SECPKG_SERIALIZED_OID Oids;
}

struct SECPKG_NEGO2_INFO
{
    ubyte AuthScheme;
    uint PackageFlags;
}

struct SECPKG_EXTENDED_INFORMATION
{
    SECPKG_EXTENDED_INFORMATION_CLASS Class;
    _Info_e__Union Info;
}

struct SECPKG_TARGETINFO
{
    void* DomainSid;
    const(wchar)* ComputerName;
}

struct SecPkgContext_SaslContext
{
    void* SaslContext;
}

struct SECURITY_USER_DATA
{
    UNICODE_STRING UserName;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING LogonServer;
    void* pSid;
}

enum SECPKG_CALL_PACKAGE_MESSAGE_TYPE
{
    SecPkgCallPackageMinMessage = 1024,
    SecPkgCallPackagePinDcMessage = 1024,
    SecPkgCallPackageUnpinAllDcsMessage = 1025,
    SecPkgCallPackageTransferCredMessage = 1026,
    SecPkgCallPackageMaxMessage = 1026,
}

struct SECPKG_CALL_PACKAGE_PIN_DC_REQUEST
{
    uint MessageType;
    uint Flags;
    UNICODE_STRING DomainName;
    UNICODE_STRING DcName;
    uint DcFlags;
}

struct SECPKG_CALL_PACKAGE_UNPIN_ALL_DCS_REQUEST
{
    uint MessageType;
    uint Flags;
}

struct SECPKG_CALL_PACKAGE_TRANSFER_CRED_REQUEST
{
    uint MessageType;
    LUID OriginLogonId;
    LUID DestinationLogonId;
    uint Flags;
}

alias LSA_REDIRECTED_LOGON_INIT = extern(Windows) NTSTATUS function(HANDLE RedirectedLogonHandle, const(UNICODE_STRING)* PackageName, uint SessionId, const(LUID)* LogonId);
alias LSA_REDIRECTED_LOGON_CALLBACK = extern(Windows) NTSTATUS function(HANDLE RedirectedLogonHandle, void* Buffer, uint BufferLength, void** ReturnBuffer, uint* ReturnBufferLength);
alias LSA_REDIRECTED_LOGON_CLEANUP_CALLBACK = extern(Windows) void function(HANDLE RedirectedLogonHandle);
alias LSA_REDIRECTED_LOGON_GET_LOGON_CREDS = extern(Windows) NTSTATUS function(HANDLE RedirectedLogonHandle, ubyte** LogonBuffer, uint* LogonBufferLength);
alias LSA_REDIRECTED_LOGON_GET_SUPP_CREDS = extern(Windows) NTSTATUS function(HANDLE RedirectedLogonHandle, SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_REDIRECTED_LOGON_INIT = extern(Windows) NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_CALLBACK = extern(Windows) NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_GET_LOGON_CREDS = extern(Windows) NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_GET_SUPP_CREDS = extern(Windows) NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK = extern(Windows) void function();
struct SECPKG_REDIRECTED_LOGON_BUFFER
{
    Guid RedirectedLogonGuid;
    HANDLE RedirectedLogonHandle;
    PLSA_REDIRECTED_LOGON_INIT Init;
    PLSA_REDIRECTED_LOGON_CALLBACK Callback;
    PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK CleanupCallback;
    PLSA_REDIRECTED_LOGON_GET_LOGON_CREDS GetLogonCreds;
    PLSA_REDIRECTED_LOGON_GET_SUPP_CREDS GetSupplementalCreds;
}

struct SECPKG_POST_LOGON_USER_INFO
{
    uint Flags;
    LUID LogonId;
    LUID LinkedLogonId;
}

alias LSA_IMPERSONATE_CLIENT = extern(Windows) NTSTATUS function();
alias LSA_UNLOAD_PACKAGE = extern(Windows) NTSTATUS function();
alias LSA_DUPLICATE_HANDLE = extern(Windows) NTSTATUS function(HANDLE SourceHandle, int* DestionationHandle);
alias LSA_SAVE_SUPPLEMENTAL_CREDENTIALS = extern(Windows) NTSTATUS function(LUID* LogonId, uint SupplementalCredSize, char* SupplementalCreds, ubyte Synchronous);
alias LSA_CREATE_THREAD = extern(Windows) HANDLE function(SECURITY_ATTRIBUTES* SecurityAttributes, uint StackSize, SEC_THREAD_START StartFunction, void* ThreadParameter, uint CreationFlags, uint* ThreadId);
alias LSA_GET_CLIENT_INFO = extern(Windows) NTSTATUS function(SECPKG_CLIENT_INFO* ClientInfo);
alias LSA_REGISTER_NOTIFICATION = extern(Windows) HANDLE function(SEC_THREAD_START StartFunction, void* Parameter, uint NotificationType, uint NotificationClass, uint NotificationFlags, uint IntervalMinutes, HANDLE WaitEvent);
alias LSA_CANCEL_NOTIFICATION = extern(Windows) NTSTATUS function(HANDLE NotifyHandle);
alias LSA_MAP_BUFFER = extern(Windows) NTSTATUS function(SecBuffer* InputBuffer, SecBuffer* OutputBuffer);
alias LSA_CREATE_TOKEN = extern(Windows) NTSTATUS function(LUID* LogonId, TOKEN_SOURCE* TokenSource, SECURITY_LOGON_TYPE LogonType, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, LSA_TOKEN_INFORMATION_TYPE TokenInformationType, void* TokenInformation, TOKEN_GROUPS* TokenGroups, UNICODE_STRING* AccountName, UNICODE_STRING* AuthorityName, UNICODE_STRING* Workstation, UNICODE_STRING* ProfilePath, int* Token, int* SubStatus);
enum SECPKG_SESSIONINFO_TYPE
{
    SecSessionPrimaryCred = 0,
}

alias LSA_CREATE_TOKEN_EX = extern(Windows) NTSTATUS function(LUID* LogonId, TOKEN_SOURCE* TokenSource, SECURITY_LOGON_TYPE LogonType, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, LSA_TOKEN_INFORMATION_TYPE TokenInformationType, void* TokenInformation, TOKEN_GROUPS* TokenGroups, UNICODE_STRING* Workstation, UNICODE_STRING* ProfilePath, void* SessionInformation, SECPKG_SESSIONINFO_TYPE SessionInformationType, int* Token, int* SubStatus);
alias LSA_AUDIT_LOGON = extern(Windows) void function(NTSTATUS Status, NTSTATUS SubStatus, UNICODE_STRING* AccountName, UNICODE_STRING* AuthenticatingAuthority, UNICODE_STRING* WorkstationName, void* UserSid, SECURITY_LOGON_TYPE LogonType, TOKEN_SOURCE* TokenSource, LUID* LogonId);
alias LSA_CALL_PACKAGE = extern(Windows) NTSTATUS function(UNICODE_STRING* AuthenticationPackage, char* ProtocolSubmitBuffer, uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, int* ProtocolStatus);
alias LSA_CALL_PACKAGEEX = extern(Windows) NTSTATUS function(UNICODE_STRING* AuthenticationPackage, void* ClientBufferBase, char* ProtocolSubmitBuffer, uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, int* ProtocolStatus);
alias LSA_CALL_PACKAGE_PASSTHROUGH = extern(Windows) NTSTATUS function(UNICODE_STRING* AuthenticationPackage, void* ClientBufferBase, char* ProtocolSubmitBuffer, uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, int* ProtocolStatus);
alias LSA_GET_CALL_INFO = extern(Windows) ubyte function(SECPKG_CALL_INFO* Info);
alias LSA_CREATE_SHARED_MEMORY = extern(Windows) void* function(uint MaxSize, uint InitialSize);
alias LSA_ALLOCATE_SHARED_MEMORY = extern(Windows) void* function(void* SharedMem, uint Size);
alias LSA_FREE_SHARED_MEMORY = extern(Windows) void function(void* SharedMem, void* Memory);
alias LSA_DELETE_SHARED_MEMORY = extern(Windows) ubyte function(void* SharedMem);
alias LSA_GET_APP_MODE_INFO = extern(Windows) NTSTATUS function(uint* UserFunction, uint* Argument1, uint* Argument2, SecBuffer* UserData, ubyte* ReturnToLsa);
alias LSA_SET_APP_MODE_INFO = extern(Windows) NTSTATUS function(uint UserFunction, uint Argument1, uint Argument2, SecBuffer* UserData, ubyte ReturnToLsa);
enum SECPKG_NAME_TYPE
{
    SecNameSamCompatible = 0,
    SecNameAlternateId = 1,
    SecNameFlat = 2,
    SecNameDN = 3,
    SecNameSPN = 4,
}

alias LSA_OPEN_SAM_USER = extern(Windows) NTSTATUS function(UNICODE_STRING* Name, SECPKG_NAME_TYPE NameType, UNICODE_STRING* Prefix, ubyte AllowGuest, uint Reserved, void** UserHandle);
alias LSA_GET_USER_CREDENTIALS = extern(Windows) NTSTATUS function(void* UserHandle, void** PrimaryCreds, uint* PrimaryCredsSize, void** SupplementalCreds, uint* SupplementalCredsSize);
alias LSA_GET_USER_AUTH_DATA = extern(Windows) NTSTATUS function(void* UserHandle, ubyte** UserAuthData, uint* UserAuthDataSize);
alias LSA_CLOSE_SAM_USER = extern(Windows) NTSTATUS function(void* UserHandle);
alias LSA_GET_AUTH_DATA_FOR_USER = extern(Windows) NTSTATUS function(UNICODE_STRING* Name, SECPKG_NAME_TYPE NameType, UNICODE_STRING* Prefix, ubyte** UserAuthData, uint* UserAuthDataSize, UNICODE_STRING* UserFlatName);
alias LSA_CONVERT_AUTH_DATA_TO_TOKEN = extern(Windows) NTSTATUS function(void* UserAuthData, uint UserAuthDataSize, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, TOKEN_SOURCE* TokenSource, SECURITY_LOGON_TYPE LogonType, UNICODE_STRING* AuthorityName, int* Token, LUID* LogonId, UNICODE_STRING* AccountName, int* SubStatus);
alias LSA_CRACK_SINGLE_NAME = extern(Windows) NTSTATUS function(uint FormatOffered, ubyte PerformAtGC, UNICODE_STRING* NameInput, UNICODE_STRING* Prefix, uint RequestedFormat, UNICODE_STRING* CrackedName, UNICODE_STRING* DnsDomainName, uint* SubStatus);
alias LSA_AUDIT_ACCOUNT_LOGON = extern(Windows) NTSTATUS function(uint AuditId, ubyte Success, UNICODE_STRING* Source, UNICODE_STRING* ClientName, UNICODE_STRING* MappedName, NTSTATUS Status);
alias LSA_CLIENT_CALLBACK = extern(Windows) NTSTATUS function(const(char)* Callback, uint Argument1, uint Argument2, SecBuffer* Input, SecBuffer* Output);
alias LSA_REGISTER_CALLBACK = extern(Windows) NTSTATUS function(uint CallbackId, PLSA_CALLBACK_FUNCTION Callback);
alias LSA_GET_EXTENDED_CALL_FLAGS = extern(Windows) NTSTATUS function(uint* Flags);
struct SECPKG_EVENT_PACKAGE_CHANGE
{
    uint ChangeType;
    uint PackageId;
    UNICODE_STRING PackageName;
}

struct SECPKG_EVENT_ROLE_CHANGE
{
    uint PreviousRole;
    uint NewRole;
}

struct SECPKG_EVENT_NOTIFY
{
    uint EventClass;
    uint Reserved;
    uint EventDataSize;
    void* EventData;
    void* PackageParameter;
}

alias LSA_UPDATE_PRIMARY_CREDENTIALS = extern(Windows) NTSTATUS function(SECPKG_PRIMARY_CRED* PrimaryCredentials, SECPKG_SUPPLEMENTAL_CRED_ARRAY* Credentials);
alias LSA_PROTECT_MEMORY = extern(Windows) void function(char* Buffer, uint BufferSize);
alias LSA_OPEN_TOKEN_BY_LOGON_ID = extern(Windows) NTSTATUS function(LUID* LogonId, HANDLE* RetTokenHandle);
alias LSA_EXPAND_AUTH_DATA_FOR_DOMAIN = extern(Windows) NTSTATUS function(char* UserAuthData, uint UserAuthDataSize, void* Reserved, ubyte** ExpandedAuthData, uint* ExpandedAuthDataSize);
enum CRED_FETCH
{
    CredFetchDefault = 0,
    CredFetchDPAPI = 1,
    CredFetchForced = 2,
}

alias LSA_GET_SERVICE_ACCOUNT_PASSWORD = extern(Windows) NTSTATUS function(UNICODE_STRING* AccountName, UNICODE_STRING* DomainName, CRED_FETCH CredFetch, FILETIME* FileTimeExpiry, UNICODE_STRING* CurrentPassword, UNICODE_STRING* PreviousPassword, FILETIME* FileTimeCurrPwdValidForOutbound);
alias LSA_AUDIT_LOGON_EX = extern(Windows) void function(NTSTATUS Status, NTSTATUS SubStatus, UNICODE_STRING* AccountName, UNICODE_STRING* AuthenticatingAuthority, UNICODE_STRING* WorkstationName, void* UserSid, SECURITY_LOGON_TYPE LogonType, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, TOKEN_SOURCE* TokenSource, LUID* LogonId);
alias LSA_CHECK_PROTECTED_USER_BY_TOKEN = extern(Windows) NTSTATUS function(HANDLE UserToken, ubyte* ProtectedUser);
alias LSA_QUERY_CLIENT_REQUEST = extern(Windows) NTSTATUS function(void** ClientRequest, uint QueryType, void** ReplyBuffer);
alias PLSA_IMPERSONATE_CLIENT = extern(Windows) NTSTATUS function();
alias PLSA_UNLOAD_PACKAGE = extern(Windows) NTSTATUS function();
alias PLSA_DUPLICATE_HANDLE = extern(Windows) NTSTATUS function();
alias PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS = extern(Windows) NTSTATUS function();
alias PLSA_CREATE_THREAD = extern(Windows) HANDLE function();
alias PLSA_GET_CLIENT_INFO = extern(Windows) NTSTATUS function();
alias PLSA_REGISTER_NOTIFICATION = extern(Windows) HANDLE function();
alias PLSA_CANCEL_NOTIFICATION = extern(Windows) NTSTATUS function();
alias PLSA_MAP_BUFFER = extern(Windows) NTSTATUS function();
alias PLSA_CREATE_TOKEN = extern(Windows) NTSTATUS function();
alias PLSA_AUDIT_LOGON = extern(Windows) void function();
alias PLSA_CALL_PACKAGE = extern(Windows) NTSTATUS function();
alias PLSA_CALL_PACKAGEEX = extern(Windows) NTSTATUS function();
alias PLSA_GET_CALL_INFO = extern(Windows) ubyte function();
alias PLSA_CREATE_SHARED_MEMORY = extern(Windows) void* function();
alias PLSA_ALLOCATE_SHARED_MEMORY = extern(Windows) void* function();
alias PLSA_FREE_SHARED_MEMORY = extern(Windows) void function();
alias PLSA_DELETE_SHARED_MEMORY = extern(Windows) ubyte function();
alias PLSA_OPEN_SAM_USER = extern(Windows) NTSTATUS function();
alias PLSA_GET_USER_CREDENTIALS = extern(Windows) NTSTATUS function();
alias PLSA_GET_USER_AUTH_DATA = extern(Windows) NTSTATUS function();
alias PLSA_CLOSE_SAM_USER = extern(Windows) NTSTATUS function();
alias PLSA_CONVERT_AUTH_DATA_TO_TOKEN = extern(Windows) NTSTATUS function();
alias PLSA_CLIENT_CALLBACK = extern(Windows) NTSTATUS function();
alias PLSA_REGISTER_CALLBACK = extern(Windows) NTSTATUS function();
alias PLSA_UPDATE_PRIMARY_CREDENTIALS = extern(Windows) NTSTATUS function();
alias PLSA_GET_AUTH_DATA_FOR_USER = extern(Windows) NTSTATUS function();
alias PLSA_CRACK_SINGLE_NAME = extern(Windows) NTSTATUS function();
alias PLSA_AUDIT_ACCOUNT_LOGON = extern(Windows) NTSTATUS function();
alias PLSA_CALL_PACKAGE_PASSTHROUGH = extern(Windows) NTSTATUS function();
alias PLSA_PROTECT_MEMORY = extern(Windows) void function();
alias PLSA_OPEN_TOKEN_BY_LOGON_ID = extern(Windows) NTSTATUS function();
alias PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN = extern(Windows) NTSTATUS function();
alias PLSA_CREATE_TOKEN_EX = extern(Windows) NTSTATUS function();
alias PLSA_GET_EXTENDED_CALL_FLAGS = extern(Windows) NTSTATUS function();
alias PLSA_GET_SERVICE_ACCOUNT_PASSWORD = extern(Windows) NTSTATUS function();
alias PLSA_AUDIT_LOGON_EX = extern(Windows) void function();
alias PLSA_CHECK_PROTECTED_USER_BY_TOKEN = extern(Windows) NTSTATUS function();
alias PLSA_QUERY_CLIENT_REQUEST = extern(Windows) NTSTATUS function();
alias PLSA_GET_APP_MODE_INFO = extern(Windows) NTSTATUS function();
alias PLSA_SET_APP_MODE_INFO = extern(Windows) NTSTATUS function();
struct ENCRYPTED_CREDENTIALW
{
    CREDENTIALW Cred;
    uint ClearCredentialBlobSize;
}

alias CredReadFn = extern(Windows) NTSTATUS function(LUID* LogonId, uint CredFlags, const(wchar)* TargetName, uint Type, uint Flags, ENCRYPTED_CREDENTIALW** Credential);
alias CredReadDomainCredentialsFn = extern(Windows) NTSTATUS function(LUID* LogonId, uint CredFlags, CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, uint Flags, uint* Count, ENCRYPTED_CREDENTIALW*** Credential);
alias CredFreeCredentialsFn = extern(Windows) void function(uint Count, char* Credentials);
alias CredWriteFn = extern(Windows) NTSTATUS function(LUID* LogonId, uint CredFlags, ENCRYPTED_CREDENTIALW* Credential, uint Flags);
alias CrediUnmarshalandDecodeStringFn = extern(Windows) NTSTATUS function(const(wchar)* MarshaledString, ubyte** Blob, uint* BlobSize, ubyte* IsFailureFatal);
struct SEC_WINNT_AUTH_IDENTITY32
{
    uint User;
    uint UserLength;
    uint Domain;
    uint DomainLength;
    uint Password;
    uint PasswordLength;
    uint Flags;
}

struct SEC_WINNT_AUTH_IDENTITY_EX32
{
    uint Version;
    uint Length;
    uint User;
    uint UserLength;
    uint Domain;
    uint DomainLength;
    uint Password;
    uint PasswordLength;
    uint Flags;
    uint PackageList;
    uint PackageListLength;
}

struct LSA_SECPKG_FUNCTION_TABLE
{
    PLSA_CREATE_LOGON_SESSION CreateLogonSession;
    PLSA_DELETE_LOGON_SESSION DeleteLogonSession;
    PLSA_ADD_CREDENTIAL AddCredential;
    PLSA_GET_CREDENTIALS GetCredentials;
    PLSA_DELETE_CREDENTIAL DeleteCredential;
    PLSA_ALLOCATE_LSA_HEAP AllocateLsaHeap;
    PLSA_FREE_LSA_HEAP FreeLsaHeap;
    PLSA_ALLOCATE_CLIENT_BUFFER AllocateClientBuffer;
    PLSA_FREE_CLIENT_BUFFER FreeClientBuffer;
    PLSA_COPY_TO_CLIENT_BUFFER CopyToClientBuffer;
    PLSA_COPY_FROM_CLIENT_BUFFER CopyFromClientBuffer;
    PLSA_IMPERSONATE_CLIENT ImpersonateClient;
    PLSA_UNLOAD_PACKAGE UnloadPackage;
    PLSA_DUPLICATE_HANDLE DuplicateHandle;
    PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS SaveSupplementalCredentials;
    PLSA_CREATE_THREAD CreateThread;
    PLSA_GET_CLIENT_INFO GetClientInfo;
    PLSA_REGISTER_NOTIFICATION RegisterNotification;
    PLSA_CANCEL_NOTIFICATION CancelNotification;
    PLSA_MAP_BUFFER MapBuffer;
    PLSA_CREATE_TOKEN CreateToken;
    PLSA_AUDIT_LOGON AuditLogon;
    PLSA_CALL_PACKAGE CallPackage;
    PLSA_FREE_LSA_HEAP FreeReturnBuffer;
    PLSA_GET_CALL_INFO GetCallInfo;
    PLSA_CALL_PACKAGEEX CallPackageEx;
    PLSA_CREATE_SHARED_MEMORY CreateSharedMemory;
    PLSA_ALLOCATE_SHARED_MEMORY AllocateSharedMemory;
    PLSA_FREE_SHARED_MEMORY FreeSharedMemory;
    PLSA_DELETE_SHARED_MEMORY DeleteSharedMemory;
    PLSA_OPEN_SAM_USER OpenSamUser;
    PLSA_GET_USER_CREDENTIALS GetUserCredentials;
    PLSA_GET_USER_AUTH_DATA GetUserAuthData;
    PLSA_CLOSE_SAM_USER CloseSamUser;
    PLSA_CONVERT_AUTH_DATA_TO_TOKEN ConvertAuthDataToToken;
    PLSA_CLIENT_CALLBACK ClientCallback;
    PLSA_UPDATE_PRIMARY_CREDENTIALS UpdateCredentials;
    PLSA_GET_AUTH_DATA_FOR_USER GetAuthDataForUser;
    PLSA_CRACK_SINGLE_NAME CrackSingleName;
    PLSA_AUDIT_ACCOUNT_LOGON AuditAccountLogon;
    PLSA_CALL_PACKAGE_PASSTHROUGH CallPackagePassthrough;
    CredReadFn* CrediRead;
    CredReadDomainCredentialsFn* CrediReadDomainCredentials;
    CredFreeCredentialsFn* CrediFreeCredentials;
    PLSA_PROTECT_MEMORY LsaProtectMemory;
    PLSA_PROTECT_MEMORY LsaUnprotectMemory;
    PLSA_OPEN_TOKEN_BY_LOGON_ID OpenTokenByLogonId;
    PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN ExpandAuthDataForDomain;
    PLSA_ALLOCATE_PRIVATE_HEAP AllocatePrivateHeap;
    PLSA_FREE_PRIVATE_HEAP FreePrivateHeap;
    PLSA_CREATE_TOKEN_EX CreateTokenEx;
    CredWriteFn* CrediWrite;
    CrediUnmarshalandDecodeStringFn* CrediUnmarshalandDecodeString;
    PLSA_PROTECT_MEMORY DummyFunction6;
    PLSA_GET_EXTENDED_CALL_FLAGS GetExtendedCallFlags;
    PLSA_DUPLICATE_HANDLE DuplicateTokenHandle;
    PLSA_GET_SERVICE_ACCOUNT_PASSWORD GetServiceAccountPassword;
    PLSA_PROTECT_MEMORY DummyFunction7;
    PLSA_AUDIT_LOGON_EX AuditLogonEx;
    PLSA_CHECK_PROTECTED_USER_BY_TOKEN CheckProtectedUserByToken;
    PLSA_QUERY_CLIENT_REQUEST QueryClientRequest;
    PLSA_GET_APP_MODE_INFO GetAppModeInfo;
    PLSA_SET_APP_MODE_INFO SetAppModeInfo;
}

alias LSA_LOCATE_PKG_BY_ID = extern(Windows) void* function(uint PackgeId);
alias PLSA_LOCATE_PKG_BY_ID = extern(Windows) void* function();
struct SECPKG_DLL_FUNCTIONS
{
    PLSA_ALLOCATE_LSA_HEAP AllocateHeap;
    PLSA_FREE_LSA_HEAP FreeHeap;
    PLSA_REGISTER_CALLBACK RegisterCallback;
    PLSA_LOCATE_PKG_BY_ID LocatePackageById;
}

alias SpInitializeFn = extern(Windows) NTSTATUS function(uint PackageId, SECPKG_PARAMETERS* Parameters, LSA_SECPKG_FUNCTION_TABLE* FunctionTable);
alias SpShutdownFn = extern(Windows) NTSTATUS function();
alias SpGetInfoFn = extern(Windows) NTSTATUS function(SecPkgInfoA* PackageInfo);
alias SpGetExtendedInformationFn = extern(Windows) NTSTATUS function(SECPKG_EXTENDED_INFORMATION_CLASS Class, SECPKG_EXTENDED_INFORMATION** ppInformation);
alias SpSetExtendedInformationFn = extern(Windows) NTSTATUS function(SECPKG_EXTENDED_INFORMATION_CLASS Class, SECPKG_EXTENDED_INFORMATION* Info);
alias LSA_AP_LOGON_USER_EX2 = extern(Windows) NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, char* ProtocolSubmitBuffer, void* ClientBufferBase, uint SubmitBufferSize, void** ProfileBuffer, uint* ProfileBufferSize, LUID* LogonId, int* SubStatus, LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, void** TokenInformation, UNICODE_STRING** AccountName, UNICODE_STRING** AuthenticatingAuthority, UNICODE_STRING** MachineName, SECPKG_PRIMARY_CRED* PrimaryCredentials, SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_AP_LOGON_USER_EX2 = extern(Windows) NTSTATUS function();
alias LSA_AP_LOGON_USER_EX3 = extern(Windows) NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, char* ProtocolSubmitBuffer, void* ClientBufferBase, uint SubmitBufferSize, SECPKG_SURROGATE_LOGON* SurrogateLogon, void** ProfileBuffer, uint* ProfileBufferSize, LUID* LogonId, int* SubStatus, LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, void** TokenInformation, UNICODE_STRING** AccountName, UNICODE_STRING** AuthenticatingAuthority, UNICODE_STRING** MachineName, SECPKG_PRIMARY_CRED* PrimaryCredentials, SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_AP_LOGON_USER_EX3 = extern(Windows) NTSTATUS function();
alias LSA_AP_PRE_LOGON_USER_SURROGATE = extern(Windows) NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, char* ProtocolSubmitBuffer, void* ClientBufferBase, uint SubmitBufferSize, SECPKG_SURROGATE_LOGON* SurrogateLogon, int* SubStatus);
alias PLSA_AP_PRE_LOGON_USER_SURROGATE = extern(Windows) NTSTATUS function();
alias LSA_AP_POST_LOGON_USER_SURROGATE = extern(Windows) NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, char* ProtocolSubmitBuffer, void* ClientBufferBase, uint SubmitBufferSize, SECPKG_SURROGATE_LOGON* SurrogateLogon, char* ProfileBuffer, uint ProfileBufferSize, LUID* LogonId, NTSTATUS Status, NTSTATUS SubStatus, LSA_TOKEN_INFORMATION_TYPE TokenInformationType, void* TokenInformation, UNICODE_STRING* AccountName, UNICODE_STRING* AuthenticatingAuthority, UNICODE_STRING* MachineName, SECPKG_PRIMARY_CRED* PrimaryCredentials, SECPKG_SUPPLEMENTAL_CRED_ARRAY* SupplementalCredentials);
alias PLSA_AP_POST_LOGON_USER_SURROGATE = extern(Windows) NTSTATUS function();
alias SpAcceptCredentialsFn = extern(Windows) NTSTATUS function(SECURITY_LOGON_TYPE LogonType, UNICODE_STRING* AccountName, SECPKG_PRIMARY_CRED* PrimaryCredentials, SECPKG_SUPPLEMENTAL_CRED* SupplementalCredentials);
alias SpAcquireCredentialsHandleFn = extern(Windows) NTSTATUS function(UNICODE_STRING* PrincipalName, uint CredentialUseFlags, LUID* LogonId, void* AuthorizationData, void* GetKeyFunciton, void* GetKeyArgument, uint* CredentialHandle, LARGE_INTEGER* ExpirationTime);
alias SpFreeCredentialsHandleFn = extern(Windows) NTSTATUS function(uint CredentialHandle);
alias SpQueryCredentialsAttributesFn = extern(Windows) NTSTATUS function(uint CredentialHandle, uint CredentialAttribute, void* Buffer);
alias SpSetCredentialsAttributesFn = extern(Windows) NTSTATUS function(uint CredentialHandle, uint CredentialAttribute, char* Buffer, uint BufferSize);
alias SpAddCredentialsFn = extern(Windows) NTSTATUS function(uint CredentialHandle, UNICODE_STRING* PrincipalName, UNICODE_STRING* Package, uint CredentialUseFlags, void* AuthorizationData, void* GetKeyFunciton, void* GetKeyArgument, LARGE_INTEGER* ExpirationTime);
alias SpSaveCredentialsFn = extern(Windows) NTSTATUS function(uint CredentialHandle, SecBuffer* Credentials);
alias SpGetCredentialsFn = extern(Windows) NTSTATUS function(uint CredentialHandle, SecBuffer* Credentials);
alias SpDeleteCredentialsFn = extern(Windows) NTSTATUS function(uint CredentialHandle, SecBuffer* Key);
alias SpInitLsaModeContextFn = extern(Windows) NTSTATUS function(uint CredentialHandle, uint ContextHandle, UNICODE_STRING* TargetName, uint ContextRequirements, uint TargetDataRep, SecBufferDesc* InputBuffers, uint* NewContextHandle, SecBufferDesc* OutputBuffers, uint* ContextAttributes, LARGE_INTEGER* ExpirationTime, ubyte* MappedContext, SecBuffer* ContextData);
alias SpDeleteContextFn = extern(Windows) NTSTATUS function(uint ContextHandle);
alias SpApplyControlTokenFn = extern(Windows) NTSTATUS function(uint ContextHandle, SecBufferDesc* ControlToken);
alias SpAcceptLsaModeContextFn = extern(Windows) NTSTATUS function(uint CredentialHandle, uint ContextHandle, SecBufferDesc* InputBuffer, uint ContextRequirements, uint TargetDataRep, uint* NewContextHandle, SecBufferDesc* OutputBuffer, uint* ContextAttributes, LARGE_INTEGER* ExpirationTime, ubyte* MappedContext, SecBuffer* ContextData);
alias SpGetUserInfoFn = extern(Windows) NTSTATUS function(LUID* LogonId, uint Flags, SECURITY_USER_DATA** UserData);
alias SpQueryContextAttributesFn = extern(Windows) NTSTATUS function(uint ContextHandle, uint ContextAttribute, void* Buffer);
alias SpSetContextAttributesFn = extern(Windows) NTSTATUS function(uint ContextHandle, uint ContextAttribute, char* Buffer, uint BufferSize);
alias SpChangeAccountPasswordFn = extern(Windows) NTSTATUS function(UNICODE_STRING* pDomainName, UNICODE_STRING* pAccountName, UNICODE_STRING* pOldPassword, UNICODE_STRING* pNewPassword, ubyte Impersonating, SecBufferDesc* pOutput);
alias SpQueryMetaDataFn = extern(Windows) NTSTATUS function(uint CredentialHandle, UNICODE_STRING* TargetName, uint ContextRequirements, uint* MetaDataLength, ubyte** MetaData, uint* ContextHandle);
alias SpExchangeMetaDataFn = extern(Windows) NTSTATUS function(uint CredentialHandle, UNICODE_STRING* TargetName, uint ContextRequirements, uint MetaDataLength, char* MetaData, uint* ContextHandle);
alias SpGetCredUIContextFn = extern(Windows) NTSTATUS function(uint ContextHandle, Guid* CredType, uint* FlatCredUIContextLength, ubyte** FlatCredUIContext);
alias SpUpdateCredentialsFn = extern(Windows) NTSTATUS function(uint ContextHandle, Guid* CredType, uint FlatCredUIContextLength, char* FlatCredUIContext);
alias SpValidateTargetInfoFn = extern(Windows) NTSTATUS function(void** ClientRequest, char* ProtocolSubmitBuffer, void* ClientBufferBase, uint SubmitBufferLength, SECPKG_TARGETINFO* TargetInfo);
alias LSA_AP_POST_LOGON_USER = extern(Windows) NTSTATUS function(SECPKG_POST_LOGON_USER_INFO* PostLogonUserInfo);
alias SpGetRemoteCredGuardLogonBufferFn = extern(Windows) NTSTATUS function(uint CredHandle, uint ContextHandle, const(UNICODE_STRING)* TargetName, int* RedirectedLogonHandle, PLSA_REDIRECTED_LOGON_CALLBACK* Callback, PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK* CleanupCallback, uint* LogonBufferSize, void** LogonBuffer);
alias SpGetRemoteCredGuardSupplementalCredsFn = extern(Windows) NTSTATUS function(uint CredHandle, const(UNICODE_STRING)* TargetName, int* RedirectedLogonHandle, PLSA_REDIRECTED_LOGON_CALLBACK* Callback, PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK* CleanupCallback, uint* SupplementalCredsSize, void** SupplementalCreds);
alias SpGetTbalSupplementalCredsFn = extern(Windows) NTSTATUS function(LUID LogonId, uint* SupplementalCredsSize, void** SupplementalCreds);
struct SECPKG_FUNCTION_TABLE
{
    PLSA_AP_INITIALIZE_PACKAGE InitializePackage;
    PLSA_AP_LOGON_USER LogonUserA;
    PLSA_AP_CALL_PACKAGE CallPackage;
    PLSA_AP_LOGON_TERMINATED LogonTerminated;
    PLSA_AP_CALL_PACKAGE_UNTRUSTED CallPackageUntrusted;
    PLSA_AP_CALL_PACKAGE_PASSTHROUGH CallPackagePassthrough;
    PLSA_AP_LOGON_USER_EX LogonUserExA;
    PLSA_AP_LOGON_USER_EX2 LogonUserEx2;
    SpInitializeFn* Initialize;
    SpShutdownFn* Shutdown;
    SpGetInfoFn* GetInfo;
    SpAcceptCredentialsFn* AcceptCredentials;
    SpAcquireCredentialsHandleFn* AcquireCredentialsHandleA;
    SpQueryCredentialsAttributesFn* QueryCredentialsAttributesA;
    SpFreeCredentialsHandleFn* FreeCredentialsHandle;
    SpSaveCredentialsFn* SaveCredentials;
    SpGetCredentialsFn* GetCredentials;
    SpDeleteCredentialsFn* DeleteCredentials;
    SpInitLsaModeContextFn* InitLsaModeContext;
    SpAcceptLsaModeContextFn* AcceptLsaModeContext;
    SpDeleteContextFn* DeleteContext;
    SpApplyControlTokenFn* ApplyControlToken;
    SpGetUserInfoFn* GetUserInfo;
    SpGetExtendedInformationFn* GetExtendedInformation;
    SpQueryContextAttributesFn* QueryContextAttributesA;
    SpAddCredentialsFn* AddCredentialsA;
    SpSetExtendedInformationFn* SetExtendedInformation;
    SpSetContextAttributesFn* SetContextAttributesA;
    SpSetCredentialsAttributesFn* SetCredentialsAttributesA;
    SpChangeAccountPasswordFn* ChangeAccountPasswordA;
    SpQueryMetaDataFn* QueryMetaData;
    SpExchangeMetaDataFn* ExchangeMetaData;
    SpGetCredUIContextFn* GetCredUIContext;
    SpUpdateCredentialsFn* UpdateCredentials;
    SpValidateTargetInfoFn* ValidateTargetInfo;
    LSA_AP_POST_LOGON_USER* PostLogonUser;
    SpGetRemoteCredGuardLogonBufferFn* GetRemoteCredGuardLogonBuffer;
    SpGetRemoteCredGuardSupplementalCredsFn* GetRemoteCredGuardSupplementalCreds;
    SpGetTbalSupplementalCredsFn* GetTbalSupplementalCreds;
    PLSA_AP_LOGON_USER_EX3 LogonUserEx3;
    PLSA_AP_PRE_LOGON_USER_SURROGATE PreLogonUserSurrogate;
    PLSA_AP_POST_LOGON_USER_SURROGATE PostLogonUserSurrogate;
}

alias SpInstanceInitFn = extern(Windows) NTSTATUS function(uint Version, SECPKG_DLL_FUNCTIONS* FunctionTable, void** UserFunctions);
alias SpInitUserModeContextFn = extern(Windows) NTSTATUS function(uint ContextHandle, SecBuffer* PackedContext);
alias SpMakeSignatureFn = extern(Windows) NTSTATUS function(uint ContextHandle, uint QualityOfProtection, SecBufferDesc* MessageBuffers, uint MessageSequenceNumber);
alias SpVerifySignatureFn = extern(Windows) NTSTATUS function(uint ContextHandle, SecBufferDesc* MessageBuffers, uint MessageSequenceNumber, uint* QualityOfProtection);
alias SpSealMessageFn = extern(Windows) NTSTATUS function(uint ContextHandle, uint QualityOfProtection, SecBufferDesc* MessageBuffers, uint MessageSequenceNumber);
alias SpUnsealMessageFn = extern(Windows) NTSTATUS function(uint ContextHandle, SecBufferDesc* MessageBuffers, uint MessageSequenceNumber, uint* QualityOfProtection);
alias SpGetContextTokenFn = extern(Windows) NTSTATUS function(uint ContextHandle, int* ImpersonationToken);
alias SpExportSecurityContextFn = extern(Windows) NTSTATUS function(uint phContext, uint fFlags, SecBuffer* pPackedContext, int* pToken);
alias SpImportSecurityContextFn = extern(Windows) NTSTATUS function(SecBuffer* pPackedContext, HANDLE Token, uint* phContext);
alias SpCompleteAuthTokenFn = extern(Windows) NTSTATUS function(uint ContextHandle, SecBufferDesc* InputBuffer);
alias SpFormatCredentialsFn = extern(Windows) NTSTATUS function(SecBuffer* Credentials, SecBuffer* FormattedCredentials);
alias SpMarshallSupplementalCredsFn = extern(Windows) NTSTATUS function(uint CredentialSize, char* Credentials, uint* MarshalledCredSize, void** MarshalledCreds);
struct SECPKG_USER_FUNCTION_TABLE
{
    SpInstanceInitFn* InstanceInit;
    SpInitUserModeContextFn* InitUserModeContext;
    SpMakeSignatureFn* MakeSignature;
    SpVerifySignatureFn* VerifySignature;
    SpSealMessageFn* SealMessage;
    SpUnsealMessageFn* UnsealMessage;
    SpGetContextTokenFn* GetContextToken;
    SpQueryContextAttributesFn* QueryContextAttributesA;
    SpCompleteAuthTokenFn* CompleteAuthToken;
    SpDeleteContextFn* DeleteUserModeContext;
    SpFormatCredentialsFn* FormatCredentials;
    SpMarshallSupplementalCredsFn* MarshallSupplementalCreds;
    SpExportSecurityContextFn* ExportContext;
    SpImportSecurityContextFn* ImportContext;
}

alias SpLsaModeInitializeFn = extern(Windows) NTSTATUS function(uint LsaVersion, uint* PackageVersion, SECPKG_FUNCTION_TABLE** ppTables, uint* pcTables);
alias SpUserModeInitializeFn = extern(Windows) NTSTATUS function(uint LsaVersion, uint* PackageVersion, SECPKG_USER_FUNCTION_TABLE** ppTables, uint* pcTables);
enum KSEC_CONTEXT_TYPE
{
    KSecPaged = 0,
    KSecNonPaged = 1,
}

struct KSEC_LIST_ENTRY
{
    LIST_ENTRY List;
    int RefCount;
    uint Signature;
    void* OwningList;
    void* Reserved;
}

alias KSEC_CREATE_CONTEXT_LIST = extern(Windows) void* function(KSEC_CONTEXT_TYPE Type);
alias KSEC_INSERT_LIST_ENTRY = extern(Windows) void function(void* List, KSEC_LIST_ENTRY* Entry);
alias KSEC_REFERENCE_LIST_ENTRY = extern(Windows) NTSTATUS function(KSEC_LIST_ENTRY* Entry, uint Signature, ubyte RemoveNoRef);
alias KSEC_DEREFERENCE_LIST_ENTRY = extern(Windows) void function(KSEC_LIST_ENTRY* Entry, ubyte* Delete);
alias KSEC_SERIALIZE_WINNT_AUTH_DATA = extern(Windows) NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias KSEC_SERIALIZE_SCHANNEL_AUTH_DATA = extern(Windows) NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias PKSEC_CREATE_CONTEXT_LIST = extern(Windows) void* function();
alias PKSEC_INSERT_LIST_ENTRY = extern(Windows) void function();
alias PKSEC_REFERENCE_LIST_ENTRY = extern(Windows) NTSTATUS function();
alias PKSEC_DEREFERENCE_LIST_ENTRY = extern(Windows) void function();
alias PKSEC_SERIALIZE_WINNT_AUTH_DATA = extern(Windows) NTSTATUS function();
alias PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA = extern(Windows) NTSTATUS function();
alias KSEC_LOCATE_PKG_BY_ID = extern(Windows) void* function(uint PackageId);
alias PKSEC_LOCATE_PKG_BY_ID = extern(Windows) void* function();
struct SECPKG_KERNEL_FUNCTIONS
{
    PLSA_ALLOCATE_LSA_HEAP AllocateHeap;
    PLSA_FREE_LSA_HEAP FreeHeap;
    PKSEC_CREATE_CONTEXT_LIST CreateContextList;
    PKSEC_INSERT_LIST_ENTRY InsertListEntry;
    PKSEC_REFERENCE_LIST_ENTRY ReferenceListEntry;
    PKSEC_DEREFERENCE_LIST_ENTRY DereferenceListEntry;
    PKSEC_SERIALIZE_WINNT_AUTH_DATA SerializeWinntAuthData;
    PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA SerializeSchannelAuthData;
    PKSEC_LOCATE_PKG_BY_ID LocatePackageById;
}

alias KspInitPackageFn = extern(Windows) NTSTATUS function(SECPKG_KERNEL_FUNCTIONS* FunctionTable);
alias KspDeleteContextFn = extern(Windows) NTSTATUS function(uint ContextId, uint* LsaContextId);
alias KspInitContextFn = extern(Windows) NTSTATUS function(uint ContextId, SecBuffer* ContextData, uint* NewContextId);
alias KspMakeSignatureFn = extern(Windows) NTSTATUS function(uint ContextId, uint fQOP, SecBufferDesc* Message, uint MessageSeqNo);
alias KspVerifySignatureFn = extern(Windows) NTSTATUS function(uint ContextId, SecBufferDesc* Message, uint MessageSeqNo, uint* pfQOP);
alias KspSealMessageFn = extern(Windows) NTSTATUS function(uint ContextId, uint fQOP, SecBufferDesc* Message, uint MessageSeqNo);
alias KspUnsealMessageFn = extern(Windows) NTSTATUS function(uint ContextId, SecBufferDesc* Message, uint MessageSeqNo, uint* pfQOP);
alias KspGetTokenFn = extern(Windows) NTSTATUS function(uint ContextId, int* ImpersonationToken, void** RawToken);
alias KspQueryAttributesFn = extern(Windows) NTSTATUS function(uint ContextId, uint Attribute, void* Buffer);
alias KspCompleteTokenFn = extern(Windows) NTSTATUS function(uint ContextId, SecBufferDesc* Token);
alias KspMapHandleFn = extern(Windows) NTSTATUS function(uint ContextId, uint* LsaContextId);
alias KspSetPagingModeFn = extern(Windows) NTSTATUS function(ubyte PagingMode);
alias KspSerializeAuthDataFn = extern(Windows) NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
struct SECPKG_KERNEL_FUNCTION_TABLE
{
    KspInitPackageFn* Initialize;
    KspDeleteContextFn* DeleteContext;
    KspInitContextFn* InitContext;
    KspMapHandleFn* MapHandle;
    KspMakeSignatureFn* Sign;
    KspVerifySignatureFn* Verify;
    KspSealMessageFn* Seal;
    KspUnsealMessageFn* Unseal;
    KspGetTokenFn* GetToken;
    KspQueryAttributesFn* QueryAttributes;
    KspCompleteTokenFn* CompleteToken;
    SpExportSecurityContextFn* ExportContext;
    SpImportSecurityContextFn* ImportContext;
    KspSetPagingModeFn* SetPackagePagingMode;
    KspSerializeAuthDataFn* SerializeAuthData;
}

struct SecPkgCred_SupportedAlgs
{
    uint cSupportedAlgs;
    uint* palgSupportedAlgs;
}

struct SecPkgCred_CipherStrengths
{
    uint dwMinimumCipherStrength;
    uint dwMaximumCipherStrength;
}

struct SecPkgCred_SupportedProtocols
{
    uint grbitProtocol;
}

struct SecPkgCred_ClientCertPolicy
{
    uint dwFlags;
    Guid guidPolicyId;
    uint dwCertFlags;
    uint dwUrlRetrievalTimeout;
    BOOL fCheckRevocationFreshnessTime;
    uint dwRevocationFreshnessTime;
    BOOL fOmitUsageCheck;
    const(wchar)* pwszSslCtlStoreName;
    const(wchar)* pwszSslCtlIdentifier;
}

enum eTlsSignatureAlgorithm
{
    TlsSignatureAlgorithm_Anonymous = 0,
    TlsSignatureAlgorithm_Rsa = 1,
    TlsSignatureAlgorithm_Dsa = 2,
    TlsSignatureAlgorithm_Ecdsa = 3,
}

enum eTlsHashAlgorithm
{
    TlsHashAlgorithm_None = 0,
    TlsHashAlgorithm_Md5 = 1,
    TlsHashAlgorithm_Sha1 = 2,
    TlsHashAlgorithm_Sha224 = 3,
    TlsHashAlgorithm_Sha256 = 4,
    TlsHashAlgorithm_Sha384 = 5,
    TlsHashAlgorithm_Sha512 = 6,
}

struct SecPkgContext_RemoteCredentialInfo
{
    uint cbCertificateChain;
    ubyte* pbCertificateChain;
    uint cCertificates;
    uint fFlags;
    uint dwBits;
}

struct SecPkgContext_LocalCredentialInfo
{
    uint cbCertificateChain;
    ubyte* pbCertificateChain;
    uint cCertificates;
    uint fFlags;
    uint dwBits;
}

struct SecPkgContext_ClientCertPolicyResult
{
    HRESULT dwPolicyResult;
    Guid guidPolicyId;
}

struct SecPkgContext_IssuerListInfoEx
{
    CRYPTOAPI_BLOB* aIssuers;
    uint cIssuers;
}

struct SecPkgContext_ConnectionInfo
{
    uint dwProtocol;
    uint aiCipher;
    uint dwCipherStrength;
    uint aiHash;
    uint dwHashStrength;
    uint aiExch;
    uint dwExchStrength;
}

struct SecPkgContext_ConnectionInfoEx
{
    uint dwVersion;
    uint dwProtocol;
    ushort szCipher;
    uint dwCipherStrength;
    ushort szHash;
    uint dwHashStrength;
    ushort szExchange;
    uint dwExchStrength;
}

struct SecPkgContext_CipherInfo
{
    uint dwVersion;
    uint dwProtocol;
    uint dwCipherSuite;
    uint dwBaseCipherSuite;
    ushort szCipherSuite;
    ushort szCipher;
    uint dwCipherLen;
    uint dwCipherBlockLen;
    ushort szHash;
    uint dwHashLen;
    ushort szExchange;
    uint dwMinExchangeLen;
    uint dwMaxExchangeLen;
    ushort szCertificate;
    uint dwKeyType;
}

struct SecPkgContext_EapKeyBlock
{
    ubyte rgbKeys;
    ubyte rgbIVs;
}

struct SecPkgContext_MappedCredAttr
{
    uint dwAttribute;
    void* pvBuffer;
}

struct SecPkgContext_SessionInfo
{
    uint dwFlags;
    uint cbSessionId;
    ubyte rgbSessionId;
}

struct SecPkgContext_SessionAppData
{
    uint dwFlags;
    uint cbAppData;
    ubyte* pbAppData;
}

struct SecPkgContext_EapPrfInfo
{
    uint dwVersion;
    uint cbPrfData;
    ubyte* pbPrfData;
}

struct SecPkgContext_SupportedSignatures
{
    ushort cSignatureAndHashAlgorithms;
    ushort* pSignatureAndHashAlgorithms;
}

struct SecPkgContext_Certificates
{
    uint cCertificates;
    uint cbCertificateChain;
    ubyte* pbCertificateChain;
}

struct SecPkgContext_CertInfo
{
    uint dwVersion;
    uint cbSubjectName;
    const(wchar)* pwszSubjectName;
    uint cbIssuerName;
    const(wchar)* pwszIssuerName;
    uint dwKeySize;
}

struct SecPkgContext_UiInfo
{
    HWND hParentWindow;
}

struct SecPkgContext_EarlyStart
{
    uint dwEarlyStartFlags;
}

struct SecPkgContext_KeyingMaterialInfo
{
    ushort cbLabel;
    const(char)* pszLabel;
    ushort cbContextValue;
    ubyte* pbContextValue;
    uint cbKeyingMaterial;
}

struct SecPkgContext_KeyingMaterial
{
    uint cbKeyingMaterial;
    ubyte* pbKeyingMaterial;
}

struct SecPkgContext_KeyingMaterial_Inproc
{
    ushort cbLabel;
    const(char)* pszLabel;
    ushort cbContextValue;
    ubyte* pbContextValue;
    uint cbKeyingMaterial;
    ubyte* pbKeyingMaterial;
}

struct SecPkgContext_SrtpParameters
{
    ushort ProtectionProfile;
    ubyte MasterKeyIdentifierSize;
    ubyte* MasterKeyIdentifier;
}

struct SecPkgContext_TokenBinding
{
    ubyte MajorVersion;
    ubyte MinorVersion;
    ushort KeyParametersSize;
    ubyte* KeyParameters;
}

struct _HMAPPER
{
}

struct SCHANNEL_CRED
{
    uint dwVersion;
    uint cCreds;
    CERT_CONTEXT** paCred;
    void* hRootStore;
    uint cMappers;
    _HMAPPER** aphMappers;
    uint cSupportedAlgs;
    uint* palgSupportedAlgs;
    uint grbitEnabledProtocols;
    uint dwMinimumCipherStrength;
    uint dwMaximumCipherStrength;
    uint dwSessionLifespan;
    uint dwFlags;
    uint dwCredFormat;
}

struct SEND_GENERIC_TLS_EXTENSION
{
    ushort ExtensionType;
    ushort HandshakeType;
    uint Flags;
    ushort BufferSize;
    ubyte Buffer;
}

struct TLS_EXTENSION_SUBSCRIPTION
{
    ushort ExtensionType;
    ushort HandshakeType;
}

struct SUBSCRIBE_GENERIC_TLS_EXTENSION
{
    uint Flags;
    uint SubscriptionsCount;
    TLS_EXTENSION_SUBSCRIPTION Subscriptions;
}

struct SCHANNEL_CERT_HASH
{
    uint dwLength;
    uint dwFlags;
    uint hProv;
    ubyte ShaHash;
}

struct SCHANNEL_CERT_HASH_STORE
{
    uint dwLength;
    uint dwFlags;
    uint hProv;
    ubyte ShaHash;
    ushort pwszStoreName;
}

struct SCHANNEL_ALERT_TOKEN
{
    uint dwTokenType;
    uint dwAlertType;
    uint dwAlertNumber;
}

struct SCHANNEL_SESSION_TOKEN
{
    uint dwTokenType;
    uint dwFlags;
}

struct SCHANNEL_CLIENT_SIGNATURE
{
    uint cbLength;
    uint aiHash;
    uint cbHash;
    ubyte HashValue;
    ubyte CertThumbprint;
}

alias SSL_EMPTY_CACHE_FN_A = extern(Windows) BOOL function(const(char)* pszTargetName, uint dwFlags);
alias SSL_EMPTY_CACHE_FN_W = extern(Windows) BOOL function(const(wchar)* pszTargetName, uint dwFlags);
struct SSL_CREDENTIAL_CERTIFICATE
{
    uint cbPrivateKey;
    ubyte* pPrivateKey;
    uint cbCertificate;
    ubyte* pCertificate;
    const(char)* pszPassword;
}

struct SCH_CRED
{
    uint dwVersion;
    uint cCreds;
    void** paSecret;
    void** paPublic;
    uint cMappers;
    _HMAPPER** aphMappers;
}

struct SCH_CRED_SECRET_CAPI
{
    uint dwType;
    uint hProv;
}

struct SCH_CRED_SECRET_PRIVKEY
{
    uint dwType;
    ubyte* pPrivateKey;
    uint cbPrivateKey;
    const(char)* pszPassword;
}

struct SCH_CRED_PUBLIC_CERTCHAIN
{
    uint dwType;
    uint cbCertChain;
    ubyte* pCertChain;
}

struct PctPublicKey
{
    uint Type;
    uint cbKey;
    ubyte pKey;
}

struct X509Certificate
{
    uint Version;
    uint SerialNumber;
    uint SignatureAlgorithm;
    FILETIME ValidFrom;
    FILETIME ValidUntil;
    const(char)* pszIssuer;
    const(char)* pszSubject;
    PctPublicKey* pPublicKey;
}

alias SSL_CRACK_CERTIFICATE_FN = extern(Windows) BOOL function(ubyte* pbCertificate, uint cbCertificate, BOOL VerifySignature, X509Certificate** ppCertificate);
alias SSL_FREE_CERTIFICATE_FN = extern(Windows) void function(X509Certificate* pCertificate);
alias SslGetServerIdentityFn = extern(Windows) int function(char* ClientHello, uint ClientHelloSize, ubyte** ServerIdentity, uint* ServerIdentitySize, uint Flags);
struct SCH_EXTENSION_DATA
{
    ushort ExtensionType;
    const(ubyte)* pExtData;
    uint cbExtData;
}

enum SchGetExtensionsOptions
{
    SCH_EXTENSIONS_OPTIONS_NONE = 0,
    SCH_NO_RECORD_HEADER = 1,
}

alias SslGetExtensionsFn = extern(Windows) int function(char* clientHello, uint clientHelloByteSize, char* genericExtensions, ubyte genericExtensionsCount, uint* bytesToRead, SchGetExtensionsOptions flags);
struct OLD_LARGE_INTEGER
{
    uint LowPart;
    int HighPart;
}

enum SE_OBJECT_TYPE
{
    SE_UNKNOWN_OBJECT_TYPE = 0,
    SE_FILE_OBJECT = 1,
    SE_SERVICE = 2,
    SE_PRINTER = 3,
    SE_REGISTRY_KEY = 4,
    SE_LMSHARE = 5,
    SE_KERNEL_OBJECT = 6,
    SE_WINDOW_OBJECT = 7,
    SE_DS_OBJECT = 8,
    SE_DS_OBJECT_ALL = 9,
    SE_PROVIDER_DEFINED_OBJECT = 10,
    SE_WMIGUID_OBJECT = 11,
    SE_REGISTRY_WOW64_32KEY = 12,
    SE_REGISTRY_WOW64_64KEY = 13,
}

enum TRUSTEE_TYPE
{
    TRUSTEE_IS_UNKNOWN = 0,
    TRUSTEE_IS_USER = 1,
    TRUSTEE_IS_GROUP = 2,
    TRUSTEE_IS_DOMAIN = 3,
    TRUSTEE_IS_ALIAS = 4,
    TRUSTEE_IS_WELL_KNOWN_GROUP = 5,
    TRUSTEE_IS_DELETED = 6,
    TRUSTEE_IS_INVALID = 7,
    TRUSTEE_IS_COMPUTER = 8,
}

enum TRUSTEE_FORM
{
    TRUSTEE_IS_SID = 0,
    TRUSTEE_IS_NAME = 1,
    TRUSTEE_BAD_FORM = 2,
    TRUSTEE_IS_OBJECTS_AND_SID = 3,
    TRUSTEE_IS_OBJECTS_AND_NAME = 4,
}

enum MULTIPLE_TRUSTEE_OPERATION
{
    NO_MULTIPLE_TRUSTEE = 0,
    TRUSTEE_IS_IMPERSONATE = 1,
}

struct OBJECTS_AND_SID
{
    uint ObjectsPresent;
    Guid ObjectTypeGuid;
    Guid InheritedObjectTypeGuid;
    SID* pSid;
}

struct OBJECTS_AND_NAME_A
{
    uint ObjectsPresent;
    SE_OBJECT_TYPE ObjectType;
    const(char)* ObjectTypeName;
    const(char)* InheritedObjectTypeName;
    const(char)* ptstrName;
}

struct OBJECTS_AND_NAME_W
{
    uint ObjectsPresent;
    SE_OBJECT_TYPE ObjectType;
    const(wchar)* ObjectTypeName;
    const(wchar)* InheritedObjectTypeName;
    const(wchar)* ptstrName;
}

struct TRUSTEE_A
{
    TRUSTEE_A* pMultipleTrustee;
    MULTIPLE_TRUSTEE_OPERATION MultipleTrusteeOperation;
    TRUSTEE_FORM TrusteeForm;
    TRUSTEE_TYPE TrusteeType;
    const(char)* ptstrName;
}

struct TRUSTEE_W
{
    TRUSTEE_W* pMultipleTrustee;
    MULTIPLE_TRUSTEE_OPERATION MultipleTrusteeOperation;
    TRUSTEE_FORM TrusteeForm;
    TRUSTEE_TYPE TrusteeType;
    const(wchar)* ptstrName;
}

enum ACCESS_MODE
{
    NOT_USED_ACCESS = 0,
    GRANT_ACCESS = 1,
    SET_ACCESS = 2,
    DENY_ACCESS = 3,
    REVOKE_ACCESS = 4,
    SET_AUDIT_SUCCESS = 5,
    SET_AUDIT_FAILURE = 6,
}

struct EXPLICIT_ACCESS_A
{
    uint grfAccessPermissions;
    ACCESS_MODE grfAccessMode;
    uint grfInheritance;
    TRUSTEE_A Trustee;
}

struct EXPLICIT_ACCESS_W
{
    uint grfAccessPermissions;
    ACCESS_MODE grfAccessMode;
    uint grfInheritance;
    TRUSTEE_W Trustee;
}

struct TRUSTEE_ACCESSA
{
    const(char)* lpProperty;
    uint Access;
    uint fAccessFlags;
    uint fReturnedAccess;
}

struct TRUSTEE_ACCESSW
{
    const(wchar)* lpProperty;
    uint Access;
    uint fAccessFlags;
    uint fReturnedAccess;
}

struct ACTRL_OVERLAPPED
{
    _Anonymous_e__Union Anonymous;
    uint Reserved2;
    HANDLE hEvent;
}

struct ACTRL_ACCESS_INFOA
{
    uint fAccessPermission;
    const(char)* lpAccessPermissionName;
}

struct ACTRL_ACCESS_INFOW
{
    uint fAccessPermission;
    const(wchar)* lpAccessPermissionName;
}

struct ACTRL_CONTROL_INFOA
{
    const(char)* lpControlId;
    const(char)* lpControlName;
}

struct ACTRL_CONTROL_INFOW
{
    const(wchar)* lpControlId;
    const(wchar)* lpControlName;
}

enum PROG_INVOKE_SETTING
{
    ProgressInvokeNever = 1,
    ProgressInvokeEveryObject = 2,
    ProgressInvokeOnError = 3,
    ProgressCancelOperation = 4,
    ProgressRetryOperation = 5,
    ProgressInvokePrePostError = 6,
}

struct _FN_OBJECT_MGR_FUNCTIONS
{
    uint Placeholder;
}

struct INHERITED_FROMA
{
    int GenerationGap;
    const(char)* AncestorName;
}

struct INHERITED_FROMW
{
    int GenerationGap;
    const(wchar)* AncestorName;
}

struct WLX_SC_NOTIFICATION_INFO
{
    const(wchar)* pszCard;
    const(wchar)* pszReader;
    const(wchar)* pszContainer;
    const(wchar)* pszCryptoProvider;
}

struct WLX_PROFILE_V1_0
{
    uint dwType;
    const(wchar)* pszProfile;
}

struct WLX_PROFILE_V2_0
{
    uint dwType;
    const(wchar)* pszProfile;
    const(wchar)* pszPolicy;
    const(wchar)* pszNetworkDefaultUserProfile;
    const(wchar)* pszServerName;
    const(wchar)* pszEnvironment;
}

struct WLX_MPR_NOTIFY_INFO
{
    const(wchar)* pszUserName;
    const(wchar)* pszDomain;
    const(wchar)* pszPassword;
    const(wchar)* pszOldPassword;
}

struct WLX_TERMINAL_SERVICES_DATA
{
    ushort ProfilePath;
    ushort HomeDir;
    ushort HomeDirDrive;
}

struct WLX_CLIENT_CREDENTIALS_INFO_V1_0
{
    uint dwType;
    const(wchar)* pszUserName;
    const(wchar)* pszDomain;
    const(wchar)* pszPassword;
    BOOL fPromptForPassword;
}

struct WLX_CLIENT_CREDENTIALS_INFO_V2_0
{
    uint dwType;
    const(wchar)* pszUserName;
    const(wchar)* pszDomain;
    const(wchar)* pszPassword;
    BOOL fPromptForPassword;
    BOOL fDisconnectOnLogonFailure;
}

struct WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0
{
    uint dwType;
    HANDLE UserToken;
    LUID LogonId;
    QUOTA_LIMITS Quotas;
    const(wchar)* UserName;
    const(wchar)* Domain;
    LARGE_INTEGER LogonTime;
    BOOL SmartCardLogon;
    uint ProfileLength;
    uint MessageType;
    ushort LogonCount;
    ushort BadPasswordCount;
    LARGE_INTEGER ProfileLogonTime;
    LARGE_INTEGER LogoffTime;
    LARGE_INTEGER KickOffTime;
    LARGE_INTEGER PasswordLastSet;
    LARGE_INTEGER PasswordCanChange;
    LARGE_INTEGER PasswordMustChange;
    const(wchar)* LogonScript;
    const(wchar)* HomeDirectory;
    const(wchar)* FullName;
    const(wchar)* ProfilePath;
    const(wchar)* HomeDirectoryDrive;
    const(wchar)* LogonServer;
    uint UserFlags;
    uint PrivateDataLen;
    ubyte* PrivateData;
}

struct WLX_DESKTOP
{
    uint Size;
    uint Flags;
    HDESK hDesktop;
    const(wchar)* pszDesktopName;
}

alias PWLX_USE_CTRL_ALT_DEL = extern(Windows) void function(HANDLE hWlx);
alias PWLX_SET_CONTEXT_POINTER = extern(Windows) void function(HANDLE hWlx, void* pWlxContext);
alias PWLX_SAS_NOTIFY = extern(Windows) void function(HANDLE hWlx, uint dwSasType);
alias PWLX_SET_TIMEOUT = extern(Windows) BOOL function(HANDLE hWlx, uint Timeout);
alias PWLX_ASSIGN_SHELL_PROTECTION = extern(Windows) int function(HANDLE hWlx, HANDLE hToken, HANDLE hProcess, HANDLE hThread);
alias PWLX_MESSAGE_BOX = extern(Windows) int function(HANDLE hWlx, HWND hwndOwner, const(wchar)* lpszText, const(wchar)* lpszTitle, uint fuStyle);
alias PWLX_DIALOG_BOX = extern(Windows) int function(HANDLE hWlx, HANDLE hInst, const(wchar)* lpszTemplate, HWND hwndOwner, DLGPROC dlgprc);
alias PWLX_DIALOG_BOX_INDIRECT = extern(Windows) int function(HANDLE hWlx, HANDLE hInst, DLGTEMPLATE* hDialogTemplate, HWND hwndOwner, DLGPROC dlgprc);
alias PWLX_DIALOG_BOX_PARAM = extern(Windows) int function(HANDLE hWlx, HANDLE hInst, const(wchar)* lpszTemplate, HWND hwndOwner, DLGPROC dlgprc, LPARAM dwInitParam);
alias PWLX_DIALOG_BOX_INDIRECT_PARAM = extern(Windows) int function(HANDLE hWlx, HANDLE hInst, DLGTEMPLATE* hDialogTemplate, HWND hwndOwner, DLGPROC dlgprc, LPARAM dwInitParam);
alias PWLX_SWITCH_DESKTOP_TO_USER = extern(Windows) int function(HANDLE hWlx);
alias PWLX_SWITCH_DESKTOP_TO_WINLOGON = extern(Windows) int function(HANDLE hWlx);
alias PWLX_CHANGE_PASSWORD_NOTIFY = extern(Windows) int function(HANDLE hWlx, WLX_MPR_NOTIFY_INFO* pMprInfo, uint dwChangeInfo);
alias PWLX_GET_SOURCE_DESKTOP = extern(Windows) BOOL function(HANDLE hWlx, WLX_DESKTOP** ppDesktop);
alias PWLX_SET_RETURN_DESKTOP = extern(Windows) BOOL function(HANDLE hWlx, WLX_DESKTOP* pDesktop);
alias PWLX_CREATE_USER_DESKTOP = extern(Windows) BOOL function(HANDLE hWlx, HANDLE hToken, uint Flags, const(wchar)* pszDesktopName, WLX_DESKTOP** ppDesktop);
alias PWLX_CHANGE_PASSWORD_NOTIFY_EX = extern(Windows) int function(HANDLE hWlx, WLX_MPR_NOTIFY_INFO* pMprInfo, uint dwChangeInfo, const(wchar)* ProviderName, void* Reserved);
alias PWLX_CLOSE_USER_DESKTOP = extern(Windows) BOOL function(HANDLE hWlx, WLX_DESKTOP* pDesktop, HANDLE hToken);
alias PWLX_SET_OPTION = extern(Windows) BOOL function(HANDLE hWlx, uint Option, uint Value, uint* OldValue);
alias PWLX_GET_OPTION = extern(Windows) BOOL function(HANDLE hWlx, uint Option, uint* Value);
alias PWLX_WIN31_MIGRATE = extern(Windows) void function(HANDLE hWlx);
alias PWLX_QUERY_CLIENT_CREDENTIALS = extern(Windows) BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V1_0* pCred);
alias PWLX_QUERY_IC_CREDENTIALS = extern(Windows) BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V1_0* pCred);
alias PWLX_QUERY_TS_LOGON_CREDENTIALS = extern(Windows) BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V2_0* pCred);
alias PWLX_DISCONNECT = extern(Windows) BOOL function();
alias PWLX_QUERY_TERMINAL_SERVICES_DATA = extern(Windows) uint function(HANDLE hWlx, WLX_TERMINAL_SERVICES_DATA* pTSData, ushort* UserName, ushort* Domain);
alias PWLX_QUERY_CONSOLESWITCH_CREDENTIALS = extern(Windows) uint function(WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0* pCred);
struct WLX_DISPATCH_VERSION_1_0
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
}

struct WLX_DISPATCH_VERSION_1_1
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
}

struct WLX_DISPATCH_VERSION_1_2
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
}

struct WLX_DISPATCH_VERSION_1_3
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
    PWLX_SET_OPTION WlxSetOption;
    PWLX_GET_OPTION WlxGetOption;
    PWLX_WIN31_MIGRATE WlxWin31Migrate;
    PWLX_QUERY_CLIENT_CREDENTIALS WlxQueryClientCredentials;
    PWLX_QUERY_IC_CREDENTIALS WlxQueryInetConnectorCredentials;
    PWLX_DISCONNECT WlxDisconnect;
    PWLX_QUERY_TERMINAL_SERVICES_DATA WlxQueryTerminalServicesData;
}

struct WLX_DISPATCH_VERSION_1_4
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
    PWLX_SET_OPTION WlxSetOption;
    PWLX_GET_OPTION WlxGetOption;
    PWLX_WIN31_MIGRATE WlxWin31Migrate;
    PWLX_QUERY_CLIENT_CREDENTIALS WlxQueryClientCredentials;
    PWLX_QUERY_IC_CREDENTIALS WlxQueryInetConnectorCredentials;
    PWLX_DISCONNECT WlxDisconnect;
    PWLX_QUERY_TERMINAL_SERVICES_DATA WlxQueryTerminalServicesData;
    PWLX_QUERY_CONSOLESWITCH_CREDENTIALS WlxQueryConsoleSwitchCredentials;
    PWLX_QUERY_TS_LOGON_CREDENTIALS WlxQueryTsLogonCredentials;
}

alias PFNMSGECALLBACK = extern(Windows) uint function(BOOL bVerbose, const(wchar)* lpMessage);
struct WLX_NOTIFICATION_INFO
{
    uint Size;
    uint Flags;
    const(wchar)* UserName;
    const(wchar)* Domain;
    const(wchar)* WindowStation;
    HANDLE hToken;
    HDESK hDesktop;
    PFNMSGECALLBACK pStatusCallback;
}

const GUID CLSID_TpmVirtualSmartCardManager = {0x16A18E86, 0x7F6E, 0x4C20, [0xAD, 0x89, 0x4F, 0xFC, 0x0D, 0xB7, 0xA9, 0x6A]};
@GUID(0x16A18E86, 0x7F6E, 0x4C20, [0xAD, 0x89, 0x4F, 0xFC, 0x0D, 0xB7, 0xA9, 0x6A]);
struct TpmVirtualSmartCardManager;

const GUID CLSID_RemoteTpmVirtualSmartCardManager = {0x152EA2A8, 0x70DC, 0x4C59, [0x8B, 0x2A, 0x32, 0xAA, 0x3C, 0xA0, 0xDC, 0xAC]};
@GUID(0x152EA2A8, 0x70DC, 0x4C59, [0x8B, 0x2A, 0x32, 0xAA, 0x3C, 0xA0, 0xDC, 0xAC]);
struct RemoteTpmVirtualSmartCardManager;

enum TPMVSC_ATTESTATION_TYPE
{
    TPMVSC_ATTESTATION_NONE = 0,
    TPMVSC_ATTESTATION_AIK_ONLY = 1,
    TPMVSC_ATTESTATION_AIK_AND_CERTIFICATE = 2,
}

enum TPMVSCMGR_STATUS
{
    TPMVSCMGR_STATUS_VTPMSMARTCARD_INITIALIZING = 0,
    TPMVSCMGR_STATUS_VTPMSMARTCARD_CREATING = 1,
    TPMVSCMGR_STATUS_VTPMSMARTCARD_DESTROYING = 2,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_INITIALIZING = 3,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_CREATING = 4,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_DESTROYING = 5,
    TPMVSCMGR_STATUS_VREADER_INITIALIZING = 6,
    TPMVSCMGR_STATUS_VREADER_CREATING = 7,
    TPMVSCMGR_STATUS_VREADER_DESTROYING = 8,
    TPMVSCMGR_STATUS_GENERATE_WAITING = 9,
    TPMVSCMGR_STATUS_GENERATE_AUTHENTICATING = 10,
    TPMVSCMGR_STATUS_GENERATE_RUNNING = 11,
    TPMVSCMGR_STATUS_CARD_CREATED = 12,
    TPMVSCMGR_STATUS_CARD_DESTROYED = 13,
}

enum TPMVSCMGR_ERROR
{
    TPMVSCMGR_ERROR_IMPERSONATION = 0,
    TPMVSCMGR_ERROR_PIN_COMPLEXITY = 1,
    TPMVSCMGR_ERROR_READER_COUNT_LIMIT = 2,
    TPMVSCMGR_ERROR_TERMINAL_SERVICES_SESSION = 3,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_INITIALIZE = 4,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_CREATE = 5,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_DESTROY = 6,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_INITIALIZE = 7,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_CREATE = 8,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_DESTROY = 9,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_WRITE_PROPERTY = 10,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_READ_PROPERTY = 11,
    TPMVSCMGR_ERROR_VREADER_INITIALIZE = 12,
    TPMVSCMGR_ERROR_VREADER_CREATE = 13,
    TPMVSCMGR_ERROR_VREADER_DESTROY = 14,
    TPMVSCMGR_ERROR_GENERATE_LOCATE_READER = 15,
    TPMVSCMGR_ERROR_GENERATE_FILESYSTEM = 16,
    TPMVSCMGR_ERROR_CARD_CREATE = 17,
    TPMVSCMGR_ERROR_CARD_DESTROY = 18,
}

const GUID IID_ITpmVirtualSmartCardManagerStatusCallback = {0x1A1BB35F, 0xABB8, 0x451C, [0xA1, 0xAE, 0x33, 0xD9, 0x8F, 0x1B, 0xEF, 0x4A]};
@GUID(0x1A1BB35F, 0xABB8, 0x451C, [0xA1, 0xAE, 0x33, 0xD9, 0x8F, 0x1B, 0xEF, 0x4A]);
interface ITpmVirtualSmartCardManagerStatusCallback : IUnknown
{
    HRESULT ReportProgress(TPMVSCMGR_STATUS Status);
    HRESULT ReportError(TPMVSCMGR_ERROR Error);
}

const GUID IID_ITpmVirtualSmartCardManager = {0x112B1DFF, 0xD9DC, 0x41F7, [0x86, 0x9F, 0xD6, 0x7F, 0xEE, 0x7C, 0xB5, 0x91]};
@GUID(0x112B1DFF, 0xD9DC, 0x41F7, [0x86, 0x9F, 0xD6, 0x7F, 0xEE, 0x7C, 0xB5, 0x91]);
interface ITpmVirtualSmartCardManager : IUnknown
{
    HRESULT CreateVirtualSmartCard(const(wchar)* pszFriendlyName, ubyte bAdminAlgId, char* pbAdminKey, uint cbAdminKey, char* pbAdminKcv, uint cbAdminKcv, char* pbPuk, uint cbPuk, char* pbPin, uint cbPin, BOOL fGenerate, ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, ushort** ppszInstanceId, int* pfNeedReboot);
    HRESULT DestroyVirtualSmartCard(const(wchar)* pszInstanceId, ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, int* pfNeedReboot);
}

const GUID IID_ITpmVirtualSmartCardManager2 = {0xFDF8A2B9, 0x02DE, 0x47F4, [0xBC, 0x26, 0xAA, 0x85, 0xAB, 0x5E, 0x52, 0x67]};
@GUID(0xFDF8A2B9, 0x02DE, 0x47F4, [0xBC, 0x26, 0xAA, 0x85, 0xAB, 0x5E, 0x52, 0x67]);
interface ITpmVirtualSmartCardManager2 : ITpmVirtualSmartCardManager
{
    HRESULT CreateVirtualSmartCardWithPinPolicy(const(wchar)* pszFriendlyName, ubyte bAdminAlgId, char* pbAdminKey, uint cbAdminKey, char* pbAdminKcv, uint cbAdminKcv, char* pbPuk, uint cbPuk, char* pbPin, uint cbPin, char* pbPinPolicy, uint cbPinPolicy, BOOL fGenerate, ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, ushort** ppszInstanceId, int* pfNeedReboot);
}

const GUID IID_ITpmVirtualSmartCardManager3 = {0x3C745A97, 0xF375, 0x4150, [0xBE, 0x17, 0x59, 0x50, 0xF6, 0x94, 0xC6, 0x99]};
@GUID(0x3C745A97, 0xF375, 0x4150, [0xBE, 0x17, 0x59, 0x50, 0xF6, 0x94, 0xC6, 0x99]);
interface ITpmVirtualSmartCardManager3 : ITpmVirtualSmartCardManager2
{
    HRESULT CreateVirtualSmartCardWithAttestation(const(wchar)* pszFriendlyName, ubyte bAdminAlgId, char* pbAdminKey, uint cbAdminKey, char* pbAdminKcv, uint cbAdminKcv, char* pbPuk, uint cbPuk, char* pbPin, uint cbPin, char* pbPinPolicy, uint cbPinPolicy, TPMVSC_ATTESTATION_TYPE attestationType, BOOL fGenerate, ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, ushort** ppszInstanceId);
}

enum KeyCredentialManagerOperationErrorStates
{
    KeyCredentialManagerOperationErrorStateNone = 0,
    KeyCredentialManagerOperationErrorStateDeviceJoinFailure = 1,
    KeyCredentialManagerOperationErrorStateTokenFailure = 2,
    KeyCredentialManagerOperationErrorStateCertificateFailure = 4,
    KeyCredentialManagerOperationErrorStateRemoteSessionFailure = 8,
    KeyCredentialManagerOperationErrorStatePolicyFailure = 16,
    KeyCredentialManagerOperationErrorStateHardwareFailure = 32,
    KeyCredentialManagerOperationErrorStatePinExistsFailure = 64,
}

enum KeyCredentialManagerOperationType
{
    KeyCredentialManagerProvisioning = 0,
    KeyCredentialManagerPinChange = 1,
    KeyCredentialManagerPinReset = 2,
}

struct KeyCredentialManagerInfo
{
    Guid containerId;
}

enum IDENTITY_TYPE
{
    IDENTITIES_ALL = 0,
    IDENTITIES_ME_ONLY = 1,
}

alias PF_NPAddConnection = extern(Windows) uint function(NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName);
alias PF_NPAddConnection3 = extern(Windows) uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName, uint dwFlags);
alias PF_NPAddConnection4 = extern(Windows) uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* lpAuthBuffer, uint cbAuthBuffer, uint dwFlags, char* lpUseOptions, uint cbUseOptions);
alias PF_NPCancelConnection = extern(Windows) uint function(const(wchar)* lpName, BOOL fForce);
alias PF_NPGetConnection = extern(Windows) uint function(const(wchar)* lpLocalName, const(wchar)* lpRemoteName, uint* lpnBufferLen);
alias PF_NPGetConnection3 = extern(Windows) uint function(const(wchar)* lpLocalName, uint dwLevel, char* lpBuffer, uint* lpBufferSize);
alias PF_NPGetUniversalName = extern(Windows) uint function(const(wchar)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpnBufferSize);
alias PF_NPGetConnectionPerformance = extern(Windows) uint function(const(wchar)* lpRemoteName, NETCONNECTINFOSTRUCT* lpNetConnectInfo);
alias PF_NPOpenEnum = extern(Windows) uint function(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, int* lphEnum);
alias PF_NPEnumResource = extern(Windows) uint function(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);
alias PF_NPCloseEnum = extern(Windows) uint function(HANDLE hEnum);
alias PF_NPGetCaps = extern(Windows) uint function(uint ndex);
alias PF_NPGetUser = extern(Windows) uint function(const(wchar)* lpName, const(wchar)* lpUserName, uint* lpnBufferLen);
alias PF_NPGetPersistentUseOptionsForConnection = extern(Windows) uint function(const(wchar)* lpRemotePath, char* lpReadUseOptions, uint cbReadUseOptions, char* lpWriteUseOptions, uint* lpSizeWriteUseOptions);
alias PF_NPDeviceMode = extern(Windows) uint function(HWND hParent);
alias PF_NPSearchDialog = extern(Windows) uint function(HWND hwndParent, NETRESOURCEW* lpNetResource, char* lpBuffer, uint cbBuffer, uint* lpnFlags);
alias PF_NPGetResourceParent = extern(Windows) uint function(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize);
alias PF_NPGetResourceInformation = extern(Windows) uint function(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize, ushort** lplpSystem);
alias PF_NPFormatNetworkName = extern(Windows) uint function(const(wchar)* lpRemoteName, const(wchar)* lpFormattedName, uint* lpnLength, uint dwFlags, uint dwAveCharPerLine);
alias PF_NPGetPropertyText = extern(Windows) uint function(uint iButton, uint nPropSel, const(wchar)* lpName, const(wchar)* lpButtonName, uint nButtonNameLen, uint nType);
alias PF_NPPropertyDialog = extern(Windows) uint function(HWND hwndParent, uint iButtonDlg, uint nPropSel, const(wchar)* lpFileName, uint nType);
alias PF_NPGetDirectoryType = extern(Windows) uint function(const(wchar)* lpName, int* lpType, BOOL bFlushCache);
alias PF_NPDirectoryNotify = extern(Windows) uint function(HWND hwnd, const(wchar)* lpDir, uint dwOper);
alias PF_NPLogonNotify = extern(Windows) uint function(LUID* lpLogonId, const(wchar)* lpAuthentInfoType, void* lpAuthentInfo, const(wchar)* lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, const(wchar)* lpStationName, void* StationHandle, ushort** lpLogonScript);
alias PF_NPPasswordChangeNotify = extern(Windows) uint function(const(wchar)* lpAuthentInfoType, void* lpAuthentInfo, const(wchar)* lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, const(wchar)* lpStationName, void* StationHandle, uint dwChangeInfo);
struct NOTIFYINFO
{
    uint dwNotifyStatus;
    uint dwOperationStatus;
    void* lpContext;
}

struct NOTIFYADD
{
    HWND hwndOwner;
    NETRESOURCEA NetResource;
    uint dwAddFlags;
}

struct NOTIFYCANCEL
{
    const(wchar)* lpName;
    const(wchar)* lpProvider;
    uint dwFlags;
    BOOL fForce;
}

alias PF_AddConnectNotify = extern(Windows) uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYADD* lpAddInfo);
alias PF_CancelConnectNotify = extern(Windows) uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYCANCEL* lpCancelInfo);
alias PF_NPFMXGetPermCaps = extern(Windows) uint function(const(wchar)* lpDriveName);
alias PF_NPFMXEditPerm = extern(Windows) uint function(const(wchar)* lpDriveName, HWND hwndFMX, uint nDialogType);
alias PF_NPFMXGetPermHelp = extern(Windows) uint function(const(wchar)* lpDriveName, uint nDialogType, BOOL fDirectory, char* lpFileNameBuffer, uint* lpBufferSize, uint* lpnHelpContext);
struct LOGON_HOURS
{
    ushort UnitsPerWeek;
    ubyte* LogonHours;
}

struct SR_SECURITY_DESCRIPTOR
{
    uint Length;
    ubyte* SecurityDescriptor;
}

struct USER_ALL_INFORMATION
{
    LARGE_INTEGER LastLogon;
    LARGE_INTEGER LastLogoff;
    LARGE_INTEGER PasswordLastSet;
    LARGE_INTEGER AccountExpires;
    LARGE_INTEGER PasswordCanChange;
    LARGE_INTEGER PasswordMustChange;
    UNICODE_STRING UserName;
    UNICODE_STRING FullName;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING HomeDirectoryDrive;
    UNICODE_STRING ScriptPath;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING AdminComment;
    UNICODE_STRING WorkStations;
    UNICODE_STRING UserComment;
    UNICODE_STRING Parameters;
    UNICODE_STRING LmPassword;
    UNICODE_STRING NtPassword;
    UNICODE_STRING PrivateData;
    SR_SECURITY_DESCRIPTOR SecurityDescriptor;
    uint UserId;
    uint PrimaryGroupId;
    uint UserAccountControl;
    uint WhichFields;
    LOGON_HOURS LogonHours;
    ushort BadPasswordCount;
    ushort LogonCount;
    ushort CountryCode;
    ushort CodePage;
    ubyte LmPasswordPresent;
    ubyte NtPasswordPresent;
    ubyte PasswordExpired;
    ubyte PrivateDataSensitive;
}

struct CLEAR_BLOCK
{
    byte data;
}

struct USER_SESSION_KEY
{
    CYPHER_BLOCK data;
}

enum NETLOGON_LOGON_INFO_CLASS
{
    NetlogonInteractiveInformation = 1,
    NetlogonNetworkInformation = 2,
    NetlogonServiceInformation = 3,
    NetlogonGenericInformation = 4,
    NetlogonInteractiveTransitiveInformation = 5,
    NetlogonNetworkTransitiveInformation = 6,
    NetlogonServiceTransitiveInformation = 7,
}

struct NETLOGON_LOGON_IDENTITY_INFO
{
    UNICODE_STRING LogonDomainName;
    uint ParameterControl;
    OLD_LARGE_INTEGER LogonId;
    UNICODE_STRING UserName;
    UNICODE_STRING Workstation;
}

struct NETLOGON_INTERACTIVE_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    LM_OWF_PASSWORD LmOwfPassword;
    LM_OWF_PASSWORD NtOwfPassword;
}

struct NETLOGON_SERVICE_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    LM_OWF_PASSWORD LmOwfPassword;
    LM_OWF_PASSWORD NtOwfPassword;
}

struct NETLOGON_NETWORK_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    CLEAR_BLOCK LmChallenge;
    STRING NtChallengeResponse;
    STRING LmChallengeResponse;
}

struct NETLOGON_GENERIC_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    UNICODE_STRING PackageName;
    uint DataLength;
    ubyte* LogonData;
}

struct MSV1_0_VALIDATION_INFO
{
    LARGE_INTEGER LogoffTime;
    LARGE_INTEGER KickoffTime;
    UNICODE_STRING LogonServer;
    UNICODE_STRING LogonDomainName;
    USER_SESSION_KEY SessionKey;
    ubyte Authoritative;
    uint UserFlags;
    uint WhichFields;
    uint UserId;
}

enum tag_IdentityUpdateEvent
{
    IDENTITY_ASSOCIATED = 1,
    IDENTITY_DISASSOCIATED = 2,
    IDENTITY_CREATED = 4,
    IDENTITY_IMPORTED = 8,
    IDENTITY_DELETED = 16,
    IDENTITY_PROPCHANGED = 32,
    IDENTITY_CONNECTED = 64,
    IDENTITY_DISCONNECTED = 128,
}

const GUID IID_IIdentityAdvise = {0x4E982FED, 0xD14B, 0x440C, [0xB8, 0xD6, 0xBB, 0x38, 0x64, 0x53, 0xD3, 0x86]};
@GUID(0x4E982FED, 0xD14B, 0x440C, [0xB8, 0xD6, 0xBB, 0x38, 0x64, 0x53, 0xD3, 0x86]);
interface IIdentityAdvise : IUnknown
{
    HRESULT IdentityUpdated(uint dwIdentityUpdateEvents, const(wchar)* lpszUniqueID);
}

const GUID IID_AsyncIIdentityAdvise = {0x3AB4C8DA, 0xD038, 0x4830, [0x8D, 0xD9, 0x32, 0x53, 0xC5, 0x5A, 0x12, 0x7F]};
@GUID(0x3AB4C8DA, 0xD038, 0x4830, [0x8D, 0xD9, 0x32, 0x53, 0xC5, 0x5A, 0x12, 0x7F]);
interface AsyncIIdentityAdvise : IUnknown
{
    HRESULT Begin_IdentityUpdated(uint dwIdentityUpdateEvents, const(wchar)* lpszUniqueID);
    HRESULT Finish_IdentityUpdated();
}

const GUID IID_IIdentityProvider = {0x0D1B9E0C, 0xE8BA, 0x4F55, [0xA8, 0x1B, 0xBC, 0xE9, 0x34, 0xB9, 0x48, 0xF5]};
@GUID(0x0D1B9E0C, 0xE8BA, 0x4F55, [0xA8, 0x1B, 0xBC, 0xE9, 0x34, 0xB9, 0x48, 0xF5]);
interface IIdentityProvider : IUnknown
{
    HRESULT GetIdentityEnum(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, const(PROPVARIANT)* pFilterPropVarValue, IEnumUnknown* ppIdentityEnum);
    HRESULT Create(const(wchar)* lpszUserName, IPropertyStore* ppPropertyStore, const(PROPVARIANT)* pKeywordsToAdd);
    HRESULT Import(IPropertyStore pPropertyStore);
    HRESULT Delete(const(wchar)* lpszUniqueID, const(PROPVARIANT)* pKeywordsToDelete);
    HRESULT FindByUniqueID(const(wchar)* lpszUniqueID, IPropertyStore* ppPropertyStore);
    HRESULT GetProviderPropertyStore(IPropertyStore* ppPropertyStore);
    HRESULT Advise(IIdentityAdvise pIdentityAdvise, uint dwIdentityUpdateEvents, uint* pdwCookie);
    HRESULT UnAdvise(const(uint) dwCookie);
}

const GUID IID_AsyncIIdentityProvider = {0xC6FC9901, 0xC433, 0x4646, [0x8F, 0x48, 0x4E, 0x46, 0x87, 0xAA, 0xE2, 0xA0]};
@GUID(0xC6FC9901, 0xC433, 0x4646, [0x8F, 0x48, 0x4E, 0x46, 0x87, 0xAA, 0xE2, 0xA0]);
interface AsyncIIdentityProvider : IUnknown
{
    HRESULT Begin_GetIdentityEnum(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, const(PROPVARIANT)* pFilterPropVarValue);
    HRESULT Finish_GetIdentityEnum(IEnumUnknown* ppIdentityEnum);
    HRESULT Begin_Create(const(wchar)* lpszUserName, const(PROPVARIANT)* pKeywordsToAdd);
    HRESULT Finish_Create(IPropertyStore* ppPropertyStore);
    HRESULT Begin_Import(IPropertyStore pPropertyStore);
    HRESULT Finish_Import();
    HRESULT Begin_Delete(const(wchar)* lpszUniqueID, const(PROPVARIANT)* pKeywordsToDelete);
    HRESULT Finish_Delete();
    HRESULT Begin_FindByUniqueID(const(wchar)* lpszUniqueID);
    HRESULT Finish_FindByUniqueID(IPropertyStore* ppPropertyStore);
    HRESULT Begin_GetProviderPropertyStore();
    HRESULT Finish_GetProviderPropertyStore(IPropertyStore* ppPropertyStore);
    HRESULT Begin_Advise(IIdentityAdvise pIdentityAdvise, uint dwIdentityUpdateEvents);
    HRESULT Finish_Advise(uint* pdwCookie);
    HRESULT Begin_UnAdvise(const(uint) dwCookie);
    HRESULT Finish_UnAdvise();
}

const GUID IID_IAssociatedIdentityProvider = {0x2AF066B3, 0x4CBB, 0x4CBA, [0xA7, 0x98, 0x20, 0x4B, 0x6A, 0xF6, 0x8C, 0xC0]};
@GUID(0x2AF066B3, 0x4CBB, 0x4CBA, [0xA7, 0x98, 0x20, 0x4B, 0x6A, 0xF6, 0x8C, 0xC0]);
interface IAssociatedIdentityProvider : IUnknown
{
    HRESULT AssociateIdentity(HWND hwndParent, IPropertyStore* ppPropertyStore);
    HRESULT DisassociateIdentity(HWND hwndParent, const(wchar)* lpszUniqueID);
    HRESULT ChangeCredential(HWND hwndParent, const(wchar)* lpszUniqueID);
}

const GUID IID_AsyncIAssociatedIdentityProvider = {0x2834D6ED, 0x297E, 0x4E72, [0x8A, 0x51, 0x96, 0x1E, 0x86, 0xF0, 0x51, 0x52]};
@GUID(0x2834D6ED, 0x297E, 0x4E72, [0x8A, 0x51, 0x96, 0x1E, 0x86, 0xF0, 0x51, 0x52]);
interface AsyncIAssociatedIdentityProvider : IUnknown
{
    HRESULT Begin_AssociateIdentity(HWND hwndParent);
    HRESULT Finish_AssociateIdentity(IPropertyStore* ppPropertyStore);
    HRESULT Begin_DisassociateIdentity(HWND hwndParent, const(wchar)* lpszUniqueID);
    HRESULT Finish_DisassociateIdentity();
    HRESULT Begin_ChangeCredential(HWND hwndParent, const(wchar)* lpszUniqueID);
    HRESULT Finish_ChangeCredential();
}

enum __MIDL___MIDL_itf_identityprovider_0000_0003_0001
{
    IDENTITY_URL_CREATE_ACCOUNT_WIZARD = 0,
    IDENTITY_URL_SIGN_IN_WIZARD = 1,
    IDENTITY_URL_CHANGE_PASSWORD_WIZARD = 2,
    IDENTITY_URL_IFEXISTS_WIZARD = 3,
    IDENTITY_URL_ACCOUNT_SETTINGS = 4,
    IDENTITY_URL_RESTORE_WIZARD = 5,
    IDENTITY_URL_CONNECT_WIZARD = 6,
}

enum __MIDL___MIDL_itf_identityprovider_0000_0003_0002
{
    NOT_CONNECTED = 0,
    CONNECTING = 1,
    CONNECT_COMPLETED = 2,
}

const GUID IID_IConnectedIdentityProvider = {0xB7417B54, 0xE08C, 0x429B, [0x96, 0xC8, 0x67, 0x8D, 0x13, 0x69, 0xEC, 0xB1]};
@GUID(0xB7417B54, 0xE08C, 0x429B, [0x96, 0xC8, 0x67, 0x8D, 0x13, 0x69, 0xEC, 0xB1]);
interface IConnectedIdentityProvider : IUnknown
{
    HRESULT ConnectIdentity(char* AuthBuffer, uint AuthBufferSize);
    HRESULT DisconnectIdentity();
    HRESULT IsConnected(int* Connected);
    HRESULT GetUrl(__MIDL___MIDL_itf_identityprovider_0000_0003_0001 Identifier, IBindCtx Context, VARIANT* PostData, ushort** Url);
    HRESULT GetAccountState(__MIDL___MIDL_itf_identityprovider_0000_0003_0002* pState);
}

const GUID IID_AsyncIConnectedIdentityProvider = {0x9CE55141, 0xBCE9, 0x4E15, [0x82, 0x4D, 0x43, 0xD7, 0x9F, 0x51, 0x2F, 0x93]};
@GUID(0x9CE55141, 0xBCE9, 0x4E15, [0x82, 0x4D, 0x43, 0xD7, 0x9F, 0x51, 0x2F, 0x93]);
interface AsyncIConnectedIdentityProvider : IUnknown
{
    HRESULT Begin_ConnectIdentity(char* AuthBuffer, uint AuthBufferSize);
    HRESULT Finish_ConnectIdentity();
    HRESULT Begin_DisconnectIdentity();
    HRESULT Finish_DisconnectIdentity();
    HRESULT Begin_IsConnected();
    HRESULT Finish_IsConnected(int* Connected);
    HRESULT Begin_GetUrl(__MIDL___MIDL_itf_identityprovider_0000_0003_0001 Identifier, IBindCtx Context);
    HRESULT Finish_GetUrl(VARIANT* PostData, ushort** Url);
    HRESULT Begin_GetAccountState();
    HRESULT Finish_GetAccountState(__MIDL___MIDL_itf_identityprovider_0000_0003_0002* pState);
}

const GUID IID_IIdentityAuthentication = {0x5E7EF254, 0x979F, 0x43B5, [0xB7, 0x4E, 0x06, 0xE4, 0xEB, 0x7D, 0xF0, 0xF9]};
@GUID(0x5E7EF254, 0x979F, 0x43B5, [0xB7, 0x4E, 0x06, 0xE4, 0xEB, 0x7D, 0xF0, 0xF9]);
interface IIdentityAuthentication : IUnknown
{
    HRESULT SetIdentityCredential(char* CredBuffer, uint CredBufferLength);
    HRESULT ValidateIdentityCredential(char* CredBuffer, uint CredBufferLength, IPropertyStore* ppIdentityProperties);
}

const GUID IID_AsyncIIdentityAuthentication = {0xF9A2F918, 0xFECA, 0x4E9C, [0x96, 0x33, 0x61, 0xCB, 0xF1, 0x3E, 0xD3, 0x4D]};
@GUID(0xF9A2F918, 0xFECA, 0x4E9C, [0x96, 0x33, 0x61, 0xCB, 0xF1, 0x3E, 0xD3, 0x4D]);
interface AsyncIIdentityAuthentication : IUnknown
{
    HRESULT Begin_SetIdentityCredential(char* CredBuffer, uint CredBufferLength);
    HRESULT Finish_SetIdentityCredential();
    HRESULT Begin_ValidateIdentityCredential(char* CredBuffer, uint CredBufferLength, IPropertyStore* ppIdentityProperties);
    HRESULT Finish_ValidateIdentityCredential(IPropertyStore* ppIdentityProperties);
}

const GUID CLSID_CoClassIdentityStore = {0x30D49246, 0xD217, 0x465F, [0xB0, 0x0B, 0xAC, 0x9D, 0xDD, 0x65, 0x2E, 0xB7]};
@GUID(0x30D49246, 0xD217, 0x465F, [0xB0, 0x0B, 0xAC, 0x9D, 0xDD, 0x65, 0x2E, 0xB7]);
struct CoClassIdentityStore;

const GUID CLSID_CIdentityProfileHandler = {0xECF5BF46, 0xE3B6, 0x449A, [0xB5, 0x6B, 0x43, 0xF5, 0x8F, 0x86, 0x78, 0x14]};
@GUID(0xECF5BF46, 0xE3B6, 0x449A, [0xB5, 0x6B, 0x43, 0xF5, 0x8F, 0x86, 0x78, 0x14]);
struct CIdentityProfileHandler;

const GUID IID_IIdentityStore = {0xDF586FA5, 0x6F35, 0x44F1, [0xB2, 0x09, 0xB3, 0x8E, 0x16, 0x97, 0x72, 0xEB]};
@GUID(0xDF586FA5, 0x6F35, 0x44F1, [0xB2, 0x09, 0xB3, 0x8E, 0x16, 0x97, 0x72, 0xEB]);
interface IIdentityStore : IUnknown
{
    HRESULT GetCount(uint* pdwProviders);
    HRESULT GetAt(const(uint) dwProvider, Guid* pProvGuid, IUnknown* ppIdentityProvider);
    HRESULT AddToCache(const(wchar)* lpszUniqueID, const(Guid)* ProviderGUID);
    HRESULT ConvertToSid(const(wchar)* lpszUniqueID, const(Guid)* ProviderGUID, ushort cbSid, char* pSid, ushort* pcbRequiredSid);
    HRESULT EnumerateIdentities(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, const(PROPVARIANT)* pFilterPropVarValue, IEnumUnknown* ppIdentityEnum);
    HRESULT Reset();
}

const GUID IID_AsyncIIdentityStore = {0xEEFA1616, 0x48DE, 0x4872, [0xAA, 0x64, 0x6E, 0x62, 0x06, 0x53, 0x5A, 0x51]};
@GUID(0xEEFA1616, 0x48DE, 0x4872, [0xAA, 0x64, 0x6E, 0x62, 0x06, 0x53, 0x5A, 0x51]);
interface AsyncIIdentityStore : IUnknown
{
    HRESULT Begin_GetCount();
    HRESULT Finish_GetCount(uint* pdwProviders);
    HRESULT Begin_GetAt(const(uint) dwProvider, Guid* pProvGuid);
    HRESULT Finish_GetAt(Guid* pProvGuid, IUnknown* ppIdentityProvider);
    HRESULT Begin_AddToCache(const(wchar)* lpszUniqueID, const(Guid)* ProviderGUID);
    HRESULT Finish_AddToCache();
    HRESULT Begin_ConvertToSid(const(wchar)* lpszUniqueID, const(Guid)* ProviderGUID, ushort cbSid, ubyte* pSid);
    HRESULT Finish_ConvertToSid(ubyte* pSid, ushort* pcbRequiredSid);
    HRESULT Begin_EnumerateIdentities(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, const(PROPVARIANT)* pFilterPropVarValue);
    HRESULT Finish_EnumerateIdentities(IEnumUnknown* ppIdentityEnum);
    HRESULT Begin_Reset();
    HRESULT Finish_Reset();
}

const GUID IID_IIdentityStoreEx = {0xF9F9EB98, 0x8F7F, 0x4E38, [0x95, 0x77, 0x69, 0x80, 0x11, 0x4C, 0xE3, 0x2B]};
@GUID(0xF9F9EB98, 0x8F7F, 0x4E38, [0x95, 0x77, 0x69, 0x80, 0x11, 0x4C, 0xE3, 0x2B]);
interface IIdentityStoreEx : IUnknown
{
    HRESULT CreateConnectedIdentity(const(wchar)* LocalName, const(wchar)* ConnectedName, const(Guid)* ProviderGUID);
    HRESULT DeleteConnectedIdentity(const(wchar)* ConnectedName, const(Guid)* ProviderGUID);
}

const GUID IID_AsyncIIdentityStoreEx = {0xFCA3AF9A, 0x8A07, 0x4EAE, [0x86, 0x32, 0xEC, 0x3D, 0xE6, 0x58, 0xA3, 0x6A]};
@GUID(0xFCA3AF9A, 0x8A07, 0x4EAE, [0x86, 0x32, 0xEC, 0x3D, 0xE6, 0x58, 0xA3, 0x6A]);
interface AsyncIIdentityStoreEx : IUnknown
{
    HRESULT Begin_CreateConnectedIdentity(const(wchar)* LocalName, const(wchar)* ConnectedName, const(Guid)* ProviderGUID);
    HRESULT Finish_CreateConnectedIdentity();
    HRESULT Begin_DeleteConnectedIdentity(const(wchar)* ConnectedName, const(Guid)* ProviderGUID);
    HRESULT Finish_DeleteConnectedIdentity();
}

enum AUDIT_PARAM_TYPE
{
    APT_None = 1,
    APT_String = 2,
    APT_Ulong = 3,
    APT_Pointer = 4,
    APT_Sid = 5,
    APT_LogonId = 6,
    APT_ObjectTypeList = 7,
    APT_Luid = 8,
    APT_Guid = 9,
    APT_Time = 10,
    APT_Int64 = 11,
    APT_IpAddress = 12,
    APT_LogonIdWithSid = 13,
}

struct AUDIT_OBJECT_TYPE
{
    Guid ObjectType;
    ushort Flags;
    ushort Level;
    uint AccessMask;
}

struct AUDIT_OBJECT_TYPES
{
    ushort Count;
    ushort Flags;
    AUDIT_OBJECT_TYPE* pObjectTypes;
}

struct AUDIT_IP_ADDRESS
{
    ubyte pIpAddress;
}

struct AUDIT_PARAM
{
    AUDIT_PARAM_TYPE Type;
    uint Length;
    uint Flags;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct AUDIT_PARAMS
{
    uint Length;
    uint Flags;
    ushort Count;
    AUDIT_PARAM* Parameters;
}

struct AUTHZ_AUDIT_EVENT_TYPE_LEGACY
{
    ushort CategoryId;
    ushort AuditId;
    ushort ParameterCount;
}

struct AUTHZ_AUDIT_EVENT_TYPE_UNION
{
    AUTHZ_AUDIT_EVENT_TYPE_LEGACY Legacy;
}

struct AUTHZ_AUDIT_EVENT_TYPE_OLD
{
    uint Version;
    uint dwFlags;
    int RefCount;
    uint hAudit;
    LUID LinkId;
    AUTHZ_AUDIT_EVENT_TYPE_UNION u;
}

struct AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__
{
    int unused;
}

struct AUTHZ_CLIENT_CONTEXT_HANDLE__
{
    int unused;
}

struct AUTHZ_RESOURCE_MANAGER_HANDLE__
{
    int unused;
}

struct AUTHZ_AUDIT_EVENT_HANDLE__
{
    int unused;
}

struct AUTHZ_AUDIT_EVENT_TYPE_HANDLE__
{
    int unused;
}

struct AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__
{
    int unused;
}

struct AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__
{
    int unused;
}

struct AUTHZ_ACCESS_REQUEST
{
    uint DesiredAccess;
    void* PrincipalSelfSid;
    OBJECT_TYPE_LIST* ObjectTypeList;
    uint ObjectTypeListLength;
    void* OptionalArguments;
}

struct AUTHZ_ACCESS_REPLY
{
    uint ResultListLength;
    uint* GrantedAccessMask;
    uint* SaclEvaluationResults;
    uint* Error;
}

alias PFN_AUTHZ_DYNAMIC_ACCESS_CHECK = extern(Windows) BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, ACE_HEADER* pAce, void* pArgs, int* pbAceApplicable);
alias PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS = extern(Windows) BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, void* Args, SID_AND_ATTRIBUTES** pSidAttrArray, uint* pSidCount, SID_AND_ATTRIBUTES** pRestrictedSidAttrArray, uint* pRestrictedSidCount);
alias PFN_AUTHZ_FREE_DYNAMIC_GROUPS = extern(Windows) void function(SID_AND_ATTRIBUTES* pSidAttrArray);
alias PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY = extern(Windows) BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, void* capid, void* pArgs, int* pCentralAccessPolicyApplicable, void** ppCentralAccessPolicy);
alias PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY = extern(Windows) void function(void* pCentralAccessPolicy);
struct AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
{
    ulong Version;
    const(wchar)* pName;
}

struct AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
{
    void* pValue;
    uint ValueLength;
}

enum AUTHZ_SECURITY_ATTRIBUTE_OPERATION
{
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_NONE = 0,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE_ALL = 1,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_ADD = 2,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_DELETE = 3,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE = 4,
}

enum AUTHZ_SID_OPERATION
{
    AUTHZ_SID_OPERATION_NONE = 0,
    AUTHZ_SID_OPERATION_REPLACE_ALL = 1,
    AUTHZ_SID_OPERATION_ADD = 2,
    AUTHZ_SID_OPERATION_DELETE = 3,
    AUTHZ_SID_OPERATION_REPLACE = 4,
}

struct AUTHZ_SECURITY_ATTRIBUTE_V1
{
    const(wchar)* pName;
    ushort ValueType;
    ushort Reserved;
    uint Flags;
    uint ValueCount;
    _Values_e__Union Values;
}

struct AUTHZ_SECURITY_ATTRIBUTES_INFORMATION
{
    ushort Version;
    ushort Reserved;
    uint AttributeCount;
    _Attribute_e__Union Attribute;
}

struct AUTHZ_RPC_INIT_INFO_CLIENT
{
    ushort version;
    const(wchar)* ObjectUuid;
    const(wchar)* ProtSeq;
    const(wchar)* NetworkAddr;
    const(wchar)* Endpoint;
    const(wchar)* Options;
    const(wchar)* ServerSpn;
}

struct AUTHZ_INIT_INFO
{
    ushort version;
    const(wchar)* szResourceManagerName;
    PFN_AUTHZ_DYNAMIC_ACCESS_CHECK pfnDynamicAccessCheck;
    PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS pfnComputeDynamicGroups;
    PFN_AUTHZ_FREE_DYNAMIC_GROUPS pfnFreeDynamicGroups;
    PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY pfnGetCentralAccessPolicy;
    PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY pfnFreeCentralAccessPolicy;
}

enum AUTHZ_CONTEXT_INFORMATION_CLASS
{
    AuthzContextInfoUserSid = 1,
    AuthzContextInfoGroupsSids = 2,
    AuthzContextInfoRestrictedSids = 3,
    AuthzContextInfoPrivileges = 4,
    AuthzContextInfoExpirationTime = 5,
    AuthzContextInfoServerContext = 6,
    AuthzContextInfoIdentifier = 7,
    AuthzContextInfoSource = 8,
    AuthzContextInfoAll = 9,
    AuthzContextInfoAuthenticationId = 10,
    AuthzContextInfoSecurityAttributes = 11,
    AuthzContextInfoDeviceSids = 12,
    AuthzContextInfoUserClaims = 13,
    AuthzContextInfoDeviceClaims = 14,
    AuthzContextInfoAppContainerSid = 15,
    AuthzContextInfoCapabilitySids = 16,
}

enum AUTHZ_AUDIT_EVENT_INFORMATION_CLASS
{
    AuthzAuditEventInfoFlags = 1,
    AuthzAuditEventInfoOperationType = 2,
    AuthzAuditEventInfoObjectType = 3,
    AuthzAuditEventInfoObjectName = 4,
    AuthzAuditEventInfoAdditionalInfo = 5,
}

struct AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET
{
    const(wchar)* szObjectTypeName;
    uint dwOffset;
}

struct AUTHZ_SOURCE_SCHEMA_REGISTRATION
{
    uint dwFlags;
    const(wchar)* szEventSourceName;
    const(wchar)* szEventMessageFile;
    const(wchar)* szEventSourceXmlSchemaFile;
    const(wchar)* szEventAccessStringsFile;
    const(wchar)* szExecutableImagePath;
    _Anonymous_e__Union Anonymous;
    uint dwObjectTypeNameCount;
    AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET ObjectTypeNames;
}

const GUID CLSID_AzAuthorizationStore = {0xB2BCFF59, 0xA757, 0x4B0B, [0xA1, 0xBC, 0xEA, 0x69, 0x98, 0x1D, 0xA6, 0x9E]};
@GUID(0xB2BCFF59, 0xA757, 0x4B0B, [0xA1, 0xBC, 0xEA, 0x69, 0x98, 0x1D, 0xA6, 0x9E]);
struct AzAuthorizationStore;

const GUID CLSID_AzBizRuleContext = {0x5C2DC96F, 0x8D51, 0x434B, [0xB3, 0x3C, 0x37, 0x9B, 0xCC, 0xAE, 0x77, 0xC3]};
@GUID(0x5C2DC96F, 0x8D51, 0x434B, [0xB3, 0x3C, 0x37, 0x9B, 0xCC, 0xAE, 0x77, 0xC3]);
struct AzBizRuleContext;

const GUID CLSID_AzPrincipalLocator = {0x483AFB5D, 0x70DF, 0x4E16, [0xAB, 0xDC, 0xA1, 0xDE, 0x4D, 0x01, 0x5A, 0x3E]};
@GUID(0x483AFB5D, 0x70DF, 0x4E16, [0xAB, 0xDC, 0xA1, 0xDE, 0x4D, 0x01, 0x5A, 0x3E]);
struct AzPrincipalLocator;

const GUID IID_IAzAuthorizationStore = {0xEDBD9CA9, 0x9B82, 0x4F6A, [0x9E, 0x8B, 0x98, 0x30, 0x1E, 0x45, 0x0F, 0x14]};
@GUID(0xEDBD9CA9, 0x9B82, 0x4F6A, [0x9E, 0x8B, 0x98, 0x30, 0x1E, 0x45, 0x0F, 0x14]);
interface IAzAuthorizationStore : IDispatch
{
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_DomainTimeout(int* plProp);
    HRESULT put_DomainTimeout(int lProp);
    HRESULT get_ScriptEngineTimeout(int* plProp);
    HRESULT put_ScriptEngineTimeout(int lProp);
    HRESULT get_MaxScriptEngines(int* plProp);
    HRESULT put_MaxScriptEngines(int lProp);
    HRESULT get_GenerateAudits(int* pbProp);
    HRESULT put_GenerateAudits(BOOL bProp);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT Initialize(int lFlags, BSTR bstrPolicyURL, VARIANT varReserved);
    HRESULT UpdateCache(VARIANT varReserved);
    HRESULT Delete(VARIANT varReserved);
    HRESULT get_Applications(IAzApplications* ppAppCollection);
    HRESULT OpenApplication(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication* ppApplication);
    HRESULT CreateApplication(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication* ppApplication);
    HRESULT DeleteApplication(BSTR bstrApplicationName, VARIANT varReserved);
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT get_DelegatedPolicyUsers(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT get_TargetMachine(BSTR* pbstrTargetMachine);
    HRESULT get_ApplyStoreSacl(int* pbApplyStoreSacl);
    HRESULT put_ApplyStoreSacl(BOOL bApplyStoreSacl);
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_DelegatedPolicyUsersName(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT CloseApplication(BSTR bstrApplicationName, int lFlag);
}

const GUID IID_IAzAuthorizationStore2 = {0xB11E5584, 0xD577, 0x4273, [0xB6, 0xC5, 0x09, 0x73, 0xE0, 0xF8, 0xE8, 0x0D]};
@GUID(0xB11E5584, 0xD577, 0x4273, [0xB6, 0xC5, 0x09, 0x73, 0xE0, 0xF8, 0xE8, 0x0D]);
interface IAzAuthorizationStore2 : IAzAuthorizationStore
{
    HRESULT OpenApplication2(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication2* ppApplication);
    HRESULT CreateApplication2(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication2* ppApplication);
}

const GUID IID_IAzAuthorizationStore3 = {0xABC08425, 0x0C86, 0x4FA0, [0x9B, 0xE3, 0x71, 0x89, 0x95, 0x6C, 0x92, 0x6E]};
@GUID(0xABC08425, 0x0C86, 0x4FA0, [0x9B, 0xE3, 0x71, 0x89, 0x95, 0x6C, 0x92, 0x6E]);
interface IAzAuthorizationStore3 : IAzAuthorizationStore2
{
    HRESULT IsUpdateNeeded(short* pbIsUpdateNeeded);
    HRESULT BizruleGroupSupported(short* pbSupported);
    HRESULT UpgradeStoresFunctionalLevel(int lFunctionalLevel);
    HRESULT IsFunctionalLevelUpgradeSupported(int lFunctionalLevel, short* pbSupported);
    HRESULT GetSchemaVersion(int* plMajorVersion, int* plMinorVersion);
}

const GUID IID_IAzApplication = {0x987BC7C7, 0xB813, 0x4D27, [0xBE, 0xDE, 0x6B, 0xA5, 0xAE, 0x86, 0x7E, 0x95]};
@GUID(0x987BC7C7, 0xB813, 0x4D27, [0xBE, 0xDE, 0x6B, 0xA5, 0xAE, 0x86, 0x7E, 0x95]);
interface IAzApplication : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_AuthzInterfaceClsid(BSTR* pbstrProp);
    HRESULT put_AuthzInterfaceClsid(BSTR bstrProp);
    HRESULT get_Version(BSTR* pbstrProp);
    HRESULT put_Version(BSTR bstrProp);
    HRESULT get_GenerateAudits(int* pbProp);
    HRESULT put_GenerateAudits(BOOL bProp);
    HRESULT get_ApplyStoreSacl(int* pbProp);
    HRESULT put_ApplyStoreSacl(BOOL bProp);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_Scopes(IAzScopes* ppScopeCollection);
    HRESULT OpenScope(BSTR bstrScopeName, VARIANT varReserved, IAzScope* ppScope);
    HRESULT CreateScope(BSTR bstrScopeName, VARIANT varReserved, IAzScope* ppScope);
    HRESULT DeleteScope(BSTR bstrScopeName, VARIANT varReserved);
    HRESULT get_Operations(IAzOperations* ppOperationCollection);
    HRESULT OpenOperation(BSTR bstrOperationName, VARIANT varReserved, IAzOperation* ppOperation);
    HRESULT CreateOperation(BSTR bstrOperationName, VARIANT varReserved, IAzOperation* ppOperation);
    HRESULT DeleteOperation(BSTR bstrOperationName, VARIANT varReserved);
    HRESULT get_Tasks(IAzTasks* ppTaskCollection);
    HRESULT OpenTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT CreateTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT DeleteTask(BSTR bstrTaskName, VARIANT varReserved);
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    HRESULT get_Roles(IAzRoles* ppRoleCollection);
    HRESULT OpenRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT CreateRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT DeleteRole(BSTR bstrRoleName, VARIANT varReserved);
    HRESULT InitializeClientContextFromToken(ulong ullTokenHandle, VARIANT varReserved, IAzClientContext* ppClientContext);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT InitializeClientContextFromName(BSTR ClientName, BSTR DomainName, VARIANT varReserved, IAzClientContext* ppClientContext);
    HRESULT get_DelegatedPolicyUsers(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT InitializeClientContextFromStringSid(BSTR SidString, int lOptions, VARIANT varReserved, IAzClientContext* ppClientContext);
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_DelegatedPolicyUsersName(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
}

const GUID IID_IAzApplication2 = {0x086A68AF, 0xA249, 0x437C, [0xB1, 0x8D, 0xD4, 0xD8, 0x6D, 0x6A, 0x96, 0x60]};
@GUID(0x086A68AF, 0xA249, 0x437C, [0xB1, 0x8D, 0xD4, 0xD8, 0x6D, 0x6A, 0x96, 0x60]);
interface IAzApplication2 : IAzApplication
{
    HRESULT InitializeClientContextFromToken2(uint ulTokenHandleLowPart, uint ulTokenHandleHighPart, VARIANT varReserved, IAzClientContext2* ppClientContext);
    HRESULT InitializeClientContext2(BSTR IdentifyingString, VARIANT varReserved, IAzClientContext2* ppClientContext);
}

const GUID IID_IAzApplications = {0x929B11A9, 0x95C5, 0x4A84, [0xA2, 0x9A, 0x20, 0xAD, 0x42, 0xC2, 0xF1, 0x6C]};
@GUID(0x929B11A9, 0x95C5, 0x4A84, [0xA2, 0x9A, 0x20, 0xAD, 0x42, 0xC2, 0xF1, 0x6C]);
interface IAzApplications : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzOperation = {0x5E56B24F, 0xEA01, 0x4D61, [0xBE, 0x44, 0xC4, 0x9B, 0x5E, 0x4E, 0xAF, 0x74]};
@GUID(0x5E56B24F, 0xEA01, 0x4D61, [0xBE, 0x44, 0xC4, 0x9B, 0x5E, 0x4E, 0xAF, 0x74]);
interface IAzOperation : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_OperationID(int* plProp);
    HRESULT put_OperationID(int lProp);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
}

const GUID IID_IAzOperations = {0x90EF9C07, 0x9706, 0x49D9, [0xAF, 0x80, 0x04, 0x38, 0xA5, 0xF3, 0xEC, 0x35]};
@GUID(0x90EF9C07, 0x9706, 0x49D9, [0xAF, 0x80, 0x04, 0x38, 0xA5, 0xF3, 0xEC, 0x35]);
interface IAzOperations : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzTask = {0xCB94E592, 0x2E0E, 0x4A6C, [0xA3, 0x36, 0xB8, 0x9A, 0x6D, 0xC1, 0xE3, 0x88]};
@GUID(0xCB94E592, 0x2E0E, 0x4A6C, [0xA3, 0x36, 0xB8, 0x9A, 0x6D, 0xC1, 0xE3, 0x88]);
interface IAzTask : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_BizRule(BSTR* pbstrProp);
    HRESULT put_BizRule(BSTR bstrProp);
    HRESULT get_BizRuleLanguage(BSTR* pbstrProp);
    HRESULT put_BizRuleLanguage(BSTR bstrProp);
    HRESULT get_BizRuleImportedPath(BSTR* pbstrProp);
    HRESULT put_BizRuleImportedPath(BSTR bstrProp);
    HRESULT get_IsRoleDefinition(int* pfProp);
    HRESULT put_IsRoleDefinition(BOOL fProp);
    HRESULT get_Operations(VARIANT* pvarProp);
    HRESULT get_Tasks(VARIANT* pvarProp);
    HRESULT AddOperation(BSTR bstrOp, VARIANT varReserved);
    HRESULT DeleteOperation(BSTR bstrOp, VARIANT varReserved);
    HRESULT AddTask(BSTR bstrTask, VARIANT varReserved);
    HRESULT DeleteTask(BSTR bstrTask, VARIANT varReserved);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
}

const GUID IID_IAzTasks = {0xB338CCAB, 0x4C85, 0x4388, [0x8C, 0x0A, 0xC5, 0x85, 0x92, 0xBA, 0xD3, 0x98]};
@GUID(0xB338CCAB, 0x4C85, 0x4388, [0x8C, 0x0A, 0xC5, 0x85, 0x92, 0xBA, 0xD3, 0x98]);
interface IAzTasks : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzScope = {0x00E52487, 0xE08D, 0x4514, [0xB6, 0x2E, 0x87, 0x7D, 0x56, 0x45, 0xF5, 0xAB]};
@GUID(0x00E52487, 0xE08D, 0x4514, [0xB6, 0x2E, 0x87, 0x7D, 0x56, 0x45, 0xF5, 0xAB]);
interface IAzScope : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    HRESULT get_Roles(IAzRoles* ppRoleCollection);
    HRESULT OpenRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT CreateRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT DeleteRole(BSTR bstrRoleName, VARIANT varReserved);
    HRESULT get_Tasks(IAzTasks* ppTaskCollection);
    HRESULT OpenTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT CreateTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT DeleteTask(BSTR bstrTaskName, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT get_CanBeDelegated(int* pfProp);
    HRESULT get_BizrulesWritable(int* pfProp);
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
}

const GUID IID_IAzScopes = {0x78E14853, 0x9F5E, 0x406D, [0x9B, 0x91, 0x6B, 0xDB, 0xA6, 0x97, 0x35, 0x10]};
@GUID(0x78E14853, 0x9F5E, 0x406D, [0x9B, 0x91, 0x6B, 0xDB, 0xA6, 0x97, 0x35, 0x10]);
interface IAzScopes : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzApplicationGroup = {0xF1B744CD, 0x58A6, 0x4E06, [0x9F, 0xBF, 0x36, 0xF6, 0xD7, 0x79, 0xE2, 0x1E]};
@GUID(0xF1B744CD, 0x58A6, 0x4E06, [0x9F, 0xBF, 0x36, 0xF6, 0xD7, 0x79, 0xE2, 0x1E]);
interface IAzApplicationGroup : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Type(int* plProp);
    HRESULT put_Type(int lProp);
    HRESULT get_LdapQuery(BSTR* pbstrProp);
    HRESULT put_LdapQuery(BSTR bstrProp);
    HRESULT get_AppMembers(VARIANT* pvarProp);
    HRESULT get_AppNonMembers(VARIANT* pvarProp);
    HRESULT get_Members(VARIANT* pvarProp);
    HRESULT get_NonMembers(VARIANT* pvarProp);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT AddAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddAppNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteAppNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT AddMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddNonMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteNonMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_MembersName(VARIANT* pvarProp);
    HRESULT get_NonMembersName(VARIANT* pvarProp);
}

const GUID IID_IAzApplicationGroups = {0x4CE66AD5, 0x9F3C, 0x469D, [0xA9, 0x11, 0xB9, 0x98, 0x87, 0xA7, 0xE6, 0x85]};
@GUID(0x4CE66AD5, 0x9F3C, 0x469D, [0xA9, 0x11, 0xB9, 0x98, 0x87, 0xA7, 0xE6, 0x85]);
interface IAzApplicationGroups : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzRole = {0x859E0D8D, 0x62D7, 0x41D8, [0xA0, 0x34, 0xC0, 0xCD, 0x5D, 0x43, 0xFD, 0xFA]};
@GUID(0x859E0D8D, 0x62D7, 0x41D8, [0xA0, 0x34, 0xC0, 0xCD, 0x5D, 0x43, 0xFD, 0xFA]);
interface IAzRole : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT AddAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddTask(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteTask(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddOperation(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteOperation(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_AppMembers(VARIANT* pvarProp);
    HRESULT get_Members(VARIANT* pvarProp);
    HRESULT get_Operations(VARIANT* pvarProp);
    HRESULT get_Tasks(VARIANT* pvarProp);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT AddMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_MembersName(VARIANT* pvarProp);
}

const GUID IID_IAzRoles = {0x95E0F119, 0x13B4, 0x4DAE, [0xB6, 0x5F, 0x2F, 0x7D, 0x60, 0xD8, 0x22, 0xE4]};
@GUID(0x95E0F119, 0x13B4, 0x4DAE, [0xB6, 0x5F, 0x2F, 0x7D, 0x60, 0xD8, 0x22, 0xE4]);
interface IAzRoles : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzClientContext = {0xEFF1F00B, 0x488A, 0x466D, [0xAF, 0xD9, 0xA4, 0x01, 0xC5, 0xF9, 0xEE, 0xF5]};
@GUID(0xEFF1F00B, 0x488A, 0x466D, [0xAF, 0xD9, 0xA4, 0x01, 0xC5, 0xF9, 0xEE, 0xF5]);
interface IAzClientContext : IDispatch
{
    HRESULT AccessCheck(BSTR bstrObjectName, VARIANT varScopeNames, VARIANT varOperations, VARIANT varParameterNames, VARIANT varParameterValues, VARIANT varInterfaceNames, VARIANT varInterfaceFlags, VARIANT varInterfaces, VARIANT* pvarResults);
    HRESULT GetBusinessRuleString(BSTR* pbstrBusinessRuleString);
    HRESULT get_UserDn(BSTR* pbstrProp);
    HRESULT get_UserSamCompat(BSTR* pbstrProp);
    HRESULT get_UserDisplay(BSTR* pbstrProp);
    HRESULT get_UserGuid(BSTR* pbstrProp);
    HRESULT get_UserCanonical(BSTR* pbstrProp);
    HRESULT get_UserUpn(BSTR* pbstrProp);
    HRESULT get_UserDnsSamCompat(BSTR* pbstrProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT GetRoles(BSTR bstrScopeName, VARIANT* pvarRoleNames);
    HRESULT get_RoleForAccessCheck(BSTR* pbstrProp);
    HRESULT put_RoleForAccessCheck(BSTR bstrProp);
}

const GUID IID_IAzClientContext2 = {0x2B0C92B8, 0x208A, 0x488A, [0x8F, 0x81, 0xE4, 0xED, 0xB2, 0x21, 0x11, 0xCD]};
@GUID(0x2B0C92B8, 0x208A, 0x488A, [0x8F, 0x81, 0xE4, 0xED, 0xB2, 0x21, 0x11, 0xCD]);
interface IAzClientContext2 : IAzClientContext
{
    HRESULT GetAssignedScopesPage(int lOptions, int PageSize, VARIANT* pvarCursor, VARIANT* pvarScopeNames);
    HRESULT AddRoles(VARIANT varRoles, BSTR bstrScopeName);
    HRESULT AddApplicationGroups(VARIANT varApplicationGroups);
    HRESULT AddStringSids(VARIANT varStringSids);
    HRESULT put_LDAPQueryDN(BSTR bstrLDAPQueryDN);
    HRESULT get_LDAPQueryDN(BSTR* pbstrLDAPQueryDN);
}

const GUID IID_IAzBizRuleContext = {0xE192F17D, 0xD59F, 0x455E, [0xA1, 0x52, 0x94, 0x03, 0x16, 0xCD, 0x77, 0xB2]};
@GUID(0xE192F17D, 0xD59F, 0x455E, [0xA1, 0x52, 0x94, 0x03, 0x16, 0xCD, 0x77, 0xB2]);
interface IAzBizRuleContext : IDispatch
{
    HRESULT put_BusinessRuleResult(BOOL bResult);
    HRESULT put_BusinessRuleString(BSTR bstrBusinessRuleString);
    HRESULT get_BusinessRuleString(BSTR* pbstrBusinessRuleString);
    HRESULT GetParameter(BSTR bstrParameterName, VARIANT* pvarParameterValue);
}

const GUID IID_IAzBizRuleParameters = {0xFC17685F, 0xE25D, 0x4DCD, [0xBA, 0xE1, 0x27, 0x6E, 0xC9, 0x53, 0x3C, 0xB5]};
@GUID(0xFC17685F, 0xE25D, 0x4DCD, [0xBA, 0xE1, 0x27, 0x6E, 0xC9, 0x53, 0x3C, 0xB5]);
interface IAzBizRuleParameters : IDispatch
{
    HRESULT AddParameter(BSTR bstrParameterName, VARIANT varParameterValue);
    HRESULT AddParameters(VARIANT varParameterNames, VARIANT varParameterValues);
    HRESULT GetParameterValue(BSTR bstrParameterName, VARIANT* pvarParameterValue);
    HRESULT Remove(BSTR varParameterName);
    HRESULT RemoveAll();
    HRESULT get_Count(uint* plCount);
}

const GUID IID_IAzBizRuleInterfaces = {0xE94128C7, 0xE9DA, 0x44CC, [0xB0, 0xBD, 0x53, 0x03, 0x6F, 0x3A, 0xAB, 0x3D]};
@GUID(0xE94128C7, 0xE9DA, 0x44CC, [0xB0, 0xBD, 0x53, 0x03, 0x6F, 0x3A, 0xAB, 0x3D]);
interface IAzBizRuleInterfaces : IDispatch
{
    HRESULT AddInterface(BSTR bstrInterfaceName, int lInterfaceFlag, VARIANT varInterface);
    HRESULT AddInterfaces(VARIANT varInterfaceNames, VARIANT varInterfaceFlags, VARIANT varInterfaces);
    HRESULT GetInterfaceValue(BSTR bstrInterfaceName, int* lInterfaceFlag, VARIANT* varInterface);
    HRESULT Remove(BSTR bstrInterfaceName);
    HRESULT RemoveAll();
    HRESULT get_Count(uint* plCount);
}

const GUID IID_IAzClientContext3 = {0x11894FDE, 0x1DEB, 0x4B4B, [0x89, 0x07, 0x6D, 0x1C, 0xDA, 0x1F, 0x5D, 0x4F]};
@GUID(0x11894FDE, 0x1DEB, 0x4B4B, [0x89, 0x07, 0x6D, 0x1C, 0xDA, 0x1F, 0x5D, 0x4F]);
interface IAzClientContext3 : IAzClientContext2
{
    HRESULT AccessCheck2(BSTR bstrObjectName, BSTR bstrScopeName, int lOperation, uint* plResult);
    HRESULT IsInRoleAssignment(BSTR bstrScopeName, BSTR bstrRoleName, short* pbIsInRole);
    HRESULT GetOperations(BSTR bstrScopeName, IAzOperations* ppOperationCollection);
    HRESULT GetTasks(BSTR bstrScopeName, IAzTasks* ppTaskCollection);
    HRESULT get_BizRuleParameters(IAzBizRuleParameters* ppBizRuleParam);
    HRESULT get_BizRuleInterfaces(IAzBizRuleInterfaces* ppBizRuleInterfaces);
    HRESULT GetGroups(BSTR bstrScopeName, uint ulOptions, VARIANT* pGroupArray);
    HRESULT get_Sids(VARIANT* pStringSidArray);
}

const GUID IID_IAzScope2 = {0xEE9FE8C9, 0xC9F3, 0x40E2, [0xAA, 0x12, 0xD1, 0xD8, 0x59, 0x97, 0x27, 0xFD]};
@GUID(0xEE9FE8C9, 0xC9F3, 0x40E2, [0xAA, 0x12, 0xD1, 0xD8, 0x59, 0x97, 0x27, 0xFD]);
interface IAzScope2 : IAzScope
{
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    HRESULT CreateRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT OpenRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinitionName);
    HRESULT get_RoleAssignments(IAzRoleAssignments* ppRoleAssignments);
    HRESULT CreateRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT OpenRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT DeleteRoleAssignment(BSTR bstrRoleAssignmentName);
}

const GUID IID_IAzApplication3 = {0x181C845E, 0x7196, 0x4A7D, [0xAC, 0x2E, 0x02, 0x0C, 0x0B, 0xB7, 0xA3, 0x03]};
@GUID(0x181C845E, 0x7196, 0x4A7D, [0xAC, 0x2E, 0x02, 0x0C, 0x0B, 0xB7, 0xA3, 0x03]);
interface IAzApplication3 : IAzApplication2
{
    HRESULT ScopeExists(BSTR bstrScopeName, short* pbExist);
    HRESULT OpenScope2(BSTR bstrScopeName, IAzScope2* ppScope2);
    HRESULT CreateScope2(BSTR bstrScopeName, IAzScope2* ppScope2);
    HRESULT DeleteScope2(BSTR bstrScopeName);
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    HRESULT CreateRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT OpenRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinitionName);
    HRESULT get_RoleAssignments(IAzRoleAssignments* ppRoleAssignments);
    HRESULT CreateRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT OpenRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT DeleteRoleAssignment(BSTR bstrRoleAssignmentName);
    HRESULT get_BizRulesEnabled(short* pbEnabled);
    HRESULT put_BizRulesEnabled(short bEnabled);
}

const GUID IID_IAzOperation2 = {0x1F5EA01F, 0x44A2, 0x4184, [0x9C, 0x48, 0xA7, 0x5B, 0x4D, 0xCC, 0x8C, 0xCC]};
@GUID(0x1F5EA01F, 0x44A2, 0x4184, [0x9C, 0x48, 0xA7, 0x5B, 0x4D, 0xCC, 0x8C, 0xCC]);
interface IAzOperation2 : IAzOperation
{
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

const GUID IID_IAzRoleDefinitions = {0x881F25A5, 0xD755, 0x4550, [0x95, 0x7A, 0xD5, 0x03, 0xA3, 0xB3, 0x40, 0x01]};
@GUID(0x881F25A5, 0xD755, 0x4550, [0x95, 0x7A, 0xD5, 0x03, 0xA3, 0xB3, 0x40, 0x01]);
interface IAzRoleDefinitions : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzRoleDefinition = {0xD97FCEA1, 0x2599, 0x44F1, [0x9F, 0xC3, 0x58, 0xE9, 0xFB, 0xE0, 0x94, 0x66]};
@GUID(0xD97FCEA1, 0x2599, 0x44F1, [0x9F, 0xC3, 0x58, 0xE9, 0xFB, 0xE0, 0x94, 0x66]);
interface IAzRoleDefinition : IAzTask
{
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
    HRESULT AddRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
}

const GUID IID_IAzRoleAssignment = {0x55647D31, 0x0D5A, 0x4FA3, [0xB4, 0xAC, 0x2B, 0x5F, 0x9A, 0xD5, 0xAB, 0x76]};
@GUID(0x55647D31, 0x0D5A, 0x4FA3, [0xB4, 0xAC, 0x2B, 0x5F, 0x9A, 0xD5, 0xAB, 0x76]);
interface IAzRoleAssignment : IAzRole
{
    HRESULT AddRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    HRESULT get_Scope(IAzScope* ppScope);
}

const GUID IID_IAzRoleAssignments = {0x9C80B900, 0xFCEB, 0x4D73, [0xA0, 0xF4, 0xC8, 0x3B, 0x0B, 0xBF, 0x24, 0x81]};
@GUID(0x9C80B900, 0xFCEB, 0x4D73, [0xA0, 0xF4, 0xC8, 0x3B, 0x0B, 0xBF, 0x24, 0x81]);
interface IAzRoleAssignments : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

const GUID IID_IAzPrincipalLocator = {0xE5C3507D, 0xAD6A, 0x4992, [0x9C, 0x7F, 0x74, 0xAB, 0x48, 0x0B, 0x44, 0xCC]};
@GUID(0xE5C3507D, 0xAD6A, 0x4992, [0x9C, 0x7F, 0x74, 0xAB, 0x48, 0x0B, 0x44, 0xCC]);
interface IAzPrincipalLocator : IDispatch
{
    HRESULT get_NameResolver(IAzNameResolver* ppNameResolver);
    HRESULT get_ObjectPicker(IAzObjectPicker* ppObjectPicker);
}

const GUID IID_IAzNameResolver = {0x504D0F15, 0x73E2, 0x43DF, [0xA8, 0x70, 0xA6, 0x4F, 0x40, 0x71, 0x4F, 0x53]};
@GUID(0x504D0F15, 0x73E2, 0x43DF, [0xA8, 0x70, 0xA6, 0x4F, 0x40, 0x71, 0x4F, 0x53]);
interface IAzNameResolver : IDispatch
{
    HRESULT NameFromSid(BSTR bstrSid, int* pSidType, BSTR* pbstrName);
    HRESULT NamesFromSids(VARIANT vSids, VARIANT* pvSidTypes, VARIANT* pvNames);
}

const GUID IID_IAzObjectPicker = {0x63130A48, 0x699A, 0x42D8, [0xBF, 0x01, 0xC6, 0x2A, 0xC3, 0xFB, 0x79, 0xF9]};
@GUID(0x63130A48, 0x699A, 0x42D8, [0xBF, 0x01, 0xC6, 0x2A, 0xC3, 0xFB, 0x79, 0xF9]);
interface IAzObjectPicker : IDispatch
{
    HRESULT GetPrincipals(HWND hParentWnd, BSTR bstrTitle, VARIANT* pvSidTypes, VARIANT* pvNames, VARIANT* pvSids);
    HRESULT get_Name(BSTR* pbstrName);
}

const GUID IID_IAzApplicationGroup2 = {0x3F0613FC, 0xB71A, 0x464E, [0xA1, 0x1D, 0x5B, 0x88, 0x1A, 0x56, 0xCE, 0xFA]};
@GUID(0x3F0613FC, 0xB71A, 0x464E, [0xA1, 0x1D, 0x5B, 0x88, 0x1A, 0x56, 0xCE, 0xFA]);
interface IAzApplicationGroup2 : IAzApplicationGroup
{
    HRESULT get_BizRule(BSTR* pbstrProp);
    HRESULT put_BizRule(BSTR bstrProp);
    HRESULT get_BizRuleLanguage(BSTR* pbstrProp);
    HRESULT put_BizRuleLanguage(BSTR bstrProp);
    HRESULT get_BizRuleImportedPath(BSTR* pbstrProp);
    HRESULT put_BizRuleImportedPath(BSTR bstrProp);
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

const GUID IID_IAzTask2 = {0x03A9A5EE, 0x48C8, 0x4832, [0x90, 0x25, 0xAA, 0xD5, 0x03, 0xC4, 0x65, 0x26]};
@GUID(0x03A9A5EE, 0x48C8, 0x4832, [0x90, 0x25, 0xAA, 0xD5, 0x03, 0xC4, 0x65, 0x26]);
interface IAzTask2 : IAzTask
{
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

enum AZ_PROP_CONSTANTS
{
    AZ_PROP_NAME = 1,
    AZ_PROP_DESCRIPTION = 2,
    AZ_PROP_WRITABLE = 3,
    AZ_PROP_APPLICATION_DATA = 4,
    AZ_PROP_CHILD_CREATE = 5,
    AZ_MAX_APPLICATION_NAME_LENGTH = 512,
    AZ_MAX_OPERATION_NAME_LENGTH = 64,
    AZ_MAX_TASK_NAME_LENGTH = 64,
    AZ_MAX_SCOPE_NAME_LENGTH = 65536,
    AZ_MAX_GROUP_NAME_LENGTH = 64,
    AZ_MAX_ROLE_NAME_LENGTH = 64,
    AZ_MAX_NAME_LENGTH = 65536,
    AZ_MAX_DESCRIPTION_LENGTH = 1024,
    AZ_MAX_APPLICATION_DATA_LENGTH = 4096,
    AZ_SUBMIT_FLAG_ABORT = 1,
    AZ_SUBMIT_FLAG_FLUSH = 2,
    AZ_MAX_POLICY_URL_LENGTH = 65536,
    AZ_AZSTORE_FLAG_CREATE = 1,
    AZ_AZSTORE_FLAG_MANAGE_STORE_ONLY = 2,
    AZ_AZSTORE_FLAG_BATCH_UPDATE = 4,
    AZ_AZSTORE_FLAG_AUDIT_IS_CRITICAL = 8,
    AZ_AZSTORE_FORCE_APPLICATION_CLOSE = 16,
    AZ_AZSTORE_NT6_FUNCTION_LEVEL = 32,
    AZ_AZSTORE_FLAG_MANAGE_ONLY_PASSIVE_SUBMIT = 32768,
    AZ_PROP_AZSTORE_DOMAIN_TIMEOUT = 100,
    AZ_AZSTORE_DEFAULT_DOMAIN_TIMEOUT = 15000,
    AZ_PROP_AZSTORE_SCRIPT_ENGINE_TIMEOUT = 101,
    AZ_AZSTORE_MIN_DOMAIN_TIMEOUT = 500,
    AZ_AZSTORE_MIN_SCRIPT_ENGINE_TIMEOUT = 5000,
    AZ_AZSTORE_DEFAULT_SCRIPT_ENGINE_TIMEOUT = 45000,
    AZ_PROP_AZSTORE_MAX_SCRIPT_ENGINES = 102,
    AZ_AZSTORE_DEFAULT_MAX_SCRIPT_ENGINES = 120,
    AZ_PROP_AZSTORE_MAJOR_VERSION = 103,
    AZ_PROP_AZSTORE_MINOR_VERSION = 104,
    AZ_PROP_AZSTORE_TARGET_MACHINE = 105,
    AZ_PROP_AZTORE_IS_ADAM_INSTANCE = 106,
    AZ_PROP_OPERATION_ID = 200,
    AZ_PROP_TASK_OPERATIONS = 300,
    AZ_PROP_TASK_BIZRULE = 301,
    AZ_PROP_TASK_BIZRULE_LANGUAGE = 302,
    AZ_PROP_TASK_TASKS = 303,
    AZ_PROP_TASK_BIZRULE_IMPORTED_PATH = 304,
    AZ_PROP_TASK_IS_ROLE_DEFINITION = 305,
    AZ_MAX_TASK_BIZRULE_LENGTH = 65536,
    AZ_MAX_TASK_BIZRULE_LANGUAGE_LENGTH = 64,
    AZ_MAX_TASK_BIZRULE_IMPORTED_PATH_LENGTH = 512,
    AZ_MAX_BIZRULE_STRING = 65536,
    AZ_PROP_GROUP_TYPE = 400,
    AZ_GROUPTYPE_LDAP_QUERY = 1,
    AZ_GROUPTYPE_BASIC = 2,
    AZ_GROUPTYPE_BIZRULE = 3,
    AZ_PROP_GROUP_APP_MEMBERS = 401,
    AZ_PROP_GROUP_APP_NON_MEMBERS = 402,
    AZ_PROP_GROUP_LDAP_QUERY = 403,
    AZ_MAX_GROUP_LDAP_QUERY_LENGTH = 4096,
    AZ_PROP_GROUP_MEMBERS = 404,
    AZ_PROP_GROUP_NON_MEMBERS = 405,
    AZ_PROP_GROUP_MEMBERS_NAME = 406,
    AZ_PROP_GROUP_NON_MEMBERS_NAME = 407,
    AZ_PROP_GROUP_BIZRULE = 408,
    AZ_PROP_GROUP_BIZRULE_LANGUAGE = 409,
    AZ_PROP_GROUP_BIZRULE_IMPORTED_PATH = 410,
    AZ_MAX_GROUP_BIZRULE_LENGTH = 65536,
    AZ_MAX_GROUP_BIZRULE_LANGUAGE_LENGTH = 64,
    AZ_MAX_GROUP_BIZRULE_IMPORTED_PATH_LENGTH = 512,
    AZ_PROP_ROLE_APP_MEMBERS = 500,
    AZ_PROP_ROLE_MEMBERS = 501,
    AZ_PROP_ROLE_OPERATIONS = 502,
    AZ_PROP_ROLE_TASKS = 504,
    AZ_PROP_ROLE_MEMBERS_NAME = 505,
    AZ_PROP_SCOPE_BIZRULES_WRITABLE = 600,
    AZ_PROP_SCOPE_CAN_BE_DELEGATED = 601,
    AZ_PROP_CLIENT_CONTEXT_USER_DN = 700,
    AZ_PROP_CLIENT_CONTEXT_USER_SAM_COMPAT = 701,
    AZ_PROP_CLIENT_CONTEXT_USER_DISPLAY = 702,
    AZ_PROP_CLIENT_CONTEXT_USER_GUID = 703,
    AZ_PROP_CLIENT_CONTEXT_USER_CANONICAL = 704,
    AZ_PROP_CLIENT_CONTEXT_USER_UPN = 705,
    AZ_PROP_CLIENT_CONTEXT_USER_DNS_SAM_COMPAT = 707,
    AZ_PROP_CLIENT_CONTEXT_ROLE_FOR_ACCESS_CHECK = 708,
    AZ_PROP_CLIENT_CONTEXT_LDAP_QUERY_DN = 709,
    AZ_PROP_APPLICATION_AUTHZ_INTERFACE_CLSID = 800,
    AZ_PROP_APPLICATION_VERSION = 801,
    AZ_MAX_APPLICATION_VERSION_LENGTH = 512,
    AZ_PROP_APPLICATION_NAME = 802,
    AZ_PROP_APPLICATION_BIZRULE_ENABLED = 803,
    AZ_PROP_APPLY_STORE_SACL = 900,
    AZ_PROP_GENERATE_AUDITS = 901,
    AZ_PROP_POLICY_ADMINS = 902,
    AZ_PROP_POLICY_READERS = 903,
    AZ_PROP_DELEGATED_POLICY_USERS = 904,
    AZ_PROP_POLICY_ADMINS_NAME = 905,
    AZ_PROP_POLICY_READERS_NAME = 906,
    AZ_PROP_DELEGATED_POLICY_USERS_NAME = 907,
    AZ_CLIENT_CONTEXT_SKIP_GROUP = 1,
    AZ_CLIENT_CONTEXT_SKIP_LDAP_QUERY = 1,
    AZ_CLIENT_CONTEXT_GET_GROUP_RECURSIVE = 2,
    AZ_CLIENT_CONTEXT_GET_GROUPS_STORE_LEVEL_ONLY = 2,
}

struct SI_OBJECT_INFO
{
    uint dwFlags;
    HINSTANCE hInstance;
    const(wchar)* pszServerName;
    const(wchar)* pszObjectName;
    const(wchar)* pszPageTitle;
    Guid guidObjectType;
}

struct SI_ACCESS
{
    const(Guid)* pguid;
    uint mask;
    const(wchar)* pszName;
    uint dwFlags;
}

struct SI_INHERIT_TYPE
{
    const(Guid)* pguid;
    uint dwFlags;
    const(wchar)* pszName;
}

enum SI_PAGE_TYPE
{
    SI_PAGE_PERM = 0,
    SI_PAGE_ADVPERM = 1,
    SI_PAGE_AUDIT = 2,
    SI_PAGE_OWNER = 3,
    SI_PAGE_EFFECTIVE = 4,
    SI_PAGE_TAKEOWNERSHIP = 5,
    SI_PAGE_SHARE = 6,
}

enum SI_PAGE_ACTIVATED
{
    SI_SHOW_DEFAULT = 0,
    SI_SHOW_PERM_ACTIVATED = 1,
    SI_SHOW_AUDIT_ACTIVATED = 2,
    SI_SHOW_OWNER_ACTIVATED = 3,
    SI_SHOW_EFFECTIVE_ACTIVATED = 4,
    SI_SHOW_SHARE_ACTIVATED = 5,
    SI_SHOW_CENTRAL_POLICY_ACTIVATED = 6,
}

const GUID IID_ISecurityInformation = {0x965FC360, 0x16FF, 0x11D0, [0x91, 0xCB, 0x00, 0xAA, 0x00, 0xBB, 0xB7, 0x23]};
@GUID(0x965FC360, 0x16FF, 0x11D0, [0x91, 0xCB, 0x00, 0xAA, 0x00, 0xBB, 0xB7, 0x23]);
interface ISecurityInformation : IUnknown
{
    HRESULT GetObjectInformation(SI_OBJECT_INFO* pObjectInfo);
    HRESULT GetSecurity(uint RequestedInformation, void** ppSecurityDescriptor, BOOL fDefault);
    HRESULT SetSecurity(uint SecurityInformation, void* pSecurityDescriptor);
    HRESULT GetAccessRights(const(Guid)* pguidObjectType, uint dwFlags, SI_ACCESS** ppAccess, uint* pcAccesses, uint* piDefaultAccess);
    HRESULT MapGeneric(const(Guid)* pguidObjectType, ubyte* pAceFlags, uint* pMask);
    HRESULT GetInheritTypes(SI_INHERIT_TYPE** ppInheritTypes, uint* pcInheritTypes);
    HRESULT PropertySheetPageCallback(HWND hwnd, uint uMsg, SI_PAGE_TYPE uPage);
}

const GUID IID_ISecurityInformation2 = {0xC3CCFDB4, 0x6F88, 0x11D2, [0xA3, 0xCE, 0x00, 0xC0, 0x4F, 0xB1, 0x78, 0x2A]};
@GUID(0xC3CCFDB4, 0x6F88, 0x11D2, [0xA3, 0xCE, 0x00, 0xC0, 0x4F, 0xB1, 0x78, 0x2A]);
interface ISecurityInformation2 : IUnknown
{
    BOOL IsDaclCanonical(ACL* pDacl);
    HRESULT LookupSids(uint cSids, void** rgpSids, IDataObject* ppdo);
}

struct SID_INFO
{
    void* pSid;
    const(wchar)* pwzCommonName;
    const(wchar)* pwzClass;
    const(wchar)* pwzUPN;
}

struct SID_INFO_LIST
{
    uint cItems;
    SID_INFO aSidInfo;
}

const GUID IID_IEffectivePermission = {0x3853DC76, 0x9F35, 0x407C, [0x88, 0xA1, 0xD1, 0x93, 0x44, 0x36, 0x5F, 0xBC]};
@GUID(0x3853DC76, 0x9F35, 0x407C, [0x88, 0xA1, 0xD1, 0x93, 0x44, 0x36, 0x5F, 0xBC]);
interface IEffectivePermission : IUnknown
{
    HRESULT GetEffectivePermission(const(Guid)* pguidObjectType, void* pUserSid, const(wchar)* pszServerName, void* pSD, OBJECT_TYPE_LIST** ppObjectTypeList, uint* pcObjectTypeListLength, uint** ppGrantedAccessList, uint* pcGrantedAccessListLength);
}

const GUID IID_ISecurityObjectTypeInfo = {0xFC3066EB, 0x79EF, 0x444B, [0x91, 0x11, 0xD1, 0x8A, 0x75, 0xEB, 0xF2, 0xFA]};
@GUID(0xFC3066EB, 0x79EF, 0x444B, [0x91, 0x11, 0xD1, 0x8A, 0x75, 0xEB, 0xF2, 0xFA]);
interface ISecurityObjectTypeInfo : IUnknown
{
    HRESULT GetInheritSource(uint si, ACL* pACL, INHERITED_FROMA** ppInheritArray);
}

const GUID IID_ISecurityInformation3 = {0xE2CDC9CC, 0x31BD, 0x4F8F, [0x8C, 0x8B, 0xB6, 0x41, 0xAF, 0x51, 0x6A, 0x1A]};
@GUID(0xE2CDC9CC, 0x31BD, 0x4F8F, [0x8C, 0x8B, 0xB6, 0x41, 0xAF, 0x51, 0x6A, 0x1A]);
interface ISecurityInformation3 : IUnknown
{
    HRESULT GetFullResourceName(ushort** ppszResourceName);
    HRESULT OpenElevatedEditor(HWND hWnd, SI_PAGE_TYPE uPage);
}

struct SECURITY_OBJECT
{
    const(wchar)* pwszName;
    void* pData;
    uint cbData;
    void* pData2;
    uint cbData2;
    uint Id;
    ubyte fWellKnown;
}

struct EFFPERM_RESULT_LIST
{
    ubyte fEvaluated;
    uint cObjectTypeListLength;
    OBJECT_TYPE_LIST* pObjectTypeList;
    uint* pGrantedAccessList;
}

const GUID IID_ISecurityInformation4 = {0xEA961070, 0xCD14, 0x4621, [0xAC, 0xE4, 0xF6, 0x3C, 0x03, 0xE5, 0x83, 0xE4]};
@GUID(0xEA961070, 0xCD14, 0x4621, [0xAC, 0xE4, 0xF6, 0x3C, 0x03, 0xE5, 0x83, 0xE4]);
interface ISecurityInformation4 : IUnknown
{
    HRESULT GetSecondarySecurity(SECURITY_OBJECT** pSecurityObjects, uint* pSecurityObjectCount);
}

const GUID IID_IEffectivePermission2 = {0x941FABCA, 0xDD47, 0x4FCA, [0x90, 0xBB, 0xB0, 0xE1, 0x02, 0x55, 0xF2, 0x0D]};
@GUID(0x941FABCA, 0xDD47, 0x4FCA, [0x90, 0xBB, 0xB0, 0xE1, 0x02, 0x55, 0xF2, 0x0D]);
interface IEffectivePermission2 : IUnknown
{
    HRESULT ComputeEffectivePermissionWithSecondarySecurity(void* pSid, void* pDeviceSid, const(wchar)* pszServerName, char* pSecurityObjects, uint dwSecurityObjectCount, TOKEN_GROUPS* pUserGroups, char* pAuthzUserGroupsOperations, TOKEN_GROUPS* pDeviceGroups, char* pAuthzDeviceGroupsOperations, AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAuthzUserClaims, char* pAuthzUserClaimsOperations, AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAuthzDeviceClaims, char* pAuthzDeviceClaimsOperations, char* pEffpermResultLists);
}

alias FN_PROGRESS = extern(Windows) void function(const(wchar)* pObjectName, uint Status, PROG_INVOKE_SETTING* pInvokeSetting, void* Args, BOOL SecuritySet);
alias PFNREADOBJECTSECURITY = extern(Windows) HRESULT function(const(wchar)* param0, uint param1, void** param2, LPARAM param3);
alias PFNWRITEOBJECTSECURITY = extern(Windows) HRESULT function(const(wchar)* param0, uint param1, void* param2, LPARAM param3);
alias PFNDSCREATEISECINFO = extern(Windows) HRESULT function(const(wchar)* param0, const(wchar)* param1, uint param2, ISecurityInformation* param3, PFNREADOBJECTSECURITY param4, PFNWRITEOBJECTSECURITY param5, LPARAM param6);
alias PFNDSCREATEISECINFOEX = extern(Windows) HRESULT function(const(wchar)* param0, const(wchar)* param1, const(wchar)* param2, const(wchar)* param3, const(wchar)* param4, uint param5, ISecurityInformation* param6, PFNREADOBJECTSECURITY param7, PFNWRITEOBJECTSECURITY param8, LPARAM param9);
alias PFNDSCREATESECPAGE = extern(Windows) HRESULT function(const(wchar)* param0, const(wchar)* param1, uint param2, HPROPSHEETPAGE* param3, PFNREADOBJECTSECURITY param4, PFNWRITEOBJECTSECURITY param5, LPARAM param6);
alias PFNDSEDITSECURITY = extern(Windows) HRESULT function(HWND param0, const(wchar)* param1, const(wchar)* param2, uint param3, const(wchar)* param4, PFNREADOBJECTSECURITY param5, PFNWRITEOBJECTSECURITY param6, LPARAM param7);
const GUID CLSID_CObjectId = {0x884E2000, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2000, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CObjectId;

const GUID CLSID_CObjectIds = {0x884E2001, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2001, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CObjectIds;

const GUID CLSID_CBinaryConverter = {0x884E2002, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2002, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CBinaryConverter;

const GUID CLSID_CX500DistinguishedName = {0x884E2003, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2003, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX500DistinguishedName;

const GUID CLSID_CCspInformation = {0x884E2007, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2007, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCspInformation;

const GUID CLSID_CCspInformations = {0x884E2008, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2008, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCspInformations;

const GUID CLSID_CCspStatus = {0x884E2009, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2009, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCspStatus;

const GUID CLSID_CX509PublicKey = {0x884E200B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E200B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509PublicKey;

const GUID CLSID_CX509PrivateKey = {0x884E200C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E200C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509PrivateKey;

const GUID CLSID_CX509EndorsementKey = {0x11A25A1D, 0xB9A3, 0x4EDD, [0xAF, 0x83, 0x3B, 0x59, 0xAD, 0xBE, 0xD3, 0x61]};
@GUID(0x11A25A1D, 0xB9A3, 0x4EDD, [0xAF, 0x83, 0x3B, 0x59, 0xAD, 0xBE, 0xD3, 0x61]);
struct CX509EndorsementKey;

const GUID CLSID_CX509Extension = {0x884E200D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E200D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509Extension;

const GUID CLSID_CX509Extensions = {0x884E200E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E200E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509Extensions;

const GUID CLSID_CX509ExtensionKeyUsage = {0x884E200F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E200F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionKeyUsage;

const GUID CLSID_CX509ExtensionEnhancedKeyUsage = {0x884E2010, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2010, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionEnhancedKeyUsage;

const GUID CLSID_CX509ExtensionTemplateName = {0x884E2011, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2011, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionTemplateName;

const GUID CLSID_CX509ExtensionTemplate = {0x884E2012, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2012, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionTemplate;

const GUID CLSID_CAlternativeName = {0x884E2013, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2013, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CAlternativeName;

const GUID CLSID_CAlternativeNames = {0x884E2014, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2014, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CAlternativeNames;

const GUID CLSID_CX509ExtensionAlternativeNames = {0x884E2015, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2015, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionAlternativeNames;

const GUID CLSID_CX509ExtensionBasicConstraints = {0x884E2016, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2016, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionBasicConstraints;

const GUID CLSID_CX509ExtensionSubjectKeyIdentifier = {0x884E2017, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2017, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionSubjectKeyIdentifier;

const GUID CLSID_CX509ExtensionAuthorityKeyIdentifier = {0x884E2018, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2018, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionAuthorityKeyIdentifier;

const GUID CLSID_CSmimeCapability = {0x884E2019, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2019, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CSmimeCapability;

const GUID CLSID_CSmimeCapabilities = {0x884E201A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E201A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CSmimeCapabilities;

const GUID CLSID_CX509ExtensionSmimeCapabilities = {0x884E201B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E201B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionSmimeCapabilities;

const GUID CLSID_CPolicyQualifier = {0x884E201C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E201C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CPolicyQualifier;

const GUID CLSID_CPolicyQualifiers = {0x884E201D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E201D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CPolicyQualifiers;

const GUID CLSID_CCertificatePolicy = {0x884E201E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E201E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertificatePolicy;

const GUID CLSID_CCertificatePolicies = {0x884E201F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E201F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertificatePolicies;

const GUID CLSID_CX509ExtensionCertificatePolicies = {0x884E2020, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2020, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionCertificatePolicies;

const GUID CLSID_CX509ExtensionMSApplicationPolicies = {0x884E2021, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2021, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509ExtensionMSApplicationPolicies;

const GUID CLSID_CX509Attribute = {0x884E2022, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2022, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509Attribute;

const GUID CLSID_CX509Attributes = {0x884E2023, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2023, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509Attributes;

const GUID CLSID_CX509AttributeExtensions = {0x884E2024, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2024, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509AttributeExtensions;

const GUID CLSID_CX509AttributeClientId = {0x884E2025, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2025, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509AttributeClientId;

const GUID CLSID_CX509AttributeRenewalCertificate = {0x884E2026, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2026, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509AttributeRenewalCertificate;

const GUID CLSID_CX509AttributeArchiveKey = {0x884E2027, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2027, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509AttributeArchiveKey;

const GUID CLSID_CX509AttributeArchiveKeyHash = {0x884E2028, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2028, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509AttributeArchiveKeyHash;

const GUID CLSID_CX509AttributeOSVersion = {0x884E202A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E202A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509AttributeOSVersion;

const GUID CLSID_CX509AttributeCspProvider = {0x884E202B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E202B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509AttributeCspProvider;

const GUID CLSID_CCryptAttribute = {0x884E202C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E202C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCryptAttribute;

const GUID CLSID_CCryptAttributes = {0x884E202D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E202D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCryptAttributes;

const GUID CLSID_CCertProperty = {0x884E202E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E202E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertProperty;

const GUID CLSID_CCertProperties = {0x884E202F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E202F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertProperties;

const GUID CLSID_CCertPropertyFriendlyName = {0x884E2030, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2030, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyFriendlyName;

const GUID CLSID_CCertPropertyDescription = {0x884E2031, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2031, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyDescription;

const GUID CLSID_CCertPropertyAutoEnroll = {0x884E2032, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2032, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyAutoEnroll;

const GUID CLSID_CCertPropertyRequestOriginator = {0x884E2033, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2033, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyRequestOriginator;

const GUID CLSID_CCertPropertySHA1Hash = {0x884E2034, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2034, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertySHA1Hash;

const GUID CLSID_CCertPropertyKeyProvInfo = {0x884E2036, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2036, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyKeyProvInfo;

const GUID CLSID_CCertPropertyArchived = {0x884E2037, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2037, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyArchived;

const GUID CLSID_CCertPropertyBackedUp = {0x884E2038, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2038, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyBackedUp;

const GUID CLSID_CCertPropertyEnrollment = {0x884E2039, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2039, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyEnrollment;

const GUID CLSID_CCertPropertyRenewal = {0x884E203A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E203A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyRenewal;

const GUID CLSID_CCertPropertyArchivedKeyHash = {0x884E203B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E203B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyArchivedKeyHash;

const GUID CLSID_CCertPropertyEnrollmentPolicyServer = {0x884E204C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E204C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CCertPropertyEnrollmentPolicyServer;

const GUID CLSID_CSignerCertificate = {0x884E203D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E203D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CSignerCertificate;

const GUID CLSID_CX509NameValuePair = {0x884E203F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E203F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509NameValuePair;

const GUID CLSID_CCertificateAttestationChallenge = {0x1362ADA1, 0xEB60, 0x456A, [0xB6, 0xE1, 0x11, 0x80, 0x50, 0xDB, 0x74, 0x1B]};
@GUID(0x1362ADA1, 0xEB60, 0x456A, [0xB6, 0xE1, 0x11, 0x80, 0x50, 0xDB, 0x74, 0x1B]);
struct CCertificateAttestationChallenge;

const GUID CLSID_CX509CertificateRequestPkcs10 = {0x884E2042, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2042, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509CertificateRequestPkcs10;

const GUID CLSID_CX509CertificateRequestCertificate = {0x884E2043, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2043, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509CertificateRequestCertificate;

const GUID CLSID_CX509CertificateRequestPkcs7 = {0x884E2044, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2044, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509CertificateRequestPkcs7;

const GUID CLSID_CX509CertificateRequestCmc = {0x884E2045, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2045, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509CertificateRequestCmc;

const GUID CLSID_CX509Enrollment = {0x884E2046, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2046, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509Enrollment;

const GUID CLSID_CX509EnrollmentWebClassFactory = {0x884E2049, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2049, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509EnrollmentWebClassFactory;

const GUID CLSID_CX509EnrollmentHelper = {0x884E2050, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2050, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509EnrollmentHelper;

const GUID CLSID_CX509MachineEnrollmentFactory = {0x884E2051, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2051, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509MachineEnrollmentFactory;

const GUID CLSID_CX509EnrollmentPolicyActiveDirectory = {0x91F39027, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x91F39027, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509EnrollmentPolicyActiveDirectory;

const GUID CLSID_CX509EnrollmentPolicyWebService = {0x91F39028, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x91F39028, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509EnrollmentPolicyWebService;

const GUID CLSID_CX509PolicyServerListManager = {0x91F39029, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x91F39029, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509PolicyServerListManager;

const GUID CLSID_CX509PolicyServerUrl = {0x91F3902A, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x91F3902A, 0x217F, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509PolicyServerUrl;

const GUID CLSID_CX509CertificateTemplateADWritable = {0x8336E323, 0x2E6A, 0x4A04, [0x93, 0x7C, 0x54, 0x8F, 0x68, 0x18, 0x39, 0xB3]};
@GUID(0x8336E323, 0x2E6A, 0x4A04, [0x93, 0x7C, 0x54, 0x8F, 0x68, 0x18, 0x39, 0xB3]);
struct CX509CertificateTemplateADWritable;

const GUID CLSID_CX509CertificateRevocationListEntry = {0x884E205E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E205E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509CertificateRevocationListEntry;

const GUID CLSID_CX509CertificateRevocationListEntries = {0x884E205F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E205F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509CertificateRevocationListEntries;

const GUID CLSID_CX509CertificateRevocationList = {0x884E2060, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2060, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509CertificateRevocationList;

const GUID CLSID_CX509SCEPEnrollment = {0x884E2061, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2061, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509SCEPEnrollment;

const GUID CLSID_CX509SCEPEnrollmentHelper = {0x884E2062, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E2062, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
struct CX509SCEPEnrollmentHelper;

const GUID CLSID_CCertGetConfig = {0xC6CC49B0, 0xCE17, 0x11D0, [0x88, 0x33, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0xC6CC49B0, 0xCE17, 0x11D0, [0x88, 0x33, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertGetConfig;

const GUID CLSID_CCertConfig = {0x372FCE38, 0x4324, 0x11D0, [0x88, 0x10, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x372FCE38, 0x4324, 0x11D0, [0x88, 0x10, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertConfig;

const GUID CLSID_CCertRequest = {0x98AFF3F0, 0x5524, 0x11D0, [0x88, 0x12, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x98AFF3F0, 0x5524, 0x11D0, [0x88, 0x12, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertRequest;

const GUID CLSID_CCertServerPolicy = {0xAA000926, 0xFFBE, 0x11CF, [0x88, 0x00, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0xAA000926, 0xFFBE, 0x11CF, [0x88, 0x00, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertServerPolicy;

const GUID CLSID_CCertServerExit = {0x4C4A5E40, 0x732C, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x4C4A5E40, 0x732C, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertServerExit;

const GUID IID_ICertServerPolicy = {0xAA000922, 0xFFBE, 0x11CF, [0x88, 0x00, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0xAA000922, 0xFFBE, 0x11CF, [0x88, 0x00, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertServerPolicy : IDispatch
{
    HRESULT SetContext(int Context);
    HRESULT GetRequestProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT GetRequestAttribute(const(ushort)* strAttributeName, BSTR* pstrAttributeValue);
    HRESULT GetCertificateProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT SetCertificateProperty(const(ushort)* strPropertyName, int PropertyType, const(VARIANT)* pvarPropertyValue);
    HRESULT GetCertificateExtension(const(ushort)* strExtensionName, int Type, VARIANT* pvarValue);
    HRESULT GetCertificateExtensionFlags(int* pExtFlags);
    HRESULT SetCertificateExtension(const(ushort)* strExtensionName, int Type, int ExtFlags, const(VARIANT)* pvarValue);
    HRESULT EnumerateExtensionsSetup(int Flags);
    HRESULT EnumerateExtensions(BSTR* pstrExtensionName);
    HRESULT EnumerateExtensionsClose();
    HRESULT EnumerateAttributesSetup(int Flags);
    HRESULT EnumerateAttributes(BSTR* pstrAttributeName);
    HRESULT EnumerateAttributesClose();
}

const GUID IID_ICertServerExit = {0x4BA9EB90, 0x732C, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x4BA9EB90, 0x732C, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertServerExit : IDispatch
{
    HRESULT SetContext(int Context);
    HRESULT GetRequestProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT GetRequestAttribute(const(ushort)* strAttributeName, BSTR* pstrAttributeValue);
    HRESULT GetCertificateProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT GetCertificateExtension(const(ushort)* strExtensionName, int Type, VARIANT* pvarValue);
    HRESULT GetCertificateExtensionFlags(int* pExtFlags);
    HRESULT EnumerateExtensionsSetup(int Flags);
    HRESULT EnumerateExtensions(BSTR* pstrExtensionName);
    HRESULT EnumerateExtensionsClose();
    HRESULT EnumerateAttributesSetup(int Flags);
    HRESULT EnumerateAttributes(BSTR* pstrAttributeName);
    HRESULT EnumerateAttributesClose();
}

const GUID IID_ICertGetConfig = {0xC7EA09C0, 0xCE17, 0x11D0, [0x88, 0x33, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0xC7EA09C0, 0xCE17, 0x11D0, [0x88, 0x33, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertGetConfig : IDispatch
{
    HRESULT GetConfig(int Flags, BSTR* pstrOut);
}

const GUID IID_ICertConfig = {0x372FCE34, 0x4324, 0x11D0, [0x88, 0x10, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x372FCE34, 0x4324, 0x11D0, [0x88, 0x10, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertConfig : IDispatch
{
    HRESULT Reset(int Index, int* pCount);
    HRESULT Next(int* pIndex);
    HRESULT GetField(const(ushort)* strFieldName, BSTR* pstrOut);
    HRESULT GetConfig(int Flags, BSTR* pstrOut);
}

const GUID IID_ICertConfig2 = {0x7A18EDDE, 0x7E78, 0x4163, [0x8D, 0xED, 0x78, 0xE2, 0xC9, 0xCE, 0xE9, 0x24]};
@GUID(0x7A18EDDE, 0x7E78, 0x4163, [0x8D, 0xED, 0x78, 0xE2, 0xC9, 0xCE, 0xE9, 0x24]);
interface ICertConfig2 : ICertConfig
{
    HRESULT SetSharedFolder(const(ushort)* strSharedFolder);
}

const GUID IID_ICertRequest = {0x014E4840, 0x5523, 0x11D0, [0x88, 0x12, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x014E4840, 0x5523, 0x11D0, [0x88, 0x12, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertRequest : IDispatch
{
    HRESULT Submit(int Flags, const(ushort)* strRequest, const(ushort)* strAttributes, const(ushort)* strConfig, int* pDisposition);
    HRESULT RetrievePending(int RequestId, const(ushort)* strConfig, int* pDisposition);
    HRESULT GetLastStatus(int* pStatus);
    HRESULT GetRequestId(int* pRequestId);
    HRESULT GetDispositionMessage(BSTR* pstrDispositionMessage);
    HRESULT GetCACertificate(int fExchangeCertificate, const(ushort)* strConfig, int Flags, BSTR* pstrCertificate);
    HRESULT GetCertificate(int Flags, BSTR* pstrCertificate);
}

const GUID IID_ICertRequest2 = {0xA4772988, 0x4A85, 0x4FA9, [0x82, 0x4E, 0xB5, 0xCF, 0x5C, 0x16, 0x40, 0x5A]};
@GUID(0xA4772988, 0x4A85, 0x4FA9, [0x82, 0x4E, 0xB5, 0xCF, 0x5C, 0x16, 0x40, 0x5A]);
interface ICertRequest2 : ICertRequest
{
    HRESULT GetIssuedCertificate(const(ushort)* strConfig, int RequestId, const(ushort)* strSerialNumber, int* pDisposition);
    HRESULT GetErrorMessageText(int hrMessage, int Flags, BSTR* pstrErrorMessageText);
    HRESULT GetCAProperty(const(ushort)* strConfig, int PropId, int PropIndex, int PropType, int Flags, VARIANT* pvarPropertyValue);
    HRESULT GetCAPropertyFlags(const(ushort)* strConfig, int PropId, int* pPropFlags);
    HRESULT GetCAPropertyDisplayName(const(ushort)* strConfig, int PropId, BSTR* pstrDisplayName);
    HRESULT GetFullResponseProperty(int PropId, int PropIndex, int PropType, int Flags, VARIANT* pvarPropertyValue);
}

enum X509EnrollmentAuthFlags
{
    X509AuthNone = 0,
    X509AuthAnonymous = 1,
    X509AuthKerberos = 2,
    X509AuthUsername = 4,
    X509AuthCertificate = 8,
}

const GUID IID_ICertRequest3 = {0xAFC8F92B, 0x33A2, 0x4861, [0xBF, 0x36, 0x29, 0x33, 0xB7, 0xCD, 0x67, 0xB3]};
@GUID(0xAFC8F92B, 0x33A2, 0x4861, [0xBF, 0x36, 0x29, 0x33, 0xB7, 0xCD, 0x67, 0xB3]);
interface ICertRequest3 : ICertRequest2
{
    HRESULT SetCredential(int hWnd, X509EnrollmentAuthFlags AuthType, BSTR strCredential, BSTR strPassword);
    HRESULT GetRequestIdString(BSTR* pstrRequestId);
    HRESULT GetIssuedCertificate2(BSTR strConfig, BSTR strRequestId, BSTR strSerialNumber, int* pDisposition);
    HRESULT GetRefreshPolicy(short* pValue);
}

const GUID IID_ICertManageModule = {0xE7D7AD42, 0xBD3D, 0x11D1, [0x9A, 0x4D, 0x00, 0xC0, 0x4F, 0xC2, 0x97, 0xEB]};
@GUID(0xE7D7AD42, 0xBD3D, 0x11D1, [0x9A, 0x4D, 0x00, 0xC0, 0x4F, 0xC2, 0x97, 0xEB]);
interface ICertManageModule : IDispatch
{
    HRESULT GetProperty(const(ushort)* strConfig, BSTR strStorageLocation, BSTR strPropertyName, int Flags, VARIANT* pvarProperty);
    HRESULT SetProperty(const(ushort)* strConfig, BSTR strStorageLocation, BSTR strPropertyName, int Flags, const(VARIANT)* pvarProperty);
    HRESULT Configure(const(ushort)* strConfig, BSTR strStorageLocation, int Flags);
}

struct CERTTRANSBLOB
{
    uint cb;
    ubyte* pb;
}

struct CERTVIEWRESTRICTION
{
    uint ColumnIndex;
    int SeekOperator;
    int SortOrder;
    ubyte* pbValue;
    uint cbValue;
}

struct CSEDB_RSTMAPW
{
    ushort* pwszDatabaseName;
    ushort* pwszNewDatabaseName;
}

alias FNCERTSRVISSERVERONLINEW = extern(Windows) HRESULT function(const(wchar)* pwszServerName, int* pfServerOnline);
alias FNCERTSRVBACKUPGETDYNAMICFILELISTW = extern(Windows) HRESULT function(void* hbc, ushort** ppwszzFileList, uint* pcbSize);
alias FNCERTSRVBACKUPPREPAREW = extern(Windows) HRESULT function(const(wchar)* pwszServerName, uint grbitJet, uint dwBackupFlags, void** phbc);
alias FNCERTSRVBACKUPGETDATABASENAMESW = extern(Windows) HRESULT function(void* hbc, ushort** ppwszzAttachmentInformation, uint* pcbSize);
alias FNCERTSRVBACKUPOPENFILEW = extern(Windows) HRESULT function(void* hbc, const(wchar)* pwszAttachmentName, uint cbReadHintSize, LARGE_INTEGER* pliFileSize);
alias FNCERTSRVBACKUPREAD = extern(Windows) HRESULT function(void* hbc, void* pvBuffer, uint cbBuffer, uint* pcbRead);
alias FNCERTSRVBACKUPCLOSE = extern(Windows) HRESULT function(void* hbc);
alias FNCERTSRVBACKUPGETBACKUPLOGSW = extern(Windows) HRESULT function(void* hbc, ushort** ppwszzBackupLogFiles, uint* pcbSize);
alias FNCERTSRVBACKUPTRUNCATELOGS = extern(Windows) HRESULT function(void* hbc);
alias FNCERTSRVBACKUPEND = extern(Windows) HRESULT function(void* hbc);
alias FNCERTSRVBACKUPFREE = extern(Windows) void function(void* pv);
alias FNCERTSRVRESTOREGETDATABASELOCATIONSW = extern(Windows) HRESULT function(void* hbc, ushort** ppwszzDatabaseLocationList, uint* pcbSize);
alias FNCERTSRVRESTOREPREPAREW = extern(Windows) HRESULT function(const(wchar)* pwszServerName, uint dwRestoreFlags, void** phbc);
alias FNCERTSRVRESTOREREGISTERW = extern(Windows) HRESULT function(void* hbc, const(wchar)* pwszCheckPointFilePath, const(wchar)* pwszLogPath, CSEDB_RSTMAPW* rgrstmap, int crstmap, const(wchar)* pwszBackupLogPath, uint genLow, uint genHigh);
alias FNCERTSRVRESTOREREGISTERCOMPLETE = extern(Windows) HRESULT function(void* hbc, HRESULT hrRestoreState);
alias FNCERTSRVRESTOREEND = extern(Windows) HRESULT function(void* hbc);
alias FNCERTSRVSERVERCONTROLW = extern(Windows) HRESULT function(const(wchar)* pwszServerName, uint dwControlFlags, uint* pcbOut, ubyte** ppbOut);
const GUID IID_ICertPolicy = {0x38BB5A00, 0x7636, 0x11D0, [0xB4, 0x13, 0x00, 0xA0, 0xC9, 0x1B, 0xBF, 0x8C]};
@GUID(0x38BB5A00, 0x7636, 0x11D0, [0xB4, 0x13, 0x00, 0xA0, 0xC9, 0x1B, 0xBF, 0x8C]);
interface ICertPolicy : IDispatch
{
    HRESULT Initialize(const(ushort)* strConfig);
    HRESULT VerifyRequest(const(ushort)* strConfig, int Context, int bNewRequest, int Flags, int* pDisposition);
    HRESULT GetDescription(BSTR* pstrDescription);
    HRESULT ShutDown();
}

const GUID IID_ICertPolicy2 = {0x3DB4910E, 0x8001, 0x4BF1, [0xAA, 0x1B, 0xF4, 0x3A, 0x80, 0x83, 0x17, 0xA0]};
@GUID(0x3DB4910E, 0x8001, 0x4BF1, [0xAA, 0x1B, 0xF4, 0x3A, 0x80, 0x83, 0x17, 0xA0]);
interface ICertPolicy2 : ICertPolicy
{
    HRESULT GetManageModule(ICertManageModule* ppManageModule);
}

enum X509SCEPMessageType
{
    SCEPMessageUnknown = -1,
    SCEPMessageCertResponse = 3,
    SCEPMessagePKCSRequest = 19,
    SCEPMessageGetCertInitial = 20,
    SCEPMessageGetCert = 21,
    SCEPMessageGetCRL = 22,
    SCEPMessageClaimChallengeAnswer = 41,
}

enum X509SCEPDisposition
{
    SCEPDispositionUnknown = -1,
    SCEPDispositionSuccess = 0,
    SCEPDispositionFailure = 2,
    SCEPDispositionPending = 3,
    SCEPDispositionPendingChallenge = 11,
}

enum X509SCEPFailInfo
{
    SCEPFailUnknown = -1,
    SCEPFailBadAlgorithm = 0,
    SCEPFailBadMessageCheck = 1,
    SCEPFailBadRequest = 2,
    SCEPFailBadTime = 3,
    SCEPFailBadCertId = 4,
}

const GUID IID_INDESPolicy = {0x13CA515D, 0x431D, 0x46CC, [0x8C, 0x2E, 0x1D, 0xA2, 0x69, 0xBB, 0xD6, 0x25]};
@GUID(0x13CA515D, 0x431D, 0x46CC, [0x8C, 0x2E, 0x1D, 0xA2, 0x69, 0xBB, 0xD6, 0x25]);
interface INDESPolicy : IUnknown
{
    HRESULT Initialize();
    HRESULT Uninitialize();
    HRESULT GenerateChallenge(const(wchar)* pwszTemplate, const(wchar)* pwszParams, ushort** ppwszResponse);
    HRESULT VerifyRequest(CERTTRANSBLOB* pctbRequest, CERTTRANSBLOB* pctbSigningCertEncoded, const(wchar)* pwszTemplate, const(wchar)* pwszTransactionId, int* pfVerified);
    HRESULT Notify(const(wchar)* pwszChallenge, const(wchar)* pwszTransactionId, X509SCEPDisposition disposition, int lastHResult, CERTTRANSBLOB* pctbIssuedCertEncoded);
}

enum CERTENROLL_OBJECTID
{
    XCN_OID_NONE = 0,
    XCN_OID_RSA = 1,
    XCN_OID_PKCS = 2,
    XCN_OID_RSA_HASH = 3,
    XCN_OID_RSA_ENCRYPT = 4,
    XCN_OID_PKCS_1 = 5,
    XCN_OID_PKCS_2 = 6,
    XCN_OID_PKCS_3 = 7,
    XCN_OID_PKCS_4 = 8,
    XCN_OID_PKCS_5 = 9,
    XCN_OID_PKCS_6 = 10,
    XCN_OID_PKCS_7 = 11,
    XCN_OID_PKCS_8 = 12,
    XCN_OID_PKCS_9 = 13,
    XCN_OID_PKCS_10 = 14,
    XCN_OID_PKCS_12 = 15,
    XCN_OID_RSA_RSA = 16,
    XCN_OID_RSA_MD2RSA = 17,
    XCN_OID_RSA_MD4RSA = 18,
    XCN_OID_RSA_MD5RSA = 19,
    XCN_OID_RSA_SHA1RSA = 20,
    XCN_OID_RSA_SETOAEP_RSA = 21,
    XCN_OID_RSA_DH = 22,
    XCN_OID_RSA_data = 23,
    XCN_OID_RSA_signedData = 24,
    XCN_OID_RSA_envelopedData = 25,
    XCN_OID_RSA_signEnvData = 26,
    XCN_OID_RSA_digestedData = 27,
    XCN_OID_RSA_hashedData = 28,
    XCN_OID_RSA_encryptedData = 29,
    XCN_OID_RSA_emailAddr = 30,
    XCN_OID_RSA_unstructName = 31,
    XCN_OID_RSA_contentType = 32,
    XCN_OID_RSA_messageDigest = 33,
    XCN_OID_RSA_signingTime = 34,
    XCN_OID_RSA_counterSign = 35,
    XCN_OID_RSA_challengePwd = 36,
    XCN_OID_RSA_unstructAddr = 37,
    XCN_OID_RSA_extCertAttrs = 38,
    XCN_OID_RSA_certExtensions = 39,
    XCN_OID_RSA_SMIMECapabilities = 40,
    XCN_OID_RSA_preferSignedData = 41,
    XCN_OID_RSA_SMIMEalg = 42,
    XCN_OID_RSA_SMIMEalgESDH = 43,
    XCN_OID_RSA_SMIMEalgCMS3DESwrap = 44,
    XCN_OID_RSA_SMIMEalgCMSRC2wrap = 45,
    XCN_OID_RSA_MD2 = 46,
    XCN_OID_RSA_MD4 = 47,
    XCN_OID_RSA_MD5 = 48,
    XCN_OID_RSA_RC2CBC = 49,
    XCN_OID_RSA_RC4 = 50,
    XCN_OID_RSA_DES_EDE3_CBC = 51,
    XCN_OID_RSA_RC5_CBCPad = 52,
    XCN_OID_ANSI_X942 = 53,
    XCN_OID_ANSI_X942_DH = 54,
    XCN_OID_X957 = 55,
    XCN_OID_X957_DSA = 56,
    XCN_OID_X957_SHA1DSA = 57,
    XCN_OID_DS = 58,
    XCN_OID_DSALG = 59,
    XCN_OID_DSALG_CRPT = 60,
    XCN_OID_DSALG_HASH = 61,
    XCN_OID_DSALG_SIGN = 62,
    XCN_OID_DSALG_RSA = 63,
    XCN_OID_OIW = 64,
    XCN_OID_OIWSEC = 65,
    XCN_OID_OIWSEC_md4RSA = 66,
    XCN_OID_OIWSEC_md5RSA = 67,
    XCN_OID_OIWSEC_md4RSA2 = 68,
    XCN_OID_OIWSEC_desECB = 69,
    XCN_OID_OIWSEC_desCBC = 70,
    XCN_OID_OIWSEC_desOFB = 71,
    XCN_OID_OIWSEC_desCFB = 72,
    XCN_OID_OIWSEC_desMAC = 73,
    XCN_OID_OIWSEC_rsaSign = 74,
    XCN_OID_OIWSEC_dsa = 75,
    XCN_OID_OIWSEC_shaDSA = 76,
    XCN_OID_OIWSEC_mdc2RSA = 77,
    XCN_OID_OIWSEC_shaRSA = 78,
    XCN_OID_OIWSEC_dhCommMod = 79,
    XCN_OID_OIWSEC_desEDE = 80,
    XCN_OID_OIWSEC_sha = 81,
    XCN_OID_OIWSEC_mdc2 = 82,
    XCN_OID_OIWSEC_dsaComm = 83,
    XCN_OID_OIWSEC_dsaCommSHA = 84,
    XCN_OID_OIWSEC_rsaXchg = 85,
    XCN_OID_OIWSEC_keyHashSeal = 86,
    XCN_OID_OIWSEC_md2RSASign = 87,
    XCN_OID_OIWSEC_md5RSASign = 88,
    XCN_OID_OIWSEC_sha1 = 89,
    XCN_OID_OIWSEC_dsaSHA1 = 90,
    XCN_OID_OIWSEC_dsaCommSHA1 = 91,
    XCN_OID_OIWSEC_sha1RSASign = 92,
    XCN_OID_OIWDIR = 93,
    XCN_OID_OIWDIR_CRPT = 94,
    XCN_OID_OIWDIR_HASH = 95,
    XCN_OID_OIWDIR_SIGN = 96,
    XCN_OID_OIWDIR_md2 = 97,
    XCN_OID_OIWDIR_md2RSA = 98,
    XCN_OID_INFOSEC = 99,
    XCN_OID_INFOSEC_sdnsSignature = 100,
    XCN_OID_INFOSEC_mosaicSignature = 101,
    XCN_OID_INFOSEC_sdnsConfidentiality = 102,
    XCN_OID_INFOSEC_mosaicConfidentiality = 103,
    XCN_OID_INFOSEC_sdnsIntegrity = 104,
    XCN_OID_INFOSEC_mosaicIntegrity = 105,
    XCN_OID_INFOSEC_sdnsTokenProtection = 106,
    XCN_OID_INFOSEC_mosaicTokenProtection = 107,
    XCN_OID_INFOSEC_sdnsKeyManagement = 108,
    XCN_OID_INFOSEC_mosaicKeyManagement = 109,
    XCN_OID_INFOSEC_sdnsKMandSig = 110,
    XCN_OID_INFOSEC_mosaicKMandSig = 111,
    XCN_OID_INFOSEC_SuiteASignature = 112,
    XCN_OID_INFOSEC_SuiteAConfidentiality = 113,
    XCN_OID_INFOSEC_SuiteAIntegrity = 114,
    XCN_OID_INFOSEC_SuiteATokenProtection = 115,
    XCN_OID_INFOSEC_SuiteAKeyManagement = 116,
    XCN_OID_INFOSEC_SuiteAKMandSig = 117,
    XCN_OID_INFOSEC_mosaicUpdatedSig = 118,
    XCN_OID_INFOSEC_mosaicKMandUpdSig = 119,
    XCN_OID_INFOSEC_mosaicUpdatedInteg = 120,
    XCN_OID_COMMON_NAME = 121,
    XCN_OID_SUR_NAME = 122,
    XCN_OID_DEVICE_SERIAL_NUMBER = 123,
    XCN_OID_COUNTRY_NAME = 124,
    XCN_OID_LOCALITY_NAME = 125,
    XCN_OID_STATE_OR_PROVINCE_NAME = 126,
    XCN_OID_STREET_ADDRESS = 127,
    XCN_OID_ORGANIZATION_NAME = 128,
    XCN_OID_ORGANIZATIONAL_UNIT_NAME = 129,
    XCN_OID_TITLE = 130,
    XCN_OID_DESCRIPTION = 131,
    XCN_OID_SEARCH_GUIDE = 132,
    XCN_OID_BUSINESS_CATEGORY = 133,
    XCN_OID_POSTAL_ADDRESS = 134,
    XCN_OID_POSTAL_CODE = 135,
    XCN_OID_POST_OFFICE_BOX = 136,
    XCN_OID_PHYSICAL_DELIVERY_OFFICE_NAME = 137,
    XCN_OID_TELEPHONE_NUMBER = 138,
    XCN_OID_TELEX_NUMBER = 139,
    XCN_OID_TELETEXT_TERMINAL_IDENTIFIER = 140,
    XCN_OID_FACSIMILE_TELEPHONE_NUMBER = 141,
    XCN_OID_X21_ADDRESS = 142,
    XCN_OID_INTERNATIONAL_ISDN_NUMBER = 143,
    XCN_OID_REGISTERED_ADDRESS = 144,
    XCN_OID_DESTINATION_INDICATOR = 145,
    XCN_OID_PREFERRED_DELIVERY_METHOD = 146,
    XCN_OID_PRESENTATION_ADDRESS = 147,
    XCN_OID_SUPPORTED_APPLICATION_CONTEXT = 148,
    XCN_OID_MEMBER = 149,
    XCN_OID_OWNER = 150,
    XCN_OID_ROLE_OCCUPANT = 151,
    XCN_OID_SEE_ALSO = 152,
    XCN_OID_USER_PASSWORD = 153,
    XCN_OID_USER_CERTIFICATE = 154,
    XCN_OID_CA_CERTIFICATE = 155,
    XCN_OID_AUTHORITY_REVOCATION_LIST = 156,
    XCN_OID_CERTIFICATE_REVOCATION_LIST = 157,
    XCN_OID_CROSS_CERTIFICATE_PAIR = 158,
    XCN_OID_GIVEN_NAME = 159,
    XCN_OID_INITIALS = 160,
    XCN_OID_DN_QUALIFIER = 161,
    XCN_OID_DOMAIN_COMPONENT = 162,
    XCN_OID_PKCS_12_FRIENDLY_NAME_ATTR = 163,
    XCN_OID_PKCS_12_LOCAL_KEY_ID = 164,
    XCN_OID_PKCS_12_KEY_PROVIDER_NAME_ATTR = 165,
    XCN_OID_LOCAL_MACHINE_KEYSET = 166,
    XCN_OID_PKCS_12_EXTENDED_ATTRIBUTES = 167,
    XCN_OID_KEYID_RDN = 168,
    XCN_OID_AUTHORITY_KEY_IDENTIFIER = 169,
    XCN_OID_KEY_ATTRIBUTES = 170,
    XCN_OID_CERT_POLICIES_95 = 171,
    XCN_OID_KEY_USAGE_RESTRICTION = 172,
    XCN_OID_SUBJECT_ALT_NAME = 173,
    XCN_OID_ISSUER_ALT_NAME = 174,
    XCN_OID_BASIC_CONSTRAINTS = 175,
    XCN_OID_KEY_USAGE = 176,
    XCN_OID_PRIVATEKEY_USAGE_PERIOD = 177,
    XCN_OID_BASIC_CONSTRAINTS2 = 178,
    XCN_OID_CERT_POLICIES = 179,
    XCN_OID_ANY_CERT_POLICY = 180,
    XCN_OID_AUTHORITY_KEY_IDENTIFIER2 = 181,
    XCN_OID_SUBJECT_KEY_IDENTIFIER = 182,
    XCN_OID_SUBJECT_ALT_NAME2 = 183,
    XCN_OID_ISSUER_ALT_NAME2 = 184,
    XCN_OID_CRL_REASON_CODE = 185,
    XCN_OID_REASON_CODE_HOLD = 186,
    XCN_OID_CRL_DIST_POINTS = 187,
    XCN_OID_ENHANCED_KEY_USAGE = 188,
    XCN_OID_CRL_NUMBER = 189,
    XCN_OID_DELTA_CRL_INDICATOR = 190,
    XCN_OID_ISSUING_DIST_POINT = 191,
    XCN_OID_FRESHEST_CRL = 192,
    XCN_OID_NAME_CONSTRAINTS = 193,
    XCN_OID_POLICY_MAPPINGS = 194,
    XCN_OID_LEGACY_POLICY_MAPPINGS = 195,
    XCN_OID_POLICY_CONSTRAINTS = 196,
    XCN_OID_RENEWAL_CERTIFICATE = 197,
    XCN_OID_ENROLLMENT_NAME_VALUE_PAIR = 198,
    XCN_OID_ENROLLMENT_CSP_PROVIDER = 199,
    XCN_OID_OS_VERSION = 200,
    XCN_OID_ENROLLMENT_AGENT = 201,
    XCN_OID_PKIX = 202,
    XCN_OID_PKIX_PE = 203,
    XCN_OID_AUTHORITY_INFO_ACCESS = 204,
    XCN_OID_BIOMETRIC_EXT = 205,
    XCN_OID_LOGOTYPE_EXT = 206,
    XCN_OID_CERT_EXTENSIONS = 207,
    XCN_OID_NEXT_UPDATE_LOCATION = 208,
    XCN_OID_REMOVE_CERTIFICATE = 209,
    XCN_OID_CROSS_CERT_DIST_POINTS = 210,
    XCN_OID_CTL = 211,
    XCN_OID_SORTED_CTL = 212,
    XCN_OID_SERIALIZED = 213,
    XCN_OID_NT_PRINCIPAL_NAME = 214,
    XCN_OID_PRODUCT_UPDATE = 215,
    XCN_OID_ANY_APPLICATION_POLICY = 216,
    XCN_OID_AUTO_ENROLL_CTL_USAGE = 217,
    XCN_OID_ENROLL_CERTTYPE_EXTENSION = 218,
    XCN_OID_CERT_MANIFOLD = 219,
    XCN_OID_CERTSRV_CA_VERSION = 220,
    XCN_OID_CERTSRV_PREVIOUS_CERT_HASH = 221,
    XCN_OID_CRL_VIRTUAL_BASE = 222,
    XCN_OID_CRL_NEXT_PUBLISH = 223,
    XCN_OID_KP_CA_EXCHANGE = 224,
    XCN_OID_KP_KEY_RECOVERY_AGENT = 225,
    XCN_OID_CERTIFICATE_TEMPLATE = 226,
    XCN_OID_ENTERPRISE_OID_ROOT = 227,
    XCN_OID_RDN_DUMMY_SIGNER = 228,
    XCN_OID_APPLICATION_CERT_POLICIES = 229,
    XCN_OID_APPLICATION_POLICY_MAPPINGS = 230,
    XCN_OID_APPLICATION_POLICY_CONSTRAINTS = 231,
    XCN_OID_ARCHIVED_KEY_ATTR = 232,
    XCN_OID_CRL_SELF_CDP = 233,
    XCN_OID_REQUIRE_CERT_CHAIN_POLICY = 234,
    XCN_OID_ARCHIVED_KEY_CERT_HASH = 235,
    XCN_OID_ISSUED_CERT_HASH = 236,
    XCN_OID_DS_EMAIL_REPLICATION = 237,
    XCN_OID_REQUEST_CLIENT_INFO = 238,
    XCN_OID_ENCRYPTED_KEY_HASH = 239,
    XCN_OID_CERTSRV_CROSSCA_VERSION = 240,
    XCN_OID_NTDS_REPLICATION = 241,
    XCN_OID_SUBJECT_DIR_ATTRS = 242,
    XCN_OID_PKIX_KP = 243,
    XCN_OID_PKIX_KP_SERVER_AUTH = 244,
    XCN_OID_PKIX_KP_CLIENT_AUTH = 245,
    XCN_OID_PKIX_KP_CODE_SIGNING = 246,
    XCN_OID_PKIX_KP_EMAIL_PROTECTION = 247,
    XCN_OID_PKIX_KP_IPSEC_END_SYSTEM = 248,
    XCN_OID_PKIX_KP_IPSEC_TUNNEL = 249,
    XCN_OID_PKIX_KP_IPSEC_USER = 250,
    XCN_OID_PKIX_KP_TIMESTAMP_SIGNING = 251,
    XCN_OID_PKIX_KP_OCSP_SIGNING = 252,
    XCN_OID_PKIX_OCSP_NOCHECK = 253,
    XCN_OID_IPSEC_KP_IKE_INTERMEDIATE = 254,
    XCN_OID_KP_CTL_USAGE_SIGNING = 255,
    XCN_OID_KP_TIME_STAMP_SIGNING = 256,
    XCN_OID_SERVER_GATED_CRYPTO = 257,
    XCN_OID_SGC_NETSCAPE = 258,
    XCN_OID_KP_EFS = 259,
    XCN_OID_EFS_RECOVERY = 260,
    XCN_OID_WHQL_CRYPTO = 261,
    XCN_OID_NT5_CRYPTO = 262,
    XCN_OID_OEM_WHQL_CRYPTO = 263,
    XCN_OID_EMBEDDED_NT_CRYPTO = 264,
    XCN_OID_ROOT_LIST_SIGNER = 265,
    XCN_OID_KP_QUALIFIED_SUBORDINATION = 266,
    XCN_OID_KP_KEY_RECOVERY = 267,
    XCN_OID_KP_DOCUMENT_SIGNING = 268,
    XCN_OID_KP_LIFETIME_SIGNING = 269,
    XCN_OID_KP_MOBILE_DEVICE_SOFTWARE = 270,
    XCN_OID_KP_SMART_DISPLAY = 271,
    XCN_OID_KP_CSP_SIGNATURE = 272,
    XCN_OID_DRM = 273,
    XCN_OID_DRM_INDIVIDUALIZATION = 274,
    XCN_OID_LICENSES = 275,
    XCN_OID_LICENSE_SERVER = 276,
    XCN_OID_KP_SMARTCARD_LOGON = 277,
    XCN_OID_YESNO_TRUST_ATTR = 278,
    XCN_OID_PKIX_POLICY_QUALIFIER_CPS = 279,
    XCN_OID_PKIX_POLICY_QUALIFIER_USERNOTICE = 280,
    XCN_OID_CERT_POLICIES_95_QUALIFIER1 = 281,
    XCN_OID_PKIX_ACC_DESCR = 282,
    XCN_OID_PKIX_OCSP = 283,
    XCN_OID_PKIX_CA_ISSUERS = 284,
    XCN_OID_VERISIGN_PRIVATE_6_9 = 285,
    XCN_OID_VERISIGN_ONSITE_JURISDICTION_HASH = 286,
    XCN_OID_VERISIGN_BITSTRING_6_13 = 287,
    XCN_OID_VERISIGN_ISS_STRONG_CRYPTO = 288,
    XCN_OID_NETSCAPE = 289,
    XCN_OID_NETSCAPE_CERT_EXTENSION = 290,
    XCN_OID_NETSCAPE_CERT_TYPE = 291,
    XCN_OID_NETSCAPE_BASE_URL = 292,
    XCN_OID_NETSCAPE_REVOCATION_URL = 293,
    XCN_OID_NETSCAPE_CA_REVOCATION_URL = 294,
    XCN_OID_NETSCAPE_CERT_RENEWAL_URL = 295,
    XCN_OID_NETSCAPE_CA_POLICY_URL = 296,
    XCN_OID_NETSCAPE_SSL_SERVER_NAME = 297,
    XCN_OID_NETSCAPE_COMMENT = 298,
    XCN_OID_NETSCAPE_DATA_TYPE = 299,
    XCN_OID_NETSCAPE_CERT_SEQUENCE = 300,
    XCN_OID_CT_PKI_DATA = 301,
    XCN_OID_CT_PKI_RESPONSE = 302,
    XCN_OID_PKIX_NO_SIGNATURE = 303,
    XCN_OID_CMC = 304,
    XCN_OID_CMC_STATUS_INFO = 305,
    XCN_OID_CMC_IDENTIFICATION = 306,
    XCN_OID_CMC_IDENTITY_PROOF = 307,
    XCN_OID_CMC_DATA_RETURN = 308,
    XCN_OID_CMC_TRANSACTION_ID = 309,
    XCN_OID_CMC_SENDER_NONCE = 310,
    XCN_OID_CMC_RECIPIENT_NONCE = 311,
    XCN_OID_CMC_ADD_EXTENSIONS = 312,
    XCN_OID_CMC_ENCRYPTED_POP = 313,
    XCN_OID_CMC_DECRYPTED_POP = 314,
    XCN_OID_CMC_LRA_POP_WITNESS = 315,
    XCN_OID_CMC_GET_CERT = 316,
    XCN_OID_CMC_GET_CRL = 317,
    XCN_OID_CMC_REVOKE_REQUEST = 318,
    XCN_OID_CMC_REG_INFO = 319,
    XCN_OID_CMC_RESPONSE_INFO = 320,
    XCN_OID_CMC_QUERY_PENDING = 321,
    XCN_OID_CMC_ID_POP_LINK_RANDOM = 322,
    XCN_OID_CMC_ID_POP_LINK_WITNESS = 323,
    XCN_OID_CMC_ID_CONFIRM_CERT_ACCEPTANCE = 324,
    XCN_OID_CMC_ADD_ATTRIBUTES = 325,
    XCN_OID_LOYALTY_OTHER_LOGOTYPE = 326,
    XCN_OID_BACKGROUND_OTHER_LOGOTYPE = 327,
    XCN_OID_PKIX_OCSP_BASIC_SIGNED_RESPONSE = 328,
    XCN_OID_PKCS_7_DATA = 329,
    XCN_OID_PKCS_7_SIGNED = 330,
    XCN_OID_PKCS_7_ENVELOPED = 331,
    XCN_OID_PKCS_7_SIGNEDANDENVELOPED = 332,
    XCN_OID_PKCS_7_DIGESTED = 333,
    XCN_OID_PKCS_7_ENCRYPTED = 334,
    XCN_OID_PKCS_9_CONTENT_TYPE = 335,
    XCN_OID_PKCS_9_MESSAGE_DIGEST = 336,
    XCN_OID_CERT_PROP_ID_PREFIX = 337,
    XCN_OID_CERT_KEY_IDENTIFIER_PROP_ID = 338,
    XCN_OID_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID = 339,
    XCN_OID_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID = 340,
    XCN_OID_CERT_MD5_HASH_PROP_ID = 341,
    XCN_OID_RSA_SHA256RSA = 342,
    XCN_OID_RSA_SHA384RSA = 343,
    XCN_OID_RSA_SHA512RSA = 344,
    XCN_OID_NIST_sha256 = 345,
    XCN_OID_NIST_sha384 = 346,
    XCN_OID_NIST_sha512 = 347,
    XCN_OID_RSA_MGF1 = 348,
    XCN_OID_ECC_PUBLIC_KEY = 349,
    XCN_OID_ECDSA_SHA1 = 350,
    XCN_OID_ECDSA_SPECIFIED = 351,
    XCN_OID_ANY_ENHANCED_KEY_USAGE = 352,
    XCN_OID_RSA_SSA_PSS = 353,
    XCN_OID_ATTR_SUPPORTED_ALGORITHMS = 355,
    XCN_OID_ATTR_TPM_SECURITY_ASSERTIONS = 356,
    XCN_OID_ATTR_TPM_SPECIFICATION = 357,
    XCN_OID_CERT_DISALLOWED_FILETIME_PROP_ID = 358,
    XCN_OID_CERT_SIGNATURE_HASH_PROP_ID = 359,
    XCN_OID_CERT_STRONG_KEY_OS_1 = 360,
    XCN_OID_CERT_STRONG_KEY_OS_CURRENT = 361,
    XCN_OID_CERT_STRONG_KEY_OS_PREFIX = 362,
    XCN_OID_CERT_STRONG_SIGN_OS_1 = 363,
    XCN_OID_CERT_STRONG_SIGN_OS_CURRENT = 364,
    XCN_OID_CERT_STRONG_SIGN_OS_PREFIX = 365,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA1_KDF = 366,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA256_KDF = 367,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA384_KDF = 368,
    XCN_OID_DISALLOWED_HASH = 369,
    XCN_OID_DISALLOWED_LIST = 370,
    XCN_OID_ECC_CURVE_P256 = 371,
    XCN_OID_ECC_CURVE_P384 = 372,
    XCN_OID_ECC_CURVE_P521 = 373,
    XCN_OID_ECDSA_SHA256 = 374,
    XCN_OID_ECDSA_SHA384 = 375,
    XCN_OID_ECDSA_SHA512 = 376,
    XCN_OID_ENROLL_CAXCHGCERT_HASH = 377,
    XCN_OID_ENROLL_EK_INFO = 378,
    XCN_OID_ENROLL_EKPUB_CHALLENGE = 379,
    XCN_OID_ENROLL_EKVERIFYCERT = 380,
    XCN_OID_ENROLL_EKVERIFYCREDS = 381,
    XCN_OID_ENROLL_EKVERIFYKEY = 382,
    XCN_OID_EV_RDN_COUNTRY = 383,
    XCN_OID_EV_RDN_LOCALE = 384,
    XCN_OID_EV_RDN_STATE_OR_PROVINCE = 385,
    XCN_OID_INHIBIT_ANY_POLICY = 386,
    XCN_OID_INTERNATIONALIZED_EMAIL_ADDRESS = 387,
    XCN_OID_KP_KERNEL_MODE_CODE_SIGNING = 388,
    XCN_OID_KP_KERNEL_MODE_HAL_EXTENSION_SIGNING = 389,
    XCN_OID_KP_KERNEL_MODE_TRUSTED_BOOT_SIGNING = 390,
    XCN_OID_KP_TPM_AIK_CERTIFICATE = 391,
    XCN_OID_KP_TPM_EK_CERTIFICATE = 392,
    XCN_OID_KP_TPM_PLATFORM_CERTIFICATE = 393,
    XCN_OID_NIST_AES128_CBC = 394,
    XCN_OID_NIST_AES128_WRAP = 395,
    XCN_OID_NIST_AES192_CBC = 396,
    XCN_OID_NIST_AES192_WRAP = 397,
    XCN_OID_NIST_AES256_CBC = 398,
    XCN_OID_NIST_AES256_WRAP = 399,
    XCN_OID_PKCS_12_PbeIds = 400,
    XCN_OID_PKCS_12_pbeWithSHA1And128BitRC2 = 401,
    XCN_OID_PKCS_12_pbeWithSHA1And128BitRC4 = 402,
    XCN_OID_PKCS_12_pbeWithSHA1And2KeyTripleDES = 403,
    XCN_OID_PKCS_12_pbeWithSHA1And3KeyTripleDES = 404,
    XCN_OID_PKCS_12_pbeWithSHA1And40BitRC2 = 405,
    XCN_OID_PKCS_12_pbeWithSHA1And40BitRC4 = 406,
    XCN_OID_PKCS_12_PROTECTED_PASSWORD_SECRET_BAG_TYPE_ID = 407,
    XCN_OID_PKINIT_KP_KDC = 408,
    XCN_OID_PKIX_CA_REPOSITORY = 409,
    XCN_OID_PKIX_OCSP_NONCE = 410,
    XCN_OID_PKIX_TIME_STAMPING = 411,
    XCN_OID_QC_EU_COMPLIANCE = 412,
    XCN_OID_QC_SSCD = 413,
    XCN_OID_QC_STATEMENTS_EXT = 414,
    XCN_OID_RDN_TPM_MANUFACTURER = 415,
    XCN_OID_RDN_TPM_MODEL = 416,
    XCN_OID_RDN_TPM_VERSION = 417,
    XCN_OID_REVOKED_LIST_SIGNER = 418,
    XCN_OID_RFC3161_counterSign = 419,
    XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_CA_REVOCATION = 420,
    XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_END_REVOCATION = 421,
    XCN_OID_ROOT_PROGRAM_FLAGS = 422,
    XCN_OID_ROOT_PROGRAM_NO_OCSP_FAILOVER_TO_CRL = 423,
    XCN_OID_RSA_PSPECIFIED = 424,
    XCN_OID_RSAES_OAEP = 425,
    XCN_OID_SUBJECT_INFO_ACCESS = 426,
    XCN_OID_TIMESTAMP_TOKEN = 427,
    XCN_OID_ENROLL_SCEP_ERROR = 428,
    XCN_OIDVerisign_MessageType = 429,
    XCN_OIDVerisign_PkiStatus = 430,
    XCN_OIDVerisign_FailInfo = 431,
    XCN_OIDVerisign_SenderNonce = 432,
    XCN_OIDVerisign_RecipientNonce = 433,
    XCN_OIDVerisign_TransactionID = 434,
    XCN_OID_ENROLL_ATTESTATION_CHALLENGE = 435,
    XCN_OID_ENROLL_ATTESTATION_STATEMENT = 436,
    XCN_OID_ENROLL_ENCRYPTION_ALGORITHM = 437,
    XCN_OID_ENROLL_KSP_NAME = 438,
}

enum WebSecurityLevel
{
    LevelUnsafe = 0,
    LevelSafe = 1,
}

enum EncodingType
{
    XCN_CRYPT_STRING_BASE64HEADER = 0,
    XCN_CRYPT_STRING_BASE64 = 1,
    XCN_CRYPT_STRING_BINARY = 2,
    XCN_CRYPT_STRING_BASE64REQUESTHEADER = 3,
    XCN_CRYPT_STRING_HEX = 4,
    XCN_CRYPT_STRING_HEXASCII = 5,
    XCN_CRYPT_STRING_BASE64_ANY = 6,
    XCN_CRYPT_STRING_ANY = 7,
    XCN_CRYPT_STRING_HEX_ANY = 8,
    XCN_CRYPT_STRING_BASE64X509CRLHEADER = 9,
    XCN_CRYPT_STRING_HEXADDR = 10,
    XCN_CRYPT_STRING_HEXASCIIADDR = 11,
    XCN_CRYPT_STRING_HEXRAW = 12,
    XCN_CRYPT_STRING_BASE64URI = 13,
    XCN_CRYPT_STRING_ENCODEMASK = 255,
    XCN_CRYPT_STRING_CHAIN = 256,
    XCN_CRYPT_STRING_TEXT = 512,
    XCN_CRYPT_STRING_PERCENTESCAPE = 134217728,
    XCN_CRYPT_STRING_HASHDATA = 268435456,
    XCN_CRYPT_STRING_STRICT = 536870912,
    XCN_CRYPT_STRING_NOCRLF = 1073741824,
    XCN_CRYPT_STRING_NOCR = -2147483648,
}

enum PFXExportOptions
{
    PFXExportEEOnly = 0,
    PFXExportChainNoRoot = 1,
    PFXExportChainWithRoot = 2,
}

enum ObjectIdGroupId
{
    XCN_CRYPT_ANY_GROUP_ID = 0,
    XCN_CRYPT_HASH_ALG_OID_GROUP_ID = 1,
    XCN_CRYPT_ENCRYPT_ALG_OID_GROUP_ID = 2,
    XCN_CRYPT_PUBKEY_ALG_OID_GROUP_ID = 3,
    XCN_CRYPT_SIGN_ALG_OID_GROUP_ID = 4,
    XCN_CRYPT_RDN_ATTR_OID_GROUP_ID = 5,
    XCN_CRYPT_EXT_OR_ATTR_OID_GROUP_ID = 6,
    XCN_CRYPT_ENHKEY_USAGE_OID_GROUP_ID = 7,
    XCN_CRYPT_POLICY_OID_GROUP_ID = 8,
    XCN_CRYPT_TEMPLATE_OID_GROUP_ID = 9,
    XCN_CRYPT_KDF_OID_GROUP_ID = 10,
    XCN_CRYPT_LAST_OID_GROUP_ID = 10,
    XCN_CRYPT_FIRST_ALG_OID_GROUP_ID = 1,
    XCN_CRYPT_LAST_ALG_OID_GROUP_ID = 4,
    XCN_CRYPT_GROUP_ID_MASK = 65535,
    XCN_CRYPT_OID_PREFER_CNG_ALGID_FLAG = 1073741824,
    XCN_CRYPT_OID_DISABLE_SEARCH_DS_FLAG = -2147483648,
    XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_MASK = 268369920,
    XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_SHIFT = 16,
    XCN_CRYPT_KEY_LENGTH_MASK = 268369920,
}

enum ObjectIdPublicKeyFlags
{
    XCN_CRYPT_OID_INFO_PUBKEY_ANY = 0,
    XCN_CRYPT_OID_INFO_PUBKEY_SIGN_KEY_FLAG = -2147483648,
    XCN_CRYPT_OID_INFO_PUBKEY_ENCRYPT_KEY_FLAG = 1073741824,
}

enum AlgorithmFlags
{
    AlgorithmFlagsNone = 0,
    AlgorithmFlagsWrap = 1,
}

const GUID IID_IObjectId = {0x728AB300, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB300, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IObjectId : IDispatch
{
    HRESULT InitializeFromName(CERTENROLL_OBJECTID Name);
    HRESULT InitializeFromValue(BSTR strValue);
    HRESULT InitializeFromAlgorithmName(ObjectIdGroupId GroupId, ObjectIdPublicKeyFlags KeyFlags, AlgorithmFlags AlgFlags, BSTR strAlgorithmName);
    HRESULT get_Name(CERTENROLL_OBJECTID* pValue);
    HRESULT get_FriendlyName(BSTR* pValue);
    HRESULT put_FriendlyName(BSTR Value);
    HRESULT get_Value(BSTR* pValue);
    HRESULT GetAlgorithmName(ObjectIdGroupId GroupId, ObjectIdPublicKeyFlags KeyFlags, BSTR* pstrAlgorithmName);
}

const GUID IID_IObjectIds = {0x728AB301, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB301, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IObjectIds : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IObjectId* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IObjectId pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT AddRange(IObjectIds pValue);
}

const GUID IID_IBinaryConverter = {0x728AB302, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB302, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IBinaryConverter : IDispatch
{
    HRESULT StringToString(BSTR strEncodedIn, EncodingType EncodingIn, EncodingType Encoding, BSTR* pstrEncoded);
    HRESULT VariantByteArrayToString(VARIANT* pvarByteArray, EncodingType Encoding, BSTR* pstrEncoded);
    HRESULT StringToVariantByteArray(BSTR strEncoded, EncodingType Encoding, VARIANT* pvarByteArray);
}

const GUID IID_IBinaryConverter2 = {0x8D7928B4, 0x4E17, 0x428D, [0x9A, 0x17, 0x72, 0x8D, 0xF0, 0x0D, 0x1B, 0x2B]};
@GUID(0x8D7928B4, 0x4E17, 0x428D, [0x9A, 0x17, 0x72, 0x8D, 0xF0, 0x0D, 0x1B, 0x2B]);
interface IBinaryConverter2 : IBinaryConverter
{
    HRESULT StringArrayToVariantArray(VARIANT* pvarStringArray, VARIANT* pvarVariantArray);
    HRESULT VariantArrayToStringArray(VARIANT* pvarVariantArray, VARIANT* pvarStringArray);
}

enum X500NameFlags
{
    XCN_CERT_NAME_STR_NONE = 0,
    XCN_CERT_SIMPLE_NAME_STR = 1,
    XCN_CERT_OID_NAME_STR = 2,
    XCN_CERT_X500_NAME_STR = 3,
    XCN_CERT_XML_NAME_STR = 4,
    XCN_CERT_NAME_STR_SEMICOLON_FLAG = 1073741824,
    XCN_CERT_NAME_STR_NO_PLUS_FLAG = 536870912,
    XCN_CERT_NAME_STR_NO_QUOTING_FLAG = 268435456,
    XCN_CERT_NAME_STR_CRLF_FLAG = 134217728,
    XCN_CERT_NAME_STR_COMMA_FLAG = 67108864,
    XCN_CERT_NAME_STR_REVERSE_FLAG = 33554432,
    XCN_CERT_NAME_STR_FORWARD_FLAG = 16777216,
    XCN_CERT_NAME_STR_AMBIGUOUS_SEPARATOR_FLAGS = 1275068416,
    XCN_CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG = 65536,
    XCN_CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG = 131072,
    XCN_CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG = 262144,
    XCN_CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG = 524288,
    XCN_CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG = 1048576,
    XCN_CERT_NAME_STR_ENABLE_PUNYCODE_FLAG = 2097152,
    XCN_CERT_NAME_STR_DS_ESCAPED = 8388608,
}

const GUID IID_IX500DistinguishedName = {0x728AB303, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB303, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX500DistinguishedName : IDispatch
{
    HRESULT Decode(BSTR strEncodedName, EncodingType Encoding, X500NameFlags NameFlags);
    HRESULT Encode(BSTR strName, X500NameFlags NameFlags);
    HRESULT get_Name(BSTR* pValue);
    HRESULT get_EncodedName(EncodingType Encoding, BSTR* pValue);
}

enum X509CertificateEnrollmentContext
{
    ContextNone = 0,
    ContextUser = 1,
    ContextMachine = 2,
    ContextAdministratorForceMachine = 3,
}

enum EnrollmentEnrollStatus
{
    Enrolled = 1,
    EnrollPended = 2,
    EnrollUIDeferredEnrollmentRequired = 4,
    EnrollError = 16,
    EnrollUnknown = 32,
    EnrollSkipped = 64,
    EnrollDenied = 256,
}

enum EnrollmentSelectionStatus
{
    SelectedNo = 0,
    SelectedYes = 1,
}

enum EnrollmentDisplayStatus
{
    DisplayNo = 0,
    DisplayYes = 1,
}

const GUID IID_IX509EnrollmentStatus = {0x728AB304, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB304, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509EnrollmentStatus : IDispatch
{
    HRESULT AppendText(BSTR strText);
    HRESULT get_Text(BSTR* pValue);
    HRESULT put_Text(BSTR Value);
    HRESULT get_Selected(EnrollmentSelectionStatus* pValue);
    HRESULT put_Selected(EnrollmentSelectionStatus Value);
    HRESULT get_Display(EnrollmentDisplayStatus* pValue);
    HRESULT put_Display(EnrollmentDisplayStatus Value);
    HRESULT get_Status(EnrollmentEnrollStatus* pValue);
    HRESULT put_Status(EnrollmentEnrollStatus Value);
    HRESULT get_Error(int* pValue);
    HRESULT put_Error(HRESULT Value);
    HRESULT get_ErrorText(BSTR* pValue);
}

enum X509ProviderType
{
    XCN_PROV_NONE = 0,
    XCN_PROV_RSA_FULL = 1,
    XCN_PROV_RSA_SIG = 2,
    XCN_PROV_DSS = 3,
    XCN_PROV_FORTEZZA = 4,
    XCN_PROV_MS_EXCHANGE = 5,
    XCN_PROV_SSL = 6,
    XCN_PROV_RSA_SCHANNEL = 12,
    XCN_PROV_DSS_DH = 13,
    XCN_PROV_EC_ECDSA_SIG = 14,
    XCN_PROV_EC_ECNRA_SIG = 15,
    XCN_PROV_EC_ECDSA_FULL = 16,
    XCN_PROV_EC_ECNRA_FULL = 17,
    XCN_PROV_DH_SCHANNEL = 18,
    XCN_PROV_SPYRUS_LYNKS = 20,
    XCN_PROV_RNG = 21,
    XCN_PROV_INTEL_SEC = 22,
    XCN_PROV_REPLACE_OWF = 23,
    XCN_PROV_RSA_AES = 24,
}

enum AlgorithmType
{
    XCN_BCRYPT_UNKNOWN_INTERFACE = 0,
    XCN_BCRYPT_CIPHER_INTERFACE = 1,
    XCN_BCRYPT_HASH_INTERFACE = 2,
    XCN_BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE = 3,
    XCN_BCRYPT_SIGNATURE_INTERFACE = 5,
    XCN_BCRYPT_SECRET_AGREEMENT_INTERFACE = 4,
    XCN_BCRYPT_RNG_INTERFACE = 6,
    XCN_BCRYPT_KEY_DERIVATION_INTERFACE = 7,
}

enum AlgorithmOperationFlags
{
    XCN_NCRYPT_NO_OPERATION = 0,
    XCN_NCRYPT_CIPHER_OPERATION = 1,
    XCN_NCRYPT_HASH_OPERATION = 2,
    XCN_NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION = 4,
    XCN_NCRYPT_SECRET_AGREEMENT_OPERATION = 8,
    XCN_NCRYPT_SIGNATURE_OPERATION = 16,
    XCN_NCRYPT_RNG_OPERATION = 32,
    XCN_NCRYPT_KEY_DERIVATION_OPERATION = 64,
    XCN_NCRYPT_ANY_ASYMMETRIC_OPERATION = 28,
    XCN_NCRYPT_PREFER_SIGNATURE_ONLY_OPERATION = 2097152,
    XCN_NCRYPT_PREFER_NON_SIGNATURE_OPERATION = 4194304,
    XCN_NCRYPT_EXACT_MATCH_OPERATION = 8388608,
    XCN_NCRYPT_PREFERENCE_MASK_OPERATION = 14680064,
}

const GUID IID_ICspAlgorithm = {0x728AB305, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB305, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICspAlgorithm : IDispatch
{
    HRESULT GetAlgorithmOid(int Length, AlgorithmFlags AlgFlags, IObjectId* ppValue);
    HRESULT get_DefaultLength(int* pValue);
    HRESULT get_IncrementLength(int* pValue);
    HRESULT get_LongName(BSTR* pValue);
    HRESULT get_Valid(short* pValue);
    HRESULT get_MaxLength(int* pValue);
    HRESULT get_MinLength(int* pValue);
    HRESULT get_Name(BSTR* pValue);
    HRESULT get_Type(AlgorithmType* pValue);
    HRESULT get_Operations(AlgorithmOperationFlags* pValue);
}

const GUID IID_ICspAlgorithms = {0x728AB306, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB306, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICspAlgorithms : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICspAlgorithm* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICspAlgorithm pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_ItemByName(BSTR strName, ICspAlgorithm* ppValue);
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
}

enum X509KeySpec
{
    XCN_AT_NONE = 0,
    XCN_AT_KEYEXCHANGE = 1,
    XCN_AT_SIGNATURE = 2,
}

const GUID IID_ICspInformation = {0x728AB307, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB307, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICspInformation : IDispatch
{
    HRESULT InitializeFromName(BSTR strName);
    HRESULT InitializeFromType(X509ProviderType Type, IObjectId pAlgorithm, short MachineContext);
    HRESULT get_CspAlgorithms(ICspAlgorithms* ppValue);
    HRESULT get_HasHardwareRandomNumberGenerator(short* pValue);
    HRESULT get_IsHardwareDevice(short* pValue);
    HRESULT get_IsRemovable(short* pValue);
    HRESULT get_IsSoftwareDevice(short* pValue);
    HRESULT get_Valid(short* pValue);
    HRESULT get_MaxKeyContainerNameLength(int* pValue);
    HRESULT get_Name(BSTR* pValue);
    HRESULT get_Type(X509ProviderType* pValue);
    HRESULT get_Version(int* pValue);
    HRESULT get_KeySpec(X509KeySpec* pValue);
    HRESULT get_IsSmartCard(short* pValue);
    HRESULT GetDefaultSecurityDescriptor(short MachineContext, BSTR* pValue);
    HRESULT get_LegacyCsp(short* pValue);
    HRESULT GetCspStatusFromOperations(IObjectId pAlgorithm, AlgorithmOperationFlags Operations, ICspStatus* ppValue);
}

const GUID IID_ICspInformations = {0x728AB308, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB308, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICspInformations : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICspInformation* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICspInformation pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT AddAvailableCsps();
    HRESULT get_ItemByName(BSTR strName, ICspInformation* ppCspInformation);
    HRESULT GetCspStatusFromProviderName(BSTR strProviderName, X509KeySpec LegacyKeySpec, ICspStatus* ppValue);
    HRESULT GetCspStatusesFromOperations(AlgorithmOperationFlags Operations, ICspInformation pCspInformation, ICspStatuses* ppValue);
    HRESULT GetEncryptionCspAlgorithms(ICspInformation pCspInformation, ICspAlgorithms* ppValue);
    HRESULT GetHashAlgorithms(ICspInformation pCspInformation, IObjectIds* ppValue);
}

const GUID IID_ICspStatus = {0x728AB309, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB309, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICspStatus : IDispatch
{
    HRESULT Initialize(ICspInformation pCsp, ICspAlgorithm pAlgorithm);
    HRESULT get_Ordinal(int* pValue);
    HRESULT put_Ordinal(int Value);
    HRESULT get_CspAlgorithm(ICspAlgorithm* ppValue);
    HRESULT get_CspInformation(ICspInformation* ppValue);
    HRESULT get_EnrollmentStatus(IX509EnrollmentStatus* ppValue);
    HRESULT get_DisplayName(BSTR* pValue);
}

const GUID IID_ICspStatuses = {0x728AB30A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB30A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICspStatuses : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICspStatus* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICspStatus pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_ItemByName(BSTR strCspName, BSTR strAlgorithmName, ICspStatus* ppValue);
    HRESULT get_ItemByOrdinal(int Ordinal, ICspStatus* ppValue);
    HRESULT get_ItemByOperations(BSTR strCspName, BSTR strAlgorithmName, AlgorithmOperationFlags Operations, ICspStatus* ppValue);
    HRESULT get_ItemByProvider(ICspStatus pCspStatus, ICspStatus* ppValue);
}

enum KeyIdentifierHashAlgorithm
{
    SKIHashDefault = 0,
    SKIHashSha1 = 1,
    SKIHashCapiSha1 = 2,
    SKIHashSha256 = 3,
    SKIHashHPKP = 5,
}

const GUID IID_IX509PublicKey = {0x728AB30B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB30B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509PublicKey : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, BSTR strEncodedKey, BSTR strEncodedParameters, EncodingType Encoding);
    HRESULT InitializeFromEncodedPublicKeyInfo(BSTR strEncodedPublicKeyInfo, EncodingType Encoding);
    HRESULT get_Algorithm(IObjectId* ppValue);
    HRESULT get_Length(int* pValue);
    HRESULT get_EncodedKey(EncodingType Encoding, BSTR* pValue);
    HRESULT get_EncodedParameters(EncodingType Encoding, BSTR* pValue);
    HRESULT ComputeKeyIdentifier(KeyIdentifierHashAlgorithm Algorithm, EncodingType Encoding, BSTR* pValue);
}

enum X509PrivateKeyExportFlags
{
    XCN_NCRYPT_ALLOW_EXPORT_NONE = 0,
    XCN_NCRYPT_ALLOW_EXPORT_FLAG = 1,
    XCN_NCRYPT_ALLOW_PLAINTEXT_EXPORT_FLAG = 2,
    XCN_NCRYPT_ALLOW_ARCHIVING_FLAG = 4,
    XCN_NCRYPT_ALLOW_PLAINTEXT_ARCHIVING_FLAG = 8,
}

enum X509PrivateKeyUsageFlags
{
    XCN_NCRYPT_ALLOW_USAGES_NONE = 0,
    XCN_NCRYPT_ALLOW_DECRYPT_FLAG = 1,
    XCN_NCRYPT_ALLOW_SIGNING_FLAG = 2,
    XCN_NCRYPT_ALLOW_KEY_AGREEMENT_FLAG = 4,
    XCN_NCRYPT_ALLOW_KEY_IMPORT_FLAG = 8,
    XCN_NCRYPT_ALLOW_ALL_USAGES = 16777215,
}

enum X509PrivateKeyProtection
{
    XCN_NCRYPT_UI_NO_PROTECTION_FLAG = 0,
    XCN_NCRYPT_UI_PROTECT_KEY_FLAG = 1,
    XCN_NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG = 2,
    XCN_NCRYPT_UI_FINGERPRINT_PROTECTION_FLAG = 4,
    XCN_NCRYPT_UI_APPCONTAINER_ACCESS_MEDIUM_FLAG = 8,
}

enum X509PrivateKeyVerify
{
    VerifyNone = 0,
    VerifySilent = 1,
    VerifySmartCardNone = 2,
    VerifySmartCardSilent = 3,
    VerifyAllowUI = 4,
}

const GUID IID_IX509PrivateKey = {0x728AB30C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB30C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509PrivateKey : IDispatch
{
    HRESULT Open();
    HRESULT Create();
    HRESULT Close();
    HRESULT Delete();
    HRESULT Verify(X509PrivateKeyVerify VerifyType);
    HRESULT Import(BSTR strExportType, BSTR strEncodedKey, EncodingType Encoding);
    HRESULT Export(BSTR strExportType, EncodingType Encoding, BSTR* pstrEncodedKey);
    HRESULT ExportPublicKey(IX509PublicKey* ppPublicKey);
    HRESULT get_ContainerName(BSTR* pValue);
    HRESULT put_ContainerName(BSTR Value);
    HRESULT get_ContainerNamePrefix(BSTR* pValue);
    HRESULT put_ContainerNamePrefix(BSTR Value);
    HRESULT get_ReaderName(BSTR* pValue);
    HRESULT put_ReaderName(BSTR Value);
    HRESULT get_CspInformations(ICspInformations* ppValue);
    HRESULT put_CspInformations(ICspInformations pValue);
    HRESULT get_CspStatus(ICspStatus* ppValue);
    HRESULT put_CspStatus(ICspStatus pValue);
    HRESULT get_ProviderName(BSTR* pValue);
    HRESULT put_ProviderName(BSTR Value);
    HRESULT get_ProviderType(X509ProviderType* pValue);
    HRESULT put_ProviderType(X509ProviderType Value);
    HRESULT get_LegacyCsp(short* pValue);
    HRESULT put_LegacyCsp(short Value);
    HRESULT get_Algorithm(IObjectId* ppValue);
    HRESULT put_Algorithm(IObjectId pValue);
    HRESULT get_KeySpec(X509KeySpec* pValue);
    HRESULT put_KeySpec(X509KeySpec Value);
    HRESULT get_Length(int* pValue);
    HRESULT put_Length(int Value);
    HRESULT get_ExportPolicy(X509PrivateKeyExportFlags* pValue);
    HRESULT put_ExportPolicy(X509PrivateKeyExportFlags Value);
    HRESULT get_KeyUsage(X509PrivateKeyUsageFlags* pValue);
    HRESULT put_KeyUsage(X509PrivateKeyUsageFlags Value);
    HRESULT get_KeyProtection(X509PrivateKeyProtection* pValue);
    HRESULT put_KeyProtection(X509PrivateKeyProtection Value);
    HRESULT get_MachineContext(short* pValue);
    HRESULT put_MachineContext(short Value);
    HRESULT get_SecurityDescriptor(BSTR* pValue);
    HRESULT put_SecurityDescriptor(BSTR Value);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_Certificate(EncodingType Encoding, BSTR Value);
    HRESULT get_UniqueContainerName(BSTR* pValue);
    HRESULT get_Opened(short* pValue);
    HRESULT get_DefaultContainer(short* pValue);
    HRESULT get_Existing(short* pValue);
    HRESULT put_Existing(short Value);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_UIContextMessage(BSTR* pValue);
    HRESULT put_UIContextMessage(BSTR Value);
    HRESULT put_Pin(BSTR Value);
    HRESULT get_FriendlyName(BSTR* pValue);
    HRESULT put_FriendlyName(BSTR Value);
    HRESULT get_Description(BSTR* pValue);
    HRESULT put_Description(BSTR Value);
}

enum X509HardwareKeyUsageFlags
{
    XCN_NCRYPT_PCP_NONE = 0,
    XCN_NCRYPT_TPM12_PROVIDER = 65536,
    XCN_NCRYPT_PCP_SIGNATURE_KEY = 1,
    XCN_NCRYPT_PCP_ENCRYPTION_KEY = 2,
    XCN_NCRYPT_PCP_GENERIC_KEY = 3,
    XCN_NCRYPT_PCP_STORAGE_KEY = 4,
    XCN_NCRYPT_PCP_IDENTITY_KEY = 8,
}

enum X509KeyParametersExportType
{
    XCN_CRYPT_OID_USE_CURVE_NONE = 0,
    XCN_CRYPT_OID_USE_CURVE_NAME_FOR_ENCODE_FLAG = 536870912,
    XCN_CRYPT_OID_USE_CURVE_PARAMETERS_FOR_ENCODE_FLAG = 268435456,
}

const GUID IID_IX509PrivateKey2 = {0x728AB362, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB362, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509PrivateKey2 : IX509PrivateKey
{
    HRESULT get_HardwareKeyUsage(X509HardwareKeyUsageFlags* pValue);
    HRESULT put_HardwareKeyUsage(X509HardwareKeyUsageFlags Value);
    HRESULT get_AlternateStorageLocation(BSTR* pValue);
    HRESULT put_AlternateStorageLocation(BSTR Value);
    HRESULT get_AlgorithmName(BSTR* pValue);
    HRESULT put_AlgorithmName(BSTR Value);
    HRESULT get_AlgorithmParameters(EncodingType Encoding, BSTR* pValue);
    HRESULT put_AlgorithmParameters(EncodingType Encoding, BSTR Value);
    HRESULT get_ParametersExportType(X509KeyParametersExportType* pValue);
    HRESULT put_ParametersExportType(X509KeyParametersExportType Value);
}

const GUID IID_IX509EndorsementKey = {0xB11CD855, 0xF4C4, 0x4FC6, [0xB7, 0x10, 0x44, 0x22, 0x23, 0x7F, 0x09, 0xE9]};
@GUID(0xB11CD855, 0xF4C4, 0x4FC6, [0xB7, 0x10, 0x44, 0x22, 0x23, 0x7F, 0x09, 0xE9]);
interface IX509EndorsementKey : IDispatch
{
    HRESULT get_ProviderName(BSTR* pValue);
    HRESULT put_ProviderName(BSTR Value);
    HRESULT get_Length(int* pValue);
    HRESULT get_Opened(short* pValue);
    HRESULT AddCertificate(EncodingType Encoding, BSTR strCertificate);
    HRESULT RemoveCertificate(EncodingType Encoding, BSTR strCertificate);
    HRESULT GetCertificateByIndex(short ManufacturerOnly, int dwIndex, EncodingType Encoding, BSTR* pValue);
    HRESULT GetCertificateCount(short ManufacturerOnly, int* pCount);
    HRESULT ExportPublicKey(IX509PublicKey* ppPublicKey);
    HRESULT Open();
    HRESULT Close();
}

const GUID IID_IX509Extension = {0x728AB30D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB30D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509Extension : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Critical(short* pValue);
    HRESULT put_Critical(short Value);
}

const GUID IID_IX509Extensions = {0x728AB30E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB30E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509Extensions : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509Extension* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509Extension pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
    HRESULT AddRange(IX509Extensions pValue);
}

enum X509KeyUsageFlags
{
    XCN_CERT_NO_KEY_USAGE = 0,
    XCN_CERT_DIGITAL_SIGNATURE_KEY_USAGE = 128,
    XCN_CERT_NON_REPUDIATION_KEY_USAGE = 64,
    XCN_CERT_KEY_ENCIPHERMENT_KEY_USAGE = 32,
    XCN_CERT_DATA_ENCIPHERMENT_KEY_USAGE = 16,
    XCN_CERT_KEY_AGREEMENT_KEY_USAGE = 8,
    XCN_CERT_KEY_CERT_SIGN_KEY_USAGE = 4,
    XCN_CERT_OFFLINE_CRL_SIGN_KEY_USAGE = 2,
    XCN_CERT_CRL_SIGN_KEY_USAGE = 2,
    XCN_CERT_ENCIPHER_ONLY_KEY_USAGE = 1,
    XCN_CERT_DECIPHER_ONLY_KEY_USAGE = 32768,
}

const GUID IID_IX509ExtensionKeyUsage = {0x728AB30F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB30F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionKeyUsage : IX509Extension
{
    HRESULT InitializeEncode(X509KeyUsageFlags UsageFlags);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_KeyUsage(X509KeyUsageFlags* pValue);
}

const GUID IID_IX509ExtensionEnhancedKeyUsage = {0x728AB310, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB310, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionEnhancedKeyUsage : IX509Extension
{
    HRESULT InitializeEncode(IObjectIds pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_EnhancedKeyUsage(IObjectIds* ppValue);
}

const GUID IID_IX509ExtensionTemplateName = {0x728AB311, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB311, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionTemplateName : IX509Extension
{
    HRESULT InitializeEncode(BSTR strTemplateName);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_TemplateName(BSTR* pValue);
}

const GUID IID_IX509ExtensionTemplate = {0x728AB312, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB312, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionTemplate : IX509Extension
{
    HRESULT InitializeEncode(IObjectId pTemplateOid, int MajorVersion, int MinorVersion);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_TemplateOid(IObjectId* ppValue);
    HRESULT get_MajorVersion(int* pValue);
    HRESULT get_MinorVersion(int* pValue);
}

enum AlternativeNameType
{
    XCN_CERT_ALT_NAME_UNKNOWN = 0,
    XCN_CERT_ALT_NAME_OTHER_NAME = 1,
    XCN_CERT_ALT_NAME_RFC822_NAME = 2,
    XCN_CERT_ALT_NAME_DNS_NAME = 3,
    XCN_CERT_ALT_NAME_X400_ADDRESS = 4,
    XCN_CERT_ALT_NAME_DIRECTORY_NAME = 5,
    XCN_CERT_ALT_NAME_EDI_PARTY_NAME = 6,
    XCN_CERT_ALT_NAME_URL = 7,
    XCN_CERT_ALT_NAME_IP_ADDRESS = 8,
    XCN_CERT_ALT_NAME_REGISTERED_ID = 9,
    XCN_CERT_ALT_NAME_GUID = 10,
    XCN_CERT_ALT_NAME_USER_PRINCIPLE_NAME = 11,
}

const GUID IID_IAlternativeName = {0x728AB313, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB313, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IAlternativeName : IDispatch
{
    HRESULT InitializeFromString(AlternativeNameType Type, BSTR strValue);
    HRESULT InitializeFromRawData(AlternativeNameType Type, EncodingType Encoding, BSTR strRawData);
    HRESULT InitializeFromOtherName(IObjectId pObjectId, EncodingType Encoding, BSTR strRawData, short ToBeWrapped);
    HRESULT get_Type(AlternativeNameType* pValue);
    HRESULT get_StrValue(BSTR* pValue);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_IAlternativeNames = {0x728AB314, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB314, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IAlternativeNames : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IAlternativeName* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IAlternativeName pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

const GUID IID_IX509ExtensionAlternativeNames = {0x728AB315, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB315, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionAlternativeNames : IX509Extension
{
    HRESULT InitializeEncode(IAlternativeNames pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_AlternativeNames(IAlternativeNames* ppValue);
}

const GUID IID_IX509ExtensionBasicConstraints = {0x728AB316, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB316, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionBasicConstraints : IX509Extension
{
    HRESULT InitializeEncode(short IsCA, int PathLenConstraint);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_IsCA(short* pValue);
    HRESULT get_PathLenConstraint(int* pValue);
}

const GUID IID_IX509ExtensionSubjectKeyIdentifier = {0x728AB317, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB317, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionSubjectKeyIdentifier : IX509Extension
{
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strKeyIdentifier);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_SubjectKeyIdentifier(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_IX509ExtensionAuthorityKeyIdentifier = {0x728AB318, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB318, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionAuthorityKeyIdentifier : IX509Extension
{
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strKeyIdentifier);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_AuthorityKeyIdentifier(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_ISmimeCapability = {0x728AB319, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB319, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ISmimeCapability : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, int BitCount);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_BitCount(int* pValue);
}

const GUID IID_ISmimeCapabilities = {0x728AB31A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB31A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ISmimeCapabilities : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ISmimeCapability* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ISmimeCapability pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT AddFromCsp(ICspInformation pValue);
    HRESULT AddAvailableSmimeCapabilities(short MachineContext);
}

const GUID IID_IX509ExtensionSmimeCapabilities = {0x728AB31B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB31B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionSmimeCapabilities : IX509Extension
{
    HRESULT InitializeEncode(ISmimeCapabilities pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_SmimeCapabilities(ISmimeCapabilities* ppValue);
}

enum PolicyQualifierType
{
    PolicyQualifierTypeUnknown = 0,
    PolicyQualifierTypeUrl = 1,
    PolicyQualifierTypeUserNotice = 2,
    PolicyQualifierTypeFlags = 3,
}

const GUID IID_IPolicyQualifier = {0x728AB31C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB31C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IPolicyQualifier : IDispatch
{
    HRESULT InitializeEncode(BSTR strQualifier, PolicyQualifierType Type);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_Qualifier(BSTR* pValue);
    HRESULT get_Type(PolicyQualifierType* pValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_IPolicyQualifiers = {0x728AB31D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB31D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IPolicyQualifiers : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IPolicyQualifier* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IPolicyQualifier pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

const GUID IID_ICertificatePolicy = {0x728AB31E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB31E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertificatePolicy : IDispatch
{
    HRESULT Initialize(IObjectId pValue);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_PolicyQualifiers(IPolicyQualifiers* ppValue);
}

const GUID IID_ICertificatePolicies = {0x728AB31F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB31F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertificatePolicies : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICertificatePolicy* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICertificatePolicy pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

const GUID IID_IX509ExtensionCertificatePolicies = {0x728AB320, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB320, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionCertificatePolicies : IX509Extension
{
    HRESULT InitializeEncode(ICertificatePolicies pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_Policies(ICertificatePolicies* ppValue);
}

const GUID IID_IX509ExtensionMSApplicationPolicies = {0x728AB321, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB321, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509ExtensionMSApplicationPolicies : IX509Extension
{
    HRESULT InitializeEncode(ICertificatePolicies pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_Policies(ICertificatePolicies* ppValue);
}

const GUID IID_IX509Attribute = {0x728AB322, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB322, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509Attribute : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_IX509Attributes = {0x728AB323, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB323, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509Attributes : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509Attribute* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509Attribute pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

const GUID IID_IX509AttributeExtensions = {0x728AB324, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB324, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509AttributeExtensions : IX509Attribute
{
    HRESULT InitializeEncode(IX509Extensions pExtensions);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
}

enum RequestClientInfoClientId
{
    ClientIdNone = 0,
    ClientIdXEnroll2003 = 1,
    ClientIdAutoEnroll2003 = 2,
    ClientIdWizard2003 = 3,
    ClientIdCertReq2003 = 4,
    ClientIdDefaultRequest = 5,
    ClientIdAutoEnroll = 6,
    ClientIdRequestWizard = 7,
    ClientIdEOBO = 8,
    ClientIdCertReq = 9,
    ClientIdTest = 10,
    ClientIdWinRT = 11,
    ClientIdUserStart = 1000,
}

const GUID IID_IX509AttributeClientId = {0x728AB325, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB325, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509AttributeClientId : IX509Attribute
{
    HRESULT InitializeEncode(RequestClientInfoClientId ClientId, BSTR strMachineDnsName, BSTR strUserSamName, BSTR strProcessName);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_ClientId(RequestClientInfoClientId* pValue);
    HRESULT get_MachineDnsName(BSTR* pValue);
    HRESULT get_UserSamName(BSTR* pValue);
    HRESULT get_ProcessName(BSTR* pValue);
}

const GUID IID_IX509AttributeRenewalCertificate = {0x728AB326, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB326, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509AttributeRenewalCertificate : IX509Attribute
{
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strCert);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_RenewalCertificate(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_IX509AttributeArchiveKey = {0x728AB327, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB327, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509AttributeArchiveKey : IX509Attribute
{
    HRESULT InitializeEncode(IX509PrivateKey pKey, EncodingType Encoding, BSTR strCAXCert, IObjectId pAlgorithm, int EncryptionStrength);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_EncryptedKeyBlob(EncodingType Encoding, BSTR* pValue);
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    HRESULT get_EncryptionStrength(int* pValue);
}

const GUID IID_IX509AttributeArchiveKeyHash = {0x728AB328, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB328, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509AttributeArchiveKeyHash : IX509Attribute
{
    HRESULT InitializeEncodeFromEncryptedKeyBlob(EncodingType Encoding, BSTR strEncryptedKeyBlob);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_EncryptedKeyHashBlob(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_IX509AttributeOSVersion = {0x728AB32A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB32A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509AttributeOSVersion : IX509Attribute
{
    HRESULT InitializeEncode(BSTR strOSVersion);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_OSVersion(BSTR* pValue);
}

const GUID IID_IX509AttributeCspProvider = {0x728AB32B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB32B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509AttributeCspProvider : IX509Attribute
{
    HRESULT InitializeEncode(X509KeySpec KeySpec, BSTR strProviderName, EncodingType Encoding, BSTR strSignature);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_KeySpec(X509KeySpec* pValue);
    HRESULT get_ProviderName(BSTR* pValue);
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_ICryptAttribute = {0x728AB32C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB32C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICryptAttribute : IDispatch
{
    HRESULT InitializeFromObjectId(IObjectId pObjectId);
    HRESULT InitializeFromValues(IX509Attributes pAttributes);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_Values(IX509Attributes* ppValue);
}

const GUID IID_ICryptAttributes = {0x728AB32D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB32D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICryptAttributes : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICryptAttribute* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICryptAttribute pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
    HRESULT AddRange(ICryptAttributes pValue);
}

enum CERTENROLL_PROPERTYID
{
    XCN_PROPERTYID_NONE = 0,
    XCN_CERT_KEY_PROV_HANDLE_PROP_ID = 1,
    XCN_CERT_KEY_PROV_INFO_PROP_ID = 2,
    XCN_CERT_SHA1_HASH_PROP_ID = 3,
    XCN_CERT_MD5_HASH_PROP_ID = 4,
    XCN_CERT_HASH_PROP_ID = 3,
    XCN_CERT_KEY_CONTEXT_PROP_ID = 5,
    XCN_CERT_KEY_SPEC_PROP_ID = 6,
    XCN_CERT_IE30_RESERVED_PROP_ID = 7,
    XCN_CERT_PUBKEY_HASH_RESERVED_PROP_ID = 8,
    XCN_CERT_ENHKEY_USAGE_PROP_ID = 9,
    XCN_CERT_CTL_USAGE_PROP_ID = 9,
    XCN_CERT_NEXT_UPDATE_LOCATION_PROP_ID = 10,
    XCN_CERT_FRIENDLY_NAME_PROP_ID = 11,
    XCN_CERT_PVK_FILE_PROP_ID = 12,
    XCN_CERT_DESCRIPTION_PROP_ID = 13,
    XCN_CERT_ACCESS_STATE_PROP_ID = 14,
    XCN_CERT_SIGNATURE_HASH_PROP_ID = 15,
    XCN_CERT_SMART_CARD_DATA_PROP_ID = 16,
    XCN_CERT_EFS_PROP_ID = 17,
    XCN_CERT_FORTEZZA_DATA_PROP_ID = 18,
    XCN_CERT_ARCHIVED_PROP_ID = 19,
    XCN_CERT_KEY_IDENTIFIER_PROP_ID = 20,
    XCN_CERT_AUTO_ENROLL_PROP_ID = 21,
    XCN_CERT_PUBKEY_ALG_PARA_PROP_ID = 22,
    XCN_CERT_CROSS_CERT_DIST_POINTS_PROP_ID = 23,
    XCN_CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID = 24,
    XCN_CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID = 25,
    XCN_CERT_ENROLLMENT_PROP_ID = 26,
    XCN_CERT_DATE_STAMP_PROP_ID = 27,
    XCN_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID = 28,
    XCN_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID = 29,
    XCN_CERT_EXTENDED_ERROR_INFO_PROP_ID = 30,
    XCN_CERT_RENEWAL_PROP_ID = 64,
    XCN_CERT_ARCHIVED_KEY_HASH_PROP_ID = 65,
    XCN_CERT_AUTO_ENROLL_RETRY_PROP_ID = 66,
    XCN_CERT_AIA_URL_RETRIEVED_PROP_ID = 67,
    XCN_CERT_AUTHORITY_INFO_ACCESS_PROP_ID = 68,
    XCN_CERT_BACKED_UP_PROP_ID = 69,
    XCN_CERT_OCSP_RESPONSE_PROP_ID = 70,
    XCN_CERT_REQUEST_ORIGINATOR_PROP_ID = 71,
    XCN_CERT_SOURCE_LOCATION_PROP_ID = 72,
    XCN_CERT_SOURCE_URL_PROP_ID = 73,
    XCN_CERT_NEW_KEY_PROP_ID = 74,
    XCN_CERT_OCSP_CACHE_PREFIX_PROP_ID = 75,
    XCN_CERT_SMART_CARD_ROOT_INFO_PROP_ID = 76,
    XCN_CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID = 77,
    XCN_CERT_NCRYPT_KEY_HANDLE_PROP_ID = 78,
    XCN_CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID = 79,
    XCN_CERT_SUBJECT_INFO_ACCESS_PROP_ID = 80,
    XCN_CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID = 81,
    XCN_CERT_CA_DISABLE_CRL_PROP_ID = 82,
    XCN_CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID = 83,
    XCN_CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID = 84,
    XCN_CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID = 85,
    XCN_CERT_SUBJECT_DISABLE_CRL_PROP_ID = 86,
    XCN_CERT_CEP_PROP_ID = 87,
    XCN_CERT_SIGN_HASH_CNG_ALG_PROP_ID = 89,
    XCN_CERT_SCARD_PIN_ID_PROP_ID = 90,
    XCN_CERT_SCARD_PIN_INFO_PROP_ID = 91,
    XCN_CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID = 92,
    XCN_CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 93,
    XCN_CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID = 94,
    XCN_CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID = 95,
    XCN_CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 96,
    XCN_CERT_NO_EXPIRE_NOTIFICATION_PROP_ID = 97,
    XCN_CERT_AUTH_ROOT_SHA256_HASH_PROP_ID = 98,
    XCN_CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID = 99,
    XCN_CERT_HCRYPTPROV_TRANSFER_PROP_ID = 100,
    XCN_CERT_SMART_CARD_READER_PROP_ID = 101,
    XCN_CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID = 102,
    XCN_CERT_KEY_REPAIR_ATTEMPTED_PROP_ID = 103,
    XCN_CERT_DISALLOWED_FILETIME_PROP_ID = 104,
    XCN_CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID = 105,
    XCN_CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID = 106,
    XCN_CERT_SHA256_HASH_PROP_ID = 107,
    XCN_CERT_SCEP_SERVER_CERTS_PROP_ID = 108,
    XCN_CERT_SCEP_RA_SIGNATURE_CERT_PROP_ID = 109,
    XCN_CERT_SCEP_RA_ENCRYPTION_CERT_PROP_ID = 110,
    XCN_CERT_SCEP_CA_CERT_PROP_ID = 111,
    XCN_CERT_SCEP_SIGNER_CERT_PROP_ID = 112,
    XCN_CERT_SCEP_NONCE_PROP_ID = 113,
    XCN_CERT_SCEP_ENCRYPT_HASH_CNG_ALG_PROP_ID = 114,
    XCN_CERT_SCEP_FLAGS_PROP_ID = 115,
    XCN_CERT_SCEP_GUID_PROP_ID = 116,
    XCN_CERT_SERIALIZABLE_KEY_CONTEXT_PROP_ID = 117,
    XCN_CERT_ISOLATED_KEY_PROP_ID = 118,
    XCN_CERT_SERIAL_CHAIN_PROP_ID = 119,
    XCN_CERT_KEY_CLASSIFICATION_PROP_ID = 120,
    XCN_CERT_DISALLOWED_ENHKEY_USAGE_PROP_ID = 122,
    XCN_CERT_NONCOMPLIANT_ROOT_URL_PROP_ID = 123,
    XCN_CERT_PIN_SHA256_HASH_PROP_ID = 124,
    XCN_CERT_CLR_DELETE_KEY_PROP_ID = 125,
    XCN_CERT_NOT_BEFORE_FILETIME_PROP_ID = 126,
    XCN_CERT_CERT_NOT_BEFORE_ENHKEY_USAGE_PROP_ID = 127,
    XCN_CERT_FIRST_RESERVED_PROP_ID = 128,
    XCN_CERT_LAST_RESERVED_PROP_ID = 32767,
    XCN_CERT_FIRST_USER_PROP_ID = 32768,
    XCN_CERT_LAST_USER_PROP_ID = 65535,
    XCN_CERT_STORE_LOCALIZED_NAME_PROP_ID = 4096,
}

const GUID IID_ICertProperty = {0x728AB32E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB32E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertProperty : IDispatch
{
    HRESULT InitializeFromCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_PropertyId(CERTENROLL_PROPERTYID* pValue);
    HRESULT put_PropertyId(CERTENROLL_PROPERTYID Value);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    HRESULT RemoveFromCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
    HRESULT SetValueOnCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
}

const GUID IID_ICertProperties = {0x728AB32F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB32F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertProperties : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICertProperty* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICertProperty pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT InitializeFromCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
}

const GUID IID_ICertPropertyFriendlyName = {0x728AB330, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB330, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyFriendlyName : ICertProperty
{
    HRESULT Initialize(BSTR strFriendlyName);
    HRESULT get_FriendlyName(BSTR* pValue);
}

const GUID IID_ICertPropertyDescription = {0x728AB331, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB331, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyDescription : ICertProperty
{
    HRESULT Initialize(BSTR strDescription);
    HRESULT get_Description(BSTR* pValue);
}

const GUID IID_ICertPropertyAutoEnroll = {0x728AB332, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB332, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyAutoEnroll : ICertProperty
{
    HRESULT Initialize(BSTR strTemplateName);
    HRESULT get_TemplateName(BSTR* pValue);
}

const GUID IID_ICertPropertyRequestOriginator = {0x728AB333, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB333, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyRequestOriginator : ICertProperty
{
    HRESULT Initialize(BSTR strRequestOriginator);
    HRESULT InitializeFromLocalRequestOriginator();
    HRESULT get_RequestOriginator(BSTR* pValue);
}

const GUID IID_ICertPropertySHA1Hash = {0x728AB334, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB334, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertySHA1Hash : ICertProperty
{
    HRESULT Initialize(EncodingType Encoding, BSTR strRenewalValue);
    HRESULT get_SHA1Hash(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_ICertPropertyKeyProvInfo = {0x728AB336, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB336, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyKeyProvInfo : ICertProperty
{
    HRESULT Initialize(IX509PrivateKey pValue);
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
}

const GUID IID_ICertPropertyArchived = {0x728AB337, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB337, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyArchived : ICertProperty
{
    HRESULT Initialize(short ArchivedValue);
    HRESULT get_Archived(short* pValue);
}

const GUID IID_ICertPropertyBackedUp = {0x728AB338, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB338, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyBackedUp : ICertProperty
{
    HRESULT InitializeFromCurrentTime(short BackedUpValue);
    HRESULT Initialize(short BackedUpValue, double Date);
    HRESULT get_BackedUpValue(short* pValue);
    HRESULT get_BackedUpTime(double* pDate);
}

const GUID IID_ICertPropertyEnrollment = {0x728AB339, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB339, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyEnrollment : ICertProperty
{
    HRESULT Initialize(int RequestId, BSTR strCADnsName, BSTR strCAName, BSTR strFriendlyName);
    HRESULT get_RequestId(int* pValue);
    HRESULT get_CADnsName(BSTR* pValue);
    HRESULT get_CAName(BSTR* pValue);
    HRESULT get_FriendlyName(BSTR* pValue);
}

const GUID IID_ICertPropertyRenewal = {0x728AB33A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB33A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyRenewal : ICertProperty
{
    HRESULT Initialize(EncodingType Encoding, BSTR strRenewalValue);
    HRESULT InitializeFromCertificateHash(short MachineContext, EncodingType Encoding, BSTR strCertificate);
    HRESULT get_Renewal(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_ICertPropertyArchivedKeyHash = {0x728AB33B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB33B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyArchivedKeyHash : ICertProperty
{
    HRESULT Initialize(EncodingType Encoding, BSTR strArchivedKeyHashValue);
    HRESULT get_ArchivedKeyHash(EncodingType Encoding, BSTR* pValue);
}

enum EnrollmentPolicyServerPropertyFlags
{
    DefaultNone = 0,
    DefaultPolicyServer = 1,
}

enum PolicyServerUrlFlags
{
    PsfNone = 0,
    PsfLocationGroupPolicy = 1,
    PsfLocationRegistry = 2,
    PsfUseClientId = 4,
    PsfAutoEnrollmentEnabled = 16,
    PsfAllowUnTrustedCA = 32,
}

const GUID IID_ICertPropertyEnrollmentPolicyServer = {0x728AB34A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB34A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertPropertyEnrollmentPolicyServer : ICertProperty
{
    HRESULT Initialize(EnrollmentPolicyServerPropertyFlags PropertyFlags, X509EnrollmentAuthFlags AuthFlags, X509EnrollmentAuthFlags EnrollmentServerAuthFlags, PolicyServerUrlFlags UrlFlags, BSTR strRequestId, BSTR strUrl, BSTR strId, BSTR strEnrollmentServerUrl);
    HRESULT GetPolicyServerUrl(BSTR* pValue);
    HRESULT GetPolicyServerId(BSTR* pValue);
    HRESULT GetEnrollmentServerUrl(BSTR* pValue);
    HRESULT GetRequestIdString(BSTR* pValue);
    HRESULT GetPropertyFlags(EnrollmentPolicyServerPropertyFlags* pValue);
    HRESULT GetUrlFlags(PolicyServerUrlFlags* pValue);
    HRESULT GetAuthentication(X509EnrollmentAuthFlags* pValue);
    HRESULT GetEnrollmentServerAuthentication(X509EnrollmentAuthFlags* pValue);
}

const GUID IID_IX509SignatureInformation = {0x728AB33C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB33C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509SignatureInformation : IDispatch
{
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    HRESULT put_HashAlgorithm(IObjectId pValue);
    HRESULT get_PublicKeyAlgorithm(IObjectId* ppValue);
    HRESULT put_PublicKeyAlgorithm(IObjectId pValue);
    HRESULT get_Parameters(EncodingType Encoding, BSTR* pValue);
    HRESULT put_Parameters(EncodingType Encoding, BSTR Value);
    HRESULT get_AlternateSignatureAlgorithm(short* pValue);
    HRESULT put_AlternateSignatureAlgorithm(short Value);
    HRESULT get_AlternateSignatureAlgorithmSet(short* pValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT put_NullSigned(short Value);
    HRESULT GetSignatureAlgorithm(short Pkcs7Signature, short SignatureKey, IObjectId* ppValue);
    HRESULT SetDefaultValues();
}

const GUID IID_ISignerCertificate = {0x728AB33D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB33D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ISignerCertificate : IDispatch
{
    HRESULT Initialize(short MachineContext, X509PrivateKeyVerify VerifyType, EncodingType Encoding, BSTR strCertificate);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_UIContextMessage(BSTR* pValue);
    HRESULT put_UIContextMessage(BSTR Value);
    HRESULT put_Pin(BSTR Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
}

const GUID IID_ISignerCertificates = {0x728AB33E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB33E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ISignerCertificates : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ISignerCertificate* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ISignerCertificate pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT Find(ISignerCertificate pSignerCert, int* piSignerCert);
}

const GUID IID_IX509NameValuePair = {0x728AB33F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB33F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509NameValuePair : IDispatch
{
    HRESULT Initialize(BSTR strName, BSTR strValue);
    HRESULT get_Value(BSTR* pValue);
    HRESULT get_Name(BSTR* pValue);
}

const GUID IID_IX509NameValuePairs = {0x728AB340, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB340, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509NameValuePairs : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509NameValuePair* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509NameValuePair pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

enum EnrollmentTemplateProperty
{
    TemplatePropCommonName = 1,
    TemplatePropFriendlyName = 2,
    TemplatePropEKUs = 3,
    TemplatePropCryptoProviders = 4,
    TemplatePropMajorRevision = 5,
    TemplatePropDescription = 6,
    TemplatePropKeySpec = 7,
    TemplatePropSchemaVersion = 8,
    TemplatePropMinorRevision = 9,
    TemplatePropRASignatureCount = 10,
    TemplatePropMinimumKeySize = 11,
    TemplatePropOID = 12,
    TemplatePropSupersede = 13,
    TemplatePropRACertificatePolicies = 14,
    TemplatePropRAEKUs = 15,
    TemplatePropCertificatePolicies = 16,
    TemplatePropV1ApplicationPolicy = 17,
    TemplatePropAsymmetricAlgorithm = 18,
    TemplatePropKeySecurityDescriptor = 19,
    TemplatePropSymmetricAlgorithm = 20,
    TemplatePropSymmetricKeyLength = 21,
    TemplatePropHashAlgorithm = 22,
    TemplatePropKeyUsage = 23,
    TemplatePropEnrollmentFlags = 24,
    TemplatePropSubjectNameFlags = 25,
    TemplatePropPrivateKeyFlags = 26,
    TemplatePropGeneralFlags = 27,
    TemplatePropSecurityDescriptor = 28,
    TemplatePropExtensions = 29,
    TemplatePropValidityPeriod = 30,
    TemplatePropRenewalPeriod = 31,
}

const GUID IID_IX509CertificateTemplate = {0x54244A13, 0x555A, 0x4E22, [0x89, 0x6D, 0x1B, 0x0E, 0x52, 0xF7, 0x64, 0x06]};
@GUID(0x54244A13, 0x555A, 0x4E22, [0x89, 0x6D, 0x1B, 0x0E, 0x52, 0xF7, 0x64, 0x06]);
interface IX509CertificateTemplate : IDispatch
{
    HRESULT get_Property(EnrollmentTemplateProperty property, VARIANT* pValue);
}

const GUID IID_IX509CertificateTemplates = {0x13B79003, 0x2181, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x13B79003, 0x2181, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateTemplates : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509CertificateTemplate* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509CertificateTemplate pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_ItemByName(BSTR bstrName, IX509CertificateTemplate* ppValue);
    HRESULT get_ItemByOid(IObjectId pOid, IX509CertificateTemplate* ppValue);
}

enum CommitTemplateFlags
{
    CommitFlagSaveTemplateGenerateOID = 1,
    CommitFlagSaveTemplateUseCurrentOID = 2,
    CommitFlagSaveTemplateOverwrite = 3,
    CommitFlagDeleteTemplate = 4,
}

const GUID IID_IX509CertificateTemplateWritable = {0xF49466A7, 0x395A, 0x4E9E, [0xB6, 0xE7, 0x32, 0xB3, 0x31, 0x60, 0x0D, 0xC0]};
@GUID(0xF49466A7, 0x395A, 0x4E9E, [0xB6, 0xE7, 0x32, 0xB3, 0x31, 0x60, 0x0D, 0xC0]);
interface IX509CertificateTemplateWritable : IDispatch
{
    HRESULT Initialize(IX509CertificateTemplate pValue);
    HRESULT Commit(CommitTemplateFlags commitFlags, BSTR strServerContext);
    HRESULT get_Property(EnrollmentTemplateProperty property, VARIANT* pValue);
    HRESULT put_Property(EnrollmentTemplateProperty property, VARIANT value);
    HRESULT get_Template(IX509CertificateTemplate* ppValue);
}

enum EnrollmentCAProperty
{
    CAPropCommonName = 1,
    CAPropDistinguishedName = 2,
    CAPropSanitizedName = 3,
    CAPropSanitizedShortName = 4,
    CAPropDNSName = 5,
    CAPropCertificateTypes = 6,
    CAPropCertificate = 7,
    CAPropDescription = 8,
    CAPropWebServers = 9,
    CAPropSiteName = 10,
    CAPropSecurity = 11,
    CAPropRenewalOnly = 12,
}

const GUID IID_ICertificationAuthority = {0x835D1F61, 0x1E95, 0x4BC8, [0xB4, 0xD3, 0x97, 0x6C, 0x42, 0xB9, 0x68, 0xF7]};
@GUID(0x835D1F61, 0x1E95, 0x4BC8, [0xB4, 0xD3, 0x97, 0x6C, 0x42, 0xB9, 0x68, 0xF7]);
interface ICertificationAuthority : IDispatch
{
    HRESULT get_Property(EnrollmentCAProperty property, VARIANT* pValue);
}

const GUID IID_ICertificationAuthorities = {0x13B79005, 0x2181, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x13B79005, 0x2181, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface ICertificationAuthorities : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICertificationAuthority* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICertificationAuthority pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT ComputeSiteCosts();
    HRESULT get_ItemByName(BSTR strName, ICertificationAuthority* ppValue);
}

enum X509EnrollmentPolicyLoadOption
{
    LoadOptionDefault = 0,
    LoadOptionCacheOnly = 1,
    LoadOptionReload = 2,
    LoadOptionRegisterForADChanges = 4,
}

enum EnrollmentPolicyFlags
{
    DisableGroupPolicyList = 2,
    DisableUserServerList = 4,
}

enum PolicyServerUrlPropertyID
{
    PsPolicyID = 0,
    PsFriendlyName = 1,
}

enum X509EnrollmentPolicyExportFlags
{
    ExportTemplates = 1,
    ExportOIDs = 2,
    ExportCAs = 4,
}

const GUID IID_IX509EnrollmentPolicyServer = {0x13B79026, 0x2181, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x13B79026, 0x2181, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509EnrollmentPolicyServer : IDispatch
{
    HRESULT Initialize(BSTR bstrPolicyServerUrl, BSTR bstrPolicyServerId, X509EnrollmentAuthFlags authFlags, short fIsUnTrusted, X509CertificateEnrollmentContext context);
    HRESULT LoadPolicy(X509EnrollmentPolicyLoadOption option);
    HRESULT GetTemplates(IX509CertificateTemplates* pTemplates);
    HRESULT GetCAsForTemplate(IX509CertificateTemplate pTemplate, ICertificationAuthorities* ppCAs);
    HRESULT GetCAs(ICertificationAuthorities* ppCAs);
    HRESULT Validate();
    HRESULT GetCustomOids(IObjectIds* ppObjectIds);
    HRESULT GetNextUpdateTime(double* pDate);
    HRESULT GetLastUpdateTime(double* pDate);
    HRESULT GetPolicyServerUrl(BSTR* pValue);
    HRESULT GetPolicyServerId(BSTR* pValue);
    HRESULT GetFriendlyName(BSTR* pValue);
    HRESULT GetIsDefaultCEP(short* pValue);
    HRESULT GetUseClientId(short* pValue);
    HRESULT GetAllowUnTrustedCA(short* pValue);
    HRESULT GetCachePath(BSTR* pValue);
    HRESULT GetCacheDir(BSTR* pValue);
    HRESULT GetAuthFlags(X509EnrollmentAuthFlags* pValue);
    HRESULT SetCredential(int hWndParent, X509EnrollmentAuthFlags flag, BSTR strCredential, BSTR strPassword);
    HRESULT QueryChanges(short* pValue);
    HRESULT InitializeImport(VARIANT val);
    HRESULT Export(X509EnrollmentPolicyExportFlags exportFlags, VARIANT* pVal);
    HRESULT get_Cost(uint* pValue);
    HRESULT put_Cost(uint value);
}

const GUID IID_IX509PolicyServerUrl = {0x884E204A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E204A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509PolicyServerUrl : IDispatch
{
    HRESULT Initialize(X509CertificateEnrollmentContext context);
    HRESULT get_Url(BSTR* ppValue);
    HRESULT put_Url(BSTR pValue);
    HRESULT get_Default(short* pValue);
    HRESULT put_Default(short value);
    HRESULT get_Flags(PolicyServerUrlFlags* pValue);
    HRESULT put_Flags(PolicyServerUrlFlags Flags);
    HRESULT get_AuthFlags(X509EnrollmentAuthFlags* pValue);
    HRESULT put_AuthFlags(X509EnrollmentAuthFlags Flags);
    HRESULT get_Cost(uint* pValue);
    HRESULT put_Cost(uint value);
    HRESULT GetStringProperty(PolicyServerUrlPropertyID propertyId, BSTR* ppValue);
    HRESULT SetStringProperty(PolicyServerUrlPropertyID propertyId, BSTR pValue);
    HRESULT UpdateRegistry(X509CertificateEnrollmentContext context);
    HRESULT RemoveFromRegistry(X509CertificateEnrollmentContext context);
}

const GUID IID_IX509PolicyServerListManager = {0x884E204B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x884E204B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509PolicyServerListManager : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509PolicyServerUrl* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509PolicyServerUrl pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT Initialize(X509CertificateEnrollmentContext context, PolicyServerUrlFlags Flags);
}

enum X509RequestType
{
    TypeAny = 0,
    TypePkcs10 = 1,
    TypePkcs7 = 2,
    TypeCmc = 3,
    TypeCertificate = 4,
}

enum X509RequestInheritOptions
{
    InheritDefault = 0,
    InheritNewDefaultKey = 1,
    InheritNewSimilarKey = 2,
    InheritPrivateKey = 3,
    InheritPublicKey = 4,
    InheritKeyMask = 15,
    InheritNone = 16,
    InheritRenewalCertificateFlag = 32,
    InheritTemplateFlag = 64,
    InheritSubjectFlag = 128,
    InheritExtensionsFlag = 256,
    InheritSubjectAltNameFlag = 512,
    InheritValidityPeriodFlag = 1024,
    InheritReserved80000000 = -2147483648,
}

enum InnerRequestLevel
{
    LevelInnermost = 0,
    LevelNext = 1,
}

const GUID IID_IX509CertificateRequest = {0x728AB341, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB341, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequest : IDispatch
{
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
    HRESULT Encode();
    HRESULT ResetForEncode();
    HRESULT GetInnerRequest(InnerRequestLevel Level, IX509CertificateRequest* ppValue);
    HRESULT get_Type(X509RequestType* pValue);
    HRESULT get_EnrollmentContext(X509CertificateEnrollmentContext* pValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_UIContextMessage(BSTR* pValue);
    HRESULT put_UIContextMessage(BSTR Value);
    HRESULT get_SuppressDefaults(short* pValue);
    HRESULT put_SuppressDefaults(short Value);
    HRESULT get_RenewalCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_RenewalCertificate(EncodingType Encoding, BSTR Value);
    HRESULT get_ClientId(RequestClientInfoClientId* pValue);
    HRESULT put_ClientId(RequestClientInfoClientId Value);
    HRESULT get_CspInformations(ICspInformations* ppValue);
    HRESULT put_CspInformations(ICspInformations pValue);
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    HRESULT put_HashAlgorithm(IObjectId pValue);
    HRESULT get_AlternateSignatureAlgorithm(short* pValue);
    HRESULT put_AlternateSignatureAlgorithm(short Value);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

enum Pkcs10AllowedSignatureTypes
{
    AllowedKeySignature = 1,
    AllowedNullSignature = 2,
}

const GUID IID_IX509CertificateRequestPkcs10 = {0x728AB342, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB342, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestPkcs10 : IX509CertificateRequest
{
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    HRESULT InitializeFromPrivateKey(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, BSTR strTemplateName);
    HRESULT InitializeFromPublicKey(X509CertificateEnrollmentContext Context, IX509PublicKey pPublicKey, BSTR strTemplateName);
    HRESULT InitializeFromCertificate(X509CertificateEnrollmentContext Context, BSTR strCertificate, EncodingType Encoding, X509RequestInheritOptions InheritOptions);
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    HRESULT CheckSignature(Pkcs10AllowedSignatureTypes AllowedSignatureTypes);
    HRESULT IsSmartCard(short* pValue);
    HRESULT get_TemplateObjectId(IObjectId* ppValue);
    HRESULT get_PublicKey(IX509PublicKey* ppValue);
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT get_ReuseKey(short* pValue);
    HRESULT get_OldCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Subject(IX500DistinguishedName* ppValue);
    HRESULT put_Subject(IX500DistinguishedName pValue);
    HRESULT get_CspStatuses(ICspStatuses* ppValue);
    HRESULT get_SmimeCapabilities(short* pValue);
    HRESULT put_SmimeCapabilities(short Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    HRESULT get_KeyContainerNamePrefix(BSTR* pValue);
    HRESULT put_KeyContainerNamePrefix(BSTR Value);
    HRESULT get_CryptAttributes(ICryptAttributes* ppValue);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    HRESULT get_SuppressOids(IObjectIds* ppValue);
    HRESULT get_RawDataToBeSigned(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
    HRESULT GetCspStatuses(X509KeySpec KeySpec, ICspStatuses* ppCspStatuses);
}

const GUID IID_IX509CertificateRequestPkcs10V2 = {0x728AB35B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB35B, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestPkcs10V2 : IX509CertificateRequestPkcs10
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromPrivateKeyTemplate(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromPublicKeyTemplate(X509CertificateEnrollmentContext Context, IX509PublicKey pPublicKey, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
}

const GUID IID_IX509CertificateRequestPkcs10V3 = {0x54EA9942, 0x3D66, 0x4530, [0xB7, 0x6E, 0x7C, 0x91, 0x70, 0xD3, 0xEC, 0x52]};
@GUID(0x54EA9942, 0x3D66, 0x4530, [0xB7, 0x6E, 0x7C, 0x91, 0x70, 0xD3, 0xEC, 0x52]);
interface IX509CertificateRequestPkcs10V3 : IX509CertificateRequestPkcs10V2
{
    HRESULT get_AttestPrivateKey(short* pValue);
    HRESULT put_AttestPrivateKey(short Value);
    HRESULT get_AttestationEncryptionCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_AttestationEncryptionCertificate(EncodingType Encoding, BSTR Value);
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    HRESULT put_EncryptionAlgorithm(IObjectId pValue);
    HRESULT get_EncryptionStrength(int* pValue);
    HRESULT put_EncryptionStrength(int Value);
    HRESULT get_ChallengePassword(BSTR* pValue);
    HRESULT put_ChallengePassword(BSTR Value);
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
}

enum KeyAttestationClaimType
{
    XCN_NCRYPT_CLAIM_NONE = 0,
    XCN_NCRYPT_CLAIM_AUTHORITY_AND_SUBJECT = 3,
    XCN_NCRYPT_CLAIM_AUTHORITY_ONLY = 1,
    XCN_NCRYPT_CLAIM_SUBJECT_ONLY = 2,
    XCN_NCRYPT_CLAIM_UNKNOWN = 4096,
}

const GUID IID_IX509CertificateRequestPkcs10V4 = {0x728AB363, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB363, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestPkcs10V4 : IX509CertificateRequestPkcs10V3
{
    HRESULT get_ClaimType(KeyAttestationClaimType* pValue);
    HRESULT put_ClaimType(KeyAttestationClaimType Value);
    HRESULT get_AttestPrivateKeyPreferred(short* pValue);
    HRESULT put_AttestPrivateKeyPreferred(short Value);
}

const GUID IID_IX509CertificateRequestCertificate = {0x728AB343, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB343, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestCertificate : IX509CertificateRequestPkcs10
{
    HRESULT CheckPublicKeySignature(IX509PublicKey pPublicKey);
    HRESULT get_Issuer(IX500DistinguishedName* ppValue);
    HRESULT put_Issuer(IX500DistinguishedName pValue);
    HRESULT get_NotBefore(double* pValue);
    HRESULT put_NotBefore(double Value);
    HRESULT get_NotAfter(double* pValue);
    HRESULT put_NotAfter(double Value);
    HRESULT get_SerialNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT put_SerialNumber(EncodingType Encoding, BSTR Value);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
}

const GUID IID_IX509CertificateRequestCertificate2 = {0x728AB35A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB35A, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestCertificate2 : IX509CertificateRequestCertificate
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromPrivateKeyTemplate(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
}

const GUID IID_IX509CertificateRequestPkcs7 = {0x728AB344, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB344, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestPkcs7 : IX509CertificateRequest
{
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    HRESULT InitializeFromCertificate(X509CertificateEnrollmentContext Context, short RenewalRequest, BSTR strCertificate, EncodingType Encoding, X509RequestInheritOptions InheritOptions);
    HRESULT InitializeFromInnerRequest(IX509CertificateRequest pInnerRequest);
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    HRESULT get_RequesterName(BSTR* pValue);
    HRESULT put_RequesterName(BSTR Value);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
}

const GUID IID_IX509CertificateRequestPkcs7V2 = {0x728AB35C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB35C, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestPkcs7V2 : IX509CertificateRequestPkcs7
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    HRESULT CheckCertificateSignature(short ValidateCertificateChain);
}

const GUID IID_IX509CertificateRequestCmc = {0x728AB345, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB345, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestCmc : IX509CertificateRequestPkcs7
{
    HRESULT InitializeFromInnerRequestTemplateName(IX509CertificateRequest pInnerRequest, BSTR strTemplateName);
    HRESULT get_TemplateObjectId(IObjectId* ppValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT get_CryptAttributes(ICryptAttributes* ppValue);
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    HRESULT get_SuppressOids(IObjectIds* ppValue);
    HRESULT get_TransactionId(int* pValue);
    HRESULT put_TransactionId(int Value);
    HRESULT get_SenderNonce(EncodingType Encoding, BSTR* pValue);
    HRESULT put_SenderNonce(EncodingType Encoding, BSTR Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    HRESULT get_ArchivePrivateKey(short* pValue);
    HRESULT put_ArchivePrivateKey(short Value);
    HRESULT get_KeyArchivalCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_KeyArchivalCertificate(EncodingType Encoding, BSTR Value);
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    HRESULT put_EncryptionAlgorithm(IObjectId pValue);
    HRESULT get_EncryptionStrength(int* pValue);
    HRESULT put_EncryptionStrength(int Value);
    HRESULT get_EncryptedKeyHash(EncodingType Encoding, BSTR* pValue);
    HRESULT get_SignerCertificates(ISignerCertificates* ppValue);
}

const GUID IID_IX509CertificateRequestCmc2 = {0x728AB35D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB35D, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRequestCmc2 : IX509CertificateRequestCmc
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromInnerRequestTemplate(IX509CertificateRequest pInnerRequest, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    HRESULT CheckSignature(Pkcs10AllowedSignatureTypes AllowedSignatureTypes);
    HRESULT CheckCertificateSignature(ISignerCertificate pSignerCertificate, short ValidateCertificateChain);
}

enum InstallResponseRestrictionFlags
{
    AllowNone = 0,
    AllowNoOutstandingRequest = 1,
    AllowUntrustedCertificate = 2,
    AllowUntrustedRoot = 4,
}

const GUID IID_IX509Enrollment = {0x728AB346, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB346, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509Enrollment : IDispatch
{
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    HRESULT InitializeFromRequest(IX509CertificateRequest pRequest);
    HRESULT CreateRequest(EncodingType Encoding, BSTR* pValue);
    HRESULT Enroll();
    HRESULT InstallResponse(InstallResponseRestrictionFlags Restrictions, BSTR strResponse, EncodingType Encoding, BSTR strPassword);
    HRESULT CreatePFX(BSTR strPassword, PFXExportOptions ExportOptions, EncodingType Encoding, BSTR* pValue);
    HRESULT get_Request(IX509CertificateRequest* pValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
    HRESULT get_EnrollmentContext(X509CertificateEnrollmentContext* pValue);
    HRESULT get_Status(IX509EnrollmentStatus* ppValue);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Response(EncodingType Encoding, BSTR* pValue);
    HRESULT get_CertificateFriendlyName(BSTR* pValue);
    HRESULT put_CertificateFriendlyName(BSTR strValue);
    HRESULT get_CertificateDescription(BSTR* pValue);
    HRESULT put_CertificateDescription(BSTR strValue);
    HRESULT get_RequestId(int* pValue);
    HRESULT get_CAConfigString(BSTR* pValue);
}

const GUID IID_IX509Enrollment2 = {0x728AB350, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB350, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509Enrollment2 : IX509Enrollment
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InstallResponse2(InstallResponseRestrictionFlags Restrictions, BSTR strResponse, EncodingType Encoding, BSTR strPassword, BSTR strEnrollmentPolicyServerUrl, BSTR strEnrollmentPolicyServerID, PolicyServerUrlFlags EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags authFlags);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    HRESULT get_RequestIdString(BSTR* pValue);
}

enum WebEnrollmentFlags
{
    EnrollPrompt = 1,
}

const GUID IID_IX509EnrollmentHelper = {0x728AB351, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB351, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509EnrollmentHelper : IDispatch
{
    HRESULT AddPolicyServer(BSTR strEnrollmentPolicyServerURI, BSTR strEnrollmentPolicyID, PolicyServerUrlFlags EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags authFlags, BSTR strCredential, BSTR strPassword);
    HRESULT AddEnrollmentServer(BSTR strEnrollmentServerURI, X509EnrollmentAuthFlags authFlags, BSTR strCredential, BSTR strPassword);
    HRESULT Enroll(BSTR strEnrollmentPolicyServerURI, BSTR strTemplateName, EncodingType Encoding, WebEnrollmentFlags enrollFlags, BSTR* pstrCertificate);
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
}

const GUID IID_IX509EnrollmentWebClassFactory = {0x728AB349, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB349, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509EnrollmentWebClassFactory : IDispatch
{
    HRESULT CreateObject(BSTR strProgID, IUnknown* ppIUnknown);
}

const GUID IID_IX509MachineEnrollmentFactory = {0x728AB352, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB352, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509MachineEnrollmentFactory : IDispatch
{
    HRESULT CreateObject(BSTR strProgID, IX509EnrollmentHelper* ppIHelper);
}

enum CRLRevocationReason
{
    XCN_CRL_REASON_UNSPECIFIED = 0,
    XCN_CRL_REASON_KEY_COMPROMISE = 1,
    XCN_CRL_REASON_CA_COMPROMISE = 2,
    XCN_CRL_REASON_AFFILIATION_CHANGED = 3,
    XCN_CRL_REASON_SUPERSEDED = 4,
    XCN_CRL_REASON_CESSATION_OF_OPERATION = 5,
    XCN_CRL_REASON_CERTIFICATE_HOLD = 6,
    XCN_CRL_REASON_REMOVE_FROM_CRL = 8,
    XCN_CRL_REASON_PRIVILEGE_WITHDRAWN = 9,
    XCN_CRL_REASON_AA_COMPROMISE = 10,
}

const GUID IID_IX509CertificateRevocationListEntry = {0x728AB35E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB35E, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRevocationListEntry : IDispatch
{
    HRESULT Initialize(EncodingType Encoding, BSTR SerialNumber, double RevocationDate);
    HRESULT get_SerialNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT get_RevocationDate(double* pValue);
    HRESULT get_RevocationReason(CRLRevocationReason* pValue);
    HRESULT put_RevocationReason(CRLRevocationReason Value);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
}

const GUID IID_IX509CertificateRevocationListEntries = {0x728AB35F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB35F, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRevocationListEntries : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509CertificateRevocationListEntry* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509CertificateRevocationListEntry pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_IndexBySerialNumber(EncodingType Encoding, BSTR SerialNumber, int* pIndex);
    HRESULT AddRange(IX509CertificateRevocationListEntries pValue);
}

const GUID IID_IX509CertificateRevocationList = {0x728AB360, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB360, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509CertificateRevocationList : IDispatch
{
    HRESULT Initialize();
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    HRESULT Encode();
    HRESULT ResetForEncode();
    HRESULT CheckPublicKeySignature(IX509PublicKey pPublicKey);
    HRESULT CheckSignature();
    HRESULT get_Issuer(IX500DistinguishedName* ppValue);
    HRESULT put_Issuer(IX500DistinguishedName pValue);
    HRESULT get_ThisUpdate(double* pValue);
    HRESULT put_ThisUpdate(double Value);
    HRESULT get_NextUpdate(double* pValue);
    HRESULT put_NextUpdate(double Value);
    HRESULT get_X509CRLEntries(IX509CertificateRevocationListEntries* ppValue);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
    HRESULT get_CRLNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT put_CRLNumber(EncodingType Encoding, BSTR Value);
    HRESULT get_CAVersion(int* pValue);
    HRESULT put_CAVersion(int pValue);
    HRESULT get_BaseCRL(short* pValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    HRESULT put_HashAlgorithm(IObjectId pValue);
    HRESULT get_AlternateSignatureAlgorithm(short* pValue);
    HRESULT put_AlternateSignatureAlgorithm(short Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    HRESULT get_RawDataToBeSigned(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
}

const GUID IID_ICertificateAttestationChallenge = {0x6F175A7C, 0x4A3A, 0x40AE, [0x9D, 0xBA, 0x59, 0x2F, 0xD6, 0xBB, 0xF9, 0xB8]};
@GUID(0x6F175A7C, 0x4A3A, 0x40AE, [0x9D, 0xBA, 0x59, 0x2F, 0xD6, 0xBB, 0xF9, 0xB8]);
interface ICertificateAttestationChallenge : IDispatch
{
    HRESULT Initialize(EncodingType Encoding, BSTR strPendingFullCmcResponseWithChallenge);
    HRESULT DecryptChallenge(EncodingType Encoding, BSTR* pstrEnvelopedPkcs7ReencryptedToCA);
    HRESULT get_RequestID(BSTR* pstrRequestID);
}

const GUID IID_ICertificateAttestationChallenge2 = {0x4631334D, 0xE266, 0x47D6, [0xBD, 0x79, 0xBE, 0x53, 0xCB, 0x2E, 0x27, 0x53]};
@GUID(0x4631334D, 0xE266, 0x47D6, [0xBD, 0x79, 0xBE, 0x53, 0xCB, 0x2E, 0x27, 0x53]);
interface ICertificateAttestationChallenge2 : ICertificateAttestationChallenge
{
    HRESULT put_KeyContainerName(BSTR Value);
    HRESULT put_KeyBlob(EncodingType Encoding, BSTR Value);
}

const GUID IID_IX509SCEPEnrollment = {0x728AB361, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB361, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509SCEPEnrollment : IDispatch
{
    HRESULT Initialize(IX509CertificateRequestPkcs10 pRequest, BSTR strThumbprint, EncodingType ThumprintEncoding, BSTR strServerCertificates, EncodingType Encoding);
    HRESULT InitializeForPending(X509CertificateEnrollmentContext Context);
    HRESULT CreateRequestMessage(EncodingType Encoding, BSTR* pValue);
    HRESULT CreateRetrievePendingMessage(EncodingType Encoding, BSTR* pValue);
    HRESULT CreateRetrieveCertificateMessage(X509CertificateEnrollmentContext Context, BSTR strIssuer, EncodingType IssuerEncoding, BSTR strSerialNumber, EncodingType SerialNumberEncoding, EncodingType Encoding, BSTR* pValue);
    HRESULT ProcessResponseMessage(BSTR strResponse, EncodingType Encoding, X509SCEPDisposition* pDisposition);
    HRESULT put_ServerCapabilities(BSTR Value);
    HRESULT get_FailInfo(X509SCEPFailInfo* pValue);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
    HRESULT get_OldCertificate(ISignerCertificate* ppValue);
    HRESULT put_OldCertificate(ISignerCertificate pValue);
    HRESULT get_TransactionId(EncodingType Encoding, BSTR* pValue);
    HRESULT put_TransactionId(EncodingType Encoding, BSTR Value);
    HRESULT get_Request(IX509CertificateRequestPkcs10* ppValue);
    HRESULT get_CertificateFriendlyName(BSTR* pValue);
    HRESULT put_CertificateFriendlyName(BSTR Value);
    HRESULT get_Status(IX509EnrollmentStatus* ppValue);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT DeleteRequest();
}

enum X509SCEPProcessMessageFlags
{
    SCEPProcessDefault = 0,
    SCEPProcessSkipCertInstall = 1,
}

enum DelayRetryAction
{
    DelayRetryUnknown = 0,
    DelayRetryNone = 1,
    DelayRetryShort = 2,
    DelayRetryLong = 3,
    DelayRetrySuccess = 4,
    DelayRetryPastSuccess = 5,
}

const GUID IID_IX509SCEPEnrollment2 = {0x728AB364, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB364, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509SCEPEnrollment2 : IX509SCEPEnrollment
{
    HRESULT CreateChallengeAnswerMessage(EncodingType Encoding, BSTR* pValue);
    HRESULT ProcessResponseMessage2(X509SCEPProcessMessageFlags Flags, BSTR strResponse, EncodingType Encoding, X509SCEPDisposition* pDisposition);
    HRESULT get_ResultMessageText(BSTR* pValue);
    HRESULT get_DelayRetry(DelayRetryAction* pValue);
    HRESULT get_ActivityId(BSTR* pValue);
    HRESULT put_ActivityId(BSTR Value);
}

const GUID IID_IX509SCEPEnrollmentHelper = {0x728AB365, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]};
@GUID(0x728AB365, 0x217D, 0x11DA, [0xB2, 0xA4, 0x00, 0x0E, 0x7B, 0xBB, 0x2B, 0x09]);
interface IX509SCEPEnrollmentHelper : IDispatch
{
    HRESULT Initialize(BSTR strServerUrl, BSTR strRequestHeaders, IX509CertificateRequestPkcs10 pRequest, BSTR strCACertificateThumbprint);
    HRESULT InitializeForPending(BSTR strServerUrl, BSTR strRequestHeaders, X509CertificateEnrollmentContext Context, BSTR strTransactionId);
    HRESULT Enroll(X509SCEPProcessMessageFlags ProcessFlags, X509SCEPDisposition* pDisposition);
    HRESULT FetchPending(X509SCEPProcessMessageFlags ProcessFlags, X509SCEPDisposition* pDisposition);
    HRESULT get_X509SCEPEnrollment(IX509SCEPEnrollment* ppValue);
    HRESULT get_ResultMessageText(BSTR* pValue);
}

enum X509CertificateTemplateGeneralFlag
{
    GeneralMachineType = 64,
    GeneralCA = 128,
    GeneralCrossCA = 2048,
    GeneralDefault = 65536,
    GeneralModified = 131072,
    GeneralDonotPersist = 4096,
}

enum X509CertificateTemplateEnrollmentFlag
{
    EnrollmentIncludeSymmetricAlgorithms = 1,
    EnrollmentPendAllRequests = 2,
    EnrollmentPublishToKRAContainer = 4,
    EnrollmentPublishToDS = 8,
    EnrollmentAutoEnrollmentCheckUserDSCertificate = 16,
    EnrollmentAutoEnrollment = 32,
    EnrollmentDomainAuthenticationNotRequired = 128,
    EnrollmentPreviousApprovalValidateReenrollment = 64,
    EnrollmentUserInteractionRequired = 256,
    EnrollmentAddTemplateName = 512,
    EnrollmentRemoveInvalidCertificateFromPersonalStore = 1024,
    EnrollmentAllowEnrollOnBehalfOf = 2048,
    EnrollmentAddOCSPNoCheck = 4096,
    EnrollmentReuseKeyOnFullSmartCard = 8192,
    EnrollmentNoRevocationInfoInCerts = 16384,
    EnrollmentIncludeBasicConstraintsForEECerts = 32768,
    EnrollmentPreviousApprovalKeyBasedValidateReenrollment = 65536,
    EnrollmentCertificateIssuancePoliciesFromRequest = 131072,
    EnrollmentSkipAutoRenewal = 262144,
}

enum X509CertificateTemplateSubjectNameFlag
{
    SubjectNameEnrolleeSupplies = 1,
    SubjectNameRequireDirectoryPath = -2147483648,
    SubjectNameRequireCommonName = 1073741824,
    SubjectNameRequireEmail = 536870912,
    SubjectNameRequireDNS = 268435456,
    SubjectNameAndAlternativeNameOldCertSupplies = 8,
    SubjectAlternativeNameEnrolleeSupplies = 65536,
    SubjectAlternativeNameRequireDirectoryGUID = 16777216,
    SubjectAlternativeNameRequireUPN = 33554432,
    SubjectAlternativeNameRequireEmail = 67108864,
    SubjectAlternativeNameRequireSPN = 8388608,
    SubjectAlternativeNameRequireDNS = 134217728,
    SubjectAlternativeNameRequireDomainDNS = 4194304,
}

enum X509CertificateTemplatePrivateKeyFlag
{
    PrivateKeyRequireArchival = 1,
    PrivateKeyExportable = 16,
    PrivateKeyRequireStrongKeyProtection = 32,
    PrivateKeyRequireAlternateSignatureAlgorithm = 64,
    PrivateKeyRequireSameKeyRenewal = 128,
    PrivateKeyUseLegacyProvider = 256,
    PrivateKeyEKTrustOnUse = 512,
    PrivateKeyEKValidateCert = 1024,
    PrivateKeyEKValidateKey = 2048,
    PrivateKeyAttestNone = 0,
    PrivateKeyAttestPreferred = 4096,
    PrivateKeyAttestRequired = 8192,
    PrivateKeyAttestMask = 12288,
    PrivateKeyAttestWithoutPolicy = 16384,
    PrivateKeyServerVersionMask = 983040,
    PrivateKeyServerVersionShift = 16,
    PrivateKeyHelloKspKey = 1048576,
    PrivateKeyHelloLogonKey = 2097152,
    PrivateKeyClientVersionMask = 251658240,
    PrivateKeyClientVersionShift = 24,
}

enum ImportPFXFlags
{
    ImportNone = 0,
    ImportMachineContext = 1,
    ImportForceOverwrite = 2,
    ImportSilent = 4,
    ImportSaveProperties = 8,
    ImportExportable = 16,
    ImportExportableEncrypted = 32,
    ImportNoUserProtected = 64,
    ImportUserProtected = 128,
    ImportUserProtectedHigh = 256,
    ImportInstallCertificate = 512,
    ImportInstallChain = 1024,
    ImportInstallChainAndRoot = 2048,
}

alias FNIMPORTPFXTOPROVIDER = extern(Windows) HRESULT function(HWND hWndParent, char* pbPFX, uint cbPFX, ImportPFXFlags ImportFlags, const(wchar)* pwszPassword, const(wchar)* pwszProviderName, const(wchar)* pwszReaderName, const(wchar)* pwszContainerNamePrefix, const(wchar)* pwszPin, const(wchar)* pwszFriendlyName, uint* pcCertOut, CERT_CONTEXT*** prgpCertOut);
alias FNIMPORTPFXTOPROVIDERFREEDATA = extern(Windows) void function(uint cCert, char* rgpCert);
struct NCRYPT_DESCRIPTOR_HANDLE__
{
    int unused;
}

struct NCRYPT_STREAM_HANDLE__
{
    int unused;
}

alias PFNCryptStreamOutputCallback = extern(Windows) int function(void* pvCallbackCtxt, char* pbData, uint cbData, BOOL fFinal);
struct NCRYPT_PROTECT_STREAM_INFO
{
    PFNCryptStreamOutputCallback pfnStreamOutput;
    void* pvCallbackCtxt;
}

alias PFNCryptStreamOutputCallbackEx = extern(Windows) int function(void* pvCallbackCtxt, char* pbData, uint cbData, NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, BOOL fFinal);
struct NCRYPT_PROTECT_STREAM_INFO_EX
{
    PFNCryptStreamOutputCallbackEx pfnStreamOutput;
    void* pvCallbackCtxt;
}

enum TOKENBINDING_TYPE
{
    TOKENBINDING_TYPE_PROVIDED = 0,
    TOKENBINDING_TYPE_REFERRED = 1,
}

enum TOKENBINDING_EXTENSION_FORMAT
{
    TOKENBINDING_EXTENSION_FORMAT_UNDEFINED = 0,
}

enum TOKENBINDING_KEY_PARAMETERS_TYPE
{
    TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PKCS = 0,
    TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PSS = 1,
    TOKENBINDING_KEY_PARAMETERS_TYPE_ECDSAP256 = 2,
    TOKENBINDING_KEY_PARAMETERS_TYPE_ANYEXISTING = 255,
}

struct TOKENBINDING_IDENTIFIER
{
    ubyte keyType;
}

struct TOKENBINDING_RESULT_DATA
{
    TOKENBINDING_TYPE bindingType;
    uint identifierSize;
    TOKENBINDING_IDENTIFIER* identifierData;
    TOKENBINDING_EXTENSION_FORMAT extensionFormat;
    uint extensionSize;
    void* extensionData;
}

struct TOKENBINDING_RESULT_LIST
{
    uint resultCount;
    TOKENBINDING_RESULT_DATA* resultData;
}

struct TOKENBINDING_KEY_TYPES
{
    uint keyCount;
    TOKENBINDING_KEY_PARAMETERS_TYPE* keyType;
}

enum CRYPT_XML_CHARSET
{
    CRYPT_XML_CHARSET_AUTO = 0,
    CRYPT_XML_CHARSET_UTF8 = 1,
    CRYPT_XML_CHARSET_UTF16LE = 2,
    CRYPT_XML_CHARSET_UTF16BE = 3,
}

struct CRYPT_XML_BLOB
{
    CRYPT_XML_CHARSET dwCharset;
    uint cbData;
    ubyte* pbData;
}

struct CRYPT_XML_DATA_BLOB
{
    uint cbData;
    ubyte* pbData;
}

enum CRYPT_XML_PROPERTY_ID
{
    CRYPT_XML_PROPERTY_MAX_HEAP_SIZE = 1,
    CRYPT_XML_PROPERTY_SIGNATURE_LOCATION = 2,
    CRYPT_XML_PROPERTY_MAX_SIGNATURES = 3,
    CRYPT_XML_PROPERTY_DOC_DECLARATION = 4,
    CRYPT_XML_PROPERTY_XML_OUTPUT_CHARSET = 5,
}

struct CRYPT_XML_PROPERTY
{
    CRYPT_XML_PROPERTY_ID dwPropId;
    const(void)* pvValue;
    uint cbValue;
}

alias PFN_CRYPT_XML_WRITE_CALLBACK = extern(Windows) HRESULT function(void* pvCallbackState, char* pbData, uint cbData);
alias PFN_CRYPT_XML_DATA_PROVIDER_READ = extern(Windows) HRESULT function(void* pvCallbackState, char* pbData, uint cbData, uint* pcbRead);
alias PFN_CRYPT_XML_DATA_PROVIDER_CLOSE = extern(Windows) HRESULT function(void* pvCallbackState);
struct CRYPT_XML_DATA_PROVIDER
{
    void* pvCallbackState;
    uint cbBufferSize;
    PFN_CRYPT_XML_DATA_PROVIDER_READ pfnRead;
    PFN_CRYPT_XML_DATA_PROVIDER_CLOSE pfnClose;
}

alias PFN_CRYPT_XML_CREATE_TRANSFORM = extern(Windows) HRESULT function(const(CRYPT_XML_ALGORITHM)* pTransform, CRYPT_XML_DATA_PROVIDER* pProviderIn, CRYPT_XML_DATA_PROVIDER* pProviderOut);
struct CRYPT_XML_STATUS
{
    uint cbSize;
    uint dwErrorStatus;
    uint dwInfoStatus;
}

struct CRYPT_XML_ALGORITHM
{
    uint cbSize;
    const(wchar)* wszAlgorithm;
    CRYPT_XML_BLOB Encoded;
}

struct CRYPT_XML_TRANSFORM_INFO
{
    uint cbSize;
    const(wchar)* wszAlgorithm;
    uint cbBufferSize;
    uint dwFlags;
    PFN_CRYPT_XML_CREATE_TRANSFORM pfnCreateTransform;
}

struct CRYPT_XML_TRANSFORM_CHAIN_CONFIG
{
    uint cbSize;
    uint cTransformInfo;
    CRYPT_XML_TRANSFORM_INFO** rgpTransformInfo;
}

struct CRYPT_XML_KEY_DSA_KEY_VALUE
{
    CRYPT_XML_DATA_BLOB P;
    CRYPT_XML_DATA_BLOB Q;
    CRYPT_XML_DATA_BLOB G;
    CRYPT_XML_DATA_BLOB Y;
    CRYPT_XML_DATA_BLOB J;
    CRYPT_XML_DATA_BLOB Seed;
    CRYPT_XML_DATA_BLOB Counter;
}

struct CRYPT_XML_KEY_ECDSA_KEY_VALUE
{
    const(wchar)* wszNamedCurve;
    CRYPT_XML_DATA_BLOB X;
    CRYPT_XML_DATA_BLOB Y;
    CRYPT_XML_BLOB ExplicitPara;
}

struct CRYPT_XML_KEY_RSA_KEY_VALUE
{
    CRYPT_XML_DATA_BLOB Modulus;
    CRYPT_XML_DATA_BLOB Exponent;
}

struct CRYPT_XML_KEY_VALUE
{
    uint dwType;
    _Anonymous_e__Union Anonymous;
}

struct CRYPT_XML_ISSUER_SERIAL
{
    const(wchar)* wszIssuer;
    const(wchar)* wszSerial;
}

struct CRYPT_XML_X509DATA_ITEM
{
    uint dwType;
    _Anonymous_e__Union Anonymous;
}

struct CRYPT_XML_X509DATA
{
    uint cX509Data;
    CRYPT_XML_X509DATA_ITEM* rgX509Data;
}

struct CRYPT_XML_KEY_INFO_ITEM
{
    uint dwType;
    _Anonymous_e__Union Anonymous;
}

struct CRYPT_XML_KEY_INFO
{
    uint cbSize;
    const(wchar)* wszId;
    uint cKeyInfo;
    CRYPT_XML_KEY_INFO_ITEM* rgKeyInfo;
    void* hVerifyKey;
}

struct CRYPT_XML_REFERENCE
{
    uint cbSize;
    void* hReference;
    const(wchar)* wszId;
    const(wchar)* wszUri;
    const(wchar)* wszType;
    CRYPT_XML_ALGORITHM DigestMethod;
    CRYPTOAPI_BLOB DigestValue;
    uint cTransform;
    CRYPT_XML_ALGORITHM* rgTransform;
}

struct CRYPT_XML_REFERENCES
{
    uint cReference;
    CRYPT_XML_REFERENCE** rgpReference;
}

struct CRYPT_XML_SIGNED_INFO
{
    uint cbSize;
    const(wchar)* wszId;
    CRYPT_XML_ALGORITHM Canonicalization;
    CRYPT_XML_ALGORITHM SignatureMethod;
    uint cReference;
    CRYPT_XML_REFERENCE** rgpReference;
    CRYPT_XML_BLOB Encoded;
}

struct CRYPT_XML_OBJECT
{
    uint cbSize;
    void* hObject;
    const(wchar)* wszId;
    const(wchar)* wszMimeType;
    const(wchar)* wszEncoding;
    CRYPT_XML_REFERENCES Manifest;
    CRYPT_XML_BLOB Encoded;
}

struct CRYPT_XML_SIGNATURE
{
    uint cbSize;
    void* hSignature;
    const(wchar)* wszId;
    CRYPT_XML_SIGNED_INFO SignedInfo;
    CRYPTOAPI_BLOB SignatureValue;
    CRYPT_XML_KEY_INFO* pKeyInfo;
    uint cObject;
    CRYPT_XML_OBJECT** rgpObject;
}

struct CRYPT_XML_DOC_CTXT
{
    uint cbSize;
    void* hDocCtxt;
    CRYPT_XML_TRANSFORM_CHAIN_CONFIG* pTransformsConfig;
    uint cSignature;
    CRYPT_XML_SIGNATURE** rgpSignature;
}

struct CRYPT_XML_KEYINFO_PARAM
{
    const(wchar)* wszId;
    const(wchar)* wszKeyName;
    CRYPTOAPI_BLOB SKI;
    const(wchar)* wszSubjectName;
    uint cCertificate;
    CRYPTOAPI_BLOB* rgCertificate;
    uint cCRL;
    CRYPTOAPI_BLOB* rgCRL;
}

enum CRYPT_XML_KEYINFO_SPEC
{
    CRYPT_XML_KEYINFO_SPEC_NONE = 0,
    CRYPT_XML_KEYINFO_SPEC_ENCODED = 1,
    CRYPT_XML_KEYINFO_SPEC_PARAM = 2,
}

struct CRYPT_XML_ALGORITHM_INFO
{
    uint cbSize;
    ushort* wszAlgorithmURI;
    ushort* wszName;
    uint dwGroupId;
    ushort* wszCNGAlgid;
    ushort* wszCNGExtraAlgid;
    uint dwSignFlags;
    uint dwVerifyFlags;
    void* pvPaddingInfo;
    void* pvExtraInfo;
}

alias PFN_CRYPT_XML_ENUM_ALG_INFO = extern(Windows) BOOL function(const(CRYPT_XML_ALGORITHM_INFO)* pInfo, void* pvArg);
alias CryptXmlDllGetInterface = extern(Windows) HRESULT function(uint dwFlags, const(CRYPT_XML_ALGORITHM_INFO)* pMethod, CRYPT_XML_CRYPTOGRAPHIC_INTERFACE* pInterface);
alias CryptXmlDllEncodeAlgorithm = extern(Windows) HRESULT function(const(CRYPT_XML_ALGORITHM_INFO)* pAlgInfo, CRYPT_XML_CHARSET dwCharset, void* pvCallbackState, PFN_CRYPT_XML_WRITE_CALLBACK pfnWrite);
alias CryptXmlDllCreateDigest = extern(Windows) HRESULT function(const(CRYPT_XML_ALGORITHM)* pDigestMethod, uint* pcbSize, void** phDigest);
alias CryptXmlDllDigestData = extern(Windows) HRESULT function(void* hDigest, char* pbData, uint cbData);
alias CryptXmlDllFinalizeDigest = extern(Windows) HRESULT function(void* hDigest, char* pbDigest, uint cbDigest);
alias CryptXmlDllCloseDigest = extern(Windows) HRESULT function(void* hDigest);
alias CryptXmlDllSignData = extern(Windows) HRESULT function(const(CRYPT_XML_ALGORITHM)* pSignatureMethod, uint hCryptProvOrNCryptKey, uint dwKeySpec, char* pbInput, uint cbInput, char* pbOutput, uint cbOutput, uint* pcbResult);
alias CryptXmlDllVerifySignature = extern(Windows) HRESULT function(const(CRYPT_XML_ALGORITHM)* pSignatureMethod, void* hKey, char* pbInput, uint cbInput, char* pbSignature, uint cbSignature);
alias CryptXmlDllGetAlgorithmInfo = extern(Windows) HRESULT function(const(CRYPT_XML_ALGORITHM)* pXmlAlgorithm, CRYPT_XML_ALGORITHM_INFO** ppAlgInfo);
struct CRYPT_XML_CRYPTOGRAPHIC_INTERFACE
{
    uint cbSize;
    CryptXmlDllEncodeAlgorithm fpCryptXmlEncodeAlgorithm;
    CryptXmlDllCreateDigest fpCryptXmlCreateDigest;
    CryptXmlDllDigestData fpCryptXmlDigestData;
    CryptXmlDllFinalizeDigest fpCryptXmlFinalizeDigest;
    CryptXmlDllCloseDigest fpCryptXmlCloseDigest;
    CryptXmlDllSignData fpCryptXmlSignData;
    CryptXmlDllVerifySignature fpCryptXmlVerifySignature;
    CryptXmlDllGetAlgorithmInfo fpCryptXmlGetAlgorithmInfo;
}

alias CryptXmlDllEncodeKeyValue = extern(Windows) HRESULT function(uint hKey, CRYPT_XML_CHARSET dwCharset, void* pvCallbackState, PFN_CRYPT_XML_WRITE_CALLBACK pfnWrite);
alias CryptXmlDllCreateKey = extern(Windows) HRESULT function(const(CRYPT_XML_BLOB)* pEncoded, void** phKey);
const GUID CLSID_CCertSrvSetupKeyInformation = {0x38373906, 0x5433, 0x4633, [0xB0, 0xFB, 0x29, 0xB7, 0xE7, 0x82, 0x62, 0xE1]};
@GUID(0x38373906, 0x5433, 0x4633, [0xB0, 0xFB, 0x29, 0xB7, 0xE7, 0x82, 0x62, 0xE1]);
struct CCertSrvSetupKeyInformation;

const GUID CLSID_CCertSrvSetup = {0x961F180F, 0xF55C, 0x413D, [0xA9, 0xB3, 0x7D, 0x2A, 0xF4, 0xD8, 0xE4, 0x2F]};
@GUID(0x961F180F, 0xF55C, 0x413D, [0xA9, 0xB3, 0x7D, 0x2A, 0xF4, 0xD8, 0xE4, 0x2F]);
struct CCertSrvSetup;

const GUID CLSID_CMSCEPSetup = {0xAA4F5C02, 0x8E7C, 0x49C4, [0x94, 0xFA, 0x67, 0xA5, 0xCC, 0x5E, 0xAD, 0xB4]};
@GUID(0xAA4F5C02, 0x8E7C, 0x49C4, [0x94, 0xFA, 0x67, 0xA5, 0xCC, 0x5E, 0xAD, 0xB4]);
struct CMSCEPSetup;

const GUID CLSID_CCertificateEnrollmentServerSetup = {0x9902F3BC, 0x88AF, 0x4CF8, [0xAE, 0x62, 0x71, 0x40, 0x53, 0x15, 0x52, 0xB6]};
@GUID(0x9902F3BC, 0x88AF, 0x4CF8, [0xAE, 0x62, 0x71, 0x40, 0x53, 0x15, 0x52, 0xB6]);
struct CCertificateEnrollmentServerSetup;

const GUID CLSID_CCertificateEnrollmentPolicyServerSetup = {0xAFE2FA32, 0x41B1, 0x459D, [0xA5, 0xDE, 0x49, 0xAD, 0xD8, 0xA7, 0x21, 0x82]};
@GUID(0xAFE2FA32, 0x41B1, 0x459D, [0xA5, 0xDE, 0x49, 0xAD, 0xD8, 0xA7, 0x21, 0x82]);
struct CCertificateEnrollmentPolicyServerSetup;

const GUID IID_ICertSrvSetupKeyInformation = {0x6BA73778, 0x36DA, 0x4C39, [0x8A, 0x85, 0xBC, 0xFA, 0x7D, 0x00, 0x07, 0x93]};
@GUID(0x6BA73778, 0x36DA, 0x4C39, [0x8A, 0x85, 0xBC, 0xFA, 0x7D, 0x00, 0x07, 0x93]);
interface ICertSrvSetupKeyInformation : IDispatch
{
    HRESULT get_ProviderName(BSTR* pVal);
    HRESULT put_ProviderName(const(ushort)* bstrVal);
    HRESULT get_Length(int* pVal);
    HRESULT put_Length(int lVal);
    HRESULT get_Existing(short* pVal);
    HRESULT put_Existing(short bVal);
    HRESULT get_ContainerName(BSTR* pVal);
    HRESULT put_ContainerName(const(ushort)* bstrVal);
    HRESULT get_HashAlgorithm(BSTR* pVal);
    HRESULT put_HashAlgorithm(const(ushort)* bstrVal);
    HRESULT get_ExistingCACertificate(VARIANT* pVal);
    HRESULT put_ExistingCACertificate(VARIANT varVal);
}

const GUID IID_ICertSrvSetupKeyInformationCollection = {0xE65C8B00, 0xE58F, 0x41F9, [0xA9, 0xEC, 0xA2, 0x8D, 0x74, 0x27, 0xC8, 0x44]};
@GUID(0xE65C8B00, 0xE58F, 0x41F9, [0xA9, 0xEC, 0xA2, 0x8D, 0x74, 0x27, 0xC8, 0x44]);
interface ICertSrvSetupKeyInformationCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppVal);
    HRESULT get_Item(int Index, VARIANT* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT Add(ICertSrvSetupKeyInformation pIKeyInformation);
}

enum CASetupProperty
{
    ENUM_SETUPPROP_INVALID = -1,
    ENUM_SETUPPROP_CATYPE = 0,
    ENUM_SETUPPROP_CAKEYINFORMATION = 1,
    ENUM_SETUPPROP_INTERACTIVE = 2,
    ENUM_SETUPPROP_CANAME = 3,
    ENUM_SETUPPROP_CADSSUFFIX = 4,
    ENUM_SETUPPROP_VALIDITYPERIOD = 5,
    ENUM_SETUPPROP_VALIDITYPERIODUNIT = 6,
    ENUM_SETUPPROP_EXPIRATIONDATE = 7,
    ENUM_SETUPPROP_PRESERVEDATABASE = 8,
    ENUM_SETUPPROP_DATABASEDIRECTORY = 9,
    ENUM_SETUPPROP_LOGDIRECTORY = 10,
    ENUM_SETUPPROP_SHAREDFOLDER = 11,
    ENUM_SETUPPROP_PARENTCAMACHINE = 12,
    ENUM_SETUPPROP_PARENTCANAME = 13,
    ENUM_SETUPPROP_REQUESTFILE = 14,
    ENUM_SETUPPROP_WEBCAMACHINE = 15,
    ENUM_SETUPPROP_WEBCANAME = 16,
}

const GUID IID_ICertSrvSetup = {0xB760A1BB, 0x4784, 0x44C0, [0x8F, 0x12, 0x55, 0x5F, 0x07, 0x80, 0xFF, 0x25]};
@GUID(0xB760A1BB, 0x4784, 0x44C0, [0x8F, 0x12, 0x55, 0x5F, 0x07, 0x80, 0xFF, 0x25]);
interface ICertSrvSetup : IDispatch
{
    HRESULT get_CAErrorId(int* pVal);
    HRESULT get_CAErrorString(BSTR* pVal);
    HRESULT InitializeDefaults(short bServer, short bClient);
    HRESULT GetCASetupProperty(CASetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetCASetupProperty(CASetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT IsPropertyEditable(CASetupProperty propertyId, short* pbEditable);
    HRESULT GetSupportedCATypes(VARIANT* pCATypes);
    HRESULT GetProviderNameList(VARIANT* pVal);
    HRESULT GetKeyLengthList(const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT GetHashAlgorithmList(const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT GetPrivateKeyContainerList(const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT GetExistingCACertificates(ICertSrvSetupKeyInformationCollection* ppVal);
    HRESULT CAImportPFX(const(ushort)* bstrFileName, const(ushort)* bstrPasswd, short bOverwriteExistingKey, ICertSrvSetupKeyInformation* ppVal);
    HRESULT SetCADistinguishedName(const(ushort)* bstrCADN, short bIgnoreUnicode, short bOverwriteExistingKey, short bOverwriteExistingCAInDS);
    HRESULT SetDatabaseInformation(const(ushort)* bstrDBDirectory, const(ushort)* bstrLogDirectory, const(ushort)* bstrSharedFolder, short bForceOverwrite);
    HRESULT SetParentCAInformation(const(ushort)* bstrCAConfiguration);
    HRESULT SetWebCAInformation(const(ushort)* bstrCAConfiguration);
    HRESULT Install();
    HRESULT PreUnInstall(short bClientOnly);
    HRESULT PostUnInstall();
}

enum MSCEPSetupProperty
{
    ENUM_CEPSETUPPROP_USELOCALSYSTEM = 0,
    ENUM_CEPSETUPPROP_USECHALLENGE = 1,
    ENUM_CEPSETUPPROP_RANAME_CN = 2,
    ENUM_CEPSETUPPROP_RANAME_EMAIL = 3,
    ENUM_CEPSETUPPROP_RANAME_COMPANY = 4,
    ENUM_CEPSETUPPROP_RANAME_DEPT = 5,
    ENUM_CEPSETUPPROP_RANAME_CITY = 6,
    ENUM_CEPSETUPPROP_RANAME_STATE = 7,
    ENUM_CEPSETUPPROP_RANAME_COUNTRY = 8,
    ENUM_CEPSETUPPROP_SIGNINGKEYINFORMATION = 9,
    ENUM_CEPSETUPPROP_EXCHANGEKEYINFORMATION = 10,
    ENUM_CEPSETUPPROP_CAINFORMATION = 11,
    ENUM_CEPSETUPPROP_MSCEPURL = 12,
    ENUM_CEPSETUPPROP_CHALLENGEURL = 13,
}

const GUID IID_IMSCEPSetup = {0x4F7761BB, 0x9F3B, 0x4592, [0x9E, 0xE0, 0x9A, 0x73, 0x25, 0x9C, 0x31, 0x3E]};
@GUID(0x4F7761BB, 0x9F3B, 0x4592, [0x9E, 0xE0, 0x9A, 0x73, 0x25, 0x9C, 0x31, 0x3E]);
interface IMSCEPSetup : IDispatch
{
    HRESULT get_MSCEPErrorId(int* pVal);
    HRESULT get_MSCEPErrorString(BSTR* pVal);
    HRESULT InitializeDefaults();
    HRESULT GetMSCEPSetupProperty(MSCEPSetupProperty propertyId, VARIANT* pVal);
    HRESULT SetMSCEPSetupProperty(MSCEPSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetAccountInformation(const(ushort)* bstrUserName, const(ushort)* bstrPassword);
    HRESULT IsMSCEPStoreEmpty(short* pbEmpty);
    HRESULT GetProviderNameList(short bExchange, VARIANT* pVal);
    HRESULT GetKeyLengthList(short bExchange, const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT Install();
    HRESULT PreUnInstall();
    HRESULT PostUnInstall();
}

enum CESSetupProperty
{
    ENUM_CESSETUPPROP_USE_IISAPPPOOLIDENTITY = 0,
    ENUM_CESSETUPPROP_CACONFIG = 1,
    ENUM_CESSETUPPROP_AUTHENTICATION = 2,
    ENUM_CESSETUPPROP_SSLCERTHASH = 3,
    ENUM_CESSETUPPROP_URL = 4,
    ENUM_CESSETUPPROP_RENEWALONLY = 5,
    ENUM_CESSETUPPROP_ALLOW_KEYBASED_RENEWAL = 6,
}

const GUID IID_ICertificateEnrollmentServerSetup = {0x70027FDB, 0x9DD9, 0x4921, [0x89, 0x44, 0xB3, 0x5C, 0xB3, 0x1B, 0xD2, 0xEC]};
@GUID(0x70027FDB, 0x9DD9, 0x4921, [0x89, 0x44, 0xB3, 0x5C, 0xB3, 0x1B, 0xD2, 0xEC]);
interface ICertificateEnrollmentServerSetup : IDispatch
{
    HRESULT get_ErrorString(BSTR* pVal);
    HRESULT InitializeInstallDefaults();
    HRESULT GetProperty(CESSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetProperty(CESSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetApplicationPoolCredentials(const(ushort)* bstrUsername, const(ushort)* bstrPassword);
    HRESULT Install();
    HRESULT UnInstall(VARIANT* pCAConfig, VARIANT* pAuthentication);
}

enum CEPSetupProperty
{
    ENUM_CEPSETUPPROP_AUTHENTICATION = 0,
    ENUM_CEPSETUPPROP_SSLCERTHASH = 1,
    ENUM_CEPSETUPPROP_URL = 2,
    ENUM_CEPSETUPPROP_KEYBASED_RENEWAL = 3,
}

const GUID IID_ICertificateEnrollmentPolicyServerSetup = {0x859252CC, 0x238C, 0x4A88, [0xB8, 0xFD, 0xA3, 0x7E, 0x7D, 0x04, 0xE6, 0x8B]};
@GUID(0x859252CC, 0x238C, 0x4A88, [0xB8, 0xFD, 0xA3, 0x7E, 0x7D, 0x04, 0xE6, 0x8B]);
interface ICertificateEnrollmentPolicyServerSetup : IDispatch
{
    HRESULT get_ErrorString(BSTR* pVal);
    HRESULT InitializeInstallDefaults();
    HRESULT GetProperty(CEPSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetProperty(CEPSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT Install();
    HRESULT UnInstall(VARIANT* pAuthKeyBasedRenewal);
}

const GUID CLSID_CCertAdmin = {0x37EABAF0, 0x7FB6, 0x11D0, [0x88, 0x17, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x37EABAF0, 0x7FB6, 0x11D0, [0x88, 0x17, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertAdmin;

const GUID CLSID_CCertView = {0xA12D0F7A, 0x1E84, 0x11D1, [0x9B, 0xD6, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0xA12D0F7A, 0x1E84, 0x11D1, [0x9B, 0xD6, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
struct CCertView;

const GUID CLSID_OCSPPropertyCollection = {0xF935A528, 0xBA8A, 0x4DD9, [0xBA, 0x79, 0xF2, 0x83, 0x27, 0x5C, 0xB2, 0xDE]};
@GUID(0xF935A528, 0xBA8A, 0x4DD9, [0xBA, 0x79, 0xF2, 0x83, 0x27, 0x5C, 0xB2, 0xDE]);
struct OCSPPropertyCollection;

const GUID CLSID_OCSPAdmin = {0xD3F73511, 0x92C9, 0x47CB, [0x8F, 0xF2, 0x8D, 0x89, 0x1A, 0x7C, 0x4D, 0xE4]};
@GUID(0xD3F73511, 0x92C9, 0x47CB, [0x8F, 0xF2, 0x8D, 0x89, 0x1A, 0x7C, 0x4D, 0xE4]);
struct OCSPAdmin;

const GUID IID_IEnumCERTVIEWCOLUMN = {0x9C735BE2, 0x57A5, 0x11D1, [0x9B, 0xDB, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0x9C735BE2, 0x57A5, 0x11D1, [0x9B, 0xDB, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
interface IEnumCERTVIEWCOLUMN : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT GetName(BSTR* pstrOut);
    HRESULT GetDisplayName(BSTR* pstrOut);
    HRESULT GetType(int* pType);
    HRESULT IsIndexed(int* pIndexed);
    HRESULT GetMaxLength(int* pMaxLength);
    HRESULT GetValue(int Flags, VARIANT* pvarValue);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWCOLUMN* ppenum);
}

const GUID IID_IEnumCERTVIEWATTRIBUTE = {0xE77DB656, 0x7653, 0x11D1, [0x9B, 0xDE, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0xE77DB656, 0x7653, 0x11D1, [0x9B, 0xDE, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
interface IEnumCERTVIEWATTRIBUTE : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT GetName(BSTR* pstrOut);
    HRESULT GetValue(BSTR* pstrOut);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWATTRIBUTE* ppenum);
}

const GUID IID_IEnumCERTVIEWEXTENSION = {0xE7DD1466, 0x7653, 0x11D1, [0x9B, 0xDE, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0xE7DD1466, 0x7653, 0x11D1, [0x9B, 0xDE, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
interface IEnumCERTVIEWEXTENSION : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT GetName(BSTR* pstrOut);
    HRESULT GetFlags(int* pFlags);
    HRESULT GetValue(int Type, int Flags, VARIANT* pvarValue);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWEXTENSION* ppenum);
}

const GUID IID_IEnumCERTVIEWROW = {0xD1157F4C, 0x5AF2, 0x11D1, [0x9B, 0xDC, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0xD1157F4C, 0x5AF2, 0x11D1, [0x9B, 0xDC, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
interface IEnumCERTVIEWROW : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT EnumCertViewColumn(IEnumCERTVIEWCOLUMN* ppenum);
    HRESULT EnumCertViewAttribute(int Flags, IEnumCERTVIEWATTRIBUTE* ppenum);
    HRESULT EnumCertViewExtension(int Flags, IEnumCERTVIEWEXTENSION* ppenum);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWROW* ppenum);
    HRESULT GetMaxIndex(int* pIndex);
}

const GUID IID_ICertView = {0xC3FAC344, 0x1E84, 0x11D1, [0x9B, 0xD6, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0xC3FAC344, 0x1E84, 0x11D1, [0x9B, 0xD6, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
interface ICertView : IDispatch
{
    HRESULT OpenConnection(const(ushort)* strConfig);
    HRESULT EnumCertViewColumn(int fResultColumn, IEnumCERTVIEWCOLUMN* ppenum);
    HRESULT GetColumnCount(int fResultColumn, int* pcColumn);
    HRESULT GetColumnIndex(int fResultColumn, const(ushort)* strColumnName, int* pColumnIndex);
    HRESULT SetResultColumnCount(int cResultColumn);
    HRESULT SetResultColumn(int ColumnIndex);
    HRESULT SetRestriction(int ColumnIndex, int SeekOperator, int SortOrder, const(VARIANT)* pvarValue);
    HRESULT OpenView(IEnumCERTVIEWROW* ppenum);
}

const GUID IID_ICertView2 = {0xD594B282, 0x8851, 0x4B61, [0x9C, 0x66, 0x3E, 0xDA, 0xDF, 0x84, 0x88, 0x63]};
@GUID(0xD594B282, 0x8851, 0x4B61, [0x9C, 0x66, 0x3E, 0xDA, 0xDF, 0x84, 0x88, 0x63]);
interface ICertView2 : ICertView
{
    HRESULT SetTable(int Table);
}

const GUID IID_ICertAdmin = {0x34DF6950, 0x7FB6, 0x11D0, [0x88, 0x17, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x34DF6950, 0x7FB6, 0x11D0, [0x88, 0x17, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertAdmin : IDispatch
{
    HRESULT IsValidCertificate(const(ushort)* strConfig, const(ushort)* strSerialNumber, int* pDisposition);
    HRESULT GetRevocationReason(int* pReason);
    HRESULT RevokeCertificate(const(ushort)* strConfig, const(ushort)* strSerialNumber, int Reason, double Date);
    HRESULT SetRequestAttributes(const(ushort)* strConfig, int RequestId, const(ushort)* strAttributes);
    HRESULT SetCertificateExtension(const(ushort)* strConfig, int RequestId, const(ushort)* strExtensionName, int Type, int Flags, const(VARIANT)* pvarValue);
    HRESULT DenyRequest(const(ushort)* strConfig, int RequestId);
    HRESULT ResubmitRequest(const(ushort)* strConfig, int RequestId, int* pDisposition);
    HRESULT PublishCRL(const(ushort)* strConfig, double Date);
    HRESULT GetCRL(const(ushort)* strConfig, int Flags, BSTR* pstrCRL);
    HRESULT ImportCertificate(const(ushort)* strConfig, const(ushort)* strCertificate, int Flags, int* pRequestId);
}

const GUID IID_ICertAdmin2 = {0xF7C3AC41, 0xB8CE, 0x4FB4, [0xAA, 0x58, 0x3D, 0x1D, 0xC0, 0xE3, 0x6B, 0x39]};
@GUID(0xF7C3AC41, 0xB8CE, 0x4FB4, [0xAA, 0x58, 0x3D, 0x1D, 0xC0, 0xE3, 0x6B, 0x39]);
interface ICertAdmin2 : ICertAdmin
{
    HRESULT PublishCRLs(const(ushort)* strConfig, double Date, int CRLFlags);
    HRESULT GetCAProperty(const(ushort)* strConfig, int PropId, int PropIndex, int PropType, int Flags, VARIANT* pvarPropertyValue);
    HRESULT SetCAProperty(const(ushort)* strConfig, int PropId, int PropIndex, int PropType, VARIANT* pvarPropertyValue);
    HRESULT GetCAPropertyFlags(const(ushort)* strConfig, int PropId, int* pPropFlags);
    HRESULT GetCAPropertyDisplayName(const(ushort)* strConfig, int PropId, BSTR* pstrDisplayName);
    HRESULT GetArchivedKey(const(ushort)* strConfig, int RequestId, int Flags, BSTR* pstrArchivedKey);
    HRESULT GetConfigEntry(const(ushort)* strConfig, const(ushort)* strNodePath, const(ushort)* strEntryName, VARIANT* pvarEntry);
    HRESULT SetConfigEntry(const(ushort)* strConfig, const(ushort)* strNodePath, const(ushort)* strEntryName, VARIANT* pvarEntry);
    HRESULT ImportKey(const(ushort)* strConfig, int RequestId, const(ushort)* strCertHash, int Flags, const(ushort)* strKey);
    HRESULT GetMyRoles(const(ushort)* strConfig, int* pRoles);
    HRESULT DeleteRow(const(ushort)* strConfig, int Flags, double Date, int Table, int RowId, int* pcDeleted);
}

const GUID IID_IOCSPProperty = {0x66FB7839, 0x5F04, 0x4C25, [0xAD, 0x18, 0x9F, 0xF1, 0xA8, 0x37, 0x6E, 0xE0]};
@GUID(0x66FB7839, 0x5F04, 0x4C25, [0xAD, 0x18, 0x9F, 0xF1, 0xA8, 0x37, 0x6E, 0xE0]);
interface IOCSPProperty : IDispatch
{
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_Value(VARIANT* pVal);
    HRESULT put_Value(VARIANT newVal);
    HRESULT get_Modified(short* pVal);
}

const GUID IID_IOCSPPropertyCollection = {0x2597C18D, 0x54E6, 0x4B74, [0x9F, 0xA9, 0xA6, 0xBF, 0xDA, 0x99, 0xCB, 0xBE]};
@GUID(0x2597C18D, 0x54E6, 0x4B74, [0x9F, 0xA9, 0xA6, 0xBF, 0xDA, 0x99, 0xCB, 0xBE]);
interface IOCSPPropertyCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppVal);
    HRESULT get_Item(int Index, VARIANT* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get_ItemByName(const(ushort)* bstrPropName, VARIANT* pVal);
    HRESULT CreateProperty(const(ushort)* bstrPropName, const(VARIANT)* pVarPropValue, IOCSPProperty* ppVal);
    HRESULT DeleteProperty(const(ushort)* bstrPropName);
    HRESULT InitializeFromProperties(const(VARIANT)* pVarProperties);
    HRESULT GetAllProperties(VARIANT* pVarProperties);
}

const GUID IID_IOCSPCAConfiguration = {0xAEC92B40, 0x3D46, 0x433F, [0x87, 0xD1, 0xB8, 0x4D, 0x5C, 0x1E, 0x79, 0x0D]};
@GUID(0xAEC92B40, 0x3D46, 0x433F, [0x87, 0xD1, 0xB8, 0x4D, 0x5C, 0x1E, 0x79, 0x0D]);
interface IOCSPCAConfiguration : IDispatch
{
    HRESULT get_Identifier(BSTR* pVal);
    HRESULT get_CACertificate(VARIANT* pVal);
    HRESULT get_HashAlgorithm(BSTR* pVal);
    HRESULT put_HashAlgorithm(const(ushort)* newVal);
    HRESULT get_SigningFlags(uint* pVal);
    HRESULT put_SigningFlags(uint newVal);
    HRESULT get_SigningCertificate(VARIANT* pVal);
    HRESULT put_SigningCertificate(VARIANT newVal);
    HRESULT get_ReminderDuration(uint* pVal);
    HRESULT put_ReminderDuration(uint newVal);
    HRESULT get_ErrorCode(uint* pVal);
    HRESULT get_CSPName(BSTR* pVal);
    HRESULT get_KeySpec(uint* pVal);
    HRESULT get_ProviderCLSID(BSTR* pVal);
    HRESULT put_ProviderCLSID(const(ushort)* newVal);
    HRESULT get_ProviderProperties(VARIANT* pVal);
    HRESULT put_ProviderProperties(VARIANT newVal);
    HRESULT get_Modified(short* pVal);
    HRESULT get_LocalRevocationInformation(VARIANT* pVal);
    HRESULT put_LocalRevocationInformation(VARIANT newVal);
    HRESULT get_SigningCertificateTemplate(BSTR* pVal);
    HRESULT put_SigningCertificateTemplate(const(ushort)* newVal);
    HRESULT get_CAConfig(BSTR* pVal);
    HRESULT put_CAConfig(const(ushort)* newVal);
}

const GUID IID_IOCSPCAConfigurationCollection = {0x2BEBEA0B, 0x5ECE, 0x4F28, [0xA9, 0x1C, 0x86, 0xB4, 0xBB, 0x20, 0xF0, 0xD3]};
@GUID(0x2BEBEA0B, 0x5ECE, 0x4F28, [0xA9, 0x1C, 0x86, 0xB4, 0xBB, 0x20, 0xF0, 0xD3]);
interface IOCSPCAConfigurationCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Item(int Index, VARIANT* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get_ItemByName(const(ushort)* bstrIdentifier, VARIANT* pVal);
    HRESULT CreateCAConfiguration(const(ushort)* bstrIdentifier, VARIANT varCACert, IOCSPCAConfiguration* ppVal);
    HRESULT DeleteCAConfiguration(const(ushort)* bstrIdentifier);
}

const GUID IID_IOCSPAdmin = {0x322E830D, 0x67DB, 0x4FE9, [0x95, 0x77, 0x45, 0x96, 0xD9, 0xF0, 0x92, 0x94]};
@GUID(0x322E830D, 0x67DB, 0x4FE9, [0x95, 0x77, 0x45, 0x96, 0xD9, 0xF0, 0x92, 0x94]);
interface IOCSPAdmin : IDispatch
{
    HRESULT get_OCSPServiceProperties(IOCSPPropertyCollection* ppVal);
    HRESULT get_OCSPCAConfigurationCollection(IOCSPCAConfigurationCollection* pVal);
    HRESULT GetConfiguration(const(ushort)* bstrServerName, short bForce);
    HRESULT SetConfiguration(const(ushort)* bstrServerName, short bForce);
    HRESULT GetMyRoles(const(ushort)* bstrServerName, int* pRoles);
    HRESULT Ping(const(ushort)* bstrServerName);
    HRESULT SetSecurity(const(ushort)* bstrServerName, const(ushort)* bstrVal);
    HRESULT GetSecurity(const(ushort)* bstrServerName, BSTR* pVal);
    HRESULT GetSigningCertificates(const(ushort)* bstrServerName, const(VARIANT)* pCACertVar, VARIANT* pVal);
    HRESULT GetHashAlgorithms(const(ushort)* bstrServerName, const(ushort)* bstrCAId, VARIANT* pVal);
}

enum OCSPSigningFlag
{
    OCSP_SF_SILENT = 1,
    OCSP_SF_USE_CACERT = 2,
    OCSP_SF_ALLOW_SIGNINGCERT_AUTORENEWAL = 4,
    OCSP_SF_FORCE_SIGNINGCERT_ISSUER_ISCA = 8,
    OCSP_SF_AUTODISCOVER_SIGNINGCERT = 16,
    OCSP_SF_MANUAL_ASSIGN_SIGNINGCERT = 32,
    OCSP_SF_RESPONDER_ID_KEYHASH = 64,
    OCSP_SF_RESPONDER_ID_NAME = 128,
    OCSP_SF_ALLOW_NONCE_EXTENSION = 256,
    OCSP_SF_ALLOW_SIGNINGCERT_AUTOENROLLMENT = 512,
}

enum OCSPRequestFlag
{
    OCSP_RF_REJECT_SIGNED_REQUESTS = 1,
}

const GUID CLSID_CCertEncodeStringArray = {0x19A76FE0, 0x7494, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x19A76FE0, 0x7494, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertEncodeStringArray;

const GUID CLSID_CCertEncodeLongArray = {0x4E0680A0, 0xA0A2, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x4E0680A0, 0xA0A2, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertEncodeLongArray;

const GUID CLSID_CCertEncodeDateArray = {0x301F77B0, 0xA470, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x301F77B0, 0xA470, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertEncodeDateArray;

const GUID CLSID_CCertEncodeCRLDistInfo = {0x01FA60A0, 0xBBFF, 0x11D0, [0x88, 0x25, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x01FA60A0, 0xBBFF, 0x11D0, [0x88, 0x25, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
struct CCertEncodeCRLDistInfo;

const GUID CLSID_CCertEncodeAltName = {0x1CFC4CDA, 0x1271, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0x1CFC4CDA, 0x1271, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
struct CCertEncodeAltName;

const GUID CLSID_CCertEncodeBitString = {0x6D6B3CD8, 0x1278, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0x6D6B3CD8, 0x1278, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
struct CCertEncodeBitString;

const GUID IID_ICertEncodeStringArray = {0x12A88820, 0x7494, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x12A88820, 0x7494, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertEncodeStringArray : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetStringType(int* pStringType);
    HRESULT GetCount(int* pCount);
    HRESULT GetValue(int Index, BSTR* pstr);
    HRESULT Reset(int Count, int StringType);
    HRESULT SetValue(int Index, const(ushort)* str);
    HRESULT Encode(BSTR* pstrBinary);
}

const GUID IID_ICertEncodeStringArray2 = {0x9C680D93, 0x9B7D, 0x4E95, [0x90, 0x18, 0x4F, 0xFE, 0x10, 0xBA, 0x5A, 0xDA]};
@GUID(0x9C680D93, 0x9B7D, 0x4E95, [0x90, 0x18, 0x4F, 0xFE, 0x10, 0xBA, 0x5A, 0xDA]);
interface ICertEncodeStringArray2 : ICertEncodeStringArray
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

const GUID IID_ICertEncodeLongArray = {0x15E2F230, 0xA0A2, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x15E2F230, 0xA0A2, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertEncodeLongArray : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetCount(int* pCount);
    HRESULT GetValue(int Index, int* pValue);
    HRESULT Reset(int Count);
    HRESULT SetValue(int Index, int Value);
    HRESULT Encode(BSTR* pstrBinary);
}

const GUID IID_ICertEncodeLongArray2 = {0x4EFDE84A, 0xBD9B, 0x4FC2, [0xA1, 0x08, 0xC3, 0x47, 0xD4, 0x78, 0x84, 0x0F]};
@GUID(0x4EFDE84A, 0xBD9B, 0x4FC2, [0xA1, 0x08, 0xC3, 0x47, 0xD4, 0x78, 0x84, 0x0F]);
interface ICertEncodeLongArray2 : ICertEncodeLongArray
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

const GUID IID_ICertEncodeDateArray = {0x2F9469A0, 0xA470, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x2F9469A0, 0xA470, 0x11D0, [0x88, 0x21, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertEncodeDateArray : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetCount(int* pCount);
    HRESULT GetValue(int Index, double* pValue);
    HRESULT Reset(int Count);
    HRESULT SetValue(int Index, double Value);
    HRESULT Encode(BSTR* pstrBinary);
}

const GUID IID_ICertEncodeDateArray2 = {0x99A4EDB5, 0x2B8E, 0x448D, [0xBF, 0x95, 0xBB, 0xA8, 0xD7, 0x78, 0x9D, 0xC8]};
@GUID(0x99A4EDB5, 0x2B8E, 0x448D, [0xBF, 0x95, 0xBB, 0xA8, 0xD7, 0x78, 0x9D, 0xC8]);
interface ICertEncodeDateArray2 : ICertEncodeDateArray
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

const GUID IID_ICertEncodeCRLDistInfo = {0x01958640, 0xBBFF, 0x11D0, [0x88, 0x25, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0x01958640, 0xBBFF, 0x11D0, [0x88, 0x25, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertEncodeCRLDistInfo : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetDistPointCount(int* pDistPointCount);
    HRESULT GetNameCount(int DistPointIndex, int* pNameCount);
    HRESULT GetNameChoice(int DistPointIndex, int NameIndex, int* pNameChoice);
    HRESULT GetName(int DistPointIndex, int NameIndex, BSTR* pstrName);
    HRESULT Reset(int DistPointCount);
    HRESULT SetNameCount(int DistPointIndex, int NameCount);
    HRESULT SetNameEntry(int DistPointIndex, int NameIndex, int NameChoice, const(ushort)* strName);
    HRESULT Encode(BSTR* pstrBinary);
}

const GUID IID_ICertEncodeCRLDistInfo2 = {0xB4275D4B, 0x3E30, 0x446F, [0xAD, 0x36, 0x09, 0xD0, 0x31, 0x20, 0xB0, 0x78]};
@GUID(0xB4275D4B, 0x3E30, 0x446F, [0xAD, 0x36, 0x09, 0xD0, 0x31, 0x20, 0xB0, 0x78]);
interface ICertEncodeCRLDistInfo2 : ICertEncodeCRLDistInfo
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

const GUID IID_ICertEncodeAltName = {0x1C9A8C70, 0x1271, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0x1C9A8C70, 0x1271, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
interface ICertEncodeAltName : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetNameCount(int* pNameCount);
    HRESULT GetNameChoice(int NameIndex, int* pNameChoice);
    HRESULT GetName(int NameIndex, BSTR* pstrName);
    HRESULT Reset(int NameCount);
    HRESULT SetNameEntry(int NameIndex, int NameChoice, const(ushort)* strName);
    HRESULT Encode(BSTR* pstrBinary);
}

const GUID IID_ICertEncodeAltName2 = {0xF67FE177, 0x5EF1, 0x4535, [0xB4, 0xCE, 0x29, 0xDF, 0x15, 0xE2, 0xE0, 0xC3]};
@GUID(0xF67FE177, 0x5EF1, 0x4535, [0xB4, 0xCE, 0x29, 0xDF, 0x15, 0xE2, 0xE0, 0xC3]);
interface ICertEncodeAltName2 : ICertEncodeAltName
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
    HRESULT GetNameBlob(int NameIndex, EncodingType Encoding, BSTR* pstrName);
    HRESULT SetNameEntryBlob(int NameIndex, int NameChoice, const(ushort)* strName, EncodingType Encoding);
}

const GUID IID_ICertEncodeBitString = {0x6DB525BE, 0x1278, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]};
@GUID(0x6DB525BE, 0x1278, 0x11D1, [0x9B, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x83, 0xFA]);
interface ICertEncodeBitString : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetBitCount(int* pBitCount);
    HRESULT GetBitString(BSTR* pstrBitString);
    HRESULT Encode(int BitCount, BSTR strBitString, BSTR* pstrBinary);
}

const GUID IID_ICertEncodeBitString2 = {0xE070D6E7, 0x23EF, 0x4DD2, [0x82, 0x42, 0xEB, 0xD9, 0xC9, 0x28, 0xCB, 0x30]};
@GUID(0xE070D6E7, 0x23EF, 0x4DD2, [0x82, 0x42, 0xEB, 0xD9, 0xC9, 0x28, 0xCB, 0x30]);
interface ICertEncodeBitString2 : ICertEncodeBitString
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(int BitCount, const(ushort)* strBitString, EncodingType EncodingIn, EncodingType Encoding, BSTR* pstrEncodedData);
    HRESULT GetBitStringBlob(EncodingType Encoding, BSTR* pstrBitString);
}

const GUID IID_ICertExit = {0xE19AE1A0, 0x7364, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]};
@GUID(0xE19AE1A0, 0x7364, 0x11D0, [0x88, 0x16, 0x00, 0xA0, 0xC9, 0x03, 0xB8, 0x3C]);
interface ICertExit : IDispatch
{
    HRESULT Initialize(const(ushort)* strConfig, int* pEventMask);
    HRESULT Notify(int ExitEvent, int Context);
    HRESULT GetDescription(BSTR* pstrDescription);
}

const GUID IID_ICertExit2 = {0x0ABF484B, 0xD049, 0x464D, [0xA7, 0xED, 0x55, 0x2E, 0x75, 0x29, 0xB0, 0xFF]};
@GUID(0x0ABF484B, 0xD049, 0x464D, [0xA7, 0xED, 0x55, 0x2E, 0x75, 0x29, 0xB0, 0xFF]);
interface ICertExit2 : ICertExit
{
    HRESULT GetManageModule(ICertManageModule* ppManageModule);
}

enum ENUM_CATYPES
{
    ENUM_ENTERPRISE_ROOTCA = 0,
    ENUM_ENTERPRISE_SUBCA = 1,
    ENUM_STANDALONE_ROOTCA = 3,
    ENUM_STANDALONE_SUBCA = 4,
    ENUM_UNKNOWN_CA = 5,
}

struct CAINFO
{
    uint cbSize;
    ENUM_CATYPES CAType;
    uint cCASignatureCerts;
    uint cCAExchangeCerts;
    uint cExitModules;
    int lPropIdMax;
    int lRoleSeparationEnabled;
    uint cKRACertUsedCount;
    uint cKRACertCount;
    uint fAdvancedServer;
}

enum ENUM_PERIOD
{
    ENUM_PERIOD_INVALID = -1,
    ENUM_PERIOD_SECONDS = 0,
    ENUM_PERIOD_MINUTES = 1,
    ENUM_PERIOD_HOURS = 2,
    ENUM_PERIOD_DAYS = 3,
    ENUM_PERIOD_WEEKS = 4,
    ENUM_PERIOD_MONTHS = 5,
    ENUM_PERIOD_YEARS = 6,
}

struct LLFILETIME
{
    _Anonymous_e__Union Anonymous;
}

alias PFNCMFILTERPROC = extern(Windows) BOOL function(CERT_CONTEXT* pCertContext, LPARAM param1, uint param2, uint param3);
alias PFNCMHOOKPROC = extern(Windows) uint function(HWND hwndDialog, uint message, WPARAM wParam, LPARAM lParam);
struct CERT_SELECT_STRUCT_A
{
    uint dwSize;
    HWND hwndParent;
    HINSTANCE hInstance;
    const(char)* pTemplateName;
    uint dwFlags;
    const(char)* szTitle;
    uint cCertStore;
    void** arrayCertStore;
    const(char)* szPurposeOid;
    uint cCertContext;
    CERT_CONTEXT** arrayCertContext;
    LPARAM lCustData;
    PFNCMHOOKPROC pfnHook;
    PFNCMFILTERPROC pfnFilter;
    const(char)* szHelpFileName;
    uint dwHelpId;
    uint hprov;
}

struct CERT_SELECT_STRUCT_W
{
    uint dwSize;
    HWND hwndParent;
    HINSTANCE hInstance;
    const(wchar)* pTemplateName;
    uint dwFlags;
    const(wchar)* szTitle;
    uint cCertStore;
    void** arrayCertStore;
    const(char)* szPurposeOid;
    uint cCertContext;
    CERT_CONTEXT** arrayCertContext;
    LPARAM lCustData;
    PFNCMHOOKPROC pfnHook;
    PFNCMFILTERPROC pfnFilter;
    const(wchar)* szHelpFileName;
    uint dwHelpId;
    uint hprov;
}

struct CERT_VIEWPROPERTIES_STRUCT_A
{
    uint dwSize;
    HWND hwndParent;
    HINSTANCE hInstance;
    uint dwFlags;
    const(char)* szTitle;
    CERT_CONTEXT* pCertContext;
    byte** arrayPurposes;
    uint cArrayPurposes;
    uint cRootStores;
    void** rghstoreRoots;
    uint cStores;
    void** rghstoreCAs;
    uint cTrustStores;
    void** rghstoreTrust;
    uint hprov;
    LPARAM lCustData;
    uint dwPad;
    const(char)* szHelpFileName;
    uint dwHelpId;
    uint nStartPage;
    uint cArrayPropSheetPages;
    PROPSHEETPAGEA* arrayPropSheetPages;
}

struct CERT_VIEWPROPERTIES_STRUCT_W
{
    uint dwSize;
    HWND hwndParent;
    HINSTANCE hInstance;
    uint dwFlags;
    const(wchar)* szTitle;
    CERT_CONTEXT* pCertContext;
    byte** arrayPurposes;
    uint cArrayPurposes;
    uint cRootStores;
    void** rghstoreRoots;
    uint cStores;
    void** rghstoreCAs;
    uint cTrustStores;
    void** rghstoreTrust;
    uint hprov;
    LPARAM lCustData;
    uint dwPad;
    const(wchar)* szHelpFileName;
    uint dwHelpId;
    uint nStartPage;
    uint cArrayPropSheetPages;
    PROPSHEETPAGEA* arrayPropSheetPages;
}

struct tagCMOID
{
    const(char)* szExtensionOID;
    uint dwTestOperation;
    ubyte* pbTestData;
    uint cbTestData;
}

struct tagCMFLTR
{
    uint dwSize;
    uint cExtensionChecks;
    tagCMOID* arrayExtensionChecks;
    uint dwCheckingFlags;
}

alias PFNTRUSTHELPER = extern(Windows) HRESULT function(CERT_CONTEXT* pCertContext, LPARAM lCustData, BOOL fLeafCertificate, ubyte* pbTrustBlob);
struct CERT_VERIFY_CERTIFICATE_TRUST
{
    uint cbSize;
    CERT_CONTEXT* pccert;
    uint dwFlags;
    uint dwIgnoreErr;
    uint* pdwErrors;
    const(char)* pszUsageOid;
    uint hprov;
    uint cRootStores;
    void** rghstoreRoots;
    uint cStores;
    void** rghstoreCAs;
    uint cTrustStores;
    void** rghstoreTrust;
    LPARAM lCustData;
    PFNTRUSTHELPER pfnTrustHelper;
    uint* pcChain;
    CERT_CONTEXT*** prgChain;
    uint** prgdwErrors;
    CRYPTOAPI_BLOB** prgpbTrustInfo;
}

struct CTL_MODIFY_REQUEST
{
    CERT_CONTEXT* pccert;
    uint dwOperation;
    uint dwError;
}

struct WINTRUST_DATA
{
    uint cbStruct;
    void* pPolicyCallbackData;
    void* pSIPClientData;
    uint dwUIChoice;
    uint fdwRevocationChecks;
    uint dwUnionChoice;
    _Anonymous_e__Union Anonymous;
    uint dwStateAction;
    HANDLE hWVTStateData;
    ushort* pwszURLReference;
    uint dwProvFlags;
    uint dwUIContext;
    WINTRUST_SIGNATURE_SETTINGS* pSignatureSettings;
}

struct WINTRUST_SIGNATURE_SETTINGS
{
    uint cbStruct;
    uint dwIndex;
    uint dwFlags;
    uint cSecondarySigs;
    uint dwVerifiedSigIndex;
    CERT_STRONG_SIGN_PARA* pCryptoPolicy;
}

struct WINTRUST_FILE_INFO
{
    uint cbStruct;
    const(wchar)* pcwszFilePath;
    HANDLE hFile;
    Guid* pgKnownSubject;
}

struct WINTRUST_CATALOG_INFO
{
    uint cbStruct;
    uint dwCatalogVersion;
    const(wchar)* pcwszCatalogFilePath;
    const(wchar)* pcwszMemberTag;
    const(wchar)* pcwszMemberFilePath;
    HANDLE hMemberFile;
    ubyte* pbCalculatedFileHash;
    uint cbCalculatedFileHash;
    CTL_CONTEXT* pcCatalogContext;
    int hCatAdmin;
}

struct WINTRUST_BLOB_INFO
{
    uint cbStruct;
    Guid gSubject;
    const(wchar)* pcwszDisplayName;
    uint cbMemObject;
    ubyte* pbMemObject;
    uint cbMemSignedMsg;
    ubyte* pbMemSignedMsg;
}

struct WINTRUST_SGNR_INFO
{
    uint cbStruct;
    const(wchar)* pcwszDisplayName;
    CMSG_SIGNER_INFO* psSignerInfo;
    uint chStores;
    void** pahStores;
}

struct WINTRUST_CERT_INFO
{
    uint cbStruct;
    const(wchar)* pcwszDisplayName;
    CERT_CONTEXT* psCertContext;
    uint chStores;
    void** pahStores;
    uint dwFlags;
    FILETIME* psftVerifyAsOf;
}

alias PFN_CPD_MEM_ALLOC = extern(Windows) void* function(uint cbSize);
alias PFN_CPD_MEM_FREE = extern(Windows) void function(void* pvMem2Free);
alias PFN_CPD_ADD_STORE = extern(Windows) BOOL function(CRYPT_PROVIDER_DATA* pProvData, void* hStore2Add);
alias PFN_CPD_ADD_SGNR = extern(Windows) BOOL function(CRYPT_PROVIDER_DATA* pProvData, BOOL fCounterSigner, uint idxSigner, CRYPT_PROVIDER_SGNR* pSgnr2Add);
alias PFN_CPD_ADD_CERT = extern(Windows) BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, BOOL fCounterSigner, uint idxCounterSigner, CERT_CONTEXT* pCert2Add);
alias PFN_CPD_ADD_PRIVDATA = extern(Windows) BOOL function(CRYPT_PROVIDER_DATA* pProvData, CRYPT_PROVIDER_PRIVDATA* pPrivData2Add);
alias PFN_PROVIDER_INIT_CALL = extern(Windows) HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_OBJTRUST_CALL = extern(Windows) HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_SIGTRUST_CALL = extern(Windows) HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTTRUST_CALL = extern(Windows) HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_FINALPOLICY_CALL = extern(Windows) HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_TESTFINALPOLICY_CALL = extern(Windows) HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CLEANUP_CALL = extern(Windows) HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTCHKPOLICY_CALL = extern(Windows) BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, BOOL fCounterSignerChain, uint idxCounterSigner);
struct CRYPT_PROVIDER_DATA
{
    uint cbStruct;
    WINTRUST_DATA* pWintrustData;
    BOOL fOpenedFile;
    HWND hWndParent;
    Guid* pgActionID;
    uint hProv;
    uint dwError;
    uint dwRegSecuritySettings;
    uint dwRegPolicySettings;
    CRYPT_PROVIDER_FUNCTIONS* psPfns;
    uint cdwTrustStepErrors;
    uint* padwTrustStepErrors;
    uint chStores;
    void** pahStores;
    uint dwEncoding;
    void* hMsg;
    uint csSigners;
    CRYPT_PROVIDER_SGNR* pasSigners;
    uint csProvPrivData;
    CRYPT_PROVIDER_PRIVDATA* pasProvPrivData;
    uint dwSubjectChoice;
    _Anonymous_e__Union Anonymous;
    byte* pszUsageOID;
    BOOL fRecallWithState;
    FILETIME sftSystemTime;
    byte* pszCTLSignerUsageOID;
    uint dwProvFlags;
    uint dwFinalError;
    CERT_USAGE_MATCH* pRequestUsage;
    uint dwTrustPubSettings;
    uint dwUIStateFlags;
    CRYPT_PROVIDER_SIGSTATE* pSigState;
    WINTRUST_SIGNATURE_SETTINGS* pSigSettings;
}

struct CRYPT_PROVIDER_SIGSTATE
{
    uint cbStruct;
    void** rhSecondarySigs;
    void* hPrimarySig;
    BOOL fFirstAttemptMade;
    BOOL fNoMoreSigs;
    uint cSecondarySigs;
    uint dwCurrentIndex;
    BOOL fSupportMultiSig;
    uint dwCryptoPolicySupport;
    uint iAttemptCount;
    BOOL fCheckedSealing;
    SEALING_SIGNATURE_ATTRIBUTE* pSealingSignature;
}

struct CRYPT_PROVIDER_FUNCTIONS
{
    uint cbStruct;
    PFN_CPD_MEM_ALLOC pfnAlloc;
    PFN_CPD_MEM_FREE pfnFree;
    PFN_CPD_ADD_STORE pfnAddStore2Chain;
    PFN_CPD_ADD_SGNR pfnAddSgnr2Chain;
    PFN_CPD_ADD_CERT pfnAddCert2Chain;
    PFN_CPD_ADD_PRIVDATA pfnAddPrivData2Chain;
    PFN_PROVIDER_INIT_CALL pfnInitialize;
    PFN_PROVIDER_OBJTRUST_CALL pfnObjectTrust;
    PFN_PROVIDER_SIGTRUST_CALL pfnSignatureTrust;
    PFN_PROVIDER_CERTTRUST_CALL pfnCertificateTrust;
    PFN_PROVIDER_FINALPOLICY_CALL pfnFinalPolicy;
    PFN_PROVIDER_CERTCHKPOLICY_CALL pfnCertCheckPolicy;
    PFN_PROVIDER_TESTFINALPOLICY_CALL pfnTestFinalPolicy;
    CRYPT_PROVUI_FUNCS* psUIpfns;
    PFN_PROVIDER_CLEANUP_CALL pfnCleanupPolicy;
}

alias PFN_PROVUI_CALL = extern(Windows) BOOL function(HWND hWndSecurityDialog, CRYPT_PROVIDER_DATA* pProvData);
struct CRYPT_PROVUI_FUNCS
{
    uint cbStruct;
    CRYPT_PROVUI_DATA* psUIData;
    PFN_PROVUI_CALL pfnOnMoreInfoClick;
    PFN_PROVUI_CALL pfnOnMoreInfoClickDefault;
    PFN_PROVUI_CALL pfnOnAdvancedClick;
    PFN_PROVUI_CALL pfnOnAdvancedClickDefault;
}

struct CRYPT_PROVUI_DATA
{
    uint cbStruct;
    uint dwFinalError;
    ushort* pYesButtonText;
    ushort* pNoButtonText;
    ushort* pMoreInfoButtonText;
    ushort* pAdvancedLinkText;
    ushort* pCopyActionText;
    ushort* pCopyActionTextNoTS;
    ushort* pCopyActionTextNotSigned;
}

struct CRYPT_PROVIDER_SGNR
{
    uint cbStruct;
    FILETIME sftVerifyAsOf;
    uint csCertChain;
    CRYPT_PROVIDER_CERT* pasCertChain;
    uint dwSignerType;
    CMSG_SIGNER_INFO* psSigner;
    uint dwError;
    uint csCounterSigners;
    CRYPT_PROVIDER_SGNR* pasCounterSigners;
    CERT_CHAIN_CONTEXT* pChainContext;
}

struct CRYPT_PROVIDER_CERT
{
    uint cbStruct;
    CERT_CONTEXT* pCert;
    BOOL fCommercial;
    BOOL fTrustedRoot;
    BOOL fSelfSigned;
    BOOL fTestCert;
    uint dwRevokedReason;
    uint dwConfidence;
    uint dwError;
    CTL_CONTEXT* pTrustListContext;
    BOOL fTrustListSignerCert;
    CTL_CONTEXT* pCtlContext;
    uint dwCtlError;
    BOOL fIsCyclic;
    CERT_CHAIN_ELEMENT* pChainElement;
}

struct CRYPT_PROVIDER_PRIVDATA
{
    uint cbStruct;
    Guid gProviderID;
    uint cbProvData;
    void* pvProvData;
}

struct PROVDATA_SIP
{
    uint cbStruct;
    Guid gSubject;
    SIP_DISPATCH_INFO* pSip;
    SIP_DISPATCH_INFO* pCATSip;
    SIP_SUBJECTINFO* psSipSubjectInfo;
    SIP_SUBJECTINFO* psSipCATSubjectInfo;
    SIP_INDIRECT_DATA* psIndirectData;
}

struct CRYPT_TRUST_REG_ENTRY
{
    uint cbStruct;
    ushort* pwszDLLName;
    ushort* pwszFunctionName;
}

struct CRYPT_REGISTER_ACTIONID
{
    uint cbStruct;
    CRYPT_TRUST_REG_ENTRY sInitProvider;
    CRYPT_TRUST_REG_ENTRY sObjectProvider;
    CRYPT_TRUST_REG_ENTRY sSignatureProvider;
    CRYPT_TRUST_REG_ENTRY sCertificateProvider;
    CRYPT_TRUST_REG_ENTRY sCertificatePolicyProvider;
    CRYPT_TRUST_REG_ENTRY sFinalPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sTestPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sCleanupProvider;
}

alias PFN_ALLOCANDFILLDEFUSAGE = extern(Windows) BOOL function(const(byte)* pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
alias PFN_FREEDEFUSAGE = extern(Windows) BOOL function(const(byte)* pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
struct CRYPT_PROVIDER_REGDEFUSAGE
{
    uint cbStruct;
    Guid* pgActionID;
    ushort* pwszDllName;
    byte* pwszLoadCallbackDataFunctionName;
    byte* pwszFreeCallbackDataFunctionName;
}

struct CRYPT_PROVIDER_DEFUSAGE
{
    uint cbStruct;
    Guid gActionID;
    void* pDefPolicyCallbackData;
    void* pDefSIPClientData;
}

struct SPC_SERIALIZED_OBJECT
{
    ubyte ClassId;
    CRYPTOAPI_BLOB SerializedData;
}

struct SPC_SIGINFO
{
    uint dwSipVersion;
    Guid gSIPGuid;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwReserved4;
    uint dwReserved5;
}

struct SPC_LINK
{
    uint dwLinkChoice;
    _Anonymous_e__Union Anonymous;
}

struct SPC_PE_IMAGE_DATA
{
    CRYPT_BIT_BLOB Flags;
    SPC_LINK* pFile;
}

struct SPC_INDIRECT_DATA_CONTENT
{
    CRYPT_ATTRIBUTE_TYPE_VALUE Data;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    CRYPTOAPI_BLOB Digest;
}

struct SPC_FINANCIAL_CRITERIA
{
    BOOL fFinancialInfoAvailable;
    BOOL fMeetsCriteria;
}

struct SPC_IMAGE
{
    SPC_LINK* pImageLink;
    CRYPTOAPI_BLOB Bitmap;
    CRYPTOAPI_BLOB Metafile;
    CRYPTOAPI_BLOB EnhancedMetafile;
    CRYPTOAPI_BLOB GifFile;
}

struct SPC_SP_AGENCY_INFO
{
    SPC_LINK* pPolicyInformation;
    const(wchar)* pwszPolicyDisplayText;
    SPC_IMAGE* pLogoImage;
    SPC_LINK* pLogoLink;
}

struct SPC_STATEMENT_TYPE
{
    uint cKeyPurposeId;
    byte** rgpszKeyPurposeId;
}

struct SPC_SP_OPUS_INFO
{
    const(wchar)* pwszProgramName;
    SPC_LINK* pMoreInfo;
    SPC_LINK* pPublisherInfo;
}

struct CAT_NAMEVALUE
{
    const(wchar)* pwszTag;
    uint fdwFlags;
    CRYPTOAPI_BLOB Value;
}

struct CAT_MEMBERINFO
{
    const(wchar)* pwszSubjGuid;
    uint dwCertVersion;
}

struct CAT_MEMBERINFO2
{
    Guid SubjectGuid;
    uint dwCertVersion;
}

struct INTENT_TO_SEAL_ATTRIBUTE
{
    uint version;
    ubyte seal;
}

struct SEALING_SIGNATURE_ATTRIBUTE
{
    uint version;
    uint signerIndex;
    CRYPT_ALGORITHM_IDENTIFIER signatureAlgorithm;
    CRYPTOAPI_BLOB encryptedDigest;
}

struct SEALING_TIMESTAMP_ATTRIBUTE
{
    uint version;
    uint signerIndex;
    CRYPTOAPI_BLOB sealTimeStampToken;
}

struct WIN_CERTIFICATE
{
    uint dwLength;
    ushort wRevision;
    ushort wCertificateType;
    ubyte bCertificate;
}

struct WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT
{
    HANDLE hClientToken;
    Guid* SubjectType;
    void* Subject;
}

struct WIN_TRUST_ACTDATA_SUBJECT_ONLY
{
    Guid* SubjectType;
    void* Subject;
}

struct WIN_TRUST_SUBJECT_FILE
{
    HANDLE hFile;
    const(wchar)* lpPath;
}

struct WIN_TRUST_SUBJECT_FILE_AND_DISPLAY
{
    HANDLE hFile;
    const(wchar)* lpPath;
    const(wchar)* lpDisplayName;
}

struct WIN_SPUB_TRUSTED_PUBLISHER_DATA
{
    HANDLE hClientToken;
    WIN_CERTIFICATE* lpCertificate;
}

alias PFNCFILTERPROC = extern(Windows) BOOL function(CERT_CONTEXT* pCertContext, int* pfInitialSelectedCert, void* pvCallbackData);
struct CERT_SELECTUI_INPUT
{
    void* hStore;
    CERT_CHAIN_CONTEXT** prgpChain;
    uint cChain;
}

struct CRYPTUI_CERT_MGR_STRUCT
{
    uint dwSize;
    HWND hwndParent;
    uint dwFlags;
    const(wchar)* pwszTitle;
    const(char)* pszInitUsageOID;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_BLOB_INFO
{
    uint dwSize;
    Guid* pGuidSubject;
    uint cbBlob;
    ubyte* pbBlob;
    const(wchar)* pwszDisplayName;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_STORE_INFO
{
    uint dwSize;
    uint cCertStore;
    void** rghCertStore;
    PFNCFILTERPROC pFilterCallback;
    void* pvCallbackData;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE_INFO
{
    uint dwSize;
    const(wchar)* pwszPvkFileName;
    const(wchar)* pwszProvName;
    uint dwProvType;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_CERT_PVK_INFO
{
    uint dwSize;
    const(wchar)* pwszSigningCertFileName;
    uint dwPvkChoice;
    _Anonymous_e__Union Anonymous;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO
{
    uint dwSize;
    uint dwAttrFlags;
    const(wchar)* pwszDescription;
    const(wchar)* pwszMoreInfoLocation;
    const(char)* pszHashAlg;
    const(wchar)* pwszSigningCertDisplayString;
    void* hAdditionalCertStore;
    CRYPT_ATTRIBUTES* psAuthenticated;
    CRYPT_ATTRIBUTES* psUnauthenticated;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_INFO
{
    uint dwSize;
    uint dwSubjectChoice;
    _Anonymous1_e__Union Anonymous1;
    uint dwSigningCertChoice;
    _Anonymous2_e__Union Anonymous2;
    const(wchar)* pwszTimestampURL;
    uint dwAdditionalCertChoice;
    CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO* pSignExtInfo;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT
{
    uint dwSize;
    uint cbBlob;
    ubyte* pbBlob;
}

struct CRYPTUI_INITDIALOG_STRUCT
{
    LPARAM lParam;
    CERT_CONTEXT* pCertContext;
}

struct CRYPTUI_VIEWCERTIFICATE_STRUCTW
{
    uint dwSize;
    HWND hwndParent;
    uint dwFlags;
    const(wchar)* szTitle;
    CERT_CONTEXT* pCertContext;
    byte** rgszPurposes;
    uint cPurposes;
    _Anonymous_e__Union Anonymous;
    BOOL fpCryptProviderDataTrustedUsage;
    uint idxSigner;
    uint idxCert;
    BOOL fCounterSigner;
    uint idxCounterSigner;
    uint cStores;
    void** rghStores;
    uint cPropSheetPages;
    PROPSHEETPAGEW* rgPropSheetPages;
    uint nStartPage;
}

struct CRYPTUI_VIEWCERTIFICATE_STRUCTA
{
    uint dwSize;
    HWND hwndParent;
    uint dwFlags;
    const(char)* szTitle;
    CERT_CONTEXT* pCertContext;
    byte** rgszPurposes;
    uint cPurposes;
    _Anonymous_e__Union Anonymous;
    BOOL fpCryptProviderDataTrustedUsage;
    uint idxSigner;
    uint idxCert;
    BOOL fCounterSigner;
    uint idxCounterSigner;
    uint cStores;
    void** rghStores;
    uint cPropSheetPages;
    PROPSHEETPAGEA* rgPropSheetPages;
    uint nStartPage;
}

struct CRYPTUI_WIZ_EXPORT_INFO
{
    uint dwSize;
    const(wchar)* pwszExportFileName;
    uint dwSubjectChoice;
    _Anonymous_e__Union Anonymous;
    uint cStores;
    void** rghStores;
}

struct CRYPTUI_WIZ_EXPORT_CERTCONTEXT_INFO
{
    uint dwSize;
    uint dwExportFormat;
    BOOL fExportChain;
    BOOL fExportPrivateKeys;
    const(wchar)* pwszPassword;
    BOOL fStrongEncryption;
}

struct CRYPTUI_WIZ_IMPORT_SRC_INFO
{
    uint dwSize;
    uint dwSubjectChoice;
    _Anonymous_e__Union Anonymous;
    uint dwFlags;
    const(wchar)* pwszPassword;
}

struct SIP_SUBJECTINFO
{
    uint cbSize;
    Guid* pgSubjectType;
    HANDLE hFile;
    const(wchar)* pwsFileName;
    const(wchar)* pwsDisplayName;
    uint dwReserved1;
    uint dwIntVersion;
    uint hProv;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    uint dwFlags;
    uint dwEncodingType;
    uint dwReserved2;
    uint fdwCAPISettings;
    uint fdwSecuritySettings;
    uint dwIndex;
    uint dwUnionChoice;
    _Anonymous_e__Union Anonymous;
    void* pClientData;
}

struct MS_ADDINFO_FLAT
{
    uint cbStruct;
    SIP_INDIRECT_DATA* pIndirectData;
}

struct MS_ADDINFO_CATALOGMEMBER
{
    uint cbStruct;
    CRYPTCATSTORE* pStore;
    CRYPTCATMEMBER* pMember;
}

struct MS_ADDINFO_BLOB
{
    uint cbStruct;
    uint cbMemObject;
    ubyte* pbMemObject;
    uint cbMemSignedMsg;
    ubyte* pbMemSignedMsg;
}

struct SIP_CAP_SET_V2
{
    uint cbSize;
    uint dwVersion;
    BOOL isMultiSign;
    uint dwReserved;
}

struct SIP_CAP_SET_V3
{
    uint cbSize;
    uint dwVersion;
    BOOL isMultiSign;
    _Anonymous_e__Union Anonymous;
}

struct SIP_INDIRECT_DATA
{
    CRYPT_ATTRIBUTE_TYPE_VALUE Data;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    CRYPTOAPI_BLOB Digest;
}

alias pCryptSIPGetSignedDataMsg = extern(Windows) BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint* pdwEncodingType, uint dwIndex, uint* pcbSignedDataMsg, ubyte* pbSignedDataMsg);
alias pCryptSIPPutSignedDataMsg = extern(Windows) BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint dwEncodingType, uint* pdwIndex, uint cbSignedDataMsg, ubyte* pbSignedDataMsg);
alias pCryptSIPCreateIndirectData = extern(Windows) BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint* pcbIndirectData, SIP_INDIRECT_DATA* pIndirectData);
alias pCryptSIPVerifyIndirectData = extern(Windows) BOOL function(SIP_SUBJECTINFO* pSubjectInfo, SIP_INDIRECT_DATA* pIndirectData);
alias pCryptSIPRemoveSignedDataMsg = extern(Windows) BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint dwIndex);
struct SIP_DISPATCH_INFO
{
    uint cbSize;
    HANDLE hSIP;
    pCryptSIPGetSignedDataMsg pfGet;
    pCryptSIPPutSignedDataMsg pfPut;
    pCryptSIPCreateIndirectData pfCreate;
    pCryptSIPVerifyIndirectData pfVerify;
    pCryptSIPRemoveSignedDataMsg pfRemove;
}

alias pfnIsFileSupported = extern(Windows) BOOL function(HANDLE hFile, Guid* pgSubject);
alias pfnIsFileSupportedName = extern(Windows) BOOL function(ushort* pwszFileName, Guid* pgSubject);
struct SIP_ADD_NEWPROVIDER
{
    uint cbStruct;
    Guid* pgSubject;
    ushort* pwszDLLFileName;
    ushort* pwszMagicNumber;
    ushort* pwszIsFunctionName;
    ushort* pwszGetFuncName;
    ushort* pwszPutFuncName;
    ushort* pwszCreateFuncName;
    ushort* pwszVerifyFuncName;
    ushort* pwszRemoveFuncName;
    ushort* pwszIsFunctionNameFmt2;
    const(wchar)* pwszGetCapFuncName;
}

alias pCryptSIPGetCaps = extern(Windows) BOOL function(SIP_SUBJECTINFO* pSubjInfo, SIP_CAP_SET_V3* pCaps);
alias pCryptSIPGetSealedDigest = extern(Windows) BOOL function(SIP_SUBJECTINFO* pSubjectInfo, char* pSig, uint dwSig, char* pbDigest, uint* pcbDigest);
struct CRYPTCATSTORE
{
    uint cbStruct;
    uint dwPublicVersion;
    const(wchar)* pwszP7File;
    uint hProv;
    uint dwEncodingType;
    uint fdwStoreFlags;
    HANDLE hReserved;
    HANDLE hAttrs;
    void* hCryptMsg;
    HANDLE hSorted;
}

struct CRYPTCATMEMBER
{
    uint cbStruct;
    const(wchar)* pwszReferenceTag;
    const(wchar)* pwszFileName;
    Guid gSubjectType;
    uint fdwMemberFlags;
    SIP_INDIRECT_DATA* pIndirectData;
    uint dwCertVersion;
    uint dwReserved;
    HANDLE hReserved;
    CRYPTOAPI_BLOB sEncodedIndirectData;
    CRYPTOAPI_BLOB sEncodedMemberInfo;
}

struct CRYPTCATATTRIBUTE
{
    uint cbStruct;
    const(wchar)* pwszReferenceTag;
    uint dwAttrTypeAndAction;
    uint cbValue;
    ubyte* pbValue;
    uint dwReserved;
}

struct CRYPTCATCDF
{
    uint cbStruct;
    HANDLE hFile;
    uint dwCurFilePos;
    uint dwLastMemberOffset;
    BOOL fEOF;
    const(wchar)* pwszResultDir;
    HANDLE hCATStore;
}

struct CATALOG_INFO
{
    uint cbStruct;
    ushort wszCatalogFile;
}

alias PFN_CDF_PARSE_ERROR_CALLBACK = extern(Windows) void function(uint dwErrorArea, uint dwLocalError, ushort* pwszLine);
const GUID CLSID_CEnroll2 = {0x127698E4, 0xE730, 0x4E5C, [0xA2, 0xB1, 0x21, 0x49, 0x0A, 0x70, 0xC8, 0xA1]};
@GUID(0x127698E4, 0xE730, 0x4E5C, [0xA2, 0xB1, 0x21, 0x49, 0x0A, 0x70, 0xC8, 0xA1]);
struct CEnroll2;

const GUID CLSID_CEnroll = {0x43F8F289, 0x7A20, 0x11D0, [0x8F, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]};
@GUID(0x43F8F289, 0x7A20, 0x11D0, [0x8F, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]);
struct CEnroll;

const GUID IID_ICEnroll = {0x43F8F288, 0x7A20, 0x11D0, [0x8F, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]};
@GUID(0x43F8F288, 0x7A20, 0x11D0, [0x8F, 0x06, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]);
interface ICEnroll : IDispatch
{
    HRESULT createFilePKCS10(BSTR DNName, BSTR Usage, BSTR wszPKCS10FileName);
    HRESULT acceptFilePKCS7(BSTR wszPKCS7FileName);
    HRESULT createPKCS10(BSTR DNName, BSTR Usage, BSTR* pPKCS10);
    HRESULT acceptPKCS7(BSTR PKCS7);
    HRESULT getCertFromPKCS7(BSTR wszPKCS7, BSTR* pbstrCert);
    HRESULT enumProviders(int dwIndex, int dwFlags, BSTR* pbstrProvName);
    HRESULT enumContainers(int dwIndex, BSTR* pbstr);
    HRESULT freeRequestInfo(BSTR PKCS7OrPKCS10);
    HRESULT get_MyStoreName(BSTR* pbstrName);
    HRESULT put_MyStoreName(BSTR bstrName);
    HRESULT get_MyStoreType(BSTR* pbstrType);
    HRESULT put_MyStoreType(BSTR bstrType);
    HRESULT get_MyStoreFlags(int* pdwFlags);
    HRESULT put_MyStoreFlags(int dwFlags);
    HRESULT get_CAStoreName(BSTR* pbstrName);
    HRESULT put_CAStoreName(BSTR bstrName);
    HRESULT get_CAStoreType(BSTR* pbstrType);
    HRESULT put_CAStoreType(BSTR bstrType);
    HRESULT get_CAStoreFlags(int* pdwFlags);
    HRESULT put_CAStoreFlags(int dwFlags);
    HRESULT get_RootStoreName(BSTR* pbstrName);
    HRESULT put_RootStoreName(BSTR bstrName);
    HRESULT get_RootStoreType(BSTR* pbstrType);
    HRESULT put_RootStoreType(BSTR bstrType);
    HRESULT get_RootStoreFlags(int* pdwFlags);
    HRESULT put_RootStoreFlags(int dwFlags);
    HRESULT get_RequestStoreName(BSTR* pbstrName);
    HRESULT put_RequestStoreName(BSTR bstrName);
    HRESULT get_RequestStoreType(BSTR* pbstrType);
    HRESULT put_RequestStoreType(BSTR bstrType);
    HRESULT get_RequestStoreFlags(int* pdwFlags);
    HRESULT put_RequestStoreFlags(int dwFlags);
    HRESULT get_ContainerName(BSTR* pbstrContainer);
    HRESULT put_ContainerName(BSTR bstrContainer);
    HRESULT get_ProviderName(BSTR* pbstrProvider);
    HRESULT put_ProviderName(BSTR bstrProvider);
    HRESULT get_ProviderType(int* pdwType);
    HRESULT put_ProviderType(int dwType);
    HRESULT get_KeySpec(int* pdw);
    HRESULT put_KeySpec(int dw);
    HRESULT get_ProviderFlags(int* pdwFlags);
    HRESULT put_ProviderFlags(int dwFlags);
    HRESULT get_UseExistingKeySet(int* fUseExistingKeys);
    HRESULT put_UseExistingKeySet(BOOL fUseExistingKeys);
    HRESULT get_GenKeyFlags(int* pdwFlags);
    HRESULT put_GenKeyFlags(int dwFlags);
    HRESULT get_DeleteRequestCert(int* fDelete);
    HRESULT put_DeleteRequestCert(BOOL fDelete);
    HRESULT get_WriteCertToCSP(int* fBool);
    HRESULT put_WriteCertToCSP(BOOL fBool);
    HRESULT get_SPCFileName(BSTR* pbstr);
    HRESULT put_SPCFileName(BSTR bstr);
    HRESULT get_PVKFileName(BSTR* pbstr);
    HRESULT put_PVKFileName(BSTR bstr);
    HRESULT get_HashAlgorithm(BSTR* pbstr);
    HRESULT put_HashAlgorithm(BSTR bstr);
}

const GUID IID_ICEnroll2 = {0x704CA730, 0xC90B, 0x11D1, [0x9B, 0xEC, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]};
@GUID(0x704CA730, 0xC90B, 0x11D1, [0x9B, 0xEC, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]);
interface ICEnroll2 : ICEnroll
{
    HRESULT addCertTypeToRequest(BSTR CertType);
    HRESULT addNameValuePairToSignature(BSTR Name, BSTR Value);
    HRESULT get_WriteCertToUserDS(int* fBool);
    HRESULT put_WriteCertToUserDS(BOOL fBool);
    HRESULT get_EnableT61DNEncoding(int* fBool);
    HRESULT put_EnableT61DNEncoding(BOOL fBool);
}

const GUID IID_ICEnroll3 = {0xC28C2D95, 0xB7DE, 0x11D2, [0xA4, 0x21, 0x00, 0xC0, 0x4F, 0x79, 0xFE, 0x8E]};
@GUID(0xC28C2D95, 0xB7DE, 0x11D2, [0xA4, 0x21, 0x00, 0xC0, 0x4F, 0x79, 0xFE, 0x8E]);
interface ICEnroll3 : ICEnroll2
{
    HRESULT InstallPKCS7(BSTR PKCS7);
    HRESULT Reset();
    HRESULT GetSupportedKeySpec(int* pdwKeySpec);
    HRESULT GetKeyLen(BOOL fMin, BOOL fExchange, int* pdwKeySize);
    HRESULT EnumAlgs(int dwIndex, int algClass, int* pdwAlgID);
    HRESULT GetAlgName(int algID, BSTR* pbstr);
    HRESULT put_ReuseHardwareKeyIfUnableToGenNew(BOOL fReuseHardwareKeyIfUnableToGenNew);
    HRESULT get_ReuseHardwareKeyIfUnableToGenNew(int* fReuseHardwareKeyIfUnableToGenNew);
    HRESULT put_HashAlgID(int hashAlgID);
    HRESULT get_HashAlgID(int* hashAlgID);
    HRESULT put_LimitExchangeKeyToEncipherment(BOOL fLimitExchangeKeyToEncipherment);
    HRESULT get_LimitExchangeKeyToEncipherment(int* fLimitExchangeKeyToEncipherment);
    HRESULT put_EnableSMIMECapabilities(BOOL fEnableSMIMECapabilities);
    HRESULT get_EnableSMIMECapabilities(int* fEnableSMIMECapabilities);
}

const GUID IID_ICEnroll4 = {0xC1F1188A, 0x2EB5, 0x4A80, [0x84, 0x1B, 0x7E, 0x72, 0x9A, 0x35, 0x6D, 0x90]};
@GUID(0xC1F1188A, 0x2EB5, 0x4A80, [0x84, 0x1B, 0x7E, 0x72, 0x9A, 0x35, 0x6D, 0x90]);
interface ICEnroll4 : ICEnroll3
{
    HRESULT put_PrivateKeyArchiveCertificate(BSTR bstrCert);
    HRESULT get_PrivateKeyArchiveCertificate(BSTR* pbstrCert);
    HRESULT put_ThumbPrint(BSTR bstrThumbPrint);
    HRESULT get_ThumbPrint(BSTR* pbstrThumbPrint);
    HRESULT binaryToString(int Flags, BSTR strBinary, BSTR* pstrEncoded);
    HRESULT stringToBinary(int Flags, BSTR strEncoded, BSTR* pstrBinary);
    HRESULT addExtensionToRequest(int Flags, BSTR strName, BSTR strValue);
    HRESULT addAttributeToRequest(int Flags, BSTR strName, BSTR strValue);
    HRESULT addNameValuePairToRequest(int Flags, BSTR strName, BSTR strValue);
    HRESULT resetExtensions();
    HRESULT resetAttributes();
    HRESULT createRequest(int Flags, BSTR strDNName, BSTR Usage, BSTR* pstrRequest);
    HRESULT createFileRequest(int Flags, BSTR strDNName, BSTR strUsage, BSTR strRequestFileName);
    HRESULT acceptResponse(BSTR strResponse);
    HRESULT acceptFileResponse(BSTR strResponseFileName);
    HRESULT getCertFromResponse(BSTR strResponse, BSTR* pstrCert);
    HRESULT getCertFromFileResponse(BSTR strResponseFileName, BSTR* pstrCert);
    HRESULT createPFX(BSTR strPassword, BSTR* pstrPFX);
    HRESULT createFilePFX(BSTR strPassword, BSTR strPFXFileName);
    HRESULT setPendingRequestInfo(int lRequestID, BSTR strCADNS, BSTR strCAName, BSTR strFriendlyName);
    HRESULT enumPendingRequest(int lIndex, int lDesiredProperty, VARIANT* pvarProperty);
    HRESULT removePendingRequest(BSTR strThumbprint);
    HRESULT GetKeyLenEx(int lSizeSpec, int lKeySpec, int* pdwKeySize);
    HRESULT InstallPKCS7Ex(BSTR PKCS7, int* plCertInstalled);
    HRESULT addCertTypeToRequestEx(int lType, BSTR bstrOIDOrName, int lMajorVersion, BOOL fMinorVersion, int lMinorVersion);
    HRESULT getProviderType(BSTR strProvName, int* plProvType);
    HRESULT put_SignerCertificate(BSTR bstrCert);
    HRESULT put_ClientId(int lClientId);
    HRESULT get_ClientId(int* plClientId);
    HRESULT addBlobPropertyToCertificate(int lPropertyId, int lReserved, BSTR bstrProperty);
    HRESULT resetBlobProperties();
    HRESULT put_IncludeSubjectKeyID(BOOL fInclude);
    HRESULT get_IncludeSubjectKeyID(int* pfInclude);
}

const GUID IID_IEnroll = {0xACAA7838, 0x4585, 0x11D1, [0xAB, 0x57, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]};
@GUID(0xACAA7838, 0x4585, 0x11D1, [0xAB, 0x57, 0x00, 0xC0, 0x4F, 0xC2, 0x95, 0xE1]);
interface IEnroll : IUnknown
{
    HRESULT createFilePKCS10WStr(const(wchar)* DNName, const(wchar)* Usage, const(wchar)* wszPKCS10FileName);
    HRESULT acceptFilePKCS7WStr(const(wchar)* wszPKCS7FileName);
    HRESULT createPKCS10WStr(const(wchar)* DNName, const(wchar)* Usage, CRYPTOAPI_BLOB* pPkcs10Blob);
    HRESULT acceptPKCS7Blob(CRYPTOAPI_BLOB* pBlobPKCS7);
    CERT_CONTEXT* getCertContextFromPKCS7(CRYPTOAPI_BLOB* pBlobPKCS7);
    void* getMyStore();
    void* getCAStore();
    void* getROOTHStore();
    HRESULT enumProvidersWStr(int dwIndex, int dwFlags, ushort** pbstrProvName);
    HRESULT enumContainersWStr(int dwIndex, ushort** pbstr);
    HRESULT freeRequestInfoBlob(CRYPTOAPI_BLOB pkcs7OrPkcs10);
    HRESULT get_MyStoreNameWStr(ushort** szwName);
    HRESULT put_MyStoreNameWStr(const(wchar)* szwName);
    HRESULT get_MyStoreTypeWStr(ushort** szwType);
    HRESULT put_MyStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_MyStoreFlags(int* pdwFlags);
    HRESULT put_MyStoreFlags(int dwFlags);
    HRESULT get_CAStoreNameWStr(ushort** szwName);
    HRESULT put_CAStoreNameWStr(const(wchar)* szwName);
    HRESULT get_CAStoreTypeWStr(ushort** szwType);
    HRESULT put_CAStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_CAStoreFlags(int* pdwFlags);
    HRESULT put_CAStoreFlags(int dwFlags);
    HRESULT get_RootStoreNameWStr(ushort** szwName);
    HRESULT put_RootStoreNameWStr(const(wchar)* szwName);
    HRESULT get_RootStoreTypeWStr(ushort** szwType);
    HRESULT put_RootStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_RootStoreFlags(int* pdwFlags);
    HRESULT put_RootStoreFlags(int dwFlags);
    HRESULT get_RequestStoreNameWStr(ushort** szwName);
    HRESULT put_RequestStoreNameWStr(const(wchar)* szwName);
    HRESULT get_RequestStoreTypeWStr(ushort** szwType);
    HRESULT put_RequestStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_RequestStoreFlags(int* pdwFlags);
    HRESULT put_RequestStoreFlags(int dwFlags);
    HRESULT get_ContainerNameWStr(ushort** szwContainer);
    HRESULT put_ContainerNameWStr(const(wchar)* szwContainer);
    HRESULT get_ProviderNameWStr(ushort** szwProvider);
    HRESULT put_ProviderNameWStr(const(wchar)* szwProvider);
    HRESULT get_ProviderType(int* pdwType);
    HRESULT put_ProviderType(int dwType);
    HRESULT get_KeySpec(int* pdw);
    HRESULT put_KeySpec(int dw);
    HRESULT get_ProviderFlags(int* pdwFlags);
    HRESULT put_ProviderFlags(int dwFlags);
    HRESULT get_UseExistingKeySet(int* fUseExistingKeys);
    HRESULT put_UseExistingKeySet(BOOL fUseExistingKeys);
    HRESULT get_GenKeyFlags(int* pdwFlags);
    HRESULT put_GenKeyFlags(int dwFlags);
    HRESULT get_DeleteRequestCert(int* fDelete);
    HRESULT put_DeleteRequestCert(BOOL fDelete);
    HRESULT get_WriteCertToUserDS(int* fBool);
    HRESULT put_WriteCertToUserDS(BOOL fBool);
    HRESULT get_EnableT61DNEncoding(int* fBool);
    HRESULT put_EnableT61DNEncoding(BOOL fBool);
    HRESULT get_WriteCertToCSP(int* fBool);
    HRESULT put_WriteCertToCSP(BOOL fBool);
    HRESULT get_SPCFileNameWStr(ushort** szw);
    HRESULT put_SPCFileNameWStr(const(wchar)* szw);
    HRESULT get_PVKFileNameWStr(ushort** szw);
    HRESULT put_PVKFileNameWStr(const(wchar)* szw);
    HRESULT get_HashAlgorithmWStr(ushort** szw);
    HRESULT put_HashAlgorithmWStr(const(wchar)* szw);
    HRESULT get_RenewalCertificate(CERT_CONTEXT** ppCertContext);
    HRESULT put_RenewalCertificate(CERT_CONTEXT* pCertContext);
    HRESULT AddCertTypeToRequestWStr(const(wchar)* szw);
    HRESULT AddNameValuePairToSignatureWStr(const(wchar)* Name, const(wchar)* Value);
    HRESULT AddExtensionsToRequest(CERT_EXTENSIONS* pCertExtensions);
    HRESULT AddAuthenticatedAttributesToPKCS7Request(CRYPT_ATTRIBUTES* pAttributes);
    HRESULT CreatePKCS7RequestFromRequest(CRYPTOAPI_BLOB* pRequest, CERT_CONTEXT* pSigningCertContext, CRYPTOAPI_BLOB* pPkcs7Blob);
}

const GUID IID_IEnroll2 = {0xC080E199, 0xB7DF, 0x11D2, [0xA4, 0x21, 0x00, 0xC0, 0x4F, 0x79, 0xFE, 0x8E]};
@GUID(0xC080E199, 0xB7DF, 0x11D2, [0xA4, 0x21, 0x00, 0xC0, 0x4F, 0x79, 0xFE, 0x8E]);
interface IEnroll2 : IEnroll
{
    HRESULT InstallPKCS7Blob(CRYPTOAPI_BLOB* pBlobPKCS7);
    HRESULT Reset();
    HRESULT GetSupportedKeySpec(int* pdwKeySpec);
    HRESULT GetKeyLen(BOOL fMin, BOOL fExchange, int* pdwKeySize);
    HRESULT EnumAlgs(int dwIndex, int algClass, int* pdwAlgID);
    HRESULT GetAlgNameWStr(int algID, ushort** ppwsz);
    HRESULT put_ReuseHardwareKeyIfUnableToGenNew(BOOL fReuseHardwareKeyIfUnableToGenNew);
    HRESULT get_ReuseHardwareKeyIfUnableToGenNew(int* fReuseHardwareKeyIfUnableToGenNew);
    HRESULT put_HashAlgID(int hashAlgID);
    HRESULT get_HashAlgID(int* hashAlgID);
    HRESULT SetHStoreMy(void* hStore);
    HRESULT SetHStoreCA(void* hStore);
    HRESULT SetHStoreROOT(void* hStore);
    HRESULT SetHStoreRequest(void* hStore);
    HRESULT put_LimitExchangeKeyToEncipherment(BOOL fLimitExchangeKeyToEncipherment);
    HRESULT get_LimitExchangeKeyToEncipherment(int* fLimitExchangeKeyToEncipherment);
    HRESULT put_EnableSMIMECapabilities(BOOL fEnableSMIMECapabilities);
    HRESULT get_EnableSMIMECapabilities(int* fEnableSMIMECapabilities);
}

const GUID IID_IEnroll4 = {0xF8053FE5, 0x78F4, 0x448F, [0xA0, 0xDB, 0x41, 0xD6, 0x1B, 0x73, 0x44, 0x6B]};
@GUID(0xF8053FE5, 0x78F4, 0x448F, [0xA0, 0xDB, 0x41, 0xD6, 0x1B, 0x73, 0x44, 0x6B]);
interface IEnroll4 : IEnroll2
{
    HRESULT put_ThumbPrintWStr(CRYPTOAPI_BLOB thumbPrintBlob);
    HRESULT get_ThumbPrintWStr(CRYPTOAPI_BLOB* thumbPrintBlob);
    HRESULT SetPrivateKeyArchiveCertificate(CERT_CONTEXT* pPrivateKeyArchiveCert);
    CERT_CONTEXT* GetPrivateKeyArchiveCertificate();
    HRESULT binaryBlobToString(int Flags, CRYPTOAPI_BLOB* pblobBinary, ushort** ppwszString);
    HRESULT stringToBinaryBlob(int Flags, const(wchar)* pwszString, CRYPTOAPI_BLOB* pblobBinary, int* pdwSkip, int* pdwFlags);
    HRESULT addExtensionToRequestWStr(int Flags, const(wchar)* pwszName, CRYPTOAPI_BLOB* pblobValue);
    HRESULT addAttributeToRequestWStr(int Flags, const(wchar)* pwszName, CRYPTOAPI_BLOB* pblobValue);
    HRESULT addNameValuePairToRequestWStr(int Flags, const(wchar)* pwszName, const(wchar)* pwszValue);
    HRESULT resetExtensions();
    HRESULT resetAttributes();
    HRESULT createRequestWStr(int Flags, const(wchar)* pwszDNName, const(wchar)* pwszUsage, CRYPTOAPI_BLOB* pblobRequest);
    HRESULT createFileRequestWStr(int Flags, const(wchar)* pwszDNName, const(wchar)* pwszUsage, const(wchar)* pwszRequestFileName);
    HRESULT acceptResponseBlob(CRYPTOAPI_BLOB* pblobResponse);
    HRESULT acceptFileResponseWStr(const(wchar)* pwszResponseFileName);
    HRESULT getCertContextFromResponseBlob(CRYPTOAPI_BLOB* pblobResponse, CERT_CONTEXT** ppCertContext);
    HRESULT getCertContextFromFileResponseWStr(const(wchar)* pwszResponseFileName, CERT_CONTEXT** ppCertContext);
    HRESULT createPFXWStr(const(wchar)* pwszPassword, CRYPTOAPI_BLOB* pblobPFX);
    HRESULT createFilePFXWStr(const(wchar)* pwszPassword, const(wchar)* pwszPFXFileName);
    HRESULT setPendingRequestInfoWStr(int lRequestID, const(wchar)* pwszCADNS, const(wchar)* pwszCAName, const(wchar)* pwszFriendlyName);
    HRESULT enumPendingRequestWStr(int lIndex, int lDesiredProperty, void* ppProperty);
    HRESULT removePendingRequestWStr(CRYPTOAPI_BLOB thumbPrintBlob);
    HRESULT GetKeyLenEx(int lSizeSpec, int lKeySpec, int* pdwKeySize);
    HRESULT InstallPKCS7BlobEx(CRYPTOAPI_BLOB* pBlobPKCS7, int* plCertInstalled);
    HRESULT AddCertTypeToRequestWStrEx(int lType, const(wchar)* pwszOIDOrName, int lMajorVersion, BOOL fMinorVersion, int lMinorVersion);
    HRESULT getProviderTypeWStr(const(wchar)* pwszProvName, int* plProvType);
    HRESULT addBlobPropertyToCertificateWStr(int lPropertyId, int lReserved, CRYPTOAPI_BLOB* pBlobProperty);
    HRESULT SetSignerCertificate(CERT_CONTEXT* pSignerCert);
    HRESULT put_ClientId(int lClientId);
    HRESULT get_ClientId(int* plClientId);
    HRESULT put_IncludeSubjectKeyID(BOOL fInclude);
    HRESULT get_IncludeSubjectKeyID(int* pfInclude);
}

struct SCESVC_CONFIGURATION_LINE
{
    byte* Key;
    byte* Value;
    uint ValueLen;
}

struct SCESVC_CONFIGURATION_INFO
{
    uint Count;
    SCESVC_CONFIGURATION_LINE* Lines;
}

enum SCESVC_INFO_TYPE
{
    SceSvcConfigurationInfo = 0,
    SceSvcMergedPolicyInfo = 1,
    SceSvcAnalysisInfo = 2,
    SceSvcInternalUse = 3,
}

struct SCESVC_ANALYSIS_LINE
{
    byte* Key;
    ubyte* Value;
    uint ValueLen;
}

struct SCESVC_ANALYSIS_INFO
{
    uint Count;
    SCESVC_ANALYSIS_LINE* Lines;
}

alias PFSCE_QUERY_INFO = extern(Windows) uint function(void* sceHandle, SCESVC_INFO_TYPE sceType, byte* lpPrefix, BOOL bExact, void** ppvInfo, uint* psceEnumHandle);
alias PFSCE_SET_INFO = extern(Windows) uint function(void* sceHandle, SCESVC_INFO_TYPE sceType, byte* lpPrefix, BOOL bExact, void* pvInfo);
alias PFSCE_FREE_INFO = extern(Windows) uint function(void* pvServiceInfo);
alias PFSCE_LOG_INFO = extern(Windows) uint function(int ErrLevel, uint Win32rc, byte* pErrFmt);
struct SCESVC_CALLBACK_INFO
{
    void* sceHandle;
    PFSCE_QUERY_INFO pfQueryInfo;
    PFSCE_SET_INFO pfSetInfo;
    PFSCE_FREE_INFO pfFreeInfo;
    PFSCE_LOG_INFO pfLogInfo;
}

alias PF_ConfigAnalyzeService = extern(Windows) uint function(SCESVC_CALLBACK_INFO* pSceCbInfo);
alias PF_UpdateService = extern(Windows) uint function(SCESVC_CALLBACK_INFO* pSceCbInfo, SCESVC_CONFIGURATION_INFO* ServiceInfo);
const GUID IID_ISceSvcAttachmentPersistInfo = {0x6D90E0D0, 0x200D, 0x11D1, [0xAF, 0xFB, 0x00, 0xC0, 0x4F, 0xB9, 0x84, 0xF9]};
@GUID(0x6D90E0D0, 0x200D, 0x11D1, [0xAF, 0xFB, 0x00, 0xC0, 0x4F, 0xB9, 0x84, 0xF9]);
interface ISceSvcAttachmentPersistInfo : IUnknown
{
    HRESULT Save(byte* lpTemplateName, void** scesvcHandle, void** ppvData, int* pbOverwriteAll);
    HRESULT IsDirty(byte* lpTemplateName);
    HRESULT FreeBuffer(void* pvData);
}

const GUID IID_ISceSvcAttachmentData = {0x17C35FDE, 0x200D, 0x11D1, [0xAF, 0xFB, 0x00, 0xC0, 0x4F, 0xB9, 0x84, 0xF9]};
@GUID(0x17C35FDE, 0x200D, 0x11D1, [0xAF, 0xFB, 0x00, 0xC0, 0x4F, 0xB9, 0x84, 0xF9]);
interface ISceSvcAttachmentData : IUnknown
{
    HRESULT GetData(void* scesvcHandle, SCESVC_INFO_TYPE sceType, void** ppvData, uint* psceEnumHandle);
    HRESULT Initialize(byte* lpServiceName, byte* lpTemplateName, ISceSvcAttachmentPersistInfo lpSceSvcPersistInfo, void** pscesvcHandle);
    HRESULT FreeBuffer(void* pvData);
    HRESULT CloseHandle(void* scesvcHandle);
}

struct SAFER_LEVEL_HANDLE__
{
    int unused;
}

struct SAFER_CODE_PROPERTIES_V1
{
    uint cbSize;
    uint dwCheckFlags;
    const(wchar)* ImagePath;
    HANDLE hImageFileHandle;
    uint UrlZoneId;
    ubyte ImageHash;
    uint dwImageHashSize;
    LARGE_INTEGER ImageSize;
    uint HashAlgorithm;
    ubyte* pByteBlock;
    HWND hWndParent;
    uint dwWVTUIChoice;
}

struct SAFER_CODE_PROPERTIES_V2
{
    uint cbSize;
    uint dwCheckFlags;
    const(wchar)* ImagePath;
    HANDLE hImageFileHandle;
    uint UrlZoneId;
    ubyte ImageHash;
    uint dwImageHashSize;
    LARGE_INTEGER ImageSize;
    uint HashAlgorithm;
    ubyte* pByteBlock;
    HWND hWndParent;
    uint dwWVTUIChoice;
    const(wchar)* PackageMoniker;
    const(wchar)* PackagePublisher;
    const(wchar)* PackageName;
    ulong PackageVersion;
    BOOL PackageIsFramework;
}

enum SAFER_POLICY_INFO_CLASS
{
    SaferPolicyLevelList = 1,
    SaferPolicyEnableTransparentEnforcement = 2,
    SaferPolicyDefaultLevel = 3,
    SaferPolicyEvaluateUserScope = 4,
    SaferPolicyScopeFlags = 5,
    SaferPolicyDefaultLevelFlags = 6,
    SaferPolicyAuthenticodeEnabled = 7,
}

enum SAFER_OBJECT_INFO_CLASS
{
    SaferObjectLevelId = 1,
    SaferObjectScopeId = 2,
    SaferObjectFriendlyName = 3,
    SaferObjectDescription = 4,
    SaferObjectBuiltin = 5,
    SaferObjectDisallowed = 6,
    SaferObjectDisableMaxPrivilege = 7,
    SaferObjectInvertDeletedPrivileges = 8,
    SaferObjectDeletedPrivileges = 9,
    SaferObjectDefaultOwner = 10,
    SaferObjectSidsToDisable = 11,
    SaferObjectRestrictedSidsInverted = 12,
    SaferObjectRestrictedSidsAdded = 13,
    SaferObjectAllIdentificationGuids = 14,
    SaferObjectSingleIdentification = 15,
    SaferObjectExtendedError = 16,
}

enum SAFER_IDENTIFICATION_TYPES
{
    SaferIdentityDefault = 0,
    SaferIdentityTypeImageName = 1,
    SaferIdentityTypeImageHash = 2,
    SaferIdentityTypeUrlZone = 3,
    SaferIdentityTypeCertificate = 4,
}

struct SAFER_IDENTIFICATION_HEADER
{
    SAFER_IDENTIFICATION_TYPES dwIdentificationType;
    uint cbStructSize;
    Guid IdentificationGuid;
    FILETIME lastModified;
}

struct SAFER_PATHNAME_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    ushort Description;
    const(wchar)* ImageName;
    uint dwSaferFlags;
}

struct SAFER_HASH_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    ushort Description;
    ushort FriendlyName;
    uint HashSize;
    ubyte ImageHash;
    uint HashAlgorithm;
    LARGE_INTEGER ImageSize;
    uint dwSaferFlags;
}

struct SAFER_HASH_IDENTIFICATION2
{
    SAFER_HASH_IDENTIFICATION hashIdentification;
    uint HashSize;
    ubyte ImageHash;
    uint HashAlgorithm;
}

struct SAFER_URLZONE_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    uint UrlZoneId;
    uint dwSaferFlags;
}

enum SLDATATYPE
{
    SL_DATA_NONE = 0,
    SL_DATA_SZ = 1,
    SL_DATA_DWORD = 4,
    SL_DATA_BINARY = 3,
    SL_DATA_MULTI_SZ = 7,
    SL_DATA_SUM = 100,
}

enum SLIDTYPE
{
    SL_ID_APPLICATION = 0,
    SL_ID_PRODUCT_SKU = 1,
    SL_ID_LICENSE_FILE = 2,
    SL_ID_LICENSE = 3,
    SL_ID_PKEY = 4,
    SL_ID_ALL_LICENSES = 5,
    SL_ID_ALL_LICENSE_FILES = 6,
    SL_ID_STORE_TOKEN = 7,
    SL_ID_LAST = 8,
}

enum SLLICENSINGSTATUS
{
    SL_LICENSING_STATUS_UNLICENSED = 0,
    SL_LICENSING_STATUS_LICENSED = 1,
    SL_LICENSING_STATUS_IN_GRACE_PERIOD = 2,
    SL_LICENSING_STATUS_NOTIFICATION = 3,
    SL_LICENSING_STATUS_LAST = 4,
}

struct SL_LICENSING_STATUS
{
    Guid SkuId;
    SLLICENSINGSTATUS eStatus;
    uint dwGraceTime;
    uint dwTotalGraceDays;
    HRESULT hrReason;
    ulong qwValidityExpiration;
}

enum SL_ACTIVATION_TYPE
{
    SL_ACTIVATION_TYPE_DEFAULT = 0,
    SL_ACTIVATION_TYPE_ACTIVE_DIRECTORY = 1,
}

struct SL_ACTIVATION_INFO_HEADER
{
    uint cbSize;
    SL_ACTIVATION_TYPE type;
}

struct SL_AD_ACTIVATION_INFO
{
    SL_ACTIVATION_INFO_HEADER header;
    const(wchar)* pwszProductKey;
    const(wchar)* pwszActivationObjectName;
}

enum SLREFERRALTYPE
{
    SL_REFERRALTYPE_SKUID = 0,
    SL_REFERRALTYPE_APPID = 1,
    SL_REFERRALTYPE_OVERRIDE_SKUID = 2,
    SL_REFERRALTYPE_OVERRIDE_APPID = 3,
    SL_REFERRALTYPE_BEST_MATCH = 4,
}

enum SL_GENUINE_STATE
{
    SL_GEN_STATE_IS_GENUINE = 0,
    SL_GEN_STATE_INVALID_LICENSE = 1,
    SL_GEN_STATE_TAMPERED = 2,
    SL_GEN_STATE_OFFLINE = 3,
    SL_GEN_STATE_LAST = 4,
}

struct SL_NONGENUINE_UI_OPTIONS
{
    uint cbSize;
    const(Guid)* pComponentId;
    HRESULT hResultUI;
}

struct SL_SYSTEM_POLICY_INFORMATION
{
    void* Reserved1;
    uint Reserved2;
}

enum DdqAccessLevel
{
    NoData = 0,
    CurrentUserData = 1,
    AllUserData = 2,
}

struct DIAGNOSTIC_DATA_RECORD
{
    long rowId;
    ulong timestamp;
    ulong eventKeywords;
    const(wchar)* fullEventName;
    const(wchar)* providerGroupGuid;
    const(wchar)* producerName;
    int* privacyTags;
    uint privacyTagCount;
    int* categoryIds;
    uint categoryIdCount;
    BOOL isCoreData;
    const(wchar)* extra1;
    const(wchar)* extra2;
    const(wchar)* extra3;
}

struct DIAGNOSTIC_DATA_SEARCH_CRITERIA
{
    ushort** producerNames;
    uint producerNameCount;
    const(wchar)* textToMatch;
    const(int)* categoryIds;
    uint categoryIdCount;
    const(int)* privacyTags;
    uint privacyTagCount;
    BOOL coreDataOnly;
}

struct DIAGNOSTIC_DATA_EVENT_TAG_DESCRIPTION
{
    int privacyTag;
    const(wchar)* name;
    const(wchar)* description;
}

struct DIAGNOSTIC_DATA_EVENT_PRODUCER_DESCRIPTION
{
    const(wchar)* name;
}

struct DIAGNOSTIC_DATA_EVENT_CATEGORY_DESCRIPTION
{
    int id;
    const(wchar)* name;
}

struct DIAGNOSTIC_DATA_EVENT_TAG_STATS
{
    int privacyTag;
    uint eventCount;
}

struct DIAGNOSTIC_DATA_EVENT_BINARY_STATS
{
    const(wchar)* moduleName;
    const(wchar)* friendlyModuleName;
    uint eventCount;
    ulong uploadSizeBytes;
}

struct DIAGNOSTIC_DATA_GENERAL_STATS
{
    uint optInLevel;
    ulong transcriptSizeBytes;
    ulong oldestEventTimestamp;
    uint totalEventCountLast24Hours;
    float averageDailyEvents;
}

struct DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION
{
    uint hoursOfHistoryToKeep;
    uint maxStoreMegabytes;
    uint requestedMaxStoreMegabytes;
}

struct DIAGNOSTIC_REPORT_PARAMETER
{
    ushort name;
    ushort value;
}

struct DIAGNOSTIC_REPORT_SIGNATURE
{
    ushort eventName;
    DIAGNOSTIC_REPORT_PARAMETER parameters;
}

struct DIAGNOSTIC_REPORT_DATA
{
    DIAGNOSTIC_REPORT_SIGNATURE signature;
    Guid bucketId;
    Guid reportId;
    FILETIME creationTime;
    ulong sizeInBytes;
    const(wchar)* cabId;
    uint reportStatus;
    Guid reportIntegratorId;
    ushort** fileNames;
    uint fileCount;
    const(wchar)* friendlyEventName;
    const(wchar)* applicationName;
    const(wchar)* applicationPath;
    const(wchar)* description;
    const(wchar)* bucketIdString;
    ulong legacyBucketId;
    const(wchar)* reportKey;
}

struct HDIAGNOSTIC_DATA_QUERY_SESSION__
{
    int unused;
}

struct HDIAGNOSTIC_REPORT__
{
    int unused;
}

struct HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__
{
    int unused;
}

struct HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__
{
    int unused;
}

struct HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__
{
    int unused;
}

struct HDIAGNOSTIC_RECORD__
{
    int unused;
}

enum PROCESS_INFORMATION_CLASS
{
    ProcessMemoryPriority = 0,
    ProcessMemoryExhaustionInfo = 1,
    ProcessAppMemoryInfo = 2,
    ProcessInPrivateInfo = 3,
    ProcessPowerThrottling = 4,
    ProcessReservedValue1 = 5,
    ProcessTelemetryCoverageInfo = 6,
    ProcessProtectionLevelInfo = 7,
    ProcessLeapSecondInfo = 8,
    ProcessInformationClassMax = 9,
}

struct NETRESOURCEA
{
    uint dwScope;
    uint dwType;
    uint dwDisplayType;
    uint dwUsage;
    const(char)* lpLocalName;
    const(char)* lpRemoteName;
    const(char)* lpComment;
    const(char)* lpProvider;
}

struct NETRESOURCEW
{
    uint dwScope;
    uint dwType;
    uint dwDisplayType;
    uint dwUsage;
    const(wchar)* lpLocalName;
    const(wchar)* lpRemoteName;
    const(wchar)* lpComment;
    const(wchar)* lpProvider;
}

struct UNIVERSAL_NAME_INFOA
{
    const(char)* lpUniversalName;
}

struct UNIVERSAL_NAME_INFOW
{
    const(wchar)* lpUniversalName;
}

struct REMOTE_NAME_INFOA
{
    const(char)* lpUniversalName;
    const(char)* lpConnectionName;
    const(char)* lpRemainingPath;
}

struct REMOTE_NAME_INFOW
{
    const(wchar)* lpUniversalName;
    const(wchar)* lpConnectionName;
    const(wchar)* lpRemainingPath;
}

struct NETCONNECTINFOSTRUCT
{
    uint cbStructure;
    uint dwFlags;
    uint dwSpeed;
    uint dwDelay;
    uint dwOptDataSize;
}

