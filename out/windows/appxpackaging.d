module windows.appxpackaging;

public import windows.com;
public import windows.structuredstorage;
public import windows.systemservices;

extern(Windows):

const GUID CLSID_AppxFactory = {0x5842A140, 0xFF9F, 0x4166, [0x8F, 0x5C, 0x62, 0xF5, 0xB7, 0xB0, 0xC7, 0x81]};
@GUID(0x5842A140, 0xFF9F, 0x4166, [0x8F, 0x5C, 0x62, 0xF5, 0xB7, 0xB0, 0xC7, 0x81]);
struct AppxFactory;

const GUID CLSID_AppxBundleFactory = {0x378E0446, 0x5384, 0x43B7, [0x88, 0x77, 0xE7, 0xDB, 0xDD, 0x88, 0x34, 0x46]};
@GUID(0x378E0446, 0x5384, 0x43B7, [0x88, 0x77, 0xE7, 0xDB, 0xDD, 0x88, 0x34, 0x46]);
struct AppxBundleFactory;

const GUID CLSID_AppxPackagingDiagnosticEventSinkManager = {0x50CA0A46, 0x1588, 0x4161, [0x8E, 0xD2, 0xEF, 0x9E, 0x46, 0x9C, 0xED, 0x5D]};
@GUID(0x50CA0A46, 0x1588, 0x4161, [0x8E, 0xD2, 0xEF, 0x9E, 0x46, 0x9C, 0xED, 0x5D]);
struct AppxPackagingDiagnosticEventSinkManager;

const GUID CLSID_AppxEncryptionFactory = {0xDC664FDD, 0xD868, 0x46EE, [0x87, 0x80, 0x8D, 0x19, 0x6C, 0xB7, 0x39, 0xF7]};
@GUID(0xDC664FDD, 0xD868, 0x46EE, [0x87, 0x80, 0x8D, 0x19, 0x6C, 0xB7, 0x39, 0xF7]);
struct AppxEncryptionFactory;

const GUID CLSID_AppxPackageEditor = {0xF004F2CA, 0xAEBC, 0x4B0D, [0xBF, 0x58, 0xE5, 0x16, 0xD5, 0xBC, 0xC0, 0xAB]};
@GUID(0xF004F2CA, 0xAEBC, 0x4B0D, [0xBF, 0x58, 0xE5, 0x16, 0xD5, 0xBC, 0xC0, 0xAB]);
struct AppxPackageEditor;

struct APPX_PACKAGE_SETTINGS
{
    BOOL forceZip32;
    IUri hashMethod;
}

enum APPX_COMPRESSION_OPTION
{
    APPX_COMPRESSION_OPTION_NONE = 0,
    APPX_COMPRESSION_OPTION_NORMAL = 1,
    APPX_COMPRESSION_OPTION_MAXIMUM = 2,
    APPX_COMPRESSION_OPTION_FAST = 3,
    APPX_COMPRESSION_OPTION_SUPERFAST = 4,
}

struct APPX_PACKAGE_WRITER_PAYLOAD_STREAM
{
    IStream inputStream;
    const(wchar)* fileName;
    const(wchar)* contentType;
    APPX_COMPRESSION_OPTION compressionOption;
}

enum APPX_FOOTPRINT_FILE_TYPE
{
    APPX_FOOTPRINT_FILE_TYPE_MANIFEST = 0,
    APPX_FOOTPRINT_FILE_TYPE_BLOCKMAP = 1,
    APPX_FOOTPRINT_FILE_TYPE_SIGNATURE = 2,
    APPX_FOOTPRINT_FILE_TYPE_CODEINTEGRITY = 3,
    APPX_FOOTPRINT_FILE_TYPE_CONTENTGROUPMAP = 4,
}

enum APPX_BUNDLE_FOOTPRINT_FILE_TYPE
{
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_FIRST = 0,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_MANIFEST = 0,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_BLOCKMAP = 1,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_SIGNATURE = 2,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_LAST = 2,
}

enum APPX_CAPABILITIES
{
    APPX_CAPABILITY_INTERNET_CLIENT = 1,
    APPX_CAPABILITY_INTERNET_CLIENT_SERVER = 2,
    APPX_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER = 4,
    APPX_CAPABILITY_DOCUMENTS_LIBRARY = 8,
    APPX_CAPABILITY_PICTURES_LIBRARY = 16,
    APPX_CAPABILITY_VIDEOS_LIBRARY = 32,
    APPX_CAPABILITY_MUSIC_LIBRARY = 64,
    APPX_CAPABILITY_ENTERPRISE_AUTHENTICATION = 128,
    APPX_CAPABILITY_SHARED_USER_CERTIFICATES = 256,
    APPX_CAPABILITY_REMOVABLE_STORAGE = 512,
    APPX_CAPABILITY_APPOINTMENTS = 1024,
    APPX_CAPABILITY_CONTACTS = 2048,
}

enum APPX_PACKAGE_ARCHITECTURE
{
    APPX_PACKAGE_ARCHITECTURE_X86 = 0,
    APPX_PACKAGE_ARCHITECTURE_ARM = 5,
    APPX_PACKAGE_ARCHITECTURE_X64 = 9,
    APPX_PACKAGE_ARCHITECTURE_NEUTRAL = 11,
    APPX_PACKAGE_ARCHITECTURE_ARM64 = 12,
}

enum APPX_PACKAGE_ARCHITECTURE2
{
    APPX_PACKAGE_ARCHITECTURE2_X86 = 0,
    APPX_PACKAGE_ARCHITECTURE2_ARM = 5,
    APPX_PACKAGE_ARCHITECTURE2_X64 = 9,
    APPX_PACKAGE_ARCHITECTURE2_NEUTRAL = 11,
    APPX_PACKAGE_ARCHITECTURE2_ARM64 = 12,
    APPX_PACKAGE_ARCHITECTURE2_X86_ON_ARM64 = 14,
    APPX_PACKAGE_ARCHITECTURE2_UNKNOWN = 65535,
}

enum APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE
{
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_APPLICATION = 0,
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_RESOURCE = 1,
}

enum DX_FEATURE_LEVEL
{
    DX_FEATURE_LEVEL_UNSPECIFIED = 0,
    DX_FEATURE_LEVEL_9 = 1,
    DX_FEATURE_LEVEL_10 = 2,
    DX_FEATURE_LEVEL_11 = 3,
}

enum APPX_CAPABILITY_CLASS_TYPE
{
    APPX_CAPABILITY_CLASS_DEFAULT = 0,
    APPX_CAPABILITY_CLASS_GENERAL = 1,
    APPX_CAPABILITY_CLASS_RESTRICTED = 2,
    APPX_CAPABILITY_CLASS_WINDOWS = 4,
    APPX_CAPABILITY_CLASS_ALL = 7,
    APPX_CAPABILITY_CLASS_CUSTOM = 8,
}

enum APPX_PACKAGING_CONTEXT_CHANGE_TYPE
{
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_START = 0,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_CHANGE = 1,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_DETAILS = 2,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_END = 3,
}

const GUID IID_IAppxFactory = {0xBEB94909, 0xE451, 0x438B, [0xB5, 0xA7, 0xD7, 0x9E, 0x76, 0x7B, 0x75, 0xD8]};
@GUID(0xBEB94909, 0xE451, 0x438B, [0xB5, 0xA7, 0xD7, 0x9E, 0x76, 0x7B, 0x75, 0xD8]);
interface IAppxFactory : IUnknown
{
    HRESULT CreatePackageWriter(IStream outputStream, APPX_PACKAGE_SETTINGS* settings, IAppxPackageWriter* packageWriter);
    HRESULT CreatePackageReader(IStream inputStream, IAppxPackageReader* packageReader);
    HRESULT CreateManifestReader(IStream inputStream, IAppxManifestReader* manifestReader);
    HRESULT CreateBlockMapReader(IStream inputStream, IAppxBlockMapReader* blockMapReader);
    HRESULT CreateValidatedBlockMapReader(IStream blockMapStream, const(wchar)* signatureFileName, IAppxBlockMapReader* blockMapReader);
}

const GUID IID_IAppxFactory2 = {0xF1346DF2, 0xC282, 0x4E22, [0xB9, 0x18, 0x74, 0x3A, 0x92, 0x9A, 0x8D, 0x55]};
@GUID(0xF1346DF2, 0xC282, 0x4E22, [0xB9, 0x18, 0x74, 0x3A, 0x92, 0x9A, 0x8D, 0x55]);
interface IAppxFactory2 : IUnknown
{
    HRESULT CreateContentGroupMapReader(IStream inputStream, IAppxContentGroupMapReader* contentGroupMapReader);
    HRESULT CreateSourceContentGroupMapReader(IStream inputStream, IAppxSourceContentGroupMapReader* reader);
    HRESULT CreateContentGroupMapWriter(IStream stream, IAppxContentGroupMapWriter* contentGroupMapWriter);
}

const GUID IID_IAppxPackageReader = {0xB5C49650, 0x99BC, 0x481C, [0x9A, 0x34, 0x3D, 0x53, 0xA4, 0x10, 0x67, 0x08]};
@GUID(0xB5C49650, 0x99BC, 0x481C, [0x9A, 0x34, 0x3D, 0x53, 0xA4, 0x10, 0x67, 0x08]);
interface IAppxPackageReader : IUnknown
{
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    HRESULT GetFootprintFile(APPX_FOOTPRINT_FILE_TYPE type, IAppxFile* file);
    HRESULT GetPayloadFile(const(wchar)* fileName, IAppxFile* file);
    HRESULT GetPayloadFiles(IAppxFilesEnumerator* filesEnumerator);
    HRESULT GetManifest(IAppxManifestReader* manifestReader);
}

const GUID IID_IAppxPackageWriter = {0x9099E33B, 0x246F, 0x41E4, [0x88, 0x1A, 0x00, 0x8E, 0xB6, 0x13, 0xF8, 0x58]};
@GUID(0x9099E33B, 0x246F, 0x41E4, [0x88, 0x1A, 0x00, 0x8E, 0xB6, 0x13, 0xF8, 0x58]);
interface IAppxPackageWriter : IUnknown
{
    HRESULT AddPayloadFile(const(wchar)* fileName, const(wchar)* contentType, APPX_COMPRESSION_OPTION compressionOption, IStream inputStream);
    HRESULT Close(IStream manifest);
}

const GUID IID_IAppxPackageWriter2 = {0x2CF5C4FD, 0xE54C, 0x4EA5, [0xBA, 0x4E, 0xF8, 0xC4, 0xB1, 0x05, 0xA8, 0xC8]};
@GUID(0x2CF5C4FD, 0xE54C, 0x4EA5, [0xBA, 0x4E, 0xF8, 0xC4, 0xB1, 0x05, 0xA8, 0xC8]);
interface IAppxPackageWriter2 : IUnknown
{
    HRESULT Close(IStream manifest, IStream contentGroupMap);
}

const GUID IID_IAppxPackageWriter3 = {0xA83AACD3, 0x41C0, 0x4501, [0xB8, 0xA3, 0x74, 0x16, 0x4F, 0x50, 0xB2, 0xFD]};
@GUID(0xA83AACD3, 0x41C0, 0x4501, [0xB8, 0xA3, 0x74, 0x16, 0x4F, 0x50, 0xB2, 0xFD]);
interface IAppxPackageWriter3 : IUnknown
{
    HRESULT AddPayloadFiles(uint fileCount, char* payloadFiles, ulong memoryLimit);
}

const GUID IID_IAppxFile = {0x91DF827B, 0x94FD, 0x468F, [0x82, 0x7B, 0x57, 0xF4, 0x1B, 0x2F, 0x6F, 0x2E]};
@GUID(0x91DF827B, 0x94FD, 0x468F, [0x82, 0x7B, 0x57, 0xF4, 0x1B, 0x2F, 0x6F, 0x2E]);
interface IAppxFile : IUnknown
{
    HRESULT GetCompressionOption(APPX_COMPRESSION_OPTION* compressionOption);
    HRESULT GetContentType(ushort** contentType);
    HRESULT GetName(ushort** fileName);
    HRESULT GetSize(ulong* size);
    HRESULT GetStream(IStream* stream);
}

const GUID IID_IAppxFilesEnumerator = {0xF007EEAF, 0x9831, 0x411C, [0x98, 0x47, 0x91, 0x7C, 0xDC, 0x62, 0xD1, 0xFE]};
@GUID(0xF007EEAF, 0x9831, 0x411C, [0x98, 0x47, 0x91, 0x7C, 0xDC, 0x62, 0xD1, 0xFE]);
interface IAppxFilesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxFile* file);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxBlockMapReader = {0x5EFEC991, 0xBCA3, 0x42D1, [0x9E, 0xC2, 0xE9, 0x2D, 0x60, 0x9E, 0xC2, 0x2A]};
@GUID(0x5EFEC991, 0xBCA3, 0x42D1, [0x9E, 0xC2, 0xE9, 0x2D, 0x60, 0x9E, 0xC2, 0x2A]);
interface IAppxBlockMapReader : IUnknown
{
    HRESULT GetFile(const(wchar)* filename, IAppxBlockMapFile* file);
    HRESULT GetFiles(IAppxBlockMapFilesEnumerator* enumerator);
    HRESULT GetHashMethod(IUri* hashMethod);
    HRESULT GetStream(IStream* blockMapStream);
}

const GUID IID_IAppxBlockMapFile = {0x277672AC, 0x4F63, 0x42C1, [0x8A, 0xBC, 0xBE, 0xAE, 0x36, 0x00, 0xEB, 0x59]};
@GUID(0x277672AC, 0x4F63, 0x42C1, [0x8A, 0xBC, 0xBE, 0xAE, 0x36, 0x00, 0xEB, 0x59]);
interface IAppxBlockMapFile : IUnknown
{
    HRESULT GetBlocks(IAppxBlockMapBlocksEnumerator* blocks);
    HRESULT GetLocalFileHeaderSize(uint* lfhSize);
    HRESULT GetName(ushort** name);
    HRESULT GetUncompressedSize(ulong* size);
    HRESULT ValidateFileHash(IStream fileStream, int* isValid);
}

const GUID IID_IAppxBlockMapFilesEnumerator = {0x02B856A2, 0x4262, 0x4070, [0xBA, 0xCB, 0x1A, 0x8C, 0xBB, 0xC4, 0x23, 0x05]};
@GUID(0x02B856A2, 0x4262, 0x4070, [0xBA, 0xCB, 0x1A, 0x8C, 0xBB, 0xC4, 0x23, 0x05]);
interface IAppxBlockMapFilesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBlockMapFile* file);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasCurrent);
}

const GUID IID_IAppxBlockMapBlock = {0x75CF3930, 0x3244, 0x4FE0, [0xA8, 0xC8, 0xE0, 0xBC, 0xB2, 0x70, 0xB8, 0x89]};
@GUID(0x75CF3930, 0x3244, 0x4FE0, [0xA8, 0xC8, 0xE0, 0xBC, 0xB2, 0x70, 0xB8, 0x89]);
interface IAppxBlockMapBlock : IUnknown
{
    HRESULT GetHash(uint* bufferSize, char* buffer);
    HRESULT GetCompressedSize(uint* size);
}

const GUID IID_IAppxBlockMapBlocksEnumerator = {0x6B429B5B, 0x36EF, 0x479E, [0xB9, 0xEB, 0x0C, 0x14, 0x82, 0xB4, 0x9E, 0x16]};
@GUID(0x6B429B5B, 0x36EF, 0x479E, [0xB9, 0xEB, 0x0C, 0x14, 0x82, 0xB4, 0x9E, 0x16]);
interface IAppxBlockMapBlocksEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBlockMapBlock* block);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestReader = {0x4E1BD148, 0x55A0, 0x4480, [0xA3, 0xD1, 0x15, 0x54, 0x47, 0x10, 0x63, 0x7C]};
@GUID(0x4E1BD148, 0x55A0, 0x4480, [0xA3, 0xD1, 0x15, 0x54, 0x47, 0x10, 0x63, 0x7C]);
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

const GUID IID_IAppxManifestReader2 = {0xD06F67BC, 0xB31D, 0x4EBA, [0xA8, 0xAF, 0x63, 0x8E, 0x73, 0xE7, 0x7B, 0x4D]};
@GUID(0xD06F67BC, 0xB31D, 0x4EBA, [0xA8, 0xAF, 0x63, 0x8E, 0x73, 0xE7, 0x7B, 0x4D]);
interface IAppxManifestReader2 : IAppxManifestReader
{
    HRESULT GetQualifiedResources(IAppxManifestQualifiedResourcesEnumerator* resources);
}

const GUID IID_IAppxManifestReader3 = {0xC43825AB, 0x69B7, 0x400A, [0x97, 0x09, 0xCC, 0x37, 0xF5, 0xA7, 0x2D, 0x24]};
@GUID(0xC43825AB, 0x69B7, 0x400A, [0x97, 0x09, 0xCC, 0x37, 0xF5, 0xA7, 0x2D, 0x24]);
interface IAppxManifestReader3 : IAppxManifestReader2
{
    HRESULT GetCapabilitiesByCapabilityClass(APPX_CAPABILITY_CLASS_TYPE capabilityClass, IAppxManifestCapabilitiesEnumerator* capabilities);
    HRESULT GetTargetDeviceFamilies(IAppxManifestTargetDeviceFamiliesEnumerator* targetDeviceFamilies);
}

const GUID IID_IAppxManifestReader4 = {0x4579BB7C, 0x741D, 0x4161, [0xB5, 0xA1, 0x47, 0xBD, 0x3B, 0x78, 0xAD, 0x9B]};
@GUID(0x4579BB7C, 0x741D, 0x4161, [0xB5, 0xA1, 0x47, 0xBD, 0x3B, 0x78, 0xAD, 0x9B]);
interface IAppxManifestReader4 : IAppxManifestReader3
{
    HRESULT GetOptionalPackageInfo(IAppxManifestOptionalPackageInfo* optionalPackageInfo);
}

const GUID IID_IAppxManifestReader5 = {0x8D7AE132, 0xA690, 0x4C00, [0xB7, 0x5A, 0x6A, 0xAE, 0x1F, 0xEA, 0xAC, 0x80]};
@GUID(0x8D7AE132, 0xA690, 0x4C00, [0xB7, 0x5A, 0x6A, 0xAE, 0x1F, 0xEA, 0xAC, 0x80]);
interface IAppxManifestReader5 : IUnknown
{
    HRESULT GetMainPackageDependencies(IAppxManifestMainPackageDependenciesEnumerator* mainPackageDependencies);
}

const GUID IID_IAppxManifestReader6 = {0x34DEACA4, 0xD3C0, 0x4E3E, [0xB3, 0x12, 0xE4, 0x26, 0x25, 0xE3, 0x80, 0x7E]};
@GUID(0x34DEACA4, 0xD3C0, 0x4E3E, [0xB3, 0x12, 0xE4, 0x26, 0x25, 0xE3, 0x80, 0x7E]);
interface IAppxManifestReader6 : IUnknown
{
    HRESULT GetIsNonQualifiedResourcePackage(int* isNonQualifiedResourcePackage);
}

const GUID IID_IAppxManifestReader7 = {0x8EFE6F27, 0x0CE0, 0x4988, [0xB3, 0x2D, 0x73, 0x8E, 0xB6, 0x3D, 0xB3, 0xB7]};
@GUID(0x8EFE6F27, 0x0CE0, 0x4988, [0xB3, 0x2D, 0x73, 0x8E, 0xB6, 0x3D, 0xB3, 0xB7]);
interface IAppxManifestReader7 : IUnknown
{
    HRESULT GetDriverDependencies(IAppxManifestDriverDependenciesEnumerator* driverDependencies);
    HRESULT GetOSPackageDependencies(IAppxManifestOSPackageDependenciesEnumerator* osPackageDependencies);
    HRESULT GetHostRuntimeDependencies(IAppxManifestHostRuntimeDependenciesEnumerator* hostRuntimeDependencies);
}

const GUID IID_IAppxManifestDriverDependenciesEnumerator = {0xFE039DB2, 0x467F, 0x4755, [0x84, 0x04, 0x8F, 0x5E, 0xB6, 0x86, 0x5B, 0x33]};
@GUID(0xFE039DB2, 0x467F, 0x4755, [0x84, 0x04, 0x8F, 0x5E, 0xB6, 0x86, 0x5B, 0x33]);
interface IAppxManifestDriverDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestDriverDependency* driverDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestDriverDependency = {0x1210CB94, 0x5A92, 0x4602, [0xBE, 0x24, 0x79, 0xF3, 0x18, 0xAF, 0x4A, 0xF9]};
@GUID(0x1210CB94, 0x5A92, 0x4602, [0xBE, 0x24, 0x79, 0xF3, 0x18, 0xAF, 0x4A, 0xF9]);
interface IAppxManifestDriverDependency : IUnknown
{
    HRESULT GetDriverConstraints(IAppxManifestDriverConstraintsEnumerator* driverConstraints);
}

const GUID IID_IAppxManifestDriverConstraintsEnumerator = {0xD402B2D1, 0xF600, 0x49E0, [0x95, 0xE6, 0x97, 0x5D, 0x8D, 0xA1, 0x3D, 0x89]};
@GUID(0xD402B2D1, 0xF600, 0x49E0, [0x95, 0xE6, 0x97, 0x5D, 0x8D, 0xA1, 0x3D, 0x89]);
interface IAppxManifestDriverConstraintsEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestDriverConstraint* driverConstraint);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestDriverConstraint = {0xC031BEE4, 0xBBCC, 0x48EA, [0xA2, 0x37, 0xC3, 0x40, 0x45, 0xC8, 0x0A, 0x07]};
@GUID(0xC031BEE4, 0xBBCC, 0x48EA, [0xA2, 0x37, 0xC3, 0x40, 0x45, 0xC8, 0x0A, 0x07]);
interface IAppxManifestDriverConstraint : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetMinVersion(ulong* minVersion);
    HRESULT GetMinDate(ushort** minDate);
}

const GUID IID_IAppxManifestOSPackageDependenciesEnumerator = {0xB84E2FC3, 0xF8EC, 0x4BC1, [0x8A, 0xE2, 0x15, 0x63, 0x46, 0xF5, 0xFF, 0xEA]};
@GUID(0xB84E2FC3, 0xF8EC, 0x4BC1, [0x8A, 0xE2, 0x15, 0x63, 0x46, 0xF5, 0xFF, 0xEA]);
interface IAppxManifestOSPackageDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestOSPackageDependency* osPackageDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestOSPackageDependency = {0x154995EE, 0x54A6, 0x4F14, [0xAC, 0x97, 0xD8, 0xCF, 0x05, 0x19, 0x64, 0x4B]};
@GUID(0x154995EE, 0x54A6, 0x4F14, [0xAC, 0x97, 0xD8, 0xCF, 0x05, 0x19, 0x64, 0x4B]);
interface IAppxManifestOSPackageDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetVersion(ulong* version);
}

const GUID IID_IAppxManifestHostRuntimeDependenciesEnumerator = {0x6427A646, 0x7F49, 0x433E, [0xB1, 0xA6, 0x0D, 0xA3, 0x09, 0xF6, 0x88, 0x5A]};
@GUID(0x6427A646, 0x7F49, 0x433E, [0xB1, 0xA6, 0x0D, 0xA3, 0x09, 0xF6, 0x88, 0x5A]);
interface IAppxManifestHostRuntimeDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestHostRuntimeDependency* hostRuntimeDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestHostRuntimeDependency = {0x3455D234, 0x8414, 0x410D, [0x95, 0xC7, 0x7B, 0x35, 0x25, 0x5B, 0x83, 0x91]};
@GUID(0x3455D234, 0x8414, 0x410D, [0x95, 0xC7, 0x7B, 0x35, 0x25, 0x5B, 0x83, 0x91]);
interface IAppxManifestHostRuntimeDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetPublisher(ushort** publisher);
    HRESULT GetMinVersion(ulong* minVersion);
}

const GUID IID_IAppxManifestOptionalPackageInfo = {0x2634847D, 0x5B5D, 0x4FE5, [0xA2, 0x43, 0x00, 0x2F, 0xF9, 0x5E, 0xDC, 0x7E]};
@GUID(0x2634847D, 0x5B5D, 0x4FE5, [0xA2, 0x43, 0x00, 0x2F, 0xF9, 0x5E, 0xDC, 0x7E]);
interface IAppxManifestOptionalPackageInfo : IUnknown
{
    HRESULT GetIsOptionalPackage(int* isOptionalPackage);
    HRESULT GetMainPackageName(ushort** mainPackageName);
}

const GUID IID_IAppxManifestMainPackageDependenciesEnumerator = {0xA99C4F00, 0x51D2, 0x4F0F, [0xBA, 0x46, 0x7E, 0xD5, 0x25, 0x5E, 0xBD, 0xFF]};
@GUID(0xA99C4F00, 0x51D2, 0x4F0F, [0xBA, 0x46, 0x7E, 0xD5, 0x25, 0x5E, 0xBD, 0xFF]);
interface IAppxManifestMainPackageDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestMainPackageDependency* mainPackageDependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestMainPackageDependency = {0x05D0611C, 0xBC29, 0x46D5, [0x97, 0xE2, 0x84, 0xB9, 0xC7, 0x9B, 0xD8, 0xAE]};
@GUID(0x05D0611C, 0xBC29, 0x46D5, [0x97, 0xE2, 0x84, 0xB9, 0xC7, 0x9B, 0xD8, 0xAE]);
interface IAppxManifestMainPackageDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetPublisher(ushort** publisher);
    HRESULT GetPackageFamilyName(ushort** packageFamilyName);
}

const GUID IID_IAppxManifestPackageId = {0x283CE2D7, 0x7153, 0x4A91, [0x96, 0x49, 0x7A, 0x0F, 0x72, 0x40, 0x94, 0x5F]};
@GUID(0x283CE2D7, 0x7153, 0x4A91, [0x96, 0x49, 0x7A, 0x0F, 0x72, 0x40, 0x94, 0x5F]);
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

const GUID IID_IAppxManifestPackageId2 = {0x2256999D, 0xD617, 0x42F1, [0x88, 0x0E, 0x0B, 0xA4, 0x54, 0x23, 0x19, 0xD5]};
@GUID(0x2256999D, 0xD617, 0x42F1, [0x88, 0x0E, 0x0B, 0xA4, 0x54, 0x23, 0x19, 0xD5]);
interface IAppxManifestPackageId2 : IAppxManifestPackageId
{
    HRESULT GetArchitecture2(APPX_PACKAGE_ARCHITECTURE2* architecture);
}

const GUID IID_IAppxManifestProperties = {0x03FAF64D, 0xF26F, 0x4B2C, [0xAA, 0xF7, 0x8F, 0xE7, 0x78, 0x9B, 0x8B, 0xCA]};
@GUID(0x03FAF64D, 0xF26F, 0x4B2C, [0xAA, 0xF7, 0x8F, 0xE7, 0x78, 0x9B, 0x8B, 0xCA]);
interface IAppxManifestProperties : IUnknown
{
    HRESULT GetBoolValue(const(wchar)* name, int* value);
    HRESULT GetStringValue(const(wchar)* name, ushort** value);
}

const GUID IID_IAppxManifestTargetDeviceFamiliesEnumerator = {0x36537F36, 0x27A4, 0x4788, [0x88, 0xC0, 0x73, 0x38, 0x19, 0x57, 0x50, 0x17]};
@GUID(0x36537F36, 0x27A4, 0x4788, [0x88, 0xC0, 0x73, 0x38, 0x19, 0x57, 0x50, 0x17]);
interface IAppxManifestTargetDeviceFamiliesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestTargetDeviceFamily* targetDeviceFamily);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestTargetDeviceFamily = {0x9091B09B, 0xC8D5, 0x4F31, [0x86, 0x87, 0xA3, 0x38, 0x25, 0x9F, 0xAE, 0xFB]};
@GUID(0x9091B09B, 0xC8D5, 0x4F31, [0x86, 0x87, 0xA3, 0x38, 0x25, 0x9F, 0xAE, 0xFB]);
interface IAppxManifestTargetDeviceFamily : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetMinVersion(ulong* minVersion);
    HRESULT GetMaxVersionTested(ulong* maxVersionTested);
}

const GUID IID_IAppxManifestPackageDependenciesEnumerator = {0xB43BBCF9, 0x65A6, 0x42DD, [0xBA, 0xC0, 0x8C, 0x67, 0x41, 0xE7, 0xF5, 0xA4]};
@GUID(0xB43BBCF9, 0x65A6, 0x42DD, [0xBA, 0xC0, 0x8C, 0x67, 0x41, 0xE7, 0xF5, 0xA4]);
interface IAppxManifestPackageDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestPackageDependency* dependency);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestPackageDependency = {0xE4946B59, 0x733E, 0x43F0, [0xA7, 0x24, 0x3B, 0xDE, 0x4C, 0x12, 0x85, 0xA0]};
@GUID(0xE4946B59, 0x733E, 0x43F0, [0xA7, 0x24, 0x3B, 0xDE, 0x4C, 0x12, 0x85, 0xA0]);
interface IAppxManifestPackageDependency : IUnknown
{
    HRESULT GetName(ushort** name);
    HRESULT GetPublisher(ushort** publisher);
    HRESULT GetMinVersion(ulong* minVersion);
}

const GUID IID_IAppxManifestPackageDependency2 = {0xDDA0B713, 0xF3FF, 0x49D3, [0x89, 0x8A, 0x27, 0x86, 0x78, 0x0C, 0x5D, 0x98]};
@GUID(0xDDA0B713, 0xF3FF, 0x49D3, [0x89, 0x8A, 0x27, 0x86, 0x78, 0x0C, 0x5D, 0x98]);
interface IAppxManifestPackageDependency2 : IAppxManifestPackageDependency
{
    HRESULT GetMaxMajorVersionTested(ushort* maxMajorVersionTested);
}

const GUID IID_IAppxManifestPackageDependency3 = {0x1AC56374, 0x6198, 0x4D6B, [0x92, 0xE4, 0x74, 0x9D, 0x5A, 0xB8, 0xA8, 0x95]};
@GUID(0x1AC56374, 0x6198, 0x4D6B, [0x92, 0xE4, 0x74, 0x9D, 0x5A, 0xB8, 0xA8, 0x95]);
interface IAppxManifestPackageDependency3 : IUnknown
{
    HRESULT GetIsOptional(int* isOptional);
}

const GUID IID_IAppxManifestResourcesEnumerator = {0xDE4DFBBD, 0x881A, 0x48BB, [0x85, 0x8C, 0xD6, 0xF2, 0xBA, 0xEA, 0xE6, 0xED]};
@GUID(0xDE4DFBBD, 0x881A, 0x48BB, [0x85, 0x8C, 0xD6, 0xF2, 0xBA, 0xEA, 0xE6, 0xED]);
interface IAppxManifestResourcesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** resource);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestDeviceCapabilitiesEnumerator = {0x30204541, 0x427B, 0x4A1C, [0xBA, 0xCF, 0x65, 0x5B, 0xF4, 0x63, 0xA5, 0x40]};
@GUID(0x30204541, 0x427B, 0x4A1C, [0xBA, 0xCF, 0x65, 0x5B, 0xF4, 0x63, 0xA5, 0x40]);
interface IAppxManifestDeviceCapabilitiesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** deviceCapability);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestCapabilitiesEnumerator = {0x11D22258, 0xF470, 0x42C1, [0xB2, 0x91, 0x83, 0x61, 0xC5, 0x43, 0x7E, 0x41]};
@GUID(0x11D22258, 0xF470, 0x42C1, [0xB2, 0x91, 0x83, 0x61, 0xC5, 0x43, 0x7E, 0x41]);
interface IAppxManifestCapabilitiesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** capability);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestApplicationsEnumerator = {0x9EB8A55A, 0xF04B, 0x4D0D, [0x80, 0x8D, 0x68, 0x61, 0x85, 0xD4, 0x84, 0x7A]};
@GUID(0x9EB8A55A, 0xF04B, 0x4D0D, [0x80, 0x8D, 0x68, 0x61, 0x85, 0xD4, 0x84, 0x7A]);
interface IAppxManifestApplicationsEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestApplication* application);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestApplication = {0x5DA89BF4, 0x3773, 0x46BE, [0xB6, 0x50, 0x7E, 0x74, 0x48, 0x63, 0xB7, 0xE8]};
@GUID(0x5DA89BF4, 0x3773, 0x46BE, [0xB6, 0x50, 0x7E, 0x74, 0x48, 0x63, 0xB7, 0xE8]);
interface IAppxManifestApplication : IUnknown
{
    HRESULT GetStringValue(const(wchar)* name, ushort** value);
    HRESULT GetAppUserModelId(ushort** appUserModelId);
}

const GUID IID_IAppxManifestQualifiedResourcesEnumerator = {0x8EF6ADFE, 0x3762, 0x4A8F, [0x93, 0x73, 0x2F, 0xC5, 0xD4, 0x44, 0xC8, 0xD2]};
@GUID(0x8EF6ADFE, 0x3762, 0x4A8F, [0x93, 0x73, 0x2F, 0xC5, 0xD4, 0x44, 0xC8, 0xD2]);
interface IAppxManifestQualifiedResourcesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestQualifiedResource* resource);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxManifestQualifiedResource = {0x3B53A497, 0x3C5C, 0x48D1, [0x9E, 0xA3, 0xBB, 0x7E, 0xAC, 0x8C, 0xD7, 0xD4]};
@GUID(0x3B53A497, 0x3C5C, 0x48D1, [0x9E, 0xA3, 0xBB, 0x7E, 0xAC, 0x8C, 0xD7, 0xD4]);
interface IAppxManifestQualifiedResource : IUnknown
{
    HRESULT GetLanguage(ushort** language);
    HRESULT GetScale(uint* scale);
    HRESULT GetDXFeatureLevel(DX_FEATURE_LEVEL* dxFeatureLevel);
}

const GUID IID_IAppxBundleFactory = {0xBBA65864, 0x965F, 0x4A5F, [0x85, 0x5F, 0xF0, 0x74, 0xBD, 0xBF, 0x3A, 0x7B]};
@GUID(0xBBA65864, 0x965F, 0x4A5F, [0x85, 0x5F, 0xF0, 0x74, 0xBD, 0xBF, 0x3A, 0x7B]);
interface IAppxBundleFactory : IUnknown
{
    HRESULT CreateBundleWriter(IStream outputStream, ulong bundleVersion, IAppxBundleWriter* bundleWriter);
    HRESULT CreateBundleReader(IStream inputStream, IAppxBundleReader* bundleReader);
    HRESULT CreateBundleManifestReader(IStream inputStream, IAppxBundleManifestReader* manifestReader);
}

const GUID IID_IAppxBundleWriter = {0xEC446FE8, 0xBFEC, 0x4C64, [0xAB, 0x4F, 0x49, 0xF0, 0x38, 0xF0, 0xC6, 0xD2]};
@GUID(0xEC446FE8, 0xBFEC, 0x4C64, [0xAB, 0x4F, 0x49, 0xF0, 0x38, 0xF0, 0xC6, 0xD2]);
interface IAppxBundleWriter : IUnknown
{
    HRESULT AddPayloadPackage(const(wchar)* fileName, IStream packageStream);
    HRESULT Close();
}

const GUID IID_IAppxBundleWriter2 = {0x6D8FE971, 0x01CC, 0x49A0, [0xB6, 0x85, 0x23, 0x38, 0x51, 0x27, 0x99, 0x62]};
@GUID(0x6D8FE971, 0x01CC, 0x49A0, [0xB6, 0x85, 0x23, 0x38, 0x51, 0x27, 0x99, 0x62]);
interface IAppxBundleWriter2 : IUnknown
{
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream);
}

const GUID IID_IAppxBundleWriter3 = {0xAD711152, 0xF969, 0x4193, [0x82, 0xD5, 0x9D, 0xDF, 0x27, 0x86, 0xD2, 0x1A]};
@GUID(0xAD711152, 0xF969, 0x4193, [0x82, 0xD5, 0x9D, 0xDF, 0x27, 0x86, 0xD2, 0x1A]);
interface IAppxBundleWriter3 : IUnknown
{
    HRESULT AddPackageReference(const(wchar)* fileName, IStream inputStream);
    HRESULT Close(const(wchar)* hashMethodString);
}

const GUID IID_IAppxBundleWriter4 = {0x9CD9D523, 0x5009, 0x4C01, [0x98, 0x82, 0xDC, 0x02, 0x9F, 0xBD, 0x47, 0xA3]};
@GUID(0x9CD9D523, 0x5009, 0x4C01, [0x98, 0x82, 0xDC, 0x02, 0x9F, 0xBD, 0x47, 0xA3]);
interface IAppxBundleWriter4 : IUnknown
{
    HRESULT AddPayloadPackage(const(wchar)* fileName, IStream packageStream, BOOL isDefaultApplicablePackage);
    HRESULT AddPackageReference(const(wchar)* fileName, IStream inputStream, BOOL isDefaultApplicablePackage);
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream, BOOL isDefaultApplicablePackage);
}

const GUID IID_IAppxBundleReader = {0xDD75B8C0, 0xBA76, 0x43B0, [0xAE, 0x0F, 0x68, 0x65, 0x6A, 0x1D, 0xC5, 0xC8]};
@GUID(0xDD75B8C0, 0xBA76, 0x43B0, [0xAE, 0x0F, 0x68, 0x65, 0x6A, 0x1D, 0xC5, 0xC8]);
interface IAppxBundleReader : IUnknown
{
    HRESULT GetFootprintFile(APPX_BUNDLE_FOOTPRINT_FILE_TYPE fileType, IAppxFile* footprintFile);
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    HRESULT GetManifest(IAppxBundleManifestReader* manifestReader);
    HRESULT GetPayloadPackages(IAppxFilesEnumerator* payloadPackages);
    HRESULT GetPayloadPackage(const(wchar)* fileName, IAppxFile* payloadPackage);
}

const GUID IID_IAppxBundleManifestReader = {0xCF0EBBC1, 0xCC99, 0x4106, [0x91, 0xEB, 0xE6, 0x74, 0x62, 0xE0, 0x4F, 0xB0]};
@GUID(0xCF0EBBC1, 0xCC99, 0x4106, [0x91, 0xEB, 0xE6, 0x74, 0x62, 0xE0, 0x4F, 0xB0]);
interface IAppxBundleManifestReader : IUnknown
{
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
    HRESULT GetStream(IStream* manifestStream);
}

const GUID IID_IAppxBundleManifestReader2 = {0x5517DF70, 0x033F, 0x4AF2, [0x82, 0x13, 0x87, 0xD7, 0x66, 0x80, 0x5C, 0x02]};
@GUID(0x5517DF70, 0x033F, 0x4AF2, [0x82, 0x13, 0x87, 0xD7, 0x66, 0x80, 0x5C, 0x02]);
interface IAppxBundleManifestReader2 : IUnknown
{
    HRESULT GetOptionalBundles(IAppxBundleManifestOptionalBundleInfoEnumerator* optionalBundles);
}

const GUID IID_IAppxBundleManifestPackageInfoEnumerator = {0xF9B856EE, 0x49A6, 0x4E19, [0xB2, 0xB0, 0x6A, 0x24, 0x06, 0xD6, 0x3A, 0x32]};
@GUID(0xF9B856EE, 0x49A6, 0x4E19, [0xB2, 0xB0, 0x6A, 0x24, 0x06, 0xD6, 0x3A, 0x32]);
interface IAppxBundleManifestPackageInfoEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBundleManifestPackageInfo* packageInfo);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxBundleManifestPackageInfo = {0x54CD06C1, 0x268F, 0x40BB, [0x8E, 0xD2, 0x75, 0x7A, 0x9E, 0xBA, 0xEC, 0x8D]};
@GUID(0x54CD06C1, 0x268F, 0x40BB, [0x8E, 0xD2, 0x75, 0x7A, 0x9E, 0xBA, 0xEC, 0x8D]);
interface IAppxBundleManifestPackageInfo : IUnknown
{
    HRESULT GetPackageType(APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE* packageType);
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    HRESULT GetFileName(ushort** fileName);
    HRESULT GetOffset(ulong* offset);
    HRESULT GetSize(ulong* size);
    HRESULT GetResources(IAppxManifestQualifiedResourcesEnumerator* resources);
}

const GUID IID_IAppxBundleManifestPackageInfo2 = {0x44C2ACBC, 0xB2CF, 0x4CCB, [0xBB, 0xDB, 0x9C, 0x6D, 0xA8, 0xC3, 0xBC, 0x9E]};
@GUID(0x44C2ACBC, 0xB2CF, 0x4CCB, [0xBB, 0xDB, 0x9C, 0x6D, 0xA8, 0xC3, 0xBC, 0x9E]);
interface IAppxBundleManifestPackageInfo2 : IUnknown
{
    HRESULT GetIsPackageReference(int* isPackageReference);
    HRESULT GetIsNonQualifiedResourcePackage(int* isNonQualifiedResourcePackage);
    HRESULT GetIsDefaultApplicablePackage(int* isDefaultApplicablePackage);
}

const GUID IID_IAppxBundleManifestPackageInfo3 = {0x6BA74B98, 0xBB74, 0x4296, [0x80, 0xD0, 0x5F, 0x42, 0x56, 0xA9, 0x96, 0x75]};
@GUID(0x6BA74B98, 0xBB74, 0x4296, [0x80, 0xD0, 0x5F, 0x42, 0x56, 0xA9, 0x96, 0x75]);
interface IAppxBundleManifestPackageInfo3 : IUnknown
{
    HRESULT GetTargetDeviceFamilies(IAppxManifestTargetDeviceFamiliesEnumerator* targetDeviceFamilies);
}

const GUID IID_IAppxBundleManifestPackageInfo4 = {0x5DA6F13D, 0xA8A7, 0x4532, [0x85, 0x7C, 0x13, 0x93, 0xD6, 0x59, 0x37, 0x1D]};
@GUID(0x5DA6F13D, 0xA8A7, 0x4532, [0x85, 0x7C, 0x13, 0x93, 0xD6, 0x59, 0x37, 0x1D]);
interface IAppxBundleManifestPackageInfo4 : IUnknown
{
    HRESULT GetIsStub(int* isStub);
}

const GUID IID_IAppxBundleManifestOptionalBundleInfoEnumerator = {0x9A178793, 0xF97E, 0x46AC, [0xAA, 0xCA, 0xDD, 0x5B, 0xA4, 0xC1, 0x77, 0xC8]};
@GUID(0x9A178793, 0xF97E, 0x46AC, [0xAA, 0xCA, 0xDD, 0x5B, 0xA4, 0xC1, 0x77, 0xC8]);
interface IAppxBundleManifestOptionalBundleInfoEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxBundleManifestOptionalBundleInfo* optionalBundle);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxBundleManifestOptionalBundleInfo = {0x515BF2E8, 0xBCB0, 0x4D69, [0x8C, 0x48, 0xE3, 0x83, 0x14, 0x7B, 0x6E, 0x12]};
@GUID(0x515BF2E8, 0xBCB0, 0x4D69, [0x8C, 0x48, 0xE3, 0x83, 0x14, 0x7B, 0x6E, 0x12]);
interface IAppxBundleManifestOptionalBundleInfo : IUnknown
{
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    HRESULT GetFileName(ushort** fileName);
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
}

const GUID IID_IAppxContentGroupFilesEnumerator = {0x1A09A2FD, 0x7440, 0x44EB, [0x8C, 0x84, 0x84, 0x82, 0x05, 0xA6, 0xA1, 0xCC]};
@GUID(0x1A09A2FD, 0x7440, 0x44EB, [0x8C, 0x84, 0x84, 0x82, 0x05, 0xA6, 0xA1, 0xCC]);
interface IAppxContentGroupFilesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** file);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxContentGroup = {0x328F6468, 0xC04F, 0x4E3C, [0xB6, 0xFA, 0x6B, 0x8D, 0x27, 0xF3, 0x00, 0x3A]};
@GUID(0x328F6468, 0xC04F, 0x4E3C, [0xB6, 0xFA, 0x6B, 0x8D, 0x27, 0xF3, 0x00, 0x3A]);
interface IAppxContentGroup : IUnknown
{
    HRESULT GetName(ushort** groupName);
    HRESULT GetFiles(IAppxContentGroupFilesEnumerator* enumerator);
}

const GUID IID_IAppxContentGroupsEnumerator = {0x3264E477, 0x16D1, 0x4D63, [0x82, 0x3E, 0x7D, 0x29, 0x84, 0x69, 0x66, 0x34]};
@GUID(0x3264E477, 0x16D1, 0x4D63, [0x82, 0x3E, 0x7D, 0x29, 0x84, 0x69, 0x66, 0x34]);
interface IAppxContentGroupsEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxContentGroup* stream);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

const GUID IID_IAppxContentGroupMapReader = {0x418726D8, 0xDD99, 0x4F5D, [0x98, 0x86, 0x15, 0x7A, 0xDD, 0x20, 0xDE, 0x01]};
@GUID(0x418726D8, 0xDD99, 0x4F5D, [0x98, 0x86, 0x15, 0x7A, 0xDD, 0x20, 0xDE, 0x01]);
interface IAppxContentGroupMapReader : IUnknown
{
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

const GUID IID_IAppxSourceContentGroupMapReader = {0xF329791D, 0x540B, 0x4A9F, [0xBC, 0x75, 0x32, 0x82, 0xB7, 0xD7, 0x31, 0x93]};
@GUID(0xF329791D, 0x540B, 0x4A9F, [0xBC, 0x75, 0x32, 0x82, 0xB7, 0xD7, 0x31, 0x93]);
interface IAppxSourceContentGroupMapReader : IUnknown
{
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

const GUID IID_IAppxContentGroupMapWriter = {0xD07AB776, 0xA9DE, 0x4798, [0x8C, 0x14, 0x3D, 0xB3, 0x1E, 0x68, 0x7C, 0x78]};
@GUID(0xD07AB776, 0xA9DE, 0x4798, [0x8C, 0x14, 0x3D, 0xB3, 0x1E, 0x68, 0x7C, 0x78]);
interface IAppxContentGroupMapWriter : IUnknown
{
    HRESULT AddAutomaticGroup(const(wchar)* groupName);
    HRESULT AddAutomaticFile(const(wchar)* fileName);
    HRESULT Close();
}

const GUID IID_IAppxPackagingDiagnosticEventSink = {0x17239D47, 0x6ADB, 0x45D2, [0x80, 0xF6, 0xF9, 0xCB, 0xC3, 0xBF, 0x05, 0x9D]};
@GUID(0x17239D47, 0x6ADB, 0x45D2, [0x80, 0xF6, 0xF9, 0xCB, 0xC3, 0xBF, 0x05, 0x9D]);
interface IAppxPackagingDiagnosticEventSink : IUnknown
{
    HRESULT ReportContextChange(APPX_PACKAGING_CONTEXT_CHANGE_TYPE changeType, int contextId, const(char)* contextName, const(wchar)* contextMessage, const(wchar)* detailsMessage);
    HRESULT ReportError(const(wchar)* errorMessage);
}

const GUID IID_IAppxPackagingDiagnosticEventSinkManager = {0x369648FA, 0xA7EB, 0x4909, [0xA1, 0x5D, 0x69, 0x54, 0xA0, 0x78, 0xF1, 0x8A]};
@GUID(0x369648FA, 0xA7EB, 0x4909, [0xA1, 0x5D, 0x69, 0x54, 0xA0, 0x78, 0xF1, 0x8A]);
interface IAppxPackagingDiagnosticEventSinkManager : IUnknown
{
    HRESULT SetSinkForProcess(IAppxPackagingDiagnosticEventSink sink);
}

struct APPX_ENCRYPTED_PACKAGE_SETTINGS
{
    uint keyLength;
    const(wchar)* encryptionAlgorithm;
    BOOL useDiffusion;
    IUri blockMapHashAlgorithm;
}

enum APPX_ENCRYPTED_PACKAGE_OPTIONS
{
    APPX_ENCRYPTED_PACKAGE_OPTION_NONE = 0,
    APPX_ENCRYPTED_PACKAGE_OPTION_DIFFUSION = 1,
    APPX_ENCRYPTED_PACKAGE_OPTION_PAGE_HASHING = 2,
}

struct APPX_ENCRYPTED_PACKAGE_SETTINGS2
{
    uint keyLength;
    const(wchar)* encryptionAlgorithm;
    IUri blockMapHashAlgorithm;
    uint options;
}

struct APPX_KEY_INFO
{
    uint keyLength;
    uint keyIdLength;
    ubyte* key;
    ubyte* keyId;
}

struct APPX_ENCRYPTED_EXEMPTIONS
{
    uint count;
    ushort** plainTextFiles;
}

const GUID IID_IAppxEncryptionFactory = {0x80E8E04D, 0x8C88, 0x44AE, [0xA0, 0x11, 0x7C, 0xAD, 0xF6, 0xFB, 0x2E, 0x72]};
@GUID(0x80E8E04D, 0x8C88, 0x44AE, [0xA0, 0x11, 0x7C, 0xAD, 0xF6, 0xFB, 0x2E, 0x72]);
interface IAppxEncryptionFactory : IUnknown
{
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT DecryptPackage(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, IAppxEncryptedPackageWriter* packageWriter);
    HRESULT CreateEncryptedPackageReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, IAppxPackageReader* packageReader);
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT DecryptBundle(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, IAppxEncryptedBundleWriter* bundleWriter);
    HRESULT CreateEncryptedBundleReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, IAppxBundleReader* bundleReader);
}

const GUID IID_IAppxEncryptionFactory2 = {0xC1B11EEE, 0xC4BA, 0x4AB2, [0xA5, 0x5D, 0xD0, 0x15, 0xFE, 0x8F, 0xF6, 0x4F]};
@GUID(0xC1B11EEE, 0xC4BA, 0x4AB2, [0xA5, 0x5D, 0xD0, 0x15, 0xFE, 0x8F, 0xF6, 0x4F]);
interface IAppxEncryptionFactory2 : IUnknown
{
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, IStream contentGroupMapStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, IAppxEncryptedPackageWriter* packageWriter);
}

const GUID IID_IAppxEncryptionFactory3 = {0x09EDCA37, 0xCD64, 0x47D6, [0xB7, 0xE8, 0x1C, 0xB1, 0x1D, 0x4F, 0x7E, 0x05]};
@GUID(0x09EDCA37, 0xCD64, 0x47D6, [0xB7, 0xE8, 0x1C, 0xB1, 0x1D, 0x4F, 0x7E, 0x05]);
interface IAppxEncryptionFactory3 : IUnknown
{
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, IStream contentGroupMapStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, IAppxEncryptedPackageWriter* packageWriter);
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, IAppxEncryptedBundleWriter* bundleWriter);
}

const GUID IID_IAppxEncryptionFactory4 = {0xA879611F, 0x12FD, 0x41FE, [0x85, 0xD5, 0x06, 0xAE, 0x77, 0x9B, 0xBA, 0xF5]};
@GUID(0xA879611F, 0x12FD, 0x41FE, [0x85, 0xD5, 0x06, 0xAE, 0x77, 0x9B, 0xBA, 0xF5]);
interface IAppxEncryptionFactory4 : IUnknown
{
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, ulong memoryLimit);
}

const GUID IID_IAppxEncryptedPackageWriter = {0xF43D0B0B, 0x1379, 0x40E2, [0x9B, 0x29, 0x68, 0x2E, 0xA2, 0xBF, 0x42, 0xAF]};
@GUID(0xF43D0B0B, 0x1379, 0x40E2, [0x9B, 0x29, 0x68, 0x2E, 0xA2, 0xBF, 0x42, 0xAF]);
interface IAppxEncryptedPackageWriter : IUnknown
{
    HRESULT AddPayloadFileEncrypted(const(wchar)* fileName, APPX_COMPRESSION_OPTION compressionOption, IStream inputStream);
    HRESULT Close();
}

const GUID IID_IAppxEncryptedPackageWriter2 = {0x3E475447, 0x3A25, 0x40B5, [0x8A, 0xD2, 0xF9, 0x53, 0xAE, 0x50, 0xC9, 0x2D]};
@GUID(0x3E475447, 0x3A25, 0x40B5, [0x8A, 0xD2, 0xF9, 0x53, 0xAE, 0x50, 0xC9, 0x2D]);
interface IAppxEncryptedPackageWriter2 : IUnknown
{
    HRESULT AddPayloadFilesEncrypted(uint fileCount, char* payloadFiles, ulong memoryLimit);
}

const GUID IID_IAppxEncryptedBundleWriter = {0x80B0902F, 0x7BF0, 0x4117, [0xB8, 0xC6, 0x42, 0x79, 0xEF, 0x81, 0xEE, 0x77]};
@GUID(0x80B0902F, 0x7BF0, 0x4117, [0xB8, 0xC6, 0x42, 0x79, 0xEF, 0x81, 0xEE, 0x77]);
interface IAppxEncryptedBundleWriter : IUnknown
{
    HRESULT AddPayloadPackageEncrypted(const(wchar)* fileName, IStream packageStream);
    HRESULT Close();
}

const GUID IID_IAppxEncryptedBundleWriter2 = {0xE644BE82, 0xF0FA, 0x42B8, [0xA9, 0x56, 0x8D, 0x1C, 0xB4, 0x8E, 0xE3, 0x79]};
@GUID(0xE644BE82, 0xF0FA, 0x42B8, [0xA9, 0x56, 0x8D, 0x1C, 0xB4, 0x8E, 0xE3, 0x79]);
interface IAppxEncryptedBundleWriter2 : IUnknown
{
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream);
}

enum APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION
{
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION_APPEND_DELTA = 0,
}

enum APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS
{
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_NONE = 0,
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_SKIP_VALIDATION = 1,
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_LOCALIZED = 2,
}

const GUID IID_IAppxEncryptedBundleWriter3 = {0x0D34DEB3, 0x5CAE, 0x4DD3, [0x97, 0x7C, 0x50, 0x49, 0x32, 0xA5, 0x1D, 0x31]};
@GUID(0x0D34DEB3, 0x5CAE, 0x4DD3, [0x97, 0x7C, 0x50, 0x49, 0x32, 0xA5, 0x1D, 0x31]);
interface IAppxEncryptedBundleWriter3 : IUnknown
{
    HRESULT AddPayloadPackageEncrypted(const(wchar)* fileName, IStream packageStream, BOOL isDefaultApplicablePackage);
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream, BOOL isDefaultApplicablePackage);
}

const GUID IID_IAppxPackageEditor = {0xE2ADB6DC, 0x5E71, 0x4416, [0x86, 0xB6, 0x86, 0xE5, 0xF5, 0x29, 0x1A, 0x6B]};
@GUID(0xE2ADB6DC, 0x5E71, 0x4416, [0x86, 0xB6, 0x86, 0xE5, 0xF5, 0x29, 0x1A, 0x6B]);
interface IAppxPackageEditor : IUnknown
{
    HRESULT SetWorkingDirectory(const(wchar)* workingDirectory);
    HRESULT CreateDeltaPackage(IStream updatedPackageStream, IStream baselinePackageStream, IStream deltaPackageStream);
    HRESULT CreateDeltaPackageUsingBaselineBlockMap(IStream updatedPackageStream, IStream baselineBlockMapStream, const(wchar)* baselinePackageFullName, IStream deltaPackageStream);
    HRESULT UpdatePackage(IStream baselinePackageStream, IStream deltaPackageStream, APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption);
    HRESULT UpdateEncryptedPackage(IStream baselineEncryptedPackageStream, IStream deltaPackageStream, APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption, const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo);
    HRESULT UpdatePackageManifest(IStream packageStream, IStream updatedManifestStream, BOOL isPackageEncrypted, APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS options);
}

struct PACKAGE_VERSION
{
    _Anonymous_e__Union Anonymous;
}

struct PACKAGE_ID
{
    uint reserved;
    uint processorArchitecture;
    PACKAGE_VERSION version;
    const(wchar)* name;
    const(wchar)* publisher;
    const(wchar)* resourceId;
    const(wchar)* publisherId;
}

enum PackagePathType
{
    PackagePathType_Install = 0,
    PackagePathType_Mutable = 1,
    PackagePathType_Effective = 2,
    PackagePathType_MachineExternal = 3,
    PackagePathType_UserExternal = 4,
    PackagePathType_EffectiveExternal = 5,
}

enum PackageOrigin
{
    PackageOrigin_Unknown = 0,
    PackageOrigin_Unsigned = 1,
    PackageOrigin_Inbox = 2,
    PackageOrigin_Store = 3,
    PackageOrigin_DeveloperUnsigned = 4,
    PackageOrigin_DeveloperSigned = 5,
    PackageOrigin_LineOfBusiness = 6,
}

struct _PACKAGE_INFO_REFERENCE
{
    void* reserved;
}

struct PACKAGE_INFO
{
    uint reserved;
    uint flags;
    const(wchar)* path;
    const(wchar)* packageFullName;
    const(wchar)* packageFamilyName;
    PACKAGE_ID packageId;
}

enum AppPolicyLifecycleManagement
{
    AppPolicyLifecycleManagement_Unmanaged = 0,
    AppPolicyLifecycleManagement_Managed = 1,
}

enum AppPolicyWindowingModel
{
    AppPolicyWindowingModel_None = 0,
    AppPolicyWindowingModel_Universal = 1,
    AppPolicyWindowingModel_ClassicDesktop = 2,
    AppPolicyWindowingModel_ClassicPhone = 3,
}

enum AppPolicyMediaFoundationCodecLoading
{
    AppPolicyMediaFoundationCodecLoading_All = 0,
    AppPolicyMediaFoundationCodecLoading_InboxOnly = 1,
}

enum AppPolicyClrCompat
{
    AppPolicyClrCompat_Other = 0,
    AppPolicyClrCompat_ClassicDesktop = 1,
    AppPolicyClrCompat_Universal = 2,
    AppPolicyClrCompat_PackagedDesktop = 3,
}

enum AppPolicyThreadInitializationType
{
    AppPolicyThreadInitializationType_None = 0,
    AppPolicyThreadInitializationType_InitializeWinRT = 1,
}

enum AppPolicyShowDeveloperDiagnostic
{
    AppPolicyShowDeveloperDiagnostic_None = 0,
    AppPolicyShowDeveloperDiagnostic_ShowUI = 1,
}

enum AppPolicyProcessTerminationMethod
{
    AppPolicyProcessTerminationMethod_ExitProcess = 0,
    AppPolicyProcessTerminationMethod_TerminateProcess = 1,
}

enum AppPolicyCreateFileAccess
{
    AppPolicyCreateFileAccess_Full = 0,
    AppPolicyCreateFileAccess_Limited = 1,
}

@DllImport("KERNEL32.dll")
int GetCurrentPackageId(uint* bufferLength, char* buffer);

@DllImport("KERNEL32.dll")
int GetCurrentPackageFullName(uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("KERNEL32.dll")
int GetCurrentPackageFamilyName(uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("KERNEL32.dll")
int GetCurrentPackagePath(uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32.dll")
int GetPackageId(HANDLE hProcess, uint* bufferLength, char* buffer);

@DllImport("KERNEL32.dll")
int GetPackageFullName(HANDLE hProcess, uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int GetPackageFullNameFromToken(HANDLE token, uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("KERNEL32.dll")
int GetPackageFamilyName(HANDLE hProcess, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int GetPackageFamilyNameFromToken(HANDLE token, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("KERNEL32.dll")
int GetPackagePath(const(PACKAGE_ID)* packageId, const(uint) reserved, uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32.dll")
int GetPackagePathByFullName(const(wchar)* packageFullName, uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32.dll")
int GetStagedPackagePathByFullName(const(wchar)* packageFullName, uint* pathLength, const(wchar)* path);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
int GetPackagePathByFullName2(const(wchar)* packageFullName, PackagePathType packagePathType, uint* pathLength, const(wchar)* path);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
int GetStagedPackagePathByFullName2(const(wchar)* packageFullName, PackagePathType packagePathType, uint* pathLength, const(wchar)* path);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
int GetCurrentPackageInfo2(const(uint) flags, PackagePathType packagePathType, uint* bufferLength, char* buffer, uint* count);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
int GetCurrentPackagePath2(PackagePathType packagePathType, uint* pathLength, const(wchar)* path);

@DllImport("KERNEL32.dll")
int GetCurrentApplicationUserModelId(uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

@DllImport("KERNEL32.dll")
int GetApplicationUserModelId(HANDLE hProcess, uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int GetApplicationUserModelIdFromToken(HANDLE token, uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int VerifyPackageFullName(const(wchar)* packageFullName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int VerifyPackageFamilyName(const(wchar)* packageFamilyName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int VerifyPackageId(const(PACKAGE_ID)* packageId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int VerifyApplicationUserModelId(const(wchar)* applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int VerifyPackageRelativeApplicationId(const(wchar)* packageRelativeApplicationId);

@DllImport("KERNEL32.dll")
int PackageIdFromFullName(const(wchar)* packageFullName, const(uint) flags, uint* bufferLength, char* buffer);

@DllImport("KERNEL32.dll")
int PackageFullNameFromId(const(PACKAGE_ID)* packageId, uint* packageFullNameLength, const(wchar)* packageFullName);

@DllImport("KERNEL32.dll")
int PackageFamilyNameFromId(const(PACKAGE_ID)* packageId, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("KERNEL32.dll")
int PackageFamilyNameFromFullName(const(wchar)* packageFullName, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

@DllImport("KERNEL32.dll")
int PackageNameAndPublisherIdFromFamilyName(const(wchar)* packageFamilyName, uint* packageNameLength, const(wchar)* packageName, uint* packagePublisherIdLength, const(wchar)* packagePublisherId);

@DllImport("KERNEL32.dll")
int FormatApplicationUserModelId(const(wchar)* packageFamilyName, const(wchar)* packageRelativeApplicationId, uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

@DllImport("KERNEL32.dll")
int ParseApplicationUserModelId(const(wchar)* applicationUserModelId, uint* packageFamilyNameLength, const(wchar)* packageFamilyName, uint* packageRelativeApplicationIdLength, const(wchar)* packageRelativeApplicationId);

@DllImport("KERNEL32.dll")
int GetPackagesByPackageFamily(const(wchar)* packageFamilyName, uint* count, char* packageFullNames, uint* bufferLength, char* buffer);

@DllImport("KERNEL32.dll")
int FindPackagesByPackageFamily(const(wchar)* packageFamilyName, uint packageFilters, uint* count, char* packageFullNames, uint* bufferLength, char* buffer, char* packageProperties);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int GetStagedPackageOrigin(const(wchar)* packageFullName, PackageOrigin* origin);

@DllImport("KERNEL32.dll")
int GetCurrentPackageInfo(const(uint) flags, uint* bufferLength, char* buffer, uint* count);

@DllImport("KERNEL32.dll")
int OpenPackageInfoByFullName(const(wchar)* packageFullName, const(uint) reserved, _PACKAGE_INFO_REFERENCE** packageInfoReference);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
int OpenPackageInfoByFullNameForUser(void* userSid, const(wchar)* packageFullName, const(uint) reserved, _PACKAGE_INFO_REFERENCE** packageInfoReference);

@DllImport("KERNEL32.dll")
int ClosePackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference);

@DllImport("KERNEL32.dll")
int GetPackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference, const(uint) flags, uint* bufferLength, char* buffer, uint* count);

@DllImport("KERNEL32.dll")
int GetPackageApplicationIds(_PACKAGE_INFO_REFERENCE* packageInfoReference, uint* bufferLength, char* buffer, uint* count);

@DllImport("KERNEL32.dll")
int AppPolicyGetLifecycleManagement(HANDLE processToken, AppPolicyLifecycleManagement* policy);

@DllImport("KERNEL32.dll")
int AppPolicyGetWindowingModel(HANDLE processToken, AppPolicyWindowingModel* policy);

@DllImport("KERNEL32.dll")
int AppPolicyGetMediaFoundationCodecLoading(HANDLE processToken, AppPolicyMediaFoundationCodecLoading* policy);

@DllImport("KERNEL32.dll")
int AppPolicyGetClrCompat(HANDLE processToken, AppPolicyClrCompat* policy);

@DllImport("KERNEL32.dll")
int AppPolicyGetThreadInitializationType(HANDLE processToken, AppPolicyThreadInitializationType* policy);

@DllImport("KERNEL32.dll")
int AppPolicyGetShowDeveloperDiagnostic(HANDLE processToken, AppPolicyShowDeveloperDiagnostic* policy);

@DllImport("KERNEL32.dll")
int AppPolicyGetProcessTerminationMethod(HANDLE processToken, AppPolicyProcessTerminationMethod* policy);

@DllImport("KERNEL32.dll")
int AppPolicyGetCreateFileAccess(HANDLE processToken, AppPolicyCreateFileAccess* policy);

@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
int GetPackageInfo2(_PACKAGE_INFO_REFERENCE* packageInfoReference, const(uint) flags, PackagePathType packagePathType, uint* bufferLength, char* buffer, uint* count);

