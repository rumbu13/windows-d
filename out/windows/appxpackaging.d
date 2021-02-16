module windows.appxpackaging;

public import windows.core;
public import windows.com : HRESULT, IUnknown, IUri;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


enum : int
{
    APPX_COMPRESSION_OPTION_NONE      = 0x00000000,
    APPX_COMPRESSION_OPTION_NORMAL    = 0x00000001,
    APPX_COMPRESSION_OPTION_MAXIMUM   = 0x00000002,
    APPX_COMPRESSION_OPTION_FAST      = 0x00000003,
    APPX_COMPRESSION_OPTION_SUPERFAST = 0x00000004,
}
alias APPX_COMPRESSION_OPTION = int;

enum : int
{
    APPX_FOOTPRINT_FILE_TYPE_MANIFEST        = 0x00000000,
    APPX_FOOTPRINT_FILE_TYPE_BLOCKMAP        = 0x00000001,
    APPX_FOOTPRINT_FILE_TYPE_SIGNATURE       = 0x00000002,
    APPX_FOOTPRINT_FILE_TYPE_CODEINTEGRITY   = 0x00000003,
    APPX_FOOTPRINT_FILE_TYPE_CONTENTGROUPMAP = 0x00000004,
}
alias APPX_FOOTPRINT_FILE_TYPE = int;

enum : int
{
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_FIRST     = 0x00000000,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_MANIFEST  = 0x00000000,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_BLOCKMAP  = 0x00000001,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_SIGNATURE = 0x00000002,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_LAST      = 0x00000002,
}
alias APPX_BUNDLE_FOOTPRINT_FILE_TYPE = int;

enum : int
{
    APPX_CAPABILITY_INTERNET_CLIENT               = 0x00000001,
    APPX_CAPABILITY_INTERNET_CLIENT_SERVER        = 0x00000002,
    APPX_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER = 0x00000004,
    APPX_CAPABILITY_DOCUMENTS_LIBRARY             = 0x00000008,
    APPX_CAPABILITY_PICTURES_LIBRARY              = 0x00000010,
    APPX_CAPABILITY_VIDEOS_LIBRARY                = 0x00000020,
    APPX_CAPABILITY_MUSIC_LIBRARY                 = 0x00000040,
    APPX_CAPABILITY_ENTERPRISE_AUTHENTICATION     = 0x00000080,
    APPX_CAPABILITY_SHARED_USER_CERTIFICATES      = 0x00000100,
    APPX_CAPABILITY_REMOVABLE_STORAGE             = 0x00000200,
    APPX_CAPABILITY_APPOINTMENTS                  = 0x00000400,
    APPX_CAPABILITY_CONTACTS                      = 0x00000800,
}
alias APPX_CAPABILITIES = int;

enum : int
{
    APPX_PACKAGE_ARCHITECTURE_X86     = 0x00000000,
    APPX_PACKAGE_ARCHITECTURE_ARM     = 0x00000005,
    APPX_PACKAGE_ARCHITECTURE_X64     = 0x00000009,
    APPX_PACKAGE_ARCHITECTURE_NEUTRAL = 0x0000000b,
    APPX_PACKAGE_ARCHITECTURE_ARM64   = 0x0000000c,
}
alias APPX_PACKAGE_ARCHITECTURE = int;

enum : int
{
    APPX_PACKAGE_ARCHITECTURE2_X86          = 0x00000000,
    APPX_PACKAGE_ARCHITECTURE2_ARM          = 0x00000005,
    APPX_PACKAGE_ARCHITECTURE2_X64          = 0x00000009,
    APPX_PACKAGE_ARCHITECTURE2_NEUTRAL      = 0x0000000b,
    APPX_PACKAGE_ARCHITECTURE2_ARM64        = 0x0000000c,
    APPX_PACKAGE_ARCHITECTURE2_X86_ON_ARM64 = 0x0000000e,
    APPX_PACKAGE_ARCHITECTURE2_UNKNOWN      = 0x0000ffff,
}
alias APPX_PACKAGE_ARCHITECTURE2 = int;

enum : int
{
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_APPLICATION = 0x00000000,
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_RESOURCE    = 0x00000001,
}
alias APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE = int;

enum : int
{
    DX_FEATURE_LEVEL_UNSPECIFIED = 0x00000000,
    DX_FEATURE_LEVEL_9           = 0x00000001,
    DX_FEATURE_LEVEL_10          = 0x00000002,
    DX_FEATURE_LEVEL_11          = 0x00000003,
}
alias DX_FEATURE_LEVEL = int;

enum : int
{
    APPX_CAPABILITY_CLASS_DEFAULT    = 0x00000000,
    APPX_CAPABILITY_CLASS_GENERAL    = 0x00000001,
    APPX_CAPABILITY_CLASS_RESTRICTED = 0x00000002,
    APPX_CAPABILITY_CLASS_WINDOWS    = 0x00000004,
    APPX_CAPABILITY_CLASS_ALL        = 0x00000007,
    APPX_CAPABILITY_CLASS_CUSTOM     = 0x00000008,
}
alias APPX_CAPABILITY_CLASS_TYPE = int;

enum : int
{
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_START   = 0x00000000,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_CHANGE  = 0x00000001,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_DETAILS = 0x00000002,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_END     = 0x00000003,
}
alias APPX_PACKAGING_CONTEXT_CHANGE_TYPE = int;

enum : int
{
    APPX_ENCRYPTED_PACKAGE_OPTION_NONE         = 0x00000000,
    APPX_ENCRYPTED_PACKAGE_OPTION_DIFFUSION    = 0x00000001,
    APPX_ENCRYPTED_PACKAGE_OPTION_PAGE_HASHING = 0x00000002,
}
alias APPX_ENCRYPTED_PACKAGE_OPTIONS = int;

enum : int
{
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION_APPEND_DELTA = 0x00000000,
}
alias APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION = int;

enum : int
{
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_NONE            = 0x00000000,
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_SKIP_VALIDATION = 0x00000001,
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_LOCALIZED       = 0x00000002,
}
alias APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS = int;

enum PackagePathType : int
{
    PackagePathType_Install           = 0x00000000,
    PackagePathType_Mutable           = 0x00000001,
    PackagePathType_Effective         = 0x00000002,
    PackagePathType_MachineExternal   = 0x00000003,
    PackagePathType_UserExternal      = 0x00000004,
    PackagePathType_EffectiveExternal = 0x00000005,
}

enum PackageOrigin : int
{
    PackageOrigin_Unknown           = 0x00000000,
    PackageOrigin_Unsigned          = 0x00000001,
    PackageOrigin_Inbox             = 0x00000002,
    PackageOrigin_Store             = 0x00000003,
    PackageOrigin_DeveloperUnsigned = 0x00000004,
    PackageOrigin_DeveloperSigned   = 0x00000005,
    PackageOrigin_LineOfBusiness    = 0x00000006,
}

enum AppPolicyLifecycleManagement : int
{
    AppPolicyLifecycleManagement_Unmanaged = 0x00000000,
    AppPolicyLifecycleManagement_Managed   = 0x00000001,
}

enum AppPolicyWindowingModel : int
{
    AppPolicyWindowingModel_None           = 0x00000000,
    AppPolicyWindowingModel_Universal      = 0x00000001,
    AppPolicyWindowingModel_ClassicDesktop = 0x00000002,
    AppPolicyWindowingModel_ClassicPhone   = 0x00000003,
}

enum AppPolicyMediaFoundationCodecLoading : int
{
    AppPolicyMediaFoundationCodecLoading_All       = 0x00000000,
    AppPolicyMediaFoundationCodecLoading_InboxOnly = 0x00000001,
}

enum AppPolicyClrCompat : int
{
    AppPolicyClrCompat_Other           = 0x00000000,
    AppPolicyClrCompat_ClassicDesktop  = 0x00000001,
    AppPolicyClrCompat_Universal       = 0x00000002,
    AppPolicyClrCompat_PackagedDesktop = 0x00000003,
}

enum AppPolicyThreadInitializationType : int
{
    AppPolicyThreadInitializationType_None            = 0x00000000,
    AppPolicyThreadInitializationType_InitializeWinRT = 0x00000001,
}

enum AppPolicyShowDeveloperDiagnostic : int
{
    AppPolicyShowDeveloperDiagnostic_None   = 0x00000000,
    AppPolicyShowDeveloperDiagnostic_ShowUI = 0x00000001,
}

enum AppPolicyProcessTerminationMethod : int
{
    AppPolicyProcessTerminationMethod_ExitProcess      = 0x00000000,
    AppPolicyProcessTerminationMethod_TerminateProcess = 0x00000001,
}

enum AppPolicyCreateFileAccess : int
{
    AppPolicyCreateFileAccess_Full    = 0x00000000,
    AppPolicyCreateFileAccess_Limited = 0x00000001,
}

// Structs


struct APPX_PACKAGE_SETTINGS
{
    BOOL forceZip32;
    IUri hashMethod;
}

struct APPX_PACKAGE_WRITER_PAYLOAD_STREAM
{
    IStream       inputStream;
    const(wchar)* fileName;
    const(wchar)* contentType;
    APPX_COMPRESSION_OPTION compressionOption;
}

struct APPX_ENCRYPTED_PACKAGE_SETTINGS
{
    uint          keyLength;
    const(wchar)* encryptionAlgorithm;
    BOOL          useDiffusion;
    IUri          blockMapHashAlgorithm;
}

struct APPX_ENCRYPTED_PACKAGE_SETTINGS2
{
    uint          keyLength;
    const(wchar)* encryptionAlgorithm;
    IUri          blockMapHashAlgorithm;
    uint          options;
}

struct APPX_KEY_INFO
{
    uint   keyLength;
    uint   keyIdLength;
    ubyte* key;
    ubyte* keyId;
}

struct APPX_ENCRYPTED_EXEMPTIONS
{
    uint     count;
    ushort** plainTextFiles;
}

struct PACKAGE_VERSION
{
    union
    {
    align (4):
        ulong Version;
        struct
        {
            ushort Revision;
            ushort Build;
            ushort Minor;
            ushort Major;
        }
    }
}

struct PACKAGE_ID
{
    uint            reserved;
    uint            processorArchitecture;
    PACKAGE_VERSION version_;
    const(wchar)*   name;
    const(wchar)*   publisher;
    const(wchar)*   resourceId;
    const(wchar)*   publisherId;
}

struct _PACKAGE_INFO_REFERENCE
{
    void* reserved;
}

struct PACKAGE_INFO
{
    uint          reserved;
    uint          flags;
    const(wchar)* path;
    const(wchar)* packageFullName;
    const(wchar)* packageFamilyName;
    PACKAGE_ID    packageId;
}

// Functions

@DllImport("KERNEL32")
int GetCurrentPackageId(uint* bufferLength, char* buffer);

@DllImport("KERNEL32")
int GetCurrentPackageFullName(uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("KERNEL32")
int GetCurrentPackageFamilyName(uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("KERNEL32")
int GetCurrentPackagePath(uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32")
int GetPackageId(HANDLE hProcess, uint* bufferLength, char* buffer);

@DllImport("KERNEL32")
int GetPackageFullName(HANDLE hProcess, uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int GetPackageFullNameFromToken(HANDLE token, uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("KERNEL32")
int GetPackageFamilyName(HANDLE hProcess, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int GetPackageFamilyNameFromToken(HANDLE token, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("KERNEL32")
int GetPackagePath(const(PACKAGE_ID)* packageId, const(uint) reserved, uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32")
int GetPackagePathByFullName(const(wchar)* packageFullName, uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32")
int GetStagedPackagePathByFullName(const(wchar)* packageFullName, uint* pathLength, const(wchar)* path);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetPackagePathByFullName2(const(wchar)* packageFullName, PackagePathType packagePathType, uint* pathLength, 
                              const(wchar)* path);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetStagedPackagePathByFullName2(const(wchar)* packageFullName, PackagePathType packagePathType, 
                                    uint* pathLength, const(wchar)* path);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetCurrentPackageInfo2(const(uint) flags, PackagePathType packagePathType, uint* bufferLength, char* buffer, 
                           uint* count);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetCurrentPackagePath2(PackagePathType packagePathType, uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32")
int GetCurrentApplicationUserModelId(uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

@DllImport("KERNEL32")
int GetApplicationUserModelId(HANDLE hProcess, uint* applicationUserModelIdLength, 
                              const(wchar)* applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int GetApplicationUserModelIdFromToken(HANDLE token, uint* applicationUserModelIdLength, 
                                       const(wchar)* applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int VerifyPackageFullName(const(wchar)* packageFullName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int VerifyPackageFamilyName(const(wchar)* packageFamilyName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int VerifyPackageId(const(PACKAGE_ID)* packageId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int VerifyApplicationUserModelId(const(wchar)* applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int VerifyPackageRelativeApplicationId(const(wchar)* packageRelativeApplicationId);

@DllImport("KERNEL32")
int PackageIdFromFullName(const(wchar)* packageFullName, const(uint) flags, uint* bufferLength, char* buffer);

@DllImport("KERNEL32")
int PackageFullNameFromId(const(PACKAGE_ID)* packageId, uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("KERNEL32")
int PackageFamilyNameFromId(const(PACKAGE_ID)* packageId, uint* packageFamilyNameLength, 
                            const(wchar)* packageFamilyName);

@DllImport("KERNEL32")
int PackageFamilyNameFromFullName(const(wchar)* packageFullName, uint* packageFamilyNameLength, 
                                  const(wchar)* packageFamilyName);

@DllImport("KERNEL32")
int PackageNameAndPublisherIdFromFamilyName(const(wchar)* packageFamilyName, uint* packageNameLength, 
                                            const(wchar)* packageName, uint* packagePublisherIdLength, 
                                            const(wchar)* packagePublisherId);

@DllImport("KERNEL32")
int FormatApplicationUserModelId(const(wchar)* packageFamilyName, const(wchar)* packageRelativeApplicationId, 
                                 uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

@DllImport("KERNEL32")
int ParseApplicationUserModelId(const(wchar)* applicationUserModelId, uint* packageFamilyNameLength, 
                                const(wchar)* packageFamilyName, uint* packageRelativeApplicationIdLength, 
                                const(wchar)* packageRelativeApplicationId);

@DllImport("KERNEL32")
int GetPackagesByPackageFamily(const(wchar)* packageFamilyName, uint* count, char* packageFullNames, 
                               uint* bufferLength, char* buffer);

@DllImport("KERNEL32")
int FindPackagesByPackageFamily(const(wchar)* packageFamilyName, uint packageFilters, uint* count, 
                                char* packageFullNames, uint* bufferLength, char* buffer, char* packageProperties);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int GetStagedPackageOrigin(const(wchar)* packageFullName, PackageOrigin* origin);

@DllImport("KERNEL32")
int GetCurrentPackageInfo(const(uint) flags, uint* bufferLength, char* buffer, uint* count);

@DllImport("KERNEL32")
int OpenPackageInfoByFullName(const(wchar)* packageFullName, const(uint) reserved, 
                              _PACKAGE_INFO_REFERENCE** packageInfoReference);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int OpenPackageInfoByFullNameForUser(void* userSid, const(wchar)* packageFullName, const(uint) reserved, 
                                     _PACKAGE_INFO_REFERENCE** packageInfoReference);

@DllImport("KERNEL32")
int ClosePackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference);

@DllImport("KERNEL32")
int GetPackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference, const(uint) flags, uint* bufferLength, 
                   char* buffer, uint* count);

@DllImport("KERNEL32")
int GetPackageApplicationIds(_PACKAGE_INFO_REFERENCE* packageInfoReference, uint* bufferLength, char* buffer, 
                             uint* count);

@DllImport("KERNEL32")
int AppPolicyGetLifecycleManagement(HANDLE processToken, AppPolicyLifecycleManagement* policy);

@DllImport("KERNEL32")
int AppPolicyGetWindowingModel(HANDLE processToken, AppPolicyWindowingModel* policy);

@DllImport("KERNEL32")
int AppPolicyGetMediaFoundationCodecLoading(HANDLE processToken, AppPolicyMediaFoundationCodecLoading* policy);

@DllImport("KERNEL32")
int AppPolicyGetClrCompat(HANDLE processToken, AppPolicyClrCompat* policy);

@DllImport("KERNEL32")
int AppPolicyGetThreadInitializationType(HANDLE processToken, AppPolicyThreadInitializationType* policy);

@DllImport("KERNEL32")
int AppPolicyGetShowDeveloperDiagnostic(HANDLE processToken, AppPolicyShowDeveloperDiagnostic* policy);

@DllImport("KERNEL32")
int AppPolicyGetProcessTerminationMethod(HANDLE processToken, AppPolicyProcessTerminationMethod* policy);

@DllImport("KERNEL32")
int AppPolicyGetCreateFileAccess(HANDLE processToken, AppPolicyCreateFileAccess* policy);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetPackageInfo2(_PACKAGE_INFO_REFERENCE* packageInfoReference, const(uint) flags, 
                    PackagePathType packagePathType, uint* bufferLength, char* buffer, uint* count);


// Interfaces

@GUID("5842A140-FF9F-4166-8F5C-62F5B7B0C781")
struct AppxFactory;

@GUID("378E0446-5384-43B7-8877-E7DBDD883446")
struct AppxBundleFactory;

@GUID("50CA0A46-1588-4161-8ED2-EF9E469CED5D")
struct AppxPackagingDiagnosticEventSinkManager;

@GUID("DC664FDD-D868-46EE-8780-8D196CB739F7")
struct AppxEncryptionFactory;

@GUID("F004F2CA-AEBC-4B0D-BF58-E516D5BCC0AB")
struct AppxPackageEditor;

@GUID("BEB94909-E451-438B-B5A7-D79E767B75D8")
interface IAppxFactory : IUnknown
{
    HRESULT CreatePackageWriter(IStream outputStream, APPX_PACKAGE_SETTINGS* settings, 
                                IAppxPackageWriter* packageWriter);
    HRESULT CreatePackageReader(IStream inputStream, IAppxPackageReader* packageReader);
    HRESULT CreateManifestReader(IStream inputStream, IAppxManifestReader* manifestReader);
    HRESULT CreateBlockMapReader(IStream inputStream, IAppxBlockMapReader* blockMapReader);
    HRESULT CreateValidatedBlockMapReader(IStream blockMapStream, const(wchar)* signatureFileName, 
                                          IAppxBlockMapReader* blockMapReader);
}

@GUID("F1346DF2-C282-4E22-B918-743A929A8D55")
interface IAppxFactory2 : IUnknown
{
    HRESULT CreateContentGroupMapReader(IStream inputStream, IAppxContentGroupMapReader* contentGroupMapReader);
    HRESULT CreateSourceContentGroupMapReader(IStream inputStream, IAppxSourceContentGroupMapReader* reader);
    HRESULT CreateContentGroupMapWriter(IStream stream, IAppxContentGroupMapWriter* contentGroupMapWriter);
}

@GUID("B5C49650-99BC-481C-9A34-3D53A4106708")
interface IAppxPackageReader : IUnknown
{
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    HRESULT GetFootprintFile(APPX_FOOTPRINT_FILE_TYPE type, IAppxFile* file);
    HRESULT GetPayloadFile(const(wchar)* fileName, IAppxFile* file);
    HRESULT GetPayloadFiles(IAppxFilesEnumerator* filesEnumerator);
    HRESULT GetManifest(IAppxManifestReader* manifestReader);
}

@GUID("9099E33B-246F-41E4-881A-008EB613F858")
interface IAppxPackageWriter : IUnknown
{
    HRESULT AddPayloadFile(const(wchar)* fileName, const(wchar)* contentType, 
                           APPX_COMPRESSION_OPTION compressionOption, IStream inputStream);
    HRESULT Close(IStream manifest);
}

@GUID("2CF5C4FD-E54C-4EA5-BA4E-F8C4B105A8C8")
interface IAppxPackageWriter2 : IUnknown
{
    HRESULT Close(IStream manifest, IStream contentGroupMap);
}

@GUID("A83AACD3-41C0-4501-B8A3-74164F50B2FD")
interface IAppxPackageWriter3 : IUnknown
{
    HRESULT AddPayloadFiles(uint fileCount, char* payloadFiles, ulong memoryLimit);
}

@GUID("91DF827B-94FD-468F-827B-57F41B2F6F2E")
interface IAppxFile : IUnknown
{
    HRESULT GetCompressionOption(APPX_COMPRESSION_OPTION* compressionOption);
    HRESULT GetContentType(ushort** contentType);
    HRESULT GetName(ushort** fileName);
    HRESULT GetSize(ulong* size);
    HRESULT GetStream(IStream* stream);
}

@GUID("F007EEAF-9831-411C-9847-917CDC62D1FE")
interface IAppxFilesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxFile* file);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("5EFEC991-BCA3-42D1-9EC2-E92D609EC22A")
interface IAppxBlockMapReader : IUnknown
{
    HRESULT GetFile(const(wchar)* filename, IAppxBlockMapFile* file);
    HRESULT GetFiles(IAppxBlockMapFilesEnumerator* enumerator);
    HRESULT GetHashMethod(IUri* hashMethod);
    HRESULT GetStream(IStream* blockMapStream);
}

@GUID("277672AC-4F63-42C1-8ABC-BEAE3600EB59")
interface IAppxBlockMapFile : IUnknown
{
    HRESULT GetBlocks(IAppxBlockMapBlocksEnumerator* blocks);
    HRESULT GetLocalFileHeaderSize(uint* lfhSize);
    HRESULT GetName(ushort** name);
    HRESULT GetUncompressedSize(ulong* size);
    HRESULT ValidateFileHash(IStream fileStream, int* isValid);
}

@GUID("02B856A2-4262-4070-BACB-1A8CBBC42305")
interface IAppxBlockMapFilesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBlockMapFile* file);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasCurrent);
}

@GUID("75CF3930-3244-4FE0-A8C8-E0BCB270B889")
interface IAppxBlockMapBlock : IUnknown
{
    HRESULT GetHash(uint* bufferSize, char* buffer);
    HRESULT GetCompressedSize(uint* size);
}

@GUID("6B429B5B-36EF-479E-B9EB-0C1482B49E16")
interface IAppxBlockMapBlocksEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBlockMapBlock* block);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("4E1BD148-55A0-4480-A3D1-15544710637C")
interface IAppxManifestReader : IUnknown
{
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    HRESULT GetProperties(IAppxManifestProperties* packageProperties);
    HRESULT GetPackageDependencies(IAppxManifestPackageDependenciesEnumerator* dependencies);
    HRESULT GetCapabilities(APPX_CAPABILITIES* capabilities);
    HRESULT GetResources(IAppxManifestResourcesEnumerator* resources);
    HRESULT GetDeviceCapabilities(IAppxManifestDeviceCapabilitiesEnumerator* deviceCapabilities);
    HRESULT GetPrerequisite(const(wchar)* name, ulong* value);
    HRESULT GetApplications(IAppxManifestApplicationsEnumerator* applications);
    HRESULT GetStream(IStream* manifestStream);
}

@GUID("D06F67BC-B31D-4EBA-A8AF-638E73E77B4D")
interface IAppxManifestReader2 : IAppxManifestReader
{
    HRESULT GetQualifiedResources(IAppxManifestQualifiedResourcesEnumerator* resources);
}

@GUID("C43825AB-69B7-400A-9709-CC37F5A72D24")
interface IAppxManifestReader3 : IAppxManifestReader2
{
    HRESULT GetCapabilitiesByCapabilityClass(APPX_CAPABILITY_CLASS_TYPE capabilityClass, 
                                             IAppxManifestCapabilitiesEnumerator* capabilities);
    HRESULT GetTargetDeviceFamilies(IAppxManifestTargetDeviceFamiliesEnumerator* targetDeviceFamilies);
}

@GUID("4579BB7C-741D-4161-B5A1-47BD3B78AD9B")
interface IAppxManifestReader4 : IAppxManifestReader3
{
    HRESULT GetOptionalPackageInfo(IAppxManifestOptionalPackageInfo* optionalPackageInfo);
}

@GUID("8D7AE132-A690-4C00-B75A-6AAE1FEAAC80")
interface IAppxManifestReader5 : IUnknown
{
    HRESULT GetMainPackageDependencies(IAppxManifestMainPackageDependenciesEnumerator* mainPackageDependencies);
}

@GUID("34DEACA4-D3C0-4E3E-B312-E42625E3807E")
interface IAppxManifestReader6 : IUnknown
{
    HRESULT GetIsNonQualifiedResourcePackage(int* isNonQualifiedResourcePackage);
}

@GUID("8EFE6F27-0CE0-4988-B32D-738EB63DB3B7")
interface IAppxManifestReader7 : IUnknown
{
    HRESULT GetDriverDependencies(IAppxManifestDriverDependenciesEnumerator* driverDependencies);
    HRESULT GetOSPackageDependencies(IAppxManifestOSPackageDependenciesEnumerator* osPackageDependencies);
    HRESULT GetHostRuntimeDependencies(IAppxManifestHostRuntimeDependenciesEnumerator* hostRuntimeDependencies);
}

@GUID("FE039DB2-467F-4755-8404-8F5EB6865B33")
interface IAppxManifestDriverDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestDriverDependency* driverDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("1210CB94-5A92-4602-BE24-79F318AF4AF9")
interface IAppxManifestDriverDependency : IUnknown
{
    HRESULT GetDriverConstraints(IAppxManifestDriverConstraintsEnumerator* driverConstraints);
}

@GUID("D402B2D1-F600-49E0-95E6-975D8DA13D89")
interface IAppxManifestDriverConstraintsEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestDriverConstraint* driverConstraint);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("C031BEE4-BBCC-48EA-A237-C34045C80A07")
interface IAppxManifestDriverConstraint : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetMinVersion(ulong* minVersion);
    HRESULT GetMinDate(ushort** minDate);
}

@GUID("B84E2FC3-F8EC-4BC1-8AE2-156346F5FFEA")
interface IAppxManifestOSPackageDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestOSPackageDependency* osPackageDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("154995EE-54A6-4F14-AC97-D8CF0519644B")
interface IAppxManifestOSPackageDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetVersion(ulong* version_);
}

@GUID("6427A646-7F49-433E-B1A6-0DA309F6885A")
interface IAppxManifestHostRuntimeDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestHostRuntimeDependency* hostRuntimeDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("3455D234-8414-410D-95C7-7B35255B8391")
interface IAppxManifestHostRuntimeDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetPublisher(ushort** publisher);
    HRESULT GetMinVersion(ulong* minVersion);
}

@GUID("2634847D-5B5D-4FE5-A243-002FF95EDC7E")
interface IAppxManifestOptionalPackageInfo : IUnknown
{
    HRESULT GetIsOptionalPackage(int* isOptionalPackage);
    HRESULT GetMainPackageName(ushort** mainPackageName);
}

@GUID("A99C4F00-51D2-4F0F-BA46-7ED5255EBDFF")
interface IAppxManifestMainPackageDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestMainPackageDependency* mainPackageDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("05D0611C-BC29-46D5-97E2-84B9C79BD8AE")
interface IAppxManifestMainPackageDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetPublisher(ushort** publisher);
    HRESULT GetPackageFamilyName(ushort** packageFamilyName);
}

@GUID("283CE2D7-7153-4A91-9649-7A0F7240945F")
interface IAppxManifestPackageId : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetArchitecture(APPX_PACKAGE_ARCHITECTURE* architecture);
    HRESULT GetPublisher(ushort** publisher);
    HRESULT GetVersion(ulong* packageVersion);
    HRESULT GetResourceId(ushort** resourceId);
    HRESULT ComparePublisher(const(wchar)* other, int* isSame);
    HRESULT GetPackageFullName(ushort** packageFullName);
    HRESULT GetPackageFamilyName(ushort** packageFamilyName);
}

@GUID("2256999D-D617-42F1-880E-0BA4542319D5")
interface IAppxManifestPackageId2 : IAppxManifestPackageId
{
    HRESULT GetArchitecture2(APPX_PACKAGE_ARCHITECTURE2* architecture);
}

@GUID("03FAF64D-F26F-4B2C-AAF7-8FE7789B8BCA")
interface IAppxManifestProperties : IUnknown
{
    HRESULT GetBoolValue(const(wchar)* name, int* value);
    HRESULT GetStringValue(const(wchar)* name, ushort** value);
}

@GUID("36537F36-27A4-4788-88C0-733819575017")
interface IAppxManifestTargetDeviceFamiliesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestTargetDeviceFamily* targetDeviceFamily);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("9091B09B-C8D5-4F31-8687-A338259FAEFB")
interface IAppxManifestTargetDeviceFamily : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetMinVersion(ulong* minVersion);
    HRESULT GetMaxVersionTested(ulong* maxVersionTested);
}

@GUID("B43BBCF9-65A6-42DD-BAC0-8C6741E7F5A4")
interface IAppxManifestPackageDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestPackageDependency* dependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("E4946B59-733E-43F0-A724-3BDE4C1285A0")
interface IAppxManifestPackageDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetPublisher(ushort** publisher);
    HRESULT GetMinVersion(ulong* minVersion);
}

@GUID("DDA0B713-F3FF-49D3-898A-2786780C5D98")
interface IAppxManifestPackageDependency2 : IAppxManifestPackageDependency
{
    HRESULT GetMaxMajorVersionTested(ushort* maxMajorVersionTested);
}

@GUID("1AC56374-6198-4D6B-92E4-749D5AB8A895")
interface IAppxManifestPackageDependency3 : IUnknown
{
    HRESULT GetIsOptional(int* isOptional);
}

@GUID("DE4DFBBD-881A-48BB-858C-D6F2BAEAE6ED")
interface IAppxManifestResourcesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** resource);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("30204541-427B-4A1C-BACF-655BF463A540")
interface IAppxManifestDeviceCapabilitiesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** deviceCapability);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("11D22258-F470-42C1-B291-8361C5437E41")
interface IAppxManifestCapabilitiesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** capability);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("9EB8A55A-F04B-4D0D-808D-686185D4847A")
interface IAppxManifestApplicationsEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestApplication* application);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("5DA89BF4-3773-46BE-B650-7E744863B7E8")
interface IAppxManifestApplication : IUnknown
{
    HRESULT GetStringValue(const(wchar)* name, ushort** value);
    HRESULT GetAppUserModelId(ushort** appUserModelId);
}

@GUID("8EF6ADFE-3762-4A8F-9373-2FC5D444C8D2")
interface IAppxManifestQualifiedResourcesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestQualifiedResource* resource);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("3B53A497-3C5C-48D1-9EA3-BB7EAC8CD7D4")
interface IAppxManifestQualifiedResource : IUnknown
{
    HRESULT GetLanguage(ushort** language);
    HRESULT GetScale(uint* scale);
    HRESULT GetDXFeatureLevel(DX_FEATURE_LEVEL* dxFeatureLevel);
}

@GUID("BBA65864-965F-4A5F-855F-F074BDBF3A7B")
interface IAppxBundleFactory : IUnknown
{
    HRESULT CreateBundleWriter(IStream outputStream, ulong bundleVersion, IAppxBundleWriter* bundleWriter);
    HRESULT CreateBundleReader(IStream inputStream, IAppxBundleReader* bundleReader);
    HRESULT CreateBundleManifestReader(IStream inputStream, IAppxBundleManifestReader* manifestReader);
}

@GUID("EC446FE8-BFEC-4C64-AB4F-49F038F0C6D2")
interface IAppxBundleWriter : IUnknown
{
    HRESULT AddPayloadPackage(const(wchar)* fileName, IStream packageStream);
    HRESULT Close();
}

@GUID("6D8FE971-01CC-49A0-B685-233851279962")
interface IAppxBundleWriter2 : IUnknown
{
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream);
}

@GUID("AD711152-F969-4193-82D5-9DDF2786D21A")
interface IAppxBundleWriter3 : IUnknown
{
    HRESULT AddPackageReference(const(wchar)* fileName, IStream inputStream);
    HRESULT Close(const(wchar)* hashMethodString);
}

@GUID("9CD9D523-5009-4C01-9882-DC029FBD47A3")
interface IAppxBundleWriter4 : IUnknown
{
    HRESULT AddPayloadPackage(const(wchar)* fileName, IStream packageStream, BOOL isDefaultApplicablePackage);
    HRESULT AddPackageReference(const(wchar)* fileName, IStream inputStream, BOOL isDefaultApplicablePackage);
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream, 
                                        BOOL isDefaultApplicablePackage);
}

@GUID("DD75B8C0-BA76-43B0-AE0F-68656A1DC5C8")
interface IAppxBundleReader : IUnknown
{
    HRESULT GetFootprintFile(APPX_BUNDLE_FOOTPRINT_FILE_TYPE fileType, IAppxFile* footprintFile);
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    HRESULT GetManifest(IAppxBundleManifestReader* manifestReader);
    HRESULT GetPayloadPackages(IAppxFilesEnumerator* payloadPackages);
    HRESULT GetPayloadPackage(const(wchar)* fileName, IAppxFile* payloadPackage);
}

@GUID("CF0EBBC1-CC99-4106-91EB-E67462E04FB0")
interface IAppxBundleManifestReader : IUnknown
{
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
    HRESULT GetStream(IStream* manifestStream);
}

@GUID("5517DF70-033F-4AF2-8213-87D766805C02")
interface IAppxBundleManifestReader2 : IUnknown
{
    HRESULT GetOptionalBundles(IAppxBundleManifestOptionalBundleInfoEnumerator* optionalBundles);
}

@GUID("F9B856EE-49A6-4E19-B2B0-6A2406D63A32")
interface IAppxBundleManifestPackageInfoEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBundleManifestPackageInfo* packageInfo);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("54CD06C1-268F-40BB-8ED2-757A9EBAEC8D")
interface IAppxBundleManifestPackageInfo : IUnknown
{
    HRESULT GetPackageType(APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE* packageType);
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    HRESULT GetFileName(ushort** fileName);
    HRESULT GetOffset(ulong* offset);
    HRESULT GetSize(ulong* size);
    HRESULT GetResources(IAppxManifestQualifiedResourcesEnumerator* resources);
}

@GUID("44C2ACBC-B2CF-4CCB-BBDB-9C6DA8C3BC9E")
interface IAppxBundleManifestPackageInfo2 : IUnknown
{
    HRESULT GetIsPackageReference(int* isPackageReference);
    HRESULT GetIsNonQualifiedResourcePackage(int* isNonQualifiedResourcePackage);
    HRESULT GetIsDefaultApplicablePackage(int* isDefaultApplicablePackage);
}

@GUID("6BA74B98-BB74-4296-80D0-5F4256A99675")
interface IAppxBundleManifestPackageInfo3 : IUnknown
{
    HRESULT GetTargetDeviceFamilies(IAppxManifestTargetDeviceFamiliesEnumerator* targetDeviceFamilies);
}

@GUID("5DA6F13D-A8A7-4532-857C-1393D659371D")
interface IAppxBundleManifestPackageInfo4 : IUnknown
{
    HRESULT GetIsStub(int* isStub);
}

@GUID("9A178793-F97E-46AC-AACA-DD5BA4C177C8")
interface IAppxBundleManifestOptionalBundleInfoEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBundleManifestOptionalBundleInfo* optionalBundle);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("515BF2E8-BCB0-4D69-8C48-E383147B6E12")
interface IAppxBundleManifestOptionalBundleInfo : IUnknown
{
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    HRESULT GetFileName(ushort** fileName);
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
}

@GUID("1A09A2FD-7440-44EB-8C84-848205A6A1CC")
interface IAppxContentGroupFilesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** file);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("328F6468-C04F-4E3C-B6FA-6B8D27F3003A")
interface IAppxContentGroup : IUnknown
{
    HRESULT GetName(ushort** groupName);
    HRESULT GetFiles(IAppxContentGroupFilesEnumerator* enumerator);
}

@GUID("3264E477-16D1-4D63-823E-7D2984696634")
interface IAppxContentGroupsEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxContentGroup* stream);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

@GUID("418726D8-DD99-4F5D-9886-157ADD20DE01")
interface IAppxContentGroupMapReader : IUnknown
{
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

@GUID("F329791D-540B-4A9F-BC75-3282B7D73193")
interface IAppxSourceContentGroupMapReader : IUnknown
{
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

@GUID("D07AB776-A9DE-4798-8C14-3DB31E687C78")
interface IAppxContentGroupMapWriter : IUnknown
{
    HRESULT AddAutomaticGroup(const(wchar)* groupName);
    HRESULT AddAutomaticFile(const(wchar)* fileName);
    HRESULT Close();
}

@GUID("17239D47-6ADB-45D2-80F6-F9CBC3BF059D")
interface IAppxPackagingDiagnosticEventSink : IUnknown
{
    HRESULT ReportContextChange(APPX_PACKAGING_CONTEXT_CHANGE_TYPE changeType, int contextId, 
                                const(char)* contextName, const(wchar)* contextMessage, const(wchar)* detailsMessage);
    HRESULT ReportError(const(wchar)* errorMessage);
}

@GUID("369648FA-A7EB-4909-A15D-6954A078F18A")
interface IAppxPackagingDiagnosticEventSinkManager : IUnknown
{
    HRESULT SetSinkForProcess(IAppxPackagingDiagnosticEventSink sink);
}

@GUID("80E8E04D-8C88-44AE-A011-7CADF6FB2E72")
interface IAppxEncryptionFactory : IUnknown
{
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT DecryptPackage(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
    HRESULT CreateEncryptedPackageReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                         IAppxPackageReader* packageReader);
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, 
                          const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, 
                          const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT DecryptBundle(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, 
                                        const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                        const(APPX_KEY_INFO)* keyInfo, 
                                        const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                        IAppxEncryptedBundleWriter* bundleWriter);
    HRESULT CreateEncryptedBundleReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                        IAppxBundleReader* bundleReader);
}

@GUID("C1B11EEE-C4BA-4AB2-A55D-D015FE8FF64F")
interface IAppxEncryptionFactory2 : IUnknown
{
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         IStream contentGroupMapStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
}

@GUID("09EDCA37-CD64-47D6-B7E8-1CB11D4F7E05")
interface IAppxEncryptionFactory3 : IUnknown
{
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         IStream contentGroupMapStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, 
                          const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                          const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, 
                                        const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, 
                                        const(APPX_KEY_INFO)* keyInfo, 
                                        const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                        IAppxEncryptedBundleWriter* bundleWriter);
}

@GUID("A879611F-12FD-41FE-85D5-06AE779BBAF5")
interface IAppxEncryptionFactory4 : IUnknown
{
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, ulong memoryLimit);
}

@GUID("F43D0B0B-1379-40E2-9B29-682EA2BF42AF")
interface IAppxEncryptedPackageWriter : IUnknown
{
    HRESULT AddPayloadFileEncrypted(const(wchar)* fileName, APPX_COMPRESSION_OPTION compressionOption, 
                                    IStream inputStream);
    HRESULT Close();
}

@GUID("3E475447-3A25-40B5-8AD2-F953AE50C92D")
interface IAppxEncryptedPackageWriter2 : IUnknown
{
    HRESULT AddPayloadFilesEncrypted(uint fileCount, char* payloadFiles, ulong memoryLimit);
}

@GUID("80B0902F-7BF0-4117-B8C6-4279EF81EE77")
interface IAppxEncryptedBundleWriter : IUnknown
{
    HRESULT AddPayloadPackageEncrypted(const(wchar)* fileName, IStream packageStream);
    HRESULT Close();
}

@GUID("E644BE82-F0FA-42B8-A956-8D1CB48EE379")
interface IAppxEncryptedBundleWriter2 : IUnknown
{
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream);
}

@GUID("0D34DEB3-5CAE-4DD3-977C-504932A51D31")
interface IAppxEncryptedBundleWriter3 : IUnknown
{
    HRESULT AddPayloadPackageEncrypted(const(wchar)* fileName, IStream packageStream, 
                                       BOOL isDefaultApplicablePackage);
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream, 
                                        BOOL isDefaultApplicablePackage);
}

@GUID("E2ADB6DC-5E71-4416-86B6-86E5F5291A6B")
interface IAppxPackageEditor : IUnknown
{
    HRESULT SetWorkingDirectory(const(wchar)* workingDirectory);
    HRESULT CreateDeltaPackage(IStream updatedPackageStream, IStream baselinePackageStream, 
                               IStream deltaPackageStream);
    HRESULT CreateDeltaPackageUsingBaselineBlockMap(IStream updatedPackageStream, IStream baselineBlockMapStream, 
                                                    const(wchar)* baselinePackageFullName, 
                                                    IStream deltaPackageStream);
    HRESULT UpdatePackage(IStream baselinePackageStream, IStream deltaPackageStream, 
                          APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption);
    HRESULT UpdateEncryptedPackage(IStream baselineEncryptedPackageStream, IStream deltaPackageStream, 
                                   APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption, 
                                   const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo);
    HRESULT UpdatePackageManifest(IStream packageStream, IStream updatedManifestStream, BOOL isPackageEncrypted, 
                                  APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS options);
}


// GUIDs

const GUID CLSID_AppxBundleFactory                       = GUIDOF!AppxBundleFactory;
const GUID CLSID_AppxEncryptionFactory                   = GUIDOF!AppxEncryptionFactory;
const GUID CLSID_AppxFactory                             = GUIDOF!AppxFactory;
const GUID CLSID_AppxPackageEditor                       = GUIDOF!AppxPackageEditor;
const GUID CLSID_AppxPackagingDiagnosticEventSinkManager = GUIDOF!AppxPackagingDiagnosticEventSinkManager;

const GUID IID_IAppxBlockMapBlock                              = GUIDOF!IAppxBlockMapBlock;
const GUID IID_IAppxBlockMapBlocksEnumerator                   = GUIDOF!IAppxBlockMapBlocksEnumerator;
const GUID IID_IAppxBlockMapFile                               = GUIDOF!IAppxBlockMapFile;
const GUID IID_IAppxBlockMapFilesEnumerator                    = GUIDOF!IAppxBlockMapFilesEnumerator;
const GUID IID_IAppxBlockMapReader                             = GUIDOF!IAppxBlockMapReader;
const GUID IID_IAppxBundleFactory                              = GUIDOF!IAppxBundleFactory;
const GUID IID_IAppxBundleManifestOptionalBundleInfo           = GUIDOF!IAppxBundleManifestOptionalBundleInfo;
const GUID IID_IAppxBundleManifestOptionalBundleInfoEnumerator = GUIDOF!IAppxBundleManifestOptionalBundleInfoEnumerator;
const GUID IID_IAppxBundleManifestPackageInfo                  = GUIDOF!IAppxBundleManifestPackageInfo;
const GUID IID_IAppxBundleManifestPackageInfo2                 = GUIDOF!IAppxBundleManifestPackageInfo2;
const GUID IID_IAppxBundleManifestPackageInfo3                 = GUIDOF!IAppxBundleManifestPackageInfo3;
const GUID IID_IAppxBundleManifestPackageInfo4                 = GUIDOF!IAppxBundleManifestPackageInfo4;
const GUID IID_IAppxBundleManifestPackageInfoEnumerator        = GUIDOF!IAppxBundleManifestPackageInfoEnumerator;
const GUID IID_IAppxBundleManifestReader                       = GUIDOF!IAppxBundleManifestReader;
const GUID IID_IAppxBundleManifestReader2                      = GUIDOF!IAppxBundleManifestReader2;
const GUID IID_IAppxBundleReader                               = GUIDOF!IAppxBundleReader;
const GUID IID_IAppxBundleWriter                               = GUIDOF!IAppxBundleWriter;
const GUID IID_IAppxBundleWriter2                              = GUIDOF!IAppxBundleWriter2;
const GUID IID_IAppxBundleWriter3                              = GUIDOF!IAppxBundleWriter3;
const GUID IID_IAppxBundleWriter4                              = GUIDOF!IAppxBundleWriter4;
const GUID IID_IAppxContentGroup                               = GUIDOF!IAppxContentGroup;
const GUID IID_IAppxContentGroupFilesEnumerator                = GUIDOF!IAppxContentGroupFilesEnumerator;
const GUID IID_IAppxContentGroupMapReader                      = GUIDOF!IAppxContentGroupMapReader;
const GUID IID_IAppxContentGroupMapWriter                      = GUIDOF!IAppxContentGroupMapWriter;
const GUID IID_IAppxContentGroupsEnumerator                    = GUIDOF!IAppxContentGroupsEnumerator;
const GUID IID_IAppxEncryptedBundleWriter                      = GUIDOF!IAppxEncryptedBundleWriter;
const GUID IID_IAppxEncryptedBundleWriter2                     = GUIDOF!IAppxEncryptedBundleWriter2;
const GUID IID_IAppxEncryptedBundleWriter3                     = GUIDOF!IAppxEncryptedBundleWriter3;
const GUID IID_IAppxEncryptedPackageWriter                     = GUIDOF!IAppxEncryptedPackageWriter;
const GUID IID_IAppxEncryptedPackageWriter2                    = GUIDOF!IAppxEncryptedPackageWriter2;
const GUID IID_IAppxEncryptionFactory                          = GUIDOF!IAppxEncryptionFactory;
const GUID IID_IAppxEncryptionFactory2                         = GUIDOF!IAppxEncryptionFactory2;
const GUID IID_IAppxEncryptionFactory3                         = GUIDOF!IAppxEncryptionFactory3;
const GUID IID_IAppxEncryptionFactory4                         = GUIDOF!IAppxEncryptionFactory4;
const GUID IID_IAppxFactory                                    = GUIDOF!IAppxFactory;
const GUID IID_IAppxFactory2                                   = GUIDOF!IAppxFactory2;
const GUID IID_IAppxFile                                       = GUIDOF!IAppxFile;
const GUID IID_IAppxFilesEnumerator                            = GUIDOF!IAppxFilesEnumerator;
const GUID IID_IAppxManifestApplication                        = GUIDOF!IAppxManifestApplication;
const GUID IID_IAppxManifestApplicationsEnumerator             = GUIDOF!IAppxManifestApplicationsEnumerator;
const GUID IID_IAppxManifestCapabilitiesEnumerator             = GUIDOF!IAppxManifestCapabilitiesEnumerator;
const GUID IID_IAppxManifestDeviceCapabilitiesEnumerator       = GUIDOF!IAppxManifestDeviceCapabilitiesEnumerator;
const GUID IID_IAppxManifestDriverConstraint                   = GUIDOF!IAppxManifestDriverConstraint;
const GUID IID_IAppxManifestDriverConstraintsEnumerator        = GUIDOF!IAppxManifestDriverConstraintsEnumerator;
const GUID IID_IAppxManifestDriverDependenciesEnumerator       = GUIDOF!IAppxManifestDriverDependenciesEnumerator;
const GUID IID_IAppxManifestDriverDependency                   = GUIDOF!IAppxManifestDriverDependency;
const GUID IID_IAppxManifestHostRuntimeDependenciesEnumerator  = GUIDOF!IAppxManifestHostRuntimeDependenciesEnumerator;
const GUID IID_IAppxManifestHostRuntimeDependency              = GUIDOF!IAppxManifestHostRuntimeDependency;
const GUID IID_IAppxManifestMainPackageDependenciesEnumerator  = GUIDOF!IAppxManifestMainPackageDependenciesEnumerator;
const GUID IID_IAppxManifestMainPackageDependency              = GUIDOF!IAppxManifestMainPackageDependency;
const GUID IID_IAppxManifestOSPackageDependenciesEnumerator    = GUIDOF!IAppxManifestOSPackageDependenciesEnumerator;
const GUID IID_IAppxManifestOSPackageDependency                = GUIDOF!IAppxManifestOSPackageDependency;
const GUID IID_IAppxManifestOptionalPackageInfo                = GUIDOF!IAppxManifestOptionalPackageInfo;
const GUID IID_IAppxManifestPackageDependenciesEnumerator      = GUIDOF!IAppxManifestPackageDependenciesEnumerator;
const GUID IID_IAppxManifestPackageDependency                  = GUIDOF!IAppxManifestPackageDependency;
const GUID IID_IAppxManifestPackageDependency2                 = GUIDOF!IAppxManifestPackageDependency2;
const GUID IID_IAppxManifestPackageDependency3                 = GUIDOF!IAppxManifestPackageDependency3;
const GUID IID_IAppxManifestPackageId                          = GUIDOF!IAppxManifestPackageId;
const GUID IID_IAppxManifestPackageId2                         = GUIDOF!IAppxManifestPackageId2;
const GUID IID_IAppxManifestProperties                         = GUIDOF!IAppxManifestProperties;
const GUID IID_IAppxManifestQualifiedResource                  = GUIDOF!IAppxManifestQualifiedResource;
const GUID IID_IAppxManifestQualifiedResourcesEnumerator       = GUIDOF!IAppxManifestQualifiedResourcesEnumerator;
const GUID IID_IAppxManifestReader                             = GUIDOF!IAppxManifestReader;
const GUID IID_IAppxManifestReader2                            = GUIDOF!IAppxManifestReader2;
const GUID IID_IAppxManifestReader3                            = GUIDOF!IAppxManifestReader3;
const GUID IID_IAppxManifestReader4                            = GUIDOF!IAppxManifestReader4;
const GUID IID_IAppxManifestReader5                            = GUIDOF!IAppxManifestReader5;
const GUID IID_IAppxManifestReader6                            = GUIDOF!IAppxManifestReader6;
const GUID IID_IAppxManifestReader7                            = GUIDOF!IAppxManifestReader7;
const GUID IID_IAppxManifestResourcesEnumerator                = GUIDOF!IAppxManifestResourcesEnumerator;
const GUID IID_IAppxManifestTargetDeviceFamiliesEnumerator     = GUIDOF!IAppxManifestTargetDeviceFamiliesEnumerator;
const GUID IID_IAppxManifestTargetDeviceFamily                 = GUIDOF!IAppxManifestTargetDeviceFamily;
const GUID IID_IAppxPackageEditor                              = GUIDOF!IAppxPackageEditor;
const GUID IID_IAppxPackageReader                              = GUIDOF!IAppxPackageReader;
const GUID IID_IAppxPackageWriter                              = GUIDOF!IAppxPackageWriter;
const GUID IID_IAppxPackageWriter2                             = GUIDOF!IAppxPackageWriter2;
const GUID IID_IAppxPackageWriter3                             = GUIDOF!IAppxPackageWriter3;
const GUID IID_IAppxPackagingDiagnosticEventSink               = GUIDOF!IAppxPackagingDiagnosticEventSink;
const GUID IID_IAppxPackagingDiagnosticEventSinkManager        = GUIDOF!IAppxPackagingDiagnosticEventSinkManager;
const GUID IID_IAppxSourceContentGroupMapReader                = GUIDOF!IAppxSourceContentGroupMapReader;
