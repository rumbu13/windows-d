// Written in the D programming language.

module windows.menusandresources;

public import windows.core;
public import windows.com : HRESULT;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : HBITMAP, HBRUSH, HCURSOR, HDC, HICON;
public import windows.shell : HELPINFO, LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, ENUMRESLANGPROCA, ENUMRESLANGPROCW,
                                       HANDLE, HINSTANCE, HRSRC, LRESULT, PSTR,
                                       PWSTR;
public import windows.windowsandmessaging : HHOOK, HOOKPROC, HWND, LPARAM, MSG,
                                            UPDATELAYEREDWINDOWINFO, WPARAM;

extern(Windows) @nogc nothrow:


// Enums


alias DI_FLAGS = uint;
enum : uint
{
    DI_MASK        = 0x00000001,
    DI_IMAGE       = 0x00000002,
    DI_NORMAL      = 0x00000003,
    DI_COMPAT      = 0x00000004,
    DI_DEFAULTSIZE = 0x00000008,
    DI_NOMIRROR    = 0x00000010,
}

alias POINTER_INPUT_TYPE = int;
enum : int
{
    PT_POINTER  = 0x00000001,
    PT_TOUCH    = 0x00000002,
    PT_PEN      = 0x00000003,
    PT_MOUSE    = 0x00000004,
    PT_TOUCHPAD = 0x00000005,
}

alias EDIT_CONTROL_FEATURE = int;
enum : int
{
    EDIT_CONTROL_FEATURE_ENTERPRISE_DATA_PROTECTION_PASTE_SUPPORT = 0x00000000,
    EDIT_CONTROL_FEATURE_PASTE_NOTIFICATIONS                      = 0x00000001,
}

alias HANDEDNESS = int;
enum : int
{
    HANDEDNESS_LEFT  = 0x00000000,
    HANDEDNESS_RIGHT = 0x00000001,
}

enum MrmPlatformVersion : int
{
    MrmPlatformVersion_Default         = 0x00000000,
    MrmPlatformVersion_Windows10_0_0_0 = 0x010a0000,
    MrmPlatformVersion_Windows10_0_0_5 = 0x010a0005,
}

enum MrmPackagingMode : int
{
    MrmPackagingModeStandaloneFile = 0x00000000,
    MrmPackagingModeAutoSplit      = 0x00000001,
    MrmPackagingModeResourcePack   = 0x00000002,
}

enum MrmPackagingOptions : int
{
    MrmPackagingOptionsNone                        = 0x00000000,
    MrmPackagingOptionsOmitSchemaFromResourcePacks = 0x00000001,
    MrmPackagingOptionsSplitLanguageVariants       = 0x00000002,
}

enum MrmDumpType : int
{
    MrmDumpType_Basic    = 0x00000000,
    MrmDumpType_Detailed = 0x00000001,
    MrmDumpType_Schema   = 0x00000002,
}

enum MrmResourceIndexerMessageSeverity : int
{
    MrmResourceIndexerMessageSeverityVerbose = 0x00000000,
    MrmResourceIndexerMessageSeverityInfo    = 0x00000001,
    MrmResourceIndexerMessageSeverityWarning = 0x00000002,
    MrmResourceIndexerMessageSeverityError   = 0x00000003,
}

// Callbacks

alias WINSTAENUMPROCA = BOOL function(PSTR param0, LPARAM param1);
alias WINSTAENUMPROCW = BOOL function(PWSTR param0, LPARAM param1);
alias DESKTOPENUMPROCA = BOOL function(PSTR param0, LPARAM param1);
alias DESKTOPENUMPROCW = BOOL function(PWSTR param0, LPARAM param1);
///An application-defined callback function used with the EnumResourceNames and EnumResourceNamesEx functions. It
///receives the type and name of a resource. The <b>ENUMRESNAMEPROC</b> type defines a pointer to this callback
///function. <i>EnumResNameProc</i> is a placeholder for the application-defined function name.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose executable file contains the resources that are being
///              enumerated. If this parameter is <b>NULL</b>, the function enumerates the resource names in the module used to
///              create the current process.
///    lpType = Type: <b>LPCTSTR</b> The type of resource for which the name is being enumerated. Alternately, rather than a
///             pointer, this parameter can be <code>MAKEINTRESOURCE(ID)</code>, where ID is an integer value representing a
///             predefined resource type. For standard resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpName = Type: <b>LPTSTR</b> The name of a resource of the type being enumerated. Alternately, rather than a pointer, this
///             parameter can be <code>MAKEINTRESOURCE(ID)</code>, where ID is the integer identifier of the resource. For more
///             information, see the Remarks section below.
///    lParam = Type: <b>LONG_PTR</b> An application-defined parameter passed to the EnumResourceNames or EnumResourceNamesEx
///             function. This parameter can be used in error checking.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ENUMRESNAMEPROCA = BOOL function(ptrdiff_t hModule, const(PSTR) lpType, PSTR lpName, ptrdiff_t lParam);
///An application-defined callback function used with the EnumResourceNames and EnumResourceNamesEx functions. It
///receives the type and name of a resource. The <b>ENUMRESNAMEPROC</b> type defines a pointer to this callback
///function. <i>EnumResNameProc</i> is a placeholder for the application-defined function name.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose executable file contains the resources that are being
///              enumerated. If this parameter is <b>NULL</b>, the function enumerates the resource names in the module used to
///              create the current process.
///    lpType = Type: <b>LPCTSTR</b> The type of resource for which the name is being enumerated. Alternately, rather than a
///             pointer, this parameter can be <code>MAKEINTRESOURCE(ID)</code>, where ID is an integer value representing a
///             predefined resource type. For standard resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpName = Type: <b>LPTSTR</b> The name of a resource of the type being enumerated. Alternately, rather than a pointer, this
///             parameter can be <code>MAKEINTRESOURCE(ID)</code>, where ID is the integer identifier of the resource. For more
///             information, see the Remarks section below.
///    lParam = Type: <b>LONG_PTR</b> An application-defined parameter passed to the EnumResourceNames or EnumResourceNamesEx
///             function. This parameter can be used in error checking.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ENUMRESNAMEPROCW = BOOL function(ptrdiff_t hModule, const(PWSTR) lpType, PWSTR lpName, ptrdiff_t lParam);
///An application-defined callback function used with the EnumResourceTypes and EnumResourceTypesEx functions. It
///receives resource types. The <b>ENUMRESTYPEPROC</b> type defines a pointer to this callback function.
///<i>EnumResTypeProc</i> is a placeholder for the application-defined function name.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose executable file contains the resources for which the types are
///              to be enumerated. If this parameter is <b>NULL</b>, the function enumerates the resource types in the module used
///              to create the current process.
///    lpType = Type: <b>LPTSTR</b> The type of resource for which the type is being enumerated. Alternately, rather than a
///             pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is the integer identifier of the given resource
///             type. For standard resource types, see Resource Types. For more information, see the Remarks section below.
///    lParam = Type: <b>LONG_PTR</b> An application-defined parameter passed to the EnumResourceTypes or EnumResourceTypesEx
///             function. This parameter can be used in error checking.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ENUMRESTYPEPROCA = BOOL function(ptrdiff_t hModule, PSTR lpType, ptrdiff_t lParam);
///An application-defined callback function used with the EnumResourceTypes and EnumResourceTypesEx functions. It
///receives resource types. The <b>ENUMRESTYPEPROC</b> type defines a pointer to this callback function.
///<i>EnumResTypeProc</i> is a placeholder for the application-defined function name.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose executable file contains the resources for which the types are
///              to be enumerated. If this parameter is <b>NULL</b>, the function enumerates the resource types in the module used
///              to create the current process.
///    lpType = Type: <b>LPTSTR</b> The type of resource for which the type is being enumerated. Alternately, rather than a
///             pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is the integer identifier of the given resource
///             type. For standard resource types, see Resource Types. For more information, see the Remarks section below.
///    lParam = Type: <b>LONG_PTR</b> An application-defined parameter passed to the EnumResourceTypes or EnumResourceTypesEx
///             function. This parameter can be used in error checking.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ENUMRESTYPEPROCW = BOOL function(ptrdiff_t hModule, PWSTR lpType, ptrdiff_t lParam);
alias WNDPROC = LRESULT function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias WNDENUMPROC = BOOL function(HWND param0, LPARAM param1);
alias NAMEENUMPROCA = BOOL function(PSTR param0, LPARAM param1);
alias NAMEENUMPROCW = BOOL function(PWSTR param0, LPARAM param1);
alias PREGISTERCLASSNAMEW = ubyte function(const(PWSTR) param0);
alias MSGBOXCALLBACK = void function(HELPINFO* lpHelpInfo);

// Structs


///Contains version information for a file. This information is language and code page independent.
struct VS_FIXEDFILEINFO
{
    ///Type: <b>DWORD</b> Contains the value 0xFEEF04BD. This is used with the <b>szKey</b> member of the VS_VERSIONINFO
    ///structure when searching a file for the <b>VS_FIXEDFILEINFO</b> structure.
    uint dwSignature;
    ///Type: <b>DWORD</b> The binary version number of this structure. The high-order word of this member contains the
    ///major version number, and the low-order word contains the minor version number.
    uint dwStrucVersion;
    ///Type: <b>DWORD</b> The most significant 32 bits of the file's binary version number. This member is used with
    ///<b>dwFileVersionLS</b> to form a 64-bit value used for numeric comparisons.
    uint dwFileVersionMS;
    ///Type: <b>DWORD</b> The least significant 32 bits of the file's binary version number. This member is used with
    ///<b>dwFileVersionMS</b> to form a 64-bit value used for numeric comparisons.
    uint dwFileVersionLS;
    ///Type: <b>DWORD</b> The most significant 32 bits of the binary version number of the product with which this file
    ///was distributed. This member is used with <b>dwProductVersionLS</b> to form a 64-bit value used for numeric
    ///comparisons.
    uint dwProductVersionMS;
    ///Type: <b>DWORD</b> The least significant 32 bits of the binary version number of the product with which this file
    ///was distributed. This member is used with <b>dwProductVersionMS</b> to form a 64-bit value used for numeric
    ///comparisons.
    uint dwProductVersionLS;
    ///Type: <b>DWORD</b> Contains a bitmask that specifies the valid bits in <b>dwFileFlags</b>. A bit is valid only if
    ///it was defined when the file was created.
    uint dwFileFlagsMask;
    ///Type: <b>DWORD</b> Contains a bitmask that specifies the Boolean attributes of the file. This member can include
    ///one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="VS_FF_DEBUG"></a><a id="vs_ff_debug"></a><dl> <dt><b>VS_FF_DEBUG</b></dt> <dt>0x00000001L</dt> </dl> </td>
    ///<td width="60%"> The file contains debugging information or is compiled with debugging features enabled. </td>
    ///</tr> <tr> <td width="40%"><a id="VS_FF_INFOINFERRED"></a><a id="vs_ff_infoinferred"></a><dl>
    ///<dt><b>VS_FF_INFOINFERRED</b></dt> <dt>0x00000010L</dt> </dl> </td> <td width="60%"> The file's version structure
    ///was created dynamically; therefore, some of the members in this structure may be empty or incorrect. This flag
    ///should never be set in a file's VS_VERSIONINFO data. </td> </tr> <tr> <td width="40%"><a
    ///id="VS_FF_PATCHED"></a><a id="vs_ff_patched"></a><dl> <dt><b>VS_FF_PATCHED</b></dt> <dt>0x00000004L</dt> </dl>
    ///</td> <td width="60%"> The file has been modified and is not identical to the original shipping file of the same
    ///version number. </td> </tr> <tr> <td width="40%"><a id="VS_FF_PRERELEASE"></a><a id="vs_ff_prerelease"></a><dl>
    ///<dt><b>VS_FF_PRERELEASE</b></dt> <dt>0x00000002L</dt> </dl> </td> <td width="60%"> The file is a development
    ///version, not a commercially released product. </td> </tr> <tr> <td width="40%"><a id="VS_FF_PRIVATEBUILD"></a><a
    ///id="vs_ff_privatebuild"></a><dl> <dt><b>VS_FF_PRIVATEBUILD</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
    ///width="60%"> The file was not built using standard release procedures. If this flag is set, the StringFileInfo
    ///structure should contain a PrivateBuild entry. </td> </tr> <tr> <td width="40%"><a id="VS_FF_SPECIALBUILD"></a><a
    ///id="vs_ff_specialbuild"></a><dl> <dt><b>VS_FF_SPECIALBUILD</b></dt> <dt>0x00000020L</dt> </dl> </td> <td
    ///width="60%"> The file was built by the original company using standard release procedures but is a variation of
    ///the normal file of the same version number. If this flag is set, the StringFileInfo structure should contain a
    ///SpecialBuild entry. </td> </tr> </table>
    uint dwFileFlags;
    ///Type: <b>DWORD</b> The operating system for which this file was designed. This member can be one of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VOS_DOS"></a><a
    ///id="vos_dos"></a><dl> <dt><b>VOS_DOS</b></dt> <dt>0x00010000L</dt> </dl> </td> <td width="60%"> The file was
    ///designed for MS-DOS. </td> </tr> <tr> <td width="40%"><a id="VOS_NT"></a><a id="vos_nt"></a><dl>
    ///<dt><b>VOS_NT</b></dt> <dt>0x00040000L</dt> </dl> </td> <td width="60%"> The file was designed for Windows NT.
    ///</td> </tr> <tr> <td width="40%"><a id="VOS__WINDOWS16"></a><a id="vos__windows16"></a><dl>
    ///<dt><b>VOS__WINDOWS16</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The file was designed for 16-bit
    ///Windows. </td> </tr> <tr> <td width="40%"><a id="VOS__WINDOWS32"></a><a id="vos__windows32"></a><dl>
    ///<dt><b>VOS__WINDOWS32</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> The file was designed for 32-bit
    ///Windows. </td> </tr> <tr> <td width="40%"><a id="VOS_OS216"></a><a id="vos_os216"></a><dl>
    ///<dt><b>VOS_OS216</b></dt> <dt>0x00020000L</dt> </dl> </td> <td width="60%"> The file was designed for 16-bit
    ///OS/2. </td> </tr> <tr> <td width="40%"><a id="VOS_OS232"></a><a id="vos_os232"></a><dl> <dt><b>VOS_OS232</b></dt>
    ///<dt>0x00030000L</dt> </dl> </td> <td width="60%"> The file was designed for 32-bit OS/2. </td> </tr> <tr> <td
    ///width="40%"><a id="VOS__PM16"></a><a id="vos__pm16"></a><dl> <dt><b>VOS__PM16</b></dt> <dt>0x00000002L</dt> </dl>
    ///</td> <td width="60%"> The file was designed for 16-bit Presentation Manager. </td> </tr> <tr> <td width="40%"><a
    ///id="VOS__PM32"></a><a id="vos__pm32"></a><dl> <dt><b>VOS__PM32</b></dt> <dt>0x00000003L</dt> </dl> </td> <td
    ///width="60%"> The file was designed for 32-bit Presentation Manager. </td> </tr> <tr> <td width="40%"><a
    ///id="VOS_UNKNOWN"></a><a id="vos_unknown"></a><dl> <dt><b>VOS_UNKNOWN</b></dt> <dt>0x00000000L</dt> </dl> </td>
    ///<td width="60%"> The operating system for which the file was designed is unknown to the system. </td> </tr>
    ///</table> An application can combine these values to indicate that the file was designed for one operating system
    ///running on another. The following <b>dwFileOS</b> values are examples of this, but are not a complete list.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VOS_DOS_WINDOWS16"></a><a
    ///id="vos_dos_windows16"></a><dl> <dt><b>VOS_DOS_WINDOWS16</b></dt> <dt>0x00010001L</dt> </dl> </td> <td
    ///width="60%"> The file was designed for 16-bit Windows running on MS-DOS. </td> </tr> <tr> <td width="40%"><a
    ///id="VOS_DOS_WINDOWS32"></a><a id="vos_dos_windows32"></a><dl> <dt><b>VOS_DOS_WINDOWS32</b></dt>
    ///<dt>0x00010004L</dt> </dl> </td> <td width="60%"> The file was designed for 32-bit Windows running on MS-DOS.
    ///</td> </tr> <tr> <td width="40%"><a id="VOS_NT_WINDOWS32"></a><a id="vos_nt_windows32"></a><dl>
    ///<dt><b>VOS_NT_WINDOWS32</b></dt> <dt>0x00040004L</dt> </dl> </td> <td width="60%"> The file was designed for
    ///Windows NT. </td> </tr> <tr> <td width="40%"><a id="VOS_OS216_PM16"></a><a id="vos_os216_pm16"></a><dl>
    ///<dt><b>VOS_OS216_PM16</b></dt> <dt>0x00020002L</dt> </dl> </td> <td width="60%"> The file was designed for 16-bit
    ///Presentation Manager running on 16-bit OS/2. </td> </tr> <tr> <td width="40%"><a id="VOS_OS232_PM32"></a><a
    ///id="vos_os232_pm32"></a><dl> <dt><b>VOS_OS232_PM32</b></dt> <dt>0x00030003L</dt> </dl> </td> <td width="60%"> The
    ///file was designed for 32-bit Presentation Manager running on 32-bit OS/2. </td> </tr> </table>
    uint dwFileOS;
    ///Type: <b>DWORD</b> The general type of file. This member can be one of the following values. All other values are
    ///reserved. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VFT_APP"></a><a
    ///id="vft_app"></a><dl> <dt><b>VFT_APP</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The file contains
    ///an application. </td> </tr> <tr> <td width="40%"><a id="VFT_DLL"></a><a id="vft_dll"></a><dl>
    ///<dt><b>VFT_DLL</b></dt> <dt>0x00000002L</dt> </dl> </td> <td width="60%"> The file contains a DLL. </td> </tr>
    ///<tr> <td width="40%"><a id="VFT_DRV"></a><a id="vft_drv"></a><dl> <dt><b>VFT_DRV</b></dt> <dt>0x00000003L</dt>
    ///</dl> </td> <td width="60%"> The file contains a device driver. If <b>dwFileType</b> is <b>VFT_DRV</b>,
    ///<b>dwFileSubtype</b> contains a more specific description of the driver. </td> </tr> <tr> <td width="40%"><a
    ///id="VFT_FONT"></a><a id="vft_font"></a><dl> <dt><b>VFT_FONT</b></dt> <dt>0x00000004L</dt> </dl> </td> <td
    ///width="60%"> The file contains a font. If <b>dwFileType</b> is <b>VFT_FONT</b>, <b>dwFileSubtype</b> contains a
    ///more specific description of the font file. </td> </tr> <tr> <td width="40%"><a id="VFT_STATIC_LIB"></a><a
    ///id="vft_static_lib"></a><dl> <dt><b>VFT_STATIC_LIB</b></dt> <dt>0x00000007L</dt> </dl> </td> <td width="60%"> The
    ///file contains a static-link library. </td> </tr> <tr> <td width="40%"><a id="VFT_UNKNOWN"></a><a
    ///id="vft_unknown"></a><dl> <dt><b>VFT_UNKNOWN</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The file
    ///type is unknown to the system. </td> </tr> <tr> <td width="40%"><a id="VFT_VXD"></a><a id="vft_vxd"></a><dl>
    ///<dt><b>VFT_VXD</b></dt> <dt>0x00000005L</dt> </dl> </td> <td width="60%"> The file contains a virtual device.
    ///</td> </tr> </table>
    uint dwFileType;
    ///Type: <b>DWORD</b> The function of the file. The possible values depend on the value of <b>dwFileType</b>. For
    ///all values of <b>dwFileType</b> not described in the following list, <b>dwFileSubtype</b> is zero. If
    ///<b>dwFileType</b> is <b>VFT_DRV</b>, <b>dwFileSubtype</b> can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VFT2_DRV_COMM"></a><a
    ///id="vft2_drv_comm"></a><dl> <dt><b>VFT2_DRV_COMM</b></dt> <dt>0x0000000AL</dt> </dl> </td> <td width="60%"> The
    ///file contains a communications driver. </td> </tr> <tr> <td width="40%"><a id="VFT2_DRV_DISPLAY"></a><a
    ///id="vft2_drv_display"></a><dl> <dt><b>VFT2_DRV_DISPLAY</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%">
    ///The file contains a display driver. </td> </tr> <tr> <td width="40%"><a id="VFT2_DRV_INSTALLABLE"></a><a
    ///id="vft2_drv_installable"></a><dl> <dt><b>VFT2_DRV_INSTALLABLE</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
    ///width="60%"> The file contains an installable driver. </td> </tr> <tr> <td width="40%"><a
    ///id="VFT2_DRV_KEYBOARD"></a><a id="vft2_drv_keyboard"></a><dl> <dt><b>VFT2_DRV_KEYBOARD</b></dt>
    ///<dt>0x00000002L</dt> </dl> </td> <td width="60%"> The file contains a keyboard driver. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_DRV_LANGUAGE"></a><a id="vft2_drv_language"></a><dl> <dt><b>VFT2_DRV_LANGUAGE</b></dt>
    ///<dt>0x00000003L</dt> </dl> </td> <td width="60%"> The file contains a language driver. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_DRV_MOUSE"></a><a id="vft2_drv_mouse"></a><dl> <dt><b>VFT2_DRV_MOUSE</b></dt>
    ///<dt>0x00000005L</dt> </dl> </td> <td width="60%"> The file contains a mouse driver. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_DRV_NETWORK"></a><a id="vft2_drv_network"></a><dl> <dt><b>VFT2_DRV_NETWORK</b></dt>
    ///<dt>0x00000006L</dt> </dl> </td> <td width="60%"> The file contains a network driver. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_DRV_PRINTER"></a><a id="vft2_drv_printer"></a><dl> <dt><b>VFT2_DRV_PRINTER</b></dt>
    ///<dt>0x00000001L</dt> </dl> </td> <td width="60%"> The file contains a printer driver. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_DRV_SOUND"></a><a id="vft2_drv_sound"></a><dl> <dt><b>VFT2_DRV_SOUND</b></dt>
    ///<dt>0x00000009L</dt> </dl> </td> <td width="60%"> The file contains a sound driver. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_DRV_SYSTEM"></a><a id="vft2_drv_system"></a><dl> <dt><b>VFT2_DRV_SYSTEM</b></dt>
    ///<dt>0x00000007L</dt> </dl> </td> <td width="60%"> The file contains a system driver. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_DRV_VERSIONED_PRINTER"></a><a id="vft2_drv_versioned_printer"></a><dl>
    ///<dt><b>VFT2_DRV_VERSIONED_PRINTER</b></dt> <dt>0x0000000CL</dt> </dl> </td> <td width="60%"> The file contains a
    ///versioned printer driver. </td> </tr> <tr> <td width="40%"><a id="VFT2_UNKNOWN"></a><a id="vft2_unknown"></a><dl>
    ///<dt><b>VFT2_UNKNOWN</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The driver type is unknown by the
    ///system. </td> </tr> </table> If <b>dwFileType</b> is <b>VFT_FONT</b>, <b>dwFileSubtype</b> can be one of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="VFT2_FONT_RASTER"></a><a id="vft2_font_raster"></a><dl> <dt><b>VFT2_FONT_RASTER</b></dt> <dt>0x00000001L</dt>
    ///</dl> </td> <td width="60%"> The file contains a raster font. </td> </tr> <tr> <td width="40%"><a
    ///id="VFT2_FONT_TRUETYPE"></a><a id="vft2_font_truetype"></a><dl> <dt><b>VFT2_FONT_TRUETYPE</b></dt>
    ///<dt>0x00000003L</dt> </dl> </td> <td width="60%"> The file contains a TrueType font. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_FONT_VECTOR"></a><a id="vft2_font_vector"></a><dl> <dt><b>VFT2_FONT_VECTOR</b></dt>
    ///<dt>0x00000002L</dt> </dl> </td> <td width="60%"> The file contains a vector font. </td> </tr> <tr> <td
    ///width="40%"><a id="VFT2_UNKNOWN"></a><a id="vft2_unknown"></a><dl> <dt><b>VFT2_UNKNOWN</b></dt>
    ///<dt>0x00000000L</dt> </dl> </td> <td width="60%"> The font type is unknown by the system. </td> </tr> </table> If
    ///<b>dwFileType</b> is <b>VFT_VXD</b>, <b>dwFileSubtype</b> contains the virtual device identifier included in the
    ///virtual device control block. All <b>dwFileSubtype</b> values not listed here are reserved.
    uint dwFileSubtype;
    ///Type: <b>DWORD</b> The most significant 32 bits of the file's 64-bit binary creation date and time stamp.
    uint dwFileDateMS;
    ///Type: <b>DWORD</b> The least significant 32 bits of the file's 64-bit binary creation date and time stamp.
    uint dwFileDateLS;
}

struct SHELLHOOKINFO
{
    HWND hwnd;
    RECT rc;
}

struct HARDWAREHOOKSTRUCT
{
    HWND   hwnd;
    uint   message;
    WPARAM wParam;
    LPARAM lParam;
}

///Contains information about the menu to be activated.
struct MDINEXTMENU
{
    ///Type: <b>HMENU</b> A handle to the current menu.
    HMENU hmenuIn;
    ///Type: <b>HMENU</b> A handle to the menu to be activated.
    HMENU hmenuNext;
    ///Type: <b>HWND</b> A handle to the window to receive the menu notification messages.
    HWND  hwndNext;
}

///Defines an accelerator key used in an accelerator table.
struct ACCEL
{
    ///Type: <b>BYTE</b> The accelerator behavior. This member can be one or more of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FALT"></a><a id="falt"></a><dl>
    ///<dt><b>FALT</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> The ALT key must be held down when the
    ///accelerator key is pressed. </td> </tr> <tr> <td width="40%"><a id="FCONTROL"></a><a id="fcontrol"></a><dl>
    ///<dt><b>FCONTROL</b></dt> <dt>0x08</dt> </dl> </td> <td width="60%"> The CTRL key must be held down when the
    ///accelerator key is pressed. </td> </tr> <tr> <td width="40%"><a id="FNOINVERT"></a><a id="fnoinvert"></a><dl>
    ///<dt><b>FNOINVERT</b></dt> <dt>0x02</dt> </dl> </td> <td width="60%"> No top-level menu item is highlighted when
    ///the accelerator is used. If this flag is not specified, a top-level menu item will be highlighted, if possible,
    ///when the accelerator is used. This attribute is obsolete and retained only for backward compatibility with
    ///resource files designed for 16-bit Windows. </td> </tr> <tr> <td width="40%"><a id="FSHIFT"></a><a
    ///id="fshift"></a><dl> <dt><b>FSHIFT</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> The SHIFT key must be held
    ///down when the accelerator key is pressed. </td> </tr> <tr> <td width="40%"><a id="FVIRTKEY"></a><a
    ///id="fvirtkey"></a><dl> <dt><b>FVIRTKEY</b></dt> <dt>TRUE</dt> </dl> </td> <td width="60%"> The <b>key</b> member
    ///specifies a virtual-key code. If this flag is not specified, <b>key</b> is assumed to specify a character code.
    ///</td> </tr> </table>
    ubyte  fVirt;
    ///Type: <b>WORD</b> The accelerator key. This member can be either a virtual-key code or a character code.
    ushort key;
    ///Type: <b>WORD</b> The accelerator identifier. This value is placed in the low-order word of the <i>wParam</i>
    ///parameter of the WM_COMMAND or WM_SYSCOMMAND message when the accelerator is pressed.
    ushort cmd;
}

///Contains extended parameters for the TrackPopupMenuEx function.
struct TPMPARAMS
{
    ///Type: <b>UINT</b> The size of structure, in bytes.
    uint cbSize;
    ///Type: <b>RECT</b> The rectangle to be excluded when positioning the window, in screen coordinates.
    RECT rcExclude;
}

///Contains information about a menu.
struct MENUINFO
{
    ///Type: <b>DWORD</b> The size of the structure, in bytes. The caller must set this member to
    ///<code>sizeof(MENUINFO)</code>.
    uint   cbSize;
    ///Type: <b>DWORD</b> Indicates the members to be retrieved or set (except for <b>MIM_APPLYTOSUBMENUS</b>). This
    ///member can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="MIM_APPLYTOSUBMENUS"></a><a id="mim_applytosubmenus"></a><dl>
    ///<dt><b>MIM_APPLYTOSUBMENUS</b></dt> <dt>0x80000000</dt> </dl> </td> <td width="60%"> Settings apply to the menu
    ///and all of its submenus. SetMenuInfo uses this flag and GetMenuInfo ignores this flag </td> </tr> <tr> <td
    ///width="40%"><a id="MIM_BACKGROUND"></a><a id="mim_background"></a><dl> <dt><b>MIM_BACKGROUND</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> Retrieves or sets the <b>hbrBack</b> member. </td> </tr> <tr>
    ///<td width="40%"><a id="MIM_HELPID"></a><a id="mim_helpid"></a><dl> <dt><b>MIM_HELPID</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> Retrieves or sets the <b>dwContextHelpID</b> member. </td> </tr> <tr> <td
    ///width="40%"><a id="MIM_MAXHEIGHT"></a><a id="mim_maxheight"></a><dl> <dt><b>MIM_MAXHEIGHT</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> Retrieves or sets the <b>cyMax</b> member. </td> </tr> <tr> <td
    ///width="40%"><a id="MIM_MENUDATA"></a><a id="mim_menudata"></a><dl> <dt><b>MIM_MENUDATA</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> Retrieves or sets the <b>dwMenuData</b> member. </td> </tr> <tr>
    ///<td width="40%"><a id="MIM_STYLE"></a><a id="mim_style"></a><dl> <dt><b>MIM_STYLE</b></dt> <dt>0x00000010</dt>
    ///</dl> </td> <td width="60%"> Retrieves or sets the <b>dwStyle</b> member. </td> </tr> </table>
    uint   fMask;
    ///Type: <b>DWORD</b> The menu style. This member can be one or more of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MNS_AUTODISMISS"></a><a
    ///id="mns_autodismiss"></a><dl> <dt><b>MNS_AUTODISMISS</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%">
    ///Menu automatically ends when mouse is outside the menu for approximately 10 seconds. </td> </tr> <tr> <td
    ///width="40%"><a id="MNS_CHECKORBMP"></a><a id="mns_checkorbmp"></a><dl> <dt><b>MNS_CHECKORBMP</b></dt>
    ///<dt>0x04000000</dt> </dl> </td> <td width="60%"> The same space is reserved for the check mark and the bitmap. If
    ///the check mark is drawn, the bitmap is not. All checkmarks and bitmaps are aligned. Used for menus where some
    ///items use checkmarks and some use bitmaps. </td> </tr> <tr> <td width="40%"><a id="MNS_DRAGDROP"></a><a
    ///id="mns_dragdrop"></a><dl> <dt><b>MNS_DRAGDROP</b></dt> <dt>0x20000000</dt> </dl> </td> <td width="60%"> Menu
    ///items are OLE drop targets or drag sources. Menu owner receives WM_MENUDRAG and WM_MENUGETOBJECT messages. </td>
    ///</tr> <tr> <td width="40%"><a id="MNS_MODELESS"></a><a id="mns_modeless"></a><dl> <dt><b>MNS_MODELESS</b></dt>
    ///<dt>0x40000000</dt> </dl> </td> <td width="60%"> Menu is modeless; that is, there is no menu modal message loop
    ///while the menu is active. </td> </tr> <tr> <td width="40%"><a id="MNS_NOCHECK"></a><a id="mns_nocheck"></a><dl>
    ///<dt><b>MNS_NOCHECK</b></dt> <dt>0x80000000</dt> </dl> </td> <td width="60%"> No space is reserved to the left of
    ///an item for a check mark. The item can still be selected, but the check mark will not appear next to the item.
    ///</td> </tr> <tr> <td width="40%"><a id="MNS_NOTIFYBYPOS"></a><a id="mns_notifybypos"></a><dl>
    ///<dt><b>MNS_NOTIFYBYPOS</b></dt> <dt>0x08000000</dt> </dl> </td> <td width="60%"> Menu owner receives a
    ///WM_MENUCOMMAND message instead of a WM_COMMAND message when the user makes a selection. <b>MNS_NOTIFYBYPOS</b> is
    ///a menu header style and has no effect when applied to individual sub menus. </td> </tr> </table>
    uint   dwStyle;
    ///Type: <b>UINT</b> The maximum height of the menu in pixels. When the menu items exceed the space available,
    ///scroll bars are automatically used. The default (0) is the screen height.
    uint   cyMax;
    ///Type: <b>HBRUSH</b> A handle to the brush to be used for the menu's background.
    HBRUSH hbrBack;
    ///Type: <b>DWORD</b> The context help identifier. This is the same value used in the GetMenuContextHelpId and
    ///SetMenuContextHelpId functions.
    uint   dwContextHelpID;
    ///Type: <b>ULONG_PTR</b> An application-defined value.
    size_t dwMenuData;
}

///Contains information about the menu that the mouse cursor is on.
struct MENUGETOBJECTINFO
{
    ///Type: <b>DWORD</b> The position of the mouse cursor with respect to the item indicated by <b>uPos</b>. It is a
    ///bitmask of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MNGOF_BOTTOMGAP"></a><a id="mngof_bottomgap"></a><dl> <dt><b>MNGOF_BOTTOMGAP</b></dt> <dt>0x00000002</dt>
    ///</dl> </td> <td width="60%"> The mouse is on the bottom of the item indicated by <b>uPos</b>. </td> </tr> <tr>
    ///<td width="40%"><a id="MNGOF_TOPGAP"></a><a id="mngof_topgap"></a><dl> <dt><b>MNGOF_TOPGAP</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> The mouse is on the top of the item indicated by <b>uPos</b>.
    ///</td> </tr> </table> If neither MNGOF_BOTTOMGAP nor MNGOF_TOPGAP is set, then the mouse is directly on the item
    ///indicated by <b>uPos</b>.
    uint  dwFlags;
    ///Type: <b>UINT</b> The position of the item the mouse cursor is on.
    uint  uPos;
    ///Type: <b>HMENU</b> A handle to the menu the mouse cursor is on.
    HMENU hmenu;
    ///Type: <b>PVOID</b> The identifier of the requested interface. Currently it can only be IDropTarget.
    void* riid;
    ///Type: <b>PVOID</b> A pointer to the interface corresponding to the <b>riid</b> member. This pointer is to be
    ///returned by the application when processing the message.
    void* pvObj;
}

///Contains information about a menu item.
struct MENUITEMINFOA
{
    ///Type: <b>UINT</b> The size of the structure, in bytes. The caller must set this member to
    ///<code>sizeof(MENUITEMINFO)</code>.
    uint    cbSize;
    ///Type: <b>UINT</b> Indicates the members to be retrieved or set. This member can be one or more of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIIM_BITMAP"></a><a
    ///id="miim_bitmap"></a><dl> <dt><b>MIIM_BITMAP</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Retrieves
    ///or sets the <b>hbmpItem</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_CHECKMARKS"></a><a
    ///id="miim_checkmarks"></a><dl> <dt><b>MIIM_CHECKMARKS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
    ///Retrieves or sets the <b>hbmpChecked</b> and <b>hbmpUnchecked</b> members. </td> </tr> <tr> <td width="40%"><a
    ///id="MIIM_DATA"></a><a id="miim_data"></a><dl> <dt><b>MIIM_DATA</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> Retrieves or sets the <b>dwItemData</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="MIIM_FTYPE"></a><a id="miim_ftype"></a><dl> <dt><b>MIIM_FTYPE</b></dt> <dt>0x00000100</dt> </dl> </td> <td
    ///width="60%"> Retrieves or sets the <b>fType</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_ID"></a><a
    ///id="miim_id"></a><dl> <dt><b>MIIM_ID</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Retrieves or sets
    ///the <b>wID</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_STATE"></a><a id="miim_state"></a><dl>
    ///<dt><b>MIIM_STATE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Retrieves or sets the <b>fState</b>
    ///member. </td> </tr> <tr> <td width="40%"><a id="MIIM_STRING"></a><a id="miim_string"></a><dl>
    ///<dt><b>MIIM_STRING</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Retrieves or sets the
    ///<b>dwTypeData</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_SUBMENU"></a><a id="miim_submenu"></a><dl>
    ///<dt><b>MIIM_SUBMENU</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Retrieves or sets the
    ///<b>hSubMenu</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_TYPE"></a><a id="miim_type"></a><dl>
    ///<dt><b>MIIM_TYPE</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Retrieves or sets the <b>fType</b> and
    ///<b>dwTypeData</b> members. <b>MIIM_TYPE</b> is replaced by <b>MIIM_BITMAP</b>, <b>MIIM_FTYPE</b>, and
    ///<b>MIIM_STRING</b>. </td> </tr> </table>
    uint    fMask;
    ///Type: <b>UINT</b> The menu item type. This member can be one or more of the following values. The
    ///<b>MFT_BITMAP</b>, <b>MFT_SEPARATOR</b>, and <b>MFT_STRING</b> values cannot be combined with one another. Set
    ///<b>fMask</b> to <b>MIIM_TYPE</b> to use <b>fType</b>. <b>fType</b> is used only if <b>fMask</b> has a value of
    ///<b>MIIM_FTYPE</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MFT_BITMAP"></a><a id="mft_bitmap"></a><dl> <dt><b>MFT_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td
    ///width="60%"> Displays the menu item using a bitmap. The low-order word of the <b>dwTypeData</b> member is the
    ///bitmap handle, and the <b>cch</b> member is ignored. <b>MFT_BITMAP</b> is replaced by <b>MIIM_BITMAP</b> and
    ///<b>hbmpItem</b>. </td> </tr> <tr> <td width="40%"><a id="MFT_MENUBARBREAK"></a><a id="mft_menubarbreak"></a><dl>
    ///<dt><b>MFT_MENUBARBREAK</b></dt> <dt>0x00000020L</dt> </dl> </td> <td width="60%"> Places the menu item on a new
    ///line (for a menu bar) or in a new column (for a drop-down menu, submenu, or shortcut menu). For a drop-down menu,
    ///submenu, or shortcut menu, a vertical line separates the new column from the old. </td> </tr> <tr> <td
    ///width="40%"><a id="MFT_MENUBREAK"></a><a id="mft_menubreak"></a><dl> <dt><b>MFT_MENUBREAK</b></dt>
    ///<dt>0x00000040L</dt> </dl> </td> <td width="60%"> Places the menu item on a new line (for a menu bar) or in a new
    ///column (for a drop-down menu, submenu, or shortcut menu). For a drop-down menu, submenu, or shortcut menu, the
    ///columns are not separated by a vertical line. </td> </tr> <tr> <td width="40%"><a id="MFT_OWNERDRAW"></a><a
    ///id="mft_ownerdraw"></a><dl> <dt><b>MFT_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%">
    ///Assigns responsibility for drawing the menu item to the window that owns the menu. The window receives a
    ///WM_MEASUREITEM message before the menu is displayed for the first time, and a WM_DRAWITEM message whenever the
    ///appearance of the menu item must be updated. If this value is specified, the <b>dwTypeData</b> member contains an
    ///application-defined value. </td> </tr> <tr> <td width="40%"><a id="MFT_RADIOCHECK"></a><a
    ///id="mft_radiocheck"></a><dl> <dt><b>MFT_RADIOCHECK</b></dt> <dt>0x00000200L</dt> </dl> </td> <td width="60%">
    ///Displays selected menu items using a radio-button mark instead of a check mark if the <b>hbmpChecked</b> member
    ///is <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="MFT_RIGHTJUSTIFY"></a><a id="mft_rightjustify"></a><dl>
    ///<dt><b>MFT_RIGHTJUSTIFY</b></dt> <dt>0x00004000L</dt> </dl> </td> <td width="60%"> Right-justifies the menu item
    ///and any subsequent items. This value is valid only if the menu item is in a menu bar. </td> </tr> <tr> <td
    ///width="40%"><a id="MFT_RIGHTORDER"></a><a id="mft_rightorder"></a><dl> <dt><b>MFT_RIGHTORDER</b></dt>
    ///<dt>0x00002000L</dt> </dl> </td> <td width="60%"> Specifies that menus cascade right-to-left (the default is
    ///left-to-right). This is used to support right-to-left languages, such as Arabic and Hebrew. </td> </tr> <tr> <td
    ///width="40%"><a id="MFT_SEPARATOR"></a><a id="mft_separator"></a><dl> <dt><b>MFT_SEPARATOR</b></dt>
    ///<dt>0x00000800L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is a separator. A menu item
    ///separator appears as a horizontal dividing line. The <b>dwTypeData</b> and <b>cch</b> members are ignored. This
    ///value is valid only in a drop-down menu, submenu, or shortcut menu. </td> </tr> <tr> <td width="40%"><a
    ///id="MFT_STRING"></a><a id="mft_string"></a><dl> <dt><b>MFT_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td
    ///width="60%"> Displays the menu item using a text string. The <b>dwTypeData</b> member is the pointer to a
    ///null-terminated string, and the <b>cch</b> member is the length of the string. <b>MFT_STRING</b> is replaced by
    ///<b>MIIM_STRING</b>. </td> </tr> </table>
    uint    fType;
    ///Type: <b>UINT</b> The menu item state. This member can be one or more of these values. Set <b>fMask</b> to
    ///<b>MIIM_STATE</b> to use <b>fState</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="MFS_CHECKED"></a><a id="mfs_checked"></a><dl> <dt><b>MFS_CHECKED</b></dt> <dt>0x00000008L</dt>
    ///</dl> </td> <td width="60%"> Checks the menu item. For more information about selected menu items, see the
    ///<b>hbmpChecked</b> member. </td> </tr> <tr> <td width="40%"><a id="MFS_DEFAULT"></a><a id="mfs_default"></a><dl>
    ///<dt><b>MFS_DEFAULT</b></dt> <dt>0x00001000L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is the
    ///default. A menu can contain only one default menu item, which is displayed in bold. </td> </tr> <tr> <td
    ///width="40%"><a id="MFS_DISABLED"></a><a id="mfs_disabled"></a><dl> <dt><b>MFS_DISABLED</b></dt>
    ///<dt>0x00000003L</dt> </dl> </td> <td width="60%"> Disables the menu item and grays it so that it cannot be
    ///selected. This is equivalent to <b>MFS_GRAYED</b>. </td> </tr> <tr> <td width="40%"><a id="MFS_ENABLED"></a><a
    ///id="mfs_enabled"></a><dl> <dt><b>MFS_ENABLED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables
    ///the menu item so that it can be selected. This is the default state. </td> </tr> <tr> <td width="40%"><a
    ///id="MFS_GRAYED"></a><a id="mfs_grayed"></a><dl> <dt><b>MFS_GRAYED</b></dt> <dt>0x00000003L</dt> </dl> </td> <td
    ///width="60%"> Disables the menu item and grays it so that it cannot be selected. This is equivalent to
    ///<b>MFS_DISABLED</b>. </td> </tr> <tr> <td width="40%"><a id="MFS_HILITE"></a><a id="mfs_hilite"></a><dl>
    ///<dt><b>MFS_HILITE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td width="60%"> Highlights the menu item. </td>
    ///</tr> <tr> <td width="40%"><a id="MFS_UNCHECKED"></a><a id="mfs_unchecked"></a><dl> <dt><b>MFS_UNCHECKED</b></dt>
    ///<dt>0x00000000L</dt> </dl> </td> <td width="60%"> Unchecks the menu item. For more information about clear menu
    ///items, see the <b>hbmpChecked</b> member. </td> </tr> <tr> <td width="40%"><a id="MFS_UNHILITE"></a><a
    ///id="mfs_unhilite"></a><dl> <dt><b>MFS_UNHILITE</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Removes
    ///the highlight from the menu item. This is the default state. </td> </tr> </table>
    uint    fState;
    ///Type: <b>UINT</b> An application-defined value that identifies the menu item. Set <b>fMask</b> to <b>MIIM_ID</b>
    ///to use <b>wID</b>.
    uint    wID;
    ///Type: <b>HMENU</b> A handle to the drop-down menu or submenu associated with the menu item. If the menu item is
    ///not an item that opens a drop-down menu or submenu, this member is <b>NULL</b>. Set <b>fMask</b> to
    ///<b>MIIM_SUBMENU</b> to use <b>hSubMenu</b>.
    HMENU   hSubMenu;
    ///Type: <b>HBITMAP</b> A handle to the bitmap to display next to the item if it is selected. If this member is
    ///<b>NULL</b>, a default bitmap is used. If the <b>MFT_RADIOCHECK</b> type value is specified, the default bitmap
    ///is a bullet. Otherwise, it is a check mark. Set <b>fMask</b> to <b>MIIM_CHECKMARKS</b> to use <b>hbmpChecked</b>.
    HBITMAP hbmpChecked;
    ///Type: <b>HBITMAP</b> A handle to the bitmap to display next to the item if it is not selected. If this member is
    ///<b>NULL</b>, no bitmap is used. Set <b>fMask</b> to <b>MIIM_CHECKMARKS</b> to use <b>hbmpUnchecked</b>.
    HBITMAP hbmpUnchecked;
    ///Type: <b>ULONG_PTR</b> An application-defined value associated with the menu item. Set <b>fMask</b> to
    ///<b>MIIM_DATA</b> to use <b>dwItemData</b>.
    size_t  dwItemData;
    ///Type: <b>LPTSTR</b> The contents of the menu item. The meaning of this member depends on the value of
    ///<b>fType</b> and is used only if the <b>MIIM_TYPE</b> flag is set in the <b>fMask</b> member. To retrieve a menu
    ///item of type <b>MFT_STRING</b>, first find the size of the string by setting the <b>dwTypeData</b> member of
    ///<b>MENUITEMINFO</b> to <b>NULL</b> and then calling GetMenuItemInfo. The value of <b>cch</b>+1 is the size
    ///needed. Then allocate a buffer of this size, place the pointer to the buffer in <b>dwTypeData</b>, increment
    ///<b>cch</b>, and call <b>GetMenuItemInfo</b> once again to fill the buffer with the string. If the retrieved menu
    ///item is of some other type, then <b>GetMenuItemInfo</b> sets the <b>dwTypeData</b> member to a value whose type
    ///is specified by the <b>fType</b> member. When using with the SetMenuItemInfo function, this member should contain
    ///a value whose type is specified by the <b>fType</b> member. <b>dwTypeData</b> is used only if the
    ///<b>MIIM_STRING</b> flag is set in the <b>fMask</b> member
    PSTR    dwTypeData;
    ///Type: <b>UINT</b> The length of the menu item text, in characters, when information is received about a menu item
    ///of the <b>MFT_STRING</b> type. However, <b>cch</b> is used only if the <b>MIIM_TYPE</b> flag is set in the
    ///<b>fMask</b> member and is zero otherwise. Also, <b>cch</b> is ignored when the content of a menu item is set by
    ///calling SetMenuItemInfo. Note that, before calling GetMenuItemInfo, the application must set <b>cch</b> to the
    ///length of the buffer pointed to by the <b>dwTypeData</b> member. If the retrieved menu item is of type
    ///<b>MFT_STRING</b> (as indicated by the <b>fType</b> member), then <b>GetMenuItemInfo</b> changes <b>cch</b> to
    ///the length of the menu item text. If the retrieved menu item is of some other type, <b>GetMenuItemInfo</b> sets
    ///the <b>cch</b> field to zero. The <b>cch</b> member is used when the <b>MIIM_STRING</b> flag is set in the
    ///<b>fMask</b> member.
    uint    cch;
    ///Type: <b>HBITMAP</b> A handle to the bitmap to be displayed, or it can be one of the values in the following
    ///table. It is used when the <b>MIIM_BITMAP</b> flag is set in the <b>fMask</b> member. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="HBMMENU_CALLBACK"></a><a id="hbmmenu_callback"></a><dl>
    ///<dt><b>HBMMENU_CALLBACK</b></dt> <dt>((HBITMAP) -1)</dt> </dl> </td> <td width="60%"> A bitmap that is drawn by
    ///the window that owns the menu. The application must process the WM_MEASUREITEM and WM_DRAWITEM messages. </td>
    ///</tr> <tr> <td width="40%"><a id="HBMMENU_MBAR_CLOSE"></a><a id="hbmmenu_mbar_close"></a><dl>
    ///<dt><b>HBMMENU_MBAR_CLOSE</b></dt> <dt>((HBITMAP) 5)</dt> </dl> </td> <td width="60%"> Close button for the menu
    ///bar. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_MBAR_CLOSE_D"></a><a id="hbmmenu_mbar_close_d"></a><dl>
    ///<dt><b>HBMMENU_MBAR_CLOSE_D</b></dt> <dt>((HBITMAP) 6)</dt> </dl> </td> <td width="60%"> Disabled close button
    ///for the menu bar. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_MBAR_MINIMIZE"></a><a
    ///id="hbmmenu_mbar_minimize"></a><dl> <dt><b>HBMMENU_MBAR_MINIMIZE</b></dt> <dt>((HBITMAP) 3)</dt> </dl> </td> <td
    ///width="60%"> Minimize button for the menu bar. </td> </tr> <tr> <td width="40%"><a
    ///id="HBMMENU_MBAR_MINIMIZE_D"></a><a id="hbmmenu_mbar_minimize_d"></a><dl> <dt><b>HBMMENU_MBAR_MINIMIZE_D</b></dt>
    ///<dt>((HBITMAP) 7)</dt> </dl> </td> <td width="60%"> Disabled minimize button for the menu bar. </td> </tr> <tr>
    ///<td width="40%"><a id="HBMMENU_MBAR_RESTORE"></a><a id="hbmmenu_mbar_restore"></a><dl>
    ///<dt><b>HBMMENU_MBAR_RESTORE</b></dt> <dt>((HBITMAP) 2)</dt> </dl> </td> <td width="60%"> Restore button for the
    ///menu bar. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_POPUP_CLOSE"></a><a id="hbmmenu_popup_close"></a><dl>
    ///<dt><b>HBMMENU_POPUP_CLOSE</b></dt> <dt>((HBITMAP) 8)</dt> </dl> </td> <td width="60%"> Close button for the
    ///submenu. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_POPUP_MAXIMIZE"></a><a
    ///id="hbmmenu_popup_maximize"></a><dl> <dt><b>HBMMENU_POPUP_MAXIMIZE</b></dt> <dt>((HBITMAP) 10)</dt> </dl> </td>
    ///<td width="60%"> Maximize button for the submenu. </td> </tr> <tr> <td width="40%"><a
    ///id="HBMMENU_POPUP_MINIMIZE"></a><a id="hbmmenu_popup_minimize"></a><dl> <dt><b>HBMMENU_POPUP_MINIMIZE</b></dt>
    ///<dt>((HBITMAP) 11)</dt> </dl> </td> <td width="60%"> Minimize button for the submenu. </td> </tr> <tr> <td
    ///width="40%"><a id="HBMMENU_POPUP_RESTORE"></a><a id="hbmmenu_popup_restore"></a><dl>
    ///<dt><b>HBMMENU_POPUP_RESTORE</b></dt> <dt>((HBITMAP) 9)</dt> </dl> </td> <td width="60%"> Restore button for the
    ///submenu. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_SYSTEM"></a><a id="hbmmenu_system"></a><dl>
    ///<dt><b>HBMMENU_SYSTEM</b></dt> <dt>((HBITMAP) 1)</dt> </dl> </td> <td width="60%"> Windows icon or the icon of
    ///the window specified in <b>dwItemData</b>. </td> </tr> </table>
    HBITMAP hbmpItem;
}

///Contains information about a menu item.
struct MENUITEMINFOW
{
    ///Type: <b>UINT</b> The size of the structure, in bytes. The caller must set this member to
    ///<code>sizeof(MENUITEMINFO)</code>.
    uint    cbSize;
    ///Type: <b>UINT</b> Indicates the members to be retrieved or set. This member can be one or more of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIIM_BITMAP"></a><a
    ///id="miim_bitmap"></a><dl> <dt><b>MIIM_BITMAP</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Retrieves
    ///or sets the <b>hbmpItem</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_CHECKMARKS"></a><a
    ///id="miim_checkmarks"></a><dl> <dt><b>MIIM_CHECKMARKS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
    ///Retrieves or sets the <b>hbmpChecked</b> and <b>hbmpUnchecked</b> members. </td> </tr> <tr> <td width="40%"><a
    ///id="MIIM_DATA"></a><a id="miim_data"></a><dl> <dt><b>MIIM_DATA</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> Retrieves or sets the <b>dwItemData</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="MIIM_FTYPE"></a><a id="miim_ftype"></a><dl> <dt><b>MIIM_FTYPE</b></dt> <dt>0x00000100</dt> </dl> </td> <td
    ///width="60%"> Retrieves or sets the <b>fType</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_ID"></a><a
    ///id="miim_id"></a><dl> <dt><b>MIIM_ID</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Retrieves or sets
    ///the <b>wID</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_STATE"></a><a id="miim_state"></a><dl>
    ///<dt><b>MIIM_STATE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Retrieves or sets the <b>fState</b>
    ///member. </td> </tr> <tr> <td width="40%"><a id="MIIM_STRING"></a><a id="miim_string"></a><dl>
    ///<dt><b>MIIM_STRING</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Retrieves or sets the
    ///<b>dwTypeData</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_SUBMENU"></a><a id="miim_submenu"></a><dl>
    ///<dt><b>MIIM_SUBMENU</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Retrieves or sets the
    ///<b>hSubMenu</b> member. </td> </tr> <tr> <td width="40%"><a id="MIIM_TYPE"></a><a id="miim_type"></a><dl>
    ///<dt><b>MIIM_TYPE</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Retrieves or sets the <b>fType</b> and
    ///<b>dwTypeData</b> members. <b>MIIM_TYPE</b> is replaced by <b>MIIM_BITMAP</b>, <b>MIIM_FTYPE</b>, and
    ///<b>MIIM_STRING</b>. </td> </tr> </table>
    uint    fMask;
    ///Type: <b>UINT</b> The menu item type. This member can be one or more of the following values. The
    ///<b>MFT_BITMAP</b>, <b>MFT_SEPARATOR</b>, and <b>MFT_STRING</b> values cannot be combined with one another. Set
    ///<b>fMask</b> to <b>MIIM_TYPE</b> to use <b>fType</b>. <b>fType</b> is used only if <b>fMask</b> has a value of
    ///<b>MIIM_FTYPE</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MFT_BITMAP"></a><a id="mft_bitmap"></a><dl> <dt><b>MFT_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td
    ///width="60%"> Displays the menu item using a bitmap. The low-order word of the <b>dwTypeData</b> member is the
    ///bitmap handle, and the <b>cch</b> member is ignored. <b>MFT_BITMAP</b> is replaced by <b>MIIM_BITMAP</b> and
    ///<b>hbmpItem</b>. </td> </tr> <tr> <td width="40%"><a id="MFT_MENUBARBREAK"></a><a id="mft_menubarbreak"></a><dl>
    ///<dt><b>MFT_MENUBARBREAK</b></dt> <dt>0x00000020L</dt> </dl> </td> <td width="60%"> Places the menu item on a new
    ///line (for a menu bar) or in a new column (for a drop-down menu, submenu, or shortcut menu). For a drop-down menu,
    ///submenu, or shortcut menu, a vertical line separates the new column from the old. </td> </tr> <tr> <td
    ///width="40%"><a id="MFT_MENUBREAK"></a><a id="mft_menubreak"></a><dl> <dt><b>MFT_MENUBREAK</b></dt>
    ///<dt>0x00000040L</dt> </dl> </td> <td width="60%"> Places the menu item on a new line (for a menu bar) or in a new
    ///column (for a drop-down menu, submenu, or shortcut menu). For a drop-down menu, submenu, or shortcut menu, the
    ///columns are not separated by a vertical line. </td> </tr> <tr> <td width="40%"><a id="MFT_OWNERDRAW"></a><a
    ///id="mft_ownerdraw"></a><dl> <dt><b>MFT_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%">
    ///Assigns responsibility for drawing the menu item to the window that owns the menu. The window receives a
    ///WM_MEASUREITEM message before the menu is displayed for the first time, and a WM_DRAWITEM message whenever the
    ///appearance of the menu item must be updated. If this value is specified, the <b>dwTypeData</b> member contains an
    ///application-defined value. </td> </tr> <tr> <td width="40%"><a id="MFT_RADIOCHECK"></a><a
    ///id="mft_radiocheck"></a><dl> <dt><b>MFT_RADIOCHECK</b></dt> <dt>0x00000200L</dt> </dl> </td> <td width="60%">
    ///Displays selected menu items using a radio-button mark instead of a check mark if the <b>hbmpChecked</b> member
    ///is <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="MFT_RIGHTJUSTIFY"></a><a id="mft_rightjustify"></a><dl>
    ///<dt><b>MFT_RIGHTJUSTIFY</b></dt> <dt>0x00004000L</dt> </dl> </td> <td width="60%"> Right-justifies the menu item
    ///and any subsequent items. This value is valid only if the menu item is in a menu bar. </td> </tr> <tr> <td
    ///width="40%"><a id="MFT_RIGHTORDER"></a><a id="mft_rightorder"></a><dl> <dt><b>MFT_RIGHTORDER</b></dt>
    ///<dt>0x00002000L</dt> </dl> </td> <td width="60%"> Specifies that menus cascade right-to-left (the default is
    ///left-to-right). This is used to support right-to-left languages, such as Arabic and Hebrew. </td> </tr> <tr> <td
    ///width="40%"><a id="MFT_SEPARATOR"></a><a id="mft_separator"></a><dl> <dt><b>MFT_SEPARATOR</b></dt>
    ///<dt>0x00000800L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is a separator. A menu item
    ///separator appears as a horizontal dividing line. The <b>dwTypeData</b> and <b>cch</b> members are ignored. This
    ///value is valid only in a drop-down menu, submenu, or shortcut menu. </td> </tr> <tr> <td width="40%"><a
    ///id="MFT_STRING"></a><a id="mft_string"></a><dl> <dt><b>MFT_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td
    ///width="60%"> Displays the menu item using a text string. The <b>dwTypeData</b> member is the pointer to a
    ///null-terminated string, and the <b>cch</b> member is the length of the string. <b>MFT_STRING</b> is replaced by
    ///<b>MIIM_STRING</b>. </td> </tr> </table>
    uint    fType;
    ///Type: <b>UINT</b> The menu item state. This member can be one or more of these values. Set <b>fMask</b> to
    ///<b>MIIM_STATE</b> to use <b>fState</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="MFS_CHECKED"></a><a id="mfs_checked"></a><dl> <dt><b>MFS_CHECKED</b></dt> <dt>0x00000008L</dt>
    ///</dl> </td> <td width="60%"> Checks the menu item. For more information about selected menu items, see the
    ///<b>hbmpChecked</b> member. </td> </tr> <tr> <td width="40%"><a id="MFS_DEFAULT"></a><a id="mfs_default"></a><dl>
    ///<dt><b>MFS_DEFAULT</b></dt> <dt>0x00001000L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is the
    ///default. A menu can contain only one default menu item, which is displayed in bold. </td> </tr> <tr> <td
    ///width="40%"><a id="MFS_DISABLED"></a><a id="mfs_disabled"></a><dl> <dt><b>MFS_DISABLED</b></dt>
    ///<dt>0x00000003L</dt> </dl> </td> <td width="60%"> Disables the menu item and grays it so that it cannot be
    ///selected. This is equivalent to <b>MFS_GRAYED</b>. </td> </tr> <tr> <td width="40%"><a id="MFS_ENABLED"></a><a
    ///id="mfs_enabled"></a><dl> <dt><b>MFS_ENABLED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables
    ///the menu item so that it can be selected. This is the default state. </td> </tr> <tr> <td width="40%"><a
    ///id="MFS_GRAYED"></a><a id="mfs_grayed"></a><dl> <dt><b>MFS_GRAYED</b></dt> <dt>0x00000003L</dt> </dl> </td> <td
    ///width="60%"> Disables the menu item and grays it so that it cannot be selected. This is equivalent to
    ///<b>MFS_DISABLED</b>. </td> </tr> <tr> <td width="40%"><a id="MFS_HILITE"></a><a id="mfs_hilite"></a><dl>
    ///<dt><b>MFS_HILITE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td width="60%"> Highlights the menu item. </td>
    ///</tr> <tr> <td width="40%"><a id="MFS_UNCHECKED"></a><a id="mfs_unchecked"></a><dl> <dt><b>MFS_UNCHECKED</b></dt>
    ///<dt>0x00000000L</dt> </dl> </td> <td width="60%"> Unchecks the menu item. For more information about clear menu
    ///items, see the <b>hbmpChecked</b> member. </td> </tr> <tr> <td width="40%"><a id="MFS_UNHILITE"></a><a
    ///id="mfs_unhilite"></a><dl> <dt><b>MFS_UNHILITE</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Removes
    ///the highlight from the menu item. This is the default state. </td> </tr> </table>
    uint    fState;
    ///Type: <b>UINT</b> An application-defined value that identifies the menu item. Set <b>fMask</b> to <b>MIIM_ID</b>
    ///to use <b>wID</b>.
    uint    wID;
    ///Type: <b>HMENU</b> A handle to the drop-down menu or submenu associated with the menu item. If the menu item is
    ///not an item that opens a drop-down menu or submenu, this member is <b>NULL</b>. Set <b>fMask</b> to
    ///<b>MIIM_SUBMENU</b> to use <b>hSubMenu</b>.
    HMENU   hSubMenu;
    ///Type: <b>HBITMAP</b> A handle to the bitmap to display next to the item if it is selected. If this member is
    ///<b>NULL</b>, a default bitmap is used. If the <b>MFT_RADIOCHECK</b> type value is specified, the default bitmap
    ///is a bullet. Otherwise, it is a check mark. Set <b>fMask</b> to <b>MIIM_CHECKMARKS</b> to use <b>hbmpChecked</b>.
    HBITMAP hbmpChecked;
    ///Type: <b>HBITMAP</b> A handle to the bitmap to display next to the item if it is not selected. If this member is
    ///<b>NULL</b>, no bitmap is used. Set <b>fMask</b> to <b>MIIM_CHECKMARKS</b> to use <b>hbmpUnchecked</b>.
    HBITMAP hbmpUnchecked;
    ///Type: <b>ULONG_PTR</b> An application-defined value associated with the menu item. Set <b>fMask</b> to
    ///<b>MIIM_DATA</b> to use <b>dwItemData</b>.
    size_t  dwItemData;
    ///Type: <b>LPTSTR</b> The contents of the menu item. The meaning of this member depends on the value of
    ///<b>fType</b> and is used only if the <b>MIIM_TYPE</b> flag is set in the <b>fMask</b> member. To retrieve a menu
    ///item of type <b>MFT_STRING</b>, first find the size of the string by setting the <b>dwTypeData</b> member of
    ///<b>MENUITEMINFO</b> to <b>NULL</b> and then calling GetMenuItemInfo. The value of <b>cch</b>+1 is the size
    ///needed. Then allocate a buffer of this size, place the pointer to the buffer in <b>dwTypeData</b>, increment
    ///<b>cch</b>, and call <b>GetMenuItemInfo</b> once again to fill the buffer with the string. If the retrieved menu
    ///item is of some other type, then <b>GetMenuItemInfo</b> sets the <b>dwTypeData</b> member to a value whose type
    ///is specified by the <b>fType</b> member. When using with the SetMenuItemInfo function, this member should contain
    ///a value whose type is specified by the <b>fType</b> member. <b>dwTypeData</b> is used only if the
    ///<b>MIIM_STRING</b> flag is set in the <b>fMask</b> member
    PWSTR   dwTypeData;
    ///Type: <b>UINT</b> The length of the menu item text, in characters, when information is received about a menu item
    ///of the <b>MFT_STRING</b> type. However, <b>cch</b> is used only if the <b>MIIM_TYPE</b> flag is set in the
    ///<b>fMask</b> member and is zero otherwise. Also, <b>cch</b> is ignored when the content of a menu item is set by
    ///calling SetMenuItemInfo. Note that, before calling GetMenuItemInfo, the application must set <b>cch</b> to the
    ///length of the buffer pointed to by the <b>dwTypeData</b> member. If the retrieved menu item is of type
    ///<b>MFT_STRING</b> (as indicated by the <b>fType</b> member), then <b>GetMenuItemInfo</b> changes <b>cch</b> to
    ///the length of the menu item text. If the retrieved menu item is of some other type, <b>GetMenuItemInfo</b> sets
    ///the <b>cch</b> field to zero. The <b>cch</b> member is used when the <b>MIIM_STRING</b> flag is set in the
    ///<b>fMask</b> member.
    uint    cch;
    ///Type: <b>HBITMAP</b> A handle to the bitmap to be displayed, or it can be one of the values in the following
    ///table. It is used when the <b>MIIM_BITMAP</b> flag is set in the <b>fMask</b> member. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="HBMMENU_CALLBACK"></a><a id="hbmmenu_callback"></a><dl>
    ///<dt><b>HBMMENU_CALLBACK</b></dt> <dt>((HBITMAP) -1)</dt> </dl> </td> <td width="60%"> A bitmap that is drawn by
    ///the window that owns the menu. The application must process the WM_MEASUREITEM and WM_DRAWITEM messages. </td>
    ///</tr> <tr> <td width="40%"><a id="HBMMENU_MBAR_CLOSE"></a><a id="hbmmenu_mbar_close"></a><dl>
    ///<dt><b>HBMMENU_MBAR_CLOSE</b></dt> <dt>((HBITMAP) 5)</dt> </dl> </td> <td width="60%"> Close button for the menu
    ///bar. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_MBAR_CLOSE_D"></a><a id="hbmmenu_mbar_close_d"></a><dl>
    ///<dt><b>HBMMENU_MBAR_CLOSE_D</b></dt> <dt>((HBITMAP) 6)</dt> </dl> </td> <td width="60%"> Disabled close button
    ///for the menu bar. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_MBAR_MINIMIZE"></a><a
    ///id="hbmmenu_mbar_minimize"></a><dl> <dt><b>HBMMENU_MBAR_MINIMIZE</b></dt> <dt>((HBITMAP) 3)</dt> </dl> </td> <td
    ///width="60%"> Minimize button for the menu bar. </td> </tr> <tr> <td width="40%"><a
    ///id="HBMMENU_MBAR_MINIMIZE_D"></a><a id="hbmmenu_mbar_minimize_d"></a><dl> <dt><b>HBMMENU_MBAR_MINIMIZE_D</b></dt>
    ///<dt>((HBITMAP) 7)</dt> </dl> </td> <td width="60%"> Disabled minimize button for the menu bar. </td> </tr> <tr>
    ///<td width="40%"><a id="HBMMENU_MBAR_RESTORE"></a><a id="hbmmenu_mbar_restore"></a><dl>
    ///<dt><b>HBMMENU_MBAR_RESTORE</b></dt> <dt>((HBITMAP) 2)</dt> </dl> </td> <td width="60%"> Restore button for the
    ///menu bar. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_POPUP_CLOSE"></a><a id="hbmmenu_popup_close"></a><dl>
    ///<dt><b>HBMMENU_POPUP_CLOSE</b></dt> <dt>((HBITMAP) 8)</dt> </dl> </td> <td width="60%"> Close button for the
    ///submenu. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_POPUP_MAXIMIZE"></a><a
    ///id="hbmmenu_popup_maximize"></a><dl> <dt><b>HBMMENU_POPUP_MAXIMIZE</b></dt> <dt>((HBITMAP) 10)</dt> </dl> </td>
    ///<td width="60%"> Maximize button for the submenu. </td> </tr> <tr> <td width="40%"><a
    ///id="HBMMENU_POPUP_MINIMIZE"></a><a id="hbmmenu_popup_minimize"></a><dl> <dt><b>HBMMENU_POPUP_MINIMIZE</b></dt>
    ///<dt>((HBITMAP) 11)</dt> </dl> </td> <td width="60%"> Minimize button for the submenu. </td> </tr> <tr> <td
    ///width="40%"><a id="HBMMENU_POPUP_RESTORE"></a><a id="hbmmenu_popup_restore"></a><dl>
    ///<dt><b>HBMMENU_POPUP_RESTORE</b></dt> <dt>((HBITMAP) 9)</dt> </dl> </td> <td width="60%"> Restore button for the
    ///submenu. </td> </tr> <tr> <td width="40%"><a id="HBMMENU_SYSTEM"></a><a id="hbmmenu_system"></a><dl>
    ///<dt><b>HBMMENU_SYSTEM</b></dt> <dt>((HBITMAP) 1)</dt> </dl> </td> <td width="60%"> Windows icon or the icon of
    ///the window specified in <b>dwItemData</b>. </td> </tr> </table>
    HBITMAP hbmpItem;
}

struct DROPSTRUCT
{
    HWND   hwndSource;
    HWND   hwndSink;
    uint   wFmt;
    size_t dwData;
    POINT  ptDrop;
    uint   dwControlData;
}

///Defines the header for a menu template. A complete menu template consists of a header and one or more menu item
///lists.
struct MENUITEMTEMPLATEHEADER
{
    ///Type: <b>WORD</b> The version number. This member must be zero.
    ushort versionNumber;
    ///Type: <b>WORD</b> The offset, in bytes, from the end of the header. The menu item list begins at this offset.
    ///Usually, this member is zero, and the menu item list follows immediately after the header.
    ushort offset;
}

///Defines a menu item in a menu template.
struct MENUITEMTEMPLATE
{
    ///Type: <b>WORD</b> One or more of the following predefined menu options that control the appearance of the menu
    ///item as shown in the following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
    ///width="60%"> Indicates that the menu item has a check mark next to it. </td> </tr> <tr> <td width="40%"><a
    ///id="MF_GRAYED"></a><a id="mf_grayed"></a><dl> <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td
    ///width="60%"> Indicates that the menu item is initially inactive and drawn with a gray effect. </td> </tr> <tr>
    ///<td width="40%"><a id="MF_HELP"></a><a id="mf_help"></a><dl> <dt><b>MF_HELP</b></dt> <dt>0x00004000L</dt> </dl>
    ///</td> <td width="60%"> Indicates that the menu item has a vertical separator to its left. </td> </tr> <tr> <td
    ///width="40%"><a id="MF_MENUBARBREAK"></a><a id="mf_menubarbreak"></a><dl> <dt><b>MF_MENUBARBREAK</b></dt>
    ///<dt>0x00000020L</dt> </dl> </td> <td width="60%"> Indicates that the menu item is placed in a new column. The old
    ///and new columns are separated by a bar. </td> </tr> <tr> <td width="40%"><a id="MF_MENUBREAK"></a><a
    ///id="mf_menubreak"></a><dl> <dt><b>MF_MENUBREAK</b></dt> <dt>0x00000040L</dt> </dl> </td> <td width="60%">
    ///Indicates that the menu item is placed in a new column. </td> </tr> <tr> <td width="40%"><a
    ///id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl> <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td>
    ///<td width="60%"> Indicates that the owner window of the menu is responsible for drawing all visual aspects of the
    ///menu item, including highlighted, selected, and inactive states. This option is not valid for an item in a menu
    ///bar. </td> </tr> <tr> <td width="40%"><a id="MF_POPUP"></a><a id="mf_popup"></a><dl> <dt><b>MF_POPUP</b></dt>
    ///<dt>0x00000010L</dt> </dl> </td> <td width="60%"> Indicates that the item is one that opens a drop-down menu or
    ///submenu. </td> </tr> </table>
    ushort    mtOption;
    ///Type: <b>WORD</b> The menu item identifier of a command item; a command item sends a command message to its owner
    ///window. The <b>MENUITEMTEMPLATE</b> structure for an item that opens a drop-down menu or submenu does not contain
    ///the <b>mtID</b> member.
    ushort    mtID;
    ///Type: <b>WCHAR[1]</b> The menu item.
    ushort[1] mtString;
}

///Contains information about an icon or a cursor.
struct ICONINFO
{
    ///Type: <b>BOOL</b> Specifies whether this structure defines an icon or a cursor. A value of <b>TRUE</b> specifies
    ///an icon; <b>FALSE</b> specifies a cursor.
    BOOL    fIcon;
    ///Type: <b>DWORD</b> The x-coordinate of a cursor's hot spot. If this structure defines an icon, the hot spot is
    ///always in the center of the icon, and this member is ignored.
    uint    xHotspot;
    ///Type: <b>DWORD</b> The y-coordinate of the cursor's hot spot. If this structure defines an icon, the hot spot is
    ///always in the center of the icon, and this member is ignored.
    uint    yHotspot;
    ///Type: <b>HBITMAP</b> The icon bitmask bitmap. If this structure defines a black and white icon, this bitmask is
    ///formatted so that the upper half is the icon AND bitmask and the lower half is the icon XOR bitmask. Under this
    ///condition, the height should be an even multiple of two. If this structure defines a color icon, this mask only
    ///defines the AND bitmask of the icon.
    HBITMAP hbmMask;
    ///Type: <b>HBITMAP</b> A handle to the icon color bitmap. This member can be optional if this structure defines a
    ///black and white icon. The AND bitmask of <b>hbmMask</b> is applied with the <b>SRCAND</b> flag to the
    ///destination; subsequently, the color bitmap is applied (using XOR) to the destination by using the
    ///<b>SRCINVERT</b> flag.
    HBITMAP hbmColor;
}

///Contains information about a cursor.
struct CURSORSHAPE
{
    ///Type: <b>int</b> The horizontal position of the hot spot, relative to the upper-left corner of the cursor bitmap.
    int   xHotSpot;
    ///Type: <b>int</b> The vertical position of the hot spot, relative to the upper-left corner of the cursor bitmap.
    int   yHotSpot;
    ///Type: <b>int</b> The width, in pixels, of the cursor.
    int   cx;
    ///Type: <b>int</b> The height, in pixels, of the cursor.
    int   cy;
    ///Type: <b>int</b> The width, in bytes, of the cursor bitmap.
    int   cbWidth;
    ///Type: <b>BYTE</b> The number of color planes.
    ubyte Planes;
    ///Type: <b>BYTE</b> The number of bits used to indicate the color of a single pixel in the cursor.
    ubyte BitsPixel;
}

///Contains information about an icon or a cursor. Extends ICONINFO. Used by GetIconInfoEx.
struct ICONINFOEXA
{
    ///Type: <b>DWORD</b> The size, in bytes, of this structure.
    uint      cbSize;
    ///Type: <b>BOOL</b> Specifies whether this structure defines an icon or a cursor. A value of <b>TRUE</b> specifies
    ///an icon; <b>FALSE</b> specifies a cursor.
    BOOL      fIcon;
    ///Type: <b>DWORD</b> The x-coordinate of a cursor's hot spot. If this structure defines an icon, the hot spot is
    ///always in the center of the icon, and this member is ignored.
    uint      xHotspot;
    ///Type: <b>DWORD</b> The y-coordinate of the cursor's hot spot. If this structure defines an icon, the hot spot is
    ///always in the center of the icon, and this member is ignored.
    uint      yHotspot;
    ///Type: <b>HBITMAP</b> The icon bitmask bitmap. If this structure defines a black and white icon, this bitmask is
    ///formatted so that the upper half is the icon AND bitmask and the lower half is the icon XOR bitmask. Under this
    ///condition, the height should be an even multiple of two. If this structure defines a color icon, this mask only
    ///defines the AND bitmask of the icon.
    HBITMAP   hbmMask;
    ///Type: <b>HBITMAP</b> A handle to the icon color bitmap. This member can be optional if this structure defines a
    ///black and white icon. The AND bitmask of <b>hbmMask</b> is applied with the <b>SRCAND</b> flag to the
    ///destination; subsequently, the color bitmap is applied (using XOR) to the destination by using the
    ///<b>SRCINVERT</b> flag.
    HBITMAP   hbmColor;
    ///Type: <b>WORD</b> The icon or cursor resource bits. These bits are typically loaded by calls to the
    ///LookupIconIdFromDirectoryEx and LoadResource functions.
    ushort    wResID;
    ///Type: <b>TCHAR[MAX_PATH]</b> The fully qualified path of the module.
    byte[260] szModName;
    ///Type: <b>TCHAR[MAX_PATH]</b> The fully qualified path of the resource.
    byte[260] szResName;
}

///Contains information about an icon or a cursor. Extends ICONINFO. Used by GetIconInfoEx.
struct ICONINFOEXW
{
    ///Type: <b>DWORD</b> The size, in bytes, of this structure.
    uint        cbSize;
    ///Type: <b>BOOL</b> Specifies whether this structure defines an icon or a cursor. A value of <b>TRUE</b> specifies
    ///an icon; <b>FALSE</b> specifies a cursor.
    BOOL        fIcon;
    ///Type: <b>DWORD</b> The x-coordinate of a cursor's hot spot. If this structure defines an icon, the hot spot is
    ///always in the center of the icon, and this member is ignored.
    uint        xHotspot;
    ///Type: <b>DWORD</b> The y-coordinate of the cursor's hot spot. If this structure defines an icon, the hot spot is
    ///always in the center of the icon, and this member is ignored.
    uint        yHotspot;
    ///Type: <b>HBITMAP</b> The icon bitmask bitmap. If this structure defines a black and white icon, this bitmask is
    ///formatted so that the upper half is the icon AND bitmask and the lower half is the icon XOR bitmask. Under this
    ///condition, the height should be an even multiple of two. If this structure defines a color icon, this mask only
    ///defines the AND bitmask of the icon.
    HBITMAP     hbmMask;
    ///Type: <b>HBITMAP</b> A handle to the icon color bitmap. This member can be optional if this structure defines a
    ///black and white icon. The AND bitmask of <b>hbmMask</b> is applied with the <b>SRCAND</b> flag to the
    ///destination; subsequently, the color bitmap is applied (using XOR) to the destination by using the
    ///<b>SRCINVERT</b> flag.
    HBITMAP     hbmColor;
    ///Type: <b>WORD</b> The icon or cursor resource bits. These bits are typically loaded by calls to the
    ///LookupIconIdFromDirectoryEx and LoadResource functions.
    ushort      wResID;
    ///Type: <b>TCHAR[MAX_PATH]</b> The fully qualified path of the module.
    ushort[260] szModName;
    ///Type: <b>TCHAR[MAX_PATH]</b> The fully qualified path of the resource.
    ushort[260] szResName;
}

struct TouchPredictionParameters
{
    uint cbSize;
    uint dwLatency;
    uint dwSampleTime;
    uint bUseHWTimeStamp;
}

///Contains the scalable metrics associated with icons. This structure is used with the SystemParametersInfo function
///when the <b>SPI_GETICONMETRICS</b> or <b>SPI_SETICONMETRICS</b> action is specified.
struct ICONMETRICSA
{
    ///Type: <b>UINT</b> The size of the structure, in bytes.
    uint     cbSize;
    ///Type: <b>int</b> The horizontal space, in pixels, for each arranged icon.
    int      iHorzSpacing;
    ///Type: <b>int</b> The vertical space, in pixels, for each arranged icon.
    int      iVertSpacing;
    ///Type: <b>int</b> If this member is nonzero, icon titles wrap to a new line. If this member is zero, titles do not
    ///wrap.
    int      iTitleWrap;
    ///Type: <b>LOGFONT</b> The font to use for icon titles.
    LOGFONTA lfFont;
}

///Contains the scalable metrics associated with icons. This structure is used with the SystemParametersInfo function
///when the <b>SPI_GETICONMETRICS</b> or <b>SPI_SETICONMETRICS</b> action is specified.
struct ICONMETRICSW
{
    ///Type: <b>UINT</b> The size of the structure, in bytes.
    uint     cbSize;
    ///Type: <b>int</b> The horizontal space, in pixels, for each arranged icon.
    int      iHorzSpacing;
    ///Type: <b>int</b> The vertical space, in pixels, for each arranged icon.
    int      iVertSpacing;
    ///Type: <b>int</b> If this member is nonzero, icon titles wrap to a new line. If this member is zero, titles do not
    ///wrap.
    int      iTitleWrap;
    ///Type: <b>LOGFONT</b> The font to use for icon titles.
    LOGFONTW lfFont;
}

///Contains global cursor information.
struct CURSORINFO
{
    ///Type: <b>DWORD</b> The size of the structure, in bytes. The caller must set this to
    ///<code>sizeof(CURSORINFO)</code>.
    uint    cbSize;
    ///Type: <b>DWORD</b> The cursor state. This parameter can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The
    ///cursor is hidden. </td> </tr> <tr> <td width="40%"><a id="CURSOR_SHOWING"></a><a id="cursor_showing"></a><dl>
    ///<dt><b>CURSOR_SHOWING</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The cursor is showing. </td>
    ///</tr> <tr> <td width="40%"><a id="CURSOR_SUPPRESSED"></a><a id="cursor_suppressed"></a><dl>
    ///<dt><b>CURSOR_SUPPRESSED</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> <b>Windows 8</b>: The cursor
    ///is suppressed. This flag indicates that the system is not drawing the cursor because the user is providing input
    ///through touch or pen instead of the mouse. </td> </tr> </table>
    uint    flags;
    ///Type: <b>HCURSOR</b> A handle to the cursor.
    HCURSOR hCursor;
    ///Type: <b>POINT</b> A structure that receives the screen coordinates of the cursor.
    POINT   ptScreenPos;
}

///Contains menu bar information.
struct MENUBARINFO
{
    ///Type: <b>DWORD</b> The size of the structure, in bytes. The caller must set this to
    ///<code>sizeof(MENUBARINFO)</code>.
    uint  cbSize;
    ///Type: <b>RECT</b> The coordinates of the menu bar, popup menu, or menu item.
    RECT  rcBar;
    ///Type: <b>HMENU</b> A handle to the menu bar or popup menu.
    HMENU hMenu;
    ///Type: <b>HWND</b> A handle to the submenu.
    HWND  hwndMenu;
    int   _bitfield69;
}

///Represents the context under which a resource is appropriate.
struct IndexedResourceQualifier
{
    ///The name of the qualifier, such as "language", "contrast", or "scale".
    PWSTR name;
    ///The value of the qualifier. You should preserve the case of the qualifier value from the first instance of the
    ///qualifier discovered during indexing. The following values are examples of the qualifier values: <ul> <li>"100",
    ///"140", or "180" for scale.</li> <li>"fr-FR" for language.</li> <li>"high" for contrast. </li> </ul>
    PWSTR value;
}

struct MrmResourceIndexerHandle
{
    void* handle;
}

struct MrmResourceIndexerMessage
{
    MrmResourceIndexerMessageSeverity severity;
    uint         id;
    const(PWSTR) text;
}

@RAIIFree!DestroyAcceleratorTable
struct HACCEL
{
    ptrdiff_t Value;
}

@RAIIFree!DestroyMenu
struct HMENU
{
    ptrdiff_t Value;
}

///Contains the error message or message box display text for a message table resource.
struct MESSAGE_RESOURCE_ENTRY
{
    ///Type: <b>WORD</b> The length, in bytes, of the <b>MESSAGE_RESOURCE_ENTRY</b> structure.
    ushort   Length;
    ///Type: <b>WORD</b> Indicates that the string is encoded in Unicode, if equal to the value 0x0001. Indicates that
    ///the string is encoded in ANSI, if equal to the value 0x0000.
    ushort   Flags;
    ///Type: <b>BYTE[1]</b> Pointer to an array that contains the error message or message box display text.
    ubyte[1] Text;
}

///Contains information about message strings with identifiers in the range indicated by the <b>LowId</b> and
///<b>HighId</b> members.
struct MESSAGE_RESOURCE_BLOCK
{
    ///Type: <b>DWORD</b> The lowest message identifier contained within this structure.
    uint LowId;
    ///Type: <b>DWORD</b> The highest message identifier contained within this structure.
    uint HighId;
    ///Type: <b>DWORD</b> The offset, in bytes, from the beginning of the MESSAGE_RESOURCE_DATA structure to the
    ///MESSAGE_RESOURCE_ENTRY structures in this <b>MESSAGE_RESOURCE_BLOCK</b>. The <b>MESSAGE_RESOURCE_ENTRY</b>
    ///structures contain the message strings.
    uint OffsetToEntries;
}

///Contains information about formatted text for display as an error message or in a message box in a message table
///resource.
struct MESSAGE_RESOURCE_DATA
{
    ///Type: <b>DWORD</b> The number of MESSAGE_RESOURCE_BLOCK structures.
    uint NumberOfBlocks;
    ///Type: <b>MESSAGE_RESOURCE_BLOCK[1]</b> An array of structures. The array is the size indicated by the
    ///<b>NumberOfBlocks</b> member.
    MESSAGE_RESOURCE_BLOCK[1] Blocks;
}

// Functions

///<p class="CCE_Message">[This function is obsolete and is only supported for backward compatibility with 16-bit
///Windows. For 32-bit Windows applications, it is not necessary to free the resources loaded using LoadResource. If
///used on 32 or 64-bit Windows systems, this function will return <b>FALSE</b>.] Decrements (decreases by one) the
///reference count of a loaded resource. When the reference count reaches zero, the memory occupied by the resource is
///freed.
///Params:
///    hResData = Type: <b>HGLOBAL</b> A handle of the resource. It is assumed that <i>hglbResource</i> was created by
///               LoadResource.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is zero. If the function fails, the return value is
///    nonzero, which indicates that the resource has not been freed.
///    
@DllImport("KERNEL32")
BOOL FreeResource(ptrdiff_t hResData);

///Retrieves a handle that can be used to obtain a pointer to the first byte of the specified resource in memory.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose executable file contains the resource. If <i>hModule</i> is
///              <b>NULL</b>, the system loads the resource from the module that was used to create the current process.
///    hResInfo = Type: <b>HRSRC</b> A handle to the resource to be loaded. This handle is returned by the FindResource or
///               FindResourceEx function.
///Returns:
///    Type: <b>HGLOBAL</b> If the function succeeds, the return value is a handle to the data associated with the
///    resource. If the function fails, the return value is <b>NULL</b>. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
ptrdiff_t LoadResource(ptrdiff_t hModule, HRSRC hResInfo);

///Loads a string resource from the executable file associated with a specified module and either copies the string into
///a buffer with a terminating null character or returns a read-only pointer to the string resource itself.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to an instance of the module whose executable file contains the string resource.
///                To get the handle to the application itself, call the GetModuleHandle function with <b>NULL</b>.
///    uID = Type: <b>UINT</b> The identifier of the string to be loaded.
///    lpBuffer = Type: <b>LPTSTR</b> The buffer to receive the string (if *cchBufferMax* is non-zero) or a read-only pointer to
///               the string resource itself (if *cchBufferMax* is zero). Must be of sufficient length to hold a pointer (8 bytes).
///    cchBufferMax = Type: <b>int</b> The size of the buffer, in characters. The string is truncated and null-terminated if it is
///                   longer than the number of characters specified. If this parameter is 0, then <i>lpBuffer</i> receives a read-only
///                   pointer to the string resource itself.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is one of the following: - The number of characters
///    copied into the buffer (if *cchBufferMax* is non-zero), not including the terminating null character. - The
///    number of characters in the string resource that *lpBuffer* points to (if *cchBufferMax* is zero). The string
///    resource is not guaranteed to be null-terminated in the module's resource table, and you can use this value to
///    determine where the string resource ends. - Zero if the string resource does not exist. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
int LoadStringA(HINSTANCE hInstance, uint uID, PSTR lpBuffer, int cchBufferMax);

///Loads a string resource from the executable file associated with a specified module and either copies the string into
///a buffer with a terminating null character or returns a read-only pointer to the string resource itself.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to an instance of the module whose executable file contains the string resource.
///                To get the handle to the application itself, call the GetModuleHandle function with <b>NULL</b>.
///    uID = Type: <b>UINT</b> The identifier of the string to be loaded.
///    lpBuffer = Type: <b>LPTSTR</b> The buffer to receive the string (if *cchBufferMax* is non-zero) or a read-only pointer to
///               the string resource itself (if *cchBufferMax* is zero). Must be of sufficient length to hold a pointer (8 bytes).
///    cchBufferMax = Type: <b>int</b> The size of the buffer, in characters. The string is truncated and null-terminated if it is
///                   longer than the number of characters specified. If this parameter is 0, then <i>lpBuffer</i> receives a read-only
///                   pointer to the string resource itself.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is one of the following: - The number of characters
///    copied into the buffer (if *cchBufferMax* is non-zero), not including the terminating null character. - The
///    number of characters in the string resource that *lpBuffer* points to (if *cchBufferMax* is zero). The string
///    resource is not guaranteed to be null-terminated in the module's resource table, and you can use this value to
///    determine where the string resource ends. - Zero if the string resource does not exist. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
int LoadStringW(HINSTANCE hInstance, uint uID, PWSTR lpBuffer, int cchBufferMax);

///Retrieves a pointer to the specified resource in memory.
///Params:
///    hResData = Type: **HGLOBAL** A handle to the resource to be accessed. The [LoadResource
///               function](nf-libloaderapi-loadresource.md) returns this handle. Note that this parameter is listed as an
///               **HGLOBAL** variable only for backward compatibility. Do not pass any value as a parameter other than a
///               successful return value from the **LoadResource** function.
///Returns:
///    Type: **LPVOID** If the loaded resource is available, the return value is a pointer to the first byte of the
///    resource; otherwise, it is **NULL**.
///    
@DllImport("KERNEL32")
void* LockResource(ptrdiff_t hResData);

///Retrieves the size, in bytes, of the specified resource.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose executable file contains the resource.
///    hResInfo = Type: <b>HRSRC</b> A handle to the resource. This handle must be created by using the FindResource or
///               FindResourceEx function.
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the number of bytes in the resource. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint SizeofResource(ptrdiff_t hModule, HRSRC hResInfo);

///Enumerates language-specific resources, of the specified type and name, associated with a specified binary module.
///Extends EnumResourceLanguages by allowing more control over the enumeration.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to search. Typically this is a language-neutral Portable Executable
///              (LN file), and if flag <b>RESOURCE_ENUM_MUI</b> is set, then appropriate .mui files are included in the search.
///              Alternately, this can be a handle to an .mui file or other LN file. If this is a specific .mui file, only that
///              file is searched for resources. If this parameter is <b>NULL</b>, it is equivalent to passing in a handle to the
///              module used to create the current process.
///    lpType = Type: <b>LPCTSTR</b> The type of the resource for which the language is being enumerated. Alternately, rather
///             than a pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined
///             resource type. For a list of predefined resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpName = Type: <b>LPCTSTR</b> The name of the resource for which the language is being enumerated. Alternately, rather
///             than a pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is the integer identifier of the resource.
///             For more information, see the Remarks section below.
///    lpEnumFunc = Type: <b>ENUMRESLANGPROC</b> A pointer to the callback function to be called for each enumerated resource
///                 language. For more information, see EnumResLangProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function. This parameter can be used in
///             error checking.
///    dwFlags = Type: <b>DWORD</b> The type of file to be searched. The following values are supported. Note that if
///              <i>dwFlags</i> is zero, then the <b>RESOURCE_ENUM_LN</b> and <b>RESOURCE_ENUM_MUI</b> flags are assumed to be
///              specified. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_MUI"></a><a id="resource_enum_mui"></a><dl> <dt><b>RESOURCE_ENUM_MUI</b></dt> <dt>0x0002</dt>
///              </dl> </td> <td width="60%"> Search for language-specific resources in .mui files associated with the LN file
///              specified by <i>hModule</i>. Alternately, if <i>LangId</i> is nonzero, the only .mui file searched will be the
///              one matching the specified <i>LangId</i>. Typically this flag should be used only if <i>hModule</i> references an
///              LN file. If <i>hModule</i> references an .mui file, then that file is actually covered by the <b>RESOURCE_LN</b>
///              flag, despite the name of the flag. See the Remarks section below for sequence of search. </td> </tr> <tr> <td
///              width="40%"><a id="RESOURCE_ENUM_LN"></a><a id="resource_enum_ln"></a><dl> <dt><b>RESOURCE_ENUM_LN</b></dt>
///              <dt>0x0001</dt> </dl> </td> <td width="60%"> Searches the file specified by <i>hModule</i>, regardless of whether
///              the file is an LN file, another type of LN file, or an .mui file. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_MUI_SYSTEM"></a><a id="resource_enum_mui_system"></a><dl>
///              <dt><b>RESOURCE_ENUM_MUI_SYSTEM</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> Restricts the .mui files
///              search to system-installed MUI languages. </td> </tr> <tr> <td width="40%"><a id="RESOURCE_ENUM_VALIDATE"></a><a
///              id="resource_enum_validate"></a><dl> <dt><b>RESOURCE_ENUM_VALIDATE</b></dt> <dt>0x0008</dt> </dl> </td> <td
///              width="60%"> Performs extra validation on the resource section and its reference in the PE header while doing the
///              enumeration to ensure that resources are properly formatted. </td> </tr> </table>
///    LangId = Type: <b>LANGID</b> The localization language used to filter the search in the .mui file. This parameter is used
///             only when the <b>RESOURCE_ENUM_MUI</b> flag is set in <i>dwFlags</i>. If zero is specified, then all .mui files
///             are included in the search. If a nonzero <i>LangId</i> is specified, then the only .mui file searched will be the
///             one matching the specified <i>LangId</i>.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if the function succeeds or <b>FALSE</b> if the function does not find a
///    resource of the type specified, or if the function fails for another reason. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceLanguagesExA(ptrdiff_t hModule, const(PSTR) lpType, const(PSTR) lpName, 
                              ENUMRESLANGPROCA lpEnumFunc, ptrdiff_t lParam, uint dwFlags, ushort LangId);

///Enumerates language-specific resources, of the specified type and name, associated with a specified binary module.
///Extends EnumResourceLanguages by allowing more control over the enumeration.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to search. Typically this is a language-neutral Portable Executable
///              (LN file), and if flag <b>RESOURCE_ENUM_MUI</b> is set, then appropriate .mui files are included in the search.
///              Alternately, this can be a handle to an .mui file or other LN file. If this is a specific .mui file, only that
///              file is searched for resources. If this parameter is <b>NULL</b>, it is equivalent to passing in a handle to the
///              module used to create the current process.
///    lpType = Type: <b>LPCTSTR</b> The type of the resource for which the language is being enumerated. Alternately, rather
///             than a pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined
///             resource type. For a list of predefined resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpName = Type: <b>LPCTSTR</b> The name of the resource for which the language is being enumerated. Alternately, rather
///             than a pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is the integer identifier of the resource.
///             For more information, see the Remarks section below.
///    lpEnumFunc = Type: <b>ENUMRESLANGPROC</b> A pointer to the callback function to be called for each enumerated resource
///                 language. For more information, see EnumResLangProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function. This parameter can be used in
///             error checking.
///    dwFlags = Type: <b>DWORD</b> The type of file to be searched. The following values are supported. Note that if
///              <i>dwFlags</i> is zero, then the <b>RESOURCE_ENUM_LN</b> and <b>RESOURCE_ENUM_MUI</b> flags are assumed to be
///              specified. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_MUI"></a><a id="resource_enum_mui"></a><dl> <dt><b>RESOURCE_ENUM_MUI</b></dt> <dt>0x0002</dt>
///              </dl> </td> <td width="60%"> Search for language-specific resources in .mui files associated with the LN file
///              specified by <i>hModule</i>. Alternately, if <i>LangId</i> is nonzero, the only .mui file searched will be the
///              one matching the specified <i>LangId</i>. Typically this flag should be used only if <i>hModule</i> references an
///              LN file. If <i>hModule</i> references an .mui file, then that file is actually covered by the <b>RESOURCE_LN</b>
///              flag, despite the name of the flag. See the Remarks section below for sequence of search. </td> </tr> <tr> <td
///              width="40%"><a id="RESOURCE_ENUM_LN"></a><a id="resource_enum_ln"></a><dl> <dt><b>RESOURCE_ENUM_LN</b></dt>
///              <dt>0x0001</dt> </dl> </td> <td width="60%"> Searches the file specified by <i>hModule</i>, regardless of whether
///              the file is an LN file, another type of LN file, or an .mui file. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_MUI_SYSTEM"></a><a id="resource_enum_mui_system"></a><dl>
///              <dt><b>RESOURCE_ENUM_MUI_SYSTEM</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> Restricts the .mui files
///              search to system-installed MUI languages. </td> </tr> <tr> <td width="40%"><a id="RESOURCE_ENUM_VALIDATE"></a><a
///              id="resource_enum_validate"></a><dl> <dt><b>RESOURCE_ENUM_VALIDATE</b></dt> <dt>0x0008</dt> </dl> </td> <td
///              width="60%"> Performs extra validation on the resource section and its reference in the PE header while doing the
///              enumeration to ensure that resources are properly formatted. </td> </tr> </table>
///    LangId = Type: <b>LANGID</b> The localization language used to filter the search in the .mui file. This parameter is used
///             only when the <b>RESOURCE_ENUM_MUI</b> flag is set in <i>dwFlags</i>. If zero is specified, then all .mui files
///             are included in the search. If a nonzero <i>LangId</i> is specified, then the only .mui file searched will be the
///             one matching the specified <i>LangId</i>.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if the function succeeds or <b>FALSE</b> if the function does not find a
///    resource of the type specified, or if the function fails for another reason. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceLanguagesExW(ptrdiff_t hModule, const(PWSTR) lpType, const(PWSTR) lpName, 
                              ENUMRESLANGPROCW lpEnumFunc, ptrdiff_t lParam, uint dwFlags, ushort LangId);

///Enumerates resources of a specified type that are associated with a specified binary module. The search can include
///both an LN file and its associated .mui files, or it can be limited in several ways.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to search. Typically this is an LN file, and if flag
///              <b>RESOURCE_ENUM_MUI</b> is set, then appropriate .mui files are included in the search. Alternately, this can be
///              a handle to an .mui file or other LN file. If this parameter is <b>NULL</b>, it is equivalent to passing in a
///              handle to the module used to create the current process.
///    lpType = Type: <b>LPCSTR</b> The type of the resource for which the name is being enumerated. Alternately, rather than a
///             pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined
///             resource type. For a list of predefined resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpEnumFunc = Type: <b>ENUMRESNAMEPROC</b> A pointer to the callback function to be called for each enumerated resource name.
///                 For more information, see EnumResNameProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function. This parameter can be used in
///             error checking.
///    dwFlags = Type: <b>DWORD</b> The type of file to search. The following values are supported. Note that if <i>dwFlags</i> is
///              zero, then the <b>RESOURCE_ENUM_LN</b> and <b>RESOURCE_ENUM_MUI</b> flags are assumed to be specified. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCE_ENUM_MUI"></a><a
///              id="resource_enum_mui"></a><dl> <dt><b>RESOURCE_ENUM_MUI</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%">
///              Search for resources in .mui files associated with the LN file specified by <i>hModule</i> and with the current
///              language preferences, following the usual Resource Loader strategy (see User Interface Language Management).
///              Alternately, if <i>LangId</i> is nonzero, then only the specified .mui file will be searched. Typically this flag
///              should be used only if <i>hModule</i> references an LN file. If <i>hModule</i> references an .mui file, then that
///              file is actually covered by the <b>RESOURCE_ENUM_LN</b> flag, despite the name of the flag. </td> </tr> <tr> <td
///              width="40%"><a id="RESOURCE_ENUM_LN"></a><a id="resource_enum_ln"></a><dl> <dt><b>RESOURCE_ENUM_LN</b></dt>
///              <dt>0x0001</dt> </dl> </td> <td width="60%"> Searches the file specified by <i>hModule</i>, regardless of whether
///              the file is an LN file, another type of LN file, or an .mui file. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_VALIDATE"></a><a id="resource_enum_validate"></a><dl> <dt><b>RESOURCE_ENUM_VALIDATE</b></dt>
///              <dt>0x0008</dt> </dl> </td> <td width="60%"> Performs extra validation on the resource section and its reference
///              in the PE header while doing the enumeration to ensure that resources are properly formatted. The validation sets
///              a maximum limit of 260 characters for each name that is enumerated. </td> </tr> </table>
///    LangId = Type: <b>LANGID</b> The localization language used to filter the search in the MUI module. This parameter is used
///             only when the <b>RESOURCE_ENUM_MUI</b> flag is set in <i>dwFlags</i>. If zero is specified, then all .mui files
///             that match current language preferences are included in the search, following the usual Resource Loader strategy
///             (see User Interface Language Management). If a nonzero <i>LangId</i> is specified, then the only .mui file
///             searched will be the one matching the specified <i>LangId</i>.
///Returns:
///    Type: <b>BOOL</b> The function <b>TRUE</b> if successful, or <b>FALSE</b> if the function does not find a
///    resource of the type specified, or if the function fails for another reason. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceNamesExA(ptrdiff_t hModule, const(PSTR) lpType, ENUMRESNAMEPROCA lpEnumFunc, ptrdiff_t lParam, 
                          uint dwFlags, ushort LangId);

///Enumerates resources of a specified type that are associated with a specified binary module. The search can include
///both an LN file and its associated .mui files, or it can be limited in several ways.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to search. Typically this is an LN file, and if flag
///              <b>RESOURCE_ENUM_MUI</b> is set, then appropriate .mui files are included in the search. Alternately, this can be
///              a handle to an .mui file or other LN file. If this parameter is <b>NULL</b>, it is equivalent to passing in a
///              handle to the module used to create the current process.
///    lpType = Type: <b>LPCTSTR</b> The type of the resource for which the name is being enumerated. Alternately, rather than a
///             pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined
///             resource type. For a list of predefined resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpEnumFunc = Type: <b>ENUMRESNAMEPROC</b> A pointer to the callback function to be called for each enumerated resource name.
///                 For more information, see EnumResNameProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function. This parameter can be used in
///             error checking.
///    dwFlags = Type: <b>DWORD</b> The type of file to search. The following values are supported. Note that if <i>dwFlags</i> is
///              zero, then the <b>RESOURCE_ENUM_LN</b> and <b>RESOURCE_ENUM_MUI</b> flags are assumed to be specified. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCE_ENUM_MUI"></a><a
///              id="resource_enum_mui"></a><dl> <dt><b>RESOURCE_ENUM_MUI</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%">
///              Search for resources in .mui files associated with the LN file specified by <i>hModule</i> and with the current
///              language preferences, following the usual Resource Loader strategy (see User Interface Language Management).
///              Alternately, if <i>LangId</i> is nonzero, then only the specified .mui file will be searched. Typically this flag
///              should be used only if <i>hModule</i> references an LN file. If <i>hModule</i> references an .mui file, then that
///              file is actually covered by the <b>RESOURCE_ENUM_LN</b> flag, despite the name of the flag. </td> </tr> <tr> <td
///              width="40%"><a id="RESOURCE_ENUM_LN"></a><a id="resource_enum_ln"></a><dl> <dt><b>RESOURCE_ENUM_LN</b></dt>
///              <dt>0x0001</dt> </dl> </td> <td width="60%"> Searches the file specified by <i>hModule</i>, regardless of whether
///              the file is an LN file, another type of LN file, or an .mui file. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_VALIDATE"></a><a id="resource_enum_validate"></a><dl> <dt><b>RESOURCE_ENUM_VALIDATE</b></dt>
///              <dt>0x0008</dt> </dl> </td> <td width="60%"> Performs extra validation on the resource section and its reference
///              in the PE header while doing the enumeration to ensure that resources are properly formatted. The validation sets
///              a maximum limit of 260 characters for each name that is enumerated. </td> </tr> </table>
///    LangId = Type: <b>LANGID</b> The localization language used to filter the search in the MUI module. This parameter is used
///             only when the <b>RESOURCE_ENUM_MUI</b> flag is set in <i>dwFlags</i>. If zero is specified, then all .mui files
///             that match current language preferences are included in the search, following the usual Resource Loader strategy
///             (see User Interface Language Management). If a nonzero <i>LangId</i> is specified, then the only .mui file
///             searched will be the one matching the specified <i>LangId</i>.
///Returns:
///    Type: <b>BOOL</b> The function <b>TRUE</b> if successful, or <b>FALSE</b> if the function does not find a
///    resource of the type specified, or if the function fails for another reason. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceNamesExW(ptrdiff_t hModule, const(PWSTR) lpType, ENUMRESNAMEPROCW lpEnumFunc, ptrdiff_t lParam, 
                          uint dwFlags, ushort LangId);

///Enumerates resource types associated with a specified binary module. The search can include both a language-neutral
///Portable Executable file (LN file) and its associated .mui files. Alternately, it can be limited to a single binary
///module of any type, or to the .mui files associated with a single LN file. The search can also be limited to a single
///associated .mui file that contains resources for a specific language. For each resource type found,
///<b>EnumResourceTypesEx</b> calls an application-defined callback function <i>lpEnumFunc</i>, passing the resource
///type it finds, as well as the various other parameters that were passed to <b>EnumResourceTypesEx</b>.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to be searched. Typically this is an LN file, and if flag
///              <b>RESOURCE_ENUM_MUI</b> is set, then appropriate .mui files can be included in the search. Alternately, this can
///              be a handle to an .mui file or other LN file. If this parameter is <b>NULL</b>, it is equivalent to passing in a
///              handle to the module used to create the current process.
///    lpEnumFunc = Type: <b>ENUMRESTYPEPROC</b> A pointer to the callback function to be called for each enumerated resource type.
///                 For more information, see EnumResTypeProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function.
///    dwFlags = Type: <b>DWORD</b> The type of file to be searched. The following values are supported. Note that if
///              <i>dwFlags</i> is zero, then the <b>RESOURCE_ENUM_LN</b> and <b>RESOURCE_ENUM_MUI</b> flags are assumed to be
///              specified. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_MUI"></a><a id="resource_enum_mui"></a><dl> <dt><b>RESOURCE_ENUM_MUI</b></dt> <dt>0x0002</dt>
///              </dl> </td> <td width="60%"> Search for resource types in one of the .mui files associated with the file
///              specified by <i>hModule</i> and with the current language preferences, following the usual Resource Loader
///              strategy (see User Interface Language Management). Alternately, if <i>LangId</i> is nonzero, then only the .mui
///              file of the language as specified by <i>LangId</i> will be searched. Typically this flag should be used only if
///              <i>hModule</i> references an LN file. If <i>hModule</i> references an .mui file, then that file is actually
///              covered by the <b>RESOURCE_ENUM_LN</b> flag, despite the name of the flag. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_LN"></a><a id="resource_enum_ln"></a><dl> <dt><b>RESOURCE_ENUM_LN</b></dt> <dt>0x0001</dt>
///              </dl> </td> <td width="60%"> Searches only the file specified by <i>hModule</i>, regardless of whether the file
///              is an LN file or an .mui file. </td> </tr> <tr> <td width="40%"><a id="RESOURCE_ENUM_VALIDATE"></a><a
///              id="resource_enum_validate"></a><dl> <dt><b>RESOURCE_ENUM_VALIDATE</b></dt> <dt>0x0008</dt> </dl> </td> <td
///              width="60%"> Performs extra validation on the resource section and its reference in the PE header while doing the
///              enumeration to ensure that resources are properly formatted. The validation sets a maximum limit of 260
///              characters for each type that is enumerated. </td> </tr> </table>
///    LangId = Type: <b>LANGID</b> The language used to filter the search in the MUI module. This parameter is used only when
///             the <b>RESOURCE_ENUM_MUI</b> flag is set in <i>dwFlags</i>. If zero is specified, then all .mui files that match
///             current language preferences are included in the search, following the usual Resource Loader strategy (see User
///             Interface Language Management). If a nonzero <i>LangId</i> is specified, then the only .mui file searched will be
///             the one matching the specified <i>LangId</i>.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful or <b>FALSE</b> if the function does not find a resource of
///    the type specified, or if the function fails for another reason. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceTypesExA(ptrdiff_t hModule, ENUMRESTYPEPROCA lpEnumFunc, ptrdiff_t lParam, uint dwFlags, 
                          ushort LangId);

///Enumerates resource types associated with a specified binary module. The search can include both a language-neutral
///Portable Executable file (LN file) and its associated .mui files. Alternately, it can be limited to a single binary
///module of any type, or to the .mui files associated with a single LN file. The search can also be limited to a single
///associated .mui file that contains resources for a specific language. For each resource type found,
///<b>EnumResourceTypesEx</b> calls an application-defined callback function <i>lpEnumFunc</i>, passing the resource
///type it finds, as well as the various other parameters that were passed to <b>EnumResourceTypesEx</b>.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to be searched. Typically this is an LN file, and if flag
///              <b>RESOURCE_ENUM_MUI</b> is set, then appropriate .mui files can be included in the search. Alternately, this can
///              be a handle to an .mui file or other LN file. If this parameter is <b>NULL</b>, it is equivalent to passing in a
///              handle to the module used to create the current process.
///    lpEnumFunc = Type: <b>ENUMRESTYPEPROC</b> A pointer to the callback function to be called for each enumerated resource type.
///                 For more information, see EnumResTypeProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function.
///    dwFlags = Type: <b>DWORD</b> The type of file to be searched. The following values are supported. Note that if
///              <i>dwFlags</i> is zero, then the <b>RESOURCE_ENUM_LN</b> and <b>RESOURCE_ENUM_MUI</b> flags are assumed to be
///              specified. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_MUI"></a><a id="resource_enum_mui"></a><dl> <dt><b>RESOURCE_ENUM_MUI</b></dt> <dt>0x0002</dt>
///              </dl> </td> <td width="60%"> Search for resource types in one of the .mui files associated with the file
///              specified by <i>hModule</i> and with the current language preferences, following the usual Resource Loader
///              strategy (see User Interface Language Management). Alternately, if <i>LangId</i> is nonzero, then only the .mui
///              file of the language as specified by <i>LangId</i> will be searched. Typically this flag should be used only if
///              <i>hModule</i> references an LN file. If <i>hModule</i> references an .mui file, then that file is actually
///              covered by the <b>RESOURCE_ENUM_LN</b> flag, despite the name of the flag. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCE_ENUM_LN"></a><a id="resource_enum_ln"></a><dl> <dt><b>RESOURCE_ENUM_LN</b></dt> <dt>0x0001</dt>
///              </dl> </td> <td width="60%"> Searches only the file specified by <i>hModule</i>, regardless of whether the file
///              is an LN file or an .mui file. </td> </tr> <tr> <td width="40%"><a id="RESOURCE_ENUM_VALIDATE"></a><a
///              id="resource_enum_validate"></a><dl> <dt><b>RESOURCE_ENUM_VALIDATE</b></dt> <dt>0x0008</dt> </dl> </td> <td
///              width="60%"> Performs extra validation on the resource section and its reference in the PE header while doing the
///              enumeration to ensure that resources are properly formatted. The validation sets a maximum limit of 260
///              characters for each type that is enumerated. </td> </tr> </table>
///    LangId = Type: <b>LANGID</b> The language used to filter the search in the MUI module. This parameter is used only when
///             the <b>RESOURCE_ENUM_MUI</b> flag is set in <i>dwFlags</i>. If zero is specified, then all .mui files that match
///             current language preferences are included in the search, following the usual Resource Loader strategy (see User
///             Interface Language Management). If a nonzero <i>LangId</i> is specified, then the only .mui file searched will be
///             the one matching the specified <i>LangId</i>.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful or <b>FALSE</b> if the function does not find a resource of
///    the type specified, or if the function fails for another reason. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceTypesExW(ptrdiff_t hModule, ENUMRESTYPEPROCW lpEnumFunc, ptrdiff_t lParam, uint dwFlags, 
                          ushort LangId);

///Writes formatted data to the specified buffer using a pointer to a list of arguments. The items pointed to by the
///argument list are converted and copied to an output buffer according to the corresponding format specification in the
///format-control string. The function appends a terminating null character to the characters it writes, but the return
///value does not include the terminating null character in its character count. <div class="alert"><b>Warning</b> Do
///not use. Consider using one of the following functions instead: StringCbVPrintf, StringCbVPrintfEx, StringCchVPrintf,
///or StringCchVPrintfEx. See Security Considerations.</div><div> </div>
///Params:
///    arg1 = Type: <b>LPTSTR</b> The buffer that is to receive the formatted output. The maximum size of the buffer is 1,024
///           bytes.
///    arg2 = Type: <b>LPCTSTR</b> The format-control specifications. In addition to ordinary ASCII characters, a format
///           specification for each argument appears in this string. For more information about the format specification, see
///           the wsprintf function.
///    arglist = Type: <b>va_list</b> Each element of this list specifies an argument for the format-control string. The number,
///              type, and interpretation of the arguments depend on the corresponding format-control specifications in the
///              <i>lpFmt</i> parameter.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of characters stored in the buffer, not
///    counting the terminating null character. If the function fails, the return value is less than the length of the
///    expected output. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int wvsprintfA(PSTR param0, const(PSTR) param1, byte* arglist);

///Writes formatted data to the specified buffer using a pointer to a list of arguments. The items pointed to by the
///argument list are converted and copied to an output buffer according to the corresponding format specification in the
///format-control string. The function appends a terminating null character to the characters it writes, but the return
///value does not include the terminating null character in its character count. <div class="alert"><b>Warning</b> Do
///not use. Consider using one of the following functions instead: StringCbVPrintf, StringCbVPrintfEx, StringCchVPrintf,
///or StringCchVPrintfEx. See Security Considerations.</div><div> </div>
///Params:
///    arg1 = Type: <b>LPTSTR</b> The buffer that is to receive the formatted output. The maximum size of the buffer is 1,024
///           bytes.
///    arg2 = Type: <b>LPCTSTR</b> The format-control specifications. In addition to ordinary ASCII characters, a format
///           specification for each argument appears in this string. For more information about the format specification, see
///           the wsprintf function.
///    arglist = Type: <b>va_list</b> Each element of this list specifies an argument for the format-control string. The number,
///              type, and interpretation of the arguments depend on the corresponding format-control specifications in the
///              <i>lpFmt</i> parameter.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of characters stored in the buffer, not
///    counting the terminating null character. If the function fails, the return value is less than the length of the
///    expected output. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int wvsprintfW(PWSTR param0, const(PWSTR) param1, byte* arglist);

///Writes formatted data to the specified buffer. Any arguments are converted and copied to the output buffer according
///to the corresponding format specification in the format string. The function appends a terminating null character to
///the characters it writes, but the return value does not include the terminating null character in its character
///count. <div class="alert"><b>Note</b> Do not use. Consider using one of the following functions instead:
///StringCbPrintf, StringCbPrintfEx, StringCchPrintf, or StringCchPrintfEx. See Security Considerations.</div><div>
///</div>
///Params:
///    arg1 = Type: <b>LPTSTR</b> The buffer that is to receive the formatted output. The maximum size of the buffer is 1,024
///           bytes.
///    arg2 = Type: <b>LPCTSTR</b> The format-control specifications. In addition to ordinary ASCII characters, a format
///           specification for each argument appears in this string. For more information about the format specification, see
///           the Remarks section.
///    arg3 = One or more optional arguments. The number and type of argument parameters depend on the corresponding
///           format-control specifications in the <i>lpFmt</i> parameter.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of characters stored in the output
///    buffer, not counting the terminating null character. If the function fails, the return value is less than the
///    length of the expected output. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int wsprintfA(PSTR param0, const(PSTR) param1);

///Writes formatted data to the specified buffer. Any arguments are converted and copied to the output buffer according
///to the corresponding format specification in the format string. The function appends a terminating null character to
///the characters it writes, but the return value does not include the terminating null character in its character
///count. <div class="alert"><b>Note</b> Do not use. Consider using one of the following functions instead:
///StringCbPrintf, StringCbPrintfEx, StringCchPrintf, or StringCchPrintfEx. See Security Considerations.</div><div>
///</div>
///Params:
///    arg1 = Type: <b>LPTSTR</b> The buffer that is to receive the formatted output. The maximum size of the buffer is 1,024
///           bytes.
///    arg2 = Type: <b>LPCTSTR</b> The format-control specifications. In addition to ordinary ASCII characters, a format
///           specification for each argument appears in this string. For more information about the format specification, see
///           the Remarks section.
///    arg3 = One or more optional arguments. The number and type of argument parameters depend on the corresponding
///           format-control specifications in the <i>lpFmt</i> parameter.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of characters stored in the output
///    buffer, not counting the terminating null character. If the function fails, the return value is less than the
///    length of the expected output. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int wsprintfW(PWSTR param0, const(PWSTR) param1);

@DllImport("USER32")
BOOL SetMessageQueue(int cMessagesMax);

@DllImport("USER32")
int BroadcastSystemMessageA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

///Determines whether a handle is a menu handle.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to be tested.
///Returns:
///    Type: <b>BOOL</b> If the handle is a menu handle, the return value is nonzero. If the handle is not a menu
///    handle, the return value is zero.
///    
@DllImport("USER32")
BOOL IsMenu(HMENU hMenu);

@DllImport("USER32")
BOOL UpdateLayeredWindowIndirect(HWND hWnd, const(UPDATELAYEREDWINDOWINFO)* pULWInfo);

@DllImport("USER32")
LRESULT DefDlgProcA(HWND hDlg, uint Msg, WPARAM wParam, LPARAM lParam);

///Translates a string into the OEM-defined character set. <div class="alert"><b>Warning</b> Do not use. See Security
///Considerations.</div><div> </div>
///Params:
///    pSrc = Type: <b>LPCTSTR</b> The null-terminated string to be translated.
///    pDst = Type: <b>LPSTR</b> The destination buffer, which receives the translated string. If the <b>CharToOem</b> function
///           is being used as an ANSI function, the string can be translated in place by setting the <i>lpszDst</i> parameter
///           to the same address as the <i>lpszSrc</i> parameter. This cannot be done if <b>CharToOem</b> is being used as a
///           wide-character function.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL CharToOemA(const(PSTR) pSrc, PSTR pDst);

///Translates a string into the OEM-defined character set. <div class="alert"><b>Warning</b> Do not use. See Security
///Considerations.</div><div> </div>
///Params:
///    pSrc = Type: <b>LPCTSTR</b> The null-terminated string to be translated.
///    pDst = Type: <b>LPSTR</b> The destination buffer, which receives the translated string. If the <b>CharToOem</b> function
///           is being used as an ANSI function, the string can be translated in place by setting the <i>lpszDst</i> parameter
///           to the same address as the <i>lpszSrc</i> parameter. This cannot be done if <b>CharToOem</b> is being used as a
///           wide-character function.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL CharToOemW(const(PWSTR) pSrc, PSTR pDst);

///Translates a string from the OEM-defined character set into either an ANSI or a wide-character string. <div
///class="alert"><b>Warning</b> Do not use. See Security Considerations.</div><div> </div>
///Params:
///    pSrc = Type: <b>LPCSTR</b> A null-terminated string of characters from the OEM-defined character set.
///    pDst = Type: <b>LPTSTR</b> The destination buffer, which receives the translated string. If the <b>OemToChar</b>
///           function is being used as an ANSI function, the string can be translated in place by setting the <i>lpszDst</i>
///           parameter to the same address as the <i>lpszSrc</i> parameter. This cannot be done if <b>OemToChar</b> is being
///           used as a wide-character function.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL OemToCharA(const(PSTR) pSrc, PSTR pDst);

///Translates a string from the OEM-defined character set into either an ANSI or a wide-character string. <div
///class="alert"><b>Warning</b> Do not use. See Security Considerations.</div><div> </div>
///Params:
///    pSrc = Type: <b>LPCSTR</b> A null-terminated string of characters from the OEM-defined character set.
///    pDst = Type: <b>LPTSTR</b> The destination buffer, which receives the translated string. If the <b>OemToChar</b>
///           function is being used as an ANSI function, the string can be translated in place by setting the <i>lpszDst</i>
///           parameter to the same address as the <i>lpszSrc</i> parameter. This cannot be done if <b>OemToChar</b> is being
///           used as a wide-character function.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL OemToCharW(const(PSTR) pSrc, PWSTR pDst);

///Translates a specified number of characters in a string into the OEM-defined character set.
///Params:
///    lpszSrc = Type: <b>LPCTSTR</b> The null-terminated string to be translated.
///    lpszDst = Type: <b>LPSTR</b> The buffer for the translated string. If the <b>CharToOemBuff</b> function is being used as an
///              ANSI function, the string can be translated in place by setting the <i>lpszDst</i> parameter to the same address
///              as the <i>lpszSrc</i> parameter. This cannot be done if <b>CharToOemBuff</b> is being used as a wide-character
///              function.
///    cchDstLength = Type: <b>DWORD</b> The number of characters to translate in the string identified by the <i>lpszSrc</i>
///                   parameter.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL CharToOemBuffA(const(PSTR) lpszSrc, PSTR lpszDst, uint cchDstLength);

///Translates a specified number of characters in a string into the OEM-defined character set.
///Params:
///    lpszSrc = Type: <b>LPCTSTR</b> The null-terminated string to be translated.
///    lpszDst = Type: <b>LPSTR</b> The buffer for the translated string. If the <b>CharToOemBuff</b> function is being used as an
///              ANSI function, the string can be translated in place by setting the <i>lpszDst</i> parameter to the same address
///              as the <i>lpszSrc</i> parameter. This cannot be done if <b>CharToOemBuff</b> is being used as a wide-character
///              function.
///    cchDstLength = Type: <b>DWORD</b> The number of characters to translate in the string identified by the <i>lpszSrc</i>
///                   parameter.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL CharToOemBuffW(const(PWSTR) lpszSrc, PSTR lpszDst, uint cchDstLength);

///Translates a specified number of characters in a string from the OEM-defined character set into either an ANSI or a
///wide-character string.
///Params:
///    lpszSrc = Type: <b>LPCSTR</b> One or more characters from the OEM-defined character set.
///    lpszDst = Type: <b>LPTSTR</b> The destination buffer, which receives the translated string. If the <b>OemToCharBuff</b>
///              function is being used as an ANSI function, the string can be translated in place by setting the <i>lpszDst</i>
///              parameter to the same address as the <i>lpszSrc</i> parameter. This cannot be done if the <b>OemToCharBuff</b>
///              function is being used as a wide-character function.
///    cchDstLength = Type: <b>DWORD</b> The number of characters to be translated in the buffer identified by the <i>lpszSrc</i>
///                   parameter.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL OemToCharBuffA(const(PSTR) lpszSrc, PSTR lpszDst, uint cchDstLength);

///Translates a specified number of characters in a string from the OEM-defined character set into either an ANSI or a
///wide-character string.
///Params:
///    lpszSrc = Type: <b>LPCSTR</b> One or more characters from the OEM-defined character set.
///    lpszDst = Type: <b>LPTSTR</b> The destination buffer, which receives the translated string. If the <b>OemToCharBuff</b>
///              function is being used as an ANSI function, the string can be translated in place by setting the <i>lpszDst</i>
///              parameter to the same address as the <i>lpszSrc</i> parameter. This cannot be done if the <b>OemToCharBuff</b>
///              function is being used as a wide-character function.
///    cchDstLength = Type: <b>DWORD</b> The number of characters to be translated in the buffer identified by the <i>lpszSrc</i>
///                   parameter.
///Returns:
///    Type: <b>BOOL</b> The return value is always nonzero except when you pass the same address to <i>lpszSrc</i> and
///    <i>lpszDst</i> in the wide-character version of the function. In this case the function returns zero and
///    GetLastError returns <b>ERROR_INVALID_ADDRESS</b>.
///    
@DllImport("USER32")
BOOL OemToCharBuffW(const(PSTR) lpszSrc, PWSTR lpszDst, uint cchDstLength);

///Converts a character string or a single character to uppercase. If the operand is a character string, the function
///converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A null-terminated string, or a single character. If the high-order word of this parameter is
///           zero, the low-order word must contain a single character to be converted.
///Returns:
///    Type: <b>LPTSTR</b> If the operand is a character string, the function returns a pointer to the converted string.
///    Because the string is converted in place, the return value is equal to <i>lpsz</i>. If the operand is a single
///    character, the return value is a 32-bit value whose high-order word is zero, and low-order word contains the
///    converted character. There is no indication of success or failure. Failure is rare. There is no extended error
///    information for this function; do not call GetLastError.
///    
@DllImport("USER32")
PSTR CharUpperA(PSTR lpsz);

///Converts a character string or a single character to uppercase. If the operand is a character string, the function
///converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A null-terminated string, or a single character. If the high-order word of this parameter is
///           zero, the low-order word must contain a single character to be converted.
///Returns:
///    Type: <b>LPTSTR</b> If the operand is a character string, the function returns a pointer to the converted string.
///    Because the string is converted in place, the return value is equal to <i>lpsz</i>. If the operand is a single
///    character, the return value is a 32-bit value whose high-order word is zero, and low-order word contains the
///    converted character. There is no indication of success or failure. Failure is rare. There is no extended error
///    information for this function; do not call GetLastError.
///    
@DllImport("USER32")
PWSTR CharUpperW(PWSTR lpsz);

///Converts lowercase characters in a buffer to uppercase characters. The function converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A buffer containing one or more characters to be processed.
///    cchLength = Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <i>lpsz</i>. The function examines each
///                character, and converts lowercase characters to uppercase characters. The function examines the number of
///                characters indicated by <i>cchLength</i>, even if one or more characters are null characters.
///Returns:
///    Type: <b>DWORD</b> The return value is the number of characters processed. For example, if
///    <b>CharUpperBuff</b>("Zenith of API Sets", 10) succeeds, the return value is 10.
///    
@DllImport("USER32")
uint CharUpperBuffA(PSTR lpsz, uint cchLength);

///Converts lowercase characters in a buffer to uppercase characters. The function converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A buffer containing one or more characters to be processed.
///    cchLength = Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <i>lpsz</i>. The function examines each
///                character, and converts lowercase characters to uppercase characters. The function examines the number of
///                characters indicated by <i>cchLength</i>, even if one or more characters are null characters.
///Returns:
///    Type: <b>DWORD</b> The return value is the number of characters processed. For example, if
///    <b>CharUpperBuff</b>("Zenith of API Sets", 10) succeeds, the return value is 10.
///    
@DllImport("USER32")
uint CharUpperBuffW(PWSTR lpsz, uint cchLength);

///Converts a character string or a single character to lowercase. If the operand is a character string, the function
///converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A null-terminated string, or specifies a single character. If the high-order word of this
///           parameter is zero, the low-order word must contain a single character to be converted.
///Returns:
///    Type: <b>LPTSTR</b> If the operand is a character string, the function returns a pointer to the converted string.
///    Because the string is converted in place, the return value is equal to <i>lpsz</i>. If the operand is a single
///    character, the return value is a 32-bit value whose high-order word is zero, and low-order word contains the
///    converted character. There is no indication of success or failure. Failure is rare. There is no extended error
///    information for this function; do not call GetLastError.
///    
@DllImport("USER32")
PSTR CharLowerA(PSTR lpsz);

///Converts a character string or a single character to lowercase. If the operand is a character string, the function
///converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A null-terminated string, or specifies a single character. If the high-order word of this
///           parameter is zero, the low-order word must contain a single character to be converted.
///Returns:
///    Type: <b>LPTSTR</b> If the operand is a character string, the function returns a pointer to the converted string.
///    Because the string is converted in place, the return value is equal to <i>lpsz</i>. If the operand is a single
///    character, the return value is a 32-bit value whose high-order word is zero, and low-order word contains the
///    converted character. There is no indication of success or failure. Failure is rare. There is no extended error
///    information for this function; do not call GetLastError.
///    
@DllImport("USER32")
PWSTR CharLowerW(PWSTR lpsz);

///Converts uppercase characters in a buffer to lowercase characters. The function converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A buffer containing one or more characters to be processed.
///    cchLength = Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <i>lpsz</i>. The function examines each
///                character, and converts uppercase characters to lowercase characters. The function examines the number of
///                characters indicated by <i>cchLength</i>, even if one or more characters are null characters.
///Returns:
///    Type: <b>DWORD</b> The return value is the number of characters processed. For example, if
///    <b>CharLowerBuff</b>("Acme of Operating Systems", 10) succeeds, the return value is 10.
///    
@DllImport("USER32")
uint CharLowerBuffA(PSTR lpsz, uint cchLength);

///Converts uppercase characters in a buffer to lowercase characters. The function converts the characters in place.
///Params:
///    lpsz = Type: <b>LPTSTR</b> A buffer containing one or more characters to be processed.
///    cchLength = Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <i>lpsz</i>. The function examines each
///                character, and converts uppercase characters to lowercase characters. The function examines the number of
///                characters indicated by <i>cchLength</i>, even if one or more characters are null characters.
///Returns:
///    Type: <b>DWORD</b> The return value is the number of characters processed. For example, if
///    <b>CharLowerBuff</b>("Acme of Operating Systems", 10) succeeds, the return value is 10.
///    
@DllImport("USER32")
uint CharLowerBuffW(PWSTR lpsz, uint cchLength);

///Retrieves a pointer to the next character in a string. This function can handle strings consisting of either single-
///or multi-byte characters.
///Params:
///    lpsz = Type: <b>LPCTSTR</b> A character in a null-terminated string.
///Returns:
///    Type: <b>LPTSTR</b> The return value is a pointer to the next character in the string, or to the terminating null
///    character if at the end of the string. If <i>lpsz</i> points to the terminating null character, the return value
///    is equal to <i>lpsz</i>.
///    
@DllImport("USER32")
PSTR CharNextA(const(PSTR) lpsz);

///Retrieves a pointer to the next character in a string. This function can handle strings consisting of either single-
///or multi-byte characters.
///Params:
///    lpsz = Type: <b>LPCTSTR</b> A character in a null-terminated string.
///Returns:
///    Type: <b>LPTSTR</b> The return value is a pointer to the next character in the string, or to the terminating null
///    character if at the end of the string. If <i>lpsz</i> points to the terminating null character, the return value
///    is equal to <i>lpsz</i>.
///    
@DllImport("USER32")
PWSTR CharNextW(const(PWSTR) lpsz);

///Retrieves a pointer to the preceding character in a string. This function can handle strings consisting of either
///single- or multi-byte characters.
///Params:
///    lpszStart = Type: <b>LPCTSTR</b> The beginning of the string.
///    lpszCurrent = Type: <b>LPCTSTR</b> A character in a null-terminated string.
///Returns:
///    Type: <b>LPTSTR</b> The return value is a pointer to the preceding character in the string, or to the first
///    character in the string if the <i>lpszCurrent</i> parameter equals the <i>lpszStart</i> parameter.
///    
@DllImport("USER32")
PSTR CharPrevA(const(PSTR) lpszStart, const(PSTR) lpszCurrent);

///Retrieves a pointer to the preceding character in a string. This function can handle strings consisting of either
///single- or multi-byte characters.
///Params:
///    lpszStart = Type: <b>LPCTSTR</b> The beginning of the string.
///    lpszCurrent = Type: <b>LPCTSTR</b> A character in a null-terminated string.
///Returns:
///    Type: <b>LPTSTR</b> The return value is a pointer to the preceding character in the string, or to the first
///    character in the string if the <i>lpszCurrent</i> parameter equals the <i>lpszStart</i> parameter.
///    
@DllImport("USER32")
PWSTR CharPrevW(const(PWSTR) lpszStart, const(PWSTR) lpszCurrent);

///Retrieves the pointer to the next character in a string. This function can handle strings consisting of either
///single- or multi-byte characters.
///Params:
///    CodePage = Type: <b>WORD</b> The identifier of the code page to use to check lead-byte ranges. Can be one of the code-page
///               values provided in Code Page Identifiers, or one of the following predefined values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CP_ACP"></a><a id="cp_acp"></a><dl> <dt><b>CP_ACP</b></dt>
///               <dt>0</dt> </dl> </td> <td width="60%"> Use system default ANSI code page. </td> </tr> <tr> <td width="40%"><a
///               id="CP_MACCP"></a><a id="cp_maccp"></a><dl> <dt><b>CP_MACCP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Use
///               the system default Macintosh code page. </td> </tr> <tr> <td width="40%"><a id="CP_OEMCP"></a><a
///               id="cp_oemcp"></a><dl> <dt><b>CP_OEMCP</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Use system default OEM
///               code page. </td> </tr> </table>
///    lpCurrentChar = Type: <b>LPCSTR</b> A character in a null-terminated string.
///    dwFlags = Type: <b>DWORD</b> This parameter is reserved and must be 0.
///Returns:
///    Type: <b>LPSTR</b> The return value is a pointer to the next character in the string, or to the terminating null
///    character if at the end of the string. If <i>lpCurrentChar</i> points to the terminating null character, the
///    return value is equal to <i>lpCurrentChar</i>.
///    
@DllImport("USER32")
PSTR CharNextExA(ushort CodePage, const(PSTR) lpCurrentChar, uint dwFlags);

///Retrieves the pointer to the preceding character in a string. This function can handle strings consisting of either
///single- or multi-byte characters.
///Params:
///    CodePage = Type: <b>WORD</b> The identifier of the code page to use to check lead-byte ranges. Can be one of the code-page
///               values provided in Code Page Identifiers, or one of the following predefined values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CP_ACP"></a><a id="cp_acp"></a><dl> <dt><b>CP_ACP</b></dt>
///               <dt>0</dt> </dl> </td> <td width="60%"> Use system default ANSI code page. </td> </tr> <tr> <td width="40%"><a
///               id="CP_MACCP"></a><a id="cp_maccp"></a><dl> <dt><b>CP_MACCP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Use
///               the system default Macintosh code page. </td> </tr> <tr> <td width="40%"><a id="CP_OEMCP"></a><a
///               id="cp_oemcp"></a><dl> <dt><b>CP_OEMCP</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Use system default OEM
///               code page. </td> </tr> </table>
///    lpStart = Type: <b>LPCSTR</b> The beginning of the string.
///    lpCurrentChar = Type: <b>LPCSTR</b> A character in a null-terminated string.
///    dwFlags = Type: <b>DWORD</b> This parameter is reserved and must be zero.
///Returns:
///    Type: <b>LPSTR</b> The return value is a pointer to the preceding character in the string, or to the first
///    character in the string if the <i>lpCurrentChar</i> parameter equals the <i>lpStart</i> parameter.
///    
@DllImport("USER32")
PSTR CharPrevExA(ushort CodePage, const(PSTR) lpStart, const(PSTR) lpCurrentChar, uint dwFlags);

///Determines whether a character is an alphabetical character. This determination is based on the semantics of the
///language selected by the user during setup or through Control Panel.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be tested.
///Returns:
///    Type: <b>BOOL</b> If the character is alphabetical, the return value is nonzero. If the character is not
///    alphabetical, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsCharAlphaA(byte ch);

///Determines whether a character is an alphabetical character. This determination is based on the semantics of the
///language selected by the user during setup or through Control Panel.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be tested.
///Returns:
///    Type: <b>BOOL</b> If the character is alphabetical, the return value is nonzero. If the character is not
///    alphabetical, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsCharAlphaW(ushort ch);

///Determines whether a character is either an alphabetical or a numeric character. This determination is based on the
///semantics of the language selected by the user during setup or through Control Panel.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be tested.
///Returns:
///    Type: <b>BOOL</b> If the character is alphanumeric, the return value is nonzero. If the character is not
///    alphanumeric, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsCharAlphaNumericA(byte ch);

///Determines whether a character is either an alphabetical or a numeric character. This determination is based on the
///semantics of the language selected by the user during setup or through Control Panel.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be tested.
///Returns:
///    Type: <b>BOOL</b> If the character is alphanumeric, the return value is nonzero. If the character is not
///    alphanumeric, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsCharAlphaNumericW(ushort ch);

///Determines whether a character is uppercase. This determination is based on the semantics of the language selected by
///the user during setup or through Control Panel.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be tested.
///Returns:
///    Type: <b>BOOL</b> If the character is uppercase, the return value is nonzero. If the character is not uppercase,
///    the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsCharUpperA(byte ch);

///Determines whether a character is uppercase. This determination is based on the semantics of the language selected by
///the user during setup or through Control Panel.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be tested.
///Returns:
///    Type: <b>BOOL</b> If the character is uppercase, the return value is nonzero. If the character is not uppercase,
///    the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsCharUpperW(ushort ch);

///Determines whether a character is lowercase. This determination is based on the semantics of the language selected by
///the user during setup or through Control Panel.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be tested.
///Returns:
///    Type: <b>BOOL</b> If the character is lowercase, the return value is nonzero. If the character is not lowercase,
///    the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsCharLowerA(byte ch);

///Loads the specified accelerator table.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module whose executable file contains the accelerator table to be loaded.
///    lpTableName = Type: <b>LPCTSTR</b> The name of the accelerator table to be loaded. Alternatively, this parameter can specify
///                  the resource identifier of an accelerator-table resource in the low-order word and zero in the high-order word.
///                  To create this value, use the MAKEINTRESOURCE macro.
///Returns:
///    Type: <b>HACCEL</b> If the function succeeds, the return value is a handle to the loaded accelerator table. If
///    the function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HACCEL LoadAcceleratorsA(HINSTANCE hInstance, const(PSTR) lpTableName);

///Loads the specified accelerator table.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module whose executable file contains the accelerator table to be loaded.
///    lpTableName = Type: <b>LPCTSTR</b> The name of the accelerator table to be loaded. Alternatively, this parameter can specify
///                  the resource identifier of an accelerator-table resource in the low-order word and zero in the high-order word.
///                  To create this value, use the MAKEINTRESOURCE macro.
///Returns:
///    Type: <b>HACCEL</b> If the function succeeds, the return value is a handle to the loaded accelerator table. If
///    the function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HACCEL LoadAcceleratorsW(HINSTANCE hInstance, const(PWSTR) lpTableName);

///Creates an accelerator table.
///Params:
///    paccel = Type: <b>LPACCEL</b> An array of ACCEL structures that describes the accelerator table.
///    cAccel = Type: <b>int</b> The number of ACCEL structures in the array. This must be within the range 1 to 32767 or the
///             function will fail.
///Returns:
///    Type: <b>HACCEL</b> If the function succeeds, the return value is the handle to the created accelerator table;
///    otherwise, it is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HACCEL CreateAcceleratorTableA(ACCEL* paccel, int cAccel);

///Creates an accelerator table.
///Params:
///    paccel = Type: <b>LPACCEL</b> An array of ACCEL structures that describes the accelerator table.
///    cAccel = Type: <b>int</b> The number of ACCEL structures in the array. This must be within the range 1 to 32767 or the
///             function will fail.
///Returns:
///    Type: <b>HACCEL</b> If the function succeeds, the return value is the handle to the created accelerator table;
///    otherwise, it is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HACCEL CreateAcceleratorTableW(ACCEL* paccel, int cAccel);

///Destroys an accelerator table.
///Params:
///    hAccel = Type: <b>HACCEL</b> A handle to the accelerator table to be destroyed. This handle must have been created by a
///             call to the CreateAcceleratorTable or LoadAccelerators function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. However, if the table has been loaded
///    more than one call to LoadAccelerators, the function will return a nonzero value only when
///    <b>DestroyAcceleratorTable</b> has been called an equal number of times. If the function fails, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL DestroyAcceleratorTable(HACCEL hAccel);

///Copies the specified accelerator table. This function is used to obtain the accelerator-table data that corresponds
///to an accelerator-table handle, or to determine the size of the accelerator-table data.
///Params:
///    hAccelSrc = Type: <b>HACCEL</b> A handle to the accelerator table to copy.
///    lpAccelDst = Type: <b>LPACCEL</b> An array of ACCEL structures that receives the accelerator-table information.
///    cAccelEntries = Type: <b>int</b> The number of ACCEL structures to copy to the buffer pointed to by the <i>lpAccelDst</i>
///                    parameter.
///Returns:
///    Type: <b>int</b> If <i>lpAccelDst</i> is <b>NULL</b>, the return value specifies the number of accelerator-table
///    entries in the original table. Otherwise, it specifies the number of accelerator-table entries that were copied.
///    
@DllImport("USER32")
int CopyAcceleratorTableA(HACCEL hAccelSrc, ACCEL* lpAccelDst, int cAccelEntries);

///Copies the specified accelerator table. This function is used to obtain the accelerator-table data that corresponds
///to an accelerator-table handle, or to determine the size of the accelerator-table data.
///Params:
///    hAccelSrc = Type: <b>HACCEL</b> A handle to the accelerator table to copy.
///    lpAccelDst = Type: <b>LPACCEL</b> An array of ACCEL structures that receives the accelerator-table information.
///    cAccelEntries = Type: <b>int</b> The number of ACCEL structures to copy to the buffer pointed to by the <i>lpAccelDst</i>
///                    parameter.
///Returns:
///    Type: <b>int</b> If <i>lpAccelDst</i> is <b>NULL</b>, the return value specifies the number of accelerator-table
///    entries in the original table. Otherwise, it specifies the number of accelerator-table entries that were copied.
///    
@DllImport("USER32")
int CopyAcceleratorTableW(HACCEL hAccelSrc, ACCEL* lpAccelDst, int cAccelEntries);

///Processes accelerator keys for menu commands. The function translates a WM_KEYDOWN or WM_SYSKEYDOWN message to a
///WM_COMMAND or WM_SYSCOMMAND message (if there is an entry for the key in the specified accelerator table) and then
///sends the <b>WM_COMMAND</b> or <b>WM_SYSCOMMAND</b> message directly to the specified window procedure.
///<b>TranslateAccelerator</b> does not return until the window procedure has processed the message.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose messages are to be translated.
///    hAccTable = Type: <b>HACCEL</b> A handle to the accelerator table. The accelerator table must have been loaded by a call to
///                the LoadAccelerators function or created by a call to the CreateAcceleratorTable function.
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that contains message information retrieved from the calling
///            thread's message queue using the GetMessage or PeekMessage function.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int TranslateAcceleratorA(HWND hWnd, HACCEL hAccTable, MSG* lpMsg);

///Processes accelerator keys for menu commands. The function translates a WM_KEYDOWN or WM_SYSKEYDOWN message to a
///WM_COMMAND or WM_SYSCOMMAND message (if there is an entry for the key in the specified accelerator table) and then
///sends the <b>WM_COMMAND</b> or <b>WM_SYSCOMMAND</b> message directly to the specified window procedure.
///<b>TranslateAccelerator</b> does not return until the window procedure has processed the message.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose messages are to be translated.
///    hAccTable = Type: <b>HACCEL</b> A handle to the accelerator table. The accelerator table must have been loaded by a call to
///                the LoadAccelerators function or created by a call to the CreateAcceleratorTable function.
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that contains message information retrieved from the calling
///            thread's message queue using the GetMessage or PeekMessage function.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int TranslateAcceleratorW(HWND hWnd, HACCEL hAccTable, MSG* lpMsg);

///Loads the specified menu resource from the executable (.exe) file associated with an application instance.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module containing the menu resource to be loaded.
///    lpMenuName = Type: <b>LPCTSTR</b> The name of the menu resource. Alternatively, this parameter can consist of the resource
///                 identifier in the low-order word and zero in the high-order word. To create this value, use the MAKEINTRESOURCE
///                 macro.
///Returns:
///    Type: <b>HMENU</b> If the function succeeds, the return value is a handle to the menu resource. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HMENU LoadMenuA(HINSTANCE hInstance, const(PSTR) lpMenuName);

///Loads the specified menu resource from the executable (.exe) file associated with an application instance.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module containing the menu resource to be loaded.
///    lpMenuName = Type: <b>LPCTSTR</b> The name of the menu resource. Alternatively, this parameter can consist of the resource
///                 identifier in the low-order word and zero in the high-order word. To create this value, use the MAKEINTRESOURCE
///                 macro.
///Returns:
///    Type: <b>HMENU</b> If the function succeeds, the return value is a handle to the menu resource. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HMENU LoadMenuW(HINSTANCE hInstance, const(PWSTR) lpMenuName);

///Loads the specified menu template in memory.
///Params:
///    lpMenuTemplate = Type: <b>const MENUTEMPLATE*</b> A pointer to a menu template or an extended menu template. A menu template
///                     consists of a MENUITEMTEMPLATEHEADER structure followed by one or more contiguous MENUITEMTEMPLATE structures. An
///                     extended menu template consists of a MENUEX_TEMPLATE_HEADER structure followed by one or more contiguous
///                     MENUEX_TEMPLATE_ITEM structures.
///Returns:
///    Type: <b>HMENU</b> If the function succeeds, the return value is a handle to the menu. If the function fails, the
///    return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HMENU LoadMenuIndirectA(const(void)* lpMenuTemplate);

///Loads the specified menu template in memory.
///Params:
///    lpMenuTemplate = Type: <b>const MENUTEMPLATE*</b> A pointer to a menu template or an extended menu template. A menu template
///                     consists of a MENUITEMTEMPLATEHEADER structure followed by one or more contiguous MENUITEMTEMPLATE structures. An
///                     extended menu template consists of a MENUEX_TEMPLATE_HEADER structure followed by one or more contiguous
///                     MENUEX_TEMPLATE_ITEM structures.
///Returns:
///    Type: <b>HMENU</b> If the function succeeds, the return value is a handle to the menu. If the function fails, the
///    return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HMENU LoadMenuIndirectW(const(void)* lpMenuTemplate);

///Retrieves a handle to the menu assigned to the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose menu handle is to be retrieved.
///Returns:
///    Type: <b>HMENU</b> The return value is a handle to the menu. If the specified window has no menu, the return
///    value is <b>NULL</b>. If the window is a child window, the return value is undefined.
///    
@DllImport("USER32")
HMENU GetMenu(HWND hWnd);

///Assigns a new menu to the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to which the menu is to be assigned.
///    hMenu = Type: <b>HMENU</b> A handle to the new menu. If this parameter is <b>NULL</b>, the window's current menu is
///            removed.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetMenu(HWND hWnd, HMENU hMenu);

@DllImport("USER32")
BOOL ChangeMenuA(HMENU hMenu, uint cmd, const(PSTR) lpszNewItem, uint cmdInsert, uint flags);

@DllImport("USER32")
BOOL ChangeMenuW(HMENU hMenu, uint cmd, const(PWSTR) lpszNewItem, uint cmdInsert, uint flags);

///Adds or removes highlighting from an item in a menu bar.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that contains the menu.
///    hMenu = Type: <b>HMENU</b> A handle to the menu bar that contains the item.
///    uIDHiliteItem = Type: <b>UINT</b> The menu item. This parameter is either the identifier of the menu item or the offset of the
///                    menu item in the menu bar, depending on the value of the <i>uHilite</i> parameter.
///    uHilite = Type: <b>UINT</b> Controls the interpretation of the <i>uItemHilite</i> parameter and indicates whether the menu
///              item is highlighted. This parameter must be a combination of either <b>MF_BYCOMMAND</b> or <b>MF_BYPOSITION</b>
///              and <b>MF_HILITE</b> or <b>MF_UNHILITE</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt>
///              <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Indicates that <i>uItemHilite</i> gives the identifier of the
///              menu item. </td> </tr> <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl>
///              <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that <i>uItemHilite</i>
///              gives the zero-based relative position of the menu item. </td> </tr> <tr> <td width="40%"><a
///              id="MF_HILITE"></a><a id="mf_hilite"></a><dl> <dt><b>MF_HILITE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td
///              width="60%"> Highlights the menu item. If this flag is not specified, the highlighting is removed from the item.
///              </td> </tr> <tr> <td width="40%"><a id="MF_UNHILITE"></a><a id="mf_unhilite"></a><dl> <dt><b>MF_UNHILITE</b></dt>
///              <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Removes highlighting from the menu item. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the menu item is set to the specified highlight state, the return value is nonzero. If the
///    menu item is not set to the specified highlight state, the return value is zero.
///    
@DllImport("USER32")
BOOL HiliteMenuItem(HWND hWnd, HMENU hMenu, uint uIDHiliteItem, uint uHilite);

///Copies the text string of the specified menu item into the specified buffer. <div class="alert"><b>Note</b> The
///<b>GetMenuString</b> function has been superseded. Use the GetMenuItemInfo function to retrieve the menu item
///text.</div><div> </div>
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu.
///    uIDItem = Type: <b>UINT</b> The menu item to be changed, as determined by the <i>uFlag</i> parameter.
///    lpString = Type: <b>LPTSTR</b> The buffer that receives the null-terminated string. If the string is as long or longer than
///               <i>lpString</i>, the string is truncated and the terminating null character is added. If <i>lpString</i> is
///               <b>NULL</b>, the function returns the length of the menu string.
///    cchMax = Type: <b>int</b> The maximum length, in characters, of the string to be copied. If the string is longer than the
///             maximum specified in the <i>nMaxCount</i> parameter, the extra characters are truncated. If <i>nMaxCount</i> is
///             0, the function returns the length of the menu string.
///    flags = Type: <b>UINT</b> Indicates how the <i>uIDItem</i> parameter is interpreted. This parameter must be one of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td>
///            <td width="60%"> Indicates that <i>uIDItem</i> gives the identifier of the menu item. If neither the
///            <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified, the <b>MF_BYCOMMAND</b> flag is the default flag.
///            </td> </tr> <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl>
///            <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that <i>uIDItem</i>
///            gives the zero-based relative position of the menu item. </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value specifies the number of characters copied to the
///    buffer, not including the terminating null character. If the function fails, the return value is zero. If the
///    specified item is not of type <b>MIIM_STRING</b> or <b>MFT_STRING</b>, then the return value is zero.
///    
@DllImport("USER32")
int GetMenuStringA(HMENU hMenu, uint uIDItem, PSTR lpString, int cchMax, uint flags);

///Copies the text string of the specified menu item into the specified buffer. <div class="alert"><b>Note</b> The
///<b>GetMenuString</b> function has been superseded. Use the GetMenuItemInfo function to retrieve the menu item
///text.</div><div> </div>
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu.
///    uIDItem = Type: <b>UINT</b> The menu item to be changed, as determined by the <i>uFlag</i> parameter.
///    lpString = Type: <b>LPTSTR</b> The buffer that receives the null-terminated string. If the string is as long or longer than
///               <i>lpString</i>, the string is truncated and the terminating null character is added. If <i>lpString</i> is
///               <b>NULL</b>, the function returns the length of the menu string.
///    cchMax = Type: <b>int</b> The maximum length, in characters, of the string to be copied. If the string is longer than the
///             maximum specified in the <i>nMaxCount</i> parameter, the extra characters are truncated. If <i>nMaxCount</i> is
///             0, the function returns the length of the menu string.
///    flags = Type: <b>UINT</b> Indicates how the <i>uIDItem</i> parameter is interpreted. This parameter must be one of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td>
///            <td width="60%"> Indicates that <i>uIDItem</i> gives the identifier of the menu item. If neither the
///            <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified, the <b>MF_BYCOMMAND</b> flag is the default flag.
///            </td> </tr> <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl>
///            <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that <i>uIDItem</i>
///            gives the zero-based relative position of the menu item. </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value specifies the number of characters copied to the
///    buffer, not including the terminating null character. If the function fails, the return value is zero. If the
///    specified item is not of type <b>MIIM_STRING</b> or <b>MFT_STRING</b>, then the return value is zero.
///    
@DllImport("USER32")
int GetMenuStringW(HMENU hMenu, uint uIDItem, PWSTR lpString, int cchMax, uint flags);

///Retrieves the menu flags associated with the specified menu item. If the menu item opens a submenu, this function
///also returns the number of items in the submenu. <div class="alert"><b>Note</b> The <b>GetMenuState</b> function has
///been superseded by the GetMenuItemInfo. You can still use <b>GetMenuState</b>, however, if you do not need any of the
///extended features of <b>GetMenuItemInfo</b>.</div><div> </div>
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu that contains the menu item whose flags are to be retrieved.
///    uId = Type: <b>UINT</b> The menu item for which the menu flags are to be retrieved, as determined by the <i>uFlags</i>
///          parameter.
///    uFlags = Type: <b>UINT</b> Indicates how the <i>uId</i> parameter is interpreted. This parameter can be one of the
///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Indicates that the <i>uId</i> parameter gives the identifier of the menu item. The
///             <b>MF_BYCOMMAND</b> flag is the default if neither the <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is
///             specified. </td> </tr> <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl>
///             <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that the <i>uId</i>
///             parameter gives the zero-based relative position of the menu item. </td> </tr> </table>
///Returns:
///    Type: <b>UINT</b> If the specified item does not exist, the return value is -1. If the menu item opens a submenu,
///    the low-order byte of the return value contains the menu flags associated with the item, and the high-order byte
///    contains the number of items in the submenu opened by the item. Otherwise, the return value is a mask (Bitwise
///    OR) of the menu flags. Following are the menu flags associated with the menu item. <table> <tr> <th>Return
///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_CHECKED</b></dt>
///    <dt>0x00000008L</dt> </dl> </td> <td width="60%"> A check mark is placed next to the item (for drop-down menus,
///    submenus, and shortcut menus only). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_DISABLED</b></dt>
///    <dt>0x00000002L</dt> </dl> </td> <td width="60%"> The item is disabled. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The item is disabled and grayed.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_HILITE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td
///    width="60%"> The item is highlighted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_MENUBARBREAK</b></dt>
///    <dt>0x00000020L</dt> </dl> </td> <td width="60%"> This is the same as the <b>MF_MENUBREAK</b> flag, except for
///    drop-down menus, submenus, and shortcut menus, where the new column is separated from the old column by a
///    vertical line. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_MENUBREAK</b></dt> <dt>0x00000040L</dt> </dl>
///    </td> <td width="60%"> The item is placed on a new line (for menu bars) or in a new column (for drop-down menus,
///    submenus, and shortcut menus) without separating columns. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> The item is owner-drawn. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_POPUP</b></dt> <dt>0x00000010L</dt> </dl> </td> <td width="60%"> Menu
///    item is a submenu. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_SEPARATOR</b></dt> <dt>0x00000800L</dt> </dl>
///    </td> <td width="60%"> There is a horizontal dividing line (for drop-down menus, submenus, and shortcut menus
///    only). </td> </tr> </table>
///    
@DllImport("USER32")
uint GetMenuState(HMENU hMenu, uint uId, uint uFlags);

///Redraws the menu bar of the specified window. If the menu bar changes after the system has created the window, this
///function must be called to draw the changed menu bar.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose menu bar is to be redrawn.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DrawMenuBar(HWND hWnd);

///Enables the application to access the window menu (also known as the system menu or the control menu) for copying and
///modifying.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that will own a copy of the window menu.
///    bRevert = Type: <b>BOOL</b> The action to be taken. If this parameter is <b>FALSE</b>, <b>GetSystemMenu</b> returns a
///              handle to the copy of the window menu currently in use. The copy is initially identical to the window menu, but
///              it can be modified. If this parameter is <b>TRUE</b>, <b>GetSystemMenu</b> resets the window menu back to the
///              default state. The previous window menu, if any, is destroyed.
///Returns:
///    Type: <b>HMENU</b> If the <i>bRevert</i> parameter is <b>FALSE</b>, the return value is a handle to a copy of the
///    window menu. If the <i>bRevert</i> parameter is <b>TRUE</b>, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HMENU GetSystemMenu(HWND hWnd, BOOL bRevert);

///Creates a menu. The menu is initially empty, but it can be filled with menu items by using the InsertMenuItem,
///AppendMenu, and InsertMenu functions.
///Returns:
///    Type: <b>HMENU</b> If the function succeeds, the return value is a handle to the newly created menu. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HMENU CreateMenu();

///Creates a drop-down menu, submenu, or shortcut menu. The menu is initially empty. You can insert or append menu items
///by using the InsertMenuItem function. You can also use the InsertMenu function to insert menu items and the
///[AppendMenu](/windows/win32/api/winuser/nf-winuser-appendmenua) function to append menu items.
///Returns:
///    Type: <b>HMENU</b> If the function succeeds, the return value is a handle to the newly created menu. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HMENU CreatePopupMenu();

///Destroys the specified menu and frees any memory that the menu occupies.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu to be destroyed.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DestroyMenu(HMENU hMenu);

///<p class="CCE_Message">[<b>CheckMenuItem</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use SetMenuItemInfo. ] Sets
///the state of the specified menu item's check-mark attribute to either selected or clear.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu of interest.
///    uIDCheckItem = Type: <b>UINT</b> The menu item whose check-mark attribute is to be set, as determined by the <i>uCheck</i>
///                   parameter.
///    uCheck = Type: <b>UINT</b> The flags that control the interpretation of the <i>uIDCheckItem</i> parameter and the state of
///             the menu item's check-mark attribute. This parameter can be a combination of either <b>MF_BYCOMMAND</b>, or
///             <b>MF_BYPOSITION</b> and <b>MF_CHECKED</b> or <b>MF_UNCHECKED</b>. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt>
///             <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Indicates that the <i>uIDCheckItem</i> parameter gives the
///             identifier of the menu item. The <b>MF_BYCOMMAND</b> flag is the default, if neither the <b>MF_BYCOMMAND</b> nor
///             <b>MF_BYPOSITION</b> flag is specified. </td> </tr> <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a
///             id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%">
///             Indicates that the <i>uIDCheckItem</i> parameter gives the zero-based relative position of the menu item. </td>
///             </tr> <tr> <td width="40%"><a id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt>
///             <dt>0x00000008L</dt> </dl> </td> <td width="60%"> Sets the check-mark attribute to the selected state. </td>
///             </tr> <tr> <td width="40%"><a id="MF_UNCHECKED"></a><a id="mf_unchecked"></a><dl> <dt><b>MF_UNCHECKED</b></dt>
///             <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Sets the check-mark attribute to the clear state. </td> </tr>
///             </table>
///Returns:
///    Type: <b>DWORD</b> The return value specifies the previous state of the menu item (either <b>MF_CHECKED</b> or
///    <b>MF_UNCHECKED</b>). If the menu item does not exist, the return value is –1.
///    
@DllImport("USER32")
uint CheckMenuItem(HMENU hMenu, uint uIDCheckItem, uint uCheck);

///Enables, disables, or grays the specified menu item.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu.
///    uIDEnableItem = Type: <b>UINT</b> The menu item to be enabled, disabled, or grayed, as determined by the <i>uEnable</i>
///                    parameter. This parameter specifies an item in a menu bar, menu, or submenu.
///    uEnable = Type: <b>UINT</b> Controls the interpretation of the <i>uIDEnableItem</i> parameter and indicate whether the menu
///              item is enabled, disabled, or grayed. This parameter must be a combination of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl>
///              <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Indicates that
///              <i>uIDEnableItem</i> gives the identifier of the menu item. If neither the <b>MF_BYCOMMAND</b> nor
///              <b>MF_BYPOSITION</b> flag is specified, the <b>MF_BYCOMMAND</b> flag is the default flag. </td> </tr> <tr> <td
///              width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt>
///              <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that <i>uIDEnableItem</i> gives the zero-based
///              relative position of the menu item. </td> </tr> <tr> <td width="40%"><a id="MF_DISABLED"></a><a
///              id="mf_disabled"></a><dl> <dt><b>MF_DISABLED</b></dt> <dt>0x00000002L</dt> </dl> </td> <td width="60%"> Indicates
///              that the menu item is disabled, but not grayed, so it cannot be selected. </td> </tr> <tr> <td width="40%"><a
///              id="MF_ENABLED"></a><a id="mf_enabled"></a><dl> <dt><b>MF_ENABLED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td
///              width="60%"> Indicates that the menu item is enabled and restored from a grayed state so that it can be selected.
///              </td> </tr> <tr> <td width="40%"><a id="MF_GRAYED"></a><a id="mf_grayed"></a><dl> <dt><b>MF_GRAYED</b></dt>
///              <dt>0x00000001L</dt> </dl> </td> <td width="60%"> Indicates that the menu item is disabled and grayed so that it
///              cannot be selected. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> The return value specifies the previous state of the menu item (it is either
///    <b>MF_DISABLED</b>, <b>MF_ENABLED</b>, or <b>MF_GRAYED</b>). If the menu item does not exist, the return value is
///    -1.
///    
@DllImport("USER32")
BOOL EnableMenuItem(HMENU hMenu, uint uIDEnableItem, uint uEnable);

///Retrieves a handle to the drop-down menu or submenu activated by the specified menu item.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu.
///    nPos = Type: <b>int</b> The zero-based relative position in the specified menu of an item that activates a drop-down
///           menu or submenu.
///Returns:
///    Type: <b>HMENU</b> If the function succeeds, the return value is a handle to the drop-down menu or submenu
///    activated by the menu item. If the menu item does not activate a drop-down menu or submenu, the return value is
///    <b>NULL</b>.
///    
@DllImport("USER32")
HMENU GetSubMenu(HMENU hMenu, int nPos);

///Retrieves the menu item identifier of a menu item located at the specified position in a menu.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu that contains the item whose identifier is to be retrieved.
///    nPos = Type: <b>int</b> The zero-based relative position of the menu item whose identifier is to be retrieved.
///Returns:
///    Type: <b>UINT</b> The return value is the identifier of the specified menu item. If the menu item identifier is
///    <b>NULL</b> or if the specified item opens a submenu, the return value is -1.
///    
@DllImport("USER32")
uint GetMenuItemID(HMENU hMenu, int nPos);

///Determines the number of items in the specified menu.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu to be examined.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value specifies the number of items in the menu. If the
///    function fails, the return value is -1. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetMenuItemCount(HMENU hMenu);

///Inserts a new menu item into a menu, moving other items down the menu. <div class="alert"><b>Note</b> The
///<b>InsertMenu</b> function has been superseded by the InsertMenuItem function. You can still use <b>InsertMenu</b>,
///however, if you do not need any of the extended features of <b>InsertMenuItem</b>. </div><div> </div>
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu to be changed.
///    uPosition = Type: <b>UINT</b> The menu item before which the new menu item is to be inserted, as determined by the
///                <i>uFlags</i> parameter.
///    uFlags = Type: <b>UINT</b> Controls the interpretation of the <i>uPosition</i> parameter and the content, appearance, and
///             behavior of the new menu item. This parameter must include one of the following required values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl>
///             <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Indicates that the
///             <i>uPosition</i> parameter gives the identifier of the menu item. The <b>MF_BYCOMMAND</b> flag is the default if
///             neither the <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified. </td> </tr> <tr> <td width="40%"><a
///             id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl>
///             </td> <td width="60%"> Indicates that the <i>uPosition</i> parameter gives the zero-based relative position of
///             the new menu item. If <i>uPosition</i> is -1, the new menu item is appended to the end of the menu. </td> </tr>
///             </table> The parameter must also include at least one of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl>
///             <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Uses a bitmap as the menu item. The
///             <i>lpNewItem</i> parameter contains a handle to the bitmap. </td> </tr> <tr> <td width="40%"><a
///             id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
///             width="60%"> Places a check mark next to the menu item. If the application provides check-mark bitmaps (see
///             SetMenuItemBitmaps), this flag displays the check-mark bitmap next to the menu item. </td> </tr> <tr> <td
///             width="40%"><a id="MF_DISABLED"></a><a id="mf_disabled"></a><dl> <dt><b>MF_DISABLED</b></dt> <dt>0x00000002L</dt>
///             </dl> </td> <td width="60%"> Disables the menu item so that it cannot be selected, but does not gray it. </td>
///             </tr> <tr> <td width="40%"><a id="MF_ENABLED"></a><a id="mf_enabled"></a><dl> <dt><b>MF_ENABLED</b></dt>
///             <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables the menu item so that it can be selected and restores
///             it from its grayed state. </td> </tr> <tr> <td width="40%"><a id="MF_GRAYED"></a><a id="mf_grayed"></a><dl>
///             <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> Disables the menu item and grays it
///             so it cannot be selected. </td> </tr> <tr> <td width="40%"><a id="MF_MENUBARBREAK"></a><a
///             id="mf_menubarbreak"></a><dl> <dt><b>MF_MENUBARBREAK</b></dt> <dt>0x00000020L</dt> </dl> </td> <td width="60%">
///             Functions the same as the <b>MF_MENUBREAK</b> flag for a menu bar. For a drop-down menu, submenu, or shortcut
///             menu, the new column is separated from the old column by a vertical line. </td> </tr> <tr> <td width="40%"><a
///             id="MF_MENUBREAK"></a><a id="mf_menubreak"></a><dl> <dt><b>MF_MENUBREAK</b></dt> <dt>0x00000040L</dt> </dl> </td>
///             <td width="60%"> Places the item on a new line (for menu bars) or in a new column (for a drop-down menu, submenu,
///             or shortcut menu) without separating columns. </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a
///             id="mf_ownerdraw"></a><dl> <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%">
///             Specifies that the item is an owner-drawn item. Before the menu is displayed for the first time, the window that
///             owns the menu receives a WM_MEASUREITEM message to retrieve the width and height of the menu item. The
///             WM_DRAWITEM message is then sent to the window procedure of the owner window whenever the appearance of the menu
///             item must be updated. </td> </tr> <tr> <td width="40%"><a id="MF_POPUP"></a><a id="mf_popup"></a><dl>
///             <dt><b>MF_POPUP</b></dt> <dt>0x00000010L</dt> </dl> </td> <td width="60%"> Specifies that the menu item opens a
///             drop-down menu or submenu. The <i>uIDNewItem</i> parameter specifies a handle to the drop-down menu or submenu.
///             This flag is used to add a menu name to a menu bar or a menu item that opens a submenu to a drop-down menu,
///             submenu, or shortcut menu. </td> </tr> <tr> <td width="40%"><a id="MF_SEPARATOR"></a><a
///             id="mf_separator"></a><dl> <dt><b>MF_SEPARATOR</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%"> Draws a
///             horizontal dividing line. This flag is used only in a drop-down menu, submenu, or shortcut menu. The line cannot
///             be grayed, disabled, or highlighted. The <i>lpNewItem</i> and <i>uIDNewItem</i> parameters are ignored. </td>
///             </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt>
///             <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is a text string; the
///             <i>lpNewItem</i> parameter is a pointer to the string. </td> </tr> <tr> <td width="40%"><a
///             id="MF_UNCHECKED"></a><a id="mf_unchecked"></a><dl> <dt><b>MF_UNCHECKED</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Does not place a check mark next to the menu item (default). If the application supplies
///             check-mark bitmaps (see the SetMenuItemBitmaps function), this flag displays the clear bitmap next to the menu
///             item. </td> </tr> </table>
///    uIDNewItem = Type: <b>UINT_PTR</b> The identifier of the new menu item or, if the <i>uFlags</i> parameter has the
///                 <b>MF_POPUP</b> flag set, a handle to the drop-down menu or submenu.
///    lpNewItem = Type: <b>LPCTSTR</b> The content of the new menu item. The interpretation of <i>lpNewItem</i> depends on whether
///                the <i>uFlags</i> parameter includes the <b>MF_BITMAP</b>, <b>MF_OWNERDRAW</b>, or <b>MF_STRING</b> flag, as
///                follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a
///                id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Contains a
///                bitmap handle. </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl>
///                <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> Contains an application-supplied
///                value that can be used to maintain additional data related to the menu item. The value is in the <b>itemData</b>
///                member of the structure pointed to by the <i>lParam</i> parameter of the WM_MEASUREITEM or WM_DRAWITEM message
///                sent when the menu item is created or its appearance is updated. </td> </tr> <tr> <td width="40%"><a
///                id="MF_STRING"></a><a id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td
///                width="60%"> Contains a pointer to a null-terminated string (the default). </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL InsertMenuA(HMENU hMenu, uint uPosition, uint uFlags, size_t uIDNewItem, const(PSTR) lpNewItem);

///Inserts a new menu item into a menu, moving other items down the menu. <div class="alert"><b>Note</b> The
///<b>InsertMenu</b> function has been superseded by the InsertMenuItem function. You can still use <b>InsertMenu</b>,
///however, if you do not need any of the extended features of <b>InsertMenuItem</b>. </div><div> </div>
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu to be changed.
///    uPosition = Type: <b>UINT</b> The menu item before which the new menu item is to be inserted, as determined by the
///                <i>uFlags</i> parameter.
///    uFlags = Type: <b>UINT</b> Controls the interpretation of the <i>uPosition</i> parameter and the content, appearance, and
///             behavior of the new menu item. This parameter must include one of the following required values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl>
///             <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Indicates that the
///             <i>uPosition</i> parameter gives the identifier of the menu item. The <b>MF_BYCOMMAND</b> flag is the default if
///             neither the <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified. </td> </tr> <tr> <td width="40%"><a
///             id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl>
///             </td> <td width="60%"> Indicates that the <i>uPosition</i> parameter gives the zero-based relative position of
///             the new menu item. If <i>uPosition</i> is -1, the new menu item is appended to the end of the menu. </td> </tr>
///             </table> The parameter must also include at least one of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl>
///             <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Uses a bitmap as the menu item. The
///             <i>lpNewItem</i> parameter contains a handle to the bitmap. </td> </tr> <tr> <td width="40%"><a
///             id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
///             width="60%"> Places a check mark next to the menu item. If the application provides check-mark bitmaps (see
///             SetMenuItemBitmaps), this flag displays the check-mark bitmap next to the menu item. </td> </tr> <tr> <td
///             width="40%"><a id="MF_DISABLED"></a><a id="mf_disabled"></a><dl> <dt><b>MF_DISABLED</b></dt> <dt>0x00000002L</dt>
///             </dl> </td> <td width="60%"> Disables the menu item so that it cannot be selected, but does not gray it. </td>
///             </tr> <tr> <td width="40%"><a id="MF_ENABLED"></a><a id="mf_enabled"></a><dl> <dt><b>MF_ENABLED</b></dt>
///             <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables the menu item so that it can be selected and restores
///             it from its grayed state. </td> </tr> <tr> <td width="40%"><a id="MF_GRAYED"></a><a id="mf_grayed"></a><dl>
///             <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> Disables the menu item and grays it
///             so it cannot be selected. </td> </tr> <tr> <td width="40%"><a id="MF_MENUBARBREAK"></a><a
///             id="mf_menubarbreak"></a><dl> <dt><b>MF_MENUBARBREAK</b></dt> <dt>0x00000020L</dt> </dl> </td> <td width="60%">
///             Functions the same as the <b>MF_MENUBREAK</b> flag for a menu bar. For a drop-down menu, submenu, or shortcut
///             menu, the new column is separated from the old column by a vertical line. </td> </tr> <tr> <td width="40%"><a
///             id="MF_MENUBREAK"></a><a id="mf_menubreak"></a><dl> <dt><b>MF_MENUBREAK</b></dt> <dt>0x00000040L</dt> </dl> </td>
///             <td width="60%"> Places the item on a new line (for menu bars) or in a new column (for a drop-down menu, submenu,
///             or shortcut menu) without separating columns. </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a
///             id="mf_ownerdraw"></a><dl> <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%">
///             Specifies that the item is an owner-drawn item. Before the menu is displayed for the first time, the window that
///             owns the menu receives a WM_MEASUREITEM message to retrieve the width and height of the menu item. The
///             WM_DRAWITEM message is then sent to the window procedure of the owner window whenever the appearance of the menu
///             item must be updated. </td> </tr> <tr> <td width="40%"><a id="MF_POPUP"></a><a id="mf_popup"></a><dl>
///             <dt><b>MF_POPUP</b></dt> <dt>0x00000010L</dt> </dl> </td> <td width="60%"> Specifies that the menu item opens a
///             drop-down menu or submenu. The <i>uIDNewItem</i> parameter specifies a handle to the drop-down menu or submenu.
///             This flag is used to add a menu name to a menu bar or a menu item that opens a submenu to a drop-down menu,
///             submenu, or shortcut menu. </td> </tr> <tr> <td width="40%"><a id="MF_SEPARATOR"></a><a
///             id="mf_separator"></a><dl> <dt><b>MF_SEPARATOR</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%"> Draws a
///             horizontal dividing line. This flag is used only in a drop-down menu, submenu, or shortcut menu. The line cannot
///             be grayed, disabled, or highlighted. The <i>lpNewItem</i> and <i>uIDNewItem</i> parameters are ignored. </td>
///             </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt>
///             <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is a text string; the
///             <i>lpNewItem</i> parameter is a pointer to the string. </td> </tr> <tr> <td width="40%"><a
///             id="MF_UNCHECKED"></a><a id="mf_unchecked"></a><dl> <dt><b>MF_UNCHECKED</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Does not place a check mark next to the menu item (default). If the application supplies
///             check-mark bitmaps (see the SetMenuItemBitmaps function), this flag displays the clear bitmap next to the menu
///             item. </td> </tr> </table>
///    uIDNewItem = Type: <b>UINT_PTR</b> The identifier of the new menu item or, if the <i>uFlags</i> parameter has the
///                 <b>MF_POPUP</b> flag set, a handle to the drop-down menu or submenu.
///    lpNewItem = Type: <b>LPCTSTR</b> The content of the new menu item. The interpretation of <i>lpNewItem</i> depends on whether
///                the <i>uFlags</i> parameter includes the <b>MF_BITMAP</b>, <b>MF_OWNERDRAW</b>, or <b>MF_STRING</b> flag, as
///                follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a
///                id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Contains a
///                bitmap handle. </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl>
///                <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> Contains an application-supplied
///                value that can be used to maintain additional data related to the menu item. The value is in the <b>itemData</b>
///                member of the structure pointed to by the <i>lParam</i> parameter of the WM_MEASUREITEM or WM_DRAWITEM message
///                sent when the menu item is created or its appearance is updated. </td> </tr> <tr> <td width="40%"><a
///                id="MF_STRING"></a><a id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td
///                width="60%"> Contains a pointer to a null-terminated string (the default). </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL InsertMenuW(HMENU hMenu, uint uPosition, uint uFlags, size_t uIDNewItem, const(PWSTR) lpNewItem);

///Appends a new item to the end of the specified menu bar, drop-down menu, submenu, or shortcut menu. You can use this
///function to specify the content, appearance, and behavior of the menu item.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu bar, drop-down menu, submenu, or shortcut menu to be changed.
///    uFlags = Type: <b>UINT</b> Controls the appearance and behavior of the new menu item. This parameter can be a combination
///             of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td
///             width="60%"> Uses a bitmap as the menu item. The <i>lpNewItem</i> parameter contains a handle to the bitmap.
///             </td> </tr> <tr> <td width="40%"><a id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt>
///             <dt>0x00000008L</dt> </dl> </td> <td width="60%"> Places a check mark next to the menu item. If the application
///             provides check-mark bitmaps (see SetMenuItemBitmaps, this flag displays the check-mark bitmap next to the menu
///             item. </td> </tr> <tr> <td width="40%"><a id="MF_DISABLED"></a><a id="mf_disabled"></a><dl>
///             <dt><b>MF_DISABLED</b></dt> <dt>0x00000002L</dt> </dl> </td> <td width="60%"> Disables the menu item so that it
///             cannot be selected, but the flag does not gray it. </td> </tr> <tr> <td width="40%"><a id="MF_ENABLED"></a><a
///             id="mf_enabled"></a><dl> <dt><b>MF_ENABLED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables the
///             menu item so that it can be selected, and restores it from its grayed state. </td> </tr> <tr> <td width="40%"><a
///             id="MF_GRAYED"></a><a id="mf_grayed"></a><dl> <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td
///             width="60%"> Disables the menu item and grays it so that it cannot be selected. </td> </tr> <tr> <td
///             width="40%"><a id="MF_MENUBARBREAK"></a><a id="mf_menubarbreak"></a><dl> <dt><b>MF_MENUBARBREAK</b></dt>
///             <dt>0x00000020L</dt> </dl> </td> <td width="60%"> Functions the same as the <b>MF_MENUBREAK</b> flag for a menu
///             bar. For a drop-down menu, submenu, or shortcut menu, the new column is separated from the old column by a
///             vertical line. </td> </tr> <tr> <td width="40%"><a id="MF_MENUBREAK"></a><a id="mf_menubreak"></a><dl>
///             <dt><b>MF_MENUBREAK</b></dt> <dt>0x00000040L</dt> </dl> </td> <td width="60%"> Places the item on a new line (for
///             a menu bar) or in a new column (for a drop-down menu, submenu, or shortcut menu) without separating columns.
///             </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl>
///             <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> Specifies that the item is an
///             owner-drawn item. Before the menu is displayed for the first time, the window that owns the menu receives a
///             WM_MEASUREITEM message to retrieve the width and height of the menu item. The WM_DRAWITEM message is then sent to
///             the window procedure of the owner window whenever the appearance of the menu item must be updated. </td> </tr>
///             <tr> <td width="40%"><a id="MF_POPUP"></a><a id="mf_popup"></a><dl> <dt><b>MF_POPUP</b></dt> <dt>0x00000010L</dt>
///             </dl> </td> <td width="60%"> Specifies that the menu item opens a drop-down menu or submenu. The
///             <i>uIDNewItem</i> parameter specifies a handle to the drop-down menu or submenu. This flag is used to add a menu
///             name to a menu bar, or a menu item that opens a submenu to a drop-down menu, submenu, or shortcut menu. </td>
///             </tr> <tr> <td width="40%"><a id="MF_SEPARATOR"></a><a id="mf_separator"></a><dl> <dt><b>MF_SEPARATOR</b></dt>
///             <dt>0x00000800L</dt> </dl> </td> <td width="60%"> Draws a horizontal dividing line. This flag is used only in a
///             drop-down menu, submenu, or shortcut menu. The line cannot be grayed, disabled, or highlighted. The
///             <i>lpNewItem</i> and <i>uIDNewItem</i> parameters are ignored. </td> </tr> <tr> <td width="40%"><a
///             id="MF_STRING"></a><a id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td
///             width="60%"> Specifies that the menu item is a text string; the <i>lpNewItem</i> parameter is a pointer to the
///             string. </td> </tr> <tr> <td width="40%"><a id="MF_UNCHECKED"></a><a id="mf_unchecked"></a><dl>
///             <dt><b>MF_UNCHECKED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Does not place a check mark next
///             to the item (default). If the application supplies check-mark bitmaps (see SetMenuItemBitmaps), this flag
///             displays the clear bitmap next to the menu item. </td> </tr> </table>
///    uIDNewItem = Type: <b>UINT_PTR</b> The identifier of the new menu item or, if the <i>uFlags</i> parameter is set to
///                 <b>MF_POPUP</b>, a handle to the drop-down menu or submenu.
///    lpNewItem = Type: <b>LPCTSTR</b> The content of the new menu item. The interpretation of <i>lpNewItem</i> depends on whether
///                the <i>uFlags</i> parameter includes the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                <tr> <td width="40%"><a id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt>
///                <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Contains a bitmap handle. </td> </tr> <tr> <td width="40%"><a
///                id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl> <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td>
///                <td width="60%"> Contains an application-supplied value that can be used to maintain additional data related to
///                the menu item. The value is in the <b>itemData</b> member of the structure pointed to by the <i>lParam</i>
///                parameter of the WM_MEASUREITEM or WM_DRAWITEM message sent when the menu is created or its appearance is
///                updated. </td> </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a id="mf_string"></a><dl>
///                <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Contains a pointer to a
///                null-terminated string. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL AppendMenuA(HMENU hMenu, uint uFlags, size_t uIDNewItem, const(PSTR) lpNewItem);

///Appends a new item to the end of the specified menu bar, drop-down menu, submenu, or shortcut menu. You can use this
///function to specify the content, appearance, and behavior of the menu item.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu bar, drop-down menu, submenu, or shortcut menu to be changed.
///    uFlags = Type: <b>UINT</b> Controls the appearance and behavior of the new menu item. This parameter can be a combination
///             of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td
///             width="60%"> Uses a bitmap as the menu item. The <i>lpNewItem</i> parameter contains a handle to the bitmap.
///             </td> </tr> <tr> <td width="40%"><a id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt>
///             <dt>0x00000008L</dt> </dl> </td> <td width="60%"> Places a check mark next to the menu item. If the application
///             provides check-mark bitmaps (see SetMenuItemBitmaps, this flag displays the check-mark bitmap next to the menu
///             item. </td> </tr> <tr> <td width="40%"><a id="MF_DISABLED"></a><a id="mf_disabled"></a><dl>
///             <dt><b>MF_DISABLED</b></dt> <dt>0x00000002L</dt> </dl> </td> <td width="60%"> Disables the menu item so that it
///             cannot be selected, but the flag does not gray it. </td> </tr> <tr> <td width="40%"><a id="MF_ENABLED"></a><a
///             id="mf_enabled"></a><dl> <dt><b>MF_ENABLED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables the
///             menu item so that it can be selected, and restores it from its grayed state. </td> </tr> <tr> <td width="40%"><a
///             id="MF_GRAYED"></a><a id="mf_grayed"></a><dl> <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td
///             width="60%"> Disables the menu item and grays it so that it cannot be selected. </td> </tr> <tr> <td
///             width="40%"><a id="MF_MENUBARBREAK"></a><a id="mf_menubarbreak"></a><dl> <dt><b>MF_MENUBARBREAK</b></dt>
///             <dt>0x00000020L</dt> </dl> </td> <td width="60%"> Functions the same as the <b>MF_MENUBREAK</b> flag for a menu
///             bar. For a drop-down menu, submenu, or shortcut menu, the new column is separated from the old column by a
///             vertical line. </td> </tr> <tr> <td width="40%"><a id="MF_MENUBREAK"></a><a id="mf_menubreak"></a><dl>
///             <dt><b>MF_MENUBREAK</b></dt> <dt>0x00000040L</dt> </dl> </td> <td width="60%"> Places the item on a new line (for
///             a menu bar) or in a new column (for a drop-down menu, submenu, or shortcut menu) without separating columns.
///             </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl>
///             <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> Specifies that the item is an
///             owner-drawn item. Before the menu is displayed for the first time, the window that owns the menu receives a
///             WM_MEASUREITEM message to retrieve the width and height of the menu item. The WM_DRAWITEM message is then sent to
///             the window procedure of the owner window whenever the appearance of the menu item must be updated. </td> </tr>
///             <tr> <td width="40%"><a id="MF_POPUP"></a><a id="mf_popup"></a><dl> <dt><b>MF_POPUP</b></dt> <dt>0x00000010L</dt>
///             </dl> </td> <td width="60%"> Specifies that the menu item opens a drop-down menu or submenu. The
///             <i>uIDNewItem</i> parameter specifies a handle to the drop-down menu or submenu. This flag is used to add a menu
///             name to a menu bar, or a menu item that opens a submenu to a drop-down menu, submenu, or shortcut menu. </td>
///             </tr> <tr> <td width="40%"><a id="MF_SEPARATOR"></a><a id="mf_separator"></a><dl> <dt><b>MF_SEPARATOR</b></dt>
///             <dt>0x00000800L</dt> </dl> </td> <td width="60%"> Draws a horizontal dividing line. This flag is used only in a
///             drop-down menu, submenu, or shortcut menu. The line cannot be grayed, disabled, or highlighted. The
///             <i>lpNewItem</i> and <i>uIDNewItem</i> parameters are ignored. </td> </tr> <tr> <td width="40%"><a
///             id="MF_STRING"></a><a id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td
///             width="60%"> Specifies that the menu item is a text string; the <i>lpNewItem</i> parameter is a pointer to the
///             string. </td> </tr> <tr> <td width="40%"><a id="MF_UNCHECKED"></a><a id="mf_unchecked"></a><dl>
///             <dt><b>MF_UNCHECKED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Does not place a check mark next
///             to the item (default). If the application supplies check-mark bitmaps (see SetMenuItemBitmaps), this flag
///             displays the clear bitmap next to the menu item. </td> </tr> </table>
///    uIDNewItem = Type: <b>UINT_PTR</b> The identifier of the new menu item or, if the <i>uFlags</i> parameter is set to
///                 <b>MF_POPUP</b>, a handle to the drop-down menu or submenu.
///    lpNewItem = Type: <b>LPCTSTR</b> The content of the new menu item. The interpretation of <i>lpNewItem</i> depends on whether
///                the <i>uFlags</i> parameter includes the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                <tr> <td width="40%"><a id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt>
///                <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Contains a bitmap handle. </td> </tr> <tr> <td width="40%"><a
///                id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl> <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td>
///                <td width="60%"> Contains an application-supplied value that can be used to maintain additional data related to
///                the menu item. The value is in the <b>itemData</b> member of the structure pointed to by the <i>lParam</i>
///                parameter of the WM_MEASUREITEM or WM_DRAWITEM message sent when the menu is created or its appearance is
///                updated. </td> </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a id="mf_string"></a><dl>
///                <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Contains a pointer to a
///                null-terminated string. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL AppendMenuW(HMENU hMenu, uint uFlags, size_t uIDNewItem, const(PWSTR) lpNewItem);

///Changes an existing menu item. This function is used to specify the content, appearance, and behavior of the menu
///item. <div class="alert"><b>Note</b> The <b>ModifyMenu</b> function has been superseded by the SetMenuItemInfo
///function. You can still use <b>ModifyMenu</b>, however, if you do not need any of the extended features of
///<b>SetMenuItemInfo</b>.</div><div> </div>
///Params:
///    hMnu = Type: <b>HMENU</b> A handle to the menu to be changed.
///    uPosition = Type: <b>UINT</b> The menu item to be changed, as determined by the <i>uFlags</i> parameter.
///    uFlags = Type: <b>UINT</b> Controls the interpretation of the <i>uPosition</i> parameter and the content, appearance, and
///             behavior of the menu item. This parameter must include one of the following required values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl>
///             <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Indicates that the
///             <i>uPosition</i> parameter gives the identifier of the menu item. The <b>MF_BYCOMMAND</b> flag is the default if
///             neither the <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified. </td> </tr> <tr> <td width="40%"><a
///             id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl>
///             </td> <td width="60%"> Indicates that the <i>uPosition</i> parameter gives the zero-based relative position of
///             the menu item. </td> </tr> </table> The parameter must also include at least one of the following values. <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl>
///             <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Uses a bitmap as the menu item. The
///             <i>lpNewItem</i> parameter contains a handle to the bitmap. </td> </tr> <tr> <td width="40%"><a
///             id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
///             width="60%"> Places a check mark next to the item. If your application provides check-mark bitmaps (see the
///             SetMenuItemBitmaps function), this flag displays a selected bitmap next to the menu item. </td> </tr> <tr> <td
///             width="40%"><a id="MF_DISABLED"></a><a id="mf_disabled"></a><dl> <dt><b>MF_DISABLED</b></dt> <dt>0x00000002L</dt>
///             </dl> </td> <td width="60%"> Disables the menu item so that it cannot be selected, but this flag does not gray
///             it. </td> </tr> <tr> <td width="40%"><a id="MF_ENABLED"></a><a id="mf_enabled"></a><dl>
///             <dt><b>MF_ENABLED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables the menu item so that it can
///             be selected and restores it from its grayed state. </td> </tr> <tr> <td width="40%"><a id="MF_GRAYED"></a><a
///             id="mf_grayed"></a><dl> <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> Disables the
///             menu item and grays it so that it cannot be selected. </td> </tr> <tr> <td width="40%"><a
///             id="MF_MENUBARBREAK"></a><a id="mf_menubarbreak"></a><dl> <dt><b>MF_MENUBARBREAK</b></dt> <dt>0x00000020L</dt>
///             </dl> </td> <td width="60%"> Functions the same as the <b>MF_MENUBREAK</b> flag for a menu bar. For a drop-down
///             menu, submenu, or shortcut menu, the new column is separated from the old column by a vertical line. </td> </tr>
///             <tr> <td width="40%"><a id="MF_MENUBREAK"></a><a id="mf_menubreak"></a><dl> <dt><b>MF_MENUBREAK</b></dt>
///             <dt>0x00000040L</dt> </dl> </td> <td width="60%"> Places the item on a new line (for menu bars) or in a new
///             column (for a drop-down menu, submenu, or shortcut menu) without separating columns. </td> </tr> <tr> <td
///             width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl> <dt><b>MF_OWNERDRAW</b></dt>
///             <dt>0x00000100L</dt> </dl> </td> <td width="60%"> Specifies that the item is an owner-drawn item. Before the menu
///             is displayed for the first time, the window that owns the menu receives a WM_MEASUREITEM message to retrieve the
///             width and height of the menu item. The WM_DRAWITEM message is then sent to the window procedure of the owner
///             window whenever the appearance of the menu item must be updated. </td> </tr> <tr> <td width="40%"><a
///             id="MF_POPUP"></a><a id="mf_popup"></a><dl> <dt><b>MF_POPUP</b></dt> <dt>0x00000010L</dt> </dl> </td> <td
///             width="60%"> Specifies that the menu item opens a drop-down menu or submenu. The <i>uIDNewItem</i> parameter
///             specifies a handle to the drop-down menu or submenu. This flag is used to add a menu name to a menu bar or a menu
///             item that opens a submenu to a drop-down menu, submenu, or shortcut menu. </td> </tr> <tr> <td width="40%"><a
///             id="MF_SEPARATOR"></a><a id="mf_separator"></a><dl> <dt><b>MF_SEPARATOR</b></dt> <dt>0x00000800L</dt> </dl> </td>
///             <td width="60%"> Draws a horizontal dividing line. This flag is used only in a drop-down menu, submenu, or
///             shortcut menu. The line cannot be grayed, disabled, or highlighted. The <i>lpNewItem</i> and <i>uIDNewItem</i>
///             parameters are ignored. </td> </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a id="mf_string"></a><dl>
///             <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is a
///             text string; the <i>lpNewItem</i> parameter is a pointer to the string. </td> </tr> <tr> <td width="40%"><a
///             id="MF_UNCHECKED"></a><a id="mf_unchecked"></a><dl> <dt><b>MF_UNCHECKED</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Does not place a check mark next to the item (the default). If your application supplies
///             check-mark bitmaps (see the SetMenuItemBitmaps function), this flag displays a clear bitmap next to the menu
///             item. </td> </tr> </table>
///    uIDNewItem = Type: <b>UINT_PTR</b> The identifier of the modified menu item or, if the <i>uFlags</i> parameter has the
///                 <b>MF_POPUP</b> flag set, a handle to the drop-down menu or submenu.
///    lpNewItem = Type: <b>LPCTSTR</b> The contents of the changed menu item. The interpretation of this parameter depends on
///                whether the <i>uFlags</i> parameter includes the <b>MF_BITMAP</b>, <b>MF_OWNERDRAW</b>, or <b>MF_STRING</b> flag.
///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a
///                id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> A bitmap
///                handle. </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl>
///                <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> A value supplied by an application
///                that is used to maintain additional data related to the menu item. The value is in the <b>itemData</b> member of
///                the structure pointed to by the <i>lParam</i> parameter of the WM_MEASUREITEM or WM_DRAWITEM messages sent when
///                the menu item is created or its appearance is updated. </td> </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a
///                id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> A pointer to
///                a null-terminated string (the default). </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ModifyMenuA(HMENU hMnu, uint uPosition, uint uFlags, size_t uIDNewItem, const(PSTR) lpNewItem);

///Changes an existing menu item. This function is used to specify the content, appearance, and behavior of the menu
///item. <div class="alert"><b>Note</b> The <b>ModifyMenu</b> function has been superseded by the SetMenuItemInfo
///function. You can still use <b>ModifyMenu</b>, however, if you do not need any of the extended features of
///<b>SetMenuItemInfo</b>.</div><div> </div>
///Params:
///    hMnu = Type: <b>HMENU</b> A handle to the menu to be changed.
///    uPosition = Type: <b>UINT</b> The menu item to be changed, as determined by the <i>uFlags</i> parameter.
///    uFlags = Type: <b>UINT</b> Controls the interpretation of the <i>uPosition</i> parameter and the content, appearance, and
///             behavior of the menu item. This parameter must include one of the following required values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl>
///             <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Indicates that the
///             <i>uPosition</i> parameter gives the identifier of the menu item. The <b>MF_BYCOMMAND</b> flag is the default if
///             neither the <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified. </td> </tr> <tr> <td width="40%"><a
///             id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl>
///             </td> <td width="60%"> Indicates that the <i>uPosition</i> parameter gives the zero-based relative position of
///             the menu item. </td> </tr> </table> The parameter must also include at least one of the following values. <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a id="mf_bitmap"></a><dl>
///             <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Uses a bitmap as the menu item. The
///             <i>lpNewItem</i> parameter contains a handle to the bitmap. </td> </tr> <tr> <td width="40%"><a
///             id="MF_CHECKED"></a><a id="mf_checked"></a><dl> <dt><b>MF_CHECKED</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
///             width="60%"> Places a check mark next to the item. If your application provides check-mark bitmaps (see the
///             SetMenuItemBitmaps function), this flag displays a selected bitmap next to the menu item. </td> </tr> <tr> <td
///             width="40%"><a id="MF_DISABLED"></a><a id="mf_disabled"></a><dl> <dt><b>MF_DISABLED</b></dt> <dt>0x00000002L</dt>
///             </dl> </td> <td width="60%"> Disables the menu item so that it cannot be selected, but this flag does not gray
///             it. </td> </tr> <tr> <td width="40%"><a id="MF_ENABLED"></a><a id="mf_enabled"></a><dl>
///             <dt><b>MF_ENABLED</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Enables the menu item so that it can
///             be selected and restores it from its grayed state. </td> </tr> <tr> <td width="40%"><a id="MF_GRAYED"></a><a
///             id="mf_grayed"></a><dl> <dt><b>MF_GRAYED</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> Disables the
///             menu item and grays it so that it cannot be selected. </td> </tr> <tr> <td width="40%"><a
///             id="MF_MENUBARBREAK"></a><a id="mf_menubarbreak"></a><dl> <dt><b>MF_MENUBARBREAK</b></dt> <dt>0x00000020L</dt>
///             </dl> </td> <td width="60%"> Functions the same as the <b>MF_MENUBREAK</b> flag for a menu bar. For a drop-down
///             menu, submenu, or shortcut menu, the new column is separated from the old column by a vertical line. </td> </tr>
///             <tr> <td width="40%"><a id="MF_MENUBREAK"></a><a id="mf_menubreak"></a><dl> <dt><b>MF_MENUBREAK</b></dt>
///             <dt>0x00000040L</dt> </dl> </td> <td width="60%"> Places the item on a new line (for menu bars) or in a new
///             column (for a drop-down menu, submenu, or shortcut menu) without separating columns. </td> </tr> <tr> <td
///             width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl> <dt><b>MF_OWNERDRAW</b></dt>
///             <dt>0x00000100L</dt> </dl> </td> <td width="60%"> Specifies that the item is an owner-drawn item. Before the menu
///             is displayed for the first time, the window that owns the menu receives a WM_MEASUREITEM message to retrieve the
///             width and height of the menu item. The WM_DRAWITEM message is then sent to the window procedure of the owner
///             window whenever the appearance of the menu item must be updated. </td> </tr> <tr> <td width="40%"><a
///             id="MF_POPUP"></a><a id="mf_popup"></a><dl> <dt><b>MF_POPUP</b></dt> <dt>0x00000010L</dt> </dl> </td> <td
///             width="60%"> Specifies that the menu item opens a drop-down menu or submenu. The <i>uIDNewItem</i> parameter
///             specifies a handle to the drop-down menu or submenu. This flag is used to add a menu name to a menu bar or a menu
///             item that opens a submenu to a drop-down menu, submenu, or shortcut menu. </td> </tr> <tr> <td width="40%"><a
///             id="MF_SEPARATOR"></a><a id="mf_separator"></a><dl> <dt><b>MF_SEPARATOR</b></dt> <dt>0x00000800L</dt> </dl> </td>
///             <td width="60%"> Draws a horizontal dividing line. This flag is used only in a drop-down menu, submenu, or
///             shortcut menu. The line cannot be grayed, disabled, or highlighted. The <i>lpNewItem</i> and <i>uIDNewItem</i>
///             parameters are ignored. </td> </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a id="mf_string"></a><dl>
///             <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Specifies that the menu item is a
///             text string; the <i>lpNewItem</i> parameter is a pointer to the string. </td> </tr> <tr> <td width="40%"><a
///             id="MF_UNCHECKED"></a><a id="mf_unchecked"></a><dl> <dt><b>MF_UNCHECKED</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Does not place a check mark next to the item (the default). If your application supplies
///             check-mark bitmaps (see the SetMenuItemBitmaps function), this flag displays a clear bitmap next to the menu
///             item. </td> </tr> </table>
///    uIDNewItem = Type: <b>UINT_PTR</b> The identifier of the modified menu item or, if the <i>uFlags</i> parameter has the
///                 <b>MF_POPUP</b> flag set, a handle to the drop-down menu or submenu.
///    lpNewItem = Type: <b>LPCTSTR</b> The contents of the changed menu item. The interpretation of this parameter depends on
///                whether the <i>uFlags</i> parameter includes the <b>MF_BITMAP</b>, <b>MF_OWNERDRAW</b>, or <b>MF_STRING</b> flag.
///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MF_BITMAP"></a><a
///                id="mf_bitmap"></a><dl> <dt><b>MF_BITMAP</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> A bitmap
///                handle. </td> </tr> <tr> <td width="40%"><a id="MF_OWNERDRAW"></a><a id="mf_ownerdraw"></a><dl>
///                <dt><b>MF_OWNERDRAW</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> A value supplied by an application
///                that is used to maintain additional data related to the menu item. The value is in the <b>itemData</b> member of
///                the structure pointed to by the <i>lParam</i> parameter of the WM_MEASUREITEM or WM_DRAWITEM messages sent when
///                the menu item is created or its appearance is updated. </td> </tr> <tr> <td width="40%"><a id="MF_STRING"></a><a
///                id="mf_string"></a><dl> <dt><b>MF_STRING</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> A pointer to
///                a null-terminated string (the default). </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ModifyMenuW(HMENU hMnu, uint uPosition, uint uFlags, size_t uIDNewItem, const(PWSTR) lpNewItem);

///Deletes a menu item or detaches a submenu from the specified menu. If the menu item opens a drop-down menu or
///submenu, <b>RemoveMenu</b> does not destroy the menu or its handle, allowing the menu to be reused. Before this
///function is called, the GetSubMenu function should retrieve a handle to the drop-down menu or submenu.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu to be changed.
///    uPosition = Type: <b>UINT</b> The menu item to be deleted, as determined by the <i>uFlags</i> parameter.
///    uFlags = Type: <b>UINT</b> Indicates how the <i>uPosition</i> parameter is interpreted. This parameter must be one of the
///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Indicates that <i>uPosition</i> gives the identifier of the menu item. If neither the
///             <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified, the <b>MF_BYCOMMAND</b> flag is the default flag.
///             </td> </tr> <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl>
///             <dt><b>MF_BYPOSITION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that <i>uPosition</i>
///             gives the zero-based relative position of the menu item. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL RemoveMenu(HMENU hMenu, uint uPosition, uint uFlags);

///Deletes an item from the specified menu. If the menu item opens a menu or submenu, this function destroys the handle
///to the menu or submenu and frees the memory used by the menu or submenu.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu to be changed.
///    uPosition = Type: <b>UINT</b> The menu item to be deleted, as determined by the <i>uFlags</i> parameter.
///    uFlags = Type: <b>UINT</b> Indicates how the <i>uPosition</i> parameter is interpreted. This parameter must be one of the
///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Indicates that <i>uPosition</i> gives the identifier of the menu item. The <b>MF_BYCOMMAND</b>
///             flag is the default flag if neither the <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> flag is specified. </td>
///             </tr> <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt>
///             <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that <i>uPosition</i> gives the zero-based relative
///             position of the menu item. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DeleteMenu(HMENU hMenu, uint uPosition, uint uFlags);

///Associates the specified bitmap with a menu item. Whether the menu item is selected or clear, the system displays the
///appropriate bitmap next to the menu item.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu containing the item to receive new check-mark bitmaps.
///    uPosition = Type: <b>UINT</b> The menu item to be changed, as determined by the <i>uFlags</i> parameter.
///    uFlags = Type: <b>UINT</b> Specifies how the <i>uPosition</i> parameter is to be interpreted. The <i>uFlags</i> parameter
///             must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="MF_BYCOMMAND"></a><a id="mf_bycommand"></a><dl> <dt><b>MF_BYCOMMAND</b></dt> <dt>0x00000000L</dt> </dl> </td>
///             <td width="60%"> Indicates that <i>uPosition</i> gives the identifier of the menu item. If neither
///             <b>MF_BYCOMMAND</b> nor <b>MF_BYPOSITION</b> is specified, <b>MF_BYCOMMAND</b> is the default flag. </td> </tr>
///             <tr> <td width="40%"><a id="MF_BYPOSITION"></a><a id="mf_byposition"></a><dl> <dt><b>MF_BYPOSITION</b></dt>
///             <dt>0x00000400L</dt> </dl> </td> <td width="60%"> Indicates that <i>uPosition</i> gives the zero-based relative
///             position of the menu item. </td> </tr> </table>
///    hBitmapUnchecked = Type: <b>HBITMAP</b> A handle to the bitmap displayed when the menu item is not selected.
///    hBitmapChecked = Type: <b>HBITMAP</b> A handle to the bitmap displayed when the menu item is selected.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetMenuItemBitmaps(HMENU hMenu, uint uPosition, uint uFlags, HBITMAP hBitmapUnchecked, HBITMAP hBitmapChecked);

///Retrieves the dimensions of the default check-mark bitmap. The system displays this bitmap next to selected menu
///items. Before calling the SetMenuItemBitmaps function to replace the default check-mark bitmap for a menu item, an
///application must determine the correct bitmap size by calling <b>GetMenuCheckMarkDimensions</b>. <div
///class="alert"><b>Note</b> The <b>GetMenuCheckMarkDimensions</b> function is included only for compatibility with
///16-bit versions of Windows. Applications should use the GetSystemMetrics function with the <b>CXMENUCHECK</b> and
///<b>CYMENUCHECK</b> values to retrieve the bitmap dimensions.</div><div> </div>
///Returns:
///    Type: <b>LONG</b> The return value specifies the height and width, in pixels, of the default check-mark bitmap.
///    The high-order word contains the height; the low-order word contains the width.
///    
@DllImport("USER32")
int GetMenuCheckMarkDimensions();

///Displays a shortcut menu at the specified location and tracks the selection of items on the menu. The shortcut menu
///can appear anywhere on the screen.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the shortcut menu to be displayed. The handle can be obtained by calling
///            CreatePopupMenu to create a new shortcut menu, or by calling GetSubMenu to retrieve a handle to a submenu
///            associated with an existing menu item.
///    uFlags = Type: <b>UINT</b> Use zero of more of these flags to specify function options. Use one of the following flags to
///             specify how the function positions the shortcut menu horizontally. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="TPM_CENTERALIGN"></a><a id="tpm_centeralign"></a><dl>
///             <dt><b>TPM_CENTERALIGN</b></dt> <dt>0x0004L</dt> </dl> </td> <td width="60%"> Centers the shortcut menu
///             horizontally relative to the coordinate specified by the <i>x</i> parameter. </td> </tr> <tr> <td width="40%"><a
///             id="TPM_LEFTALIGN"></a><a id="tpm_leftalign"></a><dl> <dt><b>TPM_LEFTALIGN</b></dt> <dt>0x0000L</dt> </dl> </td>
///             <td width="60%"> Positions the shortcut menu so that its left side is aligned with the coordinate specified by
///             the <i>x</i> parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_RIGHTALIGN"></a><a
///             id="tpm_rightalign"></a><dl> <dt><b>TPM_RIGHTALIGN</b></dt> <dt>0x0008L</dt> </dl> </td> <td width="60%">
///             Positions the shortcut menu so that its right side is aligned with the coordinate specified by the <i>x</i>
///             parameter. </td> </tr> </table> Use one of the following flags to specify how the function positions the shortcut
///             menu vertically. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="TPM_BOTTOMALIGN"></a><a id="tpm_bottomalign"></a><dl> <dt><b>TPM_BOTTOMALIGN</b></dt> <dt>0x0020L</dt> </dl>
///             </td> <td width="60%"> Positions the shortcut menu so that its bottom side is aligned with the coordinate
///             specified by the <i>y</i> parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_TOPALIGN"></a><a
///             id="tpm_topalign"></a><dl> <dt><b>TPM_TOPALIGN</b></dt> <dt>0x0000L</dt> </dl> </td> <td width="60%"> Positions
///             the shortcut menu so that its top side is aligned with the coordinate specified by the <i>y</i> parameter. </td>
///             </tr> <tr> <td width="40%"><a id="TPM_VCENTERALIGN"></a><a id="tpm_vcenteralign"></a><dl>
///             <dt><b>TPM_VCENTERALIGN</b></dt> <dt>0x0010L</dt> </dl> </td> <td width="60%"> Centers the shortcut menu
///             vertically relative to the coordinate specified by the <i>y</i> parameter. </td> </tr> </table> Use the following
///             flags to control discovery of the user selection without having to set up a parent window for the menu. <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_NONOTIFY"></a><a
///             id="tpm_nonotify"></a><dl> <dt><b>TPM_NONOTIFY</b></dt> <dt>0x0080L</dt> </dl> </td> <td width="60%"> The
///             function does not send notification messages when the user clicks a menu item. </td> </tr> <tr> <td
///             width="40%"><a id="TPM_RETURNCMD"></a><a id="tpm_returncmd"></a><dl> <dt><b>TPM_RETURNCMD</b></dt>
///             <dt>0x0100L</dt> </dl> </td> <td width="60%"> The function returns the menu item identifier of the user's
///             selection in the return value. </td> </tr> </table> Use one of the following flags to specify which mouse button
///             the shortcut menu tracks. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="TPM_LEFTBUTTON"></a><a id="tpm_leftbutton"></a><dl> <dt><b>TPM_LEFTBUTTON</b></dt> <dt>0x0000L</dt> </dl>
///             </td> <td width="60%"> The user can select menu items with only the left mouse button. </td> </tr> <tr> <td
///             width="40%"><a id="TPM_RIGHTBUTTON"></a><a id="tpm_rightbutton"></a><dl> <dt><b>TPM_RIGHTBUTTON</b></dt>
///             <dt>0x0002L</dt> </dl> </td> <td width="60%"> The user can select menu items with both the left and right mouse
///             buttons. </td> </tr> </table> Use any reasonable combination of the following flags to modify the animation of a
///             menu. For example, by selecting a horizontal and a vertical flag, you can achieve diagonal animation. <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_HORNEGANIMATION"></a><a
///             id="tpm_horneganimation"></a><dl> <dt><b>TPM_HORNEGANIMATION</b></dt> <dt>0x0800L</dt> </dl> </td> <td
///             width="60%"> Animates the menu from right to left. </td> </tr> <tr> <td width="40%"><a
///             id="TPM_HORPOSANIMATION"></a><a id="tpm_horposanimation"></a><dl> <dt><b>TPM_HORPOSANIMATION</b></dt>
///             <dt>0x0400L</dt> </dl> </td> <td width="60%"> Animates the menu from left to right. </td> </tr> <tr> <td
///             width="40%"><a id="TPM_NOANIMATION"></a><a id="tpm_noanimation"></a><dl> <dt><b>TPM_NOANIMATION</b></dt>
///             <dt>0x4000L</dt> </dl> </td> <td width="60%"> Displays menu without animation. </td> </tr> <tr> <td
///             width="40%"><a id="TPM_VERNEGANIMATION"></a><a id="tpm_verneganimation"></a><dl>
///             <dt><b>TPM_VERNEGANIMATION</b></dt> <dt>0x2000L</dt> </dl> </td> <td width="60%"> Animates the menu from bottom
///             to top. </td> </tr> <tr> <td width="40%"><a id="TPM_VERPOSANIMATION"></a><a id="tpm_verposanimation"></a><dl>
///             <dt><b>TPM_VERPOSANIMATION</b></dt> <dt>0x1000L</dt> </dl> </td> <td width="60%"> Animates the menu from top to
///             bottom. </td> </tr> </table> For any animation to occur, the SystemParametersInfo function must set
///             <b>SPI_SETMENUANIMATION</b>. Also, all the TPM_*ANIMATION flags, except <b>TPM_NOANIMATION</b>, are ignored if
///             menu fade animation is on. For more information, see the <b>SPI_GETMENUFADE</b> flag in
///             <b>SystemParametersInfo</b>. Use the <b>TPM_RECURSE</b> flag to display a menu when another menu is already
///             displayed. This is intended to support context menus within a menu. For right-to-left text layout, use
///             <b>TPM_LAYOUTRTL</b>. By default, the text layout is left-to-right.
///    x = Type: <b>int</b> The horizontal location of the shortcut menu, in screen coordinates.
///    y = Type: <b>int</b> The vertical location of the shortcut menu, in screen coordinates.
///    nReserved = Type: <b>int</b> Reserved; must be zero.
///    hWnd = Type: <b>HWND</b> A handle to the window that owns the shortcut menu. This window receives all messages from the
///           menu. The window does not receive a WM_COMMAND message from the menu until the function returns. If you specify
///           TPM_NONOTIFY in the <i>uFlags</i> parameter, the function does not send messages to the window identified by
///           <i>hWnd</i>. However, you must still pass a window handle in <i>hWnd</i>. It can be any window handle from your
///           application.
///    prcRect = Type: <b>const RECT*</b> Ignored.
///Returns:
///    Type: <b>BOOL</b> If you specify <b>TPM_RETURNCMD</b> in the <i>uFlags</i> parameter, the return value is the
///    menu-item identifier of the item that the user selected. If the user cancels the menu without making a selection,
///    or if an error occurs, the return value is zero. If you do not specify <b>TPM_RETURNCMD</b> in the <i>uFlags</i>
///    parameter, the return value is nonzero if the function succeeds and zero if it fails. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
BOOL TrackPopupMenu(HMENU hMenu, uint uFlags, int x, int y, int nReserved, HWND hWnd, const(RECT)* prcRect);

///Displays a shortcut menu at the specified location and tracks the selection of items on the shortcut menu. The
///shortcut menu can appear anywhere on the screen.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the shortcut menu to be displayed. This handle can be obtained by calling the
///            CreatePopupMenu function to create a new shortcut menu or by calling the GetSubMenu function to retrieve a handle
///            to a submenu associated with an existing menu item.
///    uFlags = Type: <b>UINT</b> Specifies function options. Use one of the following flags to specify how the function
///             positions the shortcut menu horizontally. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///             width="40%"><a id="TPM_CENTERALIGN"></a><a id="tpm_centeralign"></a><dl> <dt><b>TPM_CENTERALIGN</b></dt>
///             <dt>0x0004L</dt> </dl> </td> <td width="60%"> Centers the shortcut menu horizontally relative to the coordinate
///             specified by the <i>x</i> parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_LEFTALIGN"></a><a
///             id="tpm_leftalign"></a><dl> <dt><b>TPM_LEFTALIGN</b></dt> <dt>0x0000L</dt> </dl> </td> <td width="60%"> Positions
///             the shortcut menu so that its left side is aligned with the coordinate specified by the <i>x</i> parameter. </td>
///             </tr> <tr> <td width="40%"><a id="TPM_RIGHTALIGN"></a><a id="tpm_rightalign"></a><dl>
///             <dt><b>TPM_RIGHTALIGN</b></dt> <dt>0x0008L</dt> </dl> </td> <td width="60%"> Positions the shortcut menu so that
///             its right side is aligned with the coordinate specified by the <i>x</i> parameter. </td> </tr> </table> Use one
///             of the following flags to specify how the function positions the shortcut menu vertically. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_BOTTOMALIGN"></a><a
///             id="tpm_bottomalign"></a><dl> <dt><b>TPM_BOTTOMALIGN</b></dt> <dt>0x0020L</dt> </dl> </td> <td width="60%">
///             Positions the shortcut menu so that its bottom side is aligned with the coordinate specified by the <i>y</i>
///             parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_TOPALIGN"></a><a id="tpm_topalign"></a><dl>
///             <dt><b>TPM_TOPALIGN</b></dt> <dt>0x0000L</dt> </dl> </td> <td width="60%"> Positions the shortcut menu so that
///             its top side is aligned with the coordinate specified by the <i>y</i> parameter. </td> </tr> <tr> <td
///             width="40%"><a id="TPM_VCENTERALIGN"></a><a id="tpm_vcenteralign"></a><dl> <dt><b>TPM_VCENTERALIGN</b></dt>
///             <dt>0x0010L</dt> </dl> </td> <td width="60%"> Centers the shortcut menu vertically relative to the coordinate
///             specified by the <i>y</i> parameter. </td> </tr> </table> Use the following flags to control discovery of the
///             user selection without having to set up a parent window for the menu. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_NONOTIFY"></a><a id="tpm_nonotify"></a><dl>
///             <dt><b>TPM_NONOTIFY</b></dt> <dt>0x0080L</dt> </dl> </td> <td width="60%"> The function does not send
///             notification messages when the user clicks a menu item. </td> </tr> <tr> <td width="40%"><a
///             id="TPM_RETURNCMD"></a><a id="tpm_returncmd"></a><dl> <dt><b>TPM_RETURNCMD</b></dt> <dt>0x0100L</dt> </dl> </td>
///             <td width="60%"> The function returns the menu item identifier of the user's selection in the return value. </td>
///             </tr> </table> Use one of the following flags to specify which mouse button the shortcut menu tracks. <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_LEFTBUTTON"></a><a
///             id="tpm_leftbutton"></a><dl> <dt><b>TPM_LEFTBUTTON</b></dt> <dt>0x0000L</dt> </dl> </td> <td width="60%"> The
///             user can select menu items with only the left mouse button. </td> </tr> <tr> <td width="40%"><a
///             id="TPM_RIGHTBUTTON"></a><a id="tpm_rightbutton"></a><dl> <dt><b>TPM_RIGHTBUTTON</b></dt> <dt>0x0002L</dt> </dl>
///             </td> <td width="60%"> The user can select menu items with both the left and right mouse buttons. </td> </tr>
///             </table> Use any reasonable combination of the following flags to modify the animation of a menu. For example, by
///             selecting a horizontal and a vertical flag, you can achieve diagonal animation. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_HORNEGANIMATION"></a><a id="tpm_horneganimation"></a><dl>
///             <dt><b>TPM_HORNEGANIMATION</b></dt> <dt>0x0800L</dt> </dl> </td> <td width="60%"> Animates the menu from right to
///             left. </td> </tr> <tr> <td width="40%"><a id="TPM_HORPOSANIMATION"></a><a id="tpm_horposanimation"></a><dl>
///             <dt><b>TPM_HORPOSANIMATION</b></dt> <dt>0x0400L</dt> </dl> </td> <td width="60%"> Animates the menu from left to
///             right. </td> </tr> <tr> <td width="40%"><a id="TPM_NOANIMATION"></a><a id="tpm_noanimation"></a><dl>
///             <dt><b>TPM_NOANIMATION</b></dt> <dt>0x4000L</dt> </dl> </td> <td width="60%"> Displays menu without animation.
///             </td> </tr> <tr> <td width="40%"><a id="TPM_VERNEGANIMATION"></a><a id="tpm_verneganimation"></a><dl>
///             <dt><b>TPM_VERNEGANIMATION</b></dt> <dt>0x2000L</dt> </dl> </td> <td width="60%"> Animates the menu from bottom
///             to top. </td> </tr> <tr> <td width="40%"><a id="TPM_VERPOSANIMATION"></a><a id="tpm_verposanimation"></a><dl>
///             <dt><b>TPM_VERPOSANIMATION</b></dt> <dt>0x1000L</dt> </dl> </td> <td width="60%"> Animates the menu from top to
///             bottom. </td> </tr> </table> For any animation to occur, the SystemParametersInfo function must set
///             <b>SPI_SETMENUANIMATION</b>. Also, all the <b>TPM_*ANIMATION</b> flags, except <b>TPM_NOANIMATION</b>, are
///             ignored if menu fade animation is on. For more information, see the <b>SPI_GETMENUFADE</b> flag in
///             <b>SystemParametersInfo</b>. Use the <b>TPM_RECURSE</b> flag to display a menu when another menu is already
///             displayed. This is intended to support context menus within a menu. Use one of the following flags to specify
///             whether to accommodate horizontal or vertical alignment. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///             <td width="40%"><a id="TPM_HORIZONTAL"></a><a id="tpm_horizontal"></a><dl> <dt><b>TPM_HORIZONTAL</b></dt>
///             <dt>0x0000L</dt> </dl> </td> <td width="60%"> If the menu cannot be shown at the specified location without
///             overlapping the excluded rectangle, the system tries to accommodate the requested horizontal alignment before the
///             requested vertical alignment. </td> </tr> <tr> <td width="40%"><a id="TPM_VERTICAL"></a><a
///             id="tpm_vertical"></a><dl> <dt><b>TPM_VERTICAL</b></dt> <dt>0x0040L</dt> </dl> </td> <td width="60%"> If the menu
///             cannot be shown at the specified location without overlapping the excluded rectangle, the system tries to
///             accommodate the requested vertical alignment before the requested horizontal alignment. </td> </tr> </table> The
///             excluded rectangle is a portion of the screen that the menu should not overlap; it is specified by the
///             <i>lptpm</i> parameter. For right-to-left text layout, use <b>TPM_LAYOUTRTL</b>. By default, the text layout is
///             left-to-right.
///    x = Type: <b>int</b> The horizontal location of the shortcut menu, in screen coordinates.
///    y = Type: <b>int</b> The vertical location of the shortcut menu, in screen coordinates.
///    hwnd = Type: <b>HWND</b> A handle to the window that owns the shortcut menu. This window receives all messages from the
///           menu. The window does not receive a WM_COMMAND message from the menu until the function returns. If you specify
///           TPM_NONOTIFY in the <i>fuFlags</i> parameter, the function does not send messages to the window identified by
///           <i>hwnd</i>. However, you must still pass a window handle in <i>hwnd</i>. It can be any window handle from your
///           application.
///    lptpm = Type: <b>LPTPMPARAMS</b> A pointer to a TPMPARAMS structure that specifies an area of the screen the menu should
///            not overlap. This parameter can be <b>NULL</b>.
///Returns:
///    Type: <b>BOOL</b> If you specify <b>TPM_RETURNCMD</b> in the <i>fuFlags</i> parameter, the return value is the
///    menu-item identifier of the item that the user selected. If the user cancels the menu without making a selection,
///    or if an error occurs, the return value is zero. If you do not specify <b>TPM_RETURNCMD</b> in the <i>fuFlags</i>
///    parameter, the return value is nonzero if the function succeeds and zero if it fails. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
BOOL TrackPopupMenuEx(HMENU hMenu, uint uFlags, int x, int y, HWND hwnd, TPMPARAMS* lptpm);

///Retrieves information about a specified menu.
///Params:
///    arg1 = Type: <b>HMENU</b> A handle on a menu.
///    arg2 = Type: <b>LPMENUINFO</b> A pointer to a MENUINFO structure containing information for the menu. Note that you must
///           set the <b>cbSize</b> member to <code>sizeof(MENUINFO)</code> before calling this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetMenuInfo(HMENU param0, MENUINFO* param1);

///Sets information for a specified menu.
///Params:
///    arg1 = Type: <b>HMENU</b> A handle to a menu.
///    arg2 = Type: <b>LPCMENUINFO</b> A pointer to a MENUINFO structure for the menu.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetMenuInfo(HMENU param0, MENUINFO* param1);

///Ends the calling thread's active menu.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL EndMenu();

///Inserts a new menu item at the specified position in a menu.
///Params:
///    hmenu = Type: <b>HMENU</b> A handle to the menu in which the new menu item is inserted.
///    item = Type: <b>UINT</b> The identifier or position of the menu item before which to insert the new item. The meaning of
///           this parameter depends on the value of <i>fByPosition</i>.
///    fByPosition = Type: <b>BOOL</b> Controls the meaning of <i>item</i>. If this parameter is <b>FALSE</b>, <i>item</i> is a menu
///                  item identifier. Otherwise, it is a menu item position. See Accessing Menu Items Programmatically for more
///                  information.
///    lpmi = Type: <b>LPCMENUITEMINFO</b> A pointer to a MENUITEMINFO structure that contains information about the new menu
///           item.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL InsertMenuItemA(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOA* lpmi);

///Inserts a new menu item at the specified position in a menu.
///Params:
///    hmenu = Type: <b>HMENU</b> A handle to the menu in which the new menu item is inserted.
///    item = Type: <b>UINT</b> The identifier or position of the menu item before which to insert the new item. The meaning of
///           this parameter depends on the value of <i>fByPosition</i>.
///    fByPosition = Type: <b>BOOL</b> Controls the meaning of <i>item</i>. If this parameter is <b>FALSE</b>, <i>item</i> is a menu
///                  item identifier. Otherwise, it is a menu item position. See Accessing Menu Items Programmatically for more
///                  information.
///    lpmi = Type: <b>LPCMENUITEMINFO</b> A pointer to a MENUITEMINFO structure that contains information about the new menu
///           item.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL InsertMenuItemW(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOW* lpmi);

///Retrieves information about a menu item.
///Params:
///    hmenu = Type: <b>HMENU</b> A handle to the menu that contains the menu item.
///    item = Type: <b>UINT</b> The identifier or position of the menu item to get information about. The meaning of this
///           parameter depends on the value of <i>fByPosition</i>.
///    fByPosition = Type: <b>BOOL</b> The meaning of <i>uItem</i>. If this parameter is <b>FALSE</b>, <i>uItem</i> is a menu item
///                  identifier. Otherwise, it is a menu item position. See Accessing Menu Items Programmatically for more
///                  information.
///    lpmii = Type: <b>LPMENUITEMINFO</b> A pointer to a MENUITEMINFO structure that specifies the information to retrieve and
///            receives information about the menu item. Note that you must set the <b>cbSize</b> member to
///            <code>sizeof(MENUITEMINFO)</code> before calling this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL GetMenuItemInfoA(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOA* lpmii);

///Retrieves information about a menu item.
///Params:
///    hmenu = Type: <b>HMENU</b> A handle to the menu that contains the menu item.
///    item = Type: <b>UINT</b> The identifier or position of the menu item to get information about. The meaning of this
///           parameter depends on the value of <i>fByPosition</i>.
///    fByPosition = Type: <b>BOOL</b> The meaning of <i>uItem</i>. If this parameter is <b>FALSE</b>, <i>uItem</i> is a menu item
///                  identifier. Otherwise, it is a menu item position. See Accessing Menu Items Programmatically for more
///                  information.
///    lpmii = Type: <b>LPMENUITEMINFO</b> A pointer to a MENUITEMINFO structure that specifies the information to retrieve and
///            receives information about the menu item. Note that you must set the <b>cbSize</b> member to
///            <code>sizeof(MENUITEMINFO)</code> before calling this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL GetMenuItemInfoW(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOW* lpmii);

///Changes information about a menu item.
///Params:
///    hmenu = Type: <b>HMENU</b> A handle to the menu that contains the menu item.
///    item = Type: <b>UINT</b> The identifier or position of the menu item to change. The meaning of this parameter depends on
///           the value of <i>fByPosition</i>.
///    fByPositon = Type: <b>BOOL</b> The meaning of <i>uItem</i>. If this parameter is <b>FALSE</b>, <i>uItem</i> is a menu item
///                 identifier. Otherwise, it is a menu item position. See About Menus for more information.
///    lpmii = Type: <b>LPMENUITEMINFO</b> A pointer to a MENUITEMINFO structure that contains information about the menu item
///            and specifies which menu item attributes to change.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL SetMenuItemInfoA(HMENU hmenu, uint item, BOOL fByPositon, MENUITEMINFOA* lpmii);

///Changes information about a menu item.
///Params:
///    hmenu = Type: <b>HMENU</b> A handle to the menu that contains the menu item.
///    item = Type: <b>UINT</b> The identifier or position of the menu item to change. The meaning of this parameter depends on
///           the value of <i>fByPosition</i>.
///    fByPositon = Type: <b>BOOL</b> The meaning of <i>uItem</i>. If this parameter is <b>FALSE</b>, <i>uItem</i> is a menu item
///                 identifier. Otherwise, it is a menu item position. See About Menus for more information.
///    lpmii = Type: <b>LPMENUITEMINFO</b> A pointer to a MENUITEMINFO structure that contains information about the menu item
///            and specifies which menu item attributes to change.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL SetMenuItemInfoW(HMENU hmenu, uint item, BOOL fByPositon, MENUITEMINFOW* lpmii);

///Determines the default menu item on the specified menu.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu for which to retrieve the default menu item.
///    fByPos = Type: <b>UINT</b> Indicates whether to retrieve the menu item's identifier or its position. If this parameter is
///             <b>FALSE</b>, the identifier is returned. Otherwise, the position is returned.
///    gmdiFlags = Type: <b>UINT</b> Indicates how the function should search for menu items. This parameter can be zero or more of
///                the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="GMDI_GOINTOPOPUPS"></a><a id="gmdi_gointopopups"></a><dl> <dt><b>GMDI_GOINTOPOPUPS</b></dt> <dt>0x0002L</dt>
///                </dl> </td> <td width="60%"> If the default item is one that opens a submenu, the function is to search
///                recursively in the corresponding submenu. If the submenu has no default item, the return value identifies the
///                item that opens the submenu. By default, the function returns the first default item on the specified menu,
///                regardless of whether it is an item that opens a submenu. </td> </tr> <tr> <td width="40%"><a
///                id="GMDI_USEDISABLED"></a><a id="gmdi_usedisabled"></a><dl> <dt><b>GMDI_USEDISABLED</b></dt> <dt>0x0001L</dt>
///                </dl> </td> <td width="60%"> The function is to return a default item, even if it is disabled. By default, the
///                function skips disabled or grayed items. </td> </tr> </table>
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the identifier or position of the menu item. If
///    the function fails, the return value is -1. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint GetMenuDefaultItem(HMENU hMenu, uint fByPos, uint gmdiFlags);

///Sets the default menu item for the specified menu.
///Params:
///    hMenu = Type: <b>HMENU</b> A handle to the menu to set the default item for.
///    uItem = Type: <b>UINT</b> The identifier or position of the new default menu item or -1 for no default item. The meaning
///            of this parameter depends on the value of <i>fByPos</i>.
///    fByPos = Type: <b>UINT</b> The meaning of <i>uItem</i>. If this parameter is <b>FALSE</b>, <i>uItem</i> is a menu item
///             identifier. Otherwise, it is a menu item position. See About Menus for more information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL SetMenuDefaultItem(HMENU hMenu, uint uItem, uint fByPos);

///Retrieves the bounding rectangle for the specified menu item.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window containing the menu. If this value is <b>NULL</b> and the <i>hMenu</i>
///           parameter represents a popup menu, the function will find the menu window.
///    hMenu = Type: <b>HMENU</b> A handle to a menu.
///    uItem = Type: <b>UINT</b> The zero-based position of the menu item.
///    lprcItem = Type: <b>LPRECT</b> A pointer to a RECT structure that receives the bounding rectangle of the specified menu item
///               expressed in screen coordinates.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL GetMenuItemRect(HWND hWnd, HMENU hMenu, uint uItem, RECT* lprcItem);

///Determines which menu item, if any, is at the specified location.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window containing the menu. If this value is <b>NULL</b> and the <i>hMenu</i>
///           parameter represents a popup menu, the function will find the menu window.
///    hMenu = Type: <b>HMENU</b> A handle to the menu containing the menu items to hit test.
///    ptScreen = Type: <b>POINT</b> A structure that specifies the location to test. If <i>hMenu</i> specifies a menu bar, this
///               parameter is in window coordinates. Otherwise, it is in client coordinates.
///Returns:
///    Type: <b>int</b> Returns the zero-based position of the menu item at the specified location or -1 if no menu item
///    is at the specified location.
///    
@DllImport("USER32")
int MenuItemFromPoint(HWND hWnd, HMENU hMenu, POINT ptScreen);

@DllImport("USER32")
uint DragObject(HWND hwndParent, HWND hwndFrom, uint fmt, size_t data, HCURSOR hcur);

///Draws an icon or cursor into the specified device context. To specify additional drawing options, use the DrawIconEx
///function.
///Params:
///    hDC = Type: <b>HDC</b> A handle to the device context into which the icon or cursor will be drawn.
///    X = Type: <b>int</b> The logical x-coordinate of the upper-left corner of the icon.
///    Y = Type: <b>int</b> The logical y-coordinate of the upper-left corner of the icon.
///    hIcon = Type: <b>HICON</b> A handle to the icon to be drawn.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DrawIcon(HDC hDC, int X, int Y, HICON hIcon);

///Displays or hides the cursor.
///Params:
///    bShow = Type: <b>BOOL</b> If <i>bShow</i> is <b>TRUE</b>, the display count is incremented by one. If <i>bShow</i> is
///            <b>FALSE</b>, the display count is decremented by one.
///Returns:
///    Type: <b>int</b> The return value specifies the new display counter.
///    
@DllImport("USER32")
int ShowCursor(BOOL bShow);

///Moves the cursor to the specified screen coordinates. If the new coordinates are not within the screen rectangle set
///by the most recent ClipCursor function call, the system automatically adjusts the coordinates so that the cursor
///stays within the rectangle.
///Params:
///    X = Type: <b>int</b> The new x-coordinate of the cursor, in screen coordinates.
///    Y = Type: <b>int</b> The new y-coordinate of the cursor, in screen coordinates.
///Returns:
///    Type: <b>BOOL</b> Returns nonzero if successful or zero otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
BOOL SetCursorPos(int X, int Y);

///Sets the position of the cursor in physical coordinates.
///Params:
///    X = Type: <b>int</b> The new x-coordinate of the cursor, in physical coordinates.
///    Y = Type: <b>int</b> The new y-coordinate of the cursor, in physical coordinates.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> if successful; otherwise <b>FALSE</b>.
///    
@DllImport("USER32")
BOOL SetPhysicalCursorPos(int X, int Y);

///Sets the cursor shape.
///Params:
///    hCursor = Type: <b>HCURSOR</b> A handle to the cursor. The cursor must have been created by the CreateCursor function or
///              loaded by the LoadCursor or LoadImage function. If this parameter is <b>NULL</b>, the cursor is removed from the
///              screen.
///Returns:
///    Type: <b>HCURSOR</b> The return value is the handle to the previous cursor, if there was one. If there was no
///    previous cursor, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HCURSOR SetCursor(HCURSOR hCursor);

///Retrieves the position of the mouse cursor, in screen coordinates.
///Params:
///    lpPoint = Type: <b>LPPOINT</b> A pointer to a POINT structure that receives the screen coordinates of the cursor.
///Returns:
///    Type: <b>BOOL</b> Returns nonzero if successful or zero otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
BOOL GetCursorPos(POINT* lpPoint);

///Retrieves the position of the cursor in physical coordinates.
///Params:
///    lpPoint = Type: <b>LPPOINT</b> The position of the cursor, in physical coordinates.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> if successful; otherwise <b>FALSE</b>. GetLastError can be called to get more
///    information about any error that is generated.
///    
@DllImport("USER32")
BOOL GetPhysicalCursorPos(POINT* lpPoint);

///Retrieves the screen coordinates of the rectangular area to which the cursor is confined.
///Params:
///    lpRect = Type: <b>LPRECT</b> A pointer to a RECT structure that receives the screen coordinates of the confining
///             rectangle. The structure receives the dimensions of the screen if the cursor is not confined to a rectangle.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetClipCursor(RECT* lpRect);

///Retrieves a handle to the current cursor. To get information on the global cursor, even if it is not owned by the
///current thread, use GetCursorInfo.
///Returns:
///    Type: <b>HCURSOR</b> The return value is the handle to the current cursor. If there is no cursor, the return
///    value is <b>NULL</b>.
///    
@DllImport("USER32")
HCURSOR GetCursor();

///Creates a new shape for the system caret and assigns ownership of the caret to the specified window. The caret shape
///can be a line, a block, or a bitmap.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that owns the caret.
///    hBitmap = Type: <b>HBITMAP</b> A handle to the bitmap that defines the caret shape. If this parameter is <b>NULL</b>, the
///              caret is solid. If this parameter is <code>(HBITMAP) 1</code>, the caret is gray. If this parameter is a bitmap
///              handle, the caret is the specified bitmap. The bitmap handle must have been created by the CreateBitmap,
///              CreateDIBitmap, or LoadBitmap function. If <i>hBitmap</i> is a bitmap handle, <b>CreateCaret</b> ignores the
///              <i>nWidth</i> and <i>nHeight</i> parameters; the bitmap defines its own width and height.
///    nWidth = Type: <b>int</b> The width of the caret, in logical units. If this parameter is zero, the width is set to the
///             system-defined window border width. If <i>hBitmap</i> is a bitmap handle, <b>CreateCaret</b> ignores this
///             parameter.
///    nHeight = Type: <b>int</b> The height of the caret, in logical units. If this parameter is zero, the height is set to the
///              system-defined window border height. If <i>hBitmap</i> is a bitmap handle, <b>CreateCaret</b> ignores this
///              parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL CreateCaret(HWND hWnd, HBITMAP hBitmap, int nWidth, int nHeight);

///Retrieves the time required to invert the caret's pixels. The user can set this value.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the blink time, in milliseconds. A return value
///    of <b>INFINITE</b> indicates that the caret does not blink. A return value is zero indicates that the function
///    has failed. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint GetCaretBlinkTime();

///Sets the caret blink time to the specified number of milliseconds. The blink time is the elapsed time, in
///milliseconds, required to invert the caret's pixels.
///Params:
///    uMSeconds = Type: <b>UINT</b> The new blink time, in milliseconds.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetCaretBlinkTime(uint uMSeconds);

///Destroys the caret's current shape, frees the caret from the window, and removes the caret from the screen.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DestroyCaret();

///Removes the caret from the screen. Hiding a caret does not destroy its current shape or invalidate the insertion
///point.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that owns the caret. If this parameter is <b>NULL</b>, <b>HideCaret</b>
///           searches the current task for the window that owns the caret.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL HideCaret(HWND hWnd);

///Makes the caret visible on the screen at the caret's current position. When the caret becomes visible, it begins
///flashing automatically.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that owns the caret. If this parameter is <b>NULL</b>, <b>ShowCaret</b>
///           searches the current task for the window that owns the caret.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ShowCaret(HWND hWnd);

///Moves the caret to the specified coordinates. If the window that owns the caret was created with the <b>CS_OWNDC</b>
///class style, then the specified coordinates are subject to the mapping mode of the device context associated with
///that window.
///Params:
///    X = Type: <b>int</b> The new x-coordinate of the caret.
///    Y = Type: <b>int</b> The new y-coordinate of the caret.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetCaretPos(int X, int Y);

///Copies the caret's position to the specified POINT structure.
///Params:
///    lpPoint = Type: <b>LPPOINT</b> A pointer to the POINT structure that is to receive the client coordinates of the caret.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetCaretPos(POINT* lpPoint);

///Confines the cursor to a rectangular area on the screen. If a subsequent cursor position (set by the SetCursorPos
///function or the mouse) lies outside the rectangle, the system automatically adjusts the position to keep the cursor
///inside the rectangular area.
///Params:
///    lpRect = Type: <b>const RECT*</b> A pointer to the structure that contains the screen coordinates of the upper-left and
///             lower-right corners of the confining rectangle. If this parameter is <b>NULL</b>, the cursor is free to move
///             anywhere on the screen.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ClipCursor(const(RECT)* lpRect);

@DllImport("USER32")
ushort GetWindowWord(HWND hWnd, int nIndex);

@DllImport("USER32")
ushort SetWindowWord(HWND hWnd, int nIndex, ushort wNewWord);

@DllImport("USER32")
HHOOK SetWindowsHookA(int nFilterType, HOOKPROC pfnFilterProc);

@DllImport("USER32")
HHOOK SetWindowsHookW(int nFilterType, HOOKPROC pfnFilterProc);

@DllImport("USER32")
BOOL UnhookWindowsHook(int nCode, HOOKPROC pfnFilterProc);

///Checks a specified menu item and makes it a radio item. At the same time, the function clears all other menu items in
///the associated group and clears the radio-item type flag for those items.
///Params:
///    hmenu = Type: <b>HMENU</b> A handle to the menu that contains the group of menu items.
///    first = Type: <b>UINT</b> The identifier or position of the first menu item in the group.
///    last = Type: <b>UINT</b> The identifier or position of the last menu item in the group.
///    check = Type: <b>UINT</b> The identifier or position of the menu item to check.
///    flags = Type: <b>UINT</b> Indicates the meaning of <i>idFirst</i>, <i>idLast</i>, and <i>idCheck</i>. If this parameter
///            is <b>MF_BYCOMMAND</b>, the other parameters specify menu item identifiers. If it is <b>MF_BYPOSITION</b>, the
///            other parameters specify the menu item positions.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL CheckMenuRadioItem(HMENU hmenu, uint first, uint last, uint check, uint flags);

///Loads the specified cursor resource from the executable (.EXE) file associated with an application instance. <div
///class="alert"><b>Note</b> This function has been superseded by the LoadImage function.</div><div> </div>
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to an instance of the module whose executable file contains the cursor to be
///                loaded.
///    lpCursorName = Type: <b>LPCTSTR</b> The name of the cursor resource to be loaded. Alternatively, this parameter can consist of
///                   the resource identifier in the low-order word and zero in the high-order word. The MAKEINTRESOURCE macro can also
///                   be used to create this value. To use one of the predefined cursors, the application must set the <i>hInstance</i>
///                   parameter to <b>NULL</b> and the <i>lpCursorName</i> parameter to one the following values. <table> <tr>
///                   <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IDC_APPSTARTING"></a><a
///                   id="idc_appstarting"></a><dl> <dt><b>IDC_APPSTARTING</b></dt> <dt>MAKEINTRESOURCE(32650)</dt> </dl> </td> <td
///                   width="60%"> Standard arrow and small hourglass </td> </tr> <tr> <td width="40%"><a id="IDC_ARROW"></a><a
///                   id="idc_arrow"></a><dl> <dt><b>IDC_ARROW</b></dt> <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%">
///                   Standard arrow </td> </tr> <tr> <td width="40%"><a id="IDC_CROSS"></a><a id="idc_cross"></a><dl>
///                   <dt><b>IDC_CROSS</b></dt> <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Crosshair </td> </tr> <tr>
///                   <td width="40%"><a id="IDC_HAND"></a><a id="idc_hand"></a><dl> <dt><b>IDC_HAND</b></dt>
///                   <dt>MAKEINTRESOURCE(32649)</dt> </dl> </td> <td width="60%"> Hand </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_HELP"></a><a id="idc_help"></a><dl> <dt><b>IDC_HELP</b></dt> <dt>MAKEINTRESOURCE(32651)</dt> </dl> </td>
///                   <td width="60%"> Arrow and question mark </td> </tr> <tr> <td width="40%"><a id="IDC_IBEAM"></a><a
///                   id="idc_ibeam"></a><dl> <dt><b>IDC_IBEAM</b></dt> <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%">
///                   I-beam </td> </tr> <tr> <td width="40%"><a id="IDC_ICON"></a><a id="idc_icon"></a><dl> <dt><b>IDC_ICON</b></dt>
///                   <dt>MAKEINTRESOURCE(32641)</dt> </dl> </td> <td width="60%"> Obsolete for applications marked version 4.0 or
///                   later. </td> </tr> <tr> <td width="40%"><a id="IDC_NO"></a><a id="idc_no"></a><dl> <dt><b>IDC_NO</b></dt>
///                   <dt>MAKEINTRESOURCE(32648)</dt> </dl> </td> <td width="60%"> Slashed circle </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_SIZE"></a><a id="idc_size"></a><dl> <dt><b>IDC_SIZE</b></dt> <dt>MAKEINTRESOURCE(32640)</dt> </dl> </td>
///                   <td width="60%"> Obsolete for applications marked version 4.0 or later. Use <b>IDC_SIZEALL</b>. </td> </tr> <tr>
///                   <td width="40%"><a id="IDC_SIZEALL"></a><a id="idc_sizeall"></a><dl> <dt><b>IDC_SIZEALL</b></dt>
///                   <dt>MAKEINTRESOURCE(32646)</dt> </dl> </td> <td width="60%"> Four-pointed arrow pointing north, south, east, and
///                   west </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENESW"></a><a id="idc_sizenesw"></a><dl>
///                   <dt><b>IDC_SIZENESW</b></dt> <dt>MAKEINTRESOURCE(32643)</dt> </dl> </td> <td width="60%"> Double-pointed arrow
///                   pointing northeast and southwest </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENS"></a><a
///                   id="idc_sizens"></a><dl> <dt><b>IDC_SIZENS</b></dt> <dt>MAKEINTRESOURCE(32645)</dt> </dl> </td> <td width="60%">
///                   Double-pointed arrow pointing north and south </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENWSE"></a><a
///                   id="idc_sizenwse"></a><dl> <dt><b>IDC_SIZENWSE</b></dt> <dt>MAKEINTRESOURCE(32642)</dt> </dl> </td> <td
///                   width="60%"> Double-pointed arrow pointing northwest and southeast </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_SIZEWE"></a><a id="idc_sizewe"></a><dl> <dt><b>IDC_SIZEWE</b></dt> <dt>MAKEINTRESOURCE(32644)</dt> </dl>
///                   </td> <td width="60%"> Double-pointed arrow pointing west and east </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_UPARROW"></a><a id="idc_uparrow"></a><dl> <dt><b>IDC_UPARROW</b></dt> <dt>MAKEINTRESOURCE(32516)</dt>
///                   </dl> </td> <td width="60%"> Vertical arrow </td> </tr> <tr> <td width="40%"><a id="IDC_WAIT"></a><a
///                   id="idc_wait"></a><dl> <dt><b>IDC_WAIT</b></dt> <dt>MAKEINTRESOURCE(32514)</dt> </dl> </td> <td width="60%">
///                   Hourglass </td> </tr> </table>
///Returns:
///    Type: <b>HCURSOR</b> If the function succeeds, the return value is the handle to the newly loaded cursor. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HCURSOR LoadCursorA(HINSTANCE hInstance, const(PSTR) lpCursorName);

///Loads the specified cursor resource from the executable (.EXE) file associated with an application instance. <div
///class="alert"><b>Note</b> This function has been superseded by the LoadImage function.</div><div> </div>
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to an instance of the module whose executable file contains the cursor to be
///                loaded.
///    lpCursorName = Type: <b>LPCTSTR</b> The name of the cursor resource to be loaded. Alternatively, this parameter can consist of
///                   the resource identifier in the low-order word and zero in the high-order word. The MAKEINTRESOURCE macro can also
///                   be used to create this value. To use one of the predefined cursors, the application must set the <i>hInstance</i>
///                   parameter to <b>NULL</b> and the <i>lpCursorName</i> parameter to one the following values. <table> <tr>
///                   <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IDC_APPSTARTING"></a><a
///                   id="idc_appstarting"></a><dl> <dt><b>IDC_APPSTARTING</b></dt> <dt>MAKEINTRESOURCE(32650)</dt> </dl> </td> <td
///                   width="60%"> Standard arrow and small hourglass </td> </tr> <tr> <td width="40%"><a id="IDC_ARROW"></a><a
///                   id="idc_arrow"></a><dl> <dt><b>IDC_ARROW</b></dt> <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%">
///                   Standard arrow </td> </tr> <tr> <td width="40%"><a id="IDC_CROSS"></a><a id="idc_cross"></a><dl>
///                   <dt><b>IDC_CROSS</b></dt> <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Crosshair </td> </tr> <tr>
///                   <td width="40%"><a id="IDC_HAND"></a><a id="idc_hand"></a><dl> <dt><b>IDC_HAND</b></dt>
///                   <dt>MAKEINTRESOURCE(32649)</dt> </dl> </td> <td width="60%"> Hand </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_HELP"></a><a id="idc_help"></a><dl> <dt><b>IDC_HELP</b></dt> <dt>MAKEINTRESOURCE(32651)</dt> </dl> </td>
///                   <td width="60%"> Arrow and question mark </td> </tr> <tr> <td width="40%"><a id="IDC_IBEAM"></a><a
///                   id="idc_ibeam"></a><dl> <dt><b>IDC_IBEAM</b></dt> <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%">
///                   I-beam </td> </tr> <tr> <td width="40%"><a id="IDC_ICON"></a><a id="idc_icon"></a><dl> <dt><b>IDC_ICON</b></dt>
///                   <dt>MAKEINTRESOURCE(32641)</dt> </dl> </td> <td width="60%"> Obsolete for applications marked version 4.0 or
///                   later. </td> </tr> <tr> <td width="40%"><a id="IDC_NO"></a><a id="idc_no"></a><dl> <dt><b>IDC_NO</b></dt>
///                   <dt>MAKEINTRESOURCE(32648)</dt> </dl> </td> <td width="60%"> Slashed circle </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_SIZE"></a><a id="idc_size"></a><dl> <dt><b>IDC_SIZE</b></dt> <dt>MAKEINTRESOURCE(32640)</dt> </dl> </td>
///                   <td width="60%"> Obsolete for applications marked version 4.0 or later. Use <b>IDC_SIZEALL</b>. </td> </tr> <tr>
///                   <td width="40%"><a id="IDC_SIZEALL"></a><a id="idc_sizeall"></a><dl> <dt><b>IDC_SIZEALL</b></dt>
///                   <dt>MAKEINTRESOURCE(32646)</dt> </dl> </td> <td width="60%"> Four-pointed arrow pointing north, south, east, and
///                   west </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENESW"></a><a id="idc_sizenesw"></a><dl>
///                   <dt><b>IDC_SIZENESW</b></dt> <dt>MAKEINTRESOURCE(32643)</dt> </dl> </td> <td width="60%"> Double-pointed arrow
///                   pointing northeast and southwest </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENS"></a><a
///                   id="idc_sizens"></a><dl> <dt><b>IDC_SIZENS</b></dt> <dt>MAKEINTRESOURCE(32645)</dt> </dl> </td> <td width="60%">
///                   Double-pointed arrow pointing north and south </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENWSE"></a><a
///                   id="idc_sizenwse"></a><dl> <dt><b>IDC_SIZENWSE</b></dt> <dt>MAKEINTRESOURCE(32642)</dt> </dl> </td> <td
///                   width="60%"> Double-pointed arrow pointing northwest and southeast </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_SIZEWE"></a><a id="idc_sizewe"></a><dl> <dt><b>IDC_SIZEWE</b></dt> <dt>MAKEINTRESOURCE(32644)</dt> </dl>
///                   </td> <td width="60%"> Double-pointed arrow pointing west and east </td> </tr> <tr> <td width="40%"><a
///                   id="IDC_UPARROW"></a><a id="idc_uparrow"></a><dl> <dt><b>IDC_UPARROW</b></dt> <dt>MAKEINTRESOURCE(32516)</dt>
///                   </dl> </td> <td width="60%"> Vertical arrow </td> </tr> <tr> <td width="40%"><a id="IDC_WAIT"></a><a
///                   id="idc_wait"></a><dl> <dt><b>IDC_WAIT</b></dt> <dt>MAKEINTRESOURCE(32514)</dt> </dl> </td> <td width="60%">
///                   Hourglass </td> </tr> </table>
///Returns:
///    Type: <b>HCURSOR</b> If the function succeeds, the return value is the handle to the newly loaded cursor. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HCURSOR LoadCursorW(HINSTANCE hInstance, const(PWSTR) lpCursorName);

///Creates a cursor based on data contained in a file.
///Params:
///    lpFileName = Type: <b>LPCTSTR</b> The source of the file data to be used to create the cursor. The data in the file must be in
///                 either .CUR or .ANI format. If the high-order word of <i>lpFileName</i> is nonzero, it is a pointer to a string
///                 that is a fully qualified name of a file containing cursor data.
///Returns:
///    Type: <b>HCURSOR</b> If the function is successful, the return value is a handle to the new cursor. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    <b>GetLastError</b> may return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified file
///    cannot be found. </td> </tr> </table>
///    
@DllImport("USER32")
HCURSOR LoadCursorFromFileA(const(PSTR) lpFileName);

///Creates a cursor based on data contained in a file.
///Params:
///    lpFileName = Type: <b>LPCTSTR</b> The source of the file data to be used to create the cursor. The data in the file must be in
///                 either .CUR or .ANI format. If the high-order word of <i>lpFileName</i> is nonzero, it is a pointer to a string
///                 that is a fully qualified name of a file containing cursor data.
///Returns:
///    Type: <b>HCURSOR</b> If the function is successful, the return value is a handle to the new cursor. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    <b>GetLastError</b> may return the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified file
///    cannot be found. </td> </tr> </table>
///    
@DllImport("USER32")
HCURSOR LoadCursorFromFileW(const(PWSTR) lpFileName);

///Creates a cursor having the specified size, bit patterns, and hot spot.
///Params:
///    hInst = Type: <b>HINSTANCE</b> A handle to the current instance of the application creating the cursor.
///    xHotSpot = Type: <b>int</b> The horizontal position of the cursor's hot spot.
///    yHotSpot = Type: <b>int</b> The vertical position of the cursor's hot spot.
///    nWidth = Type: <b>int</b> The width of the cursor, in pixels.
///    nHeight = Type: <b>int</b> The height of the cursor, in pixels.
///    pvANDPlane = Type: <b>const VOID*</b> An array of bytes that contains the bit values for the AND mask of the cursor, as in a
///                 device-dependent monochrome bitmap.
///    pvXORPlane = Type: <b>const VOID*</b> An array of bytes that contains the bit values for the XOR mask of the cursor, as in a
///                 device-dependent monochrome bitmap.
///Returns:
///    Type: <b>HCURSOR</b> If the function succeeds, the return value is a handle to the cursor. If the function fails,
///    the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HCURSOR CreateCursor(HINSTANCE hInst, int xHotSpot, int yHotSpot, int nWidth, int nHeight, const(void)* pvANDPlane, 
                     const(void)* pvXORPlane);

///Destroys a cursor and frees any memory the cursor occupied. Do not use this function to destroy a shared cursor.
///Params:
///    hCursor = Type: <b>HCURSOR</b> A handle to the cursor to be destroyed. The cursor must not be in use.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DestroyCursor(HCURSOR hCursor);

///Enables an application to customize the system cursors. It replaces the contents of the system cursor specified by
///the <i>id</i> parameter with the contents of the cursor specified by the <i>hcur</i> parameter and then destroys
///<i>hcur</i>.
///Params:
///    hcur = Type: <b>HCURSOR</b> A handle to the cursor. The function replaces the contents of the system cursor specified by
///           <i>id</i> with the contents of the cursor handled by <i>hcur</i>. The system destroys <i>hcur</i> by calling the
///           DestroyCursor function. Therefore, <i>hcur</i> cannot be a cursor loaded using the LoadCursor function. To
///           specify a cursor loaded from a resource, copy the cursor using the CopyCursor function, then pass the copy to
///           <b>SetSystemCursor</b>.
///    id = Type: <b>DWORD</b> The system cursor to replace with the contents of <i>hcur</i>. This parameter can be one of
///         the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///         id="OCR_APPSTARTING"></a><a id="ocr_appstarting"></a><dl> <dt><b>OCR_APPSTARTING</b></dt> <dt>32650</dt> </dl>
///         </td> <td width="60%"> Standard arrow and small hourglass </td> </tr> <tr> <td width="40%"><a
///         id="OCR_NORMAL"></a><a id="ocr_normal"></a><dl> <dt><b>OCR_NORMAL</b></dt> <dt>32512</dt> </dl> </td> <td
///         width="60%"> Standard arrow </td> </tr> <tr> <td width="40%"><a id="OCR_CROSS"></a><a id="ocr_cross"></a><dl>
///         <dt><b>OCR_CROSS</b></dt> <dt>32515</dt> </dl> </td> <td width="60%"> Crosshair </td> </tr> <tr> <td
///         width="40%"><a id="OCR_HAND"></a><a id="ocr_hand"></a><dl> <dt><b>OCR_HAND</b></dt> <dt>32649</dt> </dl> </td>
///         <td width="60%"> Hand </td> </tr> <tr> <td width="40%"><a id="OCR_HELP"></a><a id="ocr_help"></a><dl>
///         <dt><b>OCR_HELP</b></dt> <dt>32651</dt> </dl> </td> <td width="60%"> Arrow and question mark </td> </tr> <tr> <td
///         width="40%"><a id="OCR_IBEAM"></a><a id="ocr_ibeam"></a><dl> <dt><b>OCR_IBEAM</b></dt> <dt>32513</dt> </dl> </td>
///         <td width="60%"> I-beam </td> </tr> <tr> <td width="40%"><a id="OCR_NO"></a><a id="ocr_no"></a><dl>
///         <dt><b>OCR_NO</b></dt> <dt>32648</dt> </dl> </td> <td width="60%"> Slashed circle </td> </tr> <tr> <td
///         width="40%"><a id="OCR_SIZEALL"></a><a id="ocr_sizeall"></a><dl> <dt><b>OCR_SIZEALL</b></dt> <dt>32646</dt> </dl>
///         </td> <td width="60%"> Four-pointed arrow pointing north, south, east, and west </td> </tr> <tr> <td
///         width="40%"><a id="OCR_SIZENESW"></a><a id="ocr_sizenesw"></a><dl> <dt><b>OCR_SIZENESW</b></dt> <dt>32643</dt>
///         </dl> </td> <td width="60%"> Double-pointed arrow pointing northeast and southwest </td> </tr> <tr> <td
///         width="40%"><a id="OCR_SIZENS"></a><a id="ocr_sizens"></a><dl> <dt><b>OCR_SIZENS</b></dt> <dt>32645</dt> </dl>
///         </td> <td width="60%"> Double-pointed arrow pointing north and south </td> </tr> <tr> <td width="40%"><a
///         id="OCR_SIZENWSE"></a><a id="ocr_sizenwse"></a><dl> <dt><b>OCR_SIZENWSE</b></dt> <dt>32642</dt> </dl> </td> <td
///         width="60%"> Double-pointed arrow pointing northwest and southeast </td> </tr> <tr> <td width="40%"><a
///         id="OCR_SIZEWE"></a><a id="ocr_sizewe"></a><dl> <dt><b>OCR_SIZEWE</b></dt> <dt>32644</dt> </dl> </td> <td
///         width="60%"> Double-pointed arrow pointing west and east </td> </tr> <tr> <td width="40%"><a id="OCR_UP"></a><a
///         id="ocr_up"></a><dl> <dt><b>OCR_UP</b></dt> <dt>32516</dt> </dl> </td> <td width="60%"> Vertical arrow </td>
///         </tr> <tr> <td width="40%"><a id="OCR_WAIT"></a><a id="ocr_wait"></a><dl> <dt><b>OCR_WAIT</b></dt> <dt>32514</dt>
///         </dl> </td> <td width="60%"> Hourglass </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetSystemCursor(HCURSOR hcur, uint id);

///Loads the specified icon resource from the executable (.exe) file associated with an application instance. <div
///class="alert"><b>Note</b> This function has been superseded by the LoadImage function.</div><div> </div>
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to an instance of the module whose executable file contains the icon to be
///                loaded. This parameter must be <b>NULL</b> when a standard icon is being loaded.
///    lpIconName = Type: <b>LPCTSTR</b> The name of the icon resource to be loaded. Alternatively, this parameter can contain the
///                 resource identifier in the low-order word and zero in the high-order word. Use the MAKEINTRESOURCE macro to
///                 create this value. To use one of the predefined icons, set the <i>hInstance</i> parameter to <b>NULL</b> and the
///                 <i>lpIconName</i> parameter to one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                 <tr> <td width="40%"><a id="IDI_APPLICATION"></a><a id="idi_application"></a><dl> <dt><b>IDI_APPLICATION</b></dt>
///                 <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Default application icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_ASTERISK"></a><a id="idi_asterisk"></a><dl> <dt><b>IDI_ASTERISK</b></dt>
///                 <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Asterisk icon. Same as <b>IDI_INFORMATION</b>. </td>
///                 </tr> <tr> <td width="40%"><a id="IDI_ERROR"></a><a id="idi_error"></a><dl> <dt><b>IDI_ERROR</b></dt>
///                 <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%"> Hand-shaped icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_EXCLAMATION"></a><a id="idi_exclamation"></a><dl> <dt><b>IDI_EXCLAMATION</b></dt>
///                 <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Exclamation point icon. Same as <b>IDI_WARNING</b>.
///                 </td> </tr> <tr> <td width="40%"><a id="IDI_HAND"></a><a id="idi_hand"></a><dl> <dt><b>IDI_HAND</b></dt>
///                 <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%"> Hand-shaped icon. Same as <b>IDI_ERROR</b>. </td>
///                 </tr> <tr> <td width="40%"><a id="IDI_INFORMATION"></a><a id="idi_information"></a><dl>
///                 <dt><b>IDI_INFORMATION</b></dt> <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Asterisk icon. </td>
///                 </tr> <tr> <td width="40%"><a id="IDI_QUESTION"></a><a id="idi_question"></a><dl> <dt><b>IDI_QUESTION</b></dt>
///                 <dt>MAKEINTRESOURCE(32514)</dt> </dl> </td> <td width="60%"> Question mark icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_SHIELD"></a><a id="idi_shield"></a><dl> <dt><b>IDI_SHIELD</b></dt>
///                 <dt>MAKEINTRESOURCE(32518)</dt> </dl> </td> <td width="60%"> Security Shield icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_WARNING"></a><a id="idi_warning"></a><dl> <dt><b>IDI_WARNING</b></dt>
///                 <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Exclamation point icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_WINLOGO"></a><a id="idi_winlogo"></a><dl> <dt><b>IDI_WINLOGO</b></dt>
///                 <dt>MAKEINTRESOURCE(32517)</dt> </dl> </td> <td width="60%"> Default application icon. <b>Windows 2000:
///                 </b>Windows logo icon. </td> </tr> </table>
///Returns:
///    Type: <b>HICON</b> If the function succeeds, the return value is a handle to the newly loaded icon. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HICON LoadIconA(HINSTANCE hInstance, const(PSTR) lpIconName);

///Loads the specified icon resource from the executable (.exe) file associated with an application instance. <div
///class="alert"><b>Note</b> This function has been superseded by the LoadImage function.</div><div> </div>
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to an instance of the module whose executable file contains the icon to be
///                loaded. This parameter must be <b>NULL</b> when a standard icon is being loaded.
///    lpIconName = Type: <b>LPCTSTR</b> The name of the icon resource to be loaded. Alternatively, this parameter can contain the
///                 resource identifier in the low-order word and zero in the high-order word. Use the MAKEINTRESOURCE macro to
///                 create this value. To use one of the predefined icons, set the <i>hInstance</i> parameter to <b>NULL</b> and the
///                 <i>lpIconName</i> parameter to one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                 <tr> <td width="40%"><a id="IDI_APPLICATION"></a><a id="idi_application"></a><dl> <dt><b>IDI_APPLICATION</b></dt>
///                 <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Default application icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_ASTERISK"></a><a id="idi_asterisk"></a><dl> <dt><b>IDI_ASTERISK</b></dt>
///                 <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Asterisk icon. Same as <b>IDI_INFORMATION</b>. </td>
///                 </tr> <tr> <td width="40%"><a id="IDI_ERROR"></a><a id="idi_error"></a><dl> <dt><b>IDI_ERROR</b></dt>
///                 <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%"> Hand-shaped icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_EXCLAMATION"></a><a id="idi_exclamation"></a><dl> <dt><b>IDI_EXCLAMATION</b></dt>
///                 <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Exclamation point icon. Same as <b>IDI_WARNING</b>.
///                 </td> </tr> <tr> <td width="40%"><a id="IDI_HAND"></a><a id="idi_hand"></a><dl> <dt><b>IDI_HAND</b></dt>
///                 <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%"> Hand-shaped icon. Same as <b>IDI_ERROR</b>. </td>
///                 </tr> <tr> <td width="40%"><a id="IDI_INFORMATION"></a><a id="idi_information"></a><dl>
///                 <dt><b>IDI_INFORMATION</b></dt> <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Asterisk icon. </td>
///                 </tr> <tr> <td width="40%"><a id="IDI_QUESTION"></a><a id="idi_question"></a><dl> <dt><b>IDI_QUESTION</b></dt>
///                 <dt>MAKEINTRESOURCE(32514)</dt> </dl> </td> <td width="60%"> Question mark icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_SHIELD"></a><a id="idi_shield"></a><dl> <dt><b>IDI_SHIELD</b></dt>
///                 <dt>MAKEINTRESOURCE(32518)</dt> </dl> </td> <td width="60%"> Security Shield icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_WARNING"></a><a id="idi_warning"></a><dl> <dt><b>IDI_WARNING</b></dt>
///                 <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Exclamation point icon. </td> </tr> <tr> <td
///                 width="40%"><a id="IDI_WINLOGO"></a><a id="idi_winlogo"></a><dl> <dt><b>IDI_WINLOGO</b></dt>
///                 <dt>MAKEINTRESOURCE(32517)</dt> </dl> </td> <td width="60%"> Default application icon. <b>Windows 2000:
///                 </b>Windows logo icon. </td> </tr> </table>
///Returns:
///    Type: <b>HICON</b> If the function succeeds, the return value is a handle to the newly loaded icon. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HICON LoadIconW(HINSTANCE hInstance, const(PWSTR) lpIconName);

///<p class="CCE_Message">[This function is not intended for general use. It may be altered or unavailable in subsequent
///versions of Windows.] Creates an array of handles to icons that are extracted from a specified file.
///Params:
///    szFileName = Type: <b>LPCTSTR</b> The path and name of the file from which the icon(s) are to be extracted.
///    nIconIndex = Type: <b>int</b> The zero-based index of the first icon to extract. For example, if this value is zero, the
///                 function extracts the first icon in the specified file.
///    cxIcon = Type: <b>int</b> The horizontal icon size wanted. See Remarks.
///    cyIcon = Type: <b>int</b> The vertical icon size wanted. See Remarks.
///    phicon = Type: <b>HICON*</b> A pointer to the returned array of icon handles.
///    piconid = Type: <b>UINT*</b> A pointer to a returned resource identifier for the icon that best fits the current display
///              device. The returned identifier is 0xFFFFFFFF if the identifier is not available for this format. The returned
///              identifier is 0 if the identifier cannot otherwise be obtained.
///    nIcons = Type: <b>UINT</b> The number of icons to extract from the file. This parameter is only valid when extracting from
///             .exe and .dll files.
///    flags = Type: <b>UINT</b> Specifies flags that control this function. These flags are the LR_* flags used by the
///            LoadImage function.
///Returns:
///    Type: <b>UINT</b> If the <i>phicon</i>parameter is <b>NULL</b> and this function succeeds, then the return value
///    is the number of icons in the file. If the function fails then the return value is 0. If the <i>phicon</i>
///    parameter is not <b>NULL</b> and the function succeeds, then the return value is the number of icons extracted.
///    Otherwise, the return value is 0xFFFFFFFF if the file is not found.
///    
@DllImport("USER32")
uint PrivateExtractIconsA(const(PSTR) szFileName, int nIconIndex, int cxIcon, int cyIcon, HICON* phicon, 
                          uint* piconid, uint nIcons, uint flags);

///<p class="CCE_Message">[This function is not intended for general use. It may be altered or unavailable in subsequent
///versions of Windows.] Creates an array of handles to icons that are extracted from a specified file.
///Params:
///    szFileName = Type: <b>LPCTSTR</b> The path and name of the file from which the icon(s) are to be extracted.
///    nIconIndex = Type: <b>int</b> The zero-based index of the first icon to extract. For example, if this value is zero, the
///                 function extracts the first icon in the specified file.
///    cxIcon = Type: <b>int</b> The horizontal icon size wanted. See Remarks.
///    cyIcon = Type: <b>int</b> The vertical icon size wanted. See Remarks.
///    phicon = Type: <b>HICON*</b> A pointer to the returned array of icon handles.
///    piconid = Type: <b>UINT*</b> A pointer to a returned resource identifier for the icon that best fits the current display
///              device. The returned identifier is 0xFFFFFFFF if the identifier is not available for this format. The returned
///              identifier is 0 if the identifier cannot otherwise be obtained.
///    nIcons = Type: <b>UINT</b> The number of icons to extract from the file. This parameter is only valid when extracting from
///             .exe and .dll files.
///    flags = Type: <b>UINT</b> Specifies flags that control this function. These flags are the LR_* flags used by the
///            LoadImage function.
///Returns:
///    Type: <b>UINT</b> If the <i>phicon</i>parameter is <b>NULL</b> and this function succeeds, then the return value
///    is the number of icons in the file. If the function fails then the return value is 0. If the <i>phicon</i>
///    parameter is not <b>NULL</b> and the function succeeds, then the return value is the number of icons extracted.
///    Otherwise, the return value is 0xFFFFFFFF if the file is not found.
///    
@DllImport("USER32")
uint PrivateExtractIconsW(const(PWSTR) szFileName, int nIconIndex, int cxIcon, int cyIcon, HICON* phicon, 
                          uint* piconid, uint nIcons, uint flags);

///Creates an icon that has the specified size, colors, and bit patterns.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the module creating the icon.
///    nWidth = Type: <b>int</b> The width, in pixels, of the icon.
///    nHeight = Type: <b>int</b> The height, in pixels, of the icon.
///    cPlanes = Type: <b>BYTE</b> The number of planes in the XOR bitmask of the icon.
///    cBitsPixel = Type: <b>BYTE</b> The number of bits-per-pixel in the XOR bitmask of the icon.
///    lpbANDbits = Type: <b>const BYTE*</b> An array of bytes that contains the bit values for the AND bitmask of the icon. This
///                 bitmask describes a monochrome bitmap.
///    lpbXORbits = Type: <b>const BYTE*</b> An array of bytes that contains the bit values for the XOR bitmask of the icon. This
///                 bitmask describes a monochrome or device-dependent color bitmap.
///Returns:
///    Type: <b>HICON</b> If the function succeeds, the return value is a handle to an icon. If the function fails, the
///    return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HICON CreateIcon(HINSTANCE hInstance, int nWidth, int nHeight, ubyte cPlanes, ubyte cBitsPixel, 
                 const(ubyte)* lpbANDbits, const(ubyte)* lpbXORbits);

///Destroys an icon and frees any memory the icon occupied.
///Params:
///    hIcon = Type: <b>HICON</b> A handle to the icon to be destroyed. The icon must not be in use.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DestroyIcon(HICON hIcon);

///Searches through icon or cursor data for the icon or cursor that best fits the current display device. To specify a
///desired height or width, use the LookupIconIdFromDirectoryEx function.
///Params:
///    presbits = Type: <b>PBYTE</b> The icon or cursor directory data. Because this function does not validate the resource data,
///               it causes a general protection (GP) fault or returns an undefined value if <i>presbits</i> is not pointing to
///               valid resource data.
///    fIcon = Type: <b>BOOL</b> Indicates whether an icon or a cursor is sought. If this parameter is <b>TRUE</b>, the function
///            is searching for an icon; if the parameter is <b>FALSE</b>, the function is searching for a cursor.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is an integer resource identifier for the icon or
///    cursor that best fits the current display device. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
int LookupIconIdFromDirectory(ubyte* presbits, BOOL fIcon);

///Searches through icon or cursor data for the icon or cursor that best fits the current display device.
///Params:
///    presbits = Type: <b>PBYTE</b> The icon or cursor directory data. Because this function does not validate the resource data,
///               it causes a general protection (GP) fault or returns an undefined value if <i>presbits</i> is not pointing to
///               valid resource data.
///    fIcon = Type: <b>BOOL</b> Indicates whether an icon or a cursor is sought. If this parameter is <b>TRUE</b>, the function
///            is searching for an icon; if the parameter is <b>FALSE</b>, the function is searching for a cursor.
///    cxDesired = Type: <b>int</b> The desired width, in pixels, of the icon. If this parameter is zero, the function uses the
///                <b>SM_CXICON</b> or <b>SM_CXCURSOR</b> system metric value.
///    cyDesired = Type: <b>int</b> The desired height, in pixels, of the icon. If this parameter is zero, the function uses the
///                <b>SM_CYICON</b> or <b>SM_CYCURSOR</b> system metric value.
///    Flags = Type: <b>UINT</b> A combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///            <td width="40%"><a id="LR_DEFAULTCOLOR"></a><a id="lr_defaultcolor"></a><dl> <dt><b>LR_DEFAULTCOLOR</b></dt>
///            <dt>0x00000000</dt> </dl> </td> <td width="60%"> Uses the default color format. </td> </tr> <tr> <td
///            width="40%"><a id="LR_MONOCHROME"></a><a id="lr_monochrome"></a><dl> <dt><b>LR_MONOCHROME</b></dt>
///            <dt>0x00000001</dt> </dl> </td> <td width="60%"> Creates a monochrome icon or cursor. </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is an integer resource identifier for the icon or
///    cursor that best fits the current display device. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
int LookupIconIdFromDirectoryEx(ubyte* presbits, BOOL fIcon, int cxDesired, int cyDesired, uint Flags);

///Creates an icon or cursor from resource bits describing the icon. To specify a desired height or width, use the
///CreateIconFromResourceEx function.
///Params:
///    presbits = Type: <b>PBYTE</b> The buffer containing the icon or cursor resource bits. These bits are typically loaded by
///               calls to the LookupIconIdFromDirectory, LookupIconIdFromDirectoryEx, and LoadResource functions.
///    dwResSize = Type: <b>DWORD</b> The size, in bytes, of the set of bits pointed to by the <i>presbits</i> parameter.
///    fIcon = Type: <b>BOOL</b> Indicates whether an icon or a cursor is to be created. If this parameter is <b>TRUE</b>, an
///            icon is to be created. If it is <b>FALSE</b>, a cursor is to be created.
///    dwVer = Type: <b>DWORD</b> The version number of the icon or cursor format for the resource bits pointed to by the
///            <i>presbits</i> parameter. The value must be greater than or equal to 0x00020000 and less than or equal to
///            0x00030000. This parameter is generally set to 0x00030000.
///Returns:
///    Type: <b>HICON</b> If the function succeeds, the return value is a handle to the icon or cursor. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HICON CreateIconFromResource(ubyte* presbits, uint dwResSize, BOOL fIcon, uint dwVer);

///Creates an icon or cursor from resource bits describing the icon.
///Params:
///    presbits = Type: <b>PBYTE</b> The icon or cursor resource bits. These bits are typically loaded by calls to the
///               LookupIconIdFromDirectoryEx and LoadResource functions.
///    dwResSize = Type: <b>DWORD</b> The size, in bytes, of the set of bits pointed to by the <i>pbIconBits</i> parameter.
///    fIcon = Type: <b>BOOL</b> Indicates whether an icon or a cursor is to be created. If this parameter is <b>TRUE</b>, an
///            icon is to be created. If it is <b>FALSE</b>, a cursor is to be created.
///    dwVer = Type: <b>DWORD</b> The version number of the icon or cursor format for the resource bits pointed to by the
///            <i>pbIconBits</i> parameter. The value must be greater than or equal to 0x00020000 and less than or equal to
///            0x00030000. This parameter is generally set to 0x00030000.
///    cxDesired = Type: <b>int</b> The desired width, in pixels, of the icon or cursor. If this parameter is zero, the function
///                uses the <b>SM_CXICON</b> or <b>SM_CXCURSOR</b> system metric value to set the width.
///    cyDesired = Type: <b>int</b> The desired height, in pixels, of the icon or cursor. If this parameter is zero, the function
///                uses the <b>SM_CYICON</b> or <b>SM_CYCURSOR</b> system metric value to set the height.
///    Flags = Type: <b>UINT</b> A combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///            <td width="40%"><a id="LR_DEFAULTCOLOR"></a><a id="lr_defaultcolor"></a><dl> <dt><b>LR_DEFAULTCOLOR</b></dt>
///            <dt>0x00000000</dt> </dl> </td> <td width="60%"> Uses the default color format. </td> </tr> <tr> <td
///            width="40%"><a id="LR_DEFAULTSIZE"></a><a id="lr_defaultsize"></a><dl> <dt><b>LR_DEFAULTSIZE</b></dt>
///            <dt>0x00000040</dt> </dl> </td> <td width="60%"> Uses the width or height specified by the system metric values
///            for cursors or icons, if the <i>cxDesired</i> or <i>cyDesired</i> values are set to zero. If this flag is not
///            specified and <i>cxDesired</i> and <i>cyDesired</i> are set to zero, the function uses the actual resource size.
///            If the resource contains multiple images, the function uses the size of the first image. </td> </tr> <tr> <td
///            width="40%"><a id="LR_MONOCHROME"></a><a id="lr_monochrome"></a><dl> <dt><b>LR_MONOCHROME</b></dt>
///            <dt>0x00000001</dt> </dl> </td> <td width="60%"> Creates a monochrome icon or cursor. </td> </tr> <tr> <td
///            width="40%"><a id="LR_SHARED"></a><a id="lr_shared"></a><dl> <dt><b>LR_SHARED</b></dt> <dt>0x00008000</dt> </dl>
///            </td> <td width="60%"> Shares the icon or cursor handle if the icon or cursor is created multiple times. If
///            <b>LR_SHARED</b> is not set, a second call to <b>CreateIconFromResourceEx</b> for the same resource will create
///            the icon or cursor again and return a different handle. When you use this flag, the system will destroy the
///            resource when it is no longer needed. Do not use <b>LR_SHARED</b> for icons or cursors that have non-standard
///            sizes, that may change after loading, or that are loaded from a file. When loading a system icon or cursor, you
///            must use <b>LR_SHARED</b> or the function will fail to load the resource. </td> </tr> </table>
///Returns:
///    Type: <b>HICON</b> If the function succeeds, the return value is a handle to the icon or cursor. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HICON CreateIconFromResourceEx(ubyte* presbits, uint dwResSize, BOOL fIcon, uint dwVer, int cxDesired, 
                               int cyDesired, uint Flags);

///Loads an icon, cursor, animated cursor, or bitmap.
///Params:
///    hInst = Type: <b>HINSTANCE</b> A handle to the module of either a DLL or executable (.exe) that contains the image to be
///            loaded. For more information, see GetModuleHandle. Note that as of 32-bit Windows, an instance handle
///            (<b>HINSTANCE</b>), such as the application instance handle exposed by system function call of WinMain, and a
///            module handle (<b>HMODULE</b>) are the same thing. To load an OEM image, set this parameter to <b>NULL</b>. To
///            load a stand-alone resource (icon, cursor, or bitmap file)—for example, c:\myimage.bmp—set this parameter to
///            <b>NULL</b>.
///    name = Type: <b>LPCTSTR</b> The image to be loaded. If the <i>hinst</i> parameter is non-<b>NULL</b> and the
///           <i>fuLoad</i> parameter omits <b>LR_LOADFROMFILE</b>, <i>lpszName</i> specifies the image resource in the
///           <i>hinst</i> module. If the image resource is to be loaded by name from the module, the <i>lpszName</i> parameter
///           is a pointer to a null-terminated string that contains the name of the image resource. If the image resource is
///           to be loaded by ordinal from the module, use the MAKEINTRESOURCE macro to convert the image ordinal into a form
///           that can be passed to the <b>LoadImage</b> function. For more information, see the Remarks section below. If the
///           <i>hinst</i> parameter is <b>NULL</b> and the <i>fuLoad</i> parameter omits the <b>LR_LOADFROMFILE</b> value, the
///           <i>lpszName</i> specifies the OEM image to load. The OEM image identifiers are defined in Winuser.h and have the
///           following prefixes. <table class="clsStd"> <tr> <th>Prefix</th> <th>Meaning</th> </tr> <tr> <td><b>OBM_</b></td>
///           <td>OEM bitmaps</td> </tr> <tr> <td><b>OIC_</b></td> <td>OEM icons</td> </tr> <tr> <td><b>OCR_</b></td> <td>OEM
///           cursors</td> </tr> </table> To pass these constants to the <b>LoadImage</b> function, use the MAKEINTRESOURCE
///           macro. For example, to load the <b>OCR_NORMAL</b> cursor, pass <code>MAKEINTRESOURCE(OCR_NORMAL)</code> as the
///           <i>lpszName</i> parameter, <b>NULL</b> as the <i>hinst</i> parameter, and <b>LR_SHARED</b> as one of the flags to
///           the <i>fuLoad</i> parameter. If the <i>fuLoad</i> parameter includes the <b>LR_LOADFROMFILE</b> value,
///           <i>lpszName</i> is the name of the file that contains the stand-alone resource (icon, cursor, or bitmap file).
///           Therefore, set <i>hinst</i> to <b>NULL</b>.
///    type = Type: <b>UINT</b> The type of image to be loaded. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IMAGE_BITMAP"></a><a id="image_bitmap"></a><dl>
///           <dt><b>IMAGE_BITMAP</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Loads a bitmap. </td> </tr> <tr> <td
///           width="40%"><a id="IMAGE_CURSOR"></a><a id="image_cursor"></a><dl> <dt><b>IMAGE_CURSOR</b></dt> <dt>2</dt> </dl>
///           </td> <td width="60%"> Loads a cursor. </td> </tr> <tr> <td width="40%"><a id="IMAGE_ICON"></a><a
///           id="image_icon"></a><dl> <dt><b>IMAGE_ICON</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Loads an icon. </td>
///           </tr> </table>
///    cx = Type: <b>int</b> The width, in pixels, of the icon or cursor. If this parameter is zero and the <i>fuLoad</i>
///         parameter is <b>LR_DEFAULTSIZE</b>, the function uses the <b>SM_CXICON</b> or <b>SM_CXCURSOR</b> system metric
///         value to set the width. If this parameter is zero and <b>LR_DEFAULTSIZE</b> is not used, the function uses the
///         actual resource width.
///    cy = Type: <b>int</b> The height, in pixels, of the icon or cursor. If this parameter is zero and the <i>fuLoad</i>
///         parameter is <b>LR_DEFAULTSIZE</b>, the function uses the <b>SM_CYICON</b> or <b>SM_CYCURSOR</b> system metric
///         value to set the height. If this parameter is zero and <b>LR_DEFAULTSIZE</b> is not used, the function uses the
///         actual resource height.
///    fuLoad = Type: <b>UINT</b> This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LR_CREATEDIBSECTION"></a><a id="lr_createdibsection"></a><dl>
///             <dt><b>LR_CREATEDIBSECTION</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> When the <i>uType</i>
///             parameter specifies <b>IMAGE_BITMAP</b>, causes the function to return a DIB section bitmap rather than a
///             compatible bitmap. This flag is useful for loading a bitmap without mapping it to the colors of the display
///             device. </td> </tr> <tr> <td width="40%"><a id="LR_DEFAULTCOLOR"></a><a id="lr_defaultcolor"></a><dl>
///             <dt><b>LR_DEFAULTCOLOR</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The default flag; it does
///             nothing. All it means is "not <b>LR_MONOCHROME</b>". </td> </tr> <tr> <td width="40%"><a
///             id="LR_DEFAULTSIZE"></a><a id="lr_defaultsize"></a><dl> <dt><b>LR_DEFAULTSIZE</b></dt> <dt>0x00000040</dt> </dl>
///             </td> <td width="60%"> Uses the width or height specified by the system metric values for cursors or icons, if
///             the <i>cxDesired</i> or <i>cyDesired</i> values are set to zero. If this flag is not specified and
///             <i>cxDesired</i> and <i>cyDesired</i> are set to zero, the function uses the actual resource size. If the
///             resource contains multiple images, the function uses the size of the first image. </td> </tr> <tr> <td
///             width="40%"><a id="LR_LOADFROMFILE"></a><a id="lr_loadfromfile"></a><dl> <dt><b>LR_LOADFROMFILE</b></dt>
///             <dt>0x00000010</dt> </dl> </td> <td width="60%"> Loads the stand-alone image from the file specified by
///             <i>lpszName</i> (icon, cursor, or bitmap file). </td> </tr> <tr> <td width="40%"><a
///             id="LR_LOADMAP3DCOLORS"></a><a id="lr_loadmap3dcolors"></a><dl> <dt><b>LR_LOADMAP3DCOLORS</b></dt>
///             <dt>0x00001000</dt> </dl> </td> <td width="60%"> Searches the color table for the image and replaces the
///             following shades of gray with the corresponding 3-D color. <ul> <li>Dk Gray, RGB(128,128,128) with
///             <b>COLOR_3DSHADOW</b></li> <li>Gray, RGB(192,192,192) with <b>COLOR_3DFACE</b></li> <li>Lt Gray, RGB(223,223,223)
///             with <b>COLOR_3DLIGHT</b></li> </ul> Do not use this option if you are loading a bitmap with a color depth
///             greater than 8bpp. </td> </tr> <tr> <td width="40%"><a id="LR_LOADTRANSPARENT"></a><a
///             id="lr_loadtransparent"></a><dl> <dt><b>LR_LOADTRANSPARENT</b></dt> <dt>0x00000020</dt> </dl> </td> <td
///             width="60%"> Retrieves the color value of the first pixel in the image and replaces the corresponding entry in
///             the color table with the default window color (<b>COLOR_WINDOW</b>). All pixels in the image that use that entry
///             become the default window color. This value applies only to images that have corresponding color tables. Do not
///             use this option if you are loading a bitmap with a color depth greater than 8bpp. If <i>fuLoad</i> includes both
///             the <b>LR_LOADTRANSPARENT</b> and <b>LR_LOADMAP3DCOLORS</b> values, <b>LR_LOADTRANSPARENT</b> takes precedence.
///             However, the color table entry is replaced with <b>COLOR_3DFACE</b> rather than <b>COLOR_WINDOW</b>. </td> </tr>
///             <tr> <td width="40%"><a id="LR_MONOCHROME"></a><a id="lr_monochrome"></a><dl> <dt><b>LR_MONOCHROME</b></dt>
///             <dt>0x00000001</dt> </dl> </td> <td width="60%"> Loads the image in black and white. </td> </tr> <tr> <td
///             width="40%"><a id="LR_SHARED"></a><a id="lr_shared"></a><dl> <dt><b>LR_SHARED</b></dt> <dt>0x00008000</dt> </dl>
///             </td> <td width="60%"> Shares the image handle if the image is loaded multiple times. If <b>LR_SHARED</b> is not
///             set, a second call to <b>LoadImage</b> for the same resource will load the image again and return a different
///             handle. When you use this flag, the system will destroy the resource when it is no longer needed. Do not use
///             <b>LR_SHARED</b> for images that have non-standard sizes, that may change after loading, or that are loaded from
///             a file. When loading a system icon or cursor, you must use <b>LR_SHARED</b> or the function will fail to load the
///             resource. This function finds the first image in the cache with the requested resource name, regardless of the
///             size requested. </td> </tr> <tr> <td width="40%"><a id="LR_VGACOLOR"></a><a id="lr_vgacolor"></a><dl>
///             <dt><b>LR_VGACOLOR</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Uses true VGA colors. </td> </tr>
///             </table>
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, the return value is the handle of the newly loaded image. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HANDLE LoadImageA(HINSTANCE hInst, const(PSTR) name, uint type, int cx, int cy, uint fuLoad);

///Loads an icon, cursor, animated cursor, or bitmap.
///Params:
///    hInst = Type: <b>HINSTANCE</b> A handle to the module of either a DLL or executable (.exe) that contains the image to be
///            loaded. For more information, see GetModuleHandle. Note that as of 32-bit Windows, an instance handle
///            (<b>HINSTANCE</b>), such as the application instance handle exposed by system function call of WinMain, and a
///            module handle (<b>HMODULE</b>) are the same thing. To load an OEM image, set this parameter to <b>NULL</b>. To
///            load a stand-alone resource (icon, cursor, or bitmap file)—for example, c:\myimage.bmp—set this parameter to
///            <b>NULL</b>.
///    name = Type: <b>LPCTSTR</b> The image to be loaded. If the <i>hinst</i> parameter is non-<b>NULL</b> and the
///           <i>fuLoad</i> parameter omits <b>LR_LOADFROMFILE</b>, <i>lpszName</i> specifies the image resource in the
///           <i>hinst</i> module. If the image resource is to be loaded by name from the module, the <i>lpszName</i> parameter
///           is a pointer to a null-terminated string that contains the name of the image resource. If the image resource is
///           to be loaded by ordinal from the module, use the MAKEINTRESOURCE macro to convert the image ordinal into a form
///           that can be passed to the <b>LoadImage</b> function. For more information, see the Remarks section below. If the
///           <i>hinst</i> parameter is <b>NULL</b> and the <i>fuLoad</i> parameter omits the <b>LR_LOADFROMFILE</b> value, the
///           <i>lpszName</i> specifies the OEM image to load. The OEM image identifiers are defined in Winuser.h and have the
///           following prefixes. <table class="clsStd"> <tr> <th>Prefix</th> <th>Meaning</th> </tr> <tr> <td><b>OBM_</b></td>
///           <td>OEM bitmaps</td> </tr> <tr> <td><b>OIC_</b></td> <td>OEM icons</td> </tr> <tr> <td><b>OCR_</b></td> <td>OEM
///           cursors</td> </tr> </table> To pass these constants to the <b>LoadImage</b> function, use the MAKEINTRESOURCE
///           macro. For example, to load the <b>OCR_NORMAL</b> cursor, pass <code>MAKEINTRESOURCE(OCR_NORMAL)</code> as the
///           <i>lpszName</i> parameter, <b>NULL</b> as the <i>hinst</i> parameter, and <b>LR_SHARED</b> as one of the flags to
///           the <i>fuLoad</i> parameter. If the <i>fuLoad</i> parameter includes the <b>LR_LOADFROMFILE</b> value,
///           <i>lpszName</i> is the name of the file that contains the stand-alone resource (icon, cursor, or bitmap file).
///           Therefore, set <i>hinst</i> to <b>NULL</b>.
///    type = Type: <b>UINT</b> The type of image to be loaded. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IMAGE_BITMAP"></a><a id="image_bitmap"></a><dl>
///           <dt><b>IMAGE_BITMAP</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Loads a bitmap. </td> </tr> <tr> <td
///           width="40%"><a id="IMAGE_CURSOR"></a><a id="image_cursor"></a><dl> <dt><b>IMAGE_CURSOR</b></dt> <dt>2</dt> </dl>
///           </td> <td width="60%"> Loads a cursor. </td> </tr> <tr> <td width="40%"><a id="IMAGE_ICON"></a><a
///           id="image_icon"></a><dl> <dt><b>IMAGE_ICON</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Loads an icon. </td>
///           </tr> </table>
///    cx = Type: <b>int</b> The width, in pixels, of the icon or cursor. If this parameter is zero and the <i>fuLoad</i>
///         parameter is <b>LR_DEFAULTSIZE</b>, the function uses the <b>SM_CXICON</b> or <b>SM_CXCURSOR</b> system metric
///         value to set the width. If this parameter is zero and <b>LR_DEFAULTSIZE</b> is not used, the function uses the
///         actual resource width.
///    cy = Type: <b>int</b> The height, in pixels, of the icon or cursor. If this parameter is zero and the <i>fuLoad</i>
///         parameter is <b>LR_DEFAULTSIZE</b>, the function uses the <b>SM_CYICON</b> or <b>SM_CYCURSOR</b> system metric
///         value to set the height. If this parameter is zero and <b>LR_DEFAULTSIZE</b> is not used, the function uses the
///         actual resource height.
///    fuLoad = Type: <b>UINT</b> This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LR_CREATEDIBSECTION"></a><a id="lr_createdibsection"></a><dl>
///             <dt><b>LR_CREATEDIBSECTION</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> When the <i>uType</i>
///             parameter specifies <b>IMAGE_BITMAP</b>, causes the function to return a DIB section bitmap rather than a
///             compatible bitmap. This flag is useful for loading a bitmap without mapping it to the colors of the display
///             device. </td> </tr> <tr> <td width="40%"><a id="LR_DEFAULTCOLOR"></a><a id="lr_defaultcolor"></a><dl>
///             <dt><b>LR_DEFAULTCOLOR</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The default flag; it does
///             nothing. All it means is "not <b>LR_MONOCHROME</b>". </td> </tr> <tr> <td width="40%"><a
///             id="LR_DEFAULTSIZE"></a><a id="lr_defaultsize"></a><dl> <dt><b>LR_DEFAULTSIZE</b></dt> <dt>0x00000040</dt> </dl>
///             </td> <td width="60%"> Uses the width or height specified by the system metric values for cursors or icons, if
///             the <i>cxDesired</i> or <i>cyDesired</i> values are set to zero. If this flag is not specified and
///             <i>cxDesired</i> and <i>cyDesired</i> are set to zero, the function uses the actual resource size. If the
///             resource contains multiple images, the function uses the size of the first image. </td> </tr> <tr> <td
///             width="40%"><a id="LR_LOADFROMFILE"></a><a id="lr_loadfromfile"></a><dl> <dt><b>LR_LOADFROMFILE</b></dt>
///             <dt>0x00000010</dt> </dl> </td> <td width="60%"> Loads the stand-alone image from the file specified by
///             <i>lpszName</i> (icon, cursor, or bitmap file). </td> </tr> <tr> <td width="40%"><a
///             id="LR_LOADMAP3DCOLORS"></a><a id="lr_loadmap3dcolors"></a><dl> <dt><b>LR_LOADMAP3DCOLORS</b></dt>
///             <dt>0x00001000</dt> </dl> </td> <td width="60%"> Searches the color table for the image and replaces the
///             following shades of gray with the corresponding 3-D color. <ul> <li>Dk Gray, RGB(128,128,128) with
///             <b>COLOR_3DSHADOW</b></li> <li>Gray, RGB(192,192,192) with <b>COLOR_3DFACE</b></li> <li>Lt Gray, RGB(223,223,223)
///             with <b>COLOR_3DLIGHT</b></li> </ul> Do not use this option if you are loading a bitmap with a color depth
///             greater than 8bpp. </td> </tr> <tr> <td width="40%"><a id="LR_LOADTRANSPARENT"></a><a
///             id="lr_loadtransparent"></a><dl> <dt><b>LR_LOADTRANSPARENT</b></dt> <dt>0x00000020</dt> </dl> </td> <td
///             width="60%"> Retrieves the color value of the first pixel in the image and replaces the corresponding entry in
///             the color table with the default window color (<b>COLOR_WINDOW</b>). All pixels in the image that use that entry
///             become the default window color. This value applies only to images that have corresponding color tables. Do not
///             use this option if you are loading a bitmap with a color depth greater than 8bpp. If <i>fuLoad</i> includes both
///             the <b>LR_LOADTRANSPARENT</b> and <b>LR_LOADMAP3DCOLORS</b> values, <b>LR_LOADTRANSPARENT</b> takes precedence.
///             However, the color table entry is replaced with <b>COLOR_3DFACE</b> rather than <b>COLOR_WINDOW</b>. </td> </tr>
///             <tr> <td width="40%"><a id="LR_MONOCHROME"></a><a id="lr_monochrome"></a><dl> <dt><b>LR_MONOCHROME</b></dt>
///             <dt>0x00000001</dt> </dl> </td> <td width="60%"> Loads the image in black and white. </td> </tr> <tr> <td
///             width="40%"><a id="LR_SHARED"></a><a id="lr_shared"></a><dl> <dt><b>LR_SHARED</b></dt> <dt>0x00008000</dt> </dl>
///             </td> <td width="60%"> Shares the image handle if the image is loaded multiple times. If <b>LR_SHARED</b> is not
///             set, a second call to <b>LoadImage</b> for the same resource will load the image again and return a different
///             handle. When you use this flag, the system will destroy the resource when it is no longer needed. Do not use
///             <b>LR_SHARED</b> for images that have non-standard sizes, that may change after loading, or that are loaded from
///             a file. When loading a system icon or cursor, you must use <b>LR_SHARED</b> or the function will fail to load the
///             resource. This function finds the first image in the cache with the requested resource name, regardless of the
///             size requested. </td> </tr> <tr> <td width="40%"><a id="LR_VGACOLOR"></a><a id="lr_vgacolor"></a><dl>
///             <dt><b>LR_VGACOLOR</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Uses true VGA colors. </td> </tr>
///             </table>
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, the return value is the handle of the newly loaded image. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HANDLE LoadImageW(HINSTANCE hInst, const(PWSTR) name, uint type, int cx, int cy, uint fuLoad);

///Creates a new image (icon, cursor, or bitmap) and copies the attributes of the specified image to the new one. If
///necessary, the function stretches the bits to fit the desired size of the new image.
///Params:
///    h = Type: <b>HANDLE</b> A handle to the image to be copied.
///    type = Type: <b>UINT</b> The type of image to be copied. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IMAGE_BITMAP"></a><a id="image_bitmap"></a><dl>
///           <dt><b>IMAGE_BITMAP</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Copies a bitmap. </td> </tr> <tr> <td
///           width="40%"><a id="IMAGE_CURSOR"></a><a id="image_cursor"></a><dl> <dt><b>IMAGE_CURSOR</b></dt> <dt>2</dt> </dl>
///           </td> <td width="60%"> Copies a cursor. </td> </tr> <tr> <td width="40%"><a id="IMAGE_ICON"></a><a
///           id="image_icon"></a><dl> <dt><b>IMAGE_ICON</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Copies an icon. </td>
///           </tr> </table>
///    cx = Type: <b>int</b> The desired width, in pixels, of the image. If this is zero, then the returned image will have
///         the same width as the original <i>hImage</i>.
///    cy = Type: <b>int</b> The desired height, in pixels, of the image. If this is zero, then the returned image will have
///         the same height as the original <i>hImage</i>.
///    flags = Type: <b>UINT</b> This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LR_COPYDELETEORG"></a><a id="lr_copydeleteorg"></a><dl>
///            <dt><b>LR_COPYDELETEORG</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Deletes the original image
///            after creating the copy. </td> </tr> <tr> <td width="40%"><a id="LR_COPYFROMRESOURCE"></a><a
///            id="lr_copyfromresource"></a><dl> <dt><b>LR_COPYFROMRESOURCE</b></dt> <dt>0x00004000</dt> </dl> </td> <td
///            width="60%"> Tries to reload an icon or cursor resource from the original resource file rather than simply
///            copying the current image. This is useful for creating a different-sized copy when the resource file contains
///            multiple sizes of the resource. Without this flag, <b>CopyImage</b> stretches the original image to the new size.
///            If this flag is set, <b>CopyImage</b> uses the size in the resource file closest to the desired size. This will
///            succeed only if <i>hImage</i> was loaded by LoadIcon or LoadCursor, or by LoadImage with the LR_SHARED flag.
///            </td> </tr> <tr> <td width="40%"><a id="LR_COPYRETURNORG"></a><a id="lr_copyreturnorg"></a><dl>
///            <dt><b>LR_COPYRETURNORG</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Returns the original
///            <i>hImage</i> if it satisfies the criteria for the copy—that is, correct dimensions and color depth—in which
///            case the <b>LR_COPYDELETEORG</b> flag is ignored. If this flag is not specified, a new object is always created.
///            </td> </tr> <tr> <td width="40%"><a id="LR_CREATEDIBSECTION"></a><a id="lr_createdibsection"></a><dl>
///            <dt><b>LR_CREATEDIBSECTION</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> If this is set and a new
///            bitmap is created, the bitmap is created as a DIB section. Otherwise, the bitmap image is created as a
///            device-dependent bitmap. This flag is only valid if <i>uType</i> is <b>IMAGE_BITMAP</b>. </td> </tr> <tr> <td
///            width="40%"><a id="LR_DEFAULTSIZE"></a><a id="lr_defaultsize"></a><dl> <dt><b>LR_DEFAULTSIZE</b></dt>
///            <dt>0x00000040</dt> </dl> </td> <td width="60%"> Uses the width or height specified by the system metric values
///            for cursors or icons, if the <i>cxDesired</i> or <i>cyDesired</i> values are set to zero. If this flag is not
///            specified and <i>cxDesired</i> and <i>cyDesired</i> are set to zero, the function uses the actual resource size.
///            If the resource contains multiple images, the function uses the size of the first image. </td> </tr> <tr> <td
///            width="40%"><a id="LR_MONOCHROME"></a><a id="lr_monochrome"></a><dl> <dt><b>LR_MONOCHROME</b></dt>
///            <dt>0x00000001</dt> </dl> </td> <td width="60%"> Creates a new monochrome image. </td> </tr> </table>
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, the return value is the handle to the newly created image. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HANDLE CopyImage(HANDLE h, uint type, int cx, int cy, uint flags);

///Draws an icon or cursor into the specified device context, performing the specified raster operations, and stretching
///or compressing the icon or cursor as specified.
///Params:
///    hdc = Type: <b>HDC</b> A handle to the device context into which the icon or cursor will be drawn.
///    xLeft = Type: <b>int</b> The logical x-coordinate of the upper-left corner of the icon or cursor.
///    yTop = Type: <b>int</b> The logical y-coordinate of the upper-left corner of the icon or cursor.
///    hIcon = Type: <b>HICON</b> A handle to the icon or cursor to be drawn. This parameter can identify an animated cursor.
///    cxWidth = Type: <b>int</b> The logical width of the icon or cursor. If this parameter is zero and the <i>diFlags</i>
///              parameter is <b>DI_DEFAULTSIZE</b>, the function uses the <b>SM_CXICON</b> system metric value to set the width.
///              If this parameter is zero and <b>DI_DEFAULTSIZE</b> is not used, the function uses the actual resource width.
///    cyWidth = Type: <b>int</b> The logical height of the icon or cursor. If this parameter is zero and the <i>diFlags</i>
///              parameter is <b>DI_DEFAULTSIZE</b>, the function uses the <b>SM_CYICON</b> system metric value to set the width.
///              If this parameter is zero and <b>DI_DEFAULTSIZE</b> is not used, the function uses the actual resource height.
///    istepIfAniCur = Type: <b>UINT</b> The index of the frame to draw, if <i>hIcon</i> identifies an animated cursor. This parameter
///                    is ignored if <i>hIcon</i> does not identify an animated cursor.
///    hbrFlickerFreeDraw = Type: <b>HBRUSH</b> A handle to a brush that the system uses for flicker-free drawing. If
///                         <i>hbrFlickerFreeDraw</i> is a valid brush handle, the system creates an offscreen bitmap using the specified
///                         brush for the background color, draws the icon or cursor into the bitmap, and then copies the bitmap into the
///                         device context identified by <i>hdc</i>. If <i>hbrFlickerFreeDraw</i> is <b>NULL</b>, the system draws the icon
///                         or cursor directly into the device context.
///    diFlags = Type: <b>UINT</b> The drawing flags. This parameter can be one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DI_COMPAT"></a><a id="di_compat"></a><dl>
///              <dt><b>DI_COMPAT</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> This flag is ignored. </td> </tr> <tr> <td
///              width="40%"><a id="DI_DEFAULTSIZE"></a><a id="di_defaultsize"></a><dl> <dt><b>DI_DEFAULTSIZE</b></dt>
///              <dt>0x0008</dt> </dl> </td> <td width="60%"> Draws the icon or cursor using the width and height specified by the
///              system metric values for icons, if the <i>cxWidth</i> and <i>cyWidth</i> parameters are set to zero. If this flag
///              is not specified and <i>cxWidth</i> and <i>cyWidth</i> are set to zero, the function uses the actual resource
///              size. </td> </tr> <tr> <td width="40%"><a id="DI_IMAGE"></a><a id="di_image"></a><dl> <dt><b>DI_IMAGE</b></dt>
///              <dt>0x0002</dt> </dl> </td> <td width="60%"> Draws the icon or cursor using the image. </td> </tr> <tr> <td
///              width="40%"><a id="DI_MASK"></a><a id="di_mask"></a><dl> <dt><b>DI_MASK</b></dt> <dt>0x0001</dt> </dl> </td> <td
///              width="60%"> Draws the icon or cursor using the mask. </td> </tr> <tr> <td width="40%"><a id="DI_NOMIRROR"></a><a
///              id="di_nomirror"></a><dl> <dt><b>DI_NOMIRROR</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> Draws the icon
///              as an unmirrored icon. By default, the icon is drawn as a mirrored icon if <i>hdc</i> is mirrored. </td> </tr>
///              <tr> <td width="40%"><a id="DI_NORMAL"></a><a id="di_normal"></a><dl> <dt><b>DI_NORMAL</b></dt> <dt>0x0003</dt>
///              </dl> </td> <td width="60%"> Combination of <b>DI_IMAGE</b> and <b>DI_MASK</b>. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DrawIconEx(HDC hdc, int xLeft, int yTop, HICON hIcon, int cxWidth, int cyWidth, uint istepIfAniCur, 
                HBRUSH hbrFlickerFreeDraw, DI_FLAGS diFlags);

///Creates an icon or cursor from an ICONINFO structure.
///Params:
///    piconinfo = Type: <b>PICONINFO</b> A pointer to an ICONINFO structure the function uses to create the icon or cursor.
///Returns:
///    Type: <b>HICON</b> If the function succeeds, the return value is a handle to the icon or cursor that is created.
///    If the function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HICON CreateIconIndirect(ICONINFO* piconinfo);

///Copies the specified icon from another module to the current module.
///Params:
///    hIcon = Type: <b>HICON</b> A handle to the icon to be copied.
///Returns:
///    Type: <b>HICON</b> If the function succeeds, the return value is a handle to the duplicate icon. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HICON CopyIcon(HICON hIcon);

///Retrieves information about the specified icon or cursor.
///Params:
///    hIcon = Type: <b>HICON</b> A handle to the icon or cursor. To retrieve information about a standard icon or cursor,
///            specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="IDC_APPSTARTING"></a><a id="idc_appstarting"></a><dl> <dt><b>IDC_APPSTARTING</b></dt>
///            <dt>MAKEINTRESOURCE(32650)</dt> </dl> </td> <td width="60%"> Standard arrow and small hourglass cursor. </td>
///            </tr> <tr> <td width="40%"><a id="IDC_ARROW"></a><a id="idc_arrow"></a><dl> <dt><b>IDC_ARROW</b></dt>
///            <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Standard arrow cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_CROSS"></a><a id="idc_cross"></a><dl> <dt><b>IDC_CROSS</b></dt>
///            <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Crosshair cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_HAND"></a><a id="idc_hand"></a><dl> <dt><b>IDC_HAND</b></dt>
///            <dt>MAKEINTRESOURCE(32649)</dt> </dl> </td> <td width="60%"> Hand cursor. </td> </tr> <tr> <td width="40%"><a
///            id="IDC_HELP"></a><a id="idc_help"></a><dl> <dt><b>IDC_HELP</b></dt> <dt>MAKEINTRESOURCE(32651)</dt> </dl> </td>
///            <td width="60%"> Arrow and question mark cursor. </td> </tr> <tr> <td width="40%"><a id="IDC_IBEAM"></a><a
///            id="idc_ibeam"></a><dl> <dt><b>IDC_IBEAM</b></dt> <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%">
///            I-beam cursor. </td> </tr> <tr> <td width="40%"><a id="IDC_NO"></a><a id="idc_no"></a><dl> <dt><b>IDC_NO</b></dt>
///            <dt>MAKEINTRESOURCE(32648)</dt> </dl> </td> <td width="60%"> Slashed circle cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_SIZEALL"></a><a id="idc_sizeall"></a><dl> <dt><b>IDC_SIZEALL</b></dt>
///            <dt>MAKEINTRESOURCE(32646)</dt> </dl> </td> <td width="60%"> Four-pointed arrow cursor pointing north, south,
///            east, and west. </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENESW"></a><a id="idc_sizenesw"></a><dl>
///            <dt><b>IDC_SIZENESW</b></dt> <dt>MAKEINTRESOURCE(32643)</dt> </dl> </td> <td width="60%"> Double-pointed arrow
///            cursor pointing northeast and southwest. </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENS"></a><a
///            id="idc_sizens"></a><dl> <dt><b>IDC_SIZENS</b></dt> <dt>MAKEINTRESOURCE(32645)</dt> </dl> </td> <td width="60%">
///            Double-pointed arrow cursor pointing north and south. </td> </tr> <tr> <td width="40%"><a
///            id="IDC_SIZENWSE"></a><a id="idc_sizenwse"></a><dl> <dt><b>IDC_SIZENWSE</b></dt> <dt>MAKEINTRESOURCE(32642)</dt>
///            </dl> </td> <td width="60%"> Double-pointed arrow cursor pointing northwest and southeast. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_SIZEWE"></a><a id="idc_sizewe"></a><dl> <dt><b>IDC_SIZEWE</b></dt>
///            <dt>MAKEINTRESOURCE(32644)</dt> </dl> </td> <td width="60%"> Double-pointed arrow cursor pointing west and east.
///            </td> </tr> <tr> <td width="40%"><a id="IDC_UPARROW"></a><a id="idc_uparrow"></a><dl> <dt><b>IDC_UPARROW</b></dt>
///            <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Vertical arrow cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_WAIT"></a><a id="idc_wait"></a><dl> <dt><b>IDC_WAIT</b></dt>
///            <dt>MAKEINTRESOURCE(32514)</dt> </dl> </td> <td width="60%"> Hourglass cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_APPLICATION"></a><a id="idi_application"></a><dl> <dt><b>IDI_APPLICATION</b></dt>
///            <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Application icon. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_ASTERISK"></a><a id="idi_asterisk"></a><dl> <dt><b>IDI_ASTERISK</b></dt>
///            <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Asterisk icon. </td> </tr> <tr> <td width="40%"><a
///            id="IDI_EXCLAMATION"></a><a id="idi_exclamation"></a><dl> <dt><b>IDI_EXCLAMATION</b></dt>
///            <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Exclamation point icon. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_HAND"></a><a id="idi_hand"></a><dl> <dt><b>IDI_HAND</b></dt>
///            <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%"> Stop sign icon. </td> </tr> <tr> <td width="40%"><a
///            id="IDI_QUESTION"></a><a id="idi_question"></a><dl> <dt><b>IDI_QUESTION</b></dt> <dt>MAKEINTRESOURCE(32514)</dt>
///            </dl> </td> <td width="60%"> Question-mark icon. </td> </tr> <tr> <td width="40%"><a id="IDI_WINLOGO"></a><a
///            id="idi_winlogo"></a><dl> <dt><b>IDI_WINLOGO</b></dt> <dt>MAKEINTRESOURCE(32517)</dt> </dl> </td> <td
///            width="60%"> Application icon. <b>Windows 2000: </b>Windows logo icon. </td> </tr> </table>
///    piconinfo = Type: <b>PICONINFO</b> A pointer to an ICONINFO structure. The function fills in the structure's members.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero and the function fills in the members of
///    the specified ICONINFO structure. If the function fails, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetIconInfo(HICON hIcon, ICONINFO* piconinfo);

///Retrieves information about the specified icon or cursor. <b>GetIconInfoEx</b> extends GetIconInfo by using the newer
///ICONINFOEX structure.
///Params:
///    hicon = Type: <b>HICON</b> A handle to the icon or cursor. To retrieve information about a standard icon or cursor,
///            specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="IDC_APPSTARTING"></a><a id="idc_appstarting"></a><dl> <dt><b>IDC_APPSTARTING</b></dt>
///            <dt>MAKEINTRESOURCE(32650)</dt> </dl> </td> <td width="60%"> Standard arrow and small hourglass cursor. </td>
///            </tr> <tr> <td width="40%"><a id="IDC_ARROW"></a><a id="idc_arrow"></a><dl> <dt><b>IDC_ARROW</b></dt>
///            <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Standard arrow cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_CROSS"></a><a id="idc_cross"></a><dl> <dt><b>IDC_CROSS</b></dt>
///            <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Crosshair cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_HAND"></a><a id="idc_hand"></a><dl> <dt><b>IDC_HAND</b></dt>
///            <dt>MAKEINTRESOURCE(32649)</dt> </dl> </td> <td width="60%"> Hand cursor. </td> </tr> <tr> <td width="40%"><a
///            id="IDC_HELP"></a><a id="idc_help"></a><dl> <dt><b>IDC_HELP</b></dt> <dt>MAKEINTRESOURCE(32651)</dt> </dl> </td>
///            <td width="60%"> Arrow and question mark cursor. </td> </tr> <tr> <td width="40%"><a id="IDC_IBEAM"></a><a
///            id="idc_ibeam"></a><dl> <dt><b>IDC_IBEAM</b></dt> <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%">
///            I-beam cursor. </td> </tr> <tr> <td width="40%"><a id="IDC_NO"></a><a id="idc_no"></a><dl> <dt><b>IDC_NO</b></dt>
///            <dt>MAKEINTRESOURCE(32648)</dt> </dl> </td> <td width="60%"> Slashed circle cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_SIZEALL"></a><a id="idc_sizeall"></a><dl> <dt><b>IDC_SIZEALL</b></dt>
///            <dt>MAKEINTRESOURCE(32646)</dt> </dl> </td> <td width="60%"> Four-pointed arrow cursor pointing north, south,
///            east, and west. </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENESW"></a><a id="idc_sizenesw"></a><dl>
///            <dt><b>IDC_SIZENESW</b></dt> <dt>MAKEINTRESOURCE(32643)</dt> </dl> </td> <td width="60%"> Double-pointed arrow
///            cursor pointing northeast and southwest. </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENS"></a><a
///            id="idc_sizens"></a><dl> <dt><b>IDC_SIZENS</b></dt> <dt>MAKEINTRESOURCE(32645)</dt> </dl> </td> <td width="60%">
///            Double-pointed arrow cursor pointing north and south. </td> </tr> <tr> <td width="40%"><a
///            id="IDC_SIZENWSE"></a><a id="idc_sizenwse"></a><dl> <dt><b>IDC_SIZENWSE</b></dt> <dt>MAKEINTRESOURCE(32642)</dt>
///            </dl> </td> <td width="60%"> Double-pointed arrow cursor pointing northwest and southeast. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_SIZEWE"></a><a id="idc_sizewe"></a><dl> <dt><b>IDC_SIZEWE</b></dt>
///            <dt>MAKEINTRESOURCE(32644)</dt> </dl> </td> <td width="60%"> Double-pointed arrow cursor pointing west and east.
///            </td> </tr> <tr> <td width="40%"><a id="IDC_UPARROW"></a><a id="idc_uparrow"></a><dl> <dt><b>IDC_UPARROW</b></dt>
///            <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Vertical arrow cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_WAIT"></a><a id="idc_wait"></a><dl> <dt><b>IDC_WAIT</b></dt>
///            <dt>MAKEINTRESOURCE(32514)</dt> </dl> </td> <td width="60%"> Hourglass cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_APPLICATION"></a><a id="idi_application"></a><dl> <dt><b>IDI_APPLICATION</b></dt>
///            <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Application icon. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_ASTERISK"></a><a id="idi_asterisk"></a><dl> <dt><b>IDI_ASTERISK</b></dt>
///            <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Asterisk icon. </td> </tr> <tr> <td width="40%"><a
///            id="IDI_EXCLAMATION"></a><a id="idi_exclamation"></a><dl> <dt><b>IDI_EXCLAMATION</b></dt>
///            <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Exclamation point icon. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_HAND"></a><a id="idi_hand"></a><dl> <dt><b>IDI_HAND</b></dt>
///            <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%"> Stop sign icon. </td> </tr> <tr> <td width="40%"><a
///            id="IDI_QUESTION"></a><a id="idi_question"></a><dl> <dt><b>IDI_QUESTION</b></dt> <dt>MAKEINTRESOURCE(32514)</dt>
///            </dl> </td> <td width="60%"> Question-mark icon. </td> </tr> <tr> <td width="40%"><a id="IDI_WINLOGO"></a><a
///            id="idi_winlogo"></a><dl> <dt><b>IDI_WINLOGO</b></dt> <dt>MAKEINTRESOURCE(32517)</dt> </dl> </td> <td
///            width="60%"> Application icon. <b>Windows 2000: </b>Windows logo icon. </td> </tr> </table>
///    piconinfo = Type: <b>PICONINFOEX</b> When this method returns, contains a pointer to an ICONINFOEX structure. The function
///                fills in the structure's members.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> indicates success, <b>FALSE</b> indicates failure.
///    
@DllImport("USER32")
BOOL GetIconInfoExA(HICON hicon, ICONINFOEXA* piconinfo);

///Retrieves information about the specified icon or cursor. <b>GetIconInfoEx</b> extends GetIconInfo by using the newer
///ICONINFOEX structure.
///Params:
///    hicon = Type: <b>HICON</b> A handle to the icon or cursor. To retrieve information about a standard icon or cursor,
///            specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="IDC_APPSTARTING"></a><a id="idc_appstarting"></a><dl> <dt><b>IDC_APPSTARTING</b></dt>
///            <dt>MAKEINTRESOURCE(32650)</dt> </dl> </td> <td width="60%"> Standard arrow and small hourglass cursor. </td>
///            </tr> <tr> <td width="40%"><a id="IDC_ARROW"></a><a id="idc_arrow"></a><dl> <dt><b>IDC_ARROW</b></dt>
///            <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Standard arrow cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_CROSS"></a><a id="idc_cross"></a><dl> <dt><b>IDC_CROSS</b></dt>
///            <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Crosshair cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_HAND"></a><a id="idc_hand"></a><dl> <dt><b>IDC_HAND</b></dt>
///            <dt>MAKEINTRESOURCE(32649)</dt> </dl> </td> <td width="60%"> Hand cursor. </td> </tr> <tr> <td width="40%"><a
///            id="IDC_HELP"></a><a id="idc_help"></a><dl> <dt><b>IDC_HELP</b></dt> <dt>MAKEINTRESOURCE(32651)</dt> </dl> </td>
///            <td width="60%"> Arrow and question mark cursor. </td> </tr> <tr> <td width="40%"><a id="IDC_IBEAM"></a><a
///            id="idc_ibeam"></a><dl> <dt><b>IDC_IBEAM</b></dt> <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%">
///            I-beam cursor. </td> </tr> <tr> <td width="40%"><a id="IDC_NO"></a><a id="idc_no"></a><dl> <dt><b>IDC_NO</b></dt>
///            <dt>MAKEINTRESOURCE(32648)</dt> </dl> </td> <td width="60%"> Slashed circle cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_SIZEALL"></a><a id="idc_sizeall"></a><dl> <dt><b>IDC_SIZEALL</b></dt>
///            <dt>MAKEINTRESOURCE(32646)</dt> </dl> </td> <td width="60%"> Four-pointed arrow cursor pointing north, south,
///            east, and west. </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENESW"></a><a id="idc_sizenesw"></a><dl>
///            <dt><b>IDC_SIZENESW</b></dt> <dt>MAKEINTRESOURCE(32643)</dt> </dl> </td> <td width="60%"> Double-pointed arrow
///            cursor pointing northeast and southwest. </td> </tr> <tr> <td width="40%"><a id="IDC_SIZENS"></a><a
///            id="idc_sizens"></a><dl> <dt><b>IDC_SIZENS</b></dt> <dt>MAKEINTRESOURCE(32645)</dt> </dl> </td> <td width="60%">
///            Double-pointed arrow cursor pointing north and south. </td> </tr> <tr> <td width="40%"><a
///            id="IDC_SIZENWSE"></a><a id="idc_sizenwse"></a><dl> <dt><b>IDC_SIZENWSE</b></dt> <dt>MAKEINTRESOURCE(32642)</dt>
///            </dl> </td> <td width="60%"> Double-pointed arrow cursor pointing northwest and southeast. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_SIZEWE"></a><a id="idc_sizewe"></a><dl> <dt><b>IDC_SIZEWE</b></dt>
///            <dt>MAKEINTRESOURCE(32644)</dt> </dl> </td> <td width="60%"> Double-pointed arrow cursor pointing west and east.
///            </td> </tr> <tr> <td width="40%"><a id="IDC_UPARROW"></a><a id="idc_uparrow"></a><dl> <dt><b>IDC_UPARROW</b></dt>
///            <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Vertical arrow cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDC_WAIT"></a><a id="idc_wait"></a><dl> <dt><b>IDC_WAIT</b></dt>
///            <dt>MAKEINTRESOURCE(32514)</dt> </dl> </td> <td width="60%"> Hourglass cursor. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_APPLICATION"></a><a id="idi_application"></a><dl> <dt><b>IDI_APPLICATION</b></dt>
///            <dt>MAKEINTRESOURCE(32512)</dt> </dl> </td> <td width="60%"> Application icon. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_ASTERISK"></a><a id="idi_asterisk"></a><dl> <dt><b>IDI_ASTERISK</b></dt>
///            <dt>MAKEINTRESOURCE(32516)</dt> </dl> </td> <td width="60%"> Asterisk icon. </td> </tr> <tr> <td width="40%"><a
///            id="IDI_EXCLAMATION"></a><a id="idi_exclamation"></a><dl> <dt><b>IDI_EXCLAMATION</b></dt>
///            <dt>MAKEINTRESOURCE(32515)</dt> </dl> </td> <td width="60%"> Exclamation point icon. </td> </tr> <tr> <td
///            width="40%"><a id="IDI_HAND"></a><a id="idi_hand"></a><dl> <dt><b>IDI_HAND</b></dt>
///            <dt>MAKEINTRESOURCE(32513)</dt> </dl> </td> <td width="60%"> Stop sign icon. </td> </tr> <tr> <td width="40%"><a
///            id="IDI_QUESTION"></a><a id="idi_question"></a><dl> <dt><b>IDI_QUESTION</b></dt> <dt>MAKEINTRESOURCE(32514)</dt>
///            </dl> </td> <td width="60%"> Question-mark icon. </td> </tr> <tr> <td width="40%"><a id="IDI_WINLOGO"></a><a
///            id="idi_winlogo"></a><dl> <dt><b>IDI_WINLOGO</b></dt> <dt>MAKEINTRESOURCE(32517)</dt> </dl> </td> <td
///            width="60%"> Application icon. <b>Windows 2000: </b>Windows logo icon. </td> </tr> </table>
///    piconinfo = Type: <b>PICONINFOEX</b> When this method returns, contains a pointer to an ICONINFOEX structure. The function
///                fills in the structure's members.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> indicates success, <b>FALSE</b> indicates failure.
///    
@DllImport("USER32")
BOOL GetIconInfoExW(HICON hicon, ICONINFOEXW* piconinfo);

@DllImport("USER32")
void SetDebugErrorLevel(uint dwLevel);

@DllImport("USER32")
BOOL CancelShutdown();

@DllImport("USER32")
BOOL InheritWindowMonitor(HWND hwnd, HWND hwndInherit);

@DllImport("USER32")
ptrdiff_t GetDpiAwarenessContextForProcess(HANDLE hProcess);

///Retrieves information about the global cursor.
///Params:
///    pci = Type: <b>PCURSORINFO</b> A pointer to a CURSORINFO structure that receives the information. Note that you must
///          set the <b>cbSize</b> member to <code>sizeof(CURSORINFO)</code> before calling this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetCursorInfo(CURSORINFO* pci);

///Retrieves information about the specified menu bar.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window (menu bar) whose information is to be retrieved.
///    idObject = Type: <b>LONG</b> The menu object. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OBJID_CLIENT"></a><a id="objid_client"></a><dl>
///               <dt><b>OBJID_CLIENT</b></dt> <dt>((LONG)0xFFFFFFFC)</dt> </dl> </td> <td width="60%"> The popup menu associated
///               with the window. </td> </tr> <tr> <td width="40%"><a id="OBJID_MENU"></a><a id="objid_menu"></a><dl>
///               <dt><b>OBJID_MENU</b></dt> <dt>((LONG)0xFFFFFFFD)</dt> </dl> </td> <td width="60%"> The menu bar associated with
///               the window (see the GetMenu function). </td> </tr> <tr> <td width="40%"><a id="OBJID_SYSMENU"></a><a
///               id="objid_sysmenu"></a><dl> <dt><b>OBJID_SYSMENU</b></dt> <dt>((LONG)0xFFFFFFFF)</dt> </dl> </td> <td
///               width="60%"> The system menu associated with the window (see the GetSystemMenu function). </td> </tr> </table>
///    idItem = Type: <b>LONG</b> The item for which to retrieve information. If this parameter is zero, the function retrieves
///             information about the menu itself. If this parameter is 1, the function retrieves information about the first
///             item on the menu, and so on.
///    pmbi = Type: <b>PMENUBARINFO</b> A pointer to a MENUBARINFO structure that receives the information. Note that you must
///           set the <b>cbSize</b> member to <code>sizeof(MENUBARINFO)</code> before calling this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetMenuBarInfo(HWND hwnd, int idObject, int idItem, MENUBARINFO* pmbi);

@DllImport("USER32")
uint RealGetWindowClassA(HWND hwnd, PSTR ptszClassName, uint cchClassNameMax);

///Determines where to install a file based on whether it locates another version of the file in the system. The values
///<b>VerFindFile</b> returns in the specified buffers are used in a subsequent call to the VerInstallFile function.
///Params:
///    uFlags = Type: <b>DWORD</b> This parameter can be the following value. All other bits are reserved. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VFFF_ISSHAREDFILE"></a><a
///             id="vfff_issharedfile"></a><dl> <dt><b>VFFF_ISSHAREDFILE</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
///             The source file can be shared by multiple applications. An application can use this information to determine
///             where the file should be copied. </td> </tr> </table>
///    szFileName = Type: <b>LPCTSTR</b> The name of the file to be installed. Include only the file name and extension, not a path.
///    szWinDir = Type: <b>LPCTSTR</b> The directory in which Windows is running or will be run. This string is returned by the
///               GetWindowsDirectory function.
///    szAppDir = Type: <b>LPCTSTR</b> The directory where the installation program is installing a set of related files. If the
///               installation program is installing an application, this is the directory where the application will reside. This
///               parameter also points to the application's current directory unless otherwise specified.
///    szCurDir = Type: <b>LPWSTR</b> A buffer that receives the path to a current version of the file being installed. The path is
///               a zero-terminated string. If a current version is not installed, the buffer will contain a zero-length string.
///               The buffer should be at least <b>_MAX_PATH</b> characters long, although this is not required.
///    puCurDirLen = Type: <b>PUINT</b> The length of the <i>szCurDir</i> buffer. This pointer must not be <b>NULL</b>. When the
///                  function returns, <i>lpuCurDirLen</i> contains the size, in characters, of the data returned in <i>szCurDir</i>,
///                  including the terminating null character. If the buffer is too small to contain all the data, <i>lpuCurDirLen</i>
///                  will be the size of the buffer required to hold the path.
///    szDestDir = Type: <b>LPTSTR</b> A buffer that receives the path to the installation location recommended by
///                <b>VerFindFile</b>. The path is a zero-terminated string. The buffer should be at least <b>_MAX_PATH</b>
///                characters long, although this is not required.
///    puDestDirLen = Type: <b>PUINT</b> A pointer to a variable that specifies the length of the <i>szDestDir</i> buffer. This pointer
///                   must not be <b>NULL</b>. When the function returns, <i>lpuDestDirLen</i> contains the size, in characters, of the
///                   data returned in <i>szDestDir</i>, including the terminating null character. If the buffer is too small to
///                   contain all the data, <i>lpuDestDirLen</i> will be the size of the buffer needed to hold the path.
///Returns:
///    Type: <b>DWORD</b> The return value is a bitmask that indicates the status of the file. It can be one or more of
///    the following values. All other values are reserved. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>VFF_CURNEDEST</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> The
///    currently installed version of the file is not in the recommended destination. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>VFF_FILEINUSE</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> The system is using the currently
///    installed version of the file; therefore, the file cannot be overwritten or deleted. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VFF_BUFFTOOSMALL</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> At least one of
///    the buffers was too small to contain the corresponding string. An application should check the output buffers to
///    determine which buffer was too small. </td> </tr> </table>
///    
@DllImport("VERSION")
uint VerFindFileA(uint uFlags, const(PSTR) szFileName, const(PSTR) szWinDir, const(PSTR) szAppDir, PSTR szCurDir, 
                  uint* puCurDirLen, PSTR szDestDir, uint* puDestDirLen);

///Determines where to install a file based on whether it locates another version of the file in the system. The values
///<b>VerFindFile</b> returns in the specified buffers are used in a subsequent call to the VerInstallFile function.
///Params:
///    uFlags = Type: <b>DWORD</b> This parameter can be the following value. All other bits are reserved. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VFFF_ISSHAREDFILE"></a><a
///             id="vfff_issharedfile"></a><dl> <dt><b>VFFF_ISSHAREDFILE</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
///             The source file can be shared by multiple applications. An application can use this information to determine
///             where the file should be copied. </td> </tr> </table>
///    szFileName = Type: <b>LPCTSTR</b> The name of the file to be installed. Include only the file name and extension, not a path.
///    szWinDir = Type: <b>LPCTSTR</b> The directory in which Windows is running or will be run. This string is returned by the
///               GetWindowsDirectory function.
///    szAppDir = Type: <b>LPCTSTR</b> The directory where the installation program is installing a set of related files. If the
///               installation program is installing an application, this is the directory where the application will reside. This
///               parameter also points to the application's current directory unless otherwise specified.
///    szCurDir = Type: <b>LPWSTR</b> A buffer that receives the path to a current version of the file being installed. The path is
///               a zero-terminated string. If a current version is not installed, the buffer will contain a zero-length string.
///               The buffer should be at least <b>_MAX_PATH</b> characters long, although this is not required.
///    puCurDirLen = Type: <b>PUINT</b> The length of the <i>szCurDir</i> buffer. This pointer must not be <b>NULL</b>. When the
///                  function returns, <i>lpuCurDirLen</i> contains the size, in characters, of the data returned in <i>szCurDir</i>,
///                  including the terminating null character. If the buffer is too small to contain all the data, <i>lpuCurDirLen</i>
///                  will be the size of the buffer required to hold the path.
///    szDestDir = Type: <b>LPTSTR</b> A buffer that receives the path to the installation location recommended by
///                <b>VerFindFile</b>. The path is a zero-terminated string. The buffer should be at least <b>_MAX_PATH</b>
///                characters long, although this is not required.
///    puDestDirLen = Type: <b>PUINT</b> A pointer to a variable that specifies the length of the <i>szDestDir</i> buffer. This pointer
///                   must not be <b>NULL</b>. When the function returns, <i>lpuDestDirLen</i> contains the size, in characters, of the
///                   data returned in <i>szDestDir</i>, including the terminating null character. If the buffer is too small to
///                   contain all the data, <i>lpuDestDirLen</i> will be the size of the buffer needed to hold the path.
///Returns:
///    Type: <b>DWORD</b> The return value is a bitmask that indicates the status of the file. It can be one or more of
///    the following values. All other values are reserved. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>VFF_CURNEDEST</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> The
///    currently installed version of the file is not in the recommended destination. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>VFF_FILEINUSE</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> The system is using the currently
///    installed version of the file; therefore, the file cannot be overwritten or deleted. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VFF_BUFFTOOSMALL</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> At least one of
///    the buffers was too small to contain the corresponding string. An application should check the output buffers to
///    determine which buffer was too small. </td> </tr> </table>
///    
@DllImport("VERSION")
uint VerFindFileW(uint uFlags, const(PWSTR) szFileName, const(PWSTR) szWinDir, const(PWSTR) szAppDir, 
                  PWSTR szCurDir, uint* puCurDirLen, PWSTR szDestDir, uint* puDestDirLen);

///Installs the specified file based on information returned from the VerFindFile function. <b>VerInstallFile</b>
///decompresses the file, if necessary, assigns a unique filename, and checks for errors, such as outdated files.
///Params:
///    uFlags = Type: <b>DWORD</b> This parameter can be one of the following values. All other bits are reserved. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VIFF_FORCEINSTALL"></a><a
///             id="viff_forceinstall"></a><dl> <dt><b>VIFF_FORCEINSTALL</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
///             Installs the file regardless of mismatched version numbers. The function checks only for physical errors during
///             installation. </td> </tr> <tr> <td width="40%"><a id="VIFF_DONTDELETEOLD"></a><a id="viff_dontdeleteold"></a><dl>
///             <dt><b>VIFF_DONTDELETEOLD</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Installs the file without
///             deleting the previously installed file, if the previously installed file is not in the destination directory.
///             </td> </tr> </table>
///    szSrcFileName = Type: <b>LPCTSTR</b> The name of the file to be installed. This is the filename in the directory pointed to by
///                    the <i>szSrcDir</i> parameter; the filename can include only the filename and extension, not a path.
///    szDestFileName = Type: <b>LPCTSTR</b> The name <b>VerInstallFile</b> will give the new file upon installation. This file name may
///                     be different from the filename in the <i>szSrcFileName</i> directory. The new name should include only the file
///                     name and extension, not a path.
///    szSrcDir = Type: <b>LPCTSTR</b> The name of the directory where the file can be found.
///    szDestDir = Type: <b>LPCTSTR</b> The name of the directory where the file should be installed. VerFindFile returns this value
///                in its <i>szDestDir</i> parameter.
///    szCurDir = Type: <b>LPCTSTR</b> The name of the directory where a preexisting version of this file can be found. VerFindFile
///               returns this value in its <i>szCurDir</i> parameter.
///    szTmpFile = Type: <b>LPTSTR</b> The name of a temporary copy of the source file. The buffer should be at least
///                <b>_MAX_PATH</b> characters long, although this is not required, and should be empty on input.
///    puTmpFileLen = Type: <b>PUINT</b> The length of the <i>szTmpFile</i> buffer. This pointer must not be <b>NULL</b>. When the
///                   function returns, <i>lpuTmpFileLen</i> receives the size, in characters, of the data returned in
///                   <i>szTmpFile</i>, including the terminating null character. If the buffer is too small to contain all the data,
///                   <i>lpuTmpFileLen</i> will be the size of the buffer required to hold the data.
///Returns:
///    Type: <b>DWORD</b> The return value is a bitmask that indicates exceptions. It can be one or more of the
///    following values. All other values are reserved. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_ACCESSVIOLATION</b></dt> <dt>0x00000200L</dt> </dl> </td> <td
///    width="60%"> A read, create, delete, or rename operation failed due to an access violation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_BUFFTOOSMALL</b></dt> <dt>0x00040000L</dt> </dl> </td> <td width="60%"> The
///    <i>szTmpFile</i> buffer was too small to contain the name of the temporary source file. When the function
///    returns, <i>lpuTmpFileLen</i> contains the size of the buffer required to hold the filename. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_CANNOTCREATE</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%"> The function
///    cannot create the temporary file. The specific error may be described by another flag. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_CANNOTDELETE</b></dt> <dt>0x00001000L</dt> </dl> </td> <td width="60%"> The function
///    cannot delete the destination file, or cannot delete the existing version of the file located in another
///    directory. If the <b>VIF_TEMPFILE</b> bit is set, the installation failed, and the destination file probably
///    cannot be deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_CANNOTDELETECUR</b></dt>
///    <dt>0x00004000L</dt> </dl> </td> <td width="60%"> The existing version of the file could not be deleted and
///    <b>VIFF_DONTDELETEOLD</b> was not specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_CANNOTLOADCABINET</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> The function cannot load
///    the cabinet file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_CANNOTLOADLZ32</b></dt> <dt>0x00080000L</dt>
///    </dl> </td> <td width="60%"> The function cannot load the compressed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_CANNOTREADDST</b></dt> <dt>0x00020000L</dt> </dl> </td> <td width="60%"> The function cannot read the
///    destination (existing) files. This prevents the function from examining the file's attributes. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>VIF_CANNOTREADSRC</b></dt> <dt>0x00010000L</dt> </dl> </td> <td width="60%"> The
///    function cannot read the source file. This could mean that the path was not specified properly. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>VIF_CANNOTRENAME</b></dt> <dt>0x00002000L</dt> </dl> </td> <td width="60%"> The
///    function cannot rename the temporary file, but already deleted the destination file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_DIFFCODEPG</b></dt> <dt>0x00000010L</dt> </dl> </td> <td width="60%"> The new file
///    requires a code page that cannot be displayed by the version of the system currently running. This error can be
///    overridden by calling VerInstallFile with the <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_DIFFLANG</b></dt> <dt>0x00000008L</dt> </dl> </td> <td width="60%"> The new and
///    preexisting files have different language or code-page values. This error can be overridden by calling
///    VerInstallFile again with the <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_DIFFTYPE</b></dt> <dt>0x00000020L</dt> </dl> </td> <td width="60%"> The new file has a different type,
///    subtype, or operating system from the preexisting file. This error can be overridden by calling VerInstallFile
///    again with the <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_FILEINUSE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td width="60%"> The preexisting file is in use by
///    the system and cannot be deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_MISMATCH</b></dt>
///    <dt>0x00000002L</dt> </dl> </td> <td width="60%"> The new and preexisting files differ in one or more attributes.
///    This error can be overridden by calling VerInstallFile again with the <b>VIFF_FORCEINSTALL</b> flag set. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_OUTOFMEMORY</b></dt> <dt>0x00008000L</dt> </dl> </td> <td
///    width="60%"> The function cannot complete the requested operation due to insufficient memory. Generally, this
///    means the application ran out of memory attempting to expand a compressed file. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>VIF_OUTOFSPACE</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> The function cannot create
///    the temporary file due to insufficient disk space on the destination drive. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>VIF_SHARINGVIOLATION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%"> A read, create,
///    delete, or rename operation failed due to a sharing violation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_SRCOLD</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> The file to install is older than
///    the preexisting file. This error can be overridden by calling VerInstallFile again with the
///    <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_TEMPFILE</b></dt>
///    <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The temporary copy of the new file is in the destination
///    directory. The cause of failure is reflected in other flags. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_WRITEPROT</b></dt> <dt>0x00000040L</dt> </dl> </td> <td width="60%"> The preexisting file is
///    write-protected. This error can be overridden by calling VerInstallFile again with the <b>VIFF_FORCEINSTALL</b>
///    flag set. </td> </tr> </table>
///    
@DllImport("VERSION")
uint VerInstallFileA(uint uFlags, const(PSTR) szSrcFileName, const(PSTR) szDestFileName, const(PSTR) szSrcDir, 
                     const(PSTR) szDestDir, const(PSTR) szCurDir, PSTR szTmpFile, uint* puTmpFileLen);

///Installs the specified file based on information returned from the VerFindFile function. <b>VerInstallFile</b>
///decompresses the file, if necessary, assigns a unique filename, and checks for errors, such as outdated files.
///Params:
///    uFlags = Type: <b>DWORD</b> This parameter can be one of the following values. All other bits are reserved. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VIFF_FORCEINSTALL"></a><a
///             id="viff_forceinstall"></a><dl> <dt><b>VIFF_FORCEINSTALL</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
///             Installs the file regardless of mismatched version numbers. The function checks only for physical errors during
///             installation. </td> </tr> <tr> <td width="40%"><a id="VIFF_DONTDELETEOLD"></a><a id="viff_dontdeleteold"></a><dl>
///             <dt><b>VIFF_DONTDELETEOLD</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Installs the file without
///             deleting the previously installed file, if the previously installed file is not in the destination directory.
///             </td> </tr> </table>
///    szSrcFileName = Type: <b>LPCTSTR</b> The name of the file to be installed. This is the filename in the directory pointed to by
///                    the <i>szSrcDir</i> parameter; the filename can include only the filename and extension, not a path.
///    szDestFileName = Type: <b>LPCTSTR</b> The name <b>VerInstallFile</b> will give the new file upon installation. This file name may
///                     be different from the filename in the <i>szSrcFileName</i> directory. The new name should include only the file
///                     name and extension, not a path.
///    szSrcDir = Type: <b>LPCTSTR</b> The name of the directory where the file can be found.
///    szDestDir = Type: <b>LPCTSTR</b> The name of the directory where the file should be installed. VerFindFile returns this value
///                in its <i>szDestDir</i> parameter.
///    szCurDir = Type: <b>LPCTSTR</b> The name of the directory where a preexisting version of this file can be found. VerFindFile
///               returns this value in its <i>szCurDir</i> parameter.
///    szTmpFile = Type: <b>LPTSTR</b> The name of a temporary copy of the source file. The buffer should be at least
///                <b>_MAX_PATH</b> characters long, although this is not required, and should be empty on input.
///    puTmpFileLen = Type: <b>PUINT</b> The length of the <i>szTmpFile</i> buffer. This pointer must not be <b>NULL</b>. When the
///                   function returns, <i>lpuTmpFileLen</i> receives the size, in characters, of the data returned in
///                   <i>szTmpFile</i>, including the terminating null character. If the buffer is too small to contain all the data,
///                   <i>lpuTmpFileLen</i> will be the size of the buffer required to hold the data.
///Returns:
///    Type: <b>DWORD</b> The return value is a bitmask that indicates exceptions. It can be one or more of the
///    following values. All other values are reserved. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_ACCESSVIOLATION</b></dt> <dt>0x00000200L</dt> </dl> </td> <td
///    width="60%"> A read, create, delete, or rename operation failed due to an access violation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_BUFFTOOSMALL</b></dt> <dt>0x00040000L</dt> </dl> </td> <td width="60%"> The
///    <i>szTmpFile</i> buffer was too small to contain the name of the temporary source file. When the function
///    returns, <i>lpuTmpFileLen</i> contains the size of the buffer required to hold the filename. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_CANNOTCREATE</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%"> The function
///    cannot create the temporary file. The specific error may be described by another flag. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_CANNOTDELETE</b></dt> <dt>0x00001000L</dt> </dl> </td> <td width="60%"> The function
///    cannot delete the destination file, or cannot delete the existing version of the file located in another
///    directory. If the <b>VIF_TEMPFILE</b> bit is set, the installation failed, and the destination file probably
///    cannot be deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_CANNOTDELETECUR</b></dt>
///    <dt>0x00004000L</dt> </dl> </td> <td width="60%"> The existing version of the file could not be deleted and
///    <b>VIFF_DONTDELETEOLD</b> was not specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_CANNOTLOADCABINET</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> The function cannot load
///    the cabinet file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_CANNOTLOADLZ32</b></dt> <dt>0x00080000L</dt>
///    </dl> </td> <td width="60%"> The function cannot load the compressed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_CANNOTREADDST</b></dt> <dt>0x00020000L</dt> </dl> </td> <td width="60%"> The function cannot read the
///    destination (existing) files. This prevents the function from examining the file's attributes. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>VIF_CANNOTREADSRC</b></dt> <dt>0x00010000L</dt> </dl> </td> <td width="60%"> The
///    function cannot read the source file. This could mean that the path was not specified properly. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>VIF_CANNOTRENAME</b></dt> <dt>0x00002000L</dt> </dl> </td> <td width="60%"> The
///    function cannot rename the temporary file, but already deleted the destination file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_DIFFCODEPG</b></dt> <dt>0x00000010L</dt> </dl> </td> <td width="60%"> The new file
///    requires a code page that cannot be displayed by the version of the system currently running. This error can be
///    overridden by calling VerInstallFile with the <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VIF_DIFFLANG</b></dt> <dt>0x00000008L</dt> </dl> </td> <td width="60%"> The new and
///    preexisting files have different language or code-page values. This error can be overridden by calling
///    VerInstallFile again with the <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_DIFFTYPE</b></dt> <dt>0x00000020L</dt> </dl> </td> <td width="60%"> The new file has a different type,
///    subtype, or operating system from the preexisting file. This error can be overridden by calling VerInstallFile
///    again with the <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_FILEINUSE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td width="60%"> The preexisting file is in use by
///    the system and cannot be deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_MISMATCH</b></dt>
///    <dt>0x00000002L</dt> </dl> </td> <td width="60%"> The new and preexisting files differ in one or more attributes.
///    This error can be overridden by calling VerInstallFile again with the <b>VIFF_FORCEINSTALL</b> flag set. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_OUTOFMEMORY</b></dt> <dt>0x00008000L</dt> </dl> </td> <td
///    width="60%"> The function cannot complete the requested operation due to insufficient memory. Generally, this
///    means the application ran out of memory attempting to expand a compressed file. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>VIF_OUTOFSPACE</b></dt> <dt>0x00000100L</dt> </dl> </td> <td width="60%"> The function cannot create
///    the temporary file due to insufficient disk space on the destination drive. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>VIF_SHARINGVIOLATION</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%"> A read, create,
///    delete, or rename operation failed due to a sharing violation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_SRCOLD</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> The file to install is older than
///    the preexisting file. This error can be overridden by calling VerInstallFile again with the
///    <b>VIFF_FORCEINSTALL</b> flag set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VIF_TEMPFILE</b></dt>
///    <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The temporary copy of the new file is in the destination
///    directory. The cause of failure is reflected in other flags. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>VIF_WRITEPROT</b></dt> <dt>0x00000040L</dt> </dl> </td> <td width="60%"> The preexisting file is
///    write-protected. This error can be overridden by calling VerInstallFile again with the <b>VIFF_FORCEINSTALL</b>
///    flag set. </td> </tr> </table>
///    
@DllImport("VERSION")
uint VerInstallFileW(uint uFlags, const(PWSTR) szSrcFileName, const(PWSTR) szDestFileName, const(PWSTR) szSrcDir, 
                     const(PWSTR) szDestDir, const(PWSTR) szCurDir, PWSTR szTmpFile, uint* puTmpFileLen);

///Determines whether the operating system can retrieve version information for a specified file. If version information
///is available, <b>GetFileVersionInfoSize</b> returns the size, in bytes, of that information.
///Params:
///    lptstrFilename = Type: <b>LPCTSTR</b> The name of the file of interest. The function uses the search sequence specified by the
///                     LoadLibrary function.
///    lpdwHandle = Type: <b>LPDWORD</b> A pointer to a variable that the function sets to zero.
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the size, in bytes, of the file's version
///    information. If the function fails, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("VERSION")
uint GetFileVersionInfoSizeA(const(PSTR) lptstrFilename, uint* lpdwHandle);

///Determines whether the operating system can retrieve version information for a specified file. If version information
///is available, <b>GetFileVersionInfoSize</b> returns the size, in bytes, of that information.
///Params:
///    lptstrFilename = Type: <b>LPCTSTR</b> The name of the file of interest. The function uses the search sequence specified by the
///                     LoadLibrary function.
///    lpdwHandle = Type: <b>LPDWORD</b> A pointer to a variable that the function sets to zero.
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the size, in bytes, of the file's version
///    information. If the function fails, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("VERSION")
uint GetFileVersionInfoSizeW(const(PWSTR) lptstrFilename, uint* lpdwHandle);

///Retrieves version information for the specified file.
///Params:
///    lptstrFilename = Type: <b>LPCTSTR</b> The name of the file. If a full path is not specified, the function uses the search sequence
///                     specified by the LoadLibrary function.
///    dwHandle = Type: <b>DWORD</b> This parameter is ignored.
///    dwLen = Type: <b>DWORD</b> The size, in bytes, of the buffer pointed to by the <i>lpData</i> parameter. Call the
///            GetFileVersionInfoSize function first to determine the size, in bytes, of a file's version information. The
///            <i>dwLen</i> member should be equal to or greater than that value. If the buffer pointed to by <i>lpData</i> is
///            not large enough, the function truncates the file's version information to the size of the buffer.
///    lpData = Type: <b>LPVOID</b> Pointer to a buffer that receives the file-version information. You can use this value in a
///             subsequent call to the VerQueryValue function to retrieve data from the buffer.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("VERSION")
BOOL GetFileVersionInfoA(const(PSTR) lptstrFilename, uint dwHandle, uint dwLen, void* lpData);

///Retrieves version information for the specified file.
///Params:
///    lptstrFilename = Type: <b>LPCTSTR</b> The name of the file. If a full path is not specified, the function uses the search sequence
///                     specified by the LoadLibrary function.
///    dwHandle = Type: <b>DWORD</b> This parameter is ignored.
///    dwLen = Type: <b>DWORD</b> The size, in bytes, of the buffer pointed to by the <i>lpData</i> parameter. Call the
///            GetFileVersionInfoSize function first to determine the size, in bytes, of a file's version information. The
///            <i>dwLen</i> member should be equal to or greater than that value. If the buffer pointed to by <i>lpData</i> is
///            not large enough, the function truncates the file's version information to the size of the buffer.
///    lpData = Type: <b>LPVOID</b> Pointer to a buffer that receives the file-version information. You can use this value in a
///             subsequent call to the VerQueryValue function to retrieve data from the buffer.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("VERSION")
BOOL GetFileVersionInfoW(const(PWSTR) lptstrFilename, uint dwHandle, uint dwLen, void* lpData);

///Determines whether the operating system can retrieve version information for a specified file. If version information
///is available, <b>GetFileVersionInfoSizeEx</b> returns the size, in bytes, of that information.
///Params:
///    dwFlags = Type: <b>DWORD</b> Controls which MUI DLLs (if any) from which the version resource is extracted. Zero or more of
///              the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="FILE_VER_GET_LOCALISED"></a><a id="file_ver_get_localised"></a><dl> <dt><b>FILE_VER_GET_LOCALISED</b></dt>
///              <dt>0x01</dt> </dl> </td> <td width="60%"> Loads the entire version resource (both strings and binary version
///              information) from the corresponding MUI file, if available. </td> </tr> <tr> <td width="40%"><a
///              id="FILE_VER_GET_NEUTRAL"></a><a id="file_ver_get_neutral"></a><dl> <dt><b>FILE_VER_GET_NEUTRAL</b></dt>
///              <dt>0x002</dt> </dl> </td> <td width="60%"> Loads the version resource strings from the corresponding MUI file,
///              if available, and loads the binary version information (<b>VS_FIXEDFILEINFO</b>) from the corresponding
///              language-neutral file, if available. </td> </tr> </table>
///    lpwstrFilename = Type: <b>LPCTSTR</b> The name of the file of interest. The function uses the search sequence specified by the
///                     LoadLibrary function.
///    lpdwHandle = Type: <b>LPDWORD</b> When this function returns, contains a pointer to a variable that is set to zero because
///                 this function sets it to zero. This parameter exists for historical reasons.
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the size, in bytes, of the file's version
///    information. If the function fails, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("VERSION")
uint GetFileVersionInfoSizeExA(uint dwFlags, const(PSTR) lpwstrFilename, uint* lpdwHandle);

///Determines whether the operating system can retrieve version information for a specified file. If version information
///is available, <b>GetFileVersionInfoSizeEx</b> returns the size, in bytes, of that information.
///Params:
///    dwFlags = Type: <b>DWORD</b> Controls which MUI DLLs (if any) from which the version resource is extracted. Zero or more of
///              the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="FILE_VER_GET_LOCALISED"></a><a id="file_ver_get_localised"></a><dl> <dt><b>FILE_VER_GET_LOCALISED</b></dt>
///              <dt>0x01</dt> </dl> </td> <td width="60%"> Loads the entire version resource (both strings and binary version
///              information) from the corresponding MUI file, if available. </td> </tr> <tr> <td width="40%"><a
///              id="FILE_VER_GET_NEUTRAL"></a><a id="file_ver_get_neutral"></a><dl> <dt><b>FILE_VER_GET_NEUTRAL</b></dt>
///              <dt>0x002</dt> </dl> </td> <td width="60%"> Loads the version resource strings from the corresponding MUI file,
///              if available, and loads the binary version information (<b>VS_FIXEDFILEINFO</b>) from the corresponding
///              language-neutral file, if available. </td> </tr> </table>
///    lpwstrFilename = Type: <b>LPCTSTR</b> The name of the file of interest. The function uses the search sequence specified by the
///                     LoadLibrary function.
///    lpdwHandle = Type: <b>LPDWORD</b> When this function returns, contains a pointer to a variable that is set to zero because
///                 this function sets it to zero. This parameter exists for historical reasons.
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the size, in bytes, of the file's version
///    information. If the function fails, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("VERSION")
uint GetFileVersionInfoSizeExW(uint dwFlags, const(PWSTR) lpwstrFilename, uint* lpdwHandle);

///Retrieves version information for the specified file.
///Params:
///    dwFlags = Type: <b>DWORD</b> Controls the MUI DLLs (if any) from which the version resource is extracted. The value of this
///              flag must match the flags passed to the corresponding GetFileVersionInfoSizeEx call, which was used to determine
///              the buffer size that is passed in the <i>dwLen</i> parameter. Zero or more of the following flags. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FILE_VER_GET_LOCALISED"></a><a
///              id="file_ver_get_localised"></a><dl> <dt><b>FILE_VER_GET_LOCALISED</b></dt> <dt>0x01</dt> </dl> </td> <td
///              width="60%"> Loads the entire version resource (both strings and binary version information) from the
///              corresponding MUI file, if available. </td> </tr> <tr> <td width="40%"><a id="FILE_VER_GET_NEUTRAL"></a><a
///              id="file_ver_get_neutral"></a><dl> <dt><b>FILE_VER_GET_NEUTRAL</b></dt> <dt>0x02</dt> </dl> </td> <td
///              width="60%"> Loads the version resource strings from the corresponding MUI file, if available, and loads the
///              binary version information (<b>VS_FIXEDFILEINFO</b>) from the corresponding language-neutral file, if available.
///              </td> </tr> <tr> <td width="40%"><a id="FILE_VER_GET_PREFETCHED"></a><a id="file_ver_get_prefetched"></a><dl>
///              <dt><b>FILE_VER_GET_PREFETCHED</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> Indicates a preference for
///              version.dll to attempt to preload the image outside of the loader lock to avoid contention. This flag does not
///              change the behavior or semantics of the function. </td> </tr> </table>
///    lpwstrFilename = Type: <b>LPCTSTR</b> The name of the file. If a full path is not specified, the function uses the search sequence
///                     specified by the LoadLibrary function.
///    dwHandle = Type: <b>DWORD</b> This parameter is ignored.
///    dwLen = Type: <b>DWORD</b> The size, in bytes, of the buffer pointed to by the <i>lpData</i> parameter. Call the
///            GetFileVersionInfoSizeEx function first to determine the size, in bytes, of a file's version information. The
///            <i>dwLen</i> parameter should be equal to or greater than that value. If the buffer pointed to by <i>lpData</i>
///            is not large enough, the function truncates the file's version information to the size of the buffer.
///    lpData = Type: <b>LPVOID</b> When this function returns, contains a pointer to a buffer that contains the file-version
///             information. You can use this value in a subsequent call to the VerQueryValue function to retrieve data from the
///             buffer.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("VERSION")
BOOL GetFileVersionInfoExA(uint dwFlags, const(PSTR) lpwstrFilename, uint dwHandle, uint dwLen, void* lpData);

///Retrieves version information for the specified file.
///Params:
///    dwFlags = Type: <b>DWORD</b> Controls the MUI DLLs (if any) from which the version resource is extracted. The value of this
///              flag must match the flags passed to the corresponding GetFileVersionInfoSizeEx call, which was used to determine
///              the buffer size that is passed in the <i>dwLen</i> parameter. Zero or more of the following flags. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FILE_VER_GET_LOCALISED"></a><a
///              id="file_ver_get_localised"></a><dl> <dt><b>FILE_VER_GET_LOCALISED</b></dt> <dt>0x01</dt> </dl> </td> <td
///              width="60%"> Loads the entire version resource (both strings and binary version information) from the
///              corresponding MUI file, if available. </td> </tr> <tr> <td width="40%"><a id="FILE_VER_GET_NEUTRAL"></a><a
///              id="file_ver_get_neutral"></a><dl> <dt><b>FILE_VER_GET_NEUTRAL</b></dt> <dt>0x02</dt> </dl> </td> <td
///              width="60%"> Loads the version resource strings from the corresponding MUI file, if available, and loads the
///              binary version information (<b>VS_FIXEDFILEINFO</b>) from the corresponding language-neutral file, if available.
///              </td> </tr> <tr> <td width="40%"><a id="FILE_VER_GET_PREFETCHED"></a><a id="file_ver_get_prefetched"></a><dl>
///              <dt><b>FILE_VER_GET_PREFETCHED</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> Indicates a preference for
///              version.dll to attempt to preload the image outside of the loader lock to avoid contention. This flag does not
///              change the behavior or semantics of the function. </td> </tr> </table>
///    lpwstrFilename = Type: <b>LPCTSTR</b> The name of the file. If a full path is not specified, the function uses the search sequence
///                     specified by the LoadLibrary function.
///    dwHandle = Type: <b>DWORD</b> This parameter is ignored.
///    dwLen = Type: <b>DWORD</b> The size, in bytes, of the buffer pointed to by the <i>lpData</i> parameter. Call the
///            GetFileVersionInfoSizeEx function first to determine the size, in bytes, of a file's version information. The
///            <i>dwLen</i> parameter should be equal to or greater than that value. If the buffer pointed to by <i>lpData</i>
///            is not large enough, the function truncates the file's version information to the size of the buffer.
///    lpData = Type: <b>LPVOID</b> When this function returns, contains a pointer to a buffer that contains the file-version
///             information. You can use this value in a subsequent call to the VerQueryValue function to retrieve data from the
///             buffer.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("VERSION")
BOOL GetFileVersionInfoExW(uint dwFlags, const(PWSTR) lpwstrFilename, uint dwHandle, uint dwLen, void* lpData);

///Retrieves a description string for the language associated with a specified binary Microsoft language identifier.
///Params:
///    wLang = Type: <b>DWORD</b> The binary language identifier. For a complete list of the language identifiers, see Language
///            Identifiers. For example, the description string associated with the language identifier 0x040A is "Spanish
///            (Traditional Sort)". If the identifier is unknown, the <i>szLang</i> parameter points to a default string
///            ("Language Neutral").
///    szLang = Type: <b>LPTSTR</b> The language specified by the <i>wLang</i> parameter.
///    cchLang = Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <i>szLang</i>.
///Returns:
///    Type: <b>DWORD</b> The return value is the size, in characters, of the string returned in the buffer. This value
///    does not include the terminating null character. If the description string is smaller than or equal to the
///    buffer, the entire description string is in the buffer. If the description string is larger than the buffer, the
///    description string is truncated to the length of the buffer. If an error occurs, the return value is zero.
///    Unknown language identifiers do not produce errors.
///    
@DllImport("KERNEL32")
uint VerLanguageNameA(uint wLang, PSTR szLang, uint cchLang);

///Retrieves a description string for the language associated with a specified binary Microsoft language identifier.
///Params:
///    wLang = Type: <b>DWORD</b> The binary language identifier. For a complete list of the language identifiers, see Language
///            Identifiers. For example, the description string associated with the language identifier 0x040A is "Spanish
///            (Traditional Sort)". If the identifier is unknown, the <i>szLang</i> parameter points to a default string
///            ("Language Neutral").
///    szLang = Type: <b>LPTSTR</b> The language specified by the <i>wLang</i> parameter.
///    cchLang = Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <i>szLang</i>.
///Returns:
///    Type: <b>DWORD</b> The return value is the size, in characters, of the string returned in the buffer. This value
///    does not include the terminating null character. If the description string is smaller than or equal to the
///    buffer, the entire description string is in the buffer. If the description string is larger than the buffer, the
///    description string is truncated to the length of the buffer. If an error occurs, the return value is zero.
///    Unknown language identifiers do not produce errors.
///    
@DllImport("KERNEL32")
uint VerLanguageNameW(uint wLang, PWSTR szLang, uint cchLang);

///Retrieves specified version information from the specified version-information resource. To retrieve the appropriate
///resource, before you call <b>VerQueryValue</b>, you must first call the GetFileVersionInfoSize function, and then the
///GetFileVersionInfo function.
///Params:
///    pBlock = Type: <b>LPCVOID</b> The version-information resource returned by the GetFileVersionInfo function.
///    lpSubBlock = Type: <b>LPCTSTR</b> The version-information value to be retrieved. The string must consist of names separated by
///                 backslashes (\\) and it must have one of the following forms.
///    lplpBuffer = Type: <b>LPVOID*</b> When this method returns, contains the address of a pointer to the requested version
///                 information in the buffer pointed to by <i>pBlock</i>. The memory pointed to by <i>lplpBuffer</i> is freed when
///                 the associated <i>pBlock</i> memory is freed.
///    puLen = Type: <b>PUINT</b> When this method returns, contains a pointer to the size of the requested data pointed to by
///            <i>lplpBuffer</i>: for version information values, the length in characters of the string stored at
///            <i>lplpBuffer</i>; for translation array values, the size in bytes of the array stored at <i>lplpBuffer</i>; and
///            for root block, the size in bytes of the structure.
///Returns:
///    Type: <b>BOOL</b> If the specified version-information structure exists, and version information is available,
///    the return value is nonzero. If the address of the length buffer is zero, no value is available for the specified
///    version-information name. If the specified name does not exist or the specified resource is not valid, the return
///    value is zero.
///    
@DllImport("VERSION")
BOOL VerQueryValueA(const(void)* pBlock, const(PSTR) lpSubBlock, void** lplpBuffer, uint* puLen);

///Retrieves specified version information from the specified version-information resource. To retrieve the appropriate
///resource, before you call <b>VerQueryValue</b>, you must first call the GetFileVersionInfoSize function, and then the
///GetFileVersionInfo function.
///Params:
///    pBlock = Type: <b>LPCVOID</b> The version-information resource returned by the GetFileVersionInfo function.
///    lpSubBlock = Type: <b>LPCTSTR</b> The version-information value to be retrieved. The string must consist of names separated by
///                 backslashes (\\) and it must have one of the following forms.
///    lplpBuffer = Type: <b>LPVOID*</b> When this method returns, contains the address of a pointer to the requested version
///                 information in the buffer pointed to by <i>pBlock</i>. The memory pointed to by <i>lplpBuffer</i> is freed when
///                 the associated <i>pBlock</i> memory is freed.
///    puLen = Type: <b>PUINT</b> When this method returns, contains a pointer to the size of the requested data pointed to by
///            <i>lplpBuffer</i>: for version information values, the length in characters of the string stored at
///            <i>lplpBuffer</i>; for translation array values, the size in bytes of the array stored at <i>lplpBuffer</i>; and
///            for root block, the size in bytes of the structure.
///Returns:
///    Type: <b>BOOL</b> If the specified version-information structure exists, and version information is available,
///    the return value is nonzero. If the address of the length buffer is zero, no value is available for the specified
///    version-information name. If the specified name does not exist or the specified resource is not valid, the return
///    value is zero.
///    
@DllImport("VERSION")
BOOL VerQueryValueW(const(void)* pBlock, const(PWSTR) lpSubBlock, void** lplpBuffer, uint* puLen);

///Creates a new resource indexer for the specified paths of the root of the project files and the extension DLL.
///Params:
///    projectRoot = The path of the root folder to use for the project for the files to be produced, in string form. This path is
///                  used to determine file paths relative to the package that contains them. This path must be an absolute path with
///                  the drive letter specified. Long file paths are not supported.
///    extensionDllPath = The full path to an extension dynamic-link library (DLL) that is Microsoft-signed and implements the
///                       ext-ms-win-mrmcorer-environment-l1 API set. This path determines the file path from where the extension DLL for
///                       the modern resource technology (MRT) environment is loaded. This path must be an absolute path with the drive
///                       letter specified. Long file paths are not supported.
///    ppResourceIndexer = The newly created resource indexer.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("MrmSupport")
HRESULT CreateResourceIndexer(const(PWSTR) projectRoot, const(PWSTR) extensionDllPath, void** ppResourceIndexer);

///Frees the computational resources associated with the specified resource indexer.
///Params:
///    resourceIndexer = The resource indexer for which you want to free the computational resources.
@DllImport("MrmSupport")
void DestroyResourceIndexer(void* resourceIndexer);

///Indexes a file path for file and folder naming conventions.
///Params:
///    resourceIndexer = The resource indexer object that you created by calling the CreateResourceIndexer function.
///    filePath = The path for the folder that you want to index. The path must be an absolute path with the drive letter
///               specified. Long file paths are not supported.
///    ppResourceUri = A uniform resource indicator (URI) that uses the ms-resource URI scheme and represents the named resource for the
///                    candidate, where the authority of the URI or the resource map is empty. For example,
///                    ms-resource:///Resources/String1 or ms-resource:///Files/images/logo.png.
///    pQualifierCount = The number of indexed resource qualifiers that the list in the <i>ppQualifiers</i> parameter contains.
///    ppQualifiers = A list of indexed resource qualifiers that declare the context under which the resources are appropriate.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("MrmSupport")
HRESULT IndexFilePath(void* resourceIndexer, const(PWSTR) filePath, PWSTR* ppResourceUri, uint* pQualifierCount, 
                      IndexedResourceQualifier** ppQualifiers);

///Frees the parameters that the IndexFilePath method returned.
///Params:
///    resourceUri = A uniform resource indicator (URI) that uses the ms-resource URI scheme and represents the named resource for the
///                  candidate, where the authority of the URI or the resource map is empty. For example,
///                  ms-resource:///Resources/String1 or ms-resource:///Files/images/logo.png.
///    qualifierCount = The number of indexed resource qualifiers that the list in the <i>ppQualifiers</i> parameter contains.
///    qualifiers = A list of indexed resource qualifiers that declare the context under which the resources are appropriate.
@DllImport("MrmSupport")
void DestroyIndexedResults(PWSTR resourceUri, uint qualifierCount, IndexedResourceQualifier* qualifiers);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexer(const(PWSTR) packageFamilyName, const(PWSTR) projectRoot, 
                                 MrmPlatformVersion platformVersion, const(PWSTR) defaultQualifiers, 
                                 MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousSchemaFile(const(PWSTR) projectRoot, 
                                                       MrmPlatformVersion platformVersion, 
                                                       const(PWSTR) defaultQualifiers, const(PWSTR) schemaFile, 
                                                       MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousPriFile(const(PWSTR) projectRoot, MrmPlatformVersion platformVersion, 
                                                    const(PWSTR) defaultQualifiers, const(PWSTR) priFile, 
                                                    MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousSchemaData(const(PWSTR) projectRoot, 
                                                       MrmPlatformVersion platformVersion, 
                                                       const(PWSTR) defaultQualifiers, ubyte* schemaXmlData, 
                                                       uint schemaXmlSize, MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousPriData(const(PWSTR) projectRoot, MrmPlatformVersion platformVersion, 
                                                    const(PWSTR) defaultQualifiers, ubyte* priData, uint priSize, 
                                                    MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmIndexString(MrmResourceIndexerHandle indexer, const(PWSTR) resourceUri, const(PWSTR) resourceString, 
                       const(PWSTR) qualifiers);

@DllImport("MrmSupport")
HRESULT MrmIndexEmbeddedData(MrmResourceIndexerHandle indexer, const(PWSTR) resourceUri, 
                             const(ubyte)* embeddedData, uint embeddedDataSize, const(PWSTR) qualifiers);

@DllImport("MrmSupport")
HRESULT MrmIndexFile(MrmResourceIndexerHandle indexer, const(PWSTR) resourceUri, const(PWSTR) filePath, 
                     const(PWSTR) qualifiers);

@DllImport("MrmSupport")
HRESULT MrmIndexFileAutoQualifiers(MrmResourceIndexerHandle indexer, const(PWSTR) filePath);

@DllImport("MrmSupport")
HRESULT MrmIndexResourceContainerAutoQualifiers(MrmResourceIndexerHandle indexer, const(PWSTR) containerPath);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceFile(MrmResourceIndexerHandle indexer, MrmPackagingMode packagingMode, 
                              MrmPackagingOptions packagingOptions, const(PWSTR) outputDirectory);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceFileInMemory(MrmResourceIndexerHandle indexer, MrmPackagingMode packagingMode, 
                                      MrmPackagingOptions packagingOptions, ubyte** outputPriData, 
                                      uint* outputPriSize);

@DllImport("MrmSupport")
HRESULT MrmPeekResourceIndexerMessages(MrmResourceIndexerHandle handle, MrmResourceIndexerMessage** messages, 
                                       uint* numMsgs);

@DllImport("MrmSupport")
HRESULT MrmDestroyIndexerAndMessages(MrmResourceIndexerHandle indexer);

@DllImport("MrmSupport")
HRESULT MrmFreeMemory(ubyte* data);

@DllImport("MrmSupport")
HRESULT MrmDumpPriFile(const(PWSTR) indexFileName, const(PWSTR) schemaPriFile, MrmDumpType dumpType, 
                       const(PWSTR) outputXmlFile);

@DllImport("MrmSupport")
HRESULT MrmDumpPriFileInMemory(const(PWSTR) indexFileName, const(PWSTR) schemaPriFile, MrmDumpType dumpType, 
                               ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("MrmSupport")
HRESULT MrmDumpPriDataInMemory(ubyte* inputPriData, uint inputPriSize, ubyte* schemaPriData, uint schemaPriSize, 
                               MrmDumpType dumpType, ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("MrmSupport")
HRESULT MrmCreateConfig(MrmPlatformVersion platformVersion, const(PWSTR) defaultQualifiers, 
                        const(PWSTR) outputXmlFile);

@DllImport("MrmSupport")
HRESULT MrmCreateConfigInMemory(MrmPlatformVersion platformVersion, const(PWSTR) defaultQualifiers, 
                                ubyte** outputXmlData, uint* outputXmlSize);

///Compares two character strings. The comparison is case-sensitive. To perform a comparison that is not case-sensitive,
///use the lstrcmpi function.
///Params:
///    lpString1 = Type: <b>LPCTSTR</b> The first null-terminated string to be compared.
///    lpString2 = Type: <b>LPCTSTR</b> The second null-terminated string to be compared.
///Returns:
///    Type: <b>int</b> If the string pointed to by <i>lpString1</i> is less than the string pointed to by
///    <i>lpString2</i>, the return value is negative. If the string pointed to by <i>lpString1</i> is greater than the
///    string pointed to by <i>lpString2</i>, the return value is positive. If the strings are equal, the return value
///    is zero.
///    
@DllImport("KERNEL32")
int lstrcmpA(const(PSTR) lpString1, const(PSTR) lpString2);

///Compares two character strings. The comparison is case-sensitive. To perform a comparison that is not case-sensitive,
///use the lstrcmpi function.
///Params:
///    lpString1 = Type: <b>LPCTSTR</b> The first null-terminated string to be compared.
///    lpString2 = Type: <b>LPCTSTR</b> The second null-terminated string to be compared.
///Returns:
///    Type: <b>int</b> If the string pointed to by <i>lpString1</i> is less than the string pointed to by
///    <i>lpString2</i>, the return value is negative. If the string pointed to by <i>lpString1</i> is greater than the
///    string pointed to by <i>lpString2</i>, the return value is positive. If the strings are equal, the return value
///    is zero.
///    
@DllImport("KERNEL32")
int lstrcmpW(const(PWSTR) lpString1, const(PWSTR) lpString2);

///Compares two character strings. The comparison is not case-sensitive. To perform a comparison that is case-sensitive,
///use the lstrcmp function.
///Params:
///    lpString1 = Type: <b>LPCTSTR</b> The first null-terminated string to be compared.
///    lpString2 = Type: <b>LPCTSTR</b> The second null-terminated string to be compared.
///Returns:
///    Type: <b>int</b> If the string pointed to by <i>lpString1</i> is less than the string pointed to by
///    <i>lpString2</i>, the return value is negative. If the string pointed to by <i>lpString1</i> is greater than the
///    string pointed to by <i>lpString2</i>, the return value is positive. If the strings are equal, the return value
///    is zero.
///    
@DllImport("KERNEL32")
int lstrcmpiA(const(PSTR) lpString1, const(PSTR) lpString2);

///Compares two character strings. The comparison is not case-sensitive. To perform a comparison that is case-sensitive,
///use the lstrcmp function.
///Params:
///    lpString1 = Type: <b>LPCTSTR</b> The first null-terminated string to be compared.
///    lpString2 = Type: <b>LPCTSTR</b> The second null-terminated string to be compared.
///Returns:
///    Type: <b>int</b> If the string pointed to by <i>lpString1</i> is less than the string pointed to by
///    <i>lpString2</i>, the return value is negative. If the string pointed to by <i>lpString1</i> is greater than the
///    string pointed to by <i>lpString2</i>, the return value is positive. If the strings are equal, the return value
///    is zero.
///    
@DllImport("KERNEL32")
int lstrcmpiW(const(PWSTR) lpString1, const(PWSTR) lpString2);

///Copies a specified number of characters from a source string into a buffer. <div class="alert"><b>Warning</b> Do not
///use. Consider using StringCchCopy instead. See Remarks.</div><div> </div>
///Params:
///    lpString1 = Type: <b>LPTSTR</b> The destination buffer, which receives the copied characters. The buffer must be large enough
///                to contain the number of <b>TCHAR</b> values specified by <i>iMaxLength</i>, including room for a terminating
///                null character.
///    lpString2 = Type: <b>LPCTSTR</b> The source string from which the function is to copy characters.
///    iMaxLength = Type: <b>int</b> The number of <b>TCHAR</b> values to be copied from the string pointed to by <i>lpString2</i>
///                 into the buffer pointed to by <i>lpString1</i>, including a terminating null character.
///Returns:
///    Type: <b>LPTSTR</b> If the function succeeds, the return value is a pointer to the buffer. The function can
///    succeed even if the source string is greater than <i>iMaxLength</i> characters. If the function fails, the return
///    value is <b>NULL</b> and <i>lpString1</i> may not be null-terminated.
///    
@DllImport("KERNEL32")
PSTR lstrcpynA(PSTR lpString1, const(PSTR) lpString2, int iMaxLength);

///Copies a specified number of characters from a source string into a buffer. <div class="alert"><b>Warning</b> Do not
///use. Consider using StringCchCopy instead. See Remarks.</div><div> </div>
///Params:
///    lpString1 = Type: <b>LPTSTR</b> The destination buffer, which receives the copied characters. The buffer must be large enough
///                to contain the number of <b>TCHAR</b> values specified by <i>iMaxLength</i>, including room for a terminating
///                null character.
///    lpString2 = Type: <b>LPCTSTR</b> The source string from which the function is to copy characters.
///    iMaxLength = Type: <b>int</b> The number of <b>TCHAR</b> values to be copied from the string pointed to by <i>lpString2</i>
///                 into the buffer pointed to by <i>lpString1</i>, including a terminating null character.
///Returns:
///    Type: <b>LPTSTR</b> If the function succeeds, the return value is a pointer to the buffer. The function can
///    succeed even if the source string is greater than <i>iMaxLength</i> characters. If the function fails, the return
///    value is <b>NULL</b> and <i>lpString1</i> may not be null-terminated.
///    
@DllImport("KERNEL32")
PWSTR lstrcpynW(PWSTR lpString1, const(PWSTR) lpString2, int iMaxLength);

///Copies a string to a buffer. <div class="alert"><b>Warning</b> Do not use. Consider using StringCchCopy instead. See
///Remarks.</div><div> </div>
///Params:
///    lpString1 = Type: <b>LPTSTR</b> A buffer to receive the contents of the string pointed to by the <i>lpString2</i> parameter.
///                The buffer must be large enough to contain the string, including the terminating null character.
///    lpString2 = Type: <b>LPTSTR</b> The null-terminated string to be copied.
///Returns:
///    Type: <b>LPTSTR</b> If the function succeeds, the return value is a pointer to the buffer. If the function fails,
///    the return value is <b>NULL</b> and <i>lpString1</i> may not be null-terminated.
///    
@DllImport("KERNEL32")
PSTR lstrcpyA(PSTR lpString1, const(PSTR) lpString2);

///Copies a string to a buffer. <div class="alert"><b>Warning</b> Do not use. Consider using StringCchCopy instead. See
///Remarks.</div><div> </div>
///Params:
///    lpString1 = Type: <b>LPTSTR</b> A buffer to receive the contents of the string pointed to by the <i>lpString2</i> parameter.
///                The buffer must be large enough to contain the string, including the terminating null character.
///    lpString2 = Type: <b>LPTSTR</b> The null-terminated string to be copied.
///Returns:
///    Type: <b>LPTSTR</b> If the function succeeds, the return value is a pointer to the buffer. If the function fails,
///    the return value is <b>NULL</b> and <i>lpString1</i> may not be null-terminated.
///    
@DllImport("KERNEL32")
PWSTR lstrcpyW(PWSTR lpString1, const(PWSTR) lpString2);

///Appends one string to another. <div class="alert"><b>Warning</b> Do not use. Consider using StringCchCat instead. See
///Security Considerations. </div><div> </div>
///Params:
///    lpString1 = Type: <b>LPTSTR</b> The first null-terminated string. This buffer must be large enough to contain both strings.
///    lpString2 = Type: <b>LPTSTR</b> The null-terminated string to be appended to the string specified in the <i>lpString1</i>
///                parameter.
///Returns:
///    Type: <b>LPTSTR</b> If the function succeeds, the return value is a pointer to the buffer. If the function fails,
///    the return value is <b>NULL</b> and <i>lpString1</i> may not be null-terminated.
///    
@DllImport("KERNEL32")
PSTR lstrcatA(PSTR lpString1, const(PSTR) lpString2);

///Appends one string to another. <div class="alert"><b>Warning</b> Do not use. Consider using StringCchCat instead. See
///Security Considerations. </div><div> </div>
///Params:
///    lpString1 = Type: <b>LPTSTR</b> The first null-terminated string. This buffer must be large enough to contain both strings.
///    lpString2 = Type: <b>LPTSTR</b> The null-terminated string to be appended to the string specified in the <i>lpString1</i>
///                parameter.
///Returns:
///    Type: <b>LPTSTR</b> If the function succeeds, the return value is a pointer to the buffer. If the function fails,
///    the return value is <b>NULL</b> and <i>lpString1</i> may not be null-terminated.
///    
@DllImport("KERNEL32")
PWSTR lstrcatW(PWSTR lpString1, const(PWSTR) lpString2);

///Determines the length of the specified string (not including the terminating null character).
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated string to be checked.
///Returns:
///    Type: <b>int</b> The function returns the length of the string, in characters. If <i>lpString</i> is <b>NULL</b>,
///    the function returns 0.
///    
@DllImport("KERNEL32")
int lstrlenA(const(PSTR) lpString);

///Determines the length of the specified string (not including the terminating null character).
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated string to be checked.
///Returns:
///    Type: <b>int</b> The function returns the length of the string, in characters. If <i>lpString</i> is <b>NULL</b>,
///    the function returns 0.
///    
@DllImport("KERNEL32")
int lstrlenW(const(PWSTR) lpString);

///Determines the location of a resource with the specified type and name in the specified module. To specify a
///language, use the FindResourceEx function.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose portable executable file or an accompanying MUI file contains
///              the resource. If this parameter is <b>NULL</b>, the function searches the module used to create the current
///              process.
///    lpName = Type: <b>LPCTSTR</b> The name of the resource. Alternately, rather than a pointer, this parameter can be
///             MAKEINTRESOURCE(ID), where ID is the integer identifier of the resource. For more information, see the Remarks
///             section below.
///    lpType = Type: <b>LPCTSTR</b> The resource type. Alternately, rather than a pointer, this parameter can be
///             MAKEINTRESOURCE(ID), where ID is the integer identifier of the given resource type. For standard resource types,
///             see Resource Types. For more information, see the Remarks section below.
///Returns:
///    Type: <b>HRSRC</b> If the function succeeds, the return value is a handle to the specified resource's information
///    block. To obtain a handle to the resource, pass this handle to the LoadResource function. If the function fails,
///    the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
HRSRC FindResourceA(ptrdiff_t hModule, const(PSTR) lpName, const(PSTR) lpType);

///Determines the location of the resource with the specified type, name, and language in the specified module.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to the module whose portable executable file or an accompanying MUI file contains
///              the resource. If this parameter is <b>NULL</b>, the function searches the module used to create the current
///              process.
///    lpType = Type: <b>LPCTSTR</b> The resource type. Alternately, rather than a pointer, this parameter can be
///             MAKEINTRESOURCE(ID), where ID is the integer identifier of the given resource type. For standard resource types,
///             see Resource Types. For more information, see the Remarks section below.
///    lpName = Type: <b>LPCTSTR</b> The name of the resource. Alternately, rather than a pointer, this parameter can be
///             MAKEINTRESOURCE(ID), where ID is the integer identifier of the resource. For more information, see the Remarks
///             section below.
///    wLanguage = Type: <b>WORD</b> The language of the resource. If this parameter is <code>MAKELANGID(LANG_NEUTRAL,
///                SUBLANG_NEUTRAL)</code>, the current language associated with the calling thread is used. To specify a language
///                other than the current language, use the MAKELANGID macro to create this parameter. For more information, see
///                <b>MAKELANGID</b>.
///Returns:
///    Type: <b>HRSRC</b> If the function succeeds, the return value is a handle to the specified resource's information
///    block. To obtain a handle to the resource, pass this handle to the LoadResource function. If the function fails,
///    the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
HRSRC FindResourceExA(ptrdiff_t hModule, const(PSTR) lpType, const(PSTR) lpName, ushort wLanguage);

///Enumerates resource types within a binary module. Starting with Windows Vista, this is typically a language-neutral
///Portable Executable (LN file), and the enumeration also includes resources from one of the corresponding
///language-specific resource files (.mui files)—if one exists—that contain localizable language resources. It is
///also possible to use <i>hModule</i> to specify a .mui file, in which case only that file is searched for resource
///types. Alternately, applications can call EnumResourceTypesEx, which provides more precise control over which
///resource files to enumerate.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to a module to be searched. This handle must be obtained through LoadLibrary or
///              LoadLibraryEx. See Remarks for more information. If this parameter is <b>NULL</b>, that is equivalent to passing
///              in a handle to the module used to create the current process.
///    lpEnumFunc = Type: <b>ENUMRESTYPEPROC</b> A pointer to the callback function to be called for each enumerated resource type.
///                 For more information, see the EnumResTypeProc function.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful; otherwise, <b>FALSE</b>. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceTypesA(ptrdiff_t hModule, ENUMRESTYPEPROCA lpEnumFunc, ptrdiff_t lParam);

///Enumerates resource types within a binary module. Starting with Windows Vista, this is typically a language-neutral
///Portable Executable (LN file), and the enumeration also includes resources from one of the corresponding
///language-specific resource files (.mui files)—if one exists—that contain localizable language resources. It is
///also possible to use <i>hModule</i> to specify a .mui file, in which case only that file is searched for resource
///types. Alternately, applications can call EnumResourceTypesEx, which provides more precise control over which
///resource files to enumerate.
///Params:
///    hModule = Type: <b>HMODULE</b> A handle to a module to be searched. This handle must be obtained through LoadLibrary or
///              LoadLibraryEx. See Remarks for more information. If this parameter is <b>NULL</b>, that is equivalent to passing
///              in a handle to the module used to create the current process.
///    lpEnumFunc = Type: <b>ENUMRESTYPEPROC</b> A pointer to the callback function to be called for each enumerated resource type.
///                 For more information, see the EnumResTypeProc function.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful; otherwise, <b>FALSE</b>. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceTypesW(ptrdiff_t hModule, ENUMRESTYPEPROCW lpEnumFunc, ptrdiff_t lParam);

///Enumerates resources of a specified type within a binary module. For Windows Vista and later, this is typically a
///[language-neutral Portable Executable](/windows/desktop/Intl/mui-resource-management) (LN file), and the enumeration
///will also include resources from the corresponding language-specific resource files (.mui files) that contain
///localizable language resources. It is also possible for *hModule* to specify an .mui file, in which case only that
///file is searched for resources.
///Params:
///    hModule = Type: **HMODULE** A handle to a module to be searched. Starting with Windows Vista, if this is an LN file, then
///              appropriate .mui files (if any exist) are included in the search. If this parameter is **NULL**, that is
///              equivalent to passing in a handle to the module used to create the current process.
///    lpType = Type: **LPCTSTR** The type of the resource for which the name is being enumerated. Alternately, rather than a
///             pointer, this parameter can be [MAKEINTRESOURCE](/windows/desktop/api/winuser/nf-winuser-makeintresourcea)(ID),
///             where ID is an integer value representing a predefined resource type. For a list of predefined resource types,
///             see [Resource Types](/windows/win32/menurc/resource-types). For more information, see the [Remarks](
///    lpEnumFunc = Type: **ENUMRESNAMEPROC** A pointer to the callback function to be called for each enumerated resource name or
///                 ID. For more information, see
///                 [ENUMRESNAMEPROC](/windows/win32/api/libloaderapi/nc-libloaderapi-enumresnameproca).
///    lParam = Type: **LONG_PTR** An application-defined value passed to the callback function. This parameter can be used in
///             error checking.
///Returns:
///    Type: **BOOL** The return value is **TRUE** if the function succeeds or **FALSE** if the function does not find a
///    resource of the type specified, or if the function fails for another reason. To get extended error information,
///    call [GetLastError](/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("KERNEL32")
BOOL EnumResourceNamesA(ptrdiff_t hModule, const(PSTR) lpType, ENUMRESNAMEPROCA lpEnumFunc, ptrdiff_t lParam);

///Enumerates language-specific resources, of the specified type and name, associated with a binary module.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to be searched. Starting with Windows Vista, if this is a
///              language-neutral Portable Executable (LN file), then appropriate .mui files (if any exist) are included in the
///              search. If this is a specific .mui file, only that file is searched for resources. If this parameter is
///              <b>NULL</b>, that is equivalent to passing in a handle to the module used to create the current process.
///    lpType = Type: <b>LPCTSTR</b> The type of resource for which the language is being enumerated. Alternately, rather than a
///             pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined
///             resource type. For a list of predefined resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpName = Type: <b>LPCTSTR</b> The name of the resource for which the language is being enumerated. Alternately, rather
///             than a pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is the integer identifier of the resource.
///             For more information, see the Remarks section below.
///    lpEnumFunc = Type: <b>ENUMRESLANGPROC</b> A pointer to the callback function to be called for each enumerated resource
///                 language. For more information, see EnumResLangProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function. This parameter can be used in
///             error checking.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceLanguagesA(ptrdiff_t hModule, const(PSTR) lpType, const(PSTR) lpName, ENUMRESLANGPROCA lpEnumFunc, 
                            ptrdiff_t lParam);

///Enumerates language-specific resources, of the specified type and name, associated with a binary module.
///Params:
///    hModule = Type: <b>HMODULE</b> The handle to a module to be searched. Starting with Windows Vista, if this is a
///              language-neutral Portable Executable (LN file), then appropriate .mui files (if any exist) are included in the
///              search. If this is a specific .mui file, only that file is searched for resources. If this parameter is
///              <b>NULL</b>, that is equivalent to passing in a handle to the module used to create the current process.
///    lpType = Type: <b>LPCTSTR</b> The type of resource for which the language is being enumerated. Alternately, rather than a
///             pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined
///             resource type. For a list of predefined resource types, see Resource Types. For more information, see the Remarks
///             section below.
///    lpName = Type: <b>LPCTSTR</b> The name of the resource for which the language is being enumerated. Alternately, rather
///             than a pointer, this parameter can be MAKEINTRESOURCE(ID), where ID is the integer identifier of the resource.
///             For more information, see the Remarks section below.
///    lpEnumFunc = Type: <b>ENUMRESLANGPROC</b> A pointer to the callback function to be called for each enumerated resource
///                 language. For more information, see EnumResLangProc.
///    lParam = Type: <b>LONG_PTR</b> An application-defined value passed to the callback function. This parameter can be used in
///             error checking.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EnumResourceLanguagesW(ptrdiff_t hModule, const(PWSTR) lpType, const(PWSTR) lpName, 
                            ENUMRESLANGPROCW lpEnumFunc, ptrdiff_t lParam);

///Retrieves a handle that can be used by the UpdateResource function to add, delete, or replace resources in a binary
///module.
///Params:
///    pFileName = Type: <b>LPCTSTR</b> The binary file in which to update resources. An application must be able to obtain
///                write-access to this file; the file referenced by <i>pFileName</i> cannot be currently executing. If
///                <i>pFileName</i> does not specify a full path, the system searches for the file in the current directory.
///    bDeleteExistingResources = Type: <b>BOOL</b> Indicates whether to delete the <i>pFileName</i> parameter's existing resources. If this
///                               parameter is <b>TRUE</b>, existing resources are deleted and the updated file includes only resources added with
///                               the UpdateResource function. If this parameter is <b>FALSE</b>, the updated file includes existing resources
///                               unless they are explicitly deleted or replaced by using <b>UpdateResource</b>.
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, the return value is a handle that can be used by the UpdateResource
///    and EndUpdateResource functions. The return value is <b>NULL</b> if the specified file is not a PE, the file does
///    not exist, or the file cannot be opened for writing. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
HANDLE BeginUpdateResourceA(const(PSTR) pFileName, BOOL bDeleteExistingResources);

///Retrieves a handle that can be used by the UpdateResource function to add, delete, or replace resources in a binary
///module.
///Params:
///    pFileName = Type: <b>LPCTSTR</b> The binary file in which to update resources. An application must be able to obtain
///                write-access to this file; the file referenced by <i>pFileName</i> cannot be currently executing. If
///                <i>pFileName</i> does not specify a full path, the system searches for the file in the current directory.
///    bDeleteExistingResources = Type: <b>BOOL</b> Indicates whether to delete the <i>pFileName</i> parameter's existing resources. If this
///                               parameter is <b>TRUE</b>, existing resources are deleted and the updated file includes only resources added with
///                               the UpdateResource function. If this parameter is <b>FALSE</b>, the updated file includes existing resources
///                               unless they are explicitly deleted or replaced by using <b>UpdateResource</b>.
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, the return value is a handle that can be used by the UpdateResource
///    and EndUpdateResource functions. The return value is <b>NULL</b> if the specified file is not a PE, the file does
///    not exist, or the file cannot be opened for writing. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
HANDLE BeginUpdateResourceW(const(PWSTR) pFileName, BOOL bDeleteExistingResources);

///Adds, deletes, or replaces a resource in a portable executable (PE) file. There are some restrictions on resource
///updates in files that contain Resource Configuration (RC Config) data: language-neutral (LN) files and
///language-specific resource (.mui) files.
///Params:
///    hUpdate = Type: <b>HANDLE</b> A module handle returned by the BeginUpdateResource function, referencing the file to be
///              updated.
///    lpType = Type: <b>LPCTSTR</b> The resource type to be updated. Alternatively, rather than a pointer, this parameter can be
///             MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined resource type. If the first character
///             of the string is a pound sign (
///    lpName = Type: <b>LPCTSTR</b> The name of the resource to be updated. Alternatively, rather than a pointer, this parameter
///             can be MAKEINTRESOURCE(ID), where ID is a resource ID. When creating a new resource do not use a string that
///             begins with a '
///    wLanguage = Type: <b>WORD</b> The language identifier of the resource to be updated. For a list of the primary language
///                identifiers and sublanguage identifiers that make up a language identifier, see the MAKELANGID macro.
///    lpData = Type: <b>LPVOID</b> The resource data to be inserted into the file indicated by <i>hUpdate</i>. If the resource
///             is one of the predefined types, the data must be valid and properly aligned. Note that this is the raw binary
///             data to be stored in the file indicated by <i>hUpdate</i>, not the data provided by LoadIcon, LoadString, or
///             other resource-specific load functions. All data containing strings or text must be in Unicode format.
///             <i>lpData</i> must not point to ANSI data. If <i>lpData</i> is <b>NULL</b> and <i>cbData</i> is 0, the specified
///             resource is deleted from the file indicated by <i>hUpdate</i>.
///    cb = Type: <b>DWORD</b> The size, in bytes, of the resource data at <i>lpData</i>.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL UpdateResourceA(HANDLE hUpdate, const(PSTR) lpType, const(PSTR) lpName, ushort wLanguage, void* lpData, 
                     uint cb);

///Adds, deletes, or replaces a resource in a portable executable (PE) file. There are some restrictions on resource
///updates in files that contain Resource Configuration (RC Config) data: language-neutral (LN) files and
///language-specific resource (.mui) files.
///Params:
///    hUpdate = Type: <b>HANDLE</b> A module handle returned by the BeginUpdateResource function, referencing the file to be
///              updated.
///    lpType = Type: <b>LPCTSTR</b> The resource type to be updated. Alternatively, rather than a pointer, this parameter can be
///             MAKEINTRESOURCE(ID), where ID is an integer value representing a predefined resource type. If the first character
///             of the string is a pound sign (
///    lpName = Type: <b>LPCTSTR</b> The name of the resource to be updated. Alternatively, rather than a pointer, this parameter
///             can be MAKEINTRESOURCE(ID), where ID is a resource ID. When creating a new resource do not use a string that
///             begins with a '
///    wLanguage = Type: <b>WORD</b> The language identifier of the resource to be updated. For a list of the primary language
///                identifiers and sublanguage identifiers that make up a language identifier, see the MAKELANGID macro.
///    lpData = Type: <b>LPVOID</b> The resource data to be inserted into the file indicated by <i>hUpdate</i>. If the resource
///             is one of the predefined types, the data must be valid and properly aligned. Note that this is the raw binary
///             data to be stored in the file indicated by <i>hUpdate</i>, not the data provided by LoadIcon, LoadString, or
///             other resource-specific load functions. All data containing strings or text must be in Unicode format.
///             <i>lpData</i> must not point to ANSI data. If <i>lpData</i> is <b>NULL</b> and <i>cbData</i> is 0, the specified
///             resource is deleted from the file indicated by <i>hUpdate</i>.
///    cb = Type: <b>DWORD</b> The size, in bytes, of the resource data at <i>lpData</i>.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
BOOL UpdateResourceW(HANDLE hUpdate, const(PWSTR) lpType, const(PWSTR) lpName, ushort wLanguage, void* lpData, 
                     uint cb);

///Commits or discards changes made prior to a call to UpdateResource.
///Params:
///    hUpdate = Type: <b>HANDLE</b> A module handle returned by the BeginUpdateResource function, and used by UpdateResource,
///              referencing the file to be updated.
///    fDiscard = Type: <b>BOOL</b> Indicates whether to write the resource updates to the file. If this parameter is <b>TRUE</b>,
///               no changes are made. If it is <b>FALSE</b>, the changes are made: the resource updates will take effect.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if the function succeeds; <b>FALSE</b> otherwise. If the function succeeds
///    and <i>fDiscard</i> is <b>TRUE</b>, then no resource updates are made to the file; otherwise all successful
///    resource updates are made to the file. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EndUpdateResourceA(HANDLE hUpdate, BOOL fDiscard);

///Commits or discards changes made prior to a call to UpdateResource.
///Params:
///    hUpdate = Type: <b>HANDLE</b> A module handle returned by the BeginUpdateResource function, and used by UpdateResource,
///              referencing the file to be updated.
///    fDiscard = Type: <b>BOOL</b> Indicates whether to write the resource updates to the file. If this parameter is <b>TRUE</b>,
///               no changes are made. If it is <b>FALSE</b>, the changes are made: the resource updates will take effect.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if the function succeeds; <b>FALSE</b> otherwise. If the function succeeds
///    and <i>fDiscard</i> is <b>TRUE</b>, then no resource updates are made to the file; otherwise all successful
///    resource updates are made to the file. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL EndUpdateResourceW(HANDLE hUpdate, BOOL fDiscard);


