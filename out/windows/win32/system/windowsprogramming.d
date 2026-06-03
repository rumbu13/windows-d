// Written in the D programming language.

module windows.win32.system.windowsprogramming;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, CHAR, FILETIME, HANDLE,
                                         HGLOBAL, HINSTANCE, HLOCAL, HMODULE,
                                         HRESULT, HWND, LPARAM, LRESULT, NTSTATUS,
                                         PSTR, PWSTR, RECT, UNICODE_STRING,
                                         VARIANT_BOOL, WPARAM;
public import windows.win32.graphics.gdi : HDC, RGNDATA;
public import windows.win32.system.com : IStream, IUnknown, SAFEARRAY;
public import windows.win32.system.kernel : LIST_ENTRY, STRING;
public import windows.win32.system.ole : OLE_HANDLE;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Enums


alias TDIENTITY_ENTITY_TYPE = uint;
enum : uint
{
    GENERIC_ENTITY = 0x00000000U,
    AT_ENTITY      = 0x00000280U,
    CL_NL_ENTITY   = 0x00000301U,
    CO_NL_ENTITY   = 0x00000300U,
    CL_TL_ENTITY   = 0x00000401U,
    CO_TL_ENTITY   = 0x00000400U,
    ER_ENTITY      = 0x00000380U,
    IF_ENTITY      = 0x00000200U,
}

alias WINSTATIONINFOCLASS = int;
enum : int
{
    WinStationInformation = 0x00000008,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum CameraUIControlMode : int
{
    Browse  = 0x00000000,
    Linear  = 0x00000001,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum CameraUIControlLinearSelectionMode : int
{
    Single   = 0x00000000,
    Multiple = 0x00000001,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum CameraUIControlCaptureMode : int
{
    PhotoOrVideo = 0x00000000,
    Photo        = 0x00000001,
    Video        = 0x00000002,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum CameraUIControlPhotoFormat : int
{
    Jpeg    = 0x00000000,
    Png     = 0x00000001,
    JpegXR  = 0x00000002,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum CameraUIControlVideoFormat : int
{
    Mp4     = 0x00000000,
    Wmv     = 0x00000001,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum CameraUIControlViewType : int
{
    SingleItem = 0x00000000,
    ItemList   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/ne-featurestagingapi-feature_change_time
alias FEATURE_CHANGE_TIME = int;
enum : int
{
    FEATURE_CHANGE_TIME_READ          = 0x00000000,
    FEATURE_CHANGE_TIME_MODULE_RELOAD = 0x00000001,
    FEATURE_CHANGE_TIME_SESSION       = 0x00000002,
    FEATURE_CHANGE_TIME_REBOOT        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/ne-featurestagingapi-feature_enabled_state
alias FEATURE_ENABLED_STATE = int;
enum : int
{
    FEATURE_ENABLED_STATE_DEFAULT  = 0x00000000,
    FEATURE_ENABLED_STATE_DISABLED = 0x00000001,
    FEATURE_ENABLED_STATE_ENABLED  = 0x00000002,
}

alias TDI_TL_IO_CONTROL_TYPE = int;
enum : int
{
    EndpointIoControlType   = 0x00000000,
    SetSockOptIoControlType = 0x00000001,
    GetSockOptIoControlType = 0x00000002,
    SocketIoControlType     = 0x00000003,
}

alias WLDP_HOST = int;
enum : int
{
    WLDP_HOST_RUNDLL32 = 0x00000000,
    WLDP_HOST_SVCHOST  = 0x00000001,
    WLDP_HOST_MAX      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/ne-wldp-wldp_host_id
alias WLDP_HOST_ID = int;
enum : int
{
    WLDP_HOST_ID_UNKNOWN    = 0x00000000,
    WLDP_HOST_ID_GLOBAL     = 0x00000001,
    WLDP_HOST_ID_VBA        = 0x00000002,
    WLDP_HOST_ID_WSH        = 0x00000003,
    WLDP_HOST_ID_POWERSHELL = 0x00000004,
    WLDP_HOST_ID_IE         = 0x00000005,
    WLDP_HOST_ID_MSI        = 0x00000006,
    WLDP_HOST_ID_ALL        = 0x00000007,
    WLDP_HOST_ID_MAX        = 0x00000008,
}

alias DECISION_LOCATION = int;
enum : int
{
    DECISION_LOCATION_REFRESH_GLOBAL_DATA         = 0x00000000,
    DECISION_LOCATION_PARAMETER_VALIDATION        = 0x00000001,
    DECISION_LOCATION_AUDIT                       = 0x00000002,
    DECISION_LOCATION_FAILED_CONVERT_GUID         = 0x00000003,
    DECISION_LOCATION_ENTERPRISE_DEFINED_CLASS_ID = 0x00000004,
    DECISION_LOCATION_GLOBAL_BUILT_IN_LIST        = 0x00000005,
    DECISION_LOCATION_PROVIDER_BUILT_IN_LIST      = 0x00000006,
    DECISION_LOCATION_ENFORCE_STATE_LIST          = 0x00000007,
    DECISION_LOCATION_NOT_FOUND                   = 0x00000008,
    DECISION_LOCATION_UNKNOWN                     = 0x00000009,
}

alias WLDP_KEY = int;
enum : int
{
    KEY_UNKNOWN  = 0x00000000,
    KEY_OVERRIDE = 0x00000001,
    KEY_ALL_KEYS = 0x00000002,
}

alias VALUENAME = int;
enum : int
{
    VALUENAME_UNKNOWN                     = 0x00000000,
    VALUENAME_ENTERPRISE_DEFINED_CLASS_ID = 0x00000001,
    VALUENAME_BUILT_IN_LIST               = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/ne-wldp-wldp_windows_lockdown_mode
alias WLDP_WINDOWS_LOCKDOWN_MODE = int;
enum : int
{
    WLDP_WINDOWS_LOCKDOWN_MODE_UNLOCKED = 0x00000000,
    WLDP_WINDOWS_LOCKDOWN_MODE_TRIAL    = 0x00000001,
    WLDP_WINDOWS_LOCKDOWN_MODE_LOCKED   = 0x00000002,
    WLDP_WINDOWS_LOCKDOWN_MODE_MAX      = 0x00000003,
}

alias WLDP_WINDOWS_LOCKDOWN_RESTRICTION = int;
enum : int
{
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NONE               = 0x00000000,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK           = 0x00000001,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK_PERMANENT = 0x00000002,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_MAX                = 0x00000003,
}

alias WLDP_POLICY_SETTING = int;
enum : int
{
    WLDP_POLICY_SETTING_AV_PERF_MODE = 0x000003e8,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/ne-wldp-wldp_execution_policy
alias WLDP_EXECUTION_POLICY = int;
enum : int
{
    WLDP_EXECUTION_POLICY_BLOCKED         = 0x00000000,
    WLDP_EXECUTION_POLICY_ALLOWED         = 0x00000001,
    WLDP_EXECUTION_POLICY_REQUIRE_SANDBOX = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/ne-wldp-wldp_execution_evaluation_options
alias WLDP_EXECUTION_EVALUATION_OPTIONS = int;
enum : int
{
    WLDP_EXECUTION_EVALUATION_OPTION_NONE                           = 0x00000000,
    WLDP_EXECUTION_EVALUATION_OPTION_EXECUTE_IN_INTERACTIVE_SESSION = 0x00000001,
}

alias WLDP_SECURE_SETTING_VALUE_TYPE = int;
enum : int
{
    WLDP_SECURE_SETTING_VALUE_TYPE_BOOLEAN = 0x00000000,
    WLDP_SECURE_SETTING_VALUE_TYPE_ULONG   = 0x00000001,
    WLDP_SECURE_SETTING_VALUE_TYPE_BINARY  = 0x00000002,
    WLDP_SECURE_SETTING_VALUE_TYPE_STRING  = 0x00000003,
}

// Constants


enum : const(wchar)*
{
    WLDP_DLL                  = "WLDP.DLL",
    // Native encoding: ansi
    WLDP_GETLOCKDOWNPOLICY_FN = "WldpGetLockdownPolicy",
}

// Native encoding: ansi
enum const(wchar)* WLDP_ISCLASSINAPPROVEDLIST_FN = "WldpIsClassInApprovedList";
// Native encoding: ansi
enum const(wchar)* WLDP_SETDYNAMICCODETRUST_FN = "WldpSetDynamicCodeTrust";
// Native encoding: ansi
enum const(wchar)* WLDP_ISDYNAMICCODEPOLICYENABLED_FN = "WldpIsDynamicCodePolicyEnabled";
// Native encoding: ansi
enum const(wchar)* WLDP_QUERYDANAMICCODETRUST_FN = "WldpQueryDynamicCodeTrust";
// Native encoding: ansi
enum const(wchar)* WLDP_QUERYDYNAMICCODETRUST_FN = "WldpQueryDynamicCodeTrust";
// Native encoding: ansi
enum const(wchar)* WLDP_QUERYWINDOWSLOCKDOWNMODE_FN = "WldpQueryWindowsLockdownMode";
// Native encoding: ansi
enum const(wchar)* WLDP_SETWINDOWSLOCKDOWNRESTRICTION_FN = "WldpSetWindowsLockdownRestriction";
// Native encoding: ansi
enum const(wchar)* WLDP_QUERYDEVICESECURITYINFORMATION_FN = "WldpQueryDeviceSecurityInformation";
// Native encoding: ansi
enum const(wchar)* WLDP_QUERYWINDOWSLOCKDOWNRESTRICTION_FN = "WldpQueryWindowsLockdownRestriction";
// Native encoding: ansi
enum const(wchar)* WLDP_ISAPPAPPROVEDBYPOLICY_FN = "WldpIsAppApprovedByPolicy";

enum : const(wchar)*
{
    // Native encoding: ansi
    WLDP_QUERYPOLICYSETTINGENABLED_FN  = "WldpQueryPolicySettingEnabled",
    // Native encoding: ansi
    WLDP_QUERYPOLICYSETTINGENABLED2_FN = "WldpQueryPolicySettingEnabled2",
}

// Native encoding: ansi
enum const(wchar)* WLDP_ISWCOSPRODUCTIONCONFIGURATION_FN = "WldpIsWcosProductionConfiguration";
// Native encoding: ansi
enum const(wchar)* WLDP_RESETWCOSPRODUCTIONCONFIGURATION_FN = "WldpResetWcosProductionConfiguration";
// Native encoding: ansi
enum const(wchar)* WLDP_ISPRODUCTIONCONFIGURATION_FN = "WldpIsProductionConfiguration";
// Native encoding: ansi
enum const(wchar)* WLDP_RESETPRODUCTIONCONFIGURATION_FN = "WldpResetProductionConfiguration";

enum : const(wchar)*
{
    // Native encoding: ansi
    WLDP_CANEXECUTEBUFFER_FN                    = "WldpCanExecuteBuffer",
    // Native encoding: ansi
    WLDP_CANEXECUTEFILE_FN                      = "WldpCanExecuteFile",
    // Native encoding: ansi
    WLDP_CANEXECUTEFILEFROMDETACHEDSIGNATURE_FN = "WldpCanExecuteFileFromDetachedSignature",
}

// Native encoding: ansi
enum const(wchar)* WLDP_QUERYSECURITYPOLICY_FN = "WldpQuerySecurityPolicy";

enum : uint
{
    WLDP_LOCKDOWN_UNDEFINED            = 0x00000000U,
    WLDP_LOCKDOWN_DEFINED_FLAG         = 0x80000000U,
    WLDP_LOCKDOWN_CONFIG_CI_FLAG       = 0x00000001U,
    WLDP_LOCKDOWN_CONFIG_CI_AUDIT_FLAG = 0x00000002U,
    WLDP_LOCKDOWN_UMCIENFORCE_FLAG     = 0x00000004U,
    WLDP_LOCKDOWN_AUDIT_FLAG           = 0x00000008U,
    WLDP_LOCKDOWN_EXCLUSION_FLAG       = 0x00000010U,
    WLDP_LOCKDOWN_OFF                  = 0x80000000U,
}

enum uint WLDP_HOST_INFORMATION_REVISION = 0x00000001U;
enum uint WLDP_FLAGS_SKIPSIGNATUREVALIDATION = 0x00000100U;
enum uint MAX_TDI_ENTITIES = 0x00001000U;

enum : uint
{
    INFO_CLASS_GENERIC        = 0x00000100U,
    INFO_CLASS_PROTOCOL       = 0x00000200U,
    INFO_CLASS_IMPLEMENTATION = 0x00000300U,
}

enum : uint
{
    INFO_TYPE_PROVIDER       = 0x00000100U,
    INFO_TYPE_ADDRESS_OBJECT = 0x00000200U,
    INFO_TYPE_CONNECTION     = 0x00000300U,
}

enum uint ENTITY_LIST_ID = 0x00000000U;
enum int INVALID_ENTITY_INSTANCE = 0xffffffff;
enum uint CONTEXT_SIZE = 0x00000010U;
enum uint ENTITY_TYPE_ID = 0x00000001U;

enum : uint
{
    CO_TL_NBF = 0x00000400U,
    CO_TL_SPX = 0x00000402U,
    CO_TL_TCP = 0x00000404U,
    CO_TL_SPP = 0x00000406U,
}

enum : uint
{
    CL_TL_NBF = 0x00000401U,
    CL_TL_UDP = 0x00000403U,
}

enum uint ER_ICMP = 0x00000380U;

enum : uint
{
    CL_NL_IPX = 0x00000301U,
    CL_NL_IP  = 0x00000303U,
}

enum : uint
{
    AT_ARP  = 0x00000280U,
    AT_NULL = 0x00000282U,
}

enum uint IF_GENERIC = 0x00000200U;
enum uint IF_MIB = 0x00000202U;
enum uint IOCTL_TDI_TL_IO_CONTROL_ENDPOINT = 0x00210038U;
enum uint DCI_VERSION = 0x00000100U;
enum uint DCICREATEPRIMARYSURFACE = 0x00000001U;
enum uint DCICREATEOFFSCREENSURFACE = 0x00000002U;
enum uint DCICREATEOVERLAYSURFACE = 0x00000003U;
enum uint DCIENUMSURFACE = 0x00000004U;
enum uint DCIESCAPE = 0x00000005U;
enum uint DCI_OK = 0x00000000U;

enum : int
{
    DCI_FAIL_GENERIC            = 0xffffffff,
    DCI_FAIL_UNSUPPORTEDVERSION = 0xfffffffe,
}

enum int DCI_FAIL_INVALIDSURFACE = 0xfffffffd;
enum int DCI_FAIL_UNSUPPORTED = 0xfffffffc;
enum int DCI_ERR_CURRENTLYNOTAVAIL = 0xfffffffb;

enum : int
{
    DCI_ERR_INVALIDRECT       = 0xfffffffa,
    DCI_ERR_UNSUPPORTEDFORMAT = 0xfffffff9,
    DCI_ERR_UNSUPPORTEDMASK   = 0xfffffff8,
}

enum : int
{
    DCI_ERR_TOOBIGHEIGHT    = 0xfffffff7,
    DCI_ERR_TOOBIGWIDTH     = 0xfffffff6,
    DCI_ERR_TOOBIGSIZE      = 0xfffffff5,
    DCI_ERR_OUTOFMEMORY     = 0xfffffff4,
    DCI_ERR_INVALIDPOSITION = 0xfffffff3,
    DCI_ERR_INVALIDSTRETCH  = 0xfffffff2,
    DCI_ERR_INVALIDCLIPLIST = 0xfffffff1,
}

enum int DCI_ERR_SURFACEISOBSCURED = 0xfffffff0;

enum : int
{
    DCI_ERR_XALIGN      = 0xffffffef,
    DCI_ERR_YALIGN      = 0xffffffee,
    DCI_ERR_XYALIGN     = 0xffffffed,
    DCI_ERR_WIDTHALIGN  = 0xffffffec,
    DCI_ERR_HEIGHTALIGN = 0xffffffeb,
}

enum : uint
{
    DCI_STATUS_POINTERCHANGED     = 0x00000001U,
    DCI_STATUS_STRIDECHANGED      = 0x00000002U,
    DCI_STATUS_FORMATCHANGED      = 0x00000004U,
    DCI_STATUS_SURFACEINFOCHANGED = 0x00000008U,
}

enum : uint
{
    DCI_STATUS_CHROMAKEYCHANGED = 0x00000010U,
    DCI_STATUS_WASSTILLDRAWING  = 0x00000020U,
}

enum uint DCI_SURFACE_TYPE = 0x0000000fU;
enum uint DCI_PRIMARY = 0x00000000U;
enum uint DCI_OFFSCREEN = 0x00000001U;
enum uint DCI_OVERLAY = 0x00000002U;
enum uint DCI_VISIBLE = 0x00000010U;
enum uint DCI_CHROMAKEY = 0x00000020U;
enum uint DCI_1632_ACCESS = 0x00000040U;

enum : uint
{
    DCI_DWORDSIZE  = 0x00000080U,
    DCI_DWORDALIGN = 0x00000100U,
}

enum uint DCI_WRITEONLY = 0x00000200U;

enum : uint
{
    DCI_ASYNC         = 0x00000400U,
    DCI_CAN_STRETCHX  = 0x00001000U,
    DCI_CAN_STRETCHY  = 0x00002000U,
    DCI_CAN_STRETCHXN = 0x00004000U,
    DCI_CAN_STRETCHYN = 0x00008000U,
    DCI_CANOVERLAY    = 0x00010000U,
}

enum uint FILE_FLAG_OPEN_REQUIRING_OPLOCK = 0x00040000U;
enum uint FILE_FLAG_IGNORE_IMPERSONATED_DEVICEMAP = 0x00020000U;
enum uint FILE_FLAG_DISALLOW_PATH_REDIRECTS = 0x00010000U;
enum uint FAIL_FAST_GENERATE_EXCEPTION_ADDRESS = 0x00000001U;
enum uint FAIL_FAST_NO_HARD_ERROR_DLG = 0x00000002U;
enum uint SP_SERIALCOMM = 0x00000001U;
enum uint PST_UNSPECIFIED = 0x00000000U;

enum : uint
{
    PST_RS232        = 0x00000001U,
    PST_PARALLELPORT = 0x00000002U,
}

enum : uint
{
    PST_RS422   = 0x00000003U,
    PST_RS423   = 0x00000004U,
    PST_RS449   = 0x00000005U,
    PST_MODEM   = 0x00000006U,
    PST_FAX     = 0x00000021U,
    PST_SCANNER = 0x00000022U,
}

enum uint PST_NETWORK_BRIDGE = 0x00000100U;

enum : uint
{
    PST_LAT          = 0x00000101U,
    PST_TCPIP_TELNET = 0x00000102U,
}

enum uint PST_X25 = 0x00000103U;
enum uint PCF_DTRDSR = 0x00000001U;

enum : uint
{
    PCF_RTSCTS       = 0x00000002U,
    PCF_RLSD         = 0x00000004U,
    PCF_PARITY_CHECK = 0x00000008U,
}

enum uint PCF_XONXOFF = 0x00000010U;
enum uint PCF_SETXCHAR = 0x00000020U;
enum uint PCF_TOTALTIMEOUTS = 0x00000040U;
enum uint PCF_INTTIMEOUTS = 0x00000080U;
enum uint PCF_SPECIALCHARS = 0x00000100U;
enum uint PCF_16BITMODE = 0x00000200U;
enum uint SP_PARITY = 0x00000001U;

enum : uint
{
    SP_BAUD     = 0x00000002U,
    SP_DATABITS = 0x00000004U,
}

enum uint SP_STOPBITS = 0x00000008U;
enum uint SP_HANDSHAKING = 0x00000010U;
enum uint SP_PARITY_CHECK = 0x00000020U;
enum uint SP_RLSD = 0x00000040U;

enum : uint
{
    BAUD_075    = 0x00000001U,
    BAUD_110    = 0x00000002U,
    BAUD_134_5  = 0x00000004U,
    BAUD_150    = 0x00000008U,
    BAUD_300    = 0x00000010U,
    BAUD_600    = 0x00000020U,
    BAUD_1200   = 0x00000040U,
    BAUD_1800   = 0x00000080U,
    BAUD_2400   = 0x00000100U,
    BAUD_4800   = 0x00000200U,
    BAUD_7200   = 0x00000400U,
    BAUD_9600   = 0x00000800U,
    BAUD_14400  = 0x00001000U,
    BAUD_19200  = 0x00002000U,
    BAUD_38400  = 0x00004000U,
    BAUD_56K    = 0x00008000U,
    BAUD_128K   = 0x00010000U,
    BAUD_115200 = 0x00020000U,
    BAUD_57600  = 0x00040000U,
    BAUD_USER   = 0x10000000U,
}

enum uint COMMPROP_INITIALIZED = 0xe73cf52eU;

enum : uint
{
    DTR_CONTROL_DISABLE   = 0x00000000U,
    DTR_CONTROL_ENABLE    = 0x00000001U,
    DTR_CONTROL_HANDSHAKE = 0x00000002U,
}

enum : uint
{
    RTS_CONTROL_DISABLE   = 0x00000000U,
    RTS_CONTROL_ENABLE    = 0x00000001U,
    RTS_CONTROL_HANDSHAKE = 0x00000002U,
    RTS_CONTROL_TOGGLE    = 0x00000003U,
}

enum : uint
{
    GMEM_NOCOMPACT = 0x00000010U,
    GMEM_NODISCARD = 0x00000020U,
}

enum : uint
{
    GMEM_MODIFY      = 0x00000080U,
    GMEM_DISCARDABLE = 0x00000100U,
}

enum uint GMEM_NOT_BANKED = 0x00001000U;

enum : uint
{
    GMEM_SHARE    = 0x00002000U,
    GMEM_DDESHARE = 0x00002000U,
}

enum : uint
{
    GMEM_NOTIFY      = 0x00004000U,
    GMEM_LOWER       = 0x00001000U,
    GMEM_VALID_FLAGS = 0x00007f72U,
}

enum uint GMEM_INVALID_HANDLE = 0x00008000U;
enum uint GMEM_DISCARDED = 0x00004000U;
enum uint GMEM_LOCKCOUNT = 0x000000ffU;
enum uint THREAD_PRIORITY_ERROR_RETURN = 0x7fffffffU;

enum : uint
{
    DRIVE_UNKNOWN     = 0x00000000U,
    DRIVE_NO_ROOT_DIR = 0x00000001U,
}

enum uint DRIVE_REMOVABLE = 0x00000002U;

enum : uint
{
    DRIVE_FIXED   = 0x00000003U,
    DRIVE_REMOTE  = 0x00000004U,
    DRIVE_CDROM   = 0x00000005U,
    DRIVE_RAMDISK = 0x00000006U,
}

enum uint IGNORE = 0x00000000U;

enum : uint
{
    CBR_110    = 0x0000006eU,
    CBR_300    = 0x0000012cU,
    CBR_600    = 0x00000258U,
    CBR_1200   = 0x000004b0U,
    CBR_2400   = 0x00000960U,
    CBR_4800   = 0x000012c0U,
    CBR_9600   = 0x00002580U,
    CBR_14400  = 0x00003840U,
    CBR_19200  = 0x00004b00U,
    CBR_38400  = 0x00009600U,
    CBR_56000  = 0x0000dac0U,
    CBR_57600  = 0x0000e100U,
    CBR_115200 = 0x0001c200U,
    CBR_128000 = 0x0001f400U,
}

enum uint CBR_256000 = 0x0003e800U;
enum uint CE_TXFULL = 0x00000100U;

enum : uint
{
    CE_PTO  = 0x00000200U,
    CE_IOE  = 0x00000400U,
    CE_DNS  = 0x00000800U,
    CE_OOP  = 0x00001000U,
    CE_MODE = 0x00008000U,
}

enum int IE_BADID = 0xffffffff;

enum : int
{
    IE_OPEN  = 0xfffffffe,
    IE_NOPEN = 0xfffffffd,
}

enum int IE_MEMORY = 0xfffffffc;
enum int IE_DEFAULT = 0xfffffffb;
enum int IE_HARDWARE = 0xfffffff6;
enum int IE_BYTESIZE = 0xfffffff5;
enum int IE_BAUDRATE = 0xfffffff4;
enum uint RESETDEV = 0x00000007U;
enum uint LPTx = 0x00000080U;
enum uint S_QUEUEEMPTY = 0x00000000U;
enum uint S_THRESHOLD = 0x00000001U;
enum uint S_ALLTHRESHOLD = 0x00000002U;
enum uint S_NORMAL = 0x00000000U;
enum uint S_LEGATO = 0x00000001U;
enum uint S_STACCATO = 0x00000002U;

enum : uint
{
    S_PERIOD512   = 0x00000000U,
    S_PERIOD1024  = 0x00000001U,
    S_PERIOD2048  = 0x00000002U,
    S_PERIODVOICE = 0x00000003U,
}

enum : uint
{
    S_WHITE512   = 0x00000004U,
    S_WHITE1024  = 0x00000005U,
    S_WHITE2048  = 0x00000006U,
    S_WHITEVOICE = 0x00000007U,
}

enum : int
{
    S_SERDVNA = 0xffffffff,
    S_SEROFM  = 0xfffffffe,
    S_SERMACT = 0xfffffffd,
    S_SERQFUL = 0xfffffffc,
    S_SERBDNT = 0xfffffffb,
    S_SERDLN  = 0xfffffffa,
    S_SERDCC  = 0xfffffff9,
    S_SERDTP  = 0xfffffff8,
    S_SERDVL  = 0xfffffff7,
    S_SERDMD  = 0xfffffff6,
    S_SERDSH  = 0xfffffff5,
    S_SERDPT  = 0xfffffff4,
    S_SERDFQ  = 0xfffffff3,
    S_SERDDR  = 0xfffffff2,
    S_SERDSR  = 0xfffffff1,
    S_SERDST  = 0xfffffff0,
}

enum uint FS_CASE_IS_PRESERVED = 0x00000002U;
enum uint FS_CASE_SENSITIVE = 0x00000001U;
enum uint FS_UNICODE_STORED_ON_DISK = 0x00000004U;
enum uint FS_PERSISTENT_ACLS = 0x00000008U;
enum uint FS_VOL_IS_COMPRESSED = 0x00008000U;

enum : uint
{
    FS_FILE_COMPRESSION = 0x00000010U,
    FS_FILE_ENCRYPTION  = 0x00020000U,
}

enum uint OFS_MAXPATHNAME = 0x00000080U;
enum uint MAXINTATOM = 0x0000c000U;
enum uint SCS_32BIT_BINARY = 0x00000000U;
enum uint SCS_DOS_BINARY = 0x00000001U;
enum uint SCS_WOW_BINARY = 0x00000002U;
enum uint SCS_PIF_BINARY = 0x00000003U;
enum uint SCS_POSIX_BINARY = 0x00000004U;
enum uint SCS_OS216_BINARY = 0x00000005U;
enum uint SCS_64BIT_BINARY = 0x00000006U;
enum uint SCS_THIS_PLATFORM_BINARY = 0x00000006U;
enum uint FIBER_FLAG_FLOAT_SWITCH = 0x00000001U;
enum uint UMS_VERSION = 0x00000100U;
enum uint FILE_SKIP_COMPLETION_PORT_ON_SUCCESS = 0x00000001U;
enum uint FILE_SKIP_SET_EVENT_ON_HANDLE = 0x00000002U;
enum uint CRITICAL_SECTION_NO_DEBUG_INFO = 0x01000000U;
enum uint HINSTANCE_ERROR = 0x00000020U;
enum uint FORMAT_MESSAGE_MAX_WIDTH_MASK = 0x000000ffU;
enum uint FILE_ENCRYPTABLE = 0x00000000U;
enum uint FILE_IS_ENCRYPTED = 0x00000001U;
enum uint FILE_SYSTEM_ATTR = 0x00000002U;
enum uint FILE_ROOT_DIR = 0x00000003U;
enum uint FILE_SYSTEM_DIR = 0x00000004U;

enum : uint
{
    FILE_UNKNOWN            = 0x00000005U,
    FILE_SYSTEM_NOT_SUPPORT = 0x00000006U,
}

enum uint FILE_USER_DISALLOWED = 0x00000007U;
enum uint FILE_READ_ONLY = 0x00000008U;
enum uint FILE_DIR_DISALLOWED = 0x00000009U;
enum uint EFS_USE_RECOVERY_KEYS = 0x00000001U;

enum : uint
{
    CREATE_FOR_IMPORT = 0x00000001U,
    CREATE_FOR_DIR    = 0x00000002U,
}

enum uint OVERWRITE_HIDDEN = 0x00000004U;
enum uint EFSRPC_SECURE_ONLY = 0x00000008U;
enum uint EFS_DROP_ALTERNATE_STREAMS = 0x00000010U;

enum : uint
{
    BACKUP_INVALID              = 0x00000000U,
    BACKUP_GHOSTED_FILE_EXTENTS = 0x0000000bU,
}

enum uint STREAM_NORMAL_ATTRIBUTE = 0x00000000U;
enum uint STREAM_MODIFIED_WHEN_READ = 0x00000001U;

enum : uint
{
    STREAM_CONTAINS_SECURITY   = 0x00000002U,
    STREAM_CONTAINS_PROPERTIES = 0x00000004U,
}

enum uint STREAM_SPARSE_ATTRIBUTE = 0x00000008U;
enum uint STREAM_CONTAINS_GHOSTED_FILE_EXTENTS = 0x00000010U;
enum uint STARTF_HOLOGRAPHIC = 0x00040000U;
enum uint SHUTDOWN_NORETRY = 0x00000001U;
enum uint PROTECTION_LEVEL_SAME = 0xffffffffU;
enum uint ATOM_FLAG_GLOBAL = 0x00000002U;

enum : const(wchar)*
{
    // Native encoding: ansi
    GET_SYSTEM_WOW64_DIRECTORY_NAME_A_A = "GetSystemWow64DirectoryA",
    GET_SYSTEM_WOW64_DIRECTORY_NAME_A_W = "GetSystemWow64DirectoryA",
    GET_SYSTEM_WOW64_DIRECTORY_NAME_A_T = "GetSystemWow64DirectoryA",
    // Native encoding: ansi
    GET_SYSTEM_WOW64_DIRECTORY_NAME_W_A = "GetSystemWow64DirectoryW",
    GET_SYSTEM_WOW64_DIRECTORY_NAME_W_W = "GetSystemWow64DirectoryW",
    GET_SYSTEM_WOW64_DIRECTORY_NAME_W_T = "GetSystemWow64DirectoryW",
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_A = "GetSystemWow64DirectoryW",
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_W = "GetSystemWow64DirectoryW",
    GET_SYSTEM_WOW64_DIRECTORY_NAME_T_T = "GetSystemWow64DirectoryW",
}

enum : uint
{
    BASE_SEARCH_PATH_ENABLE_SAFE_SEARCHMODE  = 0x00000001U,
    BASE_SEARCH_PATH_DISABLE_SAFE_SEARCHMODE = 0x00010000U,
    BASE_SEARCH_PATH_PERMANENT               = 0x00008000U,
}

enum uint EVENTLOG_FULL_INFO = 0x00000000U;
enum uint OPERATION_API_VERSION = 0x00000001U;
enum uint MAX_COMPUTERNAME_LENGTH = 0x0000000fU;

enum : uint
{
    LOGON32_PROVIDER_WINNT35 = 0x00000001U,
    LOGON32_PROVIDER_VIRTUAL = 0x00000004U,
}

enum uint LOGON_ZERO_PASSWORD_BUFFER = 0x80000000U;
enum uint HW_PROFILE_GUIDLEN = 0x00000027U;

enum : uint
{
    DOCKINFO_UNDOCKED      = 0x00000001U,
    DOCKINFO_DOCKED        = 0x00000002U,
    DOCKINFO_USER_SUPPLIED = 0x00000004U,
}

enum uint TC_NORMAL = 0x00000000U;
enum uint TC_HARDERR = 0x00000001U;
enum uint TC_GP_TRAP = 0x00000002U;
enum uint TC_SIGNAL = 0x00000003U;

enum : uint
{
    AC_LINE_OFFLINE      = 0x00000000U,
    AC_LINE_ONLINE       = 0x00000001U,
    AC_LINE_BACKUP_POWER = 0x00000002U,
}

enum uint AC_LINE_UNKNOWN = 0x000000ffU;

enum : uint
{
    BATTERY_FLAG_HIGH       = 0x00000001U,
    BATTERY_FLAG_LOW        = 0x00000002U,
    BATTERY_FLAG_CRITICAL   = 0x00000004U,
    BATTERY_FLAG_CHARGING   = 0x00000008U,
    BATTERY_FLAG_NO_BATTERY = 0x00000080U,
    BATTERY_FLAG_UNKNOWN    = 0x000000ffU,
}

enum uint BATTERY_PERCENTAGE_UNKNOWN = 0x000000ffU;
enum uint SYSTEM_STATUS_FLAG_POWER_SAVING_ON = 0x00000001U;
enum uint BATTERY_LIFE_UNKNOWN = 0xffffffffU;
enum uint ACTCTX_FLAG_PROCESSOR_ARCHITECTURE_VALID = 0x00000001U;

enum : uint
{
    ACTCTX_FLAG_LANGID_VALID             = 0x00000002U,
    ACTCTX_FLAG_ASSEMBLY_DIRECTORY_VALID = 0x00000004U,
}

enum uint ACTCTX_FLAG_RESOURCE_NAME_VALID = 0x00000008U;
enum uint ACTCTX_FLAG_SET_PROCESS_DEFAULT = 0x00000010U;
enum uint ACTCTX_FLAG_APPLICATION_NAME_VALID = 0x00000020U;
enum uint ACTCTX_FLAG_SOURCE_IS_ASSEMBLYREF = 0x00000040U;
enum uint ACTCTX_FLAG_HMODULE_VALID = 0x00000080U;
enum uint DEACTIVATE_ACTCTX_FLAG_FORCE_EARLY_DEACTIVATION = 0x00000001U;

enum : uint
{
    FIND_ACTCTX_SECTION_KEY_RETURN_HACTCTX           = 0x00000001U,
    FIND_ACTCTX_SECTION_KEY_RETURN_FLAGS             = 0x00000002U,
    FIND_ACTCTX_SECTION_KEY_RETURN_ASSEMBLY_METADATA = 0x00000004U,
}

enum uint ACTIVATION_CONTEXT_BASIC_INFORMATION_DEFINED = 0x00000001U;

enum : uint
{
    QUERY_ACTCTX_FLAG_USE_ACTIVE_ACTCTX = 0x00000004U,
    QUERY_ACTCTX_FLAG_ACTCTX_IS_HMODULE = 0x00000008U,
    QUERY_ACTCTX_FLAG_ACTCTX_IS_ADDRESS = 0x00000010U,
    QUERY_ACTCTX_FLAG_NO_ADDREF         = 0x80000000U,
}

enum uint RESTART_MAX_CMD_LINE = 0x00000400U;
enum uint RECOVERY_DEFAULT_PING_INTERVAL = 0x00001388U;

enum : uint
{
    FILE_RENAME_FLAG_REPLACE_IF_EXISTS              = 0x00000001U,
    FILE_RENAME_FLAG_POSIX_SEMANTICS                = 0x00000002U,
    FILE_RENAME_FLAG_SUPPRESS_PIN_STATE_INHERITANCE = 0x00000004U,
}

enum : uint
{
    STORAGE_INFO_FLAGS_ALIGNED_DEVICE              = 0x00000001U,
    STORAGE_INFO_FLAGS_PARTITION_ALIGNED_ON_DEVICE = 0x00000002U,
}

enum uint STORAGE_INFO_OFFSET_UNKNOWN = 0xffffffffU;

enum : uint
{
    REMOTE_PROTOCOL_INFO_FLAG_LOOPBACK          = 0x00000001U,
    REMOTE_PROTOCOL_INFO_FLAG_OFFLINE           = 0x00000002U,
    REMOTE_PROTOCOL_INFO_FLAG_PERSISTENT_HANDLE = 0x00000004U,
}

enum : uint
{
    RPI_FLAG_SMB2_SHARECAP_TIMEWARP                = 0x00000002U,
    RPI_FLAG_SMB2_SHARECAP_DFS                     = 0x00000008U,
    RPI_FLAG_SMB2_SHARECAP_CONTINUOUS_AVAILABILITY = 0x00000010U,
    RPI_FLAG_SMB2_SHARECAP_SCALEOUT                = 0x00000020U,
    RPI_FLAG_SMB2_SHARECAP_CLUSTER                 = 0x00000040U,
}

enum : uint
{
    RPI_SMB2_SHAREFLAG_ENCRYPT_DATA  = 0x00000001U,
    RPI_SMB2_SHAREFLAG_COMPRESS_DATA = 0x00000002U,
}

enum : uint
{
    RPI_SMB2_FLAG_SERVERCAP_DFS                = 0x00000001U,
    RPI_SMB2_FLAG_SERVERCAP_LEASING            = 0x00000002U,
    RPI_SMB2_FLAG_SERVERCAP_LARGEMTU           = 0x00000004U,
    RPI_SMB2_FLAG_SERVERCAP_MULTICHANNEL       = 0x00000008U,
    RPI_SMB2_FLAG_SERVERCAP_PERSISTENT_HANDLES = 0x00000010U,
    RPI_SMB2_FLAG_SERVERCAP_DIRECTORY_LEASING  = 0x00000020U,
}

enum uint MICROSOFT_WINDOWS_WINBASE_H_DEFINE_INTERLOCKED_CPLUSPLUS_OVERLOADS = 0x00000000U;
enum uint MICROSOFT_WINBASE_H_DEFINE_INTERLOCKED_CPLUSPLUS_OVERLOADS = 0x00000000U;

enum : uint
{
    CODEINTEGRITY_OPTION_ENABLED                      = 0x00000001U,
    CODEINTEGRITY_OPTION_TESTSIGN                     = 0x00000002U,
    CODEINTEGRITY_OPTION_UMCI_ENABLED                 = 0x00000004U,
    CODEINTEGRITY_OPTION_UMCI_AUDITMODE_ENABLED       = 0x00000008U,
    CODEINTEGRITY_OPTION_UMCI_EXCLUSIONPATHS_ENABLED  = 0x00000010U,
    CODEINTEGRITY_OPTION_TEST_BUILD                   = 0x00000020U,
    CODEINTEGRITY_OPTION_PREPRODUCTION_BUILD          = 0x00000040U,
    CODEINTEGRITY_OPTION_DEBUGMODE_ENABLED            = 0x00000080U,
    CODEINTEGRITY_OPTION_FLIGHT_BUILD                 = 0x00000100U,
    CODEINTEGRITY_OPTION_FLIGHTING_ENABLED            = 0x00000200U,
    CODEINTEGRITY_OPTION_HVCI_KMCI_ENABLED            = 0x00000400U,
    CODEINTEGRITY_OPTION_HVCI_KMCI_AUDITMODE_ENABLED  = 0x00000800U,
    CODEINTEGRITY_OPTION_HVCI_KMCI_STRICTMODE_ENABLED = 0x00001000U,
    CODEINTEGRITY_OPTION_HVCI_IUM_ENABLED             = 0x00002000U,
}

enum uint FILE_MAXIMUM_DISPOSITION = 0x00000005U;
enum uint FILE_OPEN_REMOTE_INSTANCE = 0x00000400U;
enum uint FILE_NO_COMPRESSION = 0x00008000U;
enum uint FILE_OPEN_NO_RECALL = 0x00400000U;

enum : uint
{
    FILE_VALID_OPTION_FLAGS      = 0x00ffffffU,
    FILE_VALID_PIPE_OPTION_FLAGS = 0x00000032U,
}

enum uint FILE_VALID_MAILSLOT_OPTION_FLAGS = 0x00000032U;
enum uint FILE_VALID_SET_FLAGS = 0x00000036U;
enum uint FILE_SUPERSEDED = 0x00000000U;

enum : uint
{
    FILE_OPENED      = 0x00000001U,
    FILE_CREATED     = 0x00000002U,
    FILE_OVERWRITTEN = 0x00000003U,
}

enum : uint
{
    FILE_EXISTS         = 0x00000004U,
    FILE_DOES_NOT_EXIST = 0x00000005U,
}

enum : uint
{
    WINWATCHNOTIFY_START    = 0x00000000U,
    WINWATCHNOTIFY_STOP     = 0x00000001U,
    WINWATCHNOTIFY_DESTROY  = 0x00000002U,
    WINWATCHNOTIFY_CHANGING = 0x00000003U,
    WINWATCHNOTIFY_CHANGED  = 0x00000004U,
}

enum : uint
{
    RSC_FLAG_INF                = 0x00000001U,
    RSC_FLAG_SKIPDISKSPACECHECK = 0x00000002U,
}

enum : uint
{
    RSC_FLAG_QUIET            = 0x00000004U,
    RSC_FLAG_NGCONV           = 0x00000008U,
    RSC_FLAG_UPDHLPDLLS       = 0x00000010U,
    RSC_FLAG_DELAYREGISTEROCX = 0x00000200U,
}

enum uint RSC_FLAG_SETUPAPI = 0x00000400U;

enum : uint
{
    ALINF_QUIET      = 0x00000004U,
    ALINF_NGCONV     = 0x00000008U,
    ALINF_UPDHLPDLLS = 0x00000010U,
}

enum uint ALINF_BKINSTALL = 0x00000020U;

enum : uint
{
    ALINF_ROLLBACK    = 0x00000040U,
    ALINF_CHECKBKDATA = 0x00000080U,
}

enum uint ALINF_ROLLBKDOALL = 0x00000100U;
enum uint ALINF_DELAYREGISTEROCX = 0x00000200U;
enum uint AIF_WARNIFSKIP = 0x00000001U;

enum : uint
{
    AIF_NOSKIP         = 0x00000002U,
    AIF_NOVERSIONCHECK = 0x00000004U,
}

enum uint AIF_FORCE_FILE_IN_USE = 0x00000008U;
enum uint AIF_NOOVERWRITE = 0x00000010U;
enum uint AIF_NO_VERSION_DIALOG = 0x00000020U;
enum uint AIF_REPLACEONLY = 0x00000400U;
enum uint AIF_NOLANGUAGECHECK = 0x10000000U;
enum uint AIF_QUIET = 0x20000000U;
enum uint IE4_RESTORE = 0x00000001U;
enum uint IE4_BACKNEW = 0x00000002U;
enum uint IE4_NODELETENEW = 0x00000004U;

enum : uint
{
    IE4_NOMESSAGES     = 0x00000008U,
    IE4_NOPROGRESS     = 0x00000010U,
    IE4_NOENUMKEY      = 0x00000020U,
    IE4_NO_CRC_MAPPING = 0x00000040U,
}

enum uint IE4_REGSECTION = 0x00000080U;
enum uint IE4_FRDOALL = 0x00000100U;
enum uint IE4_UPDREFCNT = 0x00000200U;
enum uint IE4_USEREFCNT = 0x00000400U;
enum uint IE4_EXTRAINCREFCNT = 0x00000800U;
enum uint IE4_REMOVREGBKDATA = 0x00001000U;

enum : uint
{
    ARSR_RESTORE    = 0x00000001U,
    ARSR_NOMESSAGES = 0x00000008U,
}

enum : uint
{
    ARSR_REGSECTION     = 0x00000080U,
    ARSR_REMOVREGBKDATA = 0x00001000U,
}

enum const(wchar)* REG_SAVE_LOG_KEY = "RegSaveLogFile";
enum const(wchar)* REG_RESTORE_LOG_KEY = "RegRestoreLogFile";

enum : uint
{
    AFSR_RESTORE     = 0x00000001U,
    AFSR_BACKNEW     = 0x00000002U,
    AFSR_NODELETENEW = 0x00000004U,
    AFSR_NOMESSAGES  = 0x00000008U,
    AFSR_NOPROGRESS  = 0x00000010U,
}

enum : uint
{
    AFSR_UPDREFCNT = 0x00000200U,
    AFSR_USEREFCNT = 0x00000400U,
}

enum uint AFSR_EXTRAINCREFCNT = 0x00000800U;
enum uint AADBE_ADD_ENTRY = 0x00000001U;
enum uint AADBE_DEL_ENTRY = 0x00000002U;
enum uint ADN_DEL_IF_EMPTY = 0x00000001U;

enum : uint
{
    ADN_DONT_DEL_SUBDIRS = 0x00000002U,
    ADN_DONT_DEL_DIR     = 0x00000004U,
}

enum uint ADN_DEL_UNC_PATHS = 0x00000008U;

enum : uint
{
    LIS_QUIET     = 0x00000001U,
    LIS_NOGRPCONV = 0x00000002U,
}

enum : uint
{
    RUNCMDS_QUIET        = 0x00000001U,
    RUNCMDS_NOWAIT       = 0x00000002U,
    RUNCMDS_DELAYPOSTCMD = 0x00000004U,
}

enum uint IME_MAXPROCESS = 0x00000020U;

enum : uint
{
    CP_HWND   = 0x00000000U,
    CP_OPEN   = 0x00000001U,
    CP_DIRECT = 0x00000002U,
}

enum uint CP_LEVEL = 0x00000003U;
enum uint MCW_DEFAULT = 0x00000000U;

enum : uint
{
    MCW_RECT   = 0x00000001U,
    MCW_WINDOW = 0x00000002U,
}

enum uint MCW_SCREEN = 0x00000004U;
enum uint MCW_VERTICAL = 0x00000008U;
enum uint MCW_HIDDEN = 0x00000010U;

enum : uint
{
    IME_MODE_ALPHANUMERIC = 0x00000001U,
    IME_MODE_SBCSCHAR     = 0x00000002U,
    IME_MODE_KATAKANA     = 0x00000002U,
    IME_MODE_HIRAGANA     = 0x00000004U,
    IME_MODE_HANJACONVERT = 0x00000004U,
    IME_MODE_DBCSCHAR     = 0x00000010U,
    IME_MODE_ROMAN        = 0x00000020U,
    IME_MODE_NOROMAN      = 0x00000040U,
    IME_MODE_CODEINPUT    = 0x00000080U,
    IME_MODE_NOCODEINPUT  = 0x00000100U,
}

enum uint IME_GETIMECAPS = 0x00000003U;
enum uint IME_SETOPEN = 0x00000004U;

enum : uint
{
    IME_GETOPEN    = 0x00000005U,
    IME_GETVERSION = 0x00000007U,
}

enum uint IME_SETCONVERSIONWINDOW = 0x00000008U;
enum uint IME_MOVEIMEWINDOW = 0x00000008U;
enum uint IME_SETCONVERSIONMODE = 0x00000010U;
enum uint IME_GETCONVERSIONMODE = 0x00000011U;

enum : uint
{
    IME_SET_MODE = 0x00000012U,
    IME_SENDVKEY = 0x00000013U,
}

enum uint IME_ENTERWORDREGISTERMODE = 0x00000018U;
enum uint IME_SETCONVERSIONFONTEX = 0x00000019U;
enum uint IME_BANJAtoJUNJA = 0x00000013U;
enum uint IME_JUNJAtoBANJA = 0x00000014U;
enum uint IME_JOHABtoKS = 0x00000015U;
enum uint IME_KStoJOHAB = 0x00000016U;

enum : uint
{
    IMEA_INIT = 0x00000001U,
    IMEA_NEXT = 0x00000002U,
    IMEA_PREV = 0x00000003U,
}

enum uint IME_REQUEST_CONVERT = 0x00000001U;
enum uint IME_ENABLE_CONVERT = 0x00000002U;
enum uint INTERIM_WINDOW = 0x00000000U;
enum uint MODE_WINDOW = 0x00000001U;
enum uint HANJA_WINDOW = 0x00000002U;

enum : uint
{
    IME_RS_ERROR       = 0x00000001U,
    IME_RS_NOIME       = 0x00000002U,
    IME_RS_TOOLONG     = 0x00000005U,
    IME_RS_ILLEGAL     = 0x00000006U,
    IME_RS_NOTFOUND    = 0x00000007U,
    IME_RS_NOROOM      = 0x0000000aU,
    IME_RS_DISKERROR   = 0x0000000eU,
    IME_RS_INVALID     = 0x00000011U,
    IME_RS_NEST        = 0x00000012U,
    IME_RS_SYSTEMMODAL = 0x00000013U,
}

enum uint WM_IME_REPORT = 0x00000280U;

enum : uint
{
    IR_STRINGSTART = 0x00000100U,
    IR_STRINGEND   = 0x00000101U,
}

enum uint IR_OPENCONVERT = 0x00000120U;
enum uint IR_CHANGECONVERT = 0x00000121U;
enum uint IR_CLOSECONVERT = 0x00000122U;
enum uint IR_FULLCONVERT = 0x00000123U;
enum uint IR_IMESELECT = 0x00000130U;
enum uint IR_STRING = 0x00000140U;
enum uint IR_DBCSCHAR = 0x00000160U;
enum uint IR_UNDETERMINE = 0x00000170U;
enum uint IR_STRINGEX = 0x00000180U;
enum uint IR_MODEINFO = 0x00000190U;
enum uint WM_WNT_CONVERTREQUESTEX = 0x00000109U;

enum : uint
{
    WM_CONVERTREQUEST = 0x0000010aU,
    WM_CONVERTRESULT  = 0x0000010bU,
}

enum uint WM_INTERIM = 0x0000010cU;

enum : uint
{
    WM_IMEKEYDOWN = 0x00000290U,
    WM_IMEKEYUP   = 0x00000291U,
}

enum uint DELAYLOAD_GPA_FAILURE = 0x00000004U;
enum GUID CATID_DeleteBrowsingHistory = GUID("31caf6e4-d6aa-4090-a050-a5ac8972e9ef");

enum : uint
{
    DELETE_BROWSING_HISTORY_HISTORY           = 0x00000001U,
    DELETE_BROWSING_HISTORY_COOKIES           = 0x00000002U,
    DELETE_BROWSING_HISTORY_TIF               = 0x00000004U,
    DELETE_BROWSING_HISTORY_FORMDATA          = 0x00000008U,
    DELETE_BROWSING_HISTORY_PASSWORDS         = 0x00000010U,
    DELETE_BROWSING_HISTORY_PRESERVEFAVORITES = 0x00000020U,
    DELETE_BROWSING_HISTORY_DOWNLOADHISTORY   = 0x00000040U,
}

enum : GUID
{
    WLDP_HOST_CMD                 = GUID("5baea1d6-6f1c-488e-8490-347fa5c5067f"),
    WLDP_HOST_POWERSHELL          = GUID("8e9aaa7c-198b-4879-ae41-a50d47ad6458"),
    WLDP_HOST_PYTHON              = GUID("bfd557ef-2448-42ec-810b-0d9f09352d4a"),
    WLDP_HOST_WINDOWS_SCRIPT_HOST = GUID("d30b84c5-29ce-4ff3-86ec-a30007a82e49"),
}

enum : GUID
{
    WLDP_HOST_JAVASCRIPT = GUID("5629f0d5-1cca-4fed-a1a3-36a8c18d74c0"),
    WLDP_HOST_HTML       = GUID("b35a71b6-fe56-48d6-9543-2dff0ecded66"),
    WLDP_HOST_XML        = GUID("5594be58-c6bf-4295-82f4-d494d20e3a36"),
    WLDP_HOST_MSI        = GUID("624eb611-6e7e-4eec-9bfe-f0ecdbfcf390"),
    WLDP_HOST_OTHER      = GUID("626cbec3-e1fa-4227-9800-ed210274cf7c"),
}

// Callbacks

alias PFIBER_CALLOUT_ROUTINE = void* function(void* lpParameter);
alias PQUERYACTCTXW_FUNC = BOOL function(uint dwFlags, HANDLE hActCtx, void* pvSubInstance, uint ulInfoClass, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvBuffer, 
                                         size_t cbBuffer, size_t* pcbWrittenOrRequired);
alias APPLICATION_RECOVERY_CALLBACK = uint function(void* pvParameter);
alias PWINSTATIONQUERYINFORMATIONW = BOOLEAN function(HANDLE param0, uint param1, WINSTATIONINFOCLASS param2, 
                                                      void* param3, uint param4, uint* param5);
alias PFEATURE_STATE_CHANGE_CALLBACK = void function(void* context);
alias ENUM_CALLBACK = void function(DCISURFACEINFO* lpSurfaceInfo, void* lpContext);
alias WINWATCHNOTIFYPROC = void function(HWINWATCH hww, HWND hwnd, uint code, LPARAM lParam);
alias REGINSTALLA = HRESULT function(HMODULE hm, const(PSTR) pszSection, const(STRTABLEA)* pstTable);
alias PWLDP_QUERYSECURITYPOLICY_API = HRESULT function(const(UNICODE_STRING)* providerName, 
                                                       const(UNICODE_STRING)* keyName, 
                                                       const(UNICODE_STRING)* valueName, 
                                                       WLDP_SECURE_SETTING_VALUE_TYPE* valueType, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* valueAddress, 
                                                       uint* valueSize);
alias PWLDP_SETDYNAMICCODETRUST_API = HRESULT function(HANDLE hFileHandle);
alias PWLDP_ISDYNAMICCODEPOLICYENABLED_API = HRESULT function(BOOL* pbEnabled);
alias PWLDP_QUERYDYNAMICODETRUST_API = HRESULT function(HANDLE fileHandle, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* baseImage, 
                                                        uint imageSize);
alias PWLDP_QUERYWINDOWSLOCKDOWNMODE_API = HRESULT function(WLDP_WINDOWS_LOCKDOWN_MODE* lockdownMode);
alias PWLDP_QUERYDEVICESECURITYINFORMATION_API = HRESULT function(WLDP_DEVICE_SECURITY_INFORMATION* information, 
                                                                  uint informationLength, uint* returnLength);
alias PWLDP_QUERYWINDOWSLOCKDOWNRESTRICTION_API = HRESULT function(WLDP_WINDOWS_LOCKDOWN_RESTRICTION* LockdownRestriction);
alias PWLDP_SETWINDOWSLOCKDOWNRESTRICTION_API = HRESULT function(WLDP_WINDOWS_LOCKDOWN_RESTRICTION LockdownRestriction);
alias PWLDP_ISAPPAPPROVEDBYPOLICY_API = HRESULT function(const(PWSTR) PackageFamilyName, ulong PackageVersion);
alias PWLDP_QUERYPOLICYSETTINGENABLED_API = HRESULT function(WLDP_POLICY_SETTING Setting, BOOL* Enabled);
alias PWLDP_QUERYPOLICYSETTINGENABLED2_API = HRESULT function(const(PWSTR) Setting, BOOL* Enabled);
alias PWLDP_ISWCOSPRODUCTIONCONFIGURATION_API = HRESULT function(BOOL* IsProductionConfiguration);
alias PWLDP_RESETWCOSPRODUCTIONCONFIGURATION_API = HRESULT function();
alias PWLDP_ISPRODUCTIONCONFIGURATION_API = HRESULT function(BOOL* IsProductionConfiguration);
alias PWLDP_RESETPRODUCTIONCONFIGURATION_API = HRESULT function();
alias PWLDP_CANEXECUTEFILE_API = HRESULT function(const(GUID)* host, WLDP_EXECUTION_EVALUATION_OPTIONS options, 
                                                  HANDLE fileHandle, const(PWSTR) auditInfo, 
                                                  WLDP_EXECUTION_POLICY* result);
alias PWLDP_CANEXECUTEBUFFER_API = HRESULT function(const(GUID)* host, WLDP_EXECUTION_EVALUATION_OPTIONS options, 
                                                    const(ubyte)* buffer, uint bufferSize, const(PWSTR) auditInfo, 
                                                    WLDP_EXECUTION_POLICY* result);
alias PWLDP_CANEXECUTESTREAM_API = HRESULT function(const(GUID)* host, WLDP_EXECUTION_EVALUATION_OPTIONS options, 
                                                    IStream stream, const(PWSTR) auditInfo, 
                                                    WLDP_EXECUTION_POLICY* result);
alias PWLDP_CANEXECUTEFILEFROMDETACHEDSIGNATURE_API = HRESULT function(const(GUID)* host, 
                                                                       WLDP_EXECUTION_EVALUATION_OPTIONS options, 
                                                                       HANDLE contentFileHandle, 
                                                                       HANDLE signatureFileHandle, 
                                                                       const(PWSTR) auditInfo, 
                                                                       WLDP_EXECUTION_POLICY* result);
alias PWLDP_GETAPPLICATIONSETTINGBOOLEAN_API = HRESULT function(const(PWSTR) id, const(PWSTR) setting, 
                                                                BOOL* result);
alias PWLDP_GETAPPLICATIONSETTINGSTRINGLIST_API = HRESULT function(const(PWSTR) id, const(PWSTR) setting, 
                                                                   size_t dataCount, size_t* requiredCount, 
                                                                   /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR result);
alias PWLDP_GETAPPLICATIONSETTINGSTRINGSET_API = HRESULT function(const(PWSTR) id, const(PWSTR) setting, 
                                                                  size_t dataCount, size_t* requiredCount, 
                                                                  /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR result);
alias PDELAYLOAD_FAILURE_DLL_CALLBACK = void* function(uint NotificationReason, DELAYLOAD_INFO* DelayloadInfo);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HWINWATCH
{
    void* Value;
}

@RAIIFree!UnsubscribeFeatureStateChangeNotification
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct FEATURE_STATE_CHANGE_SUBSCRIPTION
{
    void* Value;
}

version(X86_64)
{
    struct TCP_REQUEST_QUERY_INFORMATION_EX32_XP
    {
        TDIObjectID ID;
        uint[4]     Context;
    }
}

version(AArch64)
{
    struct TCP_REQUEST_QUERY_INFORMATION_EX32_XP
    {
        TDIObjectID ID;
        uint[4]     Context;
    }
}

version(X86_64)
{
    struct DELAYLOAD_INFO
    {
        uint                Size;
        IMAGE_DELAYLOAD_DESCRIPTOR* DelayloadDescriptor;
        IMAGE_THUNK_DATA64* ThunkAddress;
        const(PSTR)         TargetDllName;
        DELAYLOAD_PROC_DESCRIPTOR TargetApiDescriptor;
        void*               TargetModuleBase;
        void*               Unused;
        uint                LastError;
    }
}

version(AArch64)
{
    struct DELAYLOAD_INFO
    {
        uint                Size;
        IMAGE_DELAYLOAD_DESCRIPTOR* DelayloadDescriptor;
        IMAGE_THUNK_DATA64* ThunkAddress;
        const(PSTR)         TargetDllName;
        DELAYLOAD_PROC_DESCRIPTOR TargetApiDescriptor;
        void*               TargetModuleBase;
        void*               Unused;
        uint                LastError;
    }
}

struct IMAGE_THUNK_DATA64
{
    union u1
    {
        ulong ForwarderString;
        ulong Function;
        ulong Ordinal;
        ulong AddressOfData;
    }
}

struct IMAGE_THUNK_DATA32
{
    union u1
    {
        uint ForwarderString;
        uint Function;
        uint Ordinal;
        uint AddressOfData;
    }
}

struct IMAGE_DELAYLOAD_DESCRIPTOR
{
    union Attributes
    {
        uint AllAttributes;
        struct
        {
            // Native bit field: RvaBased: [0], ReservedAttributes: [1-31]
            uint _bitfield0;
        }
    }
    uint DllNameRVA;
    uint ModuleHandleRVA;
    uint ImportAddressTableRVA;
    uint ImportNameTableRVA;
    uint BoundImportAddressTableRVA;
    uint UnloadInformationTableRVA;
    uint TimeDateStamp;
}

struct CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG
{
    uint         Size;
    const(PWSTR) TriggerId;
}

struct JIT_DEBUG_INFO
{
    uint  dwSize;
    uint  dwProcessorArchitecture;
    uint  dwThreadID;
    uint  dwReserved0;
    ulong lpExceptionAddress;
    ulong lpExceptionRecord;
    ulong lpContextRecord;
}

union PROCESS_CREATION_SVE_VECTOR_LENGTH
{
    uint Data;
    struct
    {
        // Native bit field: VectorLength: [0-23], FlagsReserved: [24-31]
        uint _bitfield0;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-hw_profile_infoa
struct HW_PROFILE_INFOA
{
    uint     dwDockInfo;
    CHAR[39] szHwProfileGuid;
    CHAR[80] szHwProfileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-hw_profile_infow
struct HW_PROFILE_INFOW
{
    uint      dwDockInfo;
    wchar[39] szHwProfileGuid;
    wchar[80] szHwProfileName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct ACTCTX_SECTION_KEYED_DATA_2600
{
    uint   cbSize;
    uint   ulDataFormatVersion;
    void*  lpData;
    uint   ulLength;
    void*  lpSectionGlobalData;
    uint   ulSectionGlobalDataLength;
    void*  lpSectionBase;
    uint   ulSectionTotalLength;
    HANDLE hActCtx;
    uint   ulAssemblyRosterIndex;
}

struct ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
{
    void* lpInformation;
    void* lpSectionBase;
    uint  ulSectionLength;
    void* lpSectionGlobalDataBase;
    uint  ulSectionGlobalDataLength;
}

struct ACTIVATION_CONTEXT_BASIC_INFORMATION
{
    HANDLE hActCtx;
    uint   dwFlags;
}

struct CLIENT_ID
{
    HANDLE UniqueProcess;
    HANDLE UniqueThread;
}

struct LDR_DATA_TABLE_ENTRY
{
    void[2]*       Reserved1;
    LIST_ENTRY     InMemoryOrderLinks;
    void[2]*       Reserved2;
    void*          DllBase;
    void[2]*       Reserved3;
    UNICODE_STRING FullDllName;
    ubyte[8]       Reserved4;
    void[3]*       Reserved5;
    union
    {
        uint  CheckSum;
        void* Reserved6;
    }
    uint           TimeDateStamp;
}

struct SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION
{
    long    IdleTime;
    long    KernelTime;
    long    UserTime;
    long[2] Reserved1;
    uint    Reserved2;
}

struct SYSTEM_PROCESS_INFORMATION
{
    uint           NextEntryOffset;
    uint           NumberOfThreads;
    ubyte[48]      Reserved1;
    UNICODE_STRING ImageName;
    int            BasePriority;
    HANDLE         UniqueProcessId;
    void*          Reserved2;
    uint           HandleCount;
    uint           SessionId;
    void*          Reserved3;
    size_t         PeakVirtualSize;
    size_t         VirtualSize;
    uint           Reserved4;
    size_t         PeakWorkingSetSize;
    size_t         WorkingSetSize;
    void*          Reserved5;
    size_t         QuotaPagedPoolUsage;
    void*          Reserved6;
    size_t         QuotaNonPagedPoolUsage;
    size_t         PagefileUsage;
    size_t         PeakPagefileUsage;
    size_t         PrivatePageCount;
    long[6]        Reserved7;
}

struct SYSTEM_BASICPROCESS_INFORMATION
{
    uint           NextEntryOffset;
    HANDLE         UniqueProcessId;
    HANDLE         InheritedFromUniqueProcessId;
    ulong          SequenceNumber;
    UNICODE_STRING ImageName;
}

struct SYSTEM_HANDLECOUNT_INFORMATION
{
    uint ProcessCount;
    uint ThreadCount;
    uint HandleCount;
}

struct SYSTEM_THREAD_INFORMATION
{
    long[3]   Reserved1;
    uint      Reserved2;
    void*     StartAddress;
    CLIENT_ID ClientId;
    int       Priority;
    int       BasePriority;
    uint      Reserved3;
    uint      ThreadState;
    uint      WaitReason;
}

struct SYSTEM_REGISTRY_QUOTA_INFORMATION
{
    uint  RegistryQuotaAllowed;
    uint  RegistryQuotaUsed;
    void* Reserved1;
}

struct SYSTEM_BASIC_INFORMATION
{
    ubyte[24] Reserved1;
    void[4]*  Reserved2;
    byte      NumberOfProcessors;
}

struct SYSTEM_TIMEOFDAY_INFORMATION
{
    ubyte[48] Reserved1;
}

struct SYSTEM_PERFORMANCE_INFORMATION
{
    ubyte[312] Reserved1;
}

struct SYSTEM_EXCEPTION_INFORMATION
{
    ubyte[16] Reserved1;
}

struct SYSTEM_LOOKASIDE_INFORMATION
{
    ubyte[32] Reserved1;
}

struct SYSTEM_INTERRUPT_INFORMATION
{
    ubyte[24] Reserved1;
}

struct SYSTEM_POLICY_INFORMATION
{
    void[2]* Reserved1;
    uint[3]  Reserved2;
}

struct THREAD_NAME_INFORMATION
{
    UNICODE_STRING ThreadName;
}

struct SYSTEM_CODEINTEGRITY_INFORMATION
{
    uint Length;
    uint CodeIntegrityOptions;
}

struct PUBLIC_OBJECT_BASIC_INFORMATION
{
    uint     Attributes;
    uint     GrantedAccess;
    uint     HandleCount;
    uint     PointerCount;
    uint[10] Reserved;
}

struct PUBLIC_OBJECT_TYPE_INFORMATION
{
    UNICODE_STRING TypeName;
    uint[22]       Reserved;
}

struct WINSTATIONINFORMATIONW
{
    ubyte[70]   Reserved2;
    uint        LogonId;
    ubyte[1140] Reserved3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/ns-featurestagingapi-feature_error
struct FEATURE_ERROR
{
    HRESULT     hr;
    ushort      lineNumber;
    const(PSTR) file;
    const(PSTR) process;
    const(PSTR) module_;
    uint        callerReturnAddressOffset;
    const(PSTR) callerModule;
    const(PSTR) message;
    ushort      originLineNumber;
    const(PSTR) originFile;
    const(PSTR) originModule;
    uint        originCallerReturnAddressOffset;
    const(PSTR) originCallerModule;
    const(PSTR) originName;
}

struct DCICMD
{
    uint dwCommand;
    uint dwParam1;
    uint dwParam2;
    uint dwVersion;
    uint dwReserved;
}

struct DCICREATEINPUT
{
    DCICMD  cmd;
    uint    dwCompression;
    uint[3] dwMask;
    uint    dwWidth;
    uint    dwHeight;
    uint    dwDCICaps;
    uint    dwBitCount;
    void*   lpSurface;
}

struct DCISURFACEINFO
{
    uint      dwSize;
    uint      dwDCICaps;
    uint      dwCompression;
    uint[3]   dwMask;
    uint      dwWidth;
    uint      dwHeight;
    int       lStride;
    uint      dwBitCount;
    size_t    dwOffSurface;
    ushort    wSelSurface;
    ushort    wReserved;
    uint      dwReserved1;
    uint      dwReserved2;
    uint      dwReserved3;
    ptrdiff_t BeginAccess;
    ptrdiff_t EndAccess;
    ptrdiff_t DestroySurface;
}

struct DCIENUMINPUT
{
    DCICMD    cmd;
    RECT      rSrc;
    RECT      rDst;
    ptrdiff_t EnumCallback;
    void*     lpContext;
}

struct DCIOFFSCREEN
{
    DCISURFACEINFO dciInfo;
    ptrdiff_t      Draw;
    ptrdiff_t      SetClipList;
    ptrdiff_t      SetDestination;
}

struct DCIOVERLAY
{
    DCISURFACEINFO dciInfo;
    uint           dwChromakeyValue;
    uint           dwChromakeyMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/advpub/ns-advpub-strentrya
struct STRENTRYA
{
    PSTR pszName;
    PSTR pszValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/advpub/ns-advpub-strentryw
struct STRENTRYW
{
    PWSTR pszName;
    PWSTR pszValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/advpub/ns-advpub-strtablea
struct STRTABLEA
{
    uint       cEntries;
    STRENTRYA* pse;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/advpub/ns-advpub-strtablew
struct STRTABLEW
{
    uint       cEntries;
    STRENTRYW* pse;
}

struct CABINFOA
{
    PSTR      pszCab;
    PSTR      pszInf;
    PSTR      pszSection;
    CHAR[260] szSrcPath;
    uint      dwFlags;
}

struct CABINFOW
{
    PWSTR      pszCab;
    PWSTR      pszInf;
    PWSTR      pszSection;
    wchar[260] szSrcPath;
    uint       dwFlags;
}

struct PERUSERSECTIONA
{
    CHAR[59]   szGUID;
    CHAR[128]  szDispName;
    CHAR[10]   szLocale;
    CHAR[1040] szStub;
    CHAR[32]   szVersion;
    CHAR[128]  szCompID;
    uint       dwIsInstalled;
    BOOL       bRollback;
}

struct PERUSERSECTIONW
{
    wchar[59]   szGUID;
    wchar[128]  szDispName;
    wchar[10]   szLocale;
    wchar[1040] szStub;
    wchar[32]   szVersion;
    wchar[128]  szCompID;
    uint        dwIsInstalled;
    BOOL        bRollback;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ime/ns-ime-imestruct
struct IMESTRUCT
{
    uint   fnc;
    WPARAM wParam;
    uint   wCount;
    uint   dchSource;
    uint   dchDest;
    LPARAM lParam1;
    LPARAM lParam2;
    LPARAM lParam3;
}

struct UNDETERMINESTRUCT
{
    uint dwSize;
    uint uDefIMESize;
    uint uDefIMEPos;
    uint uUndetTextLen;
    uint uUndetTextPos;
    uint uUndetAttrPos;
    uint uCursorPos;
    uint uDeltaStart;
    uint uDetermineTextLen;
    uint uDetermineTextPos;
    uint uDetermineDelimPos;
    uint uYomiTextLen;
    uint uYomiTextPos;
    uint uYomiDelimPos;
}

struct STRINGEXSTRUCT
{
    uint dwSize;
    uint uDeterminePos;
    uint uDetermineDelimPos;
    uint uYomiPos;
    uint uYomiDelimPos;
}

struct DATETIME
{
    ushort year;
    ushort month;
    ushort day;
    ushort hour;
    ushort min;
    ushort sec;
}

struct IMEPROA
{
    HWND      hWnd;
    DATETIME  InstDate;
    uint      wVersion;
    ubyte[50] szDescription;
    ubyte[80] szName;
    ubyte[30] szOptions;
}

struct IMEPROW
{
    HWND      hWnd;
    DATETIME  InstDate;
    uint      wVersion;
    wchar[50] szDescription;
    wchar[80] szName;
    wchar[30] szOptions;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/capi/ns-capi-java_trust
struct JAVA_TRUST
{
    uint         cbSize;
    uint         flag;
    BOOL         fAllActiveXPermissions;
    BOOL         fAllPermissions;
    uint         dwEncodingType;
    ubyte*       pbJavaPermissions;
    uint         cbJavaPermissions;
    ubyte*       pbSigner;
    uint         cbSigner;
    const(PWSTR) pwszZone;
    GUID         guidZone;
    HRESULT      hVerify;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tdiinfo/ns-tdiinfo-tdientityid
struct TDIEntityID
{
    TDIENTITY_ENTITY_TYPE tei_entity;
    uint tei_instance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tdiinfo/ns-tdiinfo-tdiobjectid
struct TDIObjectID
{
    TDIEntityID toi_entity;
    uint        toi_class;
    uint        toi_type;
    uint        toi_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tdiinfo/ns-tdiinfo-tcp_request_query_information_ex_xp
struct TCP_REQUEST_QUERY_INFORMATION_EX_XP
{
    TDIObjectID ID;
    size_t[4]   Context;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tdiinfo/ns-tdiinfo-tcp_request_query_information_ex_w2k
struct TCP_REQUEST_QUERY_INFORMATION_EX_W2K
{
    TDIObjectID ID;
    ubyte[16]   Context;
}

struct TCP_REQUEST_SET_INFORMATION_EX
{
    TDIObjectID ID;
    uint        BufferSize;
    ubyte[1]    Buffer; // Flexible array
}

struct TDI_TL_IO_CONTROL_ENDPOINT
{
    TDI_TL_IO_CONTROL_TYPE Type;
    uint  Level;
    union
    {
        uint IoControlCode;
        uint OptionName;
    }
    void* InputBuffer;
    uint  InputBufferLength;
    void* OutputBuffer;
    uint  OutputBufferLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/ns-wldp-wldp_host_information
struct WLDP_HOST_INFORMATION
{
    uint         dwRevision;
    WLDP_HOST_ID dwHostId;
    const(PWSTR) szSource;
    HANDLE       hSource;
}

struct WLDP_DEVICE_SECURITY_INFORMATION
{
    uint   UnlockIdSize;
    ubyte* UnlockId;
    uint   ManufacturerIDLength;
    PWSTR  ManufacturerID;
}

struct DELAYLOAD_PROC_DESCRIPTOR
{
    uint ImportDescribedByName;
    union Description
    {
        const(PSTR) Name;
        uint        Ordinal;
    }
}

version(X86)
{
    struct DELAYLOAD_INFO
    {
        uint                Size;
        IMAGE_DELAYLOAD_DESCRIPTOR* DelayloadDescriptor;
        IMAGE_THUNK_DATA32* ThunkAddress;
        const(PSTR)         TargetDllName;
        DELAYLOAD_PROC_DESCRIPTOR TargetApiDescriptor;
        void*               TargetModuleBase;
        void*               Unused;
        uint                LastError;
    }
}

// Functions


version(X86_64)
{
    @DllImport("KERNEL32.dll")
int uaw_lstrcmpW(ushort* String1, ushort* String2);
}

version(AArch64)
{
    @DllImport("KERNEL32.dll")
int uaw_lstrcmpW(ushort* String1, ushort* String2);
}

version(X86_64)
{
    @DllImport("KERNEL32.dll")
int uaw_lstrcmpiW(ushort* String1, ushort* String2);
}

version(AArch64)
{
    @DllImport("KERNEL32.dll")
int uaw_lstrcmpiW(ushort* String1, ushort* String2);
}

version(X86_64)
{
    @DllImport("KERNEL32.dll")
int uaw_lstrlenW(ushort* String);
}

version(AArch64)
{
    @DllImport("KERNEL32.dll")
int uaw_lstrlenW(ushort* String);
}

version(X86_64)
{
    @DllImport("KERNEL32.dll")
ushort* uaw_wcschr(ushort* String, wchar Character);
}

version(AArch64)
{
    @DllImport("KERNEL32.dll")
ushort* uaw_wcschr(ushort* String, wchar Character);
}

version(X86_64)
{
    @DllImport("KERNEL32.dll")
ushort* uaw_wcscpy(ushort* Destination, ushort* Source);
}

version(AArch64)
{
    @DllImport("KERNEL32.dll")
ushort* uaw_wcscpy(ushort* Destination, ushort* Source);
}

version(X86_64)
{
    @DllImport("KERNEL32.dll")
int uaw_wcsicmp(ushort* String1, ushort* String2);
}

version(AArch64)
{
    @DllImport("KERNEL32.dll")
int uaw_wcsicmp(ushort* String1, ushort* String2);
}
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/stralign/nf-stralign-uaw_wcslen
@DllImport("KERNEL32.dll")
size_t uaw_wcslen(ushort* String);


version(X86_64)
{
    @DllImport("KERNEL32.dll")
ushort* uaw_wcsrchr(ushort* String, wchar Character);
}

version(AArch64)
{
    @DllImport("KERNEL32.dll")
ushort* uaw_wcsrchr(ushort* String, wchar Character);
}
@DllImport("ntdll.dll")
size_t RtlGetReturnAddressHijackTarget();

@DllImport("ntdll.dll")
uint RtlRaiseCustomSystemEventTrigger(CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG* TriggerConfig);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/apiquery2/nf-apiquery2-isapisetimplemented
@DllImport("api-ms-win-core-apiquery-l2-1-0.dll")
BOOL IsApiSetImplemented(const(PSTR) Contract);

@DllImport("api-ms-win-core-apiquery-l2-1-1.dll")
HRESULT GetApiSetModuleBaseName(const(PSTR) contractName, uint bufferLength, PWSTR moduleBaseName, 
                                uint* actualNameLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL QueryThreadCycleTime(HANDLE ThreadHandle, ulong* CycleTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL QueryProcessCycleTime(HANDLE ProcessHandle, ulong* CycleTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL QueryIdleProcessorCycleTime(uint* BufferLength, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ulong* ProcessorIdleCycleTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL QueryIdleProcessorCycleTimeEx(ushort Group, uint* BufferLength, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ulong* ProcessorIdleCycleTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-realtime-l1-1-1.dll")
void QueryInterruptTimePrecise(ulong* lpInterruptTimePrecise);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-realtime-l1-1-1.dll")
void QueryUnbiasedInterruptTimePrecise(ulong* lpUnbiasedInterruptTimePrecise);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-realtime-l1-1-1.dll")
void QueryInterruptTime(ulong* lpInterruptTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL QueryUnbiasedInterruptTime(ulong* UnbiasedTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("api-ms-win-core-realtime-l1-1-2.dll")
HRESULT QueryAuxiliaryCounterFrequency(ulong* lpAuxiliaryCounterFrequency);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("api-ms-win-core-realtime-l1-1-2.dll")
HRESULT ConvertAuxiliaryCounterToPerformanceCounter(ulong ullAuxiliaryCounterValue, 
                                                    ulong* lpPerformanceCounterValue, ulong* lpConversionError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("api-ms-win-core-realtime-l1-1-2.dll")
HRESULT ConvertPerformanceCounterToAuxiliaryCounter(ulong ullPerformanceCounterValue, 
                                                    ulong* lpAuxiliaryCounterValue, ulong* lpConversionError);

@DllImport("KERNEL32.dll")
size_t GlobalCompact(uint dwMinFree);

@DllImport("KERNEL32.dll")
void GlobalFix(HGLOBAL hMem);

@DllImport("KERNEL32.dll")
void GlobalUnfix(HGLOBAL hMem);

@DllImport("KERNEL32.dll")
void* GlobalWire(HGLOBAL hMem);

@DllImport("KERNEL32.dll")
BOOL GlobalUnWire(HGLOBAL hMem);

@DllImport("KERNEL32.dll")
size_t LocalShrink(HLOCAL hMem, uint cbNewSize);

@DllImport("KERNEL32.dll")
size_t LocalCompact(uint uMinFree);

@DllImport("KERNEL32.dll")
BOOL SetEnvironmentStringsA(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR NewEnvironment);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-sethandlecount
@DllImport("KERNEL32.dll")
uint SetHandleCount(uint uNumber);

@DllImport("KERNEL32.dll")
BOOL RequestDeviceWakeup(HANDLE hDevice);

@DllImport("KERNEL32.dll")
BOOL CancelDeviceWakeupRequest(HANDLE hDevice);

@DllImport("KERNEL32.dll")
BOOL SetMessageWaitingIndicator(HANDLE hMsgIndicator, uint ulMsgCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int MulDiv(int nNumber, int nNumerator, int nDenominator);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemRegistryQuota(uint* pdwQuotaAllowed, uint* pdwQuotaUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL FileTimeToDosDateTime(const(FILETIME)* lpFileTime, ushort* lpFatDate, ushort* lpFatTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL DosDateTimeToFileTime(ushort wFatDate, ushort wFatTime, FILETIME* lpFileTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-_lopen
@DllImport("KERNEL32.dll")
int _lopen(const(PSTR) lpPathName, int iReadWrite);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-_lcreat
@DllImport("KERNEL32.dll")
int _lcreat(const(PSTR) lpPathName, int iAttribute);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-_lread
@DllImport("KERNEL32.dll")
uint _lread(int hFile, 
            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
            uint uBytes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-_lwrite
@DllImport("KERNEL32.dll")
uint _lwrite(int hFile, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) lpBuffer, 
             uint uBytes);

@DllImport("KERNEL32.dll")
int _hread(int hFile, 
           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
           int lBytes);

@DllImport("KERNEL32.dll")
int _hwrite(int hFile, 
            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) lpBuffer, 
            int lBytes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-_lclose
@DllImport("KERNEL32.dll")
int _lclose(int hFile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-_llseek
@DllImport("KERNEL32.dll")
int _llseek(int hFile, int lOffset, int iOrigin);

@DllImport("KERNEL32.dll")
HANDLE OpenMutexA(uint dwDesiredAccess, BOOL bInheritHandle, const(PSTR) lpName);

@DllImport("KERNEL32.dll")
HANDLE OpenSemaphoreA(uint dwDesiredAccess, BOOL bInheritHandle, const(PSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableA(const(PSTR) lpName, const(PSTR) lpGuid, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                     uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableW(const(PWSTR) lpName, const(PWSTR) lpGuid, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                     uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableExA(const(PSTR) lpName, const(PSTR) lpGuid, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                       uint nSize, uint* pdwAttribubutes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
uint GetFirmwareEnvironmentVariableExW(const(PWSTR) lpName, const(PWSTR) lpGuid, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                       uint nSize, uint* pdwAttribubutes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableA(const(PSTR) lpName, const(PSTR) lpGuid, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pValue, 
                                     uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableW(const(PWSTR) lpName, const(PWSTR) lpGuid, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pValue, 
                                     uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableExA(const(PSTR) lpName, const(PSTR) lpGuid, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pValue, 
                                       uint nSize, uint dwAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetFirmwareEnvironmentVariableExW(const(PWSTR) lpName, const(PWSTR) lpGuid, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pValue, 
                                       uint nSize, uint dwAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL IsNativeVhdBoot(BOOL* NativeVhdBoot);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetProfileIntA(const(PSTR) lpAppName, const(PSTR) lpKeyName, int nDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetProfileIntW(const(PWSTR) lpAppName, const(PWSTR) lpKeyName, int nDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetProfileStringA(const(PSTR) lpAppName, const(PSTR) lpKeyName, const(PSTR) lpDefault, PSTR lpReturnedString, 
                       uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetProfileStringW(const(PWSTR) lpAppName, const(PWSTR) lpKeyName, const(PWSTR) lpDefault, 
                       PWSTR lpReturnedString, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WriteProfileStringA(const(PSTR) lpAppName, const(PSTR) lpKeyName, const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WriteProfileStringW(const(PWSTR) lpAppName, const(PWSTR) lpKeyName, const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetProfileSectionA(const(PSTR) lpAppName, PSTR lpReturnedString, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetProfileSectionW(const(PWSTR) lpAppName, PWSTR lpReturnedString, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WriteProfileSectionA(const(PSTR) lpAppName, const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WriteProfileSectionW(const(PWSTR) lpAppName, const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetPrivateProfileIntA(const(PSTR) lpAppName, const(PSTR) lpKeyName, int nDefault, const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetPrivateProfileIntW(const(PWSTR) lpAppName, const(PWSTR) lpKeyName, int nDefault, const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetPrivateProfileStringA(const(PSTR) lpAppName, const(PSTR) lpKeyName, const(PSTR) lpDefault, 
                              PSTR lpReturnedString, uint nSize, const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetPrivateProfileStringW(const(PWSTR) lpAppName, const(PWSTR) lpKeyName, const(PWSTR) lpDefault, 
                              PWSTR lpReturnedString, uint nSize, const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStringA(const(PSTR) lpAppName, const(PSTR) lpKeyName, const(PSTR) lpString, 
                                const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStringW(const(PWSTR) lpAppName, const(PWSTR) lpKeyName, const(PWSTR) lpString, 
                                const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionA(const(PSTR) lpAppName, PSTR lpReturnedString, uint nSize, const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionW(const(PWSTR) lpAppName, PWSTR lpReturnedString, uint nSize, const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileSectionA(const(PSTR) lpAppName, const(PSTR) lpString, const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileSectionW(const(PWSTR) lpAppName, const(PWSTR) lpString, const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionNamesA(PSTR lpszReturnBuffer, uint nSize, const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetPrivateProfileSectionNamesW(PWSTR lpszReturnBuffer, uint nSize, const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetPrivateProfileStructA(const(PSTR) lpszSection, const(PSTR) lpszKey, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpStruct, 
                              uint uSizeStruct, const(PSTR) szFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetPrivateProfileStructW(const(PWSTR) lpszSection, const(PWSTR) lpszKey, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpStruct, 
                              uint uSizeStruct, const(PWSTR) szFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStructA(const(PSTR) lpszSection, const(PSTR) lpszKey, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpStruct, 
                                uint uSizeStruct, const(PSTR) szFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WritePrivateProfileStructW(const(PWSTR) lpszSection, const(PWSTR) lpszKey, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpStruct, 
                                uint uSizeStruct, const(PWSTR) szFile);

@DllImport("KERNEL32.dll")
BOOL IsBadHugeReadPtr(const(void)* lp, size_t ucb);

@DllImport("KERNEL32.dll")
BOOL IsBadHugeWritePtr(void* lp, size_t ucb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetComputerNameA(PSTR lpBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetComputerNameW(PWSTR lpBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL DnsHostnameToComputerNameA(const(PSTR) Hostname, PSTR ComputerName, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL DnsHostnameToComputerNameW(const(PWSTR) Hostname, PWSTR ComputerName, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL GetUserNameA(PSTR lpBuffer, uint* pcbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL GetUserNameW(PWSTR lpBuffer, uint* pcbBuffer);

@DllImport("ADVAPI32.dll")
BOOL IsTokenUntrusted(HANDLE TokenHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL GetCurrentHwProfileA(HW_PROFILE_INFOA* lpHwProfileInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL GetCurrentHwProfileW(HW_PROFILE_INFOW* lpHwProfileInfo);

@DllImport("KERNEL32.dll")
BOOL ReplacePartitionUnit(PWSTR TargetPartition, PWSTR SparePartition, uint Flags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-getthreadenabledxstatefeatures
@DllImport("KERNEL32.dll")
ulong GetThreadEnabledXStateFeatures();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-enableprocessoptionalxstatefeatures
@DllImport("KERNEL32.dll")
BOOL EnableProcessOptionalXStateFeatures(ulong Features);

@DllImport("api-ms-win-core-backgroundtask-l1-1-0.dll")
uint RaiseCustomSystemEventTrigger(CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG* CustomSystemEventTriggerConfig);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winternl/nf-winternl-rtlisnamelegaldos8dot3
@DllImport("ntdll.dll")
BOOLEAN RtlIsNameLegalDOS8Dot3(UNICODE_STRING* Name, STRING* OemName, BOOLEAN* NameContainsSpaces);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winternl/nf-winternl-rtllocaltimetosystemtime
@DllImport("ntdll.dll")
NTSTATUS RtlLocalTimeToSystemTime(long* LocalTime, long* SystemTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winternl/nf-winternl-rtltimetosecondssince1970
@DllImport("ntdll.dll")
BOOLEAN RtlTimeToSecondsSince1970(long* Time, uint* ElapsedSeconds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
void RtlFreeAnsiString(STRING* AnsiString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
void RtlFreeUnicodeString(UNICODE_STRING* UnicodeString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
void RtlFreeOemString(STRING* OemString);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winternl/nf-winternl-rtlinitstring
@DllImport("ntdll.dll")
void RtlInitString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll.dll")
NTSTATUS RtlInitStringEx(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll.dll")
void RtlInitAnsiString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll.dll")
NTSTATUS RtlInitAnsiStringEx(STRING* DestinationString, byte* SourceString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
void RtlInitUnicodeString(UNICODE_STRING* DestinationString, const(PWSTR) SourceString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
NTSTATUS RtlAnsiStringToUnicodeString(UNICODE_STRING* DestinationString, STRING* SourceString, 
                                      BOOLEAN AllocateDestinationString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
NTSTATUS RtlUnicodeStringToAnsiString(STRING* DestinationString, UNICODE_STRING* SourceString, 
                                      BOOLEAN AllocateDestinationString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
NTSTATUS RtlUnicodeStringToOemString(STRING* DestinationString, UNICODE_STRING* SourceString, 
                                     BOOLEAN AllocateDestinationString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
NTSTATUS RtlUnicodeToMultiByteSize(uint* BytesInMultiByteString, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR UnicodeString, 
                                   uint BytesInUnicodeString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ntdll.dll")
NTSTATUS RtlCharToInteger(byte* String, uint Base, uint* Value);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winternl/nf-winternl-rtluniform
@DllImport("ntdll.dll")
uint RtlUniform(uint* Seed);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/nf-featurestagingapi-getfeatureenabledstate
@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
FEATURE_ENABLED_STATE GetFeatureEnabledState(uint featureId, FEATURE_CHANGE_TIME changeTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/nf-featurestagingapi-recordfeatureusage
@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void RecordFeatureUsage(uint featureId, uint kind, uint addend, const(PSTR) originName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/nf-featurestagingapi-recordfeatureerror
@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void RecordFeatureError(uint featureId, const(FEATURE_ERROR)* error);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/nf-featurestagingapi-subscribefeaturestatechangenotification
@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void SubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION* subscription, 
                                             PFEATURE_STATE_CHANGE_CALLBACK callback, void* context);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/nf-featurestagingapi-unsubscribefeaturestatechangenotification
@DllImport("api-ms-win-core-featurestaging-l1-1-0.dll")
void UnsubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION subscription);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/featurestagingapi/nf-featurestagingapi-getfeaturevariant
@DllImport("api-ms-win-core-featurestaging-l1-1-1.dll")
uint GetFeatureVariant(uint featureId, FEATURE_CHANGE_TIME changeTime, uint* payloadId, BOOL* hasNotification);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DCIMAN32.dll")
HDC DCIOpenProvider();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DCIMAN32.dll")
void DCICloseProvider(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DCIMAN32.dll")
int DCICreatePrimary(HDC hdc, DCISURFACEINFO** lplpSurface);

@DllImport("DCIMAN32.dll")
int DCICreateOffscreen(HDC hdc, uint dwCompression, uint dwRedMask, uint dwGreenMask, uint dwBlueMask, 
                       uint dwWidth, uint dwHeight, uint dwDCICaps, uint dwBitCount, DCIOFFSCREEN** lplpSurface);

@DllImport("DCIMAN32.dll")
int DCICreateOverlay(HDC hdc, void* lpOffscreenSurf, DCIOVERLAY** lplpSurface);

@DllImport("DCIMAN32.dll")
int DCIEnum(HDC hdc, RECT* lprDst, RECT* lprSrc, void* lpFnCallback, void* lpContext);

@DllImport("DCIMAN32.dll")
int DCISetSrcDestClip(DCIOFFSCREEN* pdci, RECT* srcrc, RECT* destrc, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
HWINWATCH WinWatchOpen(HWND hwnd);

@DllImport("DCIMAN32.dll")
void WinWatchClose(HWINWATCH hWW);

@DllImport("DCIMAN32.dll")
uint WinWatchGetClipList(HWINWATCH hWW, RECT* prc, uint size, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
BOOL WinWatchDidStatusChange(HWINWATCH hWW);

@DllImport("DCIMAN32.dll")
uint GetWindowRegionData(HWND hwnd, uint size, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
uint GetDCRegionData(HDC hdc, uint size, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
BOOL WinWatchNotify(HWINWATCH hWW, WINWATCHNOTIFYPROC NotifyCallback, LPARAM NotifyParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DCIMAN32.dll")
void DCIEndAccess(DCISURFACEINFO* pdci);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DCIMAN32.dll")
int DCIBeginAccess(DCISURFACEINFO* pdci, int x, int y, int dx, int dy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("DCIMAN32.dll")
void DCIDestroy(DCISURFACEINFO* pdci);

@DllImport("DCIMAN32.dll")
int DCIDraw(DCIOFFSCREEN* pdci);

@DllImport("DCIMAN32.dll")
int DCISetClipList(DCIOFFSCREEN* pdci, RGNDATA* prd);

@DllImport("DCIMAN32.dll")
int DCISetDestination(DCIOFFSCREEN* pdci, RECT* dst, RECT* src);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddrawgdi/nf-ddrawgdi-ddquerydisplaysettingsuniqueness
@DllImport("api-ms-win-dx-d3dkmt-l1-1-0.dll")
uint GdiEntry13();

@DllImport("ADVPACK.dll")
HRESULT RunSetupCommandA(HWND hWnd, const(PSTR) szCmdName, const(PSTR) szInfSection, const(PSTR) szDir, 
                         const(PSTR) lpszTitle, HANDLE* phEXE, uint dwFlags, void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT RunSetupCommandW(HWND hWnd, const(PWSTR) szCmdName, const(PWSTR) szInfSection, const(PWSTR) szDir, 
                         const(PWSTR) lpszTitle, HANDLE* phEXE, uint dwFlags, void* pvReserved);

@DllImport("ADVPACK.dll")
uint NeedRebootInit();

@DllImport("ADVPACK.dll")
BOOL NeedReboot(uint dwRebootCheck);

@DllImport("ADVPACK.dll")
HRESULT RebootCheckOnInstallA(HWND hwnd, const(PSTR) pszINF, const(PSTR) pszSec, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT RebootCheckOnInstallW(HWND hwnd, const(PWSTR) pszINF, const(PWSTR) pszSec, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringA(const(PSTR) pszInfFilename, const(PSTR) pszInstallSection, 
                            const(PSTR) pszTranslateSection, const(PSTR) pszTranslateKey, PSTR pszBuffer, 
                            uint cchBuffer, uint* pdwRequiredSize, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringW(const(PWSTR) pszInfFilename, const(PWSTR) pszInstallSection, 
                            const(PWSTR) pszTranslateSection, const(PWSTR) pszTranslateKey, PWSTR pszBuffer, 
                            uint cchBuffer, uint* pdwRequiredSize, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("ADVPACK.dll")
HRESULT RegInstallA(HMODULE hmod, const(PSTR) pszSection, const(STRTABLEA)* pstTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("ADVPACK.dll")
HRESULT RegInstallW(HMODULE hmod, const(PWSTR) pszSection, const(STRTABLEW)* pstTable);

@DllImport("ADVPACK.dll")
HRESULT LaunchINFSectionExW(HWND hwnd, HINSTANCE hInstance, PWSTR pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT ExecuteCabA(HWND hwnd, CABINFOA* pCab, void* pReserved);

@DllImport("ADVPACK.dll")
HRESULT ExecuteCabW(HWND hwnd, CABINFOW* pCab, void* pReserved);

@DllImport("ADVPACK.dll")
HRESULT AdvInstallFileA(HWND hwnd, const(PSTR) lpszSourceDir, const(PSTR) lpszSourceFile, const(PSTR) lpszDestDir, 
                        const(PSTR) lpszDestFile, uint dwFlags, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT AdvInstallFileW(HWND hwnd, const(PWSTR) lpszSourceDir, const(PWSTR) lpszSourceFile, 
                        const(PWSTR) lpszDestDir, const(PWSTR) lpszDestFile, uint dwFlags, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreA(HWND hWnd, const(PSTR) pszTitleString, HKEY hkBckupKey, const(PSTR) pcszRootKey, 
                        const(PSTR) pcszSubKey, const(PSTR) pcszValueName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreW(HWND hWnd, const(PWSTR) pszTitleString, HKEY hkBckupKey, const(PWSTR) pcszRootKey, 
                        const(PWSTR) pcszSubKey, const(PWSTR) pcszValueName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreOnINFA(HWND hWnd, const(PSTR) pszTitle, const(PSTR) pszINF, const(PSTR) pszSection, 
                             HKEY hHKLMBackKey, HKEY hHKCUBackKey, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegSaveRestoreOnINFW(HWND hWnd, const(PWSTR) pszTitle, const(PWSTR) pszINF, const(PWSTR) pszSection, 
                             HKEY hHKLMBackKey, HKEY hHKCUBackKey, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT RegRestoreAllA(HWND hWnd, const(PSTR) pszTitleString, HKEY hkBckupKey);

@DllImport("ADVPACK.dll")
HRESULT RegRestoreAllW(HWND hWnd, const(PWSTR) pszTitleString, HKEY hkBckupKey);

@DllImport("ADVPACK.dll")
HRESULT FileSaveRestoreW(HWND hDlg, PWSTR lpFileList, const(PWSTR) lpDir, const(PWSTR) lpBaseName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT FileSaveRestoreOnINFA(HWND hWnd, const(PSTR) pszTitle, const(PSTR) pszINF, const(PSTR) pszSection, 
                              const(PSTR) pszBackupDir, const(PSTR) pszBaseBackupFile, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT FileSaveRestoreOnINFW(HWND hWnd, const(PWSTR) pszTitle, const(PWSTR) pszINF, const(PWSTR) pszSection, 
                              const(PWSTR) pszBackupDir, const(PWSTR) pszBaseBackupFile, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT AddDelBackupEntryA(const(PSTR) lpcszFileList, const(PSTR) lpcszBackupDir, const(PSTR) lpcszBaseName, 
                           uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT AddDelBackupEntryW(const(PWSTR) lpcszFileList, const(PWSTR) lpcszBackupDir, const(PWSTR) lpcszBaseName, 
                           uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT FileSaveMarkNotExistA(const(PSTR) lpFileList, const(PSTR) lpDir, const(PSTR) lpBaseName);

@DllImport("ADVPACK.dll")
HRESULT FileSaveMarkNotExistW(const(PWSTR) lpFileList, const(PWSTR) lpDir, const(PWSTR) lpBaseName);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileA(const(PSTR) lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileW(const(PWSTR) lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileExA(const(PSTR) lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
HRESULT GetVersionFromFileExW(const(PWSTR) lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK.dll")
BOOL IsNTAdmin(uint dwReserved, uint* lpdwReserved);

@DllImport("ADVPACK.dll")
HRESULT DelNodeA(const(PSTR) pszFileOrDirName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT DelNodeW(const(PWSTR) pszFileOrDirName, uint dwFlags);

@DllImport("ADVPACK.dll")
HRESULT DelNodeRunDLL32W(HWND hwnd, HINSTANCE hInstance, PWSTR pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT OpenINFEngineA(const(PSTR) pszInfFilename, const(PSTR) pszInstallSection, uint dwFlags, void** phInf, 
                       void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT OpenINFEngineW(const(PWSTR) pszInfFilename, const(PWSTR) pszInstallSection, uint dwFlags, void** phInf, 
                       void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringExA(void* hInf, const(PSTR) pszInfFilename, const(PSTR) pszTranslateSection, 
                              const(PSTR) pszTranslateKey, PSTR pszBuffer, uint dwBufferSize, uint* pdwRequiredSize, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT TranslateInfStringExW(void* hInf, const(PWSTR) pszInfFilename, const(PWSTR) pszTranslateSection, 
                              const(PWSTR) pszTranslateKey, PWSTR pszBuffer, uint dwBufferSize, 
                              uint* pdwRequiredSize, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

@DllImport("ADVPACK.dll")
HRESULT CloseINFEngine(void* hInf);

@DllImport("ADVPACK.dll")
HRESULT ExtractFilesA(const(PSTR) pszCabName, const(PSTR) pszExpandDir, uint dwFlags, const(PSTR) pszFileList, 
                      void* lpReserved, uint dwReserved);

@DllImport("ADVPACK.dll")
HRESULT ExtractFilesW(const(PWSTR) pszCabName, const(PWSTR) pszExpandDir, uint dwFlags, const(PWSTR) pszFileList, 
                      void* lpReserved, uint dwReserved);

@DllImport("ADVPACK.dll")
int LaunchINFSectionW(HWND hwndOwner, HINSTANCE hInstance, PWSTR pszParams, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserInstStubWrapperA(HWND hwnd, HINSTANCE hInstance, const(PSTR) pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserInstStubWrapperW(HWND hwnd, HINSTANCE hInstance, const(PWSTR) pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserUnInstStubWrapperA(HWND hwnd, HINSTANCE hInstance, const(PSTR) pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT UserUnInstStubWrapperW(HWND hwnd, HINSTANCE hInstance, const(PWSTR) pszParms, int nShow);

@DllImport("ADVPACK.dll")
HRESULT SetPerUserSecValuesA(PERUSERSECTIONA* pPerUser);

@DllImport("ADVPACK.dll")
HRESULT SetPerUserSecValuesW(PERUSERSECTIONW* pPerUser);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
LRESULT SendIMEMessageExA(HWND param0, LPARAM param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
LRESULT SendIMEMessageExW(HWND param0, LPARAM param1);

@DllImport("USER32.dll")
BOOL IMPGetIMEA(HWND param0, IMEPROA* param1);

@DllImport("USER32.dll")
BOOL IMPGetIMEW(HWND param0, IMEPROW* param1);

@DllImport("USER32.dll")
BOOL IMPQueryIMEA(IMEPROA* param0);

@DllImport("USER32.dll")
BOOL IMPQueryIMEW(IMEPROW* param0);

@DllImport("USER32.dll")
BOOL IMPSetIMEA(HWND param0, IMEPROA* param1);

@DllImport("USER32.dll")
BOOL IMPSetIMEW(HWND param0, IMEPROW* param1);

@DllImport("USER32.dll")
uint WINNLSGetIMEHotkey(HWND param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL WINNLSEnableIME(HWND param0, BOOL param1);

@DllImport("USER32.dll")
BOOL WINNLSGetEnableStatus(HWND param0);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appcompatapi/nf-appcompatapi-apphelpcheckshellobject
@DllImport("APPHELP.dll")
BOOL ApphelpCheckShellObject(const(GUID)* ObjectCLSID, BOOL bShimIfNecessary, ulong* pullFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpgetlockdownpolicy
@DllImport("Wldp.dll")
HRESULT WldpGetLockdownPolicy(WLDP_HOST_INFORMATION* hostInformation, uint* lockdownState, uint lockdownFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpisclassinapprovedlist
@DllImport("Wldp.dll")
HRESULT WldpIsClassInApprovedList(const(GUID)* classID, WLDP_HOST_INFORMATION* hostInformation, BOOL* isApproved, 
                                  uint optionalFlags);

@DllImport("Wldp.dll")
HRESULT WldpQuerySecurityPolicy(const(UNICODE_STRING)* providerName, const(UNICODE_STRING)* keyName, 
                                const(UNICODE_STRING)* valueName, WLDP_SECURE_SETTING_VALUE_TYPE* valueType, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* valueAddress, 
                                uint* valueSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpsetdynamiccodetrust
@DllImport("Wldp.dll")
HRESULT WldpSetDynamicCodeTrust(HANDLE fileHandle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpisdynamiccodepolicyenabled
@DllImport("Wldp.dll")
HRESULT WldpIsDynamicCodePolicyEnabled(BOOL* isEnabled);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpquerydynamiccodetrust
@DllImport("Wldp.dll")
HRESULT WldpQueryDynamicCodeTrust(HANDLE fileHandle, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* baseImage, 
                                  uint imageSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpquerywindowslockdownmode
@DllImport("Wldp.dll")
HRESULT WldpQueryWindowsLockdownMode(WLDP_WINDOWS_LOCKDOWN_MODE* lockdownMode);

@DllImport("Wldp.dll")
HRESULT WldpQueryDeviceSecurityInformation(WLDP_DEVICE_SECURITY_INFORMATION* information, uint informationLength, 
                                           uint* returnLength);

@DllImport("Wldp.dll")
HRESULT WldpQueryWindowsLockdownRestriction(WLDP_WINDOWS_LOCKDOWN_RESTRICTION* LockdownRestriction);

@DllImport("Wldp.dll")
HRESULT WldpSetWindowsLockdownRestriction(WLDP_WINDOWS_LOCKDOWN_RESTRICTION LockdownRestriction);

@DllImport("Wldp.dll")
HRESULT WldpIsAppApprovedByPolicy(const(PWSTR) PackageFamilyName, ulong PackageVersion);

@DllImport("Wldp.dll")
HRESULT WldpQueryPolicySettingEnabled(WLDP_POLICY_SETTING Setting, BOOL* Enabled);

@DllImport("Wldp.dll")
HRESULT WldpQueryPolicySettingEnabled2(const(PWSTR) SettingString, BOOL* Enabled);

@DllImport("Wldp.dll")
HRESULT WldpIsWcosProductionConfiguration(BOOL* IsProductionConfiguration);

@DllImport("Wldp.dll")
HRESULT WldpResetWcosProductionConfiguration();

@DllImport("Wldp.dll")
HRESULT WldpIsProductionConfiguration(BOOL* IsProductionConfiguration);

@DllImport("Wldp.dll")
HRESULT WldpResetProductionConfiguration();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpcanexecutefile
@DllImport("Wldp.dll")
HRESULT WldpCanExecuteFile(const(GUID)* host, WLDP_EXECUTION_EVALUATION_OPTIONS options, HANDLE fileHandle, 
                           const(PWSTR) auditInfo, WLDP_EXECUTION_POLICY* result);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpcanexecutebuffer
@DllImport("Wldp.dll")
HRESULT WldpCanExecuteBuffer(const(GUID)* host, WLDP_EXECUTION_EVALUATION_OPTIONS options, const(ubyte)* buffer, 
                             uint bufferSize, const(PWSTR) auditInfo, WLDP_EXECUTION_POLICY* result);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wldp/nf-wldp-wldpcanexecutestream
@DllImport("Wldp.dll")
HRESULT WldpCanExecuteStream(const(GUID)* host, WLDP_EXECUTION_EVALUATION_OPTIONS options, IStream stream, 
                             const(PWSTR) auditInfo, WLDP_EXECUTION_POLICY* result);

@DllImport("Wldp.dll")
HRESULT WldpCanExecuteFileFromDetachedSignature(const(GUID)* host, WLDP_EXECUTION_EVALUATION_OPTIONS options, 
                                                HANDLE contentFileHandle, HANDLE signatureFileHandle, 
                                                const(PWSTR) auditInfo, WLDP_EXECUTION_POLICY* result);

@DllImport("Wldp.dll")
HRESULT WldpGetApplicationSettingBoolean(const(PWSTR) id, const(PWSTR) setting, BOOL* result);

@DllImport("Wldp.dll")
HRESULT WldpGetApplicationSettingStringList(const(PWSTR) id, const(PWSTR) setting, size_t dataCount, 
                                            size_t* requiredCount, 
                                            /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR result);

@DllImport("Wldp.dll")
HRESULT WldpGetApplicationSettingStringSet(const(PWSTR) id, const(PWSTR) setting, size_t dataCount, 
                                           size_t* requiredCount, 
                                           /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR result);


// Interfaces

@GUID("16d5a2be-b1c5-47b3-8eae-ccbcf452c7e8")
struct CameraUIControl;

@GUID("01776df3-b9af-4e50-9b1c-56e93116d704")
struct EditionUpgradeHelper;

@GUID("c4270827-4f39-45df-9288-12ff6b85a921")
struct EditionUpgradeBroker;

@GUID("3ac83423-3112-4aa6-9b5b-1feb23d0c5f9")
struct DefaultBrowserSyncSettings;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nn-camerauicontrol-icamerauicontroleventcallback
@GUID("1bfa0c2c-fbcd-4776-bda4-88bf974e74f4")
interface ICameraUIControlEventCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontroleventcallback-onstartupcomplete
    void OnStartupComplete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontroleventcallback-onsuspendcomplete
    void OnSuspendComplete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontroleventcallback-onitemcaptured
    void OnItemCaptured(const(PWSTR) pszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontroleventcallback-onitemdeleted
    void OnItemDeleted(const(PWSTR) pszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontroleventcallback-onclosed
    void OnClosed();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nn-camerauicontrol-icamerauicontrol
@GUID("b8733adf-3d68-4b8f-bb08-e28a0bed0376")
interface ICameraUIControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-show
    HRESULT Show(IUnknown pWindow, CameraUIControlMode mode, CameraUIControlLinearSelectionMode selectionMode, 
                 CameraUIControlCaptureMode captureMode, CameraUIControlPhotoFormat photoFormat, 
                 CameraUIControlVideoFormat videoFormat, BOOL bHasCloseButton, 
                 ICameraUIControlEventCallback pEventCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-suspend
    HRESULT Suspend(BOOL* pbDeferralRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-getcurrentviewtype
    HRESULT GetCurrentViewType(CameraUIControlViewType* pViewType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-getactiveitem
    HRESULT GetActiveItem(BSTR* pbstrActiveItemPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-getselecteditems
    HRESULT GetSelectedItems(SAFEARRAY** ppSelectedItemPaths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/camerauicontrol/nf-camerauicontrol-icamerauicontrol-removecaptureditem
    HRESULT RemoveCapturedItem(const(PWSTR) pszPath);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/editionupgradehelper/nn-editionupgradehelper-ieditionupgradehelper
@GUID("d3e9e342-5deb-43b6-849e-6913b85d503a")
interface IEditionUpgradeHelper : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/editionupgradehelper/nf-editionupgradehelper-ieditionupgradehelper-canupgrade
    HRESULT CanUpgrade(BOOL* isAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/editionupgradehelper/nf-editionupgradehelper-ieditionupgradehelper-updateoperatingsystem
    HRESULT UpdateOperatingSystem(const(PWSTR) contentId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/editionupgradehelper/nf-editionupgradehelper-ieditionupgradehelper-showproductkeyui
    HRESULT ShowProductKeyUI();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/editionupgradehelper/nf-editionupgradehelper-ieditionupgradehelper-getosproductcontentid
    HRESULT GetOsProductContentId(PWSTR* contentId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/editionupgradehelper/nf-editionupgradehelper-ieditionupgradehelper-getgenuinelocalstatus
    HRESULT GetGenuineLocalStatus(BOOL* isGenuine);
}

@GUID("f342d19e-cc22-4648-bb5d-03ccf75b47c5")
interface IWindowsLockModeHelper : IUnknown
{
    HRESULT GetSMode(BOOL* isSmode);
}

@GUID("ff19cbcf-9455-4937-b872-6b7929a460af")
interface IEditionUpgradeBroker : IUnknown
{
    HRESULT InitializeParentWindow(OLE_HANDLE parentHandle);
    HRESULT UpdateOperatingSystem(BSTR parameter);
    HRESULT ShowProductKeyUI();
    HRESULT CanUpgrade();
}

@GUID("b524f93f-80d5-4ec7-ae9e-d66e93ade1fa")
interface IContainerActivationHelper : IUnknown
{
    HRESULT CanActivateClientVM(VARIANT_BOOL* isAllowed);
}

@GUID("c39948f0-6142-44fd-98ca-e1681a8d68b5")
interface IClipServiceNotificationHelper : IUnknown
{
    HRESULT ShowToast(BSTR titleText, BSTR bodyText, BSTR packageName, BSTR appId, BSTR launchCommand);
}

@GUID("3d5e3d21-bd41-4c2a-a669-b17ce87fb50b")
interface IFClipNotificationHelper : IUnknown
{
    HRESULT ShowSystemDialog(BSTR titleText, BSTR bodyText);
}

@GUID("7a27faad-5ae6-4255-9030-c530936292e3")
interface IDefaultBrowserSyncSettings : IUnknown
{
    BOOL IsEnabled();
}

@GUID("cf38ed4b-2be7-4461-8b5e-9a466dc82ae3")
interface IDeleteBrowsingHistory : IUnknown
{
    HRESULT DeleteBrowsingHistory(uint dwFlags);
}


// GUIDs

const GUID CLSID_CameraUIControl            = GUIDOF!CameraUIControl;
const GUID CLSID_DefaultBrowserSyncSettings = GUIDOF!DefaultBrowserSyncSettings;
const GUID CLSID_EditionUpgradeBroker       = GUIDOF!EditionUpgradeBroker;
const GUID CLSID_EditionUpgradeHelper       = GUIDOF!EditionUpgradeHelper;

const GUID IID_ICameraUIControl               = GUIDOF!ICameraUIControl;
const GUID IID_ICameraUIControlEventCallback  = GUIDOF!ICameraUIControlEventCallback;
const GUID IID_IClipServiceNotificationHelper = GUIDOF!IClipServiceNotificationHelper;
const GUID IID_IContainerActivationHelper     = GUIDOF!IContainerActivationHelper;
const GUID IID_IDefaultBrowserSyncSettings    = GUIDOF!IDefaultBrowserSyncSettings;
const GUID IID_IDeleteBrowsingHistory         = GUIDOF!IDeleteBrowsingHistory;
const GUID IID_IEditionUpgradeBroker          = GUIDOF!IEditionUpgradeBroker;
const GUID IID_IEditionUpgradeHelper          = GUIDOF!IEditionUpgradeHelper;
const GUID IID_IFClipNotificationHelper       = GUIDOF!IFClipNotificationHelper;
const GUID IID_IWindowsLockModeHelper         = GUIDOF!IWindowsLockModeHelper;
