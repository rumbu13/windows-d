// Written in the D programming language.

module windows.appxpackaging;

public import windows.core;
public import windows.com : HRESULT, IUnknown, IUri;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


///Specifies the degree of compression used to store the file in the package.
alias APPX_COMPRESSION_OPTION = int;
enum : int
{
    ///No compression.
    APPX_COMPRESSION_OPTION_NONE      = 0x00000000,
    ///Normal compression.
    APPX_COMPRESSION_OPTION_NORMAL    = 0x00000001,
    ///Maximum compression.
    APPX_COMPRESSION_OPTION_MAXIMUM   = 0x00000002,
    ///Fast compression.
    APPX_COMPRESSION_OPTION_FAST      = 0x00000003,
    ///Super-fast compression.
    APPX_COMPRESSION_OPTION_SUPERFAST = 0x00000004,
}

///Specifies the type of footprint file in a package.
alias APPX_FOOTPRINT_FILE_TYPE = int;
enum : int
{
    ///The package manifest.
    APPX_FOOTPRINT_FILE_TYPE_MANIFEST        = 0x00000000,
    ///The package block map.
    APPX_FOOTPRINT_FILE_TYPE_BLOCKMAP        = 0x00000001,
    ///The package signature.
    APPX_FOOTPRINT_FILE_TYPE_SIGNATURE       = 0x00000002,
    ///The code signing catalog file used for code integrity checks.
    APPX_FOOTPRINT_FILE_TYPE_CODEINTEGRITY   = 0x00000003,
    ///The content group map used for streaming install.
    APPX_FOOTPRINT_FILE_TYPE_CONTENTGROUPMAP = 0x00000004,
}

///Specifies the type of footprint file in a bundle.
alias APPX_BUNDLE_FOOTPRINT_FILE_TYPE = int;
enum : int
{
    ///The bundle's first footprint file, which is the bundle manifest.
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_FIRST     = 0x00000000,
    ///The bundle manifest.
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_MANIFEST  = 0x00000000,
    ///The bundle block map.
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_BLOCKMAP  = 0x00000001,
    ///The bundle signature.
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_SIGNATURE = 0x00000002,
    ///The bundle's last footprint file, which is the bundle signature.
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_LAST      = 0x00000002,
}

///Specifies the capabilities or privileges requested by a package.
alias APPX_CAPABILITIES = int;
enum : int
{
    ///Your Internet connection for outgoing connections to the Internet.
    APPX_CAPABILITY_INTERNET_CLIENT               = 0x00000001,
    ///Your Internet connection, including incoming unsolicited connections from the Internet – the app can send
    ///information to or from your computer through a firewall. You do not need to declare
    ///<b>APPX_CAPABILITY_INTERNET_CLIENT</b> if this capability is declared.
    APPX_CAPABILITY_INTERNET_CLIENT_SERVER        = 0x00000002,
    ///A home or work network – the app can send information to or from your computer and other computers on the same
    ///network.
    APPX_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER = 0x00000004,
    ///Your documents library, including the capability to add, change, or delete files. The package can access only
    ///file types that it has declared in the manifest. The app cannot access document libraries on HomeGroup computers.
    APPX_CAPABILITY_DOCUMENTS_LIBRARY             = 0x00000008,
    ///Your pictures library, including the capability to add, change, or delete files. This capability also includes
    ///pictures libraries on HomeGroup computers, along with picture file types on locally connected media servers.
    APPX_CAPABILITY_PICTURES_LIBRARY              = 0x00000010,
    ///Your videos library, including the capability to add, change, or delete files. This capability also includes
    ///videos libraries on HomeGroup computers, along with video file types on locally connected media servers.
    APPX_CAPABILITY_VIDEOS_LIBRARY                = 0x00000020,
    ///Your music library and playlists, including the capability to add, change, or delete files. This capability also
    ///includes music libraries and playlists in the music library on HomeGroup computers, plus music file types on
    ///locally connected media servers.
    APPX_CAPABILITY_MUSIC_LIBRARY                 = 0x00000040,
    ///Your Windows credentials, for access to a corporate intranet. This application can impersonate you on the
    ///network.
    APPX_CAPABILITY_ENTERPRISE_AUTHENTICATION     = 0x00000080,
    ///Software and hardware certificates or a smart card – used to identify you in the app. This capability may be
    ///used by your employer, bank, or government services to identify you.
    APPX_CAPABILITY_SHARED_USER_CERTIFICATES      = 0x00000100,
    ///Removable storage, such as an external hard drive or USB flash drive, or MTP portable device, including the
    ///capability to add, change, or delete specific files. This package can only access file types that it has declared
    ///in the manifest.
    APPX_CAPABILITY_REMOVABLE_STORAGE             = 0x00000200,
    APPX_CAPABILITY_APPOINTMENTS                  = 0x00000400,
    APPX_CAPABILITY_CONTACTS                      = 0x00000800,
}

///Specifies the processor architectures supported by a package.
alias APPX_PACKAGE_ARCHITECTURE = int;
enum : int
{
    ///The x86 processor architecture.
    APPX_PACKAGE_ARCHITECTURE_X86     = 0x00000000,
    ///The ARM processor architecture.
    APPX_PACKAGE_ARCHITECTURE_ARM     = 0x00000005,
    ///The x64 processor architecture.
    APPX_PACKAGE_ARCHITECTURE_X64     = 0x00000009,
    ///Any processor architecture.
    APPX_PACKAGE_ARCHITECTURE_NEUTRAL = 0x0000000b,
    ///The 64-bit ARM processor architecture.
    APPX_PACKAGE_ARCHITECTURE_ARM64   = 0x0000000c,
}

///Specifies the processor architectures supported by a package.
alias APPX_PACKAGE_ARCHITECTURE2 = int;
enum : int
{
    ///The x86, 32-bit processor architecture.
    APPX_PACKAGE_ARCHITECTURE2_X86          = 0x00000000,
    ///The ARM processor architecture.
    APPX_PACKAGE_ARCHITECTURE2_ARM          = 0x00000005,
    ///The x64, 64-bit processor architecture.
    APPX_PACKAGE_ARCHITECTURE2_X64          = 0x00000009,
    ///Any processor architecture.
    APPX_PACKAGE_ARCHITECTURE2_NEUTRAL      = 0x0000000b,
    ///The 64-bit ARM processor architecture.
    APPX_PACKAGE_ARCHITECTURE2_ARM64        = 0x0000000c,
    ///A 32-bit app package that runs on a 64-bit ARM processor.
    APPX_PACKAGE_ARCHITECTURE2_X86_ON_ARM64 = 0x0000000e,
    ///Unknown app package architecture.
    APPX_PACKAGE_ARCHITECTURE2_UNKNOWN      = 0x0000ffff,
}

///Specifies the type of package for a IAppxBundleManifestPackageInfo object.
alias APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE = int;
enum : int
{
    ///The package is an app.
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_APPLICATION = 0x00000000,
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_RESOURCE    = 0x00000001,
}

alias DX_FEATURE_LEVEL = int;
enum : int
{
    DX_FEATURE_LEVEL_UNSPECIFIED = 0x00000000,
    DX_FEATURE_LEVEL_9           = 0x00000001,
    DX_FEATURE_LEVEL_10          = 0x00000002,
    DX_FEATURE_LEVEL_11          = 0x00000003,
}

alias APPX_CAPABILITY_CLASS_TYPE = int;
enum : int
{
    APPX_CAPABILITY_CLASS_DEFAULT    = 0x00000000,
    APPX_CAPABILITY_CLASS_GENERAL    = 0x00000001,
    APPX_CAPABILITY_CLASS_RESTRICTED = 0x00000002,
    APPX_CAPABILITY_CLASS_WINDOWS    = 0x00000004,
    APPX_CAPABILITY_CLASS_ALL        = 0x00000007,
    APPX_CAPABILITY_CLASS_CUSTOM     = 0x00000008,
}

alias APPX_PACKAGING_CONTEXT_CHANGE_TYPE = int;
enum : int
{
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_START   = 0x00000000,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_CHANGE  = 0x00000001,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_DETAILS = 0x00000002,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_END     = 0x00000003,
}

///Encrypted app package options.
alias APPX_ENCRYPTED_PACKAGE_OPTIONS = int;
enum : int
{
    ///No options.
    APPX_ENCRYPTED_PACKAGE_OPTION_NONE         = 0x00000000,
    ///Option to use diffusion.
    APPX_ENCRYPTED_PACKAGE_OPTION_DIFFUSION    = 0x00000001,
    APPX_ENCRYPTED_PACKAGE_OPTION_PAGE_HASHING = 0x00000002,
}

///Options to use when updating an app package.
alias APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION = int;
enum : int
{
    ///Appends the delta (difference) of the baseline package and the updated package.
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION_APPEND_DELTA = 0x00000000,
}

///Options for app manifest validation when updating the manifest.
alias APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS = int;
enum : int
{
    ///No options.
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_NONE            = 0x00000000,
    ///Skip app package manifest validation.
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_SKIP_VALIDATION = 0x00000001,
    ///The app package manifest is localized.
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_LOCALIZED       = 0x00000002,
}

///Indicates the type of folder path to retrieve in a query for the path or other info about a package.
enum PackagePathType : int
{
    ///Retrieve the package path in the original install folder for the application.
    PackagePathType_Install           = 0x00000000,
    ///Retrieve the package path in the mutable install folder for the application, if the application is declared as
    ///mutable in the package manifest.
    PackagePathType_Mutable           = 0x00000001,
    ///Retrieve the package path in the mutable folder if the application is declared as mutable in the package
    ///manifest, or in the original install folder if the application is not mutable.
    PackagePathType_Effective         = 0x00000002,
    PackagePathType_MachineExternal   = 0x00000003,
    PackagePathType_UserExternal      = 0x00000004,
    PackagePathType_EffectiveExternal = 0x00000005,
}

///Specifies the origin of a package.
enum PackageOrigin : int
{
    ///The package's origin is unknown.
    PackageOrigin_Unknown           = 0x00000000,
    ///The package originated as unsigned.
    PackageOrigin_Unsigned          = 0x00000001,
    ///The package was included inbox.
    PackageOrigin_Inbox             = 0x00000002,
    ///The package originated from the Windows Store.
    PackageOrigin_Store             = 0x00000003,
    ///The package originated as developer unsigned.
    PackageOrigin_DeveloperUnsigned = 0x00000004,
    ///The package originated as developer signed.
    PackageOrigin_DeveloperSigned   = 0x00000005,
    ///The package originated as a line-of-business app.
    PackageOrigin_LineOfBusiness    = 0x00000006,
}

///The AppPolicyLifecycleManagement enumeration indicates whether a process is lifecycle-managed or not.
enum AppPolicyLifecycleManagement : int
{
    ///Indicates that the process's lifecycle is not managed.
    AppPolicyLifecycleManagement_Unmanaged = 0x00000000,
    AppPolicyLifecycleManagement_Managed   = 0x00000001,
}

///The AppPolicyWindowingModel enumeration indicates whether a process uses a CoreWindow-based, or a HWND-based,
///windowing model.
enum AppPolicyWindowingModel : int
{
    ///Indicates that the process doesn't have a windowing model.
    AppPolicyWindowingModel_None           = 0x00000000,
    ///Indicates that the process's windowing model is CoreWindow-based.
    AppPolicyWindowingModel_Universal      = 0x00000001,
    ///Indicates that the process's windowing model is HWND-based.
    AppPolicyWindowingModel_ClassicDesktop = 0x00000002,
    AppPolicyWindowingModel_ClassicPhone   = 0x00000003,
}

///The AppPolicyMediaFoundationCodecLoading enumeration indicates whether a process’s policy allows it to load
///non-Windows (third-party) plugins.
enum AppPolicyMediaFoundationCodecLoading : int
{
    ///Indicates that the process’s policy allows it to load non-Windows (third-party) plugins.
    AppPolicyMediaFoundationCodecLoading_All       = 0x00000000,
    AppPolicyMediaFoundationCodecLoading_InboxOnly = 0x00000001,
}

///The AppPolicyClrCompat enumeration indicates the application type of a process so that you can determine whether to
///enable private reflection and/or make managed objects agile.
enum AppPolicyClrCompat : int
{
    ///Indicates an application type other than the ones indicated by the other enumerated constants. The Common
    ///Language Runtime (CLR) should not be called by applications that are not Universal Windows Platform (UWP), Win32,
    ///nor Desktop Bridge.
    AppPolicyClrCompat_Other           = 0x00000000,
    ///Indicates a desktop/Win32 application, or an NT service. You can support private reflection on framework types.
    AppPolicyClrCompat_ClassicDesktop  = 0x00000001,
    ///Indicates a Universal Windows Platform (UWP) application. You should disable private reflection on framework
    ///types, but you can support IAgileObject.
    AppPolicyClrCompat_Universal       = 0x00000002,
    AppPolicyClrCompat_PackagedDesktop = 0x00000003,
}

///The AppPolicyThreadInitializationType enumeration indicates the kind of initialization that should be automatically
///performed for a process when beginthread[ex] creates a thread.
enum AppPolicyThreadInitializationType : int
{
    ///Indicates that no initialization should be performed.
    AppPolicyThreadInitializationType_None            = 0x00000000,
    AppPolicyThreadInitializationType_InitializeWinRT = 0x00000001,
}

///The AppPolicyShowDeveloperDiagnostic enumeration indicates the method used for a process to surface developer
///information, such as asserts, to the user.
enum AppPolicyShowDeveloperDiagnostic : int
{
    ///Indicates that the process does not show developer diagnostics. This value is expected for a UWP app.
    AppPolicyShowDeveloperDiagnostic_None   = 0x00000000,
    AppPolicyShowDeveloperDiagnostic_ShowUI = 0x00000001,
}

///The AppPolicyProcessTerminationMethod enumeration indicates the method used to end a process.
enum AppPolicyProcessTerminationMethod : int
{
    ///Allows DLLs to execute code at shutdown. This value is expected for a desktop application, or for a Desktop
    ///Bridge application.
    AppPolicyProcessTerminationMethod_ExitProcess      = 0x00000000,
    AppPolicyProcessTerminationMethod_TerminateProcess = 0x00000001,
}

///The AppPolicyCreateFileAccess enumeration indicates whether a process has full or restricted access to the IO devices
///(file, file stream, directory, physical disk, volume, console buffer, tape drive, communications resource, mailslot,
///and pipe).
enum AppPolicyCreateFileAccess : int
{
    ///Indicates that the process has full access to the IO devices. This value is expected for a desktop application,
    ///or for a Desktop Bridge application.
    AppPolicyCreateFileAccess_Full    = 0x00000000,
    AppPolicyCreateFileAccess_Limited = 0x00000001,
}

// Structs


///Represents package settings used to create a package.
struct APPX_PACKAGE_SETTINGS
{
    ///Type: <b>BOOL</b> <b>TRUE</b> if the package is created as Zip32; <b>FALSE</b> if the package is created as
    ///Zip64. The default is Zip64.
    BOOL forceZip32;
    ///Type: <b><b>IUri</b>*</b> The hash algorithm URI to use for the block map of the package.
    IUri hashMethod;
}

///Contains the data and metadata of files to write into the app package.
struct APPX_PACKAGE_WRITER_PAYLOAD_STREAM
{
    ///The source of the payload file.
    IStream       inputStream;
    ///Name of the payload file.
    const(wchar)* fileName;
    ///The content type of the payload file.
    const(wchar)* contentType;
    APPX_COMPRESSION_OPTION compressionOption;
}

///Settings for encrypted Windows app packages.
struct APPX_ENCRYPTED_PACKAGE_SETTINGS
{
    ///The key length.
    uint          keyLength;
    ///The encryption algorithm used.
    const(wchar)* encryptionAlgorithm;
    ///True is diffusion is used, false otherwise.
    BOOL          useDiffusion;
    IUri          blockMapHashAlgorithm;
}

///Encrypted Windows app package settings. This structure expands on APPX_ENCRYPTED_PACKAGE_SETTINGS.
struct APPX_ENCRYPTED_PACKAGE_SETTINGS2
{
    ///The key length.
    uint          keyLength;
    ///The encryption algorithm used.
    const(wchar)* encryptionAlgorithm;
    ///The Uri of the block map hash algorithm.
    IUri          blockMapHashAlgorithm;
    uint          options;
}

///Windows app package key information.
struct APPX_KEY_INFO
{
    ///The length of the key.
    uint   keyLength;
    ///The length of the key Id.
    uint   keyIdLength;
    ///The app package key.
    ubyte* key;
    ubyte* keyId;
}

///Files exempted from Windows app package encryption.
struct APPX_ENCRYPTED_EXEMPTIONS
{
    ///The count of files exempted.
    uint     count;
    ushort** plainTextFiles;
}

///Represents the package version information.
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

///Represents package identification information, such as name, version, and publisher.
struct PACKAGE_ID
{
    ///Type: <b>UINT32</b> Reserved; do not use.
    uint            reserved;
    ///Type: <b>UINT32</b> The processor architecture of the package. This member must be one of the values of the
    ///<b>PROCESSOR_ARCHITECTURE_...</b> constants that matches the <b>ProcessorArchitecture</b> enumeration values.
    ///This includes: * PROCESSOR_ARCHITECTURE_AMD64 * PROCESSOR_ARCHITECTURE_ARM * PROCESSOR_ARCHITECTURE_ARM64 *
    ///PROCESSOR_ARCHITECTURE_INTEL * PROCESSOR_ARCHITECTURE_IA32_ON_ARM64 * PROCESSOR_ARCHITECTURE_NEUTRAL *
    ///PROCESSOR_ARCHITECTURE_UNKNOWN
    uint            processorArchitecture;
    ///Type: <b>PACKAGE_VERSION</b> The version of the package.
    PACKAGE_VERSION version_;
    ///Type: <b>PWSTR</b> The name of the package.
    const(wchar)*   name;
    ///Type: <b>PWSTR</b> The publisher of the package. If there is no publisher for the package, this member is
    ///<b>NULL</b>.
    const(wchar)*   publisher;
    ///Type: <b>PWSTR</b> The resource identifier (ID) of the package. If there is no resource ID for the package, this
    ///member is <b>NULL</b>.
    const(wchar)*   resourceId;
    ///Type: <b>PWSTR</b> The publisher identifier (ID) of the package. If there is no publisher ID for the package,
    ///this member is <b>NULL</b>.
    const(wchar)*   publisherId;
}

struct _PACKAGE_INFO_REFERENCE
{
    void* reserved;
}

///Represents package identification information that includes the package identifier, full name, and install location.
struct PACKAGE_INFO
{
    ///Type: <b>UINT32</b> Reserved; do not use.
    uint          reserved;
    ///Type: <b>UINT32</b> Properties of the package.
    uint          flags;
    ///Type: <b>PWSTR</b> The location of the package.
    const(wchar)* path;
    ///Type: <b>PWSTR</b> The package full name.
    const(wchar)* packageFullName;
    ///Type: <b>PWSTR</b> The package family name.
    const(wchar)* packageFamilyName;
    ///Type: <b>PACKAGE_ID</b> The package identifier (ID).
    PACKAGE_ID    packageId;
}

// Functions

///Gets the package identifier (ID) for the calling process.
///Params:
///    bufferLength = Type: <b>UINT32*</b> On input, the size of <i>buffer</i>, in bytes. On output, the size of the structure
///                   returned, in bytes.
///    buffer = Type: <b>BYTE*</b> The package ID, represented as a PACKAGE_ID structure.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>bufferLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetCurrentPackageId(uint* bufferLength, char* buffer);

///Gets the package full name for the calling process.
///Params:
///    packageFullNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFullName</i> buffer, in characters. On output, the size
///                            of the package full name returned, in characters, including the null terminator.
///    packageFullName = Type: <b>PWSTR</b> The package full name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>packageFullNameLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetCurrentPackageFullName(uint* packageFullNameLength, const(wchar)* packageFullName);

///Gets the package family name for the calling process.
///Params:
///    packageFamilyNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFamilyName</i> buffer, in characters, including the null
///                              terminator. On output, the size of the package family name returned, in characters, including the null
///                              terminator.
///    packageFamilyName = Type: <b>PWSTR</b> The package family name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>packageFamilyNameLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetCurrentPackageFamilyName(uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

///Gets the package path for the calling process.
///Params:
///    pathLength = Type: <b>UINT32*</b> On input, the size of the <i>path</i> buffer, in characters. On output, the size of the
///                 package path returned, in characters, including the null terminator.
///    path = Type: <b>PWSTR</b> The package path.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>pathLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetCurrentPackagePath(uint* pathLength, const(wchar)* path);

///Gets the package identifier (ID) for the specified process.
///Params:
///    hProcess = Type: <b>HANDLE</b> A handle to the process that has the <b>PROCESS_QUERY_INFORMATION</b> or
///               <b>PROCESS_QUERY_LIMITED_INFORMATION</b> access right. For more information, see Process Security and Access
///               Rights.
///    bufferLength = Type: <b>UINT32*</b> On input, the size of <i>buffer</i>, in bytes. On output, the size of the structure
///                   returned, in bytes.
///    buffer = Type: <b>BYTE*</b> The package ID, represented as a PACKAGE_ID structure.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>bufferLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetPackageId(HANDLE hProcess, uint* bufferLength, char* buffer);

///Gets the package full name for the specified process.
///Params:
///    hProcess = Type: <b>HANDLE</b> A handle to the process that has the <b>PROCESS_QUERY_INFORMATION</b> or
///               <b>PROCESS_QUERY_LIMITED_INFORMATION</b> access right. For more information, see Process Security and Access
///               Rights.
///    packageFullNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFullName</i> buffer, in characters. On output, the size
///                            of the package full name returned, in characters, including the null terminator.
///    packageFullName = Type: <b>PWSTR</b> The package full name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>packageFullNameLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetPackageFullName(HANDLE hProcess, uint* packageFullNameLength, const(wchar)* packageFullName);

///Gets the package full name for the specified token.
///Params:
///    token = A token that contains the package identity.
///    packageFullNameLength = On input, the size of the <i>packageFullName</i> buffer, in characters. On output, the size of the package full
///                            name returned, in characters, including the null terminator.
///    packageFullName = The package full name.
///Returns:
///    If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an error code. The
///    possible error codes include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td width="60%"> The token has no package
///    identity. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>packageFullNameLength</i>. </td> </tr> </table>
///    
@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int GetPackageFullNameFromToken(HANDLE token, uint* packageFullNameLength, const(wchar)* packageFullName);

///Gets the package family name for the specified process.
///Params:
///    hProcess = Type: <b>HANDLE</b> A handle to the process that has the <b>PROCESS_QUERY_INFORMATION</b> or
///               <b>PROCESS_QUERY_LIMITED_INFORMATION</b> access right. For more information, see Process Security and Access
///               Rights.
///    packageFamilyNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFamilyName</i> buffer, in characters. On output, the
///                              size of the package family name returned, in characters, including the null-terminator.
///    packageFamilyName = Type: <b>PWSTR</b> The package family name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>packageFamilyNameLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetPackageFamilyName(HANDLE hProcess, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

///Gets the package family name for the specified token.
///Params:
///    token = Type: <b>HANDLE</b> A token that contains the package identity.
///    packageFamilyNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFamilyName</i> buffer, in characters. On output, the
///                              size of the package family name returned, in characters, including the null-terminator.
///    packageFamilyName = Type: <b>PWSTR</b> The package family name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The token has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>packageFamilyNameLength</i>. </td> </tr> </table>
///    
@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int GetPackageFamilyNameFromToken(HANDLE token, uint* packageFamilyNameLength, const(wchar)* packageFamilyName);

///Gets the path for the specified package.
///Params:
///    packageId = Type: <b>const PACKAGE_ID*</b> The package identifier.
///    reserved = Type: <b>const UINT32</b> Reserved, do not use.
///    pathLength = Type: <b>UINT32*</b> On input, the size of the <i>path</i> buffer, in characters. On output, the size of the
///                 package path returned, in characters, including the null-terminator.
///    path = Type: <b>PWSTR</b> The package path.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer specified by <i>path</i> is not large enough to hold the data. The required size is
///    specified by <i>pathLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetPackagePath(const(PACKAGE_ID)* packageId, const(uint) reserved, uint* pathLength, const(wchar)* path);

///Gets the path of the specified package.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of the package.
///    pathLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters (<b>WCHAR</b>s) in the package
///                 path string, which includes the null-terminator. First you pass <b>NULL</b> to <i>path</i> to get the number of
///                 characters. You use this number to allocate memory space for <i>path</i>. Then you pass the address of this
///                 memory space to fill <i>path</i>.
///    path = Type: <b>PWSTR</b> A pointer to memory space that receives the package path string, which includes the
///           null-terminator.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer specified by <i>path</i> is not large enough to hold the data. The required size is
///    specified by <i>pathLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetPackagePathByFullName(const(wchar)* packageFullName, uint* pathLength, const(wchar)* path);

///Gets the path of the specified staged package.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of the staged package.
///    pathLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters (<b>WCHAR</b>s) in the package
///                 path string, which includes the null-terminator. First you pass <b>NULL</b> to <i>path</i> to get the number of
///                 characters. You use this number to allocate memory space for <i>path</i>. Then you pass the address of this
///                 memory space to fill <i>path</i>.
///    path = Type: <b>PWSTR</b> A pointer to memory space that receives the package path string, which includes the
///           null-terminator.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer specified by <i>path</i> is not large enough to hold the data. The required size is
///    specified by <i>pathLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetStagedPackagePathByFullName(const(wchar)* packageFullName, uint* pathLength, const(wchar)* path);

///Gets the path of the specified package, with the option to specify the type of folder path to retrieve for the
///package.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of the package.
///    packagePathType = Type: [**PackagePathType**](ne-appmodel-packagepathtype.md) Indicates the type of folder path to retrieve for the
///                      package (the original install folder or the mutable folder).
///    pathLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters (<b>WCHAR</b>s) in the package
///                 path string, which includes the null-terminator. First you pass <b>NULL</b> to <i>path</i> to get the number of
///                 characters. You use this number to allocate memory space for <i>path</i>. Then you pass the address of this
///                 memory space to fill <i>path</i>.
///    path = Type: <b>PWSTR</b> A pointer to memory space that receives the package path string, which includes the
///           null-terminator.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer specified by <i>path</i> is not large enough to hold the data. The required size is
///    specified by <i>pathLength</i>. </td> </tr> </table>
///    
@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetPackagePathByFullName2(const(wchar)* packageFullName, PackagePathType packagePathType, uint* pathLength, 
                              const(wchar)* path);

///Gets the path of the specified staged package, with the option to specify the type of folder path to retrieve for the
///package.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of the staged package.
///    packagePathType = Type: [**PackagePathType**](ne-appmodel-packagepathtype.md) Indicates the type of folder path to retrieve for the
///                      package (the original install folder or the mutable folder).
///    pathLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters (<b>WCHAR</b>s) in the package
///                 path string, which includes the null-terminator. First you pass <b>NULL</b> to <i>path</i> to get the number of
///                 characters. You use this number to allocate memory space for <i>path</i>. Then you pass the address of this
///                 memory space to fill <i>path</i>.
///    path = Type: <b>PWSTR</b> A pointer to memory space that receives the package path string, which includes the
///           null-terminator.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer specified by <i>path</i> is not large enough to hold the data. The required size is
///    specified by <i>pathLength</i>. </td> </tr> </table>
///    
@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetStagedPackagePathByFullName2(const(wchar)* packageFullName, PackagePathType packagePathType, 
                                    uint* pathLength, const(wchar)* path);

///Gets the package information for the calling process, with the option to specify the type of folder path to retrieve
///for the package.
///Params:
///    flags = Type: <b>const UINT32</b> The [package constants](/windows/desktop/appxpkg/package-constants) that specify how
///            package information is retrieved. The <b>PACKAGE_FILTER_*</b> flags are supported.
///    packagePathType = Type: [**PackagePathType**](ne-appmodel-packagepathtype.md) Indicates the type of folder path to retrieve for the
///                      package (the original install folder or the mutable folder).
///    bufferLength = Type: <b>UINT32*</b> On input, the size of <i>buffer</i>, in bytes. On output, the size of the array of
///                   structures returned, in bytes.
///    buffer = Type: <b>BYTE*</b> The package information, represented as an array of PACKAGE_INFO structures.
///    count = Type: <b>UINT32*</b> The number of structures in the buffer.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>bufferLength</i>. </td> </tr> </table>
///    
@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetCurrentPackageInfo2(const(uint) flags, PackagePathType packagePathType, uint* bufferLength, char* buffer, 
                           uint* count);

///Gets the package path for the calling process, with the option to specify the type of folder path to retrieve for the
///package.
///Params:
///    packagePathType = Type: [**PackagePathType**](ne-appmodel-packagepathtype.md) Indicates the type of folder path to retrieve for the
///                      package (the original install folder or the mutable folder).
///    pathLength = Type: <b>UINT32*</b> On input, the size of the <i>path</i> buffer, in characters. On output, the size of the
///                 package path returned, in characters, including the null terminator.
///    path = Type: <b>PWSTR</b> The package path.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>pathLength</i>. </td> </tr> </table>
///    
@DllImport("api-ms-win-appmodel-runtime-l1-1-3")
int GetCurrentPackagePath2(PackagePathType packagePathType, uint* pathLength, const(wchar)* path);

///Gets the application user model ID for the current process.
///Params:
///    applicationUserModelIdLength = On input, the size of the <i>applicationUserModelId</i> buffer, in wide characters. On success, the size of the
///                                   buffer used, including the null terminator.
///    applicationUserModelId = A pointer to a buffer that receives the application user model ID.
///Returns:
///    If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an error code. The
///    possible error codes include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_APPLICATION</b></dt> </dl> </td> <td width="60%"> The process has no
///    application identity. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl>
///    </td> <td width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>applicationUserModelIdLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetCurrentApplicationUserModelId(uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

///Gets the application user model ID for the specified process.
///Params:
///    hProcess = A handle to the process. This handle must have the <b>PROCESS_QUERY_LIMITED_INFORMATION</b> access right. For
///               more info, see Process Security and Access Rights.
///    applicationUserModelIdLength = On input, the size of the <i>applicationUserModelId</i> buffer, in wide characters. On success, the size of the
///                                   buffer used, including the null terminator.
///    applicationUserModelId = A pointer to a buffer that receives the application user model ID.
///Returns:
///    If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an error code. The
///    possible error codes include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_APPLICATION</b></dt> </dl> </td> <td width="60%"> The process has no
///    application identity. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl>
///    </td> <td width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>applicationUserModelIdLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetApplicationUserModelId(HANDLE hProcess, uint* applicationUserModelIdLength, 
                              const(wchar)* applicationUserModelId);

///Gets the application user model ID for the specified token.
///Params:
///    token = A token that contains the application identity. This handle must have the
///            <b>PROCESS_QUERY_LIMITED_INFORMATION</b> access right. For more info, see Process Security and Access Rights.
///    applicationUserModelIdLength = On input, the size of the <i>applicationUserModelId</i> buffer, in wide characters. On success, the size of the
///                                   buffer used, including the null terminator.
///    applicationUserModelId = A pointer to a buffer that receives the application user model ID.
///Returns:
///    If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an error code. The
///    possible error codes include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_APPLICATION</b></dt> </dl> </td> <td width="60%"> The token has no
///    application identity. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl>
///    </td> <td width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>applicationUserModelIdLength</i>. </td> </tr> </table>
///    
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

///Gets the package identifier (ID) for the specified package full name.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of a package.
///    flags = Type: <b>const UINT32</b> The package constants that specify how package information is retrieved. The
///            <b>PACKAGE_INFORMATION_*</b> flags are supported.
///    bufferLength = Type: <b>UINT32*</b> On input, the size of <i>buffer</i>, in bytes. On output, the size of the data returned, in
///                   bytes.
///    buffer = Type: <b>BYTE*</b> The package ID, represented as a PACKAGE_ID structure.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>bufferLength</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The package is not installed for the user. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int PackageIdFromFullName(const(wchar)* packageFullName, const(uint) flags, uint* bufferLength, char* buffer);

///Gets the package full name for the specified package identifier (ID).
///Params:
///    packageId = Type: <b>const PACKAGE_ID*</b> The package ID.
///    packageFullNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFullName</i> buffer, in characters. On output, the size
///                            of the package full name returned, in characters, including the null terminator.
///    packageFullName = Type: <b>PWSTR</b> The package full name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>packageFullNameLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int PackageFullNameFromId(const(PACKAGE_ID)* packageId, uint* packageFullNameLength, const(wchar)* packageFullName);

///Gets the package family name for the specified package identifier.
///Params:
///    packageId = Type: <b>const PACKAGE_ID*</b> The package identifier.
///    packageFamilyNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFamilyName</i> buffer, in characters. On output, the
///                              size of the package family name returned, in characters, including the null terminator.
///    packageFamilyName = Type: <b>PWSTR</b> The package family name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>packageFamilyNameLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int PackageFamilyNameFromId(const(PACKAGE_ID)* packageId, uint* packageFamilyNameLength, 
                            const(wchar)* packageFamilyName);

///Gets the package family name for the specified package full name.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of a package.
///    packageFamilyNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageFamilyName</i> buffer, in characters. On output, the
///                              size of the package family name returned, in characters, including the null terminator.
///    packageFamilyName = Type: <b>PWSTR</b> The package family name.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>packageFamilyNameLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int PackageFamilyNameFromFullName(const(wchar)* packageFullName, uint* packageFamilyNameLength, 
                                  const(wchar)* packageFamilyName);

///Gets the package name and publisher identifier (ID) for the specified package family name.
///Params:
///    packageFamilyName = Type: <b>PCWSTR</b> The family name of a package.
///    packageNameLength = Type: <b>UINT32*</b> On input, the size of the <i>packageName</i> buffer, in characters. On output, the size of
///                        the package name returned, in characters, including the null-terminator.
///    packageName = Type: <b>PWSTR</b> The package name.
///    packagePublisherIdLength = Type: <b>UINT32*</b> On input, the size of the <i>packagePublishId</i> buffer, in characters. On output, the size
///                               of the publisher ID returned, in characters, including the null-terminator.
///    packagePublisherId = Type: <b>PWSTR</b> The package publisher ID.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> One of the buffers is not large enough to hold the data. The required sizes are specified by
///    <i>packageNameLength</i> and <i>packagePublisherIdLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int PackageNameAndPublisherIdFromFamilyName(const(wchar)* packageFamilyName, uint* packageNameLength, 
                                            const(wchar)* packageName, uint* packagePublisherIdLength, 
                                            const(wchar)* packagePublisherId);

///Constructs an application user model ID from the <i>package family name</i> and the <i>package relative application
///ID</i> (PRAID).
///Params:
///    packageFamilyName = Type: <b>PCWSTR</b> The package family name.
///    packageRelativeApplicationId = Type: <b>PCWSTR</b> The package-relative app ID (PRAID).
///    applicationUserModelIdLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters (<b>WCHAR</b>s) in the app user
///                                   model ID string, which includes the null-terminator. First you pass <b>NULL</b> to <i>applicationUserModelId</i>
///                                   to get the number of characters. You use this number to allocate memory space for <i>applicationUserModelId</i>.
///                                   Then you pass the address of this memory space to fill <i>applicationUserModelId</i>.
///    applicationUserModelId = Type: <b>PWSTR</b> A pointer to memory space that receives the app user model ID string, which includes the
///                             null-terminator.
@DllImport("KERNEL32")
int FormatApplicationUserModelId(const(wchar)* packageFamilyName, const(wchar)* packageRelativeApplicationId, 
                                 uint* applicationUserModelIdLength, const(wchar)* applicationUserModelId);

///Deconstructs an application user model ID to its <i>package family name</i> and <i>package relative application
///ID</i> (PRAID).
///Params:
///    applicationUserModelId = Type: <b>PCWSTR</b> The app user model ID.
///    packageFamilyNameLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters (<b>WCHAR</b>s) in the package
///                              family name string, which includes the null-terminator. First you pass <b>NULL</b> to <i>packageFamilyName</i> to
///                              get the number of characters. You use this number to allocate memory space for <i>packageFamilyName</i>. Then you
///                              pass the address of this memory space to fill <i>packageFamilyName</i>.
///    packageFamilyName = Type: <b>PWSTR</b> A pointer to memory space that receives the package family name string, which includes the
///                        null-terminator.
///    packageRelativeApplicationIdLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters (<b>WCHAR</b>s) in the
///                                         package-relative app ID string, which includes the null-terminator. First you pass <b>NULL</b> to
///                                         <i>packageRelativeApplicationId</i> to get the number of characters. You use this number to allocate memory space
///                                         for <i>packageRelativeApplicationId</i>. Then you pass the address of this memory space to fill
///                                         <i>packageRelativeApplicationId</i>.
///    packageRelativeApplicationId = Type: <b>PWSTR</b> A pointer to memory space that receives the package-relative app ID (PRAID) string, which
///                                   includes the null-terminator.
@DllImport("KERNEL32")
int ParseApplicationUserModelId(const(wchar)* applicationUserModelId, uint* packageFamilyNameLength, 
                                const(wchar)* packageFamilyName, uint* packageRelativeApplicationIdLength, 
                                const(wchar)* packageRelativeApplicationId);

///Gets the packages with the specified family name for the current user.
///Params:
///    packageFamilyName = Type: <b>PCWSTR</b> The package family name.
///    count = Type: <b>UINT32*</b> A pointer to a variable that holds the number of package full names. First you pass
///            <b>NULL</b> to <i>packageFullNames</i> to get the number of package full names. You use this number to allocate
///            memory space for <i>packageFullNames</i>. Then you pass the address of this number to fill
///            <i>packageFullNames</i>.
///    packageFullNames = Type: <b>PWSTR*</b> A pointer to the strings of package full names.
///    bufferLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters in the string of package full
///                   names. First you pass <b>NULL</b> to <i>buffer</i> to get the number of characters. You use this number to
///                   allocate memory space for <i>buffer</i>. Then you pass the address of this number to fill <i>buffer</i>.
///    buffer = Type: <b>WCHAR*</b> The string of characters for all of the package full names.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> One or more buffer is not large enough to hold the data. The required size is specified by either
///    <i>count</i> or <i>buffer</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetPackagesByPackageFamily(const(wchar)* packageFamilyName, uint* count, char* packageFullNames, 
                               uint* bufferLength, char* buffer);

///Finds the packages with the specified family name for the current user.
///Params:
///    packageFamilyName = Type: <b>PCWSTR</b> The package family name.
///    packageFilters = Type: <b>UINT32</b> The package constants that specify how package information is retrieved. All package
///                     constants except <b>PACKAGE_FILTER_ALL_LOADED</b> are supported.
///    count = Type: <b>UINT32*</b> A pointer to a variable that holds the number of package full names that were found. First
///            you pass <b>NULL</b> to <i>packageFullNames</i> to get the number of package full names that were found. You use
///            this number to allocate memory space for <i>packageFullNames</i>. Then you pass the address of this memory space
///            to fill <i>packageFullNames</i>.
///    packageFullNames = Type: <b>PWSTR*</b> A pointer to memory space that receives the strings of package full names that were found.
///    bufferLength = Type: <b>UINT32*</b> A pointer to a variable that holds the number of characters in the string of package full
///                   names. First you pass <b>NULL</b> to <i>buffer</i> to get the number of characters. You use this number to
///                   allocate memory space for <i>buffer</i>. Then you pass the address of this memory space to fill <i>buffer</i>.
///    buffer = Type: <b>WCHAR*</b> A pointer to memory space that receives the string of characters for all of the package full
///             names.
///    packageProperties = Type: <b>UINT32*</b> A pointer to memory space that receives the package properties for all of the packages that
///                        were found.
@DllImport("KERNEL32")
int FindPackagesByPackageFamily(const(wchar)* packageFamilyName, uint packageFilters, uint* count, 
                                char* packageFullNames, uint* bufferLength, char* buffer, char* packageProperties);

///Gets the origin of the specified package.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of the package.
///    origin = Type: <b>PackageOrigin*</b> A pointer to a variable that receives a PackageOrigin-typed value that indicates the
///             origin of the package specified by <i>packageFullName</i>.
@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int GetStagedPackageOrigin(const(wchar)* packageFullName, PackageOrigin* origin);

///Gets the package information for the calling process.
///Params:
///    flags = Type: <b>const UINT32</b> The package constants that specify how package information is retrieved. The
///            <b>PACKAGE_FILTER_*</b> flags are supported.
///    bufferLength = Type: <b>UINT32*</b> On input, the size of <i>buffer</i>, in bytes. On output, the size of the array of
///                   structures returned, in bytes.
///    buffer = Type: <b>BYTE*</b> The package information, represented as an array of PACKAGE_INFO structures.
///    count = Type: <b>UINT32*</b> The number of structures in the buffer.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPMODEL_ERROR_NO_PACKAGE</b></dt> </dl> </td> <td
///    width="60%"> The process has no package identity. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is not large enough to hold the
///    data. The required size is specified by <i>bufferLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetCurrentPackageInfo(const(uint) flags, uint* bufferLength, char* buffer, uint* count);

///Opens the package information of the specified package.
///Params:
///    packageFullName = Type: <b>PCWSTR</b> The full name of the package.
///    reserved = Type: <b>const UINT32</b> Reserved; must be 0.
///    packageInfoReference = Type: <b>PACKAGE_INFO_REFERENCE*</b> A reference to package information.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The package is not installed for the current user. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int OpenPackageInfoByFullName(const(wchar)* packageFullName, const(uint) reserved, 
                              _PACKAGE_INFO_REFERENCE** packageInfoReference);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1")
int OpenPackageInfoByFullNameForUser(void* userSid, const(wchar)* packageFullName, const(uint) reserved, 
                                     _PACKAGE_INFO_REFERENCE** packageInfoReference);

///Closes a reference to the specified package information.
///Params:
///    packageInfoReference = Type: <b>PACKAGE_INFO_REFERENCE</b> A reference to package information.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code.
///    
@DllImport("KERNEL32")
int ClosePackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference);

///Gets the package information for the specified package.
///Params:
///    packageInfoReference = Type: <b>PACKAGE_INFO_REFERENCE</b> A reference to package information.
///    flags = Type: <b>const UINT32</b> The package constants that specify how package information is retrieved.
///    bufferLength = Type: <b>UINT32*</b> On input, the size of <i>buffer</i>, in bytes. On output, the size of the package
///                   information returned, in bytes.
///    buffer = Type: <b>BYTE*</b> The package information, represented as an array of PACKAGE_INFO structures.
///    count = Type: <b>UINT32*</b> The number of packages in the buffer.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>bufferLength</i>. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetPackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference, const(uint) flags, uint* bufferLength, 
                   char* buffer, uint* count);

///Gets the IDs of apps in the specified package.
///Params:
///    packageInfoReference = Type: <b>PACKAGE_INFO_REFERENCE</b> A reference to package information.
///    bufferLength = Type: <b>UINT32*</b> A pointer to a variable that holds the size of <i>buffer</i>, in bytes. First you pass
///                   <b>NULL</b> to <i>buffer</i> to get the required size of <i>buffer</i>. You use this number to allocate memory
///                   space for <i>buffer</i>. Then you pass the address of this memory space to fill <i>buffer</i>.
///    buffer = Type: <b>BYTE*</b> A pointer to memory space that receives the app IDs.
///    count = Type: <b>UINT32*</b> A pointer to a variable that receives the number of app IDs in <i>buffer</i>.
@DllImport("KERNEL32")
int GetPackageApplicationIds(_PACKAGE_INFO_REFERENCE* packageInfoReference, uint* bufferLength, char* buffer, 
                             uint* count);

///Retrieves a value indicating whether a process can be suspended/resumed by the Process Lifecycle Manager (PLM). You
///can use the value to decide whether to subscribe to relevant notifications from the PLM, or to register for a classic
///system suspend notification.
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyLifecycleManagement enumerated type. When the function returns
///             successfully, the variable contains an enumerated constant value indicating whether the identified process is
///             lifecycle-managed or not.
@DllImport("KERNEL32")
int AppPolicyGetLifecycleManagement(HANDLE processToken, AppPolicyLifecycleManagement* policy);

///Retrieves a value indicating whether a process uses a CoreWindow-based, or a HWND-based, windowing model. You can use
///the value to decide how to register for window state change notifications (size changed, visibility changed, etc.).
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyWindowingModel enumerated type. When the function returns successfully,
///             the variable contains an enumerated constant value indicating the windowing model of the identified process.
@DllImport("KERNEL32")
int AppPolicyGetWindowingModel(HANDLE processToken, AppPolicyWindowingModel* policy);

///Retrieves a value indicating whether a process’s policy allows it to load non-Windows (third-party) plugins. You
///can use the value to decide whether or not to allow non-Windows (third-party) plugins.
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyMediaFoundationCodecLoading enumerated type. When the function returns
///             successfully, the variable contains an enumerated constant value indicating the codec-loading policy of the
///             identified process.
@DllImport("KERNEL32")
int AppPolicyGetMediaFoundationCodecLoading(HANDLE processToken, AppPolicyMediaFoundationCodecLoading* policy);

///Retrieves a value indicating the application type of a process so that you can determine whether to enable private
///reflection and/or make managed objects agile.
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyClrCompat enumerated type. When the function returns successfully, the
///             variable contains an enumerated constant value indicating the application type of the identified process.
@DllImport("KERNEL32")
int AppPolicyGetClrCompat(HANDLE processToken, AppPolicyClrCompat* policy);

///Retrieves the kind of initialization that should be automatically performed for a process when beginthread[ex]
///creates a thread.
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyThreadInitializationType enumerated type. When the function returns
///             successfully, the variable contains a value indicating the kind of initialization that should be automatically
///             performed for the process when beginthread[ex] creates a thread.
@DllImport("KERNEL32")
int AppPolicyGetThreadInitializationType(HANDLE processToken, AppPolicyThreadInitializationType* policy);

///Retrieves the method used for a process to surface developer information, such as asserts, to the user.
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyShowDeveloperDiagnostic enumerated type. When the function returns
///             successfully, the variable contains a value indicating the method used for the process to surface developer
///             information, such as asserts, to the user.
@DllImport("KERNEL32")
int AppPolicyGetShowDeveloperDiagnostic(HANDLE processToken, AppPolicyShowDeveloperDiagnostic* policy);

///Retrieves the method used to end a process.
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyProcessTerminationMethod enumerated type. When the function returns
///             successfully, the variable contains a value indicating the method used to end the process.
@DllImport("KERNEL32")
int AppPolicyGetProcessTerminationMethod(HANDLE processToken, AppPolicyProcessTerminationMethod* policy);

///Retrieves a value indicating whether a process has full or restricted access to the IO devices (file, file stream,
///directory, physical disk, volume, console buffer, tape drive, communications resource, mailslot, and pipe).
///Params:
///    processToken = A handle that identifies the access token for a process.
///    policy = A pointer to a variable of the AppPolicyCreateFileAccess enumerated type. When the function returns successfully,
///             the variable contains an enumerated constant value indicating whether the process has full or restricted access
///             to the IO devices.
@DllImport("KERNEL32")
int AppPolicyGetCreateFileAccess(HANDLE processToken, AppPolicyCreateFileAccess* policy);

///Gets the package information for the specified package, with the option to specify the type of folder path to
///retrieve for the package.
///Params:
///    packageInfoReference = Type: <b>PACKAGE_INFO_REFERENCE</b> A reference to package information.
///    flags = Type: <b>const UINT32</b> The [package constants](/windows/desktop/appxpkg/package-constants) that specify how
///            package information is retrieved.
///    packagePathType = Type: [**PackagePathType**](ne-appmodel-packagepathtype.md) Indicates the type of folder path to retrieve for the
///                      package (the original install folder or the mutable folder).
///    bufferLength = Type: <b>UINT32*</b> On input, the size of <i>buffer</i>, in bytes. On output, the size of the package
///                   information returned, in bytes.
///    buffer = Type: <b>BYTE*</b> The package information, represented as an array of
///             [PACKAGE_INFO](./ns-appmodel-package_info.md) structures.
///    count = Type: <b>UINT32*</b> The number of packages in the buffer.
///Returns:
///    Type: <b>LONG</b> If the function succeeds it returns <b>ERROR_SUCCESS</b>. Otherwise, the function returns an
///    error code. The possible error codes include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is not large enough to hold the data. The required size is specified by
///    <i>bufferLength</i>. </td> </tr> </table>
///    
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

///Creates objects for reading and writing app packages.
@GUID("BEB94909-E451-438B-B5A7-D79E767B75D8")
interface IAppxFactory : IUnknown
{
    ///Creates a write-only package object to which files can be added.
    ///Params:
    ///    outputStream = Type: <b>IStream*</b> The output stream that receives the serialized package data. The stream must support at
    ///                   least the Write method.
    ///    settings = Type: <b>APPX_PACKAGE_SETTINGS*</b> The settings for the production of this package.
    ///    packageWriter = Type: <b>IAppxPackageWriter**</b> The package writer created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The specified <b>hashMethod</b> member of the APPX_PACKAGE_SETTINGS structure is not a valid
    ///    hash algorithm URI. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> ERROR_INVALID_PARAMETER</b></dt> </dl>
    ///    </td> <td width="60%"> The specified <b>hashMethod</b> member of the APPX_PACKAGE_SETTINGS structure is not a
    ///    valid hash algorithm URI. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NTE_BAD_ALGID</b></dt> </dl> </td>
    ///    <td width="60%"> The hash value is SHA1. </td> </tr> </table>
    ///    
    HRESULT CreatePackageWriter(IStream outputStream, APPX_PACKAGE_SETTINGS* settings, 
                                IAppxPackageWriter* packageWriter);
    ///Creates a read-only package reader from the contents provided by an IStream. This method does not validate the
    ///digital signature.
    ///Params:
    ///    inputStream = Type: <b>IStream*</b> The input stream that delivers the content of the package for reading. The stream must
    ///                  support Read, Seek, and Stat. If these methods fail, their error codes might be passed to and returned by
    ///                  this method.
    ///    packageReader = Type: <b>IAppxPackageReader**</b> A package reader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INTERLEAVING_NOT_ALLOWED</b></dt> </dl>
    ///    </td> <td width="60%"> The ZIP file delivered by <i>inputStream</i> is an interleaved OPC package. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_RELATIONSHIPS_NOT_ALLOWED</b></dt> </dl> </td> <td
    ///    width="60%"> The OPC package delivered by <i>inputStream</i> contains OPC package/part relationships. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_MISSING_REQUIRED_FILE</b></dt> </dl> </td> <td width="60%">
    ///    The OPC package delivered by <i>inputStream</i> does not have a manifest, or a block map, or a signature file
    ///    when a CI catalog is present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INVALID_MANIFEST</b></dt>
    ///    </dl> </td> <td width="60%"> The package manifest is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>APPX_E_INVALID_BLOCKMAP</b></dt> </dl> </td> <td width="60%"> The package block map is not valid, the
    ///    list of files in the ZIP central directory does not match the list of files in the block map, or the size of
    ///    files listed in the ZIP central directory does not match the file and block sizes listed in the block map.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreatePackageReader(IStream inputStream, IAppxPackageReader* packageReader);
    ///Creates a read-only manifest object model from contents provided by an IStream.
    ///Params:
    ///    inputStream = Type: <b>IStream*</b> The input stream that delivers the manifest XML for reading. The stream must support
    ///                  Read, Seek, and Stat. If these methods fail, their error codes might be passed to and returned by this
    ///                  method.
    ///    manifestReader = Type: <b>IAppxManifestReader**</b> The manifest reader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INVALID_MANIFEST</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>inputStream</i> does not contain syntactically valid XML for the manifest. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateManifestReader(IStream inputStream, IAppxManifestReader* manifestReader);
    ///Creates a read-only block map object model from contents provided by an IStream.
    ///Params:
    ///    inputStream = Type: <b>IStream*</b> The stream that delivers the block map XML for reading. The stream must support Read,
    ///                  Seek, and Stat. If these methods fail, their error codes might be passed to and returned by this method.
    ///    blockMapReader = Type: <b>IAppxBlockMapReader**</b> The block map reader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INVALID_BLOCKMAP</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>inputStream</i> does not contain syntactically valid XML for the block map. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateBlockMapReader(IStream inputStream, IAppxBlockMapReader* blockMapReader);
    ///Creates a read-only block map object model from contents provided by an IStream and a digital signature.
    ///Params:
    ///    blockMapStream = Type: <b>IStream*</b> The stream that delivers block map XML for reading. The stream must support Read, Seek,
    ///                     and Stat.
    ///    signatureFileName = Type: <b>LPCWSTR</b> The file that contains a digital signature used to validate the contents of the input
    ///                        stream.
    ///    blockMapReader = Type: <b>IAppxBlockMapReader**</b> The block map reader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those below. This method might return errors that are passed from the
    ///    underlying validation APIs that are used. For example, this method might return "Crypto and WinTrust error
    ///    codes (0x8009xxxx, 0x800bxxxx) if the signature can't be read, is invalid, or doesn't match the content of
    ///    <i>blockMapStream</i>. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>APPX_E_INVALID_BLOCKMAP</b></dt> </dl> </td> <td width="60%"> The <i>blockMapStream</i> does not
    ///    contain syntactically valid XML for the block map. </td> </tr> </table>
    ///    
    HRESULT CreateValidatedBlockMapReader(IStream blockMapStream, const(wchar)* signatureFileName, 
                                          IAppxBlockMapReader* blockMapReader);
}

///Creates objects for reading and writing app packages.
@GUID("F1346DF2-C282-4E22-B918-743A929A8D55")
interface IAppxFactory2 : IUnknown
{
    ///Creates an IAppxContentGroupMapReader.
    ///Params:
    ///    inputStream = The stream that delivers the content group map XML for reading.
    ///    contentGroupMapReader = The content group map reader.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateContentGroupMapReader(IStream inputStream, IAppxContentGroupMapReader* contentGroupMapReader);
    ///Creates an IAppxSourceContentGroupMapReader.
    ///Params:
    ///    inputStream = The stream that delivers the source content group map XML for reading.
    ///    reader = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateSourceContentGroupMapReader(IStream inputStream, IAppxSourceContentGroupMapReader* reader);
    ///Creates an IAppxContentGroupMapWriter.
    ///Params:
    ///    stream = The stream that receives the content group map.
    ///    contentGroupMapWriter = Provides a write-only object model for a content group map.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateContentGroupMapWriter(IStream stream, IAppxContentGroupMapWriter* contentGroupMapWriter);
}

///Provides a read-only object model for app packages.
@GUID("B5C49650-99BC-481C-9A34-3D53A4106708")
interface IAppxPackageReader : IUnknown
{
    ///Retrieves the block map object model of the package.
    ///Params:
    ///    blockMapReader = Type: <b>IAppxBlockMapReader**</b> The object model of the block map of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    ///Retrieves a footprint file from the package.
    ///Params:
    ///    type = Type: <b>APPX_FOOTPRINT_FILE_TYPE</b> The type of footprint file to be retrieved.
    ///    file = Type: <b>IAppxFile**</b> The file object that corresponds to the footprint file of <i>type</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>type</i> parameter is not a member of the APPX_FOOTPRINT_FILE_TYPE enumeration. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td
    ///    width="60%"> The package does not contain a footprint file of the specified type. GetFootprintFile can return
    ///    this error for APPX_FOOTPRINT_FILE_TYPE_SIGNATURE and APPX_FOOTPRINT_FILE_TYPE_CODEINTEGRITY types. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetFootprintFile(APPX_FOOTPRINT_FILE_TYPE type, IAppxFile* file);
    ///Retrieves a payload file from the package.
    ///Params:
    ///    fileName = Type: <b>LPCWSTR</b> The name of the payload file to be retrieved.
    ///    file = Type: <b>IAppxFile**</b> The file object that corresponds to <i>fileName</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> There is no payload
    ///    file with the specified file name. </td> </tr> </table>
    ///    
    HRESULT GetPayloadFile(const(wchar)* fileName, IAppxFile* file);
    ///Retrieves an enumerator that iterates through the payload files in the package.
    ///Params:
    ///    filesEnumerator = Type: <b>IAppxFilesEnumerator**</b> An enumerator over all payload files in the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPayloadFiles(IAppxFilesEnumerator* filesEnumerator);
    ///Retrieves the object model of the app manifest of the package.
    ///Params:
    ///    manifestReader = Type: <b>IAppxManifestReader**</b> The object model of the app manifest.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetManifest(IAppxManifestReader* manifestReader);
}

///Provides a write-only object model for app packages.
@GUID("9099E33B-246F-41E4-881A-008EB613F858")
interface IAppxPackageWriter : IUnknown
{
    ///Adds a new payload file to the app package.
    ///Params:
    ///    fileName = Type: <b>LPCWSTR</b> The name of the payload file. The file name path must be relative to the root of the
    ///               package.
    ///    contentType = Type: <b>LPCWSTR</b> The string specifying the content type of <i>fileName</i>.
    ///    compressionOption = Type: <b>APPX_COMPRESSION_OPTION</b> The type of compression to use to store <i>fileName</i> in the package.
    ///    inputStream = Type: <b>IStream*</b> An IStream providing the contents of <i>fileName</i>. The stream must support Read,
    ///                  Seek, and Stat.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. Error OPC codes, in addition to
    ///    OPC_E_DUPLICATE_PART may result. If the method fails, the package writer will close in a failed state and
    ///    can't be used any more. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> The compression option specified by
    ///    <i>compressionOption</i> is not one of the values of the APPX_COMPRESSION_OPTION enumeration. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOT_VALID_STATE </b></dt> </dl> </td> <td width="60%"> The writer is
    ///    closed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_NAME)</b></dt> </dl>
    ///    </td> <td width="60%"> The file name specified is not a valid file name or is a reserved name for a footprint
    ///    file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DUPLICATE_PART</b></dt> </dl> </td> <td
    ///    width="60%"> The file name specified is already in use in the package. </td> </tr> </table>
    ///    
    HRESULT AddPayloadFile(const(wchar)* fileName, const(wchar)* contentType, 
                           APPX_COMPRESSION_OPTION compressionOption, IStream inputStream);
    ///Writes footprint files at the end of the app package, and closes the package writer object's output stream.
    ///Params:
    ///    manifest = Type: <b>IStream*</b> The stream that provides the contents of the manifest for the package. The stream must
    ///               support Read, Seek, and Stat.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOT_VALID_STATE </b></dt> </dl> </td> <td
    ///    width="60%"> The writer is closed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>APPX_E_INVALID_MANIFEST</b></dt> </dl> </td> <td width="60%"> The input stream contains a manifest
    ///    that is not valid. </td> </tr> </table>
    ///    
    HRESULT Close(IStream manifest);
}

///Provides a write-only object model for app packages.
@GUID("2CF5C4FD-E54C-4EA5-BA4E-F8C4B105A8C8")
interface IAppxPackageWriter2 : IUnknown
{
    ///Closes the package writer object's output stream.
    ///Params:
    ///    manifest = The stream that provides the contents of the manifest for the package. The stream must support Read, Seek,
    ///               and Stat.
    ///    contentGroupMap = The stream that provides the contents of the content group map for the package.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that includes, but is not
    ///    limited to, those in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_NOT_VALID_STATE </b></dt> </dl> </td> <td width="60%"> The writer is closed.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INVALID_MANIFEST</b></dt> </dl> </td> <td width="60%">
    ///    The input stream contains a manifest that is not valid. </td> </tr> </table>
    ///    
    HRESULT Close(IStream manifest, IStream contentGroupMap);
}

///Provides a write-only object model for app packages.
@GUID("A83AACD3-41C0-4501-B8A3-74164F50B2FD")
interface IAppxPackageWriter3 : IUnknown
{
    ///Adds one or more payload files to an app package.
    ///Params:
    ///    fileCount = The number of payload files to be added to the app package.
    ///    payloadFiles = The payload files to be added.
    ///    memoryLimit = The memory limit in bytes.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT AddPayloadFiles(uint fileCount, char* payloadFiles, ulong memoryLimit);
}

///Retrieves information about a payload or footprint file in a package.
@GUID("91DF827B-94FD-468F-827B-57F41B2F6F2E")
interface IAppxFile : IUnknown
{
    ///Retrieves the compression option that is used to store the file in the package.
    ///Params:
    ///    compressionOption = Type: <b>APPX_COMPRESSION_OPTION*</b> A compression option that describes how the file is stored in the
    ///                        package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCompressionOption(APPX_COMPRESSION_OPTION* compressionOption);
    ///Retrieves the content type of the file.
    ///Params:
    ///    contentType = Type: <b>LPWSTR*</b> The content type of the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetContentType(ushort** contentType);
    ///Retrieves the name of the file, including its path relative to the package root directory.
    ///Params:
    ///    fileName = Type: <b>LPWSTR*</b> A string that contains the name and relative path of the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetName(ushort** fileName);
    ///Retrieves the uncompressed size of the file.
    ///Params:
    ///    size = Type: <b>UINT64*</b> The uncompressed size, in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSize(ulong* size);
    ///Gets a read-only stream that contains the uncompressed content of the file.
    ///Params:
    ///    stream = Type: <b>IStream**</b> A read-only stream that contains the uncompressed content of the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. [Fatal] OPC error codes (0x8051xxxx) if
    ///    the file’s local file header or data descriptor in the zip archive is invalid. This failure causes the
    ///    entire OPC zip consumer to enter an invalid state, no other file can be accessed from the IAppxPackageReader
    ///    object after this error occurs. HRESULT_FROM_WIN32(ERROR_CRC) (0x80070017) if the stream has been previously
    ///    read and its CRC was invalid. <b>Return value from the returned IStream’s Read and CopyTo methods</b>
    ///    [Fatal] HRESULT_FROM_WIN32(ERROR_CRC) (0x80070017) if the entire stream has been read and its CRC is found to
    ///    be invalid APPX_E_CORRUPT_CONTENT (0x80080206) if the file content can't be decompressed (due to corruption
    ///    of the zip file) HRESULT_FROM_WIN32(ERROR_INVALID_DATA) (0x8007000d) if a block in the file can't be read
    ///    completely or the size of the block is unexpected APPX_E_BLOCK_HASH_INVALID (0x80080207) if the content of
    ///    this file’s blocks is inconsistent with its hash in the block map
    ///    
    HRESULT GetStream(IStream* stream);
}

///Enumerates the payload files in a package.
@GUID("F007EEAF-9831-411C-9847-917CDC62D1FE")
interface IAppxFilesEnumerator : IUnknown
{
    ///Gets the payload file at the current position of the enumerator.
    ///Params:
    ///    file = Type: <b>IAppxFile**</b> The current payload file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxFile* file);
    ///Determines whether there is a payload file at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the current position references a payload file; <b>FALSE</b> if the
    ///                 enumerator has passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next payload file.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    Note that when the enumerator passes the end of the collection for the first time, <i>hasNext</i> =
    ///    <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns <b>E_BOUNDS</b> if
    ///    you subsequently call another MoveNext after you have already passed the end of the collection, and you have
    ///    previously received <i>hasNext</i> = <b>FALSE</b>.
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Represents a read-only object model for block maps that provides access to the file attributes and block hashes.
@GUID("5EFEC991-BCA3-42D1-9EC2-E92D609EC22A")
interface IAppxBlockMapReader : IUnknown
{
    ///Retrieves data corresponding to a file in the block map with the specified file name.
    ///Params:
    ///    filename = Type: <b>LPCWSTR</b> The name of the file.
    ///    file = Type: <b>IAppxBlockMapFile**</b> The data about the file's attributes and blocks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The specified file name
    ///    does not match the name of a file listed in the block map. </td> </tr> </table>
    ///    
    HRESULT GetFile(const(wchar)* filename, IAppxBlockMapFile* file);
    ///Retrieves an enumerator for traversing the files listed in the block map.
    ///Params:
    ///    enumerator = Type: <b>IAppxBlockMapFilesEnumerator**</b> The enumerator of all the files listed in the block map.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFiles(IAppxBlockMapFilesEnumerator* enumerator);
    ///Retrieves the URI for the hash algorithm used to create block hashes in the block map.
    ///Params:
    ///    hashMethod = Type: <b>IUri**</b> The hash algorithm used in this block map.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHashMethod(IUri* hashMethod);
    ///Retrieves a read-only stream that represents the XML content of the block map.
    ///Params:
    ///    blockMapStream = Type: <b>IStream**</b> A read-only stream that represents the XML content of the block map.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStream(IStream* blockMapStream);
}

///Represents a file in the block map.
@GUID("277672AC-4F63-42C1-8ABC-BEAE3600EB59")
interface IAppxBlockMapFile : IUnknown
{
    ///Retrieves an enumerator for traversing the blocks of a file listed in the block map.
    ///Params:
    ///    blocks = Type: <b>IAppxBlockMapBlocksEnumerator**</b> The enumerator for traversing the blocks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBlocks(IAppxBlockMapBlocksEnumerator* blocks);
    ///Retrieves the size of the zip local file header of the associated zip file item.
    ///Params:
    ///    lfhSize = Type: <b>UINT32*</b> In a valid app package, <i>lfhSize</i> corresponds to the size of the zip local file
    ///              header of the associated zip file item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocalFileHeaderSize(uint* lfhSize);
    ///Retrieves the name of the associated zip file item.
    ///Params:
    ///    name = Type: <b>LPWSTR*</b> In a valid app package, <i>name</i> corresponds to the name of the associated zip file
    ///           item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetName(ushort** name);
    ///Retrieves the uncompressed size of the associated zip file item.
    ///Params:
    ///    size = Type: <b>UINT64*</b> In a valid app package, <i>size</i> is the uncompressed size of the associated zip file
    ///           item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetUncompressedSize(ulong* size);
    ///Validates the content of a file against the hashes stored in the block elements for this block map file.
    ///Params:
    ///    fileStream = Type: <b>IStream*</b> The stream that contains the file's contents. The stream must support Read, Seek, and
    ///                 Stat. If these methods fail, their error codes might be passed to and returned by this method.
    ///    isValid = Type: <b>BOOL*</b> <b>TRUE</b> if the file hash validates; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ValidateFileHash(IStream fileStream, int* isValid);
}

///Enumerates the files from a block map.
@GUID("02B856A2-4262-4070-BACB-1A8CBBC42305")
interface IAppxBlockMapFilesEnumerator : IUnknown
{
    ///Gets the file at the current position of the enumerator.
    ///Params:
    ///    file = Type: <b>IAppxBlockMapFile**</b> The current file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxBlockMapFile* file);
    ///Determines whether there is a file at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the
    ///                 enumerator has passed the last item in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next file.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///                 passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    Note that when the enumerator passes the end of the collection for the first time, <i>hasNext</i> =
    ///    <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns <b>E_BOUNDS</b> if
    ///    you subsequently call another MoveNext after you have already passed the end of the collection, and you have
    ///    previously received <i>hasNext</i> = <b>FALSE</b>.
    ///    
    HRESULT MoveNext(int* hasCurrent);
}

///The <b>IAppxBlockMapBlock</b> interface provides a read-only object that represents an individual block within a file
///contained in the block map file (AppxBlockMap.xml) for the App package. The IAppxBlockMapFile::GetBlocks method is
///used to return an enumerator for traversing and retrieving the individual blocks of a file listed in the package
///block map.
@GUID("75CF3930-3244-4FE0-A8C8-E0BCB270B889")
interface IAppxBlockMapBlock : IUnknown
{
    ///Retrieves the hash value of the block.
    ///Params:
    ///    bufferSize = Type: <b>UINT32*</b> The length of <i>buffer</i>.
    ///    buffer = Type: <b>BYTE**</b> The byte sequence representing the hash value of the block.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHash(uint* bufferSize, char* buffer);
    ///Retrieves compressed size of the block.
    ///Params:
    ///    size = Type: <b>UINT32*</b> The compressed size of the block, in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCompressedSize(uint* size);
}

///Enumerates the blocks from a block map in a single file.
@GUID("6B429B5B-36EF-479E-B9EB-0C1482B49E16")
interface IAppxBlockMapBlocksEnumerator : IUnknown
{
    ///Gets the block at the current position of the enumerator.
    ///Params:
    ///    block = Type: <b>IAppxBlockMapBlock**</b> The current block.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxBlockMapBlock* block);
    ///Determines whether there is a block at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the
    ///                 enumerator has passed the last item in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next block.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    Note that when the enumerator passes the end of the collection for the first time, <i>hasNext</i> =
    ///    <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns <b>E_BOUNDS</b> if
    ///    you subsequently call another MoveNext after you have already passed the end of the collection, and you have
    ///    previously received <i>hasNext</i> = <b>FALSE</b>.
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Represents an object model of the package manifest that provides methods to access manifest elements and attributes.
@GUID("4E1BD148-55A0-4480-A3D1-15544710637C")
interface IAppxManifestReader : IUnknown
{
    ///Gets the package identifier defined in the manifest.
    ///Params:
    ///    packageId = Type: <b>IAppxManifestPackageId**</b> The package identifier.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    ///Gets the properties of the package as defined in the manifest.
    ///Params:
    ///    packageProperties = Type: <b>IAppxManifestProperties**</b> Properties of the package as described by the manifest.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetProperties(IAppxManifestProperties* packageProperties);
    ///Gets an enumerator that iterates through dependencies defined in the manifest.
    ///Params:
    ///    dependencies = Type: <b>IAppxManifestPackageDependenciesEnumerator**</b> The enumerator that iterates through the
    ///                   dependencies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageDependencies(IAppxManifestPackageDependenciesEnumerator* dependencies);
    ///Gets the list of capabilities requested by the package.
    ///Params:
    ///    capabilities = Type: <b>APPX_CAPABILITIES*</b> The list of capabilities requested by the package. This is a bitwise
    ///                   combination of the values of the enumeration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCapabilities(APPX_CAPABILITIES* capabilities);
    ///Gets an enumerator that iterates through the resources defined in the manifest.
    ///Params:
    ///    resources = Type: <b>IAppxManifestResourcesEnumerator**</b> The enumerator that iterates through the resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetResources(IAppxManifestResourcesEnumerator* resources);
    ///Gets an enumerator that iterates through the device capabilities defined in the manifest.
    ///Params:
    ///    deviceCapabilities = Type: <b>IAppxManifestDeviceCapabilitiesEnumerator**</b> The enumerator that iterates through the device
    ///                         capabilities.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDeviceCapabilities(IAppxManifestDeviceCapabilitiesEnumerator* deviceCapabilities);
    ///Gets the specified prerequisite as defined in the package manifest.
    ///Params:
    ///    name = Type: <b>LPCWSTR</b> The name of the prerequisite, either "OSMinVersion" or "OSMaxVersionTested".
    ///    value = Type: <b>UINT64*</b> The specified prerequisite. In the manifest the dot-trio representation is
    ///            Major.Minor.AppPlatform. This is converted to the 64-bit value as the follows: The highest order word
    ///            contains the Major version. The next word contains the Minor version. The next word contains the optional
    ///            AppPlatform version, if specified.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The prerequisite defined in <i>name</i> is not defined in the manifest. </td> </tr> </table>
    ///    
    HRESULT GetPrerequisite(const(wchar)* name, ulong* value);
    ///Gets an enumerator that iterates through the applications defined in the manifest.
    ///Params:
    ///    applications = Type: <b>IAppxManifestApplicationsEnumerator**</b> The enumerator that iterates through the applications.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetApplications(IAppxManifestApplicationsEnumerator* applications);
    ///Gets the raw XML parsed and read by the manifest reader.
    ///Params:
    ///    manifestStream = Type: <b>IStream**</b> The read-only stream that represents the XML content of the manifest.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStream(IStream* manifestStream);
}

///Represents an object model of the package manifest that provides methods to access manifest elements and attributes.
@GUID("D06F67BC-B31D-4EBA-A8AF-638E73E77B4D")
interface IAppxManifestReader2 : IAppxManifestReader
{
    ///Gets an enumerator that iterates through the qualified resources that are defined in the manifest.
    ///Params:
    ///    resources = Type: <b>IAppxManifestQualifiedResourcesEnumerator**</b> The enumerator that iterates through the qualified
    ///                resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
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

///Represents an object model of the package manifest that provides methods to access manifest elements and attributes.
@GUID("8D7AE132-A690-4C00-B75A-6AAE1FEAAC80")
interface IAppxManifestReader5 : IUnknown
{
    ///Gets a main package dependencies enumerator.
    ///Params:
    ///    mainPackageDependencies = The main package dependencies enumerator.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMainPackageDependencies(IAppxManifestMainPackageDependenciesEnumerator* mainPackageDependencies);
}

///Represents an object model of the package manifest that provides methods to access manifest elements and attributes.
@GUID("34DEACA4-D3C0-4E3E-B312-E42625E3807E")
interface IAppxManifestReader6 : IUnknown
{
    ///Queries whether an app package is a non-qualified resource package.
    ///Params:
    ///    isNonQualifiedResourcePackage = True if the package is a non-qualified resource package, False otherwise.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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

///Provides access to attribute values of the optional package information.
@GUID("2634847D-5B5D-4FE5-A243-002FF95EDC7E")
interface IAppxManifestOptionalPackageInfo : IUnknown
{
    ///Determines whether the package is optional.
    ///Params:
    ///    isOptionalPackage = True if the package is optional, false otherwise.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIsOptionalPackage(int* isOptionalPackage);
    ///Gets the main package name from the optional package.
    ///Params:
    ///    mainPackageName = The main package name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMainPackageName(ushort** mainPackageName);
}

///Enumerates &lt;MainPackageDependency&gt; elements from an app manifest.
@GUID("A99C4F00-51D2-4F0F-BA46-7ED5255EBDFF")
interface IAppxManifestMainPackageDependenciesEnumerator : IUnknown
{
    ///Gets the &lt;MainPackageDependency&gt; element at the current position of the enumerator.
    ///Params:
    ///    mainPackageDependency = The current &lt;MainPackageDependency&gt; element.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that includes, but is not
    ///    limited to, those in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%"> The enumerator has passed the
    ///    last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxManifestMainPackageDependency* mainPackageDependency);
    ///Determines whether there is a &lt;MainPackageDependency&gt; element at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the enumerator has
    ///                 passed the last item in the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next &lt;MainPackageDependency&gt; element.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    <div class="alert"><b>Note</b> When the enumerator passes the end of the collection for the first time,
    ///    <i>hasNext</i> = <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns
    ///    <b>E_BOUNDS</b> if you subsequently call another MoveNext after you have already passed the end of the
    ///    collection, and you have previously received <i>hasNext</i> = <b>FALSE</b>.</div> <div> </div>
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Provides access to attribute values of the main package dependency.
@GUID("05D0611C-BC29-46D5-97E2-84B9C79BD8AE")
interface IAppxManifestMainPackageDependency : IUnknown
{
    ///Gets the name of the main package dependency from the AppxManifest.xml.
    ///Params:
    ///    name = The name of the main package dependency.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetName(ushort** name);
    ///Gets the publisher of the main package dependency from the AppxManifest.xml.
    ///Params:
    ///    publisher = The publisher of the main package dependency.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPublisher(ushort** publisher);
    ///Gets the package family name of the main package dependency from the AppxManifest.xml.
    ///Params:
    ///    packageFamilyName = The package family name of the main package dependency.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageFamilyName(ushort** packageFamilyName);
}

///Provides access to the package identity.
@GUID("283CE2D7-7153-4A91-9649-7A0F7240945F")
interface IAppxManifestPackageId : IUnknown
{
    ///Gets the name of the package as defined in the manifest.
    ///Params:
    ///    name = Type: <b>LPWSTR*</b> The name of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetName(ushort** name);
    ///Gets the processor architecture as defined in the manifest.
    ///Params:
    ///    architecture = Type: <b>APPX_PACKAGE_ARCHITECTURE*</b> The architecture specified for the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetArchitecture(APPX_PACKAGE_ARCHITECTURE* architecture);
    ///Gets the name of the package publisher as defined in the manifest.
    ///Params:
    ///    publisher = Type: <b>LPWSTR*</b> The publisher of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetPublisher(ushort** publisher);
    ///Gets the version of the package as defined in the manifest.
    ///Params:
    ///    packageVersion = Type: <b>UINT64*</b> The version of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetVersion(ulong* packageVersion);
    ///Gets the package resource identifier as defined in the manifest.
    ///Params:
    ///    resourceId = Type: <b>LPWSTR*</b> The resource identifier of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetResourceId(ushort** resourceId);
    ///Compares the specified publisher with the publisher defined in the manifest.
    ///Params:
    ///    other = Type: <b>LPCWSTR</b> The publisher name to be compared.
    ///    isSame = Type: <b>BOOL*</b> <b>TRUE</b> if the specified publisher matches the package publisher; <b>FALSE</b>
    ///             otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT ComparePublisher(const(wchar)* other, int* isSame);
    ///Gets the package full name.
    ///Params:
    ///    packageFullName = Type: <b>LPWSTR*</b> The package full name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetPackageFullName(ushort** packageFullName);
    ///Gets the package family name.
    ///Params:
    ///    packageFamilyName = Type: <b>LPWSTR*</b> The package family name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetPackageFamilyName(ushort** packageFamilyName);
}

///Provides access to the app package identity.
@GUID("2256999D-D617-42F1-880E-0BA4542319D5")
interface IAppxManifestPackageId2 : IAppxManifestPackageId
{
    ///Gets the processor architecture as defined in the manifest.
    ///Params:
    ///    architecture = Type: <b>APPX_PACKAGE_ARCHITECTURE2*</b> The architecture specified for the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetArchitecture2(APPX_PACKAGE_ARCHITECTURE2* architecture);
}

///Provides read-only access to the properties section of a package manifest.
@GUID("03FAF64D-F26F-4B2C-AAF7-8FE7789B8BCA")
interface IAppxManifestProperties : IUnknown
{
    ///Gets the value of the specified Boolean element in the properties section.
    ///Params:
    ///    name = Type: <b>LPCWSTR</b> The name of the Boolean element. Valid values include: <p class="indent">"Framework" <p
    ///           class="indent">"ResourcePackage" for Windows 8.1 and later
    ///    value = Type: <b>BOOL*</b> The value of the specified Boolean element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBoolValue(const(wchar)* name, int* value);
    ///Gets the value of the specified string element in the properties section.
    ///Params:
    ///    name = Type: <b>LPCWSTR</b> The name of the string element. Valid values include: <p class="indent">"Description" <p
    ///           class="indent">"DisplayName" <p class="indent">"Logo" <p class="indent">"PublisherDisplayName"
    ///    value = Type: <b>LPWSTR*</b> The value of the specified element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStringValue(const(wchar)* name, ushort** value);
}

@GUID("36537F36-27A4-4788-88C0-733819575017")
interface IAppxManifestTargetDeviceFamiliesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestTargetDeviceFamily* targetDeviceFamily);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

///Retrieves information about the target device family from the AppxManifest.xml.
@GUID("9091B09B-C8D5-4F31-8687-A338259FAEFB")
interface IAppxManifestTargetDeviceFamily : IUnknown
{
    ///Gets the name of the target device family from the AppxManifest.xml..
    ///Params:
    ///    name = The target device family name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetName(ushort** name);
    ///Gets the minimum version of the target device family from the AppxManifest.xml.
    ///Params:
    ///    minVersion = The minimum version.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMinVersion(ulong* minVersion);
    ///Gets the maximum version tested from the AppxManifest.xml.
    ///Params:
    ///    maxVersionTested = The max version tested attribute.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMaxVersionTested(ulong* maxVersionTested);
}

///Enumerates the package dependencies defined in the package manifest.
@GUID("B43BBCF9-65A6-42DD-BAC0-8C6741E7F5A4")
interface IAppxManifestPackageDependenciesEnumerator : IUnknown
{
    ///Gets the dependency package at the current position of the enumerator.
    ///Params:
    ///    dependency = Type: <b>IAppxManifestPackageDependency**</b> The current dependency package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxManifestPackageDependency* dependency);
    ///Determines whether there is a package dependency at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the
    ///                 enumerator has passed the last item in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next package dependency.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    Note that when the enumerator passes the end of the collection for the first time, <i>hasNext</i> =
    ///    <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns <b>E_BOUNDS</b> if
    ///    you subsequently call another MoveNext after you have already passed the end of the collection, and you have
    ///    previously received <i>hasNext</i> = <b>FALSE</b>.
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Describes the dependency of one package on another package.
@GUID("E4946B59-733E-43F0-A724-3BDE4C1285A0")
interface IAppxManifestPackageDependency : IUnknown
{
    ///Gets the name of the package on which the current package has a dependency.
    ///Params:
    ///    name = Type: <b>LPWSTR*</b> The name of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetName(ushort** name);
    ///Gets the name of the publisher that produced the package on which the current package depends.
    ///Params:
    ///    publisher = Type: <b>LPWSTR*</b> The name of the publisher.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPublisher(ushort** publisher);
    ///Gets the minimum version of the package on which the current package has a dependency.
    ///Params:
    ///    minVersion = Type: <b>UINT64*</b> The minimum version of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMinVersion(ulong* minVersion);
}

///Describes the dependency of one package on another package.
@GUID("DDA0B713-F3FF-49D3-898A-2786780C5D98")
interface IAppxManifestPackageDependency2 : IAppxManifestPackageDependency
{
    ///Returns the maximum major version number of the package that is tested to be compatible with the current package.
    ///Params:
    ///    maxMajorVersionTested = The maximum major version number of the dependency package that has been tested to be compatible with the
    ///                            current package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMaxMajorVersionTested(ushort* maxMajorVersionTested);
}

@GUID("1AC56374-6198-4D6B-92E4-749D5AB8A895")
interface IAppxManifestPackageDependency3 : IUnknown
{
    HRESULT GetIsOptional(int* isOptional);
}

///Enumerates the resources defined in the package manifest.
@GUID("DE4DFBBD-881A-48BB-858C-D6F2BAEAE6ED")
interface IAppxManifestResourcesEnumerator : IUnknown
{
    ///Gets the resource at the current position of the enumerator.
    ///Params:
    ///    resource = Type: <b>LPWSTR*</b> The current resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(ushort** resource);
    ///Determines whether there is a resource at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the
    ///                 enumerator has passed the last item in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next resource.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    Note that when the enumerator passes the end of the collection for the first time, <i>hasNext</i> =
    ///    <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns <b>E_BOUNDS</b> if
    ///    you subsequently call another MoveNext after you have already passed the end of the collection, and you have
    ///    previously received <i>hasNext</i> = <b>FALSE</b>.
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Enumerates the device capabilities defined in the package manifest.
@GUID("30204541-427B-4A1C-BACF-655BF463A540")
interface IAppxManifestDeviceCapabilitiesEnumerator : IUnknown
{
    ///Gets the device capability at the current position of the enumerator.
    ///Params:
    ///    deviceCapability = Type: <b>LPWSTR*</b> The current device capability.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(ushort** deviceCapability);
    ///Determines whether there is a device capability at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the
    ///                 enumerator has passed the last item in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next device capability.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    Note that when the enumerator passes the end of the collection for the first time, <i>hasNext</i> =
    ///    <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns <b>E_BOUNDS</b> if
    ///    you subsequently call another MoveNext after you have already passed the end of the collection, and you have
    ///    previously received <i>hasNext</i> = <b>FALSE</b>.
    ///    
    HRESULT MoveNext(int* hasNext);
}

@GUID("11D22258-F470-42C1-B291-8361C5437E41")
interface IAppxManifestCapabilitiesEnumerator : IUnknown
{
    HRESULT GetCurrent(ushort** capability);
    HRESULT GetHasCurrent(int* hasCurrent);
    HRESULT MoveNext(int* hasNext);
}

///Enumerates the applications defined in the package manifest.
@GUID("9EB8A55A-F04B-4D0D-808D-686185D4847A")
interface IAppxManifestApplicationsEnumerator : IUnknown
{
    ///Gets the application at the current position of the enumerator.
    ///Params:
    ///    application = Type: <b>IAppxManifestApplication**</b> The current application.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxManifestApplication* application);
    ///Determines whether there is an application at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the
    ///                 enumerator has passed the last item in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next application.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    Note that when the enumerator passes the end of the collection for the first time, <i>hasNext</i> =
    ///    <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns <b>E_BOUNDS</b> if
    ///    you subsequently call another <b>MoveNext</b> after you have already passed the end of the collection, and
    ///    you have previously received <i>hasNext</i> = <b>FALSE</b>.
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Provides access to attribute values of the application.
@GUID("5DA89BF4-3773-46BE-B650-7E744863B7E8")
interface IAppxManifestApplication : IUnknown
{
    ///Gets the string value of an element or attribute in the application metadata section of the manifest.
    ///Params:
    ///    name = Type: <b>LPCWSTR</b> The name of the element or attribute value to get from the application metadata.
    ///           Supported names include: * AppListEntry * BackgroundColor * DefaultSize * Description * DisplayName *
    ///           EntryPoint * Executable * ForegroundText * ID * LockScreenLogo * LockScreenNotification * Logo * MinWidth *
    ///           ShortName * SmallLogo * Square150x150Logo * Square30x30Logo * Square310x310Logo * Square44x44Logo *
    ///           Square70x70Logo * Square71x71Logo * StartPage * Tall150x310Logo * VisualGroup * WideLogo * Wide310x150Logo
    ///           Refer to the [schema](/uwp/schemas/appxpackage/uapmanifestschema/schema-root) to determine where these values
    ///           are being read from in the manifest.
    ///    value = Type: <b>LPWSTR*</b> The value of the requested element or attribute.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error
    ///    code.
    ///    
    HRESULT GetStringValue(const(wchar)* name, ushort** value);
    ///Gets the application user model identifier.
    ///Params:
    ///    appUserModelId = Type: <b>LPWSTR*</b> The user model identifier.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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

///Creates objects for reading and writing bundle packages.
@GUID("BBA65864-965F-4A5F-855F-F074BDBF3A7B")
interface IAppxBundleFactory : IUnknown
{
    ///Creates a write-only bundle object to which app packages can be added.
    ///Params:
    ///    outputStream = Type: <b>IStream*</b> The output stream that receives the serialized package data. The stream must support at
    ///                   least the Write method.
    ///    bundleVersion = Type: <b>UINT64</b> The version number of the bundle. If set to 0, <b>CreateBundleWriter</b> sets the version
    ///                    number of the bundle to a value derived from the current system time. We recommend passing 0 so version
    ///                    numbers are automatically generated and each successive call generates a higher version number. For example,
    ///                    if you call <b>CreateBundleWriter</b> on 2013/12/23 3:45:00 AM UTC with <i>bundleVersion</i> set to 0, the
    ///                    version number of the bundle becomes 2013.1223.0345.0000.
    ///    bundleWriter = Type: <b>IAppxBundleWriter**</b> The bundle writer created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table.
    ///    
    HRESULT CreateBundleWriter(IStream outputStream, ulong bundleVersion, IAppxBundleWriter* bundleWriter);
    ///Creates a read-only bundle object that reads its contents from an IStream object.
    ///Params:
    ///    inputStream = Type: <b>IStream*</b> The input stream that delivers the content of the package for reading. The stream must
    ///                  support Read, Seek, and Stat. If these methods fail, their error codes might be passed to and returned by
    ///                  this method.
    ///    bundleReader = Type: <b>IAppxBundleReader**</b> A bundle reader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INTERLEAVING_NOT_ALLOWED</b></dt> </dl>
    ///    </td> <td width="60%"> The ZIP file delivered by <i>inputStream</i> is an interleaved OPC package. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_RELATIONSHIPS_NOT_ALLOWED</b></dt> </dl> </td> <td
    ///    width="60%"> The OPC package delivered by <i>inputStream</i> contains OPC package/part relationships. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_MISSING_REQUIRED_FILE</b></dt> </dl> </td> <td width="60%">
    ///    The OPC package delivered by <i>inputStream</i> does not have a manifest, or a block map, or a signature file
    ///    when a CI catalog is present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INVALID_MANIFEST</b></dt>
    ///    </dl> </td> <td width="60%"> The bundle manifest is not valid. </td> </tr> </table>
    ///    
    HRESULT CreateBundleReader(IStream inputStream, IAppxBundleReader* bundleReader);
    ///Creates a read-only bundle manifest object from a standalone stream to AppxBundleManifest.xml.
    ///Params:
    ///    inputStream = Type: <b>IStream*</b> The input stream that delivers the manifest XML for reading. The stream must support
    ///                  Read, Seek, and Stat. If these methods fail, their error codes might be passed to and returned by this
    ///                  method.
    ///    manifestReader = Type: <b>IAppxBundleManifestReader**</b> The manifest reader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>APPX_E_INVALID_MANIFEST</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>inputStream</i> does not contain syntactically valid XML for the manifest. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateBundleManifestReader(IStream inputStream, IAppxBundleManifestReader* manifestReader);
}

///Provides a write-only object model for bundle packages.
@GUID("EC446FE8-BFEC-4C64-AB4F-49F038F0C6D2")
interface IAppxBundleWriter : IUnknown
{
    ///Adds a new app package to the bundle.
    ///Params:
    ///    fileName = Type: <b>LPCWSTR</b> The name of the payload file. The file name path must be relative to the root of the
    ///               package.
    ///    packageStream = Type: <b>IStream*</b> An IStream that provides the contents of <i>fileName</i>. The stream must support Read,
    ///                    Seek, and Stat.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. Error OPC codes, in addition to
    ///    OPC_E_DUPLICATE_PART may result. If the method fails, the bundle writer will close in a failed state and
    ///    can't be used any more. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_NOT_VALID_STATE </b></dt> </dl> </td> <td width="60%"> The writer is closed. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_NAME)</b></dt> </dl> </td> <td width="60%"> The
    ///    file name specified is not a valid file name or is a reserved name for a footprint file. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_DUPLICATE_PART</b></dt> </dl> </td> <td width="60%"> The file name specified
    ///    is already in use in the bundle. </td> </tr> </table>
    ///    
    HRESULT AddPayloadPackage(const(wchar)* fileName, IStream packageStream);
    ///Finalizes the bundle package by writing footprint files at the end of the package, and closes the writer’s
    ///output stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOT_VALID_STATE </b></dt> </dl> </td> <td
    ///    width="60%"> The writer is closed. </td> </tr> </table>
    ///    
    HRESULT Close();
}

///Provides a write-only object model for bundle packages.
@GUID("6D8FE971-01CC-49A0-B685-233851279962")
interface IAppxBundleWriter2 : IUnknown
{
    ///Adds a reference to an external package to the package bundle.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    inputStream = An IStream that provides the contents of <i>fileName</i>. The stream must support Read, Seek, and Stat.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream);
}

///Provides a write-only object model for bundle packages.
@GUID("AD711152-F969-4193-82D5-9DDF2786D21A")
interface IAppxBundleWriter3 : IUnknown
{
    ///Adds a reference to an optional app package or a payload file within an app bundle.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    inputStream = An IStream that provides the contents of <i>fileName</i>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPackageReference(const(wchar)* fileName, IStream inputStream);
    ///Finalizes the bundle package by writing footprint files at the end of the package, and closes the writer’s
    ///output stream.
    ///Params:
    ///    hashMethodString = The string value of the <b>HashMethod</b> attribute of the BlockMap root element.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Close(const(wchar)* hashMethodString);
}

///Provides a write-only object model for bundle packages.
@GUID("9CD9D523-5009-4C01-9882-DC029FBD47A3")
interface IAppxBundleWriter4 : IUnknown
{
    ///Adds a new app package to the bundle.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    packageStream = An IStream that provides the contents of <i>fileName</i>.
    ///    isDefaultApplicablePackage = A flag for whether this package is a default applicable package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPayloadPackage(const(wchar)* fileName, IStream packageStream, BOOL isDefaultApplicablePackage);
    ///Adds a reference to an optional app package or a payload file within an app bundle.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    inputStream = An IStream that provides the contents of <i>fileName</i>.
    ///    isDefaultApplicablePackage = A flag for whether this package is a default applicable package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPackageReference(const(wchar)* fileName, IStream inputStream, BOOL isDefaultApplicablePackage);
    ///Adds a reference within the package bundle to an external app package.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    inputStream = An IStream that provides the contents of <i>fileName</i>.
    ///    isDefaultApplicablePackage = A flag for whether this package is a default applicable package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream, 
                                        BOOL isDefaultApplicablePackage);
}

///Provides a read-only object model for bundle packages.
@GUID("DD75B8C0-BA76-43B0-AE0F-68656A1DC5C8")
interface IAppxBundleReader : IUnknown
{
    ///Retrieves the specified type of footprint file from the bundle.
    ///Params:
    ///    fileType = Type: <b>APPX_BUNDLE_FOOTPRINT_FILE_TYPE</b> The type of footprint file to be retrieved.
    ///    footprintFile = Type: <b>IAppxFile**</b> The file object that corresponds to the footprint file of <i>fileType</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>fileType</i> parameter is not a valid value in the APPX_BUNDLE_FOOTPRINT_FILE_TYPE
    ///    enumeration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt>
    ///    </dl> </td> <td width="60%"> The bundle doesn't contain a footprint file of the specified type.
    ///    GetFootprintFile can return this error for the APPX_BUNDLE_FOOTPRINT_FILE_TYPE_SIGNATURE type. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFootprintFile(APPX_BUNDLE_FOOTPRINT_FILE_TYPE fileType, IAppxFile* footprintFile);
    ///Retrieves a read-only block map object from the bundle.
    ///Params:
    ///    blockMapReader = Type: <b>IAppxBlockMapReader**</b> The object model of the block map of a package in the bundle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    ///Retrieves a read-only manifest object from the bundle.
    ///Params:
    ///    manifestReader = Type: <b>IAppxBundleManifestReader**</b> The object model of the bundle manifest.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetManifest(IAppxBundleManifestReader* manifestReader);
    ///Retrieves an enumerator that iterates over the list of all payload packages in the bundle.
    ///Params:
    ///    payloadPackages = Type: <b>IAppxFilesEnumerator**</b> An enumerator over all payload packages in the bundle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPayloadPackages(IAppxFilesEnumerator* payloadPackages);
    ///Retrieves an appx file object for the payload package with the specified file name.
    ///Params:
    ///    fileName = Type: <b>LPCWSTR</b> The name of the payload file to be retrieved.
    ///    payloadPackage = Type: <b>IAppxFile**</b> The payload file object the that corresponds to <i>fileName</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> There is no payload
    ///    file with the specified file name. </td> </tr> </table>
    ///    
    HRESULT GetPayloadPackage(const(wchar)* fileName, IAppxFile* payloadPackage);
}

///Provides a read-only object model for manifests of bundle packages.
@GUID("CF0EBBC1-CC99-4106-91EB-E67462E04FB0")
interface IAppxBundleManifestReader : IUnknown
{
    ///Retrieves an object that represents the &lt;Identity&gt; element under the root &lt;Bundle&gt; element.
    ///Params:
    ///    packageId = Type: <b>IAppxManifestPackageId**</b> The package identifier.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    ///Retrieves an enumerator over all the &lt;Package&gt; elements under the &lt;Packages&gt; element.
    ///Params:
    ///    packageInfoItems = Type: <b>IAppxBundleManifestPackageInfoEnumerator**</b> An enumerator over all payload packages in a
    ///                       &lt;Packages&gt; element of a bundle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
    ///Gets the raw XML document without any preprocessing.
    ///Params:
    ///    manifestStream = Type: <b>IStream**</b> The read-only stream that represents the XML content of the manifest.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStream(IStream* manifestStream);
}

///Provides a read-only object model for manifests of bundle packages.
@GUID("5517DF70-033F-4AF2-8213-87D766805C02")
interface IAppxBundleManifestReader2 : IUnknown
{
    ///Retrieves an object that represents the &lt;OptionalBundles&gt; element under the root &lt;Bundle&gt; element.
    ///Params:
    ///    optionalBundles = The optional bundle.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetOptionalBundles(IAppxBundleManifestOptionalBundleInfoEnumerator* optionalBundles);
}

///Provides a read-only object model for the list of payload packages that are described in a bundle package manifest.
@GUID("F9B856EE-49A6-4E19-B2B0-6A2406D63A32")
interface IAppxBundleManifestPackageInfoEnumerator : IUnknown
{
    ///Gets the &lt;Package&gt; element at the current position of the enumerator.
    ///Params:
    ///    packageInfo = Type: <b>IAppxBundleManifestPackageInfo**</b> The current &lt;Package&gt; element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that
    ///    includes, but is not limited to, those in the following table. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator has passed the last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxBundleManifestPackageInfo* packageInfo);
    ///Determines whether there are more elements in the enumerator.
    ///Params:
    ///    hasCurrent = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the
    ///                 enumerator has passed the last item in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next &lt;Package&gt; element.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    <div class="alert"><b>Note</b> When the enumerator passes the end of the collection for the first time,
    ///    <i>hasNext</i> = <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns
    ///    <b>E_BOUNDS</b> if you subsequently call another MoveNext after you have already passed the end of the
    ///    collection, and you have previously received <i>hasNext</i> = <b>FALSE</b>.</div> <div> </div>
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Provides a read-only object model for a &lt;Package&gt; element in a bundle package manifest.
@GUID("54CD06C1-268F-40BB-8ED2-757A9EBAEC8D")
interface IAppxBundleManifestPackageInfo : IUnknown
{
    ///Retrieves the type of package that is represented by the package info.
    ///Params:
    ///    packageType = Type: <b>APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE*</b> The type of package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageType(APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE* packageType);
    ///Retrieves an object that represents the identity of the app package.
    ///Params:
    ///    packageId = Type: <b>IAppxManifestPackageId**</b> The package identifier.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    ///Retrieves the file-name attribute of the package.
    ///Params:
    ///    fileName = Type: <b>LPWSTR*</b> A string that contains the file name of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileName(ushort** fileName);
    ///Retrieves the offset of the package relative to the beginning of the bundle.
    ///Params:
    ///    offset = Type: <b>UINT64*</b> The offset of the package, in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetOffset(ulong* offset);
    ///Retrieves the size of the package, in bytes.
    ///Params:
    ///    size = Type: <b>UINT64*</b> The size of the package, in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSize(ulong* size);
    ///Retrieves an enumerator that iterates through all the &lt;Resource&gt; elements that are defined in the app
    ///package's manifest.
    ///Params:
    ///    resources = Type: <b>IAppxManifestQualifiedResourcesEnumerator**</b> The enumerator that iterates through the resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetResources(IAppxManifestQualifiedResourcesEnumerator* resources);
}

///Provides a read-only object model for a &lt;Package&gt; element in a bundle package manifest.
@GUID("44C2ACBC-B2CF-4CCB-BBDB-9C6DA8C3BC9E")
interface IAppxBundleManifestPackageInfo2 : IUnknown
{
    ///Determines whether a package is stored inside an app bundle, or if it's a reference to a package.
    ///Params:
    ///    isPackageReference = True if the package in the bundle is a reference to a package; False if the package in the bundle is stored
    ///                         inside the app bundle.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIsPackageReference(int* isPackageReference);
    ///Determines whether the app package is a non-qualified resource package.
    ///Params:
    ///    isNonQualifiedResourcePackage = True if the package is a non-qualified resource package, False otherwise.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIsNonQualifiedResourcePackage(int* isNonQualifiedResourcePackage);
    ///Determines whether the app package is a default applicable package.
    ///Params:
    ///    isDefaultApplicablePackage = True if the package is a default applicable package, False otherwise.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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

///Enumerates the optional bundle information from a bundle.
@GUID("9A178793-F97E-46AC-AACA-DD5BA4C177C8")
interface IAppxBundleManifestOptionalBundleInfoEnumerator : IUnknown
{
    ///Gets the optional bundle information at the current position of the enumerator.
    ///Params:
    ///    optionalBundle = The optional bundle information.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that includes, but is not
    ///    limited to, those in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%"> The enumerator has passed the
    ///    last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxBundleManifestOptionalBundleInfo* optionalBundle);
    ///Determines whether there is optional bundle information at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the enumerator has
    ///                 passed the last item in the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next set of optional bundle information.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    <div class="alert"><b>Note</b> When the enumerator passes the end of the collection for the first time,
    ///    <i>hasNext</i> = <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns
    ///    <b>E_BOUNDS</b> if you subsequently call another MoveNext after you have already passed the end of the
    ///    collection, and you have previously received <i>hasNext</i> = <b>FALSE</b>.</div> <div> </div>
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Provides a read-only object model for an &lt;OptionalBundle&gt; element in a bundle package manifest.
@GUID("515BF2E8-BCB0-4D69-8C48-E383147B6E12")
interface IAppxBundleManifestOptionalBundleInfo : IUnknown
{
    ///Retrieves an object that represents the identity of the &lt;OptionalBundle&gt;.
    ///Params:
    ///    packageId = The package identifier.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    ///Retrieves the file-name attribute of the &lt;OptionalBundle&gt;.
    ///Params:
    ///    fileName = Type: <b>LPWSTR*</b> A string that contains the file name of the package.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileName(ushort** fileName);
    ///Retrieves optional packages in the bundle.
    ///Params:
    ///    packageInfoItems = Type: <b>IAppxBundleManifestPackageInfoEnumerator**</b> An enumerator over all payload packages in a
    ///                       &lt;OptionalBundle&gt; element of a bundle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
}

///Enumerates files in content groups from a content group map.
@GUID("1A09A2FD-7440-44EB-8C84-848205A6A1CC")
interface IAppxContentGroupFilesEnumerator : IUnknown
{
    ///Gets the file from the content group at the current position of the enumerator.
    ///Params:
    ///    file = The file at the position of the enumerator.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrent(ushort** file);
    ///Determines whether there is a file at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the enumerator has
    ///                 passed the last item in the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next file.
    ///Params:
    ///    hasNext = <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has passed the end of the
    ///              collection.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code. <div
    ///    class="alert"><b>Note</b> When the enumerator passes the end of the collection for the first time,
    ///    <i>hasNext</i> = <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns
    ///    <b>E_BOUNDS</b> if you subsequently call another MoveNext after you have already passed the end of the
    ///    collection, and you have previously received <i>hasNext</i> = <b>FALSE</b>.</div> <div> </div>
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Retrieves information about a content group.
@GUID("328F6468-C04F-4E3C-B6FA-6B8D27F3003A")
interface IAppxContentGroup : IUnknown
{
    ///Gets the name of the content group.
    ///Params:
    ///    groupName = The content group name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetName(ushort** groupName);
    ///Gets files from a content group.
    ///Params:
    ///    enumerator = An enumerator for getting content group files.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFiles(IAppxContentGroupFilesEnumerator* enumerator);
}

///Enumerates the content groups from a content group map.
@GUID("3264E477-16D1-4D63-823E-7D2984696634")
interface IAppxContentGroupsEnumerator : IUnknown
{
    ///Gets the content group at the current position of the enumerator.
    ///Params:
    ///    stream = The current content group.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code that includes, but is not
    ///    limited to, those in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_BOUNDS</b></dt> </dl> </td> <td width="60%"> The enumerator has passed the
    ///    last item in the collection. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IAppxContentGroup* stream);
    ///Determines whether there is a content group at the current position of the enumerator.
    ///Params:
    ///    hasCurrent = <b>TRUE</b> if the enumerator's current position references an item; <b>FALSE</b> if the enumerator has
    ///                 passed the last item in the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHasCurrent(int* hasCurrent);
    ///Advances the position of the enumerator to the next content group.
    ///Params:
    ///    hasNext = Type: <b>BOOL*</b> <b>TRUE</b> if the enumerator successfully advances <b>FALSE</b> if the enumerator has
    ///              passed the end of the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    <div class="alert"><b>Note</b> When the enumerator passes the end of the collection for the first time,
    ///    <i>hasNext</i> = <b>FALSE</b>, but the method succeeds and returns <b>S_OK</b>. However, the method returns
    ///    <b>E_BOUNDS</b> if you subsequently call another MoveNext after you have already passed the end of the
    ///    collection, and you have previously received <i>hasNext</i> = <b>FALSE</b>.</div> <div> </div>
    ///    
    HRESULT MoveNext(int* hasNext);
}

///Gets information about a content group map.
@GUID("418726D8-DD99-4F5D-9886-157ADD20DE01")
interface IAppxContentGroupMapReader : IUnknown
{
    ///Gets the required content group from the content group map.
    ///Params:
    ///    requiredGroup = The required content group.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    ///Gets the automatic content group(s) from the content group map.
    ///Params:
    ///    automaticGroupsEnumerator = An enumerator for the automatic content group(s).
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

///Gets information about the source content group map.
@GUID("F329791D-540B-4A9F-BC75-3282B7D73193")
interface IAppxSourceContentGroupMapReader : IUnknown
{
    ///Gets the required content group from the source content group map.
    ///Params:
    ///    requiredGroup = The required content group.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    ///Gets the automatic content group(s) from the source content group map.
    ///Params:
    ///    automaticGroupsEnumerator = An enumerator for the automatic content group(s).
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

///Provides a write-only object model for a content group map.
@GUID("D07AB776-A9DE-4798-8C14-3DB31E687C78")
interface IAppxContentGroupMapWriter : IUnknown
{
    ///Adds an automatic content group to the content group map.
    ///Params:
    ///    groupName = The automatic content group name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddAutomaticGroup(const(wchar)* groupName);
    ///Adds files to an automatic content group in a content group map.
    ///Params:
    ///    fileName = The name of the file to be added to the automatic content group.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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

///Creates objects for encrypting, decrypting, reading, and writing packages and bundles.
@GUID("80E8E04D-8C88-44AE-A011-7CADF6FB2E72")
interface IAppxEncryptionFactory : IUnknown
{
    ///Creates an encrypted Windows app package from an unencrypted one.
    ///Params:
    ///    inputStream = A readable stream from the app package to be encrypted.
    ///    outputStream = A writeable stream for writing the resulting encrypted app package.
    ///    settings = Settings for creating the package.
    ///    keyInfo = Key information containing the base encryption key and key ID. The base key is used to derive the per file
    ///              encryption keys. If the base key is null, the global test key and key Id are used.
    ///    exemptedFiles = The list of files to be exempted from encryption.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    ///Creates an unencrypted Windows app package from an encrypted one.
    ///Params:
    ///    inputStream = A readable stream from the app package to be decrypted.
    ///    outputStream = A writeable stream for writing the resulting decrypted app package.
    ///    keyInfo = Key info containing the base encryption key and key ID for decrypting the package. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT DecryptPackage(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    ///Creates a new instance of an IAppxEncryptedPackageWriter.
    ///Params:
    ///    outputStream = A writeable stream for sending bytes produced by the app package.
    ///    manifestStream = A readable stream that defines the package for the AppxManifest.xml.
    ///    settings = Settings for creating the package.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the package. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    exemptedFiles = The list of files to be exempted from encryption.
    ///    packageWriter = The package writer object created.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
    ///Creates a new instance of <b>IAppxEncryptedPackageReader</b>.
    ///Params:
    ///    inputStream = A readable stream from the app package.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the package. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    packageReader = The package reader object created.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT CreateEncryptedPackageReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                         IAppxPackageReader* packageReader);
    ///Creates an encrypted Windows app bundle from an unencrypted one.
    ///Params:
    ///    inputStream = A readable stream from the app bundle to encrypt.
    ///    outputStream = A writeable stream for writing the resulting encrypted app bundle.
    ///    settings = Settings for creating the bundle.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the bundle. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    exemptedFiles = The list of files to be exempted from encryption.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, 
                          const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, 
                          const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    ///Creates an unencrypted Windows app bundle from an encrypted one.
    ///Params:
    ///    inputStream = A readable stream from the app bundle to be decrypted.
    ///    outputStream = A writeable stream for writing the resulting decrypted app bundle.
    ///    keyInfo = Key info containing the base encryption key and key ID for decrypting the bundle. The base key is used to
    ///              derive the per file encryption keys. If this parameter is null, the global test key and key ID are used.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT DecryptBundle(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    ///Creates a write-only bundle object to which encrypted Windows app packages can be added.
    ///Params:
    ///    outputStream = A writeable stream for writing the resulting encrypted app bundle.
    ///    bundleVersion = The version number of the bundle. If the bundle version is 0, a default version based on the current system
    ///                    time will be generated.
    ///    settings = Settings for creating the package.
    ///    keyInfo = Key info containing the base encryption key and key ID for decrypting the bundle. The base key is used to
    ///              derive the per file encryption keys. If this parameter is null, the global test key and key ID are used.
    ///    exemptedFiles = The list of files to be exempted from encryption.
    ///    bundleWriter = The bundle writer object created.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, 
                                        const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                        const(APPX_KEY_INFO)* keyInfo, 
                                        const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                        IAppxEncryptedBundleWriter* bundleWriter);
    ///Creates a read-only bundle object to which encrypted Windows app packages can be added.
    ///Params:
    ///    inputStream = A stream for reading the encrypted bundle.
    ///    keyInfo = Key info containing the base encryption key and key ID for decrypting the bundle. The base key is used to
    ///              derive the per file encryption keys. If this parameter is null, the global test key and key ID are used.
    ///    bundleReader = The bundle reader object created.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT CreateEncryptedBundleReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                        IAppxBundleReader* bundleReader);
}

///Creates objects for encrypting, decrypting, reading, and writing Windows app packages and bundles.
@GUID("C1B11EEE-C4BA-4AB2-A55D-D015FE8FF64F")
interface IAppxEncryptionFactory2 : IUnknown
{
    ///Creates a new instance of an IAppxEncryptedPackageWriter.
    ///Params:
    ///    outputStream = A writeable stream for sending bytes produced by the app package.
    ///    manifestStream = A readable stream that defines the package for the AppxManifest.xml.
    ///    contentGroupMapStream = A stream that defines the content group map.
    ///    settings = Settings for creating the package.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the package. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    exemptedFiles = Files exempted from the package writer.
    ///    packageWriter = The package writer object created.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         IStream contentGroupMapStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
}

///Creates objects for encrypting, decrypting, reading, and writing Windows app packages and bundles.
@GUID("09EDCA37-CD64-47D6-B7E8-1CB11D4F7E05")
interface IAppxEncryptionFactory3 : IUnknown
{
    ///Creates an encrypted Windows app package from an unencrypted one.
    ///Params:
    ///    inputStream = A readable stream from the app bundle to encrypt.
    ///    outputStream = A writeable stream for writing the resulting encrypted app bundle.
    ///    settings = Settings for creating the bundle.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the bundle. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    exemptedFiles = Files exempted from the package writer.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    ///Creates a new instance of an IAppxEncryptedPackageWriter.
    ///Params:
    ///    outputStream = A writeable stream for sending bytes produced by the app package.
    ///    manifestStream = A readable stream that defines the package for the AppxManifest.xml.
    ///    contentGroupMapStream = A stream that defines the content group map.
    ///    settings = Settings for creating the package.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the package. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    exemptedFiles = Files exempted from the package writer.
    ///    packageWriter = The package writer object created.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         IStream contentGroupMapStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
    ///Creates an encrypted Windows app bundle from an unencrypted one.
    ///Params:
    ///    inputStream = A readable stream from the app bundle to encrypt.
    ///    outputStream = A writeable stream for writing the resulting encrypted app bundle.
    ///    settings = Settings for creating the bundle.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the bundle. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    exemptedFiles = Files exempted from the bundle writer.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, 
                          const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                          const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    ///Creates a write-only bundle object to which encrypted Windows app packages can be added.
    ///Params:
    ///    outputStream = A writeable stream for writing the resulting encrypted app bundle.
    ///    bundleVersion = The version number of the bundle. If the bundle version is 0, a default version based on the current system
    ///                    time will be generated.
    ///    settings = Settings for creating the package.
    ///    keyInfo = Key info containing the base encryption key and key ID for decrypting the bundle. The base key is used to
    ///              derive the per file encryption keys. If this parameter is null, the global test key and key ID are used.
    ///    exemptedFiles = Files exempted from the bundle writer.
    ///    bundleWriter = The bundle writer object created.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, 
                                        const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, 
                                        const(APPX_KEY_INFO)* keyInfo, 
                                        const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                        IAppxEncryptedBundleWriter* bundleWriter);
}

///Creates objects for encrypting Windows app packages and bundles.
@GUID("A879611F-12FD-41FE-85D5-06AE779BBAF5")
interface IAppxEncryptionFactory4 : IUnknown
{
    ///Creates an encrypted Windows app package from an unencrypted one.
    ///Params:
    ///    inputStream = A readable stream from the app bundle to encrypt.
    ///    outputStream = A writeable stream for writing the resulting encrypted app bundle.
    ///    settings = Settings for creating the bundle.
    ///    keyInfo = Key info containing the base encryption key and key ID for encrypting the bundle. The base encryption key is
    ///              used to derive the per file encryption keys. If this parameter is null, the global test key and key ID are
    ///              used.
    ///    exemptedFiles = Files exempted from the package writer.
    ///    memoryLimit = The memory limit in bytes.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, ulong memoryLimit);
}

///Provides a write-only object model for encrypted app packages.
@GUID("F43D0B0B-1379-40E2-9B29-682EA2BF42AF")
interface IAppxEncryptedPackageWriter : IUnknown
{
    ///Adds a new encrypted payload file to the appx package.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    compressionOption = The type of compression to use to store <i>fileName</i> in the package.
    ///    inputStream = An IStream providing the contents of <i>fileName</i>. The stream must support Read, Seek, and Stat.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT AddPayloadFileEncrypted(const(wchar)* fileName, APPX_COMPRESSION_OPTION compressionOption, 
                                    IStream inputStream);
    ///Closes and finalizes the written package stream.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT Close();
}

///Provides a write-only object model for encrypted app packages.
@GUID("3E475447-3A25-40B5-8AD2-F953AE50C92D")
interface IAppxEncryptedPackageWriter2 : IUnknown
{
    ///Adds one or more payload files to an encrypted app package.
    ///Params:
    ///    fileCount = The number of payload files to be added to the encrypted app package.
    ///    payloadFiles = The payload files to be added.
    ///    memoryLimit = The memory limit in bytes.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT AddPayloadFilesEncrypted(uint fileCount, char* payloadFiles, ulong memoryLimit);
}

///Provides a write-only object model for encrypted bundle packages.
@GUID("80B0902F-7BF0-4117-B8C6-4279EF81EE77")
interface IAppxEncryptedBundleWriter : IUnknown
{
    ///Encrypts a new payload package to the bundle.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    packageStream = An IStream that provides the contents of <i>fileName</i>. The stream must support Read, Seek, and Stat.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT AddPayloadPackageEncrypted(const(wchar)* fileName, IStream packageStream);
    ///Writes the bundle manifest and blockmap footprint files to the bundle.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an error code.
    ///    
    HRESULT Close();
}

///Provides a write-only object model for encrypted bundle packages.
@GUID("E644BE82-F0FA-42B8-A956-8D1CB48EE379")
interface IAppxEncryptedBundleWriter2 : IUnknown
{
    ///Adds a reference within the encrypted package bundle to an external app package.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    inputStream = An IStream that provides the contents of <i>fileName</i>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream);
}

///Provides a write-only object model for encrypted bundle packages.
@GUID("0D34DEB3-5CAE-4DD3-977C-504932A51D31")
interface IAppxEncryptedBundleWriter3 : IUnknown
{
    ///Encrypts a new payload package to the bundle.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    packageStream = An IStream that provides the contents of <i>fileName</i>.
    ///    isDefaultApplicablePackage = A flag for whether this package is a default applicable package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPayloadPackageEncrypted(const(wchar)* fileName, IStream packageStream, 
                                       BOOL isDefaultApplicablePackage);
    ///Adds a reference within the encrypted package bundle to an external app package.
    ///Params:
    ///    fileName = The name of the payload file. The file name path must be relative to the root of the package.
    ///    inputStream = An IStream that provides the contents of <i>fileName</i>.
    ///    isDefaultApplicablePackage = A flag for whether this package is a default applicable package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddExternalPackageReference(const(wchar)* fileName, IStream inputStream, 
                                        BOOL isDefaultApplicablePackage);
}

///Provides functionality to edit app packages.
@GUID("E2ADB6DC-5E71-4416-86B6-86E5F5291A6B")
interface IAppxPackageEditor : IUnknown
{
    HRESULT SetWorkingDirectory(const(wchar)* workingDirectory);
    ///Creates a delta package from the differences in the updated package and the baseline package.
    ///Params:
    ///    updatedPackageStream = An IStream that provides the contents of the updated app package.
    ///    baselinePackageStream = An IStream that provides the contents of the baseline app package.
    ///    deltaPackageStream = An IStream that provides the contents of the delta (difference) app package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDeltaPackage(IStream updatedPackageStream, IStream baselinePackageStream, 
                               IStream deltaPackageStream);
    ///Creates a delta package from the differences in the updated package and the baseline block map.
    ///Params:
    ///    updatedPackageStream = An IStream that provides the contents of the updated app package.
    ///    baselineBlockMapStream = An IStream that provides the contents of the baseline block map.
    ///    baselinePackageFullName = The full name of the baseline app package.
    ///    deltaPackageStream = An IStream that provides the contents of the delta (difference) app package.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDeltaPackageUsingBaselineBlockMap(IStream updatedPackageStream, IStream baselineBlockMapStream, 
                                                    const(wchar)* baselinePackageFullName, 
                                                    IStream deltaPackageStream);
    ///Updates an app package.
    ///Params:
    ///    baselinePackageStream = An IStream that provides the contents of the baseline app package.
    ///    deltaPackageStream = An IStream that provides the contents of the delta (difference) app package.
    ///    updateOption = The update options.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UpdatePackage(IStream baselinePackageStream, IStream deltaPackageStream, 
                          APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption);
    ///Updates an encrypted app package.
    ///Params:
    ///    baselineEncryptedPackageStream = An IStream that provides the contents of the baseline encrypted app package.
    ///    deltaPackageStream = An IStream that provides the contents of the delta (difference) app package.
    ///    updateOption = The update options.
    ///    settings = The encrypted app package settings.
    ///    keyInfo = App package key information.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UpdateEncryptedPackage(IStream baselineEncryptedPackageStream, IStream deltaPackageStream, 
                                   APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption, 
                                   const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo);
    ///Updates an app package manifest.
    ///Params:
    ///    packageStream = An IStream that provides the contents of the app package associated with the manifest to be updated.
    ///    updatedManifestStream = An IStream that provides the contents of the updated app package manifest.
    ///    isPackageEncrypted = Flag to specify whether the package is encrypted.
    ///    options = Options for app package manifest validation.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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
