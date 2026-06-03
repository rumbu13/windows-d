// Written in the D programming language.

module windows.win32.security.cryptography.catalog;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, PWSTR;
public import windows.win32.security.cryptography : CERT_STRONG_SIGN_PARA, CRYPT_INTEGER_BLOB;
public import windows.win32.security.cryptography.sip : SIP_INDIRECT_DATA;

extern(Windows) @nogc nothrow:


// Enums


alias CRYPTCAT_VERSION = uint;
enum : uint
{
    CRYPTCAT_VERSION_1 = 0x00000100U,
    CRYPTCAT_VERSION_2 = 0x00000200U,
}

alias CRYPTCAT_OPEN_FLAGS = uint;
enum : uint
{
    CRYPTCAT_OPEN_ALWAYS               = 0x00000002U,
    CRYPTCAT_OPEN_CREATENEW            = 0x00000001U,
    CRYPTCAT_OPEN_EXISTING             = 0x00000004U,
    CRYPTCAT_OPEN_EXCLUDE_PAGE_HASHES  = 0x00010000U,
    CRYPTCAT_OPEN_INCLUDE_PAGE_HASHES  = 0x00020000U,
    CRYPTCAT_OPEN_VERIFYSIGHASH        = 0x10000000U,
    CRYPTCAT_OPEN_NO_CONTENT_HCRYPTMSG = 0x20000000U,
    CRYPTCAT_OPEN_SORTED               = 0x40000000U,
    CRYPTCAT_OPEN_FLAGS_MASK           = 0xffff0000U,
}

alias CRYPTCATATTRIBUTE_FLAGS = uint;
enum : uint
{
    CRYPTCAT_ATTR_AUTHENTICATED        = 0x10000000U,
    CRYPTCAT_ATTR_UNAUTHENTICATED      = 0x20000000U,
    CRYPTCAT_ATTR_NAMEASCII            = 0x00000001U,
    CRYPTCAT_ATTR_NAMEOBJID            = 0x00000002U,
    CRYPTCAT_ATTR_DATAASCII            = 0x00010000U,
    CRYPTCAT_ATTR_DATABASE64           = 0x00020000U,
    CRYPTCAT_ATTR_DATAREPLACE          = 0x00040000U,
    CRYPTCAT_ATTR_NO_AUTO_COMPAT_ENTRY = 0x01000000U,
}

// Constants


enum : const(wchar)*
{
    // Native encoding: ansi
    szOID_CATALOG_LIST         = "1.3.6.1.4.1.311.12.1.1",
    // Native encoding: ansi
    szOID_CATALOG_LIST_MEMBER  = "1.3.6.1.4.1.311.12.1.2",
    // Native encoding: ansi
    szOID_CATALOG_LIST_MEMBER2 = "1.3.6.1.4.1.311.12.1.3",
}

enum const(wchar)* CRYPTCAT_FILEEXT = "CAT";

enum : uint
{
    CRYPTCAT_MAX_MEMBERTAG             = 0x00000040U,
    CRYPTCAT_MEMBER_SORTED             = 0x40000000U,
    CRYPTCAT_E_AREA_HEADER             = 0x00000000U,
    CRYPTCAT_E_AREA_MEMBER             = 0x00010000U,
    CRYPTCAT_E_AREA_ATTRIBUTE          = 0x00020000U,
    CRYPTCAT_E_CDF_UNSUPPORTED         = 0x00000001U,
    CRYPTCAT_E_CDF_DUPLICATE           = 0x00000002U,
    CRYPTCAT_E_CDF_TAGNOTFOUND         = 0x00000004U,
    CRYPTCAT_E_CDF_MEMBER_FILE_PATH    = 0x00010001U,
    CRYPTCAT_E_CDF_MEMBER_INDIRECTDATA = 0x00010002U,
    CRYPTCAT_E_CDF_MEMBER_FILENOTFOUND = 0x00010004U,
    CRYPTCAT_E_CDF_BAD_GUID_CONV       = 0x00020001U,
    CRYPTCAT_E_CDF_ATTR_TOOFEWVALUES   = 0x00020002U,
    CRYPTCAT_E_CDF_ATTR_TYPECOMBO      = 0x00020004U,
}

enum : uint
{
    CRYPTCAT_ADDCATALOG_NONE     = 0x00000000U,
    CRYPTCAT_ADDCATALOG_HARDLINK = 0x00000001U,
}

// Callbacks

alias PFN_CDF_PARSE_ERROR_CALLBACK = void function(uint dwErrorArea, uint dwLocalError, PWSTR pwszLine);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mscat/ns-mscat-cryptcatstore
struct CRYPTCATSTORE
{
    uint                cbStruct;
    uint                dwPublicVersion;
    PWSTR               pwszP7File;
    size_t              hProv;
    uint                dwEncodingType;
    CRYPTCAT_OPEN_FLAGS fdwStoreFlags;
    HANDLE              hReserved;
    HANDLE              hAttrs;
    void*               hCryptMsg;
    HANDLE              hSorted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mscat/ns-mscat-cryptcatmember
struct CRYPTCATMEMBER
{
    uint               cbStruct;
    PWSTR              pwszReferenceTag;
    PWSTR              pwszFileName;
    GUID               gSubjectType;
    uint               fdwMemberFlags;
    SIP_INDIRECT_DATA* pIndirectData;
    uint               dwCertVersion;
    uint               dwReserved;
    HANDLE             hReserved;
    CRYPT_INTEGER_BLOB sEncodedIndirectData;
    CRYPT_INTEGER_BLOB sEncodedMemberInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mscat/ns-mscat-cryptcatattribute
struct CRYPTCATATTRIBUTE
{
    uint   cbStruct;
    PWSTR  pwszReferenceTag;
    CRYPTCATATTRIBUTE_FLAGS dwAttrTypeAndAction;
    uint   cbValue;
    ubyte* pbValue;
    uint   dwReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mscat/ns-mscat-cryptcatcdf
struct CRYPTCATCDF
{
    uint   cbStruct;
    HANDLE hFile;
    uint   dwCurFilePos;
    uint   dwLastMemberOffset;
    BOOL   fEOF;
    PWSTR  pwszResultDir;
    HANDLE hCATStore;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mscat/ns-mscat-catalog_info
struct CATALOG_INFO
{
    uint       cbStruct;
    wchar[260] wszCatalogFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-ms_addinfo_catalogmember
struct MS_ADDINFO_CATALOGMEMBER
{
    uint            cbStruct;
    CRYPTCATSTORE*  pStore;
    CRYPTCATMEMBER* pMember;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
HANDLE CryptCATOpen(PWSTR pwszFileName, CRYPTCAT_OPEN_FLAGS fdwOpenFlags, size_t hProv, 
                    CRYPTCAT_VERSION dwPublicVersion, uint dwEncodingType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATClose(HANDLE hCatalog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATSTORE* CryptCATStoreFromHandle(HANDLE hCatalog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
HANDLE CryptCATHandleFromStore(CRYPTCATSTORE* pCatStore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATPersistStore(HANDLE hCatalog);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATGetCatAttrInfo(HANDLE hCatalog, PWSTR pwszReferenceTag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATPutCatAttrInfo(HANDLE hCatalog, PWSTR pwszReferenceTag, uint dwAttrTypeAndAction, 
                                          uint cbData, ubyte* pbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATEnumerateCatAttr(HANDLE hCatalog, CRYPTCATATTRIBUTE* pPrevAttr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATGetMemberInfo(HANDLE hCatalog, PWSTR pwszReferenceTag);

@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATAllocSortedMemberInfo(HANDLE hCatalog, PWSTR pwszReferenceTag);

@DllImport("WINTRUST.dll")
void CryptCATFreeSortedMemberInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATGetAttrInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, PWSTR pwszReferenceTag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATPutMemberInfo(HANDLE hCatalog, PWSTR pwszFileName, PWSTR pwszReferenceTag, 
                                      GUID* pgSubjectType, uint dwCertVersion, uint cbSIPIndirectData, 
                                      ubyte* pbSIPIndirectData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATPutAttrInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, PWSTR pwszReferenceTag, 
                                       uint dwAttrTypeAndAction, uint cbData, ubyte* pbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATEnumerateMember(HANDLE hCatalog, CRYPTCATMEMBER* pPrevMember);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATEnumerateAttr(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, CRYPTCATATTRIBUTE* pPrevAttr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATCDF* CryptCATCDFOpen(PWSTR pwszFilePath, PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATCDFClose(CRYPTCATCDF* pCDF);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATCDFEnumCatAttributes(CRYPTCATCDF* pCDF, CRYPTCATATTRIBUTE* pPrevAttr, 
                                                PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST.dll")
CRYPTCATMEMBER* CryptCATCDFEnumMembers(CRYPTCATCDF* pCDF, CRYPTCATMEMBER* pPrevMember, 
                                       PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATCDFEnumAttributes(CRYPTCATCDF* pCDF, CRYPTCATMEMBER* pMember, 
                                             CRYPTCATATTRIBUTE* pPrevAttr, 
                                             PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL IsCatalogFile(HANDLE hFile, PWSTR pwszFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminAcquireContext(ptrdiff_t* phCatAdmin, const(GUID)* pgSubsystem, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminAcquireContext2(ptrdiff_t* phCatAdmin, const(GUID)* pgSubsystem, const(PWSTR) pwszHashAlgorithm, 
                                  CERT_STRONG_SIGN_PARA* pStrongHashPolicy, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminReleaseContext(ptrdiff_t hCatAdmin, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminReleaseCatalogContext(ptrdiff_t hCatAdmin, ptrdiff_t hCatInfo, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
ptrdiff_t CryptCATAdminEnumCatalogFromHash(ptrdiff_t hCatAdmin, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbHash, 
                                           uint cbHash, 
                                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                                           ptrdiff_t* phPrevCatInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminCalcHashFromFileHandle(HANDLE hFile, uint* pcbHash, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbHash, 
                                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminCalcHashFromFileHandle2(ptrdiff_t hCatAdmin, HANDLE hFile, uint* pcbHash, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbHash, 
                                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
ptrdiff_t CryptCATAdminAddCatalog(ptrdiff_t hCatAdmin, PWSTR pwszCatalogFile, PWSTR pwszSelectBaseName, 
                                  uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminRemoveCatalog(ptrdiff_t hCatAdmin, const(PWSTR) pwszCatalogFile, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATCatalogInfoFromContext(ptrdiff_t hCatInfo, CATALOG_INFO* psCatInfo, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WINTRUST.dll")
BOOL CryptCATAdminResolveCatalogPath(ptrdiff_t hCatAdmin, PWSTR pwszCatalogFile, CATALOG_INFO* psCatInfo, 
                                     uint dwFlags);

@DllImport("WINTRUST.dll")
BOOL CryptCATAdminPauseServiceForBackup(uint dwFlags, BOOL fResume);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecCrypto/cryptcatcdfenummembersbycdftagex
@DllImport("WINTRUST.dll")
PWSTR CryptCATCDFEnumMembersByCDFTagEx(CRYPTCATCDF* pCDF, PWSTR pwszPrevCDFTag, 
                                       PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError, CRYPTCATMEMBER** ppMember, 
                                       BOOL fContinueOnError, void* pvReserved);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecCrypto/cryptcatcdfenumattributeswithcdftag
@DllImport("WINTRUST.dll")
CRYPTCATATTRIBUTE* CryptCATCDFEnumAttributesWithCDFTag(CRYPTCATCDF* pCDF, PWSTR pwszMemberTag, 
                                                       CRYPTCATMEMBER* pMember, CRYPTCATATTRIBUTE* pPrevAttr, 
                                                       PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);


